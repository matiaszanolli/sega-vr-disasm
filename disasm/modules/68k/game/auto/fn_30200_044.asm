; ============================================================================
; Fm 044 (auto-analyzed)
; ROM Range: $0311E2-$0311E8 (6 bytes)
; ============================================================================
; Category: sound
; Purpose: Small leaf function
;   Object (A6): +$03
;
; Entry: A6 = object/entity pointer
; Uses: A4, A6
; Object fields:
;   +$03: [unknown]
; Confidence: low
; ============================================================================

fn_30200_044:
        MOVE.B  (A4)+,$0003(A6)                 ; $0311E2
        RTS                                     ; $0311E6
