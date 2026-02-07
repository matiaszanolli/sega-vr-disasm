; ============================================================================
; Pixel Unpack 1 Pair
; ROM Range: $0024AE-$0024C8 (28 bytes)
; ============================================================================
; Unpacks 1 byte into 2 pixels (4bpp packed pixel format).
;
; Entry: A0 = source data, A6 = VDP data port
; Uses: D0, D1, D6, A0 (advances by 1)
; ============================================================================

pixel_unpack_1pair:
        move.w  #$E001,d6             ; Palette base offset
        moveq   #0,d0
        moveq   #0,d1
        move.b  (a0)+,d0              ; Read packed byte
        move.b  d0,d1
        lsr.b   #4,d0                 ; High nibble
        andi.b  #$0F,d1               ; Low nibble
        add.w   d6,d0
        add.w   d6,d1
        move.w  d0,(a6)               ; Write pixel 1
        move.w  d1,(a6)               ; Write pixel 2
        rts
