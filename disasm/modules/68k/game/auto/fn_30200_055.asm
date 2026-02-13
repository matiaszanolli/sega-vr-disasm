; ============================================================================
; Fm 055 (auto-analyzed)
; ROM Range: $0314F6-$0314FC (6 bytes)
; ============================================================================
; Category: sound
; Purpose: Small leaf function
;   Object (A5): +$0A (param_a)
;
; Entry: A5 = object/entity pointer
; Uses: A4, A5
; Object fields:
;   +$0A: param_a
; Confidence: low
; ============================================================================

fn_30200_055:
        MOVE.B  (A4)+,$000A(A5)                 ; $0314F6
        RTS                                     ; $0314FA
