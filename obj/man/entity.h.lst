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
                             11     .db _x    ;; world coord
                             12     .db _y    ;; world coord
                             13     .db _x    ;; screen coord
                             14     .db _y    ;; screen coord
                             15     .db _w
                             16     .db _h
                             17     .db _dx
                             18     .db _dy
                             19     .dw _tex
                             20 .endm
                             21 
                             22 ;;===============================
                             23 ;; public DATA (:))
                     0000    24 ent_type  = 0  ;; 1 bytes
                     0001    25 ent_x     = 1  ;; 1 bytes
                     0002    26 ent_y     = 2  ;; 1 bytes
                     0003    27 ent_sx    = 3  ;; 1 bytes
                     0004    28 ent_sy    = 4  ;; 1 bytes
                     0005    29 ent_w     = 5  ;; 1 bytes
                     0006    30 ent_h     = 6  ;; 1 bytes
                     0007    31 ent_dx    = 7  ;; 1 bytes
                     0008    32 ent_dy    = 8  ;; 1 bytes
                     0009    33 ent_tex   = 9  ;; 2 bytes
                             34 ;; private DATA (:()
                     000B    35 ent_next  = 11 ;; 2 bytes
                             36 ;;===============================
                             37 
                     000D    38 ent_size = 13
                     000B    39 ent_data_size = ent_size - 2
                     000A    40 entity_manager_max_entities = 10
                             41 
                             42 
                             43 
                             44 ;;===================================
                             45 ;; Entity Bitfield
                             46 ;;===================================
                     0007    47 ent_type_alive_bit     = 7
                     0006    48 ent_type_physics_bit   = 6
                     0005    49 ent_type_render_bit    = 5
                     0004    50 ent_type_input_bit     = 4
                     0003    51 ent_type_collision_bit = 3
                             52 
                     0000    53 ent_mask_invalid   = 0x00
                     0080    54 ent_mask_alive     = (1 << ent_type_alive_bit)
                     0040    55 ent_mask_physics   = (1 << ent_type_physics_bit)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     0020    56 ent_mask_render    = (1 << ent_type_render_bit)
                     0010    57 ent_mask_input     = (1 << ent_type_input_bit)
                     0008    58 ent_mask_collision = (1 << ent_type_collision_bit)
