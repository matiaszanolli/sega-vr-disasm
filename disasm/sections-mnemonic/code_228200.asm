; Generated assembly for $228200-$22A200
; Branch targets: 0
; Labels: 0
; Format: DC.W with decoded mnemonics as comments

        org     $228200

        BCHG    D0,$05(A0,D2.W)                 ; $228200
        ADD.L  D7,$70(A7,D0.W)                  ; $228204
        MOVE.L  D5,D3                           ; $228208
        ADD.L  D7,$58(A7,D0.W)                  ; $22820A
        MOVE.L  -(A5),-$78(PC,A5.L)             ; $22820E
        BCHG    D0,(A0)+                        ; $228212
        MOVE.L  -(A5),-$49(PC,A5.L)             ; $228214
        BCHG    D0,$2605DFB7                    ; $228218
        BCHG    D0,-(A1)                        ; $22821E
        MOVE.L  -(A5),$01(PC,A5.L)              ; $228220
        BCHG    D0,-(A1)                        ; $228224
        MOVE.L  -(A5),$01(PC,A5.L)              ; $228226
        BCHG    D0,$2605D707                    ; $22822A
        BCHG    D0,(A6)                         ; $228230
        MOVE.L  -$2980(A6),(A4)                 ; $228232
        BCHG    D0,$3C(A6,D2.W)                 ; $228236
        ADD.W  D4,A2                            ; $22823A
        BCHG    D0,$2605D94A                    ; $22823C
        BCHG    D0,-(A1)                        ; $228242
        MOVE.L  -(A5),-$41(PC,A5.L)             ; $228244
        BCHG    D0,-(A2)                        ; $228248
        MOVE.L  (A5)+,-$49(PC,A5.L)             ; $22824A
        BCHG    D0,-$1B(A7,D2.W)                ; $22824E
        DC.W    $DFBF               ; $228252 ADD.L  D7,<EA:3F>
        DC.W    $017F               ; $228254 BCHG    D0,<EA:3F>
        MOVE.L  (A5)+,-$7E(PC,A6.W)             ; $228256
        BCHG    D0,-$2D(PC,D2.W)                ; $22825A
        ADD.L  -(A2),D5                         ; $22825E
        DC.W    $0188               ; $228260 BCLR    D0,A0
        MOVE.L  -(A5),D2                        ; $228262
        ADD.L  $0188(A3),D5                     ; $228264
        MOVE.L  -(A5),D2                        ; $228268
        ADD.B  D7,(A7)+                         ; $22826A
        DC.W    $0188               ; $22826C BCLR    D0,A0
        MOVE.L  -(A5),D2                        ; $22826E
        ADD.B  D7,$0188(A1)                     ; $228270
        MOVE.L  -(A5),D2                        ; $228274
        ADD.B  D1,D5                            ; $228276
        DC.W    $0188               ; $228278 BCLR    D0,A0
        MOVE.L  -(A5),D2                        ; $22827A
        ADD.W  D7,D5                            ; $22827C
        DC.W    $0188               ; $22827E BCLR    D0,A0
        MOVE.L  -(A5),D2                        ; $228280
        ADD.L  D7,A0                            ; $228282
        DC.W    $0188               ; $228284 BCLR    D0,A0
        MOVE.L  -(A5),D2                        ; $228286
        ADD.L  D7,-$78(A7,D0.W)                 ; $228288
        MOVE.L  -(A5),D2                        ; $22828C
        ADD.L  D6,(A6)                          ; $22828E
        BCHG    D0,$04(A0,D2.W)                 ; $228290
        ADD.L  D6,(A6)                          ; $228294
        DC.W    $0188               ; $228296 BCLR    D0,A0
        MOVE.L  -(A6),D2                        ; $228298
        ADD.L  D6,-(A0)                         ; $22829A
        DC.W    $0188               ; $22829C BCLR    D0,A0
        MOVE.L  -(A6),D2                        ; $22829E
        ADD.L  D6,-(A0)                         ; $2282A0
        BCHG    D0,$04(A0,D2.W)                 ; $2282A2
        ADD.W  D0,D6                            ; $2282A6
        BCHG    D0,$04(A0,D2.W)                 ; $2282A8
        ADD.W  D0,D6                            ; $2282AC
        DC.W    $0188               ; $2282AE BCLR    D0,A0
        MOVE.L  -(A6),D2                        ; $2282B0
        ADD.W  A1,D6                            ; $2282B2
        DC.W    $0188               ; $2282B4 BCLR    D0,A0
        MOVE.L  -(A6),D2                        ; $2282B6
        ADD.W  A1,D6                            ; $2282B8
        BCHG    D0,$04(A0,D2.W)                 ; $2282BA
        ADD.L  D7,-$6F(A7,D0.W)                 ; $2282BE
        MOVE.L  -(A5),D2                        ; $2282C2
        ADD.B  D1,D5                            ; $2282C4
        BCLR    D0,(A1)                         ; $2282C6
        MOVE.L  -(A5),D2                        ; $2282C8
        ADD.W  D4,A3                            ; $2282CA
        BCLR    D0,(A1)                         ; $2282CC
        MOVE.L  -(A5),D2                        ; $2282CE
        ADDA.L  $017A(PC),A4                    ; $2282D0
        DC.W    $25FD,$DA01         ; $2282D4 MOVE.L  <EA:3D>,-$25FF(PC)
        DC.W    $018F               ; $2282D8 BCLR    D0,A7
        MOVE.L  D5,D3                           ; $2282DA
        ADDA.L  $019725FD,A4                    ; $2282DC
        ADD.L  -(A2),D5                         ; $2282E2
        BCLR    D0,(A0)                         ; $2282E4
        MOVEA.L D5,A1                           ; $2282E6
        ADD.L  $0190(A3),D5                     ; $2282E8
        MOVEA.L D5,A1                           ; $2282EC
        ADD.B  D7,(A7)+                         ; $2282EE
        BCLR    D0,(A0)                         ; $2282F0
        MOVEA.L D5,A1                           ; $2282F2
        ADD.B  D7,$0190(A1)                     ; $2282F4
        MOVEA.L D5,A1                           ; $2282F8
        ADD.B  D1,D5                            ; $2282FA
        BCLR    D0,(A0)                         ; $2282FC
        MOVEA.L D5,A1                           ; $2282FE
        ADD.W  D7,D5                            ; $228300
        BCLR    D0,(A0)                         ; $228302
        MOVEA.L D5,A1                           ; $228304
        ADD.L  D7,A0                            ; $228306
        BCLR    D0,(A0)                         ; $228308
        MOVEA.L D5,A1                           ; $22830A
        ADD.L  D7,-$70(A7,D0.W)                 ; $22830C
        MOVEA.L D5,A1                           ; $228310
        ADD.L  D7,-$67(A7,D0.W)                 ; $228312
        MOVEA.L D5,A1                           ; $228316
        ADD.B  D1,D5                            ; $228318
        BCLR    D0,(A1)+                        ; $22831A
        MOVEA.L D5,A1                           ; $22831C
        ADD.L  D7,-$59(A7,D0.W)                 ; $22831E
        MOVE.L  -(A5),D2                        ; $228322
        DC.W    $DFBF               ; $228324 ADD.L  D7,<EA:3F>
        BCLR    D0,$241D(A7)                    ; $228326
        ADD.L  -(A2),D5                         ; $22832A
        BCLR    D0,(A0)+                        ; $22832C
        MOVE.L  -(A1),(A0)                      ; $22832E
        ADD.L  $0198(A3),D5                     ; $228330
        MOVE.L  -(A1),(A0)                      ; $228334
        ADD.B  D7,(A7)+                         ; $228336
        BCLR    D0,(A0)+                        ; $228338
        MOVE.L  -(A1),(A0)                      ; $22833A
        ADD.B  D7,$0198(A1)                     ; $22833C
        MOVE.L  -(A1),(A0)                      ; $228340
        ADD.B  D1,D5                            ; $228342
        BCLR    D0,(A0)+                        ; $228344
        MOVE.L  -(A1),(A0)                      ; $228346
        ADD.W  D7,D5                            ; $228348
        BCLR    D0,(A0)+                        ; $22834A
        MOVE.L  -(A1),(A0)                      ; $22834C
        ADD.L  D7,A0                            ; $22834E
        BCLR    D0,(A0)+                        ; $228350
        MOVE.L  -(A1),(A0)                      ; $228352
        ADD.L  D7,-$68(A7,D0.W)                 ; $228354
        MOVE.L  -(A1),(A0)                      ; $228358
        ADD.W  D0,D6                            ; $22835A
        BCLR    D0,(A0)                         ; $22835C
        MOVEA.L D4,A1                           ; $22835E
        ADD.W  D0,D6                            ; $228360
        BCLR    D0,(A0)+                        ; $228362
        MOVE.L  -(A3),(A0)                      ; $228364
        ADD.W  A1,D6                            ; $228366
        BCLR    D0,(A0)+                        ; $228368
        MOVE.L  -(A3),(A0)                      ; $22836A
        ADD.W  A1,D6                            ; $22836C
        BCLR    D0,(A0)                         ; $22836E
        MOVEA.L D4,A1                           ; $228370
        ADD.L  D6,-(A0)                         ; $228372
        BCLR    D0,(A0)+                        ; $228374
        MOVE.L  -(A3),(A0)                      ; $228376
        ADD.L  D6,-(A0)                         ; $228378
        BCLR    D0,(A0)                         ; $22837A
        MOVEA.L D4,A1                           ; $22837C
        ADD.L  D6,(A6)                          ; $22837E
        BCLR    D0,(A0)                         ; $228380
        MOVEA.L D4,A1                           ; $228382
        ADD.L  D6,(A6)                          ; $228384
        BCLR    D0,(A0)+                        ; $228386
        MOVE.L  -(A3),(A0)                      ; $228388
        ADD.W  D4,A3                            ; $22838A
        BCLR    D0,(A1)+                        ; $22838C
        MOVEA.L D4,A1                           ; $22838E
        ADD.L  -(A1),D5                         ; $228390
        BCLR    D0,(A0)+                        ; $228392
        DC.W    $1FCA               ; $228394 MOVE.B  A2,<EA:3F>
        ADD.L  $0198(A5),D5                     ; $228396
        DC.W    $1FC0               ; $22839A MOVE.B  D0,<EA:3F>
        ADD.W  A0,D5                            ; $22839C
        BCLR    D0,(A0)+                        ; $22839E
        MOVE.L  (A4),D0                         ; $2283A0
        ADD.B  D2,D5                            ; $2283A2
        BCLR    D0,(A0)+                        ; $2283A4
        MOVEA.L -(A4),A0                        ; $2283A6
        ADD.L  $0198(PC),D3                     ; $2283A8
        MOVEA.L -(A4),A0                        ; $2283AC
        ADDA.W  (A0)+,A3                        ; $2283AE
        BCLR    D0,(A0)+                        ; $2283B0
        MOVE.L  (A4),D0                         ; $2283B2
        ADD.L  D7,-$5F(A7,D0.W)                 ; $2283B4
        MOVE.L  -(A1),(A0)                      ; $2283B8
        ADD.B  D2,D5                            ; $2283BA
        BCLR    D0,-(A1)                        ; $2283BC
        MOVEA.L -(A4),A0                        ; $2283BE
        ADD.L  $01A1(PC),D3                     ; $2283C0
        MOVEA.L -(A4),A0                        ; $2283C4
        ADD.W  D4,A3                            ; $2283C6
        BCLR    D0,-(A1)                        ; $2283C8
        MOVE.L  -$2041(A4),-(A0)                ; $2283CA
        BCLR    D0,(A2)                         ; $2283CE
        MOVE.L  (A5)+,D2                        ; $2283D0
        ADD.L  -$5F(PC,D0.W),D3                 ; $2283D2
        MOVE.L  -$25FF(A4),-(A0)                ; $2283D6
        BCLR    D0,$2245(A7)                    ; $2283DA
        ADDA.L  $01B7223D,A4                    ; $2283DE
        ADDA.L  $019A(PC),A4                    ; $2283E4
        DC.W    $223D               ; $2283E8 MOVE.L  <EA:3D>,D1
        DC.W    $DFBF               ; $2283EA ADD.L  D7,<EA:3F>
        BCLR    D0,-(A1)                        ; $2283EC
        MOVE.L  (A1)+,(A0)                      ; $2283EE
        ADD.L  D7,-$4A(A7,D0.W)                 ; $2283F0
        MOVE.L  -(A1),(A0)                      ; $2283F4
        DC.W    $DFBF               ; $2283F6 ADD.L  D7,<EA:3F>
        DC.W    $01BE               ; $2283F8 BCLR    D0,<EA:3E>
        MOVE.L  (A1)+,(A0)                      ; $2283FA
        ADDA.L  $01A2(PC),A4                    ; $2283FC
        MOVEA.L -$2606(A5),A0                   ; $228400
        DC.W    $01BE               ; $228404 BCLR    D0,<EA:3E>
        MOVEA.L -$25FE(A5),A0                   ; $228406
        BCLR    D0,$64(A6,D2.W)                 ; $22840A
        ADD.L  -$4A(PC,D0.W),D3                 ; $22840E
        MOVEA.L -(A4),A0                        ; $228412
        ADD.L  -$42(A3,D0.W),D3                 ; $228414
        MOVEA.L -$2633(A4),A0                   ; $228418
        DC.W    $02D4               ; $22841C DC.W    $02D4
        MOVE.L  $D9AA.W,-$6C(PC,D0.W)           ; $22841E
        MOVE.L  -(A7),-$10(A3,A5.L)             ; $228424
        BCLR    D0,(A4)                         ; $228428
        MOVEA.L A1,A4                           ; $22842A
        ADDA.L  $02D5(A7),A7                    ; $22842C
        MOVE.L  (A0),D3                         ; $228430
        ADDA.L  A0,A7                           ; $228432
        BCLR    D0,-(A6)                        ; $228434
        MOVEA.L -(A6),A3                        ; $228436
        ROXR.B  #8,D7                           ; $228438
        BCLR    D0,-(A6)                        ; $22843A
        DC.W    $25B9,$D9CD,$02FD,$23FB; $22843C MOVE.L  $D9CD02FD,-$05(A2,D2.W)
        ADD.L  D4,$01BD(A2)                     ; $228444
        MOVE.L  -$2610(A2),-$43(A1,D0.W)        ; $228448
        MOVEA.L A4,A2                           ; $22844E
        ADDA.L  $02FA(A7),A7                    ; $228450
        MOVEA.L D4,A1                           ; $228454
        ADDA.L  A3,A7                           ; $228456
        DC.W    $01C8               ; $228458 BSET    D0,A0
        MOVE.L  (A4)+,(A1)                      ; $22845A
        ROXR.B  #8,D4                           ; $22845C
        DC.W    $01C8               ; $22845E BSET    D0,A0
        MOVE.L  -$2464(A4),$0170.W              ; $228460
        MOVE.L  D4,D3                           ; $228466
        ADD.L  D5,(A4)+                         ; $228468
        DC.W    $0188               ; $22846A BCLR    D0,A0
        MOVE.L  -(A6),D2                        ; $22846C
        ADD.L  D5,-(A5)                         ; $22846E
        DC.W    $0188               ; $228470 BCLR    D0,A0
        MOVE.L  -(A6),D2                        ; $228472
        ADD.L  D5,-(A5)                         ; $228474
        BCHG    D0,$04(A0,D2.W)                 ; $228476
        ADD.W  D1,D7                            ; $22847A
        BCHG    D0,$04(A0,D2.W)                 ; $22847C
        ADD.W  D1,D7                            ; $228480
        DC.W    $0188               ; $228482 BCLR    D0,A0
        MOVE.L  -(A6),D2                        ; $228484
        ADD.W  A3,D7                            ; $228486
        DC.W    $0188               ; $228488 BCLR    D0,A0
        MOVE.L  -(A6),D2                        ; $22848A
        ADD.W  A3,D7                            ; $22848C
        BCHG    D0,$04(A0,D2.W)                 ; $22848E
        ADD.L  D5,(A4)+                         ; $228492
        BCLR    D0,(A0)                         ; $228494
        MOVEA.L D4,A1                           ; $228496
        ADD.L  D5,(A4)+                         ; $228498
        BCLR    D0,(A0)+                        ; $22849A
        MOVE.L  -(A3),(A0)                      ; $22849C
        ADD.L  D5,-(A5)                         ; $22849E
        BCLR    D0,(A0)+                        ; $2284A0
        MOVE.L  -(A3),(A0)                      ; $2284A2
        ADD.L  D5,-(A5)                         ; $2284A4
        BCLR    D0,(A0)                         ; $2284A6
        MOVEA.L D4,A1                           ; $2284A8
        ADD.W  A3,D7                            ; $2284AA
        BCLR    D0,(A0)+                        ; $2284AC
        MOVE.L  -(A2),(A0)                      ; $2284AE
        ADD.W  A3,D7                            ; $2284B0
        BCLR    D0,(A0)                         ; $2284B2
        MOVEA.L D4,A1                           ; $2284B4
        ADD.W  D1,D7                            ; $2284B6
        BCLR    D0,(A0)                         ; $2284B8
        MOVEA.L D4,A1                           ; $2284BA
        ADD.W  D1,D7                            ; $2284BC
        BCLR    D0,(A0)+                        ; $2284BE
        MOVE.L  -(A2),(A0)                      ; $2284C0
        ADDA.L  $02C8(A7),A7                    ; $2284C2
        MOVE.L  -(A2),-$36(PC,A5.L)             ; $2284C6
        BCLR    D0,(A2)                         ; $2284CA
        MOVE.L  $E0150192,D4                    ; $2284CC
        MOVE.L  A2,-$33(A3,A5.L)                ; $2284D2
        DC.W    $02EF               ; $2284D6 DC.W    $02EF
        MOVE.L  -$56(A4,A5.L),$01AF(PC)         ; $2284D8
        MOVE.L  -(A3),-$10(A2,A5.L)             ; $2284DE
        BCLR    D0,$2645(A7)                    ; $2284E2
        ADDA.L  $0319(A7),A7                    ; $2284E6
        MOVE.L  -$2031(A2),D2                   ; $2284EA
        DC.W    $01BE               ; $2284EE BCLR    D0,<EA:3E>
        MOVE.L  D3,(A2)                         ; $2284F0
        ROXR.B  #8,D0                           ; $2284F2
        DC.W    $01BE               ; $2284F4 BCLR    D0,<EA:3E>
        MOVE.L  (A0),$D9F101D5                  ; $2284F6
        MOVEA.L $59(PC,A5.L),A0                 ; $2284FC
        BSET    D0,(A5)                         ; $228500
        MOVE.L  -(A0),-(A0)                     ; $228502
        ADD.L  D4,-(A5)                         ; $228504
        BTST    D1,(A5)                         ; $228506
        MOVE.L  A5,(A0)+                        ; $228508
        ADDA.L  $032C(A7),A7                    ; $22850A
        MOVE.L  A1,(A0)                         ; $22850E
        ADDA.L  A3,A7                           ; $228510
        DC.W    $01CA               ; $228512 BSET    D0,A2
        MOVE.L  -(A1),(A0)+                     ; $228514
        ROXR.B  #8,D4                           ; $228516
        DC.W    $01CA               ; $228518 BSET    D0,A2
        MOVE.L  $16(A1,D0.W),D0                 ; $22851A
        OR.B   D0,D2                            ; $22851E
        BCHG    D0,D0                           ; $228520
        BCHG    D0,(A0)                         ; $228522
        BCHG    D0,-(A0)                        ; $228524
        BCHG    D0,$16(A0,D0.W)                 ; $228526
        CMP.B  D0,D2                            ; $22852A
        BTST    D0,$20(A0,D0.W)                 ; $22852C
        SUBI.B  #$B100,(A0)+                    ; $228530
        ORI.L  #$00900408,-(A0)                 ; $228534
        MOVE.B  D0,D1                           ; $22853A
        DC.W    $00B0,$0080,$0408,$0B00; $22853C ORI.L  #$00800408,$00(A0,D0.L)
        DC.W    $00C0               ; $228544 DC.W    $00C0
        DC.W    $00F0               ; $228546 DC.W    $00F0
        SUBI.B  #$1200,A0                       ; $228548
        DC.W    $00D0               ; $22854C DC.W    $00D0
        DC.W    $00E0               ; $22854E DC.W    $00E0
        SUBI.B  #$B000,(A4)                     ; $228550
        BTST    D0,D0                           ; $228554
        BTST    D0,(A0)                         ; $228556
        ADDI.B  #$B000,(A0)+                    ; $228558
        DC.W    $0230,$02C0,$0608   ; $22855C ANDI.B  #$02C0,$08(A0,D0.W)
        MOVE.B  D0,-(A1)                        ; $228562
        DC.W    $00C0               ; $228564 DC.W    $00C0
        DC.W    $0220,$0408         ; $228566 ANDI.B  #$0408,-(A0)
        CMPI.B  #$00B0,D0                       ; $22856A
        DC.W    $0210,$0408         ; $22856E ANDI.B  #$0408,(A0)
        MOVE.B  D0,-(A1)                        ; $228572
        ORI.L  #$02000418,-(A0)                 ; $228574
        CMP.B  D0,D0                            ; $22857A
        BTST    D0,-$30(A0,D0.W)                ; $22857C
        SUBI.B  #$B300,(A6)                     ; $228580
        BCHG    D0,-(A0)                        ; $228584
        DC.W    $02E0               ; $228586 DC.W    $02E0
        DC.W    $0216,$B200         ; $228588 ANDI.B  #$B200,(A6)
        DC.W    $04E0               ; $22858C DC.W    $04E0
        BCLR    D1,$18(A0,D0.W)                 ; $22858E
        EOR.B  D0,D0                            ; $228592
        BCHG    D1,-(A0)                        ; $228594
        DC.W    $0200,$0408         ; $228596 ANDI.B  #$0408,D0
        MOVE.B  D0,D2                           ; $22859A
        BCHG    D1,$10(A0,D0.W)                 ; $22859C
        SUBI.B  #$0D00,A0                       ; $2285A0
        BCLR    D1,D0                           ; $2285A4
        DC.W    $0220,$0408         ; $2285A6 ANDI.B  #$0408,-(A0)
        MOVE.B  D0,D2                           ; $2285AA
        BCLR    D1,(A0)                         ; $2285AC
        DC.W    $0230,$0414,$B000   ; $2285AE ANDI.B  #$0414,$00(A0,A3.W)
        BCLR    D1,-(A0)                        ; $2285B4
        DC.W    $02C0               ; $2285B6 DC.W    $02C0
        ADDI.B  #$B000,(A0)+                    ; $2285B8
        SUBI.W  #$0550,(A0)                     ; $2285BC
        ADDI.B  #$1300,A0                       ; $2285C0
        BCLR    D1,D0                           ; $2285C4
        SUBI.W  #$0408,D0                       ; $2285C6
        CMPI.B  #$0370,D0                       ; $2285CA
        SUBI.B  #$0408,$00(A0,D1.W)             ; $2285CE
        BCHG    D1,-(A0)                        ; $2285D4
        SUBI.B  #$0208,-(A0)                    ; $2285D6
        MOVE.B  D0,D2                           ; $2285DA
        BTST    D2,-(A0)                        ; $2285DC
        BTST    D2,(A0)                         ; $2285DE
        SUBI.B  #$1500,A0                       ; $2285E0
        BTST    D2,$40(A0,D0.W)                 ; $2285E4
        ADDI.B  #$B100,(A0)+                    ; $2285E8
        BCHG    D2,-(A0)                        ; $2285EC
        BCHG    D2,$19(A0,D0.W)                 ; $2285EE
        CMP.B  D1,D0                            ; $2285F2
        SUBI.B  #$0218,-(A0)                    ; $2285F4
        CMP.B  D0,D0                            ; $2285F8
        BCHG    D1,-(A0)                        ; $2285FA
        BCLR    D1,$16(A0,D0.W)                 ; $2285FC
        EOR.B  D1,D0                            ; $228600
        DC.W    $04E0               ; $228602 DC.W    $04E0
        BCLR    D2,D0                           ; $228604
        DC.W    $0216,$B400         ; $228606 ANDI.B  #$B400,(A6)
        BCLR    D2,-(A0)                        ; $22860A
        BCHG    D2,$04(A0,D0.W)                 ; $22860C
        MOVE.B  D0,-(A5)                        ; $228610
        DC.W    $0000,$0010         ; $228612 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $228616 ORI.B  #$0030,-(A0)
        ADDI.B  #$1B00,D4                       ; $22861A
        BSET    D0,D0                           ; $22861E
        BSET    D0,(A0)                         ; $228620
        SUBI.B  #$1B00,D4                       ; $228622
        BTST    D1,-(A0)                        ; $228626
        BTST    D1,$04(A0,D0.W)                 ; $228628
        MOVE.B  D0,-(A5)                        ; $22862C
        BSET    D1,-(A0)                        ; $22862E
        BSET    D1,$04(A0,D0.W)                 ; $228630
        MOVE.B  D0,-(A5)                        ; $228634
        DC.W    $04F0               ; $228636 DC.W    $04F0
        BTST    D2,D0                           ; $228638
        DC.W    $0004,$1B00         ; $22863A ORI.B  #$1B00,D4
        ORI.W  #$0050,D0                        ; $22863E
        ORI.W  #$0070,-(A0)                     ; $228642
        ADDI.B  #$1B00,D4                       ; $228646
        BSET    D0,-(A0)                        ; $22864A
        BSET    D0,$04(A0,D0.W)                 ; $22864C
        MOVE.B  D0,-(A5)                        ; $228650
        BCHG    D1,D0                           ; $228652
        BCHG    D1,(A0)                         ; $228654
        SUBI.B  #$1B00,D4                       ; $228656
        SUBI.B  #$0410,D0                       ; $22865A
        DC.W    $0000,$2000         ; $22865E ORI.B  #$2000,D0
        BCLR    D0,D0                           ; $228662
        BTST    D0,(A0)                         ; $228664
        BCLR    D0,(A0)                         ; $228666
        BCLR    D0,-(A0)                        ; $228668
        SUBI.B  #$2000,D0                       ; $22866A
        BSET    D1,D0                           ; $22866E
        BSET    D1,(A0)                         ; $228670
        SUBI.B  #$2000,D0                       ; $228672
        BSET    D2,$00(A0,D0.W)                 ; $228676
        DC.W    $0000,$2000         ; $22867A ORI.B  #$2000,D0
        BCLR    D2,$00(A0,D0.W)                 ; $22867E
        BTST    D1,(A0)                         ; $228682
        BSET    D2,D0                           ; $228684
        DC.W    $0200,$2000         ; $228686 ANDI.B  #$2000,D0
        ADDI.B  #$0630,-(A0)                    ; $22868A
        SUBI.B  #$2000,D0                       ; $22868E
        ADDI.W  #$0640,(A0)                     ; $228692
        DC.W    $0017,$B301         ; $228696 ORI.B  #$B301,(A7)
        BTST    D0,(A0)                         ; $22869A
        BTST    D0,D0                           ; $22869C
        BCLR    D0,$04(A0,D0.W)                 ; $22869E
        MOVE.B  D0,-(A5)                        ; $2286A2
        ANDI.W  #$0250,D0                       ; $2286A4
        ANDI.W  #$0270,-(A0)                    ; $2286A8
        DC.W    $0004,$1B00         ; $2286AC ORI.B  #$1B00,D4
        ANDI.L  #$029002A0,D0                   ; $2286B0
        DC.W    $02B0,$0000,$2000,$02F0; $2286B6 ANDI.L  #$00002000,-$10(A0,D0.W)
        BTST    D0,$00(A0,D0.W)                 ; $2286BE
        BTST    D1,(A0)                         ; $2286C2
        DC.W    $0004,$1B00         ; $2286C4 ORI.B  #$1B00,D4
        SUBI.W  #$0470,-(A0)                    ; $2286C8
        SUBI.L  #$04900004,D0                   ; $2286CC
        MOVE.B  D0,-(A5)                        ; $2286D2
        SUBI.L  #$04B004C0,-(A0)                ; $2286D4
        DC.W    $04D0               ; $2286DA DC.W    $04D0
        DC.W    $0000,$2000         ; $2286DC ORI.B  #$2000,D0
        BCLR    D2,(A0)                         ; $2286E0
        DC.W    $02C0               ; $2286E2 DC.W    $02C0
        BSET    D1,D0                           ; $2286E4
        BSET    D1,(A0)                         ; $2286E6
        DC.W    $0000,$2000         ; $2286E8 ORI.B  #$2000,D0
        BSET    D2,(A0)                         ; $2286EC
        BCLR    D1,-$50(A0,D0.W)                ; $2286EE
        BSET    D2,D0                           ; $2286F2
        DC.W    $0000,$2000         ; $2286F4 ORI.B  #$2000,D0
        BSET    D2,-(A0)                        ; $2286F8
        BCHG    D2,(A0)                         ; $2286FA
        BSET    D2,$00(A0,D0.W)                 ; $2286FC
        DC.W    $0000,$2000         ; $228700 ORI.B  #$2000,D0
        BCHG    D2,-(A0)                        ; $228704
        ADDI.B  #$0620,(A0)                     ; $228706
        ADDI.B  #$0003,$01(A0,A0.W)             ; $22870A
        ADDI.W  #$0670,-(A0)                    ; $228710
        ADDI.L  #$00038101,D0                   ; $228714
        ADDI.L  #$06A006B0,(A0)                 ; $22871A
        DC.W    $0003,$8101         ; $228720 ORI.B  #$8101,D3
        DC.W    $06C0               ; $228724 DC.W    $06C0
        DC.W    $06D0               ; $228726 DC.W    $06D0
        DC.W    $06E0               ; $228728 DC.W    $06E0
        DC.W    $0003,$8101         ; $22872A ORI.B  #$8101,D3
        DC.W    $06F0               ; $22872E DC.W    $06F0
        BTST    D3,D0                           ; $228730
        BTST    D3,(A0)                         ; $228732
        ORI.W  #$1B00,D4                        ; $228734
        BTST    D3,-(A0)                        ; $228738
        BTST    D3,$40(A0,D0.W)                 ; $22873A
        BCHG    D3,(A0)                         ; $22873E
        ORI.W  #$1B00,D4                        ; $228740
        BCHG    D3,-(A0)                        ; $228744
        BCHG    D3,-$80(A0,D0.W)                ; $228746
        BCLR    D3,(A0)                         ; $22874A
        ORI.W  #$1B00,D4                        ; $22874C
        BCLR    D3,-(A0)                        ; $228750
        BCLR    D3,-$40(A0,D0.W)                ; $228752
        BSET    D3,(A0)                         ; $228756
        ORI.W  #$1B00,D4                        ; $228758
        BSET    D3,-(A0)                        ; $22875C
        BSET    D3,$00(A0,D0.L)                 ; $22875E
        BTST    #3,(A0)                         ; $228762
        OR.B   D1,D1                            ; $228766
        BTST    #16,-(A0)                       ; $228768
        BCHG    #3,D0                           ; $22876C
        OR.B   D1,D1                            ; $228770
        BCHG    #0,(A0)                         ; $228772
        BCHG    #3,$01(A0,A0.W)                 ; $228776
        BCLR    #16,D0                          ; $22877C
        BCLR    #3,-(A0)                        ; $228780
        OR.B   D1,D1                            ; $228784
        BCLR    #0,-$30(A0,D0.L)                ; $228786
        ORI.W  #$8201,D3                        ; $22878C
        BSET    #16,-(A0)                       ; $228790
        BTST    D4,D0                           ; $228794
        CMPI.B  #$0032,D0                       ; $228796
        DC.W    $0032,$E082,$017B   ; $22879A ORI.B  #$E082,$7B(A2,D0.W)
        MOVE.L  (A3),-$1F7F(PC)                 ; $2287A0
        BCHG    D0,(A0)+                        ; $2287A4
        MOVE.L  -$2049(PC),(A4)                 ; $2287A6
        BCHG    D0,(A1)                         ; $2287AA
        MOVE.L  A4,-$2049(A4)                   ; $2287AC
        BCHG    D0,-(A1)                        ; $2287B0
        MOVE.L  -(A5),$12(PC,A6.W)              ; $2287B2
        BCHG    D0,-$75(A2,D2.W)                ; $2287B6
        ROXL.B  #8,D2                           ; $2287BA
        BCHG    D0,(A4)+                        ; $2287BC
        MOVEA.L (A1),A4                         ; $2287BE
        ADD.L  D7,$79(A7,D0.W)                  ; $2287C0
        MOVE.L  D5,D3                           ; $2287C4
        ADD.L  D7,-$6F(A7,D0.W)                 ; $2287C6
        MOVE.L  -(A5),D2                        ; $2287CA
        ASR.L  #8,D2                            ; $2287CC
        DC.W    $0188               ; $2287CE BCLR    D0,A0
        MOVE.L  A5,(A2)+                        ; $2287D0
        ADD.L  D7,-$67(A7,D0.W)                 ; $2287D2
        MOVEA.L D5,A1                           ; $2287D6
        ASR.L  #8,D2                            ; $2287D8
        BCLR    D0,(A4)+                        ; $2287DA
        MOVE.L  -(A1),$12(A0,A6.W)              ; $2287DC
        BCLR    D0,(A1)+                        ; $2287E0
        MOVEA.L A7,A1                           ; $2287E2
        ROXL.B  #8,D2                           ; $2287E4
        BCLR    D0,(A1)                         ; $2287E6
        MOVE.L  (A5),D2                         ; $2287E8
        ADD.L  D7,-$5F(A7,D0.W)                 ; $2287EA
        MOVE.L  -(A1),(A0)                      ; $2287EE
        ASR.L  #8,D2                            ; $2287F0
        BCLR    D0,-(A1)                        ; $2287F2
        MOVE.L  -$1EEE(A3),(A0)                 ; $2287F4
        DC.W    $034B               ; $2287F8 BCHG    D1,A3
        MOVE.L  A3,(A3)                         ; $2287FA
        ROXL.B  #8,D2                           ; $2287FC
        DC.W    $034B               ; $2287FE BCHG    D1,A3
        MOVEA.L (A1),A4                         ; $228800
        ASR.L  #8,D1                            ; $228802
        DC.W    $034B               ; $228804 BCHG    D1,A3
        MOVE.L  (A3),-$1F7F(PC)                 ; $228806
        DC.W    $034B               ; $22880A BCHG    D1,A3
        MOVE.L  A5,(A2)+                        ; $22880C
        ROXL.B  #8,D2                           ; $22880E
        DC.W    $034B               ; $228810 BCHG    D1,A3
        MOVE.L  (A4),D2                         ; $228812
        ROXL.B  #8,D2                           ; $228814
        BCLR    D0,(A2)+                        ; $228816
        MOVEA.L A7,A1                           ; $228818
        ROXL.B  #8,D2                           ; $22881A
        DC.W    $034B               ; $22881C BCHG    D1,A3
        MOVEA.L A7,A1                           ; $22881E
        LSR.W  $019A.W                          ; $228820
        MOVEA.L A7,A1                           ; $228824
        LSR.W  $034B.W                          ; $228826
        MOVEA.L A7,A1                           ; $22882A
        LSR.W  $034B.W                          ; $22882C
        MOVE.L  A3,(A3)                         ; $228830
        LSR.W  $034B.W                          ; $228832
        MOVEA.L (A1),A4                         ; $228836
        LSR.W  $034B.W                          ; $228838
        MOVE.L  (A4),D2                         ; $22883C
        ROXL.B  #8,D2                           ; $22883E
        BSET    D1,-$75(A5,D2.W)                ; $228840
        LSR.W  $03F5.W                          ; $228844
        MOVE.L  A3,(A3)                         ; $228848
        ASR.L  #8,D1                            ; $22884A
        BSET    D1,-$2D(A5,D2.W)                ; $22884C
        ASR.L  #8,D1                            ; $228850
        BSET    D1,-$33(A5,D2.W)                ; $228852
        ROXL.B  #8,D2                           ; $228856
        BSET    D1,$14(A5,D2.W)                 ; $228858
        LSR.W  $03F5.W                          ; $22885C
        MOVE.L  (A4),D2                         ; $228860
        ASL.L  #8,D0                            ; $228862
        BSET    D2,(A5)                         ; $228864
        MOVE.L  -(A2),$4B(A0,A6.W)              ; $228866
        BSET    D2,(A5)                         ; $22886A
        MOVE.L  -(A2),$4B(A0,A6.W)              ; $22886C
        BCLR    D0,D0                           ; $228870
        MOVE.L  -(A2),-$80(A0,A6.W)             ; $228872
        BCLR    D0,D0                           ; $228876
        MOVE.L  -(A2),-$7E(A0,A6.W)             ; $228878
        DC.W    $06B4,$21A2,$E082,$05D5; $22887C ADDI.L  #$21A2E082,-$2B(A4,D0.W)
        MOVE.L  -$1EDF(A3),(A0)                 ; $228884
        BSET    D1,$66(A5,D2.W)                 ; $228888
        LSR.W  (A1)                             ; $22888C
        BSET    D1,$66(A5,D2.W)                 ; $22888E
        ASR.L  D0,D7                            ; $228892
        BSET    D1,-$3D(A5,D2.W)                ; $228894
        ASR.L  D0,D7                            ; $228898
        BSET    D1,-$23(A5,D2.W)                ; $22889A
        ASL.B  D0,D1                            ; $22889E
        BSET    D1,$3A(A5,D2.W)                 ; $2288A0
        LSR.W  (A1)                             ; $2288A4
        BSET    D1,$3A(A5,D2.W)                 ; $2288A6
        ROL.L  D0,D5                            ; $2288AA
        BCLR    D2,(A4)+                        ; $2288AC
        MOVE.L  (A0),-$1E80(A2)                 ; $2288AE
        BSET    D2,(A5)                         ; $2288B2
        MOVE.L  -$1E80(A3),(A0)                 ; $2288B4
        DC.W    $06B4,$20AB,$E082,$06B4; $2288B8 ADDI.L  #$20ABE082,-$4C(A4,D0.W)
        MOVE.L  -$1E80(A3),(A0)                 ; $2288C0
        DC.W    $06B4,$21A2,$0016,$BB00; $2288C4 ADDI.L  #$21A20016,$00(A4,A3.L)
        DC.W    $0210,$0220         ; $2288CC ANDI.B  #$0220,(A0)
        DC.W    $0230,$0240,$0214   ; $2288D0 ANDI.B  #$0240,$14(A0,D0.W)
        CMP.B  D0,D7                            ; $2288D6
        ORI.L  #$02500414,-(A0)                 ; $2288D8
        EOR.B  D7,D0                            ; $2288DE
        DC.W    $00E0               ; $2288E0 DC.W    $00E0
        ANDI.W  #$0616,-(A0)                    ; $2288E2
        CMP.B  D0,D2                            ; $2288E6
        ORI.L  #$00D00616,(A0)                  ; $2288E8
        EOR.B  D1,D0                            ; $2288EE
        ORI.L  #$00700416,D0                    ; $2288F0
        CMP.B  D0,D2                            ; $2288F6
        DC.W    $0000,$0060         ; $2288F8 ORI.B  #$0060,D0
        ADDI.B  #$0600,(A6)                     ; $2288FC
        BTST    D0,-(A0)                        ; $228900
        BTST    D0,(A0)                         ; $228902
        DC.W    $0216,$1900         ; $228904 ANDI.B  #$1900,(A6)
        DC.W    $00F0               ; $228908 DC.W    $00F0
        ORI.W  #$0216,D0                        ; $22890A
        OR.B   D0,D2                            ; $22890E
        ORI.W  #$0010,(A0)                      ; $228910
        ADDI.B  #$B800,(A6)                     ; $228914
        DC.W    $00F0               ; $228918 DC.W    $00F0
        BTST    D0,D0                           ; $22891A
        SUBI.B  #$B900,(A6)                     ; $22891C
        BCLR    D0,D0                           ; $228920
        BCLR    D0,(A0)                         ; $228922
        ADDI.B  #$C300,(A6)                     ; $228924
        BCLR    D0,-$40(A0,D0.W)                ; $228928
        ADDI.B  #$C200,(A4)                     ; $22892C
        BTST    D0,(A0)                         ; $228930
        BSET    D0,(A0)                         ; $228932
        SUBI.B  #$C300,(A6)                     ; $228934
        BTST    D0,-(A0)                        ; $228938
        BSET    D0,-(A0)                        ; $22893A
        SUBI.B  #$C400,(A4)                     ; $22893C
        BTST    D0,-$10(A0,D0.W)                ; $228940
        ADDI.B  #$1900,(A6)                     ; $228944
        ORI.L  #$00C00216,D0                    ; $228948
        CMP.B  D0,D4                            ; $22894E
        BCHG    D0,D0                           ; $228950
        BCHG    D0,(A0)                         ; $228952
        SUBI.B  #$B700,(A6)                     ; $228954
        BCHG    D0,-(A0)                        ; $228958
        BCHG    D0,$16(A0,D0.W)                 ; $22895A
        EOR.B  D4,D0                            ; $22895E
        BCLR    D0,-(A0)                        ; $228960
        BTST    D0,$16(A0,D0.W)                 ; $228962
        AND.B  D1,D0                            ; $228966
        DC.W    $0200,$01F0         ; $228968 ANDI.B  #$01F0,D0
        SUBI.B  #$C400,(A4)                     ; $22896C
        DC.W    $02C0               ; $228970 DC.W    $02C0
        DC.W    $02B0,$0214,$C400,$02A0; $228972 ANDI.L  #$0214C400,-$60(A0,D0.W)
        BSET    D0,-(A0)                        ; $22897A
        SUBI.B  #$C400,(A4)                     ; $22897C
        ANDI.L  #$01D00414,(A0)                 ; $228980
        AND.B  D0,D2                            ; $228986
        ANDI.W  #$01B0,$14(A0,D0.W)             ; $228988
        AND.B  D0,D2                            ; $22898E
        ANDI.L  #$01C00617,D0                   ; $228990
        MOVE.B  D1,-(A4)                        ; $228996
        DC.W    $02D0               ; $228998 DC.W    $02D0
        ADDI.B  #$1701,(A7)                     ; $22899A
        ANDI.L  #$02171901,(A0)                 ; $22899E
        ANDI.L  #$02171B01,-(A0)                ; $2289A4
        DC.W    $02B0,$0217,$1901,$02C0; $2289AA ANDI.L  #$02171901,-$40(A0,D0.W)
        DC.W    $0217,$1701         ; $2289B2 ANDI.B  #$1701,(A7)
        ANDI.L  #$0016BE00,D0                   ; $2289B6
        ANDI.W  #$02E0,-(A0)                    ; $2289BC
        DC.W    $02F0               ; $2289C0 DC.W    $02F0
        BTST    D1,D0                           ; $2289C2
        DC.W    $0215,$BF01         ; $2289C4 ANDI.B  #$BF01,(A5)
        ANDI.W  #$0016,(A0)                     ; $2289C8
        CMP.B  D0,D2                            ; $2289CC
        DC.W    $0000,$0010         ; $2289CE ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2289D2 ORI.B  #$0030,-(A0)
        DC.W    $0016,$8400         ; $2289D6 ORI.B  #$8400,(A6)
        ORI.L  #$00B000C0,-(A0)                 ; $2289DA
        ORI.L  #$0015BE01,D0                    ; $2289E0
        ANDI.W  #$0310,(A0)                     ; $2289E6
        DC.W    $0210,$0C00         ; $2289EA ANDI.B  #$0C00,(A0)
        DC.W    $0004,$0004         ; $2289EE ORI.B  #$0004,D4
        ROXL.W  $0161(PC)                       ; $2289F2
        MOVE.L  A3,-(A3)                        ; $2289F6
        ROL.L  #4,D5                            ; $2289F8
        BCHG    D0,-(A1)                        ; $2289FA
        MOVE.L  $25(A2,A6.L),$02A1(PC)          ; $2289FC
        MOVE.L  -$18FF(A7),-$5F(PC,D0.W)        ; $228A02
        MOVE.L  -(A1),(A4)                      ; $228A08
        DC.W    $0016,$0E00         ; $228A0A ORI.B  #$0E00,(A6)
        DC.W    $0000,$0010         ; $228A0E ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $228A12 ORI.B  #$0030,-(A0)
        CMPI.B  #$0025,D0                       ; $228A16
        DC.W    $0019,$0860         ; $228A1A ORI.B  #$0860,(A1)+
        DC.W    $00F1               ; $228A1E DC.W    $00F1
        MOVE.L  -$60(A3,D0.W),-$06(A2,D0.W)     ; $228A20
        MOVE.L  A6,-$69(A3,D0.W)                ; $228A26
        DC.W    $00FA               ; $228A2A DC.W    $00FA
        MOVE.L  A3,$58(A3,D0.L)                 ; $228A2C
        DC.W    $00F1               ; $228A30 DC.W    $00F1
        MOVE.L  $0755(A6),-$03(A2,D0.W)         ; $228A32
        MOVE.L  $18(A4,D0.L),$00F4(A3)          ; $228A38
        MOVE.L  A2,$2D(A2,D0.L)                 ; $228A3E
        DC.W    $00F1               ; $228A42 DC.W    $00F1
        MOVE.L  (A0)+,$6D(A2,D0.W)              ; $228A44
        DC.W    $00FA               ; $228A48 DC.W    $00FA
        DC.W    $277C,$063A,$0104,$240F; $228A4A MOVE.L  #$063A0104,$240F(A3)
        BTST    D3,$00F8(A0)                    ; $228A52
        MOVE.L  -(A7),$0911.W                   ; $228A56
        DC.W    $00F8               ; $228A5A DC.W    $00F8
        MOVE.L  $0802.W,$04(A1,D0.W)            ; $228A5C
        DC.W    $257F,$074D         ; $228A62 MOVE.L  <EA:3F>,$074D(A2)
        DC.W    $010D               ; $228A66 BTST    D0,A5
        MOVE.L  $10(A2,D0.L),$0104(A3)          ; $228A68
        MOVE.L  D7,$3E(A2,D0.W)                 ; $228A6E
        DC.W    $010D               ; $228A72 BTST    D0,A5
        MOVE.L  $0582(A4),$010D(A3)             ; $228A74
        MOVE.L  $045E(A6),(A3)                  ; $228A7A
        BTST    D0,$225B(A2)                    ; $228A7E
        BCLR    D2,$37(A7,D0.W)                 ; $228A82
        DC.W    $1FFE               ; $228A86 MOVE.B  <EA:3E>,<EA:3F>
        BSET    D1,(A0)+                        ; $228A88
        DC.W    $013D               ; $228A8A BTST    D0,<EA:3D>
        MOVE.L  (A3)+,-$7A(A2,D0.W)             ; $228A8C
        BCHG    D0,(A0)                         ; $228A90
        MOVE.L  (A6)+,D4                        ; $228A92
        BCHG    D2,$2A(A5,D0.W)                 ; $228A94
        MOVE.L  (A5)+,(A4)+                     ; $228A98
        BSET    D0,(A5)                         ; $228A9A
        BCLR    D0,D1                           ; $228A9C
        MOVE.L  $00BE(A3),$0177(A2)             ; $228A9E
        MOVE.L  A3,D1                           ; $228AA4
        DC.W    $0031,$018A,$1E5F   ; $228AA6 ORI.B  #$018A,$5F(A1,D1.L)
        BSET    D0,$0190(PC)                    ; $228AAC
        MOVE.L  A6,$41(A3,D0.W)                 ; $228AB0
        BCLR    D0,D0                           ; $228AB4
        DC.W    $27BF,$0494         ; $228AB6 MOVE.L  <EA:3F>,-$6C(A3,D0.W)
        ANDI.W  #$278E,$04E7(A4)                ; $228ABA
        BCLR    D0,D0                           ; $228AC0
        MOVE.L  (A5)+,$0494(A3)                 ; $228AC2
        BTST    D0,$278E(A4)                    ; $228AC6
        BCHG    D1,D2                           ; $228ACA
        BCLR    D0,-(A4)                        ; $228ACC
        MOVEA.L (A7)+,A0                        ; $228ACE
        BCLR    D1,(A7)+                        ; $228AD0
        ANDI.L  #$204703FC,(A1)                 ; $228AD2
        BCLR    D0,-(A4)                        ; $228AD8
        MOVE.L  $039F(A7),D0                    ; $228ADA
        BCHG    D0,(A1)                         ; $228ADE
        MOVEA.L D7,A0                           ; $228AE0
        ANDI.W  #$01AD,A4                       ; $228AE2
        MOVE.L  $02A2(A7),-$66(A1,D0.W)         ; $228AE6
        MOVE.L  D3,-$09(A1,D0.W)                ; $228AEC
        BCLR    D0,$2357(A5)                    ; $228AF0
        ANDI.L  #$015A2383,-(A2)                ; $228AF4
        DC.W    $0014,$8400         ; $228AFA ORI.B  #$8400,(A4)
        BTST    D0,-(A0)                        ; $228AFE
        BTST    D0,D0                           ; $228B00
        ORI.L  #$00F00218,D0                    ; $228B02
        OR.B   D1,D0                            ; $228B08
        BCHG    D0,D0                           ; $228B0A
        BTST    D0,$14(A0,D0.W)                 ; $228B0C
        OR.B   D0,D2                            ; $228B10
        BCLR    D0,D0                           ; $228B12
        BCHG    D0,(A0)                         ; $228B14
        DC.W    $0218,$8500         ; $228B16 ANDI.B  #$8500,(A0)+
        BCHG    D0,-(A0)                        ; $228B1A
        BTST    D0,D0                           ; $228B1C
        SUBI.B  #$8400,(A4)                     ; $228B1E
        BCHG    D0,$10(A0,D0.W)                 ; $228B22
        DC.W    $0218,$8300         ; $228B26 ANDI.B  #$8300,(A0)+
        ORI.L  #$00800416,(A0)                  ; $228B2A
        OR.B   D0,D1                            ; $228B30
        ORI.L  #$00B00216,-(A0)                 ; $228B32
        OR.B   D1,D0                            ; $228B38
        DC.W    $00E0               ; $228B3A DC.W    $00E0
        DC.W    $00F0               ; $228B3C DC.W    $00F0
        ADDI.B  #$B300,(A0)+                    ; $228B3E
        DC.W    $00D0               ; $228B42 DC.W    $00D0
        DC.W    $00C0               ; $228B44 DC.W    $00C0
        SUBI.B  #$AE00,(A4)                     ; $228B46
        ORI.W  #$0040,(A0)                      ; $228B4A
        SUBI.B  #$1400,A0                       ; $228B4E
        ORI.W  #$0070,-(A0)                     ; $228B52
        DC.W    $0004,$1B00         ; $228B56 ORI.B  #$1B00,D4
        DC.W    $0000,$0010         ; $228B5A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $228B5E ORI.B  #$0030,-(A0)
        ORI.W  #$9800,D4                        ; $228B62
        BCLR    D0,(A0)                         ; $228B66
        BCLR    D0,-(A0)                        ; $228B68
        BCLR    D0,-$40(A0,D0.W)                ; $228B6A
        ORI.W  #$9800,D4                        ; $228B6E
        BSET    D0,(A0)                         ; $228B72
        BSET    D0,-(A0)                        ; $228B74
        BSET    D0,$00(A0,D0.W)                 ; $228B76
        ORI.W  #$9800,D4                        ; $228B7A
        DC.W    $0210,$0220         ; $228B7E ANDI.B  #$0220,(A0)
        DC.W    $0230,$0240,$0C00   ; $228B82 ANDI.B  #$0240,$00(A0,D0.L)
        ORI.W  #$0056,$51(A2,D1.W)              ; $228B88
        ORI.W  #$289D,A7                        ; $228B8E
        BSET    D6,$4F(A1,D0.W)                 ; $228B92
        MOVE.L  $4A(A2,D0.L),$4F(A1,D0.W)       ; $228B96
        DC.W    $22FF               ; $228B9C MOVE.L  <EA:3F>,(A1)+
        DC.W    $0CD3               ; $228B9E DC.W    $0CD3
        ORI.W  #$2494,A7                        ; $228BA0
        DC.W    $0BC8               ; $228BA4 BSET    D5,A0
        ORI.W  #$25BB,A7                        ; $228BA6
        DC.W    $0E17               ; $228BAA DC.W    $0E17
        ORI.W  #$2A8E,A7                        ; $228BAC
        DC.W    $0AE3               ; $228BB0 DC.W    $0AE3
        ORI.W  #$2713,A7                        ; $228BB2
        BCHG    D5,-(A6)                        ; $228BB6
        DC.W    $00F8               ; $228BB8 DC.W    $00F8
        MOVE.L  D0,-$79(A2,D0.L)                ; $228BBA
        DC.W    $00F7               ; $228BBE DC.W    $00F7
        MOVEA.L A1,A2                           ; $228BC0
        BCLR    D6,$00FA(A7)                    ; $228BC2
        MOVE.L  (A2)+,$0F1F(A1)                 ; $228BC6
        DC.W    $00FE               ; $228BCA DC.W    $00FE
        MOVE.L  -(A0),(A1)                      ; $228BCC
        EORI.L  #$010426D8,D1                   ; $228BCE
        MOVE.B  $0102(A7),(A0)                  ; $228BD4
        MOVE.L  -$3A(A1,D1.W),D1                ; $228BD8
        ORI.W  #$2293,A7                        ; $228BDC
        BSET    D4,(A7)                         ; $228BE0
        DC.W    $010D               ; $228BE2 BTST    D0,A5
        MOVEA.L (A3),A4                         ; $228BE4
        EORI.W  #$004F,D3                       ; $228BE6
        DC.W    $287D               ; $228BEA MOVEA.L <EA:3D>,A4
        EORI.L  #$00E42242,A2                   ; $228BEC
        CMPI.W  #$00E4,D5                       ; $228BF2
        MOVE.L  D2,D2                           ; $228BF6
        BTST    D5,(A3)+                        ; $228BF8
        DC.W    $00E4               ; $228BFA DC.W    $00E4
        DC.W    $253E               ; $228BFC MOVE.L  <EA:3E>,-(A2)
        BTST    D4,$00E4(PC)                    ; $228BFE
        MOVE.L  (A0)+,$0C2700E4                 ; $228C02
        MOVE.L  -(A4),$0AF500E4                 ; $228C08
        MOVE.L  -(A2),-(A2)                     ; $228C0E
        DC.W    $0AEE               ; $228C10 DC.W    $0AEE
        DC.W    $00E4               ; $228C12 DC.W    $00E4
        MOVE.L  (A4)+,-(A2)                     ; $228C14
        CMPI.B  #$00E4,-(A0)                    ; $228C16
        MOVE.L  (A5)+,$0AB100E4                 ; $228C1A
        MOVEA.L $0964(A1),A1                    ; $228C20
        DC.W    $00E4               ; $228C24 DC.W    $00E4
        DC.W    $23F7,$095D,$00E4,$23F1; $228C26 MOVE.L  $5D(A7,D0.L),$00E423F1
        DC.W    $0AAA,$00E4,$2262,$0B5C; $228C2E EORI.L  #$00E42262,$0B5C(A2)
        DC.W    $00E7               ; $228C36 DC.W    $00E7
        MOVE.L  $0C7F.W,$00E6(A2)               ; $228C38
        DC.W    $243F               ; $228C3E MOVE.L  <EA:3F>,D2
        BCHG    D6,-(A5)                        ; $228C40
        DC.W    $00E7               ; $228C42 DC.W    $00E7
        MOVE.L  (A4)+,(A1)+                     ; $228C44
        BCHG    D6,$00E7(A2)                    ; $228C46
        MOVE.L  -(A4),(A1)+                     ; $228C4A
        CMPI.B  #$00E7,-$26(A2,D2.W)            ; $228C4C
        BCLR    D6,D2                           ; $228C52
        DC.W    $00E7               ; $228C54 DC.W    $00E7
        MOVE.L  A5,-(A1)                        ; $228C56
        CMPI.W  #$00E7,A6                       ; $228C58
        MOVE.L  A2,-(A0)                        ; $228C5C
        CMPI.W  #$00E7,A2                       ; $228C5E
        MOVE.L  D2,-(A0)                        ; $228C62
        BTST    D4,-(A4)                        ; $228C64
        DC.W    $00E8               ; $228C66 DC.W    $00E8
        MOVE.L  D6,$0A7800E7                    ; $228C68
        MOVE.L  $0C25(A5),D1                    ; $228C6E
        DC.W    $00E7               ; $228C72 DC.W    $00E7
        MOVE.L  D4,(A0)+                        ; $228C74
        BCLR    D6,$00EA(A1)                    ; $228C76
        MOVE.L  A7,$0EED(A1)                    ; $228C7A
        DC.W    $00EA               ; $228C7E DC.W    $00EA
        MOVE.L  (A6),D1                         ; $228C80
        DC.W    $0EF0               ; $228C82 DC.W    $0EF0
        DC.W    $00EA               ; $228C84 DC.W    $00EA
        MOVE.L  (A7)+,D1                        ; $228C86
        DC.W    $0E22               ; $228C88 DC.W    $0E22
        DC.W    $00EA               ; $228C8A DC.W    $00EA
        MOVE.L  -(A2),D0                        ; $228C8C
        DC.W    $0E1F               ; $228C8E DC.W    $0E1F
        DC.W    $00EA               ; $228C90 DC.W    $00EA
        MOVE.L  (A1)+,D0                        ; $228C92
        DC.W    $0E0E               ; $228C94 DC.W    $0E0E
        DC.W    $00EA               ; $228C96 DC.W    $00EA
        DC.W    $1FEF,$0F04         ; $228C98 MOVE.B  $0F04(A7),<EA:3F>
        DC.W    $00EA               ; $228C9C DC.W    $00EA
        MOVEA.L A6,A1                           ; $228C9E
        DC.W    $0E05               ; $228CA0 DC.W    $0E05
        DC.W    $00EE               ; $228CA2 DC.W    $00EE
        DC.W    $1FD6               ; $228CA4 MOVE.B  (A6),<EA:3F>
        BTST    D7,(A2)+                        ; $228CA6
        DC.W    $00ED               ; $228CA8 DC.W    $00ED
        MOVE.L  (A4),(A1)                       ; $228CAA
        DC.W    $0A01,$00F1         ; $228CAC EORI.B  #$00F1,D1
        MOVE.L  (A0),(A3)                       ; $228CB0
        BSET    D4,$00F1268C                    ; $228CB2
        BCHG    #17,-(A0)                       ; $228CB8
        MOVE.L  $58(A3,D0.L),-$0F(A2,D0.W)      ; $228CBC
        MOVE.L  $0A24(A6),-$0F(A2,D0.W)         ; $228CC2
        MOVE.L  -(A3),(A3)                      ; $228CC8
        BTST    #17,$2598(A5)                   ; $228CCA
        EORI.W  #$00F3,-$2F(A6,D2.W)            ; $228CD0
        BTST    #20,(A0)+                       ; $228CD6
        MOVE.L  A2,-$71(A2,D1.W)                ; $228CDA
        DC.W    $00EF               ; $228CDE DC.W    $00EF
        MOVE.L  -(A2),-$6F(A0,D1.W)             ; $228CE0
        DC.W    $00EF               ; $228CE4 DC.W    $00EF
        MOVE.L  $1023(A3),-$11(A0,D0.W)         ; $228CE6
        MOVE.B  (A2)+,$109A(A7)                 ; $228CEC
        DC.W    $00EF               ; $228CF0 DC.W    $00EF
        MOVE.L  (A6)+,$10AC.W                   ; $228CF2
        DC.W    $00F1               ; $228CF6 DC.W    $00F1
        MOVE.L  -(A4),D1                        ; $228CF8
        DC.W    $0C7E,$00F7         ; $228CFA CMPI.W  #$00F7,<EA:3E>
        DC.W    $243F               ; $228CFE MOVE.L  <EA:3F>,D2
        BCHG    D5,(A4)+                        ; $228D00
        DC.W    $00F8               ; $228D02 DC.W    $00F8
        MOVE.L  $0A72.W,$00F7(A2)               ; $228D04
        MOVE.L  -(A7),D1                        ; $228D0A
        CMPI.B  #$00F7,-(A0)                    ; $228D0C
        DC.W    $20BD               ; $228D10 MOVE.L  <EA:3D>,(A0)
        BTST    D4,(A5)+                        ; $228D12
        DC.W    $00F8               ; $228D14 DC.W    $00F8
        MOVE.L  D2,$0DA900FA                    ; $228D16
        MOVE.L  A7,$0E02(A1)                    ; $228D1C
        DC.W    $00FE               ; $228D20 DC.W    $00FE
        DC.W    $1FCE               ; $228D22 MOVE.B  A6,<EA:3F>
        BTST    D7,(A2)+                        ; $228D24
        DC.W    $00FE               ; $228D26 DC.W    $00FE
        MOVE.L  (A4),(A1)                       ; $228D28
        BCHG    D4,D4                           ; $228D2A
        DC.W    $00FA               ; $228D2C DC.W    $00FA
        MOVE.L  (A2)+,D4                        ; $228D2E
        BTST    D4,-$06(PC,D0.W)                ; $228D30
        MOVE.L  (A7),D4                         ; $228D34
        BCHG    D4,$00FA(A5)                    ; $228D36
        MOVE.L  $076D(A0),D4                    ; $228D3A
        DC.W    $00FA               ; $228D3E DC.W    $00FA
        DC.W    $277C,$0A76,$0104,$26D1; $228D40 MOVE.L  #$0A760104,$26D1(A3)
        BTST    #4,(A0)                         ; $228D48
        MOVE.L  D7,-$35(A2,D0.L)                ; $228D4C
        DC.W    $00FC               ; $228D50 DC.W    $00FC
        MOVEA.L A6,A4                           ; $228D52
        EORI.W  #$00F7,-(A6)                    ; $228D54
        MOVE.L  (A4)+,D1                        ; $228D58
        CMPI.B  #$00F7,(A0)+                    ; $228D5A
        MOVE.L  $08B5(A7),(A0)                  ; $228D5E
        DC.W    $00F7               ; $228D62 DC.W    $00F7
        MOVE.B  (A0)+,-$72(A7,D0.L)             ; $228D64
        DC.W    $00F7               ; $228D68 DC.W    $00F7
        MOVEA.B A1,A7                           ; $228D6A
        BTST    D4,(A1)                         ; $228D6C
        DC.W    $00F8               ; $228D6E DC.W    $00F8
        MOVE.L  $0728.W,-$08(A1,D0.W)           ; $228D70
        MOVE.L  -(A7),$10AC.W                   ; $228D76
        BTST    D0,D2                           ; $228D7A
        MOVE.L  -(A4),D1                        ; $228D7C
        DC.W    $0DFD               ; $228D7E BSET    D6,<EA:3D>
        DC.W    $00FE               ; $228D80 DC.W    $00FE
        DC.W    $1FBF,$0802         ; $228D82 MOVE.B  <EA:3F>,$02(A7,D0.L)
        BTST    D0,D4                           ; $228D86
        DC.W    $257F,$09CB         ; $228D88 MOVE.L  <EA:3F>,$09CB(A2)
        DC.W    $010D               ; $228D8C BTST    D0,A5
        MOVEA.L A6,A4                           ; $228D8E
        DC.W    $0AFE               ; $228D90 DC.W    $0AFE
        DC.W    $00E4               ; $228D92 DC.W    $00E4
        MOVE.L  $0C23(A0),-(A2)                 ; $228D94
        DC.W    $00E4               ; $228D98 DC.W    $00E4
        MOVE.L  -(A0),$0C2900E4                 ; $228D9A
        MOVE.L  -(A6),$0B0600E4                 ; $228DA0
        MOVE.L  $0D11(A6),-(A2)                 ; $228DA6
        DC.W    $00E6               ; $228DAA DC.W    $00E6
        MOVE.L  (A5),-(A1)                      ; $228DAC
        DC.W    $0D0B               ; $228DAE BTST    D6,A3
        DC.W    $00E6               ; $228DB0 DC.W    $00E6
        MOVE.L  A5,-(A1)                        ; $228DB2
        CMPI.B  #$00E5,D4                       ; $228DB4
        MOVE.L  (A5)+,-(A1)                     ; $228DB8
        BTST    D6,D2                           ; $228DBA
        DC.W    $00E7               ; $228DBC DC.W    $00E7
        MOVE.L  $07(A7,D0.L),D1                 ; $228DBE
        DC.W    $00E7               ; $228DC2 DC.W    $00E7
        DC.W    $223F               ; $228DC4 MOVE.L  <EA:3F>,D1
        CMPI.B  #$00E5,A2                       ; $228DC6
        MOVE.L  -(A5),-(A1)                     ; $228DCA
        BTST    D6,-(A4)                        ; $228DCC
        DC.W    $00E7               ; $228DCE DC.W    $00E7
        MOVEA.L $0EAC(A7),A1                    ; $228DD0
        DC.W    $00EA               ; $228DD4 DC.W    $00EA
        MOVE.L  -$50(A7,D0.L),$00EA(A0)         ; $228DD6
        MOVE.L  D1,$29(A0,D0.L)                 ; $228DDC
        DC.W    $00E7               ; $228DE0 DC.W    $00E7
        MOVEA.L -$7E(A7,D0.L),A1                ; $228DE2
        DC.W    $00EA               ; $228DE6 DC.W    $00EA
        MOVE.L  A6,-(A0)                        ; $228DE8
        DC.W    $0E86               ; $228DEA DC.W    $0E86
        DC.W    $00EA               ; $228DEC DC.W    $00EA
        MOVE.L  (A0)+,-(A0)                     ; $228DEE
        DC.W    $0A04,$00F1         ; $228DF0 EORI.B  #$00F1,D4
        MOVE.L  (A2),(A3)                       ; $228DF4
        DC.W    $0A0D,$00F1         ; $228DF6 EORI.B  #$00F1,A5
        MOVE.L  (A6),(A3)                       ; $228DFA
        MOVE.B  A3,D0                           ; $228DFC
        DC.W    $00EE               ; $228DFE DC.W    $00EE
        MOVE.L  $1009(A1),D0                    ; $228E00
        DC.W    $00EE               ; $228E04 DC.W    $00EE
        MOVE.L  (A7)+,D0                        ; $228E06
        MOVEA.B (A7),A0                         ; $228E08
        DC.W    $00EF               ; $228E0A DC.W    $00EF
        MOVEA.L $59(A4,D1.W),A0                 ; $228E0C
        DC.W    $00EF               ; $228E10 DC.W    $00EF
        DC.W    $207E               ; $228E12 MOVEA.L <EA:3E>,A0
        BCHG    D7,(A6)+                        ; $228E14
        DC.W    $00EC               ; $228E16 DC.W    $00EC
        MOVE.L  (A5),$1069(A0)                  ; $228E18
        DC.W    $00EF               ; $228E1C DC.W    $00EF
        MOVE.L  (A3),(A0)+                      ; $228E1E
        MOVEA.B $00EF(A2),A0                    ; $228E20
        MOVE.L  (A5)+,(A0)+                     ; $228E24
        BCHG    D7,-(A1)                        ; $228E26
        DC.W    $00EC               ; $228E28 DC.W    $00EC
        MOVE.L  (A7)+,$0926(A0)                 ; $228E2A
        DC.W    $00FA               ; $228E2E DC.W    $00FA
        MOVE.L  (A0),D4                         ; $228E30
        BTST    D4,$00FA(A7)                    ; $228E32
        MOVE.L  (A3),D4                         ; $228E36
        DC.W    $0017,$9501         ; $228E38 ORI.B  #$9501,(A7)
        DC.W    $0000,$0010         ; $228E3C ORI.B  #$0010,D0
        DC.W    $0020,$0616         ; $228E40 ORI.B  #$0616,-(A0)
        MOVE.B  D0,D1                           ; $228E44
        ORI.L  #$00A00616,(A0)                  ; $228E46
        MOVE.B  D0,D1                           ; $228E4C
        DC.W    $0030,$0080,$0617   ; $228E4E ORI.B  #$0080,$17(A0,D0.W)
        SUB.B  D1,D3                            ; $228E54
        DC.W    $0000,$0216         ; $228E56 ORI.B  #$0216,D0
        SUB.B  D2,D0                            ; $228E5A
        ORI.W  #$0040,(A0)                      ; $228E5C
        SUBI.B  #$9401,(A7)                     ; $228E60
        ORI.W  #$0216,-(A0)                     ; $228E64
        MOVE.B  D0,D1                           ; $228E68
        DC.W    $00B0,$0070,$0216,$1200; $228E6A ORI.L  #$00700216,$00(A0,D1.W)
        ORI.L  #$00300614,D0                    ; $228E72
        EOR.B  D1,D0                            ; $228E78
        BSET    D1,-(A0)                        ; $228E7A
        BSET    D1,(A0)                         ; $228E7C
        SUBI.B  #$B100,(A0)+                    ; $228E7E
        BSET    D0,D0                           ; $228E82
        BSET    D0,(A0)                         ; $228E84
        SUBI.B  #$1400,A0                       ; $228E86
        BTST    D0,-(A0)                        ; $228E8A
        BTST    D0,(A0)                         ; $228E8C
        SUBI.B  #$0E00,A0                       ; $228E8E
        BTST    D0,$00(A0,D0.W)                 ; $228E92
        DC.W    $0208,$0D00         ; $228E96 ANDI.B  #$0D00,A0
        DC.W    $0200,$0210         ; $228E9A ANDI.B  #$0210,D0
        ADDI.B  #$1300,A0                       ; $228E9E
        ANDI.W  #$0260,(A0)                     ; $228EA2
        ADDI.B  #$1400,A0                       ; $228EA6
        BTST    D0,$40(A0,D0.W)                 ; $228EAA
        SUBI.B  #$1500,A0                       ; $228EAE
        BCHG    D1,(A0)                         ; $228EB2
        BCHG    D1,$14(A0,D0.W)                 ; $228EB4
        MOVE.L  D0,-(A6)                        ; $228EB8
        SUBI.L  #$04100214,-(A0)                ; $228EBA
        MOVE.L  D0,D7                           ; $228EC0
        BSET    D1,$50(A0,D0.W)                 ; $228EC2
        SUBI.B  #$AD00,(A4)                     ; $228EC6
        SUBI.B  #$0260,D0                       ; $228ECA
        SUBI.B  #$AE00,(A4)                     ; $228ECE
        SUBI.B  #$02E0,$08(A0,D0.W)             ; $228ED2
        MOVE.B  D0,D2                           ; $228ED8
        DC.W    $02C0               ; $228EDA DC.W    $02C0
        DC.W    $0200,$0408         ; $228EDC ANDI.B  #$0408,D0
        DC.W    $0E00               ; $228EE0 DC.W    $0E00
        DC.W    $02D0               ; $228EE2 DC.W    $02D0
        DC.W    $0210,$0408         ; $228EE4 ANDI.B  #$0408,(A0)
        MOVE.B  D0,D2                           ; $228EE8
        DC.W    $02F0               ; $228EEA DC.W    $02F0
        ANDI.W  #$0208,$00(A0,D1.W)             ; $228EEC
        BSET    D0,(A0)                         ; $228EF2
        BTST    D0,(A0)                         ; $228EF4
        ADDI.B  #$B000,(A0)+                    ; $228EF6
        SUBI.B  #$03D0,-(A0)                    ; $228EFA
        ADDI.B  #$B100,(A0)+                    ; $228EFE
        DC.W    $02F0               ; $228F02 DC.W    $02F0
        SUBI.W  #$0214,D0                       ; $228F04
        EOR.B  D1,D0                            ; $228F08
        ORI.L  #$00900614,-(A0)                 ; $228F0A
        CMP.B  D0,D2                            ; $228F10
        BTST    D2,-(A0)                        ; $228F12
        DC.W    $00C0               ; $228F14 DC.W    $00C0
        ADDI.B  #$B000,(A0)+                    ; $228F16
        DC.W    $02F0               ; $228F1A DC.W    $02F0
        BSET    D1,D0                           ; $228F1C
        SUBI.B  #$1500,A0                       ; $228F1E
        DC.W    $02D0               ; $228F22 DC.W    $02D0
        BCLR    D1,$08(A0,D0.W)                 ; $228F24
        BTST    D7,D0                           ; $228F28
        DC.W    $02C0               ; $228F2A DC.W    $02C0
        BCLR    D1,-(A0)                        ; $228F2C
        DC.W    $0008,$1500         ; $228F2E ORI.B  #$1500,A0
        BCHG    D1,-(A0)                        ; $228F32
        BCHG    D1,D0                           ; $228F34
        BTST    D0,-(A0)                        ; $228F36
        BSET    D0,D0                           ; $228F38
        ADDI.B  #$0F00,A0                       ; $228F3A
        BCHG    D1,(A0)                         ; $228F3E
        BTST    D0,$08(A0,D0.W)                 ; $228F40
        DC.W    $0E00               ; $228F44 DC.W    $0E00
        SUBI.W  #$0480,$08(A0,D0.W)             ; $228F46
        MOVE.B  D0,D2                           ; $228F4C
        BCHG    D1,-(A0)                        ; $228F4E
        DC.W    $04B0,$0418,$B100,$0490; $228F50 SUBI.L  #$0418B100,-$70(A0,D0.W)
        BCHG    D2,(A0)                         ; $228F58
        ADDI.B  #$B000,(A0)+                    ; $228F5A
        BSET    D0,D0                           ; $228F5E
        BSET    D1,-(A0)                        ; $228F60
        DC.W    $0214,$B400         ; $228F62 ANDI.B  #$B400,(A4)
        ORI.W  #$00B0,$14(A0,D0.W)              ; $228F66
        EOR.B  D1,D0                            ; $228F6C
        DC.W    $00E0               ; $228F6E DC.W    $00E0
        BCHG    D2,(A0)                         ; $228F70
        ADDI.B  #$1200,(A6)                     ; $228F72
        ORI.W  #$00F0,-(A0)                     ; $228F76
        DC.W    $0004,$1B00         ; $228F7A ORI.B  #$1B00,D4
        ANDI.L  #$03800390,D0                   ; $228F7E
        ANDI.L  #$02041B00,(A0)                 ; $228F84
        BSET    D0,-$20(A0,D0.W)                ; $228F8A
        SUBI.B  #$1B00,D4                       ; $228F8E
        BCHG    D0,D0                           ; $228F92
        BCHG    D0,$04(A0,D0.W)                 ; $228F94
        MOVE.B  D0,-(A5)                        ; $228F98
        BCHG    D0,(A0)                         ; $228F9A
        BCHG    D0,-(A0)                        ; $228F9C
        SUBI.B  #$1B00,D4                       ; $228F9E
        BTST    D1,D0                           ; $228FA2
        BTST    D1,(A0)                         ; $228FA4
        SUBI.B  #$1B00,D4                       ; $228FA6
        SUBI.W  #$0460,(A0)                     ; $228FAA
        DC.W    $0018,$B300         ; $228FAE ORI.B  #$B300,(A0)+
        DC.W    $04D0               ; $228FB2 DC.W    $04D0
        BTST    D2,$30(A0,D0.W)                 ; $228FB4
        SUBI.B  #$0218,D0                       ; $228FB8
        CMP.B  D0,D1                            ; $228FBC
        BSET    D1,-$40(A0,D0.W)                ; $228FBE
        DC.W    $0216,$8200         ; $228FC2 ANDI.B  #$8200,(A6)
        DC.W    $04E0               ; $228FC6 DC.W    $04E0
        DC.W    $04F0               ; $228FC8 DC.W    $04F0
        ADDI.B  #$8300,(A6)                     ; $228FCA
        BTST    D2,D0                           ; $228FCE
        BTST    D2,(A0)                         ; $228FD0
        ADDI.B  #$B300,(A0)+                    ; $228FD2
        BSET    D1,$10(A0,D0.W)                 ; $228FD6
        DC.W    $0218,$B200         ; $228FDA ANDI.B  #$B200,(A0)+
        SUBI.L  #$05400004,-(A0)                ; $228FDE
        MOVE.B  D0,-(A5)                        ; $228FE4
        ANDI.L  #$02200230,-(A0)                ; $228FE6
        DC.W    $02B0,$0604,$1B00,$0180; $228FEC ANDI.L  #$06041B00,-$80(A0,D0.W)
        BCLR    D0,$04(A0,D0.W)                 ; $228FF4
        MOVE.B  D0,-(A5)                        ; $228FF8
        BCLR    D0,(A0)                         ; $228FFA
        BCLR    D0,-(A0)                        ; $228FFC
        SUBI.B  #$1B00,D4                       ; $228FFE
        BTST    D1,-(A0)                        ; $229002
        BTST    D1,$16(A0,D0.W)                 ; $229004
        MOVE.B  D0,D1                           ; $229008
        ORI.L  #$00C000D0,-(A0)                 ; $22900A
        DC.W    $0020,$0014         ; $229010 ORI.B  #$0014,-(A0)
        CMP.B  D0,D1                            ; $229014
        BSET    D1,(A0)                         ; $229016
        SUBI.B  #$0090,-(A0)                    ; $229018
        ORI.L  #$00440900,D0                    ; $22901C
        BCLR    D2,-(A0)                        ; $229022
        BCLR    D2,D0                           ; $229024
        BCHG    D2,-$50(A0,D0.W)                ; $229026
        ADDI.W  #$0A00,D4                       ; $22902A
        BCLR    D2,(A0)                         ; $22902E
        BCHG    D2,-(A0)                        ; $229030
        SUBI.W  #$0B00,D4                       ; $229032
        ADDI.W  #$0660,$44(A0,D0.W)             ; $229036
        DC.W    $0A00,$0710         ; $22903C EORI.B  #$0710,D0
        BTST    D3,D0                           ; $229040
        ORI.W  #$0800,D4                        ; $229042
        BSET    D2,D0                           ; $229046
        BSET    D2,(A0)                         ; $229048
        BSET    D2,-(A0)                        ; $22904A
        BSET    D2,$44(A0,D0.W)                 ; $22904C
        BTST    D4,D0                           ; $229050
        ADDI.W  #$0650,D0                       ; $229052
        SUBI.W  #$0A00,D4                       ; $229056
        ADDI.L  #$06800044,(A0)                 ; $22905A
        DC.W    $0A00,$0600         ; $229060 EORI.B  #$0600,D0
        ADDI.B  #$0620,(A0)                     ; $229064
        ADDI.B  #$0644,$00(A0,D0.L)             ; $229068
        ADDI.L  #$06B00044,-(A0)                ; $22906E
        BTST    D4,D0                           ; $229074
        DC.W    $06C0               ; $229076 DC.W    $06C0
        DC.W    $06D0               ; $229078 DC.W    $06D0
        DC.W    $06E0               ; $22907A DC.W    $06E0
        DC.W    $06F0               ; $22907C DC.W    $06F0
        CMPI.B  #$0050,D0                       ; $22907E
        ORI.W  #$1235,D4                        ; $229082
        ORI.W  #$226B,A7                        ; $229086
        MOVE.B  -(A1),$004F2294                 ; $22908A
        MOVE.B  -(A2),$004F(A2)                 ; $229090
        DC.W    $27BC,$12DB,$004F,$27C0; $229094 MOVE.L  #$12DB004F,-$40(A3,D2.W)
        DC.W    $0F4A               ; $22909C BCHG    D7,A2
        ORI.W  #$22FF,A7                        ; $22909E
        MOVE.B  D6,(A0)+                        ; $2290A2
        ORI.W  #$2293,A7                        ; $2290A4
        MOVEA.B (A1),A0                         ; $2290A8
        ORI.W  #$289D,A7                        ; $2290AA
        MOVE.B  $0102(A7),(A0)                  ; $2290AE
        MOVE.L  $35(A1,D1.W),D1                 ; $2290B2
        BTST    D0,D6                           ; $2290B6
        MOVE.L  A4,D1                           ; $2290B8
        DC.W    $13EB,$0109,$222B,$108F; $2290BA MOVE.B  $0109(A3),$222B108F
        DC.W    $00EF               ; $2290C2 DC.W    $00EF
        MOVE.L  -(A2),$30(A0,D1.W)              ; $2290C4
        DC.W    $00F3               ; $2290C8 DC.W    $00F3
        DC.W    $2179,$1230,$00F3,$2182; $2290CA MOVE.L  $123000F3,$2182(A0)
        MOVE.B  (A1),(A0)                       ; $2290D2
        DC.W    $00EF               ; $2290D4 DC.W    $00EF
        MOVE.L  $1023(A3),-$11(A0,D0.W)         ; $2290D6
        MOVE.B  (A2)+,$121D(A7)                 ; $2290DC
        DC.W    $00F4               ; $2290E0 DC.W    $00F4
        MOVE.B  $32(A0,D1.W),-(A7)              ; $2290E2
        DC.W    $00F3               ; $2290E6 DC.W    $00F3
        DC.W    $21B9,$109A,$00EF,$21DE; $2290E8 MOVE.L  $109A00EF,-$22(A0,D2.W)
        MOVE.B  $00F1(A4),(A0)                  ; $2290F0
        MOVE.L  -(A4),D1                        ; $2290F4
        MOVE.B  -$0B(A5,D0.W),D1                ; $2290F6
        DC.W    $21FF,$13D1         ; $2290FA MOVE.L  <EA:3F>,$13D1.W
        DC.W    $00F6               ; $2290FE DC.W    $00F6
        MOVE.L  (A3)+,-$29(A0,D1.W)             ; $229100
        DC.W    $00F6               ; $229104 DC.W    $00F6
        MOVE.L  -(A5),-$08(A0,D1.W)             ; $229106
        DC.W    $00F6               ; $22910A DC.W    $00F6
        MOVE.L  (A6)+,$125F.W                   ; $22910C
        DC.W    $00F6               ; $229110 DC.W    $00F6
        MOVE.B  $13ED(A7),-(A7)                 ; $229112
        DC.W    $00F8               ; $229116 DC.W    $00F8
        MOVE.L  (A6)+,D1                        ; $229118
        MOVEA.B A2,A2                           ; $22911A
        DC.W    $00F7               ; $22911C DC.W    $00F7
        MOVE.L  $143D(A3),-$09(A0,D0.W)         ; $22911E
        MOVE.L  $35(A3,D1.W),$06(A0,D0.W)       ; $229124
        DC.W    $21FF,$10AC         ; $22912A MOVE.L  <EA:3F>,$10AC.W
        BTST    D0,D2                           ; $22912E
        MOVE.L  -(A4),D1                        ; $229130
        MOVE.B  (A3)+,(A3)+                     ; $229132
        DC.W    $00FD               ; $229134 DC.W    $00FD
        DC.W    $1FED,$16DE         ; $229136 MOVE.B  $16DE(A5),<EA:3F>
        DC.W    $00FD               ; $22913A DC.W    $00FD
        MOVE.L  (A2),D0                         ; $22913C
        MOVE.B  (A5),(A3)+                      ; $22913E
        DC.W    $00FD               ; $229140 DC.W    $00FD
        MOVE.L  (A7),D0                         ; $229142
        MOVE.B  (A2),(A3)+                      ; $229144
        DC.W    $00FD               ; $229146 DC.W    $00FD
        DC.W    $1FEA,$13ED         ; $229148 MOVE.B  $13ED(A2),<EA:3F>
        DC.W    $0109               ; $22914C BTST    D0,A1
        MOVE.L  (A6)+,D1                        ; $22914E
        MOVE.B  (A2),(A7)+                      ; $229150
        BCHG    D0,D4                           ; $229152
        MOVE.L  $16C8(A2),D2                    ; $229154
        BTST    D0,-(A0)                        ; $229158
        MOVE.L  -(A1),D0                        ; $22915A
        MOVE.B  A0,(A3)+                        ; $22915C
        BCHG    D0,D1                           ; $22915E
        MOVE.L  -(A1),D0                        ; $229160
        MOVEA.B $0141(A3),A3                    ; $229162
        MOVEA.L (A3)+,A0                        ; $229166
        MOVEA.B $0120(A3),A3                    ; $229168
        MOVEA.L (A3)+,A0                        ; $22916C
        MOVE.B  $02(A1,D0.W),-(A3)              ; $22916E
        DC.W    $1FE1               ; $229172 MOVE.B  -(A1),<EA:3F>
        MOVE.B  $5F(A1,D0.W),-(A3)              ; $229174
        DC.W    $1FE1               ; $229178 MOVE.B  -(A1),<EA:3F>
        MOVE.B  $5F(A3,D0.W),D3                 ; $22917A
        DC.W    $207F               ; $22917E MOVEA.L <EA:3F>,A0
        MOVE.B  $02(A3,D0.W),D3                 ; $229180
        DC.W    $207F               ; $229184 MOVEA.L <EA:3F>,A0
        MOVE.B  $0120(A7),-$31(A2,D2.W)         ; $229186
        MOVE.B  $0141(A7),-$31(A2,D2.W)         ; $22918C
        MOVE.B  (A2),$0141(A2)                  ; $229192
        MOVE.L  A1,-(A0)                        ; $229196
        MOVE.B  (A2),$0120(A2)                  ; $229198
        MOVE.L  A1,-(A0)                        ; $22919C
        MOVE.B  (A0)+,D3                        ; $22919E
        BTST    D0,D2                           ; $2291A0
        MOVE.L  A7,(A0)                         ; $2291A2
        MOVE.B  (A0)+,D3                        ; $2291A4
        BCHG    D0,(A7)+                        ; $2291A6
        MOVE.L  A7,(A0)                         ; $2291A8
        MOVE.B  (A2)+,-(A2)                     ; $2291AA
        BCHG    D0,(A7)+                        ; $2291AC
        MOVE.L  $151A(A4),-(A0)                 ; $2291AE
        BTST    D0,D2                           ; $2291B2
        MOVE.L  $1496(A4),-(A0)                 ; $2291B4
        BTST    D0,-(A0)                        ; $2291B8
        DC.W    $217D,$1496         ; $2291BA MOVE.L  <EA:3D>,$1496(A0)
        BCHG    D0,D1                           ; $2291BE
        DC.W    $217D,$1439         ; $2291C0 MOVE.L  <EA:3D>,$1439(A0)
        BCHG    D0,D1                           ; $2291C4
        MOVE.L  $39(A7,D1.W),$20(A0,D0.W)       ; $2291C6
        MOVE.L  -$01(A7,D1.W),$02(A0,D0.W)      ; $2291CC
        DC.W    $213D               ; $2291D2 MOVE.L  <EA:3D>,-(A0)
        DC.W    $14FF               ; $2291D4 MOVE.B  <EA:3F>,(A2)+
        BCHG    D0,(A7)+                        ; $2291D6
        DC.W    $213D               ; $2291D8 MOVE.L  <EA:3D>,-(A0)
        MOVE.B  D0,D2                           ; $2291DA
        BCHG    D0,(A7)+                        ; $2291DC
        MOVE.L  (A3)+,$1400.W                   ; $2291DE
        BTST    D0,D2                           ; $2291E2
        MOVE.L  (A3)+,$170E.W                   ; $2291E4
        BTST    D0,-$0A(A1,D1.L)                ; $2291E8
        MOVE.B  A0,(A3)+                        ; $2291EC
        BCHG    D0,(A7)                         ; $2291EE
        MOVE.L  -(A1),D0                        ; $2291F0
        MOVE.B  A0,(A3)+                        ; $2291F2
        DC.W    $010A               ; $2291F4 BTST    D0,A2
        MOVE.L  -(A1),D0                        ; $2291F6
        MOVE.B  $31(A5,D0.W),$20A4(PC)          ; $2291F8
        MOVE.B  $0157(A7),-$31(A2,D2.W)         ; $2291FE
        MOVE.B  $010A(A7),-$31(A2,D2.W)         ; $229204
        MOVE.B  (A3)+,(A2)+                     ; $22920A
        BTST    D0,$52(A1,D2.W)                 ; $22920C
        MOVE.B  (A5),(A2)                       ; $229210
        BCHG    D0,(A7)                         ; $229212
        DC.W    $217D,$1495         ; $229214 MOVE.L  <EA:3D>,$1495(A0)
        DC.W    $010A               ; $229218 BTST    D0,A2
        DC.W    $217D,$1069         ; $22921A MOVE.L  <EA:3D>,$1069(A0)
        DC.W    $00EF               ; $22921E DC.W    $00EF
        MOVE.L  (A3),(A0)+                      ; $229220
        MOVE.B  -(A3),D1                        ; $229222
        DC.W    $00F4               ; $229224 DC.W    $00F4
        DC.W    $1FFB,$1224         ; $229226 MOVE.B  $24(PC,D1.W),<EA:3F>
        DC.W    $00F4               ; $22922A DC.W    $00F4
        MOVE.L  D6,D0                           ; $22922C
        MOVEA.B $00EF(A2),A0                    ; $22922E
        MOVE.L  (A5)+,(A0)+                     ; $229232
        MOVE.B  #$0111,D3                       ; $229234
        MOVEA.L $163C(PC),A0                    ; $229238
        BTST    D0,(A1)+                        ; $22923C
        MOVEA.L $14F7(PC),A0                    ; $22923E
        BTST    D0,(A1)+                        ; $229242
        MOVE.L  D4,$14F7(A0)                    ; $229244
        BTST    D0,(A1)                         ; $229248
        MOVE.L  D4,$163C(A0)                    ; $22924A
        DC.W    $014B               ; $22924E BCHG    D0,A3
        MOVEA.L $163C(PC),A0                    ; $229250
        BCHG    D0,(A2)                         ; $229254
        MOVEA.L $14F7(PC),A0                    ; $229256
        BCHG    D0,(A2)                         ; $22925A
        MOVE.L  D4,$14F7(A0)                    ; $22925C
        DC.W    $014B               ; $229260 BCHG    D0,A3
        MOVE.L  D4,$0017(A0)                    ; $229262
        SUB.B  D1,D2                            ; $229266
        DC.W    $0030,$0060,$0040   ; $229268 ORI.B  #$0060,$40(A0,D0.W)
        DC.W    $0217,$9501         ; $22926E ANDI.B  #$9501,(A7)
        ORI.W  #$0217,(A0)                      ; $229272
        SUB.B  D1,D3                            ; $229276
        DC.W    $0000,$0216         ; $229278 ORI.B  #$0216,D0
        SUB.B  D2,D0                            ; $22927C
        DC.W    $0010,$0020         ; $22927E ORI.B  #$0020,(A0)
        ADDI.B  #$1200,(A6)                     ; $229282
        ORI.L  #$00900616,D0                    ; $229286
        MOVE.B  D0,D1                           ; $22928C
        ORI.W  #$0070,(A0)                      ; $22928E
        DC.W    $0214,$B300         ; $229292 ANDI.B  #$B300,(A4)
        BSET    D0,D0                           ; $229296
        BCLR    D0,$18(A0,D0.W)                 ; $229298
        EOR.B  D0,D0                            ; $22929C
        BTST    D0,-(A0)                        ; $22929E
        BTST    D0,$08(A0,D0.W)                 ; $2292A0
        MOVE.B  D0,D2                           ; $2292A4
        BTST    D0,(A0)                         ; $2292A6
        BTST    D0,D0                           ; $2292A8
        SUBI.B  #$0E00,A0                       ; $2292AA
        DC.W    $00E0               ; $2292AE DC.W    $00E0
        DC.W    $00F0               ; $2292B0 DC.W    $00F0
        DC.W    $0208,$0D00         ; $2292B2 ANDI.B  #$0D00,A0
        BCHG    D0,$60(A0,D0.W)                 ; $2292B6
        DC.W    $0208,$1300         ; $2292BA ANDI.B  #$1300,A0
        BCLR    D0,D0                           ; $2292BE
        BTST    D0,$18(A0,D0.W)                 ; $2292C0
        CMP.B  D0,D0                            ; $2292C4
        DC.W    $0210,$01B0         ; $2292C6 ANDI.B  #$01B0,(A0)
        SUBI.B  #$B200,(A4)                     ; $2292CA
        ORI.L  #$00800004,(A0)                  ; $2292CE
        MOVE.B  D0,-(A5)                        ; $2292D4
        ORI.L  #$00B000C0,-(A0)                 ; $2292D6
        DC.W    $00D0               ; $2292DC DC.W    $00D0
        ADDI.B  #$1B00,D4                       ; $2292DE
        BCHG    D0,D0                           ; $2292E2
        BCHG    D0,(A0)                         ; $2292E4
        SUBI.B  #$1B00,D4                       ; $2292E6
        BCLR    D0,(A0)                         ; $2292EA
        BCLR    D0,-(A0)                        ; $2292EC
        DC.W    $0004,$1B00         ; $2292EE ORI.B  #$1B00,D4
        BSET    D0,(A0)                         ; $2292F2
        BSET    D0,-(A0)                        ; $2292F4
        BSET    D0,$00(A0,D0.W)                 ; $2292F6
        DC.W    $0019,$B101         ; $2292FA ORI.B  #$B101,(A1)+
        DC.W    $0220,$0210         ; $2292FE ANDI.B  #$0210,-(A0)
        BCLR    D0,D0                           ; $229302
        DC.W    $0012,$6D00         ; $229304 ORI.B  #$6D00,(A2)
        DC.W    $0230,$0240,$0250   ; $229308 ANDI.B  #$0240,$50(A0,D0.W)
        ANDI.W  #$0004,-(A0)                    ; $22930E
        MOVE.B  D0,D7                           ; $229312
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $229314
        ANDI.L  #$00126D00,-(A0)                ; $22931A
        DC.W    $02B0,$02C0,$02D0,$02E0; $229320 ANDI.L  #$02C002D0,-$20(A0,D0.W)
        DC.W    $0004,$1E00         ; $229328 ORI.B  #$1E00,D4
        DC.W    $02F0               ; $22932C DC.W    $02F0
        BTST    D1,D0                           ; $22932E
        BTST    D1,(A0)                         ; $229330
        BTST    D1,-(A0)                        ; $229332
        DC.W    $0012,$6D00         ; $229334 ORI.B  #$6D00,(A2)
        BTST    D1,$40(A0,D0.W)                 ; $229338
        BCHG    D1,(A0)                         ; $22933C
        BCHG    D1,-(A0)                        ; $22933E
        DC.W    $0004,$1E00         ; $229340 ORI.B  #$1E00,D4
        BCHG    D1,-$80(A0,D0.W)                ; $229344
        BCLR    D1,(A0)                         ; $229348
        BCLR    D1,-(A0)                        ; $22934A
        DC.W    $0013,$6D01         ; $22934C ORI.B  #$6D01,(A3)
        BCLR    D1,-$40(A0,D0.W)                ; $229350
        BSET    D1,(A0)                         ; $229354
        DC.W    $0013,$6D01         ; $229356 ORI.B  #$6D01,(A3)
        BSET    D1,-(A0)                        ; $22935A
        BSET    D1,$00(A0,D0.W)                 ; $22935C
        DC.W    $0013,$6D01         ; $229360 ORI.B  #$6D01,(A3)
        SUBI.B  #$0420,(A0)                     ; $229364
        SUBI.B  #$0044,$00(A0,D0.L)             ; $229368
        SUBI.W  #$0450,D0                       ; $22936E
        SUBI.W  #$0470,-(A0)                    ; $229372
        ORI.W  #$0300,A0                        ; $229376
        SUBI.L  #$049004A0,D0                   ; $22937A
        DC.W    $04B0,$0048,$0300,$04C0; $229380 SUBI.L  #$00480300,-$40(A0,D0.W)
        DC.W    $04D0               ; $229388 DC.W    $04D0
        DC.W    $04E0               ; $22938A DC.W    $04E0
        DC.W    $04F0               ; $22938C DC.W    $04F0
        CMPI.B  #$001B,D0                       ; $22938E
        DC.W    $001B,$13E1         ; $229392 ORI.B  #$13E1,(A3)+
        ORI.W  #$2294,A7                        ; $229396
        MOVE.B  (A5)+,(A7)+                     ; $22939A
        ORI.W  #$249F,A7                        ; $22939C
        MOVE.B  $004F.W,$4F(A7,D2.W)            ; $2293A0
        MOVE.B  -(A2),$004F(A2)                 ; $2293A6
        DC.W    $27BC,$13EB,$0109,$222B; $2293AA MOVE.L  #$13EB0109,$2B(A3,D2.W)
        MOVE.B  (A3),(A7)+                      ; $2293B2
        BCHG    D0,D4                           ; $2293B4
        MOVE.L  -$7E(A6,D1.W),D2                ; $2293B6
        BTST    D0,D4                           ; $2293BA
        DC.W    $1FEE,$1E8D         ; $2293BC MOVE.B  $1E8D(A6),<EA:3F>
        BTST    D0,$56(A1,D2.W)                 ; $2293C0
        MOVE.B  D3,-(A3)                        ; $2293C4
        DC.W    $00FD               ; $2293C6 DC.W    $00FD
        DC.W    $1FFB,$144A         ; $2293C8 MOVE.B  $4A(PC,D1.W),<EA:3F>
        DC.W    $00F7               ; $2293CC DC.W    $00F7
        MOVE.L  $1EC2(A3),$31(A0,D0.W)          ; $2293CE
        MOVE.L  (A7)+,-$3D(A1,D1.L)             ; $2293D4
        BTST    D0,-$57(A1,D2.W)                ; $2293D8
        DC.W    $143D               ; $2293DC MOVE.B  <EA:3D>,D2
        DC.W    $00F7               ; $2293DE DC.W    $00F7
        MOVE.L  -$38(A3,D1.L),$31(A0,D0.W)      ; $2293E0
        MOVE.L  -(A2),$13F800F6                 ; $2293E6
        MOVE.L  (A6)+,$16DE.W                   ; $2293EC
        DC.W    $00FD               ; $2293F0 DC.W    $00FD
        MOVE.L  (A2),D0                         ; $2293F2
        MOVE.B  (A1),(A7)                       ; $2293F4
        BTST    D0,-$7B(A1,D2.W)                ; $2293F6
        MOVE.B  (A2),(A7)                       ; $2293FA
        BTST    D0,-$70(A1,D2.W)                ; $2293FC
        MOVE.B  (A5),(A3)+                      ; $229400
        DC.W    $00FD               ; $229402 DC.W    $00FD
        MOVE.L  (A7),D0                         ; $229404
        DC.W    $13ED,$00F8,$221E,$1ED2; $229406 MOVE.B  $00F8(A5),$221E1ED2
        BCHG    D0,D4                           ; $22940E
        MOVE.L  $1931(A2),D2                    ; $229410
        BTST    D0,-(A0)                        ; $229414
        MOVE.L  A7,D0                           ; $229416
        DC.W    $13ED,$0109,$221E,$19A5; $229418 MOVE.B  $0109(A5),$221E19A5
        ANDI.W  #$1F88,A0                       ; $229420
        MOVE.B  A0,(A7)+                        ; $229424
        ANDI.W  #$20BC,A0                       ; $229426
        MOVE.B  D1,$02FB(A5)                    ; $22942A
        MOVE.B  $1EF6(A4),$02D2(A7)             ; $22942E
        MOVEA.L (A2),A0                         ; $229434
        DC.W    $0010,$1400         ; $229436 ORI.B  #$1400,(A0)
        BTST    D0,-$20(A0,D0.W)                ; $22943A
        DC.W    $00D0               ; $22943E DC.W    $00D0
        BCHG    D0,D0                           ; $229440
        ADDI.B  #$0D00,A0                       ; $229442
        ORI.L  #$00700411,D0                    ; $229446
        MOVE.B  D1,D2                           ; $22944C
        ORI.W  #$0219,-(A0)                     ; $22944E
        CMP.B  D1,D2                            ; $229452
        BCHG    D0,(A0)                         ; $229454
        DC.W    $0211,$A001         ; $229456 ANDI.B  #$A001,(A1)
        BCHG    D0,$11(A0,D0.W)                 ; $22945A
        MOVE.L  D1,D1                           ; $22945E
        BCLR    D0,D0                           ; $229460
        ADDI.B  #$A000,(A0)                     ; $229462
        BCLR    D0,(A0)                         ; $229466
        BCLR    D0,-(A0)                        ; $229468
        DC.W    $0014,$B300         ; $22946A ORI.B  #$B300,(A4)
        BCHG    D0,-(A0)                        ; $22946E
        BCHG    D0,D0                           ; $229470
        ORI.W  #$0040,(A0)                      ; $229472
        SUBI.B  #$1200,(A6)                     ; $229476
        DC.W    $0010,$0000         ; $22947A ORI.B  #$0000,(A0)
        SUBI.B  #$9400,(A6)                     ; $22947E
        DC.W    $0020,$0030         ; $229482 ORI.B  #$0030,-(A0)
        DC.W    $0004,$1B00         ; $229486 ORI.B  #$1B00,D4
        ORI.L  #$00A000B0,(A0)                  ; $22948A
        DC.W    $00C0               ; $229490 DC.W    $00C0
        DC.W    $0004,$1B00         ; $229492 ORI.B  #$1B00,D4
        DC.W    $00F0               ; $229496 DC.W    $00F0
        BTST    D0,D0                           ; $229498
        BTST    D0,(A0)                         ; $22949A
        BTST    D0,-(A0)                        ; $22949C
        CMPI.B  #$0012,D0                       ; $22949E
        DC.W    $0012,$1EDD         ; $2294A2 ORI.B  #$1EDD,(A2)
        ORI.W  #$249F,A7                        ; $2294A6
        DC.W    $293F               ; $2294AA MOVE.L  <EA:3F>,-(A4)
        ORI.W  #$1E72,A7                        ; $2294AC
        MOVE.L  (A1)+,(A5)                      ; $2294B0
        ORI.W  #$204B,A7                        ; $2294B2
        MOVE.B  $004F.W,$4F(A7,D2.W)            ; $2294B6
        DC.W    $1FE1               ; $2294BC MOVE.B  -(A1),<EA:3F>
        DC.W    $00B3,$29E9,$2AE7,$00B3; $2294BE ORI.L  #$29E92AE7,-$4D(A3,D0.W)
        MOVE.L  #$1ED30144,(A1)+                ; $2294C6
        MOVE.L  $14(A6,D2.L),D2                 ; $2294CC
        BCHG    D0,D4                           ; $2294D0
        MOVE.B  A5,D7                           ; $2294D2
        MOVE.L  -(A3),D0                        ; $2294D4
        BCHG    D0,(A4)+                        ; $2294D6
        DC.W    $2BC4               ; $2294D8 MOVE.L  D4,<EA:3D>
        MOVE.L  A2,D5                           ; $2294DA
        BCHG    D0,-$5B(A2,D2.W)                ; $2294DC
        MOVE.B  D2,(A7)+                        ; $2294E0
        BTST    D0,-$61(A1,D2.W)                ; $2294E2
        MOVE.L  $01311DA7,(A4)                  ; $2294E6
        MOVE.L  D0,(A4)+                        ; $2294EC
        BTST    D0,-$51(A1,D1.L)                ; $2294EE
        MOVE.B  D3,(A7)+                        ; $2294F2
        BTST    D0,-$57(A1,D2.W)                ; $2294F4
        MOVE.B  A0,(A7)+                        ; $2294F8
        BTST    D0,-$1E(A1,D2.W)                ; $2294FA
        MOVE.L  (A2)+,(A4)+                     ; $2294FE
        BTST    D0,-$32(A1,D1.L)                ; $229500
        MOVE.L  A4,-(A4)                        ; $229504
        BCHG    D0,D4                           ; $229506
        MOVE.B  D3,D7                           ; $229508
        MOVE.B  (A2),(A7)+                      ; $22950A
        BCHG    D0,D4                           ; $22950C
        MOVE.L  $0016(A2),D2                    ; $22950E
        MOVE.L  D0,D0                           ; $229512
        ORI.L  #$00400050,D0                    ; $229514
        ORI.L  #$06168300,(A0)                  ; $22951A
        DC.W    $0030,$0020,$0416   ; $229520 ORI.B  #$0020,$16(A0,D0.W)
        SUB.B  D2,D0                            ; $229526
        DC.W    $0000,$0010         ; $229528 ORI.B  #$0010,D0
        SUBI.B  #$1200,(A6)                     ; $22952C
        ORI.W  #$0070,-(A0)                     ; $229530
        SUBI.B  #$B400,(A4)                     ; $229534
        BTST    D0,(A0)                         ; $229538
        BTST    D0,D0                           ; $22953A
        SUBI.B  #$1400,(A0)                     ; $22953C
        DC.W    $00E0               ; $229540 DC.W    $00E0
        DC.W    $00F0               ; $229542 DC.W    $00F0
        DC.W    $0004,$1B00         ; $229544 ORI.B  #$1B00,D4
        ORI.L  #$00B000C0,-(A0)                 ; $229548
        DC.W    $00D0               ; $22954E DC.W    $00D0
        CMPI.B  #$002E,D0                       ; $229550
        DC.W    $000A,$CFCD         ; $229554 ORI.B  #$CFCD,A2
        BCHG    D1,(A0)                         ; $229558
        MOVE.B  (A0),-$33(A7,A4.L)              ; $22955A
        BCLR    D0,-(A1)                        ; $22955E
        MOVE.B  (A2),-$57(A7,A4.L)              ; $229560
        BCLR    D0,(A7)+                        ; $229564
        MOVE.B  (A0),-$57(A7,A4.L)              ; $229566
        BCHG    D1,(A0)                         ; $22956A
        MOVE.B  (A0),-$33(A7,A4.L)              ; $22956C
        BCHG    D1,(A0)                         ; $229570
        MOVEA.B (A0)+,A3                        ; $229572
        MULS    A5,D7                           ; $229574
        BCLR    D0,-(A1)                        ; $229576
        MOVEA.B A7,A3                           ; $229578
        MULU    A3,D6                           ; $22957A
        BCLR    D1,$69(A1,D1.L)                 ; $22957C
        AND.L  D7,$03B1(A3)                     ; $229580
        MOVE.B  -$3055(A1),$03B1(A7)            ; $229584
        MOVE.B  D0,(A3)                         ; $22958A
        MULU    A3,D6                           ; $22958C
        BCLR    D1,-$80(A1,D1.W)                ; $22958E
        MULS    A6,D7                           ; $229592
        DC.W    $02E6               ; $229594 DC.W    $02E6
        MOVE.B  (A7)+,(A4)                      ; $229596
        MULS    A6,D7                           ; $229598
        DC.W    $02E6               ; $22959A DC.W    $02E6
        MOVE.B  A3,D4                           ; $22959C
        MULS    A6,D7                           ; $22959E
        ANDI.W  #$180B,-$3032(A6)               ; $2295A0
        ANDI.W  #$189F,-$3032(A6)               ; $2295A6
        DC.W    $02E6               ; $2295AC DC.W    $02E6
        MOVE.B  A1,#$CFCE                       ; $2295AE
        DC.W    $02E6               ; $2295B2 DC.W    $02E6
        MOVE.B  -$32(A5,A4.L),-(A4)             ; $2295B4
        ANDI.W  #$1935,-$3032(A6)               ; $2295B8
        ANDI.W  #$19C9,-$3032(A6)               ; $2295BE
        DC.W    $02E6               ; $2295C4 DC.W    $02E6
        MOVE.B  -$3032(A7),(A5)+                ; $2295C6
        DC.W    $02E6               ; $2295CA DC.W    $02E6
        MOVEA.B (A3)+,A5                        ; $2295CC
        MULS    A6,D7                           ; $2295CE
        ANDI.W  #$1A5B,-$3032(A6)               ; $2295D0
        ANDI.W  #$1AEF,-$3032(A6)               ; $2295D6
        DC.W    $02E6               ; $2295DC DC.W    $02E6
        MOVE.B  (A3)+,D6                        ; $2295DE
        MULS    A6,D7                           ; $2295E0
        DC.W    $02E6               ; $2295E2 DC.W    $02E6
        MOVE.B  D6,-$32(A5,A4.L)                ; $2295E4
        ANDI.W  #$1B86,-$3032(A6)               ; $2295E8
        ANDI.W  #$1C1B,-$3032(A6)               ; $2295EE
        DC.W    $02E6               ; $2295F4 DC.W    $02E6
        DC.W    $1D3E               ; $2295F6 MOVE.B  <EA:3E>,-(A6)
        MULS    A6,D7                           ; $2295F8
        DC.W    $02E6               ; $2295FA DC.W    $02E6
        MOVE.B  -$3032(A2),(A6)                 ; $2295FC
        ANDI.W  #$1CAA,-$3032(A6)               ; $229600
        ANDI.W  #$1D3E,-$3032(A6)               ; $229606
        DC.W    $02E6               ; $22960C DC.W    $02E6
        MOVEA.B -(A6),A7                        ; $22960E
        MULS    A6,D7                           ; $229610
        DC.W    $02E6               ; $229612 DC.W    $02E6
        DC.W    $1DD1               ; $229614 MOVE.B  (A1),<EA:3E>
        MULS    A6,D7                           ; $229616
        ANDI.W  #$1DD1,-$3032(A6)               ; $229618
        ANDI.W  #$1E66,-$30CD(A6)               ; $22961E
        DC.W    $047D,$1925         ; $229624 SUBI.W  #$1925,<EA:3D>
        AND.L  D7,(A2)+                         ; $229628
        DC.W    $047D,$182D         ; $22962A SUBI.W  #$182D,<EA:3D>
        AND.L  D7,(A2)+                         ; $22962E
        BCLR    D1,$2D(A1,D1.L)                 ; $229630
        AND.B  D7,-$4F(A3,D0.W)                 ; $229634
        MOVE.B  -(A5),-(A4)                     ; $229638
        AND.B  $7D(PC,D0.W),D7                  ; $22963A
        MOVE.B  A4,$3B(A4,A4.L)                 ; $22963E
        BCLR    D1,-$74(A1,D1.L)                ; $229642
        AND.W  D7,D4                            ; $229646
        DC.W    $04B4,$189B,$CDCD,$04B4; $229648 SUBI.L  #$189BCDCD,-$4C(A4,D0.W)
        MOVE.B  -$1A(A6,A4.L),-(A4)             ; $229650
        BCLR    D2,-$07(A2,D1.L)                ; $229654
        AND.B  D7,D7                            ; $229658
        BCLR    D2,-$7E(A2,D1.L)                ; $22965A
        AND.B  #$063E,D7                        ; $22965E
        MOVE.B  -$3170(A6),D4                   ; $229662
        BCLR    D2,$61(A2,D1.W)                 ; $229666
        DC.W    $0016,$B700         ; $22966A ORI.B  #$B700,(A6)
        DC.W    $0000,$0010         ; $22966E ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $229672 ORI.B  #$0030,-(A0)
        DC.W    $0216,$C300         ; $229676 ANDI.B  #$C300,(A6)
        ORI.W  #$0070,-(A0)                     ; $22967A
        SUBI.B  #$B900,(A4)                     ; $22967E
        ORI.L  #$00800210,(A0)                  ; $229682
        AND.B  D0,D2                            ; $229688
        ORI.W  #$0000,D0                        ; $22968A
        SUBI.B  #$B800,(A4)                     ; $22968E
        ORI.W  #$0010,(A0)                      ; $229692
        ORI.W  #$1700,(A6)                      ; $229696
        ANDI.W  #$0220,-(A0)                    ; $22969A
        ANDI.W  #$0270,(A0)                     ; $22969E
        ADDI.W  #$1900,(A2)+                    ; $2296A2
        DC.W    $0230,$0240,$0655   ; $2296A6 ANDI.B  #$0240,$55(A0,D0.W)
        AND.B  D1,D1                            ; $2296AC
        ANDI.L  #$0654C300,D0                   ; $2296AE
        ANDI.W  #$0290,-(A0)                    ; $2296B4
        ANDI.W  #$C200,(A4)                     ; $2296B8
        ANDI.L  #$02B00455,-(A0)                ; $2296BC
        AND.B  D1,D1                            ; $2296C2
        DC.W    $02C0               ; $2296C4 DC.W    $02C0
        ANDI.W  #$C401,(A5)                     ; $2296C6
        DC.W    $02D0               ; $2296CA DC.W    $02D0
        ORI.W  #$AA00,D4                        ; $2296CC
        ORI.L  #$00B000C0,-(A0)                 ; $2296D0
        DC.W    $00D0               ; $2296D6 DC.W    $00D0
        ORI.W  #$AA00,D4                        ; $2296D8
        DC.W    $00E0               ; $2296DC DC.W    $00E0
        DC.W    $00F0               ; $2296DE DC.W    $00F0
        BTST    D0,D0                           ; $2296E0
        BTST    D0,(A0)                         ; $2296E2
        ORI.W  #$AA00,D4                        ; $2296E4
        BTST    D0,-(A0)                        ; $2296E8
        BTST    D0,$40(A0,D0.W)                 ; $2296EA
        BCHG    D0,(A0)                         ; $2296EE
        ORI.W  #$AA00,D4                        ; $2296F0
        BCHG    D0,-(A0)                        ; $2296F4
        BCHG    D0,-$80(A0,D0.W)                ; $2296F6
        BCLR    D0,(A0)                         ; $2296FA
        ORI.W  #$AA00,D4                        ; $2296FC
        BCLR    D0,-(A0)                        ; $229700
        BCLR    D0,-$40(A0,D0.W)                ; $229702
        BSET    D0,(A0)                         ; $229706
        ORI.W  #$AA00,D4                        ; $229708
        BSET    D0,-(A0)                        ; $22970C
        BSET    D0,$00(A0,D0.W)                 ; $22970E
        DC.W    $0210,$0C00         ; $229712 ANDI.B  #$0C00,(A0)
        ORI.W  #$0041,-$28A0(A0)                ; $229716
        BCLR    D0,(A7)                         ; $22971C
        MOVE.B  $60(A6,A5.W),(A6)               ; $22971E
        BCLR    D0,(A0)+                        ; $229722
        MOVE.B  $56(A4,A5.W),(A6)+              ; $229724
        BCLR    D0,(A0)+                        ; $229728
        DC.W    $1CFE               ; $22972A MOVE.B  <EA:3E>,(A6)+
        ADD.W  D3,(A6)                          ; $22972C
        BCLR    D0,(A7)                         ; $22972E
        MOVE.B  $40(A6,A5.W),(A6)               ; $229730
        BCLR    D0,(A0)+                        ; $229734
        DC.W    $1FC8               ; $229736 MOVE.B  A0,<EA:3F>
        ADD.W  D0,D0                            ; $229738
        BCLR    D0,(A0)+                        ; $22973A
        MOVE.B  D3,(A5)+                        ; $22973C
        ADD.W  D0,A2                            ; $22973E
        BCLR    D0,(A0)+                        ; $229740
        MOVE.B  D3,(A5)+                        ; $229742
        ADD.W  D0,A2                            ; $229744
        BCLR    D0,(A0)+                        ; $229746
        DC.W    $1FBF,$D4CB         ; $229748 MOVE.B  <EA:3F>,-$35(A7,A5.W)
        BCLR    D0,(A0)+                        ; $22974C
        MOVE.B  D3,(A5)+                        ; $22974E
        ADD.W  D1,A2                            ; $229750
        BCLR    D0,(A0)+                        ; $229752
        MOVE.B  D3,(A5)+                        ; $229754
        ADD.W  D1,(A4)                          ; $229756
        BCLR    D0,(A0)+                        ; $229758
        MOVE.B  -(A3),(A5)                      ; $22975A
        ADDA.W  D1,A2                           ; $22975C
        BCLR    D0,(A0)+                        ; $22975E
        MOVE.B  -(A3),(A5)                      ; $229760
        ADD.L  D0,$0198(A2)                     ; $229762
        DC.W    $1FC8               ; $229766 MOVE.B  A0,<EA:3F>
        ADD.L  D0,-$68(PC,D0.W)                 ; $229768
        DC.W    $1FBF,$D73A         ; $22976C MOVE.B  <EA:3F>,$3A(A7,A5.W)
        BCLR    D0,(A0)+                        ; $229770
        DC.W    $1FBF,$D72F         ; $229772 MOVE.B  <EA:3F>,$2F(A7,A5.W)
        BCLR    D0,(A0)+                        ; $229776
        DC.W    $1FC8               ; $229778 MOVE.B  A0,<EA:3F>
        ADD.W  D4,D4                            ; $22977A
        BCLR    D0,(A0)+                        ; $22977C
        MOVE.B  (A5),(A7)+                      ; $22977E
        ADD.W  D3,-(A0)                         ; $229780
        BCLR    D0,(A0)+                        ; $229782
        MOVE.B  (A5),(A7)+                      ; $229784
        ADD.W  D3,-(A0)                         ; $229786
        BCLR    D0,(A0)+                        ; $229788
        MOVE.B  A3,(A7)+                        ; $22978A
        ADD.W  (A0),D4                          ; $22978C
        BCLR    D0,(A0)+                        ; $22978E
        MOVE.B  A3,(A7)+                        ; $229790
        ADD.B  D0,D3                            ; $229792
        BCLR    D0,(A0)+                        ; $229794
        MOVE.B  (A7)+,(A7)                      ; $229796
        ADD.B  D0,D3                            ; $229798
        BCLR    D0,(A0)+                        ; $22979A
        MOVE.B  (A6),-$29F7(A6)                 ; $22979C
        BCLR    D0,(A0)+                        ; $2297A0
        MOVE.B  (A0),-$29F7(A6)                 ; $2297A2
        BCLR    D0,(A0)+                        ; $2297A6
        MOVE.B  (A7)+,(A7)                      ; $2297A8
        ADD.B  A1,D3                            ; $2297AA
        BCLR    D0,(A0)+                        ; $2297AC
        MOVE.B  -$2A00(A5),(A6)                 ; $2297AE
        BCLR    D0,(A0)+                        ; $2297B2
        MOVE.B  -$2EDD(A5),(A6)                 ; $2297B4
        BCLR    D0,(A0)+                        ; $2297B8
        MOVE.L  (A4),D0                         ; $2297BA
        ADDA.W  A1,A0                           ; $2297BC
        BCLR    D0,(A0)+                        ; $2297BE
        MOVEA.L -(A4),A0                        ; $2297C0
        ADDA.W  A1,A0                           ; $2297C2
        BCLR    D0,(A0)+                        ; $2297C4
        MOVE.B  D3,(A5)+                        ; $2297C6
        ADD.B  D0,-(A3)                         ; $2297C8
        BCLR    D0,(A0)+                        ; $2297CA
        MOVE.B  D3,(A5)+                        ; $2297CC
        ADDA.W  -(A6),A4                        ; $2297CE
        BCLR    D0,(A0)+                        ; $2297D0
        MOVE.B  -$1A(A3,A5.L),-$68(A5,D0.W)     ; $2297D2
        MOVE.B  D3,(A5)+                        ; $2297D8
        ADDA.L  (A4),A5                         ; $2297DA
        BCLR    D0,(A0)+                        ; $2297DC
        MOVE.B  -$28(A4,A5.W),-$68(A5,D0.W)     ; $2297DE
        MOVE.L  (A4),D0                         ; $2297E4
        ADD.L  D3,A3                            ; $2297E6
        BCLR    D0,(A3)+                        ; $2297E8
        MOVE.B  -$3D(A6,A5.W),#$019B            ; $2297EA
        MOVE.B  -$3D(A6,A5.W),#$019A            ; $2297F0
        MOVE.B  -$287E(A7),D5                   ; $2297F6
        BCLR    D0,(A2)+                        ; $2297FA
        MOVE.B  -$283D(A7),D5                   ; $2297FC
        BCLR    D0,(A0)+                        ; $229800
        MOVE.B  D2,(A5)+                        ; $229802
        ADDA.L  D3,A3                           ; $229804
        BCLR    D0,(A6)+                        ; $229806
        MOVE.B  (A7)+,-$2806(A4)                ; $229808
        BCLR    D0,(A3)+                        ; $22980C
        MOVE.B  (A3),D5                         ; $22980E
        ADDA.W  A1,A0                           ; $229810
        BCLR    D0,-(A1)                        ; $229812
        MOVEA.L -(A4),A0                        ; $229814
        ADD.W  D0,D0                            ; $229816
        BCLR    D0,-(A0)                        ; $229818
        MOVE.B  -(A3),(A4)+                     ; $22981A
        ADD.W  D0,A2                            ; $22981C
        BCLR    D0,-(A0)                        ; $22981E
        MOVE.B  -(A3),(A4)+                     ; $229820
        ADD.W  D1,A2                            ; $229822
        BCLR    D0,-(A0)                        ; $229824
        MOVE.B  -(A3),(A4)+                     ; $229826
        ADD.W  D1,(A4)                          ; $229828
        BCLR    D0,-(A0)                        ; $22982A
        MOVE.B  -(A3),(A4)+                     ; $22982C
        ADDA.W  A2,A2                           ; $22982E
        BCLR    D0,-(A0)                        ; $229830
        MOVE.B  -(A3),(A4)+                     ; $229832
        ADDA.W  D0,A2                           ; $229834
        BCLR    D0,-(A0)                        ; $229836
        MOVE.B  -(A3),(A4)+                     ; $229838
        ADDA.W  A1,A0                           ; $22983A
        BCLR    D0,-(A0)                        ; $22983C
        MOVE.B  -(A3),(A4)+                     ; $22983E
        ADD.B  D0,-(A3)                         ; $229840
        BCLR    D0,-(A0)                        ; $229842
        MOVE.B  -(A3),(A4)+                     ; $229844
        ADDA.W  -(A6),A4                        ; $229846
        BCLR    D0,-(A0)                        ; $229848
        MOVE.B  -(A3),(A4)+                     ; $22984A
        ADD.L  D3,D1                            ; $22984C
        BCLR    D0,-(A0)                        ; $22984E
        MOVE.B  -(A3),(A4)+                     ; $229850
        ADD.L  D3,A3                            ; $229852
        BCLR    D0,-(A0)                        ; $229854
        MOVE.B  -(A3),(A4)+                     ; $229856
        MULS    A5,D7                           ; $229858
        BCLR    D0,-(A1)                        ; $22985A
        MOVE.B  (A2),-$33(A7,A4.L)              ; $22985C
        BCLR    D0,-(A1)                        ; $229860
        MOVEA.B A7,A3                           ; $229862
        MULS    A5,D7                           ; $229864
        BCLR    D0,-(A1)                        ; $229866
        MOVE.L  -$2EB6(A4),-(A0)                ; $229868
        BCLR    D0,-(A0)                        ; $22986C
        MOVE.B  D5,(A4)+                        ; $22986E
        ADD.W  D0,D0                            ; $229870
        BCLR    D0,-(A0)                        ; $229872
        MOVE.B  A4,(A4)+                        ; $229874
        ADD.W  D1,(A4)                          ; $229876
        BCLR    D0,-(A0)                        ; $229878
        MOVE.B  $4A(A3,A5.W),-(A3)              ; $22987A
        BCLR    D0,-(A0)                        ; $22987E
        MOVE.B  -$2B36(PC),-(A3)                ; $229880
        BCLR    D0,-(A0)                        ; $229884
        MOVE.B  -(A0),-(A3)                     ; $229886
        ADDA.W  D0,A2                           ; $229888
        BCLR    D0,-(A0)                        ; $22988A
        MOVE.B  (A4)+,-(A3)                     ; $22988C
        ADD.B  -(A2),D0                         ; $22988E
        BSET    D0,(A5)                         ; $229890
        MOVE.B  D1,D6                           ; $229892
        ADDA.W  D3,A0                           ; $229894
        BSET    D0,(A5)                         ; $229896
        MOVE.B  -(A4),(A6)                      ; $229898
        ADD.W  $15(A4,D0.W),D0                  ; $22989A
        MOVEA.B (A3),A6                         ; $22989E
        ADDA.W  D1,A2                           ; $2298A0
        BCLR    D0,(A0)+                        ; $2298A2
        MOVE.B  -$2B3F(A5),(A6)                 ; $2298A4
        BCLR    D0,(A0)+                        ; $2298A8
        MOVE.B  D3,(A5)+                        ; $2298AA
        ADDA.W  A3,A2                           ; $2298AC
        BCLR    D0,(A0)+                        ; $2298AE
        MOVE.B  -$2CB6(A5),(A6)                 ; $2298B0
        BCLR    D0,(A0)+                        ; $2298B4
        MOVE.B  $54(A3,A5.W),$0198(A5)          ; $2298B6
        MOVE.B  D3,(A5)+                        ; $2298BC
        ADD.W  D1,(A4)                          ; $2298BE
        BCLR    D0,(A0)+                        ; $2298C0
        MOVE.B  -$3C(A3,A5.W),$0198(A5)         ; $2298C2
        DC.W    $1C3E               ; $2298C8 MOVE.B  <EA:3E>,D6
        ADDA.L  A3,A1                           ; $2298CA
        BCLR    D0,(A0)+                        ; $2298CC
        MOVE.B  -$3F(A7,A5.W),D6                ; $2298CE
        BCLR    D0,(A0)+                        ; $2298D2
        MOVE.B  -(A3),(A6)                      ; $2298D4
        ADD.B  $0198(A4),D2                     ; $2298D6
        MOVEA.B -(A2),A6                        ; $2298DA
        ADDA.W  D1,A2                           ; $2298DC
        BCLR    D0,(A0)+                        ; $2298DE
        MOVEA.B -(A1),A6                        ; $2298E0
        ADD.W  D1,(A4)                          ; $2298E2
        BCLR    D0,(A0)+                        ; $2298E4
        MOVE.B  D3,-$2CAC(A5)                   ; $2298E6
        BCLR    D0,(A0)+                        ; $2298EA
        MOVE.B  -(A2),(A5)+                     ; $2298EC
        ADDA.W  D1,A2                           ; $2298EE
        BCLR    D0,(A0)+                        ; $2298F0
        MOVE.B  -(A2),(A5)+                     ; $2298F2
        ADDA.W  D1,A2                           ; $2298F4
        BCLR    D0,(A0)+                        ; $2298F6
        MOVE.B  D3,-$2C87(A5)                   ; $2298F8
        BCLR    D0,(A0)+                        ; $2298FC
        DC.W    $1BC2               ; $2298FE MOVE.B  D2,<EA:3D>
        ADD.W  D1,A4                            ; $229900
        BCLR    D0,(A0)+                        ; $229902
        MOVE.B  -(A2),-$2B3F(A5)                ; $229904
        BCLR    D0,(A0)+                        ; $229908
        MOVE.B  -(A2),-$2B3F(A5)                ; $22990A
        BCLR    D0,(A0)+                        ; $22990E
        DC.W    $1BC2               ; $229910 MOVE.B  D2,<EA:3D>
        ADD.L  D1,(A2)                          ; $229912
        BCLR    D0,(A0)+                        ; $229914
        DC.W    $1BE2               ; $229916 MOVE.B  -(A2),<EA:3D>
        ADDA.W  D1,A2                           ; $229918
        BCLR    D0,(A0)+                        ; $22991A
        DC.W    $1BE2               ; $22991C MOVE.B  -(A2),<EA:3D>
        ADDA.W  D1,A2                           ; $22991E
        BCLR    D0,(A0)+                        ; $229920
        MOVE.B  -$46(A5,A5.W),D6                ; $229922
        BCLR    D0,(A3)+                        ; $229926
        MOVE.B  -$0E(A6,A5.W),#$019B            ; $229928
        MOVE.B  -$0E(A6,A5.W),#$019A            ; $22992E
        MOVE.B  -$2A4F(A7),D5                   ; $229934
        BCLR    D0,(A2)+                        ; $229938
        MOVE.B  -$2A0E(A7),D5                   ; $22993A
        BCLR    D0,(A0)+                        ; $22993E
        MOVE.B  D2,(A5)+                        ; $229940
        ADDA.L  -$62(A2,D0.W),A2                ; $229942
        MOVE.B  (A7)+,-$29D6(A4)                ; $229946
        BCLR    D0,(A3)+                        ; $22994A
        MOVE.B  (A3),D5                         ; $22994C
        ADD.L  D2,-$60(A1,D0.W)                 ; $22994E
        MOVE.B  -(A3),(A4)+                     ; $229952
        ADD.L  D2,-$60(PC,D0.W)                 ; $229954
        MOVE.B  -(A3),(A4)+                     ; $229958
        ADDA.W  D0,A0                           ; $22995A
        DC.W    $0202,$1ACF         ; $22995C ANDI.B  #$1ACF,D2
        ADDA.W  A1,A0                           ; $229960
        DC.W    $0202,$1AC5         ; $229962 ANDI.B  #$1AC5,D2
        ADDA.W  D0,A0                           ; $229966
        BCLR    D0,-(A1)                        ; $229968
        MOVE.B  A7,(A5)+                        ; $22996A
        MULS    (A7),D7                         ; $22996C
        DC.W    $0203,$1AD1         ; $22996E ANDI.B  #$1AD1,D3
        MULS    (A7),D7                         ; $229972
        DC.W    $023D,$1AD0         ; $229974 ANDI.B  #$1AD0,<EA:3D>
        ADDA.W  A0,A0                           ; $229978
        DC.W    $0203,$1AD0         ; $22997A ANDI.B  #$1AD0,D3
        MULS    (A7),D7                         ; $22997E
        ANDI.W  #$1702,D1                       ; $229980
        ADDA.W  A0,A0                           ; $229984
        DC.W    $0207,$1702         ; $229986 ANDI.B  #$1702,D7
        DC.W    $0008,$1500         ; $22998A ORI.B  #$1500,A0
        BCLR    D0,-(A0)                        ; $22998E
        BCLR    D0,-$40(A0,D0.W)                ; $229990
        BSET    D0,(A0)                         ; $229994
        ADDI.B  #$B101,(A1)+                    ; $229996
        ANDI.L  #$0216B300,(A0)                 ; $22999A
        BCHG    D1,$50(A0,D0.W)                 ; $2299A0
        DC.W    $0216,$B400         ; $2299A4 ANDI.B  #$B400,(A6)
        BCHG    D1,-(A0)                        ; $2299A8
        BTST    D1,D0                           ; $2299AA
        DC.W    $0208,$1400         ; $2299AC ANDI.B  #$1400,A0
        BTST    D1,(A0)                         ; $2299B0
        BSET    D0,(A0)                         ; $2299B2
        SUBI.B  #$0D00,A0                       ; $2299B4
        BTST    D1,-(A0)                        ; $2299B8
        BSET    D0,$08(A0,D0.W)                 ; $2299BA
        DC.W    $0E00               ; $2299BE DC.W    $0E00
        BSET    D0,-(A0)                        ; $2299C0
        BCLR    D0,-(A0)                        ; $2299C2
        SUBI.B  #$0D00,A0                       ; $2299C4
        DC.W    $0200,$0210         ; $2299C8 ANDI.B  #$0210,D0
        DC.W    $0004,$1B00         ; $2299CC ORI.B  #$1B00,D4
        DC.W    $00D0               ; $2299D0 DC.W    $00D0
        DC.W    $00E0               ; $2299D2 DC.W    $00E0
        DC.W    $00F0               ; $2299D4 DC.W    $00F0
        DC.W    $00C0               ; $2299D6 DC.W    $00C0
        DC.W    $0204,$1B00         ; $2299D8 ANDI.B  #$1B00,D4
        ORI.W  #$0070,D0                        ; $2299DC
        SUBI.B  #$1B00,D4                       ; $2299E0
        ORI.W  #$0060,(A0)                      ; $2299E4
        SUBI.B  #$1B00,D4                       ; $2299E8
        ANDI.L  #$02B00404,-(A0)                ; $2299EC
        MOVE.B  D0,-(A5)                        ; $2299F2
        BCLR    D1,(A0)                         ; $2299F4
        BCLR    D1,D0                           ; $2299F6
        DC.W    $0004,$F900         ; $2299F8 ORI.B  #$F900,D4
        BCLR    D1,-(A0)                        ; $2299FC
        DC.W    $02D0               ; $2299FE DC.W    $02D0
        DC.W    $02C0               ; $229A00 DC.W    $02C0
        BCLR    D1,$04(A0,D0.W)                 ; $229A02
        MOVE.W  D0,-(A4)                        ; $229A06
        ORI.L  #$00900404,-(A0)                 ; $229A08
        MOVE.W  D0,-(A4)                        ; $229A0E
        DC.W    $00B0,$0080,$0404,$F900; $229A10 ORI.L  #$00800404,$00(A0,A7.L)
        DC.W    $02F0               ; $229A18 DC.W    $02F0
        DC.W    $02E0               ; $229A1A DC.W    $02E0
        SUBI.B  #$F900,D4                       ; $229A1C
        BSET    D1,(A0)                         ; $229A20
        BSET    D1,D0                           ; $229A22
        DC.W    $0004,$1B00         ; $229A24 ORI.B  #$1B00,D4
        BCHG    D0,D0                           ; $229A28
        BCHG    D0,(A0)                         ; $229A2A
        BCHG    D0,-(A0)                        ; $229A2C
        BCHG    D0,$04(A0,D0.W)                 ; $229A2E
        MOVE.B  D0,-(A5)                        ; $229A32
        BCLR    D0,(A0)                         ; $229A34
        BCLR    D0,D0                           ; $229A36
        DC.W    $0004,$1B00         ; $229A38 ORI.B  #$1B00,D4
        DC.W    $0220,$0230         ; $229A3C ANDI.B  #$0230,-(A0)
        ANDI.W  #$0250,D0                       ; $229A40
        DC.W    $0204,$1B00         ; $229A44 ANDI.B  #$1B00,D4
        BTST    D1,$40(A0,D0.W)                 ; $229A48
        DC.W    $0004,$1B00         ; $229A4C ORI.B  #$1B00,D4
        DC.W    $0000,$0010         ; $229A50 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $229A54 ORI.B  #$0030,-(A0)
        DC.W    $0004,$1B00         ; $229A58 ORI.B  #$1B00,D4
        BTST    D0,D0                           ; $229A5C
        BTST    D0,(A0)                         ; $229A5E
        BTST    D0,-(A0)                        ; $229A60
        BTST    D0,$05(A0,D0.W)                 ; $229A62
        MOVE.B  D1,-(A5)                        ; $229A66
        ANDI.W  #$0270,-(A0)                    ; $229A68
        ANDI.L  #$00038101,D0                   ; $229A6C
        BSET    D1,-(A0)                        ; $229A72
        BSET    D1,$00(A0,D0.W)                 ; $229A74
        ORI.W  #$F900,D4                        ; $229A78
        SUBI.W  #$0090,D0                       ; $229A7C
        SUBI.W  #$0460,(A0)                     ; $229A80
        ANDI.W  #$F900,D4                       ; $229A84
        SUBI.L  #$04700444,D0                   ; $229A88
        MOVE.W  D0,-(A4)                        ; $229A8E
        SUBI.L  #$04100044,(A0)                 ; $229A90
        MOVE.B  D0,-(A5)                        ; $229A96
        BCHG    D2,-$80(A0,D0.W)                ; $229A98
        BCLR    D2,(A0)                         ; $229A9C
        BCLR    D2,-(A0)                        ; $229A9E
        ANDI.W  #$1B00,D4                       ; $229AA0
        BSET    D2,-(A0)                        ; $229AA4
        BSET    D2,$55(A0,D0.W)                 ; $229AA6
        BTST    D4,D1                           ; $229AAA
        ADDI.B  #$0640,$50(A0,D0.W)             ; $229AAC
        ADDI.W  #$C900,D2                       ; $229AB2
        ADDI.W  #$0670,-(A0)                    ; $229AB6
        ORI.W  #$F900,D4                        ; $229ABA
        SUBI.B  #$0420,(A0)                     ; $229ABE
        ORI.L  #$04300045,D0                    ; $229AC2
        MOVE.W  D1,-(A4)                        ; $229AC8
        SUBI.L  #$04B00490,-(A0)                ; $229ACA
        ORI.W  #$F900,D4                        ; $229AD0
        DC.W    $04C0               ; $229AD4 DC.W    $04C0
        DC.W    $04D0               ; $229AD6 DC.W    $04D0
        DC.W    $04E0               ; $229AD8 DC.W    $04E0
        DC.W    $04F0               ; $229ADA DC.W    $04F0
        ORI.W  #$F900,D4                        ; $229ADC
        BTST    D2,D0                           ; $229AE0
        BTST    D2,(A0)                         ; $229AE2
        BTST    D2,-(A0)                        ; $229AE4
        BTST    D2,$44(A0,D0.W)                 ; $229AE6
        MOVE.W  D0,-(A4)                        ; $229AEA
        SUBI.L  #$05400550,D0                   ; $229AEC
        BCHG    D2,-(A0)                        ; $229AF2
        ORI.W  #$1B01,D5                        ; $229AF4
        BCLR    D2,-$40(A0,D0.W)                ; $229AF8
        BSET    D2,(A0)                         ; $229AFC
        ORI.W  #$1A00,D2                        ; $229AFE
        ADDI.B  #$0610,D0                       ; $229B02
        BSET    D0,D0                           ; $229B06
        ADDI.B  #$0C00,-(A0)                    ; $229B08
        ORI.W  #$0061,-$2760(A7)                ; $229B0C
        BCLR    D0,(A0)+                        ; $229B12
        DC.W    $1BDA               ; $229B14 MOVE.B  (A2)+,<EA:3D>
        ADD.L  -(A1),D4                         ; $229B16
        BCLR    D0,(A0)+                        ; $229B18
        MOVE.B  D3,D6                           ; $229B1A
        ADD.L  (A7),D4                          ; $229B1C
        BCLR    D0,(A0)+                        ; $229B1E
        MOVE.B  A4,D6                           ; $229B20
        ADD.L  (A7),D4                          ; $229B22
        BCLR    D0,(A0)+                        ; $229B24
        DC.W    $1BE0               ; $229B26 MOVE.B  -(A0),<EA:3D>
        ADD.L  (A7),D4                          ; $229B28
        BCLR    D0,(A0)+                        ; $229B2A
        MOVE.B  D3,(A5)+                        ; $229B2C
        ADD.L  -(A0),D4                         ; $229B2E
        BCLR    D0,(A0)+                        ; $229B30
        MOVE.B  D3,(A5)+                        ; $229B32
        ADD.B  D3,$0198(PC)                     ; $229B34
        DC.W    $1FBF,$DAAD         ; $229B38 MOVE.B  <EA:3F>,-$53(A7,A5.L)
        BCLR    D0,(A0)+                        ; $229B3C
        DC.W    $1FC0               ; $229B3E MOVE.B  D0,<EA:3F>
        ADD.L  -(A1),D5                         ; $229B40
        BCLR    D0,(A0)+                        ; $229B42
        DC.W    $1FCA               ; $229B44 MOVE.B  A2,<EA:3F>
        ADD.B  D3,$0198(A7)                     ; $229B46
        DC.W    $1FC8               ; $229B4A MOVE.B  A0,<EA:3F>
        ADD.B  D5,-(A0)                         ; $229B4C
        BCLR    D0,(A0)+                        ; $229B4E
        MOVE.B  $00(A4,A5.L),(A6)+              ; $229B50
        BCLR    D0,(A0)+                        ; $229B54
        MOVE.B  $00(A4,A5.L),(A6)+              ; $229B56
        BCLR    D0,(A0)+                        ; $229B5A
        DC.W    $1CFE               ; $229B5C MOVE.B  <EA:3E>,(A6)+
        ADD.B  D5,-(A0)                         ; $229B5E
        BCLR    D0,(A0)+                        ; $229B60
        DC.W    $1CFE               ; $229B62 MOVE.B  <EA:3E>,(A6)+
        ADD.W  D4,D0                            ; $229B64
        BCLR    D0,(A0)+                        ; $229B66
        DC.W    $1CFE               ; $229B68 MOVE.B  <EA:3E>,(A6)+
        ADD.W  D3,(A6)                          ; $229B6A
        BCLR    D0,(A0)+                        ; $229B6C
        DC.W    $1CFE               ; $229B6E MOVE.B  <EA:3E>,(A6)+
        ADD.W  D3,-(A0)                         ; $229B70
        BCLR    D0,(A0)+                        ; $229B72
        MOVE.B  $40(A4,A5.L),(A6)+              ; $229B74
        BCLR    D0,(A0)+                        ; $229B78
        MOVE.B  -$39(A4,A5.L),(A6)+             ; $229B7A
        BCLR    D0,(A0)+                        ; $229B7E
        MOVE.B  (A5),(A7)+                      ; $229B80
        ADD.B  D5,-(A0)                         ; $229B82
        BCLR    D0,(A0)+                        ; $229B84
        MOVE.B  (A5),(A7)+                      ; $229B86
        ADD.B  D5,-(A0)                         ; $229B88
        BCLR    D0,(A0)+                        ; $229B8A
        MOVE.B  A3,(A7)+                        ; $229B8C
        ADDA.L  (A3),A5                         ; $229B8E
        BCLR    D0,(A0)+                        ; $229B90
        MOVE.B  A3,(A7)+                        ; $229B92
        ADD.W  (A0),D4                          ; $229B94
        BCLR    D0,(A0)+                        ; $229B96
        MOVE.B  A3,(A7)+                        ; $229B98
        ADD.W  D4,D0                            ; $229B9A
        BCLR    D0,(A0)+                        ; $229B9C
        MOVE.B  A3,(A7)+                        ; $229B9E
        ADD.W  D4,D0                            ; $229BA0
        BCLR    D0,(A0)+                        ; $229BA2
        MOVE.B  (A5),(A7)+                      ; $229BA4
        ADD.W  D4,D4                            ; $229BA6
        BCLR    D0,(A0)+                        ; $229BA8
        MOVE.B  (A5),(A7)+                      ; $229BAA
        ADDA.L  (A3),A5                         ; $229BAC
        BCLR    D0,(A0)+                        ; $229BAE
        MOVE.B  A5,-$39(A7,A5.L)                ; $229BB0
        BCLR    D0,(A0)+                        ; $229BB4
        MOVE.B  A5,$7B(A7,A5.L)                 ; $229BB6
        BCLR    D0,(A0)+                        ; $229BBA
        MOVE.B  D2,D6                           ; $229BBC
        ADD.W  D5,-$68(A0,D0.W)                 ; $229BBE
        MOVE.B  A4,D6                           ; $229BC2
        ADD.B  D7,$0198(A2)                     ; $229BC4
        MOVE.B  D2,D6                           ; $229BC8
        ADD.B  D7,(A6)+                         ; $229BCA
        BCLR    D0,(A0)+                        ; $229BCC
        MOVE.B  A4,D6                           ; $229BCE
        ADD.B  D7,(A7)+                         ; $229BD0
        BCLR    D0,(A0)+                        ; $229BD2
        MOVE.L  -(A1),(A0)                      ; $229BD4
        ADD.B  D7,$0198(A1)                     ; $229BD6
        MOVE.L  -(A1),(A0)                      ; $229BDA
        ADD.L  D6,(A6)                          ; $229BDC
        BCLR    D0,(A0)+                        ; $229BDE
        MOVE.B  -(A3),(A7)                      ; $229BE0
        ADD.L  D6,(A6)                          ; $229BE2
        BCLR    D0,(A0)+                        ; $229BE4
        MOVE.B  -$2260(A3),$0198(A6)            ; $229BE6
        MOVE.B  -$2260(A3),$0198(A6)            ; $229BEC
        MOVE.B  -(A3),(A7)                      ; $229BF2
        ADDA.W  -(A6),A4                        ; $229BF4
        BCLR    D0,(A0)+                        ; $229BF6
        MOVE.B  D3,(A5)+                        ; $229BF8
        ADD.W  D4,D0                            ; $229BFA
        BCLR    D0,(A0)+                        ; $229BFC
        MOVE.B  D3,(A5)+                        ; $229BFE
        ADD.W  D4,D0                            ; $229C00
        BCLR    D0,(A0)+                        ; $229C02
        MOVE.B  -(A3),-$271A(A5)                ; $229C04
        BCLR    D0,(A0)+                        ; $229C08
        MOVE.B  -$0E(A3,A5.L),-$68(A5,D0.W)     ; $229C0A
        MOVE.B  -(A4),-$242C(A5)                ; $229C10
        BCLR    D0,(A0)+                        ; $229C14
        MOVE.B  -$49(A4,A5.L),-$68(A5,D0.W)     ; $229C16
        MOVE.B  -(A4),-$2078(A5)                ; $229C1C
        BCLR    D0,(A0)+                        ; $229C20
        MOVE.B  $48(A4,A5.L),-$68(A5,D0.W)      ; $229C22
        MOVE.L  (A4),D0                         ; $229C28
        ADDA.W  (A0)+,A3                        ; $229C2A
        BCLR    D0,(A0)+                        ; $229C2C
        MOVE.L  (A4),D0                         ; $229C2E
        ADD.L  D7,-$68(A7,D0.W)                 ; $229C30
        MOVE.L  -(A1),(A0)                      ; $229C34
        ADD.L  D7,A0                            ; $229C36
        BCLR    D0,(A0)+                        ; $229C38
        MOVE.L  -(A1),(A0)                      ; $229C3A
        ADD.W  D7,D5                            ; $229C3C
        BCLR    D0,(A0)+                        ; $229C3E
        MOVE.L  -(A1),(A0)                      ; $229C40
        ADD.L  (A7),D4                          ; $229C42
        BCLR    D0,-(A0)                        ; $229C44
        MOVE.B  -(A3),(A4)+                     ; $229C46
        ADD.L  -(A0),D4                         ; $229C48
        BCLR    D0,-(A0)                        ; $229C4A
        MOVE.B  -(A3),(A4)+                     ; $229C4C
        ADDA.W  -(A6),A4                        ; $229C4E
        BCLR    D0,-(A0)                        ; $229C50
        MOVE.B  -(A3),(A4)+                     ; $229C52
        ADD.W  D4,D0                            ; $229C54
        BCLR    D0,-(A0)                        ; $229C56
        MOVE.B  -(A3),(A4)+                     ; $229C58
        ADD.L  D7,-$5F(A7,D0.W)                 ; $229C5A
        MOVE.B  -(A5),-$2049(A5)                ; $229C5E
        BCLR    D0,-(A1)                        ; $229C62
        MOVE.L  -(A1),(A0)                      ; $229C64
        ADDA.L  -$5F(A2,D0.W),A5                ; $229C66
        MOVE.B  -(A5),-$26C0(A5)                ; $229C6A
        BCLR    D0,-(A1)                        ; $229C6E
        MOVE.B  -(A3),-$26C0(A5)                ; $229C70
        BCLR    D0,-(A1)                        ; $229C74
        MOVE.B  D3,(A5)+                        ; $229C76
        ADD.L  -(A0),D4                         ; $229C78
        BCLR    D0,-(A0)                        ; $229C7A
        MOVE.B  D5,(A4)+                        ; $229C7C
        ADD.L  (A7),D4                          ; $229C7E
        BCLR    D0,-(A0)                        ; $229C80
        MOVE.B  D1,(A4)+                        ; $229C82
        ADD.W  D4,D0                            ; $229C84
        BCLR    D0,$18E3(A1)                    ; $229C86
        ASR.L  #8,D1                            ; $229C8A
        BCLR    D0,-(A1)                        ; $229C8C
        MOVE.B  (A6),(A5)+                      ; $229C8E
        ADD.B  D5,-$5F(A4,D0.W)                 ; $229C90
        MOVE.B  (A6),(A5)+                      ; $229C94
        ADD.B  -$5F(A6,D0.W),D5                 ; $229C96
        MOVE.B  (A6),(A5)+                      ; $229C9A
        ADD.B  -$5B(A7,D0.W),D5                 ; $229C9C
        MOVE.B  -(A2),#$DA37                    ; $229CA0
        BCLR    D0,$1721(A1)                    ; $229CA4
        ADD.W  D4,D0                            ; $229CA8
        BCLR    D0,$1703(A1)                    ; $229CAA
        ADD.W  D4,A0                            ; $229CAE
        BCLR    D0,-(A1)                        ; $229CB0
        MOVE.B  (A3)+,-$26C0(A5)                ; $229CB2
        BCLR    D0,$63(A6,D1.L)                 ; $229CB6
        ADD.W  D4,A0                            ; $229CBA
        DC.W    $01BE               ; $229CBC BCLR    D0,<EA:3E>
        MOVE.B  (A3)+,-$2041(A5)                ; $229CBE
        BCLR    D0,-(A1)                        ; $229CC2
        MOVE.B  (A5)+,-$2049(A5)                ; $229CC4
        BCLR    D0,$65(A6,D1.L)                 ; $229CC8
        DC.W    $DFBF               ; $229CCC ADD.L  D7,<EA:3F>
        DC.W    $01BE               ; $229CCE BCLR    D0,<EA:3E>
        MOVE.B  (A5)+,-$2413(A5)                ; $229CD0
        BCLR    D0,-(A1)                        ; $229CD4
        MOVE.B  (A4)+,-$240E(A5)                ; $229CD6
        BCLR    D0,$64(A6,D1.L)                 ; $229CDA
        ADDA.L  $01BE(A4),A5                    ; $229CDE
        MOVE.B  (A4)+,-$2049(A5)                ; $229CE2
        BCLR    D0,-$5F(A6,D2.W)                ; $229CE6
        DC.W    $DFBF               ; $229CEA ADD.L  D7,<EA:3F>
        DC.W    $01BE               ; $229CEC BCLR    D0,<EA:3E>
        MOVE.L  (A1)+,(A0)                      ; $229CEE
        ADD.W  D4,D0                            ; $229CF0
        BCLR    D0,#$1703                       ; $229CF2
        ADD.W  D4,A0                            ; $229CF6
        BSET    D0,D4                           ; $229CF8
        DC.W    $16FD               ; $229CFA MOVE.B  <EA:3D>,(A3)+
        ADDA.L  $02DA(A7),A7                    ; $229CFC
        MOVE.B  -(A0),(A7)                      ; $229D00
        ADDA.L  A2,A7                           ; $229D02
        DC.W    $01CA               ; $229D04 BSET    D0,A2
        MOVE.B  $15(A7,A6.W),(A7)+              ; $229D06
        DC.W    $01CA               ; $229D0A BSET    D0,A2
        MOVEA.B A0,A7                           ; $229D0C
        ADDA.L  $33(A5,D0.W),A5                 ; $229D0E
        MOVE.B  -$23B8(A5),-(A5)                ; $229D12
        DC.W    $01CA               ; $229D16 BSET    D0,A2
        MOVE.B  (A2)+,-$245F(A5)                ; $229D18
        DC.W    $01CA               ; $229D1C BSET    D0,A2
        DC.W    $1AFF               ; $229D1E MOVE.B  <EA:3F>,(A5)+
        ADD.B  D5,-$2B(A4,D0.W)                 ; $229D20
        MOVE.B  (A6),(A5)+                      ; $229D24
        ASR.L  #8,D2                            ; $229D26
        BSET    D2,(A5)                         ; $229D28
        MOVE.B  (A7),(A5)+                      ; $229D2A
        ADD.B  -$2B(A6,D0.W),D5                 ; $229D2C
        MOVE.B  (A0)+,-(A3)                     ; $229D30
        ADD.B  -$2B(A6,D0.W),D5                 ; $229D32
        MOVE.B  (A6)+,#$DA36                    ; $229D36
        DC.W    $06B4,$1AD6,$DB34,$05D5; $229D3A ADDI.L  #$1AD6DB34,-$2B(A4,D0.W)
        MOVE.B  (A6)+,#$DB34                    ; $229D42
        DC.W    $06B4,$19DE,$DA36,$06B4; $229D46 ADDI.L  #$19DEDA36,-$4C(A4,D0.W)
        MOVE.B  (A6)+,#$DB34                    ; $229D4E
        DC.W    $06B4,$1AD6,$DE41,$0198; $229D52 ADDI.L  #$1AD6DE41,-$68(A4,D0.W)
        MOVE.B  -(A3),(A7)                      ; $229D5A
        ADD.W  D1,D7                            ; $229D5C
        BCLR    D0,(A0)+                        ; $229D5E
        MOVE.B  -$21B5(A5),$0198(A6)            ; $229D60
        MOVE.B  -$21B5(A5),$0198(A6)            ; $229D66
        MOVE.B  -(A3),(A7)                      ; $229D6C
        ADD.B  -$5A(A7,D0.W),D5                 ; $229D6E
        MOVE.B  $37(A2,A5.L),-(A4)              ; $229D72
        BCLR    D0,$17D1(A0)                    ; $229D76
        ADD.B  $60(A4,D0.W),D5                  ; $229D7A
        MOVE.B  (A2)+,$34(PC,A5.L)              ; $229D7E
        ANDI.W  #$1938,-(A0)                    ; $229D82
        ADDA.L  A0,A7                           ; $229D86
        DC.W    $02F2               ; $229D88 DC.W    $02F2
        MOVE.B  A5,-$1FFF(A5)                   ; $229D8A
        DC.W    $01CA               ; $229D8E BSET    D0,A2
        MOVE.B  (A1)+,-$72(A5,A5.L)             ; $229D90
        DC.W    $01CA               ; $229D94 BSET    D0,A2
        MOVE.B  D2,-(A5)                        ; $229D96
        ADD.W  D4,(A5)+                         ; $229D98
        BSET    D0,(A6)+                        ; $229D9A
        MOVE.B  (A0),-$2646(A4)                 ; $229D9C
        BSET    D0,(A6)+                        ; $229DA0
        MOVEA.B $D99002ED,A4                    ; $229DA2
        MOVE.B  (A6)+,(A4)+                     ; $229DA8
        DC.W    $0008,$1400         ; $229DAA ORI.B  #$1400,A0
        ANDI.L  #$028002A0,(A0)                 ; $229DAE
        DC.W    $02B0,$0408,$1500,$02C0; $229DB4 ANDI.L  #$04081500,-$40(A0,D0.W)
        DC.W    $02D0               ; $229DBC DC.W    $02D0
        DC.W    $0208,$0E00         ; $229DBE ANDI.B  #$0E00,A0
        DC.W    $02E0               ; $229DC2 DC.W    $02E0
        DC.W    $02F0               ; $229DC4 DC.W    $02F0
        ADDI.B  #$0D00,A0                       ; $229DC6
        BTST    D1,(A0)                         ; $229DCA
        BTST    D1,-(A0)                        ; $229DCC
        ADDI.B  #$1400,A0                       ; $229DCE
        DC.W    $02C0               ; $229DD2 DC.W    $02C0
        BTST    D1,D0                           ; $229DD4
        SUBI.B  #$B000,(A4)                     ; $229DD6
        BCHG    D1,-$80(A0,D0.W)                ; $229DDA
        ADDI.B  #$B100,(A0)+                    ; $229DDE
        ANDI.L  #$03900414,-(A0)                ; $229DE2
        CMP.B  D0,D0                            ; $229DE8
        ANDI.L  #$03A00418,D0                   ; $229DEA
        EOR.B  D0,D0                            ; $229DF0
        ANDI.W  #$03B0,$08(A0,D0.W)             ; $229DF2
        MOVE.B  D0,-(A2)                        ; $229DF8
        ANDI.L  #$02600208,(A0)                 ; $229DFA
        MOVE.B  D0,D2                           ; $229E00
        BCHG    D1,(A0)                         ; $229E02
        BCHG    D1,-(A0)                        ; $229E04
        DC.W    $0214,$B000         ; $229E06 ANDI.B  #$B000,(A4)
        BSET    D1,-(A0)                        ; $229E0A
        BCLR    D1,$17(A0,D0.W)                 ; $229E0C
        EOR.B  D1,D1                            ; $229E10
        SUBI.B  #$0616,-(A0)                    ; $229E12
        CMP.B  D0,D1                            ; $229E16
        SUBI.W  #$0430,D0                       ; $229E18
        DC.W    $0214,$BC00         ; $229E1C ANDI.B  #$BC00,(A4)
        BCLR    D2,-(A0)                        ; $229E20
        BCLR    D2,$14(A0,D0.W)                 ; $229E22
        EOR.B  D7,D0                            ; $229E26
        BSET    D2,D0                           ; $229E28
        SUBI.B  #$0216,(A0)                     ; $229E2A
        CMP.B  D0,D1                            ; $229E2E
        BCLR    D1,-(A0)                        ; $229E30
        BCLR    D1,$16(A0,D0.W)                 ; $229E32
        EOR.B  D1,D0                            ; $229E36
        SUBI.B  #$0390,D0                       ; $229E38
        SUBI.B  #$B200,(A6)                     ; $229E3C
        BSET    D1,$70(A0,D0.W)                 ; $229E40
        ADDI.B  #$BB00,(A4)                     ; $229E44
        BCLR    D2,D0                           ; $229E48
        BCLR    D2,(A0)                         ; $229E4A
        ADDI.B  #$BE00,(A4)                     ; $229E4C
        SUBI.B  #$05C0,(A0)                     ; $229E50
        DC.W    $0215,$BE01         ; $229E54 ANDI.B  #$BE01,(A5)
        ADDI.B  #$0216,D0                       ; $229E58
        EOR.B  D7,D0                            ; $229E5C
        BSET    D2,-(A0)                        ; $229E5E
        BSET    D2,(A0)                         ; $229E60
        SUBI.B  #$BE00,(A6)                     ; $229E62
        BSET    D2,-$50(A0,D0.W)                ; $229E66
        SUBI.B  #$BF01,(A5)                     ; $229E6A
        BSET    D2,D0                           ; $229E6E
        DC.W    $0004,$1B00         ; $229E70 ORI.B  #$1B00,D4
        DC.W    $0200,$01F0         ; $229E74 ANDI.B  #$01F0,D0
        BSET    D0,-(A0)                        ; $229E78
        DC.W    $0210,$0604         ; $229E7A ANDI.B  #$0604,(A0)
        MOVE.B  D0,-(A5)                        ; $229E7E
        BSET    D0,(A0)                         ; $229E80
        BSET    D0,D0                           ; $229E82
        SUBI.B  #$1B00,D4                       ; $229E84
        DC.W    $0020,$0010         ; $229E88 ORI.B  #$0010,-(A0)
        SUBI.B  #$1B00,D4                       ; $229E8C
        DC.W    $0030,$0000,$0404   ; $229E90 ORI.B  #$0000,$04(A0,D0.W)
        MOVE.B  D0,-(A5)                        ; $229E96
        ORI.W  #$0050,D0                        ; $229E98
        SUBI.B  #$1B00,D4                       ; $229E9C
        BTST    D1,$40(A0,D0.W)                 ; $229EA0
        SUBI.B  #$1B00,D4                       ; $229EA4
        BSET    D1,(A0)                         ; $229EA8
        BSET    D1,D0                           ; $229EAA
        DC.W    $0000,$2000         ; $229EAC ORI.B  #$2000,D0
        SUBI.L  #$03700490,D0                   ; $229EB0
        SUBI.L  #$04002000,-(A0)                ; $229EB6
        DC.W    $04C0               ; $229EBC DC.W    $04C0
        DC.W    $04D0               ; $229EBE DC.W    $04D0
        SUBI.B  #$2000,D0                       ; $229EC0
        SUBI.W  #$0470,-(A0)                    ; $229EC4
        SUBI.B  #$2000,D0                       ; $229EC8
        BTST    D2,D0                           ; $229ECC
        BTST    D2,(A0)                         ; $229ECE
        DC.W    $0004,$1B00         ; $229ED0 ORI.B  #$1B00,D4
        BTST    D0,-(A0)                        ; $229ED4
        BTST    D0,$40(A0,D0.W)                 ; $229ED6
        BCHG    D0,(A0)                         ; $229EDA
        DC.W    $0204,$1B00         ; $229EDC ANDI.B  #$1B00,D4
        BCLR    D0,-(A0)                        ; $229EE0
        BCLR    D0,$04(A0,D0.W)                 ; $229EE2
        MOVE.B  D0,-(A5)                        ; $229EE6
        ORI.W  #$0070,-(A0)                     ; $229EE8
        ORI.L  #$00900004,D0                    ; $229EEC
        MOVE.B  D0,-(A5)                        ; $229EF2
        ORI.L  #$00B000C0,-(A0)                 ; $229EF4
        DC.W    $00D0               ; $229EFA DC.W    $00D0
        DC.W    $0004,$1B00         ; $229EFC ORI.B  #$1B00,D4
        DC.W    $00E0               ; $229F00 DC.W    $00E0
        DC.W    $00F0               ; $229F02 DC.W    $00F0
        BTST    D0,D0                           ; $229F04
        BTST    D0,(A0)                         ; $229F06
        DC.W    $0004,$1B00         ; $229F08 ORI.B  #$1B00,D4
        BCHG    D0,-(A0)                        ; $229F0C
        BCHG    D0,-$80(A0,D0.W)                ; $229F0E
        BCLR    D0,(A0)                         ; $229F12
        DC.W    $0004,$1B00         ; $229F14 ORI.B  #$1B00,D4
        DC.W    $0220,$0230         ; $229F18 ANDI.B  #$0230,-(A0)
        ANDI.W  #$0250,D0                       ; $229F1C
        DC.W    $0000,$2000         ; $229F20 ORI.B  #$2000,D0
        SUBI.W  #$03A0,(A0)                     ; $229F24
        SUBI.W  #$0470,-(A0)                    ; $229F28
        DC.W    $0000,$2000         ; $229F2C ORI.B  #$2000,D0
        DC.W    $04B0,$0390,$04C0,$04D0; $229F30 SUBI.L  #$039004C0,-$30(A0,D0.W)
        DC.W    $0000,$2000         ; $229F38 ORI.B  #$2000,D0
        DC.W    $04E0               ; $229F3C DC.W    $04E0
        SUBI.L  #$04A004F0,(A0)                 ; $229F3E
        DC.W    $0003,$8101         ; $229F44 ORI.B  #$8101,D3
        BTST    D2,-(A0)                        ; $229F48
        BTST    D2,$40(A0,D0.W)                 ; $229F4A
        DC.W    $0003,$8101         ; $229F4E ORI.B  #$8101,D3
        BCHG    D2,(A0)                         ; $229F52
        BCHG    D2,-(A0)                        ; $229F54
        BCHG    D2,$44(A0,D0.W)                 ; $229F56
        MOVE.B  D0,-(A5)                        ; $229F5A
        ADDI.B  #$0620,(A0)                     ; $229F5C
        ADDI.B  #$0640,$54(A0,D0.W)             ; $229F60
        SUBI.B  #$0650,D0                       ; $229F66
        ADDI.W  #$0670,-(A0)                    ; $229F6A
        ADDI.L  #$00438201,D0                   ; $229F6E
        ADDI.L  #$06A006B0,(A0)                 ; $229F74
        ORI.W  #$8201,D3                        ; $229F7A
        DC.W    $06C0               ; $229F7E DC.W    $06C0
        DC.W    $06D0               ; $229F80 DC.W    $06D0
        DC.W    $06E0               ; $229F82 DC.W    $06E0
        CMPI.B  #$000B,D0                       ; $229F84
        DC.W    $000B,$DFB7         ; $229F88 ORI.B  #$DFB7,A3
        BCLR    D0,-(A1)                        ; $229F8C
        MOVE.L  -(A1),(A0)                      ; $229F8E
        ADD.L  D7,-$5F(A7,D0.W)                 ; $229F90
        MOVE.B  -(A5),-$1F7F(A5)                ; $229F94
        BCLR    D0,-(A1)                        ; $229F98
        MOVE.B  (A6),(A5)+                      ; $229F9A
        ASR.L  #8,D2                            ; $229F9C
        BCLR    D0,-(A1)                        ; $229F9E
        MOVE.L  -$1F7E(A3),(A0)                 ; $229FA0
        BSET    D2,(A5)                         ; $229FA4
        MOVE.B  (A7),(A5)+                      ; $229FA6
        ASR.L  #8,D2                            ; $229FA8
        BSET    D2,(A5)                         ; $229FAA
        MOVE.L  -$1F7E(A3),(A0)                 ; $229FAC
        BSET    D2,(A5)                         ; $229FB0
        MOVE.B  -(A0),#$E082                    ; $229FB2
        DC.W    $06B4,$19E0,$E082,$06B4; $229FB6 ADDI.L  #$19E0E082,-$4C(A4,D0.W)
        MOVE.B  (A7),(A5)+                      ; $229FBE
        ASL.L  #8,D0                            ; $229FC0
        BSET    D2,(A5)                         ; $229FC2
        MOVE.B  (A7),(A5)+                      ; $229FC4
        ASL.L  #8,D0                            ; $229FC6
        DC.W    $06B4,$1AD7,$0016,$B300; $229FC8 ADDI.L  #$1AD70016,$00(A4,A3.W)
        DC.W    $0000,$0010         ; $229FD0 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $229FD4 ORI.B  #$0030,-(A0)
        SUBI.B  #$BC00,(A4)                     ; $229FD8
        ORI.W  #$0050,D0                        ; $229FDC
        DC.W    $0016,$BF00         ; $229FE0 ORI.B  #$BF00,(A6)
        ORI.W  #$0060,D0                        ; $229FE4
        ORI.W  #$0080,$16(A0,D0.W)              ; $229FE8
        CMP.B  D0,D7                            ; $229FEE
        ORI.L  #$00900C00,-(A0)                 ; $229FF0
        DC.W    $0006,$0000         ; $229FF6 ORI.B  #$0000,D6
        LSR.W  #7,D0                            ; $229FFA
        ORI.L  #$14F9EE46,-(A0)                 ; $229FFC
        ORI.L  #$1D68ED3E,-(A0)                 ; $22A002
        ORI.L  #$1E5FED40,-(A0)                 ; $22A008
        ORI.L  #$14F8ED41,-(A0)                 ; $22A00E
        DC.W    $018A               ; $22A014 BCLR    D0,A2
        MOVEA.B (A7)+,A7                        ; $22A016
        ASL.W  #6,D3                            ; $22A018
        DC.W    $018A               ; $22A01A BCLR    D0,A2
        MOVE.B  $0046.W,(A2)+                   ; $22A01C
        MOVE.L  D0,-(A1)                        ; $22A020
        DC.W    $0000,$0010         ; $22A022 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $22A026 ORI.B  #$0030,-(A0)
        SUBI.W  #$A100,(A6)                     ; $22A02A
        ORI.W  #$0050,D0                        ; $22A02E
        CMPI.B  #$0006,D0                       ; $22A032
        DC.W    $0000,$EE46         ; $22A036 ORI.B  #$EE46,D0
        ORI.L  #$1D68002A,-(A0)                 ; $22A03A
        ORI.L  #$1D660034,-(A0)                 ; $22A040
        ORI.L  #$1E60ED3E,-(A0)                 ; $22A046
        ORI.L  #$1E5F0031,-(A0)                 ; $22A04C
        DC.W    $018A               ; $22A052 BCLR    D0,A2
        MOVEA.B (A7)+,A7                        ; $22A054
        ASL.W  #6,D1                            ; $22A056
        DC.W    $018A               ; $22A058 BCLR    D0,A2
        MOVEA.B (A7)+,A7                        ; $22A05A
        ORI.W  #$A300,D6                        ; $22A05C
        DC.W    $0000,$0010         ; $22A060 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $22A064 ORI.B  #$0030,-(A0)
        SUBI.W  #$9F00,(A6)                     ; $22A068
        ORI.W  #$0050,D0                        ; $22A06C
        CMPI.B  #$0004,D0                       ; $22A070
        DC.W    $0000,$F2FE         ; $22A074 ORI.B  #$F2FE,D0
        ORI.L  #$14FB0029,-(A0)                 ; $22A078
        ORI.L  #$14FB002A,-(A0)                 ; $22A07E
        ORI.L  #$1D66EE46,-(A0)                 ; $22A084
        ORI.L  #$1D680046,-(A0)                 ; $22A08A
        SUB.B  D0,D2                            ; $22A090
        DC.W    $0000,$0010         ; $22A092 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $22A096 ORI.B  #$0030,-(A0)
        CMPI.B  #$0018,D0                       ; $22A09A
        DC.W    $0010,$03B4         ; $22A09E ORI.B  #$03B4,(A0)
        ORI.L  #$1BD4002A,-(A0)                 ; $22A0A2
        ORI.L  #$1D660029,-(A0)                 ; $22A0A8
        ORI.L  #$14FB03F7,-(A0)                 ; $22A0AE
        ORI.L  #$1C900034,-(A0)                 ; $22A0B4
        ORI.L  #$1E600727,-(A0)                 ; $22A0BA
        ORI.L  #$1A2606AA,-(A0)                 ; $22A0C0
        ORI.L  #$19A903F5,-(A0)                 ; $22A0C6
        DC.W    $018A               ; $22A0CC BCLR    D0,A2
        MOVE.B  A3,(A6)                         ; $22A0CE
        DC.W    $0031,$018A,$1E5F   ; $22A0D0 ORI.B  #$018A,$5F(A1,D1.L)
        BTST    D3,-(A5)                        ; $22A0D6
        DC.W    $018A               ; $22A0D8 BCLR    D0,A2
        MOVE.B  (A6)+,D5                        ; $22A0DA
        BCLR    D2,$37(A7,D0.W)                 ; $22A0DC
        DC.W    $1FFE               ; $22A0E0 MOVE.B  <EA:3E>,<EA:3F>
        BCLR    D3,(A7)                         ; $22A0E2
        DC.W    $014A               ; $22A0E4 BCHG    D0,A2
        DC.W    $1DF6,$08B5         ; $22A0E6 MOVE.B  -$4B(A6,D0.L),<EA:3E>
        DC.W    $00F7               ; $22A0EA DC.W    $00F7
        MOVE.B  (A0)+,$28(A7,D0.W)              ; $22A0EC
        DC.W    $00F8               ; $22A0F0 DC.W    $00F8
        MOVE.L  -(A7),$08D7.W                   ; $22A0F2
        DC.W    $013E               ; $22A0F6 BTST    D0,<EA:3E>
        MOVE.B  (A5),(A6)+                      ; $22A0F8
        BTST    D5,$77(A5,D0.W)                 ; $22A0FA
        MOVE.B  $0591(A3),-$59(A4,D0.W)         ; $22A0FE
        MOVEA.B A5,A7                           ; $22A104
        BSET    D2,-(A5)                        ; $22A106
        ANDI.L  #$1E1F0639,(A4)                 ; $22A108
        BCLR    D0,-(A7)                        ; $22A10E
        DC.W    $1DF1,$05E5         ; $22A110 MOVE.B  -$1B(A1,D0.W),<EA:3E>
        BCHG    D0,(A4)                         ; $22A114
        MOVE.B  (A7)+,D7                        ; $22A116
        DC.W    $0148               ; $22A118 BCHG    D0,A0
        BSET    D0,D6                           ; $22A11A
        MOVE.B  A2,-$6B(A7,D0.W)                ; $22A11C
        DC.W    $02B3,$1F52,$01E3,$01C6; $22A120 ANDI.L  #$1F5201E3,-$3A(A3,D0.W)
        MOVE.B  (A1)+,-(A7)                     ; $22A128
        BCLR    D0,(A5)                         ; $22A12A
        BCHG    D0,$52(A3,D1.L)                 ; $22A12C
        DC.W    $0016,$A400         ; $22A130 ORI.B  #$A400,(A6)
        ORI.W  #$0030,(A0)                      ; $22A134
        DC.W    $0000,$0060         ; $22A138 ORI.B  #$0060,D0
        ADDI.B  #$A400,(A6)                     ; $22A13C
        ORI.W  #$0010,D0                        ; $22A140
        ADDI.B  #$A000,(A6)                     ; $22A144
        ORI.W  #$0080,$16(A0,D0.W)              ; $22A148
        MOVE.L  D0,D0                           ; $22A14E
        ORI.W  #$0090,(A0)                      ; $22A150
        DC.W    $0214,$8500         ; $22A154 ANDI.B  #$8500,(A4)
        DC.W    $00F0               ; $22A158 DC.W    $00F0
        DC.W    $00E0               ; $22A15A DC.W    $00E0
        DC.W    $0215,$8401         ; $22A15C ANDI.B  #$8401,(A5)
        DC.W    $00B0,$0218,$8500,$00A0; $22A160 ORI.L  #$02188500,-$60(A0,D0.W)
        ORI.L  #$06148400,D0                    ; $22A168
        DC.W    $00C0               ; $22A16E DC.W    $00C0
        DC.W    $00D0               ; $22A170 DC.W    $00D0
        DC.W    $0017,$9501         ; $22A172 ORI.B  #$9501,(A7)
        DC.W    $0000,$0010         ; $22A176 ORI.B  #$0010,D0
        DC.W    $0020,$0044         ; $22A17A ORI.B  #$0044,-(A0)
        SUB.B  D4,D0                            ; $22A17E
        BTST    D0,D0                           ; $22A180
        BTST    D0,(A0)                         ; $22A182
        BTST    D0,-(A0)                        ; $22A184
        BTST    D0,$44(A0,D0.W)                 ; $22A186
        SUB.B  D4,D0                            ; $22A18A
        BCHG    D0,D0                           ; $22A18C
        BCHG    D0,(A0)                         ; $22A18E
        BCHG    D0,-(A0)                        ; $22A190
        BCHG    D0,$00(A0,D0.L)                 ; $22A192
        DC.W    $002A,$001E,$06AA   ; $22A196 ORI.B  #$001E,$06AA(A2)
        ORI.L  #$19A908BC,-(A0)                 ; $22A19C
        ORI.L  #$16D30972,-(A0)                 ; $22A1A2
        ORI.L  #$17120727,-(A0)                 ; $22A1A8
        ORI.L  #$1A26102D,-(A0)                 ; $22A1AE
        DC.W    $00EF               ; $22A1B4 DC.W    $00EF
        MOVE.B  (A1),$22(A7,D0.L)               ; $22A1B6
        DC.W    $00EA               ; $22A1BA DC.W    $00EA
        MOVE.L  -(A2),D0                        ; $22A1BC
        DC.W    $0E1F               ; $22A1BE DC.W    $0E1F
        DC.W    $00EA               ; $22A1C0 DC.W    $00EA
        MOVE.L  (A1)+,D0                        ; $22A1C2
        MOVE.B  $00EF(A3),D0                    ; $22A1C4
        MOVE.B  D7,$05(A7,D0.L)                 ; $22A1C8
        DC.W    $00EE               ; $22A1CC DC.W    $00EE
        DC.W    $1FD6               ; $22A1CE MOVE.B  (A6),<EA:3F>
        MOVE.B  (A6)+,D0                        ; $22A1D0
        DC.W    $00F2               ; $22A1D2 DC.W    $00F2
        DC.W    $1F3F               ; $22A1D4 MOVE.B  <EA:3F>,-(A7)
        MOVE.B  -(A3),D0                        ; $22A1D6
        DC.W    $00EF               ; $22A1D8 DC.W    $00EF
        MOVE.B  (A2)+,$0E0E(A7)                 ; $22A1DA
        DC.W    $00EA               ; $22A1DE DC.W    $00EA
        DC.W    $1FEF,$0E02         ; $22A1E0 MOVE.B  $0E02(A7),<EA:3F>
        DC.W    $00FE               ; $22A1E4 DC.W    $00FE
        DC.W    $1FCE               ; $22A1E6 MOVE.B  A6,<EA:3F>
        MOVE.B  (A4)+,D0                        ; $22A1E8
        BTST    D0,D2                           ; $22A1EA
        MOVE.B  -$72(A7,D0.L),-(A7)             ; $22A1EC
        DC.W    $00F7               ; $22A1F0 DC.W    $00F7
        MOVEA.B A1,A7                           ; $22A1F2
        CMPI.W  #$00FE,(A3)+                    ; $22A1F4
        MOVE.B  (A0)+,-(A6)                     ; $22A1F8
        DC.W    $0DFD               ; $22A1FA BSET    D6,<EA:3D>
        DC.W    $00FE               ; $22A1FC DC.W    $00FE
        DC.W    $1FBF,$0C18         ; $22A1FE MOVE.B  <EA:3F>,$18(A7,D0.L)
