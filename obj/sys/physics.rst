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
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                     0040    55 ent_mask_physics   = (1 << ent_type_physics_bit)
                     0020    56 ent_mask_render    = (1 << ent_type_render_bit)
                     0010    57 ent_mask_input     = (1 << ent_type_input_bit)
                     0008    58 ent_mask_collision = (1 << ent_type_collision_bit)
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
   4AEC                       4 physics_system_init::
   4AEC C9            [10]    5     ret
                              6 
                              7 
   4AED                       8 physics_system_update_one_entity:
                              9     
                             10 
                             11     
                             12     ;; update the x position
   4AED DD 7E 01      [19]   13     ld a, ent_x(ix)
   4AF0 DD 86 07      [19]   14     add  ent_dx(ix)
   4AF3 DD 77 01      [19]   15     ld ent_x(ix), a
                             16     ;; update the y position
   4AF6 DD 7E 02      [19]   17     ld a, ent_y(ix)
   4AF9 DD 86 08      [19]   18     add  ent_dy(ix)
   4AFC DD 77 02      [19]   19     ld ent_y(ix), a
                             20 
                             21 
                             22     ;; Apply gravity
   4AFF DD 7E 08      [19]   23     ld a, ent_dy(ix)
                             24     ;; if the gravity is negative allways apply it
   4B02 CB 7F         [ 8]   25     bit 7, a
   4B04 20 04         [12]   26     jr nz, apply_gravity
                             27     ;; if is positive i clamp it the max_gravity
   4B06 FE 04         [ 7]   28     cp #max_gravity
   4B08 30 03         [12]   29     jr nc, no_more_gravity
   4B0A                      30 apply_gravity:
   4B0A DD 34 08      [23]   31     inc ent_dy(ix)
   4B0D                      32 no_more_gravity:
                             33 
   4B0D C9            [10]   34     ret
                             35 
   4B0E                      36 physics_system_update::
   4B0E 3E C0         [ 7]   37     ld a, #(ent_mask_alive|ent_mask_physics)
   4B10 21 ED 4A      [10]   38     ld hl, #physics_system_update_one_entity
   4B13 CD B2 49      [17]   39     call entity_manager_forall
   4B16 C9            [10]   40     ret
