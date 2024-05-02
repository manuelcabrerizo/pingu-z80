.module entity_manager

.globl entity_manager_init
.globl entity_manager_create_entity
.globl entity_manager_destroy_entity
.globl entity_manager_forall

.macro DefineEntity _type, _x, _y, _w, _h, _dx, _dy, _tex
;; public data
    .db _type
    .db _x
    .db _y
    .db _w
    .db _h
    .db _dx
    .db _dy
    .dw _tex
.endm

;;===============================
;; public DATA (:))
ent_type  = 0  ;; 1 bytes
ent_x     = 1  ;; 1 bytes
ent_y     = 2  ;; 1 bytes
ent_w     = 3  ;; 1 bytes
ent_h     = 4  ;; 1 bytes
ent_dx    = 5  ;; 1 bytes
ent_dy    = 6  ;; 1 bytes
ent_tex   = 7  ;; 2 bytes
;; private DATA (:()
ent_next  = 9  ;; 2 bytes
;;===============================

ent_size = 11
entity_manager_max_entities = 10
ent_data_size = 9


;;===================================
;; Entity Bitfield
;;===================================
ent_type_alive_bit     = 7
ent_type_physics_bit   = 6
ent_type_render_bit    = 5
ent_type_input_bit     = 4
ent_type_collision_bit = 3

ent_mask_invalid   = 0x00
ent_mask_alive     = (1 << ent_type_alive_bit)
ent_mask_physics   = (1 << ent_type_physics_bit)
ent_mask_render    = (1 << ent_type_render_bit)
ent_mask_input     = (1 << ent_type_input_bit)
ent_mask_collision = (1 << ent_type_collision_bit)