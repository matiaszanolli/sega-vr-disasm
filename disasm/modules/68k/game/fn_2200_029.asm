; ============================================================================
; Vint Velocity 029 (auto-analyzed)
; ROM Range: $002DF4-$002E14 (32 bytes)
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

fn_2200_029:
        MOVE.L  (-14520).W,$0024(A1)            ; $002DF4
        MOVE.L  (-14520).W,$0128(A2)            ; $002DFA
        MOVE.W  #$0001,$0064(A1)                ; $002E00
        TST.W  $008C(A0)                        ; $002E06
        DC.W    $6726               ; BEQ.S  $002E32; $002E0A
        MOVE.W  #$0000,$0064(A1)                ; $002E0C
        RTS                                     ; $002E12
