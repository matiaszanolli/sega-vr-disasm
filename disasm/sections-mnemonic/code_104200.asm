; Generated assembly for $104200-$106200
; Branch targets: 137
; Labels: 125
; Format: DC.W with decoded mnemonics as comments

        org     $104200

        EOR.W  D3,-(A2)                         ; $104200
        DC.W    $00C4               ; $104202 DC.W    $00C4
        ROL.L  D5,D1                            ; $104204
        MOVE.L  -$249C(A1),(A6)                 ; $104206
        AND.W  D4,D5                            ; $10420A
        CMP.B  A3,D4                            ; $10420C
        ROR.W  (A6)+                            ; $10420E
        BLT.S  $1041E3                          ; $104210
        EXT.L   D3                              ; $104212
        BLT.S  $1041DF                          ; $104214
        BNE.S  loc_104268                       ; $104216
        MOVE.W  A0,-$2F(A0,D6.W)                ; $104218
        ADDA.W  D4,A6                           ; $10421C
        AND.B  -$2513(A5),D1                    ; $10421E
        DC.W    $DC3F               ; $104222 ADD.B  <EA:3F>,D6
        MULS    (A5)+,D4                        ; $104224
        DC.W    $0ED1               ; $104226 DC.W    $0ED1
        ASR.W  -(A0)                            ; $104228
        ADD.W  D5,(A5)                          ; $10422A
        DC.W    $3BE2               ; $10422C MOVE.W  -(A2),<EA:3D>
        DC.W    $087F,$8678         ; $10422E BCHG    #24,<EA:3F>
        ADD.W  (A6),D2                          ; $104232
        BVC.S  $1041EF                          ; $104234
        OR.W   -$6647(A0),D3                    ; $104236
        ASR.B  #6,D0                            ; $10423A
        MULS    A3,D7                           ; $10423C
        ADDA.L  -$3347(A1),A1                   ; $10423E
        ADDQ.B  #7,D0                           ; $104242
        MOVE.L  (A1),-$077F(A1)                 ; $104244
        MOVE.L  $08(PC,A7.W),(A5)               ; $104248
        DC.W    $A3FC,$23F1,$F9BA,$BCF9,$4168; $10424C MOVE.L  #$23F1F9BA,$BCF94168
        MOVE.B  -$424D(A1),(A2)+                ; $104256
        DIVS    A1,D3                           ; $10425A
        MOVE.W  #$1EE1,-$80(A6,A4.L)            ; $10425C
        BSET    D7,-$5045(A3)                   ; $104262
        MULS    -$3446(A5),D6                   ; $104266
        MOVE.B  D6,-(A0)                        ; $10426A
        BVS.S  loc_104249                       ; $10426C
        MOVE.W  -$13(A0,A5.L),(A4)+             ; $10426E
        MOVEA.W (A5),A4                         ; $104272
        CMPI.L  #$A1F8E9F0,(A5)                 ; $104274
        ROR.W  $FDC3.W                          ; $10427A
        MOVE.L  -$5F50(A3),(A5)+                ; $10427E
        SUB.L  -$5F17(A2),D5                    ; $104282
        CMPA.W  -$4455(A2),A1                   ; $104286
        MOVE.W  A0,(A7)+                        ; $10428A
        ASL.B  D4,D2                            ; $10428C
        DIVU    (A0),D4                         ; $10428E
        ROR.W  #5,D0                            ; $104290
        ROXR.W  -(A1)                           ; $104292
        MOVE.W  (A1),-$16D6(A5)                 ; $104294
        ASR.W  (A0)                             ; $104298
        MOVEQ   #-$17,D4                        ; $10429A
        MOVE.W  -(A2),-$7117(PC)                ; $10429C
        OR.W   -$1EF0(A1),D5                    ; $1042A0
        ROL.L  #4,D2                            ; $1042A4
        DC.W    $0888,$99C3         ; $1042A6 BCLR    #3,A0
        MULU    D4,D4                           ; $1042AA
        AND.L  -$0204(A2),D6                    ; $1042AC
        DC.W    $FFC7               ; $1042B0 MOVE.W  D7,<EA:3F>
        MOVE.W  -$1CD6(A0),-$16AB(A0)           ; $1042B2
        MOVE.W  A5,D1                           ; $1042B8
        ROL.L  #4,D0                            ; $1042BA
        MOVE.L  $23E9(A1),(A2)+                 ; $1042BC
        SMI     -$17EC(A4)                      ; $1042C0
        LSR.L  #6,D0                            ; $1042C4
        EOR.B  D1,D0                            ; $1042C6
        MOVE.W  $7EF1.W,-$80(PC,A3.L)           ; $1042C8
        DC.W    $04F6               ; $1042CE DC.W    $04F6
        OR.L   -(A3),D5                         ; $1042D0
        SUB.B  D0,D4                            ; $1042D2
        DC.W    $412C               ; $1042D4 DC.W    $412C
        MOVEQ   #-$5F,D3                        ; $1042D6
        DC.W    $A9F8,$67D9,$5403,$CC19; $1042D8 MOVE.L  $67D9.W,#$5403CC19
        ASL.L  D1,D6                            ; $1042E0
        DC.W    $FDE8,$E5BB         ; $1042E2 MOVE.W  -$1A45(A0),<EA:3E>
        ASR.B  #1,D1                            ; $1042E6
        SUBA.W  (A0)+,A1                        ; $1042E8
        BGT.S  loc_1042CD                       ; $1042EA
        ADD.L  $13BC(A0),D6                     ; $1042EC
        DC.W    $E4FE               ; $1042F0 ROXR.W  <EA:3E>
        SUBA.L  (A1)+,A5                        ; $1042F2
        BRA.S  loc_1042D7                       ; $1042F4
        CMPA.L  A4,A5                           ; $1042F6
        ADD.B  D6,D4                            ; $1042F8
        AND.W  D0,(A1)                          ; $1042FA
        CMPA.W  -(A3),A6                        ; $1042FC
        SUBA.W  -(A1),A4                        ; $1042FE
        DC.W    $DCBF               ; $104300 ADD.L  <EA:3F>,D6
        ROR.W  #1,D0                            ; $104302
        DC.W    $41AB               ; $104304 DC.W    $41AB
        CMP.L  (A2)+,D4                         ; $104306
        DIVU    -$3636(A1),D3                   ; $104308
        MOVE.W  D5,(A6)                         ; $10430C
        ASL.B  #4,D5                            ; $10430E
        DC.W    $4088               ; $104310 NEGX.L A0
        ROR.W  D6,D6                            ; $104312
        ADDA.L  $07(A7,D1.W),A4                 ; $104314
        DC.W    $4550               ; $104318 DC.W    $4550
        MOVE.W  -$26(A3,D7.W),(A0)+             ; $10431A
        MOVE.W  -(A5),(A3)+                     ; $10431E
        MOVE.B  -(A1),(A7)+                     ; $104320
        DC.W    $2DD9               ; $104322 MOVE.L  (A1)+,<EA:3E>
        SUB.B  D0,D0                            ; $104324
        BSET    D0,(A2)+                        ; $104326
        MOVE.W  (A2),$02(A0,D1.L)               ; $104328
        MOVEA.L -(A1),A0                        ; $10432C
        SUB.L  $10(A7,A3.L),D4                  ; $10432E
        MOVE.L  -(A2),(A0)                      ; $104332
        MOVE.W  -(A1),(A4)+                     ; $104334
        MOVE.W  -(A0),-(A5)                     ; $104336
        ASL.W  $24(A0,A2.W)                     ; $104338
        MOVE.L  -(A0),-(A4)                     ; $10433C
        ASR.L  #1,D3                            ; $10433E
        NEGX   -(A1)                            ; $104340
        MOVE.B  A4,D2                           ; $104342
        MOVE.W  $F813.W,(A7)+                   ; $104344
        DC.W    $0204,$E3F3         ; $104348 ANDI.B  #$E3F3,D4
        MOVE.W  -$07(A3,D7.W),(A6)+             ; $10434C
        SUB.W  $08A0(A4),D5                     ; $104350
        MOVE.W  -$0D4E(PC),-$0F(A4,D2.L)        ; $104354
        MOVEA.B -(A0),A7                        ; $10435A
        ADDA.W  (A2)+,A1                        ; $10435C
        MOVE.W  -$65(A2,A3.L),$AB62.W           ; $10435E
        OR.L   D3,#$DC502587                    ; $104364
        ROXR.W  D2                              ; $10436A
        MOVE.B  A2,(A6)+                        ; $10436C
        MOVE.L  (A2),(A0)+                      ; $10436E
        LSR.W  (A1)                             ; $104370
        MOVE.L  (A5),-(A5)                      ; $104372
        MOVE.L  A4,(A2)+                        ; $104374
        ADD.W  -$2144(A4),D1                    ; $104376
        DC.W    $BBFE               ; $10437A CMPA.L  <EA:3E>,A5
        ADDA.L  -(A1),A4                        ; $10437C
        MOVEA.B D1,A0                           ; $10437E
        SUBQ.W  #2,(A7)                         ; $104380
        DC.W    $F1FF,$36A3         ; $104382 MOVE.W  <EA:3F>,$36A3.W
        LSL.L  D2,D0                            ; $104386
        BCLR    D4,-(A5)                        ; $104388
        LSL.B  #4,D7                            ; $10438A
        AND.W  D4,-(A0)                         ; $10438C
        LSR.L  D6,D5                            ; $10438E
        MOVE.L  D0,(A2)                         ; $104390
        ADD.W  D1,-$6234(A4)                    ; $104392
        MOVE.L  $11E2B812,(A2)                  ; $104396
        ROXL.W  D0,D7                           ; $10439C
        BSET    #12,$CBCA.W                     ; $10439E
        BRA.S  loc_104389                       ; $1043A4
        MULU    A3,D5                           ; $1043A6
        ADD.L  $1D36(A4),D4                     ; $1043A8
        MOVE.W  A2,(A4)+                        ; $1043AC
        ADDA.W  (A1)+,A2                        ; $1043AE
        EOR.L  D5,(A3)+                         ; $1043B0
        MOVE.W  $B9FDF19B,(A4)                  ; $1043B2
        MOVE.L  A2,(A0)                         ; $1043B8
        BGT.S  loc_1043A5                       ; $1043BA
        ADDA.W  -$22(A2,A7.W),A0                ; $1043BC
        MOVEQ   #-$19,D0                        ; $1043C0
        DC.W    $0218,$D920         ; $1043C2 ANDI.B  #$D920,(A0)+
        LSR.B  #8,D5                            ; $1043C6
        ADDA.L  $E8D2.W,A1                      ; $1043C8
        AND.L  D5,A0                            ; $1043CC
        DC.W    $03CB               ; $1043CE BSET    D1,A3
        MULU    $BAF8.W,D1                      ; $1043D0
        NEG.B  D5                               ; $1043D4
        AND.L  -$0F84(A3),D0                    ; $1043D6
        ADDA.L  (A0),A4                         ; $1043DA
        DC.W    $FFF5,$1204         ; $1043DC MOVE.W  $04(A5,D1.W),<EA:3F>
        MOVE.W  -(A5),(A0)                      ; $1043E0
        AND.L  (A5)+,D5                         ; $1043E2
        MOVE.W  (A2)+,-$6B(PC,A7.L)             ; $1043E4
        AND.L  -(A1),D0                         ; $1043E8
        AND.L  D4,-$50(A1,A7.L)                 ; $1043EA
        DC.W    $FDE7               ; $1043EE MOVE.W  -(A7),<EA:3E>
        MOVE.L  (A0)+,-$263A(A7)                ; $1043F0
        SUBQ.L  #8,$6DA19BB9                    ; $1043F4
        CMPA.L  (A5)+,A4                        ; $1043FA
        MOVEQ   #-$70,D7                        ; $1043FC
        MOVE.W  A3,D4                           ; $1043FE
        ORI.L  #$C9F891BC,A4                    ; $104400
        EOR.B  D0,$5D9B(A3)                     ; $104406
        ADDQ.L  #2,-$5743(PC)                   ; $10440A
        ADD.L  #$3AC99CDB,D7                    ; $10440E
        MOVEA.B D4,A5                           ; $104414
        MOVE.W  A4,(A0)                         ; $104416
        ADDA.L  A4,A4                           ; $104418
        MOVE.L  (A4),-(A6)                      ; $10441A
        MOVE.W  $00(A4,D0.L),(A1)+              ; $10441C
        MOVEQ   #-$57,D4                        ; $104420
        MOVE.W  $02(A6,D2.W),(A1)               ; $104422
        MOVE.W  (A0),-$17(A3,A7.L)              ; $104426
        ADDA.W  $22D8(A7),A0                    ; $10442A
        MOVE.L  (A1)+,(A5)                      ; $10442E
        ROR.L  D6,D5                            ; $104430
        MOVE.W  (A3)+,-$28(A0,A4.L)             ; $104432
        DC.W    $0AF8               ; $104436 DC.W    $0AF8
        OR.W   -(A6),D3                         ; $104438
        MOVE.W  $5556(A0),$684D(A6)             ; $10443A
        ASR.W  D1,D6                            ; $104440
        MOVE.W  A2,D4                           ; $104442
        AND.W  D1,(A6)                          ; $104444
        AND.L  -$275F(A4),D2                    ; $104446
        MOVE.W  A0,(A3)                         ; $10444A
        SUBA.W  -$76C3(A2),A5                   ; $10444C
        MOVE.B  -$77E3(A3),(A6)                 ; $104450
        ADD.L  D0,(A1)+                         ; $104454
        MOVE.L  -$0777(PC),(A5)                 ; $104456
        SUB.L  -$515E(A2),D5                    ; $10445A
        ROL.L  #6,D1                            ; $10445E
        SUBA.L  -$26(A6,A4.L),A4                ; $104460
        MOVE.W  -$20(A1,A2.W),(A4)+             ; $104464
        BCHG    D4,-(A0)                        ; $104468
        CMP.L  $68F5(A2),D5                     ; $10446A
        ROR.W  $1AE9(A1)                        ; $10446E
        BVC.S  loc_1044DC                       ; $104472
        MOVE.L  -$17(A1,A0.W),(A6)+             ; $104474
        OR.L   D7,$15AA(PC)                     ; $104478
        SUB.B  (A6),D1                          ; $10447C
        SUBQ.L  #4,-$27(A1,D1.L)                ; $10447E
        MOVE.B  (A0)+,D5                        ; $104482
        ROR.W  #5,D7                            ; $104484
        ADD.L  D4,(A1)+                         ; $104486
        CMP.L  $55(A2,D2.W),D2                  ; $104488
        MOVE.W  (A5)+,(A6)+                     ; $10448C
        CMPA.W  (A7)+,A1                        ; $10448E
        MOVEM.L -$16(A2,D0.L),D1/D6/D7/A1/A2/A6/A7; $104490
        MOVE.B  (A3),(A4)+                      ; $104496
        SUBQ.B  #2,A5                           ; $104498
        EOR.L  D5,-$0F(PC,D1.L)                 ; $10449A
        MOVE.W  (A3),(A4)+                      ; $10449E
loc_1044A0:
        MULS    -$2F(A2,D3.L),D7                ; $1044A0
        ADDA.L  -(A1),A0                        ; $1044A4
        CMP.B  D5,D5                            ; $1044A6
        SUBQ.B  #2,D1                           ; $1044A8
        MOVE.L  (A6)+,-$1601(A4)                ; $1044AA
        ADD.L  (A3)+,D5                         ; $1044AE
        SUBA.L  (A1)+,A3                        ; $1044B0
        DC.W    $0CBC,$A3C4,$B5AA,$E0F1,$28EA; $1044B2 CMPI.L  #$A3C4B5AA,#$E0F128EA
        MOVE.W  -(A2),(A0)+                     ; $1044BC
        SUB.L  D4,D4                            ; $1044BE
        AND.L  D1,-$16F5(A0)                    ; $1044C0
        ROXL.W  #4,D0                           ; $1044C4
        AND.B  D1,-$5568(A5)                    ; $1044C6
        AND.B  A2,D4                            ; $1044CA
        DC.W    $ABF9,$DADE,$E3C1   ; $1044CC MOVE.L  $DADEE3C1,<EA:3D>
        BVS.S  loc_1044A0                       ; $1044D2
        EOR.L  D1,(A4)+                         ; $1044D4
        EOR.B  D1,-(A4)                         ; $1044D6
        ADDQ.L  #4,(A0)+                        ; $1044D8
        MOVE.W  (A7)+,$30FC.W                   ; $1044DA
        MOVEA.W -$44(A4,A3.W),A3                ; $1044DE
        CMPA.L  -(A3),A6                        ; $1044E2
        MOVE.L  D2,(A4)                         ; $1044E4
        DC.W    $25BD,$B3F1         ; $1044E6 MOVE.L  <EA:3D>,-$0F(A2,A3.W)
        MOVEQ   #-$0E,D1                        ; $1044EA
        MOVE.W  $B3A44CA0,(A4)                  ; $1044EC
        AND.L  $90F1.W,D5                       ; $1044F2
        MOVE.W  $1F6A(A3),(A4)                  ; $1044F6
        DC.W    $143E               ; $1044FA MOVE.B  <EA:3E>,D2
        DC.W    $2FD4               ; $1044FC MOVE.L  (A4),<EA:3F>
        SCC     -$4E(A2,D7.L)                   ; $1044FE
        AND.W  D5,D7                            ; $104502
        MOVEQ   #-$27,D4                        ; $104504
        ADDQ.W  #2,(A1)+                        ; $104506
        MOVEA.W $CD1C.W,A4                      ; $104508
        CMPA.L  (A7)+,A1                        ; $10450C
        CMP.L  (A5)+,D5                         ; $10450E
        ADD.L  D1,(A0)+                         ; $104510
        MOVEQ   #-$27,D6                        ; $104512
        SUBQ.B  #2,(A5)                         ; $104514
        SUBA.L  -(A1),A7                        ; $104516
        MOVE.L  D2,(A4)+                        ; $104518
        BSET    D0,-$0E(A2,D4.L)                ; $10451A
        AND.L  D0,$FBF2ECE1                     ; $10451E
        SUBI.L  #$FE11E30F,A5                   ; $104524
        BSET    D0,-(A2)                        ; $10452A
        AND.L  -$4556(PC),D6                    ; $10452C
        MOVE.B  -$15(A7,D2.L),D1                ; $104530
        ADDQ.L  #8,-$7D7F(A4)                   ; $104534
        MOVE.L  D2,(A4)+                        ; $104538
        DC.W    $50FD               ; $10453A ST      <EA:3D>
        MOVE.L  A0,$5B(A6,A1.W)                 ; $10453C
        CMPA.L  -(A1),A3                        ; $104540
        BCLR    D7,$CA9BAA92                    ; $104542
        BSR.S  loc_10450B                       ; $104548
        MOVE.L  (A3)+,(A4)+                     ; $10454A
        ROL.W  -$66(A1,D5.W)                    ; $10454C
        ADDA.W  -$3B02(A3),A2                   ; $104550
        ADD.L  -(A2),D0                         ; $104554
        MOVE.L  (A5),(A5)                       ; $104556
        MULU    (A0)+,D1                        ; $104558
        MOVE.W  D0,(A1)                         ; $10455A
        MOVEQ   #-$47,D4                        ; $10455C
        CMPA.W  -(A1),A0                        ; $10455E
        DIVU    -(A1),D3                        ; $104560
        MOVE.W  $10(PC,D5.W),(A7)               ; $104562
        MOVE.W  -$5F(A1,A3.L),#$BA34            ; $104566
        ROXR.W  #3,D0                           ; $10456C
        ADDA.W  (A4),A5                         ; $10456E
        DC.W    $00D9               ; $104570 DC.W    $00D9
        MOVE.L  -$2668(A2),(A1)                 ; $104572
        ADD.L  (A1)+,D0                         ; $104576
        AND.B  (A1)+,D1                         ; $104578
        MOVE.W  -(A0),D2                        ; $10457A
        ADD.B  (A4),D6                          ; $10457C
        ASL.B  D0,D4                            ; $10457E
        MOVE.L  A6,D5                           ; $104580
        AND.W  D1,(A3)                          ; $104582
        SGE     (A2)+                           ; $104584
        MOVE.W  -(A0),(A6)                      ; $104586
        MOVE.W  -(A6),(A1)+                     ; $104588
        CMP.L  -(A2),D5                         ; $10458A
        MOVE.L  -$18B0(A4),(A5)+                ; $10458C
        CMP.L  -$78(A2,A5.W),D5                 ; $104590
        MOVE.W  (A0),(A1)+                      ; $104594
        LSL.B  D6,D0                            ; $104596
        SUB.B  -$2429(A0),D1                    ; $104598
        MOVE.W  -$1F(PC,A2.W),$0A(A3,D1.W)      ; $10459C
        DIVU    -$33(A4,D7.L),D4                ; $1045A2
        ASR.W  D5                               ; $1045A6
        MOVE.L  (A2),(A1)+                      ; $1045A8
        ADDQ.W  #8,(A6)                         ; $1045AA
        MULU    -(A1),D0                        ; $1045AC
        SUB.L  -$20(PC,A3.L),D5                 ; $1045AE
        DC.W    $0EDA               ; $1045B2 DC.W    $0EDA
        SVS     $08(A3,D1.W)                    ; $1045B4
        ASR.W  -$4928(A3)                       ; $1045B8
        MOVEA.W (A0),A2                         ; $1045BC
        SUB.W  D0,-$46D8(A2)                    ; $1045BE
        ADD.B  D5,-$2603(A6)                    ; $1045C2
        SUBQ.W  #2,(A4)                         ; $1045C6
        OR.L   D2,-$42(PC,A7.W)                 ; $1045C8
        MOVE.W  (A0),-(A0)                      ; $1045CC
        MOVE.W  (A6)+,-$0F(A0,A2.W)             ; $1045CE
        SUBA.W  (A1)+,A6                        ; $1045D2
        SUBQ.B  #2,D5                           ; $1045D4
        ADDQ.L  #4,(A4)                         ; $1045D6
        CMPA.W  (A4)+,A4                        ; $1045D8
        MOVE.L  -$4B(A3,A6.L),(A4)+             ; $1045DA
        SUBQ.L  #8,-(A2)                        ; $1045DE
        SUBQ.L  #8,(A5)+                        ; $1045E0
        MOVE.W  (A5),(A0)+                      ; $1045E2
        TST.L  D0                               ; $1045E4
        SUBA.L  (A3),A4                         ; $1045E6
        ROXL.W  D0,D2                           ; $1045E8
        MOVE.W  (A0),-$32(A0,A7.W)              ; $1045EA
        MOVE.W  (A2),(A7)                       ; $1045EE
        ROL.W  #$4A24                           ; $1045F0
loc_1045F4:
        MOVE.W  -$7635(A0),-(A7)                ; $1045F4
        ROL.L  D5,D4                            ; $1045F8
        DC.W    $FFC8               ; $1045FA MOVE.W  A0,<EA:3F>
        CMP.W  (A2)+,D3                         ; $1045FC
        MOVE.L  -$0F(A6,A2.L),-$434F(PC)        ; $1045FE
        MOVE.W  -(A0),$ECCD.W                   ; $104604
        DC.W    $E9FF               ; $104608 ASL.W  <EA:3F>
        ADDQ.W  #3,(A5)                         ; $10460A
        SUB.L  (A4)+,D0                         ; $10460C
        ROL.B  D7,D0                            ; $10460E
        MOVE.L  A4,-(A1)                        ; $104610
        ADD.L  D5,(A1)+                         ; $104612
        MOVE.W  D0,$FF60.W                      ; $104614
        EOR.B  D3,D1                            ; $104618
        DC.W    $4BA7               ; $10461A DC.W    $4BA7
        MOVE.L  (A0)+,$DFCA.W                   ; $10461C
        BVS.S  loc_1045F4                       ; $104620
        MOVE.L  (A2),(A2)                       ; $104622
        MULS    A1,D1                           ; $104624
        CMPA.L  -(A4),A6                        ; $104626
        SCC     $30B0(A1)                       ; $104628
        BSET    D4,-(A6)                        ; $10462C
        MOVE.L  $53DA(A4),D1                    ; $10462E
        MOVE.W  -(A2),$F350.W                   ; $104632
        CMP.L  $0CBF.W,D1                       ; $104636
        CMP.L  -(A2),D5                         ; $10463A
        DC.W    $FFFC,$99CB         ; $10463C MOVE.W  #$99CB,<EA:3F>
        CMPA.L  D0,A4                           ; $104640
        ADD.B  D0,D6                            ; $104642
        CMP.B  A3,D0                            ; $104644
        MOVEA.W (A0)+,A4                        ; $104646
        LEA     $7125.W,A2                      ; $104648
        CMP.L  #$D9F9D9DC,D5                    ; $10464C
        AND.W  D3,D3                            ; $104652
        SUB.W  D4,-(A2)                         ; $104654
loc_104656:
        ADDA.W  (A2)+,A6                        ; $104656
        DC.W    $B4FF               ; $104658 CMPA.W  <EA:3F>,A2
        DC.W    $5FFF               ; $10465A SLE     <EA:3F>
        MOVE.W  -(A4),-$01(A2,A4.W)             ; $10465C
        MOVEA.W (A5),A4                         ; $104660
        DC.W    $FFFD               ; $104662 MOVE.W  <EA:3D>,<EA:3F>
        DC.W    $35FF,$181F         ; $104664 MOVE.W  <EA:3F>,$181F(PC)
        DC.W    $53FF               ; $104668 SLS     <EA:3F>
        DC.W    $33FF,$5F56,$6686   ; $10466A MOVE.W  <EA:3F>,$5F566686
        ADDQ.B  #3,$E2F6.W                      ; $104670
        BNE.S  loc_104656                       ; $104674
        MOVE.W  (A7),D4                         ; $104676
        CMPA.W  (A2)+,A2                        ; $104678
        ASR.W  D0,D5                            ; $10467A
        BCS.S  loc_1046D3                       ; $10467C
        MOVEA.B -(A3),A3                        ; $10467E
        ADD.W  (A6),D4                          ; $104680
        SUB.L  $F888E133,D5                     ; $104682
        BSR.S  loc_104691                       ; $104688
        DC.W    $E1FD               ; $10468A ASL.W  <EA:3D>
        ASR.L  #8,D6                            ; $10468C
        DIVU    (A2)+,D3                        ; $10468E
        ADD.W  D4,-$6606(A0)                    ; $104690
        BCHG    D2,-$27(A0,A7.W)                ; $104694
        SUB.L  D7,A1                            ; $104698
        MOVE.W  D7,-(A6)                        ; $10469A
        ADDA.W  D1,A7                           ; $10469C
        MOVE.L  $6155.W,-(A5)                   ; $10469E
        NEG.L  $E2282928                        ; $1046A2
        MOVE.W  A0,-$0CBA(A0)                   ; $1046A8
        ASR.W  D1,D5                            ; $1046AC
        ROXR.W  #1,D5                           ; $1046AE
        BCS.S  loc_104726                       ; $1046B0
        MOVE.W  D4,(A1)+                        ; $1046B2
        CMP.B  (A0)+,D1                         ; $1046B4
        MOVE.L  -(A4),#$E13EC240                ; $1046B6
        ASR.W  #6,D4                            ; $1046BC
        SUBQ.W  #2,(A6)                         ; $1046BE
        DC.W    $1DE1               ; $1046C0 MOVE.B  -(A1),<EA:3E>
        MOVEQ   #-$0B,D6                        ; $1046C2
        ADD.L  $11B1(A1),D0                     ; $1046C4
        MOVE.L  -$1670(A2),(A6)+                ; $1046C8
        ROXL.W  #6,D5                           ; $1046CC
        BCLR    D4,(A3)                         ; $1046CE
        ADDA.L  (A5)+,A1                        ; $1046D0
        ADD.L  D1,-$48(A4,A5.W)                 ; $1046D2
        ROR.L  #5,D2                            ; $1046D6
        ADDA.W  D0,A5                           ; $1046D8
        MOVE.L  -(A0),-$57(A5,A2.W)             ; $1046DA
        BSET    D0,$3ED9(A1)                    ; $1046DE
        MOVE.W  -(A1),(A3)                      ; $1046E2
        DC.W    $0A05,$97DB         ; $1046E4 EORI.B  #$97DB,D5
        ADDA.W  (A3)+,A4                        ; $1046E8
        DBVC    D3,$0FDD95                      ; $1046EA
        SNE     D1                              ; $1046EE
        ADD.B  D1,D0                            ; $1046F0
        ADDQ.L  #8,A7                           ; $1046F2
        ADD.W  (A7)+,D5                         ; $1046F4
        MOVE.L  A1,-$1E(A2,D4.L)                ; $1046F6
        ADDQ.W  #1,(A5)                         ; $1046FA
        MOVEA.W -$54(A0,A6.L),A0                ; $1046FC
        ASL.W  A4                               ; $104700
        SUB.W  -$7C(A0,A1.W),D5                 ; $104702
        SUBQ.W  #4,-$0E4F(A4)                   ; $104706
        DC.W    $08CE,$DAF0         ; $10470A BSET    #16,A6
        AND.W  D5,$50(A7,A6.L)                  ; $10470E
        MOVE.L  -$5049(A2),(A5)                 ; $104712
        MOVE.L  $65(A0,A7.W),$64(A4,A5.W)       ; $104716
        MOVEA.W $64(A5,A4.W),A1                 ; $10471C
        MOVE.L  -(A0),-$36(A4,A7.L)             ; $104720
        MOVE.L  A0,(A7)+                        ; $104724
loc_104726:
        SUBA.W  -$48(A0,A2.L),A6                ; $104726
        AND.W  D4,(A0)+                         ; $10472A
        MOVE.L  -(A2),(A4)                      ; $10472C
        CMPA.W  (A3)+,A5                        ; $10472E
        DC.W    $00EA               ; $104730 DC.W    $00EA
        MOVE.L  $38DA(A2),(A2)                  ; $104732
        MOVE.L  -$21(A4,A1.L),(A0)+             ; $104736
        CMPA.W  $E231.W,A5                      ; $10473A
        DC.W    $FCBF               ; $10473E MOVE.W  <EA:3F>,(A6)
loc_104740:
        AND.L  D5,$2AE1(A2)                     ; $104740
        ROXR.L  #5,D0                           ; $104744
        ADDA.L  A7,A2                           ; $104746
        SUB.W  -$20(A1,A3.L),D5                 ; $104748
        MOVE.W  -(A0),(A6)                      ; $10474C
        AND.L  D4,-$38(A7,A6.W)                 ; $10474E
        ADD.L  D5,-(A1)                         ; $104752
        MOVE.L  (A0)+,(A4)+                     ; $104754
        ROL.B  D2,D2                            ; $104756
        CMPA.L  -$0C(PC,A5.W),A4                ; $104758
        MOVE.L  $10C1(A1),(A4)                  ; $10475C
        LSL.W  -(A6)                            ; $104760
        ADD.L  D4,-(A0)                         ; $104762
        DC.W    $C3FF               ; $104764 MULS    <EA:3F>,D1
        DC.W    $C0FD               ; $104766 MULU    <EA:3D>,D0
        MOVEM.W $6CF8(A2),D0/D1/D3/D4/D6/D7/A0/A1/A4/A5/A7; $104768
        DC.W    $ADE2               ; $10476E MOVE.L  -(A2),<EA:3E>
        OR.L   $87A35A99,D7                     ; $104770
        MOVEQ   #-$0E,D0                        ; $104776
        MULS    $36CA(A1),D6                    ; $104778
        DC.W    $AB7E,$E2A8         ; $10477C MOVE.L  <EA:3E>,-$1D58(A5)
        EOR.W  D2,(A6)+                         ; $104780
        SUBQ.W  #8,(A1)+                        ; $104782
        ASL.B  #1,D7                            ; $104784
        AND.L  D4,A2                            ; $104786
        MOVE.L  -$4714(A2),(A4)+                ; $104788
        SUB.L  D5,A1                            ; $10478C
        ADDQ.B  #2,#$E498                       ; $10478E
        ROXL.L  D6,D4                           ; $104792
        ADD.B  D0,-$3E58(A1)                    ; $104794
        SUBA.W  (A0),A5                         ; $104798
        MOVE.L  (A6)+,(A5)                      ; $10479A
        ADDA.L  (A1)+,A2                        ; $10479C
        ADDQ.L  #4,-$55C1(PC)                   ; $10479E
        ROR.L  D1,D5                            ; $1047A2
        SUB.L  D4,D1                            ; $1047A4
        CMPA.W  A2,A1                           ; $1047A6
        MULU    D6,D5                           ; $1047A8
        LSL.W  #$A550                           ; $1047AA
        MOVE.L  D0,-$47(A1,D3.W)                ; $1047AE
        DC.W    $04BD,$AAAA,$FA80   ; $1047B2 SUBI.L  #$AAAAFA80,<EA:3D>
        SUB.B  D6,-(A0)                         ; $1047B8
        CMP.B  A2,D0                            ; $1047BA
        ADDA.W  -$02(A4,A7.L),A5                ; $1047BC
        ADDA.W  -$23(A1,A7.L),A1                ; $1047C0
        MOVEQ   #-$1C,D4                        ; $1047C4
        MOVE.L  -$3926(A2),(A5)                 ; $1047C6
        MULS    -$04(A3,A7.L),D1                ; $1047CA
        CMPA.W  (A3)+,A3                        ; $1047CE
        ADDA.L  -$1E(A2,A4.L),A4                ; $1047D0
        MOVE.L  (A1)+,-$0F(A0,A3.L)             ; $1047D4
        TST.W  (A1)                             ; $1047D8
        MOVE.L  D1,(A4)+                        ; $1047DA
        MOVEQ   #-$26,D0                        ; $1047DC
        DC.W    $90FD               ; $1047DE SUBA.W  <EA:3D>,A0
        DC.W    $A8BD               ; $1047E0 MOVE.L  <EA:3D>,(A4)
        MOVE.W  -$695B(A0),-(A7)                ; $1047E2
        LEA     -$80(A4,A6.W),A3                ; $1047E6
        AND.W  D1,-(A2)                         ; $1047EA
        DC.W    $BBBD               ; $1047EC EOR.L  D5,<EA:3D>
        CMPA.L  (A3)+,A5                        ; $1047EE
        MOVE.W  -$5507(A0),$58(A7,A3.L)         ; $1047F0
        OR.L   D1,-(A0)                         ; $1047F6
        MOVE.W  D0,-$2529(A2)                   ; $1047F8
loc_1047FC:
        ASL.W  -(A0)                            ; $1047FC
        MOVE.L  -$5377(A0),(A6)                 ; $1047FE
        ROXL.L  D6,D1                           ; $104802
        MOVE.L  $093B(A0),(A4)                  ; $104804
        ADD.W  D4,D0                            ; $104808
        SUBA.W  -$56(A2,A2.W),A2                ; $10480A
        DIVU    $72(A2,A6.L),D7                 ; $10480E
        MULU    (A1)+,D1                        ; $104812
        ROR.B  #5,D0                            ; $104814
        DC.W    $FC77,$E903         ; $104816 MOVEA.W $03(A7,A6.L),A6
        SUB.L  A2,D5                            ; $10481A
        MOVE.L  -$0DD8(A7),D5                   ; $10481C
        MOVE.W  -$01(A1,A5.L),-$0B(A6,A7.L)     ; $104820
loc_104826:
        DC.W    $38FD               ; $104826 MOVE.W  <EA:3D>,(A4)+
        DC.W    $08FD,$C32A         ; $104828 BSET    #10,<EA:3D>
        MOVE.L  -(A5),(A0)+                     ; $10482C
        CMPA.W  A6,A6                           ; $10482E
        MOVE.W  -$3E16(A5),(A4)+                ; $104830
        MOVE.L  -$575E(A2),(A0)                 ; $104834
        MOVEA.B $D2F8D515,A5                    ; $104838
        MULS    #$F501,D1                       ; $10483E
        MOVEA.L (A5),A3                         ; $104842
        MULU    D3,D2                           ; $104844
        ADDA.W  A5,A2                           ; $104846
        EOR.W  D6,-(A4)                         ; $104848
        BCS.S  loc_104826                       ; $10484A
        SUBA.L  (A2)+,A5                        ; $10484C
        ADDA.W  (A2),A2                         ; $10484E
        DC.W    $098C               ; $104850 BCLR    D4,A4
        SUBI.L  #$722604AB,A6                   ; $104852
        TST.B  $1D82(A2)                        ; $104858
        MOVE.W  A1,(A6)                         ; $10485C
loc_10485E:
        CMPA.L  $14F5(A0),A4                    ; $10485E
        SUBA.W  (A6),A6                         ; $104862
        MOVE.W  -$5C(A3,A0.L),(A6)+             ; $104864
        ROL.W  (A4)                             ; $104868
        DC.W    $C5FF               ; $10486A MULS    <EA:3F>,D2
        MOVE.L  $48(A4,A5.W),-(A0)              ; $10486C
        MULU    A4,D3                           ; $104870
        MOVE.L  $1C(A0,A5.W),(A5)+              ; $104872
        ASR.B  D1,D3                            ; $104876
        MOVE.W  (A0)+,-(A7)                     ; $104878
        BLS.S  loc_1048AE                       ; $10487A
        MOVE.W  -(A2),-(A7)                     ; $10487C
        MOVE.W  (A2),-(A7)                      ; $10487E
        MOVE.W  (A1),-(A7)                      ; $104880
        OR.B   D2,D6                            ; $104882
        DC.W    $FFD1               ; $104884 MOVE.W  (A1),<EA:3F>
        DC.W    $FFCF               ; $104886 MOVE.W  A7,<EA:3F>
        MULU    -(A2),D1                        ; $104888
        BRA.S  loc_1048ED                       ; $10488A
        ASR.W  -(A1)                            ; $10488C
        MOVE.L  -(A0),(A4)+                     ; $10488E
        MOVE.W  (A7),D4                         ; $104890
        CMP.L  (A1),D0                          ; $104892
        MOVE.L  D0,-$16(A5,D1.W)                ; $104894
        MOVE.L  D2,-$27(A7,A7.W)                ; $104898
        MOVE.L  A2,$01(A4,A4.L)                 ; $10489C
        ORI.L  #$E2FCE248,A7                    ; $1048A0
        MOVE.B  D4,$20(A2,A6.W)                 ; $1048A6
        MOVE.L  A3,D0                           ; $1048AA
        LEA     -$512D(A5),A6                   ; $1048AC
        ADDA.W  D6,A6                           ; $1048B0
        BTST    D0,-$20(A5,D5.W)                ; $1048B2
        SHI     -(A0)                           ; $1048B6
        MOVE.W  (A0)+,D4                        ; $1048B8
        CMPA.W  $54(A5,A4.L),A4                 ; $1048BA
        SUBQ.L  #8,$2B(A1,A4.L)                 ; $1048BE
        ROXL.W  #4,D0                           ; $1048C2
        ADDA.L  -(A0),A0                        ; $1048C4
        MOVE.W  (A0),D4                         ; $1048C6
        MULU    $63(A0,A6.L),D0                 ; $1048C8
        SGE     D0                              ; $1048CC
        MOVE.W  (A3),D4                         ; $1048CE
        DC.W    $77FF,$87FF         ; $1048D0 MOVE.W  <EA:3F>,-$01(PC,A0.W)
        BVC.S  loc_10485E                       ; $1048D4
        ADD.L  $35(A1,A0.L),D7                  ; $1048D6
        MOVE.W  -$0066(A0),-$7E(A7,D4.W)        ; $1048DA
        DC.W    $7FEA,$AC88         ; $1048E0 MOVE.W  -$5378(A2),<EA:3F>
        DC.W    $D2FE               ; $1048E4 ADDA.W  <EA:3E>,A1
        ASR.W  $1CFF.W                          ; $1048E6
        MULU    $1EBD.W,D0                      ; $1048EA
        MOVE.L  A7,(A5)                         ; $1048EE
        BLE.S  loc_1048B5                       ; $1048F0
        MULU    D3,D5                           ; $1048F2
        MOVE.L  #$FFCCD3DC,-(A1)                ; $1048F4
        ADD.W  D1,A1                            ; $1048FA
        ADDA.L  A4,A0                           ; $1048FC
        MOVE.W  -(A3),(A4)+                     ; $1048FE
        DC.W    $0AED               ; $104900 DC.W    $0AED
        DC.W    $DDBE               ; $104902 ADD.L  D6,<EA:3E>
        DC.W    $DDBF               ; $104904 ADD.L  D6,<EA:3F>
        CMPA.L  -$00C4(A3),A6                   ; $104906
        DC.W    $0109               ; $10490A BTST    D0,A1
        MOVE.W  #$E0FF,D5                       ; $10490C
        ROXR.B  #8,D4                           ; $104910
        DC.W    $0EE2               ; $104912 DC.W    $0EE2
        DC.W    $E0FD               ; $104914 ASR.W  <EA:3D>
        OR.W   -$1D21(A1),D7                    ; $104916
        ADDA.W  $2350(A5),A7                    ; $10491A
        ASL.W  -$5320(A5)                       ; $10491E
        MULS    D0,D0                           ; $104922
        MOVEA.L A2,A6                           ; $104924
        DC.W    $FDE0               ; $104926 MOVE.W  -(A0),<EA:3E>
        ADDA.W  -(A0),A5                        ; $104928
        LSL.W  D6,D6                            ; $10492A
        BPL.S  loc_10490B                       ; $10492C
        ADDA.L  (A5)+,A7                        ; $10492E
        ROXL.B  D5,D0                           ; $104930
        DC.W    $0CDB               ; $104932 DC.W    $0CDB
        ROXR.L  D0,D5                           ; $104934
        DC.W    $BFFE               ; $104936 CMPA.L  <EA:3E>,A7
        MOVE.W  -$10(PC,A6.W),-$01AB(PC)        ; $104938
        DC.W    $5FFE               ; $10493E SLE     <EA:3E>
        SUBQ.B  #8,(A5)                         ; $104940
        MOVE.W  (A1),$2115(A6)                  ; $104942
        MOVE.L  (A4)+,-(A0)                     ; $104946
        MOVE.B  (A1),D1                         ; $104948
        MOVE.W  -(A1),D7                        ; $10494A
        MOVE.W  (A1),-(A7)                      ; $10494C
        MOVE.B  (A2),D2                         ; $10494E
        ASR.B  #1,D7                            ; $104950
        DC.W    $FEBF               ; $104952 MOVE.W  <EA:3F>,(A7)
        DC.W    $E0FF               ; $104954 ASR.W  <EA:3F>
        DC.W    $FFFB,$FBBF         ; $104956 MOVE.W  -$41(PC,A7.L),<EA:3F>
        ROXR.W  D1,D0                           ; $10495A
        MULU    (A0)+,D0                        ; $10495C
        MOVE.L  (A1),(A2)+                      ; $10495E
        SUBQ.B  #8,(A1)                         ; $104960
        MOVE.W  -(A1),(A6)+                     ; $104962
        MOVE.B  D0,D4                           ; $104964
        SCS     -(A1)                           ; $104966
        MOVE.L  -(A2),$F606.W                   ; $104968
        DIVU    -(A2),D2                        ; $10496C
        CMPA.W  (A7)+,A7                        ; $10496E
        DC.W    $E1FE               ; $104970 ASL.W  <EA:3E>
        ROXR.B  #1,D1                           ; $104972
        DC.W    $DBFF               ; $104974 ADDA.L  <EA:3F>,A5
        MOVE.W  (A7)+,-$42AB(PC)                ; $104976
        DC.W    $3FF1,$15C0         ; $10497A MOVE.W  -$40(A1,D1.W),<EA:3F>
        MOVEA.W $7841.W,A7                      ; $10497E
        MOVE.W  (A4),-(A7)                      ; $104982
        MOVE.B  -(A4),D2                        ; $104984
        MOVE.W  -(A1),D7                        ; $104986
        CLR.W  D1                               ; $104988
        CLR.B  $0CFF.W                          ; $10498A
        MOVEA.B D4,A1                           ; $10498E
        DC.W    $24FE               ; $104990 MOVE.L  <EA:3E>,(A2)+
loc_104992:
        CLR.W  D4                               ; $104992
        SUB.B  D0,-(A0)                         ; $104994
        MOVE.W  D4,-$0801(A3)                   ; $104996
        ASR.B  D1,D1                            ; $10499A
        MOVEA.L -$22(A1,A6.W),A1                ; $10499C
        ADDA.W  -(A0),A4                        ; $1049A0
        MOVE.L  -(A0),-(A0)                     ; $1049A2
        MOVE.L  -$1E21(A3),(A2)+                ; $1049A4
        MOVE.W  A6,D5                           ; $1049A8
        DIVU    D0,D0                           ; $1049AA
        MOVE.L  D0,(A2)+                        ; $1049AC
        MOVE.W  $14D8.W,-$38BC(A3)              ; $1049AE
        MOVEA.B D1,A2                           ; $1049B4
        ASR.W  -(A4)                            ; $1049B6
        MOVE.W  D7,(A6)                         ; $1049B8
        MOVE.B  $4474.W,$FF44.W                 ; $1049BA
        DC.W    $47FF               ; $1049C0 LEA     <EA:3F>,A3
        BSET    D7,D0                           ; $1049C2
        MOVEA.W $47(A4,D7.W),A4                 ; $1049C4
        MOVE.W  -$80(PC,D0.W),(A7)+             ; $1049C8
        DC.W    $F8FF               ; $1049CC MOVE.W  <EA:3F>,(A4)+
        MOVE.W  $09(A6,D2.W),(A5)+              ; $1049CE
        MOVE.W  -(A0),(A1)+                     ; $1049D2
        MOVE.W  A5,D4                           ; $1049D4
        ROR.W  (A6)+                            ; $1049D6
        ASR.W  $0A2C.W                          ; $1049D8
        DC.W    $23BC,$E0C8,$FCE0,$F3AB; $1049DC MOVE.L  #$E0C8FCE0,-$55(A1,A7.W)
        SNE     -(A0)                           ; $1049E4
        DC.W    $F9FC,$FFF8,$1D60   ; $1049E6 MOVE.W  #$FFF8,#$1D60
        OR.B   (A2)+,D0                         ; $1049EC
        CMP.W  (A1),D0                          ; $1049EE
        SUBQ.W  #7,#$6AE3                       ; $1049F0
        MOVE.W  (A5),D4                         ; $1049F4
        MOVE.W  A2,D6                           ; $1049F6
        ASR.W  D1,D6                            ; $1049F8
loc_1049FA:
        BNE.S  loc_104A61                       ; $1049FA
        MOVE.W  -(A2),(A5)                      ; $1049FC
        AND.W  (A2)+,D1                         ; $1049FE
        MOVE.W  -$3F(A6,A6.W),$7049(PC)         ; $104A00
        BVC.S  loc_104A44                       ; $104A06
        BPL.S  loc_104992                       ; $104A08
        MOVEA.L -$28(A4,D5.W),A1                ; $104A0A
        MOVE.W  (A5),$5F58(A6)                  ; $104A0E
        CMPA.W  -(A2),A1                        ; $104A12
        OR.W   -(A5),D3                         ; $104A14
        ADDA.W  D1,A6                           ; $104A16
        DC.W    $F97E,$F15F         ; $104A18 MOVE.W  <EA:3E>,-$0EA1(A4)
        SUBQ.W  #2,$2B48(A5)                    ; $104A1C
        DC.W    $0CF5               ; $104A20 DC.W    $0CF5
        MOVEQ   #-$5F,D6                        ; $104A22
        MOVEQ   #-$5E,D2                        ; $104A24
        MULU    D1,D2                           ; $104A26
        SUB.L  -$5F(A3,D5.L),D0                 ; $104A28
loc_104A2C:
        MOVE.L  -$56(A6,A6.L),-$51(A5,A7.W)     ; $104A2C
        MOVEM.W D1/D5/A0/A2/A6,-(A2)            ; $104A32
        OR.B   $669B(A1),D2                     ; $104A36
        SUB.L  D4,A1                            ; $104A3A
        OR.L   $B984D90D,D3                     ; $104A3C
        DC.W    $43A6               ; $104A42 DC.W    $43A6
loc_104A44:
        OR.L   D4,$99C19BEF                     ; $104A44
        SUB.L  (A1)+,D4                         ; $104A4A
        LSL.L  D7,D1                            ; $104A4C
        BVS.S  loc_104A55                       ; $104A4E
        SUBA.W  -$517A(A2),A0                   ; $104A50
        OR.B   (A4)+,D4                         ; $104A54
        EOR.W  D1,(A1)                          ; $104A56
        MOVE.L  -$10(A2,A0.W),$6D9F.W           ; $104A58
        DIVU    A5,D3                           ; $104A5E
        BCS.S  loc_1049FA                       ; $104A60
        MOVE.L  A5,(A4)                         ; $104A62
        ADDQ.L  #7,-$77A2(A0)                   ; $104A64
        ADD.L  D4,(A0)+                         ; $104A68
        SUB.W  D0,D0                            ; $104A6A
        MOVE.W  -(A5),$5F88(A0)                 ; $104A6C
        ADD.W  A0,D0                            ; $104A70
        EORI.W  #$261C,(A5)                     ; $104A72
        AND.B  -$3DBB(A0),D1                    ; $104A76
        AND.L  D0,D0                            ; $104A7A
        MOVEQ   #$13,D4                         ; $104A7C
        MOVE.W  -(A5),-(A7)                     ; $104A7E
        SUBA.W  D0,A2                           ; $104A80
        DC.W    $853E               ; $104A82 OR.B   D2,<EA:3E>
        MOVE.W  A7,D0                           ; $104A84
        MOVE.B  -(A0),D0                        ; $104A86
        MOVE.B  D1,$51(A2,D5.W)                 ; $104A88
        SUBQ.B  #7,(A4)                         ; $104A8C
        OR.L   D4,A2                            ; $104A8E
        MOVE.W  -(A0),$7E2C(A4)                 ; $104A90
        ADDQ.W  #1,A2                           ; $104A94
        NEGX   (A5)                             ; $104A96
        DC.W    $4B31               ; $104A98 DC.W    $4B31
        CMP.L  -$2E37(A1),D2                    ; $104A9A
        ORI.L  #$01998C82,(A1)+                 ; $104A9E
        CMPA.L  -(A3),A4                        ; $104AA4
        ROR.B  #1,D1                            ; $104AA6
        DC.W    $497C               ; $104AA8 DC.W    $497C
        BGT.S  loc_104A2C                       ; $104AAA
        BNE.S  loc_104A47                       ; $104AAC
        MOVEQ   #$21,D4                         ; $104AAE
        BVC.S  loc_104A6D                       ; $104AB0
        MOVE.B  -$05(A1,A1.L),(A0)              ; $104AB2
        MOVE.W  (A5),D2                         ; $104AB6
        BCLR    D2,$98093A24                    ; $104AB8
        DC.W    $4809               ; $104ABE DC.W    $4809
        DIVU    (A1)+,D6                        ; $104AC0
        MOVE.W  (A5)+,(A1)+                     ; $104AC2
        MOVE.L  (A4),(A0)+                      ; $104AC4
        BNE.S  loc_104AF9                       ; $104AC6
        MOVE.W  D0,D4                           ; $104AC8
        DC.W    $480C               ; $104ACA DC.W    $480C
        MOVEA.W D0,A6                           ; $104ACC
        BCLR    D5,-(A4)                        ; $104ACE
        BPL.S  loc_104B41                       ; $104AD0
        MOVE.L  D1,(A6)                         ; $104AD2
        MOVE.W  -(A0),D1                        ; $104AD4
        MOVE.L  A3,D0                           ; $104AD6
        OR.B   D7,-(A1)                         ; $104AD8
        ROXR.L  D4,D1                           ; $104ADA
        MOVE.L  -(A2),D0                        ; $104ADC
        DC.W    $C9FD               ; $104ADE MULS    <EA:3D>,D4
        BSR.S  loc_104B02                       ; $104AE0
        MOVE.L  D4,(A3)                         ; $104AE2
        MOVE.B  A1,D4                           ; $104AE4
        MOVE.W  A1,(A3)                         ; $104AE6
        OR.W   $689C(A7),D3                     ; $104AE8
        OR.L   A1,D7                            ; $104AEC
        SUB.B  (A0)+,D6                         ; $104AEE
        MOVEQ   #-$26,D7                        ; $104AF0
        SUBA.L  A4,A4                           ; $104AF2
        MOVE.W  (A1)+,-$37(A5,A4.L)             ; $104AF4
        AND.L  D4,(A4)+                         ; $104AF8
        AND.B  (A5),D6                          ; $104AFA
        CMP.W  (A0),D0                          ; $104AFC
        MOVE.W  (A7),$14(A2,D3.L)               ; $104AFE
loc_104B02:
        OR.B   $3426(A4),D3                     ; $104B02
        OR.B   $486C(A2),D4                     ; $104B06
        MOVEQ   #$21,D1                         ; $104B0A
        DC.W    $2DFF               ; $104B0C MOVE.L  <EA:3F>,<EA:3E>
        MOVE.W  A4,D4                           ; $104B0E
        DC.W    $04C9               ; $104B10 DC.W    $04C9
        SVC     -$56(A7,A1.W)                   ; $104B12
        OR.B   D1,D3                            ; $104B16
        EOR.L  D7,-$08(A2,A4.W)                 ; $104B18
        MOVE.B  -$6D91(PC),$55(A0,A1.W)         ; $104B1C
        DC.W    $F5FE,$A2AA         ; $104B22 MOVE.W  <EA:3E>,-$5D56(PC)
        MOVE.L  $129C.W,(A0)+                   ; $104B26
        MOVE.W  $E6F8.W,-(A0)                   ; $104B2A
        BTST    D5,$4598.W                      ; $104B2E
        MOVE.W  -$6F00(A7),-(A0)                ; $104B32
        ORI.W  #$F2F6,(A3)+                     ; $104B36
        EOR.W  D7,D1                            ; $104B3A
        OR.B   D1,D6                            ; $104B3C
        MOVE.W  (A7)+,$56F4(A5)                 ; $104B3E
        DIVU    -$0F(A1,A6.W),D6                ; $104B42
        SUB.L  A3,D4                            ; $104B46
        SUB.L  D5,D2                            ; $104B48
        DIVS    D1,D7                           ; $104B4A
        BVC.S  loc_104B38                       ; $104B4C
        MOVE.L  (A3)+,-$68(A1,A7.W)             ; $104B4E
        LSR.L  #5,D0                            ; $104B52
        DBVC    D6,$103E3C                      ; $104B54
        SUB.W  D1,-$7968(A6)                    ; $104B58
        MOVEA.W D6,A1                           ; $104B5C
        DC.W    $A3F8,$E9FC,$9DA9,$D80D; $104B5E MOVE.L  $E9FC.W,$9DA9D80D
        ST      $8A89.W                         ; $104B66
        MOVEA.L -$67D4(A1),A3                   ; $104B6A
        MOVE.W  D5,(A3)                         ; $104B6E
        MOVE.L  $51(A1,D5.W),(A0)+              ; $104B70
        AND.L  D1,D6                            ; $104B74
        MOVE.L  -$33D8(A0),-$09(A0,A1.W)        ; $104B76
        BCHG    D2,-$368A(PC)                   ; $104B7C
        MOVE.W  (A2)+,$E36BFE99                 ; $104B80
        SNE     $51(A1,A3.L)                    ; $104B86
        DBRA    D3,$10053C                      ; $104B8A
        LSR.W  -$7F(A6,D6.W)                    ; $104B8E
        SUB.L  D4,A0                            ; $104B92
        SPL     D7                              ; $104B94
        SUBA.L  D0,A0                           ; $104B96
        MOVE.W  -(A0),-$0FEF(A0)                ; $104B98
        SUB.B  (A0),D4                          ; $104B9C
        ADDQ.B  #7,-$57(A5,A7.L)                ; $104B9E
        MOVE.W  (A7)+,-$4457(A5)                ; $104BA2
        DIVS    $0F(A0,A7.W),D1                 ; $104BA6
        ROL.W  D1,D7                            ; $104BAA
        MULU    $38FD(A2),D0                    ; $104BAC
        DC.W    $89FF               ; $104BB0 DIVS    <EA:3F>,D4
        SUBQ.L  #1,A0                           ; $104BB2
        SUB.W  (A5),D5                          ; $104BB4
        MOVE.W  (A1)+,(A4)                      ; $104BB6
        AND.W  D5,-(A1)                         ; $104BB8
        ST      -(A7)                           ; $104BBA
        MOVE.W  -$08(A1,A0.L),(A7)+             ; $104BBC
        MOVE.W  -(A6),-$0EB0(A0)                ; $104BC0
        MOVEQ   #$5D,D1                         ; $104BC4
        BCHG    D2,(A1)+                        ; $104BC6
        ADDA.L  -(A6),A0                        ; $104BC8
        DBVS    D4,$10083C                      ; $104BCA
        SUBA.L  (A0)+,A0                        ; $104BCE
        MOVE.W  -$1E(A2,A7.W),$0D(PC,D0.L)      ; $104BD0
        MOVE.W  -$7E91(PC),-$67(A5,D2.L)        ; $104BD6
        OR.L   -(A0),D3                         ; $104BDC
        EORI.L  #$31C969B6,D2                   ; $104BDE
        DC.W    $49FF               ; $104BE4 LEA     <EA:3F>,A4
        MOVE.W  (A1),D4                         ; $104BE6
        CMP.B  -(A0),D0                         ; $104BE8
        BCHG    D4,(A6)                         ; $104BEA
        SCS     (A0)                            ; $104BEC
        MOVE.W  -$43AE(A1),(A2)+                ; $104BEE
        BVS.S  loc_104C50                       ; $104BF2
        MOVE.L  D4,$0D(A2,D3.W)                 ; $104BF4
        BCS.S  loc_104B84                       ; $104BF8
        DC.W    $001E,$268A         ; $104BFA ORI.B  #$268A,(A6)+
        SCS     (A5)                            ; $104BFE
        MOVEA.L D1,A2                           ; $104C00
        ADDQ.B  #2,$083C(A4)                    ; $104C02
        MOVEA.W -(A3),A0                        ; $104C06
        DC.W    $0CF0               ; $104C08 DC.W    $0CF0
        MOVE.B  (A0)+,$E00CFC81                 ; $104C0A
        ASR.L  D4,D2                            ; $104C10
        MOVE.L  D2,(A5)                         ; $104C12
        MOVE.W  D4,-(A2)                        ; $104C14
        LSR.W  -$1EB8(A3)                       ; $104C16
        DC.W    $4D30               ; $104C1A DC.W    $4D30
        MOVE.W  -(A3),$52(PC,A2.W)              ; $104C1C
        CMPA.W  (A3)+,A4                        ; $104C20
        ADDA.W  -$0878(A2),A7                   ; $104C22
        OR.L   A1,D3                            ; $104C26
        MOVE.W  $6FD1(A0),-$269B(A0)            ; $104C28
        CMPA.W  -$09D8(A1),A0                   ; $104C2E
        SLE     D5                              ; $104C32
        ADD.W  (A0)+,D5                         ; $104C34
        ROXL.W  -$7AAA(A1)                      ; $104C36
        BCS.S  loc_104C29                       ; $104C3A
        BRA.S  loc_104C1F                       ; $104C3C
        MOVEA.L -$691E(A2),A5                   ; $104C3E
        ADD.B  A5,D4                            ; $104C42
        MULU    -(A2),D4                        ; $104C44
        OR.L   -(A1),D0                         ; $104C46
        MOVE.L  $60A1(A2),(A4)+                 ; $104C48
        DIVU    $1466.W,D0                      ; $104C4C
loc_104C50:
        ADD.L  D2,-(A0)                         ; $104C50
        ADD.W  D0,(A1)+                         ; $104C52
        SNE     (A2)+                           ; $104C54
        BRA.S  loc_104C50                       ; $104C56
        MOVE.B  A2,(A3)                         ; $104C58
        MOVE.L  A7,D0                           ; $104C5A
        DC.W    $EDFF               ; $104C5C ROXL.W  <EA:3F>
        AND.W  A1,D6                            ; $104C5E
        SPL     (A1)                            ; $104C60
        MOVE.L  $3629EFFC,-(A7)                 ; $104C62
        ADD.W  $2928(A4),D6                     ; $104C68
        BSR.S  loc_104C66                       ; $104C6C
        DC.W    $ABC9               ; $104C6E MOVE.L  A1,<EA:3D>
        ROR.L  D5,D7                            ; $104C70
        AND.L  D4,D6                            ; $104C72
        SUB.W  D7,(A1)+                         ; $104C74
        SUB.B  D4,-(A7)                         ; $104C76
        OR.L   -$4668(PC),D1                    ; $104C78
        MOVE.W  -$68(PC,A2.L),-$11(A2,D3.W)     ; $104C7C
        CMP.B  -(A6),D3                         ; $104C82
        EOR.L  D4,D3                            ; $104C84
        EOR.L  D5,-$57F4(A3)                    ; $104C86
        BVS.S  loc_104C45                       ; $104C8A
        SUB.B  D4,(A0)                          ; $104C8C
        DC.W    $499A               ; $104C8E DC.W    $499A
        ADD.L  -(A1),D5                         ; $104C90
        MOVE.L  (A7)+,#$ADF8A1A9                ; $104C92
        MOVE.W  A1,(A4)                         ; $104C98
        CMPA.W  (A4)+,A6                        ; $104C9A
        MOVE.L  (A1)+,-$3277(A0)                ; $104C9C
        OR.B   (A1),D2                          ; $104CA0
        SUB.B  D5,-$53(A4,D4.L)                 ; $104CA2
        MOVE.L  -(A3),(A5)                      ; $104CA6
        MOVE.B  #$1081,-$74(A4,A3.L)            ; $104CA8
        DC.W    $0E4E               ; $104CAE DC.W    $0E4E
        MOVE.W  D5,#$23AF                       ; $104CB0
        MOVE.W  (A4),(A2)+                      ; $104CB4
        MOVEA.L (A2)+,A6                        ; $104CB6
        DIVS    (A2),D6                         ; $104CB8
        DC.W    $23F8,$FCF2,$99A9,$A181; $104CBA MOVE.L  $FCF2.W,$99A9A181
        BCHG    #9,-(A2)                        ; $104CC2
        MULU    (A2)+,D6                        ; $104CC6
        CMPA.L  $6856.W,A2                      ; $104CC8
        DC.W    $418B               ; $104CCC DC.W    $418B
        CMPA.L  $66(A1,D2.W),A5                 ; $104CCE
loc_104CD2:
        SUB.B  -(A6),D5                         ; $104CD2
        ROL.W  D4,D5                            ; $104CD4
        MOVE.L  (A0)+,$2A(A4,D0.L)              ; $104CD6
        EOR.L  D5,-$7637(A1)                    ; $104CDA
        MOVE.L  -$16D0(A1),-$68(A4,D6.W)        ; $104CDE
        MOVE.L  (A4),-(A2)                      ; $104CE4
        MOVE.W  (A4)+,-$5705(A1)                ; $104CE6
        MOVE.W  A0,(A3)                         ; $104CEA
        OR.B   (A7)+,D3                         ; $104CEC
        ASL.W  $60(PC,A7.W)                     ; $104CEE
        BSR.S  loc_104CD2                       ; $104CF2
        MOVE.L  $13(A7,D5.W),$E999.W            ; $104CF4
        SUB.L  (A3)+,D4                         ; $104CFA
        MOVE.W  $BB68FDDD,(A0)                  ; $104CFC
        EOR.W  D0,(A1)                          ; $104D02
        CMPI.B  #$8A67,-$749C(A2)               ; $104D04
        OR.L   D0,(A4)+                         ; $104D0A
        MOVE.L  -$556B(A3),(A0)+                ; $104D0C
        DC.W    $54BD               ; $104D10 ADDQ.L  #2,<EA:3D>
        OR.B   (A1)+,D5                         ; $104D12
        MOVE.L  -$7004(A4),$EFF2.W              ; $104D14
        LSR.B  #2,D7                            ; $104D1A
        ADD.B  -$29(A4,D5.W),D0                 ; $104D1C
        ADD.B  $10(A3,D0.W),D2                  ; $104D20
        BSET    D6,D0                           ; $104D24
        MOVE.B  (A2)+,(A3)+                     ; $104D26
        MOVE.L  D0,$181A(A1)                    ; $104D28
        MOVEA.W -(A6),A3                        ; $104D2C
        BLS.S  loc_104D21                       ; $104D2E
        MOVE.L  (A0),(A0)+                      ; $104D30
        MOVE.B  D5,-(A4)                        ; $104D32
        SUBQ.W  #2,-(A6)                        ; $104D34
        MOVE.W  -(A4),(A3)+                     ; $104D36
        ADDA.L  -$6703(PC),A4                   ; $104D38
        LSL.L  #5,D3                            ; $104D3C
        MOVEQ   #$13,D2                         ; $104D3E
        MOVEA.B $5555(A5),A0                    ; $104D40
        MOVEQ   #-$17,D2                        ; $104D44
        PEA     A1                              ; $104D46
        MOVE.W  (A2)+,(A6)+                     ; $104D48
        MOVE.L  $22(A2,A0.L),-$7866(A3)         ; $104D4A
        MOVE.W  $6B(A1,A3.W),(A2)               ; $104D50
        SUBQ.B  #2,-(A1)                        ; $104D54
        MOVE.B  -$1187(PC),(A4)                 ; $104D56
        BCLR    #17,$57A2(PC)                   ; $104D5A
        MOVE.W  -$5556(A1),(A4)                 ; $104D60
        MOVE.W  (A0)+,(A0)                      ; $104D64
        SUB.L  D0,$18(A0,A3.W)                  ; $104D66
        SUB.L  -$65(A6,A6.W),D5                 ; $104D6A
        LEA     D0,A0                           ; $104D6E
        ADDQ.B  #8,A7                           ; $104D70
        MOVE.L  (A2)+,D5                        ; $104D72
        DC.W    $F8FD               ; $104D74 MOVE.W  <EA:3D>,(A4)+
        EOR.W  D4,(A3)                          ; $104D76
        CLR.W  -(A1)                            ; $104D78
        SUBQ.L  #8,-(A2)                        ; $104D7A
        AND.L  D4,(A2)                          ; $104D7C
        MOVEM.W -(A2),D0/D2/D3/D5/D7/A0/A3/A4   ; $104D7E
        SUB.B  D5,(A5)                          ; $104D82
        SCC     -(A2)                           ; $104D84
        ADD.W  (A1),D0                          ; $104D86
        SUB.L  -(A2),D1                         ; $104D88
        EOR.B  D3,(A6)                          ; $104D8A
        MOVE.W  D0,$6FA3(A4)                    ; $104D8C
        SUB.W  D0,(A7)                          ; $104D90
        SCS     D0                              ; $104D92
        MOVE.L  A3,(A1)+                        ; $104D94
        MOVE.L  (A6)+,(A5)+                     ; $104D96
        SUB.L  D4,$70(A0,D4.L)                  ; $104D98
        DC.W    $73B9,$2934,$8F8D,$4359; $104D9C MOVE.W  $29348F8D,$59(A1,D4.W)
        BCLR    D2,-(A1)                        ; $104DA4
        DC.W    $4009               ; $104DA6 NEGX.B A1
        AND.L  -$0CF9(A4),D4                    ; $104DA8
        MOVE.W  A4,(A1)+                        ; $104DAC
        MOVE.W  -(A1),-(A1)                     ; $104DAE
        MOVE.L  -(A0),-$4F(A5,A0.W)             ; $104DB0
        ADD.W  D6,$6277(A0)                     ; $104DB4
        EOR.W  D0,(A3)+                         ; $104DB8
        SUB.B  -(A0),D1                         ; $104DBA
        DC.W    $0CFE               ; $104DBC DC.W    $0CFE
        AND.L  -$7A90(A2),D5                    ; $104DBE
        DC.W    $097E               ; $104DC2 BCHG    D4,<EA:3E>
        SUBA.W  $28(A5,D6.L),A1                 ; $104DC4
        ORI.W  #$7A1A,(A1)+                     ; $104DC8
        ADD.B  (A2)+,D6                         ; $104DCC
        DIVU    A2,D5                           ; $104DCE
        BHI.S  loc_104E45                       ; $104DD0
        SUBQ.L  #5,D2                           ; $104DD2
        CMP.B  -(A3),D2                         ; $104DD4
        ROR.W  D1,D0                            ; $104DD6
        BMI.S  loc_104E06                       ; $104DD8
        LSL.L  D2,D2                            ; $104DDA
        DC.W    $0EFC               ; $104DDC DC.W    $0EFC
        OR.B   (A2),D1                          ; $104DDE
        MOVE.W  (A1)+,-(A7)                     ; $104DE0
        EOR.B  D0,(A3)+                         ; $104DE2
        CMP.W  -$0F57(A3),D0                    ; $104DE4
        ADDA.L  (A3)+,A6                        ; $104DE8
        BCLR    D7,-(A4)                        ; $104DEA
        TST    (A5)+                            ; $104DEC
        AND.L  D5,$63(PC,A2.L)                  ; $104DEE
        MOVE.L  #$61AAAAD4,(A6)                 ; $104DF2
        MOVE.W  -(A3),(A1)+                     ; $104DF8
        BGT.S  loc_104DAF                       ; $104DFA
        LSL.B  D4,D4                            ; $104DFC
        MOVE.B  $242C(PC),(A5)                  ; $104DFE
        MOVE.W  A7,D2                           ; $104E02
        SUB.W  D0,-$567E(A4)                    ; $104E04
        MOVE.L  $52EC(A4),-$0D01(A0)            ; $104E08
        ASL.B  D4,D0                            ; $104E0E
        MOVE.B  -$7715(A3),$120A(PC)            ; $104E10
        AND.L  D5,A4                            ; $104E16
        ADDA.W  $5C88(A6),A0                    ; $104E18
        BSR.S  loc_104E40                       ; $104E1C
        MOVE.L  -(A0),(A5)                      ; $104E1E
        DC.W    $2EFD               ; $104E20 MOVE.L  <EA:3D>,(A7)+
        DC.W    $09BD               ; $104E22 BCLR    D4,<EA:3D>
        LSR.L  #5,D4                            ; $104E24
        MOVE.W  -$0856(A3),#$2A12               ; $104E26
        LSR.L  D5,D6                            ; $104E2C
        MOVE.B  -(A5),D1                        ; $104E2E
        OR.B   D2,$44(A2,A7.W)                  ; $104E30
        OR.W   D0,(A5)+                         ; $104E34
        MOVE.W  $6AC0(A3),-(A0)                 ; $104E36
        MOVE.L  (A5),D0                         ; $104E3A
        DC.W    $0CE4               ; $104E3C DC.W    $0CE4
        EOR.L  D7,A1                            ; $104E3E
loc_104E40:
        CMPA.W  A4,A6                           ; $104E40
        MOVE.L  D0,-(A1)                        ; $104E42
        NEGX.B (A5)+                            ; $104E44
        MOVE.L  (A5),$55BC(A5)                  ; $104E46
        ADDA.L  (A4),A5                         ; $104E4A
        MOVEA.B (A1)+,A6                        ; $104E4C
loc_104E4E:
        DC.W    $3BE4               ; $104E4E MOVE.W  -(A4),<EA:3D>
        ROR.B  #5,D2                            ; $104E50
        SUBA.W  $12(A5,A1.W),A5                 ; $104E52
        MOVE.L  A4,D1                           ; $104E56
        OR.W   D4,(A0)                          ; $104E58
        DC.W    $D1FF               ; $104E5A ADDA.L  <EA:3F>,A0
        ADDA.W  $6FF3(A2),A4                    ; $104E5C
        OR.W   -$07B7(A6),D6                    ; $104E60
        MOVE.L  -$34(A5,D4.L),$1C(A4,A2.L)      ; $104E64
        MOVE.W  -$46(A4,A0.L),$59(A1,D1.L)      ; $104E6A
        MOVEA.L -$19(A3,D0.L),A7                ; $104E70
        SUBQ.B  #2,D5                           ; $104E74
        MOVE.W  A2,(A4)+                        ; $104E76
        DC.W    $2FF1,$C042         ; $104E78 MOVE.L  $42(A1,A4.W),<EA:3F>
        ROXL.W  A1                              ; $104E7C
        BVC.S  loc_104E62                       ; $104E7E
        MOVE.B  $55(A1,A5.L),#$55F4             ; $104E80
        MOVE.L  -$6300(A5),-(A3)                ; $104E86
        MOVE.L  D0,(A5)                         ; $104E8A
        MOVEQ   #$50,D3                         ; $104E8C
        OR.W   -$64(A0,A6.L),D6                 ; $104E8E
        SUBA.L  -(A0),A6                        ; $104E92
        MOVE.W  (A5),-$5278(A7)                 ; $104E94
        ROL.B  D7,D0                            ; $104E98
        MOVE.L  (A5)+,(A1)+                     ; $104E9A
        OR.L   D4,$6A82(A2)                     ; $104E9C
        ROR.W  #5,D7                            ; $104EA0
        LSL.L  D4,D1                            ; $104EA2
        BLT.S  loc_104E48                       ; $104EA4
        MOVE.L  $499B(A2),D2                    ; $104EA6
        EOR.W  D4,$2C(A4,A1.L)                  ; $104EAA
        OR.L   D4,A0                            ; $104EAE
        OR.L   -$35(A7,D2.L),D5                 ; $104EB0
        MOVE.W  -$75E4(A2),-(A4)                ; $104EB4
        BRA.S  loc_104E4E                       ; $104EB8
        ADDQ.B  #8,-$54C8(A4)                   ; $104EBA
        CLR.B  D2                               ; $104EBE
        MOVEA.L -(A5),A1                        ; $104EC0
        SUB.W  D4,D0                            ; $104EC2
        ASR.W  -$076F(A0)                       ; $104EC4
        MOVE.L  (A4),D0                         ; $104EC8
        MOVE.W  (A1)+,(A0)+                     ; $104ECA
        BVS.S  loc_104E6C                       ; $104ECC
        MOVE.W  A1,(A6)+                        ; $104ECE
        TST.L  -(A0)                            ; $104ED0
        SUB.L  D2,(A2)+                         ; $104ED2
        ADD.B  (A2)+,D0                         ; $104ED4
        OR.W   D5,D4                            ; $104ED6
        LSR.L  #4,D0                            ; $104ED8
        SUBQ.W  #1,A1                           ; $104EDA
        EORI.W  #$40EA,D5                       ; $104EDC
        MOVE.W  $4756(A2),(A4)+                 ; $104EE0
        ADD.L  D6,$BA91B854                     ; $104EE4
        DBCS    D5,$103A6E                      ; $104EEA
        MOVEQ   #$7A,D6                         ; $104EEE
        EOR.L  D2,(A2)                          ; $104EF0
        CMP.L  A2,D1                            ; $104EF2
        OR.W   -(A2),D1                         ; $104EF4
        MOVE.L  D3,$50(A3,D5.W)                 ; $104EF6
        ROR.B  D6,D7                            ; $104EFA
        MOVE.W  #$2345,D6                       ; $104EFC
        DC.W    $0E69               ; $104F00 DC.W    $0E69
        MULS    A0,D2                           ; $104F02
        AND.B  -$74B0(A6),D1                    ; $104F04
        SCS     -$1FBF(A1)                      ; $104F08
        SLE     (A1)+                           ; $104F0C
        MULS    D1,D3                           ; $104F0E
        AND.W  D6,D4                            ; $104F10
        SUB.B  D4,$0443(PC)                     ; $104F12
        MOVE.L  D5,-(A2)                        ; $104F16
        BRA.S  loc_104F8B                       ; $104F18
        SUB.W  D4,(A2)                          ; $104F1A
        MOVEQ   #-$72,D6                        ; $104F1C
        MOVE.W  (A2),(A1)                       ; $104F1E
        MULS    $4155.W,D0                      ; $104F20
        SUB.W  -(A3),D2                         ; $104F24
        MOVE.W  $7009(A4),D6                    ; $104F26
        AND.B  D2,$645B(A2)                     ; $104F2A
        OR.W   $40F2(PC),D2                     ; $104F2E
        MOVE.B  (A5),-$03AD(A2)                 ; $104F32
        DC.W    $29F1,$3422,$E02E,$0BB2; $104F36 MOVE.L  $22(A1,D3.W),#$E02E0BB2
        MOVE.L  (A2),-(A1)                      ; $104F3E
        SUB.L  -(A1),D1                         ; $104F40
        MOVEA.L -(A2),A0                        ; $104F42
        MOVE.B  -(A0),(A6)+                     ; $104F44
        DIVU    $69(A0,A6.L),D4                 ; $104F46
        DIVU    $0931.W,D4                      ; $104F4A
        ADDQ.L  #3,A1                           ; $104F4E
        SUBQ.L  #8,A1                           ; $104F50
        DC.W    $45A9               ; $104F52 DC.W    $45A9
        ADD.L  D4,-$07A7(A2)                    ; $104F54
        AND.L  D0,D0                            ; $104F58
        MOVE.B  -(A5),-(A0)                     ; $104F5A
        MOVE.L  (A2),(A2)                       ; $104F5C
        BCC.S  loc_104FC6                       ; $104F5E
        MOVEA.W -(A4),A1                        ; $104F60
        BCLR    D1,$0A(A7,A2.L)                 ; $104F62
        AND.B  -$1F(PC,A0.L),D1                 ; $104F66
        CMPA.L  (A0),A5                         ; $104F6A
        SUBA.W  -$0EB8(A4),A1                   ; $104F6C
        SUBQ.L  #4,(A0)                         ; $104F70
        MOVE.W  (A2)+,$55DA(A5)                 ; $104F72
        MOVE.W  A3,(A0)+                        ; $104F76
        DIVU    -(A1),D3                        ; $104F78
        ROR.W  #6,D0                            ; $104F7A
        MOVE.W  $EAA8.W,-$7C(A6,D7.L)           ; $104F7C
        MOVEQ   #$00,D2                         ; $104F82
        ADDQ.L  #3,$5F(A4,A2.L)                 ; $104F84
        ORI.W  #$AC76,(A7)                      ; $104F88
        OR.B   D1,D0                            ; $104F8C
        SNE     #$E130                          ; $104F8E
        DC.W    $45AE               ; $104F92 DC.W    $45AE
        DC.W    $AABD               ; $104F94 MOVE.L  <EA:3D>,(A5)
        MOVE.B  D7,-(A1)                        ; $104F96
        ROR.L  D5,D3                            ; $104F98
        EOR.L  D4,(A4)+                         ; $104F9A
        OR.B   D4,-$2E80(A4)                    ; $104F9C
        EOR.W  D4,-$27F6(A4)                    ; $104FA0
        MOVEA.W A2,A0                           ; $104FA4
        SUB.L  $3868(A2),D1                     ; $104FA6
        BCHG    D4,(A2)                         ; $104FAA
        MOVE.B  $79(PC,D5.W),(A5)+              ; $104FAC
        EOR.L  D2,$4C79(A1)                     ; $104FB0
        DC.W    $4C72               ; $104FB4 DC.W    $4C72
        MOVE.L  A0,D5                           ; $104FB6
        ROR.B  #2,D7                            ; $104FB8
        ROL.W  #8,D3                            ; $104FBA
        MOVE.B  (A3)+,(A2)+                     ; $104FBC
        EOR.W  D5,D1                            ; $104FBE
        ROR.L  D1,D5                            ; $104FC0
        SUBQ.B  #8,-$4C07(A2)                   ; $104FC2
loc_104FC6:
        BCLR    D2,D3                           ; $104FC6
        AND.W  -$13(A6,A2.L),D2                 ; $104FC8
        ROXL.L  D7,D0                           ; $104FCC
        MOVE.L  $0C92(A2),(A5)                  ; $104FCE
        OR.B   $F7BB3015,D2                     ; $104FD2
        ROXL.L  #5,D4                           ; $104FD8
        ASL.W  -(A4)                            ; $104FDA
        OR.L   D2,D6                            ; $104FDC
        MOVE.L  (A5),(A5)+                      ; $104FDE
        MOVE.W  $51FA(A0),-$7B2E(A0)            ; $104FE0
        MOVE.B  -$3B0D(A6),(A6)+                ; $104FE6
        MOVE.L  -$5156(A1),(A4)+                ; $104FEA
        MOVE.L  $0AD2.W,(A4)+                   ; $104FEE
        MOVE.W  (A4)+,$DB72.W                   ; $104FF2
        MOVE.W  (A0)+,(A1)                      ; $104FF6
        ASL.W  #8,D0                            ; $104FF8
        ADD.L  D5,A0                            ; $104FFA
        LSR.B  #4,D1                            ; $104FFC
        MOVE.W  -(A4),-$6D56(PC)                ; $104FFE
        CMPA.W  $67(A1,D4.W),A2                 ; $105002
        CMPA.W  (A5)+,A6                        ; $105006
        ASL.W  D4,D0                            ; $105008
        MOVE.L  -(A1),D5                        ; $10500A
        ASR.W  D5,D4                            ; $10500C
        DC.W    $0AAA,$5AB8,$6917,$1105; $10500E EORI.L  #$5AB86917,$1105(A2)
        ADD.W  D4,(A2)                          ; $105016
        ROL.L  D0,D4                            ; $105018
        MOVE.W  D1,-$68(A5,A7.W)                ; $10501A
        MOVE.W  A5,(A6)+                        ; $10501E
        BSR.S  loc_10503B                       ; $105020
        SUBQ.W  #4,(A5)                         ; $105022
        SUB.B  (A5)+,D2                         ; $105024
        MOVE.L  (A4),-(A1)                      ; $105026
        DC.W    $4C74               ; $105028 DC.W    $4C74
        SPL     (A4)+                           ; $10502A
loc_10502C:
        ADD.W  -$1E2B(A1),D1                    ; $10502C
        MOVE.W  D2,-$4A5B(A1)                   ; $105030
        DC.W    $D9FD               ; $105034 ADDA.L  <EA:3D>,A4
        BHI.S  loc_10502C                       ; $105036
        BHI.S  loc_10505E                       ; $105038
        MOVE.W  A5,$921A.W                      ; $10503A
        DC.W    $0209,$4CE4         ; $10503E ANDI.B  #$4CE4,A1
        OR.B   D6,-(A5)                         ; $105042
        LSR.W  (A4)+                            ; $105044
        NOT.L  #$E2CB5455                       ; $105046
        MOVE.W  D4,D6                           ; $10504C
        ADDA.L  A4,A4                           ; $10504E
        SUBQ.L  #8,(A4)                         ; $105050
        ADD.L  D4,(A3)+                         ; $105052
        LSR.B  #2,D4                            ; $105054
        MOVEQ   #$0A,D0                         ; $105056
        SUB.W  $24E55155,D3                     ; $105058
loc_10505E:
        MOVEA.L A3,A2                           ; $10505E
        LEA     -$0E34(PC),A2                   ; $105060
        LSL.L  D4,D4                            ; $105064
        MOVE.L  $7C(A3,D6.L),$33AB(PC)          ; $105066
        DC.W    $8A3D               ; $10506C OR.B   <EA:3D>,D5
        MOVE.W  (A5)+,$82EA7C45                 ; $10506E
        DIVU    -(A1),D6                        ; $105074
        DC.W    $F7B9,$20E9,$CA46,$55D0; $105076 MOVE.W  $20E9CA46,-$30(A3,D5.W)
        MOVE.W  D4,-(A1)                        ; $10507E
        ADD.W  D4,(A6)+                         ; $105080
        MOVEQ   #-$27,D2                        ; $105082
        AND.B  D6,(A5)                          ; $105084
        DC.W    $45FD               ; $105086 LEA     <EA:3D>,A2
        LSR.W  D4,D1                            ; $105088
        BNE.S  loc_10506D                       ; $10508A
        ADDA.L  -(A4),A7                        ; $10508C
        MOVE.L  A7,D4                           ; $10508E
        MOVE.W  -(A1),$65(A4,A7.W)              ; $105090
        MOVE.W  (A5),$0A8A(A2)                  ; $105094
        BNE.S  loc_105109                       ; $105098
        SUBQ.L  #4,A7                           ; $10509A
        DIVS    -$24(A0,D4.W),D4                ; $10509C
        NEG.B  A0                               ; $1050A0
        BCLR    D4,-(A0)                        ; $1050A2
        MOVE.L  -$5E(A7,D2.L),(A5)+             ; $1050A4
        ADD.B  D4,A2                            ; $1050A8
        ASL.W  -$60(A0,A5.L)                    ; $1050AA
        DC.W    $4940               ; $1050AE DC.W    $4940
        MOVE.L  A3,D4                           ; $1050B0
        CMP.W  (A5),D5                          ; $1050B2
        MOVEA.W A1,A6                           ; $1050B4
        MOVE.B  $402C(A1),-$7678(PC)            ; $1050B6
        DC.W    $0AA9,$6631,$E950,$2D38; $1050BC EORI.L  #$6631E950,$2D38(A1)
        MOVE.L  -$554D(A5),$14(A4,A2.W)         ; $1050C4
        SUB.W  D4,(A5)                          ; $1050CA
        MOVE.B  (A2)+,(A2)                      ; $1050CC
        ADD.L  (A2)+,D6                         ; $1050CE
        DC.W    $47B2               ; $1050D0 DC.W    $47B2
        CMPA.W  $6473(A6),A0                    ; $1050D2
        OR.L   $30E9(A2),D1                     ; $1050D6
        MOVE.L  A5,-(A4)                        ; $1050DA
        CMP.W  A4,D4                            ; $1050DC
        MOVE.W  -$2319(A4),$6009(A0)            ; $1050DE
        BCHG    D0,$2AA99F4A                    ; $1050E4
        OR.B   A4,D2                            ; $1050EA
        BRA.S  loc_1050B8                       ; $1050EC
        CMPA.L  $50(A1,A6.L),A1                 ; $1050EE
        CMPI.B  #$6DAA,D0                       ; $1050F2
        SUBA.W  -$0D8C(A4),A1                   ; $1050F6
        DC.W    $53FE               ; $1050FA SLS     <EA:3E>
        ROXL.B  #4,D4                           ; $1050FC
        ADD.L  -$0E8C(A7),D5                    ; $1050FE
        MOVE.W  -(A4),$32(A5,A2.L)              ; $105102
        MOVE.B  A2,D0                           ; $105106
        ROR.W  #6,D2                            ; $105108
        MOVEQ   #-$2A,D4                        ; $10510A
        SUBA.W  -$1F(A3,D3.L),A4                ; $10510C
        MOVE.L  -$4258(A3),-$55C4(A2)           ; $105110
        ROXR.B  #2,D2                           ; $105116
        DC.W    $4F51               ; $105118 DC.W    $4F51
        ROXR.W  $5AF2(A6)                       ; $10511A
        ADDI.W  #$DFFC,$2A91(A5)                ; $10511E
        MOVEQ   #$64,D6                         ; $105124
        DIVS    $34F2(A3),D2                    ; $105126
        MOVE.B  -(A6),(A4)+                     ; $10512A
        DC.W    $387F               ; $10512C MOVEA.W <EA:3F>,A4
        MOVE.L  -$5F96(PC),(A5)+                ; $10512E
        DC.W    $347F               ; $105132 MOVEA.W <EA:3F>,A2
        MOVE.L  D0,(A6)+                        ; $105134
        BTST    D6,#$5D74                       ; $105136
        BGE.W  loc_1047FC                       ; $10513A
        MOVEA.L (A6),A5                         ; $10513E
        ADDQ.W  #3,(A7)+                        ; $105140
        MOVE.W  $5F68(A4),-$77(A2,A6.W)         ; $105142
        MOVE.W  (A1)+,-$78(A0,D6.W)             ; $105148
loc_10514C:
        MOVE.W  $50(A3,D3.L),D4                 ; $10514C
        DC.W    $0AC2               ; $105150 DC.W    $0AC2
        SPL     -$15(A4,A7.W)                   ; $105152
        MOVE.W  D7,$9A98.W                      ; $105156
        MOVE.W  -$4F(A1,D2.L),-$4F(A2,A4.L)     ; $10515A
        BSR.S  loc_10519B                       ; $105160
        ADDI.L  #$F2AFAACC,D1                   ; $105162
        BLE.S  loc_10514C                       ; $105168
        MOVEA.L (A5),A0                         ; $10516A
        DC.W    $FBD8               ; $10516C MOVE.W  (A0)+,<EA:3D>
        SUB.L  A2,D5                            ; $10516E
        ADDQ.W  #6,D1                           ; $105170
        MOVE.L  (A2)+,(A4)+                     ; $105172
        DC.W    $CB3D               ; $105174 AND.B  D5,<EA:3D>
        SUBQ.W  #2,-$3FE6(A7)                   ; $105176
        BVC.S  loc_105146                       ; $10517A
        BCLR    D4,(A2)                         ; $10517C
        ROXL.W  (A4)                            ; $10517E
        MOVE.W  (A1)+,-$47(A1,A1.L)             ; $105180
        EOR.B  D5,D3                            ; $105184
        ADD.L  D4,(A3)+                         ; $105186
        BCHG    D3,(A5)                         ; $105188
        ADDA.W  (A4),A0                         ; $10518A
        SUB.B  $8696.W,D4                       ; $10518C
        SUBA.W  (A7),A5                         ; $105190
        OR.W   D4,(A6)                          ; $105192
        SUBA.L  -$76AB(A4),A5                   ; $105194
        BCLR    D3,-(A7)                        ; $105198
        MOVE.W  -(A5),$8A48.W                   ; $10519A
        MOVE.W  D4,(A1)                         ; $10519E
        SUB.L  A0,D5                            ; $1051A0
        TST.W  $65FF(A0)                        ; $1051A2
        OR.L   -(A2),D0                         ; $1051A6
        ADD.L  (A4)+,D2                         ; $1051A8
        CMPA.L  -$7525(A0),A4                   ; $1051AA
        OR.L   D2,-$5817(A2)                    ; $1051AE
        SUB.L  (A7),D4                          ; $1051B2
        DC.W    $12FF               ; $1051B4 MOVE.B  <EA:3F>,(A1)+
        OR.L   D1,A0                            ; $1051B6
        MOVE.L  D4,-(A4)                        ; $1051B8
        MOVEQ   #-$80,D3                        ; $1051BA
        ROXR.W  $7A3C(A6)                       ; $1051BC
        MOVE.W  -(A5),-$0E33(A2)                ; $1051C0
        CMPA.L  -$1D46(A7),A6                   ; $1051C4
        MOVE.B  -$62(A0,D6.W),$6999(A4)         ; $1051C8
        SUB.B  -$14F2(A0),D1                    ; $1051CE
        ASR.W  A1                               ; $1051D2
        SUB.L  A1,D1                            ; $1051D4
        SUBQ.L  #1,(A6)+                        ; $1051D6
        BVS.S  loc_105197                       ; $1051D8
        EOR.L  D6,D0                            ; $1051DA
        BGE.S  loc_105201                       ; $1051DC
        MOVE.L  D3,$551C(A1)                    ; $1051DE
        OR.B   -(A2),D1                         ; $1051E2
        MOVE.W  -(A2),D5                        ; $1051E4
        BRA.S  loc_105250                       ; $1051E6
        MOVE.B  $2B(PC,A6.L),(A3)+              ; $1051E8
        DBGE    D4,loc_104740                   ; $1051EC
        ASR.L  D6,D0                            ; $1051F0
        DC.W    $40BE               ; $1051F2 NEGX.L <EA:3E>
        MOVE.L  -(A2),(A6)+                     ; $1051F4
        MOVEQ   #-$67,D0                        ; $1051F6
        ROL.B  #4,D1                            ; $1051F8
        EOR.B  D4,-$33(A5,D1.W)                 ; $1051FA
        AND.W  (A0)+,D6                         ; $1051FE
        DC.W    $412F               ; $105200 DC.W    $412F
        OR.L   -$4F(PC,A4.W),D5                 ; $105202
        ORI.W  #$0C0A,-$5F01(A0)                ; $105206
        DC.W    $92FF               ; $10520C SUBA.W  <EA:3F>,A1
        BSR.S  loc_1051E9                       ; $10520E
        SUB.L  -(A0),D7                         ; $105210
        MOVE.W  (A3),D4                         ; $105212
        MOVE.L  -$5F88(A2),(A5)                 ; $105214
        MOVE.B  (A4)+,-(A6)                     ; $105218
        SUB.L  -(A6),D1                         ; $10521A
        MOVEQ   #$12,D4                         ; $10521C
        EOR.L  D3,A1                            ; $10521E
        DC.W    $A9F3,$A399,$C7F8,$13B0; $105220 MOVE.L  -$67(A3,A2.W),#$C7F813B0
        OR.L   D3,-$5F20(A2)                    ; $105228
        OR.B   (A2),D0                          ; $10522C
        SUBA.W  -(A0),A2                        ; $10522E
        BCLR    D4,(A0)+                        ; $105230
        ROXR.W  D1,D4                           ; $105232
        SUB.L  D5,D0                            ; $105234
        SUB.B  (A0)+,D0                         ; $105236
        MOVE.W  D0,$09(A4,A1.W)                 ; $105238
        MOVE.L  $1978(A2),(A4)                  ; $10523C
        MOVEA.B $19(A7,A2.L),A4                 ; $105240
        MOVE.L  (A1)+,(A0)                      ; $105244
        MOVE.W  $1B99(A1),(A2)                  ; $105246
        MOVE.B  (A1)+,(A6)                      ; $10524A
        BRA.S  loc_105282                       ; $10524C
        MOVEQ   #-$47,D4                        ; $10524E
loc_105250:
        ROXL.B  #7,D0                           ; $105250
        MOVE.W  A0,$11(A4,A6.L)                 ; $105252
        OR.L   D0,A2                            ; $105256
        MOVE.W  D6,(A5)+                        ; $105258
        MOVE.W  (A4),-(A7)                      ; $10525A
        AND.L  -$4507(PC),D1                    ; $10525C
        DC.W    $ABF4,$0B49         ; $105260 MOVE.L  $49(A4,D0.L),<EA:3D>
        MOVEA.L -$5738(A0),A5                   ; $105264
        ASL.W  $A8E640A1                        ; $105268
        OR.L   D6,D0                            ; $10526E
        DC.W    $F5F9,$88DA,$E18A,$EA01; $105270 MOVE.W  $88DAE18A,-$15FF(PC)
        OR.L   -$5717(A0),D6                    ; $105278
        MOVEA.W -(A5),A0                        ; $10527C
        MOVE.W  -(A6),$3122(A4)                 ; $10527E
loc_105282:
        MOVE.W  (A5),-$020B(A6)                 ; $105282
        MOVE.W  (A2)+,-(A6)                     ; $105286
        ORI.W  #$FDDE,D2                        ; $105288
        DC.W    $FDD8               ; $10528C MOVE.W  (A0)+,<EA:3E>
        CMP.B  D0,D5                            ; $10528E
        DC.W    $ABF0,$AD93         ; $105290 MOVE.L  -$6D(A0,A2.L),<EA:3D>
        MOVE.W  -$1E27(A0),$6880(A4)            ; $105294
        MOVEA.B -$4247(A6),A6                   ; $10529A
        MOVEA.L $09(A2,D7.W),A3                 ; $10529E
        ADDQ.L  #3,D6                           ; $1052A2
        OR.W   $01(A1,A0.L),D0                  ; $1052A4
        MOVE.B  D7,#$E99A                       ; $1052A8
        SUB.L  (A0)+,D5                         ; $1052AC
        MOVE.B  D7,(A3)                         ; $1052AE
        CMP.W  -$4F(A1,A5.L),D4                 ; $1052B0
        CMP.B  (A0),D5                          ; $1052B4
        DC.W    $7BE2               ; $1052B6 MOVE.W  -(A2),<EA:3D>
        OR.L   D6,D3                            ; $1052B8
        CMPA.L  (A0),A2                         ; $1052BA
        ADDQ.L  #3,A1                           ; $1052BC
        SUB.W  (A7)+,D4                         ; $1052BE
        AND.L  D1,D3                            ; $1052C0
        BNE.S  loc_105316                       ; $1052C2
        AND.L  D0,D6                            ; $1052C4
loc_1052C6:
        CMPA.W  (A1)+,A0                        ; $1052C6
        MOVE.W  -(A2),D4                        ; $1052C8
        BSET    D2,(A0)                         ; $1052CA
        BRA.S  loc_1052A6                       ; $1052CC
        CMPI.W  #$92DA,D4                       ; $1052CE
        CMPA.W  -(A5),A7                        ; $1052D2
        MOVEQ   #$52,D1                         ; $1052D4
        SUB.L  D0,$5168(A2)                     ; $1052D6
        DC.W    $0CEA               ; $1052DA DC.W    $0CEA
        DC.W    $E7FF               ; $1052DC ROL.W  <EA:3F>
        MOVE.L  $71(A1,D1.L),-$765F(A2)         ; $1052DE
loc_1052E4:
        SUBQ.L  #5,A1                           ; $1052E4
        BVC.S  loc_10527D                       ; $1052E6
        AND.L  D3,A1                            ; $1052E8
        BLT.S  loc_1052D5                       ; $1052EA
        SUB.W  D6,D5                            ; $1052EC
        ADD.L  D4,$06(A3,D7.W)                  ; $1052EE
        MOVEQ   #-$3C,D5                        ; $1052F2
        BLT.S  loc_1052C6                       ; $1052F4
        MOVE.L  -$5755(A1),(A6)+                ; $1052F6
        SUB.W  (A7)+,D4                         ; $1052FA
        ROL.L  D4,D1                            ; $1052FC
        MOVE.L  (A5)+,(A4)+                     ; $1052FE
        AND.B  A5,D5                            ; $105300
        DC.W    $4908               ; $105302 DC.W    $4908
        ADD.L  -$7A(A7,D7.W),D7                 ; $105304
        DC.W    $FBF5,$A3AC         ; $105308 MOVE.W  -$54(A5,A2.W),<EA:3D>
        ASL.W  $5F5C(A1)                        ; $10530C
        SUB.W  D5,(A2)+                         ; $105310
        ROR.W  -$4668(A3)                       ; $105312
loc_105316:
        ROR.W  -$2447(A6)                       ; $105316
        SUB.L  A6,D0                            ; $10531A
        MOVE.W  (A1),-$0008(A2)                 ; $10531C
        BCLR    D7,-(A7)                        ; $105320
        MOVEQ   #-$3B,D5                        ; $105322
        LSL.L  #8,D0                            ; $105324
        ADDA.L  A3,A5                           ; $105326
        CMPA.L  (A4)+,A5                        ; $105328
        ADDQ.L  #4,(A1)                         ; $10532A
        ADD.W  D2,-(A0)                         ; $10532C
        EOR.L  D2,(A7)                          ; $10532E
        MOVE.W  A3,(A0)                         ; $105330
        MOVE.L  -$036F(A3),(A0)+                ; $105332
        MOVE.W  D3,D3                           ; $105336
        LSR.L  D1,D1                            ; $105338
        BNE.S  loc_105344                       ; $10533A
        MOVE.W  D4,-$46BA(A2)                   ; $10533C
        SUB.W  D4,-(A7)                         ; $105340
        DC.W    $D27F               ; $105342 ADD.W  <EA:3F>,D1
loc_105344:
        ADD.L  D0,(A2)+                         ; $105344
        AND.L  -$47(A7,D0.W),D6                 ; $105346
        SUB.L  -$6945(A3),D5                    ; $10534A
        DC.W    $71B9,$7CF1,$6AAA,$82FF; $10534E MOVE.W  $7CF16AAA,-$01(A0,A0.W)
        AND.L  -$36(A3,D3.W),D4                 ; $105356
        MOVE.W  -(A5),D4                        ; $10535A
        MOVE.L  -$14(A2,A1.L),(A0)              ; $10535C
        BGT.S  loc_1052E4                       ; $105360
        DC.W    $0A2E,$E1CA,$F16F   ; $105362 EORI.B  #$E1CA,-$0E91(A6)
        ADDQ.L  #8,-$69(A0,D0.L)                ; $105368
        SUB.L  D0,(A3)+                         ; $10536C
        MOVE.W  -$5724(A0),-(A2)                ; $10536E
        ADD.L  D4,-(A7)                         ; $105372
        MOVE.W  -(A0),$A03E.W                   ; $105374
        BGT.S  loc_10535B                       ; $105378
        DC.W    $2DC8               ; $10537A MOVE.L  A0,<EA:3E>
        AND.L  D0,(A1)+                         ; $10537C
        CMP.B  (A1)+,D5                         ; $10537E
        SUB.W  D4,$4DF1(A7)                     ; $105380
        MOVE.L  (A0)+,$42(A7,D7.L)              ; $105384
        SCS     D0                              ; $105388
        MULU    A2,D2                           ; $10538A
        MOVE.W  $6269(A1),(A4)                  ; $10538C
        DC.W    $3DE1               ; $105390 MOVE.W  -(A1),<EA:3E>
        BRA.S  loc_105387                       ; $105392
        SCS     -$6C7C(A1)                      ; $105394
        MOVEA.B $5FF0(PC),A4                    ; $105398
loc_10539C:
        ADD.B  D1,$E82A58B5                     ; $10539C
        DC.W    $06F2               ; $1053A2 DC.W    $06F2
        BSET    D1,-(A1)                        ; $1053A4
        MULS    -$5C(A1,D4.W),D1                ; $1053A6
        MOVEQ   #$5F,D1                         ; $1053AA
        SF      (A2)                            ; $1053AC
        MOVE.B  $70(A5,A5.L),-$24(A2,D1.W)      ; $1053AE
        ADD.B  -$01(A0,D0.L),D5                 ; $1053B4
        SUB.W  -(A2),D3                         ; $1053B8
        ASR.W  $0F68.W                          ; $1053BA
        SUBQ.B  #2,D4                           ; $1053BE
        DC.W    $1BE9,$6624         ; $1053C0 MOVE.B  $6624(A1),<EA:3D>
        BPL.S  loc_10539C                       ; $1053C4
        ROR.B  #4,D3                            ; $1053C6
        MOVE.L  -$6769(A4),-(A2)                ; $1053C8
        MOVE.B  D0,$1FE8(A2)                    ; $1053CC
        MOVEA.B $0E(A0,D6.W),A0                 ; $1053D0
        DC.W    $F4FF               ; $1053D4 MOVE.W  <EA:3F>,(A2)+
        ADD.L  D6,(A0)+                         ; $1053D6
        MOVE.W  (A4),$55D5(A0)                  ; $1053D8
        ASR.W  $0B1C.W                          ; $1053DC
        MULU    -$25D4(A1),D5                   ; $1053E0
        DC.W    $0A2C,$F27F,$C251   ; $1053E4 EORI.B  #$F27F,-$3DAF(A4)
        MOVE.L  (A6),-(A7)                      ; $1053EA
        MULU    $66D2F8F3,D5                    ; $1053EC
        DC.W    $BBBD               ; $1053F2 EOR.L  D5,<EA:3D>
        CMP.W  D4,D6                            ; $1053F4
        SUB.B  D6,A2                            ; $1053F6
        MOVEA.L #$C1AE417C,A5                   ; $1053F8
        DC.W    $22FD               ; $1053FE MOVE.L  <EA:3D>,(A1)+
        BVC.S  loc_1053AB                       ; $105400
        MOVE.W  A2,(A0)+                        ; $105402
        BTST    #26,$6811(A3)                   ; $105404
        BVS.S  loc_1053B1                       ; $10540A
        MULU    D4,D2                           ; $10540C
        LSR.W  #8,D2                            ; $10540E
        ROR.W  (A2)                             ; $105410
        ADDQ.L  #4,A2                           ; $105412
        DIVU    A2,D6                           ; $105414
        SUB.W  A4,D5                            ; $105416
        ADD.W  D3,(A5)                          ; $105418
        SCC     (A4)+                           ; $10541A
        MOVE.L  -(A7),$40(A5,A7.W)              ; $10541C
        ROL.L  D4,D6                            ; $105420
        MOVE.W  D0,$508D.W                      ; $105422
        MOVE.W  -$7A56(A2),-(A7)                ; $105426
        MOVE.L  A2,$24C7(A1)                    ; $10542A
        ADD.L  $32(PC,A2.L),D5                  ; $10542E
        BVC.S  loc_105460                       ; $105432
        BRA.S  loc_10545F                       ; $105434
        DC.W    $0A16,$082A         ; $105436 EORI.B  #$082A,(A6)
        BVC.S  loc_105452                       ; $10543A
        MOVE.L  $FA96BBCD,-(A3)                 ; $10543C
        MOVE.W  -$6A(A2,A0.W),-$67(A4,A1.W)     ; $105442
        EOR.L  D4,A2                            ; $105448
        SUB.L  D5,A4                            ; $10544A
        AND.L  D4,$083A1A53                     ; $10544C
loc_105452:
        DC.W    $3DDE               ; $105452 MOVE.W  (A6)+,<EA:3E>
        MOVE.W  (A1)+,-$03(A0,A6.L)             ; $105454
        ROR.W  D7,D4                            ; $105458
        EOR.W  D4,A5                            ; $10545A
        DBPL    D7,$103DCA                      ; $10545C
loc_105460:
        ADD.L  D0,(A3)+                         ; $105460
        MOVEA.L (A1),A0                         ; $105462
        EOR.L  D0,-(A4)                         ; $105464
        ASL.W  $7489(A4)                        ; $105466
        MOVE.B  D2,-$2387(PC)                   ; $10546A
        OR.B   (A2)+,D0                         ; $10546E
        OR.L   -$4732(A2),D7                    ; $105470
        ROR.L  D1,D4                            ; $105474
        DC.W    $0AD0               ; $105476 DC.W    $0AD0
        ADD.B  D3,D6                            ; $105478
        ADDA.L  -(A3),A4                        ; $10547A
        MOVE.B  -(A6),(A1)                      ; $10547C
        SUBA.L  (A3)+,A0                        ; $10547E
        SUB.L  #$55A3DEEC,D0                    ; $105480
        SVC     -$70ED(A6)                      ; $105486
        MOVE.L  -$6F(A1,A4.W),-$1D(A1,A4.L)     ; $10548A
        MOVE.L  -$7CEF(A2),D5                   ; $105490
        MOVEM.W D1/D4/D7/A1/A5/A7,(A2)          ; $105494
        ST      -$7790(A3)                      ; $105498
        DC.W    $0FFF               ; $10549C BSET    D7,<EA:3F>
        MOVE.W  (A2),-$1D(A7,D7.W)              ; $10549E
        MOVE.W  (A7),D4                         ; $1054A2
        MOVE.L  D6,(A5)                         ; $1054A4
        MOVE.W  (A4),-$60(A7,D0.L)              ; $1054A6
        MOVE.W  -(A0),-(A3)                     ; $1054AA
        SUB.B  D0,D0                            ; $1054AC
        LSR.B  #4,D2                            ; $1054AE
        ASR.B  D7,D5                            ; $1054B0
        ADDQ.B  #5,A7                           ; $1054B2
        SUB.L  (A4),D4                          ; $1054B4
        LSL.L  D5,D4                            ; $1054B6
        MOVE.W  (A0)+,$32(A0,A4.W)              ; $1054B8
        AND.L  D1,-(A1)                         ; $1054BC
        MOVE.L  A3,(A5)+                        ; $1054BE
        AND.B  (A0)+,D5                         ; $1054C0
        BHI.L  $3BCF88F                         ; $1054C2
        MOVE.W  -$4A7E(A1),-$17(A0,D6.L)        ; $1054C8
        ASR.L  D2,D3                            ; $1054CE
        SLT     $6844(A2)                       ; $1054D0
        AND.W  D4,$0B(A4,A5.L)                  ; $1054D4
        MOVE.W  $62B9(A4),-$67A0(A2)            ; $1054D8
        MOVE.B  A4,-$5E57(A0)                   ; $1054DE
        DC.W    $ABE7               ; $1054E2 MOVE.L  -(A7),<EA:3D>
        SUB.W  (A6)+,D5                         ; $1054E4
        MOVE.W  A1,$55(A0,D1.W)                 ; $1054E6
        MOVE.W  -(A2),(A6)+                     ; $1054EA
        SUBQ.W  #2,$5A(A3,D3.L)                 ; $1054EC
        LSL.L  D3,D0                            ; $1054F0
        SUB.B  -$78(A1,A6.W),D5                 ; $1054F2
        MOVE.W  (A5),-(A4)                      ; $1054F6
        MOVE.L  (A2)+,-(A2)                     ; $1054F8
        BHI.S  loc_10556C                       ; $1054FA
        ADDQ.B  #6,-$0B(A0,D7.W)                ; $1054FC
        SUB.W  D0,-(A2)                         ; $105500
        OR.B   (A0)+,D2                         ; $105502
        DC.W    $55FF               ; $105504 SCS     <EA:3F>
        OR.W   -(A5),D3                         ; $105506
        MOVE.W  (A6)+,$6138(A2)                 ; $105508
        BSR.S  loc_10553F                       ; $10550C
        ROXL.L  D4,D5                           ; $10550E
        MOVEA.W $5A15(A5),A3                    ; $105510
        ROXL.B  #4,D4                           ; $105514
        ADDQ.W  #5,-(A5)                        ; $105516
        DC.W    $3DCA               ; $105518 MOVE.W  A2,<EA:3E>
        ADDQ.W  #2,$66F4(A1)                    ; $10551A
        MOVE.L  A0,$6B(A0,A1.L)                 ; $10551E
        DBCS    D4,$1010BD                      ; $105522
        ADDQ.L  #8,-$27(A2,A6.L)                ; $105526
        ADDA.L  -(A0),A6                        ; $10552A
        MOVE.W  -$74(A4,A0.L),$8C40.W           ; $10552C
        MOVE.W  -$557F(A5),$12(A5,A6.L)         ; $105532
        AND.L  $93C9D12A,D5                     ; $105538
        MOVEQ   #$6B,D4                         ; $10553E
        DIVU    -$1B(A2,D2.W),D0                ; $105540
        CMP.W  (A5),D3                          ; $105544
        CMPA.L  -(A2),A5                        ; $105546
        ADDA.L  -(A1),A0                        ; $105548
        BLE.S  loc_105563                       ; $10554A
        MOVE.L  D6,$69(A0,D5.W)                 ; $10554C
        SUB.L  D5,D4                            ; $105550
        CMPA.L  $00(A1,A6.L),A4                 ; $105552
        MOVE.W  -(A5),-(A4)                     ; $105556
        MOVE.L  -(A0),$6009.W                   ; $105558
        DC.W    $AA7E               ; $10555C MOVEA.L <EA:3E>,A5
        SVS     (A0)                            ; $10555E
        ADDA.W  (A5)+,A5                        ; $105560
        EOR.L  D4,-(A0)                         ; $105562
        OR.B   -(A4),D5                         ; $105564
        CMPA.L  (A4)+,A0                        ; $105566
        BVS.S  loc_1055E2                       ; $105568
        MOVE.B  A6,D1                           ; $10556A
loc_10556C:
        LSR.W  #2,D2                            ; $10556C
        ADD.L  -$5C(A0,A3.L),D1                 ; $10556E
        DC.W    $553E               ; $105572 SUBQ.B  #2,<EA:3E>
loc_105574:
        DC.W    $08FF,$E21E         ; $105574 BSET    #30,<EA:3F>
        ADD.W  D4,-$72A6(A0)                    ; $105578
        ROXR.W  #6,D3                           ; $10557C
        BSET    #21,(A2)                        ; $10557E
        MOVE.B  (A1),(A4)+                      ; $105582
        SCC     -(A2)                           ; $105584
        MOVE.L  (A2)+,-$1F0D(PC)                ; $105586
        ADD.W  (A1)+,D3                         ; $10558A
        ASR.W  $52(A1,D0.L)                     ; $10558C
        BGE.S  loc_105574                       ; $105590
        SUBQ.B  #2,D7                           ; $105592
        MULU    -(A1),D7                        ; $105594
        MOVE.W  -$17(A1,D5.W),(A2)+             ; $105596
        ROR.L  D7,D1                            ; $10559A
        EOR.L  D0,A1                            ; $10559C
        SUB.L  $F450553F,D5                     ; $10559E
        BSET    D4,D2                           ; $1055A4
        MOVEA.L (A2)+,A7                        ; $1055A6
        ROL.W  (A4)+                            ; $1055A8
        AND.L  $58890099,D6                     ; $1055AA
        SCS     (A5)                            ; $1055B0
        MOVEA.W A2,A2                           ; $1055B2
        MOVE.B  A1,D3                           ; $1055B4
        CMPA.W  D2,A1                           ; $1055B6
        EORI.W  #$E0BC,(A1)                     ; $1055B8
        MOVE.B  -$1F(PC,A6.L),(A2)              ; $1055BC
        MOVEQ   #$2A,D6                         ; $1055C0
        OR.B   (A2),D5                          ; $1055C2
        CMPA.L  -(A0),A6                        ; $1055C4
        MOVEA.W D4,A7                           ; $1055C6
        ADD.W  -$4F6E(A4),D5                    ; $1055C8
        ADD.L  D7,$6014(A0)                     ; $1055CC
        ADDA.W  $29(A1,D3.W),A2                 ; $1055D0
        MULS    -$08(A1,D1.W),D3                ; $1055D4
        ASL.W  (A3)+                            ; $1055D8
        BCS.S  loc_105630                       ; $1055DA
        MOVE.W  -(A2),-$5E(A0,A1.W)             ; $1055DC
        DC.W    $E3FE               ; $1055E0 LSL.W  <EA:3E>
loc_1055E2:
        ADDA.W  -$15(A2,A0.W),A4                ; $1055E2
loc_1055E6:
        CMP.B  -$0C(A5,A7.L),D2                 ; $1055E6
        DIVS    (A5)+,D0                        ; $1055EA
        MOVE.W  -(A1),$BD68.W                   ; $1055EC
        ADDA.W  (A6),A5                         ; $1055F0
        BVS.S  loc_10559F                       ; $1055F2
        EOR.L  D4,(A2)                          ; $1055F4
        BCC.W  $10C2D4                          ; $1055F6
        ROXR.W  D6                              ; $1055FA
        MOVE.L  A5,(A1)+                        ; $1055FC
        MOVE.W  (A4),$55(A0,D5.L)               ; $1055FE
        MOVE.L  (A6)+,(A0)+                     ; $105602
        MOVE.W  A1,D1                           ; $105604
        CMP.L  (A2)+,D5                         ; $105606
        ROXL.W  #6,D6                           ; $105608
        ASR.L  #5,D5                            ; $10560A
        MOVE.L  -(A0),$17(A0,D7.W)              ; $10560C
        ASR.L  D2,D6                            ; $105610
        BVS.S  loc_1055BE                       ; $105612
        SUBQ.B  #2,-(A5)                        ; $105614
        BSET    D1,$67A3(A2)                    ; $105616
        MOVE.L  (A3)+,-$4C(A0,A6.W)             ; $10561A
        SUBQ.L  #2,-(A5)                        ; $10561E
        OR.L   D4,#$A4D5AEAC                    ; $105620
        MOVE.B  D4,-$5678(A3)                   ; $105626
        SUB.L  D5,(A4)                          ; $10562A
        SUBA.L  A5,A5                           ; $10562C
        MOVE.L  (A1),-(A6)                      ; $10562E
loc_105630:
        ADD.L  $0881(A4),D6                     ; $105630
        OR.L   A2,D5                            ; $105634
        CLR.L  (A3)                             ; $105636
        DC.W    $D0FE               ; $105638 ADDA.W  <EA:3E>,A0
        MOVEA.L $20(PC,D4.L),A0                 ; $10563A
        MOVE.L  D4,$A2B5.W                      ; $10563E
        MOVE.L  (A0)+,(A5)+                     ; $105642
        ADD.B  D6,$16(A7,A0.W)                  ; $105644
        SUB.L  #$407A0071,D2                    ; $105648
        ADDQ.W  #8,(A0)+                        ; $10564E
        BCHG    D6,-(A1)                        ; $105650
        LSL.L  D0,D2                            ; $105652
        MOVE.L  $9B586683,(A5)+                 ; $105654
        ROR.L  D3,D6                            ; $10565A
        BMI.S  loc_1055E6                       ; $10565C
        SUBA.L  (A4)+,A6                        ; $10565E
        MOVE.L  $5D(A1,D7.L),(A5)+              ; $105660
        ADD.W  A5,D5                            ; $105664
        TST    A4                               ; $105666
        ADDA.W  (A6)+,A7                        ; $105668
        LSR.W  D0                               ; $10566A
        ROL.L  #2,D0                            ; $10566C
        OR.L   D5,#$AA3921BB                    ; $10566E
        ADD.B  -(A0),D7                         ; $105674
        SUB.L  D2,-(A0)                         ; $105676
        ROL.W  $F340AA41                        ; $105678
        MOVE.L  (A7)+,$0B9A(A5)                 ; $10567E
        DC.W    $7BE4               ; $105682 MOVE.W  -(A4),<EA:3D>
        SUB.B  D1,D4                            ; $105684
        ADDA.L  A4,A4                           ; $105686
        MOVEA.W $977BAAAA,A4                    ; $105688
        SUB.L  $60A1(A1),D6                     ; $10568E
        AND.L  D3,D5                            ; $105692
        ADDA.W  A7,A4                           ; $105694
        ORI.L  #$E0F2C8F1,D4                    ; $105696
        DC.W    $070A               ; $10569C BTST    D3,A2
        MOVE.L  -(A5),D5                        ; $10569E
        BRA.S  loc_105706                       ; $1056A0
        MOVEA.L -$5749(A1),A0                   ; $1056A2
        OR.L   (A4)+,D6                         ; $1056A6
        ROR.L  #5,D2                            ; $1056A8
        CMP.W  A4,D5                            ; $1056AA
        LSR.W  $555D.W                          ; $1056AC
        MOVEQ   #-$0E,D4                        ; $1056B0
        SUB.B  (A3)+,D2                         ; $1056B2
        SUB.L  D2,(A3)+                         ; $1056B4
        CMP.L  (A1),D4                          ; $1056B6
        MOVE.W  #$F4E1,D4                       ; $1056B8
        BNE.S  loc_105647                       ; $1056BC
        CMPA.L  -(A1),A5                        ; $1056BE
        OR.B   D5,D1                            ; $1056C0
        LSR.L  D6,D1                            ; $1056C2
        BNE.S  loc_10572E                       ; $1056C4
        SUBQ.W  #8,-(A0)                        ; $1056C6
        DC.W    $CD3E               ; $1056C8 AND.B  D6,<EA:3E>
        BCLR    D0,$1AFA(A4)                    ; $1056CA
        MOVE.W  D0,-$65(A4,A0.L)                ; $1056CE
        DIVS    $10(A1,A0.W),D5                 ; $1056D2
        DC.W    $054A               ; $1056D6 BCHG    D2,A2
        MOVE.W  $4F68(A2),$23(PC,A5.W)          ; $1056D8
        EOR.B  D5,(A5)                          ; $1056DE
        DC.W    $553D               ; $1056E0 SUBQ.B  #2,<EA:3D>
        CMP.L  (A4)+,D6                         ; $1056E2
        MOVE.W  (A2),D2                         ; $1056E4
        SUB.L  -(A1),D2                         ; $1056E6
        ADD.L  D1,D4                            ; $1056E8
        CMP.W  -(A5),D5                         ; $1056EA
        ROXL.W  #4,D5                           ; $1056EC
        DC.W    $A17C,$FEC2,$D284,$16FB; $1056EE MOVE.L  #$FEC2D284,$16FB(A0)
        OR.B   (A4),D1                          ; $1056F6
        ROXR.L  D2,D6                           ; $1056F8
        CMPA.L  -(A0),A4                        ; $1056FA
        DC.W    $4D6C               ; $1056FC DC.W    $4D6C
        LSL.L  D4,D4                            ; $1056FE
        DIVU    -$4347(A1),D2                   ; $105700
        DC.W    $C97D               ; $105704 AND.W  D4,<EA:3D>
loc_105706:
        ROL.L  #4,D4                            ; $105706
        MOVE.L  A0,(A0)+                        ; $105708
        MOVEA.W $9B31A89A,A0                    ; $10570A
        CMPA.L  $A1E0.W,A4                      ; $105710
        ASR.W  A4                               ; $105714
        MULS    A1,D4                           ; $105716
        AND.L  (A4)+,D6                         ; $105718
        MOVE.W  A5,(A5)+                        ; $10571A
        ANDI.L  #$54E9E899,(A2)                 ; $10571C
        ROL.L  D7,D5                            ; $105722
        LSR.B  D4,D2                            ; $105724
        DC.W    $0018,$3BC6         ; $105726 ORI.B  #$3BC6,(A0)+
        ASL.W  D0                               ; $10572A
        ADDA.W  (A0)+,A1                        ; $10572C
loc_10572E:
        SUBA.W  (A3)+,A1                        ; $10572E
        MOVEQ   #$28,D7                         ; $105730
        SUBA.W  (A3),A0                         ; $105732
        MOVE.B  $30A9(A4),(A3)+                 ; $105734
        MOVE.W  -(A0),$29(PC,D3.W)              ; $105738
        MOVE.L  (A1)+,(A6)                      ; $10573C
        OR.W   D2,(A2)+                         ; $10573E
        ROXR.W  D6                              ; $105740
        ASR.L  D0,D2                            ; $105742
        ASR.W  -(A2)                            ; $105744
        BSET    #28,D3                          ; $105746
        DC.W    $C9FF               ; $10574A MULS    <EA:3F>,D4
        SUB.L  (A2)+,D4                         ; $10574C
        ROL.L  #5,D2                            ; $10574E
        OR.L   -$35CD(A2),D1                    ; $105750
        DIVS    $E3CA.W,D4                      ; $105754
        ASR.W  #$ECDA                           ; $105758
        MOVE.W  -(A2),(A5)+                     ; $10575C
        LSR.L  #8,D4                            ; $10575E
        EOR.W  D0,#$FF01                        ; $105760
        SUB.L  D4,A0                            ; $105764
        DIVU    A1,D5                           ; $105766
        CMPI.B  #$E845,$3E80(A2)                ; $105768
        OR.B   D6,-$7D10(A1)                    ; $10576E
        LSL.B  D1,D3                            ; $105772
        MOVE.L  $5CBA(A0),(A5)                  ; $105774
        DIVU    -(A2),D0                        ; $105778
        MOVE.W  -$66A7(A3),$2B(A7,A5.L)         ; $10577A
        SMI     D1                              ; $105780
        BVC.S  loc_105802                       ; $105782
        DIVU    D3,D0                           ; $105784
        DC.W    $E3FF               ; $105786 LSL.W  <EA:3F>
        MOVE.W  -$6F(PC,A7.L),$49(A0,D5.L)      ; $105788
        DC.W    $F3F3,$E828,$A242,$E2A0; $10578E MOVE.W  $28(A3,A6.L),$A242E2A0
        LSL.W  $14(A1,D5.W)                     ; $105796
        BSET    D3,-(A1)                        ; $10579A
        ADD.W  D7,$6E9A(A2)                     ; $10579C
        SUBQ.W  #8,$D9886915                    ; $1057A0
        SCC     -$6B(A7,A0.W)                   ; $1057A6
        MOVE.W  (A1)+,(A0)+                     ; $1057AA
        MOVE.W  A0,$6C(A7,A1.L)                 ; $1057AC
        DC.W    $CC7F               ; $1057B0 AND.W  <EA:3F>,D6
        OR.W   D1,(A1)                          ; $1057B2
        SUBQ.L  #2,-(A4)                        ; $1057B4
        EOR.W  D4,D1                            ; $1057B6
        ROL.L  #8,D4                            ; $1057B8
        ADDQ.L  #1,(A1)+                        ; $1057BA
        MOVE.L  -(A5),-$1D(A6,A6.W)             ; $1057BC
        MOVEQ   #-$6D,D4                        ; $1057C0
        MOVE.L  -(A0),(A7)                      ; $1057C2
        ADD.L  (A3)+,D4                         ; $1057C4
        MOVE.B  A2,(A6)+                        ; $1057C6
        MOVE.B  (A3)+,#$A282                    ; $1057C8
        SUB.L  D0,-(A2)                         ; $1057CC
        MOVE.L  -(A4),(A1)                      ; $1057CE
        CMPA.W  D1,A4                           ; $1057D0
        ASR.W  D1,D0                            ; $1057D2
        ROL.L  D3,D2                            ; $1057D4
        SUBQ.W  #2,(A5)                         ; $1057D6
        ADD.L  (A1)+,D5                         ; $1057D8
        OR.L   D4,$8486.W                       ; $1057DA
        LSL.W  $7ABC(A6)                        ; $1057DE
        MOVEA.W -$01E1(A4),A6                   ; $1057E2
        CMPA.L  -(A1),A0                        ; $1057E6
        MOVE.W  (A5),(A6)                       ; $1057E8
        SCC     D7                              ; $1057EA
        OR.L   D5,$594B(A4)                     ; $1057EC
        ROXR.L  #5,D4                           ; $1057F0
        MOVE.W  -(A0),(A0)                      ; $1057F2
        BCHG    D5,D0                           ; $1057F4
        LSL.B  #4,D5                            ; $1057F6
        MOVEQ   #-$6B,D1                        ; $1057F8
        MOVE.B  -(A5),(A5)                      ; $1057FA
        MOVE.W  A4,(A6)                         ; $1057FC
        OR.B   (A0),D2                          ; $1057FE
        MOVE.L  $4C(A1,A2.L),-$25(PC,A6.W)      ; $105800
        ADD.L  -(A0),D2                         ; $105806
        MOVE.W  (A7),(A4)                       ; $105808
        ADDA.L  (A7)+,A4                        ; $10580A
        AND.L  D0,(A0)                          ; $10580C
        ADDA.W  -$0778(A5),A5                   ; $10580E
        AND.W  A0,D2                            ; $105812
        MOVE.L  -(A0),D5                        ; $105814
        DC.W    $ECFF               ; $105816 ROXR.W  <EA:3F>
        MOVE.W  $4A63(A3),D0                    ; $105818
        ADD.B  D0,(A1)                          ; $10581C
        MOVEQ   #-$36,D6                        ; $10581E
        MOVE.L  (A0),(A5)+                      ; $105820
        ROL.L  #1,D0                            ; $105822
        MULS    (A3),D0                         ; $105824
        DIVS    -$2E(A0,D4.L),D5                ; $105826
        MOVEQ   #-$17,D2                        ; $10582A
        ADD.W  $58(A3,D3.W),D4                  ; $10582C
        SUBA.W  D1,A4                           ; $105830
        SUBA.W  (A2)+,A2                        ; $105832
        MOVEQ   #-$38,D0                        ; $105834
        MOVE.L  -(A4),(A0)+                     ; $105836
        ROXL.B  D6,D7                           ; $105838
        LSL.W  #6,D5                            ; $10583A
        SUB.L  D3,$490A(A1)                     ; $10583C
        LSR.W  (A5)+                            ; $105840
        MOVE.L  (A4)+,(A0)+                     ; $105842
        ADD.L  D5,$4C2A(A0)                     ; $105844
        MOVE.L  -(A2),(A5)                      ; $105848
        MOVE.W  A3,(A4)+                        ; $10584A
        MOVE.W  -$48A5(A2),(A6)+                ; $10584C
        ADDQ.W  #5,D1                           ; $105850
        DC.W    $1FCB               ; $105852 MOVE.B  A3,<EA:3F>
        ADD.L  -$55FE(A2),D4                    ; $105854
        MOVE.W  D3,(A1)+                        ; $105858
        MOVE.W  #$B5E0,(A5)+                    ; $10585A
        CMP.B  (A4)+,D0                         ; $10585E
        ADD.L  D7,-(A0)                         ; $105860
        MOVE.B  A4,-$4FEF(PC)                   ; $105862
        CMP.L  (A0)+,D2                         ; $105866
        DC.W    $0FFF               ; $105868 BSET    D7,<EA:3F>
        MOVE.W  (A3)+,D4                        ; $10586A
        MOVEA.L (A2)+,A5                        ; $10586C
        MOVE.W  -$5F08(A2),(A6)+                ; $10586E
        MOVE.B  -(A7),-(A5)                     ; $105872
        MOVE.W  -(A0),D6                        ; $105874
loc_105876:
        MOVE.L  (A1)+,D4                        ; $105876
        MULU    #$8121,D1                       ; $105878
        DC.W    $FFF8,$1686         ; $10587C MOVE.W  $1686.W,<EA:3F>
        ASR.B  D1,D3                            ; $105880
        SUBQ.W  #2,(A5)                         ; $105882
        BHI.S  loc_105827                       ; $105884
        MOVE.L  -(A3),D0                        ; $105886
        MOVE.W  -$3F08(A3),(A6)                 ; $105888
        BCHG    D6,(A4)+                        ; $10588C
        ASL.W  (A4)+                            ; $10588E
        MOVE.W  D0,D6                           ; $105890
        MOVE.W  (A5),D4                         ; $105892
        LEA     D3,A6                           ; $105894
        SUB.W  (A4),D2                          ; $105896
        ADD.L  D0,D6                            ; $105898
loc_10589A:
        MOVE.L  (A7),D0                         ; $10589A
        ASL.L  #1,D0                            ; $10589C
        MOVE.L  (A4)+,D0                        ; $10589E
        BRA.S  loc_10589A                       ; $1058A0
        DC.W    $1E3E               ; $1058A2 MOVE.B  <EA:3E>,D7
        MULU    (A5),D5                         ; $1058A4
        OR.B   -(A0),D1                         ; $1058A6
        AND.B  (A3)+,D4                         ; $1058A8
        OR.W   D7,A1                            ; $1058AA
        BRA.S  loc_105876                       ; $1058AC
        MOVE.B  $EABDA0E9,(A6)+                 ; $1058AE
        MOVE.W  -$5F70(A2),(A5)                 ; $1058B4
        LSR.W  (A3)+                            ; $1058B8
        BVS.S  loc_105843                       ; $1058BA
        ADDQ.W  #1,-(A3)                        ; $1058BC
        ADD.L  D5,-$2D(A0,D7.L)                 ; $1058BE
        ASR.W  (A4)                             ; $1058C2
        MOVE.L  $4C70(A2),(A5)                  ; $1058C4
        BCHG    D4,-$5D38(A0)                   ; $1058C8
        ADDA.L  -(A2),A0                        ; $1058CC
        ROXL.L  D0,D0                           ; $1058CE
        MOVE.W  -$1528(A0),-$0F(A5,A6.L)        ; $1058D0
        AND.L  D4,-$45A0(A2)                    ; $1058D6
        BHI.W  loc_104421                       ; $1058DA
        MOVEQ   #$24,D1                         ; $1058DE
        MOVE.W  -(A5),-(A4)                     ; $1058E0
        ASL.W  #8,D0                            ; $1058E2
        DC.W    $4989               ; $1058E4 DC.W    $4989
        LSR.W  A4                               ; $1058E6
        AND.L  D5,$5525(A2)                     ; $1058E8
        TST    D0                               ; $1058EC
        MOVE.W  -$2C(A4,A6.W),$7AA0(A7)         ; $1058EE
        MOVE.L  (A7)+,$56C2(A0)                 ; $1058F4
        MOVE.W  -(A2),D0                        ; $1058F8
        MOVE.L  -(A2),(A0)+                     ; $1058FA
        SUBQ.L  #2,$09(A5,A3.W)                 ; $1058FC
        MOVE.W  D4,(A5)+                        ; $105900
        ORI.L  #$8082801A,D5                    ; $105902
        ADDA.W  $71(A2,A3.W),A4                 ; $105908
        SUBQ.L  #2,A5                           ; $10590C
        MOVE.L  $55(PC,A2.W),(A5)+              ; $10590E
        ROL.W  D0,D1                            ; $105912
        MOVE.W  -(A1),-$1F03(PC)                ; $105914
        DC.W    $06F2               ; $105918 DC.W    $06F2
        DC.W    $492A               ; $10591A DC.W    $492A
        MOVE.B  A3,(A2)+                        ; $10591C
        MOVE.W  (A5),-$006F(A7)                 ; $10591E
        MOVE.W  -$3E83(A0),$5637(A1)            ; $105922
        LSR.L  #8,D7                            ; $105928
        BSET    D4,-$16(A5,A7.L)                ; $10592A
        MOVE.L  -$0E(A4,A6.L),(A0)              ; $10592E
        SUB.L  D4,$D1B98926                     ; $105932
        MOVE.B  -(A5),-$7720(PC)                ; $105938
        SUB.L  D0,-$1B6D(PC)                    ; $10593C
        LEA     (A1)+,A3                        ; $105940
        EORI.L  #$E5A83671,A2                   ; $105942
        BTST    D4,D5                           ; $105948
        SUB.L  #$DBAA76FE,D5                    ; $10594A
        MOVE.L  (A2),(A6)                       ; $105950
        ADD.L  D4,-$042F(PC)                    ; $105952
        MULU    -$57(A2,D0.W),D4                ; $105956
        MOVE.L  D0,D6                           ; $10595A
        MOVE.W  A3,#$BC51                       ; $10595C
        SUBQ.L  #2,A3                           ; $105960
        BLS.S  loc_105954                       ; $105962
        LSL.L  #6,D1                            ; $105964
        MOVEA.L -(A2),A0                        ; $105966
        NEGX   (A4)                             ; $105968
        CMPA.L  -(A1),A1                        ; $10596A
        MOVE.B  $0B56(A3),$63C1(A7)             ; $10596C
        MOVE.L  D0,(A6)                         ; $105972
        MULU    (A4)+,D2                        ; $105974
        OR.W   D3,-(A2)                         ; $105976
        SUBA.L  -$4C(A4,D2.L),A4                ; $105978
        MOVE.W  (A0),$41E9(A0)                  ; $10597C
        ADD.L  -(A2),D6                         ; $105980
        MOVE.W  -(A1),(A2)                      ; $105982
        MOVE.L  -(A4),(A6)+                     ; $105984
        MOVE.W  $731F(A0),(A4)                  ; $105986
        OR.B   -$67F7(A4),D1                    ; $10598A
        CMPA.W  A2,A6                           ; $10598E
        CMPA.W  A2,A5                           ; $105990
        LSR.L  D0,D4                            ; $105992
        CMP.W  A2,D6                            ; $105994
        MOVE.W  (A4)+,$DEB4DAD5                 ; $105996
        MOVE.W  -(A0),(A1)+                     ; $10599C
        CMP.L  -$3E36(A4),D6                    ; $10599E
        ORI.L  #$F9F6BDA9,(A3)                  ; $1059A2
        MULU    -(A0),D5                        ; $1059A8
        CMPI.B  #$6F76,D5                       ; $1059AA
        AND.L  -$5318(A0),D0                    ; $1059AE
        MOVEQ   #-$1F,D5                        ; $1059B2
        DC.W    $00AB,$F8B9,$AC30,$0CAA; $1059B4 ORI.L  #$F8B9AC30,$0CAA(A3)
        OR.W   D2,D7                            ; $1059BC
        SUB.W  D7,-(A2)                         ; $1059BE
        MOVE.L  -$26CD(A2),(A0)+                ; $1059C0
        MOVE.W  D4,-$18(A6,A5.L)                ; $1059C4
        MOVE.W  $79(A2,A6.W),(A6)+              ; $1059C8
        MOVE.L  (A7),$1B32(A4)                  ; $1059CC
        MOVE.W  (A1)+,(A1)                      ; $1059D0
        CMPA.L  -(A0),A4                        ; $1059D2
        MOVEQ   #$13,D4                         ; $1059D4
        ADDA.W  A2,A5                           ; $1059D6
        ROL.W  A1                               ; $1059D8
        DC.W    $CBBE               ; $1059DA AND.L  D5,<EA:3E>
        MULS    (A4)+,D4                        ; $1059DC
        AND.W  D1,(A0)+                         ; $1059DE
        MOVE.W  A4,(A4)+                        ; $1059E0
        ROR.L  D1,D3                            ; $1059E2
        SUBA.L  -(A1),A5                        ; $1059E4
        DC.W    $1BE0               ; $1059E6 MOVE.B  -(A0),<EA:3D>
        MOVE.W  (A5)+,D7                        ; $1059E8
        MOVE.B  D4,(A5)+                        ; $1059EA
        AND.W  -(A4),D5                         ; $1059EC
        MULU    (A4)+,D5                        ; $1059EE
        ADD.B  D4,D6                            ; $1059F0
        MULS    D4,D4                           ; $1059F2
        MOVE.W  (A1),-$56(A1,A2.L)              ; $1059F4
        MOVE.W  -$4F(PC,A3.L),-$02(A0,A6.W)     ; $1059F8
        SUB.W  D3,D6                            ; $1059FE
        DC.W    $13F1,$447E,$E075,$AAAA; $105A00 MOVE.B  $7E(A1,D4.W),$E075AAAA
loc_105A08:
        MOVEA.L A3,A2                           ; $105A08
        MULU    -$1318(A2),D2                   ; $105A0A
        BSET    D5,-(A0)                        ; $105A0E
        MOVE.W  (A3),D4                         ; $105A10
        ASR.L  #8,D3                            ; $105A12
        BCLR    D3,D0                           ; $105A14
        DC.W    $157D,$7BE4         ; $105A16 MOVE.B  <EA:3D>,$7BE4(A2)
        ADD.B  (A3)+,D4                         ; $105A1A
        ADDQ.W  #3,(A5)                         ; $105A1C
        MOVE.B  -$3FF3(A2),(A2)                 ; $105A1E
        SUB.B  -$38(A4,A5.W),D4                 ; $105A22
        AND.W  D5,-$50(A2,A5.L)                 ; $105A26
        LSL.L  D4,D0                            ; $105A2A
        ADD.L  (A1),D5                          ; $105A2C
        ASR.B  #1,D1                            ; $105A2E
        ADDA.W  -$17(A4,A2.W),A2                ; $105A30
        ASL.L  #7,D5                            ; $105A34
        DIVS    -(A4),D0                        ; $105A36
        MOVE.L  (A1),$0F(A1,A5.L)               ; $105A38
        MOVE.L  $66FF(A2),D5                    ; $105A3C
        MOVE.L  D0,-(A0)                        ; $105A40
        MOVE.L  (A3)+,D4                        ; $105A42
        BCLR    D5,$5C(PC,D0.L)                 ; $105A44
        OR.W   (A0)+,D0                         ; $105A48
        MOVE.B  #$1CE0,D2                       ; $105A4A
        MOVE.W  (A6),D4                         ; $105A4E
        BCC.S  loc_105A08                       ; $105A50
        BLE.S  loc_1059FC                       ; $105A52
        DC.W    $C3BF               ; $105A54 AND.L  D1,<EA:3F>
        BRA.S  loc_105AB0                       ; $105A56
        DC.W    $0D89               ; $105A58 BCLR    D6,A1
        BCC.S  loc_105AAD                       ; $105A5A
        BRA.S  loc_105AB7                       ; $105A5C
        LEA     D0,A3                           ; $105A5E
        CMPA.W  A4,A6                           ; $105A60
        AND.L  $E114B215,D0                     ; $105A62
        DC.W    $00C0               ; $105A68 DC.W    $00C0
        CMP.L  D0,D7                            ; $105A6A
        AND.B  D2,D0                            ; $105A6C
        MOVE.W  D0,D0                           ; $105A6E
        DC.W    $0000,$0000         ; $105A70 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $105A74 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $105A78 ORI.B  #$0000,D0
        DC.W    $0000,$DDA8         ; $105A7C ORI.B  #$DDA8,D0
        DC.W    $DDFF               ; $105A80 ADDA.L  <EA:3F>,A6
        MOVE.W  #$1D1D,D4                       ; $105A82
        LSR.W  $1BD1.W                          ; $105A86
        MOVE.W  $7F(A5,A7.L),(A7)+              ; $105A8A
        DC.W    $50BD               ; $105A8E ADDQ.L  #8,<EA:3D>
        MOVE.W  (A1)+,D4                        ; $105A90
        DC.W    $1DD1               ; $105A92 MOVE.B  (A1),<EA:3E>
        ADD.B  D0,(A1)                          ; $105A94
        MOVE.B  (A5)+,-(A0)                     ; $105A96
        MOVE.B  -$03(PC,A3.W),$D4FD.W           ; $105A98
        NEGX.L D0                               ; $105A9E
        LSR.W  -$18(A0,A6.W)                    ; $105AA0
        BCLR    #27,D7                          ; $105AA4
        MOVE.W  $33(A1,D3.W),-(A7)              ; $105AA8
loc_105AAC:
        DC.W    $FBF1,$9413         ; $105AAC MOVE.W  $13(A1,A1.W),<EA:3D>
loc_105AB0:
        MOVE.W  (A5),$131D.W                    ; $105AB0
        DC.W    $13F8,$3101,$18E9,$CEC9; $105AB4 MOVE.B  $3101.W,$18E9CEC9
        ROXL.B  #8,D2                           ; $105ABC
        BRA.S  loc_105AAC                       ; $105ABE
        DC.W    $33FF,$FAD7,$1346   ; $105AC0 MOVE.W  <EA:3F>,$FAD71346
        CLR    -(A5)                            ; $105AC6
        DC.W    $C5FF               ; $105AC8 MULS    <EA:3F>,D2
        MOVE.L  D4,-$0F1F(PC)                   ; $105ACA
        ROXL.W  D2,D7                           ; $105ACE
        DC.W    $FE77,$8737         ; $105AD0 MOVEA.W $37(A7,A0.W),A7
        AND.B  D1,D0                            ; $105AD4
        MOVE.W  A0,-$24(A3,A6.L)                ; $105AD6
        MOVE.W  A6,$00(A3,A6.L)                 ; $105ADA
        MOVEM.L $01(A6,A2.W),D1/D2/D4/D5/D6/D7/A2/A6/A7; $105ADE
        MOVE.W  D0,(A0)+                        ; $105AE4
        DC.W    $1DE1               ; $105AE6 MOVE.B  -(A1),<EA:3E>
        CMPA.W  -(A1),A0                        ; $105AE8
        OR.W   D3,$4780.W                       ; $105AEA
        MOVEQ   #-$18,D4                        ; $105AEE
        LSR.L  #4,D6                            ; $105AF0
        DC.W    $FFF6,$FF28         ; $105AF2 MOVE.W  $28(A6,A7.L),<EA:3F>
        MOVE.B  $76(A3,A7.L),-$03A2(A4)         ; $105AF6
        ADDA.W  #$7886,A6                       ; $105AFC
        BCLR    D1,$3188(PC)                    ; $105B00
        ROXL.B  D2,D1                           ; $105B04
        MOVE.W  $20(A7,D7.L),-(A1)              ; $105B06
        NOT    -$40(A6,D5.W)                    ; $105B0A
        ADD.W  D0,A1                            ; $105B0E
        CLR.L  (A0)                             ; $105B10
        CMP.B  -$16(A5,A7.L),D4                 ; $105B12
        MOVE.W  (A4),D0                         ; $105B16
        SUBI.W  #$E201,D4                       ; $105B18
        MOVE.W  (A7),D4                         ; $105B1C
        AND.B  D6,D7                            ; $105B1E
        MOVE.W  -(A0),-(A4)                     ; $105B20
        DC.W    $19FF,$97BB         ; $105B22 MOVE.B  <EA:3F>,#$97BB
        MOVE.W  (A1),D0                         ; $105B26
        OR.B   (A1),D2                          ; $105B28
        DC.W    $4920               ; $105B2A DC.W    $4920
        DIVS    $F29EF80D,D1                    ; $105B2C
        MOVE.B  D3,-$0F(A0,A6.W)                ; $105B32
        AND.B  A5,D5                            ; $105B36
        ADDA.L  (A4)+,A0                        ; $105B38
        SVC     (A6)                            ; $105B3A
        BSET    D4,#$2813                       ; $105B3C
        ADDA.W  #$717D,A4                       ; $105B40
        DC.W    $FDB9,$F6C1,$433D,$11E2; $105B44 MOVE.W  $F6C1433D,-$1E(A6,D1.W)
        ADDA.W  $37(A2,D3.W),A2                 ; $105B4C
        MOVE.B  #$7702,$9683.W                  ; $105B50
        EOR.B  D0,-(A1)                         ; $105B56
        DC.W    $D9FD               ; $105B58 ADDA.L  <EA:3D>,A4
        AND.W  D0,(A7)                          ; $105B5A
        CMPA.W  -(A5),A2                        ; $105B5C
        ADDA.W  $7E(A1,A0.W),A0                 ; $105B5E
        MOVEQ   #-$78,D4                        ; $105B62
        SEQ     $09FB.W                         ; $105B64
        MOVE.W  A6,-$24(A7,D2.L)                ; $105B68
        MOVE.W  -(A1),-$78(A3,A0.L)             ; $105B6C
        OR.B   D0,-$08(A1,D5.W)                 ; $105B70
        MOVE.B  (A0),-$24(A0,A0.L)              ; $105B74
        EOR.B  D0,-$0D5E(A5)                    ; $105B78
        MOVE.W  D0,$00(A0,A7.L)                 ; $105B7C
        MOVEM.L -$02B8(A5),D0/D1/D3/D4/D5/D6/D7/A2/A3/A5/A6/A7; $105B80
        MOVEA.L $12(PC,A0.L),A0                 ; $105B86
        SUB.W  D6,-$0EB8(A2)                    ; $105B8A
        OR.L   D0,D2                            ; $105B8E
        LSL.W  $0A01(A0)                        ; $105B90
        MOVE.W  D7,-(A3)                        ; $105B94
        ORI.W  #$1377,-(A2)                     ; $105B96
        MOVE.W  -$01(PC,A2.W),-$7C(PC,D0.L)     ; $105B9A
        MOVE.L  $0F39.W,$FB13.W                 ; $105BA0
        MOVE.W  -(A2),(A2)+                     ; $105BA6
        SUB.W  D4,(A4)                          ; $105BA8
        OR.L   D3,D7                            ; $105BAA
        MOVE.L  A2,(A1)                         ; $105BAC
        MOVE.B  -$0F(A2,A5.L),$16F2.W           ; $105BAE
        DC.W    $4191               ; $105BB4 DC.W    $4191
        ASL.W  -$5C2E(A1)                       ; $105BB6
        MOVE.W  (A0),-$0D78(A0)                 ; $105BBA
        OR.B   (A0),D0                          ; $105BBE
        DC.W    $0ACE               ; $105BC0 DC.W    $0ACE
        ASL.B  D4,D7                            ; $105BC2
        DC.W    $4149               ; $105BC4 DC.W    $4149
        ROR.W  -$7116(A7)                       ; $105BC6
        DIVS    $48(A4,D0.W),D6                 ; $105BCA
        MOVE.W  D4,D2                           ; $105BCE
        SUB.L  D0,D4                            ; $105BD0
        ASL.W  -$030B(A4)                       ; $105BD2
        SUBQ.B  #2,-(A5)                        ; $105BD6
        MOVE.B  D0,-$1690(A3)                   ; $105BD8
        MOVE.W  A4,D0                           ; $105BDC
        DC.W    $FDF0,$0AF8         ; $105BDE MOVE.W  -$08(A0,D0.L),<EA:3E>
        MOVE.W  D1,D2                           ; $105BE2
        ROXR.B  #4,D4                           ; $105BE4
        MOVEA.B (A0),A5                         ; $105BE6
        CLR.L  (A7)+                            ; $105BE8
        LEA     $15F0(A2),A2                    ; $105BEA
        BCHG    D7,D1                           ; $105BEE
loc_105BF0:
        LSL.B  D4,D3                            ; $105BF0
        DC.W    $0A38,$EA33,$DCF3   ; $105BF2 EORI.B  #$EA33,$DCF3.W
        BRA.S  loc_105BF0                       ; $105BF8
        ADD.B  (A3)+,D1                         ; $105BFA
        DC.W    $F33F               ; $105BFC MOVE.W  <EA:3F>,-(A1)
        MOVEA.W (A4)+,A2                        ; $105BFE
        MOVE.W  $78(A3,D7.W),D4                 ; $105C00
        OR.B   -$72(A7,D2.W),D4                 ; $105C04
        BCS.S  loc_105BFB                       ; $105C08
        OR.L   D3,A2                            ; $105C0A
        MOVE.L  -$0D(A0,A6.W),(A0)+             ; $105C0C
        BRA.S  loc_105BDB                       ; $105C10
        LEA     $20(A1,D3.L),A7                 ; $105C12
        ROXL.W  D4,D7                           ; $105C16
        MOVE.W  -$111C(A6),-$20(PC,A7.L)        ; $105C18
        DC.W    $13FA,$0478,$8777,$737C; $105C1E MOVE.B  $0478(PC),$8777737C
        DC.W    $4580               ; $105C26 DC.W    $4580
        DC.W    $4C73               ; $105C28 DC.W    $4C73
        MOVE.B  -$2490(A6),(A0)+                ; $105C2A
        BSET    D0,-$22CF(A0)                   ; $105C2E
        OR.W   D3,-$16(A3,D1.W)                 ; $105C32
        BCHG    D1,D0                           ; $105C36
        BSET    D0,-$6A78(A4)                   ; $105C38
        MOVE.W  -(A1),(A7)                      ; $105C3C
        MOVE.W  A0,(A6)                         ; $105C3E
        PEA     -(A6)                           ; $105C40
        DC.W    $A9FA,$B4EB,$41A4,$1492; $105C42 MOVE.L  -$4B15(PC),#$41A41492
        MOVE.W  -$0C4F(A7),-$01(A7,D3.W)        ; $105C4A
        ADDQ.L  #5,(A1)                         ; $105C50
        MULU    -(A5),D2                        ; $105C52
        NOT    $53F4(A5)                        ; $105C54
        DC.W    $137F,$E9C1         ; $105C58 MOVE.B  <EA:3F>,-$163F(A1)
        MOVE.W  $5554(A7),$07(A0,D4.L)          ; $105C5C
        MOVE.W  -$40(A0,A7.W),-(A7)             ; $105C62
loc_105C66:
        MOVE.W  -(A7),D3                        ; $105C66
        BLE.S  loc_105C4D                       ; $105C68
        LSR.W  $22(A0,D1.W)                     ; $105C6A
        SUBQ.L  #8,(A4)                         ; $105C6E
        ROL.B  D1,D2                            ; $105C70
        LSR.L  D1,D7                            ; $105C72
        ROL.W  (A0)+                            ; $105C74
        BCHG    D4,(A5)                         ; $105C76
        DC.W    $4175               ; $105C78 DC.W    $4175
        MOVE.W  -(A5),(A1)                      ; $105C7A
        MOVE.W  A2,D0                           ; $105C7C
        DC.W    $FFE0               ; $105C7E MOVE.W  -(A0),<EA:3F>
        BTST    D7,(A4)+                        ; $105C80
        DC.W    $E6FF               ; $105C82 ROR.W  <EA:3F>
        MOVE.W  (A7),D4                         ; $105C84
        DC.W    $B67D               ; $105C86 CMP.W  <EA:3D>,D3
        ADD.B  (A4)+,D4                         ; $105C88
        SUBQ.L  #2,(A5)                         ; $105C8A
        BLT.S  loc_105C66                       ; $105C8C
        MOVE.B  $28(A5,A6.L),-$0D6B(A0)         ; $105C8E
        ASL.W  D5                               ; $105C94
        ASL.W  #6,D1                            ; $105C96
        ASL.W  #$F451                           ; $105C98
        SUBQ.B  #8,(A0)+                        ; $105C9C
        DC.W    $FFFC,$F2B3         ; $105C9E MOVE.W  #$F2B3,<EA:3F>
        DC.W    $DBFF               ; $105CA2 ADDA.L  <EA:3F>,A5
        ROL.W  -$0A(A1,D5.W)                    ; $105CA4
        MOVE.B  -$07B8(A1),-$0C1F(PC)           ; $105CA8
        ASR.W  $0C78.W                          ; $105CAE
        DC.W    $88FD               ; $105CB2 DIVU    <EA:3D>,D4
        MOVE.L  A6,$4D(A0,A6.L)                 ; $105CB4
        MOVE.W  A6,$77(A0,D7.W)                 ; $105CB8
        MOVE.W  A0,-$01(A3,D3.W)                ; $105CBC
        MOVEQ   #-$16,D4                        ; $105CC0
        MOVE.W  -$7D0E(A5),(A0)+                ; $105CC2
        SUBA.W  (A1)+,A2                        ; $105CC6
        SUB.L  D3,(A7)                          ; $105CC8
        MOVEA.W $79EE031E,A4                    ; $105CCA
        DIVU    -$1702(A6),D4                   ; $105CD0
        ADDA.L  -$7878(A6),A5                   ; $105CD4
        DC.W    $408A               ; $105CD8 NEGX.L A2
        ADDA.L  $28EA(A0),A4                    ; $105CDA
        MOVE.W  $43(A3,A7.L),-$25AF(A7)         ; $105CDE
        MOVE.W  #$EA77,-(A0)                    ; $105CE4
        LSR.L  #4,D6                            ; $105CE8
        ROR.W  D4,D0                            ; $105CEA
        DIVU    -(A4),D7                        ; $105CEC
        MOVE.W  D0,$25E4(A3)                    ; $105CEE
        ASL.W  D5,D4                            ; $105CF2
        MOVE.W  -(A4),-$01(A0,A7.L)             ; $105CF4
        MOVEA.L A2,A6                           ; $105CF8
        ROL.W  D5,D0                            ; $105CFA
        MULU    #$FC41,D5                       ; $105CFC
        MOVE.W  -(A4),-(A0)                     ; $105D00
        CMPI.L  #$7CE0FEA7,D5                   ; $105D02
        ROXR.W  -(A4)                           ; $105D08
        DC.W    $0020,$C3A2         ; $105D0A ORI.B  #$C3A2,-(A0)
        OR.L   (A4)+,D1                         ; $105D0E
        ROXL.W  $160E(A2)                       ; $105D10
        EOR.B  D6,-$08(A7,A4.W)                 ; $105D14
        BSET    D5,-(A2)                        ; $105D18
        ROXR.W  $4E11(A6)                       ; $105D1A
        DC.W    $00FF               ; $105D1E DC.W    $00FF
        NEG    (A5)+                            ; $105D20
        MOVE.W  $0100.W,$7EDB(A2)               ; $105D22
        SUBQ.L  #4,$2901(A4)                    ; $105D28
        MOVE.W  -$12(A6,D7.W),-$2200(A7)        ; $105D2C
        SUBI.W  #$DD5F,-(A5)                    ; $105D32
        ASR.W  -(A0)                            ; $105D36
        MOVEA.B D1,A2                           ; $105D38
        LSR.B  #1,D3                            ; $105D3A
        ADDA.L  -(A6),A4                        ; $105D3C
        BPL.S  loc_105D31                       ; $105D3E
        ROR.W  #5,D2                            ; $105D40
        OR.W   (A2)+,D4                         ; $105D42
        MOVE.W  (A1),-(A0)                      ; $105D44
        MOVE.W  (A2),(A4)+                      ; $105D46
        MOVE.L  $2300.W,-$0289(A3)              ; $105D48
        OR.W   $E6BF1306,D7                     ; $105D4E
        SEQ     -(A2)                           ; $105D54
        MOVEA.W $00(A1,A5.W),A5                 ; $105D56
        MOVE.B  A2,(A2)+                        ; $105D5A
        ROR.B  #3,D3                            ; $105D5C
        MULU    (A1),D6                         ; $105D5E
        SUBQ.B  #4,-$36(A1,D3.L)                ; $105D60
        DC.W    $FFFE               ; $105D64 MOVE.W  <EA:3E>,<EA:3F>
        CMPA.W  (A2)+,A2                        ; $105D66
        CMP.B  (A1),D0                          ; $105D68
        DC.W    $0000,$9EEB         ; $105D6A ORI.B  #$9EEB,D0
        OR.W   D3,D3                            ; $105D6E
        MOVE.L  -$05BC(A2),(A0)                 ; $105D70
        MULU    $5E(A0,D0.L),D0                 ; $105D74
        ADDA.W  -$1676(A0),A2                   ; $105D78
        LSR.L  D6,D2                            ; $105D7C
        MOVE.L  D0,(A5)                         ; $105D7E
        MOVE.W  (A0),D0                         ; $105D80
        ROXR.W  A4                              ; $105D82
        DC.W    $FFF8,$09E0         ; $105D84 MOVE.W  $09E0.W,<EA:3F>
        MOVE.W  A7,D4                           ; $105D88
        MOVE.W  -$08(A2,A6.W),$40(PC,D0.L)      ; $105D8A
        MOVE.W  (A1),D0                         ; $105D90
        MOVE.W  A5,(A3)+                        ; $105D92
        DC.W    $0209,$E0F8         ; $105D94 ANDI.B  #$E0F8,A1
        MOVE.B  A4,-$0ECD(A3)                   ; $105D98
        DC.W    $0DFF               ; $105D9C BSET    D6,<EA:3F>
        MOVE.W  -(A0),$1A(A6,A2.W)              ; $105D9E
        MOVE.W  D4,-(A7)                        ; $105DA2
        ADD.L  D4,D1                            ; $105DA4
        DC.W    $DAFF               ; $105DA6 ADDA.W  <EA:3F>,A5
        ASR.W  $16E5.W                          ; $105DA8
        MOVE.W  -(A1),(A0)+                     ; $105DAC
        MOVE.W  -$1F08(A2),(A7)                 ; $105DAE
        MOVE.B  -(A7),$A9FCA44A                 ; $105DB2
        SUB.L  D6,D4                            ; $105DB8
        DC.W    $0F8A               ; $105DBA BCLR    D7,A2
        ASR.W  $15AA.W                          ; $105DBC
        MOVE.W  -$5B58(A1),-$5C(A6,A2.L)        ; $105DC0
        MOVE.L  -$80(A1,A5.L),(A1)              ; $105DC6
        MOVE.W  (A3)+,D4                        ; $105DCA
        ADD.L  D0,D5                            ; $105DCC
        MOVE.W  (A3)+,D4                        ; $105DCE
        DC.W    $8FFD               ; $105DD0 DIVS    <EA:3D>,D7
        MOVE.W  A4,D2                           ; $105DD2
        ASL.W  -(A0)                            ; $105DD4
        MOVE.W  (A2),D4                         ; $105DD6
        DC.W    $E4FF               ; $105DD8 ROXR.W  <EA:3F>
        DC.W    $FFFF               ; $105DDA MOVE.W  <EA:3F>,<EA:3F>
        NEG.W  D4                               ; $105DDC
        MOVE.L  D4,D3                           ; $105DDE
        LEA     -(A0),A7                        ; $105DE0
        MOVE.W  A7,D4                           ; $105DE2
        DIVU    (A7)+,D4                        ; $105DE4
        CMPA.L  -(A3),A7                        ; $105DE6
        AND.B  -(A2),D0                         ; $105DE8
        MULS    (A6)+,D0                        ; $105DEA
        DC.W    $FFE0               ; $105DEC MOVE.W  -(A0),<EA:3F>
        MOVE.W  A6,D4                           ; $105DEE
        ASL.W  D0                               ; $105DF0
        ST      -$5D01(A1)                      ; $105DF2
        DC.W    $F8FD               ; $105DF6 MOVE.W  <EA:3D>,(A4)+
        NEG    D0                               ; $105DF8
        MOVE.W  (A0),D4                         ; $105DFA
        SUB.W  D3,D0                            ; $105DFC
        SCS     $77F8(A1)                       ; $105DFE
        DC.W    $C0FD               ; $105E02 MULU    <EA:3D>,D0
        SUBA.L  (A3)+,A5                        ; $105E04
        BRA.L  $551A0006                        ; $105E06
        ASR.W  $2A(A0,D0.L)                     ; $105E0C
        ROXL.L  #4,D2                           ; $105E10
        ASL.L  D4,D5                            ; $105E12
        MOVEA.W $0608(A1),A6                    ; $105E14
        DC.W    $A7FF,$F4A7         ; $105E18 MOVE.L  <EA:3F>,-$59(PC,A7.W)
        MOVEA.L D4,A4                           ; $105E1C
        OR.B   $46F9(A4),D0                     ; $105E1E
        MOVE.W  D0,$CCEA.W                      ; $105E22
        BCLR    D0,D4                           ; $105E26
        MOVE.L  $4F(A2,A7.L),(A2)+              ; $105E28
        MOVE.L  A0,-(A5)                        ; $105E2C
        BSR.S  loc_105EA8                       ; $105E2E
        ASR.W  D3,D0                            ; $105E30
        LEA     -$0C(PC,A0.L),A7                ; $105E32
        ADDQ.B  #8,(A4)+                        ; $105E36
        ADD.W  D0,-(A0)                         ; $105E38
        MOVE.W  (A6)+,D0                        ; $105E3A
        ASR.W  $1C1D.W                          ; $105E3C
        OR.L   A1,D4                            ; $105E40
        BLS.S  loc_105EA7                       ; $105E42
        MOVE.W  (A0)+,-$67(A7,A7.L)             ; $105E44
        DC.W    $FFFD               ; $105E48 MOVE.W  <EA:3D>,<EA:3F>
        DC.W    $9FFF               ; $105E4A SUBA.L  <EA:3F>,A7
        MOVE.W  -(A4),-(A4)                     ; $105E4C
        DC.W    $C2FF               ; $105E4E MULU    <EA:3F>,D1
        DC.W    $04FF               ; $105E50 DC.W    $04FF
        ASL.W  $5FA4.W                          ; $105E52
        LSL.W  #1,D1                            ; $105E56
        SUB.L  D4,-(A4)                         ; $105E58
        SUB.L  (A4),D2                          ; $105E5A
        SUB.W  A1,D5                            ; $105E5C
        DC.W    $494A               ; $105E5E DC.W    $494A
        ASR.W  $0F78.W                          ; $105E60
        OR.W   (A6),D4                          ; $105E64
        MOVE.L  (A0)+,(A4)                      ; $105E66
        TST.L  -$2457(A2)                       ; $105E68
        BCHG    D6,D3                           ; $105E6C
        MULU    $C0F812A4,D2                    ; $105E6E
        AND.W  D4,D6                            ; $105E74
        MOVE.L  -$657D(A1),(A5)+                ; $105E76
        OR.L   -(A0),D3                         ; $105E7A
        MOVE.W  (A2)+,D4                        ; $105E7C
        DC.W    $89BE               ; $105E7E OR.L   D4,<EA:3E>
        DIVU    $1C60.W,D0                      ; $105E80
        MOVE.W  A5,D4                           ; $105E84
        DC.W    $AFFF               ; $105E86 MOVE.L  <EA:3F>,<EA:3F>
        MOVE.B  (A2)+,-(A3)                     ; $105E88
        MOVE.W  -$06(A4,D4.L),(A5)+             ; $105E8A
        DIVS    $4F(A2,D0.W),D0                 ; $105E8E
        ASR.W  $09AA.W                          ; $105E92
        AND.B  D7,D3                            ; $105E96
        MOVEQ   #-$66,D7                        ; $105E98
        NEG.W  (A1)+                            ; $105E9A
        DC.W    $4FAF               ; $105E9C DC.W    $4FAF
        SUBA.L  -$00F3(PC),A7                   ; $105E9E
        BSET    D1,D0                           ; $105EA2
        MOVE.W  (A1)+,D4                        ; $105EA4
        MOVE.L  $0BF4.W,(A0)+                   ; $105EA6
        CMP.L  A1,D7                            ; $105EAA
        OR.L   D7,-$50(PC,A2.L)                 ; $105EAC
        ROR.L  #1,D7                            ; $105EB0
        MOVE.W  D0,$17(A7,A7.L)                 ; $105EB2
        MOVE.W  $4F(A1,A7.L),$4F02(PC)          ; $105EB6
        LEA     -(A1),A3                        ; $105EBC
        MOVE.W  -(A0),(A7)+                     ; $105EBE
        MOVE.W  (A0),D4                         ; $105EC0
        MULU    #$9FE5,D3                       ; $105EC2
        MOVEA.B (A1)+,A3                        ; $105EC6
        CMPA.W  -(A0),A6                        ; $105EC8
        MOVE.W  A7,D4                           ; $105ECA
        MULS    $20F8(PC),D1                    ; $105ECC
        MOVE.B  (A4),D4                         ; $105ED0
        SUBA.W  -$7F10(A4),A0                   ; $105ED2
        MOVE.B  (A7)+,-$1E84(A6)                ; $105ED6
        SUBI.L  #$E0F8145F,-(A0)                ; $105EDA
        SLE     $89F9C050                       ; $105EE0
        MOVE.L  (A6)+,(A0)+                     ; $105EE6
        DIVS    -$08(A2,A6.W),D0                ; $105EE8
        BTST    D4,-(A5)                        ; $105EEC
        MOVEM.L (A5),A1/A2/A4/A6                ; $105EEE
        MOVE.W  (A7)+,(A6)                      ; $105EF2
        MOVE.W  -(A0),-$0FE9(A0)                ; $105EF4
        DIVU    $4F(A0,D1.L),D0                 ; $105EF8
        MULU    -$0C(A0,D1.L),D0                ; $105EFC
        ASR.W  $1BA1.W                          ; $105F00
        MOVE.W  (A5),$FE80.W                    ; $105F04
        MOVE.W  (A7),D0                         ; $105F08
        LSR.W  -$30(A7,D7.W)                    ; $105F0A
        DC.W    $0BFF               ; $105F0E BSET    D5,<EA:3F>
        MOVE.W  (A6)+,D4                        ; $105F10
        MOVE.W  -$07EC(A3),$4343(PC)            ; $105F12
        SUBQ.W  #1,(A3)                         ; $105F18
        ADDQ.W  #2,D6                           ; $105F1A
        MOVEA.B (A3),A1                         ; $105F1C
        MULS    $1855.W,D5                      ; $105F1E
        DC.W    $FEFD               ; $105F22 MOVE.W  <EA:3D>,(A7)+
        DC.W    $A9F8,$1A41,$54A8,$BDA0; $105F24 MOVE.L  $1A41.W,#$54A8BDA0
        MOVE.W  (A0)+,D4                        ; $105F2C
        MOVE.W  -(A2),(A6)+                     ; $105F2E
        MOVE.W  A2,D4                           ; $105F30
        ADDA.W  $14C3.W,A6                      ; $105F32
        MOVE.L  $FE35.W,(A6)                    ; $105F36
        ADD.W  D3,(A3)                          ; $105F3A
        SUBQ.L  #2,-$08(A1,D7.L)                ; $105F3C
        CMPI.L  #$ECF14445,A4                   ; $105F40
        ADDQ.L  #4,-$1A08(PC)                   ; $105F46
        DC.W    $0AAA,$6F04,$1AAA,$A1A1; $105F4A EORI.L  #$6F041AAA,-$5E5F(A2)
        MOVE.L  $12(A7,A7.L),(A5)               ; $105F52
        MOVE.W  -(A4),(A5)+                     ; $105F56
        MOVE.W  A0,-(A7)                        ; $105F58
        BSET    D5,-(A5)                        ; $105F5A
        DC.W    $ADFB,$1ADD         ; $105F5C MOVE.L  -$23(PC,D1.L),<EA:3E>
        LSL.W  $0F07.W                          ; $105F60
        MOVEM.L D0/D1/D4/D5/A0/A1/A4,-$2538(A5) ; $105F64
        ADD.B  (A2)+,D7                         ; $105F6A
        MOVE.L  D1,D0                           ; $105F6C
        MULU    -$10(A7,A6.W),D0                ; $105F6E
        MOVEA.B A3,A5                           ; $105F72
        EOR.B  D5,-$7B(A5,D6.L)                 ; $105F74
        SUBQ.W  #8,$47F8(A1)                    ; $105F78
        MOVEA.B A7,A4                           ; $105F7C
        SUBQ.W  #2,(A3)                         ; $105F7E
        NOT.W  A3                               ; $105F80
        MOVE.W  A6,D4                           ; $105F82
        DC.W    $06A8,$9777,$9FA3,$A6F0; $105F84 ADDI.L  #$97779FA3,-$5910(A0)
        MOVE.B  D0,-$01(A4,D2.W)                ; $105F8C
        MOVE.W  (A7)+,D4                        ; $105F90
        DC.W    $C2FD               ; $105F92 MULU    <EA:3D>,D1
        DC.W    $BBFF               ; $105F94 CMPA.L  <EA:3F>,A5
        MOVE.W  (A6),D4                         ; $105F96
        DC.W    $0148               ; $105F98 BCHG    D0,A0
        BCS.S  loc_105FB9                       ; $105F9A
        DC.W    $FFE1               ; $105F9C MOVE.W  -(A1),<EA:3F>
        MOVE.W  (A6),D4                         ; $105F9E
        MOVE.L  -(A4),-$26(A0,A4.W)             ; $105FA0
        LSR.L  D1,D5                            ; $105FA4
        ASR.W  $140B.W                          ; $105FA6
        MOVE.W  -$76(A2,D4.W),(A4)+             ; $105FAA
        DC.W    $00F9               ; $105FAE DC.W    $00F9
        MOVE.L  D1,$18(A1,A7.L)                 ; $105FB0
        ASL.L  #2,D1                            ; $105FB4
        AND.L  A5,D3                            ; $105FB6
        DC.W    $F1FF,$CCFF         ; $105FB8 MOVE.W  <EA:3F>,$CCFF.W
        MOVE.W  -$009A(A4),-$00BA(A6)           ; $105FBC
        DC.W    $463F               ; $105FC2 NOT.B  <EA:3F>
        DC.W    $0A36,$4643,$3444   ; $105FC4 EORI.B  #$4643,$44(A6,D3.W)
        NOT.B  -$20(A4,A7.L)                    ; $105FCA
        MOVE.W  (A5),D4                         ; $105FCE
        DC.W    $2F7C,$FF64,$4443,$63E0; $105FD0 MOVE.L  #$FF644443,$63E0(A7)
        MOVE.W  (A0)+,D4                        ; $105FD8
        AND.W  D0,D6                            ; $105FDA
        BNE.S  loc_106022                       ; $105FDC
        NEG.W  -(A4)                            ; $105FDE
        BTST    D0,D4                           ; $105FE0
        MULU    $1BC1.W,D0                      ; $105FE2
        ADDA.L  -(A0),A7                        ; $105FE6
        MOVE.W  (A3)+,D4                        ; $105FE8
        SUB.W  D7,(A0)                          ; $105FEA
        MOVEQ   #-$23,D0                        ; $105FEC
        MOVE.L  $1B88.W,(A0)+                   ; $105FEE
        ADD.W  D4,(A5)+                         ; $105FF2
        MULU    $1936.W,D0                      ; $105FF4
        MOVE.W  (A4),$7FDFA0F8                  ; $105FF8
        DC.W    $1DE0               ; $105FFE MOVE.B  -(A0),<EA:3E>
        MOVE.W  D3,(A6)                         ; $106000
        MOVE.W  -$7D(A4,D3.W),-(A1)             ; $106002
        NEG.B  $20(A3,D3.L)                     ; $106006
        MULS    $AEE8.W,D1                      ; $10600A
        MOVE.W  $34(A4,A6.W),-(A0)              ; $10600E
        MOVE.B  -(A0),$4993(A7)                 ; $106012
        NOT.B  -$67(A3,A1.W)                    ; $106016
        ROR.W  $34(A0,A1.W)                     ; $10601A
        MOVE.W  D0,D4                           ; $10601E
        MOVEA.W D4,A6                           ; $106020
loc_106022:
        MOVE.W  -$22(A4,A5.L),-(A4)             ; $106022
        MOVE.L  (A1),D1                         ; $106026
        JMP     -(A2)                           ; $106028
        ADD.W  D5,D2                            ; $10602A
        MULU    D3,D0                           ; $10602C
        MOVE.W  $34(A6,A1.L),-$666C(PC)         ; $10602E
        MOVE.W  D6,$0031(A5)                    ; $106034
        LEA     $39(PC,A5.L),A1                 ; $106038
        AND.W  D2,D3                            ; $10603C
        ORI.W  #$F1AC,A6                        ; $10603E
        CMP.B  $998004D0,D2                     ; $106042
        DC.W    $FBFA,$CE00         ; $106048 MOVE.W  -$3200(PC),<EA:3D>
        DIVU    A0,D0                           ; $10604C
        ADD.L  (A3)+,D1                         ; $10604E
        MOVE.W  D0,(A4)                         ; $106050
        DC.W    $00BE,$EBDD,$E928   ; $106052 ORI.L  #$EBDDE928,<EA:3E>
        MULU    -$1586(PC),D0                   ; $106058
        DC.W    $F3FA,$D234,$8800,$6498; $10605C MOVE.W  -$2DCC(PC),$88006498
loc_106064:
        ROR.W  (A7)+                            ; $106064
        MOVE.L  (A2),(A4)+                      ; $106066
        ASR.W  $78FD(A5)                        ; $106068
        BSR.S  loc_106064                       ; $10606C
        BNE.S  loc_106071                       ; $10606E
        BCHG    D0,D4                           ; $106070
        DC.W    $93FF               ; $106072 SUBA.L  <EA:3F>,A1
        DC.W    $F3FD,$9920,$FECF   ; $106074 MOVE.W  <EA:3D>,$9920FECF
        ADDA.L  $22(A5,D4.L),A7                 ; $10607A
        MOVEQ   #-$49,D1                        ; $10607E
        SUBA.W  A1,A6                           ; $106080
        CMP.B  $44(A3,D4.W),D6                  ; $106082
        CMPA.W  (A1),A6                         ; $106086
        CMPA.L  $00(A3,D2.W),A3                 ; $106088
        CMPA.L  (A0)+,A2                        ; $10608C
        SPL     #$9C10                          ; $10608E
loc_106092:
        MOVE.L  D4,$3877(A7)                    ; $106092
        ASL.B  #8,D0                            ; $106096
        MOVE.B  -(A1),-$487B(A0)                ; $106098
        MOVE.W  D1,D5                           ; $10609C
        MOVEA.W -$0C(A4,D4.L),A7                ; $10609E
        SUB.W  D1,-(A4)                         ; $1060A2
        BCC.S  loc_1060EA                       ; $1060A4
        MOVE.W  -(A1),D3                        ; $1060A6
        MOVE.B  (A2)+,$0BEC.W                   ; $1060A8
        AND.B  -$7D(A1,D1.W),D2                 ; $1060AC
        DC.W    $06C7               ; $1060B0 DC.W    $06C7
        BLT.W  loc_1061A7                       ; $1060B2
        BCS.S  loc_106092                       ; $1060B6
        ASR.B  D1,D0                            ; $1060B8
        DC.W    $13F9,$C060,$76D0,$0196,$7C99; $1060BA MOVE.B  $C06076D0,$01967C99
        MOVE.B  (A1)+,-(A0)                     ; $1060C4
        CMP.L  A5,D6                            ; $1060C6
        DC.W    $08CF,$F6F1         ; $1060C8 BSET    #17,A7
        SUB.L  -(A7),D2                         ; $1060CC
        MOVEA.L A0,A0                           ; $1060CE
        MOVEM.L -(A3),D0/D1/D2/D3/D5/D7/A0/A2/A3/A5/A7; $1060D0
        AND.L  A3,D7                            ; $1060D4
        ORI.W  #$6664,(A1)+                     ; $1060D6
        MOVEQ   #-$04,D2                        ; $1060DA
        ADD.L  -(A5),D2                         ; $1060DC
        AND.W  D3,(A4)                          ; $1060DE
        ADD.W  D3,D6                            ; $1060E0
        SUB.B  D0,(A1)                          ; $1060E2
        MOVE.L  (A1),$43(A6,D7.L)               ; $1060E4
        DC.W    $00FC               ; $1060E8 DC.W    $00FC
loc_1060EA:
        BTST    D0,-(A3)                        ; $1060EA
        ASR.W  -$10(A1,A4.L)                    ; $1060EC
        NOT.W  $01(A0,D0.W)                     ; $1060F0
        EOR.W  D0,-(A6)                         ; $1060F4
        MOVE.W  (A6)+,-$4E(A4,A3.W)             ; $1060F6
        CLR.B  D0                               ; $1060FA
        MOVE.W  (A3),-$6F(A5,A5.W)              ; $1060FC
        MOVE.W  A2,(A4)                         ; $106100
        MOVE.L  -(A4),-(A2)                     ; $106102
        CMPA.L  -$0E(A3,D1.W),A5                ; $106104
        NEG    A1                               ; $106108
        CMP.B  -$50(A1,A2.L),D2                 ; $10610A
        MOVE.W  $3103(A2),(A1)+                 ; $10610E
        BCS.S  loc_106106                       ; $106112
        MULU    $22(A3,D3.W),D7                 ; $106114
        DC.W    $2DF1,$EF11         ; $106118 MOVE.L  $11(A1,A6.L),<EA:3E>
        DC.W    $143D               ; $10611C MOVE.B  <EA:3D>,D2
        SUB.B  D2,D6                            ; $10611E
        SUBA.L  (A6),A0                         ; $106120
        BEQ.S  loc_106168                       ; $106122
        MOVEA.B (A2)+,A0                        ; $106124
        NEGX.W $6E(A4,A7.W)                     ; $106126
        MOVE.W  D7,(A1)+                        ; $10612A
        MOVE.W  (A4),-(A1)                      ; $10612C
        MOVEQ   #-$0F,D2                        ; $10612E
        SUBA.L  $250C(A7),A6                    ; $106130
        MOVE.W  -$0C(A2,A3.W),(A4)+             ; $106134
        LSR.L  #4,D0                            ; $106138
        SUB.B  $029C(A4),D2                     ; $10613A
        ROXR.W  D0                              ; $10613E
        MOVE.W  $6000(A2),$6099(A0)             ; $106140
        SHI     -$4EE7(A4)                      ; $106146
        OR.B   D0,D6                            ; $10614A
        DC.W    $4D12               ; $10614C DC.W    $4D12
        OR.W   D1,$0A68(A3)                     ; $10614E
        BPL.S  loc_1060EA                       ; $106152
        MOVE.W  -(A7),$F2FF.W                   ; $106154
        ASR.W  -$6F(A3,A7.W)                    ; $106158
        OR.B   D1,D0                            ; $10615C
        DC.W    $D5FF               ; $10615E ADDA.L  <EA:3F>,A2
        MOVE.L  -(A1),D1                        ; $106160
        MOVE.L  D0,D7                           ; $106162
        DIVU    (A2)+,D1                        ; $106164
        ADDA.W  -(A4),A1                        ; $106166
loc_106168:
        SUB.B  D1,-(A4)                         ; $106168
        OR.B   D1,D3                            ; $10616A
        ADDA.W  -$0E(A1,D3.L),A5                ; $10616C
        SUBA.L  A2,A0                           ; $106170
        DC.W    $4311               ; $106172 DC.W    $4311
        ASL.B  D3,D0                            ; $106174
        MOVE.B  $66(A0,A6.L),$1813(A2)          ; $106176
        ADDA.W  $00(A1,D0.W),A5                 ; $10617C
        SUBA.W  -$2501(A7),A6                   ; $106180
        MOVE.L  (A4),-(A5)                      ; $106184
        ROXR.L  #8,D1                           ; $106186
        DC.W    $00F9               ; $106188 DC.W    $00F9
        MOVE.L  $44(A1,A3.L),(A4)+              ; $10618A
        CMPA.W  -$2EF9(A1),A2                   ; $10618E
        DC.W    $957E               ; $106192 SUB.W  D2,<EA:3E>
        MULS    $3922(A3),D7                    ; $106194
        MOVE.B  (A1),D1                         ; $106198
        SUB.B  D3,(A0)                          ; $10619A
        SUB.L  -$0F(A0,A7.L),D2                 ; $10619C
        CMPA.W  A5,A6                           ; $1061A0
        MOVE.W  D1,-$7D(A0,A6.L)                ; $1061A2
        BTST    #16,-(A1)                       ; $1061A6
        DIVU    $24(A3,D5.L),D0                 ; $1061AA
        MOVE.B  $4B44(A2),$EA30.W               ; $1061AE
        AND.L  -$5DA6(A0),D4                    ; $1061B4
        NOT    -$0E(A4,D1.W)                    ; $1061B8
        SGT     -$04(A3,A6.W)                   ; $1061BC
        MOVE.L  A0,-$34(A4,D3.W)                ; $1061C0
        MOVE.W  D1,$3C6E1136                    ; $1061C4
        MOVE.B  (A4),D2                         ; $1061CA
        ADD.L  D4,(A1)                          ; $1061CC
        ST      -$39(A1,D1.W)                   ; $1061CE
        MOVE.W  -(A0),-$3D(A0,A7.W)             ; $1061D2
        BSR.S  $106204                          ; $1061D6
        DC.W    $39FC,$9122,$24A2   ; $1061D8 MOVE.W  #$9122,#$24A2
        MOVE.B  -(A2),D1                        ; $1061DE
        ORI.W  #$38F7,(A2)                      ; $1061E0
        SUB.L  D4,-(A6)                         ; $1061E4
        MOVE.W  -(A0),-$0EF0(A0)                ; $1061E6
        DC.W    $02F7               ; $1061EA DC.W    $02F7
        MOVE.B  -$73E7(A2),$40(A7,A4.W)         ; $1061EC
        MOVE.B  A2,(A4)                         ; $1061F2
        ADD.B  D3,-(A1)                         ; $1061F4
        EOR.B  D5,-(A1)                         ; $1061F6
        MOVE.B  -$7F10(PC),#$2192               ; $1061F8
        MOVE.W  (A2),-(A0)                      ; $1061FE
