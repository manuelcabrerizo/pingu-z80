.module entity_manager

.globl entity_manager_init
.globl entity_manager_create_entity
.globl entity_manager_destroy_entity
.globl entity_manager_forall

.macro DefineEntity _x, _y, _w, _h, _dx, _dy, _tex
;; public data
    .db _x
    .db _y
    .db _w
    .db _h
    .db _dx
    .db _dy
    .dw _tex
    .dw #0xC000
    .dw #0xC000
.endm

;;===============================
;; public DATA (:))
ent_x     = 0  ;; 1 bytes
ent_y     = 1  ;; 1 bytes
ent_w     = 2  ;; 1 bytes
ent_h     = 3  ;; 1 bytes
ent_dx    = 4  ;; 1 bytes
ent_dy    = 5  ;; 1 bytes
ent_tex   = 6  ;; 2 bytes
ent_oldP0 = 8  ;; 2 bytes
ent_oldP1 = 10 ;; 2 bytes
;; private DATA (:()
ent_next  = 12 ;; 2 bytes
;;===============================

ent_size = 14
entity_manager_max_entities = 10
ent_data_size = 12