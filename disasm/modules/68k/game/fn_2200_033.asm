; ============================================================================
; Vint Velocity 033 (auto-analyzed)
; ROM Range: $002E7E-$002E9E (32 bytes)
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

fn_2200_033:
        MOVE.L  (-14508).W,$0024(A1)            ; $002E7E
        MOVE.L  (-14508).W,$0128(A2)            ; $002E84
        MOVE.W  #$0001,$0064(A1)                ; $002E8A
        TST.W  $008C(A0)                        ; $002E90
        BEQ.S  .loc_001E                        ; $002E94
        MOVE.W  #$0000,$0064(A1)                ; $002E96
.loc_001E:
        RTS                                     ; $002E9C
