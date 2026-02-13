; ============================================================================
; Pitch Bend Apply — apply portamento/bend to base frequency
; ROM Range: $031188-$0311A8 (32 bytes)
; ============================================================================
; Reads channel index from sequence (A4), doubles for word offset. Looks
; up bend state from A6+$10 (direction/enable) and bend amount from
; A6+$12 (16-bit delta). If positive: adds delta to base frequency
; (A5+$1E), clears state. If zero or negative: returns without change.
; Used as a sequence command for portamento effects.
;
; Entry: A4 = sequence data pointer (advanced by 1)
; Entry: A5 = channel structure pointer
; Entry: A6 = sound driver state pointer
; Uses: D0, D1, A4
; Confidence: medium
; ============================================================================

pitch_bend_apply:
        MOVE.B  (A4)+,D0                        ; $031188
        EXT.W   D0                              ; $03118A
        MOVE.B  $10(A6,D0.W),D1                 ; $03118C
        ADD.W   D0,D0                           ; $031190
        TST.B  D1                               ; $031192
        DC.W    $6720               ; BEQ.S  $0311B6; $031194
        DC.W    $6B10               ; BMI.S  $0311A8; $031196
        MOVE.W  $12(A6,D0.W),D1                 ; $031198
        ADD.W  D1,$001E(A5)                     ; $03119C
        MOVEQ   #$00,D1                         ; $0311A0
        MOVE.B  D1,$10(A6,D0.W)                 ; $0311A2
        RTS                                     ; $0311A6
