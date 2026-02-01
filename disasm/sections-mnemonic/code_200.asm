; ============================================================================
; Code Section ($000200-$0021FF)
; Regenerated with fixed disassembler - proper mnemonics
; ============================================================================

        org     $000200

; ----------------------------------------------------------------------------
; entry_point ($000200) - ROM entry point
; ----------------------------------------------------------------------------
entry_point:
        JMP     $00880838                       ; $000200
        JMP     $00880832                       ; $000206
        JMP     $00880832                       ; $00020C
        JMP     $00880832                       ; $000212
        JMP     $00880832                       ; $000218
        JMP     $00880832                       ; $00021E
        JMP     $00880832                       ; $000224
        JMP     $00880832                       ; $00022A
        JMP     $00880832                       ; $000230
        JMP     $00880832                       ; $000236
        JMP     $00880832                       ; $00023C
        JMP     $00880832                       ; $000242
        JMP     $00880832                       ; $000248
        JMP     $00880832                       ; $00024E
        JMP     $00880832                       ; $000254
        JMP     $00880832                       ; $00025A
        JMP     $00880832                       ; $000260
        JMP     $00880832                       ; $000266
        JMP     $00880832                       ; $00026C
        JMP     $00880832                       ; $000272
        JMP     $00880832                       ; $000278
        JMP     $00880832                       ; $00027E
        JMP     $00880832                       ; $000284
        JMP     $00880832                       ; $00028A
        JMP     $00880832                       ; $000290
        JMP     $00880832                       ; $000296
        JMP     $00880832                       ; $00029C
        JMP     $0088170A                       ; $0002A2
        JMP     $00880832                       ; $0002A8
        JMP     $00881684                       ; $0002AE
        JMP     $00880832                       ; $0002B4
        JMP     $00880832                       ; $0002BA
        JMP     $00880832                       ; $0002C0
        JMP     $00880832                       ; $0002C6
        JMP     $00880832                       ; $0002CC
        JMP     $00880832                       ; $0002D2
        JMP     $00880832                       ; $0002D8
        JMP     $00880832                       ; $0002DE
        JMP     $00880832                       ; $0002E4
        JMP     $00880832                       ; $0002EA
        JMP     $00880832                       ; $0002F0
        JMP     $00880832                       ; $0002F6
        JMP     $00880832                       ; $0002FC
        JMP     $00880832                       ; $000302
        JMP     $00880832                       ; $000308
        JMP     $00880832                       ; $00030E
        JMP     $00880832                       ; $000314
        JMP     $00880832                       ; $00031A
        JMP     $00880832                       ; $000320
        JMP     $00880832                       ; $000326
        JMP     $00880832                       ; $00032C
        JMP     $00880832                       ; $000332
        JMP     $00880832                       ; $000338
        JMP     $00880832                       ; $00033E
        JMP     $00880832                       ; $000344
        JMP     $00880832                       ; $00034A
        JMP     $00880832                       ; $000350
        JMP     $00880832                       ; $000356
        JMP     $00880832                       ; $00035C
        JMP     $00880832                       ; $000362
        JMP     $00880832                       ; $000368
        JMP     $00880832                       ; $00036E
        JMP     $00880832                       ; $000374
        NOP                                     ; $00037A
        NOP                                     ; $00037C
        NOP                                     ; $00037E
        NOP                                     ; $000380
        NOP                                     ; $000382
        NOP                                     ; $000384
        NOP                                     ; $000386
        NOP                                     ; $000388
        NOP                                     ; $00038A
        NOP                                     ; $00038C
        NOP                                     ; $00038E
        NOP                                     ; $000390
        NOP                                     ; $000392
        NOP                                     ; $000394
        NOP                                     ; $000396
        NOP                                     ; $000398
        NOP                                     ; $00039A
        NOP                                     ; $00039C
        NOP                                     ; $00039E
        NOP                                     ; $0003A0
        NOP                                     ; $0003A2
        NOP                                     ; $0003A4
        NOP                                     ; $0003A6
        NOP                                     ; $0003A8
        NOP                                     ; $0003AA
        NOP                                     ; $0003AC
        NOP                                     ; $0003AE
        NOP                                     ; $0003B0
        NOP                                     ; $0003B2
        NOP                                     ; $0003B4
        NOP                                     ; $0003B6
        NOP                                     ; $0003B8
        NOP                                     ; $0003BA
        NOP                                     ; $0003BC
        NOP                                     ; $0003BE
        DC.W    $4D41                           ; $0003C0
        ADDQ.W  #1,(A3)                         ; $0003C2
        MOVEA.L D3,A0                           ; $0003C4
        SWAP    D5                              ; $0003C6
        DC.W    $434B                           ; $0003C8
        MOVEA.L A5,A0                           ; $0003CA
        DC.W    $4F44                           ; $0003CC
        DC.W    $4520                           ; $0003CE
        ORI.B  #$00,D0                          ; $0003D0
        ORI.B  #$00,D2                          ; $0003D4
        ORI.B  #$00,D0                          ; $0003D8
        ORI.B  #$00,D0                          ; $0003DC
        ADDI.B  #$80,D0                         ; $0003E0
        ADDI.B  #$88,D0                         ; $0003E4
        ADDI.B  #$00,D0                         ; $0003E8
        ADDI.B  #$40,D0                         ; $0003EC
        MOVEA.L #$FFFFFFC0,A4                   ; $0003F0
        MOVE.L  #$00000000,$00A15128            ; $0003F6
        MOVE    #$2700,SR                       ; $000400
        LEA     $00A10000,A5                    ; $000404
        MOVEQ   #$01,D0                         ; $00040A
        CMPI.L  #$4D415253,$30EC(A5)            ; $00040C
        BNE.W  loc_0007FC                       ; $000414
loc_000418:
        BTST    #7,$5101(A5)                    ; $000418
        BEQ.S  loc_000418                       ; $00041E
        TST.L  $0008(A5)                        ; $000420
        BEQ.S  loc_000436                       ; $000424
        TST.W  $000C(A5)                        ; $000426
        BEQ.S  loc_000436                       ; $00042A
        BTST    #0,$5101(A5)                    ; $00042C
        BNE.W  loc_0007EC                       ; $000432
loc_000436:
        MOVE.B  $0001(A5),D0                    ; $000436
        ANDI.B  #$0F,D0                         ; $00043A
        BEQ.S  loc_000446                       ; $00043E
        MOVE.L  ($055A).W,$4000(A5)             ; $000440
loc_000446:
        MOVEQ   #$00,D1                         ; $000446
        MOVEA.L D1,A6                           ; $000448
        MOVE    A6,USP                          ; $00044A
        LEA     $000004D4,A0                    ; $00044C
        BSR.W  loc_0005A6                       ; $000452
        BSR.W  loc_0005CE                       ; $000456
        LEA     $000004E8,A3                    ; $00045A
        LEA     $00A00000,A1                    ; $000460
        LEA     $00C00011,A2                    ; $000466
        MOVE.W  #$0100,D7                       ; $00046C
        MOVEQ   #$00,D0                         ; $000470
        MOVE.W  D7,$1100(A5)                    ; $000472
        MOVE.W  D7,$1200(A5)                    ; $000476
loc_00047A:
        BTST    D0,$1100(A5)                    ; $00047A
        BNE.S  loc_00047A                       ; $00047E
        MOVEQ   #$25,D2                         ; $000480
loc_000482:
        MOVE.B  (A3)+,(A1)+                     ; $000482
        DBRA    D2,loc_000482                   ; $000484
        MOVE.W  D0,$1200(A5)                    ; $000488
        MOVE.W  D0,$1100(A5)                    ; $00048C
        MOVE.W  D7,$1200(A5)                    ; $000490
        MOVE.B  (A3)+,(A2)                      ; $000494
        MOVE.B  (A3)+,(A2)                      ; $000496
        MOVE.B  (A3)+,(A2)                      ; $000498
        MOVE.B  (A3)+,(A2)                      ; $00049A
        LEA     $000004C0,A0                    ; $00049C
        LEA     $00FF0000,A1                    ; $0004A2
        MOVE.L  (A0)+,(A1)+                     ; $0004A8
        MOVE.L  (A0)+,(A1)+                     ; $0004AA
        MOVE.L  (A0)+,(A1)+                     ; $0004AC
        MOVE.L  (A0)+,(A1)+                     ; $0004AE
        MOVE.L  (A0)+,(A1)+                     ; $0004B0
        MOVE.L  (A0)+,(A1)+                     ; $0004B2
        MOVE.L  (A0)+,(A1)+                     ; $0004B4
        MOVE.L  (A0)+,(A1)+                     ; $0004B6
        LEA     $00FF0000,A0                    ; $0004B8
        JMP     (A0)                            ; $0004BE
        MOVE.B  #$01,$5101(A5)                  ; $0004C0
        LEA     $000006BC,A0                    ; $0004C6
        ADDA.L  #$00880000,A0                   ; $0004CC
        JMP     (A0)                            ; $0004D2
        SUBI.B  #$3C,D4                         ; $0004D4
        BCHG    D3,$0000(A4)                    ; $0004D8
        ORI.B  #$00,D0                          ; $0004DC
        OR.B   D0,$02(A7,D0.W)                  ; $0004E0
        BTST    D0,D0                           ; $0004E4
        ORI.B  #$01,D0                          ; $0004E6
        ADD.B  D4,(A7)+                         ; $0004EA
        MOVE.B  -(A7),-(A0)                     ; $0004EC
        ORI.B  #$00,-(A1)                       ; $0004EE
        DC.W    $F977                           ; $0004F2
        ROXL.L  D6,D0                           ; $0004F4
        ADDA.L  -(A1),A6                        ; $0004F6
        DC.W    $FDE1                           ; $0004F8
        ASL.W  #6,D7                            ; $0004FA
        LSL.W  #6,D7                            ; $0004FC
        ADDA.L  -(A1),A0                        ; $0004FE
        DC.W    $F108                           ; $000500
        ADDA.L  D1,A4                           ; $000502
        ADDA.L  -(A1),A0                        ; $000504
        DC.W    $F1F9                           ; $000506
        DC.W    $F3ED                           ; $000508
        ADDQ.B  #3,-$17(A6,A6.L)                ; $00050A
        DC.W    $9FBF                           ; $00050E
        DC.W    $DFFF                           ; $000510
        DC.W    $4D41                           ; $000512
        ADDQ.W  #1,(A3)                         ; $000514
        MOVEA.L A1,A0                           ; $000516
        DC.W    $6E69                           ; $000518
        MOVEQ   #$69,D2                         ; $00051A
        BSR.S  loc_00058A                       ; $00051C
        MOVE.L  -(A6),D0                        ; $00051E
        MOVEA.L (A3),A0                         ; $000520
        DC.W    $6563                           ; $000522
        MOVE.W  $74(A2,D6.L),$7920(A2)          ; $000524
        ADDQ.W  #8,$67(A2,D6.L)                 ; $00052A
        MOVEQ   #$61,D1                         ; $00052E
        BLT.S  loc_000552                       ; $000530
        MOVE.L  -(A0),D0                        ; $000532
        MOVE.L  -(A0),D0                        ; $000534
        MOVE.L  -(A0),D0                        ; $000536
        MOVE.L  -(A0),D0                        ; $000538
        MOVEA.L D3,A0                           ; $00053A
        BSR.S  loc_0005B0                       ; $00053C
        MOVEQ   #$72,D2                         ; $00053E
        BVS.S  loc_0005A6                       ; $000540
        DC.W    $6765                           ; $000542
        MOVEA.L (A6),A0                         ; $000544
        BCS.S  loc_0005BA                       ; $000546
        MOVE.W  $6F6E(A1),$2020(A1)             ; $000548
        MOVE.L  -(A0),D0                        ; $00054E
        DC.W    $436F                           ; $000550
loc_000552:
        MOVEQ   #$79,D0                         ; $000552
        MOVEQ   #$69,D1                         ; $000554
        BEQ.S  loc_0005C0                       ; $000556
        MOVEQ   #$20,D2                         ; $000558
        SUBQ.W  #1,D5                           ; $00055A
        DC.W    $4741                           ; $00055C
        MOVEA.L D5,A0                           ; $00055E
        LINK    A4,#$4552                       ; $000560
        ADDQ.W  #8,(A2)                         ; $000564
        DC.W    $4953                           ; $000566
        DC.W    $4553                           ; $000568
        MOVEA.L A4,A6                           ; $00056A
        ADDQ.W  #2,D4                           ; $00056C
        MOVE.L  -(A0),D7                        ; $00056E
        MOVE.W  $39342020,-(A0)                 ; $000570
        MOVE.L  -(A0),D0                        ; $000576
        MOVE.L  -(A0),D0                        ; $000578
        MOVE.L  -(A0),D0                        ; $00057A
        MOVE.L  -(A0),D0                        ; $00057C
        MOVE.L  -(A0),D0                        ; $00057E
        MOVE.L  -(A0),D0                        ; $000580
        MOVE.L  -(A0),D0                        ; $000582
        MOVE.L  -(A0),D0                        ; $000584
        MOVE.L  -(A0),D0                        ; $000586
        MOVE.L  -(A0),D0                        ; $000588
loc_00058A:
        MOVE.L  -(A0),D0                        ; $00058A
        MOVE.L  -(A0),D0                        ; $00058C
        MOVE.L  -(A0),D0                        ; $00058E
        MOVE.L  -(A0),D0                        ; $000590
        MOVE.L  -(A0),D0                        ; $000592
        MOVE.L  -(A0),D0                        ; $000594
        ADDQ.W  #1,A7                           ; $000596
        DC.W    $4D20                           ; $000598
        ADDQ.W  #3,-(A5)                        ; $00059A
        MOVEQ   #$73,D1                         ; $00059C
        DC.W    $696F                           ; $00059E
        BGT.S  loc_0005C2                       ; $0005A0
        MOVE.W  $3000(A6),-(A0)                 ; $0005A2
loc_0005A6:
        MOVEM.L D0/D1/A1,-(A7)                  ; $0005A6
        LEA     $00C00004,A1                    ; $0005AA
loc_0005B0:
        MOVE.W  (A1),D0                         ; $0005B0
        MOVE.W  #$8000,D0                       ; $0005B2
        MOVE.W  #$0100,D1                       ; $0005B6
loc_0005BA:
        MOVE.W  #$0012,D7                       ; $0005BA
loc_0005BE:
        MOVE.B  (A0)+,D0                        ; $0005BE
loc_0005C0:
        MOVE.W  D0,(A1)                         ; $0005C0
loc_0005C2:
        ADD.W  D1,D0                            ; $0005C2
        DBRA    D7,loc_0005BE                   ; $0005C4
        MOVEM.L (A7)+,D0/D1/A1                  ; $0005C8
        RTS                                     ; $0005CC
loc_0005CE:
        MOVEM.L D0/D7/A0/A1,-(A7)               ; $0005CE
        LEA     $0000063E,A0                    ; $0005D2
        LEA     $00C00004,A1                    ; $0005D8
        MOVE.W  (A0)+,(A1)                      ; $0005DE
        MOVE.W  (A0)+,(A1)                      ; $0005E0
        MOVE.W  (A0)+,(A1)                      ; $0005E2
        MOVE.W  (A0)+,(A1)                      ; $0005E4
        MOVE.W  (A0)+,(A1)                      ; $0005E6
        MOVE.W  (A0)+,(A1)                      ; $0005E8
        MOVE.W  (A0)+,(A1)                      ; $0005EA
        MOVE.L  (A0)+,(A1)                      ; $0005EC
        MOVE.W  D1,-$0004(A1)                   ; $0005EE
loc_0005F2:
        MOVE.W  (A1),D0                         ; $0005F2
        BTST    #1,D0                           ; $0005F4
        BNE.S  loc_0005F2                       ; $0005F8
        MOVE.W  (A0)+,(A1)                      ; $0005FA
        MOVE.W  (A0)+,(A1)                      ; $0005FC
        MOVEQ   #$00,D0                         ; $0005FE
        MOVE.L  #$C0000000,(A1)                 ; $000600
        MOVEQ   #$0F,D7                         ; $000606
loc_000608:
        MOVE.W  D0,-$0004(A1)                   ; $000608
        MOVE.W  D0,-$0004(A1)                   ; $00060C
        MOVE.W  D0,-$0004(A1)                   ; $000610
        MOVE.W  D0,-$0004(A1)                   ; $000614
        DBRA    D7,loc_000608                   ; $000618
        MOVE.L  #$40000010,(A1)                 ; $00061C
        MOVEQ   #$09,D7                         ; $000622
loc_000624:
        MOVE.W  D0,-$0004(A1)                   ; $000624
        MOVE.W  D0,-$0004(A1)                   ; $000628
        MOVE.W  D0,-$0004(A1)                   ; $00062C
        MOVE.W  D0,-$0004(A1)                   ; $000630
        DBRA    D7,loc_000624                   ; $000634
        MOVEM.L (A7)+,D0/D7/A0/A1               ; $000638
        RTS                                     ; $00063C
        OR.B   D0,(A4)                          ; $00063E
        OR.B   D7,D1                            ; $000640
        DC.W    $93FF                           ; $000642
        DC.W    $94FF                           ; $000644
        SUB.B  D2,D0                            ; $000646
        SUB.B  D0,D3                            ; $000648
        SUB.L  D3,D0                            ; $00064A
        NEGX.B D0                               ; $00064C
        ORI.L  #$81048F02,D0                    ; $00064E
loc_000654:
        MOVEM.L D0/D1/D7/A1,-(A7)               ; $000654
        LEA     $00A15180,A1                    ; $000658
loc_00065E:
        BCLR    #7,-$0080(A1)                   ; $00065E
        BNE.S  loc_00065E                       ; $000664
        MOVE.W  #$00FF,D7                       ; $000666
        MOVEQ   #$00,D0                         ; $00066A
        MOVEQ   #$00,D1                         ; $00066C
        MOVE.W  #$00FF,$0004(A1)                ; $00066E
loc_000674:
        MOVE.W  D1,$0006(A1)                    ; $000674
        MOVE.W  D0,$0008(A1)                    ; $000678
        NOP                                     ; $00067C
loc_00067E:
        BTST    #1,$000B(A1)                    ; $00067E
        BNE.S  loc_00067E                       ; $000684
        ADDI.W  #$0100,D1                       ; $000686
        DBRA    D7,loc_000674                   ; $00068A
        MOVEM.L (A7)+,D0/D1/D7/A1               ; $00068E
        RTS                                     ; $000692
loc_000694:
        MOVEM.L D0/D7/A0,-(A7)                  ; $000694
        LEA     $00A15200,A0                    ; $000698
loc_00069E:
        BCLR    #7,-$0100(A0)                   ; $00069E
        BNE.S  loc_00069E                       ; $0006A4
        MOVE.W  #$001F,D7                       ; $0006A6
loc_0006AA:
        MOVE.L  D0,(A0)+                        ; $0006AA
        MOVE.L  D0,(A0)+                        ; $0006AC
        MOVE.L  D0,(A0)+                        ; $0006AE
        MOVE.L  D0,(A0)+                        ; $0006B0
        DBRA    D7,loc_0006AA                   ; $0006B2
        MOVEM.L (A7)+,D0/D7/A0                  ; $0006B6
        RTS                                     ; $0006BA
        LEA     $00FF0000,A0                    ; $0006BC
        MOVE.W  #$07FF,D7                       ; $0006C2
        MOVEQ   #$00,D0                         ; $0006C6
loc_0006C8:
        MOVE.L  D0,(A0)+                        ; $0006C8
        MOVE.L  D0,(A0)+                        ; $0006CA
        MOVE.L  D0,(A0)+                        ; $0006CC
        MOVE.L  D0,(A0)+                        ; $0006CE
        MOVE.L  D0,(A0)+                        ; $0006D0
        MOVE.L  D0,(A0)+                        ; $0006D2
        MOVE.L  D0,(A0)+                        ; $0006D4
        MOVE.L  D0,(A0)+                        ; $0006D6
        DBRA    D7,loc_0006C8                   ; $0006D8
        MOVE.W  #$0000,$1200(A5)                ; $0006DC
        MOVEQ   #$0A,D7                         ; $0006E2
loc_0006E4:
        DBRA    D7,loc_0006E4                   ; $0006E4
        LEA     $00A15100,A1                    ; $0006E8
        MOVEQ   #$00,D0                         ; $0006EE
        MOVE.L  D0,$0020(A1)                    ; $0006F0
        MOVE.L  D0,$0024(A1)                    ; $0006F4
        MOVE.B  #$03,$5101(A5)                  ; $0006F8
        MOVEA.L $00880000,A7                    ; $0006FE
loc_000704:
        BCLR    #7,(A1)                         ; $000704
        BNE.S  loc_000704                       ; $000708
        MOVEQ   #$00,D0                         ; $00070A
        MOVE.W  D0,$0002(A1)                    ; $00070C
        MOVE.W  D0,$0004(A1)                    ; $000710
        MOVE.W  D0,$0006(A1)                    ; $000714
        MOVE.L  D0,$0008(A1)                    ; $000718
        MOVE.L  D0,$000C(A1)                    ; $00071C
        MOVE.W  D0,$0010(A1)                    ; $000720
        MOVE.W  D0,$0030(A1)                    ; $000724
        MOVE.W  D0,$0032(A1)                    ; $000728
        MOVE.W  D0,$0038(A1)                    ; $00072C
        MOVE.W  D0,$0080(A1)                    ; $000730
        MOVE.W  D0,$0082(A1)                    ; $000734
loc_000738:
        BCLR    #0,$008B(A1)                    ; $000738
        BNE.S  loc_000738                       ; $00073E
        BSR.W  loc_000654                       ; $000740
loc_000744:
        BSET    #0,$008B(A1)                    ; $000744
        BEQ.S  loc_000744                       ; $00074A
        BSR.W  loc_000654                       ; $00074C
        BCLR    #0,$008B(A1)                    ; $000750
        BSR.W  loc_000694                       ; $000756
        MOVE.W  #$0040,D0                       ; $00075A
        MOVE.L  $0020(A1),D1                    ; $00075E
        CMPI.L  #$53514552,D1                   ; $000762
        BEQ.W  loc_0007FC                       ; $000768
        MOVE.W  #$0080,D0                       ; $00076C
        MOVE.L  $0020(A1),D1                    ; $000770
        CMPI.L  #$53444552,D1                   ; $000774
        BEQ.W  loc_0007FC                       ; $00077A
        MOVE.L  #$008802A2,($0070).W            ; $00077E
        MOVE.W  #$0002,D0                       ; $000786
        MOVEQ   #$00,D1                         ; $00078A
        MOVE.B  $0001(A5),D1                    ; $00078C
        MOVE.B  $0080(A1),D2                    ; $000790
        LSL.W  #8,D2                            ; $000794
        OR.W   D2,D1                            ; $000796
        BTST    #15,D1                          ; $000798
        BNE.S  loc_0007A8                       ; $00079C
        BTST    #6,D1                           ; $00079E
        BEQ.W  loc_0007FC                       ; $0007A2
        BRA.S  loc_0007B0                       ; $0007A6
loc_0007A8:
        BTST    #6,D1                           ; $0007A8
        BNE.W  loc_0007FC                       ; $0007AC
loc_0007B0:
        MOVEQ   #$20,D0                         ; $0007B0
        LEA     $00880000,A0                    ; $0007B2
        MOVE.W  $018E(A0),D6                    ; $0007B8
        TST.W  D6                               ; $0007BC
        BEQ.W  loc_0007D0                       ; $0007BE
loc_0007C2:
        MOVE.W  $0028(A1),D2                    ; $0007C2
        CMPI.W  #$0000,D2                       ; $0007C6
        BEQ.S  loc_0007C2                       ; $0007CA
        CMP.W  D6,D2                            ; $0007CC
        BNE.S  loc_0007FC                       ; $0007CE
loc_0007D0:
        MOVEQ   #$00,D0                         ; $0007D0
        MOVE.L  D0,$0028(A1)                    ; $0007D2
        MOVE.L  D0,$002C(A1)                    ; $0007D6
        MOVE.W  (A4),D7                         ; $0007DA
        MOVEA.L #$FFFFFFC0,A6                   ; $0007DC
        MOVEM.L (A6),D0/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6; $0007E2
        MOVE    #$0000,CCR                      ; $0007E6
        BRA.S  loc_000800                       ; $0007EA
loc_0007EC:
        LEA     $00A15100,A1                    ; $0007EC
        MOVE.W  D0,$0006(A1)                    ; $0007F2
        MOVE.W  #$8000,D0                       ; $0007F6
        BRA.S  loc_000800                       ; $0007FA
loc_0007FC:
        MOVE    #$0001,CCR                      ; $0007FC
loc_000800:
        BCS.S  loc_00082A                       ; $000800
        LEA     $00A15120,A0                    ; $000802
loc_000808:
        CMPI.L  #$4D5F4F4B,(A0)                 ; $000808
        BNE.S  loc_000808                       ; $00080E
loc_000810:
        CMPI.L  #$535F4F4B,$0004(A0)            ; $000810
        BNE.S  loc_000810                       ; $000818
        MOVE.L  #$00000000,(A0)                 ; $00081A
        BTST    #15,D0                          ; $000820
        BNE.S  loc_000838                       ; $000824
        BRA.W  loc_000A88                       ; $000826
loc_00082A:
        BTST    #5,D0                           ; $00082A
        BNE.W  loc_000EA8                       ; $00082E
        NOP                                     ; $000832
        NOP                                     ; $000834
        BRA.S  loc_00082A                       ; $000836
loc_000838:
; ----------------------------------------------------------------------------
; adapter_init ($000838) - 32X adapter initialization
; ----------------------------------------------------------------------------
adapter_init:
        LEA     $00A15100,A4                    ; $000838
        BTST    #0,$0001(A4)                    ; $00083E
        BEQ.S  loc_000866                       ; $000844
        BTST    #1,$0001(A4)                    ; $000846
        BNE.S  loc_0008A8                       ; $00084C
        LEA     $00A10000,A5                    ; $00084E
        MOVEA.L #$FFFFFFC0,A4                   ; $000854
        MOVE.W  #$0F3C,D7                       ; $00085A
        LEA     $008806E4,A1                    ; $00085E
        JMP     (A1)                            ; $000864
loc_000866:
        MOVE.L  #$00000000,$00A15128            ; $000866
        LEA     $00880894,A0                    ; $000870
        LEA     $00FF0000,A1                    ; $000876
        MOVE.L  (A0)+,(A1)+                     ; $00087C
        MOVE.L  (A0)+,(A1)+                     ; $00087E
        MOVE.L  (A0)+,(A1)+                     ; $000880
        MOVE.L  (A0)+,(A1)+                     ; $000882
        MOVE.L  (A0)+,(A1)+                     ; $000884
        MOVE.L  (A0)+,(A1)+                     ; $000886
        MOVE.L  (A0)+,(A1)+                     ; $000888
        MOVE.L  (A0)+,(A1)+                     ; $00088A
        LEA     $00FF0000,A0                    ; $00088C
        JMP     (A0)                            ; $000892
        MOVE.B  #$01,$0001(A4)                  ; $000894
        LEA     $0088084E,A0                    ; $00089A
        ADDA.L  #$00880000,A0                   ; $0008A0
        JMP     (A0)                            ; $0008A6
loc_0008A8:
        MOVE.W  #$1000,D7                       ; $0008A8
loc_0008AC:
        CMPI.L  #$56524553,$00A1512C            ; $0008AC
        DBEQ    D7,loc_0008AC                   ; $0008B6
        BEQ.W  loc_0009B6                       ; $0008BA
        JSR     $00263E(PC)                     ; $0008BE
        ORI.B  #$03,$00A15103                   ; $0008C2
        LEA     $00A15120,A0                    ; $0008CA
loc_0008D0:
        CMPI.L  #$4D5F4F4B,(A0)                 ; $0008D0
        BNE.S  loc_0008D0                       ; $0008D6
loc_0008D8:
        CMPI.L  #$535F4F4B,$0004(A0)            ; $0008D8
        BNE.S  loc_0008D8                       ; $0008E0
        MOVE.L  #$00000000,(A0)                 ; $0008E2
        MOVE    SR,-(A7)                        ; $0008E8
        MOVE    #$2700,SR                       ; $0008EA
        MOVE.W  #$0100,$00A11100                ; $0008EE
        MOVE.W  #$0100,$00A11200                ; $0008F6
loc_0008FE:
        BTST    #0,$00A11100                    ; $0008FE
        BNE.S  loc_0008FE                       ; $000906
        LEA     $00A00000,A1                    ; $000908
        MOVE.B  #$F3,(A1)+                      ; $00090E
        MOVE.B  #$F3,(A1)+                      ; $000912
        MOVE.B  #$C3,(A1)+                      ; $000916
        MOVE.B  #$00,(A1)+                      ; $00091A
        MOVE.B  #$00,(A1)+                      ; $00091E
        MOVE.W  #$0000,$00A11200                ; $000922
        NOP                                     ; $00092A
        NOP                                     ; $00092C
        NOP                                     ; $00092E
        NOP                                     ; $000930
        NOP                                     ; $000932
        NOP                                     ; $000934
        NOP                                     ; $000936
        NOP                                     ; $000938
        NOP                                     ; $00093A
        NOP                                     ; $00093C
        NOP                                     ; $00093E
        NOP                                     ; $000940
        NOP                                     ; $000942
        NOP                                     ; $000944
        MOVE.W  #$0000,$00A11100                ; $000946
        MOVE.W  #$0100,$00A11200                ; $00094E
        MOVE    (A7)+,SR                        ; $000956
        MOVEQ   #-$01,D0                        ; $000958
        MOVE.B  D0,$00C00011                    ; $00095A
        NOP                                     ; $000960
        NOP                                     ; $000962
        SUBI.B  #$20,D0                         ; $000964
        MOVE.B  D0,$00C00011                    ; $000968
        NOP                                     ; $00096E
        NOP                                     ; $000970
        SUBI.B  #$20,D0                         ; $000972
        MOVE.B  D0,$00C00011                    ; $000976
        NOP                                     ; $00097C
        NOP                                     ; $00097E
        SUBI.B  #$20,D0                         ; $000980
        MOVE.B  D0,$00C00011                    ; $000984
        MOVE.W  #$0100,$00A11100                ; $00098A
loc_000992:
        BTST    #0,$00A11100                    ; $000992
        BNE.S  loc_000992                       ; $00099A
        LEA     $00A130F1,A1                    ; $00099C
        TST.B  (A1)                             ; $0009A2
        MOVEQ   #$00,D0                         ; $0009A4
        JSR     ($00C0).W                       ; $0009A6
        MOVE.W  #$0000,$00A11100                ; $0009AA
        JMP     loc_000B6A(PC)                  ; $0009B2
loc_0009B6:
        MOVE    SR,-(A7)                        ; $0009B6
        MOVE    #$2700,SR                       ; $0009B8
        MOVE.W  #$0100,$00A11100                ; $0009BC
        MOVE.W  #$0100,$00A11200                ; $0009C4
loc_0009CC:
        BTST    #0,$00A11100                    ; $0009CC
        BNE.S  loc_0009CC                       ; $0009D4
        LEA     $00A00000,A1                    ; $0009D6
        MOVE.B  #$F3,(A1)+                      ; $0009DC
        MOVE.B  #$F3,(A1)+                      ; $0009E0
        MOVE.B  #$C3,(A1)+                      ; $0009E4
        MOVE.B  #$00,(A1)+                      ; $0009E8
        MOVE.B  #$00,(A1)+                      ; $0009EC
        MOVE.W  #$0000,$00A11200                ; $0009F0
        NOP                                     ; $0009F8
        NOP                                     ; $0009FA
        NOP                                     ; $0009FC
        NOP                                     ; $0009FE
        NOP                                     ; $000A00
        NOP                                     ; $000A02
        NOP                                     ; $000A04
        NOP                                     ; $000A06
        NOP                                     ; $000A08
        NOP                                     ; $000A0A
        NOP                                     ; $000A0C
        NOP                                     ; $000A0E
        NOP                                     ; $000A10
        NOP                                     ; $000A12
        MOVE.W  #$0000,$00A11100                ; $000A14
        MOVE.W  #$0100,$00A11200                ; $000A1C
        MOVE    (A7)+,SR                        ; $000A24
        MOVEQ   #-$01,D0                        ; $000A26
        MOVE.B  D0,$00C00011                    ; $000A28
        NOP                                     ; $000A2E
        NOP                                     ; $000A30
        SUBI.B  #$20,D0                         ; $000A32
        MOVE.B  D0,$00C00011                    ; $000A36
        NOP                                     ; $000A3C
        NOP                                     ; $000A3E
        SUBI.B  #$20,D0                         ; $000A40
        MOVE.B  D0,$00C00011                    ; $000A44
        NOP                                     ; $000A4A
        NOP                                     ; $000A4C
        SUBI.B  #$20,D0                         ; $000A4E
        MOVE.B  D0,$00C00011                    ; $000A52
        MOVE.W  #$0100,$00A11100                ; $000A58
loc_000A60:
        BTST    #0,$00A11100                    ; $000A60
        BNE.S  loc_000A60                       ; $000A68
        LEA     $00A130F1,A1                    ; $000A6A
        TST.B  (A1)                             ; $000A70
        MOVEQ   #$00,D0                         ; $000A72
        JSR     ($00C0).W                       ; $000A74
        MOVE.W  #$0000,$00A11100                ; $000A78
        JSR     $00263E(PC)                     ; $000A80
        JMP     loc_000B6A(PC)                  ; $000A84
loc_000A88:
        MOVE    SR,-(A7)                        ; $000A88
        MOVE    #$2700,SR                       ; $000A8A
        MOVE.W  #$0100,$00A11100                ; $000A8E
        MOVE.W  #$0100,$00A11200                ; $000A96
loc_000A9E:
        BTST    #0,$00A11100                    ; $000A9E
        BNE.S  loc_000A9E                       ; $000AA6
        LEA     $00A00000,A1                    ; $000AA8
        MOVE.B  #$F3,(A1)+                      ; $000AAE
        MOVE.B  #$F3,(A1)+                      ; $000AB2
        MOVE.B  #$C3,(A1)+                      ; $000AB6
        MOVE.B  #$00,(A1)+                      ; $000ABA
        MOVE.B  #$00,(A1)+                      ; $000ABE
        MOVE.W  #$0000,$00A11200                ; $000AC2
        NOP                                     ; $000ACA
        NOP                                     ; $000ACC
        NOP                                     ; $000ACE
        NOP                                     ; $000AD0
        NOP                                     ; $000AD2
        NOP                                     ; $000AD4
        NOP                                     ; $000AD6
        NOP                                     ; $000AD8
        NOP                                     ; $000ADA
        NOP                                     ; $000ADC
        NOP                                     ; $000ADE
        NOP                                     ; $000AE0
        NOP                                     ; $000AE2
        NOP                                     ; $000AE4
        MOVE.W  #$0000,$00A11100                ; $000AE6
        MOVE.W  #$0100,$00A11200                ; $000AEE
        MOVE    (A7)+,SR                        ; $000AF6
        MOVEQ   #-$01,D0                        ; $000AF8
        MOVE.B  D0,$00C00011                    ; $000AFA
        NOP                                     ; $000B00
        NOP                                     ; $000B02
        SUBI.B  #$20,D0                         ; $000B04
        MOVE.B  D0,$00C00011                    ; $000B08
        NOP                                     ; $000B0E
        NOP                                     ; $000B10
        SUBI.B  #$20,D0                         ; $000B12
        MOVE.B  D0,$00C00011                    ; $000B16
        NOP                                     ; $000B1C
        NOP                                     ; $000B1E
        SUBI.B  #$20,D0                         ; $000B20
        MOVE.B  D0,$00C00011                    ; $000B24
        MOVE.W  #$0100,$00A11100                ; $000B2A
loc_000B32:
        BTST    #0,$00A11100                    ; $000B32
        BNE.S  loc_000B32                       ; $000B3A
        LEA     $00A130F1,A1                    ; $000B3C
        TST.B  (A1)                             ; $000B42
        MOVEQ   #$00,D0                         ; $000B44
        JSR     ($00C0).W                       ; $000B46
        MOVE.W  #$0000,$00A11100                ; $000B4A
        MOVE.W  #$0001,$00A15104                ; $000B52
        LEA     $00C00000,A6                    ; $000B5A
        LEA     $00C00004,A5                    ; $000B60
        JSR     loc_000C80(PC)                  ; $000B66
loc_000B6A:
        JSR     loc_000C48(PC)                  ; $000B6A
        JSR     loc_000C5A(PC)                  ; $000B6E
        LEA     $00C00000,A6                    ; $000B72
        LEA     $00C00004,A5                    ; $000B78
        MOVE    SR,-(A7)                        ; $000B7E
        MOVE    #$2700,SR                       ; $000B80
        MOVE.W  #$0100,$00A11100                ; $000B84
        MOVE.W  #$0100,$00A11200                ; $000B8C
loc_000B94:
        BTST    #0,$00A11100                    ; $000B94
        BNE.S  loc_000B94                       ; $000B9C
        LEA     $00A00000,A1                    ; $000B9E
        MOVE.B  #$F3,(A1)+                      ; $000BA4
        MOVE.B  #$F3,(A1)+                      ; $000BA8
        MOVE.B  #$C3,(A1)+                      ; $000BAC
        MOVE.B  #$00,(A1)+                      ; $000BB0
        MOVE.B  #$00,(A1)+                      ; $000BB4
        MOVE.W  #$0000,$00A11200                ; $000BB8
        NOP                                     ; $000BC0
        NOP                                     ; $000BC2
        NOP                                     ; $000BC4
        NOP                                     ; $000BC6
        NOP                                     ; $000BC8
        NOP                                     ; $000BCA
        NOP                                     ; $000BCC
        NOP                                     ; $000BCE
        NOP                                     ; $000BD0
        NOP                                     ; $000BD2
        NOP                                     ; $000BD4
        NOP                                     ; $000BD6
        NOP                                     ; $000BD8
        NOP                                     ; $000BDA
        MOVE.W  #$0000,$00A11100                ; $000BDC
        MOVE.W  #$0100,$00A11200                ; $000BE4
        MOVE    (A7)+,SR                        ; $000BEC
        MOVEQ   #-$01,D0                        ; $000BEE
        MOVE.B  D0,$00C00011                    ; $000BF0
        NOP                                     ; $000BF6
        NOP                                     ; $000BF8
        SUBI.B  #$20,D0                         ; $000BFA
        MOVE.B  D0,$00C00011                    ; $000BFE
        NOP                                     ; $000C04
        NOP                                     ; $000C06
        SUBI.B  #$20,D0                         ; $000C08
        MOVE.B  D0,$00C00011                    ; $000C0C
        NOP                                     ; $000C12
        NOP                                     ; $000C14
        SUBI.B  #$20,D0                         ; $000C16
        MOVE.B  D0,$00C00011                    ; $000C1A
        JSR     loc_00203A(PC)                  ; $000C20
        JSR     loc_000D68(PC)                  ; $000C24
        JSR     loc_000DC4(PC)                  ; $000C28
        JSR     $0088C85C                       ; $000C2C
        JSR     $00880FBE                       ; $000C32
        MOVE.L  #$00894262,$00FF0002            ; $000C38
        JMP     $00FF0000                       ; $000C42
loc_000C48:
        NOP                                     ; $000C48
        NOP                                     ; $000C4A
        MOVE.W  $00C00004,D0                    ; $000C4C
        BTST    #1,D0                           ; $000C52
        BNE.S  loc_000C48                       ; $000C56
        RTS                                     ; $000C58
loc_000C5A:
; ----------------------------------------------------------------------------
; save_all_registers ($000C5A) - Save D0-D7/A0-A6 to memory
; ----------------------------------------------------------------------------
save_all_registers:
        LEA     $000C70(PC),A6                  ; $000C5A
        MOVEM.L (A6),D0/D1/D2/D3                ; $000C5E
        MOVEM.L (A6),D4/D5/D6/D7                ; $000C62
        MOVEM.L (A6),A0/A1/A2/A3                ; $000C66
        MOVEM.L (A6),A4/A5/A6                   ; $000C6A
        RTS                                     ; $000C6E
        ORI.B  #$00,D0                          ; $000C70
        ORI.B  #$00,D0                          ; $000C74
        ORI.B  #$00,D0                          ; $000C78
        ORI.B  #$00,D0                          ; $000C7C
loc_000C80:
        MOVE    SR,-(A7)                        ; $000C80
        MOVE    #$2700,SR                       ; $000C82
        MOVE.W  #$0100,$00A11100                ; $000C86
        MOVE.W  #$0100,$00A11200                ; $000C8E
loc_000C96:
        BTST    #0,$00A11100                    ; $000C96
        BNE.S  loc_000C96                       ; $000C9E
        LEA     $00A00000,A1                    ; $000CA0
        MOVE.B  #$F3,(A1)+                      ; $000CA6
        MOVE.B  #$F3,(A1)+                      ; $000CAA
        MOVE.B  #$C3,(A1)+                      ; $000CAE
        MOVE.B  #$00,(A1)+                      ; $000CB2
        MOVE.B  #$00,(A1)+                      ; $000CB6
        MOVE.W  #$0000,$00A11200                ; $000CBA
        NOP                                     ; $000CC2
        NOP                                     ; $000CC4
        NOP                                     ; $000CC6
        NOP                                     ; $000CC8
        NOP                                     ; $000CCA
        NOP                                     ; $000CCC
        NOP                                     ; $000CCE
        NOP                                     ; $000CD0
        NOP                                     ; $000CD2
        NOP                                     ; $000CD4
        NOP                                     ; $000CD6
        NOP                                     ; $000CD8
        NOP                                     ; $000CDA
        NOP                                     ; $000CDC
        MOVE.W  #$0000,$00A11100                ; $000CDE
        MOVE.W  #$0100,$00A11200                ; $000CE6
        MOVE    (A7)+,SR                        ; $000CEE
        MOVEQ   #-$01,D0                        ; $000CF0
        MOVE.B  D0,$00C00011                    ; $000CF2
        NOP                                     ; $000CF8
        NOP                                     ; $000CFA
        SUBI.B  #$20,D0                         ; $000CFC
        MOVE.B  D0,$00C00011                    ; $000D00
        NOP                                     ; $000D06
        NOP                                     ; $000D08
        SUBI.B  #$20,D0                         ; $000D0A
        MOVE.B  D0,$00C00011                    ; $000D0E
        NOP                                     ; $000D14
        NOP                                     ; $000D16
        SUBI.B  #$20,D0                         ; $000D18
        MOVE.B  D0,$00C00011                    ; $000D1C
        LEA     (-13920).W,A1                   ; $000D22
        MOVEQ   #$00,D1                         ; $000D26
        MOVE.W  #$0D57,D7                       ; $000D28
loc_000D2C:
        MOVE.L  D1,(A1)+                        ; $000D2C
        DBRA    D7,loc_000D2C                   ; $000D2E
        MOVE.B  $00A10001,D0                    ; $000D32
        MOVE.B  D0,(-4348).W                    ; $000D38
        BTST    #7,D0                           ; $000D3C
        SNE     (-4347).W                       ; $000D40
        BTST    #6,D0                           ; $000D44
        SNE     (-4346).W                       ; $000D48
        JSR     $0088C7E8                       ; $000D4C
        JSR     loc_0018D8(PC)                  ; $000D52
        JSR     loc_00170C(PC)                  ; $000D56
        MOVE.B  #$01,(-599).W                   ; $000D5A
        MOVE.B  (-14312).W,(-348).W             ; $000D60
        RTS                                     ; $000D66
loc_000D68:
; ----------------------------------------------------------------------------
; warm_boot_init ($000D68) - Warm boot/soft reset sequence
; ----------------------------------------------------------------------------
warm_boot_init:
        JSR     loc_000DB0(PC)                  ; $000D68
        JSR     loc_000FEA(PC)                  ; $000D6C
        MOVE.B  (-348).W,D0                     ; $000D70
        CMP.B  (-14312).W,D0                    ; $000D74
        BEQ.S  loc_000D84                       ; $000D78
        JSR     loc_00170C(PC)                  ; $000D7A
        MOVE.B  (-14312).W,(-348).W             ; $000D7E
loc_000D84:
        JSR     $001048(PC)                     ; $000D84
        MOVE.W  #$0083,$00A15100                ; $000D88
        ANDI.B  #$FC,$00A15181                  ; $000D90
        JSR     $0088266C                       ; $000D98
        JSR     $008826C8                       ; $000D9E
        LEA     $008BA020,A2                    ; $000DA4
        JMP     $0088284C                       ; $000DAA
loc_000DB0:
        LEA     $00FF1000,A1                    ; $000DB0
        MOVEQ   #$00,D1                         ; $000DB6
        MOVE.W  #$2E67,D7                       ; $000DB8
loc_000DBC:
        MOVE.L  D1,(A1)+                        ; $000DBC
        DBRA    D7,loc_000DBC                   ; $000DBE
        RTS                                     ; $000DC2
loc_000DC4:
; ----------------------------------------------------------------------------
; sound_update_check ($000DC4) - Conditional FM/DMA sound update
; ----------------------------------------------------------------------------
sound_update_check:
        TST.B  (-4347).W                        ; $000DC4
        BEQ.S  loc_000DD2                       ; $000DC8
        TST.B  (-4346).W                        ; $000DCA
        BNE.S  loc_000DD2                       ; $000DCE
        RTS                                     ; $000DD0
loc_000DD2:
        MOVEQ   #$04,D0                         ; $000DD2
        JSR     $008814BE                       ; $000DD4
        MOVEQ   #$0A,D1                         ; $000DDA
        JSR     $0088155E                       ; $000DDC
        MOVE.W  #$0100,$00A11100                ; $000DE2
loc_000DEA:
        BTST    #0,$00A11100                    ; $000DEA
        BNE.S  loc_000DEA                       ; $000DF2
        MOVE.W  #$8C00,(A5)                     ; $000DF4
        MOVE.W  #$9010,(A5)                     ; $000DF8
        MOVE.W  (-14220).W,D4                   ; $000DFC
        BSET    #4,D4                           ; $000E00
        MOVE.W  D4,(A5)                         ; $000E04
        MOVE.L  #$93809403,(A5)                 ; $000E06
        MOVE.L  #$95009688,(A5)                 ; $000E0C
        MOVE.W  #$977F,(A5)                     ; $000E12
        MOVE.W  #$4000,(A5)                     ; $000E16
        MOVE.W  #$0083,(-14218).W               ; $000E1A
        MOVE.W  (-14218).W,(A5)                 ; $000E20
        MOVE.W  (-14220).W,(A5)                 ; $000E24
        MOVE.W  (-14220).W,D4                   ; $000E28
        BSET    #4,D4                           ; $000E2C
        MOVE.W  D4,(A5)                         ; $000E30
        MOVE.L  #$93409400,(A5)                 ; $000E32
        MOVE.L  #$954096C2,(A5)                 ; $000E38
        MOVE.W  #$977F,(A5)                     ; $000E3E
        MOVE.W  #$C000,(A5)                     ; $000E42
        MOVE.W  #$0080,(-14218).W               ; $000E46
        MOVE.W  (-14218).W,(A5)                 ; $000E4C
        MOVE.W  (-14220).W,(A5)                 ; $000E50
        BCLR    #6,(-14322).W                   ; $000E54
        MOVE.L  #$008BB4DC,(-13972).W           ; $000E5A
        MOVE.B  #$01,(-14327).W                 ; $000E62
        MOVE.B  #$01,(-14326).W                 ; $000E68
        BSET    #6,(-14322).W                   ; $000E6E
        MOVE.B  #$01,(-14334).W                 ; $000E74
        BSET    #6,(-14219).W                   ; $000E7A
        MOVE.W  (-14220).W,(A5)                 ; $000E80
loc_000E84:
        JSR     $0088B684                       ; $000E84
        JSR     $00884998                       ; $000E8A
        BTST    #6,(-14322).W                   ; $000E90
        BNE.S  loc_000E84                       ; $000E96
        NOP                                     ; $000E98
        NOP                                     ; $000E9A
        NOP                                     ; $000E9C
        DIVU    #$0000,D0                       ; $000E9E
        NOP                                     ; $000EA2
        NOP                                     ; $000EA4
        NOP                                     ; $000EA6
loc_000EA8:
        MOVE    SR,-(A7)                        ; $000EA8
        MOVE    #$2700,SR                       ; $000EAA
        MOVE.W  #$0100,$00A11100                ; $000EAE
        MOVE.W  #$0100,$00A11200                ; $000EB6
loc_000EBE:
        BTST    #0,$00A11100                    ; $000EBE
        BNE.S  loc_000EBE                       ; $000EC6
        LEA     $00A00000,A1                    ; $000EC8
        MOVE.B  #$F3,(A1)+                      ; $000ECE
        MOVE.B  #$F3,(A1)+                      ; $000ED2
        MOVE.B  #$C3,(A1)+                      ; $000ED6
        MOVE.B  #$00,(A1)+                      ; $000EDA
        MOVE.B  #$00,(A1)+                      ; $000EDE
        MOVE.W  #$0000,$00A11200                ; $000EE2
        NOP                                     ; $000EEA
        NOP                                     ; $000EEC
        NOP                                     ; $000EEE
        NOP                                     ; $000EF0
        NOP                                     ; $000EF2
        NOP                                     ; $000EF4
        NOP                                     ; $000EF6
        NOP                                     ; $000EF8
        NOP                                     ; $000EFA
        NOP                                     ; $000EFC
        NOP                                     ; $000EFE
        NOP                                     ; $000F00
        NOP                                     ; $000F02
        NOP                                     ; $000F04
        MOVE.W  #$0000,$00A11100                ; $000F06
        MOVE.W  #$0100,$00A11200                ; $000F0E
        MOVE    (A7)+,SR                        ; $000F16
        MOVEQ   #-$01,D0                        ; $000F18
        MOVE.B  D0,$00C00011                    ; $000F1A
        NOP                                     ; $000F20
        NOP                                     ; $000F22
        SUBI.B  #$20,D0                         ; $000F24
        MOVE.B  D0,$00C00011                    ; $000F28
        NOP                                     ; $000F2E
        NOP                                     ; $000F30
        SUBI.B  #$20,D0                         ; $000F32
        MOVE.B  D0,$00C00011                    ; $000F36
        NOP                                     ; $000F3C
        NOP                                     ; $000F3E
        SUBI.B  #$20,D0                         ; $000F40
        MOVE.B  D0,$00C00011                    ; $000F44
        MOVE.W  #$0100,$00A11100                ; $000F4A
loc_000F52:
        BTST    #0,$00A11100                    ; $000F52
        BNE.S  loc_000F52                       ; $000F5A
        MOVE.L  D1,-(A7)                        ; $000F5C
        JSR     loc_000FEA(PC)                  ; $000F5E
        MOVE.L  (A7)+,D1                        ; $000F62
        MOVE.L  #$C0000000,(A5)                 ; $000F64
        MOVEQ   #$3F,D7                         ; $000F6A
        MOVEQ   #$0E,D6                         ; $000F6C
loc_000F6E:
        MOVE.W  D6,$00C00000                    ; $000F6E
        DBRA    D7,loc_000F6E                   ; $000F74
        BSET    #6,(-14219).W                   ; $000F78
        MOVE.W  (-14220).W,(A5)                 ; $000F7E
        NOP                                     ; $000F82
        NOP                                     ; $000F84
        NOP                                     ; $000F86
        DIVU    #$0000,D0                       ; $000F88
        NOP                                     ; $000F8C
        NOP                                     ; $000F8E
        NOP                                     ; $000F90
loc_000F92:
        JSR     $00894262                       ; $000F92
        MOVE.W  #$0004,(-14214).W               ; $000F98
        MOVE    #$2300,SR                       ; $000F9E
loc_000FA2:
        TST.W  (-14214).W                       ; $000FA2
        BNE.S  loc_000FA2                       ; $000FA6
        BRA.S  loc_000F92                       ; $000FA8
loc_000FAA:
        JSR     $00884CBC                       ; $000FAA
        BSET    #0,(-14331).W                   ; $000FB0
loc_000FB6:
        TST.B  (-14331).W                       ; $000FB6
        BNE.S  loc_000FB6                       ; $000FBA
        BRA.S  loc_000FAA                       ; $000FBC
        MOVEQ   #$0B,D7                         ; $000FBE
        LEA     $000F92(PC),A0                  ; $000FC0
        LEA     $00FF0000,A1                    ; $000FC4
        JMP     loc_000FDA(PC)                  ; $000FCA
        MOVEQ   #$09,D7                         ; $000FCE
        LEA     $000FAA(PC),A0                  ; $000FD0
        LEA     $00FF0000,A1                    ; $000FD4
loc_000FDA:
        MOVE    #$2700,SR                       ; $000FDA
loc_000FDE:
        MOVE.W  (A0)+,(A1)+                     ; $000FDE
        DBRA    D7,loc_000FDE                   ; $000FE0
        MOVE    #$2300,SR                       ; $000FE4
        RTS                                     ; $000FE8
loc_000FEA:
; ----------------------------------------------------------------------------
; z80_bus_vdp_init ($000FEA) - Z80 bus request + VDP register init
; ----------------------------------------------------------------------------
z80_bus_vdp_init:
        MOVE    SR,-(A7)                        ; $000FEA
        MOVE    #$2700,SR                       ; $000FEC
        MOVE.W  #$0100,$00A11100                ; $000FF0
loc_000FF8:
        BTST    #0,$00A11100                    ; $000FF8
        BNE.S  loc_000FF8                       ; $001000
        JSR     loc_0018D8(PC)                  ; $001002
        MOVE.W  #$0000,$00A11100                ; $001006
        MOVE    (A7)+,SR                        ; $00100E
        LEA     $001034(PC),A0                  ; $001010
        MOVE.B  #$81,(-14220).W                 ; $001014
        MOVE.B  $0001(A0),(-14219).W            ; $00101A
        MOVE.W  #$8000,D0                       ; $001020
        MOVEQ   #$12,D7                         ; $001024
loc_001026:
        MOVE.B  (A0)+,D0                        ; $001026
        MOVE.W  D0,(A5)                         ; $001028
        ADDI.W  #$0100,D0                       ; $00102A
        DBRA    D7,loc_001026                   ; $00102E
        RTS                                     ; $001032
        SUBI.B  #$3C,-(A4)                      ; $001034
        ADDI.W  #$0000,$00000700                ; $001038
        DC.W    $813B                           ; $001040
        ORI.B  #$00,D2                          ; $001042
        ORI.B  #$E7,D0                          ; $001046
        MOVE    #$2700,SR                       ; $00104A
        MOVE.W  #$0100,$00A11100                ; $00104E
loc_001056:
        BTST    #0,$00A11100                    ; $001056
        BNE.S  loc_001056                       ; $00105E
        MOVE.W  (-14220).W,D4                   ; $001060
        BSET    #4,D4                           ; $001064
        MOVE.W  D4,(A5)                         ; $001068
        MOVE.W  #$8F01,(A5)                     ; $00106A
        MOVE.L  #$93FF94FF,(A5)                 ; $00106E
        MOVE.W  #$9780,(A5)                     ; $001074
        MOVE.L  #$40000080,(A5)                 ; $001078
        MOVE.W  #$0000,(A6)                     ; $00107E
loc_001082:
        MOVE.W  (A5),D7                         ; $001082
        ANDI.W  #$0002,D7                       ; $001084
        BNE.S  loc_001082                       ; $001088
        MOVE.W  #$8F02,(A5)                     ; $00108A
        MOVE.W  (-14220).W,(A5)                 ; $00108E
        MOVE.W  #$0000,$00A11100                ; $001092
        MOVE    (A7)+,SR                        ; $00109A
        JSR     loc_0010AC(PC)                  ; $00109C
        MOVE.L  #$40000010,(A5)                 ; $0010A0
        MOVEQ   #$00,D1                         ; $0010A6
        JMP     $0048A8(PC)                     ; $0010A8
loc_0010AC:
        MOVE.L  #$C0000000,(A5)                 ; $0010AC
        MOVEQ   #$00,D1                         ; $0010B2
        JMP     $004888(PC)                     ; $0010B4
        MOVEQ   #$00,D1                         ; $0010B8
        MOVE.L  #$72000003,(A5)                 ; $0010BA
        MOVE.L  D1,(A6)                         ; $0010C0
        RTS                                     ; $0010C2
loc_0010C4:
; ----------------------------------------------------------------------------
; vdp_copy_rows ($0010C4) - Copy data rows to VDP
; ----------------------------------------------------------------------------
vdp_copy_rows:
        MOVE.L  #$01000000,D4                   ; $0010C4
loc_0010CA:
        MOVE.L  D0,(A5)                         ; $0010CA
        MOVE.W  D1,D3                           ; $0010CC
loc_0010CE:
        MOVE.W  (A0)+,(A6)                      ; $0010CE
        DBRA    D3,loc_0010CE                   ; $0010D0
        ADD.L  D4,D0                            ; $0010D4
        DBRA    D2,loc_0010CA                   ; $0010D6
        RTS                                     ; $0010DA
        MOVE.L  #$01000000,D4                   ; $0010DC
loc_0010E2:
        MOVE.L  D0,(A5)                         ; $0010E2
        MOVE.W  D1,D5                           ; $0010E4
loc_0010E6:
        MOVE.W  D3,(A6)                         ; $0010E6
        DBRA    D5,loc_0010E6                   ; $0010E8
        ADD.L  D4,D0                            ; $0010EC
        DBRA    D2,loc_0010E2                   ; $0010EE
        RTS                                     ; $0010F2
loc_0010F4:
; ----------------------------------------------------------------------------
; tile_decompress_init ($0010F4) - Initialize tile decompression
; ----------------------------------------------------------------------------
tile_decompress_init:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A3/A4/A5,-(A7); $0010F4
        LEA     $008811B8,A3                    ; $0010F8
        LEA     $00C00000,A4                    ; $0010FE
        BRA.S  loc_001110                       ; $001104
loc_001106:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A3/A4/A5,-(A7); $001106
        LEA     $008811CE,A3                    ; $00110A
loc_001110:
        LEA     $00FF7E00,A1                    ; $001110
        MOVE.W  (A0)+,D2                        ; $001116
        LSL.W  #1,D2                            ; $001118
        BCC.S  loc_001120                       ; $00111A
        ADDA.W  #$000A,A3                       ; $00111C
loc_001120:
        LSL.W  #2,D2                            ; $001120
        MOVEA.W D2,A5                           ; $001122
        MOVEQ   #$08,D3                         ; $001124
        MOVEQ   #$00,D2                         ; $001126
        MOVEQ   #$00,D4                         ; $001128
        BSR.W  loc_0011E4                       ; $00112A
        MOVE.B  (A0)+,D5                        ; $00112E
        ASL.W  #8,D5                            ; $001130
        MOVE.B  (A0)+,D5                        ; $001132
        MOVE.W  #$0010,D6                       ; $001134
        BSR.S  loc_001140                       ; $001138
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A3/A4/A5; $00113A
        RTS                                     ; $00113E
loc_001140:
        MOVE.W  D6,D7                           ; $001140
        SUBQ.W  #8,D7                           ; $001142
        MOVE.W  D5,D1                           ; $001144
        LSR.W  D7,D1                            ; $001146
        CMPI.B  #$FC,D1                         ; $001148
        BCC.S  loc_00118C                       ; $00114C
        ANDI.W  #$00FF,D1                       ; $00114E
        ADD.W  D1,D1                            ; $001152
        MOVE.B  $00(A1,D1.W),D0                 ; $001154
        EXT.W   D0                              ; $001158
        SUB.W  D0,D6                            ; $00115A
        CMPI.W  #$0009,D6                       ; $00115C
        BCC.S  loc_001168                       ; $001160
        ADDQ.W  #8,D6                           ; $001162
        ASL.W  #8,D5                            ; $001164
        MOVE.B  (A0)+,D5                        ; $001166
loc_001168:
        MOVE.B  $01(A1,D1.W),D1                 ; $001168
        MOVE.W  D1,D0                           ; $00116C
        ANDI.W  #$000F,D1                       ; $00116E
        ANDI.W  #$00F0,D0                       ; $001172
loc_001176:
        LSR.W  #4,D0                            ; $001176
loc_001178:
        LSL.L  #4,D4                            ; $001178
        OR.B   D1,D4                            ; $00117A
        SUBQ.W  #1,D3                           ; $00117C
        BNE.S  loc_001186                       ; $00117E
        JMP     (A3)                            ; $001180
loc_001182:
        MOVEQ   #$00,D4                         ; $001182
        MOVEQ   #$08,D3                         ; $001184
loc_001186:
        DBRA    D0,loc_001178                   ; $001186
        BRA.S  loc_001140                       ; $00118A
loc_00118C:
        SUBQ.W  #6,D6                           ; $00118C
        CMPI.W  #$0009,D6                       ; $00118E
        BCC.S  loc_00119A                       ; $001192
        ADDQ.W  #8,D6                           ; $001194
        ASL.W  #8,D5                            ; $001196
        MOVE.B  (A0)+,D5                        ; $001198
loc_00119A:
        SUBQ.W  #7,D6                           ; $00119A
        MOVE.W  D5,D1                           ; $00119C
        LSR.W  D6,D1                            ; $00119E
        MOVE.W  D1,D0                           ; $0011A0
        ANDI.W  #$000F,D1                       ; $0011A2
        ANDI.W  #$0070,D0                       ; $0011A6
        CMPI.W  #$0009,D6                       ; $0011AA
        BCC.S  loc_001176                       ; $0011AE
        ADDQ.W  #8,D6                           ; $0011B0
        ASL.W  #8,D5                            ; $0011B2
        MOVE.B  (A0)+,D5                        ; $0011B4
        BRA.S  loc_001176                       ; $0011B6
        MOVE.L  D4,(A4)                         ; $0011B8
        SUBQ.W  #1,A5                           ; $0011BA
        MOVE.W  A5,D4                           ; $0011BC
        BNE.S  loc_001182                       ; $0011BE
        RTS                                     ; $0011C0
        EOR.L  D4,D2                            ; $0011C2
        MOVE.L  D2,(A4)                         ; $0011C4
        SUBQ.W  #1,A5                           ; $0011C6
        MOVE.W  A5,D4                           ; $0011C8
        BNE.S  loc_001182                       ; $0011CA
        RTS                                     ; $0011CC
        MOVE.L  D4,(A4)+                        ; $0011CE
        SUBQ.W  #1,A5                           ; $0011D0
        MOVE.W  A5,D4                           ; $0011D2
        BNE.S  loc_001182                       ; $0011D4
        RTS                                     ; $0011D6
        EOR.L  D4,D2                            ; $0011D8
        MOVE.L  D2,(A4)+                        ; $0011DA
        SUBQ.W  #1,A5                           ; $0011DC
        MOVE.W  A5,D4                           ; $0011DE
        BNE.S  loc_001182                       ; $0011E0
        RTS                                     ; $0011E2
loc_0011E4:
        MOVE.B  (A0)+,D0                        ; $0011E4
loc_0011E6:
        CMPI.B  #$FF,D0                         ; $0011E6
        BNE.S  loc_0011EE                       ; $0011EA
        RTS                                     ; $0011EC
loc_0011EE:
        MOVE.W  D0,D7                           ; $0011EE
loc_0011F0:
        MOVE.B  (A0)+,D0                        ; $0011F0
        CMPI.B  #$80,D0                         ; $0011F2
        BCC.S  loc_0011E6                       ; $0011F6
        MOVE.B  D0,D1                           ; $0011F8
        ANDI.W  #$000F,D7                       ; $0011FA
        ANDI.W  #$0070,D1                       ; $0011FE
        OR.W   D1,D7                            ; $001202
        ANDI.W  #$000F,D0                       ; $001204
        MOVE.B  D0,D1                           ; $001208
        LSL.W  #8,D1                            ; $00120A
        OR.W   D1,D7                            ; $00120C
        MOVEQ   #$08,D1                         ; $00120E
        SUB.W  D0,D1                            ; $001210
        BNE.S  loc_00121E                       ; $001212
        MOVE.B  (A0)+,D0                        ; $001214
        ADD.W  D0,D0                            ; $001216
        MOVE.W  D7,$00(A1,D0.W)                 ; $001218
        BRA.S  loc_0011F0                       ; $00121C
loc_00121E:
        MOVE.B  (A0)+,D0                        ; $00121E
        LSL.W  D1,D0                            ; $001220
        ADD.W  D0,D0                            ; $001222
        MOVEQ   #$01,D5                         ; $001224
        LSL.W  D1,D5                            ; $001226
        SUBQ.W  #1,D5                           ; $001228
loc_00122A:
        MOVE.W  D7,$00(A1,D0.W)                 ; $00122A
        ADDQ.W  #2,D0                           ; $00122E
        DBRA    D5,loc_00122A                   ; $001230
        BRA.S  loc_0011F0                       ; $001234
loc_001236:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A1/A2/A3/A4/A5,-(A7); $001236
        MOVEA.W D0,A3                           ; $00123A
        MOVE.B  (A0)+,D0                        ; $00123C
        EXT.W   D0                              ; $00123E
        MOVEA.W D0,A5                           ; $001240
        MOVE.B  (A0)+,D4                        ; $001242
        LSL.B  #3,D4                            ; $001244
        MOVEA.W (A0)+,A2                        ; $001246
        ADDA.W  A3,A2                           ; $001248
        MOVEA.W (A0)+,A4                        ; $00124A
        ADDA.W  A3,A4                           ; $00124C
        MOVE.B  (A0)+,D5                        ; $00124E
        ASL.W  #8,D5                            ; $001250
        MOVE.B  (A0)+,D5                        ; $001252
        MOVEQ   #$10,D6                         ; $001254
loc_001256:
        MOVEQ   #$07,D0                         ; $001256
        MOVE.W  D6,D7                           ; $001258
        SUB.W  D0,D7                            ; $00125A
        MOVE.W  D5,D1                           ; $00125C
        LSR.W  D7,D1                            ; $00125E
        ANDI.W  #$007F,D1                       ; $001260
        MOVE.W  D1,D2                           ; $001264
        CMPI.W  #$0040,D1                       ; $001266
        BCC.S  loc_001270                       ; $00126A
        MOVEQ   #$06,D0                         ; $00126C
        LSR.W  #1,D2                            ; $00126E
loc_001270:
        BSR.W  loc_0013A4                       ; $001270
        ANDI.W  #$000F,D2                       ; $001274
        LSR.W  #4,D1                            ; $001278
        ADD.W  D1,D1                            ; $00127A
        JMP     $0012CC(PC,D1.W)                ; $00127C
loc_001280:
        MOVE.W  A2,(A1)+                        ; $001280
        ADDQ.W  #1,A2                           ; $001282
        DBRA    D2,loc_001280                   ; $001284
        BRA.S  loc_001256                       ; $001288
loc_00128A:
        MOVE.W  A4,(A1)+                        ; $00128A
        DBRA    D2,loc_00128A                   ; $00128C
        BRA.S  loc_001256                       ; $001290
loc_001292:
        BSR.W  loc_0012F4                       ; $001292
loc_001296:
        MOVE.W  D1,(A1)+                        ; $001296
        DBRA    D2,loc_001296                   ; $001298
        BRA.S  loc_001256                       ; $00129C
loc_00129E:
        BSR.W  loc_0012F4                       ; $00129E
loc_0012A2:
        MOVE.W  D1,(A1)+                        ; $0012A2
        ADDQ.W  #1,D1                           ; $0012A4
        DBRA    D2,loc_0012A2                   ; $0012A6
        BRA.S  loc_001256                       ; $0012AA
loc_0012AC:
        BSR.W  loc_0012F4                       ; $0012AC
loc_0012B0:
        MOVE.W  D1,(A1)+                        ; $0012B0
        SUBQ.W  #1,D1                           ; $0012B2
        DBRA    D2,loc_0012B0                   ; $0012B4
        BRA.S  loc_001256                       ; $0012B8
loc_0012BA:
        CMPI.W  #$000F,D2                       ; $0012BA
        BEQ.S  loc_0012DC                       ; $0012BE
loc_0012C0:
        BSR.W  loc_0012F4                       ; $0012C0
        MOVE.W  D1,(A1)+                        ; $0012C4
        DBRA    D2,loc_0012C0                   ; $0012C6
        BRA.S  loc_001256                       ; $0012CA
        BRA.S  loc_001280                       ; $0012CC
        BRA.S  loc_001280                       ; $0012CE
        BRA.S  loc_00128A                       ; $0012D0
        BRA.S  loc_00128A                       ; $0012D2
        BRA.S  loc_001292                       ; $0012D4
        BRA.S  loc_00129E                       ; $0012D6
        BRA.S  loc_0012AC                       ; $0012D8
        BRA.S  loc_0012BA                       ; $0012DA
loc_0012DC:
        SUBQ.W  #1,A0                           ; $0012DC
        CMPI.W  #$0010,D6                       ; $0012DE
        BNE.S  loc_0012E6                       ; $0012E2
        SUBQ.W  #1,A0                           ; $0012E4
loc_0012E6:
        MOVE.W  A0,D0                           ; $0012E6
        LSR.W  #1,D0                            ; $0012E8
        BCC.S  loc_0012EE                       ; $0012EA
        ADDQ.W  #1,A0                           ; $0012EC
loc_0012EE:
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A1/A2/A3/A4/A5; $0012EE
        RTS                                     ; $0012F2
loc_0012F4:
        MOVE.W  A3,D3                           ; $0012F4
        MOVE.B  D4,D1                           ; $0012F6
        ADD.B  D1,D1                            ; $0012F8
        BCC.S  loc_001306                       ; $0012FA
        SUBQ.W  #1,D6                           ; $0012FC
        BTST    D6,D5                           ; $0012FE
        BEQ.S  loc_001306                       ; $001300
        ORI.W  #$8000,D3                        ; $001302
loc_001306:
        ADD.B  D1,D1                            ; $001306
        BCC.S  loc_001314                       ; $001308
        SUBQ.W  #1,D6                           ; $00130A
        BTST    D6,D5                           ; $00130C
        BEQ.S  loc_001314                       ; $00130E
        ADDI.W  #$4000,D3                       ; $001310
loc_001314:
        ADD.B  D1,D1                            ; $001314
        BCC.S  loc_001322                       ; $001316
        SUBQ.W  #1,D6                           ; $001318
        BTST    D6,D5                           ; $00131A
        BEQ.S  loc_001322                       ; $00131C
        ADDI.W  #$2000,D3                       ; $00131E
loc_001322:
        ADD.B  D1,D1                            ; $001322
        BCC.S  loc_001330                       ; $001324
        SUBQ.W  #1,D6                           ; $001326
        BTST    D6,D5                           ; $001328
        BEQ.S  loc_001330                       ; $00132A
        ORI.W  #$1000,D3                        ; $00132C
loc_001330:
        ADD.B  D1,D1                            ; $001330
        BCC.S  loc_00133E                       ; $001332
        SUBQ.W  #1,D6                           ; $001334
        BTST    D6,D5                           ; $001336
        BEQ.S  loc_00133E                       ; $001338
        ORI.W  #$0800,D3                        ; $00133A
loc_00133E:
        MOVE.W  D5,D1                           ; $00133E
        MOVE.W  D6,D7                           ; $001340
        SUB.W  A5,D7                            ; $001342
        BCC.S  loc_00136E                       ; $001344
        MOVE.W  D7,D6                           ; $001346
        ADDI.W  #$0010,D6                       ; $001348
        NEG.W  D7                               ; $00134C
        LSL.W  D7,D1                            ; $00134E
        MOVE.B  (A0),D5                         ; $001350
        ROL.B  D7,D5                            ; $001352
        ADD.W  D7,D7                            ; $001354
        AND.W  $001382(PC,D7.W),D5              ; $001356
        ADD.W  D5,D1                            ; $00135A
loc_00135C:
        MOVE.W  A5,D0                           ; $00135C
        ADD.W  D0,D0                            ; $00135E
        AND.W  $001382(PC,D0.W),D1              ; $001360
        ADD.W  D3,D1                            ; $001364
        MOVE.B  (A0)+,D5                        ; $001366
        LSL.W  #8,D5                            ; $001368
        MOVE.B  (A0)+,D5                        ; $00136A
        RTS                                     ; $00136C
loc_00136E:
        BEQ.S  loc_001380                       ; $00136E
        LSR.W  D7,D1                            ; $001370
        MOVE.W  A5,D0                           ; $001372
        ADD.W  D0,D0                            ; $001374
        AND.W  $001382(PC,D0.W),D1              ; $001376
        ADD.W  D3,D1                            ; $00137A
        MOVE.W  A5,D0                           ; $00137C
        BRA.S  loc_0013A4                       ; $00137E
loc_001380:
        MOVEQ   #$10,D6                         ; $001380
        BRA.S  loc_00135C                       ; $001382
        ORI.B  #$03,D1                          ; $001384
        ORI.B  #$0F,D7                          ; $001388
        ORI.B  #$3F,(A7)+                       ; $00138C
        DC.W    $007F                           ; $001390
        DC.W    $00FF                           ; $001392
        DC.W    $01FF                           ; $001394
        DC.W    $03FF                           ; $001396
        DC.W    $07FF                           ; $001398
        DC.W    $0FFF                           ; $00139A
        DC.W    $1FFF                           ; $00139C
        DC.W    $3FFF                           ; $00139E
        DC.W    $7FFF                           ; $0013A0
        DC.W    $FFFF                           ; $0013A2
loc_0013A4:
        SUB.W  D0,D6                            ; $0013A4
        CMPI.W  #$0009,D6                       ; $0013A6
        BCC.S  loc_0013B2                       ; $0013AA
        ADDQ.W  #8,D6                           ; $0013AC
        ASL.W  #8,D5                            ; $0013AE
        MOVE.B  (A0)+,D5                        ; $0013B0
loc_0013B2:
        RTS                                     ; $0013B2
loc_0013B4:
; ----------------------------------------------------------------------------
; bit_unpack_loop ($0013B4) - Bit unpacking/RLE loop
; ----------------------------------------------------------------------------
bit_unpack_loop:
        SUBQ.L  #2,A7                           ; $0013B4
        MOVE.B  (A0)+,$0001(A7)                 ; $0013B6
        MOVE.B  (A0)+,(A7)                      ; $0013BA
        MOVE.W  (A7),D5                         ; $0013BC
        MOVEQ   #$0F,D4                         ; $0013BE
loc_0013C0:
        LSR.W  #1,D5                            ; $0013C0
        MOVE    SR,D6                           ; $0013C2
        DBRA    D4,loc_0013D2                   ; $0013C4
        MOVE.B  (A0)+,$0001(A7)                 ; $0013C8
        MOVE.B  (A0)+,(A7)                      ; $0013CC
        MOVE.W  (A7),D5                         ; $0013CE
        MOVEQ   #$0F,D4                         ; $0013D0
loc_0013D2:
        MOVE    D6,CCR                          ; $0013D2
        BCC.S  loc_0013DA                       ; $0013D4
        MOVE.B  (A0)+,(A1)+                     ; $0013D6
        BRA.S  loc_0013C0                       ; $0013D8
loc_0013DA:
        MOVEQ   #$00,D3                         ; $0013DA
        LSR.W  #1,D5                            ; $0013DC
        MOVE    SR,D6                           ; $0013DE
        DBRA    D4,loc_0013EE                   ; $0013E0
        MOVE.B  (A0)+,$0001(A7)                 ; $0013E4
        MOVE.B  (A0)+,(A7)                      ; $0013E8
        MOVE.W  (A7),D5                         ; $0013EA
        MOVEQ   #$0F,D4                         ; $0013EC
loc_0013EE:
        MOVE    D6,CCR                          ; $0013EE
        BCS.S  loc_00141E                       ; $0013F0
        LSR.W  #1,D5                            ; $0013F2
        DBRA    D4,loc_001402                   ; $0013F4
        MOVE.B  (A0)+,$0001(A7)                 ; $0013F8
        MOVE.B  (A0)+,(A7)                      ; $0013FC
        MOVE.W  (A7),D5                         ; $0013FE
        MOVEQ   #$0F,D4                         ; $001400
loc_001402:
        ROXL.W  #1,D3                           ; $001402
        LSR.W  #1,D5                            ; $001404
        DBRA    D4,loc_001414                   ; $001406
        MOVE.B  (A0)+,$0001(A7)                 ; $00140A
        MOVE.B  (A0)+,(A7)                      ; $00140E
        MOVE.W  (A7),D5                         ; $001410
        MOVEQ   #$0F,D4                         ; $001412
loc_001414:
        ROXL.W  #1,D3                           ; $001414
        ADDQ.W  #1,D3                           ; $001416
        MOVEQ   #-$01,D2                        ; $001418
        MOVE.B  (A0)+,D2                        ; $00141A
        BRA.S  loc_001434                       ; $00141C
loc_00141E:
        MOVE.B  (A0)+,D0                        ; $00141E
        MOVE.B  (A0)+,D1                        ; $001420
        MOVEQ   #-$01,D2                        ; $001422
        MOVE.B  D1,D2                           ; $001424
        LSL.W  #5,D2                            ; $001426
        MOVE.B  D0,D2                           ; $001428
        ANDI.W  #$0007,D1                       ; $00142A
        BEQ.S  loc_001440                       ; $00142E
        MOVE.B  D1,D3                           ; $001430
        ADDQ.W  #1,D3                           ; $001432
loc_001434:
        MOVE.B  $00(A1,D2.W),D0                 ; $001434
        MOVE.B  D0,(A1)+                        ; $001438
        DBRA    D3,loc_001434                   ; $00143A
        BRA.S  loc_0013C0                       ; $00143E
loc_001440:
        MOVE.B  (A0)+,D1                        ; $001440
        BEQ.S  loc_001450                       ; $001442
        CMPI.B  #$01,D1                         ; $001444
        BEQ.W  loc_0013C0                       ; $001448
        MOVE.B  D1,D3                           ; $00144C
        BRA.S  loc_001434                       ; $00144E
loc_001450:
        ADDQ.L  #2,A7                           ; $001450
        RTS                                     ; $001452
        MOVEM.W D0/D6/D7,-(A7)                  ; $001454
        ANDI.L  #$00FFFFFF,D0                   ; $001458
        MOVE.W  D0,D6                           ; $00145E
        ANDI.L  #$00003FFF,D6                   ; $001460
        ORI.W  #$4000,D6                        ; $001466
        SWAP    D6                              ; $00146A
        MOVEQ   #$0E,D7                         ; $00146C
        LSR.W  D7,D0                            ; $00146E
        OR.L   D6,D0                            ; $001470
        MOVE    SR,-(A7)                        ; $001472
        MOVE    #$2700,SR                       ; $001474
        MOVE.L  D0,(A5)                         ; $001478
        MOVE    (A7)+,SR                        ; $00147A
        MOVEM.W (A7)+,D0/D6/D7                  ; $00147C
        RTS                                     ; $001480
        MOVE.W  D0,-(A7)                        ; $001482
        ANDI.L  #$00003FFF,D0                   ; $001484
        ORI.W  #$4000,D0                        ; $00148A
        SWAP    D0                              ; $00148E
        ADDI.W  #$0010,D0                       ; $001490
        MOVE    SR,-(A7)                        ; $001494
        MOVE    #$2700,SR                       ; $001496
        MOVE.L  D0,(A5)                         ; $00149A
        MOVE    (A7)+,SR                        ; $00149C
        MOVE.W  (A7)+,D0                        ; $00149E
        RTS                                     ; $0014A0
        MOVE.W  D0,-(A7)                        ; $0014A2
        ANDI.L  #$0000007F,D0                   ; $0014A4
        ADDI.W  #$C000,D0                       ; $0014AA
        SWAP    D0                              ; $0014AE
        MOVE    SR,-(A7)                        ; $0014B0
        MOVE    #$2700,SR                       ; $0014B2
        MOVE.L  D0,(A5)                         ; $0014B6
        MOVE    (A7)+,SR                        ; $0014B8
        MOVE.W  (A7)+,D0                        ; $0014BA
        RTS                                     ; $0014BC
; ----------------------------------------------------------------------------
; fm_write ($0014BE) - FM chip register write
; ----------------------------------------------------------------------------
fm_write:
        MOVEQ   #$03,D2                         ; $0014BE
loc_0014C0:
        MOVEQ   #$00,D1                         ; $0014C0
        MOVE.B  D0,D1                           ; $0014C2
        BEQ.S  loc_0014D8                       ; $0014C4
        LSL.W  #3,D1                            ; $0014C6
        LEA     $0014E0(PC),A0                  ; $0014C8
        MOVE.L  -$08(A0,D1.W),(A5)              ; $0014CC
        MOVEA.L -$04(A0,D1.W),A0                ; $0014D0
        JSR     loc_0010F4(PC)                  ; $0014D4
loc_0014D8:
        ROR.L  #8,D0                            ; $0014D8
        DBRA    D2,loc_0014C0                   ; $0014DA
        RTS                                     ; $0014DE
        NEGX.B D0                               ; $0014E0
        ORI.B  #$00,D0                          ; $0014E2
        ORI.B  #$20,D0                          ; $0014E6
        ORI.B  #$92,D0                          ; $0014EA
        DC.W    $AC0C                           ; $0014EE
        CLR.B  -(A0)                            ; $0014F0
        ORI.B  #$92,D0                          ; $0014F2
        DC.W    $ACCC                           ; $0014F6
        CLR.B  -(A0)                            ; $0014F8
        ORI.B  #$92,D0                          ; $0014FA
        DC.W    $AD78                           ; $0014FE
        NEGX.B D0                               ; $001500
        ORI.B  #$00,D0                          ; $001502
        ORI.B  #$00,D0                          ; $001506
        ORI.B  #$00,D0                          ; $00150A
        ORI.B  #$20,D0                          ; $00150E
        ORI.B  #$8B,D0                          ; $001512
        DC.W    $F000                           ; $001516
        CLR.B  -(A0)                            ; $001518
        ORI.B  #$90,D0                          ; $00151A
        MOVE.W  A6,$00(A5,D6.W)                 ; $00151E
        ORI.B  #$90,D0                          ; $001522
        ROR.W  (A2)+                            ; $001526
        ADDQ.B  #7,D0                           ; $001528
        ORI.B  #$90,D1                          ; $00152A
        LSL.L  #2,D6                            ; $00152E
        MOVEQ   #$03,D2                         ; $001530
loc_001532:
        MOVEQ   #$00,D1                         ; $001532
        MOVE.B  D0,D1                           ; $001534
        BEQ.S  loc_001546                       ; $001536
        LSL.W  #3,D1                            ; $001538
        MOVEA.L $001546(PC,D1.W),A0             ; $00153A
        MOVEA.L $00154A(PC,D1.W),A4             ; $00153E
        JSR     loc_001106(PC)                  ; $001542
loc_001546:
        ROR.L  #8,D0                            ; $001546
        DBRA    D2,loc_001532                   ; $001548
        RTS                                     ; $00154C
        ORI.B  #$00,D0                          ; $00154E
        ORI.B  #$00,D0                          ; $001552
        ORI.B  #$00,D0                          ; $001556
        ORI.B  #$00,D0                          ; $00155A
; ----------------------------------------------------------------------------
; sound_dma_transfer ($00155E) - Sound DMA transfer
; ----------------------------------------------------------------------------
sound_dma_transfer:
        MOVEQ   #$03,D2                         ; $00155E
loc_001560:
        MOVEQ   #$00,D0                         ; $001560
        MOVE.B  D1,D0                           ; $001562
        BEQ.S  loc_00157A                       ; $001564
        MULU    #$000A,D0                       ; $001566
        LEA     $001586(PC,D0.W),A0             ; $00156A
        MOVE.W  -(A0),D0                        ; $00156E
        MOVEA.L -(A0),A1                        ; $001570
        MOVE.L  -(A0),D3                        ; $001572
        MOVEA.L D3,A0                           ; $001574
        JSR     loc_001236(PC)                  ; $001576
loc_00157A:
        ROR.L  #8,D1                            ; $00157A
        DBRA    D2,loc_001560                   ; $00157C
        MOVE    #$2300,SR                       ; $001580
        RTS                                     ; $001584
        ORI.L  #$000000FF,(A0)                  ; $001586
        MOVE.B  D0,D0                           ; $00158C
        ORI.B  #$00,(A1)                        ; $00158E
        ORI.B  #$00,D0                          ; $001592
        ORI.B  #$00,D0                          ; $001596
        ORI.B  #$00,D0                          ; $00159A
        ORI.B  #$00,D0                          ; $00159E
        ORI.B  #$90,D0                          ; $0015A2
        MOVE.L  -(A4),-$01(A1,D0.W)             ; $0015A6
        MOVE.B  D0,D0                           ; $0015AA
        ORI.B  #$90,(A1)                        ; $0015AC
        BCLR    D2,-$01(A2,D0.W)                ; $0015B0
        MOVE.B  D0,D0                           ; $0015B4
        ORI.B  #$90,(A1)                        ; $0015B6
        DC.W    $0A7C                           ; $0015BA
        DC.W    $00FF                           ; $0015BC
        MOVE.B  D0,D0                           ; $0015BE
        ORI.B  #$90,(A1)                        ; $0015C0
        MOVE.B  $00FF(A2),D0                    ; $0015C4
        MOVE.B  D0,D0                           ; $0015C8
        ORI.B  #$90,(A1)                        ; $0015CA
        MOVEA.W -$01(A4,D0.W),A5                ; $0015CE
        MOVE.B  D0,D0                           ; $0015D2
        ORI.B  #$90,(A1)                        ; $0015D4
        MOVE.W  (A6)+,(A5)+                     ; $0015D8
        DC.W    $00FF                           ; $0015DA
        MOVE.B  D0,D0                           ; $0015DC
        ORI.B  #$90,(A1)                        ; $0015DE
        MOVE.W  #$00FF,-(A5)                    ; $0015E2
        MOVE.B  D0,D0                           ; $0015E6
        ORI.B  #$03,(A1)                        ; $0015E8
loc_0015EC:
        MOVEQ   #$00,D1                         ; $0015EC
        MOVE.B  D0,D1                           ; $0015EE
        BEQ.S  loc_001608                       ; $0015F0
        LSL.W  #3,D1                            ; $0015F2
        MOVEA.L $001608(PC,D1.W),A0             ; $0015F4
        MOVEA.L $00160C(PC,D1.W),A1             ; $0015F8
        MOVEM.L D0/D2,-(A7)                     ; $0015FC
        JSR     loc_0013B4(PC)                  ; $001600
        MOVEM.L (A7)+,D0/D2                     ; $001604
loc_001608:
        ROR.L  #8,D0                            ; $001608
        DBRA    D2,loc_0015EC                   ; $00160A
loc_00160E:
        RTS                                     ; $00160E
        ORI.L  #$3B8E00FF,(A0)                  ; $001610
        MOVE.B  D0,D0                           ; $001616
        ORI.L  #$5A7E00FF,(A0)                  ; $001618
        MOVE.B  D0,D0                           ; $00161E
        ORI.L  #$77CE00FF,(A0)                  ; $001620
        MOVE.B  D0,D0                           ; $001626
        ORI.L  #$992E00FF,(A0)                  ; $001628
        MOVE.B  D0,D0                           ; $00162E
        ORI.L  #$C30E00FF,(A0)                  ; $001630
        MOVE.B  D0,D0                           ; $001636
        MOVE    #$2700,SR                       ; $001638
        MOVEQ   #$03,D2                         ; $00163C
loc_00163E:
        MOVEQ   #$00,D1                         ; $00163E
        MOVE.B  D0,D1                           ; $001640
        BEQ.S  loc_001660                       ; $001642
        MULU    #$000C,D1                       ; $001644
        MOVEM.L D0/D1/D2,-(A7)                  ; $001648
        LEA     $00166C(PC,D1.W),A0             ; $00164C
        MOVE.W  -(A0),D2                        ; $001650
        MOVE.W  -(A0),D1                        ; $001652
        MOVE.L  -(A0),D0                        ; $001654
        MOVEA.L -(A0),A0                        ; $001656
        JSR     loc_0010C4(PC)                  ; $001658
        MOVEM.L (A7)+,D0/D1/D2                  ; $00165C
loc_001660:
        ROR.L  #8,D0                            ; $001660
        DBRA    D2,loc_00163E                   ; $001662
        MOVE    #$2300,SR                       ; $001666
        RTS                                     ; $00166A
        DC.W    $00FF                           ; $00166C
        MOVE.B  D0,D0                           ; $00166E
        BCS.S  loc_00160E                       ; $001670
        ORI.B  #$0D,D2                          ; $001672
        ORI.B  #$FF,D3                          ; $001676
        MOVE.B  D0,D0                           ; $00167A
        BRA.W  loc_001680                       ; $00167C
loc_001680:
        ORI.B  #$1B,-(A7)                       ; $001680
; ----------------------------------------------------------------------------
; vint_handler ($001684) - V-INT entry point
; ----------------------------------------------------------------------------
vint_handler:
        TST.W  (-14214).W                       ; $001684
        BEQ.S  loc_0016AE                       ; $001688
        MOVE    #$2700,SR                       ; $00168A
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,-(A7); $00168E
        MOVE.W  (-14214).W,D0                   ; $001692
        MOVE.W  #$0000,(-14214).W               ; $001696
        MOVEA.L $0016B2(PC,D0.W),A1             ; $00169C
        JSR     (A1)                            ; $0016A0
        ADDQ.L  #1,(-13980).W                   ; $0016A2
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6; $0016A6
        MOVE    #$2300,SR                       ; $0016AA
loc_0016AE:
        RTE                                     ; $0016AE
; ----------------------------------------------------------------------------
; vint_early_exit ($0016B0) - RTE when no state change
; ----------------------------------------------------------------------------
vint_early_exit:
        RTE                                     ; $0016B0
        DC.W    $0088                           ; $0016B2
        DC.W    $19FE                           ; $0016B4
        DC.W    $0088                           ; $0016B6
        DC.W    $19FE                           ; $0016B8
        DC.W    $0088                           ; $0016BA
        DC.W    $19FE                           ; $0016BC
        ORI.B  #$00,D1                          ; $0016BE
        DC.W    $0088                           ; $0016C2
        DC.W    $1A6E                           ; $0016C4
        DC.W    $0088                           ; $0016C6
        DC.W    $1A72                           ; $0016C8
        DC.W    $0088                           ; $0016CA
        DC.W    $1C66                           ; $0016CC
        DC.W    $0088                           ; $0016CE
        DC.W    $1ACA                           ; $0016D0
        DC.W    $0088                           ; $0016D2
        DC.W    $19FE                           ; $0016D4
        DC.W    $0088                           ; $0016D6
        DC.W    $1E42                           ; $0016D8
        DC.W    $0088                           ; $0016DA
        MOVE.B  (A4),-(A5)                      ; $0016DC
        DC.W    $0088                           ; $0016DE
        DC.W    $1A64                           ; $0016E0
        DC.W    $0088                           ; $0016E2
        MOVE.B  $0088(A0),-$6C(A5,D1.L)         ; $0016E4
        DC.W    $0088                           ; $0016EA
        DC.W    $1F4A                           ; $0016EC
        DC.W    $0088                           ; $0016EE
        MOVE.L  (A0),D0                         ; $0016F0
        ORI.B  #$01,D0                          ; $0016F2
        DC.W    $0088                           ; $0016F6
        DC.W    $1DBE                           ; $0016F8
        ORI.B  #$01,D0                          ; $0016FA
        ORI.B  #$01,D0                          ; $0016FE
        ORI.B  #$01,D0                          ; $001702
        DC.W    $0088                           ; $001706
        DC.W    $1D0C                           ; $001708
; ----------------------------------------------------------------------------
; vint_return ($00170A) - RTE instruction
; ----------------------------------------------------------------------------
vint_return:
        RTE                                     ; $00170A
loc_00170C:
; ----------------------------------------------------------------------------
; controller_port_init ($00170C) - Initialize controller ports
; ----------------------------------------------------------------------------
controller_port_init:
        MOVE.B  #$00,(-366).W                   ; $00170C
        MOVE.B  #$00,(-365).W                   ; $001712
        LEA     (-382).W,A1                     ; $001718
        MOVE.B  #$04,(A1)+                      ; $00171C
        MOVE.B  #$06,(A1)+                      ; $001720
        MOVE.B  #$01,(A1)+                      ; $001724
        MOVE.B  #$00,(A1)+                      ; $001728
        MOVE.B  #$05,(A1)+                      ; $00172C
        MOVE.B  #$0A,(A1)+                      ; $001730
        MOVE.B  #$09,(A1)+                      ; $001734
        MOVE.B  #$08,(A1)+                      ; $001738
        MOVE.B  #$04,(A1)+                      ; $00173C
        MOVE.B  #$06,(A1)+                      ; $001740
        MOVE.B  #$01,(A1)+                      ; $001744
        MOVE.B  #$00,(A1)+                      ; $001748
        MOVE.B  #$05,(A1)+                      ; $00174C
        MOVE.B  #$0A,(A1)+                      ; $001750
        MOVE.B  #$09,(A1)+                      ; $001754
        MOVE.B  #$08,(A1)                       ; $001758
        LEA     (-364).W,A1                     ; $00175C
        LEA     $001796(PC),A3                  ; $001760
        BTST    #0,(-14312).W                   ; $001764
        BNE.S  loc_001770                       ; $00176A
        LEA     $00178E(PC),A3                  ; $00176C
loc_001770:
        JSR     loc_001784(PC)                  ; $001770
        LEA     $001796(PC),A3                  ; $001774
        BTST    #1,(-14312).W                   ; $001778
        BNE.S  loc_001784                       ; $00177E
        LEA     $00178E(PC),A3                  ; $001780
loc_001784:
        MOVEQ   #$07,D7                         ; $001784
loc_001786:
        MOVE.B  (A3)+,(A1)+                     ; $001786
        DBRA    D7,loc_001786                   ; $001788
        RTS                                     ; $00178C
        SUBI.B  #$00,D6                         ; $00178E
        BTST    D2,D0                           ; $001792
        ORI.B  #$06,D0                          ; $001794
        BTST    D0,D0                           ; $001798
        DC.W    $050A                           ; $00179A
        DC.W    $0908                           ; $00179C
loc_00179E:
; ----------------------------------------------------------------------------
; poll_controllers ($00179E) - Controller read + mode check (12 calls)
; ----------------------------------------------------------------------------
poll_controllers:
        CMPI.B  #$0D,(-14320).W                 ; $00179E
        BNE.S  loc_0017D6                       ; $0017A4
        LEA     (-14228).W,A0                   ; $0017A6
        MOVE.L  (A0),$00FF60D0                  ; $0017AA
        LEA     $00A10003,A1                    ; $0017B0
        LEA     (-13968).W,A2                   ; $0017B6
        LEA     (-382).W,A3                     ; $0017BA
        JSR     loc_00185E(PC)                  ; $0017BE
        JSR     loc_0017EE(PC)                  ; $0017C2
        CMPI.B  #$0D,(-14319).W                 ; $0017C6
        BEQ.S  loc_0017E4                       ; $0017CC
        MOVE.B  #$00,(-14226).W                 ; $0017CE
        RTS                                     ; $0017D4
loc_0017D6:
        MOVE.B  #$00,(-14228).W                 ; $0017D6
        MOVE.B  #$00,(-14226).W                 ; $0017DC
        RTS                                     ; $0017E2
loc_0017E4:
        LEA     $00A10005,A1                    ; $0017E4
        JSR     loc_00185E(PC)                  ; $0017EA
loc_0017EE:
; ----------------------------------------------------------------------------
; button_remap ($0017EE) - Button remapping function
; ----------------------------------------------------------------------------
button_remap:
        MOVE.B  (A0),D2                         ; $0017EE
        MOVE.W  D0,D1                           ; $0017F0
        EOR.B  D0,D2                            ; $0017F2
        AND.B  D2,D0                            ; $0017F4
        MOVE.B  D1,(A0)+                        ; $0017F6
        MOVE.B  D0,(A0)+                        ; $0017F8
        MOVEQ   #$00,D6                         ; $0017FA
        OR.B   D1,D6                            ; $0017FC
        ANDI.B  #$0C,D6                         ; $0017FE
        MOVE.B  (A3)+,D7                        ; $001802
        BTST    D7,D1                           ; $001804
        BEQ.S  loc_00180C                       ; $001806
        BSET    #4,D6                           ; $001808
loc_00180C:
        MOVE.B  (A3)+,D7                        ; $00180C
        BTST    D7,D1                           ; $00180E
        BEQ.S  loc_001816                       ; $001810
        BSET    #6,D6                           ; $001812
loc_001816:
        MOVE.B  (A3)+,D7                        ; $001816
        BTST    D7,D1                           ; $001818
        BEQ.S  loc_001820                       ; $00181A
        BSET    #1,D6                           ; $00181C
loc_001820:
        MOVE.B  (A3)+,D7                        ; $001820
        BTST    D7,D1                           ; $001822
        BEQ.S  loc_00182A                       ; $001824
        BSET    #0,D6                           ; $001826
loc_00182A:
        MOVE.B  (A3)+,D7                        ; $00182A
        BTST    D7,D1                           ; $00182C
        BEQ.S  loc_001834                       ; $00182E
        BSET    #10,D6                          ; $001830
loc_001834:
        MOVE.B  (A3)+,D7                        ; $001834
        BTST    D7,D1                           ; $001836
        BEQ.S  loc_00183E                       ; $001838
        BSET    #5,D6                           ; $00183A
loc_00183E:
        MOVE.B  (A3)+,D7                        ; $00183E
        BTST    D7,D1                           ; $001840
        BEQ.S  loc_001848                       ; $001842
        BSET    #9,D6                           ; $001844
loc_001848:
        MOVE.B  (A3)+,D7                        ; $001848
        BTST    D7,D1                           ; $00184A
        BEQ.S  loc_001852                       ; $00184C
        BSET    #8,D6                           ; $00184E
loc_001852:
        MOVE.W  (A2),D2                         ; $001852
        MOVE.W  D6,(A2)+                        ; $001854
        EOR.W  D6,D2                            ; $001856
        AND.W  D2,D6                            ; $001858
        MOVE.W  D6,(A2)+                        ; $00185A
        RTS                                     ; $00185C
loc_00185E:
; ----------------------------------------------------------------------------
; zbus_request ($00185E) - Z-Bus request
; ----------------------------------------------------------------------------
zbus_request:
        MOVE.W  #$0100,$00A11100                ; $00185E
loc_001866:
        BTST    #0,$00A11100                    ; $001866
        BNE.S  loc_001866                       ; $00186E
        MOVE.B  #$40,(A1)                       ; $001870
        MOVEQ   #$00,D6                         ; $001874
        MOVEQ   #$3F,D1                         ; $001876
        AND.B  (A1),D1                          ; $001878
        MOVE.B  D6,(A1)                         ; $00187A
        MOVEQ   #$40,D7                         ; $00187C
        MOVEQ   #$30,D0                         ; $00187E
        AND.B  (A1),D0                          ; $001880
        LSL.B  #2,D0                            ; $001882
        OR.W   D1,D0                            ; $001884
        MOVE.B  D7,(A1)                         ; $001886
        NOP                                     ; $001888
        NOP                                     ; $00188A
        NOP                                     ; $00188C
        NOP                                     ; $00188E
        MOVE.B  (A1),D1                         ; $001890
        MOVE.B  D6,(A1)                         ; $001892
        MOVE.W  #$00FF,D5                       ; $001894
        MOVE.B  (A1),D1                         ; $001898
        MOVE.B  D7,(A1)                         ; $00189A
        MOVE.B  (A1),D1                         ; $00189C
        MOVE.B  D6,(A1)                         ; $00189E
        NOP                                     ; $0018A0
        NOP                                     ; $0018A2
        NOP                                     ; $0018A4
        MOVEQ   #$0F,D1                         ; $0018A6
        AND.B  (A1),D1                          ; $0018A8
        BNE.S  loc_0018C8                       ; $0018AA
        MOVE.B  D7,(A1)                         ; $0018AC
        NOP                                     ; $0018AE
        NOP                                     ; $0018B0
        NOP                                     ; $0018B2
        MOVEQ   #$0F,D1                         ; $0018B4
        AND.B  (A1),D1                          ; $0018B6
        LSL.W  #8,D1                            ; $0018B8
        OR.W   D1,D0                            ; $0018BA
        NOT.W  D0                               ; $0018BC
        MOVE.W  #$0000,$00A11100                ; $0018BE
        RTS                                     ; $0018C6
loc_0018C8:
        NOT.W  D0                               ; $0018C8
        AND.W  D5,D0                            ; $0018CA
        MOVE.B  D7,(A1)                         ; $0018CC
        MOVE.W  #$0000,$00A11100                ; $0018CE
        RTS                                     ; $0018D6
loc_0018D8:
; ----------------------------------------------------------------------------
; io_port_init ($0018D8) - I/O port initialization for controllers
; ----------------------------------------------------------------------------
io_port_init:
        MOVEQ   #$00,D0                         ; $0018D8
        BSR.W  loc_001992                       ; $0018DA
        MOVE.B  D0,(-14320).W                   ; $0018DE
        MOVEQ   #$01,D0                         ; $0018E2
        BSR.W  loc_001992                       ; $0018E4
        MOVE.B  D0,(-14319).W                   ; $0018E8
        MOVEQ   #$02,D0                         ; $0018EC
        BSR.W  loc_001992                       ; $0018EE
        MOVE.B  D0,(-14318).W                   ; $0018F2
        MOVE.W  #$0100,$00A11100                ; $0018F6
loc_0018FE:
        BTST    #0,$00A11100                    ; $0018FE
        BNE.S  loc_0018FE                       ; $001906
        MOVEQ   #$40,D0                         ; $001908
        MOVE.B  D0,$00A10009                    ; $00190A
        MOVE.B  D0,$00A1000B                    ; $001910
        MOVE.B  D0,$00A1000D                    ; $001916
        MOVE.W  #$00C0,D0                       ; $00191C
        MOVE.B  D0,$00A10003                    ; $001920
        MOVE.B  D0,$00A10005                    ; $001926
        MOVE.B  D0,$00A10007                    ; $00192C
        MOVE.W  #$0000,$00A11100                ; $001932
        MOVE.W  #$1400,D7                       ; $00193A
loc_00193E:
        DBRA    D7,loc_00193E                   ; $00193E
        MOVE.B  #$00,(-14312).W                 ; $001942
        LEA     $00A10003,A1                    ; $001948
        JSR     loc_00185E(PC)                  ; $00194E
        BTST    #15,D0                          ; $001952
        BEQ.S  loc_00195E                       ; $001956
        BSET    #0,(-14312).W                   ; $001958
loc_00195E:
        LEA     $00A10005,A1                    ; $00195E
        JSR     loc_00185E(PC)                  ; $001964
        BTST    #15,D0                          ; $001968
        BEQ.S  loc_001974                       ; $00196C
        BSET    #1,(-14312).W                   ; $00196E
loc_001974:
        CMPI.B  #$0D,(-14320).W                 ; $001974
        BEQ.S  loc_001982                       ; $00197A
        BSET    #2,(-14312).W                   ; $00197C
loc_001982:
        CMPI.B  #$0D,(-14319).W                 ; $001982
        BEQ.S  loc_001990                       ; $001988
        BSET    #3,(-14312).W                   ; $00198A
loc_001990:
        RTS                                     ; $001990
loc_001992:
        MOVE.W  #$0100,$00A11100                ; $001992
loc_00199A:
        BTST    #0,$00A11100                    ; $00199A
        BNE.S  loc_00199A                       ; $0019A2
        MOVEM.L D1/D2/A1,-(A7)                  ; $0019A4
        ADD.W  D0,D0                            ; $0019A8
        ADD.W  D0,D0                            ; $0019AA
        LEA     $0019F2(PC),A0                  ; $0019AC
        MOVEA.L $00(A0,D0.W),A0                 ; $0019B0
        LEA     $0019EA(PC),A1                  ; $0019B4
        MOVE.B  (A1),$0006(A0)                  ; $0019B8
        MOVEQ   #$00,D0                         ; $0019BC
        MOVEQ   #$08,D1                         ; $0019BE
loc_0019C0:
        MOVE.B  (A1)+,(A0)                      ; $0019C0
        NOP                                     ; $0019C2
        NOP                                     ; $0019C4
        NOP                                     ; $0019C6
        NOP                                     ; $0019C8
        MOVE.B  (A0),D2                         ; $0019CA
        AND.B  (A1)+,D2                         ; $0019CC
        BEQ.W  loc_0019D4                       ; $0019CE
        OR.B   D1,D0                            ; $0019D2
loc_0019D4:
        LSR.B  #1,D1                            ; $0019D4
        BNE.S  loc_0019C0                       ; $0019D6
        CLR.B  $0006(A0)                        ; $0019D8
        MOVEM.L (A7)+,D1/D2/A1                  ; $0019DC
        MOVE.W  #$0000,$00A11100                ; $0019E0
        RTS                                     ; $0019E8
        DC.W    $400C                           ; $0019EA
        NEGX.B D3                               ; $0019EC
        DC.W    $000C                           ; $0019EE
        ORI.B  #$A1,D3                          ; $0019F0
        ORI.B  #$A1,D3                          ; $0019F4
        ORI.B  #$A1,D5                          ; $0019F8
        ORI.B  #$15,D7                          ; $0019FC
        MOVE.L  #$6C000003,(A5)                 ; $001A00
        MOVE.W  (-32768).W,(A6)                 ; $001A06
        MOVE.W  (-32766).W,(A6)                 ; $001A0A
        MOVE.L  #$40000010,(A5)                 ; $001A0E
        MOVE.W  (-14208).W,(A6)                 ; $001A14
        MOVE.W  (-14206).W,(A6)                 ; $001A18
        MOVE.W  #$0100,$00A11100                ; $001A1C
loc_001A24:
        BTST    #0,$00A11100                    ; $001A24
        BNE.S  loc_001A24                       ; $001A2C
        MOVE.W  (-14220).W,D4                   ; $001A2E
        BSET    #4,D4                           ; $001A32
        MOVE.W  D4,(A5)                         ; $001A36
        MOVE.L  #$93409400,(A5)                 ; $001A38
        MOVE.L  #$954096C2,(A5)                 ; $001A3E
        MOVE.W  #$977F,(A5)                     ; $001A44
        MOVE.W  #$C000,(A5)                     ; $001A48
        MOVE.W  #$0080,(-14218).W               ; $001A4C
        MOVE.W  (-14218).W,(A5)                 ; $001A52
        MOVE.W  (-14220).W,(A5)                 ; $001A56
        MOVE.W  #$0000,$00A11100                ; $001A5A
        RTS                                     ; $001A62
; ----------------------------------------------------------------------------
; vint_state_transition ($001A64) - Set next state
; ----------------------------------------------------------------------------
vint_state_transition:
        MOVE.W  #$002C,(-14214).W               ; $001A64
        JMP     loc_0020C6(PC)                  ; $001A6A
; ----------------------------------------------------------------------------
; vint_state_minimal ($001A6E) - Quick VDP read
; ----------------------------------------------------------------------------
vint_state_minimal:
        MOVE.W  (A5),D0                         ; $001A6E
        RTS                                     ; $001A70
; ----------------------------------------------------------------------------
; vint_state_vdp_sync ($001A72) - Full VDP sync
; ----------------------------------------------------------------------------
vint_state_vdp_sync:
        MOVE.W  (A5),D0                         ; $001A72
        MOVE.L  #$40000010,(A5)                 ; $001A74
        MOVE.W  (-14208).W,(A6)                 ; $001A7A
        MOVE.W  (-14206).W,(A6)                 ; $001A7E
        MOVE.W  #$0100,$00A11100                ; $001A82
loc_001A8A:
        BTST    #0,$00A11100                    ; $001A8A
        BNE.S  loc_001A8A                       ; $001A92
        MOVE.W  (-14220).W,D4                   ; $001A94
        BSET    #4,D4                           ; $001A98
        MOVE.W  D4,(A5)                         ; $001A9C
        MOVE.L  #$93409400,(A5)                 ; $001A9E
        MOVE.L  #$954096C2,(A5)                 ; $001AA4
        MOVE.W  #$977F,(A5)                     ; $001AAA
        MOVE.W  #$C000,(A5)                     ; $001AAE
        MOVE.W  #$0080,(-14218).W               ; $001AB2
        MOVE.W  (-14218).W,(A5)                 ; $001AB8
        MOVE.W  (-14220).W,(A5)                 ; $001ABC
        MOVE.W  #$0000,$00A11100                ; $001AC0
        RTS                                     ; $001AC8
; ----------------------------------------------------------------------------
; vint_state_sprite_cfg ($001ACA) - Sprite config
; ----------------------------------------------------------------------------
vint_state_sprite_cfg:
        MOVE.W  (A5),D0                         ; $001ACA
        MOVE.W  #$0100,$00A11100                ; $001ACC
loc_001AD4:
        BTST    #0,$00A11100                    ; $001AD4
        BNE.S  loc_001AD4                       ; $001ADC
        MOVE.W  (-14220).W,D4                   ; $001ADE
        BSET    #4,D4                           ; $001AE2
        MOVE.W  D4,(A5)                         ; $001AE6
        MOVE.L  #$93809401,(A5)                 ; $001AE8
        MOVE.L  #$951E96C0,(A5)                 ; $001AEE
        MOVE.W  #$977F,(A5)                     ; $001AF4
        MOVE.W  #$6C3C,(A5)                     ; $001AF8
        MOVE.W  #$0083,(-14218).W               ; $001AFC
        MOVE.W  (-14218).W,(A5)                 ; $001B02
        MOVE.W  (-14220).W,(A5)                 ; $001B06
        MOVE.W  #$0000,$00A11100                ; $001B0A
        RTS                                     ; $001B12
; ----------------------------------------------------------------------------
; vint_state_vdp_config ($001B14) - VDP config
; ----------------------------------------------------------------------------
vint_state_vdp_config:
        MOVE.W  (A5),D0                         ; $001B14
        MOVE.L  #$6C000003,(A5)                 ; $001B16
        MOVE.W  (-32768).W,(A6)                 ; $001B1C
        MOVE.W  (-32766).W,(A6)                 ; $001B20
        MOVE.L  #$40000010,(A5)                 ; $001B24
        MOVE.W  (-14208).W,(A6)                 ; $001B2A
        MOVE.W  (-14206).W,(A6)                 ; $001B2E
        MOVE.W  #$0100,$00A11100                ; $001B32
loc_001B3A:
        BTST    #0,$00A11100                    ; $001B3A
        BNE.S  loc_001B3A                       ; $001B42
        MOVE.W  (-14220).W,D4                   ; $001B44
        BSET    #4,D4                           ; $001B48
        MOVE.W  D4,(A5)                         ; $001B4C
        MOVE.L  #$93809403,(A5)                 ; $001B4E
        MOVE.L  #$95009688,(A5)                 ; $001B54
        MOVE.W  #$977F,(A5)                     ; $001B5A
        MOVE.W  #$6000,(A5)                     ; $001B5E
        MOVE.W  #$0082,(-14218).W               ; $001B62
        MOVE.W  (-14218).W,(A5)                 ; $001B68
        MOVE.W  (-14220).W,(A5)                 ; $001B6C
        MOVE.W  (-14220).W,D4                   ; $001B70
        BSET    #4,D4                           ; $001B74
        MOVE.W  D4,(A5)                         ; $001B78
        MOVE.L  #$93409400,(A5)                 ; $001B7A
        MOVE.L  #$954096C2,(A5)                 ; $001B80
        MOVE.W  #$977F,(A5)                     ; $001B86
        MOVE.W  #$C000,(A5)                     ; $001B8A
        MOVE.W  #$0080,(-14218).W               ; $001B8E
        MOVE.W  (-14218).W,(A5)                 ; $001B94
        MOVE.W  (-14220).W,(A5)                 ; $001B98
        MOVE.W  #$0000,$00A11100                ; $001B9C
        JMP     loc_00179E(PC)                  ; $001BA4
; ----------------------------------------------------------------------------
; vint_state_complex ($001BA8) - Complex VDP ops
; ----------------------------------------------------------------------------
vint_state_complex:
        MOVE.W  (A5),D0                         ; $001BA8
        MOVE.W  #$0100,$00A11100                ; $001BAA
loc_001BB2:
        BTST    #0,$00A11100                    ; $001BB2
        BNE.S  loc_001BB2                       ; $001BBA
        MOVE.W  (-14220).W,D4                   ; $001BBC
        BSET    #4,D4                           ; $001BC0
        MOVE.W  D4,(A5)                         ; $001BC4
        MOVE.L  #$93809403,(A5)                 ; $001BC6
        MOVE.L  #$95009688,(A5)                 ; $001BCC
        MOVE.W  #$977F,(A5)                     ; $001BD2
        MOVE.W  #$6000,(A5)                     ; $001BD6
        MOVE.W  #$0082,(-14218).W               ; $001BDA
        MOVE.W  (-14218).W,(A5)                 ; $001BE0
        MOVE.W  (-14220).W,(A5)                 ; $001BE4
        MOVE.W  (-14220).W,D4                   ; $001BE8
        BSET    #4,D4                           ; $001BEC
        MOVE.W  D4,(A5)                         ; $001BF0
        MOVE.L  #$93809403,(A5)                 ; $001BF2
        MOVE.L  #$9580968B,(A5)                 ; $001BF8
        MOVE.W  #$977F,(A5)                     ; $001BFE
        MOVE.W  #$4000,(A5)                     ; $001C02
        MOVE.W  #$0083,(-14218).W               ; $001C06
        MOVE.W  (-14218).W,(A5)                 ; $001C0C
        MOVE.W  (-14220).W,(A5)                 ; $001C10
        MOVE.W  (-14220).W,D4                   ; $001C14
        BSET    #4,D4                           ; $001C18
        MOVE.W  D4,(A5)                         ; $001C1C
        MOVE.L  #$93409400,(A5)                 ; $001C1E
        MOVE.L  #$954096C2,(A5)                 ; $001C24
        MOVE.W  #$977F,(A5)                     ; $001C2A
        MOVE.W  #$C000,(A5)                     ; $001C2E
        MOVE.W  #$0080,(-14218).W               ; $001C32
        MOVE.W  (-14218).W,(A5)                 ; $001C38
        MOVE.W  (-14220).W,(A5)                 ; $001C3C
        MOVE.W  #$0000,$00A11100                ; $001C40
        MOVE.L  #$6C000003,(A5)                 ; $001C48
        MOVE.W  (-32768).W,(A6)                 ; $001C4E
        MOVE.W  (-32766).W,(A6)                 ; $001C52
        MOVE.L  #$40000010,(A5)                 ; $001C56
        MOVE.W  (-14208).W,(A6)                 ; $001C5C
        MOVE.W  (-14206).W,(A6)                 ; $001C60
        RTS                                     ; $001C64
; ----------------------------------------------------------------------------
; vint_state_fb_toggle ($001C66) - Frame buffer toggle
; ----------------------------------------------------------------------------
vint_state_fb_toggle:
        MOVE.W  (A5),D0                         ; $001C66
        MOVE.L  #$6C000003,(A5)                 ; $001C68
        MOVE.W  (-32768).W,(A6)                 ; $001C6E
        MOVE.W  (-32766).W,(A6)                 ; $001C72
        MOVE.L  #$40000010,(A5)                 ; $001C76
        MOVE.W  (-14208).W,(A6)                 ; $001C7C
        MOVE.W  (-14206).W,(A6)                 ; $001C80
        MOVE.W  #$0100,$00A11100                ; $001C84
loc_001C8C:
        BTST    #0,$00A11100                    ; $001C8C
        BNE.S  loc_001C8C                       ; $001C94
        MOVE.W  (-14220).W,D4                   ; $001C96
        BSET    #4,D4                           ; $001C9A
        MOVE.W  D4,(A5)                         ; $001C9E
        MOVE.L  #$93409400,(A5)                 ; $001CA0
        MOVE.L  #$954096C2,(A5)                 ; $001CA6
        MOVE.W  #$977F,(A5)                     ; $001CAC
        MOVE.W  #$C000,(A5)                     ; $001CB0
        MOVE.W  #$0080,(-14218).W               ; $001CB4
        MOVE.W  (-14218).W,(A5)                 ; $001CBA
        MOVE.W  (-14220).W,(A5)                 ; $001CBE
        MOVE.W  #$0000,$00A11100                ; $001CC2
        TST.B  $00A15120                        ; $001CCA
        BNE.S  loc_001D0A                       ; $001CD0
        BCLR    #7,$00A15100                    ; $001CD2
loc_001CDA:
        BTST    #7,$00A1518A                    ; $001CDA
        BEQ.S  loc_001CDA                       ; $001CE2
        JSR     $002878(PC)                     ; $001CE4
        BCHG    #0,(-14324).W                   ; $001CE8
        BNE.S  loc_001CFA                       ; $001CEE
        BSET    #0,$00A1518B                    ; $001CF0
        BRA.S  loc_001D02                       ; $001CF8
loc_001CFA:
        BCLR    #0,$00A1518B                    ; $001CFA
loc_001D02:
        BSET    #7,$00A15100                    ; $001D02
loc_001D0A:
        RTS                                     ; $001D0A
        MOVE.W  (A5),D0                         ; $001D0C
        MOVE.L  #$6C000003,(A5)                 ; $001D0E
        MOVE.W  (-32768).W,(A6)                 ; $001D14
        MOVE.W  (-32766).W,(A6)                 ; $001D18
        MOVE.L  #$40000010,(A5)                 ; $001D1C
        MOVE.W  (-14208).W,(A6)                 ; $001D22
        MOVE.W  (-14206).W,(A6)                 ; $001D26
        MOVE.W  #$0100,$00A11100                ; $001D2A
loc_001D32:
        BTST    #0,$00A11100                    ; $001D32
        BNE.S  loc_001D32                       ; $001D3A
        MOVE.W  (-14220).W,D4                   ; $001D3C
        BSET    #4,D4                           ; $001D40
        MOVE.W  D4,(A5)                         ; $001D44
        MOVE.L  #$93409400,(A5)                 ; $001D46
        MOVE.L  #$954096C2,(A5)                 ; $001D4C
        MOVE.W  #$977F,(A5)                     ; $001D52
        MOVE.W  #$C000,(A5)                     ; $001D56
        MOVE.W  #$0080,(-14218).W               ; $001D5A
        MOVE.W  (-14218).W,(A5)                 ; $001D60
        MOVE.W  (-14220).W,(A5)                 ; $001D64
        MOVE.W  #$0000,$00A11100                ; $001D68
        BTST    #0,$00A15123                    ; $001D70
        BEQ.S  loc_001DBC                       ; $001D78
        BCLR    #0,$00A15123                    ; $001D7A
        MOVE.W  #$0000,(-14210).W               ; $001D82
        BCLR    #7,$00A15100                    ; $001D88
loc_001D90:
        BTST    #7,$00A1518A                    ; $001D90
        BEQ.S  loc_001D90                       ; $001D98
        BCHG    #0,(-14324).W                   ; $001D9A
        BNE.S  loc_001DAC                       ; $001DA0
        BSET    #0,$00A1518B                    ; $001DA2
        BRA.S  loc_001DB4                       ; $001DAA
loc_001DAC:
        BCLR    #0,$00A1518B                    ; $001DAC
loc_001DB4:
        BSET    #7,$00A15100                    ; $001DB4
loc_001DBC:
        RTS                                     ; $001DBC
        MOVE.W  (A5),D0                         ; $001DBE
        MOVE.W  #$0063,D7                       ; $001DC0
loc_001DC4:
        NOP                                     ; $001DC4
        DBRA    D7,loc_001DC4                   ; $001DC6
        MOVE.L  #$6C000003,(A5)                 ; $001DCA
        MOVE.W  (-32768).W,(A6)                 ; $001DD0
        MOVE.W  (-32766).W,(A6)                 ; $001DD4
        MOVE.L  #$40000010,(A5)                 ; $001DD8
        MOVE.W  (-14208).W,(A6)                 ; $001DDE
        MOVE.W  (-14206).W,(A6)                 ; $001DE2
        BTST    #0,$00A15123                    ; $001DE6
        BEQ.S  loc_001E40                       ; $001DEE
        BCLR    #0,$00A15123                    ; $001DF0
        CMPI.B  #$18,(-14139).W                 ; $001DF8
        BNE.S  loc_001E06                       ; $001DFE
        MOVE.W  #$0000,(-14210).W               ; $001E00
loc_001E06:
        MOVE.B  #$00,(-14140).W                 ; $001E06
        BCLR    #7,$00A15100                    ; $001E0C
loc_001E14:
        BTST    #7,$00A1518A                    ; $001E14
        BEQ.S  loc_001E14                       ; $001E1C
        BCHG    #0,(-14324).W                   ; $001E1E
        BNE.S  loc_001E30                       ; $001E24
        BSET    #0,$00A1518B                    ; $001E26
        BRA.S  loc_001E38                       ; $001E2E
loc_001E30:
        BCLR    #0,$00A1518B                    ; $001E30
loc_001E38:
        BSET    #7,$00A15100                    ; $001E38
loc_001E40:
        RTS                                     ; $001E40
; ----------------------------------------------------------------------------
; vint_state_fb_setup ($001E42) - Frame buffer setup
; ----------------------------------------------------------------------------
vint_state_fb_setup:
        MOVE.W  (A5),D0                         ; $001E42
        MOVE.L  #$6C000003,(A5)                 ; $001E44
        MOVE.W  (-32768).W,(A6)                 ; $001E4A
        MOVE.W  (-32766).W,(A6)                 ; $001E4E
        MOVE.L  #$40000010,(A5)                 ; $001E52
        MOVE.W  (-14208).W,(A6)                 ; $001E58
        MOVE.W  (-14206).W,(A6)                 ; $001E5C
        MOVE.W  #$0000,(-14210).W               ; $001E60
        BCHG    #0,(-14324).W                   ; $001E66
        BNE.S  loc_001E78                       ; $001E6C
        BSET    #0,$00A1518B                    ; $001E6E
        BRA.S  loc_001E80                       ; $001E76
loc_001E78:
        BCLR    #0,$00A1518B                    ; $001E78
loc_001E80:
        LEA     (-24320).W,A0                   ; $001E80
        LEA     $00A15200,A1                    ; $001E84
        MOVEQ   #$7F,D0                         ; $001E8A
loc_001E8C:
        MOVE.L  (A0)+,(A1)+                     ; $001E8C
        DBRA    D0,loc_001E8C                   ; $001E8E
        RTS                                     ; $001E92
; ----------------------------------------------------------------------------
; vint_state_fb_palette ($001E94) - FB + palette
; ----------------------------------------------------------------------------
vint_state_fb_palette:
        MOVE.W  (A5),D0                         ; $001E94
        MOVE.W  #$0100,$00A11100                ; $001E96
loc_001E9E:
        BTST    #0,$00A11100                    ; $001E9E
        BNE.S  loc_001E9E                       ; $001EA6
        MOVE.W  (-14220).W,D4                   ; $001EA8
        BSET    #4,D4                           ; $001EAC
        MOVE.W  D4,(A5)                         ; $001EB0
        MOVE.L  #$93209400,(A5)                 ; $001EB2
        MOVE.L  #$950096D8,(A5)                 ; $001EB8
        MOVE.W  #$977F,(A5)                     ; $001EBE
        MOVE.W  #$C000,(A5)                     ; $001EC2
        MOVE.W  #$0080,(-14218).W               ; $001EC6
        MOVE.W  (-14218).W,(A5)                 ; $001ECC
        MOVE.W  (-14220).W,(A5)                 ; $001ED0
        MOVE.W  #$0000,$00A11100                ; $001ED4
        BTST    #0,$00A15123                    ; $001EDC
        BEQ.S  loc_001F48                       ; $001EE4
        BCLR    #0,$00A15123                    ; $001EE6
        CMPI.B  #$18,(-14139).W                 ; $001EEE
        BNE.S  loc_001EFC                       ; $001EF4
        MOVE.W  #$0000,(-14210).W               ; $001EF6
loc_001EFC:
        MOVE.B  #$00,(-14140).W                 ; $001EFC
        BCLR    #7,$00A15100                    ; $001F02
loc_001F0A:
        BTST    #7,$00A1518A                    ; $001F0A
        BEQ.S  loc_001F0A                       ; $001F12
        LEA     (-19456).W,A1                   ; $001F14
        LEA     $00A15200,A2                    ; $001F18
        JSR     $0048D6(PC)                     ; $001F1E
        JSR     $0048DA(PC)                     ; $001F22
        BCHG    #0,(-14324).W                   ; $001F26
        BNE.S  loc_001F38                       ; $001F2C
        BSET    #0,$00A1518B                    ; $001F2E
        BRA.S  loc_001F40                       ; $001F36
loc_001F38:
        BCLR    #0,$00A1518B                    ; $001F38
loc_001F40:
        BSET    #7,$00A15100                    ; $001F40
loc_001F48:
        RTS                                     ; $001F48
; ----------------------------------------------------------------------------
; vint_state_fb_dma ($001F4A) - FB DMA
; ----------------------------------------------------------------------------
vint_state_fb_dma:
        MOVE.W  (A5),D0                         ; $001F4A
        MOVE.L  #$6C000003,(A5)                 ; $001F4C
        MOVE.W  (-32768).W,(A6)                 ; $001F52
        MOVE.W  (-32766).W,(A6)                 ; $001F56
        MOVE.L  #$40000010,(A5)                 ; $001F5A
        MOVE.W  (-14208).W,(A6)                 ; $001F60
        MOVE.W  (-14206).W,(A6)                 ; $001F64
        MOVE.W  #$0100,$00A11100                ; $001F68
loc_001F70:
        BTST    #0,$00A11100                    ; $001F70
        BNE.S  loc_001F70                       ; $001F78
        MOVE.W  (-14220).W,D4                   ; $001F7A
        BSET    #4,D4                           ; $001F7E
        MOVE.W  D4,(A5)                         ; $001F82
        MOVE.L  #$93209400,(A5)                 ; $001F84
        MOVE.L  #$954096C2,(A5)                 ; $001F8A
        MOVE.W  #$977F,(A5)                     ; $001F90
        MOVE.W  #$C000,(A5)                     ; $001F94
        MOVE.W  #$0080,(-14218).W               ; $001F98
        MOVE.W  (-14218).W,(A5)                 ; $001F9E
        MOVE.W  (-14220).W,(A5)                 ; $001FA2
        MOVE.W  #$0000,$00A11100                ; $001FA6
        BTST    #0,$00A15123                    ; $001FAE
        BEQ.S  loc_00200E                       ; $001FB6
        BCLR    #0,$00A15123                    ; $001FB8
        MOVE.W  #$0000,(-14210).W               ; $001FC0
        BCLR    #7,$00A15100                    ; $001FC6
loc_001FCE:
        BTST    #7,$00A1518A                    ; $001FCE
        BEQ.S  loc_001FCE                       ; $001FD6
        LEA     $00FF6E00,A1                    ; $001FD8
        LEA     $00A15200,A2                    ; $001FDE
        JSR     $0048D6(PC)                     ; $001FE4
        JSR     $0048DA(PC)                     ; $001FE8
        BCHG    #0,(-14324).W                   ; $001FEC
        BNE.S  loc_001FFE                       ; $001FF2
        BSET    #0,$00A1518B                    ; $001FF4
        BRA.S  loc_002006                       ; $001FFC
loc_001FFE:
        BCLR    #0,$00A1518B                    ; $001FFE
loc_002006:
        BSET    #7,$00A15100                    ; $002006
loc_00200E:
        RTS                                     ; $00200E
; ----------------------------------------------------------------------------
; vint_state_cleanup ($002010) - Clear SH2 flags
; ----------------------------------------------------------------------------
vint_state_cleanup:
        MOVE.W  (A5),D0                         ; $002010
        BTST    #0,$00A15123                    ; $002012
        BEQ.S  loc_002038                       ; $00201A
        BCLR    #0,$00A15123                    ; $00201C
        CMPI.B  #$18,(-14139).W                 ; $002024
        BNE.S  loc_002032                       ; $00202A
        MOVE.W  #$0000,(-14210).W               ; $00202C
loc_002032:
        MOVE.B  #$00,(-14140).W                 ; $002032
loc_002038:
        RTS                                     ; $002038
loc_00203A:
; ----------------------------------------------------------------------------
; sh2_frame_sync ($00203A) - SH2 frame sync wrapper
; ----------------------------------------------------------------------------
sh2_frame_sync:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,-(A7); $00203A
        JSR     $008B0004                       ; $00203E
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6; $002044
        RTS                                     ; $002048
        MOVEQ   #$00,D0                         ; $00204A
        MOVE.W  D0,(-14172).W                   ; $00204C
        MOVE.B  D0,(-14302).W                   ; $002050
        MOVE.B  D0,(-14301).W                   ; $002054
        MOVE.W  D0,(-14174).W                   ; $002058
        RTS                                     ; $00205C
        MOVE.B  #$F0,(-14302).W                 ; $00205E
        RTS                                     ; $002064
        MOVE.B  #$03,(-31482).W                 ; $002066
        MOVE.B  #$30,(-31484).W                 ; $00206C
        MOVEQ   #$00,D0                         ; $002072
        MOVE.B  D0,(-14302).W                   ; $002074
        MOVE.L  D0,(-14172).W                   ; $002078
        RTS                                     ; $00207C
        RTS                                     ; $00207E
; ----------------------------------------------------------------------------
; pre_dispatch_common ($002080) - Common pre-dispatch function
; ----------------------------------------------------------------------------
pre_dispatch_common:
        MOVE.B  (-14302).W,D0                   ; $002080
        BEQ.S  loc_002096                       ; $002084
        MOVE.B  D0,(-31479).W                   ; $002086
        MOVEQ   #$00,D0                         ; $00208A
        MOVE.B  D0,(-14302).W                   ; $00208C
        MOVE.L  D0,(-14172).W                   ; $002090
        BRA.S  loc_0020C6                       ; $002094
loc_002096:
        MOVE.B  (-14171).W,D0                   ; $002096
        BEQ.S  loc_0020B2                       ; $00209A
        CMP.B  (-14169).W,D0                    ; $00209C
        BEQ.S  loc_0020AA                       ; $0020A0
        MOVE.B  D0,(-31478).W                   ; $0020A2
        MOVE.B  D0,(-14169).W                   ; $0020A6
loc_0020AA:
        MOVE.B  #$00,(-14171).W                 ; $0020AA
        BRA.S  loc_0020C6                       ; $0020B0
loc_0020B2:
        MOVE.B  (-14172).W,D0                   ; $0020B2
        BEQ.S  loc_0020C6                       ; $0020B6
        MOVE.B  D0,(-31478).W                   ; $0020B8
        MOVE.B  D0,(-14170).W                   ; $0020BC
        MOVE.B  #$00,(-14172).W                 ; $0020C0
loc_0020C6:
; ----------------------------------------------------------------------------
; sound_flag_handler ($0020C6) - Sound flag handling (5 calls)
; ----------------------------------------------------------------------------
sound_flag_handler:
        MOVEM.L A5/A6,-(A7)                     ; $0020C6
        JSR     $008B0000                       ; $0020CA
        MOVEM.L (A7)+,A5/A6                     ; $0020D0
        RTS                                     ; $0020D4
        TST.B  (-31478).W                       ; $0020D6
        BNE.S  loc_0020F8                       ; $0020DA
        BTST    #5,(-15602).W                   ; $0020DC
        BNE.S  loc_0020F8                       ; $0020E2
        MOVE.B  (-14172).W,(-31478).W           ; $0020E4
        BEQ.S  loc_0020F8                       ; $0020EA
        MOVE.B  (-14172).W,(-14170).W           ; $0020EC
        MOVE.B  #$00,(-14172).W                 ; $0020F2
loc_0020F8:
        MOVEM.L A5/A6,-(A7)                     ; $0020F8
        JSR     $008B0000                       ; $0020FC
        MOVEM.L (A7)+,A5/A6                     ; $002102
        JMP     $00232E(PC)                     ; $002106
        TST.B  (-31478).W                       ; $00210A
        BNE.S  loc_00211C                       ; $00210E
        MOVE.B  (-14171).W,(-31478).W           ; $002110
        MOVE.B  #$00,(-14171).W                 ; $002116
loc_00211C:
        MOVEM.L A5/A6,-(A7)                     ; $00211C
        JSR     $008B0000                       ; $002120
        MOVEM.L (A7)+,A5/A6                     ; $002126
        JMP     $00232E(PC)                     ; $00212A
        MOVE.B  (-14302).W,D0                   ; $00212E
        BEQ.S  loc_002142                       ; $002132
        MOVE.B  D0,(-31479).W                   ; $002134
        MOVEQ   #$00,D0                         ; $002138
        MOVE.B  D0,(-14302).W                   ; $00213A
        MOVE.L  D0,(-14172).W                   ; $00213E
loc_002142:
        MOVEM.L A5/A6,-(A7)                     ; $002142
        JSR     $008B0000                       ; $002146
        MOVEM.L (A7)+,A5/A6                     ; $00214C
        JMP     $00232E(PC)                     ; $002150
        TST.B  (-31478).W                       ; $002154
        BNE.S  loc_00216E                       ; $002158
        MOVE.B  (-14172).W,(-31478).W           ; $00215A
        BEQ.S  loc_00216E                       ; $002160
        MOVE.B  (-14172).W,(-14170).W           ; $002162
        MOVE.B  #$00,(-14172).W                 ; $002168
loc_00216E:
        MOVEM.L A5/A6,-(A7)                     ; $00216E
        JSR     $008B0000                       ; $002172
        MOVEM.L (A7)+,A5/A6                     ; $002178
        JMP     $00220C(PC)                     ; $00217C
        TST.B  (-31478).W                       ; $002180
        BNE.S  loc_002192                       ; $002184
        MOVE.B  (-14171).W,(-31478).W           ; $002186
        MOVE.B  #$00,(-14171).W                 ; $00218C
loc_002192:
        MOVEM.L A5/A6,-(A7)                     ; $002192
        JSR     $008B0000                       ; $002196
        MOVEM.L (A7)+,A5/A6                     ; $00219C
        JMP     $00220C(PC)                     ; $0021A0
        MOVE.B  (-14302).W,D0                   ; $0021A4
        BEQ.S  loc_0021B8                       ; $0021A8
        MOVE.B  D0,(-31479).W                   ; $0021AA
        MOVEQ   #$00,D0                         ; $0021AE
        MOVE.B  D0,(-14302).W                   ; $0021B0
        MOVE.L  D0,(-14172).W                   ; $0021B4
loc_0021B8:
        MOVEM.L A5/A6,-(A7)                     ; $0021B8
        JSR     $008B0000                       ; $0021BC
        MOVEM.L (A7)+,A5/A6                     ; $0021C2
        JMP     $00220C(PC)                     ; $0021C6
; ----------------------------------------------------------------------------
; sfx_queue_process ($0021CA) - Sound effect queue handler (9 calls)
; ----------------------------------------------------------------------------
sfx_queue_process:
        MOVE.B  (-14302).W,D0                   ; $0021CA
        BEQ.S  loc_0021DE                       ; $0021CE
        MOVE.B  D0,(-31479).W                   ; $0021D0
        MOVEQ   #$00,D0                         ; $0021D4
        MOVE.B  D0,(-14302).W                   ; $0021D6
        MOVE.L  D0,(-14172).W                   ; $0021DA
loc_0021DE:
        MOVEM.L A5/A6,-(A7)                     ; $0021DE
        JSR     $008B0000                       ; $0021E2
        MOVEM.L (A7)+,A5/A6                     ; $0021E8
        RTS                                     ; $0021EC
        MOVE.B  #$0A,(-14297).W                 ; $0021EE
        MOVE.B  #$0F,(-14296).W                 ; $0021F4
        TST.W  (-14136).W                       ; $0021FA
        BEQ.S  $002204                          ; $0021FE
