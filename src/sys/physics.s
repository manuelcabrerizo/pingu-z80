.include "man/entity.h.s"

physics_system_init::
    ret


physics_system_update_one_entity:
    

    
    ;; update the x position
    ld a, ent_x(ix)
    add  ent_dx(ix)
    ld ent_x(ix), a
    ;; update the y position
    ld a, ent_y(ix)
    add  ent_dy(ix)
    ld ent_y(ix), a

    ;; Apply gravity
    inc ent_dy(ix)
    
    ;; check collision with the floor
    ;; if e_y < 128-h ret
    ld c, a
    ld a, #128
    sub ent_h(ix)
    ld b, a
    ld a, #256
    sub b
    add c
    ret nc
    ;; if e_y > 128-h\
    ld ent_dy(ix), #0
    ld ent_y(ix), b

    ret

physics_system_update::
    ld a, #(ent_mask_alive|ent_mask_physics)
    ld hl, #physics_system_update_one_entity
    call entity_manager_forall
    ret