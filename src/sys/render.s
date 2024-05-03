.include "cpctelera.h.s"
.include "cpct/cpct32x16.h.s"
.include "man/entity.h.s"
.include "sys/camera.h.s"

.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm
.globl _pre_palette

.globl _tile_tilemap_00



; D = Registro
; E = Valor
set_crtc:
   ld bc, #0xBC00
   out (c), d
   inc b
   out (c), e
   ret


render_system_init::
    ;; Setup the display 
    ld de, #0x0120
    call set_crtc

    ld de, #0x022A
    call set_crtc

    ld de, #0x0610
    call set_crtc

    ld de, #0x071A
    call set_crtc

    cpctm_setBorder_asm HW_WHITE
    ld c, #0
    call cpct_setVideoMode_asm

    ld hl, #_pre_palette
    ld de, #16
    call cpct_setPalette_asm

    ret



render_system_render_one_entity:

    ;; check if an entity is inside the camera
    ld a, ent_w(ix)
    ld b, a
    dec b
    ld a, #64
    sub b
    ld b, a
    
    ld a, ent_sx(ix)
    cp b
    ret nc

back_buffer_0 = . + 2
    ld   de, #0xC400 ;; DE = Pointer to start of the screen
    ld    b, ent_sy(ix)            ;; B = y coordinate (24 = 0x18)
    ld    c, ent_sx(ix)            ;; C = x coordinate (16 = 0x10)
    call getScreenPtr_32x16       ;; Calculate video memory location and return it in HL

    ex de, hl

    ld l,  ent_tex(ix)
    ld h, ent_tex+1(ix)
    ld b, ent_h(ix)
    ld c, ent_w(ix)
    call drawSprite_32x16

    ret

render_system_draw_tilemap::
    ld bc, #0x1010
    ld de, #32
    ld hl, #_tile_tilemap_00
    call setDrawTileMap4x8_ag_32x16
back_buffer_1 = . + 2   
    ld hl, #0xC400
    ld de, (camera + camera_ptr)
    call drawTilemap4x8_ag_32x16
    ret

change_screen:
change_screen_fptr = . + 1
    jp change_screen_to_C400

change_screen_to_C400:
    ld de, #0x0C32
    call set_crtc
    ld a, #0xC0
    ld (back_buffer_0), a
    ld (back_buffer_1), a

    ld hl, #change_screen_to_C000
    ld (change_screen_fptr), hl

    ret

change_screen_to_C000:
    ld de, #0x0C30
    call set_crtc
    ld a, #0xC4
    ld (back_buffer_0), a
    ld (back_buffer_1), a

    ld hl, #change_screen_to_C400
    ld (change_screen_fptr), hl

    ret

render_system_update::
    call render_system_draw_tilemap

    ld a, #(ent_mask_alive|ent_mask_render)
    ld hl, #render_system_render_one_entity
    call entity_manager_forall

    call change_screen

    ret