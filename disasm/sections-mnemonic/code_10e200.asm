; Generated assembly for $10E200-$110200
; Branch targets: 127
; Labels: 126
; Format: DC.W with decoded mnemonics as comments

        org     $10E200

        MOVE.W  $42(A4,D4.W),-(A3)              ; $10E200
        MOVE.L  -(A2),(A0)+                     ; $10E204
        MOVE.W  #$CE59,-(A5)                    ; $10E206
        MOVE.W  $4255(A2),-(A3)                 ; $10E20A
        MOVEA.L D4,A5                           ; $10E20E
        DC.W    $45A2               ; $10E210 DC.W    $45A2
        OR.W   D4,$28(A5,D7.L)                  ; $10E212
        DC.W    $92FF               ; $10E216 SUBA.W  <EA:3F>,A1
        DC.W    $23ED,$F1AF,$AAE9,$F231; $10E218 MOVE.L  -$0E51(A5),$AAE9F231
        MOVE.B  (A2),-(A2)                      ; $10E220
        MOVE.L  $0B(A4,A2.L),-(A1)              ; $10E222
        LSL.L  D4,D3                            ; $10E226
        EORI.W  #$E25B,A1                       ; $10E228
        LSR.B  D1,D2                            ; $10E22C
        OR.W   D4,D5                            ; $10E22E
        DC.W    $9A3F               ; $10E230 SUB.B  <EA:3F>,D5
        MOVE.L  $65(A1,A2.L),(A6)+              ; $10E232
        SUB.W  D0,$174A(A1)                     ; $10E236
        OR.W   -$3DBC(A7),D5                    ; $10E23A
        LSR.W  -$1C(A6,A2.W)                    ; $10E23E
        MOVEQ   #$57,D2                         ; $10E242
        NEG.W  (A1)                             ; $10E244
        DC.W    $06BA,$74E1,$75BA,$E1EA; $10E246 ADDI.L  #$74E175BA,-$1E16(PC)
        ADDQ.B  #1,$15(A2,D2.W)                 ; $10E24E
        ADDQ.L  #7,$1E63(A1)                    ; $10E252
        MOVE.W  -$5E(A2,D0.W),-(A1)             ; $10E256
        ADDQ.L  #4,$25F5(A1)                    ; $10E25A
        CMP.W  A7,D5                            ; $10E25E
        MOVE.W  (A6)+,(A7)+                     ; $10E260
        CMP.L  $0F(A0,D1.W),D0                  ; $10E262
        MOVEQ   #-$46,D1                        ; $10E266
        MOVE.W  -$04(PC,A3.L),-$2245(A3)        ; $10E268
        MOVE.W  $4A(A0,A0.W),-$5235(A3)         ; $10E26E
        BNE.S  loc_10E241                       ; $10E274
        DC.W    $FBFC,$FFBA         ; $10E276 MOVE.W  #$FFBA,<EA:3D>
        EOR.L  D6,D2                            ; $10E27A
        MOVE.L  A2,(A5)+                        ; $10E27C
        MOVE.L  (A2),-$48(A4,A2.W)              ; $10E27E
        MOVE.B  -$6514(A2),-$4836(A0)           ; $10E282
        SUBA.L  A3,A3                           ; $10E288
        MOVE.W  D3,-(A5)                        ; $10E28A
        NEGX.W -$4345(A7)                       ; $10E28C
        MOVE.L  -$1D0E(A3),(A5)+                ; $10E290
        MOVE.L  (A5)+,-(A0)                     ; $10E294
        MOVE.B  -(A4),-$01(PC,A7.W)             ; $10E296
        MOVE.W  A2,D4                           ; $10E29A
        MOVEQ   #-$49,D5                        ; $10E29C
        SUBA.L  (A5)+,A6                        ; $10E29E
        MOVE.W  D0,-$40(PC,A3.W)                ; $10E2A0
        DC.W    $25F9,$F83A,$C1BD,$7D1A; $10E2A4 MOVE.L  $F83AC1BD,$7D1A(PC)
        CMPA.L  #$43682082,A4                   ; $10E2AC
        ADDA.L  $AAFC.W,A5                      ; $10E2B2
        ADD.W  D5,-(A5)                         ; $10E2B6
        DC.W    $09BD               ; $10E2B8 BCLR    D4,<EA:3D>
        MOVE.B  D4,-(A3)                        ; $10E2BA
        MOVE.W  D1,-$25(A1,A2.L)                ; $10E2BC
        MOVE.L  (A1),D6                         ; $10E2C0
        SUB.W  (A4)+,D2                         ; $10E2C2
        MOVE.W  $0015(A1),$F2CE.W               ; $10E2C4
        BCLR    D5,D1                           ; $10E2CA
        ROXL.L  D7,D2                           ; $10E2CC
        ADD.W  $D5E1FE84,D7                     ; $10E2CE
        CMPA.L  A2,A4                           ; $10E2D4
        DC.W    $91BF               ; $10E2D6 SUB.L  D0,<EA:3F>
        EOR.L  D4,-(A7)                         ; $10E2D8
        MOVE.W  D2,-$49(PC,A2.L)                ; $10E2DA
        DC.W    $D83F               ; $10E2DE ADD.B  <EA:3F>,D4
        DC.W    $ADF4,$DDF2         ; $10E2E0 MOVE.L  -$0E(A4,A5.L),<EA:3E>
        MOVE.W  (A3)+,#$DAAA                    ; $10E2E4
        MOVE.L  -$46(PC,A5.L),$40(A6,A2.W)      ; $10E2E8
        MOVE.W  -(A6),(A6)                      ; $10E2EE
        MOVE.W  -$4773(PC),$302F(A3)            ; $10E2F0
        ADD.B  D5,A6                            ; $10E2F6
        MOVE.W  (A3)+,$86B0.W                   ; $10E2F8
        MOVE.W  $2A(A7,D0.W),-$1D(A3,A5.L)      ; $10E2FC
        MULS    -$4EC8(A6),D4                   ; $10E302
        MOVEA.B (A4),A1                         ; $10E306
        SUBQ.L  #2,$1E(PC,D7.W)                 ; $10E308
        MOVE.L  (A7),-$0E4F(A0)                 ; $10E30C
        LSR.L  D1,D5                            ; $10E310
        ROXR.B  #4,D4                           ; $10E312
        SLT     -$57(A1,A6.L)                   ; $10E314
        SUBQ.W  #2,A1                           ; $10E318
        MOVE.W  -(A1),-$27(A7,D1.W)             ; $10E31A
        ADDQ.L  #8,D1                           ; $10E31E
        NEG.L  D3                               ; $10E320
        OR.L   D2,$14BF(A0)                     ; $10E322
        BLT.S  loc_10E393                       ; $10E326
        DC.W    $0D8B               ; $10E328 BCLR    D6,A3
        MOVE.L  D4,(A0)                         ; $10E32A
        DC.W    $00E7               ; $10E32C DC.W    $00E7
        DC.W    $25FF,$5255         ; $10E32E MOVE.L  <EA:3F>,$5255(PC)
        BSET    D5,-(A1)                        ; $10E332
        BPL.S  loc_10E356                       ; $10E334
        MOVE.W  A3,(A5)                         ; $10E336
        MOVE.L  -(A4),(A5)+                     ; $10E338
        SUB.B  D4,D1                            ; $10E33A
        MOVE.L  (A2),-$0F0A(A0)                 ; $10E33C
        MOVE.W  (A0)+,-(A7)                     ; $10E340
        MOVE.L  (A2)+,(A5)+                     ; $10E342
        MOVE.W  -(A5),-(A1)                     ; $10E344
        SUB.B  -(A2),D1                         ; $10E346
        MOVE.L  (A1)+,(A1)                      ; $10E348
        ROXL.W  #8,D2                           ; $10E34A
        SUB.L  D2,$5AE0(A7)                     ; $10E34C
        DC.W    $4725               ; $10E350 DC.W    $4725
        MOVE.B  #$A99F,-$6580(A2)               ; $10E352
        ROL.L  D4,D4                            ; $10E358
        ROXL.W  #4,D1                           ; $10E35A
        BNE.S  loc_10E307                       ; $10E35C
        ADDQ.B  #8,D1                           ; $10E35E
        MOVE.W  D4,D7                           ; $10E360
        MOVE.L  (A1)+,D4                        ; $10E362
        MULU    (A3)+,D6                        ; $10E364
        NEG    #$5D2A                           ; $10E366
        BVC.S  loc_10E2F4                       ; $10E36A
        DC.W    $4592               ; $10E36C DC.W    $4592
        BSR.S  loc_10E396                       ; $10E36E
        MOVE.W  $51A9.W,$6249.W                 ; $10E370
        SUBQ.L  #3,(A0)                         ; $10E376
        SF      $CCE1B06D                       ; $10E378
        BVS.S  loc_10E3D2                       ; $10E37E
        ADDA.L  -$26(A1,D1.W),A2                ; $10E380
        MOVE.L  (A2)+,$BBF8.W                   ; $10E384
        DC.W    $0CE1               ; $10E388 DC.W    $0CE1
        MOVE.W  -$05(A7,A3.L),-$5446(A0)        ; $10E38A
        SUBQ.B  #2,(A5)                         ; $10E390
        MOVE.W  $73(PC,A6.W),$1CD9(A5)          ; $10E392
        MOVE.L  (A2)+,(A2)+                     ; $10E398
        ROXL.W  D0,D1                           ; $10E39A
        MOVE.L  (A2)+,(A0)+                     ; $10E39C
        CMPA.W  -(A1),A4                        ; $10E39E
        BRA.S  loc_10E3F6                       ; $10E3A0
        MOVE.W  -$49(A0,D7.W),(A6)+             ; $10E3A2
        MOVE.W  D0,D6                           ; $10E3A6
        ADD.B  (A0),D4                          ; $10E3A8
        DC.W    $47AC               ; $10E3AA DC.W    $47AC
        DC.W    $4121               ; $10E3AC DC.W    $4121
        ROXR.L  D0,D0                           ; $10E3AE
        DC.W    $12FD               ; $10E3B0 MOVE.B  <EA:3D>,(A1)+
        ROXR.L  D0,D3                           ; $10E3B2
        ADDQ.L  #1,$7D(A2,A4.W)                 ; $10E3B4
        LSR.W  -(A0)                            ; $10E3B8
        MOVE.L  (A2),(A6)                       ; $10E3BA
        CMP.L  -(A4),D1                         ; $10E3BC
        MOVE.W  (A3)+,$AAC11B71                 ; $10E3BE
        AND.B  D5,(A7)                          ; $10E3C4
        MULS    (A5)+,D4                        ; $10E3C6
        MULU    A2,D6                           ; $10E3C8
        AND.W  $E1DF.W,D5                       ; $10E3CA
        CMP.L  D3,D6                            ; $10E3CE
        ASR.B  #6,D1                            ; $10E3D0
loc_10E3D2:
        DC.W    $C07D               ; $10E3D2 AND.W  <EA:3D>,D0
        MOVE.L  -$2C56(A7),-$59(A5,A6.W)        ; $10E3D4
        BSET    D5,$25(A6,D3.W)                 ; $10E3DA
        NEG    A2                               ; $10E3DE
        MOVE.W  #$F991,$355E.W                  ; $10E3E0
        EOR.B  D0,$2A(A5,D4.W)                  ; $10E3E6
        MOVEA.L (A2),A4                         ; $10E3EA
        MOVE.L  A1,(A3)                         ; $10E3EC
        BPL.S  loc_10E439                       ; $10E3EE
        ADDQ.W  #1,A1                           ; $10E3F0
        BCLR    D7,$26(A7,A7.W)                 ; $10E3F2
loc_10E3F6:
        MOVE.W  -(A2),-$3B(A0,D0.W)             ; $10E3F6
        MOVE.W  $7D(A4,A6.W),D6                 ; $10E3FA
        BVS.S  loc_10E387                       ; $10E3FE
        BSET    #29,#$9CED                      ; $10E400
        SUBA.W  D7,A4                           ; $10E406
        DC.W    $00FC               ; $10E408 DC.W    $00FC
        ADDA.L  -$125D(A6),A6                   ; $10E40A
        EOR.L  D3,D6                            ; $10E40E
        MOVE.B  D3,-$33(A0,A2.L)                ; $10E410
        MOVEQ   #-$74,D7                        ; $10E414
        MOVE.L  A6,-$5C(A5,D0.W)                ; $10E416
        BSET    #30,$14(A2,A0.W)                ; $10E41A
        MOVEA.B (A5),A1                         ; $10E420
        ADDQ.W  #8,-(A0)                        ; $10E422
        MOVE.W  (A2),D4                         ; $10E424
        AND.W  D6,-(A0)                         ; $10E426
        MOVE.W  A1,D4                           ; $10E428
        MULU    (A0)+,D3                        ; $10E42A
        BSET    D7,#$F1FC                       ; $10E42C
        CMPA.L  -$7C97(A1),A3                   ; $10E430
        MOVE.B  -(A0),(A4)                      ; $10E434
        DIVU    (A3)+,D5                        ; $10E436
        CMP.W  (A2),D5                          ; $10E438
        MOVE.L  -$36(A4,A2.L),(A0)              ; $10E43A
        MOVE.L  $1BAE.W,(A0)+                   ; $10E43E
        SUB.L  A0,D2                            ; $10E442
        MOVE.L  (A1),(A3)+                      ; $10E444
        DC.W    $ABF1,$FFD2         ; $10E446 MOVE.L  -$2E(A1,A7.L),<EA:3D>
        ROL.B  D2,D3                            ; $10E44A
        EOR.L  D1,$28FA(A2)                     ; $10E44C
        DC.W    $47B2               ; $10E450 DC.W    $47B2
        MOVE.L  -$5D(A7,D2.W),$0B(A4,A1.L)      ; $10E452
        LSL.B  D6,D6                            ; $10E458
        MOVE.L  D1,(A1)                         ; $10E45A
        MOVE.L  -$040C(PC),(A5)+                ; $10E45C
        MOVE.W  (A0),(A6)                       ; $10E460
        ASR.L  #2,D5                            ; $10E462
        ROXR.L  #1,D5                           ; $10E464
        DC.W    $0EAA               ; $10E466 DC.W    $0EAA
        OR.L   -(A3),D5                         ; $10E468
        ADDA.L  #$A4AC00B2,A3                   ; $10E46A
        DC.W    $E4FE               ; $10E470 ROXR.W  <EA:3E>
loc_10E472:
        MOVE.L  -$58(A3,A4.L),(A7)              ; $10E472
        MOVE.W  D2,-(A4)                        ; $10E476
        DC.W    $B27D               ; $10E478 CMP.W  <EA:3D>,D1
        DC.W    $AABE               ; $10E47A MOVE.L  <EA:3E>,(A5)
        MOVE.W  D7,(A7)+                        ; $10E47C
        MOVE.L  D2,D5                           ; $10E47E
        MOVE.L  $09EB(PC),D1                    ; $10E480
        DC.W    $ABDF               ; $10E484 MOVE.L  (A7)+,<EA:3D>
        MULS    -$51(PC,A2.L),D6                ; $10E486
        MOVE.W  $06(A7,A2.L),(A3)+              ; $10E48A
        DC.W    $0A38,$B931,$8811   ; $10E48E EORI.B  #$B931,$8811.W
        MOVE.W  -(A4),-$79(A1,D7.W)             ; $10E494
        ASL.B  D0,D0                            ; $10E498
        AND.B  D0,$47(A1,D1.W)                  ; $10E49A
        MOVE.W  (A4),$44F6(A6)                  ; $10E49E
        MOVE.W  $0A(A4,A5.L),$15FC(A3)          ; $10E4A2
        MOVE.B  $E957.W,-$4F(A3,D1.L)           ; $10E4A8
        MOVE.W  $16(A1,A2.L),-(A4)              ; $10E4AE
        MOVE.W  (A5),D6                         ; $10E4B2
        BSR.S  loc_10E472                       ; $10E4B4
        DC.W    $E6FE               ; $10E4B6 ROR.W  <EA:3E>
        ASR.B  #3,D1                            ; $10E4B8
        DC.W    $45FF               ; $10E4BA LEA     <EA:3F>,A2
        MOVE.W  A4,D4                           ; $10E4BC
        DC.W    $47B4               ; $10E4BE DC.W    $47B4
        SUBQ.W  #8,(A5)                         ; $10E4C0
        SNE     -(A5)                           ; $10E4C2
        ROL.W  #4,D1                            ; $10E4C4
        SUB.W  D1,-$6395(A5)                    ; $10E4C6
        MOVE.W  (A2),-$36(A1,A0.W)              ; $10E4CA
        MOVE.W  A1,(A5)+                        ; $10E4CE
        MOVE.W  -(A7),-(A7)                     ; $10E4D0
        SLS     -(A5)                           ; $10E4D2
        MOVE.W  A3,$4592(A5)                    ; $10E4D4
        MOVE.L  $55(A3,D4.W),-(A1)              ; $10E4D8
        SUB.B  -(A2),D1                         ; $10E4DC
        ADD.L  D6,D4                            ; $10E4DE
        MOVE.W  (A1)+,-$66CE(A3)                ; $10E4E0
        DC.W    $4948               ; $10E4E4 DC.W    $4948
        MOVEQ   #$69,D0                         ; $10E4E6
        SUBA.L  (A1)+,A1                        ; $10E4E8
        DC.W    $1FEA,$5935         ; $10E4EA MOVE.B  $5935(A2),<EA:3F>
        MOVEQ   #$55,D2                         ; $10E4EE
        SUB.B  D4,-$6D(A5,A6.L)                 ; $10E4F0
        BGE.S  loc_10E558                       ; $10E4F4
        DC.W    $2DCA               ; $10E4F6 MOVE.L  A2,<EA:3E>
        DC.W    $22BF               ; $10E4F8 MOVE.L  <EA:3F>,(A1)
        MOVE.W  -(A2),-(A3)                     ; $10E4FA
        ADDQ.W  #2,D2                           ; $10E4FC
        MOVE.L  $42(A5,D4.W),-(A2)              ; $10E4FE
        ADDA.W  A2,A7                           ; $10E502
        ADDQ.W  #1,(A5)                         ; $10E504
        LEA     (A0)+,A2                        ; $10E506
        EOR.B  D4,-(A5)                         ; $10E508
        MOVE.L  (A5),-$7A25(A1)                 ; $10E50A
        ADD.L  $45(A4,A0.W),D1                  ; $10E50E
        ROXR.L  #1,D1                           ; $10E512
        DC.W    $21BC,$811D,$A2EE,$1140; $10E514 MOVE.L  #$811DA2EE,$40(A0,D1.W)
        MOVE.B  D5,-$0008(A0)                   ; $10E51C
        MOVE.W  -(A5),$15(A3,A0.W)              ; $10E520
        DC.W    $49B5               ; $10E524 DC.W    $49B5
        LEA     -$193A(A7),A6                   ; $10E526
        OR.W   D4,$6A625A5C                     ; $10E52A
        BCHG    #2,-$36(PC,A0.W)                ; $10E530
        AND.B  -(A4),D4                         ; $10E536
        DC.W    $4192               ; $10E538 DC.W    $4192
        MOVEA.L (A4),A6                         ; $10E53A
        SUB.B  (A1),D4                          ; $10E53C
        LEA     D7,A4                           ; $10E53E
        MOVE.L  D1,$63(A5,D4.W)                 ; $10E540
        LSR.W  -$251B(A1)                       ; $10E544
        MOVE.W  $5C(A1,D5.W),(A6)               ; $10E548
        MOVE.W  -$41B3(A5),-$50(A2,A0.W)        ; $10E54C
        SUB.B  $31(A5,A5.W),D5                  ; $10E552
        DBEQ    D2,$112F22                      ; $10E556
        MOVE.L  D1,$3115(A2)                    ; $10E55A
        BCHG    D6,-(A1)                        ; $10E55E
        DC.W    $3DE9,$31F3         ; $10E560 MOVE.W  $31F3(A1),<EA:3E>
        DC.W    $4153               ; $10E564 DC.W    $4153
        BPL.S  loc_10E59A                       ; $10E566
        AND.B  -(A2),D2                         ; $10E568
        MOVE.L  D4,-(A2)                        ; $10E56A
        MOVE.B  $72(A3,A7.W),-$3E3C(A0)         ; $10E56C
        OR.W   D6,D2                            ; $10E572
        MOVEA.L -(A0),A6                        ; $10E574
        NEG    D5                               ; $10E576
        MOVE.L  $6115(A5),$15(A0,A7.W)          ; $10E578
        ORI.L  #$8809FFFC,A0                    ; $10E57E
        DC.W    $00F0               ; $10E584 DC.W    $00F0
        DC.W    $0000,$0000         ; $10E586 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $10E58A ORI.B  #$0000,D0
        DC.W    $0017,$8076         ; $10E58E ORI.B  #$8076,(A7)
        MOVE.W  D1,(A6)                         ; $10E592
        BTST    D1,D1                           ; $10E594
        MOVE.B  A0,D2                           ; $10E596
        MOVE.L  $3D(A7,D3.W),D3                 ; $10E598
        MOVEM.L $0014(PC),D0/D1/A1/A7           ; $10E59C
        SUBI.B  #$1235,-(A5)                    ; $10E5A2
        MOVE.B  D5,$1755(A6)                    ; $10E5A6
        MOVEA.B -$048C(A0),A4                   ; $10E5AA
        BCLR    D3,D3                           ; $10E5AE
        SUBI.B  #$1405,D6                       ; $10E5B0
        MOVE.L  $3516.W,D3                      ; $10E5B4
        DC.W    $4519               ; $10E5B8 DC.W    $4519
        ADDQ.B  #3,$640A7636                    ; $10E5BA
loc_10E5C0:
        OR.B   A0,D2                            ; $10E5C0
        MOVE.W  -$067B(A0),D4                   ; $10E5C2
        BTST    D2,(A3)                         ; $10E5C6
        OR.B   D5,D3                            ; $10E5C8
        DC.W    $1AFF               ; $10E5CA MOVE.B  <EA:3F>,(A5)+
        MOVE.W  A7,$3CF3CF3C                    ; $10E5CC
        DC.W    $FABE               ; $10E5D2 MOVE.W  <EA:3E>,(A5)
        ROR.W  -$0082(A6)                       ; $10E5D4
        ADDA.L  -$1AF8(A1),A7                   ; $10E5D8
        ADDQ.B  #1,(A6)+                        ; $10E5DC
        ASR.W  #3,D5                            ; $10E5DE
        MOVE.L  -(A7),(A1)+                     ; $10E5E0
        MOVE.B  A0,D0                           ; $10E5E2
        OR.W   D3,-$6C(A7,D7.W)                 ; $10E5E4
        DC.W    $08BF,$B787         ; $10E5E8 BCLR    #7,<EA:3F>
        DC.W    $7779,$177B,$C214,$3F95; $10E5EC MOVE.W  $177BC214,$3F95(A3)
        MOVE.W  (A7)+,(A4)                      ; $10E5F4
        ASL.B  D6,D7                            ; $10E5F6
        AND.W  D3,-(A7)                         ; $10E5F8
        AND.W  D3,-(A7)                         ; $10E5FA
        BCC.S  loc_10E667                       ; $10E5FC
        ADDA.W  $7C89(A2),A2                    ; $10E5FE
        CMPA.W  A7,A0                           ; $10E602
        ROL.W  D6,D7                            ; $10E604
        BVC.S  loc_10E5E7                       ; $10E606
        BPL.S  loc_10E624                       ; $10E608
        MOVE.W  (A6),(A3)                       ; $10E60A
        BCS.S  loc_10E5CE                       ; $10E60C
        MOVE.L  $27(A5,A3.L),-$04(A0,A7.W)      ; $10E60E
        SMI     $30(A1,D7.L)                    ; $10E614
        MOVE.L  $6EDB(A7),$1C(A0,A3.L)          ; $10E618
        MOVEQ   #-$01,D6                        ; $10E61E
        MOVE.B  D1,(A3)+                        ; $10E620
        MOVE.W  -(A0),-$45B0(A2)                ; $10E622
        AND.W  D0,-$53(A5,D5.L)                 ; $10E626
        BLT.S  loc_10E5C0                       ; $10E62A
        BLE.S  loc_10E5CD                       ; $10E62C
        ADD.L  $51(A0,A3.W),D1                  ; $10E62E
        BRA.S  loc_10E5D5                       ; $10E632
        DC.W    $4305               ; $10E634 DC.W    $4305
        MOVE.B  $50C8(A0),D2                    ; $10E636
        BEQ.S  loc_10E5CD                       ; $10E63A
        DC.W    $42FD               ; $10E63C CLR    <EA:3D>
        MOVEA.L -$7C(A1,A6.L),A4                ; $10E63E
        MOVE.W  A2,(A7)                         ; $10E642
        BGT.S  loc_10E668                       ; $10E644
        MOVE.W  -$3BF3(A5),-(A0)                ; $10E646
        AND.B  -(A1),D2                         ; $10E64A
        MOVE.B  (A2),-$0071(A7)                 ; $10E64C
        MOVEA.W D6,A2                           ; $10E650
        LSL.W  (A1)                             ; $10E652
        MOVE.W  (A5)+,-(A7)                     ; $10E654
        MOVE.W  (A0)+,-(A5)                     ; $10E656
        DC.W    $DEFE               ; $10E658 ADDA.W  <EA:3E>,A7
        AND.W  D5,-$45(A0,D6.W)                 ; $10E65A
        MOVEA.L (A7)+,A2                        ; $10E65E
        MOVE.W  (A4),$1D(A5,D2.L)               ; $10E660
        MOVE.L  -$36(A0,D7.L),D1                ; $10E664
loc_10E668:
        MOVE.B  $29(A7,D4.W),-$4F34(A3)         ; $10E668
        ROR.W  D5,D1                            ; $10E66E
        DC.W    $0D3E               ; $10E670 BTST    D6,<EA:3E>
        BTST    D1,D6                           ; $10E672
loc_10E674:
        SUB.W  D6,A6                            ; $10E674
        MOVE.L  (A3),-$00CB(A3)                 ; $10E676
        DC.W    $0E52               ; $10E67A DC.W    $0E52
        AND.L  D1,A1                            ; $10E67C
        ST      (A3)+                           ; $10E67E
        BGE.L  $DB7E9D2B                        ; $10E680
        ADDQ.W  #4,$36FD(A4)                    ; $10E686
        DC.W    $337E,$D828         ; $10E68A MOVE.W  <EA:3E>,-$27D8(A1)
        ASL.W  #1,D3                            ; $10E68E
        SUB.W  D6,(A6)                          ; $10E690
        CMP.L  $2674(A5),D3                     ; $10E692
        DC.W    $C33F               ; $10E696 AND.B  D1,<EA:3F>
        MOVE.W  (A0),(A3)+                      ; $10E698
        SF      D2                              ; $10E69A
        MOVEQ   #$28,D1                         ; $10E69C
        ADDQ.L  #8,$64B0(A1)                    ; $10E69E
        DC.W    $B03F               ; $10E6A2 CMP.B  <EA:3F>,D0
        ADD.W  -(A3),D3                         ; $10E6A4
        DIVS    D2,D2                           ; $10E6A6
        ROXL.W  D0,D0                           ; $10E6A8
        MOVEA.L -(A4),A4                        ; $10E6AA
        CMP.W  (A4)+,D4                         ; $10E6AC
        MOVE.L  -(A1),D6                        ; $10E6AE
        EORI.W  #$A2F4,(A0)                     ; $10E6B0
        DIVS    D2,D2                           ; $10E6B4
        ASL.W  #8,D1                            ; $10E6B6
        LSR.W  -(A1)                            ; $10E6B8
        MOVEQ   #-$43,D0                        ; $10E6BA
        MOVE.L  -$06(A5,A7.W),-$50(A0,D5.L)     ; $10E6BC
        BCC.S  loc_10E674                       ; $10E6C2
        BCC.S  loc_10E716                       ; $10E6C4
        AND.L  D0,(A3)                          ; $10E6C6
        SUBA.W  -(A5),A2                        ; $10E6C8
        MOVE.W  A4,-$0ABE(A4)                   ; $10E6CA
        AND.B  D5,-$358E(A1)                    ; $10E6CE
        SUBA.W  -$50(A6,A4.W),A6                ; $10E6D2
        DC.W    $B47F               ; $10E6D6 CMP.W  <EA:3F>,D2
        ADDQ.B  #4,(A0)                         ; $10E6D8
        OR.B   A1,D0                            ; $10E6DA
        OR.B   (A4),D0                          ; $10E6DC
        BCHG    #18,(A2)                        ; $10E6DE
        ORI.L  #$14098214,D1                    ; $10E6E2
        CMPI.L  #$140A8414,D3                   ; $10E6E8
        BCLR    D6,D5                           ; $10E6EE
        MOVE.B  A6,D2                           ; $10E6F0
        OR.B   (A5),D3                          ; $10E6F2
        MOVE.B  D7,(A7)                         ; $10E6F4
        MOVE.B  A3,D2                           ; $10E6F6
        OR.B   (A6),D4                          ; $10E6F8
        DC.W    $3EFF               ; $10E6FA MOVE.W  <EA:3F>,(A7)+
        DC.W    $0000,$891A         ; $10E6FC ORI.B  #$891A,D0
        MOVE.B  (A3)+,-(A4)                     ; $10E700
        MOVE.B  (A2)+,-(A4)                     ; $10E702
        MOVE.B  (A7)+,-(A4)                     ; $10E704
        AND.L  D7,A7                            ; $10E706
        MULS    $272B(A4),D3                    ; $10E708
        LEA     A2,A4                           ; $10E70C
        ADD.B  D3,D0                            ; $10E70E
        DC.W    $BD7F               ; $10E710 EOR.W  D6,<EA:3F>
        DC.W    $1DEB,$F800         ; $10E712 MOVE.B  -$0800(A3),<EA:3E>
loc_10E716:
        BCLR    #15,$248D(A4)                   ; $10E716
        DC.W    $01BF               ; $10E71C BCLR    D0,<EA:3F>
        MOVE.W  (A7)+,-(A0)                     ; $10E71E
        SUBA.L  -$07(A7,D1.W),A7                ; $10E720
        DC.W    $91FD               ; $10E724 SUBA.L  <EA:3D>,A0
        SUB.L  (A1),D7                          ; $10E726
        SUB.L  D2,-(A0)                         ; $10E728
        DC.W    $470D               ; $10E72A DC.W    $470D
        SLE     D4                              ; $10E72C
        MOVEQ   #-$02,D5                        ; $10E72E
        DC.W    $0000,$00A7         ; $10E730 ORI.B  #$00A7,D0
        DC.W    $0039,$0093,$0000,$0842; $10E734 ORI.B  #$0093,$00000842
        MOVE.B  -(A7),(A6)+                     ; $10E73C
        DC.W    $3DEF,$4210         ; $10E73E MOVE.W  $4210(A7),<EA:3E>
        MOVE.L  $0C63(A1),-(A2)                 ; $10E742
        MOVE.W  A6,#$2108                       ; $10E746
        MOVE.L  A2,$35AD(A4)                    ; $10E74A
        RTE                                     ; $10E74E
        ADDQ.L  #3,-$2A(A5,D5.L)                ; $10E750
        MOVE.B  -(A5),(A2)                      ; $10E754
        ADDQ.L  #1,(A4)                         ; $10E756
        BLE.S  loc_10E7D5                       ; $10E758
        DC.W    $7FFF               ; $10E75A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $77BD,$18C6         ; $10E75C MOVE.W  <EA:3D>,-$3A(A3,D1.L)
        MOVE.L  $5EF7(A3),$6739(A6)             ; $10E760
        MOVE.B  D4,(A0)                         ; $10E766
        MOVE.W  A4,$5A(A0,D6.L)                 ; $10E768
        DC.W    $7BDE               ; $10E76C MOVE.W  (A6)+,<EA:3D>
        MOVE.W  (A4)+,$52(A1,D4.L)              ; $10E76E
        DC.W    $7FFC,$7FFD         ; $10E772 MOVE.W  #$7FFD,<EA:3F>
        DC.W    $7FFB,$7F31         ; $10E776 MOVE.W  $31(PC,D7.L),<EA:3F>
        MOVEQ   #-$75,D5                        ; $10E77A
        MOVEQ   #-$75,D3                        ; $10E77C
        MOVE.W  $18(A2,D6.W),-(A7)              ; $10E77E
        DC.W    $7FDA               ; $10E782 MOVE.W  (A2)+,<EA:3F>
        MOVE.W  (A0)+,$69(A7,D7.W)              ; $10E784
        MOVEQ   #$6A,D3                         ; $10E788
        MOVE.W  (A6),$69(A7,D7.L)               ; $10E78A
        MOVEQ   #-$54,D5                        ; $10E78E
        DC.W    $7FB9,$7F54,$7ECE,$7F76; $10E790 MOVE.W  $7F547ECE,$76(A7,D7.L)
        MOVEQ   #$46,D3                         ; $10E798
        MOVEQ   #$04,D3                         ; $10E79A
        MOVEQ   #$04,D1                         ; $10E79C
        MOVE.W  $7F33.W,$47(A7,D7.W)            ; $10E79E
        MOVEQ   #$26,D3                         ; $10E7A4
        MOVEQ   #-$33,D7                        ; $10E7A6
        MOVEQ   #$24,D3                         ; $10E7A8
        MOVEQ   #$68,D5                         ; $10E7AA
        MOVEQ   #-$32,D5                        ; $10E7AC
        MOVEQ   #-$54,D7                        ; $10E7AE
        MOVE.W  (A2),-(A7)                      ; $10E7B0
        MOVEQ   #$25,D3                         ; $10E7B2
        MOVEQ   #$25,D1                         ; $10E7B4
        MOVEQ   #-$11,D7                        ; $10E7B6
        MOVEQ   #-$75,D7                        ; $10E7B8
        DC.W    $7FD9               ; $10E7BA MOVE.W  (A1)+,<EA:3F>
        MOVEQ   #-$53,D7                        ; $10E7BC
        MOVEQ   #-$76,D5                        ; $10E7BE
        MOVE.W  (A3),$7F11(A7)                  ; $10E7C0
        MOVEQ   #$68,D3                         ; $10E7C4
        MOVE.W  (A7),$55(A7,D7.L)               ; $10E7C6
        MOVEQ   #-$12,D7                        ; $10E7CA
        MOVEQ   #-$76,D3                        ; $10E7CC
        MOVE.W  (A0),-(A7)                      ; $10E7CE
        MOVEQ   #-$33,D5                        ; $10E7D0
        MOVEQ   #-$34,D5                        ; $10E7D2
        MOVEQ   #$26,D1                         ; $10E7D4
        BGT.S  loc_10E7DC                       ; $10E7D6
        BGT.S  loc_10E7FF                       ; $10E7D8
        MOVEQ   #-$54,D3                        ; $10E7DA
loc_10E7DC:
        MOVEQ   #-$53,D5                        ; $10E7DC
        MOVEQ   #$46,D1                         ; $10E7DE
        MOVEQ   #$24,D1                         ; $10E7E0
        BGT.S  loc_10E7E7                       ; $10E7E2
loc_10E7E4:
        BLT.S  loc_10E7C9                       ; $10E7E4
        MOVEQ   #-$10,D7                        ; $10E7E6
        MOVE.W  $03(A7,D7.W),$27(A7,D7.W)       ; $10E7E8
        MOVE.W  -(A3),$7205.W                   ; $10E7EE
        DC.W    $7FFE               ; $10E7F2 MOVE.W  <EA:3E>,<EA:3F>
loc_10E7F4:
        MOVE.W  $48(A5,D7.W),$7FFA(A7)          ; $10E7F4
loc_10E7FA:
        MOVEQ   #-$55,D7                        ; $10E7FA
        MOVE.W  (A2),$7AAB(A7)                  ; $10E7FC
        MOVE.W  -$1C(A4,D6.L),$7ECC(A7)         ; $10E800
        MOVEQ   #$47,D1                         ; $10E806
        MOVE.W  A7,-(A7)                        ; $10E808
        MOVE.W  (A5),-$77(A7,D7.L)              ; $10E80A
        MOVEQ   #$27,D1                         ; $10E80E
        BLT.S  loc_10E7F4                       ; $10E810
        MOVE.W  -(A2),$7EAA.W                   ; $10E812
        MOVEQ   #$45,D3                         ; $10E816
        MOVE.W  $02(A0,D7.W),-(A7)              ; $10E818
        MOVEQ   #$67,D3                         ; $10E81C
        DC.W    $7FDB               ; $10E81E MOVE.W  (A3)+,<EA:3F>
        BLT.S  loc_10E7E4                       ; $10E820
        MOVE.W  -(A4),$7605.W                   ; $10E822
        NOT.B  -$3E(A1,D7.W)                    ; $10E826
        MOVE.W  D3,$69C2.W                      ; $10E82A
        BLT.S  loc_10E7F3                       ; $10E82E
        BGT.S  loc_10E837                       ; $10E830
        BVS.S  loc_10E7F7                       ; $10E832
        MOVEQ   #$48,D1                         ; $10E834
        BVS.S  loc_10E81B                       ; $10E836
        MOVEQ   #-$31,D5                        ; $10E838
        MOVEQ   #-$11,D5                        ; $10E83A
        MOVEQ   #-$31,D7                        ; $10E83C
        MOVEQ   #$69,D1                         ; $10E83E
        BVS.S  loc_10E803                       ; $10E840
        DC.W    $7FD8               ; $10E842 MOVE.W  (A0)+,<EA:3F>
        BVS.S  loc_10E828                       ; $10E844
        DC.W    $7FD7               ; $10E846 MOVE.W  (A7),<EA:3F>
        BLT.S  loc_10E82B                       ; $10E848
        MOVEQ   #-$13,D7                        ; $10E84A
        MOVEQ   #-$56,D5                        ; $10E84C
        BLT.S  loc_10E811                       ; $10E84E
        BVS.S  loc_10E7F3                       ; $10E850
        BLT.S  loc_10E7F6                       ; $10E852
        MOVEQ   #-$74,D7                        ; $10E854
        BVS.S  loc_10E7FA                       ; $10E856
        BLT.S  loc_10E7FB                       ; $10E858
        MOVEQ   #$06,D1                         ; $10E85A
        SUBI.B  #$0001,-(A1)                    ; $10E85C
        MOVE.W  D0,-(A7)                        ; $10E860
        MOVE.W  D0,-(A7)                        ; $10E862
        DC.W    $0001,$FF00         ; $10E864 ORI.B  #$FF00,D1
        MOVE.W  D0,-(A7)                        ; $10E868
        DC.W    $0001,$FF00         ; $10E86A ORI.B  #$FF00,D1
        MOVE.W  D0,-(A7)                        ; $10E86E
        DC.W    $0018,$6600         ; $10E870 ORI.B  #$6600,(A0)+
        MOVE.B  D1,D4                           ; $10E874
        BTST    D2,D0                           ; $10E876
        MOVE.B  D1,-(A5)                        ; $10E878
        BTST    D2,D0                           ; $10E87A
        MOVE.B  D1,D5                           ; $10E87C
        DC.W    $0A00,$0101         ; $10E87E EORI.B  #$0101,D0
        DC.W    $0002,$0003         ; $10E882 ORI.B  #$0003,D2
        BTST    D0,D4                           ; $10E886
        DC.W    $0003,$0005         ; $10E888 ORI.B  #$0005,D3
        DC.W    $0006,$0001         ; $10E88C ORI.B  #$0001,D6
        ADDI.B  #$0507,D0                       ; $10E890
        DC.W    $0008,$0000         ; $10E894 ORI.B  #$0000,A0
        DC.W    $0007,$0009         ; $10E898 ORI.B  #$0009,D7
        DC.W    $0200,$0006         ; $10E89C ANDI.B  #$0006,D0
        DC.W    $000A,$5100         ; $10E8A0 ORI.B  #$5100,A2
        DC.W    $002D,$6300,$0106   ; $10E8A4 ORI.B  #$6300,$0106(A5)
        DC.W    $0002,$0003         ; $10E8AA ORI.B  #$0003,D2
        DC.W    $000B,$000C         ; $10E8AE ORI.B  #$000C,A3
        MOVE.B  A5,D2                           ; $10E8B2
        DC.W    $0004,$0006         ; $10E8B4 ORI.B  #$0006,D4
        DC.W    $0200,$000E         ; $10E8B8 ANDI.B  #$000E,D0
        DC.W    $0009,$000B         ; $10E8BC ORI.B  #$000B,A1
        DC.W    $000F,$180D         ; $10E8C0 ORI.B  #$180D,A7
        DC.W    $000F,$000E         ; $10E8C4 ORI.B  #$000E,A7
        DC.W    $0200,$0006         ; $10E8C8 ANDI.B  #$0006,D0
        DC.W    $0002,$0003         ; $10E8CC ORI.B  #$0003,D2
        DC.W    $000C,$170D         ; $10E8D0 ORI.B  #$170D,A4
        DC.W    $000F,$0006         ; $10E8D4 ORI.B  #$0006,A7
        BTST    #14,D0                          ; $10E8D8
        DC.W    $0004,$000D         ; $10E8DC ORI.B  #$000D,D4
        DC.W    $0010,$0311         ; $10E8E0 ORI.B  #$0311,(A0)
        DC.W    $0012,$000D         ; $10E8E4 ORI.B  #$000D,(A2)
        DC.W    $000B,$0013         ; $10E8E8 ORI.B  #$0013,A3
        DC.W    $0001,$0400         ; $10E8EC ORI.B  #$0400,D1
        BTST    D2,(A1)                         ; $10E8F0
        DC.W    $000C,$0000         ; $10E8F2 ORI.B  #$0000,A4
        BTST    D0,(A1)                         ; $10E8F6
        DC.W    $0014,$0100         ; $10E8F8 ORI.B  #$0100,(A4)
        DC.W    $0015,$0011         ; $10E8FC ORI.B  #$0011,(A5)
        SUBQ.B  #8,D0                           ; $10E900
        DC.W    $002A,$6200,$0013   ; $10E902 ORI.B  #$6200,$0013(A2)
        DC.W    $000A,$0016         ; $10E908 ORI.B  #$0016,A2
        DC.W    $0012,$1711         ; $10E90C ORI.B  #$1711,(A2)
        DC.W    $0010,$0006         ; $10E910 ORI.B  #$0006,(A0)
        DC.W    $0000,$0017         ; $10E914 ORI.B  #$0017,D0
        DC.W    $0018,$0019         ; $10E918 ORI.B  #$0019,(A0)+
        DC.W    $001A,$1B11         ; $10E91C ORI.B  #$1B11,(A2)+
        DC.W    $0005,$0000         ; $10E920 ORI.B  #$0000,D5
        DC.W    $0001,$0002         ; $10E924 ORI.B  #$0002,D1
        DC.W    $000D,$0012         ; $10E928 ORI.B  #$0012,A5
        MOVE.B  (A1),D5                         ; $10E92C
        DC.W    $000E,$0600         ; $10E92E ORI.B  #$0600,A6
        DC.W    $000E,$000A         ; $10E932 ORI.B  #$000A,A6
        DC.W    $0010,$0911         ; $10E936 ORI.B  #$0911,(A0)
        DC.W    $001B,$0004         ; $10E93A ORI.B  #$0004,(A3)+
        DC.W    $000E,$0300         ; $10E93E ORI.B  #$0300,A6
        DC.W    $0108               ; $10E942 BTST    D0,A0
        DC.W    $000D,$0011         ; $10E944 ORI.B  #$0011,A5
        DC.W    $0005,$0008         ; $10E948 ORI.B  #$0008,D5
        DC.W    $0017,$0000         ; $10E94C ORI.B  #$0000,(A7)
        DC.W    $0211,$0008         ; $10E950 ANDI.B  #$0008,(A1)
        DC.W    $0016,$0111         ; $10E954 ORI.B  #$0111,(A6)
        SUBQ.B  #8,D0                           ; $10E958
        DC.W    $001F,$6000         ; $10E95A ORI.B  #$6000,(A7)+
        DC.W    $000E,$0014         ; $10E95E ORI.B  #$0014,A6
        DC.W    $001A,$1A11         ; $10E962 ORI.B  #$1A11,(A2)+
        DC.W    $001B,$0006         ; $10E966 ORI.B  #$0006,(A3)+
        DC.W    $0008,$001B         ; $10E96A ORI.B  #$001B,A0
        MOVE.B  (A1),D7                         ; $10E96E
        DC.W    $0005,$0001         ; $10E970 ORI.B  #$0001,D5
        DC.W    $001C,$1D11         ; $10E974 ORI.B  #$1D11,(A4)+
        DC.W    $000E,$0500         ; $10E978 ORI.B  #$0500,A6
        DC.W    $0005,$0012         ; $10E97C ORI.B  #$0012,D5
        BTST    D6,(A1)                         ; $10E980
        DC.W    $001A,$0014         ; $10E982 ORI.B  #$0014,(A2)+
        SUBI.B  #$001C,D0                       ; $10E986
        DC.W    $0011,$0001         ; $10E98A ORI.B  #$0001,(A1)
        DC.W    $0200,$0111         ; $10E98E ANDI.B  #$0111,D0
        DC.W    $000D,$0111         ; $10E992 ORI.B  #$0111,A5
        DC.W    $0003,$0011         ; $10E996 ORI.B  #$0011,D3
        SUBQ.B  #8,D0                           ; $10E99A
        DC.W    $0030,$5E00,$000E   ; $10E99C ORI.B  #$5E00,$0E(A0,D0.W)
        DC.W    $000A,$001B         ; $10E9A2 ORI.B  #$001B,A2
        BTST    D2,(A1)                         ; $10E9A6
        MOVE.B  (A5)+,-(A1)                     ; $10E9A8
        DC.W    $0211,$001B         ; $10E9AA ANDI.B  #$001B,(A1)
        DC.W    $0014,$0019         ; $10E9AE ORI.B  #$0019,(A4)
        SUBI.B  #$171D,(A1)                     ; $10E9B2
        DC.W    $0211,$000D         ; $10E9B6 ANDI.B  #$000D,(A1)
        DC.W    $000B,$0311         ; $10E9BA ORI.B  #$0311,A3
        MOVE.B  (A5)+,D3                        ; $10E9BE
        DC.W    $001E,$0211         ; $10E9C0 ORI.B  #$0211,(A6)+
        DC.W    $000E,$0400         ; $10E9C4 ORI.B  #$0400,A6
        DC.W    $0005,$0010         ; $10E9C8 ORI.B  #$0010,D5
        BTST    D1,(A1)                         ; $10E9CC
        DC.W    $001D,$001F         ; $10E9CE ORI.B  #$001F,(A5)+
        DC.W    $0020,$0021         ; $10E9D2 ORI.B  #$0021,-(A0)
        DC.W    $0022,$0021         ; $10E9D6 ORI.B  #$0021,-(A2)
        DC.W    $0023,$001F         ; $10E9DA ORI.B  #$001F,-(A3)
        DC.W    $001D,$0311         ; $10E9DE ORI.B  #$0311,(A5)+
        DC.W    $0018,$0001         ; $10E9E2 ORI.B  #$0001,(A0)+
        DC.W    $0200,$001C         ; $10E9E6 ANDI.B  #$001C,D0
        DC.W    $0011,$0001         ; $10E9EA ORI.B  #$0001,(A1)
        DC.W    $0200,$0011         ; $10E9EE ANDI.B  #$0011,D0
        DC.W    $001A,$0017         ; $10E9F2 ORI.B  #$0017,(A2)+
        DC.W    $0024,$0005         ; $10E9F6 ORI.B  #$0005,-(A4)
        DC.W    $0008,$0011         ; $10E9FA ORI.B  #$0011,A0
        SUBQ.B  #8,D0                           ; $10E9FE
        DC.W    $0038,$5D00,$0013   ; $10EA00 ORI.B  #$5D00,$0013.W
        DC.W    $000C,$0411         ; $10EA06 ORI.B  #$0411,A4
        DC.W    $0025,$0026         ; $10EA0A ORI.B  #$0026,-(A5)
        DC.W    $0023,$1227         ; $10EA0E ORI.B  #$1227,-(A3)
        DC.W    $0028,$0029,$0211   ; $10EA12 ORI.B  #$0029,$0211(A0)
        DC.W    $001B,$0211         ; $10EA18 ORI.B  #$0211,(A3)+
        DC.W    $001E,$0029         ; $10EA1C ORI.B  #$0029,(A6)+
        DC.W    $002A,$1627,$002B   ; $10EA20 ORI.B  #$1627,$002B(A2)
        ADDI.B  #$002C,(A1)                     ; $10EA26
        DC.W    $002D,$002A,$1527   ; $10EA2A ORI.B  #$002A,$1527(A5)
        DC.W    $002E,$0211,$000E   ; $10EA30 ORI.B  #$0211,$000E(A6)
        BTST    D1,D0                           ; $10EA36
        DC.W    $0002,$0019         ; $10EA38 ORI.B  #$0019,D2
        DC.W    $0211,$001D         ; $10EA3C ANDI.B  #$001D,(A1)
        DC.W    $002F,$002A,$0027   ; $10EA40 ORI.B  #$002A,$0027(A7)
        DC.W    $0030,$0031,$0132   ; $10EA46 ORI.B  #$0031,$32(A0,D0.W)
        DC.W    $0030,$0027,$002A   ; $10EA4C ORI.B  #$0027,$2A(A0,D0.W)
        DC.W    $0033,$0211,$001A   ; $10EA52 ORI.B  #$0211,$1A(A3,D0.W)
        DC.W    $0014,$0200         ; $10EA58 ORI.B  #$0200,(A4)
        DC.W    $001C,$0011         ; $10EA5C ORI.B  #$0011,(A4)+
        DC.W    $0001,$0200         ; $10EA60 ORI.B  #$0200,D1
        DC.W    $0011,$001A         ; $10EA64 ORI.B  #$001A,(A1)
        DC.W    $0000,$0017         ; $10EA68 ORI.B  #$0017,D0
        DC.W    $0000,$0008         ; $10EA6C ORI.B  #$0008,D0
        DC.W    $0011,$5100         ; $10EA70 ORI.B  #$5100,(A1)
        DC.W    $0034,$5C00,$0013   ; $10EA74 ORI.B  #$5C00,$13(A4,D0.W)
        DC.W    $0015,$0311         ; $10EA7A ORI.B  #$0311,(A5)
        DC.W    $0034,$0023,$002A   ; $10EA7E ORI.B  #$0023,$2A(A4,D0.W)
        DC.W    $0035,$0036,$0932   ; $10EA84 ORI.B  #$0036,$32(A5,D0.L)
        BTST    #22,$29(A1,D0.W)                ; $10EA8A
        BTST    D2,(A1)                         ; $10EA90
        DC.W    $0034,$0037,$0035   ; $10EA92 ORI.B  #$0037,$35(A4,D0.W)
        DC.W    $0038,$1631,$002B   ; $10EA98 ORI.B  #$1631,$002B.W
        SUBI.B  #$001F,(A1)                     ; $10EA9E
        DC.W    $0023,$0039         ; $10EAA2 ORI.B  #$0039,-(A3)
        DC.W    $0035,$1631,$003A   ; $10EAA6 ORI.B  #$1631,$3A(A5,D0.W)
        DC.W    $0211,$000E         ; $10EAAC ANDI.B  #$000E,(A1)
        BTST    D1,D0                           ; $10EAB0
        DC.W    $0003,$0211         ; $10EAB2 ORI.B  #$0211,D3
        DC.W    $001D,$003B         ; $10EAB6 ORI.B  #$003B,(A5)+
        DC.W    $0035,$0431,$0332   ; $10EABA ORI.B  #$0431,$32(A5,D0.W)
        DC.W    $002A,$0033,$0211   ; $10EAC0 ORI.B  #$0033,$0211(A2)
        DC.W    $000C,$0006         ; $10EAC6 ORI.B  #$0006,A4
        BTST    D0,D0                           ; $10EACA
        DC.W    $001C,$0011         ; $10EACC ORI.B  #$0011,(A4)+
        DC.W    $0001,$0200         ; $10EAD0 ORI.B  #$0200,D1
        DC.W    $0011,$001A         ; $10EAD4 ORI.B  #$001A,(A1)
        DC.W    $0200,$0008         ; $10EAD8 ANDI.B  #$0008,D0
        DC.W    $0011,$5100         ; $10EADC ORI.B  #$5100,(A1)
        DC.W    $0030,$5B00,$000E   ; $10EAE0 ORI.B  #$5B00,$0E(A0,D0.W)
        DC.W    $0015,$0211         ; $10EAE6 ORI.B  #$0211,(A5)
        DC.W    $003C,$003A,$003D   ; $10EAEA ORI.B  #$003A,#$003D
        DC.W    $003E,$0C32         ; $10EAF0 ORI.B  #$0C32,<EA:3E>
        BTST    #22,$29(A1,D0.W)                ; $10EAF4
        SUBI.B  #$003F,(A1)                     ; $10EAFA
        DC.W    $013D               ; $10EAFE BTST    D0,<EA:3D>
        MOVE.B  $2B(A1,D0.W),D4                 ; $10EB00
        BTST    D1,(A1)                         ; $10EB04
        DC.W    $001D,$0040         ; $10EB06 ORI.B  #$0040,(A5)+
        DC.W    $003D,$0038         ; $10EB0A ORI.B  #$0038,<EA:3D>
        MOVE.B  $3A(A1,D0.W),-(A3)              ; $10EB0E
        DC.W    $0211,$000E         ; $10EB12 ANDI.B  #$000E,(A1)
        DC.W    $0200,$0013         ; $10EB16 ANDI.B  #$0013,D0
        DC.W    $001A,$0111         ; $10EB1A ORI.B  #$0111,(A2)+
        DC.W    $001E,$003B         ; $10EB1E ORI.B  #$003B,(A6)+
        DC.W    $003D,$0531         ; $10EB22 ORI.B  #$0531,<EA:3D>
        BTST    D1,$31(A2,D0.W)                 ; $10EB26
        DC.W    $002A,$0041,$0211   ; $10EB2A ORI.B  #$0041,$0211(A2)
        DC.W    $0014,$0100         ; $10EB30 ORI.B  #$0100,(A4)
        DC.W    $0001,$0017         ; $10EB34 ORI.B  #$0017,D1
        BTST    D1,D0                           ; $10EB38
        DC.W    $0017,$0006         ; $10EB3A ORI.B  #$0006,(A7)
        BTST    D1,D0                           ; $10EB3E
        DC.W    $0017,$5100         ; $10EB40 ORI.B  #$5100,(A7)
        DC.W    $0020,$5A00         ; $10EB44 ORI.B  #$5A00,-(A0)
        DC.W    $0017,$000C         ; $10EB48 ORI.B  #$000C,(A7)
        DC.W    $0211,$0023         ; $10EB4C ANDI.B  #$0023,(A1)
        DC.W    $0036,$0E32,$0931   ; $10EB50 ORI.B  #$0E32,$31(A6,D0.L)
        DC.W    $0036,$0029,$0311   ; $10EB56 ORI.B  #$0029,$11(A6,D0.W)
        DC.W    $0034,$003D,$1A31   ; $10EB5C ORI.B  #$003D,$31(A4,D1.L)
        DC.W    $002B,$0211,$001D   ; $10EB62 ORI.B  #$0211,$001D(A3)
        ORI.W  #$1A31,D0                        ; $10EB68
        DC.W    $003A,$0211,$000E   ; $10EB6C ORI.B  #$0211,$000E(PC)
        DC.W    $0200,$0007         ; $10EB72 ANDI.B  #$0007,D0
        DC.W    $0211,$0042         ; $10EB76 ANDI.B  #$0042,(A1)
        SUBI.B  #$033D,$32(A1,D0.W)             ; $10EB7A
        ORI.W  #$0211,D3                        ; $10EB80
        DC.W    $001C,$6000         ; $10EB84 ORI.B  #$6000,(A4)+
        DC.W    $0027,$5900         ; $10EB88 ORI.B  #$5900,-(A7)
        DC.W    $0001,$0018         ; $10EB8C ORI.B  #$0018,D1
        DC.W    $0211,$0044         ; $10EB90 ANDI.B  #$0044,(A1)
        DC.W    $0035,$0F32,$0931   ; $10EB94 ORI.B  #$0F32,$31(A5,D0.L)
        DC.W    $0036,$0029,$0211   ; $10EB9A ORI.B  #$0029,$11(A6,D0.W)
        DC.W    $001E,$002E         ; $10EBA0 ORI.B  #$002E,(A6)+
        DC.W    $0038,$1A31,$002B   ; $10EBA4 ORI.B  #$1A31,$002B.W
        DC.W    $0211,$003F         ; $10EBAA ANDI.B  #$003F,(A1)
        MOVE.B  $3A(A1,D0.W),-(A5)              ; $10EBAE
        DC.W    $0211,$000E         ; $10EBB2 ANDI.B  #$000E,(A1)
        BTST    D0,D0                           ; $10EBB6
        DC.W    $0017,$0211         ; $10EBB8 ORI.B  #$0211,(A7)
        DC.W    $0025,$0028         ; $10EBBC ORI.B  #$0028,-(A5)
        BTST    D1,$3D(A1,D0.W)                 ; $10EBC0
        ORI.W  #$0045,D3                        ; $10EBC4
        DC.W    $0023,$0021         ; $10EBC8 ORI.B  #$0021,-(A3)
        DC.W    $0036,$0332,$0046   ; $10EBCC ORI.B  #$0332,$46(A6,D0.W)
        ORI.W  #$0211,D7                        ; $10EBD2
        DC.W    $0008,$5F00         ; $10EBD6 ORI.B  #$5F00,A0
        DC.W    $002B,$5900,$000E   ; $10EBDA ORI.B  #$5900,$000E(A3)
        DC.W    $0016,$0111         ; $10EBE0 ORI.B  #$0111,(A6)
        ORI.W  #$0043,A0                        ; $10EBE4
        ADDI.B  #$0036,$27(A2,D1.W)             ; $10EBE8
        ORI.W  #$0029,D3                        ; $10EBEE
        DC.W    $0211,$0049         ; $10EBF2 ANDI.B  #$0049,(A1)
        DC.W    $003D,$0431         ; $10EBF6 ORI.B  #$0431,<EA:3D>
        MOVE.B  -(A7),D3                        ; $10EBFA
        DC.W    $003B,$0111,$0025   ; $10EBFC ORI.B  #$0111,$25(PC,D0.W)
        DC.W    $002A,$0431,$0030   ; $10EC02 ORI.B  #$0431,$0030(A2)
        MOVE.B  -(A7),-(A2)                     ; $10EC08
        DC.W    $002E,$0211,$000E   ; $10EC0A ORI.B  #$0211,$000E(A6)
        BTST    D0,D0                           ; $10EC10
        DC.W    $0002,$0211         ; $10EC12 ORI.B  #$0211,D2
        ORI.W  #$0431,D5                        ; $10EC16
        DC.W    $002B,$0029,$001F   ; $10EC1A ORI.B  #$0029,$001F(A3)
        DC.W    $001D,$002F         ; $10EC20 ORI.B  #$002F,(A5)+
        ORI.W  #$003E,A1                        ; $10EC24
        BTST    D1,$4A(A2,D0.W)                 ; $10EC28
        DC.W    $0211,$000C         ; $10EC2C ANDI.B  #$000C,(A1)
        DC.W    $0006,$5E00         ; $10EC30 ORI.B  #$5E00,D6
        DC.W    $002E,$5800,$0001   ; $10EC34 ORI.B  #$5800,$0001(A6)
        DC.W    $0009,$0211         ; $10EC3A ORI.B  #$0211,A1
        DC.W    $003B,$003D,$0532   ; $10EC3E ORI.B  #$003D,$32(PC,D0.W)
        DC.W    $0022,$003F         ; $10EC44 ORI.B  #$003F,-(A2)
        MOVE.B  D1,$0211(A1)                    ; $10EC48
        DC.W    $001E,$0027         ; $10EC4C ORI.B  #$0027,(A6)+
        SUBI.B  #$0021,$41(A1,D1.W)             ; $10EC50
        BTST    D0,(A1)                         ; $10EC56
        ORI.W  #$003D,D4                        ; $10EC58
        DC.W    $0231,$0032,$003E   ; $10EC5C ANDI.B  #$0032,$3E(A1,D0.W)
        ORI.W  #$1541,A3                        ; $10EC62
        DC.W    $0025,$0211         ; $10EC66 ORI.B  #$0211,-(A5)
        DC.W    $000E,$0000         ; $10EC6A ORI.B  #$0000,A6
        DC.W    $0006,$000C         ; $10EC6E ORI.B  #$000C,D6
        BTST    D0,(A1)                         ; $10EC72
        DC.W    $002C,$0046,$0432   ; $10EC74 ORI.B  #$0046,$0432(A4)
        ORI.W  #$0029,D5                        ; $10EC7A
        ORI.W  #$004D,A4                        ; $10EC7E
        ORI.W  #$002D,D4                        ; $10EC82
        ORI.W  #$034F,A6                        ; $10EC86
        ORI.W  #$002D,(A0)                      ; $10EC8A
        DC.W    $0211,$0017         ; $10EC8E ANDI.B  #$0017,(A1)
        ADDQ.B  #7,D0                           ; $10EC92
        DC.W    $0039,$5800,$0017,$0012; $10EC94 ORI.B  #$5800,$00170012
        BTST    D0,(A1)                         ; $10EC9C
        DC.W    $0023,$0051         ; $10EC9E ORI.B  #$0051,-(A3)
        SUBI.B  #$0027,$42(A2,D0.W)             ; $10ECA2
        BTST    D0,(A5)+                        ; $10ECA8
        DC.W    $002D,$1052,$0046   ; $10ECAA ORI.B  #$1052,$0046(A5)
        DC.W    $0027,$0029         ; $10ECB0 ORI.B  #$0029,-(A7)
        BTST    D0,(A1)                         ; $10ECB4
        DC.W    $0033,$0053,$034F   ; $10ECB6 ORI.B  #$0053,$4F(A3,D0.W)
        ORI.W  #$001D,D3                        ; $10ECBC
        ORI.W  #$0021,D1                        ; $10ECC0
        MOVEA.B D6,A2                           ; $10ECC4
        DC.W    $003B,$0011,$0025   ; $10ECC6 ORI.B  #$0011,$25(PC,D0.W)
        DC.W    $0035,$0332,$0054   ; $10ECCC ORI.B  #$0332,$54(A5,D0.W)
        DC.W    $003F,$001E         ; $10ECD2 ORI.B  #$001E,<EA:3F>
        ORI.W  #$0027,D4                        ; $10ECD6
        MOVE.B  D6,$002E(A1)                    ; $10ECDA
        DC.W    $0211,$000E         ; $10ECDE ANDI.B  #$000E,(A1)
        DC.W    $0000,$0006         ; $10ECE2 ORI.B  #$0006,D0
        DC.W    $001B,$0111         ; $10ECE6 ORI.B  #$0111,(A3)+
        DC.W    $002D,$0054,$0355   ; $10ECEA ORI.B  #$0054,$0355(A5)
        ORI.W  #$001D,D6                        ; $10ECF0
        DC.W    $0023,$0032         ; $10ECF4 ORI.B  #$0032,-(A3)
        ORI.W  #$0052,(A6)                      ; $10ECF8
        DC.W    $001D,$0052         ; $10ECFC ORI.B  #$0052,(A5)+
        SUBI.W  #$003A,(A6)                     ; $10ED00
        DC.W    $0211,$0008         ; $10ED04 ANDI.B  #$0008,(A1)
        ADDQ.B  #7,D0                           ; $10ED08
        DC.W    $003C,$5700,$0001   ; $10ED0A ORI.B  #$5700,#$0001
        DC.W    $0002,$0211         ; $10ED10 ORI.B  #$0211,D2
        ORI.W  #$044F,(A7)                      ; $10ED14
        ORI.W  #$0047,D6                        ; $10ED18
        DC.W    $0025,$0058         ; $10ED1C ORI.B  #$0058,-(A5)
        ORI.W  #$004E,A2                        ; $10ED20
        MOVE.B  A7,$003E(A0)                    ; $10ED24
        DC.W    $002D,$0111,$0043   ; $10ED28 ORI.B  #$0111,$0043(A5)
        DC.W    $034F               ; $10ED2E BCHG    D1,A7
        ORI.W  #$0029,A6                        ; $10ED30
        ORI.W  #$002A,D1                        ; $10ED34
        DC.W    $0D4F               ; $10ED38 BCHG    D6,A7
        BCHG    D0,(A5)                         ; $10ED3A
        BCHG    D2,(A1)+                        ; $10ED3C
        DC.W    $0035,$0011,$0033   ; $10ED3E ORI.B  #$0011,$33(A5,D0.W)
        DC.W    $003E,$0359         ; $10ED44 ORI.B  #$0359,<EA:3E>
        ORI.W  #$001D,(A2)+                     ; $10ED48
        ORI.W  #$0036,D4                        ; $10ED4C
        BCHG    D1,(A3)+                        ; $10ED50
        MOVEA.B (A6),A0                         ; $10ED52
        DC.W    $0027,$0211         ; $10ED54 ORI.B  #$0211,-(A7)
        DC.W    $000E,$0000         ; $10ED58 ORI.B  #$0000,A6
        DC.W    $0005,$001A         ; $10ED5C ORI.B  #$001A,D5
        BTST    D0,(A1)                         ; $10ED60
        DC.W    $003F,$0032         ; $10ED62 ORI.B  #$0032,<EA:3F>
        ANDI.W  #$0032,(A6)                     ; $10ED66
        ORI.W  #$0033,A3                        ; $10ED6A
        DC.W    $0035,$0156,$005C   ; $10ED6E ORI.B  #$0156,$5C(A5,D0.W)
        ORI.W  #$0037,D4                        ; $10ED74
        SUBI.W  #$0043,(A6)                     ; $10ED78
        ORI.W  #$0111,(A5)+                     ; $10ED7C
        DC.W    $0024,$0006         ; $10ED80 ORI.B  #$0006,-(A4)
        SUBQ.B  #6,D0                           ; $10ED84
        DC.W    $003A,$5700,$0006   ; $10ED86 ORI.B  #$5700,$0006(PC)
        DC.W    $000B,$0111         ; $10ED8C ORI.B  #$0111,A3
        DC.W    $001D,$004A         ; $10ED90 ORI.B  #$004A,(A5)+
        SUBI.W  #$003F,A7                       ; $10ED94
        DC.W    $0033,$0021,$004E   ; $10ED98 ORI.B  #$0021,$4E(A3,D0.W)
        ANDI.W  #$0E55,A7                       ; $10ED9E
        BCHG    D0,(A6)                         ; $10EDA2
        DC.W    $0032,$002D,$0111   ; $10EDA4 ORI.B  #$002D,$11(A2,D0.W)
        ORI.W  #$0356,A6                        ; $10EDAA
        ORI.W  #$0029,(A4)+                     ; $10EDAE
        ORI.W  #$0F56,D3                        ; $10EDB2
        ADDI.W  #$0036,(A3)+                    ; $10EDB6
        DC.W    $0011,$0047         ; $10EDBA ORI.B  #$0047,(A1)
        DC.W    $0032,$035B,$0036   ; $10EDBE ORI.B  #$035B,$36(A2,D0.W)
        DC.W    $001F,$0035         ; $10EDC4 ORI.B  #$0035,(A7)+
        BCHG    D2,(A3)+                        ; $10EDC8
        BCHG    D7,(A6)                         ; $10EDCA
        ORI.W  #$0211,D6                        ; $10EDCC
        DC.W    $000E,$0001         ; $10EDD0 ORI.B  #$0001,A6
        DC.W    $000B,$0111         ; $10EDD4 ORI.B  #$0111,A3
        DC.W    $001D,$0036         ; $10EDD8 ORI.B  #$0036,(A5)+
        BCHG    D1,(A6)                         ; $10EDDC
        ORI.W  #$001D,A6                        ; $10EDDE
        ORI.W  #$0032,D5                        ; $10EDE2
        BCHG    D0,(A6)                         ; $10EDE6
        DC.W    $0032,$0023,$0029   ; $10EDE8 ORI.B  #$0023,$29(A2,D0.W)
        ORI.W  #$0356,(A4)+                     ; $10EDEE
        DC.W    $0032,$005E,$0111   ; $10EDF2 ORI.B  #$005E,$11(A2,D0.W)
        DC.W    $0010,$0017         ; $10EDF8 ORI.B  #$0017,(A0)
        SUBQ.B  #6,D0                           ; $10EDFC
        DC.W    $0035,$5700,$0006   ; $10EDFE ORI.B  #$5700,$06(A5,D0.W)
        DC.W    $0019,$0111         ; $10EE04 ORI.B  #$0111,(A1)+
        DC.W    $002D,$005C,$0356   ; $10EE08 ORI.B  #$005C,$0356(A5)
        ORI.W  #$002C,A6                        ; $10EE0E
        DC.W    $0023,$0032         ; $10EE12 ORI.B  #$0032,-(A3)
        MOVEA.B (A6),A2                         ; $10EE16
        DC.W    $0032,$0044,$0111   ; $10EE18 ORI.B  #$0044,$11(A2,D0.W)
        ORI.W  #$0356,A6                        ; $10EE1E
        ORI.W  #$0029,(A4)+                     ; $10EE22
        ORI.W  #$0E56,(A7)+                     ; $10EE26
        BCHG    D3,(A3)+                        ; $10EE2A
        DC.W    $0036,$0011,$0047   ; $10EE2C ORI.B  #$0011,$47(A6,D0.W)
        DC.W    $0032,$035B,$0036   ; $10EE32 ORI.B  #$035B,$36(A2,D0.W)
        ORI.W  #$003E,-(A0)                     ; $10EE38
        ADDI.W  #$0E56,(A3)+                    ; $10EE3C
        ORI.W  #$0211,D6                        ; $10EE40
        DC.W    $000E,$0006         ; $10EE44 ORI.B  #$0006,A6
        DC.W    $000D,$0111         ; $10EE48 ORI.B  #$0111,A5
        ORI.W  #$0032,D7                        ; $10EE4C
        BCHG    D1,(A6)                         ; $10EE50
        DC.W    $0039,$001D,$0035,$0356; $10EE52 ORI.B  #$001D,$00350356
        DC.W    $0021,$0025         ; $10EE5A ORI.B  #$0025,-(A1)
        ORI.W  #$0356,D3                        ; $10EE5E
        DC.W    $0032,$0023,$0211   ; $10EE62 ORI.B  #$0023,$11(A2,D0.W)
        DC.W    $0007,$5D00         ; $10EE68 ORI.B  #$5D00,D7
        DC.W    $0035,$5700,$0006   ; $10EE6C ORI.B  #$5700,$06(A5,D0.W)
        DC.W    $001B,$0111         ; $10EE72 ORI.B  #$0111,(A3)+
        DC.W    $0034,$004F,$0356   ; $10EE76 ORI.B  #$004F,$56(A4,D0.W)
        ORI.W  #$0033,-(A1)                     ; $10EE7C
        ORI.W  #$1556,D6                        ; $10EE80
        DC.W    $0032,$0044,$0111   ; $10EE84 ORI.B  #$0044,$11(A2,D0.W)
        ORI.W  #$0356,A6                        ; $10EE8A
        ORI.W  #$0029,(A4)+                     ; $10EE8E
        ORI.W  #$0D56,(A7)+                     ; $10EE92
        BCHG    #22,(A3)+                       ; $10EE96
        DC.W    $0011,$0047         ; $10EE9A ORI.B  #$0047,(A1)
        DC.W    $0032,$035B,$0036   ; $10EE9E ORI.B  #$035B,$36(A2,D0.W)
        ORI.W  #$003E,-(A0)                     ; $10EEA4
        BCHG    D3,(A3)+                        ; $10EEA8
        BCHG    D6,(A6)                         ; $10EEAA
        ORI.W  #$0211,D6                        ; $10EEAC
        DC.W    $000E,$0014         ; $10EEB0 ORI.B  #$0014,A6
        DC.W    $0211,$0043         ; $10EEB4 ANDI.B  #$0043,(A1)
        BCHG    D1,(A6)                         ; $10EEB8
        ORI.W  #$0029,(A4)+                     ; $10EEBA
        DC.W    $001D,$004E         ; $10EEBE ORI.B  #$004E,(A5)+
        BCHG    D1,(A6)                         ; $10EEC2
        DC.W    $003E,$0058         ; $10EEC4 ORI.B  #$0058,<EA:3E>
        DC.W    $001F,$003E         ; $10EEC8 ORI.B  #$003E,(A7)+
        BCHG    D1,(A6)                         ; $10EECC
        ORI.W  #$001D,D6                        ; $10EECE
        BTST    D0,(A1)                         ; $10EED2
        DC.W    $000F,$0001         ; $10EED4 ORI.B  #$0001,A7
        ADDQ.B  #6,D0                           ; $10EED8
        DC.W    $0036,$5700,$0006   ; $10EEDA ORI.B  #$5700,$06(A6,D0.W)
        DC.W    $001B,$0111         ; $10EEE0 ORI.B  #$0111,(A3)+
        DC.W    $0034,$004F,$0256   ; $10EEE4 ORI.B  #$004F,$56(A4,D0.W)
        ORI.W  #$001D,A6                        ; $10EEEA
        ORI.W  #$0032,(A6)+                     ; $10EEEE
        MOVE.B  (A6),$035B(A0)                  ; $10EEF2
        DC.W    $0032,$002D,$0111   ; $10EEF6 ORI.B  #$002D,$11(A2,D0.W)
        ORI.W  #$0356,A6                        ; $10EEFC
        ORI.W  #$0029,(A4)+                     ; $10EF00
        ORI.W  #$0456,(A7)+                     ; $10EF04
        ORI.W  #$1059,(A3)+                     ; $10EF08
        DC.W    $0035,$0011,$0047   ; $10EF0C ORI.B  #$0011,$47(A5,D0.W)
        DC.W    $0032,$035B,$0036   ; $10EF12 ORI.B  #$035B,$36(A2,D0.W)
        ORI.W  #$003E,-(A0)                     ; $10EF18
        SUBI.W  #$1059,(A3)+                    ; $10EF1C
        DC.W    $0027,$0211         ; $10EF20 ORI.B  #$0211,-(A7)
        DC.W    $000E,$0007         ; $10EF24 ORI.B  #$0007,A6
        DC.W    $0211,$004E         ; $10EF28 ANDI.B  #$004E,(A1)
        BCHG    D1,(A6)                         ; $10EF2C
        DC.W    $003E,$0033         ; $10EF2E ORI.B  #$0033,<EA:3E>
        ORI.W  #$0556,-(A1)                     ; $10EF32
        DC.W    $002A,$001D,$004E   ; $10EF36 ORI.B  #$001D,$004E(A2)
        BCHG    D1,(A6)                         ; $10EF3C
        ORI.W  #$0025,(A4)+                     ; $10EF3E
        BTST    D0,(A1)                         ; $10EF42
        DC.W    $0024,$0017         ; $10EF44 ORI.B  #$0017,-(A4)
        ADDQ.B  #6,D0                           ; $10EF48
        DC.W    $003F,$5700         ; $10EF4A ORI.B  #$5700,<EA:3F>
        DC.W    $0006,$001B         ; $10EF4E ORI.B  #$001B,D6
        BTST    D0,(A1)                         ; $10EF52
        DC.W    $0034,$004F,$0256   ; $10EF54 ORI.B  #$004F,$56(A4,D0.W)
        ORI.W  #$001D,A6                        ; $10EF5A
        DC.W    $002A,$0456,$0032   ; $10EF5E ORI.B  #$0456,$0032(A2)
        DC.W    $0037,$0649,$0857   ; $10EF64 ORI.B  #$0649,$57(A7,D0.L)
        ORI.W  #$001F,D5                        ; $10EF6A
        BTST    D0,(A1)                         ; $10EF6E
        ORI.W  #$0356,A6                        ; $10EF70
        ORI.W  #$0029,(A4)+                     ; $10EF74
        ORI.W  #$0356,(A7)+                     ; $10EF78
        ORI.W  #$0046,(A3)+                     ; $10EF7C
        DC.W    $002E,$0B49,$0057   ; $10EF80 ORI.B  #$0B49,$0057(A6)
        ANDI.W  #$0044,A3                       ; $10EF86
        DC.W    $0011,$0047         ; $10EF8A ORI.B  #$0047,(A1)
        DC.W    $0032,$035B,$0036   ; $10EF8E ORI.B  #$035B,$36(A2,D0.W)
        ORI.W  #$003E,-(A0)                     ; $10EF94
        BCHG    D1,(A3)+                        ; $10EF98
        DC.W    $0032,$0037,$0F49   ; $10EF9A ORI.B  #$0037,$49(A2,D0.L)
        ORI.W  #$0211,-(A2)                     ; $10EFA0
        DC.W    $0008,$000D         ; $10EFA4 ORI.B  #$000D,A0
        BTST    D0,(A1)                         ; $10EFA8
        DC.W    $0029,$005C,$0356   ; $10EFAA ORI.B  #$005C,$0356(A1)
        ORI.W  #$0060,-(A3)                     ; $10EFB0
        DC.W    $0035,$0556,$004E   ; $10EFB4 ORI.B  #$0556,$4E(A5,D0.W)
        DC.W    $001D,$0049         ; $10EFBA ORI.B  #$0049,(A5)+
        ORI.W  #$0256,A7                        ; $10EFBE
        DC.W    $0032,$0023,$0211   ; $10EFC2 ORI.B  #$0023,$11(A2,D0.W)
        DC.W    $0018,$5C00         ; $10EFC8 ORI.B  #$5C00,(A0)+
        DC.W    $003A,$5700,$0006   ; $10EFCC ORI.B  #$5700,$0006(PC)
        DC.W    $001B,$0111         ; $10EFD2 ORI.B  #$0111,(A3)+
        DC.W    $0034,$004F,$0256   ; $10EFD6 ORI.B  #$004F,$56(A4,D0.W)
        ORI.W  #$001D,A6                        ; $10EFDC
        ORI.W  #$0032,D5                        ; $10EFE0
        BCHG    D1,(A6)                         ; $10EFE4
        DC.W    $0032,$003F,$054B   ; $10EFE6 ORI.B  #$003F,$4B(A2,D0.W)
        DC.W    $0023,$0C11         ; $10EFEC ORI.B  #$0C11,-(A3)
        ORI.W  #$0356,A6                        ; $10EFF0
        ORI.W  #$0029,(A4)+                     ; $10EFF4
        ORI.W  #$0356,(A7)+                     ; $10EFF8
        ORI.W  #$0027,(A3)+                     ; $10EFFC
        DC.W    $0B4B               ; $10F000 BCHG    D5,A3
        DC.W    $0023,$0511         ; $10F002 ORI.B  #$0511,-(A3)
        ORI.W  #$0032,D7                        ; $10F006
        BCHG    D1,(A3)+                        ; $10F00A
        DC.W    $0036,$0060,$003E   ; $10F00C ORI.B  #$0060,$3E(A6,D0.W)
        BCHG    D1,(A3)+                        ; $10F012
        DC.W    $003E,$0041         ; $10F014 ORI.B  #$0041,<EA:3E>
        ORI.W  #$0E4B,D4                        ; $10F018
        ORI.W  #$0211,-(A4)                     ; $10F01C
        DC.W    $0014,$0211         ; $10F020 ORI.B  #$0211,(A4)
        ORI.W  #$0356,-(A1)                     ; $10F024
        DC.W    $0032,$0023,$005E   ; $10F028 ORI.B  #$0023,$5E(A2,D0.W)
        ORI.W  #$0556,(A4)+                     ; $10F02E
        DC.W    $0032,$0044,$0058   ; $10F032 ORI.B  #$0044,$58(A2,D0.W)
        ORI.W  #$0356,(A4)+                     ; $10F038
        DC.W    $0035,$0211,$0003   ; $10F03C ORI.B  #$0211,$03(A5,D0.W)
        ADDQ.B  #6,D0                           ; $10F042
        DC.W    $003A,$5700,$0006   ; $10F044 ORI.B  #$5700,$0006(PC)
        DC.W    $001B,$0111         ; $10F04A ORI.B  #$0111,(A3)+
        DC.W    $0034,$004F,$0256   ; $10F04E ORI.B  #$004F,$56(A4,D0.W)
        ORI.W  #$004B,-(A5)                     ; $10F054
        ORI.W  #$0030,(A0)+                     ; $10F058
        SUBI.W  #$0632,(A6)                     ; $10F05C
        ORI.W  #$0063,(A4)+                     ; $10F060
        DC.W    $0037,$0058,$0911   ; $10F064 ORI.B  #$0058,$11(A7,D0.L)
        ORI.W  #$0356,A6                        ; $10F06A
        ORI.W  #$0029,(A4)+                     ; $10F06E
        ORI.W  #$0456,(A7)+                     ; $10F072
        ORI.W  #$0B32,(A3)+                     ; $10F076
        DC.W    $0030,$0511,$0047   ; $10F07A ORI.B  #$0511,$47(A0,D0.W)
        DC.W    $0032,$035B,$0036   ; $10F080 ORI.B  #$035B,$36(A2,D0.W)
        ORI.W  #$003E,-(A0)                     ; $10F086
        BCHG    D1,(A3)+                        ; $10F08A
        DC.W    $003E,$0041         ; $10F08C ORI.B  #$0041,<EA:3E>
        DC.W    $0035,$0E32,$002A   ; $10F090 ORI.B  #$0E32,$2A(A5,D0.W)
        DC.W    $0211,$0003         ; $10F096 ANDI.B  #$0003,(A1)
        DC.W    $0211,$005F         ; $10F09A ANDI.B  #$005F,(A1)
        BCHG    D1,(A6)                         ; $10F09E
        DC.W    $003E,$0064         ; $10F0A0 ORI.B  #$0064,<EA:3E>
        ORI.W  #$0756,-(A6)                     ; $10F0A4
        ORI.W  #$0033,(A7)+                     ; $10F0A8
        DC.W    $0035,$0356,$004E   ; $10F0AC ORI.B  #$0356,$4E(A5,D0.W)
        DC.W    $001E,$0111         ; $10F0B2 ORI.B  #$0111,(A6)+
        DC.W    $001B,$000E         ; $10F0B6 ORI.B  #$000E,(A3)+
        SUBQ.B  #5,D0                           ; $10F0BA
        DC.W    $0035,$5700,$0006   ; $10F0BC ORI.B  #$5700,$06(A5,D0.W)
        DC.W    $0024,$0111         ; $10F0C2 ORI.B  #$0111,-(A4)
        DC.W    $0034,$004F,$0356   ; $10F0C6 ORI.B  #$004F,$56(A4,D0.W)
        DC.W    $0035,$001D,$0045   ; $10F0CC ORI.B  #$001D,$45(A5,D0.W)
        ORI.W  #$0D56,A7                        ; $10F0D2
        ORI.W  #$0043,(A4)+                     ; $10F0D6
        DC.W    $001D,$0711         ; $10F0DA ORI.B  #$0711,(A5)+
        ORI.W  #$0356,A6                        ; $10F0DE
        ORI.W  #$0029,(A4)+                     ; $10F0E2
        ORI.W  #$0B56,(A7)+                     ; $10F0E6
        BCHG    D2,(A3)+                        ; $10F0EA
        DC.W    $003E,$0511         ; $10F0EC ORI.B  #$0511,<EA:3E>
        ORI.W  #$0032,D7                        ; $10F0F0
        BCHG    D1,(A3)+                        ; $10F0F4
        DC.W    $0036,$0060,$003E   ; $10F0F6 ORI.B  #$0060,$3E(A6,D0.W)
        BCHG    D1,(A3)+                        ; $10F0FC
        DC.W    $003E,$0041         ; $10F0FE ORI.B  #$0041,<EA:3E>
        DC.W    $0036,$025B,$0B56   ; $10F102 ORI.B  #$025B,$56(A6,D0.L)
        ORI.W  #$0511,D6                        ; $10F108
        ORI.W  #$0456,A3                        ; $10F10C
        DC.W    $0037,$001E,$002B   ; $10F110 ORI.B  #$001E,$2B(A7,D0.W)
        BCHG    D3,(A6)                         ; $10F116
        ORI.W  #$001D,-(A7)                     ; $10F118
        DC.W    $0023,$0032         ; $10F11C ORI.B  #$0032,-(A3)
        BCHG    D1,(A6)                         ; $10F120
        ORI.W  #$0211,-(A1)                     ; $10F122
        DC.W    $0013,$5B00         ; $10F126 ORI.B  #$5B00,(A3)
        DC.W    $0033,$5700,$0001   ; $10F12A ORI.B  #$5700,$01(A3,D0.W)
        DC.W    $000A,$0111         ; $10F130 ORI.B  #$0111,A2
        DC.W    $0033,$004E,$0456   ; $10F134 ORI.B  #$004E,$56(A3,D0.W)
        ORI.W  #$0069,$0035(A0)                 ; $10F13A
        ORI.W  #$0E56,A7                        ; $10F140
        ORI.W  #$0041,$0611(A2)                 ; $10F144
        ORI.W  #$0356,A6                        ; $10F14A
        ORI.W  #$0029,(A4)+                     ; $10F14E
        ORI.W  #$0B56,(A7)+                     ; $10F152
        BCHG    D2,(A3)+                        ; $10F156
        DC.W    $003E,$0511         ; $10F158 ORI.B  #$0511,<EA:3E>
        ORI.W  #$0032,D7                        ; $10F15C
        BCHG    D1,(A3)+                        ; $10F160
        DC.W    $0036,$0060,$003E   ; $10F162 ORI.B  #$0060,$3E(A6,D0.W)
        BCHG    D1,(A3)+                        ; $10F168
        DC.W    $003E,$0041         ; $10F16A ORI.B  #$0041,<EA:3E>
        DC.W    $0036,$025B,$0B56   ; $10F16E ORI.B  #$025B,$56(A6,D0.L)
        ORI.W  #$0511,D6                        ; $10F174
        DC.W    $002B,$0456,$0037   ; $10F178 ORI.B  #$0456,$0037(A3)
        ORI.W  #$005C,D4                        ; $10F17E
        BCHG    #31,(A6)                        ; $10F182
        DC.W    $0023,$0032         ; $10F186 ORI.B  #$0032,-(A3)
        BCHG    D1,(A6)                         ; $10F18A
        ORI.W  #$0211,$0003(A3)                 ; $10F18C
        SUBQ.B  #5,D0                           ; $10F192
        DC.W    $0037,$5800,$000E   ; $10F194 ORI.B  #$5800,$0E(A7,D0.W)
        DC.W    $0211,$0037         ; $10F19A ANDI.B  #$0037,(A1)
        SUBI.W  #$0027,(A6)                     ; $10F19E
        ORI.W  #$005E,D1                        ; $10F1A2
        ORI.W  #$0036,A3                        ; $10F1A6
        ORI.W  #$0D56,A7                        ; $10F1AA
        ORI.W  #$0049,A6                        ; $10F1AE
        ORI.W  #$0411,(A5)+                     ; $10F1B2
        ORI.W  #$0356,A6                        ; $10F1B6
        ORI.W  #$0029,(A4)+                     ; $10F1BA
        ORI.W  #$0A56,(A7)+                     ; $10F1BE
        ADDI.W  #$003E,(A3)+                    ; $10F1C2
        BTST    D2,(A1)                         ; $10F1C6
        ORI.W  #$0032,D7                        ; $10F1C8
        BCHG    D1,(A3)+                        ; $10F1CC
        DC.W    $0036,$0060,$003E   ; $10F1CE ORI.B  #$0060,$3E(A6,D0.W)
        BCHG    D1,(A3)+                        ; $10F1D4
        DC.W    $003E,$0041         ; $10F1D6 ORI.B  #$0041,<EA:3E>
        DC.W    $0036,$035B,$0A56   ; $10F1DA ORI.B  #$035B,$56(A6,D0.L)
        ORI.W  #$0411,D6                        ; $10F1E0
        DC.W    $001D,$0046         ; $10F1E4 ORI.B  #$0046,(A5)+
        BCHG    D1,(A6)                         ; $10F1E8
        DC.W    $003E,$0029         ; $10F1EA ORI.B  #$0029,<EA:3E>
        DC.W    $0020,$0032         ; $10F1EE ORI.B  #$0032,-(A0)
        BCHG    #11,(A6)                        ; $10F1F2
        DC.W    $0033,$0046,$0356   ; $10F1F6 ORI.B  #$0046,$56(A3,D0.W)
        ORI.W  #$0033,(A4)+                     ; $10F1FC
        DC.W    $0211,$0017         ; $10F200 ANDI.B  #$0017,(A1)
        ADDQ.B  #5,D0                           ; $10F204
        DC.W    $0039,$5800,$0006,$0024; $10F206 ORI.B  #$5800,$00060024
        BTST    D0,(A1)                         ; $10F20E
        DC.W    $0025,$003E         ; $10F210 ORI.B  #$003E,-(A5)
        BCHG    D1,(A6)                         ; $10F214
        DC.W    $0032,$0043,$004B   ; $10F216 ORI.B  #$0043,$4B(A2,D0.W)
        DC.W    $001D,$0029         ; $10F21C ORI.B  #$0029,(A5)+
        DC.W    $003F,$004E         ; $10F220 ORI.B  #$004E,<EA:3F>
        DC.W    $053E               ; $10F224 BTST    D2,<EA:3E>
        DC.W    $0032,$0656,$0032   ; $10F226 ORI.B  #$0656,$32(A2,D0.W)
        ORI.W  #$0411,A1                        ; $10F22C
        ORI.W  #$0356,A6                        ; $10F230
        ORI.W  #$0029,(A4)+                     ; $10F234
        ORI.W  #$113E,-(A1)                     ; $10F238
        DC.W    $0039,$0511,$0047,$0032; $10F23C ORI.B  #$0511,$00470032
        BCHG    D1,(A3)+                        ; $10F244
        DC.W    $0036,$0060,$003E   ; $10F246 ORI.B  #$0060,$3E(A6,D0.W)
        BCHG    D1,(A3)+                        ; $10F24C
        DC.W    $003E,$0041         ; $10F24E ORI.B  #$0041,<EA:3E>
        ORI.W  #$083E,D3                        ; $10F252
        DC.W    $0032,$0456,$0046   ; $10F256 ORI.B  #$0456,$46(A2,D0.W)
        SUBI.B  #$002D,(A1)                     ; $10F25C
        DC.W    $0032,$0356,$0035   ; $10F260 ORI.B  #$0356,$35(A2,D0.W)
        ORI.W  #$0043,D1                        ; $10F266
        BCHG    D4,(A6)                         ; $10F26A
        DC.W    $0035,$0047,$002B   ; $10F26C ORI.B  #$0047,$2B(A5,D0.W)
        SUBI.W  #$002E,(A6)                     ; $10F272
        DC.W    $0211,$0002         ; $10F276 ANDI.B  #$0002,(A1)
        ADDQ.B  #5,D0                           ; $10F27A
        DC.W    $003D,$5900         ; $10F27C ORI.B  #$5900,<EA:3D>
        DC.W    $0018,$0211         ; $10F280 ORI.B  #$0211,(A0)+
        DC.W    $0021,$0556         ; $10F284 ORI.B  #$0556,-(A1)
        DC.W    $0032,$0027,$0020   ; $10F288 ORI.B  #$0027,$20(A2,D0.W)
        DC.W    $001F,$0060         ; $10F28E ORI.B  #$0060,(A7)+
        DC.W    $0025,$0460         ; $10F292 ORI.B  #$0460,-(A5)
        ORI.W  #$0035,-(A2)                     ; $10F296
        ORI.W  #$0556,A6                        ; $10F29A
        DC.W    $0032,$0037,$0311   ; $10F29E ORI.B  #$0037,$11(A2,D0.W)
        ORI.W  #$0356,A6                        ; $10F2A4
        ORI.W  #$002C,(A4)+                     ; $10F2A8
        DC.W    $001F,$1160         ; $10F2AC ORI.B  #$1160,(A7)+
        DC.W    $001F,$0511         ; $10F2B0 ORI.B  #$0511,(A7)+
        ORI.W  #$0032,D7                        ; $10F2B4
        BCHG    D1,(A3)+                        ; $10F2B8
        DC.W    $0036,$0060,$003E   ; $10F2BA ORI.B  #$0060,$3E(A6,D0.W)
        BCHG    D1,(A3)+                        ; $10F2C0
        DC.W    $003E,$001E         ; $10F2C2 ORI.B  #$001E,<EA:3E>
        DC.W    $001F,$0860         ; $10F2C6 ORI.B  #$0860,(A7)+
        DC.W    $003F,$0059         ; $10F2CA ORI.B  #$0059,<EA:3F>
        BCHG    D1,$0046(A4)                    ; $10F2CE
        SUBI.B  #$0045,(A1)                     ; $10F2D2
        ORI.W  #$036C,(A1)+                     ; $10F2D6
        ORI.W  #$0047,-(A1)                     ; $10F2DA
        ORI.W  #$036C,(A4)                      ; $10F2DE
        DC.W    $003E,$004E         ; $10F2E2 ORI.B  #$004E,<EA:3E>
        BCHG    D1,$0059(A4)                    ; $10F2E6
        DC.W    $0023,$0068         ; $10F2EA ORI.B  #$0068,-(A3)
        SUBI.W  #$002B,$0211(A4)                ; $10F2EE
        DC.W    $000D,$0006         ; $10F2F4 ORI.B  #$0006,A5
        SUBQ.B  #4,D0                           ; $10F2F8
        ORI.W  #$5900,D5                        ; $10F2FA
        DC.W    $000E,$0015         ; $10F2FE ORI.B  #$0015,A6
        BTST    D0,(A1)                         ; $10F302
        DC.W    $001F,$004F         ; $10F304 ORI.B  #$004F,(A7)+
        ADDI.W  #$0032,(A6)                     ; $10F308
        ADDI.W  #$0049,A6                       ; $10F30C
        ORI.W  #$001F,-(A0)                     ; $10F310
        DC.W    $001E,$0066         ; $10F314 ORI.B  #$0066,(A6)+
        DC.W    $0035,$0456,$004E   ; $10F318 ORI.B  #$0456,$4E(A5,D0.W)
        DC.W    $001E,$0211         ; $10F31E ORI.B  #$0211,(A6)+
        ORI.W  #$0356,A6                        ; $10F322
        ORI.W  #$0029,(A4)+                     ; $10F326
        ORI.W  #$1136,-(A6)                     ; $10F32A
        ORI.W  #$0511,$0047(A2)                 ; $10F32E
        DC.W    $0032,$036D,$0036   ; $10F334 ORI.B  #$036D,$36(A2,D0.W)
        ORI.W  #$003E,-(A0)                     ; $10F33A
        BCHG    D1,$003E(A5)                    ; $10F33E
        ORI.W  #$006E,D1                        ; $10F342
        BTST    D2,$3D(A6,D0.W)                 ; $10F346
        ORI.W  #$0070,$0068(A7)                 ; $10F34A
        ORI.W  #$036C,$72(A1,D0.W)              ; $10F350
        BTST    D1,(A1)                         ; $10F356
        ORI.W  #$003D,$6C(A3,D0.W)              ; $10F358
        DC.W    $003E,$001E         ; $10F35E ORI.B  #$001E,<EA:3E>
        ORI.W  #$0059,(A6)+                     ; $10F362
        ANDI.W  #$0032,$0058(A4)                ; $10F366
        DC.W    $001E,$0054         ; $10F36C ORI.B  #$0054,(A6)+
        ANDI.W  #$0059,$004B(A4)                ; $10F370
        DC.W    $001D,$0030         ; $10F376 ORI.B  #$0030,(A5)+
        BCHG    D1,$0032(A4)                    ; $10F37A
        ORI.W  #$0111,A0                        ; $10F37E
        DC.W    $0010,$0006         ; $10F382 ORI.B  #$0006,(A0)
        SUBQ.B  #4,D0                           ; $10F386
        ORI.W  #$5A00,D0                        ; $10F388
        DC.W    $0009,$0010         ; $10F38C ORI.B  #$0010,A1
        BTST    D0,(A1)                         ; $10F390
        DC.W    $003F,$0059         ; $10F392 ORI.B  #$0059,<EA:3F>
        BCHG    D6,$0055(A4)                    ; $10F396
        DC.W    $003E,$0072         ; $10F39A ORI.B  #$0072,<EA:3E>
        ORI.W  #$0033,(A6)+                     ; $10F39E
        ORI.W  #$0035,(A0)+                     ; $10F3A2
        SUBI.W  #$0049,$0211(A4)                ; $10F3A6
        DC.W    $003E,$036C         ; $10F3AC ORI.B  #$036C,<EA:3E>
        DC.W    $0032,$0029,$005F   ; $10F3B0 ORI.B  #$0029,$5F(A2,D0.W)
        EORI.W  #$066D,$0032(A4)                ; $10F3B6
        BTST    D2,(A1)                         ; $10F3BC
        ORI.W  #$0059,D7                        ; $10F3BE
        BCHG    D1,$003D(A5)                    ; $10F3C2
        ORI.W  #$0032,-(A0)                     ; $10F3C6
        BCHG    D1,$0032(A5)                    ; $10F3CA
        ORI.W  #$003D,D1                        ; $10F3CE
        BCHG    D1,$026C(A5)                    ; $10F3D2
        ORI.W  #$0037,$0068(A5)                 ; $10F3D6
        ORI.W  #$036C,$0035(A5)                 ; $10F3DC
        BTST    D1,(A1)                         ; $10F3E2
        DC.W    $0033,$005B,$0374   ; $10F3E4 ORI.B  #$005B,$74(A3,D0.W)
        DC.W    $0036,$001D,$0035   ; $10F3EA ORI.B  #$001D,$35(A6,D0.W)
        BCHG    D1,$75(A4,D0.W)                 ; $10F3F0
        ORI.W  #$0011,$32(A3,D0.W)              ; $10F3F4
        BCHG    D1,$76(A4,D0.W)                 ; $10F3FA
        ORI.W  #$0035,(A0)+                     ; $10F3FE
        SUBI.W  #$0042,$11(A4,D0.W)             ; $10F402
        DC.W    $0009,$5900         ; $10F408 ORI.B  #$5900,A1
        ORI.W  #$5A00,D4                        ; $10F40C
        DC.W    $0006,$0077         ; $10F410 ORI.B  #$0077,D6
        DC.W    $0211,$0037         ; $10F414 ANDI.B  #$0037,(A1)
        ORI.W  #$046C,(A4)                      ; $10F418
        EORI.W  #$0059,$2A(A4,D0.W)             ; $10F41C
        ORI.W  #$002E,(A0)+                     ; $10F422
        SUBI.W  #$0035,$001F(A4)                ; $10F426
        BTST    D0,(A1)                         ; $10F42C
        ORI.W  #$036C,(A4)+                     ; $10F42E
        ORI.W  #$0029,(A1)+                     ; $10F432
        DC.W    $0035,$0A6C,$006D   ; $10F436 ORI.B  #$0A6C,$6D(A5,D0.W)
        BCHG    D2,$0032.W                      ; $10F43C
        BTST    D2,(A1)                         ; $10F440
        ORI.W  #$005B,D7                        ; $10F442
        BCHG    D1,$0076.W                      ; $10F446
        ORI.W  #$0032,-(A0)                     ; $10F44A
        BCHG    D1,$0032.W                      ; $10F44E
        ORI.W  #$0076,D1                        ; $10F452
        BCHG    D1,$0274.W                      ; $10F456
        ORI.W  #$0037,$003F.W                   ; $10F45A
        ORI.W  #$0374,$005A.W                   ; $10F460
        BTST    D1,(A1)                         ; $10F466
        DC.W    $002E,$0079,$0274   ; $10F468 ORI.B  #$0079,$0274(A6)
        ORI.W  #$0045,(A3)+                     ; $10F46E
        DC.W    $001D,$0032         ; $10F472 ORI.B  #$0032,(A5)+
        BCHG    D1,$76(A4,D0.W)                 ; $10F476
        DC.W    $001F,$0011         ; $10F47A ORI.B  #$0011,(A7)+
        DC.W    $0036,$0374,$0075   ; $10F47E ORI.B  #$0374,$75(A6,D0.W)
        ORI.W  #$0064,D7                        ; $10F484
        ORI.W  #$0374,(A3)+                     ; $10F488
        ORI.W  #$0025,(A4)+                     ; $10F48C
        BTST    D0,(A1)                         ; $10F490
        DC.W    $000B,$0001         ; $10F492 ORI.B  #$0001,A3
        ADDQ.B  #4,D0                           ; $10F496
        ORI.W  #$5B00,D1                        ; $10F498
        DC.W    $0002,$001A         ; $10F49C ORI.B  #$001A,D2
        DC.W    $0211,$003F         ; $10F4A0 ANDI.B  #$003F,(A1)
        DC.W    $0039,$0F74,$005B,$0020; $10F4A4 ORI.B  #$0F74,$005B0020
        DC.W    $0025,$005C         ; $10F4AC ORI.B  #$005C,-(A5)
        BCHG    D1,$5B(A4,D0.W)                 ; $10F4B0
        DC.W    $0034,$0111,$005C   ; $10F4B4 ORI.B  #$0111,$5C(A4,D0.W)
        BCHG    D1,$5B(A4,D0.W)                 ; $10F4BA
        DC.W    $0029,$005A,$0B74   ; $10F4BE ORI.B  #$005A,$0B74(A1)
        BCHG    D2,$0032.W                      ; $10F4C4
        BTST    D2,(A1)                         ; $10F4C8
        ORI.W  #$005B,D7                        ; $10F4CA
        BCHG    D1,$0076.W                      ; $10F4CE
        ORI.W  #$0032,-(A0)                     ; $10F4D2
        BCHG    D1,$0032.W                      ; $10F4D6
        ORI.W  #$0076,D1                        ; $10F4DA
        ANDI.W  #$0374,$0078.W                  ; $10F4DE
        DC.W    $0037,$003F,$0078   ; $10F4E4 ORI.B  #$003F,$78(A7,D0.W)
        BCHG    D1,$5A(A4,D0.W)                 ; $10F4EA
        BTST    D1,(A1)                         ; $10F4EE
        ORI.W  #$0374,$75(A6,D0.W)              ; $10F4F0
        DC.W    $0033,$0049,$0078   ; $10F4F6 ORI.B  #$0049,$78(A3,D0.W)
        ANDI.W  #$0079,$3F(A4,D0.W)             ; $10F4FC
        BTST    D0,(A1)                         ; $10F502
        ORI.W  #$005B,D4                        ; $10F504
        BCHG    D1,$63(A4,D0.W)                 ; $10F508
        DC.W    $001D,$005C         ; $10F50C ORI.B  #$005C,(A5)+
        BCHG    D1,$0056(PC)                    ; $10F510
        ORI.W  #$0111,D7                        ; $10F514
        DC.W    $000D,$0006         ; $10F518 ORI.B  #$0006,A5
        ADDQ.B  #4,D0                           ; $10F51C
        DC.W    $003F,$5800         ; $10F51E ORI.B  #$5800,<EA:3F>
        DC.W    $0017,$010E         ; $10F522 ORI.B  #$010E,(A7)
        DC.W    $0008,$0009         ; $10F526 ORI.B  #$0009,A0
        BTST    D1,(A1)                         ; $10F52A
        DC.W    $001D,$002A         ; $10F52C ORI.B  #$002A,(A5)+
        ORI.W  #$0E74,(A3)+                     ; $10F530
        DC.W    $0036,$0033,$0040   ; $10F534 ORI.B  #$0033,$40(A6,D0.W)
        BCHG    D1,$5B(A4,D0.W)                 ; $10F53A
        DC.W    $0034,$0111,$005C   ; $10F53E ORI.B  #$0111,$5C(A4,D0.W)
        BCHG    D1,$5B(A4,D0.W)                 ; $10F544
        DC.W    $0029,$005A,$0B74   ; $10F548 ORI.B  #$005A,$0B74(A1)
        BCHG    D2,$0032.W                      ; $10F54E
        BTST    D2,(A1)                         ; $10F552
        ORI.W  #$005B,D7                        ; $10F554
        BCHG    D1,$0076.W                      ; $10F558
        ORI.W  #$0032,-(A0)                     ; $10F55C
        BCHG    D1,$0032.W                      ; $10F560
        ORI.W  #$0076,D1                        ; $10F564
        BCHG    D3,$0037(PC)                    ; $10F568
        DC.W    $003F,$0074         ; $10F56C ORI.B  #$0074,<EA:3F>
        BCHG    D1,$005A(PC)                    ; $10F570
        DC.W    $0211,$001D         ; $10F574 ANDI.B  #$001D,(A1)
        DC.W    $0032,$037A,$004E   ; $10F578 ORI.B  #$037A,$4E(A2,D0.W)
        ORI.W  #$0076,D1                        ; $10F57E
        BCHG    D1,$0056(PC)                    ; $10F582
        DC.W    $002D,$0111,$0025   ; $10F586 ORI.B  #$0111,$0025(A5)
        ORI.W  #$037A,-(A5)                     ; $10F58C
        ORI.W  #$001D,A7                        ; $10F590
        ORI.W  #$047A,D6                        ; $10F594
        ORI.W  #$0211,(A7)+                     ; $10F598
        DC.W    $0018,$5800         ; $10F59C ORI.B  #$5800,(A0)+
        ORI.W  #$5700,D3                        ; $10F5A0
        DC.W    $0006,$0016         ; $10F5A4 ORI.B  #$0016,D6
        BTST    D4,(A1)                         ; $10F5A8
        DC.W    $0029,$003B,$0043   ; $10F5AA ORI.B  #$003B,$0043(A1)
        ORI.W  #$017B,(A3)+                     ; $10F5B0
        DC.W    $0479,$0474,$005B,$0044; $10F5B4 SUBI.W  #$0474,$005B0044
        DC.W    $001E,$005C         ; $10F5BC ORI.B  #$005C,(A6)+
        ANDI.W  #$0056,$34(A4,D0.W)             ; $10F5C0
        BTST    D0,(A1)                         ; $10F5C6
        ORI.W  #$0074,(A4)+                     ; $10F5C8
        ANDI.W  #$0056,$0029(PC)                ; $10F5CC
        ORI.W  #$057A,(A2)+                     ; $10F5D2
        BCHG    D5,(A6)                         ; $10F5D6
        ORI.W  #$0511,(A4)+                     ; $10F5D8
        ORI.W  #$0056,D7                        ; $10F5DC
        BCHG    D1,$005C(PC)                    ; $10F5E0
        ORI.W  #$0032,-(A0)                     ; $10F5E4
        BCHG    D1,$004F(PC)                    ; $10F5E8
        ORI.W  #$004E,D1                        ; $10F5EC
        BCHG    D0,(A6)                         ; $10F5F0
        BCHG    D2,$004C(PC)                    ; $10F5F2
        DC.W    $003F,$047A         ; $10F5F6 ORI.B  #$047A,<EA:3F>
        ORI.W  #$0211,$0027(A3)                 ; $10F5FA
        BCHG    D1,$0056(PC)                    ; $10F600
        DC.W    $0023,$0025         ; $10F604 ORI.B  #$0025,-(A3)
        DC.W    $007C,$037A,$004E   ; $10F608 ORI.W  #$037A,#$004E
        DC.W    $002C,$0111,$001E   ; $10F60E ORI.B  #$0111,$001E(A4)
        ORI.W  #$037A,D6                        ; $10F614
        ORI.W  #$0033,-(A5)                     ; $10F618
        ORI.W  #$0065,D7                        ; $10F61C
        BCHG    D1,$004F(PC)                    ; $10F620
        DC.W    $0211,$0007         ; $10F624 ANDI.B  #$0007,(A1)
        ADDQ.B  #4,D0                           ; $10F628
        ORI.W  #$5700,D3                        ; $10F62A
        DC.W    $0006,$001B         ; $10F62E ORI.B  #$001B,D6
        BTST    D5,(A1)                         ; $10F632
        ORI.W  #$0020,(A5)+                     ; $10F634
        DC.W    $063F,$0021         ; $10F638 ADDI.B  #$0021,<EA:3F>
        DC.W    $007D,$037A         ; $10F63C ORI.W  #$037A,<EA:3D>
        ORI.W  #$001D,A6                        ; $10F640
        ORI.W  #$027A,(A4)+                     ; $10F644
        ORI.W  #$0034,(A6)                      ; $10F648
        BTST    D0,(A1)                         ; $10F64C
        ORI.W  #$037A,(A4)+                     ; $10F64E
        ORI.W  #$0029,(A6)                      ; $10F652
        ORI.W  #$047A,$007E(A3)                 ; $10F656
        DC.W    $003F,$0A57         ; $10F65C ORI.B  #$0A57,<EA:3F>
        DC.W    $0020,$0511         ; $10F660 ORI.B  #$0511,-(A0)
        ORI.W  #$0056,D7                        ; $10F664
        BCHG    D1,$007C(PC)                    ; $10F668
        ORI.W  #$004F,-(A0)                     ; $10F66C
        BCHG    D1,$004F(PC)                    ; $10F670
        ORI.W  #$0023,D1                        ; $10F674
        ORI.W  #$002E,(A7)                      ; $10F678
        DC.W    $007C,$047A,$004C   ; $10F67C ORI.W  #$047A,#$004C
        DC.W    $003F,$047A         ; $10F682 ORI.B  #$047A,<EA:3F>
        ORI.W  #$0211,$007C(A3)                 ; $10F686
        BCHG    D1,$0056(PC)                    ; $10F68C
        ORI.W  #$004C,D4                        ; $10F690
        SUBI.W  #$002B,$0311(PC)                ; $10F694
        ORI.W  #$007F,D5                        ; $10F69A
        BCHG    D1,$005F(PC)                    ; $10F69E
        ORI.W  #$007C,(A0)+                     ; $10F6A2
        BCHG    D1,$007F(PC)                    ; $10F6A6
        DC.W    $002D,$0111,$0015   ; $10F6AA ORI.B  #$0111,$0015(A5)
        DC.W    $0006,$5700         ; $10F6B0 ORI.B  #$5700,D6
        ORI.W  #$5700,D4                        ; $10F6B4
        DC.W    $0006,$001B         ; $10F6B8 ORI.B  #$001B,D6
        BTST    D0,(A1)                         ; $10F6BC
        DC.W    $0025,$0057         ; $10F6BE ORI.B  #$0057,-(A5)
        BCLR    D2,D0                           ; $10F6C2
        ORI.L  #$013F074C,D1                    ; $10F6C4
        DC.W    $0028,$047A,$0067   ; $10F6CA ORI.B  #$047A,$0067(A0)
        DC.W    $001D,$007C         ; $10F6D0 ORI.B  #$007C,(A5)+
        ANDI.W  #$007F,$0034(PC)                ; $10F6D4
        BTST    D0,(A1)                         ; $10F6DA
        DC.W    $007C,$037A,$0056   ; $10F6DC ORI.W  #$037A,#$0056
        DC.W    $0029,$006B,$047A   ; $10F6E2 ORI.B  #$006B,$047A(A1)
        ORI.W  #$0C4C,$023F(A3)                 ; $10F6E8
        ORI.W  #$0111,D5                        ; $10F6EE
        ORI.W  #$0056,D7                        ; $10F6F2
        BCHG    D1,$007C(PC)                    ; $10F6F6
        ORI.W  #$004F,-(A0)                     ; $10F6FA
        BCHG    D1,$0056(PC)                    ; $10F6FE
        DC.W    $002B,$014C,$002B   ; $10F702 ORI.B  #$014C,$002B(A3)
        ORI.W  #$047A,A7                        ; $10F708
        ORI.W  #$003F,A4                        ; $10F70C
        SUBI.W  #$006B,$0111(PC)                ; $10F710
        ORI.W  #$0056,-(A4)                     ; $10F716
        BCHG    D1,$0027(PC)                    ; $10F71A
        DC.W    $0025,$0022         ; $10F71E ORI.B  #$0022,-(A5)
        SUBI.W  #$004E,$003A(PC)                ; $10F722
        DC.W    $013F               ; $10F728 BTST    D0,<EA:3F>
        ORI.L  #$007E047A,D2                    ; $10F72A
        DC.W    $007C,$001F,$004C   ; $10F730 ORI.W  #$001F,#$004C
        SUBI.W  #$006B,$0211(PC)                ; $10F736
        DC.W    $0013,$5700         ; $10F73C ORI.B  #$5700,(A3)
        DC.W    $0030,$5700,$0006   ; $10F740 ORI.B  #$5700,$06(A0,D0.W)
        DC.W    $001B,$0111         ; $10F746 ORI.B  #$0111,(A3)+
        DC.W    $0023,$007F         ; $10F74A ORI.B  #$007F,-(A3)
        MOVE.B  $0056(PC),$005E(A2)             ; $10F74E
        DC.W    $001E,$007C         ; $10F754 ORI.B  #$007C,(A6)+
        ANDI.W  #$007F,$0034(PC)                ; $10F758
        BTST    D0,(A1)                         ; $10F75E
        DC.W    $007C,$037A,$0056   ; $10F760 ORI.W  #$037A,#$0056
        DC.W    $0029,$006B,$157A   ; $10F766 ORI.B  #$006B,$157A(A1)
        DC.W    $007C,$0111,$0047   ; $10F76C ORI.W  #$0111,#$0047
        ORI.W  #$037A,(A6)                      ; $10F772
        DC.W    $007C,$0060,$004F   ; $10F776 ORI.W  #$0060,#$004F
        DC.W    $0E7A               ; $10F77C DC.W    $0E7A
        ORI.W  #$003F,A4                        ; $10F77E
        SUBI.W  #$006B,$0111(PC)                ; $10F782
        DC.W    $0022,$047A         ; $10F788 ORI.B  #$047A,-(A2)
        DC.W    $002B,$0064,$004F   ; $10F78C ORI.B  #$0064,$004F(A3)
        MOVEA.B $004B(PC),A0                    ; $10F792
        ORI.W  #$007F,D5                        ; $10F796
        BCHG    D1,$007C(PC)                    ; $10F79A
        DC.W    $0211,$0014         ; $10F79E ANDI.B  #$0014,(A1)
        SUBQ.B  #3,D0                           ; $10F7A2
        DC.W    $0033,$5700,$0006   ; $10F7A4 ORI.B  #$5700,$06(A3,D0.W)
        DC.W    $001B,$0111         ; $10F7AA ORI.B  #$0111,(A3)+
        DC.W    $003C,$007D,$157A   ; $10F7AE ORI.B  #$007D,#$157A
        ORI.W  #$0033,-(A7)                     ; $10F7B4
        ORI.W  #$037A,D3                        ; $10F7B8
        DC.W    $007F,$0034         ; $10F7BC ORI.W  #$0034,<EA:3F>
        BTST    D0,(A1)                         ; $10F7C0
        DC.W    $007C,$037A,$0056   ; $10F7C2 ORI.W  #$037A,#$0056
        DC.W    $0029,$006B,$157A   ; $10F7C8 ORI.B  #$006B,$157A(A1)
        ORI.W  #$005D,A7                        ; $10F7CE
        DC.W    $0011,$0047         ; $10F7D2 ORI.B  #$0047,(A1)
        ORI.W  #$037A,(A6)                      ; $10F7D6
        DC.W    $007C,$0060,$004F   ; $10F7DA ORI.W  #$0060,#$004F
        DC.W    $0E7A               ; $10F7E0 DC.W    $0E7A
        ORI.W  #$003F,A4                        ; $10F7E2
        SUBI.W  #$006B,$0011(PC)                ; $10F7E6
        DC.W    $002D,$0056,$037A   ; $10F7EC ORI.B  #$0056,$037A(A5)
        DC.W    $007D,$0045         ; $10F7F2 ORI.W  #$0045,<EA:3D>
        ORI.W  #$007F,A3                        ; $10F7F6
        MOVEA.B $0022(PC),A0                    ; $10F7FA
        ORI.W  #$007C,(A6)+                     ; $10F7FE
        SUBI.W  #$003F,$0111(PC)                ; $10F802
        DC.W    $0012,$000E         ; $10F808 ORI.B  #$000E,(A2)
        ADDQ.B  #3,D0                           ; $10F80C
        DC.W    $0036,$5700,$0006   ; $10F80E ORI.B  #$5700,$06(A6,D0.W)
        DC.W    $001B,$0111         ; $10F814 ORI.B  #$0111,(A3)+
        DC.W    $003C,$007D,$147A   ; $10F818 ORI.B  #$007D,#$147A
        ORI.W  #$0023,(A6)                      ; $10F81E
        DC.W    $0033,$007C,$037A   ; $10F822 ORI.B  #$007C,$7A(A3,D0.W)
        ORI.W  #$0044,(A6)                      ; $10F828
        BTST    D0,(A1)                         ; $10F82C
        DC.W    $007C,$037A,$0056   ; $10F82E ORI.W  #$037A,#$0056
        DC.W    $0029,$006B,$157A   ; $10F834 ORI.B  #$006B,$157A(A1)
        ORI.W  #$005D,A7                        ; $10F83A
        DC.W    $0011,$0047         ; $10F83E ORI.B  #$0047,(A1)
        ORI.W  #$037A,(A6)                      ; $10F842
        DC.W    $007C,$0060,$004F   ; $10F846 ORI.W  #$0060,#$004F
        DC.W    $0E7A               ; $10F84C DC.W    $0E7A
        ORI.W  #$003F,A4                        ; $10F84E
        SUBI.W  #$006B,$0011(PC)                ; $10F852
        ORI.W  #$007D,A3                        ; $10F858
        BCHG    D1,$007E(PC)                    ; $10F85C
        DC.W    $001F,$004C         ; $10F860 ORI.B  #$004C,(A7)+
        BCHG    D1,$007F(PC)                    ; $10F864
        DC.W    $0021,$007F         ; $10F868 ORI.B  #$007F,-(A1)
        EORI.W  #$0083,$0041(PC)                ; $10F86C
        ORI.W  #$047A,(A2)                      ; $10F872
        DC.W    $0022,$0211         ; $10F876 ORI.B  #$0211,-(A2)
        DC.W    $000A,$5600         ; $10F87A ORI.B  #$5600,A2
        DC.W    $003A,$5700,$0006   ; $10F87E ORI.B  #$5700,$0006(PC)
        DC.W    $001B,$0111         ; $10F884 ORI.B  #$0111,(A3)+
        DC.W    $003C,$007D,$137A   ; $10F888 ORI.B  #$007D,#$137A
        ORI.W  #$0028,-(A5)                     ; $10F88E
        DC.W    $0033,$004C,$047A   ; $10F892 ORI.B  #$004C,$7A(A3,D0.W)
        ORI.W  #$001D,-(A7)                     ; $10F898
        BTST    D0,(A1)                         ; $10F89C
        DC.W    $007C,$037A,$0056   ; $10F89E ORI.W  #$037A,#$0056
        DC.W    $0029,$0027,$157A   ; $10F8A4 ORI.B  #$0027,$157A(A1)
        ORI.W  #$005D,A7                        ; $10F8AA
        DC.W    $0011,$0033         ; $10F8AE ORI.B  #$0033,(A1)
        ORI.W  #$037A,A7                        ; $10F8B2
        DC.W    $007C,$0060,$004E   ; $10F8B6 ORI.W  #$0060,#$004E
        DC.W    $0E7A               ; $10F8BC DC.W    $0E7A
        ORI.W  #$003F,A4                        ; $10F8BE
        SUBI.W  #$006B,$001D(PC)                ; $10F8C2
        DC.W    $0027,$037A         ; $10F8C8 ORI.B  #$037A,-(A7)
        ORI.W  #$005E,(A6)                      ; $10F8CC
        ORI.W  #$007C,D7                        ; $10F8D0
        BCHG    D1,$006B(PC)                    ; $10F8D4
        DC.W    $0025,$004F         ; $10F8D8 ORI.B  #$004F,-(A5)
        BCHG    D1,$0684(PC)                    ; $10F8DC
        ORI.W  #$0023,(A6)                      ; $10F8E0
        DC.W    $0029,$0065,$0384   ; $10F8E4 ORI.B  #$0065,$0384(A1)
        ORI.W  #$0025,A6                        ; $10F8EA
        BTST    D0,(A1)                         ; $10F8EE
        DC.W    $0019,$0006         ; $10F8F0 ORI.B  #$0006,(A1)+
        SUBQ.B  #2,D0                           ; $10F8F4
        DC.W    $003C,$5700,$0006   ; $10F8F6 ORI.B  #$5700,#$0006
        DC.W    $001B,$0111         ; $10F8FC ORI.B  #$0111,(A3)+
        DC.W    $003C,$007D,$117A   ; $10F900 ORI.B  #$007D,#$117A
        DC.W    $007C,$0067,$0047   ; $10F906 ORI.W  #$0067,#$0047
        ORI.W  #$0029,D1                        ; $10F90C
        ORI.W  #$047A,A6                        ; $10F910
        DC.W    $002E,$0211,$005F   ; $10F914 ORI.B  #$0211,$005F(A6)
        BCHG    D1,$0056(PC)                    ; $10F91A
        DC.W    $0029,$0041,$0067   ; $10F91E ORI.B  #$0041,$0067(A1)
        MOVEA.B $004F(PC),A2                    ; $10F924
        ORI.W  #$0011,(A5)+                     ; $10F928
        ORI.W  #$004E,D1                        ; $10F92C
        BCHG    D1,$007C(PC)                    ; $10F930
        DC.W    $001D,$0044         ; $10F934 ORI.B  #$0044,(A5)+
        ORI.W  #$0D84,A7                        ; $10F938
        ORI.W  #$003F,A4                        ; $10F93C
        ORI.W  #$0384,$006B(PC)                 ; $10F940
        ORI.W  #$0056,D4                        ; $10F946
        BCLR    D1,D4                           ; $10F94A
        ORI.W  #$001D,A7                        ; $10F94C
        ORI.W  #$0384,-(A3)                     ; $10F950
        ORI.W  #$002D,(A6)                      ; $10F954
        DC.W    $0011,$004F         ; $10F958 ORI.B  #$004F,(A1)
        BCLR    D5,D4                           ; $10F95C
        ORI.W  #$0085,$27(A2,D0.W)              ; $10F95E
        BCLR    D1,D4                           ; $10F964
        ORI.L  #$00230111,D6                    ; $10F966
        DC.W    $001B,$000E         ; $10F96C ORI.B  #$000E,(A3)+
        SUBQ.B  #2,D0                           ; $10F970
        DC.W    $003A,$5700,$0006   ; $10F972 ORI.B  #$5700,$0006(PC)
        DC.W    $001B,$0111         ; $10F978 ORI.B  #$0111,(A3)+
        ORI.W  #$004E,A0                        ; $10F97C
        MOVEA.B #$003F,A0                       ; $10F980
        BTST    D0,(A5)+                        ; $10F984
        DC.W    $001E,$0027         ; $10F986 ORI.B  #$0027,(A6)+
        ORI.W  #$047A,-(A5)                     ; $10F98A
        DC.W    $007C,$005D,$0211   ; $10F98E ORI.W  #$005D,#$0211
        DC.W    $0027,$0484         ; $10F994 ORI.B  #$0484,-(A7)
        ORI.W  #$001D,(A7)+                     ; $10F998
        ORI.W  #$005F,D1                        ; $10F99C
        MOVE.B  #$0027,$0211(A1)                ; $10F9A0
        DC.W    $002E,$0484,$0037   ; $10F9A6 ORI.B  #$0484,$0037(A6)
        DC.W    $001E,$0020         ; $10F9AC ORI.B  #$0020,(A6)+
        DC.W    $003E,$0B4F         ; $10F9B0 ORI.B  #$0B4F,<EA:3E>
        DC.W    $003E,$0068         ; $10F9B4 ORI.B  #$0068,<EA:3E>
        ORI.W  #$0484,A1                        ; $10F9B8
        DC.W    $003E,$0027         ; $10F9BC ORI.B  #$0027,<EA:3E>
        ORI.W  #$0384,$0072(A4)                 ; $10F9C0
        DC.W    $001F,$0055         ; $10F9C6 ORI.B  #$0055,(A7)+
        BCLR    D1,D4                           ; $10F9CA
        ORI.W  #$0025,$0011(A4)                 ; $10F9CC
        ORI.W  #$0B4F,D6                        ; $10F9D2
        ORI.W  #$0060,-(A7)                     ; $10F9D6
        DC.W    $001F,$0055         ; $10F9DA ORI.B  #$0055,(A7)+
        BCLR    D1,D4                           ; $10F9DE
        ORI.W  #$0211,$001C(A0)                 ; $10F9E0
        DC.W    $0001,$5400         ; $10F9E6 ORI.B  #$5400,D1
        DC.W    $0032,$5700,$0006   ; $10F9EA ORI.B  #$5700,$06(A2,D0.W)
        DC.W    $001B,$0111         ; $10F9F0 ORI.B  #$0111,(A3)+
        ORI.W  #$0033,(A5)+                     ; $10F9F4
        BCHG    D7,(A0)+                        ; $10F9F8
        BTST    D0,$4B(A3,D0.W)                 ; $10F9FA
        DC.W    $003E,$004F         ; $10F9FE ORI.B  #$004F,<EA:3E>
        BCLR    D2,D4                           ; $10FA02
        ORI.W  #$002E,$0311(A4)                 ; $10FA04
        DC.W    $0033,$0055,$0484   ; $10FA0A ORI.B  #$0055,-$7C(A3,D0.W)
        ORI.W  #$1558,-$79(A2,D0.W)             ; $10FA10
        DC.W    $0211,$0068         ; $10FA16 ANDI.B  #$0068,(A1)
        SUBI.L  #$00880089,D4                   ; $10FA1A
        BCHG    D7,(A0)+                        ; $10FA20
        ORI.W  #$0584,A5                        ; $10FA22
        ORI.W  #$0384,(A6)                      ; $10FA26
        ORI.W  #$0158,(A6)                      ; $10FA2A
        ORI.W  #$0384,(A6)                      ; $10FA2E
        ORI.W  #$001E,$11(A2,D0.W)              ; $10FA32
        BCHG    D4,(A0)+                        ; $10FA38
        BCHG    D0,D7                           ; $10FA3A
        BTST    D0,$0041(A1)                    ; $10FA3C
        ORI.W  #$0056,D7                        ; $10FA40
        BCLR    D1,D4                           ; $10FA44
        ORI.W  #$0041,A7                        ; $10FA46
        BTST    D0,(A1)                         ; $10FA4A
        DC.W    $000C,$0001         ; $10FA4C ORI.B  #$0001,A4
        ADDQ.B  #2,D0                           ; $10FA50
        DC.W    $0029,$5700,$0006   ; $10FA52 ORI.B  #$5700,$0006(A1)
        DC.W    $001B,$0111         ; $10FA58 ORI.B  #$0111,(A3)+
        ORI.W  #$004F,-(A2)                     ; $10FA5C
        MOVE.B  (A6),$0086(A0)                  ; $10FA60
        ADDI.L  #$006C0089,D4                   ; $10FA64
        BTST    D2,(A1)                         ; $10FA6A
        ORI.L  #$05841556,A2                    ; $10FA6C
        DC.W    $003E,$005D         ; $10FA72 ORI.B  #$005D,<EA:3E>
        BTST    D0,(A1)                         ; $10FA76
        ORI.W  #$0032,(A0)+                     ; $10FA78
        SUBI.L  #$00880F56,D4                   ; $10FA7C
        ORI.L  #$0A8C004F,A3                    ; $10FA82
        ORI.W  #$0035,(A0)+                     ; $10FA88
        DC.W    $038C               ; $10FA8C BCLR    D1,A4
        ORI.W  #$0020,$0111(PC)                 ; $10FA8E
        ORI.W  #$0956,(A3)                      ; $10FA94
        SUBI.W  #$048C,$7A(PC,D0.W)             ; $10FA98
        DC.W    $0029,$0111,$0010   ; $10FA9E ORI.B  #$0111,$0010(A1)
        DC.W    $0002,$5400         ; $10FAA4 ORI.B  #$5400,D2
        DC.W    $0021,$5700         ; $10FAA8 ORI.B  #$5700,-(A1)
        DC.W    $0006,$001B         ; $10FAAC ORI.B  #$001B,D6
        BTST    D0,(A1)                         ; $10FAB0
        ORI.W  #$1984,D5                        ; $10FAB2
        ORI.W  #$0089,$005D(A4)                 ; $10FAB6
        BTST    D0,(A1)                         ; $10FABC
        DC.W    $0010,$0012         ; $10FABE ORI.B  #$0012,(A0)
        BTST    D0,(A1)                         ; $10FAC2
        ORI.W  #$0054,-(A2)                     ; $10FAC4
        MOVE.B  A4,(A5)                         ; $10FAC8
        ORI.W  #$001E,(A6)                      ; $10FACA
        DC.W    $0211,$0043         ; $10FACE ANDI.B  #$0043,(A1)
        MOVE.L  A4,$42(A0,D0.W)                 ; $10FAD2
        DC.W    $0025,$004F         ; $10FAD6 ORI.B  #$004F,-(A5)
        DC.W    $038C               ; $10FADA BCLR    D1,A4
        ORI.W  #$0064,$11(A4,D0.W)              ; $10FADC
        ORI.W  #$148C,(A6)                      ; $10FAE2
        DC.W    $0021,$0211         ; $10FAE6 ORI.B  #$0211,-(A1)
        DC.W    $000A,$5400         ; $10FAEA ORI.B  #$5400,A2
        DC.W    $0020,$5700         ; $10FAEE ORI.B  #$5700,-(A0)
        DC.W    $0006,$001B         ; $10FAF2 ORI.B  #$001B,D6
        BTST    D0,(A1)                         ; $10FAF6
        ORI.W  #$198C,D5                        ; $10FAF8
        DC.W    $003B,$005D,$0111   ; $10FAFC ORI.B  #$005D,$11(PC,D0.W)
        DC.W    $0012,$0008         ; $10FB02 ORI.B  #$0008,(A2)
        DC.W    $0009,$0211         ; $10FB06 ORI.B  #$0211,A1
        DC.W    $0037,$1A8C,$007B   ; $10FB0A ORI.B  #$1A8C,$7B(A7,D0.W)
        DC.W    $001E,$0211         ; $10FB10 ORI.B  #$0211,(A6)+
        DC.W    $001F,$005A         ; $10FB14 ORI.B  #$005A,(A7)+
        MOVE.B  A4,-$73(A7,D0.W)                ; $10FB18
        ORI.W  #$003F,D5                        ; $10FB1C
        SUBI.L  #$00280211,A4                   ; $10FB20
        ORI.W  #$148C,(A6)                      ; $10FB26
        ORI.W  #$0211,-(A5)                     ; $10FB2A
        ORI.W  #$5400,$22(A7,D0.W)              ; $10FB2E
        SUBQ.B  #3,D0                           ; $10FB34
        DC.W    $0006,$001B         ; $10FB36 ORI.B  #$001B,D6
        BTST    D0,(A1)                         ; $10FB3A
        ORI.W  #$188C,D5                        ; $10FB3C
        DC.W    $0021,$005D         ; $10FB40 ORI.B  #$005D,-(A1)
        DC.W    $0211,$000D         ; $10FB44 ANDI.B  #$000D,(A1)
        DC.W    $0006,$0017         ; $10FB48 ORI.B  #$0017,D6
        DC.W    $0019,$0211         ; $10FB4C ORI.B  #$0211,(A1)+
        ORI.L  #$198C007B,A6                    ; $10FB50
        DC.W    $001E,$0311         ; $10FB56 ORI.B  #$0311,(A6)+
        DC.W    $0025,$0035         ; $10FB5A ORI.B  #$0035,-(A5)
        MOVE.B  A4,(A7)                         ; $10FB5E
        ORI.W  #$002D,-(A5)                     ; $10FB60
        DC.W    $0027,$048C         ; $10FB64 ORI.B  #$048C,-(A7)
        DC.W    $002B,$0211,$0056   ; $10FB68 ORI.B  #$0211,$0056(A3)
        MOVE.B  A4,(A2)                         ; $10FB6E
        ORI.W  #$002C,$11(PC,D0.W)              ; $10FB70
        DC.W    $0002,$5300         ; $10FB76 ORI.B  #$5300,D2
        DC.W    $002B,$5700,$0006   ; $10FB7A ORI.B  #$5700,$0006(A3)
        DC.W    $001B,$0111         ; $10FB80 ORI.B  #$0111,(A3)+
        ORI.W  #$138C,D5                        ; $10FB84
        DC.W    $018F               ; $10FB88 BCLR    D0,A7
        ORI.W  #$002B,(A4)+                     ; $10FB8A
        DC.W    $003F,$005D         ; $10FB8E ORI.B  #$005D,<EA:3F>
        DC.W    $0211,$0015         ; $10FB92 ANDI.B  #$0015,(A1)
        DC.W    $0013,$0100         ; $10FB96 ORI.B  #$0100,(A3)
        DC.W    $0002,$0019         ; $10FB9A ORI.B  #$0019,D2
        DC.W    $0211,$003F         ; $10FB9E ANDI.B  #$003F,(A1)
        ORI.W  #$0174,(A7)+                     ; $10FBA2
        MOVE.B  A4,$7B(A2,D0.W)                 ; $10FBA6
        DC.W    $001E,$0411         ; $10FBAA ORI.B  #$0411,(A6)+
        ORI.W  #$0037,D1                        ; $10FBAE
        ORI.W  #$0074,-$70(A5,D0.W)             ; $10FBB2
        MOVE.B  A4,(A5)                         ; $10FBB8
        DC.W    $0021,$0033         ; $10FBBA ORI.B  #$0033,-(A1)
        ORI.W  #$038C,$0074(A3)                 ; $10FBBE
        DC.W    $002D,$0211,$0056   ; $10FBC4 ORI.B  #$0211,$0056(A5)
        MOVE.B  A4,$5A(A2,D0.W)                 ; $10FBCA
        DC.W    $0211,$0008         ; $10FBCE ANDI.B  #$0008,(A1)
        SUBQ.B  #1,D0                           ; $10FBD2
        DC.W    $002E,$5700,$0006   ; $10FBD4 ORI.B  #$5700,$0006(A6)
        DC.W    $001B,$0111         ; $10FBDA ORI.B  #$0111,(A3)+
        DC.W    $0023,$0056         ; $10FBDE ORI.B  #$0056,-(A3)
        MOVEA.B $7B(A4,D0.W),A0                 ; $10FBE2
        DC.W    $0021,$0023         ; $10FBE6 ORI.B  #$0023,-(A1)
        DC.W    $0034,$0033,$0311   ; $10FBEA ORI.B  #$0033,$11(A4,D0.W)
        DC.W    $0010,$001C         ; $10FBF0 ORI.B  #$001C,(A0)
        DC.W    $000E,$0300         ; $10FBF4 ORI.B  #$0300,A6
        DC.W    $0008,$0016         ; $10FBF8 ORI.B  #$0016,A0
        DC.W    $0211,$001D         ; $10FBFC ANDI.B  #$001D,(A1)
        DC.W    $002D,$0045,$005C   ; $10FC00 ORI.B  #$0045,$005C(A5)
        MOVEA.B $5C(PC,D0.W),A2                 ; $10FC06
        DC.W    $001E,$0611         ; $10FC0A ORI.B  #$0611,(A6)+
        ORI.W  #$0034,D7                        ; $10FC0E
        DC.W    $003B,$0065,$197B   ; $10FC12 ORI.B  #$0065,$7B(PC,D1.L)
        ORI.W  #$0045,D2                        ; $10FC18
        ORI.W  #$037B,-(A5)                     ; $10FC1C
        DC.W    $0035,$0311,$0091   ; $10FC20 ORI.B  #$0311,-$6F(A5,D0.W)
        ORI.W  #$1474,$6B(PC,D0.W)              ; $10FC26
        DC.W    $0211,$000C         ; $10FC2C ANDI.B  #$000C,(A1)
        DC.W    $0006,$5200         ; $10FC30 ORI.B  #$5200,D6
        DC.W    $0022,$5700         ; $10FC34 ORI.B  #$5700,-(A2)
        DC.W    $0006,$001B         ; $10FC38 ORI.B  #$001B,D6
        BTST    D0,(A1)                         ; $10FC3C
        ORI.W  #$1241,(A5)+                     ; $10FC3E
        ORI.W  #$0511,(A5)+                     ; $10FC42
        DC.W    $0010,$0005         ; $10FC46 ORI.B  #$0005,(A0)
        DC.W    $0001,$0500         ; $10FC4A ORI.B  #$0500,D1
        DC.W    $0008,$0019         ; $10FC4E ORI.B  #$0019,A0
        SUBI.B  #$001E,(A1)                     ; $10FC52
        MOVEA.B D1,A2                           ; $10FC56
        ORI.W  #$0311,-(A0)                     ; $10FC58
        DC.W    $000D,$0511         ; $10FC5C ORI.B  #$0511,A5
        DC.W    $0025,$1941         ; $10FC60 ORI.B  #$1941,-(A5)
        DC.W    $001E,$005D         ; $10FC64 ORI.B  #$005D,(A6)+
        DC.W    $0025,$0341         ; $10FC68 ORI.B  #$0341,-(A5)
        DC.W    $001F,$0311         ; $10FC6C ORI.B  #$0311,(A7)+
        DC.W    $0025,$1541         ; $10FC70 ORI.B  #$1541,-(A5)
        DC.W    $0025,$0311         ; $10FC74 ORI.B  #$0311,-(A5)
        DC.W    $0017,$5200         ; $10FC78 ORI.B  #$5200,(A7)
        DC.W    $000F,$5700         ; $10FC7C ORI.B  #$5700,A7
        DC.W    $0006,$001B         ; $10FC80 ORI.B  #$001B,D6
        MOVE.B  (A1),D5                         ; $10FC84
        DC.W    $001A,$0014         ; $10FC86 ORI.B  #$0014,(A2)+
        DC.W    $000E,$0800         ; $10FC8A ORI.B  #$0800,A6
        DC.W    $000E,$0014         ; $10FC8E ORI.B  #$0014,A6
        MOVE.B  (A1),D7                         ; $10FC92
        DC.W    $0005,$000A         ; $10FC94 ORI.B  #$000A,D5
        DC.W    $4711               ; $10FC98 DC.W    $4711
        DC.W    $0008,$5200         ; $10FC9A ORI.B  #$5200,A0
        DC.W    $0016,$5700         ; $10FC9E ORI.B  #$5700,(A6)
        DC.W    $0006,$0010         ; $10FCA2 ORI.B  #$0010,D6
        MOVE.B  (A1),-(A3)                      ; $10FCA6
        DC.W    $0012,$0010         ; $10FCA8 ORI.B  #$0010,(A2)
        ORI.W  #$0013,$00(A7,D0.L)              ; $10FCAC
        DC.W    $0001,$0009         ; $10FCB2 ORI.B  #$0009,D1
        DC.W    $000F,$001B         ; $10FCB6 ORI.B  #$001B,A7
        MOVE.B  (A1),-(A5)                      ; $10FCBA
        DC.W    $0005,$0000         ; $10FCBC ORI.B  #$0000,D5
        DC.W    $0013,$001C         ; $10FCC0 ORI.B  #$001C,(A3)
        DC.W    $001B,$4411         ; $10FCC4 ORI.B  #$4411,(A3)+
        DC.W    $0024,$0006         ; $10FCC8 ORI.B  #$0006,-(A4)
        SUBQ.B  #8,D0                           ; $10FCCC
        DC.W    $0019,$5700         ; $10FCCE ORI.B  #$5700,(A1)+
        DC.W    $0001,$0004         ; $10FCD2 ORI.B  #$0004,D1
        MOVE.B  A5,-(A2)                        ; $10FCD6
        DC.W    $000F,$0007         ; $10FCD8 ORI.B  #$0007,A7
        DC.W    $0002,$0106         ; $10FCDC ORI.B  #$0106,D2
        DC.W    $0E00               ; $10FCE0 DC.W    $0E00
        DC.W    $0006,$0013         ; $10FCE2 ORI.B  #$0013,D6
        DC.W    $001C,$000F         ; $10FCE6 ORI.B  #$000F,(A4)+
        MOVE.B  A5,D4                           ; $10FCEA
        DC.W    $000F,$0013         ; $10FCEC ORI.B  #$0013,A7
        BTST    D0,D0                           ; $10FCF0
        DC.W    $0001,$0013         ; $10FCF2 ORI.B  #$0013,D1
        DC.W    $000A,$001C         ; $10FCF6 ORI.B  #$001C,A2
        DC.W    $000C,$410D         ; $10FCFA ORI.B  #$410D,A4
        DC.W    $0004,$0001         ; $10FCFE ORI.B  #$0001,D4
        SUBQ.B  #8,D0                           ; $10FD02
        DC.W    $0007,$5800         ; $10FD04 ORI.B  #$5800,D7
        MOVE.B  D1,D4                           ; $10FD08
        MOVE.B  D0,-(A1)                        ; $10FD0A
        MOVE.B  D1,D6                           ; $10FD0C
        SUBI.B  #$4401,D0                       ; $10FD0E
        ORI.L  #$51000001,(A2)                  ; $10FD12
        MOVE.W  D0,-(A7)                        ; $10FD18
        MOVE.W  D0,-(A7)                        ; $10FD1A
        DC.W    $0001,$FF00         ; $10FD1C ORI.B  #$FF00,D1
        MOVE.W  D0,-(A7)                        ; $10FD20
        DC.W    $0001,$FF00         ; $10FD22 ORI.B  #$FF00,D1
        MOVE.W  D0,-(A7)                        ; $10FD26
        ORI.L  #$00390100,-(A7)                 ; $10FD28
        DC.W    $0000,$0842         ; $10FD2E ORI.B  #$0842,D0
        CMPI.W  #$1084,-(A3)                    ; $10FD32
        MOVE.B  -(A5),(A2)                      ; $10FD36
        MOVE.B  D6,(A4)+                        ; $10FD38
        MOVE.B  -(A7),(A6)+                     ; $10FD3A
        MOVE.L  A0,-(A0)                        ; $10FD3C
loc_10FD3E:
        MOVE.L  $294A(A1),-(A2)                 ; $10FD3E
        MOVE.W  A6,#$4631                       ; $10FD42
        CLR.B  (A0)                             ; $10FD46
        DC.W    $3DEF,$35AD         ; $10FD48 MOVE.W  $35AD(A7),<EA:3E>
        MOVE.W  A4,$6B(A0,D2.L)                 ; $10FD4C
        SUBI.B  #$4E73,-(A1)                    ; $10FD50
        ADDQ.L  #1,(A4)                         ; $10FD54
        SPL     (A6)                            ; $10FD56
        BLS.S  loc_10FD72                       ; $10FD58
        BEQ.S  loc_10FD95                       ; $10FD5A
loc_10FD5C:
        BLE.S  loc_10FDD9                       ; $10FD5C
        DC.W    $77BD,$7BDE         ; $10FD5E MOVE.W  <EA:3D>,-$22(A3,D7.L)
        DC.W    $7FFF               ; $10FD62 MOVE.W  <EA:3F>,<EA:3F>
        BMI.S  loc_10FDC0                       ; $10FD64
        MOVE.W  (A4)+,-$09(A1,D5.L)             ; $10FD66
        DC.W    $7FFE               ; $10FD6A MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $7FDE               ; $10FD6C MOVE.W  (A6)+,<EA:3F>
        DC.W    $7FDD               ; $10FD6E MOVE.W  (A5)+,<EA:3F>
        MOVE.W  #$7FBB,-$66(A7,D7.L)            ; $10FD70
        MOVE.W  (A1)+,$78(A7,D7.L)              ; $10FD76
        MOVE.W  $56(A7,D7.L),$7F75(A7)          ; $10FD7A
        MOVE.W  (A5),$7F34(A5)                  ; $10FD80
        MOVE.W  $76(A3,D7.L),-(A7)              ; $10FD84
        MOVE.W  (A0),-(A7)                      ; $10FD88
        MOVEQ   #-$31,D5                        ; $10FD8A
        MOVEQ   #-$32,D5                        ; $10FD8C
        MOVEQ   #-$11,D5                        ; $10FD8E
        MOVEQ   #-$10,D5                        ; $10FD90
        MOVEQ   #-$0F,D5                        ; $10FD92
loc_10FD94:
        MOVE.W  (A1),-(A5)                      ; $10FD94
        MOVE.W  (A3),-(A5)                      ; $10FD96
        MOVEQ   #-$50,D1                        ; $10FD98
        BGT.S  loc_10FD6D                       ; $10FD9A
loc_10FD9C:
        MOVEQ   #-$2F,D1                        ; $10FD9C
        MOVE.W  (A7),$4A52(A5)                  ; $10FD9E
        ADDQ.L  #3,-$24(A5,D7.L)                ; $10FDA2
        MOVE.W  (A4),-(A3)                      ; $10FDA6
loc_10FDA8:
        BGT.S  loc_10FD9C                       ; $10FDA8
        BGT.S  loc_10FD5C                       ; $10FDAA
        BPL.S  loc_10FD3D                       ; $10FDAC
        BPL.S  loc_10FD3E                       ; $10FDAE
loc_10FDB0:
        BPL.S  loc_10FE1F                       ; $10FDB0
        BPL.S  loc_10FE20                       ; $10FDB2
        BNE.S  loc_10FE00                       ; $10FDB4
        BNE.S  loc_10FDE2                       ; $10FDB6
        BNE.S  loc_10FDE3                       ; $10FDB8
        BPL.S  loc_10FDE5                       ; $10FDBA
        BPL.S  loc_10FDE6                       ; $10FDBC
        BPL.S  loc_10FDE7                       ; $10FDBE
loc_10FDC0:
        BGT.S  loc_10FDC7                       ; $10FDC0
        BGT.S  loc_10FDEB                       ; $10FDC2
        MOVEQ   #-$53,D5                        ; $10FDC4
        MOVEQ   #$05,D3                         ; $10FDC6
        MOVEQ   #$04,D1                         ; $10FDC8
        MOVEQ   #-$0F,D1                        ; $10FDCA
        BPL.S  loc_10FE19                       ; $10FDCC
        BCS.S  loc_10FD94                       ; $10FDCE
        BCS.S  loc_10FDB7                       ; $10FDD0
        BGT.S  loc_10FD83                       ; $10FDD2
loc_10FDD4:
        MOVE.W  (A2),-(A3)                      ; $10FDD4
loc_10FDD6:
        MOVE.W  (A4),$76D0(A7)                  ; $10FDD6
        MOVEQ   #-$31,D3                        ; $10FDDA
        MOVEQ   #-$52,D1                        ; $10FDDC
        BGT.S  loc_10FD6D                       ; $10FDDE
        BGT.S  loc_10FE4E                       ; $10FDE0
loc_10FDE2:
        BPL.S  loc_10FE2E                       ; $10FDE2
loc_10FDE4:
        MOVE.W  -$1B(A5,D6.W),-(A3)             ; $10FDE4
        BSR.S  loc_10FDAF                       ; $10FDE8
        BSR.S  loc_10FDB0                       ; $10FDEA
        BSR.S  loc_10FDB1                       ; $10FDEC
        BVS.S  loc_10FDD4                       ; $10FDEE
        BLT.S  loc_10FDD6                       ; $10FDF0
        MOVE.W  (A7),-$74(A7,D7.L)              ; $10FDF2
        MOVEQ   #$46,D3                         ; $10FDF6
        BGT.S  loc_10FDFE                       ; $10FDF8
        BCS.S  loc_10FDE2                       ; $10FDFA
        MOVE.W  (A3),-(A3)                      ; $10FDFC
loc_10FDFE:
        MOVE.W  -$11(A2,D7.L),-(A7)             ; $10FDFE
        MOVEQ   #-$54,D5                        ; $10FE02
        MOVEQ   #$25,D1                         ; $10FE04
        MOVEQ   #$05,D1                         ; $10FE06
        BNE.S  loc_10FE11                       ; $10FE08
        MOVEQ   #$69,D3                         ; $10FE0A
        MOVE.W  (A6),$7FD9(A5)                  ; $10FE0C
        MOVEQ   #-$75,D5                        ; $10FE10
        MOVEQ   #-$55,D5                        ; $10FE12
        DC.W    $7FDA               ; $10FE14 MOVE.W  (A2)+,<EA:3F>
        MOVEQ   #-$2E,D1                        ; $10FE16
        BGT.S  loc_10FDA8                       ; $10FE18
        MOVE.W  $7A8A.W,$06(A7,D6.L)            ; $10FE1A
loc_10FE20:
        BPL.S  loc_10FE29                       ; $10FE20
        BGT.S  loc_10FE6C                       ; $10FE22
        MOVEQ   #$48,D1                         ; $10FE24
loc_10FE26:
        MOVEQ   #-$76,D3                        ; $10FE26
        MOVEQ   #-$55,D3                        ; $10FE28
        MOVEQ   #$6A,D1                         ; $10FE2A
        BGT.S  loc_10FE77                       ; $10FE2C
loc_10FE2E:
        BPL.S  loc_10FE79                       ; $10FE2E
        MOVEQ   #$68,D5                         ; $10FE30
        BVS.S  loc_10FE19                       ; $10FE32
        BGT.S  loc_10FDE4                       ; $10FE34
        MOVEQ   #-$30,D1                        ; $10FE36
        MOVE.W  $34(A3,D7.L),-(A5)              ; $10FE38
        MOVE.W  (A0)+,-$05(A7,D7.L)             ; $10FE3C
        DC.W    $7FB9,$7FBA,$7B78,$76F1; $10FE40 MOVE.W  $7FBA7B78,-$0F(A7,D7.W)
loc_10FE48:
        MOVE.W  (A6),$7734(A3)                  ; $10FE48
        MOVEQ   #-$0E,D1                        ; $10FE4C
loc_10FE4E:
        MOVEQ   #-$31,D1                        ; $10FE4E
loc_10FE50:
        MOVEQ   #-$73,D1                        ; $10FE50
        MOVEQ   #-$74,D1                        ; $10FE52
        MOVEQ   #-$75,D1                        ; $10FE54
loc_10FE56:
        MOVE.W  (A2),-(A7)                      ; $10FE56
        BGT.S  loc_10FEA1                       ; $10FE58
        BPL.S  loc_10FE60                       ; $10FE5A
        DC.W    $7FFC,$7668         ; $10FE5C MOVE.W  #$7668,<EA:3F>
loc_10FE60:
        BSR.S  loc_10FE48                       ; $10FE60
        BHI.S  loc_10FE6A                       ; $10FE62
loc_10FE64:
        SLT     D3                              ; $10FE64
        MOVE.W  (A6),-$51(A7,D7.W)              ; $10FE66
loc_10FE6A:
        BGT.S  loc_10FED7                       ; $10FE6A
loc_10FE6C:
        SUBQ.L  #6,-(A4)                        ; $10FE6C
loc_10FE6E:
        SLT     D5                              ; $10FE6E
loc_10FE70:
        BSR.S  loc_10FE56                       ; $10FE70
        BCS.S  loc_10FE37                       ; $10FE72
        MOVEQ   #-$54,D1                        ; $10FE74
        BVS.S  loc_10FE5B                       ; $10FE76
        BGT.S  loc_10FE7D                       ; $10FE78
        MOVEQ   #$26,D1                         ; $10FE7A
loc_10FE7C:
        BLT.S  loc_10FE61                       ; $10FE7C
        MOVEQ   #$03,D1                         ; $10FE7E
loc_10FE80:
        BVS.S  loc_10FE45                       ; $10FE80
loc_10FE82:
        BSR.S  loc_10FE27                       ; $10FE82
        SUBQ.L  #6,-(A3)                        ; $10FE84
        MOVEQ   #$47,D1                         ; $10FE86
        BPL.S  loc_10FE8F                       ; $10FE88
        BNE.S  loc_10FE91                       ; $10FE8A
        MOVE.W  $11(A6,D7.L),-(A3)              ; $10FE8C
        MOVEQ   #-$54,D7                        ; $10FE90
        MOVE.W  A7,-(A7)                        ; $10FE92
loc_10FE94:
        BGT.S  loc_10FEBA                       ; $10FE94
loc_10FE96:
        SUBQ.L  #6,-(A2)                        ; $10FE96
loc_10FE98:
        BGT.S  loc_10FE26                       ; $10FE98
        BGT.S  loc_10FEE6                       ; $10FE9A
        BGT.S  loc_10FE6E                       ; $10FE9C
        BGT.S  loc_10FF0A                       ; $10FE9E
        MOVEQ   #-$34,D7                        ; $10FEA0
        MOVE.W  -$32(A4,D7.L),$7F95(A7)         ; $10FEA2
        MOVEQ   #-$52,D3                        ; $10FEA8
        BVS.S  loc_10FE6E                       ; $10FEAA
        BSR.S  loc_10FE50                       ; $10FEAC
        BGT.S  loc_10FED8                       ; $10FEAE
        BLT.S  loc_10FE94                       ; $10FEB0
        MOVE.W  D2,$7EAA.W                      ; $10FEB2
        BSR.S  loc_10FE39                       ; $10FEB6
        SUBQ.L  #6,-(A1)                        ; $10FEB8
loc_10FEBA:
        MOVEQ   #-$53,D3                        ; $10FEBA
        BCS.S  loc_10FE80                       ; $10FEBC
        BLT.S  loc_10FE82                       ; $10FEBE
        BCS.S  loc_10FE64                       ; $10FEC0
        BSR.S  loc_10FE46                       ; $10FEC2
        SUBQ.L  #6,D1                           ; $10FEC4
        BCS.S  loc_10FE8D                       ; $10FEC6
        MOVEQ   #$24,D1                         ; $10FEC8
        MOVEQ   #-$0F,D7                        ; $10FECA
        BVS.S  loc_10FE70                       ; $10FECC
        MOVE.W  -(A4),$7648.W                   ; $10FECE
        MOVEQ   #$6B,D1                         ; $10FED2
        MOVEQ   #-$72,D1                        ; $10FED4
        BSR.S  loc_10FE7C                       ; $10FED6
loc_10FED8:
        BCS.S  loc_10FE7D                       ; $10FED8
        MOVEQ   #$4A,D1                         ; $10FEDA
        SUBQ.L  #6,D2                           ; $10FEDC
        SUBQ.L  #4,D1                           ; $10FEDE
        SUBQ.L  #4,D2                           ; $10FEE0
        SUBQ.L  #4,-(A3)                        ; $10FEE2
        BHI.S  loc_10FEEF                       ; $10FEE4
loc_10FEE6:
        MOVEQ   #$27,D1                         ; $10FEE6
        MOVEQ   #-$0D,D1                        ; $10FEE8
loc_10FEEA:
        SUBQ.L  #4,D0                           ; $10FEEA
        SUBQ.L  #6,D0                           ; $10FEEC
        MOVEQ   #-$32,D1                        ; $10FEEE
        MOVE.W  -$3F(A1,D6.L),-(A7)             ; $10FEF0
        BCS.S  loc_10FE97                       ; $10FEF4
        BSR.S  loc_10FE98                       ; $10FEF6
        MOVEQ   #-$77,D3                        ; $10FEF8
        MOVE.W  (A5),$7312(A3)                  ; $10FEFA
        BCS.S  loc_10FEC1                       ; $10FEFE
        MOVE.W  (A7),$6649(A7)                  ; $10FF00
        BPL.S  loc_10FF70                       ; $10FF04
        MOVEQ   #-$11,D3                        ; $10FF06
        MOVEQ   #-$54,D3                        ; $10FF08
loc_10FF0A:
        DC.W    $7FF9,$7FB7,$5DA0   ; $10FF0A MOVE.W  $7FB75DA0,<EA:3F>
        SUBQ.W  #6,-(A0)                        ; $10FF10
        BVS.S  loc_10FEB5                       ; $10FF12
        BSR.S  loc_10FE96                       ; $10FF14
        SUBQ.W  #4,-(A0)                        ; $10FF16
        MOVEQ   #-$51,D3                        ; $10FF18
        BVS.S  loc_10FE9D                       ; $10FF1A
        BCS.S  loc_10FE9F                       ; $10FF1C
        BSR.S  loc_10FF80                       ; $10FF1E
        BLT.S  loc_10FF07                       ; $10FF20
        BVS.S  loc_10FF0A                       ; $10FF22
        BVS.S  loc_10FEEA                       ; $10FF24
        BPL.S  loc_10FF74                       ; $10FF26
        BSR.S  loc_10FF11                       ; $10FF28
        DC.W    $7B79,$6208,$0001,$FF00; $10FF2A MOVE.W  $62080001,-$0100(A5)
        MOVE.W  D0,-(A7)                        ; $10FF32
        DC.W    $0002,$A800         ; $10FF34 ORI.B  #$A800,D2
        BTST    D5,D1                           ; $10FF38
        OR.B   D0,D5                            ; $10FF3A
        DC.W    $0023,$8F00         ; $10FF3C ORI.B  #$8F00,-(A3)
        BTST    D1,D1                           ; $10FF40
        DC.W    $0202,$0303         ; $10FF42 ANDI.B  #$0303,D2
        BTST    D0,D4                           ; $10FF46
        DC.W    $0005,$0006         ; $10FF48 ORI.B  #$0006,D5
        DC.W    $0007,$0008         ; $10FF4C ORI.B  #$0008,D7
        DC.W    $0009,$0001         ; $10FF50 ORI.B  #$0001,A1
        BTST    D1,D0                           ; $10FF54
        DC.W    $0002,$0007         ; $10FF56 ORI.B  #$0007,D2
        DC.W    $000A,$040B         ; $10FF5A ORI.B  #$040B,A2
        DC.W    $030C               ; $10FF5E BTST    D1,A4
        DC.W    $010D               ; $10FF60 BTST    D0,A5
        DC.W    $010A               ; $10FF62 BTST    D0,A2
        DC.W    $000E,$000F         ; $10FF64 ORI.B  #$000F,A6
        BTST    D0,(A0)                         ; $10FF68
        DC.W    $0009,$0008         ; $10FF6A ORI.B  #$0008,A1
        DC.W    $0007,$0006         ; $10FF6E ORI.B  #$0006,D7
        DC.W    $0005,$0104         ; $10FF72 ORI.B  #$0104,D5
        BTST    D0,D3                           ; $10FF76
        DC.W    $0002,$0900         ; $10FF78 ORI.B  #$0900,D2
        DC.W    $0211,$0004         ; $10FF7C ANDI.B  #$0004,(A1)
loc_10FF80:
        DC.W    $0203,$0001         ; $10FF80 ANDI.B  #$0001,D3
        BVC.W  loc_10FFBA                       ; $10FF84
        OR.B   D0,D2                            ; $10FF88
        DC.W    $0001,$0002         ; $10FF8A ORI.B  #$0002,D1
        DC.W    $0203,$0004         ; $10FF8E ANDI.B  #$0004,D3
        DC.W    $0006,$0007         ; $10FF92 ORI.B  #$0007,D6
        DC.W    $0009,$000F         ; $10FF96 ORI.B  #$000F,A1
        DC.W    $000A,$000D         ; $10FF9A ORI.B  #$000D,A2
        DC.W    $000B,$0012         ; $10FF9E ORI.B  #$0012,A3
        DC.W    $0013,$0014         ; $10FFA2 ORI.B  #$0014,(A3)
        DC.W    $0015,$0016         ; $10FFA6 ORI.B  #$0016,(A5)
        DC.W    $0017,$0018         ; $10FFAA ORI.B  #$0018,(A7)
        DC.W    $0019,$061A         ; $10FFAE ORI.B  #$061A,(A1)+
        DC.W    $0019,$0006         ; $10FFB2 ORI.B  #$0006,(A1)+
        BTST    D0,D0                           ; $10FFB6
        DC.W    $0003,$0010         ; $10FFB8 ORI.B  #$0010,D3
        DC.W    $0013,$001B         ; $10FFBC ORI.B  #$001B,(A3)
        MOVE.B  (A2)+,-(A4)                     ; $10FFC0
        DC.W    $0019,$0014         ; $10FFC2 ORI.B  #$0014,(A1)+
        DC.W    $0002,$0700         ; $10FFC6 ORI.B  #$0700,D2
        DC.W    $0001,$0004         ; $10FFCA ORI.B  #$0004,D1
        DC.W    $000F,$000E         ; $10FFCE ORI.B  #$000E,A7
        DC.W    $0017,$0118         ; $10FFD2 ORI.B  #$0118,(A7)
        DC.W    $001C,$000C         ; $10FFD6 ORI.B  #$000C,(A4)+
        DC.W    $0004,$0002         ; $10FFDA ORI.B  #$0002,D4
        BTST    D2,D0                           ; $10FFDE
        DC.W    $000F,$000D         ; $10FFE0 ORI.B  #$000D,A7
        DC.W    $000E,$000F         ; $10FFE4 ORI.B  #$000F,A6
        DC.W    $0010,$0008         ; $10FFE8 ORI.B  #$0008,(A0)
        BTST    D0,D1                           ; $10FFEC
        DC.W    $0004,$5700         ; $10FFEE ORI.B  #$5700,D4
        DC.W    $0034,$6700,$0001   ; $10FFF2 ORI.B  #$6700,$01(A4,D0.W)
        BTST    D2,D2                           ; $10FFF8
        BTST    D3,D3                           ; $10FFFA
        BTST    D0,D4                           ; $10FFFC
        DC.W    $0006,$0007         ; $10FFFE ORI.B  #$0007,D6
        DC.W    $0008,$0010         ; $110002 ORI.B  #$0010,A0
        DC.W    $000F,$000A         ; $110006 ORI.B  #$000A,A7
        DC.W    $000E,$0001         ; $11000A ORI.B  #$0001,A6
        BTST    D0,D0                           ; $11000E
        DC.W    $0001,$0005         ; $110010 ORI.B  #$0005,D1
        DC.W    $000A,$0014         ; $110014 ORI.B  #$0014,A2
        DC.W    $0017,$001C         ; $110018 ORI.B  #$001C,(A7)
        DC.W    $0218,$0219         ; $11001C ANDI.B  #$0219,(A0)+
        MOVE.B  (A2)+,D1                        ; $110020
        DC.W    $0007,$0000         ; $110022 ORI.B  #$0000,D7
        DC.W    $0008,$0013         ; $110026 ORI.B  #$0013,A0
        DC.W    $0019,$1C1A         ; $11002A ORI.B  #$1C1A,(A1)+
        DC.W    $0017,$0002         ; $11002E ORI.B  #$0002,(A7)
        BTST    D2,D0                           ; $110032
        DC.W    $0011,$0004         ; $110034 ORI.B  #$0004,(A1)
        DC.W    $000C,$0014         ; $110038 ORI.B  #$0014,A4
        BTST    D0,(A1)+                        ; $11003C
        SUBI.B  #$0018,(A2)+                    ; $11003E
        DC.W    $0014,$0006         ; $110042 ORI.B  #$0006,(A4)
        DC.W    $0011,$0300         ; $110046 ORI.B  #$0300,(A1)
        DC.W    $001D,$041A         ; $11004A ORI.B  #$041A,(A5)+
        DC.W    $0005,$0006         ; $11004E ORI.B  #$0006,D5
        DC.W    $001A,$000A         ; $110052 ORI.B  #$000A,(A2)+
        BTST    D0,D0                           ; $110056
        DC.W    $0007,$001A         ; $110058 ORI.B  #$001A,D7
        ADDQ.B  #1,D0                           ; $11005C
        DC.W    $002F,$6500,$0003   ; $11005E ORI.B  #$6500,$0003(A7)
        DC.W    $0004,$0008         ; $110064 ORI.B  #$0008,D4
        DC.W    $0012,$0015         ; $110068 ORI.B  #$0015,(A2)
        DC.W    $001C,$0418         ; $11006C ORI.B  #$0418,(A4)+
        DC.W    $0019,$041A         ; $110070 ORI.B  #$041A,(A1)+
        BTST    D0,(A1)+                        ; $110074
        BTST    D2,(A2)+                        ; $110076
        DC.W    $0017,$0002         ; $110078 ORI.B  #$0002,(A7)
        DC.W    $0000,$0003         ; $11007C ORI.B  #$0003,D0
        DC.W    $000E,$001B         ; $110080 ORI.B  #$001B,A6
        DC.W    $001C,$1B1A         ; $110084 ORI.B  #$1B1A,(A4)+
        DC.W    $000E,$0007         ; $110088 ORI.B  #$0007,A6
        DC.W    $001B,$1E1A         ; $11008C ORI.B  #$1E1A,(A3)+
        DC.W    $0017,$0002         ; $110090 ORI.B  #$0002,(A7)
        BTST    D2,D0                           ; $110094
        DC.W    $000F,$0015         ; $110096 ORI.B  #$0015,A7
        DC.W    $0A1A,$001C         ; $11009A EORI.B  #$001C,(A2)+
        DC.W    $000A,$0005         ; $11009E ORI.B  #$0005,A2
        DC.W    $0011,$0100         ; $1100A2 ORI.B  #$0100,(A1)
        DC.W    $0001,$0003         ; $1100A6 ORI.B  #$0003,D1
        DC.W    $000B,$001A         ; $1100AA ORI.B  #$001A,A3
        DC.W    $0008,$0009         ; $1100AE ORI.B  #$0009,A0
        DC.W    $0001,$0005         ; $1100B2 ORI.B  #$0005,D1
        BTST    D0,(A2)+                        ; $1100B6
        DC.W    $000A,$0009         ; $1100B8 ORI.B  #$0009,A2
        BTST    D0,(A2)+                        ; $1100BC
        ADDQ.B  #1,D0                           ; $1100BE
        ORI.W  #$6300,D5                        ; $1100C0
        DC.W    $0001,$0009         ; $1100C4 ORI.B  #$0009,D1
        DC.W    $000B,$171A         ; $1100C8 ORI.B  #$171A,A3
        DC.W    $001C,$0002         ; $1100CC ORI.B  #$0002,(A4)+
        DC.W    $0005,$0016         ; $1100D0 ORI.B  #$0016,D5
        DC.W    $0019,$031A         ; $1100D4 ORI.B  #$031A,(A1)+
        BTST    D0,(A6)+                        ; $1100D8
        BTST    D0,(A7)+                        ; $1100DA
        BTST    D2,-(A0)                        ; $1100DC
        DC.W    $0021,$0022         ; $1100DE ORI.B  #$0022,-(A1)
        DC.W    $0023,$0024         ; $1100E2 ORI.B  #$0024,-(A3)
        BTST    D0,-(A5)                        ; $1100E6
        DC.W    $0026,$0027         ; $1100E8 ORI.B  #$0027,-(A6)
        DC.W    $0028,$0029,$002A   ; $1100EC ORI.B  #$0029,$002A(A0)
        DC.W    $002B,$002C,$021A   ; $1100F2 ORI.B  #$002C,$021A(A3)
        DC.W    $0018,$041A         ; $1100F8 ORI.B  #$041A,(A0)+
        DC.W    $002D,$002E,$092F   ; $1100FC ORI.B  #$002E,$092F(A5)
        BTST    D0,$0130(A6)                    ; $110102
        DC.W    $0231,$0132,$0133   ; $110106 ANDI.B  #$0132,$33(A1,D0.W)
        BTST    D0,$24(A4,D0.W)                 ; $11010C
        BTST    D0,(A2)+                        ; $110110
        DC.W    $0017,$0002         ; $110112 ORI.B  #$0002,(A7)
        BTST    D1,D0                           ; $110116
        DC.W    $0001,$0010         ; $110118 ORI.B  #$0010,D1
        DC.W    $001C,$031A         ; $11011C ORI.B  #$031A,(A4)+
        DC.W    $0020,$0024         ; $110120 ORI.B  #$0024,-(A0)
        DC.W    $0035,$0036,$0037   ; $110124 ORI.B  #$0036,$37(A5,D0.W)
        DC.W    $0038,$001E,$021A   ; $11012A ORI.B  #$001E,$021A.W
        DC.W    $0016,$0006         ; $110130 ORI.B  #$0006,(A6)
        DC.W    $0011,$0200         ; $110134 ORI.B  #$0200,(A1)
        DC.W    $000E,$001A         ; $110138 ORI.B  #$001A,A6
        DC.W    $0200,$0005         ; $11013C ANDI.B  #$0005,D0
        DC.W    $001A,$000B         ; $110140 ORI.B  #$000B,(A2)+
        DC.W    $001A,$0019         ; $110144 ORI.B  #$0019,(A2)+
        DC.W    $0039,$001A,$5200,$0046; $110148 ORI.B  #$001A,$52000046
        BSR.W  loc_110155                       ; $110150
        DC.W    $000E,$0013         ; $110154 ORI.B  #$0013,A6
        MOVE.B  (A2)+,-(A1)                     ; $110158
        BTST    D0,(A6)+                        ; $11015A
        BTST    D0,-(A0)                        ; $11015C
        BTST    D0,(A2)+                        ; $11015E
        DC.W    $0018,$0006         ; $110160 ORI.B  #$0006,(A0)+
        DC.W    $003A,$021A,$003B   ; $110164 ORI.B  #$021A,$003B(PC)
        DC.W    $003C,$003D,$0036   ; $11016A ORI.B  #$003D,#$0036
        DC.W    $003E,$003F         ; $110170 ORI.B  #$003F,<EA:3E>
        ORI.W  #$0041,D0                        ; $110174
        ORI.W  #$0243,D2                        ; $110178
        ORI.W  #$0145,D4                        ; $11017C
        ORI.W  #$0247,D6                        ; $110180
        ANDI.W  #$0149,A0                       ; $110184
        ORI.W  #$0031,A2                        ; $110188
        ADDI.B  #$002B,(A2)+                    ; $11018C
        ORI.W  #$094C,A3                        ; $110190
        DC.W    $074D               ; $110194 BCHG    D3,A5
        DC.W    $0549               ; $110196 BCHG    D2,A1
        ORI.W  #$0034,A2                        ; $110198
        BTST    D0,(A2)+                        ; $11019C
        DC.W    $0017,$0002         ; $11019E ORI.B  #$0002,(A7)
        DC.W    $0200,$0011         ; $1101A2 ANDI.B  #$0011,D0
        DC.W    $0010,$0017         ; $1101A6 ORI.B  #$0017,(A0)
        DC.W    $021A,$0023         ; $1101AA ANDI.B  #$0023,(A2)+
        ORI.W  #$004F,A6                        ; $1101AE
        ORI.W  #$0150,D3                        ; $1101B2
        ORI.W  #$0046,(A1)                      ; $1101B6
        ORI.W  #$0053,(A2)                      ; $1101BA
        DC.W    $001E,$011A         ; $1101BE ORI.B  #$011A,(A6)+
        DC.W    $0014,$0004         ; $1101C2 ORI.B  #$0004,(A4)
        DC.W    $0200,$000F         ; $1101C6 ANDI.B  #$000F,D0
        DC.W    $001A,$0200         ; $1101CA ORI.B  #$0200,(A2)+
        DC.W    $0005,$001A         ; $1101CE ORI.B  #$001A,D5
        DC.W    $0005,$000A         ; $1101D2 ORI.B  #$000A,D5
        DC.W    $0014,$0001         ; $1101D6 ORI.B  #$0001,(A4)
        DC.W    $001A,$5200         ; $1101DA ORI.B  #$5200,(A2)+
        ORI.W  #$5F00,A4                        ; $1101DE
        DC.W    $0001,$0010         ; $1101E2 ORI.B  #$0010,D1
        DC.W    $0014,$051A         ; $1101E6 ORI.B  #$051A,(A4)
        DC.W    $0020,$0028         ; $1101EA ORI.B  #$0028,-(A0)
        BCHG    D0,(A4)                         ; $1101EE
        DC.W    $002A,$012B,$0133   ; $1101F0 ORI.B  #$012B,$0133(A2)
        DC.W    $0032,$0055,$0056   ; $1101F6 ORI.B  #$0055,$56(A2,D0.W)
        BCHG    D0,(A7)                         ; $1101FC
        ORI.W  #$0059,(A0)+                     ; $1101FE
