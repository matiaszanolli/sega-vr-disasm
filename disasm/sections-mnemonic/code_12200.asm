; Generated assembly for $012200-$014200
; Branch targets: 243
; Labels: 221
; Format: DC.W with decoded mnemonics as comments

        org     $012200

        SUB.W  $0401(A7),D0                     ; $012200
        SUBA.W  A7,A0                           ; $012204
        SUBI.B  #$C010,D1                       ; $012206
        DC.W    $003A,$0401,$C049   ; $01220A ORI.B  #$0401,-$3FB7(PC)
        DC.W    $003B,$0401,$C083   ; $012210 ORI.B  #$0401,-$7D(PC,A4.W)
        DC.W    $003A,$0401,$C0BC   ; $012216 ORI.B  #$0401,-$3F44(PC)
        DC.W    $003A,$0401,$C0F5   ; $01221C ORI.B  #$0401,-$3F0B(PC)
        DC.W    $003B,$4240,$4EBA   ; $012222 ORI.B  #$4240,-$46(PC,D4.L)
        AND.B  D1,D4                            ; $012228
        JSR     $00B684(PC)                     ; $01222A
        JSR     $00B6DA(PC)                     ; $01222E
        MOVEA.L $A030.W,A1                      ; $012232
        MOVE.L  $A01E.W,D0                      ; $012236
        MOVE.L  $A022.W,D1                      ; $01223A
        MOVEQ   #$00,D2                         ; $01223E
        MOVE.W  $A02C.W,D2                      ; $012240
        BSR.W  loc_012534                       ; $012244
        MOVEA.L #$0601AD00,A0                   ; $012248
        MOVEA.L #$04008020,A1                   ; $01224E
        MOVE.W  #$0110,D0                       ; $012254
        MOVE.W  #$0010,D1                       ; $012258
        JSR     $00E35A(PC)                     ; $01225C
loc_012260:
        TST.B  $00A15120                        ; $012260
        BNE.S  loc_012260                       ; $012266
        DC.W    $33FC,$0101,$00A1,$512C; $012268 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$A000,$00A1,$5128; $012270 MOVE.W  #$A000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $012278 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $012280 MOVE.B  #$0001,$00A15120
loc_012288:
        TST.B  $00A1512C                        ; $012288
        BNE.S  loc_012288                       ; $01228E
        DC.W    $33FC,$0018,$00A1,$5128; $012290 MOVE.W  #$0018,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $012298 MOVE.W  #$0101,$00A1512C
        MOVEA.L #$06018580,A0                   ; $0122A0
        LEA     $04035018,A1                    ; $0122A6
        MOVE.W  #$0038,D0                       ; $0122AC
        MOVE.W  #$0010,D1                       ; $0122B0
        JSR     $00E35A(PC)                     ; $0122B4
        LEA     $04035060,A1                    ; $0122B8
        LEA     $FA48.W,A2                      ; $0122BE
        MOVE.L  $A01E.W,D0                      ; $0122C2
        ADD.W  D0,D0                            ; $0122C6
        ADD.W  D0,D0                            ; $0122C8
        ADD.W  D0,D0                            ; $0122CA
        MOVE.W  D0,D1                           ; $0122CC
        ADD.W  D0,D0                            ; $0122CE
        ADD.W  D1,D0                            ; $0122D0
        ADD.W  D0,D0                            ; $0122D2
        ADDA.L  D0,A2                           ; $0122D4
        MOVE.L  $A022.W,D0                      ; $0122D6
        ADD.W  D0,D0                            ; $0122DA
        ADD.W  D0,D0                            ; $0122DC
        ADD.W  D0,D0                            ; $0122DE
        ADDA.L  D0,A2                           ; $0122E0
        BSR.W  loc_01260A                       ; $0122E2
        ADDA.L  #$00000010,A1                   ; $0122E6
        MOVE.B  (A2)+,D5                        ; $0122EC
        BSR.W  loc_01259C                       ; $0122EE
        ADDA.L  #$00000020,A1                   ; $0122F2
        BSR.W  loc_0126A6                       ; $0122F8
        MOVEA.L #$06030000,A0                   ; $0122FC
        LEA     $040378A2,A1                    ; $012302
        MOVE.W  #$0088,D0                       ; $012308
        MOVE.W  #$0008,D1                       ; $01230C
        JSR     $00E35A(PC)                     ; $012310
        TST.L  $A026.W                          ; $012314
        BEQ.W  loc_01235A                       ; $012318
        MOVE.L  $A030.W,D1                      ; $01231C
        MOVE.L  $A026.W,D2                      ; $012320
        ADD.L  D2,D1                            ; $012324
        MOVE.L  D1,$A030.W                      ; $012326
        MOVE.L  $A034.W,D1                      ; $01232A
        ADD.L  D2,D1                            ; $01232E
        MOVE.L  D1,$A034.W                      ; $012330
        SUBQ.W  #1,$A02A.W                      ; $012334
        BCC.W  loc_0124FE                       ; $012338
        TST.L  $A026.W                          ; $01233C
        BPL.S  loc_012346                       ; $012340
        ADDQ.W  #1,$A02C.W                      ; $012342
loc_012346:
        CLR.L  $A026.W                          ; $012346
        DC.W    $21FC,$0402,$A060,$A030; $01234A MOVE.L  #$0402A060,$A030.W
        DC.W    $21FC,$0402,$A020,$A034; $012352 MOVE.L  #$0402A020,$A034.W
loc_01235A:
        CMPI.W  #$0001,$A038.W                  ; $01235A
        BEQ.W  loc_0124CE                       ; $012360
        CMPI.W  #$0002,$A038.W                  ; $012364
        BEQ.W  loc_0124E4                       ; $01236A
        JSR     $0088179E                       ; $01236E
        MOVE.W  $C86C.W,D1                      ; $012374
        BTST    #4,D1                           ; $012378
        BEQ.S  loc_012380                       ; $01237C
        BRA.S  loc_012386                       ; $01237E
loc_012380:
        BTST    #7,D1                           ; $012380
        BEQ.S  loc_0123B4                       ; $012384
loc_012386:
        MOVE.B  #$00A8,$C8A4.W                  ; $012386
        MOVE.W  #$0002,$A038.W                  ; $01238C
        MOVE.B  #$0001,$C809.W                  ; $012392
        MOVE.B  #$0001,$C80A.W                  ; $012398
        BSET    #7,$C80E.W                      ; $01239E
        MOVE.B  #$0001,$C802.W                  ; $0123A4
        JSR     $0088205E                       ; $0123AA
        BRA.W  loc_0124FE                       ; $0123B0
loc_0123B4:
        BTST    #2,D1                           ; $0123B4
        BEQ.S  loc_0123E8                       ; $0123B8
        MOVE.B  #$00A9,$C8A4.W                  ; $0123BA
        TST.B  $A019.W                          ; $0123C0
        BEQ.S  loc_0123CE                       ; $0123C4
        SUBQ.B  #1,$A019.W                      ; $0123C6
        BRA.W  loc_0124FE                       ; $0123CA
loc_0123CE:
        TST.B  $A01A.W                          ; $0123CE
        BNE.S  loc_0123DE                       ; $0123D2
        MOVE.B  #$0002,$A019.W                  ; $0123D4
        BRA.W  loc_0124FE                       ; $0123DA
loc_0123DE:
        MOVE.B  #$0004,$A019.W                  ; $0123DE
        BRA.W  loc_0124FE                       ; $0123E4
loc_0123E8:
        BTST    #3,D1                           ; $0123E8
        BEQ.S  loc_012422                       ; $0123EC
        MOVE.B  #$00A9,$C8A4.W                  ; $0123EE
        TST.B  $A01A.W                          ; $0123F4
        BNE.S  loc_01240A                       ; $0123F8
        CMPI.B  #$0002,$A019.W                  ; $0123FA
        BGE.S  loc_01241A                       ; $012400
        ADDQ.B  #1,$A019.W                      ; $012402
        BRA.W  loc_0124FE                       ; $012406
loc_01240A:
        CMPI.B  #$0004,$A019.W                  ; $01240A
        BGE.S  loc_01241A                       ; $012410
        ADDQ.B  #1,$A019.W                      ; $012412
        BRA.W  loc_0124FE                       ; $012416
loc_01241A:
        CLR.B  $A019.W                          ; $01241A
        BRA.W  loc_0124FE                       ; $01241E
loc_012422:
        BTST    #0,D1                           ; $012422
        BEQ.S  loc_01244A                       ; $012426
        TST.B  $A01A.W                          ; $012428
        BEQ.W  loc_0124FE                       ; $01242C
        MOVE.B  #$00A9,$C8A4.W                  ; $012430
        MOVE.B  $A019.W,$A01C.W                 ; $012436
        MOVE.B  $A01B.W,$A019.W                 ; $01243C
        CLR.B  $A01A.W                          ; $012442
        BRA.W  loc_0124FE                       ; $012446
loc_01244A:
        BTST    #1,D1                           ; $01244A
        BEQ.S  loc_012474                       ; $01244E
        TST.B  $A01A.W                          ; $012450
        BNE.W  loc_0124FE                       ; $012454
        MOVE.B  #$00A9,$C8A4.W                  ; $012458
        MOVE.B  $A019.W,$A01B.W                 ; $01245E
        MOVE.B  $A01C.W,$A019.W                 ; $012464
        MOVE.B  #$0001,$A01A.W                  ; $01246A
        BRA.W  loc_0124FE                       ; $012470
loc_012474:
        LSR.W  #8,D1                            ; $012474
        BTST    #6,D1                           ; $012476
        BEQ.S  loc_0124AA                       ; $01247A
        TST.W  $A02C.W                          ; $01247C
        BEQ.W  loc_0124FE                       ; $012480
        DC.W    $21FC,$0000,$0400,$A026; $012484 MOVE.L  #$00000400,$A026.W
        MOVE.W  #$0007,$A02A.W                  ; $01248C
        SUBQ.W  #1,$A02C.W                      ; $012492
        DC.W    $04B8,$0000,$2000,$A030; $012496 SUBI.L  #$00002000,$A030.W
        DC.W    $04B8,$0000,$2000,$A034; $01249E SUBI.L  #$00002000,$A034.W
        BRA.W  loc_0124FE                       ; $0124A6
loc_0124AA:
        BTST    #5,D1                           ; $0124AA
        BEQ.W  loc_0124FE                       ; $0124AE
        CMPI.W  #$000F,$A02C.W                  ; $0124B2
        BGE.W  loc_0124FE                       ; $0124B8
        DC.W    $21FC,$FFFF,$FC00,$A026; $0124BC MOVE.L  #$FFFFFC00,$A026.W
        MOVE.W  #$0007,$A02A.W                  ; $0124C4
        BRA.W  loc_0124FE                       ; $0124CA
loc_0124CE:
        JSR     $0088FB36                       ; $0124CE
        BTST    #6,$C80E.W                      ; $0124D4
        BNE.S  loc_0124FE                       ; $0124DA
        CLR.W  $A038.W                          ; $0124DC
        BRA.W  loc_0124FE                       ; $0124E0
loc_0124E4:
        JSR     $0088FB36                       ; $0124E4
        BTST    #7,$C80E.W                      ; $0124EA
        BNE.S  loc_0124FE                       ; $0124F0
        CLR.W  $A038.W                          ; $0124F2
        ADDQ.W  #4,$C87E.W                      ; $0124F6
        BRA.W  loc_012502                       ; $0124FA
loc_0124FE:
        SUBQ.W  #4,$C87E.W                      ; $0124FE
loc_012502:
        DC.W    $33FC,$0018,$00FF,$0008; $012502 MOVE.W  #$0018,$00FF0008
        RTS                                     ; $01250A
loc_01250C:
        TST.B  $00A15120                        ; $01250C
        BNE.S  loc_01250C                       ; $012512
        CLR.B  $00A15123                        ; $012514
        MOVE.W  #$0000,$C87E.W                  ; $01251A
        DC.W    $33FC,$0020,$00FF,$0008; $012520 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0089,$26D2,$00FF,$0002; $012528 MOVE.L  #$008926D2,$00FF0002
        RTS                                     ; $012532
loc_012534:
        LEA     $EF08.W,A2                      ; $012534
        MOVEQ   #$00,D3                         ; $012538
        TST.B  D0                               ; $01253A
        BEQ.S  loc_01254A                       ; $01253C
        SUBQ.W  #1,D0                           ; $01253E
loc_012540:
        ADDI.L  #$000003C0,D3                   ; $012540
        DBRA    D0,loc_012540                   ; $012546
loc_01254A:
        ADDA.L  D3,A2                           ; $01254A
        ADD.W  D1,D1                            ; $01254C
        ADD.W  D1,D1                            ; $01254E
        ADD.W  D1,D1                            ; $012550
        ADD.W  D1,D1                            ; $012552
        MOVE.W  D1,D3                           ; $012554
        ADD.W  D1,D1                            ; $012556
        ADD.W  D1,D1                            ; $012558
        ADD.W  D3,D1                            ; $01255A
        ADD.W  D1,D1                            ; $01255C
        ADDA.L  D1,A2                           ; $01255E
        ADD.W  D2,D2                            ; $012560
        ADD.W  D2,D2                            ; $012562
        ADD.W  D2,D2                            ; $012564
        ADDA.L  D2,A2                           ; $012566
        MOVE.W  #$0005,D4                       ; $012568
        MOVEA.L A1,A3                           ; $01256C
        MOVEA.L A2,A4                           ; $01256E
loc_012570:
        MOVEA.L A3,A1                           ; $012570
        MOVEA.L A4,A2                           ; $012572
        BSR.W  loc_01260A                       ; $012574
        ADDA.L  #$00000010,A1                   ; $012578
        MOVE.B  (A2)+,D5                        ; $01257E
        BSR.W  loc_01259C                       ; $012580
        ADDA.L  #$00000020,A1                   ; $012584
        BSR.W  loc_0126A6                       ; $01258A
        ADDA.L  #$00002000,A3                   ; $01258E
        ADDQ.L  #8,A4                           ; $012594
        DBRA    D4,loc_012570                   ; $012596
        RTS                                     ; $01259A
loc_01259C:
        MOVE.B  (A2)+,D3                        ; $01259C
        BSR.W  loc_0125D0                       ; $01259E
        MOVE.W  #$000A,D1                       ; $0125A2
        BSR.W  loc_0125EC                       ; $0125A6
        ADDQ.L  #8,A1                           ; $0125AA
        MOVE.B  (A2)+,D3                        ; $0125AC
        BSR.W  loc_0125D0                       ; $0125AE
        MOVE.W  #$000B,D1                       ; $0125B2
        BSR.W  loc_0125EC                       ; $0125B6
        ADDQ.L  #8,A1                           ; $0125BA
        MOVE.B  (A2)+,D1                        ; $0125BC
        ANDI.W  #$000F,D1                       ; $0125BE
        BSR.W  loc_0125EC                       ; $0125C2
        ADDQ.L  #8,A1                           ; $0125C6
        MOVE.B  (A2)+,D3                        ; $0125C8
        BSR.W  loc_0125D0                       ; $0125CA
        RTS                                     ; $0125CE
loc_0125D0:
        MOVE.B  D3,D1                           ; $0125D0
        LSR.B  #4,D1                            ; $0125D2
        ANDI.W  #$000F,D1                       ; $0125D4
        BSR.W  loc_0125EC                       ; $0125D8
        ADDQ.L  #8,A1                           ; $0125DC
        MOVE.W  D3,D1                           ; $0125DE
        ANDI.W  #$000F,D1                       ; $0125E0
        BSR.W  loc_0125EC                       ; $0125E4
        ADDQ.L  #8,A1                           ; $0125E8
        RTS                                     ; $0125EA
loc_0125EC:
        LSL.W  #6,D1                            ; $0125EC
        MOVE.W  D1,D0                           ; $0125EE
        LSL.W  #1,D1                            ; $0125F0
        ADD.W  D0,D1                            ; $0125F2
        MOVEA.L #$0601F000,A0                   ; $0125F4
        ADDA.W  D1,A0                           ; $0125FA
        MOVE.W  #$000C,D0                       ; $0125FC
        MOVE.W  #$0010,D1                       ; $012600
        JSR     $00E35A(PC)                     ; $012604
        RTS                                     ; $012608
loc_01260A:
        MOVE.W  #$0002,D2                       ; $01260A
loc_01260E:
        MOVE.B  (A2)+,D1                        ; $01260E
        BSR.S  loc_012618                       ; $012610
        DBRA    D2,loc_01260E                   ; $012612
        RTS                                     ; $012616
loc_012618:
        CMPI.B  #$0060,D1                       ; $012618
        BGT.W  loc_012648                       ; $01261C
        CMPI.B  #$0040,D1                       ; $012620
        BGT.W  loc_012660                       ; $012624
        CMPI.B  #$0020,D1                       ; $012628
        BEQ.W  loc_0126A2                       ; $01262C
        CMPI.B  #$0021,D1                       ; $012630
        BEQ.W  loc_012676                       ; $012634
        CMPI.B  #$002E,D1                       ; $012638
        BEQ.W  loc_01267C                       ; $01263C
        MOVE.W  #$0036,D1                       ; $012640
        BRA.W  loc_012680                       ; $012644
loc_012648:
        SUBI.B  #$0047,D1                       ; $012648
        ANDI.W  #$00FF,D1                       ; $01264C
        CMPI.W  #$0033,D1                       ; $012650
        BLE.W  loc_012680                       ; $012654
        MOVE.W  #$0036,D1                       ; $012658
        BRA.W  loc_012680                       ; $01265C
loc_012660:
        SUBI.B  #$0041,D1                       ; $012660
        ANDI.W  #$00FF,D1                       ; $012664
        CMPI.W  #$0019,D1                       ; $012668
        BLE.W  loc_012680                       ; $01266C
        MOVE.W  #$0036,D1                       ; $012670
        BRA.S  loc_012680                       ; $012674
loc_012676:
        MOVE.W  #$0035,D1                       ; $012676
        BRA.S  loc_012680                       ; $01267A
loc_01267C:
        MOVE.W  #$0034,D1                       ; $01267C
loc_012680:
        LEA     $060207C0,A0                    ; $012680
        TST.W  D1                               ; $012686
        BEQ.S  loc_012696                       ; $012688
        SUBQ.W  #1,D1                           ; $01268A
loc_01268C:
        ADDA.L  #$000000C0,A0                   ; $01268C
        DBRA    D1,loc_01268C                   ; $012692
loc_012696:
        MOVE.W  #$000C,D0                       ; $012696
        MOVE.W  #$0010,D1                       ; $01269A
        JSR     $00E35A(PC)                     ; $01269E
loc_0126A2:
        ADDQ.L  #8,A1                           ; $0126A2
        RTS                                     ; $0126A4
loc_0126A6:
        MOVEA.L #$0601F9C0,A0                   ; $0126A6
        MOVEQ   #$00,D0                         ; $0126AC
        ANDI.W  #$0003,D5                       ; $0126AE
        TST.W  D5                               ; $0126B2
        BEQ.S  loc_0126C2                       ; $0126B4
        SUBQ.W  #1,D5                           ; $0126B6
loc_0126B8:
        ADDI.L  #$00000380,D0                   ; $0126B8
        DBRA    D5,loc_0126B8                   ; $0126BE
loc_0126C2:
        ADDA.L  D0,A0                           ; $0126C2
        MOVE.W  #$0038,D0                       ; $0126C4
        MOVE.W  #$0010,D1                       ; $0126C8
        JSR     $00E35A(PC)                     ; $0126CC
        RTS                                     ; $0126D0
        DC.W    $33FC,$002C,$00FF,$0008; $0126D2 MOVE.W  #$002C,$00FF0008
        MOVE.W  #$002C,$C87A.W                  ; $0126DA
        BCLR    #6,$C875.W                      ; $0126E0
        MOVE.W  $C874.W,(A5)                    ; $0126E6
        DC.W    $33FC,$0083,$00A1,$5100; $0126EA MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $0126F2 ANDI.B  #$00FC,$00A15181
        JSR     $008826C8                       ; $0126FA
        MOVE.L  #$000A0907,D0                   ; $012700
        JSR     $008814BE                       ; $012706
        MOVE.B  #$0001,$C80D.W                  ; $01270C
        LEA     $00FF2000,A0                    ; $012712
        CLR.L  (A0)+                            ; $012718
        CLR.L  (A0)+                            ; $01271A
        CLR.L  (A0)+                            ; $01271C
        CLR.L  (A0)+                            ; $01271E
        CLR.L  (A0)+                            ; $012720
        CLR.L  (A0)+                            ; $012722
        CLR.L  (A0)+                            ; $012724
        CLR.L  (A0)+                            ; $012726
        CLR.L  (A0)+                            ; $012728
        CLR.L  (A0)+                            ; $01272A
        CLR.L  (A0)+                            ; $01272C
        CLR.L  (A0)+                            ; $01272E
        CLR.L  (A0)+                            ; $012730
        MOVEQ   #$00,D0                         ; $012732
        LEA     $8480.W,A0                      ; $012734
        MOVEQ   #$1F,D1                         ; $012738
loc_01273A:
        MOVE.L  D0,(A0)+                        ; $01273A
        DBRA    D1,loc_01273A                   ; $01273C
        LEA     $00FF7B80,A0                    ; $012740
        MOVEQ   #$7F,D1                         ; $012746
loc_012748:
        MOVE.L  D0,(A0)+                        ; $012748
        DBRA    D1,loc_012748                   ; $01274A
        MOVE.L  #$60000002,(A5)                 ; $01274E
        MOVE.W  #$17FF,D1                       ; $012754
loc_012758:
        MOVE.L  D0,(A6)                         ; $012758
        DBRA    D1,loc_012758                   ; $01275A
        JSR     $008849AA                       ; $01275E
        CLR.W  $C880.W                          ; $012764
        CLR.W  $C882.W                          ; $012768
        CLR.W  $8000.W                          ; $01276C
        MOVE.W  #$FFFC,$8002.W                  ; $012770
        CLR.W  $A012.W                          ; $012776
        CLR.B  $A018.W                          ; $01277A
        DC.W    $21FC,$0000,$0014,$A020; $01277E MOVE.L  #$00000014,$A020.W
        CLR.L  $A024.W                          ; $012786
        CLR.W  $A028.W                          ; $01278A
        BTST    #7,$FDA8.W                      ; $01278E
        BEQ.S  loc_0127AC                       ; $012794
        CMPI.B  #$0005,$C817.W                  ; $012796
        BNE.S  loc_0127AC                       ; $01279C
        DC.W    $21FC,$FFFF,$FFFC,$A024; $01279E MOVE.L  #$FFFFFFFC,$A024.W
        MOVE.W  #$0037,$A028.W                  ; $0127A6
loc_0127AC:
        JSR     $008849AA                       ; $0127AC
        MOVE.W  #$0001,$A03A.W                  ; $0127B2
        DC.W    $21FC,$008B,$B4FC,$C96C; $0127B8 MOVE.L  #$008BB4FC,$C96C.W
        MOVE.B  #$0001,$C809.W                  ; $0127C0
        MOVE.B  #$0001,$C80A.W                  ; $0127C6
        BSET    #6,$C80E.W                      ; $0127CC
        MOVE.B  #$0001,$C802.W                  ; $0127D2
        LEA     $00FF1000,A0                    ; $0127D8
        MOVE.W  #$037F,D0                       ; $0127DE
loc_0127E2:
        CLR.L  (A0)+                            ; $0127E2
        DBRA    D0,loc_0127E2                   ; $0127E4
        MOVE.W  #$0001,D0                       ; $0127E8
        MOVE.W  #$0001,D1                       ; $0127EC
        MOVE.W  #$0001,D2                       ; $0127F0
        MOVE.W  #$0026,D3                       ; $0127F4
        MOVE.W  #$001A,D4                       ; $0127F8
        LEA     $00FF1000,A0                    ; $0127FC
        JSR     $00E22C(PC)                     ; $012802
        LEA     $00FF1000,A0                    ; $012806
        JSR     $00E2F0(PC)                     ; $01280C
        JSR     $00E1BC(PC)                     ; $012810
        MOVE.L  #$0000D006,D0                   ; $012814
        MOVE.W  #$0022,D1                       ; $01281A
        MOVE.W  #$0008,D2                       ; $01281E
        MOVE.W  #$0000,D3                       ; $012822
        BSR.W  loc_012FC0                       ; $012826
        DC.W    $08B9,$0007,$00A1,$5181; $01282A BCLR    #7,$00A15181
        LEA     $00FF6E00,A0                    ; $012832
        ADDA.L  #$00000120,A0                   ; $012838
        LEA     $008929E0,A1                    ; $01283E
        MOVE.W  #$000F,D0                       ; $012844
loc_012848:
        MOVE.W  (A1)+,D1                        ; $012848
        MOVE.W  D1,(A0)+                        ; $01284A
        DBRA    D0,loc_012848                   ; $01284C
        LEA     $00FF6E00,A0                    ; $012850
        ADDA.L  #$000001A0,A0                   ; $012856
        LEA     $00892A00,A1                    ; $01285C
        MOVE.W  #$001F,D0                       ; $012862
loc_012866:
        MOVE.W  (A1)+,D1                        ; $012866
        MOVE.W  D1,(A0)+                        ; $012868
        DBRA    D0,loc_012866                   ; $01286A
        LEA     $000EA840,A0                    ; $01286E
        MOVEA.L #$06038000,A1                   ; $012874
        JSR     $00E316(PC)                     ; $01287A
        BTST    #3,$C818.W                      ; $01287E
        BNE.S  loc_01288E                       ; $012884
        TST.B  $C81B.W                          ; $012886
        BNE.S  loc_0128B2                       ; $01288A
        BRA.S  loc_0128F0                       ; $01288C
loc_01288E:
        MOVEA.L #$06038000,A0                   ; $01288E
        ADDA.L  #$00000070,A0                   ; $012894
        MOVE.W  #$0037,D0                       ; $01289A
        MOVE.W  #$0048,D1                       ; $01289E
        MOVE.W  #$FFC0,D2                       ; $0128A2
        MOVE.W  #$0150,D3                       ; $0128A6
        JSR     $0088E406                       ; $0128AA
        BRA.S  loc_0128F0                       ; $0128B0
loc_0128B2:
        MOVEA.L #$06038000,A0                   ; $0128B2
        MOVE.W  #$006F,D0                       ; $0128B8
        MOVE.W  #$0048,D1                       ; $0128BC
        MOVE.W  #$FFC0,D2                       ; $0128C0
        MOVE.W  #$0150,D3                       ; $0128C4
        JSR     $0088E406                       ; $0128C8
        MOVEA.L #$06038000,A0                   ; $0128CE
        ADDA.L  #$000000A8,A0                   ; $0128D4
        MOVE.W  #$0037,D0                       ; $0128DA
        MOVE.W  #$0048,D1                       ; $0128DE
        MOVE.W  #$FFC0,D2                       ; $0128E2
        MOVE.W  #$0150,D3                       ; $0128E6
        JSR     $0088E406                       ; $0128EA
loc_0128F0:
        LEA     $000EB790,A0                    ; $0128F0
        MOVEA.L #$0603DE80,A1                   ; $0128F6
        JSR     $00E316(PC)                     ; $0128FC
        MOVE.B  $C817.W,$A019.W                 ; $012900
        MOVE.W  #$0010,$A02C.W                  ; $012906
        MOVE.W  #$0020,$A02E.W                  ; $01290C
        MOVE.W  #$00A0,$A030.W                  ; $012912
        MOVE.W  #$0380,$A032.W                  ; $012918
        MOVE.W  #$0000,$A034.W                  ; $01291E
        MOVE.W  #$0013,$A036.W                  ; $012924
        TST.B  $C81B.W                          ; $01292A
        BEQ.W  loc_012948                       ; $01292E
        CMPI.B  #$0002,$A019.W                  ; $012932
        BEQ.S  loc_012948                       ; $012938
        CMPI.B  #$0004,$A019.W                  ; $01293A
        BEQ.S  loc_012948                       ; $012940
        MOVE.B  #$0002,$A019.W                  ; $012942
loc_012948:
        JSR     $0088204A                       ; $012948
        DC.W    $0239,$00FC,$00A1,$5181; $01294E ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $012956 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $01295E MOVE.W  #$8083,$00A15100
        BSET    #6,$C875.W                      ; $012966
        MOVE.W  $C874.W,(A5)                    ; $01296C
        DC.W    $33FC,$0020,$00FF,$0008; $012970 MOVE.W  #$0020,$00FF0008
        JSR     $00884998                       ; $012978
        MOVE.W  #$0000,$C87E.W                  ; $01297E
        DC.W    $23FC,$0089,$2A40,$00FF,$0002; $012984 MOVE.L  #$00892A40,$00FF0002
        BCLR    #0,$C80B.W                      ; $01298E
        MOVE.B  #$0081,$C8A5.W                  ; $012994
        LEA     $00FF6100,A0                    ; $01299A
        MOVE.W  #$007F,D0                       ; $0129A0
loc_0129A4:
        CLR.L  (A0)+                            ; $0129A4
        CLR.L  (A0)+                            ; $0129A6
        CLR.L  (A0)+                            ; $0129A8
        CLR.L  (A0)+                            ; $0129AA
        CLR.L  (A0)+                            ; $0129AC
        DBRA    D0,loc_0129A4                   ; $0129AE
loc_0129B2:
        TST.B  $00A15120                        ; $0129B2
        BNE.S  loc_0129B2                       ; $0129B8
        CLR.B  $00A15122                        ; $0129BA
        CLR.B  $00A15123                        ; $0129C0
        DC.W    $13FC,$0003,$00A1,$5121; $0129C6 MOVE.B  #$0003,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $0129CE MOVE.B  #$0001,$00A15120
loc_0129D6:
        TST.B  $00A15120                        ; $0129D6
        BNE.S  loc_0129D6                       ; $0129DC
        RTS                                     ; $0129DE
        SPL     (A4)                            ; $0129E0
        SPL     (A6)                            ; $0129E2
        DC.W    $7FFF               ; $0129E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129E6 MOVE.W  <EA:3F>,<EA:3F>
        ADDQ.L  #1,-$4F(A0,D5.W)                ; $0129E8
        SNE     (A2)                            ; $0129EC
        SPL     (A3)                            ; $0129EE
        SGT     $64(A4,D2.L)                    ; $0129F0
        DC.W    $7FFF               ; $0129F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129FE MOVE.W  <EA:3F>,<EA:3F>
        BMI.S  loc_012A5A                       ; $012A00
        BEQ.S  loc_012A3B                       ; $012A02
        DC.W    $7FFF               ; $012A04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A06 MOVE.W  <EA:3F>,<EA:3F>
        ADDQ.L  #5,(A2)                         ; $012A08
        SGT     (A4)                            ; $012A0A
        BEQ.S  loc_012A24                       ; $012A0C
        BMI.S  loc_012A68                       ; $012A0E
        MOVE.W  (A2)+,-$18(A1,D6.W)             ; $012A10
        DC.W    $7FFF               ; $012A14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A1E MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  #$FF7A,-$01(A7,A7.L)            ; $012A20
        DC.W    $FFFF               ; $012A26 MOVE.W  <EA:3F>,<EA:3F>
        AND.W  D5,D2                            ; $012A28
        ADD.B  D0,-$1DEE(A3)                    ; $012A2A
        ROR.W  $FFFF.W                          ; $012A2E
        OR.B   D1,(A7)+                         ; $012A32
        DC.W    $FFFF               ; $012A34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A3E MOVE.W  <EA:3F>,<EA:3F>
        JSR     $00882080                       ; $012A40
        MOVE.W  $C87E.W,D0                      ; $012A46
        MOVEA.L $04(PC,D0.W),A1                 ; $012A4A
        JMP     (A1)                            ; $012A4E
        ORI.L  #$2A720089,A1                    ; $012A50
        MOVE.L  A2,(A6)                         ; $012A56
        ORI.L  #$2CC20089,A1                    ; $012A58
        MOVE.L  A2,-(A7)                        ; $012A5E
        JSR     $00B684(PC)                     ; $012A60
        BTST    #6,$C80E.W                      ; $012A64
        BNE.S  loc_012A70                       ; $012A6A
        ADDQ.W  #4,$C87E.W                      ; $012A6C
loc_012A70:
        RTS                                     ; $012A70
        CLR.W  D0                               ; $012A72
        BSR.W  $00E52C                          ; $012A74
        SUBQ.W  #1,$A036.W                      ; $012A78
        BCC.W  loc_012A92                       ; $012A7C
        MOVE.W  #$0001,$A036.W                  ; $012A80
        SUBI.W  #$0080,$A038.W                  ; $012A86
        ANDI.W  #$1FFF,$A038.W                  ; $012A8C
loc_012A92:
        LEA     $00FF6E00,A0                    ; $012A92
        LEA     $00892C72,A1                    ; $012A98
        CLR.W  D0                               ; $012A9E
        MOVE.B  $A019.W,D0                      ; $012AA0
        ADD.W  D0,D0                            ; $012AA4
        ADD.W  D0,D0                            ; $012AA6
        MOVEA.L $00(A1,D0.W),A1                 ; $012AA8
        MOVE.W  #$007F,D0                       ; $012AAC
loc_012AB0:
        MOVE.W  (A1)+,(A0)+                     ; $012AB0
        DBRA    D0,loc_012AB0                   ; $012AB2
        LEA     $00892C12,A0                    ; $012AB6
        LEA     $A02C.W,A1                      ; $012ABC
        CLR.L  D0                               ; $012AC0
        MOVE.B  $A019.W,D0                      ; $012AC2
        LSL.W  #4,D0                            ; $012AC6
        ADDA.L  D0,A0                           ; $012AC8
        MOVE.W  #$0004,D1                       ; $012ACA
loc_012ACE:
        MOVE.W  (A0)+,(A1)+                     ; $012ACE
        DBRA    D1,loc_012ACE                   ; $012AD0
        DC.W    $13FC,$0000,$00FF,$60D4; $012AD4 MOVE.B  #$0000,$00FF60D4
        LEA     $00FF6100,A1                    ; $012ADC
        MOVE.W  #$0001,$0000(A1)                ; $012AE2
        MOVE.W  $A02C.W,$0002(A1)               ; $012AE8
        MOVE.W  $A02E.W,$0004(A1)               ; $012AEE
        MOVE.W  $A030.W,$0006(A1)               ; $012AF4
        MOVE.L  $A014.W,D0                      ; $012AFA
        MOVE.W  D0,$000A(A1)                    ; $012AFE
        MOVE.W  $A032.W,$0008(A1)               ; $012B02
        MOVE.W  $A034.W,$000C(A1)               ; $012B08
        MOVE.W  #$0000,$000E(A1)                ; $012B0E
        LEA     $00892BFA,A0                    ; $012B14
        CLR.W  D1                               ; $012B1A
        MOVE.B  $A019.W,D1                      ; $012B1C
        CMPI.B  #$0005,D1                       ; $012B20
        BNE.S  loc_012B2E                       ; $012B24
        DC.W    $13FC,$0001,$00FF,$60D4; $012B26 MOVE.B  #$0001,$00FF60D4
loc_012B2E:
        ADD.W  D1,D1                            ; $012B2E
        ADD.W  D1,D1                            ; $012B30
        MOVE.L  $00(A0,D1.W),$0010(A1)          ; $012B32
        ADDA.L  #$00000014,A1                   ; $012B38
        MOVE.W  #$0000,$0000(A1)                ; $012B3E
        CMPI.B  #$0001,$A019.W                  ; $012B44
        BNE.S  loc_012B66                       ; $012B4A
        MOVE.W  #$0001,$0000(A1)                ; $012B4C
        MOVE.W  $A038.W,$000A(A1)               ; $012B52
        MOVE.W  #$0000,$000E(A1)                ; $012B58
        DC.W    $237C,$222B,$90F8,$0010; $012B5E MOVE.L  #$222B90F8,$0010(A1)
loc_012B66:
        DC.W    $33FC,$0041,$00A1,$5110; $012B66 MOVE.W  #$0041,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $012B6E MOVE.B  #$0004,$00A15107
        CLR.B  $00A15123                        ; $012B76
        DC.W    $13FC,$002B,$00A1,$5121; $012B7C MOVE.B  #$002B,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $012B84 MOVE.B  #$0001,$00A15120
loc_012B8C:
        DC.W    $0839,$0001,$00A1,$5123; $012B8C BTST    #1,$00A15123
        BEQ.S  loc_012B8C                       ; $012B94
        DC.W    $08B9,$0001,$00A1,$5123; $012B96 BCLR    #1,$00A15123
        LEA     $00FF60C8,A1                    ; $012B9E
        LEA     $00A15112,A2                    ; $012BA4
        MOVE.W  #$0040,D7                       ; $012BAA
loc_012BAE:
        DC.W    $0839,$0007,$00A1,$5107; $012BAE BTST    #7,$00A15107
        BNE.S  loc_012BAE                       ; $012BB6
        MOVE.W  (A1)+,(A2)                      ; $012BB8
        DBRA    D7,loc_012BAE                   ; $012BBA
        MOVE.L  $A014.W,D0                      ; $012BBE
        ADDI.L  #$00000080,D0                   ; $012BC2
        ANDI.L  #$0000FFFF,D0                   ; $012BC8
        MOVE.L  D0,$A014.W                      ; $012BCE
        CLR.L  D0                               ; $012BD2
        ADD.L  $A024.W,D0                       ; $012BD4
        ADD.L  D0,$A020.W                       ; $012BD8
        SUBQ.W  #4,$A028.W                      ; $012BDC
        BCC.W  loc_012BEC                       ; $012BE0
        DC.W    $21FC,$0000,$0000,$A024; $012BE4 MOVE.L  #$00000000,$A024.W
loc_012BEC:
        ADDQ.W  #4,$C87E.W                      ; $012BEC
        DC.W    $33FC,$0020,$00FF,$0008; $012BF0 MOVE.W  #$0020,$00FF0008
        RTS                                     ; $012BF8
        MOVE.L  $5FF6(A3),D1                    ; $012BFA
        MOVE.L  $710A(A3),D1                    ; $012BFE
        MOVE.L  -$6EDE(A3),D1                   ; $012C02
        MOVE.L  -$5610(A3),D1                   ; $012C06
        MOVE.L  -$370C(A3),D1                   ; $012C0A
        MOVE.L  $5FF6(A3),D1                    ; $012C0E
        DC.W    $0000,$FFB0         ; $012C12 ORI.B  #$FFB0,D0
        ORI.W  #$0140,-(A0)                     ; $012C16
        DC.W    $0000,$0000         ; $012C1A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C1E ORI.B  #$0000,D0
        DC.W    $0000,$FFB0         ; $012C22 ORI.B  #$FFB0,D0
        ORI.W  #$0140,-(A0)                     ; $012C26
        DC.W    $0000,$0000         ; $012C2A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C2E ORI.B  #$0000,D0
        DC.W    $0000,$FFB0         ; $012C32 ORI.B  #$FFB0,D0
        ORI.W  #$0140,$00(A0,D0.W)              ; $012C36
        DC.W    $0000,$0000         ; $012C3C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C40 ORI.B  #$0000,D0
        MOVE.W  -(A0),-$80(A7,D0.W)             ; $012C44
        BCLR    D0,D0                           ; $012C48
        DC.W    $0000,$0000         ; $012C4A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C4E ORI.B  #$0000,D0
        DC.W    $0000,$FF10         ; $012C52 ORI.B  #$FF10,D0
        ORI.W  #$0140,(A0)                      ; $012C56
        DC.W    $0000,$0000         ; $012C5A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C5E ORI.B  #$0000,D0
        DC.W    $0000,$FFB0         ; $012C62 ORI.B  #$FFB0,D0
        ORI.W  #$0140,-(A0)                     ; $012C66
        DC.W    $0000,$0000         ; $012C6A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C6E ORI.B  #$0000,D0
        ORI.L  #$BBDC008B,A3                    ; $012C72
        CMPA.W  (A4)+,A6                        ; $012C78
        ORI.L  #$BBDC008B,A3                    ; $012C7A
        CMPA.L  (A4)+,A6                        ; $012C80
        ORI.L  #$BEDC008B,A3                    ; $012C82
        CMPA.L  (A4)+,A5                        ; $012C88
        CLR.W  D0                               ; $012C8A
        BSR.W  $00E52C                          ; $012C8C
        DC.W    $33FC,$0020,$00FF,$0008; $012C90 MOVE.W  #$0020,$00FF0008
        ADDQ.W  #4,$C87E.W                      ; $012C98
        RTS                                     ; $012C9C
        CMPI.W  #$4000,D0                       ; $012C9E
        BGT.S  loc_012CAE                       ; $012CA2
        ADDI.W  #$0010,D0                       ; $012CA4
        BRA.S  loc_012CAE                       ; $012CA8
        ADDI.W  #$0040,D0                       ; $012CAA
loc_012CAE:
        RTS                                     ; $012CAE
        CMPI.W  #$C000,D0                       ; $012CB0
        BLT.S  loc_012CC0                       ; $012CB4
        SUBI.W  #$0010,D0                       ; $012CB6
        BRA.S  loc_012CC0                       ; $012CBA
        SUBI.W  #$0040,D0                       ; $012CBC
loc_012CC0:
        RTS                                     ; $012CC0
        CLR.W  D0                               ; $012CC2
        BSR.W  $00E52C                          ; $012CC4
        JSR     $00B684(PC)                     ; $012CC8
        JSR     $00B6DA(PC)                     ; $012CCC
        JSR     $0088179E                       ; $012CD0
        TST.W  $A03A.W                          ; $012CD6
        BNE.W  loc_012E12                       ; $012CDA
        TST.B  $C81B.W                          ; $012CDE
        BNE.W  loc_012DDE                       ; $012CE2
        MOVE.B  $A019.W,D0                      ; $012CE6
        MOVE.W  $C86C.W,D1                      ; $012CEA
        TST.L  $A024.W                          ; $012CEE
        BNE.W  loc_012E0E                       ; $012CF2
        BTST    #3,D1                           ; $012CF6
        BEQ.S  loc_012D74                       ; $012CFA
        MOVE.B  #$00A9,$C8A4.W                  ; $012CFC
        TST.B  $FDA8.W                          ; $012D02
        BEQ.S  loc_012D50                       ; $012D06
        CMPI.B  #$0005,D0                       ; $012D08
        BLT.S  loc_012D22                       ; $012D0C
        CLR.B  D0                               ; $012D0E
        DC.W    $21FC,$0000,$0004,$A024; $012D10 MOVE.L  #$00000004,$A024.W
        MOVE.W  #$0037,$A028.W                  ; $012D18
        BRA.W  loc_012E0E                       ; $012D1E
loc_012D22:
        ADDQ.B  #1,D0                           ; $012D22
        BTST    #3,$C818.W                      ; $012D24
        BEQ.S  loc_012D36                       ; $012D2A
        CMPI.B  #$0002,D0                       ; $012D2C
        BNE.S  loc_012D36                       ; $012D30
        MOVE.B  #$0003,D0                       ; $012D32
loc_012D36:
        CMPI.B  #$0005,D0                       ; $012D36
        BNE.W  loc_012E0E                       ; $012D3A
        DC.W    $21FC,$FFFF,$FFFC,$A024; $012D3E MOVE.L  #$FFFFFFFC,$A024.W
        MOVE.W  #$0037,$A028.W                  ; $012D46
        BRA.W  loc_012E0E                       ; $012D4C
loc_012D50:
        CMPI.B  #$0004,D0                       ; $012D50
        BLT.S  loc_012D5C                       ; $012D54
        CLR.B  D0                               ; $012D56
        BRA.W  loc_012E0E                       ; $012D58
loc_012D5C:
        ADDQ.B  #1,D0                           ; $012D5C
        BTST    #3,$C818.W                      ; $012D5E
        BEQ.S  loc_012D70                       ; $012D64
        CMPI.B  #$0002,D0                       ; $012D66
        BNE.S  loc_012D70                       ; $012D6A
        MOVE.B  #$0003,D0                       ; $012D6C
loc_012D70:
        BRA.W  loc_012E0E                       ; $012D70
loc_012D74:
        BTST    #2,D1                           ; $012D74
        BEQ.W  loc_012E0E                       ; $012D78
        MOVE.B  #$00A9,$C8A4.W                  ; $012D7C
        TST.B  D0                               ; $012D82
        BGT.S  loc_012DA8                       ; $012D84
        MOVE.B  #$0004,D0                       ; $012D86
        TST.B  $FDA8.W                          ; $012D8A
        BEQ.W  loc_012E0E                       ; $012D8E
        MOVE.B  #$0005,D0                       ; $012D92
        DC.W    $21FC,$FFFF,$FFFC,$A024; $012D96 MOVE.L  #$FFFFFFFC,$A024.W
        MOVE.W  #$0037,$A028.W                  ; $012D9E
        BRA.W  loc_012E0E                       ; $012DA4
loc_012DA8:
        SUBQ.B  #1,D0                           ; $012DA8
        BTST    #3,$C818.W                      ; $012DAA
        BEQ.S  loc_012DBC                       ; $012DB0
        CMPI.B  #$0002,D0                       ; $012DB2
        BNE.S  loc_012DBC                       ; $012DB6
        MOVE.B  #$0001,D0                       ; $012DB8
loc_012DBC:
        TST.B  $FDA8.W                          ; $012DBC
        BEQ.W  loc_012E0E                       ; $012DC0
        CMPI.B  #$0004,D0                       ; $012DC4
        BNE.W  loc_012E0E                       ; $012DC8
        DC.W    $21FC,$0000,$0004,$A024; $012DCC MOVE.L  #$00000004,$A024.W
        MOVE.W  #$0037,$A028.W                  ; $012DD4
        BRA.W  loc_012E0E                       ; $012DDA
loc_012DDE:
        MOVE.B  $A019.W,D0                      ; $012DDE
        MOVE.W  $C86E.W,D1                      ; $012DE2
        BTST    #3,D1                           ; $012DE6
        BNE.S  loc_012DF6                       ; $012DEA
        BTST    #2,D1                           ; $012DEC
        BNE.S  loc_012DF6                       ; $012DF0
        BRA.W  loc_012E0E                       ; $012DF2
loc_012DF6:
        MOVE.B  #$00A9,$C8A4.W                  ; $012DF6
        CMPI.B  #$0002,D0                       ; $012DFC
        BEQ.S  loc_012E0A                       ; $012E00
        MOVE.B  #$0002,D0                       ; $012E02
        BRA.W  loc_012E0E                       ; $012E06
loc_012E0A:
        MOVE.B  #$0004,D0                       ; $012E0A
loc_012E0E:
        MOVE.B  D0,$A019.W                      ; $012E0E
loc_012E12:
        MOVEA.L #$06038000,A0                   ; $012E12
        MOVEA.L #$04014000,A1                   ; $012E18
        ADDA.L  $A020.W,A1                      ; $012E1E
        MOVE.W  #$0150,D0                       ; $012E22
        MOVE.W  #$0048,D1                       ; $012E26
        JSR     $00E35A(PC)                     ; $012E2A
        TST.L  $A024.W                          ; $012E2E
        BNE.W  loc_012E42                       ; $012E32
loc_012E36:
        TST.B  $00A15120                        ; $012E36
        BNE.S  loc_012E36                       ; $012E3C
        BSR.W  loc_012F72                       ; $012E3E
loc_012E42:
        MOVEA.L #$0603DE80,A0                   ; $012E42
        MOVEA.L #$04004C60,A1                   ; $012E48
        MOVE.W  #$0080,D0                       ; $012E4E
        MOVE.W  #$0010,D1                       ; $012E52
        JSR     $00E35A(PC)                     ; $012E56
loc_012E5A:
        TST.B  $00A15120                        ; $012E5A
        BNE.S  loc_012E5A                       ; $012E60
        TST.L  $A024.W                          ; $012E62
        BNE.W  loc_012E96                       ; $012E66
        CMPI.W  #$0001,$A03A.W                  ; $012E6A
        BEQ.W  loc_012ED2                       ; $012E70
        CMPI.W  #$0002,$A03A.W                  ; $012E74
        BEQ.W  loc_012EE2                       ; $012E7A
        MOVE.W  $C86C.W,D1                      ; $012E7E
        TST.B  $C81B.W                          ; $012E82
        BEQ.W  loc_012E8E                       ; $012E86
        MOVE.W  $C86E.W,D1                      ; $012E8A
loc_012E8E:
        MOVE.W  D1,D2                           ; $012E8E
        DC.W    $0202,$00E0         ; $012E90 ANDI.B  #$00E0,D2
        BNE.S  loc_012E9E                       ; $012E94
loc_012E96:
        SUBQ.W  #8,$C87E.W                      ; $012E96
        BRA.W  loc_012EFA                       ; $012E9A
loc_012E9E:
        BTST    #0,D1                           ; $012E9E
        BEQ.S  loc_012EAA                       ; $012EA2
        BSET    #0,$C80B.W                      ; $012EA4
loc_012EAA:
        MOVE.B  #$00A8,$C8A4.W                  ; $012EAA
        MOVE.B  #$0001,$C809.W                  ; $012EB0
        MOVE.B  #$0001,$C80A.W                  ; $012EB6
        BSET    #7,$C80E.W                      ; $012EBC
        MOVE.B  #$0001,$C802.W                  ; $012EC2
        MOVE.W  #$0002,$A03A.W                  ; $012EC8
        BRA.W  loc_012EF6                       ; $012ECE
loc_012ED2:
        BTST    #6,$C80E.W                      ; $012ED2
        BNE.S  loc_012EF6                       ; $012ED8
        CLR.W  $A03A.W                          ; $012EDA
        BRA.W  loc_012EF6                       ; $012EDE
loc_012EE2:
        BTST    #7,$C80E.W                      ; $012EE2
        BNE.S  loc_012EF6                       ; $012EE8
        CLR.W  $A03A.W                          ; $012EEA
        ADDQ.W  #4,$C87E.W                      ; $012EEE
        BRA.W  loc_012EFA                       ; $012EF2
loc_012EF6:
        SUBQ.W  #8,$C87E.W                      ; $012EF6
loc_012EFA:
        DC.W    $33FC,$0018,$00FF,$0008; $012EFA MOVE.W  #$0018,$00FF0008
        MOVE.B  #$0001,$C821.W                  ; $012F02
        RTS                                     ; $012F08
loc_012F0A:
        TST.B  $00A15120                        ; $012F0A
        BNE.S  loc_012F0A                       ; $012F10
        CLR.B  $00A15123                        ; $012F12
        MOVE.W  #$0000,$C87E.W                  ; $012F18
        MOVEQ   #$00,D1                         ; $012F1E
        MOVE.B  $A019.W,D1                      ; $012F20
        MOVE.B  D1,$C817.W                      ; $012F24
        CMPI.B  #$0002,D1                       ; $012F28
        BNE.S  loc_012F3A                       ; $012F2C
        BTST    #3,$C818.W                      ; $012F2E
        BEQ.S  loc_012F3A                       ; $012F34
        MOVE.W  #$0006,D1                       ; $012F36
loc_012F3A:
        ADD.W  D1,D1                            ; $012F3A
        ADD.W  D1,D1                            ; $012F3C
        MOVE.W  #$0000,$C87E.W                  ; $012F3E
        DC.W    $23FB,$1010,$00FF,$0002; $012F44 MOVE.L  $10(PC,D1.W),$00FF0002
        DC.W    $33FC,$0020,$00FF,$0008; $012F4C MOVE.W  #$0020,$00FF0008
        RTS                                     ; $012F54
        ORI.L  #$E5CE0088,A0                    ; $012F56
        DC.W    $E5FE               ; $012F5C ROXL.W  <EA:3E>
        ORI.L  #$F13C0089,A0                    ; $012F5E
        MOVE.B  A2,-(A6)                        ; $012F64
        ORI.L  #$30540088,A1                    ; $012F66
        ROXL.W  -(A6)                           ; $012F6C
        ORI.L  #$26D27000,A1                    ; $012F6E
        MOVE.B  $A019.W,D0                      ; $012F74
        LEA     $00892F9C,A1                    ; $012F78
        ADD.W  D0,D0                            ; $012F7E
        MOVE.W  D0,D1                           ; $012F80
        ADD.W  D0,D0                            ; $012F82
        ADD.W  D1,D0                            ; $012F84
        MOVEA.L $00(A1,D0.W),A0                 ; $012F86
        MOVE.W  $04(A1,D0.W),D0                 ; $012F8A
        MOVE.W  #$0048,D1                       ; $012F8E
        MOVE.W  #$0010,D2                       ; $012F92
        JSR     $00E3B4(PC)                     ; $012F96
        RTS                                     ; $012F9A
        SUBI.B  #$4014,D1                       ; $012F9C
        DC.W    $0039,$0401,$404C,$0038; $012FA0 ORI.B  #$0401,$404C0038
        SUBI.B  #$4083,D1                       ; $012FA8
        DC.W    $0039,$0401,$40BB,$0039; $012FAC ORI.B  #$0401,$40BB0039
        SUBI.B  #$40F3,D1                       ; $012FB4
        DC.W    $0039,$0401,$40F3,$0039; $012FB8 ORI.B  #$0401,$40F30039
loc_012FC0:
        MOVE.W  #$0100,D4                       ; $012FC0
loc_012FC4:
        MOVE.W  D0,D6                           ; $012FC4
        BCLR    #15,D6                          ; $012FC6
        BSET    #14,D6                          ; $012FCA
        MOVE.W  D6,(A5)                         ; $012FCE
        MOVE.W  #$0003,(A5)                     ; $012FD0
        MOVE.W  D1,D5                           ; $012FD4
loc_012FD6:
        MOVE.W  D3,(A6)                         ; $012FD6
        DBRA    D5,loc_012FD6                   ; $012FD8
        ADD.L  D4,D0                            ; $012FDC
        DBRA    D2,loc_012FC4                   ; $012FDE
        RTS                                     ; $012FE2
loc_012FE4:
        TST.B  $00A15120                        ; $012FE4
        BNE.S  loc_012FE4                       ; $012FEA
        MOVE.L  A1,$00A15128                    ; $012FEC
        DC.W    $33FC,$0101,$00A1,$512C; $012FF2 MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0021,$00A1,$5121; $012FFA MOVE.B  #$0021,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $013002 MOVE.B  #$0001,$00A15120
loc_01300A:
        TST.B  $00A1512C                        ; $01300A
        BNE.S  loc_01300A                       ; $013010
        MOVE.W  D0,$00A15128                    ; $013012
        MOVE.W  D1,$00A1512A                    ; $013018
        DC.W    $33FC,$0101,$00A1,$512C; $01301E MOVE.W  #$0101,$00A1512C
        TST.B  $00A1512C                        ; $013026
        BNE.S  loc_01300A                       ; $01302C
        MOVE.W  D2,$00A15128                    ; $01302E
        DC.W    $33FC,$0101,$00A1,$512C; $013034 MOVE.W  #$0101,$00A1512C
loc_01303C:
        TST.B  $00A1512C                        ; $01303C
        BNE.S  loc_01303C                       ; $013042
        MOVE.L  A0,$00A15128                    ; $013044
        DC.W    $33FC,$0101,$00A1,$512C; $01304A MOVE.W  #$0101,$00A1512C
        RTS                                     ; $013052
        MOVE.B  #$0000,$A019.W                  ; $013054
        BRA.W  loc_013064                       ; $01305A
        MOVE.B  #$0004,$A019.W                  ; $01305E
loc_013064:
        DC.W    $33FC,$002C,$00FF,$0008; $013064 MOVE.W  #$002C,$00FF0008
        MOVE.W  #$002C,$C87A.W                  ; $01306C
        BCLR    #6,$C875.W                      ; $013072
        MOVE.W  $C874.W,(A5)                    ; $013078
        DC.W    $33FC,$0083,$00A1,$5100; $01307C MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $013084 ANDI.B  #$00FC,$00A15181
        JSR     $008826C8                       ; $01308C
        MOVE.L  #$000A0907,D0                   ; $013092
        JSR     $008814BE                       ; $013098
        MOVE.B  #$0001,$C80D.W                  ; $01309E
        MOVEQ   #$00,D0                         ; $0130A4
        LEA     $8480.W,A0                      ; $0130A6
        MOVEQ   #$1F,D1                         ; $0130AA
loc_0130AC:
        MOVE.L  D0,(A0)+                        ; $0130AC
        DBRA    D1,loc_0130AC                   ; $0130AE
        LEA     $00FF7B80,A0                    ; $0130B2
        MOVEQ   #$7F,D1                         ; $0130B8
loc_0130BA:
        MOVE.L  D0,(A0)+                        ; $0130BA
        DBRA    D1,loc_0130BA                   ; $0130BC
        MOVE.L  #$60000002,(A5)                 ; $0130C0
        MOVE.W  #$17FF,D1                       ; $0130C6
loc_0130CA:
        MOVE.L  D0,(A6)                         ; $0130CA
        DBRA    D1,loc_0130CA                   ; $0130CC
        JSR     $008849AA                       ; $0130D0
        CLR.W  $C880.W                          ; $0130D6
        CLR.W  $C882.W                          ; $0130DA
        CLR.W  $8000.W                          ; $0130DE
        CLR.W  $8002.W                          ; $0130E2
        CLR.W  $A012.W                          ; $0130E6
        CLR.B  $A018.W                          ; $0130EA
        JSR     $008849AA                       ; $0130EE
        DC.W    $21FC,$008B,$B57C,$C96C; $0130F4 MOVE.L  #$008BB57C,$C96C.W
        MOVE.B  #$0001,$C809.W                  ; $0130FC
        MOVE.B  #$0001,$C80A.W                  ; $013102
        BSET    #6,$C80E.W                      ; $013108
        MOVE.B  #$0001,$C802.W                  ; $01310E
        MOVE.W  #$0001,$A028.W                  ; $013114
        LEA     $00FF1000,A0                    ; $01311A
        MOVE.W  #$037F,D0                       ; $013120
loc_013124:
        CLR.L  (A0)+                            ; $013124
        DBRA    D0,loc_013124                   ; $013126
        MOVE.W  #$0001,D0                       ; $01312A
        MOVE.W  #$0001,D1                       ; $01312E
        MOVE.W  #$0001,D2                       ; $013132
        MOVE.W  #$0026,D3                       ; $013136
        MOVE.W  #$001A,D4                       ; $01313A
        LEA     $00FF1000,A0                    ; $01313E
        JSR     $00E22C(PC)                     ; $013144
        LEA     $00FF1000,A0                    ; $013148
        JSR     $00E2F0(PC)                     ; $01314E
        JSR     $00E1BC(PC)                     ; $013152
        DC.W    $08B9,$0007,$00A1,$5181; $013156 BCLR    #7,$00A15181
        LEA     $00FF6E00,A0                    ; $01315E
        ADDA.L  #$00000160,A0                   ; $013164
        LEA     $00893292,A1                    ; $01316A
        MOVE.W  #$003F,D0                       ; $013170
loc_013174:
        MOVE.W  (A1)+,D1                        ; $013174
        BSET    #15,D1                          ; $013176
        MOVE.W  D1,(A0)+                        ; $01317A
        DBRA    D0,loc_013174                   ; $01317C
        LEA     $00FF6E00,A0                    ; $013180
        ADDA.L  #$00000020,A0                   ; $013186
        MOVE.W  #$0000,(A0)                     ; $01318C
        LEA     $000EEB30,A0                    ; $013190
        MOVEA.L #$06018000,A1                   ; $013196
        JSR     $00E316(PC)                     ; $01319C
        LEA     $000EEDD0,A0                    ; $0131A0
        MOVEA.L #$0601AD00,A1                   ; $0131A6
        JSR     $00E316(PC)                     ; $0131AC
        LEA     $000EF210,A0                    ; $0131B0
        MOVEA.L #$0601DA00,A1                   ; $0131B6
        JSR     $00E316(PC)                     ; $0131BC
        LEA     $000EF780,A0                    ; $0131C0
        MOVEA.L #$0601ED00,A1                   ; $0131C6
        JSR     $00E316(PC)                     ; $0131CC
        LEA     $000F0C00,A0                    ; $0131D0
        MOVEA.L #$0602B780,A1                   ; $0131D6
        JSR     $00E316(PC)                     ; $0131DC
        LEA     $000F1570,A0                    ; $0131E0
        MOVEA.L #$06030C00,A1                   ; $0131E6
        JSR     $00E316(PC)                     ; $0131EC
        LEA     $000EF530,A0                    ; $0131F0
        MOVEA.L #$06036100,A1                   ; $0131F6
        JSR     $00E316(PC)                     ; $0131FC
        CLR.W  D0                               ; $013200
        MOVE.B  $FDA9.W,D0                      ; $013202
        MOVE.W  D0,$A01A.W                      ; $013206
        MOVE.W  #$0000,$A01C.W                  ; $01320A
        MOVE.W  #$0000,$A01E.W                  ; $013210
        MOVE.W  #$0000,$A020.W                  ; $013216
        MOVE.W  #$0000,$A022.W                  ; $01321C
        DC.W    $33FC,$000F,$00FF,$2100; $013222 MOVE.W  #$000F,$00FF2100
        DC.W    $31F9,$00FF,$2100,$A024; $01322A MOVE.W  $00FF2100,$A024.W
        MOVE.W  #$0001,$A026.W                  ; $013232
        JSR     $0088204A                       ; $013238
        MOVE.B  #$0001,$C821.W                  ; $01323E
        DC.W    $0239,$00FC,$00A1,$5181; $013244 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $01324C ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $013254 MOVE.W  #$8083,$00A15100
        JSR     $0088205E                       ; $01325C
        JSR     $00882080                       ; $013262
        BSET    #6,$C875.W                      ; $013268
        MOVE.W  $C874.W,(A5)                    ; $01326E
        DC.W    $33FC,$0018,$00FF,$0008; $013272 MOVE.W  #$0018,$00FF0008
        JSR     $00884998                       ; $01327A
        MOVE.W  #$0000,$C87E.W                  ; $013280
        DC.W    $23FC,$0089,$3312,$00FF,$0002; $013286 MOVE.L  #$00893312,$00FF0002
        RTS                                     ; $013290
        DC.W    $7FFF               ; $013292 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013294 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013296 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013298 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01329A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01329C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01329E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A8 MOVE.W  <EA:3F>,<EA:3F>
        LEA     A0,A6                           ; $0132AA
        ADDQ.B  #1,A3                           ; $0132AC
        ADDQ.W  #5,$62D1(A6)                    ; $0132AE
        LEA     A0,A6                           ; $0132B2
        ADDQ.B  #1,A3                           ; $0132B4
        ADDQ.W  #5,$62D1(A6)                    ; $0132B6
        LEA     A0,A6                           ; $0132BA
        ADDQ.B  #1,A3                           ; $0132BC
        ADDQ.W  #5,$62D1(A6)                    ; $0132BE
        LEA     A0,A6                           ; $0132C2
        ADDQ.B  #1,A3                           ; $0132C4
        ADDQ.W  #5,$62D1(A6)                    ; $0132C6
        LEA     A0,A6                           ; $0132CA
        ADDQ.B  #1,A3                           ; $0132CC
        ADDQ.W  #5,$62D1(A6)                    ; $0132CE
        MOVE.W  A2,$35EB.W                      ; $0132D2
        MOVE.W  $466F(A5),D7                    ; $0132D6
        DC.W    $7FFF               ; $0132DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E8 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  A2,$35EB.W                      ; $0132EA
        MOVE.W  $466F(A5),D7                    ; $0132EE
        MOVE.B  D1,(A2)+                        ; $0132F2
        MOVE.B  -(A2),-(A6)                     ; $0132F4
        MOVE.L  D4,-$1A(A4,D3.W)                ; $0132F6
loc_0132FA:
        NEG.W  D5                               ; $0132FA
        SUBQ.B  #8,$6212(A3)                    ; $0132FC
        BGT.S  loc_0132FA                       ; $013300
        DC.W    $7FFF               ; $013302 MOVE.W  <EA:3F>,<EA:3F>
        BTST    D1,(A7)+                        ; $013304
        DC.W    $7FFF               ; $013306 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013308 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.B  D1,(A2)+                        ; $01330A
        MOVE.B  -(A2),-(A6)                     ; $01330C
        MOVE.L  D4,-$1A(A4,D3.W)                ; $01330E
        JSR     $00882080                       ; $013312
        MOVE.W  $C87E.W,D0                      ; $013318
        MOVEA.L $04(PC,D0.W),A1                 ; $01331C
        JMP     (A1)                            ; $013320
        ORI.L  #$33460089,A1                    ; $013322
        MOVE.W  -$77(A0,D0.W),(A2)+             ; $013328
        MOVE.W  -(A4),D4                        ; $01332C
        JSR     $00B684(PC)                     ; $01332E
        BTST    #6,$C80E.W                      ; $013332
        BNE.S  loc_01333E                       ; $013338
        ADDQ.W  #4,$C87E.W                      ; $01333A
loc_01333E:
        JSR     $0088205E                       ; $01333E
        RTS                                     ; $013344
        CLR.W  D0                               ; $013346
        JSR     $00E52C(PC)                     ; $013348
        MOVEA.L #$06018000,A0                   ; $01334C
        MOVEA.L #$04004C74,A1                   ; $013352
        MOVE.W  #$0058,D0                       ; $013358
        MOVE.W  #$0010,D1                       ; $01335C
        JSR     $00E35A(PC)                     ; $013360
        MOVEA.L #$0601AD00,A0                   ; $013364
        MOVEA.L #$04009038,A1                   ; $01336A
        MOVE.W  #$0048,D0                       ; $013370
        MOVE.W  #$00A0,D1                       ; $013374
        JSR     $00E35A(PC)                     ; $013378
        MOVEA.L #$0601DA00,A0                   ; $01337C
        MOVEA.L #$04015088,A1                   ; $013382
        MOVE.W  #$0098,D0                       ; $013388
        MOVE.W  #$0020,D1                       ; $01338C
        JSR     $00E35A(PC)                     ; $013390
        LEA     $0089ABEE,A0                    ; $013394
        MOVE.W  $A01A.W,D0                      ; $01339A
        ADD.W  D0,D0                            ; $01339E
        ADD.W  D0,D0                            ; $0133A0
        MOVEA.L $00(A0,D0.W),A0                 ; $0133A2
        MOVEA.L #$04009088,A1                   ; $0133A6
        MOVE.W  #$0040,D0                       ; $0133AC
        MOVE.W  #$0010,D1                       ; $0133B0
        JSR     $00E35A(PC)                     ; $0133B4
        LEA     $0089ABFA,A0                    ; $0133B8
        MOVE.W  $A01C.W,D0                      ; $0133BE
        ADD.W  D0,D0                            ; $0133C2
        ADD.W  D0,D0                            ; $0133C4
        MOVEA.L $00(A0,D0.W),A0                 ; $0133C6
        MOVEA.L #$0400C088,A1                   ; $0133CA
        MOVE.W  #$0078,D0                       ; $0133D0
        MOVE.W  #$0010,D1                       ; $0133D4
        JSR     $00E35A(PC)                     ; $0133D8
        LEA     $0089AC7C,A0                    ; $0133DC
        MOVE.W  $A01E.W,D0                      ; $0133E2
        ADD.W  D0,D0                            ; $0133E6
        ADD.W  D0,D0                            ; $0133E8
        MOVEA.L $00(A0,D0.W),A0                 ; $0133EA
        MOVEA.L #$0400F088,A1                   ; $0133EE
        MOVE.W  #$0068,D0                       ; $0133F4
        MOVE.W  #$0010,D1                       ; $0133F8
        JSR     $00E35A(PC)                     ; $0133FC
        LEA     $0089ACBE,A0                    ; $013400
        MOVE.W  $A020.W,D0                      ; $013406
        ADD.W  D0,D0                            ; $01340A
        ADD.W  D0,D0                            ; $01340C
        MOVEA.L $00(A0,D0.W),A0                 ; $01340E
        MOVEA.L #$04012088,A1                   ; $013412
        MOVE.W  #$0088,D0                       ; $013418
        MOVE.W  #$0010,D1                       ; $01341C
        JSR     $00E35A(PC)                     ; $013420
        TST.W  $A026.W                          ; $013424
        BEQ.S  loc_013456                       ; $013428
        MOVEQ   #$00,D0                         ; $01342A
        MOVE.B  $A019.W,D0                      ; $01342C
        LEA     $008934C8,A1                    ; $013430
        ADD.W  D0,D0                            ; $013436
        ADD.W  D0,D0                            ; $013438
        MOVEA.L $00(A1,D0.W),A0                 ; $01343A
        MOVE.W  #$0048,D0                       ; $01343E
        MOVE.W  #$0010,D1                       ; $013442
        MOVE.W  #$0010,D2                       ; $013446
loc_01344A:
        TST.B  $00A15120                        ; $01344A
        BNE.S  loc_01344A                       ; $013450
        JSR     $00E3B4(PC)                     ; $013452
loc_013456:
        LEA     $00FF6E00,A1                    ; $013456
        ADDA.L  #$00000178,A1                   ; $01345C
        MOVE.W  #$0004,D2                       ; $013462
loc_013466:
        LEA     $008934E8,A0                    ; $013466
        MOVE.W  (A0)+,(A1)+                     ; $01346C
        MOVE.W  (A0)+,(A1)+                     ; $01346E
        MOVE.W  (A0)+,(A1)+                     ; $013470
        MOVE.W  (A0),(A1)+                      ; $013472
        DBRA    D2,loc_013466                   ; $013474
        TST.W  $A026.W                          ; $013478
        BEQ.S  loc_0134B4                       ; $01347C
        CMPI.B  #$0005,$A019.W                  ; $01347E
        BEQ.S  loc_0134B4                       ; $013484
        CLR.W  D0                               ; $013486
        MOVE.B  $A019.W,D0                      ; $013488
        ADD.W  D0,D0                            ; $01348C
        ADD.W  D0,D0                            ; $01348E
        ADD.W  D0,D0                            ; $013490
        LEA     $00FF6E00,A1                    ; $013492
        ADDA.L  #$00000178,A1                   ; $013498
        LEA     $008934E0,A0                    ; $01349E
        MOVE.W  (A0)+,$00(A1,D0.W)              ; $0134A4
        MOVE.W  (A0)+,$02(A1,D0.W)              ; $0134A8
        MOVE.W  (A0)+,$04(A1,D0.W)              ; $0134AC
        MOVE.W  (A0),$06(A1,D0.W)               ; $0134B0
loc_0134B4:
        MOVE.B  #$0001,$C821.W                  ; $0134B4
        ADDQ.W  #4,$C87E.W                      ; $0134BA
        DC.W    $33FC,$0020,$00FF,$0008; $0134BE MOVE.W  #$0020,$00FF0008
        RTS                                     ; $0134C6
        SUBI.B  #$9038,D0                       ; $0134C8
        SUBI.B  #$C038,D0                       ; $0134CC
        SUBI.B  #$F038,D0                       ; $0134D0
        SUBI.B  #$2038,D1                       ; $0134D4
        SUBI.B  #$5038,D1                       ; $0134D8
        SUBI.B  #$B038,D1                       ; $0134DC
        SUB.B  D0,D6                            ; $0134E0
        MOVE.L  -(A3),(A4)                      ; $0134E2
        EOR.W  D2,D6                            ; $0134E4
        MULS    -$3238(A1),D0                   ; $0134E6
        ADD.B  A3,D1                            ; $0134EA
        ADD.W  -$1D2F(A6),D5                    ; $0134EC
        CLR.W  D0                               ; $0134F0
        JSR     $00E52C(PC)                     ; $0134F2
        JSR     $00B684(PC)                     ; $0134F6
        JSR     $00B6DA(PC)                     ; $0134FA
        CMPI.W  #$0001,$A028.W                  ; $0134FE
        BEQ.W  loc_013582                       ; $013504
        CMPI.W  #$0002,$A028.W                  ; $013508
        BEQ.W  loc_013598                       ; $01350E
        JSR     $0088179E                       ; $013512
        MOVE.W  $C86C.W,D1                      ; $013518
        BSR.W  loc_0135C4                       ; $01351C
        MOVE.W  $C86E.W,D1                      ; $013520
        BSR.W  loc_0135C4                       ; $013524
        TST.W  $A022.W                          ; $013528
        BEQ.W  loc_0135B2                       ; $01352C
        CMPI.W  #$0001,$A022.W                  ; $013530
        BNE.W  loc_013562                       ; $013536
        MOVE.B  #$0001,$C809.W                  ; $01353A
        MOVE.B  #$0001,$C80A.W                  ; $013540
        BSET    #7,$C80E.W                      ; $013546
        MOVE.B  #$0001,$C802.W                  ; $01354C
        JSR     $0088205E                       ; $013552
        MOVE.W  #$0002,$A028.W                  ; $013558
        BRA.W  loc_0135B6                       ; $01355E
loc_013562:
        CLR.W  D0                               ; $013562
        LEA     $008936AA,A0                    ; $013564
        CLR.W  D2                               ; $01356A
        MOVE.B  $A019.W,D2                      ; $01356C
        ADD.W  D2,D2                            ; $013570
        ADD.W  D2,D2                            ; $013572
        MOVEA.L $00(A0,D2.W),A0                 ; $013574
        MOVE.W  #$0001,D2                       ; $013578
        JSR     (A0)                            ; $01357C
        BRA.W  loc_0135B6                       ; $01357E
loc_013582:
        JSR     $0088FB36                       ; $013582
        BTST    #6,$C80E.W                      ; $013588
        BNE.S  loc_0135B2                       ; $01358E
        CLR.W  $A028.W                          ; $013590
        BRA.W  loc_0135B2                       ; $013594
loc_013598:
        JSR     $0088FB36                       ; $013598
        BTST    #7,$C80E.W                      ; $01359E
        BNE.S  loc_0135B2                       ; $0135A4
        CLR.W  $A028.W                          ; $0135A6
        ADDQ.W  #4,$C87E.W                      ; $0135AA
        BRA.W  loc_0135B6                       ; $0135AE
loc_0135B2:
        SUBQ.W  #4,$C87E.W                      ; $0135B2
loc_0135B6:
        CLR.W  $A022.W                          ; $0135B6
        DC.W    $33FC,$0018,$00FF,$0008; $0135BA MOVE.W  #$0018,$00FF0008
        RTS                                     ; $0135C2
loc_0135C4:
        MOVE.W  D1,D2                           ; $0135C4
        DC.W    $0202,$00F0         ; $0135C6 ANDI.B  #$00F0,D2
        BNE.W  loc_013672                       ; $0135CA
        BTST    #0,D1                           ; $0135CE
        BEQ.S  loc_0135F2                       ; $0135D2
        JSR     $0088205E                       ; $0135D4
        MOVE.B  #$00A9,$C8A4.W                  ; $0135DA
        SUBQ.B  #1,$A019.W                      ; $0135E0
        BCC.W  loc_013690                       ; $0135E4
        MOVE.B  #$0005,$A019.W                  ; $0135E8
        BRA.W  loc_013690                       ; $0135EE
loc_0135F2:
        BTST    #1,D1                           ; $0135F2
        BEQ.S  loc_01361A                       ; $0135F6
        JSR     $0088205E                       ; $0135F8
        MOVE.B  #$00A9,$C8A4.W                  ; $0135FE
        ADDQ.B  #1,$A019.W                      ; $013604
        CMPI.B  #$0005,$A019.W                  ; $013608
        BLE.W  loc_013690                       ; $01360E
        CLR.B  $A019.W                          ; $013612
        BRA.W  loc_013690                       ; $013616
loc_01361A:
        BTST    #2,D1                           ; $01361A
        BEQ.S  loc_013646                       ; $01361E
        MOVE.B  #$00A9,$C8A4.W                  ; $013620
        MOVE.W  #$FFFF,D0                       ; $013626
        LEA     $008936AA,A0                    ; $01362A
        CLR.W  D2                               ; $013630
        MOVE.B  $A019.W,D2                      ; $013632
        ADD.W  D2,D2                            ; $013636
        ADD.W  D2,D2                            ; $013638
        MOVEA.L $00(A0,D2.W),A0                 ; $01363A
        CLR.W  D2                               ; $01363E
        JSR     (A0)                            ; $013640
        BRA.W  loc_013690                       ; $013642
loc_013646:
        BTST    #3,D1                           ; $013646
        BEQ.S  loc_013690                       ; $01364A
        MOVE.B  #$00A9,$C8A4.W                  ; $01364C
        MOVE.W  #$0001,D0                       ; $013652
        LEA     $008936AA,A0                    ; $013656
        CLR.W  D2                               ; $01365C
        MOVE.B  $A019.W,D2                      ; $01365E
        ADD.W  D2,D2                            ; $013662
        ADD.W  D2,D2                            ; $013664
        MOVEA.L $00(A0,D2.W),A0                 ; $013666
        CLR.W  D2                               ; $01366A
        JSR     (A0)                            ; $01366C
        BRA.W  loc_013690                       ; $01366E
loc_013672:
        MOVE.W  #$0001,$A022.W                  ; $013672
        BTST    #7,D1                           ; $013678
        BNE.S  loc_013690                       ; $01367C
        MOVE.W  #$0002,$A022.W                  ; $01367E
        BTST    #4,D1                           ; $013684
        BEQ.S  loc_013690                       ; $013688
        MOVE.W  #$0003,$A022.W                  ; $01368A
loc_013690:
        SUBQ.W  #1,$A024.W                      ; $013690
        BCC.W  loc_0136A8                       ; $013694
        DC.W    $31F9,$00FF,$2100,$A024; $013698 MOVE.W  $00FF2100,$A024.W
        SUBQ.W  #1,$A026.W                      ; $0136A0
        NEG.W  $A026.W                          ; $0136A4
loc_0136A8:
        RTS                                     ; $0136A8
        ORI.L  #$36C20089,A1                    ; $0136AA
        MOVE.W  $0089(A2),(A3)+                 ; $0136B0
        MOVE.W  -$77(A4,D0.W),-(A3)             ; $0136B4
        MOVE.W  $0089(PC),$37C0(A3)             ; $0136B8
        ORI.L  #$37F44A42,A1                    ; $0136BE
        BNE.S  loc_0136E4                       ; $0136C4
        ADD.W  D0,$A01A.W                       ; $0136C6
        TST.W  $A01A.W                          ; $0136CA
        BGE.S  loc_0136D6                       ; $0136CE
        MOVE.W  #$0002,$A01A.W                  ; $0136D0
loc_0136D6:
        CMPI.W  #$0002,$A01A.W                  ; $0136D6
        BLE.S  loc_0136E8                       ; $0136DC
        CLR.W  $A01A.W                          ; $0136DE
        BRA.S  loc_0136E8                       ; $0136E2
loc_0136E4:
        SUBQ.W  #4,$C87E.W                      ; $0136E4
loc_0136E8:
        RTS                                     ; $0136E8
        TST.W  D2                               ; $0136EA
        BNE.S  loc_01370C                       ; $0136EC
        ADD.W  D0,$A01C.W                       ; $0136EE
        TST.W  $A01C.W                          ; $0136F2
        BGE.S  loc_0136FE                       ; $0136F6
        MOVE.W  #$0019,$A01C.W                  ; $0136F8
loc_0136FE:
        CMPI.W  #$0019,$A01C.W                  ; $0136FE
        BLE.S  loc_013732                       ; $013704
        CLR.W  $A01C.W                          ; $013706
        BRA.S  loc_013732                       ; $01370A
loc_01370C:
        CMPI.W  #$0002,$A022.W                  ; $01370C
        BEQ.S  loc_01371A                       ; $013712
        MOVE.B  #$00F3,$C822.W                  ; $013714
loc_01371A:
        CLR.B  $C8A7.W                          ; $01371A
        LEA     $0089AC62,A0                    ; $01371E
        MOVE.W  $A01C.W,D0                      ; $013724
        MOVE.B  $00(A0,D0.W),$C8A5.W            ; $013728
        SUBQ.W  #4,$C87E.W                      ; $01372E
loc_013732:
        RTS                                     ; $013732
        TST.W  D2                               ; $013734
        BNE.S  loc_013756                       ; $013736
        ADD.W  D0,$A01E.W                       ; $013738
        TST.W  $A01E.W                          ; $01373C
        BGE.S  loc_013748                       ; $013740
        MOVE.W  #$000C,$A01E.W                  ; $013742
loc_013748:
        CMPI.W  #$000C,$A01E.W                  ; $013748
        BLE.S  loc_013778                       ; $01374E
        CLR.W  $A01E.W                          ; $013750
        BRA.S  loc_013778                       ; $013754
loc_013756:
        CMPI.W  #$0002,$A022.W                  ; $013756
        BEQ.S  loc_013764                       ; $01375C
        MOVE.B  #$00CA,$C822.W                  ; $01375E
loc_013764:
        LEA     $0089ACB0,A0                    ; $013764
        MOVE.W  $A01E.W,D0                      ; $01376A
        MOVE.B  $00(A0,D0.W),$C8A4.W            ; $01376E
        SUBQ.W  #4,$C87E.W                      ; $013774
loc_013778:
        RTS                                     ; $013778
        TST.W  D2                               ; $01377A
        BNE.S  loc_01379C                       ; $01377C
        ADD.W  D0,$A020.W                       ; $01377E
        TST.W  $A020.W                          ; $013782
        BGE.S  loc_01378E                       ; $013786
        MOVE.W  #$0009,$A020.W                  ; $013788
loc_01378E:
        CMPI.W  #$0009,$A020.W                  ; $01378E
        BLE.S  loc_0137BE                       ; $013794
        CLR.W  $A020.W                          ; $013796
        BRA.S  loc_0137BE                       ; $01379A
loc_01379C:
        CMPI.W  #$0002,$A022.W                  ; $01379C
        BEQ.S  loc_0137AA                       ; $0137A2
        MOVE.B  #$00CA,$C822.W                  ; $0137A4
loc_0137AA:
        LEA     $0089ACE6,A0                    ; $0137AA
        MOVE.W  $A020.W,D0                      ; $0137B0
        MOVE.B  $00(A0,D0.W),$C8A4.W            ; $0137B4
        SUBQ.W  #4,$C87E.W                      ; $0137BA
loc_0137BE:
        RTS                                     ; $0137BE
        TST.W  D2                               ; $0137C0
        BEQ.S  loc_0137F2                       ; $0137C2
        MOVE.B  #$00A8,$C8A4.W                  ; $0137C4
        ST      $A018.W                         ; $0137CA
        MOVE.B  #$0001,$C809.W                  ; $0137CE
        MOVE.B  #$0001,$C80A.W                  ; $0137D4
        BSET    #7,$C80E.W                      ; $0137DA
        MOVE.B  #$0001,$C802.W                  ; $0137E0
        JSR     $0088205E                       ; $0137E6
        MOVE.W  #$0002,$A028.W                  ; $0137EC
loc_0137F2:
        RTS                                     ; $0137F2
        TST.W  D2                               ; $0137F4
        BEQ.S  loc_013822                       ; $0137F6
        MOVE.B  #$00A8,$C8A4.W                  ; $0137F8
        MOVE.B  #$0001,$C809.W                  ; $0137FE
        MOVE.B  #$0001,$C80A.W                  ; $013804
        BSET    #7,$C80E.W                      ; $01380A
        MOVE.B  #$0001,$C802.W                  ; $013810
        JSR     $0088205E                       ; $013816
        MOVE.W  #$0002,$A028.W                  ; $01381C
loc_013822:
        RTS                                     ; $013822
loc_013824:
        TST.B  $00A15120                        ; $013824
        BNE.S  loc_013824                       ; $01382A
        CLR.B  $00A15123                        ; $01382C
        MOVE.W  $A01A.W,D0                      ; $013832
        MOVE.B  D0,$FDA9.W                      ; $013836
        DC.W    $23FC,$0089,$3864,$00FF,$0002; $01383A MOVE.L  #$00893864,$00FF0002
        TST.B  $A018.W                          ; $013844
        BNE.S  loc_013854                       ; $013848
        DC.W    $23FC,$0089,$26D2,$00FF,$0002; $01384A MOVE.L  #$008926D2,$00FF0002
loc_013854:
        MOVE.W  #$0000,$C87E.W                  ; $013854
        DC.W    $33FC,$0020,$00FF,$0008; $01385A MOVE.W  #$0020,$00FF0008
        RTS                                     ; $013862
        DC.W    $33FC,$002C,$00FF,$0008; $013864 MOVE.W  #$002C,$00FF0008
        MOVE.W  #$002C,$C87A.W                  ; $01386C
        BCLR    #6,$C875.W                      ; $013872
        MOVE.W  $C874.W,(A5)                    ; $013878
        DC.W    $33FC,$0083,$00A1,$5100; $01387C MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $013884 ANDI.B  #$00FC,$00A15181
        JSR     $008826C8                       ; $01388C
        MOVE.L  #$000A0907,D0                   ; $013892
        JSR     $008814BE                       ; $013898
        MOVE.B  #$0001,$C80D.W                  ; $01389E
        MOVEQ   #$00,D0                         ; $0138A4
        LEA     $8480.W,A0                      ; $0138A6
        MOVEQ   #$1F,D1                         ; $0138AA
loc_0138AC:
        MOVE.L  D0,(A0)+                        ; $0138AC
        DBRA    D1,loc_0138AC                   ; $0138AE
        LEA     $00FF7B80,A0                    ; $0138B2
        MOVEQ   #$7F,D1                         ; $0138B8
loc_0138BA:
        MOVE.L  D0,(A0)+                        ; $0138BA
        DBRA    D1,loc_0138BA                   ; $0138BC
        MOVE.L  #$60000002,(A5)                 ; $0138C0
        MOVE.W  #$17FF,D1                       ; $0138C6
loc_0138CA:
        MOVE.L  D0,(A6)                         ; $0138CA
        DBRA    D1,loc_0138CA                   ; $0138CC
        JSR     $008849AA                       ; $0138D0
        CLR.W  $C880.W                          ; $0138D6
        CLR.W  $C882.W                          ; $0138DA
        CLR.W  $8000.W                          ; $0138DE
        CLR.W  $8002.W                          ; $0138E2
        CLR.W  $A012.W                          ; $0138E6
        CLR.B  $A018.W                          ; $0138EA
        JSR     $008849AA                       ; $0138EE
        DC.W    $21FC,$008B,$B57C,$C96C; $0138F4 MOVE.L  #$008BB57C,$C96C.W
        MOVE.B  #$0001,$C809.W                  ; $0138FC
        MOVE.B  #$0001,$C80A.W                  ; $013902
        BSET    #6,$C80E.W                      ; $013908
        MOVE.B  #$0001,$C802.W                  ; $01390E
        MOVE.W  #$0001,$A024.W                  ; $013914
        LEA     $00FF1000,A0                    ; $01391A
        MOVE.W  #$037F,D0                       ; $013920
loc_013924:
        CLR.L  (A0)+                            ; $013924
        DBRA    D0,loc_013924                   ; $013926
        MOVE.W  #$0001,D0                       ; $01392A
        MOVE.W  #$0001,D1                       ; $01392E
        MOVE.W  #$0001,D2                       ; $013932
        MOVE.W  #$0026,D3                       ; $013936
        MOVE.W  #$001A,D4                       ; $01393A
        LEA     $00FF1000,A0                    ; $01393E
        JSR     $00E22C(PC)                     ; $013944
        LEA     $00FF1000,A0                    ; $013948
        JSR     $00E2F0(PC)                     ; $01394E
        JSR     $00E1BC(PC)                     ; $013952
        DC.W    $08B9,$0007,$00A1,$5181; $013956 BCLR    #7,$00A15181
        LEA     $00FF6E00,A0                    ; $01395E
        LEA     $00893A88,A1                    ; $013964
        ADDQ.L  #2,A0                           ; $01396A
        MOVE.W  #$002E,D0                       ; $01396C
loc_013970:
        MOVE.W  (A1)+,D1                        ; $013970
        BSET    #15,D1                          ; $013972
        MOVE.W  D1,(A0)+                        ; $013976
        DBRA    D0,loc_013970                   ; $013978
        LEA     $00FF6E00,A0                    ; $01397C
        ADDA.L  #$00000140,A0                   ; $013982
        LEA     $00893B06,A1                    ; $013988
        MOVE.W  #$005F,D0                       ; $01398E
loc_013992:
        MOVE.W  (A1)+,D1                        ; $013992
        BSET    #15,D1                          ; $013994
        MOVE.W  D1,(A0)+                        ; $013998
        DBRA    D0,loc_013992                   ; $01399A
        LEA     $00FF6E00,A0                    ; $01399E
        ADDA.L  #$00000080,A0                   ; $0139A4
        MOVE.W  #$0000,(A0)                     ; $0139AA
        LEA     $00FF6E00,A0                    ; $0139AE
        ADDA.L  #$00000078,A0                   ; $0139B4
        MOVE.W  #$0000,(A0)                     ; $0139BA
        LEA     $000F35F0,A0                    ; $0139BE
        MOVEA.L #$06014000,A1                   ; $0139C4
        JSR     $00E316(PC)                     ; $0139CA
        LEA     $000F30D0,A0                    ; $0139CE
        BTST    #2,$C818.W                      ; $0139D4
        BNE.S  loc_0139F0                       ; $0139DA
        LEA     $000F1DB0,A0                    ; $0139DC
        BTST    #0,$C818.W                      ; $0139E2
        BEQ.S  loc_0139F0                       ; $0139E8
        LEA     $000F2710,A0                    ; $0139EA
loc_0139F0:
        MOVEA.L #$06017CC0,A1                   ; $0139F0
        JSR     $00E316(PC)                     ; $0139F6
        LEA     $000F30D0,A0                    ; $0139FA
        BTST    #3,$C818.W                      ; $013A00
        BNE.S  loc_013A1C                       ; $013A06
        LEA     $000F1DB0,A0                    ; $013A08
        BTST    #1,$C818.W                      ; $013A0E
        BEQ.S  loc_013A1C                       ; $013A14
        LEA     $000F2710,A0                    ; $013A16
loc_013A1C:
        MOVEA.L #$0601DFC0,A1                   ; $013A1C
        JSR     $00E316(PC)                     ; $013A22
        CLR.B  $A019.W                          ; $013A26
        CLR.B  $A01A.W                          ; $013A2A
        CLR.W  $A01E.W                          ; $013A2E
        CLR.W  $A020.W                          ; $013A32
        CLR.W  $A022.W                          ; $013A36
        JSR     $0088204A                       ; $013A3A
        MOVE.B  #$0001,$C821.W                  ; $013A40
        DC.W    $0239,$00FC,$00A1,$5181; $013A46 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $013A4E ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $013A56 MOVE.W  #$8083,$00A15100
        BSET    #6,$C875.W                      ; $013A5E
        MOVE.W  $C874.W,(A5)                    ; $013A64
        DC.W    $33FC,$0018,$00FF,$0008; $013A68 MOVE.W  #$0018,$00FF0008
        JSR     $00884998                       ; $013A70
        MOVE.W  #$0000,$C87E.W                  ; $013A76
        DC.W    $23FC,$0089,$3BC6,$00FF,$0002; $013A7C MOVE.L  #$00893BC6,$00FF0002
        RTS                                     ; $013A86
        DC.W    $0000,$0421         ; $013A88 ORI.B  #$0421,D0
        BCHG    #3,D2                           ; $013A8C
        MOVE.B  D4,(A0)                         ; $013A90
        MOVE.B  -(A5),(A2)                      ; $013A92
        MOVE.B  D6,(A4)+                        ; $013A94
        MOVE.B  -(A7),(A6)+                     ; $013A96
        MOVE.L  A0,-(A0)                        ; $013A98
        MOVE.L  $294A(A1),-(A2)                 ; $013A9A
        MOVE.L  $318C(A3),$35AD(A6)             ; $013A9E
        MOVE.W  A6,#$3DEF                       ; $013AA4
        CLR.B  (A0)                             ; $013AA8
        NOT.B  $52(A1,D4.L)                     ; $013AAA
        RTE                                     ; $013AAE
        DC.W    $7FFF               ; $013AB0 MOVE.W  <EA:3F>,<EA:3F>
        ADDQ.L  #3,-$2A(A5,D5.L)                ; $013AB2
        SGT     $18(A7,D6.W)                    ; $013AB6
        BEQ.S  loc_013AF5                       ; $013ABA
loc_013ABC:
        BMI.S  loc_013B18                       ; $013ABC
        DC.W    $7FFF               ; $013ABE MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  (A4)+,-$43(A1,D7.W)             ; $013AC0
        DC.W    $7BDE               ; $013AC4 MOVE.W  (A6)+,<EA:3D>
        DC.W    $7FFF               ; $013AC6 MOVE.W  <EA:3F>,<EA:3F>
        MOVEQ   #$2C,D7                         ; $013AC8
        MOVE.W  (A7),$55(A7,D7.L)               ; $013ACA
        MOVE.W  (A3),-(A7)                      ; $013ACE
        MOVEQ   #-$71,D7                        ; $013AD0
        MOVE.W  $76(A5,D7.L),$2883(A7)          ; $013AD2
        MOVEQ   #-$50,D7                        ; $013AD8
        MOVEQ   #-$0E,D7                        ; $013ADA
        MOVE.W  $42(A4,D0.L),-(A7)              ; $013ADC
        DC.W    $4926               ; $013AE0 DC.W    $4926
        MOVE.L  -(A4),(A6)                      ; $013AE2
        MOVE.B  D3,(A2)                         ; $013AE4
        DC.W    $4506               ; $013AE6 DC.W    $4506
        MOVE.W  D4,(A2)+                        ; $013AE8
        DC.W    $7FFF               ; $013AEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AEC MOVE.W  <EA:3F>,<EA:3F>
        BCS.S  loc_013ABC                       ; $013AEE
        DC.W    $7FFF               ; $013AF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B04 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.B  -(A1),(A0)+                     ; $013B06
        MOVE.L  D3,$31A6(A0)                    ; $013B08
        CLR.B  A1                               ; $013B0C
        MOVE.B  D0,D6                           ; $013B0E
        MOVE.L  -(A3),(A4)                      ; $013B10
        MOVE.W  D6,$41E9(A2)                    ; $013B12
        BTST    #16,(A0)+                       ; $013B16
        DC.W    $084D,$108A         ; $013B1A BCHG    #10,A5
        DC.W    $7FFF               ; $013B1E MOVE.W  <EA:3F>,<EA:3F>
        BLE.S  loc_013B9D                       ; $013B20
        SPL     (A6)                            ; $013B22
        TST.W  (A2)                             ; $013B24
        DC.W    $7FFF               ; $013B26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B38 MOVE.W  <EA:3F>,<EA:3F>
loc_013B3A:
        DC.W    $7FFF               ; $013B3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0000,$4E73         ; $013B3E ORI.B  #$4E73,D0
        BEQ.S  loc_013B7D                       ; $013B42
        DC.W    $7FFF               ; $013B44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B4C MOVE.W  <EA:3F>,<EA:3F>
        NEG.W  D5                               ; $013B4E
        NEG    D6                               ; $013B50
        DC.W    $4968               ; $013B52 DC.W    $4968
        LEA     $7FFF(A2),A6                    ; $013B54
        BLS.S  loc_013B4F                       ; $013B58
        DC.W    $7FFF               ; $013B5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B64 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  (A4),-(A3)                      ; $013B66
        BGT.S  loc_013B5B                       ; $013B68
        BNE.S  loc_013B3A                       ; $013B6A
        ADDQ.L  #7,$7FFF(A3)                    ; $013B6C
        DC.W    $7FFF               ; $013B70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B7C MOVE.W  <EA:3F>,<EA:3F>
        BLS.S  loc_013BB7                       ; $013B7E
        SUBQ.B  #7,(A4)                         ; $013B80
        SPL     -$34(A0,D5.W)                   ; $013B82
        MOVE.B  -(A1),(A0)+                     ; $013B86
        MOVE.L  $4670(A0),$37(A4,D6.W)          ; $013B88
loc_013B8E:
        NEG.W  D5                               ; $013B8E
        SUBQ.B  #8,$6212(A3)                    ; $013B90
        BGT.S  loc_013B8E                       ; $013B94
        DC.W    $7FFF               ; $013B96 MOVE.W  <EA:3F>,<EA:3F>
        BTST    D1,(A7)+                        ; $013B98
        DC.W    $7FFF               ; $013B9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0000,$021F         ; $013BB6 ORI.B  #$021F,D0
        DC.W    $027F,$06DF         ; $013BBA ANDI.W  #$06DF,<EA:3F>
        MOVE.L  A0,-(A6)                        ; $013BBE
        LEA     A5,A4                           ; $013BC0
        ADDQ.W  #3,(A0)                         ; $013BC2
        BNE.S  loc_013B97                       ; $013BC4
        JSR     $00882080                       ; $013BC6
        MOVE.W  $C87E.W,D0                      ; $013BCC
        MOVEA.L $04(PC,D0.W),A1                 ; $013BD0
        JMP     (A1)                            ; $013BD4
        ORI.L  #$3BE60089,A1                    ; $013BD6
        MOVE.W  -$77(A0,D0.W),D6                ; $013BDC
        MOVE.W  $0089(PC),(A6)                  ; $013BE0
        MOVE.W  D0,$40(A7,D4.W)                 ; $013BE4
        BTST    #0,$C818.W                      ; $013BE8
        BEQ.S  loc_013BF4                       ; $013BEE
        MOVE.W  #$0001,D0                       ; $013BF0
loc_013BF4:
        MOVE.W  #$00FF,D3                       ; $013BF4
        LEA     $FE92.W,A0                      ; $013BF8
        LEA     $FE82.W,A1                      ; $013BFC
        LEA     $FE94.W,A2                      ; $013C00
        BSR.W  loc_013FE0                       ; $013C04
        CLR.W  D0                               ; $013C08
        BTST    #1,$C818.W                      ; $013C0A
        BEQ.S  loc_013C16                       ; $013C10
        MOVE.W  #$0001,D0                       ; $013C12
loc_013C16:
        MOVE.W  #$00FF,D3                       ; $013C16
        LEA     $FE93.W,A0                      ; $013C1A
        LEA     $FE8A.W,A1                      ; $013C1E
        LEA     $FE9C.W,A2                      ; $013C22
        BSR.W  loc_013FE0                       ; $013C26
        ADDQ.W  #4,$C87E.W                      ; $013C2A
        RTS                                     ; $013C2E
        JSR     $0088205E                       ; $013C30
        CLR.W  D0                               ; $013C36
        JSR     $00E52C(PC)                     ; $013C38
loc_013C3C:
        TST.B  $00A15120                        ; $013C3C
        BNE.S  loc_013C3C                       ; $013C42
        DC.W    $33FC,$0101,$00A1,$512C; $013C44 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$4000,$00A1,$5128; $013C4C MOVE.W  #$4000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $013C54 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $013C5C MOVE.B  #$0001,$00A15120
loc_013C64:
        TST.B  $00A1512C                        ; $013C64
        BNE.S  loc_013C64                       ; $013C6A
        DC.W    $33FC,$00B8,$00A1,$5128; $013C6C MOVE.W  #$00B8,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $013C74 MOVE.W  #$0101,$00A1512C
        MOVEA.L #$06017CC0,A0                   ; $013C7C
        MOVEA.L #$04007010,A1                   ; $013C82
        MOVE.W  #$0120,D0                       ; $013C88
        MOVE.W  #$0058,D1                       ; $013C8C
        JSR     $00E35A(PC)                     ; $013C90
        MOVEA.L #$0601DFC0,A0                   ; $013C94
        MOVEA.L #$04013010,A1                   ; $013C9A
        MOVE.W  #$0120,D0                       ; $013CA0
        MOVE.W  #$0058,D1                       ; $013CA4
        JSR     $00E35A(PC)                     ; $013CA8
        ADDQ.W  #4,$C87E.W                      ; $013CAC
        DC.W    $33FC,$0020,$00FF,$0008; $013CB0 MOVE.W  #$0020,$00FF0008
        RTS                                     ; $013CB8
        CLR.W  D0                               ; $013CBA
        JSR     $00E52C(PC)                     ; $013CBC
        JSR     $0088B684                       ; $013CC0
        JSR     $0088B6DA                       ; $013CC6
        MOVEA.L #$06014000,A0                   ; $013CCC
        MOVEA.L #$04004C74,A1                   ; $013CD2
        MOVE.W  #$0058,D0                       ; $013CD8
        MOVE.W  #$0010,D1                       ; $013CDC
        JSR     $00E35A(PC)                     ; $013CE0
        MOVEA.L #$06014580,A0                   ; $013CE4
        MOVEA.L #$04007018,A1                   ; $013CEA
        MOVE.W  #$0048,D0                       ; $013CF0
        MOVE.W  #$0010,D1                       ; $013CF4
        JSR     $00E35A(PC)                     ; $013CF8
        MOVEA.L #$06014A00,A0                   ; $013CFC
        MOVEA.L #$04013018,A1                   ; $013D02
        MOVE.W  #$0048,D0                       ; $013D08
        MOVE.W  #$0010,D1                       ; $013D0C
        JSR     $00E35A(PC)                     ; $013D10
        BTST    #2,$C818.W                      ; $013D14
        BNE.S  loc_013D42                       ; $013D1A
        LEA     $0089AA12,A0                    ; $013D1C
        CLR.W  D0                               ; $013D22
        MOVE.B  $FE92.W,D0                      ; $013D24
        ADD.W  D0,D0                            ; $013D28
        ADD.W  D0,D0                            ; $013D2A
        MOVEA.L $00(A0,D0.W),A0                 ; $013D2C
        MOVEA.L #$0400707C,A1                   ; $013D30
        MOVE.W  #$0048,D0                       ; $013D36
        MOVE.W  #$0010,D1                       ; $013D3A
        JSR     $00E35A(PC)                     ; $013D3E
loc_013D42:
        BTST    #3,$C818.W                      ; $013D42
        BNE.S  loc_013D70                       ; $013D48
        LEA     $0089AA12,A0                    ; $013D4A
        CLR.W  D0                               ; $013D50
        MOVE.B  $FE93.W,D0                      ; $013D52
        ADD.W  D0,D0                            ; $013D56
        ADD.W  D0,D0                            ; $013D58
        MOVEA.L $00(A0,D0.W),A0                 ; $013D5A
        MOVEA.L #$0401307C,A1                   ; $013D5E
        MOVE.W  #$0048,D0                       ; $013D64
        MOVE.W  #$0010,D1                       ; $013D68
        JSR     $00E35A(PC)                     ; $013D6C
loc_013D70:
        LEA     $FE82.W,A2                      ; $013D70
        LEA     $0089AA2E,A3                    ; $013D74
        CLR.W  D4                               ; $013D7A
        MOVE.W  #$0004,D3                       ; $013D7C
        BTST    #0,$C818.W                      ; $013D80
        BEQ.S  loc_013D8C                       ; $013D86
        MOVE.W  #$0007,D3                       ; $013D88
loc_013D8C:
        MOVEA.L $00(A3,D4.W),A0                 ; $013D8C
        MOVE.W  $08(A3,D4.W),D0                 ; $013D90
        MOVEA.L $04(A3,D4.W),A4                 ; $013D94
        CLR.W  D1                               ; $013D98
        MOVE.B  (A2)+,D1                        ; $013D9A
        ADD.W  D1,D1                            ; $013D9C
        ADD.W  D1,D1                            ; $013D9E
        MOVEA.L $00(A4,D1.W),A1                 ; $013DA0
        BTST    #0,$C818.W                      ; $013DA4
        BNE.S  loc_013DCC                       ; $013DAA
        CMPA.L  #$06017780,A0                   ; $013DAC
        BNE.S  loc_013DCC                       ; $013DB2
        MOVEA.L #$06017500,A0                   ; $013DB4
        MOVE.W  #$0018,D0                       ; $013DBA
        CMPI.W  #$0004,D1                       ; $013DBE
        BLE.W  loc_013DCC                       ; $013DC2
        ADDA.L  #$00000020,A1                   ; $013DC6
loc_013DCC:
        MOVE.W  #$0008,D1                       ; $013DCC
        JSR     $00E35A(PC)                     ; $013DD0
        ADDI.W  #$000A,D4                       ; $013DD4
        DBRA    D3,loc_013D8C                   ; $013DD8
        TST.W  $A020.W                          ; $013DDC
        BEQ.S  loc_013DFC                       ; $013DE0
        MOVE.W  #$0000,D0                       ; $013DE2
        BTST    #0,$C818.W                      ; $013DE6
        BEQ.S  loc_013DF2                       ; $013DEC
        MOVE.W  #$0001,D0                       ; $013DEE
loc_013DF2:
        MOVEQ   #$00,D1                         ; $013DF2
        LEA     $A019.W,A0                      ; $013DF4
        BSR.W  loc_0141EA                       ; $013DF8
loc_013DFC:
        BTST    #3,$C818.W                      ; $013DFC
        BNE.W  loc_013E9C                       ; $013E02
        LEA     $FE8A.W,A2                      ; $013E06
        LEA     $0089AA2E,A3                    ; $013E0A
        CLR.W  D4                               ; $013E10
        MOVE.W  #$0004,D3                       ; $013E12
        BTST    #1,$C818.W                      ; $013E16
        BEQ.S  loc_013E22                       ; $013E1C
        MOVE.W  #$0007,D3                       ; $013E1E
loc_013E22:
        MOVEA.L $00(A3,D4.W),A0                 ; $013E22
        MOVE.W  $08(A3,D4.W),D0                 ; $013E26
        MOVEA.L $04(A3,D4.W),A4                 ; $013E2A
        CLR.W  D1                               ; $013E2E
        MOVE.B  (A2)+,D1                        ; $013E30
        ADD.W  D1,D1                            ; $013E32
        ADD.W  D1,D1                            ; $013E34
        MOVEA.L $00(A4,D1.W),A1                 ; $013E36
        BTST    #1,$C818.W                      ; $013E3A
        BNE.S  loc_013E62                       ; $013E40
        CMPA.L  #$06017780,A0                   ; $013E42
        BNE.S  loc_013E62                       ; $013E48
        MOVEA.L #$06017500,A0                   ; $013E4A
        MOVE.W  #$0018,D0                       ; $013E50
        CMPI.W  #$0004,D1                       ; $013E54
        BLE.W  loc_013E62                       ; $013E58
        ADDA.L  #$00000020,A1                   ; $013E5C
loc_013E62:
        ADDA.L  #$0000C000,A1                   ; $013E62
        MOVE.W  #$0008,D1                       ; $013E68
        JSR     $00E35A(PC)                     ; $013E6C
        ADDI.W  #$000A,D4                       ; $013E70
        DBRA    D3,loc_013E22                   ; $013E74
        TST.W  $A022.W                          ; $013E78
        BEQ.S  loc_013E9C                       ; $013E7C
        MOVE.W  #$0000,D0                       ; $013E7E
        BTST    #1,$C818.W                      ; $013E82
        BEQ.S  loc_013E8E                       ; $013E88
        MOVE.W  #$0001,D0                       ; $013E8A
loc_013E8E:
        MOVE.L  #$0000C000,D1                   ; $013E8E
        LEA     $A01A.W,A0                      ; $013E94
        BSR.W  loc_0141EA                       ; $013E98
loc_013E9C:
        CMPI.W  #$0001,$A024.W                  ; $013E9C
        BEQ.W  loc_013F42                       ; $013EA2
        CMPI.W  #$0002,$A024.W                  ; $013EA6
        BEQ.W  loc_013F58                       ; $013EAC
        JSR     $0088179E                       ; $013EB0
        CLR.W  D0                               ; $013EB6
        BTST    #0,$C818.W                      ; $013EB8
        BEQ.S  loc_013EC4                       ; $013EBE
        MOVE.W  #$0001,D0                       ; $013EC0
loc_013EC4:
        MOVE.W  $C86C.W,D1                      ; $013EC4
        CLR.W  D2                               ; $013EC8
        CLR.W  D3                               ; $013ECA
        LEA     $FE92.W,A0                      ; $013ECC
        LEA     $FE82.W,A1                      ; $013ED0
        LEA     $FE94.W,A2                      ; $013ED4
        LEA     $A019.W,A3                      ; $013ED8
        LEA     $A020.W,A4                      ; $013EDC
        BSR.W  loc_013FE0                       ; $013EE0
        CLR.W  D0                               ; $013EE4
        BTST    #1,$C818.W                      ; $013EE6
        BEQ.S  loc_013EF2                       ; $013EEC
        MOVE.W  #$0001,D0                       ; $013EEE
loc_013EF2:
        MOVE.W  $C86E.W,D1                      ; $013EF2
        MOVE.W  #$0001,D2                       ; $013EF6
        CLR.W  D3                               ; $013EFA
        LEA     $FE93.W,A0                      ; $013EFC
        LEA     $FE8A.W,A1                      ; $013F00
        LEA     $FE9C.W,A2                      ; $013F04
        LEA     $A01A.W,A3                      ; $013F08
        LEA     $A022.W,A4                      ; $013F0C
        BSR.W  loc_013FE0                       ; $013F10
        TST.W  $A01E.W                          ; $013F14
        BEQ.W  loc_013F72                       ; $013F18
        MOVE.B  #$0001,$C809.W                  ; $013F1C
        MOVE.B  #$0001,$C80A.W                  ; $013F22
        BSET    #7,$C80E.W                      ; $013F28
        MOVE.B  #$0001,$C802.W                  ; $013F2E
        JSR     $0088205E                       ; $013F34
        MOVE.W  #$0002,$A024.W                  ; $013F3A
        BRA.S  loc_013F76                       ; $013F40
loc_013F42:
        JSR     $0088FB36                       ; $013F42
        BTST    #6,$C80E.W                      ; $013F48
        BNE.S  loc_013F72                       ; $013F4E
        CLR.W  $A024.W                          ; $013F50
        BRA.W  loc_013F72                       ; $013F54
loc_013F58:
        JSR     $0088FB36                       ; $013F58
        BTST    #7,$C80E.W                      ; $013F5E
        BNE.S  loc_013F72                       ; $013F64
        CLR.W  $A024.W                          ; $013F66
        ADDQ.W  #4,$C87E.W                      ; $013F6A
        BRA.W  loc_013F76                       ; $013F6E
loc_013F72:
        SUBQ.W  #4,$C87E.W                      ; $013F72
loc_013F76:
        DC.W    $33FC,$0018,$00FF,$0008; $013F76 MOVE.W  #$0018,$00FF0008
        RTS                                     ; $013F7E
loc_013F80:
        CMPI.B  #$0006,$FE92.W                  ; $013F80
        BNE.W  loc_013F9C                       ; $013F86
        LEA     $FE82.W,A0                      ; $013F8A
        LEA     $FE94.W,A1                      ; $013F8E
        MOVE.W  #$0007,D0                       ; $013F92
loc_013F96:
        MOVE.B  (A0)+,(A1)+                     ; $013F96
        DBRA    D0,loc_013F96                   ; $013F98
loc_013F9C:
        CMPI.B  #$0006,$FE93.W                  ; $013F9C
        BNE.W  loc_013FB8                       ; $013FA2
        LEA     $FE8A.W,A0                      ; $013FA6
        LEA     $FE9C.W,A1                      ; $013FAA
        MOVE.W  #$0007,D0                       ; $013FAE
loc_013FB2:
        MOVE.B  (A0)+,(A1)+                     ; $013FB2
        DBRA    D0,loc_013FB2                   ; $013FB4
loc_013FB8:
        TST.B  $00A15120                        ; $013FB8
        BNE.S  loc_013F80                       ; $013FBE
        CLR.B  $00A15123                        ; $013FC0
        MOVE.W  #$0000,$C87E.W                  ; $013FC6
        DC.W    $33FC,$0020,$00FF,$0008; $013FCC MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0089,$305E,$00FF,$0002; $013FD4 MOVE.L  #$0089305E,$00FF0002
        RTS                                     ; $013FDE
loc_013FE0:
        TST.W  D3                               ; $013FE0
        BNE.W  loc_01414C                       ; $013FE2
        BTST    #7,D1                           ; $013FE6
        BNE.W  loc_01413C                       ; $013FEA
        MOVE.B  D1,D3                           ; $013FEE
        DC.W    $0203,$0060         ; $013FF0 ANDI.B  #$0060,D3
        BNE.W  loc_014106                       ; $013FF4
        BTST    #4,D1                           ; $013FF8
        BNE.W  loc_01412C                       ; $013FFC
        BTST    #0,D1                           ; $014000
        BEQ.S  loc_01401E                       ; $014004
        TST.W  (A4)                             ; $014006
        BEQ.W  loc_014062                       ; $014008
        MOVE.B  #$00A9,$C8A4.W                  ; $01400C
        SUBQ.B  #1,(A3)                         ; $014012
        BCC.W  loc_01418C                       ; $014014
        CLR.B  (A3)                             ; $014018
        BRA.W  loc_01418C                       ; $01401A
loc_01401E:
        BTST    #1,D1                           ; $01401E
        BEQ.S  loc_014062                       ; $014022
        TST.W  (A4)                             ; $014024
        BEQ.W  loc_014062                       ; $014026
        MOVE.B  #$00A9,$C8A4.W                  ; $01402A
        ADDQ.B  #1,(A3)                         ; $014030
        MOVE.B  (A3),D3                         ; $014032
        MOVE.B  #$0004,D4                       ; $014034
        TST.W  D0                               ; $014038
        BEQ.S  loc_014040                       ; $01403A
        MOVE.B  #$0007,D4                       ; $01403C
loc_014040:
        CMP.B  D4,D3                            ; $014040
        BLE.W  loc_014048                       ; $014042
        MOVE.B  D4,(A3)                         ; $014046
loc_014048:
        LEA     $A01B.W,A4                      ; $014048
        TST.W  D2                               ; $01404C
        BEQ.S  loc_014054                       ; $01404E
        LEA     $A01C.W,A4                      ; $014050
loc_014054:
        MOVE.B  (A3),D0                         ; $014054
        CMP.B  (A4),D0                          ; $014056
        BLT.W  loc_01418C                       ; $014058
        MOVE.B  D0,(A4)                         ; $01405C
        BRA.W  loc_01418C                       ; $01405E
loc_014062:
        BTST    #2,D1                           ; $014062
        BEQ.S  loc_0140B2                       ; $014066
        MOVE.B  #$00A9,$C8A4.W                  ; $014068
        TST.W  (A4)                             ; $01406E
        BNE.W  loc_014082                       ; $014070
        SUBQ.B  #1,(A0)                         ; $014074
        BCC.W  loc_01414C                       ; $014076
        MOVE.B  #$0006,(A0)                     ; $01407A
        BRA.W  loc_01414C                       ; $01407E
loc_014082:
        LEA     $A01B.W,A4                      ; $014082
        TST.W  D2                               ; $014086
        BEQ.S  loc_01408E                       ; $014088
        LEA     $A01C.W,A4                      ; $01408A
loc_01408E:
        BSR.W  loc_01418E                       ; $01408E
        SUBQ.B  #1,(A4)                         ; $014092
        MOVE.B  (A4),D3                         ; $014094
        CMP.B  (A3),D3                          ; $014096
        BGE.W  loc_0140AA                       ; $014098
        MOVE.B  #$0004,(A4)                     ; $01409C
        TST.W  D0                               ; $0140A0
        BEQ.W  loc_0140AA                       ; $0140A2
        MOVE.B  #$0007,(A4)                     ; $0140A6
loc_0140AA:
        BSR.W  loc_01418E                       ; $0140AA
        BRA.W  loc_01418C                       ; $0140AE
loc_0140B2:
        BTST    #3,D1                           ; $0140B2
        BEQ.W  loc_01418C                       ; $0140B6
        MOVE.B  #$00A9,$C8A4.W                  ; $0140BA
        TST.W  (A4)                             ; $0140C0
        BNE.W  loc_0140D6                       ; $0140C2
        ADDQ.B  #1,(A0)                         ; $0140C6
        CMPI.B  #$0006,(A0)                     ; $0140C8
        BLE.W  loc_01414C                       ; $0140CC
        CLR.B  (A0)                             ; $0140D0
        BRA.W  loc_01414C                       ; $0140D2
loc_0140D6:
        LEA     $A01B.W,A4                      ; $0140D6
        TST.W  D2                               ; $0140DA
        BEQ.S  loc_0140E2                       ; $0140DC
        LEA     $A01C.W,A4                      ; $0140DE
loc_0140E2:
        BSR.W  loc_01418E                       ; $0140E2
        ADDQ.B  #1,(A4)                         ; $0140E6
        MOVE.B  #$0004,D3                       ; $0140E8
        TST.W  D0                               ; $0140EC
        BEQ.W  loc_0140F6                       ; $0140EE
        MOVE.B  #$0007,D3                       ; $0140F2
loc_0140F6:
        CMP.B  (A4),D3                          ; $0140F6
        BGE.W  loc_0140FE                       ; $0140F8
        MOVE.B  (A3),(A4)                       ; $0140FC
loc_0140FE:
        BSR.W  loc_01418E                       ; $0140FE
        BRA.W  loc_01418C                       ; $014102
loc_014106:
        CMPI.B  #$0006,(A0)                     ; $014106
        BNE.W  loc_01418C                       ; $01410A
        TST.W  (A4)                             ; $01410E
        BNE.W  loc_01418C                       ; $014110
        MOVE.W  #$0001,(A4)                     ; $014114
        CLR.B  (A3)                             ; $014118
        LEA     $A01B.W,A4                      ; $01411A
        TST.W  D2                               ; $01411E
        BEQ.S  loc_014126                       ; $014120
        LEA     $A01C.W,A4                      ; $014122
loc_014126:
        CLR.B  (A4)                             ; $014126
        BRA.W  loc_01418C                       ; $014128
loc_01412C:
        CLR.W  (A4)                             ; $01412C
        MOVE.W  #$0007,D0                       ; $01412E
loc_014132:
        MOVE.B  (A1)+,(A2)+                     ; $014132
        DBRA    D0,loc_014132                   ; $014134
        BRA.W  loc_01418C                       ; $014138
loc_01413C:
        MOVE.B  #$00A8,$C8A4.W                  ; $01413C
        MOVE.W  #$0001,$A01E.W                  ; $014142
        BRA.W  loc_01418C                       ; $014148
loc_01414C:
        CMPI.B  #$0006,(A0)                     ; $01414C
        BNE.S  loc_01415C                       ; $014150
        MOVEA.L A2,A3                           ; $014152
        MOVE.W  #$0007,D2                       ; $014154
        BRA.W  loc_014186                       ; $014158
loc_01415C:
        CLR.W  D3                               ; $01415C
        MOVE.B  (A0),D3                         ; $01415E
        ADD.W  D3,D3                            ; $014160
        ADD.W  D3,D3                            ; $014162
        ADD.W  D3,D3                            ; $014164
        LEA     $0089AB8E,A3                    ; $014166
        LEA     $00(A3,D3.W),A3                 ; $01416C
        MOVE.W  #$0004,D2                       ; $014170
        TST.W  D0                               ; $014174
        BEQ.S  loc_014186                       ; $014176
        LEA     $0089ABBE,A3                    ; $014178
        LEA     $00(A3,D3.W),A3                 ; $01417E
        MOVE.W  #$0007,D2                       ; $014182
loc_014186:
        MOVE.B  (A3)+,(A1)+                     ; $014186
        DBRA    D2,loc_014186                   ; $014188
loc_01418C:
        RTS                                     ; $01418C
loc_01418E:
        CLR.W  D3                               ; $01418E
        MOVE.B  (A3),D3                         ; $014190
        LEA     $008941DC,A0                    ; $014192
        TST.W  D0                               ; $014198
        BEQ.S  loc_0141A2                       ; $01419A
        LEA     $008941E2,A0                    ; $01419C
loc_0141A2:
        MOVE.B  $00(A0,D3.W),D1                 ; $0141A2
        CLR.W  D3                               ; $0141A6
loc_0141A8:
        CMP.B  $00(A1,D3.W),D1                  ; $0141A8
        BEQ.W  loc_0141B4                       ; $0141AC
        ADDQ.W  #1,D3                           ; $0141B0
        BRA.S  loc_0141A8                       ; $0141B2
loc_0141B4:
        MOVE.B  $00(A1,D3.W),D5                 ; $0141B4
        CLR.W  D4                               ; $0141B8
        MOVE.B  (A4),D4                         ; $0141BA
        MOVE.B  $00(A0,D4.W),D1                 ; $0141BC
        CLR.W  D4                               ; $0141C0
loc_0141C2:
        CMP.B  $00(A1,D4.W),D1                  ; $0141C2
        BEQ.W  loc_0141CE                       ; $0141C6
        ADDQ.W  #1,D4                           ; $0141CA
        BRA.S  loc_0141C2                       ; $0141CC
loc_0141CE:
        MOVE.B  $00(A1,D4.W),D6                 ; $0141CE
        MOVE.B  D5,$00(A1,D4.W)                 ; $0141D2
        MOVE.B  D6,$00(A1,D3.W)                 ; $0141D6
        RTS                                     ; $0141DA
        DC.W    $0001,$0504         ; $0141DC ORI.B  #$0504,D1
        ADDI.B  #$0001,D0                       ; $0141E0
        DC.W    $0A09,$0805         ; $0141E4 EORI.B  #$0805,A1
        SUBI.B  #$2A01,D6                       ; $0141E8
        LEA     $0089AB5A,A1                    ; $0141EC
        MOVE.W  #$0003,D3                       ; $0141F2
        TST.B  D0                               ; $0141F6
        BEQ.W  $014206                          ; $0141F8
        LEA     $0089AB6E,A1                    ; $0141FC
