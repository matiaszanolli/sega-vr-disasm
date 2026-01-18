; Generated assembly for $004200-$006200
; Branch targets: 287
; Labels: 123

        org     $004200

        AND.B  -(A0),D5                         ; $004200
        MOVEQ   #$07,D7                         ; $004202
        MOVEQ   #$00,D0                         ; $004204
        MOVE.B  $C30C.W,D0                      ; $004206
        MOVE.W  D0,D1                           ; $00420A
        CMPI.B  #$0009,D0                       ; $00420C
        BLE.S  loc_004228                       ; $004210
        LEA     $00FF6830,A2                    ; $004212
        MOVE.B  D7,$0000(A2)                    ; $004218
        MOVE.L  #$222EA436,$0008(A2)            ; $00421C
        SUBI.B  #$000A,D0                       ; $004224
loc_004228:
        LEA     $00FF6820,A2                    ; $004228
        MOVE.B  D7,$0000(A2)                    ; $00422E
        LSL.W  #2,D0                            ; $004232
        LEA     $008997C4,A3                    ; $004234
        MOVE.L  $00(A3,D0.W),$0008(A2)          ; $00423A
        LSL.W  #2,D1                            ; $004240
        LEA     $00FF6810,A2                    ; $004242
        LEA     $00899780,A3                    ; $004248
        MOVE.L  $00(A3,D1.W),$0008(A2)          ; $00424E
        LEA     $C260.W,A1                      ; $004254
        LEA     $00FF6860,A2                    ; $004258
        BSR.S  loc_004280                       ; $00425E
        LEA     $C254.W,A1                      ; $004260
        LEA     $00FF6870,A2                    ; $004264
        CMPI.L  #$61000000,(A1)                 ; $00426A
        BEQ.S  loc_004274                       ; $004270
        BSR.S  loc_004280                       ; $004272
loc_004274:
        MOVE.W  #$0040,$C25C.W                  ; $004274
        ADDQ.W  #4,$C07C.W                      ; $00427A
        RTS                                     ; $00427E
loc_004280:
        MOVE.B  (A1)+,D0                        ; $004280
        MOVE.B  D0,$000A(A2)                    ; $004282
        LSR.B  #4,D0                            ; $004286
        MOVE.B  D0,$0009(A2)                    ; $004288
        MOVE.B  (A1)+,D0                        ; $00428C
        MOVE.B  D0,$000C(A2)                    ; $00428E
        LSR.B  #4,D0                            ; $004292
        MOVE.B  D0,$000B(A2)                    ; $004294
        MOVE.W  (A1)+,D0                        ; $004298
        MOVE.B  D0,$000F(A2)                    ; $00429A
        LSR.W  #4,D0                            ; $00429E
        MOVE.B  D0,$000E(A2)                    ; $0042A0
        LSR.W  #4,D0                            ; $0042A4
        MOVE.B  D0,$000D(A2)                    ; $0042A6
        ANDI.W  #$0F0F,$000A(A2)                ; $0042AA
        ANDI.L  #$0F0F0F0F,$000C(A2)            ; $0042B0
        RTS                                     ; $0042B8
        CMPI.W  #$0014,$C8AA.W                  ; $0042BA
        BLE.S  loc_0042FE                       ; $0042C0
        MOVE.B  #$0095,$C8A5.W                  ; $0042C2
        MOVE.W  #$0000,$C084.W                  ; $0042C8
        ADDQ.W  #4,$C07C.W                      ; $0042CE
        MOVE.W  #$0000,$C8AA.W                  ; $0042D2
        LEA     $00FF6754,A2                    ; $0042D8
        MOVE.W  #$FFE0,$0004(A2)                ; $0042DE
        MOVE.W  #$0040,$0006(A2)                ; $0042E4
        MOVE.W  #$F600,$0008(A2)                ; $0042EA
        MOVE.L  #$22295ADE,$0010(A2)            ; $0042F0
        MOVE.W  #$0001,$0000(A2)                ; $0042F8
loc_0042FE:
        RTS                                     ; $0042FE
        LEA     $00FF6754,A2                    ; $004300
        ADDQ.W  #8,$C25C.W                      ; $004306
        MOVE.W  $C25C.W,D0                      ; $00430A
        MOVE.W  D0,$0006(A2)                    ; $00430E
        ADDQ.W  #2,$0004(A2)                    ; $004312
        ADDI.W  #$01C0,$0008(A2)                ; $004316
        CMPI.W  #$0100,D0                       ; $00431C
        BNE.S  loc_00432C                       ; $004320
        ADDQ.W  #4,$C07C.W                      ; $004322
        MOVE.W  #$0000,$C8AA.W                  ; $004326
loc_00432C:
        RTS                                     ; $00432C
        CMPI.W  #$003C,$C8AA.W                  ; $00432E
        BNE.S  loc_004348                       ; $004334
        ADDQ.W  #4,$C07C.W                      ; $004336
        MOVE.W  #$0000,$C8AA.W                  ; $00433A
        MOVE.W  #$0000,$00FF6754                ; $004340
loc_004348:
        RTS                                     ; $004348
        MOVE.W  $C084.W,D0                      ; $00434A
        CMPI.W  #$000A,D0                       ; $00434E
        BGT.S  loc_004384                       ; $004352
        ADDQ.W  #1,D0                           ; $004354
        MOVE.W  D0,$C084.W                      ; $004356
        MOVEQ   #$1E,D0                         ; $00435A
        LEA     $00FF6802,A2                    ; $00435C
        SUB.W  D0,$0000(A2)                     ; $004362
        SUB.W  D0,$0010(A2)                     ; $004366
        SUB.W  D0,$0020(A2)                     ; $00436A
        SUB.W  D0,$0030(A2)                     ; $00436E
        SUB.W  D0,$0040(A2)                     ; $004372
        SUB.W  D0,$0050(A2)                     ; $004376
        SUB.W  D0,$0060(A2)                     ; $00437A
        SUB.W  D0,$0070(A2)                     ; $00437E
        RTS                                     ; $004382
loc_004384:
        ADDQ.W  #4,$C07C.W                      ; $004384
        MOVE.W  #$0000,$C8AA.W                  ; $004388
        RTS                                     ; $00438E
        CMPI.W  #$0028,$C8AA.W                  ; $004390
        BNE.S  loc_0043BA                       ; $004396
        ADDQ.W  #4,$C07C.W                      ; $004398
        MOVE.W  #$0000,$C8AA.W                  ; $00439C
        MOVE.B  #$0001,$C809.W                  ; $0043A2
        MOVE.B  #$0001,$C80A.W                  ; $0043A8
        BSET    #7,$C80E.W                      ; $0043AE
        MOVE.B  #$0001,$C802.W                  ; $0043B4
loc_0043BA:
        RTS                                     ; $0043BA
        BTST    #7,$C80E.W                      ; $0043BC
        BNE.S  loc_0043CE                       ; $0043C2
        MOVE.B  #$00F3,$C822.W                  ; $0043C4
        ADDQ.W  #4,$C07C.W                      ; $0043CA
loc_0043CE:
        RTS                                     ; $0043CE
        MOVE.L  #$0088FB98,$00FF0002            ; $0043D0
        BTST    #5,$C30E.W                      ; $0043DA
        BNE.S  loc_004402                       ; $0043E0
        MOVE.L  #$60000000,$C260.W              ; $0043E2
        LEA     $C200.W,A1                      ; $0043EA
        MOVE.W  $002C(A0),D0                    ; $0043EE
        LSL.W  #2,D0                            ; $0043F2
        MOVE.L  #$00000000,$00(A1,D0.W)         ; $0043F4
        BCLR    #3,$C80E.W                      ; $0043FC
loc_004402:
        ANDI.B  #$007F,$C80E.W                  ; $004402
        MOVE.W  #$0000,$C87E.W                  ; $004408
        MOVEQ   #$00,D0                         ; $00440E
        MOVE.W  D0,$C880.W                      ; $004410
        MOVE.W  D0,$C882.W                      ; $004414
        MOVE.W  #$0020,$00FF0008                ; $004418
        JSR     $00B4CA(PC)                     ; $004420
        MOVE.B  #$0000,$C800.W                  ; $004424
        JMP     $002890(PC)                     ; $00442A [func_002890]
        MOVE.W  #$0001,$C048.W                  ; $00442E
        MOVE.W  $C07C.W,D0                      ; $004434
        MOVEA.L $04(PC,D0.W),A1                 ; $004438
        JMP     (A1)                            ; $00443C
        ORI.L  #$444E0088,A0                    ; $00443E
        NEG.W  -(A0)                            ; $004444
        ORI.L  #$44980088,A0                    ; $004446
        NEG.L  -(A6)                            ; $00444C
        MOVE.B  #$0001,$C800.W                  ; $00444E
        ADDQ.W  #4,$C07C.W                      ; $004454
        MOVE.W  #$0000,$C8AA.W                  ; $004458
        RTS                                     ; $00445E
        CMPI.W  #$0001,$C8AA.W                  ; $004460
        BNE.S  loc_00446C                       ; $004466
        JSR     $002066(PC)                     ; $004468
loc_00446C:
        CMPI.W  #$003C,$C8AA.W                  ; $00446C
        BNE.S  loc_004496                       ; $004472
        ADDQ.W  #4,$C07C.W                      ; $004474
        MOVE.W  #$0000,$C8AA.W                  ; $004478
        MOVE.B  #$0001,$C809.W                  ; $00447E
        MOVE.B  #$0001,$C80A.W                  ; $004484
        BSET    #7,$C80E.W                      ; $00448A
        MOVE.B  #$0001,$C802.W                  ; $004490
loc_004496:
        RTS                                     ; $004496
        BTST    #7,$C80E.W                      ; $004498
        BNE.S  loc_0044A4                       ; $00449E
        ADDQ.W  #4,$C07C.W                      ; $0044A0
loc_0044A4:
        RTS                                     ; $0044A4
        ANDI.B  #$0077,$C80E.W                  ; $0044A6
        MOVE.W  #$0000,$C87E.W                  ; $0044AC
        MOVE.W  #$0000,$C8A8.W                  ; $0044B2
        MOVEQ   #$00,D0                         ; $0044B8
        MOVE.W  D0,$C880.W                      ; $0044BA
        MOVE.W  D0,$C882.W                      ; $0044BE
        MOVE.W  #$0020,$00FF0008                ; $0044C2
        ANDI.B  #$00C7,$C80E.W                  ; $0044CA
        MOVE.B  #$0000,$C800.W                  ; $0044D0
        BCLR    #3,$C80E.W                      ; $0044D6
        MOVE.L  #$008909AE,$00FF0002            ; $0044DC
        RTS                                     ; $0044E6
        MOVE.W  #$0001,$C048.W                  ; $0044E8
        MOVE.W  $C07C.W,D0                      ; $0044EE
        MOVEA.L $04(PC,D0.W),A1                 ; $0044F2
        JMP     (A1)                            ; $0044F6
        ORI.L  #$45360088,A0                    ; $0044F8
        DC.W    $4538                           ; $0044FE
        ORI.L  #$45660088,A0                    ; $004500
        DC.W    $4566                           ; $004506
        ORI.L  #$456C0088,A0                    ; $004508
        NOT.B  $0088.W                          ; $00450E
        NOT.W  A2                               ; $004512
        ORI.L  #$465C0088,A0                    ; $004514
        NOT.L  D2                               ; $00451A
        MOVE.W  $C8BE.W,D0                      ; $00451C
        MOVEA.L $04(PC,D0.W),A1                 ; $004520
        JMP     (A1)                            ; $004524
        ORI.L  #$46960088,A0                    ; $004526
        NOT.L  $0088(A2)                        ; $00452C
        NOT    $0088(A6)                        ; $004530
        DC.W    $471E                           ; $004534
        RTS                                     ; $004536
        JSR     $00B25E(PC)                     ; $004538
        ADDQ.W  #4,$C07C.W                      ; $00453C
        CMPA.W  #$9000,A0                       ; $004540
        BNE.S  loc_004556                       ; $004544
        MOVE.B  #$00AA,$C8A5.W                  ; $004546
        MOVE.B  #$0000,$00FF6930                ; $00454C
        RTS                                     ; $004554
loc_004556:
        MOVE.B  #$00AB,$C8A5.W                  ; $004556
        MOVE.B  #$0000,$00FF6940                ; $00455C
        RTS                                     ; $004564
        ADDQ.W  #4,$C07C.W                      ; $004566
        RTS                                     ; $00456A
        MOVEQ   #$00,D0                         ; $00456C
        MOVE.B  $C819.W,D0                      ; $00456E
        LSL.W  #2,D0                            ; $004572
        MOVEA.L $04(PC,D0.W),A1                 ; $004574
        JMP     (A1)                            ; $004578
        ORI.L  #$46360088,A0                    ; $00457A
        DC.W    $458A                           ; $004580
        ORI.L  #$45CE0088,A0                    ; $004582
        NOT.B  -$07(A0,D4.W)                    ; $004588
        DC.W    $00FF                           ; $00458C
        BVS.S  loc_004570                       ; $00458E
        MOVE.B  #$0007,(A2)                     ; $004590
        MOVE.W  #$01AE,$0002(A2)                ; $004594
        MOVE.L  #$222EDB1A,$0008(A2)            ; $00459A
        MOVE.B  #$0000,$C816.W                  ; $0045A2
        MOVE.L  #$0402C000,$0004(A2)            ; $0045A8
        CMPA.W  #$9000,A0                       ; $0045B0
        BEQ.S  loc_0045C4                       ; $0045B4
        MOVE.B  #$0001,$C816.W                  ; $0045B6
        MOVE.L  #$04038000,$0004(A2)            ; $0045BC
loc_0045C4:
        ADDQ.B  #1,$C819.W                      ; $0045C4
        ADDQ.W  #4,$C07C.W                      ; $0045C8
        RTS                                     ; $0045CC
        MOVE.B  #$0007,(A2)                     ; $0045CE
        MOVE.W  #$01AE,$0002(A2)                ; $0045D2
        MOVE.L  #$222EDB1A,$0008(A2)            ; $0045D8
        MOVE.B  #$0003,$C819.W                  ; $0045E0
        CMPA.W  #$9000,A0                       ; $0045E6
        BEQ.S  loc_0045F8                       ; $0045EA
        MOVE.L  $B180.W,D0                      ; $0045EC
        CMP.L  $C260.W,D0                       ; $0045F0
        BLE.S  loc_00461A                       ; $0045F4
        BRA.S  loc_004604                       ; $0045F6
loc_0045F8:
        MOVE.L  $B580.W,D0                      ; $0045F8
        CMP.L  $C260.W,D0                       ; $0045FC
        BLE.S  loc_004604                       ; $004600
        BRA.S  loc_00461A                       ; $004602
loc_004604:
        MOVE.B  #$0001,$C816.W                  ; $004604
        MOVE.L  #$04038000,$0004(A2)            ; $00460A
        MOVE.W  #$0000,$B39C.W                  ; $004612
        RTS                                     ; $004618
loc_00461A:
        MOVE.B  #$0000,$C816.W                  ; $00461A
        MOVE.L  #$0402C000,$0004(A2)            ; $004620
        MOVE.W  #$0000,$B79C.W                  ; $004628
        RTS                                     ; $00462E
        MOVE.B  #$0003,$C819.W                  ; $004630
        RTS                                     ; $004636
        MOVE.B  #$00F2,$C822.W                  ; $004638
        SUBQ.W  #6,$00FF69E2                    ; $00463E
        ADDQ.W  #4,$C07C.W                      ; $004644
        RTS                                     ; $004648
        MOVE.B  #$0096,$C8A5.W                  ; $00464A
        SUBQ.W  #6,$00FF69E2                    ; $004650
        ADDQ.W  #4,$C07C.W                      ; $004656
        RTS                                     ; $00465A
        MOVE.W  #$0014,$002C(A0)                ; $00465C
        LEA     $00FF69E0,A2                    ; $004662
        SUBI.W  #$000A,$0002(A2)                ; $004668
        CMPI.W  #$00E6,$0002(A2)                ; $00466E
        BGT.S  loc_004680                       ; $004674
        MOVE.W  #$00E6,$0002(A2)                ; $004676
        ADDQ.W  #4,$C07C.W                      ; $00467C
loc_004680:
        RTS                                     ; $004680
        MOVEQ   #$00,D0                         ; $004682
        BTST    #2,$C8AB.W                      ; $004684
        BNE.S  loc_00468E                       ; $00468A
        MOVEQ   #$07,D0                         ; $00468C
loc_00468E:
        MOVE.B  D0,$00FF69E0                    ; $00468E
        RTS                                     ; $004694
        CMPI.B  #$0003,$C819.W                  ; $004696
        BNE.S  loc_0046A8                       ; $00469C
        ADDQ.W  #4,$C8BE.W                      ; $00469E
        MOVE.W  #$0000,$C8AA.W                  ; $0046A2
loc_0046A8:
        RTS                                     ; $0046A8
        CMPI.W  #$0028,$C8AA.W                  ; $0046AA
        BNE.S  loc_0046EC                       ; $0046B0
        ADDQ.W  #4,$C8BE.W                      ; $0046B2
        MOVE.W  #$0000,$C8AA.W                  ; $0046B6
        MOVE.B  #$00AB,$C8A5.W                  ; $0046BC
        TST.B  $C816.W                          ; $0046C2
        BEQ.S  loc_0046CE                       ; $0046C6
        MOVE.B  #$00AA,$C8A5.W                  ; $0046C8
loc_0046CE:
        MOVE.B  #$0001,$C800.W                  ; $0046CE
        MOVE.B  #$0001,$C809.W                  ; $0046D4
        MOVE.B  #$0001,$C80A.W                  ; $0046DA
        BSET    #7,$C80E.W                      ; $0046E0
        MOVE.B  #$0001,$C802.W                  ; $0046E6
loc_0046EC:
        RTS                                     ; $0046EC
        MOVE.W  #$0001,$C048.W                  ; $0046EE
        BTST    #7,$C80E.W                      ; $0046F4
        BNE.S  loc_00471C                       ; $0046FA
        LEA     $B400.W,A1                      ; $0046FC
        LEA     $A400.W,A2                      ; $004700
        MOVEQ   #$1F,D7                         ; $004704
loc_004706:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A1)+   ; $004706
        MOVEM.L -(A2),D4/A1/A2/A3/A4/A5/A6/A7   ; $00470A
        DBRA    D7,loc_004706                   ; $00470E
        MOVE.B  #$00F3,$C822.W                  ; $004712
        ADDQ.W  #4,$C8BE.W                      ; $004718
loc_00471C:
        RTS                                     ; $00471C
        BTST    #5,$C30E.W                      ; $00471E
        BNE.S  loc_00472E                       ; $004724
        MOVE.L  #$60000000,$C260.W              ; $004726
loc_00472E:
        ANDI.B  #$007F,$C80E.W                  ; $00472E
        MOVE.W  #$0000,$C87E.W                  ; $004734
        MOVEQ   #$00,D0                         ; $00473A
        MOVE.W  D0,$C880.W                      ; $00473C
        MOVE.W  D0,$C882.W                      ; $004740
        MOVE.W  #$8B00,(A5)                     ; $004744
        MOVE.W  #$0000,$C8A8.W                  ; $004748
        MOVE.W  #$0020,$00FF0008                ; $00474E
        MOVE.L  #$0088FB98,$00FF0002            ; $004756
        MOVE.B  #$0000,$C800.W                  ; $004760
        JMP     $002890(PC)                     ; $004766 [func_002890]
        MOVE.W  #$0001,$C048.W                  ; $00476A
        MOVE.W  $C07C.W,D0                      ; $004770
        MOVEA.L $04(PC,D0.W),A1                 ; $004774
        JMP     (A1)                            ; $004778
        ORI.L  #$478A0088,A0                    ; $00477A
        DC.W    $479E                           ; $004780
        ORI.L  #$47CA0088,A0                    ; $004782
        LEA     -(A4),A3                        ; $004788
        MOVE.B  #$0001,$C800.W                  ; $00478A
        MOVE.W  #$0000,$C8AA.W                  ; $004790
        ADDQ.W  #4,$C07C.W                      ; $004796
        JMP     $00B25E(PC)                     ; $00479A
        CMPI.W  #$0028,$C8AA.W                  ; $00479E
        BNE.S  loc_0047C8                       ; $0047A4
        MOVE.W  #$0000,$C8AA.W                  ; $0047A6
        ADDQ.W  #4,$C07C.W                      ; $0047AC
        MOVE.B  #$0001,$C809.W                  ; $0047B0
        MOVE.B  #$0001,$C80A.W                  ; $0047B6
        BSET    #7,$C80E.W                      ; $0047BC
        MOVE.B  #$0001,$C802.W                  ; $0047C2
loc_0047C8:
        RTS                                     ; $0047C8
        MOVE.W  #$0001,$C048.W                  ; $0047CA
        BTST    #7,$C80E.W                      ; $0047D0
        BNE.S  loc_0047E2                       ; $0047D6
        MOVE.B  #$00F3,$C822.W                  ; $0047D8
        ADDQ.W  #4,$C07C.W                      ; $0047DE
loc_0047E2:
        RTS                                     ; $0047E2
        BTST    #5,$C30E.W                      ; $0047E4
        BNE.S  loc_0047F4                       ; $0047EA
        MOVE.L  #$60000000,$C260.W              ; $0047EC
loc_0047F4:
        ANDI.B  #$007F,$C80E.W                  ; $0047F4
        MOVE.W  #$0000,$C87E.W                  ; $0047FA
        MOVEQ   #$00,D0                         ; $004800
        MOVE.W  D0,$C880.W                      ; $004802
        MOVE.W  D0,$C882.W                      ; $004806
        MOVE.W  #$0000,$C8A8.W                  ; $00480A
        MOVE.W  #$0020,$00FF0008                ; $004810
        MOVE.B  #$0000,$C800.W                  ; $004818
        MOVE.L  #$0088FB98,$00FF0002            ; $00481E
        RTS                                     ; $004828
        LSL.L  #2,D0                            ; $00482A
        LSR.W  #2,D0                            ; $00482C
        ORI.W  #$4000,D0                        ; $00482E
        SWAP    D0                              ; $004832
        RTS                                     ; $004834
        JSR     loc_00483A(PC)                  ; $004836
loc_00483A:
        JSR     loc_00483E(PC)                  ; $00483A
loc_00483E:
        JSR     loc_004842(PC)                  ; $00483E
loc_004842:
        JSR     loc_004846(PC)                  ; $004842
loc_004846:
        MOVE.L  D1,(A1)+                        ; $004846
        MOVE.L  D1,(A1)+                        ; $004848
        MOVE.L  D1,(A1)+                        ; $00484A
        MOVE.L  D1,(A1)+                        ; $00484C
        MOVE.L  D1,(A1)+                        ; $00484E
        MOVE.L  D1,(A1)+                        ; $004850
        MOVE.L  D1,(A1)+                        ; $004852
        MOVE.L  D1,(A1)+                        ; $004854
        MOVE.L  D1,(A1)+                        ; $004856
        MOVE.L  D1,(A1)+                        ; $004858
        MOVE.L  D1,(A1)+                        ; $00485A
        MOVE.L  D1,(A1)+                        ; $00485C
        MOVE.L  D1,(A1)+                        ; $00485E
        MOVE.L  D1,(A1)+                        ; $004860
        MOVE.L  D1,(A1)+                        ; $004862
        MOVE.L  D1,(A1)+                        ; $004864
        MOVE.L  D1,(A1)+                        ; $004866
        MOVE.L  D1,(A1)+                        ; $004868
        MOVE.L  D1,(A1)+                        ; $00486A
        MOVE.L  D1,(A1)+                        ; $00486C
        MOVE.L  D1,(A1)+                        ; $00486E
        MOVE.L  D1,(A1)+                        ; $004870
        MOVE.L  D1,(A1)+                        ; $004872
        MOVE.L  D1,(A1)+                        ; $004874
        MOVE.L  D1,(A1)+                        ; $004876
        MOVE.L  D1,(A1)+                        ; $004878
        MOVE.L  D1,(A1)+                        ; $00487A
        MOVE.L  D1,(A1)+                        ; $00487C
        MOVE.L  D1,(A1)+                        ; $00487E
        MOVE.L  D1,(A1)+                        ; $004880
        MOVE.L  D1,(A1)+                        ; $004882
        MOVE.L  D1,(A1)+                        ; $004884
        RTS                                     ; $004886
        MOVE.L  D1,(A6)                         ; $004888
        MOVE.L  D1,(A6)                         ; $00488A
        MOVE.L  D1,(A6)                         ; $00488C
        MOVE.L  D1,(A6)                         ; $00488E
        MOVE.L  D1,(A6)                         ; $004890
        MOVE.L  D1,(A6)                         ; $004892
        MOVE.L  D1,(A6)                         ; $004894
        MOVE.L  D1,(A6)                         ; $004896
        MOVE.L  D1,(A6)                         ; $004898
        MOVE.L  D1,(A6)                         ; $00489A
        MOVE.L  D1,(A6)                         ; $00489C
        MOVE.L  D1,(A6)                         ; $00489E
        MOVE.L  D1,(A6)                         ; $0048A0
        MOVE.L  D1,(A6)                         ; $0048A2
        MOVE.L  D1,(A6)                         ; $0048A4
        MOVE.L  D1,(A6)                         ; $0048A6
        MOVE.L  D1,(A6)                         ; $0048A8
        MOVE.L  D1,(A6)                         ; $0048AA
        MOVE.L  D1,(A6)                         ; $0048AC
        MOVE.L  D1,(A6)                         ; $0048AE
        MOVE.L  D1,(A6)                         ; $0048B0
        MOVE.L  D1,(A6)                         ; $0048B2
        MOVE.L  D1,(A6)                         ; $0048B4
        MOVE.L  D1,(A6)                         ; $0048B6
        MOVE.L  D1,(A6)                         ; $0048B8
        MOVE.L  D1,(A6)                         ; $0048BA
        MOVE.L  D1,(A6)                         ; $0048BC
        MOVE.L  D1,(A6)                         ; $0048BE
        MOVE.L  D1,(A6)                         ; $0048C0
        MOVE.L  D1,(A6)                         ; $0048C2
        MOVE.L  D1,(A6)                         ; $0048C4
        MOVE.L  D1,(A6)                         ; $0048C6
        RTS                                     ; $0048C8
        JSR     loc_0048CE(PC)                  ; $0048CA
loc_0048CE:
        JSR     loc_0048D2(PC)                  ; $0048CE
loc_0048D2:
        JSR     loc_0048D6(PC)                  ; $0048D2
loc_0048D6:
        JSR     loc_0048FA(PC)                  ; $0048D6
        MOVE.L  (A1)+,(A2)+                     ; $0048DA
        MOVE.L  (A1)+,(A2)+                     ; $0048DC
        MOVE.L  (A1)+,(A2)+                     ; $0048DE
        MOVE.L  (A1)+,(A2)+                     ; $0048E0
        MOVE.L  (A1)+,(A2)+                     ; $0048E2
        MOVE.L  (A1)+,(A2)+                     ; $0048E4
        MOVE.L  (A1)+,(A2)+                     ; $0048E6
        MOVE.L  (A1)+,(A2)+                     ; $0048E8
        MOVE.L  (A1)+,(A2)+                     ; $0048EA
        MOVE.L  (A1)+,(A2)+                     ; $0048EC
        MOVE.L  (A1)+,(A2)+                     ; $0048EE
        MOVE.L  (A1)+,(A2)+                     ; $0048F0
        MOVE.L  (A1)+,(A2)+                     ; $0048F2
        MOVE.L  (A1)+,(A2)+                     ; $0048F4
        MOVE.L  (A1)+,(A2)+                     ; $0048F6
        MOVE.L  (A1)+,(A2)+                     ; $0048F8
loc_0048FA:
        MOVE.L  (A1)+,(A2)+                     ; $0048FA
        MOVE.L  (A1)+,(A2)+                     ; $0048FC
        MOVE.L  (A1)+,(A2)+                     ; $0048FE
        MOVE.L  (A1)+,(A2)+                     ; $004900
        MOVE.L  (A1)+,(A2)+                     ; $004902
        MOVE.L  (A1)+,(A2)+                     ; $004904
        MOVE.L  (A1)+,(A2)+                     ; $004906
        MOVE.L  (A1)+,(A2)+                     ; $004908
        MOVE.L  (A1)+,(A2)+                     ; $00490A
        MOVE.L  (A1)+,(A2)+                     ; $00490C
        MOVE.L  (A1)+,(A2)+                     ; $00490E
        MOVE.L  (A1)+,(A2)+                     ; $004910
        MOVE.L  (A1)+,(A2)+                     ; $004912
        MOVE.L  (A1)+,(A2)+                     ; $004914
        MOVE.L  (A1)+,(A2)+                     ; $004916
        MOVE.L  (A1)+,(A2)+                     ; $004918
        MOVE.L  (A1)+,(A2)+                     ; $00491A
        MOVE.L  (A1)+,(A2)+                     ; $00491C
        MOVE.L  (A1)+,(A2)+                     ; $00491E
        MOVE.L  (A1)+,(A2)+                     ; $004920
        MOVE.L  (A1)+,(A2)+                     ; $004922
        MOVE.L  (A1)+,(A2)+                     ; $004924
        MOVE.L  (A1)+,(A2)+                     ; $004926
        MOVE.L  (A1)+,(A2)+                     ; $004928
        RTS                                     ; $00492A
        MOVE.L  (A1)+,(A6)                      ; $00492C
        MOVE.L  (A1)+,(A6)                      ; $00492E
        MOVE.L  (A1)+,(A6)                      ; $004930
        MOVE.L  (A1)+,(A6)                      ; $004932
        MOVE.L  (A1)+,(A6)                      ; $004934
        MOVE.L  (A1)+,(A6)                      ; $004936
        MOVE.L  (A1)+,(A6)                      ; $004938
        MOVE.L  (A1)+,(A6)                      ; $00493A
        MOVE.L  (A1)+,(A6)                      ; $00493C
        MOVE.L  (A1)+,(A6)                      ; $00493E
        MOVE.L  (A1)+,(A6)                      ; $004940
        MOVE.L  (A1)+,(A6)                      ; $004942
        MOVE.L  (A1)+,(A6)                      ; $004944
        MOVE.L  (A1)+,(A6)                      ; $004946
        MOVE.L  (A1)+,(A6)                      ; $004948
        MOVE.L  (A1)+,(A6)                      ; $00494A
        MOVE.L  (A1)+,(A6)                      ; $00494C
        MOVE.L  (A1)+,(A6)                      ; $00494E
        MOVE.L  (A1)+,(A6)                      ; $004950
        MOVE.L  (A1)+,(A6)                      ; $004952
        MOVE.L  (A1)+,(A6)                      ; $004954
        MOVE.L  (A1)+,(A6)                      ; $004956
        MOVE.L  (A1)+,(A6)                      ; $004958
        MOVE.L  (A1)+,(A6)                      ; $00495A
        MOVE.L  (A1)+,(A6)                      ; $00495C
        MOVE.L  (A1)+,(A6)                      ; $00495E
        MOVE.L  (A1)+,(A6)                      ; $004960
        MOVE.L  (A1)+,(A6)                      ; $004962
        MOVE.L  (A1)+,(A6)                      ; $004964
        MOVE.L  (A1)+,(A6)                      ; $004966
        MOVE.L  (A1)+,(A6)                      ; $004968
        MOVE.L  (A1)+,(A6)                      ; $00496A
        RTS                                     ; $00496C
        MOVE.L  D1,-(A7)                        ; $00496E
        MOVE.L  $EF00.W,D1                      ; $004970
        BNE.S  loc_00497C                       ; $004974
        MOVE.L  #$2A6D365A,D1                   ; $004976
loc_00497C:
        MOVE.L  D1,D0                           ; $00497C
        ASL.L  #2,D1                            ; $00497E
        ADD.L  D0,D1                            ; $004980
        ASL.L  #3,D1                            ; $004982
        ADD.L  D0,D1                            ; $004984
        MOVE.W  D1,D0                           ; $004986
        SWAP    D1                              ; $004988
        ADD.W  D1,D0                            ; $00498A
        MOVE.W  D0,D1                           ; $00498C
        SWAP    D1                              ; $00498E
        MOVE.L  D1,$EF00.W                      ; $004990
        MOVE.L  (A7)+,D1                        ; $004994
        RTS                                     ; $004996
loc_004998:
        MOVE.W  #$0004,$C87A.W                  ; $004998
        NOT    #$2300                           ; $00499E
loc_0049A2:
        TST.W  $C87A.W                          ; $0049A2
        BNE.S  loc_0049A2                       ; $0049A6
        RTS                                     ; $0049A8
loc_0049AA:
        MOVE.W  #$FF00,$C86C.W                  ; $0049AA
        MOVE.W  #$FF00,$C86E.W                  ; $0049B0
        MOVE.L  #$FFFF0000,$C970.W              ; $0049B6
        MOVE.L  #$FFFF0000,$C974.W              ; $0049BE
        RTS                                     ; $0049C6
        MOVE.W  #$FF00,$C86C.W                  ; $0049C8
        MOVE.W  #$FF00,$C86E.W                  ; $0049CE
        MOVE.L  #$FFFF0000,$C970.W              ; $0049D4
        RTS                                     ; $0049DC
        MOVE.W  #$FF00,$C86E.W                  ; $0049DE
        MOVE.L  #$FFFF0000,$C974.W              ; $0049E4
        RTS                                     ; $0049EC
loc_0049EE:
        ANDI.W  #$FF80,$C86C.W                  ; $0049EE
        ANDI.W  #$FF80,$C86E.W                  ; $0049F4
        MOVE.L  #$FFFF0000,$C970.W              ; $0049FA
        MOVE.L  #$FFFF0000,$C974.W              ; $004A02
        RTS                                     ; $004A0A
        ANDI.W  #$FF80,$C86C.W                  ; $004A0C
        ANDI.W  #$FF80,$C86E.W                  ; $004A12
        MOVE.L  #$FFFF0000,$C970.W              ; $004A18
        RTS                                     ; $004A20
        ANDI.W  #$FF80,$C86E.W                  ; $004A22
        MOVE.L  #$FFFF0000,$C974.W              ; $004A28
        RTS                                     ; $004A30
        MOVEQ   #$00,D1                         ; $004A32
        LEA     $00FF7B80,A1                    ; $004A34
        JMP     loc_00483E(PC)                  ; $004A3A
        NOT    #$2700                           ; $004A3E
        BCLR    #6,$C875.W                      ; $004A42
        MOVE.W  $C874.W,(A5)                    ; $004A48
        MOVE.W  #$0083,$00A15100                ; $004A4C
        ANDI.B  #$00FC,$00A15181                ; $004A54
        JSR     $00270A(PC)                     ; $004A5C [func_00270A]
        MOVE.B  #$0001,$C80D.W                  ; $004A60
        ANDI.B  #$0009,$C80E.W                  ; $004A66
        MOVEQ   #$00,D0                         ; $004A6C
        MOVEQ   #$00,D1                         ; $004A6E
        MOVE.B  $FEA5.W,D0                      ; $004A70
        MOVE.B  $FEB1.W,D1                      ; $004A74
        BTST    #7,$FDA8.W                      ; $004A78
        BEQ.S  loc_004A84                       ; $004A7E
        MOVE.B  $FEA6.W,D0                      ; $004A80
loc_004A84:
        JSR     func_00D19C                       ; $004A84
        MOVE.B  $C8C9.W,D0                      ; $004A8A
        ADDQ.B  #1,D0                           ; $004A8E
        MOVE.B  D0,$00A15122                    ; $004A90
        MOVE.W  #$0103,$C8A8.W                  ; $004A96
        MOVE.B  $C8A9.W,$00A15121               ; $004A9C
        MOVE.B  $C8A8.W,$00A15120               ; $004AA4
        MOVE.B  #$0000,$C80F.W                  ; $004AAC
        MOVE.W  #$0000,$C8BC.W                  ; $004AB2
        JSR     func_00D1D4                       ; $004AB8
        JSR     func_00D42C                       ; $004ABE
        LEA     $008BA220,A0                    ; $004AC4
        MOVE.W  $C8A0.W,D0                      ; $004ACA
        MOVEA.L $00(A0,D0.W),A2                 ; $004ACE
        JSR     $00284C(PC)                     ; $004AD2 [func_00284C]
        LEA     $008BAE38,A0                    ; $004AD6
        MOVE.W  $C8CC.W,D0                      ; $004ADC
        MOVEA.L $00(A0,D0.W),A2                 ; $004AE0
        JSR     $002862(PC)                     ; $004AE4 [func_002862]
        MOVE.W  #$0010,$00FF0008                ; $004AE8
        MOVE.W  #$0000,$C8AA.W                  ; $004AF0
        JSR     loc_0049AA(PC)                  ; $004AF6
        JSR     func_00CD92                       ; $004AFA
        MOVE.B  #$0000,$C314.W                  ; $004B00
        BTST    #0,$C818.W                      ; $004B06
        BEQ.S  loc_004B14                       ; $004B0C
        MOVE.B  #$0001,$C314.W                  ; $004B0E
loc_004B14:
        MOVEQ   #$00,D0                         ; $004B14
        JSR     func_00CC74                       ; $004B16
        JSR     $00C870(PC)                     ; $004B1C [func_00C870]
        JSR     $00C9B6(PC)                     ; $004B20
        TST.B  $FEA9.W                          ; $004B24
        BEQ.S  loc_004B2E                       ; $004B28
        JSR     $00CA4C(PC)                     ; $004B2A
loc_004B2E:
        BTST    #7,$FDA8.W                      ; $004B2E
        BEQ.S  loc_004B40                       ; $004B34
        MOVE.L  #$0403131C,$00FF69B4            ; $004B36
loc_004B40:
        JSR     $0088D054                       ; $004B40
        JSR     $0088CA9A                       ; $004B46
        MOVE.B  #$0005,$C310.W                  ; $004B4C
        JSR     $0088CC88                       ; $004B52
        MOVEQ   #$18,D0                         ; $004B58
        MOVEQ   #-$01,D1                        ; $004B5A
        TST.W  $C89C.W                          ; $004B5C
        BEQ.S  loc_004B64                       ; $004B60
        MOVEQ   #$00,D1                         ; $004B62
loc_004B64:
        JSR     $0088CDD2                       ; $004B64
        JSR     $0088CD4C                       ; $004B6A
        JSR     $00A80A(PC)                     ; $004B70
        JSR     $00A144(PC)                     ; $004B74 [func_00A144]
        LEA     $9000.W,A0                      ; $004B78
        JSR     $00A1FC(PC)                     ; $004B7C [func_00A1FC]
        JSR     $00C974(PC)                     ; $004B80
        JSR     $0088CF0C                       ; $004B84
        JSR     func_00CC06                       ; $004B8A
        JSR     $0088CFAE                       ; $004B90
        MOVE.W  #$0000,$C87E.W                  ; $004B96
        MOVE.W  #$C9A0,$C8C0.W                  ; $004B9C
        MOVE.B  #$0002,$C80A.W                  ; $004BA2
        BTST    #3,$C80E.W                      ; $004BA8
        BEQ.S  loc_004BB6                       ; $004BAE
        JSR     $0088D0F6                       ; $004BB0
loc_004BB6:
        JSR     loc_0058C8(PC)                  ; $004BB6
        JSR     loc_005908(PC)                  ; $004BBA
        JSR     loc_00593C(PC)                  ; $004BBE
        ANDI.B  #$00FC,$00A15181                ; $004BC2
        ORI.B  #$0001,$00A15181                 ; $004BCA
        MOVE.W  #$8083,$00A15100                ; $004BD2
        JSR     $00204A(PC)                     ; $004BDA [func_00204A]
        JSR     $0020C6(PC)                     ; $004BDE [func_0020C6]
        BSET    #6,$C875.W                      ; $004BE2
        MOVE.W  $C874.W,(A5)                    ; $004BE8
        JSR     loc_004998(PC)                  ; $004BEC
        MOVE.W  $C8A0.W,D0                      ; $004BF0
        LEA     $008BB1C4,A0                    ; $004BF4
        MOVE.L  $00(A0,D0.W),$C96C.W            ; $004BFA
        MOVE.B  #$0001,$C809.W                  ; $004C00
        BSET    #6,$C80E.W                      ; $004C06
        MOVE.B  #$0001,$C802.W                  ; $004C0C
        BTST    #7,$FDA8.W                      ; $004C12
        BEQ.S  loc_004C22                       ; $004C18
        MOVE.B  #$0001,$00FF60D4                ; $004C1A
loc_004C22:
        BTST    #0,$00A15123                    ; $004C22
        BEQ.S  loc_004C22                       ; $004C2A
        BCLR    #0,$00A15123                    ; $004C2C
        MOVE.W  #$0102,$C8A8.W                  ; $004C34
        BTST    #3,$C80E.W                      ; $004C3A
        BNE.S  loc_004C8A                       ; $004C40
        MOVE.W  $C8C8.W,D0                      ; $004C42
        MOVE.W  #$0000,$8790.W                  ; $004C46
        LEA     $006A(PC),A1                    ; $004C4C
        BTST    #0,$C80B.W                      ; $004C50
        BNE.S  loc_004C5E                       ; $004C56
        MOVE.B  $00(A1,D0.W),$C8A5.W            ; $004C58
loc_004C5E:
        JSR     $002080(PC)                     ; $004C5E [func_002080]
        JSR     loc_004998(PC)                  ; $004C62
        JSR     $0021EE(PC)                     ; $004C66
        MOVE.L  #$00884CBC,$00FF0002            ; $004C6A
        MOVE.L  #$00000000,$00FF5FF8            ; $004C74
        MOVE.L  #$00000000,$00FF5FFC            ; $004C7E
        RTS                                     ; $004C88
loc_004C8A:
        MOVE.B  #$009A,$C8A5.W                  ; $004C8A
        JSR     $002080(PC)                     ; $004C90 [func_002080]
        JSR     loc_004998(PC)                  ; $004C94
        MOVE.L  #$00885618,$00FF0002            ; $004C98
        MOVE.L  #$00000000,$00FF5FF8            ; $004CA2
        MOVE.L  #$00000000,$00FF5FFC            ; $004CAC
        RTS                                     ; $004CB6
        MOVE.L  -(A0),(A1)                      ; $004CB8
        MOVE.L  D0,-(A0)                        ; $004CBA
        MOVE.W  $C87E.W,D0                      ; $004CBC
        MOVEA.L $04(PC,D0.W),A1                 ; $004CC0
        JMP     (A1)                            ; $004CC4
        ORI.L  #$4CDA0088,A0                    ; $004CC6
        DC.W    $4D00                           ; $004CCC
        ORI.L  #$4D1A0088,A0                    ; $004CCE
        DC.W    $4D7A                           ; $004CD4
        ORI.L  #$573C4EBA,A0                    ; $004CD6
        ADDA.L  -(A6),A5                        ; $004CDC
        JSR     $0020D6(PC)                     ; $004CDE
        JSR     $00B09E(PC)                     ; $004CE2 [animation_update]
        JSR     $00B02C(PC)                     ; $004CE6
        JSR     $00B632(PC)                     ; $004CEA
        JSR     loc_0058C8(PC)                  ; $004CEE
        ADDQ.W  #4,$C87E.W                      ; $004CF2
        MOVE.W  #$0010,$00FF0008                ; $004CF6
        RTS                                     ; $004CFE
        JSR     $00210A(PC)                     ; $004D00
        JSR     $00B09E(PC)                     ; $004D04 [animation_update]
        JSR     loc_005908(PC)                  ; $004D08
        ADDQ.W  #4,$C87E.W                      ; $004D0C
        MOVE.W  #$0010,$00FF0008                ; $004D10
        RTS                                     ; $004D18
        JSR     $00212E(PC)                     ; $004D1A
        JSR     $00179E(PC)                     ; $004D1E [func_00179E]
        JSR     $00B09E(PC)                     ; $004D22 [animation_update]
        JSR     $00B144(PC)                     ; $004D26
        JSR     $00B504(PC)                     ; $004D2A
        JSR     $00B4DC(PC)                     ; $004D2E
        JSR     $00B522(PC)                     ; $004D32
        ADDQ.W  #1,$C8AA.W                      ; $004D36
        MOVEA.W $C8C0.W,A0                      ; $004D3A
        CMPA.W  #$EF00,A0                       ; $004D3E
        BEQ.W  loc_004D5E                       ; $004D42
        MOVE.B  $C971.W,D0                      ; $004D46
        ANDI.B  #$005C,D0                       ; $004D4A
        MOVE.B  $C973.W,D1                      ; $004D4E
        ANDI.B  #$0003,D1                       ; $004D52
        OR.B   D1,D0                            ; $004D56
        MOVE.B  D0,(A0)+                        ; $004D58
        MOVE.W  A0,$C8C0.W                      ; $004D5A
loc_004D5E:
        JSR     loc_00593C(PC)                  ; $004D5E
        JSR     $00B6DA(PC)                     ; $004D62 [sprite_update]
        JSR     $00B684(PC)                     ; $004D66 [object_update]
        ADDQ.W  #4,$C87E.W                      ; $004D6A
        MOVE.W  #$0054,$00FF0008                ; $004D6E
        JMP     loc_0056F8(PC)                  ; $004D76
        JSR     $00212E(PC)                     ; $004D7A
        JSR     $00179E(PC)                     ; $004D7E [func_00179E]
        JSR     $00B09E(PC)                     ; $004D82 [animation_update]
        JSR     $00B144(PC)                     ; $004D86
        ADDQ.B  #1,$C886.W                      ; $004D8A
        MOVE.W  #$0054,$00FF0008                ; $004D8E
        RTS                                     ; $004D96
        NOT    #$2700                           ; $004D98
        BCLR    #6,$C875.W                      ; $004D9C
        MOVE.W  $C874.W,(A5)                    ; $004DA2
        MOVE.W  #$0083,$00A15100                ; $004DA6
        ANDI.B  #$00FC,$00A15181                ; $004DAE
        JSR     $00270A(PC)                     ; $004DB6 [func_00270A]
        MOVE.B  #$0001,$C80D.W                  ; $004DBA
        MOVE.B  #$0000,$C80E.W                  ; $004DC0
        ORI.B  #$0010,$C80E.W                   ; $004DC6
        BCLR    #7,$FDA8.W                      ; $004DCC
        MOVEQ   #$00,D0                         ; $004DD2
        MOVEQ   #$00,D1                         ; $004DD4
        MOVE.B  $FEAB.W,D0                      ; $004DD6
        MOVE.B  $FEB3.W,D1                      ; $004DDA
        JSR     func_00D19C                       ; $004DDE
        MOVE.B  #$0004,$00A15122                ; $004DE4
        MOVE.W  #$0103,$C8A8.W                  ; $004DEC
        MOVE.B  $C8A9.W,$00A15121               ; $004DF2
        MOVE.B  $C8A8.W,$00A15120               ; $004DFA
        MOVE.B  #$0001,$C80F.W                  ; $004E02
        MOVE.W  #$0040,$C8BC.W                  ; $004E08
        JSR     func_00D1D4                       ; $004E0E
        JSR     func_00D42C                       ; $004E14
        LEA     $008BA220,A0                    ; $004E1A
        MOVE.W  $C8A0.W,D0                      ; $004E20
        MOVEA.L $00(A0,D0.W),A2                 ; $004E24
        JSR     $00284C(PC)                     ; $004E28 [func_00284C]
        LEA     $008BAE38,A0                    ; $004E2C
        MOVE.W  $C8CC.W,D0                      ; $004E32
        MOVEA.L $00(A0,D0.W),A2                 ; $004E36
        JSR     $002862(PC)                     ; $004E3A [func_002862]
        MOVE.W  #$0010,$00FF0008                ; $004E3E
        MOVE.W  #$0000,$C8AA.W                  ; $004E46
        JSR     loc_0049AA(PC)                  ; $004E4C
        JSR     $00CD92(PC)                     ; $004E50 [func_00CD92]
        MOVEQ   #$10,D0                         ; $004E54
        JSR     $00CC74(PC)                     ; $004E56 [func_00CC74]
        JSR     $00C870(PC)                     ; $004E5A [func_00C870]
        JSR     $00C9E0(PC)                     ; $004E5E
        TST.B  $FEAF.W                          ; $004E62
        BEQ.S  loc_004E6C                       ; $004E66
        JSR     $00CA66(PC)                     ; $004E68
loc_004E6C:
        TST.B  $FEB0.W                          ; $004E6C
        BEQ.S  loc_004E76                       ; $004E70
        JSR     $00CA80(PC)                     ; $004E72
loc_004E76:
        JSR     $0088D450                       ; $004E76
        JSR     $0088D08A                       ; $004E7C
        JSR     $00CB3E(PC)                     ; $004E82
        JSR     $00CC88(PC)                     ; $004E86
        LEA     $9F00.W,A0                      ; $004E8A
        JSR     $00CC92(PC)                     ; $004E8E
        MOVEQ   #$30,D0                         ; $004E92
        JSR     $0088CE02                       ; $004E94
        MOVE.B  $FEB0.W,$C30F.W                 ; $004E9A
        JSR     $00A144(PC)                     ; $004EA0 [func_00A144]
        LEA     $9F00.W,A0                      ; $004EA4
        JSR     $00A1FC(PC)                     ; $004EA8 [func_00A1FC]
        JSR     $00C8F2(PC)                     ; $004EAC
        JSR     $0088CFD6                       ; $004EB0
        JSR     $0088CE76                       ; $004EB6
        JSR     $0088CECC                       ; $004EBC
        MOVE.B  #$0000,$C314.W                  ; $004EC2
        BTST    #1,$C818.W                      ; $004EC8
        BEQ.S  loc_004ED6                       ; $004ECE
        MOVE.B  #$0001,$C314.W                  ; $004ED0
loc_004ED6:
        LEA     $C000.W,A2                      ; $004ED6
        LEA     $B800.W,A1                      ; $004EDA
        MOVEQ   #$1F,D7                         ; $004EDE
loc_004EE0:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A2)+   ; $004EE0
        MOVEM.L -(A1),D4/A1/A2/A3/A4/A5/A6/A7   ; $004EE4
        DBRA    D7,loc_004EE0                   ; $004EE8
        MOVE.B  #$0000,$C314.W                  ; $004EEC
        BTST    #0,$C818.W                      ; $004EF2
        BEQ.S  loc_004F00                       ; $004EF8
        MOVE.B  #$0001,$C314.W                  ; $004EFA
loc_004F00:
        MOVE.B  $FEAF.W,$C30F.W                 ; $004F00
        JSR     $00A144(PC)                     ; $004F06 [func_00A144]
        LEA     $9000.W,A0                      ; $004F0A
        JSR     $00A1FC(PC)                     ; $004F0E [func_00A1FC]
        JSR     $0088CEC2                       ; $004F12
        MOVE.W  #$0000,$C87E.W                  ; $004F18
        BSET    #4,$C80E.W                      ; $004F1E
        JSR     $00640E(PC)                     ; $004F24
        JSR     $006496(PC)                     ; $004F28
        ANDI.B  #$00FC,$00A15181                ; $004F2C
        ORI.B  #$0001,$00A15181                 ; $004F34
        MOVE.W  #$8083,$00A15100                ; $004F3C
        JSR     $00204A(PC)                     ; $004F44 [func_00204A]
        JSR     $0020C6(PC)                     ; $004F48 [func_0020C6]
        BSET    #6,$C875.W                      ; $004F4C
        MOVE.W  $C874.W,(A5)                    ; $004F52
        JSR     func_004998                       ; $004F56
        MOVE.W  $C8C8.W,D0                      ; $004F5C
        MOVE.W  #$0000,$8790.W                  ; $004F60
        LEA     -$02B0(PC),A1                   ; $004F66
        BTST    #0,$C80B.W                      ; $004F6A
        BNE.S  loc_004F78                       ; $004F70
        MOVE.B  $00(A1,D0.W),$C8A5.W            ; $004F72
loc_004F78:
        JSR     func_002080                       ; $004F78
        JSR     func_004998                       ; $004F7E
        MOVE.W  $C8C8.W,D0                      ; $004F84
        MOVE.W  #$0000,$8760.W                  ; $004F88
        LEA     $0090(PC),A1                    ; $004F8E
        BTST    #0,$C80B.W                      ; $004F92
        BNE.S  loc_004FA0                       ; $004F98
        MOVE.B  $00(A1,D0.W),$C8A5.W            ; $004F9A
loc_004FA0:
        JSR     func_002080                       ; $004FA0
        JSR     func_004998                       ; $004FA6
        JSR     $0021EE(PC)                     ; $004FAC
        MOVE.W  $C8A0.W,D0                      ; $004FB0
        LEA     $008BB1C4,A0                    ; $004FB4
        MOVE.L  $00(A0,D0.W),$C96C.W            ; $004FBA
        MOVE.B  #$0001,$C809.W                  ; $004FC0
        MOVE.B  #$0002,$C80A.W                  ; $004FC6
        BSET    #6,$C80E.W                      ; $004FCC
        MOVE.B  #$0001,$C802.W                  ; $004FD2
        BTST    #7,$FDA8.W                      ; $004FD8
        BEQ.S  loc_004FE8                       ; $004FDE
        MOVE.B  #$0001,$00FF60D4                ; $004FE0
loc_004FE8:
        BTST    #0,$00A15123                    ; $004FE8
        BEQ.S  loc_004FE8                       ; $004FF0
        BCLR    #0,$00A15123                    ; $004FF2
        MOVE.W  #$0104,$C8A8.W                  ; $004FFA
        MOVE.L  #$00885024,$00FF0002            ; $005000
        MOVE.L  #$00000000,$00FF5FF8            ; $00500A
        MOVE.L  #$00000000,$00FF5FFC            ; $005014
        RTS                                     ; $00501E
        MOVE.L  -(A3),$00(A2,A2.W)              ; $005020
        MOVE.W  $C87E.W,D0                      ; $005024
        MOVEA.L $04(PC,D0.W),A1                 ; $005028
        JMP     (A1)                            ; $00502C
        ORI.L  #$50420088,A0                    ; $00502E
        ADDQ.W  #8,-$78(A0,D0.W)                ; $005034
        ADDQ.L  #8,(A6)+                        ; $005038
        ORI.L  #$50DE0088,A0                    ; $00503A
        SUBQ.B  #3,#$4EBA                       ; $005040
        ADD.W  <EA:3E>,D4                       ; $005044
        JSR     $002154(PC)                     ; $005046
        JSR     $00B09E(PC)                     ; $00504A [animation_update]
        JSR     $00B094(PC)                     ; $00504E
        JSR     $00B0DE(PC)                     ; $005052
        JSR     $00B03C(PC)                     ; $005056
        JSR     $00B632(PC)                     ; $00505A
        JSR     $00B646(PC)                     ; $00505E
        ADDQ.W  #4,$C87E.W                      ; $005062
        MOVE.W  #$0014,$00FF0008                ; $005066
        RTS                                     ; $00506E
        JSR     $002180(PC)                     ; $005070
        JSR     $00179E(PC)                     ; $005074 [func_00179E]
        JSR     $00B09E(PC)                     ; $005078 [animation_update]
        JSR     $00B094(PC)                     ; $00507C
        JSR     $00B0DE(PC)                     ; $005080
        JSR     $00B128(PC)                     ; $005084
        JSR     $00B136(PC)                     ; $005088
        JSR     $00640E(PC)                     ; $00508C
        ADDQ.W  #4,$C87E.W                      ; $005090
        MOVE.W  #$001C,$00FF0008                ; $005094
        RTS                                     ; $00509C
        JSR     $0021A4(PC)                     ; $00509E
        JSR     $006496(PC)                     ; $0050A2
        JSR     $00B09E(PC)                     ; $0050A6 [animation_update]
        JSR     $00B094(PC)                     ; $0050AA
        JSR     $00B0DE(PC)                     ; $0050AE
        JSR     $00B504(PC)                     ; $0050B2
        JSR     $00B4F8(PC)                     ; $0050B6
        JSR     $00B55A(PC)                     ; $0050BA
        JSR     $00B590(PC)                     ; $0050BE
        ADDQ.W  #1,$C8AA.W                      ; $0050C2
        JSR     $00B6DA(PC)                     ; $0050C6 [sprite_update]
        JSR     $00B684(PC)                     ; $0050CA [object_update]
        ADDQ.W  #4,$C87E.W                      ; $0050CE
        MOVE.W  #$0054,$00FF0008                ; $0050D2
        JMP     loc_0056F8(PC)                  ; $0050DA
        JSR     $0021A4(PC)                     ; $0050DE
        JSR     $00179E(PC)                     ; $0050E2 [func_00179E]
        JSR     $00B09E(PC)                     ; $0050E6 [animation_update]
        JSR     $00B094(PC)                     ; $0050EA
        JSR     $00B0DE(PC)                     ; $0050EE
        ADDQ.B  #1,$C886.W                      ; $0050F2
        MOVE.W  #$0054,$00FF0008                ; $0050F6
        RTS                                     ; $0050FE
        NOT    #$2700                           ; $005100
        BCLR    #6,$C875.W                      ; $005104
        MOVE.W  $C874.W,(A5)                    ; $00510A
        MOVE.W  #$0083,$00A15100                ; $00510E
        ANDI.B  #$00FC,$00A15181                ; $005116
        JSR     $00270A(PC)                     ; $00511E [func_00270A]
        MOVE.B  #$0001,$C80D.W                  ; $005122
        MOVE.B  #$0000,$C80E.W                  ; $005128
        ORI.B  #$0020,$C80E.W                   ; $00512E
        BCLR    #7,$FDA8.W                      ; $005134
        MOVEQ   #$00,D0                         ; $00513A
        MOVEQ   #$00,D1                         ; $00513C
        MOVE.B  $FEA7.W,D0                      ; $00513E
        MOVE.B  $FEB2.W,D1                      ; $005142
        JSR     func_00D19C                       ; $005146
        MOVE.B  $C8C9.W,D0                      ; $00514C
        ADDQ.B  #1,D0                           ; $005150
        MOVE.B  D0,$00A15122                    ; $005152
        MOVE.W  #$0103,$C8A8.W                  ; $005158
        MOVE.B  $C8A9.W,$00A15121               ; $00515E
        MOVE.B  $C8A8.W,$00A15120               ; $005166
        MOVE.B  #$0000,$C80F.W                  ; $00516E
        MOVE.W  #$0000,$C8BC.W                  ; $005174
        JSR     func_00D1D4                       ; $00517A
        JSR     func_00D42C                       ; $005180
        LEA     $008BA220,A0                    ; $005186
        MOVE.W  $C8A0.W,D0                      ; $00518C
        MOVEA.L $00(A0,D0.W),A2                 ; $005190
        JSR     $00284C(PC)                     ; $005194 [func_00284C]
        LEA     $008BAE38,A0                    ; $005198
        MOVE.W  $C8CC.W,D0                      ; $00519E
        MOVEA.L $00(A0,D0.W),A2                 ; $0051A2
        JSR     $002862(PC)                     ; $0051A6 [func_002862]
        MOVE.W  #$0010,$00FF0008                ; $0051AA
        MOVE.W  #$0000,$C8AA.W                  ; $0051B2
        JSR     loc_0049AA(PC)                  ; $0051B8
        JSR     $00CD92(PC)                     ; $0051BC [func_00CD92]
        MOVE.B  #$0000,$C314.W                  ; $0051C0
        BTST    #0,$C818.W                      ; $0051C6
        BEQ.S  loc_0051D4                       ; $0051CC
        MOVE.B  #$0001,$C314.W                  ; $0051CE
loc_0051D4:
        MOVEQ   #$10,D0                         ; $0051D4
        JSR     $00CC74(PC)                     ; $0051D6 [func_00CC74]
        JSR     $00C870(PC)                     ; $0051DA [func_00C870]
        JSR     $00CA00(PC)                     ; $0051DE
        JSR     $00D0CC(PC)                     ; $0051E2
        TST.B  $FEAA.W                          ; $0051E6
        BEQ.S  loc_0051F0                       ; $0051EA
        JSR     $00CA4C(PC)                     ; $0051EC
loc_0051F0:
        JSR     $0088D450                       ; $0051F0
        JSR     $0088D054                       ; $0051F6
        JSR     $00CAA0(PC)                     ; $0051FC
        MOVE.B  $C81A.W,$C310.W                 ; $005200
        JSR     $00CC88(PC)                     ; $005206
        MOVEQ   #$18,D0                         ; $00520A
        MOVEQ   #$00,D1                         ; $00520C
        JSR     $00CE22(PC)                     ; $00520E [func_00CE22]
        MOVE.B  $FEAA.W,$C30F.W                 ; $005212
        JSR     $00A144(PC)                     ; $005218 [func_00A144]
        LEA     $9000.W,A0                      ; $00521C
        JSR     $00A1FC(PC)                     ; $005220 [func_00A1FC]
        JSR     $00C974(PC)                     ; $005224
        JSR     $00CFAE(PC)                     ; $005228
        MOVE.B  #$0000,$C819.W                  ; $00522C
        MOVE.W  #$0000,$C8BE.W                  ; $005232
        MOVE.W  #$0000,$C87E.W                  ; $005238
        JSR     $006840(PC)                     ; $00523E
        ANDI.B  #$00FC,$00A15181                ; $005242
        ORI.B  #$0001,$00A15181                 ; $00524A
        MOVE.W  #$8083,$00A15100                ; $005252
        JSR     $00204A(PC)                     ; $00525A [func_00204A]
        JSR     $0020C6(PC)                     ; $00525E [func_0020C6]
        BSET    #6,$C875.W                      ; $005262
        MOVE.W  $C874.W,(A5)                    ; $005268
        JSR     func_004998                       ; $00526C
        MOVE.W  $C8C8.W,D0                      ; $005272
        LEA     -$05C0(PC),A1                   ; $005276
        BTST    #0,$C80B.W                      ; $00527A
        BNE.S  loc_005288                       ; $005280
        MOVE.B  $00(A1,D0.W),$C8A5.W            ; $005282
loc_005288:
        JSR     func_002080                       ; $005288
        JSR     func_004998                       ; $00528E
        JSR     $0021EE(PC)                     ; $005294
        MOVE.W  $C8A0.W,D0                      ; $005298
        LEA     $008BB1C4,A0                    ; $00529C
        MOVE.L  $00(A0,D0.W),$C96C.W            ; $0052A2
        MOVE.B  #$0001,$C809.W                  ; $0052A8
        MOVE.B  #$0002,$C80A.W                  ; $0052AE
        BSET    #6,$C80E.W                      ; $0052B4
        MOVE.B  #$0001,$C802.W                  ; $0052BA
        BTST    #7,$FDA8.W                      ; $0052C0
        BEQ.S  loc_0052D0                       ; $0052C6
        MOVE.B  #$0001,$00FF60D4                ; $0052C8
loc_0052D0:
        BTST    #0,$00A15123                    ; $0052D0
        BEQ.S  loc_0052D0                       ; $0052D8
        BCLR    #0,$00A15123                    ; $0052DA
        MOVE.W  #$0102,$C8A8.W                  ; $0052E2
        MOVE.L  #$00885308,$00FF0002            ; $0052E8
        MOVE.L  #$00000000,$00FF5FF8            ; $0052F2
        MOVE.L  #$00000000,$00FF5FFC            ; $0052FC
        RTS                                     ; $005306
        MOVE.W  $C87E.W,D0                      ; $005308
        MOVEA.L $04(PC,D0.W),A1                 ; $00530C
        JMP     (A1)                            ; $005310
        ORI.L  #$53260088,A0                    ; $005312
        SUBQ.W  #1,A0                           ; $005318
        ORI.L  #$535E0088,A0                    ; $00531A
        SUBQ.L  #1,(A6)                         ; $005320
        ORI.L  #$573C4EBA,A0                    ; $005322
        ADD.L  D2,(A2)+                         ; $005328
        JSR     $0020D6(PC)                     ; $00532A
        JSR     $00B09E(PC)                     ; $00532E [animation_update]
        JSR     $00B02C(PC)                     ; $005332
        JSR     $00B632(PC)                     ; $005336
        ADDQ.W  #4,$C87E.W                      ; $00533A
        MOVE.W  #$0010,$00FF0008                ; $00533E
        RTS                                     ; $005346
        JSR     $00210A(PC)                     ; $005348
        JSR     $00B09E(PC)                     ; $00534C [animation_update]
        ADDQ.W  #4,$C87E.W                      ; $005350
        MOVE.W  #$0010,$00FF0008                ; $005354
        RTS                                     ; $00535C
        JSR     $00212E(PC)                     ; $00535E
        JSR     $00179E(PC)                     ; $005362 [func_00179E]
        JSR     $00B09E(PC)                     ; $005366 [animation_update]
        JSR     $00B11A(PC)                     ; $00536A
        JSR     $00B504(PC)                     ; $00536E
        JSR     $00B5A4(PC)                     ; $005372
        ADDQ.W  #1,$C8AA.W                      ; $005376
        JSR     $006840(PC)                     ; $00537A
        JSR     $00B6DA(PC)                     ; $00537E [sprite_update]
        JSR     $00B684(PC)                     ; $005382 [object_update]
        ADDQ.W  #4,$C87E.W                      ; $005386
        MOVE.W  #$0054,$00FF0008                ; $00538A
        JMP     loc_0056F8(PC)                  ; $005392
        JSR     $00212E(PC)                     ; $005396
        JSR     $00179E(PC)                     ; $00539A [func_00179E]
        JSR     $00B09E(PC)                     ; $00539E [animation_update]
        ADDQ.B  #1,$C886.W                      ; $0053A2
        MOVE.W  #$0054,$00FF0008                ; $0053A6
        RTS                                     ; $0053AE
        NOT    #$2700                           ; $0053B0
        BCLR    #6,$C875.W                      ; $0053B4
        MOVE.W  $C874.W,(A5)                    ; $0053BA
        MOVE.W  #$0083,$00A15100                ; $0053BE
        ANDI.B  #$00FC,$00A15181                ; $0053C6
        JSR     $00270A(PC)                     ; $0053CE [func_00270A]
        MOVEQ   #$07,D0                         ; $0053D2
        JSR     func_0014BE                       ; $0053D4
        MOVEQ   #$00,D1                         ; $0053DA
        MOVE.B  $FEB6.W,D0                      ; $0053DC
        CMPI.B  #$0005,D0                       ; $0053E0
        BCS.S  loc_0053E8                       ; $0053E4
        MOVEQ   #$00,D0                         ; $0053E6
loc_0053E8:
        MOVE.B  $FEB5.W,D1                      ; $0053E8
        MOVE.B  #$0001,$C80D.W                  ; $0053EC
        JSR     $00D19C(PC)                     ; $0053F2 [func_00D19C]
        MOVE.B  $C8C9.W,D0                      ; $0053F6
        ADDQ.B  #1,D0                           ; $0053FA
        MOVE.B  D0,$00A15122                    ; $0053FC
        MOVE.W  #$0103,$C8A8.W                  ; $005402
        MOVE.B  $C8A9.W,$00A15121               ; $005408
        MOVE.B  $C8A8.W,$00A15120               ; $005410
        MOVE.B  #$0000,$C80F.W                  ; $005418
        MOVE.W  #$0000,$C8BC.W                  ; $00541E
        JSR     func_00D1D4                       ; $005424
        JSR     func_00D42C                       ; $00542A
        LEA     $008BA220,A0                    ; $005430
        MOVE.W  $C8A0.W,D0                      ; $005436
        MOVEA.L $00(A0,D0.W),A2                 ; $00543A
        JSR     $00284C(PC)                     ; $00543E [func_00284C]
        LEA     $008BAE38,A0                    ; $005442
        MOVE.W  $C8CC.W,D0                      ; $005448
        MOVEA.L $00(A0,D0.W),A2                 ; $00544C
        JSR     $002862(PC)                     ; $005450 [func_002862]
        MOVE.W  #$0010,$00FF0008                ; $005454
        MOVE.W  #$0000,$C8AA.W                  ; $00545C
        MOVE.W  #$0000,$C080.W                  ; $005462
        JSR     loc_0049AA(PC)                  ; $005468
        JSR     $00CD92(PC)                     ; $00546C [func_00CD92]
        MOVE.B  #$0000,$C314.W                  ; $005470
        BTST    #0,$C818.W                      ; $005476
        BEQ.S  loc_005484                       ; $00547C
        MOVE.B  #$0001,$C314.W                  ; $00547E
loc_005484:
        MOVEQ   #$00,D0                         ; $005484
        JSR     $00CC74(PC)                     ; $005486 [func_00CC74]
        JSR     $00C870(PC)                     ; $00548A [func_00C870]
        JSR     $00CA10(PC)                     ; $00548E
        JSR     $00CC88(PC)                     ; $005492
        JSR     $00BA5E(PC)                     ; $005496
        MOVEQ   #$00,D0                         ; $00549A
        MOVEQ   #$00,D1                         ; $00549C
        JSR     $00CDD2(PC)                     ; $00549E
        JSR     $00CD4C(PC)                     ; $0054A2
        JSR     $00A7E2(PC)                     ; $0054A6
        JSR     $00A144(PC)                     ; $0054AA [func_00A144]
        LEA     $9000.W,A0                      ; $0054AE
        JSR     $00A1FC(PC)                     ; $0054B2 [func_00A1FC]
        JSR     $00C974(PC)                     ; $0054B6
        JSR     $00CF0C(PC)                     ; $0054BA
        JSR     $00CC06(PC)                     ; $0054BE [func_00CC06]
        JSR     $00CFAE(PC)                     ; $0054C2
        JSR     $00CC72(PC)                     ; $0054C6
        MOVE.W  #$0090,$00FF60CC                ; $0054CA
        MOVE.W  #$0000,$C87E.W                  ; $0054D2
        JSR     loc_0058C8(PC)                  ; $0054D8
        JSR     loc_005908(PC)                  ; $0054DC
        JSR     loc_00593C(PC)                  ; $0054E0
        ANDI.B  #$00FC,$00A15181                ; $0054E4
        ORI.B  #$0001,$00A15181                 ; $0054EC
        MOVE.W  #$8083,$00A15100                ; $0054F4
        JSR     $00204A(PC)                     ; $0054FC [func_00204A]
        JSR     $0020C6(PC)                     ; $005500 [func_0020C6]
        BSET    #6,$C875.W                      ; $005504
        MOVE.W  $C874.W,(A5)                    ; $00550A
        JSR     func_004998                       ; $00550E
        MOVE.W  $C8A0.W,D0                      ; $005514
        LEA     $008BB1C4,A0                    ; $005518
        MOVE.L  $00(A0,D0.W),$C96C.W            ; $00551E
        MOVE.B  #$0001,$C809.W                  ; $005524
        MOVE.B  #$0002,$C80A.W                  ; $00552A
        BSET    #6,$C80E.W                      ; $005530
        MOVE.B  #$0001,$C802.W                  ; $005536
loc_00553C:
        BTST    #0,$00A15123                    ; $00553C
        BEQ.S  loc_00553C                       ; $005544
        BCLR    #0,$00A15123                    ; $005546
        MOVE.B  #$009B,$C8A5.W                  ; $00554E
        JSR     func_002080                       ; $005554
        JSR     func_004998                       ; $00555A
        MOVE.W  #$0105,$C8A8.W                  ; $005560
        MOVE.L  #$00885586,$00FF0002            ; $005566
        MOVE.L  #$00000000,$00FF5FF8            ; $005570
        MOVE.L  #$00000000,$00FF5FFC            ; $00557A
        RTS                                     ; $005584
        MOVE.W  $C87E.W,D0                      ; $005586
        MOVEA.L $04(PC,D0.W),A1                 ; $00558A
        JMP     (A1)                            ; $00558E
        ORI.L  #$55A00088,A0                    ; $005590
        SUBQ.L  #2,$0088(PC)                    ; $005596
        SCS     (A0)                            ; $00559A
        ORI.L  #$55FE4EBA,A0                    ; $00559C
        ADD.B  D1,-(A0)                         ; $0055A2
        JSR     $0021CA(PC)                     ; $0055A4 [func_0021CA]
        JSR     loc_0058C8(PC)                  ; $0055A8
        ADDQ.W  #4,$C87E.W                      ; $0055AC
        MOVE.W  #$0010,$00FF0008                ; $0055B0
        RTS                                     ; $0055B8
        JSR     $0021CA(PC)                     ; $0055BA [func_0021CA]
        JSR     loc_005908(PC)                  ; $0055BE
        ADDQ.W  #4,$C87E.W                      ; $0055C2
        MOVE.W  #$0010,$00FF0008                ; $0055C6
        RTS                                     ; $0055CE
        JSR     $0021CA(PC)                     ; $0055D0 [func_0021CA]
        JSR     $00179E(PC)                     ; $0055D4 [func_00179E]
        ADDQ.W  #1,$C8AA.W                      ; $0055D8
        JSR     loc_00593C(PC)                  ; $0055DC
        JSR     $00BC40(PC)                     ; $0055E0
        JSR     $00BAD4(PC)                     ; $0055E4
        JSR     $00B6DA(PC)                     ; $0055E8 [sprite_update]
        JSR     $00B684(PC)                     ; $0055EC [object_update]
        ADDQ.W  #4,$C87E.W                      ; $0055F0
        MOVE.W  #$0054,$00FF0008                ; $0055F4
        RTS                                     ; $0055FC
        JSR     $0021CA(PC)                     ; $0055FE [func_0021CA]
        JSR     $00179E(PC)                     ; $005602 [func_00179E]
        JSR     $00BAD4(PC)                     ; $005606
        ADDQ.B  #1,$C886.W                      ; $00560A
        MOVE.W  #$0054,$00FF0008                ; $00560E
        RTS                                     ; $005616
        MOVE.W  $C87E.W,D0                      ; $005618
        MOVEA.L $04(PC,D0.W),A1                 ; $00561C
        JMP     (A1)                            ; $005620
        ORI.L  #$56360088,A0                    ; $005622
        ADDQ.W  #3,(A0)+                        ; $005628
        ORI.L  #$56760088,A0                    ; $00562A
        DBNE    D6,loc_0056BA                   ; $005630
        SUBQ.B  #3,#$4EBA                       ; $005634
        ADD.L  A2,D1                            ; $005638
        JSR     $0021CA(PC)                     ; $00563A [func_0021CA]
        JSR     $0088BE(PC)                     ; $00563E
        JSR     loc_0058C8(PC)                  ; $005642
        ADDQ.B  #1,$C886.W                      ; $005646
        ADDQ.W  #4,$C87E.W                      ; $00564A
        MOVE.W  #$0010,$00FF0008                ; $00564E
        RTS                                     ; $005656
        JSR     $0021CA(PC)                     ; $005658 [func_0021CA]
        JSR     $00B02C(PC)                     ; $00565C
        JSR     $00B632(PC)                     ; $005660
        JSR     loc_005908(PC)                  ; $005664
        ADDQ.W  #4,$C87E.W                      ; $005668
        MOVE.W  #$0010,$00FF0008                ; $00566C
        RTS                                     ; $005674
        JSR     $0021CA(PC)                     ; $005676 [func_0021CA]
        JSR     $00179E(PC)                     ; $00567A [func_00179E]
        JSR     $00B504(PC)                     ; $00567E
        JSR     $00B522(PC)                     ; $005682
        ADDQ.W  #1,$C8AA.W                      ; $005686
        MOVE.L  #$FFFF0000,$C970.W              ; $00568A
        MOVEA.W $C8C0.W,A0                      ; $005692
        MOVE.B  (A0)+,D0                        ; $005696
        MOVE.B  D0,D1                           ; $005698
        ANDI.B  #$005C,D0                       ; $00569A
        MOVE.B  D0,$C971.W                      ; $00569E
        ANDI.B  #$0003,D1                       ; $0056A2
        MOVE.B  D1,$C973.W                      ; $0056A6
        MOVE.W  A0,$C8C0.W                      ; $0056AA
        JSR     $00B5CA(PC)                     ; $0056AE
        JSR     loc_00593C(PC)                  ; $0056B2
        JSR     $00B6DA(PC)                     ; $0056B6 [sprite_update]
loc_0056BA:
        JSR     $00B684(PC)                     ; $0056BA [object_update]
        ADDQ.W  #4,$C87E.W                      ; $0056BE
        MOVE.W  #$0054,$00FF0008                ; $0056C2
        JMP     loc_0056F8(PC)                  ; $0056CA
        JSR     $0021CA(PC)                     ; $0056CE [func_0021CA]
        JSR     $00179E(PC)                     ; $0056D2 [func_00179E]
        ADDQ.B  #1,$C886.W                      ; $0056D6
        MOVE.W  #$0054,$00FF0008                ; $0056DA
        RTS                                     ; $0056E2
        BCLR    #7,$FDA8.W                      ; $0056E4
        JMP     $00D48A(PC)                     ; $0056EA
        BSET    #7,$FDA8.W                      ; $0056EE
        JMP     $00D48A(PC)                     ; $0056F4
loc_0056F8:
        MOVE.B  $C86D.W,D0                      ; $0056F8
        BTST    #4,$C80E.W                      ; $0056FC
        BEQ.S  loc_005708                       ; $005702
        OR.B   $C86F.W,D0                       ; $005704
loc_005708:
        BTST    #7,D0                           ; $005708
        BEQ.S  loc_00573A                       ; $00570C
        TST.B  $C800.W                          ; $00570E
        BNE.S  loc_00573A                       ; $005712
        MOVE.B  #$0001,$00FF69F0                ; $005714
        JSR     loc_0049AA(PC)                  ; $00571C
        MOVE.B  #$0000,$A510.W                  ; $005720
        MOVE.W  #$0C00,$C8C4.W                  ; $005726
        MOVE.W  #$0010,$C87E.W                  ; $00572C
        MOVE.W  #$0044,$00FF0008                ; $005732
loc_00573A:
        RTS                                     ; $00573A
        JSR     $0021CA(PC)                     ; $00573C [func_0021CA]
        ADDQ.B  #1,$A510.W                      ; $005740
        MOVEQ   #$00,D0                         ; $005744
        MOVE.B  $C8C4.W,D0                      ; $005746
        MOVEA.L $04(PC,D0.W),A1                 ; $00574A
        JMP     (A1)                            ; $00574E
        ORI.L  #$57600088,A0                    ; $005750
        SUBQ.W  #3,-$78(A2,D0.W)                ; $005756
        SUBQ.L  #3,D0                           ; $00575A
        ORI.L  #$57BC4EBA,A0                    ; $00575C
        ADD.W  D0,-(A0)                         ; $005762
        ADDQ.B  #4,$C8C4.W                      ; $005764
        MOVE.W  #$0020,$00FF0008                ; $005768
        RTS                                     ; $005770
        ADDQ.B  #4,$C8C4.W                      ; $005772
        MOVE.W  #$0020,$00FF0008                ; $005776
        RTS                                     ; $00577E
        JSR     $00179E(PC)                     ; $005780 [func_00179E]
        ADDQ.B  #4,$C8C4.W                      ; $005784
        MOVE.W  #$0044,$00FF0008                ; $005788
        MOVEQ   #$00,D0                         ; $005790
        MOVE.B  $C8C5.W,D0                      ; $005792
        MOVEA.L $0C(PC,D0.W),A1                 ; $005796
        JSR     (A1)                            ; $00579A
        JSR     $00B6DA(PC)                     ; $00579C [sprite_update]
        JMP     $00B684(PC)                     ; $0057A0 [object_update]
        ORI.L  #$57CA0088,A0                    ; $0057A4
        SEQ     (A0)                            ; $0057AA
        ORI.L  #$57D80088,A0                    ; $0057AC
        ADDQ.W  #4,A2                           ; $0057B2
        ORI.L  #$58660088,A0                    ; $0057B4
        ADDQ.L  #4,$38(A4,D5.W)                 ; $0057BA
        AND.L  D6,D4                            ; $0057BE
        MOVE.W  #$0044,$00FF0008                ; $0057C0
        RTS                                     ; $0057C8
        ADDQ.B  #4,$C8C5.W                      ; $0057CA
        RTS                                     ; $0057CE
        ADDQ.B  #4,$C8C5.W                      ; $0057D0
        JMP     $00246C(PC)                     ; $0057D4
        MOVEQ   #$00,D0                         ; $0057D8
        BTST    #5,$A510.W                      ; $0057DA
        BNE.S  loc_0057E6                       ; $0057E0
        MOVE.W  #$0001,D0                       ; $0057E2
loc_0057E6:
        MOVE.B  D0,$00FF69F0                    ; $0057E6
        MOVE.B  $C86C.W,D0                      ; $0057EC
        BTST    #4,$C80E.W                      ; $0057F0
        BEQ.S  loc_0057FC                       ; $0057F6
        OR.B   $C86E.W,D0                       ; $0057F8
loc_0057FC:
        CMPI.B  #$0070,D0                       ; $0057FC
        BEQ.S  loc_005822                       ; $005800
        MOVE.B  $C86D.W,D0                      ; $005802
        BTST    #4,$C80E.W                      ; $005806
        BEQ.S  loc_005812                       ; $00580C
        OR.B   $C86F.W,D0                       ; $00580E
loc_005812:
        BTST    #7,D0                           ; $005812
        BNE.S  loc_00581A                       ; $005816
        RTS                                     ; $005818
loc_00581A:
        MOVE.B  #$0014,$C8C5.W                  ; $00581A
        RTS                                     ; $005820
loc_005822:
        JSR     $002474(PC)                     ; $005822
        MOVE.B  #$0001,$C809.W                  ; $005826
        MOVE.B  #$0001,$C80A.W                  ; $00582C
        BSET    #7,$C80E.W                      ; $005832
        MOVE.B  #$0001,$C802.W                  ; $005838
        MOVE.B  #$00F3,$C822.W                  ; $00583E
        ADDQ.B  #4,$C8C5.W                      ; $005844
        RTS                                     ; $005848
        BTST    #7,$C80E.W                      ; $00584A
        BNE.S  loc_005864                       ; $005850
        MOVE.W  #$8B00,(A5)                     ; $005852
        MOVEQ   #$00,D0                         ; $005856
        MOVE.B  D0,$C304.W                      ; $005858
        MOVE.B  D0,$C30C.W                      ; $00585C
        ADDQ.B  #4,$C8C5.W                      ; $005860
loc_005864:
        RTS                                     ; $005864
        JSR     $00B4CA(PC)                     ; $005866
        MOVE.L  $00FF0002,D0                    ; $00586A
        MOVEQ   #-$04,D1                        ; $005870
        MOVEQ   #$03,D7                         ; $005872
        LEA     $001E(PC),A1                    ; $005874
loc_005878:
        ADDQ.W  #4,D1                           ; $005878
        CMP.L  (A1)+,D0                         ; $00587A
        DBEQ    D7,loc_005878                   ; $00587C
        MOVE.L  $22(PC,D1.W),$00FF0002          ; $005880
        MOVE.W  #$0020,$00FF0008                ; $005888
        JMP     $002890(PC)                     ; $005890 [func_002890]
        ORI.L  #$56180088,A0                    ; $005894
        SUBQ.B  #1,A0                           ; $00589A
        ORI.L  #$50240088,A0                    ; $00589C
        MOVEM.W D0/D3/D7,#$09AE                 ; $0058A2
        ORI.L  #$FB980088,A0                    ; $0058A8
        MOVE.W  (A0)+,-$78(A5,D0.W)             ; $0058AE
        MOVE.W  (A0)+,-$04(A5,D1.W)             ; $0058B2
        ORI.B  #$00FF,D0                        ; $0058B6
        BVS.S  loc_0058AC                       ; $0058BA
        JSR     loc_0049AA(PC)                  ; $0058BC
        ADDQ.B  #4,$C8C5.W                      ; $0058C0
        JMP     $002474(PC)                     ; $0058C4
loc_0058C8:
        JSR     $006B8A(PC)                     ; $0058C8
        LEA     $A000.W,A4                      ; $0058CC
        MOVE.W  $C26C.W,D0                      ; $0058D0
        BTST    #7,$C81C.W                      ; $0058D4
        BNE.S  loc_0058E2                       ; $0058DA
        TST.W  $C89C.W                          ; $0058DC
        BEQ.S  loc_0058EA                       ; $0058E0
loc_0058E2:
        ANDI.W  #$0138,D0                       ; $0058E2
        BEQ.S  loc_0058F0                       ; $0058E6
loc_0058E8:
        RTS                                     ; $0058E8
loc_0058EA:
        ANDI.W  #$0130,D0                       ; $0058EA
        BNE.S  loc_0058E8                       ; $0058EE
loc_0058F0:
        MOVE.B  #$0000,$00FF5FFE                ; $0058F0
        LEA     $9100.W,A0                      ; $0058F8
        MOVEQ   #$05,D7                         ; $0058FC
loc_0058FE:
        JSR     loc_0059EC(PC)                  ; $0058FE
        DBRA    D7,loc_0058FE                   ; $005902
        RTS                                     ; $005906
loc_005908:
        LEA     $A000.W,A4                      ; $005908
        MOVE.W  $C26C.W,D0                      ; $00590C
        BTST    #7,$C81C.W                      ; $005910
        BNE.S  loc_00591E                       ; $005916
        TST.W  $C89C.W                          ; $005918
        BEQ.S  loc_005926                       ; $00591C
loc_00591E:
        ANDI.W  #$0138,D0                       ; $00591E
        BEQ.S  loc_00592C                       ; $005922
loc_005924:
        RTS                                     ; $005924
loc_005926:
        ANDI.W  #$0130,D0                       ; $005926
        BNE.S  loc_005924                       ; $00592A
loc_00592C:
        LEA     $9700.W,A0                      ; $00592C
        MOVEQ   #$07,D7                         ; $005930
loc_005932:
        JSR     loc_0059EC(PC)                  ; $005932
        DBRA    D7,loc_005932                   ; $005936
        RTS                                     ; $00593A
loc_00593C:
        LEA     $A000.W,A4                      ; $00593C
        MOVE.W  $C26C.W,D0                      ; $005940
        BTST    #7,$C81C.W                      ; $005944
        BNE.S  loc_005952                       ; $00594A
        TST.W  $C89C.W                          ; $00594C
loc_005950:
        BEQ.S  loc_00595A                       ; $005950
loc_005952:
        ANDI.W  #$0138,D0                       ; $005952
        BEQ.S  loc_005962                       ; $005956
        BRA.S  loc_00596A                       ; $005958
loc_00595A:
        ANDI.W  #$0130,D0                       ; $00595A
        BEQ.S  loc_005962                       ; $00595E
        BRA.S  loc_00596A                       ; $005960
loc_005962:
        LEA     $9F00.W,A0                      ; $005962
        JSR     loc_0059EC(PC)                  ; $005966
loc_00596A:
        LEA     $9000.W,A0                      ; $00596A
        MOVE.L  $00B2(A0),$0018(A0)             ; $00596E
        MOVE.B  $00E5(A0),D1                    ; $005974
loc_005978:
        ANDI.B  #$0006,D1                       ; $005978
        BEQ.S  loc_005984                       ; $00597C
        MOVE.L  $C70C.W,$0018(A0)               ; $00597E
loc_005984:
        MOVE.W  $C07A.W,D0                      ; $005984
        BTST    #3,$C80E.W                      ; $005988
        BNE.S  loc_005996                       ; $00598E
        MOVEA.L $0A(PC,D0.W),A1                 ; $005990
        JMP     (A1)                            ; $005994
loc_005996:
        MOVEA.L $2C(PC,D0.W),A1                 ; $005996
        JMP     (A1)                            ; $00599A
        ORI.L  #$5AB60088,A0                    ; $00599C
        SUBQ.W  #5,$0088(A6)                    ; $0059A2
        SMI     -(A0)                           ; $0059A6
loc_0059A8:
        ORI.L  #$5C5A0088,A0                    ; $0059A8
        SUBQ.B  #6,A0                           ; $0059AE
        ORI.L  #$5DE00088,A0                    ; $0059B0
        ADDQ.B  #7,$0088.W                      ; $0059B6
        BLS.S  loc_005950                       ; $0059BA
        ORI.L  #$633A0088,A0                    ; $0059BC
        SMI     $0088(A4)                       ; $0059C2
        SGT     $0088(A2)                       ; $0059C6
        SUBQ.L  #7,(A2)+                        ; $0059CA
        ORI.L  #$60080088,A0                    ; $0059CC
        BRA.S  loc_0059A8                       ; $0059D2
        ORI.L  #$617A0088,A0                    ; $0059D4
        SLT     -(A0)                           ; $0059DA
        ORI.L  #$62920088,A0                    ; $0059DC
        BLS.S  loc_005978                       ; $0059E2
        ORI.L  #$633A0088,A0                    ; $0059E4
        BRA.S  loc_005A00                       ; $0059EA
loc_0059EC:
        MOVE.W  D7,-(A7)                        ; $0059EC
        JSR     $009B12(PC)                     ; $0059EE [movement_calc]
        JSR     $00A3BA(PC)                     ; $0059F2
        JSR     $00A3EA(PC)                     ; $0059F6
        JSR     $00A470(PC)                     ; $0059FA
        MOVE.W  $0054(A0),D0                    ; $0059FE
        ANDI.W  #$0009,D0                       ; $005A02
        BEQ.S  loc_005A1C                       ; $005A06
        TST.W  $006A(A0)                        ; $005A08
        BNE.S  loc_005A1C                       ; $005A0C
        CMPI.W  #$0064,$0004(A0)                ; $005A0E
        BLE.S  loc_005A1C                       ; $005A14
        ORI.W  #$1000,$0002(A0)                 ; $005A16
loc_005A1C:
        JSR     $00A350(PC)                     ; $005A1C [collision_check]
        TST.W  $0004(A0)                        ; $005A20
        BEQ.S  loc_005A32                       ; $005A24
        SUBI.W  #$2000,$00BC(A0)                ; $005A26
        SUBI.W  #$1800,$00C4(A0)                ; $005A2C
loc_005A32:
        JSR     $007AB6(PC)                     ; $005A32 [func_007AB6]
        LEA     $0093AC2C,A1                    ; $005A36
        MOVE.W  $00C8(A0),D0                    ; $005A3C
        SUB.W  $0032(A0),D0                     ; $005A40
        ADD.W  D0,D0                            ; $005A44
        BMI.S  loc_005A52                       ; $005A46
        ANDI.W  #$03FF,D0                       ; $005A48
        MOVE.W  $00(A1,D0.W),D0                 ; $005A4C
        BRA.S  loc_005A5E                       ; $005A50
loc_005A52:
        NEG.W  D0                               ; $005A52
        ANDI.W  #$03FF,D0                       ; $005A54
        MOVE.W  $00(A1,D0.W),D0                 ; $005A58
        NEG.W  D0                               ; $005A5C
loc_005A5E:
        MOVE.W  D0,$003A(A0)                    ; $005A5E
        LEA     $0093A82C,A1                    ; $005A62
        MOVE.W  $0032(A0),D0                    ; $005A68
        SUB.W  $00C6(A0),D0                     ; $005A6C
        ADD.W  D0,D0                            ; $005A70
        BMI.S  loc_005A7E                       ; $005A72
        ANDI.W  #$03FF,D0                       ; $005A74
        MOVE.W  $00(A1,D0.W),D0                 ; $005A78
        BRA.S  loc_005A8A                       ; $005A7C
loc_005A7E:
        NEG.W  D0                               ; $005A7E
        ANDI.W  #$03FF,D0                       ; $005A80
        MOVE.W  $00(A1,D0.W),D0                 ; $005A84
        NEG.W  D0                               ; $005A88
loc_005A8A:
        MOVE.W  D0,$003E(A0)                    ; $005A8A
        MOVE.W  $006E(A0),$0046(A0)             ; $005A8E
        JSR     $00764E(PC)                     ; $005A94 [render_prep]
        JSR     $00714A(PC)                     ; $005A98 [transform_calc]
        MOVE.W  $0026(A0),D0                    ; $005A9C
        SUB.W  $0024(A0),D0                     ; $005AA0
        CMPI.W  #$0064,D0                       ; $005AA4
        BLT.S  loc_005AAE                       ; $005AA8
        ADDQ.W  #1,$002C(A0)                    ; $005AAA
loc_005AAE:
        LEA     $0100(A0),A0                    ; $005AAE
        MOVE.W  (A7)+,D7                        ; $005AB2
        RTS                                     ; $005AB4
        JSR     $00B77C(PC)                     ; $005AB6 [func_00B77C]
        MOVEQ   #$00,D0                         ; $005ABA
        MOVE.W  D0,$0044(A0)                    ; $005ABC
        MOVE.W  D0,$0046(A0)                    ; $005AC0
        MOVE.W  D0,$004A(A0)                    ; $005AC4
        JSR     $0085C4(PC)                     ; $005AC8
        JSR     $00859A(PC)                     ; $005ACC [vdp_write]
        JSR     $00A350(PC)                     ; $005AD0 [collision_check]
        JSR     $008170(PC)                     ; $005AD4 [func_008170]
        JSR     $0080CC(PC)                     ; $005AD8 [func_0080CC]
        JSR     $008548(PC)                     ; $005ADC [vdp_operation]
        JSR     $0094FA(PC)                     ; $005AE0 [sound_trigger]
        JSR     $009312(PC)                     ; $005AE4 [timer_update]
        JSR     $009B12(PC)                     ; $005AE8 [movement_calc]
        JSR     $009182(PC)                     ; $005AEC [input_process]
        JSR     $00961E(PC)                     ; $005AF0 [state_machine]
        JSR     $009688(PC)                     ; $005AF4 [func_009688]
        JSR     $009802(PC)                     ; $005AF8 [game_update]
        JSR     $007E7A(PC)                     ; $005AFC [func_007E7A]
        JSR     $006F98(PC)                     ; $005B00 [func_006F98]
        JSR     $007CD8(PC)                     ; $005B04 [func_007CD8]
        JSR     $00A434(PC)                     ; $005B08 [score_update]
        JSR     $0070AA(PC)                     ; $005B0C [func_0070AA]
loc_005B10:
        JSR     $007F04(PC)                     ; $005B10 [func_007F04]
        JSR     $009E6E(PC)                     ; $005B14 [func_009E6E]
        JSR     $007C4E(PC)                     ; $005B18 [func_007C4E]
        JSR     $00714A(PC)                     ; $005B1C [transform_calc]
        JSR     $00764E(PC)                     ; $005B20 [render_prep]
        JSR     $007F50(PC)                     ; $005B24 [func_007F50]
        JSR     $009CCE(PC)                     ; $005B28 [math_routine]
        JSR     $00AC3E(PC)                     ; $005B2C [func_00AC3E]
        JSR     $009B54(PC)                     ; $005B30 [physics_calc]
        JSR     $0086FE(PC)                     ; $005B34 [func_0086FE]
        JSR     $009040(PC)                     ; $005B38 [func_009040]
        JSR     $00ACD4(PC)                     ; $005B3C [func_00ACD4]
        JSR     $0081D8(PC)                     ; $005B40
        JSR     $009EC0(PC)                     ; $005B44 [func_009EC0]
        JSR     $0075FE(PC)                     ; $005B48 [func_0075FE]
        JSR     $0071A6(PC)                     ; $005B4C [func_0071A6]
        JSR     $002984(PC)                     ; $005B50 [func_002984]
        JSR     $0031A6(PC)                     ; $005B54 [func_0031A6]
        JSR     $0036DE(PC)                     ; $005B58 [clear_buffer]
        JSR     $0037B6(PC)                     ; $005B5C [memory_copy]
        JSR     $003F86(PC)                     ; $005B60 [func_003F86]
        MOVE.B  $C304.W,$C30C.W                 ; $005B64
        JMP     $006C08(PC)                     ; $005B6A
        JSR     $00B77C(PC)                     ; $005B6E [func_00B77C]
        JSR     $00A350(PC)                     ; $005B72 [collision_check]
        JSR     $008170(PC)                     ; $005B76 [func_008170]
        JSR     $0080CC(PC)                     ; $005B7A [func_0080CC]
        JSR     $008548(PC)                     ; $005B7E [vdp_operation]
        JSR     $00961E(PC)                     ; $005B82 [state_machine]
        JSR     $007816(PC)                     ; $005B86 [func_007816]
        JSR     $00764E(PC)                     ; $005B8A [render_prep]
        JSR     $0070AA(PC)                     ; $005B8E [func_0070AA]
        JSR     $00A8E0(PC)                     ; $005B92
        JSR     $009B54(PC)                     ; $005B96 [physics_calc]
        JSR     $009182(PC)                     ; $005B9A [input_process]
        JSR     $009802(PC)                     ; $005B9E [game_update]
        JSR     $00714A(PC)                     ; $005BA2 [transform_calc]
        JSR     $009CCE(PC)                     ; $005BA6 [math_routine]
        JSR     $0086FE(PC)                     ; $005BAA [func_0086FE]
        JSR     $009040(PC)                     ; $005BAE [func_009040]
        JSR     $00ACD4(PC)                     ; $005BB2 [func_00ACD4]
        JSR     $0075FE(PC)                     ; $005BB6 [func_0075FE]
        JSR     $0071A6(PC)                     ; $005BBA [func_0071A6]
        JSR     $002984(PC)                     ; $005BBE [func_002984]
        JSR     $0031A6(PC)                     ; $005BC2 [func_0031A6]
        JSR     $0036DE(PC)                     ; $005BC6 [clear_buffer]
        JSR     $0037B6(PC)                     ; $005BCA [memory_copy]
        JSR     $003F86(PC)                     ; $005BCE [func_003F86]
        JSR     $003CC4(PC)                     ; $005BD2 [func_003CC4]
        MOVE.B  $C304.W,$C30C.W                 ; $005BD6
        JMP     $006BEA(PC)                     ; $005BDC
        MOVE.W  #$0000,$0006(A0)                ; $005BE0
        MOVE.W  #$0000,$0074(A0)                ; $005BE6
        JSR     $00B77C(PC)                     ; $005BEC [func_00B77C]
        MOVEQ   #$00,D0                         ; $005BF0
        MOVE.W  D0,$0044(A0)                    ; $005BF2
        MOVE.W  D0,$0046(A0)                    ; $005BF6
        MOVE.W  D0,$004A(A0)                    ; $005BFA
        JSR     loc_0049EE(PC)                  ; $005BFE
        JSR     $00859A(PC)                     ; $005C02 [vdp_write]
        JSR     $00A350(PC)                     ; $005C06 [collision_check]
        JSR     $008170(PC)                     ; $005C0A [func_008170]
        JSR     $0080CC(PC)                     ; $005C0E [func_0080CC]
        JSR     $008548(PC)                     ; $005C12 [vdp_operation]
        JSR     $0094FA(PC)                     ; $005C16 [sound_trigger]
        CMPI.W  #$0004,$C26C.W                  ; $005C1A
        BEQ.S  loc_005C26                       ; $005C20
        JSR     $009312(PC)                     ; $005C22 [timer_update]
loc_005C26:
        JSR     $009B12(PC)                     ; $005C26 [movement_calc]
        JSR     $009182(PC)                     ; $005C2A [input_process]
        JSR     $009802(PC)                     ; $005C2E [game_update]
        JSR     $007084(PC)                     ; $005C32 [func_007084]
        JSR     $0070AA(PC)                     ; $005C36 [func_0070AA]
        JSR     $007816(PC)                     ; $005C3A [func_007816]
        SUBQ.W  #1,$C02C.W                      ; $005C3E
        BGT.S  loc_005C56                       ; $005C42
        MOVE.W  #$0000,$C02C.W                  ; $005C44
        MOVE.W  #$0000,$0074(A0)                ; $005C4A
        MOVE.W  $C08C.W,$C07A.W                 ; $005C50
loc_005C56:
        JMP     loc_005B10(PC)                  ; $005C56
        JSR     $00B77C(PC)                     ; $005C5A [func_00B77C]
        MOVEQ   #$00,D0                         ; $005C5E
        MOVE.W  D0,$0044(A0)                    ; $005C60
        MOVE.W  D0,$0046(A0)                    ; $005C64
        MOVE.W  D0,$004A(A0)                    ; $005C68
        JSR     $00859A(PC)                     ; $005C6C [vdp_write]
        JSR     $00A350(PC)                     ; $005C70 [collision_check]
        JSR     $008170(PC)                     ; $005C74 [func_008170]
        JSR     $0080CC(PC)                     ; $005C78 [func_0080CC]
        JSR     $008548(PC)                     ; $005C7C [vdp_operation]
        JSR     $009802(PC)                     ; $005C80 [game_update]
        JSR     $007E7A(PC)                     ; $005C84 [func_007E7A]
        JSR     $006F98(PC)                     ; $005C88 [func_006F98]
        JSR     $007CD8(PC)                     ; $005C8C [func_007CD8]
        JSR     $00A434(PC)                     ; $005C90 [score_update]
        JSR     $0070AA(PC)                     ; $005C94 [func_0070AA]
        JSR     $007F04(PC)                     ; $005C98 [func_007F04]
        JSR     $009E6E(PC)                     ; $005C9C [func_009E6E]
        JSR     $007C4E(PC)                     ; $005CA0 [func_007C4E]
        JSR     $00714A(PC)                     ; $005CA4 [transform_calc]
        JSR     $00764E(PC)                     ; $005CA8 [render_prep]
        JSR     $007F50(PC)                     ; $005CAC [func_007F50]
        JSR     $009CCE(PC)                     ; $005CB0 [math_routine]
        JSR     $00AC3E(PC)                     ; $005CB4 [func_00AC3E]
        JSR     $0086FE(PC)                     ; $005CB8 [func_0086FE]
        JSR     $009040(PC)                     ; $005CBC [func_009040]
        JSR     $0081D8(PC)                     ; $005CC0
        JSR     $009EC0(PC)                     ; $005CC4 [func_009EC0]
        JSR     $00961E(PC)                     ; $005CC8 [state_machine]
        JSR     $00A8F8(PC)                     ; $005CCC [func_00A8F8]
        BTST    #4,$C30E.W                      ; $005CD0
        BEQ.S  loc_005CDE                       ; $005CD6
        MOVE.W  $C08C.W,$C07A.W                 ; $005CD8
loc_005CDE:
        JSR     $0075FE(PC)                     ; $005CDE [func_0075FE]
        JSR     $0071A6(PC)                     ; $005CE2 [func_0071A6]
        JSR     $002984(PC)                     ; $005CE6 [func_002984]
        JSR     $0031A6(PC)                     ; $005CEA [func_0031A6]
        JSR     $0036DE(PC)                     ; $005CEE [clear_buffer]
        JSR     $0037B6(PC)                     ; $005CF2 [memory_copy]
        TST.W  $C89C.W                          ; $005CF6
        BNE.S  loc_005D00                       ; $005CFA
        JSR     $003CC4(PC)                     ; $005CFC [func_003CC4]
loc_005D00:
        MOVE.B  $C304.W,$C30C.W                 ; $005D00
        RTS                                     ; $005D06
        MOVE.B  #$0001,$C800.W                  ; $005D08
        MOVEQ   #$00,D0                         ; $005D0E
        MOVE.W  D0,$0044(A0)                    ; $005D10
        MOVE.W  D0,$0046(A0)                    ; $005D14
        MOVE.W  D0,$004A(A0)                    ; $005D18
        JSR     $0080CC(PC)                     ; $005D1C [func_0080CC]
        JSR     $008548(PC)                     ; $005D20 [vdp_operation]
        JSR     $009802(PC)                     ; $005D24 [game_update]
        JSR     $007E7A(PC)                     ; $005D28 [func_007E7A]
        JSR     $006F98(PC)                     ; $005D2C [func_006F98]
        JSR     $007CD8(PC)                     ; $005D30 [func_007CD8]
        JSR     $0070AA(PC)                     ; $005D34 [func_0070AA]
        JSR     $00714A(PC)                     ; $005D38 [transform_calc]
        JSR     $00764E(PC)                     ; $005D3C [render_prep]
        JSR     $007F50(PC)                     ; $005D40 [func_007F50]
        JSR     $009CCE(PC)                     ; $005D44 [math_routine]
        JSR     $00AC3E(PC)                     ; $005D48 [func_00AC3E]
        JSR     $009B54(PC)                     ; $005D4C [physics_calc]
        JSR     $0086FE(PC)                     ; $005D50 [func_0086FE]
        JSR     $009040(PC)                     ; $005D54 [func_009040]
        JSR     $0081D8(PC)                     ; $005D58
        JSR     $0075FE(PC)                     ; $005D5C [func_0075FE]
        JSR     $0071A6(PC)                     ; $005D60 [func_0071A6]
        JSR     $002984(PC)                     ; $005D64 [func_002984]
        JSR     $0031A6(PC)                     ; $005D68 [func_0031A6]
        JSR     $0036DE(PC)                     ; $005D6C [clear_buffer]
        JSR     $0037B6(PC)                     ; $005D70 [memory_copy]
        JSR     $003F86(PC)                     ; $005D74 [func_003F86]
        MOVE.B  $C304.W,$C30C.W                 ; $005D78
        MOVE.W  $C8A0.W,D0                      ; $005D7E
        BTST    #7,$C81C.W                      ; $005D82
        BEQ.S  loc_005D8C                       ; $005D88
        MOVEQ   #$04,D0                         ; $005D8A
loc_005D8C:
        MOVEA.L $3A(PC,D0.W),A1                 ; $005D8C
        JSR     (A1)                            ; $005D90
        CMPI.W  #$0014,$C8AA.W                  ; $005D92
        BNE.S  loc_005DC6                       ; $005D98
        MOVE.B  #$0000,$C800.W                  ; $005D9A
        MOVE.W  $C092.W,$C07A.W                 ; $005DA0
        MOVE.W  #$0004,$C8AC.W                  ; $005DA6
        TST.W  $C89C.W                          ; $005DAC
        BEQ.S  loc_005DB8                       ; $005DB0
        MOVE.W  #$0020,$C8AC.W                  ; $005DB2
loc_005DB8:
        BTST    #7,$C81C.W                      ; $005DB8
        BEQ.S  loc_005DC6                       ; $005DBE
        MOVE.W  #$0020,$C8AC.W                  ; $005DC0
loc_005DC6:
        RTS                                     ; $005DC6
        ORI.L  #$3C7E0088,A0                    ; $005DC8
        MOVE.W  (A2)+,$0088(A6)                 ; $005DCE
        MOVE.W  (A2)+,$0088(A6)                 ; $005DD2
        MOVE.W  (A2)+,$0088(A6)                 ; $005DD6
        MOVE.W  (A2)+,$0088(A6)                 ; $005DDA
        MOVE.W  (A2)+,$4EBA(A6)                 ; $005DDE
        LSL.W  A0                               ; $005DE2
        JSR     $00B77C(PC)                     ; $005DE4 [func_00B77C]
        MOVEQ   #$00,D0                         ; $005DE8
        MOVE.W  D0,$0044(A0)                    ; $005DEA
        MOVE.W  D0,$0046(A0)                    ; $005DEE
        MOVE.W  D0,$004A(A0)                    ; $005DF2
        JSR     $0070AA(PC)                     ; $005DF6 [func_0070AA]
        JSR     $00714A(PC)                     ; $005DFA [transform_calc]
        JSR     $00764E(PC)                     ; $005DFE [render_prep]
        JSR     $007F50(PC)                     ; $005E02 [func_007F50]
        JSR     $009CCE(PC)                     ; $005E06 [math_routine]
        JSR     $0086FE(PC)                     ; $005E0A [func_0086FE]
        JSR     $009040(PC)                     ; $005E0E [func_009040]
        JSR     $0081D8(PC)                     ; $005E12
        JSR     $004084(PC)                     ; $005E16
        JSR     $0075FE(PC)                     ; $005E1A [func_0075FE]
        JSR     $0071A6(PC)                     ; $005E1E [func_0071A6]
        JSR     $002984(PC)                     ; $005E22 [func_002984]
        JSR     $0031A6(PC)                     ; $005E26 [func_0031A6]
        JSR     $0036DE(PC)                     ; $005E2A [clear_buffer]
        JSR     $0037B6(PC)                     ; $005E2E [memory_copy]
        JSR     $0030C6(PC)                     ; $005E32
        RTS                                     ; $005E36
        MOVEQ   #$00,D0                         ; $005E38
        MOVE.W  D0,$0044(A0)                    ; $005E3A
        MOVE.W  D0,$0046(A0)                    ; $005E3E
        MOVE.W  D0,$004A(A0)                    ; $005E42
        MOVE.L  #$00100010,$C970.W              ; $005E46
        JSR     $00B77C(PC)                     ; $005E4E [func_00B77C]
        MOVE.W  #$0002,$0092(A0)                ; $005E52
        JSR     $00859A(PC)                     ; $005E58 [vdp_write]
        JSR     $00A350(PC)                     ; $005E5C [collision_check]
        JSR     $008170(PC)                     ; $005E60 [func_008170]
        JSR     $0080CC(PC)                     ; $005E64 [func_0080CC]
        JSR     $008548(PC)                     ; $005E68 [vdp_operation]
        JSR     $0094FA(PC)                     ; $005E6C [sound_trigger]
        JSR     $009312(PC)                     ; $005E70 [timer_update]
        JSR     $009B12(PC)                     ; $005E74 [movement_calc]
        JSR     $009182(PC)                     ; $005E78 [input_process]
        JSR     $00961E(PC)                     ; $005E7C [state_machine]
        JSR     $009688(PC)                     ; $005E80 [func_009688]
        JSR     $009802(PC)                     ; $005E84 [game_update]
        JSR     $007E7A(PC)                     ; $005E88 [func_007E7A]
        JSR     $006F98(PC)                     ; $005E8C [func_006F98]
        JSR     $007CD8(PC)                     ; $005E90 [func_007CD8]
        JSR     $00A434(PC)                     ; $005E94 [score_update]
        JSR     $0070AA(PC)                     ; $005E98 [func_0070AA]
        JSR     $007F04(PC)                     ; $005E9C [func_007F04]
        JSR     $007C4E(PC)                     ; $005EA0 [func_007C4E]
        JSR     $00714A(PC)                     ; $005EA4 [transform_calc]
        JSR     $00764E(PC)                     ; $005EA8 [render_prep]
        JSR     $007F50(PC)                     ; $005EAC [func_007F50]
        JSR     $009CCE(PC)                     ; $005EB0 [math_routine]
        JSR     $009B54(PC)                     ; $005EB4 [physics_calc]
        JSR     $0086FE(PC)                     ; $005EB8 [func_0086FE]
        JSR     $009040(PC)                     ; $005EBC [func_009040]
        JSR     $00ACD4(PC)                     ; $005EC0 [func_00ACD4]
        JSR     $004084(PC)                     ; $005EC4
        JSR     $0075FE(PC)                     ; $005EC8 [func_0075FE]
        JSR     $0071A6(PC)                     ; $005ECC [func_0071A6]
        JSR     $002984(PC)                     ; $005ED0 [func_002984]
        JSR     $0031A6(PC)                     ; $005ED4 [func_0031A6]
        JSR     $0036DE(PC)                     ; $005ED8 [clear_buffer]
        JSR     $0037B6(PC)                     ; $005EDC [memory_copy]
        JSR     $003F86(PC)                     ; $005EE0 [func_003F86]
        JSR     $0030C6(PC)                     ; $005EE4
        RTS                                     ; $005EE8
        MOVEQ   #$00,D0                         ; $005EEA
        MOVE.W  D0,$0044(A0)                    ; $005EEC
        MOVE.W  D0,$0046(A0)                    ; $005EF0
        MOVE.W  D0,$004A(A0)                    ; $005EF4
        JSR     $0085C4(PC)                     ; $005EF8
        JSR     $00859A(PC)                     ; $005EFC [vdp_write]
        JSR     $00A350(PC)                     ; $005F00 [collision_check]
        JSR     $008170(PC)                     ; $005F04 [func_008170]
        JSR     $0080CC(PC)                     ; $005F08 [func_0080CC]
        JSR     $008548(PC)                     ; $005F0C [vdp_operation]
        JSR     $0094FA(PC)                     ; $005F10 [sound_trigger]
        JSR     $009312(PC)                     ; $005F14 [timer_update]
        JSR     $009B12(PC)                     ; $005F18 [movement_calc]
        JSR     $009182(PC)                     ; $005F1C [input_process]
        JSR     $00961E(PC)                     ; $005F20 [state_machine]
        JSR     $009688(PC)                     ; $005F24 [func_009688]
        JSR     $009802(PC)                     ; $005F28 [game_update]
        JSR     $007E7A(PC)                     ; $005F2C [func_007E7A]
        JSR     $006F98(PC)                     ; $005F30 [func_006F98]
        JSR     $007CD8(PC)                     ; $005F34 [func_007CD8]
        JSR     $00A434(PC)                     ; $005F38 [score_update]
        JSR     $0070AA(PC)                     ; $005F3C [func_0070AA]
        JSR     $007F04(PC)                     ; $005F40 [func_007F04]
        JSR     $009E6E(PC)                     ; $005F44 [func_009E6E]
        JSR     $007C4E(PC)                     ; $005F48 [func_007C4E]
        JSR     $00714A(PC)                     ; $005F4C [transform_calc]
        JSR     $00764E(PC)                     ; $005F50 [render_prep]
        JSR     $007F50(PC)                     ; $005F54 [func_007F50]
        JSR     $009CCE(PC)                     ; $005F58 [math_routine]
        JSR     $00AC3E(PC)                     ; $005F5C [func_00AC3E]
        JSR     $009B54(PC)                     ; $005F60 [physics_calc]
        JSR     $0086C8(PC)                     ; $005F64 [func_0086C8]
        JSR     $00ACD4(PC)                     ; $005F68 [func_00ACD4]
        JSR     $009EC0(PC)                     ; $005F6C [func_009EC0]
        JSR     $003126(PC)                     ; $005F70 [func_003126]
        JSR     $003160(PC)                     ; $005F74 [func_003160]
        JSR     $007624(PC)                     ; $005F78 [func_007624]
        JSR     $00734E(PC)                     ; $005F7C [func_00734E]
        JSR     $0036DE(PC)                     ; $005F80 [clear_buffer]
        JSR     $0037B6(PC)                     ; $005F84 [memory_copy]
        JSR     $003F86(PC)                     ; $005F88 [func_003F86]
        JSR     $009064(PC)                     ; $005F8C [func_009064]
        MOVE.B  $C304.W,$C30C.W                 ; $005F90
        JMP     $006C08(PC)                     ; $005F96
        JSR     $00A350(PC)                     ; $005F9A [collision_check]
        JSR     $008170(PC)                     ; $005F9E [func_008170]
        JSR     $0080CC(PC)                     ; $005FA2 [func_0080CC]
        JSR     $008548(PC)                     ; $005FA6 [vdp_operation]
        JSR     $00961E(PC)                     ; $005FAA [state_machine]
        JSR     $007816(PC)                     ; $005FAE [func_007816]
        JSR     $00764E(PC)                     ; $005FB2 [render_prep]
        JSR     $0070AA(PC)                     ; $005FB6 [func_0070AA]
        JSR     $00A8E0(PC)                     ; $005FBA
        JSR     $009B54(PC)                     ; $005FBE [physics_calc]
        JSR     $009182(PC)                     ; $005FC2 [input_process]
        JSR     $009802(PC)                     ; $005FC6 [game_update]
        JSR     $00714A(PC)                     ; $005FCA [transform_calc]
        JSR     $009CCE(PC)                     ; $005FCE [math_routine]
        JSR     $0086C8(PC)                     ; $005FD2 [func_0086C8]
        JSR     $00ACD4(PC)                     ; $005FD6 [func_00ACD4]
        JSR     $003126(PC)                     ; $005FDA [func_003126]
        JSR     $003160(PC)                     ; $005FDE [func_003160]
        JSR     $007624(PC)                     ; $005FE2 [func_007624]
        JSR     $00734E(PC)                     ; $005FE6 [func_00734E]
        JSR     $0036DE(PC)                     ; $005FEA [clear_buffer]
        JSR     $0037B6(PC)                     ; $005FEE [memory_copy]
        JSR     $003F86(PC)                     ; $005FF2 [func_003F86]
        JSR     $003CC4(PC)                     ; $005FF6 [func_003CC4]
        JSR     $009064(PC)                     ; $005FFA [func_009064]
        MOVE.B  $C304.W,$C30C.W                 ; $005FFE
        JMP     $006C08(PC)                     ; $006004
        MOVE.W  #$0000,$0006(A0)                ; $006008
        MOVE.W  #$0000,$0074(A0)                ; $00600E
        MOVEQ   #$00,D0                         ; $006014
        MOVE.W  D0,$0044(A0)                    ; $006016
        MOVE.W  D0,$0046(A0)                    ; $00601A
        MOVE.W  D0,$004A(A0)                    ; $00601E
        JSR     loc_0049EE(PC)                  ; $006022
        JSR     $00859A(PC)                     ; $006026 [vdp_write]
        JSR     $00A350(PC)                     ; $00602A [collision_check]
        JSR     $008170(PC)                     ; $00602E [func_008170]
        JSR     $0080CC(PC)                     ; $006032 [func_0080CC]
        JSR     $008548(PC)                     ; $006036 [vdp_operation]
        JSR     $0094FA(PC)                     ; $00603A [sound_trigger]
        CMPI.W  #$0004,$C26C.W                  ; $00603E
        BEQ.S  loc_00604A                       ; $006044
        JSR     $009312(PC)                     ; $006046 [timer_update]
loc_00604A:
        JSR     $009B12(PC)                     ; $00604A [movement_calc]
        JSR     $009182(PC)                     ; $00604E [input_process]
        JSR     $009802(PC)                     ; $006052 [game_update]
        JSR     $007084(PC)                     ; $006056 [func_007084]
        JSR     $0070AA(PC)                     ; $00605A [func_0070AA]
        JSR     $007816(PC)                     ; $00605E [func_007816]
        SUBQ.W  #1,$C02C.W                      ; $006062
        BGT.S  loc_00607A                       ; $006066
        MOVE.W  #$0000,$C02C.W                  ; $006068
        MOVE.W  #$0000,$0074(A0)                ; $00606E
        MOVE.W  $C08C.W,$C07A.W                 ; $006074
loc_00607A:
        JSR     $007F04(PC)                     ; $00607A [func_007F04]
        JSR     $009E6E(PC)                     ; $00607E [func_009E6E]
        JSR     $007C4E(PC)                     ; $006082 [func_007C4E]
        JSR     $00714A(PC)                     ; $006086 [transform_calc]
        JSR     $00764E(PC)                     ; $00608A [render_prep]
        JSR     $007F50(PC)                     ; $00608E [func_007F50]
        JSR     $009CCE(PC)                     ; $006092 [math_routine]
        JSR     $00AC3E(PC)                     ; $006096 [func_00AC3E]
        JSR     $009B54(PC)                     ; $00609A [physics_calc]
        JSR     $0086C8(PC)                     ; $00609E [func_0086C8]
        JSR     $00ACD4(PC)                     ; $0060A2 [func_00ACD4]
        JSR     $009EC0(PC)                     ; $0060A6 [func_009EC0]
        JSR     $003126(PC)                     ; $0060AA [func_003126]
        JSR     $003160(PC)                     ; $0060AE [func_003160]
        JSR     $007624(PC)                     ; $0060B2 [func_007624]
        JSR     $00734E(PC)                     ; $0060B6 [func_00734E]
        JSR     $0036DE(PC)                     ; $0060BA [clear_buffer]
        JSR     $0037B6(PC)                     ; $0060BE [memory_copy]
        JSR     $003F86(PC)                     ; $0060C2 [func_003F86]
        JSR     $009064(PC)                     ; $0060C6 [func_009064]
        MOVE.B  $C304.W,$C30C.W                 ; $0060CA
        JMP     $006C08(PC)                     ; $0060D0
        MOVEQ   #$00,D0                         ; $0060D4
        MOVE.W  D0,$0044(A0)                    ; $0060D6
        MOVE.W  D0,$0046(A0)                    ; $0060DA
        MOVE.W  D0,$004A(A0)                    ; $0060DE
        JSR     $00859A(PC)                     ; $0060E2 [vdp_write]
        JSR     $00A350(PC)                     ; $0060E6 [collision_check]
        JSR     $008170(PC)                     ; $0060EA [func_008170]
        JSR     $0080CC(PC)                     ; $0060EE [func_0080CC]
        JSR     $008548(PC)                     ; $0060F2 [vdp_operation]
        JSR     $009802(PC)                     ; $0060F6 [game_update]
        JSR     $007E7A(PC)                     ; $0060FA [func_007E7A]
        JSR     $006F98(PC)                     ; $0060FE [func_006F98]
        JSR     $007CD8(PC)                     ; $006102 [func_007CD8]
        JSR     $00A434(PC)                     ; $006106 [score_update]
        JSR     $0070AA(PC)                     ; $00610A [func_0070AA]
        JSR     $007F04(PC)                     ; $00610E [func_007F04]
        JSR     $009E6E(PC)                     ; $006112 [func_009E6E]
        JSR     $007C4E(PC)                     ; $006116 [func_007C4E]
        JSR     $00714A(PC)                     ; $00611A [transform_calc]
        JSR     $00764E(PC)                     ; $00611E [render_prep]
        JSR     $007F50(PC)                     ; $006122 [func_007F50]
        JSR     $009CCE(PC)                     ; $006126 [math_routine]
        JSR     $00AC3E(PC)                     ; $00612A [func_00AC3E]
        JSR     $0086C8(PC)                     ; $00612E [func_0086C8]
        JSR     $009EC0(PC)                     ; $006132 [func_009EC0]
        JSR     $00961E(PC)                     ; $006136 [state_machine]
        JSR     $00A8F8(PC)                     ; $00613A [func_00A8F8]
        BTST    #4,$C30E.W                      ; $00613E
        BEQ.S  loc_00614C                       ; $006144
        MOVE.W  $C08C.W,$C07A.W                 ; $006146
loc_00614C:
        JSR     $003126(PC)                     ; $00614C [func_003126]
        JSR     $003160(PC)                     ; $006150 [func_003160]
        JSR     $007624(PC)                     ; $006154 [func_007624]
        JSR     $00734E(PC)                     ; $006158 [func_00734E]
        JSR     $0036DE(PC)                     ; $00615C [clear_buffer]
        JSR     $0037B6(PC)                     ; $006160 [memory_copy]
        TST.W  $C89C.W                          ; $006164
        BNE.S  loc_00616E                       ; $006168
        JSR     $003CC4(PC)                     ; $00616A [func_003CC4]
loc_00616E:
        JSR     $009064(PC)                     ; $00616E [func_009064]
        MOVE.B  $C304.W,$C30C.W                 ; $006172
        RTS                                     ; $006178
        BTST    #0,$C80E.W                      ; $00617A
        BNE.W  $006258                          ; $006180
        MOVE.B  #$0001,$C800.W                  ; $006184
        MOVEQ   #$00,D0                         ; $00618A
        MOVE.W  D0,$0044(A0)                    ; $00618C
        MOVE.W  D0,$0046(A0)                    ; $006190
        MOVE.W  D0,$004A(A0)                    ; $006194
        JSR     $0080CC(PC)                     ; $006198 [func_0080CC]
        JSR     $008548(PC)                     ; $00619C [vdp_operation]
        JSR     $009802(PC)                     ; $0061A0 [game_update]
        JSR     $007E7A(PC)                     ; $0061A4 [func_007E7A]
        JSR     $006F98(PC)                     ; $0061A8 [func_006F98]
        JSR     $007CD8(PC)                     ; $0061AC [func_007CD8]
        JSR     $0070AA(PC)                     ; $0061B0 [func_0070AA]
        JSR     $00714A(PC)                     ; $0061B4 [transform_calc]
        JSR     $00764E(PC)                     ; $0061B8 [render_prep]
        JSR     $007F50(PC)                     ; $0061BC [func_007F50]
        JSR     $009CCE(PC)                     ; $0061C0 [math_routine]
        JSR     $00AC3E(PC)                     ; $0061C4 [func_00AC3E]
        JSR     $009B54(PC)                     ; $0061C8 [physics_calc]
        JSR     $0086C8(PC)                     ; $0061CC [func_0086C8]
        JSR     $003126(PC)                     ; $0061D0 [func_003126]
        JSR     $003160(PC)                     ; $0061D4 [func_003160]
        JSR     $007624(PC)                     ; $0061D8 [func_007624]
        JSR     $00734E(PC)                     ; $0061DC [func_00734E]
        JSR     $0036DE(PC)                     ; $0061E0 [clear_buffer]
        JSR     $0037B6(PC)                     ; $0061E4 [memory_copy]
        JSR     $003F86(PC)                     ; $0061E8 [func_003F86]
        JSR     $009064(PC)                     ; $0061EC [func_009064]
        MOVE.B  $C304.W,$C30C.W                 ; $0061F0
        MOVE.W  $C8A0.W,D0                      ; $0061F6
        BTST    #7,$C81C.W                      ; $0061FA
