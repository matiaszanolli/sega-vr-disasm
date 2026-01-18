; Generated assembly for $030200-$032200
; Branch targets: 377
; Labels: 375

        org     $030200

        MOVE.B  (A0)+,$0018(A5)                 ; $030200
        MOVE.B  (A0)+,$0019(A5)                 ; $030204
        MOVE.B  (A0)+,$001A(A5)                 ; $030208
        MOVE.B  (A0)+,D0                        ; $03020C
        LSR.B  #1,D0                            ; $03020E
        MOVE.B  D0,$001B(A5)                    ; $030210
        CLR.W  $001C(A5)                        ; $030214
        RTS                                     ; $030218
loc_03021A:
        TST.B  $0012(A5)                        ; $03021A
        BEQ.S  loc_030240                       ; $03021E
        SUBQ.B  #1,$0012(A5)                    ; $030220
        BNE.S  loc_030240                       ; $030224
        BSET    #1,(A5)                         ; $030226
        TST.B  $0001(A5)                        ; $03022A
        BMI.W  loc_03023A                       ; $03022E
        JSR     loc_030C8A(PC)                  ; $030232
        ADDQ.W  #4,A7                           ; $030236
        RTS                                     ; $030238
loc_03023A:
        JSR     loc_030FB2(PC)                  ; $03023A
        ADDQ.W  #4,A7                           ; $03023E
loc_030240:
        RTS                                     ; $030240
loc_030242:
        BTST    #7,$000A(A5)                    ; $030242
        BEQ.S  loc_030290                       ; $030248
        TST.B  $0018(A5)                        ; $03024A
        BEQ.S  loc_030256                       ; $03024E
        SUBQ.B  #1,$0018(A5)                    ; $030250
        RTS                                     ; $030254
loc_030256:
        SUBQ.B  #1,$0019(A5)                    ; $030256
        BEQ.S  loc_03025E                       ; $03025A
        RTS                                     ; $03025C
loc_03025E:
        MOVEA.L $0014(A5),A0                    ; $03025E
        MOVE.B  $0001(A0),$0019(A5)             ; $030262
        TST.B  $001B(A5)                        ; $030268
        BNE.S  loc_03027A                       ; $03026C
        MOVE.B  $0003(A0),$001B(A5)             ; $03026E
        NEG.B  $001A(A5)                        ; $030274
        RTS                                     ; $030278
loc_03027A:
        SUBQ.B  #1,$001B(A5)                    ; $03027A
        MOVE.B  $001A(A5),D6                    ; $03027E
        EXT.W   D6                              ; $030282
        ADD.W  $001C(A5),D6                     ; $030284
        MOVE.W  D6,$001C(A5)                    ; $030288
        ADD.W  $0010(A5),D6                     ; $03028C
loc_030290:
        RTS                                     ; $030290
        MOVE.W  $0010(A5),D6                    ; $030292
        BNE.S  loc_0302A6                       ; $030296
        BSET    #1,(A5)                         ; $030298
        RTS                                     ; $03029C
        TST.B  $000A(A5)                        ; $03029E
        BEQ.W  loc_0302EC                       ; $0302A2
loc_0302A6:
        BTST    #1,(A5)                         ; $0302A6
        BNE.W  loc_0302EC                       ; $0302AA
        BTST    #2,(A5)                         ; $0302AE
        BNE.W  loc_0302EC                       ; $0302B2
        JSR     loc_0302EE(PC)                  ; $0302B6
        TST.B  $000F(A6)                        ; $0302BA
        BEQ.S  loc_0302CA                       ; $0302BE
        CMPI.B  #$0002,$0001(A5)                ; $0302C0
        BEQ.W  loc_03038E                       ; $0302C6
loc_0302CA:
        MOVE.W  D6,D1                           ; $0302CA
        LSR.W  #8,D1                            ; $0302CC
        MOVE.B  #$00A4,D0                       ; $0302CE
        JSR     loc_030D1C(PC)                  ; $0302D2
        JSR     loc_030CCC(PC)                  ; $0302D6
        MOVE.B  D6,D1                           ; $0302DA
        MOVE.B  #$00A0,D0                       ; $0302DC
        JSR     loc_030CCC(PC)                  ; $0302E0
        MOVE.W  #$0000,$00A11100                ; $0302E4
loc_0302EC:
        RTS                                     ; $0302EC
loc_0302EE:
        MOVEQ   #$00,D6                         ; $0302EE
        MOVE.B  $000A(A5),D0                    ; $0302F0
        ANDI.W  #$007F,D0                       ; $0302F4
        BEQ.S  loc_03033E                       ; $0302F8
        LEA     $263A(PC),A0                    ; $0302FA
        SUBQ.W  #1,D0                           ; $0302FE
        LSL.W  #2,D0                            ; $030300
        MOVEA.L $00(A0,D0.W),A0                 ; $030302
loc_030306:
        MOVEQ   #$00,D0                         ; $030306
        MOVE.B  $0026(A5),D0                    ; $030308
        ADDQ.B  #1,$0026(A5)                    ; $03030C
        MOVE.B  $00(A0,D0.W),D6                 ; $030310
        BPL.S  loc_030334                       ; $030314
        CMPI.B  #$0080,D6                       ; $030316
        BEQ.S  loc_030358                       ; $03031A
        CMPI.B  #$0081,D6                       ; $03031C
        BEQ.S  loc_03035E                       ; $030320
        CMPI.B  #$0083,D6                       ; $030322
        BEQ.S  loc_030364                       ; $030326
        CMPI.B  #$0082,D6                       ; $030328
        BEQ.S  loc_030376                       ; $03032C
        CMPI.B  #$0084,D6                       ; $03032E
        BEQ.S  loc_03037E                       ; $030332
loc_030334:
        EXT.W   D6                              ; $030334
        MOVE.B  $0003(A5),D0                    ; $030336
        EXT.W   D0                              ; $03033A
        MULU    D0,D6                           ; $03033C
loc_03033E:
        MOVE.W  $001E(A5),D0                    ; $03033E
        ADD.W  D0,D6                            ; $030342
        ADD.W  $0010(A5),D6                     ; $030344
        TST.B  $000A(A5)                        ; $030348
        BPL.S  loc_030352                       ; $03034C
        ADD.W  $001C(A5),D6                     ; $03034E
loc_030352:
        RTS                                     ; $030352
        ADDQ.W  #4,A7                           ; $030354
        RTS                                     ; $030356
loc_030358:
        CLR.B  $0026(A5)                        ; $030358
        BRA.S  loc_030306                       ; $03035C
loc_03035E:
        SUBQ.B  #2,$0026(A5)                    ; $03035E
        BRA.S  loc_030306                       ; $030362
loc_030364:
        BSET    #1,(A5)                         ; $030364
        TST.B  $0001(A5)                        ; $030368
        BMI.S  loc_030372                       ; $03036C
        BRA.W  loc_030C8A                       ; $03036E
loc_030372:
        BRA.W  loc_030FB2                       ; $030372
loc_030376:
        MOVE.B  $01(A0,D0.W),$0026(A5)          ; $030376
        BRA.S  loc_030306                       ; $03037C
loc_03037E:
        MOVE.B  $01(A0,D0.W),D0                 ; $03037E
        ADD.B  D0,$0003(A5)                     ; $030382
        ADDQ.B  #1,$0026(A5)                    ; $030386
        BRA.W  loc_030306                       ; $03038A
loc_03038E:
        LEA     $003C(PC),A1                    ; $03038E
        LEA     $0020(A6),A2                    ; $030392
        TST.B  $000E(A6)                        ; $030396
        BEQ.S  loc_0303A0                       ; $03039A
        LEA     $0028(A6),A2                    ; $03039C
loc_0303A0:
        MOVEQ   #$03,D5                         ; $0303A0
        JSR     loc_030D1C(PC)                  ; $0303A2
loc_0303A6:
        MOVE.W  D6,D1                           ; $0303A6
        MOVE.W  (A2)+,D0                        ; $0303A8
        ADD.W  D0,D1                            ; $0303AA
        MOVE.W  D1,D3                           ; $0303AC
        LSR.W  #8,D1                            ; $0303AE
        MOVE.B  (A1)+,D0                        ; $0303B0
        JSR     loc_030CD8(PC)                  ; $0303B2
        MOVE.B  D3,D1                           ; $0303B6
        MOVE.B  (A1)+,D0                        ; $0303B8
        JSR     loc_030CD8(PC)                  ; $0303BA
        DBRA    D5,loc_0303A6                   ; $0303BE
        MOVE.W  #$0000,$00A11100                ; $0303C2
        RTS                                     ; $0303CA
        MOVE.L  -$5358(A1),-$56(A6,A2.L)        ; $0303CC
        MOVE.L  -(A2),(A3)                      ; $0303D2
        BTST    #1,(A5)                         ; $0303D4
        BNE.S  loc_0303E6                       ; $0303D8
        MOVEQ   #$00,D0                         ; $0303DA
        MOVE.B  $0028(A5),D0                    ; $0303DC
        LSL.W  #1,D0                            ; $0303E0
        JMP     $02(PC,D0.W)                    ; $0303E2
loc_0303E6:
        RTS                                     ; $0303E6
        BRA.S  loc_030412                       ; $0303E8
        BRA.S  loc_030408                       ; $0303EA
        BRA.S  loc_030408                       ; $0303EC
        BTST    #1,(A5)                         ; $0303EE
        BNE.S  loc_030400                       ; $0303F2
        MOVEQ   #$00,D0                         ; $0303F4
        MOVE.B  $0028(A5),D0                    ; $0303F6
        LSL.W  #1,D0                            ; $0303FA
        JMP     $02(PC,D0.W)                    ; $0303FC
loc_030400:
        RTS                                     ; $030400
        RTS                                     ; $030402
        BRA.S  loc_030412                       ; $030404
        BRA.S  loc_030412                       ; $030406
loc_030408:
        MOVE.B  $0023(A5),$0024(A5)             ; $030408
        CLR.B  $0021(A5)                        ; $03040E
loc_030412:
        MOVE.B  $0024(A5),D0                    ; $030412
        CMP.B  $0023(A5),D0                     ; $030416
        BNE.S  loc_03043A                       ; $03041A
        MOVE.B  $0022(A5),D3                    ; $03041C
        CMP.B  $0021(A5),D3                     ; $030420
        BPL.S  loc_030432                       ; $030424
        CMPI.B  #$0002,$0028(A5)                ; $030426
        BEQ.S  loc_03046A                       ; $03042C
        CLR.B  $0021(A5)                        ; $03042E
loc_030432:
        CLR.B  $0024(A5)                        ; $030432
        ADDQ.B  #1,$0021(A5)                    ; $030436
loc_03043A:
        MOVEQ   #$00,D0                         ; $03043A
        MOVE.B  $0020(A5),D0                    ; $03043C
        SUBQ.W  #1,D0                           ; $030440
        LSL.W  #2,D0                            ; $030442
        MOVEA.L $26(PC,D0.W),A0                 ; $030444
        MOVEQ   #$00,D0                         ; $030448
        MOVE.B  $0021(A5),D0                    ; $03044A
        SUBQ.W  #1,D0                           ; $03044E
        MOVE.B  $00(A0,D0.W),D1                 ; $030450
        MOVE.B  $0027(A5),D0                    ; $030454
        ANDI.B  #$0037,D0                       ; $030458
        OR.B   D0,D1                            ; $03045C
        MOVE.B  #$00B4,D0                       ; $03045E
        JSR     loc_030CA2(PC)                  ; $030462
        ADDQ.B  #1,$0024(A5)                    ; $030466
loc_03046A:
        RTS                                     ; $03046A
        ORI.L  #$0478008B,A3                    ; $03046C
        SUBI.W  #$008B,$047D(PC)                ; $030472
        NEGX.L D0                               ; $030478
        NEGX   D0                               ; $03047A
        DIVU    D0,D0                           ; $03047C
        DIVU    D0,D0                           ; $03047E
        NEGX.B D0                               ; $030480
        BMI.S  loc_0304BE                       ; $030482
        MOVEQ   #$02,D2                         ; $030484
        MOVE.B  #$00B4,D0                       ; $030486
        MOVEQ   #$00,D1                         ; $03048A
        JSR     loc_030D1C(PC)                  ; $03048C
loc_030490:
        JSR     loc_030CD8(PC)                  ; $030490
        JSR     loc_030CFE(PC)                  ; $030494
        ADDQ.B  #1,D0                           ; $030498
        DBRA    D2,loc_030490                   ; $03049A
        MOVEQ   #$02,D2                         ; $03049E
        MOVEQ   #$28,D0                         ; $0304A0
loc_0304A2:
        MOVE.B  D2,D1                           ; $0304A2
        JSR     loc_030CD8(PC)                  ; $0304A4
        ADDQ.B  #4,D1                           ; $0304A8
        JSR     loc_030CD8(PC)                  ; $0304AA
        DBRA    D2,loc_0304A2                   ; $0304AE
        MOVE.W  #$0000,$00A11100                ; $0304B2
        BRA.W  loc_030FC8                       ; $0304BA
loc_0304BE:
        CLR.B  $0007(A6)                        ; $0304BE
        MOVEQ   #$30,D3                         ; $0304C2
        LEA     $0040(A6),A5                    ; $0304C4
        MOVEQ   #$06,D4                         ; $0304C8
        JSR     loc_030D1C(PC)                  ; $0304CA
loc_0304CE:
        BTST    #7,(A5)                         ; $0304CE
        BEQ.S  loc_0304E6                       ; $0304D2
        BTST    #2,(A5)                         ; $0304D4
        BNE.S  loc_0304E6                       ; $0304D8
        MOVE.B  #$00B4,D0                       ; $0304DA
        MOVE.B  $0027(A5),D1                    ; $0304DE
        JSR     loc_030CCC(PC)                  ; $0304E2
loc_0304E6:
        ADDA.W  D3,A5                           ; $0304E6
        DBRA    D4,loc_0304CE                   ; $0304E8
        LEA     $0220(A6),A5                    ; $0304EC
        MOVEQ   #$02,D4                         ; $0304F0
loc_0304F2:
        BTST    #7,(A5)                         ; $0304F2
        BEQ.S  loc_03050A                       ; $0304F6
        BTST    #2,(A5)                         ; $0304F8
        BNE.S  loc_03050A                       ; $0304FC
        MOVE.B  #$00B4,D0                       ; $0304FE
        MOVE.B  $0027(A5),D1                    ; $030502
        JSR     loc_030CCC(PC)                  ; $030506
loc_03050A:
        ADDA.W  D3,A5                           ; $03050A
        DBRA    D4,loc_0304F2                   ; $03050C
        LEA     $0340(A6),A5                    ; $030510
        BTST    #7,(A5)                         ; $030514
        BEQ.S  loc_03052C                       ; $030518
        BTST    #2,(A5)                         ; $03051A
        BNE.S  loc_03052C                       ; $03051E
        MOVE.B  #$00B4,D0                       ; $030520
        MOVE.B  $0027(A5),D1                    ; $030524
        JSR     loc_030CCC(PC)                  ; $030528
loc_03052C:
        MOVE.W  #$0000,$00A11100                ; $03052C
        RTS                                     ; $030534
        LEA     $25F8(PC),A0                    ; $030536
        LEA     $000A(A6),A1                    ; $03053A
        MOVE.B  $0000(A6),D3                    ; $03053E
        MOVE.B  (A1),D0                         ; $030542
        MOVE.B  D0,D1                           ; $030544
        CLR.B  (A1)                             ; $030546
        SUBI.B  #$0081,D0                       ; $030548
        BCS.S  loc_030560                       ; $03054C
        ANDI.W  #$007F,D0                       ; $03054E
        MOVE.B  $00(A0,D0.W),D2                 ; $030552
        CMP.B  D3,D2                            ; $030556
        BCS.S  loc_030560                       ; $030558
        MOVE.B  D2,D3                           ; $03055A
        MOVE.B  D1,$0009(A6)                    ; $03055C
loc_030560:
        TST.B  D3                               ; $030560
        BMI.S  loc_030568                       ; $030562
        MOVE.B  D3,$0000(A6)                    ; $030564
loc_030568:
        RTS                                     ; $030568
        MOVEQ   #$00,D7                         ; $03056A
        MOVE.B  $0009(A6),D7                    ; $03056C
        BEQ.W  loc_030BF6                       ; $030570
        MOVE.B  #$0080,$0009(A6)                ; $030574
        CMPI.B  #$0080,D7                       ; $03057A
        BEQ.S  loc_0305B8                       ; $03057E
        BCS.W  loc_030B90                       ; $030580
        CMPI.B  #$009F,D7                       ; $030584
        BLS.W  loc_03061C                       ; $030588
        CMPI.B  #$00A0,D7                       ; $03058C
        BCS.W  loc_0305B8                       ; $030590
        CMPI.B  #$00D2,D7                       ; $030594
        BLS.W  loc_030798                       ; $030598
        CMPI.B  #$00D6,D7                       ; $03059C
        BCS.W  loc_0305B8                       ; $0305A0
        CMPI.B  #$00D8,D7                       ; $0305A4
        BCS.W  loc_030892                       ; $0305A8
        CMPI.B  #$00F0,D7                       ; $0305AC
        BCS.S  loc_030604                       ; $0305B0
        CMPI.B  #$00FF,D7                       ; $0305B2
        BLS.S  loc_0305BA                       ; $0305B6
loc_0305B8:
        RTS                                     ; $0305B8
loc_0305BA:
        SUBI.B  #$00F0,D7                       ; $0305BA
        LSL.W  #2,D7                            ; $0305BE
        JMP     $02(PC,D7.W)                    ; $0305C0
        BRA.W  loc_030A5C                       ; $0305C4
        BRA.W  loc_03094E                       ; $0305C8
        BRA.W  loc_0309F2                       ; $0305CC
        BRA.W  loc_030B90                       ; $0305D0
        BRA.W  loc_030B90                       ; $0305D4
        BRA.W  loc_030B90                       ; $0305D8
        BRA.W  loc_030B90                       ; $0305DC
        BRA.W  loc_030B90                       ; $0305E0
        BRA.W  loc_030B90                       ; $0305E4
        BRA.W  loc_030B90                       ; $0305E8
        BRA.W  loc_030B90                       ; $0305EC
        BRA.W  loc_030B90                       ; $0305F0
        BRA.W  loc_030B90                       ; $0305F4
        BRA.W  loc_030B90                       ; $0305F8
        BRA.W  loc_030B90                       ; $0305FC
        BRA.W  loc_030B90                       ; $030600
loc_030604:
        SUBI.B  #$00D7,D7                       ; $030604
        JSR     loc_030D1C(PC)                  ; $030608
        MOVE.B  D7,$00A00FFE                    ; $03060C
        MOVE.W  #$0000,$00A11100                ; $030612
        RTS                                     ; $03061A
loc_03061C:
        JSR     loc_030BE0(PC)                  ; $03061C
        LEA     $2496(PC),A4                    ; $030620
        SUBI.B  #$0081,D7                       ; $030624
        LSL.W  #2,D7                            ; $030628
        MOVEA.L $00(A4,D7.W),A4                 ; $03062A
        MOVEQ   #$00,D0                         ; $03062E
        MOVE.W  (A4),D0                         ; $030630
        ADD.L  A4,D0                            ; $030632
        MOVE.L  D0,$0030(A6)                    ; $030634
        MOVE.B  $0005(A4),$0002(A6)             ; $030638
        MOVE.B  $0005(A4),$0001(A6)             ; $03063E
        MOVEQ   #$00,D1                         ; $030644
        MOVEA.L A4,A3                           ; $030646
        ADDQ.W  #6,A4                           ; $030648
        MOVEQ   #$00,D7                         ; $03064A
        MOVE.B  $0002(A3),D7                    ; $03064C
        BEQ.S  loc_0306C8                       ; $030650
        SUBQ.B  #1,D7                           ; $030652
        MOVE.B  #$00C0,D1                       ; $030654
        MOVE.B  $0004(A3),D4                    ; $030658
        MOVEQ   #$30,D6                         ; $03065C
        MOVE.B  #$0001,D5                       ; $03065E
        LEA     $0040(A6),A1                    ; $030662
        LEA     $0124(PC),A2                    ; $030666
loc_03066A:
        BSET    #7,(A1)                         ; $03066A
        MOVE.B  (A2)+,$0001(A1)                 ; $03066E
        MOVE.B  D4,$0002(A1)                    ; $030672
        MOVE.B  D6,$000D(A1)                    ; $030676
        MOVE.B  D1,$0027(A1)                    ; $03067A
        MOVE.B  D5,$000E(A1)                    ; $03067E
        MOVEQ   #$00,D0                         ; $030682
        MOVE.W  (A4)+,D0                        ; $030684
        ADD.L  A3,D0                            ; $030686
        MOVE.L  D0,$0004(A1)                    ; $030688
        MOVE.W  (A4)+,$0008(A1)                 ; $03068C
        ADDA.W  D6,A1                           ; $030690
        DBRA    D7,loc_03066A                   ; $030692
        CMPI.B  #$0007,$0002(A3)                ; $030696
        BNE.S  loc_0306A8                       ; $03069C
        MOVEQ   #$2B,D0                         ; $03069E
        MOVEQ   #$00,D1                         ; $0306A0
        JSR     loc_030CBA(PC)                  ; $0306A2
        BRA.S  loc_0306C8                       ; $0306A6
loc_0306A8:
        MOVEQ   #$28,D0                         ; $0306A8
        MOVEQ   #$06,D1                         ; $0306AA
        JSR     loc_030CBA(PC)                  ; $0306AC
        MOVE.B  #$00B6,D0                       ; $0306B0
        MOVE.B  #$00C0,D1                       ; $0306B4
        JSR     loc_030D1C(PC)                  ; $0306B8
        JSR     loc_030CFE(PC)                  ; $0306BC
        MOVE.W  #$0000,$00A11100                ; $0306C0
loc_0306C8:
        MOVEQ   #$00,D7                         ; $0306C8
        MOVE.B  $0003(A3),D7                    ; $0306CA
        BEQ.S  loc_03070A                       ; $0306CE
        SUBQ.B  #1,D7                           ; $0306D0
        LEA     $0190(A6),A1                    ; $0306D2
        LEA     $00BC(PC),A2                    ; $0306D6
loc_0306DA:
        BSET    #7,(A1)                         ; $0306DA
        MOVE.B  (A2)+,$0001(A1)                 ; $0306DE
        MOVE.B  D4,$0002(A1)                    ; $0306E2
        MOVE.B  D6,$000D(A1)                    ; $0306E6
        MOVE.B  D5,$000E(A1)                    ; $0306EA
        MOVEQ   #$00,D0                         ; $0306EE
        MOVE.W  (A4)+,D0                        ; $0306F0
        ADD.L  A3,D0                            ; $0306F2
        MOVE.L  D0,$0004(A1)                    ; $0306F4
        MOVE.W  (A4)+,$0008(A1)                 ; $0306F8
        MOVE.B  (A4)+,$000A(A1)                 ; $0306FC
        MOVE.B  (A4)+,$000B(A1)                 ; $030700
        ADDA.W  D6,A1                           ; $030704
        DBRA    D7,loc_0306DA                   ; $030706
loc_03070A:
        LEA     $0220(A6),A1                    ; $03070A
        MOVEQ   #$05,D7                         ; $03070E
loc_030710:
        TST.B  (A1)                             ; $030710
        BPL.W  loc_030732                       ; $030712
        MOVEQ   #$00,D0                         ; $030716
        MOVE.B  $0001(A1),D0                    ; $030718
        BMI.S  loc_030724                       ; $03071C
        SUBQ.B  #2,D0                           ; $03071E
        LSL.B  #2,D0                            ; $030720
        BRA.S  loc_030726                       ; $030722
loc_030724:
        LSR.B  #3,D0                            ; $030724
loc_030726:
        LEA     $012A(PC),A0                    ; $030726
        MOVEA.L $00(A0,D0.W),A0                 ; $03072A
        BSET    #2,(A0)                         ; $03072E
loc_030732:
        ADDA.W  D6,A1                           ; $030732
        DBRA    D7,loc_030710                   ; $030734
        TST.W  $0340(A6)                        ; $030738
        BPL.S  loc_030744                       ; $03073C
        BSET    #2,$0100(A6)                    ; $03073E
loc_030744:
        TST.W  $0370(A6)                        ; $030744
        BPL.S  loc_030750                       ; $030748
        BSET    #2,$01F0(A6)                    ; $03074A
loc_030750:
        LEA     $0070(A6),A5                    ; $030750
        MOVEQ   #$05,D4                         ; $030754
loc_030756:
        BTST    #2,(A5)                         ; $030756
        BNE.S  loc_030760                       ; $03075A
        JSR     loc_030C8A(PC)                  ; $03075C
loc_030760:
        ADDA.W  D6,A5                           ; $030760
        DBRA    D4,loc_030756                   ; $030762
        MOVEQ   #$02,D4                         ; $030766
loc_030768:
        BTST    #2,(A5)                         ; $030768
        BNE.S  loc_030772                       ; $03076C
        JSR     loc_030FB2(PC)                  ; $03076E
loc_030772:
        ADDA.W  D6,A5                           ; $030772
        DBRA    D4,loc_030768                   ; $030774
        BTST    #2,$01F0(A6)                    ; $030778
        BNE.S  loc_030788                       ; $03077E
        MOVE.B  #$00FF,$00C00011                ; $030780
loc_030788:
        ADDQ.W  #4,A7                           ; $030788
        RTS                                     ; $03078A
        ADDI.B  #$0102,D0                       ; $03078C
        SUBI.B  #$0600,D5                       ; $030790
        OR.L   -(A0),D0                         ; $030794
        AND.B  D0,D0                            ; $030796
loc_030798:
        LEA     $008B9150,A0                    ; $030798
        SUBI.B  #$00A0,D7                       ; $03079E
        LSL.W  #2,D7                            ; $0307A2
        MOVEA.L $00(A0,D7.W),A3                 ; $0307A4
        MOVEA.L A3,A1                           ; $0307A8
        MOVEQ   #$00,D1                         ; $0307AA
        MOVE.W  (A1)+,D1                        ; $0307AC
        ADD.L  A3,D1                            ; $0307AE
        MOVE.B  (A1)+,D5                        ; $0307B0
        MOVE.B  (A1)+,D7                        ; $0307B2
        SUBQ.B  #1,D7                           ; $0307B4
        MOVEQ   #$30,D6                         ; $0307B6
loc_0307B8:
        MOVEQ   #$00,D3                         ; $0307B8
        MOVE.B  $0001(A1),D3                    ; $0307BA
        MOVE.B  D3,D4                           ; $0307BE
        BMI.S  loc_0307D4                       ; $0307C0
        SUBQ.W  #2,D3                           ; $0307C2
        LSL.W  #2,D3                            ; $0307C4
        LEA     $008A(PC),A5                    ; $0307C6
        MOVEA.L $00(A5,D3.W),A5                 ; $0307CA
        BSET    #2,(A5)                         ; $0307CE
        BRA.S  loc_0307FA                       ; $0307D2
loc_0307D4:
        LSR.W  #3,D3                            ; $0307D4
        MOVEA.L $7A(PC,D3.W),A5                 ; $0307D6
        BSET    #2,(A5)                         ; $0307DA
        CMPI.B  #$00C0,D4                       ; $0307DE
        BNE.S  loc_0307FA                       ; $0307E2
        MOVE.B  D4,D0                           ; $0307E4
        ORI.B  #$001F,D0                        ; $0307E6
        MOVE.B  D0,$00C00011                    ; $0307EA
        BCHG    #5,D0                           ; $0307F0
        MOVE.B  D0,$00C00011                    ; $0307F4
loc_0307FA:
        MOVEA.L $76(PC,D3.W),A5                 ; $0307FA
        MOVEA.L A5,A2                           ; $0307FE
        MOVEQ   #$0B,D0                         ; $030800
loc_030802:
        CLR.L  (A2)+                            ; $030802
        DBRA    D0,loc_030802                   ; $030804
        MOVE.L  D1,$0020(A5)                    ; $030808
        MOVE.W  (A1)+,(A5)                      ; $03080C
        MOVE.B  D5,$0002(A5)                    ; $03080E
        MOVEQ   #$00,D0                         ; $030812
        MOVE.W  (A1)+,D0                        ; $030814
        ADD.L  A3,D0                            ; $030816
        MOVE.L  D0,$0004(A5)                    ; $030818
        MOVE.W  (A1)+,$0008(A5)                 ; $03081C
        MOVE.B  #$0001,$000E(A5)                ; $030820
        MOVE.B  D6,$000D(A5)                    ; $030826
        TST.B  D4                               ; $03082A
        BMI.S  loc_030834                       ; $03082C
        MOVE.B  #$00C0,$0027(A5)                ; $03082E
loc_030834:
        DBRA    D7,loc_0307B8                   ; $030834
        TST.B  $0250(A6)                        ; $030838
        BPL.S  loc_030844                       ; $03083C
        BSET    #2,$0340(A6)                    ; $03083E
loc_030844:
        TST.B  $0310(A6)                        ; $030844
        BPL.S  loc_030850                       ; $030848
        BSET    #2,$0370(A6)                    ; $03084A
loc_030850:
        RTS                                     ; $030850
        DC.W    $00FF                           ; $030852
        DIVS    (A0),D2                         ; $030854
        ORI.B  #$0000,D0                        ; $030856
        DC.W    $00FF                           ; $03085A
        OR.B   D0,D3                            ; $03085C
        DC.W    $00FF                           ; $03085E
        OR.B   -$01(A0,D0.W),D3                 ; $030860
        OR.W   D2,D0                            ; $030864
        DC.W    $00FF                           ; $030866
        DIVU    D0,D3                           ; $030868
        DC.W    $00FF                           ; $03086A
        DIVU    -$01(A0,D0.W),D3                ; $03086C
        DIVU    -$01(A0,D0.W),D3                ; $030870
        OR.B   D3,-(A0)                         ; $030874
        ORI.B  #$0000,D0                        ; $030876
        DC.W    $00FF                           ; $03087A
        OR.W   D3,(A0)                          ; $03087C
        DC.W    $00FF                           ; $03087E
        OR.L   D3,D0                            ; $030880
        DC.W    $00FF                           ; $030882
        OR.L   D3,-$01(A0,D0.W)                 ; $030884
        DIVS    -(A0),D3                        ; $030888
        DC.W    $00FF                           ; $03088A
        OR.B   (A0),D4                          ; $03088C
        DC.W    $00FF                           ; $03088E
        OR.B   (A0),D4                          ; $030890
loc_030892:
        LEA     $008B921C,A0                    ; $030892
        SUBI.B  #$00D6,D7                       ; $030898
        LSL.W  #2,D7                            ; $03089C
        MOVEA.L $00(A0,D7.W),A3                 ; $03089E
        MOVEA.L A3,A1                           ; $0308A2
        MOVEQ   #$00,D0                         ; $0308A4
        MOVE.W  (A1)+,D0                        ; $0308A6
        ADD.L  A3,D0                            ; $0308A8
        MOVE.L  D0,$0034(A6)                    ; $0308AA
        MOVE.B  (A1)+,D5                        ; $0308AE
        MOVE.B  (A1)+,D7                        ; $0308B0
        SUBQ.B  #1,D7                           ; $0308B2
        MOVEQ   #$30,D6                         ; $0308B4
loc_0308B6:
        MOVE.B  $0001(A1),D4                    ; $0308B6
        BMI.S  loc_0308C8                       ; $0308BA
        BSET    #2,$0100(A6)                    ; $0308BC
        LEA     $0340(A6),A5                    ; $0308C2
        BRA.S  loc_0308D2                       ; $0308C6
loc_0308C8:
        BSET    #2,$01F0(A6)                    ; $0308C8
        LEA     $0370(A6),A5                    ; $0308CE
loc_0308D2:
        MOVEA.L A5,A2                           ; $0308D2
        MOVEQ   #$0B,D0                         ; $0308D4
loc_0308D6:
        CLR.L  (A2)+                            ; $0308D6
        DBRA    D0,loc_0308D6                   ; $0308D8
        MOVE.W  (A1)+,(A5)                      ; $0308DC
        MOVE.B  D5,$0002(A5)                    ; $0308DE
        MOVEQ   #$00,D0                         ; $0308E2
        MOVE.W  (A1)+,D0                        ; $0308E4
        ADD.L  A3,D0                            ; $0308E6
        MOVE.L  D0,$0004(A5)                    ; $0308E8
        MOVE.W  (A1)+,$0008(A5)                 ; $0308EC
        MOVE.B  #$0001,$000E(A5)                ; $0308F0
        MOVE.B  D6,$000D(A5)                    ; $0308F6
        TST.B  D4                               ; $0308FA
        BMI.S  loc_030904                       ; $0308FC
        MOVE.B  #$00C0,$0027(A5)                ; $0308FE
loc_030904:
        DBRA    D7,loc_0308B6                   ; $030904
        TST.B  $0250(A6)                        ; $030908
        BPL.S  loc_030914                       ; $03090C
        BSET    #2,$0340(A6)                    ; $03090E
loc_030914:
        TST.B  $0310(A6)                        ; $030914
        BPL.S  loc_030934                       ; $030918
        BSET    #2,$0370(A6)                    ; $03091A
        ORI.B  #$001F,D4                        ; $030920
        MOVE.B  D4,$00C00011                    ; $030924
        BCHG    #5,D4                           ; $03092A
        MOVE.B  D4,$00C00011                    ; $03092E
loc_030934:
        RTS                                     ; $030934
        DC.W    $00FF                           ; $030936
        OR.B   D0,D3                            ; $030938
        DC.W    $00FF                           ; $03093A
        DIVU    -$01(A0,D0.W),D3                ; $03093C
        OR.W   D3,(A0)                          ; $030940
        DC.W    $00FF                           ; $030942
        OR.B   (A0),D4                          ; $030944
        DC.W    $00FF                           ; $030946
        OR.W   D0,D4                            ; $030948
        DC.W    $00FF                           ; $03094A
        OR.W   $2E(A0,D4.W),D4                  ; $03094C
        ORI.B  #$7027,D0                        ; $030950
        MOVEQ   #$00,D1                         ; $030954
        JSR     loc_030CBA(PC)                  ; $030956
        LEA     $0220(A6),A5                    ; $03095A
        MOVEQ   #$05,D6                         ; $03095E
loc_030960:
        TST.B  (A5)                             ; $030960
        BPL.W  loc_0309E8                       ; $030962
        BCLR    #7,(A5)                         ; $030966
        MOVEQ   #$00,D3                         ; $03096A
        MOVE.B  $0001(A5),D3                    ; $03096C
        BMI.S  loc_0309B2                       ; $030970
        JSR     loc_030C8A(PC)                  ; $030972
        CMPI.B  #$0004,D3                       ; $030976
        BNE.S  loc_03098C                       ; $03097A
        TST.B  $0340(A6)                        ; $03097C
        BPL.S  loc_03098C                       ; $030980
        LEA     $0340(A6),A5                    ; $030982
        MOVEA.L $0034(A6),A1                    ; $030986
        BRA.S  loc_03099E                       ; $03098A
loc_03098C:
        SUBQ.B  #2,D3                           ; $03098C
        LSL.B  #2,D3                            ; $03098E
        LEA     -$0140(PC),A0                   ; $030990
        MOVEA.L A5,A3                           ; $030994
        MOVEA.L $00(A0,D3.W),A5                 ; $030996
        MOVEA.L $0030(A6),A1                    ; $03099A
loc_03099E:
        BCLR    #2,(A5)                         ; $03099E
        BSET    #1,(A5)                         ; $0309A2
        MOVE.B  $000B(A5),D0                    ; $0309A6
        JSR     loc_0312E8(PC)                  ; $0309AA
        MOVEA.L A3,A5                           ; $0309AE
        BRA.S  loc_0309E8                       ; $0309B0
loc_0309B2:
        JSR     loc_030FB2(PC)                  ; $0309B2
        LEA     $0370(A6),A0                    ; $0309B6
        CMPI.B  #$00E0,D3                       ; $0309BA
        BEQ.S  loc_0309D0                       ; $0309BE
        CMPI.B  #$00C0,D3                       ; $0309C0
        BEQ.S  loc_0309D0                       ; $0309C4
        LSR.B  #3,D3                            ; $0309C6
        LEA     -$0178(PC),A0                   ; $0309C8
        MOVEA.L $00(A0,D3.W),A0                 ; $0309CC
loc_0309D0:
        BCLR    #2,(A0)                         ; $0309D0
        BSET    #1,(A0)                         ; $0309D4
        CMPI.B  #$00E0,$0001(A0)                ; $0309D8
        BNE.S  loc_0309E8                       ; $0309DE
        MOVE.B  $0025(A0),$00C00011             ; $0309E0
loc_0309E8:
        ADDA.W  #$0030,A5                       ; $0309E8
        DBRA    D6,loc_030960                   ; $0309EC
        RTS                                     ; $0309F0
loc_0309F2:
        LEA     $0340(A6),A5                    ; $0309F2
        TST.B  (A5)                             ; $0309F6
        BPL.S  loc_030A24                       ; $0309F8
        BCLR    #7,(A5)                         ; $0309FA
        BTST    #2,(A5)                         ; $0309FE
        BNE.S  loc_030A24                       ; $030A02
        JSR     loc_030C96(PC)                  ; $030A04
        LEA     $0100(A6),A5                    ; $030A08
        BCLR    #2,(A5)                         ; $030A0C
        BSET    #1,(A5)                         ; $030A10
        TST.B  (A5)                             ; $030A14
        BPL.S  loc_030A24                       ; $030A16
        MOVEA.L $0030(A6),A1                    ; $030A18
        MOVE.B  $000B(A5),D0                    ; $030A1C
        JSR     loc_0312E8(PC)                  ; $030A20
loc_030A24:
        LEA     $0370(A6),A5                    ; $030A24
        TST.B  (A5)                             ; $030A28
        BPL.S  loc_030A5A                       ; $030A2A
        BCLR    #7,(A5)                         ; $030A2C
        BTST    #2,(A5)                         ; $030A30
        BNE.S  loc_030A5A                       ; $030A34
        JSR     loc_030FB8(PC)                  ; $030A36
        LEA     $01F0(A6),A5                    ; $030A3A
        BCLR    #2,(A5)                         ; $030A3E
        BSET    #1,(A5)                         ; $030A42
        TST.B  (A5)                             ; $030A46
        BPL.S  loc_030A5A                       ; $030A48
        CMPI.B  #$00E0,$0001(A5)                ; $030A4A
        BNE.S  loc_030A5A                       ; $030A50
        MOVE.B  $0025(A5),$00C00011             ; $030A52
loc_030A5A:
        RTS                                     ; $030A5A
loc_030A5C:
        JSR     loc_03094E(PC)                  ; $030A5C
        JSR     loc_0309F2(PC)                  ; $030A60
        MOVE.B  #$0001,$0006(A6)                ; $030A64
        MOVE.B  #$0005,$0004(A6)                ; $030A6A
        RTS                                     ; $030A70
        MOVEQ   #$00,D0                         ; $030A72
        MOVE.B  $0004(A6),D0                    ; $030A74
        BEQ.S  loc_030A84                       ; $030A78
        MOVE.B  $0006(A6),D0                    ; $030A7A
        BEQ.S  loc_030A86                       ; $030A7E
        SUBQ.B  #1,$0006(A6)                    ; $030A80
loc_030A84:
        RTS                                     ; $030A84
loc_030A86:
        SUBQ.B  #1,$0004(A6)                    ; $030A86
        BEQ.W  loc_030B90                       ; $030A8A
        MOVE.B  #$0001,$0006(A6)                ; $030A8E
        LEA     $0040(A6),A5                    ; $030A94
        TST.B  (A5)                             ; $030A98
        BPL.S  loc_030AAC                       ; $030A9A
        ADDQ.B  #4,$0009(A5)                    ; $030A9C
        BPL.S  loc_030AA8                       ; $030AA0
        BCLR    #7,(A5)                         ; $030AA2
        BRA.S  loc_030AAC                       ; $030AA6
loc_030AA8:
        JSR     loc_030DF4(PC)                  ; $030AA8
loc_030AAC:
        LEA     $0070(A6),A5                    ; $030AAC
        MOVEQ   #$05,D7                         ; $030AB0
loc_030AB2:
        TST.B  (A5)                             ; $030AB2
        BPL.S  loc_030AC6                       ; $030AB4
        ADDQ.B  #1,$0009(A5)                    ; $030AB6
        BPL.S  loc_030AC2                       ; $030ABA
        BCLR    #7,(A5)                         ; $030ABC
        BRA.S  loc_030AC6                       ; $030AC0
loc_030AC2:
        JSR     loc_03135A(PC)                  ; $030AC2
loc_030AC6:
        ADDA.W  #$0030,A5                       ; $030AC6
        DBRA    D7,loc_030AB2                   ; $030ACA
        MOVEQ   #$02,D7                         ; $030ACE
loc_030AD0:
        TST.B  (A5)                             ; $030AD0
        BPL.S  loc_030AEE                       ; $030AD2
        ADDQ.B  #1,$0009(A5)                    ; $030AD4
        CMPI.B  #$0010,$0009(A5)                ; $030AD8
        BCS.S  loc_030AE6                       ; $030ADE
        BCLR    #7,(A5)                         ; $030AE0
        BRA.S  loc_030AEE                       ; $030AE4
loc_030AE6:
        MOVE.B  $0009(A5),D6                    ; $030AE6
        JSR     loc_030F60(PC)                  ; $030AEA
loc_030AEE:
        ADDA.W  #$0030,A5                       ; $030AEE
        DBRA    D7,loc_030AD0                   ; $030AF2
        RTS                                     ; $030AF6
        MOVE.B  $0002(A6),D0                    ; $030AF8
        BEQ.S  loc_030B1A                       ; $030AFC
        ADD.B  D0,$0001(A6)                     ; $030AFE
        BCC.S  loc_030B1A                       ; $030B02
        LEA     $0040(A6),A0                    ; $030B04
        MOVEQ   #$30,D0                         ; $030B08
        MOVEQ   #$09,D1                         ; $030B0A
loc_030B0C:
        TST.B  (A0)                             ; $030B0C
        BPL.S  loc_030B14                       ; $030B0E
        ADDQ.B  #1,$000E(A0)                    ; $030B10
loc_030B14:
        ADDA.W  D0,A0                           ; $030B14
        DBRA    D1,loc_030B0C                   ; $030B16
loc_030B1A:
        RTS                                     ; $030B1A
loc_030B1C:
        JSR     loc_030D1C(PC)                  ; $030B1C
        MOVEQ   #$03,D4                         ; $030B20
        MOVEQ   #$40,D3                         ; $030B22
        MOVEQ   #$7F,D1                         ; $030B24
loc_030B26:
        MOVE.B  D3,D0                           ; $030B26
        JSR     loc_030CCC(PC)                  ; $030B28
        ADDQ.B  #4,D3                           ; $030B2C
        DBRA    D4,loc_030B26                   ; $030B2E
        MOVEQ   #$03,D4                         ; $030B32
        MOVE.B  #$0080,D3                       ; $030B34
        MOVEQ   #$0F,D1                         ; $030B38
loc_030B3A:
        MOVE.B  D3,D0                           ; $030B3A
        JSR     loc_030CCC(PC)                  ; $030B3C
        ADDQ.B  #4,D3                           ; $030B40
        DBRA    D4,loc_030B3A                   ; $030B42
        MOVE.W  #$0000,$00A11100                ; $030B46
        RTS                                     ; $030B4E
loc_030B50:
        MOVEQ   #$02,D2                         ; $030B50
        MOVEQ   #$28,D0                         ; $030B52
        JSR     loc_030D1C(PC)                  ; $030B54
loc_030B58:
        MOVE.B  D2,D1                           ; $030B58
        JSR     loc_030CD8(PC)                  ; $030B5A
        ADDQ.B  #4,D1                           ; $030B5E
        JSR     loc_030CD8(PC)                  ; $030B60
        DBRA    D2,loc_030B58                   ; $030B64
        MOVEQ   #$40,D0                         ; $030B68
        MOVEQ   #$7F,D1                         ; $030B6A
        MOVEQ   #$02,D3                         ; $030B6C
loc_030B6E:
        MOVEQ   #$03,D2                         ; $030B6E
loc_030B70:
        JSR     loc_030CD8(PC)                  ; $030B70
        JSR     loc_030CFE(PC)                  ; $030B74
        ADDQ.W  #4,D0                           ; $030B78
        DBRA    D2,loc_030B70                   ; $030B7A
        SUBI.B  #$000F,D0                       ; $030B7E
        DBRA    D3,loc_030B6E                   ; $030B82
        MOVE.W  #$0000,$00A11100                ; $030B86
        RTS                                     ; $030B8E
loc_030B90:
        MOVEQ   #$2B,D0                         ; $030B90
        MOVE.B  #$0080,D1                       ; $030B92
        JSR     loc_030CBA(PC)                  ; $030B96
        MOVEQ   #$27,D0                         ; $030B9A
        MOVEQ   #$00,D1                         ; $030B9C
        JSR     loc_030CBA(PC)                  ; $030B9E
        MOVEA.L A6,A0                           ; $030BA2
        MOVE.W  #$00E3,D0                       ; $030BA4
loc_030BA8:
        CLR.L  (A0)+                            ; $030BA8
        DBRA    D0,loc_030BA8                   ; $030BAA
        MOVE.B  #$0080,$0009(A6)                ; $030BAE
        JSR     loc_030B50(PC)                  ; $030BB4
        BRA.W  loc_030FC8                       ; $030BB8
        MOVEQ   #$27,D0                         ; $030BBC
        MOVEQ   #$00,D1                         ; $030BBE
        JSR     loc_030CBA(PC)                  ; $030BC0
        MOVEA.L A6,A0                           ; $030BC4
        MOVE.B  $0000(A6),D1                    ; $030BC6
        MOVE.W  #$0087,D0                       ; $030BCA
loc_030BCE:
        CLR.L  (A0)+                            ; $030BCE
        DBRA    D0,loc_030BCE                   ; $030BD0
        MOVE.B  D1,$0000(A6)                    ; $030BD4
        MOVE.B  #$0080,$0009(A6)                ; $030BD8
        RTS                                     ; $030BDE
loc_030BE0:
        LEA     $0040(A6),A0                    ; $030BE0
        MOVE.W  #$0077,D0                       ; $030BE4
loc_030BE8:
        CLR.L  (A0)+                            ; $030BE8
        DBRA    D0,loc_030BE8                   ; $030BEA
        MOVE.B  #$0080,$0009(A6)                ; $030BEE
        RTS                                     ; $030BF4
loc_030BF6:
        LEA     $00FF8500,A6                    ; $030BF6
        MOVE.W  #$0100,$00A11100                ; $030BFC
loc_030C04:
        BTST    #0,$00A11100                    ; $030C04
        BNE.S  loc_030C04                       ; $030C0C
        LEA     $0A78(PC),A0                    ; $030C0E
        LEA     $00A00000,A1                    ; $030C12
        MOVE.W  #$028C,D0                       ; $030C18
loc_030C1C:
        MOVE.B  (A0)+,(A1)+                     ; $030C1C
        DBRA    D0,loc_030C1C                   ; $030C1E
        LEA     $0CF1(PC),A0                    ; $030C22
        LEA     $00A01000,A1                    ; $030C26
        MOVE.W  #$0FFF,D0                       ; $030C2C
loc_030C30:
        MOVE.B  (A0)+,(A1)+                     ; $030C30
        DBRA    D0,loc_030C30                   ; $030C32
        MOVE.W  #$0000,$00A11200                ; $030C36
        NOP                                     ; $030C3E
        NOP                                     ; $030C40
        NOP                                     ; $030C42
        NOP                                     ; $030C44
        NOP                                     ; $030C46
        NOP                                     ; $030C48
        NOP                                     ; $030C4A
        NOP                                     ; $030C4C
        NOP                                     ; $030C4E
        NOP                                     ; $030C50
        NOP                                     ; $030C52
        NOP                                     ; $030C54
        NOP                                     ; $030C56
        NOP                                     ; $030C58
        MOVE.W  #$0100,$00A11200                ; $030C5A
        MOVE.W  #$0000,$00A11100                ; $030C62
        BRA.W  loc_030B90                       ; $030C6A
        BTST    #1,(A5)                         ; $030C6E
        BNE.S  loc_030C88                       ; $030C72
        BTST    #2,(A5)                         ; $030C74
        BNE.S  loc_030C88                       ; $030C78
        MOVEQ   #$28,D0                         ; $030C7A
        MOVE.B  $0001(A5),D1                    ; $030C7C
        ORI.B  #$00F0,D1                        ; $030C80
        BRA.W  loc_030CBA                       ; $030C84
loc_030C88:
        RTS                                     ; $030C88
loc_030C8A:
        BTST    #4,(A5)                         ; $030C8A
        BNE.S  loc_030CA0                       ; $030C8E
        BTST    #2,(A5)                         ; $030C90
        BNE.S  loc_030CA0                       ; $030C94
loc_030C96:
        MOVEQ   #$28,D0                         ; $030C96
        MOVE.B  $0001(A5),D1                    ; $030C98
        BRA.W  loc_030CBA                       ; $030C9C
loc_030CA0:
        RTS                                     ; $030CA0
loc_030CA2:
        BTST    #2,(A5)                         ; $030CA2
        BNE.S  loc_030CB8                       ; $030CA6
        JSR     loc_030D1C(PC)                  ; $030CA8
        JSR     loc_030CCC(PC)                  ; $030CAC
        MOVE.W  #$0000,$00A11100                ; $030CB0
loc_030CB8:
        RTS                                     ; $030CB8
loc_030CBA:
        JSR     loc_030D1C(PC)                  ; $030CBA
        JSR     loc_030CD8(PC)                  ; $030CBE
        MOVE.W  #$0000,$00A11100                ; $030CC2
        RTS                                     ; $030CCA
loc_030CCC:
        BTST    #2,$0001(A5)                    ; $030CCC
        BNE.S  loc_030CF4                       ; $030CD2
        ADD.B  $0001(A5),D0                     ; $030CD4
loc_030CD8:
        LEA     $00A04000,A0                    ; $030CD8
loc_030CDE:
        BTST    #7,(A0)                         ; $030CDE
        BNE.S  loc_030CDE                       ; $030CE2
        MOVE.B  D0,(A0)                         ; $030CE4
        NOP                                     ; $030CE6
loc_030CE8:
        BTST    #7,(A0)                         ; $030CE8
        BNE.S  loc_030CE8                       ; $030CEC
        MOVE.B  D1,$0001(A0)                    ; $030CEE
        RTS                                     ; $030CF2
loc_030CF4:
        MOVE.B  $0001(A5),D2                    ; $030CF4
        BCLR    #2,D2                           ; $030CF8
        ADD.B  D2,D0                            ; $030CFC
loc_030CFE:
        LEA     $00A04000,A0                    ; $030CFE
loc_030D04:
        BTST    #7,(A0)                         ; $030D04
        BNE.S  loc_030D04                       ; $030D08
        MOVE.B  D0,$0002(A0)                    ; $030D0A
        NOP                                     ; $030D0E
loc_030D10:
        BTST    #7,(A0)                         ; $030D10
        BNE.S  loc_030D10                       ; $030D14
        MOVE.B  D1,$0003(A0)                    ; $030D16
        RTS                                     ; $030D1A
loc_030D1C:
        MOVE.W  #$0100,$00A11100                ; $030D1C
loc_030D24:
        BTST    #0,$00A11100                    ; $030D24
        BNE.S  loc_030D24                       ; $030D2C
        BTST    #7,$00A00FFF                    ; $030D2E
        BEQ.S  loc_030D4C                       ; $030D36
        MOVE.W  #$0000,$00A11100                ; $030D38
        NOP                                     ; $030D40
        NOP                                     ; $030D42
        NOP                                     ; $030D44
        NOP                                     ; $030D46
        NOP                                     ; $030D48
        BRA.S  loc_030D1C                       ; $030D4A
loc_030D4C:
        RTS                                     ; $030D4C
        TST.B  $0038(A6)                        ; $030D4E
        BEQ.W  loc_030DF2                       ; $030D52
        CMPI.B  #$0002,$0038(A6)                ; $030D56
        BEQ.W  loc_030DF2                       ; $030D5C
        MOVE.B  $0039(A6),D6                    ; $030D60
        LEA     $0040(A6),A5                    ; $030D64
        TST.B  (A5)                             ; $030D68
        BPL.S  loc_030D82                       ; $030D6A
        TST.B  $0038(A6)                        ; $030D6C
        BPL.S  loc_030D78                       ; $030D70
        SUB.B  D6,$0009(A5)                     ; $030D72
        BRA.S  loc_030D7E                       ; $030D76
loc_030D78:
        ADD.B  D6,$0009(A5)                     ; $030D78
        BMI.S  loc_030D82                       ; $030D7C
loc_030D7E:
        JSR     loc_030DF4(PC)                  ; $030D7E
loc_030D82:
        MOVE.B  $003A(A6),D6                    ; $030D82
        LEA     $0070(A6),A5                    ; $030D86
        MOVEQ   #$05,D7                         ; $030D8A
loc_030D8C:
        TST.B  (A5)                             ; $030D8C
        BPL.S  loc_030DA6                       ; $030D8E
        TST.B  $0038(A6)                        ; $030D90
        BPL.S  loc_030D9C                       ; $030D94
        SUB.B  D6,$0009(A5)                     ; $030D96
        BRA.S  loc_030DA2                       ; $030D9A
loc_030D9C:
        ADD.B  D6,$0009(A5)                     ; $030D9C
        BMI.S  loc_030DA6                       ; $030DA0
loc_030DA2:
        JSR     loc_03135A(PC)                  ; $030DA2
loc_030DA6:
        ADDA.W  #$0030,A5                       ; $030DA6
        DBRA    D7,loc_030D8C                   ; $030DAA
        MOVE.B  $003B(A6),D5                    ; $030DAE
        MOVEQ   #$02,D7                         ; $030DB2
loc_030DB4:
        TST.B  (A5)                             ; $030DB4
        BPL.S  loc_030DD8                       ; $030DB6
        TST.B  $0038(A6)                        ; $030DB8
        BPL.S  loc_030DC4                       ; $030DBC
        SUB.B  D5,$0009(A5)                     ; $030DBE
        BRA.S  loc_030DD0                       ; $030DC2
loc_030DC4:
        ADD.B  D5,$0009(A5)                     ; $030DC4
        CMPI.B  #$0010,$0009(A5)                ; $030DC8
        BCC.S  loc_030DD8                       ; $030DCE
loc_030DD0:
        MOVE.B  $0009(A5),D6                    ; $030DD0
        JSR     loc_030F60(PC)                  ; $030DD4
loc_030DD8:
        ADDA.W  #$0030,A5                       ; $030DD8
        DBRA    D7,loc_030DB4                   ; $030DDC
        TST.B  $0038(A6)                        ; $030DE0
        BMI.S  loc_030DEE                       ; $030DE4
        MOVE.B  #$0002,$0038(A6)                ; $030DE6
        RTS                                     ; $030DEC
loc_030DEE:
        CLR.B  $0038(A6)                        ; $030DEE
loc_030DF2:
        RTS                                     ; $030DF2
loc_030DF4:
        MOVE.W  #$0100,$00A11100                ; $030DF4
loc_030DFC:
        BTST    #0,$00A11100                    ; $030DFC
        BNE.S  loc_030DFC                       ; $030E04
        MOVE.B  $0009(A5),D0                    ; $030E06
        LSR.B  #3,D0                            ; $030E0A
        ANDI.B  #$000F,D0                       ; $030E0C
        MOVE.B  D0,$00A00FFD                    ; $030E10
        MOVE.W  #$0000,$00A11100                ; $030E16
        RTS                                     ; $030E1E
        ANDI.W  #$0284,(A6)+                    ; $030E20
        ANDI.L  #$02D302FE,$032D(A3)            ; $030E24
        BCHG    D1,(A4)+                        ; $030E2C
        BCLR    D1,A7                           ; $030E2E
        BSET    D1,D5                           ; $030E30
        BSET    D1,<EA:3F>                      ; $030E32
        SUBI.B  #$047C,#$532D                   ; $030E34
        ORI.B  #$6610,A6                        ; $030E3A
        BCLR    #4,(A5)                         ; $030E3E
        JSR     loc_030E5E(PC)                  ; $030E42
        JSR     loc_030EC2(PC)                  ; $030E46
        BRA.W  loc_030F16                       ; $030E4A
        JSR     loc_03021A(PC)                  ; $030E4E
        JSR     loc_030F0E(PC)                  ; $030E52
        JSR     loc_030242(PC)                  ; $030E56
        BRA.W  loc_030ECE                       ; $030E5A
loc_030E5E:
        BCLR    #1,(A5)                         ; $030E5E
        MOVEA.L $0004(A5),A4                    ; $030E62
loc_030E66:
        MOVEQ   #$00,D5                         ; $030E66
        MOVE.B  (A4)+,D5                        ; $030E68
        CMPI.B  #$00E0,D5                       ; $030E6A
        BCS.S  loc_030E76                       ; $030E6E
        JSR     loc_031094(PC)                  ; $030E70
        BRA.S  loc_030E66                       ; $030E74
loc_030E76:
        TST.B  D5                               ; $030E76
        BPL.S  loc_030E8A                       ; $030E78
        JSR     loc_030E92(PC)                  ; $030E7A
        MOVE.B  (A4)+,D5                        ; $030E7E
        TST.B  D5                               ; $030E80
        BPL.S  loc_030E8A                       ; $030E82
        SUBQ.W  #1,A4                           ; $030E84
        BRA.W  $0301D2                          ; $030E86
loc_030E8A:
        JSR     $0301B2(PC)                     ; $030E8A
        BRA.W  $0301D2                          ; $030E8E
loc_030E92:
        SUBI.B  #$0081,D5                       ; $030E92
        BCS.S  loc_030EB0                       ; $030E96
        ADD.B  $0008(A5),D5                     ; $030E98
        ANDI.W  #$007F,D5                       ; $030E9C
        LSL.W  #1,D5                            ; $030EA0
        LEA     $013C(PC),A0                    ; $030EA2
        MOVE.W  $00(A0,D5.W),$0010(A5)          ; $030EA6
        BRA.W  $0301D2                          ; $030EAC
loc_030EB0:
        BSET    #1,(A5)                         ; $030EB0
        MOVE.W  #$FFFF,$0010(A5)                ; $030EB4
        JSR     $0301D2(PC)                     ; $030EBA
        BRA.W  loc_030FB2                       ; $030EBE
loc_030EC2:
        MOVE.W  $0010(A5),D6                    ; $030EC2
        BPL.S  loc_030ED4                       ; $030EC6
        BSET    #1,(A5)                         ; $030EC8
        RTS                                     ; $030ECC
loc_030ECE:
        TST.B  $000A(A5)                        ; $030ECE
        BEQ.S  loc_030F0C                       ; $030ED2
loc_030ED4:
        BTST    #1,(A5)                         ; $030ED4
        BNE.S  loc_030F0C                       ; $030ED8
        BTST    #2,(A5)                         ; $030EDA
        BNE.S  loc_030F0C                       ; $030EDE
        JSR     loc_0302EE(PC)                  ; $030EE0
        MOVE.B  $0001(A5),D0                    ; $030EE4
        CMPI.B  #$00E0,D0                       ; $030EE8
        BNE.S  loc_030EF2                       ; $030EEC
        MOVE.B  #$00C0,D0                       ; $030EEE
loc_030EF2:
        MOVE.W  D6,D1                           ; $030EF2
        ANDI.B  #$000F,D1                       ; $030EF4
        OR.B   D1,D0                            ; $030EF8
        LSR.W  #4,D6                            ; $030EFA
        ANDI.B  #$003F,D6                       ; $030EFC
        MOVE.B  D0,$00C00011                    ; $030F00
        MOVE.B  D6,$00C00011                    ; $030F06
loc_030F0C:
        RTS                                     ; $030F0C
loc_030F0E:
        TST.B  $000B(A5)                        ; $030F0E
        BEQ.W  loc_030F80                       ; $030F12
loc_030F16:
        MOVE.B  $0009(A5),D6                    ; $030F16
        MOVEQ   #$00,D0                         ; $030F1A
        MOVE.B  $000B(A5),D0                    ; $030F1C
        BEQ.S  loc_030F60                       ; $030F20
        LEA     $1AD6(PC),A0                    ; $030F22
        SUBQ.W  #1,D0                           ; $030F26
        LSL.W  #2,D0                            ; $030F28
        MOVEA.L $00(A0,D0.W),A0                 ; $030F2A
loc_030F2E:
        MOVEQ   #$00,D0                         ; $030F2E
        MOVE.B  $000C(A5),D0                    ; $030F30
        ADDQ.B  #1,$000C(A5)                    ; $030F34
        MOVE.B  $00(A0,D0.W),D0                 ; $030F38
        BPL.S  loc_030F56                       ; $030F3C
        CMPI.B  #$0083,D0                       ; $030F3E
        BEQ.S  loc_030F90                       ; $030F42
        CMPI.B  #$0081,D0                       ; $030F44
        BEQ.S  loc_030F9C                       ; $030F48
        CMPI.B  #$0082,D0                       ; $030F4A
        BEQ.S  loc_030FA2                       ; $030F4E
        CMPI.B  #$0080,D0                       ; $030F50
        BEQ.S  loc_030FAA                       ; $030F54
loc_030F56:
        ADD.W  D0,D6                            ; $030F56
        CMPI.B  #$0010,D6                       ; $030F58
        BCS.S  loc_030F60                       ; $030F5C
        MOVEQ   #$0F,D6                         ; $030F5E
loc_030F60:
        BTST    #1,(A5)                         ; $030F60
        BNE.S  loc_030F80                       ; $030F64
        BTST    #2,(A5)                         ; $030F66
        BNE.S  loc_030F80                       ; $030F6A
        BTST    #4,(A5)                         ; $030F6C
        BNE.S  loc_030F82                       ; $030F70
loc_030F72:
        OR.B   $0001(A5),D6                     ; $030F72
        ADDI.B  #$0010,D6                       ; $030F76
        MOVE.B  D6,$00C00011                    ; $030F7A
loc_030F80:
        RTS                                     ; $030F80
loc_030F82:
        TST.B  $0013(A5)                        ; $030F82
        BEQ.S  loc_030F72                       ; $030F86
        TST.B  $0012(A5)                        ; $030F88
        BNE.S  loc_030F72                       ; $030F8C
        RTS                                     ; $030F8E
loc_030F90:
        SUBQ.B  #2,$000C(A5)                    ; $030F90
        BSET    #1,(A5)                         ; $030F94
        BRA.W  loc_030FB2                       ; $030F98
loc_030F9C:
        SUBQ.B  #2,$000C(A5)                    ; $030F9C
        RTS                                     ; $030FA0
loc_030FA2:
        MOVE.B  $01(A0,D0.W),$000C(A5)          ; $030FA2
        BRA.S  loc_030F2E                       ; $030FA8
loc_030FAA:
        CLR.B  $000C(A5)                        ; $030FAA
        BRA.W  loc_030F2E                       ; $030FAE
loc_030FB2:
        BTST    #2,(A5)                         ; $030FB2
        BNE.S  loc_030FC6                       ; $030FB6
loc_030FB8:
        MOVE.B  $0001(A5),D0                    ; $030FB8
        ORI.B  #$001F,D0                        ; $030FBC
        MOVE.B  D0,$00C00011                    ; $030FC0
loc_030FC6:
        RTS                                     ; $030FC6
loc_030FC8:
        LEA     $00C00011,A0                    ; $030FC8
        MOVE.B  #$009F,(A0)                     ; $030FCE
        MOVE.B  #$00BF,(A0)                     ; $030FD2
        MOVE.B  #$00DF,(A0)                     ; $030FD6
        MOVE.B  #$00FF,(A0)                     ; $030FDA
        RTS                                     ; $030FDE
        BCHG    D1,(A6)                         ; $030FE0
        BTST    D1,-(A6)                        ; $030FE2
        DC.W    $02F9                           ; $030FE4
        DC.W    $02CE                           ; $030FE6
        ANDI.L  #$0280025C,-(A5)                ; $030FE8
        ANDI.B  #$021A,$01FB(PC)                ; $030FEE
        BSET    D0,(A7)+                        ; $030FF4
        BSET    D0,D4                           ; $030FF6
        BCLR    D0,$0193(A3)                    ; $030FF8
        BCHG    D0,<EA:3D>                      ; $030FFC
        BCHG    D0,-(A7)                        ; $030FFE
        BCHG    D0,(A3)                         ; $031000
        BCHG    D0,D0                           ; $031002
        BTST    D0,$011D(A6)                    ; $031004
        BTST    D0,A5                           ; $031008
        DC.W    $00FE                           ; $03100A
        DC.W    $00EF                           ; $03100C
        DC.W    $00E2                           ; $03100E
        DC.W    $00D6                           ; $031010
        DC.W    $00C9                           ; $031012
        ORI.L  #$00B400A9,<EA:3E>               ; $031014
        ORI.L  #$0097008F,-(A0)                 ; $03101A
        ORI.L  #$007F0078,D7                    ; $031020
        ORI.W  #$006B,$65(A1,D0.W)              ; $031026
        ORI.W  #$005A,(A7)+                     ; $03102C
        ORI.W  #$0050,(A5)                      ; $031030
        ORI.W  #$0047,A3                        ; $031034
        ORI.W  #$0040,D3                        ; $031038
        ORI.B  #$0039,#$0036                    ; $03103C
        ORI.B  #$0030,$2D(A3,D0.W)              ; $031042
        ORI.B  #$0028,$0026(A3)                 ; $031048
        ORI.B  #$0022,-(A4)                     ; $03104E
        ORI.B  #$001F,-(A0)                     ; $031052
        ORI.B  #$001B,(A5)+                     ; $031056
        ORI.B  #$0018,(A2)+                     ; $03105A
        ORI.B  #$0016,(A7)                      ; $03105E
        ORI.B  #$0013,(A5)                      ; $031062
        ORI.B  #$0011,(A2)                      ; $031066
        ORI.B  #$000F,(A0)                      ; $03106A
        ORI.B  #$000D,A6                        ; $03106E
        ORI.B  #$000B,A4                        ; $031072
        ORI.B  #$0009,A2                        ; $031076
        ORI.B  #$0007,A0                        ; $03107A
        ORI.B  #$0005,D6                        ; $03107E
        ORI.B  #$0003,D4                        ; $031082
        ORI.B  #$0001,D2                        ; $031086
        ORI.B  #$0000,D0                        ; $03108A
        ORI.B  #$0000,D0                        ; $03108E
        ORI.B  #$0445,D0                        ; $031092
        DC.W    $00E0                           ; $031096
        LSL.W  #2,D5                            ; $031098
        JMP     $02(PC,D5.W)                    ; $03109A
        BRA.W  loc_0311B8                       ; $03109E
        BRA.W  loc_0311D8                       ; $0310A2
        BRA.W  loc_0311E2                       ; $0310A6
        BRA.W  loc_0311E8                       ; $0310AA
        BRA.W  loc_0311F0                       ; $0310AE
        BRA.W  loc_031218                       ; $0310B2
        BRA.W  loc_031228                       ; $0310B6
        BRA.W  loc_03123A                       ; $0310BA
        BRA.W  loc_031240                       ; $0310BE
        BRA.W  loc_03124A                       ; $0310C2
        BRA.W  loc_03129C                       ; $0310C6
        BRA.W  loc_0312A6                       ; $0310CA
        BRA.W  loc_0312AC                       ; $0310CE
        BRA.W  loc_0312B4                       ; $0310D2
        BRA.W  loc_0312BC                       ; $0310D6
        BRA.W  loc_0312C4                       ; $0310DA
        BRA.W  loc_0313E2                       ; $0310DE
        BRA.W  loc_031406                       ; $0310E2
        BRA.W  loc_031418                       ; $0310E6
        BRA.W  loc_0314DC                       ; $0310EA
        BRA.W  loc_0314F6                       ; $0310EE
        BRA.W  loc_0314FC                       ; $0310F2
        BRA.W  loc_031502                       ; $0310F6
        BRA.W  loc_03150E                       ; $0310FA
        BRA.W  loc_031528                       ; $0310FE
        BRA.W  loc_03153A                       ; $031102
        BRA.W  loc_03154E                       ; $031106
        BRA.W  loc_031554                       ; $03110A
        BRA.W  loc_03155C                       ; $03110E
        BRA.W  loc_031564                       ; $031112
        BRA.W  loc_03156C                       ; $031116
        MOVEQ   #$00,D0                         ; $03111A
        MOVE.B  (A4)+,D0                        ; $03111C
        LSL.W  #2,D0                            ; $03111E
        JMP     $02(PC,D0.W)                    ; $031120
        BRA.W  loc_031574                       ; $031124
        BRA.W  loc_031598                       ; $031128
        BRA.W  loc_031650                       ; $03112C
        BRA.W  loc_031666                       ; $031130
        BRA.W  loc_031680                       ; $031134
        BRA.W  loc_031188                       ; $031138
        BRA.W  loc_03117C                       ; $03113C
        BRA.W  loc_031166                       ; $031140
        MOVEQ   #$00,D0                         ; $031144
        MOVE.B  (A4)+,D0                        ; $031146
        MOVE.B  $18(A6,D0.W),D1                 ; $031148
        TST.B  $16(A6,D0.W)                     ; $03114C
        BEQ.S  loc_031164                       ; $031150
        BPL.S  loc_031156                       ; $031152
        NEG.B  D1                               ; $031154
loc_031156:
        ADD.B  D1,$0009(A5)                     ; $031156
        MOVEQ   #$00,D1                         ; $03115A
        MOVE.B  D1,$16(A6,D0.W)                 ; $03115C
        BRA.W  loc_03135A                       ; $031160
loc_031164:
        RTS                                     ; $031164
loc_031166:
        MOVE.B  (A4)+,D0                        ; $031166
        JSR     loc_030D1C(PC)                  ; $031168
        MOVE.B  D0,$00A00FFE                    ; $03116C
        MOVE.W  #$0000,$00A11100                ; $031172
        RTS                                     ; $03117A
loc_03117C:
        MOVE.B  (A4)+,D0                        ; $03117C
        LSL.W  #8,D0                            ; $03117E
        MOVE.B  (A4)+,D0                        ; $031180
        MOVE.W  D0,$001E(A5)                    ; $031182
        RTS                                     ; $031186
loc_031188:
        MOVE.B  (A4)+,D0                        ; $031188
        EXT.W   D0                              ; $03118A
        MOVE.B  $10(A6,D0.W),D1                 ; $03118C
        ADD.W  D0,D0                            ; $031190
        TST.B  D1                               ; $031192
        BEQ.S  loc_0311B6                       ; $031194
        BMI.S  loc_0311A8                       ; $031196
        MOVE.W  $12(A6,D0.W),D1                 ; $031198
        ADD.W  D1,$001E(A5)                     ; $03119C
        MOVEQ   #$00,D1                         ; $0311A0
        MOVE.B  D1,$10(A6,D0.W)                 ; $0311A2
        RTS                                     ; $0311A6
loc_0311A8:
        MOVE.W  $12(A6,D0.W),D1                 ; $0311A8
        SUB.W  D1,$001E(A5)                     ; $0311AC
        MOVEQ   #$00,D1                         ; $0311B0
        MOVE.B  D1,$10(A6,D0.W)                 ; $0311B2
loc_0311B6:
        RTS                                     ; $0311B6
loc_0311B8:
        MOVE.B  (A4)+,D1                        ; $0311B8
        TST.B  $0001(A5)                        ; $0311BA
        BMI.S  loc_0311D6                       ; $0311BE
        MOVE.B  $0027(A5),D0                    ; $0311C0
        ANDI.B  #$0037,D0                       ; $0311C4
        OR.B   D0,D1                            ; $0311C8
        MOVE.B  D1,$0027(A5)                    ; $0311CA
        MOVE.B  #$00B4,D0                       ; $0311CE
        BRA.W  loc_030CA2                       ; $0311D2
loc_0311D6:
        RTS                                     ; $0311D6
loc_0311D8:
        MOVE.B  (A4)+,D0                        ; $0311D8
        EXT.W   D0                              ; $0311DA
        MOVE.W  D0,$001E(A5)                    ; $0311DC
        RTS                                     ; $0311E0
loc_0311E2:
        MOVE.B  (A4)+,$0003(A6)                 ; $0311E2
        RTS                                     ; $0311E6
loc_0311E8:
        JSR     loc_030B1C(PC)                  ; $0311E8
        BRA.W  loc_031418                       ; $0311EC
loc_0311F0:
        MOVE.B  (A4)+,$0028(A5)                 ; $0311F0
        BEQ.S  loc_03120C                       ; $0311F4
        MOVE.B  (A4)+,$0020(A5)                 ; $0311F6
        MOVE.B  (A4)+,$0021(A5)                 ; $0311FA
        MOVE.B  (A4)+,$0022(A5)                 ; $0311FE
        MOVE.B  (A4),$0023(A5)                  ; $031202
        MOVE.B  (A4)+,$0024(A5)                 ; $031206
        RTS                                     ; $03120A
loc_03120C:
        MOVE.B  #$00B4,D0                       ; $03120C
        MOVE.B  $0027(A5),D1                    ; $031210
        BRA.W  loc_030CA2                       ; $031214
loc_031218:
        MOVE.B  (A4)+,D0                        ; $031218
        TST.B  $0001(A5)                        ; $03121A
        BPL.S  loc_031228                       ; $03121E
        ADD.B  D0,$0009(A5)                     ; $031220
        ADDQ.W  #1,A4                           ; $031224
        RTS                                     ; $031226
loc_031228:
        MOVE.B  (A4)+,D0                        ; $031228
        ADD.B  D0,$0009(A5)                     ; $03122A
        TST.B  $0008(A6)                        ; $03122E
        BMI.W  loc_030DF4                       ; $031232
        BRA.W  loc_03135A                       ; $031236
loc_03123A:
        BSET    #4,(A5)                         ; $03123A
        RTS                                     ; $03123E
loc_031240:
        MOVE.B  (A4),$0012(A5)                  ; $031240
        MOVE.B  (A4)+,$0013(A5)                 ; $031244
        RTS                                     ; $031248
loc_03124A:
        MOVEA.L $0030(A6),A1                    ; $03124A
        BEQ.S  loc_031254                       ; $03124E
        MOVEA.L $0020(A5),A1                    ; $031250
loc_031254:
        MOVE.B  (A4),D3                         ; $031254
        ADDA.W  #$0009,A0                       ; $031256
        LEA     $003C(PC),A2                    ; $03125A
        MOVEQ   #$03,D6                         ; $03125E
loc_031260:
        MOVE.B  (A1)+,D1                        ; $031260
        MOVE.B  (A2)+,D0                        ; $031262
        BTST    #7,D3                           ; $031264
        BEQ.S  loc_031272                       ; $031268
        BSET    #7,D1                           ; $03126A
        JSR     loc_030CA2(PC)                  ; $03126E
loc_031272:
        LSL.W  #1,D3                            ; $031272
        DBRA    D6,loc_031260                   ; $031274
        MOVE.B  (A4)+,D1                        ; $031278
        MOVEQ   #$22,D0                         ; $03127A
        JSR     loc_030CBA(PC)                  ; $03127C
        MOVE.B  (A4)+,D1                        ; $031280
        MOVE.B  $0027(A5),D0                    ; $031282
        ANDI.B  #$00C0,D0                       ; $031286
        OR.B   D0,D1                            ; $03128A
        MOVE.B  D1,$0027(A5)                    ; $03128C
        MOVE.B  #$00B4,D0                       ; $031290
        BRA.W  loc_030CA2                       ; $031294
        BRA.S  loc_031302                       ; $031298
        BCC.S  loc_031308                       ; $03129A
loc_03129C:
        MOVE.B  (A4),$0002(A6)                  ; $03129C
        MOVE.B  (A4)+,$0001(A6)                 ; $0312A0
        RTS                                     ; $0312A4
loc_0312A6:
        MOVE.B  (A4)+,$000A(A6)                 ; $0312A6
        RTS                                     ; $0312AA
loc_0312AC:
        MOVE.B  (A4)+,D0                        ; $0312AC
        ADD.B  D0,$0009(A5)                     ; $0312AE
        RTS                                     ; $0312B2
loc_0312B4:
        MOVE.B  (A4)+,D0                        ; $0312B4
        MOVE.B  (A4)+,D1                        ; $0312B6
        BRA.W  loc_030CA2                       ; $0312B8
loc_0312BC:
        MOVE.B  (A4)+,D0                        ; $0312BC
        MOVE.B  (A4)+,D1                        ; $0312BE
        BRA.W  loc_030CBA                       ; $0312C0
loc_0312C4:
        MOVEQ   #$00,D0                         ; $0312C4
        MOVE.B  (A4)+,D0                        ; $0312C6
        MOVE.B  D0,$000B(A5)                    ; $0312C8
        BTST    #2,(A5)                         ; $0312CC
        BNE.W  loc_031350                       ; $0312D0
        MOVEA.L $0030(A6),A1                    ; $0312D4
        TST.B  $000E(A6)                        ; $0312D8
        BEQ.S  loc_0312E8                       ; $0312DC
        MOVEA.L $0020(A5),A1                    ; $0312DE
        BMI.S  loc_0312E8                       ; $0312E2
        MOVEA.L $0034(A6),A1                    ; $0312E4
loc_0312E8:
        SUBQ.W  #1,D0                           ; $0312E8
        BMI.S  loc_0312F6                       ; $0312EA
        MOVE.W  #$0019,D1                       ; $0312EC
loc_0312F0:
        ADDA.W  D1,A1                           ; $0312F0
        DBRA    D0,loc_0312F0                   ; $0312F2
loc_0312F6:
        JSR     loc_030D1C(PC)                  ; $0312F6
        MOVE.B  (A1)+,D1                        ; $0312FA
        MOVE.B  D1,$0025(A5)                    ; $0312FC
        MOVE.B  D1,D4                           ; $031300
loc_031302:
        MOVE.B  #$00B0,D0                       ; $031302
        JSR     loc_030CCC(PC)                  ; $031306
        LEA     $00BE(PC),A2                    ; $03130A
        MOVEQ   #$13,D3                         ; $03130E
loc_031310:
        MOVE.B  (A2)+,D0                        ; $031310
        MOVE.B  (A1)+,D1                        ; $031312
        JSR     loc_030CCC(PC)                  ; $031314
        DBRA    D3,loc_031310                   ; $031318
        MOVEQ   #$03,D5                         ; $03131C
        ANDI.W  #$0007,D4                       ; $03131E
        MOVE.B  $2E(PC,D4.W),D4                 ; $031322
        MOVE.B  $0009(A5),D3                    ; $031326
loc_03132A:
        MOVE.B  (A2)+,D0                        ; $03132A
        MOVE.B  (A1)+,D1                        ; $03132C
        LSR.B  #1,D4                            ; $03132E
        BCC.S  loc_031334                       ; $031330
        ADD.B  D3,D1                            ; $031332
loc_031334:
        JSR     loc_030CCC(PC)                  ; $031334
        DBRA    D5,loc_03132A                   ; $031338
        MOVE.B  #$00B4,D0                       ; $03133C
        MOVE.B  $0027(A5),D1                    ; $031340
        JSR     loc_030CCC(PC)                  ; $031344
        MOVE.W  #$0000,$00A11100                ; $031348
loc_031350:
        RTS                                     ; $031350
        BTST    #8,A0                           ; $031352
        EORI.B  #$0E0F,A6                       ; $031356
loc_03135A:
        BTST    #2,(A5)                         ; $03135A
        BNE.S  loc_0313C8                       ; $03135E
        MOVEQ   #$00,D0                         ; $031360
        MOVE.B  $000B(A5),D0                    ; $031362
        MOVEA.L $0030(A6),A1                    ; $031366
        TST.B  $000E(A6)                        ; $03136A
        BEQ.S  loc_03137E                       ; $03136E
        MOVEA.L $0020(A5),A1                    ; $031370
        TST.B  $000E(A6)                        ; $031374
        BMI.S  loc_03137E                       ; $031378
        MOVEA.L $0034(A6),A1                    ; $03137A
loc_03137E:
        SUBQ.W  #1,D0                           ; $03137E
        BMI.S  loc_03138C                       ; $031380
        MOVE.W  #$0019,D1                       ; $031382
loc_031386:
        ADDA.W  D1,A1                           ; $031386
        DBRA    D0,loc_031386                   ; $031388
loc_03138C:
        ADDA.W  #$0015,A1                       ; $03138C
        LEA     $004C(PC),A2                    ; $031390
        MOVE.B  $0025(A5),D0                    ; $031394
        ANDI.W  #$0007,D0                       ; $031398
        MOVE.B  -$4C(PC,D0.W),D4                ; $03139C
        MOVE.B  $0009(A5),D3                    ; $0313A0
        BMI.S  loc_0313C8                       ; $0313A4
        MOVEQ   #$03,D5                         ; $0313A6
        JSR     loc_030D1C(PC)                  ; $0313A8
loc_0313AC:
        MOVE.B  (A2)+,D0                        ; $0313AC
        MOVE.B  (A1)+,D1                        ; $0313AE
        LSR.B  #1,D4                            ; $0313B0
        BCC.S  loc_0313BC                       ; $0313B2
        ADD.B  D3,D1                            ; $0313B4
        BCS.S  loc_0313BC                       ; $0313B6
        JSR     loc_030CCC(PC)                  ; $0313B8
loc_0313BC:
        DBRA    D5,loc_0313AC                   ; $0313BC
        MOVE.W  #$0000,$00A11100                ; $0313C0
loc_0313C8:
        RTS                                     ; $0313C8
        MOVE.W  $343C.W,D0                      ; $0313CA
        ADDQ.W  #8,(A0)+                        ; $0313CE
        ADDQ.W  #2,(A4)+                        ; $0313D0
        BRA.S  loc_03143C                       ; $0313D2
        BCC.S  loc_031442                       ; $0313D4
        MOVEQ   #$78,D0                         ; $0313D6
        MOVEQ   #$7C,D2                         ; $0313D8
        OR.L   A0,D0                            ; $0313DA
        OR.L   A4,D2                            ; $0313DC
        NEGX.W A0                               ; $0313DE
        NEG.W  A4                               ; $0313E0
loc_0313E2:
        BSET    #7,$000A(A5)                    ; $0313E2
        MOVE.L  A4,$0014(A5)                    ; $0313E8
        MOVE.B  (A4)+,$0018(A5)                 ; $0313EC
        MOVE.B  (A4)+,$0019(A5)                 ; $0313F0
        MOVE.B  (A4)+,$001A(A5)                 ; $0313F4
        MOVE.B  (A4)+,D0                        ; $0313F8
        LSR.B  #1,D0                            ; $0313FA
        MOVE.B  D0,$001B(A5)                    ; $0313FC
        CLR.W  $001C(A5)                        ; $031400
        RTS                                     ; $031404
loc_031406:
        MOVE.B  (A4)+,D0                        ; $031406
        TST.B  $0001(A5)                        ; $031408
        BPL.W  loc_0314F6                       ; $03140C
        MOVE.B  D0,$000A(A5)                    ; $031410
        MOVE.B  (A4)+,D0                        ; $031414
        RTS                                     ; $031416
loc_031418:
        BCLR    #7,(A5)                         ; $031418
        BCLR    #4,(A5)                         ; $03141C
        TST.B  $0001(A5)                        ; $031420
        BMI.S  loc_031434                       ; $031424
        TST.B  $0008(A6)                        ; $031426
        BMI.W  loc_0314D8                       ; $03142A
        JSR     loc_030C8A(PC)                  ; $03142E
        BRA.S  loc_031438                       ; $031432
loc_031434:
        JSR     loc_030FB2(PC)                  ; $031434
loc_031438:
        TST.B  $000E(A6)                        ; $031438
loc_03143C:
        BPL.W  loc_0314D8                       ; $03143C
        CLR.B  $0000(A6)                        ; $031440
        MOVEQ   #$00,D0                         ; $031444
        MOVE.B  $0001(A5),D0                    ; $031446
        BMI.S  loc_0314A2                       ; $03144A
        LEA     -$0BFC(PC),A0                   ; $03144C
        MOVEA.L A5,A3                           ; $031450
        CMPI.B  #$0004,D0                       ; $031452
        BNE.S  loc_031468                       ; $031456
        TST.B  $0340(A6)                        ; $031458
        BPL.S  loc_031468                       ; $03145C
        LEA     $0340(A6),A5                    ; $03145E
        MOVEA.L $0034(A6),A1                    ; $031462
        BRA.S  loc_031478                       ; $031466
loc_031468:
        SUBQ.B  #2,D0                           ; $031468
        LSL.B  #2,D0                            ; $03146A
        MOVEA.L $00(A0,D0.W),A5                 ; $03146C
        TST.B  (A5)                             ; $031470
        BPL.S  loc_031488                       ; $031472
        MOVEA.L $0030(A6),A1                    ; $031474
loc_031478:
        BCLR    #2,(A5)                         ; $031478
        BSET    #1,(A5)                         ; $03147C
        MOVE.B  $000B(A5),D0                    ; $031480
        JSR     loc_0312E8(PC)                  ; $031484
loc_031488:
        MOVEA.L A3,A5                           ; $031488
        CMPI.B  #$0002,$0001(A5)                ; $03148A
        BNE.S  loc_0314D8                       ; $031490
        TST.B  $000F(A6)                        ; $031492
        BNE.S  loc_0314D8                       ; $031496
        MOVEQ   #$00,D1                         ; $031498
        MOVEQ   #$27,D0                         ; $03149A
        JSR     loc_030CBA(PC)                  ; $03149C
        BRA.S  loc_0314D8                       ; $0314A0
loc_0314A2:
        LEA     $0370(A6),A0                    ; $0314A2
        TST.B  (A0)                             ; $0314A6
        BPL.S  loc_0314B6                       ; $0314A8
        CMPI.B  #$00E0,D0                       ; $0314AA
        BEQ.S  loc_0314C0                       ; $0314AE
        CMPI.B  #$00C0,D0                       ; $0314B0
        BEQ.S  loc_0314C0                       ; $0314B4
loc_0314B6:
        LEA     -$0C66(PC),A0                   ; $0314B6
        LSR.B  #3,D0                            ; $0314BA
        MOVEA.L $00(A0,D0.W),A0                 ; $0314BC
loc_0314C0:
        BCLR    #2,(A0)                         ; $0314C0
        BSET    #1,(A0)                         ; $0314C4
        CMPI.B  #$00E0,$0001(A0)                ; $0314C8
        BNE.S  loc_0314D8                       ; $0314CE
        MOVE.B  $0025(A0),$00C00011             ; $0314D0
loc_0314D8:
        ADDQ.W  #8,A7                           ; $0314D8
        RTS                                     ; $0314DA
loc_0314DC:
        MOVE.B  #$00E0,$0001(A5)                ; $0314DC
        MOVE.B  (A4)+,$0025(A5)                 ; $0314E2
        BTST    #2,(A5)                         ; $0314E6
        BNE.S  loc_0314F4                       ; $0314EA
        MOVE.B  -$0001(A4),$00C00011            ; $0314EC
loc_0314F4:
        RTS                                     ; $0314F4
loc_0314F6:
        MOVE.B  (A4)+,$000A(A5)                 ; $0314F6
        RTS                                     ; $0314FA
loc_0314FC:
        MOVE.B  (A4)+,$000B(A5)                 ; $0314FC
        RTS                                     ; $031500
loc_031502:
        MOVE.B  (A4)+,D0                        ; $031502
        LSL.W  #8,D0                            ; $031504
        MOVE.B  (A4)+,D0                        ; $031506
        ADDA.W  D0,A4                           ; $031508
        SUBQ.W  #1,A4                           ; $03150A
        RTS                                     ; $03150C
loc_03150E:
        MOVEQ   #$00,D0                         ; $03150E
        MOVE.B  (A4)+,D0                        ; $031510
        MOVE.B  (A4)+,D1                        ; $031512
        TST.B  $2A(A5,D0.W)                     ; $031514
        BNE.S  loc_03151E                       ; $031518
        MOVE.B  D1,$2A(A5,D0.W)                 ; $03151A
loc_03151E:
        SUBQ.B  #1,$2A(A5,D0.W)                 ; $03151E
        BNE.S  loc_031502                       ; $031522
        ADDQ.W  #2,A4                           ; $031524
        RTS                                     ; $031526
loc_031528:
        MOVEQ   #$00,D0                         ; $031528
        MOVE.B  $000D(A5),D0                    ; $03152A
        SUBQ.B  #4,D0                           ; $03152E
        MOVE.L  A4,$00(A5,D0.W)                 ; $031530
        MOVE.B  D0,$000D(A5)                    ; $031534
        BRA.S  loc_031502                       ; $031538
loc_03153A:
        MOVEQ   #$00,D0                         ; $03153A
        MOVE.B  $000D(A5),D0                    ; $03153C
        MOVEA.L $00(A5,D0.W),A4                 ; $031540
        ADDQ.W  #2,A4                           ; $031544
        ADDQ.B  #4,D0                           ; $031546
        MOVE.B  D0,$000D(A5)                    ; $031548
        RTS                                     ; $03154C
loc_03154E:
        MOVE.B  (A4)+,$0002(A5)                 ; $03154E
        RTS                                     ; $031552
loc_031554:
        MOVE.B  (A4)+,D0                        ; $031554
        ADD.B  D0,$0008(A5)                     ; $031556
        RTS                                     ; $03155A
loc_03155C:
        BSET    #7,$000A(A5)                    ; $03155C
        RTS                                     ; $031562
loc_031564:
        BCLR    #7,$000A(A5)                    ; $031564
        RTS                                     ; $03156A
loc_03156C:
        MOVEQ   #$00,D0                         ; $03156C
        MOVE.B  D0,$0000(A6)                    ; $03156E
        RTS                                     ; $031572
loc_031574:
        LEA     $001A(PC),A1                    ; $031574
        MOVEQ   #$03,D3                         ; $031578
loc_03157A:
        MOVE.B  (A1)+,D0                        ; $03157A
        MOVE.B  (A4)+,D1                        ; $03157C
        JSR     loc_030CA2(PC)                  ; $03157E
        MOVE.B  (A1)+,D0                        ; $031582
        MOVEQ   #$1F,D1                         ; $031584
        JSR     loc_030CA2(PC)                  ; $031586
        DBRA    D3,loc_03157A                   ; $03158A
        RTS                                     ; $03158E
        SUB.W  (A0),D0                          ; $031590
        SUB.W  (A0)+,D4                         ; $031592
        SUB.W  (A4),D2                          ; $031594
        SUB.W  (A4)+,D6                         ; $031596
loc_031598:
        MOVEQ   #$30,D3                         ; $031598
        MOVE.B  (A4)+,D0                        ; $03159A
        BEQ.S  loc_0315F4                       ; $03159C
        MOVEA.L A5,A3                           ; $03159E
        LEA     $0040(A6),A5                    ; $0315A0
        BTST    #7,(A5)                         ; $0315A4
        BEQ.S  loc_0315B2                       ; $0315A8
        BCLR    #7,(A5)                         ; $0315AA
        BSET    #0,(A5)                         ; $0315AE
loc_0315B2:
        MOVEQ   #$05,D4                         ; $0315B2
loc_0315B4:
        ADDA.W  D3,A5                           ; $0315B4
        BTST    #7,(A5)                         ; $0315B6
        BEQ.S  loc_0315D2                       ; $0315BA
        BCLR    #7,(A5)                         ; $0315BC
        BSET    #0,(A5)                         ; $0315C0
        MOVE.B  #$00B4,D0                       ; $0315C4
        MOVEQ   #$00,D1                         ; $0315C8
        JSR     loc_030CA2(PC)                  ; $0315CA
        JSR     loc_030C8A(PC)                  ; $0315CE
loc_0315D2:
        DBRA    D4,loc_0315B4                   ; $0315D2
        MOVEQ   #$02,D4                         ; $0315D6
loc_0315D8:
        ADDA.W  D3,A5                           ; $0315D8
        BTST    #7,(A5)                         ; $0315DA
        BEQ.S  loc_0315EC                       ; $0315DE
        BCLR    #7,(A5)                         ; $0315E0
        BSET    #0,(A5)                         ; $0315E4
        JSR     loc_030FB2(PC)                  ; $0315E8
loc_0315EC:
        DBRA    D4,loc_0315D8                   ; $0315EC
        MOVEA.L A3,A5                           ; $0315F0
        RTS                                     ; $0315F2
loc_0315F4:
        MOVEA.L A5,A3                           ; $0315F4
        LEA     $0040(A6),A5                    ; $0315F6
        BTST    #0,(A5)                         ; $0315FA
        BEQ.S  loc_031614                       ; $0315FE
        BSET    #7,(A5)                         ; $031600
        BCLR    #0,(A5)                         ; $031604
        MOVE.B  #$00B4,D0                       ; $031608
        MOVE.B  $0027(A5),D1                    ; $03160C
        JSR     loc_030CA2(PC)                  ; $031610
loc_031614:
        MOVEQ   #$05,D4                         ; $031614
loc_031616:
        ADDA.W  D3,A5                           ; $031616
        BTST    #0,(A5)                         ; $031618
        BEQ.S  loc_031632                       ; $03161C
        BSET    #7,(A5)                         ; $03161E
        BCLR    #0,(A5)                         ; $031622
        MOVE.B  #$00B4,D0                       ; $031626
        MOVE.B  $0027(A5),D1                    ; $03162A
        JSR     loc_030CA2(PC)                  ; $03162E
loc_031632:
        DBRA    D4,loc_031616                   ; $031632
        MOVEQ   #$02,D4                         ; $031636
loc_031638:
        ADDA.W  D3,A5                           ; $031638
        BTST    #0,(A5)                         ; $03163A
        BEQ.S  loc_031648                       ; $03163E
        BSET    #7,(A5)                         ; $031640
        BCLR    #0,(A5)                         ; $031644
loc_031648:
        DBRA    D4,loc_031638                   ; $031648
        MOVEA.L A3,A5                           ; $03164C
        RTS                                     ; $03164E
loc_031650:
        LEA     $0040(A6),A0                    ; $031650
        MOVE.B  (A4)+,D0                        ; $031654
        MOVEQ   #$30,D1                         ; $031656
        MOVEQ   #$09,D2                         ; $031658
loc_03165A:
        MOVE.B  D0,$0002(A0)                    ; $03165A
        ADDA.W  D1,A0                           ; $03165E
        DBRA    D2,loc_03165A                   ; $031660
        RTS                                     ; $031664
loc_031666:
        CMPI.B  #$0002,$0038(A6)                ; $031666
        BEQ.W  loc_03167E                       ; $03166C
        MOVE.B  #$0001,$0038(A6)                ; $031670
        MOVE.B  (A4)+,$003A(A6)                 ; $031676
        MOVE.B  (A4)+,$003B(A6)                 ; $03167A
loc_03167E:
        RTS                                     ; $03167E
loc_031680:
        MOVE.B  #$0080,$0038(A6)                ; $031680
        RTS                                     ; $031686
        MOVE.W  $00(A3,D0.L),$060010FE          ; $031688
        BTST    D6,-(A0)                        ; $031690
        MOVE.W  (A5)+,#$21F5                    ; $031692
        ORI.B  #$2A08,<EA:3E>                   ; $031696
        MOVE.L  $0F(A2,A7.L),-(A7)              ; $03169A
        MOVE.W  <EA:3E>,(A1)+                   ; $03169E
        BTST    D7,$0F(A2,A7.L)                 ; $0316A0
        MOVE.W  <EA:3F>,(A1)+                   ; $0316A4
        BTST    D7,<EA:3E>                      ; $0316A6
        MOVE.L  $40(A2,D0.W),-(A5)              ; $0316A8
        MOVE.W  D0,(A7)                         ; $0316AC
        MOVE.W  D1,D1                           ; $0316AE
        NEGX.B -$01F1(PC)                       ; $0316B0
        CMPA.L  A2,A3                           ; $0316B4
        MOVE.L  D0,-(A4)                        ; $0316B6
        MOVEA.W $3D(A6,D0.W),A5                 ; $0316B8
        MOVE.L  D5,-(A0)                        ; $0316BC
        BCHG    D0,A7                           ; $0316BE
        ADDI.B  #$0909,D0                       ; $0316C0
        MOVEQ   #$23,D7                         ; $0316C4
        BNE.S  loc_031737                       ; $0316C6
        MOVE.W  D0,(A7)                         ; $0316C8
        MOVE.W  <EA:3E>,(A1)+                   ; $0316CA
        BCHG    D7,<EA:3E>                      ; $0316CC
        MOVE.W  (A2)+,(A1)                      ; $0316CE
        ORI.B  #$BD00,$7E(A2,D2.W)              ; $0316D0
        MOVE.W  #$0F23,(A1)+                    ; $0316D6
        ADD.B  D4,-(A1)                         ; $0316DA
        ORI.W  #$770F,-(A0)                     ; $0316DC
        MOVE.W  A7,-(A3)                        ; $0316E0
        MOVE.W  A7,-(A3)                        ; $0316E2
        MOVE.W  A7,-(A3)                        ; $0316E4
        MOVE.W  A7,-(A3)                        ; $0316E6
        MOVE.W  A7,-(A3)                        ; $0316E8
        MOVE.W  A7,-(A3)                        ; $0316EA
        MOVE.W  A7,-(A3)                        ; $0316EC
        MOVE.W  D1,D3                           ; $0316EE
        MOVE.L  <EA:3F>,$0FD9.W                 ; $0316F0
        ADDQ.B  #7,-(A3)                        ; $0316F4
        ADDQ.B  #3,-(A3)                        ; $0316F6
        MOVEQ   #$23,D7                         ; $0316F8
        BNE.S  loc_03176B                       ; $0316FA
        DC.W    $0E80                           ; $0316FC
        MOVEQ   #$07,D7                         ; $0316FE
        BTST    D3,D7                           ; $031700
        BSET    D3,-(A6)                        ; $031702
        BTST    D7,$00(A2,A0.W)                 ; $031704
        MOVE.W  (A5)+,#$8601                    ; $031708
        LEA     (A1)+,A7                        ; $03170C
        SUBQ.B  #7,-$02F1(PC)                   ; $03170E
        MOVE.W  (A0),D3                         ; $031712
        SUBQ.B  #3,(A2)+                        ; $031714
        MOVE.W  A0,-(A2)                        ; $031716
        MOVE.W  D0,D1                           ; $031718
        NEGX.B A0                               ; $03171A
        MOVE.W  D1,D1                           ; $03171C
        NEGX.B $06(A4,A5.L)                     ; $03171E
        BTST    D0,(A0)                         ; $031722
        MOVEA.W <EA:3E>,A7                      ; $031724
        LSR.B  #3,D7                            ; $031726
        MOVE.W  -(A6),(A1)                      ; $031728
        ORI.W  #$DD86,$014FD95F                 ; $03172A
        MOVE.W  <EA:3D>,(A5)+                   ; $031732
        BSET    D7,$57(A6,D1.W)                 ; $031734
        MOVE.B  $32(A5,D0.L),D5                 ; $031738
        ORI.W  #$0832,D0                        ; $03173C
        BCHG    D0,D0                           ; $031740
        MOVE.W  (A1)+,(A2)+                     ; $031742
        ADDI.B  #$10FE,D1                       ; $031744
        MOVE.L  #$B5C2E900,$3AFC(A1)            ; $031748
        BTST    D7,#$32FC                       ; $031750
        BSET    D7,(A1)+                        ; $031754
        MOVE.L  D0,-(A0)                        ; $031756
        BRA.S  loc_0317D1                       ; $031758
        BCHG    D7,$77(A7,D0.L)                 ; $03175A
        BCHG    D7,$77(A7,D0.L)                 ; $03175E
        BCHG    D7,$77(A7,D0.L)                 ; $031762
        BCHG    D7,$36(A7,D0.L)                 ; $031766
        BTST    D0,-(A1)                        ; $03176A
        MOVE.W  A7,-(A7)                        ; $03176C
        ADD.B  D4,-(A6)                         ; $03176E
        OR.B   (A3)+,D0                         ; $031770
        MOVEQ   #-$4D,D5                        ; $031772
        AND.B  $0032(A1),D1                     ; $031774
        MOVE.W  A7,D7                           ; $031778
        AND.B  D1,$0000(A1)                     ; $03177A
        BTST    D0,D2                           ; $03177E
        SUBI.B  #$1020,A0                       ; $031780
        NEGX.L D0                               ; $031784
        MOVE.W  <EA:3E>,<EA:3F>                 ; $031786
        MOVE.W  $F0E0.W,(A6)+                   ; $031788
        AND.W  -(A7),D0                         ; $03178C
        BCHG    D0,$0173(A5)                    ; $03178E
        BCHG    D0,$017F0185                    ; $031792
        BCLR    D0,A3                           ; $031798
        BCLR    D0,(A1)                         ; $03179A
        BCLR    D0,(A7)                         ; $03179C
        BCLR    D0,(A5)+                        ; $03179E
        BCLR    D0,-(A3)                        ; $0317A0
        BCLR    D0,$01AF(A1)                    ; $0317A2
        BCLR    D0,-$45(A5,D0.W)                ; $0317A6
        BSET    D0,D1                           ; $0317AA
        BSET    D0,D7                           ; $0317AC
        BSET    D0,A5                           ; $0317AE
        BSET    D0,(A3)                         ; $0317B0
        BSET    D0,(A1)+                        ; $0317B2
        BSET    D0,(A7)+                        ; $0317B4
        BSET    D0,-(A5)                        ; $0317B6
        BSET    D0,$01F1(A3)                    ; $0317B8
        BSET    D0,-$03(A7,D0.W)                ; $0317BC
        BTST    D0,D3                           ; $0317C0
        ANDI.B  #$020F,A1                       ; $0317C2
        ANDI.B  #$021B,(A5)                     ; $0317C6
        ANDI.B  #$0227,-(A1)                    ; $0317CA
        ANDI.B  #$0233,$0239(A5)                ; $0317CE
        ANDI.B  #$0245,<EA:3F>                  ; $0317D4
        ANDI.W  #$0251,A3                       ; $0317D8
        ANDI.W  #$025D,(A7)                     ; $0317DC
        ANDI.W  #$0269,-(A3)                    ; $0317E0
        ANDI.W  #$0275,$027B(A7)                ; $0317E4
        ANDI.L  #$0287020A,D1                   ; $0317EA
        MOVE.B  -(A5),(A4)                      ; $0317F0
        BTST    D3,D0                           ; $0317F2
        OR.B   A2,D0                            ; $0317F4
        MOVE.B  $08A5(A7),D4                    ; $0317F6
        OR.B   D3,D5                            ; $0317FA
        MOVE.B  -(A1),(A4)                      ; $0317FC
        DC.W    $0AD4                           ; $0317FE
        OR.B   D7,A2                            ; $031800
        MOVE.B  -(A1),(A4)                      ; $031802
        DC.W    $0AD4                           ; $031804
        OR.B   D7,(A4)                          ; $031806
        MOVE.B  -(A1),(A4)                      ; $031808
        DC.W    $0AD4                           ; $03180A
        OR.B   D7,A2                            ; $03180C
        MOVE.B  $21759A0A,(A4)                  ; $03180E
        MOVE.B  $2E(PC,D0.L),(A4)               ; $031814
        CMP.B  A2,D6                            ; $031818
        MOVEA.B -(A0),A4                        ; $03181A
        MOVE.L  -$38F6(A1),(A1)+                ; $03181C
        MOVE.B  -(A1),(A4)+                     ; $031820
        MOVE.L  A1,-$15F6(A0)                   ; $031822
        MOVE.B  $2A(A5,D0.L),#$8C0A             ; $031826
        MOVE.B  D6,#$061F                       ; $03182C
        SUB.B  A2,D4                            ; $031830
        MOVE.B  $1AE59E0A,$1984(A4)             ; $031832
        BCHG    #10,(A6)+                       ; $03183A
        MOVE.B  -(A3),-(A4)                     ; $03183E
        DC.W    $04E2                           ; $031840
        AND.B  D0,A2                            ; $031842
        MOVE.B  (A6),#$0105                     ; $031844
        AND.B  A2,D3                            ; $031848
        MOVE.B  -(A0),-(A4)                     ; $03184A
        BSET    D6,(A3)+                        ; $03184C
        AND.B  D3,A2                            ; $03184E
        MOVE.B  $1DFB(A3),#$D40A                ; $031850
        MOVE.B  -(A2),-(A4)                     ; $031856
        MOVE.B  -(A6),<EA:3F>                   ; $031858
        MOVE.W  A2,D1                           ; $03185A
        MOVE.B  (A0),D5                         ; $03185C
        MOVE.B  A0,D5                           ; $03185E
        SUB.B  A4,D1                            ; $031860
        MOVE.B  A5,D5                           ; $031862
        MOVE.B  (A0)+,D0                        ; $031864
        MOVE.L  A5,D6                           ; $031866
        MOVE.B  $25(A4,D1.W),(A5)               ; $031868
        CMP.B  A5,D6                            ; $03186C
        MOVEA.B D0,A5                           ; $03186E
        BSET    D3,(A1)+                        ; $031870
        AND.B  A5,D6                            ; $031872
        MOVE.B  -(A6),(A5)                      ; $031874
        ADDI.B  #$D40C,(A1)+                    ; $031876
        MOVE.B  A0,D5                           ; $03187A
        BCLR    #14,<EA:3F>                     ; $03187C
        MOVE.B  D3,(A5)+                        ; $031880
        BSET    D2,D7                           ; $031882
        ASR.B  #1,D1                            ; $031884
        MOVEA.B D7,A5                           ; $031886
        MOVE.W  A2,$0A(A3,A6.L)                 ; $031888
        MOVE.B  (A4)+,<EA:3D>                   ; $03188C
        MOVE.B  (A1),<EA:3E>                    ; $03188E
        SUB.B  D7,A5                            ; $031890
        MOVE.B  -$53(A3,D0.L),-$42FC(A5)        ; $031892
        MOVE.B  $20(A1,D0.L),$04(A5,A4.L)       ; $031898
        MOVE.B  (A6),$12D1(A5)                  ; $03189E
        ADD.B  D3,D2                            ; $0318A2
        MOVE.B  $0127(A6),$03(A5,A6.W)          ; $0318A4
        MOVE.B  D3,-$2B(A5,D0.W)                ; $0318AA
        ASR.B  #4,D4                            ; $0318AE
        MOVE.B  (A3)+,<EA:3D>                   ; $0318B0
        CMPI.W  #$ED04,(A0)+                    ; $0318B2
        MOVE.B  -(A2),$33(A5,D0.L)              ; $0318B6
        MOVE.W  D4,D5                           ; $0318BA
        MOVE.B  D0,(A6)                         ; $0318BC
        BSET    D7,(A5)                         ; $0318BE
        OR.B   D4,D1                            ; $0318C0
        MOVE.B  $3955(A3),(A6)                  ; $0318C2
        SUB.B  D4,D4                            ; $0318C6
        MOVE.B  D2,D6                           ; $0318C8
        ORI.B  #$D30A,D0                        ; $0318CA
        MOVEA.B -(A2),A6                        ; $0318CE
        BTST    D3,D2                           ; $0318D0
        ADD.B  D1,A3                            ; $0318D2
        MOVE.B  $64(A4,D0.W),D6                 ; $0318D4
        ADD.B  A1,D5                            ; $0318D8
        MOVE.B  $1698(A2),D6                    ; $0318DA
        ADD.B  A1,D7                            ; $0318DE
        MOVE.B  $0CC2(PC),(A6)+                 ; $0318E0
        MOVE.W  D4,D2                           ; $0318E4
        MOVE.B  (A4)+,<EA:3E>                   ; $0318E6
        BCLR    D7,#$8101                       ; $0318E8
        MOVEA.B D1,A7                           ; $0318EC
        MOVE.L  $01(A1,A6.W),(A2)+              ; $0318EE
        MOVE.B  $261E(A0),-(A6)                 ; $0318F2
        CMP.B  D1,D1                            ; $0318F6
        MOVE.B  -(A1),(A7)+                     ; $0318F8
        MOVE.L  -(A0),-(A7)                     ; $0318FA
        OR.B   D1,D4                            ; $0318FC
        MOVE.B  (A0),$2B32(A7)                  ; $0318FE
        OR.B   D1,D6                            ; $031902
        MOVE.B  (A2)+,<EA:3E>                   ; $031904
        MOVE.L  D6,-$27FF(A7)                   ; $031906
        MOVE.B  $01(A0,D2.L),(A7)+              ; $03190A
        CMP.B  D4,D4                            ; $03190E
        MOVE.B  D6,-$68(A6,D2.W)                ; $031910
        SUB.B  D0,D0                            ; $031914
        BTST    D0,D2                           ; $031916
        BTST    D1,D4                           ; $031918
        BTST    D2,D6                           ; $03191A
        BTST    D3,A0                           ; $03191C
        BTST    D4,A2                           ; $03191E
        BTST    D5,A4                           ; $031920
        BTST    D6,A6                           ; $031922
        BTST    D7,(A0)                         ; $031924
        MOVE.B  (A2),-(A0)                      ; $031926
        MOVE.B  (A4),-(A1)                      ; $031928
        MOVE.B  (A6),-(A2)                      ; $03192A
        MOVE.B  (A0)+,-(A3)                     ; $03192C
        MOVE.B  (A2)+,-(A4)                     ; $03192E
        MOVE.B  (A4)+,-(A5)                     ; $031930
        MOVE.B  (A6)+,-(A6)                     ; $031932
        MOVE.B  -(A0),-(A7)                     ; $031934
        MOVE.L  -(A2),-(A0)                     ; $031936
        MOVE.L  -(A4),-(A1)                     ; $031938
        MOVE.L  -(A6),-(A2)                     ; $03193A
        MOVE.L  $292A(A0),-(A3)                 ; $03193C
        MOVE.L  $2D2E(A4),-(A5)                 ; $031940
        MOVE.L  $32(A0,D3.W),-(A7)              ; $031944
        MOVE.W  $36(A4,D3.W),-(A1)              ; $031948
        MOVE.W  $393A.W,-(A3)                   ; $03194C
        MOVE.W  #$3D3E,-(A5)                    ; $031950
        MOVE.W  D0,$4142(A7)                    ; $031954
        DC.W    $4344                           ; $031958
        DC.W    $4546                           ; $03195A
        DC.W    $4748                           ; $03195C
        DC.W    $494A                           ; $03195E
        DC.W    $4B4C                           ; $031960
        DC.W    $4D4E                           ; $031962
        DC.W    $4F50                           ; $031964
        SUBQ.W  #8,(A2)                         ; $031966
        SUBQ.W  #1,(A4)                         ; $031968
        SUBQ.W  #2,(A6)                         ; $03196A
        SUBQ.W  #3,(A0)+                        ; $03196C
        SUBQ.W  #4,(A2)+                        ; $03196E
        SUBQ.W  #5,(A4)+                        ; $031970
        SUBQ.W  #6,(A6)+                        ; $031972
        SUBQ.W  #7,-(A0)                        ; $031974
        BSR.S  loc_0319DA                       ; $031976
        BLS.S  loc_0319DE                       ; $031978
        BCS.S  loc_0319E2                       ; $03197A
        BEQ.S  loc_0319E6                       ; $03197C
        BVS.S  loc_0319EA                       ; $03197E
        BMI.S  loc_0319EE                       ; $031980
        BLT.S  loc_0319F2                       ; $031982
        BLE.S  loc_0319F6                       ; $031984
        MOVE.W  $74(A2,D7.W),$7576(A0)          ; $031986
        MOVE.W  $797A.W,$7B7C(A3)               ; $03198C
        MOVE.W  <EA:3E>,$7F80(A6)               ; $031992
        OR.L   D0,D2                            ; $031996
        OR.L   D1,D4                            ; $031998
        OR.L   D2,D6                            ; $03199A
        OR.L   D3,A0                            ; $03199C
        OR.L   D4,A2                            ; $03199E
        OR.L   D5,A4                            ; $0319A0
        OR.L   D6,A6                            ; $0319A2
        OR.L   D7,(A0)                          ; $0319A4
        SUB.L  D0,(A2)                          ; $0319A6
        SUB.L  D1,(A4)                          ; $0319A8
        SUB.L  D2,(A6)                          ; $0319AA
        SUB.L  D3,(A0)+                         ; $0319AC
        SUB.L  D4,(A2)+                         ; $0319AE
        SUB.L  D5,(A4)+                         ; $0319B0
        SUB.L  D6,(A6)+                         ; $0319B2
        SUB.L  D7,-(A0)                         ; $0319B4
        MOVE.L  -(A2),-$5C(A0,A2.W)             ; $0319B6
        MOVE.L  -(A6),-$58(A2,A2.W)             ; $0319BA
        MOVE.L  -$5454(A2),-$52(A4,A2.L)        ; $0319BE
        MOVE.L  -$4E(A0,A3.W),-$4C(A7,A3.W)     ; $0319C4
        EOR.L  D2,-$48(A6,A3.W)                 ; $0319CA
        EOR.L  D4,-$4444(PC)                    ; $0319CE
        EOR.L  D6,<EA:3E>                       ; $0319D2
        CMPA.L  D0,A7                           ; $0319D4
        MULS    D2,D0                           ; $0319D6
        MULS    D4,D1                           ; $0319D8
loc_0319DA:
        MULS    D6,D2                           ; $0319DA
        MULS    A0,D3                           ; $0319DC
loc_0319DE:
        MULS    A2,D4                           ; $0319DE
        MULS    A4,D5                           ; $0319E0
loc_0319E2:
        MULS    A6,D6                           ; $0319E2
        MULS    (A0),D7                         ; $0319E4
loc_0319E6:
        ADDA.L  (A2),A0                         ; $0319E6
        ADDA.L  (A4),A1                         ; $0319E8
loc_0319EA:
        ADDA.L  (A6),A2                         ; $0319EA
        ADDA.L  (A0)+,A3                        ; $0319EC
loc_0319EE:
        ADDA.L  (A2)+,A4                        ; $0319EE
        ADDA.L  (A4)+,A5                        ; $0319F0
loc_0319F2:
        ADDA.L  (A6)+,A6                        ; $0319F2
        ADDA.L  -(A0),A7                        ; $0319F4
loc_0319F6:
        ASL.W  -(A2)                            ; $0319F6
        LSL.W  -(A4)                            ; $0319F8
        ROXL.W  -(A6)                           ; $0319FA
        ROL.W  -$1616(A0)                       ; $0319FC
        LSL.W  -$1212(A4)                       ; $031A00
        ROL.W  -$0E(A0,A7.W)                    ; $031A04
        MOVE.W  -$0A(A4,A7.W),$F7F8F9FA         ; $031A08
        MOVE.W  #$FDFE,<EA:3D>                  ; $031A10
        MOVE.W  A0,-(A7)                        ; $031A14
        BTST    D4,A2                           ; $031A16
        BTST    D5,A4                           ; $031A18
        BTST    D6,A6                           ; $031A1A
        BTST    D7,(A0)                         ; $031A1C
        MOVE.B  (A2),-(A0)                      ; $031A1E
        MOVE.B  (A4),-(A1)                      ; $031A20
        MOVE.B  (A6),-(A2)                      ; $031A22
        MOVE.B  (A7),D3                         ; $031A24
        MOVE.B  (A1)+,D4                        ; $031A26
        MOVE.B  (A3)+,D5                        ; $031A28
        MOVE.B  (A5)+,D6                        ; $031A2A
        MOVE.B  (A7)+,D7                        ; $031A2C
        MOVE.L  -(A1),D0                        ; $031A2E
        MOVE.L  -(A3),D1                        ; $031A30
        MOVE.L  -(A5),D2                        ; $031A32
        MOVE.L  -(A6),-(A2)                     ; $031A34
        MOVE.L  $292A(A0),-(A3)                 ; $031A36
        MOVE.L  $2D2E(A4),-(A5)                 ; $031A3A
        MOVE.L  $32(A0,D3.W),-(A7)              ; $031A3E
        MOVE.W  $35(A4,D3.W),-(A1)              ; $031A42
        MOVE.W  $39(A7,D3.L),D3                 ; $031A46
        MOVE.W  $3D(PC,D3.L),D5                 ; $031A4A
        MOVE.W  <EA:3F>,D7                      ; $031A4E
        NEGX.W D1                               ; $031A50
        CLR.W  D3                               ; $031A52
        DC.W    $4344                           ; $031A54
        DC.W    $4546                           ; $031A56
        DC.W    $4748                           ; $031A58
        DC.W    $494A                           ; $031A5A
        DC.W    $4B4C                           ; $031A5C
        DC.W    $4D4E                           ; $031A5E
        DC.W    $4F50                           ; $031A60
        SUBQ.W  #8,(A2)                         ; $031A62
        ADDQ.W  #1,(A3)                         ; $031A64
        ADDQ.W  #2,(A5)                         ; $031A66
        ADDQ.W  #3,(A7)                         ; $031A68
        ADDQ.W  #4,(A1)+                        ; $031A6A
        ADDQ.W  #5,(A3)+                        ; $031A6C
        ADDQ.W  #6,(A5)+                        ; $031A6E
        ADDQ.W  #7,(A7)+                        ; $031A70
        BRA.S  loc_031AD5                       ; $031A72
        BSR.S  loc_031AD8                       ; $031A74
        BLS.S  loc_031ADC                       ; $031A76
        BCS.S  loc_031AE0                       ; $031A78
        BEQ.S  loc_031AE4                       ; $031A7A
        BVS.S  loc_031AE8                       ; $031A7C
        BMI.S  loc_031AEC                       ; $031A7E
        BLT.S  loc_031AF0                       ; $031A80
        BLE.S  loc_031AF4                       ; $031A82
        MOVEQ   #$71,D0                         ; $031A84
        MOVEQ   #$73,D1                         ; $031A86
        MOVEQ   #$75,D2                         ; $031A88
        MOVEQ   #$77,D3                         ; $031A8A
        MOVEQ   #$79,D4                         ; $031A8C
        MOVEQ   #$7B,D5                         ; $031A8E
        MOVEQ   #$7D,D6                         ; $031A90
        MOVEQ   #$7F,D7                         ; $031A92
        MOVE.W  D0,-$7F(A7,A0.W)                ; $031A94
        OR.L   D3,D1                            ; $031A98
        OR.L   D5,D2                            ; $031A9A
        OR.L   D7,D3                            ; $031A9C
        OR.L   A1,D4                            ; $031A9E
        OR.L   A3,D5                            ; $031AA0
        OR.L   A5,D6                            ; $031AA2
        OR.L   A7,D7                            ; $031AA4
        OR.L   D7,(A0)                          ; $031AA6
        SUB.L  D0,(A2)                          ; $031AA8
        SUB.L  D1,(A4)                          ; $031AAA
        SUB.L  D2,(A6)                          ; $031AAC
        SUB.L  D3,(A0)+                         ; $031AAE
        SUB.L  D4,(A2)+                         ; $031AB0
        SUB.L  D5,(A4)+                         ; $031AB2
        SUB.L  D6,(A6)+                         ; $031AB4
        SUB.L  (A7)+,D7                         ; $031AB6
        MOVE.L  -(A1),(A0)                      ; $031AB8
        MOVE.L  -(A3),(A1)                      ; $031ABA
        MOVE.L  -(A5),(A2)                      ; $031ABC
        MOVE.L  -(A7),(A3)                      ; $031ABE
        MOVE.L  -$5555(A1),(A4)                 ; $031AC0
        MOVE.L  -$5252(A5),(A6)                 ; $031AC4
        MOVE.L  -$4E(A0,A3.W),-$4C(A7,A3.W)     ; $031AC8
        EOR.L  D2,-$48(A6,A3.W)                 ; $031ACE
        EOR.L  D4,-$4444(PC)                    ; $031AD2
        CMP.L  <EA:3D>,D6                       ; $031AD6
loc_031AD8:
        CMP.L  <EA:3F>,D7                       ; $031AD8
        MULU    D1,D0                           ; $031ADA
loc_031ADC:
        MULU    D3,D1                           ; $031ADC
        MULU    D5,D2                           ; $031ADE
loc_031AE0:
        MULU    D7,D3                           ; $031AE0
        MULU    A1,D4                           ; $031AE2
loc_031AE4:
        MULU    A3,D5                           ; $031AE4
        MULS    A4,D5                           ; $031AE6
loc_031AE8:
        MULS    A6,D6                           ; $031AE8
        MULS    (A0),D7                         ; $031AEA
loc_031AEC:
        ADDA.L  (A2),A0                         ; $031AEC
        ADDA.L  (A4),A1                         ; $031AEE
loc_031AF0:
        ADDA.L  (A6),A2                         ; $031AF0
        ADDA.L  (A0)+,A3                        ; $031AF2
loc_031AF4:
        ADDA.L  (A2)+,A4                        ; $031AF4
        ADDA.W  (A3)+,A5                        ; $031AF6
        ADDA.W  (A5)+,A6                        ; $031AF8
        ADDA.W  (A7)+,A7                        ; $031AFA
        ASR.W  -(A1)                            ; $031AFC
        LSR.W  -(A3)                            ; $031AFE
        ROXR.W  -(A5)                           ; $031B00
        ROR.W  -(A7)                            ; $031B02
        ASR.W  -$1616(A1)                       ; $031B04
        LSL.W  -$1212(A4)                       ; $031B08
        ROL.W  -$0E(A0,A7.W)                    ; $031B0C
        MOVE.W  -$0A(A4,A7.W),$F7101112         ; $031B10
        MOVE.B  (A4),-(A1)                      ; $031B18
        MOVE.B  (A6),-(A2)                      ; $031B1A
        MOVE.B  (A7),D3                         ; $031B1C
        MOVE.B  (A1)+,D4                        ; $031B1E
        MOVE.B  (A3)+,D5                        ; $031B20
        MOVE.B  (A5)+,D6                        ; $031B22
        MOVE.B  (A6)+,-(A6)                     ; $031B24
        MOVE.B  -(A0),-(A7)                     ; $031B26
        MOVE.L  -(A2),-(A0)                     ; $031B28
        MOVE.L  -(A4),-(A1)                     ; $031B2A
        MOVE.L  -(A5),D2                        ; $031B2C
        MOVE.L  -(A7),D3                        ; $031B2E
        MOVE.L  $2A2B(A1),D4                    ; $031B30
        MOVE.L  $2D2E(A4),-(A5)                 ; $031B34
        MOVE.L  $32(A0,D3.W),-(A7)              ; $031B38
        MOVE.W  $35(A3,D3.W),D1                 ; $031B3C
        MOVE.W  $39(A7,D3.L),D3                 ; $031B40
        MOVE.W  $3B3C(PC),-(A4)                 ; $031B44
        MOVE.W  <EA:3E>,-(A6)                   ; $031B48
        MOVE.W  D0,$4041(A7)                    ; $031B4A
        CLR.W  D3                               ; $031B4E
        NEG.W  D5                               ; $031B50
        NOT.W  D7                               ; $031B52
        DC.W    $4748                           ; $031B54
        DC.W    $494A                           ; $031B56
        DC.W    $4B4C                           ; $031B58
        DC.W    $4D4E                           ; $031B5A
        TRAP    #15                             ; $031B5C
        ADDQ.W  #8,(A1)                         ; $031B5E
        ADDQ.W  #1,(A3)                         ; $031B60
        ADDQ.W  #2,(A5)                         ; $031B62
        SUBQ.W  #2,(A6)                         ; $031B64
        SUBQ.W  #3,(A0)+                        ; $031B66
        SUBQ.W  #4,(A2)+                        ; $031B68
        SUBQ.W  #5,(A4)+                        ; $031B6A
        ADDQ.W  #6,(A5)+                        ; $031B6C
        ADDQ.W  #7,(A7)+                        ; $031B6E
        BRA.S  loc_031BD3                       ; $031B70
        BHI.S  loc_031BD7                       ; $031B72
        BLS.S  loc_031BDA                       ; $031B74
        BCS.S  loc_031BDE                       ; $031B76
        BEQ.S  loc_031BE2                       ; $031B78
        BVS.S  loc_031BE6                       ; $031B7A
        BPL.S  loc_031BE9                       ; $031B7C
        BGE.S  loc_031BED                       ; $031B7E
        BGT.S  loc_031BF1                       ; $031B80
        MOVEQ   #$71,D0                         ; $031B82
        MOVE.W  $74(A2,D7.W),$7576(A0)          ; $031B84
        MOVE.W  $7879.W,$7A7B(A3)               ; $031B8A
        MOVEQ   #$7D,D6                         ; $031B90
        MOVEQ   #$7F,D7                         ; $031B92
        MOVE.W  D0,-$7F(A7,A0.W)                ; $031B94
        OR.L   D3,D1                            ; $031B98
        OR.L   D5,D2                            ; $031B9A
        OR.L   D7,D3                            ; $031B9C
        OR.L   D3,A0                            ; $031B9E
        OR.L   D4,A2                            ; $031BA0
        OR.L   D5,A4                            ; $031BA2
        OR.L   D6,A6                            ; $031BA4
        OR.L   A7,D7                            ; $031BA6
        SUB.L  (A1),D0                          ; $031BA8
        SUB.L  (A3),D1                          ; $031BAA
        SUB.L  (A5),D2                          ; $031BAC
        SUB.L  D2,(A6)                          ; $031BAE
        SUB.L  D3,(A0)+                         ; $031BB0
        SUB.L  D4,(A2)+                         ; $031BB2
        SUB.L  D5,(A4)+                         ; $031BB4
        SUB.L  (A5)+,D6                         ; $031BB6
        SUB.L  (A7)+,D7                         ; $031BB8
        MOVE.L  -(A1),(A0)                      ; $031BBA
        MOVE.L  -(A3),(A1)                      ; $031BBC
        MOVE.L  -(A4),-$5A(A1,A2.W)             ; $031BBE
        MOVE.L  -$5656(A0),-$55(A3,A2.L)        ; $031BC2
        MOVE.L  -$5151(A5),(A6)                 ; $031BC8
        CMP.L  -$4E(A1,A3.W),D0                 ; $031BCC
        EOR.L  D1,-$4A(A4,A3.W)                 ; $031BD0
        EOR.L  D3,$B8B9.W                       ; $031BD4
        CMP.L  -$43(PC,A3.L),D5                 ; $031BD8
        CMP.L  <EA:3F>,D7                       ; $031BDC
loc_031BDE:
        CMPA.L  D0,A7                           ; $031BDE
        MULS    D2,D0                           ; $031BE0
loc_031BE2:
        MULS    D4,D1                           ; $031BE2
        MULS    D6,D2                           ; $031BE4
loc_031BE6:
        MULU    D7,D3                           ; $031BE6
        MULU    A1,D4                           ; $031BE8
        MULU    A3,D5                           ; $031BEA
        MULU    A5,D6                           ; $031BEC
        MULS    A6,D6                           ; $031BEE
        MULS    (A0),D7                         ; $031BF0
        ADDA.L  (A2),A0                         ; $031BF2
        ADDA.L  (A4),A1                         ; $031BF4
        ADDA.W  (A5),A2                         ; $031BF6
        ADDA.W  (A7),A3                         ; $031BF8
        ADDA.W  (A1)+,A4                        ; $031BFA
        ADDA.W  (A3)+,A5                        ; $031BFC
        ADDA.L  (A4)+,A5                        ; $031BFE
        ADDA.L  (A6)+,A6                        ; $031C00
        ADDA.L  -(A0),A7                        ; $031C02
        ASL.W  -(A2)                            ; $031C04
        LSR.W  -(A3)                            ; $031C06
        ROXR.W  -(A5)                           ; $031C08
        ROR.W  -(A7)                            ; $031C0A
        ASR.W  -$1616(A1)                       ; $031C0C
        LSL.W  -$1212(A4)                       ; $031C10
        ROL.B  #7,D0                            ; $031C14
        MOVE.B  (A2)+,-(A4)                     ; $031C16
        MOVE.B  (A4)+,-(A5)                     ; $031C18
        MOVE.B  (A5)+,D6                        ; $031C1A
        MOVE.B  (A7)+,D7                        ; $031C1C
        MOVE.L  -(A0),D0                        ; $031C1E
        MOVE.L  -(A2),-(A0)                     ; $031C20
        MOVE.L  -(A4),-(A1)                     ; $031C22
        MOVE.L  -(A5),D2                        ; $031C24
        MOVE.L  -(A7),D3                        ; $031C26
        MOVE.L  $292A(A1),D4                    ; $031C28
        MOVE.L  $2D2D(A4),-(A5)                 ; $031C2C
        MOVE.L  $3031(A7),D7                    ; $031C30
        MOVE.W  $34(A2,D3.W),-(A0)              ; $031C34
        MOVE.W  $37(A6,D3.W),-(A2)              ; $031C38
        MOVE.W  $3A3A3B3C,D4                    ; $031C3C
        MOVE.W  <EA:3E>,-(A6)                   ; $031C42
        MOVE.W  <EA:3F>,D7                      ; $031C44
        NEGX.W D1                               ; $031C46
        CLR.W  D3                               ; $031C48
        DC.W    $4344                           ; $031C4A
        DC.W    $4546                           ; $031C4C
        DC.W    $4747                           ; $031C4E
        PEA     A1                              ; $031C50
        TST.W  A3                               ; $031C52
        DC.W    $4B4C                           ; $031C54
        DC.W    $4D4E                           ; $031C56
        DC.W    $4F50                           ; $031C58
        ADDQ.W  #8,(A1)                         ; $031C5A
        ADDQ.W  #1,(A3)                         ; $031C5C
        ADDQ.W  #2,(A4)                         ; $031C5E
        SUBQ.W  #2,(A6)                         ; $031C60
        SUBQ.W  #3,(A0)+                        ; $031C62
        ADDQ.W  #4,(A1)+                        ; $031C64
        ADDQ.W  #5,(A3)+                        ; $031C66
        ADDQ.W  #6,(A5)+                        ; $031C68
        SUBQ.W  #6,(A6)+                        ; $031C6A
        SUBQ.W  #7,-(A0)                        ; $031C6C
        BSR.S  loc_031CD1                       ; $031C6E
        BHI.S  loc_031CD5                       ; $031C70
        BCC.S  loc_031CD9                       ; $031C72
        BCS.S  loc_031CDC                       ; $031C74
        BEQ.S  loc_031CE0                       ; $031C76
        BVS.S  loc_031CE4                       ; $031C78
        BPL.S  loc_031CE7                       ; $031C7A
        BGE.S  loc_031CEB                       ; $031C7C
        BGT.S  loc_031CEE                       ; $031C7E
        BLE.S  loc_031CF2                       ; $031C80
        MOVE.W  $73(A2,D7.W),$7475(A0)          ; $031C82
        MOVEQ   #$77,D3                         ; $031C88
        MOVE.W  $797A.W,$7B7B(A3)               ; $031C8A
        MOVEQ   #$7D,D6                         ; $031C90
        MOVEQ   #$7F,D7                         ; $031C92
        MOVE.W  D0,-$7F(A7,A0.W)                ; $031C94
        OR.L   D3,D1                            ; $031C98
        OR.L   D4,D2                            ; $031C9A
        OR.L   D2,D6                            ; $031C9C
        OR.L   D3,A0                            ; $031C9E
        OR.L   A1,D4                            ; $031CA0
        OR.L   A3,D5                            ; $031CA2
        OR.L   A5,D6                            ; $031CA4
        OR.L   D6,A6                            ; $031CA6
        OR.L   D7,(A0)                          ; $031CA8
        SUB.L  D0,(A1)                          ; $031CAA
        SUB.L  (A3),D1                          ; $031CAC
        SUB.L  (A5),D2                          ; $031CAE
        SUB.L  D2,(A6)                          ; $031CB0
        SUB.L  D3,(A0)+                         ; $031CB2
        SUB.L  D4,(A2)+                         ; $031CB4
        SUB.L  (A3)+,D5                         ; $031CB6
        SUB.L  (A5)+,D6                         ; $031CB8
        SUB.L  (A6)+,D7                         ; $031CBA
        SUB.L  D7,-(A0)                         ; $031CBC
        MOVE.L  -(A2),-$5D(A0,A2.W)             ; $031CBE
        MOVE.L  -(A5),(A2)                      ; $031CC2
        MOVE.L  -(A7),(A3)                      ; $031CC4
        MOVE.L  -$5656(A0),-$55(A3,A2.L)        ; $031CC6
        MOVE.L  -$5151(A5),(A6)                 ; $031CCC
        MOVE.L  -$4E(A0,A3.W),-$4C(A7,A3.W)     ; $031CD0
        CMP.L  -$49(A5,A3.W),D2                 ; $031CD6
        CMP.L  $B9BA.W,D4                       ; $031CDA
        EOR.L  D5,#$BCBDBEBF                    ; $031CDE
loc_031CE4:
        MULU    D1,D0                           ; $031CE4
        MULS    D2,D0                           ; $031CE6
        MULS    D4,D1                           ; $031CE8
        MULS    D5,D2                           ; $031CEA
        MULU    D7,D3                           ; $031CEC
loc_031CEE:
        MULU    A1,D4                           ; $031CEE
        MULS    A2,D4                           ; $031CF0
loc_031CF2:
        MULS    A4,D5                           ; $031CF2
        MULS    A6,D6                           ; $031CF4
        MULU    A7,D7                           ; $031CF6
        ADDA.W  (A1),A0                         ; $031CF8
        ADDA.W  (A2),A1                         ; $031CFA
        ADDA.L  (A4),A1                         ; $031CFC
        ADDA.L  (A6),A2                         ; $031CFE
        ADDA.W  (A7),A3                         ; $031D00
        ADDA.W  (A1)+,A4                        ; $031D02
        ADDA.W  (A3)+,A5                        ; $031D04
        ADDA.L  (A4)+,A5                        ; $031D06
        ADDA.L  (A6)+,A6                        ; $031D08
        ADDA.L  (A7)+,A7                        ; $031D0A
        ASR.W  -(A1)                            ; $031D0C
        LSR.W  -(A3)                            ; $031D0E
        LSL.W  -(A4)                            ; $031D10
        ROXL.W  -(A6)                           ; $031D12
        ASL.B  D3,D0                            ; $031D14
        MOVE.L  -(A2),-(A0)                     ; $031D16
        MOVE.L  -(A3),D1                        ; $031D18
        MOVE.L  -(A5),D2                        ; $031D1A
        MOVE.L  -(A6),-(A2)                     ; $031D1C
        MOVE.L  $2829(A0),-(A3)                 ; $031D1E
        MOVE.L  $2B2C(A3),D5                    ; $031D22
        MOVE.L  $2E2F(A6),-(A6)                 ; $031D26
        MOVE.W  $32(A1,D3.W),D0                 ; $031D2A
        MOVE.W  $35(A4,D3.W),-(A1)              ; $031D2E
        MOVE.W  $38(A7,D3.W),D3                 ; $031D32
        MOVE.W  $3A3B(PC),-(A4)                 ; $031D36
        MOVE.W  <EA:3D>,D6                      ; $031D3A
        MOVE.W  <EA:3E>,-(A6)                   ; $031D3C
        MOVE.W  D0,$4041(A7)                    ; $031D3E
        CLR.W  D3                               ; $031D42
        DC.W    $4344                           ; $031D44
        DC.W    $4546                           ; $031D46
        NOT.W  D7                               ; $031D48
        PEA     A1                              ; $031D4A
        DC.W    $494A                           ; $031D4C
        DC.W    $4B4C                           ; $031D4E
        DC.W    $4C4D                           ; $031D50
        TRAP    #15                             ; $031D52
        DC.W    $4F50                           ; $031D54
        SUBQ.W  #8,(A2)                         ; $031D56
        ADDQ.W  #1,(A3)                         ; $031D58
        ADDQ.W  #2,(A5)                         ; $031D5A
        SUBQ.W  #2,(A6)                         ; $031D5C
        SUBQ.W  #3,(A0)+                        ; $031D5E
        ADDQ.W  #4,(A1)+                        ; $031D60
        ADDQ.W  #5,(A3)+                        ; $031D62
        SUBQ.W  #5,(A4)+                        ; $031D64
        SUBQ.W  #6,(A6)+                        ; $031D66
        ADDQ.W  #7,(A7)+                        ; $031D68
        BRA.S  loc_031DCD                       ; $031D6A
        BSR.S  loc_031DD0                       ; $031D6C
        BLS.S  loc_031DD4                       ; $031D6E
        BCC.S  loc_031DD7                       ; $031D70
        BNE.S  loc_031DDB                       ; $031D72
        BEQ.S  loc_031DDE                       ; $031D74
        BVS.S  loc_031DE2                       ; $031D76
        BPL.S  loc_031DE5                       ; $031D78
        BGE.S  loc_031DE9                       ; $031D7A
        BLT.S  loc_031DEC                       ; $031D7C
        BLE.S  loc_031DF0                       ; $031D7E
        MOVEQ   #$71,D0                         ; $031D80
        MOVEQ   #$73,D1                         ; $031D82
        MOVE.W  $76(A4,D7.W),$7677(A1)          ; $031D84
        MOVEQ   #$79,D4                         ; $031D8A
        MOVE.W  $7B7C(PC),$7C7D(A4)             ; $031D8C
        MOVEQ   #$7F,D7                         ; $031D92
        MOVE.W  D0,-$7F(A7,A0.W)                ; $031D94
        OR.L   D3,D1                            ; $031D98
        OR.L   D1,D4                            ; $031D9A
        OR.L   D2,D6                            ; $031D9C
        OR.L   D7,D3                            ; $031D9E
        OR.L   A1,D4                            ; $031DA0
        OR.L   D4,A2                            ; $031DA2
        OR.L   D5,A4                            ; $031DA4
        OR.L   A5,D6                            ; $031DA6
        OR.L   A7,D7                            ; $031DA8
        OR.L   D7,(A0)                          ; $031DAA
        SUB.L  D0,(A2)                          ; $031DAC
        SUB.L  (A3),D1                          ; $031DAE
        SUB.L  (A5),D2                          ; $031DB0
        SUB.L  D2,(A6)                          ; $031DB2
        SUB.L  D3,(A0)+                         ; $031DB4
        SUB.L  (A1)+,D4                         ; $031DB6
        SUB.L  (A3)+,D5                         ; $031DB8
        SUB.L  D5,(A4)+                         ; $031DBA
        SUB.L  D6,(A6)+                         ; $031DBC
        SUB.L  (A7)+,D7                         ; $031DBE
        MOVE.L  -(A1),(A0)                      ; $031DC0
        MOVE.L  -(A2),-$5C(A0,A2.W)             ; $031DC2
        MOVE.L  -(A5),(A2)                      ; $031DC6
        MOVE.L  -(A7),(A3)                      ; $031DC8
        MOVE.L  -$5656(A0),-$55(A3,A2.L)        ; $031DCA
loc_031DD0:
        MOVE.L  -$5252(A5),(A6)                 ; $031DD0
loc_031DD4:
        MOVE.L  -$4F(A0,A3.W),-$4D(A7,A3.W)     ; $031DD4
        EOR.L  D1,-$4A(A4,A3.W)                 ; $031DDA
loc_031DDE:
        CMP.L  -$47(A7,A3.L),D3                 ; $031DDE
loc_031DE2:
        EOR.L  D4,-$4444(PC)                    ; $031DE2
        CMP.L  <EA:3D>,D6                       ; $031DE6
        CMP.L  <EA:3F>,D7                       ; $031DE8
        CMPA.L  D0,A7                           ; $031DEA
loc_031DEC:
        MULS    D2,D0                           ; $031DEC
        MULU    D3,D1                           ; $031DEE
loc_031DF0:
        MULU    D5,D2                           ; $031DF0
        MULS    D6,D2                           ; $031DF2
        MULS    A0,D3                           ; $031DF4
        MULU    A1,D4                           ; $031DF6
        MULU    A3,D5                           ; $031DF8
        MULS    A4,D5                           ; $031DFA
        MULS    A6,D6                           ; $031DFC
        MULU    A7,D7                           ; $031DFE
        ADDA.W  (A1),A0                         ; $031E00
        ADDA.L  (A2),A0                         ; $031E02
        ADDA.L  (A4),A1                         ; $031E04
        ADDA.W  (A5),A2                         ; $031E06
        ADDA.W  (A7),A3                         ; $031E08
        ADDA.L  (A0)+,A3                        ; $031E0A
        ADDA.L  (A2)+,A4                        ; $031E0C
        ADDA.W  (A3)+,A5                        ; $031E0E
        ADDA.W  (A5)+,A6                        ; $031E10
        ADDA.L  (A6)+,A6                        ; $031E12
        ADD.B  D7,$292A(A0)                     ; $031E14
        MOVE.L  $2C2C(A3),D5                    ; $031E18
        MOVE.L  $2E2F(A6),-(A6)                 ; $031E1C
        MOVE.W  $32(A0,D3.W),D0                 ; $031E20
        MOVE.W  $35(A3,D3.W),D1                 ; $031E24
        MOVE.W  $37(A6,D3.W),-(A2)              ; $031E28
        MOVE.W  $393A3B3B,D4                    ; $031E2C
        MOVE.W  <EA:3D>,D6                      ; $031E32
        MOVE.W  <EA:3E>,-(A6)                   ; $031E34
        MOVE.W  D0,$4041(A7)                    ; $031E36
        CLR.W  D2                               ; $031E3A
        DC.W    $4344                           ; $031E3C
        NEG.W  D5                               ; $031E3E
        NOT.W  D6                               ; $031E40
        DC.W    $4748                           ; $031E42
        PEA     A1                              ; $031E44
        TST.W  A3                               ; $031E46
        DC.W    $4B4C                           ; $031E48
        DC.W    $4D4D                           ; $031E4A
        TRAP    #15                             ; $031E4C
        DC.W    $4F50                           ; $031E4E
        SUBQ.W  #8,(A1)                         ; $031E50
        ADDQ.W  #1,(A3)                         ; $031E52
        SUBQ.W  #1,(A4)                         ; $031E54
        SUBQ.W  #2,(A6)                         ; $031E56
        ADDQ.W  #3,(A7)                         ; $031E58
        ADDQ.W  #4,(A0)+                        ; $031E5A
        SUBQ.W  #4,(A2)+                        ; $031E5C
        ADDQ.W  #5,(A3)+                        ; $031E5E
        ADDQ.W  #6,(A4)+                        ; $031E60
        SUBQ.W  #6,(A6)+                        ; $031E62
        ADDQ.W  #7,(A7)+                        ; $031E64
        BRA.S  loc_031EC9                       ; $031E66
        BSR.S  loc_031ECC                       ; $031E68
        BLS.S  loc_031ECF                       ; $031E6A
        BCC.S  loc_031ED3                       ; $031E6C
        BCS.S  loc_031ED6                       ; $031E6E
        BEQ.S  loc_031ED9                       ; $031E70
        BVC.S  loc_031EDD                       ; $031E72
        BVS.S  loc_031EE0                       ; $031E74
        BMI.S  loc_031EE4                       ; $031E76
        BGE.S  loc_031EE7                       ; $031E78
        BGT.S  loc_031EEA                       ; $031E7A
        BLE.S  loc_031EEE                       ; $031E7C
        MOVEQ   #$71,D0                         ; $031E7E
        MOVEQ   #$72,D1                         ; $031E80
        MOVE.W  $75(A4,D7.W),$7677(A1)          ; $031E82
        MOVE.W  $7979.W,$7A7B(A3)               ; $031E88
        MOVE.W  #$7D7D,$7E7F(A5)                ; $031E8E
        MOVE.W  D0,-$7F(A7,A0.W)                ; $031E94
        OR.L   D2,D1                            ; $031E98
        OR.L   D1,D4                            ; $031E9A
        OR.L   D5,D2                            ; $031E9C
        OR.L   D6,D3                            ; $031E9E
        OR.L   D3,A0                            ; $031EA0
        OR.L   A1,D4                            ; $031EA2
        OR.L   A3,D5                            ; $031EA4
        OR.L   D5,A4                            ; $031EA6
        OR.L   D6,A5                            ; $031EA8
        OR.L   A7,D7                            ; $031EAA
        OR.L   D7,(A0)                          ; $031EAC
        SUB.L  D0,(A1)                          ; $031EAE
        SUB.L  (A3),D1                          ; $031EB0
        SUB.L  D1,(A4)                          ; $031EB2
        SUB.L  D2,(A6)                          ; $031EB4
        SUB.L  (A7),D3                          ; $031EB6
        SUB.L  (A0)+,D4                         ; $031EB8
        SUB.L  D4,(A2)+                         ; $031EBA
        SUB.L  (A3)+,D5                         ; $031EBC
        SUB.L  (A4)+,D6                         ; $031EBE
        SUB.L  D6,(A6)+                         ; $031EC0
        SUB.L  (A7)+,D7                         ; $031EC2
        MOVE.L  -(A1),(A0)                      ; $031EC4
        MOVE.L  -(A2),-$5D(A0,A2.W)             ; $031EC6
        MOVE.L  -(A5),(A2)                      ; $031ECA
loc_031ECC:
        MOVE.L  -(A6),-$59(A2,A2.W)             ; $031ECC
        MOVE.L  -$5656(A1),(A4)                 ; $031ED0
        MOVE.L  -$5353(A4),-$52(A5,A2.L)        ; $031ED4
        MOVE.L  -$4F(A0,A3.W),-$4E(A7,A3.W)     ; $031EDA
loc_031EE0:
        EOR.L  D1,-$4B(A4,A3.W)                 ; $031EE0
loc_031EE4:
        CMP.L  -$48(A7,A3.W),D3                 ; $031EE4
        EOR.L  D4,$BABBBBBC                     ; $031EE8
loc_031EEE:
        EOR.L  D6,<EA:3D>                       ; $031EEE
        CMP.L  <EA:3F>,D7                       ; $031EF0
        CMPA.L  D0,A7                           ; $031EF2
        MULS    D2,D0                           ; $031EF4
        MULU    D3,D1                           ; $031EF6
        MULU    D4,D2                           ; $031EF8
        MULS    D6,D2                           ; $031EFA
        MULU    D7,D3                           ; $031EFC
        MULU    A0,D4                           ; $031EFE
        MULS    A2,D4                           ; $031F00
        MULU    A3,D5                           ; $031F02
        MULU    A5,D6                           ; $031F04
        MULS    A6,D6                           ; $031F06
        MULS    A7,D7                           ; $031F08
        ADDA.W  (A1),A0                         ; $031F0A
        ADDA.L  (A2),A0                         ; $031F0C
        ADDA.L  (A3),A1                         ; $031F0E
        ADDA.W  (A5),A2                         ; $031F10
        ADDA.L  (A6),A2                         ; $031F12
        ADD.B  D3,$31(A0,D3.W)                  ; $031F14
        MOVE.W  $34(A3,D3.W),D1                 ; $031F18
        MOVE.W  $36(A5,D3.W),D2                 ; $031F1C
        MOVE.W  $3839.W,-(A3)                   ; $031F20
        MOVE.W  $3B3B(PC),-(A4)                 ; $031F24
        MOVE.W  <EA:3D>,D6                      ; $031F28
        MOVE.W  <EA:3E>,-(A6)                   ; $031F2A
        MOVE.W  <EA:3F>,D7                      ; $031F2C
        NEGX.W D0                               ; $031F2E
        DC.W    $4142                           ; $031F30
        CLR.W  D3                               ; $031F32
        DC.W    $4344                           ; $031F34
        DC.W    $4545                           ; $031F36
        NOT.W  D7                               ; $031F38
        DC.W    $4748                           ; $031F3A
        PEA     A1                              ; $031F3C
        TST.W  A2                               ; $031F3E
        DC.W    $4B4C                           ; $031F40
        DC.W    $4C4D                           ; $031F42
        DC.W    $4D4E                           ; $031F44
        DC.W    $4F4F                           ; $031F46
        ADDQ.W  #8,(A1)                         ; $031F48
        SUBQ.W  #8,(A2)                         ; $031F4A
        ADDQ.W  #1,(A3)                         ; $031F4C
        ADDQ.W  #2,(A4)                         ; $031F4E
        SUBQ.W  #2,(A6)                         ; $031F50
        ADDQ.W  #3,(A7)                         ; $031F52
        SUBQ.W  #3,(A0)+                        ; $031F54
        SUBQ.W  #4,(A1)+                        ; $031F56
        ADDQ.W  #5,(A3)+                        ; $031F58
        SUBQ.W  #5,(A4)+                        ; $031F5A
        ADDQ.W  #6,(A5)+                        ; $031F5C
        ADDQ.W  #7,(A6)+                        ; $031F5E
        SUBQ.W  #7,-(A0)                        ; $031F60
        BRA.S  loc_031FC5                       ; $031F62
        BSR.S  loc_031FC8                       ; $031F64
        BLS.S  loc_031FCB                       ; $031F66
        BCC.S  loc_031FCF                       ; $031F68
        BCS.S  loc_031FD2                       ; $031F6A
        BNE.S  loc_031FD5                       ; $031F6C
        BVC.S  loc_031FD8                       ; $031F6E
        BVS.S  loc_031FDC                       ; $031F70
        BPL.S  loc_031FDF                       ; $031F72
        BMI.S  loc_031FE2                       ; $031F74
        BLT.S  loc_031FE5                       ; $031F76
        BGT.S  loc_031FE9                       ; $031F78
        BLE.S  loc_031FEC                       ; $031F7A
        MOVEQ   #$71,D0                         ; $031F7C
        MOVEQ   #$72,D1                         ; $031F7E
        MOVE.W  $75(A4,D7.W),$7576(A1)          ; $031F80
        MOVE.W  $79(A7,D7.L),$797A(A3)          ; $031F86
        MOVEQ   #$7B,D5                         ; $031F8C
        MOVEQ   #$7C,D6                         ; $031F8E
        MOVE.W  <EA:3E>,$7E7F(A6)               ; $031F90
        MOVE.W  D0,-$7F(A7,A0.W)                ; $031F94
        OR.L   D0,D2                            ; $031F98
        OR.L   D1,D3                            ; $031F9A
        OR.L   D5,D2                            ; $031F9C
        OR.L   D2,D6                            ; $031F9E
        OR.L   D7,D3                            ; $031FA0
        OR.L   A0,D4                            ; $031FA2
        OR.L   D4,A2                            ; $031FA4
        OR.L   A3,D5                            ; $031FA6
        OR.L   D5,A4                            ; $031FA8
        OR.L   D6,A5                            ; $031FAA
        OR.L   A7,D7                            ; $031FAC
        OR.L   D7,(A0)                          ; $031FAE
        SUB.L  (A1),D0                          ; $031FB0
        SUB.L  (A2),D1                          ; $031FB2
        SUB.L  D1,(A4)                          ; $031FB4
        SUB.L  (A5),D2                          ; $031FB6
        SUB.L  D2,(A6)                          ; $031FB8
        SUB.L  D3,(A7)                          ; $031FBA
        SUB.L  (A1)+,D4                         ; $031FBC
        SUB.L  D4,(A2)+                         ; $031FBE
        SUB.L  (A3)+,D5                         ; $031FC0
        SUB.L  (A4)+,D6                         ; $031FC2
        SUB.L  D6,(A6)+                         ; $031FC4
        SUB.L  (A7)+,D7                         ; $031FC6
loc_031FC8:
        SUB.L  D7,-(A0)                         ; $031FC8
        MOVE.L  -(A1),-$5D(A0,A2.W)             ; $031FCA
        MOVE.L  -(A4),-$5B(A1,A2.W)             ; $031FCE
loc_031FD2:
        MOVE.L  -(A6),(A3)                      ; $031FD2
        MOVE.L  -$5757(A0),-$56(A3,A2.L)        ; $031FD4
        MOVE.L  -$5353(A3),-$52(A5,A2.L)        ; $031FDA
        MOVE.L  -$4F50(A7),(A7)                 ; $031FE0
        EOR.L  D0,-$4D(A2,A3.W)                 ; $031FE4
        EOR.L  D1,-$4B(A4,A3.W)                 ; $031FE8
loc_031FEC:
        CMP.L  -$48(A7,A3.W),D3                 ; $031FEC
        CMP.L  $BABABBBC,D4                     ; $031FF0
        CMP.L  <EA:3D>,D6                       ; $031FF6
        EOR.L  D6,<EA:3E>                       ; $031FF8
        EOR.L  D7,<EA:3F>                       ; $031FFA
        MULU    D1,D0                           ; $031FFC
        MULS    D2,D0                           ; $031FFE
        MULU    D3,D1                           ; $032000
        MULU    D4,D2                           ; $032002
        MULS    D6,D2                           ; $032004
        MULU    D7,D3                           ; $032006
        MULS    A0,D3                           ; $032008
        MULS    A1,D4                           ; $03200A
        MULU    A3,D5                           ; $03200C
        MULS    A4,D5                           ; $03200E
        MULU    A5,D6                           ; $032010
        MULU    A6,D7                           ; $032012
        AND.B  D7,$3939.W                       ; $032014
        MOVE.W  $3B3B(PC),D5                    ; $032018
        MOVE.W  <EA:3D>,D6                      ; $03201C
        MOVE.W  <EA:3E>,-(A6)                   ; $03201E
        MOVE.W  <EA:3F>,D7                      ; $032020
        MOVE.W  D0,$4041(A7)                    ; $032022
        CLR.W  D2                               ; $032026
        DC.W    $4343                           ; $032028
        NEG.W  D4                               ; $03202A
        DC.W    $4546                           ; $03202C
        NOT.W  D7                               ; $03202E
        DC.W    $4748                           ; $032030
        PEA     A1                              ; $032032
        DC.W    $494A                           ; $032034
        DC.W    $4B4B                           ; $032036
        DC.W    $4C4C                           ; $032038
        DC.W    $4D4D                           ; $03203A
        TRAP    #15                             ; $03203C
        DC.W    $4F50                           ; $03203E
        ADDQ.W  #8,(A1)                         ; $032040
        SUBQ.W  #8,(A2)                         ; $032042
        ADDQ.W  #1,(A3)                         ; $032044
        ADDQ.W  #2,(A4)                         ; $032046
        SUBQ.W  #2,(A5)                         ; $032048
        ADDQ.W  #3,(A6)                         ; $03204A
        SUBQ.W  #3,(A0)+                        ; $03204C
        ADDQ.W  #4,(A1)+                        ; $03204E
        SUBQ.W  #4,(A2)+                        ; $032050
        ADDQ.W  #5,(A3)+                        ; $032052
        SUBQ.W  #5,(A4)+                        ; $032054
        SUBQ.W  #6,(A5)+                        ; $032056
        ADDQ.W  #7,(A6)+                        ; $032058
        SUBQ.W  #7,(A7)+                        ; $03205A
        BRA.S  loc_0320BF                       ; $03205C
        BSR.S  loc_0320C2                       ; $03205E
        BHI.S  loc_0320C5                       ; $032060
        BLS.S  loc_0320C8                       ; $032062
        BCC.S  loc_0320CB                       ; $032064
        BNE.S  loc_0320CE                       ; $032066
        BEQ.S  loc_0320D1                       ; $032068
        BVC.S  loc_0320D4                       ; $03206A
        BVS.S  loc_0320D8                       ; $03206C
        BPL.S  loc_0320DB                       ; $03206E
        BMI.S  loc_0320DE                       ; $032070
        BGE.S  loc_0320E1                       ; $032072
        BLT.S  loc_0320E4                       ; $032074
        BLE.S  loc_0320E7                       ; $032076
        MOVEQ   #$70,D0                         ; $032078
        MOVE.W  $73(A1,D7.W),$7374(A0)          ; $03207A
        MOVEQ   #$75,D2                         ; $032080
        MOVE.W  $77(A6,D7.W),$7878(A2)          ; $032082
        MOVE.W  $7A7A7B7C,$7C7D(A4)             ; $032088
        MOVE.W  <EA:3E>,$7E7F(A6)               ; $032090
        MOVE.W  D0,-$7F(A7,A0.W)                ; $032094
        OR.L   D0,D2                            ; $032098
        OR.L   D3,D1                            ; $03209A
        OR.L   D1,D4                            ; $03209C
        OR.L   D2,D5                            ; $03209E
        OR.L   D6,D3                            ; $0320A0
        OR.L   D3,D7                            ; $0320A2
        OR.L   A1,D4                            ; $0320A4
        OR.L   D4,A2                            ; $0320A6
        OR.L   A3,D5                            ; $0320A8
        OR.L   D5,A4                            ; $0320AA
        OR.L   A5,D6                            ; $0320AC
        OR.L   A6,D7                            ; $0320AE
        OR.L   D7,A7                            ; $0320B0
        SUB.L  (A0),D0                          ; $0320B2
        SUB.L  D0,(A2)                          ; $0320B4
        SUB.L  (A3),D1                          ; $0320B6
        SUB.L  D1,(A4)                          ; $0320B8
        SUB.L  (A5),D2                          ; $0320BA
        SUB.L  D2,(A6)                          ; $0320BC
        SUB.L  D3,(A7)                          ; $0320BE
        SUB.L  (A0)+,D4                         ; $0320C0
loc_0320C2:
        SUB.L  D4,(A1)+                         ; $0320C2
        SUB.L  (A3)+,D5                         ; $0320C4
        SUB.L  D5,(A4)+                         ; $0320C6
loc_0320C8:
        SUB.L  (A5)+,D6                         ; $0320C8
        SUB.L  D6,(A6)+                         ; $0320CA
        SUB.L  (A7)+,D7                         ; $0320CC
loc_0320CE:
        MOVE.L  -(A0),(A0)                      ; $0320CE
        MOVE.L  -(A1),-$5E(A0,A2.W)             ; $0320D0
loc_0320D4:
        MOVE.L  -(A4),-$5B(A1,A2.W)             ; $0320D4
loc_0320D8:
        MOVE.L  -(A6),-$59(A2,A2.W)             ; $0320D8
        MOVE.L  -$5657(A0),-$56(A3,A2.L)        ; $0320DC
        MOVE.L  -$5353(A3),-$52(A5,A2.L)        ; $0320E2
        MOVE.L  -$5050(A7),(A7)                 ; $0320E8
        CMP.L  -$4E(A1,A3.W),D0                 ; $0320EC
        EOR.L  D1,-$4C(A3,A3.W)                 ; $0320F0
        EOR.L  D2,-$49(A6,A3.W)                 ; $0320F4
        EOR.L  D3,$B8B9.W                       ; $0320F8
        EOR.L  D4,-$4445(PC)                    ; $0320FC
        CMP.L  #$BDBDBEBF,D6                    ; $032100
        CMPA.L  D0,A7                           ; $032106
        MULU    D1,D0                           ; $032108
        MULS    D2,D0                           ; $03210A
        MULU    D3,D1                           ; $03210C
        MULU    D4,D2                           ; $03210E
        MULS    D5,D2                           ; $032110
        MULU    D6,D3                           ; $032112
        AND.W  D3,D0                            ; $032114
        NEGX.W D1                               ; $032116
        DC.W    $4142                           ; $032118
        CLR.W  D3                               ; $03211A
        DC.W    $4344                           ; $03211C
        NEG.W  D5                               ; $03211E
        DC.W    $4546                           ; $032120
        NOT.W  D7                               ; $032122
        DC.W    $4748                           ; $032124
        PEA     A1                              ; $032126
        DC.W    $494A                           ; $032128
        TST.W  A3                               ; $03212A
        DC.W    $4B4C                           ; $03212C
        DC.W    $4C4D                           ; $03212E
        DC.W    $4D4E                           ; $032130
        TRAP    #15                             ; $032132
        DC.W    $4F50                           ; $032134
        ADDQ.W  #8,(A1)                         ; $032136
        SUBQ.W  #8,(A2)                         ; $032138
        ADDQ.W  #1,(A3)                         ; $03213A
        SUBQ.W  #1,(A4)                         ; $03213C
        ADDQ.W  #2,(A5)                         ; $03213E
        SUBQ.W  #2,(A6)                         ; $032140
        ADDQ.W  #3,(A7)                         ; $032142
        SUBQ.W  #3,(A0)+                        ; $032144
        ADDQ.W  #4,(A1)+                        ; $032146
        SUBQ.W  #4,(A2)+                        ; $032148
        ADDQ.W  #5,(A3)+                        ; $03214A
        SUBQ.W  #5,(A4)+                        ; $03214C
        ADDQ.W  #6,(A5)+                        ; $03214E
        SUBQ.W  #6,(A6)+                        ; $032150
        ADDQ.W  #7,(A7)+                        ; $032152
        SUBQ.W  #7,-(A0)                        ; $032154
        BRA.S  loc_0321B9                       ; $032156
        BSR.S  loc_0321BC                       ; $032158
        BHI.S  loc_0321BF                       ; $03215A
        BLS.S  loc_0321C2                       ; $03215C
        BCC.S  loc_0321C5                       ; $03215E
        BCS.S  loc_0321C8                       ; $032160
        BNE.S  loc_0321CB                       ; $032162
        BEQ.S  loc_0321CE                       ; $032164
        BVC.S  loc_0321D1                       ; $032166
        BVS.S  loc_0321D4                       ; $032168
        BPL.S  loc_0321D7                       ; $03216A
        BMI.S  loc_0321DA                       ; $03216C
        BGE.S  loc_0321DD                       ; $03216E
        BLT.S  loc_0321E0                       ; $032170
        BGT.S  loc_0321E3                       ; $032172
        BLE.S  loc_0321E6                       ; $032174
        MOVEQ   #$71,D0                         ; $032176
        MOVE.W  $73(A2,D7.W),$7374(A0)          ; $032178
        MOVEQ   #$75,D2                         ; $03217E
        MOVE.W  $77(A6,D7.W),$7778(A2)          ; $032180
        MOVEQ   #$79,D4                         ; $032186
        MOVE.W  $7A7B(PC),$7B7C(A4)             ; $032188
        MOVEQ   #$7D,D6                         ; $03218E
        MOVE.W  <EA:3E>,$7E7F(A6)               ; $032190
        MOVE.W  D0,-$7F(A7,A0.W)                ; $032194
        OR.L   D0,D2                            ; $032198
        OR.L   D3,D1                            ; $03219A
        OR.L   D1,D4                            ; $03219C
        OR.L   D5,D2                            ; $03219E
        OR.L   D2,D6                            ; $0321A0
        OR.L   D7,D3                            ; $0321A2
        OR.L   D3,A0                            ; $0321A4
        OR.L   A1,D4                            ; $0321A6
        OR.L   D4,A2                            ; $0321A8
        OR.L   A3,D5                            ; $0321AA
        OR.L   D5,A4                            ; $0321AC
        OR.L   A5,D6                            ; $0321AE
        OR.L   D6,A6                            ; $0321B0
        OR.L   A7,D7                            ; $0321B2
        OR.L   D7,(A0)                          ; $0321B4
        SUB.L  (A1),D0                          ; $0321B6
        SUB.L  D0,(A2)                          ; $0321B8
        SUB.L  (A3),D1                          ; $0321BA
loc_0321BC:
        SUB.L  D1,(A4)                          ; $0321BC
        SUB.L  (A5),D2                          ; $0321BE
        SUB.L  D2,(A6)                          ; $0321C0
loc_0321C2:
        SUB.L  (A7),D3                          ; $0321C2
        SUB.L  D3,(A0)+                         ; $0321C4
        SUB.L  (A1)+,D4                         ; $0321C6
loc_0321C8:
        SUB.L  D4,(A2)+                         ; $0321C8
        SUB.L  (A3)+,D5                         ; $0321CA
        SUB.L  D5,(A4)+                         ; $0321CC
loc_0321CE:
        SUB.L  (A5)+,D6                         ; $0321CE
        SUB.L  D6,(A6)+                         ; $0321D0
        SUB.L  (A7)+,D7                         ; $0321D2
loc_0321D4:
        SUB.L  D7,-(A0)                         ; $0321D4
        MOVE.L  -(A1),(A0)                      ; $0321D6
        MOVE.L  -(A2),-$5D(A0,A2.W)             ; $0321D8
        MOVE.L  -(A4),-$5B(A1,A2.W)             ; $0321DC
loc_0321E0:
        MOVE.L  -(A6),-$59(A2,A2.W)             ; $0321E0
        MOVE.L  -$5757(A0),-$56(A3,A2.L)        ; $0321E4
        MOVE.L  -$5454(A3),(A5)                 ; $0321EA
        MOVE.L  -$5252(A5),(A6)                 ; $0321EE
        MOVE.L  -$5050(A7),(A7)                 ; $0321F2
        CMP.L  -$4E(A1,A3.W),D0                 ; $0321F6
        CMP.L  -$4C(A3,A3.W),D1                 ; $0321FA
        CMP.L  -$4A(A5,A3.W),D2                 ; $0321FE
