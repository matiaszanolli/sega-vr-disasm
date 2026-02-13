; ============================================================================
; Fm 059 (auto-analyzed)
; ROM Range: $03154E-$031554 (6 bytes)
; ============================================================================
; Category: sound
; Purpose: Small leaf function
;   Object (A5): +$02 (flags/type)
;
; Entry: A5 = object/entity pointer
; Uses: A4, A5
; Object fields:
;   +$02: flags/type
; Confidence: low
; ============================================================================

fn_30200_059:
        MOVE.B  (A4)+,$0002(A5)                 ; $03154E
        RTS                                     ; $031552
