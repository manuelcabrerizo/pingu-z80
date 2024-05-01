.include "cpctelera.h.s"


;; LOCAL MACRO: drawSpriteRow
;;    Copies 4 bytes from the Stack to (HL) using pop BC.
;; It can copy the sprite left-to-right or right-to-left. For left-to-right
;; use 'inc' as parameter (MOV=inc), and for right-to-left use 'dec' (MOV=dec).
;; The copy assumes that destination is 4-byte aligned (L + 2 < 0xFF)
;; Parameters:
;;    MOV = ( inc | dec )
;;
.macro drawSpriteRow MOV
   pop   bc             ;; [3] Get next 2 sprite bytes
   ld  (hl), c          ;; [2] Copy byte 1
   MOV    l             ;; [1] HL++ / HL-- (4-byte aligned) -> next video mem location
   ld  (hl), b          ;; [2] Copy byte 2
   MOV    l             ;; [1] HL++ / HL-- (4-byte aligned) -> next video mem location
   pop   bc             ;; [3] Get next 2 sprite bytes
   ld  (hl), c          ;; [2] Copy byte 3
   MOV    l             ;; [1] HL++ / HL-- (4-byte aligned) -> next video mem location
   ld  (hl), b          ;; [2] Copy byte 4
.endm



drawTilemap4x8_ag_32x16::
    ;; Set Height and Width of the View Window of the current 
    ;; tilemap to be drawn (This is set by setDrawTilemap4x8_agf)
widthHeightSet = .+2
    ld iy, #0000         ;; [4] IYL=View Window Width, IYH=View Window Height

nextRow:
    ;; Disable interrupts and save SP before starting
    di                   ;; [1] Disable interrupts before starting (we are using SP to read values)
    ld (restoreSP), sp   ;; [6] Save actual SP to restore it in the end
    ;; Start of the code that draws the next tile of the present row being drawn
    ;;
nexttile:
    ;; Get next tile to be drawn from the tilemap, which is pointed by DE
    ld     a, (de)    ;; [2] A = present tile-ID of the tile to be drawn
    ld     b, a       ;; [1] B = A

    ;; From the tile-ID we hold in B, we need to calculate the Offset of the 
    ;; tile definition (its 32-bytes of screen pixel data). As each tile takes 32-bytes,
    ;; offsets are tile_0: 0-bytes, tile_1: 32-bytes, tile_2: 64-bytes... tile_N: N*32-bytes.
    ;; Therefore, we need to multiply 32*B (32*tile-ID). As this multiplication may result 
    ;; in a 16-bits value, we will perform BC = 32*B. Considering B=[abcdefgh], result 
    ;; has to be BC = [000abcde][fgh00000] (B shifted 5 times left = BC = 32*tile-ID).  
    xor    a       ;; [1] A = [00000000]
    srl    b       ;; [2] B = [0abcdefg] (Right shift, Carry = h)
    rra            ;; [1] A = [h0000000] (Rotate Right + Bit7 = h (Carry insertion))
    srl    b       ;; [2] B = [00abcdef] (Right shift, Carry = g)
    rra            ;; [1] A = [gh000000] (Rotate Right + Bit7 = g (Carry insertion))
    srl    b       ;; [2] B = [000abcde] (Right shift, Carry = f). 
    rra            ;; [1] A = [fgh00000] (Rotate Right + Bit7 = f (Carry insertion)). 
    ld     c, a    ;; [1] C = A. BC = 32*tile-ID complete.

    ;; Make IX point to the 32-byte screen pixel definition of the selected tile.
    ;; For that, we need to add previous calculated tile Offset (BC) and the start location
    ;; of the tileset (IX). So operation is IX = tilesetPtr + Offset = IX + BC. 
tilesetPtr = .+2
    ld    ix, #0000   ;; [4] IX = Pointer to start of tileset (0000 is placeholder set with tileset address)
    add   ix, bc      ;; [4] IX += Tile Offset  
    ld    sp, ix      ;; [3] Make SP Point to the start of the 32-byte screen pixel data
                        ;; ... definition of the current tile (IX is used to save and restore this pointer)
    ;;
    ;; This section of the code draws 1 8x8 pixels (4x8 bytes) tile
    ;; Uses:
    ;;    SP = Pointer to the start of the 32-bytes screen pixel definition of the tile
    ;;    HL = Video Memory Pointer (top-left-corner)
    ;; Modifies BC 
    ;;

    ;; Draw Sprite Lines using Gray-Code order and Zig-Zag movement
    ;; Gray Code scanline order: 0,1,3,2,6,7,5,4
    drawSpriteRow inc ;; [17] Copy tile line Left-to-Right [>>]
    set    3, h       ;; [ 2] --000---=>--001--- (Next sprite line: 1)
    drawSpriteRow dec ;; [17] Copy tile line Right-to-Left [<<]
    set    4, h       ;; [ 2] --001---=>--011--- (Next sprite line: 3)
    drawSpriteRow inc ;; [17] Copy tile line Left-to-Right [>>]
    res    3, h       ;; [ 2] --011---=>--010--- (Next sprite line: 2)
    drawSpriteRow dec ;; [17] Copy tile line Right-to-Left [<<]
    set    5, h       ;; [ 2] --010---=>--110--- (Next sprite line: 6)
    drawSpriteRow inc ;; [17] Copy tile line Left-to-Right [>>]
    set    3, h       ;; [ 2] --110---=>--111--- (Next sprite line: 7)
    drawSpriteRow dec ;; [17] Copy tile line Right-to-Left [<<] 
    res    4, h       ;; [ 2] --111---=>--101--- (Next sprite line: 5)
    drawSpriteRow inc ;; [17] Copy tile line Left-to-Right [>>]
    res    3, h       ;; [ 2] --101---=>--100--- (Next sprite line: 4)
    drawSpriteRow dec ;; [17] Copy tile line Right-to-Left [<<]
    res    5, h       ;; [ 2] --100---=>--000--- (Next sprite line: 0)

    ;; After drawing the tile, HL points to the same place in video memory
    ;; as it started. We need to move it to the right 4 bytes (the width of 1 tile)
    ;; to point to the place in video memory for the next tile. As this function
    ;; requires tilemap to be 4-bytes aligned in video memory, maximum value 
    ;; for L will be L=0xFC, so we can always safely add 3 to L with INC L, without 
    ;; modifying H. Then for safety reasons, last increment will be INC HL to 
    ;; ensure that H gets incremented when L=0xFF. This saves 1 microsecond
    ;; from LD BC, #4: ADD HL, BC.
    inc    l  ;; [1] /
    inc    l  ;; [1] | HL+=3 (Incrementing L only)  
    inc    l  ;; [1] \ 
    inc   hl  ;; [2] HL++ (HL += 4 in total)

    ;; We now test if we have finished drawing present row of tiles. If that is
    ;; the case, the Width counter will be 0 (IYL=0). 
    inc   de           ;; [2] ++DE (Make tilemapPtr point to next tile to be drawn)
    dec__iyl           ;; [2] --IYL (--Width, One less tile to be drawn in this row)
    jp    nz, nexttile ;; [3] if (IYL!=0), then more tiles are left to be drawn in this row,
                        ;; ... so continue with next tile.
rowEnd:
    ;; We have finished drawing present row of tiles. We restore SP original value
    ;; and previous interrupt status. This will enable interrupts to occur in a
    ;; safe way, permitting the use of this function along with split rasters
    ;; and/or music played on interrupts
restoreSP = .+1
    ld    sp, #0000      ;; [3] Restore SP (#0000 is a placeholder)
restoreI = .
    ei                   ;; [1] Restore previous interrupt status (Enabled or disabled)
                        ;; ... EI gets modified by setDrawTilemap_agf and could by DI instead

    ;; Decrement the Height counter (IYH) as we have finished a complete row.
    ;; If the counter is 0, then we have finished drawing the whole tilemap.
    dec__iyh             ;; [3]   --IYH (--Height)
    jr     z, return     ;; [2/3] if (Height==0) then return

    ;;
    ;; As Height counter is not 0 (IYH > 0), there are more rows to draw.
    ;; Set up pointers before drawing next tile row.
    ;;

    ;; Video Memory Pointer (Currently HL) has to point to next row in the screen.
    ;; As each row takes 0x50 bytes (in standard modes) we need to add to HL
    ;; the difference between the bytes drawn in this row and 0x50 to ensure that
    ;; each loop makes HL increment exactly 0x50 bytes, so that it points to next line.
    ;; Also, as width is measured in tiles, and each tile is 4 bytes-wide, the 
    ;; final calculation will be HL += screenWidth - drawnWidth = 0x50 - 4*width
incrementHL = .+1
    ld    bc, #0000      ;; [3] BC = (0x50 - 4*width) (#0000 is a placeholder that gets the value)
    add   hl, bc         ;; [3] HL += 0x50 - 4*width

    ;; As IYL has been used as width counter, it has been decremented to 0.
    ;; Restore it to the width value before using it again.
restoreWidth = .+2
    ld__iyl  #00         ;; [2] IYL = Width (#00 is a placeholder)

    ;; Tilemap pointer (Currently at DE) has to point to the start of the next row 
    ;; of the tilemap to be drawn. Similarly to the Video Memory Pointer, if our tilemap
    ;; is wider than our view width, we need to increment the pointer with the 
    ;; difference between tilemapWidth and our view width to ensure that the pointer
    ;; gets incremented by exactly tilemapWidth at each loop (ensuring that we always
    ;; end up pointing to the first tile of the next row). As we have incremented
    ;; the tilemap pointer by (width), the operation will be 
    ;; TilemapPtr += tilemapWidth - width
    ex    de, hl         ;; [1] Temporarily exchange HL<=>DE to do 16-bit maths for updating DE
updateWidth = .+1
    ld    bc, #0000      ;; [3] BC = tilemapWidth - width
    add   hl, bc         ;; [3] HL += tilemapWidth - width (TilemapPtr points to first tile of next row)
    ex    de, hl         ;; [1] Restore DE,HL into its proper registers, now with DE incremented

    jp    nextRow        ;; [3] Next Row

    ;; When everything is finished, we safely return
    ;; 
return:
    ret

setDrawTileMap4x8_ag_32x16::
   ;; Set (tilesetPtr) placeholder
   ld (tilesetPtr), hl     ;; [5] Save HL into tilesetPtr placeholder

   ;; Set all Width values required by drawTileMap4x8_ag. First two values
   ;; (heightSet, widthSet) are values used at the start of the function for
   ;; initialization. The other one (restoreWidth) restores the value of the
   ;; width after each loop, as it is used as counter and decremented to 0.
   ld (widthHeightSet), bc ;; [6]
   ld     a, c                    ;; [1]
   ld (restoreWidth), a    ;; [4] Set restore width after each loop placeholder
   
   ;; In order to properly show a view of (Width x Height) tiles from within the
   ;; tilemap, every time a row has been drawn, we need to move tilemap pointer
   ;; to the start of the next row. As the complete tilemap is (tilemapWidth) bytes
   ;; wide and we are showing a view only (Width) tiles wide, to complete (tilemapWidth)
   ;; bytes at each loop, we need to add (tilemapWidth - Width) bytes.
   sub_de_a                      ;; [7] tilemapWidth - Width
   ld (updateWidth), de   ;; [6] set the difference in updateWidth placeholder

   ;; Calculate HL update that has to be performed for each new row loop.
   ;; HL advances through video memory as tiles are being drawn. When a row
   ;; is completely drawn, HL is at the right-most place of the screen.
   ;; As each screen row has a width of 0x50 bytes (in standard modes), 
   ;; if the Row that has been drawn has less than 0x50 bytes, this difference
   ;; has to be added to HL to make it point to the start of next screen row.
   ;; As each tile is 4-bytes wide, this amount is (0x50 - 4*Width). Also,
   ;; taking into account that 4*Width cannot exceed 255 (1-byte), a maximum
   ;; of 63 tiles can be considered as Width.
   ld     a, c                ;; [1] A = Width
   add    a                   ;; [1] A = 2*Width
   add    a                   ;; [1] A = 4*Width
   cpl                        ;; [1] A = -4*Width - 1
   add #0x40 + 1              ;; [2] A = -4*Width-1 + 0x50+1 = 0x50 - 4*Width
   ld (incrementHL), a ;; [4] Set HL increment in its placeholder

   ;; Set the restoring of Interrupt Status. drawTileMap4x8_ag disables interrupts before
   ;; drawing each tile row, and then it restores previous interrupt status after the row
   ;; has been drawn. To do this, present interrupt status is considered. This code detects
   ;; present interrupt status and sets a EI/DI instruction at the end of tile row drawing
   ;; to either reactivate interrupts or preserve interrupts disabled.
   ld     a, i             ;; [3] P/V flag set to current interrupt status (IFF2 flip-flop)
   ld     a, #opc_EI       ;; [2] A = Opcode for Enable Interrupts instruction (EI = 0xFB)
   jp    pe, int_enabled   ;; [3] If interrupts are enabled, EI is the appropriate instruction
     ld   a, #opc_DI       ;; [2] Otherwise, it is DI, so A = Opcode for Disable Interrupts instruction (DI = 0xF3)
int_enabled:
   ld (restoreI), a ;; [4] Set the Restore Interrupt status at the end with corresponding DI or EI

   ret                     ;; [3] Return to caller



getScreenPtr_32x16::
   ;; Extract line number (L) from Y-coordinate
   ;; And multiply it by 256. rHL = 256 * L
   ld    a, b     ;; [1] rA = Y-Coordinate
   and   #0x07    ;; [2] /
   ld    h, a     ;; [1] \ rH = Y % 8      ;; << rH contains Line number [0-7] inside character Row
                  ;;     Putting Line Number into rH is similar to putting it 
                  ;;     into rHL and then shifting it 8-bits left. Same as 256*rHL.
                  ;;     Therefore, this is like doing HL += 256*L

   ;; Now extract Screen Character Row (R) from Y-Coordinate
   xor   b        ;; [1] / rA = ( rB and #0x07 ) xor rB  =  rB and #0xF8
   ld    l, a     ;; [1] \ rL = 8*int(Y/8) ;; << L contains Screen Character Row multiplied by 8
                                           ;;    as bits are shifted 3-bits to the left because
                                           ;;    the 3-least-significant-bits had the line number (L)
   ;; Now rHL = 256*L + 8*R  { rH = Y%8 = L ||| rL = 8*int(Y/8) = 8*R }
   ;; We need to calculate 2048*L + 64*R
   ;; This can be factored into 8*(256*L + 8*R)

   ;; Now rHL = 256*L + 8*R
   ;; Just multiply rHL' = 8*rHL = 8*(256*L + 8*R) = 2048*L + 64*R
   add   hl, hl   ;; [3] / rHL' = 8*rHL
   add   hl, hl   ;; [3] | rHL' = 2048*L + 64*R
   add   hl, hl   ;; [3] \ 

   ;; To complete the calculations, we only need to add the X-Coordinate
   ;; and the pointer to the start of the video buffer
   
   ;; Add up X coordinate
   ld     b, #0   ;; [2] / As rC = X-Coordinate, having rB=0 makes rBC = X-Coordinate
   add   hl, bc   ;; [3] \ rHL' = rHL + X

   ;; Add up screen start address we still keep in DE
   add   hl, de   ;; [3] rHL' = rHL + screen_start

   ;; HL now contains the pointer to the byte in the video buffer. Just return it
   ret            ;; [3] return rHL = Pointer to the video buffer at (X,Y) byte coordinates




;; copy the byte to video memory
;; HL = Ptr to the sprite
;; DE = Ptr to video memory
;; B = Height
;; C = Width
drawSprite_32x16::
   ld a, c
   ld (spr_width), a
   neg
   ld (spr_width_neg), a   
   ld__iyl_b

next_line:
   ;; copy sprite row
spr_width = . +1
   ld bc, #0   ;; 01 00 00
   ldir        ;; *DE = *HL; ++HL; ++DE; --BC
   
   dec__iyl
   ret z
   
   ;; jump to next row
   ex de, hl
spr_width_neg = . +1
   ld bc, #0x7FC
   add hl, bc
   ex de, hl
   
   ;; Detect jump outside character boundaries
   ld a, #0x38  ;;  0b00111000
   and d
   jr nz, next_line

   ;; jump to the start of the next character

   ex de, hl
   ld bc, #-8*0x800 + 0x40
   add hl, bc
   ex de, hl

   jr next_line


;; copy the byte to video memory
;; DE = Ptr to video memory
;; B  = Height
;; C  = Width
;; A  = Color
drawSolidBox_32x16::
    ld (sb_spr_color), a

    ld a, c
    ld (sb_spr_width), a
    neg
    ld (sb_spr_width_neg), a   
    ld__iyl_b ;; .db 0xDD 0x68

sb_next_line:
    ;; copy sprite row

    ex de, hl
sb_spr_width = . +1
    ld a, #0   ;; 01 00 00
    
sb_loop:
sb_spr_color = . +1
    ld (hl), #0
    inc hl
    dec a
    jr nz, sb_loop
   
    dec__iyl
    ret z
   
    ;; jump to next row
sb_spr_width_neg = . +1
    ld bc, #0x7FC
    add hl, bc
    ex de, hl
   
    ;; Detect jump outside character boundaries
    ld a, #0x38  ;;  0b00111000
    and d
    jr nz, sb_next_line

    ;; jump to the start of the next character

    ex de, hl
    ld bc, #-8*0x800 + 0x40
    add hl, bc
    ex de, hl

    jr sb_next_line

