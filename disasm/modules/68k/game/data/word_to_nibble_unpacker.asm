; ============================================================================
; word_to_nibble_unpacker — Word-to-Nibble Unpacker
; ROM Range: $00B43C-$00B478 (60 bytes)
; Unpacks two words from (A1) into individual nibble bytes at (A3).
; Reads +$02(A1) → shifts right 4 bits at a time to fill +$07,+$06,+$05.
; Reads (A1) → shifts right to fill +$04,+$03,+$02,+$01.
; Masks results with ANDI to keep only low nibble per byte.
; Used by sequence/sound system for BCD-style data unpacking.
;
; Entry: A1 = source word pointer, A3 = output nibble buffer
; Uses: D0, A1, A3
; Confidence: high
; ============================================================================

word_to_nibble_unpacker:
        MOVE.W  $0002(A1),D0                    ; $00B43C
        MOVE.B  D0,$0007(A3)                    ; $00B440
        LSR.W  #4,D0                            ; $00B444
        MOVE.B  D0,$0006(A3)                    ; $00B446
        LSR.W  #4,D0                            ; $00B44A
        MOVE.B  D0,$0005(A3)                    ; $00B44C
        MOVE.W  (A1),D0                         ; $00B450
        MOVE.B  D0,$0004(A3)                    ; $00B452
        LSR.W  #4,D0                            ; $00B456
        MOVE.B  D0,$0003(A3)                    ; $00B458
        LSR.W  #4,D0                            ; $00B45C
        MOVE.B  D0,$0002(A3)                    ; $00B45E
        LSR.W  #4,D0                            ; $00B462
        MOVE.B  D0,$0001(A3)                    ; $00B464
        ANDI.W  #$0F0F,$0002(A3)                ; $00B468
        ANDI.L  #$0F0F0F0F,$0004(A3)            ; $00B46E
        RTS                                     ; $00B476
