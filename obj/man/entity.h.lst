ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



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
