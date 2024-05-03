.include "cpctelera.h.s"
.include "sys/camera.h.s"
.include "sys/render.h.s"
.include "man/entity.h.s"

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

camera::
    .dw _tilemap_00    ;; Tilemap camera pointer
    .db 0, 0           ;; Camera (x, y) coordinates
    .db 0, 0           ;; Camera Target Screen Coords
    .db 0              ;; Camera Scroll State

camera_system_init::
    ;; initialize the camera
    ld hl, #_tilemap_00
    ld (camera + camera_ptr), hl
    ld a, #0
    ld (camera + camera_x), a
    ld (camera + camera_y), a
    ld (camera + camera_tx), a
    ld (camera + camera_ty), a
    ld (camera + camera_scroll), a
    ret

scroll_left:
    ld hl, (camera + camera_ptr)
    ld bc, #-1
    add hl, bc
    ld (camera + camera_ptr), hl
    ld a, (camera + camera_x)
    add #-4
    ld (camera + camera_x), a

    ld hl, #(camera + camera_scroll)
    inc (hl)

    ret

scroll_right:
    ld hl, (camera + camera_ptr)
    ld bc, #1
    add hl, bc
    ld (camera + camera_ptr), hl
    ld a, (camera + camera_x)
    add #4
    ld (camera + camera_x), a

    ld hl, #(camera + camera_scroll)
    dec (hl)

    ret

start_scroll_left:
    ;; check if we can scroll
    ld a, (camera + camera_x)
    cp #0
    ret z
    ld a, #-8
    ld (camera + camera_scroll), a
    ret


start_scroll_right:
    ;; check if we can scroll
    ld a, (camera + camera_x)
    cp #(32*4)
    ret z

    ld a, #8
    ld (camera + camera_scroll), a
    ret


camera_system_scroll:
    ;; Do scroll when in scroll state
    ld a, (camera + camera_scroll)
    bit 7, a
    jr nz, scroll_left
    or a
    jr nz, scroll_right

    ;; the camera can scroll
    ld a, (camera + camera_tx)
    cp #48
    jp nc, start_scroll_right    
    cp #16
    jp c, start_scroll_left

    ret



camera_system_update_one_entity:
    ;; ent_sx = ent_x - camera_x
    ld a, (camera + camera_x)
    ld b, a
    ld a, ent_x(ix)
    sub b
    ld ent_sx(ix), a
    ;; ent_sy = ent_y - camera_y
    ld a, (camera + camera_y)
    ld b, a
    ld a, ent_y(ix)
    sub b
    ld ent_sy(ix), a

    ret


camera_system_update::

    call camera_system_scroll

    ld a, #(ent_mask_alive|ent_mask_render)
    ld hl, #camera_system_update_one_entity
    call entity_manager_forall

    ret