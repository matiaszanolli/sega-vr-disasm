; ============================================================================
; Vint Velocity 031 (auto-analyzed)
; ROM Range: $002E34-$002E5E (42 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$24, +$64, +$8A (param_8a), +$8C (velocity_x)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1, A2
; Object fields:
;   +$24: [unknown]
;   +$64: [unknown]
;   +$8A: param_8a
;   +$8C: velocity_x
; Confidence: low
; ============================================================================

fn_2200_031:
        MOVE.W  $008A(A0),D0                    ; $002E34
        DC.W    $6744               ; BEQ.S  $002E7E; $002E38
        SUBQ.W  #1,D0                           ; $002E3A
        DC.W    $6720               ; BEQ.S  $002E5E; $002E3C
        MOVE.L  (-14496).W,$0024(A1)            ; $002E3E
        MOVE.L  (-14496).W,$0128(A2)            ; $002E44
        MOVE.W  #$0001,$0064(A1)                ; $002E4A
        TST.W  $008C(A0)                        ; $002E50
        DC.W    $6746               ; BEQ.S  $002E9C; $002E54
        MOVE.W  #$0000,$0064(A1)                ; $002E56
        RTS                                     ; $002E5C
