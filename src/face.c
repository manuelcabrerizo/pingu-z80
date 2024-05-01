#include "face.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Palette uses hardware values.
const u8 pre_palette[16] = { 0x54, 0x44, 0x5c, 0x58, 0x45, 0x56, 0x46, 0x5e, 0x40, 0x47, 0x42, 0x53, 0x5a, 0x4a, 0x43, 0x4b };

u8* const pre_tileset[1] = { 
	pre_face
};
// Tile pre_face: 8x8 pixels, 4x8 bytes.
const u8 pre_face[4 * 8] = {
	0x00, 0xf3, 0xf3, 0x00,
	0x51, 0xf3, 0xf3, 0xa2,
	0xf7, 0xfb, 0xff, 0xf3,
	0xf7, 0x51, 0xaa, 0xf3,
	0xf3, 0xf3, 0xf3, 0xf3,
	0xf3, 0xa2, 0x00, 0xf3,
	0x51, 0xf3, 0xf3, 0xa2,
	0x00, 0xf3, 0xf3, 0x00
};
