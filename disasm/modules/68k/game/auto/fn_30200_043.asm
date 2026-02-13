; ============================================================================
; Fm 043 (auto-analyzed)
; ROM Range: $0311B8-$0311D8 (32 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5): +$01, +$27
;
; Entry: A5 = object/entity pointer
; Uses: D0, D1, A4, A5
; Object fields:
;   +$01: [unknown]
;   +$27: [unknown]
; Confidence: low
; ============================================================================

fn_30200_043:
        MOVE.B  (A4)+,D1                        ; $0311B8
        TST.B  $0001(A5)                        ; $0311BA
        BMI.S  .loc_001E                        ; $0311BE
        MOVE.B  $0027(A5),D0                    ; $0311C0
        ANDI.B  #$37,D0                         ; $0311C4
        DC.W    $8200                           ; $0311C8
        MOVE.B  D1,$0027(A5)                    ; $0311CA
        MOVE.B  #$B4,D0                         ; $0311CE
        DC.W    $6000,$FACE         ; BRA.W  $030CA2; $0311D2
.loc_001E:
        RTS                                     ; $0311D6
