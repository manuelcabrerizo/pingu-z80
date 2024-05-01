;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of CPCtelera: An Amstrad CPC Game Engine 
;;  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;-------------------------------------------------------------------------------

;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"
.include "cpct/cpct32x16.h.s"
.include "man/entity.h.s"

;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA 
.area _CODE

.globl cpct_disableFirmware_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPalette_asm

.globl _pre_palette
.globl _pre_face
.globl _spr_pingu_0

test_entity_1: DefineEntity 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x1111

; D = Registro
; E = Valor
set_crtc::
   ld bc, #0xBC00
   out (c), d
   inc b
   out (c), e
   ret


;;
;; MAIN function. This is the entry point of the application.
;;    _main:: global symbol is required for correctly compiling and linking
;;
_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   ;; Setup the display 
   ld de, #0x0120
   call set_crtc

   ld de, #0x022A
   call set_crtc

   ld de, #0x0610
   call set_crtc

   ld de, #0x071A
   call set_crtc

   cpctm_setBorder_asm HW_WHITE
   ld c, #0
   call cpct_setVideoMode_asm

   ld hl, #_pre_palette
   ld de, #16
   call cpct_setPalette_asm

   ;; test for the entity manager initialization
   call entity_manager_init

   call entity_manager_create_entity
   ld hl, #test_entity_1
   ldir        ;; *DE = *HL; ++HL; ++DE; --BC

   ;; Calculate a video-memory location for printing a string
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #5                   ;; B = y coordinate (24 = 0x18)
   ld    c, #5                   ;; C = x coordinate (16 = 0x10)
   call getScreenPtr_32x16       ;; Calculate video memory location and return it in HL

   ex de, hl

   ld hl, #_pre_face
   ld b, #8
   ld c, #4
   call drawSprite_32x16

      ;; Calculate a video-memory location for printing a string
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #0                   ;; B = y coordinate (24 = 0x18)
   ld    c, #16                  ;; C = x coordinate (16 = 0x10)
   call getScreenPtr_32x16       ;; Calculate video memory location and return it in HL

   ex de, hl

   ld hl, #_spr_pingu_0
   ld b, #24
   ld c, #8
   call drawSprite_32x16


         ;; Calculate a video-memory location for printing a string
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, #0                   ;; B = y coordinate (24 = 0x18)
   ld    c, #16                  ;; C = x coordinate (16 = 0x10)
   call getScreenPtr_32x16       ;; Calculate video memory location and return it in HL

   ex de, hl

   ld a, #0x00
   ld b, #24
   ld c, #8
   call drawSolidBox_32x16


   ;; Loop forever
loop:
   jr    loop