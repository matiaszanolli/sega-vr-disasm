; ============================================================================
; Code Section ($008200-$00A1FF)
; Regenerated with fixed disassembler - proper mnemonics
; ============================================================================

        org     $008200

        AND.L  -(A4),D4                         ; $008200
        BEQ.S  loc_00820A                       ; $008202
        MOVE.B  #$00BF,$C8A4.W                  ; $008204
loc_00820A:
        TST.W  $C04E.W                          ; $00820A
        BEQ.S  loc_008254                       ; $00820E
        MOVEQ   #$00,D0                         ; $008210
        SUBQ.W  #1,$C04E.W                      ; $008212
        BEQ.S  loc_008222                       ; $008216
        BTST    #2,$C8AB.W                      ; $008218
        BNE.S  loc_008222                       ; $00821E
        MOVEQ   #$01,D0                         ; $008220
loc_008222:
        MOVE.B  D0,$00FF6960                    ; $008222
        TST.B  $C305.W                          ; $008228
        BNE.S  loc_008254                       ; $00822C
        CMPI.W  #$003C,$C04E.W                  ; $00822E
        BNE.S  loc_008254                       ; $008234
        BTST    #1,$0002(A0)                    ; $008236
        BEQ.S  loc_008246                       ; $00823C
        ANDI.W  #$FDFF,$0002(A0)                ; $00823E
        RTS                                     ; $008244
loc_008246:
        MOVE.W  $002C(A0),D0                    ; $008246
        LEA     $000A(PC),A1                    ; $00824A
        MOVE.B  $00(A1,D0.W),$C8A5.W            ; $00824E
loc_008254:
        RTS                                     ; $008254
        OR.L   D2,D6                            ; $008256
        OR.L   D3,A0                            ; $008258
        OR.B   D4,D0                            ; $00825A
        BTST    #6,$0002(A0)                    ; $00825C
        BEQ.S  loc_0082A6                       ; $008262
        ANDI.W  #$BFFF,$0002(A0)                ; $008264
        BTST    #1,$0002(A0)                    ; $00826A
        BEQ.S  loc_008280                       ; $008270
        MOVE.W  #$0000,$C04E.W                  ; $008272
        ANDI.W  #$FDFF,$0002(A0)                ; $008278
        RTS                                     ; $00827E
loc_008280:
        CLR.W  $C8AA.W                          ; $008280
        MOVEQ   #$00,D6                         ; $008284
        MOVE.B  $C319.W,D0                      ; $008286
        ANDI.W  #$00C0,D0                       ; $00828A
        LSR.B  #4,D0                            ; $00828E
        MOVEA.L $56(PC,D0.W),A1                 ; $008290
        JSR     (A1)                            ; $008294
        LEA     $00FF68F8,A1                    ; $008296
        MOVE.B  D0,-$0007(A1)                   ; $00829C
        MOVE.B  D1,(A1)+                        ; $0082A0
        JSR     loc_00839A(PC)                  ; $0082A2
loc_0082A6:
        MOVE.W  $C04E.W,D0                      ; $0082A6
        BEQ.S  loc_0082E6                       ; $0082AA
        MOVEQ   #$00,D7                         ; $0082AC
        SUBQ.W  #1,$C04E.W                      ; $0082AE
        BEQ.S  loc_0082E0                       ; $0082B2
        BTST    #2,$C8AB.W                      ; $0082B4
        BNE.S  loc_0082BE                       ; $0082BA
        MOVEQ   #$03,D7                         ; $0082BC
loc_0082BE:
        TST.B  $C305.W                          ; $0082BE
        BNE.S  loc_0082E6                       ; $0082C2
        TST.W  D0                               ; $0082C4
        BMI.S  loc_0082E6                       ; $0082C6
        MOVE.W  $0002(A0),D1                    ; $0082C8
        ANDI.W  #$0200,D1                       ; $0082CC
        BEQ.S  loc_0082E0                       ; $0082D0
        ANDI.W  #$FDFF,$0002(A0)                ; $0082D2
        MOVE.W  #$0000,$C04E.W                  ; $0082D8
        RTS                                     ; $0082DE
loc_0082E0:
        MOVE.B  D7,$00FF68F0                    ; $0082E0
loc_0082E6:
        RTS                                     ; $0082E6
        DC.W    $0088                           ; $0082E8
        DIVU    $0088.W,D1                      ; $0082EA
        DIVU    $0088.W,D1                      ; $0082EE
        DIVU    $0088(PC),D1                    ; $0082F2
        OR.B   D1,(A0)+                         ; $0082F6
        RTS                                     ; $0082F8
        LEA     $C806.W,A1                      ; $0082FA
        LEA     $C270.W,A2                      ; $0082FE
        JSR     $00B3CE(PC)                     ; $008302
        MOVEQ   #$00,D0                         ; $008306
        LEA     $C270.W,A1                      ; $008308
        JSR     $00B386(PC)                     ; $00830C
        MOVE.L  $C270.W,D5                      ; $008310
        MOVEQ   #$04,D6                         ; $008314
        BRA.S  loc_008334                       ; $008316
        LEA     $C806.W,A1                      ; $008318
        LEA     $C274.W,A2                      ; $00831C
        JSR     $00B3CE(PC)                     ; $008320
        MOVEQ   #$02,D0                         ; $008324
        LEA     $C274.W,A1                      ; $008326
        JSR     $00B386(PC)                     ; $00832A
        MOVE.L  $C274.W,D5                      ; $00832E
        MOVEQ   #$08,D6                         ; $008332
loc_008334:
        LEA     $FDAA.W,A3                      ; $008334
        MOVE.W  $C89C.W,D1                      ; $008338
        LSL.W  #5,D1                            ; $00833C
        ADD.W  $C8A0.W,D1                       ; $00833E
        MOVE.W  $C8C8.W,D2                      ; $008342
        LSL.W  #3,D2                            ; $008346
        ADD.W  $C8CC.W,D2                       ; $008348
        ADD.W  D2,D1                            ; $00834C
        ADD.W  D6,D1                            ; $00834E
        LEA     $00(A3,D1.W),A3                 ; $008350
        CMPI.L  #$60000000,D5                   ; $008354
        BLT.S  loc_008368                       ; $00835A
        MOVE.L  #$DDDD0DDD,(A4)                 ; $00835C
        MOVEQ   #$01,D0                         ; $008362
        MOVEQ   #$00,D1                         ; $008364
        RTS                                     ; $008366
loc_008368:
        CMP.L  (A3),D5                          ; $008368
        BLT.S  loc_00837A                       ; $00836A
        BGT.S  loc_00838A                       ; $00836C
        MOVE.L  #$00000000,(A4)                 ; $00836E
        MOVEQ   #$0E,D1                         ; $008374
        MOVEQ   #$00,D0                         ; $008376
        RTS                                     ; $008378
loc_00837A:
        MOVE.L  (A3),(A4)                       ; $00837A
        MOVE.L  D5,$0004(A4)                    ; $00837C
        JSR     $00B478(PC)                     ; $008380
        MOVEQ   #$02,D0                         ; $008384
        MOVEQ   #$0D,D1                         ; $008386
        RTS                                     ; $008388
loc_00838A:
        MOVE.L  D5,(A4)                         ; $00838A
        MOVE.L  (A3),$0004(A4)                  ; $00838C
        JSR     $00B478(PC)                     ; $008390
        MOVEQ   #$01,D0                         ; $008394
        MOVEQ   #$0C,D1                         ; $008396
        RTS                                     ; $008398
loc_00839A:
        MOVE.B  (A4),D1                         ; $00839A
        BSR.S  loc_0083AE                       ; $00839C
        MOVE.B  $0001(A4),D1                    ; $00839E
        BSR.S  loc_0083AE                       ; $0083A2
        MOVE.B  $0002(A4),D1                    ; $0083A4
        MOVE.B  D1,(A1)+                        ; $0083A8
        MOVE.B  $0003(A4),D1                    ; $0083AA
loc_0083AE:
        MOVE.B  D1,D2                           ; $0083AE
        LSR.B  #4,D2                            ; $0083B0
        MOVE.B  D2,(A1)+                        ; $0083B2
        ANDI.B  #$000F,D1                       ; $0083B4
        MOVE.B  D1,(A1)+                        ; $0083B8
        RTS                                     ; $0083BA
        BTST    #6,$0002(A0)                    ; $0083BC
        BNE.S  loc_0083C6                       ; $0083C2
        RTS                                     ; $0083C4
loc_0083C6:
        MOVEQ   #$00,D0                         ; $0083C6
        MOVE.B  $A9E0.W,D0                      ; $0083C8
        ADDQ.B  #1,$A9E0.W                      ; $0083CC
        LEA     $A9E3.W,A1                      ; $0083D0
        LEA     $A800.W,A2                      ; $0083D4
        BRA.S  loc_0083F6                       ; $0083D8
        BTST    #6,$0002(A0)                    ; $0083DA
        BNE.S  loc_0083E4                       ; $0083E0
        RTS                                     ; $0083E2
loc_0083E4:
        MOVEQ   #$00,D0                         ; $0083E4
        MOVE.B  $A9E1.W,D0                      ; $0083E6
        ADDQ.B  #1,$A9E1.W                      ; $0083EA
        LEA     $A9E7.W,A1                      ; $0083EE
        LEA     $A8F0.W,A2                      ; $0083F2
loc_0083F6:
        LSL.W  #2,D0                            ; $0083F6
        LEA     $00(A2,D0.W),A2                 ; $0083F8
        MOVE.L  A2,-(A7)                        ; $0083FC
        JSR     $00B3CE(PC)                     ; $0083FE
        MOVEA.L (A7)+,A1                        ; $008402
        MOVEQ   #$00,D0                         ; $008404
        MOVE.B  $C319.W,D0                      ; $008406
        ANDI.W  #$00C0,D0                       ; $00840A
        LSR.W  #6,D0                            ; $00840E
        SUBQ.W  #1,D0                           ; $008410
        ADD.W  D0,D0                            ; $008412
        JMP     $00B3BC(PC)                     ; $008414
        BTST    #6,$0002(A0)                    ; $008418
        BEQ.S  loc_00846C                       ; $00841E
        ANDI.W  #$BFFF,$0002(A0)                ; $008420
        CLR.W  $C8AA.W                          ; $008426
        LEA     $A800.W,A2                      ; $00842A
        LEA     $A8F0.W,A3                      ; $00842E
        MOVEQ   #$00,D1                         ; $008432
        MOVE.B  $A9E0.W,D1                      ; $008434
        JSR     loc_0084F4(PC)                  ; $008438
        BEQ.S  loc_008446                       ; $00843C
        MOVE.W  #$0000,$C04E.W                  ; $00843E
        BRA.S  loc_00848A                       ; $008444
loc_008446:
        ANDI.W  #$BFFF,$0002(A1)                ; $008446
        JSR     loc_00850E(PC)                  ; $00844C
        LEA     $00FF68F8,A1                    ; $008450
        MOVE.L  #$04028070,-$0004(A1)           ; $008456
        MOVE.B  D0,-$0007(A1)                   ; $00845E
        MOVE.B  D1,(A1)+                        ; $008462
        JSR     loc_00839A(PC)                  ; $008464
        LEA     $9F00.W,A1                      ; $008468
loc_00846C:
        TST.W  $C04E.W                          ; $00846C
        BEQ.S  loc_00848A                       ; $008470
        MOVEQ   #$00,D7                         ; $008472
        SUBQ.W  #1,$C04E.W                      ; $008474
        BEQ.S  loc_008484                       ; $008478
        BTST    #2,$C8AB.W                      ; $00847A
        BNE.S  loc_008484                       ; $008480
        MOVEQ   #$03,D7                         ; $008482
loc_008484:
        MOVE.B  D7,$00FF68F0                    ; $008484
loc_00848A:
        BTST    #6,$0002(A1)                    ; $00848A
        BEQ.S  loc_0084D4                       ; $008490
        ANDI.W  #$BFFF,$0002(A1)                ; $008492
        CLR.W  $C8AA.W                          ; $008498
        LEA     $A8F0.W,A2                      ; $00849C
        LEA     $A800.W,A3                      ; $0084A0
        MOVEQ   #$00,D1                         ; $0084A4
        MOVE.B  $A9E1.W,D1                      ; $0084A6
        JSR     loc_0084F4(PC)                  ; $0084AA
        BEQ.S  loc_0084B8                       ; $0084AE
        MOVE.W  #$0000,$B7AE.W                  ; $0084B0
        BRA.S  loc_0084F2                       ; $0084B6
loc_0084B8:
        JSR     loc_00850E(PC)                  ; $0084B8
        LEA     $00FF68F8,A1                    ; $0084BC
        MOVE.L  #$04034070,-$0004(A1)           ; $0084C2
        MOVE.B  D0,-$0007(A1)                   ; $0084CA
        MOVE.B  D1,(A1)+                        ; $0084CE
        JSR     loc_00839A(PC)                  ; $0084D0
loc_0084D4:
        TST.W  $B7AE.W                          ; $0084D4
        BEQ.S  loc_0084F2                       ; $0084D8
        MOVEQ   #$00,D7                         ; $0084DA
        SUBQ.W  #1,$B7AE.W                      ; $0084DC
        BEQ.S  loc_0084EC                       ; $0084E0
        BTST    #2,$C8AB.W                      ; $0084E2
        BNE.S  loc_0084EC                       ; $0084E8
        MOVEQ   #$03,D7                         ; $0084EA
loc_0084EC:
        MOVE.B  D7,$00FF68F0                    ; $0084EC
loc_0084F2:
        RTS                                     ; $0084F2
loc_0084F4:
        SUBQ.W  #1,D1                           ; $0084F4
        LSL.W  #2,D1                            ; $0084F6
        MOVE.L  $00(A2,D1.W),D5                 ; $0084F8
        MOVE.L  $00(A3,D1.W),D4                 ; $0084FC
        BEQ.S  loc_00850A                       ; $008500
        CMP.L  D4,D5                            ; $008502
        BLT.S  loc_00850A                       ; $008504
        MOVEQ   #$00,D0                         ; $008506
        RTS                                     ; $008508
loc_00850A:
        MOVEQ   #$01,D0                         ; $00850A
        RTS                                     ; $00850C
loc_00850E:
        CMPI.L  #$60000000,D5                   ; $00850E
        BLT.S  loc_008522                       ; $008514
        MOVE.L  #$DDDD0DDD,(A4)                 ; $008516
        MOVEQ   #$01,D0                         ; $00851C
        MOVEQ   #$00,D1                         ; $00851E
        RTS                                     ; $008520
loc_008522:
        CMP.L  D4,D5                            ; $008522
        BNE.S  loc_008538                       ; $008524
        MOVE.L  #$00000000,(A4)                 ; $008526
        MOVEQ   #$0E,D1                         ; $00852C
        MOVEQ   #$00,D0                         ; $00852E
        RTS                                     ; $008530
        CMPI.L  #$003C0000,D0                   ; $008532
loc_008538:
        MOVE.L  D5,(A4)                         ; $008538
        MOVE.L  D4,$0004(A4)                    ; $00853A
        JSR     $00B478(PC)                     ; $00853E
        MOVEQ   #$01,D0                         ; $008542
        MOVEQ   #$0C,D1                         ; $008544
        RTS                                     ; $008546
        TST.W  $0098(A0)                        ; $008548
        BLE.S  loc_008552                       ; $00854C
        SUBQ.W  #1,$0098(A0)                    ; $00854E
loc_008552:
        TST.W  $009A(A0)                        ; $008552
        BLE.S  loc_00855C                       ; $008556
        SUBQ.W  #1,$009A(A0)                    ; $008558
loc_00855C:
        TST.W  $0086(A0)                        ; $00855C
        BLE.S  loc_008566                       ; $008560
        SUBQ.W  #1,$0086(A0)                    ; $008562
loc_008566:
        TST.W  $0080(A0)                        ; $008566
        BLE.S  loc_008570                       ; $00856A
        SUBQ.W  #1,$0080(A0)                    ; $00856C
loc_008570:
        TST.W  $0082(A0)                        ; $008570
        BLE.S  loc_00857A                       ; $008574
        SUBQ.W  #1,$0082(A0)                    ; $008576
loc_00857A:
        TST.W  $0084(A0)                        ; $00857A
        BLE.S  loc_008584                       ; $00857E
        SUBQ.W  #1,$0084(A0)                    ; $008580
loc_008584:
        TST.W  $00E6(A0)                        ; $008584
        BLE.S  loc_00858E                       ; $008588
        SUBQ.W  #1,$00E6(A0)                    ; $00858A
loc_00858E:
        TST.W  $00E8(A0)                        ; $00858E
        BLE.S  loc_008598                       ; $008592
        SUBQ.W  #1,$00E8(A0)                    ; $008594
loc_008598:
        RTS                                     ; $008598
        MOVE.W  $0004(A0),D0                    ; $00859A
        EXT.L   D0                              ; $00859E
        MOVEQ   #$06,D1                         ; $0085A0
        LSL.L  D1,D0                            ; $0085A2
        BPL.S  loc_0085A8                       ; $0085A4
        MOVEQ   #$00,D0                         ; $0085A6
loc_0085A8:
        CMPI.L  #$00001900,D0                   ; $0085A8
        BCS.S  loc_0085BE                       ; $0085AE
        LSL.L  #2,D0                            ; $0085B0
        CMPI.L  #$00007000,D0                   ; $0085B2
        BCS.S  loc_0085BE                       ; $0085B8
        MOVE.W  #$7080,D0                       ; $0085BA
loc_0085BE:
        SUB.W  D0,$00BC(A0)                     ; $0085BE
        RTS                                     ; $0085C2
        TST.B  $C8A2.W                          ; $0085C4
        BEQ.S  loc_0085D6                       ; $0085C8
        SUBQ.B  #1,$C8A2.W                      ; $0085CA
        BNE.S  loc_0085D6                       ; $0085CE
        MOVE.B  #$0000,$C8A6.W                  ; $0085D0
loc_0085D6:
        MOVE.W  $0094(A0),D0                    ; $0085D6
        BPL.S  loc_0085DE                       ; $0085DA
        NEG.W  D0                               ; $0085DC
loc_0085DE:
        CMPI.W  #$0010,D0                       ; $0085DE
        BLE.S  loc_008600                       ; $0085E2
        CMPI.W  #$0020,D0                       ; $0085E4
        BLE.S  loc_00860E                       ; $0085E8
        CMPI.B  #$00BD,$C8A6.W                  ; $0085EA
        BEQ.S  loc_00860E                       ; $0085F0
        MOVE.B  #$00BD,$C8A4.W                  ; $0085F2
        MOVE.B  #$0020,$C8A2.W                  ; $0085F8
        RTS                                     ; $0085FE
loc_008600:
        CMPI.B  #$00BD,$C8A6.W                  ; $008600
        BNE.S  loc_00860E                       ; $008606
        MOVE.B  #$00C8,$C8A4.W                  ; $008608
loc_00860E:
        RTS                                     ; $00860E
        TST.B  $C8A2.W                          ; $008610
        BEQ.S  loc_008622                       ; $008614
        SUBQ.B  #1,$C8A2.W                      ; $008616
        BNE.S  loc_008622                       ; $00861A
        MOVE.B  #$0000,$C8A6.W                  ; $00861C
loc_008622:
        MOVE.W  $9094.W,D0                      ; $008622
        BPL.S  loc_00862A                       ; $008626
        NEG.W  D0                               ; $008628
loc_00862A:
        MOVE.W  $9F94.W,D2                      ; $00862A
        BPL.S  loc_008632                       ; $00862E
        NEG.W  D2                               ; $008630
loc_008632:
        CMPI.W  #$0010,D0                       ; $008632
        BGT.S  loc_008646                       ; $008636
        CMPI.W  #$0010,D2                       ; $008638
        BLE.S  loc_008662                       ; $00863C
loc_00863E:
        CMPI.W  #$0020,D2                       ; $00863E
        BGT.S  loc_00864C                       ; $008642
        RTS                                     ; $008644
loc_008646:
        CMPI.W  #$0020,D0                       ; $008646
        BLE.S  loc_00863E                       ; $00864A
loc_00864C:
        CMPI.B  #$00BD,$C8A6.W                  ; $00864C
        BEQ.S  loc_008670                       ; $008652
        MOVE.B  #$00BD,$C8A4.W                  ; $008654
        MOVE.B  #$0020,$C8A2.W                  ; $00865A
        RTS                                     ; $008660
loc_008662:
        CMPI.B  #$00BD,$C8A6.W                  ; $008662
        BNE.S  loc_008670                       ; $008668
        MOVE.B  #$00C8,$C8A4.W                  ; $00866A
loc_008670:
        RTS                                     ; $008670
        MOVE.W  #$0100,D4                       ; $008672
        MOVE.W  #$0200,D5                       ; $008676
        MOVE.W  #$1000,D6                       ; $00867A
        MOVE.W  #$0000,$00C0(A1)                ; $00867E
        MOVE.W  $0030(A1),D2                    ; $008684
        MOVE.W  $0034(A1),D4                    ; $008688
        SUB.W  $0030(A0),D2                     ; $00868C
        BPL.S  loc_008694                       ; $008690
        NEG.W  D2                               ; $008692
loc_008694:
        CMP.W  D6,D2                            ; $008694
        BGT.S  loc_0086C6                       ; $008696
        SUB.W  $0034(A0),D4                     ; $008698
        BPL.S  loc_0086A0                       ; $00869C
        NEG.W  D4                               ; $00869E
loc_0086A0:
        CMP.W  D6,D4                            ; $0086A0
        BGT.S  loc_0086C6                       ; $0086A2
        MOVE.W  #$0003,$00C0(A1)                ; $0086A4
        CMP.W  D5,D2                            ; $0086AA
        BGT.S  loc_0086C6                       ; $0086AC
        CMP.W  D5,D4                            ; $0086AE
        BGT.S  loc_0086C6                       ; $0086B0
        MOVE.W  #$0002,$00C0(A1)                ; $0086B2
        CMP.W  D4,D2                            ; $0086B8
        BGT.S  loc_0086C6                       ; $0086BA
        CMP.W  D4,D4                            ; $0086BC
        BGT.S  loc_0086C6                       ; $0086BE
        MOVE.W  #$0001,$00C0(A1)                ; $0086C0
loc_0086C6:
        RTS                                     ; $0086C6
        MOVE.W  $0030(A0),D0                    ; $0086C8
        MOVE.W  $0034(A0),D1                    ; $0086CC
        TST.W  $C0BA.W                          ; $0086D0
        BEQ.S  loc_0086DE                       ; $0086D4
        MOVE.W  $C0BA.W,D0                      ; $0086D6
        MOVE.W  $C0BE.W,D1                      ; $0086DA
loc_0086DE:
        MOVE.L  #$014001C0,D4                   ; $0086DE
        MOVE.W  #$0400,D5                       ; $0086E4
        MOVE.W  #$0800,D6                       ; $0086E8
        BTST    #0,$C313.W                      ; $0086EC
        BNE.S  loc_008714                       ; $0086F2
        MOVE.W  #$0800,D5                       ; $0086F4
        MOVE.W  #$0FA0,D6                       ; $0086F8
        BRA.S  loc_008714                       ; $0086FC
        MOVE.W  $0030(A0),D0                    ; $0086FE
        MOVE.W  $0034(A0),D1                    ; $008702
        MOVE.L  #$014001C0,D4                   ; $008706
        MOVE.W  #$02C0,D5                       ; $00870C
        MOVE.W  #$1000,D6                       ; $008710
loc_008714:
        MOVEQ   #$0E,D7                         ; $008714
        LEA     $9100.W,A1                      ; $008716
loc_00871A:
        MOVE.W  #$0000,$00C0(A1)                ; $00871A
        MOVE.W  $0030(A1),D2                    ; $008720
        SUB.W  D0,D2                            ; $008724
        BPL.S  loc_00872A                       ; $008726
        NEG.W  D2                               ; $008728
loc_00872A:
        CMP.W  D6,D2                            ; $00872A
        BGT.S  loc_008770                       ; $00872C
        MOVE.W  $0034(A1),D3                    ; $00872E
        SUB.W  D1,D3                            ; $008732
        BPL.S  loc_008738                       ; $008734
        NEG.W  D3                               ; $008736
loc_008738:
        CMP.W  D6,D3                            ; $008738
        BGT.S  loc_008770                       ; $00873A
        MOVE.W  #$0003,$00C0(A1)                ; $00873C
        CMP.W  D5,D2                            ; $008742
        BGT.S  loc_008770                       ; $008744
        CMP.W  D5,D3                            ; $008746
        BGT.S  loc_008770                       ; $008748
        MOVE.W  #$0002,$00C0(A1)                ; $00874A
        CMP.W  D4,D2                            ; $008750
        BGT.S  loc_008770                       ; $008752
        CMP.W  D4,D3                            ; $008754
        BGT.S  loc_008770                       ; $008756
        MOVE.W  #$8002,$00C0(A1)                ; $008758
        SWAP    D4                              ; $00875E
        CMP.W  D4,D2                            ; $008760
        BGT.S  loc_00876E                       ; $008762
        CMP.W  D4,D3                            ; $008764
        BGT.S  loc_00876E                       ; $008766
        MOVE.W  #$8001,$00C0(A1)                ; $008768
loc_00876E:
        SWAP    D4                              ; $00876E
loc_008770:
        LEA     $0100(A1),A1                    ; $008770
        DBRA    D7,loc_00871A                   ; $008774
        RTS                                     ; $008778
        MOVE.W  $0030(A0),D0                    ; $00877A
        MOVE.W  $0034(A0),D1                    ; $00877E
        MOVE.W  #$0140,D4                       ; $008782
        MOVE.W  #$02C0,D5                       ; $008786
        MOVE.W  #$1000,D6                       ; $00878A
        MOVEQ   #$0E,D7                         ; $00878E
        LEA     $9100.W,A1                      ; $008790
loc_008794:
        MOVE.W  #$0000,$00C0(A1)                ; $008794
        MOVE.W  $0030(A1),D2                    ; $00879A
        SUB.W  D0,D2                            ; $00879E
        BPL.S  loc_0087A4                       ; $0087A0
        NEG.W  D2                               ; $0087A2
loc_0087A4:
        CMP.W  D6,D2                            ; $0087A4
        BGT.S  loc_0087D8                       ; $0087A6
        MOVE.W  $0034(A1),D3                    ; $0087A8
        SUB.W  D1,D3                            ; $0087AC
        BPL.S  loc_0087B2                       ; $0087AE
        NEG.W  D3                               ; $0087B0
loc_0087B2:
        CMP.W  D6,D3                            ; $0087B2
        BGT.S  loc_0087D8                       ; $0087B4
        MOVE.W  #$0003,$00C0(A1)                ; $0087B6
        CMP.W  D5,D2                            ; $0087BC
        BGT.S  loc_0087D8                       ; $0087BE
        CMP.W  D5,D3                            ; $0087C0
        BGT.S  loc_0087D8                       ; $0087C2
        MOVE.W  #$0002,$00C0(A1)                ; $0087C4
        CMP.W  D4,D2                            ; $0087CA
        BGT.S  loc_0087D8                       ; $0087CC
        CMP.W  D4,D3                            ; $0087CE
        BGT.S  loc_0087D8                       ; $0087D0
        MOVE.W  #$8001,$00C0(A1)                ; $0087D2
loc_0087D8:
        LEA     $0100(A1),A1                    ; $0087D8
        DBRA    D7,loc_008794                   ; $0087DC
        RTS                                     ; $0087E0
        LEA     $9000.W,A0                      ; $0087E2
        LEA     $9F00.W,A2                      ; $0087E6
        MOVE.W  $002E(A0),D0                    ; $0087EA
        LSL.W  #8,D0                            ; $0087EE
        ADD.W  $0024(A0),D0                     ; $0087F0
        MOVE.W  $002E(A2),D1                    ; $0087F4
        LSL.W  #8,D1                            ; $0087F8
        ADD.W  $0024(A2),D1                     ; $0087FA
        MOVEQ   #$02,D2                         ; $0087FE
        MOVEQ   #$01,D3                         ; $008800
        CMP.W  D0,D1                            ; $008802
        BGT.S  loc_008858                       ; $008804
        BNE.S  loc_008854                       ; $008806
        MOVE.W  $001E(A0),D0                    ; $008808
        NEG.W  D0                               ; $00880C
        MOVE.W  D0,D2                           ; $00880E
        JSR     loc_008F52(PC)                  ; $008810
        ASR.W  #4,D0                            ; $008814
        MULS    $0030(A0),D0                    ; $008816
        MOVE.L  D0,D4                           ; $00881A
        MOVE.W  D2,D0                           ; $00881C
        JSR     loc_008F4E(PC)                  ; $00881E
        ASR.W  #4,D0                            ; $008822
        MULS    $0034(A0),D0                    ; $008824
        ADD.L  D0,D4                            ; $008828
        MOVE.W  $001E(A2),D0                    ; $00882A
        NEG.W  D0                               ; $00882E
        MOVE.W  D0,D2                           ; $008830
        JSR     loc_008F52(PC)                  ; $008832
        ASR.W  #4,D0                            ; $008836
        MULS    $0030(A2),D0                    ; $008838
        MOVE.L  D0,D3                           ; $00883C
        MOVE.W  D2,D0                           ; $00883E
        JSR     loc_008F4E(PC)                  ; $008840
        ASR.W  #4,D0                            ; $008844
        MULS    $0034(A2),D0                    ; $008846
        ADD.L  D3,D0                            ; $00884A
        MOVEQ   #$02,D2                         ; $00884C
        MOVEQ   #$01,D3                         ; $00884E
        CMP.L  D4,D0                            ; $008850
        BGT.S  loc_008858                       ; $008852
loc_008854:
        MOVEQ   #$01,D2                         ; $008854
        MOVEQ   #$02,D3                         ; $008856
loc_008858:
        CMP.W  $002A(A0),D2                     ; $008858
        BEQ.S  loc_0088B4                       ; $00885C
        MOVE.W  $0004(A0),D4                    ; $00885E
        SUB.W  $0004(A2),D4                     ; $008862
        BPL.S  loc_00886A                       ; $008866
        NEG.W  D4                               ; $008868
loc_00886A:
        CMPI.W  #$0014,D4                       ; $00886A
        BLE.S  loc_0088B4                       ; $00886E
        MOVE.W  $0004(A0),D4                    ; $008870
        ADD.W  $0004(A2),D4                     ; $008874
        CMPI.W  #$0064,D4                       ; $008878
        BLE.S  loc_0088B4                       ; $00887C
        CMPI.W  #$0004,$C89C.W                  ; $00887E
        BNE.S  loc_008892                       ; $008884
        MOVE.B  $00E5(A0),D1                    ; $008886
        EOR.B  D1,D2                            ; $00888A
        ANDI.B  #$0006,D2                       ; $00888C
        BNE.S  loc_0088B4                       ; $008890
loc_008892:
        MOVE.B  #$00CC,$C8A4.W                  ; $008892
        CMPI.W  #$0001,$C8C8.W                  ; $008898
        BEQ.S  loc_0088B4                       ; $00889E
        MOVE.B  #$00CF,$C8A4.W                  ; $0088A0
        CMPI.W  #$0002,$C8C8.W                  ; $0088A6
        BEQ.S  loc_0088B4                       ; $0088AC
        MOVE.B  #$00B3,$C8A4.W                  ; $0088AE
loc_0088B4:
        MOVE.W  D2,$002A(A0)                    ; $0088B4
        MOVE.W  D3,$002A(A2)                    ; $0088B8
        RTS                                     ; $0088BC
        MOVE.B  $C86D.W,D0                      ; $0088BE
        ANDI.B  #$0060,D0                       ; $0088C2
        BEQ.S  loc_0088CE                       ; $0088C6
        BCHG    #0,$C313.W                      ; $0088C8
loc_0088CE:
        LEA     $9000.W,A0                      ; $0088CE
        BTST    #0,$C313.W                      ; $0088D2
        BEQ.W  loc_0089C4                       ; $0088D8
        BSET    #3,$C313.W                      ; $0088DC
        MOVE.W  #$0000,$C0C8.W                  ; $0088E2
        BTST    #0,$C86C.W                      ; $0088E8
        BNE.S  loc_00896E                       ; $0088EE
        BTST    #1,$C86C.W                      ; $0088F0
        BNE.W  loc_008998                       ; $0088F6
        MOVE.W  #$0010,$C8E0.W                  ; $0088FA
loc_008900:
        MOVE.W  $C8D8.W,D0                      ; $008900
        CMPI.W  #$3000,D0                       ; $008904
        BGT.S  loc_008926                       ; $008908
        BEQ.S  loc_00893A                       ; $00890A
        MOVE.W  #$07D0,$C8D4.W                  ; $00890C
        MOVE.W  #$0200,$00FF60CC                ; $008912
        LSR.W  #3,D0                            ; $00891A
        SUBI.W  #$00A0,D0                       ; $00891C
        MOVE.W  D0,$C8D6.W                      ; $008920
        BRA.S  loc_008942                       ; $008924
loc_008926:
        MOVE.W  #$0600,$C8D6.W                  ; $008926
        MOVEQ   #$09,D1                         ; $00892C
        LSR.W  D1,D0                            ; $00892E
        NEG.W  D0                               ; $008930
        ADDI.W  #$07D0,D0                       ; $008932
        MOVE.W  D0,$C8D4.W                      ; $008936
loc_00893A:
        MOVE.W  #$0100,$00FF60CC                ; $00893A
loc_008942:
        MOVE.W  $C8D4.W,$C0AE.W                 ; $008942
        MOVE.W  #$0000,$C0B0.W                  ; $008948
        MOVE.W  #$0000,$C0B2.W                  ; $00894E
        MOVE.W  $C8D6.W,$C054.W                 ; $008954
        MOVE.W  $C8D8.W,$C056.W                 ; $00895A
        MOVE.W  #$0000,$C0C6.W                  ; $008960
        MOVE.W  #$0000,$C0BA.W                  ; $008966
        RTS                                     ; $00896C
loc_00896E:
        MOVE.W  $C8E0.W,D0                      ; $00896E
        ADD.W  D0,D0                            ; $008972
        CMPI.W  #$0400,D0                       ; $008974
        BLE.S  loc_00897E                       ; $008978
        MOVE.W  #$0400,D0                       ; $00897A
loc_00897E:
        MOVE.W  D0,$C8E0.W                      ; $00897E
        ADD.W  $C8D8.W,D0                       ; $008982
        CMPI.W  #$7800,D0                       ; $008986
        BLE.S  loc_008990                       ; $00898A
        MOVE.W  #$7800,D0                       ; $00898C
loc_008990:
        MOVE.W  D0,$C8D8.W                      ; $008990
        BRA.W  loc_008900                       ; $008994
loc_008998:
        MOVE.W  $C8E0.W,D0                      ; $008998
        ADD.W  D0,D0                            ; $00899C
        CMPI.W  #$0400,D0                       ; $00899E
        BLE.S  loc_0089A8                       ; $0089A2
        MOVE.W  #$0400,D0                       ; $0089A4
loc_0089A8:
        MOVE.W  D0,$C8E0.W                      ; $0089A8
        NEG.W  D0                               ; $0089AC
        ADD.W  $C8D8.W,D0                       ; $0089AE
        CMPI.W  #$0500,D0                       ; $0089B2
        BGE.S  loc_0089BC                       ; $0089B6
        MOVE.W  #$0500,D0                       ; $0089B8
loc_0089BC:
        MOVE.W  D0,$C8D8.W                      ; $0089BC
        BRA.W  loc_008900                       ; $0089C0
loc_0089C4:
        BTST    #4,$C86D.W                      ; $0089C4
        BEQ.S  loc_0089D8                       ; $0089CA
        BCHG    #2,$C313.W                      ; $0089CC
        BCLR    #4,$C313.W                      ; $0089D2
loc_0089D8:
        MOVE.W  #$00C0,$C0C8.W                  ; $0089D8
        MOVE.W  #$0100,$00FF60CC                ; $0089DE
        MOVE.W  $C8DA.W,$C0AE.W                 ; $0089E6
        MOVE.W  #$0000,$C0B0.W                  ; $0089EC
        MOVE.W  #$0000,$C0B2.W                  ; $0089F2
        MOVE.W  $C8DC.W,$C054.W                 ; $0089F8
        MOVE.W  $C8DE.W,$C056.W                 ; $0089FE
        MOVE.W  $C8A0.W,D0                      ; $008A04
        MOVEA.L $04(PC,D0.W),A1                 ; $008A08
        JMP     (A1)                            ; $008A0C
        DC.W    $0088                           ; $008A0E
        OR.W   $0088(A0),D5                     ; $008A10
        OR.B   -(A6),D5                         ; $008A14
        DC.W    $0088                           ; $008A16
        OR.W   $0088(A0),D5                     ; $008A18
        OR.W   $0088(A0),D5                     ; $008A1C
        OR.W   D2,D5                            ; $008A20
        DC.W    $0088                           ; $008A22
        OR.W   $1028(A0),D5                     ; $008A24
        DC.W    $00E5                           ; $008A28
        BTST    #2,D0                           ; $008A2A
        BNE.W  loc_008B7C                       ; $008A2E
        CMPI.W  #$00E0,$001C(A0)                ; $008A32
        BLE.S  loc_008A68                       ; $008A38
        ANDI.B  #$0002,D0                       ; $008A3A
        BNE.W  loc_008B7C                       ; $008A3E
        MOVE.W  $0024(A0),D0                    ; $008A42
        CMPI.W  #$0042,D0                       ; $008A46
        BCS.S  loc_008A68                       ; $008A4A
        CMPI.W  #$0048,D0                       ; $008A4C
        BCC.S  loc_008A68                       ; $008A50
        LEA     $0108(PC),A1                    ; $008A52
        BTST    #2,$C313.W                      ; $008A56
        BEQ.S  loc_008A62                       ; $008A5C
        LEA     $010C(PC),A1                    ; $008A5E
loc_008A62:
        LEA     $C0BA.W,A2                      ; $008A62
        BRA.S  loc_008AD2                       ; $008A66
loc_008A68:
        BTST    #4,$C313.W                      ; $008A68
        BEQ.S  loc_008A76                       ; $008A6E
        MOVEA.L $C288.W,A1                      ; $008A70
        BRA.S  loc_008AD2                       ; $008A74
loc_008A76:
        MOVEQ   #$00,D0                         ; $008A76
        BTST    #2,$C313.W                      ; $008A78
        BEQ.S  loc_008A82                       ; $008A7E
        MOVEQ   #$04,D0                         ; $008A80
loc_008A82:
        LEA     $00FF301A,A1                    ; $008A82
        ADD.W  $C8A0.W,D0                       ; $008A88
        ADD.W  $C8A0.W,D0                       ; $008A8C
        MOVEA.L $00(A1,D0.W),A1                 ; $008A90
        LEA     $C0BA.W,A2                      ; $008A94
        MOVE.W  $0030(A0),D0                    ; $008A98
        MOVE.W  $0034(A0),D1                    ; $008A9C
        MOVE.W  #$0640,D6                       ; $008AA0
        MOVE.W  (A1)+,D7                        ; $008AA4
loc_008AA6:
        MOVE.W  $0000(A1),D2                    ; $008AA6
        MOVE.W  $0004(A1),D4                    ; $008AAA
        MOVE.W  D2,D3                           ; $008AAE
        SUB.W  D0,D3                            ; $008AB0
        BPL.S  loc_008AB6                       ; $008AB2
        NEG.W  D3                               ; $008AB4
loc_008AB6:
        CMP.W  D6,D3                            ; $008AB6
        BGT.S  loc_008AC6                       ; $008AB8
        MOVE.W  D4,D3                           ; $008ABA
        SUB.W  D1,D3                            ; $008ABC
        BPL.S  loc_008AC2                       ; $008ABE
        NEG.W  D3                               ; $008AC0
loc_008AC2:
        CMP.W  D6,D3                            ; $008AC2
        BLE.S  loc_008AD2                       ; $008AC4
loc_008AC6:
        LEA     $0010(A1),A1                    ; $008AC6
        DBRA    D7,loc_008AA6                   ; $008ACA
        JMP     loc_008B7C(PC)                  ; $008ACE
loc_008AD2:
        BCLR    #3,$C313.W                      ; $008AD2
        CMPA.L  $C288.W,A1                      ; $008AD8
        BEQ.S  loc_008AF4                       ; $008ADC
        MOVE.L  A1,$C288.W                      ; $008ADE
        MOVE.W  $0006(A1),$C100.W               ; $008AE2
        MOVE.W  $0008(A1),$C102.W               ; $008AE8
        MOVE.W  $000A(A1),$C104.W               ; $008AEE
loc_008AF4:
        MOVE.W  $000E(A1),D2                    ; $008AF4
        BTST    #15,D2                          ; $008AF8
        BEQ.S  loc_008B04                       ; $008AFC
        BSET    #3,$C313.W                      ; $008AFE
loc_008B04:
        ANDI.W  #$7FFF,D2                       ; $008B04
        MOVE.L  (A1)+,(A2)+                     ; $008B08
        MOVE.L  (A1)+,(A2)+                     ; $008B0A
        MOVE.L  (A1)+,(A2)+                     ; $008B0C
        MOVE.W  (A1),(A2)                       ; $008B0E
        MOVE.W  (A1),D0                         ; $008B10
        ADD.W  D0,D0                            ; $008B12
        ADD.W  D0,$00FF60CC                     ; $008B14
        MOVEA.L $0C(PC,D2.W),A1                 ; $008B1A
        JSR     (A1)                            ; $008B1E
        BCLR    #1,$C313.W                      ; $008B20
        RTS                                     ; $008B26
        DC.W    $0088                           ; $008B28
        OR.W   D6,-(A2)                         ; $008B2A
        DC.W    $0088                           ; $008B2C
        OR.L   -$78(A6,D0.W),D7                 ; $008B2E
        DIVU    (A6),D7                         ; $008B32
        DC.W    $0088                           ; $008B34
        DIVU    -$78(A2,D0.W),D7                ; $008B36
        DIVU    -$78(A4,D0.W),D7                ; $008B3A
        DIVU    #$0088,D7                       ; $008B3E
        OR.W   D0,D6                            ; $008B42
        DC.W    $0088                           ; $008B44
        DIVU    A6,D6                           ; $008B46
        DC.W    $0088                           ; $008B48
        OR.L   D5,(A4)+                         ; $008B4A
        DC.W    $0088                           ; $008B4C
        DIVS    D0,D6                           ; $008B4E
        DC.W    $0088                           ; $008B50
        DIVS    D2,D5                           ; $008B52
        DC.W    $0088                           ; $008B54
        DIVS    -$78(A2,D0.W),D5                ; $008B56
        OR.B   (A6),D6                          ; $008B5A
        MOVE.W  $00(A0,D5.L),D5                 ; $008B5C
        MOVE.B  (A0)+,$0000(A6)                 ; $008B60
        ORI.B  #$0000,D0                        ; $008B64
        ORI.B  #$0024,D0                        ; $008B68
        LSL.W  D6,D0                            ; $008B6C
        NEG.B  D0                               ; $008B6E
        MOVE.B  (A3),(A7)                       ; $008B70
        ORI.B  #$0000,D0                        ; $008B72
        ORI.B  #$0100,D0                        ; $008B76
        ORI.B  #$31FC,-(A4)                     ; $008B7A
        ORI.B  #$C0C6,D0                        ; $008B7E
        MOVE.W  #$0000,$C0BA.W                  ; $008B82
        BSET    #1,$C313.W                      ; $008B88
        BCLR    #3,$C313.W                      ; $008B8E
        MOVE.B  #$0000,$C896.W                  ; $008B94
        RTS                                     ; $008B9A
        MOVE.W  #$0000,$C0BA.W                  ; $008B9C
        MOVE.W  #$0080,$C0B0.W                  ; $008BA2
        MOVE.W  $C8DC.W,D0                      ; $008BA8
        MOVE.W  D0,$C054.W                      ; $008BAC
        MOVE.W  D0,$C892.W                      ; $008BB0
        MOVE.W  $C8DE.W,D0                      ; $008BB4
        MOVE.W  D0,$C056.W                      ; $008BB8
        MOVE.W  D0,$C894.W                      ; $008BBC
        RTS                                     ; $008BC0
        MOVE.W  #$0000,$C0BA.W                  ; $008BC2
        LEA     $C0C0.W,A1                      ; $008BC8
        MOVE.W  (A1)+,$C0AE.W                   ; $008BCC
        MOVE.W  (A1)+,$C0B0.W                   ; $008BD0
        MOVE.W  (A1),$C0B2.W                    ; $008BD4
        MOVE.W  $C8DC.W,D0                      ; $008BD8
        MOVE.W  D0,$C054.W                      ; $008BDC
        MOVE.W  D0,$C892.W                      ; $008BE0
        MOVE.W  #$0800,D0                       ; $008BE4
        MOVE.W  D0,$C056.W                      ; $008BE8
        MOVE.W  D0,$C894.W                      ; $008BEC
        RTS                                     ; $008BF0
        MOVE.W  #$0000,$C0BA.W                  ; $008BF2
        LEA     $C0C0.W,A1                      ; $008BF8
        MOVE.W  (A1)+,D0                        ; $008BFC
        MOVE.W  D0,$C054.W                      ; $008BFE
        MOVE.W  D0,$C892.W                      ; $008C02
        MOVE.W  (A1)+,$C0B0.W                   ; $008C06
        MOVE.W  (A1),D0                         ; $008C0A
        MOVE.W  D0,$C056.W                      ; $008C0C
        MOVE.W  D0,$C894.W                      ; $008C10
        RTS                                     ; $008C14
        MOVE.W  #$0000,$C0BA.W                  ; $008C16
        LEA     $C0C0.W,A1                      ; $008C1C
        MOVE.W  (A1)+,D0                        ; $008C20
        MOVE.W  D0,$C054.W                      ; $008C22
        MOVE.W  D0,$C892.W                      ; $008C26
        MOVE.W  (A1)+,$C0AE.W                   ; $008C2A
        MOVE.W  $C0BC.W,$C0B0.W                 ; $008C2E
        MOVE.W  (A1),D0                         ; $008C34
        MOVE.W  D0,$C056.W                      ; $008C36
        MOVE.W  D0,$C894.W                      ; $008C3A
        RTS                                     ; $008C3E
        MOVEQ   #$00,D0                         ; $008C40
        MOVE.W  D0,$C0BA.W                      ; $008C42
        MOVE.B  $C896.W,D0                      ; $008C46
        MOVE.W  $06(PC,D0.W),D0                 ; $008C4A
        JMP     $02(PC,D0.W)                    ; $008C4E
        ORI.B  #$005E,D6                        ; $008C52
        ORI.W  #$31FC,$00C0(PC)                 ; $008C56
        MULU    A0,D0                           ; $008C5C
        MOVE.W  #$0100,$00FF60CC                ; $008C5E
        MOVE.W  $C8DA.W,$C0AE.W                 ; $008C66
        MOVEQ   #$00,D0                         ; $008C6C
        MOVE.W  D0,$C0C6.W                      ; $008C6E
        MOVE.W  D0,$C0AE.W                      ; $008C72
        MOVE.W  D0,$C0B0.W                      ; $008C76
        MOVE.W  D0,$C0B2.W                      ; $008C7A
        MOVE.W  D0,$C086.W                      ; $008C7E
        MOVE.W  D0,$C88C.W                      ; $008C82
        MOVE.W  D0,$C88E.W                      ; $008C86
        MOVE.W  D0,$C890.W                      ; $008C8A
        MOVE.W  D0,$C8F6.W                      ; $008C8E
        MOVE.W  $C8DC.W,D0                      ; $008C92
        MOVE.W  D0,$C054.W                      ; $008C96
        MOVE.W  D0,$C892.W                      ; $008C9A
        MOVE.W  $C8DE.W,D0                      ; $008C9E
        MOVE.W  D0,$C056.W                      ; $008CA2
        MOVE.W  D0,$C894.W                      ; $008CA6
        ADDQ.B  #2,$C896.W                      ; $008CAA
        RTS                                     ; $008CAE
        ADDQ.W  #8,$C892.W                      ; $008CB0
        ADDQ.W  #8,$C894.W                      ; $008CB4
        MOVE.W  $C892.W,$C054.W                 ; $008CB8
        MOVE.W  $C894.W,$C056.W                 ; $008CBE
        MOVE.W  $C8F6.W,$C0C6.W                 ; $008CC4
        RTS                                     ; $008CCA
        RTS                                     ; $008CCC
        MOVE.B  $C896.W,D0                      ; $008CCE
        MOVE.W  $0C(PC,D0.W),D0                 ; $008CD2
        JSR     $08(PC,D0.W)                    ; $008CD6
        JMP     $00888DC0                       ; $008CDA
        DC.W    $0008                           ; $008CE0
        ORI.B  #$0032,-(A6)                     ; $008CE2
        ORI.W  #$31F8,-$46(A2,A4.W)             ; $008CE6
        MULU    $31F8.W,D4                      ; $008CEC
        AND.L  #$C89231F8,D0                    ; $008CF0
        AND.L  <EA:3E>,D0                       ; $008CF6
        AND.L  (A4),D4                          ; $008CF8
        MOVE.B  #$0005,$C8F6.W                  ; $008CFA
        ADDQ.B  #2,$C896.W                      ; $008D00
        RTS                                     ; $008D04
        SUBQ.B  #1,$C8F6.W                      ; $008D06
        BNE.S  loc_008D10                       ; $008D0A
        ADDQ.B  #2,$C896.W                      ; $008D0C
loc_008D10:
        RTS                                     ; $008D10
        CMPI.W  #$EC0A,$C894.W                  ; $008D12
        BGT.S  loc_008D38                       ; $008D18
        ADDI.W  #$0050,$C894.W                  ; $008D1A
        MOVE.W  $C894.W,$C0BE.W                 ; $008D20
        CMPI.W  #$E8E8,$C894.W                  ; $008D26
        BLE.S  loc_008D36                       ; $008D2C
        MOVE.W  $C894.W,$00FF3028               ; $008D2E
loc_008D36:
        RTS                                     ; $008D36
loc_008D38:
        MOVE.W  #$EC0A,$C894.W                  ; $008D38
        MOVE.W  $C894.W,$C0BE.W                 ; $008D3E
        MOVE.W  $C894.W,$00FF3028               ; $008D44
        ADDQ.B  #2,$C896.W                      ; $008D4C
        RTS                                     ; $008D50
        MOVE.W  $C894.W,$C0BE.W                 ; $008D52
        MOVE.W  $C894.W,$00FF3028               ; $008D58
        RTS                                     ; $008D60
        MOVE.W  $C0BA.W,D0                      ; $008D62
        MOVE.W  $C0BE.W,D1                      ; $008D66
        MOVE.W  $0030(A0),D2                    ; $008D6A
        MOVE.W  $0034(A0),D3                    ; $008D6E
        JSR     $00A7A0(PC)                     ; $008D72
        SUBI.W  #$4000,D0                       ; $008D76
        NEG.W  D0                               ; $008D7A
        MOVE.W  D0,$C0C2.W                      ; $008D7C
        JSR     loc_008F4E(PC)                  ; $008D80
        MOVE.W  $0030(A0),D2                    ; $008D84
        SUB.W  $C0BA.W,D2                       ; $008D88
        CMPI.W  #$C000,$C0C2.W                  ; $008D8C
        BNE.S  loc_008D96                       ; $008D92
        NEG.W  D2                               ; $008D94
loc_008D96:
        TST.W  D0                               ; $008D96
        BEQ.S  loc_008DA8                       ; $008D98
        MOVE.W  $0034(A0),D2                    ; $008D9A
        SUB.W  $C0BE.W,D2                       ; $008D9E
        EXT.L   D2                              ; $008DA2
        ASL.L  #8,D2                            ; $008DA4
        DIVS    D0,D2                           ; $008DA6
loc_008DA8:
        MOVE.W  $0032(A0),D3                    ; $008DA8
        SUB.W  $C0BC.W,D3                       ; $008DAC
        ASR.W  #4,D3                            ; $008DB0
        MOVE.W  D2,D2                           ; $008DB2
        JSR     $00A7A4(PC)                     ; $008DB4
        NEG.W  D0                               ; $008DB8
        MOVE.W  D0,$C0C0.W                      ; $008DBA
        RTS                                     ; $008DBE
        MOVE.W  $C0BA.W,D0                      ; $008DC0
        MOVE.W  $C0BE.W,D1                      ; $008DC4
        MOVE.W  $0030(A0),D2                    ; $008DC8
        MOVE.W  $0034(A0),D3                    ; $008DCC
        JSR     $00A7A0(PC)                     ; $008DD0
        SUBI.W  #$4000,D0                       ; $008DD4
        NEG.W  D0                               ; $008DD8
        TST.W  $C102.W                          ; $008DDA
        BEQ.S  loc_008E0E                       ; $008DDE
        MOVEQ   #$00,D3                         ; $008DE0
        TST.W  D0                               ; $008DE2
        BMI.S  loc_008DFE                       ; $008DE4
        MOVE.W  $C102.W,D3                      ; $008DE6
        BPL.S  loc_008E04                       ; $008DEA
loc_008DEC:
        CMPI.W  #$C000,D0                       ; $008DEC
        BCC.S  loc_008DF8                       ; $008DF0
        CMPI.W  #$4000,D0                       ; $008DF2
        BCC.S  loc_008E04                       ; $008DF6
loc_008DF8:
        ADD.W  D3,D0                            ; $008DF8
        ASR.W  #1,D0                            ; $008DFA
        BRA.S  loc_008E0E                       ; $008DFC
loc_008DFE:
        MOVE.W  $C102.W,D3                      ; $008DFE
        BPL.S  loc_008DEC                       ; $008E02
loc_008E04:
        ANDI.L  #$0000FFFF,D0                   ; $008E04
        ADD.L  D3,D0                            ; $008E0A
        ASR.L  #1,D0                            ; $008E0C
loc_008E0E:
        MOVE.W  D0,$C0C2.W                      ; $008E0E
        MOVE.W  D0,$C102.W                      ; $008E12
        CMPI.W  #$1000,D0                       ; $008E16
        BCS.S  loc_008E2E                       ; $008E1A
        CMPI.W  #$F000,D0                       ; $008E1C
        BCC.S  loc_008E2E                       ; $008E20
        CMPI.W  #$9000,D0                       ; $008E22
        BCC.S  loc_008E48                       ; $008E26
        CMPI.W  #$7000,D0                       ; $008E28
        BCS.S  loc_008E48                       ; $008E2C
loc_008E2E:
        JSR     loc_008F4E(PC)                  ; $008E2E
        MOVE.W  $0030(A0),D2                    ; $008E32
        SUB.W  $C0BA.W,D2                       ; $008E36
        TST.W  D0                               ; $008E3A
        BEQ.S  loc_008E66                       ; $008E3C
        MOVE.W  $0034(A0),D2                    ; $008E3E
        SUB.W  $C0BE.W,D2                       ; $008E42
        BRA.S  loc_008E60                       ; $008E46
loc_008E48:
        JSR     loc_008F52(PC)                  ; $008E48
        MOVE.W  $0034(A0),D2                    ; $008E4C
        SUB.W  $C0BE.W,D2                       ; $008E50
        TST.W  D0                               ; $008E54
        BEQ.S  loc_008E66                       ; $008E56
        MOVE.W  $0030(A0),D2                    ; $008E58
        SUB.W  $C0BA.W,D2                       ; $008E5C
loc_008E60:
        EXT.L   D2                              ; $008E60
        ASL.L  #8,D2                            ; $008E62
        DIVS    D0,D2                           ; $008E64
loc_008E66:
        MOVE.W  $0032(A0),D3                    ; $008E66
        SUB.W  $C0BC.W,D3                       ; $008E6A
        ASR.W  #4,D3                            ; $008E6E
        MOVE.W  D2,D2                           ; $008E70
        JSR     $00A7A4(PC)                     ; $008E72
        NEG.W  D0                               ; $008E76
        TST.W  $C100.W                          ; $008E78
        BEQ.S  loc_008EAC                       ; $008E7C
        MOVEQ   #$00,D3                         ; $008E7E
        TST.W  D0                               ; $008E80
        BMI.S  loc_008E9C                       ; $008E82
        MOVE.W  $C100.W,D3                      ; $008E84
        BPL.S  loc_008EA2                       ; $008E88
loc_008E8A:
        CMPI.W  #$C000,D0                       ; $008E8A
        BCC.S  loc_008E96                       ; $008E8E
        CMPI.W  #$4000,D0                       ; $008E90
        BCC.S  loc_008EA2                       ; $008E94
loc_008E96:
        ADD.W  D3,D0                            ; $008E96
        ASR.W  #1,D0                            ; $008E98
        BRA.S  loc_008EAC                       ; $008E9A
loc_008E9C:
        MOVE.W  $C100.W,D3                      ; $008E9C
        BPL.S  loc_008E8A                       ; $008EA0
loc_008EA2:
        ANDI.L  #$0000FFFF,D0                   ; $008EA2
        ADD.L  D3,D0                            ; $008EA8
        ASR.L  #1,D0                            ; $008EAA
loc_008EAC:
        MOVE.W  D0,$C0C0.W                      ; $008EAC
        MOVE.W  D0,$C100.W                      ; $008EB0
        RTS                                     ; $008EB4
        MOVE.W  $C0BA.W,D0                      ; $008EB6
        MOVE.W  $C0BE.W,D1                      ; $008EBA
        MOVE.W  $0030(A0),D2                    ; $008EBE
        MOVE.W  $0034(A0),D3                    ; $008EC2
        JSR     $00A7A0(PC)                     ; $008EC6
        SUBI.W  #$4000,D0                       ; $008ECA
        NEG.W  D0                               ; $008ECE
        MOVE.W  D0,$C0C2.W                      ; $008ED0
        RTS                                     ; $008ED4
        MOVE.W  $0032(A0),D3                    ; $008ED6
        SUB.W  $C0BC.W,D3                       ; $008EDA
        ASR.W  #4,D3                            ; $008EDE
        MOVE.W  $0034(A0),D2                    ; $008EE0
        SUB.W  $C0BE.W,D2                       ; $008EE4
        JSR     $00A7A4(PC)                     ; $008EE8
        NEG.W  D0                               ; $008EEC
        MOVE.W  D0,$C0C0.W                      ; $008EEE
        RTS                                     ; $008EF2
        MOVE.W  #$0000,$C0BA.W                  ; $008EF4
        RTS                                     ; $008EFA
        MOVE.W  $C0BA.W,D0                      ; $008EFC
        MOVE.W  $C0BE.W,D1                      ; $008F00
        MOVE.W  $0030(A0),D2                    ; $008F04
        MOVE.W  $0034(A0),D3                    ; $008F08
        JSR     $00A7A0(PC)                     ; $008F0C
        SUBI.W  #$4000,D0                       ; $008F10
        NEG.W  D0                               ; $008F14
        MOVE.W  D0,D3                           ; $008F16
        JSR     loc_008F4E(PC)                  ; $008F18
        MOVE.W  $0030(A0),D2                    ; $008F1C
        SUB.W  $C0BA.W,D2                       ; $008F20
        CMPI.W  #$C000,D3                       ; $008F24
        BNE.S  loc_008F2C                       ; $008F28
        NEG.W  D2                               ; $008F2A
loc_008F2C:
        TST.W  D0                               ; $008F2C
        BEQ.S  loc_008F4C                       ; $008F2E
        MOVE.W  $0034(A0),D2                    ; $008F30
        SUB.W  $C0BE.W,D2                       ; $008F34
        EXT.L   D2                              ; $008F38
        ASL.L  #8,D2                            ; $008F3A
        DIVS    D0,D2                           ; $008F3C
        BMI.S  loc_008F4C                       ; $008F3E
        MOVE.W  $00FF5000,D3                    ; $008F40
        MULU    D3,D2                           ; $008F46
        MOVE.W  D2,$C0C6.W                      ; $008F48
loc_008F4C:
        RTS                                     ; $008F4C
loc_008F4E:
        ADDI.W  #$4000,D0                       ; $008F4E
loc_008F52:
        MOVEQ   #$00,D1                         ; $008F52
        MOVE.W  D0,D1                           ; $008F54
        LSR.W  #6,D0                            ; $008F56
        LSL.L  #2,D1                            ; $008F58
        SWAP    D1                              ; $008F5A
        ADD.W  D1,D1                            ; $008F5C
        ADD.W  D1,D1                            ; $008F5E
        MOVEA.L $04(PC,D1.W),A1                 ; $008F60
        JMP     (A1)                            ; $008F64
        DC.W    $0088                           ; $008F66
        OR.W   D7,$0088(PC)                     ; $008F68
        OR.L   D7,A0                            ; $008F6C
        DC.W    $0088                           ; $008F6E
        OR.L   D7,(A4)+                         ; $008F70
        DC.W    $0088                           ; $008F72
        OR.L   D7,-$78(A0,D0.W)                 ; $008F74
        DIVS    D6,D7                           ; $008F78
        LEA     $00930000,A1                    ; $008F7A
        ADD.W  D0,D0                            ; $008F80
        MOVE.W  $00(A1,D0.W),D0                 ; $008F82
        RTS                                     ; $008F86
        LEA     $00930000,A1                    ; $008F88
        SUBI.W  #$0200,D0                       ; $008F8E
        NEG.W  D0                               ; $008F92
        ADD.W  D0,D0                            ; $008F94
        MOVE.W  $00(A1,D0.W),D0                 ; $008F96
        RTS                                     ; $008F9A
        LEA     $00930000,A1                    ; $008F9C
        SUBI.W  #$0200,D0                       ; $008FA2
        ADD.W  D0,D0                            ; $008FA6
        MOVE.W  $00(A1,D0.W),D0                 ; $008FA8
        NEG.W  D0                               ; $008FAC
        RTS                                     ; $008FAE
        LEA     $00930000,A1                    ; $008FB0
        SUBI.W  #$0400,D0                       ; $008FB6
        NEG.W  D0                               ; $008FBA
        ADD.W  D0,D0                            ; $008FBC
        MOVE.W  $00(A1,D0.W),D0                 ; $008FBE
        NEG.W  D0                               ; $008FC2
        RTS                                     ; $008FC4
        RTS                                     ; $008FC6
        MOVE.L  D0,D1                           ; $008FC8
        BPL.S  loc_008FCE                       ; $008FCA
        NEG.L  D1                               ; $008FCC
loc_008FCE:
        CMPI.L  #$00000400,D1                   ; $008FCE
        BGE.S  loc_008FEA                       ; $008FD4
        ANDI.B  #$00FC,D1                       ; $008FD6
        ASR.L  #1,D1                            ; $008FDA
        LEA     $00930202,A1                    ; $008FDC
        MOVE.W  $00(A1,D1.L),D1                 ; $008FE2
        EXT.L   D1                              ; $008FE6
        BRA.S  loc_009034                       ; $008FE8
loc_008FEA:
        CMPI.L  #$00000D8F,D1                   ; $008FEA
        BGE.S  loc_00900C                       ; $008FF0
        SUBI.L  #$00000400,D1                   ; $008FF2
        ANDI.B  #$00F0,D1                       ; $008FF8
        ASR.L  #3,D1                            ; $008FFC
        LEA     $00930402,A1                    ; $008FFE
        MOVE.W  $00(A1,D1.L),D1                 ; $009004
        EXT.L   D1                              ; $009008
        BRA.S  loc_009034                       ; $00900A
loc_00900C:
        CMPI.L  #$0000517C,D1                   ; $00900C
        BGE.S  loc_009020                       ; $009012
        MOVEQ   #$0B,D2                         ; $009014
        ASR.L  D2,D1                            ; $009016
        ADDI.L  #$000000F4,D1                   ; $009018
        BRA.S  loc_009034                       ; $00901E
loc_009020:
        MOVE.L  #$000000FE,D1                   ; $009020
        CMPI.L  #$0000A2F8,D1                   ; $009026
        BLT.S  loc_009034                       ; $00902C
        MOVE.L  #$00000100,D1                   ; $00902E
loc_009034:
        TST.L  D0                               ; $009034
        BPL.S  loc_00903A                       ; $009036
        NEG.L  D1                               ; $009038
loc_00903A:
        ASL.L  #6,D1                            ; $00903A
        MOVE.W  D1,D0                           ; $00903C
        RTS                                     ; $00903E
        MOVE.W  $903C.W,D0                      ; $009040
        ADD.W  $9096.W,D0                       ; $009044
        TST.W  $C04C.W                          ; $009048
        BEQ.S  loc_009052                       ; $00904C
        SUB.W  $9046.W,D0                       ; $00904E
loc_009052:
        ASR.W  #6,D0                            ; $009052
        BTST    #7,$FDA8.W                      ; $009054
        BEQ.S  loc_00905E                       ; $00905A
        NEG.W  D0                               ; $00905C
loc_00905E:
        MOVE.W  D0,$8002.W                      ; $00905E
        RTS                                     ; $009062
        BTST    #3,$C313.W                      ; $009064
        BNE.S  loc_00909C                       ; $00906A
        MOVE.W  $00CC(A0),D0                    ; $00906C
        ASR.W  #6,D0                            ; $009070
        MOVE.W  D0,$8002.W                      ; $009072
        MOVE.W  $00FF6108,D0                    ; $009076
        ASR.W  #8,D0                            ; $00907C
        CMPI.W  #$FFF8,D0                       ; $00907E
        BGE.S  loc_009086                       ; $009082
        MOVEQ   #-$08,D0                        ; $009084
loc_009086:
        CMPI.W  #$0010,D0                       ; $009086
        BLE.S  loc_00908E                       ; $00908A
        MOVEQ   #$10,D0                         ; $00908C
loc_00908E:
        SUBQ.W  #8,D0                           ; $00908E
        MOVE.W  D0,$C882.W                      ; $009090
        MOVE.W  #$FEC0,$8000.W                  ; $009094
        RTS                                     ; $00909A
loc_00909C:
        MOVE.W  #$0000,$8000.W                  ; $00909C
        RTS                                     ; $0090A2
        MOVE.W  $C0B0.W,D0                      ; $0090A4
        ASL.W  #3,D0                            ; $0090A8
        ADD.W  $903C.W,D0                       ; $0090AA
        ADD.W  $9096.W,D0                       ; $0090AE
        TST.W  $C04C.W                          ; $0090B2
        BEQ.S  loc_0090BC                       ; $0090B6
        SUB.W  $9046.W,D0                       ; $0090B8
loc_0090BC:
        ASR.W  #6,D0                            ; $0090BC
        BTST    #7,$FDA8.W                      ; $0090BE
        BEQ.S  loc_0090C8                       ; $0090C4
        NEG.W  D0                               ; $0090C6
loc_0090C8:
        MOVE.W  D0,$8002.W                      ; $0090C8
        RTS                                     ; $0090CC
        MOVEQ   #$00,D0                         ; $0090CE
        MOVE.W  $003C(A0),D0                    ; $0090D0
        ADD.W  $0096(A0),D0                     ; $0090D4
        TST.W  $C04C.W                          ; $0090D8
        BEQ.S  loc_0090E2                       ; $0090DC
        SUB.W  $0046(A0),D0                     ; $0090DE
loc_0090E2:
        ASR.W  #6,D0                            ; $0090E2
        MOVE.L  D0,D1                           ; $0090E4
        MOVE.L  D0,D2                           ; $0090E6
        MOVE.L  D0,D3                           ; $0090E8
        MOVE.L  D0,D4                           ; $0090EA
        MOVE.L  D0,D5                           ; $0090EC
        MOVE.L  D0,D6                           ; $0090EE
        MOVE.L  D0,D7                           ; $0090F0
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,(A1)    ; $0090F2
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $0090F6
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $0090FA
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $0090FE
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $009102
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $009106
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $00910A
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $00910E
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $009112
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $009116
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $00911A
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A1)   ; $00911E
        RTS                                     ; $009122
        MOVEA.W $C8C0.W,A1                      ; $009124
        CMPI.L  #$00000000,$EEDC.W              ; $009128
        BEQ.S  loc_00914A                       ; $009130
        MOVEA.L A1,A2                           ; $009132
        MOVE.W  #$0253,D7                       ; $009134
        MOVE.L  #$7FFF0000,D0                   ; $009138
loc_00913E:
        MOVE.L  D0,(A2)+                        ; $00913E
        MOVE.L  D0,(A2)+                        ; $009140
        MOVE.L  D0,(A2)+                        ; $009142
        MOVE.L  D0,(A2)+                        ; $009144
        DBRA    D7,loc_00913E                   ; $009146
loc_00914A:
        MOVE.W  $001C(A0),D0                    ; $00914A
        LSL.W  #3,D0                            ; $00914E
        LEA     $00(A1,D0.W),A1                 ; $009150
        MOVE.W  $0004(A1),D0                    ; $009154
        ADD.W  $0006(A1),D0                     ; $009158
        BPL.S  loc_009160                       ; $00915C
        NEG.W  D0                               ; $00915E
loc_009160:
        MOVE.W  $0072(A0),D1                    ; $009160
        ADD.W  $00E2(A0),D1                     ; $009164
        BPL.S  loc_00916C                       ; $009168
        NEG.W  D1                               ; $00916A
loc_00916C:
        CMP.W  D0,D1                            ; $00916C
        BGE.S  loc_009180                       ; $00916E
        MOVE.W  $0030(A0),(A1)+                 ; $009170
        MOVE.W  $0034(A0),(A1)+                 ; $009174
        MOVE.W  $0072(A0),(A1)+                 ; $009178
        MOVE.W  $0072(A0),(A1)                  ; $00917C
loc_009180:
        RTS                                     ; $009180
        MOVE.W  $008C(A0),D1                    ; $009182
        ADD.W  $006A(A0),D1                     ; $009186
        BNE.W  loc_009300                       ; $00918A
        TST.B  $C30F.W                          ; $00918E
        BEQ.W  loc_009254                       ; $009192
        MOVE.W  $00AE(A0),D0                    ; $009196
        ADD.W  D0,D0                            ; $00919A
        LEA     $C05C.W,A1                      ; $00919C
        CMPI.W  #$0001,$00(A1,D0.W)             ; $0091A0
        BEQ.W  loc_009254                       ; $0091A6
        BTST    #1,$C973.W                      ; $0091AA
        BEQ.S  loc_0091FE                       ; $0091B0
        MOVE.W  $007A(A0),D2                    ; $0091B2
        CMPI.W  #$0006,D2                       ; $0091B6
        BGE.W  loc_0092DE                       ; $0091BA
        MOVE.W  $0074(A0),D1                    ; $0091BE
        LEA     $0088A1F0,A1                    ; $0091C2
        ADD.W  D2,D2                            ; $0091C8
        MULS    $00(A1,D2.W),D1                 ; $0091CA
        LSR.L  #8,D1                            ; $0091CE
        MOVE.W  D1,$0074(A0)                    ; $0091D0
        ADDQ.W  #1,$007A(A0)                    ; $0091D4
        CMPI.W  #$1F40,$0074(A0)                ; $0091D8
        BLT.S  loc_0091FA                       ; $0091DE
        CMPI.W  #$0004,$007A(A0)                ; $0091E0
        BGE.S  loc_0091FA                       ; $0091E6
        TST.W  $0082(A0)                        ; $0091E8
        BNE.S  loc_0091FA                       ; $0091EC
        MOVE.W  #$000F,$0082(A0)                ; $0091EE
        MOVE.B  #$00B4,$C8A4.W                  ; $0091F4
loc_0091FA:
        BRA.W  loc_0092DE                       ; $0091FA
loc_0091FE:
        BTST    #0,$C973.W                      ; $0091FE
        BEQ.W  loc_0092DE                       ; $009204
        TST.W  $007A(A0)                        ; $009208
        BLE.W  loc_0092DE                       ; $00920C
        SUBQ.W  #1,$007A(A0)                    ; $009210
        MOVE.W  $0074(A0),D1                    ; $009214
        EXT.L   D1                              ; $009218
        LSL.L  #8,D1                            ; $00921A
        LEA     $0088A1F0,A1                    ; $00921C
        MOVE.W  $007A(A0),D2                    ; $009222
        ADD.W  D2,D2                            ; $009226
        DIVU    $00(A1,D2.W),D1                 ; $009228
        MOVE.W  D1,$0074(A0)                    ; $00922C
        CMPI.W  #$4268,D1                       ; $009230
        BLE.W  loc_0092DE                       ; $009234
        MOVE.W  #$4268,$0074(A0)                ; $009238
        TST.W  $0084(A0)                        ; $00923E
        BNE.S  loc_00924A                       ; $009242
        MOVE.W  #$000A,$0084(A0)                ; $009244
loc_00924A:
        MOVE.W  #$00FF,$0010(A0)                ; $00924A
        BRA.W  loc_0092DE                       ; $009250
loc_009254:
        MOVE.W  $0074(A0),D2                    ; $009254
        MOVE.W  $007A(A0),D1                    ; $009258
        ADD.W  D1,D1                            ; $00925C
        TST.W  $0004(A0)                        ; $00925E
        BEQ.W  loc_0092AE                       ; $009262
        LEA     $0088A1E2,A1                    ; $009266
        CMP.W  $00(A1,D1.W),D2                  ; $00926C
        BLE.W  loc_0092AE                       ; $009270
        LEA     $0088A1F0,A1                    ; $009274
        MULS    $00(A1,D1.W),D2                 ; $00927A
        LSR.L  #8,D2                            ; $00927E
        MOVE.W  D2,$0074(A0)                    ; $009280
        ADDQ.W  #1,$007A(A0)                    ; $009284
        CMPI.W  #$1F40,$0074(A0)                ; $009288
        BLT.S  loc_0092AA                       ; $00928E
        CMPI.W  #$0004,$007A(A0)                ; $009290
        BGE.S  loc_0092AA                       ; $009296
        TST.W  $0082(A0)                        ; $009298
        BNE.S  loc_0092AA                       ; $00929C
        MOVE.W  #$000F,$0082(A0)                ; $00929E
        MOVE.B  #$00B4,$C8A4.W                  ; $0092A4
loc_0092AA:
        BRA.W  loc_0092DE                       ; $0092AA
loc_0092AE:
        LEA     $00939EDE,A1                    ; $0092AE
        CMP.W  $00(A1,D1.W),D2                  ; $0092B4
        BGE.W  loc_0092DE                       ; $0092B8
        SUBQ.W  #1,$007A(A0)                    ; $0092BC
        EXT.L   D2                              ; $0092C0
        LSL.L  #8,D2                            ; $0092C2
        LEA     $0088A1F0,A1                    ; $0092C4
        DIVS    -$02(A1,D1.W),D2                ; $0092CA
        MOVE.W  D2,$0074(A0)                    ; $0092CE
        TST.W  $0084(A0)                        ; $0092D2
        BNE.S  loc_0092DE                       ; $0092D6
        MOVE.W  #$000A,$0084(A0)                ; $0092D8
loc_0092DE:
        MOVE.W  $0074(A0),D1                    ; $0092DE
        SUB.W  $007E(A0),D1                     ; $0092E2
        CMPI.W  #$0400,D1                       ; $0092E6
        BLE.S  loc_0092F0                       ; $0092EA
        MOVE.W  #$0400,D1                       ; $0092EC
loc_0092F0:
        CMPI.W  #$FC00,D1                       ; $0092F0
        BGE.S  loc_0092FA                       ; $0092F4
        MOVE.W  #$FC00,D1                       ; $0092F6
loc_0092FA:
        ADD.W  D1,$007E(A0)                     ; $0092FA
        RTS                                     ; $0092FE
loc_009300:
        MOVE.W  #$FFCD,$000E(A0)                ; $009300
        MOVE.W  $0074(A0),D2                    ; $009306
        MOVE.W  $007A(A0),D1                    ; $00930A
        ADD.W  D1,D1                            ; $00930E
        BRA.S  loc_0092AE                       ; $009310
        MOVE.W  $0074(A0),D1                    ; $009312
        BGE.S  loc_00931C                       ; $009316
        MOVEQ   #$00,D1                         ; $009318
        BRA.S  loc_009326                       ; $00931A
loc_00931C:
        CMPI.W  #$4268,D1                       ; $00931C
        BLE.S  loc_009326                       ; $009320
        MOVE.W  #$4268,D1                       ; $009322
loc_009326:
        ASR.W  #7,D1                            ; $009326
        LEA     $0093910E,A1                    ; $009328
        TST.B  $C30F.W                          ; $00932E
        BNE.S  loc_00933A                       ; $009332
        LEA     $00938FCE,A1                    ; $009334
loc_00933A:
        ADD.W  D1,D1                            ; $00933A
        MOVE.W  $00(A1,D1.W),D2                 ; $00933C
        MOVEA.L $C278.W,A2                      ; $009340
        MOVE.W  $007A(A0),D3                    ; $009344
        ADD.W  D3,D3                            ; $009348
        MULU    $00(A2,D3.W),D2                 ; $00934A
        LSR.L  #5,D2                            ; $00934E
        MULS    $000E(A0),D2                    ; $009350
        ASR.L  #7,D2                            ; $009354
        BGT.S  loc_009364                       ; $009356
        MOVE.L  #$FFFFFE00,D0                   ; $009358
        CMP.L  D0,D2                            ; $00935E
        BLT.S  loc_009364                       ; $009360
        MOVE.L  D0,D2                           ; $009362
loc_009364:
        JSR     loc_009458(PC)                  ; $009364
        MOVE.W  $0016(A0),D1                    ; $009368
        EXT.L   D1                              ; $00936C
        LSL.L  #4,D1                            ; $00936E
        SUB.L  D1,D2                            ; $009370
        MOVE.W  $0010(A0),D1                    ; $009372
        MULS    #$71C0,D1                       ; $009376
        ASR.L  #7,D1                            ; $00937A
        SUB.L  D1,D2                            ; $00937C
        BPL.S  loc_009382                       ; $00937E
        ADD.L  D2,D2                            ; $009380
loc_009382:
        MOVE.W  #$0100,$0078(A0)                ; $009382
        MOVE.W  $C0EC.W,D0                      ; $009388
        NEG.W  D0                               ; $00938C
        EXT.L   D0                              ; $00938E
        CMP.L  D0,D2                            ; $009390
        BGT.S  loc_0093C0                       ; $009392
        MOVE.L  D0,D1                           ; $009394
        ADD.L  D1,D1                            ; $009396
        CMP.L  D1,D2                            ; $009398
        BGT.S  loc_0093BC                       ; $00939A
        MOVE.W  $0080(A0),D1                    ; $00939C
        OR.W   $008C(A0),D1                     ; $0093A0
        BNE.S  loc_0093BC                       ; $0093A4
        CMPI.W  #$0014,$0004(A0)                ; $0093A6
        BLE.W  loc_0093BC                       ; $0093AC
        MOVE.W  #$000F,$0080(A0)                ; $0093B0
        MOVE.B  #$00B1,$C8A4.W                  ; $0093B6
loc_0093BC:
        MOVE.L  D0,D2                           ; $0093BC
        BRA.S  loc_0093FC                       ; $0093BE
loc_0093C0:
        MOVEQ   #$00,D0                         ; $0093C0
        MOVE.W  $C0EA.W,D0                      ; $0093C2
        CMP.L  D0,D2                            ; $0093C6
        BLE.W  loc_0093FC                       ; $0093C8
        MOVE.L  D2,D1                           ; $0093CC
        SUB.L  D0,D1                            ; $0093CE
        ASL.L  #8,D1                            ; $0093D0
        DIVS    D0,D1                           ; $0093D2
        SUB.W  D1,$0078(A0)                     ; $0093D4
        CMPI.W  #$0080,D1                       ; $0093D8
        BLE.S  loc_0093E4                       ; $0093DC
        MOVE.W  #$0080,$0078(A0)                ; $0093DE
loc_0093E4:
        TST.W  $007A(A0)                        ; $0093E4
        BNE.S  loc_0093FC                       ; $0093E8
        TST.W  $0082(A0)                        ; $0093EA
        BNE.S  loc_0093FC                       ; $0093EE
        MOVE.W  #$000F,$0082(A0)                ; $0093F0
        MOVE.B  #$00B4,$C8A4.W                  ; $0093F6
loc_0093FC:
        ASR.L  #1,D2                            ; $0093FC
        MULS    $0078(A0),D2                    ; $0093FE
        ASR.L  #7,D2                            ; $009402
        MOVE.W  D2,D1                           ; $009404
        ASR.W  #2,D1                            ; $009406
        EXT.L   D1                              ; $009408
        DIVS    #$0190,D1                       ; $00940A
        MOVE.W  D1,$000C(A0)                    ; $00940E
        ADD.W  D1,$0006(A0)                     ; $009412
        BPL.S  loc_00941C                       ; $009416
        CLR.W  $0006(A0)                        ; $009418
loc_00941C:
        MOVEA.L $C278.W,A1                      ; $00941C
        MOVE.W  $007A(A0),D1                    ; $009420
        ADD.W  D1,D1                            ; $009424
        MOVE.W  $00(A1,D1.W),D3                 ; $009426
        MULS    $0006(A0),D3                    ; $00942A
        ASL.L  #2,D3                            ; $00942E
        MOVE.L  D3,D1                           ; $009430
        ASL.L  #2,D3                            ; $009432
        ADD.L  D3,D1                            ; $009434
        ASL.L  #2,D3                            ; $009436
        ADD.L  D3,D1                            ; $009438
        ASL.L  #3,D3                            ; $00943A
        ADD.L  D1,D3                            ; $00943C
        MOVEQ   #$0C,D1                         ; $00943E
        LSR.L  D1,D3                            ; $009440
        BGE.S  loc_009446                       ; $009442
        MOVEQ   #$00,D3                         ; $009444
loc_009446:
        CMPI.L  #$00004268,D3                   ; $009446
        BLE.S  loc_009452                       ; $00944C
        MOVE.W  #$4268,D3                       ; $00944E
loc_009452:
        MOVE.W  D3,$0074(A0)                    ; $009452
        RTS                                     ; $009456
loc_009458:
        MOVEM.L D0/A1,-(A7)                     ; $009458
        MOVEA.L $C27C.W,A1                      ; $00945C
        MOVE.W  $0004(A0),D0                    ; $009460
        ADD.W  D0,D0                            ; $009464
        MOVE.W  $00(A1,D0.W),D0                 ; $009466
        MULS    $C0E6.W,D0                      ; $00946A
        ASR.L  #8,D0                            ; $00946E
        MOVE.W  D0,$0016(A0)                    ; $009470
        TST.B  $C826.W                          ; $009474
        BEQ.S  loc_00948A                       ; $009478
        MOVEQ   #$10,D0                         ; $00947A
        ADD.W  $008A(A0),D0                     ; $00947C
        MULS    $0016(A0),D0                    ; $009480
        ASR.L  #4,D0                            ; $009484
        MOVE.W  D0,$0016(A0)                    ; $009486
loc_00948A:
        MOVE.W  $0016(A0),D0                    ; $00948A
        CMPI.W  #$0004,$00A8(A0)                ; $00948E
        BLE.S  loc_0094A6                       ; $009494
        MOVE.W  D0,D1                           ; $009496
        ADD.W  D0,D0                            ; $009498
        ADD.W  D0,D0                            ; $00949A
        ADD.W  D1,D0                            ; $00949C
        ADD.W  D0,D0                            ; $00949E
        ADD.W  D1,D0                            ; $0094A0
        ASR.W  #4,D0                            ; $0094A2
        BRA.S  loc_0094BC                       ; $0094A4
loc_0094A6:
        TST.W  $00A8(A0)                        ; $0094A6
        BEQ.S  loc_0094BC                       ; $0094AA
        MOVE.W  $0006(A0),D1                    ; $0094AC
        CMP.W  $000A(A0),D1                     ; $0094B0
        BLE.S  loc_0094BC                       ; $0094B4
        MOVE.W  D0,D1                           ; $0094B6
        ASR.W  #1,D1                            ; $0094B8
        ADD.W  D1,D0                            ; $0094BA
loc_0094BC:
        MOVE.W  D0,$0016(A0)                    ; $0094BC
        JSR     loc_009B32(PC)                  ; $0094C0
        ADD.W  D0,$0016(A0)                     ; $0094C4
        TST.B  $C31B.W                          ; $0094C8
        BEQ.S  loc_0094DE                       ; $0094CC
        MOVE.W  $0016(A0),D0                    ; $0094CE
        ASR.W  #1,D0                            ; $0094D2
        MOVE.W  D0,D1                           ; $0094D4
        ASR.W  #1,D1                            ; $0094D6
        ADD.W  D1,D0                            ; $0094D8
        ADD.W  D0,$0016(A0)                     ; $0094DA
loc_0094DE:
        TST.W  $0014(A0)                        ; $0094DE
        BLE.S  loc_0094EE                       ; $0094E2
        SUBQ.W  #1,$0014(A0)                    ; $0094E4
        ADDI.W  #$0738,$0016(A0)                ; $0094E8
loc_0094EE:
        MOVEM.L (A7)+,D0/A1                     ; $0094EE
        RTS                                     ; $0094F2
        DC.W    $FFE8                           ; $0094F4
        ORI.B  #$0018,D0                        ; $0094F6
        MOVE.B  $C300.W,$C301.W                 ; $0094FA
        MOVE.B  $C971.W,$C300.W                 ; $009500
        MOVEQ   #$02,D2                         ; $009506
        MOVEQ   #$03,D3                         ; $009508
        BTST    #7,$FDA8.W                      ; $00950A
        BEQ.S  loc_009514                       ; $009510
        AND.W  D2,D3                            ; $009512
loc_009514:
        LEA     $C300.W,A1                      ; $009514
        MOVEQ   #$00,D0                         ; $009518
        MOVEQ   #$00,D1                         ; $00951A
        BTST    D2,$0001(A1)                    ; $00951C
        BEQ.S  loc_009524                       ; $009520
        MOVEQ   #$01,D0                         ; $009522
loc_009524:
        BTST    D3,$0001(A1)                    ; $009524
        BEQ.S  loc_00952C                       ; $009528
        SUBQ.W  #1,D0                           ; $00952A
loc_00952C:
        BTST    D2,(A1)                         ; $00952C
        BEQ.S  loc_009532                       ; $00952E
        MOVEQ   #$01,D1                         ; $009530
loc_009532:
        BTST    D3,(A1)                         ; $009532
        BEQ.S  loc_009538                       ; $009534
        SUBQ.W  #1,D1                           ; $009536
loc_009538:
        LEA     -$0044(PC),A1                   ; $009538
        CMP.W  $C006.W,D1                       ; $00953C
        BEQ.S  loc_00955A                       ; $009540
        MOVE.W  D1,$C006.W                      ; $009542
        MOVE.W  D1,D2                           ; $009546
        ADD.W  D2,D2                            ; $009548
        MOVE.W  $00(A1,D2.W),D2                 ; $00954A
        MOVE.W  D2,$C000.W                      ; $00954E
        LSL.W  #8,D2                            ; $009552
        MOVE.W  D2,$008E(A0)                    ; $009554
        BRA.S  loc_0095A0                       ; $009558
loc_00955A:
        TST.W  D1                               ; $00955A
        BNE.S  loc_009576                       ; $00955C
        MOVE.W  $C000.W,D2                      ; $00955E
        BEQ.S  loc_00956C                       ; $009562
        BPL.S  loc_00956A                       ; $009564
        MOVEQ   #-$02,D2                        ; $009566
        BRA.S  loc_00956C                       ; $009568
loc_00956A:
        MOVEQ   #$02,D2                         ; $00956A
loc_00956C:
        MOVE.W  $00(A1,D2.W),D2                 ; $00956C
        SUB.W  D2,$C000.W                       ; $009570
        BRA.S  loc_0095A0                       ; $009574
loc_009576:
        MOVE.W  D1,$C006.W                      ; $009576
        MOVE.W  D1,D2                           ; $00957A
        ADD.W  D2,D2                            ; $00957C
        MOVE.W  $00(A1,D2.W),D2                 ; $00957E
        TST.W  $C8C8.W                          ; $009582
        BEQ.S  loc_00959C                       ; $009586
        MOVE.W  $0094(A0),D0                    ; $009588
        EOR.W  D2,D0                            ; $00958C
        BMI.S  loc_00959C                       ; $00958E
        ASR.W  #1,D2                            ; $009590
        MOVE.W  $0094(A0),D0                    ; $009592
        ASR.W  #3,D0                            ; $009596
        SUB.W  D0,$0094(A0)                     ; $009598
loc_00959C:
        ADD.W  D2,$C000.W                       ; $00959C
loc_0095A0:
        CMPI.W  #$007F,$C000.W                  ; $0095A0
        BLE.S  loc_0095AE                       ; $0095A6
        MOVE.W  #$007F,$C000.W                  ; $0095A8
loc_0095AE:
        CMPI.W  #$FF81,$C000.W                  ; $0095AE
        BGE.S  loc_0095BC                       ; $0095B4
        MOVE.W  #$FF81,$C000.W                  ; $0095B6
loc_0095BC:
        MOVE.W  $C000.W,D2                      ; $0095BC
        MOVE.W  D2,D0                           ; $0095C0
        BPL.S  loc_0095C8                       ; $0095C2
        NEG.W  D0                               ; $0095C4
        BVC.S  loc_0095D2                       ; $0095C6
loc_0095C8:
        CMPI.W  #$0018,D0                       ; $0095C8
        BGE.S  loc_0095D2                       ; $0095CC
        CLR.W  $C000.W                          ; $0095CE
loc_0095D2:
        EXT.L   D2                              ; $0095D2
        LSL.L  #8,D2                            ; $0095D4
        MOVE.W  $008E(A0),D1                    ; $0095D6
        EXT.L   D1                              ; $0095DA
        ADD.L  D1,D2                            ; $0095DC
        ASR.L  #1,D2                            ; $0095DE
        MOVE.L  D2,D3                           ; $0095E0
        SUB.L  D1,D3                            ; $0095E2
        TST.W  D3                               ; $0095E4
        BPL.S  loc_0095EA                       ; $0095E6
        NEG.W  D3                               ; $0095E8
loc_0095EA:
        ASR.W  #8,D3                            ; $0095EA
        ADD.W  $00AA(A0),D3                     ; $0095EC
        CMPI.W  #$00C8,D3                       ; $0095F0
        BLE.S  loc_0095FA                       ; $0095F4
        MOVE.W  #$00C8,D3                       ; $0095F6
loc_0095FA:
        CMPI.W  #$0000,D3                       ; $0095FA
        BGE.S  loc_009604                       ; $0095FE
        MOVE.W  #$0000,D3                       ; $009600
loc_009604:
        MOVE.W  D3,$00AA(A0)                    ; $009604
        MOVE.W  D2,D1                           ; $009608
        BPL.S  loc_009610                       ; $00960A
        NEG.W  D1                               ; $00960C
        BVS.S  loc_009618                       ; $00960E
loc_009610:
        CMPI.W  #$0018,D1                       ; $009610
        BGE.S  loc_009618                       ; $009614
        MOVEQ   #$00,D2                         ; $009616
loc_009618:
        MOVE.W  D2,$008E(A0)                    ; $009618
        RTS                                     ; $00961C
        MOVE.W  $006A(A0),D0                    ; $00961E
        OR.W   $008C(A0),D0                     ; $009622
        BNE.S  loc_009686                       ; $009626
        MOVEQ   #$30,D0                         ; $009628
        MOVE.W  $C0AC.W,D1                      ; $00962A
        CMP.W  $0092(A0),D1                     ; $00962E
        BLT.S  loc_00963C                       ; $009632
        BTST    #4,$C971.W                      ; $009634
        BNE.S  loc_00963E                       ; $00963A
loc_00963C:
        NEG.W  D0                               ; $00963C
loc_00963E:
        MOVE.W  $000E(A0),D1                    ; $00963E
        ADD.W  D0,D1                            ; $009642
        CMPI.W  #$00FF,D1                       ; $009644
        BLE.S  loc_00964E                       ; $009648
        MOVE.W  #$00FF,D1                       ; $00964A
loc_00964E:
        CMPI.W  #$FFCD,D1                       ; $00964E
        BGE.S  loc_009658                       ; $009652
        MOVE.W  #$FFCD,D1                       ; $009654
loc_009658:
        MOVE.W  D1,$000E(A0)                    ; $009658
        MOVEQ   #$30,D0                         ; $00965C
        BTST    #6,$C971.W                      ; $00965E
        BNE.S  loc_009668                       ; $009664
        NEG.W  D0                               ; $009666
loc_009668:
        MOVE.W  $0010(A0),D1                    ; $009668
        ADD.W  D0,D1                            ; $00966C
        CMPI.W  #$00FF,D1                       ; $00966E
        BLE.S  loc_009678                       ; $009672
        MOVE.W  #$00FF,D1                       ; $009674
loc_009678:
        CMPI.W  #$0000,D1                       ; $009678
        BGE.S  loc_009682                       ; $00967C
        MOVE.W  #$0000,D1                       ; $00967E
loc_009682:
        MOVE.W  D1,$0010(A0)                    ; $009682
loc_009686:
        RTS                                     ; $009686
        MOVE.W  $008E(A0),D0                    ; $009688
        ASR.W  #4,D0                            ; $00968C
        MOVE.W  #$0497,D1                       ; $00968E
        SUB.W  $0006(A0),D1                     ; $009692
        MULS    D0,D1                           ; $009696
        DIVS    #$0497,D1                       ; $009698
        ADD.W  D1,D0                            ; $00969C
        MOVE.W  D0,$0090(A0)                    ; $00969E
        CMPI.W  #$0080,$0004(A0)                ; $0096A2
        BGE.S  loc_0096C6                       ; $0096A8
        MOVE.W  D0,D2                           ; $0096AA
        MOVE.W  $0004(A0),D0                    ; $0096AC
        LSL.W  #7,D0                            ; $0096B0
        ADDI.W  #$8000,D0                       ; $0096B2
        JSR     loc_008F52(PC)                  ; $0096B6
        ADDI.W  #$0100,D0                       ; $0096BA
        MULS    $0090(A0),D0                    ; $0096BE
        ASR.L  #6,D0                            ; $0096C2
        ADD.W  D2,D0                            ; $0096C4
loc_0096C6:
        MULS    $0004(A0),D0                    ; $0096C6
        MOVEQ   #$0A,D2                         ; $0096CA
        ASR.L  D2,D0                            ; $0096CC
        MOVE.W  $0076(A0),D2                    ; $0096CE
        MOVE.W  $000C(A0),D3                    ; $0096D2
        BPL.S  loc_0096DC                       ; $0096D6
        ADD.W  D3,D3                            ; $0096D8
        SUB.W  D3,D2                            ; $0096DA
loc_0096DC:
        MULS    D2,D0                           ; $0096DC
        ASR.L  #8,D0                            ; $0096DE
        TST.W  $0092(A0)                        ; $0096E0
        BLE.S  loc_0096F2                       ; $0096E4
        MOVE.W  #$0028,D1                       ; $0096E6
        SUB.W  $0092(A0),D1                     ; $0096EA
        MULS    D1,D0                           ; $0096EE
        ASR.L  #5,D0                            ; $0096F0
loc_0096F2:
        MOVE.W  D0,D2                           ; $0096F2
        MOVE.W  D0,D1                           ; $0096F4
        ASR.W  #1,D1                            ; $0096F6
        ADD.W  D1,D0                            ; $0096F8
        TST.B  $C31B.W                          ; $0096FA
        BEQ.S  loc_009704                       ; $0096FE
        ASR.W  #1,D2                            ; $009700
        ADD.W  D2,D0                            ; $009702
loc_009704:
        ADD.W  D0,$003C(A0)                     ; $009704
        MOVE.W  $003C(A0),D0                    ; $009708
        SUB.W  $001E(A0),D0                     ; $00970C
        BPL.S  loc_009714                       ; $009710
        NEG.W  D0                               ; $009712
loc_009714:
        CMPI.W  #$0222,D0                       ; $009714
        BGE.S  loc_009748                       ; $009718
        ADDQ.W  #1,$C002.W                      ; $00971A
        CMPI.W  #$0004,$C002.W                  ; $00971E
        BLT.S  loc_00974C                       ; $009724
        MOVE.W  $001E(A0),D0                    ; $009726
        SUB.W  $0040(A0),D0                     ; $00972A
        CMPI.W  #$0012,D0                       ; $00972E
        BLE.S  loc_009738                       ; $009732
        MOVE.W  #$0012,D0                       ; $009734
loc_009738:
        CMPI.W  #$FFEE,D0                       ; $009738
        BGE.S  loc_009742                       ; $00973C
        MOVE.W  #$FFEE,D0                       ; $00973E
loc_009742:
        ADD.W  D0,$003C(A0)                     ; $009742
        BRA.S  loc_00974C                       ; $009746
loc_009748:
        CLR.W  $C002.W                          ; $009748
loc_00974C:
        MOVE.W  $005C(A0),D0                    ; $00974C
        SUB.W  $005A(A0),D0                     ; $009750
        MOVE.W  $0090(A0),D1                    ; $009754
        BPL.S  loc_00975E                       ; $009758
        NEG.W  D0                               ; $00975A
        NEG.W  D1                               ; $00975C
loc_00975E:
        CMPI.W  #$0190,D0                       ; $00975E
        BLE.S  loc_009768                       ; $009762
        MOVE.W  #$0190,D0                       ; $009764
loc_009768:
        CMPI.W  #$FFCE,D0                       ; $009768
        BGE.S  loc_009772                       ; $00976C
        MOVE.W  #$FFCE,D0                       ; $00976E
loc_009772:
        LSL.W  #4,D0                            ; $009772
        MOVE.W  D0,D2                           ; $009774
        ADD.W  D0,D0                            ; $009776
        ADD.W  D0,D0                            ; $009778
        ADD.W  D2,D0                            ; $00977A
        ASR.W  #8,D0                            ; $00977C
        MOVE.W  $0006(A0),D2                    ; $00977E
        ADD.W  D2,D2                            ; $009782
        ADD.W  D2,D2                            ; $009784
        MOVE.W  D2,D3                           ; $009786
        ADD.W  D3,D3                            ; $009788
        ADD.W  D3,D3                            ; $00978A
        ADD.W  D3,D2                            ; $00978C
        MULS    D2,D2                           ; $00978E
        SWAP    D2                              ; $009790
        MULS    D1,D2                           ; $009792
        MOVEQ   #$0D,D1                         ; $009794
        ASR.L  D1,D2                            ; $009796
        ASR.W  #3,D2                            ; $009798
        MOVE.W  D2,D1                           ; $00979A
        ASR.W  #1,D1                            ; $00979C
        ADD.W  D1,D2                            ; $00979E
        ADDI.W  #$0188,D0                       ; $0097A0
        SUB.W  D2,D0                            ; $0097A4
        MOVE.W  $000C(A0),D1                    ; $0097A6
        NEG.W  D1                               ; $0097AA
        LSL.W  #4,D1                            ; $0097AC
        CMPI.W  #$0040,D1                       ; $0097AE
        BLE.S  loc_0097B8                       ; $0097B2
        MOVE.W  #$0040,D1                       ; $0097B4
loc_0097B8:
        CMPI.W  #$FFF0,D1                       ; $0097B8
        BGE.S  loc_0097C2                       ; $0097BC
        MOVE.W  #$FFF0,D1                       ; $0097BE
loc_0097C2:
        ADD.W  D1,D0                            ; $0097C2
        CMPI.W  #$0040,D0                       ; $0097C4
        BGE.S  loc_0097CC                       ; $0097C8
        MOVEQ   #$40,D0                         ; $0097CA
loc_0097CC:
        CMP.W  $C0E8.W,D0                       ; $0097CC
        BLE.S  loc_0097D6                       ; $0097D0
        MOVE.W  $C0E8.W,D0                      ; $0097D2
loc_0097D6:
        TST.W  $00AA(A0)                        ; $0097D6
        BLE.S  loc_0097E0                       ; $0097DA
        SUBQ.W  #8,$00AA(A0)                    ; $0097DC
loc_0097E0:
        CMPI.W  #$0050,$00AA(A0)                ; $0097E0
        BGT.S  loc_0097FC                       ; $0097E6
        MOVE.W  $0076(A0),D1                    ; $0097E8
        SUB.W  D0,D1                            ; $0097EC
        CMPI.W  #$000C,D1                       ; $0097EE
        BLE.S  loc_0097FC                       ; $0097F2
        SUBI.W  #$000C,$0076(A0)                ; $0097F4
        BRA.S  loc_009800                       ; $0097FA
loc_0097FC:
        MOVE.W  D0,$0076(A0)                    ; $0097FC
loc_009800:
        RTS                                     ; $009800
        MOVE.W  $C8CC.W,D0                      ; $009802
        MOVEA.L $04(PC,D0.W),A1                 ; $009806
        JMP     (A1)                            ; $00980A
        DC.W    $0088                           ; $00980C
        SUB.B  (A0)+,D4                         ; $00980E
        DC.W    $0088                           ; $009810
        SUB.L  D4,$0088(A2)                     ; $009812
        SUB.W  <EA:3E>,D4                       ; $009816
        MOVE.W  $0092(A0),D0                    ; $009818
        OR.W   $0062(A0),D0                     ; $00981C
        BNE.S  loc_00984E                       ; $009820
        MOVE.W  $004C(A0),D0                    ; $009822
        BPL.S  loc_00982A                       ; $009826
        NEG.W  D0                               ; $009828
loc_00982A:
        CMPI.W  #$0037,D0                       ; $00982A
        BLE.S  loc_00984E                       ; $00982E
        MOVE.W  $004C(A0),D0                    ; $009830
        ASR.W  #7,D0                            ; $009834
        MOVE.W  D0,D1                           ; $009836
        ASR.W  #1,D0                            ; $009838
        ADD.W  D1,D0                            ; $00983A
        ADD.W  D0,$0094(A0)                     ; $00983C
        MOVE.W  $0094(A0),D0                    ; $009840
        ASR.W  #1,D0                            ; $009844
        MOVE.W  D0,$0096(A0)                    ; $009846
        BRA.W  loc_00987C                       ; $00984A
loc_00984E:
        MOVE.W  $0094(A0),D0                    ; $00984E
        MOVE.W  D0,D1                           ; $009852
        ASR.W  #2,D0                            ; $009854
        SUB.W  D0,$0094(A0)                     ; $009856
        MOVE.W  $0094(A0),D0                    ; $00985A
        MOVE.W  D0,$0096(A0)                    ; $00985E
        TST.W  D1                               ; $009862
        BGE.S  loc_00986A                       ; $009864
        NEG.W  D0                               ; $009866
        NEG.W  D1                               ; $009868
loc_00986A:
        CMP.W  D0,D1                            ; $00986A
        BLT.S  loc_00987C                       ; $00986C
        TST.W  D0                               ; $00986E
        BLT.S  loc_00987C                       ; $009870
        CMPI.W  #$000F,D0                       ; $009872
        BGT.S  loc_00987C                       ; $009876
        CLR.W  $0094(A0)                        ; $009878
loc_00987C:
        RTS                                     ; $00987C
        MOVE.W  $C000.W,D0                      ; $00987E
        BPL.S  loc_009886                       ; $009882
        NEG.W  D0                               ; $009884
loc_009886:
        MULS    $0010(A0),D0                    ; $009886
        ASR.W  #8,D0                            ; $00988A
        MOVE.W  $0078(A0),D1                    ; $00988C
        SUB.W  D0,D1                            ; $009890
        CMPI.W  #$007F,D1                       ; $009892
        BGE.S  loc_00989A                       ; $009896
        MOVEQ   #$7F,D1                         ; $009898
loc_00989A:
        MOVE.W  D1,$0078(A0)                    ; $00989A
        CLR.B  $C31B.W                          ; $00989E
        MOVE.W  $0092(A0),D0                    ; $0098A2
        ADD.W  $0062(A0),D0                     ; $0098A6
        BNE.W  loc_009950                       ; $0098AA
        MOVE.W  $004C(A0),D0                    ; $0098AE
        MOVE.W  D0,D1                           ; $0098B2
        BPL.S  loc_0098B8                       ; $0098B4
        NEG.W  D1                               ; $0098B6
loc_0098B8:
        CMPI.W  #$0037,D1                       ; $0098B8
        BLE.W  loc_009950                       ; $0098BC
        MOVE.W  $0094(A0),D1                    ; $0098C0
        BPL.S  loc_0098C8                       ; $0098C4
        NEG.W  D1                               ; $0098C6
loc_0098C8:
        EXT.L   D0                              ; $0098C8
        DIVS    $C0EE.W,D0                      ; $0098CA
        CMP.W  $C0F0.W,D1                       ; $0098CE
        BGT.S  loc_0098F2                       ; $0098D2
        MOVE.W  #$0200,D2                       ; $0098D4
        SUB.W  $0078(A0),D2                     ; $0098D8
        MULS    D2,D0                           ; $0098DC
        ASR.L  #8,D0                            ; $0098DE
        ADD.W  D0,$0094(A0)                     ; $0098E0
        MOVE.W  $0094(A0),D0                    ; $0098E4
        ASR.W  #1,D0                            ; $0098E8
        MOVE.W  D0,$0096(A0)                    ; $0098EA
        BRA.W  loc_0099A8                       ; $0098EE
loc_0098F2:
        MOVE.B  #$0001,$C31B.W                  ; $0098F2
        ASR.W  #2,D0                            ; $0098F8
        MOVE.W  D0,D1                           ; $0098FA
        ASR.W  #1,D1                            ; $0098FC
        ADD.W  D1,D0                            ; $0098FE
        ADD.W  D0,$0094(A0)                     ; $009900
        MOVE.W  $0094(A0),D0                    ; $009904
        MOVE.W  D0,D1                           ; $009908
        BPL.S  loc_00990E                       ; $00990A
        NEG.W  D1                               ; $00990C
loc_00990E:
        MOVE.W  D0,$0096(A0)                    ; $00990E
        MULS    $C0F6.W,D0                      ; $009912
        ASR.L  #8,D0                            ; $009916
        SUB.W  D0,$003C(A0)                     ; $009918
        CMP.W  $C0F2.W,D1                       ; $00991C
        BLT.W  loc_0099A8                       ; $009920
        MOVE.W  $006A(A0),D2                    ; $009924
        ADD.W  $008C(A0),D2                     ; $009928
        BNE.W  loc_0099A8                       ; $00992C
        MOVE.W  #$2000,D2                       ; $009930
        TST.W  $0094(A0)                        ; $009934
        BMI.S  loc_00993E                       ; $009938
        MOVE.W  #$1000,D2                       ; $00993A
loc_00993E:
        MOVE.B  #$00B2,$C8A4.W                  ; $00993E
        OR.W   D2,$0002(A0)                     ; $009944
        CLR.B  $C31B.W                          ; $009948
        BRA.W  loc_0099A8                       ; $00994C
loc_009950:
        MOVE.W  $0094(A0),D0                    ; $009950
        MOVE.W  D0,D1                           ; $009954
        BMI.S  loc_009964                       ; $009956
        CMPI.W  #$0100,D0                       ; $009958
        BGT.S  loc_00996E                       ; $00995C
        MOVE.W  #$0100,D0                       ; $00995E
        BRA.S  loc_00996E                       ; $009962
loc_009964:
        CMPI.W  #$FF00,D0                       ; $009964
        BLT.S  loc_00996E                       ; $009968
        MOVE.W  #$FF00,D0                       ; $00996A
loc_00996E:
        MOVE.W  D0,D1                           ; $00996E
        MULS    $C0F4.W,D0                      ; $009970
        ASR.L  #8,D0                            ; $009974
        SUB.W  D0,$0094(A0)                     ; $009976
        MOVE.W  $0094(A0),D2                    ; $00997A
        EOR.W  D2,D0                            ; $00997E
        BPL.S  loc_009986                       ; $009980
        CLR.W  $0094(A0)                        ; $009982
loc_009986:
        MOVE.W  $0094(A0),D0                    ; $009986
        MOVE.W  D0,$0096(A0)                    ; $00998A
        TST.W  D1                               ; $00998E
        BGE.S  loc_009996                       ; $009990
        NEG.W  D0                               ; $009992
        NEG.W  D1                               ; $009994
loc_009996:
        CMP.W  D0,D1                            ; $009996
        BLT.S  loc_0099A8                       ; $009998
        TST.W  D0                               ; $00999A
        BLT.S  loc_0099A8                       ; $00999C
        CMPI.W  #$000F,D0                       ; $00999E
        BGT.S  loc_0099A8                       ; $0099A2
        CLR.W  $0094(A0)                        ; $0099A4
loc_0099A8:
        RTS                                     ; $0099A8
        MOVE.W  #$00B5,D6                       ; $0099AA
        MOVE.W  D6,D7                           ; $0099AE
        MOVE.W  $C000.W,D0                      ; $0099B0
        BPL.S  loc_0099B8                       ; $0099B4
        NEG.W  D0                               ; $0099B6
loc_0099B8:
        MULS    $0010(A0),D0                    ; $0099B8
        ASR.L  #7,D0                            ; $0099BC
        MOVEQ   #$00,D1                         ; $0099BE
        CMPI.W  #$00C8,$0004(A0)                ; $0099C0
        BLE.S  loc_0099DA                       ; $0099C6
        BTST    #4,$C971.W                      ; $0099C8
        BEQ.S  loc_0099DA                       ; $0099CE
        MOVE.W  #$00FF,D1                       ; $0099D0
        SUB.W  $000E(A0),D1                     ; $0099D4
        ASL.W  #3,D1                            ; $0099D8
loc_0099DA:
        ADD.W  D1,D0                            ; $0099DA
        MOVE.W  $0078(A0),D1                    ; $0099DC
        SUB.W  D0,D1                            ; $0099E0
        CMPI.W  #$00FF,D1                       ; $0099E2
        BLE.S  loc_0099EC                       ; $0099E6
        MOVE.W  #$00FF,D1                       ; $0099E8
loc_0099EC:
        CMPI.W  #$0040,D1                       ; $0099EC
        BGE.S  loc_0099F6                       ; $0099F0
        MOVE.W  #$0040,D1                       ; $0099F2
loc_0099F6:
        MOVE.W  D1,$0078(A0)                    ; $0099F6
        MOVE.W  $0092(A0),D0                    ; $0099FA
        ADD.W  $0062(A0),D0                     ; $0099FE
        BNE.W  loc_009AA6                       ; $009A02
        MOVE.W  $004C(A0),D0                    ; $009A06
        MOVE.W  D0,D1                           ; $009A0A
        BPL.S  loc_009A10                       ; $009A0C
        NEG.W  D1                               ; $009A0E
loc_009A10:
        CMPI.W  #$0037,D1                       ; $009A10
        BLE.W  loc_009AA6                       ; $009A14
        MOVE.W  $0094(A0),D1                    ; $009A18
        BPL.S  loc_009A20                       ; $009A1C
        NEG.W  D1                               ; $009A1E
loc_009A20:
        MOVE.W  #$0200,D2                       ; $009A20
        SUB.W  $0078(A0),D2                     ; $009A24
        MULS    D2,D0                           ; $009A28
        ASR.L  #8,D0                            ; $009A2A
        DIVS    $C0EE.W,D0                      ; $009A2C
        CMP.W  $C0F0.W,D1                       ; $009A30
        BLE.S  loc_009A38                       ; $009A34
        ASR.W  #1,D0                            ; $009A36
loc_009A38:
        ADD.W  D0,$0094(A0)                     ; $009A38
        MOVE.W  $0094(A0),D0                    ; $009A3C
        MOVE.W  D0,D2                           ; $009A40
        ADD.W  D2,D2                            ; $009A42
        MOVE.W  D2,$0096(A0)                    ; $009A44
        MOVE.W  D0,D1                           ; $009A48
        BPL.S  loc_009A4E                       ; $009A4A
        NEG.W  D1                               ; $009A4C
loc_009A4E:
        CMPI.W  #$0100,D1                       ; $009A4E
        BLT.S  loc_009A6C                       ; $009A52
        MOVEQ   #$7F,D2                         ; $009A54
        TST.W  D0                               ; $009A56
        BMI.S  loc_009A5C                       ; $009A58
        NEG.W  D2                               ; $009A5A
loc_009A5C:
        ADD.W  D2,D6                            ; $009A5C
        SUB.W  D2,D7                            ; $009A5E
        CMPI.W  #$000B,$0080(A0)                ; $009A60
        BGE.S  loc_009A6C                       ; $009A66
        ADDQ.W  #4,$0080(A0)                    ; $009A68
loc_009A6C:
        MULS    $C0F6.W,D0                      ; $009A6C
        ASR.L  #8,D0                            ; $009A70
        SUB.W  D0,$003C(A0)                     ; $009A72
        CMP.W  $C0F2.W,D1                       ; $009A76
        BLT.W  loc_009B04                       ; $009A7A
        MOVE.W  $006A(A0),D2                    ; $009A7E
        ADD.W  $008C(A0),D2                     ; $009A82
        BNE.W  loc_009B04                       ; $009A86
        MOVE.W  #$2000,D2                       ; $009A8A
        TST.W  $0094(A0)                        ; $009A8E
        BMI.S  loc_009A98                       ; $009A92
        MOVE.W  #$1000,D2                       ; $009A94
loc_009A98:
        MOVE.B  #$00B2,$C8A4.W                  ; $009A98
        OR.W   D2,$0002(A0)                     ; $009A9E
        BRA.W  loc_009B04                       ; $009AA2
loc_009AA6:
        MOVE.W  $0094(A0),D0                    ; $009AA6
        MOVE.W  D0,D1                           ; $009AAA
        BMI.S  loc_009ABA                       ; $009AAC
        CMPI.W  #$0200,D0                       ; $009AAE
        BGT.S  loc_009AC4                       ; $009AB2
        MOVE.W  #$0200,D0                       ; $009AB4
        BRA.S  loc_009AC4                       ; $009AB8
loc_009ABA:
        CMPI.W  #$FE00,D0                       ; $009ABA
        BLT.S  loc_009AC4                       ; $009ABE
        MOVE.W  #$FE00,D0                       ; $009AC0
loc_009AC4:
        MOVE.W  D0,D1                           ; $009AC4
        MULS    $C0F4.W,D0                      ; $009AC6
        ASR.L  #8,D0                            ; $009ACA
        SUB.W  D0,$0094(A0)                     ; $009ACC
        MOVE.W  $0094(A0),D2                    ; $009AD0
        EOR.W  D2,D0                            ; $009AD4
        BPL.S  loc_009ADC                       ; $009AD6
        CLR.W  $0094(A0)                        ; $009AD8
loc_009ADC:
        MOVE.W  $0094(A0),D0                    ; $009ADC
        MOVE.W  D0,D2                           ; $009AE0
        ASR.W  #1,D2                            ; $009AE2
        ADD.W  D0,D2                            ; $009AE4
        MOVE.W  D2,$0096(A0)                    ; $009AE6
        TST.W  D1                               ; $009AEA
        BGE.S  loc_009AF2                       ; $009AEC
        NEG.W  D0                               ; $009AEE
        NEG.W  D1                               ; $009AF0
loc_009AF2:
        CMP.W  D0,D1                            ; $009AF2
        BLT.S  loc_009B04                       ; $009AF4
        TST.W  D0                               ; $009AF6
        BLT.S  loc_009B04                       ; $009AF8
        CMPI.W  #$000F,D0                       ; $009AFA
        BGT.S  loc_009B04                       ; $009AFE
        CLR.W  $0094(A0)                        ; $009B00
loc_009B04:
        MOVE.W  D6,$00FF617A                    ; $009B04
        MOVE.W  D7,$00FF618E                    ; $009B0A
        RTS                                     ; $009B10
        MOVE.W  $0006(A0),D0                    ; $009B12
        TST.W  $00A8(A0)                        ; $009B16
        BNE.S  loc_009B26                       ; $009B1A
        CMP.W  $000A(A0),D0                     ; $009B1C
        BLE.S  loc_009B26                       ; $009B20
        MOVE.W  $000A(A0),D0                    ; $009B22
loc_009B26:
        MULS    #$0048,D0                       ; $009B26
        ASR.L  #8,D0                            ; $009B2A
        MOVE.W  D0,$0004(A0)                    ; $009B2C
        RTS                                     ; $009B30
loc_009B32:
        MOVE.L  D1,-(A7)                        ; $009B32
        MOVEQ   #$00,D0                         ; $009B34
        MOVE.B  $C31A.W,D1                      ; $009B36
        BEQ.S  loc_009B4E                       ; $009B3A
        MOVE.W  $0004(A0),D0                    ; $009B3C
        MULS    D0,D0                           ; $009B40
        LSR.L  #4,D0                            ; $009B42
        CMPI.B  #$0002,D1                       ; $009B44
        BGT.S  loc_009B50                       ; $009B48
        LSR.W  #1,D0                            ; $009B4A
        BRA.S  loc_009B50                       ; $009B4C
loc_009B4E:
        MOVEQ   #$00,D0                         ; $009B4E
loc_009B50:
        MOVE.L  (A7)+,D1                        ; $009B50
        RTS                                     ; $009B52
        MOVEQ   #-$01,D0                        ; $009B54
        MOVE.W  D0,$C00C.W                      ; $009B56
        MOVE.W  D0,$C018.W                      ; $009B5A
        MOVE.W  D0,$C012.W                      ; $009B5E
        TST.W  $00FF6114                        ; $009B62
        BEQ.S  loc_009B70                       ; $009B68
        TST.W  $C048.W                          ; $009B6A
        BNE.S  loc_009B82                       ; $009B6E
loc_009B70:
        MOVE.W  D0,$C01E.W                      ; $009B70
        MOVE.W  D0,$C024.W                      ; $009B74
        MOVE.W  D0,$C00E.W                      ; $009B78
        MOVE.W  D0,$C010.W                      ; $009B7C
        RTS                                     ; $009B80
loc_009B82:
        MOVE.W  $0080(A0),D1                    ; $009B82
        CMPI.W  #$0007,D1                       ; $009B86
        BGT.S  loc_009B96                       ; $009B8A
        MOVE.W  $0082(A0),D1                    ; $009B8C
        CMPI.W  #$0007,D1                       ; $009B90
        BLE.S  loc_009B9E                       ; $009B94
loc_009B96:
        MOVEQ   #$0F,D0                         ; $009B96
        SUB.W  D1,D0                            ; $009B98
        MOVE.W  D0,$C00C.W                      ; $009B9A
loc_009B9E:
        MOVE.W  $0084(A0),D0                    ; $009B9E
        BEQ.S  loc_009BB2                       ; $009BA2
        CMPI.W  #$000A,D0                       ; $009BA4
        BGT.S  loc_009BB2                       ; $009BA8
        MOVEQ   #$0A,D1                         ; $009BAA
        SUB.W  D0,D1                            ; $009BAC
        MOVE.W  D1,$C018.W                      ; $009BAE
loc_009BB2:
        CMPI.W  #$0014,$0004(A0)                ; $009BB2
        BLE.S  loc_009BFC                       ; $009BB8
        MOVE.W  $0098(A0),D0                    ; $009BBA
        BEQ.S  loc_009BD8                       ; $009BBE
        ADDQ.W  #1,$C01E.W                      ; $009BC0
        ANDI.W  #$0003,$C01E.W                  ; $009BC4
        CMPI.W  #$0078,$0004(A0)                ; $009BCA
        BGT.S  loc_009BDE                       ; $009BD0
        ADDQ.W  #4,$C01E.W                      ; $009BD2
        BRA.S  loc_009BDE                       ; $009BD6
loc_009BD8:
        MOVE.W  #$FFFF,$C01E.W                  ; $009BD8
loc_009BDE:
        MOVE.W  $009A(A0),D1                    ; $009BDE
        BEQ.S  loc_009C02                       ; $009BE2
        ADDQ.W  #1,$C024.W                      ; $009BE4
        ANDI.W  #$0003,$C024.W                  ; $009BE8
        CMPI.W  #$0078,$0004(A0)                ; $009BEE
        BGT.S  loc_009C08                       ; $009BF4
        ADDQ.W  #4,$C024.W                      ; $009BF6
        BRA.S  loc_009C08                       ; $009BFA
loc_009BFC:
        MOVE.W  #$FFFF,$C01E.W                  ; $009BFC
loc_009C02:
        MOVE.W  #$FFFF,$C024.W                  ; $009C02
loc_009C08:
        CMPI.W  #$0014,$0004(A0)                ; $009C08
        BLE.S  loc_009C52                       ; $009C0E
        MOVE.W  $00E6(A0),D0                    ; $009C10
        BEQ.S  loc_009C2E                       ; $009C14
        ADDQ.W  #1,$C00E.W                      ; $009C16
        ANDI.W  #$0003,$C00E.W                  ; $009C1A
        CMPI.W  #$0078,$0004(A0)                ; $009C20
        BGT.S  loc_009C34                       ; $009C26
        ADDQ.W  #4,$C00E.W                      ; $009C28
        BRA.S  loc_009C34                       ; $009C2C
loc_009C2E:
        MOVE.W  #$FFFF,$C00E.W                  ; $009C2E
loc_009C34:
        MOVE.W  $00E8(A0),D1                    ; $009C34
        BEQ.S  loc_009C58                       ; $009C38
        ADDQ.W  #1,$C010.W                      ; $009C3A
        ANDI.W  #$0003,$C010.W                  ; $009C3E
        CMPI.W  #$0078,$0004(A0)                ; $009C44
        BGT.S  loc_009C5E                       ; $009C4A
        ADDQ.W  #4,$C010.W                      ; $009C4C
        BRA.S  loc_009C5E                       ; $009C50
loc_009C52:
        MOVE.W  #$FFFF,$C00E.W                  ; $009C52
loc_009C58:
        MOVE.W  #$FFFF,$C010.W                  ; $009C58
loc_009C5E:
        MOVE.W  $00BE(A0),D0                    ; $009C5E
        ADD.W  D0,D0                            ; $009C62
        JMP     $02(PC,D0.W)                    ; $009C64
        BRA.S  loc_009C6C                       ; $009C68
        BRA.S  loc_009C84                       ; $009C6A
loc_009C6C:
        CMPI.W  #$0007,$0086(A0)                ; $009C6C
        BLE.S  loc_009C9A                       ; $009C72
        MOVEQ   #$0F,D1                         ; $009C74
        SUB.W  $0086(A0),D1                     ; $009C76
        ADD.W  D1,D1                            ; $009C7A
        MOVE.W  $1E(PC,D1.W),$C012.W            ; $009C7C
        BRA.S  loc_009C9A                       ; $009C82
loc_009C84:
        CMPI.W  #$0000,$0086(A0)                ; $009C84
        BLE.S  loc_009C9A                       ; $009C8A
        MOVEQ   #$0F,D1                         ; $009C8C
        SUB.W  $0086(A0),D1                     ; $009C8E
        ADD.W  D1,D1                            ; $009C92
        MOVE.W  $18(PC,D1.W),$C012.W            ; $009C94
loc_009C9A:
        RTS                                     ; $009C9A
        ORI.B  #$0001,D0                        ; $009C9C
        ORI.B  #$0003,D2                        ; $009CA0
        ORI.B  #$0006,D4                        ; $009CA4
        DC.W    $0008                           ; $009CA8
        DC.W    $0009                           ; $009CAA
        DC.W    $000A                           ; $009CAC
        ORI.B  #$0001,D0                        ; $009CAE
        ORI.B  #$0002,D1                        ; $009CB2
        ORI.B  #$0003,D3                        ; $009CB6
        ORI.B  #$0005,D4                        ; $009CBA
        ORI.B  #$0006,D5                        ; $009CBE
        ORI.B  #$0007,D7                        ; $009CC2
        DC.W    $0008                           ; $009CC6
        DC.W    $0009                           ; $009CC8
        DC.W    $0009                           ; $009CCA
        DC.W    $000A                           ; $009CCC
        MOVE.L  A0,-(A7)                        ; $009CCE
        MOVE.W  $00A4(A0),D6                    ; $009CD0
        MOVE.W  $00A6(A0),D7                    ; $009CD4
        LEA     (A0),A1                         ; $009CD8
        LEA     $A044.W,A2                      ; $009CDA
        LEA     $A000.W,A3                      ; $009CDE
        MOVE.W  $0024(A1),(A2)+                 ; $009CE2
        MOVE.W  A1,(A2)+                        ; $009CE6
        MOVE.W  $002E(A1),D0                    ; $009CE8
        LSL.W  #8,D0                            ; $009CEC
        ADD.W  $0024(A1),D0                     ; $009CEE
        MOVE.W  D0,(A3)+                        ; $009CF2
        MOVE.W  A1,(A3)+                        ; $009CF4
        LEA     $0100(A1),A1                    ; $009CF6
        MOVEQ   #$0E,D2                         ; $009CFA
loc_009CFC:
        MOVE.W  $0024(A1),(A2)+                 ; $009CFC
        MOVE.W  A1,(A2)+                        ; $009D00
        MOVE.W  $002C(A1),D0                    ; $009D02
        LSL.W  #8,D0                            ; $009D06
        ADD.W  $0024(A1),D0                     ; $009D08
        MOVE.W  D0,(A3)+                        ; $009D0C
        MOVE.W  A1,(A3)+                        ; $009D0E
        LEA     $0100(A1),A1                    ; $009D10
        DBRA    D2,loc_009CFC                   ; $009D14
        LEA     $A044.W,A0                      ; $009D18
        JSR     loc_009DE2(PC)                  ; $009D1C
        LEA     $A000.W,A0                      ; $009D20
        JSR     loc_009DE2(PC)                  ; $009D24
        LEA     $A044.W,A0                      ; $009D28
        MOVE.L  $003C(A0),-$0004(A0)            ; $009D2C
        MOVE.L  (A0),$0040(A0)                  ; $009D32
        MOVEQ   #$0F,D2                         ; $009D36
loc_009D38:
        MOVEA.W $0002(A0),A3                    ; $009D38
        MOVE.W  -$0002(A0),D0                   ; $009D3C
        LSR.W  #8,D0                            ; $009D40
        ANDI.W  #$000F,D0                       ; $009D42
        MOVE.W  D0,$00A4(A3)                    ; $009D46
        MOVE.W  $0006(A0),D0                    ; $009D4A
        LSR.W  #8,D0                            ; $009D4E
        ANDI.W  #$000F,D0                       ; $009D50
        MOVE.W  D0,$00A6(A3)                    ; $009D54
        LEA     $0004(A0),A0                    ; $009D58
        DBRA    D2,loc_009D38                   ; $009D5C
        LEA     $A000.W,A0                      ; $009D60
        MOVEQ   #$01,D1                         ; $009D64
        MOVEQ   #$0F,D2                         ; $009D66
loc_009D68:
        MOVEA.W $0002(A0),A2                    ; $009D68
        MOVE.W  D1,$002A(A2)                    ; $009D6C
        LEA     $0004(A0),A0                    ; $009D70
        ADDQ.W  #1,D1                           ; $009D74
        DBRA    D2,loc_009D68                   ; $009D76
        LEA     $9000.W,A0                      ; $009D7A
        MOVE.B  $002B(A0),$C304.W               ; $009D7E
        CMP.W  $00A6(A0),D6                     ; $009D84
        BEQ.S  loc_009D92                       ; $009D88
        CMP.W  $00A4(A0),D7                     ; $009D8A
        BNE.S  loc_009DD2                       ; $009D8E
        MOVE.W  D7,D6                           ; $009D90
loc_009D92:
        MOVE.W  $0004(A0),D1                    ; $009D92
        MOVE.B  $00E5(A0),D2                    ; $009D96
        LSL.W  #8,D6                            ; $009D9A
        LEA     $00(A0,D6.W),A0                 ; $009D9C
        SUB.W  $0004(A0),D1                     ; $009DA0
        BPL.S  loc_009DA8                       ; $009DA4
        NEG.W  D1                               ; $009DA6
loc_009DA8:
        CMPI.W  #$0014,D1                       ; $009DA8
        BLE.S  loc_009DD2                       ; $009DAC
        CMPI.W  #$0004,$C89C.W                  ; $009DAE
        BNE.S  loc_009DC2                       ; $009DB4
        MOVE.B  $00E5(A0),D1                    ; $009DB6
        EOR.B  D1,D2                            ; $009DBA
        ANDI.B  #$0006,D2                       ; $009DBC
        BNE.S  loc_009DD2                       ; $009DC0
loc_009DC2:
        MOVE.W  $00C2(A0),D0                    ; $009DC2
        LSR.W  #4,D0                            ; $009DC6
        ADD.W  $C8CC.W,D0                       ; $009DC8
        MOVE.B  $08(PC,D0.W),$C8A4.W            ; $009DCC
loc_009DD2:
        MOVEA.L (A7)+,A0                        ; $009DD2
        RTS                                     ; $009DD4
        EOR.L  D1,-$44(PC,A3.W)                 ; $009DD6
        MULU    A5,D6                           ; $009DDA
        MULU    A6,D6                           ; $009DDC
        MULS    (A0),D7                         ; $009DDE
        MULS    (A1),D7                         ; $009DE0
loc_009DE2:
        MOVEQ   #$0E,D1                         ; $009DE2
loc_009DE4:
        LEA     $0004(A0),A1                    ; $009DE4
        MOVE.W  D1,D2                           ; $009DE8
loc_009DEA:
        MOVE.W  (A0),D0                         ; $009DEA
        CMP.W  (A1),D0                          ; $009DEC
        BLT.S  loc_009E42                       ; $009DEE
        BGT.S  loc_009E48                       ; $009DF0
        MOVEA.W $0002(A0),A2                    ; $009DF2
        MOVEA.W $0002(A1),A3                    ; $009DF6
        MOVE.W  $001E(A2),D0                    ; $009DFA
        ADDI.W  #$2000,D0                       ; $009DFE
        ROL.W  #3,D0                            ; $009E02
        ANDI.W  #$0006,D0                       ; $009E04
        JMP     $02(PC,D0.W)                    ; $009E08
        BRA.S  loc_009E14                       ; $009E0C
        BRA.S  loc_009E20                       ; $009E0E
        BRA.S  loc_009E2C                       ; $009E10
        BRA.S  loc_009E38                       ; $009E12
loc_009E14:
        MOVE.W  $0034(A2),D0                    ; $009E14
        CMP.W  $0034(A3),D0                     ; $009E18
        BLT.S  loc_009E42                       ; $009E1C
        BRA.S  loc_009E48                       ; $009E1E
loc_009E20:
        MOVE.W  $0030(A2),D0                    ; $009E20
        CMP.W  $0030(A3),D0                     ; $009E24
        BGT.S  loc_009E42                       ; $009E28
        BRA.S  loc_009E48                       ; $009E2A
loc_009E2C:
        MOVE.W  $0034(A2),D0                    ; $009E2C
        CMP.W  $0034(A3),D0                     ; $009E30
        BGT.S  loc_009E42                       ; $009E34
        BRA.S  loc_009E48                       ; $009E36
loc_009E38:
        MOVE.W  $0030(A2),D0                    ; $009E38
        CMP.W  $0030(A3),D0                     ; $009E3C
        BGT.S  loc_009E48                       ; $009E40
loc_009E42:
        MOVE.L  (A0),D0                         ; $009E42
        MOVE.L  (A1),(A0)                       ; $009E44
        MOVE.L  D0,(A1)                         ; $009E46
loc_009E48:
        LEA     $0004(A1),A1                    ; $009E48
        DBRA    D2,loc_009DEA                   ; $009E4C
        LEA     $0004(A0),A0                    ; $009E50
        DBRA    D1,loc_009DE4                   ; $009E54
        RTS                                     ; $009E58
        TST.W  $00A8(A0)                        ; $009E5A
        BEQ.S  loc_009E64                       ; $009E5E
        SUBQ.W  #1,$00A8(A0)                    ; $009E60
loc_009E64:
        CMPI.W  #$0002,$002A(A0)                ; $009E64
        BEQ.S  loc_009E78                       ; $009E6A
        RTS                                     ; $009E6C
        TST.W  $00A8(A0)                        ; $009E6E
        BEQ.S  loc_009E78                       ; $009E72
        SUBQ.W  #1,$00A8(A0)                    ; $009E74
loc_009E78:
        MOVE.W  $00A4(A0),D0                    ; $009E78
        ASL.W  #8,D0                            ; $009E7C
        LEA     $9000.W,A1                      ; $009E7E
        LEA     $00(A1,D0.W),A1                 ; $009E82
        MOVE.W  $0072(A1),D0                    ; $009E86
        SUB.W  $0072(A0),D0                     ; $009E8A
        BPL.S  loc_009E92                       ; $009E8E
        NEG.W  D0                               ; $009E90
loc_009E92:
        CMPI.W  #$0030,D0                       ; $009E92
        BGT.S  loc_009EBE                       ; $009E96
        MOVE.W  $0030(A1),D0                    ; $009E98
        SUB.W  $0030(A0),D0                     ; $009E9C
        BPL.S  loc_009EA4                       ; $009EA0
        NEG.W  D0                               ; $009EA2
loc_009EA4:
        MOVE.W  $0034(A1),D1                    ; $009EA4
        SUB.W  $0034(A0),D1                     ; $009EA8
        BPL.S  loc_009EB0                       ; $009EAC
        NEG.W  D1                               ; $009EAE
loc_009EB0:
        ADD.W  D1,D0                            ; $009EB0
        CMPI.W  #$0070,D0                       ; $009EB2
loc_009EB6:
        BGT.S  loc_009EBE                       ; $009EB6
        MOVE.W  #$000C,$00A8(A0)                ; $009EB8
loc_009EBE:
        RTS                                     ; $009EBE
        MOVE.W  $C8AC.W,D0                      ; $009EC0
        MOVEA.L $04(PC,D0.W),A1                 ; $009EC4
        JMP     (A1)                            ; $009EC8
        DC.W    $0088                           ; $009ECA
        MOVEA.L A6,A0                           ; $009ECC
        DC.W    $0088                           ; $009ECE
        SUB.B  D7,(A6)                          ; $009ED0
        DC.W    $0088                           ; $009ED2
        SUB.B  D7,$0088(A2)                     ; $009ED4
        SUB.W  D7,A2                            ; $009ED8
        DC.W    $0088                           ; $009EDA
        SUB.W  D7,$0088(A4)                     ; $009EDC
        SUB.L  D7,A6                            ; $009EE0
        DC.W    $0088                           ; $009EE2
        SUB.L  D7,#$0088A04E                    ; $009EE4
        DC.W    $0088                           ; $009EEA
        MOVE.W  (A2)+,-$78(A6,D0.W)             ; $009EEC
        MOVE.W  -(A6),-$78(A6,D0.W)             ; $009EF0
        DC.W    $3DD4                           ; $009EF4
        DC.W    $0088                           ; $009EF6
        MOVE.W  A0,D7                           ; $009EF8
        DC.W    $0088                           ; $009EFA
        MOVEA.W (A0)+,A7                        ; $009EFC
        DC.W    $0088                           ; $009EFE
        MOVEA.W -(A4),A7                        ; $009F00
        DC.W    $0088                           ; $009F02
        DC.W    $3E7E                           ; $009F04
        DC.W    $0088                           ; $009F06
        MOVE.W  -(A2),(A7)                      ; $009F08
        DC.W    $0088                           ; $009F0A
        MOVE.W  D6,(A7)+                        ; $009F0C
        DC.W    $0088                           ; $009F0E
        MOVE.W  -$78(A6,D0.W),(A7)+             ; $009F10
        MOVE.W  $4278(A4),-(A7)                 ; $009F14
        SUB.L  $78(A0,D4.W),D0                  ; $009F18
        AND.L  $13FC(A2),D4                     ; $009F1C
        ORI.B  #$00FF,D1                        ; $009F20
        BVS.S  loc_009EB6                       ; $009F24
        ADDQ.W  #4,$C8AC.W                      ; $009F26
        CMPI.W  #$003C,$C8AA.W                  ; $009F2A
        BLT.W  loc_00A022                       ; $009F30
        ADDQ.W  #4,$C8AC.W                      ; $009F34
        CLR.W  $C8AA.W                          ; $009F38
        MOVE.B  #$0009,$00FF6980                ; $009F3C
        MOVE.B  #$00C0,$C8A4.W                  ; $009F44
        CMPI.W  #$0014,$C8AA.W                  ; $009F4A
        BLT.W  loc_00A022                       ; $009F50
        ADDQ.W  #4,$C8AC.W                      ; $009F54
        CLR.W  $C8AA.W                          ; $009F58
        MOVE.L  #$222F038A,$00FF6988            ; $009F5C
        MOVE.B  #$00C1,$C8A4.W                  ; $009F66
        CMPI.W  #$0014,$C8AA.W                  ; $009F6C
        BLT.W  loc_00A022                       ; $009F72
        ADDQ.W  #4,$C8AC.W                      ; $009F76
        CLR.W  $C8AA.W                          ; $009F7A
        MOVE.L  #$222F002C,$00FF6988            ; $009F7E
        MOVE.B  #$00C2,$C8A4.W                  ; $009F88
        CMPI.W  #$0014,$C8AA.W                  ; $009F8E
        BLT.W  loc_00A022                       ; $009F94
        ADDQ.W  #4,$C8AC.W                      ; $009F98
        CLR.W  $C8AA.W                          ; $009F9C
        CLR.B  $00FF6990                        ; $009FA0
        MOVE.L  #$222EEF3A,$00FF6988            ; $009FA6
        BSET    #4,$C30E.W                      ; $009FB0
        MOVE.B  #$00C3,$C8A4.W                  ; $009FB6
        CMPI.W  #$0005,$C8AA.W                  ; $009FBC
        BNE.S  loc_009FD8                       ; $009FC2
        MOVE.B  #$0082,$C8A5.W                  ; $009FC4
        BTST    #5,$C80E.W                      ; $009FCA
        BEQ.S  loc_009FD8                       ; $009FD0
        MOVE.B  #$0093,$C8A5.W                  ; $009FD2
loc_009FD8:
        CLR.W  $C026.W                          ; $009FD8
        TST.B  $C312.W                          ; $009FDC
        BNE.S  loc_009FFC                       ; $009FE0
        MOVEQ   #$00,D0                         ; $009FE2
        BTST    #2,$C8AB.W                      ; $009FE4
        BNE.S  loc_009FEE                       ; $009FEA
        MOVEQ   #$09,D0                         ; $009FEC
loc_009FEE:
        MOVE.B  D0,$00FF6980                    ; $009FEE
        CMPI.W  #$003C,$C8AA.W                  ; $009FF4
        BLT.S  loc_00A034                       ; $009FFA
loc_009FFC:
        ADDQ.W  #4,$C8AC.W                      ; $009FFC
        LEA     $00FF66DC,A1                    ; $00A000
        CLR.W  (A1)                             ; $00A006
        CLR.W  $0014(A1)                        ; $00A008
        CLR.W  $0028(A1)                        ; $00A00C
        CLR.W  $003C(A1)                        ; $00A010
        MOVE.W  #$FFFF,$C026.W                  ; $00A014
        CLR.B  $00FF6980                        ; $00A01A
        BRA.S  loc_00A04E                       ; $00A020
loc_00A022:
        MOVEQ   #$00,D0                         ; $00A022
        BTST    #2,$C8AB.W                      ; $00A024
        BEQ.S  loc_00A02E                       ; $00A02A
        MOVEQ   #$01,D0                         ; $00A02C
loc_00A02E:
        MOVE.B  D0,$00FF6990                    ; $00A02E
loc_00A034:
        MOVE.W  $90B0.W,D0                      ; $00A034
        ADDQ.W  #1,$90B0.W                      ; $00A038
        MULU    #$3BBB,D0                       ; $00A03C
        SWAP    D0                              ; $00A040
        CMPI.W  #$001B,D0                       ; $00A042
        BLE.S  loc_00A04A                       ; $00A046
        MOVEQ   #$1B,D0                         ; $00A048
loc_00A04A:
        MOVE.W  D0,$C026.W                      ; $00A04A
loc_00A04E:
        RTS                                     ; $00A04E
        LEA     $00898824,A1                    ; $00A050
        MOVE.L  (A1)+,$C278.W                   ; $00A056
        MOVE.W  (A1)+,$C0E6.W                   ; $00A05A
        MOVE.W  (A1)+,$C0E8.W                   ; $00A05E
        MOVE.W  (A1)+,$C0EA.W                   ; $00A062
        MOVE.W  (A1)+,$C0EC.W                   ; $00A066
        MOVE.W  (A1)+,$C0EE.W                   ; $00A06A
        MOVE.W  (A1)+,$C0F0.W                   ; $00A06E
        MOVE.W  (A1)+,$C0F2.W                   ; $00A072
        MOVE.W  (A1)+,$C0F4.W                   ; $00A076
        MOVE.W  (A1)+,$C0F6.W                   ; $00A07A
        MOVE.W  (A1)+,$C8CE.W                   ; $00A07E
        MOVE.W  (A1)+,$C8D0.W                   ; $00A082
        MOVE.W  (A1)+,$C8D2.W                   ; $00A086
        MOVE.W  (A1)+,$C0F8.W                   ; $00A08A
        MOVE.W  (A1)+,$C0FA.W                   ; $00A08E
        MOVE.L  #$0093925E,$C27C.W              ; $00A092
        MOVE.W  $C8A0.W,D1                      ; $00A09A
        ADD.W  D1,D1                            ; $00A09E
        MOVE.W  $C8C8.W,D0                      ; $00A0A0
        MULS    #$0030,D0                       ; $00A0A4
        ADD.W  D0,D1                            ; $00A0A8
        LEA     $08(PC,D1.W),A1                 ; $00A0AA
        MOVE.L  A1,$C280.W                      ; $00A0AE
        RTS                                     ; $00A0B2
        ORI.W  #$0088,(A0)                      ; $00A0B4
        ORI.L  #$00980040,(A0)                  ; $00A0B8
        ORI.W  #$0080,$70(A0,D0.W)              ; $00A0BE
        ORI.W  #$0058,(A0)                      ; $00A0C4
        ORI.L  #$00980080,(A0)                  ; $00A0C8
        ORI.L  #$00C000C0,D0                    ; $00A0CE
        ORI.W  #$0068,(A0)                      ; $00A0D4
        ORI.L  #$00880050,D0                    ; $00A0D8
        ORI.W  #$0080,$0088(A0)                 ; $00A0DE
        ORI.W  #$0088,-(A0)                     ; $00A0E4
        ORI.L  #$00980098,(A0)                  ; $00A0E8
        ORI.L  #$00E000F0,-(A0)                 ; $00A0EE
        ORI.W  #$0088,(A0)                      ; $00A0F4
        ORI.L  #$00980050,(A0)                  ; $00A0F8
        ORI.W  #$0080,$0088(A0)                 ; $00A0FE
        ORI.W  #$0068,(A0)                      ; $00A104
        ORI.L  #$00880050,D0                    ; $00A108
        ORI.W  #$0080,$0088(A0)                 ; $00A10E
        ORI.W  #$0088,-(A0)                     ; $00A114
        ORI.L  #$009800B0,(A0)                  ; $00A118
        ORI.L  #$00C000C0,$50(A0,D0.W)          ; $00A11E
        DC.W    $0088                           ; $00A126
        ORI.L  #$00980060,(A0)                  ; $00A128
        ORI.W  #$00A0,-(A0)                     ; $00A12E
        DC.W    $00C0                           ; $00A132
        ORI.W  #$0068,(A0)                      ; $00A134
        ORI.L  #$00880050,D0                    ; $00A138
        ORI.W  #$0080,$0088(A0)                 ; $00A13E
        LEA     $00898818,A1                    ; $00A144
        MOVE.W  $C8CC.W,D0                      ; $00A14A
        MOVEA.L $00(A1,D0.W),A1                 ; $00A14E
        MOVE.L  (A1)+,$C278.W                   ; $00A152
        MOVE.W  (A1)+,$C0E6.W                   ; $00A156
        MOVE.W  (A1)+,$C0E8.W                   ; $00A15A
        MOVE.W  (A1)+,$C0EA.W                   ; $00A15E
        MOVE.W  (A1)+,$C0EC.W                   ; $00A162
        MOVE.W  (A1)+,$C0EE.W                   ; $00A166
        MOVE.W  (A1)+,$C0F0.W                   ; $00A16A
        MOVE.W  (A1)+,$C0F2.W                   ; $00A16E
        MOVE.W  (A1)+,$C0F4.W                   ; $00A172
        MOVE.W  (A1)+,$C0F6.W                   ; $00A176
        MOVE.W  (A1)+,$C8CE.W                   ; $00A17A
        MOVE.W  (A1)+,$C8D0.W                   ; $00A17E
        MOVE.W  (A1)+,$C8D2.W                   ; $00A182
        MOVE.W  (A1)+,$C0F8.W                   ; $00A186
        MOVE.W  (A1)+,$C0FA.W                   ; $00A18A
        LEA     $003A(PC),A1                    ; $00A18E
        ADD.W  D0,D0                            ; $00A192
        TST.B  $C30F.W                          ; $00A194
        BEQ.S  loc_00A19C                       ; $00A198
        ADDQ.W  #4,D0                           ; $00A19A
loc_00A19C:
        MOVE.L  $00(A1,D0.W),$C27C.W            ; $00A19C
        LEA     $FBF8.W,A1                      ; $00A1A2
        MOVE.W  $C8C8.W,D1                      ; $00A1A6
        MULS    #$0090,D1                       ; $00A1AA
        ADDA.W  D1,A1                           ; $00A1AE
        MOVE.W  $C89C.W,D1                      ; $00A1B0
        ASL.W  #3,D1                            ; $00A1B4
        ADDA.W  D1,A1                           ; $00A1B6
        MOVEQ   #$00,D1                         ; $00A1B8
        MOVE.B  $FDA9.W,D1                      ; $00A1BA
        MULS    #$0030,D1                       ; $00A1BE
        ADDA.W  D1,A1                           ; $00A1C2
        MOVE.L  A1,$C280.W                      ; $00A1C4
        RTS                                     ; $00A1C8
        ORI.L  #$925E0093,(A3)                  ; $00A1CA
        SUB.W  D2,<EA:3E>                       ; $00A1D0
        ORI.L  #$989E0093,(A3)                  ; $00A1D2
        SUB.L  D5,<EA:3E>                       ; $00A1D8
        ORI.L  #$989E0093,(A3)                  ; $00A1DA
        SUB.L  D5,<EA:3E>                       ; $00A1E0
        MOVE.W  (A0)+,(A5)                      ; $00A1E2
        MOVE.W  (A0)+,(A5)                      ; $00A1E4
        MOVE.W  (A0)+,(A5)                      ; $00A1E6
        MOVE.W  (A0)+,(A5)                      ; $00A1E8
        MOVE.W  (A0)+,(A5)                      ; $00A1EA
        MOVE.W  A0,-(A4)                        ; $00A1EC
        MOVE.W  D0,-(A6)                        ; $00A1EE
        ORI.L  #$00C000CD,$00D5(A3)             ; $00A1F0
        DC.W    $00DB                           ; $00A1F8
        DC.W    $00E0                           ; $00A1FA
        MOVE.W  $C8CA.W,D0                      ; $00A1FC
