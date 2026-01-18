; Generated assembly for $108200-$10A200
; Branch targets: 109
; Labels: 107
; Format: DC.W with decoded mnemonics as comments

        org     $108200

        ADD.L  D7,(A1)+                         ; $108200
        MOVE.W  D6,D6                           ; $108202
        MOVE.W  $22(A0,A0.L),-(A0)              ; $108204
        ADD.W  (A5),D0                          ; $108208
        MOVE.W  -$5AAB(A0),(A1)+                ; $10820A
        DC.W    $3BFC,$E2A5         ; $10820E MOVE.W  #$E2A5,<EA:3D>
        MOVE.W  A7,-$61(A7,A5.W)                ; $108212
        MOVE.W  A0,-(A6)                        ; $108216
        DC.W    $99FD               ; $108218 SUBA.L  <EA:3D>,A4
        MOVE.W  (A1)+,$50(A4,A1.L)              ; $10821A
        DC.W    $B5FF               ; $10821E CMPA.L  <EA:3F>,A2
        MOVE.W  -(A3),D6                        ; $108220
        ADDA.W  (A2)+,A4                        ; $108222
        DC.W    $FFD2               ; $108224 MOVE.W  (A2),<EA:3F>
        CMPA.W  (A5),A0                         ; $108226
        LEA     A1,A0                           ; $108228
        MOVE.W  D1,-(A2)                        ; $10822A
        DC.W    $00E5               ; $10822C DC.W    $00E5
        EOR.W  D4,(A5)                          ; $10822E
        ADD.L  D6,D4                            ; $108230
        ROXR.W  #8,D4                           ; $108232
        DC.W    $94FF               ; $108234 SUBA.W  <EA:3F>,A2
        MOVE.W  $50C2(A1),(A2)                  ; $108236
        ASR.W  -$079E(A5)                       ; $10823A
        AND.B  (A7),D2                          ; $10823E
        SUBQ.W  #2,-$04AB(A1)                   ; $108240
loc_108244:
        MULS    -$2FA0(A1),D0                   ; $108244
        ROXR.W  #6,D0                           ; $108248
        MULU    (A0)+,D2                        ; $10824A
        ROXR.W  #6,D5                           ; $10824C
        AND.B  D6,-(A0)                         ; $10824E
        AND.B  A1,D0                            ; $108250
        MOVE.B  -$2B(A5,A6.W),$20DA.W           ; $108252
        DC.W    $0EC5               ; $108258 DC.W    $0EC5
        DC.W    $FFFC,$4A82         ; $10825A MOVE.W  #$4A82,<EA:3F>
        BSET    D7,-(A3)                        ; $10825E
        MOVE.B  -$20(A6,A6.W),(A4)+             ; $108260
        MOVE.L  (A2)+,$5A44(A4)                 ; $108264
        EOR.L  D2,D3                            ; $108268
        MOVE.L  $5B(A0,D4.L),D5                 ; $10826A
        DC.W    $0238,$F2AF,$EA1C   ; $10826E ANDI.B  #$F2AF,$EA1C.W
        ASL.B  D5,D5                            ; $108274
        ASL.W  D0,D1                            ; $108276
        DC.W    $478A               ; $108278 DC.W    $478A
        ADD.B  D0,$36(A6,D3.W)                  ; $10827A
loc_10827E:
        BNE.S  loc_10827E                       ; $10827E
        ADD.L  $30(PC,A3.L),D5                  ; $108280
        ADDQ.W  #2,(A4)                         ; $108284
        EORI.W  #$ACB8,(A5)                     ; $108286
        MOVE.L  (A0)+,$28DA(A4)                 ; $10828A
        MOVE.W  -$5E(A1,A4.W),(A0)+             ; $10828E
        ROL.W  $5B1B(A0)                        ; $108292
        DC.W    $F2FF               ; $108296 MOVE.W  <EA:3F>,(A1)+
        LSR.B  #5,D0                            ; $108298
        MOVE.W  (A3)+,(A4)+                     ; $10829A
        MOVE.W  (A1)+,(A0)+                     ; $10829C
        DIVU    (A4),D1                         ; $10829E
        MOVE.L  $44AA(A3),(A4)+                 ; $1082A0
loc_1082A4:
        MOVE.W  D0,(A6)                         ; $1082A4
        SUB.L  D2,-(A3)                         ; $1082A6
        MOVE.W  D0,(A6)+                        ; $1082A8
        MOVEA.L (A0),A2                         ; $1082AA
        CMP.L  $04(A0,A5.L),D3                  ; $1082AC
        OR.B   D3,-$3F(A0,A1.L)                 ; $1082B0
        ADD.B  A0,D0                            ; $1082B4
        ROXL.W  #5,D5                           ; $1082B6
        MOVE.L  (A2),(A5)                       ; $1082B8
        MOVE.W  D0,D5                           ; $1082BA
loc_1082BC:
        MOVE.W  -$2E65(A0),(A3)                 ; $1082BC
        ASL.W  D4,D3                            ; $1082C0
        BLS.S  loc_108244                       ; $1082C2
        MOVE.W  -$5588(A2),-$16(A2,D3.L)        ; $1082C4
        MULS    $10EA(A1),D7                    ; $1082CA
        BLE.S  loc_1082A4                       ; $1082CE
        BEQ.S  loc_1082BC                       ; $1082D0
        MOVE.W  #$2489,-$1D(A0,A1.L)            ; $1082D2
        MOVE.W  $10(A0,A6.L),-(A3)              ; $1082D8
        BCS.S  loc_1082C1                       ; $1082DC
        MOVE.L  -$0416(A2),(A4)                 ; $1082DE
        NEGX.L -$0B46(PC)                       ; $1082E2
        MOVE.L  D3,(A4)+                        ; $1082E6
        DC.W    $E0FE               ; $1082E8 ASR.W  <EA:3E>
        MOVE.B  A2,(A4)+                        ; $1082EA
        MOVE.L  D2,D4                           ; $1082EC
        MOVE.W  -$5338(A5),(A2)                 ; $1082EE
        CMPA.L  -(A3),A5                        ; $1082F2
        ROXR.W  -(A0)                           ; $1082F4
        DC.W    $E3FF               ; $1082F6 LSL.W  <EA:3F>
        CMPI.W  #$E681,-(A3)                    ; $1082F8
        DIVS    -(A7),D0                        ; $1082FC
        MOVE.W  (A0)+,D4                        ; $1082FE
        ADD.L  D1,D7                            ; $108300
        ADDQ.L  #2,-$1F06(A3)                   ; $108302
        MOVE.L  -$1947(PC),D1                   ; $108306
        CMP.W  (A5),D1                          ; $10830A
        AND.W  #$009C,D4                        ; $10830C
        DC.W    $4994               ; $108310 DC.W    $4994
        BRA.S  loc_1082AE                       ; $108312
        DC.W    $33FC,$20BE,$B1E0,$F80F; $108314 MOVE.W  #$20BE,$B1E0F80F
        BRA.S  loc_10836F                       ; $10831C
        DC.W    $FFEA,$5787         ; $10831E MOVE.W  $5787(A2),<EA:3F>
        ROXR.W  (A3)+                           ; $108322
        EOR.L  D2,(A0)                          ; $108324
        ADD.B  (A5),D5                          ; $108326
        CMP.L  -$658D(A1),D7                    ; $108328
        OR.W   -$01(PC,A5.L),D2                 ; $10832C
        SLS     -$131B(A4)                      ; $108330
        MOVE.W  D3,$1C7A(A5)                    ; $108334
        MOVE.L  -$42(PC,A6.L),-$1F(A4,A3.L)     ; $108338
        MOVE.W  D7,-$2CF2(PC)                   ; $10833E
        ADDA.L  D5,A1                           ; $108342
        OR.B   D2,-$5520(PC)                    ; $108344
        ASL.L  D0,D5                            ; $108348
        SUBQ.W  #2,(A0)                         ; $10834A
        NEGX   -$105B(PC)                       ; $10834C
        MOVEQ   #-$1F,D6                        ; $108350
        MOVE.W  $5594(A4),(A6)+                 ; $108352
        MOVE.W  -$23(A1,A0.W),-$5D(PC,D5.L)     ; $108356
        MOVE.L  (A2),$5F(PC,A5.W)               ; $10835C
        ROXL.L  D0,D4                           ; $108360
        MOVE.W  D0,(A0)                         ; $108362
        DC.W    $7DD1               ; $108364 MOVE.W  (A1),<EA:3E>
        DIVU    -$79(A1,D3.W),D5                ; $108366
        MOVE.W  A7,$5BDD(A0)                    ; $10836A
        MOVE.W  -$3843(A0),(A6)+                ; $10836E
        ADD.W  D6,(A2)+                         ; $108372
        MOVE.L  -$421C(A3),(A5)                 ; $108374
        MOVEM.L $7A5A(A1),D1/D3/D5/D7/A2/A4/A6  ; $108378
        LEA     -$25(A2,A3.L),A3                ; $10837E
        BGE.S  loc_108376                       ; $108382
        SUBA.W  -$0F(A1,D0.L),A2                ; $108384
        CMPA.W  -(A1),A2                        ; $108388
        EOR.L  D6,$6B(PC,A5.L)                  ; $10838A
        OR.L   D1,-(A1)                         ; $10838E
        ASL.W  (A3)+                            ; $108390
        SUB.L  D2,-$1F(A1,D5.W)                 ; $108392
        ADDA.L  (A5)+,A5                        ; $108396
        LSL.L  D4,D2                            ; $108398
        MOVEA.W D1,A7                           ; $10839A
        MULU    (A3),D2                         ; $10839C
        AND.L  D1,$1D(PC,A4.W)                  ; $10839E
        LSR.W  #$E048                           ; $1083A2
        DC.W    $DDBD               ; $1083A6 ADD.L  D6,<EA:3D>
        MOVE.W  #$AAE8,(A2)+                    ; $1083A8
        MOVE.L  -$5C15(A2),$0B(A4,A1.L)         ; $1083AC
        MOVE.L  $3444(A2),(A5)                  ; $1083B2
        MOVE.W  -(A2),(A5)+                     ; $1083B6
        ADD.W  -$1EF0(A4),D4                    ; $1083B8
        MOVE.L  D5,$B11F.W                      ; $1083BC
        DC.W    $06FC               ; $1083C0 DC.W    $06FC
        SUBQ.W  #2,(A3)+                        ; $1083C2
        CMP.L  -(A0),D2                         ; $1083C4
        DC.W    $4BBB               ; $1083C6 DC.W    $4BBB
        DC.W    $FBF5,$1D5C         ; $1083C8 MOVE.W  $5C(A5,D1.L),<EA:3D>
        ROL.B  #1,D7                            ; $1083CC
        MOVE.L  -$1661(A4),-(A0)                ; $1083CE
        DC.W    $FFF9,$9F24,$E999   ; $1083D2 MOVE.W  $9F24E999,<EA:3F>
        MOVE.W  A2,-(A4)                        ; $1083D8
        DC.W    $00FB               ; $1083DA DC.W    $00FB
        SUB.W  D4,-$21(A7,A6.L)                 ; $1083DC
        ADD.B  D5,-$1F1F(A6)                    ; $1083E0
        ROR.W  -(A2)                            ; $1083E4
        SUBA.L  (A5)+,A7                        ; $1083E6
        ROR.W  -(A1)                            ; $1083E8
        DC.W    $E0FF               ; $1083EA ASR.W  <EA:3F>
        SUB.B  D7,A3                            ; $1083EC
        MOVE.L  (A7)+,(A5)                      ; $1083EE
        DC.W    $F9F9,$36EE,$E0A9,$EADF; $1083F0 MOVE.W  $36EEE0A9,#$EADF
        MOVE.L  A3,#$E90080C5                   ; $1083F8
        ADD.L  D4,$BBC39255                     ; $1083FE
        MOVEA.W A0,A6                           ; $108404
        ADD.B  A3,D4                            ; $108406
        MOVE.W  D5,(A0)+                        ; $108408
        ROXL.W  #8,D5                           ; $10840A
        BCS.S  loc_1083F7                       ; $10840C
        ADDQ.L  #4,-$16(A1,D6.W)                ; $10840E
        ADD.L  D2,$12C1(A2)                     ; $108412
        ROR.L  D0,D6                            ; $108416
        MOVE.W  $1684.W,(A4)+                   ; $108418
        ADD.B  D4,-$45(PC,D1.W)                 ; $10841C
        OR.L   D1,$17D9(A1)                     ; $108420
        MOVE.L  A0,D4                           ; $108424
        LEA     -$45FC(A1),A1                   ; $108426
        DC.W    $E9FD               ; $10842A ASL.W  <EA:3D>
        MOVE.W  (A2)+,(A6)+                     ; $10842C
        BVC.S  loc_10844C                       ; $10842E
        BGT.S  loc_108467                       ; $108430
        MOVE.W  -(A3),(A4)+                     ; $108432
        DC.W    $3BFC,$35BD         ; $108434 MOVE.W  #$35BD,<EA:3D>
        BSR.S  loc_10847A                       ; $108438
        MOVE.W  -$6043(A5),D2                   ; $10843A
        ADDQ.L  #4,D6                           ; $10843E
        MOVEA.L -(A4),A2                        ; $108440
        DC.W    $FD3F               ; $108442 MOVE.W  <EA:3F>,-(A6)
        MOVE.W  #$1004,-$12D0(PC)               ; $108444
        ASL.W  -$1E(A1,D2.L)                    ; $10844A
        MOVE.W  D2,(A2)+                        ; $10844E
        MOVE.B  #$F49D,(A1)+                    ; $108450
        MOVE.B  (A3)+,(A4)+                     ; $108454
        ADD.W  D3,D3                            ; $108456
        DC.W    $00FC               ; $108458 DC.W    $00FC
        DC.W    $E5FF               ; $10845A ROXL.W  <EA:3F>
        MULU    (A4),D1                         ; $10845C
        BHI.S  loc_10846F                       ; $10845E
        DC.W    $F6FF               ; $108460 MOVE.W  <EA:3F>,(A3)+
        ADDA.L  -(A3),A7                        ; $108462
        DC.W    $DBBD               ; $108464 ADD.L  D5,<EA:3D>
        EOR.B  D6,D0                            ; $108466
        OR.B   -$0D(A2,A7.L),D0                 ; $108468
        OR.B   D0,D6                            ; $10846C
        MOVE.B  -$030D(A7),$DBFC.W              ; $10846E
        SUBQ.W  #2,D0                           ; $108474
        MOVE.W  -$0F(A2,A5.L),(A2)              ; $108476
loc_10847A:
        SUB.L  D1,A5                            ; $10847A
        MOVE.W  -(A4),$D750.W                   ; $10847C
        LEA     #$C4D30ADA,A4                   ; $108480
        DC.W    $1FDA               ; $108486 MOVE.B  (A2)+,<EA:3F>
        ROR.W  D2,D4                            ; $108488
        MOVEA.W (A1)+,A1                        ; $10848A
        MOVEA.L -$04(A1,A7.W),A1                ; $10848C
        ROXR.W  #$AFFC                          ; $108490
        SUBQ.B  #8,(A1)                         ; $108494
        NEGX   $6A(A1,A7.L)                     ; $108496
        ADD.B  D5,A0                            ; $10849A
        ADDA.W  #$255D,A5                       ; $10849C
        ADDA.W  -$04(A3,A3.L),A2                ; $1084A0
        DC.W    $00D9               ; $1084A4 DC.W    $00D9
        ADDA.L  (A3),A0                         ; $1084A6
        CMP.L  $38DB(PC),D5                     ; $1084A8
        SUBQ.B  #2,(A1)                         ; $1084AC
        MOVE.B  (A2)+,$06DE.W                   ; $1084AE
        MOVE.B  -$2E(A1,A4.L),-$0E(PC,D0.L)     ; $1084B2
        MOVEA.W -$7411(A4),A4                   ; $1084B8
        MOVE.W  (A4)+,(A4)+                     ; $1084BC
        MOVE.W  -$2607(A1),-(A4)                ; $1084BE
        MOVE.L  (A1)+,#$9929D180                ; $1084C2
        ANDI.W  #$FC9B,(A1)+                    ; $1084C8
        MOVE.B  (A1)+,(A6)+                     ; $1084CC
        MOVE.W  (A3),$14(A7,A0.L)               ; $1084CE
        CMPI.B  #$FFFF,D4                       ; $1084D2
        MOVE.W  -(A5),(A2)+                     ; $1084D6
        MOVEA.W (A2),A1                         ; $1084D8
        BCS.S  loc_1084F9                       ; $1084DA
        MOVE.W  -$61(A2,A7.L),#$13F1            ; $1084DC
        ROXL.W  $60(A3,A7.L)                    ; $1084E2
        NEGX   -(A2)                            ; $1084E6
        ADDA.W  -$4D64(A3),A1                   ; $1084E8
        MOVEA.B -(A4),A2                        ; $1084EC
        DC.W    $FFDF               ; $1084EE MOVE.W  (A7)+,<EA:3F>
        CMPA.W  -$49(A0,A4.L),A4                ; $1084F0
        MOVE.W  A0,-(A0)                        ; $1084F4
        MOVE.B  (A1)+,$FEF6.W                   ; $1084F6
        MULS    D0,D6                           ; $1084FA
        CMP.L  A2,D5                            ; $1084FC
        ADD.W  D4,(A0)+                         ; $1084FE
        ASL.W  #4,D4                            ; $108500
        MULS    (A1),D2                         ; $108502
        CMP.L  A1,D2                            ; $108504
        CMP.W  (A5),D5                          ; $108506
        MOVE.L  -$0F(A2,A6.W),-(A1)             ; $108508
        CMP.L  (A7)+,D5                         ; $10850C
        MOVE.W  -(A7),$56(A5,A5.W)              ; $10850E
        AND.L  D2,(A4)+                         ; $108512
        MOVE.W  D3,-$6420(A6)                   ; $108514
        ADD.W  D0,A6                            ; $108518
        ASR.B  #1,D6                            ; $10851A
        CMP.B  $2C(A7,D0.W),D1                  ; $10851C
        MOVE.L  $46FC(A3),D5                    ; $108520
        ST      (A2)                            ; $108524
        OR.B   -(A1),D6                         ; $108526
        DC.W    $57FD               ; $108528 SEQ     <EA:3D>
        MOVEA.L D7,A5                           ; $10852A
        SPL     #$F926                          ; $10852C
        NEGX   $99FC.W                          ; $108530
        ROXR.W  #$0184                          ; $108534
        MOVE.W  -$80(A1,A6.W),-$0D(PC,D7.L)     ; $108538
        MOVE.L  -(A2),D6                        ; $10853E
        BSET    D4,(A7)+                        ; $108540
        BPL.S  loc_108536                       ; $108542
        BGT.S  loc_1085A8                       ; $108544
        DIVU    $4620(A2),D2                    ; $108546
        MOVEA.W (A1)+,A6                        ; $10854A
        DC.W    $F3FD,$E6FB,$F664   ; $10854C MOVE.W  <EA:3D>,$E6FBF664
        ADDA.W  -$039C(A6),A1                   ; $108552
loc_108556:
        LEA     $33F1(A2),A2                    ; $108556
        DC.W    $4101               ; $10855A DC.W    $4101
        MOVE.W  (A5)+,#$793C                    ; $10855C
        MOVE.W  -(A5),(A1)+                     ; $108560
        DC.W    $F1F9,$2089,$A2CF,$D9E6; $108562 MOVE.W  $2089A2CF,$D9E6.W
        BVC.S  loc_108556                       ; $10856A
        PEA     (A7)+                           ; $10856C
        MOVEA.W (A0)+,A0                        ; $10856E
        LSL.W  (A3)+                            ; $108570
        MOVEA.L D4,A2                           ; $108572
        ADDQ.L  #5,$4C89(A3)                    ; $108574
        MOVE.W  D0,D0                           ; $108578
        ADD.L  -$03(A1,A4.L),D6                 ; $10857A
        BMI.S  loc_1085F2                       ; $10857E
        MOVEA.L -$25(A0,A7.L),A4                ; $108580
        AND.B  D5,-$0D83(PC)                    ; $108584
        MOVE.W  $5535(A2),D1                    ; $108588
        ADD.W  D5,(A4)                          ; $10858C
        DC.W    $02DF               ; $10858E DC.W    $02DF
        BVC.S  loc_108586                       ; $108590
        ROL.W  D2                               ; $108592
        DC.W    $C7FF               ; $108594 MULS    <EA:3F>,D3
        SUBQ.B  #2,-(A2)                        ; $108596
        SUBA.L  -$37(A3,D3.L),A4                ; $108598
        SLS     (A2)                            ; $10859C
        MOVEM.W D0/D1/D2/D6/D7/A3/A5,$104B(A2)  ; $10859E
        ASR.W  -(A4)                            ; $1085A4
        LSL.W  #4,D2                            ; $1085A6
loc_1085A8:
        ADD.L  D7,-$56(A5,A6.W)                 ; $1085A8
        DC.W    $8CFF               ; $1085AC DIVU    <EA:3F>,D6
        NEGX.L $2BD3(A5)                        ; $1085AE
        MOVE.L  (A4),(A4)+                      ; $1085B2
        MOVE.B  A4,(A0)+                        ; $1085B4
        MOVE.L  $52AC(A2),-$33(A1,A6.L)         ; $1085B6
        DC.W    $DEFD               ; $1085BC ADDA.W  <EA:3D>,A7
        DC.W    $D8FD               ; $1085BE ADDA.W  <EA:3D>,A4
        SUBA.L  D1,A3                           ; $1085C0
        EOR.L  D4,D1                            ; $1085C2
        ADD.L  -(A5),D2                         ; $1085C4
        SUBQ.L  #2,$4C82(A3)                    ; $1085C6
        DC.W    $FCFD               ; $1085CA MOVE.W  <EA:3D>,(A6)+
        ADDA.W  #$9FB8,A4                       ; $1085CC
        DC.W    $0E38               ; $1085D0 DC.W    $0E38
        SUB.W  D0,(A4)                          ; $1085D2
        MOVE.L  (A1),$C0CB1D1A                  ; $1085D4
        OR.W   D1,$0AAB.W                       ; $1085DA
        MOVE.B  -(A1),$BD443DDF                 ; $1085DE
        MOVE.L  -(A2),#$AB8568FF                ; $1085E4
        LSR.W  D4                               ; $1085EA
        MOVE.W  -$0069(A6),-$72(A7,A1.L)        ; $1085EC
loc_1085F2:
        ASR.L  D4,D2                            ; $1085F2
        MOVE.W  A6,(A7)                         ; $1085F4
        ASR.W  $13EA.W                          ; $1085F6
        LSR.W  -(A0)                            ; $1085FA
        DC.W    $FDFF               ; $1085FC MOVE.W  <EA:3F>,<EA:3E>
        EORI.W  #$E0F8,-(A6)                    ; $1085FE
        EORI.W  #$F2C0,(A1)                     ; $108602
        MOVE.W  A6,D4                           ; $108606
        DC.W    $FDE0               ; $108608 MOVE.W  -(A0),<EA:3E>
        MOVE.W  -$1DCF(PC),(A7)                 ; $10860A
        DIVU    -(A0),D7                        ; $10860E
        MOVE.W  A6,D4                           ; $108610
        DC.W    $FFE8,$FF88         ; $108612 MOVE.W  -$0078(A0),<EA:3F>
        OR.L   -(A3),D4                         ; $108616
        LEA     #$8585F3A3,A0                   ; $108618
        ADD.L  D0,A4                            ; $10861E
        MOVE.W  A7,-(A7)                        ; $108620
        EOR.L  D0,D0                            ; $108622
        DC.W    $1FF1,$F2EE         ; $108624 MOVE.B  -$12(A1,A7.W),<EA:3F>
        ADDQ.W  #6,(A5)                         ; $108628
        ADDQ.L  #4,A0                           ; $10862A
        ROXR.W  D7,D6                           ; $10862C
        DC.W    $00E5               ; $10862E DC.W    $00E5
        LSR.L  #7,D0                            ; $108630
        AND.L  D6,(A1)                          ; $108632
        LSR.L  #4,D6                            ; $108634
        ROXR.W  -$7A(A4,D1.L)                   ; $108636
        ADDA.W  D5,A7                           ; $10863A
        SCS     -$38(A5,A0.L)                   ; $10863C
        MOVE.B  D1,-(A1)                        ; $108640
        OR.L   A4,D0                            ; $108642
        DIVU    A7,D7                           ; $108644
        MOVE.W  (A4)+,(A4)+                     ; $108646
        MOVE.B  (A1),-(A0)                      ; $108648
        MULU    #$B5C4,D0                       ; $10864A
        DC.W    $001E,$D8EF         ; $10864E ORI.B  #$D8EF,(A6)+
        MOVE.W  A0,#$5858                       ; $108652
        SUBQ.B  #2,D0                           ; $108656
        DIVS    -(A2),D1                        ; $108658
        ASL.W  -(A6)                            ; $10865A
        SVC     D3                              ; $10865C
        DC.W    $030E               ; $10865E BTST    D1,A6
        DC.W    $FFFD               ; $108660 MOVE.W  <EA:3D>,<EA:3F>
        DIVU    D5,D6                           ; $108662
        MOVE.W  $5C(A3,A0.L),(A0)+              ; $108664
        BTST    D0,D6                           ; $108668
        ROL.W  A0                               ; $10866A
        ASL.W  -$177B(A0)                       ; $10866C
        MOVE.L  $C4FF.W,D1                      ; $108670
        ASR.W  (A4)+                            ; $108674
        MULU    -$10(A2,A5.W),D6                ; $108676
        CLR.B  A4                               ; $10867A
        ADDA.L  -$3513(A6),A2                   ; $10867C
        OR.L   A5,D4                            ; $108680
        ADDQ.W  #2,-(A2)                        ; $108682
        DIVU    D2,D2                           ; $108684
        DC.W    $FFFC,$E054         ; $108686 MOVE.W  #$E054,<EA:3F>
        BVC.S  loc_10867D                       ; $10868A
        CMP.W  D1,D0                            ; $10868C
        NEG    A0                               ; $10868E
        ADDQ.L  #4,D4                           ; $108690
        CMPA.W  -$13(A1,D4.W),A7                ; $108692
        MOVE.W  D1,$C71096F2                    ; $108696
        OR.W   D2,D5                            ; $10869C
        DC.W    $4B58               ; $10869E DC.W    $4B58
        OR.L   D0,D4                            ; $1086A0
        DC.W    $0002,$E3DE         ; $1086A2 ORI.B  #$E3DE,D2
        LSL.W  #7,D0                            ; $1086A6
        MOVE.W  D0,-(A2)                        ; $1086A8
        AND.W  -$56(A0,A5.W),D1                 ; $1086AA
        CMP.L  A0,D6                            ; $1086AE
        OR.B   (A2),D0                          ; $1086B0
        DC.W    $48FD,$8455         ; $1086B2 MOVEM.L <EA:3D>,D0/D2/D4/D6/A2/A7
        AND.L  $00A8F3E7,D2                     ; $1086B6
        MOVE.L  (A4)+,D4                        ; $1086BC
        ASL.W  -$76FA(A5)                       ; $1086BE
        DC.W    $4C64               ; $1086C2 DC.W    $4C64
        SUB.W  $54(A3,A2.L),D6                  ; $1086C4
        AND.W  D3,#$8C07                        ; $1086C8
        NEGX   -$12(A0,D5.L)                    ; $1086CC
        LEA     (A5)+,A2                        ; $1086D0
        ROXL.L  D0,D6                           ; $1086D2
        NEG.B  (A1)+                            ; $1086D4
        ADDQ.L  #3,A0                           ; $1086D6
        MOVE.B  A3,(A5)+                        ; $1086D8
        OR.B   -$3A(A7,D6.W),D0                 ; $1086DA
        ADDQ.L  #4,D5                           ; $1086DE
        DC.W    $23F1,$E880,$0658,$5801; $1086E0 MOVE.L  -$80(A1,A6.L),$06585801
        LSR.W  #5,D0                            ; $1086E8
        ROR.W  -(A5)                            ; $1086EA
        CMP.L  -$469C(A0),D6                    ; $1086EC
        DC.W    $0001,$E01B         ; $1086F0 ORI.B  #$E01B,D1
        MULU    $08(PC,A1.W),D5                 ; $1086F4
        ADDA.W  (A5),A5                         ; $1086F8
        SUB.W  D1,(A7)+                         ; $1086FA
        ROXR.B  #2,D1                           ; $1086FC
        CMPA.L  A5,A5                           ; $1086FE
        AND.L  D5,(A1)+                         ; $108700
        SLT     (A5)+                           ; $108702
        CMP.B  D1,D4                            ; $108704
        LEA     -$2117(A1),A4                   ; $108706
        DIVU    (A4),D0                         ; $10870A
        MOVE.L  -(A2),D6                        ; $10870C
        MOVEQ   #-$2C,D2                        ; $10870E
        MOVE.W  -$5C0F(A3),(A7)                 ; $108710
        ROXL.W  $5444(A6)                       ; $108714
        SUBA.W  D4,A4                           ; $108718
        ADDA.L  (A6),A1                         ; $10871A
        MOVE.L  A3,(A3)+                        ; $10871C
        LEA     (A0),A4                         ; $10871E
        MOVE.L  D7,$AEB9B4F2                    ; $108720
        ROR.W  #7,D6                            ; $108726
        ADDQ.W  #7,-(A0)                        ; $108728
        ROXL.B  #6,D1                           ; $10872A
        AND.W  (A4),D3                          ; $10872C
        LEA     -$0DA8(A5),A2                   ; $10872E
        OR.L   D4,D2                            ; $108732
        OR.B   D1,(A4)                          ; $108734
        DC.W    $15FF,$F8F1         ; $108736 MOVE.B  <EA:3F>,-$070F(PC)
        SLS     $6C(A1,A5.W)                    ; $10873A
        ADDA.L  $11(A4,A1.W),A2                 ; $10873E
        MOVE.B  D3,(A0)+                        ; $108742
        MULU    (A2)+,D6                        ; $108744
        MOVE.L  D0,D6                           ; $108746
        ST      (A6)                            ; $108748
        ASR.W  -(A1)                            ; $10874A
        ASL.W  D4,D6                            ; $10874C
        MOVE.W  A3,-(A0)                        ; $10874E
        CLR.L  (A7)+                            ; $108750
        MOVE.W  A6,-$1C(A0,D1.W)                ; $108752
        MOVE.W  (A2),-$0E79(A7)                 ; $108756
        OR.L   A5,D7                            ; $10875A
        CMP.B  #$D3EF,D4                        ; $10875C
        MOVE.W  D5,$5C(A1,A7.L)                 ; $108760
        ADDQ.W  #2,A0                           ; $108764
        SUBI.B  #$4BF1,(A2)                     ; $108766
        LSR.L  D0,D4                            ; $10876A
        MOVE.W  #$F509,$11AA(A1)                ; $10876C
        BGE.S  loc_108765                       ; $108772
        ADD.L  D7,D5                            ; $108774
        MOVEQ   #$10,D2                         ; $108776
        MOVE.B  (A0)+,$336A(PC)                 ; $108778
        DC.W    $08CA,$CCF2         ; $10877C BSET    #18,A2
        MOVE.B  D1,-(A0)                        ; $108780
        ROR.W  #4,D3                            ; $108782
        LSL.W  $0B57(A3)                        ; $108784
        ADD.W  A0,D4                            ; $108788
        DIVS    $44(A1,A6.L),D2                 ; $10878A
        SVC     $75F1(A0)                       ; $10878E
        CMPA.L  $10(A2,D0.W),A2                 ; $108792
        ADDA.W  A5,A2                           ; $108796
        LSR.W  -$6F(A1,A7.W)                    ; $108798
        DC.W    $00F1               ; $10879C DC.W    $00F1
        MOVEA.B (A4),A0                         ; $10879E
        ROR.W  D5,D6                            ; $1087A0
        DC.W    $163F               ; $1087A2 MOVE.B  <EA:3F>,D3
        MOVE.W  -(A4),-$5B2F(A0)                ; $1087A4
        LSR.L  D1,D3                            ; $1087A8
        DC.W    $04AB,$62E8,$C1F1,$CFE9; $1087AA SUBI.L  #$62E8C1F1,-$3017(A3)
        MULU    -(A7),D1                        ; $1087B2
        SUB.B  -(A2),D0                         ; $1087B4
        DC.W    $AD3E               ; $1087B6 MOVE.L  <EA:3E>,-(A6)
        ADDA.W  -$7E(A1,A7.L),A6                ; $1087B8
        OR.L   D4,D7                            ; $1087BC
        MULU    -(A7),D2                        ; $1087BE
        DC.W    $0220,$34B4         ; $1087C0 ANDI.B  #$34B4,-(A0)
        MOVEM.L D2/D3/D5/A0/A1/A2/A4/A7,A6      ; $1087C4
        ADD.L  D2,D5                            ; $1087C8
        DIVU    $3E(A2,A2.L),D5                 ; $1087CA
        MULS    -$6420(A5),D5                   ; $1087CE
        MOVE.W  A2,-$78(A6,A0.W)                ; $1087D2
        ADDQ.W  #8,-$0D(A2,A6.L)                ; $1087D6
        MOVE.W  -(A4),$5889(A7)                 ; $1087DA
        ROXL.W  #$8E33                          ; $1087DE
        MOVE.W  D6,$EA72.W                      ; $1087E2
        MOVE.L  (A0)+,-(A2)                     ; $1087E6
        MULS    -$0D1E(A3),D7                   ; $1087E8
        OR.W   (A4)+,D4                         ; $1087EC
        OR.W   D0,D7                            ; $1087EE
        SCS     -(A7)                           ; $1087F0
        DC.W    $FA3D               ; $1087F2 MOVE.W  <EA:3D>,D5
        ROXL.L  D4,D2                           ; $1087F4
        LSL.W  #4,D4                            ; $1087F6
        LSL.L  #8,D7                            ; $1087F8
        LSR.L  D6,D5                            ; $1087FA
        MOVEA.W (A7),A2                         ; $1087FC
loc_1087FE:
        SUBQ.W  #4,(A1)                         ; $1087FE
        MOVE.W  A6,-$6A(A0,A6.L)                ; $108800
        ASL.W  #4,D6                            ; $108804
        MOVEA.W -$60(A2,A7.W),A6                ; $108806
        DIVU    #$14A0,D3                       ; $10880A
        MOVEA.W -$0C(A3,A7.W),A7                ; $10880E
        ADD.W  (A0)+,D6                         ; $108812
        MOVEA.L (A1),A1                         ; $108814
        MOVE.B  -(A2),(A2)+                     ; $108816
        SUB.L  $37FB(A3),D2                     ; $108818
        SUB.L  D4,D4                            ; $10881C
        MOVE.W  -$2072(A4),D5                   ; $10881E
        DIVU    -(A5),D7                        ; $108822
        ASR.B  D4,D2                            ; $108824
        MOVE.L  (A4)+,(A2)                      ; $108826
        MOVE.L  -$5613(A0),D7                   ; $108828
        SVC     -$0F(A2,A3.W)                   ; $10882C
        BHI.S  loc_1087FE                       ; $108830
        MOVE.W  (A7),$F1A3.W                    ; $108832
        OR.L   $EA44.W,D2                       ; $108836
        MOVEA.L D7,A7                           ; $10883A
        SUBA.L  -$6E(A2,D4.W),A5                ; $10883C
        MOVE.B  -$1E(A4,A3.W),-$0924(A2)        ; $108840
        MOVE.W  -$7F16(A6),$A1DF.W              ; $108846
        MOVE.B  D0,(A5)                         ; $10884C
        ADD.W  A0,D0                            ; $10884E
        ADDA.L  -(A6),A0                        ; $108850
        SCS     D2                              ; $108852
        MOVE.W  D4,-$668F(A4)                   ; $108854
        MOVE.W  D2,-$63(A2,A0.W)                ; $108858
        MOVE.W  $2411(A2),-(A1)                 ; $10885C
        AND.B  D2,(A3)+                         ; $108860
        AND.W  (A6),D1                          ; $108862
        DIVS    -$71AF(A3),D3                   ; $108864
        MOVE.B  -$3C(A0,D4.W),-$024C(PC)        ; $108868
        DIVS    $F2F1.W,D1                      ; $10886E
        MOVEA.W D5,A6                           ; $108872
        MOVE.B  (A0)+,-(A2)                     ; $108874
        MULU    $50(A2,D6.L),D0                 ; $108876
        ROXL.L  #5,D3                           ; $10887A
        MOVE.W  D7,-(A7)                        ; $10887C
        ROXR.W  #6,D4                           ; $10887E
        SUBQ.B  #2,-$0E(A2,A5.W)                ; $108880
        MOVE.B  $1AE2(A1),(A0)+                 ; $108884
        CMP.L  -(A5),D2                         ; $108888
        MOVE.B  -(A4),(A6)                      ; $10888A
        SUBI.L  #$4AF349ED,D5                   ; $10888C
        DIVU    $3718(A2),D2                    ; $108892
        DC.W    $F57D,$F430         ; $108896 MOVE.W  <EA:3D>,-$0BD0(A2)
        ASR.L  #5,D5                            ; $10889A
        DIVS    $5E55(A1),D2                    ; $10889C
        SUBA.L  -$7A1F(A6),A2                   ; $1088A0
        ROXR.W  D5,D0                           ; $1088A4
        MOVE.W  -$0F(A4,A7.L),-(A0)             ; $1088A6
        MOVE.W  -(A6),-$593E(A1)                ; $1088AA
        BLS.S  loc_1088F0                       ; $1088AE
        DC.W    $4957               ; $1088B0 DC.W    $4957
        DC.W    $D0BD               ; $1088B2 ADD.L  <EA:3D>,D0
        MOVE.W  A2,$54A5(A1)                    ; $1088B4
        BSET    #21,-$5A(A4,D7.W)               ; $1088B8
        MOVE.W  -(A2),-$0E(A2,D5.L)             ; $1088BE
        DC.W    $73F2,$EC8B,$C44A,$E8E1; $1088C2 MOVE.W  -$75(A2,A6.L),$C44AE8E1
        MOVE.L  -$2B8B(A6),D2                   ; $1088CA
        ADD.W  D3,D3                            ; $1088CE
        SUB.B  D2,$42(A1,D4.W)                  ; $1088D0
        ASL.W  #4,D2                            ; $1088D4
        BCS.S  loc_1088A8                       ; $1088D6
        DC.W    $0AFA               ; $1088D8 DC.W    $0AFA
        ROXR.W  (A7)+                           ; $1088DA
        LSL.L  D4,D1                            ; $1088DC
        AND.B  $24(A0,A0.W),D6                  ; $1088DE
        DC.W    $7DF8,$092E         ; $1088E2 MOVE.W  $092E.W,<EA:3E>
        ADDQ.W  #7,(A0)                         ; $1088E6
        CMP.B  #$AA48,D0                        ; $1088E8
        DC.W    $454E               ; $1088EC DC.W    $454E
        MULS    #$D2F2,D3                       ; $1088EE
        LSR.W  -$5B55(A4)                       ; $1088F2
        MOVE.L  (A0),(A5)+                      ; $1088F6
        LSR.W  #5,D0                            ; $1088F8
        MOVE.W  -$0E(A2,A2.W),#$7EF5            ; $1088FA
        MULU    -$7714(A2),D1                   ; $108900
        MOVE.W  -$3DAF(A1),(A7)+                ; $108904
        MULU    D7,D4                           ; $108908
        OR.L   D4,D2                            ; $10890A
        DIVU    -(A6),D7                        ; $10890C
        DC.W    $23F2,$9091,$EE7D,$F16E; $10890E MOVE.L  -$6F(A2,A1.W),$EE7DF16E
        OR.L   D5,D4                            ; $108916
        AND.B  D3,-(A3)                         ; $108918
        BMI.S  loc_1088FE                       ; $10891A
        LSL.L  #4,D6                            ; $10891C
        ASR.L  #7,D5                            ; $10891E
        ADDA.L  (A0),A2                         ; $108920
        OR.B   -$2A47(A2),D4                    ; $108922
        MOVE.W  $63(A6,D7.L),D4                 ; $108926
        MOVE.W  (A7)+,-$1C57(A1)                ; $10892A
        DC.W    $A4FF               ; $10892E MOVE.L  <EA:3F>,(A2)+
        MOVEQ   #-$0D,D1                        ; $108930
        ROXR.W  (A1)+                           ; $108932
        BVC.S  loc_10892B                       ; $108934
        DC.W    $98BE               ; $108936 SUB.L  <EA:3E>,D4
        ROXL.W  #5,D6                           ; $108938
        AND.L  D1,(A3)+                         ; $10893A
        ROXL.B  #8,D7                           ; $10893C
        MOVEA.W D2,A1                           ; $10893E
        ADDA.W  $40F2(A4),A6                    ; $108940
        ASL.W  #$E4F1                           ; $108944
        DC.W    $4820               ; $108948 DC.W    $4820
loc_10894A:
        NEG.W  D2                               ; $10894A
        MOVE.W  -$0C07(A5),-$09(A7,D5.W)        ; $10894C
        DC.W    $4549               ; $108952 DC.W    $4549
        BEQ.S  loc_10894A                       ; $108954
        BGE.S  loc_1089B4                       ; $108956
        ADD.B  D7,$D984.W                       ; $108958
        MOVE.W  #$75D4,(A0)+                    ; $10895C
        MOVE.W  -$0D(A4,D4.W),(A0)+             ; $108960
        NOT    $5E(A5,D5.L)                     ; $108964
        ADDQ.B  #8,$14(A0,A6.W)                 ; $108968
        DC.W    $4BBB               ; $10896C DC.W    $4BBB
        MOVEA.L (A0)+,A4                        ; $10896E
        TRAP    #8                              ; $108970
        MULU    (A1)+,D1                        ; $108972
        OR.L   D5,D2                            ; $108974
        DC.W    $FBF1,$66EB         ; $108976 MOVE.W  -$15(A1,D6.W),<EA:3D>
        ADD.L  -$37CB(A2),D1                    ; $10897A
        AND.B  A4,D5                            ; $10897E
        SUBA.W  -(A0),A6                        ; $108980
        MOVE.W  -(A7),(A2)                      ; $108982
        ADDA.W  -$032E(A5),A1                   ; $108984
        MOVE.L  $5938(A2),(A5)                  ; $108988
        ADDA.L  D2,A4                           ; $10898C
        ADD.B  D4,A0                            ; $10898E
        MOVEA.W $68(A3,A6.W),A3                 ; $108990
        MOVE.W  D4,(A1)+                        ; $108994
        SUB.B  D5,-$1DDC(A5)                    ; $108996
        SUB.W  D1,-$28(PC,A6.L)                 ; $10899A
        MOVE.B  -$23(A1,A7.W),(A7)+             ; $10899E
        ADDQ.W  #5,(A6)                         ; $1089A2
        MULU    (A2)+,D0                        ; $1089A4
        ASR.W  (A5)                             ; $1089A6
        MULS    -$1717(A1),D0                   ; $1089A8
        ROXL.B  #8,D1                           ; $1089AC
        ADD.W  (A3),D3                          ; $1089AE
        MOVE.L  D5,-$2E56(PC)                   ; $1089B0
loc_1089B4:
        ASR.W  #$77E0                           ; $1089B4
        AND.L  A6,D7                            ; $1089B8
        MOVEA.L A1,A2                           ; $1089BA
        MOVE.B  $54(A5,A2.L),(A2)+              ; $1089BC
        MOVEA.L -(A2),A5                        ; $1089C0
        MOVE.W  -$0008(A4),(A2)                 ; $1089C2
        EORI.W  #$D404,$85E0.W                  ; $1089C6
        MOVE.W  (A3),-$6B0F(A7)                 ; $1089CC
        CLR.B  (A1)+                            ; $1089D0
        MOVE.L  (A5)+,(A7)                      ; $1089D2
        MOVE.W  $E05E.W,D2                      ; $1089D4
        ASR.L  D7,D5                            ; $1089D8
        BRA.S  loc_1089AF                       ; $1089DA
        MOVE.L  (A4),-$400E(A3)                 ; $1089DC
        MOVE.L  -(A5),D2                        ; $1089E0
        MOVE.L  $9138E92B,(A2)+                 ; $1089E2
        ADD.B  D1,(A4)                          ; $1089E8
        MOVE.W  (A1),-$2714(A5)                 ; $1089EA
        ASL.W  #4,D2                            ; $1089EE
        ADDA.L  $4774(A3),A0                    ; $1089F0
        MOVE.W  A1,$15E0(A3)                    ; $1089F4
        ADD.L  D1,(A0)+                         ; $1089F8
        SUBI.L  #$69E009FC,(A2)                 ; $1089FA
        LEA     -$2ED6(A2),A6                   ; $108A00
        BTST    D5,-$22A1(A1)                   ; $108A04
        ADDA.L  A4,A1                           ; $108A08
        MOVE.W  $58FE.W,-$47FE(A1)              ; $108A0A
        CMPA.W  -(A0),A1                        ; $108A10
        DIVU    $7AEA(A0),D7                    ; $108A12
        BLS.S  loc_108A01                       ; $108A16
        SUB.B  D3,D1                            ; $108A18
        MOVE.L  (A0),(A4)                       ; $108A1A
        MOVE.L  -(A6),(A0)                      ; $108A1C
        LEA     -$03(A3,A3.L),A5                ; $108A1E
        MOVE.L  -$1118(A0),$60(A0,A6.W)         ; $108A22
        ASR.W  #7,D1                            ; $108A28
        OR.W   (A5),D7                          ; $108A2A
        SUBQ.L  #2,$55(A7,A4.L)                 ; $108A2C
        ASR.W  $09E9.W                          ; $108A30
        MOVE.W  (A0),(A7)                       ; $108A34
        ROXR.W  D3,D4                           ; $108A36
        MOVE.W  (A2),$19D0D218                  ; $108A38
        ADD.B  A1,D0                            ; $108A3E
        SUBQ.B  #2,(A6)                         ; $108A40
        NEGX   -$1E02(A4)                       ; $108A42
        MULS    (A1)+,D7                        ; $108A46
        MOVE.W  -(A6),(A2)                      ; $108A48
        BHI.S  loc_108A15                       ; $108A4A
        DC.W    $F7BD,$D2E2         ; $108A4C MOVE.W  <EA:3D>,-$1E(A3,A5.W)
        BHI.S  loc_108A33                       ; $108A50
        OR.L   A0,D7                            ; $108A52
        ROXR.L  D7,D0                           ; $108A54
        MOVE.W  -(A1),-$1237(A7)                ; $108A56
        ADDQ.B  #4,-$6F12(A6)                   ; $108A5A
        MOVE.B  -$7758(A3),(A1)+                ; $108A5E
        DC.W    $27FC,$EDE0,$2A12,$F3D9; $108A62 MOVE.L  #$EDE02A12,-$27(PC,A7.W)
        ADDA.L  -$26(A3,A2.W),A3                ; $108A6A
        MOVE.L  $2B28(A2),-$4E(PC,A0.W)         ; $108A6E
        ADDA.L  (A2),A3                         ; $108A74
        MOVE.W  -$45(A1,A2.W),(A3)+             ; $108A76
        ADDA.W  (A6),A1                         ; $108A7A
        MOVE.B  (A2)+,-(A2)                     ; $108A7C
        ADDA.L  $25(A3,A6.W),A0                 ; $108A7E
        MOVE.B  #$0DD9,$55(PC,A0.L)             ; $108A82
        DC.W    $03CA               ; $108A88 BSET    D1,A2
        MOVE.W  $5510F8EE,-(A2)                 ; $108A8A
        ADD.B  D7,-$150F(A1)                    ; $108A90
        MOVE.W  -$26(A7,D0.L),(A1)              ; $108A94
        MOVE.B  D7,(A2)+                        ; $108A98
        LSR.B  #6,D5                            ; $108A9A
        LSL.L  D4,D5                            ; $108A9C
        ADD.W  D1,D2                            ; $108A9E
        OR.L   D2,D4                            ; $108AA0
        CMP.B  $0148(A2),D4                     ; $108AA2
        CMPA.L  -(A2),A3                        ; $108AA6
        SUBA.W  -$6E36(A1),A3                   ; $108AA8
        ROXL.W  -$36(A1,A2.L)                   ; $108AAC
        LSR.W  $5C55FE78                        ; $108AB0
        AND.L  (A3)+,D1                         ; $108AB6
        OR.W   D5,A4                            ; $108AB8
        NEG.W  (A4)+                            ; $108ABA
        DC.W    $4819               ; $108ABC DC.W    $4819
loc_108ABE:
        ROXL.W  #8,D7                           ; $108ABE
        MOVE.W  $48(A1,D7.L),-$2B(PC,D0.L)      ; $108AC0
        BVS.S  loc_108B20                       ; $108AC6
        SUBA.W  -$20(A2,D5.W),A0                ; $108AC8
        MOVEQ   #$08,D2                         ; $108ACC
        LSL.W  D0                               ; $108ACE
        LSR.B  #4,D7                            ; $108AD0
        BHI.S  loc_108ABD                       ; $108AD2
        MOVE.L  $4775(A3),$75(A0,A6.L)          ; $108AD4
        OR.B   D4,A0                            ; $108ADA
loc_108ADC:
        ADDA.L  D6,A5                           ; $108ADC
        MOVE.W  -$6CF2(A3),-(A3)                ; $108ADE
        ROR.W  #2,D0                            ; $108AE2
        OR.W   -$03DB(A2),D7                    ; $108AE4
        CMPA.W  A1,A1                           ; $108AE8
        BNE.S  loc_108AF0                       ; $108AEA
        MULS    -$7C(A4,A7.W),D1                ; $108AEC
loc_108AF0:
        MOVE.L  D5,(A3)                         ; $108AF0
        ADDQ.L  #2,(A2)+                        ; $108AF2
        SUBQ.L  #2,A2                           ; $108AF4
        MOVE.L  -(A5),(A5)+                     ; $108AF6
        SNE     (A2)+                           ; $108AF8
        TST    (A3)+                            ; $108AFA
        BCLR    D4,$72(A3,A4.W)                 ; $108AFC
        ASR.W  D2,D0                            ; $108B00
        ADD.B  A0,D7                            ; $108B02
        MOVE.L  -$13CF(A0),D5                   ; $108B04
        AND.B  D2,$0F(A0,A4.W)                  ; $108B08
        AND.B  (A5),D1                          ; $108B0C
        AND.W  D6,-$0E(A2,A2.L)                 ; $108B0E
        ROXL.L  #2,D3                           ; $108B12
        MOVE.W  -$32(PC,A6.L),(A7)+             ; $108B14
        AND.L  D4,-(A4)                         ; $108B18
        ROL.W  #8,D6                            ; $108B1A
        MOVEQ   #-$0F,D7                        ; $108B1C
        MOVEA.B (A5),A3                         ; $108B1E
loc_108B20:
        BVC.S  loc_108ADC                       ; $108B20
        MOVEQ   #-$0F,D3                        ; $108B22
        SGT     (A7)                            ; $108B24
        ROXL.L  #8,D5                           ; $108B26
        DC.W    $00E4               ; $108B28 DC.W    $00E4
        MOVE.W  -$46(PC,D0.L),$1E(A6,D7.L)      ; $108B2A
        NEGX.L -$58(A1,D5.L)                    ; $108B30
        SCS     -$1B76(A6)                      ; $108B34
        ROR.W  #3,D0                            ; $108B38
        ASL.L  D2,D2                            ; $108B3A
        MOVEQ   #$7C,D7                         ; $108B3C
        ROXL.W  -$4E(A6,A6.W)                   ; $108B3E
        MOVE.B  A3,(A6)+                        ; $108B42
        ROXR.W  #2,D5                           ; $108B44
        MOVE.L  -(A4),(A5)                      ; $108B46
        ADDQ.L  #4,-(A3)                        ; $108B48
        MOVE.L  $EA44.W,D5                      ; $108B4A
        CMP.L  D5,D3                            ; $108B4E
        DC.W    $F2BE               ; $108B50 MOVE.W  <EA:3E>,(A1)
        EOR.W  D5,-(A7)                         ; $108B52
        DC.W    $DBBD               ; $108B54 ADD.L  D5,<EA:3D>
        MOVE.W  -(A4),-(A0)                     ; $108B56
        MOVE.L  (A2),(A6)+                      ; $108B58
        CMP.B  -$26(PC,A2.W),D1                 ; $108B5A
        SUB.W  D1,(A5)                          ; $108B5E
        MOVE.L  -(A4),(A2)+                     ; $108B60
        LSL.L  D4,D2                            ; $108B62
        MOVE.L  (A0)+,(A5)                      ; $108B64
        ADD.W  D5,(A0)                          ; $108B66
        MOVE.W  -$23FD(PC),D1                   ; $108B68
        MOVE.L  A4,(A5)+                        ; $108B6C
        MOVEM.W D0/D3/D4/D6/D7/A0/A1/A2/A3/A5/A6/A7,D0; $108B6E
        MULU    $CEAA.W,D6                      ; $108B72
        CMP.W  A6,D1                            ; $108B76
        ROXR.W  (A2)                            ; $108B78
        ADD.W  -(A1),D5                         ; $108B7A
        ASL.W  #7,D0                            ; $108B7C
        ASR.B  #2,D0                            ; $108B7E
        CMPA.W  -$25C3(A6),A7                   ; $108B80
        MOVEA.L D5,A4                           ; $108B84
        DBCC    D2,$10A2E8                      ; $108B86
        ROR.W  A0                               ; $108B8A
        ADD.W  D0,A0                            ; $108B8C
        SPL     $55(A4,D6.L)                    ; $108B8E
        EOR.W  D0,A0                            ; $108B92
        MOVE.W  -(A4),D2                        ; $108B94
        SUBQ.L  #2,(A2)+                        ; $108B96
        ADD.B  (A1)+,D6                         ; $108B98
        AND.W  D0,-$26E1(A6)                    ; $108B9A
        OR.L   -(A0),D2                         ; $108B9E
        ROR.L  D7,D5                            ; $108BA0
        MOVE.W  -$0923(A0),$13F3(A1)            ; $108BA2
        DC.W    $FFF1,$EEA8         ; $108BA8 MOVE.W  -$58(A1,A6.L),<EA:3F>
        MOVE.W  D2,(A7)+                        ; $108BAC
        ASR.B  D5,D4                            ; $108BAE
        MOVE.L  A0,(A0)                         ; $108BB0
        ROR.L  D1,D0                            ; $108BB2
        ROXL.W  -(A4)                           ; $108BB4
        MULS    -$7B(A6,A2.L),D3                ; $108BB6
        LSR.W  -$0D12(A0)                       ; $108BBA
        MULU    (A1),D3                         ; $108BBE
        OR.W   A0,D4                            ; $108BC0
        OR.B   A2,D7                            ; $108BC2
        BSET    D6,$55(A2,D5.L)                 ; $108BC4
        MOVEM.L D0/D2/D7/A3/A7,$588E(A5)        ; $108BC8
        MOVEA.L $70(A5,A4.W),A7                 ; $108BCE
        ADD.B  D5,-$4E80(A1)                    ; $108BD2
        CMPA.L  (A2)+,A4                        ; $108BD6
        ADD.B  D0,$7AAC(A3)                     ; $108BD8
        ADD.W  A0,D2                            ; $108BDC
        NOT.L  -$154F(PC)                       ; $108BDE
        MOVEA.L -$44AB(A6),A0                   ; $108BE2
        DIVU    -(A5),D7                        ; $108BE6
        EOR.L  D2,-(A0)                         ; $108BE8
        BLE.S  loc_108C51                       ; $108BEA
        MOVE.W  (A1)+,$6AB1.W                   ; $108BEC
        DC.W    $4554               ; $108BF0 DC.W    $4554
        ADDA.L  (A0),A4                         ; $108BF2
        MOVE.W  -(A1),(A5)+                     ; $108BF4
        MOVE.L  A0,(A5)+                        ; $108BF6
        SUBA.L  D3,A3                           ; $108BF8
        MOVE.W  -$2E(A3,A4.W),#$8EC2            ; $108BFA
        MOVE.L  -$545E(PC),-$51DF(A5)           ; $108C00
        SLT     (A3)                            ; $108C06
        CMPA.L  (A7)+,A1                        ; $108C08
        ASR.L  D6,D5                            ; $108C0A
        MOVE.L  D4,-$178F(A4)                   ; $108C0C
        AND.B  D2,$228F(A2)                     ; $108C10
        LSR.L  #7,D6                            ; $108C14
        MOVE.W  D7,-(A0)                        ; $108C16
        LSR.B  #8,D1                            ; $108C18
        MOVE.W  $48(A6,D3.W),(A0)               ; $108C1A
        MOVE.L  A5,D5                           ; $108C1E
        MOVE.L  A4,(A6)                         ; $108C20
        CMP.B  D2,D2                            ; $108C22
        AND.B  (A7)+,D6                         ; $108C24
        ADD.B  D1,-(A4)                         ; $108C26
        LSR.W  (A1)+                            ; $108C28
        CLR.B  $2868(A7)                        ; $108C2A
        PEA     (A4)                            ; $108C2E
        MOVE.L  -(A4),(A2)                      ; $108C30
        DC.W    $F3F1,$F3B0,$E1CE,$E218; $108C32 MOVE.W  -$50(A1,A7.W),$E1CEE218
        DIVU    -$2C(A5,D0.W),D0                ; $108C3A
        DC.W    $22FE               ; $108C3E MOVE.L  <EA:3E>,(A1)+
        MOVE.W  (A4),-(A7)                      ; $108C40
        DC.W    $06D9               ; $108C42 DC.W    $06D9
        MULU    (A4)+,D0                        ; $108C44
        ASL.W  #$F825                           ; $108C46
        CLR    $14B4(A3)                        ; $108C4A
        MOVE.W  D1,(A4)                         ; $108C4E
        ASL.W  $2DF4(A0)                        ; $108C50
        ADDA.W  A2,A2                           ; $108C54
        ADDQ.B  #2,A0                           ; $108C56
        MOVE.L  $F1C85CE8,D0                    ; $108C58
        ADDA.W  D1,A3                           ; $108C5E
loc_108C60:
        OR.L   D2,D1                            ; $108C60
        MOVE.W  -(A3),(A4)                      ; $108C62
        ROXR.L  D3,D3                           ; $108C64
        DIVS    -$56(A2,A2.W),D4                ; $108C66
        MOVEA.L $7F(A3,A3.W),A5                 ; $108C6A
        ROXR.W  #$FCDA                          ; $108C6E
        AND.L  D4,A2                            ; $108C72
        ASL.W  D5                               ; $108C74
        MOVE.W  $00(A1,A2.L),$DB3A.W            ; $108C76
        DC.W    $04F4               ; $108C7C DC.W    $04F4
        MOVE.L  -$169B(A2),-$56AB(A5)           ; $108C7E
        ASR.W  A6                               ; $108C84
        SHI     (A1)                            ; $108C86
loc_108C88:
        MOVE.L  (A6)+,-(A0)                     ; $108C88
        MOVE.W  -(A1),-$3FAE(PC)                ; $108C8A
        BGT.S  loc_108C7A                       ; $108C8E
        ADDA.L  $5E(A1,D5.W),A6                 ; $108C90
        ROXL.W  D0                              ; $108C94
        MOVE.B  -$40(PC,A7.L),#$EB24            ; $108C96
        ADDQ.W  #1,$AACC.W                      ; $108C9C
        OR.W   (A2),D0                          ; $108CA0
        AND.B  D5,-(A5)                         ; $108CA2
        ADDA.W  $18DB(A7),A6                    ; $108CA4
        BVC.S  loc_108CBC                       ; $108CA8
        MOVE.W  $EBFD.W,$FEF0.W                 ; $108CAA
        ADDQ.B  #2,A1                           ; $108CB0
        SUB.W  (A0)+,D1                         ; $108CB2
        JSR     $50(A2,D5.L)                    ; $108CB4
        LSL.W  -$4E(A0,A3.L)                    ; $108CB8
loc_108CBC:
        ADDQ.L  #6,$58(A3,A7.W)                 ; $108CBC
        NEG    -$2669(A4)                       ; $108CC0
        SUB.W  D3,D2                            ; $108CC4
        MOVE.L  -$0645(A2),(A5)                 ; $108CC6
        LSR.L  D6,D6                            ; $108CCA
        LEA     (A1),A2                         ; $108CCC
        BCS.S  loc_108C60                       ; $108CCE
loc_108CD0:
        BCHG    D5,(A5)                         ; $108CD0
        BLS.S  loc_108C88                       ; $108CD2
        ADD.B  -$5D(A6,A7.W),D5                 ; $108CD4
        MOVE.W  -(A2),D3                        ; $108CD8
        NEG.L  -$10(A1,A4.L)                    ; $108CDA
        ADD.L  D2,A6                            ; $108CDE
        AND.W  D4,(A2)                          ; $108CE0
        MOVEA.W (A4),A4                         ; $108CE2
        SUBQ.L  #2,A7                           ; $108CE4
        DC.W    $4C24               ; $108CE6 DC.W    $4C24
        BGE.S  loc_108C9E                       ; $108CE8
        BLE.S  loc_108CB1                       ; $108CEA
        MOVEM.W D0/D2/D5/D6/D7/A0/A2/A3/A6/A7,-(A4); $108CEC
        LEA     -$2B(A5,D5.L),A4                ; $108CF0
        MOVE.L  (A2)+,(A2)+                     ; $108CF4
        SUB.L  $5E(A3,D5.L),D0                  ; $108CF6
        MOVE.B  -$1A0D(PC),(A6)                 ; $108CFA
        SCC     -$321E(A3)                      ; $108CFE
        BLT.S  loc_108CD0                       ; $108D02
        DC.W    $41A9               ; $108D04 DC.W    $41A9
        SGT     -(A5)                           ; $108D06
        MOVE.W  (A1)+,D1                        ; $108D08
        ADD.W  D7,D5                            ; $108D0A
        ADD.W  D5,A5                            ; $108D0C
        DC.W    $45A4               ; $108D0E DC.W    $45A4
        EORI.W  #$C1B2,$0ABB(A3)                ; $108D10
        ADD.L  $20AF(A3),D3                     ; $108D16
        MOVE.W  $56(A2,A2.L),$2F(PC,A4.W)       ; $108D1A
        MOVE.W  $1B(A3,A7.W),(A1)+              ; $108D20
        DC.W    $D33F               ; $108D24 ADD.B  D1,<EA:3F>
        MOVE.W  D0,(A6)                         ; $108D26
        AND.B  -(A5),D1                         ; $108D28
        MOVE.L  -$0C(A1,D0.L),$55(PC,A0.W)      ; $108D2A
        MULU    A5,D4                           ; $108D30
        MOVE.L  -(A5),D2                        ; $108D32
        ROXL.W  #4,D2                           ; $108D34
        CLR    -(A7)                            ; $108D36
        CMPA.W  (A0)+,A1                        ; $108D38
        MOVE.L  (A0)+,$F3B2D681                 ; $108D3A
        MOVE.L  #$55E1E965,(A5)                 ; $108D40
        MOVEA.B A0,A6                           ; $108D46
        MOVEA.W D5,A2                           ; $108D48
        DC.W    $FBCA               ; $108D4A MOVE.W  A2,<EA:3D>
        MOVE.L  (A2),(A5)                       ; $108D4C
        ADDQ.B  #1,#$C28F                       ; $108D4E
        ROXR.W  -(A1)                           ; $108D52
        DC.W    $400E               ; $108D54 NEGX.B A6
        ADDA.W  (A1),A4                         ; $108D56
        AND.L  D4,(A3)                          ; $108D58
        NEG.B  (A2)                             ; $108D5A
        SUBA.L  -(A4),A0                        ; $108D5C
        MOVE.W  A3,D4                           ; $108D5E
        MULU    A7,D4                           ; $108D60
        ADDQ.L  #8,-$5E(A7,A1.W)                ; $108D62
        DC.W    $0029,$BABA,$F009   ; $108D66 ORI.B  #$BABA,-$0FF7(A1)
        NEGX   $16F5(A5)                        ; $108D6C
        MOVE.L  $6FD5(A0),(A4)                  ; $108D70
        CMP.W  (A4),D6                          ; $108D74
        DC.W    $E2FD               ; $108D76 LSR.W  <EA:3D>
        OR.B   D5,D0                            ; $108D78
        MOVE.L  -$6DAD(A2),$2D(A1,D4.W)         ; $108D7A
        MOVEA.W D0,A6                           ; $108D80
        CMP.L  (A0)+,D2                         ; $108D82
        MOVE.W  A1,D0                           ; $108D84
        CMPA.L  A3,A6                           ; $108D86
        AND.L  #$A0AAA8B0,D2                    ; $108D88
        LSR.L  D5,D2                            ; $108D8E
loc_108D90:
        ADD.W  D5,A4                            ; $108D90
        DIVU    -$0D89(A0),D3                   ; $108D92
        SUBA.W  $04D6(A4),A2                    ; $108D96
        MOVE.L  $71FC(A2),(A1)                  ; $108D9A
        DC.W    $4DA8               ; $108D9E DC.W    $4DA8
        BSET    D4,-(A7)                        ; $108DA0
        DIVU    -(A4),D3                        ; $108DA2
        ADD.B  -$4053(A5),D3                    ; $108DA4
        MOVE.L  -(A3),(A0)+                     ; $108DA8
        MOVE.L  $47CD(A2),(A5)                  ; $108DAA
        MOVE.L  -$03(A6,A6.W),(A3)              ; $108DAE
        BSR.S  loc_108D71                       ; $108DB2
        MOVE.L  -$5D(A5,D4.L),(A6)              ; $108DB4
        MOVE.W  $43CC(A2),(A2)                  ; $108DB8
        MOVE.L  (A2)+,D5                        ; $108DBC
        MOVE.B  -$2D(A4,A0.W),(A4)              ; $108DBE
        MOVE.W  D3,(A6)+                        ; $108DC2
        BLS.S  loc_108D90                       ; $108DC4
        ROL.W  -(A2)                            ; $108DC6
        MOVE.W  -(A2),(A0)+                     ; $108DC8
        LSR.L  #1,D1                            ; $108DCA
        OR.B   -(A5),D2                         ; $108DCC
        MOVE.B  -$3E(A0,D0.L),(A2)+             ; $108DCE
        ADDA.W  -(A7),A0                        ; $108DD2
        NOT.L  -(A1)                            ; $108DD4
        EOR.L  D2,(A2)                          ; $108DD6
        SUB.B  D3,-$3A(A0,A5.W)                 ; $108DD8
        CMP.L  D5,D1                            ; $108DDC
        DC.W    $04E1               ; $108DDE DC.W    $04E1
        DIVS    A1,D5                           ; $108DE0
        ADD.L  -$5D32(PC),D3                    ; $108DE2
        ADD.L  D4,A5                            ; $108DE6
        ADDA.L  -$3DBB(A4),A0                   ; $108DE8
        DC.W    $481A               ; $108DEC DC.W    $481A
        AND.B  D1,-$09(A0,A6.W)                 ; $108DEE
        MOVE.L  D5,D5                           ; $108DF2
        MOVE.W  -$04(A6,D5.L),#$52F2            ; $108DF4
        OR.W   (A3),D6                          ; $108DFA
        MOVEA.W (A5),A3                         ; $108DFC
        ADD.W  D5,(A5)                          ; $108DFE
        ADD.B  D2,D7                            ; $108E00
        MOVE.W  A5,-$14CA(A1)                   ; $108E02
        OR.L   -(A0),D7                         ; $108E06
        ADDA.W  D7,A5                           ; $108E08
        ADDA.W  $44(A1,A2.W),A6                 ; $108E0A
        ADDQ.B  #8,A1                           ; $108E0E
        MOVE.L  -$2B(A1,D5.W),(A0)+             ; $108E10
        OR.L   D4,D2                            ; $108E14
        CMPA.W  -$1C(A3,A7.L),A0                ; $108E16
        ROR.L  D0,D7                            ; $108E1A
        DC.W    $2FEA,$5BF3         ; $108E1C MOVE.L  $5BF3(A2),<EA:3F>
        MOVE.L  -(A4),(A0)+                     ; $108E20
        SPL     (A2)                            ; $108E22
        MOVE.L  $5484(A2),-$2F(A5,D2.W)         ; $108E24
        ADD.L  D1,(A4)+                         ; $108E2A
        ASL.W  (A0)+                            ; $108E2C
        ADD.L  (A0)+,D6                         ; $108E2E
        ROR.B  #3,D0                            ; $108E30
        MOVE.W  (A6)+,(A2)+                     ; $108E32
        AND.W  D0,-(A2)                         ; $108E34
        SCS     (A1)+                           ; $108E36
        ADDA.W  #$5810,A7                       ; $108E38
        LSL.W  #4,D0                            ; $108E3C
        ADDA.L  (A1)+,A0                        ; $108E3E
        DC.W    $1FD7               ; $108E40 MOVE.B  (A7),<EA:3F>
        LEA     -$0A(A5,D0.W),A0                ; $108E42
        SUBQ.W  #2,(A5)                         ; $108E46
        MOVE.L  -(A5),$D0FF.W                   ; $108E48
        MOVE.W  A3,(A0)+                        ; $108E4C
        ROL.L  D2,D4                            ; $108E4E
        DC.W    $B8FD               ; $108E50 CMPA.W  <EA:3D>,A4
        MOVE.W  (A4)+,(A0)+                     ; $108E52
        MOVE.W  (A1)+,$36E9(PC)                 ; $108E54
        SUB.W  (A1),D3                          ; $108E58
        OR.W   D3,D1                            ; $108E5A
        MOVE.W  (A0),(A2)+                      ; $108E5C
        LSR.B  #3,D0                            ; $108E5E
        ROXR.W  #2,D5                           ; $108E60
        SCS     -$26(A6,A1.W)                   ; $108E62
        ASL.L  #5,D0                            ; $108E66
        ADD.W  $82F2.W,D5                       ; $108E68
        OR.W   -(A0),D2                         ; $108E6C
        CMP.W  D1,D7                            ; $108E6E
        DIVU    D4,D5                           ; $108E70
        SUB.L  D0,A3                            ; $108E72
        MOVEA.L A2,A5                           ; $108E74
        MOVE.W  -(A5),#$1CCA                    ; $108E76
        ADD.L  (A1)+,D6                         ; $108E7A
        DC.W    $A9BE,$C57B         ; $108E7C MOVE.L  <EA:3E>,$7B(A4,A4.W)
        MOVE.L  -$5DC8(A2),(A1)                 ; $108E80
        ROL.W  #4,D4                            ; $108E84
        ADD.B  $43(A2,A7.W),D6                  ; $108E86
        MOVE.W  D4,-$1D8C(A0)                   ; $108E8A
        DC.W    $F1B9,$AFAA,$3BF2,$5858; $108E8E MOVE.W  $AFAA3BF2,$58(A0,D5.L)
        EXT.W   D4                              ; $108E96
        LEA     $79(A2,D1.L),A5                 ; $108E98
        MOVE.W  (A1)+,(A5)+                     ; $108E9C
        MOVE.W  (A3),(A3)                       ; $108E9E
        BSET    D7,$41(A2,D4.L)                 ; $108EA0
        OR.W   $389B58E5,D0                     ; $108EA4
        ADD.W  (A6)+,D6                         ; $108EAA
        MOVE.L  -$4B(A2,A5.W),-$5760(A1)        ; $108EAC
        MOVE.W  -$4C7F(PC),#$F284               ; $108EB2
        SUB.L  D5,D3                            ; $108EB8
        OR.B   D5,(A3)                          ; $108EBA
        SUB.B  D5,$1A71(A2)                     ; $108EBC
        CMP.W  -$7E93(A7),D5                    ; $108EC0
        MULS    -$1E(A6,A5.L),D6                ; $108EC4
        ROL.L  #8,D2                            ; $108EC8
        OR.W   D0,D4                            ; $108ECA
        LEA     -$4A(A6,A6.L),A2                ; $108ECC
        DC.W    $A2FF               ; $108ED0 MOVE.L  <EA:3F>,(A1)+
        MOVE.L  A6,$D1F8.W                      ; $108ED2
        BSET    D0,D2                           ; $108ED6
        MOVE.W  A2,(A4)+                        ; $108ED8
        LSL.B  #2,D1                            ; $108EDA
        DC.W    $11FF,$810A         ; $108EDC MOVE.B  <EA:3F>,$810A.W
        MOVE.B  (A1),D5                         ; $108EE0
        MOVEA.L A1,A0                           ; $108EE2
        DC.W    $4D09               ; $108EE4 DC.W    $4D09
        MOVE.W  (A7),$211B(A7)                  ; $108EE6
        DC.W    $4977               ; $108EEA DC.W    $4977
        DC.W    $0308               ; $108EEC BTST    D1,A0
        MOVE.W  A0,-$0A(A0,A6.L)                ; $108EEE
        MOVE.W  A1,D2                           ; $108EF2
        BSET    D1,-$0678(A4)                   ; $108EF4
        DC.W    $18FD               ; $108EF8 MOVE.B  <EA:3D>,(A4)+
        ROR.W  D4,D0                            ; $108EFA
        MOVE.W  $097C1786,-(A3)                 ; $108EFC
        MULU    -$1334(A4),D6                   ; $108F02
        SUB.B  D0,-(A1)                         ; $108F06
        ADDA.W  D7,A5                           ; $108F08
        MULS    (A2)+,D3                        ; $108F0A
        BTST    D4,(A1)+                        ; $108F0C
        MOVEQ   #$78,D4                         ; $108F0E
        MULS    D0,D6                           ; $108F10
        ADD.L  D2,D6                            ; $108F12
        MOVE.B  -$7F(A1,A0.L),(A4)+             ; $108F14
        ADD.W  D7,-$34(A7,A6.W)                 ; $108F18
        DC.W    $0024,$E7C1         ; $108F1C ORI.B  #$E7C1,-(A4)
        MOVE.W  A0,$42E30102                    ; $108F20
        DC.W    $FFFD               ; $108F26 MOVE.W  <EA:3D>,<EA:3F>
        CMPA.L  #$78ED20A2,A4                   ; $108F28
        MOVE.W  (A5),(A6)                       ; $108F2E
        MOVE.W  A3,-$80(A4,D0.W)                ; $108F30
        DC.W    $FFF8,$0FCC         ; $108F34 MOVE.W  $0FCC.W,<EA:3F>
        ROXL.L  #2,D7                           ; $108F38
        AND.B  -$7054(A2),D2                    ; $108F3A
        DC.W    $A8FF               ; $108F3E MOVE.L  <EA:3F>,(A4)+
        MOVE.W  (A5)+,D4                        ; $108F40
        LEA     #$E1F81968,A4                   ; $108F42
        DC.W    $04B1,$60FE,$FFF8,$0E15; $108F48 SUBI.L  #$60FEFFF8,$15(A1,D0.L)
        MOVE.W  A0,-(A6)                        ; $108F50
        DC.W    $001D,$FDFC         ; $108F52 ORI.B  #$FDFC,(A5)+
        MOVE.B  -$08(A1,A6.L),(A3)+             ; $108F56
        BCHG    D4,(A5)                         ; $108F5A
        SUBQ.W  #2,(A4)                         ; $108F5C
        DC.W    $1DF0,$54E1         ; $108F5E MOVE.B  -$1F(A0,D5.W),<EA:3E>
        MOVE.B  -(A2),#$BBED                    ; $108F62
        DC.W    $13F2,$E2FE,$3631,$DE6E; $108F66 MOVE.B  -$02(A2,A6.W),$3631DE6E
        MOVEA.W (A3),A6                         ; $108F6E
loc_108F70:
        BLS.S  loc_108FA7                       ; $108F70
        MOVE.B  $3951(A1),$9A3B.W               ; $108F72
        MOVE.W  (A5),$4342(A2)                  ; $108F78
        SUBQ.W  #1,-(A3)                        ; $108F7C
        BCLR    D2,D1                           ; $108F7E
        MOVE.W  (A7),D4                         ; $108F80
        DC.W    $21FC,$32F0,$F80A,$9EF2; $108F82 MOVE.L  #$32F0F80A,$9EF2.W
        MOVE.L  (A4),(A1)+                      ; $108F8A
        ADD.W  D3,-$08(A0,D4.L)                 ; $108F8C
        MOVE.B  A7,(A3)                         ; $108F90
        MOVEA.W $8878.W,A1                      ; $108F92
        MOVEQ   #-$1D,D4                        ; $108F96
        DC.W    $F3FF,$F80A,$C6D7   ; $108F98 MOVE.W  <EA:3F>,$F80AC6D7
        MULU    (A0)+,D6                        ; $108F9E
        BSR.S  loc_108F70                       ; $108FA0
        MOVE.W  A4,(A6)+                        ; $108FA2
        ROXR.W  -$13E8(A6)                      ; $108FA4
        MOVE.B  -(A0),-$6B(A4,A7.W)             ; $108FA8
        DC.W    $047C,$CCAC,$1253   ; $108FAC SUBI.W  #$CCAC,#$1253
        MOVE.W  (A7)+,D1                        ; $108FB2
        BTST    D7,(A1)+                        ; $108FB4
        MOVE.W  D5,-$4B0B(A1)                   ; $108FB6
        MOVE.B  A7,D2                           ; $108FBA
        DC.W    $19FF,$E783         ; $108FBC MOVE.B  <EA:3F>,#$E783
        MOVE.W  D7,-$08(A0,D7.W)                ; $108FC0
        MOVE.W  -$0E(A4,A0.L),(A6)+             ; $108FC4
        MOVE.W  (A3),-(A7)                      ; $108FC8
        ROXL.B  #6,D3                           ; $108FCA
        ADDQ.W  #2,$1887.W                      ; $108FCC
        NOT.B  $77(A5,D4.W)                     ; $108FD0
        OR.B   D1,$77AF(A1)                     ; $108FD4
        MOVE.W  D3,#$2254                       ; $108FD8
        SCS     $F6E20CDF                       ; $108FDC
        OR.L   A5,D2                            ; $108FE2
        MOVE.L  -(A5),(A3)+                     ; $108FE4
        MOVE.L  $0E09(A4),D4                    ; $108FE6
        MOVEQ   #$50,D0                         ; $108FEA
        MOVE.B  (A4)+,(A4)+                     ; $108FEC
        MOVE.W  (A5),$34F7(A4)                  ; $108FEE
        MOVE.W  A3,D0                           ; $108FF2
        ROXL.B  #5,D3                           ; $108FF4
        MOVE.B  D7,$1B(A6,D5.W)                 ; $108FF6
        OR.W   D2,D6                            ; $108FFA
        MOVE.W  -(A3),D3                        ; $108FFC
        MOVE.B  -$04(A2,D3.W),-(A3)             ; $108FFE
        AND.B  D0,A6                            ; $109002
        MOVE.W  -(A3),-(A1)                     ; $109004
        MOVE.W  $2132(PC),(A3)+                 ; $109006
        DC.W    $4139               ; $10900A DC.W    $4139
        MOVE.L  -$48(A3,D0.W),-(A1)             ; $10900C
        MULS    D0,D1                           ; $109010
        DC.W    $33F0,$F8E8,$F017,$3335; $109012 MOVE.W  -$18(A0,A7.L),$F0173335
        BCHG    D1,(A2)+                        ; $10901A
        CMPA.W  $31(A1,D3.W),A0                 ; $10901C
        MOVE.L  (A7)+,D0                        ; $109020
        BTST    D0,(A2)                         ; $109022
        DC.W    $87BD               ; $109024 OR.L   D3,<EA:3D>
        MOVE.W  -$75E7(A3),$7C(A0,D1.W)         ; $109026
        MOVE.W  -$2617(A5),(A6)+                ; $10902C
        CMPA.W  -$0F0F(A1),A6                   ; $109030
        ADD.W  (A2)+,D4                         ; $109034
        MOVE.L  D2,D5                           ; $109036
        SUBI.L  #$339A3220,-(A4)                ; $109038
        MOVE.B  D0,D2                           ; $10903E
        MOVE.W  (A7)+,-(A4)                     ; $109040
        MOVE.B  A4,(A2)+                        ; $109042
        ORI.L  #$1110D8EC,A0                    ; $109044
        BTST    D5,D2                           ; $10904A
        DIVU    -$040B(A1),D5                   ; $10904C
        ROXR.W  -$0017(A3)                      ; $109050
        MOVE.L  (A0),D1                         ; $109054
        CMP.L  A3,D1                            ; $109056
        ASL.W  -$15(A4,A7.W)                    ; $109058
        ROR.W  D1,D0                            ; $10905C
        EXT.W   D5                              ; $10905E
        MULS    $32(A4,D3.W),D4                 ; $109060
        MOVEQ   #-$0E,D4                        ; $109064
        MOVEQ   #-$16,D4                        ; $109066
        MOVE.W  -(A2),(A1)                      ; $109068
        MOVEA.L #$0DE980CD,A5                   ; $10906A
        BSET    D4,D1                           ; $109070
        MOVE.W  D4,-$13A8(A1)                   ; $109072
        MOVE.W  (A0),(A2)                       ; $109076
        DC.W    $04F9               ; $109078 DC.W    $04F9
        OR.W   D1,D4                            ; $10907A
        DC.W    $0AAB,$2AE2,$FEB0,$EB45; $10907C EORI.L  #$2AE2FEB0,-$14BB(A3)
        ROXR.B  #4,D1                           ; $109084
        SUBA.W  $2A(A5,A7.L),A6                 ; $109086
        MOVE.W  $55(A0,D5.L),-(A2)              ; $10908A
        MOVE.W  (A5),$54F9(A4)                  ; $10908E
        DC.W    $4545               ; $109092 DC.W    $4545
        MOVE.B  -$0F00(A4),-$0C(A1,D5.W)        ; $109094
        DC.W    $1BEA,$AC09         ; $10909A MOVE.B  -$53F7(A2),<EA:3D>
        BMI.S  loc_1090CD                       ; $10909E
        BTST    D2,$22(A1,A1.W)                 ; $1090A0
        MOVE.W  $09FF(A0),D2                    ; $1090A4
        MOVE.L  -$18(A6,A7.L),(A0)+             ; $1090A8
        CMP.B  A2,D6                            ; $1090AC
        MOVE.W  D6,(A4)                         ; $1090AE
        DBCS    D0,$10F640                      ; $1090B0
        MOVE.W  -$3293(A0),-(A0)                ; $1090B4
        MOVE.W  -$17(PC,A7.L),(A1)              ; $1090B8
        OR.W   -(A4),D3                         ; $1090BC
        MOVE.W  (A1)+,$65(A1,D5.W)              ; $1090BE
        CMP.B  A6,D7                            ; $1090C2
        ADDA.L  D0,A7                           ; $1090C4
        DC.W    $0E81               ; $1090C6 DC.W    $0E81
        MOVE.B  $33(A5,D6.W),-(A4)              ; $1090C8
        MOVE.W  (A2)+,-(A6)                     ; $1090CC
        ADDQ.W  #3,(A3)                         ; $1090CE
        MOVEQ   #$19,D6                         ; $1090D0
        MOVE.L  $23(A6,D2.W),-(A2)              ; $1090D2
        MOVE.W  (A0),(A1)+                      ; $1090D6
        CMPI.B  #$0C33,-$2322(A4)               ; $1090D8
        ROL.W  D0,D0                            ; $1090DE
        MOVE.W  -$46(A3,D1.W),-(A0)             ; $1090E0
        MOVE.L  (A1),$0712(A4)                  ; $1090E4
        SUBQ.W  #1,(A4)                         ; $1090E8
        DC.W    $4351               ; $1090EA DC.W    $4351
        MOVE.B  D0,D1                           ; $1090EC
        MOVE.W  -$5F(A5,A5.L),-(A0)             ; $1090EE
        MOVE.W  D7,$5654A8F7                    ; $1090F2
        SUBQ.L  #1,$F14229FB                    ; $1090F8
        ROXR.L  D6,D2                           ; $1090FE
        MOVE.W  (A1),(A1)                       ; $109100
        AND.L  -$34(A7,A6.L),D4                 ; $109102
        MOVE.W  -$12(A4,A7.L),(A6)+             ; $109106
        MOVE.W  D2,$78(A0,D0.L)                 ; $10910A
        MOVE.B  $1126.W,(A6)+                   ; $10910E
        CLR    -$5D(A1,D2.L)                    ; $109112
        BCHG    D4,(A7)+                        ; $109116
        MOVE.B  -$01(A4,D2.W),-(A0)             ; $109118
        MOVE.W  $45(A4,D1.W),D6                 ; $10911C
        SCS     -$30(A1,D6.W)                   ; $109120
        MOVE.B  $4430(A1),(A0)+                 ; $109124
        MOVE.B  A0,D4                           ; $109128
        SUB.B  A0,D2                            ; $10912A
        AND.L  D6,-$1DAB(A6)                    ; $10912C
        ADD.W  D0,-(A3)                         ; $109130
        MOVE.L  A7,D1                           ; $109132
        MOVE.B  -(A2),(A5)                      ; $109134
        ASL.B  D4,D7                            ; $109136
        MOVE.W  -(A0),$F294.W                   ; $109138
        DC.W    $FFFE               ; $10913C MOVE.W  <EA:3E>,<EA:3F>
        MULU    (A7)+,D3                        ; $10913E
        MOVEA.L (A6),A1                         ; $109140
        EORI.W  #$DC33,-(A6)                    ; $109142
        MOVE.L  -$5BAB(A2),(A5)                 ; $109146
        MOVE.L  $4137(A7),$66(A5,D4.L)          ; $10914A
        DC.W    $2BDB               ; $109150 MOVE.L  (A3)+,<EA:3D>
        EOR.B  D5,$36(A4,A6.W)                  ; $109152
        MOVEQ   #$50,D2                         ; $109156
        MOVEA.L -(A4),A2                        ; $109158
        MOVE.W  D7,-(A7)                        ; $10915A
        MOVE.W  (A1),-$16AD(A4)                 ; $10915C
        MOVE.W  -(A1),D0                        ; $109160
        MOVE.W  -$5BBB(PC),-$78(A2,D5.W)        ; $109162
        MOVE.W  $7772(A2),$18(A7,D2.W)          ; $109168
        MOVEQ   #$32,D1                         ; $10916E
        MOVE.W  (A0)+,D1                        ; $109170
        BLS.S  loc_10918B                       ; $109172
        BSET    D5,(A5)                         ; $109174
        MOVE.B  (A2),#$296C                     ; $109176
        DC.W    $04D5               ; $10917A DC.W    $04D5
        MOVE.W  A4,(A6)+                        ; $10917C
        BCC.S  loc_109171                       ; $10917E
        DC.W    $4596               ; $109180 DC.W    $4596
        ADDQ.W  #4,(A5)                         ; $109182
        SUBQ.L  #2,D0                           ; $109184
        BGE.S  loc_109141                       ; $109186
        SUB.W  D5,(A2)                          ; $109188
        DC.W    $7DC5               ; $10918A MOVE.W  D5,<EA:3E>
loc_10918C:
        BSET    D6,-$5FF5(A4)                   ; $10918C
        DC.W    $43BC               ; $109190 DC.W    $43BC
        MOVE.W  (A4)+,(A2)                      ; $109192
        MOVE.W  -$3B(PC,D5.W),$146A(A1)         ; $109194
        MOVE.W  D4,(A2)+                        ; $10919A
        SUBI.L  #$099C9E98,A0                   ; $10919C
        MOVE.B  (A0),(A7)+                      ; $1091A2
        LSL.W  $181BB527                        ; $1091A4
        EOR.B  D5,-$44F0(A5)                    ; $1091AA
        MOVE.L  (A5)+,-$1872(A0)                ; $1091AE
        DC.W    $853D               ; $1091B2 OR.B   D2,<EA:3D>
        SUBQ.W  #5,#$3361                       ; $1091B4
        MOVE.W  (A3),$66DB(A0)                  ; $1091B8
        BSR.S  loc_1091CE                       ; $1091BC
        MOVE.W  $29(A4,D3.L),(A3)               ; $1091BE
        EOR.L  D5,(A0)                          ; $1091C2
        ROL.L  D0,D3                            ; $1091C4
        CMPA.W  -$244B(A7),A2                   ; $1091C6
        DC.W    $F0FF               ; $1091CA MOVE.W  <EA:3F>,(A0)+
        ROR.W  #$3945                           ; $1091CC
        MOVE.W  $45(PC,A3.L),-$43(A5,D6.W)      ; $1091D0
        ADD.L  D5,-(A4)                         ; $1091D6
        BNE.L  $8F778F8E                        ; $1091D8
        MOVE.W  -$45(A6,A7.L),D3                ; $1091DE
        BLS.S  loc_109251                       ; $1091E2
        ADDA.L  (A3)+,A6                        ; $1091E4
        SUBQ.W  #1,-$40BD(A5)                   ; $1091E6
        EOR.L  D2,$33(PC,A2.W)                  ; $1091EA
        DC.W    $45BB               ; $1091EE DC.W    $45BB
        MOVE.L  $23(A0,D1.W),(A2)               ; $1091F0
        MOVE.L  (A2),$62C0(PC)                  ; $1091F4
        CMPA.W  -$5C(A4,D2.W),A0                ; $1091F8
        AND.W  (A6),D0                          ; $1091FC
        EOR.W  D2,$2C68(A3)                     ; $1091FE
        ADD.L  D4,-$5C58(PC)                    ; $109202
        MOVE.B  $1936.W,(A1)                    ; $109206
        MOVE.W  -$0F(A2,D1.W),D4                ; $10920A
        OR.B   D5,D1                            ; $10920E
        MOVE.W  -$79(A5,D1.W),$66F2.W           ; $109210
        OR.W   (A0),D3                          ; $109216
        ASR.B  D4,D3                            ; $109218
        MOVE.L  (A3),-$19(A1,D2.W)              ; $10921A
        BLS.S  loc_1091F2                       ; $10921E
        ROXL.L  D4,D1                           ; $109220
        AND.L  -(A3),D3                         ; $109222
        MOVE.W  $1314.W,-$26BC(PC)              ; $109224
        ASL.W  #5,D4                            ; $10922A
        MOVE.W  D2,$44(A4,A2.L)                 ; $10922C
        NEG    -$5276(A1)                       ; $109230
        BMI.S  loc_10924A                       ; $109234
        ADD.B  D5,A6                            ; $109236
        ASL.W  D1,D4                            ; $109238
        MOVE.W  A4,(A1)                         ; $10923A
        DC.W    $0AFC               ; $10923C DC.W    $0AFC
        ADDA.L  -$46(A7,D2.L),A4                ; $10923E
        ASL.W  #$D931                           ; $109242
        AND.L  -(A1),D3                         ; $109246
        MOVE.L  -(A1),(A3)                      ; $109248
loc_10924A:
        MOVE.L  $38(A5,D2.W),(A3)+              ; $10924A
        TST    $3689.W                          ; $10924E
        LSR.L  #5,D7                            ; $109252
        BSET    D5,(A3)+                        ; $109254
        OR.W   D3,-(A6)                         ; $109256
        EOR.B  D2,-$08(A3,D4.W)                 ; $109258
        BNE.S  loc_1092C0                       ; $10925C
        ADD.W  D5,$2233(A4)                     ; $10925E
        SUBQ.B  #2,-(A2)                        ; $109262
        DC.W    $2DDD               ; $109264 MOVE.L  (A5)+,<EA:3E>
        DC.W    $0030,$BAF3,$40EE   ; $109266 ORI.B  #$BAF3,-$12(A0,D4.W)
loc_10926C:
        DC.W    $2DFD               ; $10926C MOVE.L  <EA:3D>,<EA:3E>
        DC.W    $0CFF               ; $10926E DC.W    $0CFF
        MOVE.W  -$201D(A5),$22BD(A7)            ; $109270
        BNE.S  loc_1092A3                       ; $109276
        ADDA.L  (A5)+,A6                        ; $109278
        MOVE.W  D3,(A3)+                        ; $10927A
        ASR.W  D0,D2                            ; $10927C
        ADD.L  D7,(A7)+                         ; $10927E
        MULU    (A7)+,D3                        ; $109280
        MOVE.W  A5,#$881A                       ; $109282
        ADDA.L  -$21(A5,A0.W),A6                ; $109286
        BNE.S  loc_10926C                       ; $10928A
        MOVE.W  -(A1),-$07(A0,D2.W)             ; $10928C
        BVS.S  loc_109231                       ; $109290
        MOVE.L  $2AB1(A1),-(A0)                 ; $109292
        MOVE.B  A0,(A5)+                        ; $109296
        MOVE.W  -(A4),-$45(A0,A7.W)             ; $109298
        BVC.S  loc_1092D0                       ; $10929C
        AND.B  D2,(A2)+                         ; $10929E
        MOVE.L  -(A1),-(A0)                     ; $1092A0
        CMPA.L  -(A0),A6                        ; $1092A2
        ROXL.W  (A5)+                           ; $1092A4
        DC.W    $E6FD               ; $1092A6 ROR.W  <EA:3D>
        MOVE.W  -$1C(A6,D6.L),-(A6)             ; $1092A8
        DC.W    $0EAA               ; $1092AC DC.W    $0EAA
        BSET    D7,-$75(A1,A3.L)                ; $1092AE
        SUBQ.L  #7,-$5BAC(A2)                   ; $1092B2
        AND.B  (A2)+,D6                         ; $1092B6
        LSL.L  D2,D2                            ; $1092B8
        CMP.B  $66(A6,D6.W),D3                  ; $1092BA
        MOVE.B  $17(A5,D1.W),(A6)+              ; $1092BE
        DC.W    $3BD9               ; $1092C2 MOVE.W  (A1)+,<EA:3D>
        BVS.S  loc_10924C                       ; $1092C4
        SUB.W  -$26AC(A4),D4                    ; $1092C6
        BLS.S  loc_109333                       ; $1092CA
        ROXL.W  #4,D4                           ; $1092CC
        MULS    -$2F42(A0),D2                   ; $1092CE
        MOVE.W  D0,(A0)                         ; $1092D2
        BCLR    D4,(A6)                         ; $1092D4
        MOVE.W  A1,D0                           ; $1092D6
        BSET    D5,$11(A5,D4.L)                 ; $1092D8
        MOVEA.B (A0)+,A2                        ; $1092DC
        DC.W    $45BB               ; $1092DE DC.W    $45BB
        EOR.B  D7,-$1E(A3,D4.L)                 ; $1092E0
        MOVEQ   #$66,D6                         ; $1092E4
        MULU    (A3),D4                         ; $1092E6
        ASR.B  #8,D3                            ; $1092E8
        MOVE.W  A4,(A6)                         ; $1092EA
        MOVE.W  -(A5),-$7F(A0,A5.L)             ; $1092EC
        CMP.W  (A5),D5                          ; $1092F0
        MOVE.L  $5B(PC,D3.W),$55(A5,A0.L)       ; $1092F2
        DC.W    $3BBD,$D6F1         ; $1092F8 MOVE.W  <EA:3D>,-$0F(A5,A5.W)
        EOR.B  D6,D1                            ; $1092FC
        DC.W    $F1FD,$D1AC         ; $1092FE MOVE.W  <EA:3D>,$D1AC.W
        OR.W   (A2)+,D6                         ; $109302
        MOVE.W  $6A(A5,D6.W),(A5)+              ; $109304
        DC.W    $23F0,$1BBB,$B3D3,$33B3; $109308 MOVE.L  -$45(A0,D1.L),$B3D333B3
        MOVE.B  $5466(A3),-$23(PC,A3.L)         ; $109310
        SUBQ.B  #6,D0                           ; $109316
        MOVE.W  (A5)+,$7421(PC)                 ; $109318
        ADD.L  D4,$29(A5,D7.L)                  ; $10931C
        SUBA.W  $50(A6,D0.L),A7                 ; $109320
        AND.B  -$41(A6,A4.W),D5                 ; $109324
        DC.W    $3BDC               ; $109328 MOVE.W  (A4)+,<EA:3D>
        ADD.W  -$01(A0,A4.L),D6                 ; $10932A
        MOVE.W  (A1),-(A4)                      ; $10932E
        EOR.L  D5,(A7)+                         ; $109330
        ADDQ.B  #4,-(A2)                        ; $109332
        BSET    D2,-$0D45(A3)                   ; $109334
        MOVE.L  (A7)+,(A0)+                     ; $109338
        SUBA.L  $5329996B,A4                    ; $10933A
        ADDA.W  $40(A1,A1.W),A7                 ; $109340
        MOVE.W  $56A0.W,(A1)                    ; $109344
        MOVE.L  -(A1),D2                        ; $109348
        DC.W    $A4FD               ; $10934A MOVE.L  <EA:3D>,(A2)+
        ADDA.L  -$0F(A1,A5.L),A3                ; $10934C
        MOVEA.L -$68(A0,D2.W),A5                ; $109350
        MOVE.L  (A1),-(A0)                      ; $109354
        MOVE.L  (A4)+,(A0)+                     ; $109356
        MOVE.W  #$F8AC,$65BD.W                  ; $109358
        BGT.S  loc_1093D1                       ; $10935E
        MOVE.W  -(A2),-$571F(A0)                ; $109360
        MOVEA.W -(A6),A3                        ; $109364
        NEG.W  (A7)                             ; $109366
        MOVE.W  -$1D56(A0),$43E0.W              ; $109368
        ROXR.B  D1,D3                           ; $10936E
        ASL.W  #8,D1                            ; $109370
        AND.B  A1,D6                            ; $109372
        MOVE.L  $32(A5,D3.W),D2                 ; $109374
        MOVE.W  -$1F17(A2),(A1)+                ; $109378
        LEA     D5,A2                           ; $10937C
        MULS    -(A2),D3                        ; $10937E
        OR.B   A1,D4                            ; $109380
        MOVE.W  (A4),-(A4)                      ; $109382
        MOVE.W  A2,-$28(A0,D0.L)                ; $109384
        MOVE.L  -$55C1(A2),(A0)                 ; $109388
        MULS    -$0D(A1,D2.L),D0                ; $10938C
        SUB.B  (A3),D7                          ; $109390
        DC.W    $FFC1               ; $109392 MOVE.W  D1,<EA:3F>
        MOVE.B  $61(A1,D4.L),(A0)+              ; $109394
        MOVE.B  -$30(A2,D3.W),(A4)+             ; $109398
        DC.W    $1BF2,$ABE2         ; $10939C MOVE.B  -$1E(A2,A2.L),<EA:3D>
        AND.W  D0,(A6)                          ; $1093A0
        BLS.S  loc_1093F8                       ; $1093A2
        DC.W    $04BF,$92E9,$97EA   ; $1093A4 SUBI.L  #$92E997EA,<EA:3F>
        MOVE.L  -$3E80(A7),(A7)+                ; $1093AA
        MOVE.W  -$1AD8(A1),(A4)+                ; $1093AE
        DC.W    $0A33,$A196,$28A0   ; $1093B2 EORI.B  #$A196,-$60(A3,D2.L)
        DIVS    -(A3),D6                        ; $1093B8
        MOVE.W  (A7),-(A2)                      ; $1093BA
        LSR.W  $66(A6,A5.L)                     ; $1093BC
        DC.W    $00C2               ; $1093C0 DC.W    $00C2
        CMPA.L  $8EE2.W,A2                      ; $1093C2
        ROR.B  D7,D7                            ; $1093C6
        MULU    $6332(A6),D0                    ; $1093C8
        MOVE.L  $3323(A6),(A7)+                 ; $1093CC
        MOVE.L  $00(A3,D3.W),(A4)+              ; $1093D0
        ADDQ.B  #6,-(A2)                        ; $1093D4
        LSR.W  $54(A7,A3.L)                     ; $1093D6
        SF      -$47E2(A2)                      ; $1093DA
        SUBQ.W  #3,#$7888                       ; $1093DE
        ROXL.W  A1                              ; $1093E2
        MOVE.B  A2,(A4)+                        ; $1093E4
        MOVE.W  A0,-$56(A3,A6.L)                ; $1093E6
        MOVE.L  $10(A7,D7.L),(A6)+              ; $1093EA
        MULU    -$0A(A7,A4.L),D5                ; $1093EE
        MULU    $70D3.W,D5                      ; $1093F2
        SUBQ.B  #3,A5                           ; $1093F6
loc_1093F8:
        ADDA.W  A2,A0                           ; $1093F8
        OR.W   -$04(A7,A0.W),D4                 ; $1093FA
        AND.B  -$2D(A1,A5.L),D5                 ; $1093FE
        MULS    A4,D5                           ; $109402
        MULU    A6,D5                           ; $109404
        DC.W    $0AFA               ; $109406 DC.W    $0AFA
        MOVE.W  D4,$5C(A5,A4.W)                 ; $109408
        CMPA.L  (A1)+,A5                        ; $10940C
        DC.W    $0CD2               ; $10940E DC.W    $0CD2
        DC.W    $3DD1               ; $109410 MOVE.W  (A1),<EA:3E>
        SUBQ.W  #1,-$1F(A7,D7.L)                ; $109412
        ADDQ.L  #8,D5                           ; $109416
        DC.W    $3BD7               ; $109418 MOVE.W  (A7),<EA:3D>
        SUBQ.L  #1,$7E(PC,A4.W)                 ; $10941A
        CMP.B  -$15(A0,A5.L),D5                 ; $10941E
        BCHG    D3,-$0EEB(A7)                   ; $109422
        AND.B  D0,A1                            ; $109426
        MOVE.B  -$46(A1,D5.W),-$555B(PC)        ; $109428
        SCS     -$7780(PC)                      ; $10942E
        ASL.L  D7,D5                            ; $109432
        DIVU    #$C602,D1                       ; $109434
        ASR.W  #6,D7                            ; $109438
        BLT.S  loc_1093E0                       ; $10943A
        MOVE.W  $2AE1(PC),(A3)                  ; $10943C
        MOVE.W  (A4),D6                         ; $109440
        DIVU    $5A05.W,D3                      ; $109442
        SUBA.W  $5B(A7,A2.W),A5                 ; $109446
        MOVE.W  $6A5A(A2),(A6)                  ; $10944A
        BCC.S  loc_109458                       ; $10944E
        MOVE.B  D3,D5                           ; $109450
        MOVE.L  D6,(A2)+                        ; $109452
        ROR.L  D2,D4                            ; $109454
        LSR.B  #8,D1                            ; $109456
loc_109458:
        DC.W    $7DD9               ; $109458 MOVE.W  (A1)+,<EA:3E>
        MOVE.B  -(A2),#$C1E9                    ; $10945A
        MOVE.W  -$7B24(A4),-$51(A5,D3.L)        ; $10945E
        MULS    (A0)+,D1                        ; $109464
loc_109466:
        ASL.W  $317EDF3B                        ; $109466
        MOVE.W  $3D(PC,D0.W),-(A1)              ; $10946C
        EOR.L  D5,$3D(A3,D3.W)                  ; $109470
        DC.W    $DBFF               ; $109474 ADDA.L  <EA:3F>,A5
        ADDA.L  -$423E(A1),A0                   ; $109476
        ROL.L  D0,D5                            ; $10947A
        MOVE.W  $6D53(A1),$6363(PC)             ; $10947C
        ADD.L  D6,$3B(A5,D3.W)                  ; $109482
        ASL.L  #8,D7                            ; $109486
        ADD.L  D4,-$21(PC,A5.L)                 ; $109488
        EOR.L  D5,-$41(A5,D3.W)                 ; $10948C
        ADDA.L  -$21(A7,D0.L),A5                ; $109490
        DC.W    $3DFC,$E199         ; $109494 MOVE.W  #$E199,<EA:3E>
        DC.W    $FDF9,$66FF,$CEE1   ; $109498 MOVE.W  $66FFCEE1,<EA:3E>
        MOVE.W  (A0),$33(A7,A5.W)               ; $10949E
        BLT.S  loc_1094A1                       ; $1094A2
        ADD.W  D5,(A3)                          ; $1094A4
        MOVE.W  (A7)+,(A3)                      ; $1094A6
        ADD.L  D6,(A6)+                         ; $1094A8
        MOVE.W  D3,-$7F04(A7)                   ; $1094AA
loc_1094AE:
        ADDA.L  -$05(PC,A5.L),A2                ; $1094AE
        MOVE.W  D3,(A4)+                        ; $1094B2
        MOVE.L  -$61(A3,D6.L),-$45(A0,A5.W)     ; $1094B4
        DC.W    $FFDB               ; $1094BA MOVE.W  (A3)+,<EA:3F>
        MULU    (A5)+,D1                        ; $1094BC
        ORI.L  #$FCDBDC33,D4                    ; $1094BE
        CMP.B  D6,D0                            ; $1094C4
        MOVE.B  -$2F(A6,A3.W),D4                ; $1094C6
        BNE.S  loc_109466                       ; $1094CA
        MOVEA.W -(A3),A6                        ; $1094CC
        EOR.W  D5,-(A3)                         ; $1094CE
        MOVEM.W A0,D3/D5/D6/A0/A1/A3/A4/A6      ; $1094D0
        CMP.L  D2,D5                            ; $1094D4
        ADDQ.W  #2,(A0)+                        ; $1094D6
        ADDQ.B  #2,(A2)                         ; $1094D8
        MOVE.W  (A4),$0BC1(A4)                  ; $1094DA
        MOVE.W  D0,(A4)+                        ; $1094DE
        ADDA.L  D0,A4                           ; $1094E0
        ROXL.W  #1,D5                           ; $1094E2
        ADDQ.W  #8,$08(A4,D4.L)                 ; $1094E4
        ADD.B  A2,D4                            ; $1094E8
        ASR.W  -$4836(A2)                       ; $1094EA
        BGE.S  loc_1094AE                       ; $1094EE
        ASR.W  #1,D6                            ; $1094F0
        OR.W   D7,(A5)                          ; $1094F2
        ADD.L  D2,A4                            ; $1094F4
        MOVE.L  (A1)+,-$2C28(PC)                ; $1094F6
        ADDA.L  (A0),A3                         ; $1094FA
        ADDA.L  $F809.W,A3                      ; $1094FC
        DC.W    $ADF3,$1D4D         ; $109500 MOVE.L  $4D(A3,D1.L),<EA:3E>
        MOVE.L  -(A1),-$009F(PC)                ; $109504
        CMPA.L  (A5)+,A6                        ; $109508
        NEG.W  (A5)                             ; $10950A
        CMPA.L  (A5)+,A5                        ; $10950C
        DC.W    $4553               ; $10950E DC.W    $4553
        BMI.S  loc_1094ED                       ; $109510
        MOVEA.W -$44EB(A3),A2                   ; $109512
        OR.W   (A0)+,D5                         ; $109516
        ROXR.L  #5,D2                           ; $109518
        ROL.L  #5,D0                            ; $10951A
        CMPA.L  $43E1(A6),A5                    ; $10951C
        MOVE.W  -$6B(A1,A5.W),(A1)              ; $109520
        NEG    -$458E(A6)                       ; $109524
        ADDA.L  (A3)+,A4                        ; $109528
        DC.W    $2BD1               ; $10952A MOVE.L  (A1),<EA:3D>
        DC.W    $29E9,$14E9,$0154,$DBA4; $10952C MOVE.L  $14E9(A1),#$0154DBA4
        BSET    D2,#$D1CD                       ; $109534
        MOVE.B  (A1)+,-(A4)                     ; $109538
        MOVE.L  $00(A2,D4.W),(A0)+              ; $10953A
        CMPA.W  -$25(A2,A0.W),A4                ; $10953E
        MOVE.W  -$57AE(A6),$54EE(PC)            ; $109542
        DIVU    $5D(A4,A0.L),D0                 ; $109548
        ADDA.W  (A7)+,A4                        ; $10954C
        ADD.W  D0,D0                            ; $10954E
        MOVE.W  D1,(A6)+                        ; $109550
        LEA     -(A0),A5                        ; $109552
        ADDA.L  -$58(A6,A1.L),A0                ; $109554
        MOVE.B  (A5),-(A6)                      ; $109558
        SUBQ.B  #2,(A1)                         ; $10955A
        MOVE.W  (A3)+,$14(PC,D2.W)              ; $10955C
        MOVEA.L A3,A5                           ; $109560
        ADDQ.L  #4,$544A(A2)                    ; $109562
        BGT.S  loc_109571                       ; $109566
        BLS.S  loc_109574                       ; $109568
        AND.L  -$4AA6(A3),D2                    ; $10956A
        MOVE.L  -$00E1(A2),(A5)                 ; $10956E
        SUB.B  D2,-$455D(PC)                    ; $109572
        MOVE.W  -$445B(A2),(A5)                 ; $109576
        EOR.L  D5,-$455B(PC)                    ; $10957A
        ADD.L  D5,-(A5)                         ; $10957E
        OR.B   -(A1),D3                         ; $109580
        MOVE.L  (A3)+,(A5)+                     ; $109582
        MOVE.L  -$4555(A2),(A5)+                ; $109584
        MOVE.W  -$78(PC,D0.L),D4                ; $109588
        MOVEA.W (A3),A2                         ; $10958C
        DC.W    $ABE9,$896D         ; $10958E MOVE.L  -$7693(A1),<EA:3D>
        DIVU    $3AC7(A3),D0                    ; $109592
        ADD.L  D0,-$474F(A2)                    ; $109596
        CMPA.L  A3,A5                           ; $10959A
        MOVE.W  D3,(A6)+                        ; $10959C
        MOVE.L  -$5AA5(A2),-$56(A1,A5.L)        ; $10959E
        DC.W    $3BDD               ; $1095A4 MOVE.W  (A5)+,<EA:3D>
        CMP.L  $30(A0,D7.W),D5                  ; $1095A6
        BCLR    D2,-(A4)                        ; $1095AA
        MULS    (A2)+,D0                        ; $1095AC
        MOVE.L  -(A4),(A5)                      ; $1095AE
        ROXL.B  #4,D6                           ; $1095B0
        DC.W    $D13D               ; $1095B2 ADD.B  D0,<EA:3D>
        MOVEQ   #$6C,D3                         ; $1095B4
        MOVEA.L (A3),A3                         ; $1095B6
        MOVE.W  -(A1),(A3)+                     ; $1095B8
        DC.W    $53FD               ; $1095BA SLS     <EA:3D>
        MOVE.W  (A7)+,(A6)+                     ; $1095BC
        BSET    D2,(A1)+                        ; $1095BE
        MOVE.W  (A5),-$0877(A6)                 ; $1095C0
        SUB.W  A4,D5                            ; $1095C4
        ASL.W  (A0)                             ; $1095C6
        BSR.S  loc_109626                       ; $1095C8
        MOVE.W  (A4)+,-(A0)                     ; $1095CA
        ADD.L  D5,-(A5)                         ; $1095CC
        MOVEA.L -$45(A0,D0.L),A5                ; $1095CE
        MOVE.L  -(A0),-$23(A5,A2.W)             ; $1095D2
        ADD.L  D5,$03(A1,A4.L)                  ; $1095D6
        OR.W   D1,A1                            ; $1095DA
        MOVE.L  -(A1),(A6)+                     ; $1095DC
        DC.W    $000B,$24D9         ; $1095DE ORI.B  #$24D9,A3
        SUBA.W  (A4)+,A5                        ; $1095E2
        NEG.W  D5                               ; $1095E4
        DC.W    $FDD1               ; $1095E6 MOVE.W  (A1),<EA:3E>
        MOVE.L  A2,(A4)                         ; $1095E8
        MOVE.W  (A7),(A3)+                      ; $1095EA
        DIVS    -$50(A6,D2.L),D4                ; $1095EC
        DC.W    $0E6C               ; $1095F0 DC.W    $0E6C
        MOVE.W  (A0)+,-$5C5C(A3)                ; $1095F2
        DC.W    $2FFF               ; $1095F6 MOVE.L  <EA:3F>,<EA:3F>
        MOVE.W  (A5),(A4)+                      ; $1095F8
        MOVE.B  D2,(A3)+                        ; $1095FA
        EOR.L  D0,D7                            ; $1095FC
        ADDQ.W  #2,(A0)+                        ; $1095FE
        MOVEQ   #-$34,D4                        ; $109600
        MOVE.W  D6,$18E982E1                    ; $109602
        MOVE.B  $22FEAEE6,(A1)+                 ; $109608
        MOVE.L  -(A3),-(A1)                     ; $10960E
        OR.B   $33(A2,D3.W),D4                  ; $109610
        DIVS    $35(A2,A5.L),D1                 ; $109614
        SUBQ.W  #1,A4                           ; $109618
        AND.L  -(A3),D1                         ; $10961A
        MOVE.L  (A4)+,D5                        ; $10961C
        EOR.W  D0,(A4)                          ; $10961E
        MOVE.L  (A6),$BCC5D0D9                  ; $109620
loc_109626:
        MULU    -$4017(A1),D0                   ; $109626
        OR.L   $4CF1(A2),D4                     ; $10962A
        MOVE.W  $18(PC,D0.L),(A4)+              ; $10962E
        DC.W    $0AF8               ; $109632 DC.W    $0AF8
        LSR.B  #4,D5                            ; $109634
        DC.W    $003C,$4A85,$A6CE   ; $109636 ORI.B  #$4A85,#$A6CE
        CMPI.L  #$B495FF53,A6                   ; $10963C
        MOVE.B  $06(A1,A2.W),$C33A.W            ; $109642
        MOVE.B  (A1)+,(A7)+                     ; $109648
        MOVE.L  (A1),-(A5)                      ; $10964A
        SUBQ.B  #8,A1                           ; $10964C
        ADD.L  D6,A2                            ; $10964E
        DC.W    $3BD0               ; $109650 MOVE.W  (A0),<EA:3D>
        MULS    (A5)+,D7                        ; $109652
        OR.B   D2,-$17(PC,A5.L)                 ; $109654
        MOVE.L  $545A(PC),-$56(A5,A2.L)         ; $109658
        OR.L   D6,-$0F(A0,A7.L)                 ; $10965E
        MOVE.W  -$0F(A1,A4.W),-$430F(PC)        ; $109662
        EOR.B  D1,-$0E5B(A2)                    ; $109668
        MOVE.L  A7,(A4)                         ; $10966C
        MULS    #$3C8C,D3                       ; $10966E
        MOVEQ   #-$17,D1                        ; $109672
        CMP.L  -(A4),D5                         ; $109674
        SUBQ.W  #2,(A5)+                        ; $109676
        MOVEA.L (A5),A5                         ; $109678
        MOVE.W  #$F1A6,(A6)                     ; $10967A
        MOVE.W  -(A4),-(A6)                     ; $10967E
        OR.L   $B7DD4436,D2                     ; $109680
        SVC     $0CE0(A0)                       ; $109686
        MOVE.W  A1,D4                           ; $10968A
        MOVE.W  A0,-$03(A0,A7.W)                ; $10968C
        MOVE.W  A2,-$5BB6(A7)                   ; $109690
        SUBA.W  $BF79.W,A4                      ; $109694
        DC.W    $FFFF               ; $109698 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFDF               ; $10969A MOVE.W  (A7)+,<EA:3F>
        MOVE.W  (A1)+,-$01(A7,A7.L)             ; $10969C
        SUB.L  D7,(A1)+                         ; $1096A0
        MOVE.W  -(A5),-(A7)                     ; $1096A2
        LEA     -(A0),A0                        ; $1096A4
        MOVE.W  A7,D4                           ; $1096A6
        DC.W    $ABE0               ; $1096A8 MOVE.L  -(A0),<EA:3D>
        MOVE.W  A7,D4                           ; $1096AA
        MOVEA.L $6C(A1,A6.L),A6                 ; $1096AC
        BSET    D5,-(A1)                        ; $1096B0
        ADD.W  D7,-(A0)                         ; $1096B2
        ST      -$43(A1,A5.L)                   ; $1096B4
        ADD.L  D5,$34CB(PC)                     ; $1096B8
        SUBA.L  -$37(PC,D3.W),A7                ; $1096BC
        DC.W    $FDD1               ; $1096C0 MOVE.W  (A1),<EA:3E>
        DC.W    $02FA               ; $1096C2 DC.W    $02FA
        ADDA.W  -(A5),A1                        ; $1096C4
        MOVE.L  (A2),(A1)+                      ; $1096C6
        MOVE.W  $3A(A5,A6.W),$01(A1,D6.W)       ; $1096C8
        MOVE.W  $39(A2,A2.L),-(A7)              ; $1096CE
        ADD.B  D0,-(A6)                         ; $1096D2
        SUBQ.L  #6,A3                           ; $1096D4
        DC.W    $06DD               ; $1096D6 DC.W    $06DD
        MOVE.L  $4E(A5,D4.L),D5                 ; $1096D8
        AND.L  D4,$4A(PC,A4.L)                  ; $1096DC
        DC.W    $0AF2               ; $1096E0 DC.W    $0AF2
        DC.W    $038C               ; $1096E2 BCLR    D1,A4
        MOVE.L  -$04(PC,A5.L),(A0)              ; $1096E4
        CMPA.L  (A5)+,A4                        ; $1096E8
        ADD.B  D5,D5                            ; $1096EA
        DC.W    $04F5               ; $1096EC DC.W    $04F5
        ADDA.L  -(A4),A5                        ; $1096EE
        MOVE.W  A0,-$3A2F(PC)                   ; $1096F0
        NEGX.B D0                               ; $1096F4
        ADD.W  (A7)+,D6                         ; $1096F6
        ASL.W  -(A7)                            ; $1096F8
        CMPI.B  #$DDDB,(A0)                     ; $1096FA
        DC.W    $FFDB               ; $1096FE MOVE.W  (A3)+,<EA:3F>
        ADD.B  D5,D0                            ; $109700
        MOVE.B  D1,(A4)+                        ; $109702
        DC.W    $C3FE               ; $109704 MULS    <EA:3E>,D1
        MOVE.L  (A5),-(A5)                      ; $109706
loc_109708:
        BSET    D0,D4                           ; $109708
        MOVE.W  (A1)+,-$3F(PC,A6.W)             ; $10970A
        DC.W    $3CFD               ; $10970E MOVE.W  <EA:3D>,(A6)+
        DC.W    $4955               ; $109710 DC.W    $4955
        MOVE.W  #$202D,(A2)+                    ; $109712
        BVC.S  loc_109708                       ; $109716
        DC.W    $0CFF               ; $109718 DC.W    $0CFF
        MOVE.W  A3,D4                           ; $10971A
        OR.L   D0,(A0)                          ; $10971C
        MOVE.B  D0,(A5)                         ; $10971E
        SUBA.W  A1,A1                           ; $109720
        MOVE.L  $14(A3,A1.L),-(A5)              ; $109722
        ROR.L  D5,D3                            ; $109726
        MOVE.L  (A1),-(A0)                      ; $109728
        MOVE.W  A0,-$61(PC,A0.W)                ; $10972A
        LSL.W  $0A2A.W                          ; $10972E
        MOVE.L  $61(A3,A5.W),-$656B(A4)         ; $109732
        MOVE.L  -$07EE(A1),(A1)                 ; $109738
        AND.W  -$02(A4,A6.L),D0                 ; $10973C
        SUB.L  $4C(PC,D5.W),D5                  ; $109740
        MOVE.L  A0,$7804.W                      ; $109744
        ADD.W  D0,$7864.W                       ; $109748
        MOVE.L  D7,$7C(A4,D7.L)                 ; $10974C
        MOVE.B  -(A1),(A7)                      ; $109750
        DC.W    $04D2               ; $109752 DC.W    $04D2
        MOVE.L  -$3066(A2),-$04(A6,A7.L)        ; $109754
        ROR.W  #7,D2                            ; $10975A
        MOVE.L  D0,(A2)+                        ; $10975C
        SUB.L  (A7)+,D1                         ; $10975E
        SUB.B  D0,#$EC82                        ; $109760
        OR.L   D5,$0A36(A2)                     ; $109764
        MOVE.L  -$7E(A1,A4.L),(A1)+             ; $109768
        MOVE.W  (A4),D4                         ; $10976C
        ROXL.L  #1,D2                           ; $10976E
        MOVE.B  $13E9(A5),-$2D67(PC)            ; $109770
        DC.W    $4557               ; $109776 DC.W    $4557
        MOVE.L  $1BA3.W,-$5A5C(A4)              ; $109778
        MOVE.W  A1,D4                           ; $10977E
        MULU    $0D89(A4),D6                    ; $109780
        MOVE.W  -(A1),$58(A6,D1.W)              ; $109784
        BVS.S  loc_109723                       ; $109788
        ADD.L  -(A4),D5                         ; $10978A
        DC.W    $E9FD               ; $10978C ASL.W  <EA:3D>
        ADD.W  #$D7FC,D7                        ; $10978E
        MOVE.B  -(A3),-(A2)                     ; $109792
        ADD.L  D0,(A7)+                         ; $109794
        ADDA.W  -$01(A0,D1.L),A4                ; $109796
        MOVE.W  (A3)+,D4                        ; $10979A
        OR.L   D1,A0                            ; $10979C
        SUB.L  D2,D7                            ; $10979E
        BSR.S  loc_10973B                       ; $1097A0
        MOVEA.W -(A0),A7                        ; $1097A2
        SUB.L  D4,D1                            ; $1097A4
        MOVE.L  $1881.W,$6419(A4)               ; $1097A6
        MULS    $88AC.W,D4                      ; $1097AC
        OR.B   D0,-$3C(A0,A1.W)                 ; $1097B0
        MOVE.W  (A1)+,(A6)                      ; $1097B4
        NEG    A2                               ; $1097B6
        SUBA.W  $0BA9.W,A4                      ; $1097B8
        ADD.L  D2,A2                            ; $1097BC
        MOVE.W  -$3988(A2),-$0E(A3,A3.W)        ; $1097BE
        DC.W    $0F8A               ; $1097C4 BCLR    D7,A2
        DIVU    -$75(A4,A3.L),D3                ; $1097C6
        DC.W    $D9FE               ; $1097CA ADDA.L  <EA:3E>,A4
        MOVE.B  $0A00(A4),D4                    ; $1097CC
        MULU    (A4),D7                         ; $1097D0
        SUBA.W  (A0),A1                         ; $1097D2
        DIVU    -$76(A7,A5.L),D6                ; $1097D4
        MOVE.L  #$9D91199B,(A0)+                ; $1097D8
        MULU    -$6E(A5,A5.W),D2                ; $1097DE
        MOVE.L  $3481(A2),(A6)                  ; $1097E2
        MOVE.W  (A0),(A4)                       ; $1097E6
        MOVE.W  (A4),(A7)+                      ; $1097E8
        AND.W  D1,(A0)                          ; $1097EA
        OR.W   -$65(A3,A7.W),D1                 ; $1097EC
        OR.B   (A2)+,D0                         ; $1097F0
        NEG.B  D4                               ; $1097F2
        MOVE.B  -$7A(A7,A0.W),(A2)+             ; $1097F4
        ADDQ.B  #4,$288C(A0)                    ; $1097F8
        CMP.W  $36(A0,A0.L),D1                  ; $1097FC
        DIVU    D6,D2                           ; $109800
        DC.W    $7FF0,$0BA9         ; $109802 MOVE.W  -$57(A0,D0.L),<EA:3F>
        LSR.W  (A4)+                            ; $109806
        AND.W  D1,-$6E6E(PC)                    ; $109808
        DC.W    $2DF1,$9799         ; $10980C MOVE.L  -$67(A1,A1.W),<EA:3E>
        MOVE.L  (A1),-$6D(A5,A1.L)              ; $109810
        DC.W    $ECFF               ; $109814 ROXR.W  <EA:3F>
        SNE     $22CC(A4)                       ; $109816
        MULU    A6,D7                           ; $10981A
        MOVEA.W -(A6),A1                        ; $10981C
        ROR.W  -$2147(A6)                       ; $10981E
        ROR.W  #$CA9C                           ; $109822
        ROXL.L  D5,D5                           ; $109826
        MOVEA.L (A4)+,A5                        ; $109828
        ADD.L  $14(A3,A7.W),D6                  ; $10982A
        MOVE.B  (A1),(A7)                       ; $10982E
        OR.B   D3,A2                            ; $109830
        MOVEA.W (A5),A1                         ; $109832
        MOVEQ   #-$60,D5                        ; $109834
        MOVE.W  (A4),D0                         ; $109836
        MOVE.W  A3,(A1)                         ; $109838
        MOVE.L  -$0D15(A2),(A2)                 ; $10983A
        OR.L   D4,D3                            ; $10983E
        MOVEQ   #-$40,D6                        ; $109840
        MOVE.W  A3,D4                           ; $109842
        MULU    -$10(A4,A4.L),D2                ; $109844
        DC.W    $0BFF               ; $109848 BSET    D5,<EA:3F>
        MOVE.W  A4,D4                           ; $10984A
        CMP.W  (A0),D5                          ; $10984C
        MOVE.L  (A6)+,(A4)                      ; $10984E
        MOVE.B  -$66(PC,D7.L),$63(A7,D6.W)      ; $109850
        DBGT    D1,loc_108ABE                   ; $109856
        CMPA.W  D1,A6                           ; $10985A
        DC.W    $00E3               ; $10985C DC.W    $00E3
        DC.W    $F5FF,$FCEA         ; $10985E MOVE.W  <EA:3F>,-$0316(PC)
        MOVE.W  #$DDAF,(A6)+                    ; $109862
        MOVEQ   #-$07,D7                        ; $109866
        DC.W    $9FFD               ; $109868 SUBA.L  <EA:3D>,A7
        CMPA.L  (A7)+,A6                        ; $10986A
        OR.L   -$1F(A1,D0.W),D5                 ; $10986C
        SUBA.L  -(A1),A2                        ; $109870
        EOR.B  D5,$35(PC,A2.W)                  ; $109872
        MOVEA.W (A5),A5                         ; $109876
        ADD.L  D2,(A6)+                         ; $109878
        MULS    -(A0),D0                        ; $10987A
        CMP.L  -(A1),D1                         ; $10987C
        EOR.B  D0,D1                            ; $10987E
        MULU    A0,D1                           ; $109880
        MULS    -(A0),D0                        ; $109882
        ADD.L  (A0)+,D3                         ; $109884
        MULU    -(A5),D1                        ; $109886
        DC.W    $D5BD               ; $109888 ADD.L  D2,<EA:3D>
        MOVEA.L (A3),A5                         ; $10988A
        DC.W    $32FE               ; $10988C MOVE.W  <EA:3E>,(A1)+
        MOVE.L  -$47(A3,D3.W),-(A4)             ; $10988E
        MOVEM.L D0/D1/D4/D5/D7/A1/A2/A3/A5/A7,A3; $109892
        MOVE.W  (A5),(A4)+                      ; $109896
        SUB.W  -$025D(A2),D1                    ; $109898
        DC.W    $00B2,$3334,$E155,$3D9D; $10989C ORI.L  #$3334E155,-$63(A2,D3.L)
        MOVE.W  $66(A3,D5.W),-$06(A1,A6.W)      ; $1098A4
        LEA     (A0)+,A0                        ; $1098AA
        ADDA.W  (A0)+,A5                        ; $1098AC
        ADD.B  A1,D0                            ; $1098AE
        DC.W    $0AD1               ; $1098B0 DC.W    $0AD1
        ADDA.L  (A3)+,A6                        ; $1098B2
        MOVE.L  -$1E(A3,A5.L),-(A1)             ; $1098B4
        MOVE.L  -$4F(A3,A5.W),(A4)              ; $1098B8
        MOVE.L  A2,(A2)+                        ; $1098BC
        MULS    #$A5D2,D2                       ; $1098BE
        MOVEQ   #-$44,D6                        ; $1098C2
        MOVEA.W -(A5),A3                        ; $1098C4
        NEGX.B $5A(A6,A0.L)                     ; $1098C6
        DC.W    $49B1               ; $1098CA DC.W    $49B1
        BLE.S  loc_10989F                       ; $1098CC
        ADDA.L  D3,A3                           ; $1098CE
        MOVEQ   #$00,D3                         ; $1098D0
        ADDA.W  $54(A7,A4.L),A1                 ; $1098D2
        DC.W    $04D6               ; $1098D6 DC.W    $04D6
        MOVE.W  -$0800(A2),(A1)                 ; $1098D8
        ADD.W  $FFFC.W,D3                       ; $1098DC
        MULU    D4,D5                           ; $1098E0
        MOVE.W  D0,(A1)                         ; $1098E2
        MOVE.W  (A0),-(A2)                      ; $1098E4
        MOVE.L  A3,(A6)+                        ; $1098E6
        MOVE.W  -$27(A3,A5.L),(A4)              ; $1098E8
        ADDA.W  (A1)+,A0                        ; $1098EC
        SUBQ.W  #2,D0                           ; $1098EE
        DC.W    $04FC               ; $1098F0 DC.W    $04FC
        MOVEA.W (A5)+,A4                        ; $1098F2
        MOVE.W  #$5B58,(A0)+                    ; $1098F4
        SUBQ.L  #6,(A1)+                        ; $1098F8
        DC.W    $4C45               ; $1098FA DC.W    $4C45
        MOVE.W  (A4),-$0F1F(A0)                 ; $1098FC
        ROXL.W  A4                              ; $109900
        AND.L  $3C(A5,A5.L),D6                  ; $109902
        MOVE.W  #$444E,(A2)+                    ; $109906
        CMPA.W  #$4C1F,A5                       ; $10990A
        MULS    -$0260(A6),D4                   ; $10990E
        AND.L  $50(PC,A7.L),D3                  ; $109912
        OR.W   A4,D1                            ; $109916
        DC.W    $E3FF               ; $109918 LSL.W  <EA:3F>
        DC.W    $FDCE               ; $10991A MOVE.W  A6,<EA:3E>
        MOVE.W  $08EC(A0),-(A7)                 ; $10991C
        MOVE.W  A5,-(A7)                        ; $109920
        DC.W    $8CFF               ; $109922 DIVU    <EA:3F>,D6
        DC.W    $00F0               ; $109924 DC.W    $00F0
        DC.W    $0000,$0000         ; $109926 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $10992A ORI.B  #$0000,D0
        DC.W    $FDFF               ; $10992E MOVE.W  <EA:3F>,<EA:3E>
        DC.W    $22FF               ; $109930 MOVE.L  <EA:3F>,(A1)+
        MOVE.W  -(A7),D4                        ; $109932
        OR.B   -(A2),D4                         ; $109934
        OR.B   D7,$666F(A0)                     ; $109936
        MOVE.W  -(A6),-(A7)                     ; $10993A
        SUB.L  D4,(A6)                          ; $10993C
        MOVE.W  A1,(A4)                         ; $10993E
        MOVE.W  -$47(A3,A3.W),-$0795(A7)        ; $109940
        EOR.W  D5,-$65(PC,D6.L)                 ; $109946
        MOVE.W  -$1C(PC,A3.L),-$08(A3,A6.L)     ; $10994A
        DC.W    $0FFF               ; $109950 BSET    D7,<EA:3F>
        MOVE.L  (A0)+,-$62(A4,A1.L)             ; $109952
        MOVE.L  $5AA9(A0),-$01(A2,A3.W)         ; $109956
        LEA     #$5BB55A55,A1                   ; $10995C
        MOVE.L  $5A5A(A2),-$56(A4,A2.L)         ; $109962
        MOVE.W  $3316(A3),-$02(A7,A4.W)         ; $109968
        ROR.L  D1,D5                            ; $10996E
        MOVE.W  D2,(A6)                         ; $109970
        MOVE.W  $0D63.W,(A6)+                   ; $109972
loc_109976:
        DC.W    $8CFF               ; $109976 DIVU    <EA:3F>,D6
        MOVE.L  #$26FC8931,(A4)+                ; $109978
        MULU    #$67FC,D3                       ; $10997E
        SUBA.L  -$4413(A5),A3                   ; $109982
        DC.W    $F0FF               ; $109986 MOVE.W  <EA:3F>,(A0)+
        CMPA.L  $69774735,A3                    ; $109988
        EOR.W  D4,$4B55(A7)                     ; $10998E
        EOR.L  D4,A0                            ; $109992
loc_109994:
        DC.W    $47FF               ; $109994 LEA     <EA:3F>,A3
        MOVE.W  -$7F(A5,A3.L),$7555(A7)         ; $109996
        MOVE.W  $4555(A6),$5AC1(A5)             ; $10999C
        MOVE.W  (A7),$7B61(A3)                  ; $1099A2
        DC.W    $FCFF               ; $1099A6 MOVE.W  <EA:3F>,(A6)+
        MOVEA.W (A3)+,A2                        ; $1099A8
        OR.W   (A5),D3                          ; $1099AA
        MOVE.W  $68(A4,A2.L),-$25B6(A2)         ; $1099AC
        LEA     $4A(A1,A6.L),A5                 ; $1099B2
        DC.W    $FFFF               ; $1099B6 MOVE.W  <EA:3F>,<EA:3F>
        MOVEQ   #-$71,D2                        ; $1099B8
        MOVE.W  (A7),-(A0)                      ; $1099BA
        DC.W    $77BE,$FF88         ; $1099BC MOVE.W  <EA:3E>,-$78(A3,A7.L)
        MOVE.L  A0,(A5)                         ; $1099C0
        MOVE.B  D3,-$12(A7,A3.W)                ; $1099C2
        BCC.S  loc_109994                       ; $1099C6
        DC.W    $FFFF               ; $1099C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $43B8               ; $1099CA DC.W    $43B8
        MOVEA.W -$72(A4,D4.W),A5                ; $1099CC
        BVC.S  loc_109976                       ; $1099D0
        NEG    -(A7)                            ; $1099D2
        BEQ.S  loc_109A4E                       ; $1099D4
        AND.L  -$7886(PC),D4                    ; $1099D6
        DC.W    $FFFF               ; $1099DA MOVE.W  <EA:3F>,<EA:3F>
        MULU    D6,D4                           ; $1099DC
        AND.W  D3,-$778F(PC)                    ; $1099DE
        EOR.W  D5,D6                            ; $1099E2
        OR.L   $747BBB55,D4                     ; $1099E4
        SUBQ.W  #3,(A7)                         ; $1099EA
        MOVE.W  $45(A4,D4.L),-(A7)              ; $1099EC
        SUBQ.W  #3,$45(A5,D5.L)                 ; $1099F0
        MOVE.W  (A7),$7C7F(A2)                  ; $1099F4
        DC.W    $1FF2,$E2C3         ; $1099F8 MOVE.B  -$3D(A2,A6.W),<EA:3F>
        MOVE.W  -$0F(PC,D1.L),(A6)+             ; $1099FC
        MOVE.W  D6,-$0708(A1)                   ; $109A00
        BCLR    D3,D4                           ; $109A04
        CMP.B  (A7)+,D4                         ; $109A06
        DC.W    $FFFF               ; $109A08 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  #$FD45,-$3F0F(PC)               ; $109A0A
        DC.W    $F1F9,$F00F,$D5D8,$FC08; $109A10 MOVE.W  $F00FD5D8,$FC08.W
        DC.W    $4EFF               ; $109A18 JMP     <EA:3F>
        MOVE.W  -(A0),-$10(PC,A5.W)             ; $109A1A
        MOVE.B  $71(PC,A6.L),-$04(A4,D0.L)      ; $109A1E
        LSR.B  #1,D1                            ; $109A24
        MOVE.W  -$03(A7,A7.L),$57FC(A2)         ; $109A26
        MOVE.W  D1,-(A6)                        ; $109A2C
        MULU    $3E(A4,D2.W),D1                 ; $109A2E
        MOVEA.W (A7),A6                         ; $109A32
        DC.W    $F877,$E17F         ; $109A34 MOVEA.W $7F(A7,A6.W),A4
        SUBQ.W  #2,-$59(A7,A7.W)                ; $109A38
        TST.W  (A5)                             ; $109A3C
        ADDQ.W  #2,(A4)                         ; $109A3E
        MOVEA.L (A5),A2                         ; $109A40
        SUBQ.W  #2,(A0)+                        ; $109A42
        DC.W    $3BF8,$87F2         ; $109A44 MOVE.W  $87F2.W,<EA:3D>
        BCC.S  loc_109A01                       ; $109A48
        SUBQ.W  #3,$57(A4,A4.W)                 ; $109A4A
loc_109A4E:
        SUBQ.W  #2,D4                           ; $109A4E
        ASL.B  D4,D3                            ; $109A50
        MOVEA.W (A5),A6                         ; $109A52
        DC.W    $4774               ; $109A54 DC.W    $4774
        ROXR.W  #$8BBC                          ; $109A56
        SUB.W  D3,-$1F(A7,A4.L)                 ; $109A5A
        MOVE.W  -$0C(A6,D6.W),D0                ; $109A5E
        MOVE.W  A2,-$580F(A3)                   ; $109A62
        CMP.W  D7,D3                            ; $109A66
        DC.W    $0CC3               ; $109A68 DC.W    $0CC3
        AND.L  (A4),D1                          ; $109A6A
        MOVEQ   #-$3A,D2                        ; $109A6C
        EOR.W  D3,-(A6)                         ; $109A6E
        LSR.W  #2,D3                            ; $109A70
        DC.W    $C3FF               ; $109A72 MULS    <EA:3F>,D1
        MOVEA.L -$14(A7,D7.W),A2                ; $109A74
        SUB.W  D5,D4                            ; $109A78
        CMP.L  (A3),D2                          ; $109A7A
        MOVE.W  A3,$4B39(A4)                    ; $109A7C
        DC.W    $BBFF               ; $109A80 CMPA.L  <EA:3F>,A5
        MOVE.W  -$43(A4,A3.L),-$34(A7,A3.L)     ; $109A82
        DC.W    $BB3D               ; $109A88 EOR.B  D5,<EA:3D>
        SUBA.W  (A3),A2                         ; $109A8A
        DC.W    $BB3E               ; $109A8C EOR.B  D5,<EA:3E>
        SUB.B  D5,#$BB9E                        ; $109A8E
        DC.W    $343F               ; $109A92 MOVE.W  <EA:3F>,D2
        DC.W    $223D               ; $109A94 MOVE.L  <EA:3D>,D1
        CMPA.L  -(A1),A1                        ; $109A96
        ADD.L  D5,(A4)+                         ; $109A98
        MOVE.L  (A0)+,(A3)                      ; $109A9A
        MOVE.W  $08(A7,A6.W),-(A5)              ; $109A9C
        MOVE.W  #$8F11,(A1)+                    ; $109AA0
        MOVE.W  D1,D2                           ; $109AA4
        DC.W    $1FFC,$FEF4         ; $109AA6 MOVE.B  #$FEF4,<EA:3F>
        MOVE.W  (A1),-(A3)                      ; $109AAA
        DC.W    $1FFE               ; $109AAC MOVE.B  <EA:3E>,<EA:3F>
        ASL.B  #7,D2                            ; $109AAE
        DC.W    $02EC               ; $109AB0 DC.W    $02EC
        ROR.W  $3CF9(PC)                        ; $109AB2
        DC.W    $0CC3               ; $109AB6 DC.W    $0CC3
        DC.W    $33FF,$EFF8,$FEFE   ; $109AB8 MOVE.W  <EA:3F>,$EFF8FEFE
        MOVE.W  $0007(A7),(A4)+                 ; $109ABE
        ROL.W  -$0211(A7)                       ; $109AC2
        MOVE.W  -$0CE8(A6),(A1)+                ; $109AC6
        MOVE.W  (A6),$EEEE.W                    ; $109ACA
        DC.W    $EAFF               ; $109ACE LSR.W  <EA:3F>
        MOVE.L  #$FF3722E9,(A7)+                ; $109AD0
        SUB.B  D4,(A2)                          ; $109AD6
        MOVE.L  (A3)+,(A7)                      ; $109AD8
        MOVE.L  D1,-$5B(A5,D2.L)                ; $109ADA
        ADDQ.W  #5,-$1581(A0)                   ; $109ADE
        MOVE.W  (A5),$5AB8(A5)                  ; $109AE2
        SUB.W  (A2)+,D5                         ; $109AE6
        ADDQ.L  #5,$20(A6,A2.W)                 ; $109AE8
        MOVE.W  -$08(A3,A7.L),-(A0)             ; $109AEC
        MOVE.W  -$40(A2,D3.W),D3                ; $109AF0
        MULU    #$A723,D1                       ; $109AF4
        MOVE.L  -(A0),$0D(A1,A6.L)              ; $109AF8
        BVC.S  loc_109B24                       ; $109AFC
        BLT.S  loc_109A87                       ; $109AFE
        DC.W    $997F               ; $109B00 SUB.W  D4,<EA:3F>
        MOVE.L  -$4860(A1),(A0)+                ; $109B02
        LSR.W  $A0EA.W                          ; $109B06
        DC.W    $4B88               ; $109B0A DC.W    $4B88
        MOVEQ   #-$08,D6                        ; $109B0C
        AND.L  D1,(A5)+                         ; $109B0E
        MOVE.W  -$72(A6,D1.L),D6                ; $109B10
        OR.L   D7,(A6)                          ; $109B14
        MOVEA.B (A0),A4                         ; $109B16
        DC.W    $AEFF               ; $109B18 MOVE.L  <EA:3F>,(A7)+
        MOVE.W  D1,$18(A7,A0.L)                 ; $109B1A
        CMPA.L  -(A1),A4                        ; $109B1E
        LSR.L  #7,D0                            ; $109B20
        MOVE.W  $1E(A1,A0.W),(A3)               ; $109B22
        DC.W    $99BE               ; $109B26 SUB.L  D4,<EA:3E>
        OR.L   D1,D4                            ; $109B28
        DC.W    $F7FF,$18E6         ; $109B2A MOVE.W  <EA:3F>,-$1A(PC,D1.L)
        MOVE.W  (A7)+,-(A0)                     ; $109B2E
        MOVE.W  D1,(A2)+                        ; $109B30
        DC.W    $77FF,$1CC5         ; $109B32 MOVE.W  <EA:3F>,-$3B(PC,D1.L)
        MOVE.W  D1,(A6)+                        ; $109B36
        MOVE.B  D2,(A1)+                        ; $109B38
        MOVE.B  #$130A,$1F(PC,D3.L)             ; $109B3A
        DC.W    $F0FF               ; $109B40 MOVE.W  <EA:3F>,(A0)+
        MOVE.B  (A5)+,(A3)+                     ; $109B42
        DC.W    $FFE8,$EABA         ; $109B44 MOVE.W  -$1546(A0),<EA:3F>
        TST.L  A0                               ; $109B48
        ADD.L  D5,$1E(PC,A3.L)                  ; $109B4A
        DC.W    $E9FF               ; $109B4E ASL.W  <EA:3F>
        MOVE.W  -(A3),$1E(A7,A3.L)              ; $109B50
        SUB.L  D5,-$457F(A5)                    ; $109B54
        SUB.L  D5,(A1)+                         ; $109B58
        SUB.L  D1,D5                            ; $109B5A
        OR.L   D5,(A5)+                         ; $109B5C
        SUB.B  D5,(A1)                          ; $109B5E
        DC.W    $EEFF               ; $109B60 ROR.W  <EA:3F>
        MOVE.W  (A3)+,-$7F(A7,A4.L)             ; $109B62
        DIVS    -$1426(A0),D0                   ; $109B66
        SUB.L  D6,$A393.W                       ; $109B6A
        SUB.L  -$45(A6,A2.L),D7                 ; $109B6E
        DC.W    $CEFF               ; $109B72 MULU    <EA:3F>,D7
        MOVE.W  #$BBD9,-(A7)                    ; $109B74
        MOVE.W  -$4C3D(A3),(A7)+                ; $109B78
        SUBA.W  (A3)+,A7                        ; $109B7C
        TST.B  -$23(A3,A1.L)                    ; $109B7E
        DC.W    $4BBB               ; $109B82 DC.W    $4BBB
        DC.W    $9DFF               ; $109B84 SUBA.L  <EA:3F>,A6
        DC.W    $FFD3               ; $109B86 MOVE.W  (A3),<EA:3F>
        EOR.L  D5,$3DEB(A2)                     ; $109B88
        MOVE.L  D7,$7738(A5)                    ; $109B8C
        ASL.L  D1,D4                            ; $109B90
        MOVE.W  -$4C(A3,A6.W),-(A3)             ; $109B92
        DC.W    $77FF,$FFAC         ; $109B96 MOVE.W  <EA:3F>,-$54(PC,A7.L)
        ADD.L  D1,$48(A4,D4.W)                  ; $109B9A
        ADD.W  D1,A3                            ; $109B9E
        MOVE.W  A3,-$7626(A3)                   ; $109BA0
        DC.W    $455A               ; $109BA4 DC.W    $455A
        OR.W   D4,$3F(A7,D4.W)                  ; $109BA6
        AND.W  $44(A7,A0.L),D0                  ; $109BAA
        NEG.W  $11(A4,A2.L)                     ; $109BAE
        EOR.L  D3,$FE00FFEE                     ; $109BB2
        MOVE.W  $1E11.W,#$F18E                  ; $109BB8
        MOVE.B  (A7)+,D7                        ; $109BBE
        MOVEA.W -$12(A0,D2.W),A4                ; $109BC0
        MOVE.W  (A6)+,-(A1)                     ; $109BC4
        LSR.L  #4,D6                            ; $109BC6
        MOVE.W  $4F04.W,(A6)+                   ; $109BC8
        ROL.W  -(A1)                            ; $109BCC
        ROR.W  (A6)+                            ; $109BCE
        ADDA.L  -$3D(PC,A7.L),A6                ; $109BD0
        DC.W    $00F1               ; $109BD4 DC.W    $00F1
        ADDA.L  (A5)+,A6                        ; $109BD6
        LEA     -$2104(A5),A2                   ; $109BD8
        SUBI.W  #$F3F8,-(A0)                    ; $109BDC
        MOVE.W  -$0A(A0,A7.W),#$C32C            ; $109BE0
        DIVS    #$CCFC,D3                       ; $109BE6
        MOVE.W  (A2),D4                         ; $109BEA
        MOVE.W  -(A2),-(A7)                     ; $109BEC
        MOVE.W  D5,-(A6)                        ; $109BEE
        MOVE.W  -(A3),-(A0)                     ; $109BF0
        MOVE.L  A7,(A1)+                        ; $109BF2
        MOVE.W  -$5D10(PC),$27FD.W              ; $109BF4
        MOVEA.L (A4)+,A1                        ; $109BFA
        CLR    A6                               ; $109BFC
        MOVE.W  (A2),D1                         ; $109BFE
        MOVE.B  (A6)+,(A1)+                     ; $109C00
        MOVE.W  (A7),D4                         ; $109C02
        CMP.L  $4000(A1),D3                     ; $109C04
        DC.W    $F8FF               ; $109C08 MOVE.W  <EA:3F>,(A4)+
        DC.W    $D8FF               ; $109C0A ADDA.W  <EA:3F>,A4
        BSET    D0,-(A2)                        ; $109C0C
        MOVE.W  -$01(A6,A4.L),#$21FF            ; $109C0E
        MOVE.B  $44(A0,D0.W),$2E44.W            ; $109C14
        DC.W    $4541               ; $109C1A DC.W    $4541
        MOVE.B  -(A2),-(A0)                     ; $109C1C
        MOVE.W  D1,-$15(A2,A5.W)                ; $109C1E
        MOVE.W  -(A6),#$E0F8                    ; $109C22
        DC.W    $0CFF               ; $109C26 DC.W    $0CFF
        DC.W    $FDC0               ; $109C28 MOVE.W  D0,<EA:3E>
        MOVE.W  A2,D4                           ; $109C2A
        OR.B   -$04(A1,D2.L),D2                 ; $109C2C
        ROL.B  #8,D5                            ; $109C30
        LSL.B  D0,D5                            ; $109C32
        DC.W    $A6BF               ; $109C34 MOVE.L  <EA:3F>,(A3)
        ROL.B  #2,D5                            ; $109C36
        MOVEA.W D7,A6                           ; $109C38
        MOVE.W  (A7),-$70B5(A2)                 ; $109C3A
        SUBQ.W  #2,(A7)                         ; $109C3E
        SLT     -$1F(A4,D4.W)                   ; $109C40
        ADDQ.W  #2,D0                           ; $109C44
        ROXL.W  D0,D7                           ; $109C46
        OR.W   D0,D7                            ; $109C48
        ROXL.W  -$1C(A4,D4.W)                   ; $109C4A
        MOVEA.L -(A6),A5                        ; $109C4E
        DC.W    $FFFF               ; $109C50 MOVE.W  <EA:3F>,<EA:3F>
        OR.L   D1,D4                            ; $109C52
        MOVE.L  -$7E78(A5),-$53(A3,A2.W)        ; $109C54
        OR.W   $7446(A5),D4                     ; $109C5A
        OR.W   -$5553(A3),D4                    ; $109C5E
        DC.W    $FFFF               ; $109C62 MOVE.W  <EA:3F>,<EA:3F>
        OR.L   D4,(A2)+                         ; $109C64
        MOVEQ   #-$43,D5                        ; $109C66
        ADDA.L  A3,A4                           ; $109C68
        DC.W    $43B3               ; $109C6A DC.W    $43B3
        OR.W   D6,-$5645(A3)                    ; $109C6C
        ROXR.L  #7,D4                           ; $109C70
        OR.B   D0,(A1)                          ; $109C72
        DC.W    $C3FF               ; $109C74 MULS    <EA:3F>,D1
        LSL.L  #8,D0                            ; $109C76
        DIVU    -(A1),D7                        ; $109C78
        OR.B   D0,(A0)+                         ; $109C7A
        MOVE.B  A5,(A4)                         ; $109C7C
        BVC.S  loc_109C98                       ; $109C7E
        DIVU    (A3)+,D4                        ; $109C80
        BVC.S  loc_109D03                       ; $109C82
        MOVE.W  (A1),D4                         ; $109C84
        OR.L   (A2)+,D4                         ; $109C86
        SUB.B  D4,(A1)                          ; $109C88
        OR.B   -$10(PC,A4.L),D7                 ; $109C8A
        MOVE.W  $1E8E(A5),$7F80(A5)             ; $109C8E
        CMP.L  (A6)+,D2                         ; $109C94
        OR.B   D0,(A6)+                         ; $109C96
loc_109C98:
        MOVE.B  (A5)+,(A4)+                     ; $109C98
        MOVE.B  (A1),D4                         ; $109C9A
        MOVE.W  (A5)+,(A3)+                     ; $109C9C
        MULS    -$73(A0,A6.L),D1                ; $109C9E
        MOVE.B  (A3),$EEE8.W                    ; $109CA2
        MOVE.W  -$7778(A1),(A6)+                ; $109CA6
        BSET    D0,D2                           ; $109CAA
        MOVE.B  (A1)+,D4                        ; $109CAC
        DC.W    $FDFE               ; $109CAE MOVE.W  <EA:3E>,<EA:3E>
        ASR.W  D4                               ; $109CB0
        DC.W    $1EFF               ; $109CB2 MOVE.B  <EA:3F>,(A7)+
        MOVE.W  (A3)+,$4A(A7,A3.W)              ; $109CB4
        ADD.L  D5,-$5B56(A3)                    ; $109CB8
        ADD.L  D5,-$55(PC,A3.L)                 ; $109CBC
        MOVE.W  (A2)+,-$46(A5,D3.L)             ; $109CC0
        DC.W    $9DFF               ; $109CC4 SUBA.L  <EA:3F>,A6
        MOVE.W  -$245C(PC),-$47(A7,A5.L)        ; $109CC6
        SUB.L  D4,-(A3)                         ; $109CCC
        SUB.L  -$264D(A1),D2                    ; $109CCE
        CMPA.W  $3C9B(A1),A5                    ; $109CD2
        DC.W    $A3FF,$FFB3,$A33A   ; $109CD6 MOVE.L  <EA:3F>,$FFB3A33A
        CMP.L  -$4C66(A5),D3                    ; $109CDC
        MOVE.W  (A1)+,(A4)                      ; $109CE0
        DC.W    $ABD4               ; $109CE2 MOVE.L  (A4),<EA:3D>
        CMP.L  (A4)+,D3                         ; $109CE4
        MOVE.L  (A3)+,#$B1FF1F9E                ; $109CE6
        MOVE.W  (A3)+,(A3)+                     ; $109CEC
        MULS    (A1),D0                         ; $109CEE
        MOVEA.W -(A3),A6                        ; $109CF0
        BSR.S  loc_109C8C                       ; $109CF2
        MOVEA.L -$7722(A5),A4                   ; $109CF4
        DC.W    $A9BC,$3F89,$54F1,$EE81; $109CF8 MOVE.L  #$3F8954F1,-$7F(A4,A6.L)
        LSL.L  #8,D7                            ; $109D00
        ASL.W  -$711F(A6)                       ; $109D02
        MOVE.B  A6,(A4)                         ; $109D06
        MOVE.B  D4,(A7)                         ; $109D08
        BSET    D3,-$1704(PC)                   ; $109D0A
        MOVE.B  $1EE8(A6),(A4)+                 ; $109D0E
        MOVE.W  A0,D6                           ; $109D12
        MOVEQ   #-$0E,D0                        ; $109D14
        ASR.W  -$6F12(A5)                       ; $109D16
        ADDA.L  (A6)+,A6                        ; $109D1A
        MOVE.W  (A0)+,D0                        ; $109D1C
        ROL.B  #5,D5                            ; $109D1E
        MOVE.W  -$2171(A6),(A1)+                ; $109D20
        MOVE.W  $2002(A0),(A2)+                 ; $109D24
        ADDA.L  -$710E(A4),A3                   ; $109D28
        ASL.L  #3,D4                            ; $109D2C
        CMPA.W  -$711B(A1),A3                   ; $109D2E
        MULU    -(A0),D6                        ; $109D32
        MOVE.W  A4,$E0F1.W                      ; $109D34
        DC.W    $CC7D               ; $109D38 AND.W  <EA:3D>,D6
        MOVE.B  -(A3),(A4)+                     ; $109D3A
        MOVE.W  A4,$BEF1.W                      ; $109D3C
        AND.B  (A1),D6                          ; $109D40
        MOVE.B  (A2),D1                         ; $109D42
        MOVE.W  -(A1),D6                        ; $109D44
        MOVE.L  -(A0),-$04(A0,D3.L)             ; $109D46
        DC.W    $FFC1               ; $109D4A MOVE.W  D1,<EA:3F>
        MULU    -$80(A0,D0.L),D0                ; $109D4C
        MOVE.W  A5,D0                           ; $109D50
        DC.W    $FFFD               ; $109D52 MOVE.W  <EA:3D>,<EA:3F>
        MOVE.L  -(A3),D1                        ; $109D54
        MOVE.L  A4,(A4)                         ; $109D56
        ROXL.W  -(A1)                           ; $109D58
        MOVE.W  A2,D4                           ; $109D5A
        DIVU    -$01(A0,D1.L),D0                ; $109D5C
        MOVE.L  (A2),-(A0)                      ; $109D60
        BTST    D7,D1                           ; $109D62
        ASR.W  #7,D1                            ; $109D64
        DC.W    $4111               ; $109D66 DC.W    $4111
        DC.W    $44FF               ; $109D68 NEG    <EA:3F>
        DC.W    $14FD               ; $109D6A MOVE.B  <EA:3D>,(A2)+
        DC.W    $0A00,$F514         ; $109D6C EORI.B  #$F514,D0
        ASR.W  $0D81.W                          ; $109D70
        EOR.B  D0,D0                            ; $109D74
        MOVE.B  -$3F04(A6),(A0)+                ; $109D76
        AND.B  (A4),D0                          ; $109D7A
        MOVE.L  D0,D0                           ; $109D7C
        ADDA.W  -(A1),A5                        ; $109D7E
        ADDQ.L  #2,D0                           ; $109D80
        MOVE.W  A7,D4                           ; $109D82
        ASL.W  #2,D3                            ; $109D84
        DC.W    $54FE               ; $109D86 SCC     <EA:3E>
        MOVE.B  (A4),D2                         ; $109D88
        MOVE.L  D1,-$3C60(A1)                   ; $109D8A
        MOVE.W  (A1),D4                         ; $109D8E
        MOVE.W  $0010(A2),(A7)+                 ; $109D90
        DC.W    $ADFA,$C580         ; $109D94 MOVE.L  -$3A80(PC),<EA:3E>
        MOVE.W  (A1)+,D4                        ; $109D98
        DC.W    $A0FF               ; $109D9A MOVE.L  <EA:3F>,(A0)+
        MOVE.W  D0,(A7)                         ; $109D9C
        MOVE.L  D0,$16(A0,A7.L)                 ; $109D9E
        MOVE.L  -$5534(A4),D1                   ; $109DA2
        MOVE.B  A2,(A1)+                        ; $109DA6
        DC.W    $FFFF               ; $109DA8 MOVE.W  <EA:3F>,<EA:3F>
        ROL.W  A2                               ; $109DAA
        MOVE.L  -$2253(A7),-$03(A0,D1.L)        ; $109DAC
        ROR.W  (A7)+                            ; $109DB2
        MULU    #$DEDA,D5                       ; $109DB4
        DC.W    $00F8               ; $109DB8 DC.W    $00F8
        DC.W    $0FCC               ; $109DBA BSET    D7,A4
        MOVE.W  D0,D0                           ; $109DBC
        AND.L  -(A0),D1                         ; $109DBE
        ADDA.W  A4,A6                           ; $109DC0
        MULU    D1,D5                           ; $109DC2
        MOVE.W  $00FB(A0),(A6)                  ; $109DC4
        MOVE.W  D1,(A6)+                        ; $109DC8
        MOVE.W  -(A0),(A1)+                     ; $109DCA
        MOVE.W  (A4),D0                         ; $109DCC
        ADD.L  -$5C(A0,D6.W),D7                 ; $109DCE
        CMP.L  -$3E40(A2),D5                    ; $109DD2
        MOVE.W  (A2)+,D0                        ; $109DD6
        DC.W    $ADFD               ; $109DD8 MOVE.L  <EA:3D>,<EA:3E>
        MOVE.B  (A6)+,(A5)+                     ; $109DDA
        MOVE.W  D7,-(A7)                        ; $109DDC
        ASR.W  $101C.W                          ; $109DDE
        MOVE.L  $21AA(A2),(A5)                  ; $109DE2
        DC.W    $FDDE               ; $109DE6 MOVE.W  (A6)+,<EA:3E>
        MOVE.L  -$217D(A7),-$7A(A7,D3.W)        ; $109DE8
        MOVEQ   #-$20,D6                        ; $109DEE
        MOVE.W  A7,D4                           ; $109DF0
        MOVE.L  D0,(A5)                         ; $109DF2
        ADDA.L  (A5)+,A7                        ; $109DF4
        MULS    -$26(PC,A4.W),D1                ; $109DF6
        ADDA.W  -$2212(PC),A7                   ; $109DFA
        LSL.L  D6,D5                            ; $109DFE
        MOVE.L  $162A.W,(A0)+                   ; $109E00
        MOVE.L  -$0E01(A4),(A5)                 ; $109E04
        MOVE.B  -$2701(A7),-$45(A0,D6.L)        ; $109E08
        CMP.L  -$4D(PC,A1.W),D2                 ; $109E0E
        MOVE.L  $39FF(A3),(A5)                  ; $109E12
        MOVE.W  -$46(A4,D4.L),(A0)              ; $109E16
        BLS.S  loc_109E60                       ; $109E1A
        DC.W    $4BB4               ; $109E1C DC.W    $4BB4
        BLS.S  loc_109DCB                       ; $109E1E
        DC.W    $FFD9               ; $109E20 MOVE.W  (A1)+,<EA:3F>
        DC.W    $33FC,$FFF0,$9BBB,$A4BA; $109E22 MOVE.W  #$FFF0,$9BBBA4BA
        OR.L   D1,-$46(PC,D4.L)                 ; $109E2A
        SUBQ.W  #2,(A5)                         ; $109E2E
        NEG.W  D1                               ; $109E30
        DC.W    $4515               ; $109E32 DC.W    $4515
        MOVEA.L (A4),A0                         ; $109E34
        SCC     -$01(A1,A7.W)                   ; $109E36
        MOVE.W  $45(A5,A7.L),(A6)+              ; $109E3A
        OR.B   -$18(A1,A7.L),D1                 ; $109E3E
        DC.W    $FFFC,$41FF         ; $109E42 MOVE.W  #$41FF,<EA:3F>
        MOVE.B  $0CFF(PC),D2                    ; $109E46
        ASR.W  $0D55.W                          ; $109E4A
        SNE     -(A6)                           ; $109E4E
        BCS.S  loc_109EB9                       ; $109E50
        BLS.S  loc_109E45                       ; $109E52
        MOVEA.W (A6),A6                         ; $109E54
        SNE     -(A1)                           ; $109E56
        LEA     -(A0),A6                        ; $109E58
        MOVE.W  A1,(A7)+                        ; $109E5A
        NEG.W  (A5)                             ; $109E5C
        BCLR    D7,D7                           ; $109E5E
loc_109E60:
        BNE.S  loc_109EB7                       ; $109E60
        ADDQ.W  #2,-(A7)                        ; $109E62
        MOVE.W  -$79(PC,D7.W),-$21(PC,A0.W)     ; $109E64
        MOVE.W  D7,$77(A7,D7.L)                 ; $109E6A
        MOVEQ   #-$4D,D3                        ; $109E6E
loc_109E70:
        CMP.W  A2,D5                            ; $109E70
        DC.W    $47B3               ; $109E72 DC.W    $47B3
        DC.W    $4B4A               ; $109E74 DC.W    $4B4A
        MOVEQ   #-$56,D2                        ; $109E76
        DC.W    $FDFF               ; $109E78 MOVE.W  <EA:3F>,<EA:3E>
        MOVE.B  $34(A4,A3.L),$744A(A7)          ; $109E7A
        SUB.L  D5,-(A4)                         ; $109E80
        MOVE.L  $47(A4,A3.L),-$5C(A5,A2.L)      ; $109E82
        DC.W    $A4FE               ; $109E88 MOVE.L  <EA:3E>,(A2)+
        MOVE.W  (A7)+,-$34B5(A7)                ; $109E8A
        MOVE.W  -(A6),$74(A5,D3.L)              ; $109E8E
        NOT    -(A3)                            ; $109E92
        BNE.S  loc_109EDD                       ; $109E94
        MOVE.L  (A1)+,(A4)                      ; $109E96
        ASL.W  #1,D4                            ; $109E98
        DC.W    $FFFF               ; $109E9A MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  (A1)+,$D344.W                   ; $109E9C
        AND.L  (A4)+,D7                         ; $109EA0
        BVS.S  loc_109EE8                       ; $109EA2
        DC.W    $393D               ; $109EA4 MOVE.W  <EA:3D>,-(A4)
        MOVE.W  A5,$3B9C(A4)                    ; $109EA6
        AND.W  D1,D3                            ; $109EAA
        DC.W    $FFC7               ; $109EAC MOVE.W  D7,<EA:3F>
        EOR.B  D5,$934B3C9D                     ; $109EAE
        AND.B  D1,(A1)                          ; $109EB4
        MOVE.B  (A0)+,-(A0)                     ; $109EB6
        MOVE.B  -(A1),(A4)+                     ; $109EB8
        MOVE.W  -(A1),(A6)+                     ; $109EBA
        DC.W    $038E               ; $109EBC BCLR    D1,A6
        DIVS    -$1E7F(PC),D0                   ; $109EBE
        MOVE.B  A0,-$11(A0,D1.L)                ; $109EC2
        OR.B   (A1),D2                          ; $109EC6
        MOVE.W  A0,(A6)                         ; $109EC8
        MOVE.W  D1,(A6)                         ; $109ECA
        DIVU    -$01(PC,A7.L),D4                ; $109ECC
        MOVE.W  D1,-$45(A1,A0.L)                ; $109ED0
        BLT.S  loc_109E70                       ; $109ED4
        ROL.L  #6,D1                            ; $109ED6
        ADD.L  D6,(A6)                          ; $109ED8
        ADD.L  (A5)+,D7                         ; $109EDA
        ADDA.W  A6,A7                           ; $109EDC
        DC.W    $9DFF               ; $109EDE SUBA.L  <EA:3F>,A6
        DC.W    $7FD3               ; $109EE0 MOVE.W  (A3),<EA:3F>
        BVS.S  loc_109E6C                       ; $109EE2
        DIVU    -$11EF(A5),D3                   ; $109EE4
loc_109EE8:
        ADDA.L  (A0)+,A6                        ; $109EE8
        ROR.B  #7,D4                            ; $109EEA
        ADDA.W  -(A1),A7                        ; $109EEC
        MOVE.B  A1,(A4)                         ; $109EEE
        ADDA.W  #$FFC3,A6                       ; $109EF0
        ROR.W  -$18(A1,A0.L)                    ; $109EF4
        ROR.W  $888E.W                          ; $109EF8
        ASR.W  $8EEE.W                          ; $109EFC
        MOVE.B  D0,-$1E08(PC)                   ; $109F00
        DIVS    -(A1),D0                        ; $109F04
        DC.W    $00EA               ; $109F06 DC.W    $00EA
        MULU    (A3)+,D2                        ; $109F08
        DC.W    $00E9               ; $109F0A DC.W    $00E9
        MOVE.B  -(A4),-(A3)                     ; $109F0C
        OR.B   (A0)+,D4                         ; $109F0E
        MOVE.B  D1,(A7)                         ; $109F10
        MOVE.W  -(A1),(A3)+                     ; $109F12
        MOVE.W  -$18(A5,A6.W),#$380C            ; $109F14
        MOVE.W  $18E8(A6),#$FA1E                ; $109F1A
        MOVE.B  A0,D7                           ; $109F20
        ST      -$7104(PC)                      ; $109F22
        ADDA.W  $00F8(A0),A4                    ; $109F26
        BSET    D5,D5                           ; $109F2A
loc_109F2C:
        MOVE.B  -(A0),D7                        ; $109F2C
        MOVE.W  (A3),D4                         ; $109F2E
        ASR.W  -$21(A0,D0.L)                    ; $109F30
        DBCC    D3,loc_10918C                   ; $109F34
        BNE.S  loc_109FA0                       ; $109F38
        DC.W    $0214,$FD76         ; $109F3A ANDI.B  #$FD76,(A4)
        DC.W    $DAFD               ; $109F3E ADDA.W  <EA:3D>,A5
        DIVS    D0,D3                           ; $109F40
        MOVE.W  A4,D4                           ; $109F42
        BSR.W  loc_109C29                       ; $109F44
        ADDQ.W  #2,(A4)                         ; $109F48
        DC.W    $C2FF               ; $109F4A MULU    <EA:3F>,D1
        MOVEA.B D0,A4                           ; $109F4C
        ADD.W  -(A6),D7                         ; $109F4E
        BEQ.S  loc_109F0F                       ; $109F50
        ADDA.L  D0,A7                           ; $109F52
        MOVE.W  A7,D4                           ; $109F54
        ADD.B  D1,D0                            ; $109F56
        MOVE.L  -$1D(A1,D6.W),(A4)+             ; $109F58
        MOVEQ   #$67,D3                         ; $109F5C
        ADDA.W  D0,A5                           ; $109F5E
        DC.W    $22FD               ; $109F60 MOVE.L  <EA:3D>,(A1)+
        MOVE.W  -(A0),(A2)+                     ; $109F62
        DIVU    $00(A5,A6.W),D2                 ; $109F64
        ASR.L  D0,D1                            ; $109F68
        MOVE.L  -(A1),$56(PC,D7.L)              ; $109F6A
        NEGX.B -$01(A6,D7.W)                    ; $109F6E
        CMP.W  -(A0),D5                         ; $109F72
        MOVE.W  (A3),D0                         ; $109F74
        SUBQ.W  #2,D2                           ; $109F76
        MOVEA.W (A6),A1                         ; $109F78
        ORI.W  #$D7FE,D0                        ; $109F7A
        SUBA.L  -(A2),A6                        ; $109F7E
        NEG.W  D0                               ; $109F80
        DC.W    $18FE               ; $109F82 MOVE.B  <EA:3E>,(A4)+
        ASR.L  #5,D7                            ; $109F84
        ADDQ.W  #3,(A5)                         ; $109F86
        OR.B   (A0),D0                          ; $109F88
        CMPA.L  (A0),A7                         ; $109F8A
        BLS.S  loc_109F2C                       ; $109F8C
        MOVE.W  A2,D0                           ; $109F8E
        NEGX   D2                               ; $109F90
        OR.L   D3,$C0F80B80                     ; $109F92
        MOVE.L  -(A2),(A4)                      ; $109F98
        MOVE.W  -(A1),D6                        ; $109F9A
        AND.B  D0,D0                            ; $109F9C
        MOVE.W  A1,(A2)                         ; $109F9E
loc_109FA0:
        SCC     (A0)+                           ; $109FA0
        MOVE.L  $14DF.W,(A0)+                   ; $109FA2
        EOR.W  D5,-$08(A7,A4.W)                 ; $109FA6
        DC.W    $0EF9               ; $109FAA DC.W    $0EF9
        DC.W    $FBC0               ; $109FAC MOVE.W  D0,<EA:3D>
        LSR.B  D4,D1                            ; $109FAE
        ROR.W  #8,D7                            ; $109FB0
        SUBQ.L  #2,-$5251(A5)                   ; $109FB2
        ASR.W  $105F.W                          ; $109FB6
        DC.W    $FFEF,$376C         ; $109FBA MOVE.W  $376C(A7),<EA:3F>
        DC.W    $4FFE               ; $109FBE LEA     <EA:3E>,A7
        ROR.W  $24C1(A5)                        ; $109FC0
        DC.W    $EDFD               ; $109FC4 ROXL.W  <EA:3D>
        MOVE.L  (A5)+,(A7)+                     ; $109FC6
        ASR.W  $0FF4.W                          ; $109FC8
        ASR.L  #6,D7                            ; $109FCC
        MULU    -$2747(A7),D0                   ; $109FCE
        ADDA.L  (A5)+,A6                        ; $109FD2
        DC.W    $FDDD               ; $109FD4 MOVE.W  (A5)+,<EA:3E>
        ADDA.W  -$0F(PC,A0.W),A5                ; $109FD6
        ROXL.W  -(A0)                           ; $109FDA
        MOVE.W  (A7)+,-(A6)                     ; $109FDC
        LSR.W  #3,D7                            ; $109FDE
        DC.W    $FDFD               ; $109FE0 MOVE.W  <EA:3D>,<EA:3E>
loc_109FE2:
        ROR.W  #7,D7                            ; $109FE2
        AND.B  D1,D7                            ; $109FE4
        DC.W    $FDEF,$EEFA         ; $109FE6 MOVE.W  -$1106(A7),<EA:3E>
        ROR.W  -$2102(A7)                       ; $109FEA
        MOVE.W  -$01(A7,A7.L),(A7)+             ; $109FEE
        DC.W    $BBFF               ; $109FF2 CMPA.L  <EA:3F>,A5
        MOVE.W  -(A4),$66(A3,D4.L)              ; $109FF4
        MOVE.L  $68885B88,D2                    ; $109FF8
        OR.L   D7,D7                            ; $109FFE
        DC.W    $FFFF               ; $10A000 MOVE.W  <EA:3F>,<EA:3F>
        BGE.S  loc_109FE2                       ; $10A002
        DIVS    (A0)+,D0                        ; $10A004
        DC.W    $4B96               ; $10A006 DC.W    $4B96
        AND.W  D7,D7                            ; $10A008
        SUBQ.B  #1,$1869.W                      ; $10A00A
        DC.W    $FFFF               ; $10A00E MOVE.W  <EA:3F>,<EA:3F>
        MOVE.L  -$47(A6,A0.W),(A5)              ; $10A010
        DC.W    $4BBA               ; $10A014 DC.W    $4BBA
        MOVE.L  $74(A4,D7.L),(A4)               ; $10A016
        MOVE.L  -$53(A3,D4.L),$1D(A2,A4.W)      ; $10A01A
        DC.W    $FFFF               ; $10A020 MOVE.W  <EA:3F>,<EA:3F>
        DIVS    $75BA(A4),D6                    ; $10A022
        NOT.L  -(A7)                            ; $10A026
        MOVEQ   #$57,D2                         ; $10A028
        DC.W    $4B77               ; $10A02A DC.W    $4B77
        CMP.L  -(A4),D5                         ; $10A02C
        DC.W    $477C               ; $10A02E DC.W    $477C
        MOVE.W  (A1)+,-(A5)                     ; $10A030
        MOVE.W  (A7)+,-(A7)                     ; $10A032
        NEG.L  -(A4)                            ; $10A034
        MOVE.L  (A0)+,-(A4)                     ; $10A036
        ADD.L  -(A4),D7                         ; $10A038
        EOR.W  D3,D3                            ; $10A03A
        NEG.W  $57(A5,D7.W)                     ; $10A03C
        MOVE.W  (A5),-$0101(A2)                 ; $10A040
        ROXR.W  #5,D5                           ; $10A044
        MOVE.W  -$5B89(A2),$39(A2,D7.L)         ; $10A046
        MOVEA.W D7,A6                           ; $10A04C
        MOVE.L  (A1)+,$5A(A1,D6.L)              ; $10A04E
        DC.W    $DAFF               ; $10A052 ADDA.W  <EA:3F>,A5
        DC.W    $FFB9,$6B7A,$9988,$475B; $10A054 MOVE.W  $6B7A9988,$5B(A7,D4.W)
        EOR.L  D5,(A3)+                         ; $10A05C
        NEG.W  A2                               ; $10A05E
        MOVE.W  -(A4),(A5)                      ; $10A060
        EOR.W  D5,D4                            ; $10A062
        EOR.L  D5,D7                            ; $10A064
        AND.L  D1,-$46(A3,D3.L)                 ; $10A066
        DC.W    $39FE,$B44B         ; $10A06A MOVE.W  <EA:3E>,#$B44B
        MOVE.L  $4AFF.W,(A2)+                   ; $10A06E
        LSL.W  #8,D2                            ; $10A072
        MOVE.W  -$4D(A4,D4.W),(A4)              ; $10A074
        ADD.L  -$4B46(PC),D7                    ; $10A078
        ADDA.L  -$59(A3,A1.W),A6                ; $10A07C
        MULS    -(A1),D1                        ; $10A080
        DC.W    $4744               ; $10A082 DC.W    $4744
        DC.W    $43FD               ; $10A084 LEA     <EA:3D>,A1
        MOVEA.L A4,A2                           ; $10A086
        TST    (A3)+                            ; $10A088
        DC.W    $437A               ; $10A08A DC.W    $437A
        DC.W    $1FFE               ; $10A08C MOVE.B  <EA:3E>,<EA:3F>
        CMP.W  D4,D5                            ; $10A08E
        ADD.L  D1,-$334C(A2)                    ; $10A090
        ASR.W  D5,D3                            ; $10A094
        CMP.L  -$36(A3,D3.L),D2                 ; $10A096
        NEG    D3                               ; $10A09A
        DC.W    $FFB9,$9B97,$FC1D,$9D3B; $10A09C MOVE.W  $9B97FC1D,$3B(A7,A1.L)
        CMPA.L  -$3966(A1),A5                   ; $10A0A4
        MOVE.L  (A3),(A3)                       ; $10A0A8
        DC.W    $FFFF               ; $10A0AA MOVE.W  <EA:3F>,<EA:3F>
        ADD.L  D1,(A3)+                         ; $10A0AC
        ADD.L  $CC3D3BB3,D3                     ; $10A0AE
        SUB.B  D4,-$37(A3,A3.L)                 ; $10A0B4
        ADD.B  $B39DFF3F,D6                     ; $10A0B8
        ADD.B  D4,#$3931                        ; $10A0BE
        ROR.L  D6,D3                            ; $10A0C2
        SUB.B  D4,(A3)                          ; $10A0C4
        MOVE.W  D4,-$4BED(A5)                   ; $10A0C6
        MOVE.W  -$5504(A3),$13(A1,A4.W)         ; $10A0CA
        MOVE.L  -$67(A4,A4.L),-$59(A5,A2.L)     ; $10A0D0
        MULS    (A3)+,D1                        ; $10A0D6
        MOVE.W  A1,(A6)                         ; $10A0D8
        MOVEQ   #$78,D0                         ; $10A0DA
        SUB.L  D4,(A0)+                         ; $10A0DC
        OR.L   D6,(A3)                          ; $10A0DE
        NEG    $DB44.W                          ; $10A0E0
loc_10A0E4:
        DC.W    $4765               ; $10A0E4 DC.W    $4765
        OR.L   $56(A2,A7.L),D6                  ; $10A0E6
        DC.W    $FFCD               ; $10A0EA MOVE.W  A5,<EA:3F>
        DC.W    $E9FF               ; $10A0EC ASL.W  <EA:3F>
        MOVE.L  -$1617(A4),$7667(A1)            ; $10A0EE
        MOVE.W  A1,-$01(A7,A3.L)                ; $10A0F4
        SUBA.L  $78CC(A1),A4                    ; $10A0F8
        DC.W    $FFE2               ; $10A0FC MOVE.W  -(A2),<EA:3F>
        BEQ.S  loc_10A0E4                       ; $10A0FE
        MOVE.W  $78(A6,D6.W),$7887(A3)          ; $10A100
        MOVE.W  D7,$0E78(A3)                    ; $10A106
        OR.L   A0,D4                            ; $10A10A
        DC.W    $87FF               ; $10A10C DIVS    <EA:3F>,D3
        ASR.W  D0,D5                            ; $10A10E
        DC.W    $A8FF               ; $10A110 MOVE.L  <EA:3F>,(A4)+
        LSR.W  D0                               ; $10A112
        ADDA.L  -$3F08(A1),A2                   ; $10A114
        MOVEA.B A3,A3                           ; $10A118
        MOVE.L  -$5B57(A4),-$47(A1,D3.L)        ; $10A11A
        MULS    -(A1),D1                        ; $10A120
        MOVEQ   #-$37,D2                        ; $10A122
        EOR.B  D4,-(A3)                         ; $10A124
        MOVE.W  $47(A3,A1.W),-(A1)              ; $10A126
        EOR.L  D5,-$01(PC,A5.L)                 ; $10A12A
        DC.W    $4BB3               ; $10A12E DC.W    $4BB3
        SUB.L  D5,-$34C2(A4)                    ; $10A130
        SPL     -(A1)                           ; $10A134
        MOVE.W  (A1)+,(A6)                      ; $10A136
        CMPA.L  A3,A1                           ; $10A138
        DC.W    $4B99               ; $10A13A DC.W    $4B99
        ADD.L  D6,(A3)                          ; $10A13C
        MOVE.W  A4,-(A7)                        ; $10A13E
        DC.W    $4B93               ; $10A140 DC.W    $4B93
        MOVE.B  A3,(A7)+                        ; $10A142
        DC.W    $493E               ; $10A144 DC.W    $493E
        MOVE.B  D4,-$61E7(A4)                   ; $10A146
        DC.W    $3FFC,$56D8         ; $10A14A MOVE.W  #$56D8,<EA:3F>
        MOVE.B  -$4C28(A5),(A5)                 ; $10A14E
        DC.W    $FE3F               ; $10A152 MOVE.W  <EA:3F>,D7
        ROL.B  #8,D4                            ; $10A154
        DC.W    $A9B9,$E1FF,$FF18,$A9EE; $10A156 MOVE.L  $E1FFFF18,-$12(A4,A2.L)
        ADD.L  D4,(A1)                          ; $10A15E
        MOVE.W  A6,-$68(A0,A5.W)                ; $10A160
        DC.W    $113D               ; $10A164 MOVE.B  <EA:3D>,-(A0)
        ASL.W  -(A1)                            ; $10A166
        MOVE.W  (A1)+,$887F.W                   ; $10A168
        OR.B   (A1),D0                          ; $10A16C
        MOVE.B  (A6)+,$831B.W                   ; $10A16E
        MOVE.B  A5,-$10(A0,A4.L)                ; $10A172
        DC.W    $7DF0,$06F1         ; $10A176 MOVE.W  -$0F(A0,D0.W),<EA:3E>
        MOVE.W  D6,(A6)                         ; $10A17A
        OR.B   D0,(A7)+                         ; $10A17C
        OR.W   D0,(A2)+                         ; $10A17E
        ADDA.L  -$08(A1,A6.L),A1                ; $10A180
        DC.W    $FFFF               ; $10A184 MOVE.W  <EA:3F>,<EA:3F>
        OR.B   D4,(A1)                          ; $10A186
        MOVE.W  (A1),-(A7)                      ; $10A188
        ROXR.B  #7,D1                           ; $10A18A
        DC.W    $1FF1,$FC1F         ; $10A18C MOVE.B  $1F(A1,A7.L),<EA:3F>
        MOVE.B  (A1),-(A7)                      ; $10A190
        CMP.L  -$0B(A1,A7.L),D0                 ; $10A192
        DC.W    $F1FE,$DAB1         ; $10A196 MOVE.W  <EA:3E>,$DAB1.W
        OR.W   D0,D4                            ; $10A19A
        MOVE.W  $0020(A0),$1B(A3,A7.L)          ; $10A19C
        MOVE.B  D0,-(A7)                        ; $10A1A2
        MOVE.W  (A4)+,D4                        ; $10A1A4
        ASR.W  -$18(A0,D0.L)                    ; $10A1A6
        AND.B  D1,$77(A2,A6.W)                  ; $10A1AA
        DIVS    $7878(PC),D3                    ; $10A1AE
        ASR.W  $15C0.W                          ; $10A1B2
        OR.B   -$1540(A0),D5                    ; $10A1B6
        MOVE.W  A1,D4                           ; $10A1BA
        ADDA.L  -$1F(A4,A5.W),A3                ; $10A1BC
        MOVE.L  (A0),D4                         ; $10A1C0
        MOVE.W  #$F480,(A7)                     ; $10A1C2
        MOVE.W  A7,D4                           ; $10A1C6
        SMI     -(A1)                           ; $10A1C8
        MOVE.W  $00(A6,D5.L),-$1E1E(A5)         ; $10A1CA
        ASR.W  $0D9A.W                          ; $10A1D0
loc_10A1D4:
        DC.W    $C2BF               ; $10A1D4 AND.L  <EA:3F>,D1
        MOVE.W  -(A0),-$0FE6(A7)                ; $10A1D6
        DC.W    $DE7D               ; $10A1DA ADD.W  <EA:3D>,D7
        ADDA.W  (A6)+,A7                        ; $10A1DC
        ROR.W  -(A0)                            ; $10A1DE
        MOVE.W  (A6),D4                         ; $10A1E0
        BGT.S  loc_10A1C1                       ; $10A1E2
        ROXL.W  (A2)+                           ; $10A1E4
        ADD.L  D6,-$12F3(A5)                    ; $10A1E6
        BSET    D7,-$5220(A5)                   ; $10A1EA
        MOVE.W  A6,D4                           ; $10A1EE
        BLT.S  loc_10A1D4                       ; $10A1F0
        DC.W    $7DED,$EEDE         ; $10A1F2 MOVE.W  -$1122(A5),<EA:3E>
        MOVE.W  (A3)+,D0                        ; $10A1F6
        ROXR.W  -$33(PC,A5.L)                   ; $10A1F8
        ADDA.W  (A6)+,A5                        ; $10A1FC
        ADD.L  D6,-$1F01(A2)                    ; $10A1FE
