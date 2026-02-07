; ============================================================================
; Vint Velocity 032 (auto-analyzed)
; ROM Range: $002E5E-$002E7E (32 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0, A1): +$24, +$64, +$8C (velocity_x)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: A0, A1, A2
; Object fields:
;   +$24: [unknown]
;   +$64: [unknown]
;   +$8C: velocity_x
; Confidence: low
; ============================================================================

fn_2200_032:
        MOVE.L  (-14500).W,$0024(A1)            ; $002E5E
        MOVE.L  (-14500).W,$0128(A2)            ; $002E64
        MOVE.W  #$0001,$0064(A1)                ; $002E6A
        TST.W  $008C(A0)                        ; $002E70
        DC.W    $6726               ; BEQ.S  $002E9C; $002E74
        MOVE.W  #$0000,$0064(A1)                ; $002E76
        RTS                                     ; $002E7C
