; ============================================================================
; Fm 056 (auto-analyzed)
; ROM Range: $0314FC-$031502 (6 bytes)
; ============================================================================
; Category: sound
; Purpose: Small leaf function
;   Object (A5): +$0B
;
; Entry: A5 = object/entity pointer
; Uses: A4, A5
; Object fields:
;   +$0B: [unknown]
; Confidence: low
; ============================================================================

fn_30200_056:
        MOVE.B  (A4)+,$000B(A5)                 ; $0314FC
        RTS                                     ; $031500
