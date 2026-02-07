; ============================================================================
; Data Unpack Nibbles
; ROM Range: $004280-$0042BA (58 bytes)
; ============================================================================
; Unpacks packed nibble data from (A1)+ into byte fields at A2+$09 through A2+$0F.
; Reads 2 bytes + 1 word, splits each byte into high/low nibbles.
;
; Entry: A1 = source data, A2 = destination structure
; Uses: D0, A1 (advances)
; ============================================================================

data_unpack_nibbles:
        move.b  (a1)+,d0              ; Read packed byte 1
        move.b  d0,$000A(a2)          ; Store low nibble (unmasked)
        lsr.b   #4,d0                 ; Get high nibble
        move.b  d0,$0009(a2)          ; Store high nibble
        move.b  (a1)+,d0              ; Read packed byte 2
        move.b  d0,$000C(a2)          ; Store low nibble
        lsr.b   #4,d0
        move.b  d0,$000B(a2)          ; Store high nibble
        move.w  (a1)+,d0              ; Read packed word
        move.b  d0,$000F(a2)          ; Bits 3-0 (low byte low nibble)
        lsr.w   #4,d0                 ; Shift right 4
        move.b  d0,$000E(a2)          ; Bits 7-4
        lsr.w   #4,d0                 ; Shift right 4 more
        move.b  d0,$000D(a2)          ; Bits 11-8
        andi.w  #$0F0F,$000A(a2)      ; Mask bytes $0A-$0B to nibbles
        andi.l  #$0F0F0F0F,$000C(a2)  ; Mask bytes $0C-$0F to nibbles
        rts
