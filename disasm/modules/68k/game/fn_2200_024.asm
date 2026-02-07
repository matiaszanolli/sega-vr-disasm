; ============================================================================
; Vint Velocity 024 (auto-analyzed)
; ROM Range: $002AAA-$002AC4 (26 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A0, A1): +$24, +$64, +$8C (velocity_x)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: A0, A1
; Object fields:
;   +$24: [unknown]
;   +$64: [unknown]
;   +$8C: velocity_x
; Confidence: low
; ============================================================================

fn_2200_024:
        MOVE.L  (-14520).W,$0024(A1)            ; $002AAA
        MOVE.W  #$0001,$0064(A1)                ; $002AB0
        TST.W  $008C(A0)                        ; $002AB6
        DC.W    $6720               ; BEQ.S  $002ADC; $002ABA
        MOVE.W  #$0000,$0064(A1)                ; $002ABC
        RTS                                     ; $002AC2
