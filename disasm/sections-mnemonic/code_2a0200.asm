; Generated assembly for $2A0200-$2A2200
; Branch targets: 37
; Labels: 37
; Format: DC.W with decoded mnemonics as comments

        org     $2A0200

        CLR.B  D0                               ; $2A0200
        DC.W    $0000,$57EE         ; $2A0202 ORI.B  #$57EE,D0
        DC.W    $0000,$0000         ; $2A0206 ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A020A
        DC.W    $0000,$0000         ; $2A020C ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A0210
        CLR.B  D0                               ; $2A0212
        DC.W    $0000,$A4CE         ; $2A0214 ORI.B  #$A4CE,D0
        CLR.B  D0                               ; $2A0218
        DC.W    $0000,$A4CE         ; $2A021A ORI.B  #$A4CE,D0
        DC.W    $0000,$0000         ; $2A021E ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A0222
        DC.W    $0000,$0000         ; $2A0224 ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A0228
        CLR.B  D0                               ; $2A022A
        DC.W    $0000,$3F10         ; $2A022C ORI.B  #$3F10,D0
        MOVE.W  $6F(PC,A7.L),$3F10(A0)          ; $2A0230
        MOVE.L  $6F(PC,A7.L),$57F0(A6)          ; $2A0236
        MOVE.L  $00(PC,D0.W),$57F0(A6)          ; $2A023C
        MOVE.W  $00(PC,D0.W),$3F10(A0)          ; $2A0242
        DC.W    $417B               ; $2A0248 DC.W    $417B
        MOVEA.W $3F10(A7),A4                    ; $2A024A
        MOVE.W  $6F(PC,A7.L),$57F0(A6)          ; $2A024E
        MOVE.W  $00(PC,D0.W),$57F0(A6)          ; $2A0254
        DC.W    $417B               ; $2A025A DC.W    $417B
        DC.W    $0000,$A7FF         ; $2A025C ORI.B  #$A7FF,D0
        MOVE.W  $00(PC,D0.W),-$5801(A0)         ; $2A0260
        MOVE.L  $00(PC,D0.W),-$3D3C(A6)         ; $2A0266
        MOVE.L  $00(PC,D0.W),-$3D3C(A6)         ; $2A026C
        MOVE.W  $00(PC,D0.W),-$5801(A0)         ; $2A0272
        DC.W    $417B               ; $2A0278 DC.W    $417B
        DC.W    $0000,$A7FF         ; $2A027A ORI.B  #$A7FF,D0
        MOVE.W  $00(PC,D0.W),-$3D3C(A6)         ; $2A027E
        MOVE.W  $00(PC,D0.W),-$3D3C(A6)         ; $2A0284
        DC.W    $417B               ; $2A028A DC.W    $417B
        DC.W    $0000,$D225         ; $2A028C ORI.B  #$D225,D0
        DC.W    $417B               ; $2A0290 DC.W    $417B
        DC.W    $0000,$D225         ; $2A0292 ORI.B  #$D225,D0
        MOVE.L  $00(PC,D0.W),$17A0(A6)          ; $2A0296
        DC.W    $417B               ; $2A029C DC.W    $417B
        MOVE.W  -$47(A0,A6.L),(A7)              ; $2A029E
        DC.W    $417B               ; $2A02A2 DC.W    $417B
        DC.W    $FFFF               ; $2A02A4 MOVE.W  <EA:3F>,<EA:3F>
        ROR.L  D5,D1                            ; $2A02A6
        MOVE.L  -$01(PC,A7.L),$17A0(A6)         ; $2A02A8
        MOVE.L  -$50(PC,A7.L),$2FF1(A6)         ; $2A02AE
        DC.W    $417B               ; $2A02B4 DC.W    $417B
        DC.W    $FB3D               ; $2A02B6 MOVE.W  <EA:3D>,-(A5)
        DC.W    $2FF1,$2D7B         ; $2A02B8 MOVE.L  $7B(A1,D2.L),<EA:3F>
        DC.W    $FB3D               ; $2A02BC MOVE.W  <EA:3D>,-(A5)
        ADDA.W  #$38AF,A6                       ; $2A02BE
        MOVE.W  (A5)+,(A7)+                     ; $2A02C2
        ADDA.W  #$3648,A6                       ; $2A02C4
        MOVE.W  (A5)+,(A7)+                     ; $2A02C8
        ROR.B  D4,D1                            ; $2A02CA
        MOVEA.W A0,A3                           ; $2A02CC
        MOVE.W  (A5)+,(A7)+                     ; $2A02CE
        ROR.B  D4,D1                            ; $2A02D0
        MOVE.W  -$0123(A7),(A4)                 ; $2A02D2
        ROR.W  $38AFFEDD                        ; $2A02D6
        ROR.W  $3048FEDD                        ; $2A02DC
        ROL.W  D4,D0                            ; $2A02E2
        MOVEA.W A0,A0                           ; $2A02E4
        MOVE.W  (A4)+,(A7)+                     ; $2A02E6
        ROL.W  D4,D0                            ; $2A02E8
        MOVE.W  -$0124(A7),(A4)                 ; $2A02EA
        ADDA.W  #$3EAF,A6                       ; $2A02EE
        MOVE.W  (A5)+,(A7)+                     ; $2A02F2
        ADD.W  D7,$48(PC,D3.W)                  ; $2A02F4
        MOVE.W  (A5)+,(A7)+                     ; $2A02F8
        ADD.W  D7,-$51(PC,D3.L)                 ; $2A02FA
        MOVE.W  (A5)+,(A7)+                     ; $2A02FE
        ADDA.W  #$32AF,A6                       ; $2A0300
        MOVE.W  (A5)+,(A7)+                     ; $2A0304
        ADDA.W  #$3048,A6                       ; $2A0306
        MOVE.W  (A5)+,(A7)+                     ; $2A030A
        ROL.W  D4,D0                            ; $2A030C
        MOVE.W  -$0124(A7),(A1)                 ; $2A030E
        LSL.W  -$51(A7,D3.L)                    ; $2A0312
        MOVE.W  (A3)+,(A7)+                     ; $2A0316
        LSL.W  $48(A7,D3.L)                     ; $2A0318
        MOVE.W  (A3)+,(A7)+                     ; $2A031C
        MOVEA.W $48(A3,D3.L),A4                 ; $2A031E
        MOVE.W  D6,(A7)+                        ; $2A0322
        MOVEA.W -$51(A3,D3.L),A4                ; $2A0324
        MOVE.W  D6,(A7)+                        ; $2A0328
        MOVE.W  $7B(A6,D3.L),(A0)+              ; $2A032A
        MOVE.W  (A5),(A7)+                      ; $2A032E
        MOVE.W  $48(A6,D3.W),(A0)+              ; $2A0330
        MOVE.W  (A5),(A7)+                      ; $2A0334
        MOVE.W  $48(A5,D3.W),-$012F(A1)         ; $2A0336
        MOVE.W  $7B(A5,D3.L),-$012F(A1)         ; $2A033C
        DC.W    $1DD8               ; $2A0342 MOVE.B  (A0)+,<EA:3E>
        MOVE.W  -$0C(PC,A7.L),$1DD8(A6)         ; $2A0344
        MOVEA.W A0,A0                           ; $2A034A
        MOVE.W  $52(A4,D2.W),(A6)+              ; $2A034C
        MOVEA.W A0,A0                           ; $2A0350
        MOVE.W  $2052(A1),(A6)                  ; $2A0352
        MOVE.W  -$57(PC,A7.L),$18E0(A6)         ; $2A0356
        MOVE.W  -$028F(A7),(A7)                 ; $2A035C
        MOVE.B  -(A0),(A4)+                     ; $2A0360
        MOVEA.W A0,A6                           ; $2A0362
        MOVE.W  $45(A1,D2.W),$3C48(A6)          ; $2A0364
        DC.W    $FBFA,$2545         ; $2A036A MOVE.W  $2545(PC),<EA:3D>
        MOVE.W  -$0406(A7),(A7)                 ; $2A036E
        MOVE.B  -(A7),$377B(A0)                 ; $2A0372
        DC.W    $FDFB,$13E5         ; $2A0376 MOVE.W  -$1B(PC,D1.W),<EA:3E>
        MOVEA.W A0,A0                           ; $2A037A
        DC.W    $FDD2               ; $2A037C MOVE.W  (A2),<EA:3E>
        MOVEA.B -(A3),A3                        ; $2A037E
        MOVEA.W A0,A0                           ; $2A0380
        MOVE.W  -(A5),-$1B(A6,D1.W)             ; $2A0382
        MOVE.W  -$2E(PC,A7.L),$0B2B(A3)         ; $2A0386
        MOVE.W  -$01B4(A7),(A4)                 ; $2A038C
        BTST    D5,$3648(A3)                    ; $2A0390
        MOVEA.W A4,A7                           ; $2A0394
        MOVEA.B -(A3),A3                        ; $2A0396
        MOVEA.W A0,A3                           ; $2A0398
        MOVE.W  -(A5),$63(A6,D1.W)              ; $2A039A
        MOVE.W  -$025B(A7),(A4)                 ; $2A039E
        BTST    D5,$3EAF(A3)                    ; $2A03A2
        MOVEA.W A4,A7                           ; $2A03A6
        BTST    D5,$3C48(A3)                    ; $2A03A8
        MOVEA.W A4,A7                           ; $2A03AC
        MOVE.B  -(A3),-(A2)                     ; $2A03AE
        MOVEA.W A0,A6                           ; $2A03B0
        DC.W    $FDBD,$1523         ; $2A03B2 MOVE.W  <EA:3D>,$23(A6,D1.W)
        MOVE.W  -$0243(A7),(A7)                 ; $2A03B6
        MOVE.B  -(A5),$3EAFFDD2                 ; $2A03BA
        MOVEA.B -(A3),A3                        ; $2A03C0
        MOVE.W  -$5B(PC,A7.L),$1663(A3)         ; $2A03C2
        MOVE.W  -$025B(A7),(A7)                 ; $2A03C8
        BSET    D4,$3EAF(A4)                    ; $2A03CC
        MOVEA.W (A2)+,A7                        ; $2A03D0
        BSET    D4,$3048(A4)                    ; $2A03D2
        MOVEA.W (A2)+,A7                        ; $2A03D6
        CMPI.W  #$3048,-$01C2(A2)               ; $2A03D8
        CMPI.W  #$3EAF,-$01C2(A2)               ; $2A03DE
        MOVE.W  -$51(A3,D3.L),D6                ; $2A03E4
        MOVE.W  $FC33.W,(A7)                    ; $2A03E8
        MOVEA.W A0,A3                           ; $2A03EC
        MOVE.W  $062E.W,(A7)                    ; $2A03EE
        MOVEA.W A0,A3                           ; $2A03F2
        MOVEA.W $2E(PC,D0.W),A7                 ; $2A03F4
        MOVE.W  -$0185(A7),(A4)                 ; $2A03F8
        MOVE.W  -$51(A3,D3.L),D6                ; $2A03FC
        MOVE.W  $FC33.W,(A7)                    ; $2A0400
        MOVEA.W A0,A6                           ; $2A0404
        MOVE.W  $062E.W,(A7)                    ; $2A0406
        MOVEA.W A0,A6                           ; $2A040A
        MOVEA.W $2E(PC,D0.W),A7                 ; $2A040C
        MOVE.W  -$0185(A7),(A7)                 ; $2A0410
        DC.W    $04EE               ; $2A0414 DC.W    $04EE
        MOVE.W  -$017A(A7),(A7)                 ; $2A0416
        DC.W    $04EE               ; $2A041A DC.W    $04EE
        MOVEA.W A0,A0                           ; $2A041C
        MOVE.W  D6,(A7)                         ; $2A041E
        BCHG    D3,$3048(A5)                    ; $2A0420
        MOVEA.W $6D(A1,D0.W),A7                 ; $2A0424
        MOVE.W  -$018F(A7),(A7)                 ; $2A0428
        ADDA.W  #$3C48,A6                       ; $2A042C
        MOVE.W  (A5)+,(A7)+                     ; $2A0430
        ROL.W  D4,D0                            ; $2A0432
        MOVEA.W A0,A6                           ; $2A0434
        MOVE.W  (A4)+,(A7)+                     ; $2A0436
        ROL.W  D4,D0                            ; $2A0438
        MOVE.W  -$0124(A7),(A7)                 ; $2A043A
        MOVE.W  -$51(A2,D3.L),(A5)+             ; $2A043E
        DC.W    $FEBD               ; $2A0442 MOVE.W  <EA:3D>,(A7)
        MOVE.W  $48(A3,D3.W),(A5)+              ; $2A0444
        DC.W    $FEBD               ; $2A0448 MOVE.W  <EA:3D>,(A7)
        MOVE.W  $48(A2,D3.W),-$014D(A6)         ; $2A044A
        MOVE.W  -$51(A2,D3.L),-$014D(A6)        ; $2A0450
        DC.W    $0004,$2000         ; $2A0456 ORI.B  #$2000,D4
        BCLR    D0,D0                           ; $2A045A
        BCHG    D0,$20(A0,D0.W)                 ; $2A045C
        BCLR    D0,(A0)                         ; $2A0460
        DC.W    $0204,$2000         ; $2A0462 ANDI.B  #$2000,D4
        BSET    D0,D0                           ; $2A0466
        BCLR    D0,$04(A0,D0.W)                 ; $2A0468
        MOVE.L  D0,D0                           ; $2A046C
        BSET    D0,(A0)                         ; $2A046E
        BCLR    D0,-(A0)                        ; $2A0470
        SUBI.B  #$2000,D4                       ; $2A0472
        BSET    D0,-$20(A0,D0.W)                ; $2A0476
        SUBI.B  #$2000,D4                       ; $2A047A
        ORI.L  #$00C00000,(A0)                  ; $2A047E
        BTST    D2,D0                           ; $2A0484
        DC.W    $0000,$0010         ; $2A0486 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A048A ORI.B  #$0030,-(A0)
        DC.W    $0000,$0500         ; $2A048E ORI.B  #$0500,D0
        ORI.W  #$0050,D0                        ; $2A0492
        ORI.W  #$0070,-(A0)                     ; $2A0496
        DC.W    $0004,$2000         ; $2A049A ORI.B  #$2000,D4
        ORI.L  #$009000A0,D0                    ; $2A049E
        DC.W    $00B0,$0004,$2000,$00C0; $2A04A4 ORI.L  #$00042000,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A04AC DC.W    $00D0
        DC.W    $00E0               ; $2A04AE DC.W    $00E0
        DC.W    $00F0               ; $2A04B0 DC.W    $00F0
        DC.W    $0004,$2000         ; $2A04B2 ORI.B  #$2000,D4
        BTST    D0,D0                           ; $2A04B6
        BTST    D0,(A0)                         ; $2A04B8
        BTST    D0,-(A0)                        ; $2A04BA
        BTST    D0,$04(A0,D0.W)                 ; $2A04BC
        MOVE.L  D0,D0                           ; $2A04C0
        BCHG    D0,D0                           ; $2A04C2
        BCHG    D0,(A0)                         ; $2A04C4
        BCHG    D0,-(A0)                        ; $2A04C6
        BCHG    D0,$12(A0,D0.W)                 ; $2A04C8
        MOVE.W  D0,-(A4)                        ; $2A04CC
        DC.W    $0200,$0210         ; $2A04CE ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2A04D2 ANDI.B  #$0230,-(A0)
        DC.W    $0012,$7900         ; $2A04D6 ORI.B  #$7900,(A2)
        ANDI.W  #$0250,D0                       ; $2A04DA
        ANDI.W  #$0270,-(A0)                    ; $2A04DE
        DC.W    $0012,$7900         ; $2A04E2 ORI.B  #$7900,(A2)
        ANDI.L  #$02100290,D0                   ; $2A04E6
        ANDI.L  #$00127900,-(A0)                ; $2A04EC
        DC.W    $02B0,$02C0,$0260,$02D0; $2A04F2 ANDI.L  #$02C00260,-$30(A0,D0.W)
        DC.W    $0012,$7900         ; $2A04FA ORI.B  #$7900,(A2)
        DC.W    $02E0               ; $2A04FE DC.W    $02E0
        DC.W    $02F0               ; $2A0500 DC.W    $02F0
        BTST    D1,D0                           ; $2A0502
        BTST    D1,(A0)                         ; $2A0504
        DC.W    $0012,$7900         ; $2A0506 ORI.B  #$7900,(A2)
        BTST    D1,-(A0)                        ; $2A050A
        BTST    D1,$40(A0,D0.W)                 ; $2A050C
        BCHG    D1,(A0)                         ; $2A0510
        DC.W    $0012,$7900         ; $2A0512 ORI.B  #$7900,(A2)
        BCHG    D1,-(A0)                        ; $2A0516
        BCHG    D1,-$80(A0,D0.W)                ; $2A0518
        BCLR    D1,(A0)                         ; $2A051C
        DC.W    $0012,$7900         ; $2A051E ORI.B  #$7900,(A2)
        BCLR    D1,-(A0)                        ; $2A0522
        BCLR    D1,-$40(A0,D0.W)                ; $2A0524
        BSET    D1,(A0)                         ; $2A0528
        DC.W    $0012,$7900         ; $2A052A ORI.B  #$7900,(A2)
        BSET    D1,-(A0)                        ; $2A052E
        BSET    D1,$00(A0,D0.W)                 ; $2A0530
        SUBI.B  #$0012,(A0)                     ; $2A0534
        MOVE.W  D0,-(A4)                        ; $2A0538
        SUBI.B  #$0430,-(A0)                    ; $2A053A
        SUBI.W  #$0450,D0                       ; $2A053E
        DC.W    $0012,$7900         ; $2A0542 ORI.B  #$7900,(A2)
        SUBI.W  #$0470,-(A0)                    ; $2A0546
        SUBI.L  #$04900012,D0                   ; $2A054A
        MOVE.W  D0,-(A4)                        ; $2A0550
        SUBI.L  #$041004B0,-(A0)                ; $2A0552
        DC.W    $04C0               ; $2A0558 DC.W    $04C0
        DC.W    $0012,$7900         ; $2A055A ORI.B  #$7900,(A2)
        DC.W    $04D0               ; $2A055E DC.W    $04D0
        DC.W    $04E0               ; $2A0560 DC.W    $04E0
        DC.W    $04F0               ; $2A0562 DC.W    $04F0
        BTST    D2,D0                           ; $2A0564
        DC.W    $0012,$7900         ; $2A0566 ORI.B  #$7900,(A2)
        BTST    D2,(A0)                         ; $2A056A
        BTST    D2,-(A0)                        ; $2A056C
        BTST    D2,$40(A0,D0.W)                 ; $2A056E
        DC.W    $0012,$7900         ; $2A0572 ORI.B  #$7900,(A2)
        BCHG    D2,(A0)                         ; $2A0576
        BCHG    D2,-(A0)                        ; $2A0578
        BCHG    D2,-$80(A0,D0.W)                ; $2A057A
        DC.W    $0012,$7900         ; $2A057E ORI.B  #$7900,(A2)
        BCLR    D2,(A0)                         ; $2A0582
        BCLR    D2,-(A0)                        ; $2A0584
        BCLR    D2,-$40(A0,D0.W)                ; $2A0586
        DC.W    $0012,$7900         ; $2A058A ORI.B  #$7900,(A2)
        ANDI.L  #$05D005E0,D0                   ; $2A058E
        BSET    D2,$12(A0,D0.W)                 ; $2A0594
        MOVE.W  D0,-(A4)                        ; $2A0598
        ADDI.B  #$0610,D0                       ; $2A059A
        ADDI.B  #$0630,-(A0)                    ; $2A059E
        CMPI.B  #$0044,D0                       ; $2A05A2
        ORI.W  #$0E04,D4                        ; $2A05A6
        MOVE.W  $14(PC,A7.L),$0E04(A6)          ; $2A05AA
        MOVEA.W A0,A3                           ; $2A05B0
        MOVE.W  (A4),-(A4)                      ; $2A05B2
        MOVEA.B $48(A1,D3.W),A0                 ; $2A05B4
        MOVEA.W $1071(A1),A4                    ; $2A05B8
        MOVE.W  $69(PC,A7.L),$057A(A6)          ; $2A05BC
        MOVE.W  $3B(PC,A7.L),$057A(A3)          ; $2A05C2
        MOVE.W  (A5),-(A2)                      ; $2A05C8
        MOVE.W  $71(PC,D1.W),-(A5)              ; $2A05CA
        MOVE.W  (A5),-(A2)                      ; $2A05CE
        MOVEA.W $1071(A1),A4                    ; $2A05D0
        MOVE.W  $69(PC,A7.L),$057A(A3)          ; $2A05D4
        MOVE.W  -$04C5(A7),(A7)                 ; $2A05DA
        BCHG    D2,$3C48(PC)                    ; $2A05DE
        MOVE.W  $71(PC,D1.W),-(A5)              ; $2A05E2
        MOVEA.W A0,A6                           ; $2A05E6
        MOVEA.W $1071(A1),A4                    ; $2A05E8
        MOVE.W  -$0797(A7),(A7)                 ; $2A05EC
        SUBI.W  #$3EAF,D0                       ; $2A05F0
        MOVE.W  D3,$40(A5,D0.W)                 ; $2A05F4
        MOVEA.W A0,A0                           ; $2A05F8
        MOVE.W  D3,-$4C(A5,D0.W)                ; $2A05FA
        MOVEA.W A0,A0                           ; $2A05FE
        MOVE.W  -$4C(A2,D0.W),(A5)+             ; $2A0600
        MOVE.W  -$050E(A7),(A7)                 ; $2A0604
        ASL.B  D7,D0                            ; $2A0608
        MOVE.W  -$014D(A7),(A1)                 ; $2A060A
        ASL.B  D7,D0                            ; $2A060E
        MOVEA.W A0,A0                           ; $2A0610
        MOVE.W  $5F(A3,A7.L),(A7)               ; $2A0612
        MOVEA.W A0,A0                           ; $2A0616
        MOVE.W  -(A1),-$05A1(A6)                ; $2A0618
        MOVE.W  -$029F(A7),(A1)                 ; $2A061C
        ASL.B  D7,D0                            ; $2A0620
        MOVE.W  -$014D(A7),(A7)                 ; $2A0622
        ASL.B  D7,D0                            ; $2A0626
        MOVEA.W A0,A6                           ; $2A0628
        MOVE.W  $5F(A3,A7.L),(A7)               ; $2A062A
        MOVEA.W A0,A6                           ; $2A062E
        MOVE.W  -(A1),-$05A1(A6)                ; $2A0630
        MOVE.W  -$029F(A7),(A7)                 ; $2A0634
        ROXL.W  -(A0)                           ; $2A0638
        MOVE.W  -$0133(A7),(A7)                 ; $2A063A
        ROXL.W  -(A0)                           ; $2A063E
        MOVEA.W A0,A0                           ; $2A0640
        MOVE.W  A5,(A7)+                        ; $2A0642
        MOVEA.W -(A1),A0                        ; $2A0644
        MOVEA.W A0,A0                           ; $2A0646
        MOVE.W  (A7),(A7)                       ; $2A0648
        MOVEA.W -(A1),A0                        ; $2A064A
        MOVE.W  -$0169(A7),(A7)                 ; $2A064C
        MOVE.W  (A2)+,(A6)+                     ; $2A0650
        MOVE.W  -$0307(A7),(A1)                 ; $2A0652
        MOVE.W  (A2)+,(A6)+                     ; $2A0656
        MOVEA.W A0,A0                           ; $2A0658
        MOVE.W  $FF533048,(A6)+                 ; $2A065A
        MOVE.W  D6,(A6)                         ; $2A0660
        MOVE.W  (A3),$32AF(A7)                  ; $2A0662
        MOVE.W  D6,(A6)                         ; $2A0666
        MOVE.B  (A5)+,(A1)+                     ; $2A0668
        MOVE.W  -$0846(A7),(A1)                 ; $2A066A
        MOVE.B  (A5)+,(A1)+                     ; $2A066E
        MOVEA.W A0,A0                           ; $2A0670
        MOVE.W  $1548(PC),$48(A3,D3.W)          ; $2A0672
        MOVE.W  A0,-(A3)                        ; $2A0678
        MOVE.B  A0,$32AF(A2)                    ; $2A067A
        MOVE.W  A0,-(A3)                        ; $2A067E
        MOVE.W  $7B(A2,D3.W),-(A7)              ; $2A0680
        MOVE.W  $32(A0,D3.L),$2D7B(A2)          ; $2A0684
        MOVE.W  -$10(A0,D5.W),$2D7B(A2)         ; $2A068A
        DC.W    $0000,$57F0         ; $2A0690 ORI.B  #$57F0,D0
        MOVE.W  $00(PC,D0.W),$3F32(A0)          ; $2A0694
        DC.W    $417B               ; $2A069A DC.W    $417B
        MOVE.W  $32(A0,D3.L),$3D7B(A2)          ; $2A069C
        MOVE.W  -$10(A0,D5.W),$3D7B(A2)         ; $2A06A2
        DC.W    $0000,$57F0         ; $2A06A8 ORI.B  #$57F0,D0
        DC.W    $417B               ; $2A06AC DC.W    $417B
        DC.W    $0000,$A7FF         ; $2A06AE ORI.B  #$A7FF,D0
        MOVE.W  -$01(PC,A7.L),-$5801(A0)        ; $2A06B2
        MOVE.L  -$01(PC,A7.L),-$3CE0(A6)        ; $2A06B8
        MOVE.L  $1A(PC,D0.W),-$3CE0(A6)         ; $2A06BE
        MOVE.W  $1A(PC,D0.W),-$5801(A0)         ; $2A06C4
        DC.W    $417B               ; $2A06CA DC.W    $417B
        DC.W    $FFFF               ; $2A06CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $A7FF,$3D7B         ; $2A06CE MOVE.L  <EA:3F>,$7B(PC,D3.L)
        DC.W    $FFFF               ; $2A06D2 MOVE.W  <EA:3F>,<EA:3F>
        AND.B  D1,-(A0)                         ; $2A06D4
        MOVE.W  $1A(PC,D0.W),-$3CE0(A6)         ; $2A06D6
        DC.W    $417B               ; $2A06DC DC.W    $417B
        BTST    D0,(A2)+                        ; $2A06DE
        ADD.L  (A6)+,D1                         ; $2A06E0
        DC.W    $417B               ; $2A06E2 DC.W    $417B
        BCHG    D0,-$2D62(A1)                   ; $2A06E4
        MOVE.L  $69(PC,D0.W),$17B2(A6)          ; $2A06E8
        DC.W    $417B               ; $2A06EE DC.W    $417B
        MOVE.W  -(A2),D4                        ; $2A06F0
        ROL.W  #5,D6                            ; $2A06F2
        DC.W    $417B               ; $2A06F4 DC.W    $417B
        DC.W    $00C8               ; $2A06F6 DC.W    $00C8
        ROL.W  #5,D6                            ; $2A06F8
        MOVE.L  -$38(PC,D0.W),$17B2(A6)         ; $2A06FA
        MOVE.L  $22(PC,A7.L),$2FE8(A6)          ; $2A0700
        DC.W    $417B               ; $2A0706 DC.W    $417B
        MOVE.W  A4,$2FE8(A1)                    ; $2A0708
        MOVE.L  $4C(PC,A7.W),$57EE(A6)          ; $2A070C
        CLR.B  D0                               ; $2A0712
        DC.W    $0000,$57EE         ; $2A0714 ORI.B  #$57EE,D0
        DC.W    $0000,$0000         ; $2A0718 ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A071C
        DC.W    $0000,$0000         ; $2A071E ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A0722
        CLR.B  D0                               ; $2A0724
        DC.W    $0000,$A4CE         ; $2A0726 ORI.B  #$A4CE,D0
        CLR.B  D0                               ; $2A072A
        DC.W    $0000,$A4CE         ; $2A072C ORI.B  #$A4CE,D0
        DC.W    $0000,$0000         ; $2A0730 ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A0734
        DC.W    $0000,$0000         ; $2A0736 ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A073A
        CLR.B  D0                               ; $2A073C
        DC.W    $0000,$0004         ; $2A073E ORI.B  #$0004,D0
        MOVE.L  D0,D0                           ; $2A0742
        BCHG    D1,D0                           ; $2A0744
        BTST    D1,-$20(A0,D0.W)                ; $2A0746
        BCHG    D1,(A0)                         ; $2A074A
        DC.W    $0204,$2000         ; $2A074C ANDI.B  #$2000,D4
        BCLR    D1,D0                           ; $2A0750
        BCHG    D1,$04(A0,D0.W)                 ; $2A0752
        MOVE.L  D0,D0                           ; $2A0756
        BCLR    D1,(A0)                         ; $2A0758
        BCHG    D1,-(A0)                        ; $2A075A
        SUBI.B  #$2000,D4                       ; $2A075C
        BCLR    D1,-$60(A0,D0.W)                ; $2A0760
        SUBI.B  #$2000,D4                       ; $2A0764
        ANDI.W  #$0280,(A0)                     ; $2A0768
        DC.W    $0012,$7900         ; $2A076C ORI.B  #$7900,(A2)
        DC.W    $0000,$0010         ; $2A0770 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A0774 ORI.B  #$0030,-(A0)
        DC.W    $0012,$7900         ; $2A0778 ORI.B  #$7900,(A2)
        ORI.W  #$0050,D0                        ; $2A077C
        ORI.W  #$0070,-(A0)                     ; $2A0780
        DC.W    $0012,$7900         ; $2A0784 ORI.B  #$7900,(A2)
        ORI.L  #$009000A0,D0                    ; $2A0788
        DC.W    $00B0,$0012,$7900,$00C0; $2A078E ORI.L  #$00127900,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A0796 DC.W    $00D0
        DC.W    $00E0               ; $2A0798 DC.W    $00E0
        DC.W    $00F0               ; $2A079A DC.W    $00F0
        DC.W    $0012,$7900         ; $2A079C ORI.B  #$7900,(A2)
        BTST    D0,D0                           ; $2A07A0
        BTST    D0,(A0)                         ; $2A07A2
        BTST    D0,-(A0)                        ; $2A07A4
        BTST    D0,$12(A0,D0.W)                 ; $2A07A6
        MOVE.W  D0,-(A4)                        ; $2A07AA
        BCHG    D0,D0                           ; $2A07AC
        BCHG    D0,(A0)                         ; $2A07AE
        BCHG    D0,-(A0)                        ; $2A07B0
        BCHG    D0,$12(A0,D0.W)                 ; $2A07B2
        MOVE.W  D0,-(A4)                        ; $2A07B6
        BCLR    D0,D0                           ; $2A07B8
        BCLR    D0,(A0)                         ; $2A07BA
        BCLR    D0,-(A0)                        ; $2A07BC
        BCLR    D0,$12(A0,D0.W)                 ; $2A07BE
        MOVE.W  D0,-(A4)                        ; $2A07C2
        BSET    D0,D0                           ; $2A07C4
        BSET    D0,(A0)                         ; $2A07C6
        BSET    D0,-(A0)                        ; $2A07C8
        BSET    D0,$12(A0,D0.W)                 ; $2A07CA
        MOVE.W  D0,-(A4)                        ; $2A07CE
        DC.W    $0200,$0210         ; $2A07D0 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2A07D4 ANDI.B  #$0230,-(A0)
        DC.W    $0004,$2000         ; $2A07D8 ORI.B  #$2000,D4
        ANDI.W  #$0250,D0                       ; $2A07DC
        ANDI.W  #$0270,-(A0)                    ; $2A07E0
        DC.W    $0004,$2000         ; $2A07E4 ORI.B  #$2000,D4
        ANDI.L  #$029002A0,D0                   ; $2A07E8
        DC.W    $02B0,$0004,$2000,$02C0; $2A07EE ANDI.L  #$00042000,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A07F6 DC.W    $02D0
        DC.W    $02E0               ; $2A07F8 DC.W    $02E0
        DC.W    $02F0               ; $2A07FA DC.W    $02F0
        DC.W    $0004,$2000         ; $2A07FC ORI.B  #$2000,D4
        BTST    D1,D0                           ; $2A0800
        BTST    D1,(A0)                         ; $2A0802
        BTST    D1,-(A0)                        ; $2A0804
        BTST    D1,$00(A0,D0.W)                 ; $2A0806
        BTST    D2,D0                           ; $2A080A
        BSET    D1,D0                           ; $2A080C
        BSET    D1,(A0)                         ; $2A080E
        BSET    D1,-(A0)                        ; $2A0810
        BSET    D1,$00(A0,D0.W)                 ; $2A0812
        BTST    D2,D0                           ; $2A0816
        SUBI.B  #$0410,D0                       ; $2A0818
        SUBI.B  #$0430,-(A0)                    ; $2A081C
        CMPI.B  #$0044,D0                       ; $2A0820
        ORI.W  #$0C36,D4                        ; $2A0824
        MOVE.W  -$27(PC,A7.W),$0C36(A6)         ; $2A0828
        MOVEA.W A0,A3                           ; $2A082E
        MOVE.W  (A1)+,$0EBC3648                 ; $2A0830
        DC.W    $F3FC,$0EBC,$3D7B,$F3FC; $2A0836 MOVE.W  #$0EBC,$3D7BF3FC
        BCHG    D1,$377B(A2)                    ; $2A083E
        MOVE.W  (A2),(A2)                       ; $2A0842
        BCHG    D1,$3515(A2)                    ; $2A0844
        MOVE.W  (A2),(A2)                       ; $2A0848
        DC.W    $0EBC               ; $2A084A DC.W    $0EBC
        MOVE.W  (A5),-(A2)                      ; $2A084C
        DC.W    $F3FC,$0EBC,$377B,$F3FC; $2A084E MOVE.W  #$0EBC,$377BF3FC
        BCHG    D1,$3EAF(A2)                    ; $2A0856
        MOVE.W  (A2),(A2)                       ; $2A085A
        BCHG    D1,$3C48(A2)                    ; $2A085C
        MOVE.W  (A2),(A2)                       ; $2A0860
        DC.W    $0EBC               ; $2A0862 DC.W    $0EBC
        MOVEA.W A0,A6                           ; $2A0864
        DC.W    $F3FC,$0EBC,$3EAF,$F3FC; $2A0866 MOVE.W  #$0EBC,$3EAFF3FC
        DC.W    $022E,$3EAF,$F4D2   ; $2A086E ANDI.B  #$3EAF,-$0B2E(A6)
        DC.W    $022E,$3048,$F4D2   ; $2A0874 ANDI.B  #$3048,-$0B2E(A6)
        DC.W    $04A8,$3048,$F45A,$04A8; $2A087A SUBI.L  #$3048F45A,$04A8(A0)
        MOVE.W  -$0BA6(A7),(A7)                 ; $2A0882
        ROXL.W  -(A4)                           ; $2A0886
        MOVE.W  -$043A(A7),(A1)                 ; $2A0888
        ROXL.W  -(A4)                           ; $2A088C
        MOVEA.W A0,A0                           ; $2A088E
        DC.W    $FBC6               ; $2A0890 MOVE.W  D6,<EA:3D>
        DC.W    $F87F               ; $2A0892 MOVEA.W <EA:3F>,A4
        MOVEA.W A0,A0                           ; $2A0894
        MOVE.W  $7F(A2,A7.L),-$51(A3,D3.W)      ; $2A0896
        MOVE.W  -$1C(A2,A6.L),-$51(A3,D3.L)     ; $2A089C
        DC.W    $FBC6               ; $2A08A2 MOVE.W  D6,<EA:3D>
        ROXL.W  -(A4)                           ; $2A08A4
        MOVEA.W A0,A6                           ; $2A08A6
        DC.W    $FBC6               ; $2A08A8 MOVE.W  D6,<EA:3D>
        DC.W    $F87F               ; $2A08AA MOVEA.W <EA:3F>,A4
        MOVEA.W A0,A6                           ; $2A08AC
        MOVE.W  $7F(A2,A7.L),-$51(A3,D3.L)      ; $2A08AE
        MOVE.W  -$49(A2,A6.L),-$51(A3,D3.L)     ; $2A08B4
        DC.W    $FC3D               ; $2A08BA MOVE.W  <EA:3D>,D6
        ROXR.L  D6,D7                           ; $2A08BC
        MOVEA.W A0,A0                           ; $2A08BE
        DC.W    $FC3D               ; $2A08C0 MOVE.W  <EA:3D>,D6
        ROXL.B  #7,D1                           ; $2A08C2
        MOVEA.W A0,A0                           ; $2A08C4
        MOVE.W  (A0),-$10EF(A5)                 ; $2A08C6
        MOVE.W  -$04B0(A7),(A7)                 ; $2A08CA
        MOVE.W  -(A3),(A5)+                     ; $2A08CE
        MOVE.W  -$0922(A7),(A1)                 ; $2A08D0
        MOVE.W  -(A3),(A5)+                     ; $2A08D4
        MOVEA.W A0,A0                           ; $2A08D6
        MOVE.W  (A6)+,(A3)+                     ; $2A08D8
        MOVE.W  A3,$3048(A6)                    ; $2A08DA
        MOVE.W  (A2)+,D3                        ; $2A08DE
        MOVE.W  A3,$32AF(A6)                    ; $2A08E0
        MOVE.W  (A2)+,D3                        ; $2A08E4
        DC.W    $113E               ; $2A08E6 MOVE.B  <EA:3E>,-(A0)
        MOVE.W  -$0BBE(A7),(A1)                 ; $2A08E8
        DC.W    $113E               ; $2A08EC MOVE.B  <EA:3E>,-(A0)
        MOVEA.W A0,A0                           ; $2A08EE
        MOVEA.W D2,A2                           ; $2A08F0
        DC.W    $13BD,$3048         ; $2A08F2 MOVE.B  <EA:3D>,$48(A1,D3.W)
        MOVE.W  -(A6),(A2)                      ; $2A08F6
        DC.W    $13BD,$32AF         ; $2A08F8 MOVE.B  <EA:3D>,-$51(A1,D3.W)
        MOVE.W  -(A6),(A2)                      ; $2A08FC
        MOVE.W  (A7),$317B(A6)                  ; $2A08FE
        MOVE.W  D4,-(A7)                        ; $2A0902
        MOVE.W  (A7),$2D7B(A6)                  ; $2A0904
        MOVE.W  D4,-(A7)                        ; $2A0908
        SEQ     $7B(A0,D2.L)                    ; $2A090A
        DC.W    $0000,$57F0         ; $2A090E ORI.B  #$57F0,D0
        MOVE.W  $00(PC,D0.W),$3D57(A0)          ; $2A0912
        DC.W    $417B               ; $2A0918 DC.W    $417B
        MOVE.W  D4,-(A7)                        ; $2A091A
        MOVE.W  (A7),$3D7B(A6)                  ; $2A091C
        MOVE.W  D4,-(A7)                        ; $2A0920
        SEQ     $7B(A0,D3.L)                    ; $2A0922
        DC.W    $0000,$57F0         ; $2A0926 ORI.B  #$57F0,D0
        DC.W    $417B               ; $2A092A DC.W    $417B
        DC.W    $0000,$A7FF         ; $2A092C ORI.B  #$A7FF,D0
        MOVE.W  -$01(PC,A7.L),-$5801(A0)        ; $2A0930
        MOVE.L  -$01(PC,A7.L),-$3D35(A6)        ; $2A0936
        MOVE.L  $4F(PC,D0.W),-$3D35(A6)         ; $2A093C
        MOVE.W  $4F(PC,D0.W),-$5801(A0)         ; $2A0942
        DC.W    $417B               ; $2A0948 DC.W    $417B
        DC.W    $FFFF               ; $2A094A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $A7FF,$3D7B         ; $2A094C MOVE.L  <EA:3F>,$7B(PC,D3.L)
        DC.W    $FFFF               ; $2A0950 MOVE.W  <EA:3F>,<EA:3F>
        MULU    A3,D1                           ; $2A0952
        MOVE.W  $4F(PC,D0.W),-$3D35(A6)         ; $2A0954
        DC.W    $417B               ; $2A095A DC.W    $417B
        DC.W    $034F               ; $2A095C BCHG    D1,A7
        ADD.W  (A7),D1                          ; $2A095E
        DC.W    $417B               ; $2A0960 DC.W    $417B
        BTST    D1,$57(A7,A5.W)                 ; $2A0962
        MOVE.L  $37(PC,D0.W),$1637(A6)          ; $2A0966
        DC.W    $417B               ; $2A096C DC.W    $417B
        MOVE.W  -(A4),-(A2)                     ; $2A096E
        ROR.W  #5,D5                            ; $2A0970
        DC.W    $417B               ; $2A0972 DC.W    $417B
        MOVE.W  -(A5),-(A6)                     ; $2A0974
        ROR.W  #5,D5                            ; $2A0976
        MOVE.L  $25(PC,A7.L),$1637(A6)          ; $2A0978
        MOVE.L  $24(PC,A7.W),$2E0F(A6)          ; $2A097E
        DC.W    $417B               ; $2A0984 DC.W    $417B
        MOVE.W  $2E0F(A1),D6                    ; $2A0986
        MOVE.L  $29(PC,A7.L),$57EE(A6)          ; $2A098A
        CLR.B  D0                               ; $2A0990
        DC.W    $0000,$57EE         ; $2A0992 ORI.B  #$57EE,D0
        DC.W    $0000,$0000         ; $2A0996 ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A099A
        DC.W    $0000,$0000         ; $2A099C ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A09A0
        CLR.B  D0                               ; $2A09A2
        DC.W    $0000,$A4CE         ; $2A09A4 ORI.B  #$A4CE,D0
        CLR.B  D0                               ; $2A09A8
        DC.W    $0000,$A4CE         ; $2A09AA ORI.B  #$A4CE,D0
        DC.W    $0000,$0000         ; $2A09AE ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A09B2
        DC.W    $0000,$0000         ; $2A09B4 ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A09B8
        CLR.B  D0                               ; $2A09BA
        DC.W    $0000,$0004         ; $2A09BC ORI.B  #$0004,D0
        MOVE.L  D0,D0                           ; $2A09C0
        BCHG    D1,D0                           ; $2A09C2
        BTST    D1,-$20(A0,D0.W)                ; $2A09C4
        BCHG    D1,(A0)                         ; $2A09C8
        DC.W    $0204,$2000         ; $2A09CA ANDI.B  #$2000,D4
        BCLR    D1,D0                           ; $2A09CE
        BCHG    D1,$04(A0,D0.W)                 ; $2A09D0
        MOVE.L  D0,D0                           ; $2A09D4
        BCLR    D1,(A0)                         ; $2A09D6
        BCHG    D1,-(A0)                        ; $2A09D8
        SUBI.B  #$2000,D4                       ; $2A09DA
        BCLR    D1,-$60(A0,D0.W)                ; $2A09DE
        SUBI.B  #$2000,D4                       ; $2A09E2
        ANDI.W  #$0280,(A0)                     ; $2A09E6
        DC.W    $0012,$7900         ; $2A09EA ORI.B  #$7900,(A2)
        DC.W    $0000,$0010         ; $2A09EE ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A09F2 ORI.B  #$0030,-(A0)
        DC.W    $0012,$7900         ; $2A09F6 ORI.B  #$7900,(A2)
        ORI.W  #$0050,D0                        ; $2A09FA
        ORI.W  #$0070,-(A0)                     ; $2A09FE
        DC.W    $0012,$7900         ; $2A0A02 ORI.B  #$7900,(A2)
        ORI.L  #$009000A0,D0                    ; $2A0A06
        DC.W    $00B0,$0012,$7900,$00C0; $2A0A0C ORI.L  #$00127900,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A0A14 DC.W    $00D0
        DC.W    $00E0               ; $2A0A16 DC.W    $00E0
        DC.W    $00F0               ; $2A0A18 DC.W    $00F0
        DC.W    $0012,$7900         ; $2A0A1A ORI.B  #$7900,(A2)
        BTST    D0,D0                           ; $2A0A1E
        BTST    D0,(A0)                         ; $2A0A20
        BTST    D0,-(A0)                        ; $2A0A22
        BTST    D0,$12(A0,D0.W)                 ; $2A0A24
        MOVE.W  D0,-(A4)                        ; $2A0A28
        BCHG    D0,D0                           ; $2A0A2A
        BCHG    D0,(A0)                         ; $2A0A2C
        BCHG    D0,-(A0)                        ; $2A0A2E
        BCHG    D0,$12(A0,D0.W)                 ; $2A0A30
        MOVE.W  D0,-(A4)                        ; $2A0A34
        BCLR    D0,D0                           ; $2A0A36
        BCLR    D0,(A0)                         ; $2A0A38
        BCLR    D0,-(A0)                        ; $2A0A3A
        BCLR    D0,$12(A0,D0.W)                 ; $2A0A3C
        MOVE.W  D0,-(A4)                        ; $2A0A40
        BSET    D0,D0                           ; $2A0A42
        BSET    D0,(A0)                         ; $2A0A44
        BSET    D0,-(A0)                        ; $2A0A46
        BSET    D0,$12(A0,D0.W)                 ; $2A0A48
        MOVE.W  D0,-(A4)                        ; $2A0A4C
        DC.W    $0200,$0210         ; $2A0A4E ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2A0A52 ANDI.B  #$0230,-(A0)
        DC.W    $0004,$2000         ; $2A0A56 ORI.B  #$2000,D4
        ANDI.W  #$0250,D0                       ; $2A0A5A
        ANDI.W  #$0270,-(A0)                    ; $2A0A5E
        DC.W    $0004,$2000         ; $2A0A62 ORI.B  #$2000,D4
        ANDI.L  #$029002A0,D0                   ; $2A0A66
        DC.W    $02B0,$0004,$2000,$02C0; $2A0A6C ANDI.L  #$00042000,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A0A74 DC.W    $02D0
        DC.W    $02E0               ; $2A0A76 DC.W    $02E0
        DC.W    $02F0               ; $2A0A78 DC.W    $02F0
        DC.W    $0004,$2000         ; $2A0A7A ORI.B  #$2000,D4
        BTST    D1,D0                           ; $2A0A7E
        BTST    D1,(A0)                         ; $2A0A80
        BTST    D1,-(A0)                        ; $2A0A82
        BTST    D1,$00(A0,D0.W)                 ; $2A0A84
        BTST    D2,D0                           ; $2A0A88
        BSET    D1,D0                           ; $2A0A8A
        BSET    D1,(A0)                         ; $2A0A8C
        BSET    D1,-(A0)                        ; $2A0A8E
        BSET    D1,$00(A0,D0.W)                 ; $2A0A90
        BTST    D2,D0                           ; $2A0A94
        SUBI.B  #$0410,D0                       ; $2A0A96
        SUBI.B  #$0430,-(A0)                    ; $2A0A9A
        CMPI.B  #$0044,D0                       ; $2A0A9E
        ORI.W  #$0BAF,D4                        ; $2A0AA2
        MOVE.W  $26(PC,A7.L),$0BAF(A6)          ; $2A0AA6
        MOVEA.W A0,A3                           ; $2A0AAC
        MOVE.W  -(A6),D6                        ; $2A0AAE
        DC.W    $0E19               ; $2A0AB0 DC.W    $0E19
        MOVEA.W A0,A3                           ; $2A0AB2
        MOVE.W  (A5)+,(A6)+                     ; $2A0AB4
        DC.W    $0E19               ; $2A0AB6 DC.W    $0E19
        MOVE.W  -$23(PC,A7.L),$033F(A6)         ; $2A0AB8
        MOVE.W  -$62(PC,A7.L),$033F(A3)         ; $2A0ABE
        MOVE.W  (A5),-(A2)                      ; $2A0AC4
        MOVE.W  (A6)+,$19(A4,D0.L)              ; $2A0AC6
        MOVE.W  (A5),-(A2)                      ; $2A0ACA
        MOVE.W  (A5)+,(A6)+                     ; $2A0ACC
        DC.W    $0E19               ; $2A0ACE DC.W    $0E19
        MOVE.W  -$23(PC,A7.L),$033F(A3)         ; $2A0AD0
        MOVE.W  -$0662(A7),(A7)                 ; $2A0AD6
        DC.W    $033F               ; $2A0ADA BTST    D1,<EA:3F>
        MOVEA.W A0,A6                           ; $2A0ADC
        MOVE.W  (A6)+,$19(A4,D0.L)              ; $2A0ADE
        MOVEA.W A0,A6                           ; $2A0AE2
        MOVE.W  (A5)+,(A6)+                     ; $2A0AE4
        DC.W    $0E19               ; $2A0AE6 DC.W    $0E19
        MOVE.W  -$0323(A7),(A7)                 ; $2A0AE8
        DC.W    $020B,$3EAF         ; $2A0AEC ANDI.B  #$3EAF,A3
        MOVE.W  D2,$020B(A4)                    ; $2A0AF0
        MOVEA.W A0,A0                           ; $2A0AF4
        MOVE.W  D2,$0474(A4)                    ; $2A0AF6
        MOVEA.W A0,A0                           ; $2A0AFA
        MOVE.W  $0474(PC),#$3EAF                ; $2A0AFC
        MOVE.W  -$12B4(PC),#$32AF               ; $2A0B02
        MOVEA.W -(A3),A2                        ; $2A0B08
        LSL.W  #6,D4                            ; $2A0B0A
        MOVEA.W A0,A0                           ; $2A0B0C
        MOVEA.W -(A3),A2                        ; $2A0B0E
        MOVEA.W (A5)+,A4                        ; $2A0B10
        MOVEA.W A0,A0                           ; $2A0B12
        MOVE.W  A0,(A3)+                        ; $2A0B14
        MOVEA.W (A5)+,A4                        ; $2A0B16
        MOVE.W  -$0938(A7),(A1)                 ; $2A0B18
        LSL.W  #6,D4                            ; $2A0B1C
        MOVE.W  -$0B9D(A7),(A7)                 ; $2A0B1E
        LSL.W  #6,D4                            ; $2A0B22
        MOVEA.W A0,A6                           ; $2A0B24
        MOVEA.W -(A3),A2                        ; $2A0B26
        MOVEA.W (A5)+,A4                        ; $2A0B28
        MOVEA.W A0,A6                           ; $2A0B2A
        MOVE.W  A0,(A3)+                        ; $2A0B2C
        MOVEA.W (A5)+,A4                        ; $2A0B2E
        MOVE.W  -$0938(A7),(A7)                 ; $2A0B30
        LSR.B  #6,D6                            ; $2A0B34
        MOVE.W  -$0BCC(A7),(A7)                 ; $2A0B36
        LSR.B  #6,D6                            ; $2A0B3A
        MOVEA.W A0,A0                           ; $2A0B3C
        MOVE.W  -$76(A4,A6.L),D2                ; $2A0B3E
        MOVEA.W A0,A0                           ; $2A0B42
        MOVE.W  (A7),(A2)                       ; $2A0B44
        LSR.L  #7,D2                            ; $2A0B46
        MOVE.W  -$0B69(A7),(A7)                 ; $2A0B48
        MOVE.W  A2,(A5)+                        ; $2A0B4C
        MOVE.W  -$0890(A7),(A1)                 ; $2A0B4E
        MOVE.W  A2,(A5)+                        ; $2A0B52
        MOVEA.W A0,A0                           ; $2A0B54
        MOVE.W  $37(A0,A7.L),$3048(A3)          ; $2A0B56
        MOVE.W  (A5)+,D4                        ; $2A0B5C
        MOVE.W  -$51(A7,D3.W),-(A6)             ; $2A0B5E
        MOVE.W  (A5)+,D4                        ; $2A0B62
        MOVE.B  D4,(A0)                         ; $2A0B64
        MOVE.W  -$029A(A7),(A1)                 ; $2A0B66
        MOVE.B  D4,(A0)                         ; $2A0B6A
        MOVEA.W A0,A0                           ; $2A0B6C
        MOVE.W  -(A6),$12F0(A6)                 ; $2A0B6E
        MOVEA.W A0,A0                           ; $2A0B72
        MOVE.W  (A4),D7                         ; $2A0B74
        MOVE.B  -$51(A0,D3.W),(A1)+             ; $2A0B76
        MOVE.W  (A4),D7                         ; $2A0B7A
        MOVE.W  $317B0348,-(A6)                 ; $2A0B7C
        MOVE.W  $2D7B0348,-(A6)                 ; $2A0B82
        SEQ     $7B(A0,D2.L)                    ; $2A0B88
        DC.W    $0000,$57F0         ; $2A0B8C ORI.B  #$57F0,D0
        MOVE.W  $00(PC,D0.W),$3D39(A0)          ; $2A0B90
        DC.W    $417B               ; $2A0B96 DC.W    $417B
        DC.W    $0348               ; $2A0B98 BCHG    D1,A0
        MOVE.W  $3D7B0348,-(A6)                 ; $2A0B9A
        SEQ     $7B(A0,D3.L)                    ; $2A0BA0
        DC.W    $0000,$57F0         ; $2A0BA4 ORI.B  #$57F0,D0
        DC.W    $417B               ; $2A0BA8 DC.W    $417B
        DC.W    $0000,$A7FF         ; $2A0BAA ORI.B  #$A7FF,D0
        MOVE.W  -$01(PC,A7.L),-$5801(A0)        ; $2A0BAE
        MOVE.L  -$01(PC,A7.L),-$3D45(A6)        ; $2A0BB4
        MOVE.L  -$2D(PC,A7.L),-$3D45(A6)        ; $2A0BBA
        MOVE.W  -$2D(PC,A7.L),-$5801(A0)        ; $2A0BC0
        DC.W    $417B               ; $2A0BC6 DC.W    $417B
        DC.W    $FFFF               ; $2A0BC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $A7FF,$3D7B         ; $2A0BCA MOVE.L  <EA:3F>,$7B(PC,D3.L)
        DC.W    $FFFF               ; $2A0BCE MOVE.W  <EA:3F>,<EA:3F>
        AND.L  $7B(PC,D3.L),D1                  ; $2A0BD0
        MOVE.W  (A3),(A6)+                      ; $2A0BD4
        AND.L  $7B(PC,D4.W),D1                  ; $2A0BD6
        MOVE.W  (A3),(A6)+                      ; $2A0BDA
        ADD.W  D0,D3                            ; $2A0BDC
        DC.W    $417B               ; $2A0BDE DC.W    $417B
        MOVE.W  $43(A0,A5.W),$2D7B(A3)          ; $2A0BE0
        MOVE.W  $5D(A0,D1.W),$417B(A3)          ; $2A0BE6
        MOVE.W  -$1671(A4),-(A7)                ; $2A0BEC
        DC.W    $417B               ; $2A0BF0 DC.W    $417B
        DC.W    $F3E9,$E98F,$2D7B,$F3E9; $2A0BF2 MOVE.W  -$1671(A1),$2D7BF3E9
        MOVE.B  (A5)+,$2D7B(A2)                 ; $2A0BFA
        MOVE.W  $2DBB(A4),-(A7)                 ; $2A0BFE
        DC.W    $417B               ; $2A0C02 DC.W    $417B
        BCHG    D1,(A1)+                        ; $2A0C04
        MOVE.L  $7B(PC,D2.L),$59(A6,D0.W)       ; $2A0C06
        SEQ     $4200(A6)                       ; $2A0C0C
        DC.W    $0000,$57EE         ; $2A0C10 ORI.B  #$57EE,D0
        DC.W    $0000,$0000         ; $2A0C14 ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A0C18
        DC.W    $0000,$0000         ; $2A0C1A ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A0C1E
        CLR.B  D0                               ; $2A0C20
        DC.W    $0000,$A4CE         ; $2A0C22 ORI.B  #$A4CE,D0
        CLR.B  D0                               ; $2A0C26
        DC.W    $0000,$A4CE         ; $2A0C28 ORI.B  #$A4CE,D0
        DC.W    $0000,$0000         ; $2A0C2C ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A0C30
        DC.W    $0000,$0000         ; $2A0C32 ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A0C36
        CLR.B  D0                               ; $2A0C38
        DC.W    $0000,$0004         ; $2A0C3A ORI.B  #$0004,D0
        MOVE.L  D0,D0                           ; $2A0C3E
        BCHG    D1,D0                           ; $2A0C40
        BTST    D1,-$20(A0,D0.W)                ; $2A0C42
        BCHG    D1,(A0)                         ; $2A0C46
        DC.W    $0204,$2000         ; $2A0C48 ANDI.B  #$2000,D4
        BCLR    D1,D0                           ; $2A0C4C
        BCHG    D1,$04(A0,D0.W)                 ; $2A0C4E
        MOVE.L  D0,D0                           ; $2A0C52
        BCLR    D1,(A0)                         ; $2A0C54
        BCHG    D1,-(A0)                        ; $2A0C56
        SUBI.B  #$2000,D4                       ; $2A0C58
        BCLR    D1,-$60(A0,D0.W)                ; $2A0C5C
        SUBI.B  #$2000,D4                       ; $2A0C60
        ANDI.W  #$0280,(A0)                     ; $2A0C64
        DC.W    $0012,$7900         ; $2A0C68 ORI.B  #$7900,(A2)
        DC.W    $0000,$0010         ; $2A0C6C ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A0C70 ORI.B  #$0030,-(A0)
        DC.W    $0012,$7900         ; $2A0C74 ORI.B  #$7900,(A2)
        ORI.W  #$0050,D0                        ; $2A0C78
        ORI.W  #$0070,-(A0)                     ; $2A0C7C
        DC.W    $0012,$7900         ; $2A0C80 ORI.B  #$7900,(A2)
        ORI.L  #$009000A0,D0                    ; $2A0C84
        DC.W    $00B0,$0012,$7900,$00C0; $2A0C8A ORI.L  #$00127900,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A0C92 DC.W    $00D0
        DC.W    $00E0               ; $2A0C94 DC.W    $00E0
        DC.W    $00F0               ; $2A0C96 DC.W    $00F0
        DC.W    $0012,$7900         ; $2A0C98 ORI.B  #$7900,(A2)
        BTST    D0,D0                           ; $2A0C9C
        BTST    D0,(A0)                         ; $2A0C9E
        BTST    D0,-(A0)                        ; $2A0CA0
        BTST    D0,$12(A0,D0.W)                 ; $2A0CA2
        MOVE.W  D0,-(A4)                        ; $2A0CA6
        BCHG    D0,D0                           ; $2A0CA8
        BCHG    D0,(A0)                         ; $2A0CAA
        BCHG    D0,-(A0)                        ; $2A0CAC
        BCHG    D0,$12(A0,D0.W)                 ; $2A0CAE
        MOVE.W  D0,-(A4)                        ; $2A0CB2
        BCLR    D0,D0                           ; $2A0CB4
        BCLR    D0,(A0)                         ; $2A0CB6
        BCLR    D0,-(A0)                        ; $2A0CB8
        BCLR    D0,$12(A0,D0.W)                 ; $2A0CBA
        MOVE.W  D0,-(A4)                        ; $2A0CBE
        BSET    D0,D0                           ; $2A0CC0
        BSET    D0,(A0)                         ; $2A0CC2
        BSET    D0,-(A0)                        ; $2A0CC4
        BSET    D0,$12(A0,D0.W)                 ; $2A0CC6
        MOVE.W  D0,-(A4)                        ; $2A0CCA
        DC.W    $0200,$0210         ; $2A0CCC ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2A0CD0 ANDI.B  #$0230,-(A0)
        DC.W    $0004,$2000         ; $2A0CD4 ORI.B  #$2000,D4
        ANDI.W  #$0250,D0                       ; $2A0CD8
        ANDI.W  #$0270,-(A0)                    ; $2A0CDC
        DC.W    $0004,$2000         ; $2A0CE0 ORI.B  #$2000,D4
        ANDI.L  #$029002A0,D0                   ; $2A0CE4
        DC.W    $02B0,$0004,$2000,$02C0; $2A0CEA ANDI.L  #$00042000,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A0CF2 DC.W    $02D0
        DC.W    $02E0               ; $2A0CF4 DC.W    $02E0
        DC.W    $02F0               ; $2A0CF6 DC.W    $02F0
        DC.W    $0004,$2000         ; $2A0CF8 ORI.B  #$2000,D4
        BTST    D1,D0                           ; $2A0CFC
        BTST    D1,(A0)                         ; $2A0CFE
        BTST    D1,-(A0)                        ; $2A0D00
        BTST    D1,$00(A0,D0.W)                 ; $2A0D02
        BTST    D2,D0                           ; $2A0D06
        BSET    D1,D0                           ; $2A0D08
        BSET    D1,(A0)                         ; $2A0D0A
        BSET    D1,-(A0)                        ; $2A0D0C
        BSET    D1,$00(A0,D0.W)                 ; $2A0D0E
        BTST    D2,D0                           ; $2A0D12
        SUBI.B  #$0410,D0                       ; $2A0D14
        SUBI.B  #$0430,-(A0)                    ; $2A0D18
        CMPI.B  #$0044,D0                       ; $2A0D1C
        ORI.W  #$090E,D4                        ; $2A0D20
        MOVE.W  -$2A(PC,D0.W),$090E(A6)         ; $2A0D24
        MOVEA.W A0,A3                           ; $2A0D2A
        DC.W    $02D6               ; $2A0D2C DC.W    $02D6
        DC.W    $0B89               ; $2A0D2E BCLR    D5,A1
        MOVEA.W A0,A3                           ; $2A0D30
        BCHG    D1,-(A0)                        ; $2A0D32
        DC.W    $0B89               ; $2A0D34 BCLR    D5,A1
        MOVE.W  $60(PC,D0.W),$0070(A6)          ; $2A0D36
        MOVE.W  -$4E(PC,D0.W),$0070(A3)         ; $2A0D3C
        MOVE.W  (A5),-(A2)                      ; $2A0D42
        DC.W    $00B2,$0B89,$3515,$0360; $2A0D44 ORI.L  #$0B893515,$60(A2,D0.W)
        DC.W    $0B89               ; $2A0D4C BCLR    D5,A1
        MOVE.W  $60(PC,D0.W),$0070(A3)          ; $2A0D4E
        MOVE.W  $00B2(A7),(A7)                  ; $2A0D54
        ORI.W  #$3C48,-$4E(A0,D0.W)             ; $2A0D58
        DC.W    $0B89               ; $2A0D5E BCLR    D5,A1
        MOVEA.W A0,A6                           ; $2A0D60
        BCHG    D1,-(A0)                        ; $2A0D62
        DC.W    $0B89               ; $2A0D64 BCLR    D5,A1
        MOVE.W  $0360(A7),(A7)                  ; $2A0D66
        MOVE.W  $3EAF005D,-(A7)                 ; $2A0D6A
        MOVE.W  $3048005D,-(A7)                 ; $2A0D70
        BCLR    D0,$3048(A3)                    ; $2A0D76
        BTST    D0,D6                           ; $2A0D7A
        BCLR    D0,$3EAF(A3)                    ; $2A0D7C
        BTST    D0,D6                           ; $2A0D80
        LSR.L  D5,D1                            ; $2A0D82
        MOVE.W  -$061F(A7),(A1)                 ; $2A0D84
        LSR.L  D5,D1                            ; $2A0D88
        MOVEA.W A0,A0                           ; $2A0D8A
        MOVE.W  -(A1),#$F57E                    ; $2A0D8C
        MOVEA.W A0,A0                           ; $2A0D90
        DC.W    $FD79,$F57E,$32AF,$FD79; $2A0D92 MOVE.W  $F57E32AF,-$0287(A6)
        LSR.L  D5,D1                            ; $2A0D9A
        MOVE.W  -$061F(A7),(A7)                 ; $2A0D9C
        LSR.L  D5,D1                            ; $2A0DA0
        MOVEA.W A0,A6                           ; $2A0DA2
        MOVE.W  -(A1),#$F57E                    ; $2A0DA4
        MOVEA.W A0,A6                           ; $2A0DA8
        DC.W    $FD79,$F57E,$3EAF,$FD79; $2A0DAA MOVE.W  $F57E3EAF,-$0287(A6)
        ROXL.W  D4,D6                           ; $2A0DB2
        MOVE.W  -$0688(A7),(A7)                 ; $2A0DB4
        ROXL.W  D4,D6                           ; $2A0DB8
        MOVEA.W A0,A0                           ; $2A0DBA
        MOVE.W  $EBDE.W,$3048(A4)               ; $2A0DBC
        MOVEA.W A2,A5                           ; $2A0DC2
        LSL.W  (A6)+                            ; $2A0DC4
        MOVE.W  -$05B6(A7),(A7)                 ; $2A0DC6
        MOVE.W  $32AF(A3),$3B(PC,A7.L)          ; $2A0DCA
        MOVE.W  $3048(A3),$3B(PC,A7.L)          ; $2A0DD0
        MOVEA.W (A1)+,A5                        ; $2A0DD6
        MOVEA.W A0,A0                           ; $2A0DD8
        MOVE.W  $59(A7,A7.L),(A7)+              ; $2A0DDA
        MOVE.W  -$0109(A7),(A1)                 ; $2A0DDE
        DC.W    $0E05               ; $2A0DE2 DC.W    $0E05
        MOVE.W  $03E1(A7),(A1)                  ; $2A0DE4
        DC.W    $0E05               ; $2A0DE8 DC.W    $0E05
        MOVEA.W A0,A0                           ; $2A0DEA
        BSET    D1,-(A1)                        ; $2A0DEC
        MOVE.B  D3,(A0)                         ; $2A0DEE
        MOVEA.W A0,A0                           ; $2A0DF0
        SUBI.W  #$1083,(A1)+                    ; $2A0DF2
        MOVE.W  $0459(A7),(A1)                  ; $2A0DF6
        MOVE.W  -(A6),$317B(A5)                 ; $2A0DFA
        ADDI.W  #$3B66,D7                       ; $2A0DFE
        MOVE.L  $47(PC,D0.W),$57F0(A6)          ; $2A0E02
        MOVE.L  $00(PC,D0.W),$57F0(A6)          ; $2A0E08
        MOVE.W  $00(PC,D0.W),$3B66(A0)          ; $2A0E0E
        DC.W    $417B               ; $2A0E14 DC.W    $417B
        ADDI.W  #$3B66,D7                       ; $2A0E16
        MOVE.W  $47(PC,D0.W),$57F0(A6)          ; $2A0E1A
        MOVE.W  $00(PC,D0.W),$57F0(A6)          ; $2A0E20
        DC.W    $417B               ; $2A0E26 DC.W    $417B
        DC.W    $0000,$A7FF         ; $2A0E28 ORI.B  #$A7FF,D0
        MOVE.W  -$01(PC,A7.L),-$5801(A0)        ; $2A0E2C
        MOVE.L  -$01(PC,A7.L),-$4074(A6)        ; $2A0E32
        MOVE.L  -$76(PC,A7.W),-$4074(A6)        ; $2A0E38
        MOVE.W  -$76(PC,A7.W),-$5801(A0)        ; $2A0E3E
        DC.W    $417B               ; $2A0E44 DC.W    $417B
        DC.W    $FFFF               ; $2A0E46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $A7FF,$3D7B         ; $2A0E48 MOVE.L  <EA:3F>,$7B(PC,D3.L)
        DC.W    $FFFF               ; $2A0E4C MOVE.W  <EA:3F>,<EA:3F>
        EOR.L  D7,A4                            ; $2A0E4E
        MOVE.W  -$76(PC,A7.W),-$4074(A6)        ; $2A0E50
        DC.W    $417B               ; $2A0E56 DC.W    $417B
        MOVE.W  A2,$10(A1,A4.L)                 ; $2A0E58
        DC.W    $417B               ; $2A0E5C DC.W    $417B
        MOVE.W  (A5)+,-$30F0(A1)                ; $2A0E5E
        MOVE.L  $5D(PC,A7.W),$1302(A6)          ; $2A0E62
        DC.W    $417B               ; $2A0E68 DC.W    $417B
        DC.W    $063C,$E711,$417B   ; $2A0E6A ADDI.B  #$E711,#$417B
        MOVE.W  (A5)+,D5                        ; $2A0E70
        ROXL.B  #3,D1                           ; $2A0E72
        MOVE.L  $1D(PC,A7.L),$1302(A6)          ; $2A0E74
        MOVE.L  $3C(PC,D0.W),$2BDF(A6)          ; $2A0E7A
        DC.W    $417B               ; $2A0E80 DC.W    $417B
        BSET    D3,-(A7)                        ; $2A0E82
        DC.W    $2BDF               ; $2A0E84 MOVE.L  (A7)+,<EA:3D>
        MOVE.L  -$19(PC,D0.W),$57EE(A6)         ; $2A0E86
        CLR.B  D0                               ; $2A0E8C
        DC.W    $0000,$57EE         ; $2A0E8E ORI.B  #$57EE,D0
        DC.W    $0000,$0000         ; $2A0E92 ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A0E96
        DC.W    $0000,$0000         ; $2A0E98 ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A0E9C
        CLR.B  D0                               ; $2A0E9E
        DC.W    $0000,$A4CE         ; $2A0EA0 ORI.B  #$A4CE,D0
        CLR.B  D0                               ; $2A0EA4
        DC.W    $0000,$A4CE         ; $2A0EA6 ORI.B  #$A4CE,D0
        DC.W    $0000,$0000         ; $2A0EAA ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A0EAE
        DC.W    $0000,$0000         ; $2A0EB0 ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A0EB4
        CLR.B  D0                               ; $2A0EB6
        DC.W    $0000,$0004         ; $2A0EB8 ORI.B  #$0004,D0
        MOVE.L  D0,D0                           ; $2A0EBC
        BCHG    D1,D0                           ; $2A0EBE
        BTST    D1,-$20(A0,D0.W)                ; $2A0EC0
        BCHG    D1,(A0)                         ; $2A0EC4
        DC.W    $0204,$2000         ; $2A0EC6 ANDI.B  #$2000,D4
        BCLR    D1,D0                           ; $2A0ECA
        BCHG    D1,$04(A0,D0.W)                 ; $2A0ECC
        MOVE.L  D0,D0                           ; $2A0ED0
        BCLR    D1,(A0)                         ; $2A0ED2
        BCHG    D1,-(A0)                        ; $2A0ED4
        SUBI.B  #$2000,D4                       ; $2A0ED6
        BCLR    D1,-$60(A0,D0.W)                ; $2A0EDA
        SUBI.B  #$2000,D4                       ; $2A0EDE
        ANDI.W  #$0280,(A0)                     ; $2A0EE2
        DC.W    $0012,$7900         ; $2A0EE6 ORI.B  #$7900,(A2)
        DC.W    $0000,$0010         ; $2A0EEA ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A0EEE ORI.B  #$0030,-(A0)
        DC.W    $0012,$7900         ; $2A0EF2 ORI.B  #$7900,(A2)
        ORI.W  #$0050,D0                        ; $2A0EF6
        ORI.W  #$0070,-(A0)                     ; $2A0EFA
        DC.W    $0012,$7900         ; $2A0EFE ORI.B  #$7900,(A2)
        ORI.L  #$009000A0,D0                    ; $2A0F02
        DC.W    $00B0,$0012,$7900,$00C0; $2A0F08 ORI.L  #$00127900,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A0F10 DC.W    $00D0
        DC.W    $00E0               ; $2A0F12 DC.W    $00E0
        DC.W    $00F0               ; $2A0F14 DC.W    $00F0
        DC.W    $0012,$7900         ; $2A0F16 ORI.B  #$7900,(A2)
        BTST    D0,D0                           ; $2A0F1A
        BTST    D0,(A0)                         ; $2A0F1C
        BTST    D0,-(A0)                        ; $2A0F1E
        BTST    D0,$12(A0,D0.W)                 ; $2A0F20
        MOVE.W  D0,-(A4)                        ; $2A0F24
        BCHG    D0,D0                           ; $2A0F26
        BCHG    D0,(A0)                         ; $2A0F28
        BCHG    D0,-(A0)                        ; $2A0F2A
        BCHG    D0,$12(A0,D0.W)                 ; $2A0F2C
        MOVE.W  D0,-(A4)                        ; $2A0F30
        BCLR    D0,D0                           ; $2A0F32
        BCLR    D0,(A0)                         ; $2A0F34
        BCLR    D0,-(A0)                        ; $2A0F36
        BCLR    D0,$12(A0,D0.W)                 ; $2A0F38
        MOVE.W  D0,-(A4)                        ; $2A0F3C
        BSET    D0,D0                           ; $2A0F3E
        BSET    D0,(A0)                         ; $2A0F40
        BSET    D0,-(A0)                        ; $2A0F42
        BSET    D0,$12(A0,D0.W)                 ; $2A0F44
        MOVE.W  D0,-(A4)                        ; $2A0F48
        DC.W    $0200,$0210         ; $2A0F4A ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2A0F4E ANDI.B  #$0230,-(A0)
        DC.W    $0004,$2000         ; $2A0F52 ORI.B  #$2000,D4
        ANDI.W  #$0250,D0                       ; $2A0F56
        ANDI.W  #$0270,-(A0)                    ; $2A0F5A
        DC.W    $0004,$2000         ; $2A0F5E ORI.B  #$2000,D4
        ANDI.L  #$029002A0,D0                   ; $2A0F62
        DC.W    $02B0,$0004,$2000,$02C0; $2A0F68 ANDI.L  #$00042000,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A0F70 DC.W    $02D0
        DC.W    $02E0               ; $2A0F72 DC.W    $02E0
        DC.W    $02F0               ; $2A0F74 DC.W    $02F0
        DC.W    $0004,$2000         ; $2A0F76 ORI.B  #$2000,D4
        BTST    D1,D0                           ; $2A0F7A
        BTST    D1,(A0)                         ; $2A0F7C
        BTST    D1,-(A0)                        ; $2A0F7E
        BTST    D1,$00(A0,D0.W)                 ; $2A0F80
        BTST    D2,D0                           ; $2A0F84
        BSET    D1,D0                           ; $2A0F86
        BSET    D1,(A0)                         ; $2A0F88
        BSET    D1,-(A0)                        ; $2A0F8A
        BSET    D1,$00(A0,D0.W)                 ; $2A0F8C
        BTST    D2,D0                           ; $2A0F90
        SUBI.B  #$0410,D0                       ; $2A0F92
        SUBI.B  #$0430,-(A0)                    ; $2A0F96
        CMPI.B  #$0044,D0                       ; $2A0F9A
        ORI.W  #$0B8C,D4                        ; $2A0F9E
        MOVE.W  -$30(PC,D0.W),$0B8C(A6)         ; $2A0FA2
        MOVEA.W A0,A3                           ; $2A0FA8
        DC.W    $02D0               ; $2A0FAA DC.W    $02D0
        DC.W    $0E0A               ; $2A0FAC DC.W    $0E0A
        MOVEA.W A0,A3                           ; $2A0FAE
        DC.W    $02F5               ; $2A0FB0 DC.W    $02F5
        DC.W    $0E0A               ; $2A0FB2 DC.W    $0E0A
        MOVE.W  -$0B(PC,D0.W),$02D6(A6)         ; $2A0FB4
        MOVE.W  $23(PC,D0.W),$02D6(A3)          ; $2A0FBA
        MOVE.W  (A5),-(A2)                      ; $2A0FC0
        DC.W    $0223,$0E0A         ; $2A0FC2 ANDI.B  #$0E0A,-(A3)
        MOVE.W  (A5),-(A2)                      ; $2A0FC6
        DC.W    $02F5               ; $2A0FC8 DC.W    $02F5
        DC.W    $0E0A               ; $2A0FCA DC.W    $0E0A
        MOVE.W  -$0B(PC,D0.W),$02D6(A3)         ; $2A0FCC
        MOVE.W  $0223(A7),(A7)                  ; $2A0FD2
        DC.W    $02D6               ; $2A0FD6 DC.W    $02D6
        MOVEA.W A0,A6                           ; $2A0FD8
        DC.W    $0223,$0E0A         ; $2A0FDA ANDI.B  #$0E0A,-(A3)
        MOVEA.W A0,A6                           ; $2A0FDE
        DC.W    $02F5               ; $2A0FE0 DC.W    $02F5
        DC.W    $0E0A               ; $2A0FE2 DC.W    $0E0A
        MOVE.W  $02F5(A7),(A7)                  ; $2A0FE4
        BCLR    D0,(A7)                         ; $2A0FE8
        MOVE.W  $0207(A7),(A7)                  ; $2A0FEA
        BCLR    D0,(A7)                         ; $2A0FEE
        MOVEA.W A0,A0                           ; $2A0FF0
        DC.W    $0207,$0414         ; $2A0FF2 ANDI.B  #$0414,D7
        MOVEA.W A0,A0                           ; $2A0FF6
        ANDI.W  #$0414,D0                       ; $2A0FF8
        MOVE.W  $0240(A7),(A7)                  ; $2A0FFC
        ASR.L  #6,D2                            ; $2A1000
        MOVE.W  -$0058(A7),(A1)                 ; $2A1002
        ASR.L  #6,D2                            ; $2A1006
        MOVEA.W A0,A0                           ; $2A1008
        MOVE.W  -$0857(A0),$48(A7,D3.W)         ; $2A100A
        DC.W    $00FE               ; $2A1010 DC.W    $00FE
        MOVE.W  $32AF(A1),-$02(A3,D0.W)         ; $2A1012
        ASR.L  #6,D2                            ; $2A1018
        MOVE.W  -$0058(A7),(A7)                 ; $2A101A
        ASR.L  #6,D2                            ; $2A101E
        MOVEA.W A0,A6                           ; $2A1020
        MOVE.W  -$0857(A0),$48(A7,D3.L)         ; $2A1022
        DC.W    $00FE               ; $2A1028 DC.W    $00FE
        MOVE.W  $3EAF(A1),-$02(A3,D0.W)         ; $2A102A
        ASL.W  #5,D4                            ; $2A1030
        MOVE.W  -$0080(A7),(A7)                 ; $2A1032
        ASL.W  #5,D4                            ; $2A1036
        MOVEA.W A0,A0                           ; $2A1038
        MOVE.W  D0,-$41(A7,A6.L)                ; $2A103A
        MOVEA.W A0,A0                           ; $2A103E
        DC.W    $FFD0               ; $2A1040 MOVE.W  (A0),<EA:3F>
        ROL.L  D6,D7                            ; $2A1042
        MOVE.W  -$0030(A7),(A7)                 ; $2A1044
        MOVE.W  -(A4),D5                        ; $2A1048
        MOVE.W  $0144(A7),(A1)                  ; $2A104A
        MOVE.W  -(A4),D5                        ; $2A104E
        MOVEA.W A0,A0                           ; $2A1050
        BCHG    D0,D4                           ; $2A1052
        MOVE.W  -(A0),(A6)                      ; $2A1054
        MOVEA.W A0,A0                           ; $2A1056
        DC.W    $0189               ; $2A1058 BCLR    D0,A1
        MOVE.W  -(A0),(A6)                      ; $2A105A
        MOVE.W  $0189(A7),(A1)                  ; $2A105C
        MOVE.B  A1,(A0)                         ; $2A1060
        MOVE.W  $0313(A7),(A1)                  ; $2A1062
        MOVE.B  A1,(A0)                         ; $2A1066
        MOVEA.W A0,A0                           ; $2A1068
        BTST    D1,(A3)                         ; $2A106A
        MOVE.B  A0,-(A1)                        ; $2A106C
        MOVEA.W A0,A0                           ; $2A106E
        BTST    D1,$1308(A3)                    ; $2A1070
        MOVE.W  $032B(A7),(A1)                  ; $2A1074
        MOVE.W  (A4)+,$317B(A6)                 ; $2A1078
        BSET    D0,-(A6)                        ; $2A107C
        MOVE.W  (A4)+,$2D7B(A6)                 ; $2A107E
        BSET    D0,-(A6)                        ; $2A1082
        SEQ     $7B(A0,D2.L)                    ; $2A1084
        DC.W    $0000,$57F0         ; $2A1088 ORI.B  #$57F0,D0
        MOVE.W  $00(PC,D0.W),$3D5C(A0)          ; $2A108C
        DC.W    $417B               ; $2A1092 DC.W    $417B
        BSET    D0,-(A6)                        ; $2A1094
        MOVE.W  (A4)+,$3D7B(A6)                 ; $2A1096
        BSET    D0,-(A6)                        ; $2A109A
        SEQ     $7B(A0,D3.L)                    ; $2A109C
        DC.W    $0000,$57F0         ; $2A10A0 ORI.B  #$57F0,D0
        DC.W    $417B               ; $2A10A4 DC.W    $417B
        DC.W    $0000,$A7FF         ; $2A10A6 ORI.B  #$A7FF,D0
        MOVE.W  -$01(PC,A7.L),-$5801(A0)        ; $2A10AA
        MOVE.L  -$01(PC,A7.L),-$3EE5(A6)        ; $2A10B0
        MOVE.L  -$38(PC,A7.L),-$3EE5(A6)        ; $2A10B6
        MOVE.W  -$38(PC,A7.L),-$5801(A0)        ; $2A10BC
        DC.W    $417B               ; $2A10C2 DC.W    $417B
        DC.W    $FFFF               ; $2A10C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $A7FF,$3D7B         ; $2A10C6 MOVE.L  <EA:3F>,$7B(PC,D3.L)
        DC.W    $FFFF               ; $2A10CA MOVE.W  <EA:3F>,<EA:3F>
        AND.B  D0,(A3)+                         ; $2A10CC
        MOVE.W  -$38(PC,A7.L),-$3EE5(A6)        ; $2A10CE
        DC.W    $417B               ; $2A10D4 DC.W    $417B
        DC.W    $FBC8               ; $2A10D6 MOVE.W  A0,<EA:3D>
        ADD.W  $417B(A3),D0                     ; $2A10D8
        MOVE.W  -$2F95(A4),-(A6)                ; $2A10DC
        MOVE.L  $2C(PC,A7.L),$1585(A6)          ; $2A10E0
        DC.W    $417B               ; $2A10E6 DC.W    $417B
        SUBI.W  #$E8CB,A7                       ; $2A10E8
        DC.W    $417B               ; $2A10EC DC.W    $417B
        ORI.W  #$E8CB,D3                        ; $2A10EE
        MOVE.L  $43(PC,D0.W),$1585(A6)          ; $2A10F2
        MOVE.L  $4F(PC,D0.W),$2E12(A6)          ; $2A10F8
        DC.W    $417B               ; $2A10FE DC.W    $417B
        DC.W    $0389               ; $2A1100 BCLR    D1,A1
        MOVE.L  (A2),D7                         ; $2A1102
        MOVE.L  -$77(PC,D0.W),$57EE(A6)         ; $2A1104
        CLR.B  D0                               ; $2A110A
        DC.W    $0000,$57EE         ; $2A110C ORI.B  #$57EE,D0
        DC.W    $0000,$0000         ; $2A1110 ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A1114
        DC.W    $0000,$0000         ; $2A1116 ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A111A
        CLR.B  D0                               ; $2A111C
        DC.W    $0000,$A4CE         ; $2A111E ORI.B  #$A4CE,D0
        CLR.B  D0                               ; $2A1122
        DC.W    $0000,$A4CE         ; $2A1124 ORI.B  #$A4CE,D0
        DC.W    $0000,$0000         ; $2A1128 ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A112C
        DC.W    $0000,$0000         ; $2A112E ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A1132
        CLR.B  D0                               ; $2A1134
        DC.W    $0000,$0004         ; $2A1136 ORI.B  #$0004,D0
        MOVE.L  D0,D0                           ; $2A113A
        BCHG    D1,D0                           ; $2A113C
        BTST    D1,-$20(A0,D0.W)                ; $2A113E
        BCHG    D1,(A0)                         ; $2A1142
        DC.W    $0204,$2000         ; $2A1144 ANDI.B  #$2000,D4
        BCLR    D1,D0                           ; $2A1148
        BCHG    D1,$04(A0,D0.W)                 ; $2A114A
        MOVE.L  D0,D0                           ; $2A114E
        BCLR    D1,(A0)                         ; $2A1150
        BCHG    D1,-(A0)                        ; $2A1152
        SUBI.B  #$2000,D4                       ; $2A1154
        BCLR    D1,-$60(A0,D0.W)                ; $2A1158
        SUBI.B  #$2000,D4                       ; $2A115C
        ANDI.W  #$0280,(A0)                     ; $2A1160
        DC.W    $0012,$7900         ; $2A1164 ORI.B  #$7900,(A2)
        DC.W    $0000,$0010         ; $2A1168 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A116C ORI.B  #$0030,-(A0)
        DC.W    $0012,$7900         ; $2A1170 ORI.B  #$7900,(A2)
        ORI.W  #$0050,D0                        ; $2A1174
        ORI.W  #$0070,-(A0)                     ; $2A1178
        DC.W    $0012,$7900         ; $2A117C ORI.B  #$7900,(A2)
        ORI.L  #$009000A0,D0                    ; $2A1180
        DC.W    $00B0,$0012,$7900,$00C0; $2A1186 ORI.L  #$00127900,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A118E DC.W    $00D0
        DC.W    $00E0               ; $2A1190 DC.W    $00E0
        DC.W    $00F0               ; $2A1192 DC.W    $00F0
        DC.W    $0012,$7900         ; $2A1194 ORI.B  #$7900,(A2)
        BTST    D0,D0                           ; $2A1198
        BTST    D0,(A0)                         ; $2A119A
        BTST    D0,-(A0)                        ; $2A119C
        BTST    D0,$12(A0,D0.W)                 ; $2A119E
        MOVE.W  D0,-(A4)                        ; $2A11A2
        BCHG    D0,D0                           ; $2A11A4
        BCHG    D0,(A0)                         ; $2A11A6
        BCHG    D0,-(A0)                        ; $2A11A8
        BCHG    D0,$12(A0,D0.W)                 ; $2A11AA
        MOVE.W  D0,-(A4)                        ; $2A11AE
        BCLR    D0,D0                           ; $2A11B0
        BCLR    D0,(A0)                         ; $2A11B2
        BCLR    D0,-(A0)                        ; $2A11B4
        BCLR    D0,$12(A0,D0.W)                 ; $2A11B6
        MOVE.W  D0,-(A4)                        ; $2A11BA
        BSET    D0,D0                           ; $2A11BC
        BSET    D0,(A0)                         ; $2A11BE
        BSET    D0,-(A0)                        ; $2A11C0
        BSET    D0,$12(A0,D0.W)                 ; $2A11C2
        MOVE.W  D0,-(A4)                        ; $2A11C6
        DC.W    $0200,$0210         ; $2A11C8 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2A11CC ANDI.B  #$0230,-(A0)
        DC.W    $0004,$2000         ; $2A11D0 ORI.B  #$2000,D4
        ANDI.W  #$0250,D0                       ; $2A11D4
        ANDI.W  #$0270,-(A0)                    ; $2A11D8
        DC.W    $0004,$2000         ; $2A11DC ORI.B  #$2000,D4
        ANDI.L  #$029002A0,D0                   ; $2A11E0
        DC.W    $02B0,$0004,$2000,$02C0; $2A11E6 ANDI.L  #$00042000,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A11EE DC.W    $02D0
        DC.W    $02E0               ; $2A11F0 DC.W    $02E0
        DC.W    $02F0               ; $2A11F2 DC.W    $02F0
        DC.W    $0004,$2000         ; $2A11F4 ORI.B  #$2000,D4
        BTST    D1,D0                           ; $2A11F8
        BTST    D1,(A0)                         ; $2A11FA
        BTST    D1,-(A0)                        ; $2A11FC
        BTST    D1,$00(A0,D0.W)                 ; $2A11FE
        BTST    D2,D0                           ; $2A1202
        BSET    D1,D0                           ; $2A1204
        BSET    D1,(A0)                         ; $2A1206
        BSET    D1,-(A0)                        ; $2A1208
        BSET    D1,$00(A0,D0.W)                 ; $2A120A
        BTST    D2,D0                           ; $2A120E
        SUBI.B  #$0410,D0                       ; $2A1210
        SUBI.B  #$0430,-(A0)                    ; $2A1214
        CMPI.B  #$0044,D0                       ; $2A1218
        ORI.W  #$0CFA,D4                        ; $2A121C
        MOVE.W  $70(PC,A7.L),$0CFA(A6)          ; $2A1220
        MOVEA.W A0,A3                           ; $2A1226
        MOVEA.W $76(A0,D0.L),A7                 ; $2A1228
        MOVEA.W A0,A3                           ; $2A122C
        MOVEA.W (A0),A7                         ; $2A122E
        BCHG    D7,$7B(A6,D3.L)                 ; $2A1230
        MOVEA.W (A0),A7                         ; $2A1234
        SUBI.W  #$377B,A1                       ; $2A1236
        MOVE.W  D3,(A7)+                        ; $2A123A
        SUBI.W  #$3515,A1                       ; $2A123C
        MOVE.W  D3,(A7)+                        ; $2A1240
        BCHG    D7,$15(A6,D3.W)                 ; $2A1242
        MOVEA.W (A0),A7                         ; $2A1246
        BCHG    D7,$7B(A6,D3.W)                 ; $2A1248
        MOVEA.W (A0),A7                         ; $2A124C
        SUBI.W  #$3EAF,A1                       ; $2A124E
        MOVE.W  D3,(A7)+                        ; $2A1252
        SUBI.W  #$3C48,A1                       ; $2A1254
        MOVE.W  D3,(A7)+                        ; $2A1258
        BCHG    D7,$48(A6,D3.L)                 ; $2A125A
        MOVEA.W (A0),A7                         ; $2A125E
        BCHG    D7,-$51(A6,D3.L)                ; $2A1260
        MOVEA.W (A0),A7                         ; $2A1264
        DC.W    $030C               ; $2A1266 BTST    D1,A4
        MOVE.W  -$0134(A7),(A7)                 ; $2A1268
        DC.W    $030C               ; $2A126C BTST    D1,A4
        MOVEA.W A0,A0                           ; $2A126E
        MOVE.W  A4,(A7)+                        ; $2A1270
        DC.W    $0588               ; $2A1272 BCLR    D2,A0
        MOVEA.W A0,A0                           ; $2A1274
        MOVE.W  $0588(PC),(A7)                  ; $2A1276
        MOVE.W  -$0146(A7),(A7)                 ; $2A127A
        ROXL.W  $32AF(A5)                       ; $2A127E
        MOVE.W  (A2),-(A7)                      ; $2A1282
        ROXL.W  $3048(A5)                       ; $2A1284
        MOVE.W  (A2),-(A7)                      ; $2A1288
        MOVE.W  (A4)+,-(A4)                     ; $2A128A
        MOVEA.W A0,A0                           ; $2A128C
        MOVE.W  #$F91C,(A7)+                    ; $2A128E
        MOVE.W  -$0104(A7),(A1)                 ; $2A1292
        ROXL.W  $3EAF(A5)                       ; $2A1296
        MOVE.W  (A2),-(A7)                      ; $2A129A
        ROXL.W  $3C48(A5)                       ; $2A129C
        MOVE.W  (A2),-(A7)                      ; $2A12A0
        MOVE.W  (A4)+,-(A4)                     ; $2A12A2
        MOVEA.W A0,A6                           ; $2A12A4
        MOVE.W  #$F91C,(A7)+                    ; $2A12A6
        MOVE.W  -$0104(A7),(A7)                 ; $2A12AA
        ROXR.L  D6,D0                           ; $2A12AE
        MOVE.W  -$00ED(A7),(A7)                 ; $2A12B0
        ROXR.L  D6,D0                           ; $2A12B4
        MOVEA.W A0,A0                           ; $2A12B6
        MOVE.W  (A3),-(A7)                      ; $2A12B8
        LSL.B  D7,D4                            ; $2A12BA
        MOVEA.W A0,A0                           ; $2A12BC
        MOVE.W  (A1),-(A7)                      ; $2A12BE
        LSL.B  D7,D4                            ; $2A12C0
        MOVE.W  -$00EF(A7),(A7)                 ; $2A12C2
        MOVE.W  (A0)+,-$51(A5,D3.W)             ; $2A12C6
        MOVE.W  -$68(A4,A7.L),(A7)+             ; $2A12CA
        MOVEA.W A0,A0                           ; $2A12CE
        MOVE.W  $14(A4,A7.L),(A7)+              ; $2A12D0
        MOVEA.W A0,A0                           ; $2A12D4
        MOVE.W  -$01EC(A1),(A7)+                ; $2A12D6
        MOVE.W  -$0117(A7),(A1)                 ; $2A12DA
        MOVE.B  -$51(A1,D3.W),$FE2D.W           ; $2A12DE
        MOVE.B  $48(A1,D3.W),$FE2D.W            ; $2A12E4
        MOVEA.B $3048(A4),A2                    ; $2A12EA
        MOVE.W  D3,D7                           ; $2A12EE
        MOVEA.B $32AF(A4),A2                    ; $2A12F0
        MOVE.W  D3,D7                           ; $2A12F4
        MOVE.W  -(A6),D7                        ; $2A12F6
        MOVE.W  -$70(PC,A7.L),$3E26(A0)         ; $2A12F8
        MOVE.L  -$70(PC,A7.L),$57F0(A6)         ; $2A12FE
        MOVE.L  $00(PC,D0.W),$57F0(A6)          ; $2A1304
        MOVE.W  $00(PC,D0.W),$3E26(A0)          ; $2A130A
        DC.W    $417B               ; $2A1310 DC.W    $417B
        MOVE.W  (A0),(A4)                       ; $2A1312
        MOVE.W  -(A6),D7                        ; $2A1314
        MOVE.W  -$70(PC,A7.L),$57F0(A6)         ; $2A1316
        MOVE.W  $00(PC,D0.W),$57F0(A6)          ; $2A131C
        DC.W    $417B               ; $2A1322 DC.W    $417B
        DC.W    $0000,$A7FF         ; $2A1324 ORI.B  #$A7FF,D0
        MOVE.W  -$01(PC,A7.L),-$5801(A0)        ; $2A1328
        MOVE.L  -$01(PC,A7.L),-$3D90(A6)        ; $2A132E
        MOVE.L  $00(PC,D0.W),-$3D90(A6)         ; $2A1334
        MOVE.W  $00(PC,D0.W),-$5801(A0)         ; $2A133A
        DC.W    $417B               ; $2A1340 DC.W    $417B
        DC.W    $FFFF               ; $2A1342 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $A7FF,$3D7B         ; $2A1344 MOVE.L  <EA:3F>,$7B(PC,D3.L)
        DC.W    $FFFF               ; $2A1348 MOVE.W  <EA:3F>,<EA:3F>
        AND.W  $7B(A0,D3.L),D1                  ; $2A134A
        DC.W    $0000,$C270         ; $2A134E ORI.B  #$C270,D0
        DC.W    $417B               ; $2A1352 DC.W    $417B
        DC.W    $0000,$D1BF         ; $2A1354 ORI.B  #$D1BF,D0
        DC.W    $417B               ; $2A1358 DC.W    $417B
        DC.W    $0000,$D1BF         ; $2A135A ORI.B  #$D1BF,D0
        MOVE.L  $00(PC,D0.W),$16E5(A6)          ; $2A135E
        DC.W    $417B               ; $2A1364 DC.W    $417B
        DC.W    $FEBF               ; $2A1366 MOVE.W  <EA:3F>,(A7)
        ROXR.B  D5,D4                           ; $2A1368
        DC.W    $417B               ; $2A136A DC.W    $417B
        DC.W    $FFFF               ; $2A136C MOVE.W  <EA:3F>,<EA:3F>
        ROXR.B  D5,D4                           ; $2A136E
        MOVE.L  -$01(PC,A7.L),$16E5(A6)         ; $2A1370
        MOVE.L  -$41(PC,A7.L),$2F1C(A6)         ; $2A1376
        DC.W    $417B               ; $2A137C DC.W    $417B
        MOVE.W  -(A7),$2F1C(A5)                 ; $2A137E
        MOVE.L  $67(PC,A7.L),$57EE(A6)          ; $2A1382
        CLR.B  D0                               ; $2A1388
        DC.W    $0000,$57EE         ; $2A138A ORI.B  #$57EE,D0
        DC.W    $0000,$0000         ; $2A138E ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A1392
        DC.W    $0000,$0000         ; $2A1394 ORI.B  #$0000,D0
        SUBQ.B  #5,-(A1)                        ; $2A1398
        CLR.B  D0                               ; $2A139A
        DC.W    $0000,$A4CE         ; $2A139C ORI.B  #$A4CE,D0
        CLR.B  D0                               ; $2A13A0
        DC.W    $0000,$A4CE         ; $2A13A2 ORI.B  #$A4CE,D0
        DC.W    $0000,$0000         ; $2A13A6 ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A13AA
        DC.W    $0000,$0000         ; $2A13AC ORI.B  #$0000,D0
        MOVE.L  D2,D4                           ; $2A13B0
        CLR.B  D0                               ; $2A13B2
        DC.W    $0000,$0004         ; $2A13B4 ORI.B  #$0004,D0
        MOVE.L  D0,D0                           ; $2A13B8
        BCHG    D1,D0                           ; $2A13BA
        BTST    D1,-$20(A0,D0.W)                ; $2A13BC
        BCHG    D1,(A0)                         ; $2A13C0
        DC.W    $0204,$2000         ; $2A13C2 ANDI.B  #$2000,D4
        BCLR    D1,D0                           ; $2A13C6
        BCHG    D1,$04(A0,D0.W)                 ; $2A13C8
        MOVE.L  D0,D0                           ; $2A13CC
        BCLR    D1,(A0)                         ; $2A13CE
        BCHG    D1,-(A0)                        ; $2A13D0
        SUBI.B  #$2000,D4                       ; $2A13D2
        BCLR    D1,-$60(A0,D0.W)                ; $2A13D6
        SUBI.B  #$2000,D4                       ; $2A13DA
        ANDI.W  #$0280,(A0)                     ; $2A13DE
        DC.W    $0012,$7900         ; $2A13E2 ORI.B  #$7900,(A2)
        DC.W    $0000,$0010         ; $2A13E6 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A13EA ORI.B  #$0030,-(A0)
        DC.W    $0012,$7900         ; $2A13EE ORI.B  #$7900,(A2)
        ORI.W  #$0050,D0                        ; $2A13F2
        ORI.W  #$0070,-(A0)                     ; $2A13F6
        DC.W    $0012,$7900         ; $2A13FA ORI.B  #$7900,(A2)
        ORI.L  #$009000A0,D0                    ; $2A13FE
        DC.W    $00B0,$0012,$7900,$00C0; $2A1404 ORI.L  #$00127900,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A140C DC.W    $00D0
        DC.W    $00E0               ; $2A140E DC.W    $00E0
        DC.W    $00F0               ; $2A1410 DC.W    $00F0
        DC.W    $0012,$7900         ; $2A1412 ORI.B  #$7900,(A2)
        BTST    D0,D0                           ; $2A1416
        BTST    D0,(A0)                         ; $2A1418
        BTST    D0,-(A0)                        ; $2A141A
        BTST    D0,$12(A0,D0.W)                 ; $2A141C
        MOVE.W  D0,-(A4)                        ; $2A1420
        BCHG    D0,D0                           ; $2A1422
        BCHG    D0,(A0)                         ; $2A1424
        BCHG    D0,-(A0)                        ; $2A1426
        BCHG    D0,$12(A0,D0.W)                 ; $2A1428
        MOVE.W  D0,-(A4)                        ; $2A142C
        BCLR    D0,D0                           ; $2A142E
        BCLR    D0,(A0)                         ; $2A1430
        BCLR    D0,-(A0)                        ; $2A1432
        BCLR    D0,$12(A0,D0.W)                 ; $2A1434
        MOVE.W  D0,-(A4)                        ; $2A1438
        BSET    D0,D0                           ; $2A143A
        BSET    D0,(A0)                         ; $2A143C
        BSET    D0,-(A0)                        ; $2A143E
        BSET    D0,$12(A0,D0.W)                 ; $2A1440
        MOVE.W  D0,-(A4)                        ; $2A1444
        DC.W    $0200,$0210         ; $2A1446 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2A144A ANDI.B  #$0230,-(A0)
        DC.W    $0004,$2000         ; $2A144E ORI.B  #$2000,D4
        ANDI.W  #$0250,D0                       ; $2A1452
        ANDI.W  #$0270,-(A0)                    ; $2A1456
        DC.W    $0004,$2000         ; $2A145A ORI.B  #$2000,D4
        ANDI.L  #$029002A0,D0                   ; $2A145E
        DC.W    $02B0,$0004,$2000,$02C0; $2A1464 ANDI.L  #$00042000,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A146C DC.W    $02D0
        DC.W    $02E0               ; $2A146E DC.W    $02E0
        DC.W    $02F0               ; $2A1470 DC.W    $02F0
        DC.W    $0004,$2000         ; $2A1472 ORI.B  #$2000,D4
        BTST    D1,D0                           ; $2A1476
        BTST    D1,(A0)                         ; $2A1478
        BTST    D1,-(A0)                        ; $2A147A
        BTST    D1,$00(A0,D0.W)                 ; $2A147C
        BTST    D2,D0                           ; $2A1480
        BSET    D1,D0                           ; $2A1482
        BSET    D1,(A0)                         ; $2A1484
        BSET    D1,-(A0)                        ; $2A1486
        BSET    D1,$00(A0,D0.W)                 ; $2A1488
        BTST    D2,D0                           ; $2A148C
        SUBI.B  #$0410,D0                       ; $2A148E
        SUBI.B  #$0430,-(A0)                    ; $2A1492
        CMPI.B  #$0027,D0                       ; $2A1496
        DC.W    $0027,$0D65         ; $2A149A ORI.B  #$0D65,-(A7)
        MOVEQ   #$50,D2                         ; $2A149E
        MOVE.W  (A4),-$6E(A3,D0.L)              ; $2A14A0
        MOVEQ   #-$44,D1                        ; $2A14A4
        MOVE.W  (A0),$71(A1,D5.W)               ; $2A14A6
        ADD.B  D0,D4                            ; $2A14AA
        ADD.L  D3,D3                            ; $2A14AC
        ADDQ.W  #5,-(A3)                        ; $2A14AE
        ADD.B  D0,D4                            ; $2A14B0
        ADD.L  D5,D7                            ; $2A14B2
        MOVE.L  (A5),$00(A2,A5.L)               ; $2A14B4
        ADD.L  D5,D7                            ; $2A14B8
        MOVE.L  (A7)+,$00(A4,A5.L)              ; $2A14BA
        ADD.L  D3,D3                            ; $2A14BE
        MOVE.W  $72DCF390,-(A2)                 ; $2A14C0
        MOVEA.W $66(A0,D7.W),A1                 ; $2A14C6
        MOVE.W  (A4),-$40(A3,D0.L)              ; $2A14CA
        MOVEQ   #-$24,D1                        ; $2A14CE
        BTST    D5,(A0)+                        ; $2A14D0
        DC.W    $0D89               ; $2A14D2 BCLR    D6,A1
        MOVEQ   #$66,D2                         ; $2A14D4
        BTST    D3,(A4)                         ; $2A14D6
        ADDQ.W  #5,-(A3)                        ; $2A14D8
        ADD.B  D0,D4                            ; $2A14DA
        MOVE.L  -(A0),-(A1)                     ; $2A14DC
        ADDQ.W  #3,(A1)+                        ; $2A14DE
        ADD.B  D0,D4                            ; $2A14E0
        MOVE.L  -(A4),-(A3)                     ; $2A14E2
        MOVE.L  A0,$00(A4,A5.L)                 ; $2A14E4
        MOVE.L  -(A4),-(A3)                     ; $2A14E8
        MOVE.L  (A5),$00(A2,A5.L)               ; $2A14EA
        MOVE.L  -(A0),-(A1)                     ; $2A14EE
        MOVE.W  (A4),(A1)                       ; $2A14F0
        MOVEQ   #$50,D2                         ; $2A14F2
        BTST    D3,(A4)                         ; $2A14F4
        MOVE.W  -(A7),$72BC(A2)                 ; $2A14F6
        BTST    D5,(A0)+                        ; $2A14FA
        MOVE.L  A5,$0A(A0,D4.W)                 ; $2A14FC
        MOVE.B  A3,(A0)+                        ; $2A1500
        MOVE.L  (A5),-$1D(A1,D3.L)              ; $2A1502
        MOVE.B  (A3),$79(A0,A5.L)               ; $2A1506
        NEGX.B D5                               ; $2A150A
        MOVE.B  (A3),-$7E(A0,A5.L)              ; $2A150C
        NEG.B  A2                               ; $2A1510
        MOVE.B  -$11(PC,D4.W),(A0)              ; $2A1512
        DC.W    $FFEF,$1D20         ; $2A1516 MOVE.W  $1D20(A7),<EA:3F>
        NEG    (A2)                             ; $2A151A
        DC.W    $FBEA,$1DFE         ; $2A151C MOVE.W  $1DFE(A2),<EA:3D>
        EOR.B  D5,(A3)+                         ; $2A1520
        DC.W    $FBEA,$1DFE         ; $2A1522 MOVE.W  $1DFE(A2),<EA:3D>
        EOR.B  D6,(A0)+                         ; $2A1526
        DC.W    $FFFB,$1D20         ; $2A1528 MOVE.W  $20(PC,D1.L),<EA:3F>
        ADD.L  D2,D7                            ; $2A152C
        NEG.B  A2                               ; $2A152E
        ASL.W  #7,D5                            ; $2A1530
        ADD.W  $4005EE6D,D6                     ; $2A1532
        MOVE.L  (A5),-$1D(A1,D3.L)              ; $2A1538
        LSR.W  D7,D5                            ; $2A153C
        MOVE.L  A5,$0A(A0,D4.W)                 ; $2A153E
        ROXL.B  D7,D5                           ; $2A1542
        EOR.B  D6,(A0)+                         ; $2A1544
        DC.W    $FFFB,$E2E0         ; $2A1546 MOVE.W  -$20(PC,A6.W),<EA:3F>
        EOR.B  D5,(A3)+                         ; $2A154A
        DC.W    $FBEA,$E202         ; $2A154C MOVE.W  -$1DFE(A2),<EA:3D>
        NEG    (A2)                             ; $2A1550
        DC.W    $FBEA,$E202         ; $2A1552 MOVE.W  -$1DFE(A2),<EA:3D>
        CLR    -$0011(A7)                       ; $2A1556
        LSR.W  -(A0)                            ; $2A155A
        ADDA.W  -(A6),A6                        ; $2A155C
        DC.W    $3FF4,$104B         ; $2A155E MOVE.W  $4B(A4,D1.W),<EA:3F>
        ADDA.W  -(A6),A7                        ; $2A1562
        NEG.B  A2                               ; $2A1564
        BCHG    D7,-$1B(A3,D4.W)                ; $2A1566
        BSET    D1,(A5)+                        ; $2A156A
        MOVE.B  A5,-(A5)                        ; $2A156C
        NEG    (A5)+                            ; $2A156E
        DC.W    $FBEA,$1CA6         ; $2A1570 MOVE.W  $1CA6(A2),<EA:3D>
        EOR.B  D7,(A3)                          ; $2A1574
        BSET    D1,(A5)+                        ; $2A1576
        ROL.L  #1,D3                            ; $2A1578
        MOVE.L  (A2),-(A1)                      ; $2A157A
        DC.W    $3FF4,$EE5D         ; $2A157C MOVE.W  $5D(A4,A6.L),<EA:3F>
        MOVE.L  (A2),-(A0)                      ; $2A1580
        NEG.B  A2                               ; $2A1582
        ROXL.B  D7,D5                           ; $2A1584
        DC.W    $0000,$AC00         ; $2A1586 ORI.B  #$AC00,D0
        BCHG    D0,D0                           ; $2A158A
        BCHG    D0,(A0)                         ; $2A158C
        BCHG    D0,-(A0)                        ; $2A158E
        BCHG    D0,$00(A0,D0.W)                 ; $2A1590
        MOVE.L  D0,D6                           ; $2A1594
        BSET    D0,(A0)                         ; $2A1596
        BSET    D0,D0                           ; $2A1598
        SUBI.B  #$AC00,D0                       ; $2A159A
        BSET    D0,-(A0)                        ; $2A159E
        BSET    D0,$00(A0,D0.W)                 ; $2A15A0
        MOVE.L  D0,D6                           ; $2A15A4
        BCHG    D0,(A0)                         ; $2A15A6
        BCHG    D0,D0                           ; $2A15A8
        DC.W    $0000,$B000         ; $2A15AA ORI.B  #$B000,D0
        DC.W    $0000,$0010         ; $2A15AE ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A15B2 ORI.B  #$0030,-(A0)
        DC.W    $0000,$B000         ; $2A15B6 ORI.B  #$B000,D0
        ORI.W  #$0050,D0                        ; $2A15BA
        ORI.W  #$0070,-(A0)                     ; $2A15BE
        DC.W    $0000,$B000         ; $2A15C2 ORI.B  #$B000,D0
        ORI.L  #$009000A0,D0                    ; $2A15C6
        DC.W    $00B0,$0000,$B000,$00C0; $2A15CC ORI.L  #$0000B000,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A15D4 DC.W    $00D0
        DC.W    $00E0               ; $2A15D6 DC.W    $00E0
        DC.W    $00F0               ; $2A15D8 DC.W    $00F0
        DC.W    $0000,$AC00         ; $2A15DA ORI.B  #$AC00,D0
        BTST    D0,D0                           ; $2A15DE
        BTST    D0,(A0)                         ; $2A15E0
        BTST    D0,-(A0)                        ; $2A15E2
        BTST    D0,$00(A0,D0.W)                 ; $2A15E4
        MOVE.L  D0,D6                           ; $2A15E8
        BCLR    D0,D0                           ; $2A15EA
        BCLR    D0,(A0)                         ; $2A15EC
        BCLR    D0,-(A0)                        ; $2A15EE
        BCLR    D0,$00(A0,D0.W)                 ; $2A15F0
        MOVE.L  D0,D7                           ; $2A15F4
        DC.W    $0200,$0210         ; $2A15F6 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2A15FA ANDI.B  #$0230,-(A0)
        DC.W    $0000,$AE00         ; $2A15FE ORI.B  #$AE00,D0
        ANDI.W  #$01D0,D0                       ; $2A1602
        ANDI.W  #$0260,(A0)                     ; $2A1606
        CMPI.B  #$00D8,D0                       ; $2A160A
        DC.W    $00D8               ; $2A160E DC.W    $00D8
        ASL.B  D6,D7                            ; $2A1610
        LSL.B  D6,D4                            ; $2A1612
        DC.W    $0000,$0008         ; $2A1614 ORI.B  #$0008,D0
        ASL.W  D2,D5                            ; $2A1618
        DC.W    $0000,$12DD         ; $2A161A ORI.B  #$12DD,D0
        ROXL.B  D6,D2                           ; $2A161E
        DC.W    $0000,$1AA1         ; $2A1620 ORI.B  #$1AA1,D0
        DC.W    $0002,$0000         ; $2A1624 ORI.B  #$0000,D2
        ROL.W  #2,D4                            ; $2A1628
        DC.W    $FFFD               ; $2A162A MOVE.W  <EA:3D>,<EA:3F>
        DC.W    $0000,$12D6         ; $2A162C ORI.B  #$12D6,D0
        MOVE.B  (A3),(A1)+                      ; $2A1630
        DC.W    $0000,$0002         ; $2A1632 ORI.B  #$0002,D0
        MOVE.B  (A7)+,(A5)                      ; $2A1636
        DC.W    $0000,$ED36         ; $2A1638 ORI.B  #$ED36,D0
        MOVE.B  (A7),(A1)+                      ; $2A163C
        DC.W    $0000,$E039         ; $2A163E ORI.B  #$E039,D0
        ADDQ.W  #1,(A1)                         ; $2A1642
        BCLR    D0,$79(A1,D2.L)                 ; $2A1644
        BLT.S  loc_2A166E                       ; $2A1648
        BCLR    D0,-$04(A1,D2.L)                ; $2A164A
        BGT.S  loc_2A1686                       ; $2A164E
        BCLR    D0,-$2C(A1,A5.L)                ; $2A1650
        SUBQ.B  #1,(A0)+                        ; $2A1654
        BCLR    D0,$36(A1,A5.W)                 ; $2A1656
        BLT.S  loc_2A168E                       ; $2A165A
        BCLR    D0,$0B(A1,D2.W)                 ; $2A165C
        SUBQ.W  #8,-$4F(A3,D0.W)                ; $2A1660
        MOVE.L  A6,-$7A(A0,D5.W)                ; $2A1664
        BCLR    D0,-$61(A1,A5.W)                ; $2A1668
        BGT.S  loc_2A162D                       ; $2A166C
loc_2A166E:
        BCLR    D0,-$43(A1,D2.W)                ; $2A166E
        ADDQ.L  #8,$01B1(A6)                    ; $2A1672
        BGE.S  loc_2A1617                       ; $2A1676
        MOVE.L  $01B1(PC),-$42(A6,D6.L)         ; $2A1678
        MOVE.L  (A6)+,D7                        ; $2A167E
        BCLR    D0,$02(A1,D2.W)                 ; $2A1680
        SUBQ.L  #8,D2                           ; $2A1684
loc_2A1686:
        BCLR    D0,-$0C(A1,D2.L)                ; $2A1686
        BMI.S  loc_2A1704                       ; $2A168A
        BCLR    D0,-$0A(A1,D5.W)                ; $2A168C
        MOVE.L  -$4F(PC,D0.W),D1                ; $2A1690
        ADDQ.B  #1,(A5)                         ; $2A1694
        MOVE.L  (A7)+,(A1)                      ; $2A1696
        BCLR    D0,-$5E(A1,D2.L)                ; $2A1698
        BGE.S  loc_2A1699                       ; $2A169C
        BCLR    D0,$51(A1,D5.W)                 ; $2A169E
        DC.W    $1FC7               ; $2A16A2 MOVE.B  D7,<EA:3F>
        BCLR    D0,$24(A1,D6.L)                 ; $2A16A4
        ADD.L  D1,D7                            ; $2A16A8
        BCLR    D0,$36(A1,D6.L)                 ; $2A16AA
        ADD.B  D1,D4                            ; $2A16AE
        BCLR    D0,$18(A1,D5.W)                 ; $2A16B0
        MOVE.L  $01B1(A4),D0                    ; $2A16B4
        BLT.S  loc_2A16EC                       ; $2A16B8
        MOVE.L  A2,(A5)+                        ; $2A16BA
        BCLR    D0,$73(A1,D5.W)                 ; $2A16BC
        ADDA.W  -$4F(A5,D0.W),A7                ; $2A16C0
        ADDQ.L  #1,D6                           ; $2A16C4
        ADD.W  -$4F(A2,D0.W),D7                 ; $2A16C6
        BGT.S  loc_2A168B                       ; $2A16CA
        MOVE.L  -(A1),$01B1(A5)                 ; $2A16CC
        ADDQ.L  #8,-$23BD(A6)                   ; $2A16D0
        BCLR    D0,-$46(A1,D2.L)                ; $2A16D4
        SUB.W  D1,-(A1)                         ; $2A16D8
        BCLR    D0,$1E(A1,D2.L)                 ; $2A16DA
        SUB.W  D2,D1                            ; $2A16DE
        BCLR    D0,-$7E(A1,D5.W)                ; $2A16E0
        DC.W    $DBFE               ; $2A16E4 ADDA.L  <EA:3E>,A5
        BCLR    D0,$78(A1,D6.L)                 ; $2A16E6
        ADD.B  D0,A4                            ; $2A16EA
loc_2A16EC:
        BCLR    D0,$3B(A1,D2.W)                 ; $2A16EC
        MOVE.L  A2,-(A7)                        ; $2A16F0
        BCLR    D0,-$61(A1,D2.W)                ; $2A16F2
        DC.W    $ADEB,$01B1         ; $2A16F6 MOVE.L  $01B1(A3),<EA:3E>
        BGE.S  loc_2A16F7                       ; $2A16FA
        ADD.W  (A6)+,D0                         ; $2A16FC
        BCLR    D0,-$39(A1,D1.L)                ; $2A16FE
        MOVE.L  $01B1(A7),-$79(A6,A5.W)         ; $2A1702
        SUBA.W  (A4)+,A1                        ; $2A1708
        BCLR    D0,$04(A1,A5.W)                 ; $2A170A
        SUBA.L  A2,A0                           ; $2A170E
        BCLR    D0,$2C(A1,D2.W)                 ; $2A1710
        MOVE.L  $01B1(A0),(A6)+                 ; $2A1714
        MOVE.L  A2,(A5)+                        ; $2A1718
        SUBA.W  A6,A1                           ; $2A171A
        BCLR    D0,-$0B(A1,A5.L)                ; $2A171C
        MOVE.L  A5,(A7)                         ; $2A1720
        BCLR    D0,$72(A1,A5.L)                 ; $2A1722
        MOVE.L  $01B1(PC),$2B61(A6)             ; $2A1726
        SUB.W  D0,D1                            ; $2A172C
        BCLR    D0,$43(A1,A5.L)                 ; $2A172E
        MOVE.L  (A2),$01B1(A7)                  ; $2A1732
        SUB.W  D1,-(A1)                         ; $2A1736
        ADD.W  D6,D1                            ; $2A1738
        BCLR    D0,$42(A1,A1.W)                 ; $2A173A
        ADDA.L  -(A2),A0                        ; $2A173E
        BCLR    D0,-$02(A1,A5.L)                ; $2A1740
        DC.W    $AE7E               ; $2A1744 MOVEA.L <EA:3E>,A7
        BCLR    D0,$0C(A1,A5.W)                 ; $2A1746
        SUB.L  A0,D2                            ; $2A174A
        BCLR    D0,$0A(A1,A2.L)                 ; $2A174C
        ADDA.L  D5,A6                           ; $2A1750
        BCLR    D0,-$15(A1,A2.L)                ; $2A1752
        ADD.W  D6,-(A1)                         ; $2A1756
        BCLR    D0,$5E(A1,A5.W)                 ; $2A1758
        SUB.B  D1,D5                            ; $2A175C
loc_2A175E:
        BCLR    D0,-$51(A1,A2.L)                ; $2A175E
        ROR.B  D0,D1                            ; $2A1762
        BCLR    D0,-$24(A1,A1.W)                ; $2A1764
        MOVEA.L $01B191CA,A6                    ; $2A1768
        MOVE.L  #$01B1ACE8,(A6)+                ; $2A176E
        ADDA.L  (A4),A7                         ; $2A1774
        BCLR    D0,-$32(A1,A1.W)                ; $2A1776
        ADD.B  D2,-$4F(A6,D0.W)                 ; $2A177A
        MOVE.L  A5,(A7)                         ; $2A177E
        MOVE.L  A3,-(A0)                        ; $2A1780
        BCLR    D0,$7A(A1,A2.L)                 ; $2A1782
        MOVE.L  A6,-$4F(A0,D0.W)                ; $2A1786
        SUB.W  D0,D1                            ; $2A178A
        ADD.L  (A7)+,D2                         ; $2A178C
        BCLR    D0,$52(A1,A2.L)                 ; $2A178E
        DC.W    $23BD,$01B1         ; $2A1792 MOVE.L  <EA:3D>,-$4F(A1,D0.W)
        ADD.W  D6,D1                            ; $2A1796
        BGE.S  loc_2A1739                       ; $2A1798
        BCLR    D0,-$1E(A1,A5.W)                ; $2A179A
        BLT.S  loc_2A175E                       ; $2A179E
        BCLR    D0,$7E(A1,A2.L)                 ; $2A17A0
        MOVE.L  D2,D2                           ; $2A17A4
        BCLR    D0,-$78(A1,A1.W)                ; $2A17A6
        MOVE.L  -$4F(A4,D0.W),(A7)+             ; $2A17AA
        ADDA.L  D5,A6                           ; $2A17AE
        ST      -$4F(A6,D0.W)                   ; $2A17B0
        ADD.W  D6,-(A1)                         ; $2A17B4
        ADDQ.B  #1,(A5)                         ; $2A17B6
        BCLR    D0,$05(A1,A1.W)                 ; $2A17B8
        MOVE.L  -(A2),-$4F(A7,D0.W)             ; $2A17BC
        ADD.B  (A3),D1                          ; $2A17C0
        BGT.S  loc_2A17A5                       ; $2A17C2
        BCLR    D0,-$66(A1,A7.W)                ; $2A17C4
        MOVE.B  $01B1(PC),(A3)                  ; $2A17C8
        MOVE.W  (A0)+,(A4)                      ; $2A17CC
        MOVE.B  -$4F(A3,D0.W),-$2BFE(A3)        ; $2A17CE
        BLE.S  loc_2A1795                       ; $2A17D4
        BCLR    D0,-$13(A1,D2.L)                ; $2A17D6
        BGT.S  loc_2A17BD                       ; $2A17DA
        BCLR    D0,$6C(A1,D0.L)                 ; $2A17DC
        MOVE.B  $01B1.W,(A3)                    ; $2A17E0
        BCHG    D5,(A0)+                        ; $2A17E4
        MOVE.B  (A1),$01B1(PC)                  ; $2A17E6
        DC.W    $2FE8,$6E20         ; $2A17EA MOVE.L  $6E20(A0),<EA:3F>
        BCLR    D0,-$1F(A1,D6.L)                ; $2A17EE
        DC.W    $2DED,$01B1         ; $2A17F2 MOVE.L  $01B1(A5),<EA:3E>
        MOVE.B  $0966(PC),(A3)                  ; $2A17F6
        BCLR    D0,$73(A1,D1.W)                 ; $2A17FA
        BCHG    D3,$01B1(A0)                    ; $2A17FE
        BLE.S  loc_2A17C3                       ; $2A1802
        DC.W    $2BFE               ; $2A1804 MOVE.L  <EA:3E>,<EA:3D>
        BCLR    D0,-$1F(A1,D6.L)                ; $2A1806
        ADD.B  (A3),D1                          ; $2A180A
        BCLR    D0,-$48(A1,D1.W)                ; $2A180C
        MOVE.W  (A4),(A3)                       ; $2A1810
        BCLR    D0,-$2F(A1,D1.W)                ; $2A1812
        MOVE.W  $01B1(A0),(A2)                  ; $2A1816
        BGT.S  loc_2A183C                       ; $2A181A
        ADD.B  (A0)+,D0                         ; $2A181C
        BCLR    D0,-$13(A1,D2.L)                ; $2A181E
        SUB.B  D0,(A7)+                         ; $2A1822
        BCLR    D0,$66(A1,D0.L)                 ; $2A1824
        ASL.W  #4,D6                            ; $2A1828
        BCLR    D0,$68(A1,D0.W)                 ; $2A182A
        LSR.L  #4,D5                            ; $2A182E
        BCLR    D0,-$02(A1,D2.L)                ; $2A1830
        SUB.W  D1,D0                            ; $2A1834
        BCLR    D0,$13(A1,A5.W)                 ; $2A1836
        SUB.B  D0,(A7)+                         ; $2A183A
loc_2A183C:
        BCLR    D0,-$6C(A1,A7.W)                ; $2A183C
        LSL.W  #4,D0                            ; $2A1840
        BCLR    D0,-$58(A1,A7.W)                ; $2A1842
        LSR.B  D5,D7                            ; $2A1846
        BCLR    D0,$18(A1,A5.W)                 ; $2A1848
        SUBA.L  -(A0),A0                        ; $2A184C
        BCLR    D0,$1F(A1,A1.W)                 ; $2A184E
        ADD.B  (A3),D1                          ; $2A1852
        BCLR    D0,$46(A1,A6.L)                 ; $2A1854
        MOVE.W  (A2)+,(A3)                      ; $2A1858
        BCLR    D0,-$73(A1,A6.L)                ; $2A185A
        MOVE.W  (A0)+,(A4)                      ; $2A185E
        BCLR    D0,$41(A1,A1.W)                 ; $2A1860
        ADD.B  D2,D2                            ; $2A1864
        BCLR    D0,$1F(A1,A1.W)                 ; $2A1866
        DC.W    $2DED,$01B1         ; $2A186A MOVE.L  $01B1(A5),<EA:3E>
        LSL.W  #4,D0                            ; $2A186E
        BCHG    D4,$01B1(A4)                    ; $2A1870
loc_2A1874:
        LSR.B  D5,D7                            ; $2A1874
        BCHG    D5,(A0)+                        ; $2A1876
        BCLR    D0,-$20(A1,A1.W)                ; $2A1878
        DC.W    $2FE8,$01B1         ; $2A187C MOVE.L  $01B1(A0),<EA:3F>
        ASR.W  #8,D5                            ; $2A1880
        ADDQ.B  #1,-(A3)                        ; $2A1882
        DC.W    $0000,$E0EA         ; $2A1884 ORI.B  #$E0EA,D0
        DBT     D4,loc_2A188A                   ; $2A1888
        MOVEA.L $4FD8(A4),A0                    ; $2A188C
        DC.W    $0000,$2112         ; $2A1890 ORI.B  #$2112,D0
        SUBQ.W  #8,$0000(A0)                    ; $2A1894
        ADD.B  -$3F(A1,D6.L),D2                 ; $2A1898
        DC.W    $0000,$D489         ; $2A189C ORI.B  #$D489,D0
        BGT.S  loc_2A1874                       ; $2A18A0
        DC.W    $0000,$2D03         ; $2A18A2 ORI.B  #$2D03,D0
        BGT.S  loc_2A18EA                       ; $2A18A6
        DC.W    $0000,$2D57         ; $2A18A8 ORI.B  #$2D57,D0
        BLE.S  loc_2A18C4                       ; $2A18AC
        DC.W    $0000,$23A4         ; $2A18AE ORI.B  #$23A4,D0
        ADDQ.L  #8,D5                           ; $2A18B2
        DC.W    $0000,$2326         ; $2A18B4 ORI.B  #$2326,D0
        DC.W    $4F1D               ; $2A18B8 DC.W    $4F1D
        DC.W    $0000,$4F62         ; $2A18BA ORI.B  #$4F62,D0
        MOVE.L  D7,$00(A0,D0.W)                 ; $2A18BE
        ST      $2E(A2,D2.W)                    ; $2A18C2
        DC.W    $0000,$300B         ; $2A18C6 ORI.B  #$300B,D0
        BGT.S  loc_2A18CD                       ; $2A18CA
        DC.W    $0000,$2FA0         ; $2A18CC ORI.B  #$2FA0,D0
        BLT.S  loc_2A18EC                       ; $2A18D0
        DC.W    $0000,$6DCA         ; $2A18D2 ORI.B  #$6DCA,D0
        MOVE.L  -(A2),D7                        ; $2A18D6
        DC.W    $0000,$6E9C         ; $2A18D8 ORI.B  #$6E9C,D0
        MOVEA.L #$00005223,A7                   ; $2A18DC
        MOVE.B  $00(PC,D0.W),-$34(A7,D5.W)      ; $2A18E2
        MOVE.B  (A6),-(A7)                      ; $2A18E8
loc_2A18EA:
        DC.W    $0000,$4FD8         ; $2A18EA ORI.B  #$4FD8,D0
        ADD.L  D7,(A4)                          ; $2A18EE
        DC.W    $0000,$5168         ; $2A18F0 ORI.B  #$5168,D0
        ADDA.W  $0000(A6),A7                    ; $2A18F4
        BLE.S  loc_2A18BB                       ; $2A18F8
        DC.W    $2BCF               ; $2A18FA MOVE.L  A7,<EA:3D>
        DC.W    $0000,$6ED2         ; $2A18FC ORI.B  #$6ED2,D0
        MOVE.L  $00(A7,D0.W),$6E42(A5)          ; $2A1900
        DC.W    $D2FD               ; $2A1906 ADDA.W  <EA:3D>,A1
        DC.W    $0000,$6F16         ; $2A1908 ORI.B  #$6F16,D0
        ADD.L  $0000(A1),D1                     ; $2A190C
        ADDQ.L  #8,D5                           ; $2A1910
        ADD.W  (A4)+,D6                         ; $2A1912
        DC.W    $0000,$4F1D         ; $2A1914 ORI.B  #$4F1D,D0
        ADDA.W  (A2)+,A6                        ; $2A1918
        DC.W    $0000,$2187         ; $2A191A ORI.B  #$2187,D0
        CMP.L  (A6)+,D0                         ; $2A191E
        DC.W    $0000,$222E         ; $2A1920 ORI.B  #$222E,D0
        MOVE.L  A6,-(A7)                        ; $2A1924
        DC.W    $0000,$6E01         ; $2A1926 ORI.B  #$6E01,D0
        MULS    $00(A5,D0.W),D7                 ; $2A192A
        BLT.S  loc_2A194A                       ; $2A192E
        ADD.W  -(A0),D0                         ; $2A1930
        DC.W    $0000,$2E22         ; $2A1932 ORI.B  #$2E22,D0
        SUB.B  $00(A6,D0.W),D1                  ; $2A1936
        MOVEA.L #$91640000,A7                   ; $2A193A
        MOVE.B  -$23(PC,A2.L),$00(A7,D0.W)      ; $2A1940
        MOVE.B  (A6),-(A7)                      ; $2A1946
        MOVE.L  $00(A4,D0.W),-(A7)              ; $2A1948
        ADD.L  D7,(A4)                          ; $2A194C
        CMP.B  $0000(A0),D0                     ; $2A194E
        ADDA.W  -$5168(A6),A7                   ; $2A1952
        DC.W    $0000,$2BCF         ; $2A1956 ORI.B  #$2BCF,D0
        DC.W    $903F               ; $2A195A SUB.B  <EA:3F>,D0
        DC.W    $0000,$2B77         ; $2A195C ORI.B  #$2B77,D0
        SUB.B  D0,$0000(A6)                     ; $2A1960
        DC.W    $D2FD               ; $2A1964 ADDA.W  <EA:3D>,A1
        DC.W    $91BE               ; $2A1966 SUB.L  D0,<EA:3E>
        DC.W    $0000,$D2A9         ; $2A1968 ORI.B  #$D2A9,D0
        SUBA.W  $0000(A2),A0                    ; $2A196C
        ADD.W  (A4)+,D6                         ; $2A1970
        MOVE.L  $00(PC,D0.W),-$2326(A7)         ; $2A1972
        CMPA.W  -(A3),A0                        ; $2A1978
        DC.W    $0000,$B09E         ; $2A197A ORI.B  #$B09E,D0
        ADD.W  $0000AF0E,D7                     ; $2A197E
        ADDA.L  (A2),A6                         ; $2A1984
        DC.W    $0000,$CFF5         ; $2A1986 ORI.B  #$CFF5,D0
        DC.W    $91FF               ; $2A198A SUBA.L  <EA:3F>,A0
        DC.W    $0000,$D060         ; $2A198C ORI.B  #$D060,D0
        SUBA.W  -(A6),A1                        ; $2A1990
        DC.W    $0000,$9236         ; $2A1992 ORI.B  #$9236,D0
        ADDA.L  (A6)+,A0                        ; $2A1996
        DC.W    $0000,$9164         ; $2A1998 ORI.B  #$9164,D0
        ADD.L  D0,D4                            ; $2A199C
        DC.W    $0000,$ADDD         ; $2A199E ORI.B  #$ADDD,D0
        ASR.W  #8,D5                            ; $2A19A2
        DC.W    $0000,$AF34         ; $2A19A4 ORI.B  #$AF34,D0
        ASR.W  $0000(A2)                        ; $2A19A8
        CMP.B  $206C(A0),D0                     ; $2A19AC
        DC.W    $0000,$AE98         ; $2A19B0 ORI.B  #$AE98,D0
        MOVE.L  (A2),-(A0)                      ; $2A19B4
        DC.W    $0000,$903F         ; $2A19B6 ORI.B  #$903F,D0
        ADD.B  $00(A1,D0.W),D2                  ; $2A19BA
        SUB.B  D0,-$2B77(A6)                    ; $2A19BE
loc_2A19C2:
        DC.W    $0000,$91BE         ; $2A19C2 ORI.B  #$91BE,D0
        MOVE.L  D3,-(A6)                        ; $2A19C6
        DC.W    $0000,$90EA         ; $2A19C8 ORI.B  #$90EA,D0
        MOVE.L  (A7),$0000(A6)                  ; $2A19CC
        MOVE.L  -$5C(PC,D2.W),$0000(A7)         ; $2A19D0
        CMPA.W  -(A3),A0                        ; $2A19D6
        MOVE.L  -(A6),-(A1)                     ; $2A19D8
        DC.W    $0000,$DE79         ; $2A19DA ORI.B  #$DE79,D0
        DC.W    $4F62               ; $2A19DE DC.W    $4F62
        DC.W    $0000,$DDD2         ; $2A19E0 ORI.B  #$DDD2,D0
        ST      $00(A2,D0.W)                    ; $2A19E4
        DC.W    $91FF               ; $2A19E8 SUBA.L  <EA:3F>,A0
        MOVE.W  A3,D0                           ; $2A19EA
        DC.W    $0000,$92E6         ; $2A19EC ORI.B  #$92E6,D0
        MOVE.L  -(A0),$00(A7,D0.W)              ; $2A19F0
        ADDA.L  (A6)+,A0                        ; $2A19F4
        BLT.S  loc_2A19C2                       ; $2A19F6
        DC.W    $0000,$D184         ; $2A19F8 ORI.B  #$D184,D0
        BGT.S  loc_2A199A                       ; $2A19FC
        DC.W    $0000,$64CC         ; $2A19FE ORI.B  #$64CC,D0
        DC.W    $2DC6               ; $2A1A02 MOVE.L  D6,<EA:3E>
        BCHG    D1,$6939(A4)                    ; $2A1A04
        MOVE.L  $036C(A3),D3                    ; $2A1A08
        MOVEQ   #$06,D1                         ; $2A1A0C
        MOVE.L  $6C(A3,D0.W),D3                 ; $2A1A0E
        MOVEQ   #$66,D3                         ; $2A1A12
        DC.W    $2DD6               ; $2A1A14 MOVE.L  (A6),<EA:3E>
        BCHG    D1,$71F8(A4)                    ; $2A1A16
        MOVE.W  $6C(A0,D0.W),$692C(A2)          ; $2A1A1A
        MOVE.W  $036C(A1),$6504(A2)             ; $2A1A20
        ADD.L  D1,D2                            ; $2A1A26
        BCHG    D1,$6971(A4)                    ; $2A1A28
        MULS    -(A6),D5                        ; $2A1A2C
        BCHG    D1,$723E(A4)                    ; $2A1A2E
        MULS    $036C(A6),D5                    ; $2A1A32
        MOVEQ   #-$63,D3                        ; $2A1A36
        ADD.L  D1,(A1)                          ; $2A1A38
        BCHG    D1,$7231(A4)                    ; $2A1A3A
        ADD.B  D5,$036C(A4)                     ; $2A1A3E
        BVS.S  loc_2A1AA8                       ; $2A1A42
        ADD.B  D5,-(A4)                         ; $2A1A44
        BCHG    D1,$24D8(A4)                    ; $2A1A46
        SUB.W  D0,A0                            ; $2A1A4A
        BCHG    D1,$2945(A4)                    ; $2A1A4C
        OR.L   D4,$036C(A5)                     ; $2A1A50
        MOVE.W  (A2),D1                         ; $2A1A54
        OR.L   D4,$6C(A5,D0.W)                  ; $2A1A56
        MOVEA.W $58(A1,A1.W),A3                 ; $2A1A5A
        BCHG    D1,$3205(A4)                    ; $2A1A5E
        SUBA.W  $6C(A2,D0.W),A4                 ; $2A1A62
        MOVE.L  $98EB.W,-(A4)                   ; $2A1A66
        BCHG    D1,-$3640(A4)                   ; $2A1A6A
        SUBA.L  (A0),A0                         ; $2A1A6E
loc_2A1A70:
        BCHG    D1,-$31D2(A4)                   ; $2A1A70
        OR.B   $6C(A6,D0.W),D5                  ; $2A1A74
        ADDA.W  -$75C3(PC),A3                   ; $2A1A78
        BCHG    D1,-$24A6(A4)                   ; $2A1A7C
        SUBA.L  -(A0),A0                        ; $2A1A80
        BCHG    D1,-$2913(A4)                   ; $2A1A82
        SUB.W  D4,$6C(PC,D0.W)                  ; $2A1A86
        AND.B  -(A0),D7                         ; $2A1A8A
        SUB.W  D4,$6C(A3,D0.W)                  ; $2A1A8C
        DIVS    -$2E09(A1),D4                   ; $2A1A90
        BCHG    D1,-$71A9(A4)                   ; $2A1A94
        AND.W  (A4)+,D5                         ; $2A1A98
        BCHG    D1,-$68DD(A4)                   ; $2A1A9A
        AND.W  -(A4),D5                         ; $2A1A9E
        BCHG    D1,-$647D(A4)                   ; $2A1AA0
        ADD.B  D7,D1                            ; $2A1AA4
        BCHG    D1,-$68EA(A4)                   ; $2A1AA6
        ADD.L  D4,-(A1)                         ; $2A1AAA
        BCHG    D1,-$71B7(A4)                   ; $2A1AAC
        ADD.L  D4,(A2)+                         ; $2A1AB0
        BCHG    D1,-$7781(A4)                   ; $2A1AB2
        MOVE.L  (A6),D7                         ; $2A1AB6
        BCHG    D1,-$7313(A4)                   ; $2A1AB8
        MOVEA.L $036C(PC),A3                    ; $2A1ABC
        SUB.L  D2,$2683(PC)                     ; $2A1AC0
        BCHG    D1,-$65E7(A4)                   ; $2A1AC4
        MOVE.L  -(A5),D7                        ; $2A1AC8
        BCHG    D1,-$6A54(A4)                   ; $2A1ACA
        MOVE.W  D0,$036C(PC)                    ; $2A1ACE
        DIVU    (A7)+,D6                        ; $2A1AD2
        DC.W    $35B9,$036C,$CA18,$6E1B; $2A1AD4 MOVE.W  $036CCA18,$1B(A2,D6.L)
        BCHG    D1,-$317B(A4)                   ; $2A1ADC
        BNE.S  loc_2A1A63                       ; $2A1AE0
        BCHG    D1,-$28AF(A4)                   ; $2A1AE2
        BNE.S  loc_2A1A70                       ; $2A1AE6
        BCHG    D1,-$244E(A4)                   ; $2A1AE8
        BGT.S  loc_2A1B19                       ; $2A1AEC
        BCHG    D1,-$28BC(A4)                   ; $2A1AEE
        MOVE.W  D6,$036C(PC)                    ; $2A1AF2
        AND.W  -$42(A7,D7.W),D7                 ; $2A1AF6
loc_2A1AFA:
        BCHG    D1,$24D8(A4)                    ; $2A1AFA
        BGT.S  loc_2A1AD9                       ; $2A1AFE
        BCHG    D1,$2944(A4)                    ; $2A1B00
        BEQ.S  loc_2A1B44                       ; $2A1B04
        BCHG    D1,$3211(A4)                    ; $2A1B06
        BEQ.S  loc_2A1B51                       ; $2A1B0A
        BCHG    D1,$3671(A4)                    ; $2A1B0C
        BGT.S  loc_2A1AFA                       ; $2A1B10
        BCHG    D1,$3204(A4)                    ; $2A1B12
        MOVEQ   #-$7C,D3                        ; $2A1B16
        BCHG    D1,$2937(A4)                    ; $2A1B18
        MOVEQ   #$7B,D3                         ; $2A1B1C
        BCHG    D1,$0000(A4)                    ; $2A1B1E
        MOVE.L  D0,D0                           ; $2A1B22
        DC.W    $0000,$0010         ; $2A1B24 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A1B28 ORI.B  #$0030,-(A0)
        DC.W    $0200,$9E00         ; $2A1B2C ANDI.B  #$9E00,D0
        ORI.W  #$0040,(A0)                      ; $2A1B30
        SUBI.B  #$A000,D0                       ; $2A1B34
        ORI.W  #$0070,-(A0)                     ; $2A1B38
        DC.W    $0000,$2000         ; $2A1B3C ORI.B  #$2000,D0
        EORI.L  #$0A900AA0,D0                   ; $2A1B40
        DC.W    $0AB0,$0200,$2000,$0AC0; $2A1B46 EORI.L  #$02002000,-$40(A0,D0.L)
        DC.W    $0AD0               ; $2A1B4E DC.W    $0AD0
        DC.W    $0000,$2000         ; $2A1B50 ORI.B  #$2000,D0
        DC.W    $0AE0               ; $2A1B54 DC.W    $0AE0
        DC.W    $0AF0               ; $2A1B56 DC.W    $0AF0
        BTST    D5,D0                           ; $2A1B58
        BTST    D5,(A0)                         ; $2A1B5A
        DC.W    $0200,$2000         ; $2A1B5C ANDI.B  #$2000,D0
        BTST    D5,-(A0)                        ; $2A1B60
        BTST    D5,$00(A0,D0.W)                 ; $2A1B62
        MOVE.L  D0,D0                           ; $2A1B66
        BCHG    D5,D0                           ; $2A1B68
        BCHG    D5,(A0)                         ; $2A1B6A
        BCHG    D5,-(A0)                        ; $2A1B6C
        BCHG    D5,$00(A0,D0.W)                 ; $2A1B6E
        MOVE.L  D0,D0                           ; $2A1B72
        BCLR    D5,D0                           ; $2A1B74
        BCLR    D5,(A0)                         ; $2A1B76
        DC.W    $0000,$2000         ; $2A1B78 ORI.B  #$2000,D0
        BCLR    D5,-(A0)                        ; $2A1B7C
        BCLR    D5,-$40(A0,D0.L)                ; $2A1B7E
        BSET    D5,(A0)                         ; $2A1B82
        DC.W    $0200,$2000         ; $2A1B84 ANDI.B  #$2000,D0
        BSET    D5,-(A0)                        ; $2A1B88
        BSET    D5,$00(A0,D0.W)                 ; $2A1B8A
        MOVE.L  D0,D0                           ; $2A1B8E
        CMPI.B  #$0C10,D0                       ; $2A1B90
        CMPI.B  #$0C30,-(A0)                    ; $2A1B94
        DC.W    $0200,$2000         ; $2A1B98 ANDI.B  #$2000,D0
        CMPI.W  #$0C50,D0                       ; $2A1B9C
        DC.W    $0000,$2000         ; $2A1BA0 ORI.B  #$2000,D0
        CMPI.W  #$0C70,-(A0)                    ; $2A1BA4
        CMPI.L  #$0C900200,D0                   ; $2A1BA8
        MOVE.L  D0,D0                           ; $2A1BAE
        CMPI.L  #$0CB00000,-(A0)                ; $2A1BB0
        MOVE.L  D0,D0                           ; $2A1BB6
        DC.W    $0CC0               ; $2A1BB8 DC.W    $0CC0
        DC.W    $0CD0               ; $2A1BBA DC.W    $0CD0
        DC.W    $0CE0               ; $2A1BBC DC.W    $0CE0
        DC.W    $0CF0               ; $2A1BBE DC.W    $0CF0
        DC.W    $0200,$2000         ; $2A1BC0 ANDI.B  #$2000,D0
        BTST    D6,D0                           ; $2A1BC4
        BTST    D6,(A0)                         ; $2A1BC6
        DC.W    $0000,$2000         ; $2A1BC8 ORI.B  #$2000,D0
        BTST    D6,-(A0)                        ; $2A1BCC
        BTST    D6,$40(A0,D0.L)                 ; $2A1BCE
        BCHG    D6,(A0)                         ; $2A1BD2
        DC.W    $0200,$2000         ; $2A1BD4 ANDI.B  #$2000,D0
        BCHG    D6,-(A0)                        ; $2A1BD8
        BCHG    D6,$00(A0,D0.W)                 ; $2A1BDA
        SUB.B  D0,D6                            ; $2A1BDE
        ORI.L  #$009000A0,D0                    ; $2A1BE0
        DC.W    $00B0,$0000,$9C00,$00C0; $2A1BE6 ORI.L  #$00009C00,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A1BEE DC.W    $00D0
        DC.W    $00E0               ; $2A1BF0 DC.W    $00E0
        DC.W    $00F0               ; $2A1BF2 DC.W    $00F0
        DC.W    $0000,$B600         ; $2A1BF4 ORI.B  #$B600,D0
        BTST    D0,D0                           ; $2A1BF8
        BTST    D0,(A0)                         ; $2A1BFA
        BTST    D0,-(A0)                        ; $2A1BFC
        BTST    D0,$00(A0,D0.W)                 ; $2A1BFE
        CMP.B  D0,D3                            ; $2A1C02
        BCHG    D0,D0                           ; $2A1C04
        BCHG    D0,(A0)                         ; $2A1C06
        BCHG    D0,-(A0)                        ; $2A1C08
        BCHG    D0,$00(A0,D0.W)                 ; $2A1C0A
        EOR.B  D2,D0                            ; $2A1C0E
        BCLR    D0,D0                           ; $2A1C10
        BCLR    D0,(A0)                         ; $2A1C12
        BCLR    D0,-(A0)                        ; $2A1C14
        BCLR    D0,$00(A0,D0.W)                 ; $2A1C16
        EOR.B  D2,D0                            ; $2A1C1A
        BSET    D0,D0                           ; $2A1C1C
        BSET    D0,(A0)                         ; $2A1C1E
        BSET    D0,-(A0)                        ; $2A1C20
        BSET    D0,$00(A0,D0.W)                 ; $2A1C22
        SUB.B  D0,D6                            ; $2A1C26
        DC.W    $0200,$0210         ; $2A1C28 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2A1C2C ANDI.B  #$0230,-(A0)
        DC.W    $0000,$9C00         ; $2A1C30 ORI.B  #$9C00,D0
        ANDI.W  #$0250,D0                       ; $2A1C34
        ANDI.W  #$0270,-(A0)                    ; $2A1C38
        DC.W    $0000,$B400         ; $2A1C3C ORI.B  #$B400,D0
        ANDI.L  #$029002A0,D0                   ; $2A1C40
        DC.W    $02B0,$0000,$B400,$02C0; $2A1C46 ANDI.L  #$0000B400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A1C4E DC.W    $02D0
        DC.W    $02E0               ; $2A1C50 DC.W    $02E0
        DC.W    $02F0               ; $2A1C52 DC.W    $02F0
        DC.W    $0000,$B700         ; $2A1C54 ORI.B  #$B700,D0
        BTST    D1,D0                           ; $2A1C58
        BTST    D1,(A0)                         ; $2A1C5A
        BTST    D1,-(A0)                        ; $2A1C5C
        BTST    D1,$00(A0,D0.W)                 ; $2A1C5E
        EOR.B  D3,D0                            ; $2A1C62
        BCHG    D1,D0                           ; $2A1C64
        BCHG    D1,(A0)                         ; $2A1C66
        BCHG    D1,-(A0)                        ; $2A1C68
        BCHG    D1,$00(A0,D0.W)                 ; $2A1C6A
        CMP.B  D0,D3                            ; $2A1C6E
        BCLR    D1,D0                           ; $2A1C70
        BCLR    D1,(A0)                         ; $2A1C72
        BCLR    D1,-(A0)                        ; $2A1C74
        BCLR    D1,$00(A0,D0.W)                 ; $2A1C76
        CMP.B  D0,D3                            ; $2A1C7A
        BSET    D1,D0                           ; $2A1C7C
        BSET    D1,(A0)                         ; $2A1C7E
        BSET    D1,-(A0)                        ; $2A1C80
        BSET    D1,$00(A0,D0.W)                 ; $2A1C82
        EOR.B  D2,D0                            ; $2A1C86
        SUBI.B  #$0410,D0                       ; $2A1C88
        SUBI.B  #$0430,-(A0)                    ; $2A1C8C
        DC.W    $0000,$B500         ; $2A1C90 ORI.B  #$B500,D0
        SUBI.W  #$0450,D0                       ; $2A1C94
        SUBI.W  #$0470,-(A0)                    ; $2A1C98
        DC.W    $0000,$B500         ; $2A1C9C ORI.B  #$B500,D0
        SUBI.L  #$049004A0,D0                   ; $2A1CA0
        DC.W    $04B0,$0000,$9C00,$04C0; $2A1CA6 SUBI.L  #$00009C00,-$40(A0,D0.W)
        DC.W    $04D0               ; $2A1CAE DC.W    $04D0
        DC.W    $04E0               ; $2A1CB0 DC.W    $04E0
        DC.W    $04F0               ; $2A1CB2 DC.W    $04F0
        DC.W    $0000,$B600         ; $2A1CB4 ORI.B  #$B600,D0
        BTST    D2,D0                           ; $2A1CB8
        BTST    D2,(A0)                         ; $2A1CBA
        BTST    D2,-(A0)                        ; $2A1CBC
        BTST    D2,$00(A0,D0.W)                 ; $2A1CBE
        EOR.B  D2,D0                            ; $2A1CC2
        BCHG    D2,D0                           ; $2A1CC4
        BCHG    D2,(A0)                         ; $2A1CC6
        BCHG    D2,-(A0)                        ; $2A1CC8
        BCHG    D2,$00(A0,D0.W)                 ; $2A1CCA
        SUB.B  D0,D6                            ; $2A1CCE
        BCLR    D2,D0                           ; $2A1CD0
        BCLR    D2,(A0)                         ; $2A1CD2
        BCLR    D2,-(A0)                        ; $2A1CD4
        BCLR    D2,$00(A0,D0.W)                 ; $2A1CD6
        CMP.B  D0,D2                            ; $2A1CDA
        BSET    D2,D0                           ; $2A1CDC
        BSET    D2,(A0)                         ; $2A1CDE
        BSET    D2,-(A0)                        ; $2A1CE0
        BSET    D2,$00(A0,D0.W)                 ; $2A1CE2
        EOR.B  D3,D0                            ; $2A1CE6
        ADDI.B  #$0610,D0                       ; $2A1CE8
        ADDI.B  #$0630,-(A0)                    ; $2A1CEC
        DC.W    $0000,$B600         ; $2A1CF0 ORI.B  #$B600,D0
        ADDI.W  #$0650,D0                       ; $2A1CF4
        ADDI.W  #$0670,-(A0)                    ; $2A1CF8
        DC.W    $0000,$1C00         ; $2A1CFC ORI.B  #$1C00,D0
        ADDI.L  #$069006A0,D0                   ; $2A1D00
        DC.W    $06B0,$0000,$1C00,$06C0; $2A1D06 ADDI.L  #$00001C00,-$40(A0,D0.W)
        DC.W    $06D0               ; $2A1D0E DC.W    $06D0
        DC.W    $06E0               ; $2A1D10 DC.W    $06E0
        DC.W    $06F0               ; $2A1D12 DC.W    $06F0
        DC.W    $0000,$1C00         ; $2A1D14 ORI.B  #$1C00,D0
        BTST    D3,D0                           ; $2A1D18
        BTST    D3,(A0)                         ; $2A1D1A
        BTST    D3,-(A0)                        ; $2A1D1C
        BTST    D3,$00(A0,D0.W)                 ; $2A1D1E
        MOVE.B  D0,D6                           ; $2A1D22
        BCHG    D3,D0                           ; $2A1D24
        BCHG    D3,(A0)                         ; $2A1D26
        BCHG    D3,-(A0)                        ; $2A1D28
        BCHG    D3,$00(A0,D0.W)                 ; $2A1D2A
        MOVE.B  D0,D6                           ; $2A1D2E
        BCLR    D3,D0                           ; $2A1D30
        BCLR    D3,(A0)                         ; $2A1D32
        BCLR    D3,-(A0)                        ; $2A1D34
        BCLR    D3,$00(A0,D0.W)                 ; $2A1D36
        MOVE.B  D0,D6                           ; $2A1D3A
        BSET    D3,D0                           ; $2A1D3C
        BSET    D3,(A0)                         ; $2A1D3E
        BSET    D3,-(A0)                        ; $2A1D40
        BSET    D3,$00(A0,D0.W)                 ; $2A1D42
        MOVE.B  D0,D6                           ; $2A1D46
        BTST    #16,D0                          ; $2A1D48
        BTST    #16,-(A0)                       ; $2A1D4C
        DC.W    $0000,$1C00         ; $2A1D50 ORI.B  #$1C00,D0
        BCHG    #16,D0                          ; $2A1D54
        BCHG    #16,-(A0)                       ; $2A1D58
        DC.W    $0000,$1C00         ; $2A1D5C ORI.B  #$1C00,D0
        BCLR    #16,D0                          ; $2A1D60
        BCLR    #16,-(A0)                       ; $2A1D64
        DC.W    $0000,$1C00         ; $2A1D68 ORI.B  #$1C00,D0
        BSET    #16,D0                          ; $2A1D6C
        BSET    #16,-(A0)                       ; $2A1D70
        DC.W    $0000,$1C00         ; $2A1D74 ORI.B  #$1C00,D0
        BTST    D4,D0                           ; $2A1D78
        BTST    D4,(A0)                         ; $2A1D7A
        BTST    D4,-(A0)                        ; $2A1D7C
        BTST    D4,$00(A0,D0.W)                 ; $2A1D7E
        MOVE.B  D0,D6                           ; $2A1D82
        BCHG    D4,D0                           ; $2A1D84
        BCHG    D4,(A0)                         ; $2A1D86
        BCHG    D4,-(A0)                        ; $2A1D88
        BCHG    D4,$00(A0,D0.W)                 ; $2A1D8A
        MOVE.B  D0,D6                           ; $2A1D8E
        BCLR    D4,D0                           ; $2A1D90
        BCLR    D4,(A0)                         ; $2A1D92
        BCLR    D4,-(A0)                        ; $2A1D94
        BCLR    D4,$00(A0,D0.W)                 ; $2A1D96
        MOVE.B  D0,D6                           ; $2A1D9A
        BSET    D4,D0                           ; $2A1D9C
        BSET    D4,(A0)                         ; $2A1D9E
        BSET    D4,-(A0)                        ; $2A1DA0
        BSET    D4,$00(A0,D0.W)                 ; $2A1DA2
        MOVE.B  D0,D6                           ; $2A1DA6
        DC.W    $0A00,$0A10         ; $2A1DA8 EORI.B  #$0A10,D0
        DC.W    $0A20,$0A30         ; $2A1DAC EORI.B  #$0A30,-(A0)
        DC.W    $0000,$1C00         ; $2A1DB0 ORI.B  #$1C00,D0
        EORI.W  #$0A50,D0                       ; $2A1DB4
        EORI.W  #$0A70,-(A0)                    ; $2A1DB8
        CMPI.B  #$001A,D0                       ; $2A1DBC
        DC.W    $001A,$0000         ; $2A1DC0 ORI.B  #$0000,(A2)+
        BVS.S  loc_2A1D5E                       ; $2A1DC4
        BCHG    D4,D2                           ; $2A1DC6
        DC.W    $0000,$6998         ; $2A1DC8 ORI.B  #$6998,D0
        MOVE.W  A1,(A3)                         ; $2A1DCC
        DC.W    $0000,$6C03         ; $2A1DCE ORI.B  #$6C03,D0
        MOVE.W  $00(A3,D0.W),(A3)+              ; $2A1DD2
        BGE.S  loc_2A1DDB                       ; $2A1DD6
        BSET    #25,(A2)+                       ; $2A1DD8
        DC.W    $4533               ; $2A1DDC DC.W    $4533
        MOVEA.W -(A3),A0                        ; $2A1DDE
        CMP.B  D4,D1                            ; $2A1DE0
        DC.W    $0002,$E4B0         ; $2A1DE2 ORI.B  #$E4B0,D2
        CMP.B  D4,D1                            ; $2A1DE6
        DC.W    $010D               ; $2A1DE8 BTST    D0,A5
        ADDA.W  D4,A7                           ; $2A1DEA
        LSL.W  $4592EA69                        ; $2A1DEC
        BCHG    D6,$5972(A0)                    ; $2A1DF2
        MOVE.W  A7,$00006C03                    ; $2A1DF6
        MOVE.W  $68(A1,D0.L),(A0)+              ; $2A1DFC
        SUBQ.L  #4,-(A0)                        ; $2A1E00
        ROXL.W  (A1)                            ; $2A1E02
        DC.W    $0000,$6C03         ; $2A1E04 ORI.B  #$6C03,D0
        DC.W    $0EFB               ; $2A1E08 DC.W    $0EFB
        CMP.B  D4,D1                            ; $2A1E0A
        BTST    D0,D2                           ; $2A1E0C
        MOVE.L  $04(A4,A3.W),-(A0)              ; $2A1E0E
        DC.W    $FFF8,$1B48         ; $2A1E12 MOVE.W  $1B48.W,<EA:3F>
        DC.W    $4E05               ; $2A1E16 DC.W    $4E05
        DC.W    $FFF8,$1B48         ; $2A1E18 MOVE.W  $1B48.W,<EA:3F>
        DC.W    $4E05               ; $2A1E1C DC.W    $4E05
        BTST    D0,D2                           ; $2A1E1E
        MOVE.L  -$7E(A4,A6.L),-(A0)             ; $2A1E20
        SUBQ.W  #8,D5                           ; $2A1E24
        ASR.W  D6,D6                            ; $2A1E26
        ASR.L  #6,D2                            ; $2A1E28
        SUBQ.B  #8,D3                           ; $2A1E2A
        MOVEA.W -(A2),A1                        ; $2A1E2C
        MOVE.B  $4C42(A1),-(A3)                 ; $2A1E2E
        LSL.L  #5,D4                            ; $2A1E32
        DC.W    $4E05               ; $2A1E34 DC.W    $4E05
        DC.W    $010D               ; $2A1E36 BTST    D0,A5
        ADDA.W  D4,A7                           ; $2A1E38
        DC.W    $4E05               ; $2A1E3A DC.W    $4E05
        DC.W    $0002,$E4B0         ; $2A1E3C ORI.B  #$E4B0,D2
        MOVE.B  $4BF2(A1),-(A3)                 ; $2A1E40
        MOVE.W  D7,$2F(A0,A6.W)                 ; $2A1E44
        JSR     A0                              ; $2A1E48
        LSR.L  D5,D1                            ; $2A1E4A
        LSL.B  #4,D2                            ; $2A1E4C
        DC.W    $41A8               ; $2A1E4E DC.W    $41A8
        ROR.B  D4,D4                            ; $2A1E50
        MOVEA.B -(A3),A5                        ; $2A1E52
        DC.W    $4D1F               ; $2A1E54 DC.W    $4D1F
        ROR.L  #5,D2                            ; $2A1E56
        MOVEA.B $5C87(A3),A6                    ; $2A1E58
        LSL.L  #6,D6                            ; $2A1E5C
        DC.W    $0000,$AB00         ; $2A1E5E ORI.B  #$AB00,D0
        ORI.L  #$00200090,D0                    ; $2A1E62
        ORI.L  #$0600AB00,-(A0)                 ; $2A1E68
        BTST    D0,(A0)                         ; $2A1E6E
        BTST    D0,D0                           ; $2A1E70
        DC.W    $0000,$AB00         ; $2A1E72 ORI.B  #$AB00,D0
        DC.W    $00B0,$00C0,$00D0,$0030; $2A1E76 ORI.L  #$00C000D0,$30(A0,D0.W)
        DC.W    $0200,$AB00         ; $2A1E7E ANDI.B  #$AB00,D0
        DC.W    $00E0               ; $2A1E82 DC.W    $00E0
        DC.W    $00F0               ; $2A1E84 DC.W    $00F0
        DC.W    $0000,$AE00         ; $2A1E86 ORI.B  #$AE00,D0
        DC.W    $0000,$0010         ; $2A1E8A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A1E8E ORI.B  #$0030,-(A0)
        DC.W    $0000,$AB00         ; $2A1E92 ORI.B  #$AB00,D0
        ORI.W  #$0050,D0                        ; $2A1E96
        ORI.W  #$0070,-(A0)                     ; $2A1E9A
        DC.W    $0000,$AB00         ; $2A1E9E ORI.B  #$AB00,D0
        BTST    D0,-(A0)                        ; $2A1EA2
        BTST    D0,$40(A0,D0.W)                 ; $2A1EA4
        BCHG    D0,(A0)                         ; $2A1EA8
        DC.W    $0004,$1A00         ; $2A1EAA ORI.B  #$1A00,D4
        BCHG    D0,-(A0)                        ; $2A1EAE
        BCHG    D0,-$80(A0,D0.W)                ; $2A1EB0
        BCLR    D0,(A0)                         ; $2A1EB4
        CMPI.B  #$0032,D0                       ; $2A1EB6
        DC.W    $0032,$0004,$0009   ; $2A1EBA ORI.B  #$0004,$09(A2,D0.W)
        MOVE.W  $04(PC,D0.W),#$0009             ; $2A1EC0
        MOVE.W  (A5)+,(A4)+                     ; $2A1EC6
        MOVE.L  $20(A7,A2.L),-(A2)              ; $2A1EC8
        MOVE.W  $37(A1,D2.W),(A4)+              ; $2A1ECC
        MOVE.L  -(A0),D7                        ; $2A1ED0
        MOVE.W  -$4C(PC,A5.L),#$B2FD            ; $2A1ED2
        MOVE.W  -$4C(PC,A5.L),#$B2FD            ; $2A1ED8
        MOVE.W  $04(A0,D0.W),(A4)+              ; $2A1EDE
        DC.W    $0009,$0716         ; $2A1EE2 ORI.B  #$0716,A1
        DC.W    $0004,$0009         ; $2A1EE6 ORI.B  #$0009,D4
        BSET    D2,$37(A7,D2.W)                 ; $2A1EEA
        MOVE.L  -(A0),D7                        ; $2A1EEE
        ADDI.B  #$2537,A4                       ; $2A1EF0
        MOVE.L  -(A0),D7                        ; $2A1EF4
        BTST    D3,(A6)                         ; $2A1EF6
        ADD.L  -$03(A4,A3.W),D6                 ; $2A1EF8
        BTST    D3,(A6)                         ; $2A1EFC
        ADD.L  -$03(A4,A3.W),D6                 ; $2A1EFE
        ADDI.B  #$242C,A3                       ; $2A1F02
        MOVE.L  -$33(A5,A7.L),-(A5)             ; $2A1F06
        MOVE.L  -$587D(A4),D2                   ; $2A1F0A
        DC.W    $0000,$2CB6         ; $2A1F0E ORI.B  #$2CB6,D0
        CMP.B  (A7)+,D2                         ; $2A1F12
        DC.W    $0000,$0DD0         ; $2A1F14 ORI.B  #$0DD0,D0
        MOVE.L  $5B(A1,A7.W),-$30(A2,D0.L)      ; $2A1F18
        SUB.L  D7,$00(A7,D0.W)                  ; $2A1F1E
        MOVE.W  -$4F(A0,A2.W),D1                ; $2A1F22
        MOVEA.W (A3)+,A2                        ; $2A1F26
        MOVE.W  -$49(A0,A1.L),D1                ; $2A1F28
        DC.W    $0000,$DBD4         ; $2A1F2C ORI.B  #$DBD4,D0
        MOVE.L  -$33(A5,A7.L),-(A5)             ; $2A1F30
        ADDA.L  (A4),A5                         ; $2A1F34
        MOVE.L  D3,$00(A3,D0.W)                 ; $2A1F36
        ADD.W  D1,A2                            ; $2A1F3A
        CMP.B  (A7)+,D2                         ; $2A1F3C
        DC.W    $0000,$242C         ; $2A1F3E ORI.B  #$242C,D0
        CMPA.L  -(A5),A0                        ; $2A1F42
        MOVE.W  (A1),(A3)                       ; $2A1F44
        BSET    D6,(A0)                         ; $2A1F46
        CMP.L  D4,D0                            ; $2A1F48
        MOVE.W  #$F230,(A0)                     ; $2A1F4A
        CMP.L  D4,D0                            ; $2A1F4E
        MOVE.W  #$DBD4,(A0)                     ; $2A1F50
        CMPA.L  -(A5),A0                        ; $2A1F54
        MOVE.W  (A1),(A3)                       ; $2A1F56
        MOVE.L  -$54CB(A4),D2                   ; $2A1F58
        BTST    D3,$2C(A3,D2.W)                 ; $2A1F5C
        CMPA.L  -(A5),A0                        ; $2A1F60
        BCHG    D4,$0DD0(A7)                    ; $2A1F62
        MOVE.L  -$5B(A1,D0.L),-$30(A2,D0.L)     ; $2A1F66
        CMP.L  D4,D0                            ; $2A1F6C
        BCHG    D7,D4                           ; $2A1F6E
        MOVE.W  -$4F(A0,A2.W),D1                ; $2A1F70
        BCLR    D5,-(A5)                        ; $2A1F74
        MOVE.W  -$7C(A0,A3.W),D1                ; $2A1F76
        BCHG    D7,D4                           ; $2A1F7A
        ADDA.L  (A4),A5                         ; $2A1F7C
        MOVE.L  $33(A5,D0.W),-(A5)              ; $2A1F7E
        ADDA.L  (A4),A5                         ; $2A1F82
        CMPA.L  -(A5),A0                        ; $2A1F84
        BCHG    D4,-$0199(A7)                   ; $2A1F86
        ADD.B  D3,(A6)+                         ; $2A1F8A
        DC.W    $0000,$FE67         ; $2A1F8C ORI.B  #$FE67,D0
        CMP.W  A2,D0                            ; $2A1F90
        DC.W    $0000,$0199         ; $2A1F92 ORI.B  #$0199,D0
        CMP.W  A2,D0                            ; $2A1F96
        DC.W    $0000,$0199         ; $2A1F98 ORI.B  #$0199,D0
        ADD.B  D3,(A6)+                         ; $2A1F9C
        DC.W    $0000,$F693         ; $2A1F9E ORI.B  #$F693,D0
        CMP.B  (A4),D7                          ; $2A1FA2
        MOVE.W  -$078D(A5),D7                   ; $2A1FA4
        CMP.B  -$01D3(A6),D5                    ; $2A1FA8
        BCHG    D3,$2E(A2,A3.L)                 ; $2A1FAC
        MOVE.W  $0952(A5),D7                    ; $2A1FB0
        CMP.B  (A4),D7                          ; $2A1FB4
        MOVE.W  -$07CD(A5),D7                   ; $2A1FB6
        AND.L  $2D(A7,A7.L),D6                  ; $2A1FBA
        MOVE.W  (A3),D5                         ; $2A1FBE
        MULU    (A0),D4                         ; $2A1FC0
        MOVE.W  $0551(A5),D7                    ; $2A1FC2
        MULU    (A0),D4                         ; $2A1FC6
        MOVE.W  $0732(A5),D7                    ; $2A1FC8
        AND.L  $2D(A7,A7.L),D6                  ; $2A1FCC
        MOVEA.W (A3),A5                         ; $2A1FD0
        ADDA.L  -$01D3(PC),A0                   ; $2A1FD2
        MOVE.W  $14(A3,A4.L),D6                 ; $2A1FD6
        MOVE.W  $03B2(A5),D7                    ; $2A1FDA
        AND.B  (A4),D7                          ; $2A1FDE
        MOVE.W  $0592(A5),D7                    ; $2A1FE0
        ADDA.L  -$01D3(PC),A0                   ; $2A1FE4
        DC.W    $0000,$BA00         ; $2A1FE8 ORI.B  #$BA00,D0
        DC.W    $00F0               ; $2A1FEC DC.W    $00F0
        BTST    D0,D0                           ; $2A1FEE
        DC.W    $00D0               ; $2A1FF0 DC.W    $00D0
        DC.W    $00C0               ; $2A1FF2 DC.W    $00C0
        SUBI.B  #$B901,D1                       ; $2A1FF4
        DC.W    $00E0               ; $2A1FF8 DC.W    $00E0
        DC.W    $0201,$B801         ; $2A1FFA ANDI.B  #$B801,D1
        BCHG    D0,-(A0)                        ; $2A1FFE
        DC.W    $0200,$B900         ; $2A2000 ANDI.B  #$B900,D0
        BCHG    D0,-$10(A0,D0.W)                ; $2A2004
        SUBI.B  #$BA00,D0                       ; $2A2008
        BCLR    D0,D0                           ; $2A200C
        BTST    D0,(A0)                         ; $2A200E
        DC.W    $0200,$BB00         ; $2A2010 ANDI.B  #$BB00,D0
        BTST    D0,-(A0)                        ; $2A2014
        BTST    D0,D0                           ; $2A2016
        ADDI.B  #$BA00,D0                       ; $2A2018
        BTST    D0,$40(A0,D0.W)                 ; $2A201C
        ADDI.B  #$B900,D0                       ; $2A2020
        BCLR    D0,D0                           ; $2A2024
        BCLR    D0,(A0)                         ; $2A2026
        DC.W    $0201,$B801         ; $2A2028 ANDI.B  #$B801,D1
        BCHG    D0,(A0)                         ; $2A202C
        DC.W    $0201,$B901         ; $2A202E ANDI.B  #$B901,D1
        BCHG    D0,D0                           ; $2A2032
        ADDI.B  #$BA01,D1                       ; $2A2034
        DC.W    $0200,$0601         ; $2A2038 ANDI.B  #$0601,D0
        EOR.B  D5,D1                            ; $2A203C
        DC.W    $0210,$0200         ; $2A203E ANDI.B  #$0200,(A0)
        CMP.B  D0,D6                            ; $2A2042
        BSET    D0,-$20(A0,D0.W)                ; $2A2044
        SUBI.B  #$BD00,D0                       ; $2A2048
        BSET    D0,(A0)                         ; $2A204C
        BSET    D0,D0                           ; $2A204E
        SUBI.B  #$BC00,D0                       ; $2A2050
        BCLR    D0,-$60(A0,D0.W)                ; $2A2054
        SUBI.B  #$BB01,D1                       ; $2A2058
        DC.W    $00E0               ; $2A205C DC.W    $00E0
        DC.W    $0201,$BA01         ; $2A205E ANDI.B  #$BA01,D1
        DC.W    $00D0               ; $2A2062 DC.W    $00D0
        DC.W    $0200,$BB00         ; $2A2064 ANDI.B  #$BB00,D0
        BTST    D0,D0                           ; $2A2068
        BSET    D0,D0                           ; $2A206A
        SUBI.B  #$BC00,D0                       ; $2A206C
        BTST    D0,-(A0)                        ; $2A2070
        BSET    D0,-(A0)                        ; $2A2072
        SUBI.B  #$BB00,D0                       ; $2A2074
        BCHG    D0,D0                           ; $2A2078
        DC.W    $0200,$0000         ; $2A207A ANDI.B  #$0000,D0
        MOVE.B  D0,-(A5)                        ; $2A207E
        DC.W    $0000,$0010         ; $2A2080 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A2084 ORI.B  #$0030,-(A0)
        DC.W    $0000,$1B00         ; $2A2088 ORI.B  #$1B00,D0
        DC.W    $0010,$0000         ; $2A208C ORI.B  #$0000,(A0)
        ORI.W  #$0050,D0                        ; $2A2090
        DC.W    $0000,$1B00         ; $2A2094 ORI.B  #$1B00,D0
        ORI.W  #$0070,-(A0)                     ; $2A2098
        ORI.L  #$00900000,D0                    ; $2A209C
        MOVE.B  D0,-(A5)                        ; $2A20A2
        ORI.W  #$0060,-$60(A0,D0.W)             ; $2A20A4
        DC.W    $00B0,$0000,$A300,$0220; $2A20AA ORI.L  #$0000A300,$20(A0,D0.W)
        DC.W    $0230,$0240,$0250   ; $2A20B2 ANDI.B  #$0240,$50(A0,D0.W)
        DC.W    $0000,$2000         ; $2A20B8 ORI.B  #$2000,D0
        ANDI.W  #$0270,-(A0)                    ; $2A20BC
        ANDI.L  #$02900000,D0                   ; $2A20C0
        MOVE.L  D0,D0                           ; $2A20C6
        ANDI.L  #$02B002C0,-(A0)                ; $2A20C8
        DC.W    $02D0               ; $2A20CE DC.W    $02D0
        DC.W    $0000,$2000         ; $2A20D0 ORI.B  #$2000,D0
        DC.W    $02E0               ; $2A20D4 DC.W    $02E0
        DC.W    $02F0               ; $2A20D6 DC.W    $02F0
        BTST    D1,D0                           ; $2A20D8
        BTST    D1,(A0)                         ; $2A20DA
        CMPI.B  #$000D,D0                       ; $2A20DC
        DC.W    $0000,$F16A         ; $2A20E0 ORI.B  #$F16A,D0
        ROXL.L  #5,D3                           ; $2A20E4
        DC.W    $0E7A               ; $2A20E6 DC.W    $0E7A
        MOVE.W  #$EB93,-(A0)                    ; $2A20E8
        MOVE.W  D6,-(A0)                        ; $2A20EC
        DC.W    $F3FE,$020C,$F373   ; $2A20EE MOVE.W  <EA:3E>,$020CF373
        MOVE.W  -(A4),D2                        ; $2A20F4
        DC.W    $020C,$0C05         ; $2A20F6 ANDI.B  #$0C05,A4
        LSL.W  -$27E9(A7)                       ; $2A20FA
        MOVE.B  -(A0),D2                        ; $2A20FE
        ROXL.L  D5,D1                           ; $2A2100
        ADD.B  (A7),D4                          ; $2A2102
        ROXL.W  D5,D1                           ; $2A2104
        DC.W    $0EBD               ; $2A2106 DC.W    $0EBD
        ROXL.L  #5,D3                           ; $2A2108
        MOVE.W  (A1)+,(A0)+                     ; $2A210A
        CMPI.B  #$020C,D3                       ; $2A210C
        MOVE.W  A6,$1438(A1)                    ; $2A2110
        ADD.B  (A7),D4                          ; $2A2114
        ROXL.B  D5,D3                           ; $2A2116
        DC.W    $0EEA               ; $2A2118 DC.W    $0EEA
        ROXL.L  #5,D3                           ; $2A211A
        DC.W    $0E4D               ; $2A211C DC.W    $0E4D
        CMPI.B  #$020C,$0BE0(A0)                ; $2A211E
        MOVEA.B $17(A6,A5.L),A2                 ; $2A2124
        MOVE.B  -(A2),$00130D5D                 ; $2A2128
        MOVE.W  $0050(A2),$00(A7,A2.L)          ; $2A212E
        DC.W    $0000,$0010         ; $2A2134 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A2138 ORI.B  #$0030,-(A0)
        ADDI.W  #$A900,(A0)                     ; $2A213C
        ORI.W  #$0070,-(A0)                     ; $2A2140
        ADDI.W  #$8400,(A0)                     ; $2A2144
        ORI.W  #$0080,(A0)                      ; $2A2148
        ADDI.W  #$8600,(A0)                     ; $2A214C
        DC.W    $0000,$0040         ; $2A2150 ORI.B  #$0040,D0
        SUBI.W  #$B900,(A0)                     ; $2A2154
        ORI.L  #$00B00450,(A0)                  ; $2A2158
        OR.B   D0,D3                            ; $2A215E
        ORI.W  #$0080,-(A0)                     ; $2A2160
        ADDI.W  #$AA00,(A0)                     ; $2A2164
        ORI.L  #$00700650,-(A0)                 ; $2A2168
        MOVE.L  D0,-(A5)                        ; $2A216E
        DC.W    $0000,$0030         ; $2A2170 ORI.B  #$0030,D0
        ANDI.W  #$1001,(A1)                     ; $2A2174
        DC.W    $00C0               ; $2A2178 DC.W    $00C0
        ANDI.W  #$1201,(A1)                     ; $2A217A
        ORI.W  #$0651,$01(A0,D1.W)              ; $2A217E
        DC.W    $0020,$0651         ; $2A2184 ORI.B  #$0651,-(A0)
        MOVE.B  D1,D1                           ; $2A2188
        DC.W    $0030,$0C00,$0015   ; $2A218A ORI.B  #$0C00,$15(A0,D0.W)
        DC.W    $0000,$F13F         ; $2A2190 ORI.B  #$F13F,D0
        MOVE.W  $76(A4,A7.L),$3F(PC,A7.W)       ; $2A2194
        MOVE.W  -$76(A4,D0.W),$3F(PC,A7.W)      ; $2A219A
        MOVE.W  -(A6),(A0)                      ; $2A21A0
        SUBI.L  #$F13F30A6,A2                   ; $2A21A2
        MOVE.W  -$3F(A6,D0.L),$30A6(A5)         ; $2A21A8
        MOVE.W  -$3F(A6,D0.L),$30A6(A5)         ; $2A21AE
        SUBI.L  #$0EC137F4,A2                   ; $2A21B4
        SUBI.L  #$0EC137F4,A2                   ; $2A21BA
        MOVE.W  -$22(A6,D0.W),$37F4(A5)         ; $2A21C0
        MOVE.W  A0,-$04DE(A1)                   ; $2A21C6
        MOVE.W  $48(A4,A7.W),$22(PC,A7.L)       ; $2A21CA
        MOVE.W  -(A6),(A0)                      ; $2A21D0
        MOVE.W  A0,$04DE(A1)                    ; $2A21D2
        MOVE.W  -(A6),(A0)                      ; $2A21D6
        MOVE.W  A0,-$0EC1(A1)                   ; $2A21D8
        DC.W    $0000,$0CB8         ; $2A21DC ORI.B  #$0CB8,D0
        DC.W    $F13F               ; $2A21E0 MOVE.W  <EA:3F>,-(A0)
        DC.W    $0000,$F348         ; $2A21E2 ORI.B  #$F348,D0
        DC.W    $F13F               ; $2A21E6 MOVE.W  <EA:3F>,-(A0)
        DC.W    $4383               ; $2A21E8 DC.W    $4383
        MOVE.W  A0,-$0EC1(A1)                   ; $2A21EA
        DC.W    $4383               ; $2A21EE DC.W    $4383
        DC.W    $0CB8,$0EC1,$0000,$F348; $2A21F0 CMPI.L  #$0EC10000,$F348.W
        DC.W    $0EC1               ; $2A21F8 DC.W    $0EC1
        DC.W    $4383               ; $2A21FA DC.W    $4383
        MOVE.W  A0,$0EC1(A1)                    ; $2A21FC
