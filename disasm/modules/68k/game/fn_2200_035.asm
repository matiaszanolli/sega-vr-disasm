; ============================================================================
; Vint 035 (auto-analyzed)
; ROM Range: $002EB2-$002EC6 (20 bytes)
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

fn_2200_035:
        MOVE.L  (-14504).W,$0024(A1)            ; $002EB2
        TST.W  $008A(A0)                        ; $002EB8
        BEQ.S  .loc_0012                        ; $002EBC
        MOVE.L  (-14492).W,$0024(A1)            ; $002EBE
.loc_0012:
        RTS                                     ; $002EC4
