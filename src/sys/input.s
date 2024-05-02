.include "cpctelera.h.s"
.include "man/entity.h.s"

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

input_system_init::
    ret

input_system_update_one_entity:

    call cpct_scanKeyboard_asm

    ld ent_dx(ix), #0

    ld hl, #Key_P
    call cpct_isKeyPressed_asm
    jr z, p_not_press
    ld ent_dx(ix), #1

p_not_press:

    ld hl, #Key_O
    call cpct_isKeyPressed_asm
    jr z, o_not_press
    ld ent_dx(ix), #-1

o_not_press:

    ld hl, #Key_Space
    call cpct_isKeyPressed_asm
    jr z, space_not_press
    ld ent_dy(ix), #-8

space_not_press:

    ret
    

input_system_update::
    ld a, #(ent_mask_alive|ent_mask_physics|ent_mask_input)
    ld hl, #input_system_update_one_entity
    call entity_manager_forall
    ret