; ============================================================================
; Fm 041 (auto-analyzed)
; ROM Range: $03117C-$031188 (12 bytes)
; ============================================================================
; Category: sound
; Purpose: Small leaf function
;   Object (A5): +$1E
;
; Entry: A5 = object/entity pointer
; Uses: D0, A4, A5
; Object fields:
;   +$1E: [unknown]
; Confidence: low
; ============================================================================

fn_30200_041:
        MOVE.B  (A4)+,D0                        ; $03117C
        LSL.W  #8,D0                            ; $03117E
        MOVE.B  (A4)+,D0                        ; $031180
        MOVE.W  D0,$001E(A5)                    ; $031182
        RTS                                     ; $031186
