; Generated assembly for $014200-$016200
; Branch targets: 43
; Labels: 32
; Format: DC.W with decoded mnemonics as comments

        org     $014200

        MOVE.L  $363C(A6),$0006(A5)             ; $014200
        CLR.W  D2                               ; $014206
        MOVE.B  (A0),D2                         ; $014208
        MOVE.W  D2,D4                           ; $01420A
        ADD.W  D2,D2                            ; $01420C
        ADD.W  D2,D2                            ; $01420E
        MOVEA.L $00(A1,D2.W),A0                 ; $014210
        ADDA.L  D1,A0                           ; $014214
        MOVE.W  #$0050,D0                       ; $014216
        MOVE.W  #$0007,D1                       ; $01421A
        MOVE.W  #$003C,D2                       ; $01421E
loc_014222:
        TST.B  $00A15120                        ; $014222
        BNE.S  loc_014222                       ; $014228
        JSR     $00E3B4(PC)                     ; $01422A
        SUB.W  D4,D3                            ; $01422E
        BCS.W  loc_014260                       ; $014230
        ADDQ.W  #1,D4                           ; $014234
loc_014236:
        MOVE.B  D4,D2                           ; $014236
        ADD.W  D2,D2                            ; $014238
        ADD.W  D2,D2                            ; $01423A
        MOVEA.L $00(A1,D2.W),A0                 ; $01423C
        ADDA.L  D5,A0                           ; $014240
        MOVE.W  #$0050,D0                       ; $014242
        MOVE.W  #$0007,D1                       ; $014246
        MOVE.W  #$0040,D2                       ; $01424A
loc_01424E:
        TST.B  $00A15120                        ; $01424E
        BNE.S  loc_01424E                       ; $014254
        JSR     $00E3B4(PC)                     ; $014256
        ADDQ.W  #1,D4                           ; $01425A
        DBRA    D3,loc_014236                   ; $01425C
loc_014260:
        RTS                                     ; $014260
        NOT    #$2700                           ; $014262
        BCLR    #6,$C875.W                      ; $014266
        MOVE.W  $C874.W,(A5)                    ; $01426C
        DC.W    $33FC,$0083,$00A1,$5100; $014270 MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $014278 ANDI.B  #$00FC,$00A15181
        JSR     $0088268C                       ; $014280
        DC.W    $33FC,$0100,$00A1,$1100; $014286 MOVE.W  #$0100,$00A11100
loc_01428E:
        DC.W    $0839,$0000,$00A1,$1100; $01428E BTST    #0,$00A11100
        BNE.S  loc_01428E                       ; $014296
        MOVE.W  $C874.W,D4                      ; $014298
        BSET    #4,D4                           ; $01429C
        MOVE.W  D4,(A5)                         ; $0142A0
        MOVE.L  #$93409400,(A5)                 ; $0142A2
        MOVE.L  #$954096C2,(A5)                 ; $0142A8
        MOVE.W  #$977F,(A5)                     ; $0142AE
        MOVE.W  #$C000,(A5)                     ; $0142B2
        MOVE.W  #$0080,$C876.W                  ; $0142B6
        MOVE.W  $C876.W,(A5)                    ; $0142BC
        MOVE.W  $C874.W,(A5)                    ; $0142C0
        MOVE.W  $C874.W,D4                      ; $0142C4
        BSET    #4,D4                           ; $0142C8
        MOVE.W  D4,(A5)                         ; $0142CC
        MOVE.W  #$8F01,(A5)                     ; $0142CE
        MOVE.L  #$93FF941F,(A5)                 ; $0142D2
        MOVE.W  #$9780,(A5)                     ; $0142D8
        MOVE.L  #$60000082,(A5)                 ; $0142DC
        MOVE.W  #$0000,(A6)                     ; $0142E2
loc_0142E6:
        MOVE.W  (A5),D7                         ; $0142E6
        ANDI.W  #$0002,D7                       ; $0142E8
        BNE.S  loc_0142E6                       ; $0142EC
        MOVE.W  #$8F02,(A5)                     ; $0142EE
        MOVE.W  $C874.W,(A5)                    ; $0142F2
        MOVE.W  $C874.W,D4                      ; $0142F6
        BSET    #4,D4                           ; $0142FA
        MOVE.W  D4,(A5)                         ; $0142FE
        MOVE.W  #$8F01,(A5)                     ; $014300
        MOVE.L  #$93FF941F,(A5)                 ; $014304
        MOVE.W  #$9780,(A5)                     ; $01430A
        MOVE.L  #$40000083,(A5)                 ; $01430E
        MOVE.W  #$0000,(A6)                     ; $014314
loc_014318:
        MOVE.W  (A5),D7                         ; $014318
        ANDI.W  #$0002,D7                       ; $01431A
        BNE.S  loc_014318                       ; $01431E
        MOVE.W  #$8F02,(A5)                     ; $014320
        MOVE.W  $C874.W,(A5)                    ; $014324
        DC.W    $33FC,$0000,$00A1,$1100; $014328 MOVE.W  #$0000,$00A11100
        JSR     $0088204A                       ; $014330
        JSR     $008849AA                       ; $014336
        DC.W    $21FC,$00FF,$9000,$C888; $01433C MOVE.L  #$00FF9000,$C888.W
        JSR     $00D42C(PC)                     ; $014344
        MOVEQ   #$00,D0                         ; $014348
        MOVEQ   #$00,D1                         ; $01434A
        JSR     $00D3DA(PC)                     ; $01434C
        DC.W    $33FC,$0010,$00FF,$0008; $014350 MOVE.W  #$0010,$00FF0008
        MOVE.B  #$0001,$C80D.W                  ; $014358
        MOVE.W  #$0000,$C87E.W                  ; $01435E
        MOVE.W  #$0000,$C082.W                  ; $014364
        MOVE.B  #$0000,$C080.W                  ; $01436A
        CLR.W  $A002.W                          ; $014370
        CLR.W  $A004.W                          ; $014374
        MOVE.B  #$002D,$C081.W                  ; $014378
        MOVE.B  #$0000,$C80E.W                  ; $01437E
        DC.W    $0239,$00FC,$00A1,$5181; $014384 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0003,$00A1,$5181; $01438C ORI.B  #$0003,$00A15181
        BSET    #6,$C875.W                      ; $014394
        MOVE.W  $C874.W,(A5)                    ; $01439A
        JSR     $00884998                       ; $01439E
        MOVE.W  #$0106,$C8A8.W                  ; $0143A4
        DC.W    $13F8,$C8A9,$00A1,$5121; $0143AA MOVE.B  $C8A9.W,$00A15121
        DC.W    $13F8,$C8A8,$00A1,$5120; $0143B2 MOVE.B  $C8A8.W,$00A15120
        DC.W    $23FC,$0089,$43C6,$00FF,$0002; $0143BA MOVE.L  #$008943C6,$00FF0002
        RTS                                     ; $0143C4
        JSR     $00882080                       ; $0143C6
        MOVE.W  $C87E.W,D0                      ; $0143CC
        MOVEA.L $04(PC,D0.W),A1                 ; $0143D0
        JMP     (A1)                            ; $0143D4
        ORI.L  #$43E20089,A1                    ; $0143D6
        LEA     $0089(PC),A1                    ; $0143DC
        NEG.B  D0                               ; $0143E0
        JSR     $0088179E                       ; $0143E2
        JSR     loc_01440E(PC)                  ; $0143E8
        ADDQ.W  #4,$C87E.W                      ; $0143EC
        DC.W    $33FC,$0020,$00FF,$0008; $0143F0 MOVE.W  #$0020,$00FF0008
        RTS                                     ; $0143F8
        ADDQ.W  #4,$C87E.W                      ; $0143FA
        RTS                                     ; $0143FE
        JSR     loc_01457C(PC)                  ; $014400
        DC.W    $33FC,$0024,$00FF,$0008; $014404 MOVE.W  #$0024,$00FF0008
        RTS                                     ; $01440C
loc_01440E:
        MOVE.W  $C082.W,D0                      ; $01440E
        MOVEA.L $04(PC,D0.W),A1                 ; $014412
        JMP     (A1)                            ; $014416
        ORI.L  #$44380089,A1                    ; $014418
        NEG.W  (A0)                             ; $01441E
        ORI.L  #$446C0089,A1                    ; $014420
        NEG.L  $0089(A0)                        ; $014426
        NEG    (A0)                             ; $01442A
        ORI.L  #$44F20089,A1                    ; $01442C
        DC.W    $4518               ; $014432 DC.W    $4518
        ORI.L  #$45404278,A1                    ; $014434
        AND.L  D4,D0                            ; $01443A
        CLR.W  $A008.W                          ; $01443C
        ADDQ.W  #4,$C082.W                      ; $014440
        MOVE.W  #$001E,$A006.W                  ; $014444
        MOVE.W  #$0801,$A008.W                  ; $01444A
        LEA     $0090E732,A1                    ; $014450
        MOVE.L  #$00009A00,D1                   ; $014456
        JSR     loc_0145F0(PC)                  ; $01445C
        SUBQ.W  #1,$A006.W                      ; $014460
        BGT.S  loc_01446A                       ; $014464
        ADDQ.W  #4,$C082.W                      ; $014466
loc_01446A:
        RTS                                     ; $01446A
        JSR     loc_014566(PC)                  ; $01446C
        BEQ.S  loc_014478                       ; $014470
        MOVE.W  #$000F,$C084.W                  ; $014472
loc_014478:
        LEA     $01B0(PC),A0                    ; $014478
        MOVE.W  $C084.W,D0                      ; $01447C
        ASL.W  #2,D0                            ; $014480
        MOVEA.L $00(A0,D0.W),A1                 ; $014482
        MOVE.L  #$00009A00,D1                   ; $014486
        JSR     loc_0145F0(PC)                  ; $01448C
        ADDQ.W  #1,$C084.W                      ; $014490
        CMPI.W  #$000F,$C084.W                  ; $014494
        BLE.S  loc_0144A6                       ; $01449A
        ADDQ.W  #4,$C082.W                      ; $01449C
        MOVE.W  #$0028,$A006.W                  ; $0144A0
loc_0144A6:
        RTS                                     ; $0144A6
        LEA     $009286AE,A1                    ; $0144A8
        MOVE.L  #$00009A00,D1                   ; $0144AE
        JSR     loc_0145F0(PC)                  ; $0144B4
        SUBQ.W  #1,$A006.W                      ; $0144B8
        BGT.S  loc_0144CE                       ; $0144BC
        ADDQ.W  #4,$C082.W                      ; $0144BE
        MOVE.B  #$00F0,$C822.W                  ; $0144C2
        MOVE.W  #$0802,$A008.W                  ; $0144C8
loc_0144CE:
        RTS                                     ; $0144CE
        LEA     $009286AE,A1                    ; $0144D0
        MOVE.L  #$00009A00,D1                   ; $0144D6
        JSR     loc_0145F0(PC)                  ; $0144DC
        TST.W  $A008.W                          ; $0144E0
        BNE.S  loc_0144F0                       ; $0144E4
        ADDQ.W  #4,$C082.W                      ; $0144E6
        MOVE.W  #$0801,$A008.W                  ; $0144EA
loc_0144F0:
        RTS                                     ; $0144F0
        LEA     $00929CA6,A1                    ; $0144F2
        MOVE.L  #$00002000,D1                   ; $0144F8
        JSR     loc_0145F0(PC)                  ; $0144FE
        TST.W  $A008.W                          ; $014502
        BNE.S  loc_014516                       ; $014506
        CLR.W  $A008.W                          ; $014508
        ADDQ.W  #4,$C082.W                      ; $01450C
        MOVE.W  #$0014,$A006.W                  ; $014510
loc_014516:
        RTS                                     ; $014516
        LEA     $00929CA6,A1                    ; $014518
        MOVE.L  #$00002000,D1                   ; $01451E
        JSR     loc_0145F0(PC)                  ; $014524
        SUBQ.W  #1,$A006.W                      ; $014528
        BGT.S  loc_01453E                       ; $01452C
        ADDQ.W  #4,$C082.W                      ; $01452E
        MOVE.B  #$00F0,$C822.W                  ; $014532
        MOVE.W  #$0802,$A008.W                  ; $014538
loc_01453E:
        RTS                                     ; $01453E
        TST.W  $A008.W                          ; $014540
        BNE.S  loc_014564                       ; $014544
        DC.W    $33FC,$0020,$00FF,$0008; $014546 MOVE.W  #$0020,$00FF0008
        MOVE.B  #$0000,$C080.W                  ; $01454E
        DC.W    $23FC,$0088,$53B0,$00FF,$0002; $014554 MOVE.L  #$008853B0,$00FF0002
        JMP     $00882890                       ; $01455E
loc_014564:
        RTS                                     ; $014564
loc_014566:
        MOVE.B  $C86D.W,D0                      ; $014566
        CMPI.B  #$000D,$C810.W                  ; $01456A
        BNE.S  loc_014576                       ; $014570
        OR.B   $C86F.W,D0                       ; $014572
loc_014576:
        DC.W    $0200,$0080         ; $014576 ANDI.B  #$0080,D0
        RTS                                     ; $01457A
loc_01457C:
        NOP                                     ; $01457C
        NOP                                     ; $01457E
        NOP                                     ; $014580
        TST.W  $A008.W                          ; $014582
        BEQ.W  loc_0145E8                       ; $014586
        LEA     $A100.W,A1                      ; $01458A
        MOVEQ   #$00,D2                         ; $01458E
        MOVE.B  $A008.W,D2                      ; $014590
        CMPI.B  #$0002,$A009.W                  ; $014594
        BEQ.S  loc_0145A4                       ; $01459A
        MOVE.W  #$0008,D2                       ; $01459C
        SUB.B  $A008.W,D2                       ; $0145A0
loc_0145A4:
        MOVE.W  #$00FF,D1                       ; $0145A4
loc_0145A8:
        MOVE.W  (A1),D0                         ; $0145A8
        MOVE.W  D0,D3                           ; $0145AA
        ANDI.W  #$001F,D3                       ; $0145AC
        MULU    D2,D3                           ; $0145B0
        LSR.W  #3,D3                            ; $0145B2
        ANDI.W  #$001F,D3                       ; $0145B4
        MOVE.W  D0,D4                           ; $0145B8
        ANDI.W  #$03E0,D4                       ; $0145BA
        MULU    D2,D4                           ; $0145BE
        LSR.W  #3,D4                            ; $0145C0
        ANDI.W  #$03E0,D4                       ; $0145C2
        MOVE.W  D0,D5                           ; $0145C6
        ANDI.W  #$7C00,D5                       ; $0145C8
        MULU    D2,D5                           ; $0145CC
        LSR.L  #3,D5                            ; $0145CE
        ANDI.W  #$7C00,D5                       ; $0145D0
        OR.W   D4,D3                            ; $0145D4
        OR.W   D5,D3                            ; $0145D6
        MOVE.W  D3,(A1)+                        ; $0145D8
        DBRA    D1,loc_0145A8                   ; $0145DA
        SUBQ.B  #1,$A008.W                      ; $0145DE
        BNE.S  loc_0145E8                       ; $0145E2
        CLR.W  $A008.W                          ; $0145E4
loc_0145E8:
        NOP                                     ; $0145E8
        NOP                                     ; $0145EA
        NOP                                     ; $0145EC
        RTS                                     ; $0145EE
loc_0145F0:
        MOVE.W  (A1)+,D2                        ; $0145F0
        MOVE.W  (A1)+,D3                        ; $0145F2
        MOVE.W  (A1)+,D0                        ; $0145F4
        MOVEA.L A1,A2                           ; $0145F6
        LEA     $A100.W,A3                      ; $0145F8
        MOVE.W  D0,D4                           ; $0145FC
        ADD.W  D4,D4                            ; $0145FE
        SUBQ.W  #1,D4                           ; $014600
loc_014602:
        MOVE.L  (A2)+,(A3)+                     ; $014602
        DBRA    D4,loc_014602                   ; $014604
        ADD.W  D0,D0                            ; $014608
        LEA     $00(A1,D0.W),A1                 ; $01460A
        LEA     $00844000,A3                    ; $01460E
        ADDA.L  D1,A3                           ; $014614
loc_014616:
        LEA     (A3),A2                         ; $014616
        MOVE.W  (A1)+,D4                        ; $014618
loc_01461A:
        MOVE.W  (A1)+,(A2)+                     ; $01461A
        DBRA    D4,loc_01461A                   ; $01461C
        LEA     $0200(A3),A3                    ; $014620
        DBRA    D3,loc_014616                   ; $014624
        RTS                                     ; $014628
        ORI.L  #$E7320090,(A0)                  ; $01462A
        MOVE.W  $0091(A0),-(A6)                 ; $014630
        DC.W    $1BCA               ; $014634 MOVE.B  A2,<EA:3D>
        ORI.L  #$3DA60091,(A1)                  ; $014636
        SLE     -(A0)                           ; $01463C
        ORI.L  #$81900091,(A1)                  ; $01463E
        MOVE.L  (A0)+,$0091.W                   ; $014644
        DC.W    $C2FE               ; $014648 MULU    <EA:3E>,D1
        ORI.L  #$E21A0091,(A1)                  ; $01464A
        MOVE.W  -$6E(A6,D0.W),$1662(A6)         ; $014650
        ORI.L  #$2DD40092,(A2)                  ; $014656
        NEG    D0                               ; $01465C
        ORI.L  #$5AEA0092,(A2)                  ; $01465E
        MOVEQ   #-$3A,D0                        ; $014664
        ORI.L  #$86AE7000,(A2)                  ; $014666
        MOVE.B  D0,$C80D.W                      ; $01466C
        MOVE.B  D0,$00FF6870                    ; $014670
        MOVE.B  D0,$00FF68A0                    ; $014676
        MOVE.B  D0,$00FF6820                    ; $01467C
        MOVE.B  D0,$00FF6850                    ; $014682
        MOVE.B  D0,$00FF6830                    ; $014688
        MOVE.B  D0,$00FF68B0                    ; $01468E
        RTS                                     ; $014694
        MOVE.B  #$0001,$C80D.W                  ; $014696
        MOVEM.L -(A7),D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6/A7; $01469C
        NOT    #$2700                           ; $0146A0
        JSR     $0088D1D4                       ; $0146A4
        NOT    #$2300                           ; $0146AA
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,(A7)+; $0146AE
        RTS                                     ; $0146B2
        MOVE.B  #$0001,$C30D.W                  ; $0146B4
        RTS                                     ; $0146BA
        BSET    #0,$C30E.W                      ; $0146BC
        MOVE.W  $C096.W,$C07A.W                 ; $0146C2
        RTS                                     ; $0146C8
        MOVEQ   #$01,D0                         ; $0146CA
        ADD.W  D0,$C054.W                       ; $0146CC
        DC.W    $33F8,$C054,$00FF,$6104; $0146D0 MOVE.W  $C054.W,$00FF6104
        RTS                                     ; $0146D8
        MOVEQ   #$01,D0                         ; $0146DA
        SUB.W  D0,$C054.W                       ; $0146DC
        DC.W    $33F8,$C054,$00FF,$6104; $0146E0 MOVE.W  $C054.W,$00FF6104
        RTS                                     ; $0146E8
        MOVEQ   #$01,D0                         ; $0146EA
        ADD.W  D0,$C056.W                       ; $0146EC
        DC.W    $33F8,$C056,$00FF,$6106; $0146F0 MOVE.W  $C056.W,$00FF6106
        RTS                                     ; $0146F8
        MOVEQ   #$01,D0                         ; $0146FA
        SUB.W  D0,$C056.W                       ; $0146FC
        DC.W    $33F8,$C056,$00FF,$6106; $014700 MOVE.W  $C056.W,$00FF6106
        RTS                                     ; $014708
        MOVEQ   #$20,D0                         ; $01470A
        ADD.W  D0,$C054.W                       ; $01470C
        DC.W    $33F8,$C054,$00FF,$6104; $014710 MOVE.W  $C054.W,$00FF6104
        RTS                                     ; $014718
        MOVEQ   #$20,D0                         ; $01471A
        SUB.W  D0,$C054.W                       ; $01471C
        DC.W    $33F8,$C054,$00FF,$6104; $014720 MOVE.W  $C054.W,$00FF6104
        RTS                                     ; $014728
        MOVEQ   #$20,D0                         ; $01472A
        ADD.W  D0,$C056.W                       ; $01472C
        DC.W    $33F8,$C056,$00FF,$6106; $014730 MOVE.W  $C056.W,$00FF6106
        RTS                                     ; $014738
        MOVEQ   #$20,D0                         ; $01473A
        SUB.W  D0,$C056.W                       ; $01473C
        DC.W    $33F8,$C056,$00FF,$6106; $014740 MOVE.W  $C056.W,$00FF6106
        RTS                                     ; $014748
        MOVE.W  $C8B0.W,D0                      ; $01474A
        ADD.W  D0,$C056.W                       ; $01474E
        RTS                                     ; $014752
        MOVE.W  $C8B0.W,D0                      ; $014754
        SUB.W  D0,$C056.W                       ; $014758
        RTS                                     ; $01475C
        MOVE.W  $C8B2.W,D0                      ; $01475E
        ADD.W  D0,$C086.W                       ; $014762
        RTS                                     ; $014766
        MOVE.W  $C8B2.W,D0                      ; $014768
        SUB.W  D0,$C086.W                       ; $01476C
        RTS                                     ; $014770
        MOVE.W  $C8B4.W,D0                      ; $014772
        ADD.W  D0,$C0B0.W                       ; $014776
        RTS                                     ; $01477A
        MOVE.W  $C8B4.W,D0                      ; $01477C
        SUB.W  D0,$C0B0.W                       ; $014780
        RTS                                     ; $014784
        MOVE.W  $C8B6.W,D0                      ; $014786
        ADD.W  D0,$C0AE.W                       ; $01478A
        RTS                                     ; $01478E
        MOVE.W  $C8B6.W,D0                      ; $014790
        SUB.W  D0,$C0AE.W                       ; $014794
        RTS                                     ; $014798
        MOVE.W  $C8B8.W,D0                      ; $01479A
        ADD.W  D0,$C0B2.W                       ; $01479E
        RTS                                     ; $0147A2
        MOVE.W  $C8B8.W,D0                      ; $0147A4
        SUB.W  D0,$C0B2.W                       ; $0147A8
        RTS                                     ; $0147AC
        MOVE.W  $C8BA.W,D0                      ; $0147AE
        ADD.W  D0,$C054.W                       ; $0147B2
        RTS                                     ; $0147B6
        MOVE.W  $C8BA.W,D0                      ; $0147B8
        SUB.W  D0,$C054.W                       ; $0147BC
        RTS                                     ; $0147C0
        MOVE.W  #$0000,$C086.W                  ; $0147C2
        MOVE.W  #$F400,$C054.W                  ; $0147C8
        MOVE.W  #$3400,$C056.W                  ; $0147CE
        MOVE.W  #$0000,$C0AE.W                  ; $0147D4
        MOVE.W  #$0800,$C0B0.W                  ; $0147DA
        MOVE.W  #$0000,$C0B2.W                  ; $0147E0
        RTS                                     ; $0147E6
        MOVE.W  #$0080,$C8B0.W                  ; $0147E8
        MOVE.W  #$0080,$C8B2.W                  ; $0147EE
        MOVE.W  #$0080,$C8B4.W                  ; $0147F4
        MOVE.W  #$0080,$C8B6.W                  ; $0147FA
        MOVE.W  #$0080,$C8B8.W                  ; $014800
        MOVE.W  #$0080,$C8BA.W                  ; $014806
        RTS                                     ; $01480C
        ADDI.W  #$0400,$903C.W                  ; $01480E
        RTS                                     ; $014814
        SUBI.W  #$0400,$903C.W                  ; $014816
        RTS                                     ; $01481C
        ADDI.W  #$1000,$903C.W                  ; $01481E
        RTS                                     ; $014824
        ADDI.W  #$2000,$903C.W                  ; $014826
        RTS                                     ; $01482C
        MOVE.L  $C888.W,D0                      ; $01482E
        ADDQ.L  #8,D0                           ; $014832
        CMPI.L  #$00FFFFFF,D0                   ; $014834
        BLE.S  loc_014842                       ; $01483A
        MOVE.L  #$00FF0000,D0                   ; $01483C
loc_014842:
        MOVE.L  D0,$C888.W                      ; $014842
        RTS                                     ; $014846
        MOVE.L  $C888.W,D0                      ; $014848
        SUBQ.L  #8,D0                           ; $01484C
        CMPI.L  #$00FF6000,D0                   ; $01484E
        BGE.S  loc_01485C                       ; $014854
        MOVE.L  #$00FFFFF7,D0                   ; $014856
loc_01485C:
        MOVE.L  D0,$C888.W                      ; $01485C
        RTS                                     ; $014860
        MOVE.W  (A1),D0                         ; $014862
        CMP.W  (A2),D0                          ; $014864
        BEQ.S  loc_01486A                       ; $014866
        MOVE.W  D0,(A2)                         ; $014868
loc_01486A:
        ADDI.W  #$0010,(A2)                     ; $01486A
        MOVE.W  (A2),(A1)                       ; $01486E
        RTS                                     ; $014870
        MOVE.W  (A1),D0                         ; $014872
        CMP.W  (A2),D0                          ; $014874
        BEQ.S  loc_01487A                       ; $014876
        MOVE.W  D0,(A2)                         ; $014878
loc_01487A:
        SUBI.W  #$0010,(A2)                     ; $01487A
        MOVE.W  (A2),(A1)                       ; $01487E
        RTS                                     ; $014880
        RTS                                     ; $014882
        RTS                                     ; $014884
        RTS                                     ; $014886
        ORI.L  #$48860089,A1                    ; $014888
        EXT.W   D2                              ; $01488E
        ORI.L  #$48820089,A1                    ; $014890
        EXT.W   D6                              ; $014896
        ORI.L  #$48820089,A1                    ; $014898
        EXT.W   D2                              ; $01489E
        ORI.L  #$48820089,A1                    ; $0148A0
        EXT.W   D6                              ; $0148A6
        ORI.L  #$48820089,A1                    ; $0148A8
        EXT.W   D2                              ; $0148AE
        ORI.L  #$48820089,A1                    ; $0148B0
        EXT.W   D6                              ; $0148B6
        ORI.L  #$48860089,A1                    ; $0148B8
        EXT.W   D6                              ; $0148BE
        ORI.L  #$48860089,A1                    ; $0148C0
        EXT.W   D6                              ; $0148C6
        ORI.L  #$48820089,A1                    ; $0148C8
        EXT.W   D2                              ; $0148CE
        ORI.L  #$48820089,A1                    ; $0148D0
        EXT.W   D6                              ; $0148D6
        ORI.L  #$48820089,A1                    ; $0148D8
        EXT.W   D2                              ; $0148DE
        ORI.L  #$48820089,A1                    ; $0148E0
        EXT.W   D6                              ; $0148E6
        ORI.L  #$48820089,A1                    ; $0148E8
        EXT.W   D2                              ; $0148EE
        ORI.L  #$48820089,A1                    ; $0148F0
        EXT.W   D6                              ; $0148F6
        ORI.L  #$48860089,A1                    ; $0148F8
        EXT.W   D6                              ; $0148FE
        ORI.L  #$48860089,A1                    ; $014900
        EXT.W   D6                              ; $014906
        ORI.L  #$48820089,A1                    ; $014908
        EXT.W   D2                              ; $01490E
        ORI.L  #$48820089,A1                    ; $014910
        EXT.W   D6                              ; $014916
        ORI.L  #$48160089,A1                    ; $014918
        EXT.W   D2                              ; $01491E
        ORI.L  #$48820089,A1                    ; $014920
        EXT.W   D6                              ; $014926
        ORI.L  #$480E0089,A1                    ; $014928
        EXT.W   D2                              ; $01492E
        ORI.L  #$48820089,A1                    ; $014930
        EXT.W   D6                              ; $014936
        ORI.L  #$48860089,A1                    ; $014938
        EXT.W   D6                              ; $01493E
        ORI.L  #$48860089,A1                    ; $014940
        EXT.W   D6                              ; $014946
        ORI.L  #$48820089,A1                    ; $014948
        EXT.W   D2                              ; $01494E
        ORI.L  #$48820089,A1                    ; $014950
        EXT.W   D6                              ; $014956
        ORI.L  #$48820089,A1                    ; $014958
        EXT.W   D2                              ; $01495E
        ORI.L  #$48820089,A1                    ; $014960
        EXT.W   D6                              ; $014966
        ORI.L  #$48820089,A1                    ; $014968
        EXT.W   D2                              ; $01496E
        ORI.L  #$48820089,A1                    ; $014970
        EXT.W   D6                              ; $014976
        ORI.L  #$48860089,A1                    ; $014978
        EXT.W   D6                              ; $01497E
        ORI.L  #$48860089,A1                    ; $014980
        EXT.W   D6                              ; $014986
        ORI.L  #$48820089,A1                    ; $014988
        PEA     A0                              ; $01498E
        ORI.L  #$482E0089,A1                    ; $014990
        EXT.W   D6                              ; $014996
        ORI.L  #$48820089,A1                    ; $014998
        EXT.W   D2                              ; $01499E
        ORI.L  #$48820089,A1                    ; $0149A0
        EXT.W   D6                              ; $0149A6
        ORI.L  #$48820089,A1                    ; $0149A8
        EXT.W   D2                              ; $0149AE
        ORI.L  #$48820089,A1                    ; $0149B0
        EXT.W   D6                              ; $0149B6
        ORI.L  #$48860089,A1                    ; $0149B8
        EXT.W   D6                              ; $0149BE
        ORI.L  #$48860089,A1                    ; $0149C0
        EXT.W   D6                              ; $0149C6
        ORI.L  #$48820089,A1                    ; $0149C8
        EXT.W   D2                              ; $0149CE
        ORI.L  #$48820089,A1                    ; $0149D0
        EXT.W   D6                              ; $0149D6
        ORI.L  #$48820089,A1                    ; $0149D8
        EXT.W   D2                              ; $0149DE
        ORI.L  #$48820089,A1                    ; $0149E0
        EXT.W   D6                              ; $0149E6
        ORI.L  #$48820089,A1                    ; $0149E8
        EXT.W   D2                              ; $0149EE
        ORI.L  #$48820089,A1                    ; $0149F0
        EXT.W   D6                              ; $0149F6
        ORI.L  #$48860089,A1                    ; $0149F8
        EXT.W   D6                              ; $0149FE
        ORI.L  #$48860089,A1                    ; $014A00
        EXT.W   D6                              ; $014A06
        ORI.L  #$48820089,A1                    ; $014A08
        EXT.W   D2                              ; $014A0E
        ORI.L  #$48820089,A1                    ; $014A10
        EXT.W   D6                              ; $014A16
        ORI.L  #$48820089,A1                    ; $014A18
        EXT.W   D2                              ; $014A1E
        ORI.L  #$48820089,A1                    ; $014A20
        EXT.W   D6                              ; $014A26
        ORI.L  #$48820089,A1                    ; $014A28
        EXT.W   D2                              ; $014A2E
        ORI.L  #$48820089,A1                    ; $014A30
        EXT.W   D6                              ; $014A36
        ORI.L  #$48860089,A1                    ; $014A38
        EXT.W   D6                              ; $014A3E
        ORI.L  #$48860089,A1                    ; $014A40
        EXT.W   D6                              ; $014A46
        ORI.L  #$466A0089,A1                    ; $014A48
        NOT.L  -$77(A4,D0.W)                    ; $014A4E
        NOT.L  #$00894886                       ; $014A52
        ORI.L  #$48260089,A1                    ; $014A58
        EXT.W   D2                              ; $014A5E
        ORI.L  #$48820089,A1                    ; $014A60
        EXT.W   D6                              ; $014A66
        ORI.L  #$481E0089,A1                    ; $014A68
        EXT.W   D2                              ; $014A6E
        ORI.L  #$48820089,A1                    ; $014A70
        EXT.W   D6                              ; $014A76
        ORI.L  #$48860089,A1                    ; $014A78
        EXT.W   D6                              ; $014A7E
        ORI.L  #$48860089,A1                    ; $014A80
        EXT.W   D6                              ; $014A86
        ORI.L  #$48820089,A1                    ; $014A88
        NOT    A2                               ; $014A8E
        ORI.L  #$46DA0089,A1                    ; $014A90
        EXT.W   D6                              ; $014A96
        ORI.L  #$46FA0089,A1                    ; $014A98
        EXT.W   D2                              ; $014A9E
        ORI.L  #$48820089,A1                    ; $014AA0
        EXT.W   D6                              ; $014AA6
        ORI.L  #$46EA0089,A1                    ; $014AA8
        EXT.W   D2                              ; $014AAE
        ORI.L  #$48820089,A1                    ; $014AB0
        EXT.W   D6                              ; $014AB6
        ORI.L  #$48860089,A1                    ; $014AB8
        EXT.W   D6                              ; $014ABE
        ORI.L  #$48860089,A1                    ; $014AC0
        EXT.W   D6                              ; $014AC6
        ORI.L  #$48820089,A1                    ; $014AC8
        EXT.W   D2                              ; $014ACE
        ORI.L  #$48820089,A1                    ; $014AD0
        EXT.W   D6                              ; $014AD6
        ORI.L  #$48820089,A1                    ; $014AD8
        EXT.W   D2                              ; $014ADE
        ORI.L  #$48820089,A1                    ; $014AE0
        EXT.W   D6                              ; $014AE6
        ORI.L  #$48820089,A1                    ; $014AE8
        EXT.W   D2                              ; $014AEE
        ORI.L  #$48820089,A1                    ; $014AF0
        EXT.W   D6                              ; $014AF6
        ORI.L  #$48860089,A1                    ; $014AF8
        EXT.W   D6                              ; $014AFE
        ORI.L  #$48860089,A1                    ; $014B00
        EXT.W   D6                              ; $014B06
        ORI.L  #$48820089,A1                    ; $014B08
        EXT.W   D2                              ; $014B0E
        ORI.L  #$48820089,A1                    ; $014B10
        EXT.W   D6                              ; $014B16
        ORI.L  #$48820089,A1                    ; $014B18
        EXT.W   D2                              ; $014B1E
        ORI.L  #$48820089,A1                    ; $014B20
        EXT.W   D6                              ; $014B26
        ORI.L  #$48820089,A1                    ; $014B28
        EXT.W   D2                              ; $014B2E
        ORI.L  #$48820089,A1                    ; $014B30
        EXT.W   D6                              ; $014B36
        ORI.L  #$48860089,A1                    ; $014B38
        EXT.W   D6                              ; $014B3E
        ORI.L  #$48860089,A1                    ; $014B40
        EXT.W   D6                              ; $014B46
        ORI.L  #$48820089,A1                    ; $014B48
        EXT.W   D2                              ; $014B4E
        ORI.L  #$48820089,A1                    ; $014B50
        EXT.W   D6                              ; $014B56
        ORI.L  #$48820089,A1                    ; $014B58
        EXT.W   D2                              ; $014B5E
        ORI.L  #$48820089,A1                    ; $014B60
        EXT.W   D6                              ; $014B66
        ORI.L  #$48820089,A1                    ; $014B68
        EXT.W   D2                              ; $014B6E
        ORI.L  #$48820089,A1                    ; $014B70
        EXT.W   D6                              ; $014B76
        ORI.L  #$48860089,A1                    ; $014B78
        EXT.W   D6                              ; $014B7E
        ORI.L  #$48860089,A1                    ; $014B80
        EXT.W   D6                              ; $014B86
        ORI.L  #$48820089,A1                    ; $014B88
        DC.W    $470A               ; $014B8E DC.W    $470A
        ORI.L  #$471A0089,A1                    ; $014B90
        EXT.W   D6                              ; $014B96
        ORI.L  #$473A0089,A1                    ; $014B98
        EXT.W   D2                              ; $014B9E
        ORI.L  #$48820089,A1                    ; $014BA0
        EXT.W   D6                              ; $014BA6
        ORI.L  #$472A0089,A1                    ; $014BA8
        EXT.W   D2                              ; $014BAE
        ORI.L  #$48820089,A1                    ; $014BB0
        EXT.W   D6                              ; $014BB6
        ORI.L  #$48860089,A1                    ; $014BB8
        EXT.W   D6                              ; $014BBE
        ORI.L  #$48860089,A1                    ; $014BC0
        EXT.W   D6                              ; $014BC6
        ORI.L  #$48820089,A1                    ; $014BC8
        EXT.W   D2                              ; $014BCE
        ORI.L  #$48820089,A1                    ; $014BD0
        EXT.W   D6                              ; $014BD6
        ORI.L  #$48820089,A1                    ; $014BD8
        EXT.W   D2                              ; $014BDE
        ORI.L  #$48820089,A1                    ; $014BE0
        EXT.W   D6                              ; $014BE6
        ORI.L  #$48820089,A1                    ; $014BE8
        EXT.W   D2                              ; $014BEE
        ORI.L  #$48820089,A1                    ; $014BF0
        EXT.W   D6                              ; $014BF6
        ORI.L  #$48860089,A1                    ; $014BF8
        EXT.W   D6                              ; $014BFE
        ORI.L  #$48860089,A1                    ; $014C00
        EXT.W   D6                              ; $014C06
        ORI.L  #$48820089,A1                    ; $014C08
        EXT.W   D2                              ; $014C0E
        ORI.L  #$48820089,A1                    ; $014C10
        EXT.W   D6                              ; $014C16
        ORI.L  #$48820089,A1                    ; $014C18
        EXT.W   D2                              ; $014C1E
        ORI.L  #$48820089,A1                    ; $014C20
        EXT.W   D6                              ; $014C26
        ORI.L  #$48820089,A1                    ; $014C28
        EXT.W   D2                              ; $014C2E
        ORI.L  #$48820089,A1                    ; $014C30
        EXT.W   D6                              ; $014C36
        ORI.L  #$48860089,A1                    ; $014C38
        EXT.W   D6                              ; $014C3E
        ORI.L  #$48860089,A1                    ; $014C40
        EXT.W   D6                              ; $014C46
        ORI.L  #$46960089,A1                    ; $014C48
        EXT.W   D2                              ; $014C4E
        ORI.L  #$48820089,A1                    ; $014C50
        EXT.W   D6                              ; $014C56
        ORI.L  #$48820089,A1                    ; $014C58
        EXT.W   D2                              ; $014C5E
        ORI.L  #$48820089,A1                    ; $014C60
        EXT.W   D6                              ; $014C66
        ORI.L  #$48820089,A1                    ; $014C68
        EXT.W   D2                              ; $014C6E
        ORI.L  #$48820089,A1                    ; $014C70
        EXT.W   D6                              ; $014C76
        ORI.L  #$48860089,A1                    ; $014C78
        EXT.W   D6                              ; $014C7E
        ORI.L  #$48860089,A1                    ; $014C80
        EXT.W   D6                              ; $014C86
        ORI.L  #$48860089,A1                    ; $014C88
        EXT.W   D4                              ; $014C8E
        ORI.L  #$48840089,A1                    ; $014C90
        EXT.W   D6                              ; $014C96
        ORI.L  #$48840089,A1                    ; $014C98
        EXT.W   D4                              ; $014C9E
        ORI.L  #$48840089,A1                    ; $014CA0
        EXT.W   D6                              ; $014CA6
        ORI.L  #$48840089,A1                    ; $014CA8
        EXT.W   D4                              ; $014CAE
        ORI.L  #$48840089,A1                    ; $014CB0
        EXT.W   D6                              ; $014CB6
        ORI.L  #$48860089,A1                    ; $014CB8
        EXT.W   D6                              ; $014CBE
        ORI.L  #$48860089,A1                    ; $014CC0
        EXT.W   D6                              ; $014CC6
        ORI.L  #$48840089,A1                    ; $014CC8
        EXT.W   D4                              ; $014CCE
        ORI.L  #$48840089,A1                    ; $014CD0
        EXT.W   D6                              ; $014CD6
        ORI.L  #$48840089,A1                    ; $014CD8
        EXT.W   D4                              ; $014CDE
        ORI.L  #$48840089,A1                    ; $014CE0
        EXT.W   D6                              ; $014CE6
        ORI.L  #$48840089,A1                    ; $014CE8
        EXT.W   D4                              ; $014CEE
        ORI.L  #$48840089,A1                    ; $014CF0
        EXT.W   D6                              ; $014CF6
        ORI.L  #$48860089,A1                    ; $014CF8
        EXT.W   D6                              ; $014CFE
        ORI.L  #$48860089,A1                    ; $014D00
        EXT.W   D6                              ; $014D06
        ORI.L  #$48840089,A1                    ; $014D08
        EXT.W   D4                              ; $014D0E
        ORI.L  #$48840089,A1                    ; $014D10
        EXT.W   D6                              ; $014D16
        ORI.L  #$48840089,A1                    ; $014D18
        EXT.W   D4                              ; $014D1E
        ORI.L  #$48840089,A1                    ; $014D20
        EXT.W   D6                              ; $014D26
        ORI.L  #$48840089,A1                    ; $014D28
        EXT.W   D4                              ; $014D2E
        ORI.L  #$48840089,A1                    ; $014D30
        EXT.W   D6                              ; $014D36
        ORI.L  #$48860089,A1                    ; $014D38
        EXT.W   D6                              ; $014D3E
        ORI.L  #$48860089,A1                    ; $014D40
        EXT.W   D6                              ; $014D46
        ORI.L  #$48840089,A1                    ; $014D48
        EXT.W   D4                              ; $014D4E
        ORI.L  #$48840089,A1                    ; $014D50
        EXT.W   D6                              ; $014D56
        ORI.L  #$48840089,A1                    ; $014D58
        EXT.W   D4                              ; $014D5E
        ORI.L  #$48840089,A1                    ; $014D60
        EXT.W   D6                              ; $014D66
        ORI.L  #$48840089,A1                    ; $014D68
        EXT.W   D4                              ; $014D6E
        ORI.L  #$48840089,A1                    ; $014D70
        EXT.W   D6                              ; $014D76
        ORI.L  #$48860089,A1                    ; $014D78
        EXT.W   D6                              ; $014D7E
        ORI.L  #$48860089,A1                    ; $014D80
        EXT.W   D6                              ; $014D86
        ORI.L  #$48840089,A1                    ; $014D88
        EXT.W   D4                              ; $014D8E
        ORI.L  #$48840089,A1                    ; $014D90
        EXT.W   D6                              ; $014D96
        ORI.L  #$48840089,A1                    ; $014D98
        EXT.W   D4                              ; $014D9E
        ORI.L  #$48840089,A1                    ; $014DA0
        EXT.W   D6                              ; $014DA6
        ORI.L  #$48840089,A1                    ; $014DA8
        EXT.W   D4                              ; $014DAE
        ORI.L  #$48840089,A1                    ; $014DB0
        EXT.W   D6                              ; $014DB6
        ORI.L  #$48860089,A1                    ; $014DB8
        EXT.W   D6                              ; $014DBE
        ORI.L  #$48860089,A1                    ; $014DC0
        EXT.W   D6                              ; $014DC6
        ORI.L  #$48840089,A1                    ; $014DC8
        EXT.W   D4                              ; $014DCE
        ORI.L  #$48840089,A1                    ; $014DD0
        EXT.W   D6                              ; $014DD6
        ORI.L  #$48840089,A1                    ; $014DD8
        EXT.W   D4                              ; $014DDE
        ORI.L  #$48840089,A1                    ; $014DE0
        EXT.W   D6                              ; $014DE6
        ORI.L  #$48840089,A1                    ; $014DE8
        EXT.W   D4                              ; $014DEE
        ORI.L  #$48840089,A1                    ; $014DF0
        EXT.W   D6                              ; $014DF6
        ORI.L  #$48860089,A1                    ; $014DF8
        EXT.W   D6                              ; $014DFE
        ORI.L  #$48860089,A1                    ; $014E00
        EXT.W   D6                              ; $014E06
        ORI.L  #$48840089,A1                    ; $014E08
        EXT.W   D4                              ; $014E0E
        ORI.L  #$48840089,A1                    ; $014E10
        EXT.W   D6                              ; $014E16
        ORI.L  #$48840089,A1                    ; $014E18
        EXT.W   D4                              ; $014E1E
        ORI.L  #$48840089,A1                    ; $014E20
        EXT.W   D6                              ; $014E26
        ORI.L  #$48840089,A1                    ; $014E28
        EXT.W   D4                              ; $014E2E
        ORI.L  #$48840089,A1                    ; $014E30
        EXT.W   D6                              ; $014E36
        ORI.L  #$48860089,A1                    ; $014E38
        EXT.W   D6                              ; $014E3E
        ORI.L  #$48860089,A1                    ; $014E40
        EXT.W   D6                              ; $014E46
        ORI.L  #$48840089,A1                    ; $014E48
        EXT.W   D4                              ; $014E4E
        ORI.L  #$48840089,A1                    ; $014E50
        EXT.W   D6                              ; $014E56
        ORI.L  #$48840089,A1                    ; $014E58
        EXT.W   D4                              ; $014E5E
        ORI.L  #$48840089,A1                    ; $014E60
        EXT.W   D6                              ; $014E66
        ORI.L  #$48840089,A1                    ; $014E68
        EXT.W   D4                              ; $014E6E
        ORI.L  #$48840089,A1                    ; $014E70
        EXT.W   D6                              ; $014E76
        ORI.L  #$48860089,A1                    ; $014E78
        EXT.W   D6                              ; $014E7E
        ORI.L  #$48860089,A1                    ; $014E80
        EXT.W   D6                              ; $014E86
        ORI.L  #$48840089,A1                    ; $014E88
        EXT.W   D4                              ; $014E8E
        ORI.L  #$48840089,A1                    ; $014E90
        EXT.W   D6                              ; $014E96
        ORI.L  #$48840089,A1                    ; $014E98
        EXT.W   D4                              ; $014E9E
        ORI.L  #$48840089,A1                    ; $014EA0
        EXT.W   D6                              ; $014EA6
        ORI.L  #$48840089,A1                    ; $014EA8
        EXT.W   D4                              ; $014EAE
        ORI.L  #$48840089,A1                    ; $014EB0
        EXT.W   D6                              ; $014EB6
        ORI.L  #$48860089,A1                    ; $014EB8
        EXT.W   D6                              ; $014EBE
        ORI.L  #$48860089,A1                    ; $014EC0
        EXT.W   D6                              ; $014EC6
        ORI.L  #$48840089,A1                    ; $014EC8
        EXT.W   D4                              ; $014ECE
        ORI.L  #$48840089,A1                    ; $014ED0
        EXT.W   D6                              ; $014ED6
        ORI.L  #$48840089,A1                    ; $014ED8
        EXT.W   D4                              ; $014EDE
        ORI.L  #$48840089,A1                    ; $014EE0
        EXT.W   D6                              ; $014EE6
        ORI.L  #$48840089,A1                    ; $014EE8
        EXT.W   D4                              ; $014EEE
        ORI.L  #$48840089,A1                    ; $014EF0
        EXT.W   D6                              ; $014EF6
        ORI.L  #$48860089,A1                    ; $014EF8
        EXT.W   D6                              ; $014EFE
        ORI.L  #$48860089,A1                    ; $014F00
        EXT.W   D6                              ; $014F06
        ORI.L  #$48840089,A1                    ; $014F08
        EXT.W   D4                              ; $014F0E
        ORI.L  #$48840089,A1                    ; $014F10
        EXT.W   D6                              ; $014F16
        ORI.L  #$48840089,A1                    ; $014F18
        EXT.W   D4                              ; $014F1E
        ORI.L  #$48840089,A1                    ; $014F20
        EXT.W   D6                              ; $014F26
        ORI.L  #$48840089,A1                    ; $014F28
        EXT.W   D4                              ; $014F2E
        ORI.L  #$48840089,A1                    ; $014F30
        EXT.W   D6                              ; $014F36
        ORI.L  #$48860089,A1                    ; $014F38
        EXT.W   D6                              ; $014F3E
        ORI.L  #$48860089,A1                    ; $014F40
        EXT.W   D6                              ; $014F46
        ORI.L  #$48840089,A1                    ; $014F48
        EXT.W   D4                              ; $014F4E
        ORI.L  #$48840089,A1                    ; $014F50
        EXT.W   D6                              ; $014F56
        ORI.L  #$48840089,A1                    ; $014F58
        EXT.W   D4                              ; $014F5E
        ORI.L  #$48840089,A1                    ; $014F60
        EXT.W   D6                              ; $014F66
        ORI.L  #$48840089,A1                    ; $014F68
        EXT.W   D4                              ; $014F6E
        ORI.L  #$48840089,A1                    ; $014F70
        EXT.W   D6                              ; $014F76
        ORI.L  #$48860089,A1                    ; $014F78
        EXT.W   D6                              ; $014F7E
        ORI.L  #$48860089,A1                    ; $014F80
        EXT.W   D6                              ; $014F86
        ORI.L  #$48840089,A1                    ; $014F88
        EXT.W   D4                              ; $014F8E
        ORI.L  #$48840089,A1                    ; $014F90
        EXT.W   D6                              ; $014F96
        ORI.L  #$48840089,A1                    ; $014F98
        EXT.W   D4                              ; $014F9E
        ORI.L  #$48840089,A1                    ; $014FA0
        EXT.W   D6                              ; $014FA6
        ORI.L  #$48840089,A1                    ; $014FA8
        EXT.W   D4                              ; $014FAE
        ORI.L  #$48840089,A1                    ; $014FB0
        EXT.W   D6                              ; $014FB6
        ORI.L  #$48860089,A1                    ; $014FB8
        EXT.W   D6                              ; $014FBE
        ORI.L  #$48860089,A1                    ; $014FC0
        EXT.W   D6                              ; $014FC6
        ORI.L  #$48840089,A1                    ; $014FC8
        EXT.W   D4                              ; $014FCE
        ORI.L  #$48840089,A1                    ; $014FD0
        EXT.W   D6                              ; $014FD6
        ORI.L  #$48840089,A1                    ; $014FD8
        EXT.W   D4                              ; $014FDE
        ORI.L  #$48840089,A1                    ; $014FE0
        EXT.W   D6                              ; $014FE6
        ORI.L  #$48840089,A1                    ; $014FE8
        EXT.W   D4                              ; $014FEE
        ORI.L  #$48840089,A1                    ; $014FF0
        EXT.W   D6                              ; $014FF6
        ORI.L  #$48860089,A1                    ; $014FF8
        EXT.W   D6                              ; $014FFE
        ORI.L  #$48860089,A1                    ; $015000
        EXT.W   D6                              ; $015006
        ORI.L  #$48840089,A1                    ; $015008
        EXT.W   D4                              ; $01500E
        ORI.L  #$48840089,A1                    ; $015010
        EXT.W   D6                              ; $015016
        ORI.L  #$48840089,A1                    ; $015018
        EXT.W   D4                              ; $01501E
        ORI.L  #$48840089,A1                    ; $015020
        EXT.W   D6                              ; $015026
        ORI.L  #$48840089,A1                    ; $015028
        EXT.W   D4                              ; $01502E
        ORI.L  #$48840089,A1                    ; $015030
        EXT.W   D6                              ; $015036
        ORI.L  #$48860089,A1                    ; $015038
        EXT.W   D6                              ; $01503E
        ORI.L  #$48860089,A1                    ; $015040
        EXT.W   D6                              ; $015046
        ORI.L  #$48840089,A1                    ; $015048
        EXT.W   D4                              ; $01504E
        ORI.L  #$48840089,A1                    ; $015050
        EXT.W   D6                              ; $015056
        ORI.L  #$48840089,A1                    ; $015058
        EXT.W   D4                              ; $01505E
        ORI.L  #$48840089,A1                    ; $015060
        EXT.W   D6                              ; $015066
        ORI.L  #$48840089,A1                    ; $015068
        EXT.W   D4                              ; $01506E
        ORI.L  #$48840089,A1                    ; $015070
        EXT.W   D6                              ; $015076
        ORI.L  #$48860089,A1                    ; $015078
        EXT.W   D6                              ; $01507E
        ORI.L  #$48860089,A1                    ; $015080
        EXT.W   D6                              ; $015086
        ORI.L  #$48860089,A1                    ; $015088
        EXT.W   D6                              ; $01508E
        ORI.L  #$48860089,A1                    ; $015090
        EXT.W   D6                              ; $015096
        ORI.L  #$48860089,A1                    ; $015098
        EXT.W   D6                              ; $01509E
        ORI.L  #$48860089,A1                    ; $0150A0
        EXT.W   D6                              ; $0150A6
        ORI.L  #$48860089,A1                    ; $0150A8
        EXT.W   D6                              ; $0150AE
        ORI.L  #$48860089,A1                    ; $0150B0
        EXT.W   D6                              ; $0150B6
        ORI.L  #$48860089,A1                    ; $0150B8
        EXT.W   D6                              ; $0150BE
        ORI.L  #$48860089,A1                    ; $0150C0
        EXT.W   D6                              ; $0150C6
        ORI.L  #$48860089,A1                    ; $0150C8
        DC.W    $4786               ; $0150CE DC.W    $4786
        ORI.L  #$47900089,A1                    ; $0150D0
        EXT.W   D6                              ; $0150D6
        ORI.L  #$477C0089,A1                    ; $0150D8
        EXT.W   D6                              ; $0150DE
        ORI.L  #$48860089,A1                    ; $0150E0
        EXT.W   D6                              ; $0150E6
        ORI.L  #$47720089,A1                    ; $0150E8
        EXT.W   D6                              ; $0150EE
        ORI.L  #$48860089,A1                    ; $0150F0
        EXT.W   D6                              ; $0150F6
        ORI.L  #$48860089,A1                    ; $0150F8
        EXT.W   D6                              ; $0150FE
        ORI.L  #$48860089,A1                    ; $015100
        EXT.W   D6                              ; $015106
        ORI.L  #$48860089,A1                    ; $015108
        DC.W    $474A               ; $01510E DC.W    $474A
        ORI.L  #$47540089,A1                    ; $015110
        EXT.W   D6                              ; $015116
        ORI.L  #$47680089,A1                    ; $015118
        EXT.W   D6                              ; $01511E
        ORI.L  #$48860089,A1                    ; $015120
        EXT.W   D6                              ; $015126
        ORI.L  #$475E0089,A1                    ; $015128
        EXT.W   D6                              ; $01512E
        ORI.L  #$48860089,A1                    ; $015130
        EXT.W   D6                              ; $015136
        ORI.L  #$48860089,A1                    ; $015138
        EXT.W   D6                              ; $01513E
        ORI.L  #$48860089,A1                    ; $015140
        EXT.W   D6                              ; $015146
        ORI.L  #$48860089,A1                    ; $015148
        EXT.W   D6                              ; $01514E
        ORI.L  #$48860089,A1                    ; $015150
        EXT.W   D6                              ; $015156
        ORI.L  #$48860089,A1                    ; $015158
        EXT.W   D6                              ; $01515E
        ORI.L  #$48860089,A1                    ; $015160
        EXT.W   D6                              ; $015166
        ORI.L  #$48860089,A1                    ; $015168
        EXT.W   D6                              ; $01516E
        ORI.L  #$48860089,A1                    ; $015170
        EXT.W   D6                              ; $015176
        ORI.L  #$48860089,A1                    ; $015178
        EXT.W   D6                              ; $01517E
        ORI.L  #$48860089,A1                    ; $015180
        EXT.W   D6                              ; $015186
        ORI.L  #$48860089,A1                    ; $015188
        DC.W    $47AE               ; $01518E DC.W    $47AE
        ORI.L  #$47B80089,A1                    ; $015190
        EXT.W   D6                              ; $015196
        ORI.L  #$47A40089,A1                    ; $015198
        EXT.W   D6                              ; $01519E
        ORI.L  #$48860089,A1                    ; $0151A0
        EXT.W   D6                              ; $0151A6
        ORI.L  #$479A0089,A1                    ; $0151A8
        EXT.W   D6                              ; $0151AE
        ORI.L  #$48860089,A1                    ; $0151B0
        EXT.W   D6                              ; $0151B6
        ORI.L  #$48860089,A1                    ; $0151B8
        EXT.W   D6                              ; $0151BE
        ORI.L  #$48860089,A1                    ; $0151C0
        EXT.W   D6                              ; $0151C6
        ORI.L  #$48860089,A1                    ; $0151C8
        EXT.W   D6                              ; $0151CE
        ORI.L  #$48860089,A1                    ; $0151D0
        EXT.W   D6                              ; $0151D6
        ORI.L  #$48860089,A1                    ; $0151D8
        EXT.W   D6                              ; $0151DE
        ORI.L  #$48860089,A1                    ; $0151E0
        EXT.W   D6                              ; $0151E6
        ORI.L  #$48860089,A1                    ; $0151E8
        EXT.W   D6                              ; $0151EE
        ORI.L  #$48860089,A1                    ; $0151F0
        EXT.W   D6                              ; $0151F6
        ORI.L  #$48860089,A1                    ; $0151F8
        EXT.W   D6                              ; $0151FE
        ORI.L  #$48860089,A1                    ; $015200
        EXT.W   D6                              ; $015206
        ORI.L  #$48860089,A1                    ; $015208
        EXT.W   D6                              ; $01520E
        ORI.L  #$48860089,A1                    ; $015210
        EXT.W   D6                              ; $015216
        ORI.L  #$48860089,A1                    ; $015218
        EXT.W   D6                              ; $01521E
        ORI.L  #$48860089,A1                    ; $015220
        EXT.W   D6                              ; $015226
        ORI.L  #$48860089,A1                    ; $015228
        EXT.W   D6                              ; $01522E
        ORI.L  #$48860089,A1                    ; $015230
        EXT.W   D6                              ; $015236
        ORI.L  #$48860089,A1                    ; $015238
        EXT.W   D6                              ; $01523E
        ORI.L  #$48860089,A1                    ; $015240
        EXT.W   D6                              ; $015246
        ORI.L  #$47C20089,A1                    ; $015248
        EXT.W   D6                              ; $01524E
        ORI.L  #$48860089,A1                    ; $015250
        EXT.W   D6                              ; $015256
        ORI.L  #$48860089,A1                    ; $015258
        EXT.W   D6                              ; $01525E
        ORI.L  #$48860089,A1                    ; $015260
        EXT.W   D6                              ; $015266
        ORI.L  #$48860089,A1                    ; $015268
        EXT.W   D6                              ; $01526E
        ORI.L  #$48860089,A1                    ; $015270
        EXT.W   D6                              ; $015276
        ORI.L  #$48860089,A1                    ; $015278
        EXT.W   D6                              ; $01527E
        ORI.L  #$48860089,A1                    ; $015280
        EXT.W   D6                              ; $015286
        ORI.L  #$48860089,A1                    ; $015288
        EXT.W   D6                              ; $01528E
        ORI.L  #$48860089,A1                    ; $015290
        EXT.W   D6                              ; $015296
        ORI.L  #$48860089,A1                    ; $015298
        EXT.W   D6                              ; $01529E
        ORI.L  #$48860089,A1                    ; $0152A0
        EXT.W   D6                              ; $0152A6
        ORI.L  #$48860089,A1                    ; $0152A8
        EXT.W   D6                              ; $0152AE
        ORI.L  #$48860089,A1                    ; $0152B0
        EXT.W   D6                              ; $0152B6
        ORI.L  #$48860089,A1                    ; $0152B8
        EXT.W   D6                              ; $0152BE
        ORI.L  #$48860089,A1                    ; $0152C0
        EXT.W   D6                              ; $0152C6
        ORI.L  #$48860089,A1                    ; $0152C8
        EXT.W   D6                              ; $0152CE
        ORI.L  #$48860089,A1                    ; $0152D0
        EXT.W   D6                              ; $0152D6
        ORI.L  #$48860089,A1                    ; $0152D8
        EXT.W   D6                              ; $0152DE
        ORI.L  #$48860089,A1                    ; $0152E0
        EXT.W   D6                              ; $0152E6
        ORI.L  #$48860089,A1                    ; $0152E8
        EXT.W   D6                              ; $0152EE
        ORI.L  #$48860089,A1                    ; $0152F0
        EXT.W   D6                              ; $0152F6
        ORI.L  #$48860089,A1                    ; $0152F8
        EXT.W   D6                              ; $0152FE
        ORI.L  #$48860089,A1                    ; $015300
        EXT.W   D6                              ; $015306
        ORI.L  #$48860089,A1                    ; $015308
        EXT.W   D6                              ; $01530E
        ORI.L  #$48860089,A1                    ; $015310
        EXT.W   D6                              ; $015316
        ORI.L  #$48860089,A1                    ; $015318
        EXT.W   D6                              ; $01531E
        ORI.L  #$48860089,A1                    ; $015320
        EXT.W   D6                              ; $015326
        ORI.L  #$48860089,A1                    ; $015328
        EXT.W   D6                              ; $01532E
        ORI.L  #$48860089,A1                    ; $015330
        EXT.W   D6                              ; $015336
        ORI.L  #$48860089,A1                    ; $015338
        EXT.W   D6                              ; $01533E
        ORI.L  #$48860089,A1                    ; $015340
        EXT.W   D6                              ; $015346
        ORI.L  #$48860089,A1                    ; $015348
        EXT.W   D6                              ; $01534E
        ORI.L  #$48860089,A1                    ; $015350
        EXT.W   D6                              ; $015356
        ORI.L  #$48860089,A1                    ; $015358
        EXT.W   D6                              ; $01535E
        ORI.L  #$48860089,A1                    ; $015360
        EXT.W   D6                              ; $015366
        ORI.L  #$48860089,A1                    ; $015368
        EXT.W   D6                              ; $01536E
        ORI.L  #$48860089,A1                    ; $015370
        EXT.W   D6                              ; $015376
        ORI.L  #$48860089,A1                    ; $015378
        EXT.W   D6                              ; $01537E
        ORI.L  #$48860089,A1                    ; $015380
        EXT.W   D6                              ; $015386
        ORI.L  #$48860089,A1                    ; $015388
        EXT.W   D6                              ; $01538E
        ORI.L  #$48860089,A1                    ; $015390
        EXT.W   D6                              ; $015396
        ORI.L  #$48860089,A1                    ; $015398
        EXT.W   D6                              ; $01539E
        ORI.L  #$48860089,A1                    ; $0153A0
        EXT.W   D6                              ; $0153A6
        ORI.L  #$48860089,A1                    ; $0153A8
        EXT.W   D6                              ; $0153AE
        ORI.L  #$48860089,A1                    ; $0153B0
        EXT.W   D6                              ; $0153B6
        ORI.L  #$48860089,A1                    ; $0153B8
        EXT.W   D6                              ; $0153BE
        ORI.L  #$48860089,A1                    ; $0153C0
        EXT.W   D6                              ; $0153C6
        ORI.L  #$48860089,A1                    ; $0153C8
        EXT.W   D6                              ; $0153CE
        ORI.L  #$48860089,A1                    ; $0153D0
        EXT.W   D6                              ; $0153D6
        ORI.L  #$48860089,A1                    ; $0153D8
        EXT.W   D6                              ; $0153DE
        ORI.L  #$48860089,A1                    ; $0153E0
        EXT.W   D6                              ; $0153E6
        ORI.L  #$48860089,A1                    ; $0153E8
        EXT.W   D6                              ; $0153EE
        ORI.L  #$48860089,A1                    ; $0153F0
        EXT.W   D6                              ; $0153F6
        ORI.L  #$48860089,A1                    ; $0153F8
        EXT.W   D6                              ; $0153FE
        ORI.L  #$48860089,A1                    ; $015400
        EXT.W   D6                              ; $015406
        ORI.L  #$48860089,A1                    ; $015408
        EXT.W   D6                              ; $01540E
        ORI.L  #$48860089,A1                    ; $015410
        EXT.W   D6                              ; $015416
        ORI.L  #$48860089,A1                    ; $015418
        EXT.W   D6                              ; $01541E
        ORI.L  #$48860089,A1                    ; $015420
        EXT.W   D6                              ; $015426
        ORI.L  #$48860089,A1                    ; $015428
        EXT.W   D6                              ; $01542E
        ORI.L  #$48860089,A1                    ; $015430
        EXT.W   D6                              ; $015436
        ORI.L  #$48860089,A1                    ; $015438
        EXT.W   D6                              ; $01543E
        ORI.L  #$48860089,A1                    ; $015440
        EXT.W   D6                              ; $015446
        ORI.L  #$47E80089,A1                    ; $015448
        EXT.W   D6                              ; $01544E
        ORI.L  #$48860089,A1                    ; $015450
        EXT.W   D6                              ; $015456
        ORI.L  #$48860089,A1                    ; $015458
        EXT.W   D6                              ; $01545E
        ORI.L  #$48860089,A1                    ; $015460
        EXT.W   D6                              ; $015466
        ORI.L  #$48860089,A1                    ; $015468
        EXT.W   D6                              ; $01546E
        ORI.L  #$48860089,A1                    ; $015470
        EXT.W   D6                              ; $015476
        ORI.L  #$48860089,A1                    ; $015478
        EXT.W   D6                              ; $01547E
        ORI.L  #$48860089,A1                    ; $015480
        EXT.W   D6                              ; $015486
        ORI.L  #$54940089,A1                    ; $015488
        ADDQ.L  #2,-$77(A4,D0.W)                ; $01548E
        SCC     (A4)                            ; $015492
        DC.W    $0000,$0000         ; $015494 ORI.B  #$0000,D0
        DC.W    $00B0,$04B8,$0000,$0000; $015498 ORI.L  #$04B80000,$00(A0,D0.W)
        DC.W    $0000,$0000         ; $0154A0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0154A4 ORI.B  #$0000,D0
        DC.W    $00B0,$04B8,$00C0,$0000; $0154A8 ORI.L  #$04B800C0,$00(A0,D0.W)
        DC.W    $0000,$0070         ; $0154B0 ORI.B  #$0070,D0
        DC.W    $0000,$0000         ; $0154B4 ORI.B  #$0000,D0
        BTST    D0,D0                           ; $0154B8
        BTST    D2,D0                           ; $0154BA
        DC.W    $0000,$0000         ; $0154BC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0154C0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0154C4 ORI.B  #$0000,D0
        BTST    D0,D0                           ; $0154C8
        BTST    D2,D0                           ; $0154CA
        DC.W    $00C0               ; $0154CC DC.W    $00C0
        DC.W    $0000,$0000         ; $0154CE ORI.B  #$0000,D0
        ORI.W  #$0000,$00(A0,D0.W)              ; $0154D2
        BTST    D0,D0                           ; $0154D8
        SUBI.B  #$0000,D0                       ; $0154DA
        DC.W    $0000,$0000         ; $0154DE ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0154E2 ORI.B  #$0000,D0
        DC.W    $0000,$0100         ; $0154E6 ORI.B  #$0100,D0
        SUBI.B  #$00C0,D0                       ; $0154EA
        DC.W    $0000,$0000         ; $0154EE ORI.B  #$0000,D0
        ORI.W  #$0089,$00(A0,D5.W)              ; $0154F2
        ORI.L  #$55200089,A1                    ; $0154F8
        SUBQ.W  #2,D0                           ; $0154FE
        DC.W    $0000,$0000         ; $015500 ORI.B  #$0000,D0
        ORI.L  #$04780000,D0                    ; $015504
        DC.W    $0000,$0000         ; $01550A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $01550E ORI.B  #$0000,D0
        DC.W    $0000,$0080         ; $015512 ORI.B  #$0080,D0
        SUBI.W  #$00C0,$0000.W                  ; $015516
        DC.W    $0000,$0070         ; $01551C ORI.B  #$0070,D0
        DC.W    $0000,$0000         ; $015520 ORI.B  #$0000,D0
        DC.W    $00F0               ; $015524 DC.W    $00F0
        DC.W    $04B6,$0000,$0000,$0000; $015526 SUBI.L  #$00000000,$00(A6,D0.W)
        DC.W    $0000,$0000         ; $01552E ORI.B  #$0000,D0
        DC.W    $0000,$00F0         ; $015532 ORI.B  #$00F0,D0
        DC.W    $04B6,$00C0,$0000,$0000; $015536 SUBI.L  #$00C00000,$00(A6,D0.W)
        ORI.W  #$0000,$00(A0,D0.W)              ; $01553E
        DC.W    $00F0               ; $015544 DC.W    $00F0
        SUBI.W  #$0000,$0000.W                  ; $015546
        DC.W    $0000,$0000         ; $01554C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015550 ORI.B  #$0000,D0
        DC.W    $00F0               ; $015554 DC.W    $00F0
        SUBI.W  #$00C0,$0000.W                  ; $015556
        DC.W    $0000,$0070         ; $01555C ORI.B  #$0070,D0
        ORI.L  #$556C0089,A1                    ; $015560
        SUBQ.L  #2,A4                           ; $015566
        ORI.L  #$55AC0000,A1                    ; $015568
        DC.W    $0000,$0080         ; $01556E ORI.B  #$0080,D0
        SUBI.W  #$0000,$0000.W                  ; $015572
        DC.W    $0000,$0000         ; $015578 ORI.B  #$0000,D0
        DC.W    $0000,$0064         ; $01557C ORI.B  #$0064,D0
        ORI.L  #$047800C0,D0                    ; $015580
        DC.W    $0000,$0000         ; $015586 ORI.B  #$0000,D0
        ORI.W  #$0000,$00(A0,D0.W)              ; $01558A
        DC.W    $00F0               ; $015590 DC.W    $00F0
        DC.W    $04B6,$0000,$0000,$0000; $015592 SUBI.L  #$00000000,$00(A6,D0.W)
        DC.W    $0000,$0000         ; $01559A ORI.B  #$0000,D0
        ORI.W  #$00F0,-(A4)                     ; $01559E
        DC.W    $04B6,$00C0,$0000,$0000; $0155A2 SUBI.L  #$00C00000,$00(A6,D0.W)
        ORI.W  #$0000,$00(A0,D0.W)              ; $0155AA
        DC.W    $00F0               ; $0155B0 DC.W    $00F0
        SUBI.W  #$0000,$0000.W                  ; $0155B2
        DC.W    $0000,$0000         ; $0155B8 ORI.B  #$0000,D0
        DC.W    $0000,$0064         ; $0155BC ORI.B  #$0064,D0
        DC.W    $00F0               ; $0155C0 DC.W    $00F0
        SUBI.W  #$00C0,$0000.W                  ; $0155C2
        DC.W    $0000,$0070         ; $0155C8 ORI.B  #$0070,D0
        ORI.L  #$55D80089,A1                    ; $0155CC
        ADDQ.B  #3,A0                           ; $0155D2
        ORI.L  #$563800D7,A1                    ; $0155D4
        DC.W    $0000,$FD00         ; $0155DA ORI.B  #$FD00,D0
        DC.W    $00D7               ; $0155DE DC.W    $00D7
        DC.W    $0000,$FD00         ; $0155E0 ORI.B  #$FD00,D0
        DC.W    $0000,$0000         ; $0155E4 ORI.B  #$0000,D0
        MOVE.W  $00(A6,D0.W),(A6)+              ; $0155E8
        DC.W    $0000,$FD0A         ; $0155EC ORI.B  #$FD0A,D0
        DC.W    $00D7               ; $0155F0 DC.W    $00D7
        DC.W    $0000,$FD00         ; $0155F2 ORI.B  #$FD00,D0
        DC.W    $00D7               ; $0155F6 DC.W    $00D7
        DC.W    $0000,$FD00         ; $0155F8 ORI.B  #$FD00,D0
        DC.W    $00D7               ; $0155FC DC.W    $00D7
        DC.W    $0000,$FD00         ; $0155FE ORI.B  #$FD00,D0
        DC.W    $00D7               ; $015602 DC.W    $00D7
        DC.W    $0000,$FD00         ; $015604 ORI.B  #$FD00,D0
        DC.W    $00F5               ; $015608 DC.W    $00F5
        DC.W    $0000,$FD4F         ; $01560A ORI.B  #$FD4F,D0
        DC.W    $00F5               ; $01560E DC.W    $00F5
        DC.W    $0000,$FD4F         ; $015610 ORI.B  #$FD4F,D0
        DC.W    $0000,$0000         ; $015614 ORI.B  #$0000,D0
        MOVE.W  -(A4),(A6)+                     ; $015618
        ORI.W  #$0000,-$02D9(A1)                ; $01561A
        BTST    D0,(A1)                         ; $015620
        DC.W    $0000,$FD3A         ; $015622 ORI.B  #$FD3A,D0
        BTST    D0,(A1)                         ; $015626
        DC.W    $0000,$FD3A         ; $015628 ORI.B  #$FD3A,D0
        BTST    D0,(A1)                         ; $01562C
        DC.W    $0000,$FD3A         ; $01562E ORI.B  #$FD3A,D0
        BTST    D0,(A1)                         ; $015632
        DC.W    $0000,$FD3A         ; $015634 ORI.B  #$FD3A,D0
        DC.W    $00D7               ; $015638 DC.W    $00D7
        DC.W    $0000,$FE1D         ; $01563A ORI.B  #$FE1D,D0
        DC.W    $00D7               ; $01563E DC.W    $00D7
        DC.W    $0000,$FE1D         ; $015640 ORI.B  #$FE1D,D0
        DC.W    $0000,$0000         ; $015644 ORI.B  #$0000,D0
        MOVEA.W A4,A7                           ; $015648
        DC.W    $0000,$0000         ; $01564A ORI.B  #$0000,D0
        MOVEA.W A4,A7                           ; $01564E
        DC.W    $00D7               ; $015650 DC.W    $00D7
        DC.W    $0000,$FE1D         ; $015652 ORI.B  #$FE1D,D0
        DC.W    $00D7               ; $015656 DC.W    $00D7
        DC.W    $0000,$FE1D         ; $015658 ORI.B  #$FE1D,D0
        DC.W    $00D7               ; $01565C DC.W    $00D7
        DC.W    $0000,$FE1D         ; $01565E ORI.B  #$FE1D,D0
        DC.W    $00D7               ; $015662 DC.W    $00D7
        DC.W    $0000,$FE1D         ; $015664 ORI.B  #$FE1D,D0
        ORI.W  #$0000,-(A4)                     ; $015668
        MOVE.W  D0,D0                           ; $01566C
        DC.W    $0000,$2229         ; $01566E ORI.B  #$2229,D0
        DC.W    $4E12               ; $015672 DC.W    $4E12
        DC.W    $0000,$0000         ; $015674 ORI.B  #$0000,D0
        ORI.W  #$0000,-(A4)                     ; $015678
        MOVE.W  D0,D0                           ; $01567C
        DC.W    $0000,$2229         ; $01567E ORI.B  #$2229,D0
        ADDQ.B  #8,$00(A4,D0.W)                 ; $015682
        DC.W    $0000,$0064         ; $015686 ORI.B  #$0064,D0
        DC.W    $0000,$F000         ; $01568A ORI.B  #$F000,D0
        DC.W    $0000,$2229         ; $01568E ORI.B  #$2229,D0
        ADDQ.L  #1,$0000.W                      ; $015692
        DC.W    $0000,$0064         ; $015696 ORI.B  #$0064,D0
        DC.W    $0000,$F000         ; $01569A ORI.B  #$F000,D0
        DC.W    $0000,$2229         ; $01569E ORI.B  #$2229,D0
        SUBQ.B  #2,(A2)+                        ; $0156A2
        DC.W    $0000,$0000         ; $0156A4 ORI.B  #$0000,D0
        ORI.W  #$0000,-(A4)                     ; $0156A8
        ASL.B  #5,D0                            ; $0156AC
        DC.W    $0000,$2229         ; $0156AE ORI.B  #$2229,D0
        SUBQ.L  #3,(A0)                         ; $0156B2
        DC.W    $0000,$0000         ; $0156B4 ORI.B  #$0000,D0
        ORI.W  #$0000,-(A4)                     ; $0156B8
        MOVE.W  D0,D0                           ; $0156BC
        DC.W    $0000,$2229         ; $0156BE ORI.B  #$2229,D0
        SUBQ.B  #2,(A2)+                        ; $0156C2
        DC.W    $0000,$0000         ; $0156C4 ORI.B  #$0000,D0
        ORI.L  #$56D40089,A1                    ; $0156C8
        SUBQ.B  #3,(A0)+                        ; $0156CE
        ORI.L  #$575C0603,A1                    ; $0156D0
        AND.B  D0,D0                            ; $0156D6
        ADDI.B  #$D450,D3                       ; $0156D8
        ADDI.B  #$D55A,D3                       ; $0156DC
        ADDI.B  #$D664,D3                       ; $0156E0
        ADDI.B  #$C6A8,D3                       ; $0156E4
        ADDI.B  #$DBA6,D3                       ; $0156E8
        ADDI.B  #$E4AE,D3                       ; $0156EC
        ADDI.B  #$E6E4,D3                       ; $0156F0
        MOVE.L  $211A(A0),D1                    ; $0156F4
        ORI.L  #$05340093,(A3)                  ; $0156F8
        DC.W    $054C               ; $0156FE BCHG    D2,A4
        ORI.L  #$05580093,(A3)                  ; $015700
        BCHG    D2,-(A4)                        ; $015706
        ORI.L  #$761E0603,(A3)                  ; $015708
        DC.W    $C73E               ; $01570E AND.B  D3,<EA:3E>
        ADDI.B  #$CDD6,D3                       ; $015710
        ADDI.B  #$DE68,D3                       ; $015714
        ADDI.B  #$C000,D3                       ; $015718
        ADDI.B  #$D214,D3                       ; $01571C
        ADDI.B  #$D2D6,D3                       ; $015720
        ADDI.B  #$D398,D3                       ; $015724
        ADDI.B  #$C5CE,D3                       ; $015728
        ADDI.B  #$D78E,D3                       ; $01572C
        DC.W    $0000,$0000         ; $015730 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015734 ORI.B  #$0000,D0
        MOVE.L  $211A(A0),D1                    ; $015738
        ORI.L  #$056A0093,(A3)                  ; $01573C
        BCLR    D2,D2                           ; $015742
        ORI.L  #$05940093,(A3)                  ; $015744
        DC.W    $058E               ; $01574A BCLR    D2,A6
        ORI.L  #$B88C0603,(A3)                  ; $01574C
        AND.B  -(A0),D3                         ; $015752
        ADDI.B  #$CC16,D3                       ; $015754
        ADDI.B  #$DBA4,D3                       ; $015758
        ADDI.B  #$C000,D3                       ; $01575C
        ADDI.B  #$D2B8,D3                       ; $015760
        ADDI.B  #$D37A,D3                       ; $015764
        ADDI.B  #$D43C,D3                       ; $015768
        ADDI.B  #$C62C,D3                       ; $01576C
        ADDI.B  #$D856,D3                       ; $015770
        DC.W    $0000,$0000         ; $015774 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015778 ORI.B  #$0000,D0
        MOVE.L  $211A(A0),D1                    ; $01577C
        ORI.L  #$05A00093,(A3)                  ; $015780
        BCLR    D2,$0093.W                      ; $015786
        DC.W    $05CA               ; $01578A BSET    D2,A2
        ORI.L  #$05C40093,(A3)                  ; $01578C
        CMP.B  $0603(A4),D0                     ; $015792
        AND.L  $0603(A6),D3                     ; $015796
        MULU    (A0),D6                         ; $01579A
        ADDI.B  #$DA8A,D3                       ; $01579C
        ORI.L  #$57AC0089,A1                    ; $0157A0
        ADDQ.B  #4,D4                           ; $0157A6
        ORI.L  #$585C0603,A1                    ; $0157A8
        AND.B  D0,D0                            ; $0157AE
        ADDI.B  #$CC06,D3                       ; $0157B0
        ADDI.B  #$CCE0,D3                       ; $0157B4
        ADDI.B  #$CDBA,D3                       ; $0157B8
        ADDI.B  #$C710,D3                       ; $0157BC
        ADDI.B  #$C7A6,D3                       ; $0157C0
        ADDI.B  #$CC06,D3                       ; $0157C4
        ADDI.B  #$CCE0,D3                       ; $0157C8
        MOVE.L  $211A(A0),D1                    ; $0157CC
        ORI.L  #$05340093,(A3)                  ; $0157D0
        DC.W    $054C               ; $0157D6 BCHG    D2,A4
        ORI.L  #$05580000,(A3)                  ; $0157D8
        DC.W    $0000,$0093         ; $0157DE ORI.B  #$0093,D0
        MOVEQ   #$1E,D3                         ; $0157E2
        ADDI.B  #$C000,D3                       ; $0157E4
        ADDI.B  #$C000,D3                       ; $0157E8
        ADDI.B  #$C7A6,D3                       ; $0157EC
        ADDI.B  #$C362,D3                       ; $0157F0
        ADDI.B  #$C9CC,D3                       ; $0157F4
        ADDI.B  #$C362,D3                       ; $0157F8
        ADDI.B  #$C362,D3                       ; $0157FC
        ADDI.B  #$C9CC,D3                       ; $015800
        ADDI.B  #$CF68,D3                       ; $015804
        ADDI.B  #$D87E,D3                       ; $015808
        ADDI.B  #$D940,D3                       ; $01580C
        ADDI.B  #$DA02,D3                       ; $015810
        ADDI.B  #$D5EE,D3                       ; $015814
        ADDI.B  #$D62C,D3                       ; $015818
        DC.W    $0000,$0000         ; $01581C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015820 ORI.B  #$0000,D0
        MOVE.L  $211A(A0),D1                    ; $015824
        ORI.L  #$056A0093,(A3)                  ; $015828
        BCLR    D2,D2                           ; $01582E
        ORI.L  #$05940000,(A3)                  ; $015830
        DC.W    $0000,$0093         ; $015836 ORI.B  #$0093,D0
        CMP.L  A4,D4                            ; $01583A
        ADDI.B  #$CF68,D3                       ; $01583C
        ADDI.B  #$CF68,D3                       ; $015840
        ADDI.B  #$D62C,D3                       ; $015844
        ADDI.B  #$D294,D3                       ; $015848
        ADDI.B  #$D74C,D3                       ; $01584C
        ADDI.B  #$D294,D3                       ; $015850
        ADDI.B  #$D294,D3                       ; $015854
        ADDI.B  #$D74C,D3                       ; $015858
        ADDI.B  #$DBB0,D3                       ; $01585C
        ADDI.B  #$E442,D3                       ; $015860
        ADDI.B  #$E504,D3                       ; $015864
        ADDI.B  #$E5C6,D3                       ; $015868
        ADDI.B  #$E234,D3                       ; $01586C
        ADDI.B  #$E296,D3                       ; $015870
        DC.W    $0000,$0000         ; $015874 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015878 ORI.B  #$0000,D0
        MOVE.L  $211A(A0),D1                    ; $01587C
        ORI.L  #$05A00093,(A3)                  ; $015880
        BCLR    D2,$0093.W                      ; $015886
        DC.W    $05CA               ; $01588A BSET    D2,A2
        DC.W    $0000,$0000         ; $01588C ORI.B  #$0000,D0
        ORI.L  #$B02C0603,(A3)                  ; $015890
        ADD.L  D5,$03(A0,D0.W)                  ; $015896
        ADD.L  D5,$03(A0,D0.W)                  ; $01589A
        ROXR.L  #1,D6                           ; $01589E
        ADDI.B  #$DEF6,D3                       ; $0158A0
        ADDI.B  #$E36C,D3                       ; $0158A4
        ADDI.B  #$DEF6,D3                       ; $0158A8
        ADDI.B  #$DEF6,D3                       ; $0158AC
        ADDI.B  #$E36C,D3                       ; $0158B0
        ORI.L  #$58C00089,A1                    ; $0158B4
        DBVC    D4,loc_015945                   ; $0158BA
        SVC     (A0)+                           ; $0158BE
        ADDI.B  #$EB96,D3                       ; $0158C0
        ADDI.B  #$E91A,D3                       ; $0158C4
        ADDI.B  #$EA58,D3                       ; $0158C8
        ADDI.B  #$E204,D3                       ; $0158CC
        ADDI.B  #$DFC8,D3                       ; $0158D0
        ADDI.B  #$E0E6,D3                       ; $0158D4
        ADDI.B  #$DF2A,D3                       ; $0158D8
        ADDI.B  #$DCEE,D3                       ; $0158DC
        ADDI.B  #$DE0C,D3                       ; $0158E0
        ORI.L  #$58F00089,A1                    ; $0158E4
        SUBQ.B  #4,-$77(A0,D0.W)                ; $0158EA
        SUBQ.W  #4,$00(A0,D0.W)                 ; $0158EE
        DC.W    $0000,$0603         ; $0158F2 ORI.B  #$0603,D0
        ROXL.L  #5,D6                           ; $0158F6
        ADDI.B  #$ED80,D3                       ; $0158F8
        ADDI.B  #$EFDC,D3                       ; $0158FC
        DC.W    $0000,$0000         ; $015900 ORI.B  #$0000,D0
        ADDI.B  #$F016,D3                       ; $015904
        ADDI.B  #$F200,D3                       ; $015908
        ADDI.B  #$F45C,D3                       ; $01590C
        DC.W    $0000,$0000         ; $015910 ORI.B  #$0000,D0
        ADDI.B  #$F496,D3                       ; $015914
        ADDI.B  #$F680,D3                       ; $015918
        ADDI.B  #$F8DC,D3                       ; $01591C
        DC.W    $0000,$0000         ; $015920 ORI.B  #$0000,D0
        ADDI.B  #$F916,D3                       ; $015924
        ADDI.B  #$FB00,D3                       ; $015928
        ADDI.B  #$FD5C,D3                       ; $01592C
        DC.W    $0000,$0000         ; $015930 ORI.B  #$0000,D0
        ADDI.B  #$E204,D3                       ; $015934
        ADDI.B  #$E3F2,D3                       ; $015938
        ADDI.B  #$E53C,D3                       ; $01593C
        DC.W    $0000,$0000         ; $015940 ORI.B  #$0000,D0
        ADDI.B  #$E58A,D3                       ; $015944
        ADDI.B  #$E7C0,D3                       ; $015948
        ADDI.B  #$E93E,D3                       ; $01594C
        DC.W    $0000,$0000         ; $015950 ORI.B  #$0000,D0
        ADDI.B  #$E98C,D3                       ; $015954
        ADDI.B  #$EBA2,D3                       ; $015958
        ADDI.B  #$ED04,D3                       ; $01595C
        DC.W    $0000,$0000         ; $015960 ORI.B  #$0000,D0
        ADDI.B  #$ED52,D3                       ; $015964
        ADDI.B  #$EF80,D3                       ; $015968
        ADDI.B  #$F0FE,D3                       ; $01596C
        DC.W    $0000,$0000         ; $015970 ORI.B  #$0000,D0
        ADDI.B  #$DF2A,D3                       ; $015974
        ADDI.B  #$E1A8,D3                       ; $015978
        ADDI.B  #$E2DE,D3                       ; $01597C
        DC.W    $0000,$0000         ; $015980 ORI.B  #$0000,D0
        ADDI.B  #$E32C,D3                       ; $015984
        ADDI.B  #$E50C,D3                       ; $015988
        ADDI.B  #$E642,D3                       ; $01598C
        DC.W    $0000,$0000         ; $015990 ORI.B  #$0000,D0
        ADDI.B  #$E690,D3                       ; $015994
        ADDI.B  #$E8D0,D3                       ; $015998
        ADDI.B  #$EA18,D3                       ; $01599C
        DC.W    $0000,$0000         ; $0159A0 ORI.B  #$0000,D0
        ADDI.B  #$EA66,D3                       ; $0159A4
        ADDI.B  #$EC86,D3                       ; $0159A8
        ADDI.B  #$ED98,D3                       ; $0159AC
        ADDI.B  #$9F9A,D3                       ; $0159B0
        ADDI.B  #$A044,D3                       ; $0159B4
        ADDI.B  #$A0F2,D3                       ; $0159B8
        ADDI.B  #$A190,D3                       ; $0159BC
        ADDI.B  #$A22E,D3                       ; $0159C0
        ADDI.B  #$A2CC,D3                       ; $0159C4
        ADDI.B  #$A36A,D3                       ; $0159C8
        ADDI.B  #$A408,D3                       ; $0159CC
        ADDI.B  #$3000,D3                       ; $0159D0
        ADDI.B  #$34D6,D3                       ; $0159D4
        ADDI.B  #$39C8,D3                       ; $0159D8
        ADDI.B  #$3EBA,D3                       ; $0159DC
        ADDI.B  #$43AC,D3                       ; $0159E0
        ADDI.B  #$489E,D3                       ; $0159E4
        ADDI.B  #$4D90,D3                       ; $0159E8
        ADDI.B  #$5282,D3                       ; $0159EC
        ADDI.B  #$5774,D3                       ; $0159F0
        ADDI.B  #$5C66,D3                       ; $0159F4
        ADDI.B  #$6158,D3                       ; $0159F8
        ADDI.B  #$654E,D3                       ; $0159FC
        ADDI.B  #$65CC,D3                       ; $015A00
        ADDI.B  #$679A,D3                       ; $015A04
        ADDI.B  #$6968,D3                       ; $015A08
        ADDI.B  #$6B36,D3                       ; $015A0C
        ADDI.B  #$7004,D3                       ; $015A10
        ADDI.B  #$7512,D3                       ; $015A14
        ADDI.B  #$7A20,D3                       ; $015A18
        ADDI.B  #$7EEE,D3                       ; $015A1C
        ADDI.B  #$84AC,D3                       ; $015A20
        ADDI.B  #$8A6A,D3                       ; $015A24
        ADDI.B  #$8D10,D3                       ; $015A28
        ADDI.B  #$8FB6,D3                       ; $015A2C
        ADDI.B  #$925C,D3                       ; $015A30
        ADDI.B  #$9502,D3                       ; $015A34
        ADDI.B  #$97A8,D3                       ; $015A38
        ADDI.B  #$9A4E,D3                       ; $015A3C
        ADDI.B  #$9CF4,D3                       ; $015A40
        ADDI.B  #$A4A6,D3                       ; $015A44
        ADDI.B  #$A74C,D3                       ; $015A48
        ADDI.B  #$A9F2,D3                       ; $015A4C
        ADDI.B  #$AC98,D3                       ; $015A50
        ADDI.B  #$AF3E,D3                       ; $015A54
        ADDI.B  #$B1E4,D3                       ; $015A58
        ADDI.B  #$B48A,D3                       ; $015A5C
        ADDI.B  #$B730,D3                       ; $015A60
        ORI.L  #$5A7C0089,A1                    ; $015A64
        ADDQ.L  #5,-(A6)                        ; $015A6A
        ORI.L  #$5AD00089,A1                    ; $015A6C
        SPL     $0089(PC)                       ; $015A72
        SUBQ.B  #5,-(A4)                        ; $015A76
        ORI.L  #$5B24F483,A1                    ; $015A78
        EORI.W  #$E698,$00(PC,D0.W)             ; $015A7E
        BTST    D0,D0                           ; $015A84
        ORI.L  #$5B4E06C6,A1                    ; $015A86
        BSET    D7,-(A2)                        ; $015A8C
        MOVE.L  -(A6),D1                        ; $015A8E
        MOVE.W  $00(A7,D0.W),(A3)+              ; $015A90
        ORI.L  #$5B66101A,A1                    ; $015A94
        DC.W    $0A1C,$ED7C         ; $015A9A EORI.B  #$ED7C,(A4)+
        DC.W    $F23D               ; $015A9E MOVE.W  <EA:3D>,D1
        BTST    D0,D0                           ; $015AA0
        ORI.L  #$5B66F39F,A1                    ; $015AA2
        MOVE.B  D0,-(A7)                        ; $015AA8
        MOVE.W  $0000(A6),$00CD(A7)             ; $015AAA
        ORI.L  #$5B4E08CD,A1                    ; $015AB0
        MOVE.L  D0,D2                           ; $015AB6
        MOVE.B  D5,(A7)+                        ; $015AB8
        MOVE.W  A6,-$33(A1,D0.W)                ; $015ABA
        ORI.L  #$5B661143,A1                    ; $015ABE
        CMPI.L  #$EEC8EE6B,D0                   ; $015AC4
        DC.W    $014E               ; $015ACA BCHG    D0,A6
        ORI.L  #$5B66EC46,A1                    ; $015ACC
        DC.W    $03C8               ; $015AD2 BSET    D1,A0
        MOVE.W  (A3),$000000A1                  ; $015AD4
        ORI.L  #$5B4E25D8,A1                    ; $015ADA
        DC.W    $00DA               ; $015AE0 DC.W    $00DA
        BCLR    #31,$00C8(A2)                   ; $015AE2
        ORI.L  #$5B660DE4,A1                    ; $015AE8
        BCHG    #31,-(A6)                       ; $015AEE
        MOVE.W  D6,-(A1)                        ; $015AF2
        ORI.W  #$0089,$5B66(PC)                 ; $015AF4
        ROL.W  D5,D3                            ; $015AFA
        DC.W    $094A               ; $015AFC BCHG    D4,A2
        DC.W    $0229,$0000,$0100   ; $015AFE ANDI.B  #$0000,$0100(A1)
        ORI.L  #$5B4EFA8A,A1                    ; $015B04
        SUBI.W  #$26E2,-(A7)                    ; $015B0A
        ROL.W  #7,D3                            ; $015B0E
        DC.W    $00BC,$0089,$5B66,$FD9C,$0A49; $015B10 ORI.L  #$00895B66,#$FD9C0A49
        MOVE.W  $1000(A5),D0                    ; $015B1A
        BTST    D0,D0                           ; $015B1E
        ORI.L  #$5B66E1C9,A1                    ; $015B20
        ANDI.W  #$EB25,(A1)                     ; $015B26
        DC.W    $0000,$00ED         ; $015B2A ORI.B  #$00ED,D0
        ORI.L  #$5B4EEEBC,A1                    ; $015B2E
        MOVE.W  (A3)+,-(A4)                     ; $015B34
        MOVE.L  -$0F(A6,A7.W),-(A0)             ; $015B36
        DC.W    $00E9               ; $015B3A DC.W    $00E9
        ORI.L  #$5B661C4D,A1                    ; $015B3C
        BTST    D0,(A4)+                        ; $015B42
        MOVE.W  D3,-$53(PC,D0.L)                ; $015B44
        BCLR    D0,-$77(PC,D0.W)                ; $015B48
        SUBQ.W  #5,-(A6)                        ; $015B4C
        MOVE.L  -$1058(A1),D1                   ; $015B4E
        MOVE.L  -$0CAE(A1),D1                   ; $015B52
        MOVE.L  -$0904(A1),D1                   ; $015B56
        MOVE.L  -$055A(A1),D1                   ; $015B5A
        MOVE.L  -$01B0(A1),D1                   ; $015B5E
        MOVE.L  $01FA(A2),D1                    ; $015B62
        MOVE.L  $05A4(A2),D1                    ; $015B66
        MOVE.L  $0822(A2),D1                    ; $015B6A
        MOVE.L  $0AA0(A2),D1                    ; $015B6E
        MOVE.L  $0D1E(A2),D1                    ; $015B72
        MOVE.L  $0F9C(A2),D1                    ; $015B76
        MOVE.L  $121A(A2),D1                    ; $015B7A
        MOVE.L  D1,D1                           ; $015B7E
loc_015B80:
        BRA.S  loc_015B80                       ; $015B80
        MOVE.L  D1,D1                           ; $015B82
        SUBQ.W  #6,(A6)+                        ; $015B84
        MOVE.L  D1,D1                           ; $015B86
        SUBQ.B  #7,$2201(A6)                    ; $015B88
        SUBQ.L  #5,A6                           ; $015B8C
        MOVE.L  $2780(A2),D1                    ; $015B8E
        DC.W    $0000,$0000         ; $015B92 ORI.B  #$0000,D0
        MOVE.L  $272C(A2),D1                    ; $015B96
        DC.W    $0000,$0000         ; $015B9A ORI.B  #$0000,D0
        MOVE.L  $2936(A2),D1                    ; $015B9E
        DC.W    $0000,$0000         ; $015BA2 ORI.B  #$0000,D0
        MOVE.L  $272C(A2),D1                    ; $015BA6
        DC.W    $0000,$0000         ; $015BAA ORI.B  #$0000,D0
        MOVE.L  $2AEC(A2),D1                    ; $015BAE
        DC.W    $0000,$0000         ; $015BB2 ORI.B  #$0000,D0
        MOVE.L  $272C(A2),D1                    ; $015BB6
        DC.W    $0000,$0000         ; $015BBA ORI.B  #$0000,D0
        MOVE.L  $2CA2(A2),D1                    ; $015BBE
        DC.W    $0000,$0000         ; $015BC2 ORI.B  #$0000,D0
        MOVE.L  $272C(A2),D1                    ; $015BC6
        DC.W    $0000,$0000         ; $015BCA ORI.B  #$0000,D0
        MOVE.L  $2E58(A2),D1                    ; $015BCE
        DC.W    $0000,$0000         ; $015BD2 ORI.B  #$0000,D0
        MOVE.L  $272C(A2),D1                    ; $015BD6
        DC.W    $0000,$0000         ; $015BDA ORI.B  #$0000,D0
        MOVE.L  $300E(A2),D1                    ; $015BDE
        DC.W    $0000,$0000         ; $015BE2 ORI.B  #$0000,D0
        MOVE.L  $272C(A2),D1                    ; $015BE6
        DC.W    $0000,$0000         ; $015BEA ORI.B  #$0000,D0
        MOVE.L  $31C4(A2),D1                    ; $015BEE
        MOVE.L  $2702(A2),D1                    ; $015BF2
        MOVE.L  $272C(A2),D1                    ; $015BF6
        DC.W    $0000,$0000         ; $015BFA ORI.B  #$0000,D0
        MOVE.L  $3356(A2),D1                    ; $015BFE
        MOVE.L  $2702(A2),D1                    ; $015C02
        MOVE.L  $272C(A2),D1                    ; $015C06
        DC.W    $0000,$0000         ; $015C0A ORI.B  #$0000,D0
        MOVE.L  $34E8(A2),D1                    ; $015C0E
        MOVE.L  $2702(A2),D1                    ; $015C12
        MOVE.L  $272C(A2),D1                    ; $015C16
        DC.W    $0000,$0000         ; $015C1A ORI.B  #$0000,D0
        MOVE.L  $369E(A2),D1                    ; $015C1E
        MOVE.L  $2702(A2),D1                    ; $015C22
        MOVE.L  $272C(A2),D1                    ; $015C26
        DC.W    $0000,$0000         ; $015C2A ORI.B  #$0000,D0
        MOVE.L  $3854(A2),D1                    ; $015C2E
        MOVE.L  $2702(A2),D1                    ; $015C32
        MOVE.L  $272C(A2),D1                    ; $015C36
        DC.W    $0000,$0000         ; $015C3A ORI.B  #$0000,D0
        MOVE.L  $3A0A(A2),D1                    ; $015C3E
        MOVE.L  $2702(A2),D1                    ; $015C42
        MOVE.L  $272C(A2),D1                    ; $015C46
        DC.W    $0000,$0000         ; $015C4A ORI.B  #$0000,D0
        MOVE.L  $3BC0(A2),D1                    ; $015C4E
        MOVE.L  $2702(A2),D1                    ; $015C52
        MOVE.L  $272C(A2),D1                    ; $015C56
        MOVE.L  $2756(A2),D1                    ; $015C5A
        MOVE.L  $3D52(A2),D1                    ; $015C5E
        MOVE.L  $2702(A2),D1                    ; $015C62
        MOVE.L  $272C(A2),D1                    ; $015C66
        MOVE.L  $2756(A2),D1                    ; $015C6A
        MOVE.L  $3EE4(A2),D1                    ; $015C6E
        MOVE.L  $2702(A2),D1                    ; $015C72
        MOVE.L  $272C(A2),D1                    ; $015C76
        MOVE.L  $2756(A2),D1                    ; $015C7A
        MOVE.L  $4076(A2),D1                    ; $015C7E
        MOVE.L  $2702(A2),D1                    ; $015C82
        MOVE.L  $272C(A2),D1                    ; $015C86
        MOVE.L  $2756(A2),D1                    ; $015C8A
        MOVE.L  $4208(A2),D1                    ; $015C8E
        MOVE.L  $2702(A2),D1                    ; $015C92
        DC.W    $0000,$0000         ; $015C96 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015C9A
        MOVE.L  $43BE(A2),D1                    ; $015C9E
        MOVE.L  $2702(A2),D1                    ; $015CA2
        DC.W    $0000,$0000         ; $015CA6 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015CAA
        MOVE.L  $4574(A2),D1                    ; $015CAE
        MOVE.L  $2702(A2),D1                    ; $015CB2
        DC.W    $0000,$0000         ; $015CB6 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015CBA
        MOVE.L  $472A(A2),D1                    ; $015CBE
        MOVE.L  $2702(A2),D1                    ; $015CC2
        DC.W    $0000,$0000         ; $015CC6 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015CCA
        MOVE.L  $48E0(A2),D1                    ; $015CCE
        MOVE.L  $2702(A2),D1                    ; $015CD2
        DC.W    $0000,$0000         ; $015CD6 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015CDA
        MOVE.L  $4A72(A2),D1                    ; $015CDE
        MOVE.L  $2702(A2),D1                    ; $015CE2
        DC.W    $0000,$0000         ; $015CE6 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015CEA
        MOVE.L  $4C04(A2),D1                    ; $015CEE
        DC.W    $0000,$0000         ; $015CF2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015CF6 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015CFA
        MOVE.L  $4DBA(A2),D1                    ; $015CFE
        DC.W    $0000,$0000         ; $015D02 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015D06 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015D0A
        MOVE.L  $4F70(A2),D1                    ; $015D0E
        DC.W    $0000,$0000         ; $015D12 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015D16 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015D1A
        MOVE.L  $5126(A2),D1                    ; $015D1E
        DC.W    $0000,$0000         ; $015D22 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015D26 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015D2A
        MOVE.L  $52DC(A2),D1                    ; $015D2E
        DC.W    $0000,$0000         ; $015D32 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015D36 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015D3A
        MOVE.L  $5492(A2),D1                    ; $015D3E
        DC.W    $0000,$0000         ; $015D42 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015D46 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015D4A
        MOVE.L  $5648(A2),D1                    ; $015D4E
        DC.W    $0000,$0000         ; $015D52 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015D56 ORI.B  #$0000,D0
        MOVE.L  $2756(A2),D1                    ; $015D5A
        MOVE.L  $587C(A2),D1                    ; $015D5E
        DC.W    $0000,$0000         ; $015D62 ORI.B  #$0000,D0
        MOVE.L  $5828(A2),D1                    ; $015D66
        DC.W    $0000,$0000         ; $015D6A ORI.B  #$0000,D0
        MOVE.L  $5A32(A2),D1                    ; $015D6E
        DC.W    $0000,$0000         ; $015D72 ORI.B  #$0000,D0
        MOVE.L  $5828(A2),D1                    ; $015D76
        DC.W    $0000,$0000         ; $015D7A ORI.B  #$0000,D0
        MOVE.L  $5BE8(A2),D1                    ; $015D7E
        DC.W    $0000,$0000         ; $015D82 ORI.B  #$0000,D0
        MOVE.L  $5828(A2),D1                    ; $015D86
        DC.W    $0000,$0000         ; $015D8A ORI.B  #$0000,D0
        MOVE.L  $5D9E(A2),D1                    ; $015D8E
        DC.W    $0000,$0000         ; $015D92 ORI.B  #$0000,D0
        MOVE.L  $5828(A2),D1                    ; $015D96
        DC.W    $0000,$0000         ; $015D9A ORI.B  #$0000,D0
        MOVE.L  $5F54(A2),D1                    ; $015D9E
        MOVE.L  $57FE(A2),D1                    ; $015DA2
        MOVE.L  $5828(A2),D1                    ; $015DA6
        DC.W    $0000,$0000         ; $015DAA ORI.B  #$0000,D0
        MOVE.L  $60E6(A2),D1                    ; $015DAE
        MOVE.L  $57FE(A2),D1                    ; $015DB2
        MOVE.L  $5828(A2),D1                    ; $015DB6
        DC.W    $0000,$0000         ; $015DBA ORI.B  #$0000,D0
        MOVE.L  $6278(A2),D1                    ; $015DBE
        MOVE.L  $57FE(A2),D1                    ; $015DC2
        MOVE.L  $5828(A2),D1                    ; $015DC6
        DC.W    $0000,$0000         ; $015DCA ORI.B  #$0000,D0
        MOVE.L  $640A(A2),D1                    ; $015DCE
        MOVE.L  $57FE(A2),D1                    ; $015DD2
        MOVE.L  $5828(A2),D1                    ; $015DD6
        DC.W    $0000,$0000         ; $015DDA ORI.B  #$0000,D0
        MOVE.L  $65C0(A2),D1                    ; $015DDE
        MOVE.L  $57FE(A2),D1                    ; $015DE2
        MOVE.L  $5828(A2),D1                    ; $015DE6
        DC.W    $0000,$0000         ; $015DEA ORI.B  #$0000,D0
        MOVE.L  $6776(A2),D1                    ; $015DEE
        MOVE.L  $57FE(A2),D1                    ; $015DF2
        MOVE.L  $5828(A2),D1                    ; $015DF6
        DC.W    $0000,$0000         ; $015DFA ORI.B  #$0000,D0
        MOVE.L  $692C(A2),D1                    ; $015DFE
        MOVE.L  $57FE(A2),D1                    ; $015E02
        MOVE.L  $5828(A2),D1                    ; $015E06
        DC.W    $0000,$0000         ; $015E0A ORI.B  #$0000,D0
        MOVE.L  $6AE2(A2),D1                    ; $015E0E
        MOVE.L  $57FE(A2),D1                    ; $015E12
        MOVE.L  $5828(A2),D1                    ; $015E16
        DC.W    $0000,$0000         ; $015E1A ORI.B  #$0000,D0
        MOVE.L  $6C98(A2),D1                    ; $015E1E
        MOVE.L  $57FE(A2),D1                    ; $015E22
        MOVE.L  $5828(A2),D1                    ; $015E26
        MOVE.L  $5852(A2),D1                    ; $015E2A
        MOVE.L  $6E2A(A2),D1                    ; $015E2E
        MOVE.L  $57FE(A2),D1                    ; $015E32
        MOVE.L  $5828(A2),D1                    ; $015E36
        MOVE.L  $5852(A2),D1                    ; $015E3A
        MOVE.L  $6FBC(A2),D1                    ; $015E3E
        MOVE.L  $57FE(A2),D1                    ; $015E42
        DC.W    $0000,$0000         ; $015E46 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015E4A
        MOVE.L  $7172(A2),D1                    ; $015E4E
        MOVE.L  $57FE(A2),D1                    ; $015E52
        DC.W    $0000,$0000         ; $015E56 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015E5A
        MOVE.L  $7328(A2),D1                    ; $015E5E
        MOVE.L  $57FE(A2),D1                    ; $015E62
        DC.W    $0000,$0000         ; $015E66 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015E6A
        MOVE.L  $74DE(A2),D1                    ; $015E6E
        MOVE.L  $57FE(A2),D1                    ; $015E72
        DC.W    $0000,$0000         ; $015E76 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015E7A
        MOVE.L  $7694(A2),D1                    ; $015E7E
        MOVE.L  $57FE(A2),D1                    ; $015E82
        DC.W    $0000,$0000         ; $015E86 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015E8A
        MOVE.L  $784A(A2),D1                    ; $015E8E
        MOVE.L  $57FE(A2),D1                    ; $015E92
        DC.W    $0000,$0000         ; $015E96 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015E9A
        MOVE.L  $7A00(A2),D1                    ; $015E9E
        MOVE.L  $57FE(A2),D1                    ; $015EA2
        DC.W    $0000,$0000         ; $015EA6 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015EAA
        MOVE.L  $7B92(A2),D1                    ; $015EAE
        MOVE.L  $57FE(A2),D1                    ; $015EB2
        DC.W    $0000,$0000         ; $015EB6 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015EBA
        MOVE.L  $7D24(A2),D1                    ; $015EBE
        DC.W    $0000,$0000         ; $015EC2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015EC6 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015ECA
        MOVE.L  $7EDA(A2),D1                    ; $015ECE
        DC.W    $0000,$0000         ; $015ED2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015ED6 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015EDA
        MOVE.L  -$7F70(A2),D1                   ; $015EDE
        DC.W    $0000,$0000         ; $015EE2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015EE6 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015EEA
        MOVE.L  -$7DBA(A2),D1                   ; $015EEE
        DC.W    $0000,$0000         ; $015EF2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015EF6 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015EFA
        MOVE.L  -$7C04(A2),D1                   ; $015EFE
        DC.W    $0000,$0000         ; $015F02 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015F06 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015F0A
        MOVE.L  -$7A4E(A2),D1                   ; $015F0E
        DC.W    $0000,$0000         ; $015F12 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015F16 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015F1A
        MOVE.L  -$7898(A2),D1                   ; $015F1E
        DC.W    $0000,$0000         ; $015F22 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $015F26 ORI.B  #$0000,D0
        MOVE.L  $5852(A2),D1                    ; $015F2A
        MOVE.L  -$7534(A2),D1                   ; $015F2E
        DC.W    $0000,$0000         ; $015F32 ORI.B  #$0000,D0
        MOVE.L  -$76B8(A2),D1                   ; $015F36
        DC.W    $0000,$0000         ; $015F3A ORI.B  #$0000,D0
        MOVE.L  -$71B4(A2),D1                   ; $015F3E
        DC.W    $0000,$0000         ; $015F42 ORI.B  #$0000,D0
        MOVE.L  -$76B8(A2),D1                   ; $015F46
        DC.W    $0000,$0000         ; $015F4A ORI.B  #$0000,D0
        MOVE.L  -$6E34(A2),D1                   ; $015F4E
        DC.W    $0000,$0000         ; $015F52 ORI.B  #$0000,D0
        MOVE.L  -$76B8(A2),D1                   ; $015F56
        DC.W    $0000,$0000         ; $015F5A ORI.B  #$0000,D0
        MOVE.L  -$6AB4(A2),D1                   ; $015F5E
        DC.W    $0000,$0000         ; $015F62 ORI.B  #$0000,D0
        MOVE.L  -$76B8(A2),D1                   ; $015F66
        DC.W    $0000,$0000         ; $015F6A ORI.B  #$0000,D0
        MOVE.L  -$6734(A2),D1                   ; $015F6E
        DC.W    $0000,$0000         ; $015F72 ORI.B  #$0000,D0
        MOVE.L  -$76B8(A2),D1                   ; $015F76
        DC.W    $0000,$0000         ; $015F7A ORI.B  #$0000,D0
        MOVE.L  -$63B4(A2),D1                   ; $015F7E
        MOVE.L  -$76E2(A2),D1                   ; $015F82
        MOVE.L  -$76B8(A2),D1                   ; $015F86
        DC.W    $0000,$0000         ; $015F8A ORI.B  #$0000,D0
        MOVE.L  -$6058(A2),D1                   ; $015F8E
        MOVE.L  -$76E2(A2),D1                   ; $015F92
        MOVE.L  -$76B8(A2),D1                   ; $015F96
        DC.W    $0000,$0000         ; $015F9A ORI.B  #$0000,D0
        MOVE.L  -$5CFC(A2),D1                   ; $015F9E
        MOVE.L  -$76E2(A2),D1                   ; $015FA2
        MOVE.L  -$76B8(A2),D1                   ; $015FA6
        DC.W    $0000,$0000         ; $015FAA ORI.B  #$0000,D0
        MOVE.L  -$58CC(A2),D1                   ; $015FAE
        MOVE.L  -$76E2(A2),D1                   ; $015FB2
        MOVE.L  -$76B8(A2),D1                   ; $015FB6
        DC.W    $0000,$0000         ; $015FBA ORI.B  #$0000,D0
        MOVE.L  -$549C(A2),D1                   ; $015FBE
        MOVE.L  -$76E2(A2),D1                   ; $015FC2
        MOVE.L  -$76B8(A2),D1                   ; $015FC6
        DC.W    $0000,$0000         ; $015FCA ORI.B  #$0000,D0
        MOVE.L  -$506C(A2),D1                   ; $015FCE
        MOVE.L  -$76E2(A2),D1                   ; $015FD2
        MOVE.L  -$76B8(A2),D1                   ; $015FD6
        DC.W    $0000,$0000         ; $015FDA ORI.B  #$0000,D0
        MOVE.L  -$4C3C(A2),D1                   ; $015FDE
        MOVE.L  -$76E2(A2),D1                   ; $015FE2
        MOVE.L  -$76B8(A2),D1                   ; $015FE6
        DC.W    $0000,$0000         ; $015FEA ORI.B  #$0000,D0
        MOVE.L  -$480C(A2),D1                   ; $015FEE
        MOVE.L  -$76E2(A2),D1                   ; $015FF2
        MOVE.L  -$76B8(A2),D1                   ; $015FF6
        MOVE.L  -$75F6(A2),D1                   ; $015FFA
        MOVE.L  -$44B0(A2),D1                   ; $015FFE
        MOVE.L  -$76E2(A2),D1                   ; $016002
        MOVE.L  -$76B8(A2),D1                   ; $016006
        MOVE.L  -$75F6(A2),D1                   ; $01600A
        MOVE.L  -$4154(A2),D1                   ; $01600E
        MOVE.L  -$76E2(A2),D1                   ; $016012
        MOVE.L  -$76B8(A2),D1                   ; $016016
        MOVE.L  -$75F6(A2),D1                   ; $01601A
        MOVE.L  -$3DF8(A2),D1                   ; $01601E
        MOVE.L  -$76E2(A2),D1                   ; $016022
        DC.W    $0000,$0000         ; $016026 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $01602A
        MOVE.L  -$39C8(A2),D1                   ; $01602E
        MOVE.L  -$76E2(A2),D1                   ; $016032
        DC.W    $0000,$0000         ; $016036 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $01603A
        MOVE.L  -$3598(A2),D1                   ; $01603E
        MOVE.L  -$76E2(A2),D1                   ; $016042
        DC.W    $0000,$0000         ; $016046 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $01604A
        MOVE.L  -$3168(A2),D1                   ; $01604E
        MOVE.L  -$76E2(A2),D1                   ; $016052
        DC.W    $0000,$0000         ; $016056 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $01605A
        MOVE.L  -$2D38(A2),D1                   ; $01605E
        MOVE.L  -$76E2(A2),D1                   ; $016062
        DC.W    $0000,$0000         ; $016066 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $01606A
        MOVE.L  -$29DC(A2),D1                   ; $01606E
        MOVE.L  -$76E2(A2),D1                   ; $016072
        DC.W    $0000,$0000         ; $016076 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $01607A
        MOVE.L  -$2680(A2),D1                   ; $01607E
        DC.W    $0000,$0000         ; $016082 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $016086 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $01608A
        MOVE.L  -$2300(A2),D1                   ; $01608E
        DC.W    $0000,$0000         ; $016092 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $016096 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $01609A
        MOVE.L  -$1F80(A2),D1                   ; $01609E
        DC.W    $0000,$0000         ; $0160A2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0160A6 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $0160AA
        MOVE.L  -$1C00(A2),D1                   ; $0160AE
        DC.W    $0000,$0000         ; $0160B2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0160B6 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $0160BA
        MOVE.L  -$1880(A2),D1                   ; $0160BE
        DC.W    $0000,$0000         ; $0160C2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0160C6 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $0160CA
        MOVE.L  -$1500(A2),D1                   ; $0160CE
        DC.W    $0000,$0000         ; $0160D2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0160D6 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $0160DA
        MOVE.L  -$1180(A2),D1                   ; $0160DE
        DC.W    $0000,$0000         ; $0160E2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0160E6 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $0160EA
        MOVE.L  -$0E00(A2),D1                   ; $0160EE
        DC.W    $0000,$0000         ; $0160F2 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $0160F6 ORI.B  #$0000,D0
        MOVE.L  -$75F6(A2),D1                   ; $0160FA
        MOVE.L  -$08D2(A2),D1                   ; $0160FE
        DC.W    $0000,$0000         ; $016102 ORI.B  #$0000,D0
        MOVE.L  -$0A56(A2),D1                   ; $016106
        DC.W    $0000,$0000         ; $01610A ORI.B  #$0000,D0
        MOVE.L  -$0552(A2),D1                   ; $01610E
        DC.W    $0000,$0000         ; $016112 ORI.B  #$0000,D0
        MOVE.L  -$0A56(A2),D1                   ; $016116
        DC.W    $0000,$0000         ; $01611A ORI.B  #$0000,D0
        MOVE.L  -$01D2(A2),D1                   ; $01611E
        DC.W    $0000,$0000         ; $016122 ORI.B  #$0000,D0
        MOVE.L  -$0A56(A2),D1                   ; $016126
        DC.W    $0000,$0000         ; $01612A ORI.B  #$0000,D0
        MOVE.L  $01AE(A3),D1                    ; $01612E
        DC.W    $0000,$0000         ; $016132 ORI.B  #$0000,D0
        MOVE.L  -$0A56(A2),D1                   ; $016136
        DC.W    $0000,$0000         ; $01613A ORI.B  #$0000,D0
        MOVE.L  $052E(A3),D1                    ; $01613E
        DC.W    $0000,$0000         ; $016142 ORI.B  #$0000,D0
        MOVE.L  -$0A56(A2),D1                   ; $016146
        DC.W    $0000,$0000         ; $01614A ORI.B  #$0000,D0
        MOVE.L  $08AE(A3),D1                    ; $01614E
        DC.W    $0000,$0000         ; $016152 ORI.B  #$0000,D0
        MOVE.L  -$0A56(A2),D1                   ; $016156
        DC.W    $0000,$0000         ; $01615A ORI.B  #$0000,D0
        MOVE.L  $0C2E(A3),D1                    ; $01615E
        DC.W    $0000,$0000         ; $016162 ORI.B  #$0000,D0
        MOVE.L  -$0A56(A2),D1                   ; $016166
        DC.W    $0000,$0000         ; $01616A ORI.B  #$0000,D0
        MOVE.L  $0FAE(A3),D1                    ; $01616E
        DC.W    $0000,$0000         ; $016172 ORI.B  #$0000,D0
        MOVE.L  -$0A56(A2),D1                   ; $016176
        DC.W    $0000,$0000         ; $01617A ORI.B  #$0000,D0
        MOVE.L  $132E(A3),D1                    ; $01617E
        MOVE.L  -$0A80(A2),D1                   ; $016182
        MOVE.L  -$0A56(A2),D1                   ; $016186
        DC.W    $0000,$0000         ; $01618A ORI.B  #$0000,D0
        MOVE.L  $168A(A3),D1                    ; $01618E
        MOVE.L  -$0A80(A2),D1                   ; $016192
        MOVE.L  -$0A56(A2),D1                   ; $016196
        DC.W    $0000,$0000         ; $01619A ORI.B  #$0000,D0
        MOVE.L  $19E6(A3),D1                    ; $01619E
        MOVE.L  -$0A80(A2),D1                   ; $0161A2
        MOVE.L  -$0A56(A2),D1                   ; $0161A6
        DC.W    $0000,$0000         ; $0161AA ORI.B  #$0000,D0
        MOVE.L  $1E16(A3),D1                    ; $0161AE
        MOVE.L  -$0A80(A2),D1                   ; $0161B2
        MOVE.L  -$0A56(A2),D1                   ; $0161B6
        DC.W    $0000,$0000         ; $0161BA ORI.B  #$0000,D0
        MOVE.L  $2246(A3),D1                    ; $0161BE
        MOVE.L  -$0A80(A2),D1                   ; $0161C2
        MOVE.L  -$0A56(A2),D1                   ; $0161C6
        DC.W    $0000,$0000         ; $0161CA ORI.B  #$0000,D0
        MOVE.L  $2676(A3),D1                    ; $0161CE
        MOVE.L  -$0A80(A2),D1                   ; $0161D2
        MOVE.L  -$0A56(A2),D1                   ; $0161D6
        MOVE.L  -$0994(A2),D1                   ; $0161DA
        MOVE.L  $29D2(A3),D1                    ; $0161DE
        MOVE.L  -$0A80(A2),D1                   ; $0161E2
        MOVE.L  -$0A56(A2),D1                   ; $0161E6
        MOVE.L  -$0994(A2),D1                   ; $0161EA
        MOVE.L  $2D2E(A3),D1                    ; $0161EE
        MOVE.L  -$0A80(A2),D1                   ; $0161F2
        DC.W    $0000,$0000         ; $0161F6 ORI.B  #$0000,D0
        MOVE.L  -$0994(A2),D1                   ; $0161FA
        MOVE.L  $315E(A3),D1                    ; $0161FE
