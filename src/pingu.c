#include "pingu.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
u8* const spr_tileset[4] = { 
	spr_pingu_0, spr_pingu_1, spr_pingu_2, spr_pingu_3
};
// Tile spr_pingu_0: 16x24 pixels, 8x24 bytes.
const u8 spr_pingu_0[8 * 24] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x03, 0x03, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x01, 0x03, 0x03, 0x02, 0x00, 0x00,
	0x00, 0x00, 0x03, 0xff, 0x57, 0x03, 0x00, 0x00,
	0x00, 0x00, 0x57, 0xaa, 0xaa, 0xab, 0x00, 0x00,
	0x00, 0x01, 0x57, 0xaa, 0xaa, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xeb, 0xc3, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xeb, 0xc3, 0x83, 0x02, 0x00,
	0x00, 0x03, 0x03, 0xff, 0xff, 0x03, 0x03, 0x00,
	0x00, 0x03, 0x03, 0xff, 0xff, 0x03, 0x03, 0x00,
	0x01, 0x03, 0x57, 0xff, 0xff, 0xab, 0x03, 0x02,
	0x01, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x02,
	0x00, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x03, 0xff, 0xff, 0x03, 0x02, 0x00,
	0x00, 0x00, 0x03, 0x03, 0x03, 0x03, 0x00, 0x00,
	0x00, 0x00, 0x01, 0x02, 0x01, 0x02, 0x00, 0x00,
	0x00, 0x00, 0x41, 0xc3, 0x00, 0xc3, 0x82, 0x00,
	0x00, 0x00, 0x00, 0x82, 0x00, 0x41, 0x00, 0x00
};

// Tile spr_pingu_1: 16x24 pixels, 8x24 bytes.
const u8 spr_pingu_1[8 * 24] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x01, 0x03, 0x02, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x03, 0x03, 0x03, 0x00, 0x00, 0x00,
	0x00, 0x01, 0x57, 0xab, 0xab, 0x02, 0x00, 0x00,
	0x00, 0x01, 0xff, 0x55, 0x55, 0x02, 0x00, 0x00,
	0x00, 0x03, 0xff, 0x55, 0x55, 0x03, 0x00, 0x00,
	0x00, 0x03, 0xff, 0xc3, 0xd7, 0x03, 0x00, 0x00,
	0x00, 0x03, 0xff, 0xc3, 0xc3, 0x03, 0x00, 0x00,
	0x00, 0x03, 0x57, 0xff, 0xab, 0x03, 0x02, 0x00,
	0x00, 0x03, 0x57, 0xff, 0xab, 0x03, 0x02, 0x00,
	0x01, 0x03, 0xff, 0xff, 0xff, 0x03, 0x03, 0x00,
	0x01, 0x03, 0xff, 0xff, 0xff, 0x03, 0x01, 0x00,
	0x03, 0x03, 0xff, 0xff, 0xff, 0x03, 0x00, 0x00,
	0x02, 0x03, 0xff, 0xff, 0xff, 0x03, 0x00, 0x00,
	0x02, 0x03, 0xff, 0xff, 0xff, 0x03, 0x00, 0x00,
	0x00, 0x03, 0xff, 0xff, 0xff, 0xc3, 0x00, 0x00,
	0x00, 0x03, 0xff, 0xff, 0xab, 0xc3, 0x82, 0x00,
	0x00, 0x01, 0x57, 0xff, 0xab, 0xc3, 0x00, 0x00,
	0x00, 0x00, 0x03, 0x03, 0x03, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x01, 0x02, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x41, 0xc3, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x00, 0x00
};

// Tile spr_pingu_2: 16x24 pixels, 8x24 bytes.
const u8 spr_pingu_2[8 * 24] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x03, 0x03, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x01, 0x03, 0x03, 0x02, 0x00, 0x00,
	0x00, 0x00, 0x03, 0xff, 0x57, 0x03, 0x00, 0x00,
	0x00, 0x00, 0x57, 0xaa, 0xaa, 0xab, 0x00, 0x00,
	0x00, 0x01, 0x57, 0xaa, 0xaa, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xeb, 0xc3, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xeb, 0xc3, 0x83, 0x02, 0x00,
	0x00, 0x03, 0x03, 0xff, 0xff, 0x03, 0x03, 0x00,
	0x00, 0x03, 0x03, 0xff, 0xff, 0x03, 0x03, 0x00,
	0x01, 0x03, 0x57, 0xff, 0xff, 0xab, 0x03, 0x02,
	0x01, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x02,
	0x00, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x57, 0xff, 0xff, 0xab, 0x02, 0x00,
	0x00, 0x01, 0x03, 0xff, 0xff, 0x03, 0x02, 0x00,
	0x00, 0x00, 0x03, 0x03, 0x03, 0x03, 0x00, 0x00,
	0x00, 0x00, 0x01, 0x02, 0x01, 0x02, 0x00, 0x00,
	0x00, 0x00, 0x41, 0xc3, 0x00, 0xc3, 0x82, 0x00,
	0x00, 0x00, 0x00, 0x82, 0x00, 0x41, 0x00, 0x00
};

// Tile spr_pingu_3: 16x24 pixels, 8x24 bytes.
const u8 spr_pingu_3[8 * 24] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x01, 0x03, 0x02, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x03, 0x03, 0x03, 0x00, 0x00,
	0x00, 0x00, 0x01, 0x57, 0xab, 0xab, 0x02, 0x00,
	0x00, 0x00, 0x01, 0xff, 0x55, 0x55, 0x02, 0x00,
	0x00, 0x00, 0x03, 0xff, 0x55, 0x55, 0x03, 0x00,
	0x00, 0x00, 0x03, 0xff, 0xc3, 0xd7, 0x03, 0x00,
	0x00, 0x00, 0x03, 0xff, 0xc3, 0xc3, 0x03, 0x00,
	0x00, 0x01, 0x03, 0x57, 0xff, 0xab, 0x03, 0x00,
	0x00, 0x01, 0x03, 0x57, 0xff, 0xab, 0x03, 0x00,
	0x00, 0x03, 0x03, 0xff, 0xff, 0xff, 0x03, 0x02,
	0x00, 0x02, 0x03, 0xff, 0xff, 0xff, 0x03, 0x03,
	0x00, 0x00, 0x03, 0xff, 0xff, 0xff, 0x03, 0x03,
	0x00, 0x00, 0x03, 0xff, 0xff, 0xff, 0x03, 0x01,
	0x00, 0x00, 0x03, 0xff, 0xff, 0xff, 0x03, 0x01,
	0x00, 0x00, 0x03, 0xc3, 0xff, 0xff, 0x03, 0x00,
	0x00, 0x00, 0x03, 0xc3, 0xd7, 0xff, 0x03, 0x00,
	0x00, 0x00, 0x03, 0xc3, 0xff, 0xab, 0x02, 0x00,
	0x00, 0x00, 0x01, 0x03, 0x03, 0x03, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0xc3, 0x82, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x41, 0x00, 0x00
};

