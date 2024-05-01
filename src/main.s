.include "cpctelera.h.s"
.include "cpct/cpct32x16.h.s"
.include "man/entity.h.s"
.include "sys/render.h.s"

.area _DATA 
.area _CODE

.globl cpct_disableFirmware_asm
.globl _pre_face
.globl _spr_pingu_0

test_face:  DefineEntity 16,  5, 4,  8, 0, 0, _pre_face
test_pingu: DefineEntity 0, 16, 8, 24, 0, 0, _spr_pingu_0

;;
;; MAIN function. This is the entry point of the application.
;;    _main:: global symbol is required for correctly compiling and linking
;;
_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ;; initialize subsystems
   call entity_manager_init
   call render_system_init
   
   call entity_manager_create_entity
   ld hl, #test_face
   ldir

   call entity_manager_create_entity
   ld hl, #test_pingu
   ldir

game_loop:

   call render_system_update

   jr game_loop