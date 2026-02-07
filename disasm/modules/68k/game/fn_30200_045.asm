; ============================================================================
; Fm 045 (auto-analyzed)
; ROM Range: $0311E8-$03120C (36 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5): +$20, +$21, +$22, +$23, +$24, +$28
;
; Entry: A5 = object/entity pointer
; Uses: A4, A5
; Object fields:
;   +$20: [unknown]
;   +$21: [unknown]
;   +$22: [unknown]
;   +$23: [unknown]
;   +$24: [unknown]
;   +$28: [unknown]
; Confidence: low
; ============================================================================

fn_30200_045:
        DC.W    $4EBA,$F932         ; JSR     $030B1C(PC); $0311E8
        DC.W    $6000,$022A         ; BRA.W  $031418; $0311EC
        MOVE.B  (A4)+,$0028(A5)                 ; $0311F0
        DC.W    $6716               ; BEQ.S  $03120C; $0311F4
        MOVE.B  (A4)+,$0020(A5)                 ; $0311F6
        MOVE.B  (A4)+,$0021(A5)                 ; $0311FA
        MOVE.B  (A4)+,$0022(A5)                 ; $0311FE
        MOVE.B  (A4),$0023(A5)                  ; $031202
        MOVE.B  (A4)+,$0024(A5)                 ; $031206
        RTS                                     ; $03120A
