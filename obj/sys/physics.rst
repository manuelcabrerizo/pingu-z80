ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 .include "man/entity.h.s"
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     0000    55 ent_mask_invalid   = 0x00
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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



                              2 .include "sys/physics.h.s"
                              1 .module physics_system
                              2 
                              3 .globl physics_system_init
                              4 .globl physics_system_update
                              5 
                              6 
                     0004     7 max_gravity = 4
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



                              3 
   4CD6                       4 physics_system_init::
   4CD6 C9            [10]    5     ret
                              6 
                              7 
   4CD7                       8 physics_system_update_one_entity:
                              9         
                             10     ;; update the x position
   4CD7 DD 7E 01      [19]   11     ld a, ent_x(ix)
   4CDA DD 86 07      [19]   12     add  ent_dx(ix)
   4CDD DD 77 01      [19]   13     ld ent_x(ix), a
                             14     ;; update the y position
   4CE0 DD 7E 02      [19]   15     ld a, ent_y(ix)
   4CE3 DD 86 08      [19]   16     add  ent_dy(ix)
   4CE6 DD 77 02      [19]   17     ld ent_y(ix), a
                             18 
                             19     ;; Apply gravity
   4CE9 DD 7E 08      [19]   20     ld a, ent_dy(ix)
                             21     ;; if the gravity is negative allways apply it
   4CEC CB 7F         [ 8]   22     bit 7, a
   4CEE 20 04         [12]   23     jr nz, apply_gravity
                             24     ;; if is positive i clamp it the max_gravity
   4CF0 FE 04         [ 7]   25     cp #max_gravity
   4CF2 30 03         [12]   26     jr nc, no_more_gravity
   4CF4                      27 apply_gravity:
   4CF4 DD 34 08      [23]   28     inc ent_dy(ix)
   4CF7                      29 no_more_gravity:
                             30 
   4CF7 C9            [10]   31     ret
                             32 
   4CF8                      33 physics_system_update::
   4CF8 3E C0         [ 7]   34     ld a, #(ent_mask_alive|ent_mask_physics)
   4CFA 21 D7 4C      [10]   35     ld hl, #physics_system_update_one_entity
   4CFD CD BE 4A      [17]   36     call entity_manager_forall
   4D00 C9            [10]   37     ret
