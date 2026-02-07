; ============================================================================
; Camera 039 (auto-analyzed)
; ROM Range: $013FE0-$01418E (430 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A3): +$00
;
; Entry: A3 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, A0, A1, A2
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_12200_039:
        TST.W  D3                               ; $013FE0
        BNE.W  .loc_016C                        ; $013FE2
        BTST    #7,D1                           ; $013FE6
        BNE.W  .loc_015C                        ; $013FEA
        MOVE.B  D1,D3                           ; $013FEE
        ANDI.B  #$60,D3                         ; $013FF0
        BNE.W  .loc_0126                        ; $013FF4
        BTST    #4,D1                           ; $013FF8
        BNE.W  .loc_014C                        ; $013FFC
        BTST    #0,D1                           ; $014000
        BEQ.S  .loc_003E                        ; $014004
        TST.W  (A4)                             ; $014006
        BEQ.W  .loc_0082                        ; $014008
        MOVE.B  #$A9,(-14172).W                 ; $01400C
        SUBQ.B  #1,(A3)                         ; $014012
        BCC.W  .loc_01AC                        ; $014014
        CLR.B  (A3)                             ; $014018
        BRA.W  .loc_01AC                        ; $01401A
.loc_003E:
        BTST    #1,D1                           ; $01401E
        BEQ.S  .loc_0082                        ; $014022
        TST.W  (A4)                             ; $014024
        BEQ.W  .loc_0082                        ; $014026
        MOVE.B  #$A9,(-14172).W                 ; $01402A
        ADDQ.B  #1,(A3)                         ; $014030
        MOVE.B  (A3),D3                         ; $014032
        MOVE.B  #$04,D4                         ; $014034
        TST.W  D0                               ; $014038
        BEQ.S  .loc_0060                        ; $01403A
        MOVE.B  #$07,D4                         ; $01403C
.loc_0060:
        CMP.B  D4,D3                            ; $014040
        BLE.W  .loc_0068                        ; $014042
        MOVE.B  D4,(A3)                         ; $014046
.loc_0068:
        LEA     (-24549).W,A4                   ; $014048
        TST.W  D2                               ; $01404C
        BEQ.S  .loc_0074                        ; $01404E
        LEA     (-24548).W,A4                   ; $014050
.loc_0074:
        MOVE.B  (A3),D0                         ; $014054
        CMP.B  (A4),D0                          ; $014056
        BLT.W  .loc_01AC                        ; $014058
        MOVE.B  D0,(A4)                         ; $01405C
        BRA.W  .loc_01AC                        ; $01405E
.loc_0082:
        BTST    #2,D1                           ; $014062
        BEQ.S  .loc_00D2                        ; $014066
        MOVE.B  #$A9,(-14172).W                 ; $014068
        TST.W  (A4)                             ; $01406E
        BNE.W  .loc_00A2                        ; $014070
        SUBQ.B  #1,(A0)                         ; $014074
        BCC.W  .loc_016C                        ; $014076
        MOVE.B  #$06,(A0)                       ; $01407A
        BRA.W  .loc_016C                        ; $01407E
.loc_00A2:
        LEA     (-24549).W,A4                   ; $014082
        TST.W  D2                               ; $014086
        BEQ.S  .loc_00AE                        ; $014088
        LEA     (-24548).W,A4                   ; $01408A
.loc_00AE:
        DC.W    $6100,$00FE         ; BSR.W  $01418E; $01408E
        SUBQ.B  #1,(A4)                         ; $014092
        MOVE.B  (A4),D3                         ; $014094
        CMP.B  (A3),D3                          ; $014096
        BGE.W  .loc_00CA                        ; $014098
        MOVE.B  #$04,(A4)                       ; $01409C
        TST.W  D0                               ; $0140A0
        BEQ.W  .loc_00CA                        ; $0140A2
        MOVE.B  #$07,(A4)                       ; $0140A6
.loc_00CA:
        DC.W    $6100,$00E2         ; BSR.W  $01418E; $0140AA
        BRA.W  .loc_01AC                        ; $0140AE
.loc_00D2:
        BTST    #3,D1                           ; $0140B2
        BEQ.W  .loc_01AC                        ; $0140B6
        MOVE.B  #$A9,(-14172).W                 ; $0140BA
        TST.W  (A4)                             ; $0140C0
        BNE.W  .loc_00F6                        ; $0140C2
        ADDQ.B  #1,(A0)                         ; $0140C6
        CMPI.B  #$06,(A0)                       ; $0140C8
        BLE.W  .loc_016C                        ; $0140CC
        CLR.B  (A0)                             ; $0140D0
        BRA.W  .loc_016C                        ; $0140D2
.loc_00F6:
        LEA     (-24549).W,A4                   ; $0140D6
        TST.W  D2                               ; $0140DA
        BEQ.S  .loc_0102                        ; $0140DC
        LEA     (-24548).W,A4                   ; $0140DE
.loc_0102:
        DC.W    $6100,$00AA         ; BSR.W  $01418E; $0140E2
        ADDQ.B  #1,(A4)                         ; $0140E6
        MOVE.B  #$04,D3                         ; $0140E8
        TST.W  D0                               ; $0140EC
        BEQ.W  .loc_0116                        ; $0140EE
        MOVE.B  #$07,D3                         ; $0140F2
.loc_0116:
        CMP.B  (A4),D3                          ; $0140F6
        BGE.W  .loc_011E                        ; $0140F8
        MOVE.B  (A3),(A4)                       ; $0140FC
.loc_011E:
        DC.W    $6100,$008E         ; BSR.W  $01418E; $0140FE
        BRA.W  .loc_01AC                        ; $014102
.loc_0126:
        CMPI.B  #$06,(A0)                       ; $014106
        BNE.W  .loc_01AC                        ; $01410A
        TST.W  (A4)                             ; $01410E
        BNE.W  .loc_01AC                        ; $014110
        MOVE.W  #$0001,(A4)                     ; $014114
        CLR.B  (A3)                             ; $014118
        LEA     (-24549).W,A4                   ; $01411A
        TST.W  D2                               ; $01411E
        BEQ.S  .loc_0146                        ; $014120
        LEA     (-24548).W,A4                   ; $014122
.loc_0146:
        CLR.B  (A4)                             ; $014126
        BRA.W  .loc_01AC                        ; $014128
.loc_014C:
        CLR.W  (A4)                             ; $01412C
        MOVE.W  #$0007,D0                       ; $01412E
.loc_0152:
        MOVE.B  (A1)+,(A2)+                     ; $014132
        DBRA    D0,.loc_0152                    ; $014134
        BRA.W  .loc_01AC                        ; $014138
.loc_015C:
        MOVE.B  #$A8,(-14172).W                 ; $01413C
        MOVE.W  #$0001,(-24546).W               ; $014142
        BRA.W  .loc_01AC                        ; $014148
.loc_016C:
        CMPI.B  #$06,(A0)                       ; $01414C
        BNE.S  .loc_017C                        ; $014150
        MOVEA.L A2,A3                           ; $014152
        MOVE.W  #$0007,D2                       ; $014154
        BRA.W  .loc_01A6                        ; $014158
.loc_017C:
        CLR.W  D3                               ; $01415C
        MOVE.B  (A0),D3                         ; $01415E
        DC.W    $D643                           ; $014160
        DC.W    $D643                           ; $014162
        DC.W    $D643                           ; $014164
        LEA     $0089AB8E,A3                    ; $014166
        LEA     $00(A3,D3.W),A3                 ; $01416C
        MOVE.W  #$0004,D2                       ; $014170
        TST.W  D0                               ; $014174
        BEQ.S  .loc_01A6                        ; $014176
        LEA     $0089ABBE,A3                    ; $014178
        LEA     $00(A3,D3.W),A3                 ; $01417E
        MOVE.W  #$0007,D2                       ; $014182
.loc_01A6:
        MOVE.B  (A3)+,(A1)+                     ; $014186
        DBRA    D2,.loc_01A6                    ; $014188
.loc_01AC:
        RTS                                     ; $01418C
