; Generated assembly for $100200-$102200
; Branch targets: 157
; Labels: 154
; Format: DC.W with decoded mnemonics as comments

        org     $100200

        MOVEA.L D2,A4                           ; $100200
        DIVS    D4,D0                           ; $100202
        ADDQ.W  #8,(A4)                         ; $100204
        NOT.L  (A3)                             ; $100206
        DC.W    $093E               ; $100208 BTST    D4,<EA:3E>
        DC.W    $F077,$5840         ; $10020A MOVEA.W $40(A7,D5.L),A0
        DC.W    $018C               ; $10020E BCLR    D0,A4
        EOR.L  D3,-$72CB(A7)                    ; $100210
        DC.W    $41B6               ; $100214 DC.W    $41B6
        ROR.B  D7,D4                            ; $100216
        DC.W    $4316               ; $100218 DC.W    $4316
        MOVE.W  D4,$31(A0,A3.W)                 ; $10021A
        MOVE.L  $20(A4,D4.L),(A2)               ; $10021E
        DC.W    $007C,$0671,$1E02   ; $100222 ORI.W  #$0671,#$1E02
        MOVE.W  D3,(A4)                         ; $100228
        DC.W    $001C,$C5E6         ; $10022A ORI.B  #$C5E6,(A4)+
        DC.W    $0E44               ; $10022E DC.W    $0E44
        ROXR.B  #2,D2                           ; $100230
        OR.B   D2,$21(A6,D0.W)                  ; $100232
        MOVE.W  D6,(A1)+                        ; $100236
        SF      -$29(A5,A0.W)                   ; $100238
        OR.W   D0,D2                            ; $10023C
        ADD.B  (A3),D2                          ; $10023E
        AND.W  -(A4),D6                         ; $100240
        DC.W    $FFC0               ; $100242 MOVE.W  D0,<EA:3F>
        ADDQ.W  #8,$03E7(A4)                    ; $100244
        ASL.W  #8,D2                            ; $100248
        DC.W    $06C1               ; $10024A DC.W    $06C1
        DC.W    $4314               ; $10024C DC.W    $4314
        NOT.W  (A2)+                            ; $10024E
        BCS.S  $1001E7                          ; $100250
        BLS.S  loc_1002C4                       ; $100252
        SUB.W  (A2)+,D2                         ; $100254
        MOVE.B  $3B(A1,A3.L),$5A(A5,A3.W)       ; $100256
        ADDQ.L  #8,(A1)                         ; $10025C
        CMPA.L  -(A0),A6                        ; $10025E
        MOVE.W  (A1),$03(PC,D0.W)               ; $100260
        AND.W  D1,$1749(A7)                     ; $100264
        MOVEQ   #$32,D2                         ; $100268
        ADDA.W  (A7)+,A0                        ; $10026A
        SUBA.L  (A0)+,A6                        ; $10026C
        LSR.B  #8,D6                            ; $10026E
        BSET    D4,-(A0)                        ; $100270
        ADD.B  (A4)+,D2                         ; $100272
        MOVE.L  -(A5),(A7)                      ; $100274
        ADD.B  $1E(A1,A4.W),D1                  ; $100276
        MOVE.W  -(A3),(A4)+                     ; $10027A
        MOVE.L  $07(A2,D5.W),D1                 ; $10027C
        MOVE.L  A0,-$6C(A1,A7.W)                ; $100280
        MOVE.B  -(A1),-(A2)                     ; $100284
        ROXR.W  D4                              ; $100286
        LEA     D7,A7                           ; $100288
        OR.W   D3,D4                            ; $10028A
        MOVEA.L D4,A5                           ; $10028C
        OR.B   (A5),D0                          ; $10028E
        ORI.W  #$0B10,D0                        ; $100290
        MOVE.L  D5,D0                           ; $100294
        OR.W   (A0),D4                          ; $100296
        DC.W    $02E0               ; $100298 DC.W    $02E0
        MOVEA.W -(A2),A7                        ; $10029A
        OR.W   (A6),D5                          ; $10029C
        MOVE.L  (A4),$5535(A2)                  ; $10029E
        BTST    D2,(A3)+                        ; $1002A2
        SUB.W  (A4)+,D4                         ; $1002A4
        EORI.W  #$5C0A,(A0)+                    ; $1002A6
        BNE.S  loc_10031E                       ; $1002AA
        MOVE.L  -(A0),-$4F(PC,D2.L)             ; $1002AC
        ANDI.W  #$B84F,$14(A6,A5.W)             ; $1002B0
        ASR.B  D5,D3                            ; $1002B6
        SUB.B  D5,#$2762                        ; $1002B8
        DIVU    $11CF(A5),D2                    ; $1002BC
        AND.W  $55C7(A2),D2                     ; $1002C0
loc_1002C4:
        DC.W    $4729               ; $1002C4 DC.W    $4729
        SHI     -$28(A0,D1.W)                   ; $1002C6
        BSR.S  loc_100306                       ; $1002CA
        SUBI.B  #$BF0A,(A0)                     ; $1002CC
        ORI.W  #$0504,-(A1)                     ; $1002D0
        MOVE.W  $061D(A1),(A0)                  ; $1002D4
        MOVE.W  D2,(A0)+                        ; $1002D8
        MOVE.L  (A0)+,D2                        ; $1002DA
        MOVEQ   #-$7D,D2                        ; $1002DC
        DC.W    $0E18               ; $1002DE DC.W    $0E18
        BSR.S  loc_100334                       ; $1002E0
        CMPI.B  #$6185,$0830(PC)                ; $1002E2
        MOVE.L  D6,-(A4)                        ; $1002E8
        MOVE.B  -(A0),D6                        ; $1002EA
        AND.L  -(A4),D1                         ; $1002EC
        MOVEA.B $0A(A0,D4.W),A4                 ; $1002EE
        SUB.W  -(A1),D0                         ; $1002F2
        ADD.B  D1,A4                            ; $1002F4
        MOVE.L  D1,D7                           ; $1002F6
        OR.W   D2,A0                            ; $1002F8
        SCC     -(A3)                           ; $1002FA
        DC.W    $05FD               ; $1002FC BSET    D2,<EA:3D>
        MOVE.B  D0,(A0)+                        ; $1002FE
        MOVE.L  (A0)+,D2                        ; $100300
        MOVEQ   #$05,D6                         ; $100302
        ADDQ.L  #5,(A0)                         ; $100304
loc_100306:
        BSR.S  loc_1002D9                       ; $100306
        DC.W    $1579,$E17F,$2C2F,$E90E; $100308 MOVE.B  $E17F2C2F,-$16F2(A2)
        AND.B  D6,-(A0)                         ; $100310
        MULS    -(A0),D1                        ; $100312
        MOVE.W  (A4),$0F(A5,A0.W)               ; $100314
        SUB.L  D0,$0EE0(A3)                     ; $100318
        ROR.W  (A2)                             ; $10031C
loc_10031E:
        MOVE.B  $817F.W,-(A2)                   ; $10031E
        TST.B  $46(A1,A2.L)                     ; $100322
        MOVE.W  -$395B(A0),-(A2)                ; $100326
        MOVE.B  (A4),(A4)+                      ; $10032A
        MOVE.L  (A2)+,-(A1)                     ; $10032C
        SUB.W  -(A3),D2                         ; $10032E
        ADDQ.L  #1,A4                           ; $100330
        BPL.S  loc_100385                       ; $100332
loc_100334:
        OR.W   D6,A2                            ; $100334
        MOVE.W  $4635(A1),-$3A(A0,D2.L)         ; $100336
        MOVE.L  (A0)+,-(A2)                     ; $10033C
        ADD.L  -(A3),D2                         ; $10033E
        MOVE.B  A4,D5                           ; $100340
        BLS.S  loc_100395                       ; $100342
        OR.W   $518D(PC),D6                     ; $100344
        TST.B  $46(A1,A2.L)                     ; $100348
        MOVE.W  -$395B(A0),-(A2)                ; $10034C
        MOVE.B  (A4),(A4)+                      ; $100350
        MOVE.L  (A2)+,-(A1)                     ; $100352
        SUB.W  -(A3),D2                         ; $100354
        ADDQ.L  #1,A4                           ; $100356
        BPL.S  loc_1003AB                       ; $100358
        OR.W   D6,A2                            ; $10035A
        MOVE.W  $4635(A1),-$3A(A0,D2.L)         ; $10035C
loc_100362:
        OR.B   D1,(A0)+                         ; $100362
        ADD.W  -(A3),D2                         ; $100364
        MOVE.B  (A4),(A7)                       ; $100366
        BLS.S  loc_1003BC                       ; $100368
        OR.W   $518D(A2),D6                     ; $10036A
        TST.B  $46(A1,A2.L)                     ; $10036E
        MOVE.W  -$395B(A0),-(A2)                ; $100372
        MOVE.B  (A4),(A4)+                      ; $100376
        MOVE.L  (A2)+,-(A1)                     ; $100378
        SUB.W  -(A3),D2                         ; $10037A
        ADDQ.L  #1,A4                           ; $10037C
        BPL.S  loc_1003D1                       ; $10037E
        OR.W   D6,A2                            ; $100380
        MOVE.W  -(A0),$35(A0,A4.W)              ; $100382
        MOVE.B  D7,(A4)+                        ; $100386
loc_100388:
        MOVE.L  (A0)+,-(A2)                     ; $100388
        ADD.W  -(A3),D2                         ; $10038A
        MOVE.B  (A4),(A5)                       ; $10038C
        BCC.S  loc_100362                       ; $10038E
        OR.L   (A2)+,D6                         ; $100390
        SUBQ.L  #8,(A3)                         ; $100392
        TST.B  $46(A2,D6.L)                     ; $100394
        DC.W    $4D28               ; $100398 DC.W    $4D28
        AND.L  D4,-(A5)                         ; $10039A
        MOVE.B  $26(A4,A2.W),-(A4)              ; $10039C
        SUB.W  -(A4),D2                         ; $1003A0
        ADD.L  A4,D1                            ; $1003A2
        SUB.W  (A1),D5                          ; $1003A4
        SUB.W  D1,A2                            ; $1003A6
        MOVEA.W $464C(A1),A1                    ; $1003A8
        MOVE.B  A1,(A4)+                        ; $1003AC
loc_1003AE:
        MOVE.L  (A1)+,-(A1)                     ; $1003AE
        ADDQ.L  #2,-(A3)                        ; $1003B0
        MOVE.L  (A4),(A3)                       ; $1003B2
        BCC.S  loc_100388                       ; $1003B4
        OR.L   (A2)+,D6                         ; $1003B6
        SUBQ.L  #8,(A3)                         ; $1003B8
        TST.B  $46(A2,D6.L)                     ; $1003BA
        DC.W    $4D28               ; $1003BE DC.W    $4D28
        AND.L  D4,-(A5)                         ; $1003C0
        MOVE.B  $26(A4,A2.W),-(A4)              ; $1003C2
        SUB.W  -(A4),D2                         ; $1003C6
        ADD.L  A4,D1                            ; $1003C8
        SUB.W  (A1),D5                          ; $1003CA
        SUB.B  D1,D6                            ; $1003CC
        MOVEA.W -$39AB(A0),A1                   ; $1003CE
        MOVE.L  A1,(A4)+                        ; $1003D2
        MOVE.L  (A1)+,-(A2)                     ; $1003D4
        MOVE.W  -(A3),(A2)                      ; $1003D6
        MOVE.L  (A4),(A3)                       ; $1003D8
        BCC.S  loc_1003AE                       ; $1003DA
        OR.L   (A2)+,D6                         ; $1003DC
        SUBQ.L  #8,(A3)                         ; $1003DE
        TST.B  $46(A2,D6.L)                     ; $1003E0
        DC.W    $4D28               ; $1003E4 DC.W    $4D28
        AND.L  D4,-(A5)                         ; $1003E6
        MOVE.B  $26(A4,A2.W),-(A4)              ; $1003E8
        SUB.W  -(A4),D2                         ; $1003EC
        AND.L  D0,A4                            ; $1003EE
        SUB.B  $4A(A1,A1.W),D5                  ; $1003F0
        MOVEA.W -$39B3(A0),A1                   ; $1003F4
        MOVE.L  A4,(A4)+                        ; $1003F8
        MOVE.L  (A1)+,-(A2)                     ; $1003FA
        SUB.L  -(A3),D2                         ; $1003FC
        MOVE.W  (A4),(A1)                       ; $1003FE
        BNE.S  loc_100454                       ; $100400
        DIVU    A2,D6                           ; $100402
        SUBQ.L  #8,(A1)+                        ; $100404
        TST.B  $46(A3,D2.L)                     ; $100406
        BCS.S  loc_100434                       ; $10040A
        AND.L  -(A5),D6                         ; $10040C
        MOVE.B  (A4),$32(A4,A2.W)               ; $10040E
        SUB.W  -(A6),D2                         ; $100412
        ADDQ.L  #1,A4                           ; $100414
        AND.B  $46(A1,A1.L),D4                  ; $100416
        MOVE.W  $4665(A1),$28CC(A1)             ; $10041A
        MOVE.L  (A1)+,-(A2)                     ; $100420
        SUB.L  -(A3),D2                         ; $100422
        MOVE.W  (A4),(A1)                       ; $100424
        BNE.S  loc_10047A                       ; $100426
        DIVU    A2,D6                           ; $100428
        SUBQ.L  #8,(A1)+                        ; $10042A
        TST.B  $46(A3,D2.L)                     ; $10042C
        BCS.S  loc_10045A                       ; $100430
        AND.L  -(A5),D6                         ; $100432
loc_100434:
        MOVE.B  (A4),$32(A4,A2.W)               ; $100434
        CMPI.W  #$518C,-(A6)                    ; $100438
        ADD.W  (A1),D5                          ; $10043C
        SUB.W  D4,A2                            ; $10043E
        MOVE.W  $4665(A1),-(A1)                 ; $100440
        MOVE.L  A4,(A4)+                        ; $100444
loc_100446:
        MOVE.L  (A1)+,-(A2)                     ; $100446
        SUB.L  -(A3),D2                         ; $100448
        MOVE.W  (A4),(A1)                       ; $10044A
        BNE.S  loc_1004A0                       ; $10044C
        DIVU    A2,D6                           ; $10044E
        SUBQ.L  #8,(A1)+                        ; $100450
        TST.B  $46(A3,D2.L)                     ; $100452
        BCS.S  loc_100480                       ; $100456
        AND.L  D3,D6                            ; $100458
loc_10045A:
        MOVE.B  (A4),$36(A4,D6.W)               ; $10045A
        SUB.W  -(A6),D2                         ; $10045E
        SUBQ.L  #8,A4                           ; $100460
        AND.W  (A1),D5                          ; $100462
        SUB.W  D7,A2                            ; $100464
        DC.W    $33E9,$467D,$28CF,$A519; $100466 MOVE.W  $467D(A1),$28CFA519
        MOVE.W  -(A3),(A2)                      ; $10046E
        MOVE.W  (A4),(A7)                       ; $100470
        BEQ.S  loc_100446                       ; $100472
        DIVU    $519F(PC),D6                    ; $100474
        TST.B  $46(A3,A6.L)                     ; $100478
        MOVE.W  -$305B(A0),-(A6)                ; $10047C
loc_100480:
        MOVE.B  $3E(A0,D6.W),#$8C68             ; $100480
        ADDQ.L  #1,A4                           ; $100486
        MOVEA.W (A1),A5                         ; $100488
        SUB.W  D7,A2                            ; $10048A
        DC.W    $33E9,$467D,$28CF,$A519; $10048C MOVE.W  $467D(A1),$28CFA519
        MOVE.W  -(A3),(A2)                      ; $100494
        MOVE.W  (A4),(A7)                       ; $100496
        BEQ.S  loc_10046C                       ; $100498
        DIVU    $519F(PC),D6                    ; $10049A
        TST.B  $46(A3,A6.L)                     ; $10049E
        MOVEQ   #$18,D6                         ; $1004A2
        AND.L  D7,-(A3)                         ; $1004A4
        MOVE.B  (A4),D5                         ; $1004A6
        DC.W    $A33E               ; $1004A8 MOVE.L  <EA:3E>,-(A1)
        SUB.W  -(A7),D2                         ; $1004AA
        ADD.L  A4,D1                            ; $1004AC
        MOVEA.W (A1),A5                         ; $1004AE
        SUB.W  D7,A2                            ; $1004B0
        DC.W    $33E9,$467D,$28CF,$A519; $1004B2 MOVE.W  $467D(A1),$28CFA519
        MOVE.W  -(A3),(A2)                      ; $1004BA
        MOVE.W  (A4),(A7)                       ; $1004BC
        BEQ.S  loc_100492                       ; $1004BE
        DIVU    $519F(PC),D6                    ; $1004C0
        ADDI.B  #$E8C6,$28(A3,A0.W)             ; $1004C4
        AND.L  D7,-(A3)                         ; $1004CA
        MOVE.B  $4A(A4,A0.W),#$9069             ; $1004CC
        ADDQ.B  #1,A5                           ; $1004D2
        MOVEA.L D1,A5                           ; $1004D4
        MOVE.L  A0,$34A9(A2)                    ; $1004D6
        ADDI.L  #$20D2A41A,(A5)                 ; $1004DA
        ADDQ.L  #2,D3                           ; $1004E0
        TST.L  (A0)                             ; $1004E2
        BVS.S  loc_100538                       ; $1004E4
        BTST    D6,$41A5(A2)                    ; $1004E6
        DC.W    $4834               ; $1004EA DC.W    $4834
        MOVE.L  D6,(A0)                         ; $1004EC
        SUB.B  D2,(A0)                          ; $1004EE
        ADD.L  D1,-(A4)                         ; $1004F0
        MOVEA.B (A4),A5                         ; $1004F2
        OR.W   D1,A2                            ; $1004F4
        SUB.W  $520D(A1),D0                     ; $1004F6
        MOVEA.L D1,A5                           ; $1004FA
        MOVE.L  A0,$34A9(A2)                    ; $1004FC
        ADDI.L  #$20D2A41A,(A5)                 ; $100500
        ADDQ.L  #2,D3                           ; $100506
        TST.L  (A0)                             ; $100508
        BVS.S  loc_10055E                       ; $10050A
        BTST    D6,$21A5(A0)                    ; $10050C
        NEG.B  $06(A4,A6.L)                     ; $100510
        SUB.B  D2,-(A0)                         ; $100514
        ADD.L  -(A4),D1                         ; $100516
        MOVEA.B (A4),A5                         ; $100518
        OR.W   D1,A2                            ; $10051A
        SUB.W  $520D(A1),D0                     ; $10051C
        MOVEA.L D1,A5                           ; $100520
        MOVE.L  A0,$34A9(A2)                    ; $100522
        ADDI.L  #$20D2A41A,(A5)                 ; $100526
        ADDQ.L  #2,D3                           ; $10052C
        TST.B  A0                               ; $10052E
        BVS.S  loc_100583                       ; $100530
        BTST    D6,$41A5(PC)                    ; $100532
        NEG.B  $7D(A4,A1.L)                     ; $100536
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $10053A
        DC.W    $DF7D               ; $10053E ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100540
        DC.W    $DF7D               ; $100544 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100546
        DC.W    $DF7D               ; $10054A ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $10054C
        DC.W    $DF7D               ; $100550 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100552
        DC.W    $DF7D               ; $100556 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100558
        DC.W    $DF7D               ; $10055C ADD.W  D7,<EA:3D>
loc_10055E:
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $10055E
        DC.W    $DF7D               ; $100562 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100564
        DC.W    $DF7D               ; $100568 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $10056A
        DC.W    $DF7D               ; $10056E ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100570
        DC.W    $DF7D               ; $100574 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100576
        DC.W    $DF7D               ; $10057A ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $10057C
        DC.W    $DF7D               ; $100580 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100582
        DC.W    $DF7D               ; $100586 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100588
        DC.W    $DF7D               ; $10058C ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $10058E
        DC.W    $DF7D               ; $100592 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $100594
        DC.W    $DF7D               ; $100598 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $10059A
        DC.W    $DF7D               ; $10059E ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $1005A0
        DC.W    $DF7D               ; $1005A4 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $1005A6
        DC.W    $DF7D               ; $1005AA ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $1005AC
        MOVE.W  D0,$0E(A7,D0.L)                 ; $1005B0
        DC.W    $0000,$0000         ; $1005B4 ORI.B  #$0000,D0
        BSET    D0,$7D(A7,A5.L)                 ; $1005B8
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $1005BC
        DC.W    $DF7D               ; $1005C0 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $1005C2
        DC.W    $DF7D               ; $1005C6 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $1005C8
        DC.W    $DF7D               ; $1005CC ADD.W  D7,<EA:3D>
        MOVE.L  D0,D7                           ; $1005CE
        DC.W    $04FA               ; $1005D0 DC.W    $04FA
        CMP.W  D5,D2                            ; $1005D2
        SVS     $7D(A7,A5.L)                    ; $1005D4
        BRA.S  loc_1005F3                       ; $1005D8
        MOVE.L  D1,D4                           ; $1005DA
        MOVEQ   #$43,D2                         ; $1005DC
        MOVE.W  (A2)+,-(A4)                     ; $1005DE
        OR.B   (A7),D0                          ; $1005E0
        AND.B  $06(A3,A2.L),D0                  ; $1005E2
        OR.B   D3,D0                            ; $1005E6
        MOVE.B  -(A4),(A2)                      ; $1005E8
        MOVEA.B $61(A4,D4.W),A5                 ; $1005EA
        DC.W    $ABE2               ; $1005EE MOVE.L  -(A2),<EA:3D>
        EOR.W  D0,#$5A2A                        ; $1005F0
        BSET    D5,D3                           ; $1005F4
        ASR.L  #7,D0                            ; $1005F6
        MULU    $5F0D(A5),D4                    ; $1005F8
        BPL.S  loc_10061F                       ; $1005FC
        MULU    (A5),D6                         ; $1005FE
        DC.W    $F17D,$BE31         ; $100600 MOVE.W  <EA:3D>,-$41CF(A0)
        CMPA.L  D6,A2                           ; $100604
        MOVE.W  $44(A4,D0.L),-$241F(PC)         ; $100606
        ADD.W  D0,#$3E2B                        ; $10060C
        OR.W   D5,D4                            ; $100610
        MOVE.W  -(A5),$36(A0,A3.L)              ; $100612
        CMP.W  D6,D2                            ; $100616
        SUB.L  (A0)+,D3                         ; $100618
        ROXR.W  D1,D1                           ; $10061A
        MOVE.W  $60(A1,A4.L),$0960(A2)          ; $10061C
        ADDQ.W  #8,(A4)+                        ; $100622
        MOVE.L  $0A40(A0),D0                    ; $100624
        MOVEA.B (A7)+,A2                        ; $100628
        MOVE.B  A2,-(A0)                        ; $10062A
        ASR.W  #1,D1                            ; $10062C
        BTST    #9,A2                           ; $10062E
        NEG.B  (A0)                             ; $100632
        MOVE.L  $2574(A4),(A4)                  ; $100634
        AND.W  (A6)+,D2                         ; $100638
        MOVE.W  -(A4),(A4)+                     ; $10063A
        ADD.B  (A5)+,D2                         ; $10063C
        SUB.B  -(A0),D4                         ; $10063E
        SUBQ.W  #8,D4                           ; $100640
        MOVE.W  -$7751(A2),-$20(A3,D0.W)        ; $100642
        SUB.B  D5,D4                            ; $100648
        ORI.W  #$0380,D0                        ; $10064A
        ASL.B  #8,D1                            ; $10064E
        AND.B  D0,-$1E(A3,A4.W)                 ; $100650
        MOVE.W  (A4)+,D0                        ; $100654
        ADDQ.B  #1,(A3)                         ; $100656
        MOVE.L  D0,-(A4)                        ; $100658
        MOVE.W  A0,$4D65(A0)                    ; $10065A
        BSET    D0,D5                           ; $10065E
        MOVE.B  $E407.W,-(A0)                   ; $100660
        ORI.L  #$0833C0E2,D0                    ; $100664
        MOVE.L  $03(A0,A4.L),(A0)+              ; $10066A
        DIVS    -(A0),D4                        ; $10066E
        MOVE.W  D4,-(A0)                        ; $100670
        DC.W    $0E00               ; $100672 DC.W    $0E00
        OR.B   A0,D0                            ; $100674
        ASL.W  #2,D2                            ; $100676
        SUBI.W  #$A182,$10(A0,D3.L)             ; $100678
        BTST    D0,(A4)+                        ; $10067E
        MOVE.L  -(A0),D5                        ; $100680
        SUB.B  D4,D4                            ; $100682
        MOVEA.L D7,A0                           ; $100684
        ASR.B  D2,D7                            ; $100686
        NEGX.L (A2)                             ; $100688
        MOVE.L  $2F(A4,A0.W),-$77DD(A3)         ; $10068A
        DIVS    -(A4),D4                        ; $100690
        ASR.W  #8,D7                            ; $100692
        MOVE.L  A1,D1                           ; $100694
        SUB.B  D6,D1                            ; $100696
        BVC.S  loc_1006E9                       ; $100698
        DC.W    $4140               ; $10069A DC.W    $4140
        DC.W    $4F81               ; $10069C DC.W    $4F81
        TST.W  $23CF.W                          ; $10069E
        DC.W    $0479,$E08F,$0411,$E88F; $1006A2 SUBI.W  #$E08F,$0411E88F
        AND.B  D3,$04(A0,D4.W)                  ; $1006AA
        CMPA.L  $1FB8(PC),A0                    ; $1006AE
        AND.L  $17(A7,D4.W),D4                  ; $1006B2
        MOVE.L  -(A2),D1                        ; $1006B6
        ADD.B  D7,D4                            ; $1006B8
        ADDQ.L  #7,D4                           ; $1006BA
        OR.W   D5,$7E(A6,D5.W)                  ; $1006BC
        MOVE.B  -$2BBA(A5),D5                   ; $1006C0
        SUBA.W  -$4887(A0),A4                   ; $1006C4
        LEA     -$26(PC,D2.W),A7                ; $1006C8
        MOVE.L  -(A3),-(A3)                     ; $1006CC
        MOVE.B  $7A(A2,D2.L),D5                 ; $1006CE
        MOVE.L  -$7BBC(A2),-$58(A6,D5.L)        ; $1006D2
        OR.B   D6,$6F(A2,D1.W)                  ; $1006D8
        SUB.B  -$26(A6,A2.W),D1                 ; $1006DC
        DC.W    $2DD4               ; $1006E0 MOVE.L  (A4),<EA:3E>
        NOT.L  (A0)+                            ; $1006E2
        MOVE.L  $4F(A7,D6.W),(A4)               ; $1006E4
        LSR.L  D6,D7                            ; $1006E8
        MOVE.W  D5,-(A3)                        ; $1006EA
        DC.W    $45A4               ; $1006EC DC.W    $45A4
        CMP.B  (A2),D7                          ; $1006EE
        MOVE.B  -$43C9(A6),$5786(A0)            ; $1006F0
        LSR.W  $5E(A0,A5.L)                     ; $1006F6
        MOVE.B  -$3C8B(A3),$6E(A5,D7.L)         ; $1006FA
        MOVE.L  A5,-(A1)                        ; $100700
        ADD.B  D2,-(A5)                         ; $100702
        DC.W    $4784               ; $100704 DC.W    $4784
        MOVE.W  (A7),(A5)+                      ; $100706
        DIVU    -$0F23(A2),D3                   ; $100708
        ADDQ.B  #7,(A3)+                        ; $10070C
        DC.W    $ABC3               ; $10070E MOVE.L  D3,<EA:3D>
        MOVE.W  $6EA9.W,$0DD5(A2)               ; $100710
        MOVE.L  A6,$38(PC,A2.L)                 ; $100716
        SUBQ.L  #3,D6                           ; $10071A
        LSL.W  $5E(A0,A5.L)                     ; $10071C
        MOVE.B  -$3C4B(A3),$76(A6,D7.L)         ; $100720
        MOVE.L  A6,-(A7)                        ; $100726
        ADDA.L  -(A1),A2                        ; $100728
        ADD.L  #$3B57876A,D5                    ; $10072A
        MOVE.W  $5E1D(A5),(A0)+                 ; $100730
loc_100734:
        DC.W    $ABC3               ; $100734 MOVE.L  D3,<EA:3D>
        EOR.W  D2,$76AF.W                       ; $100736
        DC.W    $0ED5               ; $10073A DC.W    $0ED5
        ASL.W  (A2)+                            ; $10073C
        CMP.B  -$79(PC,D5.L),D6                 ; $10073E
        BPL.S  loc_100734                       ; $100742
        MOVE.W  (A6)+,$1FAB(A6)                 ; $100744
        MULS    $7E(A5,D7.L),D1                 ; $100748
        MOVE.L  A7,-(A7)                        ; $10074C
        ADDA.L  -(A1),A2                        ; $10074E
        MOVE.W  #$3F57,(A5)                     ; $100750
        DIVS    -$0F03(A2),D3                   ; $100754
        ADDQ.B  #7,(A7)+                        ; $100758
        DC.W    $ABC3               ; $10075A MOVE.L  D3,<EA:3D>
        MOVE.W  $7EAF.W,$0FD5(A2)               ; $10075C
        ASL.W  -$03C1(PC)                       ; $100762
        SUBQ.L  #3,A0                           ; $100766
        BPL.S  loc_10075B                       ; $100768
        BCHG    D6,(A6)+                        ; $10076A
        MOVE.L  -$3BCB(A3),-$7A(A0,D7.L)        ; $10076C
        MOVE.L  (A0),-(A7)                      ; $100772
        ADDA.L  -(A2),A2                        ; $100774
        MOVE.B  #$4357,(A5)                     ; $100776
        OR.W   -$0EF3(A2),D4                    ; $10077A
        ADDQ.B  #7,-(A1)                        ; $10077E
        DC.W    $ABC4               ; $100780 MOVE.L  D4,<EA:3D>
        MOVE.W  $86AF.W,$10D7(A2)               ; $100782
        ROR.B  #1,D2                            ; $100788
        CMP.W  D7,D6                            ; $10078A
        SUBQ.L  #3,A0                           ; $10078C
        LSR.W  $5E(A1,D1.L)                     ; $10078E
        MOVE.L  -$3B8B(A3),-$72(A1,D7.L)        ; $100792
        MOVE.L  (A1),-(A7)                      ; $100798
        ADDA.L  -(A2),A2                        ; $10079A
        MOVE.W  #$4757,(A5)                     ; $10079C
        DIVU    -$0EE3(A2),D4                   ; $1007A0
        ADDQ.B  #7,-(A3)                        ; $1007A4
        DC.W    $ABC4               ; $1007A6 MOVE.L  D4,<EA:3D>
        MOVE.W  $8EBF.W,$11D5(A2)               ; $1007A8
        ROR.W  #1,D2                            ; $1007AE
        CMP.W  A3,D6                            ; $1007B0
        SUBQ.L  #3,A1                           ; $1007B2
        BPL.S  loc_1007A7                       ; $1007B4
        MOVE.L  (A6)+,$25AB(A6)                 ; $1007B6
        AND.L  -$6A(A5,D7.L),D2                 ; $1007BA
        MOVE.L  (A2),-(A7)                      ; $1007BE
        ADDA.L  -(A2),A2                        ; $1007C0
        ADDQ.L  #5,#$4B57896A                   ; $1007C2
        MOVE.W  $5E25(A5),-(A0)                 ; $1007C8
        DC.W    $ABC4               ; $1007CC MOVE.L  D4,<EA:3D>
        CMPA.L  $96AF.W,A2                      ; $1007CE
        MOVE.B  (A5),$E27ABC4F                  ; $1007D2
        SUBQ.L  #3,A1                           ; $1007D8
        LSR.W  $5E(A1,D3.L)                     ; $1007DA
        MOVE.L  -$3B0B(A3),-$62(A3,D7.L)        ; $1007DE
        MOVE.L  (A3),-(A7)                      ; $1007E4
        ADDA.L  -(A2),A2                        ; $1007E6
        MOVEQ   #-$44,D5                        ; $1007E8
        DC.W    $4F57               ; $1007EA DC.W    $4F57
        DIVS    -$0EC3(A2),D4                   ; $1007EC
        ADDQ.B  #7,-(A7)                        ; $1007F0
        DC.W    $AFC4               ; $1007F2 MOVE.L  D4,<EA:3F>
        MOVE.W  $A6AF.W,$14D5(A2)               ; $1007F4
        ROR.L  #1,D2                            ; $1007FA
        CMP.W  (A3),D6                          ; $1007FC
        SUBQ.L  #3,A2                           ; $1007FE
        BPL.S  loc_1007F3                       ; $100800
        DC.W    $4D5E               ; $100802 DC.W    $4D5E
        MOVE.L  -$3ACB(A3),-$5A(A4,D7.L)        ; $100804
        MOVE.L  (A4),-(A7)                      ; $10080A
        ADDA.L  -(A2),A2                        ; $10080C
        SUB.L  #$53578A6A,D5                    ; $10080E
        MOVE.W  A5,$7E29(A0)                    ; $100814
        DC.W    $ABC5               ; $100818 MOVE.L  D5,<EA:3D>
        MOVE.W  $AEAF.W,$15D5(A2)               ; $10081A
        ROR.L  D1,D2                            ; $100820
        CMP.W  (A7),D6                          ; $100822
        SUBQ.L  #3,A2                           ; $100824
        LSR.W  $5E(A1,D5.L)                     ; $100826
        MOVE.L  -$3A8B(A3),-$52(A5,D7.L)        ; $10082A
        MOVE.L  (A5),-(A7)                      ; $100830
        ADDA.L  -(A2),A2                        ; $100832
        CMP.L  #$57578AEB,D5                    ; $100834
        MOVE.W  (A5)+,$5E2D(A0)                 ; $10083A
        DC.W    $ABC5               ; $10083E MOVE.L  D5,<EA:3D>
        EOR.W  D2,$B6AF.W                       ; $100840
        MOVE.B  (A5),(A3)+                      ; $100844
        LSR.W  (A2)+                            ; $100846
        CMP.W  (A3)+,D6                         ; $100848
        SUBQ.L  #3,A3                           ; $10084A
        BPL.S  loc_10083F                       ; $10084C
        BLT.S  loc_1008AE                       ; $10084E
        MOVE.L  -$3A4B(A3),-$4A(A6,D7.L)        ; $100850
        MOVE.L  (A6),-(A7)                      ; $100856
        ADDA.L  -(A2),A2                        ; $100858
        ADD.L  #$5B5F8B6A,D5                    ; $10085A
        DC.W    $F17D,$5E2F         ; $100860 MOVE.W  <EA:3D>,$5E2F(A0)
        DC.W    $ABC5               ; $100864 MOVE.L  D5,<EA:3D>
        MOVE.W  $BEAF.W,$17D5(A2)               ; $100866
        LSR.W  -$43A1(PC)                       ; $10086C
        SUBQ.L  #3,A3                           ; $100870
        LSR.W  $5E(A1,D7.L)                     ; $100872
        MOVE.L  -$3A0B(A3),-$42(A7,D7.L)        ; $100876
        MOVE.L  (A7),-(A7)                      ; $10087C
        ADDA.L  -(A2),A2                        ; $10087E
        MOVE.W  #$5F57,(A5)+                    ; $100880
        OR.W   -$0E73(A2),D6                    ; $100884
        ADDQ.B  #7,-$3A(A1,A2.L)                ; $100888
        MOVE.W  $C6AF.W,$18D5(A2)               ; $10088C
        ROL.B  #1,D2                            ; $100892
        CMP.W  -(A3),D6                         ; $100894
        SUBQ.L  #3,A4                           ; $100896
        BPL.S  loc_10088B                       ; $100898
        OR.W   D6,(A6)+                         ; $10089A
        MOVE.W  -$39CB(A3),-$3A(A0,D7.L)        ; $10089C
        MOVE.L  (A0)+,-(A7)                     ; $1008A2
        ADDA.L  -(A3),A2                        ; $1008A4
        MOVE.B  #$4B57,(A5)                     ; $1008A6
        OR.W   D4,-$0ED3(A2)                    ; $1008AA
loc_1008AE:
        ADDQ.B  #7,-(A5)                        ; $1008AE
        DC.W    $ABC4               ; $1008B0 MOVE.L  D4,<EA:3D>
        EOR.W  D2,$96AF.W                       ; $1008B2
        MOVE.B  (A5),(A1)+                      ; $1008B6
        ROR.W  #1,D2                            ; $1008B8
        CMP.W  A3,D6                            ; $1008BA
        SUBQ.L  #3,A1                           ; $1008BC
        BPL.S  loc_1008B1                       ; $1008BE
        MOVE.L  (A6)+,$25AB(A6)                 ; $1008C0
        AND.L  -$6A(A5,D7.L),D2                 ; $1008C4
        MOVE.L  (A2),-(A7)                      ; $1008C8
        ADDA.L  -(A2),A3                        ; $1008CA
        ADDQ.L  #5,#$4F5789EA                   ; $1008CC
        DC.W    $F13D               ; $1008D2 MOVE.W  <EA:3D>,-(A0)
        ADDQ.B  #7,-(A7)                        ; $1008D4
        DC.W    $ABC4               ; $1008D6 MOVE.L  D4,<EA:3D>
        MOVE.W  $9EAF.W,$13D5(A2)               ; $1008D8
        ROR.W  D1,D2                            ; $1008DE
        CMP.W  A7,D6                            ; $1008E0
        SUBQ.L  #3,A1                           ; $1008E2
        LSR.W  $5E(A1,D3.L)                     ; $1008E4
        MOVE.L  -$3B0B(A3),-$62(A3,D7.L)        ; $1008E8
        EOR.B  D7,(A3)                          ; $1008EE
        ADDA.L  -(A2),A2                        ; $1008F0
        SUB.L  #$53578A6A,D5                    ; $1008F2
        MOVE.W  A5,$5E29(A0)                    ; $1008F8
        DC.W    $ABC5               ; $1008FC MOVE.L  D5,<EA:3D>
        MOVE.W  $A6AF.W,$14D5(A2)               ; $1008FE
        ROR.L  #1,D2                            ; $100904
        CMP.W  (A3),D6                          ; $100906
        SUBQ.L  #3,A2                           ; $100908
        BPL.S  loc_1008FD                       ; $10090A
        DC.W    $4D5E               ; $10090C DC.W    $4D5E
        MOVE.L  -$3ACB(A3),-$5A(A4,A7.L)        ; $10090E
        MOVE.L  (A5),-(A7)                      ; $100914
        ADDA.L  -(A2),A2                        ; $100916
        CMP.L  #$57578AEA,D5                    ; $100918
        MOVE.W  (A5)+,$5E2B(A0)                 ; $10091E
        DC.W    $ABC5               ; $100922 MOVE.L  D5,<EA:3D>
        MOVE.W  $AEAF.W,$15D5(A2)               ; $100924
        ROR.L  D1,D2                            ; $10092A
        CMP.W  (A7),D6                          ; $10092C
        SUBQ.L  #3,A2                           ; $10092E
        LSR.W  $5E(A1,D5.L)                     ; $100930
        MOVE.L  -$3A8B(A7),-$4A(A5,D7.L)        ; $100934
        MOVE.L  (A6),-(A7)                      ; $10093A
        ADDA.L  -(A2),A2                        ; $10093C
        ADD.L  #$5B578B6A,D5                    ; $10093E
        MOVE.W  $5E2D(A5),-$543B(A0)            ; $100944
        EOR.W  D2,$B6AF.W                       ; $10094A
        MOVE.B  (A5),(A3)+                      ; $10094E
        LSR.W  (A2)+                            ; $100950
        CMP.W  (A3)+,D6                         ; $100952
        SUBQ.L  #3,A3                           ; $100954
        BPL.S  loc_100949                       ; $100956
        BLT.S  loc_1009D8                       ; $100958
        MOVE.L  -$3A0B(A3),-$42(A6,D7.L)        ; $10095A
        MOVE.L  (A7),-(A7)                      ; $100960
        ADDA.L  -(A2),A2                        ; $100962
        MOVE.W  #$5F57,(A5)                     ; $100964
        DIVS    -$0E83(A2),D5                   ; $100968
        ADDQ.B  #7,-$543B(A7)                   ; $10096C
        MOVE.W  $BEAF.W,$17D5(A2)               ; $100970
        LSR.W  -$43A1(PC)                       ; $100976
        SUBQ.L  #3,A3                           ; $10097A
        LSL.W  $5E(A1,D7.L)                     ; $10097C
        MOVE.W  -$39CB(A3),-$3A(A0,D7.L)        ; $100980
        MOVE.L  (A0)+,-(A7)                     ; $100986
        ADDA.L  -(A3),A2                        ; $100988
        MOVE.B  #$6357,(A5)                     ; $10098A
        OR.W   -$0E73(A2),D6                    ; $10098E
        ADDQ.B  #7,-$3A(A1,A2.L)                ; $100992
        MOVE.W  $C6AF.W,$18D5(A2)               ; $100996
        ROL.B  #1,D2                            ; $10099C
        CMP.W  -(A3),D6                         ; $10099E
        SUBQ.L  #3,A4                           ; $1009A0
        BPL.S  loc_100995                       ; $1009A2
        MOVE.L  (A6)+,$25AB(A6)                 ; $1009A4
        AND.L  -$6A(A5,D7.L),D2                 ; $1009A8
        MOVE.L  (A2),-(A7)                      ; $1009AC
        ADDA.L  -(A2),A2                        ; $1009AE
        ADDQ.L  #5,#$4B57896A                   ; $1009B0
        MOVE.W  $5E25(A5),-(A0)                 ; $1009B6
        DC.W    $ABC4               ; $1009BA MOVE.L  D4,<EA:3D>
        EOR.W  D2,$96AF.W                       ; $1009BC
        MOVE.B  (A5),(A1)+                      ; $1009C0
        ROR.W  #1,D2                            ; $1009C2
        CMP.W  A3,D6                            ; $1009C4
        SUBQ.L  #7,A1                           ; $1009C6
        BPL.S  loc_1009BB                       ; $1009C8
        MOVE.W  (A6)+,$27AB(A6)                 ; $1009CA
        MULU    -$62(A5,D7.L),D2                ; $1009CE
        MOVE.L  (A3),-(A7)                      ; $1009D2
        ADDA.L  -(A2),A2                        ; $1009D4
        MOVEQ   #-$44,D5                        ; $1009D6
loc_1009D8:
        DC.W    $4F57               ; $1009D8 DC.W    $4F57
        DIVS    -$0EC3(A2),D4                   ; $1009DA
        ADDQ.B  #7,-(A7)                        ; $1009DE
        DC.W    $ABC4               ; $1009E0 MOVE.L  D4,<EA:3D>
        MOVE.W  $9EAF.W,$13D5(A2)               ; $1009E2
        ROR.W  D1,D2                            ; $1009E8
        MOVEA.W A7,A6                           ; $1009EA
        SUBQ.L  #3,A2                           ; $1009EC
        BPL.S  loc_1009E1                       ; $1009EE
        DC.W    $4D5E               ; $1009F0 DC.W    $4D5E
        MOVE.L  -$3ACB(A3),-$5A(A4,D7.L)        ; $1009F2
        MOVE.L  (A4),-(A7)                      ; $1009F8
        ADDA.L  -(A2),A2                        ; $1009FA
        SUB.L  #$53578A6A,D5                    ; $1009FC
        MOVE.W  A5,$5E29(A0)                    ; $100A02
        DC.W    $ABC5               ; $100A06 MOVE.L  D5,<EA:3D>
        MOVE.W  $A6AF.W,$14D7(A2)               ; $100A08
        ROR.L  #1,D2                            ; $100A0E
        CMP.W  (A7),D6                          ; $100A10
        SUBQ.L  #3,A2                           ; $100A12
        LSR.W  $5E(A1,D5.L)                     ; $100A14
        MOVE.L  -$3A8B(A3),-$52(A5,D7.L)        ; $100A18
        MOVE.L  (A5),-(A7)                      ; $100A1E
        ADDA.L  -(A2),A2                        ; $100A20
        CMP.L  #$57578AEA,D5                    ; $100A22
        MOVE.W  (A5)+,$5E2B(A0)                 ; $100A28
        DC.W    $ABC5               ; $100A2C MOVE.L  D5,<EA:3D>
        MOVE.W  $AEBF.W,$15D5(A2)               ; $100A2E
        LSR.W  (A2)+                            ; $100A34
        CMP.W  (A3)+,D6                         ; $100A36
        SUBQ.L  #3,A3                           ; $100A38
        BPL.S  loc_100A2D                       ; $100A3A
        BLT.S  loc_100A9C                       ; $100A3C
        MOVE.L  -$3A4B(A3),-$4A(A6,D7.L)        ; $100A3E
        MOVE.L  (A6),-(A7)                      ; $100A44
        ADDA.L  -(A2),A2                        ; $100A46
        ADD.L  #$5B578B6A,D5                    ; $100A48
        MOVE.W  $5E2D(A5),-$543B(A0)            ; $100A4E
        CMPA.L  $B6AF.W,A2                      ; $100A54
        MOVE.B  (A5),-$06(PC,A6.W)              ; $100A58
        CMP.W  (A7)+,D6                         ; $100A5C
        SUBQ.L  #3,A3                           ; $100A5E
        LSR.W  $5E(A1,D7.L)                     ; $100A60
        MOVE.L  -$3A0B(A3),-$42(A7,D7.L)        ; $100A64
        MOVE.L  (A7),-(A7)                      ; $100A6A
        ADDA.L  -(A2),A2                        ; $100A6C
        MOVE.W  #$5F57,(A5)                     ; $100A6E
        DIVS    -$0E83(A2),D5                   ; $100A72
        ADDQ.B  #7,-$543B(A7)                   ; $100A76
        MOVE.W  $07(A0,D0.L),$00(PC,D0.W)       ; $100A7A
        DC.W    $0000,$01F7         ; $100A80 ORI.B  #$01F7,D0
        DC.W    $DF7D               ; $100A84 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$60(PC,D7.L)             ; $100A86
        MOVE.B  -(A0),$1A82(A7)                 ; $100A8A
        CMPA.L  A1,A4                           ; $100A8E
        DC.W    $0588               ; $100A90 BCLR    D2,A0
        CMPI.L  #$96E02C29,D0                   ; $100A92
        ADD.B  D0,D0                            ; $100A98
        MOVEA.L D2,A5                           ; $100A9A
loc_100A9C:
        CMPA.L  A4,A4                           ; $100A9C
        ADD.L  D3,A5                            ; $100A9E
        MOVEQ   #-$80,D0                        ; $100AA0
        AND.B  A1,D4                            ; $100AA2
        MOVEQ   #$20,D5                         ; $100AA4
        BCHG    D2,(A0)                         ; $100AA6
        SUBQ.B  #3,$20B10190                    ; $100AA8
        DC.W    $13EF,$BE80,$A8C1,$0017; $100AAE MOVE.B  -$4180(A7),$A8C10017
        ADD.B  D6,D0                            ; $100AB6
        MOVE.L  D2,D0                           ; $100AB8
        MOVEQ   #$20,D1                         ; $100ABA
        MOVE.L  (A0)+,D1                        ; $100ABC
        MOVE.L  -(A5),(A0)                      ; $100ABE
        MOVE.W  (A0),D6                         ; $100AC0
        BCLR    #0,-$80(A1,D0.W)                ; $100AC2
        OR.B   A2,D4                            ; $100AC8
        MOVE.B  $0F004D50,(A0)+                 ; $100ACA
        SUBI.W  #$A0B1,A2                       ; $100AD0
        MOVEA.W D1,A1                           ; $100AD4
loc_100AD6:
        BSR.S  loc_100B40                       ; $100AD6
        NEGX   A2                               ; $100AD8
        MOVE.L  A0,D0                           ; $100ADA
        OR.B   D6,(A1)                          ; $100ADC
        DC.W    $CD7F               ; $100ADE AND.W  D6,<EA:3F>
        MOVE.L  D0,-(A4)                        ; $100AE0
        OR.W   $E810.W,D7                       ; $100AE2
        SUBQ.B  #8,A4                           ; $100AE6
        MOVEA.B (A3),A0                         ; $100AE8
        ASL.B  #6,D1                            ; $100AEA
        DC.W    $4501               ; $100AEC DC.W    $4501
        SUBI.L  #$42214021,D0                   ; $100AEE
        MOVEA.B $1A(A0,A3.W),A0                 ; $100AF4
        MOVEQ   #$40,D4                         ; $100AF8
        BCHG    D2,(A6)+                        ; $100AFA
        DC.W    $4814               ; $100AFC DC.W    $4814
        OR.L   A0,D0                            ; $100AFE
        DC.W    $0A07,$2169         ; $100B00 EORI.B  #$2169,D7
        BLS.S  loc_100B47                       ; $100B04
        BPL.S  loc_100AD6                       ; $100B06
        DC.W    $451C               ; $100B08 DC.W    $451C
        OR.B   $0290(A1),D4                     ; $100B0A
        MOVE.B  (A2),D1                         ; $100B0E
        DC.W    $02F3               ; $100B10 DC.W    $02F3
        BRA.S  loc_100B54                       ; $100B12
        ORI.W  #$4405,D0                        ; $100B14
        MOVE.L  D1,D4                           ; $100B18
        CMP.L  A0,D6                            ; $100B1A
        NEG.W  (A2)+                            ; $100B1C
        AND.B  D0,-(A2)                         ; $100B1E
        SUB.L  -$10(A6,D2.W),D4                 ; $100B20
        BTST    D1,(A0)                         ; $100B24
        MOVE.B  D1,-(A0)                        ; $100B26
        LEA     D0,A2                           ; $100B28
        ADDQ.W  #6,D7                           ; $100B2A
        NEG.B  A6                               ; $100B2C
        ORI.W  #$8440,D4                        ; $100B2E
        LEA     (A4)+,A4                        ; $100B32
        DC.W    $0749               ; $100B34 BCHG    D3,A1
        BCHG    D3,(A6)                         ; $100B36
        OR.B   D1,D0                            ; $100B38
loc_100B3A:
        NEGX.W $00A3.W                          ; $100B3A
        ADD.B  (A5)+,D0                         ; $100B3E
loc_100B40:
        MOVE.W  (A7)+,D0                        ; $100B40
        MOVE.L  D0,$1A21(A0)                    ; $100B42
        MOVE.L  (A4),$1D5C.W                    ; $100B46
        ROXR.W  #2,D1                           ; $100B4A
        AND.L  D2,(A1)                          ; $100B4C
        BTST    #25,$0050(A1)                   ; $100B4E
loc_100B54:
        CMPI.B  #$503C,D0                       ; $100B54
        SUB.W  A5,D0                            ; $100B58
        SUBI.W  #$6808,(A0)                     ; $100B5A
        SUBI.B  #$0726,$40(A6,D0.W)             ; $100B5E
        ADDQ.B  #3,(A1)+                        ; $100B64
        DC.W    $010E               ; $100B66 BTST    D0,A6
        BGE.S  loc_100BA4                       ; $100B68
        OR.L   D1,-(A0)                         ; $100B6A
        ANDI.W  #$20F0,D1                       ; $100B6C
        MOVE.L  A4,$440F(A0)                    ; $100B70
        OR.L   D1,D2                            ; $100B74
        MOVEQ   #-$80,D0                        ; $100B76
        BTST    D7,-(A6)                        ; $100B78
        MOVE.B  -(A1),-(A6)                     ; $100B7A
        ADDQ.B  #1,(A4)                         ; $100B7C
        ANDI.L  #$B9712411,(A0)                 ; $100B7E
        MOVE.W  A0,$47FC(PC)                    ; $100B84
        MOVE.B  $4A22(A1),D4                    ; $100B88
loc_100B8C:
        ASL.W  #6,D4                            ; $100B8C
        SUBQ.W  #4,(A0)                         ; $100B8E
        MOVEA.W D3,A6                           ; $100B90
        DC.W    $A83E               ; $100B92 MOVE.L  <EA:3E>,D4
        OR.W   D1,D0                            ; $100B94
        OR.B   $02F2(A7),D5                     ; $100B96
        BTST    D4,D0                           ; $100B9A
        SUB.B  -$7EB0(A5),D0                    ; $100B9C
        MOVE.L  D2,-$09D3(A7)                   ; $100BA0
loc_100BA4:
        ROR.B  D6,D2                            ; $100BA4
        DC.W    $42BF               ; $100BA6 CLR.L  <EA:3F>
        DC.W    $007C,$8500,$685F   ; $100BA8 ORI.W  #$8500,#$685F
        MOVE.B  A5,(A0)+                        ; $100BAE
        BTST    D6,D0                           ; $100BB0
        BGE.S  loc_100B3A                       ; $100BB2
        AND.L  D0,(A5)                          ; $100BB4
        DIVU    (A0)+,D2                        ; $100BB6
        BGE.S  loc_100B47                       ; $100BB8
        BTST    #7,(A4)                         ; $100BBA
        DC.W    $ABD4               ; $100BBE MOVE.L  (A4),<EA:3D>
        ADDI.L  #$3903D069,(A0)                 ; $100BC0
        OR.L   D5,D2                            ; $100BC6
        MOVE.L  D1,$2151(A5)                    ; $100BC8
        MOVE.B  -(A6),-$147F(A6)                ; $100BCC
        BTST    #13,#$0210                      ; $100BD0
        MOVEQ   #$1E,D2                         ; $100BD6
        BGE.S  loc_100C00                       ; $100BD8
        BSET    D0,-(A0)                        ; $100BDA
        MOVEA.L D2,A1                           ; $100BDC
        MOVE.L  D0,(A1)+                        ; $100BDE
        BSET    D0,$20(A0,D6.W)                 ; $100BE0
        ADD.B  (A0),D4                          ; $100BE4
        BCLR    #8,$3486(A0)                    ; $100BE6
        ROXR.W  D0,D2                           ; $100BEC
        BCLR    D0,-(A2)                        ; $100BEE
        MOVE.B  -(A1),$2038(A1)                 ; $100BF0
        MOVE.W  A2,D0                           ; $100BF4
        CMP.B  (A0)+,D6                         ; $100BF6
        BCHG    D2,(A2)+                        ; $100BF8
        BHI.S  loc_100BF7                       ; $100BFA
        NEG.W  (A3)+                            ; $100BFC
        BVC.S  loc_100B8C                       ; $100BFE
loc_100C00:
        BCHG    D7,(A0)                         ; $100C00
        ADDQ.B  #3,(A0)+                        ; $100C02
        MOVE.W  D4,-$7F(A0,D0.W)                ; $100C04
        OR.B   D2,(A0)+                         ; $100C08
        BPL.S  loc_100BAF                       ; $100C0A
        DC.W    $0D48               ; $100C0C BCHG    D6,A0
        DC.W    $1FBD,$91A9         ; $100C0E MOVE.B  <EA:3D>,-$57(A7,A1.W)
        MOVE.B  D1,-(A2)                        ; $100C12
        CMPA.W  $0EC8(A4),A0                    ; $100C14
        MOVE.L  (A2),D1                         ; $100C18
        MOVE.L  $0EDB(A5),(A0)+                 ; $100C1A
        BCLR    #2,-$2C(A0,A1.W)                ; $100C1E
        ADD.L  (A0),D5                          ; $100C24
        ADDA.W  (A2)+,A0                        ; $100C26
        ADDQ.W  #8,(A4)                         ; $100C28
        SUB.B  D0,A0                            ; $100C2A
        MOVE.W  (A6)+,$0C02(A0)                 ; $100C2C
        MOVE.W  (A1),-(A3)                      ; $100C30
        BHI.W  $105734                          ; $100C32
        MOVEQ   #$07,D2                         ; $100C36
        MOVE.B  (A7)+,D2                        ; $100C38
        NEGX.L $20(A0,D3.L)                     ; $100C3A
        MOVE.W  -(A0),-(A4)                     ; $100C3E
        MOVE.L  (A1),(A0)+                      ; $100C40
        EOR.B  D6,(A0)+                         ; $100C42
        ADD.B  A2,D0                            ; $100C44
        MULU    (A0),D0                         ; $100C46
        ADDI.L  #$3F130370,(A0)                 ; $100C48
        NEGX.B (A5)                             ; $100C4E
        MOVE.W  (A0),D4                         ; $100C50
        DC.W    $0A3C,$0585,$1E03   ; $100C52 EORI.B  #$0585,#$1E03
        MOVE.B  A1,-(A4)                        ; $100C58
        MOVEA.L -$7391(A3),A6                   ; $100C5A
        ORI.W  #$B632,A0                        ; $100C5E
        CMP.W  D1,D7                            ; $100C62
        PEA     $4770(A0)                       ; $100C64
        ANDI.W  #$1001,A0                       ; $100C68
        MOVEA.B -$80(A4,D7.W),A0                ; $100C6C
        MOVE.L  (A0)+,(A2)+                     ; $100C70
        SF      D2                              ; $100C72
        DC.W    $003C,$0775,$3A20   ; $100C74 ORI.B  #$0775,#$3A20
        BCLR    D2,D4                           ; $100C7A
loc_100C7C:
        ADDA.W  $9100.W,A6                      ; $100C7C
        ASL.W  D7,D3                            ; $100C80
        MOVEA.L (A6)+,A1                        ; $100C82
        DC.W    $23BE,$414F         ; $100C84 MOVE.L  <EA:3E>,$4F(A1,D4.W)
        MOVE.L  D5,$8055.W                      ; $100C88
        DC.W    $893E               ; $100C8C OR.B   D4,<EA:3E>
        AND.B  (A2),D2                          ; $100C8E
        CLR.L  -(A0)                            ; $100C90
        MOVEA.L D2,A1                           ; $100C92
        OR.B   -$1C(A4,D0.W),D0                 ; $100C94
        MOVE.W  $48(A4,D2.W),D7                 ; $100C98
        MOVE.L  D0,D3                           ; $100C9C
        MOVE.L  D3,-(A4)                        ; $100C9E
        AND.B  A4,D4                            ; $100CA0
        OR.W   (A4),D4                          ; $100CA2
        BSET    D3,$32(A1,D1.W)                 ; $100CA4
        MOVEQ   #-$38,D7                        ; $100CA8
        MOVE.L  D7,D2                           ; $100CAA
        OR.W   #$8508,D0                        ; $100CAC
        NEG.W  -$7FB0(A0)                       ; $100CB0
        BVC.S  loc_100C7C                       ; $100CB4
        SUB.B  D0,$4695(A4)                     ; $100CB6
        MOVEA.L -$72C9(A3),A6                   ; $100CBA
        BCLR    D0,(A4)                         ; $100CBE
        OR.B   A1,D2                            ; $100CC0
        MOVE.B  D6,(A2)                         ; $100CC2
        CMP.L  $2ED2(A0),D5                     ; $100CC4
        MOVE.B  (A7)+,-(A5)                     ; $100CC8
        MOVE.L  #$05E3C006,(A0)+                ; $100CCA
        MOVEA.L -(A4),A0                        ; $100CD0
        CLR.L  -(A0)                            ; $100CD2
        MOVEA.L D2,A1                           ; $100CD4
        OR.B   -(A0),D0                         ; $100CD6
        DC.W    $0220,$2843         ; $100CD8 ANDI.B  #$2843,-(A0)
        LSR.B  D0,D2                            ; $100CDC
        BTST    D0,-$2DE2(A2)                   ; $100CDE
        MOVE.B  -(A0),(A7)                      ; $100CE2
        MOVEQ   #-$14,D1                        ; $100CE4
        DC.W    $4802               ; $100CE6 DC.W    $4802
        MOVE.W  D3,(A6)                         ; $100CE8
        MOVE.L  -$105B(PC),D6                   ; $100CEA
        AND.B  D2,(A1)                          ; $100CEE
        BCHG    #3,D7                           ; $100CF0
        BCLR    D3,D4                           ; $100CF4
        SUB.W  D7,D2                            ; $100CF6
        OR.B   A1,D2                            ; $100CF8
        BCHG    D3,$46(A2,D6.W)                 ; $100CFA
        SUBI.W  #$A4F8,-(A0)                    ; $100CFE
        BCLR    D6,-(A5)                        ; $100D02
        MOVEA.W -(A6),A0                        ; $100D04
        AND.W  A2,D1                            ; $100D06
        MOVE.W  D6,-$48(A2,A5.W)                ; $100D08
        MOVE.W  D2,$048B(A2)                    ; $100D0C
        NEGX   -(A5)                            ; $100D10
        AND.W  $69825701,D0                     ; $100D12
        ASR.L  D3,D4                            ; $100D18
        BSET    D4,$C9A7.W                      ; $100D1A
        DIVS    (A2)+,D0                        ; $100D1E
        MOVE.W  $1008(PC),(A7)+                 ; $100D20
        SUBI.B  #$408A,(A2)+                    ; $100D24
        MOVE.W  -(A1),#$421B                    ; $100D28
        AND.B  -(A3),D5                         ; $100D2C
        MOVE.W  D4,-(A5)                        ; $100D2E
        MOVEA.L -$7203(A0),A6                   ; $100D30
        MOVE.L  D4,(A0)                         ; $100D34
        MOVE.L  $3C82.W,D3                      ; $100D36
        MOVE.B  -(A5),(A6)+                     ; $100D3A
        DC.W    $0222,$F845         ; $100D3C ANDI.B  #$F845,-(A2)
        ADDQ.B  #2,A1                           ; $100D40
        MOVE.L  -(A3),D7                        ; $100D42
        AND.B  (A4),D7                          ; $100D44
        MOVE.W  D7,(A2)+                        ; $100D46
        MOVE.L  (A1),-(A1)                      ; $100D48
        DC.W    $4361               ; $100D4A DC.W    $4361
        MOVE.W  A0,D6                           ; $100D4C
        MOVE.L  -(A3),-$7711(A4)                ; $100D4E
        CMP.B  (A5)+,D4                         ; $100D52
        ROXR.W  -$64(A1,A6.L)                   ; $100D54
        MOVE.W  D5,$0B(A6,A4.W)                 ; $100D58
        MOVE.B  D7,$800900D1                    ; $100D5C
        MOVEA.B (A6)+,A6                        ; $100D62
        DC.W    $038B               ; $100D64 BCLR    D1,A3
        ADDQ.W  #8,$05(A1,A6.L)                 ; $100D66
        BCC.S  loc_100DAD                       ; $100D6A
        AND.L  D2,D6                            ; $100D6C
        MOVE.B  -$36(A7,A4.W),D3                ; $100D6E
        MOVEA.L -(A1),A0                        ; $100D72
        SUBQ.B  #8,A4                           ; $100D74
        OR.B   -(A0),D4                         ; $100D76
        SUBA.L  D0,A0                           ; $100D78
        MOVE.W  $7E(A1,A1.W),$43CB(A5)          ; $100D7A
        MOVEA.L $B447.W,A1                      ; $100D80
        CMP.W  $F7CC.W,D5                       ; $100D84
        MOVE.B  $7199(PC),(A7)+                 ; $100D88
        DC.W    $4E33               ; $100D8C DC.W    $4E33
        MOVE.L  D6,#$6538CCA7                   ; $100D8E
        MOVE.B  (A4),$32(A4,A6.W)               ; $100D94
        SUB.W  -(A6),D6                         ; $100D98
        SUBQ.L  #1,A4                           ; $100D9A
        AND.W  $4E(A1,A1.L),D5                  ; $100D9C
        MOVE.W  -$399B(A1),-(A1)                ; $100DA0
        MOVE.W  A4,(A4)+                        ; $100DA4
        MOVE.L  (A1)+,-(A3)                     ; $100DA6
        SUBA.W  -(A3),A2                        ; $100DA8
        MOVE.W  (A4)+,(A1)                      ; $100DAA
        BNE.S  loc_100E01                       ; $100DAC
        DIVU    A2,D6                           ; $100DAE
        MOVE.W  (A1)+,$33(A0,D4.L)              ; $100DB0
        MOVE.L  D6,#$6538CCA7                   ; $100DB4
        MOVE.B  (A4),$32(A4,A6.W)               ; $100DBA
        SUB.W  -(A6),D6                         ; $100DBE
        SUBQ.L  #1,A4                           ; $100DC0
        AND.W  $4E(A1,A1.L),D5                  ; $100DC2
        MOVE.W  -$399B(A1),-(A1)                ; $100DC6
        MOVE.W  A4,(A4)+                        ; $100DCA
        MOVE.L  (A1)+,-(A3)                     ; $100DCC
        SUBA.W  -(A3),A2                        ; $100DCE
        MOVE.W  (A4)+,(A1)                      ; $100DD0
        BNE.S  loc_100E2B                       ; $100DD2
        DIVU    A2,D6                           ; $100DD4
        MOVE.W  -(A1),$34(A0,D4.L)              ; $100DD6
        MOVE.L  D6,#$8538D0A7                   ; $100DDA
        MOVE.B  (A4),D5                         ; $100DE0
        ASL.W  #1,D2                            ; $100DE2
        SUB.W  $538D(A0),D6                     ; $100DE4
        EORI.W  #$A14E,$29(A1,D3.W)             ; $100DE8
        AND.L  D5,D3                            ; $100DEE
        MOVE.W  (A0),(A4)+                      ; $100DF0
        MOVE.L  (A2)+,-(A3)                     ; $100DF2
        MOVE.B  -(A3),(A2)+                     ; $100DF4
        CLR.L  (A4)+                            ; $100DF6
        BVC.S  loc_100E4D                       ; $100DF8
        OR.B   D6,A2                            ; $100DFA
        MOVE.W  -(A1),$34(A0,D4.L)              ; $100DFC
        MOVE.L  D6,#$8538D0A7                   ; $100E00
        MOVE.B  (A4),D5                         ; $100E06
        ASL.W  #1,D2                            ; $100E08
        SUB.W  $538D(A0),D6                     ; $100E0A
        EORI.W  #$A14E,$29(A1,D3.W)             ; $100E0E
        AND.L  D5,D3                            ; $100E14
        MOVE.W  (A0),(A4)+                      ; $100E16
        MOVE.L  (A2)+,-(A3)                     ; $100E18
        MOVE.B  -(A3),(A2)+                     ; $100E1A
        CLR    (A4)+                            ; $100E1C
        BVC.S  loc_100E77                       ; $100E1E
        OR.W   D6,A2                            ; $100E20
        MOVE.W  $5E35(A1),-$3A(A0,D2.L)         ; $100E22
        MOVE.L  $D4AF.W,$1A95(A2)               ; $100E28
        ROXL.W  #1,D2                           ; $100E2E
        CMP.W  $578D(A2),D6                     ; $100E30
        TST    $5E(A1,A2.L)                     ; $100E34
        MOVE.W  -$395B(A3),-(A2)                ; $100E38
        MOVEQ   #-$2C,D4                        ; $100E3C
        MOVE.L  (A2)+,-(A7)                     ; $100E3E
        SUBA.L  -(A3),A3                        ; $100E40
        ADDQ.L  #1,#$6E578DCA                   ; $100E42
        DC.W    $F1B9,$5E37,$2BC6,$E578; $100E48 MOVE.W  $5E372BC6,$78(A0,A6.W)
        ADD.L  $1B95(A7),D6                     ; $100E50
        ROXL.W  D1,D2                           ; $100E54
        CMP.W  $578D(A6),D6                     ; $100E56
        MULU    $5E(A1,A3.L),D5                 ; $100E5A
        MOVE.W  -$391B(A3),-(A3)                ; $100E5E
        MOVEQ   #-$24,D4                        ; $100E62
        EOR.B  D7,(A3)+                         ; $100E64
        SUBA.L  -(A3),A2                        ; $100E66
        SUB.L  #$72578E4A,D1                    ; $100E68
        MOVE.W  A1,$5E39.W                      ; $100E6E
        DC.W    $2BC7               ; $100E72 MOVE.L  D7,<EA:3D>
        MOVE.L  $E4AF.W,$1C95(A2)               ; $100E74
        ROXL.L  #1,D2                           ; $100E7A
        CMP.W  -$72(A2,D5.W),D6                 ; $100E7C
        TST    $5E(A1,A4.L)                     ; $100E80
        MOVE.W  -$38DB(A3),-(A4)                ; $100E84
        MOVE.W  -(A4),(A4)+                     ; $100E88
        MOVE.L  (A5)+,-(A7)                     ; $100E8A
        SUBA.L  -(A3),A2                        ; $100E8C
        CMP.L  #$76578ECA,D1                    ; $100E8E
        MOVE.W  (A1)+,$5E3B.W                   ; $100E94
        DC.W    $2BC7               ; $100E98 MOVE.L  D7,<EA:3D>
        BCS.S  loc_100F14                       ; $100E9A
        LSR.L  D6,D7                            ; $100E9C
        MOVE.B  (A5),-$4E(A6,A6.W)              ; $100E9E
        CMP.W  -$72(A6,D5.W),D6                 ; $100EA2
        MULU    $5E(A1,A5.L),D5                 ; $100EA6
        MOVE.W  -$389B(A7),-(A5)                ; $100EAA
        MOVEQ   #-$0C,D4                        ; $100EAE
        MOVE.L  (A6)+,-(A7)                     ; $100EB0
        SUBA.L  -(A3),A2                        ; $100EB2
        ADD.L  #$7A578F4A,D1                    ; $100EB4
        MOVE.W  $5E3D(A1),$2BC7.W               ; $100EBA
        MOVE.L  $F4AF.W,$1E95(A2)               ; $100EC0
        LSL.W  (A2)                             ; $100EC6
        CMP.W  $578F(PC),D6                     ; $100EC8
        TST    $7E(A1,A6.L)                     ; $100ECC
        MOVE.W  -$37DB(A3),-(A6)                ; $100ED0
        MOVE.W  #$BF1F,(A4)+                    ; $100ED4
        SUBA.L  -(A3),A3                        ; $100ED8
        MOVE.W  #$7E5F,(A1)+                    ; $100EDA
        DIVS    A3,D7                           ; $100EDE
        DC.W    $F1F9,$7E3F,$2FC8,$65F9; $100EE0 MOVE.W  $7E3F2FC8,$65F9.W
        DC.W    $0CBF,$2197,$E432   ; $100EE8 CMPI.L  #$2197E432,<EA:3F>
        MOVE.W  D6,(A6)                         ; $100EEE
        SUBQ.L  #7,(A0)                         ; $100EF0
        MULS    $7E(A2,D1.L),D5                 ; $100EF2
        DC.W    $432F               ; $100EF6 DC.W    $432F
        MULU    -(A5),D4                        ; $100EF8
        MOVE.W  (A4)+,-(A4)                     ; $100EFA
        EOR.B  D7,-(A3)                         ; $100EFC
        SUBA.L  -(A4),A3                        ; $100EFE
        MOVEQ   #-$04,D1                        ; $100F00
        OR.W   (A7)+,D7                         ; $100F02
        SUBA.L  A3,A0                           ; $100F04
        MOVE.W  $7E472FC9,D1                    ; $100F06
        BCS.S  loc_100F07                       ; $100F0C
        DC.W    $2CBF               ; $100F0E MOVE.L  <EA:3F>,(A6)
        MOVE.L  (A7),-$4E(A2,A6.W)              ; $100F10
loc_100F14:
        MOVE.W  (A6),(A6)                       ; $100F14
        SUBQ.L  #7,(A2)                         ; $100F16
        MULS    $7E(A2,D5.L),D5                 ; $100F18
        DC.W    $4B2F               ; $100F1C DC.W    $4B2F
        MULS    -(A5),D4                        ; $100F1E
        MOVE.W  #$BF27,-(A4)                    ; $100F20
        SUBA.L  -(A4),A3                        ; $100F24
        MOVE.W  #$9E5F,(A1)+                    ; $100F26
        SUBA.L  A3,A1                           ; $100F2A
        MOVEA.W $7E4F2FCA,A1                    ; $100F2C
        BCS.S  loc_100F2D                       ; $100F32
        DC.W    $4CBF,$2997         ; $100F34 MOVEM.W D0/D1/D2/D4/D7/A0/A3/A5,<EA:3F>
        ROXL.B  D2,D2                           ; $100F38
        MOVE.W  -(A6),(A6)                      ; $100F3A
        SUBQ.L  #7,(A4)                         ; $100F3C
        MULS    $7E(A2,A1.L),D5                 ; $100F3E
        SUBQ.B  #1,-$381B(A7)                   ; $100F42
        MOVE.W  #$BF1F,(A4)+                    ; $100F46
        SUBA.L  -(A3),A3                        ; $100F4A
        MOVE.W  #$7E5F,(A1)+                    ; $100F4C
        DIVS    A3,D7                           ; $100F50
        DC.W    $F1F9,$7E3F,$2FC8,$65F9; $100F52 MOVE.W  $7E3F2FC8,$65F9.W
        DC.W    $0CBF,$2197,$E432   ; $100F5A CMPI.L  #$2197E432,<EA:3F>
        MOVE.W  D6,(A6)                         ; $100F60
        SUBQ.L  #7,(A0)                         ; $100F62
        MULS    $7E(A2,D1.L),D5                 ; $100F64
        DC.W    $432F               ; $100F68 DC.W    $432F
        MULU    -(A5),D4                        ; $100F6A
        MOVE.W  (A4)+,-(A4)                     ; $100F6C
        EOR.B  D7,-(A3)                         ; $100F6E
        SUBA.L  -(A4),A3                        ; $100F70
        MOVEQ   #-$04,D1                        ; $100F72
        OR.W   (A7)+,D7                         ; $100F74
        SUBA.L  A3,A0                           ; $100F76
        MOVE.W  $7E472FC9,D1                    ; $100F78
        BCS.S  loc_100F79                       ; $100F7E
        DC.W    $2CBF               ; $100F80 MOVE.L  <EA:3F>,(A6)
        MOVE.L  (A7),-$4E(A2,A6.W)              ; $100F82
        MOVE.W  (A6),(A6)                       ; $100F86
        SUBQ.L  #7,(A2)                         ; $100F88
        MULS    $7E(A2,D5.L),D5                 ; $100F8A
        DC.W    $4B2F               ; $100F8E DC.W    $4B2F
        MULS    -(A5),D4                        ; $100F90
        MOVE.W  #$BF27,-(A4)                    ; $100F92
        SUBA.L  -(A4),A3                        ; $100F96
        MOVE.W  #$9E5F,(A1)+                    ; $100F98
        SUBA.L  A3,A1                           ; $100F9C
        MOVEA.W $7E4F2FCA,A1                    ; $100F9E
        BCS.S  loc_100F9F                       ; $100FA4
        DC.W    $4CBF,$2997         ; $100FA6 MOVEM.W D0/D1/D2/D4/D7/A0/A3/A5,<EA:3F>
        ROXL.B  D2,D2                           ; $100FAA
        MOVE.W  -(A6),(A6)                      ; $100FAC
        SUBQ.L  #7,(A4)                         ; $100FAE
        MULS    $7E(A2,A1.L),D5                 ; $100FB0
        SUBQ.B  #1,-$381B(A7)                   ; $100FB4
        MOVE.W  #$BF1F,(A4)+                    ; $100FB8
        SUBA.L  -(A3),A3                        ; $100FBC
        MOVE.W  #$7E5F,(A1)+                    ; $100FBE
        DIVS    A3,D7                           ; $100FC2
        DC.W    $F1F9,$7E3F,$2FC8,$65F9; $100FC4 MOVE.W  $7E3F2FC8,$65F9.W
        DC.W    $0CBF,$2197,$E432   ; $100FCC CMPI.L  #$2197E432,<EA:3F>
        MOVE.W  D6,(A6)                         ; $100FD2
        SUBQ.L  #7,(A0)                         ; $100FD4
        MULS    $7E(A2,D1.L),D5                 ; $100FD6
        DC.W    $432F               ; $100FDA DC.W    $432F
        MULU    -(A5),D4                        ; $100FDC
        MOVE.W  (A4)+,-(A4)                     ; $100FDE
        EOR.B  D7,-(A3)                         ; $100FE0
        SUBA.L  -(A4),A3                        ; $100FE2
        MOVEQ   #-$04,D1                        ; $100FE4
        OR.W   (A7)+,D7                         ; $100FE6
        SUBA.L  A3,A0                           ; $100FE8
        MOVE.W  $7E472FC9,D1                    ; $100FEA
        BCS.S  loc_100FEB                       ; $100FF0
        DC.W    $2CBF               ; $100FF2 MOVE.L  <EA:3F>,(A6)
        MOVE.L  (A7),-$4E(A2,A6.W)              ; $100FF4
        MOVE.W  (A6),(A6)                       ; $100FF8
        SUBQ.L  #7,(A2)                         ; $100FFA
        MULS    $7E(A2,D5.L),D5                 ; $100FFC
        DC.W    $4B2F               ; $101000 DC.W    $4B2F
        MULS    -(A5),D4                        ; $101002
        MOVE.W  #$BF27,-(A4)                    ; $101004
        SUBA.L  -(A4),A3                        ; $101008
        MOVE.W  #$9E5F,(A1)+                    ; $10100A
        SUBA.L  A3,A1                           ; $10100E
        MOVEA.W $7E4F2FCA,A1                    ; $101010
        BCS.S  loc_101011                       ; $101016
        DC.W    $4CBF,$2997         ; $101018 MOVEM.W D0/D1/D2/D4/D7/A0/A3/A5,<EA:3F>
        ROXL.B  D2,D2                           ; $10101C
        MOVE.W  -(A6),(A6)                      ; $10101E
        SUBQ.L  #7,(A4)                         ; $101020
        MULS    $7E(A2,A1.L),D5                 ; $101022
        DC.W    $533F               ; $101026 SUBQ.B  #1,<EA:3F>
        OR.B   D0,D0                            ; $101028
        DC.W    $090F               ; $10102A BTST    D4,A7
        DC.W    $0000,$00DD         ; $10102C ORI.B  #$00DD,D0
        ANDI.W  #$0027,$8002.W                  ; $101030
        MOVEQ   #$00,D4                         ; $101036
        MOVE.L  D0,-(A2)                        ; $101038
        ANDI.L  #$3CA88022,(A0)                 ; $10103A
        MOVEQ   #$00,D4                         ; $101040
        MOVE.L  D0,$78(A3,D0.W)                 ; $101042
        DC.W    $0027,$8002         ; $101046 ORI.B  #$8002,-(A7)
        MOVEQ   #$00,D4                         ; $10104A
        MOVE.L  D0,$78(A3,D0.W)                 ; $10104C
        DC.W    $0024,$8003         ; $101050 ORI.B  #$8003,-(A4)
        OR.B   #$AC03,D0                        ; $101054
        ADD.W  $0027.W,D3                       ; $101058
        OR.B   D2,D0                            ; $10105C
        MOVEQ   #$00,D4                         ; $10105E
        MOVE.L  D0,$00(A3,D0.W)                 ; $101060
        DC.W    $0002,$9E00         ; $101064 ORI.B  #$9E00,D2
        BSET    D4,-(A0)                        ; $101068
        ORI.L  #$000E4001,D6                    ; $10106A
        BSET    D3,$24(A0,D3.L)                 ; $101070
        OR.B   D3,D0                            ; $101074
        OR.B   #$AA83,D0                        ; $101076
        MOVE.W  (A0)+,-$40(A7,D0.L)             ; $10107A
        CMPI.B  #$7082,D0                       ; $10107E
        AND.B  D7,D0                            ; $101082
        DC.W    $04F0               ; $101084 DC.W    $04F0
        ORI.W  #$0004,A7                        ; $101086
        MOVE.W  D0,D0                           ; $10108A
        BTST    D5,#$0013                       ; $10108C
        AND.B  D1,D0                            ; $101090
        AND.B  D0,D0                            ; $101092
        MOVE.B  D0,$0918(A2)                    ; $101094
        DC.W    $0014,$420D         ; $101098 ORI.B  #$420D,(A4)
        AND.B  -(A0),D0                         ; $10109C
        MOVE.B  D2,-(A2)                        ; $10109E
        MOVE.B  D4,$0194(A0)                    ; $1010A0
        OR.B   (A3)+,D1                         ; $1010A4
        CMPI.B  #$1CC0,D0                       ; $1010A6
        MOVE.L  A7,D4                           ; $1010AA
        ROR.W  D0,D6                            ; $1010AC
        BSET    D1,$00(A6,D5.W)                 ; $1010AE
        MOVE.W  D0,D5                           ; $1010B2
        ADDQ.B  #8,(A7)+                        ; $1010B4
        AND.W  D0,$0000.W                       ; $1010B6
        ADDQ.W  #7,-(A7)                        ; $1010BA
        OR.B   D2,D0                            ; $1010BC
        MOVEQ   #$00,D4                         ; $1010BE
        MOVE.L  D0,(A1)                         ; $1010C0
        ORI.W  #$E000,-$6A00(A1)                ; $1010C2
        DC.W    $0028,$800B,$9000   ; $1010C8 ORI.B  #$800B,-$7000(A0)
        DC.W    $0220,$111A         ; $1010CE ANDI.B  #$111A,-(A0)
        OR.B   A4,D0                            ; $1010D2
        OR.B   D0,D6                            ; $1010D4
        BSET    D5,-(A1)                        ; $1010D6
        MOVE.B  -(A2),(A1)+                     ; $1010D8
        MOVE.B  -(A0),D1                        ; $1010DA
        MOVE.B  (A3),$0034.W                    ; $1010DC
        OR.B   D0,D0                            ; $1010E0
        MOVE.W  A1,-(A1)                        ; $1010E2
        MOVE.B  A0,D0                           ; $1010E4
        AND.B  A4,D0                            ; $1010E6
        BCHG    D0,(A2)+                        ; $1010E8
        DC.W    $417A               ; $1010EA DC.W    $417A
        SUB.B  D0,D7                            ; $1010EC
        BSET    D4,-(A0)                        ; $1010EE
        DC.W    $00E6               ; $1010F0 DC.W    $00E6
        DC.W    $0004,$0920         ; $1010F2 ORI.B  #$0920,D4
        DC.W    $4D02               ; $1010F6 DC.W    $4D02
        SCS     D0                              ; $1010F8
        DC.W    $29F1,$0388,$1240,$9A07; $1010FA MOVE.L  -$78(A1,D0.W),#$12409A07
        ADDQ.B  #8,-(A4)                        ; $101102
        OR.B   D0,-(A4)                         ; $101104
        BTST    D7,-(A0)                        ; $101106
        MOVE.W  D2,-(A6)                        ; $101108
        DC.W    $4812               ; $10110A DC.W    $4812
        NEGX.L (A2)+                            ; $10110C
        SUBI.L  #$3B0D0254,(A0)                 ; $10110E
        DC.W    $503D               ; $101114 ADDQ.B  #8,<EA:3D>
        MOVE.B  D2,-(A6)                        ; $101116
        SGE     D0                              ; $101118
        MOVE.L  -(A0),D4                        ; $10111A
        ROXR.B  D0,D7                           ; $10111C
        SUBI.L  #$B8052884,A6                   ; $10111E
        SUB.B  A0,D1                            ; $101124
        DC.W    $0029,$049B,$8040   ; $101126 ORI.B  #$049B,-$7FC0(A1)
        MOVE.L  D4,-(A4)                        ; $10112C
        MOVE.L  (A0),(A3)                       ; $10112E
        MOVE.B  $04B2(A3),(A2)                  ; $101130
        OR.W   D2,D4                            ; $101134
        MOVE.L  D4,-(A4)                        ; $101136
        AND.L  D7,(A0)                          ; $101138
        DC.W    $4340               ; $10113A DC.W    $4340
        MOVE.B  D1,D7                           ; $10113C
        BCLR    #10,-(A0)                       ; $10113E
        MOVE.B  (A6)+,$24(PC,D0.W)              ; $101142
        MOVE.L  (A0)+,D2                        ; $101146
        MOVE.W  A0,(A7)                         ; $101148
        MOVEA.B D0,A1                           ; $10114A
        ASR.B  #5,D4                            ; $10114C
        SUB.B  #$81F8,D0                        ; $10114E
        OR.B   (A2),D4                          ; $101152
        MOVE.W  D1,(A3)                         ; $101154
        MOVE.W  A6,D2                           ; $101156
        MOVEA.L A1,A0                           ; $101158
        ANDI.W  #$1E40,A0                       ; $10115A
        MOVE.W  D4,D5                           ; $10115E
        SUB.B  -(A4),D0                         ; $101160
        OR.B   D0,$20(A4,D0.L)                  ; $101162
        MOVE.W  D2,-(A2)                        ; $101166
        ADDQ.L  #2,(A3)                         ; $101168
        BSET    D6,(A5)+                        ; $10116A
        ANDI.W  #$1E40,A0                       ; $10116C
        MOVE.W  D4,D5                           ; $101170
        SUB.B  -(A4),D0                         ; $101172
        DIVS    -(A4),D0                        ; $101174
        BCLR    D7,-(A0)                        ; $101176
        MOVEQ   #-$6E,D3                        ; $101178
        BTST    #14,-$75F6(A3)                  ; $10117A
        MOVE.W  -(A0),D4                        ; $101180
        OR.B   (A2),D3                          ; $101182
        BTST    D5,$20B6(A1)                    ; $101184
        OR.B   A0,D5                            ; $101188
        MOVE.W  -(A0),-(A4)                     ; $10118A
        EOR.B  D0,D6                            ; $10118C
        BTST    #2,$48(A1,A4.L)                 ; $10118E
        MOVE.L  D1,-$6DF5(A6)                   ; $101194
        ASL.B  D5,D0                            ; $101198
        AND.L  D7,(A1)+                         ; $10119A
        BSET    D4,D0                           ; $10119C
        MOVEQ   #$13,D2                         ; $10119E
        BRA.S  loc_10113D                       ; $1011A0
        ADD.B  D3,D1                            ; $1011A2
        MOVE.B  (A0),-(A6)                      ; $1011A4
        SUB.W  $0040.W,D6                       ; $1011A6
        DC.W    $4942               ; $1011AA DC.W    $4942
        MOVE.L  (A1),D2                         ; $1011AC
        MOVE.W  (A5)+,(A0)                      ; $1011AE
        DC.W    $04EC               ; $1011B0 DC.W    $04EC
        BCLR    D6,-(A1)                        ; $1011B2
        MOVE.W  A1,D6                           ; $1011B4
        ASL.B  D6,D0                            ; $1011B6
        MOVE.W  -$10(A3,D0.L),-$80(PC,D1.L)     ; $1011B8
        MOVEQ   #$03,D6                         ; $1011BE
        MOVEA.W D1,A5                           ; $1011C0
        MOVE.W  -(A2),$7A(A7,D1.W)              ; $1011C2
        DC.W    $4142               ; $1011C6 DC.W    $4142
        MOVE.L  D1,D1                           ; $1011C8
        SUB.B  -(A1),D5                         ; $1011CA
        DC.W    $45A4               ; $1011CC DC.W    $45A4
        MOVE.B  $2189(PC),$FC34.W               ; $1011CE
        DIVU    D5,D0                           ; $1011D4
        OR.W   $3181(A4),D2                     ; $1011D6
        OR.B   D6,A2                            ; $1011DA
        MOVE.L  (A2),(A0)+                      ; $1011DC
        DC.W    $04F2               ; $1011DE DC.W    $04F2
        MOVEA.B (A0),A2                         ; $1011E0
        MOVE.L  -(A6),$05(A4,D3.L)              ; $1011E2
        OR.B   $416A(A4),D4                     ; $1011E6
        DC.W    $0CBA,$A0BD,$0408,$3041; $1011EA CMPI.L  #$A0BD0408,$3041(PC)
        OR.B   A3,D5                            ; $1011F2
        MOVEA.B D3,A0                           ; $1011F4
        BTST    D4,D5                           ; $1011F6
        SUB.L  (A0),D2                          ; $1011F8
        SUBQ.W  #5,D5                           ; $1011FA
        SUBI.B  #$9058,(A4)+                    ; $1011FC
        OR.B   D1,D4                            ; $101200
        MOVE.B  (A2),(A4)+                      ; $101202
        DC.W    $4C7D               ; $101204 DC.W    $4C7D
        MOVE.B  (A6),D2                         ; $101206
        MOVE.W  D1,-$6DF5(A0)                   ; $101208
        ASL.L  D4,D0                            ; $10120C
        CMP.L  (A2),D1                          ; $10120E
        DC.W    $0EE8               ; $101210 DC.W    $0EE8
        DIVU    $09(PC,A1.W),D0                 ; $101212
        AND.L  D0,D0                            ; $101216
        CLR.W  (A2)+                            ; $101218
        NEGX.W D1                               ; $10121A
        ASR.L  #8,D3                            ; $10121C
        MULU    $44A2(A0),D5                    ; $10121E
        DC.W    $83BE               ; $101222 OR.L   D1,<EA:3E>
        MOVEA.L D4,A4                           ; $101224
        CLR.W  -(A4)                            ; $101226
        MOVE.L  -(A6),D2                        ; $101228
        ADD.W  D1,D2                            ; $10122A
        MOVE.W  (A2),-(A3)                      ; $10122C
        MOVE.B  D1,-$50(A1,D0.W)                ; $10122E
        MOVE.B  -$4C(PC,D0.L),(A2)              ; $101232
        DIVU    D0,D2                           ; $101236
        MOVE.W  D1,D7                           ; $101238
        MOVE.W  A1,-(A4)                        ; $10123A
        AND.L  D0,D0                            ; $10123C
        CLR.W  (A2)+                            ; $10123E
        NEGX.W D1                               ; $101240
        MOVE.W  (A3),D6                         ; $101242
        SUB.B  D1,-(A0)                         ; $101244
        BTST    D4,D0                           ; $101246
        DC.W    $4342               ; $101248 DC.W    $4342
        MOVE.B  D0,-(A4)                        ; $10124A
        MOVEQ   #$03,D0                         ; $10124C
        AND.L  A2,D3                            ; $10124E
        MOVEA.B $02(A0,A2.W),A2                 ; $101250
        MOVE.L  (A1),D2                         ; $101254
        NEGX.B $0458(A0)                        ; $101256
        ADDQ.W  #1,$10600B80                    ; $10125A
        SUBQ.L  #6,-(A6)                        ; $101260
        MOVE.B  $0089(A6),(A2)                  ; $101262
        MOVE.L  (A4),D3                         ; $101266
        ASR.W  #7,D4                            ; $101268
        NEGX.B D1                               ; $10126A
        MOVEA.L (A4),A4                         ; $10126C
        MOVE.L  D6,D5                           ; $10126E
        DC.W    $4B89               ; $101270 DC.W    $4B89
        ADDI.B  #$2F48,D3                       ; $101272
        DC.W    $32FD               ; $101276 MOVE.W  <EA:3D>,(A1)+
        DC.W    $02D4               ; $101278 DC.W    $02D4
        MOVE.W  -$7B(A1,A2.W),$142D(A2)         ; $10127A
        MOVE.W  (A3),(A2)                       ; $101280
        MOVE.W  (A5),$0788(PC)                  ; $101282
        NEG.W  D2                               ; $101286
        BHI.S  loc_101298                       ; $101288
        ADD.L  A0,D0                            ; $10128A
        DIVS    A2,D1                           ; $10128C
        ASR.W  #4,D4                            ; $10128E
        MOVE.L  D3,(A1)                         ; $101290
        CMP.W  A0,D7                            ; $101292
        NEG.W  D2                               ; $101294
        BHI.S  loc_1012AB                       ; $101296
loc_101298:
        BVS.S  loc_1012C0                       ; $101298
        MOVE.W  $6710(PC),-$64(A3,D7.L)         ; $10129A
        OR.B   -(A6),D2                         ; $1012A0
        MOVE.L  -(A1),-(A0)                     ; $1012A2
        MOVE.W  -$35BE(A1),-(A4)                ; $1012A4
        SUBQ.B  #6,-(A4)                        ; $1012A8
        MOVE.L  (A1),(A6)+                      ; $1012AA
        DC.W    $02E7               ; $1012AC DC.W    $02E7
        MOVEQ   #$07,D0                         ; $1012AE
        ORI.L  #$0BC05F11,(A4)                  ; $1012B0
        MOVE.L  (A0),-$4C(A4,D1.W)              ; $1012B6
        OR.L   D2,$6860(PC)                     ; $1012BA
        ASR.L  #3,D5                            ; $1012BE
loc_1012C0:
        MOVE.L  -$6B(A2,D2.W),D2                ; $1012C0
        BTST    D5,-$33(A5,D5.W)                ; $1012C4
        NEG.B  A5                               ; $1012C8
        SUBA.W  D0,A6                           ; $1012CA
        MOVE.B  D6,D4                           ; $1012CC
        ASR.B  #8,D7                            ; $1012CE
        ORI.L  #$981BFF00,(A6)                  ; $1012D0
        MOVE.W  A6,D4                           ; $1012D6
        BRA.S  loc_10134E                       ; $1012D8
        MOVE.B  $A140.W,D2                      ; $1012DA
        CMP.B  D5,D4                            ; $1012DE
        ADD.B  D7,D0                            ; $1012E0
        ORI.L  #$0BC05F11,(A4)                  ; $1012E2
        MOVE.L  (A0),$72(A4,D0.W)               ; $1012E8
        DC.W    $153E               ; $1012EC MOVE.B  <EA:3E>,-(A2)
        OR.B   $2130(A2),D0                     ; $1012EE
        SUBQ.B  #2,D0                           ; $1012F2
        MOVE.W  D1,D1                           ; $1012F4
        MOVE.L  D1,(A5)                         ; $1012F6
        SCS     -(A0)                           ; $1012F8
        SUBI.B  #$015A,(A3)+                    ; $1012FA
        ROXR.B  #1,D5                           ; $1012FE
        OR.B   D0,A4                            ; $101300
        ADD.B  A3,D1                            ; $101302
        MOVE.B  (A2),-(A6)                      ; $101304
        MOVE.B  $30(A3,D0.L),$1743(A1)          ; $101306
        NEGX.B (A2)+                            ; $10130C
        MOVEA.B A1,A5                           ; $10130E
        MOVE.L  $1A5E(A0),(A1)                  ; $101310
        LSL.W  D1,D5                            ; $101314
        MOVE.B  $48(A0,A5.W),(A5)               ; $101316
        OR.B   (A2)+,D0                         ; $10131A
        MOVE.L  (A5),(A2)+                      ; $10131C
        MOVE.L  A1,$74(A0,D0.L)                 ; $10131E
        ADD.W  D1,(A1)+                         ; $101322
        LSL.B  #8,D4                            ; $101324
        MOVE.L  $1A(A0,D4.W),-$30(A4,D1.W)      ; $101326
        AND.L  D6,D2                            ; $10132C
        MOVE.W  $2191(A5),D2                    ; $10132E
        DC.W    $0CB4,$90B3,$C535,$8859; $101332 CMPI.L  #$90B3C535,$59(A4,A0.L)
        MOVE.L  (A3)+,(A2)                      ; $10133A
        MOVE.B  $62EA(A0),D5                    ; $10133C
        OR.L   D2,$26(A4,A5.W)                  ; $101340
        EOR.B  D2,$69CC432D                     ; $101344
        MOVE.L  -$2CFD(PC),D2                   ; $10134A
loc_10134E:
        MULS    -(A3),D3                        ; $10134E
        MOVE.B  (A0),-(A1)                      ; $101350
        SUB.B  A7,D4                            ; $101352
        OR.B   -(A6),D3                         ; $101354
        LEA     $1D90(A2),A1                    ; $101356
        MOVE.W  D7,(A6)                         ; $10135A
        MOVE.W  -$27(PC,D2.W),D2                ; $10135C
        BSET    D7,$7E44(A0)                    ; $101360
        DC.W    $0220,$44E9         ; $101364 ANDI.B  #$44E9,-(A0)
        NEG.B  (A0)                             ; $101368
        ADDQ.B  #6,D4                           ; $10136A
        EOR.W  D0,(A4)                          ; $10136C
        MOVE.B  (A4),(A0)                       ; $10136E
        NEGX   $11(A5,A6.W)                     ; $101370
        NEGX.B $0458(A0)                        ; $101374
        MOVE.L  D0,-(A1)                        ; $101378
        MOVE.W  A0,D2                           ; $10137A
        ADD.W  D7,D0                            ; $10137C
        BCLR    D2,(A4)+                        ; $10137E
        MOVE.L  (A4),-(A6)                      ; $101380
        MULU    -$3C(A1,A6.L),D0                ; $101382
        AND.B  -(A6),D2                         ; $101386
        BSET    D1,-(A1)                        ; $101388
        OR.L   D4,D2                            ; $10138A
        MOVE.L  (A6),D3                         ; $10138C
        SUB.B  -(A1),D0                         ; $10138E
        OR.B   (A4),D5                          ; $101390
        MOVE.L  D0,$2801(A6)                    ; $101392
        DC.W    $4D30               ; $101396 DC.W    $4D30
        CMPA.L  (A1),A2                         ; $101398
        DC.W    $02F5               ; $10139A DC.W    $02F5
        ADDQ.L  #8,$04(A7,A7.L)                 ; $10139C
        PEA     (A5)+                           ; $1013A0
        CLR    $16E1(A4)                        ; $1013A2
        MOVE.L  D1,(A4)                         ; $1013A6
        MOVEQ   #$0B,D0                         ; $1013A8
        MOVE.L  -$47(A7,D2.W),$0600(A0)         ; $1013AA
        CMP.B  (A5),D4                          ; $1013B0
        ASR.W  #5,D1                            ; $1013B2
        CMP.L  -(A2),D2                         ; $1013B4
        DC.W    $9B7E               ; $1013B6 SUB.W  D5,<EA:3E>
        MOVE.L  A6,$0C95(A0)                    ; $1013B8
        MOVE.W  (A4)+,(A0)+                     ; $1013BC
        ROL.B  #8,D3                            ; $1013BE
        BEQ.S  loc_101404                       ; $1013C0
        MOVE.L  D6,D0                           ; $1013C2
        MOVE.W  -$41(A7,A4.L),-(A2)             ; $1013C4
        DC.W    $43FD               ; $1013C8 LEA     <EA:3D>,A1
        MOVEQ   #-$20,D2                        ; $1013CA
        DC.W    $4143               ; $1013CC DC.W    $4143
        CMP.B  (A4),D3                          ; $1013CE
        DC.W    $3FF4,$4402         ; $1013D0 MOVE.W  $02(A4,D4.W),<EA:3F>
        MOVE.B  (A0),-$1379(A6)                 ; $1013D4
        BCC.S  loc_101419                       ; $1013D8
        SUBQ.W  #1,A6                           ; $1013DA
        BTST    D2,-(A4)                        ; $1013DC
        LSR.W  (A4)                             ; $1013DE
        DC.W    $4E05               ; $1013E0 DC.W    $4E05
        MOVEA.W D7,A4                           ; $1013E2
        ADD.L  D7,D4                            ; $1013E4
        MOVE.W  $57D4(A0),-(A6)                 ; $1013E6
        DIVU    A5,D2                           ; $1013EA
        MOVEA.W D7,A4                           ; $1013EC
        ADD.L  D7,D4                            ; $1013EE
        MOVE.W  $57D4(A0),-(A6)                 ; $1013F0
        DIVU    A5,D2                           ; $1013F4
        MOVEA.W D7,A4                           ; $1013F6
        ADD.L  D7,D4                            ; $1013F8
        MOVE.W  $57D4(A0),-(A6)                 ; $1013FA
        DIVU    A5,D2                           ; $1013FE
        MOVEA.B D7,A4                           ; $101400
        ADD.L  D4,D1                            ; $101402
loc_101404:
        SUB.B  D6,$4E51(A0)                     ; $101404
        OR.L   D2,(A7)                          ; $101408
        MOVEA.L D7,A4                           ; $10140A
        MULU    (A2),D1                         ; $10140C
        MOVE.B  $6B(A4,A6.W),D1                 ; $10140E
        AND.B  (A6),D1                          ; $101412
        MOVE.W  -(A1),-(A2)                     ; $101414
        MOVE.W  D2,$1654E17D                    ; $101416
        AND.B  (A6),D1                          ; $10141C
        SUBQ.W  #3,-(A1)                        ; $10141E
        OR.W   D2,(A2)                          ; $101420
        MOVE.B  $65(A4,D6.W),-(A3)              ; $101422
        AND.B  (A1),D5                          ; $101426
        MOVE.W  -$73(A4,A0.W),(A0)              ; $101428
        MOVEA.W (A2)+,A4                        ; $10142C
        MOVE.W  D5,(A0)                         ; $10142E
        SUB.W  D6,A0                            ; $101430
        SGE     -$6B(A0,A0.W)                   ; $101432
        MOVEA.W (A7)+,A4                        ; $101436
        MOVEQ   #-$7B,D0                        ; $101438
        SUBA.L  (A0)+,A2                        ; $10143A
        BSR.S  loc_101492                       ; $10143C
loc_10143E:
        DIVS    A5,D2                           ; $10143E
        MOVEA.B (A1)+,A4                        ; $101440
        MOVEQ   #-$7C,D1                        ; $101442
        MOVEQ   #$2D,D6                         ; $101444
        MOVE.L  -(A3),-(A0)                     ; $101446
loc_101448:
        DC.W    $4E16               ; $101448 DC.W    $4E16
        CMP.B  -(A1),D6                         ; $10144A
        BEQ.S  loc_1014A0                       ; $10144C
        MOVE.B  #$2165,-(A3)                    ; $10144E
loc_101452:
        DC.W    $4E17               ; $101452 DC.W    $4E17
        ADD.B  -(A1),D6                         ; $101454
        BCS.S  loc_1014CE                       ; $101456
        MOVEA.B (A5),A4                         ; $101458
        MOVE.L  $16(A3,D4.W),$5D61(A0)          ; $10145A
        BCS.S  loc_10146D                       ; $101460
        MOVEQ   #$5C,D4                         ; $101462
        CLR    -$50(A2,D1.W)                    ; $101464
        CMP.L  -(A6),D1                         ; $101468
        DC.W    $0D0A               ; $10146A BTST    D6,A2
        BRA.S  loc_10143E                       ; $10146C
        MOVE.L  A5,D3                           ; $10146E
loc_101470:
        EORI.W  #$D0A6,-(A0)                    ; $101470
        DC.W    $0D0A               ; $101474 BTST    D6,A2
        BRA.S  loc_101448                       ; $101476
        MOVE.L  A5,D3                           ; $101478
loc_10147A:
        EORI.W  #$D0A6,-(A0)                    ; $10147A
        DC.W    $0D0A               ; $10147E BTST    D6,A2
        BRA.S  loc_101452                       ; $101480
        MOVE.L  A5,D3                           ; $101482
loc_101484:
        EORI.W  #$D0A6,-(A0)                    ; $101484
        DC.W    $0D0A               ; $101488 BTST    D6,A2
        BRA.S  loc_10145C                       ; $10148A
        MOVE.L  A5,D3                           ; $10148C
        EORI.W  #$D0A6,-(A0)                    ; $10148E
loc_101492:
        DC.W    $0D0A               ; $101492 BTST    D6,A2
        BRA.S  loc_101466                       ; $101494
        MOVE.L  A5,D3                           ; $101496
        EORI.W  #$D0A6,-(A0)                    ; $101498
loc_10149C:
        DC.W    $0D0A               ; $10149C BTST    D6,A2
        BRA.S  loc_101470                       ; $10149E
loc_1014A0:
        MOVE.L  A5,D3                           ; $1014A0
        EORI.W  #$D0A6,-(A0)                    ; $1014A2
loc_1014A6:
        DC.W    $0D0A               ; $1014A6 BTST    D6,A2
        BRA.S  loc_10147A                       ; $1014A8
        MOVE.L  A5,D3                           ; $1014AA
        EORI.W  #$D0A6,-(A0)                    ; $1014AC
loc_1014B0:
        DC.W    $0D0A               ; $1014B0 BTST    D6,A2
        BRA.S  loc_101484                       ; $1014B2
        MOVE.L  A5,D3                           ; $1014B4
        DC.W    $0AE0               ; $1014B6 DC.W    $0AE0
        ADD.L  -(A6),D0                         ; $1014B8
loc_1014BA:
        DC.W    $0D4A               ; $1014BA BCHG    D6,A2
        BRA.S  loc_101492                       ; $1014BC
        MOVE.L  A5,D3                           ; $1014BE
        TST.W  -(A0)                            ; $1014C0
        ADD.L  -(A6),D2                         ; $1014C2
loc_1014C4:
        DC.W    $0D4A               ; $1014C4 BCHG    D6,A2
        BRA.S  loc_10149C                       ; $1014C6
        MOVE.L  A5,D3                           ; $1014C8
        TST.W  -(A0)                            ; $1014CA
        ADD.L  -(A6),D2                         ; $1014CC
loc_1014CE:
        DC.W    $0D4A               ; $1014CE BCHG    D6,A2
        BRA.S  loc_1014A6                       ; $1014D0
        MOVE.L  A5,D3                           ; $1014D2
        TST.W  -(A0)                            ; $1014D4
        ADD.L  -(A6),D2                         ; $1014D6
loc_1014D8:
        DC.W    $0D4A               ; $1014D8 BCHG    D6,A2
        BRA.S  loc_1014B0                       ; $1014DA
        MOVE.L  A5,D3                           ; $1014DC
        TST.W  -(A0)                            ; $1014DE
        ADD.L  -(A6),D2                         ; $1014E0
        DC.W    $0D4A               ; $1014E2 BCHG    D6,A2
        BRA.S  loc_1014BA                       ; $1014E4
        MOVE.L  A5,D3                           ; $1014E6
        TST.W  -(A0)                            ; $1014E8
        ADD.L  -(A6),D2                         ; $1014EA
        DC.W    $0D4A               ; $1014EC BCHG    D6,A2
        BRA.S  loc_1014C4                       ; $1014EE
        MOVE.L  A5,D3                           ; $1014F0
        TST.W  -(A0)                            ; $1014F2
        ADD.L  -(A6),D2                         ; $1014F4
        DC.W    $0D4A               ; $1014F6 BCHG    D6,A2
        BRA.S  loc_1014CE                       ; $1014F8
        MOVE.L  A5,D3                           ; $1014FA
        TST.W  -(A0)                            ; $1014FC
        ADD.L  -(A6),D2                         ; $1014FE
        DC.W    $0D4A               ; $101500 BCHG    D6,A2
        BRA.S  loc_1014D8                       ; $101502
        CMP.B  A5,D0                            ; $101504
        DC.W    $4820               ; $101506 DC.W    $4820
        ADDA.L  -(A0),A4                        ; $101508
        BCLR    D6,-$7F28(PC)                   ; $10150A
        OR.B   A5,D1                            ; $10150E
        SUB.B  D0,D7                            ; $101510
        ADD.L  D5,$0D88(A0)                     ; $101512
        MOVE.L  (A1)+,(A0)+                     ; $101516
        LSR.B  #8,D5                            ; $101518
        CMP.L  D0,D5                            ; $10151A
        ADD.L  D2,D4                            ; $10151C
        BCLR    D6,(A6)+                        ; $10151E
        DC.W    $00DB               ; $101520 DC.W    $00DB
        MOVE.L  A5,D4                           ; $101522
        OR.B   -(A0),D4                         ; $101524
        ADDA.L  -(A0),A4                        ; $101526
        BCLR    D6,-$7F28(PC)                   ; $101528
        OR.B   A5,D1                            ; $10152C
        SUB.B  D0,D7                            ; $10152E
        ADD.L  D5,$0D88(A0)                     ; $101530
        MOVE.L  (A1)+,(A0)+                     ; $101534
        LSR.B  #8,D5                            ; $101536
        CMP.L  D0,D5                            ; $101538
        ADD.L  D2,D4                            ; $10153A
        BCLR    D6,(A6)+                        ; $10153C
        DC.W    $00DB               ; $10153E DC.W    $00DB
        MOVE.L  A5,D4                           ; $101540
        OR.B   -(A0),D4                         ; $101542
        ADDA.L  -(A0),A4                        ; $101544
        BCLR    D6,-$7F28(PC)                   ; $101546
        OR.B   A5,D1                            ; $10154A
        SUB.B  D0,D7                            ; $10154C
        ADD.L  D5,$0D88(A0)                     ; $10154E
        MOVE.L  (A1)+,(A0)+                     ; $101552
        LSR.B  #8,D5                            ; $101554
        CMP.L  D0,D5                            ; $101556
        ADD.L  D2,D4                            ; $101558
        BCLR    D6,(A6)+                        ; $10155A
        DC.W    $00DB               ; $10155C DC.W    $00DB
        MOVE.L  A5,D4                           ; $10155E
        OR.B   -(A0),D4                         ; $101560
        ADDA.L  -(A0),A4                        ; $101562
        BCLR    D6,-$7F28(PC)                   ; $101564
        OR.B   A5,D1                            ; $101568
        SUB.B  D0,D7                            ; $10156A
        ADD.L  D5,$0D88(A0)                     ; $10156C
        MOVE.L  (A1)+,(A0)+                     ; $101570
        LSR.B  #8,D5                            ; $101572
        CMP.L  D0,D5                            ; $101574
        ADD.L  D2,D4                            ; $101576
        BCLR    D6,(A6)+                        ; $101578
        DC.W    $00DB               ; $10157A DC.W    $00DB
        NOT.L  A0                               ; $10157C
        MOVE.W  $8378.W,$08(A3,D1.L)            ; $10157E
        MOVE.W  D7,D2                           ; $101584
        BTST    #28,-$30(A7,D0.L)               ; $101586
        MOVE.W  -(A5),-(A0)                     ; $10158C
        AND.B  (A4)+,D0                         ; $10158E
        BVC.S  loc_1015E3                       ; $101590
        DC.W    $06F7               ; $101592 DC.W    $06F7
        MOVEA.B $0381(A7),A0                    ; $101594
        MOVE.B  D0,(A7)                         ; $101598
        ASL.B  #8,D6                            ; $10159A
        ROXR.B  D4,D7                           ; $10159C
        OR.L   D0,$0E24(PC)                     ; $10159E
        CMP.L  D3,D0                            ; $1015A2
        MOVEQ   #-$78,D5                        ; $1015A4
        MOVE.W  $8378.W,$09(A3,D1.L)            ; $1015A6
        ADD.B  D0,D6                            ; $1015AC
        MOVE.W  (A0),-(A3)                      ; $1015AE
        BLE.S  loc_1015B5                       ; $1015B0
        OR.B   D0,(A6)+                         ; $1015B2
        DIVU    -(A1),D0                        ; $1015B4
        DC.W    $06E8               ; $1015B6 DC.W    $06E8
        MOVE.W  D1,$0E(A3,A3.L)                 ; $1015B8
        MOVE.L  $038D.W,(A2)                    ; $1015BC
        DC.W    $0A20,$DEE2         ; $1015C0 EORI.B  #$DEE2,-(A0)
        BSET    D6,-(A0)                        ; $1015C4
        MOVEQ   #$23,D0                         ; $1015C6
        ADD.B  (A4)+,D0                         ; $1015C8
        MOVE.L  (A5)+,(A0)+                     ; $1015CA
        DC.W    $06F0               ; $1015CC DC.W    $06F0
        MOVE.W  D1,-$3B6A(A3)                   ; $1015CE
        MOVEA.B $5106(A7),A0                    ; $1015D2
        MOVE.W  (A0),-(A3)                      ; $1015D6
        BLE.S  loc_1015DD                       ; $1015D8
        OR.B   D0,$20DE(PC)                     ; $1015DA
        LSR.B  #1,D5                            ; $1015DE
        ROXR.W  D0,D0                           ; $1015E0
        MOVE.L  (A0),$1C20DD06                  ; $1015E2
        MOVE.W  -$3C(A7,D4.W),D0                ; $1015E8
        SUB.B  D3,D0                            ; $1015EC
        MOVE.W  -(A1),$1B(A0,D4.W)              ; $1015EE
        ADD.W  D1,D6                            ; $1015F2
        CMP.B  A6,D6                            ; $1015F4
        SUBI.W  #$0384,$1BA0(PC)                ; $1015F6
        ADD.B  D6,D7                            ; $1015FC
        ROR.B  D4,D0                            ; $1015FE
        SUBA.W  D2,A1                           ; $101600
        BSET    D6,$20DE(A2)                    ; $101602
        LSR.B  #1,D5                            ; $101606
        ROXR.W  D0,D0                           ; $101608
        MOVE.L  D4,$1BDC(A3)                    ; $10160A
        DC.W    $41BC               ; $10160E DC.W    $41BC
        DC.W    $0E04               ; $101610 DC.W    $0E04
        MOVE.L  D3,-(A4)                        ; $101612
        SUB.L  D1,D0                            ; $101614
        MOVE.W  -$7C61(A1),$37(A3,A2.W)         ; $101616
        DIVS    D6,D0                           ; $10161C
        DC.W    $0E30               ; $10161E DC.W    $0E30
        BGT.S  loc_1015A5                       ; $101620
        OR.L   (A0),D7                          ; $101622
        MOVE.W  $0393(A1),D5                    ; $101624
        OR.B   -$7D(A7,A2.L),D0                 ; $101628
        SUB.L  D7,$3781.W                       ; $10162C
        AND.B  A6,D3                            ; $101630
        MOVEA.W -$7C74(A6),A0                   ; $101632
        MOVE.B  D0,-(A6)                        ; $101636
        ASL.B  #4,D6                            ; $101638
        ASL.B  D6,D0                            ; $10163A
        MOVEQ   #$70,D1                         ; $10163C
        DC.W    $06F5               ; $10163E DC.W    $06F5
        MOVEA.L $48(A3,A2.W),A0                 ; $101640
        MOVE.B  (A4)+,(A6)                      ; $101644
        DC.W    $01BD               ; $101646 BCLR    D0,<EA:3D>
        DC.W    $4C1C               ; $101648 DC.W    $4C1C
        MOVE.W  D1,-(A6)                        ; $10164A
        CMP.B  A6,D6                            ; $10164C
        MOVEA.W $74(A1,A0.W),A0                 ; $10164E
        MOVEA.B -$2F(A4,A0.W),A6                ; $101652
        DC.W    $481C               ; $101656 DC.W    $481C
        SUB.B  D1,D6                            ; $101658
        EOR.W  D6,A4                            ; $10165A
        DC.W    $1CFD               ; $10165C MOVE.B  <EA:3D>,(A6)+
        AND.L  D0,#$0E307183                    ; $10165E
        MOVEQ   #$1C,D2                         ; $101664
        BRA.S  loc_101650                       ; $101666
        DC.W    $0748               ; $101668 BCHG    D3,A0
        MOVE.W  $0393(A1),-$7FC9(A3)            ; $10166A
        MOVE.L  D3,-(A4)                        ; $101670
        SUB.B  D6,A2                            ; $101672
        NEGX   -(A4)                            ; $101674
        LSR.B  #8,D5                            ; $101676
        ASR.W  D5,D0                            ; $101678
        ROL.W  $0DE0(A0)                        ; $10167A
        MOVE.W  D3,$1B(A0,A0.L)                 ; $10167E
        MOVE.L  -(A3),(A0)+                     ; $101682
        MOVE.L  A6,D2                           ; $101684
        OR.W   D0,D5                            ; $101686
        ROXR.W  -(A0)                           ; $101688
        BSET    D6,$60E7(A2)                    ; $10168A
        LSR.B  #7,D5                            ; $10168E
        ROXR.W  D0,D1                           ; $101690
        OR.L   D1,A4                            ; $101692
        MOVE.B  -(A0),$07(A5,A6.W)              ; $101694
        NEGX.B $41BB(PC)                        ; $101698
        DC.W    $481C               ; $10169C DC.W    $481C
        SUB.B  D1,D6                            ; $10169E
        EOR.W  D6,A0                            ; $1016A0
        MOVE.B  $5207(A0),(A6)+                 ; $1016A2
        MOVE.L  D0,-(A3)                        ; $1016A6
        BLE.S  loc_1016FC                       ; $1016A8
        DC.W    $073F               ; $1016AA BTST    D3,<EA:3F>
        ROXR.W  D0,D5                           ; $1016AC
        OR.W   D1,$1BC0.W                       ; $1016AE
        ASR.B  #6,D6                            ; $1016B2
        MOVE.W  -$24(PC,D4.W),D0                ; $1016B4
        BSET    D6,(A0)                         ; $1016B8
        MOVE.W  D3,$1B(A2,D7.L)                 ; $1016BA
        MULU    $06F0(A4),D0                    ; $1016BE
        MOVE.W  D1,-$437C(A3)                   ; $1016C2
        MOVEA.L $7C07(A7),A0                    ; $1016C6
        BRA.S  loc_101707                       ; $1016CA
        MULS    (A2)+,D0                        ; $1016CC
        DC.W    $0EE0               ; $1016CE DC.W    $0EE0
        BGT.S  loc_101655                       ; $1016D0
        MOVE.L  (A3)+,D6                        ; $1016D2
        MULU    (A6)+,D0                        ; $1016D4
        BCHG    D3,-(A0)                        ; $1016D6
        MOVE.W  D1,$0D(A3,A3.L)                 ; $1016D8
        LSR.W  D0,D6                            ; $1016DC
        AND.B  D6,D1                            ; $1016DE
        MOVE.W  -(A0),$03(PC,D7.W)              ; $1016E0
        CMP.B  (A5)+,D6                         ; $1016E4
        MOVE.L  $06E8(A6),(A0)+                 ; $1016E6
        MOVE.W  D1,(A5)+                        ; $1016EA
        CMP.B  A5,D6                            ; $1016EC
        ROXR.W  D0,D6                           ; $1016EE
        BCHG    D1,$1DA0.W                      ; $1016F0
        ASR.B  #7,D6                            ; $1016F4
        ROR.B  D4,D2                            ; $1016F6
        DC.W    $C1BD               ; $1016F8 AND.L  D0,<EA:3D>
        ADD.B  (A3)+,D2                         ; $1016FA
loc_1016FC:
        MULU    $06F0(A4),D0                    ; $1016FC
        MOVE.W  D1,-$43F3(A3)                   ; $101700
        ADD.W  D0,D4                            ; $101704
        ADDA.W  $0EC0.W,A7                      ; $101706
        MOVE.W  D3,$1D(A3,A3.W)                 ; $10170A
        MULU    (A5)+,D0                        ; $10170E
        BCHG    D3,(A0)+                        ; $101710
        MOVE.W  D1,$0E(A3,A3.L)                 ; $101712
        AND.W  $0374(A7),D0                     ; $101716
        DC.W    $1BC0               ; $10171A MOVE.B  D0,<EA:3D>
        ADD.L  D6,D4                            ; $10171C
        BSET    D6,-$3F14(A7)                   ; $10171E
        BCHG    D3,$3B41.W                      ; $101722
        ADD.B  A5,D6                            ; $101726
        ADD.W  $78(A5,A0.W),D0                  ; $101728
        DC.W    $1BC0               ; $10172C MOVE.B  D0,<EA:3D>
        ASR.B  #6,D6                            ; $10172E
        MOVE.W  -$24(PC,D4.W),D0                ; $101730
        BSET    D6,(A0)                         ; $101734
        MOVE.W  D3,-$58(A2,D7.L)                ; $101736
        MOVE.W  D1,$0D(A3,A5.L)                 ; $10173A
        LSR.W  D0,D6                            ; $10173E
        OR.W   D1,$1BB0.W                       ; $101740
        DC.W    $81BD               ; $101744 OR.L   D0,<EA:3D>
        MOVE.W  (A5)+,D0                        ; $101746
        DIVU    $0768(A7),D0                    ; $101748
        MOVE.W  D1,$0E(A5,A3.L)                 ; $10174C
        CMP.W  $0378(A7),D0                     ; $101750
        MOVE.B  D0,$06(A6,A5.L)                 ; $101754
        ROXR.B  D4,D7                           ; $101758
        OR.L   D0,$1B(PC,D0.L)                  ; $10175A
        ADD.L  D7,D1                            ; $10175E
        ADD.B  A6,D4                            ; $101760
        MOVEA.W -$48(A6,A0.W),A0                ; $101762
        MOVE.B  -(A0),$06(A5,A6.L)              ; $101766
        MOVE.W  -$28(A7,A0.W),D0                ; $10176A
        BSET    D6,-(A0)                        ; $10176E
        MOVEQ   #-$7D,D3                        ; $101770
        CMP.B  (A3)+,D4                         ; $101772
        MOVE.L  (A6)+,(A0)+                     ; $101774
        DC.W    $06EF               ; $101776 DC.W    $06EF
        ROXR.W  D0,D0                           ; $101778
        OR.W   D1,$00(A4,D1.L)                  ; $10177A
        ASL.B  #1,D6                            ; $10177E
        ROR.B  D4,D4                            ; $101780
        DC.W    $41BC               ; $101782 DC.W    $41BC
        BSET    D6,(A0)                         ; $101784
        MOVE.W  D3,$1E(A0,D7.W)                 ; $101786
        DC.W    $00E3               ; $10178A DC.W    $00E3
        DC.W    $06E8               ; $10178C DC.W    $06E8
        MOVEA.W D1,A6                           ; $10178E
        CMP.L  D7,D6                            ; $101790
        OR.W   $74(A1,A0.W),D0                  ; $101792
        MOVE.B  D0,D7                           ; $101796
        ASL.B  #1,D6                            ; $101798
        ROR.B  D4,D0                            ; $10179A
        AND.L  D0,#$0DD071A3                    ; $10179C
        AND.B  (A4)+,D4                         ; $1017A2
        BRA.S  loc_101783                       ; $1017A4
        BTST    D3,(A2)+                        ; $1017A6
        MOVE.W  D1,$0D(A7,A4.W)                 ; $1017A8
        ADD.W  $038C.W,D0                       ; $1017AC
        MOVE.B  -(A0),$06(A5,A6.W)              ; $1017B0
        MOVE.W  -$3E(A7,D4.W),D0                ; $1017B4
        BSET    D6,(A0)                         ; $1017B8
        MOVEQ   #$03,D4                         ; $1017BA
        OR.B   (A3)+,D6                         ; $1017BC
        MOVE.L  -$0E(A1,D0.W),(A0)+             ; $1017BE
        MOVE.B  D1,$0D(A7,A4.W)                 ; $1017C2
        ADD.W  $038C.W,D0                       ; $1017C6
        MOVE.B  -(A0),$06(A5,A7.W)              ; $1017CA
        MOVE.W  -$3A(A7,D4.W),D0                ; $1017CE
        BSET    D6,(A0)                         ; $1017D2
        MOVEQ   #$03,D4                         ; $1017D4
        OR.B   (A3)+,D6                         ; $1017D6
        MOVE.L  -(A3),(A0)+                     ; $1017D8
        DC.W    $06F2               ; $1017DA DC.W    $06F2
        MOVE.B  D1,D6                           ; $1017DC
        AND.L  A7,D3                            ; $1017DE
        MOVEA.L $74(A1,A0.W),A0                 ; $1017E0
        MOVEA.B -$01F9(A0),A6                   ; $1017E4
        MOVE.B  -$20(A7,D4.W),D4                ; $1017E8
        DC.W    $0E30               ; $1017EC DC.W    $0E30
        BGT.S  loc_101773                       ; $1017EE
        OR.B   (A3)+,D6                         ; $1017F0
        MULU    (A5)+,D0                        ; $1017F2
        DC.W    $0708               ; $1017F4 BTST    D3,A0
        MOVE.W  D1,-$1FF2(A3)                   ; $1017F6
        MOVEA.W -$7C3C(A6),A0                   ; $1017FA
        DC.W    $1BC8               ; $1017FE MOVE.B  A0,<EA:3D>
        MOVEQ   #$07,D7                         ; $101800
        MOVE.B  -$20(A7,D4.W),D4                ; $101802
        DC.W    $0E30               ; $101806 DC.W    $0E30
        BGT.S  loc_10178D                       ; $101808
        AND.B  (A3)+,D2                         ; $10180A
        MULU    (A5)+,D0                        ; $10180C
        BTST    D3,(A0)+                        ; $10180E
        MOVE.W  D1,-$1FF2(A3)                   ; $101810
        MOVEA.W -$7C74(A6),A0                   ; $101814
        DC.W    $1BC8               ; $101818 MOVE.B  A0,<EA:3D>
        MOVEQ   #$07,D0                         ; $10181A
        MOVE.B  #$81C6,D5                       ; $10181C
        BSET    D6,(A0)                         ; $101820
        MOVE.W  -(A3),$1C(A0,A7.L)              ; $101822
        BRA.S  loc_101805                       ; $101826
        BCLR    D3,D0                           ; $101828
        MOVE.W  D1,(A4)+                        ; $10182A
        CMP.B  A6,D5                            ; $10182C
        MOVEA.W $0374(A7),A0                    ; $10182E
        MOVE.B  -(A0),D6                        ; $101832
        ADD.B  D6,D7                            ; $101834
        OR.B   $C1BA.W,D0                       ; $101836
        BTST    D7,(A0)                         ; $10183A
        MOVE.W  -(A1),$1D(A0,A4.L)              ; $10183C
        NEGX   (A7)+                            ; $101840
        BTST    D3,(A2)                         ; $101842
        ADDQ.W  #4,D1                           ; $101844
        EOR.W  D6,D4                            ; $101846
        DC.W    $1BDC               ; $101848 MOVE.B  (A4)+,<EA:3D>
        DC.W    $41BC               ; $10184A DC.W    $41BC
        DC.W    $0E04               ; $10184C DC.W    $0E04
        MOVEQ   #$03,D4                         ; $10184E
        OR.B   D2,A2                            ; $101850
        MOVE.L  (A6)+,(A0)+                     ; $101852
        LSR.B  #8,D6                            ; $101854
        MOVE.L  $0385.W,(A2)                    ; $101856
        DC.W    $0A20,$DEE2         ; $10185A EORI.B  #$DEE2,-(A0)
        BSET    D6,-(A0)                        ; $10185E
        MOVEQ   #$23,D0                         ; $101860
        AND.B  (A4)+,D0                         ; $101862
        MOVEA.L (A1),A4                         ; $101864
        DC.W    $06F7               ; $101866 DC.W    $06F7
        ORI.W  #$25D0,$60(A1,D1.L)              ; $101868
        ADD.B  D6,D7                            ; $10186E
        ADDQ.B  #8,-$3C(A7,A4.W)                ; $101870
        SUB.B  (A0),D3                          ; $101874
        BLE.S  loc_1018C9                       ; $101876
        DC.W    $06F7               ; $101878 DC.W    $06F7
        MOVEA.B $0381(A7),A0                    ; $10187A
        MOVE.B  D0,D7                           ; $10187E
        ASL.W  #8,D2                            ; $101880
        OR.B   $03(A7,A3.L),D4                  ; $101882
        OR.B   D4,$00E1(A6)                     ; $101886
        CLR.L  A0                               ; $10188A
        MOVE.W  $8378.W,$08(A3,D1.L)            ; $10188C
        MOVE.W  D7,D0                           ; $101892
        DC.W    $0A14,$41BD         ; $101894 EORI.B  #$41BD,(A4)
        AND.B  (A4)+,D0                         ; $101898
        DC.W    $4974               ; $10189A DC.W    $4974
        BTST    D3,(A0)+                        ; $10189C
        MOVE.W  D1,-$2BF3(A3)                   ; $10189E
        MOVEA.W -$7C(A1,D2.W),A0                ; $1018A2
        DC.W    $1BD4               ; $1018A6 MOVE.B  (A4),<EA:3D>
        DC.W    $41BD               ; $1018A8 DC.W    $41BD
        AND.B  (A3)+,D2                         ; $1018AA
        MULU    -(A0),D0                        ; $1018AC
        DC.W    $4780               ; $1018AE DC.W    $4780
        MOVEA.W (A0),A4                         ; $1018B0
        MOVE.L  A5,D1                           ; $1018B2
        ASR.B  #7,D0                            ; $1018B4
        LSR.W  #1,D3                            ; $1018B6
        OR.B   $50A2.W,D0                       ; $1018B8
        BSET    D6,$20DE(A6)                    ; $1018BC
        BTST    D3,D2                           ; $1018C0
        MOVE.W  D1,D6                           ; $1018C2
        AND.L  D5,D1                            ; $1018C4
        MOVEA.B $7007(A7),A0                    ; $1018C6
        MOVEA.B (A5)+,A1                        ; $1018CA
        BSET    D0,D6                           ; $1018CC
        BSET    D6,(A0)                         ; $1018CE
        MOVE.W  D3,-(A2)                        ; $1018D0
        MOVEQ   #$1C,D6                         ; $1018D2
        DC.W    $4972               ; $1018D4 DC.W    $4972
        BCHG    D3,(A0)                         ; $1018D6
        MOVE.W  D1,$08(A3,A5.W)                 ; $1018D8
        MOVEA.B $41BD.W,A6                      ; $1018DC
        AND.B  (A5)+,D0                         ; $1018E0
        ADDQ.L  #2,D1                           ; $1018E2
        MULS    (A4),D4                         ; $1018E4
        DC.W    $1BC0               ; $1018E6 MOVE.B  D0,<EA:3D>
        ASL.B  #3,D6                            ; $1018E8
        MOVE.W  $81D4.W,D4                      ; $1018EA
        BSET    D6,$60E3(A0)                    ; $1018EE
        MOVE.L  A6,D1                           ; $1018F2
        OR.B   D0,D7                            ; $1018F4
        ASR.L  D0,D4                            ; $1018F6
        DC.W    $0E4E               ; $1018F8 DC.W    $0E4E
        MOVE.L  (A6)+,(A0)+                     ; $1018FA
        BTST    D3,$3741.W                      ; $1018FC
        LSR.B  #1,D6                            ; $101900
        MOVEA.L $4307(A7),A0                    ; $101902
        MOVE.B  (A4)+,D5                        ; $101906
        MULS    -(A2),D0                        ; $101908
        DC.W    $0EA0               ; $10190A DC.W    $0EA0
        BLE.S  loc_101911                       ; $10190C
        MOVE.L  (A0),D7                         ; $10190E
        MOVE.W  $7B(A0,A0.W),(A4)+              ; $101910
        OR.B   -$56FD(PC),D0                    ; $101914
        SUB.L  D1,$3781(A0)                     ; $101918
        AND.B  A5,D7                            ; $10191C
        MOVEA.W -$58(A1,D0.W),A0                ; $10191E
        DC.W    $1BD0               ; $101922 MOVE.B  (A0),<EA:3D>
        MULS    D7,D0                           ; $101924
        NEG.B  (A5)+                            ; $101926
        MOVE.B  D1,D6                           ; $101928
        AND.W  D0,A0                            ; $10192A
        MOVE.B  (A5)+,(A6)                      ; $10192C
        DC.W    $41BC               ; $10192E DC.W    $41BC
        DC.W    $0E70               ; $101930 DC.W    $0E70
        BGT.S  loc_1018B7                       ; $101932
        AND.B  (A5)+,D2                         ; $101934
        NEGX   (A6)+                            ; $101936
        OR.B   A6,D3                            ; $101938
        MOVE.W  $83C41D40,D2                    ; $10193A
        ADD.B  D7,D7                            ; $101940
        ADDQ.B  #6,-(A0)                        ; $101942
        MOVE.W  -(A1),$06F7.W                   ; $101944
        ORI.W  #$5207,$50(A5,D2.W)              ; $101948
        BLE.S  loc_101953                       ; $10194E
        SUB.B  (A3)+,D6                         ; $101950
        ASR.W  -(A2)                            ; $101952
        BCHG    D3,(A0)                         ; $101954
        MOVE.W  -(A1),-$72(A3,A0.W)             ; $101956
        OR.B   $3803(PC),D4                     ; $10195A
        OR.L   (A0),D1                          ; $10195E
        MOVE.W  -$7C88(PC),-(A4)                ; $101960
        MOVE.B  -(A0),(A6)+                     ; $101964
        ADD.B  D6,D7                            ; $101966
        OR.B   -$7E43(PC),D4                    ; $101968
        CMPI.B  #$6873,(A4)+                    ; $10196C
        DC.W    $0788               ; $101970 BCLR    D3,A0
        MOVE.W  D1,(A5)                         ; $101972
        CMP.B  A6,D6                            ; $101974
        CMP.W  D0,D4                            ; $101976
        LSL.W  D2                               ; $101978
        BSET    D6,-$1F1D(A6)                   ; $10197A
        DC.W    $06F0               ; $10197E DC.W    $06F0
        MOVE.W  D1,$0E(A3,A5.L)                 ; $101980
        MOVEA.W -$48(A6,A0.W),A0                ; $101984
        MOVE.B  -$43(A0,A0.W),$1D(A5,A7.L)      ; $101988
        DIVU    $0768(A7),D0                    ; $10198E
        MOVE.W  D1,$0E(A5,A3.L)                 ; $101992
        CMP.W  $0380(A7),D0                     ; $101996
        DC.W    $1BC0               ; $10199A MOVE.B  D0,<EA:3D>
        ADD.B  D6,D7                            ; $10199C
        BVC.S  loc_1019DB                       ; $10199E
        OR.L   D0,$0E70(PC)                     ; $1019A0
        BLE.S  loc_101A1D                       ; $1019A4
        DC.W    $06F0               ; $1019A6 DC.W    $06F0
        MOVE.W  D1,-(A5)                        ; $1019A8
        ADD.B  A6,D7                            ; $1019AA
        ADD.W  $74(A7,D0.W),D0                  ; $1019AC
        MOVE.B  -(A0),-$1FB9(A6)                ; $1019B0
        ADD.B  -$26(A7,A0.W),D4                 ; $1019B4
        DC.W    $0EE0               ; $1019B8 DC.W    $0EE0
        BGT.S  loc_10193F                       ; $1019BA
        OR.B   (A3)+,D6                         ; $1019BC
        MULU    (A6)+,D0                        ; $1019BE
        BCHG    D3,-(A0)                        ; $1019C0
        DC.W    $3BC1               ; $1019C2 MOVE.W  D1,<EA:3D>
        ADD.B  A6,D5                            ; $1019C4
        LSR.W  D0,D6                            ; $1019C6
        AND.B  D6,D1                            ; $1019C8
        MOVE.W  -(A0),$03(PC,D7.W)              ; $1019CA
        CMP.B  (A5)+,D6                         ; $1019CE
        MOVE.L  $06E8(A6),(A0)+                 ; $1019D0
        MOVE.W  D1,(A5)+                        ; $1019D4
        CMP.B  A6,D6                            ; $1019D6
        ORI.W  #$0374,$1DA0(A7)                 ; $1019D8
        ASR.B  #7,D6                            ; $1019DE
        ROR.B  D4,D1                            ; $1019E0
        DC.W    $C1BD               ; $1019E2 AND.L  D0,<EA:3D>
        ADD.B  (A3)+,D6                         ; $1019E4
        MULU    $0778(A4),D0                    ; $1019E6
        MOVE.W  D1,-$23F3(A5)                   ; $1019EA
        ADD.W  -$7F(A5,A0.W),D0                 ; $1019EE
        MOVE.B  -(A0),-$21F9(A7)                ; $1019F2
        BVC.S  loc_101A33                       ; $1019F6
        OR.L   D0,$0E30(PC)                     ; $1019F8
        BLE.S  loc_101A01                       ; $1019FC
        MOVEQ   #$1D,D4                         ; $1019FE
        DIVU    $0768(A7),D0                    ; $101A00
        MOVE.W  D1,$08(A5,A3.L)                 ; $101A04
        DC.W    $1BDF               ; $101A08 MOVE.B  (A7)+,<EA:3D>
        DIVS    (A0)+,D0                        ; $101A0A
        DC.W    $0EF0               ; $101A0C DC.W    $0EF0
        MOVEQ   #-$7D,D3                        ; $101A0E
        CMP.B  (A3)+,D4                         ; $101A10
        MOVE.L  $06F0(A3),(A0)+                 ; $101A12
        MOVE.W  D1,D4                           ; $101A16
        CMP.B  A5,D6                            ; $101A18
        ADD.W  -$48(A6,A0.W),D0                 ; $101A1A
        MOVE.B  -(A0),$06(A5,A6.W)              ; $101A1E
        MOVE.W  $03(A0,D6.L),-$4FE3(A3)         ; $101A22
        ASR.W  $0770(A5)                        ; $101A28
        MOVE.W  D1,-$29F2(A3)                   ; $101A2C
        DC.W    $047F,$0378         ; $101A30 SUBI.W  #$0378,<EA:3F>
        MOVE.B  -(A0),$06(A6,A6.L)              ; $101A34
        ROR.B  D4,D0                            ; $101A38
        AND.L  D0,#$0DE07603                    ; $101A3A
        CMP.B  (A5)+,D6                         ; $101A40
        MOVE.L  $06E8(A6),(A0)+                 ; $101A42
        MOVE.W  D1,$0E(A3,A3.L)                 ; $101A46
        DC.W    $343F               ; $101A4A MOVE.W  <EA:3F>,D2
        BSET    D1,D0                           ; $101A4C
        MOVEA.B -(A0),A6                        ; $101A4E
        ADD.B  D6,D7                            ; $101A50
        MOVE.B  -$42(A7,A0.W),D4                ; $101A52
        DC.W    $0E20               ; $101A56 DC.W    $0E20
        BGT.S  loc_1019DD                       ; $101A58
        AND.B  (A4)+,D0                         ; $101A5A
        BRA.S  loc_101A3B                       ; $101A5C
        BTST    D3,(A0)+                        ; $101A5E
        MOVE.W  D1,$0E(A3,A3.L)                 ; $101A60
        MOVEQ   #$3E,D2                         ; $101A64
        BSET    D1,D0                           ; $101A66
        MOVEA.B -(A0),A6                        ; $101A68
        ADD.B  D6,D7                            ; $101A6A
        OR.B   -$40(A7,A0.W),D4                 ; $101A6C
        DC.W    $0E30               ; $101A70 DC.W    $0E30
        BGT.S  loc_1019F7                       ; $101A72
        AND.B  (A4)+,D0                         ; $101A74
        BRA.S  loc_101A55                       ; $101A76
        DC.W    $0788               ; $101A78 BCLR    D3,A0
        MOVE.W  $039F(A1),$38(A3,A7.W)          ; $101A7A
        AND.L  D0,$0F10(PC)                     ; $101A80
        MOVEQ   #-$7D,D4                        ; $101A84
        MOVEQ   #$1B,D4                         ; $101A86
        MOVE.L  -(A3),(A0)+                     ; $101A88
        DC.W    $06E8               ; $101A8A DC.W    $06E8
        MOVE.W  D1,D6                           ; $101A8C
        AND.B  A5,D3                            ; $101A8E
        ADD.W  $78(A1,A0.W),D0                  ; $101A90
        DC.W    $1BE0               ; $101A94 MOVE.B  -(A0),<EA:3D>
        ASR.W  #1,D3                            ; $101A96
        MOVE.W  #$01C6,D0                       ; $101A98
        BSET    D6,(A0)                         ; $101A9C
        MOVE.W  D3,$1B(A0,D7.L)                 ; $101A9E
        MOVE.L  -(A7),(A0)+                     ; $101AA2
        DC.W    $06E8               ; $101AA4 DC.W    $06E8
        MOVE.W  D1,D6                           ; $101AA6
        AND.B  A5,D3                            ; $101AA8
        ADD.W  $8378.W,D0                       ; $101AAA
        MOVE.B  D0,D6                           ; $101AAE
        ASL.W  #1,D3                            ; $101AB0
        MOVE.L  #$01C60DD0,D0                   ; $101AB2
        MOVEQ   #-$7D,D4                        ; $101AB8
        MOVEQ   #-$70,D5                        ; $101ABA
        DC.W    $39FF,$038C         ; $101ABC MOVE.W  <EA:3F>,#$038C
        MOVE.B  -(A0),$07(A5,A7.W)              ; $101AC0
        OR.B   -$46(A7,A0.W),D4                 ; $101AC4
        DC.W    $0E30               ; $101AC8 DC.W    $0E30
        BGT.S  loc_101A4F                       ; $101ACA
        AND.B  (A4)+,D0                         ; $101ACC
        BRA.S  loc_101AAD                       ; $101ACE
        BTST    D3,(A0)+                        ; $101AD0
        MOVE.W  D1,$0E(A3,A3.L)                 ; $101AD2
        DC.W    $243F               ; $101AD6 MOVE.L  <EA:3F>,D2
        BSET    D1,D0                           ; $101AD8
        MOVEA.B -(A0),A6                        ; $101ADA
        ADD.B  D6,D7                            ; $101ADC
        MOVE.B  -$46(A7,A0.W),D4                ; $101ADE
        DC.W    $0E70               ; $101AE2 DC.W    $0E70
        BGT.S  loc_101A69                       ; $101AE4
        AND.B  (A4)+,D0                         ; $101AE6
        BRA.S  loc_101AC7                       ; $101AE8
        DC.W    $0788               ; $101AEA BCLR    D3,A0
        MOVE.W  D1,$0E(A3,A4.W)                 ; $101AEC
        MOVE.W  $03C0(PC),D2                    ; $101AF0
        MOVEA.B -(A0),A6                        ; $101AF4
        ADD.B  D6,D7                            ; $101AF6
        OR.B   $03(A7,A2.L),D4                  ; $101AF8
        SUBA.L  $38C1(A0),A7                    ; $101AFC
        CMP.B  A7,D5                            ; $101B00
        MOVEA.B $8378.W,A0                      ; $101B02
        MOVE.B  -(A0),$06(A5,A6.W)              ; $101B06
        ROR.B  D4,D4                            ; $101B0A
        BSET    D0,D6                           ; $101B0C
        BSET    D6,(A0)                         ; $101B0E
        MOVE.W  D3,$1C(A0,A0.W)                 ; $101B10
        BSET    #16,$11(A1,D3.L)                ; $101B14
        LSR.B  #3,D6                            ; $101B1A
        MOVEA.B -$7C88(A6),A0                   ; $101B1C
        DC.W    $1BC9               ; $101B20 MOVE.B  A1,<EA:3D>
        MOVE.W  D7,D0                           ; $101B22
        DC.W    $0A14,$41BD         ; $101B24 EORI.B  #$41BD,(A4)
        AND.B  (A3)+,D2                         ; $101B28
        MULU    -(A0),D0                        ; $101B2A
        DC.W    $47A0               ; $101B2C DC.W    $47A0
        MOVE.W  D1,$0D(A3,A4.L)                 ; $101B2E
        LSR.W  D0,D6                            ; $101B32
        OR.W   D1,$2C20DEA4                     ; $101B34
        BSET    D6,-(A4)                        ; $101B3A
        CMP.L  D3,D0                            ; $101B3C
        OR.B   D2,(A6)+                         ; $101B3E
        MOVE.L  (A6)+,(A0)+                     ; $101B40
        BTST    D3,D2                           ; $101B42
        MOVE.W  D1,(A6)+                        ; $101B44
        AND.B  A5,D1                            ; $101B46
        ADD.W  $0379(A7),D0                     ; $101B48
        MOVE.W  D0,D7                           ; $101B4C
        ASL.W  #8,D2                            ; $101B4E
        OR.B   -$7D(A7,A3.L),D4                 ; $101B50
        MOVEQ   #$1C,D4                         ; $101B54
        BSET    #16,-$3F(A4,D3.L)               ; $101B56
        CMP.B  A5,D6                            ; $101B5C
        ADD.W  $2584(A7),D0                     ; $101B5E
        DC.W    $1BD4               ; $101B62 MOVE.B  (A4),<EA:3D>
        OR.L   D0,#$961070A3                    ; $101B64
        AND.B  (A3)+,D2                         ; $101B6A
        MULU    -(A0),D0                        ; $101B6C
        DC.W    $4798               ; $101B6E DC.W    $4798
        MOVEA.W D1,A4                           ; $101B70
        CMP.B  A5,D5                            ; $101B72
        LSR.W  D0,D7                            ; $101B74
        MOVE.L  D0,$28(PC,D1.L)                 ; $101B76
        SUBQ.B  #8,D6                           ; $101B7A
        MOVE.W  (A0),-(A3)                      ; $101B7C
        BLE.S  loc_101B83                       ; $101B7E
        OR.B   D0,(A6)+                         ; $101B80
        DIVU    (A6)+,D0                        ; $101B82
        BTST    D3,$3781.W                      ; $101B84
        CMP.B  A5,D5                            ; $101B88
        ROXR.L  D2,D0                           ; $101B8A
        OR.W   D1,-$6FC9(PC)                    ; $101B8C
        SUBA.W  D2,A1                           ; $101B90
        DC.W    $0E14               ; $101B92 DC.W    $0E14
        MOVEQ   #-$7D,D4                        ; $101B94
        MOVEQ   #$1C,D4                         ; $101B96
        BSET    #21,$73(A0,D2.W)                ; $101B98
        MOVE.W  D6,D0                           ; $101B9E
        MOVE.W  -$0C(A0,D7.W),-(A2)             ; $101BA0
        DC.W    $06F0               ; $101BA4 DC.W    $06F0
        MOVE.W  D1,(A4)+                        ; $101BA6
        AND.B  A5,D0                            ; $101BA8
        ADD.W  $07(A1,A5.W),D0                  ; $101BAA
        DC.W    $4520               ; $101BAE DC.W    $4520
        MOVEQ   #$72,D1                         ; $101BB0
        DC.W    $06F0               ; $101BB2 DC.W    $06F0
        MOVE.W  D1,#$C08F                       ; $101BB4
        MOVEQ   #$6F,D0                         ; $101BB8
        DC.W    $038C               ; $101BBA BCLR    D1,A4
        MOVEA.B -(A0),A6                        ; $101BBC
        ADD.B  D6,D6                            ; $101BBE
        MOVE.W  $01D2(PC),D0                    ; $101BC0
        BSET    D6,(A2)+                        ; $101BC4
        MOVE.L  -(A4),(A0)+                     ; $101BC6
        MOVE.L  A6,D1                           ; $101BC8
        SUB.W  D0,D5                            ; $101BCA
        ROL.W  -(A0)                            ; $101BCC
        BSET    D6,$60E7(A2)                    ; $101BCE
        LSR.B  #4,D5                            ; $101BD2
        ROXR.W  D0,D1                           ; $101BD4
        OR.L   D1,D0                            ; $101BD6
        MOVE.B  -(A0),-$5C(A5,A6.W)             ; $101BD8
        DC.W    $0E8A               ; $101BDC DC.W    $0E8A
        NEGX   -(A4)                            ; $101BDE
        LSR.B  #2,D5                            ; $101BE0
        ROXR.W  D0,D3                           ; $101BE2
        OR.L   D1,D1                            ; $101BE4
        MOVE.B  -(A0),(A7)+                     ; $101BE6
        ADD.B  D7,D7                            ; $101BE8
        MOVE.B  $C1BA.W,D4                      ; $101BEA
        BSET    D6,-(A0)                        ; $101BEE
        MOVEQ   #$03,D2                         ; $101BF0
        MOVE.L  (A3)+,D2                        ; $101BF2
        EOR.W  D2,D1                            ; $101BF4
        AND.W  D4,D4                            ; $101BF6
        MOVE.B  -$31(A4,A0.W),-(A6)             ; $101BF8
        AND.B  (A3)+,D0                         ; $101BFC
        ADDA.W  D1,A2                           ; $101BFE
        MULS    (A0),D7                         ; $101C00
        DC.W    $1BC0               ; $101C02 MOVE.B  D0,<EA:3D>
        ASL.B  #1,D7                            ; $101C04
        DC.W    $0037,$41C7,$481D   ; $101C06 ORI.B  #$41C7,$1D(A7,D4.L)
        MOVE.B  D1,(A2)                         ; $101C0C
        MULS    A0,D4                           ; $101C0E
        DC.W    $1BC0               ; $101C10 MOVE.B  D0,<EA:3D>
        ASL.B  #3,D7                            ; $101C12
        DC.W    $023D,$C1BC         ; $101C14 ANDI.B  #$C1BC,<EA:3D>
        DC.W    $0E30               ; $101C18 DC.W    $0E30
        MOVE.W  D3,$1B(A0,D7.W)                 ; $101C1A
        MULU    $0748(A0),D0                    ; $101C1E
        MOVE.W  -$7C6E(A2),-$77C6(A3)           ; $101C22
        BVS.S  loc_101C2D                       ; $101C28
        SUB.L  D7,D0                            ; $101C2A
        MOVE.W  $039F(A1),$3A(A3,A1.L)          ; $101C2C
        AND.L  D0,#$0DE07652                    ; $101C32
        BTST    D3,-(A2)                        ; $101C38
        DC.W    $1DC1               ; $101C3A MOVE.B  D1,<EA:3E>
        ADD.B  A5,D3                            ; $101C3C
        LSR.W  D0,D7                            ; $101C3E
        BCLR    D1,(A4)+                        ; $101C40
        DC.W    $1BC0               ; $101C42 MOVE.B  D0,<EA:3D>
        ADD.B  D6,D6                            ; $101C44
        MOVE.W  -$7D(A7,D6.W),D0                ; $101C46
        MOVE.W  A6,-(A4)                        ; $101C4A
        DC.W    $00ED               ; $101C4C DC.W    $00ED
        MOVE.L  A6,D2                           ; $101C4E
        MOVEQ   #$20,D4                         ; $101C50
        ADD.L  -(A2),D7                         ; $101C52
        DC.W    $0E44               ; $101C54 DC.W    $0E44
        MOVE.W  D3,(A0)                         ; $101C56
        MOVEQ   #$10,D5                         ; $101C58
        MOVE.W  $03B1(A1),$60(A3,D1.L)          ; $101C5A
        ASL.B  #5,D6                            ; $101C60
        MOVE.W  -$27(A7,A0.W),D0                ; $101C62
        DC.W    $481C               ; $101C66 DC.W    $481C
        OR.W   $58(A7,D0.W),D4                  ; $101C68
        MOVE.W  D1,$0E(A3,A3.L)                 ; $101C6C
        MOVEQ   #$6F,D0                         ; $101C70
        BCHG    D1,-$40(A4,D1.L)                ; $101C72
        ADD.L  D6,D6                            ; $101C76
        BSET    D6,-(A4)                        ; $101C78
loc_101C7A:
        MOVE.W  D3,D4                           ; $101C7A
        CMP.L  (A0),D3                          ; $101C7C
        MOVE.W  -(A0),#$837A                    ; $101C7E
        OR.B   $10C20DE8,D4                     ; $101C82
        NEGX   (A6)+                            ; $101C88
        MOVE.L  A6,D2                           ; $101C8A
        AND.W  $83AC1BC0,D2                     ; $101C8C
        ADD.B  D7,D7                            ; $101C92
        BCS.S  loc_101CB6                       ; $101C94
        MOVEQ   #$21,D1                         ; $101C96
        ADD.B  (A5)+,D6                         ; $101C98
        BRA.S  loc_101C7A                       ; $101C9A
        DC.W    $06F0               ; $101C9C DC.W    $06F0
        MOVE.W  D1,#$BC0D                       ; $101C9E
        ADD.W  $0376(A7),D0                     ; $101CA2
        MOVE.B  -$20(A7,A1.W),D4                ; $101CA6
        DC.W    $0EDA               ; $101CAA DC.W    $0EDA
        NEGX   -(A7)                            ; $101CAC
        OR.B   A5,D1                            ; $101CAE
        ASR.B  D5,D0                            ; $101CB0
        ASR.W  #2,D3                            ; $101CB2
        BTST    #3,-$70(A7,D7.L)                ; $101CB4
        MOVE.W  (A1),-(A5)                      ; $101CBA
        LSR.B  #3,D6                            ; $101CBC
        CMP.W  $0378(A7),D0                     ; $101CBE
        MOVE.B  (A4),-$38(A6,A0.W)              ; $101CC2
        OR.B   (A0),D3                          ; $101CC6
        BLE.S  loc_101D48                       ; $101CC8
        BTST    D3,(A0)+                        ; $101CCA
        MOVE.W  D1,-$1FF2(A3)                   ; $101CCC
        MOVEA.W -$7C3C(A6),A0                   ; $101CD0
        DC.W    $1BC0               ; $101CD4 MOVE.B  D0,<EA:3D>
        ADD.B  D6,D7                            ; $101CD6
        MOVE.B  -$20(A7,D4.W),D4                ; $101CD8
        DC.W    $0E30               ; $101CDC DC.W    $0E30
        BGT.S  loc_101C63                       ; $101CDE
        OR.B   (A3)+,D6                         ; $101CE0
        AND.W  $18(A5,D0.W),D4                  ; $101CE2
        MOVE.W  D1,-$1FF2(A3)                   ; $101CE6
        MOVEA.W -$7C73(A6),A0                   ; $101CEA
        MOVE.B  -(A0),(A7)                      ; $101CEE
        ASL.B  #1,D6                            ; $101CF0
        ROR.B  D4,D4                            ; $101CF2
        BSET    D0,D6                           ; $101CF4
        BSET    D6,(A0)                         ; $101CF6
        MOVE.W  -(A3),$1C(A0,A7.L)              ; $101CF8
        BRA.S  loc_101CDB                       ; $101CFC
        BTST    D3,(A0)+                        ; $101CFE
        MOVE.W  D1,-$1DF2(A3)                   ; $101D00
        MOVEA.W $0374(A7),A0                    ; $101D04
        MOVEA.B -(A0),A6                        ; $101D08
        ADD.B  D6,D7                            ; $101D0A
        OR.B   $C1BA.W,D0                       ; $101D0C
        BTST    D7,(A0)                         ; $101D10
        BLE.S  loc_101D35                       ; $101D12
        MOVE.W  (A4)+,D2                        ; $101D14
        BRA.S  loc_101CF5                       ; $101D16
        BCLR    D3,D0                           ; $101D18
        MOVE.W  D1,(A4)+                        ; $101D1A
        CMP.B  A6,D5                            ; $101D1C
        MOVEA.W $0374(A7),A0                    ; $101D1E
        MOVEA.B -(A0),A6                        ; $101D22
        ADD.B  D6,D7                            ; $101D24
        OR.B   $C1BA.W,D0                       ; $101D26
        DC.W    $0E34               ; $101D2A DC.W    $0E34
        MOVEQ   #-$7D,D5                        ; $101D2C
        OR.B   (A3)+,D6                         ; $101D2E
        MOVE.L  $18(A0,D0.W),(A0)+              ; $101D30
        MOVE.W  D1,-$3971(A3)                   ; $101D34
        ROXR.W  D0,D1                           ; $101D38
        OR.W   D1,$60(A4,D1.L)                  ; $101D3A
        ADD.B  D6,D7                            ; $101D3E
        OR.B   $C1BC.W,D4                       ; $101D40
        BSET    D6,(A0)                         ; $101D44
        MOVE.W  D3,$1E(A0,D7.W)                 ; $101D46
        DC.W    $00E3               ; $101D4A DC.W    $00E3
        DC.W    $06E8               ; $101D4C DC.W    $06E8
        MOVEA.W D1,A6                           ; $101D4E
        CMP.L  D7,D6                            ; $101D50
        ADD.W  $74(A1,A0.W),D0                  ; $101D52
        MOVE.B  D0,D7                           ; $101D56
        ASL.B  #1,D6                            ; $101D58
        ROR.B  D4,D0                            ; $101D5A
        AND.L  D0,#$0DD07183                    ; $101D5C
        MOVEQ   #$1E,D2                         ; $101D62
        DC.W    $00E3               ; $101D64 DC.W    $00E3
        DC.W    $06E8               ; $101D66 DC.W    $06E8
        MOVE.W  (A1),(A4)+                      ; $101D68
        LSR.B  #5,D6                            ; $101D6A
        MOVEA.W -$7C40(A6),A0                   ; $101D6C
        MOVEA.B -(A0),A6                        ; $101D70
        ADD.B  D6,D7                            ; $101D72
        DC.W    $1A3F               ; $101D74 MOVE.B  <EA:3F>,D5
        DIVS    D6,D0                           ; $101D76
        BSET    D6,(A0)                         ; $101D78
        MOVE.W  D3,$1E(A0,D7.W)                 ; $101D7A
        MOVE.L  -(A3),(A0)+                     ; $101D7E
        DC.W    $06F0               ; $101D80 DC.W    $06F0
        MOVE.W  D1,-$39F3(A3)                   ; $101D82
        ADD.W  $038C.W,D0                       ; $101D86
        MOVE.B  -(A0),$06(A5,A7.W)              ; $101D8A
        ASL.B  D7,D0                            ; $101D8E
        BLE.S  loc_101D15                       ; $101D90
        OR.B   (A3)+,D4                         ; $101D92
        MULS    -(A1),D4                        ; $101D94
        DC.W    $06F5               ; $101D96 DC.W    $06F5
        MOVEA.B $7106(A7),A0                    ; $101D98
        MOVE.W  $11E0.W,D0                      ; $101D9C
        DC.W    $0E14               ; $101DA0 DC.W    $0E14
        MOVE.L  D3,(A4)                         ; $101DA2
        MOVE.W  -(A0),-$7F(A5,D3.L)             ; $101DA4
        CMP.B  A5,D5                            ; $101DA8
        LSR.W  D0,D7                            ; $101DAA
        BCLR    D1,D5                           ; $101DAC
        DC.W    $0A20,$DEE2         ; $101DAE EORI.B  #$DEE2,-(A0)
        BSET    D6,-(A0)                        ; $101DB2
        MOVEQ   #$23,D0                         ; $101DB4
        AND.B  (A4)+,D0                         ; $101DB6
        MOVEA.L (A1),A4                         ; $101DB8
        DC.W    $06F7               ; $101DBA DC.W    $06F7
        ORI.W  #$27C8,-$20(A1,D1.L)             ; $101DBC
        ASR.B  #1,D6                            ; $101DC2
        MOVEA.W $41BD.W,A1                      ; $101DC4
        NEG.B  (A3)+                            ; $101DC8
        ADD.W  D1,D6                            ; $101DCA
        CMP.B  A6,D6                            ; $101DCC
        SUBI.W  #$0385,$0A20.W                  ; $101DCE
        ADDA.W  $0E20(A0),A7                    ; $101DD4
        BGT.S  loc_101D5D                       ; $101DD8
        MOVEQ   #$1B,D4                         ; $101DDA
        MULU    -(A1),D0                        ; $101DDC
        CLR.L  A0                               ; $101DDE
        MOVE.W  $8378.W,$08(A3,D1.L)            ; $101DE0
        MOVE.W  D7,D0                           ; $101DE6
        DC.W    $0A14,$41BD         ; $101DE8 EORI.B  #$41BD,(A4)
        AND.B  (A4)+,D0                         ; $101DEC
        LEA     -$08(A2,D0.W),A4                ; $101DEE
        MOVE.W  D1,(A4)                         ; $101DF2
        CMP.L  (A6)+,D6                         ; $101DF4
        MOVEA.B $5106(A7),A0                    ; $101DF6
        MOVE.W  (A0),-(A3)                      ; $101DFA
        BLE.S  loc_101E01                       ; $101DFC
        OR.B   D0,(A6)+                         ; $101DFE
        DC.W    $00E1               ; $101E00 DC.W    $00E1
        CLR.L  A0                               ; $101E02
        MOVE.W  $0388(PC),-$60(A3,D1.L)         ; $101E04
        ADD.B  D6,D7                            ; $101E0A
        MOVE.W  $50A2.W,D0                      ; $101E0C
        BSET    D6,$20DE(A6)                    ; $101E10
        BTST    D3,D2                           ; $101E14
        MOVE.W  D1,D6                           ; $101E16
        AND.L  D5,D1                            ; $101E18
        MOVEA.B $7007(A7),A0                    ; $101E1A
        MOVEA.B #$81BE,A1                       ; $101E1E
        DC.W    $0E20               ; $101E22 DC.W    $0E20
        BLE.S  loc_101E4F                       ; $101E24
        AND.B  (A3)+,D0                         ; $101E26
        ADD.L  D1,D0                            ; $101E28
        MULS    A4,D3                           ; $101E2A
        DC.W    $1BE0               ; $101E2C MOVE.B  -(A0),<EA:3D>
        ASR.B  #1,D6                            ; $101E2E
        ROR.B  D4,D2                            ; $101E30
        MOVE.L  D3,-(A4)                        ; $101E32
        SUB.L  D1,$3781(A0)                     ; $101E34
        AND.B  A5,D7                            ; $101E38
        MOVEA.W -$58(A1,D0.W),A0                ; $101E3A
        DC.W    $1BD0               ; $101E3E MOVE.B  (A0),<EA:3D>
        MULS    D6,D0                           ; $101E40
        OR.B   D7,D0                            ; $101E42
        MOVE.W  (A2),$0727(A2)                  ; $101E44
        ADDQ.W  #8,$039C(A7)                    ; $101E48
        MOVE.B  -(A0),$07(A5,A7.W)              ; $101E4C
        ADDQ.B  #8,-$7D(A7,A2.W)                ; $101E50
        OR.B   D6,A6                            ; $101E54
        NEGX   -(A3)                            ; $101E56
        DC.W    $06E8               ; $101E58 DC.W    $06E8
        MOVE.W  -(A1),-$71(A3,D0.W)             ; $101E5A
        SUB.B  -$3C(A7,A4.W),D4                 ; $101E5E
        BSET    D6,(A0)                         ; $101E62
        MOVE.W  (A2),$0727(A2)                  ; $101E64
        ADDQ.W  #8,$039C(A7)                    ; $101E68
        DC.W    $1BE0               ; $101E6C MOVE.B  -(A0),<EA:3D>
        ASR.B  #1,D7                            ; $101E6E
        ADDQ.B  #8,-$7D(A7,A2.W)                ; $101E70
        OR.B   D6,(A6)+                         ; $101E74
        DC.W    $00EA               ; $101E76 DC.W    $00EA
        MOVE.L  A6,D2                           ; $101E78
        JSR     -(A0)                           ; $101E7A
        ADD.B  D7,D7                            ; $101E7C
        MOVE.W  -$1E(A7,D4.W),D4                ; $101E7E
        DC.W    $0EA0               ; $101E82 DC.W    $0EA0
        BLE.S  loc_101EC9                       ; $101E84
        BTST    D3,(A2)+                        ; $101E86
        MOVE.B  D1,(A6)                         ; $101E88
        AND.B  A5,D3                            ; $101E8A
        ADD.W  $4207(A7),D0                     ; $101E8C
        MOVE.B  -$7D(A0,D6.L),-(A7)             ; $101E90
        OR.B   (A3)+,D4                         ; $101E94
        MOVE.L  -$5BF2(A2),(A0)+                ; $101E96
        JSR     -(A0)                           ; $101E9A
        ADD.B  D7,D7                            ; $101E9C
        MOVE.W  -$3C(A7,A4.W),D4                ; $101E9E
        DC.W    $0EA0               ; $101EA2 DC.W    $0EA0
        BLE.S  loc_101EE9                       ; $101EA4
        BTST    D3,(A2)+                        ; $101EA6
        MOVE.W  D1,D6                           ; $101EA8
        ADD.W  D2,A0                            ; $101EAA
        MOVE.B  (A5)+,(A6)                      ; $101EAC
        DC.W    $41BC               ; $101EAE DC.W    $41BC
        DC.W    $0E70               ; $101EB0 DC.W    $0E70
        BGT.S  loc_101E37                       ; $101EB2
        AND.B  (A5)+,D2                         ; $101EB4
        NEGX   (A6)+                            ; $101EB6
        OR.B   A6,D3                            ; $101EB8
        MOVE.W  $038C1BA0,D2                    ; $101EBA
        ADD.L  D4,D7                            ; $101EC0
        DC.W    $0E3F               ; $101EC2 DC.W    $0E3F
        DC.W    $00DF               ; $101EC4 DC.W    $00DF
        BTST    D3,(A0)                         ; $101EC6
        MOVE.W  D1,-$29F3(A3)                   ; $101EC8
        LSR.W  D0,D7                            ; $101ECC
        BCLR    D1,-$20(A0,D1.L)                ; $101ECE
        ADD.W  D6,D7                            ; $101ED2
        MOVE.L  -$7D(A7,A2.L),D0                ; $101ED4
        EOR.B  D2,A6                            ; $101ED8
        ASR.W  $06F0(A3)                        ; $101EDA
        MOVE.W  D1,$0E(A3,A5.L)                 ; $101EDE
        MOVEA.W -$48(A6,A0.W),A0                ; $101EE2
        MOVE.B  -$43(A0,A0.W),$1D(A5,A5.L)      ; $101EE6
        DIVU    $0768(A7),D0                    ; $101EEC
        MOVE.W  D1,$0E(A5,A3.L)                 ; $101EF0
        CMP.W  $037A(A7),D0                     ; $101EF4
        SUB.B  $3B83B81B,D0                     ; $101EF8
        MOVE.L  $06F0(A3),(A0)+                 ; $101EFE
        MOVE.W  D1,$0E(A3,A5.L)                 ; $101F02
        MOVEA.W $2310(A7),A0                    ; $101F06
        DC.W    $1BD4               ; $101F0A MOVE.B  (A4),<EA:3D>
        LEA     (A2)+,A0                        ; $101F0C
        OR.W   D3,-$7D(A0,D7.W)                 ; $101F0E
        MOVEQ   #$1B,D4                         ; $101F12
        MULU    $0778(A4),D0                    ; $101F14
        MOVE.W  D1,-$23F3(A5)                   ; $101F18
        ADD.W  D0,D4                            ; $101F1C
        ADDA.W  $0EC0(A6),A7                    ; $101F1E
        MOVE.W  D3,$1D(A3,A3.W)                 ; $101F22
        MULU    (A5)+,D0                        ; $101F26
        BCHG    D3,(A0)+                        ; $101F28
        MOVE.W  D1,$48(A3,A3.L)                 ; $101F2A
        MOVE.B  (A5)+,(A6)                      ; $101F2E
        MULS    (A4)+,D0                        ; $101F30
        BSET    D6,(A0)                         ; $101F32
        MOVE.W  D3,$1B(A2,D7.L)                 ; $101F34
        MULU    $0778(A4),D0                    ; $101F38
        MOVE.W  (A1),$0D(A3,A0.L)               ; $101F3C
        ASR.B  D5,D0                            ; $101F40
        ASL.W  #6,D3                            ; $101F42
        CMP.B  -$3E44(PC),D4                    ; $101F44
        BSET    D6,-(A0)                        ; $101F48
        MOVEQ   #$03,D3                         ; $101F4A
        CMP.B  (A5)+,D6                         ; $101F4C
        MOVE.L  $06EC(A6),(A0)+                 ; $101F4E
        MOVEA.L $7707(A7),A0                    ; $101F52
        BRA.S  loc_101F93                       ; $101F56
        MULS    (A2)+,D0                        ; $101F58
        DC.W    $0EE0               ; $101F5A DC.W    $0EE0
        BGT.S  loc_101EE1                       ; $101F5C
        MOVE.L  (A3)+,D6                        ; $101F5E
        MULU    (A6)+,D0                        ; $101F60
        MOVE.L  A6,D2                           ; $101F62
        JMP     -(A0)                           ; $101F64
        ASR.B  #7,D6                            ; $101F66
        ROR.B  D4,D2                            ; $101F68
        AND.L  D0,#$0DE07603                    ; $101F6A
        CMP.B  (A3)+,D6                         ; $101F70
        MULU    -(A1),D4                        ; $101F72
        DC.W    $06F7               ; $101F74 DC.W    $06F7
        OR.W   $74(A1,A0.W),D0                  ; $101F76
        MOVE.B  D0,D7                           ; $101F7A
        ASL.B  #1,D6                            ; $101F7C
        ROR.B  D4,D0                            ; $101F7E
        AND.L  D0,#$0DD07023                    ; $101F80
        MOVE.W  (A4)+,D4                        ; $101F86
        BRA.S  loc_101F67                       ; $101F88
        DC.W    $0788               ; $101F8A BCLR    D3,A0
        MOVE.W  D1,$0E(A3,A3.L)                 ; $101F8C
        MOVEA.W -$7C40(A6),A0                   ; $101F90
        MOVEA.B -(A0),A6                        ; $101F94
        ADD.B  D6,D7                            ; $101F96
        MOVE.B  -$46(A7,A0.W),D4                ; $101F98
        DC.W    $0E30               ; $101F9C DC.W    $0E30
loc_101F9E:
        BGT.S  loc_101F9E                       ; $101F9E
        BCLR    D3,D0                           ; $101FA0
        MOVE.W  D1,(A4)+                        ; $101FA2
        CMP.B  A6,D5                            ; $101FA4
        MOVEA.W $0374(A7),A0                    ; $101FA6
        MOVEA.B -(A0),A6                        ; $101FAA
        ADD.B  D6,D7                            ; $101FAC
        OR.B   $C1BA.W,D0                       ; $101FAE
        BTST    D7,(A0)                         ; $101FB2
        BLE.S  loc_101FB9                       ; $101FB4
        MOVEQ   #$1C,D2                         ; $101FB6
        BVC.S  loc_102030                       ; $101FB8
        BCLR    D3,D0                           ; $101FBA
        MOVE.W  D1,(A4)+                        ; $101FBC
        CMP.B  A6,D5                            ; $101FBE
        MOVEA.W $0374(A7),A0                    ; $101FC0
        MOVE.B  A0,D6                           ; $101FC4
        MOVE.W  D7,D7                           ; $101FC6
        MOVE.B  -$1E(A7,D4.W),D4                ; $101FC8
        BSET    D6,-(A0)                        ; $101FCC
        BGT.S  loc_101F53                       ; $101FCE
        OR.B   (A3)+,D6                         ; $101FD0
        MOVE.L  $18(A0,D0.W),(A0)+              ; $101FD2
        MOVE.W  D1,-$39F3(A3)                   ; $101FD6
        LSR.W  D0,D6                            ; $101FDA
        OR.L   D1,A4                            ; $101FDC
        DC.W    $1BBF,$81E0         ; $101FDE MOVE.B  <EA:3F>,-$20(A5,A0.W)
        DC.W    $0E30               ; $101FE2 DC.W    $0E30
        BGT.S  loc_101F69                       ; $101FE4
        OR.B   (A3)+,D6                         ; $101FE6
        MULU    (A5)+,D0                        ; $101FE8
        BTST    D3,(A0)+                        ; $101FEA
        MOVE.W  D1,-$1FF2(A3)                   ; $101FEC
        MOVEA.W -$7C3C(A6),A0                   ; $101FF0
        DC.W    $1BC0               ; $101FF4 MOVE.B  D0,<EA:3D>
        ADD.B  D6,D7                            ; $101FF6
        MOVE.B  (A5)+,D5                        ; $101FF8
        DIVS    -(A0),D0                        ; $101FFA
        DC.W    $0E30               ; $101FFC DC.W    $0E30
        BGT.S  loc_101F83                       ; $101FFE
        OR.B   (A3)+,D6                         ; $102000
        MULU    (A5)+,D0                        ; $102002
        BTST    D3,D2                           ; $102004
        MOVE.W  D1,$0D(A7,A4.W)                 ; $102006
        ADD.W  $8378.W,D0                       ; $10200A
        MOVE.B  -(A0),$06(A5,A6.W)              ; $10200E
        ROR.B  D4,D4                            ; $102012
        BSET    D0,D6                           ; $102014
        BSET    D6,(A0)                         ; $102016
        MOVE.W  D3,$1B(A0,D7.L)                 ; $102018
        MOVE.L  -(A3),(A0)+                     ; $10201C
        DC.W    $06EF               ; $10201E DC.W    $06EF
        ROR.W  D0,D0                            ; $102020
        DC.W    $038C               ; $102022 BCLR    D1,A4
        MOVE.B  -(A0),$06(A5,A6.W)              ; $102024
        MOVE.W  -$3A(A7,D4.W),D0                ; $102028
        BSET    D6,(A0)                         ; $10202C
        MOVEQ   #$03,D4                         ; $10202E
loc_102030:
        OR.B   (A3)+,D6                         ; $102030
        MOVE.L  -$10(A1,D0.W),(A0)+             ; $102032
        MOVE.W  D1,-$3979(A3)                   ; $102036
        NEGX.W $038C.W                          ; $10203A
        MOVE.B  -(A0),$07(A5,A6.W)              ; $10203E
        DC.W    $0A14,$41BD         ; $102042 EORI.B  #$41BD,(A4)
        AND.B  (A3)+,D2                         ; $102046
        MULU    -(A0),D0                        ; $102048
        DC.W    $47A0               ; $10204A DC.W    $47A0
        MOVEA.W D1,A4                           ; $10204C
        CMP.B  A6,D5                            ; $10204E
        MOVEQ   #$6E,D0                         ; $102050
        OR.L   D1,A1                            ; $102052
        MOVE.L  D0,D7                           ; $102054
        ASL.W  #8,D2                            ; $102056
        OR.B   -$7D(A7,A3.L),D4                 ; $102058
        MOVEQ   #$1C,D4                         ; $10205C
        BSET    #8,$41(A4,D3.W)                 ; $10205E
        CMP.B  A5,D6                            ; $102064
        ADD.W  -$40(A1,D2.W),D0                 ; $102066
        MOVE.B  $5106(A0),D6                    ; $10206A
        MOVE.W  (A0),-(A3)                      ; $10206E
        BLE.S  loc_102075                       ; $102070
        OR.B   D0,(A6)+                         ; $102072
        DC.W    $00E1               ; $102074 DC.W    $00E1
        CLR.L  A0                               ; $102076
        MOVE.W  $8378.W,$08(A3,D1.L)            ; $102078
        MOVE.W  D7,D2                           ; $10207E
        BTST    #14,-$30(A7,D0.L)               ; $102080
        MOVE.W  -(A5),-(A0)                     ; $102086
        AND.B  (A4)+,D0                         ; $102088
        MOVEA.L (A1),A4                         ; $10208A
        DC.W    $06F7               ; $10208C DC.W    $06F7
        MOVEA.B $0381(A7),A0                    ; $10208E
        MOVE.B  D0,(A7)                         ; $102092
        ASL.B  #8,D6                            ; $102094
        ROXR.B  D4,D7                           ; $102096
        OR.L   D0,$0E24(PC)                     ; $102098
        CMP.B  D3,D4                            ; $10209C
        OR.B   D2,A2                            ; $10209E
        MOVE.L  (A6)+,(A0)+                     ; $1020A0
        LSR.B  #1,D5                            ; $1020A2
        ROXR.W  D0,D0                           ; $1020A4
        MOVE.L  D0,$1C285106                    ; $1020A6
        MOVE.W  (A0),-(A3)                      ; $1020AC
        BLE.S  loc_1020B3                       ; $1020AE
        OR.B   D0,(A6)+                         ; $1020B0
        DIVU    -(A1),D0                        ; $1020B2
        DC.W    $06E8               ; $1020B4 DC.W    $06E8
        MOVE.W  D1,#$BA0E                       ; $1020B6
        MOVE.L  $0385.W,(A2)                    ; $1020BA
        DC.W    $0A20,$DEE2         ; $1020BE EORI.B  #$DEE2,-(A0)
        BSET    D6,-(A0)                        ; $1020C2
        MOVEQ   #$23,D0                         ; $1020C4
        ADD.B  (A4)+,D0                         ; $1020C6
        MOVE.L  (A5)+,(A0)+                     ; $1020C8
        DC.W    $06F0               ; $1020CA DC.W    $06F0
        MOVE.W  D1,-$3B69(A3)                   ; $1020CC
        ORI.W  #$A144,-$24(A0,D1.L)             ; $1020D0
        DC.W    $41BC               ; $1020D6 DC.W    $41BC
        DC.W    $0E04               ; $1020D8 DC.W    $0E04
        MOVEQ   #$03,D4                         ; $1020DA
        OR.B   D2,A2                            ; $1020DC
        MOVE.L  (A6)+,(A0)+                     ; $1020DE
        LSR.B  #1,D5                            ; $1020E0
        ROXR.W  D0,D0                           ; $1020E2
        MOVE.L  D0,$1D5481C9                    ; $1020E4
        AND.B  (A3)+,D0                         ; $1020EA
        ADDA.W  D1,A2                           ; $1020EC
        MULS    (A0),D7                         ; $1020EE
        DC.W    $1BC0               ; $1020F0 MOVE.B  D0,<EA:3D>
        ASL.B  #1,D7                            ; $1020F2
        MOVE.B  -$39(A7,D4.W),D4                ; $1020F4
        DC.W    $481D               ; $1020F8 DC.W    $481D
        MOVE.B  D1,(A2)                         ; $1020FA
        MULS    D0,D4                           ; $1020FC
        DC.W    $1BD4               ; $1020FE MOVE.B  (A4),<EA:3D>
        MULS    A7,D0                           ; $102100
        ADD.B  (A3)+,D0                         ; $102102
        MULU    -(A3),D0                        ; $102104
        BTST    D3,(A0)+                        ; $102106
        MOVE.W  D1,-$38B8(A3)                   ; $102108
        MOVE.B  (A4),-(A6)                      ; $10210C
        DIVS    A1,D0                           ; $10210E
        AND.B  (A3)+,D0                         ; $102110
        ADDA.W  D1,A2                           ; $102112
        AND.W  D7,A0                            ; $102114
        MOVE.B  (A4)+,(A6)                      ; $102116
        DC.W    $01BD               ; $102118 BCLR    D0,<EA:3D>
        DC.W    $4C1C               ; $10211A DC.W    $4C1C
        MOVE.W  D1,-(A6)                        ; $10211C
        CMP.B  A6,D6                            ; $10211E
        MOVEA.W $74(A1,A0.W),A0                 ; $102120
        MOVEA.B -$2F(A4,A0.W),A6                ; $102124
        DC.W    $481C               ; $102128 DC.W    $481C
        SUB.B  D1,D6                            ; $10212A
        EOR.W  D6,A4                            ; $10212C
        DC.W    $1CFD               ; $10212E MOVE.B  <EA:3D>,(A6)+
        BCLR    D0,#$0E30                       ; $102130
        MOVE.W  D3,$1C(A0,D7.W)                 ; $102134
        MOVEQ   #-$7F,D2                        ; $102138
        ADD.W  D0,A0                            ; $10213A
        MOVE.B  (A4)+,(A6)                      ; $10213C
        DC.W    $01BD               ; $10213E BCLR    D0,<EA:3D>
        DC.W    $4C1C               ; $102140 DC.W    $4C1C
        MOVE.W  D1,(A2)                         ; $102142
        MULS    D0,D4                           ; $102144
        DC.W    $1BD4               ; $102146 MOVE.B  (A4),<EA:3D>
        MULS    A7,D0                           ; $102148
        ADD.B  (A3)+,D0                         ; $10214A
        MULU    -(A3),D0                        ; $10214C
        BTST    D3,(A0)+                        ; $10214E
        MOVE.W  D1,-$38B8(A3)                   ; $102150
        MOVE.B  (A4),-(A6)                      ; $102154
        DIVS    A1,D0                           ; $102156
        AND.B  (A3)+,D0                         ; $102158
        ADDA.W  D1,A2                           ; $10215A
        MULS    (A0),D7                         ; $10215C
        DC.W    $1BC0               ; $10215E MOVE.B  D0,<EA:3D>
        ASL.B  #1,D7                            ; $102160
        MOVE.B  -$39(A7,D4.W),D4                ; $102162
        DC.W    $481D               ; $102166 DC.W    $481D
        MOVE.B  D1,(A2)                         ; $102168
        MULS    D0,D4                           ; $10216A
        DC.W    $1BD4               ; $10216C MOVE.B  (A4),<EA:3D>
        MULS    A7,D0                           ; $10216E
        DC.W    $481C               ; $102170 DC.W    $481C
        SUB.B  D1,D6                            ; $102172
        EOR.W  D6,A0                            ; $102174
        DC.W    $1CFF               ; $102176 MOVE.B  <EA:3F>,(A6)+
        DIVS    (A6),D0                         ; $102178
        BSET    D6,-(A0)                        ; $10217A
        BLE.S  loc_102181                       ; $10217C
        CMP.B  (A5)+,D0                         ; $10217E
        ASR.W  $0770(A5)                        ; $102180
        MOVE.W  D1,-$29F3(A3)                   ; $102184
        LSR.W  D0,D7                            ; $102188
        BCLR    D1,-$20(A0,D1.L)                ; $10218A
        ADD.B  D6,D6                            ; $10218E
        MOVE.W  (A7)+,D1                        ; $102190
        DIVS    (A6),D0                         ; $102192
        BSET    D6,-(A0)                        ; $102194
        BLE.S  loc_10219B                       ; $102196
        CMP.B  (A3)+,D0                         ; $102198
        MOVE.L  $0770(A5),(A0)+                 ; $10219A
        MOVE.W  D1,-$29F3(A3)                   ; $10219E
        LSR.W  D0,D7                            ; $1021A2
        BCLR    D1,$60(A0,D1.L)                 ; $1021A4
        ADD.B  D6,D6                            ; $1021A8
        MOVE.W  (A7)+,D1                        ; $1021AA
        DIVS    (A6),D0                         ; $1021AC
        BSET    D6,-(A0)                        ; $1021AE
        BLE.S  loc_1021B5                       ; $1021B0
        CMP.B  (A5)+,D0                         ; $1021B2
        ASR.W  $0770(A5)                        ; $1021B4
        MOVE.W  D1,-$29F3(A3)                   ; $1021B8
        LSR.W  D0,D7                            ; $1021BC
        BCLR    D1,-$20(A0,D1.L)                ; $1021BE
        ASL.B  #6,D7                            ; $1021C2
        MOVEQ   #$1F,D1                         ; $1021C4
        DIVS    (A6),D0                         ; $1021C6
        BSET    D6,-(A0)                        ; $1021C8
        BLE.S  loc_1021CF                       ; $1021CA
        CMP.B  (A5)+,D0                         ; $1021CC
        ASR.W  (A5)+                            ; $1021CE
        DC.W    $06F0               ; $1021D0 DC.W    $06F0
        MOVE.W  D1,-$29F3(A3)                   ; $1021D2
        LSR.W  D0,D7                            ; $1021D6
        BCLR    D1,-$60(A0,D1.L)                ; $1021D8
        ASL.B  #6,D7                            ; $1021DC
        MOVEQ   #$1F,D1                         ; $1021DE
        DIVS    (A6),D0                         ; $1021E0
        BSET    D6,-(A0)                        ; $1021E2
        BLE.S  loc_1021E9                       ; $1021E4
        CMP.B  (A4)+,D0                         ; $1021E6
        BRA.S  loc_1021C7                       ; $1021E8
        DC.W    $06F0               ; $1021EA DC.W    $06F0
        MOVE.W  D1,-$29F3(A3)                   ; $1021EC
        LSR.W  D0,D7                            ; $1021F0
        BCLR    D1,-$20(A0,D1.L)                ; $1021F2
        ASL.B  #6,D7                            ; $1021F6
        MOVEQ   #$1F,D1                         ; $1021F8
        DIVS    (A6),D0                         ; $1021FA
        BSET    D6,-(A0)                        ; $1021FC
        BLE.S  $102203                          ; $1021FE
