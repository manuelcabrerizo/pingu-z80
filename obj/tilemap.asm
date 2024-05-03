;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module tilemap
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tile_tilemap_11
	.globl _tile_tilemap_10
	.globl _tile_tilemap_09
	.globl _tile_tilemap_08
	.globl _tile_tilemap_07
	.globl _tile_tilemap_06
	.globl _tile_tilemap_05
	.globl _tile_tilemap_04
	.globl _tile_tilemap_03
	.globl _tile_tilemap_02
	.globl _tile_tilemap_01
	.globl _tile_tilemap_00
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
_tile_tilemap_00:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf6	; 246
	.db #0xf9	; 249
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf9	; 249
	.db #0xf6	; 246
	.db #0xff	; 255
_tile_tilemap_01:
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xf7	; 247
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xff	; 255
	.db #0xfb	; 251
	.db #0xff	; 255
	.db #0xf7	; 247
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xf6	; 246
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xf3	; 243
	.db #0xf9	; 249
	.db #0xf6	; 246
	.db #0xfb	; 251
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf9	; 249
_tile_tilemap_02:
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xa8	; 168
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x54	; 84	'T'
_tile_tilemap_03:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x54	; 84	'T'
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xa8	; 168
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x54	; 84	'T'
_tile_tilemap_04:
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x0c	; 12
_tile_tilemap_05:
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x23	; 35
	.db #0x13	; 19
	.db #0x03	; 3
	.db #0xcf	; 207
	.db #0x9b	; 155
	.db #0x67	; 103	'g'
	.db #0xcf	; 207
	.db #0x8b	; 139
	.db #0x33	; 51	'3'
	.db #0x33	; 51	'3'
	.db #0x47	; 71	'G'
	.db #0x16	; 22
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x29	; 41
	.db #0x03	; 3
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x03	; 3
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xcf	; 207
	.db #0xcf	; 207
	.db #0xf0	; 240
_tile_tilemap_06:
	.db #0x03	; 3
	.db #0x13	; 19
	.db #0xa1	; 161
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x23	; 35
	.db #0x52	; 82	'R'
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xa1	; 161
	.db #0x52	; 82	'R'
	.db #0x03	; 3
	.db #0x52	; 82	'R'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x23	; 35
	.db #0xa1	; 161
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0x13	; 19
	.db #0x03	; 3
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0x03	; 3
_tile_tilemap_07:
	.db #0x52	; 82	'R'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x23	; 35
	.db #0xa1	; 161
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x52	; 82	'R'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0x72	; 114	'r'
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0x03	; 3
	.db #0x06	; 6
	.db #0x09	; 9
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x09	; 9
	.db #0x06	; 6
	.db #0x03	; 3
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
	.db #0xb1	; 177
_tile_tilemap_08:
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
_tile_tilemap_09:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xf3	; 243
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xd1	; 209
	.db #0xc0	; 192
	.db #0xd1	; 209
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xd1	; 209
	.db #0xe2	; 226
	.db #0xd1	; 209
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xd1	; 209
	.db #0xe2	; 226
_tile_tilemap_10:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xe2	; 226
	.db #0xc0	; 192
_tile_tilemap_11:
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xc0	; 192
	.db #0xff	; 255
	.db #0xd5	; 213
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xea	; 234
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe2	; 226
	.db #0xc0	; 192
	.area _INITIALIZER
	.area _CABS (ABS)
