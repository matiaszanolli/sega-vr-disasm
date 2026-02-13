; ============================================================================
; Fm 047 (auto-analyzed)
; ROM Range: $031228-$031240 (24 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5, A6): +$08, +$09
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, A4, A5, A6
; Object fields:
;   +$08: [unknown]
;   +$09: [unknown]
; Confidence: low
; ============================================================================

fn_30200_047:
        MOVE.B  (A4)+,D0                        ; $031228
        ADD.B  D0,$0009(A5)                     ; $03122A
        TST.B  $0008(A6)                        ; $03122E
        DC.W    $6B00,$FBC0         ; BMI.W  $030DF4; $031232
        DC.W    $6000,$0122         ; BRA.W  $03135A; $031236
        BSET    #4,(A5)                         ; $03123A
        RTS                                     ; $03123E
