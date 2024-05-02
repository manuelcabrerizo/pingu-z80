.include "cpctelera.h.s"
.include "cpct/cpct32x16.h.s"
.include "man/entity.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/input.h.s"
.include "sys/collision.h.s"

.area _DATA 
.area _CODE

.globl cpct_disableFirmware_asm
.globl cpct_waitVSYNC_asm
.globl _pre_face
.globl _spr_pingu_0

test_face:  DefineEntity (ent_mask_alive|ent_mask_physics|ent_mask_render|ent_mask_collision), 16, 5, 4,  8, 0, 0, _pre_face
test_pingu: DefineEntity (ent_mask_alive|ent_mask_physics|ent_mask_render|ent_mask_input|ent_mask_collision), 0,  5, 8, 24, 0, 0, _spr_pingu_0

;;
;; MAIN function. This is the entry point of the application.
;;    _main:: global symbol is required for correctly compiling and linking
;;
_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ;; initialize managers
   call entity_manager_init
   ;; initialize subsystems
   call render_system_init
   call input_system_init
   call physics_system_init
   call collision_system_init
   
   
   call entity_manager_create_entity
   ld hl, #test_face
   ldir

   call entity_manager_create_entity
   ld hl, #test_pingu
   ldir

game_loop:
   call input_system_update
   call physics_system_update
   call collision_system_update

   call render_system_update
   jr game_loop