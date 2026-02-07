; ============================================================================
; Fm 035 (auto-analyzed)
; ROM Range: $030F82-$030F90 (14 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5): +$12 (timer_12), +$13
;
; Entry: A5 = object/entity pointer
; Uses: A5
; Object fields:
;   +$12: timer_12
;   +$13: [unknown]
; Confidence: low
; ============================================================================

fn_30200_035:
        TST.B  $0013(A5)                        ; $030F82
        DC.W    $67EA               ; BEQ.S  $030F72; $030F86
        TST.B  $0012(A5)                        ; $030F88
        DC.W    $66E4               ; BNE.S  $030F72; $030F8C
        RTS                                     ; $030F8E
