.include "cpctelera.h.s"
.include "cpct/cpct32x16.h.s"
.include "man/entity.h.s"

.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm
.globl _pre_palette

.globl _tile_tilemap_00
.globl _tilemap_00

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

    ;; remove the entity oldP
    ld a, #0
    ld e, ent_oldP0(ix)
    ld d, ent_oldP1(ix)
    ld b, ent_h(ix)
    ld c, ent_w(ix)
    call drawSolidBox_32x16

    ;; Calculate a video-memory location for printing a string
    ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
    ld    b, ent_y(ix)            ;; B = y coordinate (24 = 0x18)
    ld    c, ent_x(ix)            ;; C = x coordinate (16 = 0x10)
    call getScreenPtr_32x16       ;; Calculate video memory location and return it in HL

    ld ent_oldP0(ix), l
    ld ent_oldP1(ix), h

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
    
    ld hl, #0xC000
    ld de, #_tilemap_00
    call drawTilemap4x8_ag_32x16
    
    ret

render_system_update::
    call render_system_draw_tilemap

    ;;ld bc, #( CMP_FLAGS... )
    ld hl, #render_system_render_one_entity
    call entity_manager_forall
    ret