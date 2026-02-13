; ============================================================================
; Fm 046 (auto-analyzed)
; ROM Range: $03120C-$031228 (28 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5): +$01, +$09, +$27
;
; Entry: A5 = object/entity pointer
; Uses: D0, D1, A4, A5
; Object fields:
;   +$01: [unknown]
;   +$09: [unknown]
;   +$27: [unknown]
; Confidence: low
; ============================================================================

fn_30200_046:
        MOVE.B  #$B4,D0                         ; $03120C
        MOVE.B  $0027(A5),D1                    ; $031210
        DC.W    $6000,$FA8C         ; BRA.W  $030CA2; $031214
        MOVE.B  (A4)+,D0                        ; $031218
        TST.B  $0001(A5)                        ; $03121A
        DC.W    $6A08               ; BPL.S  $031228; $03121E
        ADD.B  D0,$0009(A5)                     ; $031220
        ADDQ.W  #1,A4                           ; $031224
        RTS                                     ; $031226
