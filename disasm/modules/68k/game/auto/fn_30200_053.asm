; ============================================================================
; Fm 053 (auto-analyzed)
; ROM Range: $031406-$031418 (18 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5): +$01, +$0A (param_a)
;
; Entry: A5 = object/entity pointer
; Uses: D0, A4, A5
; Object fields:
;   +$01: [unknown]
;   +$0A: param_a
; Confidence: low
; ============================================================================

fn_30200_053:
        MOVE.B  (A4)+,D0                        ; $031406
        TST.B  $0001(A5)                        ; $031408
        DC.W    $6A00,$00E8         ; BPL.W  $0314F6; $03140C
        MOVE.B  D0,$000A(A5)                    ; $031410
        MOVE.B  (A4)+,D0                        ; $031414
        RTS                                     ; $031416
