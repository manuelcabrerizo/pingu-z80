.include "cpctelera.h.s"
.include "man/entity.h.s"

.globl _tilemap_00

collision_system_init::
    ret

collision_system_update_one_entity:
    ;; tilemapWidth = 32
    ;; tileY = y >> 3
    ;; tileX = x >> 2
    ;; tilemapStart + (tileY * tilemapWidth) + tileX
    ld b, ent_h(ix)
    dec b

    ld a, ent_y(ix)
    add b
    ;srl a
    ;srl a
    ;srl a
    and #0b11111000

    ld h, #0
    ld l, a
    ;add hl, hl       ;; tileY * 2
    ;add hl, hl       ;; tileY * 4
    ;add hl, hl       ;; tileY * 8
    add hl, hl        ;; tileY * 16
    add hl, hl        ;; tileY * 32

    ld a, ent_x(ix)
    srl a
    srl a

    add_hl_a          ;; (tileY * tilemapWidth) + tileX
    ld de, #_tilemap_00
    add hl, de

    ;; HL = tilemapStart + (tileY * tilemapWidth) + tileX
    ld a, (hl)
    and #0b11111000
    ret nz

    ld ent_dy(ix), #0

    ret

collision_system_update::
    ld a, #(ent_mask_alive|ent_mask_physics|ent_mask_collision)
    ld hl, #collision_system_update_one_entity
    call entity_manager_forall
    ret