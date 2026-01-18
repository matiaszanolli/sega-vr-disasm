; Generated assembly for $010200-$012200
; Branch targets: 239
; Labels: 220
; Format: DC.W with decoded mnemonics as comments

        org     $010200

        MOVEA.B (A0),A0                         ; $010200
        MOVE.W  #$00A8,D0                       ; $010202
        MOVE.W  #$0010,D1                       ; $010206
        JSR     $00E35A(PC)                     ; $01020A
        MOVEA.L #$06020000,A0                   ; $01020E
        MOVE.W  $A022.W,D0                      ; $010214
        LSL.W  #7,D0                            ; $010218
        MOVE.W  D0,D1                           ; $01021A
        LSL.W  #2,D0                            ; $01021C
        ADD.W  D1,D0                            ; $01021E
        LEA     $00(A0,D0.W),A0                 ; $010220
        MOVEA.L #$240310CC,A1                   ; $010224
        MOVE.W  #$0028,D0                       ; $01022A
        MOVE.W  #$0010,D1                       ; $01022E
        JSR     $00E35A(PC)                     ; $010232
        ADDQ.W  #4,$C87E.W                      ; $010236
        DC.W    $33FC,$0020,$00FF,$0008; $01023A MOVE.W  #$0020,$00FF0008
        RTS                                     ; $010242
        CLR.W  D0                               ; $010244
        JSR     $00E52C(PC)                     ; $010246
        MOVEA.L $A018.W,A0                      ; $01024A
        BSR.W  loc_010796                       ; $01024E
        JSR     $0088179E                       ; $010252
        CMPI.W  #$0001,$A036.W                  ; $010258
        BEQ.W  loc_01033C                       ; $01025E
        MOVE.W  $C86C.W,D1                      ; $010262
        BTST    #4,D1                           ; $010266
        BNE.W  loc_0102E0                       ; $01026A
        MOVE.W  D1,D2                           ; $01026E
        DC.W    $0202,$00E0         ; $010270 ANDI.B  #$00E0,D2
        BEQ.W  loc_010338                       ; $010274
        MOVE.B  #$0001,$A02C.W                  ; $010278
        MOVE.B  #$0000,$A02D.W                  ; $01027E
        MOVE.B  #$00A8,$C8A4.W                  ; $010284
        BTST    #7,D1                           ; $01028A
        BNE.W  loc_0102D8                       ; $01028E
        MOVE.W  $A024.W,D0                      ; $010292
        CMPI.B  #$0003,D0                       ; $010296
        BEQ.W  loc_0102D8                       ; $01029A
        CMPI.B  #$0008,D0                       ; $01029E
        BEQ.W  loc_0102E0                       ; $0102A2
        CLR.W  D1                               ; $0102A6
        MOVE.B  $A020.W,D1                      ; $0102A8
        MOVEA.L $A018.W,A0                      ; $0102AC
        MOVE.B  D0,$00(A0,D1.W)                 ; $0102B0
        BTST    #1,$A014.W                      ; $0102B4
        BEQ.W  loc_0102C6                       ; $0102BA
        MOVEA.L $A01C.W,A0                      ; $0102BE
        MOVE.B  D0,$00(A0,D1.W)                 ; $0102C2
loc_0102C6:
        ADDQ.B  #1,$A020.W                      ; $0102C6
        CMPI.B  #$0003,$A020.W                  ; $0102CA
        BGE.W  loc_0102D8                       ; $0102D0
        BRA.W  loc_01034E                       ; $0102D4
loc_0102D8:
        ADDQ.W  #4,$C87E.W                      ; $0102D8
        BRA.W  loc_010352                       ; $0102DC
loc_0102E0:
        TST.B  $A020.W                          ; $0102E0
        BEQ.W  loc_01034E                       ; $0102E4
        CLR.W  D1                               ; $0102E8
        MOVE.B  $A020.W,D1                      ; $0102EA
        MOVEA.L $A018.W,A0                      ; $0102EE
        MOVE.B  #$0020,$00(A0,D1.W)             ; $0102F2
        BTST    #1,$A014.W                      ; $0102F8
        BEQ.W  loc_01030C                       ; $0102FE
        MOVEA.L $A01C.W,A0                      ; $010302
        MOVE.B  #$0020,$00(A0,D1.W)             ; $010306
loc_01030C:
        SUBQ.B  #1,$A020.W                      ; $01030C
        CLR.W  D1                               ; $010310
        MOVE.B  $A020.W,D1                      ; $010312
        MOVEA.L $A018.W,A0                      ; $010316
        MOVE.B  #$0020,$00(A0,D1.W)             ; $01031A
        BTST    #1,$A014.W                      ; $010320
        BEQ.W  loc_010334                       ; $010326
        MOVEA.L $A01C.W,A0                      ; $01032A
        MOVE.B  #$0020,$00(A0,D1.W)             ; $01032E
loc_010334:
        BRA.W  loc_01034E                       ; $010334
loc_010338:
        BSR.W  loc_01084C                       ; $010338
loc_01033C:
        JSR     $0088FB36                       ; $01033C
        BTST    #6,$C80E.W                      ; $010342
        BNE.S  loc_01034E                       ; $010348
        CLR.W  $A036.W                          ; $01034A
loc_01034E:
        SUBQ.W  #4,$C87E.W                      ; $01034E
loc_010352:
        DC.W    $33FC,$0018,$00FF,$0008; $010352 MOVE.W  #$0018,$00FF0008
        RTS                                     ; $01035A
        CLR.W  D0                               ; $01035C
        BSR.W  $00E52C                          ; $01035E
        JSR     $00B684(PC)                     ; $010362
        BSR.W  loc_01071C                       ; $010366
        MOVEA.L #$0601C300,A0                   ; $01036A
        MOVEA.L #$2400E030,A1                   ; $010370
        MOVE.W  #$0080,D0                       ; $010376
        MOVE.W  #$0020,D1                       ; $01037A
        JSR     $00E35A(PC)                     ; $01037E
        LEA     $2402F0C0,A1                    ; $010382
        LEA     $FA48.W,A2                      ; $010388
        MOVEQ   #$00,D0                         ; $01038C
        MOVE.B  $FEB1.W,D0                      ; $01038E
        ADD.W  D0,D0                            ; $010392
        ADD.W  D0,D0                            ; $010394
        ADD.W  D0,D0                            ; $010396
        MOVE.W  D0,D1                           ; $010398
        ADD.W  D0,D0                            ; $01039A
        ADD.W  D1,D0                            ; $01039C
        ADD.W  D0,D0                            ; $01039E
        ADDA.L  D0,A2                           ; $0103A0
        MOVEQ   #$00,D0                         ; $0103A2
        MOVE.B  $FEA5.W,D0                      ; $0103A4
        ADD.W  D0,D0                            ; $0103A8
        ADD.W  D0,D0                            ; $0103AA
        ADD.W  D0,D0                            ; $0103AC
        ADDQ.W  #4,D0                           ; $0103AE
        ADDA.L  D0,A2                           ; $0103B0
        BSR.W  loc_010606                       ; $0103B2
        ADDQ.W  #4,$C87E.W                      ; $0103B6
        DC.W    $33FC,$0020,$00FF,$0008; $0103BA MOVE.W  #$0020,$00FF0008
        RTS                                     ; $0103C2
        CLR.W  D0                               ; $0103C4
        JSR     $00E52C(PC)                     ; $0103C6
        MOVEA.L $A01C.W,A0                      ; $0103CA
        BSR.W  loc_010796                       ; $0103CE
        JSR     $0088179E                       ; $0103D2
        CMPI.W  #$0001,$A036.W                  ; $0103D8
        BEQ.W  loc_010482                       ; $0103DE
        MOVE.W  $C86C.W,D1                      ; $0103E2
        BTST    #4,D1                           ; $0103E6
        BNE.W  loc_01044E                       ; $0103EA
        MOVE.W  D1,D2                           ; $0103EE
        DC.W    $0202,$00E0         ; $0103F0 ANDI.B  #$00E0,D2
        BEQ.W  loc_01047E                       ; $0103F4
        MOVE.B  #$0001,$A02C.W                  ; $0103F8
        MOVE.B  #$0000,$A02D.W                  ; $0103FE
        MOVE.B  #$00A8,$C8A4.W                  ; $010404
        BTST    #7,D1                           ; $01040A
        BNE.W  loc_010446                       ; $01040E
        MOVE.W  $A024.W,D0                      ; $010412
        CMPI.B  #$0003,D0                       ; $010416
        BEQ.W  loc_010446                       ; $01041A
        CMPI.B  #$0008,D0                       ; $01041E
        BEQ.W  loc_01044E                       ; $010422
        CLR.W  D1                               ; $010426
        MOVE.B  $A020.W,D1                      ; $010428
        MOVEA.L $A01C.W,A0                      ; $01042C
        MOVE.B  D0,$00(A0,D1.W)                 ; $010430
        ADDQ.B  #1,$A020.W                      ; $010434
        CMPI.B  #$0003,$A020.W                  ; $010438
        BGE.W  loc_010446                       ; $01043E
        BRA.W  loc_010494                       ; $010442
loc_010446:
        ADDQ.W  #4,$C87E.W                      ; $010446
        BRA.W  loc_010498                       ; $01044A
loc_01044E:
        CLR.W  D1                               ; $01044E
        MOVE.B  $A020.W,D1                      ; $010450
        MOVEA.L $A01C.W,A0                      ; $010454
        MOVE.B  #$0020,$00(A0,D1.W)             ; $010458
        TST.B  $A020.W                          ; $01045E
        BEQ.W  loc_010494                       ; $010462
        SUBQ.B  #1,$A020.W                      ; $010466
        CLR.W  D1                               ; $01046A
        MOVE.B  $A020.W,D1                      ; $01046C
        MOVEA.L $A01C.W,A0                      ; $010470
        MOVE.B  #$0020,$00(A0,D1.W)             ; $010474
        BRA.W  loc_010494                       ; $01047A
loc_01047E:
        BSR.W  loc_01084C                       ; $01047E
loc_010482:
        JSR     $0088FB36                       ; $010482
        BTST    #6,$C80E.W                      ; $010488
        BNE.S  loc_010494                       ; $01048E
        CLR.W  $A036.W                          ; $010490
loc_010494:
        SUBQ.W  #4,$C87E.W                      ; $010494
loc_010498:
        DC.W    $33FC,$0018,$00FF,$0008; $010498 MOVE.W  #$0018,$00FF0008
        RTS                                     ; $0104A0
        CLR.W  D0                               ; $0104A2
        JSR     $00E52C(PC)                     ; $0104A4
        JSR     $00B6DA(PC)                     ; $0104A8
        MOVEA.L #$06014000,A0                   ; $0104AC
        MOVEA.L #$24014034,A1                   ; $0104B2
        MOVE.W  #$00D8,D0                       ; $0104B8
        MOVE.W  #$0050,D1                       ; $0104BC
        JSR     $00E35A(PC)                     ; $0104C0
        TST.W  $A02E.W                          ; $0104C4
        BPL.S  loc_010506                       ; $0104C8
        MOVE.B  #$0001,$A02C.W                  ; $0104CA
        MOVE.B  #$0001,$A02D.W                  ; $0104D0
        SUBQ.W  #1,$A030.W                      ; $0104D6
        BCC.S  loc_010506                       ; $0104DA
        MOVE.W  #$0002,$A036.W                  ; $0104DC
        MOVE.B  #$0001,$C809.W                  ; $0104E2
        MOVE.B  #$0001,$C80A.W                  ; $0104E8
        BSET    #7,$C80E.W                      ; $0104EE
        MOVE.B  #$0001,$C802.W                  ; $0104F4
        JSR     $0088205E                       ; $0104FA
        MOVE.W  #$0BB8,$A030.W                  ; $010500
loc_010506:
        MOVEA.L $A018.W,A0                      ; $010506
        BTST    #0,$A014.W                      ; $01050A
        BNE.W  loc_010518                       ; $010510
        MOVEA.L $A01C.W,A0                      ; $010514
loc_010518:
        TST.B  $A02C.W                          ; $010518
        BEQ.W  loc_010540                       ; $01051C
        MOVEA.L A0,A4                           ; $010520
        CLR.W  D0                               ; $010522
        MOVE.B  (A0),D0                         ; $010524
        CMPI.B  #$0020,D0                       ; $010526
        BEQ.W  loc_010540                       ; $01052A
        CMPI.B  #$0003,D0                       ; $01052E
        BEQ.W  loc_010540                       ; $010532
        MOVEA.L #$24034060,A1                   ; $010536
        BSR.W  loc_010674                       ; $01053C
loc_010540:
        TST.B  $A02C.W                          ; $010540
        BEQ.W  loc_010568                       ; $010544
        MOVE.W  (A4),D0                         ; $010548
        ANDI.W  #$00FF,D0                       ; $01054A
        CMPI.B  #$0020,D0                       ; $01054E
        BEQ.W  loc_010568                       ; $010552
        CMPI.B  #$0003,D0                       ; $010556
        BEQ.W  loc_010568                       ; $01055A
        MOVEA.L #$24034090,A1                   ; $01055E
        BSR.W  loc_010674                       ; $010564
loc_010568:
        TST.B  $A02C.W                          ; $010568
        BEQ.W  loc_010592                       ; $01056C
        MOVE.B  $0002(A4),D0                    ; $010570
        ANDI.W  #$00FF,D0                       ; $010574
        CMPI.B  #$0020,D0                       ; $010578
        BEQ.W  loc_010592                       ; $01057C
        CMPI.B  #$0003,D0                       ; $010580
        BEQ.W  loc_010592                       ; $010584
        MOVEA.L #$240340C0,A1                   ; $010588
        BSR.W  loc_010674                       ; $01058E
loc_010592:
        CMPI.W  #$0002,$A036.W                  ; $010592
        BEQ.W  loc_0105BE                       ; $010598
        SUBQ.B  #1,$A02D.W                      ; $01059C
        BCC.S  loc_0105BA                       ; $0105A0
        BCHG    #0,$A02C.W                      ; $0105A2
        MOVE.B  #$0001,$A02D.W                  ; $0105A8
        BTST    #0,$A02C.W                      ; $0105AE
        BEQ.S  loc_0105BA                       ; $0105B4
        SUBQ.W  #1,$A02E.W                      ; $0105B6
loc_0105BA:
        BRA.W  loc_0105D4                       ; $0105BA
loc_0105BE:
        JSR     $0088FB36                       ; $0105BE
        BTST    #7,$C80E.W                      ; $0105C4
        BNE.S  loc_0105D4                       ; $0105CA
        CLR.W  $A036.W                          ; $0105CC
        ADDQ.W  #4,$C87E.W                      ; $0105D0
loc_0105D4:
        DC.W    $33FC,$0018,$00FF,$0008; $0105D4 MOVE.W  #$0018,$00FF0008
        RTS                                     ; $0105DC
loc_0105DE:
        TST.B  $00A15120                        ; $0105DE
        BNE.S  loc_0105DE                       ; $0105E4
        CLR.B  $00A15123                        ; $0105E6
        MOVE.W  #$0000,$C87E.W                  ; $0105EC
        DC.W    $33FC,$0020,$00FF,$0008; $0105F2 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0089,$09AE,$00FF,$0002; $0105FA MOVE.L  #$008909AE,$00FF0002
        RTS                                     ; $010604
loc_010606:
        MOVE.B  (A2)+,D3                        ; $010606
        BSR.W  loc_01063A                       ; $010608
        MOVE.W  #$000A,D1                       ; $01060C
        BSR.W  loc_010656                       ; $010610
        ADDQ.L  #8,A1                           ; $010614
        MOVE.B  (A2)+,D3                        ; $010616
        BSR.W  loc_01063A                       ; $010618
        MOVE.W  #$000B,D1                       ; $01061C
        BSR.W  loc_010656                       ; $010620
        ADDQ.L  #8,A1                           ; $010624
        MOVE.B  (A2)+,D1                        ; $010626
        ANDI.W  #$000F,D1                       ; $010628
        BSR.W  loc_010656                       ; $01062C
        ADDQ.L  #8,A1                           ; $010630
        MOVE.B  (A2)+,D3                        ; $010632
        BSR.W  loc_01063A                       ; $010634
        RTS                                     ; $010638
loc_01063A:
        MOVE.B  D3,D1                           ; $01063A
        LSR.B  #4,D1                            ; $01063C
        ANDI.W  #$000F,D1                       ; $01063E
        BSR.W  loc_010656                       ; $010642
        ADDQ.L  #8,A1                           ; $010646
        MOVE.W  D3,D1                           ; $010648
        ANDI.W  #$000F,D1                       ; $01064A
        BSR.W  loc_010656                       ; $01064E
        ADDQ.L  #8,A1                           ; $010652
        RTS                                     ; $010654
loc_010656:
        LSL.W  #6,D1                            ; $010656
        MOVE.W  D1,D0                           ; $010658
        LSL.W  #1,D1                            ; $01065A
        ADD.W  D0,D1                            ; $01065C
        MOVEA.L #$06023200,A0                   ; $01065E
        ADDA.W  D1,A0                           ; $010664
        MOVE.W  #$000C,D0                       ; $010666
        MOVE.W  #$0010,D1                       ; $01066A
        JSR     $00E35A(PC)                     ; $01066E
        RTS                                     ; $010672
loc_010674:
        CMPI.W  #$0020,D0                       ; $010674
        BEQ.W  loc_0106BC                       ; $010678
        CMPI.W  #$0008,D0                       ; $01067C
        BEQ.W  loc_0106C4                       ; $010680
        CMPI.W  #$0003,D0                       ; $010684
        BEQ.W  loc_0106CC                       ; $010688
        CMPI.W  #$002E,D0                       ; $01068C
        BEQ.W  loc_0106D4                       ; $010690
        CMPI.W  #$0021,D0                       ; $010694
        BEQ.W  loc_0106DC                       ; $010698
        CMPI.W  #$003F,D0                       ; $01069C
        BEQ.W  loc_0106B4                       ; $0106A0
        CMPI.W  #$005A,D0                       ; $0106A4
        BLE.W  loc_0106E4                       ; $0106A8
        CMPI.W  #$007A,D0                       ; $0106AC
        BLE.W  loc_0106EC                       ; $0106B0
loc_0106B4:
        MOVE.W  #$0036,D0                       ; $0106B4
        BRA.W  loc_0106F0                       ; $0106B8
loc_0106BC:
        MOVE.W  #$0037,D0                       ; $0106BC
        BRA.W  loc_0106F0                       ; $0106C0
loc_0106C4:
        MOVE.W  #$0038,D0                       ; $0106C4
        BRA.W  loc_0106F0                       ; $0106C8
loc_0106CC:
        MOVE.W  #$0039,D0                       ; $0106CC
        BRA.W  loc_0106F0                       ; $0106D0
loc_0106D4:
        MOVE.W  #$0034,D0                       ; $0106D4
        BRA.W  loc_0106F0                       ; $0106D8
loc_0106DC:
        MOVE.W  #$0035,D0                       ; $0106DC
        BRA.W  loc_0106F0                       ; $0106E0
loc_0106E4:
        SUBI.W  #$0041,D0                       ; $0106E4
        BRA.W  loc_0106F0                       ; $0106E8
loc_0106EC:
        SUBI.W  #$0047,D0                       ; $0106EC
loc_0106F0:
        ANDI.L  #$0000FFFF,D0                   ; $0106F0
        LSL.L  #6,D0                            ; $0106F6
        MOVE.L  D0,D1                           ; $0106F8
        LSL.L  #1,D0                            ; $0106FA
        ADD.L  D0,D1                            ; $0106FC
        LSL.L  #1,D0                            ; $0106FE
        ADD.L  D0,D1                            ; $010700
        LSL.L  #1,D0                            ; $010702
        ADD.L  D1,D0                            ; $010704
        MOVEA.L #$06024000,A0                   ; $010706
        ADDA.L  D0,A0                           ; $01070C
        MOVE.W  #$0018,D0                       ; $01070E
        MOVE.W  #$0028,D1                       ; $010712
        JSR     $00E35A(PC)                     ; $010716
        RTS                                     ; $01071A
loc_01071C:
        MOVEA.L #$06014000,A0                   ; $01071C
        MOVEA.L #$24014034,A1                   ; $010722
        MOVE.W  #$00D8,D0                       ; $010728
        MOVE.W  #$0050,D1                       ; $01072C
        JSR     $00E35A(PC)                     ; $010730
        MOVEA.L #$06019700,A0                   ; $010734
        MOVEA.L #$240080A0,A1                   ; $01073A
        MOVE.W  #$0058,D0                       ; $010740
        MOVE.W  #$0010,D1                       ; $010744
        JSR     $00E35A(PC)                     ; $010748
        MOVEA.L #$06019C80,A0                   ; $01074C
        MOVEA.L #$2400A0A0,A1                   ; $010752
        MOVE.W  #$0058,D0                       ; $010758
        MOVE.W  #$0010,D1                       ; $01075C
        JSR     $00E35A(PC)                     ; $010760
        MOVEA.L #$06019000,A0                   ; $010764
        MOVEA.L #$24008060,A1                   ; $01076A
        MOVE.W  #$0038,D0                       ; $010770
        MOVE.W  #$0020,D1                       ; $010774
        JSR     $00E35A(PC)                     ; $010778
        MOVEA.L #$0601A200,A0                   ; $01077C
        MOVEA.L #$24004C60,A1                   ; $010782
        MOVE.W  #$0080,D0                       ; $010788
        MOVE.W  #$0010,D1                       ; $01078C
        JSR     $00E35A(PC)                     ; $010790
        RTS                                     ; $010794
loc_010796:
        SUBQ.B  #1,$A02D.W                      ; $010796
        BCC.S  loc_0107A8                       ; $01079A
        BCHG    #0,$A02C.W                      ; $01079C
        MOVE.B  #$0000,$A02D.W                  ; $0107A2
loc_0107A8:
        TST.B  $A020.W                          ; $0107A8
        BEQ.W  loc_010804                       ; $0107AC
        CMPI.B  #$0001,$A020.W                  ; $0107B0
        BEQ.W  loc_01081E                       ; $0107B6
        MOVEA.L A0,A4                           ; $0107BA
        CLR.W  D0                               ; $0107BC
        MOVE.B  (A0),D0                         ; $0107BE
        CMPI.B  #$0020,D0                       ; $0107C0
        BEQ.W  loc_0107D2                       ; $0107C4
        MOVEA.L #$24034060,A1                   ; $0107C8
        BSR.W  loc_010674                       ; $0107CE
loc_0107D2:
        MOVE.W  (A4),D0                         ; $0107D2
        ANDI.W  #$00FF,D0                       ; $0107D4
        CMPI.B  #$0020,D0                       ; $0107D8
        BEQ.W  loc_0107EA                       ; $0107DC
        MOVEA.L #$24034090,A1                   ; $0107E0
        BSR.W  loc_010674                       ; $0107E6
loc_0107EA:
        TST.B  $A02C.W                          ; $0107EA
        BEQ.W  loc_01084A                       ; $0107EE
        MOVE.W  $A024.W,D0                      ; $0107F2
        MOVEA.L #$240340C0,A1                   ; $0107F6
        BSR.W  loc_010674                       ; $0107FC
        BRA.W  loc_01084A                       ; $010800
loc_010804:
        TST.B  $A02C.W                          ; $010804
        BEQ.W  loc_01084A                       ; $010808
        MOVE.W  $A024.W,D0                      ; $01080C
        MOVEA.L #$24034060,A1                   ; $010810
        BSR.W  loc_010674                       ; $010816
        BRA.W  loc_01084A                       ; $01081A
loc_01081E:
        CLR.W  D0                               ; $01081E
        MOVE.B  (A0),D0                         ; $010820
        CMPI.B  #$0020,D0                       ; $010822
        BEQ.W  loc_010834                       ; $010826
        MOVEA.L #$24034060,A1                   ; $01082A
        BSR.W  loc_010674                       ; $010830
loc_010834:
        TST.B  $A02C.W                          ; $010834
        BEQ.W  loc_01084A                       ; $010838
        MOVE.W  $A024.W,D0                      ; $01083C
        MOVEA.L #$24034090,A1                   ; $010840
        BSR.W  loc_010674                       ; $010846
loc_01084A:
        RTS                                     ; $01084A
loc_01084C:
        MOVE.W  D1,D2                           ; $01084C
        LSR.W  #8,D2                            ; $01084E
        CMP.B  $A02A.W,D2                       ; $010850
        BNE.W  loc_010872                       ; $010854
        ADDQ.B  #1,$A02B.W                      ; $010858
        CMPI.B  #$000F,$A02B.W                  ; $01085C
        BLT.W  loc_010876                       ; $010862
        MOVE.B  #$000C,$A02B.W                  ; $010866
        MOVE.W  D2,D1                           ; $01086C
        BRA.W  loc_010876                       ; $01086E
loc_010872:
        CLR.B  $A02B.W                          ; $010872
loc_010876:
        MOVE.B  D2,$A02A.W                      ; $010876
        BTST    #2,D1                           ; $01087A
        BEQ.S  loc_0108BA                       ; $01087E
        MOVE.B  #$0001,$A02C.W                  ; $010880
        MOVE.B  #$0000,$A02D.W                  ; $010886
        MOVE.B  #$00A9,$C8A4.W                  ; $01088C
        TST.W  $A026.W                          ; $010892
        BEQ.S  loc_0108B0                       ; $010896
        SUBQ.W  #1,$A026.W                      ; $010898
        CMPI.W  #$0033,$A026.W                  ; $01089C
        BNE.W  loc_010948                       ; $0108A2
        MOVE.W  #$0019,$A026.W                  ; $0108A6
        BRA.W  loc_010948                       ; $0108AC
loc_0108B0:
        MOVE.W  #$0039,$A026.W                  ; $0108B0
        BRA.W  loc_010948                       ; $0108B6
loc_0108BA:
        BTST    #3,D1                           ; $0108BA
        BEQ.S  loc_0108FA                       ; $0108BE
        MOVE.B  #$0001,$A02C.W                  ; $0108C0
        MOVE.B  #$0000,$A02D.W                  ; $0108C6
        MOVE.B  #$00A9,$C8A4.W                  ; $0108CC
        CMPI.W  #$0039,$A026.W                  ; $0108D2
        BGE.S  loc_0108F2                       ; $0108D8
        ADDQ.W  #1,$A026.W                      ; $0108DA
        CMPI.W  #$001A,$A026.W                  ; $0108DE
        BNE.W  loc_010948                       ; $0108E4
        MOVE.W  #$0034,$A026.W                  ; $0108E8
        BRA.W  loc_010948                       ; $0108EE
loc_0108F2:
        CLR.W  $A026.W                          ; $0108F2
        BRA.W  loc_010948                       ; $0108F6
loc_0108FA:
        BTST    #0,D1                           ; $0108FA
        BEQ.S  loc_010922                       ; $0108FE
        TST.W  $A028.W                          ; $010900
        BEQ.W  loc_010948                       ; $010904
        MOVE.B  #$0001,$A02C.W                  ; $010908
        MOVE.B  #$0000,$A02D.W                  ; $01090E
        CLR.W  $A028.W                          ; $010914
        MOVE.B  #$00A9,$C8A4.W                  ; $010918
        BRA.W  loc_010948                       ; $01091E
loc_010922:
        BTST    #1,D1                           ; $010922
        BEQ.S  loc_010948                       ; $010926
        TST.W  $A028.W                          ; $010928
        BNE.W  loc_010948                       ; $01092C
        MOVE.B  #$0001,$A02C.W                  ; $010930
        MOVE.B  #$0000,$A02D.W                  ; $010936
        MOVE.W  #$0001,$A028.W                  ; $01093C
        MOVE.B  #$00A9,$C8A4.W                  ; $010942
loc_010948:
        MOVE.W  $A026.W,D0                      ; $010948
        CMPI.W  #$0019,D0                       ; $01094C
        BGT.W  loc_010960                       ; $010950
        TST.W  $A028.W                          ; $010954
        BEQ.W  loc_010960                       ; $010958
        ADDI.W  #$001A,D0                       ; $01095C
loc_010960:
        LEA     $00890974,A0                    ; $010960
        MOVE.B  $00(A0,D0.W),D0                 ; $010966
        ANDI.W  #$00FF,D0                       ; $01096A
        MOVE.W  D0,$A024.W                      ; $01096E
        RTS                                     ; $010972
        DC.W    $4142               ; $010974 DC.W    $4142
        DC.W    $4344               ; $010976 DC.W    $4344
        DC.W    $4546               ; $010978 DC.W    $4546
        DC.W    $4748               ; $01097A DC.W    $4748
        DC.W    $494A               ; $01097C DC.W    $494A
        DC.W    $4B4C               ; $01097E DC.W    $4B4C
        DC.W    $4D4E               ; $010980 DC.W    $4D4E
        DC.W    $4F50               ; $010982 DC.W    $4F50
        SUBQ.W  #8,(A2)                         ; $010984
        SUBQ.W  #1,(A4)                         ; $010986
        SUBQ.W  #2,(A6)                         ; $010988
        SUBQ.W  #3,(A0)+                        ; $01098A
        SUBQ.W  #4,(A2)+                        ; $01098C
        BSR.S  loc_0109F2                       ; $01098E
        BLS.S  loc_0109F6                       ; $010990
        BCS.S  loc_0109FA                       ; $010992
        BEQ.S  loc_0109FE                       ; $010994
        BVS.S  loc_010A02                       ; $010996
        BMI.S  loc_010A06                       ; $010998
        BLT.S  loc_010A0A                       ; $01099A
        BLE.S  loc_010A0E                       ; $01099C
        MOVE.W  $74(A2,D7.W),$7576(A0)          ; $01099E
        MOVE.W  $797A.W,$2E21(A3)               ; $0109A4
        MOVE.W  -(A0),-(A7)                     ; $0109AA
        BTST    #28,D3                          ; $0109AC
        DC.W    $002C,$00FF,$0008   ; $0109B0 ORI.B  #$00FF,$0008(A4)
        MOVE.W  #$002C,$C87A.W                  ; $0109B6
        BCLR    #6,$C875.W                      ; $0109BC
        MOVE.W  $C874.W,(A5)                    ; $0109C2
        DC.W    $33FC,$0083,$00A1,$5100; $0109C6 MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $0109CE ANDI.B  #$00FC,$00A15181
        JSR     $008826C8                       ; $0109D6
        MOVE.L  #$000A0907,D0                   ; $0109DC
        JSR     $008814BE                       ; $0109E2
        MOVE.B  #$0001,$C80D.W                  ; $0109E8
        MOVEQ   #$00,D0                         ; $0109EE
        LEA     $8480.W,A0                      ; $0109F0
        MOVEQ   #$1F,D1                         ; $0109F4
loc_0109F6:
        MOVE.L  D0,(A0)+                        ; $0109F6
        DBRA    D1,loc_0109F6                   ; $0109F8
        LEA     $00FF7B80,A0                    ; $0109FC
loc_010A02:
        MOVEQ   #$7F,D1                         ; $010A02
loc_010A04:
        MOVE.L  D0,(A0)+                        ; $010A04
loc_010A06:
        DBRA    D1,loc_010A04                   ; $010A06
loc_010A0A:
        MOVE.L  #$60000002,(A5)                 ; $010A0A
        MOVE.W  #$17FF,D1                       ; $010A10
loc_010A14:
        MOVE.L  D0,(A6)                         ; $010A14
        DBRA    D1,loc_010A14                   ; $010A16
        JSR     $008849AA                       ; $010A1A
        CLR.W  $C880.W                          ; $010A20
        CLR.W  $C882.W                          ; $010A24
        CLR.W  $8000.W                          ; $010A28
        CLR.W  $8002.W                          ; $010A2C
        CLR.W  $A012.W                          ; $010A30
        CLR.B  $A018.W                          ; $010A34
        JSR     $008849AA                       ; $010A38
        DC.W    $21FC,$008B,$B4FC,$C96C; $010A3E MOVE.L  #$008BB4FC,$C96C.W
        MOVE.B  #$0001,$C809.W                  ; $010A46
        MOVE.B  #$0001,$C80A.W                  ; $010A4C
        BSET    #6,$C80E.W                      ; $010A52
        MOVE.B  #$0001,$C802.W                  ; $010A58
        MOVE.W  #$0001,$A05C.W                  ; $010A5E
        LEA     $00FF1000,A0                    ; $010A64
        MOVE.W  #$037F,D0                       ; $010A6A
loc_010A6E:
        CLR.L  (A0)+                            ; $010A6E
        DBRA    D0,loc_010A6E                   ; $010A70
        MOVE.W  #$0001,D0                       ; $010A74
        MOVE.W  #$0001,D1                       ; $010A78
        MOVE.W  #$0001,D2                       ; $010A7C
        MOVE.W  #$0026,D3                       ; $010A80
        MOVE.W  #$001A,D4                       ; $010A84
        LEA     $00FF1000,A0                    ; $010A88
        JSR     $00E22C(PC)                     ; $010A8E
        LEA     $00FF1000,A0                    ; $010A92
        JSR     $00E2F0(PC)                     ; $010A98
        JSR     $00E1BC(PC)                     ; $010A9C
        DC.W    $08B9,$0007,$00A1,$5181; $010AA0 BCLR    #7,$00A15181
        LEA     $00FF6E00,A0                    ; $010AA8
        ADDA.L  #$00000160,A0                   ; $010AAE
        LEA     $00891062,A1                    ; $010AB4
        MOVE.W  #$003F,D0                       ; $010ABA
loc_010ABE:
        MOVE.W  (A1)+,D1                        ; $010ABE
        BSET    #15,D1                          ; $010AC0
        MOVE.W  D1,(A0)+                        ; $010AC4
        DBRA    D0,loc_010ABE                   ; $010AC6
        BTST    #4,$C80E.W                      ; $010ACA
        BEQ.W  loc_010AF6                       ; $010AD0
        LEA     $00FF6E00,A0                    ; $010AD4
        ADDA.L  #$00000180,A0                   ; $010ADA
        LEA     $008910E2,A1                    ; $010AE0
        MOVE.W  #$000F,D0                       ; $010AE6
loc_010AEA:
        MOVE.W  (A1)+,D1                        ; $010AEA
        BSET    #15,D1                          ; $010AEC
        MOVE.W  D1,(A0)+                        ; $010AF0
        DBRA    D0,loc_010AEA                   ; $010AF2
loc_010AF6:
        LEA     $000EC980,A0                    ; $010AF6
        MOVEA.L #$06018000,A1                   ; $010AFC
        JSR     $00E316(PC)                     ; $010B02
        LEA     $000ECC90,A0                    ; $010B06
        MOVEA.L #$06018500,A1                   ; $010B0C
        JSR     $00E316(PC)                     ; $010B12
        LEA     $000ECE20,A0                    ; $010B16
        MOVEA.L #$06018C00,A1                   ; $010B1C
        JSR     $00E316(PC)                     ; $010B22
        BTST    #4,$C80E.W                      ; $010B26
        BEQ.W  loc_010B40                       ; $010B2C
        LEA     $000ECAB0,A0                    ; $010B30
        MOVEA.L #$06018F80,A1                   ; $010B36
        JSR     $00E316(PC)                     ; $010B3C
loc_010B40:
        LEA     $000EBB40,A0                    ; $010B40
        MOVEA.L #$0601AD00,A1                   ; $010B46
        JSR     $00E316(PC)                     ; $010B4C
        LEA     $000EB980,A0                    ; $010B50
        MOVEA.L #$0601DF00,A1                   ; $010B56
        JSR     $00E316(PC)                     ; $010B5C
        MOVEQ   #$00,D0                         ; $010B60
        MOVE.B  $FEB1.W,D0                      ; $010B62
        BTST    #5,$C80E.W                      ; $010B66
        BEQ.W  loc_010B74                       ; $010B6C
        MOVE.B  $FEB2.W,D0                      ; $010B70
loc_010B74:
        BTST    #4,$C80E.W                      ; $010B74
        BEQ.W  loc_010B82                       ; $010B7A
        MOVE.B  $FEB3.W,D0                      ; $010B7E
loc_010B82:
        ADD.L  D0,D0                            ; $010B82
        ADD.L  D0,D0                            ; $010B84
        LEA     $0089103E,A0                    ; $010B86
        MOVEA.L $00(A0,D0.W),A0                 ; $010B8C
        MOVEA.L #$0601E8C0,A1                   ; $010B90
        JSR     $00E316(PC)                     ; $010B96
        MOVEQ   #$00,D0                         ; $010B9A
        MOVE.B  $FEA5.W,D0                      ; $010B9C
        BTST    #5,$C80E.W                      ; $010BA0
        BEQ.W  loc_010BAE                       ; $010BA6
        MOVE.B  $FEA7.W,D0                      ; $010BAA
loc_010BAE:
        BTST    #4,$C80E.W                      ; $010BAE
        BEQ.W  loc_010BBC                       ; $010BB4
        MOVE.B  $FEAB.W,D0                      ; $010BB8
loc_010BBC:
        ADD.L  D0,D0                            ; $010BBC
        ADD.L  D0,D0                            ; $010BBE
        LEA     $0089104A,A0                    ; $010BC0
        MOVEA.L $00(A0,D0.W),A0                 ; $010BC6
        MOVEA.L #$0601EE40,A1                   ; $010BCA
        JSR     $00E316(PC)                     ; $010BD0
        LEA     $000EDE10,A0                    ; $010BD4
        MOVEA.L #$06010000,A1                   ; $010BDA
        JSR     $00E316(PC)                     ; $010BE0
        MOVE.B  #$0000,$A019.W                  ; $010BE4
        MOVE.B  #$0000,$A01A.W                  ; $010BEA
        MOVE.B  #$0002,$A01C.W                  ; $010BF0
        DC.W    $21FC,$0000,$0000,$A022; $010BF6 MOVE.L  #$00000000,$A022.W
        DC.W    $21FC,$0000,$0000,$A026; $010BFE MOVE.L  #$00000000,$A026.W
        MOVE.B  #$0000,$A02E.W                  ; $010C06
        DC.W    $21FC,$0000,$0000,$A032; $010C0C MOVE.L  #$00000000,$A032.W
        DC.W    $21FC,$0000,$0000,$A036; $010C14 MOVE.L  #$00000000,$A036.W
        MOVE.B  #$0000,$A03E.W                  ; $010C1C
        CLR.W  $A050.W                          ; $010C22
        MOVE.W  #$0010,$A052.W                  ; $010C26
        MOVEQ   #$00,D0                         ; $010C2C
        MOVE.B  $FEA8.W,D0                      ; $010C2E
        LEA     $00891102,A0                    ; $010C32
        BTST    #5,$C80E.W                      ; $010C38
        BNE.S  loc_010C56                       ; $010C3E
        MOVE.B  $FEAC.W,D0                      ; $010C40
        LEA     $00891112,A0                    ; $010C44
        BTST    #4,$C80E.W                      ; $010C4A
        BNE.S  loc_010C56                       ; $010C50
        MOVE.B  #$0000,D0                       ; $010C52
loc_010C56:
        ADD.W  D0,D0                            ; $010C56
        ADD.W  D0,D0                            ; $010C58
        MOVE.L  $00(A0,D0.W),$A02A.W            ; $010C5A
        MOVE.L  $00(A0,D0.W),$A03A.W            ; $010C60
        CLR.L  $A046.W                          ; $010C66
        LEA     $A046.W,A0                      ; $010C6A
        LEA     $C200.W,A1                      ; $010C6E
        MOVE.W  #$0013,D2                       ; $010C72
loc_010C76:
        ADDI.B  #$0000,D0                       ; $010C76
        MOVE.B  $0003(A0),D0                    ; $010C7A
        MOVE.B  $0003(A1),D1                    ; $010C7E
        AND.B  D0,D1                            ; $010C82
        MOVE.B  D0,$0003(A0)                    ; $010C84
        MOVE.B  $0002(A0),D0                    ; $010C88
        MOVE.B  $0002(A1),D1                    ; $010C8C
        AND.B  D0,D1                            ; $010C90
        MOVE.B  D0,D1                           ; $010C92
        DC.W    $0200,$000F         ; $010C94 ANDI.B  #$000F,D0
        MOVE.B  D0,$0002(A0)                    ; $010C98
        LSR.B  #4,D1                            ; $010C9C
        ADDI.B  #$0000,D0                       ; $010C9E
        MOVE.B  $0001(A0),D0                    ; $010CA2
        AND.B  D0,D1                            ; $010CA6
        MOVE.B  $0001(A1),D1                    ; $010CA8
        AND.B  D0,D1                            ; $010CAC
        BCC.W  loc_010CC2                       ; $010CAE
        ADDI.B  #$0000,D0                       ; $010CB2
        MOVE.B  #$0040,D1                       ; $010CB6
        AND.B  D0,D1                            ; $010CBA
        MOVE.B  #$0001,D1                       ; $010CBC
        BRA.S  loc_010CDA                       ; $010CC0
loc_010CC2:
        CLR.B  D1                               ; $010CC2
        CMPI.B  #$0060,D0                       ; $010CC4
        BCS.W  loc_010CDA                       ; $010CC8
        ADDI.B  #$0000,D0                       ; $010CCC
        MOVE.B  #$0060,D1                       ; $010CD0
        OR.B   D0,D1                            ; $010CD4
        MOVE.B  #$0001,D1                       ; $010CD6
loc_010CDA:
        MOVE.B  D0,$0001(A0)                    ; $010CDA
        ADDI.B  #$0000,D0                       ; $010CDE
        MOVE.B  (A0),D0                         ; $010CE2
        AND.B  D0,D1                            ; $010CE4
        MOVE.B  (A1),D1                         ; $010CE6
        AND.B  D0,D1                            ; $010CE8
        MOVE.B  D0,(A0)                         ; $010CEA
        ADDQ.L  #4,A1                           ; $010CEC
        DBRA    D2,loc_010C76                   ; $010CEE
        TST.L  $A046.W                          ; $010CF2
        BNE.S  loc_010D00                       ; $010CF6
        DC.W    $21FC,$CCCC,$0CCC,$A046; $010CF8 MOVE.L  #$CCCC0CCC,$A046.W
loc_010D00:
        LEA     $C200.W,A0                      ; $010D00
        MOVE.W  #$0013,D0                       ; $010D04
loc_010D08:
        TST.L  (A0)                             ; $010D08
        BEQ.W  loc_010D16                       ; $010D0A
        ADDQ.L  #4,A0                           ; $010D0E
        DBRA    D0,loc_010D08                   ; $010D10
        BRA.S  loc_010D20                       ; $010D14
loc_010D16:
        MOVE.L  #$CCCC0CCC,(A0)+                ; $010D16
        DBRA    D0,loc_010D16                   ; $010D1C
loc_010D20:
        MOVE.W  #$0000,$A042.W                  ; $010D20
        LEA     $C200.W,A0                      ; $010D26
        MOVE.L  $0010(A0),D0                    ; $010D2A
        CMPI.L  #$CCCC0CCC,D0                   ; $010D2E
        BNE.S  loc_010D3C                       ; $010D34
        MOVE.W  #$0001,$A042.W                  ; $010D36
loc_010D3C:
        MOVEQ   #$00,D2                         ; $010D3C
        MOVE.L  D2,$A01E.W                      ; $010D3E
        LEA     $C200.W,A0                      ; $010D42
        MOVE.L  #$60000000,D0                   ; $010D46
        MOVE.W  #$0013,D3                       ; $010D4C
loc_010D50:
        MOVE.L  (A0)+,D1                        ; $010D50
        BEQ.S  loc_010D66                       ; $010D52
        CMPI.L  #$CCCC0CCC,D1                   ; $010D54
        BEQ.S  loc_010D66                       ; $010D5A
        CMP.L  D1,D0                            ; $010D5C
        BLE.S  loc_010D66                       ; $010D5E
        MOVE.L  D1,D0                           ; $010D60
        MOVE.L  D2,$A01E.W                      ; $010D62
loc_010D66:
        ADDI.L  #$00000D80,D2                   ; $010D66
        DBRA    D3,loc_010D50                   ; $010D6C
loc_010D70:
        TST.B  $00A15120                        ; $010D70
        BNE.S  loc_010D70                       ; $010D76
        DC.W    $23FC,$0602,$0000,$00A1,$5128; $010D78 MOVE.L  #$06020000,$00A15128
        DC.W    $13FC,$0026,$00A1,$5121; $010D82 MOVE.B  #$0026,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $010D8A MOVE.B  #$0001,$00A15120
        BTST    #4,$C80E.W                      ; $010D92
        BNE.W  loc_010E7E                       ; $010D98
        MOVEA.L #$0601AD00,A0                   ; $010D9C
        MOVEA.L #$06028000,A1                   ; $010DA2
        MOVE.W  #$0028,D0                       ; $010DA8
        MOVE.W  #$0140,D1                       ; $010DAC
        MOVE.W  #$00D8,D2                       ; $010DB0
        JSR     loc_011A98(PC)                  ; $010DB4
        MOVEQ   #$00,D3                         ; $010DB8
        MOVEQ   #$00,D4                         ; $010DBA
        MOVE.W  #$0013,D5                       ; $010DBC
loc_010DC0:
        MOVEA.L #$06028030,A1                   ; $010DC0
        ADDA.L  D3,A1                           ; $010DC6
        ADDI.L  #$00000D80,D3                   ; $010DC8
        LEA     $C200.W,A2                      ; $010DCE
        ADDA.L  D4,A2                           ; $010DD2
        ADDQ.L  #4,D4                           ; $010DD4
        MOVE.W  #$00D8,D2                       ; $010DD6
        JSR     loc_011942(PC)                  ; $010DDA
        DBRA    D5,loc_010DC0                   ; $010DDE
        DC.W    $0CB8,$6100,$0000,$C254; $010DE2 CMPI.L  #$61000000,$C254.W
        BEQ.W  loc_010E7A                       ; $010DEA
        LEA     $C200.W,A2                      ; $010DEE
        MOVE.L  #$60000000,D1                   ; $010DF2
        CLR.W  D3                               ; $010DF8
        MOVE.W  #$0001,D2                       ; $010DFA
        MOVE.W  #$0013,D4                       ; $010DFE
loc_010E02:
        MOVE.L  (A2)+,D0                        ; $010E02
        CMPI.L  #$CCCC0CCC,D0                   ; $010E04
        BEQ.S  loc_010E14                       ; $010E0A
        CMP.L  D1,D0                            ; $010E0C
        BCC.S  loc_010E14                       ; $010E0E
        MOVE.L  D0,D1                           ; $010E10
        MOVE.W  D2,D3                           ; $010E12
loc_010E14:
        ADDQ.W  #1,D2                           ; $010E14
        DBRA    D4,loc_010E02                   ; $010E16
        TST.W  D3                               ; $010E1A
        BEQ.S  loc_010E54                       ; $010E1C
        MOVEA.L #$06028030,A0                   ; $010E1E
        SUBQ.W  #1,D3                           ; $010E24
        ANDI.L  #$0000FFFF,D3                   ; $010E26
        LSL.L  #7,D3                            ; $010E2C
        MOVE.L  D3,D4                           ; $010E2E
        LSL.L  #1,D3                            ; $010E30
        ADD.L  D3,D4                            ; $010E32
        LSL.L  #2,D3                            ; $010E34
        ADD.L  D3,D4                            ; $010E36
        LSL.L  #1,D3                            ; $010E38
        ADD.L  D4,D3                            ; $010E3A
        ADDA.L  D3,A0                           ; $010E3C
        MOVE.W  #$0078,D0                       ; $010E3E
        MOVE.W  #$0010,D1                       ; $010E42
        MOVE.W  #$0008,D2                       ; $010E46
        MOVE.W  #$00D8,D3                       ; $010E4A
        JSR     $0088E406                       ; $010E4E
loc_010E54:
        MOVEA.L #$06019D00,A0                   ; $010E54
        MOVEA.L #$06028088,A1                   ; $010E5A
        ADDA.L  $A01E.W,A1                      ; $010E60
        MOVE.W  #$0050,D0                       ; $010E64
        MOVE.W  #$0010,D1                       ; $010E68
        MOVE.W  #$00D8,D2                       ; $010E6C
        ADDI.L  #$00000D80,D3                   ; $010E70
        JSR     loc_011A98(PC)                  ; $010E76
loc_010E7A:
        BRA.W  loc_010FC8                       ; $010E7A
loc_010E7E:
        MOVEA.L #$0601AD00,A0                   ; $010E7E
        MOVEA.L #$06028000,A1                   ; $010E84
        MOVE.W  #$0028,D0                       ; $010E8A
        MOVE.W  #$0140,D1                       ; $010E8E
        MOVE.W  #$0080,D2                       ; $010E92
        JSR     loc_011A98(PC)                  ; $010E96
        MOVEQ   #$00,D3                         ; $010E9A
        MOVEQ   #$00,D4                         ; $010E9C
        MOVE.W  #$0013,D5                       ; $010E9E
loc_010EA2:
        MOVEA.L #$06028030,A1                   ; $010EA2
        ADDA.L  D3,A1                           ; $010EA8
        ADDI.L  #$00000800,D3                   ; $010EAA
        LEA     $C200.W,A2                      ; $010EB0
        ADDA.L  D4,A2                           ; $010EB4
        ADDQ.L  #4,D4                           ; $010EB6
        MOVE.W  #$0080,D2                       ; $010EB8
        JSR     loc_011942(PC)                  ; $010EBC
        DBRA    D5,loc_010EA2                   ; $010EC0
        LEA     $C200.W,A2                      ; $010EC4
        MOVE.L  #$60000000,D1                   ; $010EC8
        CLR.W  D3                               ; $010ECE
        MOVE.W  #$0001,D2                       ; $010ED0
        MOVE.W  #$0013,D4                       ; $010ED4
loc_010ED8:
        MOVE.L  (A2)+,D0                        ; $010ED8
        CMPI.L  #$CCCC0CCC,D0                   ; $010EDA
        BEQ.S  loc_010EEA                       ; $010EE0
        CMP.L  D1,D0                            ; $010EE2
        BCC.S  loc_010EEA                       ; $010EE4
        MOVE.L  D0,D1                           ; $010EE6
        MOVE.W  D2,D3                           ; $010EE8
loc_010EEA:
        ADDQ.W  #1,D2                           ; $010EEA
        DBRA    D4,loc_010ED8                   ; $010EEC
        TST.W  D3                               ; $010EF0
        BEQ.S  loc_010F1E                       ; $010EF2
        MOVEA.L #$06028000,A0                   ; $010EF4
        SUBQ.W  #1,D3                           ; $010EFA
        ANDI.L  #$0000FFFF,D3                   ; $010EFC
        LSL.L  #8,D3                            ; $010F02
        LSL.L  #3,D3                            ; $010F04
        ADDA.L  D3,A0                           ; $010F06
        MOVE.W  #$0080,D0                       ; $010F08
        MOVE.W  #$0010,D1                       ; $010F0C
        MOVE.W  #$0008,D2                       ; $010F10
        MOVE.W  #$0080,D3                       ; $010F14
        JSR     $0088E406                       ; $010F18
loc_010F1E:
        BSR.W  loc_011B6A                       ; $010F1E
        MOVEA.L #$2601AD00,A0                   ; $010F22
        MOVEA.L #$26032000,A1                   ; $010F28
        MOVE.W  #$0028,D0                       ; $010F2E
        MOVE.W  #$0140,D1                       ; $010F32
        MOVE.W  #$0080,D2                       ; $010F36
        JSR     loc_011A98(PC)                  ; $010F3A
        MOVEQ   #$00,D3                         ; $010F3E
        MOVEQ   #$00,D4                         ; $010F40
        MOVE.W  #$0013,D5                       ; $010F42
loc_010F46:
        MOVEA.L #$06032030,A1                   ; $010F46
        ADDA.L  D3,A1                           ; $010F4C
        ADDI.L  #$00000800,D3                   ; $010F4E
        LEA     $C200.W,A2                      ; $010F54
        ADDA.L  D4,A2                           ; $010F58
        ADDQ.L  #4,D4                           ; $010F5A
        MOVE.W  #$0080,D2                       ; $010F5C
        JSR     loc_011942(PC)                  ; $010F60
        DBRA    D5,loc_010F46                   ; $010F64
        LEA     $C200.W,A2                      ; $010F68
        MOVE.L  #$60000000,D1                   ; $010F6C
        CLR.W  D3                               ; $010F72
        MOVE.W  #$0001,D2                       ; $010F74
        MOVE.W  #$0013,D4                       ; $010F78
loc_010F7C:
        MOVE.L  (A2)+,D0                        ; $010F7C
        CMPI.L  #$CCCC0CCC,D0                   ; $010F7E
        BEQ.S  loc_010F8E                       ; $010F84
        CMP.L  D1,D0                            ; $010F86
        BCC.S  loc_010F8E                       ; $010F88
        MOVE.L  D0,D1                           ; $010F8A
        MOVE.W  D2,D3                           ; $010F8C
loc_010F8E:
        ADDQ.W  #1,D2                           ; $010F8E
        DBRA    D4,loc_010F7C                   ; $010F90
        TST.W  D3                               ; $010F94
        BEQ.S  loc_010FC2                       ; $010F96
        MOVEA.L #$06032000,A0                   ; $010F98
        SUBQ.W  #1,D3                           ; $010F9E
        ANDI.L  #$0000FFFF,D3                   ; $010FA0
        LSL.L  #8,D3                            ; $010FA6
        LSL.L  #3,D3                            ; $010FA8
        ADDA.L  D3,A0                           ; $010FAA
        MOVE.W  #$0080,D0                       ; $010FAC
        MOVE.W  #$0010,D1                       ; $010FB0
        MOVE.W  #$0008,D2                       ; $010FB4
        MOVE.W  #$0080,D3                       ; $010FB8
        JSR     $0088E406                       ; $010FBC
loc_010FC2:
        JSR     $0088204A                       ; $010FC2
loc_010FC8:
        MOVE.B  #$0001,$C821.W                  ; $010FC8
        DC.W    $0239,$00FC,$00A1,$5181; $010FCE ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $010FD6 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $010FDE MOVE.W  #$8083,$00A15100
        BSET    #6,$C875.W                      ; $010FE6
        MOVE.W  $C874.W,(A5)                    ; $010FEC
        DC.W    $33FC,$0018,$00FF,$0008; $010FF0 MOVE.W  #$0018,$00FF0008
        JSR     $00884998                       ; $010FF8
        MOVE.W  #$0000,$C87E.W                  ; $010FFE
        DC.W    $23FC,$0089,$1166,$00FF,$0002; $011004 MOVE.L  #$00891166,$00FF0002
        BTST    #4,$C80E.W                      ; $01100E
        BNE.W  loc_011036                       ; $011014
        DC.W    $23FC,$0089,$1142,$00FF,$0002; $011018 MOVE.L  #$00891142,$00FF0002
        BTST    #5,$C80E.W                      ; $011022
        BNE.W  loc_011036                       ; $011028
        DC.W    $23FC,$0089,$1122,$00FF,$0002; $01102C MOVE.L  #$00891122,$00FF0002
loc_011036:
        MOVE.B  #$008E,$C8A5.W                  ; $011036
        RTS                                     ; $01103C
        DC.W    $000E,$D310         ; $01103E ORI.B  #$D310,A6
        DC.W    $000E,$D440         ; $011042 ORI.B  #$D440,A6
        DC.W    $000E,$D530         ; $011046 ORI.B  #$D530,A6
        DC.W    $000E,$D670         ; $01104A ORI.B  #$D670,A6
        DC.W    $000E,$D7D0         ; $01104E ORI.B  #$D7D0,A6
        DC.W    $000E,$D930         ; $011052 ORI.B  #$D930,A6
        DC.W    $000E,$DA70         ; $011056 ORI.B  #$DA70,A6
        DC.W    $000E,$DBA0         ; $01105A ORI.B  #$DBA0,A6
        DC.W    $000E,$DD10         ; $01105E ORI.B  #$DD10,A6
        NEG.B  D0                               ; $011062
        NEG.L  -(A3)                            ; $011064
        DC.W    $4946               ; $011066 DC.W    $4946
        LEA     $1C00(A1),A6                    ; $011068
        MOVE.L  -(A3),(A4)                      ; $01106C
        MOVE.W  D6,$41E9(A2)                    ; $01106E
        DC.W    $0010,$14AF         ; $011072 ORI.B  #$14AF,(A0)
        MOVE.L  A6,$3DED(A4)                    ; $011076
        MOVE.B  D0,D6                           ; $01107A
        MOVE.L  -(A3),(A4)                      ; $01107C
        MOVE.W  D6,$41E9(A2)                    ; $01107E
        NEG.B  D0                               ; $011082
        NEG.L  -(A3)                            ; $011084
        DC.W    $4946               ; $011086 DC.W    $4946
        LEA     $7FFF(A1),A6                    ; $011088
        BLS.S  loc_011083                       ; $01108C
        DC.W    $7FFF               ; $01108E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011090 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $011092 ORI.B  #$14AF,(A0)
        MOVE.L  A6,$3DED(A4)                    ; $011096
        DC.W    $7FFF               ; $01109A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01109C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01109E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A8 MOVE.W  <EA:3F>,<EA:3F>
loc_0110AA:
        NEG.W  D5                               ; $0110AA
        SUBQ.B  #8,$6212(A3)                    ; $0110AC
        BGT.S  loc_0110AA                       ; $0110B0
        DC.W    $7FFF               ; $0110B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0E9A               ; $0110B4 DC.W    $0E9A
        DC.W    $7FFF               ; $0110B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $0110C2 ORI.B  #$14AF,(A0)
        MOVE.L  A6,$3DED(A4)                    ; $0110C6
loc_0110CA:
        NEG.W  D5                               ; $0110CA
        SUBQ.B  #8,$6212(A3)                    ; $0110CC
        BGT.S  loc_0110CA                       ; $0110D0
        DC.W    $7FFF               ; $0110D2 MOVE.W  <EA:3F>,<EA:3F>
        BTST    D1,(A7)+                        ; $0110D4
        DC.W    $7FFF               ; $0110D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110E0 MOVE.W  <EA:3F>,<EA:3F>
        NEG.B  D0                               ; $0110E2
        NEG.L  -(A3)                            ; $0110E4
        DC.W    $4946               ; $0110E6 DC.W    $4946
        LEA     $4445(A1),A6                    ; $0110E8
        NEG    D6                               ; $0110EC
        DC.W    $4968               ; $0110EE DC.W    $4968
        LEA     $7FFF(A2),A6                    ; $0110F0
        BLS.S  loc_0110EB                       ; $0110F4
        DC.W    $7FFF               ; $0110F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011100 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0000,$0000         ; $011102 ORI.B  #$0000,D0
        DC.W    $0000,$4380         ; $011106 ORI.B  #$4380,D0
        DC.W    $0000,$8700         ; $01110A ORI.B  #$8700,D0
        DC.W    $0000,$CA80         ; $01110E ORI.B  #$CA80,D0
        DC.W    $0000,$0000         ; $011112 ORI.B  #$0000,D0
        DC.W    $0000,$2800         ; $011116 ORI.B  #$2800,D0
        DC.W    $0000,$5000         ; $01111A ORI.B  #$5000,D0
        DC.W    $0000,$7800         ; $01111E ORI.B  #$7800,D0
        JSR     $00882080                       ; $011122
        MOVE.W  $C87E.W,D0                      ; $011128
        MOVEA.L $04(PC,D0.W),A1                 ; $01112C
        JMP     (A1)                            ; $011130
        ORI.L  #$11A40089,A1                    ; $011132
        MOVE.B  -(A4),-$77(A0,D0.W)             ; $011138
        MOVEA.B D0,A1                           ; $01113C
        ORI.L  #$17F44EB9,A1                    ; $01113E
        ORI.L  #$20803038,A0                    ; $011144
        DC.W    $C87E               ; $01114A AND.W  <EA:3E>,D4
        MOVEA.L $04(PC,D0.W),A1                 ; $01114C
        JMP     (A1)                            ; $011150
        ORI.L  #$11A40089,A1                    ; $011152
        MOVE.B  -(A4),-$77(A0,D0.W)             ; $011158
        MOVE.B  (A2)+,D2                        ; $01115C
        ORI.L  #$146E0089,A1                    ; $01115E
        MOVEA.B -(A2),A4                        ; $011164
        JSR     $00882080                       ; $011166
        MOVE.W  $C87E.W,D0                      ; $01116C
        MOVEA.L $04(PC,D0.W),A1                 ; $011170
        JMP     (A1)                            ; $011174
        ORI.L  #$11A40089,A1                    ; $011176
        MOVE.B  -(A4),-$77(A0,D0.W)             ; $01117C
        MOVE.B  -$77(A6,D0.W),-$4A(A0,D1.W)     ; $011180
        ORI.L  #$15A80089,A1                    ; $011186
        MOVE.B  -$77(A0,D0.W),D3                ; $01118C
        MOVE.B  A2,(A4)                         ; $011190
        JSR     $00B684(PC)                     ; $011192
        BTST    #6,$C80E.W                      ; $011196
        BNE.S  loc_0111A2                       ; $01119C
        ADDQ.W  #4,$C87E.W                      ; $01119E
loc_0111A2:
        RTS                                     ; $0111A2
        JSR     loc_011B08(PC)                  ; $0111A4
        ADDQ.W  #4,$C87E.W                      ; $0111A8
        DC.W    $33FC,$0018,$00FF,$0008; $0111AC MOVE.W  #$0018,$00FF0008
        RTS                                     ; $0111B4
        MOVEA.L #$06018F80,A0                   ; $0111B6
        MOVEA.L #$0400D018,A1                   ; $0111BC
        MOVE.W  #$0078,D0                       ; $0111C2
        MOVE.W  #$0018,D1                       ; $0111C6
        JSR     $00E35A(PC)                     ; $0111CA
        MOVEA.L #$06019AC0,A0                   ; $0111CE
        MOVEA.L #$0400D0A0,A1                   ; $0111D4
        MOVE.W  #$0078,D0                       ; $0111DA
        MOVE.W  #$0018,D1                       ; $0111DE
        JSR     $00E35A(PC)                     ; $0111E2
        LEA     $0403B048,A1                    ; $0111E6
        LEA     $A046.W,A2                      ; $0111EC
        JSR     loc_0118D4(PC)                  ; $0111F0
        LEA     $0403B0D0,A1                    ; $0111F4
        LEA     $A04A.W,A2                      ; $0111FA
        JSR     loc_0118D4(PC)                  ; $0111FE
        MOVEA.L #$06018C00,A0                   ; $011202
        MOVEA.L #$0401B010,A1                   ; $011208
        MOVE.W  #$0038,D0                       ; $01120E
        MOVE.W  #$0010,D1                       ; $011212
        JSR     $00E35A(PC)                     ; $011216
        MOVEA.L #$06018C00,A0                   ; $01121A
        MOVEA.L #$0401B098,A1                   ; $011220
        MOVE.W  #$0038,D0                       ; $011226
        MOVE.W  #$0010,D1                       ; $01122A
        JSR     $00E35A(PC)                     ; $01122E
        ADDQ.W  #4,$C87E.W                      ; $011232
        DC.W    $33FC,$0018,$00FF,$0008; $011236 MOVE.W  #$0018,$00FF0008
        RTS                                     ; $01123E
        CLR.W  D0                               ; $011240
        JSR     $00E52C(PC)                     ; $011242
        JSR     $00B684(PC)                     ; $011246
        JSR     $00B6DA(PC)                     ; $01124A
        MOVEA.L #$06018F80,A0                   ; $01124E
        MOVEA.L #$0400E038,A1                   ; $011254
        MOVE.W  #$00D8,D0                       ; $01125A
        MOVE.W  #$0010,D1                       ; $01125E
        JSR     $00E35A(PC)                     ; $011262
        MOVEA.L #$06028000,A0                   ; $011266
        MOVEA.L #$04010038,A1                   ; $01126C
        MOVE.W  #$00D8,D0                       ; $011272
        MOVE.W  #$0050,D1                       ; $011276
        JSR     $00E35A(PC)                     ; $01127A
        LEA     $0402C090,A1                    ; $01127E
        LEA     $A046.W,A2                      ; $011284
        JSR     loc_0118D4(PC)                  ; $011288
        MOVEA.L #$06018C00,A0                   ; $01128C
        MOVEA.L #$0400C048,A1                   ; $011292
        MOVE.W  #$0038,D0                       ; $011298
        MOVE.W  #$0010,D1                       ; $01129C
        JSR     $00E35A(PC)                     ; $0112A0
        TST.W  $A042.W                          ; $0112A4
        BNE.W  loc_0112F4                       ; $0112A8
        MOVEA.L #$0601A200,A0                   ; $0112AC
        MOVEA.L #$0401B030,A1                   ; $0112B2
        MOVE.W  #$0080,D0                       ; $0112B8
        MOVE.W  #$0010,D1                       ; $0112BC
        JSR     $00E35A(PC)                     ; $0112C0
        MOVEA.L #$0601AA00,A0                   ; $0112C4
        MOVEA.L #$0401B0D0,A1                   ; $0112CA
        MOVE.W  #$0018,D0                       ; $0112D0
        MOVE.W  #$0010,D1                       ; $0112D4
        JSR     $00E35A(PC)                     ; $0112D8
        MOVEA.L #$0601AB80,A0                   ; $0112DC
        MOVEA.L #$0401B100,A1                   ; $0112E2
        MOVE.W  #$0018,D0                       ; $0112E8
        MOVE.W  #$0010,D1                       ; $0112EC
        JSR     $00E35A(PC)                     ; $0112F0
loc_0112F4:
        CMPI.W  #$0001,$A05C.W                  ; $0112F4
        BEQ.W  loc_0113DC                       ; $0112FA
        CMPI.W  #$0002,$A05C.W                  ; $0112FE
        BEQ.W  loc_0113F2                       ; $011304
        JSR     $0088179E                       ; $011308
        MOVE.W  $C86C.W,D1                      ; $01130E
        MOVE.W  D1,D2                           ; $011312
        DC.W    $0202,$00E0         ; $011314 ANDI.B  #$00E0,D2
        BEQ.S  loc_011348                       ; $011318
        MOVE.B  #$00A8,$C8A4.W                  ; $01131A
        MOVE.B  #$0001,$C809.W                  ; $011320
        MOVE.B  #$0001,$C80A.W                  ; $011326
        BSET    #7,$C80E.W                      ; $01132C
        MOVE.B  #$0001,$C802.W                  ; $011332
        JSR     $0088205E                       ; $011338
        MOVE.W  #$0002,$A05C.W                  ; $01133E
        BRA.W  loc_01140C                       ; $011344
loc_011348:
        BTST    #4,D1                           ; $011348
        BEQ.S  loc_01139C                       ; $01134C
        TST.B  $A019.W                          ; $01134E
        BNE.W  loc_01136E                       ; $011352
        TST.W  $A042.W                          ; $011356
        BNE.W  loc_01136E                       ; $01135A
        MOVE.B  #$00A9,$C8A4.W                  ; $01135E
        MOVE.B  #$0001,$A019.W                  ; $011364
        BRA.W  loc_01140C                       ; $01136A
loc_01136E:
        MOVE.B  #$00A8,$C8A4.W                  ; $01136E
        MOVE.B  #$0001,$C809.W                  ; $011374
        MOVE.B  #$0001,$C80A.W                  ; $01137A
        BSET    #7,$C80E.W                      ; $011380
        MOVE.B  #$0001,$C802.W                  ; $011386
        JSR     $0088205E                       ; $01138C
        MOVE.W  #$0002,$A05C.W                  ; $011392
        BRA.W  loc_01140C                       ; $011398
loc_01139C:
        TST.W  $A042.W                          ; $01139C
        BNE.S  loc_01140C                       ; $0113A0
        BTST    #2,D1                           ; $0113A2
        BEQ.S  loc_0113BE                       ; $0113A6
        TST.B  $A019.W                          ; $0113A8
        BEQ.W  loc_01140C                       ; $0113AC
        MOVE.B  #$00A9,$C8A4.W                  ; $0113B0
        CLR.B  $A019.W                          ; $0113B6
        BRA.W  loc_01140C                       ; $0113BA
loc_0113BE:
        BTST    #3,D1                           ; $0113BE
        BEQ.S  loc_01140C                       ; $0113C2
        TST.B  $A019.W                          ; $0113C4
        BNE.W  loc_01140C                       ; $0113C8
        MOVE.B  #$00A9,$C8A4.W                  ; $0113CC
        MOVE.B  #$0001,$A019.W                  ; $0113D2
        BRA.W  loc_01140C                       ; $0113D8
loc_0113DC:
        JSR     $0088FB36                       ; $0113DC
        BTST    #6,$C80E.W                      ; $0113E2
        BNE.S  loc_01140C                       ; $0113E8
        CLR.W  $A05C.W                          ; $0113EA
        BRA.W  loc_01140C                       ; $0113EE
loc_0113F2:
        JSR     $0088FB36                       ; $0113F2
        BTST    #7,$C80E.W                      ; $0113F8
        BNE.S  loc_01140C                       ; $0113FE
        CLR.W  $A05C.W                          ; $011400
        ADDQ.W  #4,$C87E.W                      ; $011404
        BRA.W  loc_011410                       ; $011408
loc_01140C:
        BSR.W  loc_0119B8                       ; $01140C
loc_011410:
        DC.W    $33FC,$0018,$00FF,$0008; $011410 MOVE.W  #$0018,$00FF0008
        RTS                                     ; $011418
        CLR.W  D0                               ; $01141A
        JSR     $00E52C(PC)                     ; $01141C
loc_011420:
        TST.B  $00A15120                        ; $011420
        BNE.S  loc_011420                       ; $011426
        DC.W    $33FC,$0101,$00A1,$512C; $011428 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$8000,$00A1,$5128; $011430 MOVE.W  #$8000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $011438 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $011440 MOVE.B  #$0001,$00A15120
loc_011448:
        TST.B  $00A1512C                        ; $011448
        BNE.S  loc_011448                       ; $01144E
        DC.W    $33FC,$0050,$00A1,$5128; $011450 MOVE.W  #$0050,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $011458 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$0020,$00FF,$0008; $011460 MOVE.W  #$0020,$00FF0008
        ADDQ.W  #4,$C87E.W                      ; $011468
        RTS                                     ; $01146C
        CLR.W  D0                               ; $01146E
        JSR     $00E52C(PC)                     ; $011470
        JSR     $00B684(PC)                     ; $011474
        JSR     $00B6DA(PC)                     ; $011478
        MOVEA.L #$06018F80,A0                   ; $01147C
        MOVEA.L #$0400E038,A1                   ; $011482
        MOVE.W  #$00D8,D0                       ; $011488
        MOVE.W  #$0010,D1                       ; $01148C
        JSR     $00E35A(PC)                     ; $011490
        MOVEA.L #$26028000,A0                   ; $011494
        MOVE.L  $A022.W,D0                      ; $01149A
        ADDA.L  D0,A0                           ; $01149E
        MOVEA.L #$24010038,A1                   ; $0114A0
        MOVE.W  #$00D8,D0                       ; $0114A6
        MOVE.W  #$0050,D1                       ; $0114AA
        JSR     $00E35A(PC)                     ; $0114AE
        TST.L  $A026.W                          ; $0114B2
        BEQ.W  loc_0114D4                       ; $0114B6
        MOVE.L  $A022.W,D0                      ; $0114BA
        MOVE.L  $A026.W,D1                      ; $0114BE
        ADD.L  D1,D0                            ; $0114C2
        MOVE.L  D0,$A022.W                      ; $0114C4
        SUBQ.B  #1,$A02E.W                      ; $0114C8
        BCC.W  loc_01159A                       ; $0114CC
        CLR.L  $A026.W                          ; $0114D0
loc_0114D4:
        CMPI.W  #$0001,$A05C.W                  ; $0114D4
        BEQ.W  loc_01156A                       ; $0114DA
        CMPI.W  #$0002,$A05C.W                  ; $0114DE
        BEQ.W  loc_011580                       ; $0114E4
        JSR     $0088179E                       ; $0114E8
        MOVE.W  $C86C.W,D1                      ; $0114EE
        MOVE.W  D1,D2                           ; $0114F2
        DC.W    $0202,$00F0         ; $0114F4 ANDI.B  #$00F0,D2
        BEQ.S  loc_011528                       ; $0114F8
        MOVE.B  #$00A8,$C8A4.W                  ; $0114FA
        MOVE.W  #$0002,$A05C.W                  ; $011500
        MOVE.B  #$0001,$C809.W                  ; $011506
        MOVE.B  #$0001,$C80A.W                  ; $01150C
        BSET    #7,$C80E.W                      ; $011512
        MOVE.B  #$0001,$C802.W                  ; $011518
        JSR     $0088205E                       ; $01151E
        BRA.W  loc_01159E                       ; $011524
loc_011528:
        LSR.W  #8,D1                            ; $011528
        BTST    #0,D1                           ; $01152A
        BEQ.S  loc_01154A                       ; $01152E
        TST.L  $A022.W                          ; $011530
        BLE.W  loc_01159A                       ; $011534
        DC.W    $21FC,$FFFF,$FE50,$A026; $011538 MOVE.L  #$FFFFFE50,$A026.W
        MOVE.B  #$0007,$A02E.W                  ; $011540
        BRA.W  loc_01159A                       ; $011546
loc_01154A:
        BTST    #1,D1                           ; $01154A
        BEQ.S  loc_01159A                       ; $01154E
        MOVE.L  $A022.W,D0                      ; $011550
        CMP.L  $A02A.W,D0                       ; $011554
        BGE.W  loc_01159A                       ; $011558
        DC.W    $21FC,$0000,$01B0,$A026; $01155C MOVE.L  #$000001B0,$A026.W
        MOVE.B  #$0007,$A02E.W                  ; $011564
loc_01156A:
        JSR     $0088FB36                       ; $01156A
        BTST    #6,$C80E.W                      ; $011570
        BNE.S  loc_01159A                       ; $011576
        CLR.W  $A05C.W                          ; $011578
        BRA.W  loc_01159A                       ; $01157C
loc_011580:
        JSR     $0088FB36                       ; $011580
        BTST    #7,$C80E.W                      ; $011586
        BNE.S  loc_01159A                       ; $01158C
        CLR.W  $A05C.W                          ; $01158E
        ADDQ.W  #4,$C87E.W                      ; $011592
        BRA.W  loc_01159E                       ; $011596
loc_01159A:
        SUBQ.W  #4,$C87E.W                      ; $01159A
loc_01159E:
        DC.W    $33FC,$0018,$00FF,$0008; $01159E MOVE.W  #$0018,$00FF0008
        RTS                                     ; $0115A6
        CLR.W  D0                               ; $0115A8
        JSR     $00E52C(PC)                     ; $0115AA
loc_0115AE:
        TST.B  $00A15120                        ; $0115AE
        BNE.S  loc_0115AE                       ; $0115B4
        DC.W    $33FC,$0101,$00A1,$512C; $0115B6 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$8000,$00A1,$5128; $0115BE MOVE.W  #$8000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $0115C6 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $0115CE MOVE.B  #$0001,$00A15120
loc_0115D6:
        TST.B  $00A1512C                        ; $0115D6
        BNE.S  loc_0115D6                       ; $0115DC
        DC.W    $33FC,$0050,$00A1,$5128; $0115DE MOVE.W  #$0050,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $0115E6 MOVE.W  #$0101,$00A1512C
        MOVEA.L #$26028000,A0                   ; $0115EE
        MOVE.L  $A022.W,D0                      ; $0115F4
        ADDA.L  D0,A0                           ; $0115F8
        MOVEA.L #$24010018,A1                   ; $0115FA
        MOVE.W  #$0080,D0                       ; $011600
        MOVE.W  #$0050,D1                       ; $011604
        JSR     $00E35A(PC)                     ; $011608
        SUBQ.W  #1,$A052.W                      ; $01160C
        BCC.S  loc_01161E                       ; $011610
        MOVE.W  #$0010,$A052.W                  ; $011612
        BCHG    #0,$A050.W                      ; $011618
loc_01161E:
        BSR.W  loc_011C7E                       ; $01161E
        DC.W    $33FC,$0020,$00FF,$0008; $011622 MOVE.W  #$0020,$00FF0008
        ADDQ.W  #4,$C87E.W                      ; $01162A
        RTS                                     ; $01162E
        CLR.W  D0                               ; $011630
        JSR     $00E52C(PC)                     ; $011632
        JSR     $00B684(PC)                     ; $011636
        JSR     $00B6DA(PC)                     ; $01163A
        MOVEA.L #$26032000,A0                   ; $01163E
        MOVE.L  $A032.W,D0                      ; $011644
        ADDA.L  D0,A0                           ; $011648
        MOVEA.L #$240100A0,A1                   ; $01164A
        MOVE.W  #$0080,D0                       ; $011650
        MOVE.W  #$0050,D1                       ; $011654
        JSR     $00E35A(PC)                     ; $011658
        TST.L  $A026.W                          ; $01165C
        BEQ.W  loc_01167E                       ; $011660
        MOVE.L  $A022.W,D0                      ; $011664
        MOVE.L  $A026.W,D1                      ; $011668
        ADD.L  D1,D0                            ; $01166C
        MOVE.L  D0,$A022.W                      ; $01166E
        SUBQ.B  #1,$A02E.W                      ; $011672
        BCC.W  loc_011714                       ; $011676
        CLR.L  $A026.W                          ; $01167A
loc_01167E:
        CMPI.W  #$0001,$A05C.W                  ; $01167E
        BEQ.W  loc_0117B6                       ; $011684
        CMPI.W  #$0002,$A05C.W                  ; $011688
        BEQ.W  loc_0117CC                       ; $01168E
        JSR     $0088179E                       ; $011692
        MOVE.W  $C86C.W,D1                      ; $011698
        MOVE.W  D1,D2                           ; $01169C
        DC.W    $0202,$00F0         ; $01169E ANDI.B  #$00F0,D2
        BEQ.S  loc_0116D2                       ; $0116A2
        MOVE.B  #$00A8,$C8A4.W                  ; $0116A4
        MOVE.W  #$0002,$A05C.W                  ; $0116AA
        MOVE.B  #$0001,$C809.W                  ; $0116B0
        MOVE.B  #$0001,$C80A.W                  ; $0116B6
        BSET    #7,$C80E.W                      ; $0116BC
        MOVE.B  #$0001,$C802.W                  ; $0116C2
        JSR     $0088205E                       ; $0116C8
        BRA.W  loc_0117E6                       ; $0116CE
loc_0116D2:
        LSR.W  #8,D1                            ; $0116D2
        BTST    #0,D1                           ; $0116D4
        BEQ.S  loc_0116F4                       ; $0116D8
        TST.L  $A022.W                          ; $0116DA
        BLE.W  loc_011714                       ; $0116DE
        DC.W    $21FC,$FFFF,$FE00,$A026; $0116E2 MOVE.L  #$FFFFFE00,$A026.W
        MOVE.B  #$0003,$A02E.W                  ; $0116EA
        BRA.W  loc_011714                       ; $0116F0
loc_0116F4:
        BTST    #1,D1                           ; $0116F4
        BEQ.S  loc_011714                       ; $0116F8
        MOVE.L  $A022.W,D0                      ; $0116FA
        CMP.L  $A02A.W,D0                       ; $0116FE
        BGE.W  loc_011714                       ; $011702
        DC.W    $21FC,$0000,$0200,$A026; $011706 MOVE.L  #$00000200,$A026.W
        MOVE.B  #$0003,$A02E.W                  ; $01170E
loc_011714:
        TST.L  $A036.W                          ; $011714
        BEQ.W  loc_011736                       ; $011718
        MOVE.L  $A032.W,D0                      ; $01171C
        MOVE.L  $A036.W,D1                      ; $011720
        ADD.L  D1,D0                            ; $011724
        MOVE.L  D0,$A032.W                      ; $011726
        SUBQ.B  #1,$A03E.W                      ; $01172A
        BCC.W  loc_0117E6                       ; $01172E
        CLR.L  $A036.W                          ; $011732
loc_011736:
        MOVE.W  $C86E.W,D1                      ; $011736
        MOVE.W  D1,D2                           ; $01173A
        DC.W    $0202,$00F0         ; $01173C ANDI.B  #$00F0,D2
        BEQ.S  loc_011770                       ; $011740
        MOVE.B  #$00A8,$C8A4.W                  ; $011742
        MOVE.W  #$0002,$A05C.W                  ; $011748
        MOVE.B  #$0001,$C809.W                  ; $01174E
        MOVE.B  #$0001,$C80A.W                  ; $011754
        BSET    #7,$C80E.W                      ; $01175A
        MOVE.B  #$0001,$C802.W                  ; $011760
        JSR     $0088205E                       ; $011766
        BRA.W  loc_0117E6                       ; $01176C
loc_011770:
        LSR.W  #8,D1                            ; $011770
        BTST    #0,D1                           ; $011772
        BEQ.S  loc_011792                       ; $011776
        TST.L  $A032.W                          ; $011778
        BLE.W  loc_0117E6                       ; $01177C
        DC.W    $21FC,$FFFF,$FE00,$A036; $011780 MOVE.L  #$FFFFFE00,$A036.W
        MOVE.B  #$0003,$A03E.W                  ; $011788
        BRA.W  loc_0117E6                       ; $01178E
loc_011792:
        BTST    #1,D1                           ; $011792
        BEQ.S  loc_0117E6                       ; $011796
        MOVE.L  $A032.W,D0                      ; $011798
        CMP.L  $A03A.W,D0                       ; $01179C
        BGE.W  loc_0117E6                       ; $0117A0
        DC.W    $21FC,$0000,$0200,$A036; $0117A4 MOVE.L  #$00000200,$A036.W
        MOVE.B  #$0003,$A03E.W                  ; $0117AC
        BRA.W  loc_0117E6                       ; $0117B2
loc_0117B6:
        JSR     $0088FB36                       ; $0117B6
        BTST    #6,$C80E.W                      ; $0117BC
        BNE.S  loc_0117E6                       ; $0117C2
        CLR.W  $A05C.W                          ; $0117C4
        BRA.W  loc_0117E6                       ; $0117C8
loc_0117CC:
        JSR     $0088FB36                       ; $0117CC
        BTST    #7,$C80E.W                      ; $0117D2
        BNE.S  loc_0117E6                       ; $0117D8
        CLR.W  $A05C.W                          ; $0117DA
        ADDQ.W  #4,$C87E.W                      ; $0117DE
        BRA.W  loc_0117EA                       ; $0117E2
loc_0117E6:
        SUBQ.W  #4,$C87E.W                      ; $0117E6
loc_0117EA:
        DC.W    $33FC,$0018,$00FF,$0008; $0117EA MOVE.W  #$0018,$00FF0008
        RTS                                     ; $0117F2
loc_0117F4:
        TST.B  $00A15120                        ; $0117F4
        BNE.S  loc_0117F4                       ; $0117FA
        CLR.B  $00A15123                        ; $0117FC
        MOVE.W  #$0000,$C87E.W                  ; $011802
        DC.W    $33FC,$0020,$00FF,$0008; $011808 MOVE.W  #$0020,$00FF0008
        TST.B  $A019.W                          ; $011810
        BNE.S  loc_011830                       ; $011814
        TST.W  $A042.W                          ; $011816
        BNE.S  loc_011830                       ; $01181A
        BSET    #3,$C80E.W                      ; $01181C
        DC.W    $23FC,$0088,$4A3E,$00FF,$0002; $011822 MOVE.L  #$00884A3E,$00FF0002
        BRA.W  loc_011860                       ; $01182C
loc_011830:
        BCLR    #3,$C80E.W                      ; $011830
        BCLR    #7,$C81C.W                      ; $011836
        BTST    #7,$FEB7.W                      ; $01183C
        BEQ.S  loc_011856                       ; $011842
        BSET    #7,$C81C.W                      ; $011844
        DC.W    $23FC,$0088,$C0F0,$00FF,$0002; $01184A MOVE.L  #$0088C0F0,$00FF0002
        BRA.S  loc_011860                       ; $011854
loc_011856:
        DC.W    $23FC,$0088,$D48A,$00FF,$0002; $011856 MOVE.L  #$0088D48A,$00FF0002
loc_011860:
        RTS                                     ; $011860
loc_011862:
        TST.B  $00A15120                        ; $011862
        BNE.S  loc_011862                       ; $011868
        CLR.B  $00A15123                        ; $01186A
        MOVE.W  #$0000,$C87E.W                  ; $011870
        DC.W    $33FC,$0020,$00FF,$0008; $011876 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0088,$D4A4,$00FF,$0002; $01187E MOVE.L  #$0088D4A4,$00FF0002
        RTS                                     ; $011888
        LEA     $00FF6E00,A0                    ; $01188A
        MOVE.W  #$007F,D0                       ; $011890
loc_011894:
        CLR.L  (A0)+                            ; $011894
        DBRA    D0,loc_011894                   ; $011896
        MOVE.B  #$0001,$C821.W                  ; $01189A
        JSR     $00B6DA(PC)                     ; $0118A0
        BTST    #7,$C80E.W                      ; $0118A4
        BNE.S  loc_0118D2                       ; $0118AA
loc_0118AC:
        TST.B  $00A15120                        ; $0118AC
        BNE.S  loc_0118AC                       ; $0118B2
        CLR.B  $00A15123                        ; $0118B4
        MOVE.W  #$0000,$C87E.W                  ; $0118BA
        DC.W    $33FC,$0020,$00FF,$0008; $0118C0 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0088,$D4B8,$00FF,$0002; $0118C8 MOVE.L  #$0088D4B8,$00FF0002
loc_0118D2:
        RTS                                     ; $0118D2
loc_0118D4:
        MOVE.B  (A2)+,D3                        ; $0118D4
        BSR.W  loc_011908                       ; $0118D6
        MOVE.W  #$000A,D1                       ; $0118DA
        BSR.W  loc_011924                       ; $0118DE
        ADDQ.L  #8,A1                           ; $0118E2
        MOVE.B  (A2)+,D3                        ; $0118E4
        BSR.W  loc_011908                       ; $0118E6
        MOVE.W  #$000B,D1                       ; $0118EA
        BSR.W  loc_011924                       ; $0118EE
        ADDQ.L  #8,A1                           ; $0118F2
        MOVE.B  (A2)+,D1                        ; $0118F4
        ANDI.W  #$000F,D1                       ; $0118F6
        BSR.W  loc_011924                       ; $0118FA
        ADDQ.L  #8,A1                           ; $0118FE
        MOVE.B  (A2)+,D3                        ; $011900
        BSR.W  loc_011908                       ; $011902
        RTS                                     ; $011906
loc_011908:
        MOVE.B  D3,D1                           ; $011908
        LSR.B  #4,D1                            ; $01190A
        ANDI.W  #$000F,D1                       ; $01190C
        BSR.W  loc_011924                       ; $011910
        ADDQ.L  #8,A1                           ; $011914
        MOVE.W  D3,D1                           ; $011916
        ANDI.W  #$000F,D1                       ; $011918
        BSR.W  loc_011924                       ; $01191C
        ADDQ.L  #8,A1                           ; $011920
        RTS                                     ; $011922
loc_011924:
        LSL.W  #6,D1                            ; $011924
        MOVE.W  D1,D0                           ; $011926
        LSL.W  #1,D1                            ; $011928
        ADD.W  D0,D1                            ; $01192A
        MOVEA.L #$0601DF00,A0                   ; $01192C
        ADDA.W  D1,A0                           ; $011932
        MOVE.W  #$000C,D0                       ; $011934
        MOVE.W  #$0010,D1                       ; $011938
        JSR     $00E35A(PC)                     ; $01193C
        RTS                                     ; $011940
loc_011942:
        MOVEM.L -(A7),A3/A4                     ; $011942
        MOVE.B  (A2)+,D3                        ; $011946
        BSR.W  loc_01197E                       ; $011948
        MOVE.W  #$000A,D1                       ; $01194C
        BSR.W  loc_01199A                       ; $011950
        ADDQ.L  #8,A1                           ; $011954
        MOVE.B  (A2)+,D3                        ; $011956
        BSR.W  loc_01197E                       ; $011958
        MOVE.W  #$000B,D1                       ; $01195C
        BSR.W  loc_01199A                       ; $011960
        ADDQ.L  #8,A1                           ; $011964
        MOVE.B  (A2)+,D1                        ; $011966
        ANDI.W  #$000F,D1                       ; $011968
        BSR.W  loc_01199A                       ; $01196C
        ADDQ.L  #8,A1                           ; $011970
        MOVE.B  (A2)+,D3                        ; $011972
        BSR.W  loc_01197E                       ; $011974
        MOVEM.L D3/D4,(A7)+                     ; $011978
        RTS                                     ; $01197C
loc_01197E:
        MOVE.B  D3,D1                           ; $01197E
        LSR.B  #4,D1                            ; $011980
        ANDI.W  #$000F,D1                       ; $011982
        BSR.W  loc_01199A                       ; $011986
        ADDQ.L  #8,A1                           ; $01198A
        MOVE.W  D3,D1                           ; $01198C
        ANDI.W  #$000F,D1                       ; $01198E
        BSR.W  loc_01199A                       ; $011992
        ADDQ.L  #8,A1                           ; $011996
        RTS                                     ; $011998
loc_01199A:
        LSL.W  #6,D1                            ; $01199A
        MOVE.W  D1,D0                           ; $01199C
        LSL.W  #1,D1                            ; $01199E
        ADD.W  D0,D1                            ; $0119A0
        MOVEA.L #$0601DF00,A0                   ; $0119A2
        ADDA.W  D1,A0                           ; $0119A8
        MOVE.W  #$000C,D0                       ; $0119AA
        MOVE.W  #$0010,D1                       ; $0119AE
        JSR     loc_011A98(PC)                  ; $0119B2
        RTS                                     ; $0119B6
loc_0119B8:
        LEA     $00FF6E00,A0                    ; $0119B8
        ADDA.L  #$000001E0,A0                   ; $0119BE
        LEA     $00891A70,A1                    ; $0119C4
        MOVE.W  #$0007,D0                       ; $0119CA
loc_0119CE:
        MOVE.W  (A1)+,D1                        ; $0119CE
        BSET    #15,D1                          ; $0119D0
        MOVE.W  D1,(A0)+                        ; $0119D4
        DBRA    D0,loc_0119CE                   ; $0119D6
        MOVEQ   #$00,D0                         ; $0119DA
        MOVE.B  $A019.W,D0                      ; $0119DC
        ADD.L  D0,D0                            ; $0119E0
        ADD.L  D0,D0                            ; $0119E2
        ADD.L  D0,D0                            ; $0119E4
        LEA     $00FF6E00,A0                    ; $0119E6
        ADDA.L  #$000001E0,A0                   ; $0119EC
        ADDA.L  D0,A0                           ; $0119F2
        LEA     $00891A80,A1                    ; $0119F4
        MOVEQ   #$00,D1                         ; $0119FA
        MOVE.B  $A01A.W,D1                      ; $0119FC
        MOVE.W  #$0003,D2                       ; $011A00
loc_011A04:
        MOVE.W  (A1)+,D5                        ; $011A04
        BSR.S  loc_011A5C                       ; $011A06
        MOVE.W  D5,D3                           ; $011A08
        MOVE.W  (A1)+,D5                        ; $011A0A
        BSR.S  loc_011A5C                       ; $011A0C
        MOVE.W  D5,D4                           ; $011A0E
        MOVE.W  (A1)+,D5                        ; $011A10
        BSR.S  loc_011A5C                       ; $011A12
        LSL.W  #5,D4                            ; $011A14
        LSL.W  #8,D5                            ; $011A16
        LSL.W  #2,D5                            ; $011A18
        OR.W   D4,D3                            ; $011A1A
        OR.W   D5,D3                            ; $011A1C
        BSET    #15,D3                          ; $011A1E
        MOVE.W  D3,(A0)+                        ; $011A22
        DBRA    D2,loc_011A04                   ; $011A24
        MOVE.B  $A01A.W,D0                      ; $011A28
        MOVE.B  $A01C.W,D1                      ; $011A2C
        ADD.B  D1,D0                            ; $011A30
        CMPI.B  #$001F,D0                       ; $011A32
        BLE.S  loc_011A42                       ; $011A36
        MOVE.B  #$001F,D0                       ; $011A38
        MOVE.B  #$00FE,D1                       ; $011A3C
        BRA.S  loc_011A4C                       ; $011A40
loc_011A42:
        TST.B  D0                               ; $011A42
        BGE.S  loc_011A4C                       ; $011A44
        CLR.B  D0                               ; $011A46
        MOVE.B  #$0002,D1                       ; $011A48
loc_011A4C:
        MOVE.B  D0,$A01A.W                      ; $011A4C
        MOVE.B  D1,$A01C.W                      ; $011A50
        MOVE.B  #$0001,$C821.W                  ; $011A54
        RTS                                     ; $011A5A
loc_011A5C:
        ADD.W  D1,D5                            ; $011A5C
        CMPI.W  #$001F,D5                       ; $011A5E
        BLE.S  loc_011A68                       ; $011A62
        MOVE.W  #$001F,D5                       ; $011A64
loc_011A68:
        TST.W  D5                               ; $011A68
        BGT.S  loc_011A6E                       ; $011A6A
        CLR.W  D5                               ; $011A6C
loc_011A6E:
        RTS                                     ; $011A6E
        NEG.B  D0                               ; $011A70
        NEG.L  -(A3)                            ; $011A72
        DC.W    $4946               ; $011A74 DC.W    $4946
        LEA     $4400(A1),A6                    ; $011A76
        NEG.L  -(A3)                            ; $011A7A
        DC.W    $4946               ; $011A7C DC.W    $4946
        LEA     $0000(A1),A6                    ; $011A7E
        DC.W    $0000,$0011         ; $011A82 ORI.B  #$0011,D0
        DC.W    $0003,$0005         ; $011A86 ORI.B  #$0005,D3
        DC.W    $0011,$0006         ; $011A8A ORI.B  #$0006,(A1)
        DC.W    $000A,$0012         ; $011A8E ORI.B  #$0012,A2
        DC.W    $0008,$000F         ; $011A92 ORI.B  #$000F,A0
        DC.W    $0013,$4A39         ; $011A96 ORI.B  #$4A39,(A3)
        ORI.L  #$512066F8,-(A1)                 ; $011A9A
        MOVE.L  A1,$00A15128                    ; $011AA0
        DC.W    $13FC,$0001,$00A1,$512C; $011AA6 MOVE.B  #$0001,$00A1512C
        DC.W    $13FC,$0020,$00A1,$5121; $011AAE MOVE.B  #$0020,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $011AB6 MOVE.B  #$0001,$00A15120
loc_011ABE:
        TST.B  $00A1512C                        ; $011ABE
        BNE.S  loc_011ABE                       ; $011AC4
        MOVE.W  D0,$00A15128                    ; $011AC6
        MOVE.W  D1,$00A1512A                    ; $011ACC
        DC.W    $13FC,$0001,$00A1,$512C; $011AD2 MOVE.B  #$0001,$00A1512C
loc_011ADA:
        TST.B  $00A1512C                        ; $011ADA
        BNE.S  loc_011ADA                       ; $011AE0
        MOVE.W  D2,$00A15128                    ; $011AE2
        DC.W    $13FC,$0001,$00A1,$512C; $011AE8 MOVE.B  #$0001,$00A1512C
loc_011AF0:
        TST.B  $00A1512C                        ; $011AF0
        BNE.S  loc_011AF0                       ; $011AF6
        MOVE.L  A0,$00A15128                    ; $011AF8
        DC.W    $13FC,$0001,$00A1,$512C; $011AFE MOVE.B  #$0001,$00A1512C
        RTS                                     ; $011B06
loc_011B08:
        MOVEA.L #$06018000,A0                   ; $011B08
        MOVEA.L #$04004C78,A1                   ; $011B0E
        MOVE.W  #$0050,D0                       ; $011B14
        MOVE.W  #$0010,D1                       ; $011B18
        JSR     $00E35A(PC)                     ; $011B1C
        MOVEA.L #$0601E8C0,A0                   ; $011B20
        MOVEA.L #$04008090,A1                   ; $011B26
        MOVE.W  #$0058,D0                       ; $011B2C
        MOVE.W  #$0010,D1                       ; $011B30
        JSR     $00E35A(PC)                     ; $011B34
        MOVEA.L #$0601EE40,A0                   ; $011B38
        MOVEA.L #$0400A090,A1                   ; $011B3E
        MOVE.W  #$0058,D0                       ; $011B44
        MOVE.W  #$0010,D1                       ; $011B48
        JSR     $00E35A(PC)                     ; $011B4C
        MOVEA.L #$06018500,A0                   ; $011B50
        MOVEA.L #$04008048,A1                   ; $011B56
        MOVE.W  #$0038,D0                       ; $011B5C
        MOVE.W  #$0020,D1                       ; $011B60
        JSR     $00E35A(PC)                     ; $011B64
        RTS                                     ; $011B68
loc_011B6A:
        MOVE.L  $C260.W,D0                      ; $011B6A
        MOVE.L  D0,$A058.W                      ; $011B6E
        LEA     $B400.W,A1                      ; $011B72
        LEA     $C400.W,A2                      ; $011B76
        MOVEQ   #$1F,D7                         ; $011B7A
loc_011B7C:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A1)+   ; $011B7C
        MOVEM.L -(A2),D4/A1/A2/A3/A4/A5/A6/A7   ; $011B80
        DBRA    D7,loc_011B7C                   ; $011B84
        CLR.L  $A04A.W                          ; $011B88
        LEA     $A04A.W,A0                      ; $011B8C
        LEA     $C200.W,A1                      ; $011B90
        MOVE.W  #$0013,D2                       ; $011B94
loc_011B98:
        ADDI.B  #$0000,D0                       ; $011B98
        MOVE.B  $0003(A0),D0                    ; $011B9C
        MOVE.B  $0003(A1),D1                    ; $011BA0
        AND.B  D0,D1                            ; $011BA4
        MOVE.B  D0,$0003(A0)                    ; $011BA6
        MOVE.B  $0002(A0),D0                    ; $011BAA
        MOVE.B  $0002(A1),D1                    ; $011BAE
        AND.B  D0,D1                            ; $011BB2
        MOVE.B  D0,D1                           ; $011BB4
        DC.W    $0200,$000F         ; $011BB6 ANDI.B  #$000F,D0
        MOVE.B  D0,$0002(A0)                    ; $011BBA
        LSR.B  #4,D1                            ; $011BBE
        ADDI.B  #$0000,D0                       ; $011BC0
        MOVE.B  $0001(A0),D0                    ; $011BC4
        AND.B  D0,D1                            ; $011BC8
        MOVE.B  $0001(A1),D1                    ; $011BCA
        AND.B  D0,D1                            ; $011BCE
        BCC.W  loc_011BE4                       ; $011BD0
        ADDI.B  #$0000,D0                       ; $011BD4
        MOVE.B  #$0040,D1                       ; $011BD8
        AND.B  D0,D1                            ; $011BDC
        MOVE.B  #$0001,D1                       ; $011BDE
        BRA.S  loc_011BFC                       ; $011BE2
loc_011BE4:
        CLR.B  D1                               ; $011BE4
        CMPI.B  #$0060,D0                       ; $011BE6
        BCS.W  loc_011BFC                       ; $011BEA
        ADDI.B  #$0000,D0                       ; $011BEE
        MOVE.B  #$0060,D1                       ; $011BF2
        OR.B   D0,D1                            ; $011BF6
        MOVE.B  #$0001,D1                       ; $011BF8
loc_011BFC:
        MOVE.B  D0,$0001(A0)                    ; $011BFC
        ADDI.B  #$0000,D0                       ; $011C00
        MOVE.B  (A0),D0                         ; $011C04
        AND.B  D0,D1                            ; $011C06
        MOVE.B  (A1),D1                         ; $011C08
        AND.B  D0,D1                            ; $011C0A
        MOVE.B  D0,(A0)                         ; $011C0C
        ADDQ.L  #4,A1                           ; $011C0E
        DBRA    D2,loc_011B98                   ; $011C10
        TST.L  $A04A.W                          ; $011C14
        BNE.S  loc_011C22                       ; $011C18
        DC.W    $21FC,$CCCC,$0CCC,$A04A; $011C1A MOVE.L  #$CCCC0CCC,$A04A.W
loc_011C22:
        LEA     $C200.W,A0                      ; $011C22
        MOVE.W  #$0013,D0                       ; $011C26
loc_011C2A:
        TST.L  (A0)                             ; $011C2A
        BEQ.W  loc_011C38                       ; $011C2C
        ADDQ.L  #4,A0                           ; $011C30
        DBRA    D0,loc_011C2A                   ; $011C32
        BRA.S  loc_011C42                       ; $011C36
loc_011C38:
        MOVE.L  #$CCCC0CCC,(A0)+                ; $011C38
        DBRA    D0,loc_011C38                   ; $011C3E
loc_011C42:
        MOVE.W  #$0002,$A04E.W                  ; $011C42
        MOVE.L  $A058.W,D0                      ; $011C48
        MOVE.L  $C260.W,D1                      ; $011C4C
        CMP.L  D0,D1                            ; $011C50
        BEQ.W  loc_011C7C                       ; $011C52
        MOVE.W  #$0001,$A04E.W                  ; $011C56
        CMPI.L  #$CCCC0CCC,D0                   ; $011C5C
        BEQ.S  loc_011C7C                       ; $011C62
        CLR.W  $A04E.W                          ; $011C64
        CMPI.L  #$CCCC0CCC,D1                   ; $011C68
        BEQ.S  loc_011C7C                       ; $011C6E
        CMP.L  D0,D1                            ; $011C70
        BHI.W  loc_011C7C                       ; $011C72
        MOVE.W  #$0001,$A04E.W                  ; $011C76
loc_011C7C:
        RTS                                     ; $011C7C
loc_011C7E:
        TST.W  $A04E.W                          ; $011C7E
        BNE.S  loc_011CC4                       ; $011C82
        BTST    #0,$A050.W                      ; $011C84
        BNE.S  loc_011CA8                       ; $011C8A
        MOVEA.L #$06018F80,A0                   ; $011C8C
        MOVEA.L #$0400D018,A1                   ; $011C92
        MOVE.W  #$0078,D0                       ; $011C98
        MOVE.W  #$0018,D1                       ; $011C9C
        JSR     $00E35A(PC)                     ; $011CA0
        BRA.W  loc_011D08                       ; $011CA4
loc_011CA8:
        MOVEA.L #$06010000,A0                   ; $011CA8
        MOVEA.L #$0400D018,A1                   ; $011CAE
        MOVE.W  #$0078,D0                       ; $011CB4
        MOVE.W  #$0018,D1                       ; $011CB8
        JSR     $00E35A(PC)                     ; $011CBC
        BRA.W  loc_011D08                       ; $011CC0
loc_011CC4:
        CMPI.W  #$0002,$A04E.W                  ; $011CC4
        BEQ.S  loc_011D08                       ; $011CCA
        BTST    #0,$A050.W                      ; $011CCC
        BNE.S  loc_011CF0                       ; $011CD2
        MOVEA.L #$06019AC0,A0                   ; $011CD4
        MOVEA.L #$0400D0A0,A1                   ; $011CDA
        MOVE.W  #$0078,D0                       ; $011CE0
        MOVE.W  #$0018,D1                       ; $011CE4
        JSR     $00E35A(PC)                     ; $011CE8
        BRA.W  loc_011D08                       ; $011CEC
loc_011CF0:
        MOVEA.L #$06010000,A0                   ; $011CF0
        MOVEA.L #$0400D0A0,A1                   ; $011CF6
        MOVE.W  #$0078,D0                       ; $011CFC
        MOVE.W  #$0018,D1                       ; $011D00
        JSR     $00E35A(PC)                     ; $011D04
loc_011D08:
        RTS                                     ; $011D08
        DC.W    $33FC,$002C,$00FF,$0008; $011D0A MOVE.W  #$002C,$00FF0008
        MOVE.W  #$002C,$C87A.W                  ; $011D12
        BCLR    #6,$C875.W                      ; $011D18
        MOVE.W  $C874.W,(A5)                    ; $011D1E
        DC.W    $33FC,$0083,$00A1,$5100; $011D22 MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $011D2A ANDI.B  #$00FC,$00A15181
        JSR     $008826C8                       ; $011D32
        MOVE.L  #$000A0907,D0                   ; $011D38
        JSR     $008814BE                       ; $011D3E
        MOVE.B  #$0001,$C80D.W                  ; $011D44
        MOVEQ   #$00,D0                         ; $011D4A
        LEA     $8480.W,A0                      ; $011D4C
        MOVEQ   #$1F,D1                         ; $011D50
loc_011D52:
        MOVE.L  D0,(A0)+                        ; $011D52
        DBRA    D1,loc_011D52                   ; $011D54
        LEA     $00FF7B80,A0                    ; $011D58
        MOVEQ   #$7F,D1                         ; $011D5E
loc_011D60:
        MOVE.L  D0,(A0)+                        ; $011D60
        DBRA    D1,loc_011D60                   ; $011D62
        MOVE.L  #$60000002,(A5)                 ; $011D66
        MOVE.W  #$17FF,D1                       ; $011D6C
loc_011D70:
        MOVE.L  D0,(A6)                         ; $011D70
        DBRA    D1,loc_011D70                   ; $011D72
        JSR     $008849AA                       ; $011D76
        CLR.W  $C880.W                          ; $011D7C
        CLR.W  $C882.W                          ; $011D80
        CLR.W  $8000.W                          ; $011D84
        CLR.W  $8002.W                          ; $011D88
        CLR.W  $A012.W                          ; $011D8C
        CLR.B  $A018.W                          ; $011D90
        JSR     $008849AA                       ; $011D94
        DC.W    $21FC,$008B,$B4FC,$C96C; $011D9A MOVE.L  #$008BB4FC,$C96C.W
        MOVE.B  #$0001,$C809.W                  ; $011DA2
        MOVE.B  #$0001,$C80A.W                  ; $011DA8
        BSET    #6,$C80E.W                      ; $011DAE
        MOVE.B  #$0001,$C802.W                  ; $011DB4
        MOVE.W  #$0001,$A038.W                  ; $011DBA
        LEA     $00FF1000,A0                    ; $011DC0
        MOVE.W  #$037F,D0                       ; $011DC6
loc_011DCA:
        CLR.L  (A0)+                            ; $011DCA
        DBRA    D0,loc_011DCA                   ; $011DCC
        MOVE.W  #$0001,D0                       ; $011DD0
        MOVE.W  #$0001,D1                       ; $011DD4
        MOVE.W  #$0001,D2                       ; $011DD8
        MOVE.W  #$0026,D3                       ; $011DDC
        MOVE.W  #$001A,D4                       ; $011DE0
        LEA     $00FF1000,A0                    ; $011DE4
        JSR     $00E22C(PC)                     ; $011DEA
        LEA     $00FF1000,A0                    ; $011DEE
        JSR     $00E2F0(PC)                     ; $011DF4
        JSR     $00E1BC(PC)                     ; $011DF8
        DC.W    $08B9,$0007,$00A1,$5181; $011DFC BCLR    #7,$00A15181
        LEA     $00FF6E00,A0                    ; $011E04
        ADDQ.L  #2,A0                           ; $011E0A
        LEA     $00891F38,A1                    ; $011E0C
        MOVE.W  #$002E,D0                       ; $011E12
loc_011E16:
        MOVE.W  (A1)+,D1                        ; $011E16
        BSET    #15,D1                          ; $011E18
        MOVE.W  D1,(A0)+                        ; $011E1C
        DBRA    D0,loc_011E16                   ; $011E1E
        LEA     $00FF6E00,A0                    ; $011E22
        ADDA.L  #$00000120,A0                   ; $011E28
        LEA     $00891F96,A1                    ; $011E2E
        MOVE.W  #$005F,D0                       ; $011E34
loc_011E38:
        MOVE.W  (A1)+,D1                        ; $011E38
        BSET    #15,D1                          ; $011E3A
        MOVE.W  D1,(A0)+                        ; $011E3E
        DBRA    D0,loc_011E38                   ; $011E40
        LEA     $000EDF70,A0                    ; $011E44
        MOVEA.L #$06018000,A1                   ; $011E4A
        JSR     $00E316(PC)                     ; $011E50
        LEA     $000EE770,A0                    ; $011E54
        MOVEA.L #$0601AD00,A1                   ; $011E5A
        JSR     $00E316(PC)                     ; $011E60
        LEA     $000EBB40,A0                    ; $011E64
        MOVEA.L #$0601BE00,A1                   ; $011E6A
        JSR     $00E316(PC)                     ; $011E70
        LEA     $000EB980,A0                    ; $011E74
        MOVEA.L #$0601F000,A1                   ; $011E7A
        JSR     $00E316(PC)                     ; $011E80
        LEA     $000EC6F0,A0                    ; $011E84
        MOVEA.L #$0601F9C0,A1                   ; $011E8A
        JSR     $00E316(PC)                     ; $011E90
        LEA     $000EC150,A0                    ; $011E94
        MOVEA.L #$060207C0,A1                   ; $011E9A
        JSR     $00E316(PC)                     ; $011EA0
        LEA     $000EEA40,A0                    ; $011EA4
        MOVEA.L #$06030000,A1                   ; $011EAA
        JSR     $00E316(PC)                     ; $011EB0
        MOVE.B  #$0000,$A019.W                  ; $011EB4
        MOVE.B  #$0000,$A01A.W                  ; $011EBA
        MOVE.B  #$0000,$A01B.W                  ; $011EC0
        MOVE.B  #$0000,$A01C.W                  ; $011EC6
        CLR.L  $A026.W                          ; $011ECC
        CLR.W  $A02C.W                          ; $011ED0
        DC.W    $21FC,$0402,$A060,$A030; $011ED4 MOVE.L  #$0402A060,$A030.W
        DC.W    $21FC,$0402,$A020,$A034; $011EDC MOVE.L  #$0402A020,$A034.W
        JSR     $0088204A                       ; $011EE4
        MOVE.B  #$0001,$C821.W                  ; $011EEA
        DC.W    $0239,$00FC,$00A1,$5181; $011EF0 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $011EF8 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $011F00 MOVE.W  #$8083,$00A15100
        BSET    #6,$C875.W                      ; $011F08
        MOVE.W  $C874.W,(A5)                    ; $011F0E
        DC.W    $33FC,$0018,$00FF,$0008; $011F12 MOVE.W  #$0018,$00FF0008
        JSR     $00884998                       ; $011F1A
        MOVE.W  #$0000,$C87E.W                  ; $011F20
        DC.W    $23FC,$0089,$2056,$00FF,$0002; $011F26 MOVE.L  #$00892056,$00FF0002
        MOVE.B  #$008F,$C8A5.W                  ; $011F30
        RTS                                     ; $011F36
        DC.W    $0000,$0421         ; $011F38 ORI.B  #$0421,D0
        BCHG    #3,D2                           ; $011F3C
        MOVE.B  D4,(A0)                         ; $011F40
        MOVE.B  -(A5),(A2)                      ; $011F42
        MOVE.B  D6,(A4)+                        ; $011F44
        MOVE.B  -(A7),(A6)+                     ; $011F46
        MOVE.L  A0,-(A0)                        ; $011F48
        MOVE.L  $7FFF(A1),-(A2)                 ; $011F4A
        DC.W    $7FFF               ; $011F4E MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  A4,-$01(A0,D7.L)                ; $011F50
        MOVE.W  A6,#$3DEF                       ; $011F54
        DC.W    $7FFF               ; $011F58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F5E MOVE.W  <EA:3F>,<EA:3F>
        ADDQ.L  #1,(A4)                         ; $011F60
        ADDQ.L  #3,-$01(A5,D7.L)                ; $011F62
        SGT     $18(A7,D6.W)                    ; $011F66
        DC.W    $7FFF               ; $011F6A MOVE.W  <EA:3F>,<EA:3F>
        BMI.S  loc_011FC8                       ; $011F6C
        BLE.S  loc_011FEB                       ; $011F6E
        DC.W    $7FFF               ; $011F70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7BDE               ; $011F74 MOVE.W  (A6)+,<EA:3D>
        DC.W    $7FFF               ; $011F76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F94 MOVE.W  <EA:3F>,<EA:3F>
        BLS.S  loc_011FCF                       ; $011F96
        BEQ.S  loc_011FD1                       ; $011F98
        BMI.S  loc_011FF4                       ; $011F9A
        BLE.S  loc_012017                       ; $011F9C
loc_011F9E:
        NEG.W  D5                               ; $011F9E
        SUBQ.B  #8,$6212(A3)                    ; $011FA0
        BGT.S  loc_011F9E                       ; $011FA4
        MOVE.W  (A2)+,-$18(A1,D6.W)             ; $011FA6
        DC.W    $7FFF               ; $011FAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FB6 MOVE.W  <EA:3F>,<EA:3F>
        MOVEQ   #$00,D0                         ; $011FB8
        MOVEQ   #-$60,D6                        ; $011FBA
        MOVEQ   #-$19,D0                        ; $011FBC
        DC.W    $7FFF               ; $011FBE MOVE.W  <EA:3F>,<EA:3F>
        ADDQ.B  #4,D0                           ; $011FC0
        BCLR    D0,D0                           ; $011FC2
        DC.W    $0200,$000E         ; $011FC4 ANDI.B  #$000E,D0
loc_011FC8:
        DC.W    $0014,$1CFB         ; $011FC8 ORI.B  #$1CFB,(A4)
        DC.W    $7FFF               ; $011FCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FD4 MOVE.W  <EA:3F>,<EA:3F>
        NEG.B  D0                               ; $011FD6
        NEG.L  -(A3)                            ; $011FD8
        DC.W    $4946               ; $011FDA DC.W    $4946
        LEA     $1C00(A1),A6                    ; $011FDC
        MOVE.L  -(A3),(A4)                      ; $011FE0
        MOVE.W  D6,$41E9(A2)                    ; $011FE2
        SUBQ.W  #4,D0                           ; $011FE6
        SUBQ.L  #4,D3                           ; $011FE8
        SCS     -(A6)                           ; $011FEA
        ADDQ.B  #3,$1C00(A1)                    ; $011FEC
        MOVE.L  -(A3),(A4)                      ; $011FF0
        MOVE.W  D6,$41E9(A2)                    ; $011FF2
        NEG.B  D0                               ; $011FF6
        NEG.L  -(A3)                            ; $011FF8
        DC.W    $4946               ; $011FFA DC.W    $4946
        LEA     $7FFF(A1),A6                    ; $011FFC
        BLS.S  loc_011FF7                       ; $012000
        DC.W    $7FFF               ; $012002 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012004 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$7FFF         ; $012006 ORI.B  #$7FFF,(A0)
        MOVE.L  A6,$7FFF(A4)                    ; $01200A
        DC.W    $0000,$4E73         ; $01200E ORI.B  #$4E73,D0
        BEQ.S  loc_01204D                       ; $012012
        DC.W    $7FFF               ; $012014 MOVE.W  <EA:3F>,<EA:3F>
        BLS.S  loc_01204F                       ; $012016
        BEQ.S  loc_012051                       ; $012018
        BMI.S  loc_012074                       ; $01201A
        BLE.S  loc_012097                       ; $01201C
        BMI.S  loc_012056                       ; $01201E
        BMI.S  loc_012059                       ; $012020
        BLE.S  loc_01207C                       ; $012022
        BLE.S  loc_01209F                       ; $012024
        MOVE.W  (A2)+,-$18(A1,D6.W)             ; $012026
        DC.W    $7FFF               ; $01202A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01202C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01202E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012030 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012032 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012034 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.B  -(A1),(A0)+                     ; $012036
        MOVE.L  $4670(A0),$37(A4,D6.W)          ; $012038
loc_01203E:
        NEG.W  D5                               ; $01203E
        SUBQ.B  #8,$6212(A3)                    ; $012040
        BGT.S  loc_01203E                       ; $012044
        DC.W    $7FFF               ; $012046 MOVE.W  <EA:3F>,<EA:3F>
        BTST    D1,(A7)+                        ; $012048
        DC.W    $7FFF               ; $01204A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01204C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01204E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012050 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012052 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012054 MOVE.W  <EA:3F>,<EA:3F>
loc_012056:
        JSR     $00882080                       ; $012056
        MOVE.W  $C87E.W,D0                      ; $01205C
        MOVEA.L $04(PC,D0.W),A1                 ; $012060
        JMP     (A1)                            ; $012064
        ORI.L  #$20840089,A1                    ; $012066
        MOVE.L  -(A4),D1                        ; $01206C
        ORI.L  #$250C4EBA,A1                    ; $01206E
loc_012074:
        SUB.B  (A0),D3                          ; $012074
        BTST    #6,$C80E.W                      ; $012076
loc_01207C:
        BNE.S  loc_012082                       ; $01207C
        ADDQ.W  #4,$C87E.W                      ; $01207E
loc_012082:
        RTS                                     ; $012082
        CLR.W  D0                               ; $012084
        JSR     $00E52C(PC)                     ; $012086
        MOVEA.L #$06018000,A0                   ; $01208A
        MOVEA.L #$04004C74,A1                   ; $012090
        MOVE.W  #$0058,D0                       ; $012096
        MOVE.W  #$0010,D1                       ; $01209A
        JSR     $00E35A(PC)                     ; $01209E
        MOVEA.L #$06018900,A0                   ; $0120A2
        MOVEA.L #$04019010,A1                   ; $0120A8
        MOVE.W  #$0120,D0                       ; $0120AE
        MOVE.W  #$0010,D1                       ; $0120B2
        JSR     $00E35A(PC)                     ; $0120B6
        MOVEA.L #$06019B00,A0                   ; $0120BA
        MOVEA.L #$0401C010,A1                   ; $0120C0
        MOVE.W  #$0120,D0                       ; $0120C6
        MOVE.W  #$0010,D1                       ; $0120CA
        JSR     $00E35A(PC)                     ; $0120CE
        MOVEQ   #$00,D0                         ; $0120D2
        TST.B  $A01A.W                          ; $0120D4
        BNE.S  loc_0120E4                       ; $0120D8
        MOVE.B  $A019.W,D0                      ; $0120DA
        MOVE.W  #$0010,D2                       ; $0120DE
        BRA.S  loc_0120EC                       ; $0120E2
loc_0120E4:
        MOVE.B  $A01B.W,D0                      ; $0120E4
        MOVE.W  #$FFC0,D2                       ; $0120E8
loc_0120EC:
        MOVE.B  D0,D3                           ; $0120EC
        LEA     $008921FA,A1                    ; $0120EE
        ADD.W  D0,D0                            ; $0120F4
        ADD.W  D0,D0                            ; $0120F6
        MOVEA.L $00(A1,D0.W),A0                 ; $0120F8
        MOVE.W  #$0061,D0                       ; $0120FC
        TST.B  D3                               ; $012100
        BNE.S  loc_012108                       ; $012102
        MOVE.W  #$0060,D0                       ; $012104
loc_012108:
        MOVE.W  #$0010,D1                       ; $012108
loc_01210C:
        TST.B  $00A15120                        ; $01210C
        BNE.S  loc_01210C                       ; $012112
        JSR     $00E3B4(PC)                     ; $012114
        MOVEQ   #$00,D0                         ; $012118
        TST.B  $A01A.W                          ; $01211A
        BEQ.S  loc_01212A                       ; $01211E
        MOVE.B  $A019.W,D0                      ; $012120
        MOVE.W  #$0010,D2                       ; $012124
        BRA.S  loc_012132                       ; $012128
loc_01212A:
        MOVE.B  $A01C.W,D0                      ; $01212A
        MOVE.W  #$FFC0,D2                       ; $01212E
loc_012132:
        LEA     $00892206,A1                    ; $012132
        ADD.W  D0,D0                            ; $012138
        MOVE.W  D0,D1                           ; $01213A
        ADD.W  D0,D0                            ; $01213C
        ADD.W  D1,D0                            ; $01213E
        MOVEA.L $00(A1,D0.W),A0                 ; $012140
        MOVE.W  $04(A1,D0.W),D0                 ; $012144
        MOVE.W  #$0010,D1                       ; $012148
loc_01214C:
        TST.B  $00A15120                        ; $01214C
        BNE.S  loc_01214C                       ; $012152
        JSR     $00E3B4(PC)                     ; $012154
loc_012158:
        TST.B  $00A15120                        ; $012158
        BNE.S  loc_012158                       ; $01215E
        DC.W    $33FC,$0101,$00A1,$512C; $012160 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$4000,$00A1,$5128; $012168 MOVE.W  #$4000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $012170 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $012178 MOVE.B  #$0001,$00A15120
loc_012180:
        TST.B  $00A1512C                        ; $012180
        BNE.S  loc_012180                       ; $012186
        DC.W    $33FC,$0078,$00A1,$5128; $012188 MOVE.W  #$0078,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $012190 MOVE.W  #$0101,$00A1512C
        MOVEQ   #$00,D0                         ; $012198
        MOVE.B  $A019.W,D0                      ; $01219A
        TST.B  $A01A.W                          ; $01219E
        BEQ.S  loc_0121A8                       ; $0121A2
        MOVE.B  $A01B.W,D0                      ; $0121A4
loc_0121A8:
        MOVE.L  D0,$A01E.W                      ; $0121A8
        MOVEQ   #$00,D0                         ; $0121AC
        MOVE.B  $A019.W,D0                      ; $0121AE
        TST.B  $A01A.W                          ; $0121B2
        BNE.S  loc_0121BC                       ; $0121B6
        MOVE.B  $A01C.W,D0                      ; $0121B8
loc_0121BC:
        MOVE.L  D0,$A022.W                      ; $0121BC
        MOVEA.L #$0601BE00,A0                   ; $0121C0
        MOVEQ   #$00,D1                         ; $0121C6
        MOVE.W  $A02C.W,D0                      ; $0121C8
        BEQ.S  loc_0121DC                       ; $0121CC
        SUBQ.W  #1,D0                           ; $0121CE
loc_0121D0:
        ADDI.L  #$00000280,D1                   ; $0121D0
        DBRA    D0,loc_0121D0                   ; $0121D6
        ADDA.L  D1,A0                           ; $0121DA
loc_0121DC:
        MOVEA.L $A034.W,A1                      ; $0121DC
        MOVE.W  #$0028,D0                       ; $0121E0
        MOVE.W  #$0060,D1                       ; $0121E4
        JSR     $00E35A(PC)                     ; $0121E8
        ADDQ.W  #4,$C87E.W                      ; $0121EC
        DC.W    $33FC,$0020,$00FF,$0008; $0121F0 MOVE.W  #$0020,$00FF0008
        RTS                                     ; $0121F8
        SUBI.B  #$9010,D1                       ; $0121FA
        SUBI.B  #$906F,D1                       ; $0121FE
