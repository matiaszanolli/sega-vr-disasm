; ============================================================================
; Vint Velocity 030 (auto-analyzed)
; ROM Range: $002E14-$002E34 (32 bytes)
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

fn_2200_030:
        MOVE.L  (-14576).W,$0024(A1)            ; $002E14
        MOVE.L  (-14576).W,$0128(A2)            ; $002E1A
        MOVE.W  #$0001,$0064(A1)                ; $002E20
        TST.W  $008C(A0)                        ; $002E26
        BEQ.S  .loc_001E                        ; $002E2A
        MOVE.W  #$0000,$0064(A1)                ; $002E2C
.loc_001E:
        RTS                                     ; $002E32
