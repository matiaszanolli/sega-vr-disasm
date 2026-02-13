; ============================================================================
; Fm Dispatch 039 (auto-analyzed)
; ROM Range: $030FE0-$031166 (390 bytes)
; ============================================================================
; Category: sound
; Purpose: State dispatcher using jump table
;   Object (A1, A4, A5, A6): +$09, +$16 (calc_speed), +$18, +$28, +$65, +$69
;
; Entry: A1 = object/entity pointer
; Entry: A4 = object/entity pointer
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D3, D4, D5, D7, A0, A1
; Object fields:
;   +$09: [unknown]
;   +$16: calc_speed
;   +$18: [unknown]
;   +$28: [unknown]
;   +$65: [unknown]
;   +$69: [unknown]
; Confidence: low
; ============================================================================

fn_30200_039:
        BCHG    D1,(A6)                         ; $030FE0
        BTST    D1,-(A6)                        ; $030FE2
        DC.W    $02F9                           ; $030FE4
        DC.W    $02CE                           ; $030FE6
        ANDI.L  #$0280025C,-(A5)                ; $030FE8
        DC.W    $023A                           ; $030FEE
        DC.W    $021A                           ; $030FF0
        DC.W    $01FB                           ; $030FF2
        BSET    D0,(A7)+                        ; $030FF4
        BSET    D0,D4                           ; $030FF6
        BCLR    D0,$0193(A3)                    ; $030FF8
        DC.W    $017D                           ; $030FFC
        BCHG    D0,-(A7)                        ; $030FFE
        BCHG    D0,(A3)                         ; $031000
        BCHG    D0,D0                           ; $031002
        BTST    D0,$011D(A6)                    ; $031004
        DC.W    $010D                           ; $031008
        DC.W    $00FE                           ; $03100A
        DC.W    $00EF                           ; $03100C
        DC.W    $00E2                           ; $03100E
        DC.W    $00D6                           ; $031010
        DC.W    $00C9                           ; $031012
        DC.W    $00BE                           ; $031014
        ORI.L  #$00A900A0,-$69(A4,D0.W)         ; $031016
        DC.W    $008F                           ; $03101E
        ORI.L  #$007F0078,D7                    ; $031020
        ORI.W  #$006B,$65(A1,D0.W)              ; $031026
        ORI.W  #$005A,(A7)+                     ; $03102C
        ORI.W  #$0050,(A5)                      ; $031030
        DC.W    $004B                           ; $031034
        ORI.W  #$0043,D7                        ; $031036
        ORI.W  #$003C,D0                        ; $03103A
        ORI.B  #$36,$00330030                   ; $03103E
        ORI.B  #$2B,$0028(A5)                   ; $031046
        ORI.B  #$24,-(A6)                       ; $03104C
        ORI.B  #$20,-(A2)                       ; $031050
        ORI.B  #$1D,(A7)+                       ; $031054
        ORI.B  #$1A,(A3)+                       ; $031058
        ORI.B  #$17,(A0)+                       ; $03105C
        ORI.B  #$15,(A6)                        ; $031060
        ORI.B  #$12,(A3)                        ; $031064
        ORI.B  #$10,(A1)                        ; $031068
        DC.W    $000F                           ; $03106C
        DC.W    $000E                           ; $03106E
        DC.W    $000D                           ; $031070
        DC.W    $000C                           ; $031072
        DC.W    $000B                           ; $031074
        DC.W    $000A                           ; $031076
        DC.W    $0009                           ; $031078
        DC.W    $0008                           ; $03107A
        ORI.B  #$06,D7                          ; $03107C
        ORI.B  #$04,D5                          ; $031080
        ORI.B  #$02,D3                          ; $031084
        ORI.B  #$00,D1                          ; $031088
        ORI.B  #$00,D0                          ; $03108C
        ORI.B  #$00,D0                          ; $031090
        SUBI.W  #$00E0,D5                       ; $031094
        LSL.W  #2,D5                            ; $031098
        JMP     $03109E(PC,D5.W)                ; $03109A
        DC.W    $6000,$0118         ; BRA.W  $0311B8; $03109E
        DC.W    $6000,$0134         ; BRA.W  $0311D8; $0310A2
        DC.W    $6000,$013A         ; BRA.W  $0311E2; $0310A6
        DC.W    $6000,$013C         ; BRA.W  $0311E8; $0310AA
        DC.W    $6000,$0140         ; BRA.W  $0311F0; $0310AE
        DC.W    $6000,$0164         ; BRA.W  $031218; $0310B2
        DC.W    $6000,$0170         ; BRA.W  $031228; $0310B6
        DC.W    $6000,$017E         ; BRA.W  $03123A; $0310BA
        DC.W    $6000,$0180         ; BRA.W  $031240; $0310BE
        DC.W    $6000,$0186         ; BRA.W  $03124A; $0310C2
        DC.W    $6000,$01D4         ; BRA.W  $03129C; $0310C6
        DC.W    $6000,$01DA         ; BRA.W  $0312A6; $0310CA
        DC.W    $6000,$01DC         ; BRA.W  $0312AC; $0310CE
        DC.W    $6000,$01E0         ; BRA.W  $0312B4; $0310D2
        DC.W    $6000,$01E4         ; BRA.W  $0312BC; $0310D6
        DC.W    $6000,$01E8         ; BRA.W  $0312C4; $0310DA
        DC.W    $6000,$0302         ; BRA.W  $0313E2; $0310DE
        DC.W    $6000,$0322         ; BRA.W  $031406; $0310E2
        DC.W    $6000,$0330         ; BRA.W  $031418; $0310E6
        DC.W    $6000,$03F0         ; BRA.W  $0314DC; $0310EA
        DC.W    $6000,$0406         ; BRA.W  $0314F6; $0310EE
        DC.W    $6000,$0408         ; BRA.W  $0314FC; $0310F2
        DC.W    $6000,$040A         ; BRA.W  $031502; $0310F6
        DC.W    $6000,$0412         ; BRA.W  $03150E; $0310FA
        DC.W    $6000,$0428         ; BRA.W  $031528; $0310FE
        DC.W    $6000,$0436         ; BRA.W  $03153A; $031102
        DC.W    $6000,$0446         ; BRA.W  $03154E; $031106
        DC.W    $6000,$0448         ; BRA.W  $031554; $03110A
        DC.W    $6000,$044C         ; BRA.W  $03155C; $03110E
        DC.W    $6000,$0450         ; BRA.W  $031564; $031112
        DC.W    $6000,$0454         ; BRA.W  $03156C; $031116
        MOVEQ   #$00,D0                         ; $03111A
        MOVE.B  (A4)+,D0                        ; $03111C
        LSL.W  #2,D0                            ; $03111E
        JMP     $031124(PC,D0.W)                ; $031120
        DC.W    $6000,$044E         ; BRA.W  $031574; $031124
        DC.W    $6000,$046E         ; BRA.W  $031598; $031128
        DC.W    $6000,$0522         ; BRA.W  $031650; $03112C
        DC.W    $6000,$0534         ; BRA.W  $031666; $031130
        DC.W    $6000,$054A         ; BRA.W  $031680; $031134
        DC.W    $6000,$004E         ; BRA.W  $031188; $031138
        DC.W    $6000,$003E         ; BRA.W  $03117C; $03113C
        DC.W    $6000,$0024         ; BRA.W  $031166; $031140
        MOVEQ   #$00,D0                         ; $031144
        MOVE.B  (A4)+,D0                        ; $031146
        MOVE.B  $18(A6,D0.W),D1                 ; $031148
        TST.B  $16(A6,D0.W)                     ; $03114C
        BEQ.S  .loc_0184                        ; $031150
        BPL.S  .loc_0176                        ; $031152
        NEG.B  D1                               ; $031154
.loc_0176:
        ADD.B  D1,$0009(A5)                     ; $031156
        MOVEQ   #$00,D1                         ; $03115A
        MOVE.B  D1,$16(A6,D0.W)                 ; $03115C
        DC.W    $6000,$01F8         ; BRA.W  $03135A; $031160
.loc_0184:
        RTS                                     ; $031164
