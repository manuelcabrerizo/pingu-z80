.include "cpctelera.h.s"
.include "sys/camera.h.s"
.include "sys/render.h.s"
.include "man/entity.h.s"

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

camera::
    .dw _tilemap_00    ;; Tilemap camera pointer
    .db 0, 0           ;; Camera (x, y) coordinates


camera_system_init::
    ;; initialize the camera
    ld hl, #_tilemap_00
    ld (camera + camera_ptr), hl
    ld a, #0
    ld (camera + camera_x), a
    ld (camera + camera_y), a

    ret

scroll_left:
    ld hl, (camera + camera_ptr)
    dec hl
    ld (camera + camera_ptr), hl
    ld a, (camera + camera_x)
    sub #4
    ld (camera + camera_x), a
    ret

scroll_right:
    ld hl, (camera + camera_ptr)
    inc hl
    ld (camera + camera_ptr), hl
    ld a, (camera + camera_x)
    add #4
    ld (camera + camera_x), a
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

   ;; Scroll Left
    ld hl, #Key_E
    call cpct_isKeyPressed_asm
    jr z, e_not_press

    ld a, (camera + camera_x)
    cp #0
    jr z, e_not_press

    call scroll_left

e_not_press:
    ;; Scroll Right
    ld hl, #Key_R
    call cpct_isKeyPressed_asm
    jr z, r_not_press

    ld a, (camera + camera_x)
    cp #(32*2)
    jr z, r_not_press

    call scroll_right

r_not_press:

    ld a, #(ent_mask_alive|ent_mask_render)
    ld hl, #camera_system_update_one_entity
    call entity_manager_forall

    ret