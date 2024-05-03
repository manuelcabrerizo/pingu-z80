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
                             19     .db 0
                             20     .dw _tex
                             21 .endm
                             22 
                             23 ;;===============================
                             24 ;; public DATA (:))
                     0000    25 ent_type  = 0  ;; 1 bytes
                     0001    26 ent_x     = 1  ;; 1 bytes
                     0002    27 ent_y     = 2  ;; 1 bytes
                     0003    28 ent_sx    = 3  ;; 1 bytes
                     0004    29 ent_sy    = 4  ;; 1 bytes
                     0005    30 ent_w     = 5  ;; 1 bytes
                     0006    31 ent_h     = 6  ;; 1 bytes
                     0007    32 ent_dx    = 7  ;; 1 bytes
                     0008    33 ent_dy    = 8  ;; 1 bytes
                     0009    34 ent_flags = 9  ;; 1 bytes
                     000A    35 ent_tex   = 10 ;; 2 bytes
                             36 ;; private DATA (:()
                     000C    37 ent_next  = 12 ;; 2 bytes
                             38 ;;===============================
                             39 
                     000E    40 ent_size = 14
                     000C    41 ent_data_size = ent_size - 2
                     000A    42 entity_manager_max_entities = 10
                             43 
                             44 
                             45 
                             46 ;;===================================
                             47 ;; Entity Bitfield
                             48 ;;===================================
                     0007    49 ent_type_alive_bit     = 7
                     0006    50 ent_type_physics_bit   = 6
                     0005    51 ent_type_render_bit    = 5
                     0004    52 ent_type_input_bit     = 4
                     0003    53 ent_type_collision_bit = 3
                             54 
                     0000    55 ent_mask_invalid   = 0x00
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     0080    56 ent_mask_alive     = (1 << ent_type_alive_bit)
                     0040    57 ent_mask_physics   = (1 << ent_type_physics_bit)
                     0020    58 ent_mask_render    = (1 << ent_type_render_bit)
                     0010    59 ent_mask_input     = (1 << ent_type_input_bit)
                     0008    60 ent_mask_collision = (1 << ent_type_collision_bit)
                             61 
                             62 
                             63 ;;===================================
                             64 ;; Entity Flags
                             65 ;;===================================
                     0007    66 ent_jump_bit  = 7
