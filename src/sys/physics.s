.include "man/entity.h.s"

physics_system_init::
    ret


physics_system_update_one_entity:

    inc ent_dy(ix)
    
    ld a, ent_y(ix)
    add  ent_dy(ix)
    ld ent_y(ix), a
    
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
    ;; if e_y > 128-h
    ld ent_dy(ix), #-14
    ld ent_y(ix), b

    ret

physics_system_update::
    ;;ld bc, #( CMP_FLAGS... )
    ld hl, #physics_system_update_one_entity
    call entity_manager_forall
    ret