; Generated assembly for $106200-$108200
; Branch targets: 132
; Labels: 127
; Format: DC.W with decoded mnemonics as comments

        org     $106200

        SUB.B  D1,$24(A3,D4.W)                  ; $106200
        OR.B   (A3)+,D1                         ; $106204
        BCC.S  $1061CB                          ; $106206
        ADD.B  D0,(A2)                          ; $106208
        MOVE.L  (A2)+,(A6)                      ; $10620A
        MOVE.L  -(A2),D1                        ; $10620C
        DIVU    -$3F(A1,D2.W),D4                ; $10620E
        MOVE.L  -$0C68(A4),-(A0)                ; $106212
        MOVE.W  (A1)+,(A2)                      ; $106216
        BNE.S  loc_106245                       ; $106218
        BNE.S  $1061A0                          ; $10621A
        BTST    D0,$31AC(A1)                    ; $10621C
        BCC.S  loc_106255                       ; $106220
        AND.L  D2,D1                            ; $106222
        MOVE.B  -(A0),-(A0)                     ; $106224
        DC.W    $DEFF               ; $106226 ADDA.W  <EA:3F>,A7
        CMP.W  -$31(A0,D5.L),D5                 ; $106228
        MOVE.W  (A1),(A7)                       ; $10622C
        DC.W    $46FF               ; $10622E NOT    <EA:3F>
        LSR.B  #1,D7                            ; $106230
        MOVE.W  -(A2),-(A0)                     ; $106232
        MOVE.L  #$E1F470CD,-(A1)                ; $106234
        DC.W    $FFF1,$4321         ; $10623A MOVE.W  $21(A1,D4.W),<EA:3F>
        MOVEA.L A6,A2                           ; $10623E
        MOVE.B  (A2),-(A0)                      ; $106240
        MOVE.L  -(A0),-(A1)                     ; $106242
        ORI.W  #$B08E,(A6)                      ; $106244
        AND.B  D0,D2                            ; $106248
        MOVE.W  (A4)+,-$3C(A0,D0.L)             ; $10624A
        SUB.W  D4,$2236(A5)                     ; $10624E
        OR.W   A1,D1                            ; $106252
        MOVEA.B -$0E6F(A4),A1                   ; $106254
        MOVE.B  (A3)+,$0FA0(A4)                 ; $106258
        ROL.W  (A1)                             ; $10625C
        MOVE.L  (A1),-(A0)                      ; $10625E
        SUB.B  D1,-$43(A6,A6.W)                 ; $106260
        NEGX   (A2)                             ; $106264
        DC.W    $0000,$FEF2         ; $106266 ORI.B  #$FEF2,D0
        DC.W    $D3FF               ; $10626A ADDA.L  <EA:3F>,A1
        MOVE.L  $64(A0,D0.W),(A1)+              ; $10626C
        AND.L  (A3),D3                          ; $106270
        MOVE.W  (A1)+,$29(A0,D1.W)              ; $106272
        ROXR.W  (A4)                            ; $106276
        MOVE.B  D5,(A7)+                        ; $106278
        LSL.W  -(A1)                            ; $10627A
        MOVE.W  D4,(A6)                         ; $10627C
        MOVE.W  $6653(A2),(A2)+                 ; $10627E
        ADD.B  D4,(A1)                          ; $106282
        MOVEA.B -(A4),A3                        ; $106284
        ADDQ.L  #2,-(A1)                        ; $106286
        ADD.L  -$0EE4(A4),D0                    ; $106288
        MOVEA.W -$1DC7(A3),A2                   ; $10628C
        LSR.W  (A7)+                            ; $106290
        OR.B   A0,D4                            ; $106292
        BRA.S  loc_106301                       ; $106294
        DIVU    (A7),D5                         ; $106296
        MULU    (A5)+,D0                        ; $106298
        DC.W    $ADDA               ; $10629A MOVE.L  (A2)+,<EA:3E>
        MOVE.L  D0,D1                           ; $10629C
        MOVE.B  (A6),(A0)                       ; $10629E
        ADDQ.L  #8,(A7)+                        ; $1062A0
        NEG    $08(A1,D0.W)                     ; $1062A2
        MOVE.W  $74(A4,D7.L),-(A7)              ; $1062A6
        ROR.L  #3,D7                            ; $1062AA
        SUB.B  D2,D2                            ; $1062AC
        DC.W    $F3FB,$41FB,$13FA,$1422; $1062AE MOVE.W  -$05(PC,D4.W),$13FA1422
        BMI.S  loc_1062F9                       ; $1062B6
        BSET    #20,$20(A1,A3.L)                ; $1062B8
        DC.W    $22FF               ; $1062BE MOVE.L  <EA:3F>,(A1)+
        ADDA.L  -$32E6(PC),A0                   ; $1062C0
        BSET    D1,(A2)+                        ; $1062C4
        DC.W    $FBFC,$33F2         ; $1062C6 MOVE.W  #$33F2,<EA:3D>
        MOVE.L  D1,-(A0)                        ; $1062CA
        DC.W    $4502               ; $1062CC DC.W    $4502
        BCHG    D4,D4                           ; $1062CE
        MOVE.W  -(A3),(A5)+                     ; $1062D0
        MOVE.L  (A4),D5                         ; $1062D2
        BSET    D1,-$03(A7,A7.L)                ; $1062D4
        MOVE.W  (A4),-(A0)                      ; $1062D8
        SUB.B  D4,D2                            ; $1062DA
        DC.W    $02F7               ; $1062DC DC.W    $02F7
        MOVE.B  $5CC0(A1),-(A1)                 ; $1062DE
        OR.B   D0,D0                            ; $1062E2
        MOVE.W  -$13(A0,D2.W),-$75F5(A3)        ; $1062E4
        MOVE.W  (A0)+,D6                        ; $1062EA
        MOVE.W  (A4),$8D23.W                    ; $1062EC
        DC.W    $4114               ; $1062F0 DC.W    $4114
        OR.L   D5,(A4)+                         ; $1062F2
        DC.W    $4818               ; $1062F4 DC.W    $4818
        SLE     -$17AE(A3)                      ; $1062F6
        MOVE.B  (A0)+,D2                        ; $1062FA
        MOVE.W  -$1C84(A1),(A0)+                ; $1062FC
        MOVEA.W D1,A4                           ; $106300
        BCLR    D4,D0                           ; $106302
        CMP.W  -(A6),D2                         ; $106304
        MOVE.W  (A3)+,(A6)+                     ; $106306
        MOVE.B  D4,-$50(A7,D4.L)                ; $106308
        MOVE.W  -$700E(A7),$47FD.W              ; $10630C
        BTST    #22,(A1)                        ; $106312
        MOVE.W  D3,-$0410(A5)                   ; $106316
        SUB.L  (A6)+,D1                         ; $10631A
        AND.W  D3,D2                            ; $10631C
        MOVEA.W D1,A3                           ; $10631E
        LEA     $1800(A1),A6                    ; $106320
        BCLR    D1,-(A0)                        ; $106324
        ROL.L  D4,D5                            ; $106326
        SUB.W  D5,(A4)                          ; $106328
        MOVE.W  (A3),$0C51.W                    ; $10632A
        MOVE.W  -(A5),-(A1)                     ; $10632E
        DC.W    $21BE,$25D9         ; $106330 MOVE.L  <EA:3E>,-$27(A0,D2.W)
        ST      $31(A5,D4.L)                    ; $106334
        DC.W    $FFFC,$5221         ; $106338 MOVE.W  #$5221,<EA:3F>
        DC.W    $433A               ; $10633C DC.W    $433A
        DC.W    $13FB,$1242,$784E,$8A34; $10633E MOVE.B  $42(PC,D1.W),$784E8A34
        SUB.B  $33(A2,D1.W),D3                  ; $106346
        MOVE.L  (A3),-(A1)                      ; $10634A
        CMPA.W  -(A0),A4                        ; $10634C
        ASL.B  D4,D1                            ; $10634E
        MOVE.W  A2,-$6D(A5,A7.W)                ; $106350
        MOVE.L  -(A4),D1                        ; $106354
        MOVE.B  A1,D0                           ; $106356
        MOVE.W  -(A2),(A4)+                     ; $106358
        EOR.B  D7,-(A1)                         ; $10635A
        MOVE.L  -$80(A0,D0.W),$3FF3(A3)         ; $10635C
        SUB.L  (A3),D4                          ; $106362
        OR.B   D0,D5                            ; $106364
        EOR.B  D6,-$0E(A1,A7.W)                 ; $106366
        MOVE.W  (A6),(A6)+                      ; $10636A
        MOVE.W  $43(A2,A7.L),-(A0)              ; $10636C
        MOVE.W  (A2),-(A5)                      ; $106370
        ADDQ.W  #7,-(A6)                        ; $106372
        BSET    D1,D2                           ; $106374
        ADDQ.L  #7,A0                           ; $106376
        DC.W    $3DF5,$1460         ; $106378 MOVE.W  $60(A5,D1.W),<EA:3E>
        MOVE.B  -$2E(A3,A6.L),-$1EEE(A2)        ; $10637C
        MULS    -(A1),D6                        ; $106382
        MULS    -$0D(A2,A3.L),D5                ; $106384
        MOVE.B  D2,-$201D(A2)                   ; $106388
        ROL.W  #4,D0                            ; $10638C
        AND.L  D1,A1                            ; $10638E
        NEG.B  (A3)                             ; $106390
        MOVE.B  D0,$3EFC0911                    ; $106392
        BSET    D0,$3214(A1)                    ; $106398
        MOVEA.W -(A4),A3                        ; $10639C
        OR.L   -(A0),D4                         ; $10639E
        ADDQ.B  #4,-$160C(A6)                   ; $1063A0
        SUB.B  $08(A1,A7.W),D2                  ; $1063A4
        MOVEA.L D3,A1                           ; $1063A8
        MOVE.W  -$68(PC,A0.L),$E17B.W           ; $1063AA
        MOVE.L  -(A2),-$3B9D(A4)                ; $1063B0
        ASR.B  D5,D7                            ; $1063B4
        MOVE.W  A6,-$7FBF(A0)                   ; $1063B6
        ADDQ.B  #8,A0                           ; $1063BA
        MOVE.W  D6,-(A5)                        ; $1063BC
        ASL.B  #4,D0                            ; $1063BE
        MOVE.W  D0,$15(A4,D3.W)                 ; $1063C0
loc_1063C4:
        MOVE.L  A2,D2                           ; $1063C4
        MOVE.W  -$0EBD(PC),-$08(A0,A7.W)        ; $1063C6
        DC.W    $19FE,$F728         ; $1063CC MOVE.B  <EA:3E>,#$F728
        DC.W    $0033,$60F5,$EA29   ; $1063D0 ORI.B  #$60F5,$29(A3,A6.L)
        MOVE.W  D4,D6                           ; $1063D6
        NEGX.W -$4B(A4,D4.W)                    ; $1063D8
        SUB.L  $50(A6,D5.W),D0                  ; $1063DC
        SVC     -$1C17(A1)                      ; $1063E0
        MOVE.W  -$570E(A4),(A7)+                ; $1063E4
        DC.W    $5E3F               ; $1063E8 ADDQ.B  #7,<EA:3F>
        MOVEA.W D5,A1                           ; $1063EA
        MOVE.W  D5,$7C(A6,D1.W)                 ; $1063EC
        MOVE.W  D0,D1                           ; $1063F0
        MOVE.W  $2446(A2),-$1F(A4,A6.L)         ; $1063F2
        MOVEA.L D0,A0                           ; $1063F8
        MOVE.W  -(A6),-$01(A4,A3.L)             ; $1063FA
        CLR.W  $1449(A4)                        ; $1063FE
        MOVEA.W $43(A2,A7.W),A3                 ; $106402
        DC.W    $4C17               ; $106406 DC.W    $4C17
        MOVE.W  (A2),-(A0)                      ; $106408
        BRA.S  loc_1063C4                       ; $10640A
        MOVE.B  -$4A(A4,A6.L),$52(A1,D2.W)      ; $10640C
        MOVE.B  -(A0),D1                        ; $106412
        ASR.W  $5BF6(A2)                        ; $106414
        MOVE.W  D4,-$0E8F(A7)                   ; $106418
        DC.W    $00C8               ; $10641C DC.W    $00C8
        AND.W  D4,D0                            ; $10641E
        CLR    $10(PC,A5.W)                     ; $106420
        CMP.W  -$530F(A5),D3                    ; $106424
        ROXR.B  #5,D6                           ; $106428
        MOVEQ   #$69,D2                         ; $10642A
        BVS.S  loc_1064A5                       ; $10642C
        BTST    D0,-$0F(A4,D0.L)                ; $10642E
        MOVE.W  D6,(A3)                         ; $106432
        SUB.L  D0,$E80BC9F2                     ; $106434
        BLS.S  loc_106496                       ; $10643A
        DC.W    $0D4B               ; $10643C BCHG    D6,A3
        MOVE.W  $316F(A1),-$2DA0(PC)            ; $10643E
        MULU    -$1DED(A6),D5                   ; $106444
        MOVEA.L A0,A1                           ; $106448
        BEQ.S  loc_10649B                       ; $10644A
        BVS.S  loc_1063E2                       ; $10644C
        ADDA.W  $00(A1,A5.W),A3                 ; $10644E
        MOVE.B  D1,-(A0)                        ; $106452
        ROXL.W  $29(PC,D2.W)                    ; $106454
        ORI.W  #$37AA,D2                        ; $106458
        AND.W  D1,D2                            ; $10645C
        CMP.W  D4,D3                            ; $10645E
        DC.W    $0003,$6694         ; $106460 ORI.B  #$6694,D3
        MULS    -(A2),D6                        ; $106464
        MOVE.B  A2,(A2)                         ; $106466
        SUB.W  D1,-(A4)                         ; $106468
        MOVE.W  -(A2),D0                        ; $10646A
        MOVE.W  #$3A33,(A6)+                    ; $10646C
        MOVE.W  -(A1),D6                        ; $106470
        SUBQ.W  #2,-(A0)                        ; $106472
        SVS     -$04(A1,D5.L)                   ; $106474
        MOVE.W  #$55F1,(A6)+                    ; $106478
        ROR.W  (A4)                             ; $10647C
        ST      D4                              ; $10647E
        MULS    (A0),D4                         ; $106480
        MOVE.W  (A6),(A1)                       ; $106482
        MOVE.W  (A3)+,D1                        ; $106484
        MOVE.L  D4,(A3)                         ; $106486
        SUB.B  (A3),D3                          ; $106488
        MOVE.L  (A4)+,(A4)+                     ; $10648A
        ADDA.W  -$54(A2,D2.W),A4                ; $10648C
        MOVEA.W D0,A3                           ; $106490
        SCC     (A7)                            ; $106492
        MOVE.W  -$0E70(A7),-(A3)                ; $106494
        MOVE.L  -$16(A2,A1.W),(A2)+             ; $106498
        MOVEA.B D2,A2                           ; $10649C
        SUBQ.B  #6,-$0E39(A4)                   ; $10649E
        MOVE.L  (A3),$3222(A1)                  ; $1064A2
        BTST    D0,(A3)                         ; $1064A6
        SVC     (A4)+                           ; $1064A8
        AND.W  -$7E40(A7),D5                    ; $1064AA
        ADDQ.W  #2,-(A2)                        ; $1064AE
        CMP.W  (A4),D6                          ; $1064B0
        DC.W    $C4FD               ; $1064B2 MULU    <EA:3D>,D2
        ADDQ.W  #8,$12FF(A3)                    ; $1064B4
        MOVEA.L A3,A1                           ; $1064B8
        ASL.B  #8,D7                            ; $1064BA
        ROXL.B  D5,D4                           ; $1064BC
        CMPA.W  -$0F(A1,A2.L),A3                ; $1064BE
        MOVE.B  D1,(A1)+                        ; $1064C2
        OR.B   -$252C(A1),D5                    ; $1064C4
        SGE     -(A1)                           ; $1064C8
        MOVE.B  A0,-(A1)                        ; $1064CA
        ROXL.L  #8,D4                           ; $1064CC
        LSL.B  D1,D2                            ; $1064CE
        OR.W   $6BE2(A7),D0                     ; $1064D0
        DC.W    $FFFD               ; $1064D4 MOVE.W  <EA:3D>,<EA:3F>
        MULS    -(A2),D3                        ; $1064D6
        ADD.L  D6,A2                            ; $1064D8
        MOVE.L  (A2)+,D0                        ; $1064DA
        CMPA.L  -(A1),A0                        ; $1064DC
        ROL.W  -$0D53(A7)                       ; $1064DE
        LSR.W  $70(A1,D3.W)                     ; $1064E2
        SUBI.B  #$8311,(A1)+                    ; $1064E6
        LEA     (A6),A3                         ; $1064EA
        MOVE.W  (A4),$502A(A3)                  ; $1064EC
        SGE     -$7516(A1)                      ; $1064F0
        ADD.B  D2,(A4)                          ; $1064F4
        LSR.B  #4,D4                            ; $1064F6
        DC.W    $FFFD               ; $1064F8 MOVE.W  <EA:3D>,<EA:3F>
        MOVEQ   #$00,D0                         ; $1064FA
        MOVE.L  $22(A6,A6.W),-(A2)              ; $1064FC
        MOVEA.L -(A4),A2                        ; $106500
        AND.B  -(A5),D6                         ; $106502
loc_106504:
        DC.W    $457A               ; $106504 DC.W    $457A
        ASL.W  (A0)+                            ; $106506
        MOVE.W  (A3),D4                         ; $106508
        DC.W    $FF7E,$E1A8         ; $10650A MOVE.W  <EA:3E>,-$1E58(A7)
        ROXL.L  D4,D2                           ; $10650E
        MOVE.W  A2,-(A3)                        ; $106510
        ADDA.L  $42(A6,D2.W),A5                 ; $106512
        CMPA.W  -$1A(A5,D2.W),A5                ; $106516
        MULU    $24A8(A1),D4                    ; $10651A
        CMP.L  (A5),D4                          ; $10651E
        LSR.W  -$28(A1,D7.L)                    ; $106520
        MOVE.W  D0,-(A0)                        ; $106524
        MOVE.W  D4,(A3)+                        ; $106526
        MOVE.L  (A0)+,(A2)+                     ; $106528
        MOVE.W  A5,(A1)+                        ; $10652A
        DC.W    $D6FF               ; $10652C ADDA.W  <EA:3F>,A3
        BLE.S  loc_106511                       ; $10652E
        SUBI.B  #$A1D1,A2                       ; $106530
        MOVE.B  (A2),D6                         ; $106534
        DC.W    $3BF1,$A9CA         ; $106536 MOVE.W  -$36(A1,A2.L),<EA:3D>
        MOVE.L  $3FF0(A0),(A5)                  ; $10653A
        LSL.W  D0,D4                            ; $10653E
        MOVE.W  (A0)+,-$16E6(PC)                ; $106540
        ROXR.W  (A6)+                           ; $106544
        MOVE.B  -(A1),(A7)+                     ; $106546
        MOVEA.B (A4),A5                         ; $106548
        ADDA.L  -(A2),A3                        ; $10654A
        ADDA.W  -(A1),A1                        ; $10654C
        MOVE.B  -(A2),(A2)+                     ; $10654E
        MOVE.L  $C7E2F3EB,(A1)+                 ; $106550
        LSR.W  $1454(A1)                        ; $106556
        MOVE.W  (A4),(A7)                       ; $10655A
        ASL.W  -$34(PC,D2.W)                    ; $10655C
        DC.W    $1BDA               ; $106560 MOVE.B  (A2)+,<EA:3D>
        MULU    -(A3),D1                        ; $106562
        ADDQ.B  #2,D4                           ; $106564
        ROXR.L  #4,D7                           ; $106566
        DC.W    $FDC8               ; $106568 MOVE.W  A0,<EA:3E>
        LSL.W  -(A0)                            ; $10656A
        MOVE.L  (A3),#$91C8E943                 ; $10656C
        ADDQ.B  #6,(A2)                         ; $106572
        DC.W    $4332               ; $106574 DC.W    $4332
        BLE.S  loc_106504                       ; $106576
        DC.W    $0A38,$51E1,$14EB   ; $106578 EORI.B  #$51E1,$14EB.W
        MOVEQ   #-$0F,D2                        ; $10657E
        ROXR.W  (A1)+                           ; $106580
        MOVE.L  (A0)+,D6                        ; $106582
        MOVEA.W (A4)+,A3                        ; $106584
loc_106586:
        CMPA.W  (A5)+,A2                        ; $106586
        DC.W    $FFFE               ; $106588 MOVE.W  <EA:3E>,<EA:3F>
        MOVE.L  -(A2),D1                        ; $10658A
        DC.W    $0149               ; $10658C BCHG    D0,A1
        ADD.W  D0,(A0)                          ; $10658E
        CMP.B  A0,D4                            ; $106590
        BSR.S  loc_106586                       ; $106592
        SUBQ.W  #2,-$17(A1,A6.W)                ; $106594
        DC.W    $00F1               ; $106598 DC.W    $00F1
        ADDA.W  $0DE0.W,A4                      ; $10659A
        MOVE.W  -$1C60(A0),$61(A3,D3.W)         ; $10659E
        OR.W   D3,-$0F(A0,A7.W)                 ; $1065A4
        DC.W    $4372               ; $1065A8 DC.W    $4372
        MOVE.W  D1,-$12DD(A5)                   ; $1065AA
        MOVE.B  -(A7),-$57D6(A1)                ; $1065AE
        ASR.W  #7,D7                            ; $1065B2
        CMPA.L  -$0F19(A1),A1                   ; $1065B4
        CMPA.L  -$0B0A(A2),A0                   ; $1065B8
        MOVEQ   #-$12,D6                        ; $1065BC
        MOVE.L  -(A1),(A0)+                     ; $1065BE
        SUBA.W  #$38D2,A6                       ; $1065C0
        BLS.S  loc_106634                       ; $1065C4
        MOVEA.B -(A4),A1                        ; $1065C6
        MOVE.W  D0,$41(PC,D3.W)                 ; $1065C8
        MOVE.B  D6,$57D1(A0)                    ; $1065CC
        DC.W    $13F3,$3236,$9495,$66C8; $1065D0 MOVE.B  $36(A3,D3.W),$949566C8
        BNE.S  loc_10660B                       ; $1065D8
        DC.W    $F3F1,$84FE,$AAA0,$1D64; $1065DA MOVE.W  -$02(A1,A0.W),$AAA01D64
        DC.W    $7BEA,$B6C9         ; $1065E2 MOVE.W  -$4937(A2),<EA:3D>
        BNE.S  loc_106659                       ; $1065E6
        DC.W    $CFFF               ; $1065E8 MULS    <EA:3F>,D7
        MOVE.W  $3CC0(A2),$2C(A1,A3.L)          ; $1065EA
        SVS     -$0DA4(PC)                      ; $1065F0
        ADDA.W  (A4),A3                         ; $1065F4
        MOVE.W  $52(A2,D5.W),(A7)+              ; $1065F6
        MOVE.L  -$0BF5(A2),D4                   ; $1065FA
        ADDA.L  $56(A4,A4.L),A4                 ; $1065FE
        ADD.W  D0,A5                            ; $106602
        AND.W  -(A5),D1                         ; $106604
        MOVE.W  -$25E3(A0),(A1)+                ; $106606
        BCHG    D6,$2114(A0)                    ; $10660A
        MOVE.L  (A7),D2                         ; $10660E
        DC.W    $0EEB               ; $106610 DC.W    $0EEB
        MOVE.B  A2,-(A3)                        ; $106612
        MOVE.L  A2,D5                           ; $106614
        MOVE.W  $6BC9(A2),(A3)+                 ; $106616
        EORI.W  #$D158,(A3)                     ; $10661A
        CMP.B  -$1D5C(A1),D5                    ; $10661E
        MOVE.L  (A0),D0                         ; $106622
        MOVE.W  A7,D4                           ; $106624
        MOVE.L  -$5F(PC,A6.L),D4                ; $106626
        MOVE.W  #$BAE3,$5571.W                  ; $10662A
        MOVE.W  $0C(A2,D3.W),(A6)+              ; $106630
loc_106634:
        LSL.W  -(A1)                            ; $106634
        MOVE.W  (A2),D0                         ; $106636
        MOVE.W  -$1F(A2,A7.L),$46(PC,A7.L)      ; $106638
        CLR.B  -(A3)                            ; $10663E
loc_106640:
        ADDQ.W  #3,(A6)                         ; $106640
        ASL.W  D0,D2                            ; $106642
        ASR.L  #7,D5                            ; $106644
        MOVEA.L (A4),A2                         ; $106646
        ASL.W  D0                               ; $106648
        ROXL.W  #4,D5                           ; $10664A
        LSL.W  #2,D4                            ; $10664C
        MOVE.W  A2,-$091A(A0)                   ; $10664E
        MOVE.W  A1,D0                           ; $106652
        SUBA.L  -$5F36(A3),A3                   ; $106654
        MOVE.W  (A1)+,$3FA87523                 ; $106658
        DC.W    $4F60               ; $10665E DC.W    $4F60
        ADD.L  D6,A2                            ; $106660
        ROXR.B  D3,D2                           ; $106662
        BRA.S  loc_106640                       ; $106664
        DC.W    $3DCA               ; $106666 MOVE.W  A2,<EA:3E>
        MOVEA.B D1,A3                           ; $106668
        SCS     (A0)                            ; $10666A
        MOVE.W  (A2)+,(A0)+                     ; $10666C
        ADD.L  -$32(A1,D7.L),D5                 ; $10666E
        ADDA.W  -$51(A1,A7.L),A2                ; $106672
        LSL.W  (A4)+                            ; $106676
        ADD.B  -$57DF(A2),D2                    ; $106678
        NEGX.W D0                               ; $10667C
        MOVE.B  $54(A4,D3.L),(A0)+              ; $10667E
loc_106682:
        MOVE.W  $3561(PC),#$6040                ; $106682
        BCLR    D4,-(A4)                        ; $106688
        EORI.W  #$480A,D3                       ; $10668A
        DC.W    $FA7D               ; $10668E MOVEA.W <EA:3D>,A5
        ADDQ.L  #1,A4                           ; $106690
        BSR.S  loc_106625                       ; $106692
        ADDQ.B  #8,A1                           ; $106694
        ASR.W  $105A.W                          ; $106696
        ADDQ.L  #8,-$279E(A0)                   ; $10669A
        MOVEA.L D0,A0                           ; $10669E
        MOVE.B  $40(A1,D2.W),-(A4)              ; $1066A0
        MOVE.B  D1,$32(A6,D7.W)                 ; $1066A4
        DC.W    $404B               ; $1066A8 NEGX.W A3
        SUBQ.W  #7,(A0)                         ; $1066AA
        NEGX.W D0                               ; $1066AC
        MOVE.B  $7737.W,$3340(A3)               ; $1066AE
        NEGX.B (A1)+                            ; $1066B4
        MOVE.L  D0,$4017(A6)                    ; $1066B6
        CMP.W  A1,D2                            ; $1066BA
        ADDQ.W  #1,D0                           ; $1066BC
        MOVEM.L A5,D0/D1/D6/D7/A0/A3/A5         ; $1066BE
        SPL     -(A7)                           ; $1066C2
        OR.W   D7,(A4)                          ; $1066C4
        EOR.W  D4,$5447.W                       ; $1066C6
        MOVEA.W (A1),A0                         ; $1066CA
        MOVE.L  D2,$64D1(A0)                    ; $1066CC
loc_1066D0:
        MOVEA.L -$2672(A3),A1                   ; $1066D0
        BNE.S  loc_1066B8                       ; $1066D4
        BHI.S  loc_1066D0                       ; $1066D6
        MOVEA.L D2,A4                           ; $1066D8
        DC.W    $0031,$78AC,$DA5B   ; $1066DA ORI.B  #$78AC,$5B(A1,A5.L)
        MOVE.W  A0,-$7B(PC,A7.W)                ; $1066E0
        ADDQ.L  #6,D7                           ; $1066E4
        EOR.W  D1,$77(A6,D6.L)                  ; $1066E6
        AND.W  -$4460(A3),D2                    ; $1066EA
        OR.W   D3,$EE72.W                       ; $1066EE
        BVS.S  loc_106682                       ; $1066F2
        ROR.W  $0A(A0,A7.W)                     ; $1066F4
        ADDA.W  -(A0),A7                        ; $1066F8
        BHI.S  loc_10670B                       ; $1066FA
        MOVE.B  (A1)+,D0                        ; $1066FC
        SUBQ.L  #4,A6                           ; $1066FE
        NEG    -$1104(A6)                       ; $106700
        DC.W    $FFE4               ; $106704 MOVE.W  -(A4),<EA:3F>
        BTST    D2,(A4)                         ; $106706
        MOVE.W  A5,(A6)                         ; $106708
        DC.W    $F3FF,$A84F,$41FC   ; $10670A MOVE.W  <EA:3F>,$A84F41FC
        DC.W    $03CB               ; $106710 BSET    D1,A3
        SUB.W  D6,(A2)                          ; $106712
        ROR.W  -$1B1C(A0)                       ; $106714
        ROXL.W  $4EFE(A6)                       ; $106718
        MOVE.L  D0,(A6)                         ; $10671C
        LSR.W  -(A5)                            ; $10671E
        ROXL.W  -$53(A0,A7.W)                   ; $106720
        DC.W    $993F               ; $106724 SUB.B  D4,<EA:3F>
        MOVE.B  D1,(A6)                         ; $106726
        SUBQ.B  #8,$55(A3,A6.W)                 ; $106728
        ADDQ.W  #3,$55FF(A6)                    ; $10672C
        BNE.S  loc_106787                       ; $106730
        ASR.B  #7,D2                            ; $106732
        DC.W    $04F7               ; $106734 DC.W    $04F7
        SGT     -$12(A0,A7.L)                   ; $106736
        ROR.L  D0,D1                            ; $10673A
        BCLR    D6,$1E(A0,D3.W)                 ; $10673C
        MOVE.W  (A2),-(A3)                      ; $106740
        SF      -(A7)                           ; $106742
        SUBQ.W  #7,(A1)                         ; $106744
        ADDQ.B  #3,D1                           ; $106746
        MOVE.L  (A6)+,(A6)+                     ; $106748
        SVC     (A1)+                           ; $10674A
        ADD.W  D5,D7                            ; $10674C
        SF      $0742(A6)                       ; $10674E
        DC.W    $00A8,$FD6A,$564C,$51BC; $106752 ORI.L  #$FD6A564C,$51BC(A0)
        BSR.W  $10B7F0                          ; $10675A
        TST    -$6565(PC)                       ; $10675E
        OR.W   D3,$1B(A0,D6.W)                  ; $106762
        SUBI.L  #$52136052,(A7)                 ; $106766
        MOVE.W  -(A7),$B44A4110                 ; $10676C
        ST      -(A6)                           ; $106772
        EOR.W  D3,-(A1)                         ; $106774
        MOVE.W  (A4),$4C(PC,A1.W)               ; $106776
        BSET    D2,D1                           ; $10677A
        BTST    D2,-$6D0C(A2)                   ; $10677C
        MOVE.W  (A3)+,$64C0.W                   ; $106780
        MOVE.L  A1,-$57AC(A7)                   ; $106784
        MOVEQ   #-$33,D4                        ; $106788
        ADDQ.W  #5,(A7)                         ; $10678A
        ROXR.W  #6,D6                           ; $10678C
        MULS    $7949(A0),D7                    ; $10678E
        NEG.L  -$20(A5,D0.W)                    ; $106792
        DC.W    $C0FE               ; $106796 MULU    <EA:3E>,D0
        MULU    -$46(A3,A5.L),D7                ; $106798
        MOVE.W  -$5FE4(A2),-(A3)                ; $10679C
        TST    -(A3)                            ; $1067A0
        MOVE.W  D4,$4A(A0,D3.L)                 ; $1067A2
        TST    $5E(A4,A5.L)                     ; $1067A6
        MULU    D0,D0                           ; $1067AA
        MOVE.W  (A4),$2C78.W                    ; $1067AC
        DIVU    -(A4),D7                        ; $1067B0
        LSR.W  -$01(A1,D0.L)                    ; $1067B2
        OR.L   A2,D5                            ; $1067B6
        ROXR.L  #4,D6                           ; $1067B8
        DC.W    $4904               ; $1067BA DC.W    $4904
        BCC.L  $E902D31F                        ; $1067BC
        DC.W    $02B2,$CB7E,$4ADC,$C1E2; $1067C2 ANDI.L  #$CB7E4ADC,-$1E(A2,A4.W)
        OR.L   A0,D5                            ; $1067CA
        MOVEA.L A4,A6                           ; $1067CC
        PEA     -(A3)                           ; $1067CE
        DIVS    -$05(A1,D4.W),D5                ; $1067D0
        MOVEA.L A2,A5                           ; $1067D4
        DIVU    $5B7D.W,D4                      ; $1067D6
        TST.W  D6                               ; $1067DA
        ADDQ.W  #3,-(A4)                        ; $1067DC
        MOVE.W  $E930.W,(A1)+                   ; $1067DE
        ROXL.L  #5,D2                           ; $1067E2
        MOVE.L  -$7AB4(A2),(A5)+                ; $1067E4
        ROR.B  D5,D0                            ; $1067E8
        CLR.B  (A7)+                            ; $1067EA
        MOVE.L  A1,D4                           ; $1067EC
        SUBA.W  -$04(A2,A4.L),A4                ; $1067EE
        MOVEA.L (A2)+,A5                        ; $1067F2
        ASR.W  #$9420                           ; $1067F4
        MOVE.B  -(A2),(A2)+                     ; $1067F8
        MOVE.W  -(A0),D4                        ; $1067FA
        MOVE.W  $1D(A1,D7.W),-(A3)              ; $1067FC
        MULU    -$17(A2,D5.L),D4                ; $106800
        MOVE.W  D2,-(A3)                        ; $106804
        ROXR.B  #4,D0                           ; $106806
        DC.W    $7BD5               ; $106808 MOVE.W  (A5),<EA:3D>
        ADDA.L  $37F0(A6),A2                    ; $10680A
        DC.W    $4187               ; $10680E DC.W    $4187
        OR.L   D6,D7                            ; $106810
        MULS    $0A08.W,D2                      ; $106812
        LSR.W  -(A1)                            ; $106816
        DC.W    $FF7D,$F141         ; $106818 MOVE.W  <EA:3D>,-$0EBF(A7)
        MOVE.L  $2F(A7,D6.W),$602A(A6)          ; $10681C
        DIVU    $0C59.W,D0                      ; $106822
        ROXR.B  D1,D1                           ; $106826
        AND.B  (A1)+,D4                         ; $106828
        MOVEA.L $3831(A2),A6                    ; $10682A
        ADD.W  D6,D1                            ; $10682E
        MOVE.W  -(A7),-(A0)                     ; $106830
        MOVE.W  (A1)+,D4                        ; $106832
        EOR.B  D3,-$1BCD(A3)                    ; $106834
        MOVE.W  $171D.W,(A2)+                   ; $106838
        SUBQ.B  #2,-$050E(A0)                   ; $10683C
        DC.W    $3BF8,$15DC         ; $106840 MOVE.W  $15DC.W,<EA:3D>
        MOVE.B  -(A3),-(A0)                     ; $106844
        MOVE.L  $7380(PC),$E00E.W               ; $106846
        MOVE.L  $61E0(A2),$6E(A5,D3.L)          ; $10684C
        ROXL.L  D4,D7                           ; $106852
        LSR.W  D5,D5                            ; $106854
        MOVE.W  $1A(A1,A7.L),-$0A(A0,D3.W)      ; $106856
        MOVE.L  (A1),$52E1(A5)                  ; $10685C
        LSR.W  -$57C7(A6)                       ; $106860
        LEA     -(A4),A2                        ; $106864
        NEG.W  D5                               ; $106866
        SUBQ.W  #2,D4                           ; $106868
        MOVE.W  -$0BFA(A6),(A2)+                ; $10686A
        ADDQ.W  #8,(A0)+                        ; $10686E
        ADDQ.B  #1,#$3987                       ; $106870
loc_106874:
        AND.B  D4,D5                            ; $106874
        LEA     $2839(A1),A1                    ; $106876
        MOVE.B  D1,-$7FDD(PC)                   ; $10687A
        DC.W    $4826               ; $10687E DC.W    $4826
        BRA.S  loc_106874                       ; $106880
        ADD.B  -(A7),D6                         ; $106882
        BVC.S  loc_10686F                       ; $106884
        OR.L   (A2),D1                          ; $106886
        MOVE.W  -$0E10(A1),-(A0)                ; $106888
        SVC     $08(A1,A7.L)                    ; $10688C
        BCHG    D5,(A2)                         ; $106890
        MOVE.L  -(A0),D6                        ; $106892
        SEQ     -(A2)                           ; $106894
        MOVE.L  -$60(A4,A2.W),(A4)+             ; $106896
        MOVE.W  -$0E(PC,A4.W),(A1)+             ; $10689A
        MOVE.L  $7E61(A2),D5                    ; $10689E
        NEG.L  -(A6)                            ; $1068A2
        MOVE.W  (A0)+,-(A0)                     ; $1068A4
        ROXL.L  D4,D0                           ; $1068A6
        MOVE.W  A2,#$31CE                       ; $1068A8
        ASL.B  #4,D0                            ; $1068AC
        ADDI.W  #$77F0,-$2A(A2,A6.L)            ; $1068AE
        ADDQ.B  #8,D5                           ; $1068B4
        DC.W    $863F               ; $1068B6 OR.B   <EA:3F>,D3
        LSR.W  (A0)                             ; $1068B8
        LEA     -(A0),A5                        ; $1068BA
        ASL.W  (A1)+                            ; $1068BC
        ASL.W  (A5)+                            ; $1068BE
        LSL.B  #7,D2                            ; $1068C0
        MOVE.W  A1,$4444(A3)                    ; $1068C2
        JMP     (A2)+                           ; $1068C6
        ASL.W  $4EAD(A6)                        ; $1068C8
        LSL.L  D4,D0                            ; $1068CC
        ROXL.L  #4,D6                           ; $1068CE
        MOVEA.B A1,A6                           ; $1068D0
        MOVE.W  -$119B(A1),-$04(PC,A6.L)        ; $1068D2
        ADDA.W  -(A1),A4                        ; $1068D8
        DIVU    $04D1(A0),D7                    ; $1068DA
        LSL.W  D0,D4                            ; $1068DE
        ROL.L  D5,D7                            ; $1068E0
        ROL.W  -(A1)                            ; $1068E2
        ADD.B  (A0),D6                          ; $1068E4
        MOVE.W  D4,D5                           ; $1068E6
        NEGX.W -$1A(A3,A7.W)                    ; $1068E8
        MOVE.W  -$7719(A0),-(A7)                ; $1068EC
        MOVE.B  -$1F(A0,A6.L),-$30C2(A3)        ; $1068F0
        BTST    D0,D0                           ; $1068F6
        DC.W    $4511               ; $1068F8 DC.W    $4511
        MOVEA.L D4,A0                           ; $1068FA
        ADD.L  D4,-(A2)                         ; $1068FC
        DC.W    $823E               ; $1068FE OR.B   <EA:3E>,D1
        ADDQ.W  #7,$942350EB                    ; $106900
        BCS.S  loc_106912                       ; $106906
        SUB.W  (A6)+,D1                         ; $106908
        CMP.L  -$4F(A5,D3.L),D6                 ; $10690A
        MOVE.L  (A0)+,D1                        ; $10690E
        DIVS    $160F(A1),D5                    ; $106910
        DC.W    $073E               ; $106914 BTST    D3,<EA:3E>
        EOR.B  D6,$73(A3,D1.W)                  ; $106916
        MOVEQ   #$48,D7                         ; $10691A
        MOVE.W  -(A4),$45(PC,D4.W)              ; $10691C
        MOVEA.L D1,A0                           ; $106920
        NEG    $3428(A6)                        ; $106922
        BTST    D4,(A3)+                        ; $106926
        NEG    -$7F3E(A2)                       ; $106928
        MOVE.L  $6413(A0),$44(A6,A6.L)          ; $10692C
        LSR.W  D7,D2                            ; $106932
        ADDQ.L  #2,D7                           ; $106934
        ASR.W  $0BA4.W                          ; $106936
        MOVE.B  -$15C9(A2),(A3)+                ; $10693A
        DC.W    $AFE0               ; $10693E MOVE.L  -(A0),<EA:3F>
        LSR.W  -(A0)                            ; $106940
        MOVE.W  A7,D4                           ; $106942
        DC.W    $4915               ; $106944 DC.W    $4915
        ASR.B  D2,D0                            ; $106946
        DC.W    $0F8F               ; $106948 BCLR    D7,A7
        MULU    -$08(A3,A6.W),D0                ; $10694A
        MOVE.B  #$E6E0,D3                       ; $10694E
        MOVE.W  (A4),D4                         ; $106952
        SUB.W  D2,(A5)                          ; $106954
        MOVE.W  -$3E(A7,D1.L),(A6)+             ; $106956
        ADDA.W  -$2620(PC),A3                   ; $10695A
        DC.W    $0CDB               ; $10695E DC.W    $0CDB
        MOVE.L  (A7)+,$1DABB694                 ; $106960
        ADD.W  D0,-$17(A7,D1.L)                 ; $106966
        ROXR.W  -(A2)                           ; $10696A
        MOVE.L  $0AC4.W,(A6)+                   ; $10696C
        MOVEA.B $C43A.W,A7                      ; $106970
        OR.B   -(A4),D4                         ; $106974
        MOVE.L  (A3),-(A4)                      ; $106976
        CLR    -$2302(A5)                       ; $106978
        MOVEA.L A7,A1                           ; $10697C
        ROXR.W  #1,D0                           ; $10697E
        MOVEA.W $554B(A2),A1                    ; $106980
        ADDA.W  (A0),A5                         ; $106984
        MOVE.L  -(A4),-$0E17(A1)                ; $106986
        ADD.L  D4,A0                            ; $10698A
        MOVE.W  A1,(A4)+                        ; $10698C
        BRA.S  loc_10697B                       ; $10698E
        MOVE.W  (A2)+,-(A3)                     ; $106990
        ASR.W  $55(A2,A5.W)                     ; $106992
        EOR.W  D6,A5                            ; $106996
        MOVE.W  D0,$DA8E.W                      ; $106998
        OR.W   A7,D7                            ; $10699C
        MOVE.W  -$3C(A1,D2.L),$0A(A1,A7.W)      ; $10699E
        MOVE.L  (A5),-(A5)                      ; $1069A4
        MOVE.W  A2,(A0)+                        ; $1069A6
        MOVE.B  (A0)+,-(A6)                     ; $1069A8
        ADD.W  D5,-(A3)                         ; $1069AA
        DC.W    $29ED,$BA73,$DCC9,$9F18; $1069AC MOVE.L  -$458D(A5),#$DCC99F18
        DC.W    $0A14,$55B1         ; $1069B4 EORI.B  #$55B1,(A4)
        BSR.S  loc_10699B                       ; $1069B8
        ADDA.L  (A1)+,A4                        ; $1069BA
        CMP.L  -(A5),D3                         ; $1069BC
        ROL.B  D4,D2                            ; $1069BE
loc_1069C0:
        DC.W    $177F,$E809         ; $1069C0 MOVE.B  <EA:3F>,-$17F7(A3)
        DC.W    $4101               ; $1069C4 DC.W    $4101
        MOVE.B  -(A2),-(A3)                     ; $1069C6
        ROXR.B  D3,D4                           ; $1069C8
        ASL.W  (A7)+                            ; $1069CA
        MULU    (A1)+,D1                        ; $1069CC
        MOVE.B  (A0)+,$5CE8(A2)                 ; $1069CE
        MOVE.W  A6,D0                           ; $1069D2
        MOVE.W  $30(A3,A7.L),(A4)+              ; $1069D4
        SUBA.L  $5580(A1),A4                    ; $1069D8
        BRA.S  loc_1069EC                       ; $1069DC
        BGT.S  loc_1069C0                       ; $1069DE
        DC.W    $0A12,$FF76         ; $1069E0 EORI.B  #$FF76,(A2)
        MOVE.B  (A4)+,$578A(A0)                 ; $1069E4
        LSR.W  -(A6)                            ; $1069E8
        MOVEQ   #$18,D2                         ; $1069EA
loc_1069EC:
        BCHG    D6,D4                           ; $1069EC
        MOVE.W  (A3)+,-$271E(A0)                ; $1069EE
        MOVE.L  $00E1(A1),(A5)+                 ; $1069F2
        BNE.S  loc_1069E2                       ; $1069F6
        MOVE.L  A6,(A5)                         ; $1069F8
        DIVU    $24(A0,D1.W),D4                 ; $1069FA
        AND.B  D0,D5                            ; $1069FE
        ROXL.B  #8,D1                           ; $106A00
        ROR.W  $2175(A4)                        ; $106A02
        ADD.B  (A2)+,D4                         ; $106A06
        DIVU    -(A3),D6                        ; $106A08
        MOVE.L  D6,D4                           ; $106A0A
        DC.W    $00E0               ; $106A0C DC.W    $00E0
        MOVE.B  D5,D4                           ; $106A0E
        NEG    $18(A1,D1.L)                     ; $106A10
        MOVE.B  D0,(A3)                         ; $106A14
        MOVE.W  (A1),$3E50.W                    ; $106A16
        SUBQ.B  #2,-$20(A7,D0.W)                ; $106A1A
        BCHG    D7,(A1)                         ; $106A1E
        MOVE.W  D0,-(A1)                        ; $106A20
        LSR.B  #8,D4                            ; $106A22
        CMPA.L  D2,A7                           ; $106A24
        DC.W    $0218,$09E0         ; $106A26 ANDI.B  #$09E0,(A0)+
        MOVE.L  (A1),D0                         ; $106A2A
        BCLR    D1,$55F1(A0)                    ; $106A2C
        JMP     (A2)                            ; $106A30
        MOVE.B  -$0E94(A0),D3                   ; $106A32
        BCHG    D4,-$54E0(PC)                   ; $106A36
        MOVE.B  -(A2),-(A4)                     ; $106A3A
        MOVE.L  A4,D0                           ; $106A3C
        MOVE.L  (A1)+,D0                        ; $106A3E
        BNE.S  loc_106A86                       ; $106A40
        MOVEM.W -(A0),D2/D5/D6/D7/A0/A2/A3/A4   ; $106A42
        MOVE.L  (A3)+,D0                        ; $106A46
        ASR.W  (A1)+                            ; $106A48
        CMP.B  D2,D5                            ; $106A4A
        SGE     -(A2)                           ; $106A4C
        DC.W    $E0FE               ; $106A4E ASR.W  <EA:3E>
        MOVE.L  -(A2),(A3)+                     ; $106A50
        BNE.S  loc_106AA2                       ; $106A52
        MOVE.L  (A7)+,D0                        ; $106A54
        MOVE.L  -$56(A1,A0.W),(A6)+             ; $106A56
        MOVE.L  -(A2),(A0)+                     ; $106A5A
        DC.W    $BCFF               ; $106A5C CMPA.W  <EA:3F>,A6
        DC.W    $09CB               ; $106A5E BSET    D4,A3
        CMPA.L  -$60(A1,A1.L),A0                ; $106A60
        MOVE.B  (A5),(A5)+                      ; $106A64
        SUB.L  #$EBE87CC2,D1                    ; $106A66
        CMP.B  (A4),D4                          ; $106A6C
        SUBA.W  -$6E(A3,D1.W),A3                ; $106A6E
loc_106A72:
        AND.L  -(A4),D5                         ; $106A72
        MOVEQ   #-$08,D5                        ; $106A74
        LEA     -(A2),A7                        ; $106A76
        MOVE.L  -$4002(A6),D6                   ; $106A78
        MOVE.B  -$10(A7,D7.L),$7EE5(A0)         ; $106A7C
        BGT.S  loc_106A72                       ; $106A82
        ADD.W  D7,A2                            ; $106A84
loc_106A86:
        ASL.W  D2,D5                            ; $106A86
        ADDQ.W  #2,D5                           ; $106A88
        ADDQ.W  #2,D4                           ; $106A8A
        MOVE.B  -(A2),$E817E240                 ; $106A8C
        MOVE.W  -$20(A0,D2.W),(A1)+             ; $106A92
        MOVE.W  D5,$65E5(A0)                    ; $106A96
        SUBQ.W  #2,(A5)                         ; $106A9A
        BCHG    D7,-$1C2F(A3)                   ; $106A9C
        MOVEQ   #-$7C,D7                        ; $106AA0
loc_106AA2:
        AND.W  D6,#$5CFC                        ; $106AA2
        BCS.S  loc_106B1F                       ; $106AA6
        AND.W  D0,(A6)                          ; $106AA8
        ADDQ.W  #2,A6                           ; $106AAA
        ASR.W  #4,D4                            ; $106AAC
        ORI.L  #$DDF7DCD3,(A4)                  ; $106AAE
        ADD.W  D5,D4                            ; $106AB4
        DC.W    $2BC0               ; $106AB6 MOVE.L  D0,<EA:3D>
        MULU    D5,D0                           ; $106AB8
        MOVE.W  A5,-(A1)                        ; $106ABA
        AND.L  D5,A6                            ; $106ABC
        MOVE.W  D1,$B4D9A86A                    ; $106ABE
        MOVE.W  $11BC(A7),-$20(A7,D2.W)         ; $106AC4
        MOVE.W  -$15B0(A0),-(A3)                ; $106ACA
        ADD.L  D4,$D9E8.W                       ; $106ACE
        OR.L   D3,$76D9(A0)                     ; $106AD2
        DIVU    -(A4),D4                        ; $106AD6
        OR.W   -$20(A3,D3.W),D1                 ; $106AD8
        MOVE.W  D0,-$2D(PC,A2.L)                ; $106ADC
        MOVE.B  -$18(A3,A5.L),-(A0)             ; $106AE0
        MOVE.B  A5,D0                           ; $106AE4
        MOVE.L  -$7C(A0,D0.L),(A0)+             ; $106AE6
        ADD.L  A2,D6                            ; $106AEA
        MOVE.L  -$22(A0,A4.W),(A0)+             ; $106AEC
        MOVE.W  (A2),D4                         ; $106AF0
        AND.B  D5,A1                            ; $106AF2
        LSR.L  D2,D6                            ; $106AF4
        MULU    $1556.W,D1                      ; $106AF6
        MOVE.W  -(A0),$4878(PC)                 ; $106AFA
        ASL.W  A2                               ; $106AFE
        ASL.W  D0,D4                            ; $106B00
        AND.W  -$3580(A3),D1                    ; $106B02
        BTST    D7,$6B(A7,A1.W)                 ; $106B06
        EOR.L  D0,D0                            ; $106B0A
        EORI.L  #$06DA6512,(A1)+                ; $106B0C
        ASR.L  #4,D0                            ; $106B12
        BTST    #3,A7                           ; $106B14
        OR.W   (A5),D0                          ; $106B18
        ASR.W  -$21(A3,A6.L)                    ; $106B1A
        OR.L   D3,D0                            ; $106B1E
        BTST    D6,-(A3)                        ; $106B20
        ASL.L  #4,D4                            ; $106B22
        EOR.W  D0,(A5)                          ; $106B24
        SUBQ.W  #2,D1                           ; $106B26
        DC.W    $4CFC,$ED41,$24E5,$B210; $106B28 MOVEM.L D0/D6/A0/A2/A3/A5/A6/A7,#$24E5B210
        ADDA.W  (A5)+,A5                        ; $106B30
        ROXL.W  (A4)+                           ; $106B32
        ASR.L  #5,D0                            ; $106B34
        CMPI.B  #$456B,D7                       ; $106B36
        MOVE.W  -$01(A7,A0.L),$44F2(A0)         ; $106B3A
        MOVE.B  D2,(A3)+                        ; $106B40
        ADDQ.W  #5,(A3)+                        ; $106B42
        MOVE.B  D0,(A2)                         ; $106B44
        BTST    #4,A7                           ; $106B46
        MOVE.W  A6,-$1F11(A0)                   ; $106B4A
        MOVE.B  D0,-$07F4(A1)                   ; $106B4E
        MOVE.L  A2,$44(A5,A6.L)                 ; $106B52
        ASR.W  $0980(A0)                        ; $106B56
        BTST    D5,(A6)+                        ; $106B5A
        MOVE.W  A5,D4                           ; $106B5C
        OR.B   A4,D0                            ; $106B5E
        MOVE.W  $2A(A2,A0.W),(A6)+              ; $106B60
        MOVE.W  D0,(A6)                         ; $106B64
        BCLR    D4,-$7FF2(PC)                   ; $106B66
        DC.W    $36FD               ; $106B6A MOVE.W  <EA:3D>,(A3)+
        ADDA.L  -$7FF5(A2),A0                   ; $106B6C
        MOVEA.L (A2)+,A4                        ; $106B70
        CMP.L  D0,D7                            ; $106B72
        EORI.L  #$F178400B,(A7)                 ; $106B74
        MOVE.W  (A1)+,(A3)+                     ; $106B7A
        OR.B   A1,D0                            ; $106B7C
        MOVE.B  D0,$55(A6,D0.L)                 ; $106B7E
        ADDQ.W  #2,-$3680(A4)                   ; $106B82
        BTST    #26,A7                          ; $106B86
        DC.W    $00E8               ; $106B8A DC.W    $00E8
        MOVE.B  D0,$0D(A4,D6.W)                 ; $106B8C
        MOVE.L  A0,D0                           ; $106B90
        MOVE.B  D5,$54BE(A3)                    ; $106B92
        MOVE.W  A5,D4                           ; $106B96
        DC.W    $4008               ; $106B98 NEGX.B A0
        MOVE.B  (A1),(A0)                       ; $106B9A
        ROL.L  D1,D4                            ; $106B9C
        DC.W    $FFE0               ; $106B9E MOVE.W  -(A0),<EA:3F>
        MOVE.W  A7,D4                           ; $106BA0
        MOVE.B  (A5),$7AE1(A5)                  ; $106BA2
        RTS                                     ; $106BA6
        ASL.W  $3CA0(A6)                        ; $106BA8
        ROL.B  #8,D4                            ; $106BAC
        EOR.B  D0,A0                            ; $106BAE
        LSR.L  D7,D3                            ; $106BB0
        MOVE.W  -(A0),$09(A7,A6.W)              ; $106BB2
        BCC.S  loc_106B41                       ; $106BB6
        LSR.W  D2                               ; $106BB8
        CMP.L  -(A0),D1                         ; $106BBA
        ROXR.B  #8,D3                           ; $106BBC
        LSR.W  #7,D6                            ; $106BBE
        ASR.L  #4,D7                            ; $106BC0
        ROR.W  -(A4)                            ; $106BC2
        MOVEA.L -$04CA(A2),A4                   ; $106BC4
        AND.L  -(A0),D5                         ; $106BC8
        ROXR.B  #8,D3                           ; $106BCA
        ROR.W  -$47(A2,D7.W)                    ; $106BCC
        LSL.B  #5,D3                            ; $106BD0
        MOVE.L  -(A0),(A0)+                     ; $106BD2
        MOVE.B  -$6C(A7,D1.W),D3                ; $106BD4
        AND.L  D5,-(A0)                         ; $106BD8
        ROXR.B  #8,D7                           ; $106BDA
        ASR.L  D0,D0                            ; $106BDC
        ROR.B  #8,D5                            ; $106BDE
        BRA.S  loc_106BEA                       ; $106BE0
        MOVE.B  D5,(A5)                         ; $106BE2
        DC.W    $E1FF               ; $106BE4 ASL.W  <EA:3F>
        DC.W    $0008,$15FF         ; $106BE6 ORI.B  #$15FF,A0
loc_106BEA:
        OR.L   -$035C(A1),D5                    ; $106BEA
        TST.W  -$68(A6,D0.W)                    ; $106BEE
        ASR.W  $168A.W                          ; $106BF2
        DC.W    $4711               ; $106BF6 DC.W    $4711
        MOVE.L  -$2022(A0),(A2)                 ; $106BF8
        SCS     (A5)                            ; $106BFC
        MOVE.L  A0,D0                           ; $106BFE
        MOVE.B  (A7)+,(A3)                      ; $106C00
        MOVE.W  -(A0),$09(A7,D0.L)              ; $106C02
        ASR.W  $15A0.W                          ; $106C06
        DC.W    $0EE0               ; $106C0A DC.W    $0EE0
        MOVE.W  (A3)+,D4                        ; $106C0C
        NEGX   $16C2.W                          ; $106C0E
        BSET    D4,$5A88(A5)                    ; $106C12
        MOVEA.W D0,A2                           ; $106C16
        MOVE.W  (A7),D4                         ; $106C18
        OR.B   D7,$44(A5,D0.L)                  ; $106C1A
        NEG    D0                               ; $106C1E
        MOVE.B  D0,(A5)+                        ; $106C20
        BSET    D6,$08(A4,A4.W)                 ; $106C22
        MOVE.B  -$20(A5,D6.L),(A2)              ; $106C26
        DC.W    $0AFC               ; $106C2A DC.W    $0AFC
        MOVE.B  -(A0),$081A.W                   ; $106C2C
        OR.W   D7,-(A0)                         ; $106C30
        BTST    #0,(A6)+                        ; $106C32
        MOVE.B  (A0)+,$10(A0,A2.W)              ; $106C36
        MOVE.B  (A1)+,(A4)                      ; $106C3A
        MOVE.L  -(A0),$2008(A6)                 ; $106C3C
        DC.W    $1E3F               ; $106C40 MOVE.B  <EA:3F>,D7
        MOVE.L  (A2)+,D4                        ; $106C42
        ADD.L  D6,(A7)                          ; $106C44
        MOVE.L  -(A5),$F815FF62                 ; $106C46
        MOVE.L  (A2)+,-(A4)                     ; $106C4C
        DC.W    $F0FE               ; $106C4E MOVE.W  <EA:3E>,(A0)+
        DC.W    $FFE0               ; $106C50 MOVE.W  -(A0),<EA:3F>
        MOVE.W  A6,D4                           ; $106C52
        MOVE.W  (A2)+,D5                        ; $106C54
        ADD.B  D6,$22A1(A3)                     ; $106C56
        MOVE.B  (A5)+,-(A0)                     ; $106C5A
        MOVE.B  (A2),D5                         ; $106C5C
        MOVE.B  D4,$11AA(A3)                    ; $106C5E
        MOVE.B  -(A1),-(A0)                     ; $106C62
        MULU    $0BCF.W,D0                      ; $106C64
        MOVE.B  -$1BF5(A1),D0                   ; $106C68
        MOVE.L  $22D1(A1),D0                    ; $106C6C
        NOT.B  -(A1)                            ; $106C70
        ADDA.L  D1,A5                           ; $106C72
        ROXR.W  D6,D1                           ; $106C74
        ADD.W  -$271A(A5),D7                    ; $106C76
        SUB.W  (A1)+,D2                         ; $106C7A
        MOVE.B  (A2),D1                         ; $106C7C
        MOVE.W  A1,-(A1)                        ; $106C7E
        OR.B   D4,$3BAD(A7)                     ; $106C80
        MOVE.W  $71(PC,A5.W),$B7FB.W            ; $106C84
        MOVE.W  (A1)+,-(A7)                     ; $106C8A
        MOVE.W  -$08(PC,A4.W),-$47(A4,D0.L)     ; $106C8C
        SUB.L  D5,(A7)                          ; $106C92
        EOR.L  D5,$9977B977                     ; $106C94
        EOR.L  D5,$50(PC,A6.W)                  ; $106C9A
        MOVE.W  (A7),-$06(A3,A3.L)              ; $106C9E
        CMP.W  -$41(PC,A7.L),D7                 ; $106CA2
        MOVEQ   #-$12,D5                        ; $106CA6
        MOVE.W  D7,(A4)                         ; $106CA8
        MOVE.W  -$41(A7,D7.L),-(A3)             ; $106CAA
        MOVE.W  -$45(A7,A1.L),-$08E3(A7)        ; $106CAE
        OR.L   D3,(A7)+                         ; $106CB4
        EOR.L  D5,-$01(A7,D7.L)                 ; $106CB6
        DC.W    $D9BE               ; $106CBA ADD.L  D4,<EA:3E>
        MOVE.W  (A7),-$62(A7,A3.W)              ; $106CBC
        CMP.B  A6,D7                            ; $106CC0
        BSET    D0,-(A4)                        ; $106CC2
        CMPA.L  -(A3),A5                        ; $106CC4
        MOVE.W  (A5),-$30(PC,A6.L)              ; $106CC6
        DC.W    $C2FF               ; $106CCA MULU    <EA:3F>,D1
        MOVE.W  -$1A02(A3),(A7)+                ; $106CCC
        ROXL.L  D5,D7                           ; $106CD0
        DC.W    $F7FE,$EE97         ; $106CD2 MOVE.W  <EA:3E>,-$69(PC,A6.L)
        DC.W    $FBBE,$0087         ; $106CD6 MOVE.W  <EA:3E>,-$79(A5,D0.W)
        ROL.W  -$02(A3,A6.L)                    ; $106CDA
        MOVE.W  $1F(A3,A5.L),-$45(A3,A0.L)      ; $106CDE
        LSL.W  $33EE(A3)                        ; $106CE4
        MOVE.W  (A7)+,(A7)+                     ; $106CE8
        DC.W    $EFFF               ; $106CEA ROL.W  <EA:3F>
        CMPA.L  D3,A7                           ; $106CEC
        ASL.W  -$4485(A1)                       ; $106CEE
        MOVE.W  -$12(A7,D7.L),(A6)+             ; $106CF2
        MOVE.W  -$3F(PC,A6.L),$7E(A1,D0.W)      ; $106CF6
        ROR.W  -(A7)                            ; $106CFC
        DC.W    $FFF8,$093D         ; $106CFE MOVE.W  $093D.W,<EA:3F>
        ROR.W  -(A3)                            ; $106D02
        MOVE.W  #$80EB,-$1253(A5)               ; $106D04
        DC.W    $BEBF               ; $106D0A CMP.L  <EA:3F>,D7
        LSR.W  #$C54F                           ; $106D0C
        DC.W    $FFDD               ; $106D10 MOVE.W  (A5)+,<EA:3F>
        DC.W    $EEFF               ; $106D12 ROR.W  <EA:3F>
        MOVE.W  (A2)+,(A7)+                     ; $106D14
        BGE.S  loc_106CF5                       ; $106D16
        CMP.L  $1AAD(A5),D5                     ; $106D18
        ADD.B  (A5)+,D5                         ; $106D1C
        BTST    D7,-(A1)                        ; $106D1E
        MOVE.L  (A5)+,$A11A.W                   ; $106D20
        EOR.B  D5,(A2)+                         ; $106D24
        DC.W    $A7FC,$A1C0,$3091,$03E9; $106D26 MOVE.L  #$A1C03091,-$17(PC,D0.W)
        DC.W    $7BF1,$A9EB         ; $106D2E MOVE.W  -$15(A1,A2.L),<EA:3D>
        MOVE.W  A7,D7                           ; $106D32
        BGE.S  loc_106CF1                       ; $106D34
        MOVE.B  -$2665(A2),(A5)                 ; $106D36
        MOVE.B  -$2E57(A2),$7F(A0,A7.W)         ; $106D3A
        DIVU    #$AAFF,D0                       ; $106D40
        MOVE.L  -(A1),$77(A6,A2.L)              ; $106D44
        DC.W    $FDE7               ; $106D48 MOVE.W  -(A7),<EA:3E>
        MOVEQ   #$70,D7                         ; $106D4A
        DIVU    $54EF(A1),D2                    ; $106D4C
        ROR.W  -$7E80(A6)                       ; $106D50
        BSET    D0,D2                           ; $106D54
        CMPA.W  -$0359(A6),A7                   ; $106D56
        SUBA.L  -$40D0(A7),A3                   ; $106D5A
        DC.W    $00EB               ; $106D5E DC.W    $00EB
        DC.W    $FCFF               ; $106D60 MOVE.W  <EA:3F>,(A6)+
        DC.W    $FBF9,$A7C0,$0DF9   ; $106D62 MOVE.W  $A7C00DF9,<EA:3D>
        DC.W    $7FEE,$EAAF         ; $106D68 MOVE.W  -$1551(A6),<EA:3F>
        BRA.S  loc_106D65                       ; $106D6C
        EOR.B  D7,D0                            ; $106D6E
        ORI.W  #$DCE8,-$2680(A4)                ; $106D70
        ASL.W  D0,D6                            ; $106D76
        PEA     -(A2)                           ; $106D78
        ROR.W  #7,D2                            ; $106D7A
        DC.W    $FFFF               ; $106D7C MOVE.W  <EA:3F>,<EA:3F>
        MOVE.L  D2,(A0)                         ; $106D7E
        ROR.L  #5,D6                            ; $106D80
        DIVU    $60(A0,D0.L),D1                 ; $106D82
        ADD.L  -$48(A0,A2.L),D6                 ; $106D86
        DIVS    #$FFF3,D4                       ; $106D8A
        MOVE.L  -$0F(A2,D7.L),$21F0(PC)         ; $106D8E
        MOVE.B  D0,(A5)                         ; $106D94
        MOVE.B  (A0)+,D0                        ; $106D96
        EORI.L  #$C0100DC1,-(A0)                ; $106D98
        MOVE.W  (A1)+,D4                        ; $106D9E
        ROXR.B  #8,D3                           ; $106DA0
        BLE.L  $E028894E                        ; $106DA2
        DIVU    -(A0),D1                        ; $106DA8
        MOVE.W  (A4),D4                         ; $106DAA
        ROR.B  #8,D0                            ; $106DAC
        DC.W    $0AE0               ; $106DAE DC.W    $0AE0
        MOVE.W  (A7),D4                         ; $106DB0
        ROR.B  #8,D6                            ; $106DB2
        MOVE.L  $17E0.W,(A0)+                   ; $106DB4
        MOVE.B  -(A2),(A7)+                     ; $106DB8
        MOVE.L  -$1FE8(A2),(A5)                 ; $106DBA
        DC.W    $1DC1               ; $106DBE MOVE.B  D1,<EA:3E>
        SUB.B  (A1)+,D0                         ; $106DC0
        TST.L  (A4)+                            ; $106DC2
        AND.L  (A0),D0                          ; $106DC4
        MOVE.B  -$0E(A3,A3.W),(A5)+             ; $106DC6
        OR.B   (A4)+,D4                         ; $106DCA
        MULU    $19EF.W,D0                      ; $106DCC
        SUB.L  A2,D2                            ; $106DD0
        DC.W    $AABF               ; $106DD2 MOVE.L  <EA:3F>,(A5)
        MOVE.W  -$07F0(A1),-$2F(A0,D1.W)        ; $106DD4
        LSR.L  #2,D1                            ; $106DDA
        MULS    (A2)+,D4                        ; $106DDC
        OR.B   A1,D6                            ; $106DDE
        MOVEQ   #$0A,D4                         ; $106DE0
        BPL.S  loc_106E38                       ; $106DE2
        BSET    D1,(A3)                         ; $106DE4
loc_106DE6:
        BSET    D3,(A1)                         ; $106DE6
        MOVE.L  (A1)+,(A0)                      ; $106DE8
        DIVS    (A1),D5                         ; $106DEA
        MOVEQ   #-$01,D7                        ; $106DEC
        CMPA.L  (A1),A1                         ; $106DEE
        DC.W    $C7FE               ; $106DF0 MULS    <EA:3E>,D3
        MOVE.W  #$ECCE,$53DA(A6)                ; $106DF2
        MOVE.W  -(A2),-(A3)                     ; $106DF8
        MOVE.L  -(A7),D1                        ; $106DFA
        LSR.B  D2,D6                            ; $106DFC
        ASR.W  #7,D4                            ; $106DFE
        ADDQ.W  #2,A1                           ; $106E00
        BSET    D2,-(A0)                        ; $106E02
        MOVE.W  (A0),$5782(A7)                  ; $106E04
        MOVE.L  (A1),(A6)                       ; $106E08
        MOVE.L  -$005D(A1),(A0)                 ; $106E0A
        BPL.S  loc_106DE6                       ; $106E0E
        BPL.S  loc_106DF4                       ; $106E10
        MOVE.W  D5,$09(A7,A7.L)                 ; $106E12
        MOVE.L  A2,(A3)+                        ; $106E16
        LEA     D2,A5                           ; $106E18
loc_106E1A:
        MOVE.B  (A2)+,(A0)+                     ; $106E1A
        MOVEQ   #-$4E,D1                        ; $106E1C
        MOVE.W  -(A4),(A1)+                     ; $106E1E
        ROXL.L  #4,D2                           ; $106E20
        JMP     -(A2)                           ; $106E22
        MOVE.W  A2,D4                           ; $106E24
        MOVEQ   #-$5E,D4                        ; $106E26
        OR.W   D2,(A1)+                         ; $106E28
        SHI     D4                              ; $106E2A
        MOVE.B  $4E20(PC),(A4)                  ; $106E2C
        SUBA.L  -(A1),A2                        ; $106E30
        ADD.W  D2,-$4D(A3,D7.W)                 ; $106E32
        DC.W    $0020,$C4FF         ; $106E36 ORI.B  #$C4FF,-(A0)
        DIVS    -(A1),D2                        ; $106E3A
        BTST    D5,-$47(A0,D0.L)                ; $106E3C
        ADDQ.B  #2,D6                           ; $106E40
        DIVU    -$52D2(A4),D2                   ; $106E42
        MOVEA.L D0,A7                           ; $106E46
        DC.W    $01CB               ; $106E48 BSET    D0,A3
        CMP.B  -$1477(A6),D0                    ; $106E4A
        ASL.W  D4,D0                            ; $106E4E
        BMI.S  loc_106E1A                       ; $106E50
        MOVE.W  (A5),$5519(A2)                  ; $106E52
        MOVE.W  (A5),-$3BC5(A4)                 ; $106E56
        CMPA.W  #$E410,A0                       ; $106E5A
        NOT.L  -$4F(A0,A1.W)                    ; $106E5E
        MOVE.W  -(A5),$56FF(A7)                 ; $106E62
        SUBA.W  #$FA65,A4                       ; $106E66
        BNE.S  loc_106E63                       ; $106E6A
        SUBA.W  $1D22(A1),A5                    ; $106E6C
        MOVEQ   #$77,D1                         ; $106E70
        MOVE.L  D1,-(A0)                        ; $106E72
        DC.W    $33EE,$7077,$2D79,$E2E9; $106E74 MOVE.W  $7077(A6),$2D79E2E9
        MOVE.W  D0,(A0)+                        ; $106E7C
        MULS    $54E3(A1),D0                    ; $106E7E
        MOVE.W  (A5),$2BC4(A7)                  ; $106E82
        BNE.S  loc_106EEE                       ; $106E86
        ADDQ.W  #3,-$5314(A3)                   ; $106E88
        MOVE.L  $2741(PC),(A1)+                 ; $106E8C
        BTST    D6,D3                           ; $106E90
        ASR.B  D1,D7                            ; $106E92
        OR.L   (A1),D6                          ; $106E94
        LSR.W  A7                               ; $106E96
        BCS.S  loc_106EE8                       ; $106E98
        AND.L  D7,D0                            ; $106E9A
        MOVE.L  $50(PC,A1.L),(A1)               ; $106E9C
        MOVE.W  A5,D0                           ; $106EA0
        ADD.L  (A1)+,D4                         ; $106EA2
        ADDA.W  D1,A4                           ; $106EA4
        ORI.L  #$B27377DE,A4                    ; $106EA6
        MOVEA.L (A4)+,A5                        ; $106EAC
        OR.B   -$67EE(A4),D4                    ; $106EAE
        MOVE.W  -$16(A2,D2.W),$1827(A1)         ; $106EB2
        MOVEQ   #$72,D1                         ; $106EB8
        ROXR.L  #6,D0                           ; $106EBA
        MOVE.B  A1,-$7768(A3)                   ; $106EBC
        MOVE.W  (A6),D1                         ; $106EC0
        ASR.W  $15FC(A0)                        ; $106EC2
        MOVE.W  -(A1),-$68(A1,D6.W)             ; $106EC6
        MOVEA.L -$7C(A5,D2.W),A1                ; $106ECA
        SUB.B  (A3)+,D0                         ; $106ECE
        BSET    D2,-(A4)                        ; $106ED0
        MOVE.W  (A3),D4                         ; $106ED2
        ADD.W  D1,D3                            ; $106ED4
        SUBQ.W  #2,$2A37(A4)                    ; $106ED6
        ADDQ.B  #3,-(A7)                        ; $106EDA
        AND.L  D4,-$70(A1,D4.W)                 ; $106EDC
        MOVE.B  (A7),-$6517(A5)                 ; $106EE0
        MOVE.W  A7,D4                           ; $106EE4
        MOVE.W  A4,-(A0)                        ; $106EE6
loc_106EE8:
        MOVEA.W -$3CC9(A2),A0                   ; $106EE8
        MOVE.W  -$55(A7,D2.W),-$7D03(A7)        ; $106EEC
        MOVEQ   #$2E,D1                         ; $106EF2
        BCC.S  loc_106EEE                       ; $106EF4
        BCHG    D6,$7B0B(A1)                    ; $106EF6
        CMPA.L  #$EC3E560D,A5                   ; $106EFA
        MULU    $0DB8.W,D1                      ; $106F00
        DC.W    $F13D               ; $106F04 MOVE.W  <EA:3D>,-(A0)
        BGE.S  loc_106EB4                       ; $106F06
        BGE.S  loc_106EFC                       ; $106F08
        MOVE.W  -$80(A2,A0.W),(A5)+             ; $106F0A
        DC.W    $0A31,$023A,$67C6   ; $106F0E EORI.B  #$023A,-$3A(A1,D6.W)
        MOVE.W  -$1E38(A0),(A7)                 ; $106F14
        DIVS    -(A4),D0                        ; $106F18
        SUBQ.L  #2,-$008A(A3)                   ; $106F1A
        DC.W    $ACFD               ; $106F1E MOVE.L  <EA:3D>,(A6)+
        CMPA.L  D2,A3                           ; $106F20
        ROXR.W  $5555(A6)                       ; $106F22
        ADDQ.W  #2,-(A4)                        ; $106F26
        BNE.S  loc_106F8F                       ; $106F28
        BNE.S  loc_106F83                       ; $106F2A
        ASL.W  D0,D6                            ; $106F2C
        MOVE.W  $2C(A1,D3.L),-(A0)              ; $106F2E
        SUB.L  (A4)+,D5                         ; $106F32
        BMI.S  loc_106EEE                       ; $106F34
        MULU    -(A2),D1                        ; $106F36
        DC.W    $777E,$A155         ; $106F38 MOVE.W  <EA:3E>,-$5EAB(A3)
        ASR.W  #7,D4                            ; $106F3C
        AND.W  D2,-(A5)                         ; $106F3E
        MOVE.L  -(A1),(A6)                      ; $106F40
        ADDQ.B  #2,(A3)                         ; $106F42
        MOVE.W  -(A0),-$46(A0,A6.L)             ; $106F44
        MOVE.W  -(A1),D7                        ; $106F48
        BRA.S  loc_106ECD                       ; $106F4A
        LSL.B  #4,D0                            ; $106F4C
        MOVEQ   #-$41,D1                        ; $106F4E
        OR.W   (A6)+,D1                         ; $106F50
        DC.W    $A87E               ; $106F52 MOVEA.L <EA:3E>,A4
        MOVE.W  (A4),$0C9F(A7)                  ; $106F54
        MOVEM.L $7227(A1),D1/D3/D4/D5/D7/A1/A2/A3/A6/A7; $106F58
        MOVEQ   #$73,D1                         ; $106F5E
        ROXR.W  #7,D4                           ; $106F60
        SUBQ.L  #2,D2                           ; $106F62
        EOR.L  D3,-$0A9F(PC)                    ; $106F64
        DC.W    $00F3               ; $106F68 DC.W    $00F3
        ADDA.W  $096C.W,A6                      ; $106F6A
        MULS    (A4),D4                         ; $106F6E
loc_106F70:
        LSL.L  #4,D4                            ; $106F70
        AND.W  D0,-$1F(PC,D7.W)                 ; $106F72
        SGT     -(A0)                           ; $106F76
        NEGX   $0BE1.W                          ; $106F78
        DC.W    $1FD3               ; $106F7C MOVE.B  (A3),<EA:3F>
        MOVE.W  D1,$372E(A3)                    ; $106F7E
        MOVE.W  -$1B(A2,A6.W),$7E56(A3)         ; $106F82
        NOT.L  $4E(A4,D6.L)                     ; $106F88
        BNE.S  loc_106F70                       ; $106F8C
        ADD.L  -(A4),D7                         ; $106F8E
        DC.W    $FDDD               ; $106F90 MOVE.W  (A5)+,<EA:3E>
        BTST    D1,D0                           ; $106F92
        ADDQ.L  #7,-$111E(A2)                   ; $106F94
        MOVEA.W A1,A5                           ; $106F98
        MOVE.W  D0,(A5)+                        ; $106F9A
        CMP.W  A0,D4                            ; $106F9C
        MOVEA.W (A5),A5                         ; $106F9E
        ADDQ.W  #3,(A7)+                        ; $106FA0
        DC.W    $455E               ; $106FA2 DC.W    $455E
        MOVE.B  -$20(A0,A2.W),(A6)              ; $106FA4
        BSET    D4,(A0)+                        ; $106FA8
        DC.W    $1DD8               ; $106FAA MOVE.B  (A0)+,<EA:3E>
        ADDA.W  $30AA(A6),A2                    ; $106FAC
        SUBA.L  -$7F1E(A1),A3                   ; $106FB0
        MOVE.L  (A4)+,-$20(A3,A4.W)             ; $106FB4
        DC.W    $0AB8,$F00B,$2B0B,$708B; $106FB8 EORI.L  #$F00B2B0B,$708B.W
        DC.W    $1DE2               ; $106FC0 MOVE.B  -(A2),<EA:3E>
        BRA.S  loc_107034                       ; $106FC2
        DC.W    $1DC0               ; $106FC4 MOVE.B  D0,<EA:3E>
        ADD.B  (A7)+,D4                         ; $106FC6
        DC.W    $B8FF               ; $106FC8 CMPA.W  <EA:3F>,A4
        MOVE.W  (A5)+,D4                        ; $106FCA
        MOVE.L  $2EE2(A2),(A5)                  ; $106FCC
        MOVE.W  (A3)+,D4                        ; $106FD0
        MOVE.W  D4,-$0A(PC,D0.W)                ; $106FD2
        MOVE.L  A3,$51(A7,A2.W)                 ; $106FD6
        MOVEA.B (A7)+,A4                        ; $106FDA
        BSET    D6,$096A(A0)                    ; $106FDC
        BTST    D0,-$65(A3,A0.L)                ; $106FE0
        MOVE.B  (A0),-$7653(A5)                 ; $106FE4
        MOVE.W  $71(A7,D0.W),-(A0)              ; $106FE8
        AND.W  D3,(A1)+                         ; $106FEC
        MULS    $33(PC,D5.L),D1                 ; $106FEE
        DC.W    $8D3E               ; $106FF2 OR.B   D6,<EA:3E>
        EOR.W  D4,$72(A2,A7.L)                  ; $106FF4
        OR.W   D2,(A5)                          ; $106FF8
        MOVE.L  -$0F(A7,D2.W),D7                ; $106FFA
        MOVE.W  -(A7),-(A2)                     ; $106FFE
        MOVE.L  $EA3F.W,(A1)+                   ; $107000
        LSR.B  D5,D0                            ; $107004
        MOVE.W  D7,$59(A0,D6.L)                 ; $107006
        ROXL.W  D4,D2                           ; $10700A
        MOVE.L  -(A5),(A1)+                     ; $10700C
        MOVEQ   #-$1C,D1                        ; $10700E
        MULU    -$1A14(A1),D7                   ; $107010
        MOVE.W  D4,-$07A3(A0)                   ; $107014
        ADDA.W  -$1BC9(A6),A5                   ; $107018
        MOVEQ   #-$1E,D1                        ; $10701C
        MOVEQ   #-$31,D1                        ; $10701E
        SLT     $2E09(A6)                       ; $107020
        SUB.W  D3,D5                            ; $107024
        ADD.W  -(A0),D2                         ; $107026
        MOVEA.L (A4),A5                         ; $107028
        MOVE.W  D5,-$00D4(A7)                   ; $10702A
        MOVE.L  A4,$00(A0,D7.W)                 ; $10702E
        SGT     -$4635(A6)                      ; $107032
        MOVE.W  (A1)+,(A4)+                     ; $107036
        NEG.W  A6                               ; $107038
        LEA     $78(A7,A6.L),A2                 ; $10703A
        DIVS    $4554(A5),D0                    ; $10703E
        ADDQ.W  #7,A6                           ; $107042
        ADD.L  D7,-$1AEB(A1)                    ; $107044
        DC.W    $0EE3               ; $107048 DC.W    $0EE3
        NEGX   (A1)+                            ; $10704A
        SGT     (A1)+                           ; $10704C
        AND.W  D4,(A5)                          ; $10704E
        DC.W    $4544               ; $107050 DC.W    $4544
        ADD.L  A0,D3                            ; $107052
        MULU    (A6),D7                         ; $107054
        ROXL.W  #4,D4                           ; $107056
        ADD.W  (A4),D0                          ; $107058
        MOVE.W  -$1117(A2),(A2)                 ; $10705A
        MOVE.L  A1,D0                           ; $10705E
        DC.W    $FFE7               ; $107060 MOVE.W  -(A7),<EA:3F>
        CMPA.W  (A1)+,A4                        ; $107062
        MOVE.W  -(A5),(A0)                      ; $107064
        MOVEA.W D4,A6                           ; $107066
        DIVU    (A6)+,D0                        ; $107068
        ADDA.W  -$2A66(A0),A4                   ; $10706A
        LEA     -$27(A7,A3.L),A0                ; $10706E
        CMPA.L  (A1)+,A2                        ; $107072
        BCS.S  loc_107059                       ; $107074
        LSR.L  D5,D0                            ; $107076
        ADD.W  D2,D5                            ; $107078
        DC.W    $00F1               ; $10707A DC.W    $00F1
        DC.W    $E9FF               ; $10707C ASL.W  <EA:3F>
        ADD.B  D1,D4                            ; $10707E
        DIVU    -$10(A1,A7.L),D0                ; $107080
        ROR.W  (A2)                             ; $107084
loc_107086:
        OR.L   D4,D4                            ; $107086
        MOVE.W  (A1),(A2)+                      ; $107088
        MOVE.W  D5,(A0)                         ; $10708A
        DC.W    $DCFF               ; $10708C ADDA.W  <EA:3F>,A6
        SUBQ.W  #8,-(A4)                        ; $10708E
        ADDQ.W  #3,-(A6)                        ; $107090
        MOVE.W  (A4),-$3D(PC,A4.L)              ; $107092
        MOVE.W  D1,-(A7)                        ; $107096
        OR.W   D0,-$2310(A4)                    ; $107098
        MOVE.W  #$F8A3,-$40(PC,A5.L)            ; $10709C
        BNE.S  loc_107109                       ; $1070A2
        ADDQ.W  #2,A6                           ; $1070A4
        ADDQ.L  #7,$28(A2,D4.L)                 ; $1070A6
        MOVE.L  #$6CDAA0CA,(A4)+                ; $1070AA
        MOVE.W  -$04(A1,A5.W),#$044C            ; $1070B0
        EOR.W  D5,-(A5)                         ; $1070B6
        BLS.S  loc_107086                       ; $1070B8
        DC.W    $4522               ; $1070BA DC.W    $4522
        MOVE.B  -(A6),(A1)+                     ; $1070BC
        LEA     (A1)+,A7                        ; $1070BE
        MOVE.W  -$0075(A5),(A6)+                ; $1070C0
        MOVEM.L -(A3),D0/D3/D5/D6/D7/A2/A3/A4/A5; $1070C4
        MOVE.W  -(A6),(A1)                      ; $1070C8
        MOVE.B  D1,-$30BB(A0)                   ; $1070CA
        MOVE.W  (A5),(A3)                       ; $1070CE
        DC.W    $ABE6               ; $1070D0 MOVE.L  -(A6),<EA:3D>
        ASR.L  #1,D0                            ; $1070D2
        MOVE.W  A6,$D45E.W                      ; $1070D4
        NEG    -(A3)                            ; $1070D8
        ROXL.B  #2,D4                           ; $1070DA
        LEA     (A6)+,A4                        ; $1070DC
        BCC.S  loc_1070F0                       ; $1070DE
        DC.W    $D9FE               ; $1070E0 ADDA.L  <EA:3E>,A4
        SUB.W  D5,(A0)+                         ; $1070E2
        MOVEA.W -$24(A1,D6.L),A6                ; $1070E4
        ADDA.W  -(A3),A2                        ; $1070E8
        LSR.B  D7,D6                            ; $1070EA
        MOVE.W  (A5),$54D1(A7)                  ; $1070EC
loc_1070F0:
        BCC.S  loc_10715A                       ; $1070F0
        MULU    $51(A7,D2.W),D0                 ; $1070F2
        ASL.W  $4FFC(A6)                        ; $1070F6
        DC.W    $4340               ; $1070FA DC.W    $4340
        SUBQ.W  #2,(A6)+                        ; $1070FC
        JMP     D4                              ; $1070FE
        ROXL.W  A0                              ; $107100
        EOR.L  D7,-$71A9(A5)                    ; $107102
        ROXR.L  D1,D3                           ; $107106
        MOVE.W  -(A4),(A1)+                     ; $107108
        DIVU    (A1),D2                         ; $10710A
        MOVE.W  -$2F(A1,A6.L),(A2)+             ; $10710C
        TRAP    #5                              ; $107110
        OR.L   A0,D3                            ; $107112
        MOVE.W  #$F25E,-$5DBC(A0)               ; $107114
        AND.B  -(A1),D7                         ; $10711A
        MOVE.B  -(A4),#$54D4                    ; $10711C
        NEG.L  -(A7)                            ; $107120
        SLT     #$6421                          ; $107122
        DC.W    $04F7               ; $107126 DC.W    $04F7
        OR.W   D5,D5                            ; $107128
        OR.W   D6,(A6)+                         ; $10712A
        MOVE.W  D4,-$2C(A4,D4.L)                ; $10712C
        MOVE.L  -(A5),(A0)+                     ; $107130
        BPL.S  loc_1070D6                       ; $107132
        CLR.L  (A0)                             ; $107134
        BLT.S  loc_10710B                       ; $107136
        DIVU    -(A4),D6                        ; $107138
        MOVE.W  -(A3),D1                        ; $10713A
        ROXL.W  #8,D1                           ; $10713C
        NOT.B  (A0)                             ; $10713E
        ORI.L  #$0CF1801E,(A6)                  ; $107140
        NEGX.W D2                               ; $107146
        SUBA.W  D1,A0                           ; $107148
        ROL.W  -$09(A2,D3.W)                    ; $10714A
        MOVE.L  $F6FB.W,(A2)+                   ; $10714E
        ADD.W  D7,-(A5)                         ; $107152
        ASR.B  D1,D2                            ; $107154
        MOVE.W  -(A1),$77(A3,D5.W)              ; $107156
loc_10715A:
        SGT     $44(PC,D2.W)                    ; $10715A
        ADD.B  D0,-(A2)                         ; $10715E
        DC.W    $4946               ; $107160 DC.W    $4946
        DC.W    $4944               ; $107162 DC.W    $4944
        MOVE.L  (A7),(A4)+                      ; $107164
        ADD.L  D6,(A3)+                         ; $107166
        ADDQ.W  #2,D0                           ; $107168
        MOVE.W  $0617(A0),$FB9A.W               ; $10716A
        SUBA.W  (A4)+,A0                        ; $107170
        MOVE.L  -(A7),-(A3)                     ; $107172
        MOVE.W  (A1),$22D4.W                    ; $107174
        DC.W    $00B0,$FAD4,$4A45,$E122; $107178 ORI.L  #$FAD44A45,$22(A0,A6.W)
        OR.L   -$37(A1,A5.L),D3                 ; $107180
        BGT.S  loc_107167                       ; $107184
        MOVE.L  #$7272E227,(A1)+                ; $107186
        MOVE.B  A4,(A4)                         ; $10718C
        SF      (A1)+                           ; $10718E
        MOVEA.W -$6C(A7,A7.W),A4                ; $107190
        ROXL.W  D4,D2                           ; $107194
        DC.W    $02B6,$F0D8,$D9FF,$05E2; $107196 ANDI.L  #$F0D8D9FF,-$1E(A6,D0.W)
        DC.W    $FDF1,$2E18         ; $10719E MOVE.W  $18(A1,D2.L),<EA:3E>
        NEGX.W (A0)                             ; $1071A2
        AND.W  -$26(A5,D2.L),D5                 ; $1071A4
        MOVE.W  (A1)+,-$16E0(A3)                ; $1071A8
        DC.W    $00F8               ; $1071AC DC.W    $00F8
        ADDA.L  -(A1),A0                        ; $1071AE
        MOVEA.L (A0),A6                         ; $1071B0
        SUBI.B  #$91EA,A3                       ; $1071B2
        MOVEA.L A2,A2                           ; $1071B6
        MOVE.W  $10(A7,D1.W),(A6)+              ; $1071B8
        DC.W    $0CCA               ; $1071BC DC.W    $0CCA
        MOVEQ   #-$37,D3                        ; $1071BE
        ST      -$4320(A2)                      ; $1071C0
        ADDQ.B  #2,(A5)                         ; $1071C4
        ROXR.B  D7,D5                           ; $1071C6
        DC.W    $F3F8,$EA65,$8285,$EBE6; $1071C8 MOVE.W  $EA65.W,$8285EBE6
        AND.B  -(A4),D1                         ; $1071D0
        ADD.B  D1,D1                            ; $1071D2
        DC.W    $14BD               ; $1071D4 MOVE.B  <EA:3D>,(A2)
        MOVEQ   #-$18,D4                        ; $1071D6
        DIVU    -$7614(A1),D3                   ; $1071D8
        OR.L   D0,-(A4)                         ; $1071DC
        LSL.W  D4                               ; $1071DE
        DC.W    $E2FD               ; $1071E0 LSR.W  <EA:3D>
        MOVE.W  A1,(A6)                         ; $1071E2
        BTST    #5,A0                           ; $1071E4
        DC.W    $C7FF               ; $1071E8 MULS    <EA:3F>,D3
        MOVE.L  -(A3),D2                        ; $1071EA
        MOVE.W  A0,(A3)+                        ; $1071EC
        MULU    (A3),D5                         ; $1071EE
        CMP.L  (A4)+,D6                         ; $1071F0
        ASL.L  D0,D5                            ; $1071F2
        MOVE.W  #$4545,-(A0)                    ; $1071F4
        MOVE    USP,A7                          ; $1071F8
        ASL.L  #4,D0                            ; $1071FA
        MOVEA.L D1,A5                           ; $1071FC
        ROXR.W  D1,D4                           ; $1071FE
        DC.W    $EAFD               ; $107200 LSR.W  <EA:3D>
        DC.W    $93FF               ; $107202 SUBA.L  <EA:3F>,A1
        MOVEA.W (A1)+,A6                        ; $107204
        ADD.W  D4,$17(A7,A6.W)                  ; $107206
        MOVE.W  (A5),-$68(A0,D7.W)              ; $10720A
        MOVE.W  -(A5),$7D05.W                   ; $10720E
        ROR.L  D6,D0                            ; $107212
        AND.L  D4,D4                            ; $107214
        MOVEA.W D1,A4                           ; $107216
        ASR.W  #1,D5                            ; $107218
loc_10721A:
        ORI.L  #$EA39B2E8,D4                    ; $10721A
        DC.W    $0EEA               ; $107220 DC.W    $0EEA
        MOVE.L  -$368D(A4),$33FA(A3)            ; $107222
        OR.L   D1,(A2)                          ; $107228
        SUBQ.W  #3,-$3E27(A1)                   ; $10722A
        MOVE.L  D3,D7                           ; $10722E
        NEG    -(A5)                            ; $107230
        LSR.W  #2,D6                            ; $107232
        MOVE.B  D4,-(A0)                        ; $107234
        MOVE.W  (A2),-$6AE8(A3)                 ; $107236
loc_10723A:
        MOVE.L  (A2),(A0)+                      ; $10723A
        DC.W    $438B               ; $10723C DC.W    $438B
        BGE.S  loc_1072A5                       ; $10723E
        MOVE.W  $15(A5,D5.L),-$1FF0(A7)         ; $107240
        BRA.S  loc_10721A                       ; $107246
        OR.L   D7,(A2)                          ; $107248
        MOVEQ   #$64,D2                         ; $10724A
        DIVU    (A4)+,D2                        ; $10724C
        EOR.W  D2,(A2)+                         ; $10724E
        DC.W    $4956               ; $107250 DC.W    $4956
        MOVE.W  (A2),-(A6)                      ; $107252
        AND.W  -$7F(A2,D3.L),D5                 ; $107254
        DC.W    $018C               ; $107258 BCLR    D0,A4
        BCC.S  loc_10723A                       ; $10725A
        MOVE.L  (A3)+,(A7)+                     ; $10725C
        MOVE.W  (A0)+,$2BA7(A0)                 ; $10725E
        MOVEQ   #-$78,D4                        ; $107262
        SUBA.L  -$7F(A1,A1.W),A0                ; $107264
        MOVE.W  $7A38.W,$48(A3,D5.L)            ; $107268
        BPL.S  loc_10722C                       ; $10726E
        DC.W    $06E1               ; $107270 DC.W    $06E1
        CMP.W  (A1),D4                          ; $107272
        OR.L   D0,-$7E9D(A0)                    ; $107274
        LEA     $6BBD(A6),A1                    ; $107278
        MOVEA.W -$1B15(A1),A0                   ; $10727C
        BPL.S  loc_1072A0                       ; $107280
        SUB.L  D4,A6                            ; $107282
        BGE.S  loc_107300                       ; $107284
        CMP.L  -$7778(PC),D3                    ; $107286
        OR.B   D1,D5                            ; $10728A
        BHI.S  loc_10726A                       ; $10728C
        MOVE.W  $5459(A0),#$0802                ; $10728E
        MOVE.B  (A5),-$6C50(A7)                 ; $107294
        MOVE.W  (A0)+,$4295(A4)                 ; $107298
        DIVS    (A4),D2                         ; $10729C
        DIVS    (A7),D4                         ; $10729E
loc_1072A0:
        ADD.B  -$80(A7,A3.L),D5                 ; $1072A0
        MOVE.L  (A7)+,(A5)+                     ; $1072A4
        MOVE.W  A7,(A3)+                        ; $1072A6
        ASL.L  #7,D6                            ; $1072A8
        ADD.B  (A4)+,D6                         ; $1072AA
        OR.L   (A4)+,D5                         ; $1072AC
        MOVE.W  (A6),#$AA82                     ; $1072AE
        LSR.W  #7,D0                            ; $1072B2
        BSR.S  loc_107239                       ; $1072B4
        OR.W   D4,-$77(A3,A0.W)                 ; $1072B6
        ADDA.W  A1,A2                           ; $1072BA
        MOVE.W  -$58(A3,A4.L),D2                ; $1072BC
        MOVEA.B (A5)+,A0                        ; $1072C0
        NEG.W  D1                               ; $1072C2
        ADD.L  $F0FCCAD0,D4                     ; $1072C4
        MOVE.B  -$55A0(A2),$19(A2,D4.L)         ; $1072CA
        DC.W    $E2FE               ; $1072D0 LSR.W  <EA:3E>
        BRA.S  loc_10731C                       ; $1072D2
        MOVE.B  #$B560,D2                       ; $1072D4
        DC.W    $4817               ; $1072D8 DC.W    $4817
        ADDA.W  -$2D(A5,A2.L),A4                ; $1072DA
        BRA.S  loc_10732D                       ; $1072DE
        SUB.L  -(A2),D1                         ; $1072E0
        BLE.S  loc_10730E                       ; $1072E2
        BRA.S  loc_107335                       ; $1072E4
        MOVE.W  -$5F(A0,D5.L),-(A6)             ; $1072E6
        SVS     $DAC2.W                         ; $1072EA
        MOVE.L  -(A1),$64C2(A4)                 ; $1072EE
        MOVEQ   #-$0F,D4                        ; $1072F2
        MOVEQ   #-$1F,D1                        ; $1072F4
        EOR.B  D4,-$2F(A3,A7.L)                 ; $1072F6
        MOVEQ   #$77,D5                         ; $1072FA
        DC.W    $4518               ; $1072FC DC.W    $4518
        MOVE.L  -$1F9F(A6),-(A3)                ; $1072FE
        DC.W    $F0FD               ; $107302 MOVE.W  <EA:3D>,(A0)+
        ROXR.W  D7,D7                           ; $107304
        ADDQ.B  #5,(A5)                         ; $107306
        MOVE.W  A6,$09D9(A2)                    ; $107308
        LSR.W  #2,D3                            ; $10730C
loc_10730E:
        DC.W    $F1F9,$EB25,$DAEB,$F2D5; $10730E MOVE.W  $EB25DAEB,$F2D5.W
        DIVU    (A1)+,D1                        ; $107316
        DC.W    $00DB               ; $107318 DC.W    $00DB
        SUBA.W  -$2714(A2),A1                   ; $10731A
        DC.W    $4E27               ; $10731E DC.W    $4E27
        DC.W    $F1FD,$6A41         ; $107320 MOVE.W  <EA:3D>,$6A41.W
        DBNE    D2,$1054F8                      ; $107324
        MOVE.L  (A1),#$04DA4410                 ; $107328
        ADDA.W  -(A2),A5                        ; $10732E
        DC.W    $4B4A               ; $107330 DC.W    $4B4A
        SUBQ.W  #2,(A4)                         ; $107332
        ASR.W  #$48E4                           ; $107334
        MOVE.L  (A2)+,(A4)+                     ; $107338
        MOVE.B  (A1)+,(A2)+                     ; $10733A
        ADD.W  $F3BE.W,D4                       ; $10733C
        ADD.W  D0,D1                            ; $107340
        DC.W    $3DE9,$EA9F         ; $107342 MOVE.W  -$1561(A1),<EA:3E>
        ADD.L  -$26(A1,D4.L),D6                 ; $107346
        MOVE.B  (A3)+,(A7)+                     ; $10734A
        ROXR.W  -(A5)                           ; $10734C
        ADDQ.B  #7,(A4)                         ; $10734E
        DC.W    $0BC9               ; $107350 BSET    D5,A1
        ADDQ.W  #2,A4                           ; $107352
        EOR.L  D0,(A4)                          ; $107354
        ROL.B  D2,D0                            ; $107356
        ADD.W  D0,(A2)+                         ; $107358
        MOVE.L  -$57(A2,A3.L),-$6B4F(PC)        ; $10735A
        BCS.S  loc_1073BE                       ; $107360
        ADDA.L  (A4)+,A5                        ; $107362
        LSL.W  -$64(A4,A5.W)                    ; $107364
        BCHG    D0,(A4)                         ; $107368
        ADDQ.L  #5,-$01(A1,A5.W)                ; $10736A
        MOVE.B  $13DE(A3),#$6BDA                ; $10736E
        MOVE.B  $B1F1.W,-$333F(A6)              ; $107374
        ADDQ.W  #2,(A6)+                        ; $10737A
        MULU    D0,D1                           ; $10737C
        SUBQ.B  #2,-$6BFB(A6)                   ; $10737E
        ADD.B  D3,$B5E0BADA                     ; $107382
        AND.B  D4,D4                            ; $107388
        BSET    #29,D3                          ; $10738A
        DC.W    $4521               ; $10738E DC.W    $4521
        CMPA.W  -$4A(A7,D5.L),A5                ; $107390
        ROXR.W  -(A1)                           ; $107394
        MULU    (A1)+,D2                        ; $107396
        BNE.S  loc_1073EE                       ; $107398
        AND.B  A0,D0                            ; $10739A
        MOVE.L  (A1)+,(A5)+                     ; $10739C
        ROL.W  -$0298(A2)                       ; $10739E
        OR.B   (A7),D0                          ; $1073A2
        MOVE.W  (A0),(A7)                       ; $1073A4
        LSL.W  -$5219(A6)                       ; $1073A6
        ROXR.B  #4,D0                           ; $1073AA
        LEA     D1,A2                           ; $1073AC
        SUBA.L  (A2),A5                         ; $1073AE
        ROXR.W  #2,D4                           ; $1073B0
        MOVE.W  -(A4),-$5E(PC,D0.L)             ; $1073B2
        MOVE.W  $4CD1(A6),(A3)+                 ; $1073B6
        SUBQ.L  #6,-$25(A5,A6.L)                ; $1073BA
loc_1073BE:
        DC.W    $0222,$74D2         ; $1073BE ANDI.B  #$74D2,-(A2)
        MULS    (A2),D6                         ; $1073C2
        ADDA.W  (A7),A5                         ; $1073C4
        MOVE.L  $06F1(A1),D0                    ; $1073C6
        MOVE.W  -$1F(A3,A2.L),$1454.W           ; $1073CA
        SUBA.W  (A4),A7                         ; $1073D0
        ADD.W  -$57(A6,A4.L),D0                 ; $1073D2
        BSET    D3,(A1)+                        ; $1073D6
        MOVE.L  -(A0),(A7)                      ; $1073D8
        ADDQ.L  #2,A2                           ; $1073DA
        MOVE.L  -(A0),-(A4)                     ; $1073DC
        MOVEA.L (A5),A4                         ; $1073DE
        MOVE.W  (A1),D6                         ; $1073E0
        ADDA.L  -$470E(A4),A4                   ; $1073E2
        ROR.W  (A2)+                            ; $1073E6
        ADDQ.B  #5,-$1C(A5,A0.L)                ; $1073E8
        MOVE.W  -(A2),(A2)+                     ; $1073EC
loc_1073EE:
        ASL.L  D6,D3                            ; $1073EE
        MOVEA.L (A1)+,A1                        ; $1073F0
        MOVE.L  A4,#$D21EE28F                   ; $1073F2
        ROXL.W  #8,D4                           ; $1073F8
        MOVEQ   #-$6B,D6                        ; $1073FA
        OR.W   -(A4),D6                         ; $1073FC
        DC.W    $454E               ; $1073FE DC.W    $454E
        DC.W    $4564               ; $107400 DC.W    $4564
        MOVE.W  -$3B27(A1),(A1)                 ; $107402
        MOVE.L  -(A3),(A4)+                     ; $107406
        MOVE.B  -$248B(A3),(A2)                 ; $107408
        ADDA.W  -$3E20(A5),A6                   ; $10740C
        BNE.S  loc_107470                       ; $107410
        AND.L  D4,A6                            ; $107412
        ADD.L  D0,A0                            ; $107414
        MOVE.L  D0,(A2)                         ; $107416
        MOVE.W  -$48(A5,A5.L),-$1E(A0,D4.W)     ; $107418
        BVC.S  loc_107474                       ; $10741E
        ASR.W  $71E3(A0)                        ; $107420
        ADD.W  (A4),D5                          ; $107424
        SUB.L  $3C84DA56,D6                     ; $107426
        BCLR    D3,(A0)+                        ; $10742C
        MOVE.W  (A2)+,(A0)+                     ; $10742E
        LEA     (A2)+,A0                        ; $107430
        MOVE.L  $5E22(A1),(A6)                  ; $107432
        BCHG    D4,D1                           ; $107436
        ADDQ.L  #1,-$08(A4,A3.L)                ; $107438
        OR.L   D7,-(A2)                         ; $10743C
        ASR.B  D1,D4                            ; $10743E
        DC.W    $DBFF               ; $107440 ADDA.L  <EA:3F>,A5
        DC.W    $FDE9,$8295         ; $107442 MOVE.W  -$7D6B(A1),<EA:3E>
        MULS    $37372783,D0                    ; $107446
        LSL.L  D4,D3                            ; $10744C
        MOVE.L  A2,(A0)+                        ; $10744E
        MULS    -$127C(A1),D7                   ; $107450
        ROXL.B  #4,D6                           ; $107454
        MOVE.L  D3,$62(A0,A6.L)                 ; $107456
        BPL.S  loc_107486                       ; $10745A
        SCC     -(A3)                           ; $10745C
        MOVEA.W $1C(A4,D2.W),A1                 ; $10745E
        BGE.S  loc_107475                       ; $107462
        MOVE.W  (A5)+,-(A4)                     ; $107464
        MOVE.W  -(A1),(A2)+                     ; $107466
        MOVE.W  A1,$55AD(A7)                    ; $107468
        MOVEQ   #-$17,D2                        ; $10746C
        DC.W    $417A               ; $10746E DC.W    $417A
loc_107470:
        MOVE.W  -(A6),(A0)+                     ; $107470
        MOVE.L  A3,$02C0(A5)                    ; $107472
        DC.W    $0EDC               ; $107476 DC.W    $0EDC
        ADD.B  D0,-(A2)                         ; $107478
        ADDQ.W  #2,A5                           ; $10747A
        TST.L  -$1324(A2)                       ; $10747C
        LSL.W  #3,D2                            ; $107480
        DC.W    $FFF8,$0A12         ; $107482 MOVE.W  $0A12.W,<EA:3F>
loc_107486:
        MOVE.W  (A2),(A4)+                      ; $107486
        SMI     (A2)                            ; $107488
        MOVE.W  (A4),D4                         ; $10748A
        MOVE.L  -$4508(A2),D5                   ; $10748C
        BSET    D6,-$0DEA(PC)                   ; $107490
        MOVE.L  A2,-$49(A2,D1.W)                ; $107494
        MOVE.W  A4,D4                           ; $107498
        MOVEA.B A2,A1                           ; $10749A
        MOVEA.W A2,A2                           ; $10749C
        ADD.L  -(A1),D2                         ; $10749E
        MOVE.L  A2,#$54D4E3D8                   ; $1074A0
        MOVE.L  A4,D0                           ; $1074A6
        ROR.W  #7,D4                            ; $1074A8
        MOVE.B  -$5577(A2),$48(A1,A0.W)         ; $1074AA
        MOVE.B  $0E(A4,A6.W),D3                 ; $1074B0
        OR.B   $1760(A0),D0                     ; $1074B4
        ROXR.B  #8,D1                           ; $1074B8
        SUB.B  D2,$28(A1,A4.W)                  ; $1074BA
        BCHG    D5,-(A0)                        ; $1074BE
        LSR.B  #8,D5                            ; $1074C0
        MOVEA.L -$3301(A2),A5                   ; $1074C2
        MOVEQ   #$09,D6                         ; $1074C6
        MOVE.B  (A6)+,(A2)+                     ; $1074C8
        SUB.L  D1,$00(A0,D1.W)                  ; $1074CA
        MOVE.W  (A3)+,D4                        ; $1074CE
        MOVE.W  -$08(A6,A7.L),D6                ; $1074D0
        MOVE.B  D0,$5573(A5)                    ; $1074D4
        ADD.W  D2,(A0)                          ; $1074D8
        LEA     (A1)+,A0                        ; $1074DA
        MULU    (A1),D7                         ; $1074DC
        SPL     $60(A4,D4.W)                    ; $1074DE
        BTST    D5,$37(A1,D1.L)                 ; $1074E2
        MOVE.L  $7DB5EB28,D5                    ; $1074E6
        DC.W    $0CE0               ; $1074EC DC.W    $0CE0
        MOVE.W  A3,D4                           ; $1074EE
        MOVE.W  $72(A7,D7.W),-(A3)              ; $1074F0
        NEGX   -$20(A0,D0.L)                    ; $1074F4
        MOVE.W  (A1),D4                         ; $1074F8
        MOVE.W  A2,$32AA(PC)                    ; $1074FA
        MOVE.L  -(A1),(A5)                      ; $1074FE
        SUB.B  D0,$FEE0.W                       ; $107500
        MOVE.W  (A2),D4                         ; $107504
        MULU    D1,D0                           ; $107506
        NEGX   -$08(A1,A6.W)                    ; $107508
        MOVE.B  (A3),(A3)+                      ; $10750C
        AND.B  D0,A3                            ; $10750E
        ADD.L  D0,D2                            ; $107510
        BPL.S  loc_1074D2                       ; $107512
        ROL.W  D5,D1                            ; $107514
        MOVE.L  (A1),-$08(A4,A6.W)              ; $107516
        BSET    D7,-$4C(A6,A0.L)                ; $10751A
        AND.W  #$C172,D1                        ; $10751E
        SUBQ.W  #2,(A5)                         ; $107522
        MOVEQ   #-$17,D5                        ; $107524
        MOVE.W  -$4334(A1),#$0066               ; $107526
        MOVE.B  $54DC(A4),(A1)+                 ; $10752C
        BSET    #1,$5505(A3)                    ; $107530
        SUBA.W  A2,A4                           ; $107536
        MOVE.L  (A3),(A7)+                      ; $107538
        ASR.W  A2                               ; $10753A
        EORI.W  #$B88A,-(A1)                    ; $10753C
        MOVE.L  A3,#$55A4AAD8                   ; $107540
        AND.B  D7,$3831(A0)                     ; $107546
        OR.W   D6,(A1)                          ; $10754A
        MOVE.W  $55(A1,D5.L),D7                 ; $10754C
        DC.W    $3BE2               ; $107550 MOVE.W  -(A2),<EA:3D>
        LSL.B  D2,D1                            ; $107552
        MOVE.L  -(A2),(A6)+                     ; $107554
        MOVE.L  -(A2),(A5)+                     ; $107556
        BSET    D5,-$1346(A3)                   ; $107558
        ADDA.L  $2A(A1,A2.L),A1                 ; $10755C
        SUBQ.B  #6,A1                           ; $107560
        MOVE.W  -$1C33(A7),-$74(A3,A6.W)        ; $107562
        ASR.B  #1,D1                            ; $107568
        ASL.B  D4,D0                            ; $10756A
        ADDQ.B  #8,A5                           ; $10756C
        SUB.L  D2,$0855(A1)                     ; $10756E
        CMPA.L  A4,A6                           ; $107572
        ADD.L  -(A5),D1                         ; $107574
        MOVE.L  D3,(A7)                         ; $107576
        SUB.B  A4,D5                            ; $107578
        SUBA.L  (A0),A4                         ; $10757A
        MOVE.W  (A5),-(A0)                      ; $10757C
        SUB.B  D2,-(A0)                         ; $10757E
        ADDQ.B  #4,A1                           ; $107580
        MOVE.L  -(A2),$43C3.W                   ; $107582
        SUB.L  $FD9DFE91,D3                     ; $107586
        DC.W    $B5FF               ; $10758C CMPA.L  <EA:3F>,A2
        ROL.L  #3,D7                            ; $10758E
        ROL.L  D4,D1                            ; $107590
        DC.W    $E3FE               ; $107592 LSL.W  <EA:3E>
        MOVE.L  $0C44(PC),D4                    ; $107594
        DC.W    $0CBC,$FC27,$FD82,$284C,$2882; $107598 CMPI.L  #$FC27FD82,#$284C2882
        BCHG    D7,(A2)                         ; $1075A2
        MOVE.W  A0,$77(A7,D2.L)                 ; $1075A4
        MOVEQ   #-$03,D4                        ; $1075A8
        CMP.B  (A5)+,D4                         ; $1075AA
        ASR.B  D0,D7                            ; $1075AC
        MOVE.W  A4,$045A(A2)                    ; $1075AE
        MOVE.L  -(A3),$41CA(A6)                 ; $1075B2
        NOT.W  D6                               ; $1075B6
        MOVE.W  -(A4),#$5849                    ; $1075B8
        BTST    D4,D4                           ; $1075BC
        ROR.W  -(A5)                            ; $1075BE
        MULS    (A4)+,D0                        ; $1075C0
        SUBQ.B  #5,D4                           ; $1075C2
        BSET    D0,(A2)+                        ; $1075C4
        SUB.W  D3,A0                            ; $1075C6
        MOVE.W  -$1BBB(PC),(A2)                 ; $1075C8
        DC.W    $FDC2               ; $1075CC MOVE.W  D2,<EA:3E>
        MOVEQ   #-$1A,D0                        ; $1075CE
        OR.W   D7,A4                            ; $1075D0
        DC.W    $ADEA,$DD1A         ; $1075D2 MOVE.L  -$22E6(A2),<EA:3E>
        SVC     (A2)+                           ; $1075D6
        SCS     (A6)                            ; $1075D8
        ADD.B  D4,-(A0)                         ; $1075DA
        ADD.W  -$25E4(A2),D1                    ; $1075DC
        DC.W    $0E04               ; $1075E0 DC.W    $0E04
        AND.L  A6,D5                            ; $1075E2
        EOR.L  D7,-$19B2(A5)                    ; $1075E4
        DIVS    -(A4),D3                        ; $1075E8
        BCS.S  loc_10765A                       ; $1075EA
        ROR.W  $D164.W                          ; $1075EC
        MOVE.W  A1,(A1)+                        ; $1075F0
        SNE     D4                              ; $1075F2
        MOVE.W  D6,(A6)+                        ; $1075F4
        ADDQ.W  #3,-$5B(A3,D4.W)                ; $1075F6
        ROXL.B  #8,D1                           ; $1075FA
        MOVE.W  (A1),D1                         ; $1075FC
        MOVE.L  $4EAC(A2),(A0)+                 ; $1075FE
        MOVE.W  $55(A5,D3.L),-$547D(A0)         ; $107602
        SUBQ.B  #4,(A5)+                        ; $107608
        MOVE.W  A1,D4                           ; $10760A
        SCC     -(A2)                           ; $10760C
        SUBI.B  #$C7E2,$31C1(A5)                ; $10760E
        MOVE.W  (A6)+,-(A0)                     ; $107614
        MOVE.L  (A6),$2B40(A0)                  ; $107616
        DC.W    $480B               ; $10761A DC.W    $480B
        BTST    D5,$1DB5(A1)                    ; $10761C
        DC.W    $C1BF               ; $107620 AND.L  D0,<EA:3F>
        ASL.W  #4,D1                            ; $107622
        OR.W   D0,$7B(A7,A7.L)                  ; $107624
        DC.W    $4148               ; $107628 DC.W    $4148
        EORI.W  #$58F0,A2                       ; $10762A
        MOVE.L  -$54(A0,D1.L),D0                ; $10762E
        MOVE.W  $39(A3,D6.W),D6                 ; $107632
        SUBQ.W  #2,(A5)                         ; $107636
        DIVU    -(A2),D0                        ; $107638
        MOVE.L  $10C2(A0),(A0)+                 ; $10763A
        SUBQ.L  #1,A0                           ; $10763E
        DC.W    $4191               ; $107640 DC.W    $4191
        MOVE.B  D0,(A1)                         ; $107642
        ADDQ.B  #8,(A4)                         ; $107644
        LSR.W  $31(A1,A6.W)                     ; $107646
        SUBQ.W  #2,(A5)                         ; $10764A
        AND.B  D1,$4A(A3,D7.L)                  ; $10764C
        ASR.W  $0FC7.W                          ; $107650
        ADDA.L  A2,A0                           ; $107654
        EOR.W  D1,A0                            ; $107656
        AND.L  (A6)+,D5                         ; $107658
loc_10765A:
        MOVE.W  -(A0),(A1)+                     ; $10765A
        MOVE.W  A7,D4                           ; $10765C
        ADD.L  -$1618(A2),D4                    ; $10765E
        MOVE.W  A7,-$79(PC,A7.W)                ; $107662
        SCC     D1                              ; $107666
        DC.W    $0A12,$2050         ; $107668 EORI.B  #$2050,(A2)
        MOVE.B  (A2)+,D2                        ; $10766C
        MOVE.W  -(A0),$5012(A7)                 ; $10766E
        DC.W    $E0FF               ; $107672 ASR.W  <EA:3F>
        BVC.S  loc_1076D3                       ; $107674
        DC.W    $AAFF               ; $107676 MOVE.L  <EA:3F>,(A5)+
        MOVE.L  -$1556(A6),$11BB.W              ; $107678
        ADD.L  D5,-$111F(A2)                    ; $10767E
        MOVE.L  D0,$6111(A0)                    ; $107682
        NEGX.W -(A1)                            ; $107686
        MOVEA.B D0,A5                           ; $107688
        BSR.S  loc_1076EC                       ; $10768A
        SUBQ.B  #5,$1A(A5,D6.L)                 ; $10768C
        MOVEA.L $30(A1,D5.L),A0                 ; $107690
        SPL     $61A1(A5)                       ; $107694
        ADDA.L  $ADFA.W,A5                      ; $107698
        LEA     $5A(A5,D5.W),A1                 ; $10769C
        DC.W    $AA3D               ; $1076A0 MOVE.L  <EA:3D>,D5
        MOVEA.L -$26(A7,D7.L),A5                ; $1076A2
        ROXR.W  D3,D7                           ; $1076A6
        MOVE.B  $5A(A0,D4.W),-(A5)              ; $1076A8
        ADD.B  (A0),D5                          ; $1076AC
        SVS     (A1)                            ; $1076AE
        MOVE.W  -$12(A1,A2.L),(A4)+             ; $1076B0
        DC.W    $FFF9,$AD12,$3459   ; $1076B4 MOVE.W  $AD123459,<EA:3F>
        MOVE.B  $7B(PC,A3.W),(A1)               ; $1076BA
        EOR.W  D5,$1A(A7,D7.W)                  ; $1076BE
        EOR.B  D5,A7                            ; $1076C2
        BTST    D0,(A2)                         ; $1076C4
        MOVE.B  -(A1),-$5E(A0,D2.W)             ; $1076C6
        AND.B  D3,(A1)                          ; $1076CA
        MOVE.W  D0,-(A6)                        ; $1076CC
        DC.W    $00B7,$F5F6,$C600,$FEFA; $1076CE ORI.L  #$F5F6C600,-$06(A7,A7.L)
        MOVE.W  (A6)+,(A1)+                     ; $1076D6
        CMP.W  -$4D(A7,A1.L),D1                 ; $1076D8
        MOVE.B  -(A1),-(A0)                     ; $1076DC
        MOVE.W  $179B.W,-(A6)                   ; $1076DE
        MOVEA.L (A1)+,A6                        ; $1076E2
        MOVE.B  (A3)+,-(A3)                     ; $1076E4
        EOR.B  D5,-(A2)                         ; $1076E6
        MOVE.W  $22(PC,A3.W),(A3)               ; $1076E8
loc_1076EC:
        MOVE.W  -$42(A7,A7.W),(A6)              ; $1076EC
        ROXR.B  #7,D1                           ; $1076F0
        MOVE.W  $11(PC,A3.L),-$65(A4,D2.W)      ; $1076F2
        MOVEA.L (A3)+,A0                        ; $1076F8
        CMP.B  -(A1),D7                         ; $1076FA
        MOVE.W  A0,$6179(A5)                    ; $1076FC
        ROXL.W  -(A3)                           ; $107700
        ROR.B  D4,D5                            ; $107702
        SUBQ.B  #4,-(A1)                        ; $107704
        MOVE.L  (A1)+,$56(A3,D0.W)              ; $107706
        SUBQ.W  #1,(A1)+                        ; $10770A
        MOVEA.L (A4),A3                         ; $10770C
        ROL.W  D5,D2                            ; $10770E
        MOVEA.L -(A0),A0                        ; $107710
        CMPI.B  #$610F,(A7)+                    ; $107712
        MOVE.L  (A0)+,$59EE.W                   ; $107716
        EOR.L  D3,-$4586(A2)                    ; $10771A
        SUB.B  D7,(A7)                          ; $10771E
        OR.B   D4,A0                            ; $107720
        MOVE.L  $600F(A1),-$4A28(A5)            ; $107722
        MOVE.W  -$0085(A0),$C2A1.W              ; $107728
        LEA     D0,A2                           ; $10772E
        ADDQ.B  #8,A2                           ; $107730
        DC.W    $FFF8,$0C37         ; $107732 MOVE.W  $0C37.W,<EA:3F>
        OR.L   -$73(A6,A6.L),D2                 ; $107736
        MOVE.W  -(A0),(A6)                      ; $10773A
        ADDQ.B  #8,A7                           ; $10773C
        MOVE.W  -(A0),$0C(A5,D5.W)              ; $10773E
        EOR.L  D7,-(A2)                         ; $107742
        MOVE.W  -(A0),-$40(A6,D5.W)             ; $107744
        SNE     -$3FB0(A6)                      ; $107748
        MOVE.B  $51(PC,A4.W),-$01(A4,A3.L)      ; $10774C
        CMPA.L  $5442(A6),A7                    ; $107752
        ADDA.W  D0,A4                           ; $107756
loc_107758:
        ADDQ.B  #8,(A7)                         ; $107758
        BCC.S  loc_107758                       ; $10775A
        MOVE.B  -$54(PC,D4.W),(A0)+             ; $10775C
        ROXL.B  D1,D4                           ; $107760
        MOVE.W  A3,(A6)+                        ; $107762
loc_107764:
        MOVEA.L -(A0),A0                        ; $107764
        MOVE.L  -$3F20(A2),D0                   ; $107766
        ADDQ.B  #4,(A4)                         ; $10776A
        MOVEA.L -(A7),A0                        ; $10776C
        AND.W  (A0)+,D0                         ; $10776E
        MOVE.B  -(A0),#$F81B                    ; $107770
        SUB.L  D7,-(A3)                         ; $107774
        NEG.B  (A6)                             ; $107776
        MOVE.L  D6,-$1F04(A3)                   ; $107778
        CMPA.W  D0,A3                           ; $10777C
        ADDQ.B  #4,(A3)                         ; $10777E
        AND.W  D0,D3                            ; $107780
        BLS.S  loc_107764                       ; $107782
        DC.W    $FBEB,$C141         ; $107784 MOVE.W  -$3EBF(A3),<EA:3D>
        DIVU    D1,D5                           ; $107788
        DC.W    $41A8               ; $10778A DC.W    $41A8
        SUB.L  D4,-$5566(A2)                    ; $10778C
        SUB.L  (A0),D5                          ; $107790
        MOVE.W  D0,$400F.W                      ; $107792
        OR.B   -$76(A0,A5.W),D5                 ; $107796
        ADD.L  D7,-$5721(A0)                    ; $10779A
        MOVE.L  -(A0),$4018(A4)                 ; $10779E
        OR.W   D0,D0                            ; $1077A2
        DC.W    $0EF0               ; $1077A4 DC.W    $0EF0
        DC.W    $06AF,$FFFA,$F9FA,$FAE0; $1077A6 ADDI.L  #$FFFAF9FA,-$0520(A7)
        MOVE.W  (A0),D4                         ; $1077AE
        DC.W    $9ABE               ; $1077B0 SUB.L  <EA:3E>,D5
        DC.W    $4300               ; $1077B2 DC.W    $4300
        MOVE.W  -$5021(PC),-(A5)                ; $1077B4
        SUBA.L  -(A2),A7                        ; $1077B8
        ADD.B  D5,D7                            ; $1077BA
        DC.W    $00E0               ; $1077BC DC.W    $00E0
        MOVE.W  D0,D7                           ; $1077BE
        MOVE.W  D0,D0                           ; $1077C0
        DC.W    $0000,$0000         ; $1077C2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $1077C6 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $1077CA ORI.B  #$0000,D0
        BCHG    D6,D1                           ; $1077CE
        DC.W    $11FF,$F837         ; $1077D0 MOVE.B  <EA:3F>,$F837.W
        DC.W    $81FD               ; $1077D4 DIVS    <EA:3D>,D0
        DC.W    $18FF               ; $1077D6 MOVE.B  <EA:3F>,(A4)+
        ROXL.W  $0CCC.W                         ; $1077D8
        LSR.W  -$19(A0,A0.L)                    ; $1077DC
        DC.W    $FFF8,$12D5         ; $1077E0 MOVE.W  $12D5.W,<EA:3F>
        OR.B   -$79(A3,D6.W),D4                 ; $1077E4
        MOVE.W  A0,-$26(A3,A7.L)                ; $1077E8
        AND.L  D1,D4                            ; $1077EC
        MOVE.B  D3,-$2708(A6)                   ; $1077EE
        MOVE.B  $FD18.W,-$2E(A2,A0.W)           ; $1077F2
        DC.W    $18FD               ; $1077F8 MOVE.B  <EA:3D>,(A4)+
        AND.B  D1,D6                            ; $1077FA
        LSL.W  -(A6)                            ; $1077FC
        MOVE.W  A7,D4                           ; $1077FE
        DC.W    $C9BF               ; $107800 AND.L  D4,<EA:3F>
        DC.W    $77FF,$7C80         ; $107802 MOVE.W  <EA:3F>,-$80(PC,D7.L)
        MOVEA.B #$E3FF,A1                       ; $107806
        DC.W    $A2FF               ; $10780A MOVE.L  <EA:3F>,(A1)+
        ASR.B  D4,D2                            ; $10780C
        MOVE.L  A7,(A0)+                        ; $10780E
        MOVE.W  -$63(PC,A6.W),(A5)+             ; $107810
        MOVE.B  -(A4),$EEEE.W                   ; $107814
        ROXR.W  -(A0)                           ; $107818
        ASR.B  D1,D0                            ; $10781A
        MOVE.L  A5,(A1)                         ; $10781C
        AND.L  D3,D1                            ; $10781E
        LSL.W  -(A4)                            ; $107820
        MOVEQ   #-$40,D3                        ; $107822
        LSR.W  A4                               ; $107824
        ASR.W  #$CCEC                           ; $107826
        ADDA.L  A1,A7                           ; $10782A
        NEGX.B D1                               ; $10782C
        DIVS    -(A3),D0                        ; $10782E
        MOVEA.L $E022.W,A6                      ; $107830
        DIVU    (A7)+,D2                        ; $107834
        MOVE.B  #$F878,(A4)+                    ; $107836
        MOVE.W  -(A1),-(A0)                     ; $10783A
        SUBA.W  D7,A2                           ; $10783C
        MULS    -$63(A7,A6.L),D3                ; $10783E
        MOVE.W  (A2)+,-$01F8(A3)                ; $107842
        DIVS    $1149.W,D0                      ; $107846
        AND.W  D6,D0                            ; $10784A
        BRA.S  loc_107865                       ; $10784C
        DC.W    $D93D               ; $10784E ADD.B  D4,<EA:3D>
        MOVE.W  (A3)+,D4                        ; $107850
        ROR.B  D3,D4                            ; $107852
        ADDQ.B  #8,A4                           ; $107854
        MOVE.W  D2,-$07F4(A7)                   ; $107856
        DC.W    $B8FD               ; $10785A CMPA.W  <EA:3D>,A4
        AND.B  (A1),D0                          ; $10785C
        OR.L   -$0A(A2,A1.W),D0                 ; $10785E
        SUB.L  D0,-$4A(PC,A7.W)                 ; $107862
        MOVE.B  D5,(A1)                         ; $107866
        CMPA.L  -$01(A0,D0.L),A1                ; $107868
        MOVE.W  $5387(PC),-(A6)                 ; $10786C
        BLE.W  loc_10793E                       ; $107870
        ADDQ.W  #6,A0                           ; $107874
        ADD.B  (A0)+,D1                         ; $107876
        DC.W    $C33D               ; $107878 AND.B  D1,<EA:3D>
        MOVEQ   #$77,D7                         ; $10787A
        MOVEQ   #-$79,D7                        ; $10787C
        MOVE.W  $0008.W,$77E2(A4)               ; $10787E
        MOVE.W  $8800.W,-(A7)                   ; $107884
        MOVE.W  (A7),(A6)+                      ; $107888
        ADDA.L  (A4),A6                         ; $10788A
        DC.W    $4301               ; $10788C DC.W    $4301
        DC.W    $FFCE               ; $10788E MOVE.W  A6,<EA:3F>
        MOVE.W  D4,-$3321(A3)                   ; $107890
        DC.W    $F3F7,$6024,$EAFA,$78CC; $107894 MOVE.W  $24(A7,D6.W),$EAFA78CC
        MOVE.W  -$78(A4,A4.W),-(A1)             ; $10789C
        MOVE.W  (A0)+,(A4)+                     ; $1078A0
        MOVEQ   #$09,D6                         ; $1078A2
        MOVE.L  (A5),D0                         ; $1078A4
        ROL.W  A5                               ; $1078A6
        MOVE.W  -$79(A2,D7.L),(A5)+             ; $1078A8
        MULU    $11(A1,D0.W),D3                 ; $1078AC
        LSR.W  -$2232(PC)                       ; $1078B0
        ADD.L  D0,A4                            ; $1078B4
        ADDA.W  (A4)+,A4                        ; $1078B6
        MULU    -$32(A0,D2.W),D0                ; $1078B8
        ADD.B  D7,D0                            ; $1078BC
        DIVS    -(A6),D0                        ; $1078BE
        MOVE.B  -$7807(A1),(A6)+                ; $1078C0
        DC.W    $0011,$91FF         ; $1078C4 ORI.B  #$91FF,(A1)
        ASR.L  #2,D0                            ; $1078C8
        BSET    D0,(A1)                         ; $1078CA
        DC.W    $A3F6,$DFF6,$80F8,$1D28; $1078CC MOVE.L  -$0A(A6,A5.L),$80F81D28
        DIVU    D7,D4                           ; $1078D4
        MOVE.L  D6,-$0B01(A4)                   ; $1078D6
        DC.W    $29F3,$0110,$FF78,$DAFE; $1078DA MOVE.L  $10(A3,D0.W),#$FF78DAFE
        MOVE.W  (A5),D4                         ; $1078E2
        MOVE.B  -(A2),(A2)+                     ; $1078E4
        MOVE.L  -$0F(A4,D2.W),(A0)+             ; $1078E6
        SUB.L  D6,$64(A6,A7.W)                  ; $1078EA
        MOVE.W  A5,D1                           ; $1078EE
        DC.W    $002A,$64F1,$C7AC   ; $1078F0 ORI.B  #$64F1,-$3854(A2)
        MOVEA.L (A0),A2                         ; $1078F6
        MOVE.B  (A0)+,(A0)+                     ; $1078F8
        ADD.W  D4,$A3F0.W                       ; $1078FA
        BSET    D4,(A7)+                        ; $1078FE
        BSET    D0,-$76(A2,A4.W)                ; $107900
        AND.W  D3,$FF88.W                       ; $107904
        MOVEQ   #-$2A,D4                        ; $107908
        LSR.W  D0                               ; $10790A
        MOVE.W  D0,-(A1)                        ; $10790C
        NEG.W  (A4)+                            ; $10790E
        EOR.W  D4,$30(A5,A3.W)                  ; $107910
        MOVE.L  D3,-$4788(A0)                   ; $107914
        OR.L   D3,A4                            ; $107918
        MOVE.L  A2,-$70(A5,D2.L)                ; $10791A
        MOVE.W  (A3),D0                         ; $10791E
        MOVEM.L -$17(A3,D2.L),D1/D4/D5/D6/D7/A0/A4/A5/A6; $107920
        LSL.W  D5,D2                            ; $107926
        LSR.B  #4,D4                            ; $107928
        DIVS    $28(A1,A0.W),D3                 ; $10792A
        SUBQ.L  #1,-(A2)                        ; $10792E
        MOVE.W  -$05(A3,D2.W),(A5)+             ; $107930
        MOVE.W  D6,-$2FFB(A0)                   ; $107934
        DC.W    $77FD,$6F90         ; $107938 MOVE.W  <EA:3D>,-$70(PC,D6.L)
        MOVE.W  -(A6),$0E(A2,A6.L)              ; $10793C
        DIVU    A6,D0                           ; $107940
        MOVE.W  -$32(A1,A6.L),$19FD.W           ; $107942
        MOVE.B  -(A1),(A1)                      ; $107948
        OR.W   D0,-(A4)                         ; $10794A
        MOVE.W  #$0FFC,$8040.W                  ; $10794C
        BRA.S  loc_107947                       ; $107952
        DC.W    $FFFC,$D780         ; $107954 MOVE.W  #$D780,<EA:3F>
        MOVE.L  (A0),(A0)+                      ; $107958
        ADDA.L  -$261B(A1),A2                   ; $10795A
        MOVE.W  -$03(A0,A0.W),$76(A0,D0.W)      ; $10795E
        ASL.W  -(A0)                            ; $107964
        ROL.L  #4,D3                            ; $107966
        MOVE.L  -$6F0E(A2),D0                   ; $107968
        MOVE.L  (A0)+,(A5)+                     ; $10796C
        ROXR.L  #5,D0                           ; $10796E
        ASL.W  (A6)+                            ; $107970
        ROXR.L  #5,D3                           ; $107972
        LSR.L  #6,D5                            ; $107974
        ROR.B  #4,D1                            ; $107976
        MOVE.L  (A1)+,$4F20(A0)                 ; $107978
        DC.W    $7BF1,$8714         ; $10797C MOVE.W  $14(A1,A0.W),<EA:3D>
        MULU    $5414(A1),D6                    ; $107980
        BGE.S  loc_10790F                       ; $107984
        ROXL.W  D7,D0                           ; $107986
        ASR.W  #5,D0                            ; $107988
        ROL.W  $58(A1,D1.W)                     ; $10798A
        ASL.W  -(A0)                            ; $10798E
        MOVE.W  D4,$F1E2.W                      ; $107990
        LSR.B  D0,D0                            ; $107994
        MOVE.W  (A4),-(A6)                      ; $107996
        MOVE.B  -(A5),(A0)+                     ; $107998
        MOVE.L  -(A2),$38(PC,D3.W)              ; $10799A
        NEG.L  (A5)                             ; $10799E
        MOVE.W  (A5)+,(A7)                      ; $1079A0
        MOVE.W  -$0F(A5,A3.W),-$09(A0,A6.L)     ; $1079A2
        ADDA.W  $30(A0,D0.L),A6                 ; $1079A8
        MOVEA.L -$4379(A5),A5                   ; $1079AC
        DC.W    $3FE0               ; $1079B0 MOVE.W  -(A0),<EA:3F>
        LSL.W  A5                               ; $1079B2
        MOVE.W  $22FF(A0),D2                    ; $1079B4
        LSR.W  -(A3)                            ; $1079B8
        ROL.W  -$80(A1,A3.L)                    ; $1079BA
        OR.L   D0,(A3)                          ; $1079BE
        DC.W    $9EFF               ; $1079C0 SUBA.W  <EA:3F>,A7
        DC.W    $CEFE               ; $1079C2 MULU    <EA:3E>,D7
        OR.B   (A7),D4                          ; $1079C4
        BCC.S  loc_107A12                       ; $1079C6
        BTST    D2,-(A7)                        ; $1079C8
        MOVE.W  -(A6),-(A0)                     ; $1079CA
        MOVE.W  -(A5),-(A2)                     ; $1079CC
        MOVE.W  D1,$C72C.W                      ; $1079CE
        MOVE.W  $25(A7,D4.W),(A7)               ; $1079D2
        MOVE.W  A5,(A5)                         ; $1079D6
        MOVE.L  -$11(A2,A0.W),(A0)+             ; $1079D8
        ADD.W  D1,(A5)                          ; $1079DC
        TST.W  -(A3)                            ; $1079DE
        MOVE.W  A4,D0                           ; $1079E0
        ROXR.W  -$0F(A2,A1.W)                   ; $1079E2
        SUBA.L  -$39(A1,A5.L),A5                ; $1079E6
        MOVE.L  (A6),(A1)                       ; $1079EA
        CMP.L  -(A0),D3                         ; $1079EC
        ROXR.B  #8,D0                           ; $1079EE
        MOVE.W  A1,-$7744(A7)                   ; $1079F0
        ROXL.B  #4,D1                           ; $1079F4
        LEA     -(A0),A2                        ; $1079F6
        BNE.S  loc_107A76                       ; $1079F8
        BVC.S  loc_1079D7                       ; $1079FA
        BRA.S  loc_1079A1                       ; $1079FC
        DIVU    D0,D1                           ; $1079FE
        ADD.B  A5,D4                            ; $107A00
        MOVEQ   #$7B,D6                         ; $107A02
        DIVS    -$0D(A2,A0.L),D6                ; $107A04
        ADDA.W  A2,A0                           ; $107A08
        TST    -$03(A1,A7.W)                    ; $107A0A
        ROL.W  #1,D6                            ; $107A0E
        MOVE.W  $14F1.W,-$0D0F(A6)              ; $107A10
        EOR.W  D7,A1                            ; $107A16
        BLE.S  loc_1079E8                       ; $107A18
        MULU    A4,D7                           ; $107A1A
        ROXR.W  -$11B2(A4)                      ; $107A1C
        MOVE.W  A6,$E13E.W                      ; $107A20
        MOVEA.W -(A3),A6                        ; $107A24
        ADDQ.B  #8,(A4)                         ; $107A26
        DC.W    $F3EE,$E9EE,$EAF8,$FD14; $107A28 MOVE.W  -$1612(A6),$EAF8FD14
        MOVE.W  D1,$5207(A0)                    ; $107A30
        DC.W    $F1FE,$6BE1         ; $107A34 MOVE.W  <EA:3E>,$6BE1.W
        LSL.W  -$0DE0(A4)                       ; $107A38
        LSR.B  #8,D6                            ; $107A3C
        SUB.B  D2,D4                            ; $107A3E
        MOVEQ   #-$04,D4                        ; $107A40
        MOVE.L  (A5)+,(A0)+                     ; $107A42
        LEA     $6F31(A2),A7                    ; $107A44
        ROXL.W  #8,D4                           ; $107A48
        SUBI.L  #$83FA7EE2,(A2)                 ; $107A4A
        LSR.B  #6,D4                            ; $107A50
        MOVE.W  (A3)+,-$03(A7,A4.L)             ; $107A52
        DC.W    $15BE,$1544         ; $107A56 MOVE.B  <EA:3E>,$44(A2,D1.W)
        MOVEQ   #$18,D4                         ; $107A5A
        ADDQ.W  #2,D4                           ; $107A5C
        MOVE.W  D1,-(A3)                        ; $107A5E
        ADDI.L  #$44FCF944,D5                   ; $107A60
        DC.W    $C5FD               ; $107A66 MULS    <EA:3D>,D2
        DC.W    $FEFF               ; $107A68 MOVE.W  <EA:3F>,(A7)+
        MOVE.W  -(A6),$6222(A7)                 ; $107A6A
        MOVE.B  $66(A3,D6.W),-(A0)              ; $107A6E
        MOVEA.L (A3),A1                         ; $107A72
        MOVE.W  -$10(A6,D6.W),-(A1)             ; $107A74
        BLS.S  loc_107ACD                       ; $107A78
        MOVE.W  -(A3),$5535(A5)                 ; $107A7A
        MOVE.W  -$09(A6,D4.W),D3                ; $107A7E
        ADDQ.B  #2,(A0)+                        ; $107A82
        MOVE.W  $45(A7,D3.W),$F791.W            ; $107A84
        OR.B   -(A2),D4                         ; $107A8A
        OR.L   D0,D2                            ; $107A8C
        MOVE.L  (A6)+,-$04(PC,D2.W)             ; $107A8E
        DC.W    $00C3               ; $107A92 DC.W    $00C3
        DC.W    $FBE2               ; $107A94 MOVE.W  -(A2),<EA:3D>
        MOVEA.W -(A3),A5                        ; $107A96
        BLS.S  loc_107A6D                       ; $107A98
        MOVE.W  D0,-(A1)                        ; $107A9A
        SUBQ.B  #3,-$1E(A5,A6.W)                ; $107A9C
        SUBQ.W  #1,(A5)                         ; $107AA0
        MOVEQ   #$5A,D6                         ; $107AA2
        MOVE.W  -(A2),(A1)+                     ; $107AA4
        ASR.W  #1,D3                            ; $107AA6
        MOVEQ   #$70,D6                         ; $107AA8
        MOVEA.W #$3E22,A1                       ; $107AAA
        MOVE.L  $6E(A2,D6.W),D0                 ; $107AAE
        ASR.B  #7,D0                            ; $107AB2
        DC.W    $00E5               ; $107AB4 DC.W    $00E5
        DC.W    $D8BD               ; $107AB6 ADD.L  <EA:3D>,D4
        MOVE.W  D5,-$2B(A7,D0.W)                ; $107AB8
        MOVE.W  (A0),(A2)                       ; $107ABC
        MOVEA.W -$47(A4,A6.L),A1                ; $107ABE
        ASL.W  A6                               ; $107AC2
loc_107AC4:
        ADD.B  D6,(A1)                          ; $107AC4
        DC.W    $0031,$EA16,$FFBE   ; $107AC6 ORI.B  #$EA16,-$42(A1,A7.L)
        BPL.S  loc_107B26                       ; $107ACC
        MOVE.W  $F8D1.W,-$541F(A7)              ; $107ACE
        MOVE.B  (A6)+,(A4)+                     ; $107AD4
        OR.L   D3,D1                            ; $107AD6
        BVS.S  loc_107ABB                       ; $107AD8
        BCLR    D0,D4                           ; $107ADA
        MOVE.B  -(A1),(A2)+                     ; $107ADC
        MOVE.W  (A2)+,(A1)+                     ; $107ADE
        BRA.S  loc_107AC4                       ; $107AE0
        ASR.W  #7,D1                            ; $107AE2
        SUBQ.B  #2,-$0E(A3,D3.L)                ; $107AE4
        MOVE.W  -(A1),$A8D4E5E9                 ; $107AE8
        CMPA.W  -$5F2E(A1),A0                   ; $107AEE
        DC.W    $4555               ; $107AF2 DC.W    $4555
        BCC.S  loc_107AE7                       ; $107AF4
        ADDA.W  -(A1),A1                        ; $107AF6
        MOVE.B  (A6)+,-$0D4A(A5)                ; $107AF8
        ROXL.B  D4,D4                           ; $107AFC
        ADD.B  -$22AB(A4),D5                    ; $107AFE
        DC.W    $553F               ; $107B02 SUBQ.B  #2,<EA:3F>
        ROXR.B  #2,D4                           ; $107B04
        ADD.W  (A7)+,D5                         ; $107B06
        ADDA.W  A0,A2                           ; $107B08
        ROR.L  D2,D2                            ; $107B0A
        DC.W    $E4FF               ; $107B0C ROXR.W  <EA:3F>
        MOVE.W  (A5),D4                         ; $107B0E
        SEQ     -$0F14(A1)                      ; $107B10
        MOVE.L  (A0),D3                         ; $107B14
        MULS    D7,D6                           ; $107B16
        MOVE.W  D5,-$0E7D(A7)                   ; $107B18
        DC.W    $A0FD               ; $107B1C MOVE.L  <EA:3D>,(A0)+
        DIVS    $A7F1.W,D3                      ; $107B1E
        DC.W    $3179,$E2B2,$1070,$E29B; $107B22 MOVE.W  $E2B21070,-$1D65(A0)
        ASL.W  -(A0)                            ; $107B2A
        SVS     (A2)+                           ; $107B2C
        LSL.L  #1,D4                            ; $107B2E
        MOVE.L  $7387(A0),-$17(A5,A5.W)         ; $107B30
        MOVEQ   #-$2B,D0                        ; $107B36
        DC.W    $86FD               ; $107B38 DIVU    <EA:3D>,D3
        MULS    -$1ED8(A0),D5                   ; $107B3A
        ADDQ.L  #4,-(A0)                        ; $107B3E
        LSR.W  D5,D0                            ; $107B40
        DC.W    $00DE               ; $107B42 DC.W    $00DE
        ADD.W  D1,A5                            ; $107B44
        AND.L  D6,A0                            ; $107B46
        DC.W    $7DE5               ; $107B48 MOVE.W  -(A5),<EA:3E>
        SUBQ.B  #2,A1                           ; $107B4A
        DC.W    $0CC8               ; $107B4C DC.W    $0CC8
        DC.W    $0EBF               ; $107B4E DC.W    $0EBF
        LSR.W  #5,D3                            ; $107B50
        LSR.L  D1,D4                            ; $107B52
        DC.W    $DBFF               ; $107B54 ADDA.L  <EA:3F>,A5
        MOVE.W  (A2),D4                         ; $107B56
        ROXR.L  D2,D1                           ; $107B58
        SUB.L  -(A0),D1                         ; $107B5A
        ASR.L  #2,D1                            ; $107B5C
        MULS    $0ABD.W,D3                      ; $107B5E
        AND.L  -$6E(A3,A2.L),D6                 ; $107B62
        DC.W    $E0FD               ; $107B66 ASR.W  <EA:3D>
        BVC.S  loc_107B53                       ; $107B68
        DIVS    (A2)+,D5                        ; $107B6A
        SUBA.L  (A1),A4                         ; $107B6C
        MULU    -(A2),D0                        ; $107B6E
        MOVE.L  (A1)+,(A0)+                     ; $107B70
        OR.W   D5,A4                            ; $107B72
        MOVE.L  (A4),(A5)                       ; $107B74
        MULS    -(A1),D5                        ; $107B76
        MOVEA.W A0,A2                           ; $107B78
        ASL.B  #5,D4                            ; $107B7A
        ADD.L  -$1CF4(A0),D5                    ; $107B7C
        MOVE.L  -(A0),(A5)+                     ; $107B80
        MOVE.W  (A1),(A6)+                      ; $107B82
        ADD.W  (A6),D0                          ; $107B84
        ADD.W  D5,-$11(A7,A5.L)                 ; $107B86
        MULS    D0,D4                           ; $107B8A
loc_107B8C:
        MOVE.L  D3,D5                           ; $107B8C
        ADDA.W  $C8C8.W,A5                      ; $107B8E
        ADD.L  D4,D4                            ; $107B92
        MOVE.W  $2A(A2,A6.L),-$1B(A0,A2.W)      ; $107B94
        LSR.W  (A2)                             ; $107B9A
        DIVU    D4,D2                           ; $107B9C
        SUB.B  A4,D2                            ; $107B9E
        MOVE.L  A2,(A2)+                        ; $107BA0
        ADDA.W  -(A4),A2                        ; $107BA2
        MOVE.B  -$0D05(A7),(A4)+                ; $107BA4
        ASR.B  D1,D5                            ; $107BA8
        ADD.W  D4,-$56(A4,A7.W)                 ; $107BAA
        MOVEA.L $56FE(A0),A2                    ; $107BAE
        BRA.S  loc_107B8C                       ; $107BB2
        DC.W    $0988               ; $107BB4 BCLR    D4,A0
        MOVE.W  (A3)+,(A6)+                     ; $107BB6
        ADD.W  D4,D5                            ; $107BB8
        DC.W    $02CE               ; $107BBA DC.W    $02CE
        MOVE.L  A1,(A5)+                        ; $107BBC
        DIVU    -$0E(A1,A0.W),D4                ; $107BBE
        ADDA.W  -(A2),A0                        ; $107BC2
        MULU    -(A3),D4                        ; $107BC4
        SUB.B  -$80(A0,A6.L),D0                 ; $107BC6
        MOVE.L  $FDC3.W,(A5)                    ; $107BCA
        DIVS    -$1E(A3,A3.W),D3                ; $107BCE
        BEQ.S  loc_107BC5                       ; $107BD2
        OR.B   (A7)+,D5                         ; $107BD4
        ADD.B  D5,(A4)+                         ; $107BD6
        ADD.W  D1,$7818(A0)                     ; $107BD8
        DIVS    D7,D3                           ; $107BDC
        MOVE.W  -(A5),-(A0)                     ; $107BDE
        BCHG    D2,(A0)+                        ; $107BE0
        MOVE.W  $5588(A2),(A6)+                 ; $107BE2
        DC.W    $FDB9,$F00E,$8074,$0DC1; $107BE6 MOVE.W  $F00E8074,-$3F(A6,D0.L)
        MULU    (A5),D0                         ; $107BEE
        MULU    -$502D(A4),D7                   ; $107BF0
        MOVE.L  -(A2),#$E83F49FB                ; $107BF4
        OR.B   -$7D(A5,D1.W),D3                 ; $107BFA
        MOVE.W  (A4),-$1B74(A2)                 ; $107BFE
        LSR.W  $1FFF.W                          ; $107C02
        ASL.W  D4,D5                            ; $107C06
        AND.W  -(A5),D4                         ; $107C08
        SUBQ.W  #2,(A5)                         ; $107C0A
        MOVE.W  (A5),$5454(A2)                  ; $107C0C
        OR.W   -(A1),D3                         ; $107C10
        MOVEA.W D5,A5                           ; $107C12
        NEG    $5444(PC)                        ; $107C14
        LSR.W  $640C(A0)                        ; $107C18
        BSET    D1,$54FD(A1)                    ; $107C1C
        NEG.W  D4                               ; $107C20
        ASL.L  #4,D0                            ; $107C22
        DC.W    $2FFC,$EAFF,$F82E   ; $107C24 MOVE.L  #$EAFFF82E,<EA:3F>
        SUBQ.W  #2,(A3)                         ; $107C2A
        SUBQ.W  #1,D5                           ; $107C2C
        MOVE.W  -(A1),$00(PC,D1.W)              ; $107C2E
        DC.W    $AFF8,$FFAB         ; $107C32 MOVE.L  $FFAB.W,<EA:3F>
        ADDI.B  #$FC45,D0                       ; $107C36
        DC.W    $FFE7               ; $107C3A MOVE.W  -(A7),<EA:3F>
        MOVE.W  $44B2(A4),-(A3)                 ; $107C3C
        LEA     (A5)+,A2                        ; $107C40
        ASL.W  $53E7(A7)                        ; $107C42
        MOVE.W  D6,-$6F1F(A0)                   ; $107C46
        ADD.W  D6,(A3)                          ; $107C4A
        MOVE.W  $2C(A5,A7.L),D0                 ; $107C4C
        MOVE.L  $55A0.W,(A1)+                   ; $107C50
        ASL.W  -$04C0(A1)                       ; $107C54
        MULU    $33(A3,A7.L),D0                 ; $107C58
        LSR.W  -$01(A5,A7.W)                    ; $107C5C
        MOVEA.W D4,A5                           ; $107C60
        LSL.L  D0,D2                            ; $107C62
        MOVE.W  $5B(PC,D5.W),(A1)               ; $107C64
        DC.W    $32BD               ; $107C68 MOVE.W  <EA:3D>,(A1)
        EOR.L  D5,$4B(PC,D3.W)                  ; $107C6A
        SUBI.B  #$9DBB,-$631E(A5)               ; $107C6E
        DC.W    $D0BF               ; $107C74 ADD.L  <EA:3F>,D0
        MOVEA.B -(A3),A0                        ; $107C76
        DC.W    $94FF               ; $107C78 SUBA.W  <EA:3F>,A2
        MOVE.L  -$05(PC,A3.L),(A5)+             ; $107C7A
        EOR.B  D5,(A0)+                         ; $107C7E
        DC.W    $02FB               ; $107C80 DC.W    $02FB
        LEA     (A5)+,A2                        ; $107C82
        ADD.L  D6,-$0D84(A2)                    ; $107C84
        MOVEQ   #$16,D4                         ; $107C88
        DC.W    $AABD               ; $107C8A MOVE.L  <EA:3D>,(A5)
        DC.W    $DDFF               ; $107C8C ADDA.L  <EA:3F>,A6
        DC.W    $33F4,$DD53,$333B,$380C; $107C8E MOVE.W  $53(A4,A5.L),$333B380C
        ADD.B  $3B(PC,A3.W),D0                  ; $107C96
        OR.B   -$55FF(PC),D4                    ; $107C9A
        DC.W    $1AFF               ; $107C9E MOVE.B  <EA:3F>,(A5)+
        LEA     -$23BD(A5),A1                   ; $107CA0
        NEGX   -$01(A2,A7.L)                    ; $107CA4
        MOVE.B  #$DDF9,(A0)+                    ; $107CA8
        DC.W    $9FFD               ; $107CAC SUBA.L  <EA:3D>,A7
        CMPA.L  (A7)+,A6                        ; $107CAE
        DC.W    $FDCD               ; $107CB0 MOVE.W  A5,<EA:3E>
        ADDA.L  D2,A6                           ; $107CB2
        DC.W    $0FFF               ; $107CB4 BSET    D7,<EA:3F>
        MULS    (A4),D5                         ; $107CB6
        CMPA.L  A3,A5                           ; $107CB8
        MOVE.L  $66(A5,D3.L),-(A1)              ; $107CBA
        MOVEA.B -(A0),A2                        ; $107CBE
        MOVEQ   #-$57,D7                        ; $107CC0
        ROR.W  (A0)                             ; $107CC2
        MOVE.L  (A5)+,(A0)+                     ; $107CC4
        CMP.B  (A0)+,D2                         ; $107CC6
        AND.W  (A3),D1                          ; $107CC8
        ADDA.L  (A3)+,A6                        ; $107CCA
        MOVE.L  (A3)+,-$5C(PC,A4.L)             ; $107CCC
        MOVEA.W -$4549(A2),A0                   ; $107CD0
        MOVE.W  -(A5),-$26(A1,D3.W)             ; $107CD4
        MOVE.W  A0,(A1)+                        ; $107CD8
        DC.W    $F23E               ; $107CDA MOVE.W  <EA:3E>,D1
        SUBI.W  #$FCEE,(A0)                     ; $107CDC
        MOVE.W  A1,(A5)+                        ; $107CE0
        ADDA.L  -$26EF(A1),A4                   ; $107CE2
        ADDQ.B  #8,$FCC8.W                      ; $107CE6
        TST    $94E00B12                        ; $107CEA
loc_107CF0:
        SUBA.L  (A4)+,A0                        ; $107CF0
        BSET    D6,-(A1)                        ; $107CF2
        MOVE.L  (A0)+,(A4)+                     ; $107CF4
        DC.W    $4183               ; $107CF6 DC.W    $4183
        DC.W    $F8FF               ; $107CF8 MOVE.W  <EA:3F>,(A4)+
        BSR.S  loc_107CF0                       ; $107CFA
        SGT     -(A3)                           ; $107CFC
        MULU    -$68(A3,D4.L),D7                ; $107CFE
        ROXR.W  (A1)+                           ; $107D02
        CMPA.L  A1,A1                           ; $107D04
        DC.W    $B83E               ; $107D06 CMP.B  <EA:3E>,D4
        MOVE.L  -$1F40(PC),(A6)+                ; $107D08
        EOR.B  D6,(A1)                          ; $107D0C
        AND.L  $1848.W,D0                       ; $107D0E
        DC.W    $D6FE               ; $107D12 ADDA.W  <EA:3E>,A3
        ROXL.L  D5,D4                           ; $107D14
        ADD.W  D4,$11(A3,D3.W)                  ; $107D16
        AND.B  D1,D1                            ; $107D1A
        MULU    D5,D6                           ; $107D1C
        MOVE.W  #$AA53,-(A1)                    ; $107D1E
        MOVE.W  (A4),$7C84(A6)                  ; $107D22
        SUBA.L  $13(A7,A6.L),A3                 ; $107D26
        MOVE.W  -$10(A6,D1.W),-(A1)             ; $107D2A
        ASR.W  #6,D0                            ; $107D2E
        ROXL.W  #1,D5                           ; $107D30
        LSL.W  #$DBA5                           ; $107D32
        MOVE.W  -$7A(PC,D3.W),$66(A5,A2.W)      ; $107D36
        ROXL.B  D2,D6                           ; $107D3C
        ADD.W  -(A3),D5                         ; $107D3E
        MOVE.B  $31(A0,D1.L),-(A1)              ; $107D40
        BGT.S  loc_107DAC                       ; $107D44
        BLS.S  loc_107CD1                       ; $107D46
        MOVE.W  (A2),(A4)+                      ; $107D48
        BLS.S  loc_107CE1                       ; $107D4A
        BCHG    D0,-(A0)                        ; $107D4C
        MOVE.L  -$02(A4,A4.W),(A4)+             ; $107D4E
        CMPA.L  -(A1),A7                        ; $107D52
        MOVE.W  (A5),-$21BB(PC)                 ; $107D54
        MOVEA.W (A0)+,A6                        ; $107D58
        MOVEA.W (A5),A2                         ; $107D5A
        ADDQ.B  #2,(A1)                         ; $107D5C
        MOVE.W  -$0ED0(PC),-$0E2C(PC)           ; $107D5E
        LSL.B  #4,D0                            ; $107D64
        AND.W  (A4),D0                          ; $107D66
        MOVE.W  $ED08.W,#$5101                  ; $107D68
        MOVE.B  $63DF.W,(A7)+                   ; $107D6E
        MOVE.W  $5589(A5),#$B5E9                ; $107D72
        MOVE.B  -$04(A1,A7.L),(A1)+             ; $107D78
        MOVE.L  -$0F03(A1),-$08FB(PC)           ; $107D7C
        BSET    D4,-(A1)                        ; $107D82
        DC.W    $A9EA,$F6A3,$EBEF,$451B; $107D84 MOVE.L  -$095D(A2),#$EBEF451B
        ASL.L  #3,D3                            ; $107D8C
        LSR.W  (A7)+                            ; $107D8E
        ADDA.W  -$40(A1,A3.L),A2                ; $107D90
        ROXL.B  D4,D3                           ; $107D94
        NEG.B  -(A2)                            ; $107D96
        MOVE.W  D0,(A1)+                        ; $107D98
        ASL.W  -$68(A7,A2.W)                    ; $107D9A
        MOVE.L  -$1F08(A7),D1                   ; $107D9E
        EOR.L  D5,-$23(PC,A3.L)                 ; $107DA2
        MOVE.W  -(A4),-(A5)                     ; $107DA6
        MOVE.W  D4,(A1)                         ; $107DA8
        DC.W    $02FB               ; $107DAA DC.W    $02FB
loc_107DAC:
        ADD.L  D5,A7                            ; $107DAC
        BMI.S  loc_107DA0                       ; $107DAE
        ROL.W  #4,D2                            ; $107DB0
        NEGX.B -$7E(A4,A7.L)                    ; $107DB2
        ADDQ.W  #2,-(A0)                        ; $107DB6
        SLT     $0C(A1,D5.W)                    ; $107DB8
        AND.B  D1,(A5)+                         ; $107DBC
        ADD.L  D5,$14BB(A2)                     ; $107DBE
        DC.W    $AAFD               ; $107DC2 MOVE.L  <EA:3D>,(A5)+
        EOR.B  D5,$0E35(A2)                     ; $107DC4
        MULU    $40FD(A1),D7                    ; $107DC8
        SUBA.W  $37A4(A5),A4                    ; $107DCC
        SUBQ.B  #1,D0                           ; $107DD0
        MOVE.W  -$3B44(A2),(A0)+                ; $107DD2
        ADDA.W  (A7)+,A3                        ; $107DD6
        DC.W    $FFC6               ; $107DD8 MOVE.W  D6,<EA:3F>
        DBVC    D0,$105B26                      ; $107DDA
        MOVE.W  D1,$3B68(A6)                    ; $107DDE
        ROXR.B  D5,D2                           ; $107DE2
        MOVEQ   #$38,D3                         ; $107DE4
        CMPA.L  -$5B40(A1),A6                   ; $107DE6
        CMPA.W  -$1645(A1),A5                   ; $107DEA
        MOVE.W  -(A3),-(A6)                     ; $107DEE
        DBNE    D2,loc_106FCD                   ; $107DF0
        MOVEQ   #-$19,D0                        ; $107DF4
        MOVE.W  A0,$20(A1,A6.L)                 ; $107DF6
        DC.W    $F27D               ; $107DFA MOVEA.W <EA:3D>,A1
        MOVE.L  (A1)+,-(A7)                     ; $107DFC
        MOVE.W  -$155C(A0),D1                   ; $107DFE
        ADDQ.W  #5,D5                           ; $107E02
        MOVE.W  $53(A1,A6.L),-$5B(A2,A2.L)      ; $107E04
        MOVE.W  $0C08(A4),-$16(PC,A4.W)         ; $107E0A
        EOR.W  D7,(A2)+                         ; $107E10
        NOP                                     ; $107E12
        MOVE.W  (A4),$3BF9(A5)                  ; $107E14
        MOVE.W  -$17(A4,D3.L),-$12(A5,A5.L)     ; $107E18
        ROL.B  D0,D5                            ; $107E1E
        ADD.W  D5,(A3)+                         ; $107E20
        MOVEA.B D2,A4                           ; $107E22
        DC.W    $DBFD               ; $107E24 ADDA.L  <EA:3D>,A5
        CMPA.L  (A2),A5                         ; $107E26
        SUB.L  D7,(A0)                          ; $107E28
        MOVE.W  (A0)+,D5                        ; $107E2A
        BRA.S  loc_107E06                       ; $107E2C
        SUBQ.W  #1,(A3)+                        ; $107E2E
        MULS    -$445C(PC),D3                   ; $107E30
        ORI.W  #$1391,-$4F23(A4)                ; $107E34
        SUBA.L  $5DD8(A1),A0                    ; $107E3A
        MOVE.W  A3,-(A2)                        ; $107E3E
        MOVE.W  (A7)+,$79E9(A2)                 ; $107E40
        ADD.W  D7,D3                            ; $107E44
        MOVE.L  -(A1),(A2)+                     ; $107E46
        CMPA.L  $44(A1,A6.L),A2                 ; $107E48
        MOVE.B  D6,D6                           ; $107E4C
        OR.L   $44BB(PC),D7                     ; $107E4E
        ADD.L  D5,-$2680(PC)                    ; $107E52
        MOVEQ   #$7A,D0                         ; $107E56
        DC.W    $FBFF               ; $107E58 MOVE.W  <EA:3F>,<EA:3D>
        MOVE.W  -(A4),-$03(A5,A1.L)             ; $107E5A
        ADDQ.W  #8,$34(A5,A7.L)                 ; $107E5E
        ROXL.L  D0,D4                           ; $107E62
        MULU    -(A3),D5                        ; $107E64
        EOR.B  D1,-(A0)                         ; $107E66
        ROXR.L  D3,D0                           ; $107E68
        ROXR.W  #5,D3                           ; $107E6A
        MOVE.W  D0,(A6)                         ; $107E6C
        BSET    D2,$3C(A0,A3.W)                 ; $107E6E
        MOVE.B  D1,$B5E6.W                      ; $107E72
        SUBQ.W  #2,(A5)                         ; $107E76
        MOVE.L  D1,(A7)+                        ; $107E78
        MOVE.W  (A3)+,-$25(PC,A3.W)             ; $107E7A
        TST    A2                               ; $107E7E
        SUBA.L  A1,A3                           ; $107E80
        ADDA.W  (A2),A4                         ; $107E82
        SUB.L  D3,$C4C1D582                     ; $107E84
        AND.L  D0,$E8A19CB9                     ; $107E8A
        CMPA.W  -$780C(A1),A1                   ; $107E90
        DC.W    $B2FD               ; $107E94 CMPA.W  <EA:3D>,A1
        MOVE.L  D3,(A4)                         ; $107E96
        MOVE.W  (A1)+,(A7)+                     ; $107E98
        MOVE.W  -(A7),-$34(A7,A3.W)             ; $107E9A
        EOR.L  D4,-(A0)                         ; $107E9E
        BCS.S  loc_107E47                       ; $107EA0
        MULS    #$36C9,D4                       ; $107EA2
        SUBA.W  A1,A6                           ; $107EA6
        AND.B  D2,D7                            ; $107EA8
        LSR.W  -(A0)                            ; $107EAA
        BTST    D4,$C3DE97F4                    ; $107EAC
        MOVE.W  -(A5),$0AAA.W                   ; $107EB2
        SUBI.B  #$E333,-$7238(A2)               ; $107EB6
        MOVE.B  D5,(A1)+                        ; $107EBC
        AND.B  D4,D1                            ; $107EBE
        ASL.W  D5,D1                            ; $107EC0
        MOVE.W  #$F2DD,(A4)                     ; $107EC2
        MOVE.W  (A5)+,(A4)+                     ; $107EC6
        MOVE.W  $53(A3,A7.L),-(A1)              ; $107EC8
        DC.W    $3DFF               ; $107ECC MOVE.W  <EA:3F>,<EA:3E>
        MOVE.W  D7,-(A7)                        ; $107ECE
        ADD.W  D5,(A5)                          ; $107ED0
        MOVE.W  (A7)+,(A1)+                     ; $107ED2
        ADD.W  D5,(A3)                          ; $107ED4
        MOVE.W  (A5)+,(A3)+                     ; $107ED6
        ADD.W  D1,(A5)                          ; $107ED8
        MOVE.W  (A6),(A3)+                      ; $107EDA
        ASR.L  #8,D5                            ; $107EDC
        OR.W   D2,-(A4)                         ; $107EDE
        MOVE.W  -$1B(PC,A6.L),-$4B(A0,A5.L)     ; $107EE0
        DIVU    -$3D(A1,A7.L),D5                ; $107EE6
        MOVE.L  -(A6),D1                        ; $107EEA
        ADD.L  D6,$62(PC,A6.L)                  ; $107EEC
        CMPA.L  D1,A1                           ; $107EF0
        LSR.W  D3                               ; $107EF2
        MOVEA.B D6,A7                           ; $107EF4
        SUBA.W  -(A3),A4                        ; $107EF6
        DIVU    $3F(A3,D3.W),D0                 ; $107EF8
        ADDA.L  #$3DD5D5DC,A6                   ; $107EFC
        MOVE.W  $553D.W,(A0)+                   ; $107F02
        ADDA.L  $5D89(A1),A7                    ; $107F06
        LEA     (A5),A6                         ; $107F0A
        ADD.W  D2,(A1)                          ; $107F0C
        AND.W  D1,(A4)                          ; $107F0E
        DC.W    $4D60               ; $107F10 DC.W    $4D60
        CMPA.L  $79C1(A1),A7                    ; $107F12
        BLS.S  loc_107F14                       ; $107F16
        BHI.S  loc_107F32                       ; $107F18
        ADDI.W  #$FC26,-(A6)                    ; $107F1A
        MOVEA.L -(A6),A2                        ; $107F1E
        MOVE.L  (A3)+,(A1)+                     ; $107F20
        DC.W    $00B4,$F8C8,$F833,$EB62; $107F22 ORI.L  #$F8C8F833,$62(A4,A6.L)
        MOVE.B  -(A1),(A2)+                     ; $107F2A
        ST      -(A3)                           ; $107F2C
        MOVE.L  -(A6),-$052B(A7)                ; $107F2E
loc_107F32:
        MOVEA.W -(A3),A3                        ; $107F32
        MOVE.B  A1,(A4)                         ; $107F34
        MOVE.L  (A0),(A1)+                      ; $107F36
        BHI.S  loc_107F35                       ; $107F38
        MOVE.W  (A2)+,-(A7)                     ; $107F3A
        ANDI.L  #$3645D936,(A5)                 ; $107F3C
        SUB.W  D4,D5                            ; $107F42
        ADD.B  D3,-(A0)                         ; $107F44
        MOVE.B  -$08(A0,D6.L),(A5)              ; $107F46
        BSET    D3,D4                           ; $107F4A
        BNE.S  loc_107F8F                       ; $107F4C
        ADDA.L  $D221.W,A0                      ; $107F4E
        MOVE.W  A0,-(A0)                        ; $107F52
        LSR.B  #4,D1                            ; $107F54
        MOVE.W  $DA87.W,D4                      ; $107F56
        CMP.L  -$55AB(A2),D7                    ; $107F5A
        SPL     #$549E                          ; $107F5E
        ADD.W  D4,D4                            ; $107F62
        TST.L  -$1E(PC,A2.L)                    ; $107F64
        DIVS    $0C(A5,A5.W),D7                 ; $107F68
        DC.W    $0ED9               ; $107F6C DC.W    $0ED9
        ASR.W  #3,D4                            ; $107F6E
        MOVE.L  -$5ABB(A2),$01(A5,A3.L)         ; $107F70
        SCC     -(A0)                           ; $107F76
        CMPA.L  -(A1),A5                        ; $107F78
        MOVE.W  (A0)+,D1                        ; $107F7A
        ASR.B  #5,D0                            ; $107F7C
        LSL.B  D6,D0                            ; $107F7E
        ROXL.W  #6,D5                           ; $107F80
        ADDQ.L  #2,A0                           ; $107F82
        MOVE.W  -(A2),-$3D(A0,A7.W)             ; $107F84
        MOVE.W  D2,-(A0)                        ; $107F88
        LSR.W  -$04(A1,A7.L)                    ; $107F8A
        CMPA.W  (A4)+,A0                        ; $107F8E
        OR.W   D3,D3                            ; $107F90
        MULU    $36(A5,D3.W),D2                 ; $107F92
        MOVE.W  -(A3),D5                        ; $107F96
        MOVE.L  $22(A2,A7.L),-(A1)              ; $107F98
        BCHG    #3,(A1)                         ; $107F9C
        MOVE.W  $6B(A6,A7.W),-(A6)              ; $107FA0
        CMP.B  $0DF8(A4),D5                     ; $107FA4
        BLS.S  loc_107FE7                       ; $107FA8
loc_107FAA:
        ASL.W  -(A2)                            ; $107FAA
        MOVE.L  -(A3),D1                        ; $107FAC
        MOVE.L  A0,$22(A5,A5.W)                 ; $107FAE
        MOVEA.W (A0)+,A1                        ; $107FB2
        ROXR.W  D1,D7                           ; $107FB4
        MOVE.W  (A0)+,$40(A1,A5.W)              ; $107FB6
        OR.L   D2,D2                            ; $107FBA
        MOVE.W  $F0B8.W,(A4)+                   ; $107FBC
        ADD.L  D0,A1                            ; $107FC0
        OR.L   $1EF2(A4),D2                     ; $107FC2
        JMP     $8F90.W                         ; $107FC6
        MOVE.W  A1,D4                           ; $107FCA
        BRA.S  loc_108005                       ; $107FCC
        BGT.S  loc_107FA3                       ; $107FCE
        MOVE.W  $DC32.W,D4                      ; $107FD0
        BVC.S  loc_107FAA                       ; $107FD4
        MOVE.W  -$27(A2,A6.L),D3                ; $107FD6
        BLS.S  loc_107FFE                       ; $107FDA
        MOVE.W  (A5)+,$77(A5,A0.L)              ; $107FDC
        DC.W    $00E2               ; $107FE0 DC.W    $00E2
        SCS     (A4)                            ; $107FE2
        DC.W    $44FF               ; $107FE4 NEG    <EA:3F>
        MOVE.B  $2F(A3,A7.L),-(A7)              ; $107FE6
        ADD.W  D6,D3                            ; $107FEA
        MOVE.W  -(A2),-(A7)                     ; $107FEC
        MOVE.W  (A5)+,#$D933                    ; $107FEE
        DC.W    $29FD,$5DE2,$76D2   ; $107FF2 MOVE.L  <EA:3D>,#$5DE276D2
        DC.W    $FDE8,$2FD3         ; $107FF8 MOVE.W  $2FD3(A0),<EA:3E>
        MOVE.W  -(A1),(A5)+                     ; $107FFC
loc_107FFE:
        DC.W    $2DFC,$EADB,$DBFF   ; $107FFE MOVE.L  #$EADBDBFF,<EA:3E>
        ADD.L  D7,-$2D43(A6)                    ; $108004
        DC.W    $FFFD               ; $108008 MOVE.W  <EA:3D>,<EA:3F>
        ADD.L  D6,-$61(A4,D3.W)                 ; $10800A
        ADD.L  D5,$5D(A4,D5.W)                  ; $10800E
        MOVE.W  $15(A1,A6.W),-(A6)              ; $108012
        DC.W    $BEBD               ; $108016 CMP.L  <EA:3D>,D7
        CMPA.L  (A7)+,A1                        ; $108018
        ASL.W  (A5)+                            ; $10801A
        DC.W    $EAFF               ; $10801C LSR.W  <EA:3F>
        MOVE.W  (A7)+,-$45(A4,A5.L)             ; $10801E
        MOVE.W  D3,-(A7)                        ; $108022
        MOVE.W  $2D(A7,A6.L),D6                 ; $108024
        MOVE.W  (A6)+,#$C9FD                    ; $108028
        ADD.B  -$23(A5,D3.L),D1                 ; $10802C
        ST      $23C0(A5)                       ; $108030
        ADDA.L  -(A4),A1                        ; $108034
        ROXL.L  D5,D2                           ; $108036
        MOVE.W  A4,-(A1)                        ; $108038
        LSL.L  D0,D2                            ; $10803A
        ROR.W  -(A1)                            ; $10803C
        CMP.B  A7,D5                            ; $10803E
loc_108040:
        MOVE.L  -$5BAB(PC),-$55(A7,D3.W)        ; $108040
        MOVE.W  -(A3),D1                        ; $108046
        MOVE.L  -$5AFF(A2),(A5)                 ; $108048
        MOVE.W  A4,$40(A0,D0.W)                 ; $10804C
        LSL.W  D1,D0                            ; $108050
        BSET    D3,-$6D60(PC)                   ; $108052
        BPL.S  loc_108040                       ; $108056
        MOVE.W  -$0703(A2),-$1008(A0)           ; $108058
        MOVE.W  A2,-(A6)                        ; $10805E
        DIVU    (A0)+,D5                        ; $108060
        ROXL.W  #5,D0                           ; $108062
        MOVE.W  A1,D1                           ; $108064
        ROL.B  D0,D6                            ; $108066
        MOVE.B  -$0E(A2,A5.L),(A6)+             ; $108068
        ADDI.W  #$FB14,$F136.W                  ; $10806C
        DC.W    $FAFF               ; $108072 MOVE.W  <EA:3F>,(A5)+
        MOVE.W  $18(A2,A0.L),D1                 ; $108074
        MOVE.W  (A7)+,D4                        ; $108078
        MOVE.W  -$77CD(A0),-(A5)                ; $10807A
        MOVE.L  $33(A2,D2.W),-(A1)              ; $10807E
        MOVE.W  -$80(A3,D2.W),D1                ; $108082
        DIVS    (A2)+,D2                        ; $108086
        MOVE.W  A0,-$0F(PC,D1.W)                ; $108088
        DC.W    $7BD5               ; $10808C MOVE.W  (A5),<EA:3D>
        AND.W  D0,D3                            ; $10808E
        SLS     -(A0)                           ; $108090
        LSR.W  $9A2E.W                          ; $108092
        MOVE.L  -(A2),D1                        ; $108096
        MOVE.L  $8DF1.W,(A1)+                   ; $108098
        SUBQ.B  #8,(A0)                         ; $10809C
        MOVE.L  -(A3),D1                        ; $10809E
        MOVE.W  D4,-$2E(A7,A7.W)                ; $1080A0
        DC.W    $7BF1,$6D23         ; $1080A4 MOVE.W  $23(A1,D6.L),<EA:3D>
        ASL.W  -$32(A2,A0.W)                    ; $1080A8
        MOVE.W  $2E1F(A1),$22(A5,A6.L)          ; $1080AC
        DC.W    $FBC6               ; $1080B2 MOVE.W  D6,<EA:3D>
        SNE     (A1)+                           ; $1080B4
        MOVE.L  (A1)+,(A7)+                     ; $1080B6
        MOVEA.L (A3)+,A1                        ; $1080B8
        MULS    A6,D0                           ; $1080BA
        MOVE.W  -(A2),(A0)                      ; $1080BC
        SUBA.W  -(A3),A2                        ; $1080BE
        SUBQ.W  #8,(A5)                         ; $1080C0
        BRA.S  loc_10806E                       ; $1080C2
        MOVE.W  (A4),(A4)+                      ; $1080C4
        DC.W    $BAFF               ; $1080C6 CMPA.W  <EA:3F>,A5
        MOVE.W  (A5),D7                         ; $1080C8
        MOVE.L  (A3),-(A5)                      ; $1080CA
        MOVE.L  D1,-$1DBB(A4)                   ; $1080CC
        LEA     A7,A4                           ; $1080D0
        DC.W    $A3FC,$BAAC,$A29A,$8C69,$F155; $1080D2 MOVE.L  #$BAACA29A,$8C69F155
        DC.W    $55BE               ; $1080DC SUBQ.L  #2,<EA:3E>
        ADD.L  D4,(A4)                          ; $1080DE
        DC.W    $CCFF               ; $1080E0 MULU    <EA:3F>,D6
        MOVE.W  A3,D4                           ; $1080E2
        MULU    $4EF2(A4),D4                    ; $1080E4
        MOVE.W  -$0F(A1,D5.L),(A6)+             ; $1080E8
        ADDA.W  D1,A5                           ; $1080EC
        SUBQ.W  #2,(A5)                         ; $1080EE
        MULU    -$3D(A3,A5.W),D6                ; $1080F0
        ROXL.W  -$0E(A2,D3.L)                   ; $1080F4
        DC.W    $FDD3               ; $1080F8 MOVE.W  (A3),<EA:3E>
        MOVE.W  (A2)+,-$3C(PC,A1.L)             ; $1080FA
        DIVU    $02(A4,D5.W),D7                 ; $1080FE
loc_108102:
        ST      (A0)                            ; $108102
        BTST    D5,-$3DEC(A4)                   ; $108104
        AND.W  D1,-(A2)                         ; $108108
        ADDA.L  -$50AC(A0),A4                   ; $10810A
        ADDQ.L  #1,-$371D(A2)                   ; $10810E
        MOVE.W  (A4),$50(PC,A5.L)               ; $108112
        MULS    $55(A0,A7.L),D3                 ; $108116
        OR.B   -(A1),D3                         ; $10811A
        AND.B  A7,D0                            ; $10811C
        MOVE.W  A4,(A0)+                        ; $10811E
        LEA     D2,A0                           ; $108120
        MOVE.W  (A0),(A0)+                      ; $108122
        CMPI.W  #$F722,A0                       ; $108124
        MOVEA.L D5,A4                           ; $108128
        MOVE.B  A5,(A0)+                        ; $10812A
        ASL.W  -(A0)                            ; $10812C
        BSET    D6,-(A5)                        ; $10812E
        DC.W    $3DFF               ; $108130 MOVE.W  <EA:3F>,<EA:3E>
        DIVS    A0,D4                           ; $108132
        ROXR.L  #8,D1                           ; $108134
        LSL.L  #4,D0                            ; $108136
        MOVE.W  -(A2),(A4)                      ; $108138
        MOVE.L  D0,(A6)                         ; $10813A
        MOVEQ   #-$04,D4                        ; $10813C
        MOVE.W  $E9F1.W,-$0704(A0)              ; $10813E
        BPL.S  loc_108102                       ; $108144
        ROR.L  D4,D4                            ; $108146
        MULU    D5,D4                           ; $108148
        MOVEM.L (A2),D0/D1/D3/D6/D7/A5/A7       ; $10814A
loc_10814E:
        SPL     $36(A1,A2.L)                    ; $10814E
        BLS.S  loc_10814E                       ; $108152
        DIVS    -$2390(A5),D2                   ; $108154
        LSL.L  #5,D0                            ; $108158
        ROXL.B  D0,D5                           ; $10815A
        MOVE.L  -$56(PC,A3.L),-$17(A5,A0.L)     ; $10815C
        MOVE.W  -(A1),$45DF(A6)                 ; $108162
        DC.W    $FFFC,$FF99         ; $108166 MOVE.W  #$FF99,<EA:3F>
        MOVE.B  (A3),(A4)+                      ; $10816A
        OR.L   -$00D1(PC),D4                    ; $10816C
        AND.L  A5,D0                            ; $108170
        LSL.L  D0,D2                            ; $108172
        DC.W    $DBBD               ; $108174 ADD.L  D5,<EA:3D>
        BLE.S  loc_108163                       ; $108176
        DC.W    $E6FF               ; $108178 ROR.W  <EA:3F>
        MOVE.W  D1,$4599(A6)                    ; $10817A
        MOVE.W  -$36(PC,D5.L),#$A3BA            ; $10817E
        MOVE.W  (A3),(A6)+                      ; $108184
        MOVE.W  A3,-(A0)                        ; $108186
        MOVEA.W -$1E5B(A0),A0                   ; $108188
        DIVU    (A1),D4                         ; $10818C
        DC.W    $DCFE               ; $10818E ADDA.W  <EA:3E>,A6
        DC.W    $DBFD               ; $108190 ADDA.L  <EA:3D>,A5
        MOVEA.W (A0),A7                         ; $108192
        ADD.W  D4,D4                            ; $108194
        TST.L  -$45AC(A2)                       ; $108196
        TST.L  $5452(A3)                        ; $10819A
        ROXL.B  #8,D0                           ; $10819E
        SUBQ.L  #8,-(A1)                        ; $1081A0
        MOVE.W  A1,(A1)+                        ; $1081A2
        DC.W    $A0FD               ; $1081A4 MOVE.L  <EA:3D>,(A0)+
        DC.W    $A5B9,$4498,$DFF8,$F4BB; $1081A6 MOVE.L  $4498DFF8,-$45(A2,A7.W)
        CMP.L  (A0),D5                          ; $1081AE
        MOVE.L  (A0),$CFFCDBFC                  ; $1081B0
        DC.W    $0230,$82E7,$F7FC   ; $1081B6 ANDI.B  #$82E7,-$04(A0,A7.W)
        OR.W   -(A2),D4                         ; $1081BC
        AND.B  (A0)+,D1                         ; $1081BE
        LSR.W  (A4)+                            ; $1081C0
        CMPA.W  A1,A6                           ; $1081C2
        OR.L   D2,-$5340(A2)                    ; $1081C4
        MOVE.W  -$4F34(PC),(A6)                 ; $1081C8
        ADDA.W  #$92C3,A2                       ; $1081CC
        BCHG    #11,-$274C(A0)                  ; $1081D0
        DC.W    $ABF7,$8034         ; $1081D6 MOVE.L  $34(A7,A0.W),<EA:3D>
        CMPA.W  -$57(A7,A7.L),A0                ; $1081DA
        DC.W    $ABBD,$5424         ; $1081DE MOVE.L  <EA:3D>,$24(A5,D5.W)
        MOVE.W  -$073D(PC),(A6)                 ; $1081E2
        ASR.W  (A2)+                            ; $1081E6
        DC.W    $24FF               ; $1081E8 MOVE.L  <EA:3F>,(A2)+
        MOVEA.L (A0),A2                         ; $1081EA
        ADDA.W  (A6)+,A6                        ; $1081EC
        ASR.W  #$FD42                           ; $1081EE
        ROXL.W  #1,D4                           ; $1081F2
        DC.W    $02CE               ; $1081F4 DC.W    $02CE
        MOVE.W  D1,(A4)+                        ; $1081F6
        DC.W    $1DC9               ; $1081F8 MOVE.B  A1,<EA:3E>
        MOVE.L  -(A5),D5                        ; $1081FA
        MOVE.L  A1,(A0)+                        ; $1081FC
        MOVE.W  D4,-(A2)                        ; $1081FE
