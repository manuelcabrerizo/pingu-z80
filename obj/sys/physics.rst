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
                              8 .macro DefineEntity _x, _y, _w, _h, _dx, _dy, _tex
                              9 ;; public data
                             10     .db _x
                             11     .db _y
                             12     .db _w
                             13     .db _h
                             14     .db _dx
                             15     .db _dy
                             16     .dw _tex
                             17     .dw #0xC000
                             18     .dw #0xC000
                             19 .endm
                             20 
                             21 ;;===============================
                             22 ;; public DATA (:))
                     0000    23 ent_x     = 0  ;; 1 bytes
                     0001    24 ent_y     = 1  ;; 1 bytes
                     0002    25 ent_w     = 2  ;; 1 bytes
                     0003    26 ent_h     = 3  ;; 1 bytes
                     0004    27 ent_dx    = 4  ;; 1 bytes
                     0005    28 ent_dy    = 5  ;; 1 bytes
                     0006    29 ent_tex   = 6  ;; 2 bytes
                     0008    30 ent_oldP0 = 8  ;; 2 bytes
                     000A    31 ent_oldP1 = 10 ;; 2 bytes
                             32 ;; private DATA (:()
                     000C    33 ent_next  = 12 ;; 2 bytes
                             34 ;;===============================
                             35 
                     000E    36 ent_size = 14
                     000A    37 entity_manager_max_entities = 10
                     000C    38 ent_data_size = 12
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



                              2 
   49CE                       3 physics_system_init::
   49CE C9            [10]    4     ret
                              5 
                              6 
   49CF                       7 physics_system_update_one_entity:
                              8 
   49CF DD 34 05      [23]    9     inc ent_dy(ix)
                             10     
   49D2 DD 7E 01      [19]   11     ld a, ent_y(ix)
   49D5 DD 86 05      [19]   12     add  ent_dy(ix)
   49D8 DD 77 01      [19]   13     ld ent_y(ix), a
                             14     
                             15     ;; check collision with the floor
                             16     ;; if e_y < 128-h ret
   49DB 4F            [ 4]   17     ld c, a
   49DC 3E 80         [ 7]   18     ld a, #128
   49DE DD 96 03      [19]   19     sub ent_h(ix)
   49E1 47            [ 4]   20     ld b, a
   49E2 3E 00         [ 7]   21     ld a, #256
   49E4 90            [ 4]   22     sub b
   49E5 81            [ 4]   23     add c
   49E6 D0            [11]   24     ret nc
                             25     ;; if e_y > 128-h
   49E7 DD 36 05 F2   [19]   26     ld ent_dy(ix), #-14
   49EB DD 70 01      [19]   27     ld ent_y(ix), b
                             28 
   49EE C9            [10]   29     ret
                             30 
   49EF                      31 physics_system_update::
                             32     ;;ld bc, #( CMP_FLAGS... )
   49EF 21 CF 49      [10]   33     ld hl, #physics_system_update_one_entity
   49F2 CD B1 49      [17]   34     call entity_manager_forall
   49F5 C9            [10]   35     ret
