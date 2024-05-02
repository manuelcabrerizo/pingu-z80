ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .module entity_manager
                              2 
                              3 .globl entity_manager_init
                              4 .globl entity_manager_create_entity
                              5 .globl entity_manager_destroy_entity
                              6 .globl entity_manager_forall
                              7 
                              8 .macro DefineEntity _type, _x, _y, _w, _h, _dx, _dy, _tex
                              9 ;; public data
                             10     .db _type
                             11     .db _x
                             12     .db _y
                             13     .db _w
                             14     .db _h
                             15     .db _dx
                             16     .db _dy
                             17     .dw _tex
                             18 .endm
                             19 
                             20 ;;===============================
                             21 ;; public DATA (:))
                     0000    22 ent_type  = 0  ;; 1 bytes
                     0001    23 ent_x     = 1  ;; 1 bytes
                     0002    24 ent_y     = 2  ;; 1 bytes
                     0003    25 ent_w     = 3  ;; 1 bytes
                     0004    26 ent_h     = 4  ;; 1 bytes
                     0005    27 ent_dx    = 5  ;; 1 bytes
                     0006    28 ent_dy    = 6  ;; 1 bytes
                     0007    29 ent_tex   = 7  ;; 2 bytes
                             30 ;; private DATA (:()
                     0009    31 ent_next  = 9  ;; 2 bytes
                             32 ;;===============================
                             33 
                     000B    34 ent_size = 11
                     000A    35 entity_manager_max_entities = 10
                     0009    36 ent_data_size = 9
                             37 
                             38 
                             39 ;;===================================
                             40 ;; Entity Bitfield
                             41 ;;===================================
                     0007    42 ent_type_alive_bit     = 7
                     0006    43 ent_type_physics_bit   = 6
                     0005    44 ent_type_render_bit    = 5
                     0004    45 ent_type_input_bit     = 4
                     0003    46 ent_type_collision_bit = 3
                             47 
                     0000    48 ent_mask_invalid   = 0x00
                     0080    49 ent_mask_alive     = (1 << ent_type_alive_bit)
                     0040    50 ent_mask_physics   = (1 << ent_type_physics_bit)
                     0020    51 ent_mask_render    = (1 << ent_type_render_bit)
                     0010    52 ent_mask_input     = (1 << ent_type_input_bit)
                     0008    53 ent_mask_collision = (1 << ent_type_collision_bit)
