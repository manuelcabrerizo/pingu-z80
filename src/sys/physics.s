.include "man/entity.h.s"
.include "sys/physics.h.s"

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
    ld a, ent_dy(ix)
    ;; if the gravity is negative allways apply it
    bit 7, a
    jr nz, apply_gravity
    ;; if is positive i clamp it the max_gravity
    cp #max_gravity
    jr nc, no_more_gravity
apply_gravity:
    inc ent_dy(ix)
no_more_gravity:

    ret

physics_system_update::
    ld a, #(ent_mask_alive|ent_mask_physics)
    ld hl, #physics_system_update_one_entity
    call entity_manager_forall
    ret