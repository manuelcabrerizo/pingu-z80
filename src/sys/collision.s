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
    ld e, l
    ld d, h
    add hl, hl        ;; tileY * 32
    add hl, de
    ld a, c
    srl a
    srl a
    add_hl_a          ;; (tileY * tilemapWidth) + tileX
    ld de, #_tilemap_00
    add hl, de        ;; HL = tilemapStart + (tileY * tilemapWidth) + tileX
    ret



;;====================================================
;; Funtion for collision resolution with the tilemap
;;====================================================
resolve_floor_collision:
    ld a, ent_y(ix)
    and #0b11111000
    ld ent_y(ix), a
    ld ent_dy(ix), #0
    ret

resolve_roof_collision:
    ld a, ent_y(ix)
    and #0b11111000
    add #8
    ld ent_y(ix), a
    ld ent_dy(ix), #0
    ret

resolve_right_wall_collision:
    ld a, ent_x(ix)
    and #0b11111100
    ld ent_x(ix), a
    ld ent_dx(ix), #0
    ret


resolve_left_wall_collision:
    ld a, ent_x(ix)
    and #0b11111100
    add #4
    ld ent_x(ix), a
    ld ent_dx(ix), #0
    ret

;;=======================================================
;; Function for test collision with the tilemap
;;=======================================================
collision_system_test_floor:
;; bottom left collision check
    ld d, ent_h(ix)
    dec d
    ld a, ent_y(ix)
    add d
    ld b, a
    ld c, ent_x(ix)
    call get_tile_from_coord

    ld a, (hl)
    cp #5
    jr nc, bottom_right_collision_check
    call resolve_floor_collision
    ret
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
    cp #5
    ret nc
    call resolve_floor_collision

    ret

;;=======================================================
;; Function for test collision with the tilemap
;;=======================================================
collision_system_test_roof:
;; top left collision check
    ld b, ent_y(ix)
    ld c, ent_x(ix)
    call get_tile_from_coord

    ld a, (hl)
    cp #5
    jr nc, top_right_collision_check
    call resolve_roof_collision
    ret
top_right_collision_check:
    ld b, ent_y(ix)
    ld c, ent_w(ix)
    dec c
    ld a, ent_x(ix)
    add c
    ld c, a
    call get_tile_from_coord

    ld a, (hl)
    cp #5
    ret nc
    call resolve_roof_collision

    ret

;;=======================================================
;; Function for test collision with the tilemap
;;=======================================================
collision_system_test_right_wall:
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
    cp #5
    ret nc
    call resolve_right_wall_collision

    ret

;;=======================================================
;; Functions for test collision with the tilemap
;;=======================================================
collision_system_test_left_wall:
    ld d, ent_h(ix)
    dec d
    ld a, ent_y(ix)
    add d
    ld b, a
    ld c, ent_x(ix)
    call get_tile_from_coord

    ld a, (hl)
    cp #5
    ret nc
    call resolve_left_wall_collision

    ret


collision_system_update_one_entity:
    call collision_system_test_floor
    call collision_system_test_right_wall
    call collision_system_test_left_wall
    call collision_system_test_roof    
    ret


collision_system_update::
    ld a, #(ent_mask_alive|ent_mask_physics|ent_mask_collision)
    ld hl, #collision_system_update_one_entity
    call entity_manager_forall
    ret