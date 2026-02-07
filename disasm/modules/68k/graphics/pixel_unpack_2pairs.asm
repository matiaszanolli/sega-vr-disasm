; ============================================================================
; Pixel Unpack 2 Pairs
; ROM Range: $00247C-$0024AC (50 bytes)
; ============================================================================
; Unpacks 2 bytes into 4 pixels (4bpp packed pixel format).
; Each byte has two nibbles mapped to palette indices via D6 base offset.
;
; Entry: A0 = source data, A6 = VDP data port
; Uses: D0, D1, D6, A0 (advances by 2)
; ============================================================================

pixel_unpack_2pairs:
        move.w  #$E001,d6             ; Palette base offset
        moveq   #0,d0
        moveq   #0,d1
        move.b  (a0)+,d0              ; Read packed byte 1
        move.b  d0,d1
        lsr.b   #4,d0                 ; High nibble
        andi.b  #$0F,d1               ; Low nibble
        add.w   d6,d0                 ; Add palette base
        add.w   d6,d1
        move.w  d0,(a6)               ; Write pixel 1
        move.w  d1,(a6)               ; Write pixel 2
        moveq   #0,d0
        moveq   #0,d1
        move.b  (a0)+,d0              ; Read packed byte 2
        move.b  d0,d1
        lsr.b   #4,d0
        andi.b  #$0F,d1
        add.w   d6,d0
        add.w   d6,d1
        move.w  d0,(a6)               ; Write pixel 3
        move.w  d1,(a6)               ; Write pixel 4
        rts
