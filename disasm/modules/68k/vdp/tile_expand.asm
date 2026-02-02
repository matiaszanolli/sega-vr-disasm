; ============================================================================
; VDP Tile Expansion Functions ($00247C - $0024AC)
; ============================================================================
;
; PURPOSE
; -------
; Expands packed nibble tile data to VDP format. Each source byte contains
; two 4-bit tile indices that are expanded to 16-bit VDP tile references.
;
; Called 24 times per frame - highest frequency VDP function.
;
; MEMORY MAP
; ----------
; | Address    | Name           | Purpose                        |
; |------------|----------------|--------------------------------|
; | $C00000    | VDP_DATA       | VDP data port (A6 register)    |
; | $C00004    | VDP_CTRL       | VDP control port (A5 register) |
;
; ALGORITHM
; ---------
; For each input byte at (A0)+:
;   1. Extract high nibble (bits 7-4) → D0
;   2. Extract low nibble (bits 3-0) → D1
;   3. Add tile base ($E001) to each → VDP tile reference
;   4. Write both words to VDP data port
;
; TILE FORMAT
; -----------
; VDP tile reference word:
;   Bits 15-13: Priority, palette, V/H flip
;   Bits 10-0:  Tile index in VRAM
;
; $E001 = 1110 0000 0000 0001
;       = Priority=1, Palette=3, VFlip=0, HFlip=0, Tile=1
;
; Dependencies: VDP initialized, A5=VDP_CTRL, A6=VDP_DATA
; Related: vdp_handlers.asm
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; VDP ports
VDP_DATA        equ     $C00000     ; VDP data port
VDP_CTRL        equ     $C00004     ; VDP control port

; Tile base value
TILE_BASE       equ     $E001       ; Priority + palette 3 + tile 1

        org     $00247C

; ============================================================================
; unpack_tiles_vdp ($00247C) - Expand 2 Bytes to 4 Tiles
; Called by: 24 locations per frame (tile copy loops)
; Parameters:
;   A0 = Source data pointer (2 bytes packed nibbles)
;   A6 = VDP data port
; Returns:
;   A0 = Advanced by 2 bytes
;   4 tile words written to VDP
;
; Expands 2 packed bytes (4 nibbles) to 4 VDP tile references.
; ============================================================================

unpack_tiles_vdp:
        move.w  #TILE_BASE,d6                   ; $00247C: $3C3C $E001 - Load tile base

; First byte - extract both nibbles
        moveq   #0,d0                           ; $002480: $7000       - Clear D0
        moveq   #0,d1                           ; $002482: $7200       - Clear D1
        move.b  (a0)+,d0                        ; $002484: $1018       - Read byte
        move.b  d0,d1                           ; $002486: $1200       - Copy to D1
        lsr.b   #4,d0                           ; $002488: $E808       - D0 = high nibble
        andi.b  #$0F,d1                         ; $00248A: $0201 $000F - D1 = low nibble
        add.w   d6,d0                           ; $00248E: $D046       - D0 += tile base
        add.w   d6,d1                           ; $002490: $D246       - D1 += tile base
        move.w  d0,(a6)                         ; $002492: $3CC0       - Write tile 1
        move.w  d1,(a6)                         ; $002494: $3CC1       - Write tile 2

; Second byte - same process
        moveq   #0,d0                           ; $002496: $7000       - Clear D0
        moveq   #0,d1                           ; $002498: $7200       - Clear D1
        move.b  (a0)+,d0                        ; $00249A: $1018       - Read byte
        move.b  d0,d1                           ; $00249C: $1200       - Copy to D1
        lsr.b   #4,d0                           ; $00249E: $E808       - D0 = high nibble
        andi.b  #$0F,d1                         ; $0024A0: $0201 $000F - D1 = low nibble
        add.w   d6,d0                           ; $0024A4: $D046       - D0 += tile base
        add.w   d6,d1                           ; $0024A6: $D246       - D1 += tile base
        move.w  d0,(a6)                         ; $0024A8: $3CC0       - Write tile 3
        move.w  d1,(a6)                         ; $0024AA: $3CC1       - Write tile 4
        rts                                     ; $0024AC: $4E75

; ============================================================================
; tile_index_expand ($0024AE) - Expand 1 Byte to 2 Tiles
; Called by: Tile copy routines (less frequent)
; Parameters:
;   A0 = Source data pointer (1 byte packed nibbles)
;   A6 = VDP data port
; Returns:
;   A0 = Advanced by 1 byte
;   2 tile words written to VDP
;
; Shorter version for single-byte expansion.
; ============================================================================

        org     $0024AE

tile_index_expand:
        move.w  #TILE_BASE,d6                   ; $0024AE: $3C3C $E001 - Load tile base
        moveq   #0,d0                           ; $0024B2: $7000       - Clear D0
        moveq   #0,d1                           ; $0024B4: $7200       - Clear D1
        move.b  (a0)+,d0                        ; $0024B6: $1018       - Read byte
        move.b  d0,d1                           ; $0024B8: $1200       - Copy to D1
        lsr.b   #4,d0                           ; $0024BA: $E808       - D0 = high nibble
        andi.b  #$0F,d1                         ; $0024BC: $0201 $000F - D1 = low nibble
        add.w   d6,d0                           ; $0024C0: $D046       - D0 += tile base
        add.w   d6,d1                           ; $0024C2: $D246       - D1 += tile base
        move.w  d0,(a6)                         ; $0024C4: $3CC0       - Write tile 1
        move.w  d1,(a6)                         ; $0024C6: $3CC1       - Write tile 2
        rts                                     ; $0024C8: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; unpack_tiles_vdp is the highest-frequency VDP function at 24 calls/frame.
; It expands packed 4-bit tile indices to 16-bit VDP tile references.
;
; Performance: ~60 cycles per call × 24 calls = ~1440 cycles/frame
;
; The tile base $E001 sets:
; - Priority bit (tile appears in front)
; - Palette 3 (colors 48-63)
; - Starting tile index 1
;
; ============================================================================
