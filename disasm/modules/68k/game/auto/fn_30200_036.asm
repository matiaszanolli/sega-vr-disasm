; ============================================================================
; Fm 036 (auto-analyzed)
; ROM Range: $030F90-$030FA2 (18 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5): +$0C
;
; Entry: A5 = object/entity pointer
; Uses: A5
; Object fields:
;   +$0C: [unknown]
; Confidence: low
; ============================================================================

fn_30200_036:
        SUBQ.B  #2,$000C(A5)                    ; $030F90
        BSET    #1,(A5)                         ; $030F94
        DC.W    $6000,$0018         ; BRA.W  $030FB2; $030F98
        SUBQ.B  #2,$000C(A5)                    ; $030F9C
        RTS                                     ; $030FA0
