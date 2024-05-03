.include "cpctelera.h.s"
.include "man/entity.h.s"

.globl _tilemap_00

collision_system_init::
    ret

;;==============================================
;; get the tile position from the (x, y) coords
;; PARAMETERS:
;;     B = y
;;     C = x
;; RETURN VALUE:
;;     HL = addrs of the tile
;; MODIFY REGISTERS:
;;     A, HL, DE
;;==============================================
get_tile_from_coord:
    ld a, b
    and #0b11111000
    ld h, #0
    ld l, a
    add hl, hl        ;; tileY * 16
    add hl, hl        ;; tileY * 32
    ld a, c
    srl a
    srl a
    add_hl_a          ;; (tileY * tilemapWidth) + tileX
    ld de, #_tilemap_00
    add hl, de        ;; HL = tilemapStart + (tileY * tilemapWidth) + tileX
    ret

resolve_floor_collision:
    ld a, ent_y(ix)
    and #0b11111000
    ld ent_y(ix), a
    ld ent_dy(ix), #0
    ret




collision_system_test_floor:
;; bottom left collision check
bottom_left_collision_check:
    ld d, ent_h(ix)
    dec d
    ld a, ent_y(ix)
    add d
    ld b, a
    ld c, ent_x(ix)
    call get_tile_from_coord

    ld a, (hl)
    and #0b11111000 ;; test the tile
    jr nz, bottom_right_collision_check
    call resolve_floor_collision

;; bottom right collision check
bottom_right_collision_check:
    ld d, ent_h(ix)
    dec d
    ld a, ent_y(ix)
    add d
    ld b, a
    ld c, ent_w(ix)
    dec c
    ld a, ent_x(ix)
    add c
    ld c, a
    call get_tile_from_coord

    ld a, (hl)
    and #0b11111000 ;; test the tile
    ret nz
    call resolve_floor_collision

    ret





collision_system_update_one_entity:
    call collision_system_test_floor
    ret



collision_system_update::
    ld a, #(ent_mask_alive|ent_mask_physics|ent_mask_collision)
    ld hl, #collision_system_update_one_entity
    call entity_manager_forall
    ret