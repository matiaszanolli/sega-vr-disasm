; ============================================================================
; Fm 012 (auto-analyzed)
; ROM Range: $03056A-$0305BA (80 bytes)
; ============================================================================
; Category: sound
; Purpose: Object (A6): +$09
;
; Entry: A6 = object/entity pointer
; Uses: D2, D6, D7, A0, A6
; Object fields:
;   +$09: [unknown]
; Confidence: low
; ============================================================================

fn_30200_012:
        MOVEQ   #$00,D7                         ; $03056A
        MOVE.B  $0009(A6),D7                    ; $03056C
        DC.W    $6700,$0684         ; BEQ.W  $030BF6; $030570
        MOVE.B  #$80,$0009(A6)                  ; $030574
        CMPI.B  #$80,D7                         ; $03057A
        BEQ.S  .loc_004E                        ; $03057E
        DC.W    $6500,$060E         ; BCS.W  $030B90; $030580
        CMPI.B  #$9F,D7                         ; $030584
        DC.W    $6300,$0092         ; BLS.W  $03061C; $030588
        CMPI.B  #$A0,D7                         ; $03058C
        BCS.W  .loc_004E                        ; $030590
        CMPI.B  #$D2,D7                         ; $030594
        DC.W    $6300,$01FE         ; BLS.W  $030798; $030598
        CMPI.B  #$D6,D7                         ; $03059C
        BCS.W  .loc_004E                        ; $0305A0
        CMPI.B  #$D8,D7                         ; $0305A4
        DC.W    $6500,$02E8         ; BCS.W  $030892; $0305A8
        CMPI.B  #$F0,D7                         ; $0305AC
        DC.W    $6552               ; BCS.S  $030604; $0305B0
        CMPI.B  #$FF,D7                         ; $0305B2
        DC.W    $6302               ; BLS.S  $0305BA; $0305B6
.loc_004E:
        RTS                                     ; $0305B8
