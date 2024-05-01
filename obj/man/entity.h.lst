ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 
                              2 .globl entity_manager_init
                              3 .globl entity_manager_create_entity
                              4 .globl entity_manager_destroy_entity
                              5 
                              6 .macro DefineEntity _x, _y, _w, _h, _dx, _dy, _tex
                              7 ;; public data
                              8     .db _x
                              9     .db _y
                             10     .db _w
                             11     .db _h
                             12     .db _dx
                             13     .db _dy
                             14     .dw _tex
                             15     .dw #0xC000
                             16     .dw #0xC000
                             17 .endm
                             18 
                             19 ;;===============================
                             20 ;; public DATA (:))
                     0000    21 ent_x     = 0  ;; 1 bytes
                     0001    22 ent_y     = 1  ;; 1 bytes
                     0002    23 ent_w     = 2  ;; 1 bytes
                     0003    24 ent_h     = 3  ;; 1 bytes
                     0004    25 ent_dx    = 4  ;; 1 bytes
                     0005    26 ent_dy    = 5  ;; 1 bytes
                     0006    27 ent_tex   = 6  ;; 2 bytes
                     0008    28 ent_oldP0 = 8  ;; 2 bytes
                     000A    29 ent_oldp1 = 10 ;; 2 bytes
                             30 ;; private DATA (:()
                     000C    31 ent_next  = 12 ;; 2 bytes
                             32 ;;===============================
                             33 
                     000E    34 ent_size = 14
                     000A    35 entity_manager_max_entities = 10
                     000C    36 ent_data_size = 12
