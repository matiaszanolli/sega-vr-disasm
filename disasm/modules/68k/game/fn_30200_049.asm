; ============================================================================
; Fm 049 (auto-analyzed)
; ROM Range: $0312A6-$0312AC (6 bytes)
; ============================================================================
; Category: sound
; Purpose: Small leaf function
;   Object (A6): +$0A (param_a)
;
; Entry: A6 = object/entity pointer
; Uses: A4, A6
; Object fields:
;   +$0A: param_a
; Confidence: low
; ============================================================================

fn_30200_049:
        MOVE.B  (A4)+,$000A(A6)                 ; $0312A6
        RTS                                     ; $0312AA
