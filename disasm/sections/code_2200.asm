; Generated assembly for $002200-$004200
; Branch targets: 210
; Labels: 199

        org     $002200

        ADDQ.B  #1,$C828.W                      ; $002200
        BSET    #1,$C80B.W                      ; $002204
        RTS                                     ; $00220A
        MOVE.W  $9F74.W,D0                      ; $00220C
        MOVE.B  $9FE5.W,D1                      ; $002210
        LEA     $8759.W,A3                      ; $002214
        LEA     $8517.W,A2                      ; $002218
        LEA     $8760.W,A1                      ; $00221C
        BSR.S  loc_002236                       ; $002220
        MOVE.W  $9074.W,D0                      ; $002222
        MOVE.B  $90E5.W,D1                      ; $002226
        LEA     $8789.W,A3                      ; $00222A
        LEA     $8516.W,A2                      ; $00222E
        LEA     $8790.W,A1                      ; $002232
loc_002236:
        BTST    #4,D1                           ; $002236
        BEQ.S  loc_00224C                       ; $00223A
        MOVE.B  $C827.W,D1                      ; $00223C
        CMP.B  (A3),D1                          ; $002240
        BEQ.S  loc_00225A                       ; $002242
        MOVE.B  D1,(A3)                         ; $002244
        MOVE.B  #$0001,(A2)                     ; $002246
        BRA.S  loc_00225A                       ; $00224A
loc_00224C:
        MOVE.B  $C828.W,D1                      ; $00224C
        CMP.B  (A3),D1                          ; $002250
        BEQ.S  loc_00225A                       ; $002252
        MOVE.B  D1,(A3)                         ; $002254
        MOVE.B  #$0001,(A2)                     ; $002256
loc_00225A:
        CMPI.W  #$0000,$C8C8.W                  ; $00225A
        BEQ.S  loc_0022AA                       ; $002260
        CMPI.W  #$0002,$C8C8.W                  ; $002262
        BEQ.W  loc_0022EC                       ; $002268
        LSR.W  #5,D0                            ; $00226C
        MOVE.W  D0,D1                           ; $00226E
        LSR.W  #2,D0                            ; $002270
        ADD.W  D0,D1                            ; $002272
        LSR.W  #1,D0                            ; $002274
        ADD.W  D0,D1                            ; $002276
        ADDI.W  #$1A5E,D1                       ; $002278
        ADD.W  (A1),D1                          ; $00227C
        LSR.W  #1,D1                            ; $00227E
        CMPI.W  #$1E00,D1                       ; $002280
        BGT.S  loc_002294                       ; $002284
        CMPI.W  #$1A5E,D1                       ; $002286
        BGT.S  loc_002298                       ; $00228A
        MOVE.W  #$1A5E,D1                       ; $00228C
        MOVE.W  D1,(A1)                         ; $002290
        RTS                                     ; $002292
loc_002294:
        MOVE.W  #$1E00,D1                       ; $002294
loc_002298:
        CMP.W  (A1),D1                          ; $002298
        BNE.S  loc_0022A6                       ; $00229A
        JSR     $00496E(PC)                     ; $00229C [func_00496E]
        ANDI.W  #$000F,D0                       ; $0022A0
        SUB.W  D0,D1                            ; $0022A4
loc_0022A6:
        MOVE.W  D1,(A1)                         ; $0022A6
        RTS                                     ; $0022A8
loc_0022AA:
        LSR.W  #4,D0                            ; $0022AA
        MOVE.W  D0,D1                           ; $0022AC
        LSR.W  #1,D0                            ; $0022AE
        ADD.W  D0,D1                            ; $0022B0
        LSR.W  #1,D0                            ; $0022B2
        ADD.W  D0,D1                            ; $0022B4
        LSR.W  #2,D0                            ; $0022B6
        ADD.W  D0,D1                            ; $0022B8
        ADDI.W  #$1A5E,D1                       ; $0022BA
        ADD.W  (A1),D1                          ; $0022BE
        LSR.W  #1,D1                            ; $0022C0
        CMPI.W  #$21D0,D1                       ; $0022C2
        BGT.S  loc_0022D6                       ; $0022C6
        CMPI.W  #$1A5E,D1                       ; $0022C8
        BGT.S  loc_0022DA                       ; $0022CC
        MOVE.W  #$1A5E,D1                       ; $0022CE
        MOVE.W  D1,(A1)                         ; $0022D2
        RTS                                     ; $0022D4
loc_0022D6:
        MOVE.W  #$21D0,D1                       ; $0022D6
loc_0022DA:
        CMP.W  (A1),D1                          ; $0022DA
        BNE.S  loc_0022E8                       ; $0022DC
        JSR     $00496E(PC)                     ; $0022DE [func_00496E]
        ANDI.W  #$000F,D0                       ; $0022E2
        SUB.W  D0,D1                            ; $0022E6
loc_0022E8:
        MOVE.W  D1,(A1)                         ; $0022E8
        RTS                                     ; $0022EA
loc_0022EC:
        LSR.W  #4,D0                            ; $0022EC
        MOVE.W  D0,D1                           ; $0022EE
        LSR.W  #1,D0                            ; $0022F0
        ADD.W  D0,D1                            ; $0022F2
        LSR.W  #1,D0                            ; $0022F4
        ADD.W  D0,D1                            ; $0022F6
        ADDI.W  #$1A5E,D1                       ; $0022F8
        ADD.W  (A1),D1                          ; $0022FC
        LSR.W  #1,D1                            ; $0022FE
        CMPI.W  #$21A0,D1                       ; $002300
        BGT.S  loc_002314                       ; $002304
        CMPI.W  #$1A5E,D1                       ; $002306
        BGT.S  loc_002318                       ; $00230A
        MOVE.W  #$1A5E,D1                       ; $00230C
        MOVE.W  D1,(A1)                         ; $002310
        RTS                                     ; $002312
loc_002314:
        MOVE.W  #$21A0,D1                       ; $002314
loc_002318:
        CMP.W  (A1),D1                          ; $002318
        BNE.S  loc_002326                       ; $00231A
        JSR     $00496E(PC)                     ; $00231C [func_00496E]
        ANDI.W  #$000F,D0                       ; $002320
        SUB.W  D0,D1                            ; $002324
loc_002326:
        MOVE.W  D1,(A1)                         ; $002326
        RTS                                     ; $002328
        MOVE.L  -$5200(A5),$38(A7,D3.W)         ; $00232A
        SUB.W  -$08(A4,D4.W),D0                 ; $002330
        OR.L   D3,(A0)                          ; $002334
        BTST    #4,$90E5.W                      ; $002336
        BEQ.S  loc_002358                       ; $00233C
        CMPI.B  #$0001,$C823.W                  ; $00233E
        BEQ.S  loc_00236A                       ; $002344
        MOVE.B  #$0001,$C823.W                  ; $002346
        MOVE.W  $C8C8.W,D0                      ; $00234C
        MOVE.B  -$28(PC,D0.W),$C8A5.W           ; $002350
        BRA.S  loc_00236A                       ; $002356
loc_002358:
        TST.B  $C823.W                          ; $002358
        BEQ.S  loc_00236A                       ; $00235C
        MOVE.B  #$0000,$C823.W                  ; $00235E
        MOVE.B  #$00AB,$C8A5.W                  ; $002364
loc_00236A:
        BTST    #1,$C80B.W                      ; $00236A
        BEQ.S  loc_002384                       ; $002370
        MOVE.B  $C828.W,$8789.W                 ; $002372
        MOVE.B  #$0001,$8516.W                  ; $002378
        BCLR    #1,$C80B.W                      ; $00237E
loc_002384:
        CMPI.W  #$0000,$C8C8.W                  ; $002384
        BEQ.S  loc_0023DC                       ; $00238A
        CMPI.W  #$0002,$C8C8.W                  ; $00238C
        BEQ.W  loc_002426                       ; $002392
        LSR.W  #5,D0                            ; $002396
        MOVE.W  D0,D1                           ; $002398
        LSR.W  #2,D0                            ; $00239A
        ADD.W  D0,D1                            ; $00239C
        LSR.W  #1,D0                            ; $00239E
        ADD.W  D0,D1                            ; $0023A0
        ADDI.W  #$1A5E,D1                       ; $0023A2
        ADD.W  (A1),D1                          ; $0023A6
        LSR.W  #1,D1                            ; $0023A8
        CMPI.W  #$1E00,D1                       ; $0023AA
        BGT.S  loc_0023C2                       ; $0023AE
        CMPI.W  #$1A5E,D1                       ; $0023B0
        BGT.S  loc_0023C6                       ; $0023B4
        MOVE.W  #$1A5E,D1                       ; $0023B6
        MOVE.W  D1,(A1)                         ; $0023BA
        MOVE.W  (A1),$8760.W                    ; $0023BC
        RTS                                     ; $0023C0
loc_0023C2:
        MOVE.W  #$1E00,D1                       ; $0023C2
loc_0023C6:
        CMP.W  (A1),D1                          ; $0023C6
        BNE.S  loc_0023D4                       ; $0023C8
        JSR     $00496E(PC)                     ; $0023CA [func_00496E]
        ANDI.W  #$000F,D0                       ; $0023CE
        SUB.W  D0,D1                            ; $0023D2
loc_0023D4:
        MOVE.W  D1,(A1)                         ; $0023D4
        MOVE.W  (A1),$8760.W                    ; $0023D6
        RTS                                     ; $0023DA
loc_0023DC:
        LSR.W  #4,D0                            ; $0023DC
        MOVE.W  D0,D1                           ; $0023DE
        LSR.W  #1,D0                            ; $0023E0
        ADD.W  D0,D1                            ; $0023E2
        LSR.W  #1,D0                            ; $0023E4
        ADD.W  D0,D1                            ; $0023E6
        LSR.W  #2,D0                            ; $0023E8
        ADD.W  D0,D1                            ; $0023EA
        ADDI.W  #$1A5E,D1                       ; $0023EC
        ADD.W  (A1),D1                          ; $0023F0
        LSR.W  #1,D1                            ; $0023F2
        CMPI.W  #$21D0,D1                       ; $0023F4
        BGT.S  loc_00240C                       ; $0023F8
        CMPI.W  #$1A5E,D1                       ; $0023FA
        BGT.S  loc_002410                       ; $0023FE
        MOVE.W  #$1A5E,D1                       ; $002400
        MOVE.W  D1,(A1)                         ; $002404
        MOVE.W  (A1),$8760.W                    ; $002406
        RTS                                     ; $00240A
loc_00240C:
        MOVE.W  #$21D0,D1                       ; $00240C
loc_002410:
        CMP.W  (A1),D1                          ; $002410
        BNE.S  loc_00241E                       ; $002412
        JSR     $00496E(PC)                     ; $002414 [func_00496E]
        ANDI.W  #$000F,D0                       ; $002418
        SUB.W  D0,D1                            ; $00241C
loc_00241E:
        MOVE.W  D1,(A1)                         ; $00241E
        MOVE.W  (A1),$8760.W                    ; $002420
        RTS                                     ; $002424
loc_002426:
        LSR.W  #4,D0                            ; $002426
        MOVE.W  D0,D1                           ; $002428
        LSR.W  #1,D0                            ; $00242A
        ADD.W  D0,D1                            ; $00242C
        LSR.W  #1,D0                            ; $00242E
        ADD.W  D0,D1                            ; $002430
        ADDI.W  #$1A5E,D1                       ; $002432
        ADD.W  (A1),D1                          ; $002436
        LSR.W  #1,D1                            ; $002438
        CMPI.W  #$21A0,D1                       ; $00243A
        BGT.S  loc_002452                       ; $00243E
        CMPI.W  #$1A5E,D1                       ; $002440
        BGT.S  loc_002456                       ; $002444
        MOVE.W  #$1A5E,D1                       ; $002446
        MOVE.W  D1,(A1)                         ; $00244A
        MOVE.W  (A1),$8760.W                    ; $00244C
        RTS                                     ; $002450
loc_002452:
        MOVE.W  #$21A0,D1                       ; $002452
loc_002456:
        CMP.W  (A1),D1                          ; $002456
        BNE.S  loc_002464                       ; $002458
        JSR     $00496E(PC)                     ; $00245A [func_00496E]
        ANDI.W  #$000F,D0                       ; $00245E
        SUB.W  D0,D1                            ; $002462
loc_002464:
        MOVE.W  D1,(A1)                         ; $002464
        MOVE.W  (A1),$8760.W                    ; $002466
        RTS                                     ; $00246A
        MOVE.B  #$0001,$8507.W                  ; $00246C
        RTS                                     ; $002472
        MOVE.B  #$0080,$8507.W                  ; $002474
        RTS                                     ; $00247A
loc_00247C:
        MOVE.W  #$E001,D6                       ; $00247C
        MOVEQ   #$00,D0                         ; $002480
        MOVEQ   #$00,D1                         ; $002482
        MOVE.B  (A0)+,D0                        ; $002484
        MOVE.B  D0,D1                           ; $002486
        LSR.B  #4,D0                            ; $002488
        ANDI.B  #$000F,D1                       ; $00248A
        ADD.W  D6,D0                            ; $00248E
        ADD.W  D6,D1                            ; $002490
        MOVE.W  D0,(A6)                         ; $002492
        MOVE.W  D1,(A6)                         ; $002494
        MOVEQ   #$00,D0                         ; $002496
        MOVEQ   #$00,D1                         ; $002498
        MOVE.B  (A0)+,D0                        ; $00249A
        MOVE.B  D0,D1                           ; $00249C
        LSR.B  #4,D0                            ; $00249E
        ANDI.B  #$000F,D1                       ; $0024A0
        ADD.W  D6,D0                            ; $0024A4
        ADD.W  D6,D1                            ; $0024A6
        MOVE.W  D0,(A6)                         ; $0024A8
        MOVE.W  D1,(A6)                         ; $0024AA
        RTS                                     ; $0024AC
loc_0024AE:
        MOVE.W  #$E001,D6                       ; $0024AE
        MOVEQ   #$00,D0                         ; $0024B2
        MOVEQ   #$00,D1                         ; $0024B4
        MOVE.B  (A0)+,D0                        ; $0024B6
        MOVE.B  D0,D1                           ; $0024B8
        LSR.B  #4,D0                            ; $0024BA
        ANDI.B  #$000F,D1                       ; $0024BC
        ADD.W  D6,D0                            ; $0024C0
        ADD.W  D6,D1                            ; $0024C2
        MOVE.W  D0,(A6)                         ; $0024C4
        MOVE.W  D1,(A6)                         ; $0024C6
        RTS                                     ; $0024C8
        TST.B  $C80D.W                          ; $0024CA
        BNE.W  loc_002592                       ; $0024CE
        MOVE.W  #$0000,$8000.W                  ; $0024D2
        MOVE.W  #$FFF8,$C880.W                  ; $0024D8
        LEA     $00FF6116,A0                    ; $0024DE
        MOVE.L  #$62020002,(A5)                 ; $0024E4
        JSR     loc_00247C(PC)                  ; $0024EA
        LEA     $9032.W,A0                      ; $0024EE
        MOVE.L  #$620C0002,(A5)                 ; $0024F2
        JSR     loc_00247C(PC)                  ; $0024F8
        LEA     $00FF611A,A0                    ; $0024FC
        MOVE.L  #$62160002,(A5)                 ; $002502
        JSR     loc_00247C(PC)                  ; $002508
        LEA     $00FF6108,A0                    ; $00250C
        MOVE.L  #$63020002,(A5)                 ; $002512
        JSR     loc_00247C(PC)                  ; $002518
        LEA     $00FF610A,A0                    ; $00251C
        MOVE.L  #$630C0002,(A5)                 ; $002522
        JSR     loc_00247C(PC)                  ; $002528
        LEA     $00FF610C,A0                    ; $00252C
        MOVE.L  #$63160002,(A5)                 ; $002532
        JSR     loc_00247C(PC)                  ; $002538
        LEA     $00FF6104,A0                    ; $00253C
        MOVE.L  #$632A0002,(A5)                 ; $002542
        JSR     loc_00247C(PC)                  ; $002548
        LEA     $00FF6106,A0                    ; $00254C
        MOVE.L  #$63340002,(A5)                 ; $002552
        JSR     loc_00247C(PC)                  ; $002558
        LEA     $00FF5FF8,A0                    ; $00255C
        MOVE.L  #$640C0002,(A5)                 ; $002562
        JSR     loc_00247C(PC)                  ; $002568
        MOVE.L  #$64160002,(A5)                 ; $00256C
        JSR     loc_00247C(PC)                  ; $002572
        MOVE.L  #$64200002,(A5)                 ; $002576
        JSR     loc_00247C(PC)                  ; $00257C
        MOVE.L  #$642A0002,(A5)                 ; $002580
        JSR     loc_00247C(PC)                  ; $002586
        MOVE.B  #$0000,$00FF5FFF                ; $00258A
loc_002592:
        RTS                                     ; $002592
        TST.B  $C80D.W                          ; $002594
        BNE.S  loc_0025AE                       ; $002598
        LEA     $C886.W,A0                      ; $00259A
        MOVE.L  #$622A0002,(A5)                 ; $00259E
        JSR     loc_0024AE(PC)                  ; $0025A4
        MOVE.B  #$0000,$C886.W                  ; $0025A8
loc_0025AE:
        RTS                                     ; $0025AE
        TST.B  $C80D.W                          ; $0025B0
        BNE.W  loc_00263C                       ; $0025B4
        LEA     $C888.W,A0                      ; $0025B8
        MOVE.L  #$65020002,(A5)                 ; $0025BC
        JSR     loc_00247C(PC)                  ; $0025C2
        JSR     loc_00247C(PC)                  ; $0025C6
        MOVEA.L $C888.W,A0                      ; $0025CA
        MOVE.L  #$65140002,(A5)                 ; $0025CE
        JSR     loc_00247C(PC)                  ; $0025D4
        MOVE.L  #$651E0002,(A5)                 ; $0025D8
        JSR     loc_00247C(PC)                  ; $0025DE
        MOVE.L  #$65280002,(A5)                 ; $0025E2
        JSR     loc_00247C(PC)                  ; $0025E8
        MOVE.L  #$65320002,(A5)                 ; $0025EC
        JSR     loc_00247C(PC)                  ; $0025F2
        ADDQ.L  #8,$C888.W                      ; $0025F6
        LEA     $C888.W,A0                      ; $0025FA
        MOVE.L  #$66020002,(A5)                 ; $0025FE
        JSR     loc_00247C(PC)                  ; $002604
        JSR     loc_00247C(PC)                  ; $002608
        MOVEA.L $C888.W,A0                      ; $00260C
        MOVE.L  #$66140002,(A5)                 ; $002610
        JSR     loc_00247C(PC)                  ; $002616
        MOVE.L  #$661E0002,(A5)                 ; $00261A
        JSR     loc_00247C(PC)                  ; $002620
        MOVE.L  #$66280002,(A5)                 ; $002624
        JSR     loc_00247C(PC)                  ; $00262A
        MOVE.L  #$66320002,(A5)                 ; $00262E
        JSR     loc_00247C(PC)                  ; $002634
        SUBQ.L  #8,$C888.W                      ; $002638
loc_00263C:
        RTS                                     ; $00263C
        LEA     $0012(PC),A1                    ; $00263E
        LEA     $00A15100,A2                    ; $002642
        MOVEQ   #$0C,D7                         ; $002648
loc_00264A:
        MOVE.W  (A1)+,(A2)+                     ; $00264A
        DBRA    D7,loc_00264A                   ; $00264C
        RTS                                     ; $002650
        ORI.L  #$00000001,D3                    ; $002652
        ORI.B  #$0000,D0                        ; $002658
        ORI.B  #$0000,D0                        ; $00265C
        ORI.B  #$0000,D0                        ; $002660
        ORI.B  #$0000,D0                        ; $002664
        ORI.B  #$0000,D0                        ; $002668
        LEA     $0012(PC),A1                    ; $00266C
        LEA     $00A15180,A2                    ; $002670
        MOVEQ   #$05,D7                         ; $002676
loc_002678:
        MOVE.W  (A1)+,(A2)+                     ; $002678
        DBRA    D7,loc_002678                   ; $00267A
        RTS                                     ; $00267E
        OR.B   D0,D0                            ; $002680
        ORI.B  #$0000,D0                        ; $002682
        ORI.B  #$0000,D0                        ; $002686
        ORI.B  #$49F9,D0                        ; $00268A
        ORI.L  #$510008AC,-(A1)                 ; $00268E
        ORI.B  #$008B,D0                        ; $002694
        JSR     loc_002742(PC)                  ; $002698
        JSR     loc_0027BE(PC)                  ; $00269C
        JSR     loc_00281E(PC)                  ; $0026A0
        BSET    #0,$008B(A4)                    ; $0026A4
        JSR     loc_002742(PC)                  ; $0026AA
        JSR     loc_0027BE(PC)                  ; $0026AE
        JSR     loc_00281E(PC)                  ; $0026B2
        BCLR    #0,$008B(A4)                    ; $0026B6
        MOVE.B  #$0000,$C80C.W                  ; $0026BC
        MOVEQ   #$00,D0                         ; $0026C2
        JMP     loc_002782(PC)                  ; $0026C4
        LEA     $00A15100,A4                    ; $0026C8
        BCLR    #0,$008B(A4)                    ; $0026CE
        BSR.S  loc_002742                       ; $0026D4
        JSR     loc_0027A0(PC)                  ; $0026D6
        JSR     loc_00281E(PC)                  ; $0026DA
        BSET    #0,$008B(A4)                    ; $0026DE
        BSR.S  loc_002742                       ; $0026E4
        JSR     loc_0027A0(PC)                  ; $0026E6
        JSR     loc_00281E(PC)                  ; $0026EA
        BCLR    #0,$008B(A4)                    ; $0026EE
        MOVE.B  #$0000,$C80C.W                  ; $0026F4
        MOVEQ   #$00,D0                         ; $0026FA
        JSR     loc_002782(PC)                  ; $0026FC
        MOVE.W  #$8000,$00A15202                ; $002700
        RTS                                     ; $002708
        LEA     $00A15100,A4                    ; $00270A
        BSR.S  loc_002742                       ; $002710
        JSR     loc_0027A0(PC)                  ; $002712
        JSR     loc_0027DA(PC)                  ; $002716
        MOVEQ   #$01,D0                         ; $00271A
        MOVEQ   #$00,D2                         ; $00271C
        BTST    #0,$C80C.W                      ; $00271E
        BEQ.S  loc_00272A                       ; $002724
        MOVEQ   #$00,D0                         ; $002726
        MOVEQ   #$01,D2                         ; $002728
loc_00272A:
        MOVE.B  D0,$008B(A4)                    ; $00272A
        BSR.S  loc_002742                       ; $00272E
        BSR.S  loc_0027A0                       ; $002730
        JSR     loc_0027DA(PC)                  ; $002732
        MOVE.B  D2,$008B(A4)                    ; $002736
        RTS                                     ; $00273A
        LEA     $00A15100,A4                    ; $00273C
loc_002742:
        LEA     $00A15186,A2                    ; $002742
        LEA     $00A15188,A3                    ; $002748
        ANDI.B  #$0040,$0081(A4)                ; $00274E
        MOVE.W  #$00FF,D7                       ; $002754
        MOVEQ   #$00,D0                         ; $002758
        MOVEQ   #$00,D1                         ; $00275A
        MOVE.W  #$0100,D2                       ; $00275C
        MOVE.W  #$00FF,$0084(A4)                ; $002760
loc_002766:
        MOVE.W  D1,(A2)                         ; $002766
        MOVE.W  D0,(A3)                         ; $002768
loc_00276A:
        BTST    #1,$008B(A4)                    ; $00276A
        BNE.S  loc_00276A                       ; $002770
        ADD.W  D2,D1                            ; $002772
        DBRA    D7,loc_002766                   ; $002774
        RTS                                     ; $002778
        ANDI.B  #$0040,$00A15181                ; $00277A
loc_002782:
        LEA     $00A15200,A2                    ; $002782
        MOVEQ   #$1F,D7                         ; $002788
loc_00278A:
        MOVE.L  D0,(A2)+                        ; $00278A
        MOVE.L  D0,(A2)+                        ; $00278C
        MOVE.L  D0,(A2)+                        ; $00278E
        MOVE.L  D0,(A2)+                        ; $002790
        DBRA    D7,loc_00278A                   ; $002792
        RTS                                     ; $002796
        ANDI.B  #$0040,$00A15181                ; $002798
loc_0027A0:
        LEA     $00840000,A1                    ; $0027A0
        MOVE.W  #$1F00,D2                       ; $0027A6
        MOVE.W  #$00DF,D7                       ; $0027AA
loc_0027AE:
        MOVE.W  D2,(A1)+                        ; $0027AE
        DBRA    D7,loc_0027AE                   ; $0027B0
        RTS                                     ; $0027B4
        ANDI.B  #$0040,$00A15181                ; $0027B6
loc_0027BE:
        LEA     $00840000,A1                    ; $0027BE
        MOVE.W  #$0100,D0                       ; $0027C4
        MOVE.W  #$2000,D1                       ; $0027C8
        MOVE.W  #$00DF,D7                       ; $0027CC
loc_0027D0:
        MOVE.W  D1,(A1)+                        ; $0027D0
        ADD.W  D0,D1                            ; $0027D2
        DBRA    D7,loc_0027D0                   ; $0027D4
        RTS                                     ; $0027D8
loc_0027DA:
        BSR.S  loc_00281E                       ; $0027DA
        LEA     $00A15100,A4                    ; $0027DC
        LEA     $00A15186,A2                    ; $0027E2
        LEA     $00A15188,A3                    ; $0027E8
        MOVE.W  #$2000,D1                       ; $0027EE
        BSR.S  loc_0027F8                       ; $0027F2
        MOVE.W  #$F000,D1                       ; $0027F4
loc_0027F8:
        MOVE.W  #$000F,D7                       ; $0027F8
        MOVE.W  #$0101,D0                       ; $0027FC
        MOVE.W  #$0100,D2                       ; $002800
        MOVE.W  #$00FF,$0084(A4)                ; $002804
loc_00280A:
        MOVE.W  D1,(A2)                         ; $00280A
        MOVE.W  D0,(A3)                         ; $00280C
loc_00280E:
        BTST    #1,$008B(A4)                    ; $00280E
        BNE.S  loc_00280E                       ; $002814
        ADD.W  D2,D1                            ; $002816
        DBRA    D7,loc_00280A                   ; $002818
        RTS                                     ; $00281C
loc_00281E:
        LEA     $00A15100,A4                    ; $00281E
        LEA     $00A15186,A2                    ; $002824
        LEA     $00A15188,A3                    ; $00282A
        MOVE.W  #$1F00,D1                       ; $002830
        MOVE.W  #$0101,D0                       ; $002834
        MOVE.W  #$00FF,$0084(A4)                ; $002838
        MOVE.W  D1,(A2)                         ; $00283E
        MOVE.W  D0,(A3)                         ; $002840
loc_002842:
        BTST    #1,$008B(A4)                    ; $002842
        BNE.S  loc_002842                       ; $002848
        RTS                                     ; $00284A
        LEA     $00A15200,A3                    ; $00284C
        MOVEQ   #$1F,D7                         ; $002852
loc_002854:
        MOVE.L  (A2)+,(A3)+                     ; $002854
        MOVE.L  (A2)+,(A3)+                     ; $002856
        MOVE.L  (A2)+,(A3)+                     ; $002858
        MOVE.L  (A2)+,(A3)+                     ; $00285A
        DBRA    D7,loc_002854                   ; $00285C
        RTS                                     ; $002860
        LEA     $00A15240,A3                    ; $002862
        MOVEQ   #$07,D7                         ; $002868
loc_00286A:
        MOVE.L  (A2)+,(A3)+                     ; $00286A
        MOVE.L  (A2)+,(A3)+                     ; $00286C
        MOVE.L  (A2)+,(A3)+                     ; $00286E
        MOVE.L  (A2)+,(A3)+                     ; $002870
        DBRA    D7,loc_00286A                   ; $002872
        RTS                                     ; $002876
        TST.B  $C821.W                          ; $002878
        BEQ.S  loc_00288E                       ; $00287C
        LEA     $00FF6E00,A1                    ; $00287E
        LEA     $00A15200,A2                    ; $002884
        JMP     $0048D2(PC)                     ; $00288A [func_0048D2]
loc_00288E:
        RTS                                     ; $00288E
loc_002890:
        BTST    #0,$00A15123                    ; $002890
        BEQ.S  loc_002890                       ; $002898
        BCLR    #0,$00A15123                    ; $00289A
        MOVE.W  #$0000,$C8A8.W                  ; $0028A2
        MOVE.B  $C8A9.W,$00A15121               ; $0028A8
        MOVE.B  $C8A8.W,$00A15120               ; $0028B0
        MOVE.B  #$0000,$00A15123                ; $0028B8
        RTS                                     ; $0028C0
        MOVE.W  #$0500,$00A15110                ; $0028C2
        MOVE.B  #$0004,$00A15107                ; $0028CA
        MOVE.B  $C8A9.W,$00A15121               ; $0028D2
        MOVE.B  $C8A8.W,$00A15120               ; $0028DA
loc_0028E2:
        BTST    #1,$00A15123                    ; $0028E2
        BEQ.S  loc_0028E2                       ; $0028EA
        BCLR    #1,$00A15123                    ; $0028EC
        LEA     $00FF6000,A1                    ; $0028F4
        LEA     $00A15112,A2                    ; $0028FA
        JSR     func_0188EC                       ; $002900
        JSR     func_0188EC                       ; $002906
        JSR     func_0188EC                       ; $00290C
        JSR     func_0188EC                       ; $002912
        JSR     func_0188EC                       ; $002918
        JSR     func_0188EC                       ; $00291E
        JSR     func_0188EC                       ; $002924
        JSR     func_0188EC                       ; $00292A
        JSR     func_0188EC                       ; $002930
        JMP     func_0188EC                       ; $002936
        LEA     $00A15100,A4                    ; $00293C
        MOVE.B  #$0000,(A4)                     ; $002942
        LEA     $00A15186,A2                    ; $002946
        LEA     $00A15188,A3                    ; $00294C
        MOVE.W  #$00BF,D7                       ; $002952
        MOVEQ   #$00,D0                         ; $002956
        MOVE.W  #$3000,D1                       ; $002958
        MOVE.W  #$0100,D2                       ; $00295C
        MOVE.W  #$009F,$0084(A4)                ; $002960
loc_002966:
        MOVE.W  D1,(A2)                         ; $002966
        MOVE.W  D0,(A3)                         ; $002968
        MOVEQ   #$6F,D0                         ; $00296A
        DIVS    #$0378,D0                       ; $00296C
loc_002970:
        BTST    #1,$008B(A4)                    ; $002970
        BNE.S  loc_002970                       ; $002976
        ADD.W  D2,D1                            ; $002978
        DBRA    D7,loc_002966                   ; $00297A
        MOVE.B  #$0080,(A4)                     ; $00297E
        RTS                                     ; $002982
        LEA     $9000.W,A0                      ; $002984
        LEA     $00FF6100,A1                    ; $002988
        TST.W  $C04C.W                          ; $00298E
        BNE.W  loc_002ADE                       ; $002992
loc_002996:
        MOVE.W  $0030(A0),D0                    ; $002996
        MOVE.W  D0,$0016(A1)                    ; $00299A
        MOVE.W  $009C(A0),D0                    ; $00299E
        ASL.W  #4,D0                            ; $0029A2
        MOVE.W  D0,D1                           ; $0029A4
        SUB.W  $C054.W,D1                       ; $0029A6
        NEG.W  D1                               ; $0029AA
        MOVE.W  D1,$0004(A1)                    ; $0029AC
        ADD.W  $C0E4.W,D0                       ; $0029B0
        ADD.W  $0032(A0),D0                     ; $0029B4
        MOVE.W  D0,$0018(A1)                    ; $0029B8
        MOVE.W  $C056.W,$0006(A1)               ; $0029BC
        MOVE.W  $0034(A0),D0                    ; $0029C2
        MOVE.W  D0,$001A(A1)                    ; $0029C6
        MOVE.W  $003A(A0),D0                    ; $0029CA
        ASR.W  #3,D0                            ; $0029CE
        MOVE.W  D0,D1                           ; $0029D0
        ADD.W  $C0C8.W,D0                       ; $0029D2
        MOVE.W  D0,$0008(A1)                    ; $0029D6
        MOVE.W  $0044(A0),D0                    ; $0029DA
        ASR.W  #3,D0                            ; $0029DE
        ADD.W  D1,D0                            ; $0029E0
        NEG.W  D0                               ; $0029E2
        MOVE.W  D0,$001C(A1)                    ; $0029E4
        MOVE.W  $003C(A0),D0                    ; $0029E8
        ADD.W  $0096(A0),D0                     ; $0029EC
        ASR.W  #3,D0                            ; $0029F0
        MOVE.W  D0,D1                           ; $0029F2
        ADD.W  $C0CA.W,D0                       ; $0029F4
        NEG.W  D0                               ; $0029F8
        MOVE.W  D0,$000A(A1)                    ; $0029FA
        MOVE.W  $0046(A0),D0                    ; $0029FE
        ASR.W  #3,D0                            ; $002A02
        SUB.W  D0,D1                            ; $002A04
        MOVE.W  D1,$001E(A1)                    ; $002A06
        MOVE.W  $003E(A0),D0                    ; $002A0A
        ASR.W  #3,D0                            ; $002A0E
        MOVE.W  D0,D1                           ; $002A10
        ADD.W  $C0CC.W,D0                       ; $002A12
        MOVE.W  D0,$000C(A1)                    ; $002A16
        MOVE.W  $004A(A0),D0                    ; $002A1A
        ADD.W  $004C(A0),D0                     ; $002A1E
        ASR.W  #5,D0                            ; $002A22
        SUB.W  D1,D0                            ; $002A24
        MOVE.W  D0,$0020(A1)                    ; $002A26
        MOVE.W  $0090(A0),D0                    ; $002A2A
        ASR.W  #3,D0                            ; $002A2E
        MOVE.W  D0,$0032(A1)                    ; $002A30
        MOVE.W  D0,$0046(A1)                    ; $002A34
        MOVE.W  $00BC(A0),D0                    ; $002A38
        ASR.W  #3,D0                            ; $002A3C
        MOVE.W  D0,$0030(A1)                    ; $002A3E
        MOVE.W  D0,$0044(A1)                    ; $002A42
        MOVE.W  D0,$0058(A1)                    ; $002A46
        TST.B  $C31C.W                          ; $002A4A
        BEQ.S  loc_002A72                       ; $002A4E
        BTST    #3,$00E5(A0)                    ; $002A50
        BEQ.S  loc_002A72                       ; $002A56
        MOVEQ   #$00,D0                         ; $002A58
        MOVE.W  D0,(A1)                         ; $002A5A
        MOVE.W  D0,$0014(A1)                    ; $002A5C
        MOVE.W  D0,$0028(A1)                    ; $002A60
        MOVE.W  D0,$003C(A1)                    ; $002A64
        MOVE.W  D0,$0050(A1)                    ; $002A68
        MOVE.W  D0,$0064(A1)                    ; $002A6C
        RTS                                     ; $002A70
loc_002A72:
        MOVEQ   #$01,D0                         ; $002A72
        MOVE.W  D0,(A1)                         ; $002A74
        MOVE.W  D0,$0014(A1)                    ; $002A76
        MOVE.W  D0,$0028(A1)                    ; $002A7A
        MOVE.W  D0,$003C(A1)                    ; $002A7E
        MOVE.W  D0,$0050(A1)                    ; $002A82
        MOVE.W  $008A(A0),D0                    ; $002A86
        BEQ.S  loc_002AC4                       ; $002A8A
        SUBQ.W  #1,D0                           ; $002A8C
        BEQ.S  loc_002AAA                       ; $002A8E
        MOVE.L  $C74C.W,$0024(A1)               ; $002A90
        MOVE.W  #$0001,$0064(A1)                ; $002A96
        TST.W  $008C(A0)                        ; $002A9C
        BEQ.S  loc_002ADC                       ; $002AA0
        MOVE.W  #$0000,$0064(A1)                ; $002AA2
        RTS                                     ; $002AA8
loc_002AAA:
        MOVE.L  $C748.W,$0024(A1)               ; $002AAA
        MOVE.W  #$0001,$0064(A1)                ; $002AB0
        TST.W  $008C(A0)                        ; $002AB6
        BEQ.S  loc_002ADC                       ; $002ABA
        MOVE.W  #$0000,$0064(A1)                ; $002ABC
        RTS                                     ; $002AC2
loc_002AC4:
        MOVE.L  $C710.W,$0024(A1)               ; $002AC4
        MOVE.W  #$0001,$0064(A1)                ; $002ACA
        TST.W  $008C(A0)                        ; $002AD0
        BEQ.S  loc_002ADC                       ; $002AD4
        MOVE.W  #$0000,$0064(A1)                ; $002AD6
loc_002ADC:
        RTS                                     ; $002ADC
loc_002ADE:
        MOVE.L  $C724.W,$0024(A1)               ; $002ADE
        TST.W  $008A(A0)                        ; $002AE4
        BEQ.S  loc_002AF0                       ; $002AE8
        MOVE.L  $C750.W,$0024(A1)               ; $002AEA
loc_002AF0:
        MOVE.W  $0030(A0),D0                    ; $002AF0
        MOVE.W  D0,$0016(A1)                    ; $002AF4
        MOVE.W  $C054.W,$0004(A1)               ; $002AF8
        MOVE.W  $009C(A0),D0                    ; $002AFE
        ASL.W  #4,D0                            ; $002B02
        ADD.W  $0032(A0),D0                     ; $002B04
        ADD.W  $C0E4.W,D0                       ; $002B08
        MOVE.W  D0,$0018(A1)                    ; $002B0C
        MOVE.W  $C056.W,$0006(A1)               ; $002B10
        MOVE.W  $0034(A0),D0                    ; $002B16
        MOVE.W  D0,$001A(A1)                    ; $002B1A
        MOVE.W  $003A(A0),D0                    ; $002B1E
        ASR.W  #3,D0                            ; $002B22
        MOVE.W  D0,D1                           ; $002B24
        ADD.W  $C0C8.W,D0                       ; $002B26
        MOVE.W  D0,$0008(A1)                    ; $002B2A
        NEG.W  D1                               ; $002B2E
        MOVE.W  D1,$001C(A1)                    ; $002B30
        MOVE.W  $003C(A0),D0                    ; $002B34
        ADD.W  $0096(A0),D0                     ; $002B38
        SUB.W  $0046(A0),D0                     ; $002B3C
        ASR.W  #3,D0                            ; $002B40
        MOVE.W  D0,D1                           ; $002B42
        ADD.W  $C0CA.W,D0                       ; $002B44
        NEG.W  D0                               ; $002B48
        MOVE.W  D0,$000A(A1)                    ; $002B4A
        MOVE.W  D1,$001E(A1)                    ; $002B4E
        MOVE.W  $003E(A0),D0                    ; $002B52
        ASR.W  #3,D0                            ; $002B56
        MOVE.W  D0,D1                           ; $002B58
        ADD.W  $C0CC.W,D0                       ; $002B5A
        MOVE.W  D0,$000C(A1)                    ; $002B5E
        MOVE.W  $004C(A0),D0                    ; $002B62
        ASR.W  #4,D0                            ; $002B66
        SUB.W  D1,D0                            ; $002B68
        MOVE.W  D0,$0020(A1)                    ; $002B6A
        MOVE.W  $0090(A0),D0                    ; $002B6E
        ASR.W  #3,D0                            ; $002B72
        MOVE.W  D0,$0032(A1)                    ; $002B74
        MOVE.W  D0,$0046(A1)                    ; $002B78
        MOVE.W  $00BC(A0),D0                    ; $002B7C
        ASR.W  #3,D0                            ; $002B80
        MOVE.W  D0,$0030(A1)                    ; $002B82
        MOVE.W  D0,$0044(A1)                    ; $002B86
        MOVE.W  $C088.W,D1                      ; $002B8A
        MOVE.W  $008E(A0),D0                    ; $002B8E
        EXT.L   D1                              ; $002B92
        EXT.L   D0                              ; $002B94
        ADD.L  D1,D0                            ; $002B96
        ASR.L  #1,D0                            ; $002B98
        MOVE.W  D0,$C088.W                      ; $002B9A
        NEG.W  D0                               ; $002B9E
        MOVE.W  D0,D1                           ; $002BA0
        ASR.W  #7,D1                            ; $002BA2
        ASR.W  #6,D0                            ; $002BA4
        ADD.W  D1,D0                            ; $002BA6
        ASL.W  #1,D0                            ; $002BA8
        MOVE.W  D0,$0070(A1)                    ; $002BAA
        RTS                                     ; $002BAE
        LEA     $9000.W,A0                      ; $002BB0
        LEA     $00FF6100,A1                    ; $002BB4
        LEA     $00FF6330,A2                    ; $002BBA
        BTST    #5,$C30E.W                      ; $002BC0
        BNE.S  loc_002BE6                       ; $002BC6
        JSR     loc_002C58(PC)                  ; $002BC8
        TST.W  $C04C.W                          ; $002BCC
        BNE.S  loc_002BDE                       ; $002BD0
        JSR     loc_002CDC(PC)                  ; $002BD2
        JSR     loc_002DCA(PC)                  ; $002BD6
        JMP     loc_002EC6(PC)                  ; $002BDA
loc_002BDE:
        JSR     loc_002F04(PC)                  ; $002BDE
        JMP     loc_002E9E(PC)                  ; $002BE2
loc_002BE6:
        MOVEQ   #$02,D0                         ; $002BE6
        MOVE.W  D0,$0014(A1)                    ; $002BE8
        MOVE.W  D0,$0028(A1)                    ; $002BEC
        MOVE.W  D0,$003C(A1)                    ; $002BF0
        MOVE.W  D0,$0050(A1)                    ; $002BF4
        JSR     loc_003130(PC)                  ; $002BF8
        JSR     loc_003010(PC)                  ; $002BFC
        JMP     loc_002DCA(PC)                  ; $002C00
        LEA     $9F00.W,A0                      ; $002C04
        LEA     $00FF6330,A1                    ; $002C08
        LEA     $00FF6100,A2                    ; $002C0E
        BTST    #5,$C30E.W                      ; $002C14
        BNE.S  loc_002C3A                       ; $002C1A
        JSR     loc_002C9A(PC)                  ; $002C1C
        TST.W  $C04C.W                          ; $002C20
        BNE.S  loc_002C32                       ; $002C24
        JSR     loc_002CDC(PC)                  ; $002C26
        JSR     loc_002E34(PC)                  ; $002C2A
        JMP     loc_002EC6(PC)                  ; $002C2E
loc_002C32:
        JSR     loc_002F04(PC)                  ; $002C32
        JMP     loc_002EB2(PC)                  ; $002C36
loc_002C3A:
        MOVEQ   #$02,D0                         ; $002C3A
        MOVE.W  D0,$0014(A1)                    ; $002C3C
        MOVE.W  D0,$0028(A1)                    ; $002C40
        MOVE.W  D0,$003C(A1)                    ; $002C44
        MOVE.W  D0,$0050(A1)                    ; $002C48
        JSR     loc_003130(PC)                  ; $002C4C
        JSR     loc_003010(PC)                  ; $002C50
        JMP     loc_002E34(PC)                  ; $002C54
loc_002C58:
        MOVEQ   #$00,D0                         ; $002C58
        TST.W  $00C0(A0)                        ; $002C5A
        BEQ.S  loc_002C88                       ; $002C5E
        MOVEQ   #$01,D0                         ; $002C60
        TST.B  $9FE4.W                          ; $002C62
        BNE.S  loc_002C6E                       ; $002C66
        TST.B  $B4FC.W                          ; $002C68
        BEQ.S  loc_002C7A                       ; $002C6C
loc_002C6E:
        BTST    #3,$00E5(A0)                    ; $002C6E
        BEQ.S  loc_002C88                       ; $002C74
loc_002C76:
        MOVEQ   #$00,D0                         ; $002C76
        BRA.S  loc_002C88                       ; $002C78
loc_002C7A:
        BTST    #3,$9FE5.W                      ; $002C7A
        BEQ.S  loc_002C88                       ; $002C80
        TST.B  $00E4(A0)                        ; $002C82
        BNE.S  loc_002C76                       ; $002C86
loc_002C88:
        MOVE.W  D0,$0118(A2)                    ; $002C88
        MOVE.W  D0,$012C(A2)                    ; $002C8C
        MOVE.W  D0,$0140(A2)                    ; $002C90
        MOVE.W  D0,$0154(A2)                    ; $002C94
        RTS                                     ; $002C98
loc_002C9A:
        MOVEQ   #$00,D0                         ; $002C9A
        TST.W  $00C0(A0)                        ; $002C9C
        BEQ.S  loc_002CCA                       ; $002CA0
        MOVEQ   #$01,D0                         ; $002CA2
        TST.B  $90E4.W                          ; $002CA4
        BNE.S  loc_002CB0                       ; $002CA8
        TST.B  $B0FC.W                          ; $002CAA
        BEQ.S  loc_002CBC                       ; $002CAE
loc_002CB0:
        BTST    #3,$00E5(A0)                    ; $002CB0
        BEQ.S  loc_002CCA                       ; $002CB6
loc_002CB8:
        MOVEQ   #$00,D0                         ; $002CB8
        BRA.S  loc_002CCA                       ; $002CBA
loc_002CBC:
        BTST    #3,$90E5.W                      ; $002CBC
        BEQ.S  loc_002CCA                       ; $002CC2
        TST.B  $00E4(A0)                        ; $002CC4
        BNE.S  loc_002CB8                       ; $002CC8
loc_002CCA:
        MOVE.W  D0,$0118(A2)                    ; $002CCA
        MOVE.W  D0,$012C(A2)                    ; $002CCE
        MOVE.W  D0,$0140(A2)                    ; $002CD2
        MOVE.W  D0,$0154(A2)                    ; $002CD6
        RTS                                     ; $002CDA
loc_002CDC:
        MOVE.W  $0030(A0),D0                    ; $002CDC
        MOVE.W  D0,$0016(A1)                    ; $002CE0
        MOVE.W  D0,$011A(A2)                    ; $002CE4
        MOVE.W  $009C(A0),D0                    ; $002CE8
        ASL.W  #4,D0                            ; $002CEC
        MOVE.W  D0,D1                           ; $002CEE
        SUB.W  $C054.W,D1                       ; $002CF0
        NEG.W  D1                               ; $002CF4
        MOVE.W  D1,$0004(A1)                    ; $002CF6
        ADD.W  $C0E4.W,D0                       ; $002CFA
        ADD.W  $0032(A0),D0                     ; $002CFE
        MOVE.W  D0,$0018(A1)                    ; $002D02
        MOVE.W  D0,$011C(A2)                    ; $002D06
        MOVE.W  $C056.W,$0006(A1)               ; $002D0A
        MOVE.W  $0034(A0),D0                    ; $002D10
        MOVE.W  D0,$001A(A1)                    ; $002D14
        MOVE.W  D0,$011E(A2)                    ; $002D18
        MOVE.W  $003A(A0),D0                    ; $002D1C
        ASR.W  #3,D0                            ; $002D20
        MOVE.W  D0,D1                           ; $002D22
        ADD.W  $C0C8.W,D0                       ; $002D24
        ADD.W  $C0AE.W,D0                       ; $002D28
        MOVE.W  D0,$0008(A1)                    ; $002D2C
        MOVE.W  $0044(A0),D0                    ; $002D30
        ASR.W  #3,D0                            ; $002D34
        ADD.W  D1,D0                            ; $002D36
        NEG.W  D0                               ; $002D38
        MOVE.W  D0,$001C(A1)                    ; $002D3A
        MOVE.W  D0,$0120(A2)                    ; $002D3E
        MOVE.W  $003C(A0),D0                    ; $002D42
        ADD.W  $0096(A0),D0                     ; $002D46
        ASR.W  #3,D0                            ; $002D4A
        MOVE.W  D0,D1                           ; $002D4C
        ADD.W  $C0CA.W,D0                       ; $002D4E
        ADD.W  $C0B0.W,D0                       ; $002D52
        NEG.W  D0                               ; $002D56
        MOVE.W  D0,$000A(A1)                    ; $002D58
        MOVE.W  $0046(A0),D0                    ; $002D5C
        ASR.W  #3,D0                            ; $002D60
        SUB.W  D0,D1                            ; $002D62
        MOVE.W  D1,$001E(A1)                    ; $002D64
        MOVE.W  D1,$0122(A2)                    ; $002D68
        MOVE.W  $003E(A0),D0                    ; $002D6C
        ASR.W  #3,D0                            ; $002D70
        MOVE.W  D0,D1                           ; $002D72
        ADD.W  $C0CC.W,D0                       ; $002D74
        ADD.W  $C0B2.W,D0                       ; $002D78
        MOVE.W  D0,$000C(A1)                    ; $002D7C
        MOVE.W  $004A(A0),D0                    ; $002D80
        ADD.W  $004C(A0),D0                     ; $002D84
        ASR.W  #5,D0                            ; $002D88
        SUB.W  D1,D0                            ; $002D8A
        MOVE.W  D0,$0020(A1)                    ; $002D8C
        MOVE.W  D0,$0124(A2)                    ; $002D90
        MOVE.W  $0090(A0),D0                    ; $002D94
        ASR.W  #3,D0                            ; $002D98
        MOVE.W  D0,$0032(A1)                    ; $002D9A
        MOVE.W  D0,$0046(A1)                    ; $002D9E
        MOVE.W  D0,$0136(A2)                    ; $002DA2
        MOVE.W  D0,$014A(A2)                    ; $002DA6
        MOVE.W  $00BC(A0),D0                    ; $002DAA
        ASR.W  #3,D0                            ; $002DAE
        MOVE.W  D0,$0030(A1)                    ; $002DB0
        MOVE.W  D0,$0044(A1)                    ; $002DB4
        MOVE.W  D0,$0058(A1)                    ; $002DB8
        MOVE.W  D0,$0134(A2)                    ; $002DBC
        MOVE.W  D0,$0148(A2)                    ; $002DC0
        MOVE.W  D0,$015C(A2)                    ; $002DC4
        RTS                                     ; $002DC8
loc_002DCA:
        MOVE.W  $008A(A0),D0                    ; $002DCA
        BEQ.S  loc_002E14                       ; $002DCE
        SUBQ.W  #1,D0                           ; $002DD0
        BEQ.S  loc_002DF4                       ; $002DD2
        MOVE.L  $C74C.W,$0024(A1)               ; $002DD4
        MOVE.L  $C74C.W,$0128(A2)               ; $002DDA
        MOVE.W  #$0001,$0064(A1)                ; $002DE0
        TST.W  $008C(A0)                        ; $002DE6
        BEQ.S  loc_002E32                       ; $002DEA
        MOVE.W  #$0000,$0064(A1)                ; $002DEC
        RTS                                     ; $002DF2
loc_002DF4:
        MOVE.L  $C748.W,$0024(A1)               ; $002DF4
        MOVE.L  $C748.W,$0128(A2)               ; $002DFA
        MOVE.W  #$0001,$0064(A1)                ; $002E00
        TST.W  $008C(A0)                        ; $002E06
        BEQ.S  loc_002E32                       ; $002E0A
        MOVE.W  #$0000,$0064(A1)                ; $002E0C
        RTS                                     ; $002E12
loc_002E14:
        MOVE.L  $C710.W,$0024(A1)               ; $002E14
        MOVE.L  $C710.W,$0128(A2)               ; $002E1A
        MOVE.W  #$0001,$0064(A1)                ; $002E20
        TST.W  $008C(A0)                        ; $002E26
        BEQ.S  loc_002E32                       ; $002E2A
        MOVE.W  #$0000,$0064(A1)                ; $002E2C
loc_002E32:
        RTS                                     ; $002E32
loc_002E34:
        MOVE.W  $008A(A0),D0                    ; $002E34
        BEQ.S  loc_002E7E                       ; $002E38
        SUBQ.W  #1,D0                           ; $002E3A
        BEQ.S  loc_002E5E                       ; $002E3C
        MOVE.L  $C760.W,$0024(A1)               ; $002E3E
        MOVE.L  $C760.W,$0128(A2)               ; $002E44
        MOVE.W  #$0001,$0064(A1)                ; $002E4A
        TST.W  $008C(A0)                        ; $002E50
        BEQ.S  loc_002E9C                       ; $002E54
        MOVE.W  #$0000,$0064(A1)                ; $002E56
        RTS                                     ; $002E5C
loc_002E5E:
        MOVE.L  $C75C.W,$0024(A1)               ; $002E5E
        MOVE.L  $C75C.W,$0128(A2)               ; $002E64
        MOVE.W  #$0001,$0064(A1)                ; $002E6A
        TST.W  $008C(A0)                        ; $002E70
        BEQ.S  loc_002E9C                       ; $002E74
        MOVE.W  #$0000,$0064(A1)                ; $002E76
        RTS                                     ; $002E7C
loc_002E7E:
        MOVE.L  $C754.W,$0024(A1)               ; $002E7E
        MOVE.L  $C754.W,$0128(A2)               ; $002E84
        MOVE.W  #$0001,$0064(A1)                ; $002E8A
        TST.W  $008C(A0)                        ; $002E90
        BEQ.S  loc_002E9C                       ; $002E94
        MOVE.W  #$0000,$0064(A1)                ; $002E96
loc_002E9C:
        RTS                                     ; $002E9C
loc_002E9E:
        MOVE.L  $C724.W,$0024(A1)               ; $002E9E
        TST.W  $008A(A0)                        ; $002EA4
        BEQ.S  loc_002EB0                       ; $002EA8
        MOVE.L  $C750.W,$0024(A1)               ; $002EAA
loc_002EB0:
        RTS                                     ; $002EB0
loc_002EB2:
        MOVE.L  $C758.W,$0024(A1)               ; $002EB2
        TST.W  $008A(A0)                        ; $002EB8
        BEQ.S  loc_002EC4                       ; $002EBC
        MOVE.L  $C764.W,$0024(A1)               ; $002EBE
loc_002EC4:
        RTS                                     ; $002EC4
loc_002EC6:
        TST.B  $C31C.W                          ; $002EC6
        BEQ.S  loc_002EEE                       ; $002ECA
        BTST    #3,$00E5(A0)                    ; $002ECC
        BEQ.S  loc_002EEE                       ; $002ED2
        MOVEQ   #$00,D0                         ; $002ED4
        MOVE.W  D0,(A1)                         ; $002ED6
        MOVE.W  D0,$0014(A1)                    ; $002ED8
        MOVE.W  D0,$0028(A1)                    ; $002EDC
        MOVE.W  D0,$003C(A1)                    ; $002EE0
        MOVE.W  D0,$0050(A1)                    ; $002EE4
        MOVE.W  D0,$0064(A1)                    ; $002EE8
        RTS                                     ; $002EEC
loc_002EEE:
        MOVEQ   #$01,D0                         ; $002EEE
        MOVE.W  D0,(A1)                         ; $002EF0
        MOVE.W  D0,$0014(A1)                    ; $002EF2
        MOVE.W  D0,$0028(A1)                    ; $002EF6
        MOVE.W  D0,$003C(A1)                    ; $002EFA
        MOVE.W  D0,$0050(A1)                    ; $002EFE
        RTS                                     ; $002F02
loc_002F04:
        MOVE.W  $0030(A0),D0                    ; $002F04
        MOVE.W  D0,$0016(A1)                    ; $002F08
        MOVE.W  D0,$011A(A2)                    ; $002F0C
        MOVE.W  $C054.W,$0004(A1)               ; $002F10
        MOVE.W  $009C(A0),D0                    ; $002F16
        ASL.W  #4,D0                            ; $002F1A
        ADD.W  $0032(A0),D0                     ; $002F1C
        ADD.W  $C0E4.W,D0                       ; $002F20
        MOVE.W  D0,$0018(A1)                    ; $002F24
        MOVE.W  D0,$011C(A2)                    ; $002F28
        MOVE.W  $C056.W,$0006(A1)               ; $002F2C
        MOVE.W  $0034(A0),D0                    ; $002F32
        MOVE.W  D0,$001A(A1)                    ; $002F36
        MOVE.W  D0,$011E(A2)                    ; $002F3A
        MOVE.W  $003A(A0),D0                    ; $002F3E
        ASR.W  #3,D0                            ; $002F42
        MOVE.W  D0,D1                           ; $002F44
        ADD.W  $C0C8.W,D0                       ; $002F46
        ADD.W  $C0AE.W,D0                       ; $002F4A
        MOVE.W  D0,$0008(A1)                    ; $002F4E
        NEG.W  D1                               ; $002F52
        MOVE.W  D1,$001C(A1)                    ; $002F54
        MOVE.W  D1,$0120(A2)                    ; $002F58
        MOVE.W  $003C(A0),D0                    ; $002F5C
        ADD.W  $0096(A0),D0                     ; $002F60
        SUB.W  $0046(A0),D0                     ; $002F64
        ASR.W  #3,D0                            ; $002F68
        MOVE.W  D0,D1                           ; $002F6A
        ADD.W  $C0CA.W,D0                       ; $002F6C
        ADD.W  $C0B0.W,D0                       ; $002F70
        NEG.W  D0                               ; $002F74
        MOVE.W  D0,$000A(A1)                    ; $002F76
        MOVE.W  D1,$001E(A1)                    ; $002F7A
        MOVE.W  $0046(A0),D0                    ; $002F7E
        ASR.W  #3,D0                            ; $002F82
        SUB.W  D0,D1                            ; $002F84
        MOVE.W  D1,$0122(A2)                    ; $002F86
        MOVE.W  $003E(A0),D0                    ; $002F8A
        ASR.W  #3,D0                            ; $002F8E
        MOVE.W  D0,D1                           ; $002F90
        ADD.W  $C0CC.W,D0                       ; $002F92
        ADD.W  $C0B2.W,D0                       ; $002F96
        MOVE.W  D0,$000C(A1)                    ; $002F9A
        MOVE.W  $004C(A0),D0                    ; $002F9E
        ASR.W  #4,D0                            ; $002FA2
        SUB.W  D1,D0                            ; $002FA4
        MOVE.W  D0,$0020(A1)                    ; $002FA6
        MOVE.W  $004A(A0),D0                    ; $002FAA
        ADD.W  $004C(A0),D0                     ; $002FAE
        ASR.W  #5,D0                            ; $002FB2
        SUB.W  D1,D0                            ; $002FB4
        MOVE.W  D0,$0124(A2)                    ; $002FB6
        MOVE.W  $0090(A0),D0                    ; $002FBA
        ASR.W  #3,D0                            ; $002FBE
        MOVE.W  D0,$0032(A1)                    ; $002FC0
        MOVE.W  D0,$0046(A1)                    ; $002FC4
        MOVE.W  D0,$0136(A2)                    ; $002FC8
        MOVE.W  D0,$014A(A2)                    ; $002FCC
        MOVE.W  $00BC(A0),D0                    ; $002FD0
        ASR.W  #3,D0                            ; $002FD4
        MOVE.W  D0,$0030(A1)                    ; $002FD6
        MOVE.W  D0,$0044(A1)                    ; $002FDA
        MOVE.W  D0,$0134(A2)                    ; $002FDE
        MOVE.W  D0,$0148(A2)                    ; $002FE2
        MOVE.W  D0,$015C(A2)                    ; $002FE6
        MOVE.W  $C088.W,D1                      ; $002FEA
        MOVE.W  $008E(A0),D0                    ; $002FEE
        EXT.L   D1                              ; $002FF2
        EXT.L   D0                              ; $002FF4
        ADD.L  D1,D0                            ; $002FF6
        ASR.L  #1,D0                            ; $002FF8
        MOVE.W  D0,$C088.W                      ; $002FFA
        NEG.W  D0                               ; $002FFE
        MOVE.W  D0,D1                           ; $003000
        ASR.W  #7,D1                            ; $003002
        ASR.W  #6,D0                            ; $003004
        ADD.W  D1,D0                            ; $003006
        ASL.W  #1,D0                            ; $003008
        MOVE.W  D0,$0070(A1)                    ; $00300A
        RTS                                     ; $00300E
loc_003010:
        MOVEQ   #$00,D0                         ; $003010
        TST.W  $00C0(A0)                        ; $003012
        BEQ.S  loc_00301A                       ; $003016
        MOVEQ   #$01,D0                         ; $003018
loc_00301A:
        MOVE.W  D0,$0118(A2)                    ; $00301A
        MOVE.W  D0,$012C(A2)                    ; $00301E
        MOVE.W  D0,$0140(A2)                    ; $003022
        MOVE.W  D0,$0154(A2)                    ; $003026
        MOVE.W  $0030(A0),D0                    ; $00302A
        MOVE.W  D0,$011A(A2)                    ; $00302E
        MOVE.W  $009C(A0),D0                    ; $003032
        ASL.W  #4,D0                            ; $003036
        ADD.W  $C0E4.W,D0                       ; $003038
        ADD.W  $0032(A0),D0                     ; $00303C
        MOVE.W  D0,$011C(A2)                    ; $003040
        MOVE.W  $0034(A0),D0                    ; $003044
        MOVE.W  D0,$011E(A2)                    ; $003048
        MOVE.W  $003A(A0),D1                    ; $00304C
        ASR.W  #3,D1                            ; $003050
        MOVE.W  $0044(A0),D0                    ; $003052
        ASR.W  #3,D0                            ; $003056
        ADD.W  D1,D0                            ; $003058
        NEG.W  D0                               ; $00305A
        MOVE.W  D0,$0120(A2)                    ; $00305C
        MOVE.W  $003C(A0),D2                    ; $003060
        ADD.W  $0096(A0),D2                     ; $003064
        ASR.W  #3,D2                            ; $003068
        MOVE.W  $0046(A0),D0                    ; $00306A
        ASR.W  #3,D0                            ; $00306E
        NEG.W  D0                               ; $003070
        ADD.W  D2,D0                            ; $003072
        MOVE.W  D0,$0122(A2)                    ; $003074
        MOVE.W  $003E(A0),D3                    ; $003078
        ASR.W  #3,D3                            ; $00307C
        MOVE.W  $004A(A0),D0                    ; $00307E
        ADD.W  $004C(A0),D0                     ; $003082
        ASR.W  #5,D0                            ; $003086
        ADD.W  D3,D0                            ; $003088
        NEG.W  D0                               ; $00308A
        MOVE.W  D0,$0124(A2)                    ; $00308C
        MOVE.W  $0090(A0),D0                    ; $003090
        ASR.W  #3,D0                            ; $003094
        MOVE.W  D0,$0032(A1)                    ; $003096
        MOVE.W  D0,$0046(A1)                    ; $00309A
        MOVE.W  D0,$0136(A2)                    ; $00309E
        MOVE.W  D0,$014A(A2)                    ; $0030A2
        MOVE.W  $00BC(A0),D0                    ; $0030A6
        ASR.W  #3,D0                            ; $0030AA
        MOVE.W  D0,$0030(A1)                    ; $0030AC
        MOVE.W  D0,$0044(A1)                    ; $0030B0
        MOVE.W  D0,$0058(A1)                    ; $0030B4
        MOVE.W  D0,$0134(A2)                    ; $0030B8
        MOVE.W  D0,$0148(A2)                    ; $0030BC
        MOVE.W  D0,$015C(A2)                    ; $0030C0
        RTS                                     ; $0030C4
        BTST    #5,$C30E.W                      ; $0030C6
        BEQ.S  loc_003114                       ; $0030CC
        LEA     $00FF6100,A1                    ; $0030CE
        MOVE.W  $000A(A1),D0                    ; $0030D4
        SUB.W  $C0B0.W,D0                       ; $0030D8
        MOVE.W  #$F000,D1                       ; $0030DC
        CMP.W  D1,D0                            ; $0030E0
        BLE.S  loc_0030EC                       ; $0030E2
        ADDI.W  #$0040,$C0B0.W                  ; $0030E4
        MOVE.W  D0,D1                           ; $0030EA
loc_0030EC:
        MOVE.W  D1,$000A(A1)                    ; $0030EC
        MOVE.W  $C056.W,D0                      ; $0030F0
        MOVE.W  #$0280,D1                       ; $0030F4
        TST.W  $C8C8.W                          ; $0030F8
        BEQ.S  loc_003102                       ; $0030FC
        MOVE.W  #$0350,D1                       ; $0030FE
loc_003102:
        CMP.W  D1,D0                            ; $003102
        BLE.S  loc_003110                       ; $003104
        SUBI.W  #$0010,$C056.W                  ; $003106
        MOVE.W  $C056.W,D1                      ; $00310C
loc_003110:
        MOVE.W  D1,$C056.W                      ; $003110
loc_003114:
        RTS                                     ; $003114
        BTST    #5,$C30E.W                      ; $003116
        BEQ.S  loc_003124                       ; $00311C
        ADDI.W  #$0040,$C0B0.W                  ; $00311E
loc_003124:
        RTS                                     ; $003124
        LEA     $9000.W,A0                      ; $003126
        LEA     $00FF6100,A1                    ; $00312A
loc_003130:
        MOVE.W  $C086.W,$0002(A1)               ; $003130
        JSR     loc_002996(PC)                  ; $003136
        MOVE.W  $C0AE.W,D0                      ; $00313A
        ADD.W  D0,$0008(A1)                     ; $00313E
        MOVE.W  $C0B0.W,D0                      ; $003142
        ADD.W  D0,$000A(A1)                     ; $003146
        MOVE.W  $C0B2.W,D0                      ; $00314A
        ADD.W  D0,$000C(A1)                     ; $00314E
        TST.W  $C8C8.W                          ; $003152
        BEQ.S  loc_00315E                       ; $003156
        ADDI.W  #$00E0,$0006(A1)                ; $003158
loc_00315E:
        RTS                                     ; $00315E
        MOVE.W  #$0001,$00FF6100                ; $003160
        MOVEQ   #$70,D0                         ; $003168
        ADD.W  $C0C6.W,D0                       ; $00316A
        MOVE.W  D0,$00FF60CE                    ; $00316E
        TST.W  $C0BA.W                          ; $003174
        BEQ.S  loc_0031A4                       ; $003178
        MOVE.W  #$0002,$00FF6100                ; $00317A
        LEA     $C0BA.W,A1                      ; $003182
        LEA     $00FF6102,A2                    ; $003186
        MOVE.W  (A1)+,(A2)+                     ; $00318C
        MOVE.W  (A1)+,(A2)+                     ; $00318E
        MOVE.W  (A1)+,(A2)+                     ; $003190
        MOVE.W  (A1)+,D0                        ; $003192
        ASR.W  #3,D0                            ; $003194
        MOVE.W  D0,(A2)+                        ; $003196
        MOVE.W  (A1)+,D0                        ; $003198
        ASR.W  #3,D0                            ; $00319A
        MOVE.W  D0,(A2)+                        ; $00319C
        MOVE.W  (A1)+,D0                        ; $00319E
        ASR.W  #3,D0                            ; $0031A0
        MOVE.W  D0,(A2)                         ; $0031A2
loc_0031A4:
        RTS                                     ; $0031A4
        MOVEQ   #$00,D0                         ; $0031A6
        MOVE.B  $C305.W,D0                      ; $0031A8
        MOVEA.L $04(PC,D0.W),A1                 ; $0031AC
        JMP     (A1)                            ; $0031B0
        ORI.L  #$33780088,A0                    ; $0031B2
        MOVEA.W -$78(A2,D0.W),A1                ; $0031B8
        MOVE.W  (A6)+,$0088.W                   ; $0031BC
        MOVE.W  (A6)+,$0088.W                   ; $0031C0
        MOVE.W  (A6)+,$0088.W                   ; $0031C4
        MOVE.W  (A6)+,$0088.W                   ; $0031C8
        MOVE.W  $0088(A2),D1                    ; $0031CC
        MOVE.W  $0088(A2),D1                    ; $0031D0
        MOVE.W  $0088(A2),D1                    ; $0031D4
        MOVE.W  D4,D1                           ; $0031D8
        ORI.L  #$32504A78,A0                    ; $0031DA
        AND.W  A6,D0                            ; $0031E0
        BEQ.S  loc_003250                       ; $0031E2
        MOVEA.L $C258.W,A1                      ; $0031E4
        MOVE.B  #$0002,$0000(A1)                ; $0031E8
        MOVE.B  #$0003,$00FF6950                ; $0031EE
        MOVE.B  #$0001,$00FF6940                ; $0031F6
        ADDQ.B  #4,$C305.W                      ; $0031FE
        RTS                                     ; $003202
        SUBQ.B  #1,$C308.W                      ; $003204
        BNE.S  loc_003224                       ; $003208
        MOVE.W  $C08E.W,D0                      ; $00320A
        CMP.W  $C07A.W,D0                       ; $00320E
        BEQ.S  loc_003224                       ; $003212
        MOVE.W  $002C(A0),D0                    ; $003214
        LEA     $008989EE,A1                    ; $003218
        MOVE.B  $00(A1,D0.W),$C8A5.W            ; $00321E
loc_003224:
        MOVE.B  #$0004,$C305.W                  ; $003224
        TST.W  $C04E.W                          ; $00322A
        BEQ.S  loc_003250                       ; $00322E
        MOVEA.L $C258.W,A1                      ; $003230
        MOVE.B  #$0000,$0000(A1)                ; $003234
        MOVE.B  #$0000,$00FF6940                ; $00323A
        MOVE.B  #$0000,$00FF6950                ; $003242
        ADDQ.B  #4,$C305.W                      ; $00324A
        RTS                                     ; $00324E
loc_003250:
        MOVEA.L $C258.W,A1                      ; $003250
        MOVE.B  #$0002,$0000(A1)                ; $003254
        MOVE.B  #$0000,$00FF6940                ; $00325A
        MOVE.B  #$0000,$00FF6950                ; $003262
        MOVE.B  #$0000,$C305.W                  ; $00326A
        RTS                                     ; $003270
        MOVE.B  #$0002,$C308.W                  ; $003272
        MOVEQ   #$00,D0                         ; $003278
        LEA     $00FF68D0,A1                    ; $00327A
        MOVE.W  $002C(A0),D0                    ; $003280
        SUBQ.W  #1,D0                           ; $003284
        LSL.W  #4,D0                            ; $003286
        ADDA.L  D0,A1                           ; $003288
        MOVE.L  A1,$C258.W                      ; $00328A
        MOVE.B  #$0002,$0000(A1)                ; $00328E
        MOVE.B  #$0003,$00FF6950                ; $003294
        MOVEA.W $C076.W,A2                      ; $00329C
        MOVEQ   #$00,D0                         ; $0032A0
        MOVE.B  $C806.W,D0                      ; $0032A2
        MOVE.B  #$0000,$C806.W                  ; $0032A6
        ADD.W  D0,D0                            ; $0032AC
        LEA     $00899884,A3                    ; $0032AE
        MOVE.W  $00(A3,D0.W),D0                 ; $0032B4
        MOVE.B  D0,(A2)+                        ; $0032B8
        MOVEQ   #$00,D0                         ; $0032BA
        MOVE.B  $C807.W,D0                      ; $0032BC
        MOVE.B  #$00C4,$C807.W                  ; $0032C0
        SUBI.B  #$00C4,D0                       ; $0032C6
        ADD.W  D0,D0                            ; $0032CA
        LEA     $00899884,A3                    ; $0032CC
        MOVE.W  $00(A3,D0.W),D0                 ; $0032D2
        MOVE.B  D0,(A2)+                        ; $0032D6
        MOVEQ   #$00,D0                         ; $0032D8
        MOVE.B  $C808.W,D0                      ; $0032DA
        MOVE.B  #$00C4,$C808.W                  ; $0032DE
        SUBI.B  #$00C4,D0                       ; $0032E4
        ADD.W  D0,D0                            ; $0032E8
        LEA     $0089980C,A3                    ; $0032EA
        MOVE.W  $00(A3,D0.W),D0                 ; $0032F0
        MOVE.W  D0,(A2)+                        ; $0032F4
        MOVE.W  A2,$C076.W                      ; $0032F6
        JSR     $0088B2E4                       ; $0032FA
        JSR     func_00B422                       ; $003300
        SUBQ.L  #4,A2                           ; $003306
        MOVE.L  (A2),D0                         ; $003308
        MOVE.L  #$222E070C,$00FF6948            ; $00330A
        MOVE.B  #$0000,$C30B.W                  ; $003314
        CMP.L  $C254.W,D0                       ; $00331A
        BGE.S  loc_00335C                       ; $00331E
        MOVE.L  D0,$C254.W                      ; $003320
        MOVEQ   #$00,D0                         ; $003324
        LEA     $00FF68D1,A1                    ; $003326
        MOVE.B  $C307.W,D0                      ; $00332C
        LEA     $00(A1,D0.W),A2                 ; $003330
        MOVE.B  #$0000,(A2)                     ; $003334
        MOVE.W  $002C(A0),D0                    ; $003338
        SUBQ.W  #1,D0                           ; $00333C
        LSL.W  #4,D0                            ; $00333E
        MOVE.B  D0,$C307.W                      ; $003340
        LEA     $00(A1,D0.W),A2                 ; $003344
        MOVE.B  #$0001,(A2)                     ; $003348
        MOVE.L  #$222DFB7C,$00FF6948            ; $00334C
        MOVE.B  #$0001,$C30B.W                  ; $003356
loc_00335C:
        MOVE.B  #$0001,$00FF6940                ; $00335C
        MOVE.B  $C8AB.W,D0                      ; $003364
        ANDI.B  #$0003,D0                       ; $003368
        ADD.B  D0,D0                            ; $00336C
        ADD.B  D0,D0                            ; $00336E
        ADDI.B  #$000C,D0                       ; $003370
        MOVE.B  D0,$C305.W                      ; $003374
        RTS                                     ; $003378
        MOVEQ   #$00,D0                         ; $00337A
        MOVE.B  $C305.W,D0                      ; $00337C
        MOVEA.L $04(PC,D0.W),A1                 ; $003380
        JMP     (A1)                            ; $003384
        ORI.L  #$34E60088,A0                    ; $003386
        MOVE.W  D4,D2                           ; $00338C
        ORI.L  #$33C20088,A0                    ; $00338E
        MOVE.W  D2,$008833C2                    ; $003394
        ORI.L  #$33C20088,A0                    ; $00339A
        MOVE.W  D2,$008833C2                    ; $0033A0
        ORI.L  #$33C20088,A0                    ; $0033A6
        MOVE.W  D2,$008833C2                    ; $0033AC
        ORI.L  #$33C20088,A0                    ; $0033B2
        MOVE.W  $0088(A4),$33FC0088             ; $0033B8
        MOVE.W  A2,(A2)+                        ; $0033C0
        MOVE.W  $C08E.W,D0                      ; $0033C2
        CMP.W  $C07A.W,D0                       ; $0033C6
        BEQ.S  loc_0033E4                       ; $0033CA
        ADDQ.B  #4,$C305.W                      ; $0033CC
        MOVE.W  $002C(A0),D0                    ; $0033D0
        SUBQ.W  #1,D0                           ; $0033D4
        CMP.B  $C310.W,D0                       ; $0033D6
        BNE.S  loc_0033E2                       ; $0033DA
        MOVE.B  #$0030,$C305.W                  ; $0033DC
loc_0033E2:
        RTS                                     ; $0033E2
loc_0033E4:
        MOVE.B  #$0034,$C305.W                  ; $0033E4
        RTS                                     ; $0033EA
        MOVE.W  $002C(A0),D0                    ; $0033EC
        LEA     $008989EE,A1                    ; $0033F0
        MOVE.B  $00(A1,D0.W),$C8A5.W            ; $0033F6
        MOVE.B  #$0000,$C305.W                  ; $0033FC
        RTS                                     ; $003402
        LEA     $C806.W,A1                      ; $003404
        CMPA.W  #$9000,A0                       ; $003408
        BEQ.S  loc_003412                       ; $00340C
        LEA     $C813.W,A1                      ; $00340E
loc_003412:
        MOVEA.W $C076.W,A2                      ; $003412
        MOVEQ   #$00,D0                         ; $003416
        MOVE.B  (A1),D0                         ; $003418
        MOVE.B  #$0000,(A1)                     ; $00341A
        ADD.W  D0,D0                            ; $00341E
        LEA     $00899884,A3                    ; $003420
        MOVE.W  $00(A3,D0.W),D0                 ; $003426
        MOVE.B  D0,(A2)+                        ; $00342A
        MOVEQ   #$00,D0                         ; $00342C
        MOVE.B  $0001(A1),D0                    ; $00342E
        MOVE.B  #$00C4,$0001(A1)                ; $003432
        SUBI.B  #$00C4,D0                       ; $003438
        ADD.W  D0,D0                            ; $00343C
        LEA     $00899884,A3                    ; $00343E
        MOVE.W  $00(A3,D0.W),D0                 ; $003444
        MOVE.B  D0,(A2)+                        ; $003448
        MOVEQ   #$00,D0                         ; $00344A
        MOVE.B  $0002(A1),D0                    ; $00344C
        MOVE.B  #$00C4,$0002(A1)                ; $003450
        SUBI.B  #$00C4,D0                       ; $003456
        ADD.W  D0,D0                            ; $00345A
        LEA     $0089980C,A3                    ; $00345C
        MOVE.W  $00(A3,D0.W),D0                 ; $003462
        MOVE.W  D0,(A2)+                        ; $003466
        MOVE.W  A2,$C076.W                      ; $003468
        JSR     $00B2E4(PC)                     ; $00346C
        SUBQ.L  #4,A2                           ; $003470
        MOVE.L  (A2),D0                         ; $003472
        CMP.L  $C254.W,D0                       ; $003474
        BGE.S  loc_0034AC                       ; $003478
        MOVE.L  D0,$C254.W                      ; $00347A
        MOVE.W  $002C(A0),D0                    ; $00347E
        SUBQ.W  #1,D0                           ; $003482
        LSL.W  #4,D0                            ; $003484
        MOVE.B  D0,$C307.W                      ; $003486
        LEA     $C254.W,A1                      ; $00348A
        LEA     $00FF68E8,A3                    ; $00348E
        CMPA.W  #$9000,A0                       ; $003494
        BEQ.S  loc_0034A0                       ; $003498
        LEA     $00FF6968,A3                    ; $00349A
loc_0034A0:
        MOVE.B  #$0002,-$0008(A3)               ; $0034A0
        JSR     func_00B43C                       ; $0034A6
loc_0034AC:
        BTST    #5,$C30E.W                      ; $0034AC
        BNE.S  loc_0034C0                       ; $0034B2
        TST.B  $C819.W                          ; $0034B4
        BEQ.S  loc_0034D2                       ; $0034B8
        MOVE.W  $C098.W,$C07A.W                 ; $0034BA
loc_0034C0:
        MOVE.W  #$0004,$C07C.W                  ; $0034C0
        ADDQ.B  #1,$C819.W                      ; $0034C6
        MOVE.B  #$0038,$C305.W                  ; $0034CA
        RTS                                     ; $0034D0
loc_0034D2:
        MOVE.B  $C8AB.W,D0                      ; $0034D2
        ANDI.B  #$0003,D0                       ; $0034D6
        ADD.B  D0,D0                            ; $0034DA
        ADD.B  D0,D0                            ; $0034DC
        ADDI.B  #$000C,D0                       ; $0034DE
        MOVE.B  D0,$C305.W                      ; $0034E2
        RTS                                     ; $0034E6
        MOVEQ   #$00,D0                         ; $0034E8
        MOVE.B  $C305.W,D0                      ; $0034EA
        MOVEA.L $04(PC,D0.W),A1                 ; $0034EE
        JMP     (A1)                            ; $0034F2
        ORI.L  #$36DC0088,A0                    ; $0034F4
        MOVE.W  -$78(A4,D0.W),$24(A2,D3.W)      ; $0034FA
        ORI.L  #$35240088,A0                    ; $003500
        MOVE.W  -(A4),-(A2)                     ; $003506
        ORI.L  #$35240088,A0                    ; $003508
        MOVE.W  D0,-$78(A2,D0.W)                ; $00350E
        MOVE.W  D0,-$78(A2,D0.W)                ; $003512
        MOVE.W  D0,-$78(A2,D0.W)                ; $003516
        MOVE.W  D0,$0088(A2)                    ; $00351A
        MOVE.W  (A4)+,-$78(A2,D0.W)             ; $00351E
        MOVE.W  D0,(A3)+                        ; $003522
        TST.W  $C04E.W                          ; $003524
        BEQ.S  loc_00359C                       ; $003528
        MOVE.B  #$0003,$00FF6950                ; $00352A
        MOVE.B  #$0001,$00FF6940                ; $003532
        ADDQ.B  #4,$C305.W                      ; $00353A
        RTS                                     ; $00353E
        SUBQ.B  #1,$C308.W                      ; $003540
        BNE.S  loc_00357A                       ; $003544
        MOVE.W  $C08E.W,D0                      ; $003546
        CMP.W  $C07A.W,D0                       ; $00354A
        BEQ.S  loc_00357A                       ; $00354E
        BTST    #5,$C30E.W                      ; $003550
        BNE.S  loc_00357A                       ; $003556
        MOVE.W  $002C(A0),D0                    ; $003558
        LEA     $008989EE,A1                    ; $00355C
        MOVE.B  $00(A1,D0.W),$C8A5.W            ; $003562
        CMPI.L  #$222E0508,$00FF6948            ; $003568
        BNE.S  loc_00357A                       ; $003572
        MOVE.B  #$0097,$C8A5.W                  ; $003574
loc_00357A:
        MOVE.B  #$0004,$C305.W                  ; $00357A
        TST.W  $C04E.W                          ; $003580
        BEQ.S  loc_00359C                       ; $003584
        MOVE.B  #$0000,$00FF6940                ; $003586
        MOVE.B  #$0000,$00FF6950                ; $00358E
        ADDQ.B  #4,$C305.W                      ; $003596
        RTS                                     ; $00359A
loc_00359C:
        MOVE.B  #$0000,$00FF6940                ; $00359C
        MOVE.B  #$0000,$00FF6950                ; $0035A4
        MOVE.B  #$0000,$C305.W                  ; $0035AC
        RTS                                     ; $0035B2
        MOVE.B  #$0001,$C308.W                  ; $0035B4
        MOVE.W  $002C(A0),D0                    ; $0035BA
        ADDQ.W  #1,D0                           ; $0035BE
        CMP.B  $C310.W,D0                       ; $0035C0
        BNE.S  loc_0035CC                       ; $0035C4
        MOVE.B  #$0002,$C308.W                  ; $0035C6
loc_0035CC:
        MOVE.B  #$0003,$00FF6950                ; $0035CC
        MOVEA.W $C076.W,A2                      ; $0035D4
        MOVEQ   #$00,D0                         ; $0035D8
        MOVE.B  $C806.W,D0                      ; $0035DA
        MOVE.B  #$0000,$C806.W                  ; $0035DE
        ADD.W  D0,D0                            ; $0035E4
        LEA     $00899884,A3                    ; $0035E6
        MOVE.W  $00(A3,D0.W),D0                 ; $0035EC
        MOVE.B  D0,(A2)+                        ; $0035F0
        MOVEQ   #$00,D0                         ; $0035F2
        MOVE.B  $C807.W,D0                      ; $0035F4
        MOVE.B  #$00C4,$C807.W                  ; $0035F8
        SUBI.B  #$00C4,D0                       ; $0035FE
        ADD.W  D0,D0                            ; $003602
        LEA     $00899884,A3                    ; $003604
        MOVE.W  $00(A3,D0.W),D0                 ; $00360A
        MOVE.B  D0,(A2)+                        ; $00360E
        MOVEQ   #$00,D0                         ; $003610
        MOVE.B  $C808.W,D0                      ; $003612
        MOVE.B  #$00C4,$C808.W                  ; $003616
        SUBI.B  #$00C4,D0                       ; $00361C
        ADD.W  D0,D0                            ; $003620
        LEA     $0089980C,A3                    ; $003622
        MOVE.W  $00(A3,D0.W),D0                 ; $003628
        MOVE.W  D0,(A2)+                        ; $00362C
        MOVE.W  A2,$C076.W                      ; $00362E
        JSR     $00B2E4(PC)                     ; $003632
        JSR     $00B40E(PC)                     ; $003636
        SUBQ.L  #4,A2                           ; $00363A
        MOVE.L  (A2),D0                         ; $00363C
        MOVE.L  #$222E070C,$00FF6948            ; $00363E
        CMP.L  $C254.W,D0                       ; $003648
        BGE.S  loc_0036B0                       ; $00364C
        MOVE.L  D0,$C254.W                      ; $00364E
        MOVEQ   #$00,D1                         ; $003652
        MOVE.W  $002C(A0),D1                    ; $003654
        SUBQ.W  #1,D1                           ; $003658
        LSL.W  #4,D1                            ; $00365A
        MOVE.B  D1,$C307.W                      ; $00365C
        MOVE.L  #$222DFB7C,$00FF6948            ; $003660
        LEA     $FDAA.W,A1                      ; $00366A
        MOVE.W  $C89C.W,D1                      ; $00366E
        LSL.W  #5,D1                            ; $003672
        ADD.W  $C8A0.W,D1                       ; $003674
        MOVE.W  $C8C8.W,D2                      ; $003678
        LSL.W  #3,D2                            ; $00367C
        ADD.W  $C8CC.W,D2                       ; $00367E
        ADD.W  D2,D1                            ; $003682
        LEA     $00(A1,D1.W),A1                 ; $003684
        CMP.L  (A1),D0                          ; $003688
        BGE.S  loc_0036B0                       ; $00368A
        MOVE.L  #$222E0508,$00FF6948            ; $00368C
        MOVE.L  D0,(A1)+                        ; $003696
        MOVE.L  $C270.W,(A1)+                   ; $003698
        MOVE.L  $C274.W,(A1)                    ; $00369C
        LEA     $00FF6958,A1                    ; $0036A0
        LEA     $00FF68E8,A2                    ; $0036A6
        MOVE.L  (A1)+,(A2)+                     ; $0036AC
        MOVE.L  (A1),(A2)                       ; $0036AE
loc_0036B0:
        MOVE.B  #$0001,$00FF6940                ; $0036B0
        BTST    #5,$C30E.W                      ; $0036B8
        BEQ.S  loc_0036C8                       ; $0036BE
        MOVE.B  #$002C,$C305.W                  ; $0036C0
        RTS                                     ; $0036C6
loc_0036C8:
        MOVE.B  $C8AB.W,D0                      ; $0036C8
        ANDI.B  #$0003,D0                       ; $0036CC
        ADD.B  D0,D0                            ; $0036D0
        ADD.B  D0,D0                            ; $0036D2
        ADDI.B  #$000C,D0                       ; $0036D4
        MOVE.B  D0,$C305.W                      ; $0036D8
        RTS                                     ; $0036DC
        LEA     $9100.W,A0                      ; $0036DE
        LEA     $00FF6218,A1                    ; $0036E2
        LEA     $008958E4,A3                    ; $0036E8
        MOVE.W  $C8CC.W,D0                      ; $0036EE
        MOVEA.L $00(A3,D0.W),A3                 ; $0036F2
        MOVEQ   #$0E,D7                         ; $0036F6
loc_0036F8:
        MOVEQ   #$00,D5                         ; $0036F8
        MOVEQ   #$00,D6                         ; $0036FA
        MOVEQ   #$00,D0                         ; $0036FC
        MOVE.B  $00C1(A0),D0                    ; $0036FE
        BEQ.W  loc_003790                       ; $003702
        MOVEQ   #$01,D5                         ; $003706
        MOVEQ   #$01,D6                         ; $003708
        TST.B  $90E4.W                          ; $00370A
        BNE.S  loc_003716                       ; $00370E
        TST.B  $C31C.W                          ; $003710
        BEQ.S  loc_003726                       ; $003714
loc_003716:
        BTST    #3,$00E5(A0)                    ; $003716
        BEQ.S  loc_003734                       ; $00371C
loc_00371E:
        MOVEQ   #$00,D5                         ; $00371E
        MOVEQ   #$00,D6                         ; $003720
        BRA.W  loc_003790                       ; $003722
loc_003726:
        BTST    #3,$90E5.W                      ; $003726
        BEQ.S  loc_003734                       ; $00372C
        TST.B  $00E4(A0)                        ; $00372E
        BNE.S  loc_00371E                       ; $003732
loc_003734:
        CMPI.W  #$0001,D0                       ; $003734
        BEQ.S  loc_00373C                       ; $003738
        MOVEQ   #$00,D6                         ; $00373A
loc_00373C:
        ADD.W  D0,D0                            ; $00373C
        ADD.W  D0,D0                            ; $00373E
        ADD.W  $00C2(A0),D0                     ; $003740
        MOVE.L  $00(A3,D0.W),$0010(A1)          ; $003744
        MOVE.W  $C0E4.W,D0                      ; $00374A
        ADD.W  $0032(A0),D0                     ; $00374E
        MOVE.W  D0,$0004(A1)                    ; $003752
        MOVE.W  $003A(A0),D0                    ; $003756
        ASR.W  #3,D0                            ; $00375A
        NEG.W  D0                               ; $00375C
        MOVE.W  D0,$0008(A1)                    ; $00375E
        MOVE.W  $003C(A0),D0                    ; $003762
        ADD.W  $006E(A0),D0                     ; $003766
        ASR.W  #3,D0                            ; $00376A
        MOVE.W  D0,$000A(A1)                    ; $00376C
        MOVE.W  $003E(A0),D0                    ; $003770
        ASR.W  #3,D0                            ; $003774
        NEG.W  D0                               ; $003776
        MOVE.W  D0,$000C(A1)                    ; $003778
        MOVE.W  $00BC(A0),D0                    ; $00377C
        ASR.W  #3,D0                            ; $003780
        MOVE.W  D0,$001C(A1)                    ; $003782
        MOVE.W  $00C4(A0),D0                    ; $003786
        ASR.W  #3,D0                            ; $00378A
        MOVE.W  D0,$0030(A1)                    ; $00378C
loc_003790:
        MOVE.W  $0030(A0),$0002(A1)             ; $003790
        MOVE.W  $0034(A0),$0006(A1)             ; $003796
        MOVE.W  D5,$0000(A1)                    ; $00379C
        MOVE.W  D6,$0014(A1)                    ; $0037A0
        MOVE.W  D6,$0028(A1)                    ; $0037A4
        LEA     $0100(A0),A0                    ; $0037A8
        LEA     $003C(A1),A1                    ; $0037AC
        DBRA    D7,loc_0036F8                   ; $0037B0
        RTS                                     ; $0037B4
        LEA     $9000.W,A0                      ; $0037B6
        MOVE.W  $C8A0.W,D1                      ; $0037BA
        LEA     $00895A64,A1                    ; $0037BE
        MOVEA.L $00(A1,D1.W),A1                 ; $0037C4
        LEA     $00FF659C,A2                    ; $0037C8
        MOVE.W  #$0C80,D1                       ; $0037CE
        MOVEQ   #$02,D7                         ; $0037D2
loc_0037D4:
        MOVE.W  $0030(A0),D2                    ; $0037D4
        MOVE.W  $0034(A0),D4                    ; $0037D8
        SUB.W  (A1),D2                          ; $0037DC
        BPL.S  loc_0037E2                       ; $0037DE
        NEG.W  D2                               ; $0037E0
loc_0037E2:
        CMP.W  D1,D2                            ; $0037E2
        BGT.S  loc_00382C                       ; $0037E4
        SUB.W  $0004(A1),D4                     ; $0037E6
        BPL.S  loc_0037EE                       ; $0037EA
        NEG.W  D4                               ; $0037EC
loc_0037EE:
        CMP.W  D1,D4                            ; $0037EE
        BGT.S  loc_00382C                       ; $0037F0
        MOVE.W  #$0001,$0000(A2)                ; $0037F2
        MOVE.L  (A1)+,$0002(A2)                 ; $0037F8
        MOVE.W  (A1)+,$0006(A2)                 ; $0037FC
        MOVE.W  (A1)+,$000A(A2)                 ; $003800
        MOVE.W  (A1)+,$000E(A2)                 ; $003804
        MOVEA.L (A1),A1                         ; $003808
        MOVE.W  $C008.W,D0                      ; $00380A
        ADDQ.W  #1,D0                           ; $00380E
        CMPI.W  #$000C,D0                       ; $003810
        BNE.S  loc_00381A                       ; $003814
        MOVE.W  #$0000,D0                       ; $003816
loc_00381A:
        MOVE.W  D0,$C008.W                      ; $00381A
        LSR.W  #1,D0                            ; $00381E
        ADD.W  D0,D0                            ; $003820
        ADD.W  D0,D0                            ; $003822
        MOVE.L  $00(A1,D0.W),$0010(A2)          ; $003824
        BRA.S  loc_00383A                       ; $00382A
loc_00382C:
        LEA     $000E(A1),A1                    ; $00382C
        DBRA    D7,loc_0037D4                   ; $003830
        MOVE.W  #$0000,$0000(A2)                ; $003834
loc_00383A:
        MOVE.W  $C8A0.W,D0                      ; $00383A
        MOVEA.L $04(PC,D0.W),A1                 ; $00383E
        JMP     (A1)                            ; $003842
        ORI.L  #$385E0088,A0                    ; $003844
        MOVE.W  (A4)+,$0088(A4)                 ; $00384A
        MOVEA.W (A4)+,A4                        ; $00384E
        ORI.L  #$3AAA0088,A0                    ; $003850
        MOVEA.W (A4)+,A4                        ; $003856
        ORI.L  #$385C4E75,A0                    ; $003858
        TST.B  $C80F.W                          ; $00385E
        BEQ.S  loc_003866                       ; $003862
        RTS                                     ; $003864
loc_003866:
        LEA     $00883924,A1                    ; $003866
        LEA     $00FF65B0,A2                    ; $00386C
        ADDQ.W  #3,$C8E2.W                      ; $003872
        MOVE.W  #$0C80,D1                       ; $003876
        MOVE.W  #$1400,D3                       ; $00387A
        MOVE.W  #$0000,$0000(A2)                ; $00387E
        MOVE.W  #$0000,$0014(A2)                ; $003884
        MOVE.W  $C8E2.W,D0                      ; $00388A
        ANDI.W  #$1FFF,D0                       ; $00388E
        MOVE.W  D0,$0020(A2)                    ; $003892
        BSR.S  loc_0038C0                       ; $003896
        LEA     $0028(A2),A2                    ; $003898
        MOVE.W  $C8E2.W,D0                      ; $00389C
        LSL.W  #8,D0                            ; $0038A0
        MOVEM.L -(A7),D6/A6                     ; $0038A2
        JSR     $008F52(PC)                     ; $0038A6 [func_008F52]
        MOVEM.L D1/A1,(A7)+                     ; $0038AA
        ASL.W  #2,D0                            ; $0038AE
        MOVE.W  D0,$0020(A2)                    ; $0038B0
        MOVE.W  #$0000,$0000(A2)                ; $0038B4
        MOVE.W  #$0000,$0010(A2)                ; $0038BA
loc_0038C0:
        MOVE.W  $0030(A0),D2                    ; $0038C0
        MOVE.W  $0034(A0),D4                    ; $0038C4
        MOVE.W  $0032(A0),D5                    ; $0038C8
        SUB.W  (A1),D2                          ; $0038CC
        BPL.S  loc_0038D2                       ; $0038CE
        NEG.W  D2                               ; $0038D0
loc_0038D2:
        CMP.W  D1,D2                            ; $0038D2
        BGT.S  loc_003922                       ; $0038D4
        SUB.W  $0002(A1),D5                     ; $0038D6
        BPL.S  loc_0038DE                       ; $0038DA
        NEG.W  D5                               ; $0038DC
loc_0038DE:
        CMP.W  D3,D5                            ; $0038DE
        BGT.S  loc_003922                       ; $0038E0
        SUB.W  $0004(A1),D4                     ; $0038E2
        BPL.S  loc_0038EA                       ; $0038E6
        NEG.W  D4                               ; $0038E8
loc_0038EA:
        CMP.W  D1,D4                            ; $0038EA
        BGT.S  loc_003922                       ; $0038EC
        MOVE.W  #$0002,$0000(A2)                ; $0038EE
        MOVE.L  (A1)+,$0002(A2)                 ; $0038F4
        MOVE.W  (A1)+,$0006(A2)                 ; $0038F8
        MOVE.W  (A1)+,$000A(A2)                 ; $0038FC
        MOVE.W  (A1)+,$000E(A2)                 ; $003900
        MOVE.L  (A1)+,$0010(A2)                 ; $003904
        MOVE.W  #$0002,$0014(A2)                ; $003908
        MOVE.L  (A1)+,$0016(A2)                 ; $00390E
        MOVE.W  (A1)+,$001A(A2)                 ; $003912
        MOVE.W  (A1)+,$001E(A2)                 ; $003916
        MOVE.W  (A1)+,$0022(A2)                 ; $00391A
        MOVE.L  (A1)+,$0024(A2)                 ; $00391E
loc_003922:
        RTS                                     ; $003922
        MOVE.W  A1,D4                           ; $003924
        MOVE.B  (A7),D2                         ; $003926
        AND.B  D7,(A7)+                         ; $003928
        MOVEA.W <EA:3F>,A0                      ; $00392A
        ORI.B  #$222A,D0                        ; $00392C
        MOVE.B  (A0)+,(A2)                      ; $003930
        ORI.B  #$1CB3,D0                        ; $003932
        ORI.B  #$0000,D0                        ; $003936
        ORI.B  #$222A,D0                        ; $00393A
        MOVE.B  A4,D3                           ; $00393E
        MOVE.W  $2C(A0,D0.L),<EA:3E>            ; $003940
        ADD.W  D0,-(A1)                         ; $003944
        MOVE.B  D0,D0                           ; $003946
        ORI.B  #$222A,D0                        ; $003948
        MOVE.B  <EA:3E>,$00(A6,D0.W)            ; $00394C
        MOVEA.B $0000(A1),A5                    ; $003950
        ORI.B  #$0000,D0                        ; $003954
        MOVE.L  $1EB8(A2),D1                    ; $003958
        LEA     $00883A4E,A1                    ; $00395C
        LEA     $00FF65B0,A2                    ; $003962
        MOVE.L  #$22295A24,D0                   ; $003968
        MOVEQ   #$03,D7                         ; $00396E
        JSR     loc_0039EC(PC)                  ; $003970
        TST.B  $C80F.W                          ; $003974
        BEQ.S  loc_00397C                       ; $003978
        RTS                                     ; $00397A
loc_00397C:
        LEA     $00883A80,A1                    ; $00397C
        LEA     $00FF65D8,A2                    ; $003982
        ADDI.W  #$001E,$C8E2.W                  ; $003988
        MOVE.W  #$0C80,D1                       ; $00398E
        MOVE.W  #$1400,D3                       ; $003992
        MOVE.W  #$0000,$0000(A2)                ; $003996
        MOVE.W  #$0000,$0014(A2)                ; $00399C
        MOVE.W  $C8E2.W,D0                      ; $0039A2
        ANDI.W  #$1FFF,D0                       ; $0039A6
        MOVE.W  D0,$0020(A2)                    ; $0039AA
        JSR     loc_0038C0(PC)                  ; $0039AE
        LEA     $00FF65C4,A2                    ; $0039B2
        MOVE.W  #$0000,$0000(A2)                ; $0039B8
        TST.W  $00FF65D8                        ; $0039BE
        BEQ.S  loc_0039EA                       ; $0039C4
        LEA     $00883A76,A1                    ; $0039C6
        MOVE.W  #$0001,$0000(A2)                ; $0039CC
        MOVE.L  (A1)+,$0002(A2)                 ; $0039D2
        MOVE.W  (A1)+,$0006(A2)                 ; $0039D6
        MOVE.W  (A1)+,$000A(A2)                 ; $0039DA
        MOVE.W  (A1),$000E(A2)                  ; $0039DE
        MOVE.L  #$222A218E,$0010(A2)            ; $0039E2
loc_0039EA:
        RTS                                     ; $0039EA
loc_0039EC:
        MOVE.W  #$0C80,D1                       ; $0039EC
        MOVE.W  #$0300,D3                       ; $0039F0
loc_0039F4:
        MOVE.W  $0030(A0),D2                    ; $0039F4
        MOVE.W  $0034(A0),D4                    ; $0039F8
        MOVE.W  $0032(A0),D5                    ; $0039FC
        SUB.W  (A1),D2                          ; $003A00
        BPL.S  loc_003A06                       ; $003A02
        NEG.W  D2                               ; $003A04
loc_003A06:
        CMP.W  D1,D2                            ; $003A06
        BGT.S  loc_003A3E                       ; $003A08
        SUB.W  $0002(A1),D5                     ; $003A0A
        BPL.S  loc_003A12                       ; $003A0E
        NEG.W  D5                               ; $003A10
loc_003A12:
        CMP.W  D3,D5                            ; $003A12
        BGT.S  loc_003A3E                       ; $003A14
        SUB.W  $0004(A1),D4                     ; $003A16
        BPL.S  loc_003A1E                       ; $003A1A
        NEG.W  D4                               ; $003A1C
loc_003A1E:
        CMP.W  D1,D4                            ; $003A1E
        BGT.S  loc_003A3E                       ; $003A20
        MOVE.W  #$0001,$0000(A2)                ; $003A22
        MOVE.L  (A1)+,$0002(A2)                 ; $003A28
        MOVE.W  (A1)+,$0006(A2)                 ; $003A2C
        MOVE.W  (A1)+,$000A(A2)                 ; $003A30
        MOVE.W  (A1),$000E(A2)                  ; $003A34
        MOVE.L  D0,$0010(A2)                    ; $003A38
        RTS                                     ; $003A3C
loc_003A3E:
        LEA     $000A(A1),A1                    ; $003A3E
        DBRA    D7,loc_0039F4                   ; $003A42
        MOVE.W  #$0000,$0000(A2)                ; $003A46
        RTS                                     ; $003A4C
        MOVE.W  $33(A2,D1.L),-$1199(A1)         ; $003A4E
        MOVE.W  D0,D0                           ; $003A54
        BTST    D0,D0                           ; $003A56
        MOVEA.B A1,A0                           ; $003A58
        BSET    D7,A5                           ; $003A5A
        ROXL.W  -(A2)                           ; $003A5C
        MOVE.W  D0,D0                           ; $003A5E
        BTST    D0,(A0)                         ; $003A60
        MOVE.W  $0DE6(A0),(A0)                  ; $003A62
        ROXL.W  D4,D7                           ; $003A66
        MOVE.W  (A7)+,(A6)+                     ; $003A68
        DC.W    $00F7                           ; $003A6A
        BCLR    D7,A1                           ; $003A6C
        BSET    #28,A5                          ; $003A6E
        MOVE.W  D0,D4                           ; $003A72
        BTST    D0,D0                           ; $003A74
        MOVE.B  (A7),D3                         ; $003A76
        ADDI.L  #$F7AEF476,$0100(A4)            ; $003A78
        MOVE.B  $10A8F74A,-$0BB9(A2)            ; $003A80
        ORI.B  #$222A,D0                        ; $003A88
        MOVE.L  (A6)+,(A0)+                     ; $003A8C
        ORI.B  #$0000,D0                        ; $003A8E
        MOVEA.W $0000(A2),A5                    ; $003A92
        ORI.B  #$222A,D0                        ; $003A96
        MOVEA.L -$1F(A2,A7.W),A1                ; $003A9A
        ADDI.B  #$2A89,$00(A3,D0.W)             ; $003A9E
        BTST    D0,D0                           ; $003AA4
        MOVE.L  $2508(A2),D1                    ; $003AA6
        TST.B  $C80F.W                          ; $003AAA
        BEQ.S  loc_003AB2                       ; $003AAE
        RTS                                     ; $003AB0
loc_003AB2:
        LEA     $00883A9C,A1                    ; $003AB2
        LEA     $00FF65B0,A2                    ; $003AB8
        ADDI.W  #$003C,$C8E2.W                  ; $003ABE
        MOVE.W  #$0C80,D1                       ; $003AC4
        MOVE.W  #$1400,D3                       ; $003AC8
        MOVE.W  #$0000,$0000(A2)                ; $003ACC
        MOVE.W  $C8E2.W,D0                      ; $003AD2
        ANDI.W  #$1FFF,D0                       ; $003AD6
        MOVE.W  D0,$000A(A2)                    ; $003ADA
        MOVE.W  $0030(A0),D2                    ; $003ADE
        MOVE.W  $0034(A0),D4                    ; $003AE2
        MOVE.W  $0032(A0),D5                    ; $003AE6
        SUB.W  (A1),D2                          ; $003AEA
        BPL.S  loc_003AF0                       ; $003AEC
        NEG.W  D2                               ; $003AEE
loc_003AF0:
        CMP.W  D1,D2                            ; $003AF0
        BGT.S  loc_003B26                       ; $003AF2
        SUB.W  $0002(A1),D5                     ; $003AF4
        BPL.S  loc_003AFC                       ; $003AF8
        NEG.W  D5                               ; $003AFA
loc_003AFC:
        CMP.W  D3,D5                            ; $003AFC
        BGT.S  loc_003B26                       ; $003AFE
        SUB.W  $0004(A1),D4                     ; $003B00
        BPL.S  loc_003B08                       ; $003B04
        NEG.W  D4                               ; $003B06
loc_003B08:
        CMP.W  D1,D4                            ; $003B08
        BGT.S  loc_003B26                       ; $003B0A
        MOVE.W  #$0001,$0000(A2)                ; $003B0C
        MOVE.L  (A1)+,$0002(A2)                 ; $003B12
        MOVE.W  (A1)+,$0006(A2)                 ; $003B16
        MOVE.W  (A1)+,$000C(A2)                 ; $003B1A
        MOVE.W  (A1)+,$000E(A2)                 ; $003B1E
        MOVE.L  (A1)+,$0010(A2)                 ; $003B22
loc_003B26:
        RTS                                     ; $003B26
        LEA     $9F00.W,A0                      ; $003B28
        MOVE.W  $C8A0.W,D1                      ; $003B2C
        LEA     $00895A64,A1                    ; $003B30
        MOVEA.L $00(A1,D1.W),A1                 ; $003B36
        LEA     $00FF663C,A2                    ; $003B3A
        MOVE.W  #$0C80,D1                       ; $003B40
        MOVEQ   #$02,D7                         ; $003B44
loc_003B46:
        MOVE.W  $0030(A0),D2                    ; $003B46
        MOVE.W  $0034(A0),D4                    ; $003B4A
        SUB.W  (A1),D2                          ; $003B4E
        BPL.S  loc_003B54                       ; $003B50
        NEG.W  D2                               ; $003B52
loc_003B54:
        CMP.W  D1,D2                            ; $003B54
        BGT.S  loc_003B9E                       ; $003B56
        SUB.W  $0004(A1),D4                     ; $003B58
        BPL.S  loc_003B60                       ; $003B5C
        NEG.W  D4                               ; $003B5E
loc_003B60:
        CMP.W  D1,D4                            ; $003B60
        BGT.S  loc_003B9E                       ; $003B62
        MOVE.W  #$0001,$0000(A2)                ; $003B64
        MOVE.L  (A1)+,$0002(A2)                 ; $003B6A
        MOVE.W  (A1)+,$0006(A2)                 ; $003B6E
        MOVE.W  (A1)+,$000A(A2)                 ; $003B72
        MOVE.W  (A1)+,$000E(A2)                 ; $003B76
        MOVEA.L (A1),A1                         ; $003B7A
        MOVE.W  $C008.W,D0                      ; $003B7C
        ADDQ.W  #1,D0                           ; $003B80
        CMPI.W  #$000C,D0                       ; $003B82
        BNE.S  loc_003B8C                       ; $003B86
        MOVE.W  #$0000,D0                       ; $003B88
loc_003B8C:
        MOVE.W  D0,$C008.W                      ; $003B8C
        LSR.W  #1,D0                            ; $003B90
        ADD.W  D0,D0                            ; $003B92
        ADD.W  D0,D0                            ; $003B94
        MOVE.L  $00(A1,D0.W),$0010(A2)          ; $003B96
        BRA.S  loc_003BAC                       ; $003B9C
loc_003B9E:
        LEA     $000E(A1),A1                    ; $003B9E
        DBRA    D7,loc_003B46                   ; $003BA2
        MOVE.W  #$0000,$0000(A2)                ; $003BA6
loc_003BAC:
        MOVE.W  $C89C.W,D1                      ; $003BAC
        CMPI.W  #$0001,D1                       ; $003BB0
        BNE.S  loc_003C28                       ; $003BB4
        LEA     $00883A4E,A1                    ; $003BB6
        LEA     $00FF6650,A2                    ; $003BBC
        MOVE.W  #$0C80,D1                       ; $003BC2
        MOVE.W  #$0300,D3                       ; $003BC6
        MOVEQ   #$03,D7                         ; $003BCA
loc_003BCC:
        MOVE.W  $0030(A0),D2                    ; $003BCC
        MOVE.W  $0034(A0),D4                    ; $003BD0
        MOVE.W  $0032(A0),D5                    ; $003BD4
        SUB.W  (A1),D2                          ; $003BD8
        BPL.S  loc_003BDE                       ; $003BDA
        NEG.W  D2                               ; $003BDC
loc_003BDE:
        CMP.W  D1,D2                            ; $003BDE
        BGT.S  loc_003C1A                       ; $003BE0
        SUB.W  $0002(A1),D5                     ; $003BE2
        BPL.S  loc_003BEA                       ; $003BE6
        NEG.W  D5                               ; $003BE8
loc_003BEA:
        CMP.W  D3,D5                            ; $003BEA
        BGT.S  loc_003C1A                       ; $003BEC
        SUB.W  $0004(A1),D4                     ; $003BEE
        BPL.S  loc_003BF6                       ; $003BF2
        NEG.W  D4                               ; $003BF4
loc_003BF6:
        CMP.W  D1,D4                            ; $003BF6
        BGT.S  loc_003C1A                       ; $003BF8
        MOVE.W  #$0001,$0000(A2)                ; $003BFA
        MOVE.L  (A1)+,$0002(A2)                 ; $003C00
        MOVE.W  (A1)+,$0006(A2)                 ; $003C04
        MOVE.W  (A1)+,$000A(A2)                 ; $003C08
        MOVE.W  (A1),$000E(A2)                  ; $003C0C
        MOVE.L  #$22295A24,$0010(A2)            ; $003C10
        RTS                                     ; $003C18
loc_003C1A:
        LEA     $000A(A1),A1                    ; $003C1A
        DBRA    D7,loc_003BCC                   ; $003C1E
        MOVE.W  #$0000,$0000(A2)                ; $003C22
loc_003C28:
        RTS                                     ; $003C28
        MOVE.W  (A0),-$06(A0,D0.L)              ; $003C2A
        MOVE.W  -$70(A0,A7.W),$0A40.W           ; $003C2E
        MOVE.W  $70(A0,A6.L),$03B3.W            ; $003C34
        MOVE.W  (A0),-$1700(A5)                 ; $003C3A
        DC.W    $0AF0                           ; $003C3E
        BTST    #16,D0                          ; $003C40
        BCLR    D1,$50(A3,A7.L)                 ; $003C44
        MOVE.W  (A0),-$06(A0,D0.L)              ; $003C48
        MOVE.W  $30(A0,D0.W),$002B.W            ; $003C4C
        ORI.B  #$FFFD,-$29(A1,A7.L)             ; $003C52
        ORI.B  #$FFCE,-$0003(A3)                ; $003C58
        ORI.B  #$0021,$35(A4,D0.W)              ; $003C5E
        MOVE.W  -$2D(A3,A7.L),<EA:3F>           ; $003C64
        ORI.B  #$FFCA,-(A1)                     ; $003C68
        MOVE.W  $34(A3,D0.W),<EA:3F>            ; $003C6C
        ORI.B  #$0035,(A7)                      ; $003C70
        MOVE.W  -$002D(A6),<EA:3F>              ; $003C74
        ORI.B  #$FFCA,(A7)                      ; $003C78
        MOVE.W  $3038(A6),<EA:3F>               ; $003C7C
        MULU    A0,D4                           ; $003C80
        LSL.W  #4,D0                            ; $003C82
        LEA     -$38(PC,D0.W),A2                ; $003C84
        MOVE.W  $C8A0.W,D0                      ; $003C88
        ADD.W  $C89E.W,D0                       ; $003C8C
        LEA     -$68(PC,D0.W),A3                ; $003C90
        LEA     $00FF66DC,A1                    ; $003C94
        MOVEQ   #$01,D1                         ; $003C9A
        MOVEQ   #$03,D2                         ; $003C9C
loc_003C9E:
        MOVE.W  D1,$0000(A1)                    ; $003C9E
        MOVE.W  (A3)+,D0                        ; $003CA2
        ADD.W  (A2)+,D0                         ; $003CA4
        MOVE.W  D0,$0002(A1)                    ; $003CA6
        MOVE.W  (A3)+,$0004(A1)                 ; $003CAA
        MOVE.W  (A3)+,D0                        ; $003CAE
        SUB.W  (A2)+,D0                         ; $003CB0
        MOVE.W  D0,$0006(A1)                    ; $003CB2
        LEA     $0014(A1),A1                    ; $003CB6
        SUBQ.W  #6,A3                           ; $003CBA
        DBRA    D2,loc_003C9E                   ; $003CBC
        MOVEQ   #$00,D0                         ; $003CC0
        BRA.S  loc_003CCE                       ; $003CC2
        MOVEQ   #$00,D0                         ; $003CC4
        MOVE.W  $C026.W,D0                      ; $003CC6
        BPL.S  loc_003CCE                       ; $003CCA
        RTS                                     ; $003CCC
loc_003CCE:
        LEA     $00FF66EC,A1                    ; $003CCE
        LEA     $00895B7E,A2                    ; $003CD4
        ASL.W  #4,D0                            ; $003CDA
        MOVEQ   #$03,D1                         ; $003CDC
loc_003CDE:
        MOVEA.L (A2)+,A3                        ; $003CDE
        ADDA.L  D0,A3                           ; $003CE0
        MOVE.L  A3,(A1)                         ; $003CE2
        LEA     $0014(A1),A1                    ; $003CE4
        DBRA    D1,loc_003CDE                   ; $003CE8
        MOVE.W  $C026.W,D1                      ; $003CEC
        CMPI.W  #$0007,D1                       ; $003CF0
        BLT.S  loc_003D22                       ; $003CF4
        CMPI.W  #$0013,D1                       ; $003CF6
        BGE.S  loc_003D22                       ; $003CFA
        MOVEQ   #$00,D0                         ; $003CFC
        LEA     $00FF6128,A1                    ; $003CFE
        MOVE.W  D0,$0000(A1)                    ; $003D04
        MOVE.W  D0,$0014(A1)                    ; $003D08
        TST.W  $C04C.W                          ; $003D0C
        BNE.S  loc_003D20                       ; $003D10
        MOVE.W  D0,$0028(A1)                    ; $003D12
        TST.W  $C8C8.W                          ; $003D16
        BNE.S  loc_003D20                       ; $003D1A
        MOVE.W  D0,$003C(A1)                    ; $003D1C
loc_003D20:
        RTS                                     ; $003D20
loc_003D22:
        CMPI.W  #$0004,D1                       ; $003D22
        BNE.S  loc_003D2E                       ; $003D26
        MOVE.B  #$00BA,$C8A4.W                  ; $003D28
loc_003D2E:
        CMPI.W  #$0016,D1                       ; $003D2E
        BNE.S  loc_003D3A                       ; $003D32
        MOVE.B  #$00BA,$C8A4.W                  ; $003D34
loc_003D3A:
        MOVEQ   #$01,D0                         ; $003D3A
        LEA     $00FF6128,A1                    ; $003D3C
        MOVE.W  D0,$0000(A1)                    ; $003D42
        MOVE.W  D0,$0014(A1)                    ; $003D46
        TST.W  $C04C.W                          ; $003D4A
        BNE.S  loc_003D58                       ; $003D4E
        MOVE.W  D0,$0028(A1)                    ; $003D50
        MOVE.W  D0,$003C(A1)                    ; $003D54
loc_003D58:
        RTS                                     ; $003D58
        LEA     $00FF6980,A1                    ; $003D5A
        MOVE.B  #$0009,(A1)                     ; $003D60
        MOVE.L  #$040268F8,$0004(A1)            ; $003D64
        MOVE.L  #$222F0FBE,$0008(A1)            ; $003D6C
        LEA     $00FF69C0,A1                    ; $003D74
        MOVE.B  #$0009,(A1)                     ; $003D7A
        LEA     $00FF6990,A1                    ; $003D7E
        MOVE.B  #$0009,(A1)                     ; $003D84
        MOVE.L  #$0402C8EC,$0004(A1)            ; $003D88
        MOVE.L  #$222F22A2,$0008(A1)            ; $003D90
        RTS                                     ; $003D98
        MOVE.W  #$0000,$C8AA.W                  ; $003D9A
        ADDQ.W  #4,$C8AC.W                      ; $003DA0
        RTS                                     ; $003DA4
        CMPI.W  #$0014,$C8AA.W                  ; $003DA6
        BLE.S  loc_003DD2                       ; $003DAC
        LEA     $00FF69C0,A1                    ; $003DAE
        MOVE.B  #$0009,$0000(A1)                ; $003DB4
        MOVE.L  #$222F1D4A,$0008(A1)            ; $003DBA
        MOVE.W  #$0000,$C8AA.W                  ; $003DC2
        MOVE.B  #$00A6,$C8A4.W                  ; $003DC8
        ADDQ.W  #4,$C8AC.W                      ; $003DCE
loc_003DD2:
        RTS                                     ; $003DD2
        CMPI.W  #$0014,$C8AA.W                  ; $003DD4
        BLE.S  loc_003E06                       ; $003DDA
        MOVE.L  #$222F29EE,$00FF69C8            ; $003DDC
        MOVE.L  #$222F1716,$00FF6998            ; $003DE6
        MOVE.W  #$0000,$C8AA.W                  ; $003DF0
        MOVE.B  #$00A7,$C8A4.W                  ; $003DF6
        BSET    #4,$C30E.W                      ; $003DFC
        ADDQ.W  #4,$C8AC.W                      ; $003E02
loc_003E06:
        RTS                                     ; $003E06
        CMPI.W  #$000A,$C8AA.W                  ; $003E08
        BNE.S  loc_003E28                       ; $003E0E
        MOVE.W  $C89C.W,D0                      ; $003E10
        MOVE.B  $3C(PC,D0.W),$C8A5.W            ; $003E14
        BTST    #5,$C80E.W                      ; $003E1A
        BEQ.S  loc_003E28                       ; $003E20
        MOVE.B  #$0093,$C8A5.W                  ; $003E22
loc_003E28:
        CMPI.W  #$0028,$C8AA.W                  ; $003E28
        BLE.S  loc_003E50                       ; $003E2E
        MOVE.W  #$0000,$C8AA.W                  ; $003E30
        MOVE.W  #$0000,$C8AC.W                  ; $003E36
        MOVEQ   #$00,D0                         ; $003E3C
        MOVE.B  D0,$00FF6980                    ; $003E3E
        MOVE.B  D0,$00FF6990                    ; $003E44
        MOVE.B  D0,$00FF69C0                    ; $003E4A
loc_003E50:
        RTS                                     ; $003E50
        OR.L   D1,D3                            ; $003E52
        OR.L   (A1)+,D2                         ; $003E54
        SUB.L  (A1)+,D7                         ; $003E56
        MOVE.W  #$0000,$C8AA.W                  ; $003E58
        ADDQ.W  #4,$C8AC.W                      ; $003E5E
        RTS                                     ; $003E62
        MOVE.W  #$0000,$C8AA.W                  ; $003E64
        ADDQ.W  #4,$C8AC.W                      ; $003E6A
        MOVE.B  #$0009,$00FF6980                ; $003E6E
        MOVE.B  #$00C0,$C8A4.W                  ; $003E76
        RTS                                     ; $003E7C
        CMPI.W  #$0014,$C8AA.W                  ; $003E7E
        BLE.S  loc_003EA0                       ; $003E84
        MOVE.L  #$222F038A,$00FF6988            ; $003E86
        MOVE.B  #$00C1,$C8A4.W                  ; $003E90
        MOVE.W  #$0000,$C8AA.W                  ; $003E96
        ADDQ.W  #4,$C8AC.W                      ; $003E9C
loc_003EA0:
        RTS                                     ; $003EA0
        CMPI.W  #$0014,$C8AA.W                  ; $003EA2
        BLE.S  loc_003EC4                       ; $003EA8
        MOVE.L  #$222F002C,$00FF6988            ; $003EAA
        MOVE.B  #$00C2,$C8A4.W                  ; $003EB4
        MOVE.W  #$0000,$C8AA.W                  ; $003EBA
        ADDQ.W  #4,$C8AC.W                      ; $003EC0
loc_003EC4:
        RTS                                     ; $003EC4
        CMPI.W  #$0014,$C8AA.W                  ; $003EC6
        BLE.S  loc_003EF4                       ; $003ECC
        MOVE.L  #$222EEF3A,$00FF6988            ; $003ECE
        MOVE.B  #$00C3,$C8A4.W                  ; $003ED8
        MOVE.W  #$0000,$C8AA.W                  ; $003EDE
        BSET    #4,$C30E.W                      ; $003EE4
        BSET    #4,$B4EE.W                      ; $003EEA
        ADDQ.W  #4,$C8AC.W                      ; $003EF0
loc_003EF4:
        RTS                                     ; $003EF4
        CMPI.W  #$0005,$C8AA.W                  ; $003EF6
        BNE.S  loc_003F04                       ; $003EFC
        MOVE.B  #$0098,$C8A5.W                  ; $003EFE
loc_003F04:
        MOVEQ   #$00,D0                         ; $003F04
        BTST    #2,$C8AB.W                      ; $003F06
        BNE.S  loc_003F10                       ; $003F0C
        MOVEQ   #$09,D0                         ; $003F0E
loc_003F10:
        MOVE.B  D0,$00FF6980                    ; $003F10
        CMPI.W  #$003C,$C8AA.W                  ; $003F16
        BLE.S  loc_003F2A                       ; $003F1C
        MOVE.B  #$0000,$00FF6980                ; $003F1E
        ADDQ.W  #4,$C8AC.W                      ; $003F26
loc_003F2A:
        RTS                                     ; $003F2A
        RTS                                     ; $003F2C
        MOVEQ   #$00,D3                         ; $003F2E
        MOVEQ   #$00,D4                         ; $003F30
        TST.W  $00FF6448                        ; $003F32
        BEQ.S  loc_003F44                       ; $003F38
        TST.W  $00C0(A0)                        ; $003F3A
        BEQ.S  loc_003F44                       ; $003F3E
        MOVEQ   #$01,D3                         ; $003F40
        MOVEQ   #$02,D4                         ; $003F42
loc_003F44:
        LEA     $00FF64AC,A1                    ; $003F44
        JSR     loc_003F90(PC)                  ; $003F4A
        MOVEQ   #$01,D3                         ; $003F4E
        MOVEQ   #$02,D4                         ; $003F50
        LEA     $00FF6178,A1                    ; $003F52
        BRA.S  loc_003F90                       ; $003F58
        MOVEQ   #$00,D3                         ; $003F5A
        MOVEQ   #$00,D4                         ; $003F5C
        TST.W  $00FF6218                        ; $003F5E
        BEQ.S  loc_003F70                       ; $003F64
        TST.W  $00C0(A0)                        ; $003F66
        BEQ.S  loc_003F70                       ; $003F6A
        MOVEQ   #$01,D3                         ; $003F6C
        MOVEQ   #$02,D4                         ; $003F6E
loc_003F70:
        LEA     $00FF627C,A1                    ; $003F70
        JSR     loc_003F90(PC)                  ; $003F76
        MOVEQ   #$01,D3                         ; $003F7A
        MOVEQ   #$02,D4                         ; $003F7C
        LEA     $00FF63A8,A1                    ; $003F7E
        BRA.S  loc_003F90                       ; $003F84
        LEA     $00FF6178,A1                    ; $003F86
        MOVEQ   #$01,D3                         ; $003F8C
        MOVEQ   #$02,D4                         ; $003F8E
loc_003F90:
        MOVEQ   #$00,D1                         ; $003F90
        MOVEQ   #$14,D2                         ; $003F92
        MOVE.W  D1,$0000(A1)                    ; $003F94
        MOVE.W  D1,$00(A1,D2.W)                 ; $003F98
        MOVE.W  $C00C.W,D0                      ; $003F9C
        BMI.S  loc_003FC0                       ; $003FA0
        ADD.W  D0,D0                            ; $003FA2
        ADD.W  D0,D0                            ; $003FA4
        LEA     $008959B0,A2                    ; $003FA6
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $003FAC
        MOVE.W  D4,$0000(A1)                    ; $003FB2
        MOVE.L  $00(A2,D0.W),$10(A1,D2.W)       ; $003FB6
        MOVE.W  D3,$00(A1,D2.W)                 ; $003FBC
loc_003FC0:
        ADDA.L  D2,A1                           ; $003FC0
        ADDA.L  D2,A1                           ; $003FC2
        MOVE.W  D1,$0000(A1)                    ; $003FC4
        MOVE.W  $C012.W,D0                      ; $003FC8
        BMI.S  loc_003FE2                       ; $003FCC
        ADD.W  D0,D0                            ; $003FCE
        ADD.W  D0,D0                            ; $003FD0
        LEA     $008959D0,A2                    ; $003FD2
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $003FD8
        MOVE.W  D3,$0000(A1)                    ; $003FDE
loc_003FE2:
        ADDA.L  D2,A1                           ; $003FE2
        MOVE.W  D1,$0000(A1)                    ; $003FE4
        MOVE.W  $C018.W,D0                      ; $003FE8
        BMI.S  loc_004002                       ; $003FEC
        ADD.W  D0,D0                            ; $003FEE
        ADD.W  D0,D0                            ; $003FF0
        LEA     $008959FC,A2                    ; $003FF2
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $003FF8
        MOVE.W  D3,$0000(A1)                    ; $003FFE
loc_004002:
        ADDA.L  D2,A1                           ; $004002
        MOVE.W  D1,$0000(A1)                    ; $004004
        MOVE.W  $C01E.W,D0                      ; $004008
        BMI.S  loc_004022                       ; $00400C
        ADD.W  D0,D0                            ; $00400E
        ADD.W  D0,D0                            ; $004010
        LEA     $00895A24,A2                    ; $004012
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $004018
        MOVE.W  D4,$0000(A1)                    ; $00401E
loc_004022:
        ADDA.L  D2,A1                           ; $004022
        MOVE.W  D1,$0000(A1)                    ; $004024
        MOVE.W  $C024.W,D0                      ; $004028
        BMI.S  loc_004042                       ; $00402C
        ADD.W  D0,D0                            ; $00402E
        ADD.W  D0,D0                            ; $004030
        LEA     $00895A24,A2                    ; $004032
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $004038
        MOVE.W  D3,$0000(A1)                    ; $00403E
loc_004042:
        ADDA.L  D2,A1                           ; $004042
        MOVE.W  D1,$0000(A1)                    ; $004044
        MOVE.W  $C00E.W,D0                      ; $004048
        BMI.S  loc_004062                       ; $00404C
        ADD.W  D0,D0                            ; $00404E
        ADD.W  D0,D0                            ; $004050
        LEA     $00895A44,A2                    ; $004052
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $004058
        MOVE.W  D4,$0000(A1)                    ; $00405E
loc_004062:
        ADDA.L  D2,A1                           ; $004062
        MOVE.W  D1,$0000(A1)                    ; $004064
        MOVE.W  $C010.W,D0                      ; $004068
        BMI.S  loc_004082                       ; $00406C
        ADD.W  D0,D0                            ; $00406E
        ADD.W  D0,D0                            ; $004070
        LEA     $00895A44,A2                    ; $004072
        MOVE.L  $00(A2,D0.W),$0010(A1)          ; $004078
        MOVE.W  D3,$0000(A1)                    ; $00407E
loc_004082:
        RTS                                     ; $004082
        MOVE.W  #$0001,$C048.W                  ; $004084
        MOVE.W  $C07C.W,D0                      ; $00408A
        MOVEA.L $04(PC,D0.W),A1                 ; $00408E
        JMP     (A1)                            ; $004092
        ORI.L  #$40C80088,A0                    ; $004094
        DC.W    $412E                           ; $00409A
        ORI.L  #$413A0088,A0                    ; $00409C
        DC.W    $4168                           ; $0040A2
        ORI.L  #$417C0088,A0                    ; $0040A4
        LEA     -(A4),A0                        ; $0040AA
        ORI.L  #$42BA0088,A0                    ; $0040AC
        DC.W    $4300                           ; $0040B2
        ORI.L  #$432E0088,A0                    ; $0040B4
        DC.W    $434A                           ; $0040BA
        ORI.L  #$43900088,A0                    ; $0040BC
        DC.W    $43BC                           ; $0040C2
        ORI.L  #$43D011FC,A0                    ; $0040C4
        ORI.B  #$C800,D1                        ; $0040CA
        CMPI.W  #$FFFF,$C050.W                  ; $0040CE
        BNE.S  loc_0040DC                       ; $0040D4
        MOVE.W  #$0000,$C050.W                  ; $0040D6
loc_0040DC:
        MOVE.B  #$0000,$00FF6960                ; $0040DC
        MOVE.B  #$0000,$00FF6930                ; $0040E4
        MOVE.B  #$0000,$00FF6970                ; $0040EC
        LEA     $00FF6754,A2                    ; $0040F4
        MOVE.B  #$00F3,$C822.W                  ; $0040FA
        MOVE.W  #$FFE0,$0004(A2)                ; $004100
        MOVE.W  #$0040,$0006(A2)                ; $004106
        MOVE.W  #$F600,$0008(A2)                ; $00410C
        MOVE.L  #$2229660C,$0010(A2)            ; $004112
        MOVE.W  #$0001,$0000(A2)                ; $00411A
        MOVE.W  #$0040,$C25C.W                  ; $004120
        ADDQ.W  #4,$C07C.W                      ; $004126
        JMP     $00B1B8(PC)                     ; $00412A
        MOVE.B  #$0096,$C8A5.W                  ; $00412E
        ADDQ.W  #4,$C07C.W                      ; $004134
        RTS                                     ; $004138
        LEA     $00FF6754,A2                    ; $00413A
        ADDQ.W  #8,$C25C.W                      ; $004140
        MOVE.W  $C25C.W,D0                      ; $004144
        MOVE.W  D0,$0006(A2)                    ; $004148
        ADDQ.W  #2,$0004(A2)                    ; $00414C
        ADDI.W  #$01C0,$0008(A2)                ; $004150
        CMPI.W  #$0100,D0                       ; $004156
        BNE.S  loc_004166                       ; $00415A
        ADDQ.W  #4,$C07C.W                      ; $00415C
        MOVE.W  #$0000,$C8AA.W                  ; $004160
loc_004166:
        RTS                                     ; $004166
        CMPI.W  #$003C,$C8AA.W                  ; $004168
        BNE.S  loc_00417A                       ; $00416E
        ADDQ.W  #4,$C07C.W                      ; $004170
        MOVE.W  #$0000,$C8AA.W                  ; $004174
loc_00417A:
        RTS                                     ; $00417A
        CMPI.W  #$0015,$C8AA.W                  ; $00417C
        BNE.S  loc_0041E2                       ; $004182
        MOVE.W  $C096.W,$C07A.W                 ; $004184
        ADDQ.W  #4,$C07C.W                      ; $00418A
        MOVE.W  #$0000,$00FF6754                ; $00418E
        TST.B  $FDA9.W                          ; $004196
        BEQ.S  loc_0041E2                       ; $00419A
        CMPI.B  #$0001,$C30C.W                  ; $00419C
        BNE.S  loc_0041E2                       ; $0041A2
        BTST    #7,$FDA8.W                      ; $0041A4
        BNE.S  loc_0041E2                       ; $0041AA
        MOVE.W  $C89C.W,D0                      ; $0041AC
        BSET    D0,$EF07.W                      ; $0041B0
        CMPI.B  #$0002,$FDA9.W                  ; $0041B4
        BNE.S  loc_0041C0                       ; $0041BA
        BSET    D0,$FEB7.W                      ; $0041BC
loc_0041C0:
        CMPI.B  #$001F,$FEB7.W                  ; $0041C0
        BNE.S  loc_0041D4                       ; $0041C6
        BSET    #6,$FEB7.W                      ; $0041C8
        BSET    #7,$FEB7.W                      ; $0041CE
loc_0041D4:
        CMPI.B  #$001F,$EF07.W                  ; $0041D4
        BNE.S  loc_0041E2                       ; $0041DA
        BSET    #0,$FDA8.W                      ; $0041DC
loc_0041E2:
        RTS                                     ; $0041E2
        MOVE.B  #$0001,$C800.W                  ; $0041E4
        MOVE.B  #$00F3,$C822.W                  ; $0041EA
        BTST    #5,$C30E.W                      ; $0041F0
        BNE.S  loc_0041FC                       ; $0041F6
        JSR     $00B1B8(PC)                     ; $0041F8
loc_0041FC:
        JSR     $0088CA20                       ; $0041FC
