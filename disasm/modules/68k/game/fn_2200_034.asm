; ============================================================================
; Vint 034 (auto-analyzed)
; ROM Range: $002E9E-$002EB2 (20 bytes)
; ============================================================================
; Category: vint
; Purpose: Short helper function
;   Object (A0, A1): +$24, +$8A (param_8a)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: A0, A1
; Object fields:
;   +$24: [unknown]
;   +$8A: param_8a
; Confidence: low
; ============================================================================

fn_2200_034:
        MOVE.L  (-14556).W,$0024(A1)            ; $002E9E
        TST.W  $008A(A0)                        ; $002EA4
        BEQ.S  .loc_0012                        ; $002EA8
        MOVE.L  (-14512).W,$0024(A1)            ; $002EAA
.loc_0012:
        RTS                                     ; $002EB0
