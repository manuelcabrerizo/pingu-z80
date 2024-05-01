.include "man/entity.h.s"
.include "cpctelera.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO: check that the last element in the link list
;; has always the next pointer pointing to NULL (0x0000)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;=====================================================
;; Private entity manager DATA
;;=====================================================
entity_count:
    .db #0

first_free:
    .dw #0000

first_entity:
    .dw #0000

entities::
    .ds #entity_manager_max_entities * ent_size
;;=====================================================

;;==========================================
;; initialize the entity manager
;; PARAMETERS:
;;     none
;; RETURN VALUE:
;;     none
;; MODIFY REGISTERS:
;;     A, HL, IX, IY, BC
;;==========================================
entity_manager_init::
    ;; init first_entity pointer
    ld hl, #entities
    ld (first_free), hl

    ;; init create entity function
    ld hl, #entity_manager_add_first_entity
    ld (ent_man_create_addrs), hl 

    ;; init entity_count
    ld a, #0
    ld (entity_count), a
    
    ;; init free list
    ld a, #entity_manager_max_entities - 1

    ld ix, #entities
    ld iy, #entities + ent_size
    
    ent_man_init_loop:

        ld (next_entity_addrs), iy

    next_entity_addrs = . + 1
        ld hl, #0000
        ld   ent_next(ix), l
        ld ent_next+1(ix), h

        ;; next entity
        ld bc, #ent_size
        add ix, bc
        add iy, bc

        dec a
        jr nz, ent_man_init_loop
    ret
;;==========================================


;;==========================================
;; add a new entity to the manager and
;; return it in DE and its size in BC
;; PARAMETERS:
;;     none
;; RETURN VALUE:
;;     DE, BC
;; MODIFY REGISTERS:
;;     A, IX, HL
;;==========================================
entity_manager_create_entity::
ent_man_create_addrs = . + 1
    jp entity_manager_add_first_entity

entity_manager_add_first_entity:
    ;; initialize the first_entity pointer
    ld hl, #entities
    ld (first_entity), hl
    ;; grab a new entity from the free list
    ;; update the free list
    ld ix, (first_free)
    ld l,   ent_next(ix)
    ld h, ent_next+1(ix)
    ld (first_free), hl
    ld   ent_next(ix), #0
    ld ent_next+1(ix), #0
    ;; increment the number of entities in
    ;; the manager
    ld a, (entity_count)
    inc a
    ld (entity_count), a

    ;; change the addres of
    ;; jp entity_manager_add_first_entity
    ;; to point to jp entity_manager_add_entity
    ld hl, #entity_manager_add_entity
    ld (ent_man_create_addrs), hl 
    
    ld__e_ixl
    ld__d_ixh
    ld bc, #ent_data_size

    ret

entity_manager_add_entity:
    ;; grab a new entity from the free list
    ;; update the free list
    ld ix, (first_free)
    ld l,   ent_next(ix)
    ld h, ent_next+1(ix)
    ld (first_free), hl

    ld hl, (first_entity)
    ld   ent_next(ix), l
    ld ent_next+1(ix), h

    ;; update the first entity pointer
    ;; to point to this entity
    ld (first_entity), ix

    ;; increment the number of entities in
    ;; the manager
    ld a, (entity_count)
    inc a
    ld (entity_count), a

    ld__e_ixl
    ld__d_ixh
    ld bc, #ent_data_size

    ret
;;==========================================


;;==========================================
;; destroy a entity pass in ix
;; PARAMETERS:
;;     IX = entity to delete
;; RETURN VALUE:
;;     none
;; MODIFY REGISTERS:
;;     none
;;==========================================
entity_manager_destroy_entity::
    ;; if first
    ld__e_ixl
    ld__d_ixh
    ld hl, (first_entity)
    ld a, h
    xor d
    ld d, a
    ld a, l
    xor e
    or d
    jr nz, entity_is_not_first
    ;;=======================================
    ;; the entity was the first in the list
    ;;=======================================
    ;; set the first_entity to point to the next
    ld l,   ent_next(ix)
    ld h, ent_next+1(ix)
    ld (first_entity), hl
    call add_entity_to_free_list
    ret
    entity_is_not_first:
    ;;==========================================
    ;; the entity was NOT the first in the list
    ;;==========================================
    ;; search for the prev
    ld a, (entity_count)
    dec a
    ld (loop_counter_adds), a
    
    ld iy, (first_entity)
    prev_ent_loop:
        ;; set the entity to delete in de
        ld__e_ixl
        ld__d_ixh
        ;; set the next in bc
        ld c,   ent_next(iy)
        ld b, ent_next+1(iy)
        ;; compare the next entity to this entity
        ld a, d
        xor b
        ld b, a
        ld a, e
        xor c
        or b
        jr nz, next_entity_to_search
        ;; prev finded
        ;; the prev entity have to point to the next
        ;; of the deleted entity
        ld l,   ent_next(ix)
        ld h, ent_next+1(ix)
        ld   ent_next(iy), l
        ld ent_next+1(iy), h

        call add_entity_to_free_list

        ret
    next_entity_to_search:
        ;; move iy to the next entity in the list
        ld e,   ent_next(iy)
        ld d, ent_next+1(iy)
        ld__iyl_e
        ld__iyh_d
        ;; try to use the null ptr for this jump
        loop_counter_adds = . + 1
        ld a, #0
        dec a
        ld (loop_counter_adds), a
        jp nz, prev_ent_loop
;;==========================================

add_entity_to_free_list:
    ;; store this entity as the first_free
    ld hl, (first_free)
    ld (first_free), ix
    ;; store in the next ptr of this ent the last first free
    ld   ent_next(ix), l
    ld ent_next+1(ix), h
    ;; decrement the number of entities in
    ;; the manager
    ld a, (entity_count)
    dec a
    ld (entity_count), a
    ret



;;==========================================
;; call the function that is store in hl
;; foreach entity
;; PARAMETERS:
;;     HL,
;;     TODO: pass the component mask 
;;           to filter entities out
;; RETURN VALUE:
;;     none
;; MODIFY REGISTERS:
;;     HL, DE, IX, A
;;==========================================
entity_manager_forall::
    ;; Initialize the callback
    ld (forall_function_ptr), hl
    ;; load to ix the first entity
    ld ix, (first_entity)

    ld a, (entity_count)
forall_entity_loop:
    push af
forall_function_ptr = . + 1
    call #0000
    pop af


forall_next_entity:
    ld e,   ent_next(ix)
    ld d, ent_next+1(ix)
    ld__ixl_e
    ld__ixh_d

    dec a
    jr nz, forall_entity_loop
    ret
;;==========================================
