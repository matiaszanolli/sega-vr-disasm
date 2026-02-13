; ============================================================================
; FM Sound Command Dispatcher — route command byte to handler
; ROM Range: $03056A-$0305BA (80 bytes)
; ============================================================================
; Reads sound command byte from A6+$09, dispatches to appropriate handler
; based on value range. Clears command after reading ($80 = sentinel).
; Command ranges:
;   $80      = stop/silence -> $030BF6
;   $81-$9F  = note-on -> $030B90
;   $A0-$D2  = instrument select -> $03061C
;   $D6-$D7  = special effect -> $030892
;   $F0-$FE  = system commands -> $030604
;   Others   = ignored (RTS)
;
; Entry: A6 = sound channel state (+$09=command byte)
; Uses: D2, D6, D7, A0, A6
; Confidence: medium
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
