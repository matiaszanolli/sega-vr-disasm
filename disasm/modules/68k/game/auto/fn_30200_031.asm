; ============================================================================
; Fm 031 (auto-analyzed)
; ROM Range: $030DEE-$030DF4 (6 bytes)
; ============================================================================
; Category: sound
; Purpose: Small leaf function
;   Object (A6): +$38
;
; Entry: A6 = object/entity pointer
; Uses: A6
; Object fields:
;   +$38: [unknown]
; Confidence: low
; ============================================================================

fn_30200_031:
        CLR.B  $0038(A6)                        ; $030DEE
        RTS                                     ; $030DF2
