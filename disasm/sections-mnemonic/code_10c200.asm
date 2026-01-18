; Generated assembly for $10C200-$10E200
; Branch targets: 95
; Labels: 88
; Format: DC.W with decoded mnemonics as comments

        org     $10C200

        EOR.B  D7,-$53(A1,A0.L)                 ; $10C200
        SUB.L  (A5)+,D4                         ; $10C204
        MOVE.W  -$755D(PC),(A5)+                ; $10C206
        DC.W    $E9FD               ; $10C20A ASL.W  <EA:3D>
        MOVE.W  -$2590(A7),-$64(A7,A7.L)        ; $10C20C
        ASL.W  A2                               ; $10C212
        SUBA.W  (A1)+,A7                        ; $10C214
loc_10C216:
        MOVE.L  -$5536(A2),(A6)+                ; $10C216
        ADDA.L  -(A1),A7                        ; $10C21A
        MOVE.B  -$07(A1,A5.L),(A0)              ; $10C21C
        MOVE.L  -$2010(A4),(A6)                 ; $10C220
        DC.W    $ADC1               ; $10C224 MOVE.L  D1,<EA:3E>
        DC.W    $0EF0               ; $10C226 DC.W    $0EF0
        MOVE.W  D6,-(A0)                        ; $10C228
        DC.W    $F1FD,$94EA         ; $10C22A MOVE.W  <EA:3D>,$94EA.W
        MOVE.L  $1044(A7),(A5)                  ; $10C22E
        MOVE.W  -$5236(A7),(A3)+                ; $10C232
        BSET    D7,$00(A1,A7.L)                 ; $10C236
        BRA.S  loc_10C209                       ; $10C23A
        ADDA.W  -$0A01(A2),A7                   ; $10C23C
        BCLR    D3,-(A4)                        ; $10C240
        AND.L  D4,#$87ACDCBB                    ; $10C242
        AND.L  -$5535(A5),D4                    ; $10C248
        MULS    D6,D3                           ; $10C24C
        DC.W    $0000,$70CE         ; $10C24E ORI.B  #$70CE,D0
        DBLE    D0,loc_10C2D4                   ; $10C252
        SGT     -(A6)                           ; $10C256
        SGE     $3F38.W                         ; $10C258
        AND.L  -$77(PC,A0.L),D6                 ; $10C25C
        OR.L   D7,D4                            ; $10C260
        MOVEQ   #-$04,D4                        ; $10C262
        DC.W    $FFFF               ; $10C264 MOVE.W  <EA:3F>,<EA:3F>
        AND.L  $7EC0(A4),D6                     ; $10C266
        BRA.S  loc_10C216                       ; $10C26A
        AND.L  D4,A1                            ; $10C26C
        AND.L  $6095(A2),D5                     ; $10C26E
        BTST    #0,-$1F01(A0)                   ; $10C272
        DC.W    $E0FE               ; $10C278 ASR.W  <EA:3E>
        DC.W    $00FC               ; $10C27A DC.W    $00FC
        ROR.W  #1,D6                            ; $10C27C
        CLR.L  A1                               ; $10C27E
        MOVE.W  (A1)+,-$51(A7,A1.L)             ; $10C280
        DC.W    $4300               ; $10C284 DC.W    $4300
        MOVE.W  (A2)+,-$04(A7,A1.L)             ; $10C286
        DIVS    D1,D3                           ; $10C28A
        ASR.L  #8,D0                            ; $10C28C
        MOVE.W  -$0267(A1),(A4)+                ; $10C28E
        ROL.L  #1,D1                            ; $10C292
        SUB.B  D4,D4                            ; $10C294
        ADDQ.B  #4,$1F(PC,A4.L)                 ; $10C296
        OR.L   D4,-$76CE(A4)                    ; $10C29A
        MOVE.W  D0,$316C(A0)                    ; $10C29E
        LEA     D0,A3                           ; $10C2A2
        MOVE.W  A4,D4                           ; $10C2A4
        ROR.L  #8,D0                            ; $10C2A6
        AND.B  D1,D2                            ; $10C2A8
        MOVE.W  (A0)+,(A6)                      ; $10C2AA
        AND.L  A1,D0                            ; $10C2AC
        DC.W    $ACBF               ; $10C2AE MOVE.L  <EA:3F>,(A6)
        DIVU    -$36(A0,A2.W),D1                ; $10C2B0
        CMP.L  D0,D7                            ; $10C2B4
        ADD.B  A4,D0                            ; $10C2B6
        MOVE.W  D4,$5566(A7)                    ; $10C2B8
        MOVE.W  $5554(A7),-$2F(A6,A0.W)         ; $10C2BC
        SUBQ.W  #2,-$69(A7,A1.W)                ; $10C2C2
        BCS.S  loc_10C32F                       ; $10C2C6
        MOVE.W  $40(A7,D7.W),-$2FF3(A4)         ; $10C2C8
        ADDQ.W  #5,D3                           ; $10C2CE
        OR.B   D7,$3CDA(A1)                     ; $10C2D0
loc_10C2D4:
        SEQ     (A1)                            ; $10C2D4
        DBCS    D5,$10A461                      ; $10C2D6
loc_10C2DA:
        ROXL.L  #8,D7                           ; $10C2DA
        ASR.W  #1,D4                            ; $10C2DC
        NEGX.W -$0116(A0)                       ; $10C2DE
        AND.W  D3,(A6)                          ; $10C2E2
        ADD.B  $50(A1,D6.W),D6                  ; $10C2E4
        DIVU    D7,D0                           ; $10C2E8
        DC.W    $3FD1               ; $10C2EA MOVE.W  (A1),<EA:3F>
        MOVE.L  (A2),(A3)+                      ; $10C2EC
        MULU    #$5A10,D3                       ; $10C2EE
        SUB.B  D3,$D1ACE179                     ; $10C2F2
        BRA.S  loc_10C2DA                       ; $10C2F8
        MOVE.B  (A5)+,-$1E(A5,D6.W)             ; $10C2FA
        MOVE.B  D0,-(A2)                        ; $10C2FE
        ADD.W  -(A0),D3                         ; $10C300
        ROXR.B  #8,D6                           ; $10C302
        DC.W    $00F0               ; $10C304 DC.W    $00F0
        DC.W    $0000,$0000         ; $10C306 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $10C30A ORI.B  #$0000,D0
        DC.W    $1DC0               ; $10C30E MOVE.B  D0,<EA:3E>
        DC.W    $88FF               ; $10C310 DIVU    <EA:3F>,D4
        MOVE.W  $5511.W,D4                      ; $10C312
        DC.W    $FEFF               ; $10C316 MOVE.W  <EA:3F>,(A7)+
        ASL.W  $1080.W                          ; $10C318
        MOVEQ   #-$7B,D5                        ; $10C31C
        DC.W    $ECFD               ; $10C31E ROXR.W  <EA:3D>
        DC.W    $FFFF               ; $10C320 MOVE.W  <EA:3F>,<EA:3F>
        ASL.W  $0F11.W                          ; $10C322
        MOVE.L  (A5),-(A1)                      ; $10C326
        MOVE.W  (A6),(A4)                       ; $10C328
        MOVE.W  (A1),D6                         ; $10C32A
        MOVE.B  $13(A3,A6.W),-(A1)              ; $10C32C
        ASR.W  $1386.W                          ; $10C330
        DC.W    $91FF               ; $10C334 SUBA.L  <EA:3F>,A0
        MOVE.L  (A0)+,-$03CD(A0)                ; $10C336
        MOVE.W  (A0)+,(A1)+                     ; $10C33A
        OR.B   D3,D2                            ; $10C33C
        DC.W    $FBFF               ; $10C33E MOVE.W  <EA:3F>,<EA:3D>
        MOVE.W  (A2),D4                         ; $10C340
        AND.W  (A5),D5                          ; $10C342
        SUBQ.B  #2,(A5)                         ; $10C344
        MOVE.W  $18FF(A1),-(A6)                 ; $10C346
        ASR.W  $1474.W                          ; $10C34A
        MOVE.W  A1,D4                           ; $10C34E
        SUBA.W  -(A6),A4                        ; $10C350
        MOVE.W  (A6),D4                         ; $10C352
        OR.L   D0,D6                            ; $10C354
        DC.W    $1DFE               ; $10C356 MOVE.B  <EA:3E>,<EA:3E>
        MOVE.W  $55(A3,A6.W),-(A1)              ; $10C358
        LEA     -$07F6(A5),A2                   ; $10C35C
        MOVE.W  A0,(A1)                         ; $10C360
        DC.W    $02C0               ; $10C362 DC.W    $02C0
        ROXL.B  D7,D2                           ; $10C364
        DC.W    $FDFC,$FD33         ; $10C366 MOVE.W  #$FD33,<EA:3E>
        DC.W    $3FD8               ; $10C36A MOVE.W  (A0)+,<EA:3F>
        MOVE.L  (A5),$3222(A2)                  ; $10C36C
        MOVE.L  -$61(A3,D3.W),-(A2)             ; $10C370
        DC.W    $E2FE               ; $10C374 LSR.W  <EA:3E>
        MOVEQ   #-$04,D4                        ; $10C376
        MOVE.W  $C447.W,-(A6)                   ; $10C378
        MOVE.W  D7,$77FC(A5)                    ; $10C37C
        NEG    #$5125                           ; $10C380
        DC.W    $4377               ; $10C384 DC.W    $4377
        DC.W    $FBE2               ; $10C386 MOVE.W  -(A2),<EA:3D>
        MOVE.W  (A7),D0                         ; $10C388
        MOVE.W  -$08(A2,D2.W),-$0E(PC,D0.L)     ; $10C38A
        MOVE.W  -(A0),$08FE(A0)                 ; $10C390
        MOVE.W  (A5),$1114(A7)                  ; $10C394
        DC.W    $FDC8               ; $10C398 MOVE.W  A0,<EA:3E>
        MOVE.W  A7,D4                           ; $10C39A
        MOVE.B  A4,(A4)                         ; $10C39C
        DC.W    $00FC               ; $10C39E DC.W    $00FC
        DC.W    $33FB,$0440,$86FB,$DDF6; $10C3A0 MOVE.W  $40(PC,D0.W),$86FBDDF6
        MOVE.L  $0A55.W,(A6)+                   ; $10C3A8
        OR.L   D1,-(A1)                         ; $10C3AC
        AND.B  (A2),D1                          ; $10C3AE
        MOVE.L  $22FF(A2),$F80A.W               ; $10C3B0
        DC.W    $16FE               ; $10C3B6 MOVE.B  <EA:3E>,(A3)+
        MOVEA.W (A1),A7                         ; $10C3B8
        BTST    #12,-(A4)                       ; $10C3BA
        ROL.W  -(A0)                            ; $10C3BE
        MOVE.L  #$4148F0A0,(A0)+                ; $10C3C0
        DBCS    D6,$111588                      ; $10C3C6
        DIVU    -(A7),D3                        ; $10C3CA
        MOVE.W  -(A4),$FFFE.W                   ; $10C3CC
        MOVE.L  $03(A1,A7.L),$21FE.W            ; $10C3D0
        MOVE.L  $23(A1,D2.W),D1                 ; $10C3D6
        MOVE.L  $4A(A2,A7.L),D1                 ; $10C3DA
        MOVE.L  -$03(A6,A4.L),$D421.W           ; $10C3DE
        MOVE.W  (A2),-(A7)                      ; $10C3E4
        MOVE.L  -(A5),(A1)+                     ; $10C3E6
        DC.W    $FFF9,$EDFE,$158C   ; $10C3E8 MOVE.W  $EDFE158C,<EA:3F>
        MOVEA.W A4,A1                           ; $10C3EE
        MOVE.L  -(A0),(A2)                      ; $10C3F0
        DC.W    $15FD,$F4FD         ; $10C3F2 MOVE.B  <EA:3D>,-$0B03(PC)
        DC.W    $37FE,$9F73         ; $10C3F6 MOVE.W  <EA:3E>,$73(PC,A1.L)
        MOVE.W  -(A2),-(A1)                     ; $10C3FA
        CMPA.W  $65(A3,A7.L),A1                 ; $10C3FC
        MOVE.W  -$13(A0,A7.W),$6245(PC)         ; $10C400
        ADDA.L  -$3304(A1),A2                   ; $10C406
        MOVEA.W (A1),A5                         ; $10C40A
        DC.W    $E4FD               ; $10C40C ROXR.W  <EA:3D>
        ADDA.W  #$B252,A0                       ; $10C40E
        MOVE.B  -(A4),-$04(A0,A4.W)             ; $10C412
        DC.W    $FFF8,$0BC5         ; $10C416 MOVE.W  $0BC5.W,<EA:3F>
        DC.W    $FDE7               ; $10C41A MOVE.W  -(A7),<EA:3E>
        DC.W    $49FD               ; $10C41C LEA     <EA:3D>,A4
        MULS    (A4)+,D7                        ; $10C41E
        ASR.W  $11C0.W                          ; $10C420
        DC.W    $FCFF               ; $10C424 MOVE.W  <EA:3F>,(A6)+
        MOVE.W  (A6)+,D4                        ; $10C426
        MOVE.B  -$78(A3,D3.W),D1                ; $10C428
        DC.W    $0788               ; $10C42C BCLR    D3,A0
        MOVE.B  -(A3),D1                        ; $10C42E
        MOVE.W  (A0)+,-(A1)                     ; $10C430
        DC.W    $2BF7,$5100         ; $10C432 MOVE.L  $00(A7,D5.W),<EA:3D>
        DC.W    $00F7               ; $10C436 DC.W    $00F7
        MOVE.W  #$F821,(A4)+                    ; $10C438
        MOVEQ   #-$0D,D3                        ; $10C43C
        MOVE.B  A6,-(A0)                        ; $10C43E
        MOVE.W  (A5)+,-(A1)                     ; $10C440
        MOVE.L  A0,$0B(A1,A7.W)                 ; $10C442
        MOVE.W  (A0)+,-(A0)                     ; $10C446
        OR.W   D3,-(A3)                         ; $10C448
        MULS    $3115(A1),D7                    ; $10C44A
        ROXL.B  D3,D2                           ; $10C44E
        SUBQ.W  #2,(A2)                         ; $10C450
        MOVEA.W (A5),A6                         ; $10C452
        CMPA.W  -(A4),A1                        ; $10C454
        MOVE.W  D4,(A6)                         ; $10C456
        ROXR.B  #4,D0                           ; $10C458
        MOVE.B  D0,-$1004(A1)                   ; $10C45A
        NEGX   $1483(A0)                        ; $10C45E
        DC.W    $3FD4               ; $10C462 MOVE.W  (A4),<EA:3F>
        MOVE.B  (A0)+,-$77CE(A0)                ; $10C464
        SUBQ.B  #8,-$04(A2,D2.W)                ; $10C468
        MOVE.B  -(A0),(A1)+                     ; $10C46C
        MOVE.W  (A4),D4                         ; $10C46E
        SUBA.W  -$3CA8(A3),A1                   ; $10C470
        MOVE.B  (A7),$4843(A0)                  ; $10C474
        DC.W    $4547               ; $10C478 DC.W    $4547
        MOVE.W  (A3),-(A2)                      ; $10C47A
        DIVU    $0D87(A3),D2                    ; $10C47C
        DIVS    -$7F16(A1),D1                   ; $10C480
        MOVEA.W -(A0),A1                        ; $10C484
        MOVE.L  -$02(A5,D5.W),-(A2)             ; $10C486
        MOVE.L  D0,$5333.W                      ; $10C48A
        MOVE.W  $7C(A3,A7.L),-(A5)              ; $10C48E
        MOVE.W  D7,$44(A2,A7.W)                 ; $10C492
        DC.W    $4555               ; $10C496 DC.W    $4555
        SCC     #$32FC                          ; $10C498
        ADDQ.B  #1,-(A5)                        ; $10C49C
        NEG    $55(A0,D0.W)                     ; $10C49E
        BGT.S  loc_10C4C6                       ; $10C4A2
        MOVEA.L (A5),A1                         ; $10C4A4
        MOVEA.W $6108(A1),A2                    ; $10C4A6
        ASR.W  #6,D5                            ; $10C4AA
        ROXL.W  #7,D4                           ; $10C4AC
        SCC     $00(PC,D3.W)                    ; $10C4AE
        BSET    D0,-$1B21(A3)                   ; $10C4B2
        SCC     $1000F1D8                       ; $10C4B6
        ROR.W  $3000.W                          ; $10C4BC
        DC.W    $EFFD               ; $10C4C0 ROL.W  <EA:3D>
        SCS     #$F17C                          ; $10C4C2
loc_10C4C6:
        MOVE.W  $54(PC,D2.W),(A4)+              ; $10C4C6
        MOVE.W  -$4A(A7,D7.L),$5777(A3)         ; $10C4CA
        ADDQ.W  #2,D3                           ; $10C4D0
        ASL.B  #8,D1                            ; $10C4D2
        MOVE.W  D7,-$1E8C(A2)                   ; $10C4D4
        SUBQ.W  #3,D4                           ; $10C4D8
        LEA     -$7C(A5,D2.W),A3                ; $10C4DA
        ROXL.W  D2,D7                           ; $10C4DE
        ADDA.L  -$08(A7,D5.W),A6                ; $10C4E0
        MOVE.W  D0,D7                           ; $10C4E4
        MOVE.W  (A5),-$1FF6(A3)                 ; $10C4E6
        MOVE.B  $54(A1,D1.W),$5177(A2)          ; $10C4EA
        MOVE.W  $06FA.W,-(A5)                   ; $10C4F0
        MOVE.W  -$1D(A7,D4.W),$77CC(A5)         ; $10C4F4
        BPL.W  $10AC50                          ; $10C4FA
        MOVE.W  -$52(A1,D4.W),#$F8C0            ; $10C4FE
        MOVE.L  $51(A7,A7.L),(A1)+              ; $10C504
        MOVE.W  $1E(A2,A6.L),$04FB.W            ; $10C508
        SUBQ.W  #8,(A1)                         ; $10C50E
        MOVE.B  -$0F(A0,D6.W),$E740.W           ; $10C510
        BRA.S  loc_10C4A0                       ; $10C516
        DC.W    $FFF0,$D710         ; $10C518 MOVE.W  $10(A0,A5.W),<EA:3F>
        LEA     $F0FD.W,A2                      ; $10C51C
        MULU    -$0301(A0),D3                   ; $10C520
        MOVE.L  (A0),-(A4)                      ; $10C524
        ADDA.L  -$00BF(A2),A5                   ; $10C526
        ADDA.L  $49(A0,D2.L),A0                 ; $10C52A
        ADD.B  D4,-(A7)                         ; $10C52E
        MOVE.W  D7,$ECFA.W                      ; $10C530
        DC.W    $13F5,$4048,$F0E3,$92CD; $10C534 MOVE.B  $48(A5,D4.W),$F0E392CD
        OR.L   D6,-$00CF(A3)                    ; $10C53C
        ADDA.L  -$05(A1,D2.W),A7                ; $10C540
        MOVE.B  -(A3),D1                        ; $10C544
        MOVE.W  -(A1),(A0)+                     ; $10C546
        LEA     -$6B(A1,A2.L),A4                ; $10C548
        NEG    $53(A2,A2.W)                     ; $10C54C
        ROXL.W  D7,D0                           ; $10C550
        ADD.B  A3,D4                            ; $10C552
        OR.L   D2,(A5)+                         ; $10C554
        MOVEA.W -(A7),A6                        ; $10C556
        MOVE.W  A3,(A2)                         ; $10C558
        MOVE.L  -$2C(PC,D3.W),(A5)+             ; $10C55A
        LSL.W  (A2)                             ; $10C55E
        MOVE.W  $09FB(A0),(A3)+                 ; $10C560
        ROL.L  D1,D2                            ; $10C564
        ASR.B  D1,D0                            ; $10C566
        SUBA.L  -$1C19(A5),A1                   ; $10C568
        DC.W    $B4FD               ; $10C56C CMPA.W  <EA:3D>,A2
        ADDA.W  $1205(A7),A4                    ; $10C56E
        MULS    -(A4),D3                        ; $10C572
        ADDA.L  -(A1),A1                        ; $10C574
        DC.W    $C8FF               ; $10C576 MULU    <EA:3F>,D4
        MOVE.B  -$80(A1,D2.W),(A1)+             ; $10C578
        MOVE.W  -(A2),-$01(PC,D1.W)             ; $10C57C
        DC.W    $82FF               ; $10C580 DIVU    <EA:3F>,D1
        BTST    D0,D4                           ; $10C582
        MOVE.W  $0915.W,#$EAF8                  ; $10C584
        ADDA.W  -(A2),A4                        ; $10C58A
        MOVE.W  D0,D5                           ; $10C58C
        LEA     $56(A7,A7.W),A4                 ; $10C58E
        ROXR.W  $60EE.W                         ; $10C592
        ADDQ.B  #8,D4                           ; $10C596
        MOVE.W  (A4),$F2FF.W                    ; $10C598
        MOVE.W  (A7),D4                         ; $10C59C
        MOVE.L  -$43(A5,D5.W),D6                ; $10C59E
        ADDQ.B  #5,-$1418(PC)                   ; $10C5A2
        LSR.W  -(A5)                            ; $10C5A6
        MOVE.W  A1,D4                           ; $10C5A8
        MOVEQ   #-$1E,D0                        ; $10C5AA
        MOVE.L  -(A3),D1                        ; $10C5AC
        MOVE.L  $40E0(A4),-$23(A1,A7.L)         ; $10C5AE
        MULS    -(A3),D3                        ; $10C5B4
        MULS    -(A2),D7                        ; $10C5B6
        MOVEQ   #$50,D0                         ; $10C5B8
        BCHG    D0,-(A2)                        ; $10C5BA
        ASL.B  D1,D3                            ; $10C5BC
        SEQ     (A2)+                           ; $10C5BE
        DC.W    $AFF8,$0BE8         ; $10C5C0 MOVE.L  $0BE8.W,<EA:3F>
        OR.L   A0,D6                            ; $10C5C4
        DC.W    $FFE9,$DD32         ; $10C5C6 MOVE.W  -$22CE(A1),<EA:3F>
        ASL.W  -(A2)                            ; $10C5CA
        TST.W  -(A0)                            ; $10C5CC
        ROXR.B  D0,D4                           ; $10C5CE
        LSR.B  #8,D1                            ; $10C5D0
        BSET    D6,-(A1)                        ; $10C5D2
        ASR.W  $9BE9.W                          ; $10C5D4
        MOVE.B  D1,D1                           ; $10C5D8
        OR.L   (A6),D4                          ; $10C5DA
        LSR.W  -(A2)                            ; $10C5DC
        ADD.L  D5,(A5)                          ; $10C5DE
        DC.W    $4811               ; $10C5E0 DC.W    $4811
        AND.L  D4,A6                            ; $10C5E2
        DC.W    $C2FD               ; $10C5E4 MULU    <EA:3D>,D1
        DC.W    $7DE9,$A409         ; $10C5E6 MOVE.W  -$5BF7(A1),<EA:3E>
        DC.W    $86FF               ; $10C5EA DIVU    <EA:3F>,D3
        MULU    $5552(PC),D0                    ; $10C5EC
        ROXL.W  $25(A0,D4.W)                    ; $10C5F0
        MOVE.W  -(A1),D6                        ; $10C5F4
        ADDQ.W  #1,(A3)                         ; $10C5F6
        MOVE.L  (A1)+,D1                        ; $10C5F8
        SCS     (A0)                            ; $10C5FA
        SUB.B  D2,A0                            ; $10C5FC
        MOVE.W  #$2978,$534D.W                  ; $10C5FE
        MOVE.L  -(A2),-(A1)                     ; $10C604
        BSET    D0,-(A3)                        ; $10C606
        SUBQ.W  #8,(A2)                         ; $10C608
        ADD.W  -$22(A6,D3.W),D6                 ; $10C60A
        MOVE.W  $0255(A1),-(A2)                 ; $10C60E
        DC.W    $25FC,$92FC,$EB8C,$0FE4; $10C612 MOVE.L  #$92FCEB8C,$0FE4(PC)
        ADDQ.B  #1,-(A5)                        ; $10C61A
        ROXR.W  #8,D5                           ; $10C61C
        SUBQ.B  #4,-(A3)                        ; $10C61E
        MOVE.L  D3,-(A2)                        ; $10C620
        ORI.W  #$3211,-$037B(PC)                ; $10C622
        MOVE.L  A2,$00AA(A7)                    ; $10C628
        DIVU    -(A1),D2                        ; $10C62C
        MOVE.W  A4,(A6)+                        ; $10C62E
        ORI.L  #$F1D60255,D1                    ; $10C630
        MOVE.W  -$15A5(A2),D6                   ; $10C636
        MOVE.L  (A0),-$08(A0,A5.W)              ; $10C63A
        MOVE.W  -$7F2D(A4),-$0001(A6)           ; $10C63E
        ADDQ.W  #1,D7                           ; $10C644
        MOVE.B  (A5),D4                         ; $10C646
        MOVE.B  (A1),-(A1)                      ; $10C648
        ADDQ.B  #1,A5                           ; $10C64A
        OR.B   (A3),D0                          ; $10C64C
        MOVE.L  D0,-(A0)                        ; $10C64E
        MOVE.B  D4,(A0)+                        ; $10C650
        MOVE.W  (A6)+,(A1)+                     ; $10C652
        SUBQ.B  #3,(A0)                         ; $10C654
        MOVE.B  -$2827(PC),(A0)                 ; $10C656
        MOVE.W  D2,D7                           ; $10C65A
        MOVE.L  (A4)+,(A0)                      ; $10C65C
        SHI     -$28(A4,A1.L)                   ; $10C65E
        NOT.B  (A2)                             ; $10C662
        ADD.W  (A3),D2                          ; $10C664
        AND.L  -(A2),D2                         ; $10C666
        MULU    #$B054,D3                       ; $10C668
        DC.W    $8FFE               ; $10C66C DIVS    <EA:3E>,D7
        MOVE.B  $0A(A5,A7.L),$35(A2,A2.L)       ; $10C66E
        ROXL.W  -$40(A2,D4.W)                   ; $10C674
        MOVE.W  (A0),-$73(A2,D6.L)              ; $10C678
        BLT.S  loc_10C6D3                       ; $10C67C
        MOVE.L  (A5),-(A2)                      ; $10C67E
        MULU    -(A2),D4                        ; $10C680
        NEG.L  (A0)                             ; $10C682
        ASL.W  #4,D4                            ; $10C684
        DIVS    $65E9(A2),D3                    ; $10C686
        DIVS    $3CF5(A3),D0                    ; $10C68A
        OR.W   -$000F(A5),D2                    ; $10C68E
        MOVEM.W A0,D0/D5/D6/D7/A0/A3/A5/A7      ; $10C692
        OR.L   -$1EB8(A3),D4                    ; $10C696
        BCHG    D0,D5                           ; $10C69A
        MOVE.L  -(A1),-$2504(PC)                ; $10C69C
        SUBA.L  -(A1),A5                        ; $10C6A0
        ADD.B  (A5),D7                          ; $10C6A2
        NEG    (A3)+                            ; $10C6A4
        MOVE.W  -$1FF5(A4),D6                   ; $10C6A6
        ASR.W  A2                               ; $10C6AA
        ADD.W  -$09(A6,A6.L),D3                 ; $10C6AC
        MOVE.W  (A0)+,D0                        ; $10C6B0
        AND.W  (A0),D4                          ; $10C6B2
        ADD.W  D7,D1                            ; $10C6B4
        DC.W    $C3FF               ; $10C6B6 MULS    <EA:3F>,D1
        MOVE.W  A5,D4                           ; $10C6B8
        DC.W    $84FD               ; $10C6BA DIVU    <EA:3D>,D2
        LSL.W  #$8CC9                           ; $10C6BC
        OR.W   (A3),D2                          ; $10C6C0
        OR.L   D5,D4                            ; $10C6C2
        MOVE.W  $4F(A3,A0.W),-(A0)              ; $10C6C4
        MOVE.W  D0,$22(A2,D1.L)                 ; $10C6C8
        DC.W    $DAFD               ; $10C6CC ADDA.W  <EA:3D>,A5
        OR.B   -(A5),D1                         ; $10C6CE
        CLR.W  (A0)                             ; $10C6D0
        MOVE.L  (A2),-$35CD(A7)                 ; $10C6D2
        MOVE.W  D7,-$1EA3(A4)                   ; $10C6D6
        LSL.B  #8,D1                            ; $10C6DA
        SUB.B  $E367E45F,D4                     ; $10C6DC
        MOVE.B  D5,-(A0)                        ; $10C6E2
        DC.W    $FDFE               ; $10C6E4 MOVE.W  <EA:3E>,<EA:3E>
        ROXL.W  -$252B(A7)                      ; $10C6E6
        MOVE.B  -(A1),D4                        ; $10C6EA
        MOVE.W  $66(A5,D3.W),-(A2)              ; $10C6EC
        MOVE.W  -(A5),D4                        ; $10C6F0
        DC.W    $0024,$FBF2         ; $10C6F2 ORI.B  #$FBF2,-(A4)
        ASL.B  D5,D5                            ; $10C6F6
        MOVE.W  D1,-(A2)                        ; $10C6F8
        MOVE.L  (A0),(A6)                       ; $10C6FA
        ASL.W  -$3282(A3)                       ; $10C6FC
        MOVE.W  -$0F(A5,A6.W),-(A0)             ; $10C700
        MOVEQ   #$00,D3                         ; $10C704
        MOVEA.W (A3),A6                         ; $10C706
        MOVE.B  -(A1),$5134FCA7                 ; $10C708
        MOVEQ   #$18,D4                         ; $10C70E
        MOVEA.W (A5),A6                         ; $10C710
        DC.W    $4314               ; $10C712 DC.W    $4314
        LEA     #$331421C0,A3                   ; $10C714
        MOVE.W  A5,(A6)+                        ; $10C71A
        LEA     $C213.W,A0                      ; $10C71C
        MOVE.B  (A3),D5                         ; $10C720
        MOVE.W  (A3)+,-(A1)                     ; $10C722
        DC.W    $E1FF               ; $10C724 ASL.W  <EA:3F>
        MOVE.W  D7,-$038C(A7)                   ; $10C726
        MOVE.W  D2,D4                           ; $10C72A
        MOVE.L  -$05(A7,A5.W),(A0)+             ; $10C72C
        AND.B  D2,$0CFF.W                       ; $10C730
        MOVE.L  -(A1),(A6)+                     ; $10C734
        MOVE.W  $47(A5,A7.L),$7410(A3)          ; $10C736
        DIVU    $41(A7,A6.W),D3                 ; $10C73C
        MOVEA.W D4,A6                           ; $10C740
        MOVEQ   #-$10,D2                        ; $10C742
        ORI.W  #$54F7,D0                        ; $10C744
        MOVE.W  -$5558(A6),(A2)+                ; $10C748
        DC.W    $CCFF               ; $10C74C MULU    <EA:3F>,D6
        DC.W    $DAFF               ; $10C74E ADDA.W  <EA:3F>,A5
        MOVE.W  A1,D4                           ; $10C750
        DC.W    $FFE4               ; $10C752 MOVE.W  -(A4),<EA:3F>
        MULU    A0,D6                           ; $10C754
        BSET    D4,-$0F(A4,A5.W)                ; $10C756
        ADD.B  D2,D5                            ; $10C75A
        CMPA.L  (A4)+,A6                        ; $10C75C
        BSET    #28,-(A3)                       ; $10C75E
        MOVE.B  -(A3),-(A2)                     ; $10C762
        ROXR.B  #1,D5                           ; $10C764
        ADDA.L  A1,A3                           ; $10C766
        SUBQ.L  #2,A1                           ; $10C768
        DC.W    $06D2               ; $10C76A DC.W    $06D2
        DC.W    $06ED               ; $10C76C DC.W    $06ED
        BSET    D4,(A0)                         ; $10C76E
        ADD.W  D7,(A1)                          ; $10C770
        ADD.B  D5,(A5)                          ; $10C772
        MOVE.B  (A0),D2                         ; $10C774
        ROR.L  #5,D0                            ; $10C776
        ADDA.W  (A1),A5                         ; $10C778
        MULU    #$EDD9,D1                       ; $10C77A
        SUBA.L  (A2)+,A4                        ; $10C77E
        DC.W    $4740               ; $10C780 DC.W    $4740
        SUB.W  D0,D5                            ; $10C782
        LEA     A0,A0                           ; $10C784
        ADDA.L  $5555(A7),A7                    ; $10C786
        MOVE.L  (A3)+,(A4)+                     ; $10C78A
        MOVE.B  A7,(A2)+                        ; $10C78C
        CMPA.W  -(A1),A0                        ; $10C78E
        MOVE.W  $10EF(A1),-$1E(PC,D4.W)         ; $10C790
        MOVE.W  -(A1),(A6)+                     ; $10C796
        MOVE.W  -(A7),#$5145                    ; $10C798
        MULS    -(A2),D6                        ; $10C79C
        MOVE.W  -$15DF(A0),-(A6)                ; $10C79E
        ASL.B  D4,D0                            ; $10C7A2
        ROXR.W  $5545.W                         ; $10C7A4
        DC.W    $0EED               ; $10C7A8 DC.W    $0EED
        DC.W    $0CEB               ; $10C7AA DC.W    $0CEB
        MOVE.W  D2,-$04(PC,A6.W)                ; $10C7AC
        ROR.W  -(A1)                            ; $10C7B0
        MULS    -$15DB(A5),D5                   ; $10C7B2
        ADDA.L  (A0),A2                         ; $10C7B6
        ASL.W  -(A1)                            ; $10C7B8
        DC.W    $FFE6               ; $10C7BA MOVE.W  -(A6),<EA:3F>
        DC.W    $2DE9,$F8FD         ; $10C7BC MOVE.L  -$0703(A1),<EA:3E>
        DIVU    -(A0),D0                        ; $10C7C0
        DC.W    $0DFF               ; $10C7C2 BSET    D6,<EA:3F>
        MOVE.W  (A4),D4                         ; $10C7C4
        MOVEA.B -(A3),A4                        ; $10C7C6
        MOVE.B  (A7),(A1)+                      ; $10C7C8
        MOVE.B  (A0),$13B82515                  ; $10C7CA
        EOR.L  D2,$DA14CCEF                     ; $10C7D0
        DC.W    $C4FF               ; $10C7D6 MULU    <EA:3F>,D2
        MOVEQ   #-$02,D2                        ; $10C7D8
        DC.W    $5CFE               ; $10C7DA SGE     <EA:3E>
        ADDQ.B  #1,D0                           ; $10C7DC
        SUB.W  #$E105,D4                        ; $10C7DE
        ADDA.L  -(A0),A3                        ; $10C7E2
        MOVE.B  -(A4),D1                        ; $10C7E4
        DC.W    $06E0               ; $10C7E6 DC.W    $06E0
        LEA     -$27AA(A6),A1                   ; $10C7E8
        MOVE.L  $2461(A3),(A5)                  ; $10C7EC
        AND.B  -(A1),D1                         ; $10C7F0
        MULS    (A2),D1                         ; $10C7F2
        SUBA.L  -$18(A2,D2.W),A7                ; $10C7F4
        BCLR    D4,$50DC.W                      ; $10C7F8
        ADDQ.W  #7,(A5)                         ; $10C7FC
        SUB.B  D4,-(A1)                         ; $10C7FE
        MOVE.B  (A5),-(A2)                      ; $10C800
        MOVE.L  (A2)+,$93E207EC                 ; $10C802
        MULU    $09EC.W,D0                      ; $10C808
        MOVE.W  (A1),$5420(A0)                  ; $10C80C
        DC.W    $FCFD               ; $10C810 MOVE.W  <EA:3D>,(A6)+
        MOVE.B  -(A4),(A6)+                     ; $10C812
        MOVE.W  A4,-$1E10(PC)                   ; $10C814
        ADD.W  (A3),D5                          ; $10C818
        MOVEA.B $E223.W,A4                      ; $10C81A
        MOVE.B  -(A5),D0                        ; $10C81E
        ASR.B  D7,D5                            ; $10C820
        MOVE.B  -(A0),-(A0)                     ; $10C822
        DIVU    -$40AB(A6),D0                   ; $10C824
        MOVE.W  $01(A7,D0.W),(A4)+              ; $10C828
        MOVE.W  -(A4),(A2)+                     ; $10C82C
        DIVS    $67(A0,D1.W),D7                 ; $10C82E
        MOVEA.W D0,A2                           ; $10C832
        ROXL.L  D7,D4                           ; $10C834
        MOVE.W  $23(A6,A6.W),-(A1)              ; $10C836
        DC.W    $3FCC               ; $10C83A MOVE.W  A4,<EA:3F>
        SUBA.W  $0EF1.W,A1                      ; $10C83C
        SUB.B  D4,-(A5)                         ; $10C840
        ADDQ.W  #1,(A2)                         ; $10C842
        SUB.W  D2,D0                            ; $10C844
        ROXL.W  #4,D5                           ; $10C846
        MOVE.L  -(A0),-(A2)                     ; $10C848
        LEA     (A1)+,A5                        ; $10C84A
        DC.W    $CFBD               ; $10C84C AND.L  D7,<EA:3D>
        AND.L  D0,(A0)+                         ; $10C84E
        MOVE.W  -(A0),$32(PC,D0.L)              ; $10C850
        ADDQ.L  #1,(A2)+                        ; $10C854
        DC.W    $1FE2               ; $10C856 MOVE.B  -(A2),<EA:3F>
        SUBA.W  $31(PC,D1.W),A3                 ; $10C858
        ADDA.L  A2,A2                           ; $10C85C
        MOVE.W  (A1),$FFF82058                  ; $10C85E
        LSL.W  -(A4)                            ; $10C864
        ADD.B  D4,-$0F(A2,A3.W)                 ; $10C866
        ADDA.W  (A2)+,A6                        ; $10C86A
        MOVE.L  (A6),(A4)+                      ; $10C86C
        SVC     $3CD9.W                         ; $10C86E
        CLR    (A1)+                            ; $10C872
        MOVE.W  (A1),$5164(PC)                  ; $10C874
        ADD.L  (A5),D1                          ; $10C878
        MOVE.W  -(A2),-$27AF(A0)                ; $10C87A
        MOVE.B  (A6),(A6)+                      ; $10C87E
        MOVE.W  $13(A1,A7.L),D4                 ; $10C880
        DC.W    $13F0,$E90F,$2131,$5125; $10C884 MOVE.B  $0F(A0,A6.L),$21315125
        SUBQ.L  #4,(A1)                         ; $10C88C
        MOVE.W  (A1)+,(A6)                      ; $10C88E
        MOVE.W  -(A5),D3                        ; $10C890
        OR.B   D1,D2                            ; $10C892
        CLR.B  (A1)                             ; $10C894
        SUBQ.B  #5,-(A3)                        ; $10C896
        MOVEA.B D0,A1                           ; $10C898
        MOVE.L  D3,(A2)+                        ; $10C89A
        MULU    A4,D3                           ; $10C89C
        DC.W    $D97D               ; $10C89E ADD.W  D4,<EA:3D>
        MOVE.B  -$03(A5,D1.W),(A6)+             ; $10C8A0
        MOVE.W  (A0),D2                         ; $10C8A4
        AND.W  (A4),D1                          ; $10C8A6
        MOVEA.W D4,A6                           ; $10C8A8
        MOVE.W  (A4),D6                         ; $10C8AA
        MOVE.W  $00(A1,D5.L),D4                 ; $10C8AC
        NEG.W  D3                               ; $10C8B0
        MOVE.B  -(A2),(A6)+                     ; $10C8B2
        DC.W    $4522               ; $10C8B4 DC.W    $4522
        MOVE.B  -(A2),-$04EC(PC)                ; $10C8B6
        BCLR    D0,-(A0)                        ; $10C8BA
        ADDA.L  (A1)+,A7                        ; $10C8BC
        CMPA.W  $22(A5,A4.W),A2                 ; $10C8BE
        MOVE.B  -$4F(A7,D5.W),$33(A5,D5.W)      ; $10C8C2
        MOVEQ   #-$1F,D0                        ; $10C8C8
        MOVE.B  -(A1),$517470E1                 ; $10C8CA
        LEA     $5F(A0,A0.W),A3                 ; $10C8D0
        ROXL.W  D0,D1                           ; $10C8D4
        CLR.B  -(A4)                            ; $10C8D6
        MOVE.L  $2A(A4,A2.L),-(A1)              ; $10C8D8
        BCLR    D4,-$1015(A6)                   ; $10C8DC
        MOVEQ   #-$26,D4                        ; $10C8E0
        SGE     D1                              ; $10C8E2
        ADDA.W  (A5),A4                         ; $10C8E4
        ADDA.W  D1,A5                           ; $10C8E6
        MOVE.B  -$0B(PC,A1.W),(A5)              ; $10C8E8
        MOVE.B  -(A1),#$2479                    ; $10C8EC
        MOVEA.W -(A1),A2                        ; $10C8F0
        ADD.B  -(A4),D5                         ; $10C8F2
        BTST    D0,D6                           ; $10C8F4
        MULU    -$33BB(A1),D6                   ; $10C8F6
        NEG    D6                               ; $10C8FA
        LSR.W  D4,D6                            ; $10C8FC
        MOVEA.W (A7),A4                         ; $10C8FE
        SUBA.W  -(A1),A5                        ; $10C900
        SUBQ.W  #3,-$1F(A4,A0.L)                ; $10C902
        MOVEQ   #$14,D2                         ; $10C906
        CMPA.W  -(A1),A1                        ; $10C908
        DC.W    $410B               ; $10C90A DC.W    $410B
        OR.L   D5,D1                            ; $10C90C
        ROXL.W  D1,D4                           ; $10C90E
        MOVE.L  -(A1),(A3)+                     ; $10C910
        MOVE.W  D0,-$0B(A3,A6.W)                ; $10C912
loc_10C916:
        DC.W    $4C40               ; $10C916 DC.W    $4C40
        SUBA.W  -(A2),A6                        ; $10C918
        DC.W    $FBE6               ; $10C91A MOVE.W  -(A6),<EA:3D>
        ASL.B  D3,D0                            ; $10C91C
        BSET    D1,-(A6)                        ; $10C91E
        AND.W  D6,(A1)+                         ; $10C920
        ROXL.W  $FA0020FE                       ; $10C922
        DC.W    $F9BE,$E08E         ; $10C928 MOVE.W  <EA:3E>,-$72(A4,A6.W)
        MOVE.L  -(A1),(A6)+                     ; $10C92C
        MOVEQ   #$57,D2                         ; $10C92E
        MOVE.W  (A0),(A0)+                      ; $10C930
        DC.W    $FFFD               ; $10C932 MOVE.W  <EA:3D>,<EA:3F>
        MOVE.B  D6,D6                           ; $10C934
        EOR.W  D6,$54(A5,D4.W)                  ; $10C936
        ROXL.W  #6,D4                           ; $10C93A
        NEG    -(A2)                            ; $10C93C
        AND.B  (A0),D0                          ; $10C93E
        LEA     -(A5),A7                        ; $10C940
        DC.W    $44FD               ; $10C942 NEG    <EA:3D>
        MOVE.W  D1,-$2D(A2,A2.W)                ; $10C944
        MOVE.L  -(A5),$47(A3,A7.W)              ; $10C948
        MOVE.B  (A4),(A5)+                      ; $10C94C
        BRA.S  loc_10C916                       ; $10C94E
        MOVE.W  $24A0.W,(A4)+                   ; $10C950
        AND.B  (A5),D1                          ; $10C954
        MOVE.W  D0,-$3AB0(A5)                   ; $10C956
        ROXL.L  #1,D3                           ; $10C95A
        ADD.W  D4,-$55EF(PC)                    ; $10C95C
        DC.W    $1FE3               ; $10C960 MOVE.B  -(A3),<EA:3F>
        DIVU    D3,D2                           ; $10C962
        MOVE.B  D5,$51D4(A2)                    ; $10C964
        LEA     $0A(A2,A5.L),A0                 ; $10C968
        BLS.S  loc_10C9CA                       ; $10C96C
        ASL.W  (A4)+                            ; $10C96E
        DC.W    $E2FF               ; $10C970 LSR.W  <EA:3F>
        MOVE.W  -(A5),$4333.W                   ; $10C972
        ROXR.B  D2,D3                           ; $10C976
        OR.W   A3,D6                            ; $10C978
        AND.W  D3,D4                            ; $10C97A
        ROXL.W  #2,D3                           ; $10C97C
        MOVE.B  A2,-$0E56(A0)                   ; $10C97E
        MOVE.L  D1,(A5)+                        ; $10C982
        BSET    D6,$26(A0,D1.W)                 ; $10C984
        ADDA.L  -$16(A0,A6.W),A0                ; $10C988
        ROR.B  #4,D0                            ; $10C98C
        LEA     -$1F08(A2),A5                   ; $10C98E
        MOVE.B  (A7)+,-(A0)                     ; $10C992
        ROXL.L  D4,D0                           ; $10C994
loc_10C996:
        TST.B  -(A7)                            ; $10C996
        DC.W    $B1FF               ; $10C998 CMPA.L  <EA:3F>,A0
        MOVE.W  -$17(A1,A5.L),-(A0)             ; $10C99A
        DIVU    -(A3),D1                        ; $10C99E
        DC.W    $02EC               ; $10C9A0 DC.W    $02EC
        MOVE.L  -$15(A5,A7.L),D5                ; $10C9A2
        MULS    -(A2),D0                        ; $10C9A6
        LSR.W  (A4)+                            ; $10C9A8
        ADDA.L  (A3)+,A4                        ; $10C9AA
        ADD.B  D4,-$46(A1,A5.L)                 ; $10C9AC
        DC.W    $93FE               ; $10C9B0 SUBA.L  <EA:3E>,A1
        MOVE.B  D1,-$4C(A1,A3.W)                ; $10C9B2
        DC.W    $FBE4               ; $10C9B6 MOVE.W  -(A4),<EA:3D>
        AND.B  D0,-(A3)                         ; $10C9B8
        CMPA.L  (A4)+,A6                        ; $10C9BA
        DC.W    $B8BD               ; $10C9BC CMP.L  <EA:3D>,D4
        MOVE.W  -(A2),(A1)                      ; $10C9BE
        MOVE.B  A0,(A0)                         ; $10C9C0
        MULS    (A3)+,D4                        ; $10C9C2
        MOVE.L  -(A2),(A5)+                     ; $10C9C4
        BVC.S  loc_10C996                       ; $10C9C6
        ASR.B  D2,D3                            ; $10C9C8
loc_10C9CA:
        DC.W    $4990               ; $10C9CA DC.W    $4990
        AND.L  D2,#$20E5DFAE                    ; $10C9CC
        ROXL.B  #4,D5                           ; $10C9D2
        SUBQ.L  #2,A4                           ; $10C9D4
        ROXL.W  (A3)+                           ; $10C9D6
        SUBA.W  -(A2),A6                        ; $10C9D8
        MOVEA.L -(A0),A0                        ; $10C9DA
        CMPA.L  -$08(A4,A3.L),A7                ; $10C9DC
        CMP.W  D2,D6                            ; $10C9E0
        MOVE.L  D4,$18(A2,A6.W)                 ; $10C9E2
        MULU    (A4),D5                         ; $10C9E6
        ASL.W  #5,D1                            ; $10C9E8
        SCS     D5                              ; $10C9EA
        ADDQ.L  #2,$0BC3(A0)                    ; $10C9EC
        MOVEA.L $54(A0,A4.W),A1                 ; $10C9F0
        LSR.B  D1,D7                            ; $10C9F4
        MOVE.W  $AEE3C02A,D7                    ; $10C9F6
        DC.W    $23FE,$38FF,$F80F   ; $10C9FC MOVE.L  <EA:3E>,$38FFF80F
        MOVE.W  -(A5),(A4)+                     ; $10CA02
        MOVE.W  -(A5),(A6)+                     ; $10CA04
        MOVE.L  (A2),(A5)                       ; $10CA06
        SUBQ.W  #1,-(A0)                        ; $10CA08
        ADD.W  (A0),D5                          ; $10CA0A
        ADDA.W  -$31(A0,A5.L),A6                ; $10CA0C
        ADD.B  D4,D6                            ; $10CA10
        OR.L   A2,D5                            ; $10CA12
        MOVE.B  D2,(A6)+                        ; $10CA14
        MULU    -$1C(A2,D6.W),D6                ; $10CA16
        MOVE.W  A4,D4                           ; $10CA1A
        MULU    #$F515,D1                       ; $10CA1C
        BGT.S  loc_10CA8E                       ; $10CA20
        MOVE.L  $08(A0,A7.W),-$5414(PC)         ; $10CA22
        MOVE.L  -(A2),-(A2)                     ; $10CA28
        MOVE.L  -$66EB(A6),-$0FAF(PC)           ; $10CA2A
        DC.W    $0108               ; $10CA30 BTST    D0,A0
        AND.B  D0,-(A2)                         ; $10CA32
        MOVE.W  (A5),$25FE(A0)                  ; $10CA34
        MOVE.L  D4,(A7)+                        ; $10CA38
        BCLR    #18,D0                          ; $10CA3A
        MOVE.W  (A4)+,$22C0.W                   ; $10CA3E
        MOVE.W  A4,-$3616(A4)                   ; $10CA42
        MOVE.L  (A2)+,(A4)+                     ; $10CA46
        MOVE.L  D5,-(A1)                        ; $10CA48
        OR.W   D1,(A5)                          ; $10CA4A
        MOVE.L  (A5),-(A0)                      ; $10CA4C
        MULS    -$7337(A5),D0                   ; $10CA4E
        SLS     (A0)                            ; $10CA52
        BCHG    D1,-(A2)                        ; $10CA54
        MOVE.W  A1,$2352FAB6                    ; $10CA56
        ADD.W  D6,(A3)                          ; $10CA5C
        MOVE.B  D3,D0                           ; $10CA5E
        MOVE.W  #$F297,-$50(A6,D1.W)            ; $10CA60
        OR.W   D5,D0                            ; $10CA66
        DC.W    $3FF5,$61D3         ; $10CA68 MOVE.W  -$2D(A5,D6.W),<EA:3F>
        MOVE.L  -$1EA5(PC),$2B04.W              ; $10CA6C
        MULU    -(A1),D2                        ; $10CA72
        MOVE.W  -(A4),(A2)                      ; $10CA74
        ASR.W  #1,D4                            ; $10CA76
        ADDA.L  #$23FB5556,A0                   ; $10CA78
        BCC.S  loc_10CA21                       ; $10CA7E
        DC.W    $AFDA               ; $10CA80 MOVE.L  (A2)+,<EA:3F>
        MOVE.W  (A1),-$0F(A7,D4.W)              ; $10CA82
        BCLR    D5,#$E1E0                       ; $10CA86
        ASR.W  #5,D1                            ; $10CA8A
        DC.W    $8CBD               ; $10CA8C OR.L   <EA:3D>,D6
loc_10CA8E:
        ASL.L  D4,D2                            ; $10CA8E
        MOVE.W  $54(A2,A7.L),(A3)+              ; $10CA90
        MOVEA.L D3,A5                           ; $10CA94
        ASR.L  #3,D7                            ; $10CA96
        LSR.W  -(A0)                            ; $10CA98
        AND.L  D3,(A1)+                         ; $10CA9A
        LSR.W  -(A0)                            ; $10CA9C
        AND.B  (A3)+,D0                         ; $10CA9E
        MOVE.B  -(A4),-(A0)                     ; $10CAA0
        MOVEA.W D1,A4                           ; $10CAA2
        OR.B   -$0322(A6),D0                    ; $10CAA4
        DC.W    $4130               ; $10CAA8 DC.W    $4130
        ASL.W  #8,D2                            ; $10CAAA
        MOVE.B  A3,(A2)                         ; $10CAAC
        LSL.B  #1,D4                            ; $10CAAE
        DC.W    $00F0               ; $10CAB0 DC.W    $00F0
        MOVEA.B D4,A2                           ; $10CAB2
        MOVE.W  -$5FF0(A7),(A7)+                ; $10CAB4
        DC.W    $FCFF               ; $10CAB8 MOVE.W  <EA:3F>,(A6)+
        MULU    D1,D3                           ; $10CABA
        LEA     (A2)+,A4                        ; $10CABC
        ADD.B  D7,-$78(A3,D3.W)                 ; $10CABE
        MOVEA.W (A2),A5                         ; $10CAC2
        MOVE.W  -$16DD(A0),-(A2)                ; $10CAC4
        AND.L  A3,D5                            ; $10CAC8
        AND.B  -(A4),D1                         ; $10CACA
        DC.W    $04B1,$A0C9,$E2FD,$51B7; $10CACC SUBI.L  #$A0C9E2FD,-$49(A1,D5.W)
        ASR.L  #4,D7                            ; $10CAD4
        MOVEA.B D7,A7                           ; $10CAD6
        DC.W    $FBD1               ; $10CAD8 MOVE.W  (A1),<EA:3D>
        MOVE.W  (A1),$1514(A3)                  ; $10CADA
        MOVE.W  $04(A6,A2.L),-$03(PC,D7.W)      ; $10CADE
        MULS    (A4)+,D0                        ; $10CAE4
        DC.W    $C27E               ; $10CAE6 AND.W  <EA:3E>,D1
        ASL.W  A3                               ; $10CAE8
        MULS    $55(A6,D5.L),D1                 ; $10CAEA
        DIVU    $40(PC,D4.W),D3                 ; $10CAEE
        ROL.B  D1,D4                            ; $10CAF2
        ROXR.W  D2,D6                           ; $10CAF4
        ROL.L  #8,D3                            ; $10CAF6
        MOVE.L  -$3900(A5),-$2A(A0,D0.W)        ; $10CAF8
        ADDA.W  -$58D3(PC),A7                   ; $10CAFE
        DC.W    $00C8               ; $10CB02 DC.W    $00C8
        MOVE.W  A7,$75(A6,A4.W)                 ; $10CB04
        ROL.W  -(A1)                            ; $10CB08
        DC.W    $B3FF               ; $10CB0A CMPA.L  <EA:3F>,A1
        OR.B   D2,D5                            ; $10CB0C
        SUBA.L  $FCEF.W,A4                      ; $10CB0E
        SF      -(A1)                           ; $10CB12
        CMPA.W  -(A2),A2                        ; $10CB14
        MULU    $54(A7,A4.L),D1                 ; $10CB16
        DC.W    $4142               ; $10CB1A DC.W    $4142
        AND.B  D4,$60(PC,D1.W)                  ; $10CB1C
        OR.B   -(A1),D0                         ; $10CB20
        SUBQ.L  #8,(A4)+                        ; $10CB22
        ROXL.W  #8,D2                           ; $10CB24
        MOVE.W  -(A2),(A6)+                     ; $10CB26
        EOR.L  D0,$2221(A2)                     ; $10CB28
        ADD.B  D4,-(A3)                         ; $10CB2C
        MOVE.L  -(A7),(A4)                      ; $10CB2E
        MOVE.B  (A3)+,$FFF8.W                   ; $10CB30
        BCLR    D5,(A4)                         ; $10CB34
        LSR.L  D6,D2                            ; $10CB36
        MOVEA.L -(A7),A5                        ; $10CB38
        AND.L  -$0EFC(A6),D5                    ; $10CB3A
        AND.W  D5,(A2)                          ; $10CB3E
        LSR.B  #4,D1                            ; $10CB40
        BVC.S  loc_10CB0B                       ; $10CB42
        SUBA.L  -$7511(A2),A2                   ; $10CB44
        DC.W    $45AA               ; $10CB48 DC.W    $45AA
        MOVE.L  $7BC4(A2),D5                    ; $10CB4A
        NEG    D7                               ; $10CB4E
        DC.W    $FFF8,$105F         ; $10CB50 MOVE.W  $105F.W,<EA:3F>
        MOVEA.L -$3C7C(A4),A6                   ; $10CB54
        SUB.B  D2,-(A0)                         ; $10CB58
        SUB.B  A1,D0                            ; $10CB5A
        MOVE.B  $0B66(A0),(A2)+                 ; $10CB5C
        DC.W    $51FF               ; $10CB60 SF      <EA:3F>
        SLS     #$38F1                          ; $10CB62
        MOVE.W  (A4)+,$55(A6,A6.W)              ; $10CB66
        SUBQ.B  #2,$07(A2,A6.L)                 ; $10CB6A
        ASR.L  D5,D7                            ; $10CB6E
        ROXL.W  D1,D4                           ; $10CB70
        DC.W    $FDD8               ; $10CB72 MOVE.W  (A0)+,<EA:3E>
        MOVE.L  A4,$D962C2B0                    ; $10CB74
        ASL.W  #1,D4                            ; $10CB7A
        BSET    D2,$0A(A4,A2.W)                 ; $10CB7C
        AND.L  (A3)+,D1                         ; $10CB80
        MOVE.W  $5025F8AA,(A6)+                 ; $10CB82
        MOVE.L  (A7),$2A(A0,A4.L)               ; $10CB88
        ROL.B  D0,D2                            ; $10CB8C
        LSR.W  A2                               ; $10CB8E
        ADD.W  -$2063(A3),D1                    ; $10CB90
        MOVE.L  A1,D0                           ; $10CB94
        DIVU    $2152(A1),D0                    ; $10CB96
        MOVE.W  (A3),D1                         ; $10CB9A
        AND.W  D4,-(A1)                         ; $10CB9C
        MOVEA.W (A2),A7                         ; $10CB9E
        CMPI.B  #$EA25,-(A2)                    ; $10CBA0
        MOVE.W  -(A2),(A6)+                     ; $10CBA4
        AND.L  D1,-(A1)                         ; $10CBA6
        MOVE.L  D6,-(A4)                        ; $10CBA8
        ADD.L  A4,D3                            ; $10CBAA
        OR.L   D7,-$12(A0,A4.W)                 ; $10CBAC
        SF      (A2)                            ; $10CBB0
        OR.B   D4,-$6F(A5,D6.L)                 ; $10CBB2
        ROXR.B  D6,D7                           ; $10CBB6
        MOVE.L  -(A5),(A4)+                     ; $10CBB8
        MULU    -(A2),D2                        ; $10CBBA
        MOVE.L  $5CFD.W,$64D1(A2)               ; $10CBBC
        MOVEA.L (A5),A1                         ; $10CBC2
        SCC     $442442D2                       ; $10CBC4
        DC.W    $FFDB               ; $10CBCA MOVE.W  (A3)+,<EA:3F>
        SUB.L  (A1),D6                          ; $10CBCC
        SUBQ.B  #8,(A3)                         ; $10CBCE
        MOVEA.B (A2),A2                         ; $10CBD0
        MOVE.B  -(A5),-(A1)                     ; $10CBD2
        NEG.W  (A2)                             ; $10CBD4
        MOVE.W  -(A7),-(A2)                     ; $10CBD6
        MOVE.L  D5,$14C9(A4)                    ; $10CBD8
        CLR.B  A3                               ; $10CBDC
        DC.W    $4506               ; $10CBDE DC.W    $4506
        ROR.L  #5,D6                            ; $10CBE0
        ADDQ.B  #2,(A6)+                        ; $10CBE2
        ASL.W  #4,D4                            ; $10CBE4
        ASL.W  -(A2)                            ; $10CBE6
        MOVE.L  -$0624(A2),(A0)+                ; $10CBE8
        ADD.W  $0E6C(PC),D4                     ; $10CBEC
        LSR.W  D6,D7                            ; $10CBF0
        ASR.W  #5,D5                            ; $10CBF2
        MOVE.L  -(A0),D5                        ; $10CBF4
        SUBQ.L  #1,A1                           ; $10CBF6
        EOR.L  D0,-$5339(A6)                    ; $10CBF8
        LSL.W  $D6EAE1F2                        ; $10CBFC
        SNE     -$1735(A2)                      ; $10CC02
        DC.W    $4545               ; $10CC06 DC.W    $4545
        SPL     $5AAB2040                       ; $10CC08
        DC.W    $A5FC,$BFF1,$BD69,$3350; $10CC0E MOVE.L  #$BFF1BD69,$3350(PC)
        SUB.L  D2,(A5)                          ; $10CC16
        BMI.S  loc_10CBCB                       ; $10CC18
        ROXL.W  (A1)                            ; $10CC1A
        ROR.W  -(A1)                            ; $10CC1C
        MULU    A2,D5                           ; $10CC1E
        BSR.S  loc_10CC0C                       ; $10CC20
        SUBQ.W  #6,D0                           ; $10CC22
        DC.W    $FFD9               ; $10CC24 MOVE.W  (A1)+,<EA:3F>
        ASL.W  #8,D4                            ; $10CC26
        MOVE.B  -$16B2(A3),-(A1)                ; $10CC28
        ASR.L  D3,D7                            ; $10CC2C
        MULU    (A0),D0                         ; $10CC2E
        ASL.W  #8,D3                            ; $10CC30
        MOVE.W  $74E1(A3),-$24(PC,D5.W)         ; $10CC32
        ROXR.B  #8,D1                           ; $10CC38
        DC.W    $7DCA               ; $10CC3A MOVE.W  A2,<EA:3E>
        DC.W    $FFF8,$0B4B         ; $10CC3C MOVE.W  $0B4B.W,<EA:3F>
        LSR.W  (A6)                             ; $10CC40
        ADDQ.W  #2,(A1)                         ; $10CC42
        DBLT    D1,loc_10CC78                   ; $10CC44
loc_10CC48:
        MOVE.L  $1751(A0),$37(A0,A2.L)          ; $10CC48
        MOVE.B  D7,D5                           ; $10CC4E
        DIVS    -$1EB9(A0),D0                   ; $10CC50
        ASL.W  #1,D7                            ; $10CC54
        MOVE.B  -$30(A6,D4.W),-$070C(PC)        ; $10CC56
        ADD.W  $1C(A6,A6.L),D1                  ; $10CC5C
        LSL.L  D4,D2                            ; $10CC60
        CMPI.W  #$DDC9,-$6E(A4,D0.L)            ; $10CC62
        MOVE.L  A2,(A0)+                        ; $10CC68
        MOVE.W  -$0056(A7),-$26(A4,A0.L)        ; $10CC6A
        MOVEQ   #-$37,D4                        ; $10CC70
        MOVEQ   #-$35,D0                        ; $10CC72
        LSR.W  #$98CA                           ; $10CC74
loc_10CC78:
        BLE.S  loc_10CC48                       ; $10CC78
        SUBA.W  A2,A0                           ; $10CC7A
        MOVE.B  D5,$55(A0,A7.L)                 ; $10CC7C
        MOVE.W  (A5)+,(A2)+                     ; $10CC80
        ADDA.W  -(A1),A2                        ; $10CC82
        ASL.B  D6,D2                            ; $10CC84
        ORI.W  #$75CA,(A7)                      ; $10CC86
        MOVE.W  $EEA8.W,$DAF0.W                 ; $10CC8A
        MOVE.W  -$4738(A3),$10(A7,D0.L)         ; $10CC90
        ASR.B  #7,D7                            ; $10CC96
        LSR.W  D5,D2                            ; $10CC98
        MOVE.L  (A4),-$2F3F(A4)                 ; $10CC9A
        BCC.S  loc_10CC4C                       ; $10CC9E
        MOVE.W  -$17(PC,D2.L),$33E9.W           ; $10CCA0
        SHI     (A0)                            ; $10CCA6
        MOVE.W  A7,D4                           ; $10CCA8
        MOVE.B  D5,D5                           ; $10CCAA
        MOVE.W  -$0F(A3,A2.W),(A6)              ; $10CCAC
        DC.W    $C0BE               ; $10CCB0 AND.L  <EA:3E>,D0
        CLR    -$04(PC,A5.W)                    ; $10CCB2
        MOVE.W  (A0)+,$01E3(A3)                 ; $10CCB6
        MOVE.L  -(A3),D1                        ; $10CCBA
        MOVE.W  $0BDC.W,-$252B(A6)              ; $10CCBC
        EORI.L  #$D2243BA1,-(A0)                ; $10CCC2
        MOVE.W  (A6)+,(A5)+                     ; $10CCC8
        MOVE.L  D2,(A4)+                        ; $10CCCA
        TST.L  (A1)                             ; $10CCCC
        ROR.L  D0,D2                            ; $10CCCE
        ROR.W  D0,D0                            ; $10CCD0
        DC.W    $1BE3               ; $10CCD2 MOVE.B  -(A3),<EA:3D>
        DC.W    $FDF9,$13F9,$2A2B   ; $10CCD4 MOVE.W  $13F92A2B,<EA:3E>
        MOVE.W  -$16(A1,D2.W),D6                ; $10CCDA
        MOVEQ   #-$17,D0                        ; $10CCDE
        ASL.L  #3,D2                            ; $10CCE0
        MOVE.L  (A4),(A5)+                      ; $10CCE2
        AND.L  $2AFC(A1),D5                     ; $10CCE4
        MOVE.L  -(A3),(A1)+                     ; $10CCE8
        DC.W    $7BEA,$ADF8         ; $10CCEA MOVE.W  -$5208(A2),<EA:3D>
        BCHG    D6,(A1)+                        ; $10CCEE
        ADDA.W  $50(A0,A4.W),A5                 ; $10CCF0
        MOVE.W  -$5408(A2),-(A6)                ; $10CCF4
        SUBA.W  -$08(A2,D4.W),A2                ; $10CCF8
        DC.W    $0ADB               ; $10CCFC DC.W    $0ADB
        MOVE.W  -(A2),(A3)                      ; $10CCFE
        LEA     (A1)+,A3                        ; $10CD00
        AND.L  -$5740(A2),D2                    ; $10CD02
        MOVE.B  -$1F7D(A2),$9A85.W              ; $10CD06
        DC.W    $9EFE               ; $10CD0C SUBA.W  <EA:3E>,A7
        OR.L   -$6D60(A4),D1                    ; $10CD0E
        AND.L  D1,-$08(A0,A5.W)                 ; $10CD12
        BCLR    D4,(A0)+                        ; $10CD16
        MOVE.W  -(A0),$0B(A7,A7.L)              ; $10CD18
        MOVE.W  A2,$2DE0(A5)                    ; $10CD1C
        MOVE.W  A2,D4                           ; $10CD20
        DC.W    $F0FD               ; $10CD22 MOVE.W  <EA:3D>,(A0)+
        BSET    D6,$1861.W                      ; $10CD24
        DC.W    $417A               ; $10CD28 DC.W    $417A
        ASL.W  #4,D3                            ; $10CD2A
        MOVE.W  $6A41(A1),(A2)+                 ; $10CD2C
        DC.W    $10FF               ; $10CD30 MOVE.B  <EA:3F>,(A0)+
        MOVE.W  A5,D4                           ; $10CD32
        DIVS    (A1),D2                         ; $10CD34
        SUBQ.L  #8,-(A5)                        ; $10CD36
        AND.B  A1,D4                            ; $10CD38
        BSET    D4,(A1)+                        ; $10CD3A
        MOVE.W  A2,D0                           ; $10CD3C
        CMP.L  $51(A6,A5.W),D4                  ; $10CD3E
        MOVE.B  -$1F(A1,D2.L),-(A1)             ; $10CD42
        ADD.L  $44(A1,D3.W),D0                  ; $10CD46
        ADD.W  D5,D1                            ; $10CD4A
        ANDI.W  #$04E9,A0                       ; $10CD4C
        MOVE.B  -$01(PC,A7.W),-$2E(A5,A3.W)     ; $10CD50
        OR.L   D2,D5                            ; $10CD56
        MOVE.W  -(A6),-$2C01(A7)                ; $10CD58
        MOVE.W  A2,D4                           ; $10CD5C
        MOVE.W  (A2)+,-$23(A5,D6.W)             ; $10CD5E
        DC.W    $0EEF               ; $10CD62 DC.W    $0EEF
        ROL.W  -(A1)                            ; $10CD64
        AND.L  $4311F873,D4                     ; $10CD66
        MOVEA.W (A4),A2                         ; $10CD6C
        DC.W    $472A               ; $10CD6E DC.W    $472A
        ROXR.B  #5,D4                           ; $10CD70
        MOVE.W  $1474.W,$62EA(PC)               ; $10CD72
        DC.W    $FFF8,$0C4A         ; $10CD78 MOVE.W  $0C4A.W,<EA:3F>
        CMPA.W  #$ABDD,A2                       ; $10CD7C
        NEG.L  $1042(A2)                        ; $10CD80
        CMPA.L  #$ABF8B4FC,A5                   ; $10CD84
        EOR.B  D6,$3E88(A4)                     ; $10CD8A
        CMPA.W  (A5),A5                         ; $10CD8E
        ASL.W  $5BBD.W                          ; $10CD90
        SUBQ.W  #5,(A5)                         ; $10CD94
        MOVE.W  D0,D6                           ; $10CD96
        ROL.L  D3,D3                            ; $10CD98
        ADD.L  -$5445(A2),D5                    ; $10CD9A
        MOVE.L  #$F03BFDFF,(A5)+                ; $10CD9E
        CMP.L  -$3334(A2),D5                    ; $10CDA4
        DC.W    $ABD5               ; $10CDA8 MOVE.L  (A5),<EA:3D>
        CMPA.W  -(A1),A4                        ; $10CDAA
        ADD.W  (A3)+,D5                         ; $10CDAC
        OR.B   -(A1),D2                         ; $10CDAE
        ROL.W  (A5)+                            ; $10CDB0
        ADD.L  D1,-$421A(A5)                    ; $10CDB2
        MOVE.L  D6,-$21(A6,A7.W)                ; $10CDB6
        CMPA.W  #$ABFC,A5                       ; $10CDBA
        ADD.L  D5,-$4595(PC)                    ; $10CDBE
        SCS     (A3)+                           ; $10CDC2
        ADDA.L  (A3)+,A6                        ; $10CDC4
        SUBA.W  $0FFF.W,A7                      ; $10CDC6
        MOVE.W  (A1),D4                         ; $10CDCA
        SUBQ.B  #2,(A6)+                        ; $10CDCC
        CMPA.L  (A1),A0                         ; $10CDCE
        MOVEQ   #-$24,D1                        ; $10CDD0
        ASL.B  #8,D6                            ; $10CDD2
        EOR.L  D1,(A5)                          ; $10CDD4
        CMP.L  -$1F(PC,A6.W),D2                 ; $10CDD6
        MOVE.W  A1,D4                           ; $10CDDA
        DC.W    $00E9               ; $10CDDC DC.W    $00E9
        MOVE.W  -(A6),D6                        ; $10CDDE
        ADDA.L  #$FC5494B5,A0                   ; $10CDE0
        DC.W    $29E9,$FC44,$FCFF,$F81F; $10CDE6 MOVE.L  -$03BC(A1),#$FCFFF81F
        ADDA.L  -(A1),A5                        ; $10CDEE
        DC.W    $452A               ; $10CDF0 DC.W    $452A
        MOVE.B  (A0),(A0)                       ; $10CDF2
        CMP.L  A6,D1                            ; $10CDF4
        CMPA.L  A5,A1                           ; $10CDF6
        ASL.L  #8,D1                            ; $10CDF8
        ASL.W  -$095F(A6)                       ; $10CDFA
        MOVE.L  $F7A4.W,(A5)+                   ; $10CDFE
        OR.B   D0,(A6)                          ; $10CE02
        MOVE.W  A0,$17(A1,A3.W)                 ; $10CE04
        SUBA.L  $0A6A(A0),A5                    ; $10CE08
        SUBQ.B  #2,-$0BF0(A0)                   ; $10CE0C
        MOVE.W  A0,-$44(PC,A6.L)                ; $10CE10
        ADD.W  (A1),D1                          ; $10CE14
        BGE.S  loc_10CDC9                       ; $10CE16
        CMP.W  -(A4),D2                         ; $10CE18
        BNE.S  loc_10CDEF                       ; $10CE1A
        OR.W   D1,-(A6)                         ; $10CE1C
        BCLR    D6,$75(A1,A7.W)                 ; $10CE1E
        MOVEA.L -(A3),A0                        ; $10CE22
        SCC     -$32(PC,D1.W)                   ; $10CE24
        MOVE.B  -(A0),(A2)+                     ; $10CE28
        ST      -$3B(A0,A6.W)                   ; $10CE2A
        DC.W    $4F72               ; $10CE2E DC.W    $4F72
        SUBQ.B  #8,-(A5)                        ; $10CE30
        MOVE.W  (A2),D4                         ; $10CE32
        MOVEQ   #-$4F,D7                        ; $10CE34
        SUBQ.L  #2,-$4C(A5,D3.L)                ; $10CE36
        ST      -$4F97(A3)                      ; $10CE3A
        DC.W    $09CA               ; $10CE3E BSET    D4,A2
        MOVEA.L -$0310(A2),A4                   ; $10CE40
        BTST    D4,(A4)+                        ; $10CE44
        MOVE.W  D5,$0A55(A0)                    ; $10CE46
        MOVE.W  (A1)+,(A2)                      ; $10CE4A
        MOVE.B  -(A1),-$1E(A4,A2.W)             ; $10CE4C
        ASL.B  D3,D4                            ; $10CE50
        DC.W    $1FF4,$D7F3         ; $10CE52 MOVE.B  -$0D(A4,A5.W),<EA:3F>
        MOVE.L  (A2)+,(A5)+                     ; $10CE56
        DC.W    $000C,$FA35         ; $10CE58 ORI.B  #$FA35,A4
        MOVE.W  -$76(A4,A5.W),-$2105(A1)        ; $10CE5C
        MOVE.L  (A0)+,-$1EBC(A1)                ; $10CE62
        OR.L   D4,(A1)+                         ; $10CE66
        LEA     (A2),A2                         ; $10CE68
        BHI.S  loc_10CDF3                       ; $10CE6A
        SUBQ.B  #3,-(A0)                        ; $10CE6C
        MOVE.W  (A4),$4BFCFDBB                  ; $10CE6E
        ADDA.W  #$F03F,A2                       ; $10CE74
        CMPA.W  #$B4BA,A5                       ; $10CE78
        ADD.L  D5,-$45(A4,A3.L)                 ; $10CE7C
        ADD.L  D6,-$46(PC,A3.L)                 ; $10CE80
        ROR.B  #6,D7                            ; $10CE84
        MOVE.W  (A5)+,(A6)+                     ; $10CE86
        MOVE.L  -(A7),(A5)+                     ; $10CE88
        MOVEA.W A3,A6                           ; $10CE8A
        ADD.L  -$55(PC,A5.L),D2                 ; $10CE8C
        DC.W    $DBBD               ; $10CE90 ADD.L  D5,<EA:3D>
        BSET    D0,-(A0)                        ; $10CE92
        LSL.W  #$F9FC                           ; $10CE94
        ADD.L  -$02BD(A2),D5                    ; $10CE98
        ADD.L  D6,#$1FF1ACAC                    ; $10CE9C
        AND.L  -$55(PC,A3.L),D6                 ; $10CEA2
        DC.W    $ABFC,$BBA2,$3CFD   ; $10CEA6 MOVE.L  #$BBA23CFD,<EA:3D>
        MOVE.W  #$FCBC,$04(A7,A4.L)             ; $10CEAC
        DC.W    $04E8               ; $10CEB2 DC.W    $04E8
        MULS    -$0006(PC),D5                   ; $10CEB4
        NEGX.B D0                               ; $10CEB8
        DC.W    $F5FF,$EDF7         ; $10CEBA MOVE.W  <EA:3F>,-$1209(PC)
        DC.W    $0024,$FDEB         ; $10CEBE ORI.B  #$FDEB,-(A4)
        DC.W    $FFF7,$EA87         ; $10CEC2 MOVE.W  -$79(A7,A6.L),<EA:3F>
        MOVE.W  -$2717(PC),-$56(A4,A3.L)        ; $10CEC6
        AND.L  D5,$1AF9(A2)                     ; $10CECC
        AND.W  D0,D4                            ; $10CED0
        MOVE.L  -$14(A6,A7.L),$5344.W           ; $10CED2
        EOR.L  D3,#$ABD7CBC4                    ; $10CED8
        EOR.L  D2,$6E(A5,A2.L)                  ; $10CEDE
        DC.W    $F1BF,$A2CC         ; $10CEE2 MOVE.W  <EA:3F>,-$34(A0,A2.W)
        MOVE.L  -$0F(A4,D6.L),$51F2(A0)         ; $10CEE6
        NOT    D2                               ; $10CEEC
        EOR.L  D1,-(A4)                         ; $10CEEE
        OR.B   D6,(A1)                          ; $10CEF0
        LEA     -$4B(A2,D7.W),A0                ; $10CEF2
        MOVE.W  $74(A7,A7.L),-$0900(A0)         ; $10CEF6
        MOVE.B  -$16(A2,D2.L),$F810.W           ; $10CEFC
        ST      -$1F04(A1)                      ; $10CF02
        ADD.L  $0F(A4,A5.L),D4                  ; $10CF06
        SUBQ.L  #2,A7                           ; $10CF0A
        ROXR.W  D5                              ; $10CF0C
        ROXR.W  #2,D0                           ; $10CF0E
        BSET    D4,-$3D(A3,A7.W)                ; $10CF10
        SUB.L  -$26EB(A7),D1                    ; $10CF14
        MOVE.B  (A2),-(A0)                      ; $10CF18
        MOVEA.L -$07AF(A2),A5                   ; $10CF1A
        MULS    -$3C89(PC),D4                   ; $10CF1E
        BMI.S  loc_10CEF8                       ; $10CF22
        BLE.S  loc_10CEEA                       ; $10CF24
        DC.W    $FDC2               ; $10CF26 MOVE.W  D2,<EA:3E>
        MOVE.W  -$36EF(A4),-(A0)                ; $10CF28
        MOVE.L  -$6E67(A2),$53(A6,D3.W)         ; $10CF2C
        MOVE.L  -(A0),$27(A0,A5.L)              ; $10CF32
        LSL.W  -$03(A0,A5.L)                    ; $10CF36
        ROXR.W  D5,D0                           ; $10CF3A
        SUBA.W  (A2)+,A1                        ; $10CF3C
        ADDQ.W  #4,$50(A1,A5.L)                 ; $10CF3E
        MOVE.L  (A3)+,D0                        ; $10CF42
        CMPA.W  (A4)+,A4                        ; $10CF44
        DC.W    $41B8               ; $10CF46 DC.W    $41B8
        ADD.B  -(A5),D5                         ; $10CF48
        MOVE.W  (A2),-(A0)                      ; $10CF4A
        MOVE.L  D3,(A4)                         ; $10CF4C
        MOVE.L  -$779F(A0),$12(A0,A3.L)         ; $10CF4E
        CMP.L  -$3DC8(A2),D0                    ; $10CF54
        ADD.B  A1,D4                            ; $10CF58
        MOVEA.L (A0)+,A4                        ; $10CF5A
        MOVEA.B -$6EBA(PC),A2                   ; $10CF5C
        MOVE.L  (A7)+,#$64FD32BD                ; $10CF60
        OR.W   D4,-$80(A2,D0.L)                 ; $10CF66
        MOVEQ   #-$3F,D4                        ; $10CF6A
        SUBQ.B  #8,(A2)                         ; $10CF6C
        DC.W    $4D23               ; $10CF6E DC.W    $4D23
        MOVE.L  (A0),D5                         ; $10CF70
        ROL.B  D1,D2                            ; $10CF72
        MOVE.W  A0,$934F.W                      ; $10CF74
        DIVU    (A7)+,D5                        ; $10CF78
        DC.W    $41FF               ; $10CF7A LEA     <EA:3F>,A0
        SUBQ.W  #2,D4                           ; $10CF7C
        MOVE.L  -$6D87(A3),(A6)+                ; $10CF7E
        DC.W    $474D               ; $10CF82 DC.W    $474D
loc_10CF84:
        SUBQ.B  #8,(A4)+                        ; $10CF84
        CMP.L  -(A4),D1                         ; $10CF86
        LSR.L  D1,D6                            ; $10CF88
        BPL.S  loc_10CF84                       ; $10CF8A
        AND.W  D7,-(A2)                         ; $10CF8C
        BSET    #28,(A5)+                       ; $10CF8E
        MOVE.W  (A5),D4                         ; $10CF92
        SUB.L  $1450(A2),D1                     ; $10CF94
        EOR.W  D4,A0                            ; $10CF98
        LEA     (A4),A6                         ; $10CF9A
        EOR.L  D7,(A3)+                         ; $10CF9C
        ST      $0A88.W                         ; $10CF9E
        ROXL.B  #7,D6                           ; $10CFA2
        DC.W    $00BC,$D80B,$E0E8,$15DC,$E0EF; $10CFA4 ORI.L  #$D80BE0E8,#$15DCE0EF
        DC.W    $E0FE               ; $10CFAE ASR.W  <EA:3E>
        ASR.L  #4,D4                            ; $10CFB0
        ASR.W  -(A2)                            ; $10CFB2
        CMPA.L  (A4)+,A5                        ; $10CFB4
        CMPA.W  $3010(A4),A5                    ; $10CFB6
        DC.W    $EAFE               ; $10CFBA LSR.W  <EA:3E>
        MULU    A4,D6                           ; $10CFBC
loc_10CFBE:
        DC.W    $FDFA,$42AC         ; $10CFBE MOVE.W  $42AC(PC),<EA:3E>
        DC.W    $F4FF               ; $10CFC2 MOVE.W  <EA:3F>,(A2)+
        DC.W    $A1FD,$1BC1         ; $10CFC4 MOVE.L  <EA:3D>,$1BC1.W
        ASL.B  D6,D0                            ; $10CFC8
        MOVE.B  (A4),(A3)+                      ; $10CFCA
        DC.W    $EAFD               ; $10CFCC LSR.W  <EA:3D>
        ADDA.W  -$0246(A1),A3                   ; $10CFCE
        MULS    $500D(A1),D1                    ; $10CFD2
        ROXL.W  -$16(A5,A2.L)                   ; $10CFD6
        ROXL.W  -$1D16(A2)                      ; $10CFDA
        MOVE.L  D0,-(A5)                        ; $10CFDE
        BSR.S  loc_10CFBE                       ; $10CFE0
        MOVE.W  -$5424(A7),#$ABAA               ; $10CFE2
        MOVE.B  D5,-$4716(PC)                   ; $10CFE8
        ADDA.W  -$7B15(A2),A0                   ; $10CFEC
        ASR.L  D3,D7                            ; $10CFF0
        ADDA.L  (A0)+,A4                        ; $10CFF2
        MOVE.W  -$5C(A1,A2.L),D1                ; $10CFF4
        DC.W    $D9FF               ; $10CFF8 ADDA.L  <EA:3F>,A4
        MULS    (A5)+,D1                        ; $10CFFA
        BTST    #16,-$1604(A0)                  ; $10CFFC
        MOVE.W  $03(A1,A7.L),#$8FFD             ; $10D002
        MOVE.W  -(A7),$111AFF10                 ; $10D008
        AND.L  -$4F(A1,A2.L),D5                 ; $10D00E
        ADDA.W  A3,A6                           ; $10D012
        CMP.L  -$13(A1,A4.W),D5                 ; $10D014
        EOR.B  D0,D7                            ; $10D018
        MOVEQ   #$7F,D4                         ; $10D01A
        EOR.W  D5,-$7F(A7,A7.W)                 ; $10D01C
        MULU    D7,D6                           ; $10D020
        MOVE.W  #$688A,-$0384(A5)               ; $10D022
        BSET    D7,(A1)+                        ; $10D028
        NEG    #$BB0E                           ; $10D02A
        DC.W    $00FC               ; $10D02E DC.W    $00FC
        SLS     (A1)+                           ; $10D030
        LEA     (A3)+,A6                        ; $10D032
        MOVE.W  #$71E8,$FBBD.W                  ; $10D034
        MOVE.W  (A5)+,(A0)+                     ; $10D03A
        MOVE.L  $75(A7,A5.L),(A5)+              ; $10D03C
        ADD.B  A3,D4                            ; $10D040
        DC.W    $4B30               ; $10D042 DC.W    $4B30
        ANDI.L  #$FCDDBAFC,-(A4)                ; $10D044
        MOVEQ   #$02,D3                         ; $10D04A
        ADDA.W  #$F7E1,A2                       ; $10D04C
        CMPA.W  -(A1),A5                        ; $10D050
        DC.W    $F2FF               ; $10D052 MOVE.W  <EA:3F>,(A1)+
        MOVE.W  (A2)+,D4                        ; $10D054
        SCS     (A0)+                           ; $10D056
        DC.W    $4B4D               ; $10D058 DC.W    $4B4D
        TST    D3                               ; $10D05A
        ADD.L  A3,D6                            ; $10D05C
        MOVE.L  D7,(A2)+                        ; $10D05E
        MOVE.W  -$55(A7,A3.W),-$61(A7,A6.W)     ; $10D060
        ADDQ.L  #8,-$5256(A3)                   ; $10D066
        DC.W    $BDBD               ; $10D06A EOR.L  D6,<EA:3D>
        DC.W    $ADE0               ; $10D06C MOVE.L  -(A0),<EA:3E>
        LSL.W  A4                               ; $10D06E
        OR.W   (A5),D5                          ; $10D070
        MOVE.B  #$8BE0,(A0)                     ; $10D072
        MOVE.W  A7,D4                           ; $10D076
        ADDA.W  -$04B6(A2),A4                   ; $10D078
        ADDA.W  $4AB0(A4),A5                    ; $10D07C
        MOVE.L  $71(A6,A6.W),(A5)+              ; $10D080
        ASR.W  $0B38.W                          ; $10D084
        ASR.W  #6,D0                            ; $10D088
        EOR.W  D0,(A7)+                         ; $10D08A
        CMPA.L  -$6D(A1,D2.W),A0                ; $10D08C
        MOVE.L  -$0346(A2),$2A(A5,D2.L)         ; $10D090
        DC.W    $ABBD,$DF54         ; $10D096 MOVE.L  <EA:3D>,$54(A5,A5.L)
        MOVE.W  -(A0),(A4)+                     ; $10D09A
        CMP.W  (A4),D5                          ; $10D09C
        MOVE.W  A3,D4                           ; $10D09E
        DC.W    $FFFC,$DFA2         ; $10D0A0 MOVE.W  #$DFA2,<EA:3F>
        MOVE.L  $08AB(A3),(A1)                  ; $10D0A4
        ADD.W  D6,-(A0)                         ; $10D0A8
        ADD.B  D0,(A4)+                         ; $10D0AA
        ADDA.L  (A2)+,A5                        ; $10D0AC
        MOVE.L  (A3),$0858(A4)                  ; $10D0AE
        DC.W    $0A18,$00DC         ; $10D0B2 EORI.B  #$00DC,(A0)+
        SUBA.W  -(A1),A1                        ; $10D0B6
        MOVE.L  D2,(A1)+                        ; $10D0B8
        EOR.W  D5,(A6)                          ; $10D0BA
        DC.W    $1DBD,$DBBB         ; $10D0BC MOVE.B  <EA:3D>,-$45(A6,A5.L)
        MULU    $18AB(A3),D4                    ; $10D0C0
        CMP.W  $49EB(A3),D4                     ; $10D0C4
        MOVE.L  $30F9(A3),-$20(A0,A7.L)         ; $10D0C8
        MOVE.B  -(A0),(A5)+                     ; $10D0CE
        BSET    #10,$45A4(A0)                   ; $10D0D0
        LSL.L  D5,D0                            ; $10D0D6
        MOVE.L  $54A0(A3),(A2)                  ; $10D0D8
        MOVE.W  -(A0),(A7)+                     ; $10D0DC
        ROXR.B  #8,D5                           ; $10D0DE
        EOR.W  D6,(A4)                          ; $10D0E0
        BRA.S  loc_10D09B                       ; $10D0E2
        ASL.W  (A2)+                            ; $10D0E4
        MOVE.L  (A0)+,(A5)                      ; $10D0E6
        DC.W    $C9FF               ; $10D0E8 MULS    <EA:3F>,D4
        MOVE.W  (A2)+,D4                        ; $10D0EA
        ST      (A1)+                           ; $10D0EC
        NEG.B  -$0E55(PC)                       ; $10D0EE
        ADDA.L  $22F1(A2),A7                    ; $10D0F2
        DIVU    (A1)+,D7                        ; $10D0F6
        BSET    D6,-(A3)                        ; $10D0F8
        MULU    -$38C3(A2),D1                   ; $10D0FA
        MOVE.W  #$FBC7,$77FB(A0)                ; $10D0FE
        MOVEQ   #-$06,D6                        ; $10D104
        BCHG    D1,-$16(A7,A2.L)                ; $10D106
        MOVE.W  -$54(A3,A3.L),(A1)+             ; $10D10A
        EOR.W  D5,#$AA1C                        ; $10D10E
        MOVE.W  (A6)+,D4                        ; $10D112
        CMPA.L  #$CCAA11FB,A0                   ; $10D114
        DC.W    $FFC7               ; $10D11A MOVE.W  D7,<EA:3F>
        MULU    (A4),D5                         ; $10D11C
        MOVE.B  -$16(A1,A7.L),-$0E(PC,D0.L)     ; $10D11E
        ADDA.L  (A6),A3                         ; $10D124
        MOVE.W  A5,-$247F(A5)                   ; $10D126
        CMP.W  #$7CED,D0                        ; $10D12A
        CMP.L  -$55D0(A2),D4                    ; $10D12E
        ADDQ.L  #2,(A4)                         ; $10D132
        ASR.L  D5,D7                            ; $10D134
        CMP.L  -$6656(A2),D5                    ; $10D136
        DC.W    $7DE9,$A8EB         ; $10D13A MOVE.W  -$5715(A1),<EA:3E>
        SUBQ.W  #8,D0                           ; $10D13E
        SPL     -$05E5(A2)                      ; $10D140
        ADDA.L  -$6B(PC,A7.L),A5                ; $10D144
        DC.W    $050C               ; $10D148 BTST    D2,A4
        ADD.B  D5,D0                            ; $10D14A
        ADD.L  D6,D0                            ; $10D14C
        LSR.W  -$2E(PC,A6.W)                    ; $10D14E
        ADD.B  -(A4),D6                         ; $10D152
        DC.W    $04E0               ; $10D154 DC.W    $04E0
        BHI.S  loc_10D133                       ; $10D156
        MOVEA.W D0,A5                           ; $10D158
        DC.W    $7DFD               ; $10D15A MOVE.W  <EA:3D>,<EA:3E>
        AND.B  D5,D0                            ; $10D15C
        DC.W    $DB7D               ; $10D15E ADD.W  D5,<EA:3D>
        LSL.W  A3                               ; $10D160
        CMPA.W  A4,A5                           ; $10D162
        AND.L  D7,D5                            ; $10D164
        DC.W    $23F9,$E11A,$BC52,$1ABA,$7AFC; $10D166 MOVE.L  $E11ABC52,$1ABA7AFC
        MOVE.W  D3,(A6)+                        ; $10D170
        SUB.B  (A2)+,D4                         ; $10D172
        MOVE.L  (A2)+,D5                        ; $10D174
        MOVE.B  -$48E6(A2),$45(A0,D7.W)         ; $10D176
        MOVE.W  (A7)+,-(A2)                     ; $10D17C
        ROXR.W  D0,D7                           ; $10D17E
        SUBQ.W  #3,$7B(A5,D7.W)                 ; $10D180
        MOVE.B  -$56(A1,A2.W),$A1C4.W           ; $10D184
        ORI.W  #$D460,$18(A7,A7.L)              ; $10D18A
        MOVE.W  $57(A4,A7.L),(A0)+              ; $10D190
        SLE     (A7)+                           ; $10D194
        SEQ     (A3)+                           ; $10D196
        EOR.W  D7,-(A1)                         ; $10D198
        EOR.L  D6,-$43(PC,D2.L)                 ; $10D19A
        ADD.L  D5,$4F(PC,A1.W)                  ; $10D19E
        ADDA.L  (A3)+,A0                        ; $10D1A2
        BHI.S  loc_10D153                       ; $10D1A4
        ADDA.L  (A4),A6                         ; $10D1A6
        MOVE.W  -(A3),-(A7)                     ; $10D1A8
        DIVU    D1,D5                           ; $10D1AA
        DC.W    $FFF8,$0929         ; $10D1AC MOVE.W  $0929.W,<EA:3F>
        MOVE.L  (A3)+,#$2992D2DB                ; $10D1B0
        SUB.L  D6,D0                            ; $10D1B6
        DC.W    $0FBD               ; $10D1B8 BCLR    D7,<EA:3D>
        DC.W    $3CBD               ; $10D1BA MOVE.W  <EA:3D>,(A6)
        ADDA.L  (A3)+,A4                        ; $10D1BC
        EOR.L  D4,$2146(A5)                     ; $10D1BE
        DC.W    $FCBD               ; $10D1C2 MOVE.W  <EA:3D>,(A6)
        LSR.W  (A5)+                            ; $10D1C4
        MOVE.W  A5,(A6)+                        ; $10D1C6
        MOVE.W  A0,D6                           ; $10D1C8
        DC.W    $07FF               ; $10D1CA BSET    D3,<EA:3F>
        ADDA.L  -(A0),A4                        ; $10D1CC
        DC.W    $2DD2               ; $10D1CE MOVE.L  (A2),<EA:3E>
        CMPA.W  -(A0),A1                        ; $10D1D0
        BSR.S  loc_10D1EC                       ; $10D1D2
        LEA     D2,A5                           ; $10D1D4
        ADD.L  D5,(A1)+                         ; $10D1D6
        SUB.L  D4,-$65(A4,A5.L)                 ; $10D1D8
        BSET    D0,(A2)                         ; $10D1DC
        DC.W    $FCFD               ; $10D1DE MOVE.W  <EA:3D>,(A6)+
        CMPA.W  A5,A0                           ; $10D1E0
        ROR.L  D0,D1                            ; $10D1E2
        MOVE.B  D2,(A0)+                        ; $10D1E4
        MOVE.L  -(A6),-$19(A6,A3.W)             ; $10D1E6
        ADDA.L  -(A2),A6                        ; $10D1EA
loc_10D1EC:
        ADD.B  -(A1),D5                         ; $10D1EC
        OR.L   -$461F(A5),D3                    ; $10D1EE
        MOVE.L  (A5)+,(A5)+                     ; $10D1F2
        SUB.W  D4,D7                            ; $10D1F4
        MOVE.B  D0,-(A5)                        ; $10D1F6
        MULS    A1,D4                           ; $10D1F8
        ADD.L  D5,-(A0)                         ; $10D1FA
        MOVE.W  -$5B7C(A3),-(A6)                ; $10D1FC
        OR.W   D3,-(A2)                         ; $10D200
        MOVE.L  (A2)+,(A4)+                     ; $10D202
        DC.W    $ABFC,$A933,$E1E1   ; $10D204 MOVE.L  #$A933E1E1,<EA:3D>
        SUB.B  D4,-$1E(A0,D7.L)                 ; $10D20A
        DIVU    $0992.W,D0                      ; $10D20E
        DC.W    $FFD2               ; $10D212 MOVE.W  (A2),<EA:3F>
        DC.W    $29B9,$2BD9,$1880,$A79B; $10D214 MOVE.L  $2BD91880,-$65(A4,A2.W)
        ADD.W  D4,-(A1)                         ; $10D21C
        EOR.L  D5,-(A2)                         ; $10D21E
loc_10D220:
        BSET    D0,-(A0)                        ; $10D220
        DC.W    $9CFF               ; $10D222 SUBA.W  <EA:3F>,A6
        ASR.W  $0A92.W                          ; $10D224
        ADDQ.W  #6,A0                           ; $10D228
        DC.W    $0DFF               ; $10D22A BSET    D6,<EA:3F>
        DC.W    $E8FF               ; $10D22C ASR.W  <EA:3F>
        DC.W    $FDC2               ; $10D22E MOVE.W  D2,<EA:3E>
        MOVE.W  A2,D4                           ; $10D230
        DC.W    $E0FE               ; $10D232 ASR.W  <EA:3E>
        MOVE.L  D0,-(A5)                        ; $10D234
        BSR.S  loc_10D218                       ; $10D236
        BPL.S  loc_10D220                       ; $10D238
        SUBA.W  #$CCCB,A5                       ; $10D23A
        MOVE.W  -(A1),D3                        ; $10D23E
        LEA     -(A0),A4                        ; $10D240
        MOVE.W  A5,D4                           ; $10D242
        EOR.B  D4,-$5666(A1)                    ; $10D244
        MOVE.W  $50(PC,D4.W),-$01(A5,A6.W)      ; $10D248
        AND.W  D6,D5                            ; $10D24E
        ADDA.L  $0CA0.W,A7                      ; $10D250
        MOVE.W  A6,D4                           ; $10D254
        MOVE.W  A6,-(A4)                        ; $10D256
        MOVE.L  $0CE0.W,(A2)+                   ; $10D258
        SUBA.L  -(A0),A5                        ; $10D25C
        MOVE.L  -$78FF(A2),-(A5)                ; $10D25E
        MOVE.L  -$4547(A3),-$53(A2,A4.W)        ; $10D262
        CMPA.L  #$D4EAFFC0,A5                   ; $10D268
        MOVE.W  (A7),D4                         ; $10D26E
        MULU    $0FE0.W,D2                      ; $10D270
        MOVE.W  A7,D4                           ; $10D274
        SUBA.W  (A4)+,A6                        ; $10D276
        MOVE.W  (A2),D4                         ; $10D278
        MOVE.L  $0FDC.W,(A0)+                   ; $10D27A
        MOVE.W  A7,D4                           ; $10D27E
        MOVE.W  (A2)+,-(A3)                     ; $10D280
        MOVEA.W #$77EB,A0                       ; $10D282
        DIVS    (A1)+,D6                        ; $10D286
        DC.W    $77FE,$FF7C         ; $10D288 MOVE.W  <EA:3E>,$7C(PC,A7.L)
        SWAP    D0                              ; $10D28C
        MOVE.W  A1,-$1603(A6)                   ; $10D28E
        LSL.L  #3,D2                            ; $10D292
        MOVE.B  -(A5),$94E9.W                   ; $10D294
        MOVE.L  -$0939(A1),(A3)+                ; $10D298
        MOVE.W  D1,-(A7)                        ; $10D29C
        SCS     (A6)+                           ; $10D29E
        ASR.W  A4                               ; $10D2A0
        DC.W    $F3E9,$1AE9,$C1E9,$2056; $10D2A2 MOVE.W  $1AE9(A1),$C1E92056
        ASL.W  (A2)+                            ; $10D2AA
        MOVEA.W A3,A2                           ; $10D2AC
        LSL.L  D5,D3                            ; $10D2AE
        MOVE.W  (A0),$50F2(A6)                  ; $10D2B0
        CMPA.L  (A2),A5                         ; $10D2B4
        ROR.W  -(A4)                            ; $10D2B6
        ADD.W  -(A4),D6                         ; $10D2B8
        ROXL.L  #4,D1                           ; $10D2BA
        ASL.B  D4,D0                            ; $10D2BC
        SNE     $F4F86CC4                       ; $10D2BE
        SUBA.L  (A4),A2                         ; $10D2C4
        LSL.L  #4,D6                            ; $10D2C6
        BLE.S  loc_10D26B                       ; $10D2C8
        MOVE.W  $53(A5,D3.W),-(A7)              ; $10D2CA
        LSL.L  #4,D2                            ; $10D2CE
        MOVE.W  (A2),-$0790(A2)                 ; $10D2D0
        MOVE.W  $33(A5,D5.W),(A0)+              ; $10D2D4
        MOVE.L  $53(A5,A7.L),-(A2)              ; $10D2D8
        MOVE.L  (A3),$1191(A1)                  ; $10D2DC
        OR.L   D5,D1                            ; $10D2E0
        DC.W    $DFFD               ; $10D2E2 ADDA.L  <EA:3D>,A7
        LSR.L  #1,D2                            ; $10D2E4
        BSET    D1,-$68(A7,D5.W)                ; $10D2E6
        SUBA.L  -(A0),A0                        ; $10D2EA
        ADDQ.W  #1,(A3)                         ; $10D2EC
        LSR.B  #1,D4                            ; $10D2EE
        DC.W    $00DF               ; $10D2F0 DC.W    $00DF
        SUBQ.B  #1,-$07(A2,A7.W)                ; $10D2F2
        BCLR    D7,D5                           ; $10D2F6
        MOVEA.W (A2),A4                         ; $10D2F8
        BLS.S  loc_10D32E                       ; $10D2FA
        SHI     $361F(PC)                       ; $10D2FC
        LEA     $3FEC(A1),A0                    ; $10D300
        MOVE.L  $63(A2,D3.W),-(A1)              ; $10D304
        MOVEA.L -(A3),A3                        ; $10D308
        DC.W    $23EA,$3136,$AA69,$5334; $10D30A MOVE.L  $3136(A2),$AA695334
        MOVE.W  (A3),D6                         ; $10D312
        ADD.W  (A2),D0                          ; $10D314
        MOVE.W  (A6)+,$43563516                 ; $10D316
        MOVE.W  $35(A0,A6.W),(A3)+              ; $10D31C
        MOVE.L  (A1),$2356(A7)                  ; $10D320
        MOVE.W  -(A6),D1                        ; $10D324
        ROXL.B  D1,D3                           ; $10D326
        MOVE.W  -$00CC(A7),(A1)+                ; $10D328
        SUBQ.W  #1,-(A1)                        ; $10D32C
loc_10D32E:
        MOVE.B  $22(A2,A3.L),-(A1)              ; $10D32E
        MOVE.B  D6,$1422(A1)                    ; $10D332
        MOVE.L  D2,$1136(A1)                    ; $10D336
loc_10D33A:
        MOVE.B  $32(A7,A6.L),(A1)+              ; $10D33A
        MOVE.B  -(A7),-(A0)                     ; $10D33E
        LEA     (A4)+,A1                        ; $10D340
        MOVE.W  D3,$2575(A4)                    ; $10D342
        MOVEQ   #$63,D1                         ; $10D346
        MOVE.W  $71(A4,A5.W),D3                 ; $10D348
        MOVE.W  A6,D1                           ; $10D34C
        MOVE.W  (A1)+,-(A5)                     ; $10D34E
        OR.W   $3447CD22,D5                     ; $10D350
        DC.W    $34FF               ; $10D356 MOVE.W  <EA:3F>,(A2)+
        OR.B   (A4),D5                          ; $10D358
        MOVE.W  -(A1),-(A1)                     ; $10D35A
        ASL.B  #7,D1                            ; $10D35C
        MOVEA.L D6,A2                           ; $10D35E
        MOVEA.W D2,A1                           ; $10D360
        CLR    (A1)+                            ; $10D362
        BVS.S  loc_10D3A9                       ; $10D364
        MOVE.L  -(A2),D3                        ; $10D366
        MOVEA.W (A4)+,A1                        ; $10D368
        DC.W    $00C9               ; $10D36A DC.W    $00C9
        MOVE.B  A1,(A0)+                        ; $10D36C
        MOVE.W  -(A6),D2                        ; $10D36E
        ADD.W  D4,A1                            ; $10D370
        CMPA.W  $8000.W,A6                      ; $10D372
        ASL.W  (A3)+                            ; $10D376
        DC.W    $237C,$FABF,$D0C1,$723D; $10D378 MOVE.L  #$FABFD0C1,$723D(A1)
        BVS.S  loc_10D395                       ; $10D380
        MOVE.L  (A2),D2                         ; $10D382
        MOVE.B  $26(A1,D2.W),D2                 ; $10D384
        MOVE.W  $7E(A4,D5.W),-(A1)              ; $10D388
        BTST    #8,$32(A5,D0.L)                 ; $10D38C
        MOVEA.W D5,A1                           ; $10D392
        MOVE.B  $12(A1,A5.W),-(A1)              ; $10D394
        BTST    D7,(A7)+                        ; $10D398
        AND.B  $45(A3,D6.W),D6                  ; $10D39A
        BSR.S  loc_10D33A                       ; $10D39E
        MOVE.L  $21(A1,D4.W),D3                 ; $10D3A0
        DC.W    $21FE,$C37B         ; $10D3A4 MOVE.L  <EA:3E>,$C37B.W
        NEG.W  -(A3)                            ; $10D3A8
        MOVE.W  D4,$3455(A3)                    ; $10D3AA
        BEQ.S  loc_10D3F2                       ; $10D3AE
        MOVE.W  $1287(A2),(A3)                  ; $10D3B0
        BTST    D7,$63(A1,D1.W)                 ; $10D3B4
        NEG    D3                               ; $10D3B8
        MOVE.W  $43(A3,D5.W),-(A1)              ; $10D3BA
        MOVE.W  (A0),-(A0)                      ; $10D3BE
        MOVEA.L (A7)+,A0                        ; $10D3C0
        MOVE.W  -$01(A1,A5.W),-(A0)             ; $10D3C2
        MOVE.B  A4,D1                           ; $10D3C6
        DC.W    $3BF8,$2462         ; $10D3C8 MOVE.W  $2462.W,<EA:3D>
        AND.B  D5,(A2)                          ; $10D3CC
        DC.W    $4373               ; $10D3CE DC.W    $4373
loc_10D3D0:
        MOVE.W  -(A4),-(A0)                     ; $10D3D0
        BNE.S  loc_10D3D0                       ; $10D3D2
        MOVE.B  A1,(A0)+                        ; $10D3D4
        MOVEQ   #$42,D1                         ; $10D3D6
        MOVE.L  (A1),-(A2)                      ; $10D3D8
        CLR.B  (A2)                             ; $10D3DA
        OR.B   -(A2),D1                         ; $10D3DC
        MOVEQ   #$28,D7                         ; $10D3DE
        ROXL.W  #5,D5                           ; $10D3E0
        MOVE.W  -(A1),D1                        ; $10D3E2
        MOVE.B  -$26(A3,D6.W),-(A1)             ; $10D3E4
        MOVE.W  A3,(A2)                         ; $10D3E8
        MULS    #$63F6,D0                       ; $10D3EA
        MOVE.L  $13(A4,D2.W),D2                 ; $10D3EE
loc_10D3F2:
        DC.W    $4734               ; $10D3F2 DC.W    $4734
        MOVE.W  -(A4),D3                        ; $10D3F4
        OR.W   D2,D6                            ; $10D3F6
        MOVE.B  D2,-$2F(A7,A0.L)                ; $10D3F8
        CLR.B  -(A3)                            ; $10D3FC
        MOVEA.L D3,A3                           ; $10D3FE
        BHI.S  loc_10D428                       ; $10D400
        CMPA.L  -$77(A0,D0.W),A1                ; $10D402
        ADDQ.W  #5,$2141(PC)                    ; $10D406
        MOVE.L  (A3),$2431(A2)                  ; $10D40A
        MOVE.W  (A6),$75(A1,D0.W)               ; $10D40E
        CMPA.L  -$08B7(A2),A0                   ; $10D412
        ADDA.L  $49(A1,D0.W),A4                 ; $10D416
        MOVE.L  D6,$1089(A0)                    ; $10D41A
        CLR.W  A4                               ; $10D41E
        AND.B  -$78(A4,D2.L),D1                 ; $10D420
        OR.B   -(A4),D4                         ; $10D424
        MOVE.B  (A4),D6                         ; $10D426
loc_10D428:
        CMPI.B  #$4204,D2                       ; $10D428
        MOVE.W  -$7D61(A3),$2487(A1)            ; $10D42C
        MOVE.W  $27(A0,A4.W),D0                 ; $10D432
        BNE.S  loc_10D4AC                       ; $10D436
        MOVE.W  $1673(A6),$11DF(A3)             ; $10D438
        MOVE.L  -(A3),D4                        ; $10D43E
        CLR.W  $77(A3,D1.W)                     ; $10D440
        SUBQ.W  #1,$53(A1,A5.W)                 ; $10D444
loc_10D448:
        OR.W   $0F(A4,D6.W),D0                  ; $10D448
        MOVE.W  D0,(A0)                         ; $10D44C
        MOVE.W  (A0)+,D4                        ; $10D44E
        MOVE.W  -(A7),-(A3)                     ; $10D450
        SUBQ.B  #1,(A2)                         ; $10D452
        MOVE.L  (A0),(A6)                       ; $10D454
        MOVE.B  (A6),-(A0)                      ; $10D456
        NEG.W  -(A1)                            ; $10D458
        ADD.W  D5,-(A4)                         ; $10D45A
        CMP.B  -(A3),D6                         ; $10D45C
        SLS     -(A1)                           ; $10D45E
        MOVEA.L D1,A3                           ; $10D460
        BCHG    #2,-$16CA(A7)                   ; $10D462
        BSR.S  loc_10D48E                       ; $10D468
        SUBQ.W  #8,$31(PC,D6.W)                 ; $10D46A
        MOVE.B  -$67(A6,D0.W),(A0)+             ; $10D46E
        DC.W    $23EC,$4234,$4A29,$5343; $10D472 MOVE.L  $4234(A4),$4A295343
        BSET    D1,(A4)                         ; $10D47A
        MOVEA.B (A4),A1                         ; $10D47C
        MOVE.W  A5,$FA11.W                      ; $10D47E
        EOR.L  D4,$5BF10183                     ; $10D482
        MOVE.W  $7A(A1,D3.L),D2                 ; $10D488
        SUB.W  D0,$7FA1.W                       ; $10D48C
        DC.W    $4969               ; $10D490 DC.W    $4969
        DC.W    $4324               ; $10D492 DC.W    $4324
        OR.W   D1,D3                            ; $10D494
        NOT.W  D3                               ; $10D496
        DBCC    D6,$11268D                      ; $10D498
        BHI.S  loc_10D461                       ; $10D49C
        DIVS    -(A3),D3                        ; $10D49E
        OR.B   D0,(A4)                          ; $10D4A0
        BLS.S  loc_10D448                       ; $10D4A2
        MOVE.B  -(A1),-(A1)                     ; $10D4A4
        BHI.S  loc_10D4CE                       ; $10D4A6
        MOVE.W  (A7)+,(A3)+                     ; $10D4A8
        MOVE.W  $1625.W,$62(A7,D2.W)            ; $10D4AA
        MOVE.L  $31(A2,D4.W),D2                 ; $10D4B0
        SUBQ.B  #6,$43(A2,D1.W)                 ; $10D4B4
        DC.W    $0AAA,$262A,$2121,$00F9; $10D4B8 EORI.L  #$262A2121,$00F9(A2)
        MOVE.W  D0,D6                           ; $10D4C0
        MOVE.W  (A2)+,D4                        ; $10D4C2
        OR.B   -$0C17(A1),D2                    ; $10D4C4
        MOVE.W  -(A1),$29(A7,A0.W)              ; $10D4C8
        MOVE.B  $52(A4,D4.W),D1                 ; $10D4CC
        DC.W    $4557               ; $10D4D0 DC.W    $4557
        SUBQ.B  #1,-$5A(A4,D6.W)                ; $10D4D2
        MOVE.B  D5,D2                           ; $10D4D6
        DC.W    $4105               ; $10D4D8 DC.W    $4105
        MOVE.B  -(A5),$6C29(A0)                 ; $10D4DA
        NOT    (A4)                             ; $10D4DE
        DC.W    $41BF               ; $10D4E0 DC.W    $41BF
        LEA     -$79(A1,A0.W),A2                ; $10D4E2
        MOVE.W  (A3)+,#$4422                    ; $10D4E6
        MOVEA.L $43(A6,A5.W),A2                 ; $10D4EA
        OR.W   (A3),D0                          ; $10D4EE
        MOVE.W  (A3),-(A0)                      ; $10D4F0
        MOVE.L  -(A1),-(A0)                     ; $10D4F2
        DC.W    $13BF,$DFFE         ; $10D4F4 MOVE.B  <EA:3F>,-$02(A1,A5.L)
        BLS.S  loc_10D50B                       ; $10D4F8
        MOVE.L  $62(A3,D3.W),-(A3)              ; $10D4FA
        DC.W    $4169               ; $10D4FE DC.W    $4169
        MOVE.L  (A6),$65(A2,D4.L)               ; $10D500
        MOVEA.B -(A3),A1                        ; $10D504
        MOVEA.B (A6),A3                         ; $10D506
        DC.W    $2FF4,$3561         ; $10D508 MOVE.L  $61(A4,D3.W),<EA:3F>
        SUB.B  D0,(A1)                          ; $10D50C
        MOVE.W  (A5)+,(A3)+                     ; $10D50E
        EOR.W  D0,-$14(A0,D3.W)                 ; $10D510
        SUBQ.W  #4,-(A2)                        ; $10D514
        DC.W    $13FF,$FD37,$6326   ; $10D516 MOVE.B  <EA:3F>,$FD376326
        BCC.S  loc_10D550                       ; $10D51C
        NEG.B  -(A1)                            ; $10D51E
        MOVEA.W -(A5),A2                        ; $10D520
        MOVEQ   #$7D,D2                         ; $10D522
        MOVE.W  D3,$4436(A0)                    ; $10D524
        SUBA.L  (A0),A0                         ; $10D528
        AND.B  D1,$19(A4,D7.W)                  ; $10D52A
        MOVEQ   #$73,D1                         ; $10D52E
        SUB.B  D0,(A2)                          ; $10D530
        MOVE.W  (A2)+,$3385(A0)                 ; $10D532
        MOVE.W  (A2),$4143(A7)                  ; $10D536
        TST.B  D4                               ; $10D53A
        BCC.S  loc_10D564                       ; $10D53C
        BLS.S  loc_10D552                       ; $10D53E
        MOVE.L  -$58(A4,D4.W),$3897(A3)         ; $10D540
        DIVS    -$4F(A1,A6.W),D5                ; $10D546
        SUB.L  $11(A4,D6.W),D7                  ; $10D54A
        BCC.S  loc_10D5A4                       ; $10D54E
loc_10D550:
        BSET    D2,-$40(A0,D2.W)                ; $10D550
        MOVE.W  (A6)+,D0                        ; $10D554
        AND.W  (A4)+,D4                         ; $10D556
        ADD.W  -(A2),D6                         ; $10D558
        ROXR.W  D2                              ; $10D55A
        ADDQ.B  #3,(A5)                         ; $10D55C
        ADDA.W  A4,A4                           ; $10D55E
        LSL.W  #4,D0                            ; $10D560
        DC.W    $0A26,$71F6         ; $10D562 EORI.B  #$71F6,-(A6)
        ROR.W  A4                               ; $10D566
        AND.B  D2,D2                            ; $10D568
        MOVE.L  (A1),D5                         ; $10D56A
        OR.L   D4,-$28(A1,A1.W)                 ; $10D56C
        MOVE.L  -(A2),-(A7)                     ; $10D570
        MOVE.L  -(A2),D0                        ; $10D572
        DC.W    $4105               ; $10D574 DC.W    $4105
        SUB.W  D6,-(A3)                         ; $10D576
        LEA     -$3E(A6,A2.L),A1                ; $10D578
        DC.W    $0024,$FE5A         ; $10D57C ORI.B  #$FE5A,-(A4)
        MOVE.L  #$06EB4423,-(A7)                ; $10D580
        DC.W    $34FF               ; $10D586 MOVE.W  <EA:3F>,(A2)+
        DC.W    $33F7,$1505,$F35A,$385F; $10D588 MOVE.W  $05(A7,D1.W),$F35A385F
        DIVS    D5,D0                           ; $10D590
        ADDA.W  A6,A5                           ; $10D592
        ROR.L  #5,D7                            ; $10D594
        SF      (A5)                            ; $10D596
        ADD.W  (A2)+,D1                         ; $10D598
        MOVE.L  -$36(A0,D5.L),D4                ; $10D59A
        MOVE.B  -(A0),(A6)                      ; $10D59E
        DC.W    $35FF,$F80E         ; $10D5A0 MOVE.W  <EA:3F>,-$07F2(PC)
loc_10D5A4:
        SUB.W  (A2)+,D6                         ; $10D5A4
        ADDI.W  #$431E,$34(PC,D7.W)             ; $10D5A6
        DC.W    $FBBE,$4144         ; $10D5AC MOVE.W  <EA:3E>,$44(A5,D4.W)
        DC.W    $0849,$4443         ; $10D5B0 BCHG    #3,A1
        MOVE.W  D3,D2                           ; $10D5B4
        NEGX.B $43(A6,A3.W)                     ; $10D5B6
        SUB.L  D4,(A0)+                         ; $10D5BA
        SUB.W  D6,D3                            ; $10D5BC
        BTST    D0,D2                           ; $10D5BE
        MOVE.B  (A3)+,-(A4)                     ; $10D5C0
        EOR.W  D3,-(A4)                         ; $10D5C2
        MOVEA.L -(A6),A1                        ; $10D5C4
        MOVE.W  D4,D7                           ; $10D5C6
        ADD.B  $44(A2,D3.W),D7                  ; $10D5C8
        SCS     -(A0)                           ; $10D5CC
        SCS     -(A1)                           ; $10D5CE
        SUBI.W  #$D8F2,D0                       ; $10D5D0
        MOVE.W  -(A0),$4955(A5)                 ; $10D5D4
        MOVE.W  -(A4),-$63(A3,D7.W)             ; $10D5D8
        MOVE.W  A0,D6                           ; $10D5DC
        MOVE.L  $F143.W,(A6)+                   ; $10D5DE
        SUBQ.L  #8,$15(A6,A2.L)                 ; $10D5E2
        MOVE.L  D7,(A5)+                        ; $10D5E6
        MOVE.B  (A1),D0                         ; $10D5E8
        MOVEQ   #-$04,D4                        ; $10D5EA
        DC.W    $00F9               ; $10D5EC DC.W    $00F9
        MOVE.W  $30(A4,A1.W),-(A4)              ; $10D5EE
        DC.W    $0CBC,$FD61,$C88C,$5912,$8633; $10D5F2 CMPI.L  #$FD61C88C,#$59128633
        DC.W    $2179,$346C,$58A0,$E5C0; $10D5FC MOVE.L  $346C58A0,-$1A40(A0)
        MOVE.W  $23(A3,A2.W),D2                 ; $10D604
        NEG.W  A3                               ; $10D608
        SUBQ.W  #8,(A0)                         ; $10D60A
        DIVS    A0,D2                           ; $10D60C
        DC.W    $4D51               ; $10D60E DC.W    $4D51
        MOVE.L  (A2),$7210(A2)                  ; $10D610
        EORI.W  #$59FB,(A4)+                    ; $10D614
        BTST    #20,(A0)                        ; $10D618
        SPL     $4550.W                         ; $10D61C
        SCS     -$39(A7,A7.L)                   ; $10D620
        SUBQ.L  #8,(A0)                         ; $10D624
        MOVE.W  D4,D2                           ; $10D626
        MOVE.L  $5100(A4),-(A4)                 ; $10D628
        MOVE.W  (A5),D6                         ; $10D62C
        LEA     -(A0),A4                        ; $10D62E
        MOVE.L  A0,-(A2)                        ; $10D630
        CMPA.W  D4,A6                           ; $10D632
        SUBQ.W  #1,(A4)                         ; $10D634
        MOVEM.W D1/D4/D5/A2/A5/A7,-(A6)         ; $10D636
        MOVE.W  $5A6B(A7),D2                    ; $10D63A
        BRA.S  loc_10D64B                       ; $10D63E
        SF      -(A0)                           ; $10D640
        DC.W    $06F1               ; $10D642 DC.W    $06F1
        MOVE.B  $1A6C(A0),$59(A1,D0.W)          ; $10D644
        ADDA.W  #$4A60,A4                       ; $10D64A
        DC.W    $0BC9               ; $10D64E BSET    D5,A1
        MOVEA.W (A1)+,A6                        ; $10D650
        MOVE.W  -$36(A3,A4.W),D1                ; $10D652
        SUB.W  -(A1),D6                         ; $10D656
        BSET    D0,-$66(A1,D3.W)                ; $10D658
        ASL.W  $6580(A0)                        ; $10D65C
        BSR.S  loc_10D6BA                       ; $10D660
        MULU    $44E14445,D1                    ; $10D662
        ADD.B  -$1EBB(A0),D4                    ; $10D668
        SCS     $69442076                       ; $10D66C
        ADD.B  D4,$FC68.W                       ; $10D672
        MOVE.W  D2,(A4)                         ; $10D676
        ADDQ.W  #3,(A6)                         ; $10D678
        MOVE.W  (A6),$6565(A5)                  ; $10D67A
        ADDQ.W  #2,-(A5)                        ; $10D67E
        DC.W    $0030,$66FB,$F4F3   ; $10D680 ORI.B  #$66FB,-$0D(A0,A7.W)
        DC.W    $4545               ; $10D686 DC.W    $4545
        DC.W    $00C0               ; $10D688 DC.W    $00C0
        MOVE.W  (A6)+,(A4)+                     ; $10D68A
        MOVE.W  (A6)+,(A4)+                     ; $10D68C
        DC.W    $4552               ; $10D68E DC.W    $4552
        ADDQ.W  #8,(A4)                         ; $10D690
        CMPA.W  -$29CC(A1),A1                   ; $10D692
        ADD.W  -$0EF6(A6),D0                    ; $10D696
        MOVE.W  D3,-(A0)                        ; $10D69A
        CMP.W  -(A7),D4                         ; $10D69C
        MOVE.W  -$09(A3,A6.W),-(A0)             ; $10D69E
        MOVE.W  (A1),$45(A2,D4.W)               ; $10D6A2
        ORI.W  #$7FF1,D2                        ; $10D6A6
        MOVE.W  -$0F(PC,A5.W),(A0)              ; $10D6AA
        MOVE.W  -(A3),D6                        ; $10D6AE
        DC.W    $00D0               ; $10D6B0 DC.W    $00D0
        MOVE.W  $F3F7D121,D4                    ; $10D6B2
        ADD.B  D4,D2                            ; $10D6B8
loc_10D6BA:
        MOVEQ   #$44,D3                         ; $10D6BA
        BTST    D7,-$0BB4(A1)                   ; $10D6BC
        MOVEA.L D0,A1                           ; $10D6C0
        MOVE.B  A6,D4                           ; $10D6C2
        OR.W   (A0)+,D4                         ; $10D6C4
        OR.W   -(A3),D6                         ; $10D6C6
        MOVEA.W (A7),A6                         ; $10D6C8
        MOVE.W  (A4),$74FC(A5)                  ; $10D6CA
        MOVE.W  D0,-$05(PC,D0.W)                ; $10D6CE
        BVS.S  loc_10D717                       ; $10D6D2
        MOVE.L  $40(A4,A2.L),-(A1)              ; $10D6D4
        LSL.W  D0,D0                            ; $10D6D8
        SUB.B  -(A3),D0                         ; $10D6DA
        MOVE.L  -(A1),(A7)                      ; $10D6DC
        MOVEA.W -(A5),A6                        ; $10D6DE
        DC.W    $4301               ; $10D6E0 DC.W    $4301
        ADDI.B  #$56AA,$43(A4,A1.L)             ; $10D6E2
        MOVE.W  -(A0),(A1)                      ; $10D6E8
        MOVEA.L (A0),A4                         ; $10D6EA
        CMP.W  (A4),D2                          ; $10D6EC
        DC.W    $0D8A               ; $10D6EE BCLR    D6,A2
        ADD.W  D4,(A5)                          ; $10D6F0
        ADD.W  (A7),D0                          ; $10D6F2
        MOVE.W  $0561(A3),-$7E(A7,A4.L)         ; $10D6F4
        MOVE.B  #$FBA4,-(A3)                    ; $10D6FA
        MOVE.W  A3,D4                           ; $10D6FE
        MOVE.W  -(A4),-(A1)                     ; $10D700
        DC.W    $4565               ; $10D702 DC.W    $4565
        MOVE.L  A6,$3AAF(A1)                    ; $10D704
        DC.W    $55FF               ; $10D708 SCS     <EA:3F>
        MOVE.L  (A0),D0                         ; $10D70A
        BCHG    D7,-$80(A7,A7.L)                ; $10D70C
        ADDQ.L  #4,$FB9C.W                      ; $10D710
        BVS.S  loc_10D6F8                       ; $10D714
        MOVE.W  A7,-$52DB(A2)                   ; $10D716
        OR.W   $6B4C(A6),D5                     ; $10D71A
        BLE.S  loc_10D717                       ; $10D71E
        ROXR.B  #1,D4                           ; $10D720
        ROXL.W  $45(PC,A6.W)                    ; $10D722
        DC.W    $0E11               ; $10D726 DC.W    $0E11
        DC.W    $4553               ; $10D728 DC.W    $4553
        MOVE.W  (A3),$5334(A4)                  ; $10D72A
        LEA     A7,A1                           ; $10D72E
        AND.B  D4,$53(A3,D7.W)                  ; $10D730
        LEA     (A6)+,A0                        ; $10D734
        MOVE.W  (A5),-$360F(A2)                 ; $10D736
        MOVE.W  (A5)+,$7524.W                   ; $10D73A
        DC.W    $00D9               ; $10D73E DC.W    $00D9
        ADDQ.B  #3,(A5)+                        ; $10D740
        MOVE.B  D5,-$16ED(A0)                   ; $10D742
        SUB.W  $3562(A1),D6                     ; $10D746
        MOVE.W  -(A3),-$549D(A5)                ; $10D74A
        MOVE.W  (A2),$5559(A3)                  ; $10D74E
        ADD.B  D5,(A6)                          ; $10D752
        BHI.S  loc_10D76E                       ; $10D754
        MOVE.W  $4956.W,-$04(A4,D1.W)           ; $10D756
        MOVE.L  -$76(A2,A6.W),$008C(A2)         ; $10D75C
        LEA     -(A5),A3                        ; $10D762
        DC.W    $4752               ; $10D764 DC.W    $4752
        MOVE.W  A6,-$5D5F(A4)                   ; $10D766
        MOVE.L  (A3),D1                         ; $10D76A
        MOVEA.W -$0B(A1,A7.L),A4                ; $10D76C
        BCLR    D5,D0                           ; $10D770
        SUBQ.B  #8,-(A1)                        ; $10D772
        MOVE.W  A4,$47D0(A7)                    ; $10D774
        MOVE.W  $4800(A0),$40FC.W               ; $10D778
        ROXL.W  $48(A0,D3.L)                    ; $10D77E
        SUBQ.B  #2,$16(A7,A4.W)                 ; $10D782
        DC.W    $A3F0,$0C22,$A998,$6EEE; $10D786 MOVE.L  $22(A0,D0.L),$A9986EEE
        MOVEA.B D1,A2                           ; $10D78E
        MOVE.B  -(A6),$FD85.W                   ; $10D790
        MOVE.L  $51(A5,A7.L),(A6)+              ; $10D794
        MOVE.B  (A3),$42F4(A1)                  ; $10D798
        ROXL.B  D4,D2                           ; $10D79C
        SUBA.L  -$0003(A3),A5                   ; $10D79E
        OR.B   D2,(A3)                          ; $10D7A2
        MOVE.L  -(A0),$12(A1,D3.W)              ; $10D7A4
        MOVE.B  A3,$1052F9B4                    ; $10D7A8
        MOVE.L  (A2),-$7FB2(PC)                 ; $10D7AE
        SUB.W  D0,-(A4)                         ; $10D7B2
        SNE     D3                              ; $10D7B4
        MOVE.L  (A5),-(A0)                      ; $10D7B6
        MOVE.W  $0AF1(A2),(A6)                  ; $10D7B8
        MOVEQ   #$09,D0                         ; $10D7BC
        MOVE.B  (A1),(A4)                       ; $10D7BE
        MOVE.W  $53(A3,D4.W),D6                 ; $10D7C0
        MOVE.L  (A3)+,(A3)+                     ; $10D7C4
        DIVS    $0B51.W,D0                      ; $10D7C6
        CLR    $58D8(A0)                        ; $10D7CA
        MOVE.W  A5,-$2066(A2)                   ; $10D7CE
        BPL.S  loc_10D784                       ; $10D7D2
        ROR.B  #4,D0                            ; $10D7D4
        MOVE.L  A2,D4                           ; $10D7D6
        NEG.W  D4                               ; $10D7D8
        ROR.W  D1,D1                            ; $10D7DA
        DC.W    $482E               ; $10D7DC DC.W    $482E
        DC.W    $193F               ; $10D7DE MOVE.B  <EA:3F>,-(A4)
        SVS     #$F145                          ; $10D7E0
        NEG.B  -(A2)                            ; $10D7E4
        SUB.L  (A7),D1                          ; $10D7E6
        ASR.W  $0F84(A0)                        ; $10D7E8
        EOR.B  D2,-(A6)                         ; $10D7EC
        ADD.L  (A0)+,D4                         ; $10D7EE
        SUBQ.W  #5,(A1)+                        ; $10D7F0
        MOVEQ   #$44,D6                         ; $10D7F2
        ASR.W  $0FFF.W                          ; $10D7F4
        MOVE.W  D1,-$4C(A6,A1.W)                ; $10D7F8
        MOVE.L  $C0F80985,(A4)+                 ; $10D7FC
        DC.W    $ABE9,$5C45         ; $10D802 MOVE.L  $5C45(A1),<EA:3D>
        ADDQ.B  #1,-$75BC(A2)                   ; $10D806
        ADDQ.L  #1,A2                           ; $10D80A
        OR.W   -$3D(PC,D6.W),D5                 ; $10D80C
        MOVE.W  (A3),D4                         ; $10D810
        AND.W  D5,$6263(A1)                     ; $10D812
        AND.B  A5,D2                            ; $10D816
        MOVE.B  $47(A3,A7.W),-(A1)              ; $10D818
        MOVE.W  (A0)+,(A6)                      ; $10D81C
        MOVE.L  D0,(A4)+                        ; $10D81E
        DIVU    $A3F1.W,D2                      ; $10D820
        MOVE.W  $8411.W,$5474.W                 ; $10D824
        MOVE.W  $0B(A1,A7.L),-$4C(PC,D2.L)      ; $10D82A
        OR.B   (A4),D5                          ; $10D830
        SUBQ.W  #4,$3D(PC,A6.L)                 ; $10D832
        OR.W   D0,(A7)                          ; $10D836
        MOVE.W  D2,$5A(A4,D4.W)                 ; $10D838
        CMPA.L  -$556D(A6),A2                   ; $10D83C
        SUB.L  D0,-$403A(A3)                    ; $10D840
        EOR.W  D6,D4                            ; $10D844
        DC.W    $4BBB               ; $10D846 DC.W    $4BBB
        CMPA.L  (A4),A6                         ; $10D848
        MOVE.L  D3,$59FF(A5)                    ; $10D84A
        MOVE.W  (A2)+,D4                        ; $10D84E
        DC.W    $ABFC,$D9D6,$5325   ; $10D850 MOVE.L  #$D9D65325,<EA:3D>
        MOVE.W  -(A7),D6                        ; $10D856
        MOVE.W  -$47(A7,D5.W),$7536(A4)         ; $10D858
        SUBQ.L  #8,-(A7)                        ; $10D85E
        OR.B   (A0)+,D1                         ; $10D860
        ADDQ.W  #5,$74(A4,A7.L)                 ; $10D862
        MOVE.L  -(A4),D3                        ; $10D866
        ADDQ.L  #1,D1                           ; $10D868
        CLR    $12AB(A7)                        ; $10D86A
        DC.W    $022C,$2144,$9939   ; $10D86E ANDI.B  #$2144,-$66C7(A4)
        ADDA.L  $31(A1,A7.W),A6                 ; $10D874
        MOVE.B  -$0760(PC),(A2)                 ; $10D878
        DC.W    $ABD2               ; $10D87C MOVE.L  (A2),<EA:3D>
        MOVE.W  (A2),$2174(A4)                  ; $10D87E
        LEA     $3A86(A2),A3                    ; $10D882
        MOVE.L  $0ADF(A2),$15(A0,D6.L)          ; $10D886
        MULS    -$458F(A3),D0                   ; $10D88C
        CMPA.W  $6D21(A3),A4                    ; $10D890
        MOVE.B  -(A0),D2                        ; $10D894
        BSET    D5,$1AA0(A5)                    ; $10D896
        MOVE.L  (A2)+,D2                        ; $10D89A
        MOVE.W  D0,(A2)                         ; $10D89C
        DC.W    $91FF               ; $10D89E SUBA.L  <EA:3F>,A0
        MOVE.W  $1F(A2,A7.W),#$A9C8             ; $10D8A0
        MOVE.W  D0,(A5)+                        ; $10D8A6
        ASL.W  -(A3)                            ; $10D8A8
        ADD.B  A7,D0                            ; $10D8AA
        OR.B   D2,-(A2)                         ; $10D8AC
        ADD.W  D0,(A0)+                         ; $10D8AE
        DBCS    D4,$10B3F4                      ; $10D8B0
        BRA.S  loc_10D84D                       ; $10D8B4
        BGE.S  loc_10D8E2                       ; $10D8B6
        EOR.W  D5,D2                            ; $10D8B8
        CLR.L  $CDBA1955                        ; $10D8BA
        BTST    D3,-$11(A6,A6.W)                ; $10D8C0
        MOVE.L  A1,-$67E0(PC)                   ; $10D8C4
        MOVEA.B D0,A2                           ; $10D8C8
        LSR.B  #4,D1                            ; $10D8CA
        NEG.B  -(A1)                            ; $10D8CC
        MOVEA.L -$17(A3,D4.W),A4                ; $10D8CE
        MOVEA.L (A4),A4                         ; $10D8D2
        ADDQ.W  #4,D1                           ; $10D8D4
        MOVE.W  D0,-$107F(A3)                   ; $10D8D6
        SMI     -$0B(A1,D5.W)                   ; $10D8DA
        MOVEA.W D3,A7                           ; $10D8DE
        MOVEA.W (A5),A1                         ; $10D8E0
loc_10D8E2:
        DC.W    $2B3E               ; $10D8E2 MOVE.L  <EA:3E>,-(A5)
        ROL.B  #5,D3                            ; $10D8E4
        OR.B   D0,A7                            ; $10D8E6
        MOVEQ   #-$7E,D5                        ; $10D8E8
        BLT.S  loc_10D943                       ; $10D8EA
        MOVE.W  $5D(A1,A2.L),D1                 ; $10D8EC
        ROL.B  D5,D3                            ; $10D8F0
        MOVEA.B D5,A3                           ; $10D8F2
        ROXL.B  D7,D1                           ; $10D8F4
        MOVE.L  -$21(A1,A7.L),D6                ; $10D8F6
        MOVE.W  -(A6),#$4010                    ; $10D8FA
        MOVE.W  A1,-$7D(PC,A7.L)                ; $10D8FE
        LSL.W  #4,D0                            ; $10D902
        MOVE.L  $71(A6,A4.L),$7948(PC)          ; $10D904
        SHI     $E9C15556                       ; $10D90A
        MOVEA.B -$1416(A2),A6                   ; $10D910
        AND.W  D4,$3A(PC,D2.W)                  ; $10D914
        ADD.B  D6,$05(A5,A6.L)                  ; $10D918
        MOVEA.B (A4),A1                         ; $10D91C
        LEA     #$A77149EA,A0                   ; $10D91E
        MOVE.W  A5,D4                           ; $10D924
        ROL.W  $FCAD16A5                        ; $10D926
        ADD.L  -$1A78(A1),D2                    ; $10D92C
        DC.W    $3D79,$7FBA,$00D2,$33E3; $10D930 MOVE.W  $7FBA00D2,$33E3(A6)
        AND.B  D0,D1                            ; $10D938
        DC.W    $3DF6,$96F9         ; $10D93A MOVE.W  -$07(A6,A1.W),<EA:3E>
        CMPA.L  -$7ECD(A1),A2                   ; $10D93E
        OR.B   A3,D4                            ; $10D942
        MOVEA.L #$543A7BF9,A4                   ; $10D944
        MOVEA.B (A1)+,A5                        ; $10D94A
        OR.L   $5C7A(PC),D4                     ; $10D94C
        OR.L   D0,-(A4)                         ; $10D950
        DC.W    $04EA               ; $10D952 DC.W    $04EA
        MULS    -(A1),D0                        ; $10D954
        OR.B   (A1),D4                          ; $10D956
        MOVE.B  A0,-(A0)                        ; $10D958
        BSR.S  loc_10D945                       ; $10D95A
        MOVE.B  -$50(A3,A6.W),$1080(PC)         ; $10D95C
        MOVE.W  (A5)+,-$25(A3,A2.L)             ; $10D962
        MOVE.L  -(A0),(A6)+                     ; $10D966
        DC.W    $E1FF               ; $10D968 ASL.W  <EA:3F>
        MOVE.W  A7,D4                           ; $10D96A
        OR.B   D3,-$07(A5,A5.L)                 ; $10D96C
        DC.W    $FC77,$766B         ; $10D970 MOVEA.W $6B(A7,D7.W),A6
        NEG.W  $47(A1,A6.L)                     ; $10D974
        MOVE.W  $7784(A1),$9969.W               ; $10D978
        MOVE.W  -$0E1E(A5),-(A2)                ; $10D97E
        CLR.W  $07(A5,A2.L)                     ; $10D982
        ADD.W  D1,D1                            ; $10D986
        SCC     $5ADB(A5)                       ; $10D988
        ADD.W  D4,#$EABB                        ; $10D98C
        ADDA.L  (A5)+,A6                        ; $10D990
        MOVE.W  $4123(A5),(A6)                  ; $10D992
        MOVE.W  (A1),-(A4)                      ; $10D996
        DC.W    $81BD               ; $10D998 OR.L   D0,<EA:3D>
        DC.W    $4B89               ; $10D99A DC.W    $4B89
        SUB.W  -$5403(PC),D7                    ; $10D99C
        MOVEA.B (A2)+,A6                        ; $10D9A0
        DIVU    (A1)+,D0                        ; $10D9A2
        MOVE.W  -$542C(A5),#$FC88               ; $10D9A4
        SUB.B  D4,D0                            ; $10D9AA
        EOR.L  D0,-$0720(A2)                    ; $10D9AC
        CMPA.L  #$DBD52E44,A6                   ; $10D9B0
        DIVS    (A2)+,D4                        ; $10D9B6
        BGT.S  loc_10D94B                       ; $10D9B8
        DC.W    $4B79               ; $10D9BA DC.W    $4B79
        AND.W  $18(A1,D5.W),D7                  ; $10D9BC
        DIVS    (A4),D0                         ; $10D9C0
        LEA     A0,A5                           ; $10D9C2
        SUBQ.L  #8,D0                           ; $10D9C4
        DIVU    -$77(A3,A7.L),D5                ; $10D9C6
        DIVS    D1,D0                           ; $10D9CA
        BSR.S  loc_10D9A6                       ; $10D9CC
        MOVEQ   #$61,D1                         ; $10D9CE
        DC.W    $EBFE               ; $10D9D0 LSL.W  <EA:3E>
        ADDA.L  $54(A0,D2.W),A5                 ; $10D9D2
        DC.W    $4769               ; $10D9D6 DC.W    $4769
        SUBQ.L  #3,(A0)+                        ; $10D9D8
        MOVE.W  (A1)+,#$51B5                    ; $10D9DA
        OR.L   A0,D5                            ; $10D9DE
        EOR.W  D2,D5                            ; $10D9E0
        MOVE.W  $79DC.W,-(A4)                   ; $10D9E2
        EOR.B  D0,D0                            ; $10D9E6
        BSET    D0,(A4)                         ; $10D9E8
        CMP.L  -$551A(A4),D4                    ; $10D9EA
        AND.W  -(A1),D1                         ; $10D9EE
        SUB.L  D3,-(A5)                         ; $10D9F0
        MOVE.W  $33(PC,D5.W),(A6)               ; $10D9F2
        MOVE.W  (A3)+,(A1)+                     ; $10D9F6
        DC.W    $4328               ; $10D9F8 DC.W    $4328
        MOVE.L  (A4),(A0)                       ; $10D9FA
        ADD.W  D6,-(A2)                         ; $10D9FC
        SUBA.L  $04(PC,D6.L),A0                 ; $10D9FE
        MOVE.B  -$6E(A7,A5.L),$06DA(PC)         ; $10DA02
        MOVE.L  D2,-$4BBF(PC)                   ; $10DA08
        BSR.W  loc_10D706                       ; $10DA0C
        EOR.L  D1,-$5D(A3,A7.L)                 ; $10DA10
        BCHG    D1,(A6)                         ; $10DA14
        MOVEQ   #$79,D6                         ; $10DA16
        EOR.L  D6,A6                            ; $10DA18
        ADDA.W  (A4),A5                         ; $10DA1A
        DC.W    $FBD1               ; $10DA1C MOVE.W  (A1),<EA:3D>
        MOVE.L  -$1300(A1),D6                   ; $10DA1E
        MOVE.W  (A1),$EFD4740E                  ; $10DA22
        ASL.W  #4,D7                            ; $10DA28
        SF      -$76(A7,A2.L)                   ; $10DA2A
        MOVEA.W A7,A4                           ; $10DA2E
        MOVE.W  D0,D5                           ; $10DA30
        ROXL.W  #4,D6                           ; $10DA32
        ROXL.L  #5,D3                           ; $10DA34
        DC.W    $0B0F               ; $10DA36 BTST    D5,A7
        ROXL.W  D7,D4                           ; $10DA38
        MOVE.W  A0,-(A5)                        ; $10DA3A
        CMPA.L  (A1),A2                         ; $10DA3C
        DC.W    $FFFA,$21F3         ; $10DA3E MOVE.W  $21F3(PC),<EA:3F>
        CMP.W  -(A6),D1                         ; $10DA42
        MOVE.W  -$3A(A1,A4.W),$53F1(A0)         ; $10DA44
        MOVEQ   #$48,D1                         ; $10DA4A
        LSR.W  -$43(A1,D7.W)                    ; $10DA4C
        ROXL.W  D4,D7                           ; $10DA50
        MOVE.W  (A5),$5577(A1)                  ; $10DA52
        DC.W    $73F5,$C164,$C4BE,$C175; $10DA56 MOVE.W  $64(A5,A4.W),$C4BEC175
        MOVE.B  $41(A3,A3.L),-$167E(A0)         ; $10DA5E
        BVS.S  loc_10DABB                       ; $10DA64
        ADD.B  D2,(A0)                          ; $10DA66
        MOVE.B  A0,D5                           ; $10DA68
        MOVE.B  $0B(A0,D0.L),(A5)+              ; $10DA6A
        BEQ.S  loc_10DA12                       ; $10DA6E
        BCLR    D0,$C8C5706A                    ; $10DA70
        OR.W   -(A3),D0                         ; $10DA76
        MOVE.W  D4,$27(A2,D5.W)                 ; $10DA78
        ADDQ.W  #7,$41E1(A1)                    ; $10DA7C
        DC.W    $21FC,$71FC,$BF80,$5277; $10DA80 MOVE.L  #$71FCBF80,$5277.W
        MOVE.B  (A7),-(A3)                      ; $10DA88
        ADDQ.W  #1,$56(A1,D7.W)                 ; $10DA8A
        ADDA.L  #$5552FF17,A0                   ; $10DA8E
        DC.W    $7DE4               ; $10DA94 MOVE.W  -(A4),<EA:3E>
        DC.W    $077E               ; $10DA96 BCHG    D3,<EA:3E>
        MOVE.B  $095E.W,D6                      ; $10DA98
        MOVE.W  A3,#$2FE1                       ; $10DA9C
        BCC.S  loc_10DAB2                       ; $10DAA0
        MOVE.W  #$D800,$62A1(PC)                ; $10DAA2
        BPL.S  loc_10DAC8                       ; $10DAA8
        MOVE.W  (A5),-(A4)                      ; $10DAAA
        MOVE.W  A1,$4D9A(A0)                    ; $10DAAC
        OR.L   -$7A2E(PC),D0                    ; $10DAB0
        MOVE.W  (A0),-$4B67(A1)                 ; $10DAB4
        ROXR.W  #8,D1                           ; $10DAB8
        CMPA.L  -$064C(A1),A7                   ; $10DABA
        ROXR.B  D5,D5                           ; $10DABE
        SUBQ.W  #2,(A5)                         ; $10DAC0
        MOVE.B  $55B5(A5),#$E92C                ; $10DAC2
loc_10DAC8:
        LSR.W  -$4D(A1,A7.W)                    ; $10DAC8
        LSL.L  D4,D5                            ; $10DACC
        ROL.W  D4,D0                            ; $10DACE
        SF      (A2)                            ; $10DAD0
        ROXR.W  #1,D5                           ; $10DAD2
        SUBQ.B  #2,$2F1A(PC)                    ; $10DAD4
        LSR.B  D5,D1                            ; $10DAD8
        MOVE.L  A1,-$2BCA(A5)                   ; $10DADA
        MOVE.L  $23C8(A7),-$1CFA(A5)            ; $10DADE
        MOVE.B  A5,-$74(A4,A2.L)                ; $10DAE4
        MOVE.W  $23(A2,D5.W),D6                 ; $10DAE8
        ADD.B  D4,A4                            ; $10DAEC
        ADD.W  D5,D7                            ; $10DAEE
        BCLR    D6,-$1CF6(A6)                   ; $10DAF0
        MOVE.L  $0DBC(PC),D1                    ; $10DAF4
        ROXR.W  (A0)+                           ; $10DAF8
        MOVE.B  (A6),$29E9AC91                  ; $10DAFA
        DIVU    (A7),D5                         ; $10DB00
        EOR.B  D7,(A4)                          ; $10DB02
        MOVE.L  #$E7E3E141,(A1)                 ; $10DB04
        CLR    -(A4)                            ; $10DB0A
        MOVE.W  $1841(A5),-$67(A0,A3.W)         ; $10DB0C
        SUBQ.B  #2,A1                           ; $10DB12
        MULU    -(A3),D2                        ; $10DB14
        MOVE.L  -(A0),(A0)+                     ; $10DB16
        MOVE.B  D0,D4                           ; $10DB18
        ADDA.W  -$4F(A6,A4.L),A3                ; $10DB1A
loc_10DB1E:
        MULU    -(A4),D5                        ; $10DB1E
        BLS.S  loc_10DB1E                       ; $10DB20
        MOVEQ   #$38,D2                         ; $10DB22
        MOVE.W  -(A3),D5                        ; $10DB24
        AND.B  D2,-(A3)                         ; $10DB26
        OR.L   D7,D4                            ; $10DB28
        NEG.W  $5B44(A6)                        ; $10DB2A
        MOVE.L  A1,-$78(PC,D4.W)                ; $10DB2E
        NEGX   (A1)+                            ; $10DB32
        OR.B   D3,-$16E9(A1)                    ; $10DB34
        MOVE.B  D1,(A0)+                        ; $10DB38
        OR.L   $6ADD(A5),D2                     ; $10DB3A
        MOVE.W  (A7)+,-(A6)                     ; $10DB3E
        DC.W    $4B20               ; $10DB40 DC.W    $4B20
        ROL.B  #4,D3                            ; $10DB42
        MOVE.L  (A0)+,$79BA(A0)                 ; $10DB44
        DC.W    $1BC3               ; $10DB48 MOVE.B  D3,<EA:3D>
        BSR.S  loc_10DB67                       ; $10DB4A
        MOVE.L  -(A1),$08(A5,A2.L)              ; $10DB4C
        DC.W    $AFF8,$A1F8         ; $10DB50 MOVE.L  $A1F8.W,<EA:3F>
        MOVE.L  -(A1),(A5)                      ; $10DB54
        MOVE.L  (A1),-(A0)                      ; $10DB56
        AND.W  $3038(A1),D0                     ; $10DB58
        SUB.W  D1,-(A4)                         ; $10DB5C
        MOVE.W  (A2)+,D0                        ; $10DB5E
        DC.W    $ABE0               ; $10DB60 MOVE.L  -(A0),<EA:3D>
        DC.W    $13EA,$1ABA,$E000,$E0FC; $10DB62 MOVE.B  $1ABA(A2),$E000E0FC
        MOVE.B  (A2)+,D5                        ; $10DB6A
        ASR.W  #6,D2                            ; $10DB6C
        ADD.L  D0,(A7)                          ; $10DB6E
        DC.W    $4D61               ; $10DB70 DC.W    $4D61
        ROXL.B  #5,D1                           ; $10DB72
        AND.W  D5,$F63F6110                     ; $10DB74
        AND.B  (A1),D3                          ; $10DB7A
        ROL.L  D4,D2                            ; $10DB7C
        ROL.B  #5,D2                            ; $10DB7E
        DC.W    $B17D               ; $10DB80 EOR.W  D0,<EA:3D>
        DC.W    $4508               ; $10DB82 DC.W    $4508
        EOR.B  D0,(A2)+                         ; $10DB84
        MOVEA.W -$2316(A1),A7                   ; $10DB86
        MOVE.B  D0,-(A0)                        ; $10DB8A
        BCLR    #22,-(A4)                       ; $10DB8C
        ADD.B  -$3E(A0,D0.W),D1                 ; $10DB90
        ROR.B  #2,D3                            ; $10DB94
        MOVE.W  (A5),(A7)+                      ; $10DB96
        MOVE.W  A4,D6                           ; $10DB98
        BSET    D1,-$5412(A6)                   ; $10DB9A
        LSL.L  D0,D7                            ; $10DB9E
        DC.W    $FFE0               ; $10DBA0 MOVE.W  -(A0),<EA:3F>
        DC.W    $DEFE               ; $10DBA2 ADDA.W  <EA:3E>,A7
        SUB.L  -$4E4F(A2),D7                    ; $10DBA4
        ADDA.W  -(A1),A5                        ; $10DBA8
        ADD.B  (A5),D2                          ; $10DBAA
        MOVE.W  (A3)+,$EEEB.W                   ; $10DBAC
        ADD.L  D5,$2F(PC,D2.L)                  ; $10DBB0
        ROR.W  -$0315(A6)                       ; $10DBB4
        MOVE.W  -$1107(A3),(A6)+                ; $10DBB8
        ASL.L  #8,D0                            ; $10DBBC
        MOVE.B  $34(A7,A7.L),(A3)+              ; $10DBBE
        ASL.W  #$FCD4                           ; $10DBC2
        MOVE.W  -$0D08(A1),(A0)+                ; $10DBC6
        MOVE.W  (A6)+,(A6)+                     ; $10DBCA
        MOVE.W  (A3)+,(A6)+                     ; $10DBCC
        ADDA.W  #$BDDE,A2                       ; $10DBCE
        ROXR.B  D7,D5                           ; $10DBD2
        CMPA.W  (A5)+,A5                        ; $10DBD4
        CMPA.L  -$1648(A5),A6                   ; $10DBD6
        ADD.B  -$08(A1,A7.L),D1                 ; $10DBDA
        AND.W  D4,-$4E(A1,D7.W)                 ; $10DBDE
        MOVE.L  A5,(A5)+                        ; $10DBE2
        ROXR.W  D4                              ; $10DBE4
        DC.W    $EBFF               ; $10DBE6 LSL.W  <EA:3F>
        OR.B   (A7),D5                          ; $10DBE8
        SUB.B  $118A(A5),D4                     ; $10DBEA
        MOVE.B  -(A2),-(A1)                     ; $10DBEE
        MOVEQ   #$0F,D3                         ; $10DBF0
        BEQ.S  loc_10DBA5                       ; $10DBF2
        MOVE.L  A2,D4                           ; $10DBF4
        SUBQ.W  #2,$13(A7,A6.L)                 ; $10DBF6
        MOVE.B  (A4)+,-(A0)                     ; $10DBFA
        ROXR.W  #5,D1                           ; $10DBFC
        MOVE.L  (A1),D1                         ; $10DBFE
        MOVE.W  D0,$12(A7,A6.L)                 ; $10DC00
        MOVE.B  -(A2),-(A2)                     ; $10DC04
        SUBQ.B  #2,-(A1)                        ; $10DC06
        MOVE.L  (A2),$22F3(A0)                  ; $10DC08
        ST      (A5)                            ; $10DC0C
        MOVE.W  $27(A0,D5.W),$EA3C.W            ; $10DC0E
        MOVE.W  A5,-(A0)                        ; $10DC14
        MOVE.L  D6,(A1)+                        ; $10DC16
        SUBQ.L  #8,A4                           ; $10DC18
        ADDQ.W  #1,(A6)                         ; $10DC1A
        SUBQ.W  #2,(A5)                         ; $10DC1C
        MOVE.W  -(A2),-$12(A6,D5.W)             ; $10DC1E
        LSL.W  D0,D0                            ; $10DC22
        MOVE.B  (A5),D2                         ; $10DC24
        DC.W    $F5FF,$F811         ; $10DC26 MOVE.W  <EA:3F>,-$07EF(PC)
        MOVE.W  -$1F(PC,A7.L),(A2)              ; $10DC2A
        DC.W    $4551               ; $10DC2E DC.W    $4551
        NEGX.B (A0)                             ; $10DC30
        MOVE.B  (A4),$E18D88A1                  ; $10DC32
        MOVE.W  (A6),(A4)                       ; $10DC38
        ASR.B  #5,D0                            ; $10DC3A
        SUBQ.L  #2,(A0)                         ; $10DC3C
        LSR.L  D4,D0                            ; $10DC3E
        TST.B  $0F(A3,D5.W)                     ; $10DC40
        ADDQ.L  #2,-$2D0B(A0)                   ; $10DC44
        SUBQ.L  #2,(A2)+                        ; $10DC48
        MULU    $280D(A0),D2                    ; $10DC4A
        SUB.W  -(A2),D5                         ; $10DC4E
        DC.W    $4144               ; $10DC50 DC.W    $4144
        MOVEA.B (A4),A2                         ; $10DC52
        SUBA.L  A1,A1                           ; $10DC54
        DC.W    $0A23,$5039         ; $10DC56 EORI.B  #$5039,-(A3)
        SUBI.B  #$E86C,A0                       ; $10DC5A
        BRA.S  loc_10DCD7                       ; $10DC5E
        ADD.W  (A3)+,D0                         ; $10DC60
        AND.B  A0,D0                            ; $10DC62
        MOVE.B  D2,(A2)                         ; $10DC64
        AND.W  D4,D1                            ; $10DC66
        MOVE.B  (A4),-(A3)                      ; $10DC68
        MOVE.W  -(A2),(A7)+                     ; $10DC6A
        LEA     -$0ED7(PC),A3                   ; $10DC6C
        MOVEA.L A3,A5                           ; $10DC70
        AND.B  D5,(A0)                          ; $10DC72
        MOVE.B  -$34D6(PC),$3919(A1)            ; $10DC74
        MOVE.B  D5,D4                           ; $10DC7A
        MOVE.W  A4,(A3)                         ; $10DC7C
        ROXL.W  D4,D5                           ; $10DC7E
        MOVE.W  (A3),-$04(A5,A4.W)              ; $10DC80
        ADD.L  D2,-$3CBE(A7)                    ; $10DC84
        DC.W    $7FE1               ; $10DC88 MOVE.W  -(A1),<EA:3F>
        OR.L   -$1B(A2,D5.L),D4                 ; $10DC8A
        MOVEA.L (A2),A1                         ; $10DC8E
        MOVE.W  (A5),$1259(A0)                  ; $10DC90
        ASL.B  #4,D2                            ; $10DC94
        MOVE.L  -$28(A2,A4.W),(A5)              ; $10DC96
        MOVEA.W -$5F(A1,A6.L),A1                ; $10DC9A
        ADD.W  D4,D0                            ; $10DC9E
        ROXR.W  #6,D6                           ; $10DCA0
        SNE     -$0E50(PC)                      ; $10DCA2
        DC.W    $4915               ; $10DCA6 DC.W    $4915
        AND.L  -$27(PC,A3.W),D4                 ; $10DCA8
        MOVE.W  (A4),-(A7)                      ; $10DCAC
        MOVE.L  (A7),-$27(A4,D3.L)              ; $10DCAE
        EOR.L  D6,(A0)+                         ; $10DCB2
        MOVE.W  -$5F3E(A3),#$5BA5               ; $10DCB4
        SHI     -$4C(A1,A2.L)                   ; $10DCBA
        NEG.W  (A7)                             ; $10DCBE
        ADD.B  D2,-(A0)                         ; $10DCC0
        MOVE.W  A5,-$2445(A0)                   ; $10DCC2
        DIVU    -$0B(A7,D7.L),D0                ; $10DCC6
        MOVE.W  -$7334(A2),(A2)+                ; $10DCCA
        MOVE.W  -$20(A4,D0.W),(A2)              ; $10DCCE
        MOVE.B  $5514(A3),(A7)                  ; $10DCD2
        CMP.L  -$729E(A3),D5                    ; $10DCD6
        MOVEQ   #$61,D6                         ; $10DCDA
        CMP.W  -(A1),D0                         ; $10DCDC
        AND.B  D5,(A3)                          ; $10DCDE
        DC.W    $527F               ; $10DCE0 ADDQ.W  #1,<EA:3F>
        BHI.S  loc_10DCC8                       ; $10DCE2
        DC.W    $3BF0,$FFF3         ; $10DCE4 MOVE.W  -$0D(A0,A7.L),<EA:3D>
        MOVEA.W $BCAABA1F,A3                    ; $10DCE8
        MOVE.L  -(A1),(A5)                      ; $10DCEE
        DC.W    $F1FE,$FEA1         ; $10DCF0 MOVE.W  <EA:3E>,$FEA1.W
        MOVE.W  D7,-$12(A7,A7.L)                ; $10DCF4
        LSR.L  D5,D2                            ; $10DCF8
        DC.W    $AFFF               ; $10DCFA MOVE.L  <EA:3F>,<EA:3F>
        MOVE.W  $1FFB(A3),(A5)                  ; $10DCFC
        EOR.L  D5,-(A1)                         ; $10DD00
        MOVE.W  -$46(A0,A7.L),-(A6)             ; $10DD02
        MOVE.W  -$04(PC,A7.L),(A0)              ; $10DD06
        MOVE.L  -$5E02(A7),$21(A7,A3.L)         ; $10DD0A
        DC.W    $C0BF               ; $10DD10 AND.L  <EA:3F>,D0
        DC.W    $FFE9,$AFFE         ; $10DD12 MOVE.W  -$5002(A1),<EA:3F>
        MOVE.W  -$1E21(PC),-$02(A0,A2.L)        ; $10DD16
        ADD.L  -$5111(A2),D6                    ; $10DD1C
        MOVE.L  (A2)+,D5                        ; $10DD20
        MOVE.L  -$4EA0(A7),(A5)+                ; $10DD22
        ROL.B  D4,D7                            ; $10DD26
        DC.W    $E0FF               ; $10DD28 ASR.W  <EA:3F>
        MOVE.B  (A2)+,-(A0)                     ; $10DD2A
        DC.W    $1AFF               ; $10DD2C MOVE.B  <EA:3F>,(A5)+
        ROXL.B  #7,D1                           ; $10DD2E
        LSR.W  $0E(A7,A3.L)                     ; $10DD30
        MOVE.L  $27E9(A7),$FFA1.W               ; $10DD34
        MOVE.W  (A7)+,-(A3)                     ; $10DD3A
        DC.W    $FBFF               ; $10DD3C MOVE.W  <EA:3F>,<EA:3D>
        MOVEA.B -(A2),A6                        ; $10DD3E
        ROR.W  -$4005(PC)                       ; $10DD40
        LSR.L  D7,D7                            ; $10DD44
        MULU    (A4),D3                         ; $10DD46
        MOVEA.B $45(A1,D2.W),A4                 ; $10DD48
        ADD.B  D2,-(A2)                         ; $10DD4C
        MOVEA.W (A4),A6                         ; $10DD4E
        ADD.L  D5,D5                            ; $10DD50
        ADDQ.L  #7,-$04(A2,A5.W)                ; $10DD52
        MOVE.W  -$09(A4,A3.L),(A6)+             ; $10DD56
        LEA     -$2443(A3),A4                   ; $10DD5A
        MOVE.W  #$ACAA,$57(A0,A7.L)             ; $10DD5E
        DC.W    $FCFD               ; $10DD64 MOVE.W  <EA:3D>,(A6)+
        SUB.B  D1,$1E38(A0)                     ; $10DD66
        ADD.L  D5,D6                            ; $10DD6A
        LSR.W  -$02D6(A5)                       ; $10DD6C
        MOVE.L  A6,-$07(A4,A5.L)                ; $10DD70
        MOVE.W  $10(A6,D3.L),(A1)               ; $10DD74
        MOVE.W  #$2B42,(A1)+                    ; $10DD78
        BCC.S  loc_10DD68                       ; $10DD7C
        ADDQ.L  #2,$7DDD(A5)                    ; $10DD7E
        MOVE.W  (A7),-$1B4E(A7)                 ; $10DD82
        DC.W    $FDE9,$49F1         ; $10DD86 MOVE.W  $49F1(A1),<EA:3E>
        DC.W    $4784               ; $10DD8A DC.W    $4784
        MOVE.W  A2,$1A(A0,A0.W)                 ; $10DD8C
        ADDA.L  $5755(PC),A4                    ; $10DD90
        DC.W    $D2FD               ; $10DD94 ADDA.W  <EA:3D>,A1
        BVC.S  loc_10DD39                       ; $10DD96
        MOVE.W  A6,-(A4)                        ; $10DD98
        MOVE.B  -(A0),$2014(A2)                 ; $10DD9A
        DC.W    $FFFF               ; $10DD9E MOVE.W  <EA:3F>,<EA:3F>
        SUBQ.L  #5,-(A5)                        ; $10DDA0
        MOVE.W  (A5)+,(A6)+                     ; $10DDA2
        ADDQ.B  #1,-(A1)                        ; $10DDA4
        BRA.S  loc_10DDF1                       ; $10DDA6
        AND.L  D0,(A1)                          ; $10DDA8
        MOVE.W  -$0F(A7,D5.L),(A4)+             ; $10DDAA
        SUBQ.L  #5,$62(A5,A6.L)                 ; $10DDAE
        MOVE.W  #$BBFC,(A4)+                    ; $10DDB2
        DC.W    $ABFD               ; $10DDB6 MOVE.L  <EA:3D>,<EA:3D>
        SUBQ.L  #6,$5B5C(A3)                    ; $10DDB8
        CMPA.L  #$BBDB5B20,A0                   ; $10DDBC
        MOVEM.W D0/D2/D3/D4/D6/A0/A3/A6/A7,(A2)+; $10DDC2
        MOVE.W  D3,$08FC(A5)                    ; $10DDC6
        MOVE.W  -$04(PC,A5.W),-$04(A6,A3.L)     ; $10DDCA
        CMPA.L  -(A0),A3                        ; $10DDD0
        MOVE.W  D5,D0                           ; $10DDD2
        MOVE.W  (A5),-(A6)                      ; $10DDD4
        CLR.L  -$2207(PC)                       ; $10DDD6
        MOVE.L  #$CC6EABB7,(A5)                 ; $10DDDA
        MOVE.W  (A1)+,-$4384(A3)                ; $10DDE0
        SUB.W  -$389C(A1),D3                    ; $10DDE4
        MOVE.W  D7,$4C41.W                      ; $10DDE8
        SUB.W  D4,D4                            ; $10DDEC
        MOVE.B  (A6),D1                         ; $10DDEE
        BHI.S  loc_10DE5D                       ; $10DDF0
        SGT     -$10(A1,A7.W)                   ; $10DDF2
        MOVEQ   #$5C,D6                         ; $10DDF6
        ADDQ.W  #1,(A1)                         ; $10DDF8
        CLR    -(A7)                            ; $10DDFA
        ADD.B  D7,#$59CD                        ; $10DDFC
        MOVEA.W (A1),A4                         ; $10DE00
        MOVEA.W D7,A4                           ; $10DE02
        BVS.S  loc_10DDE7                       ; $10DE04
        MOVE.W  $4EAB(A2),D4                    ; $10DE06
        MOVE.L  -$5428(A3),(A5)                 ; $10DE0A
        ADD.W  D1,(A0)                          ; $10DE0E
        DC.W    $4324               ; $10DE10 DC.W    $4324
        MOVE.W  (A0)+,-(A0)                     ; $10DE12
        MOVE.W  -(A2),(A1)+                     ; $10DE14
        MOVE.W  A3,-(A7)                        ; $10DE16
        MOVE.W  -(A1),-(A0)                     ; $10DE18
        DC.W    $FCFE               ; $10DE1A MOVE.W  <EA:3E>,(A6)+
        MOVE.W  (A7)+,(A6)+                     ; $10DE1C
        DC.W    $AFF7,$AABA         ; $10DE1E MOVE.L  -$46(A7,A2.L),<EA:3F>
        DC.W    $AFCB               ; $10DE22 MOVE.L  A3,<EA:3F>
        MOVE.W  -$45(PC,D4.L),D5                ; $10DE24
        DC.W    $AFFC,$DCC1,$FFFF   ; $10DE28 MOVE.L  #$DCC1FFFF,<EA:3F>
        DC.W    $FDEF,$CB7E         ; $10DE2E MOVE.W  -$3482(A7),<EA:3E>
        MOVE.W  -(A7),(A4)+                     ; $10DE32
        MOVE.B  -$56(A1,A6.L),(A6)+             ; $10DE34
        MOVE.B  -$0504(A2),-$02(A7,D1.L)        ; $10DE38
        MOVE.B  $0520(A7),(A5)                  ; $10DE3E
        MOVE.W  -$5A27(A7),-$15(A0,A7.W)        ; $10DE42
        DC.W    $FC3F               ; $10DE48 MOVE.W  <EA:3F>,D6
        CMPI.L  #$191AAAFF,D0                   ; $10DE4A
        DC.W    $1FF1,$A31F         ; $10DE50 MOVE.B  $1F(A1,A2.W),<EA:3F>
        ASL.B  #7,D7                            ; $10DE54
        BSET    D1,-$51(A3,D1.W)                ; $10DE56
        ROR.W  -$0717(A4)                       ; $10DE5A
        MOVE.B  -$3D(A5,A0.W),$F8CF.W           ; $10DE5E
        MOVE.W  (A1)+,$FFA1.W                   ; $10DE64
        MOVE.W  $001F(A3),-$30(A7,A2.L)         ; $10DE68
        CMP.L  -$11(PC,A3.L),D2                 ; $10DE6E
        MOVE.L  -$01E9(A7),(A5)+                ; $10DE72
        DC.W    $95FF               ; $10DE76 SUBA.L  <EA:3F>,A2
        ROR.L  D7,D3                            ; $10DE78
        DC.W    $BEFE               ; $10DE7A CMPA.W  <EA:3E>,A7
        MOVE.W  -$4001(PC),(A7)                 ; $10DE7C
        MOVE.W  (A6),-$04(A5,D3.L)              ; $10DE80
        ASL.W  -(A4)                            ; $10DE84
        CMP.B  $AAEEDBBD,D2                     ; $10DE86
        LEA     $1877(A6),A3                    ; $10DE8C
        ROR.W  -(A1)                            ; $10DE90
        MOVE.W  -$2204(A5),(A0)+                ; $10DE92
        ROR.W  (A5)+                            ; $10DE96
        ADDA.L  #$EDD7EAC3,A3                   ; $10DE98
        MOVE.L  -$5523(A6),(A5)                 ; $10DE9E
        MOVE.L  -$5224(PC),$60(A1,A7.W)         ; $10DEA2
        DC.W    $41FF               ; $10DEA8 LEA     <EA:3F>,A0
        MOVE.W  (A2),D4                         ; $10DEAA
        MOVE.W  A2,(A7)                         ; $10DEAC
        BRA.S  loc_10DEF0                       ; $10DEAE
        DC.W    $0BFF               ; $10DEB0 BSET    D5,<EA:3F>
        MOVE.W  (A0),D4                         ; $10DEB2
        MOVEA.L (A5),A5                         ; $10DEB4
        MOVE.L  -(A5),$55(A2,A2.L)              ; $10DEB6
        ORI.W  #$FF08,A6                        ; $10DEBA
        MOVE.B  -$351F(A5),-$40(A1,D5.W)        ; $10DEBE
        DC.W    $415A               ; $10DEC4 DC.W    $415A
        MOVEA.L D3,A0                           ; $10DEC6
        MOVE.L  -(A3),#$079946AA                ; $10DEC8
        MOVEA.L -$06BD(A3),A5                   ; $10DECE
        OR.W   D0,-$42(A4,D3.W)                 ; $10DED2
        MOVE.W  -(A7),-$0C85(A7)                ; $10DED6
        ADD.L  D3,D0                            ; $10DEDA
        MOVE.W  (A7),D0                         ; $10DEDC
        CMPA.W  $14(A2,D5.L),A0                 ; $10DEDE
        DC.W    $5FFF               ; $10DEE2 SLE     <EA:3F>
        SUBA.L  $10EE.W,A5                      ; $10DEE4
        SUBQ.W  #5,(A6)                         ; $10DEE8
        SUBQ.L  #2,$24(A5,A1.W)                 ; $10DEEA
        SUBQ.B  #8,(A5)                         ; $10DEEE
loc_10DEF0:
        SUB.B  D5,-$5E(A1,A7.L)                 ; $10DEF0
        MOVEM.L D0/D2/D4/D6/D7/A0/A3/A4/A6,$5B55(A1); $10DEF4
        DC.W    $4983               ; $10DEFA DC.W    $4983
        MOVE.B  -(A6),(A3)+                     ; $10DEFC
        SUBQ.B  #5,$33(A7,A4.L)                 ; $10DEFE
        SUBQ.B  #6,-(A2)                        ; $10DF02
        MOVE.L  -$56(A3,D4.L),D6                ; $10DF04
        DC.W    $AAFF               ; $10DF08 MOVE.L  <EA:3F>,(A5)+
        DC.W    $7BFC,$FC1A         ; $10DF0A MOVE.W  #$FC1A,<EA:3D>
        MOVEA.L A6,A2                           ; $10DF0E
        MOVE.W  D2,D2                           ; $10DF10
        MOVE.L  (A3),$39(A3,D5.L)               ; $10DF12
        MOVE.W  A2,(A3)                         ; $10DF16
        MOVE.W  -$0207(A5),(A1)+                ; $10DF18
        DC.W    $E9FD               ; $10DF1C ASL.W  <EA:3D>
        LSL.W  $D042.W                          ; $10DF1E
        MOVE.W  -$6D(A2,D4.L),(A2)              ; $10DF22
        MULS    (A4),D1                         ; $10DF26
        ROXL.L  D5,D6                           ; $10DF28
        LEA     -(A6),A0                        ; $10DF2A
        DC.W    $4192               ; $10DF2C DC.W    $4192
        OR.L   A2,D5                            ; $10DF2E
        MOVE.W  D5,-$1D2A(A5)                   ; $10DF30
        LEA     A0,A1                           ; $10DF34
        MOVE.B  D7,D5                           ; $10DF36
        LSL.L  D1,D2                            ; $10DF38
        ADDQ.W  #4,(A6)+                        ; $10DF3A
        MOVEA.W (A1)+,A4                        ; $10DF3C
        MOVE.B  (A4)+,$2441(A5)                 ; $10DF3E
        ADD.W  D1,(A3)                          ; $10DF42
        MOVE.W  D7,(A3)+                        ; $10DF44
        DIVU    $31AA(A1),D4                    ; $10DF46
        MOVE.L  D2,-$0184(A1)                   ; $10DF4A
        MOVE.W  A4,-(A7)                        ; $10DF4E
        CLR    #$510A                           ; $10DF50
        CMP.L  $51E8(A4),D5                     ; $10DF54
        SUBQ.B  #8,(A5)                         ; $10DF58
        SPL     D7                              ; $10DF5A
        BRA.S  loc_10DEF6                       ; $10DF5C
        MOVE.B  (A4)+,$82744868                 ; $10DF5E
        MOVE.W  -$05(A1,A1.L),-(A2)             ; $10DF64
        DC.W    $FFF8,$1385         ; $10DF68 MOVE.W  $1385.W,<EA:3F>
        ASL.L  D2,D4                            ; $10DF6C
        BRA.S  loc_10DF06                       ; $10DF6E
        DC.W    $FFF8,$0F31         ; $10DF70 MOVE.W  $0F31.W,<EA:3F>
        AND.W  -(A4),D3                         ; $10DF74
        MOVE.W  -(A3),D6                        ; $10DF76
        MOVE.W  (A1),-(A5)                      ; $10DF78
        DC.W    $FBCC               ; $10DF7A MOVE.W  A4,<EA:3D>
        SUB.B  A5,D0                            ; $10DF7C
        OR.B   D1,-$7B04(A4)                    ; $10DF7E
        MOVE.B  A4,-$5403(A1)                   ; $10DF82
        DC.W    $31FD,$6BDB         ; $10DF86 MOVE.W  <EA:3D>,$6BDB.W
        MOVE.W  (A5),-(A1)                      ; $10DF8A
        DC.W    $833D               ; $10DF8C OR.B   D1,<EA:3D>
        MOVE.L  $7912(A4),$71(A0,D4.L)          ; $10DF8E
        SUBQ.W  #2,(A0)+                        ; $10DF94
        MOVE.B  (A3),-$4EF7(A0)                 ; $10DF96
        ROL.W  $25(PC,D3.W)                     ; $10DF9A
        ADDQ.W  #2,(A2)                         ; $10DF9E
        MOVE.B  (A2),(A2)+                      ; $10DFA0
        MOVE.W  (A4),-(A0)                      ; $10DFA2
        ADDQ.L  #2,(A2)                         ; $10DFA4
        MOVE.B  D0,$0D(A0,A1.W)                 ; $10DFA6
        DIVS    $8DE3.W,D7                      ; $10DFAA
        OR.L   D2,A0                            ; $10DFAE
        DC.W    $FDDF               ; $10DFB0 MOVE.W  (A7)+,<EA:3E>
        MOVE.W  (A5)+,(A6)+                     ; $10DFB2
        ADD.L  D6,A7                            ; $10DFB4
        LSR.L  D0,D1                            ; $10DFB6
        MOVE.W  (A5)+,-(A4)                     ; $10DFB8
        ADDQ.L  #2,-$7F(PC,A5.L)                ; $10DFBA
        MOVE.W  (A2),D4                         ; $10DFBE
        DC.W    $8DBD               ; $10DFC0 OR.L   D6,<EA:3D>
        ADDA.W  -(A4),A7                        ; $10DFC2
        MOVE.L  (A1),-(A4)                      ; $10DFC4
        MOVE.W  (A2)+,$4123(A0)                 ; $10DFC6
        ASR.W  -(A3)                            ; $10DFCA
        MOVE.W  A7,D4                           ; $10DFCC
        CMPA.W  #$E9FC,A4                       ; $10DFCE
        EOR.W  D6,(A1)                          ; $10DFD2
        BSET    D1,(A0)+                        ; $10DFD4
        DC.W    $D8BD               ; $10DFD6 ADD.L  <EA:3D>,D4
        MULU    $1351.W,D0                      ; $10DFD8
        MOVE.W  -(A2),D7                        ; $10DFDC
        DC.W    $3FD8               ; $10DFDE MOVE.W  (A0)+,<EA:3F>
        MOVE.L  -$1C08(PC),$1612(A1)            ; $10DFE0
        MOVEQ   #-$66,D6                        ; $10DFE6
        OR.B   D0,(A2)                          ; $10DFE8
        MOVE.L  -$21(A4,D0.L),-(A0)             ; $10DFEA
        ROXR.W  $1194.W                         ; $10DFEE
        DC.W    $0A25,$B42D         ; $10DFF2 EORI.B  #$B42D,-(A5)
        DC.W    $4111               ; $10DFF6 DC.W    $4111
        MOVE.L  (A5),-(A0)                      ; $10DFF8
        MOVEQ   #-$1D,D2                        ; $10DFFA
        SUBQ.W  #4,$47(A0,A7.L)                 ; $10DFFC
        MOVE.W  -(A2),-(A3)                     ; $10E000
        MOVEQ   #$54,D2                         ; $10E002
        MOVE.W  D7,$4574(A3)                    ; $10E004
        SUBQ.W  #8,$5577(A3)                    ; $10E008
        DC.W    $4754               ; $10E00C DC.W    $4754
        EOR.L  D3,-(A1)                         ; $10E00E
        SUBI.L  #$44F8120C,D2                   ; $10E010
        MOVE.L  (A0)+,$AA9869C1                 ; $10E016
        SUBQ.W  #3,-$06(A0,D7.W)                ; $10E01C
        MOVEQ   #-$36,D4                        ; $10E020
        MOVE.W  D5,$1113(A3)                    ; $10E022
        MOVE.W  -$65(A1,A7.W),(A5)              ; $10E026
        SUBQ.W  #2,(A5)                         ; $10E02A
        ADD.L  D6,(A2)+                         ; $10E02C
        SUB.W  -$6F(A5,A7.L),D4                 ; $10E02E
        CMP.W  $61(A1,A1.L),D3                  ; $10E032
        AND.L  -$4D(A3,A4.W),D2                 ; $10E036
        ADDQ.L  #7,(A5)+                        ; $10E03A
        MOVE.W  A5,-(A2)                        ; $10E03C
        SUB.L  D5,-$1E6F(A3)                    ; $10E03E
        MOVE.L  $3111(A6),-$3D(A5,D0.W)         ; $10E042
        ADDA.L  (A1),A6                         ; $10E048
        NEG.B  D5                               ; $10E04A
        OR.B   D2,$54A49A7B                     ; $10E04C
        SUBA.L  #$C391DAF0,A6                   ; $10E052
        MOVEQ   #$75,D3                         ; $10E058
        MOVE.W  $14(A1,D7.W),D5                 ; $10E05A
        DC.W    $4306               ; $10E05E DC.W    $4306
        AND.W  D4,(A4)                          ; $10E060
        MOVE.L  (A1)+,(A2)                      ; $10E062
        SUBQ.W  #2,A0                           ; $10E064
        OR.W   (A5),D6                          ; $10E066
        CMP.W  (A7),D5                          ; $10E068
        AND.B  -$7A(A4,D4.W),D5                 ; $10E06A
        BRA.S  loc_10DFF0                       ; $10E06E
        DC.W    $15FF,$F815         ; $10E070 MOVE.B  <EA:3F>,-$07EB(PC)
        DC.W    $451D               ; $10E074 DC.W    $451D
        OR.L   D3,-$3E(A4,D3.L)                 ; $10E076
        CMPA.W  $09(A0,D0.L),A5                 ; $10E07A
        DC.W    $4BFD               ; $10E07E LEA     <EA:3D>,A5
        MOVE.W  $1421.W,-(A1)                   ; $10E080
        DC.W    $FBCA               ; $10E084 MOVE.W  A2,<EA:3D>
        AND.L  D0,-$4608(A5)                    ; $10E086
        SUB.B  (A5),D0                          ; $10E08A
        MOVE.L  -$0328(A1),D0                   ; $10E08C
        EOR.W  D0,D4                            ; $10E090
        BPL.S  loc_10E0D4                       ; $10E092
        OR.B   A4,D0                            ; $10E094
        OR.B   D4,-$13(A6,A7.L)                 ; $10E096
        ASL.W  #$FFF8                           ; $10E09A
        BTST    D4,-$2F(A4,D4.W)                ; $10E09E
        MOVE.B  A6,-(A1)                        ; $10E0A2
        BSET    D3,#$4334                       ; $10E0A4
        MOVEA.W (A4),A6                         ; $10E0A8
        MOVE.W  D4,-$03F8(A0)                   ; $10E0AA
        MOVEA.B A1,A0                           ; $10E0AE
        LEA     #$F3440EAA,A3                   ; $10E0B0
        BMI.S  loc_10E0FC                       ; $10E0B6
        NEG.W  D1                               ; $10E0B8
        MOVE.W  (A1),$700A8C77                  ; $10E0BA
        OR.L   A2,D1                            ; $10E0C0
        ADD.W  D7,D2                            ; $10E0C2
        ADDQ.W  #4,-$03(A6,A2.L)                ; $10E0C4
        BSET    D5,-$46(A1,A5.L)                ; $10E0C8
        OR.L   D7,$FC5D.W                       ; $10E0CC
        BLS.S  loc_10E07C                       ; $10E0D0
        ADD.L  D4,-$45(A3,A3.W)                 ; $10E0D2
        DC.W    $ADE3               ; $10E0D6 MOVE.L  -(A3),<EA:3E>
        SUBA.W  -(A1),A5                        ; $10E0D8
        SUBA.W  (A3)+,A5                        ; $10E0DA
        ADD.B  D6,-(A3)                         ; $10E0DC
        MOVE.L  (A6)+,D6                        ; $10E0DE
        MOVEA.W -$38(A3,D6.L),A6                ; $10E0E0
        MOVE.B  (A0),$6C(PC,A7.W)               ; $10E0E4
        MOVE.W  $21(A3,D5.W),-(A0)              ; $10E0E8
        MOVE.W  -$0B8E(A5),-(A7)                ; $10E0EC
        MOVE.L  -(A2),D1                        ; $10E0F0
        MOVE.B  $25(A7,D5.W),$52E8(A3)          ; $10E0F2
        EOR.W  D4,-$37(A5,D6.W)                 ; $10E0F8
loc_10E0FC:
        ADD.W  D2,D5                            ; $10E0FC
        ROXL.W  #8,D7                           ; $10E0FE
        MOVE.W  (A1),-$3F(A0,D6.L)              ; $10E100
        MOVE.L  $71(A3,D7.W),D1                 ; $10E104
        ASR.W  #6,D7                            ; $10E108
        SUBQ.L  #8,-(A2)                        ; $10E10A
        CMP.B  -(A2),D2                         ; $10E10C
        MOVE.B  -$5F(A2,D3.L),-$05B8(PC)        ; $10E10E
        SUBQ.B  #4,(A5)+                        ; $10E114
        CMP.W  -(A4),D0                         ; $10E116
        BVS.S  loc_10E149                       ; $10E118
        BSR.S  loc_10E191                       ; $10E11A
        SF      (A7)                            ; $10E11C
        AND.B  (A2),D4                          ; $10E11E
        MOVE.B  D4,(A1)                         ; $10E120
        DC.W    $2DCA               ; $10E122 MOVE.L  A2,<EA:3E>
        MOVE.L  A3,(A4)+                        ; $10E124
        DC.W    $D8FF               ; $10E126 ADDA.W  <EA:3F>,A4
        SEQ     -(A5)                           ; $10E128
        OR.L   D7,$4224(A2)                     ; $10E12A
        MOVE.L  -$47(A4,D5.W),-(A1)             ; $10E12E
        MOVE.L  -$134F(A2),(A7)+                ; $10E132
        MOVEQ   #-$46,D4                        ; $10E136
        MOVE.B  D6,-(A2)                        ; $10E138
        BRA.S  loc_10E12D                       ; $10E13A
        DC.W    $4570               ; $10E13C DC.W    $4570
        EOR.W  D0,D0                            ; $10E13E
        ADDA.W  -(A2),A5                        ; $10E140
        NEG.W  (A5)                             ; $10E142
        ASR.B  #8,D3                            ; $10E144
        ORI.W  #$6932,-$1A(A6,A7.L)             ; $10E146
        MOVE.W  (A2),$0FB4(A1)                  ; $10E14C
        ADD.B  D4,-$5F(A2,D6.W)                 ; $10E150
        MOVEA.L (A5),A2                         ; $10E154
        SUB.L  D1,-$5527(A2)                    ; $10E156
        SUBA.W  -$4E4E(A3),A2                   ; $10E15A
        MOVE.L  A3,D7                           ; $10E15E
        SUB.L  D6,(A1)+                         ; $10E160
        AND.L  $72(A5,A1.L),D4                  ; $10E162
        AND.L  D0,$2A(A2,A6.W)                  ; $10E166
        DC.W    $00FA               ; $10E16A DC.W    $00FA
        MOVEA.L $12(A4,A6.W),A3                 ; $10E16C
        MOVEA.W $F1CE.W,A1                      ; $10E170
        OR.B   D4,$76(A1,A3.W)                  ; $10E174
        ST      -(A6)                           ; $10E178
        DC.W    $21FC,$A122,$549B,$6070; $10E17A MOVE.L  #$A122549B,$6070.W
        MOVE.B  $E951.W,$0C(A2,D4.W)            ; $10E182
        BLS.L  $1045923                         ; $10E188
        MOVE.B  -(A0),(A5)                      ; $10E18E
        SUBQ.W  #4,(A5)                         ; $10E190
        OR.B   D1,A1                            ; $10E192
        BEQ.S  $10E20A                          ; $10E194
        OR.B   D3,D0                            ; $10E196
        DC.W    $BAFF               ; $10E198 CMPA.W  <EA:3F>,A5
        MOVE.W  (A7),D4                         ; $10E19A
        MOVE.L  -(A2),(A0)                      ; $10E19C
        MOVE.W  (A3)+,-$16(A0,A6.L)             ; $10E19E
        OR.L   D3,(A1)+                         ; $10E1A2
        MOVE.W  D4,$89995F6B                    ; $10E1A4
        MOVEQ   #$54,D2                         ; $10E1AA
        DC.W    $06EA               ; $10E1AC DC.W    $06EA
        MOVE.W  $1FB3.W,(A2)                    ; $10E1AE
        DC.W    $C17D               ; $10E1B2 AND.W  D0,<EA:3D>
        ADD.W  D6,-$26(PC,A3.W)                 ; $10E1B4
        ROL.W  $127B.W                          ; $10E1B8
        MOVE.L  -$2E56(A6),-(A3)                ; $10E1BC
        EOR.W  D3,-$3F(A7,D6.W)                 ; $10E1C0
        DC.W    $7DDB               ; $10E1C4 MOVE.W  (A3)+,<EA:3E>
        CMPA.L  D3,A5                           ; $10E1C6
        MOVE.W  -(A7),#$B122                    ; $10E1C8
        MOVEA.W (A2),A0                         ; $10E1CC
        MOVEA.L $75(A4,A7.L),A1                 ; $10E1CE
        ADDQ.B  #1,-$59(A0,D5.L)                ; $10E1D2
        SUB.L  $75FB(PC),D5                     ; $10E1D6
        ROXR.W  $2748(A2)                       ; $10E1DA
        MOVE.W  D1,D1                           ; $10E1DE
        BHI.S  $10E219                          ; $10E1E0
        DC.W    $F3F6,$F872,$F572,$15ED; $10E1E2 MOVE.W  $72(A6,A7.L),$F57215ED
        DC.W    $EDFF               ; $10E1EA ROXL.W  <EA:3F>
        MOVE.W  -(A6),-$5E(A6,A6.W)             ; $10E1EC
        MULS    -(A0),D7                        ; $10E1F0
        MOVE.L  A4,D0                           ; $10E1F2
        DC.W    $55BF               ; $10E1F4 SUBQ.L  #2,<EA:3F>
        ASR.W  #5,D5                            ; $10E1F6
        MOVE.B  A6,D5                           ; $10E1F8
        LEA     -(A6),A3                        ; $10E1FA
        DC.W    $4154               ; $10E1FC DC.W    $4154
        MOVEA.L (A2),A6                         ; $10E1FE
