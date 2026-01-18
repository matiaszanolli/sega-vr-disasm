; Generated assembly for $102200-$104200
; Branch targets: 94
; Labels: 89
; Format: DC.W with decoded mnemonics as comments

        org     $102200

        CMP.B  (A5)+,D0                         ; $102200
        ASR.W  $0770(A5)                        ; $102202
        MOVE.W  D1,-$29F3(A3)                   ; $102206
        LSR.W  D0,D7                            ; $10220A
        BCLR    D1,-$20(A0,D1.L)                ; $10220C
        ADD.B  D6,D6                            ; $102210
        MOVE.W  (A7)+,D1                        ; $102212
        DIVS    (A6),D0                         ; $102214
        BSET    D6,-(A0)                        ; $102216
        BLE.S  loc_10221D                       ; $102218
        CMP.B  (A3)+,D0                         ; $10221A
        MOVE.L  $0770(A5),(A0)+                 ; $10221C
        MOVE.W  D1,-$29F3(A3)                   ; $102220
        LSR.W  D0,D7                            ; $102224
        BCLR    D1,$60(A0,D1.L)                 ; $102226
        ADD.B  D6,D6                            ; $10222A
        MOVE.W  (A7)+,D1                        ; $10222C
        DIVS    (A6),D0                         ; $10222E
        BSET    D6,-(A0)                        ; $102230
        BLE.S  loc_102237                       ; $102232
        CMP.B  (A5)+,D0                         ; $102234
        ASR.W  $0770(A5)                        ; $102236
        MOVE.W  D1,-$29F3(A3)                   ; $10223A
        LSR.W  D0,D7                            ; $10223E
        BCLR    D1,-$20(A0,D1.L)                ; $102240
        ASL.B  #6,D7                            ; $102244
        MOVEQ   #$18,D1                         ; $102246
        DC.W    $41BD               ; $102248 DC.W    $41BD
        MOVE.W  (A4)+,D4                        ; $10224A
        BRA.S  loc_10222B                       ; $10224C
        BCLR    D3,D0                           ; $10224E
        MOVE.W  D1,(A4)+                        ; $102250
        CMP.B  A7,D5                            ; $102252
        MOVEA.B $0374(A7),A0                    ; $102254
        MOVEA.B -(A0),A6                        ; $102258
        ADD.B  D6,D7                            ; $10225A
        OR.B   $C1BA.W,D0                       ; $10225C
        BTST    D7,(A0)                         ; $102260
        BLE.S  loc_102285                       ; $102262
        MOVE.W  (A4)+,D4                        ; $102264
        BRA.S  loc_102245                       ; $102266
        BCLR    D3,D0                           ; $102268
        MOVE.W  D1,(A4)+                        ; $10226A
        CMP.B  A7,D5                            ; $10226C
        MOVEA.B $0374(A7),A0                    ; $10226E
        MOVEA.B -(A0),A6                        ; $102272
        ADD.B  D6,D7                            ; $102274
        OR.B   $C1BA.W,D0                       ; $102276
        BTST    D7,(A0)                         ; $10227A
        MOVEQ   #$25,D0                         ; $10227C
        MOVE.W  (A6)+,D4                        ; $10227E
        DC.W    $00E3               ; $102280 DC.W    $00E3
        DC.W    $06E8               ; $102282 DC.W    $06E8
        MOVEA.W D1,A6                           ; $102284
        CMP.B  A5,D6                            ; $102286
        ADD.W  $74(A1,A0.W),D0                  ; $102288
        MOVE.B  D0,D7                           ; $10228C
        ASL.B  #1,D6                            ; $10228E
        ROR.B  D4,D4                            ; $102290
        DC.W    $41BC               ; $102292 DC.W    $41BC
        BSET    D6,(A0)                         ; $102294
        MOVE.W  -(A1),$1E(A0,A7.L)              ; $102296
        DC.W    $00E3               ; $10229A DC.W    $00E3
        DC.W    $06E8               ; $10229C DC.W    $06E8
        MOVEA.W D1,A6                           ; $10229E
        CMP.B  A5,D6                            ; $1022A0
        ADD.W  $74(A1,A0.W),D0                  ; $1022A2
        MOVE.B  D0,D7                           ; $1022A6
        ASL.B  #1,D6                            ; $1022A8
        ROR.B  D4,D4                            ; $1022AA
        DC.W    $41BC               ; $1022AC DC.W    $41BC
        BSET    D6,(A0)                         ; $1022AE
        MOVE.W  -(A1),$1E(A0,A5.W)              ; $1022B0
        DC.W    $00E3               ; $1022B4 DC.W    $00E3
        DC.W    $06E8               ; $1022B6 DC.W    $06E8
        MOVEA.W D1,A6                           ; $1022B8
        AND.L  (A7),D0                          ; $1022BA
        ROR.W  D0,D0                            ; $1022BC
        DC.W    $038C               ; $1022BE BCLR    D1,A4
        MOVE.B  -(A0),$06(A5,A7.W)              ; $1022C0
        MOVE.W  -$3A(A7,D4.W),D0                ; $1022C4
        BSET    D6,(A0)                         ; $1022C8
        MOVEQ   #$03,D4                         ; $1022CA
        OR.B   (A3)+,D6                         ; $1022CC
        MOVE.L  -$10(A1,D0.W),(A0)+             ; $1022CE
        MOVE.W  D1,-$3979(A3)                   ; $1022D2
        ROR.W  D0,D0                            ; $1022D6
        DC.W    $038C               ; $1022D8 BCLR    D1,A4
        MOVE.B  -(A0),$06(A5,A7.W)              ; $1022DA
        MOVE.W  -$3A(A7,D4.W),D0                ; $1022DE
        BSET    D6,(A0)                         ; $1022E2
        MOVEQ   #$03,D4                         ; $1022E4
        OR.B   (A3)+,D6                         ; $1022E6
        MOVE.L  -$10(A1,D0.W),(A0)+             ; $1022E8
        MOVE.W  D1,-$3979(A3)                   ; $1022EC
        NEGX.W $038C.W                          ; $1022F0
        MOVE.B  -(A0),$07(A5,A7.W)              ; $1022F4
        ANDI.W  #$01E0,(A7)+                    ; $1022F8
        DC.W    $0E30               ; $1022FC DC.W    $0E30
        BGT.S  loc_102283                       ; $1022FE
        AND.B  (A3)+,D2                         ; $102300
        MULU    (A5)+,D0                        ; $102302
        BTST    D3,(A0)+                        ; $102304
        MOVE.W  D1,-$1FF2(A3)                   ; $102306
        MOVEA.W -$7C3C(A6),A0                   ; $10230A
        MOVE.B  $5106(A0),D6                    ; $10230E
        MOVE.W  D0,-(A3)                        ; $102312
        MOVE.W  -(A5),-(A0)                     ; $102314
        AND.B  (A4)+,D0                         ; $102316
        MOVEA.L (A1),A4                         ; $102318
        DC.W    $06F7               ; $10231A DC.W    $06F7
        MOVEA.B $0381(A7),A0                    ; $10231C
        MOVE.B  D0,D7                           ; $102320
        ASL.W  #8,D2                            ; $102322
        OR.B   $03(A7,A3.L),D4                  ; $102324
        OR.B   D4,$00E1(A6)                     ; $102328
        CLR.L  A0                               ; $10232C
        MOVE.W  $8378.W,$08(A3,D1.L)            ; $10232E
        ADD.B  D7,D1                            ; $102334
        MOVE.W  (A0),-(A7)                      ; $102336
        BLE.S  loc_1022BD                       ; $102338
        OR.B   D4,$00E1(A6)                     ; $10233A
        CLR.L  A0                               ; $10233E
        MOVE.W  $0389.W,$00(A3,D2.L)            ; $102340
        ASL.W  #8,D2                            ; $102346
        OR.B   -$7D(A7,A3.L),D4                 ; $102348
        MOVEQ   #$1C,D4                         ; $10234C
        BSET    #10,$41(A0,D1.W)                ; $10234E
        CMPA.L  D0,A6                           ; $102354
        MOVEA.B A1,A6                           ; $102356
        MOVEQ   #$07,D0                         ; $102358
        DC.W    $0A14,$41BD         ; $10235A EORI.B  #$41BD,(A4)
        AND.B  (A3)+,D2                         ; $10235E
        MULU    -(A0),D0                        ; $102360
        NOT.L  (A0)                             ; $102362
        MOVE.W  $837C.W,#$1C49                  ; $102364
        MOVEQ   #$07,D0                         ; $10236A
        DC.W    $0A14,$41BD         ; $10236C EORI.B  #$41BD,(A4)
        AND.B  (A4)+,D0                         ; $102370
        DC.W    $4970               ; $102372 DC.W    $4970
        DC.W    $070A               ; $102374 BTST    D3,A2
        MOVEA.B D1,A2                           ; $102376
        CMPA.L  D4,A6                           ; $102378
        DC.W    $1BC0               ; $10237A MOVE.B  D0,<EA:3D>
        ASR.W  #8,D7                            ; $10237C
        OR.B   $50A2.W,D0                       ; $10237E
        BSET    D6,$00E2(A6)                    ; $102382
        DC.W    $4B80               ; $102386 DC.W    $4B80
        MOVEA.W (A0),A4                         ; $102388
        MOVE.L  A5,D1                           ; $10238A
        ASR.B  D7,D0                            ; $10238C
        ADD.B  D7,D7                            ; $10238E
        DC.W    $0234,$81CF,$C41B   ; $102390 ANDI.B  #$81CF,$1B(A4,A4.W)
        ASR.W  -(A2)                            ; $102396
        DC.W    $4B80               ; $102398 DC.W    $4B80
        MOVEA.W (A0),A4                         ; $10239A
        MOVE.L  A5,D1                           ; $10239C
        ASR.B  #7,D0                            ; $10239E
        LSR.W  #1,D3                            ; $1023A0
        MOVE.W  D0,D4                           ; $1023A2
        DC.W    $090F               ; $1023A4 BTST    D4,A7
        DC.W    $0000,$0000         ; $1023A6 ORI.B  #$0000,D0
        BSET    D0,$62(A7,A5.L)                 ; $1023AA
        SUB.W  D3,D5                            ; $1023AE
        SPL     -(A2)                           ; $1023B0
        SUB.B  D0,(A6)                          ; $1023B2
        DIVS    (A2),D3                         ; $1023B4
        MOVEM.W (A3),D0/D1/D4/D6/D7/A1/A3/A5/A6/A7; $1023B6
        MOVEM.W $29C5(A2),D1/D2/D4/D7/A3/A4/A6  ; $1023BA
        ASL.W  $117D(A3)                        ; $1023C0
        MOVEA.W D3,A2                           ; $1023C4
        MOVE.L  D0,D1                           ; $1023C6
        MOVE.B  -(A0),D0                        ; $1023C8
        BTST    #2,D4                           ; $1023CA
        DC.W    $067D,$7A69         ; $1023CE ADDI.W  #$7A69,<EA:3D>
        MOVE.B  A2,-$75BA(A2)                   ; $1023D2
        SGE     -$2F2C(A2)                      ; $1023D6
        OR.B   D6,$45A1(A4)                     ; $1023DA
        LSL.B  #5,D7                            ; $1023DE
        EXT.W   D3                              ; $1023E0
        MOVEA.W (A2)+,A2                        ; $1023E2
        MOVE.W  D7,(A1)                         ; $1023E4
        DC.W    $078D               ; $1023E6 BCLR    D3,A5
        SUBQ.W  #1,A0                           ; $1023E8
        ASL.W  D7,D5                            ; $1023EA
        OR.L   $4121(A4),D3                     ; $1023EC
        LSL.B  #7,D7                            ; $1023F0
        MOVEM.W A2,D1/D2/D3/D4/D7/A1/A2/A6/A7   ; $1023F2
        MOVE.B  $2140(PC),(A5)+                 ; $1023F6
        DC.W    $0008,$1000         ; $1023FA ORI.B  #$1000,A0
        SUBI.B  #$5440,A2                       ; $1023FE
        DC.W    $0204,$0106         ; $102402 ANDI.B  #$0106,D4
        OR.B   D5,D0                            ; $102406
        AND.W  -(A1),D1                         ; $102408
        NEGX.B $5C(A0,A1.L)                     ; $10240A
        DC.W    $4008               ; $10240E NEGX.B A0
        ORI.W  #$3908,-(A0)                     ; $102410
        MOVE.B  D0,D4                           ; $102414
        DC.W    $0006,$013A         ; $102416 ORI.B  #$013A,D6
        MOVE.L  (A3)+,-(A4)                     ; $10241A
        ROXR.L  D0,D0                           ; $10241C
        ADDA.W  -$4B9B(A0),A2                   ; $10241E
        DC.W    $0E0F               ; $102422 DC.W    $0E0F
        MOVE.B  -(A6),(A5)                      ; $102424
        SUBA.L  (A6)+,A0                        ; $102426
        DC.W    $0B0D               ; $102428 BTST    D5,A5
        MOVE.W  A2,-$26(A3,A4.W)                ; $10242A
        MOVE.L  -(A7),(A0)                      ; $10242E
        MOVE.B  A4,(A2)                         ; $102430
        CMP.B  $4D(A5,A6.L),D6                  ; $102432
        BSET    D6,-$0C(A0,A3.W)                ; $102436
        SUB.B  D0,#$3523                        ; $10243A
        MOVE.L  (A2)+,-(A4)                     ; $10243E
        ADDQ.L  #4,A0                           ; $102440
        DC.W    $001A,$1AB1         ; $102442 ORI.B  #$1AB1,(A2)+
        SUB.B  $41(A1,A2.L),D3                  ; $102446
        MOVEQ   #-$58,D1                        ; $10244A
        OR.B   #$1E22,D0                        ; $10244C
        MOVE.L  D1,D4                           ; $102450
        MOVE.W  $4424.W,D4                      ; $102452
        CMPI.B  #$1611,D1                       ; $102456
        ORI.W  #$82F0,D6                        ; $10245A
        DC.W    $090A               ; $10245E BTST    D4,A2
        MOVE.W  D0,(A2)                         ; $102460
        DC.W    $0E85               ; $102462 DC.W    $0E85
        MOVE.L  D6,(A3)                         ; $102464
        MOVE.W  (A0)+,$7A48(A2)                 ; $102466
        SUB.B  (A2)+,D7                         ; $10246A
        SUB.L  D0,(A4)                          ; $10246C
        OR.B   D6,$45F6(A4)                     ; $10246E
        MOVEQ   #$08,D4                         ; $102472
        BLT.S  loc_1024E2                       ; $102474
        BMI.S  loc_102488                       ; $102476
        JSR     A2                              ; $102478
        NOT.W  $80EC.W                          ; $10247A
        BTST    D0,$5148(A4)                    ; $10247E
        ADD.B  D7,D5                            ; $102482
        OR.L   -(A5),D3                         ; $102484
        OR.W   D2,-(A3)                         ; $102486
loc_102488:
        PEA     (A1)                            ; $102488
        DC.W    $003D,$20F4         ; $10248A ORI.B  #$20F4,<EA:3D>
        ADD.B  A5,D1                            ; $10248E
        MOVE.B  $42(A0,D0.W),(A0)+              ; $102490
        MOVE.B  D0,D2                           ; $102494
        MOVE.B  D5,D4                           ; $102496
        AND.W  A0,D4                            ; $102498
        ROXR.B  D1,D0                           ; $10249A
        MOVE.B  $00(A0,D1.W),D1                 ; $10249C
        SUB.B  (A4),D2                          ; $1024A0
        DC.W    $0026,$8900         ; $1024A2 ORI.B  #$8900,-(A6)
        DC.W    $06C0               ; $1024A6 DC.W    $06C0
        ADD.B  D0,D1                            ; $1024A8
        SUB.W  (A0),D0                          ; $1024AA
        ORI.W  #$0510,-$6E2D(A4)                ; $1024AC
        DC.W    $00E7               ; $1024B2 DC.W    $00E7
        ORI.L  #$A545232B,(A2)                  ; $1024B4
        MOVE.W  (A0),D0                         ; $1024BA
        ADD.W  (A4),D5                          ; $1024BC
        OR.B   A6,D0                            ; $1024BE
        ASR.B  D3,D1                            ; $1024C0
        MOVE.B  (A1),$098F(A6)                  ; $1024C2
        DC.W    $00CD               ; $1024C6 DC.W    $00CD
        MOVE.L  D4,$3368(A1)                    ; $1024C8
        BSR.S  loc_102526                       ; $1024CC
        ADD.L  $3B(A4,D4.W),D1                  ; $1024CE
        AND.B  D3,D4                            ; $1024D2
        ASL.B  D0,D5                            ; $1024D4
        DC.W    $0005,$2003         ; $1024D6 ORI.B  #$2003,D5
        MOVE.L  (A4),$33F4(A5)                  ; $1024DA
        OR.B   $C855625E,D0                     ; $1024DE
        MOVE.B  $20F6(A5),(A1)+                 ; $1024E4
        BTST    D7,D0                           ; $1024E8
        CMPI.B  #$7013,D2                       ; $1024EA
        MOVE.L  D0,D2                           ; $1024EE
        MOVE.W  A1,(A1)                         ; $1024F0
        DC.W    $00CD               ; $1024F2 DC.W    $00CD
        MOVE.L  D0,$02A0(A0)                    ; $1024F4
        MOVE.W  D0,D0                           ; $1024F8
        MOVE.L  A4,D4                           ; $1024FA
        BTST    D1,-$7E3C(A3)                   ; $1024FC
        EORI.W  #$360E,D0                       ; $102500
        OR.B   A7,D4                            ; $102504
        MOVE.L  D4,-$50(A4,A1.L)                ; $102506
        BSET    D3,D2                           ; $10250A
        ADDQ.B  #2,(A2)                         ; $10250C
        CMP.B  D0,D0                            ; $10250E
        OR.B   A0,D0                            ; $102510
        MOVE.L  D2,-$5A(A2,D0.L)                ; $102512
        MOVE.B  (A4)+,(A1)+                     ; $102516
        MOVE.L  D2,D1                           ; $102518
        AND.B  -(A3),D2                         ; $10251A
        MOVE.L  -(A1),D5                        ; $10251C
        MOVE.W  -(A6),-$32(A0,D0.W)             ; $10251E
        MOVE.L  -(A5),-(A0)                     ; $102522
        DC.W    $0005,$2099         ; $102524 ORI.B  #$2099,D5
        MOVE.W  (A0),D0                         ; $102528
        DC.W    $0ABC,$026D,$5434,$BC02,$5B48; $10252A EORI.L  #$026D5434,#$BC025B48
        MOVE.W  #$8030,$1AE0(A2)                ; $102534
        DC.W    $0223,$E000         ; $10253A ANDI.B  #$E000,-(A3)
        AND.B  D4,D1                            ; $10253E
        BTST    D6,-(A0)                        ; $102540
        DC.W    $0200,$6603         ; $102542 ANDI.B  #$6603,D0
        BRA.S  loc_10251F                       ; $102546
        DIVU    D0,D3                           ; $102548
        MOVE.L  $3B(A4,A0.W),$24(A3,A4.W)       ; $10254A
        DC.W    $A97E,$0CF8         ; $102550 MOVE.L  <EA:3E>,$0CF8(A4)
        BGE.S  loc_10259C                       ; $102554
        SUB.B  -$4E(A4,A4.L),D5                 ; $102556
        DC.W    $0AD0               ; $10255A DC.W    $0AD0
        ADDQ.L  #2,D0                           ; $10255C
        OR.B   (A5),D6                          ; $10255E
        MOVEA.B -$5C(PC,A4.W),A4                ; $102560
        MOVE.B  D0,-(A7)                        ; $102564
        MOVE.L  (A6)+,-$75(A4,A7.W)             ; $102566
        ADDQ.L  #6,D0                           ; $10256A
        CMP.B  (A3),D3                          ; $10256C
        MOVE.L  $0300(A5),-(A1)                 ; $10256E
        BCLR    D3,D1                           ; $102572
        AND.B  D1,D3                            ; $102574
        DC.W    $003C,$8022,$6131   ; $102576 ORI.B  #$8022,#$6131
        BCLR    #9,D1                           ; $10257C
        BSR.S  loc_1025F3                       ; $102580
        ANDI.W  #$9FC0,(A0)+                    ; $102582
        ASR.B  #1,D4                            ; $102586
        DC.W    $B13F               ; $102588 EOR.B  D0,<EA:3F>
        OR.B   D2,D0                            ; $10258A
        DC.W    $02C0               ; $10258C DC.W    $02C0
        MOVE.W  D3,-(A0)                        ; $10258E
        OR.B   A4,D4                            ; $102590
        MULU    -(A2),D0                        ; $102592
        MOVE.L  -$7B(A2,D2.L),$4826(A3)         ; $102594
        MOVE.W  D0,(A6)                         ; $10259A
loc_10259C:
        CMP.B  (A3),D3                          ; $10259C
        MOVE.L  (A7)+,D0                        ; $10259E
        ADD.B  D1,A1                            ; $1025A0
        ADDA.L  -(A0),A7                        ; $1025A2
        BCLR    #2,(A0)+                        ; $1025A4
        MOVEA.L D6,A0                           ; $1025A8
        BCLR    D0,D0                           ; $1025AA
        OR.B   D4,D6                            ; $1025AC
        OR.B   D2,D6                            ; $1025AE
        CMP.B  (A6),D0                          ; $1025B0
        OR.L   $45C1.W,D0                       ; $1025B2
        MOVE.W  A2,-(A7)                        ; $1025B6
        DC.W    $0015,$00B7         ; $1025B8 ORI.B  #$00B7,(A5)
        NEG.B  -(A5)                            ; $1025BC
        MOVE.B  D0,D6                           ; $1025BE
        MOVE.W  -(A0),$2828(A7)                 ; $1025C0
        SUBQ.B  #8,A2                           ; $1025C4
        ADDQ.B  #3,(A1)                         ; $1025C6
        MOVEM.L $6A(A1,D1.L),D3/D4/D6/D7/A0/A1/A4; $1025C8
        DIVU    A3,D3                           ; $1025CE
        OR.B   (A6),D4                          ; $1025D0
        OR.W   $4C37(A5),D0                     ; $1025D2
        MOVE.B  D2,$1B(A7,D7.L)                 ; $1025D6
        AND.B  $00D8(A0),D0                     ; $1025DA
        DC.W    $0E00               ; $1025DE DC.W    $0E00
        MOVE.W  -(A2),-(A0)                     ; $1025E0
        ADD.B  (A6),D0                          ; $1025E2
        AND.W  -$2E(A4,D1.L),D1                 ; $1025E4
        MOVE.L  D2,D0                           ; $1025E8
        MOVE.L  -(A5),D4                        ; $1025EA
        BSR.S  loc_10258D                       ; $1025EC
        DC.W    $0D8E               ; $1025EE BCLR    D6,A6
        MOVE.L  -$5A(A2,A7.W),$29(A4,A6.L)      ; $1025F0
        SMI     -$60(A6,D0.W)                   ; $1025F6
        MOVE.L  D0,(A6)+                        ; $1025FA
        LSR.B  D7,D0                            ; $1025FC
        SUB.B  D1,-$7538(A4)                    ; $1025FE
        ADDQ.B  #3,-$1E(A4,A0.W)                ; $102602
        MOVE.B  D0,D6                           ; $102606
        MOVE.W  D7,$0C(A6,D0.L)                 ; $102608
        BSET    D0,D1                           ; $10260C
        DC.W    $00B4,$004B,$8944,$1340; $10260E ORI.L  #$004B8944,$40(A4,D1.W)
        NEGX.B D4                               ; $102616
        ADD.L  (A0),D4                          ; $102618
        DC.W    $007C,$0401,$4605   ; $10261A ORI.W  #$0401,#$4605
        ADDQ.B  #6,-$607E(A1)                   ; $102620
        ADDQ.B  #2,(A3)                         ; $102624
        CMP.L  $112C(A2),D0                     ; $102626
        MOVE.L  -(A2),(A5)                      ; $10262A
        MOVE.W  (A1),D1                         ; $10262C
        OR.W   (A5),D4                          ; $10262E
        OR.L   D0,D5                            ; $102630
        BCHG    D2,D1                           ; $102632
        MOVE.L  A1,-$58(A3,D3.L)                ; $102634
        ORI.W  #$0387,(A4)                      ; $102638
        MOVE.L  $80F0.W,D0                      ; $10263C
        LEA     -$51(A6,D4.W),A3                ; $102640
        ADD.B  -$3E9F(A0),D6                    ; $102644
        BTST    D5,(A0)                         ; $102648
        MOVE.L  D4,(A5)+                        ; $10264A
        CMP.B  -(A5),D6                         ; $10264C
        ADDA.W  (A7)+,A0                        ; $10264E
        DC.W    $06FE               ; $102650 DC.W    $06FE
        MOVE.B  -$56F9(A2),D0                   ; $102652
        BCLR    D1,-(A0)                        ; $102656
        MOVE.B  A0,(A3)                         ; $102658
        CMP.W  (A3),D3                          ; $10265A
        MOVE.L  $0E(PC,A0.W),D0                 ; $10265C
        SUB.B  A4,D0                            ; $102660
        BVS.S  loc_1025EB                       ; $102662
        DC.W    $13F0,$6F48,$B80A,$A0AC; $102664 MOVE.B  $48(A0,D6.L),$B80AA0AC
        BCHG    D4,$41(A4,D1.W)                 ; $10266C
        AND.L  (A3)+,D4                         ; $102670
        MOVE.L  (A1)+,(A6)+                     ; $102672
        MOVE.L  A1,(A3)+                        ; $102674
        MOVE.W  $BC472639,D3                    ; $102676
        DBRA    D1,$101BAA                      ; $10267C
        OR.W   D4,(A3)+                         ; $102680
        DC.W    $4B1C               ; $102682 DC.W    $4B1C
        SVC     D2                              ; $102684
        MOVE.L  (A5),-(A2)                      ; $102686
        MOVE.L  (A6)+,D0                        ; $102688
        ORI.W  #$1EF1,$4702.W                   ; $10268A
        MOVE.L  A0,D0                           ; $102690
        ORI.L  #$0A881740,-(A7)                 ; $102692
        ASR.B  #6,D5                            ; $102698
        MOVE.W  A5,-$658C(A1)                   ; $10269A
        ADD.W  D1,-(A6)                         ; $10269E
        SUB.B  $26(A4,A6.W),D5                  ; $1026A0
        OR.L   D0,D0                            ; $1026A4
        BCHG    D0,-(A0)                        ; $1026A6
        MOVEQ   #$02,D4                         ; $1026A8
        BPL.S  loc_1026E4                       ; $1026AA
        MOVE.B  D0,D4                           ; $1026AC
        OR.W   -(A7),D0                         ; $1026AE
        BRA.S  loc_10272A                       ; $1026B0
        SUB.W  D0,-(A4)                         ; $1026B2
        MOVE.B  -(A0),-(A0)                     ; $1026B4
        ADD.L  D5,D1                            ; $1026B6
        MOVE.L  A3,-(A7)                        ; $1026B8
        BGT.S  loc_10268F                       ; $1026BA
        OR.B   D5,(A5)+                         ; $1026BC
        MOVE.B  $01(A3,A7.L),(A0)               ; $1026BE
        ROR.B  #8,D6                            ; $1026C2
        NEGX   -$70(A4,D1.W)                    ; $1026C4
        EOR.B  D2,A1                            ; $1026C8
        MOVE.L  A6,(A6)                         ; $1026CA
        SUBI.W  #$138D,-$4B(A1,D2.W)            ; $1026CC
        MOVE.W  (A1)+,-(A1)                     ; $1026D2
        MOVEA.W (A3)+,A4                        ; $1026D4
        OR.B   D0,D2                            ; $1026D6
        BCHG    #15,-$0BD8(A2)                  ; $1026D8
        CMP.B  -(A5),D0                         ; $1026DE
        DIVS    #$1061,D4                       ; $1026E0
loc_1026E4:
        DC.W    $450A               ; $1026E4 DC.W    $450A
        MOVEA.W (A5)+,A0                        ; $1026E6
        DIVU    $2B82(A6),D1                    ; $1026E8
        MOVE.L  D2,D0                           ; $1026EC
        MOVE.L  -(A0),(A5)                      ; $1026EE
        MOVEQ   #-$07,D1                        ; $1026F0
        BTST    D7,$1540(A4)                    ; $1026F2
        MOVE.L  -(A4),(A5)                      ; $1026F6
        MOVE.B  A6,-(A6)                        ; $1026F8
        NOT.W  D0                               ; $1026FA
        MOVE.B  $D4A9074F,(A5)                  ; $1026FC
        MOVE.W  A2,(A0)+                        ; $102702
        OR.L   D1,$1D70(A4)                     ; $102704
        SUBQ.B  #2,D2                           ; $102708
        MOVEA.L A7,A4                           ; $10270A
        BLS.S  loc_10275F                       ; $10270C
        MOVE.B  D0,(A5)                         ; $10270E
        MOVEQ   #$03,D3                         ; $102710
        CMP.B  (A4)+,D1                         ; $102712
        AND.L  D0,-(A6)                         ; $102714
        DC.W    $4D92               ; $102716 DC.W    $4D92
        DC.W    $1BF2,$D9A3         ; $102718 MOVE.B  -$5D(A2,A5.L),<EA:3D>
        MOVE.B  #$7366,D3                       ; $10271C
        LSL.W  #8,D5                            ; $102720
        ADD.W  (A2),D6                          ; $102722
        CMPA.L  D2,A3                           ; $102724
        MOVE.L  A6,$6077(A5)                    ; $102726
loc_10272A:
        MOVEA.L $05(A0,D7.L),A2                 ; $10272A
        DC.W    $4908               ; $10272E DC.W    $4908
        MOVE.B  #$C080,(A2)+                    ; $102730
        EORI.L  #$551902B0,-(A0)                ; $102734
        MOVE.L  -$7D06(A2),D7                   ; $10273A
        MOVE.W  (A0)+,D0                        ; $10273E
        MOVE.W  D3,D6                           ; $102740
        MOVE.B  (A4),D0                         ; $102742
        LSR.L  D0,D0                            ; $102744
        BTST    D2,-(A0)                        ; $102746
        MOVE.L  D1,(A6)+                        ; $102748
        OR.B   A4,D5                            ; $10274A
        BVC.S  loc_1027B1                       ; $10274C
        MULU    (A2)+,D1                        ; $10274E
        SUB.B  -$3D(A2,D3.L),D2                 ; $102750
        MOVEQ   #$2F,D5                         ; $102754
        MOVE.B  -(A3),-$74DB(A0)                ; $102756
        MOVE.L  #$D10BE7E0,(A4)                 ; $10275A
        SUB.L  D6,D5                            ; $102760
        MOVEA.W -$1FEA(A2),A4                   ; $102762
        MOVE.B  A0,$05(A1,A1.L)                 ; $102766
        OR.B   $00BF(A4),D1                     ; $10276A
        OR.B   (A0),D1                          ; $10276E
        MOVE.B  -(A0),(A0)                      ; $102770
        OR.B   D0,D4                            ; $102772
        AND.B  -(A6),D0                         ; $102774
        DC.W    $4301               ; $102776 DC.W    $4301
        AND.B  $50(A0,D2.W),D4                  ; $102778
        MOVE.B  D6,$21A7(A5)                    ; $10277C
        BSR.S  loc_102797                       ; $102780
        MOVE.W  (A0),-(A2)                      ; $102782
        AND.W  D0,$00B05C02                     ; $102784
        ASR.B  D1,D5                            ; $10278A
        ADD.W  (A5),D0                          ; $10278C
        ADDI.B  #$3B52,(A0)                     ; $10278E
        AND.L  D5,(A3)+                         ; $102792
        MOVE.B  $4A(A7,D7.W),-(A6)              ; $102794
loc_102798:
        ADD.L  A0,D7                            ; $102798
        MOVEQ   #-$20,D3                        ; $10279A
        OR.L   -$1762(A3),D1                    ; $10279C
        MULU    -$5D(A2,D0.L),D0                ; $1027A0
        MOVE.L  A6,D0                           ; $1027A4
        MOVE.W  $7B(PC,A2.W),D2                 ; $1027A6
        BSET    D6,-$7D(A0,D2.L)                ; $1027AA
        MOVEQ   #$0A,D7                         ; $1027AE
        MOVEA.L (A5),A0                         ; $1027B0
        BCHG    D3,$6CF8.W                      ; $1027B2
        ROR.W  A5                               ; $1027B6
        AND.L  (A3)+,D1                         ; $1027B8
        CMP.L  -(A5),D4                         ; $1027BA
        BLE.S  loc_102798                       ; $1027BC
        SNE     (A1)                            ; $1027BE
        OR.L   (A3)+,D5                         ; $1027C0
        MULU    (A1)+,D6                        ; $1027C2
        MOVE.L  D7,(A3)+                        ; $1027C4
        MOVE.W  A1,$62(A3,D6.L)                 ; $1027C6
        SUB.W  (A7),D3                          ; $1027CA
        AND.W  D4,(A3)+                         ; $1027CC
        DC.W    $4B1C               ; $1027CE DC.W    $4B1C
        SVC     D2                              ; $1027D0
        AND.B  D2,(A5)                          ; $1027D2
        SUB.B  -$68(A2,A4.W),D6                 ; $1027D4
        DC.W    $0CD0               ; $1027D8 DC.W    $0CD0
        SUBQ.L  #1,D3                           ; $1027DA
        MOVE.W  (A5),(A4)+                      ; $1027DC
        BHI.S  loc_10283D                       ; $1027DE
        BCHG    D2,(A5)                         ; $1027E0
        NEGX.W -(A7)                            ; $1027E2
        MOVE.W  (A6),-(A2)                      ; $1027E4
        SUB.B  -$58(A5,D0.W),D0                 ; $1027E6
        BTST    D6,-(A0)                        ; $1027EA
        BVS.S  loc_102779                       ; $1027EC
        TST.L  (A0)                             ; $1027EE
        MOVE.W  -$7CA6(A0),$0835(A2)            ; $1027F0
        CMP.L  D2,D5                            ; $1027F6
        AND.B  (A3)+,D0                         ; $1027F8
        ORI.L  #$1668B325,-(A7)                 ; $1027FA
        SUB.W  D3,(A2)                          ; $102800
        MOVE.B  #$A9BB,-(A5)                    ; $102802
        BSET    D6,$6ED6(A3)                    ; $102806
        OR.B   $10C6(A5),D6                     ; $10280A
        CLR.B  A4                               ; $10280E
        BGT.S  loc_102823                       ; $102810
        CMPA.W  (A1),A4                         ; $102812
        CMPI.W  #$11C7,$0C(A6,A5.W)             ; $102814
        MOVEQ   #$10,D3                         ; $10281A
        MULS    -$80(A3,D0.L),D3                ; $10281C
        ADD.B  D6,D5                            ; $102820
        AND.B  D7,$53(A6,D6.L)                  ; $102822
        DC.W    $7BC3               ; $102826 MOVE.W  D3,<EA:3D>
        MOVEA.W A4,A3                           ; $102828
        MOVE.W  $2C(A6,A7.W),(A1)               ; $10282A
        MOVE.W  -(A3),$0B14(A0)                 ; $10282E
        ADDQ.W  #3,-(A1)                        ; $102832
        SUB.B  D0,(A4)+                         ; $102834
        OR.B   $6D(A1,A6.W),D6                  ; $102836
        MOVEA.W (A1)+,A4                        ; $10283A
        CMP.W  A3,D6                            ; $10283C
        MOVE.W  (A4),-(A5)                      ; $10283E
        DC.W    $B2BF               ; $102840 CMP.L  <EA:3F>,D1
        TST    (A2)+                            ; $102842
        SVC     -(A1)                           ; $102844
        ADD.B  D7,A7                            ; $102846
        DC.W    $00E1               ; $102848 DC.W    $00E1
        BSET    D1,D2                           ; $10284A
        MOVE.B  -$79(A1,A6.W),(A6)              ; $10284C
        OR.B   (A4),D4                          ; $102850
        MOVE.L  A6,$1E68F803                    ; $102852
        SUB.B  (A5)+,D5                         ; $102858
        CMP.B  D3,D7                            ; $10285A
        ADDA.L  D5,A4                           ; $10285C
        MOVE.W  #$3364,$37(A3,A6.W)             ; $10285E
        OR.W   D4,$6296(A7)                     ; $102864
        SUBQ.B  #3,(A1)+                        ; $102868
        SUBQ.W  #5,(A2)                         ; $10286A
        ADD.B  D5,-(A4)                         ; $10286C
        ROR.W  D1,D1                            ; $10286E
        SUBQ.W  #1,-$2A(A6,D5.L)                ; $102870
        ADDA.L  A1,A6                           ; $102874
        DC.W    $2DDA               ; $102876 MOVE.L  (A2)+,<EA:3E>
        MOVE.W  (A7)+,(A0)+                     ; $102878
        CMP.B  A6,D1                            ; $10287A
        MOVE.B  D0,(A7)+                        ; $10287C
        ASL.B  #4,D7                            ; $10287E
        ADDQ.B  #4,-$28(PC,D0.W)                ; $102880
        DC.W    $0ED0               ; $102884 DC.W    $0ED0
loc_102886:
        MOVE.W  D3,-(A2)                        ; $102886
        MOVE.L  (A0),(A3)                       ; $102888
        DC.W    $39F9,$0BA4,$1D60,$EEC8; $10288A MOVE.W  $0BA41D60,#$EEC8
        MOVEA.L (A4)+,A7                        ; $102892
        MOVE.W  -(A0),(A1)+                     ; $102894
        MOVE.L  A6,-(A3)                        ; $102896
        MOVE.W  (A0),-$266A(A7)                 ; $102898
        MOVE.W  -$1F(A6,D6.W),D6                ; $10289C
        BTST    D7,(A0)+                        ; $1028A0
        MOVEQ   #-$3A,D4                        ; $1028A2
        MOVE.B  (A3)+,(A5)+                     ; $1028A4
        EOR.L  D1,D6                            ; $1028A6
        DIVU    A4,D3                           ; $1028A8
        MOVE.W  -(A7),D6                        ; $1028AA
        AND.W  A3,D3                            ; $1028AC
        SUB.B  $27(A1,A6.W),D6                  ; $1028AE
        CMPI.W  #$6ED2,-$59(PC,A0.L)            ; $1028B2
        MOVE.B  $5B77(A7),$14B7(A4)             ; $1028B8
        BVC.S  loc_102886                       ; $1028BE
        DBLE    D4,$1060A5                      ; $1028C0
        MOVE.W  (A1)+,-(A0)                     ; $1028C4
        SUBA.L  D2,A4                           ; $1028C6
        ADD.W  D1,-$2D(A6,D7.W)                 ; $1028C8
        OR.L   D2,-(A6)                         ; $1028CC
        ROXR.L  D6,D7                           ; $1028CE
        MOVE.L  $5B(PC,A1.W),$61(A6,A3.L)       ; $1028D0
        SUB.B  D3,$596E(A3)                     ; $1028D6
        DC.W    $436E               ; $1028DA DC.W    $436E
        MOVE.B  (A3),-$39(A5,D6.W)              ; $1028DC
        DC.W    $2DCE               ; $1028E0 MOVE.L  A6,<EA:3E>
        MOVE.W  A3,(A0)+                        ; $1028E2
        SUB.L  D2,$48F1(A5)                     ; $1028E4
        MOVE.W  (A7),(A7)                       ; $1028E8
        OR.L   -$2F(A6,D6.W),D2                 ; $1028EA
        MOVE.B  $794BC630,-(A4)                 ; $1028EE
        ADDA.W  (A5)+,A2                        ; $1028F4
        SUB.B  $65(A4,A3.L),D6                  ; $1028F6
        LSL.B  D1,D7                            ; $1028FA
        BCHG    D4,-$3C82(A4)                   ; $1028FC
        SUBQ.B  #5,$E5E5.W                      ; $102900
        NOT.B  (A6)+                            ; $102904
        MOVEQ   #$61,D2                         ; $102906
        ASL.W  #3,D6                            ; $102908
        DC.W    $1E7F               ; $10290A MOVEA.B <EA:3F>,A7
        MOVE.L  -(A7),$0F49(PC)                 ; $10290C
        MOVE.W  D3,#$D21E                       ; $102910
        MOVEQ   #-$0C,D1                        ; $102914
        OR.L   D3,(A4)+                         ; $102916
        MOVE.W  -(A1),-(A6)                     ; $102918
        LSL.B  D3,D7                            ; $10291A
        DC.W    $497A               ; $10291C DC.W    $497A
        LEA     A6,A5                           ; $10291E
        ADDQ.L  #7,(A2)                         ; $102920
        MOVE.W  D7,-$18(A1,A1.L)                ; $102922
        MOVEQ   #$4B,D5                         ; $102926
        AND.B  (A6)+,D7                         ; $102928
        SUBA.W  -$5C(A3,A1.W),A0                ; $10292A
        MOVE.W  -(A1),(A6)+                     ; $10292E
        LSL.B  #4,D7                            ; $102930
        MOVEA.W $4BCE(PC),A4                    ; $102932
        MOVE.B  (A0),(A7)                       ; $102936
        MOVE.W  (A7),$3C(A1,A2.W)               ; $102938
        ASL.W  $465E(A1)                        ; $10293C
        MOVE.W  -(A5),$0F(A7,A6.W)              ; $102940
        PEA     $C3D21E70                       ; $102944
        MOVE.W  D7,(A2)                         ; $10294A
        DC.W    $9C3D               ; $10294C SUB.B  <EA:3D>,D6
        MOVE.L  -(A7),$0F49(PC)                 ; $10294E
        MOVE.W  D3,#$D21E                       ; $102952
        MOVEQ   #-$0C,D1                        ; $102956
        OR.L   D3,(A6)+                         ; $102958
        MOVEA.B $4197(PC),A4                    ; $10295A
        MOVE.L  (A1)+,-(A2)                     ; $10295E
        DC.W    $79FE,$979C         ; $102960 MOVE.W  <EA:3E>,#$979C
        MOVE.W  -(A1),(A6)+                     ; $102964
        LSL.B  D4,D7                            ; $102966
        MOVEA.W $43CE(PC),A4                    ; $102968
        ADDQ.L  #7,(A0)                         ; $10296C
        MOVE.W  D7,$3C(A1,A2.W)                 ; $10296E
        ASL.W  $2F38(A1)                        ; $102972
        MOVEQ   #$43,D5                         ; $102976
        AND.W  (A6)+,D7                         ; $102978
        SUB.W  -(A1),D2                         ; $10297A
        ASL.W  #3,D6                            ; $10297C
        DC.W    $5E7F               ; $10297E ADDQ.W  #7,<EA:3F>
        MOVE.L  -(A7),$0F48(PC)                 ; $102980
        MOVE.W  D3,#$D21E                       ; $102984
        MOVEQ   #-$0C,D0                        ; $102988
        OR.L   D3,(A4)+                         ; $10298A
        MOVE.W  -(A5),-(A6)                     ; $10298C
        LSL.B  #3,D7                            ; $10298E
        DC.W    $4979               ; $102990 DC.W    $4979
        MULS    (A2),D1                         ; $102992
        MOVEA.B -$79(A2,A7.W),A7                ; $102994
        SUB.B  (A0)+,D7                         ; $102998
        MOVEQ   #$41,D5                         ; $10299A
        SUB.L  D3,-(A5)                         ; $10299C
        DC.W    $1979,$FE97,$9C3C,$E1E9; $10299E MOVE.B  $FE979C3C,-$1E17(A4)
        MOVE.L  $7A43.W,-(A7)                   ; $1029A6
        AND.W  (A6)+,D7                         ; $1029AA
        SUBA.W  -$5C(A3,A0.W),A0                ; $1029AC
        MOVE.W  -(A1),(A6)+                     ; $1029B0
        LSL.B  D4,D7                            ; $1029B2
        MOVEA.W $43CE(PC),A4                    ; $1029B4
        ADDQ.L  #7,(A4)                         ; $1029B8
        BSR.S  loc_1029A3                       ; $1029BA
        NOT.W  (A6)+                            ; $1029BC
        MOVEQ   #$25,D7                         ; $1029BE
        LSL.B  #3,D7                            ; $1029C0
        PEA     $C3D21E70                       ; $1029C2
        MOVE.W  D7,(A2)                         ; $1029C8
        DC.W    $9C3D               ; $1029CA SUB.B  <EA:3D>,D6
        MOVE.L  -(A7),$4A1E(PC)                 ; $1029CC
        SUB.L  D7,-(A1)                         ; $1029D0
        LSL.B  D5,D7                            ; $1029D2
        BVC.S  loc_102A51                       ; $1029D4
        LEA     (A6),A1                         ; $1029D6
        MOVE.B  -$79(A2,A7.W),(A7)              ; $1029D8
        DC.W    $B4BD               ; $1029DC CMP.L  <EA:3D>,D2
        BCS.S  loc_1029CD                       ; $1029DE
        MOVE.L  (A0)+,$7B4B(A7)                 ; $1029E0
        ADD.W  (A6)+,D3                         ; $1029E4
        ADDA.W  -$51(A6,A1.W),A0                ; $1029E6
        ROR.W  D4,D3                            ; $1029EA
        LEA     (A6),A5                         ; $1029EC
        MOVE.B  (A0),(A7)+                      ; $1029EE
        MOVE.W  D7,-$43(A2,A3.W)                ; $1029F0
        MOVE.L  $0F58(A3),$7B4B.W               ; $1029F4
        ADD.B  (A6)+,D3                         ; $1029FA
        ADDA.W  -$4C(A5,A0.W),A0                ; $1029FC
        MOVE.W  -(A5),-$1406(A6)                ; $102A00
        SGT     (A0)                            ; $102A04
        MOVE.W  (A7),(A3)                       ; $102A06
        DC.W    $B4BD               ; $102A08 CMP.L  <EA:3D>,D2
        BCS.S  loc_1029F9                       ; $102A0A
        MOVE.L  (A0)+,$7AC3(A7)                 ; $102A0C
        ADD.B  (A6)+,D5                         ; $102A10
        CMPA.W  -$54(A6,A0.W),A0                ; $102A12
        EOR.L  D6,-(A1)                         ; $102A16
        LSL.B  #6,D7                            ; $102A18
        ADDQ.W  #4,-$0169(PC)                   ; $102A1A
        DC.W    $AC3D               ; $102A1E MOVE.L  <EA:3D>,D6
        MOVE.L  $2F69(A3),$7AC3(PC)             ; $102A20
        ADD.W  (A6)+,D5                         ; $102A26
        CMPA.W  -$4C(A6,A0.W),A1                ; $102A28
        EOR.W  D6,-(A1)                         ; $102A2C
        LSL.B  D6,D7                            ; $102A2E
        ADDQ.W  #4,-$2A(PC,D4.W)                ; $102A30
        MOVE.B  (A7)+,(A7)+                     ; $102A34
        MOVE.L  $0F58(A5),$7AC3(PC)             ; $102A36
        ADD.W  (A6)+,D5                         ; $102A3C
        CMPA.W  -$54(A6,A0.W),A0                ; $102A3E
        MOVE.W  -(A1),$2F(A6,A6.L)              ; $102A42
        SUBQ.W  #4,-$26(PC,D4.W)                ; $102A46
        SGT     (A2)                            ; $102A4A
        MOVE.W  (A7),-$17(A2,A3.W)              ; $102A4C
        MOVEQ   #-$3D,D5                        ; $102A50
        ADD.B  (A6)+,D3                         ; $102A52
        ADDA.W  -$4C(A5,A0.W),A0                ; $102A54
        MOVE.W  -(A5),-$12F1(A6)                ; $102A58
        BVC.S  loc_102AD8                       ; $102A5C
        MULS    (A6),D1                         ; $102A5E
        ADDQ.L  #7,-$69(A0,A7.W)                ; $102A60
        DC.W    $ACBD               ; $102A64 MOVE.L  <EA:3D>,(A6)
        MOVE.L  -$05E2(A3),-$2D0B(PC)           ; $102A66
        SUB.L  D3,-$5B(A4,D3.L)                 ; $102A6C
        LSL.B  #5,D7                            ; $102A70
        BVS.S  loc_102AEE                       ; $102A72
        MULS    (A2)+,D1                        ; $102A74
        MOVE.B  -$69(A0,A7.W),(A7)              ; $102A76
        DC.W    $B43D               ; $102A7A CMP.B  <EA:3D>,D2
        BSR.S  loc_102A69                       ; $102A7C
        BCHG    D7,$7AE1(A1)                    ; $102A7E
        OR.L   D3,$7B(A6,D1.L)                  ; $102A82
        SUBQ.L  #8,(A7)                         ; $102A86
        DC.W    $AFE8,$7B4B         ; $102A88 MOVE.L  $7B4B(A0),<EA:3F>
        ADD.W  (A6)+,D5                         ; $102A8C
        CMPA.W  -$54(A6,A1.W),A1                ; $102A8E
        MOVE.W  -(A1),-$12F1(A6)                ; $102A92
        ADDQ.W  #4,-$2A(PC,D4.W)                ; $102A96
        SGT     (A0)                            ; $102A9A
        MOVE.W  D7,(A3)                         ; $102A9C
        DC.W    $AC3D               ; $102A9E MOVE.L  <EA:3D>,D6
        BCS.S  loc_102A8D                       ; $102AA0
        NOT.B  (A6)+                            ; $102AA2
        MOVE.W  -(A1),D6                        ; $102AA4
        LSL.W  #7,D2                            ; $102AA6
        DC.W    $1F3F               ; $102AA8 MOVE.B  <EA:3F>,-(A7)
        MOVE.L  -$78(A5,D0.L),$7BCB.W           ; $102AAA
        ROR.B  #3,D7                            ; $102AB0
        MOVE.B  $87DC3EA1,(A0)+                 ; $102AB2
        MOVE.W  -$6785(A7),-(A0)                ; $102AB8
        MULS    -(A2),D1                        ; $102ABC
        MOVE.B  -$0D(A4,A2.W),(A7)+             ; $102ABE
        ADD.B  (A7)+,D1                         ; $102AC2
        ST      $87BC.W                         ; $102AC4
        MOVE.W  -(A1),D7                        ; $102AC8
        LSL.W  #7,D2                            ; $102ACA
        DC.W    $1F3F               ; $102ACC MOVE.B  <EA:3F>,-(A7)
        MOVE.L  -$78(A5,D0.L),$7BCB.W           ; $102ACE
        ROR.B  #3,D7                            ; $102AD4
        MOVE.B  $87DC3EA1,(A0)+                 ; $102AD6
        MOVE.W  -$6785(A7),-(A0)                ; $102ADC
        MULS    -(A2),D1                        ; $102AE0
        MOVE.B  -$0D(A4,A2.W),(A7)+             ; $102AE2
        MOVE.W  (A7)+,D1                        ; $102AE6
        ST      $87BC.W                         ; $102AE8
        CMP.W  -(A1),D7                         ; $102AEC
loc_102AEE:
        MOVE.W  A7,-(A0)                        ; $102AEE
        DC.W    $987D               ; $102AF0 SUB.W  <EA:3D>,D4
        MULS    $1F12(A2),D1                    ; $102AF2
        MOVE.W  D7,$3E(A4,A3.L)                 ; $102AF6
        MOVE.L  $4A1F(A7),$3D21.W               ; $102AFA
        MOVE.W  A7,-(A2)                        ; $102B00
        OR.W   -$1E(PC,A4.W),D4                 ; $102B02
        MOVE.B  -$0D(A4,A2.W),(A7)+             ; $102B06
        MOVE.W  (A7)+,D1                        ; $102B0A
        ST      $87BC.W                         ; $102B0C
        CMP.W  -(A1),D7                         ; $102B10
        MOVE.W  A7,-(A0)                        ; $102B12
        DC.W    $987D               ; $102B14 SUB.W  <EA:3D>,D4
        MULS    $1F12(A2),D1                    ; $102B16
        MOVE.W  D7,$3E(A4,A3.L)                 ; $102B1A
        MOVE.L  $4A1F(A7),$3F21.W               ; $102B1E
        MOVE.W  A7,-(A2)                        ; $102B24
        OR.W   -$1A(PC,A4.L),D4                 ; $102B26
        MOVE.B  (A0),-(A7)                      ; $102B2A
        MOVE.W  D7,$3E(A4,A5.L)                 ; $102B2C
        MOVE.L  -$68(A1,D2.L),$7BC3.W           ; $102B30
        ROR.B  #1,D6                            ; $102B36
        MOVE.W  -(A1),(A2)                      ; $102B38
        MOVE.W  (A2),$1F50F887                  ; $102B3A
        DC.W    $BC3E               ; $102B40 CMP.B  <EA:3E>,D6
        MOVE.L  $4A1F(A7),$3F21.W               ; $102B42
        MOVE.W  A7,-(A2)                        ; $102B48
        OR.W   -$1A(PC,A4.L),D4                 ; $102B4A
        MOVE.B  (A0),-(A7)                      ; $102B4E
        MOVE.W  D7,$3E(A4,A5.L)                 ; $102B50
        MOVE.L  -$68(A1,D2.L),$7BC3.W           ; $102B54
        ROR.B  #1,D6                            ; $102B5A
        MOVE.W  -(A1),(A2)                      ; $102B5C
        MOVE.W  A2,$1F50F887                    ; $102B5E
        ADD.W  D2,A0                            ; $102B64
        MOVEQ   #$70,D7                         ; $102B66
        DIVS    -(A5),D3                        ; $102B68
        EXT.W   D0                              ; $102B6A
        MOVE.W  D7,(A0)                         ; $102B6C
        ADD.W  D2,A0                            ; $102B6E
        MOVEQ   #$72,D7                         ; $102B70
        DIVS    -(A4),D3                        ; $102B72
        NEGX.W -(A1)                            ; $102B74
        MOVE.W  A2,$1F9C(A2)                    ; $102B76
        MOVE.L  $1F(A5,D4.L),$94E2.W            ; $102B7A
        BCHG    D2,D6                           ; $102B80
        DC.W    $1FFC,$A1F9         ; $102B82 MOVE.B  #$A1F9,<EA:3F>
        MOVE.B  (A0)+,D0                        ; $102B86
        MOVE.W  (A2),-$7819(A6)                 ; $102B88
        DC.W    $087D,$5487         ; $102B8C BCHG    #7,<EA:3D>
        LSL.B  #3,D0                            ; $102B90
        MOVEQ   #$54,D7                         ; $102B92
        OR.B   A7,D4                            ; $102B94
        DC.W    $087D,$5487         ; $102B96 BCHG    #7,<EA:3D>
        LSL.B  D3,D0                            ; $102B9A
        MOVEQ   #$44,D7                         ; $102B9C
        ADDI.B  #$54A1,(A7)+                    ; $102B9E
        MOVE.W  D2,#$1F54                       ; $102BA2
        DC.W    $A1F9,$4E20,$5461,$FFCA; $102BA6 MOVE.L  $4E205461,$FFCA.W
        MOVE.B  (A1),-$79(A7,D0.W)              ; $102BAE
        ADD.B  D2,$7E70(A0)                     ; $102BB2
        DIVS    (A5),D3                         ; $102BB6
        DC.W    $487E               ; $102BB8 PEA     <EA:3E>
        MOVEQ   #-$79,D0                        ; $102BBA
        LSL.W  #2,D0                            ; $102BBC
        DIVU    -$2B(A0,A0.W),D0                ; $102BBE
        DC.W    $487E               ; $102BC2 PEA     <EA:3E>
        MOVEQ   #-$79,D1                        ; $102BC4
        ASR.W  #2,D0                            ; $102BC6
        BSR.S  loc_102BBF                       ; $102BC8
        TST.B  (A7)+                            ; $102BCA
        SUB.B  -(A1),D6                         ; $102BCC
        MOVE.W  A2,$1F94(A2)                    ; $102BCE
        ASR.B  #1,D5                            ; $102BD2
        NOT.B  (A7)+                            ; $102BD4
        MOVE.W  -(A1),(A6)                      ; $102BD6
        MOVE.W  (A0),-(A4)                      ; $102BD8
        DC.W    $187D               ; $102BDA MOVEA.B <EA:3D>,A4
        ADDQ.L  #1,D7                           ; $102BDC
        LSL.B  #3,D0                            ; $102BDE
        MOVE.W  (A4),-$7819(A6)                 ; $102BE0
        DC.W    $C87E               ; $102BE4 AND.W  <EA:3E>,D4
        NEG.B  D6                               ; $102BE6
        ADD.B  D7,-$79(A4,A7.L)                 ; $102BE8
        DC.W    $DD3D               ; $102BEC ADD.B  D6,<EA:3D>
        ASR.B  #1,D7                            ; $102BEE
        MOVEA.B A0,A0                           ; $102BF0
        MOVEQ   #-$3C,D7                        ; $102BF2
        MOVE.B  -(A0),D5                        ; $102BF4
        MOVE.W  $8805.W,(A2)+                   ; $102BF6
        MOVE.W  D4,(A4)                         ; $102BFA
        MOVE.W  D7,$40(A2,A4.L)                 ; $102BFC
        LSR.B  #1,D1                            ; $102C00
        BSET    D7,(A0)+                        ; $102C02
        OR.W   D1,(A3)+                         ; $102C04
        ROXL.B  #3,D5                           ; $102C06
        DC.W    $C2FE               ; $102C08 MULU    <EA:3E>,D1
        SMI     -(A6)                           ; $102C0A
        SUB.B  D7,(A0)                          ; $102C0C
        MOVE.W  -(A7),$41(A5,A3.L)              ; $102C0E
        ASL.W  $08(A1,D1.W)                     ; $102C12
        OR.W   D4,D2                            ; $102C16
        DC.W    $0E20               ; $102C18 DC.W    $0E20
        DC.W    $90FD               ; $102C1A SUBA.W  <EA:3D>,A0
        OR.B   $71(A5,A3.L),D4                  ; $102C1C
        ADDQ.B  #6,-$2A42(A7)                   ; $102C20
        BVS.S  loc_102C17                       ; $102C24
        BCLR    D7,$7BC4(PC)                    ; $102C26
        DC.W    $0E20               ; $102C2A DC.W    $0E20
        DC.W    $90FD               ; $102C2C SUBA.W  <EA:3D>,A0
        OR.B   -$17(A4,D4.W),D4                 ; $102C2E
        MOVE.W  (A0),-(A0)                      ; $102C32
        EORI.W  #$08EB,-$68(A1,D0.L)            ; $102C34
        DIVS    D4,D0                           ; $102C3A
        MOVE.B  (A7)+,D1                        ; $102C3C
        EOR.B  D0,D6                            ; $102C3E
        CMPA.L  A6,A3                           ; $102C40
        MOVE.L  D5,-$49(A5,A7.L)                ; $102C42
        DC.W    $CD3E               ; $102C46 AND.B  D6,<EA:3E>
        MOVE.L  $78(A7,D4.L),$83D3.W            ; $102C48
        ASR.B  D1,D0                            ; $102C4E
        MOVE.B  A0,-(A0)                        ; $102C50
        OR.B   (A4)+,D4                         ; $102C52
        DC.W    $4121               ; $102C54 DC.W    $4121
        MOVE.W  (A0),-(A5)                      ; $102C56
        BMI.S  loc_102CD6                       ; $102C58
        ROR.L  D1,D0                            ; $102C5A
        SUBQ.L  #7,$7CD3(A3)                    ; $102C5C
        ROR.B  #1,D7                            ; $102C60
        MOVEQ   #-$09,D2                        ; $102C62
        OR.B   (A4)+,D4                         ; $102C64
        DC.W    $4121               ; $102C66 DC.W    $4121
        MOVE.W  (A0),-(A5)                      ; $102C68
        BVC.S  loc_102BEF                       ; $102C6A
        ADDA.L  -(A2),A1                        ; $102C6C
        MOVE.L  (A4),D0                         ; $102C6E
        ROXR.B  #1,D1                           ; $102C70
        ADD.B  (A7)+,D3                         ; $102C72
        MOVE.W  D3,-(A0)                        ; $102C74
        OR.B   -(A4),D4                         ; $102C76
        MOVE.W  -(A2),$0D6F(A7)                 ; $102C78
        SUB.W  (A7),D6                          ; $102C7C
        BSET    D5,$6F9A7C43                    ; $102C7E
        ROR.L  #7,D6                            ; $102C84
        MOVE.W  D7,-(A0)                        ; $102C86
        MOVE.L  D4,$22(PC,D4.W)                 ; $102C88
        MOVE.B  (A0),-(A0)                      ; $102C8C
        MOVE.W  D2,(A4)                         ; $102C8E
        LEA     -$2A(A6,D2.W),A1                ; $102C90
        MOVE.W  D5,#$70BF                       ; $102C94
        MOVE.B  $A7C43EE9,(A3)+                 ; $102C98
        ROXL.B  #7,D0                           ; $102C9E
        MOVE.W  D2,(A4)                         ; $102CA0
        LEA     -$2F(A6,D2.W),A1                ; $102CA2
        CMPI.L  #$103E90FA,-(A5)                ; $102CA6
        DIVS    -(A4),D3                        ; $102CAC
        CLR    -(A1)                            ; $102CAE
        MOVE.W  A7,-(A1)                        ; $102CB0
        CMP.W  (A1),D5                          ; $102CB2
        BSET    D1,-(A1)                        ; $102CB4
        MOVE.B  A2,(A0)+                        ; $102CB6
        SUBQ.B  #8,D3                           ; $102CB8
        LSL.B  #4,D7                            ; $102CBA
        DC.W    $A87E               ; $102CBC MOVEA.L <EA:3E>,A4
        NEG.B  $1F31(A6)                        ; $102CBE
        CMPI.L  #$103E110C,-(A5)                ; $102CC2
        MOVE.L  (A0),-(A2)                      ; $102CC8
        MOVE.W  (A0),-(A7)                      ; $102CCA
        MOVE.W  -(A7),$41(A5,A3.L)              ; $102CCC
        ASL.W  -$58(A1,D0.L)                    ; $102CD0
        MOVEQ   #$44,D7                         ; $102CD4
loc_102CD6:
        MOVE.L  (A7)+,D7                        ; $102CD6
        MOVE.W  A4,-(A0)                        ; $102CD8
        MOVE.L  (A0),-(A2)                      ; $102CDA
        MOVE.W  (A1),D7                         ; $102CDC
        CMPI.L  #$103E90FA,-(A5)                ; $102CDE
        DIVS    -(A4),D3                        ; $102CE4
        CLR    -(A1)                            ; $102CE6
        MOVE.W  A7,-(A1)                        ; $102CE8
        CMP.W  (A1),D5                          ; $102CEA
        BSET    D1,-(A1)                        ; $102CEC
        MOVE.B  A2,(A0)+                        ; $102CEE
        SUBQ.B  #8,D3                           ; $102CF0
        LSL.B  #4,D7                            ; $102CF2
        DC.W    $A87E               ; $102CF4 MOVEA.L <EA:3E>,A4
        NEG.B  $1F31(A6)                        ; $102CF6
        CMPI.L  #$103E110C,-(A5)                ; $102CFA
        MOVE.L  (A0),-(A2)                      ; $102D00
        MOVE.W  (A0),-(A7)                      ; $102D02
        MOVE.W  -(A7),$41(A5,A3.L)              ; $102D04
        ASL.W  -$58(A1,D0.L)                    ; $102D08
        MOVEQ   #$44,D7                         ; $102D0C
        MOVE.L  (A7)+,D7                        ; $102D0E
        MOVE.W  A4,-(A0)                        ; $102D10
        MOVE.L  (A0),-(A2)                      ; $102D12
        MOVE.W  (A1),D7                         ; $102D14
        CMPI.L  #$103E90FA,-(A5)                ; $102D16
        DIVS    -(A4),D3                        ; $102D1C
        CLR    -(A1)                            ; $102D1E
        MOVE.W  A7,-(A1)                        ; $102D20
        CMP.W  (A1),D5                          ; $102D22
        BSET    D1,-(A1)                        ; $102D24
        MOVE.B  A2,(A0)+                        ; $102D26
        SUBQ.B  #8,D3                           ; $102D28
        LSL.B  #4,D7                            ; $102D2A
        DC.W    $A87E               ; $102D2C MOVEA.L <EA:3E>,A4
        NEG.B  $1F31(A6)                        ; $102D2E
        CMPI.L  #$103E110C,-(A5)                ; $102D32
        MOVE.L  (A0),-(A2)                      ; $102D38
        MOVE.W  (A0),-(A7)                      ; $102D3A
        MOVE.W  -(A7),$41(A5,A3.L)              ; $102D3C
        ASL.W  -$58(A1,D0.L)                    ; $102D40
        MOVEQ   #$44,D7                         ; $102D44
        MOVE.L  (A7)+,D7                        ; $102D46
        MOVE.W  A4,-(A0)                        ; $102D48
        MOVE.L  (A0),-(A2)                      ; $102D4A
        MOVE.W  (A1),D7                         ; $102D4C
        CMPI.L  #$103ED0FA,-(A5)                ; $102D4E
        DIVS    -(A4),D3                        ; $102D54
        CLR    -(A1)                            ; $102D56
        MOVE.W  (A0),-(A1)                      ; $102D58
        MOVEQ   #$7C,D5                         ; $102D5A
        NEG.B  D2                               ; $102D5C
        SUB.W  D2,D2                            ; $102D5E
        MOVEA.W D4,A6                           ; $102D60
        MOVE.B  (A7)+,(A7)                      ; $102D62
        MOVE.B  -$781C(PC),(A0)+                ; $102D64
        MOVE.W  -(A2),$0D10(A7)                 ; $102D68
        MOVEQ   #$7C,D5                         ; $102D6C
        NEG.B  D2                               ; $102D6E
        SUB.W  D2,D2                            ; $102D70
        MOVE.W  D4,$1E9F(A7)                    ; $102D72
        MOVE.B  D7,-(A0)                        ; $102D76
        MOVE.L  D4,$22(PC,D4.W)                 ; $102D78
        MOVE.B  (A0),-(A0)                      ; $102D7C
        MOVEQ   #$7C,D5                         ; $102D7E
        NEG.B  D2                               ; $102D80
        MOVE.L  (A0),-(A0)                      ; $102D82
        MOVE.W  D7,(A5)                         ; $102D84
        ROR.B  D2,D7                            ; $102D86
        BHI.S  loc_102D97                       ; $102D88
        MOVE.B  (A7)+,(A0)                      ; $102D8A
        MOVE.W  A2,-(A0)                        ; $102D8C
        DC.W    $883D               ; $102D8E OR.B   <EA:3D>,D4
        MOVE.W  -(A2),D7                        ; $102D90
        DC.W    $0F4F               ; $102D92 BCHG    D7,A7
        OR.L   D0,D4                            ; $102D94
        NEG.B  -(A2)                            ; $102D96
        MOVE.L  -$78(A4,A7.L),(A0)+             ; $102D98
        BTST    D2,-$7B88(A0)                   ; $102D9C
        DC.W    $883D               ; $102DA0 OR.B   <EA:3D>,D4
        MOVE.W  -(A1),D7                        ; $102DA2
        MOVE.W  A7,-(A2)                        ; $102DA4
        DC.W    $C87E               ; $102DA6 AND.W  <EA:3E>,D4
        AND.B  (A2)+,D2                         ; $102DA8
        MOVE.L  -$78(A4,A7.L),(A0)+             ; $102DAA
        BTST    D2,-$7B82(A0)                   ; $102DAE
        DC.W    $883D               ; $102DB2 OR.B   <EA:3D>,D4
        MOVE.W  -(A2),D7                        ; $102DB4
        DC.W    $0F4F               ; $102DB6 BCHG    D7,A7
        OR.L   D0,D4                            ; $102DB8
        NEG.B  -(A2)                            ; $102DBA
        MOVE.L  -$78(A4,A7.L),(A0)+             ; $102DBC
        SUBI.W  #$21F5,D2                       ; $102DC0
        DC.W    $0FC8               ; $102DC4 BSET    D7,A0
        MOVEQ   #-$3C,D7                        ; $102DC6
        MOVE.B  -(A1),D5                        ; $102DC8
        MOVEA.W -(A2),A7                        ; $102DCA
        MOVE.B  (A0),-(A2)                      ; $102DCC
        MOVEQ   #$7C,D5                         ; $102DCE
        NEG.B  (A6)+                            ; $102DD0
        SUB.B  D7,(A1)                          ; $102DD2
        ORI.L  #$4441E9F1,A0                    ; $102DD4
        MOVE.B  A2,D0                           ; $102DDA
        SUBQ.B  #8,A0                           ; $102DDC
        MOVE.W  (A0),-(A0)                      ; $102DDE
        MOVEQ   #$7C,D5                         ; $102DE0
        LEA     $1F90(A2),A1                    ; $102DE2
        MOVE.W  A0,$41(A6,D3.W)                 ; $102DE6
        ASL.W  $0A(A1,D1.W)                     ; $102DEA
        SUBQ.B  #8,A0                           ; $102DEE
        MOVE.W  (A0),-(A6)                      ; $102DF0
        MOVEQ   #$7C,D5                         ; $102DF2
        NEG.B  (A6)+                            ; $102DF4
        SUB.B  D7,(A1)                          ; $102DF6
        ORI.L  #$4441E9F1,A0                    ; $102DF8
        MOVE.B  A0,D0                           ; $102DFE
        OR.W   D3,D2                            ; $102E00
        ROR.B  #5,D7                            ; $102E02
        DC.W    $90FD               ; $102E04 SUBA.W  <EA:3D>,A0
        OR.B   $7C(A4,D4.W),D4                  ; $102E06
        AND.B  $20F4(A2),D2                     ; $102E0A
        MOVE.W  A0,(A4)                         ; $102E0E
        DC.W    $3D3E               ; $102E10 MOVE.W  <EA:3E>,-(A6)
        MOVE.L  D1,D1                           ; $102E12
        MOVE.B  A0,(A0)                         ; $102E14
        DIVS    (A3),D1                         ; $102E16
        ASR.B  D1,D0                            ; $102E18
        MOVE.B  -(A2),(A2)                      ; $102E1A
        MOVE.B  -(A6),$20F4.W                   ; $102E1C
        MOVE.W  D7,(A4)                         ; $102E20
        DC.W    $DD3D               ; $102E22 ADD.B  D6,<EA:3D>
        LSR.B  #1,D7                            ; $102E24
        DC.W    $4F88               ; $102E26 DC.W    $4F88
        OR.W   D4,D3                            ; $102E28
        DC.W    $0E1F               ; $102E2A DC.W    $0E1F
        MOVE.W  D3,-(A0)                        ; $102E2C
        MOVE.L  (A0),-(A2)                      ; $102E2E
        SUB.B  -$79(A0,A7.L),D7                 ; $102E30
        ADD.B  D6,-$7E04(A0)                    ; $102E34
        OR.W   -(A4),D4                         ; $102E38
        NEGX   -(A1)                            ; $102E3A
        MOVE.W  (A0),-(A3)                      ; $102E3C
        DC.W    $387D               ; $102E3E MOVEA.W <EA:3D>,A4
        ADDA.L  (A6)+,A1                        ; $102E40
        MOVE.L  -$79(A4,A7.L),(A0)+             ; $102E42
        DC.W    $DD3D               ; $102E46 ADD.B  D6,<EA:3D>
        LSR.B  #1,D7                            ; $102E48
        DC.W    $4F8B               ; $102E4A DC.W    $4F8B
        MOVEQ   #-$1E,D6                        ; $102E4C
        CMP.W  (A7)+,D4                         ; $102E4E
        ASR.L  #4,D6                            ; $102E50
        NEG.B  A6                               ; $102E52
        MOVE.B  -$79(A1,D0.W),-$22C3(A7)        ; $102E54
        LSR.B  #1,D7                            ; $102E5A
        DC.W    $4F88               ; $102E5C DC.W    $4F88
        DC.W    $7DD3               ; $102E5E MOVE.W  (A3),<EA:3E>
        ADD.B  -(A0),D7                         ; $102E60
        MOVE.W  $8864.W,(A2)+                   ; $102E62
        NEGX   -(A1)                            ; $102E66
        MOVE.W  D2,$74(PC,D2.W)                 ; $102E68
        MOVE.L  (A3),D1                         ; $102E6C
        AND.B  (A7)+,D3                         ; $102E6E
        MOVE.W  $10(PC,A2.W),(A0)+              ; $102E70
        MOVE.W  (A1),-$78(A7,D0.L)              ; $102E74
        DC.W    $1C3E               ; $102E78 MOVE.B  <EA:3E>,D6
        ASR.B  #1,D7                            ; $102E7A
        BCLR    D7,$7BC4(PC)                    ; $102E7C
        MOVE.B  (A7)+,(A7)                      ; $102E80
        MOVE.B  -$44(PC,A2.W),(A0)+             ; $102E82
        LEA     -$0E91(A1),A0                   ; $102E86
        SUB.W  (A7),D6                          ; $102E8A
        DC.W    $0BFD               ; $102E8C BSET    D5,<EA:3D>
        MOVE.B  A0,(A0)+                        ; $102E8E
        DIVS    D3,D0                           ; $102E90
        ASR.B  D7,D0                            ; $102E92
        MOVEQ   #-$05,D0                        ; $102E94
        DC.W    $A7BC,$41E9,$F10F,$BA7B; $102E96 MOVE.L  #$41E9F10F,$7B(A3,A3.L)
        AND.B  (A6)+,D2                         ; $102E9E
        SUB.B  D7,(A1)                          ; $102EA0
        CMPI.L  #$1C3EF844,A0                   ; $102EA2
        DC.W    $0E94               ; $102EA8 DC.W    $0E94
        CLR.W  $C3E6.W                          ; $102EAA
        MOVE.B  $07(A4,A2.W),-$0DDF(A7)         ; $102EAE
        SUB.B  D0,D3                            ; $102EB4
        DIVS    (A4)+,D3                        ; $102EB6
        NEGX   -(A1)                            ; $102EB8
        MOVE.W  A7,$7883(A3)                    ; $102EBA
        ADDA.L  -(A2),A1                        ; $102EBE
        MOVE.B  -$78(A4,A7.W),$3D3E(A7)         ; $102EC0
        DC.W    $2DF3,$8AE1         ; $102EC6 MOVE.L  -$1F(A3,A0.L),<EA:3E>
        MOVE.W  -(A2),$10(A7,D1.L)              ; $102ECA
        DC.W    $387D               ; $102ECE MOVEA.W <EA:3D>,A4
        AND.B  A6,D2                            ; $102ED0
        MOVE.B  -$78(A4,A7.W),$3D3E(A7)         ; $102ED2
        MOVE.L  $78(A7,D4.L),$83D3.W            ; $102ED8
        ASR.B  D1,D1                            ; $102EDE
        SUB.B  D0,D3                            ; $102EE0
        DIVS    (A6)+,D3                        ; $102EE2
        MOVE.B  D1,(A4)                         ; $102EE4
        ADD.L  A0,D1                            ; $102EE6
        MOVE.B  (A0)+,-(A6)                     ; $102EE8
        DC.W    $7FF2,$87E4         ; $102EEA MOVE.W  -$1C(A2,A0.W),<EA:3F>
        NEGX.W -(A1)                            ; $102EEE
        MOVE.W  (A2),$1F9C(A2)                  ; $102EF0
        DC.W    $21F9,$5220,$3461,$FFCA; $102EF4 MOVE.L  $52203461,$FFCA.W
        MOVE.B  (A1),-$79(A7,D0.W)              ; $102EFC
        ADD.B  D2,$7E70(A0)                     ; $102F00
        DIVS    (A5),D3                         ; $102F04
        DC.W    $487E               ; $102F06 PEA     <EA:3E>
        MOVEQ   #-$79,D1                        ; $102F08
        ASR.W  #2,D0                            ; $102F0A
        BSR.S  loc_102F03                       ; $102F0C
        TST.B  (A7)+                            ; $102F0E
        SUBA.W  -(A2),A2                        ; $102F10
        BCHG    D2,D6                           ; $102F12
        DC.W    $1FFC,$A1F9         ; $102F14 MOVE.B  #$A1F9,<EA:3F>
        MOVE.B  (A0)+,D0                        ; $102F18
        MOVE.W  (A4),-$7819(A6)                 ; $102F1A
        DC.W    $087E,$5488         ; $102F1E BCHG    #8,<EA:3E>
        BTST    D6,(A0)+                        ; $102F22
        DC.W    $7FF2,$87E4         ; $102F24 MOVE.W  -$1C(A2,A0.W),<EA:3F>
        NEGX.W -(A1)                            ; $102F28
        MOVE.W  A2,$1F9C(A2)                    ; $102F2A
        MOVE.L  $1F(A5,D5.W),$9CA1.W            ; $102F2E
loc_102F34:
        MOVE.W  (A0),-(A4)                      ; $102F34
        DC.W    $187D               ; $102F36 MOVEA.B <EA:3D>,A4
        ADDQ.L  #1,D7                           ; $102F38
        ROL.B  D2,D0                            ; $102F3A
        OR.W   D0,(A1)                          ; $102F3C
        DC.W    $87FF               ; $102F3E DIVS    <EA:3F>,D3
        DC.W    $287E               ; $102F40 MOVEA.L <EA:3E>,A4
        NEG.B  D6                               ; $102F42
loc_102F44:
        MOVE.B  (A5),$21F9(A7)                  ; $102F44
        AND.B  (A7)+,D1                         ; $102F48
        SUB.B  D2,-(A2)                         ; $102F4A
        BCHG    D1,D6                           ; $102F4C
        DC.W    $1FFC,$A1F9         ; $102F4E MOVE.B  #$A1F9,<EA:3F>
        MOVE.B  (A0)+,D0                        ; $102F52
        MOVE.W  (A2),-$7819(A6)                 ; $102F54
        DC.W    $087D,$5487         ; $102F58 BCHG    #7,<EA:3D>
        LSL.B  D3,D0                            ; $102F5C
        MOVEQ   #$44,D7                         ; $102F5E
        ADDI.B  #$54A1,(A7)+                    ; $102F60
        MOVE.W  A6,$2054(A4)                    ; $102F64
        BSR.L  $FA2FC06B                        ; $102F68
        DC.W    $883D               ; $102F6E OR.B   <EA:3D>,D4
        MOVE.W  -(A2),D7                        ; $102F70
        BTST    D0,(A0)                         ; $102F72
        OR.L   D1,D4                            ; $102F74
        AND.B  (A2),D2                          ; $102F76
        MOVE.B  -$49(A1,D0.W),$3E(A7,A4.L)      ; $102F78
        MOVE.L  $78(A7,D4.L),$81FB.W            ; $102F7E
        OR.B   -(A4),D4                         ; $102F84
        MOVE.W  -(A2),$0D10(A7)                 ; $102F86
        MOVEQ   #$7C,D5                         ; $102F8A
        NEG.B  D2                               ; $102F8C
        MOVE.L  (A1),-(A0)                      ; $102F8E
        DC.W    $0388               ; $102F90 BCLR    D1,A0
        DC.W    $243F               ; $102F92 MOVE.L  <EA:3F>,D2
        BHI.S  loc_102FA3                       ; $102F94
        BLE.S  loc_102F34                       ; $102F96
        SUBQ.B  #3,A3                           ; $102F98
        MOVE.W  -$6584(A7),$43EE(A6)            ; $102F9A
        SUBA.W  -$78(A1,D0.W),A7                ; $102FA0
        DC.W    $243F               ; $102FA4 MOVE.L  <EA:3F>,D2
        BHI.S  loc_102FB5                       ; $102FA6
        BLE.S  loc_102F44                       ; $102FA8
        MOVEQ   #$43,D6                         ; $102FAA
        ROR.L  #7,D6                            ; $102FAC
        MOVE.W  D7,-(A0)                        ; $102FAE
        MOVE.L  D4,$3F(PC,D4.W)                 ; $102FB0
        NEG.B  -(A2)                            ; $102FB4
        MOVEA.L -$79(A1,D0.W),A0                ; $102FB6
        ASR.W  #6,D1                            ; $102FBA
        DC.W    $ADF3,$4F88         ; $102FBC MOVE.L  -$78(A3,D4.L),<EA:3E>
        DC.W    $7DD3               ; $102FC0 MOVE.W  (A3),<EA:3E>
        ADD.B  -(A0),D7                         ; $102FC2
        MOVE.W  D4,-(A0)                        ; $102FC4
        DIVS    $41A2(A4),D3                    ; $102FC6
        DC.W    $0F4F               ; $102FCA BCHG    D7,A7
        DIVU    (A1),D7                         ; $102FCC
        ORI.L  #$4440E209,A0                    ; $102FCE
        BSET    D7,(A0)+                        ; $102FD4
        OR.W   D1,(A3)+                         ; $102FD6
        ROXL.B  #3,D5                           ; $102FD8
        DC.W    $C2FF               ; $102FDA MULU    <EA:3F>,D1
        SMI     -(A6)                           ; $102FDC
        SUB.B  D7,(A0)                          ; $102FDE
        MOVE.W  -(A7),$40(A5,A3.L)              ; $102FE0
        LSR.B  #1,D1                            ; $102FE4
        BSET    D7,(A0)+                        ; $102FE6
        OR.W   D1,(A3)+                         ; $102FE8
        ROR.L  #3,D7                            ; $102FEA
        MOVE.B  -$44(PC,A2.W),(A0)+             ; $102FEC
        LEA     -$0EF0(A1),A0                   ; $102FF0
        BSET    D7,(A1)                         ; $102FF4
        DC.W    $0888,$1C41         ; $102FF6 BCLR    #1,A0
        MOVE.L  $6B(PC,D1.W),$7CD3.W            ; $102FFA
        ROR.B  #1,D7                            ; $103000
        MOVEQ   #-$09,D2                        ; $103002
        OR.B   (A4)+,D4                         ; $103004
        DC.W    $4121               ; $103006 DC.W    $4121
        MOVE.W  (A0),-(A5)                      ; $103008
        BVC.S  loc_102F8F                       ; $10300A
        ADDA.L  -(A3),A1                        ; $10300C
        CMP.W  D0,D2                            ; $10300E
        MOVE.L  (A1),D1                         ; $103010
        MOVE.B  $8243.W,D0                      ; $103012
        MOVE.W  -(A0),D3                        ; $103016
        ADDA.W  $C570BFD6,A3                    ; $103018
        MOVE.W  -(A7),$3E(A4,A4.W)              ; $10301E
        ASL.W  $1038(A7)                        ; $103022
        OR.W   D3,D1                            ; $103026
        MOVE.W  -(A0),D3                        ; $103028
        ADDA.W  $A7C43EE9,A3                    ; $10302A
        ROXL.B  #7,D0                           ; $103030
        MOVEQ   #$7C,D5                         ; $103032
        NEG.B  D3                               ; $103034
        ASR.W  #6,D2                            ; $103036
        MOVE.L  D7,D1                           ; $103038
        MOVEA.B A0,A0                           ; $10303A
        MOVEQ   #-$3C,D7                        ; $10303C
        MOVE.B  (A7)+,D5                        ; $10303E
        MOVEQ   #-$09,D2                        ; $103040
        DC.W    $883D               ; $103042 OR.B   <EA:3D>,D4
        MOVE.W  -(A1),D7                        ; $103044
        MOVE.W  A7,-(A2)                        ; $103046
        AND.L  D5,D4                            ; $103048
        MULS    -(A6),D1                        ; $10304A
        MOVE.L  (A4),$07(A0,A2.W)               ; $10304C
        ADD.B  (A7)+,D1                         ; $103050
        ST      #$885C                          ; $103052
        MOVEA.W -(A1),A7                        ; $103056
        MOVE.W  A2,$207D(A3)                    ; $103058
        MOVE.L  -$38(A5,D0.L),$85C3.W           ; $10305C
        ASR.B  D3,D1                            ; $103062
        SUB.L  -(A2),D2                         ; $103064
        BSET    D3,D2                           ; $103066
        MOVE.L  (A4),$07(A0,A2.W)               ; $103068
        ADD.B  (A7)+,D1                         ; $10306C
        ST      #$885C                          ; $10306E
        MOVEA.W -(A2),A7                        ; $103072
        MOVE.B  A2,$207E(A4)                    ; $103074
        MOVE.L  $78(A7,D4.L),$83D3.W            ; $103078
        ROR.B  #1,D7                            ; $10307E
        ST      #$885C                          ; $103080
        MOVEA.W -(A2),A7                        ; $103084
        MOVE.B  A2,$207D(A4)                    ; $103086
        MOVE.L  -$38(A5,D0.L),$85C3.W           ; $10308A
        ROR.B  #3,D7                            ; $103090
        MOVEQ   #-$5E,D2                        ; $103092
        BSET    D3,(A2)                         ; $103094
        MOVE.B  (A0),-$0378(A7)                 ; $103096
        DC.W    $5C3E               ; $10309A ADDQ.B  #6,<EA:3E>
        BHI.S  loc_1030B7                       ; $10309C
        TST.B  -(A0)                            ; $10309E
        MOVEQ   #$22,D6                         ; $1030A0
        MOVE.B  A2,$207D(A4)                    ; $1030A2
        MOVE.L  -$38(A5,D0.L),$85C3.W           ; $1030A6
        ASR.B  D3,D1                            ; $1030AC
        SUB.L  -(A2),D2                         ; $1030AE
        BSET    D3,-(A2)                        ; $1030B0
        MOVE.B  -$78(A4,A7.W),$3D3E(A7)         ; $1030B2
        MOVE.L  -$38(A5,D0.L),$85C3.W           ; $1030B8
        ASR.B  D3,D1                            ; $1030BE
        SUB.L  -(A2),D2                         ; $1030C0
        BSET    D3,(A2)                         ; $1030C2
loc_1030C4:
        MOVE.B  (A0),-$0378(A7)                 ; $1030C4
        DC.W    $5C3E               ; $1030C8 ADDQ.B  #6,<EA:3E>
        BSR.S  loc_1030C3                       ; $1030CA
        TST.B  -(A0)                            ; $1030CC
        MOVE.W  -(A1),-(A6)                     ; $1030CE
        MOVE.W  A7,-(A2)                        ; $1030D0
        AND.L  D5,D4                            ; $1030D2
        MULS    -(A6),D1                        ; $1030D4
        MOVE.L  (A4),$07(A0,A2.W)               ; $1030D6
        AND.B  -(A1),D1                         ; $1030DA
        SUB.L  -(A2),D2                         ; $1030DC
        BSET    D3,(A2)                         ; $1030DE
        MOVE.B  (A0),-$0378(A7)                 ; $1030E0
        DC.W    $5C3E               ; $1030E4 ADDQ.B  #6,<EA:3E>
        BHI.S  loc_103101                       ; $1030E6
        TST.B  -(A0)                            ; $1030E8
        MOVE.W  -(A1),$4F(A7,A7.W)              ; $1030EA
        MOVEQ   #-$7D,D4                        ; $1030EE
        ADDA.L  -(A2),A1                        ; $1030F0
        MOVE.B  (A0),-$0378(A7)                 ; $1030F2
        DC.W    $5C3E               ; $1030F6 ADDQ.B  #6,<EA:3E>
        BSR.S  loc_1030EF                       ; $1030F8
        DC.W    $0FC8               ; $1030FA BSET    D7,A0
        MOVEQ   #-$3C,D7                        ; $1030FC
        MOVE.B  -(A1),D5                        ; $1030FE
        MOVE.W  A2,-(A0)                        ; $103100
        DC.W    $883F               ; $103102 OR.B   <EA:3F>,D4
        MOVEA.W #$441E,A5                       ; $103104
        SUB.B  D7,(A1)                          ; $103108
        ORI.L  #$108FD107,-(A5)                 ; $10310A
        MOVE.L  D4,-$5F(PC,D3.L)                ; $103110
        MOVE.W  A7,-(A4)                        ; $103114
        ADD.L  D3,D4                            ; $103116
        NEG.B  -(A6)                            ; $103118
        MOVE.L  (A1),$07A7(A0)                  ; $10311A
        AND.W  D1,D2                            ; $10311E
        ASL.W  $08(A1,D1.W)                     ; $103120
        OR.W   D4,D2                            ; $103124
        MOVE.B  A5,$22(A7,D3.L)                 ; $103126
        DC.W    $014A               ; $10312A BCHG    D0,A2
        MOVE.L  (A7)+,-(A0)                     ; $10312C
        MOVE.L  A7,D1                           ; $10312E
        DC.W    $4F88               ; $103130 DC.W    $4F88
        DIVS    (A3),D1                         ; $103132
        ASR.B  D1,D0                            ; $103134
        MOVE.B  A0,-(A0)                        ; $103136
        DIVS    (A4),D3                         ; $103138
        MOVE.W  -(A1),-(A7)                     ; $10313A
        MOVE.W  (A0),-(A5)                      ; $10313C
        BVC.S  loc_1030C4                       ; $10313E
        AND.B  $20F4(A2),D2                     ; $103140
        MOVE.W  A0,(A4)                         ; $103144
        MOVE.W  (A2)+,-(A7)                     ; $103146
        MOVEQ   #$44,D6                         ; $103148
        ANDI.L  #$423F441E,(A4)                 ; $10314A
        SUB.B  D7,(A0)                          ; $103150
        MOVE.W  D7,(A5)                         ; $103152
        ROR.B  D2,D7                            ; $103154
        BHI.S  loc_103165                       ; $103156
        MOVE.B  (A0)+,(A0)                      ; $103158
        OR.W   D2,D4                            ; $10315A
        MOVE.B  (A7)+,(A7)                      ; $10315C
        MOVE.B  D7,-(A0)                        ; $10315E
        MOVE.L  D4,$22(PC,D4.W)                 ; $103160
        MOVE.B  (A0),-(A0)                      ; $103164
        MOVEQ   #$34,D7                         ; $103166
        MOVE.W  A0,(A4)                         ; $103168
        BTST    D2,-$7B82(A0)                   ; $10316A
        DC.W    $883D               ; $10316E OR.B   <EA:3D>,D4
        MOVE.W  -(A2),D7                        ; $103170
        DC.W    $0F4F               ; $103172 BCHG    D7,A7
        OR.L   D0,D4                            ; $103174
        NEG.B  -(A2)                            ; $103176
        MOVE.B  (A0),-$0379(A7)                 ; $103178
        ASR.W  #6,D1                            ; $10317C
        MOVE.L  (A3),D1                         ; $10317E
        MOVE.B  -$7C2D(A0),(A0)                 ; $103180
        ASR.B  D1,D0                            ; $103184
        MOVEA.W -$0EF0(A1),A6                   ; $103186
        EORI.W  #$08FD,(A1)                     ; $10318A
        MOVEA.B $7C43(PC),A0                    ; $10318E
        ROR.B  #5,D7                            ; $103192
        DC.W    $90FD               ; $103194 SUBA.W  <EA:3D>,A0
        OR.B   $62(A4,D4.W),D4                  ; $103196
        MOVE.B  (A0),-(A2)                      ; $10319A
        MOVEQ   #$7C,D5                         ; $10319C
        NEG.B  (A6)+                            ; $10319E
        SUB.B  D7,(A1)                          ; $1031A0
        ORI.L  #$4441F8D3,A0                    ; $1031A2
        ASR.B  D1,D0                            ; $1031A8
        MOVE.B  -(A2),(A2)                      ; $1031AA
        MOVE.B  $20F4(PC),$F888.W               ; $1031AC
        DC.W    $3D3E               ; $1031B2 MOVE.W  <EA:3E>,-(A6)
        MOVE.L  D1,D1                           ; $1031B4
        MOVE.B  A0,(A0)                         ; $1031B6
        MOVE.W  D3,-$0DE1(A6)                   ; $1031B8
        EOR.B  D0,D6                            ; $1031BC
        OR.W   A4,D4                            ; $1031BE
        CLR.L  -(A2)                            ; $1031C0
        DC.W    $0F4F               ; $1031C2 BCHG    D7,A7
        OR.W   D5,#$E2B8                        ; $1031C4
        SUBQ.L  #7,$8644.W                      ; $1031C8
        DC.W    $0E1F               ; $1031CC DC.W    $0E1F
        MOVE.W  D3,-(A0)                        ; $1031CE
        DIVS    (A5)+,D3                        ; $1031D0
        DC.W    $3DE2               ; $1031D2 MOVE.W  -(A2),<EA:3E>
        DC.W    $0F4F               ; $1031D4 BCHG    D7,A7
        OR.L   D6,D4                            ; $1031D6
        NEG.B  A6                               ; $1031D8
        MOVE.B  -$5B(A1,D0.W),$109F(A7)         ; $1031DA
        ADDA.W  $886440E1,A0                    ; $1031E0
        MOVE.W  (A0),-(A3)                      ; $1031E6
        DC.W    $387D               ; $1031E8 MOVEA.W <EA:3D>,A4
        ADDA.L  (A6)+,A1                        ; $1031EA
        MOVE.L  -$79(A4,A7.L),(A0)+             ; $1031EC
        DC.W    $DD3D               ; $1031F0 ADD.B  D6,<EA:3D>
        LSR.B  #1,D7                            ; $1031F2
        DC.W    $4F88               ; $1031F4 DC.W    $4F88
        OR.W   D4,D3                            ; $1031F6
        BCLR    D7,-$1E(A4,D3.L)                ; $1031F8
        DC.W    $070F               ; $1031FC BTST    D3,A7
        CMP.W  $1E(PC,A4.W),D5                  ; $1031FE
        SUB.B  D7,(A6)                          ; $103202
        MOVE.W  D5,#$70BF                       ; $103204
        MOVE.W  A4,-(A0)                        ; $103208
        OR.B   (A4)+,D4                         ; $10320A
        MOVE.W  -(A2),(A7)+                     ; $10320C
        DC.W    $070F               ; $10320E BTST    D3,A7
        CMP.W  $1E(PC,A4.W),D5                  ; $103210
        SUB.B  D7,(A1)                          ; $103214
        CMPI.L  #$1C3EE207,A0                   ; $103216
        TST.B  -(A1)                            ; $10321C
        MOVE.W  -(A1),$10(A7,A7.W)              ; $10321E
        AND.L  D1,D4                            ; $103222
        MULS    $2070(A6),D1                    ; $103224
        MOVE.W  -(A7),$41(A5,A3.L)              ; $103228
        ASL.W  -$46(A1,D0.L)                    ; $10322C
        DC.W    $7BC4               ; $103230 MOVE.W  D4,<EA:3D>
        MOVE.B  (A7)+,(A7)                      ; $103232
        MOVE.B  A4,-(A0)                        ; $103234
        OR.B   (A7)+,D4                         ; $103236
        BVC.S  loc_1032B7                       ; $103238
        AND.B  A6,D2                            ; $10323A
        MOVE.B  -$78(A4,A7.W),$3D3E(A7)         ; $10323C
        DC.W    $2DF3,$8AE1         ; $103242 MOVE.L  -$1F(A3,A0.L),<EA:3E>
        MOVEQ   #-$1E,D7                        ; $103246
        MOVE.B  (A0),-(A4)                      ; $103248
        DC.W    $387D               ; $10324A MOVEA.W <EA:3D>,A4
        AND.B  A6,D2                            ; $10324C
        MOVE.B  -$78(A4,A7.W),$3D3E(A7)         ; $10324E
        MOVE.L  (A1)+,D1                        ; $103254
        MOVE.B  $7DC4.W,D0                      ; $103256
        DC.W    $0E94               ; $10325A DC.W    $0E94
        DC.W    $427F               ; $10325C CLR.W  <EA:3F>
        LEA     -(A6),A1                        ; $10325E
        MOVE.L  (A1),-$79(A0,D0.W)              ; $103260
        ADD.W  D0,D6                            ; $103264
        ASL.W  $78(A7,D4.L)                     ; $103266
        DIVS    (A3),D1                         ; $10326A
        ROR.B  #1,D7                            ; $10326C
        MOVEQ   #-$09,D2                        ; $10326E
        DC.W    $883D               ; $103270 OR.B   <EA:3D>,D4
        MOVE.W  -(A2),D7                        ; $103272
        MOVE.B  (A0),-(A4)                      ; $103274
        MOVE.W  (A0),(A7)+                      ; $103276
        MOVE.W  A0,$3E(A5,D1.L)                 ; $103278
        ASL.W  $107A(A7)                        ; $10327C
        MOVEQ   #$5B,D6                         ; $103280
        ROXL.B  #3,D5                           ; $103282
        MULU    $32(PC,D4.W),D1                 ; $103284
        MOVEA.L -$78(A0,A7.L),A0                ; $103288
        DC.W    $1C3F               ; $10328C MOVE.B  <EA:3F>,D6
        ASR.B  #1,D1                            ; $10328E
        DC.W    $0FCA               ; $103290 BSET    D7,A2
        SUB.B  D0,D1                            ; $103292
        MOVE.L  A7,-(A1)                        ; $103294
        MOVEA.W (A0),A7                         ; $103296
        MOVE.W  A0,(A6)                         ; $103298
        DC.W    $0C3E,$A943         ; $10329A CMPI.B  #$A943,<EA:3E>
        MOVE.W  (A4)+,(A1)                      ; $10329E
        NEGX.L $43EA.W                          ; $1032A0
        DC.W    $943F               ; $1032A4 SUB.B  <EA:3F>,D2
        MOVEA.W D3,A4                           ; $1032A6
        ASR.L  D5,D4                            ; $1032A8
        MOVE.W  $43F22030,-(A7)                 ; $1032AA
        MOVE.W  -(A5),(A5)                      ; $1032B0
        DC.W    $0FCA               ; $1032B2 BSET    D7,A2
        MOVE.W  D2,-(A0)                        ; $1032B4
        MOVE.L  A7,-(A1)                        ; $1032B6
        MOVE.W  (A0),D7                         ; $1032B8
        MOVE.W  $101A(A1),(A6)                  ; $1032BA
        DC.W    $30FF               ; $1032BE MOVE.W  <EA:3F>,(A0)+
        LSL.B  #2,D7                            ; $1032C0
        AND.L  D0,D4                            ; $1032C2
        MULS    -$6BC1(A2),D1                   ; $1032C4
        MOVE.L  D4,#$0B843EA9                   ; $1032C8
        LEA     $3E(A3,A0.W),A1                 ; $1032CE
        MOVEA.L D3,A5                           ; $1032D2
        MOVE.W  (A4),$22(A1,D3.L)               ; $1032D4
        DC.W    $030F               ; $1032D8 BTST    D1,A7
        MOVEA.L (A0),A5                         ; $1032DA
        MOVE.W  -(A7),(A6)                      ; $1032DC
        MOVE.B  $30FF(A2),D0                    ; $1032DE
        LSL.B  #8,D7                            ; $1032E2
        AND.L  (A1),D5                          ; $1032E4
        BCLR    D0,-(A3)                        ; $1032E6
        DC.W    $0FFE               ; $1032E8 BSET    D7,<EA:3E>
        ST      #$880C                          ; $1032EA
        MOVE.W  $43F2(A1),(A7)                  ; $1032EE
        SUB.W  D0,D6                            ; $1032F2
        CMP.W  D3,D4                            ; $1032F4
        ROXR.L  #5,D4                           ; $1032F6
        MOVE.W  $43EA.W,-(A7)                   ; $1032F8
        DC.W    $A43F               ; $1032FC MOVE.L  <EA:3F>,D2
        MOVE.W  D3,-$0DE0(A4)                   ; $1032FE
        MOVE.W  -$5AF1(PC),(A0)+                ; $103302
        AND.W  -$5D(A1,D0.W),D5                 ; $103306
        DC.W    $0FFE               ; $10330A BSET    D7,<EA:3E>
        MOVE.B  #$A910,(A0)+                    ; $10330C
        MOVE.B  -$03(A1,D0.W),D5                ; $103310
        BSET    D7,(A0)+                        ; $103314
        OR.W   D1,D4                            ; $103316
        MOVE.B  (A7)+,(A7)                      ; $103318
        MOVE.B  D0,-(A0)                        ; $10331A
        OR.W   D4,D4                            ; $10331C
        NEGX   -(A2)                            ; $10331E
        DC.W    $090F               ; $103320 BTST    D4,A7
        ADD.L  D3,D4                            ; $103322
        SMI     -(A6)                           ; $103324
        SUB.B  D7,(A0)                          ; $103326
        MOVE.W  -(A7),$41(A5,A3.L)              ; $103328
        MOVE.W  (A3),(A4)+                      ; $10332C
        ASR.B  D1,D0                            ; $10332E
        MOVE.B  -(A2),(A2)+                     ; $103330
        MOVE.B  $1F36(PC),$F9A7.W               ; $103332
        DC.W    $C43E               ; $103338 AND.B  <EA:3E>,D2
        ASL.W  $1038(A7)                        ; $10333A
        OR.W   D3,D1                            ; $10333E
        MOVE.W  -(A0),D3                        ; $103340
        ADDA.W  $A7C43EE9,A3                    ; $103342
        ROXL.B  #7,D0                           ; $103348
        MOVEQ   #$7C,D5                         ; $10334A
        MOVEQ   #-$78,D7                        ; $10334C
        SUBI.W  #$2207,D2                       ; $10334E
        MOVEA.B A0,A0                           ; $103352
        MOVEQ   #-$3C,D7                        ; $103354
        MOVE.B  -(A0),D5                        ; $103356
        MOVE.W  $8804.W,(A2)+                   ; $103358
        CLR.B  -(A2)                            ; $10335C
        BTST    D3,(A0)                         ; $10335E
        DC.W    $487E               ; $103360 PEA     <EA:3E>
        AND.B  (A2)+,D2                         ; $103362
        DC.W    $DF3D               ; $103364 ADD.B  D7,<EA:3D>
        BVS.S  loc_103359                       ; $103366
        BCLR    D7,$7BC4(PC)                    ; $103368
        MOVE.B  (A7)+,(A7)                      ; $10336C
        MOVE.B  D0,-(A0)                        ; $10336E
        MOVE.L  (A0),-(A3)                      ; $103370
        DIVS    (A0),D7                         ; $103372
        MOVE.W  $3E(A7,A4.L),-$09(A4,D2.W)      ; $103374
        DC.W    $4F78               ; $10337A DC.W    $4F78
        DIVS    D4,D0                           ; $10337C
        MOVE.B  (A7)+,D1                        ; $10337E
        EOR.B  D0,D6                            ; $103380
        CMPA.L  A5,A3                           ; $103382
        MOVE.W  -(A1),D7                        ; $103384
        MOVE.W  A7,$7883(A3)                    ; $103386
        ADDA.L  -(A3),A1                        ; $10338A
        MOVEA.W D0,A2                           ; $10338C
        MOVE.L  (A1),D1                         ; $10338E
        MOVE.B  $8243.W,D0                      ; $103390
        MOVE.W  -(A0),D3                        ; $103394
        ADD.B  D0,D7                            ; $103396
        MOVE.L  D4,$22(PC,D4.W)                 ; $103398
        MOVE.B  (A0),-(A0)                      ; $10339C
        MOVE.W  D2,(A4)                         ; $10339E
        LEA     -$2A(A6,D2.W),A1                ; $1033A0
        MOVE.W  $4F88(A3),#$7DD3                ; $1033A4
        ADD.B  -(A0),D7                         ; $1033AA
        MOVE.W  $8805.W,(A2)+                   ; $1033AC
        MOVE.W  D4,(A4)                         ; $1033B0
        MOVEQ   #-$79,D7                        ; $1033B2
        DC.W    $CDBE               ; $1033B4 AND.L  D6,<EA:3E>
        BVS.S  loc_1033A9                       ; $1033B6
        BCLR    D7,$7BC4(PC)                    ; $1033B8
        DC.W    $0E20               ; $1033BC DC.W    $0E20
        DC.W    $90FD               ; $1033BE SUBA.W  <EA:3D>,A0
        OR.B   $69(A5,A3.L),D4                  ; $1033C0
        MOVE.W  A7,-(A0)                        ; $1033C4
        CMP.W  $1E(PC,A4.W),D5                  ; $1033C6
        SUB.B  D7,(A7)+                         ; $1033CA
        MOVE.L  D1,D1                           ; $1033CC
        MOVE.B  A0,(A0)                         ; $1033CE
        DIVS    D4,D0                           ; $1033D0
        MOVE.B  (A7)+,D1                        ; $1033D2
        EOR.B  D0,D6                            ; $1033D4
        DC.W    $883D               ; $1033D6 OR.B   <EA:3D>,D4
        MOVE.W  -(A2),D7                        ; $1033D8
        BTST    D0,(A0)                         ; $1033DA
        DC.W    $887D               ; $1033DC OR.W   <EA:3D>,D4
        LEA     $70(A2,D2.W),A1                 ; $1033DE
        MOVE.W  D7,$28(A4,A5.L)                 ; $1033E2
        DIVS    -$2C(A4,A0.W),D0                ; $1033E6
        MOVE.W  -(A2),-(A7)                     ; $1033EA
        MOVE.B  A7,-(A3)                        ; $1033EC
        SUB.L  D6,D4                            ; $1033EE
        ADDQ.L  #1,A0                           ; $1033F0
        MOVE.B  A0,$7DD3(A7)                    ; $1033F2
        ADD.B  -(A0),D7                         ; $1033F6
        MOVE.W  $8865.W,(A2)+                   ; $1033F8
        MOVE.L  D1,(A4)                         ; $1033FC
        MOVE.W  A0,(A0)                         ; $1033FE
        BCS.S  loc_10342A                       ; $103400
        DIVS    -$2C(A4,A0.W),D0                ; $103402
        MOVE.W  -(A2),-(A7)                     ; $103406
        MOVE.B  A7,-(A3)                        ; $103408
        SUB.L  D6,D4                            ; $10340A
        ADDQ.L  #1,A0                           ; $10340C
        MOVE.B  A0,-$2D(A7,D7.L)                ; $10340E
        ADD.B  -(A0),D7                         ; $103412
        MOVE.W  $87D4.W,(A2)+                   ; $103414
        MOVE.W  -(A2),-(A7)                     ; $103418
        MOVE.B  A7,-(A3)                        ; $10341A
        DC.W    $987D               ; $10341C SUB.W  <EA:3D>,D4
        ADD.L  A0,D1                            ; $10341E
        MOVE.B  A0,$7D43(A7)                    ; $103420
        MOVE.W  -(A1),D1                        ; $103424
        MOVEQ   #-$07,D0                        ; $103426
        OR.W   -(A5),D4                         ; $103428
loc_10342A:
        MOVE.L  D1,(A4)                         ; $10342A
        MOVE.W  D7,(A2)                         ; $10342C
        DC.W    $DD3D               ; $10342E ADD.B  D6,<EA:3D>
        LSR.B  #1,D7                            ; $103430
        DC.W    $4F88               ; $103432 DC.W    $4F88
        OR.W   (A2),D3                          ; $103434
        OR.B   (A7)+,D4                         ; $103436
        BCLR    #8,D6                           ; $103438
        MOVE.B  A0,$7D43(A7)                    ; $10343C
        MOVE.W  -(A1),D1                        ; $103440
        MOVEQ   #-$07,D0                        ; $103442
        OR.W   -(A5),D4                         ; $103444
        MOVE.L  D1,(A4)                         ; $103446
        MOVE.W  D7,(A4)                         ; $103448
        DC.W    $DD3D               ; $10344A ADD.B  D6,<EA:3D>
        LSR.B  #1,D7                            ; $10344C
        DC.W    $4F88               ; $10344E DC.W    $4F88
loc_103450:
        MOVE.W  D3,-$0DDF(A6)                   ; $103450
        MOVEQ   #-$07,D0                        ; $103454
        DIVS    (A5)+,D3                        ; $103456
        MOVE.L  D1,(A4)                         ; $103458
        MOVE.W  D7,(A2)                         ; $10345A
        DC.W    $D43F               ; $10345C ADD.B  <EA:3F>,D2
        MOVE.L  (A7),D1                         ; $10345E
        BCLR    D7,(A0)+                        ; $103460
        OR.W   (A2),D3                          ; $103462
        OR.B   (A7)+,D4                         ; $103464
        DC.W    $487D               ; $103466 PEA     <EA:3D>
        ADDA.L  (A6)+,A1                        ; $103468
        MOVE.L  -$78(A4,A7.L),(A0)+             ; $10346A
        BCS.S  loc_103498                       ; $10346E
        DIVS    $65(A0,A0.L),D0                 ; $103470
        MOVE.L  D1,(A4)                         ; $103474
        MOVE.W  D7,(A2)                         ; $103476
        DC.W    $D43F               ; $103478 ADD.B  <EA:3F>,D2
        MOVE.L  (A7),D1                         ; $10347A
        BCLR    D7,(A0)+                        ; $10347C
        OR.W   (A2),D3                          ; $10347E
        OR.B   (A7)+,D4                         ; $103480
        DC.W    $887D               ; $103482 OR.W   <EA:3D>,D4
        ADDA.L  (A6)+,A1                        ; $103484
        MOVE.L  -$79(A4,A7.L),(A0)+             ; $103486
        DC.W    $D43F               ; $10348A ADD.B  <EA:3F>,D2
        MOVE.L  (A7),D1                         ; $10348C
        BCLR    D7,(A0)+                        ; $10348E
        DC.W    $7DD2               ; $103490 MOVE.W  (A2),<EA:3E>
        OR.B   (A7)+,D4                         ; $103492
        DC.W    $AB7C,$D3E2,$1F74,$F788; $103494 MOVE.L  #$D3E21F74,-$0878(A5)
        MOVEA.B D1,A6                           ; $10349C
        MOVE.L  $68(PC,D1.W),$83D3.W            ; $10349E
        ASR.B  D1,D0                            ; $1034A4
        MOVE.B  -(A2),(A2)+                     ; $1034A6
        MOVE.B  (A6),$1F31.W                    ; $1034A8
        DC.W    $0388               ; $1034AC BCLR    D1,A0
        DC.W    $243F               ; $1034AE MOVE.L  <EA:3F>,D2
        BHI.S  loc_1034BF                       ; $1034B0
        BLE.S  loc_103450                       ; $1034B2
        SUBQ.B  #3,A3                           ; $1034B4
        MOVE.W  -$6584(A7),$43EE(A4)            ; $1034B6
        SUBA.W  -$59(A1,D0.W),A7                ; $1034BC
        AND.W  D0,D2                            ; $1034C0
        MOVE.L  (A1),D1                         ; $1034C2
        MOVE.B  $8243.W,D0                      ; $1034C4
        MOVE.W  -(A0),D3                        ; $1034C8
        ADDA.W  $C570BF56,A3                    ; $1034CA
        MOVE.W  -(A7),$3E(A4,A4.W)              ; $1034D0
        ASL.W  $1038(A7)                        ; $1034D4
        OR.W   D3,D1                            ; $1034D8
        MOVE.W  -(A0),D3                        ; $1034DA
        ADD.B  D0,D7                            ; $1034DC
        MOVE.L  D4,$29(PC,D4.W)                 ; $1034DE
        AND.B  -(A3),D2                         ; $1034E2
        DC.W    $AC3E               ; $1034E4 MOVE.L  <EA:3E>,D6
        BHI.S  loc_1034EF                       ; $1034E6
        MOVEA.B A0,A0                           ; $1034E8
        MOVEQ   #-$3C,D7                        ; $1034EA
        MOVE.B  (A7)+,(A5)+                     ; $1034EC
        MOVE.W  $17F2(A6),(A4)                  ; $1034EE
        ADD.B  D7,-$79(A4,A7.L)                 ; $1034F2
        DC.W    $DD3D               ; $1034F6 ADD.B  D6,<EA:3D>
        LSR.B  #1,D7                            ; $1034F8
        DC.W    $4F88               ; $1034FA DC.W    $4F88
        OR.W   D4,D0                            ; $1034FC
        MOVE.L  -(A0),D1                        ; $1034FE
        MOVE.W  D4,-(A0)                        ; $103500
        DIVS    $41AD(A4),D3                    ; $103502
        MOVE.W  A2,$7E(A1,A6.W)                 ; $103506
        DC.W    $ADF3,$4F88         ; $10350A MOVE.L  -$78(A3,D4.L),<EA:3E>
        DC.W    $7DD3               ; $10350E MOVE.W  (A3),<EA:3E>
        ADD.B  -(A0),D7                         ; $103510
        MOVE.W  D4,-(A0)                        ; $103512
        DIVS    $41A2(A4),D3                    ; $103514
        DC.W    $0F4F               ; $103518 BCHG    D7,A7
        OR.L   D0,D4                            ; $10351A
        SUBQ.L  #1,A0                           ; $10351C
        DC.W    $4758               ; $10351E DC.W    $4758
        MOVEQ   #-$3C,D6                        ; $103520
        DC.W    $0E20               ; $103522 DC.W    $0E20
        DC.W    $90FD               ; $103524 SUBA.W  <EA:3D>,A0
        OR.B   $71(A5,A3.L),D4                  ; $103526
        ADDQ.B  #6,-$1A42(A7)                   ; $10352A
        BVS.S  loc_103521                       ; $10352E
        BCLR    D7,$7BC4(PC)                    ; $103530
        MOVE.B  (A7)+,(A7)                      ; $103534
        MOVE.B  D0,-(A0)                        ; $103536
        OR.W   D4,D4                            ; $103538
        NEGX   -(A2)                            ; $10353A
        DC.W    $090F               ; $10353C BTST    D4,A7
        ADD.L  D3,D4                            ; $10353E
        SMI     -(A7)                           ; $103540
        MOVE.B  D2,-$03A5(PC)                   ; $103542
        ROR.L  #3,D7                            ; $103546
        MOVE.B  -$44(PC,A2.W),(A0)+             ; $103548
        NEGX   -(A2)                            ; $10354C
        DC.W    $090F               ; $10354E BTST    D4,A7
        ADD.L  D3,D4                            ; $103550
        NEG.B  $40(A2,A1.W)                     ; $103552
        MOVEA.W D3,A5                           ; $103556
        ROR.B  #5,D7                            ; $103558
        SUB.B  D0,A3                            ; $10355A
        DIVS    A4,D3                           ; $10355C
        MOVE.W  $440F(A1),(A7)+                 ; $10355E
        OR.W   D3,D2                            ; $103562
        MOVE.L  D4,$0FA4(A4)                    ; $103564
        MOVE.W  -(A1),(A7)                      ; $103568
        MOVE.W  (A0),-(A4)                      ; $10356A
        CMP.W  #$C432,D4                        ; $10356C
        SUB.W  D0,D2                            ; $103570
        MOVEA.W D4,A4                           ; $103572
        MOVE.W  (A4),(A1)                       ; $103574
        NEGX   #$43EE                           ; $103576
        SUBA.W  -$59(A1,D0.W),A7                ; $10357A
        DC.W    $C43E               ; $10357E AND.B  <EA:3E>,D2
        DC.W    $A1F9,$10B8,$7CC4,$3294; $103580 MOVE.L  $10B87CC4,$3294.W
        NEGX   $4432.W                          ; $103588
        SUB.W  D0,D2                            ; $10358C
        MOVEA.W D3,A5                           ; $10358E
        ROR.B  #5,D7                            ; $103590
        SUB.B  D0,A3                            ; $103592
        DIVS    A4,D3                           ; $103594
        MOVE.W  $440F(A1),(A7)+                 ; $103596
        OR.W   D3,D2                            ; $10359A
        MOVE.L  D4,$0FA4(A4)                    ; $10359C
        MOVE.W  -(A1),(A7)                      ; $1035A0
        MOVE.W  (A0),-(A4)                      ; $1035A2
        CMP.W  #$C432,D4                        ; $1035A4
        SUB.W  D0,D2                            ; $1035A8
        MOVEA.W D4,A4                           ; $1035AA
        MOVE.W  (A4),(A1)                       ; $1035AC
        NEGX   #$43EE                           ; $1035AE
        SUBA.W  -$59(A1,D0.W),A7                ; $1035B2
        DC.W    $C43E               ; $1035B6 AND.B  <EA:3E>,D2
        DC.W    $A1F9,$10B8,$7CC4,$3294; $1035B8 MOVE.L  $10B87CC4,$3294.W
        NEGX   $4432.W                          ; $1035C0
        SUB.W  D0,D2                            ; $1035C4
        MOVEA.W D3,A5                           ; $1035C6
        ROR.B  #5,D7                            ; $1035C8
        SUB.B  D0,A3                            ; $1035CA
        DIVS    A4,D3                           ; $1035CC
        MOVE.W  $440F(A1),(A7)+                 ; $1035CE
        OR.W   D3,D2                            ; $1035D2
        MOVE.L  D4,$0FA4(A4)                    ; $1035D4
        MOVE.W  -(A1),(A7)                      ; $1035D8
        MOVE.W  (A0),-(A4)                      ; $1035DA
        CMP.W  #$C432,D4                        ; $1035DC
        SUB.W  D0,D2                            ; $1035E0
        MOVEA.W D4,A4                           ; $1035E2
        MOVE.W  (A4),(A1)                       ; $1035E4
        NEGX   #$43EE                           ; $1035E6
        SUBA.W  -$59(A1,D0.W),A7                ; $1035EA
        DC.W    $C43E               ; $1035EE AND.B  <EA:3E>,D2
        DC.W    $A1F9,$10B8,$7CC4,$3294; $1035F0 MOVE.L  $10B87CC4,$3294.W
        NEGX   $4432.W                          ; $1035F8
        SUB.W  D0,D2                            ; $1035FC
        MOVE.W  D3,-$15E1(A5)                   ; $1035FE
        SUB.B  D0,A3                            ; $103602
        DIVS    A4,D3                           ; $103604
        LEA     -$0EF0(A1),A0                   ; $103606
        EORI.W  #$08F1,(A1)                     ; $10360A
        MOVEA.B $7C43(PC),A0                    ; $10360E
        ROR.B  #5,D7                            ; $103612
        DC.W    $90FD               ; $103614 SUBA.W  <EA:3D>,A0
        OR.B   -$17(A4,D4.W),D4                 ; $103616
        MOVE.W  (A0),-(A0)                      ; $10361A
        EORI.W  #$08FD,(A1)                     ; $10361C
        MOVEA.B $7C44(PC),A0                    ; $103620
        MOVE.B  (A7)+,(A7)                      ; $103624
        MOVE.B  D0,-(A0)                        ; $103626
        OR.W   D4,D4                            ; $103628
        LEA     -$0EF0(A1),A0                   ; $10362A
        BCLR    #10,D4                          ; $10362E
        MOVE.B  (A0),-$78(A7,A7.L)              ; $103632
        MOVEA.W D2,A2                           ; $103636
        MOVEQ   #-$3C,D6                        ; $103638
        MOVE.L  -(A0),D5                        ; $10363A
        MOVE.W  $883D.W,(A2)+                   ; $10363C
        MOVE.W  -(A2),D7                        ; $103640
        BTST    D0,(A0)                         ; $103642
        OR.L   D3,D4                            ; $103644
        ADDA.L  -(A2),A1                        ; $103646
        MOVE.L  (A4),D0                         ; $103648
        MOVE.L  (A1),D1                         ; $10364A
        ASR.B  D1,D0                            ; $10364C
        MOVE.W  $87D4.W,(A2)+                   ; $10364E
        MOVE.W  -(A1),-(A7)                     ; $103652
        MOVE.W  (A0),-(A5)                      ; $103654
        BVC.S  loc_1035DB                       ; $103656
        ADDA.L  -(A2),A1                        ; $103658
        MOVE.L  (A4),D0                         ; $10365A
        MOVE.L  (A1),D1                         ; $10365C
        MOVE.W  -(A0),D5                        ; $10365E
        MOVE.W  $883D.W,(A2)+                   ; $103660
        MOVE.W  -(A2),D7                        ; $103664
        BTST    D0,(A0)                         ; $103666
        OR.L   D3,D4                            ; $103668
        ADDA.L  -(A2),A1                        ; $10366A
        MOVE.L  (A1),D0                         ; $10366C
        BCLR    #31,D7                          ; $10366E
        MOVE.L  $68(PC,D1.W),$84F9.W            ; $103672
        OR.W   (A4),D4                          ; $103678
        LEA     -$0EF0(A1),A0                   ; $10367A
        MOVEQ   #$7C,D5                         ; $10367E
        NEG.B  D2                               ; $103680
        MOVE.L  (A1),-(A0)                      ; $103682
        BCLR    D3,-(A7)                        ; $103684
        AND.W  D0,D2                            ; $103686
        MOVE.L  D4,$23C4(A4)                    ; $103688
        LEA     -$0EF1(A1),A0                   ; $10368C
        DC.W    $A87E               ; $103690 MOVEA.L <EA:3E>,A4
        LEA     -$2F(A6,D2.W),A1                ; $103692
        BCLR    D3,-(A7)                        ; $103696
        AND.W  D0,D2                            ; $103698
        MOVE.L  D4,$23F4(A4)                    ; $10369A
        LEA     -$0EF0(A1),A0                   ; $10369E
        MOVEQ   #$7C,D5                         ; $1036A2
        NEG.B  D2                               ; $1036A4
        MOVE.L  (A1),-(A0)                      ; $1036A6
        BCLR    D3,-(A7)                        ; $1036A8
        AND.W  D0,D2                            ; $1036AA
        MOVE.L  (A1),D1                         ; $1036AC
        BCLR    D7,$7E43(A0)                    ; $1036AE
        MOVE.W  -(A0),D3                        ; $1036B2
        ADD.B  D0,A1                            ; $1036B4
        MOVE.W  (A0),-(A1)                      ; $1036B6
        MOVE.L  D3,(A4)                         ; $1036B8
        ADDA.L  -(A2),A1                        ; $1036BA
        MOVE.L  -$78(A4,A7.L),(A0)+             ; $1036BC
        SUBI.W  #$220F,D2                       ; $1036C0
        DC.W    $4F88               ; $1036C4 DC.W    $4F88
        OR.W   (A2),D0                          ; $1036C6
        OR.W   D7,D4                            ; $1036C8
        SUB.L  D3,D4                            ; $1036CA
        ADDA.L  -(A2),A1                        ; $1036CC
        MOVE.B  -$78(A4,A7.W),$3D3E(A7)         ; $1036CE
        MOVE.L  (A1)+,D1                        ; $1036D4
        MOVE.B  $7DC4.W,D0                      ; $1036D6
        DC.W    $0E94               ; $1036DA DC.W    $0E94
        CLR.W  $C3E6.W                          ; $1036DC
        MOVE.B  $07(A4,A2.W),-$0DDF(A7)         ; $1036E0
        SUB.B  D0,D3                            ; $1036E6
        DIVS    (A4)+,D3                        ; $1036E8
        NEGX   -(A1)                            ; $1036EA
        MOVE.W  A7,$7883(A3)                    ; $1036EC
        ADDA.L  -(A2),A1                        ; $1036F0
        MOVE.B  -$78(A4,A7.W),$3D3E(A7)         ; $1036F2
        DC.W    $2DF3,$8AE1         ; $1036F8 MOVE.L  -$1F(A3,A0.L),<EA:3E>
        MOVE.W  -(A2),$10(A7,D1.L)              ; $1036FC
        DC.W    $387D               ; $103700 MOVEA.W <EA:3D>,A4
        AND.B  A6,D2                            ; $103702
        MOVE.B  -$78(A4,A7.W),$3D3E(A7)         ; $103704
        MOVE.L  $78(A7,D4.L),$83D3.W            ; $10370A
        ASR.B  D1,D1                            ; $103710
        SUB.B  D0,D3                            ; $103712
        DIVS    (A7)+,D3                        ; $103714
        BCLR    #8,D1                           ; $103716
        DC.W    $4F18               ; $10371A DC.W    $4F18
        MOVEQ   #-$3D,D6                        ; $10371C
        ROXR.L  #7,D4                           ; $10371E
        DC.W    $40FE               ; $103720 NEGX   <EA:3E>
        NEG.B  $70(A2,D2.W)                     ; $103722
        MOVE.W  A0,$3E(A5,D1.L)                 ; $103726
        ASL.W  $107A(A7)                        ; $10372A
        MOVEQ   #$43,D6                         ; $10372E
        ROR.L  #7,D6                            ; $103730
        MOVE.W  D7,-(A0)                        ; $103732
        MOVE.L  D5,$71(PC,A3.L)                 ; $103734
        ADDQ.B  #6,-$0BBD(A7)                   ; $103738
        MOVE.L  D7,D1                           ; $10373C
        BCLR    D7,$81C3.W                      ; $10373E
        ROR.L  #7,D6                            ; $103742
        MOVE.W  D7,-(A0)                        ; $103744
        MOVE.L  D4,-$17(PC,D3.L)                ; $103746
        ROXL.B  #7,D0                           ; $10374A
        MOVEQ   #$7C,D5                         ; $10374C
        NEG.B  $70(A2,D2.W)                     ; $10374E
        DC.W    $FBE1               ; $103752 MOVE.W  -(A1),<EA:3D>
        MOVE.B  $5109(PC),D0                    ; $103754
        LSL.B  #1,D7                            ; $103758
        DC.W    $987D               ; $10375A SUB.W  <EA:3D>,D4
        ADD.L  A0,D1                            ; $10375C
        DC.W    $1FC8               ; $10375E MOVE.B  A0,<EA:3F>
        OR.W   D4,D3                            ; $103760
        DC.W    $0E1F               ; $103762 DC.W    $0E1F
        MOVE.W  D3,-(A0)                        ; $103764
        DIVS    (A5)+,D3                        ; $103766
        DC.W    $3DE2               ; $103768 MOVE.W  -(A2),<EA:3E>
        DC.W    $0F4F               ; $10376A BCHG    D7,A7
        DC.W    $887D               ; $10376C OR.W   <EA:3D>,D4
        ADDA.L  (A6)+,A1                        ; $10376E
        MOVE.L  -$49(A4,A7.L),(A0)+             ; $103770
        AND.B  -$7A02(A3),D7                    ; $103774
        OR.W   -(A4),D4                         ; $103778
        NEGX   -(A1)                            ; $10377A
        MOVE.W  (A0),-(A3)                      ; $10377C
        DC.W    $387D               ; $10377E MOVEA.W <EA:3D>,A4
        ADDA.L  (A6)+,A1                        ; $103780
        MOVE.L  -$79(A4,A7.L),(A0)+             ; $103782
        DC.W    $DD3D               ; $103786 ADD.B  D6,<EA:3D>
        LSR.B  #1,D7                            ; $103788
        DC.W    $4F88               ; $10378A DC.W    $4F88
        OR.W   D4,D3                            ; $10378C
        DC.W    $0E1F               ; $10378E DC.W    $0E1F
        MOVEQ   #$62,D4                         ; $103790
        DC.W    $074A               ; $103792 BCHG    D3,A2
        MOVEA.L -$01(A4,D6.W),A0                ; $103794
        AND.B  (A7)+,D5                         ; $103798
        SUB.B  D0,D1                            ; $10379A
        DIVS    (A5),D3                         ; $10379C
        DC.W    $487E               ; $10379E PEA     <EA:3E>
        MOVEQ   #-$79,D0                        ; $1037A0
        LSL.W  #2,D0                            ; $1037A2
        DIVU    (A1),D0                         ; $1037A4
        DC.W    $87FF               ; $1037A6 DIVS    <EA:3F>,D3
        DC.W    $287E               ; $1037A8 MOVEA.L <EA:3E>,A4
        NEG.B  D6                               ; $1037AA
        MOVE.B  (A4),-$5E07(A7)                 ; $1037AC
        AND.B  (A7)+,D1                         ; $1037B0
        SUBQ.B  #2,-(A1)                        ; $1037B2
        MOVE.W  A2,#$1F91                       ; $1037B4
        BCLR    D0,D7                           ; $1037B8
        ADD.B  D2,$7E53(A0)                     ; $1037BA
        OR.B   (A5),D4                          ; $1037BE
        DC.W    $187F               ; $1037C0 MOVEA.B <EA:3F>,A4
        MOVE.W  D7,(A1)                         ; $1037C2
        ASR.W  #2,D0                            ; $1037C4
        BSR.S  loc_1037BD                       ; $1037C6
        ADDQ.B  #1,(A7)+                        ; $1037C8
        SUB.B  -(A1),D6                         ; $1037CA
        MOVE.W  (A2),$2034(A4)                  ; $1037CC
        BSR.L  $CA2FC8D3                        ; $1037D0
        DIVS    (A5),D3                         ; $1037D6
        DC.W    $287E               ; $1037D8 MOVEA.L <EA:3E>,A4
        MOVEQ   #-$79,D0                        ; $1037DA
        ADD.W  D2,A0                            ; $1037DC
        MOVEQ   #$72,D7                         ; $1037DE
        DIVS    -(A4),D3                        ; $1037E0
        NEGX.W -(A1)                            ; $1037E2
        MOVE.W  A2,$1F94(A2)                    ; $1037E4
        ASR.B  #1,D5                            ; $1037E8
        NOT.B  (A7)+                            ; $1037EA
        MOVE.W  -(A1),(A6)                      ; $1037EC
        MOVE.W  (A0),-(A4)                      ; $1037EE
        DC.W    $187D               ; $1037F0 MOVEA.B <EA:3D>,A4
        ADDQ.L  #2,D7                           ; $1037F2
        LSL.B  #3,D0                            ; $1037F4
        MOVEQ   #$54,D7                         ; $1037F6
        OR.B   A5,D4                            ; $1037F8
        DC.W    $187F               ; $1037FA MOVEA.B <EA:3F>,A4
        MOVE.W  D7,(A1)                         ; $1037FC
        ASR.W  #2,D0                            ; $1037FE
        BSR.S  loc_1037F7                       ; $103800
        TST.B  (A7)+                            ; $103802
        SUB.B  -(A1),D6                         ; $103804
        MOVE.W  (A2),$1F9C(A2)                  ; $103806
        DC.W    $A1F9,$1018,$7D52,$87E5; $10380A MOVE.L  $10187D52,$87E5.W
        MOVE.W  D1,(A4)                         ; $103812
        SUBQ.L  #8,D7                           ; $103814
        DC.W    $FFE8,$7E44         ; $103816 MOVE.W  $7E44(A0),<EA:3F>
        ADDI.B  #$F4F8,-(A0)                    ; $10381A
        OR.B   D4,D4                            ; $10381E
        CLR.B  -(A2)                            ; $103820
loc_103822:
        BTST    D3,(A0)                         ; $103822
        DC.W    $487E               ; $103824 PEA     <EA:3E>
        AND.B  (A2)+,D2                         ; $103826
        ADD.B  D7,-$79(A4,A7.L)                 ; $103828
        DC.W    $DD3D               ; $10382C ADD.B  D6,<EA:3D>
        ASR.B  #1,D7                            ; $10382E
        ASR.B  D7,D0                            ; $103830
loc_103832:
        DC.W    $90FD               ; $103832 SUBA.W  <EA:3D>,A0
        OR.B   -$17(A4,D4.W),D4                 ; $103834
        MOVE.W  (A0),-(A0)                      ; $103838
        BCLR    #14,D4                          ; $10383A
        MOVE.L  (A0),(A0)                       ; $10383E
        MOVE.W  A0,-$42(A6,D3.W)                ; $103840
        MOVE.W  (A4)+,$2FF5(A0)                 ; $103844
        CMP.W  -$0EF1(A1),D7                    ; $103848
        CMP.W  $0E(PC,A4.W),D5                  ; $10384C
        MOVE.L  (A0),(A0)                       ; $103850
        MOVE.W  A0,-$42(A6,D3.W)                ; $103852
        BVS.S  loc_103849                       ; $103856
        BCLR    D7,$7BC4(PC)                    ; $103858
        MOVE.B  (A7)+,(A7)                      ; $10385C
        MOVE.B  D0,-(A0)                        ; $10385E
        MOVE.W  (A0),-(A6)                      ; $103860
        OR.L   D1,D4                            ; $103862
        AND.B  (A2),D2                          ; $103864
        MOVE.B  -$49(A1,D0.W),$3E(A7,A4.L)      ; $103866
        MOVE.L  $78(A7,D4.L),$81C4.W            ; $10386C
        MOVE.B  (A7)+,D1                        ; $103872
        EOR.B  D0,D6                            ; $103874
        DC.W    $883D               ; $103876 OR.B   <EA:3D>,D4
        MOVE.W  $02(PC,D4.W),D7                 ; $103878
        MOVE.L  (A1),-(A0)                      ; $10387C
        DC.W    $0388               ; $10387E BCLR    D1,A0
        DC.W    $243F               ; $103880 MOVE.L  <EA:3F>,D2
        BHI.S  loc_103891                       ; $103882
        BLE.S  loc_103822                       ; $103884
        SUBQ.B  #3,A3                           ; $103886
        MOVE.W  -$6584(A7),$43EE(A6)            ; $103888
        SUBA.W  -$78(A1,D0.W),A7                ; $10388E
        DC.W    $243F               ; $103892 MOVE.L  <EA:3F>,D2
        BHI.S  loc_1038A3                       ; $103894
        BLE.S  loc_103832                       ; $103896
        MOVEQ   #$43,D6                         ; $103898
        ROR.L  #7,D6                            ; $10389A
        MOVE.W  D7,-(A0)                        ; $10389C
        MOVE.L  D4,$3F(PC,D4.W)                 ; $10389E
        NEG.B  -(A2)                            ; $1038A2
        MOVEA.L -$79(A1,D0.W),A0                ; $1038A4
        ASR.W  #6,D1                            ; $1038A8
        DC.W    $ADF3,$4F88         ; $1038AA MOVE.L  -$78(A3,D4.L),<EA:3E>
        DC.W    $7DD3               ; $1038AE MOVE.W  (A3),<EA:3E>
        ADD.B  -(A0),D7                         ; $1038B0
        MOVE.W  D4,-(A0)                        ; $1038B2
        DIVS    $41A2(A4),D3                    ; $1038B4
        DC.W    $0F4F               ; $1038B8 BCHG    D7,A7
        DIVU    (A1),D7                         ; $1038BA
        ORI.L  #$4440E209,A0                    ; $1038BC
        BSET    D7,(A0)+                        ; $1038C2
        OR.W   D1,(A3)+                         ; $1038C4
        ROXL.B  #3,D5                           ; $1038C6
        DC.W    $C2FF               ; $1038C8 MULU    <EA:3F>,D1
        SMI     -(A6)                           ; $1038CA
        SUB.B  D7,(A0)                          ; $1038CC
        MOVE.W  -(A7),$40(A5,A3.L)              ; $1038CE
        LSR.B  #1,D1                            ; $1038D2
        BSET    D7,(A0)+                        ; $1038D4
        OR.W   D1,(A3)+                         ; $1038D6
        ROR.L  #3,D7                            ; $1038D8
        MOVE.B  -$44(PC,A2.W),(A0)+             ; $1038DA
        LEA     -$0EF0(A1),A0                   ; $1038DE
        BCLR    D7,-$78(A1,D0.L)                ; $1038E2
        MOVEA.B D1,A6                           ; $1038E6
        MOVE.L  $68(PC,D1.W),$7DD3.W            ; $1038E8
        ADD.B  -(A0),D7                         ; $1038EE
        MOVE.W  $87D4.W,(A2)+                   ; $1038F0
        MOVE.W  -(A2),-(A7)                     ; $1038F4
        MOVE.B  A7,-(A3)                        ; $1038F6
        SUB.L  D6,D4                            ; $1038F8
        ADDQ.L  #1,A0                           ; $1038FA
        MOVE.B  A0,$7D43(A7)                    ; $1038FC
        MOVE.W  -(A1),D1                        ; $103900
        MOVEQ   #-$07,D0                        ; $103902
        DIVS    (A5)+,D3                        ; $103904
        MOVE.L  D1,(A4)                         ; $103906
        MOVE.W  D7,(A2)                         ; $103908
        DC.W    $D43F               ; $10390A ADD.B  <EA:3F>,D2
        MOVE.L  (A7),D1                         ; $10390C
        BCLR    D7,(A0)+                        ; $10390E
        OR.W   (A2),D3                          ; $103910
        OR.B   (A7)+,D4                         ; $103912
        BCLR    #8,D6                           ; $103914
        MOVE.B  A0,$7D43(A7)                    ; $103918
        MOVE.W  -(A1),D1                        ; $10391C
        MOVEQ   #-$07,D0                        ; $10391E
        OR.W   -(A5),D4                         ; $103920
        MOVE.L  D1,(A4)                         ; $103922
        MOVE.W  D7,(A4)                         ; $103924
        DC.W    $DD3D               ; $103926 ADD.B  D6,<EA:3D>
        LSR.B  #1,D7                            ; $103928
        DC.W    $4F88               ; $10392A DC.W    $4F88
        MOVE.W  D3,-$0DDF(A6)                   ; $10392C
        MOVEQ   #-$07,D0                        ; $103930
        OR.W   -(A5),D4                         ; $103932
        MOVE.L  D1,(A4)                         ; $103934
        MOVE.W  D7,(A2)                         ; $103936
        DC.W    $D43F               ; $103938 ADD.B  <EA:3F>,D2
        MOVE.L  (A7),D1                         ; $10393A
        BCLR    D7,(A0)+                        ; $10393C
        DC.W    $7DD2               ; $10393E MOVE.W  (A2),<EA:3E>
        OR.B   (A7)+,D4                         ; $103940
        DC.W    $487D               ; $103942 PEA     <EA:3D>
        LEA     $70(A2,D2.W),A1                 ; $103944
        MOVE.W  A0,$28(A4,D6.W)                 ; $103948
        DIVS    $65(A0,A0.L),D0                 ; $10394C
        MOVE.L  D1,(A4)                         ; $103950
        MOVE.W  D7,(A2)                         ; $103952
        DC.W    $D43F               ; $103954 ADD.B  <EA:3F>,D2
        MOVE.L  (A7),D1                         ; $103956
        BCLR    D7,(A0)+                        ; $103958
        OR.W   (A2),D3                          ; $10395A
        OR.B   (A7)+,D4                         ; $10395C
        DC.W    $887D               ; $10395E OR.W   <EA:3D>,D4
        ADDA.L  (A6)+,A1                        ; $103960
        MOVE.L  -$79(A4,A7.L),(A0)+             ; $103962
        DC.W    $D43F               ; $103966 ADD.B  <EA:3F>,D2
        MOVE.L  (A7),D1                         ; $103968
        BCLR    D7,(A0)+                        ; $10396A
        OR.W   (A2),D3                          ; $10396C
        OR.B   (A7)+,D4                         ; $10396E
        DC.W    $487D               ; $103970 PEA     <EA:3D>
        LEA     $70(A2,D2.W),A1                 ; $103972
        MOVE.W  D7,$28(A4,A5.L)                 ; $103976
        DIVS    -$2C(A4,A0.W),D0                ; $10397A
        MOVE.W  -(A2),-(A7)                     ; $10397E
        MOVE.B  A7,-(A3)                        ; $103980
        SUB.L  D6,D4                            ; $103982
        ADDQ.L  #1,A0                           ; $103984
        MOVE.B  A0,-(A7)                        ; $103986
        OR.W   (A2),D3                          ; $103988
        OR.B   (A7)+,D4                         ; $10398A
        DC.W    $487D               ; $10398C PEA     <EA:3D>
        LEA     $70(A2,D2.W),A1                 ; $10398E
        MOVE.W  A0,$28(A4,D6.W)                 ; $103992
        DC.W    $81FE               ; $103996 DIVS    <EA:3E>,D0
        DIVS    (A5)+,D3                        ; $103998
        DC.W    $3DE2               ; $10399A MOVE.W  -(A2),<EA:3E>
        DC.W    $0F4F               ; $10399C BCHG    D7,A7
        DC.W    $887D               ; $10399E OR.W   <EA:3D>,D4
        LEA     $70(A2,D2.W),A1                 ; $1039A0
        MOVE.W  D7,$3F(A4,A5.W)                 ; $1039A4
        MOVE.L  $68(PC,D1.W),$84C4.W            ; $1039A8
        MOVE.L  -(A0),D5                        ; $1039AE
        MOVE.W  -$0EF0(A1),(A6)+                ; $1039B0
        MOVEQ   #$7C,D5                         ; $1039B4
        NEG.B  D2                               ; $1039B6
        SUB.W  D2,D2                            ; $1039B8
        MOVE.W  D4,$1E9F(A7)                    ; $1039BA
        MOVE.B  -$781C(PC),(A0)+                ; $1039BE
        MOVE.W  -(A2),$0D10(A7)                 ; $1039C2
        SUB.L  D5,D4                            ; $1039C6
        NEG.B  (A6)+                            ; $1039C8
        SUB.B  D7,(A1)                          ; $1039CA
        BCLR    D3,-(A7)                        ; $1039CC
        AND.W  D0,D2                            ; $1039CE
        MOVE.L  (A1),D1                         ; $1039D0
        DC.W    $107E               ; $1039D2 MOVEA.B <EA:3E>,A0
        MOVE.W  $8805.W,(A2)+                   ; $1039D4
        MOVE.L  D4,(A4)                         ; $1039D8
        MOVEQ   #-$78,D7                        ; $1039DA
        DC.W    $3D3E               ; $1039DC MOVE.W  <EA:3E>,-(A6)
        MOVE.L  A7,D1                           ; $1039DE
        DC.W    $4F88               ; $1039E0 DC.W    $4F88
        OR.W   D4,D0                            ; $1039E2
        MOVE.L  (A7)+,D1                        ; $1039E4
        ST      #$87EC                          ; $1039E6
        DC.W    $41A2               ; $1039EA DC.W    $41A2
        MOVE.B  (A0),-(A1)                      ; $1039EC
        MOVE.L  D3,(A4)                         ; $1039EE
        ADDA.L  -(A2),A1                        ; $1039F0
        MOVE.L  #$69F1100A,(A0)+                ; $1039F2
        SUBQ.B  #8,A0                           ; $1039F8
        MOVE.W  (A0),-(A6)                      ; $1039FA
        MOVEQ   #$7C,D5                         ; $1039FC
        LEA     $1F90(A2),A1                    ; $1039FE
        MOVE.W  A0,$42(A6,D3.W)                 ; $103A02
        BHI.S  loc_103A1D                       ; $103A06
        MOVEA.B $7C44(PC),A0                    ; $103A08
        MOVE.B  (A7)+,(A7)                      ; $103A0C
        MOVE.B  D0,-(A0)                        ; $103A0E
        OR.W   D4,D4                            ; $103A10
        LEA     $D3E2.W,A0                      ; $103A12
        MOVE.L  (A4),D0                         ; $103A16
        MOVE.L  (A1),D1                         ; $103A18
        MOVE.W  -(A0),D5                        ; $103A1A
        MOVE.W  $883D.W,(A2)+                   ; $103A1C
        MOVE.W  -(A2),D7                        ; $103A20
        BTST    D0,(A0)                         ; $103A22
        DC.W    $887D               ; $103A24 OR.W   <EA:3D>,D4
        LEA     -$4F(A2,D1.L),A1                ; $103A26
        ADDI.L  #$4C42A20F,A0                   ; $103A2A
        DC.W    $4F88               ; $103A30 DC.W    $4F88
        DIVS    -$3C(A1,A2.W),D1                ; $103A32
        NEGX.B $4423(A1)                        ; $103A36
        MOVEA.W D1,A2                           ; $103A3A
        ASL.W  -$58(A1,D0.L)                    ; $103A3C
        MOVEQ   #$43,D7                         ; $103A40
        MOVE.W  -(A0),D3                        ; $103A42
        ADD.B  D0,A1                            ; $103A44
        OR.W   (A4),D4                          ; $103A46
        LEA     -$0EF0(A1),A0                   ; $103A48
        MOVEQ   #$7C,D5                         ; $103A4C
        NEG.B  D2                               ; $103A4E
        MOVE.L  (A1),-(A0)                      ; $103A50
        BSET    D3,-(A3)                        ; $103A52
        DC.W    $4F88               ; $103A54 DC.W    $4F88
        OR.W   (A2),D0                          ; $103A56
        OR.W   D7,D4                            ; $103A58
        ADD.L  D3,D4                            ; $103A5A
        ADDA.L  -(A2),A1                        ; $103A5C
        MOVE.L  -$78(A4,A7.L),(A0)+             ; $103A5E
        SUBI.W  #$21F5,D2                       ; $103A62
        DC.W    $0FC8               ; $103A66 BSET    D7,A0
        MOVEQ   #-$3C,D7                        ; $103A68
        MOVE.B  -(A1),D5                        ; $103A6A
        MOVE.W  A2,-(A0)                        ; $103A6C
        DC.W    $883D               ; $103A6E OR.B   <EA:3D>,D4
        DC.W    $3E3F               ; $103A70 MOVE.W  <EA:3F>,D7
        OR.B   D0,D0                            ; $103A72
        BTST    D2,D0                           ; $103A74
        DC.W    $0000,$0000         ; $103A76 ORI.B  #$0000,D0
        BSET    D0,$7D(A7,A5.L)                 ; $103A7A
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $103A7E
        DC.W    $DF7D               ; $103A82 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,$00(PC,D7.L)              ; $103A84
        MOVE.L  A0,D0                           ; $103A88
        MOVEA.L D2,A6                           ; $103A8A
        DC.W    $0201,$4040         ; $103A8C ANDI.B  #$4040,D1
        MOVEA.B D2,A7                           ; $103A90
        BCHG    D0,D0                           ; $103A92
        OR.W   D0,D0                            ; $103A94
        MOVE.B  A5,D0                           ; $103A96
        MOVE.W  (A7)+,-$52(PC,D7.L)             ; $103A98
        DC.W    $4B7A               ; $103A9C DC.W    $4B7A
        OR.W   D0,D0                            ; $103A9E
        BTST    #14,D2                          ; $103AA0
        OR.W   D0,D3                            ; $103AA4
        OR.B   -(A7),D3                         ; $103AA6
        DC.W    $DF7D               ; $103AA8 ADD.W  D7,<EA:3D>
        MOVEQ   #$1F,D0                         ; $103AAA
        DC.W    $7DF5,$7F1A         ; $103AAC MOVE.W  $1A(A5,D7.L),<EA:3E>
        OR.B   D5,D2                            ; $103AB0
        MOVE.B  (A0),D3                         ; $103AB2
        MOVE.B  D2,-(A6)                        ; $103AB4
        ADDQ.W  #6,-(A0)                        ; $103AB6
        DC.W    $0E8A               ; $103AB8 DC.W    $0E8A
        MOVEA.B $27DF(A1),A2                    ; $103ABA
        DC.W    $7DF7,$3F48         ; $103ABE MOVE.W  $48(A7,D3.L),<EA:3E>
        SUBQ.L  #1,-(A0)                        ; $103AC2
        ANDI.L  #$0C405314,D7                   ; $103AC4
        MOVEA.W D2,A7                           ; $103ACA
        SUB.L  D0,D1                            ; $103ACC
        DC.W    $7DF7,$DF7D         ; $103ACE MOVE.W  $7D(A7,A5.L),<EA:3E>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $103AD2
        DC.W    $DF7D               ; $103AD6 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$0B(PC,D7.L)             ; $103AD8
        MOVE.W  D0,$00(A7,D0.W)                 ; $103ADC
        DC.W    $0000,$0000         ; $103AE0 ORI.B  #$0000,D0
        BSET    D0,$7D(A7,A5.L)                 ; $103AE4
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $103AE8
        DC.W    $DF7D               ; $103AEC ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $103AEE
        DC.W    $DF7D               ; $103AF2 ADD.W  D7,<EA:3D>
        ORI.L  #$082C4202,-(A0)                 ; $103AF4
        BCHG    D0,D0                           ; $103AFA
        NEGX.B (A6)+                            ; $103AFC
        CLR.B  D1                               ; $103AFE
        NEGX.L D0                               ; $103B00
        NEGX.B (A0)                             ; $103B02
        BSET    D6,$7D(A7,A5.L)                 ; $103B04
        OR.B   D6,D4                            ; $103B08
        DC.W    $03C9               ; $103B0A BSET    D1,A1
        BTST    D0,(A5)                         ; $103B0C
        OR.B   D7,D2                            ; $103B0E
        NEGX.L (A6)                             ; $103B10
        BCHG    D3,(A0)+                        ; $103B12
        BCHG    D0,D2                           ; $103B14
        SUB.W  D0,D2                            ; $103B16
        DC.W    $7DF7,$DF73         ; $103B18 MOVE.W  $73(A7,A5.L),<EA:3E>
        DIVU    D4,D6                           ; $103B1C
        BSET    D3,-$7FD8(A0)                   ; $103B1E
        MOVEQ   #-$3C,D0                        ; $103B22
        BTST    D2,$14(A1,D4.L)                 ; $103B24
        ADD.B  D3,D2                            ; $103B28
        ROL.L  D7,D6                            ; $103B2A
        DC.W    $FBEF,$BEFB         ; $103B2C MOVE.W  -$4105(A7),<EA:3D>
        ROL.L  D7,D6                            ; $103B30
        DC.W    $FBEF,$BEFB         ; $103B32 MOVE.W  -$4105(A7),<EA:3D>
        ROL.L  D7,D6                            ; $103B36
        DC.W    $FBEF,$ABFC         ; $103B38 MOVE.W  -$5404(A7),<EA:3D>
        BTST    D2,D0                           ; $103B3C
        DC.W    $0000,$0000         ; $103B3E ORI.B  #$0000,D0
        BSET    D0,$7D(A7,A5.L)                 ; $103B42
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $103B46
        DC.W    $DF7D               ; $103B4A ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,-$09(PC,D7.L)             ; $103B4C
        DC.W    $DF7D               ; $103B50 ADD.W  D7,<EA:3D>
        MOVE.W  (A7)+,$00(PC,D7.L)              ; $103B52
        MOVE.L  A0,D0                           ; $103B56
        MOVEA.L D2,A6                           ; $103B58
        DC.W    $0201,$4040         ; $103B5A ANDI.B  #$4040,D1
        MOVEA.B D2,A7                           ; $103B5E
        BCHG    D0,D0                           ; $103B60
        OR.W   D0,D0                            ; $103B62
        MOVE.B  A5,D0                           ; $103B64
        MOVE.W  (A7)+,-$72(PC,D7.L)             ; $103B66
        DC.W    $4B7A               ; $103B6A DC.W    $4B7A
        OR.W   D0,D0                            ; $103B6C
        BCHG    D7,-(A2)                        ; $103B6E
        ADDQ.L  #4,(A4)                         ; $103B70
        ASL.B  #2,D1                            ; $103B72
        DC.W    $4C53               ; $103B74 DC.W    $4C53
        AND.B  D4,D2                            ; $103B76
        BTST    D2,D0                           ; $103B78
        DC.W    $FBEF,$BEFB         ; $103B7A MOVE.W  -$4105(A7),<EA:3D>
        ROL.L  D7,D6                            ; $103B7E
        DC.W    $FBEF,$BEFB         ; $103B80 MOVE.W  -$4105(A7),<EA:3D>
        ROL.L  D7,D6                            ; $103B84
        DC.W    $FBEF,$BEFB         ; $103B86 MOVE.W  -$4105(A7),<EA:3D>
loc_103B8A:
        ROL.L  D7,D6                            ; $103B8A
        MOVE.L  $31(A0,A0.L),-$01(PC,A7.L)      ; $103B8C
        MOVE.W  -$0904(A1),D4                   ; $103B92
        BVC.S  loc_103B94                       ; $103B96
        OR.L   D4,D6                            ; $103B98
        ASL.W  -$03(A5,A1.L)                    ; $103B9A
        OR.L   D4,-$0D66(A3)                    ; $103B9E
        DC.W    $BBFF               ; $103BA2 CMPA.L  <EA:3F>,A5
        MOVE.B  $9999.W,(A0)+                   ; $103BA4
        CMP.W  -$6655(A0),D6                    ; $103BA8
        CMP.L  A1,D6                            ; $103BAC
        MOVE.W  A5,-$790F(PC)                   ; $103BAE
        MOVE.W  -$07(PC,A5.L),-$33(A4,A3.L)     ; $103BB2
        MOVE.W  (A5)+,#$BBDF                    ; $103BB8
        BSR.S  loc_103B8A                       ; $103BBC
        ADDA.L  -$3333(A6),A6                   ; $103BBE
        DC.W    $EEFF               ; $103BC2 ROR.W  <EA:3F>
        MOVE.W  -(A2),D4                        ; $103BC4
        EOR.L  D4,A0                            ; $103BC6
        MOVE.W  -$663E(A3),(A6)+                ; $103BC8
        ADDA.W  -$15(A7,A7.L),A1                ; $103BCC
        LSR.W  $0F87.W                          ; $103BD0
        DC.W    $86FF               ; $103BD4 DIVU    <EA:3F>,D3
        MOVE.W  -(A6),$6FFF(A7)                 ; $103BD6
        SUB.L  D4,(A0)+                         ; $103BDA
        OR.W   -(A6),D4                         ; $103BDC
        ADDA.W  (A1)+,A6                        ; $103BDE
        SUB.L  D4,A0                            ; $103BE0
        MULS    A5,D6                           ; $103BE2
        AND.L  D4,(A1)+                         ; $103BE4
        ADDA.L  -$24(A0,A7.W),A6                ; $103BE6
        DC.W    $FFCD               ; $103BEA MOVE.W  A5,<EA:3F>
        ROXL.W  A5                              ; $103BEC
        MULU    -(A2),D6                        ; $103BEE
        ROXL.W  (A5)+                           ; $103BF0
        MOVE.W  D7,(A3)                         ; $103BF2
        MOVE.B  A0,-$7A(A0,A0.L)                ; $103BF4
        OR.W   D4,#$989C                        ; $103BF8
        ASR.B  D6,D6                            ; $103BFC
        MOVE.B  A2,(A0)                         ; $103BFE
        ADDA.W  -$727A(A6),A7                   ; $103C00
        MULU    $0D3F.W,D0                      ; $103C04
        NOT    (A5)+                            ; $103C08
        DBLE    D4,$1008A4                      ; $103C0A
        DIVU    A5,D3                           ; $103C0E
        SUBA.W  -(A2),A4                        ; $103C10
        ADD.B  -(A6),D6                         ; $103C12
        MULU    -$2327(A6),D4                   ; $103C14
        DC.W    $FDEC,$23FE         ; $103C18 MOVE.W  $23FE(A4),<EA:3E>
        SUBQ.L  #7,(A0)+                        ; $103C1C
        MOVE.B  -(A2),D6                        ; $103C1E
        MOVE.W  (A0)+,-$04(A5,D6.W)             ; $103C20
        MULS    $31(A7,D0.L),D4                 ; $103C24
        ADD.W  D0,(A7)+                         ; $103C28
        ADD.L  (A1),D6                          ; $103C2A
        OR.B   (A4),D3                          ; $103C2C
        DIVU    (A2),D4                         ; $103C2E
        DC.W    $0709               ; $103C30 BTST    D3,A1
        MOVE.B  #$FFF8,(A0)                     ; $103C32
        SUBA.L  A5,A5                           ; $103C36
        MOVE.W  D4,-$04(A2,A4.L)                ; $103C38
        MOVE.W  (A6)+,-$0EF1(PC)                ; $103C3C
        BSET    D7,#$888F                       ; $103C40
        OR.W   -$7D77(A7),D4                    ; $103C44
        DIVU    A4,D3                           ; $103C48
        AND.B  D5,$20FA.W                       ; $103C4A
        DC.W    $0ABB,$CD63,$0600,$9068; $103C4E EORI.L  #$CD630600,$68(PC,A1.W)
        MOVEQ   #-$01,D3                        ; $103C56
        MOVE.W  -$60(A4,A0.W),D6                ; $103C58
        MOVE.W  -$45(A6,A4.L),(A7)              ; $103C5C
        DC.W    $FBCE               ; $103C60 MOVE.W  A6,<EA:3D>
        ADD.B  D3,-$7A(A0,A4.W)                 ; $103C62
        LSR.W  A4                               ; $103C66
        CMP.L  D5,D4                            ; $103C68
        MULS    -(A1),D4                        ; $103C6A
        MOVEQ   #$0C,D6                         ; $103C6C
        AND.L  D5,-$55(A0,D6.L)                 ; $103C6E
        AND.L  $0F(A4,A4.L),D6                  ; $103C72
        BSET    D7,-$24(A5,A4.L)                ; $103C76
        OR.L   D4,$F8989BBB                     ; $103C7A
        AND.B  (A7)+,D6                         ; $103C80
        MOVE.W  -$4643(A4),D0                   ; $103C82
        SUB.L  (A1)+,D4                         ; $103C86
        SUBA.L  -(A3),A5                        ; $103C88
        DC.W    $2FDC               ; $103C8A MOVE.L  (A4)+,<EA:3F>
        NOT.W  D0                               ; $103C8C
        CMPA.L  A5,A3                           ; $103C8E
        MOVE.W  -(A0),(A6)                      ; $103C90
        MOVEA.W D4,A4                           ; $103C92
        NEGX.L -(A6)                            ; $103C94
        MOVE.B  $F702.W,$0F(PC,A0.W)            ; $103C96
        MOVEA.L (A3)+,A4                        ; $103C9C
        OR.B   D1,D7                            ; $103C9E
        DC.W    $04C9               ; $103CA0 DC.W    $04C9
        SUBA.L  -$03(A0,A7.W),A4                ; $103CA2
        MOVE.W  (A4)+,D1                        ; $103CA6
        ADDQ.W  #2,D2                           ; $103CA8
        MULU    (A7)+,D7                        ; $103CAA
        DC.W    $F1F9,$F62C,$0140,$002C; $103CAC MOVE.W  $F62C0140,$002C.W
        MOVE.W  (A1)+,(A0)+                     ; $103CB4
        MOVE.W  A0,-(A5)                        ; $103CB6
        MOVE.W  (A1)+,(A0)+                     ; $103CB8
        MULS    (A0),D4                         ; $103CBA
        MOVE.W  (A0)+,-$33(A7,A5.L)             ; $103CBC
        BSR.S  loc_103CEF                       ; $103CC0
        MULS    A4,D5                           ; $103CC2
        SVS     (A4)+                           ; $103CC4
        ADD.B  D5,(A7)+                         ; $103CC6
        MOVE.W  A3,D0                           ; $103CC8
        MOVE.W  -$08(A2,D5.W),(A6)+             ; $103CCA
        MOVE.W  (A6),(A3)+                      ; $103CCE
        MOVE.B  #$B8F4,(A4)+                    ; $103CD0
        MOVE.W  $16(A5,A6.L),$89FD.W            ; $103CD4
        SUB.W  D5,-$47BC(A3)                    ; $103CDA
        CMPA.L  -$07F7(A4),A5                   ; $103CDE
        ADDA.W  -$06(A3,A1.L),A6                ; $103CE2
        SUB.L  D5,#$99023AFC                    ; $103CE6
        ASL.B  #4,D0                            ; $103CEC
        MOVE.W  -(A4),$4402(A0)                 ; $103CEE
        MOVE.W  A0,$06(A6,A1.L)                 ; $103CF2
        DC.W    $80FF               ; $103CF6 DIVU    <EA:3F>,D0
        CMP.W  (A5)+,D6                         ; $103CF8
        ROL.W  D6,D7                            ; $103CFA
        ANDI.W  #$CD55,(A4)+                    ; $103CFC
        DC.W    $F3FF,$E2ED,$DEED   ; $103D00 MOVE.W  <EA:3F>,$E2EDDEED
        DC.W    $00FC               ; $103D06 DC.W    $00FC
        ADD.B  $0700(A2),D0                     ; $103D08
        MOVE.W  (A7),D4                         ; $103D0C
        CMPA.W  $2F(A6,A4.L),A4                 ; $103D0E
        MOVE.W  -(A0),-(A6)                     ; $103D12
        MOVE.W  $0E(A0,A7.W),(A3)+              ; $103D14
        BSR.S  loc_103D16                       ; $103D18
        EOR.L  D4,$D7BBD99B                     ; $103D1A
        AND.B  D5,(A0)+                         ; $103D20
        LEA     -$24(A7,A3.L),A1                ; $103D22
        MOVE.W  -$0845(A5),-$0D(PC,D4.L)        ; $103D26
        ROL.L  D3,D3                            ; $103D2C
        MOVE.W  #$ED90,(A6)                     ; $103D2E
        AND.W  D6,-(A1)                         ; $103D32
        BSET    #17,(A5)+                       ; $103D34
        ADD.L  -$22(PC,A7.L),D7                 ; $103D38
        ORI.W  #$F8CF,-$5D7E(A2)                ; $103D3C
        MOVE.W  -$28(A0,A7.W),-$13(A0,A6.L)     ; $103D42
        SUB.W  D0,D1                            ; $103D48
        MOVE.W  (A0),-$0E08(PC)                 ; $103D4A
        BMI.S  loc_103DB2                       ; $103D4E
        ROXR.B  #4,D0                           ; $103D50
        BSET    D7,-$0E(A0,A4.W)                ; $103D52
        OR.W   -(A5),D4                         ; $103D56
        MOVE.W  -$0825(A3),-(A7)                ; $103D58
        AND.L  D5,(A6)                          ; $103D5C
        ORI.W  #$65B5,$46(A0,A6.L)              ; $103D5E
        AND.L  D4,(A0)+                         ; $103D64
        ADD.B  D6,A0                            ; $103D66
        SUBQ.L  #1,-(A0)                        ; $103D68
        CMPA.L  (A1),A4                         ; $103D6A
        AND.L  D5,$226F(A3)                     ; $103D6C
        MOVE.W  (A0)+,-(A0)                     ; $103D70
        MULU    -$68(A2,A7.L),D6                ; $103D72
        BNE.S  loc_103D74                       ; $103D76
        EOR.L  D4,A0                            ; $103D78
        AND.B  -(A7),D1                         ; $103D7A
        MOVE.W  -$2201(A3),(A1)+                ; $103D7C
        ROR.W  -$6791(A3)                       ; $103D80
        MULU    $03(PC,D0.W),D1                 ; $103D84
        ROR.B  #4,D6                            ; $103D88
        ASL.W  #6,D0                            ; $103D8A
        MOVE.W  (A4)+,D4                        ; $103D8C
        MULS    A3,D5                           ; $103D8E
        DC.W    $CCBD               ; $103D90 AND.L  <EA:3D>,D6
        DC.W    $4108               ; $103D92 DC.W    $4108
        DC.W    $404C               ; $103D94 NEGX.W A4
        NEGX   $6100.W                          ; $103D96
        SUBQ.W  #8,D0                           ; $103D9A
        MOVE.W  #$CCF8,(A4)+                    ; $103D9C
        ASR.W  -$2A7E(A2)                       ; $103DA0
        SUBA.L  $0FF1(A3),A5                    ; $103DA4
        MOVE.B  -$0E(A2,D0.L),(A0)+             ; $103DA8
        ROXL.W  -(A7)                           ; $103DAC
        ASR.W  D5,D3                            ; $103DAE
        DC.W    $4835               ; $103DB0 DC.W    $4835
loc_103DB2:
        ADDA.L  $39E3(A1),A7                    ; $103DB2
        ROXL.W  A0                              ; $103DB6
        DC.W    $F4FF               ; $103DB8 MOVE.W  <EA:3F>,(A2)+
        MOVE.W  -(A5),D4                        ; $103DBA
        LSL.B  D6,D2                            ; $103DBC
        MOVE.B  (A2),$C8E9.W                    ; $103DBE
        MOVE.W  -$0F(A3,A4.W),$21A8.W           ; $103DC2
        CMPA.L  -$53AC(A4),A5                   ; $103DC8
        MOVE.W  A2,(A1)+                        ; $103DCC
        MOVE.W  (A4),D4                         ; $103DCE
        DC.W    $AB3F               ; $103DD0 MOVE.L  <EA:3F>,-(A5)
        MULS    (A0)+,D7                        ; $103DD2
        MOVE.B  (A6),$55AE(A5)                  ; $103DD4
        DC.W    $EAFF               ; $103DD8 LSR.W  <EA:3F>
        MOVE.W  (A0),D4                         ; $103DDA
        SUBA.L  $5568(A1),A6                    ; $103DDC
        DC.W    $FFF5,$6889         ; $103DE0 MOVE.W  -$77(A5,D6.L),<EA:3F>
        SCC     (A1)+                           ; $103DE4
        ADD.L  D7,A1                            ; $103DE6
        BSET    #24,-(A2)                       ; $103DE8
        MOVE.B  -(A0),-(A0)                     ; $103DEC
        MOVEA.W -$0D(A2,D7.W),A1                ; $103DEE
        MOVE.W  -(A2),(A5)+                     ; $103DF2
        ASR.W  D6,D0                            ; $103DF4
        MOVE.W  A0,-$1E14(A2)                   ; $103DF6
        AND.B  D5,-(A7)                         ; $103DFA
        MOVE.W  (A4)+,(A6)+                     ; $103DFC
        MOVE.W  #$BBF1,(A0)+                    ; $103DFE
        AND.L  D5,-$0A46(A3)                    ; $103E02
        CMPA.L  A4,A5                           ; $103E06
loc_103E08:
        CMPA.W  A4,A6                           ; $103E08
        ORI.L  #$CDFDD717,(A2)+                 ; $103E0A
        MOVE.W  (A0)+,(A1)+                     ; $103E10
        MOVE.W  (A4)+,$4463.W                   ; $103E12
        MOVE.W  $4E(A6,A6.W),(A4)+              ; $103E16
        MOVE.W  #$EDBD,(A0)+                    ; $103E1A
        ASL.B  #6,D4                            ; $103E1E
        AND.L  $2940.W,D0                       ; $103E20
        MOVE.W  -(A0),D4                        ; $103E24
        MOVE.L  (A6)+,(A4)+                     ; $103E26
        MOVE.W  -(A0),(A0)+                     ; $103E28
        DC.W    $F3F8,$A8F1,$D0F2,$29CE; $103E2A MOVE.W  $A8F1.W,$D0F229CE
        MOVE.L  -(A1),-$06(A2,A7.W)             ; $103E32
        ROL.B  #6,D4                            ; $103E36
        ADDA.L  A6,A6                           ; $103E38
        AND.B  D3,D1                            ; $103E3A
        ADDA.W  -$0311(A0),A0                   ; $103E3C
        ADD.L  D5,(A1)+                         ; $103E40
        OR.L   A0,D4                            ; $103E42
        SUB.L  D2,-(A0)                         ; $103E44
        MOVE.W  $60(PC,A6.W),-$2525(PC)         ; $103E46
        BSR.S  loc_103E4B                       ; $103E4C
loc_103E4E:
        DC.W    $FFFF               ; $103E4E MOVE.W  <EA:3F>,<EA:3F>
        BNE.S  loc_103E4E                       ; $103E50
        DC.W    $1FFF               ; $103E52 MOVE.B  <EA:3F>,<EA:3F>
        SUBQ.L  #7,A2                           ; $103E54
        OR.L   A0,D5                            ; $103E56
        BCS.S  loc_103E14                       ; $103E58
        MOVE.L  D6,(A4)                         ; $103E5A
        BLE.S  loc_103E08                       ; $103E5C
        OR.L   D6,D4                            ; $103E5E
        BSET    D1,-$58(A3,A0.L)                ; $103E60
        ADD.L  A2,D0                            ; $103E64
        MOVE.L  -$0ABA(A3),-$15(A5,D4.W)        ; $103E66
        SNE     -(A3)                           ; $103E6C
        MOVE.L  -(A0),(A0)+                     ; $103E6E
        BSET    D7,(A2)                         ; $103E70
        MOVE.W  -(A1),(A1)+                     ; $103E72
        BCLR    D3,-$571F(A5)                   ; $103E74
        OR.W   -(A5),D3                         ; $103E78
        MOVE.W  (A4),-$01(A3,A6.W)              ; $103E7A
        MOVE.W  A2,D4                           ; $103E7E
        MOVE.W  A5,-$0DCF(PC)                   ; $103E80
        OR.L   D2,(A4)+                         ; $103E84
        ADDA.W  $56(A5,A7.L),A2                 ; $103E86
        MOVE.W  A0,(A6)                         ; $103E8A
        DC.W    $F67F               ; $103E8C MOVEA.W <EA:3F>,A3
        MOVE.W  (A1)+,(A0)                      ; $103E8E
        CMP.W  (A6),D5                          ; $103E90
        OR.L   D4,(A3)+                         ; $103E92
        MOVE.L  -$65EC(A0),-$632F(A5)           ; $103E94
        CMP.L  A1,D6                            ; $103E9A
        BTST    D1,-$44(A4,A2.L)                ; $103E9C
        MULS    #$1F99,D6                       ; $103EA0
        DC.W    $2FE9,$99AA         ; $103EA4 MOVE.L  -$6656(A1),<EA:3F>
        SUBA.W  $8FD9.W,A1                      ; $103EA8
        ASR.W  -$2725(A3)                       ; $103EAC
        DC.W    $02F3               ; $103EB0 DC.W    $02F3
        MOVEA.L (A4),A3                         ; $103EB2
        SUBA.W  -(A6),A3                        ; $103EB4
        ADDA.W  $DDF8.W,A5                      ; $103EB6
        DC.W    $DAFF               ; $103EBA ADDA.W  <EA:3F>,A5
        CLR    -$55(A2,D4.W)                    ; $103EBC
        MOVE.L  A4,$EADD.W                      ; $103EC0
        ADDA.L  (A1)+,A3                        ; $103EC4
        ADDA.L  A1,A6                           ; $103EC6
        DC.W    $F1FE,$D980         ; $103EC8 MOVE.W  <EA:3E>,$D980.W
        DC.W    $00D8               ; $103ECC DC.W    $00D8
        ADD.B  A6,D7                            ; $103ECE
        MULU    A5,D3                           ; $103ED0
        LSR.L  #2,D0                            ; $103ED2
        ADDA.L  A1,A0                           ; $103ED4
        ADDA.L  -$24(A1,A6.L),A7                ; $103ED6
        EOR.W  D0,$04EF(A0)                     ; $103EDA
        DC.W    $F8FE               ; $103EDE MOVE.W  <EA:3E>,(A4)+
        LSL.W  (A5)+                            ; $103EE0
        LSR.W  A0                               ; $103EE2
        OR.B   D2,$48E2(A7)                     ; $103EE4
        MOVE.L  -$45(A2,A7.L),(A4)+             ; $103EE8
        CMPA.L  (A5)+,A5                        ; $103EEC
        MULS    A3,D5                           ; $103EEE
        MOVE.L  $10(A2,A2.W),$E68B.W            ; $103EF0
        SUBA.W  -$34(A1,A7.L),A1                ; $103EF6
        MOVEQ   #-$80,D0                        ; $103EFA
        BVC.S  loc_103EE7                       ; $103EFC
        ADDA.L  A3,A5                           ; $103EFE
        DC.W    $FCFF               ; $103F00 MOVE.W  <EA:3F>,(A6)+
        MOVE.W  D3,(A0)+                        ; $103F02
        DC.W    $BCFD               ; $103F04 CMPA.W  <EA:3D>,A6
        AND.L  D5,-$4547(PC)                    ; $103F06
        AND.L  D5,-$0013(A3)                    ; $103F0A
        DC.W    $0708               ; $103F0E BTST    D3,A0
        AND.L  -$4434(A3),D6                    ; $103F10
        DC.W    $F3FC,$BB01,$FEF4,$BBEC; $103F14 MOVE.W  #$BB01,$FEF4BBEC
        ROL.L  D3,D1                            ; $103F1C
        MOVE.L  -$6457(PC),-$3D(A5,A2.L)        ; $103F1E
        NEGX.L -$4648(A3)                       ; $103F24
        MOVE.W  (A3)+,$28(A1,A1.L)              ; $103F28
        MOVE.W  D2,(A1)                         ; $103F2C
        CMP.W  D7,D0                            ; $103F2E
        ADDA.W  $F76C.W,A5                      ; $103F30
        ADDI.L  #$68FCBDD9,(A4)                 ; $103F34
        MULS    #$E808,D6                       ; $103F3A
        ADD.W  (A1),D7                          ; $103F3E
        SUB.B  D2,-(A0)                         ; $103F40
        MOVE.B  -(A5),D4                        ; $103F42
        ROR.W  #5,D1                            ; $103F44
        ASL.W  $D448.W                          ; $103F46
        MOVE.W  -(A4),(A1)+                     ; $103F4A
        ORI.W  #$00EA,-$35(A0,A4.W)             ; $103F4C
        MOVE.L  (A0)+,-(A1)                     ; $103F52
        SUB.L  D5,(A5)+                         ; $103F54
        MOVE.W  -$0F45(PC),(A4)                 ; $103F56
        MOVE.L  $50(A1,A3.L),(A0)+              ; $103F5A
        MOVE.B  -(A3),D2                        ; $103F5E
        ADD.L  -(A0),D0                         ; $103F60
        MOVE.W  (A0)+,(A6)+                     ; $103F62
        MULS    $28(A1,D6.W),D4                 ; $103F64
        MOVE.L  -$35(A6,A2.L),(A4)+             ; $103F68
        MOVE.W  -$3816(PC),(A4)                 ; $103F6C
        OR.L   D0,D5                            ; $103F70
        MOVE.L  -$021F(A0),-(A3)                ; $103F72
        ADDQ.L  #3,D0                           ; $103F76
        DC.W    $04C9               ; $103F78 DC.W    $04C9
        AND.W  D3,D0                            ; $103F7A
        ADDQ.L  #8,-(A3)                        ; $103F7C
        DC.W    $02D3               ; $103F7E DC.W    $02D3
        SUB.L  $25F8(A2),D5                     ; $103F80
        ASR.L  D5,D0                            ; $103F84
        ROL.B  D5,D3                            ; $103F86
        DC.W    $0888,$F781         ; $103F88 BCLR    #1,A0
        MOVE.W  A0,$F701.W                      ; $103F8C
        SUB.B  -$08(A2,A4.L),D2                 ; $103F90
        MOVE.W  -(A0),(A7)                      ; $103F94
        MOVE.W  D1,(A3)+                        ; $103F96
        ASL.L  D5,D4                            ; $103F98
        SUB.W  D2,-$4F03(A0)                    ; $103F9A
        SUB.L  (A3)+,D4                         ; $103F9E
        SUB.B  D5,$E1B3.W                       ; $103FA0
        ROXR.W  D5                              ; $103FA4
        MOVE.L  -$0E(PC,A2.W),-(A2)             ; $103FA6
        BGE.S  loc_103F8A                       ; $103FAA
        ADD.L  A3,D7                            ; $103FAC
        MOVE.W  $4D11(A4),-$5D0A(A6)            ; $103FAE
        DC.W    $9CFD               ; $103FB4 SUBA.W  <EA:3D>,A6
        ADD.B  D6,D4                            ; $103FB6
        CMP.L  (A4)+,D6                         ; $103FB8
        ORI.W  #$F8F7,A0                        ; $103FBA
        MOVEA.W (A7)+,A4                        ; $103FBE
        MOVE.W  -(A4),$39A9(PC)                 ; $103FC0
        MOVE.W  -$22(A4,D7.W),(A6)+             ; $103FC4
        SUB.B  (A4)+,D6                         ; $103FC8
        ROR.B  D5,D4                            ; $103FCA
        MOVEA.W D5,A1                           ; $103FCC
        LSL.B  D6,D3                            ; $103FCE
        ROR.B  #8,D6                            ; $103FD0
        ADD.W  D6,-(A1)                         ; $103FD2
        ROR.B  #8,D3                            ; $103FD4
        MOVE.W  $28(A4,A4.W),-(A6)              ; $103FD6
        ADD.B  A4,D0                            ; $103FDA
        SUB.B  D4,(A4)+                         ; $103FDC
        MULS    A4,D4                           ; $103FDE
        MOVE.W  (A4),-$75(PC,A7.W)              ; $103FE0
        MULS    $25C9(A5),D6                    ; $103FE4
        ROR.L  D7,D3                            ; $103FE8
        DIVU    -(A2),D4                        ; $103FEA
        MOVE.W  A3,D4                           ; $103FEC
        MOVE.W  D1,-$10(PC,A4.W)                ; $103FEE
        DC.W    $FFB9,$8FFC,$DB98,$FCED; $103FF2 MOVE.W  $8FFCDB98,-$13(A7,A7.L)
        EOR.W  D4,$41D5(A7)                     ; $103FFA
        DC.W    $FFEE,$F705         ; $103FFE MOVE.W  -$08FB(A6),<EA:3F>
        ADD.W  D4,(A0)+                         ; $104002
        ROXR.W  $FDF9.W                         ; $104004
        ADD.W  D0,D4                            ; $104008
        LSR.W  -$0B(A2,A3.L)                    ; $10400A
        MOVE.W  -$0366(A2),(A4)+                ; $10400E
        DC.W    $BBBD               ; $104012 EOR.L  D5,<EA:3D>
        AND.L  D6,(A2)+                         ; $104014
        DC.W    $ABBC,$DCF7,$FF41,$E9CB; $104016 MOVE.L  #$DCF7FF41,-$35(A5,A6.L)
        SUB.L  $3CE9(A2),D5                     ; $10401E
        MOVE.L  -$5468(A3),-$66(A4,A1.L)        ; $104022
        SUB.L  D4,A1                            ; $104028
        OR.L   D4,$162A(A2)                     ; $10402A
        CMPA.L  (A4),A5                         ; $10402E
        AND.L  D4,$38C1(A3)                     ; $104030
        DC.W    $33ED,$60F1,$ECF1,$14D4; $104034 MOVE.W  $60F1(A5),$ECF114D4
        ADDA.W  (A3)+,A5                        ; $10403C
        MULU    -$005C(A1),D3                   ; $10403E
        DC.W    $F1FF,$FC74         ; $104042 MOVE.W  <EA:3F>,$FC74.W
        MOVE.W  (A6),-$1E33(A0)                 ; $104046
        SVC     $26(A1,A5.L)                    ; $10404A
        MOVE.W  -$0EDA(A7),(A1)                 ; $10404E
        MOVE.W  -(A3),(A1)+                     ; $104052
        MULS    A4,D6                           ; $104054
        BRA.S  loc_10409D                       ; $104056
        MULU    -(A7),D5                        ; $104058
        BSR.S  loc_10404D                       ; $10405A
        CMP.W  (A2)+,D6                         ; $10405C
        MOVE.W  $E9C7.W,$0D10(A0)               ; $10405E
        BVC.S  loc_104055                       ; $104064
        MULU    -$20(A2,A4.L),D2                ; $104066
        ADDA.W  A4,A2                           ; $10406A
        OR.B   D0,-(A4)                         ; $10406C
        CMPA.W  -(A0),A4                        ; $10406E
        CMPA.L  -$20(A7,A5.L),A6                ; $104070
        BTST    D0,(A0)                         ; $104074
        DIVS    A2,D3                           ; $104076
        DC.W    $FBC9               ; $104078 MOVE.W  A1,<EA:3D>
        ASL.B  #1,D0                            ; $10407A
        MOVE.L  D6,(A0)+                        ; $10407C
        MOVE.W  D3,-$67(A6,A4.W)                ; $10407E
        MOVE.B  D2,D6                           ; $104082
        LSR.L  D1,D2                            ; $104084
        SUBA.L  A4,A4                           ; $104086
        MOVE.W  -$137C(A2),(A4)                 ; $104088
        BSET    #13,$A9F5.W                     ; $10408C
        DC.W    $0888,$ECF8         ; $104092 BCLR    #24,A0
        SVS     #$0100                          ; $104096
        MOVE.W  (A1)+,-$08(A7,D5.L)             ; $10409A
        SUBQ.B  #1,(A7)+                        ; $10409E
loc_1040A0:
        NEGX   (A2)+                            ; $1040A0
        OR.L   -$6668(A3),D5                    ; $1040A2
        MOVEA.W A4,A1                           ; $1040A6
        SUB.L  $4020(PC),D3                     ; $1040A8
        MOVE.W  D3,$39F8(A3)                    ; $1040AC
        MOVE.L  A0,(A4)                         ; $1040B0
        MOVE.W  (A1)+,-$0E(A3,D5.W)             ; $1040B2
        MOVE.L  $18(A0,A6.L),(A3)+              ; $1040B6
        MOVE.L  -$24(A7,D1.L),(A0)+             ; $1040BA
        MOVE.L  $9900.W,(A7)+                   ; $1040BE
        BSET    #12,(A7)+                       ; $1040C2
        MOVE.W  $05(A7,D4.W),-$22(A7,D4.L)      ; $1040C6
        DIVS    -$0138(A1),D1                   ; $1040CC
        ROXR.W  $FF50.W                         ; $1040D0
        CLR.B  D0                               ; $1040D4
        BLE.S  loc_1040A0                       ; $1040D6
        BCHG    D2,$25C0(A4)                    ; $1040D8
        LEA     (A6)+,A4                        ; $1040DC
        MOVEQ   #-$18,D4                        ; $1040DE
        BSET    D4,$E2F9.W                      ; $1040E0
        MOVE.B  (A1),-$4555(A2)                 ; $1040E4
        ADDA.W  -(A1),A7                        ; $1040E8
        MOVEQ   #-$17,D1                        ; $1040EA
        BTST    #9,-$0F(A0,A4.W)                ; $1040EC
        MOVE.L  -(A2),(A6)+                     ; $1040F2
        DC.W    $FABF               ; $1040F4 MOVE.W  <EA:3F>,(A5)
        LSL.L  D0,D3                            ; $1040F6
        MOVE.L  (A0),-$4566(A4)                 ; $1040F8
        MOVE.B  -(A1),D0                        ; $1040FC
        AND.W  (A0),D6                          ; $1040FE
        MOVE.L  -$57(A5,D3.W),-(A5)             ; $104100
        MOVE.L  D4,D0                           ; $104104
        ADDQ.W  #2,D1                           ; $104106
        MOVE.W  $6C10(A1),$4C(A3,D2.W)          ; $104108
        SMI     #$5498                          ; $10410E
        ADD.B  D0,-(A2)                         ; $104112
        MULU    -(A0),D0                        ; $104114
        DC.W    $26FF               ; $104116 MOVE.L  <EA:3F>,(A3)+
        MOVE.W  (A2)+,(A6)                      ; $104118
        MOVE.B  -(A4),-$56(A0,A1.L)             ; $10411A
        MOVE.W  (A6),(A7)+                      ; $10411E
        DC.W    $3DFC,$3512         ; $104120 MOVE.W  #$3512,<EA:3E>
        OR.L   D4,(A0)+                         ; $104124
        SUBA.L  -$07(A1,A6.W),A1                ; $104126
        ROXL.W  $02(A1,D0.W)                    ; $10412A
        ADD.W  D4,D4                            ; $10412E
        ADDA.L  (A2)+,A4                        ; $104130
        CMPA.L  (A2)+,A3                        ; $104132
        OR.L   D2,D1                            ; $104134
        DC.W    $01FF               ; $104136 BSET    D0,<EA:3F>
        DC.W    $7BF1,$29E1         ; $104138 MOVE.W  -$1F(A1,D2.L),<EA:3D>
        MOVEQ   #-$80,D6                        ; $10413C
        MOVE.L  $73(A2,A6.W),(A4)+              ; $10413E
        MOVE.W  (A6)+,-$3E(A7,D3.W)             ; $104142
        DC.W    $02B8,$E51E,$FC27,$F1EE; $104146 ANDI.L  #$E51EFC27,$F1EE.W
        ASR.L  #6,D2                            ; $10414E
        CMP.L  (A5)+,D1                         ; $104150
        ROR.W  D1,D2                            ; $104152
        MOVE.W  (A1),$70F2(A0)                  ; $104154
        MOVE.L  -$60(A1,A1.W),$223C.W           ; $104158
        MOVEA.W A7,A1                           ; $10415E
        MOVEQ   #-$1F,D0                        ; $104160
        BCC.S  loc_10415A                       ; $104162
        MOVE.W  $0B(A2,A6.W),(A1)+              ; $104164
        EORI.W  #$DCDB,$25(A0,A7.L)             ; $104168
        MOVE.W  A4,-$0EBA(A0)                   ; $10416E
        SUBI.L  #$19C9CDF1,-(A0)                ; $104172
        MOVE.W  $3109(A6),(A4)+                 ; $104178
        DC.W    $0CEA               ; $10417C DC.W    $0CEA
        MOVE.W  A3,(A4)+                        ; $10417E
        MOVE.W  D4,D4                           ; $104180
        MOVE.W  A0,(A1)                         ; $104182
        SGE     D0                              ; $104184
        CMPA.W  -$0734(A2),A6                   ; $104186
        ADDA.L  #$4455F9C3,A5                   ; $10418A
        MOVE.W  #$D4FD,(A4)+                    ; $104190
        MOVE.W  $19EC.W,(A4)+                   ; $104194
        ASR.B  #6,D5                            ; $104198
        MOVE.W  -$0CF4(A3),(A2)                 ; $10419A
        DC.W    $DCFF               ; $10419E ADDA.W  <EA:3F>,A6
        MOVE.L  D1,-$0346(PC)                   ; $1041A0
        EORI.L  #$B02CDFDE,A2                   ; $1041A4
        CMPA.L  (A1)+,A6                        ; $1041AA
        ADDA.W  -$55C5(A1),A6                   ; $1041AC
        ADDA.W  D0,A7                           ; $1041B0
        MOVE.W  A2,D4                           ; $1041B2
        MULU    -(A0),D0                        ; $1041B4
        MOVE.B  -$1DE0(A5),(A7)+                ; $1041B6
        AND.B  (A1),D4                          ; $1041BA
        SUBQ.W  #2,(A5)                         ; $1041BC
        DC.W    $06D1               ; $1041BE DC.W    $06D1
        BNE.S  loc_10414A                       ; $1041C0
        MOVE.L  D4,(A6)                         ; $1041C2
        MOVE.W  A1,$22(A7,A1.L)                 ; $1041C4
        ADD.B  A1,D0                            ; $1041C8
        ROL.W  $03(A5,A5.W)                     ; $1041CA
        MOVE.L  A0,(A4)                         ; $1041CE
        BNE.S  $10423A                          ; $1041D0
        ROXR.W  $78F1(PC)                       ; $1041D2
        ROL.W  -(A1)                            ; $1041D6
        CMP.W  D6,D5                            ; $1041D8
        ADDA.W  -$2B1E(A2),A6                   ; $1041DA
        ADDA.W  A1,A4                           ; $1041DE
        BVC.S  $10424A                          ; $1041E0
        ADD.L  D6,-$0F(A1,D6.W)                 ; $1041E2
        DC.W    $ABE9,$058C         ; $1041E6 MOVE.L  $058C(A1),<EA:3D>
        BSET    D1,-$512F(A6)                   ; $1041EA
        BSET    D0,-(A5)                        ; $1041EE
        SUB.W  D5,(A7)+                         ; $1041F0
        SF      -(A5)                           ; $1041F2
        CMP.L  (A1)+,D6                         ; $1041F4
        SUB.L  D5,-$14(PC,A4.L)                 ; $1041F6
        ADDA.L  $D3E8.W,A0                      ; $1041FA
        CMPA.W  -$489E(A2),A6                   ; $1041FE
