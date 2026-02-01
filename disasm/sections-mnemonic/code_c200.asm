; ============================================================================
; Code Section ($00C200-$00E1FF)
; Regenerated with fixed disassembler - proper mnemonics
; ============================================================================

        org     $00C200

        LEA     $9000.W,A0                      ; $00C200
        JSR     $00A1FC(PC)                     ; $00C204
        JSR     loc_00C974(PC)                  ; $00C208
        JSR     loc_00CF0C(PC)                  ; $00C20C
        JSR     loc_00CC06(PC)                  ; $00C210
        JSR     loc_00CFAE(PC)                  ; $00C214
        MOVE.W  #$0000,$C87E.W                  ; $00C218
        MOVE.W  #$0000,$C8F4.W                  ; $00C21E
        BCLR    #7,$FEB7.W                      ; $00C224
        BCLR    #0,$C81C.W                      ; $00C22A
        MOVE.W  #$C9A0,$C8C0.W                  ; $00C230
        MOVE.B  #$0002,$C80A.W                  ; $00C236
        JSR     loc_00C6DA(PC)                  ; $00C23C
        JSR     $0058C8(PC)                     ; $00C240
        JSR     $005908(PC)                     ; $00C244
        JSR     $00593C(PC)                     ; $00C248
        ANDI.B  #$00FC,$00A15181                ; $00C24C
        ORI.B  #$0001,$00A15181                 ; $00C254
        MOVE.W  #$8083,$00A15100                ; $00C25C
        JSR     $0088204A                       ; $00C264
        JSR     $008820C6                       ; $00C26A
        BSET    #6,$C875.W                      ; $00C270
        MOVE.W  $C874.W,(A5)                    ; $00C276
        JSR     $00884998                       ; $00C27A
        MOVE.W  #$0080,$A000.W                  ; $00C280
        MOVE.B  #$00C5,$C8A4.W                  ; $00C286
loc_00C28C:
        JSR     $00882080                       ; $00C28C
        JSR     $00884998                       ; $00C292
        SUBQ.W  #1,$A000.W                      ; $00C298
        BNE.S  loc_00C28C                       ; $00C29C
        MOVE.W  $C8A0.W,D0                      ; $00C29E
        LEA     $008BB1C4,A0                    ; $00C2A2
        MOVE.L  $00(A0,D0.W),$C96C.W            ; $00C2A8
        MOVE.B  #$0001,$C809.W                  ; $00C2AE
        BSET    #6,$C80E.W                      ; $00C2B4
        MOVE.B  #$0001,$C802.W                  ; $00C2BA
loc_00C2C0:
        BTST    #0,$00A15123                    ; $00C2C0
        BEQ.S  loc_00C2C0                       ; $00C2C8
        BCLR    #0,$00A15123                    ; $00C2CA
        MOVE.W  #$0102,$C8A8.W                  ; $00C2D2
        MOVE.B  #$009C,$C8A5.W                  ; $00C2D8
        JSR     $00882080                       ; $00C2DE
        JSR     $00884998                       ; $00C2E4
        MOVE.L  #$0088C30A,$00FF0002            ; $00C2EA
        MOVE.L  #$00000000,$00FF5FF8            ; $00C2F4
        MOVE.L  #$00000000,$00FF5FFC            ; $00C2FE
        RTS                                     ; $00C308
        MOVE.W  $C87E.W,D0                      ; $00C30A
        MOVEA.L $04(PC,D0.W),A1                 ; $00C30E
        JMP     (A1)                            ; $00C312
        DC.W    $0088                           ; $00C314
        AND.B  D1,$0088(A0)                     ; $00C316
        AND.W  D1,$0088(A0)                     ; $00C31A
        AND.L  D1,(A0)                          ; $00C31E
        DC.W    $0088                           ; $00C320
        MULS    #$0088,D1                       ; $00C322
        AND.W  (A6)+,D2                         ; $00C326
        JSR     $008828C2                       ; $00C328
        JSR     $008821CA                       ; $00C32E
        MOVE.W  $C86C.W,-(A7)                   ; $00C334
        MOVE.W  #$FF00,$C86C.W                  ; $00C338
        BTST    #0,$C81C.W                      ; $00C33E
        BNE.S  loc_00C34C                       ; $00C344
        JSR     $008888BE                       ; $00C346
loc_00C34C:
        MOVE.W  (A7)+,$C86C.W                   ; $00C34C
        JSR     $008858C8                       ; $00C350
        ADDQ.B  #1,$C886.W                      ; $00C356
        ADDQ.W  #4,$C87E.W                      ; $00C35A
        MOVE.W  #$0010,$00FF0008                ; $00C35E
        RTS                                     ; $00C366
        JSR     $008821CA                       ; $00C368
        JSR     $008825B0                       ; $00C36E
        JSR     $00BA18(PC)                     ; $00C374
        JSR     $00885908                       ; $00C378
        ADDQ.B  #1,$C886.W                      ; $00C37E
        ADDQ.W  #4,$C87E.W                      ; $00C382
        MOVE.W  #$0010,$00FF0008                ; $00C386
        RTS                                     ; $00C38E
        JSR     $008821CA                       ; $00C390
        JSR     $0088179E                       ; $00C396
        ADDQ.W  #1,$C080.W                      ; $00C39C
        ADDQ.W  #1,$C8AA.W                      ; $00C3A0
        MOVE.L  #$FFFF0000,$C970.W              ; $00C3A4
        MOVEA.W $C8C0.W,A0                      ; $00C3AC
        MOVE.B  (A0)+,D0                        ; $00C3B0
        MOVE.B  D0,D1                           ; $00C3B2
        ANDI.B  #$005C,D0                       ; $00C3B4
        MOVE.B  D0,$C971.W                      ; $00C3B8
        ANDI.B  #$0003,D1                       ; $00C3BC
        MOVE.B  D1,$C973.W                      ; $00C3C0
        MOVE.W  A0,$C8C0.W                      ; $00C3C4
        JSR     $0088593C                       ; $00C3C8
        JSR     $008824CA                       ; $00C3CE
        JSR     $00B6DA(PC)                     ; $00C3D4
        JSR     $00B684(PC)                     ; $00C3D8
        ADDQ.B  #1,$C886.W                      ; $00C3DC
        ADDQ.W  #4,$C87E.W                      ; $00C3E0
        MOVE.W  #$0038,$00FF0008                ; $00C3E4
        JSR     loc_00C416(PC)                  ; $00C3EC
        JSR     loc_00C5AE(PC)                  ; $00C3F0
        JSR     $00C070(PC)                     ; $00C3F4
        JMP     loc_00C662(PC)                  ; $00C3F8
        JSR     $008821CA                       ; $00C3FC
        JSR     $0088179E                       ; $00C402
        ADDQ.B  #1,$C886.W                      ; $00C408
        MOVE.W  #$0038,$00FF0008                ; $00C40C
        RTS                                     ; $00C414
loc_00C416:
        MOVEQ   #$00,D0                         ; $00C416
        MOVE.B  $C8F5.W,D0                      ; $00C418
        MOVE.W  $2E(PC,D0.W),D0                 ; $00C41C
        CMP.W  $C080.W,D0                       ; $00C420
        BNE.S  loc_00C44A                       ; $00C424
        JSR     $008849AA                       ; $00C426
        MOVE.W  #$0010,$C87E.W                  ; $00C42C
        MOVE.W  #$0C00,$C8C4.W                  ; $00C432
        MOVE.B  #$0004,$C082.W                  ; $00C438
        ADDQ.B  #2,$C8F5.W                      ; $00C43E
        MOVE.W  #$0044,$00FF0008                ; $00C442
loc_00C44A:
        RTS                                     ; $00C44A
        DC.W    $0089                           ; $00C44C
        BTST    D0,(A7)                         ; $00C44E
        BCHG    D0,$01E0(A2)                    ; $00C450
        ANDI.W  #$02E2,(A6)+                    ; $00C454
        BCHG    D1,A5                           ; $00C458
        MOVE.B  D0,D0                           ; $00C45A
        MOVE.B  D0,D0                           ; $00C45C
        JSR     $008821CA                       ; $00C45E
        MOVEQ   #$00,D0                         ; $00C464
        MOVE.B  $C8C4.W,D0                      ; $00C466
        MOVEA.L $04(PC,D0.W),A1                 ; $00C46A
        JMP     (A1)                            ; $00C46E
        DC.W    $0088                           ; $00C470
        AND.L  D0,D2                            ; $00C472
        DC.W    $0088                           ; $00C474
        AND.L  -(A4),D2                         ; $00C476
        DC.W    $0088                           ; $00C478
        MULU    D2,D2                           ; $00C47A
        DC.W    $0088                           ; $00C47C
        AND.B  D2,#$4EB9                        ; $00C47E
        DC.W    $0088                           ; $00C482
        MOVE.L  D2,(A4)+                        ; $00C484
        JSR     $008825B0                       ; $00C486
        JSR     $00886D9C                       ; $00C48C
        ADDQ.B  #1,$C886.W                      ; $00C492
        ADDQ.B  #4,$C8C4.W                      ; $00C496
        MOVE.W  #$0010,$00FF0008                ; $00C49A
        RTS                                     ; $00C4A2
        JSR     $0088BA18                       ; $00C4A4
        JSR     $00886DC8                       ; $00C4AA
        ADDQ.B  #1,$C886.W                      ; $00C4B0
        ADDQ.B  #4,$C8C4.W                      ; $00C4B4
        MOVE.W  #$0010,$00FF0008                ; $00C4B8
        RTS                                     ; $00C4C0
        JSR     $0088179E                       ; $00C4C2
        ADDQ.W  #1,$C080.W                      ; $00C4C8
        ADDQ.W  #1,$C8AA.W                      ; $00C4CC
        MOVE.L  #$FFFF0000,$C970.W              ; $00C4D0
        MOVEA.W $C8C0.W,A0                      ; $00C4D8
        MOVE.B  (A0)+,D0                        ; $00C4DC
        MOVE.B  D0,D1                           ; $00C4DE
        ANDI.B  #$005C,D0                       ; $00C4E0
        MOVE.B  D0,$C971.W                      ; $00C4E4
        ANDI.B  #$0003,D1                       ; $00C4E8
        MOVE.B  D1,$C973.W                      ; $00C4EC
        MOVE.W  A0,$C8C0.W                      ; $00C4F0
        JSR     $00886DF0                       ; $00C4F4
        JSR     $008824CA                       ; $00C4FA
        ADDQ.B  #1,$C886.W                      ; $00C500
        ADDQ.B  #4,$C8C4.W                      ; $00C504
        MOVE.W  #$0044,$00FF0008                ; $00C508
        MOVEQ   #$00,D0                         ; $00C510
        MOVE.B  $C082.W,D0                      ; $00C512
        MOVEA.L $14(PC,D0.W),A1                 ; $00C516
        JSR     (A1)                            ; $00C51A
        JSR     $00C070(PC)                     ; $00C51C
        JSR     $00B6DA(PC)                     ; $00C520
        JSR     $00B684(PC)                     ; $00C524
        JMP     loc_00C662(PC)                  ; $00C528
        DC.W    $0088                           ; $00C52C
        AND.W  D2,D2                            ; $00C52E
        DC.W    $0088                           ; $00C530
        AND.W  D2,D4                            ; $00C532
        DC.W    $0088                           ; $00C534
        AND.L  D2,D6                            ; $00C536
        DC.W    $0088                           ; $00C538
        AND.L  D2,(A2)                          ; $00C53A
        ADDQ.B  #1,$C886.W                      ; $00C53C
        RTS                                     ; $00C540
        RTS                                     ; $00C542
        ADDQ.B  #4,$C082.W                      ; $00C544
        MOVEQ   #$00,D0                         ; $00C548
        MOVE.B  $C8F5.W,D0                      ; $00C54A
        LSR.W  #1,D0                            ; $00C54E
        SUBQ.W  #1,D0                           ; $00C550
        MOVE.B  $16(PC,D0.W),$C083.W            ; $00C552
        ADD.W  D0,D0                            ; $00C558
        MOVE.W  $18(PC,D0.W),$C0FC.W            ; $00C55A
        MOVE.W  #$0034,$00FF0008                ; $00C560
        RTS                                     ; $00C568
        MOVE.L  #$64646450,D4                   ; $00C56A
        BCC.S  loc_00C5EA                       ; $00C570
        ADDQ.B  #8,D0                           ; $00C572
        ORI.B  #$0002,D1                        ; $00C574
        ORI.B  #$0004,D3                        ; $00C578
        ORI.B  #$0006,D5                        ; $00C57C
        ORI.B  #$0008,D7                        ; $00C580
        ORI.B  #$5338,D0                        ; $00C584
        AND.L  D3,D0                            ; $00C588
        BNE.S  loc_00C590                       ; $00C58A
        ADDQ.B  #4,$C082.W                      ; $00C58C
loc_00C590:
        RTS                                     ; $00C590
        MOVE.W  #$003C,$00FF0008                ; $00C592
        MOVE.B  #$0000,$C082.W                  ; $00C59A
        MOVE.W  #$0000,$C0FC.W                  ; $00C5A0
        MOVE.B  #$0018,$C8C5.W                  ; $00C5A6
        RTS                                     ; $00C5AC
loc_00C5AE:
        MOVE.W  $C080.W,D0                      ; $00C5AE
        CMPI.W  #$03E3,D0                       ; $00C5B2
        BLT.W  loc_00C660                       ; $00C5B6
        CMPI.W  #$03E3,D0                       ; $00C5BA
        BNE.S  loc_00C618                       ; $00C5BE
        BSET    #0,$C81C.W                      ; $00C5C0
        MOVE.W  #$00C0,$C0C8.W                  ; $00C5C6
        MOVE.W  #$0100,$00FF60CC                ; $00C5CC
        MOVE.W  $C8DA.W,$C0AE.W                 ; $00C5D4
        MOVE.W  #$0000,$C0B0.W                  ; $00C5DA
        MOVE.W  #$0000,$C0B2.W                  ; $00C5E0
        MOVE.W  $C8DC.W,$C054.W                 ; $00C5E6
        MOVE.W  $C8DE.W,$C056.W                 ; $00C5EC
        MOVE.W  #$0000,$C0C6.W                  ; $00C5F2
        MOVE.W  #$0000,$C0BA.W                  ; $00C5F8
        BSET    #1,$C313.W                      ; $00C5FE
        BCLR    #3,$C313.W                      ; $00C604
        MOVE.B  #$0000,$C896.W                  ; $00C60A
        MOVE.W  #$0008,$C0FC.W                  ; $00C610
        RTS                                     ; $00C616
loc_00C618:
        ADDQ.W  #2,$C0C6.W                      ; $00C618
        CMPI.W  #$0030,$C0C6.W                  ; $00C61C
        BLE.S  loc_00C62A                       ; $00C622
        MOVE.W  #$0030,$C0C6.W                  ; $00C624
loc_00C62A:
        ADDI.W  #$0080,$C0B0.W                  ; $00C62A
        CMPI.W  #$1000,$C0B0.W                  ; $00C630
        BLE.S  loc_00C63E                       ; $00C636
        MOVE.W  #$1000,$C0B0.W                  ; $00C638
loc_00C63E:
        CMPI.W  #$04D9,$C080.W                  ; $00C63E
        BNE.S  loc_00C64C                       ; $00C644
        JSR     $00882066                       ; $00C646
loc_00C64C:
        CMPI.W  #$0510,$C080.W                  ; $00C64C
        BLT.S  loc_00C660                       ; $00C652
        TST.B  $C8F4.W                          ; $00C654
        BNE.S  loc_00C660                       ; $00C658
        MOVE.B  #$0004,$C8F4.W                  ; $00C65A
loc_00C660:
        RTS                                     ; $00C660
loc_00C662:
        MOVEQ   #$00,D0                         ; $00C662
        MOVE.B  $C8F4.W,D0                      ; $00C664
        MOVEA.L $04(PC,D0.W),A1                 ; $00C668
        JMP     (A1)                            ; $00C66C
        DC.W    $0088                           ; $00C66E
        AND.W  <EA:3E>,D3                       ; $00C670
        DC.W    $0088                           ; $00C672
        AND.L  D0,D3                            ; $00C674
        DC.W    $0088                           ; $00C676
        AND.L  -(A4),D3                         ; $00C678
        DC.W    $0088                           ; $00C67A
        AND.L  $75(A6,D4.L),D3                  ; $00C67C
        MOVE.B  #$0001,$C809.W                  ; $00C680
        MOVE.B  #$0001,$C80A.W                  ; $00C686
        BSET    #7,$C80E.W                      ; $00C68C
        MOVE.B  #$0001,$C802.W                  ; $00C692
        MOVE.B  #$00F3,$C822.W                  ; $00C698
        ADDQ.B  #4,$C8F4.W                      ; $00C69E
        RTS                                     ; $00C6A2
        BTST    #7,$C80E.W                      ; $00C6A4
        BNE.S  loc_00C6B4                       ; $00C6AA
        MOVE.W  #$8B00,(A5)                     ; $00C6AC
        ADDQ.B  #4,$C8F4.W                      ; $00C6B0
loc_00C6B4:
        RTS                                     ; $00C6B4
        MOVE.B  #$0000,$C8F4.W                  ; $00C6B6
        BCLR    #7,$C81C.W                      ; $00C6BC
        MOVE.L  #$00894262,$00FF0002            ; $00C6C2
        MOVE.W  #$0020,$00FF0008                ; $00C6CC
        JMP     $00882890                       ; $00C6D4
loc_00C6DA:
        LEA     $008BB45C,A1                    ; $00C6DA
        LEA     $B000.W,A2                      ; $00C6E0
        JSR     $0048EA(PC)                     ; $00C6E4
        LEA     $008BAFC4,A1                    ; $00C6E8
        LEA     $B400.W,A2                      ; $00C6EE
        JSR     $0048D2(PC)                     ; $00C6F2
        LEA     $008BA220,A1                    ; $00C6F6
        MOVE.W  $C8A0.W,D0                      ; $00C6FC
        MOVEA.L $00(A1,D0.W),A1                 ; $00C700
        LEA     $00FF6E00,A2                    ; $00C704
        JSR     $0048D2(PC)                     ; $00C70A
        LEA     $008BAE38,A1                    ; $00C70E
        MOVE.W  $C8CC.W,D0                      ; $00C714
        MOVEA.L $00(A1,D0.W),A1                 ; $00C718
        LEA     $00FF6E40,A2                    ; $00C71C
        JSR     $0048EA(PC)                     ; $00C722
        MOVE.B  #$0003,$C80A.W                  ; $00C726
        LEA     $C200.W,A2                      ; $00C72C
        LEA     $EEE0.W,A1                      ; $00C730
        JSR     $00884920                       ; $00C734
        MOVE.L  $EEFC.W,$C254.W                 ; $00C73A
        MOVE.W  #$00C0,$C054.W                  ; $00C740
        MOVE.W  #$0540,$C056.W                  ; $00C746
        MOVE.W  #$0000,$C896.W                  ; $00C74C
        JSR     $006F5C(PC)                     ; $00C752
        JSR     $0088BE(PC)                     ; $00C756
        MOVE.W  #$00C0,$C0C8.W                  ; $00C75A
        MOVE.W  #$07D0,$C8D4.W                  ; $00C760
        MOVE.W  #$0600,$C8D6.W                  ; $00C766
        MOVE.W  #$3000,$C8D8.W                  ; $00C76C
        MOVE.W  #$0000,$C8DA.W                  ; $00C772
        MOVE.W  #$00C0,$C8DC.W                  ; $00C778
        MOVE.W  #$0540,$C8DE.W                  ; $00C77E
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,-(A7); $00C784
        MOVEQ   #$00,D1                         ; $00C788
        LEA     $0036(PC),A1                    ; $00C78A
        LEA     $9100.W,A2                      ; $00C78E
        MOVEQ   #$0E,D0                         ; $00C792
loc_00C794:
        MOVE.W  (A1),$00B6(A2)                  ; $00C794
        MOVE.W  (A1)+,$000A(A2)                 ; $00C798
        LEA     $0100(A2),A2                    ; $00C79C
        DBRA    D0,loc_00C794                   ; $00C7A0
        MOVE.L  #$0088C7E0,$C280.W              ; $00C7A4
        LEA     $0093C0EC,A0                    ; $00C7AC
        MOVEA.W $C8C0.W,A1                      ; $00C7B2
        JSR     $008813B4                       ; $00C7B6
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6; $00C7BC
        RTS                                     ; $00C7C0
        SUBI.L  #$04830471,$046E(A1)            ; $00C7C2
        SUBI.W  #$0456,-(A2)                    ; $00C7CA
        SUBI.W  #$0433,D4                       ; $00C7CE
        SUBI.B  #$040E,$03F3(A1)                ; $00C7D2
        BSET    D1,-(A2)                        ; $00C7D8
        BSET    D1,(A7)                         ; $00C7DA
        BSET    D1,D1                           ; $00C7DC
        BSET    D1,D0                           ; $00C7DE
        ORI.B  #$0050,$0064(PC)                 ; $00C7E0
        ORI.L  #$41F90089,D3                    ; $00C7E6
        MOVE.L  #$43F8EF08,-(A7)                ; $00C7EC
        JSR     $008813B4                       ; $00C7F2
        LEA     $0089B6AC,A1                    ; $00C7F8
        LEA     $FA48.W,A2                      ; $00C7FE
        JSR     $0048EA(PC)                     ; $00C802
        JSR     $004922(PC)                     ; $00C806
        LEA     $0089B73C,A1                    ; $00C80A
        LEA     $FDAA.W,A2                      ; $00C810
        MOVEQ   #$35,D7                         ; $00C814
loc_00C816:
        MOVE.L  (A1)+,(A2)+                     ; $00C816
        DBRA    D7,loc_00C816                   ; $00C818
        MOVEQ   #$00,D0                         ; $00C81C
        MOVE.B  D0,$FEA5.W                      ; $00C81E
        MOVE.B  D0,$FEA6.W                      ; $00C822
        MOVE.B  D0,$FEAB.W                      ; $00C826
        MOVE.B  D0,$FEA7.W                      ; $00C82A
        MOVE.B  D0,$FDA8.W                      ; $00C82E
        MOVE.B  D0,$EF07.W                      ; $00C832
        MOVE.B  D0,$FEB7.W                      ; $00C836
        MOVE.B  D0,$FEB1.W                      ; $00C83A
        MOVE.B  #$0002,$FEAD.W                  ; $00C83E
        MOVE.B  #$0002,$FEAE.W                  ; $00C844
        MOVE.B  #$00FF,$FEA4.W                  ; $00C84A
        MOVE.B  #$0000,$C825.W                  ; $00C850
        JMP     $0088A83E                       ; $00C856
loc_00C85C:
        MOVEQ   #$00,D1                         ; $00C85C
        LEA     $00FF6000,A1                    ; $00C85E
        JSR     $00884836                       ; $00C864
        JMP     $0088483E                       ; $00C86A
        BSR.S  loc_00C85C                       ; $00C870
        MOVE.W  $C8CC.W,D0                      ; $00C872
        LEA     $00895488,A1                    ; $00C876
        MOVEA.L $00(A1,D0.W),A1                 ; $00C87C
        TST.B  $C80F.W                          ; $00C880
        BEQ.S  loc_00C8A6                       ; $00C884
        LEA     $00895560,A1                    ; $00C886
        MOVEA.L $00(A1,D0.W),A1                 ; $00C88C
        LEA     $00FF6330,A2                    ; $00C890
        JSR     $00884920                       ; $00C896
        LEA     $008954F4,A1                    ; $00C89C
        MOVEA.L $00(A1,D0.W),A1                 ; $00C8A2
loc_00C8A6:
        LEA     $00FF6100,A2                    ; $00C8A6
        JSR     $00884920                       ; $00C8AC
        MOVE.W  (A1)+,$C054.W                   ; $00C8B2
        MOVE.W  (A1)+,$C056.W                   ; $00C8B6
        MOVE.L  (A1)+,$C0C8.W                   ; $00C8BA
        MOVE.W  (A1)+,$C0CC.W                   ; $00C8BE
        MOVE.W  (A1),$00FF60CC                  ; $00C8C2
        MOVE.W  #$0070,$00FF60CE                ; $00C8C8
        LEA     $C0AE.W,A1                      ; $00C8D0
        MOVEQ   #$00,D1                         ; $00C8D4
        MOVE.L  D1,(A1)+                        ; $00C8D6
        MOVE.L  D1,(A1)+                        ; $00C8D8
        MOVE.L  D1,(A1)                         ; $00C8DA
        MOVE.L  #$00FF9000,$C888.W              ; $00C8DC
        RTS                                     ; $00C8E4
        ADDQ.B  #2,D0                           ; $00C8E6
        SUBQ.B  #2,D0                           ; $00C8E8
        ADDQ.B  #5,D0                           ; $00C8EA
        SUBQ.B  #5,D0                           ; $00C8EC
        TST.B  D0                               ; $00C8EE
        DC.W    $4B00                           ; $00C8F0
        MOVE.W  $C8CC.W,D0                      ; $00C8F2
        MOVE.W  -$12(PC,D0.W),$00FF6122         ; $00C8F6
        MOVE.W  -$18(PC,D0.W),$00FF6352         ; $00C8FE
        LEA     $008957A0,A1                    ; $00C906
        BSR.S  loc_00C962                       ; $00C90C
        LEA     $00FF6114,A1                    ; $00C90E
        LEA     $008957A0,A4                    ; $00C914
        BSR.S  loc_00C986                       ; $00C91A
        JSR     loc_00C9AE(PC)                  ; $00C91C
        LEA     $00FF6218,A1                    ; $00C920
        LEA     $008957A0,A4                    ; $00C926
        BSR.S  loc_00C986                       ; $00C92C
        MOVE.L  $C754.W,$00FF6228               ; $00C92E
        LEA     $00FF6344,A1                    ; $00C936
        LEA     $008957A0,A4                    ; $00C93C
        BSR.S  loc_00C986                       ; $00C942
        BSR.S  loc_00C9AE                       ; $00C944
        MOVE.L  $C754.W,$00FF6354               ; $00C946
        LEA     $00FF6448,A1                    ; $00C94E
        LEA     $008957A0,A4                    ; $00C954
        BRA.S  loc_00C986                       ; $00C95A
loc_00C95C:
        LEA     $008956C8,A1                    ; $00C95C
loc_00C962:
        MOVE.W  $C8CC.W,D0                      ; $00C962
        MOVEA.L $00(A1,D0.W),A1                 ; $00C966
        LEA     $C710.W,A2                      ; $00C96A
        JMP     $008848FE                       ; $00C96E
loc_00C974:
        BSR.S  loc_00C95C                       ; $00C974
        LEA     $00FF6114,A1                    ; $00C976
        BSR.S  loc_00C980                       ; $00C97C
        BRA.S  loc_00C9AE                       ; $00C97E
loc_00C980:
        LEA     $008956C8,A4                    ; $00C980
loc_00C986:
        MOVEA.L $C734.W,A3                      ; $00C986
        MOVE.W  $C8CC.W,D0                      ; $00C98A
        MOVEA.L $00(A4,D0.W),A4                 ; $00C98E
        MOVEQ   #$01,D0                         ; $00C992
        MOVE.W  D0,(A1)                         ; $00C994
        LEA     $0010(A1),A1                    ; $00C996
        MOVE.L  (A4)+,(A1)+                     ; $00C99A
        BSR.S  loc_00C9A2                       ; $00C99C
        BSR.S  loc_00C9A2                       ; $00C99E
        NOP                                     ; $00C9A0
loc_00C9A2:
        MOVE.W  D0,(A1)+                        ; $00C9A2
        MOVE.L  (A3)+,(A1)+                     ; $00C9A4
        MOVE.W  (A3)+,(A1)+                     ; $00C9A6
        ADDQ.L  #8,A1                           ; $00C9A8
        MOVE.L  (A4)+,(A1)+                     ; $00C9AA
        RTS                                     ; $00C9AC
loc_00C9AE:
        MOVE.W  D0,(A1)                         ; $00C9AE
        MOVE.L  (A4)+,$0010(A1)                 ; $00C9B0
        RTS                                     ; $00C9B4
        LEA     $00898C80,A1                    ; $00C9B6
        BTST    #3,$C80E.W                      ; $00C9BC
        BEQ.S  loc_00C9CA                       ; $00C9C2
        LEA     $00898F00,A1                    ; $00C9C4
loc_00C9CA:
        LEA     $00FF6800,A2                    ; $00C9CA
        MOVEQ   #$1F,D0                         ; $00C9D0
loc_00C9D2:
        MOVE.L  (A1)+,(A2)+                     ; $00C9D2
        MOVE.L  (A1)+,(A2)+                     ; $00C9D4
        MOVE.L  (A1)+,(A2)+                     ; $00C9D6
        MOVE.L  (A1)+,(A2)+                     ; $00C9D8
        DBRA    D0,loc_00C9D2                   ; $00C9DA
        RTS                                     ; $00C9DE
        LEA     $00899500,A1                    ; $00C9E0
        LEA     $00FF6800,A2                    ; $00C9E6
        MOVEQ   #$1F,D0                         ; $00C9EC
        BRA.S  loc_00C9D2                       ; $00C9EE
        LEA     $00899100,A1                    ; $00C9F0
        LEA     $00FF6800,A2                    ; $00C9F6
        MOVEQ   #$1F,D0                         ; $00C9FC
        BRA.S  loc_00C9D2                       ; $00C9FE
        LEA     $00899300,A1                    ; $00CA00
        LEA     $00FF6800,A2                    ; $00CA06
        MOVEQ   #$1F,D0                         ; $00CA0C
        BRA.S  loc_00C9D2                       ; $00CA0E
        LEA     $00899700,A1                    ; $00CA10
        LEA     $00FF6800,A2                    ; $00CA16
        MOVEQ   #$07,D0                         ; $00CA1C
        BRA.S  loc_00C9D2                       ; $00CA1E
        LEA     $00898E80,A1                    ; $00CA20
        LEA     $00FF6800,A2                    ; $00CA26
        MOVEQ   #$07,D0                         ; $00CA2C
        BSR.S  loc_00C9D2                       ; $00CA2E
        MOVEQ   #$00,D1                         ; $00CA30
        MOVEQ   #$17,D0                         ; $00CA32
loc_00CA34:
        MOVE.B  D1,(A2)                         ; $00CA34
        LEA     $0010(A2),A2                    ; $00CA36
        DBRA    D0,loc_00CA34                   ; $00CA3A
        MOVE.W  D1,$00FF6740                    ; $00CA3E
        MOVE.W  D1,$00FF672C                    ; $00CA44
        RTS                                     ; $00CA4A
        MOVE.B  #$0004,$00FF6920                ; $00CA4C
        MOVE.B  #$0001,$00FF6880                ; $00CA54
        MOVE.B  #$0001,$00FF69A0                ; $00CA5C
        RTS                                     ; $00CA64
        MOVE.B  #$0004,$00FF6920                ; $00CA66
        MOVE.B  #$0001,$00FF6880                ; $00CA6E
        MOVE.B  #$0001,$00FF6800                ; $00CA76
        RTS                                     ; $00CA7E
        MOVE.B  #$0004,$00FF6910                ; $00CA80
        MOVE.B  #$0001,$00FF6870                ; $00CA88
        MOVE.B  #$0001,$00FF69D0                ; $00CA90
        RTS                                     ; $00CA98
        BSR.S  loc_00CAD0                       ; $00CA9A
        JMP     loc_00CBCA(PC)                  ; $00CA9C
        BSR.S  loc_00CAD0                       ; $00CAA0
        MOVE.W  #$004E,$00FF6744                ; $00CAA2
        MOVE.W  $C8C8.W,D0                      ; $00CAAA
        BEQ.W  loc_00CBCA                       ; $00CAAE
        CMPI.W  #$0001,D0                       ; $00CAB2
        BNE.S  loc_00CAC4                       ; $00CAB6
        MOVE.W  #$0050,$00FF6744                ; $00CAB8
        JMP     loc_00CBCA(PC)                  ; $00CAC0
loc_00CAC4:
        MOVE.W  #$0050,$00FF6744                ; $00CAC4
        JMP     loc_00CBCA(PC)                  ; $00CACC
loc_00CAD0:
        MOVE.W  $C8CC.W,D0                      ; $00CAD0
        LEA     $00898C68,A1                    ; $00CAD4
        MOVE.L  $00(A1,D0.W),$00FF6858          ; $00CADA
        LEA     $0012(PC),A1                    ; $00CAE2
        MOVEA.L $00(A1,D0.W),A1                 ; $00CAE6
        LEA     $00FF6740,A2                    ; $00CAEA
        JMP     $00884920                       ; $00CAF0
        DC.W    $0088                           ; $00CAF6
        AND.B  D5,D2                            ; $00CAF8
        DC.W    $0088                           ; $00CAFA
        AND.B  D5,(A6)                          ; $00CAFC
        DC.W    $0088                           ; $00CAFE
        AND.B  D5,$0001(A2)                     ; $00CB00
        MOVE.W  $0036(A4),$0000(A7)             ; $00CB04
        ORI.B  #$0000,D0                        ; $00CB0A
        BTST    #7,D0                           ; $00CB0E
        MOVE.L  $59D6(A1),D1                    ; $00CB12
        ORI.B  #$FF6C,D1                        ; $00CB16
        ORI.B  #$0000,$0000.W                   ; $00CB1A
        ORI.B  #$0800,D0                        ; $00CB20
        ORI.L  #$222959D6,D4                    ; $00CB24
        ORI.B  #$FF6F,D1                        ; $00CB2A
        ORI.B  #$0000,$0000.W                   ; $00CB2E
        ORI.B  #$0800,D0                        ; $00CB34
        ORI.L  #$222959D6,D4                    ; $00CB38
        MOVE.W  $C8CC.W,D0                      ; $00CB3E
        LEA     $00898C74,A1                    ; $00CB42
        MOVE.L  $00(A1,D0.W),$00FF6858          ; $00CB48
        MOVE.L  $00(A1,D0.W),$00FF69B8          ; $00CB50
        LEA     $0028(PC),A1                    ; $00CB58
        MOVEA.L $00(A1,D0.W),A1                 ; $00CB5C
        LEA     $00FF631C,A2                    ; $00CB60
        JSR     $00884920                       ; $00CB66
        LEA     $0014(PC),A1                    ; $00CB6C
        MOVEA.L $00(A1,D0.W),A1                 ; $00CB70
        LEA     $00FF654C,A2                    ; $00CB74
        JSR     $00884920                       ; $00CB7A
        BRA.S  loc_00CBCA                       ; $00CB80
        DC.W    $0088                           ; $00CB82
        AND.L  D5,A6                            ; $00CB84
        DC.W    $0088                           ; $00CB86
        AND.L  D5,-(A2)                         ; $00CB88
        DC.W    $0088                           ; $00CB8A
        AND.L  D5,$01(A6,D0.W)                  ; $00CB8C
        MOVE.W  $2B(A2,D0.W),$0000(A7)          ; $00CB90
        ORI.B  #$0000,D0                        ; $00CB96
        BTST    #12,D0                          ; $00CB9A
        MOVE.L  $59D6(A1),D1                    ; $00CB9E
        ORI.B  #$FF6C,D1                        ; $00CBA2
        ORI.B  #$0000,$0000(A4)                 ; $00CBA6
        ORI.B  #$0800,D0                        ; $00CBAC
        ORI.W  #$2229,-$2A(A2,D5.L)             ; $00CBB0
        ORI.B  #$FF73,D1                        ; $00CBB6
        ORI.B  #$0000,$0000(A4)                 ; $00CBBA
        ORI.B  #$0800,D0                        ; $00CBC0
        ORI.W  #$2229,$59D6(A3)                 ; $00CBC4
loc_00CBCA:
        MOVE.W  $C8A0.W,D0                      ; $00CBCA
        LSL.W  #2,D0                            ; $00CBCE
        LEA     $00895668,A1                    ; $00CBD0
        LEA     $00(A1,D0.W),A1                 ; $00CBD6
        LEA     $00FF672C,A2                    ; $00CBDA
        MOVE.W  #$0001,$0000(A2)                ; $00CBE0
        MOVE.L  (A1)+,$0002(A2)                 ; $00CBE6
        MOVE.W  (A1)+,$0006(A2)                 ; $00CBEA
        MOVE.W  (A1)+,$000E(A2)                 ; $00CBEE
        MOVE.L  (A1),$0010(A2)                  ; $00CBF2
        BTST    #7,$FDA8.W                      ; $00CBF6
        BEQ.S  loc_00CC04                       ; $00CBFC
        ADDI.W  #$0020,$0002(A2)                ; $00CBFE
loc_00CC04:
        RTS                                     ; $00CC04
loc_00CC06:
        LEA     $008958B4,A4                    ; $00CC06
        MOVE.W  $C8CC.W,D1                      ; $00CC0C
        MOVEA.L $00(A4,D1.W),A4                 ; $00CC10
        MOVEQ   #$01,D0                         ; $00CC14
        LEA     $00FF6218,A1                    ; $00CC16
        MOVEQ   #$0E,D7                         ; $00CC1C
loc_00CC1E:
        MOVEA.L $C73C.W,A2                      ; $00CC1E
        MOVEA.L A4,A3                           ; $00CC22
        MOVE.W  D0,$0000(A1)                    ; $00CC24
        MOVE.W  D0,$0014(A1)                    ; $00CC28
        MOVE.W  D0,$0028(A1)                    ; $00CC2C
        MOVE.L  (A3)+,$0010(A1)                 ; $00CC30
        MOVE.L  (A3)+,$0024(A1)                 ; $00CC34
        MOVE.L  (A3),$0038(A1)                  ; $00CC38
        MOVE.L  (A2)+,$0016(A1)                 ; $00CC3C
        MOVE.W  (A2)+,$001A(A1)                 ; $00CC40
        MOVE.L  (A2)+,$002A(A1)                 ; $00CC44
        MOVE.W  (A2),$002E(A1)                  ; $00CC48
        LEA     $003C(A1),A1                    ; $00CC4C
        DBRA    D7,loc_00CC1E                   ; $00CC50
        LEA     $00FF6226,A1                    ; $00CC54
        LEA     $0093816C,A2                    ; $00CC5A
        MOVEA.L $00(A2,D1.W),A2                 ; $00CC60
        MOVEQ   #$0E,D7                         ; $00CC64
loc_00CC66:
        MOVE.W  (A2)+,(A1)                      ; $00CC66
        LEA     $003C(A1),A1                    ; $00CC68
        DBRA    D7,loc_00CC66                   ; $00CC6C
        RTS                                     ; $00CC70
        RTS                                     ; $00CC72
        LEA     $008997EC,A1                    ; $00CC74
        LEA     $00(A1,D0.W),A1                 ; $00CC7A
        LEA     $C08C.W,A2                      ; $00CC7E
        JMP     $00884922                       ; $00CC82
        MOVE.B  $FEA9.W,$C30F.W                 ; $00CC88
        LEA     $9000.W,A0                      ; $00CC8E
        MOVE.B  #$0000,$C819.W                  ; $00CC92
        MOVE.W  $C094.W,$C07A.W                 ; $00CC98
        MOVE.B  #$0000,$C311.W                  ; $00CC9E
        MOVE.W  #$0001,$C048.W                  ; $00CCA4
        MOVE.B  #$0004,$C302.W                  ; $00CCAA
        MOVE.W  #$0000,$C086.W                  ; $00CCB0
        MOVE.W  #$0040,$C0E4.W                  ; $00CCB6
        LEA     $00898A04,A1                    ; $00CCBC
        MOVE.W  $C89C.W,D0                      ; $00CCC2
        MULU    #$0014,D0                       ; $00CCC6
        ADDA.L  D0,A1                           ; $00CCCA
        LEA     $C700.W,A2                      ; $00CCCC
        JSR     $00884922                       ; $00CCD0
        MOVE.L  (A1),$0018(A0)                  ; $00CCD6
        MOVE.L  (A1),$00B2(A0)                  ; $00CCDA
        LEA     $00930612,A1                    ; $00CCDE
        MOVE.W  $C8CC.W,D0                      ; $00CCE4
        MOVEA.L $00(A1,D0.W),A1                 ; $00CCE8
        MOVE.L  A1,$C268.W                      ; $00CCEC
        LEA     $009305D6,A1                    ; $00CCF0
        MOVEA.L $00(A1,D0.W),A1                 ; $00CCF6
        LEA     $C8E4.W,A2                      ; $00CCFA
        JSR     $00884922                       ; $00CCFE
        MOVE.W  #$0001,$002A(A0)                ; $00CD04
        MOVE.W  #$0001,$00A6(A0)                ; $00CD0A
        MOVE.W  #$000F,$00A4(A0)                ; $00CD10
        MOVE.W  #$0003,$00AC(A0)                ; $00CD16
        MOVE.W  #$0100,$0076(A0)                ; $00CD1C
        MOVE.W  #$0100,$0078(A0)                ; $00CD22
        MOVEQ   #$00,D0                         ; $00CD28
        MOVE.W  #$001E,$C0AC.W                  ; $00CD2A
        MOVE.B  #$0014,$C824.W                  ; $00CD30
        CMPI.W  #$0001,$C8C8.W                  ; $00CD36
        BNE.S  loc_00CD44                       ; $00CD3C
        MOVE.B  #$001E,$C824.W                  ; $00CD3E
loc_00CD44:
        MOVE.W  #$FFFF,$C05A.W                  ; $00CD44
        RTS                                     ; $00CD4A
        LEA     $00898A7C,A1                    ; $00CD4C
        MOVE.W  $C8A0.W,D7                      ; $00CD52
        MOVEA.L $00(A1,D7.W),A1                 ; $00CD56
        MOVEQ   #$0E,D7                         ; $00CD5A
        LEA     $9100.W,A0                      ; $00CD5C
        LEA     $0093814E,A3                    ; $00CD60
        MOVEQ   #$00,D0                         ; $00CD66
        MOVEQ   #$02,D1                         ; $00CD68
loc_00CD6A:
        MOVEA.L (A1)+,A2                        ; $00CD6A
        MOVE.L  A2,$0018(A0)                    ; $00CD6C
        MOVE.W  (A3)+,$00C2(A0)                 ; $00CD70
        MOVE.W  D0,$00A4(A0)                    ; $00CD74
        MOVE.W  D1,$00A6(A0)                    ; $00CD78
        ADDQ.W  #1,D0                           ; $00CD7C
        ADDQ.W  #1,D1                           ; $00CD7E
        ANDI.W  #$000F,D0                       ; $00CD80
        ANDI.W  #$000F,D1                       ; $00CD84
        LEA     $0100(A0),A0                    ; $00CD88
        DBRA    D7,loc_00CD6A                   ; $00CD8C
        RTS                                     ; $00CD90
        MOVE.L  $C260.W,-(A7)                   ; $00CD92
        LEA     $C000.W,A1                      ; $00CD96
        MOVEQ   #$00,D1                         ; $00CD9A
        JSR     $0088483A                       ; $00CD9C
        MOVE.L  (A7)+,$C260.W                   ; $00CDA2
        LEA     $9000.W,A1                      ; $00CDA6
        MOVEQ   #$00,D1                         ; $00CDAA
        MOVEQ   #$0F,D7                         ; $00CDAC
loc_00CDAE:
        JSR     $00884842                       ; $00CDAE
        DBRA    D7,loc_00CDAE                   ; $00CDB4
        MOVEQ   #$00,D1                         ; $00CDB8
        MOVE.B  D1,$C30E.W                      ; $00CDBA
        MOVE.W  D1,$C8AA.W                      ; $00CDBE
        MOVE.W  D1,$C8AC.W                      ; $00CDC2
        MOVE.W  D1,$C8AE.W                      ; $00CDC6
        MOVE.W  #$FFFF,$C026.W                  ; $00CDCA
        RTS                                     ; $00CDD0
        MOVEQ   #$0F,D7                         ; $00CDD2
        ADD.W  $C8A0.W,D0                       ; $00CDD4
        LEA     $9000.W,A0                      ; $00CDD8
        MOVE.W  $C8CC.W,D2                      ; $00CDDC
        LEA     $009382BA,A1                    ; $00CDE0
        MOVEA.L $00(A1,D2.W),A1                 ; $00CDE6
        MOVEA.L $00(A1,D0.W),A1                 ; $00CDEA
loc_00CDEE:
        BSR.S  loc_00CE3C                       ; $00CDEE
        LEA     $0100(A0),A0                    ; $00CDF0
        DBRA    D7,loc_00CDEE                   ; $00CDF4
        MOVE.L  #$00000000,$902C.W              ; $00CDF8
        RTS                                     ; $00CE00
        MOVEQ   #$00,D1                         ; $00CE02
        BSR.S  loc_00CE22                       ; $00CE04
        MOVE.W  #$000F,$00A4(A0)                ; $00CE06
        MOVE.W  #$000F,$00A6(A0)                ; $00CE0C
        LEA     $9F00.W,A0                      ; $00CE12
        BSR.S  loc_00CE3C                       ; $00CE16
        MOVE.W  D1,$00A4(A0)                    ; $00CE18
        MOVE.W  D1,$00A6(A0)                    ; $00CE1C
        RTS                                     ; $00CE20
loc_00CE22:
        LEA     $9000.W,A0                      ; $00CE22
        ADD.W  $C8A0.W,D0                       ; $00CE26
        MOVE.W  $C8CC.W,D2                      ; $00CE2A
        LEA     $009382BA,A1                    ; $00CE2E
        MOVEA.L $00(A1,D2.W),A1                 ; $00CE34
        MOVEA.L $00(A1,D0.W),A1                 ; $00CE38
loc_00CE3C:
        MOVE.W  (A1)+,$0030(A0)                 ; $00CE3C
        MOVE.W  (A1)+,$0032(A0)                 ; $00CE40
        MOVE.W  (A1)+,$0034(A0)                 ; $00CE44
        MOVE.W  (A1),$003C(A0)                  ; $00CE48
        MOVE.W  (A1)+,$0040(A0)                 ; $00CE4C
        MOVE.L  D1,$002C(A0)                    ; $00CE50
        RTS                                     ; $00CE54
        MOVEQ   #$0F,D7                         ; $00CE56
        LEA     $9000.W,A0                      ; $00CE58
        LEA     $00938EAE,A1                    ; $00CE5C
loc_00CE62:
        BSR.S  loc_00CE3C                       ; $00CE62
        LEA     $0100(A0),A0                    ; $00CE64
        DBRA    D7,loc_00CE62                   ; $00CE68
        MOVE.L  #$00000000,$902C.W              ; $00CE6C
        RTS                                     ; $00CE74
        MOVEQ   #$00,D1                         ; $00CE76
        LEA     $A800.W,A1                      ; $00CE78
        JSR     $00884842                       ; $00CE7C
        JSR     $00884846                       ; $00CE82
        JSR     $00884856                       ; $00CE88
        MOVE.B  D1,$C81D.W                      ; $00CE8E
        MOVE.B  D1,$C81F.W                      ; $00CE92
        MOVE.B  D1,$C820.W                      ; $00CE96
        MOVE.W  D1,$A9E0.W                      ; $00CE9A
        MOVE.L  #$0000C4C4,$A9E2.W              ; $00CE9E
        MOVE.L  #$0000C4C4,$A9E6.W              ; $00CEA6
        MOVE.B  #$0000,$C819.W                  ; $00CEAE
        MOVE.W  #$0000,$C8BE.W                  ; $00CEB4
        MOVE.B  $C81A.W,$C310.W                 ; $00CEBA
        RTS                                     ; $00CEC0
        LEA     $9000.W,A0                      ; $00CEC2
        MOVE.B  $FEAD.W,D0                      ; $00CEC6
        BRA.S  loc_00CED4                       ; $00CECA
        LEA     $9F00.W,A0                      ; $00CECC
        MOVE.B  $FEAE.W,D0                      ; $00CED0
loc_00CED4:
        MOVE.W  $C8CC.W,D1                      ; $00CED4
        ADD.W  D1,D1                            ; $00CED8
        ADD.W  $C8CA.W,D1                       ; $00CEDA
        EXT.W   D0                              ; $00CEDE
        ADD.W  D0,D0                            ; $00CEE0
        ADD.W  D1,D0                            ; $00CEE2
        MOVE.W  $08(PC,D0.W),D0                 ; $00CEE4
        ADD.W  D0,$C0E8.W                       ; $00CEE8
        RTS                                     ; $00CEEC
        ORI.B  #$000F,(A6)+                     ; $00CEEE
        ORI.B  #$FFF1,D0                        ; $00CEF2
        DC.W    $FFE2                           ; $00CEF6
        ORI.B  #$000F,(A6)+                     ; $00CEF8
        ORI.B  #$FFF1,D0                        ; $00CEFC
        DC.W    $FFE2                           ; $00CF00
        ORI.B  #$000F,(A6)+                     ; $00CF02
        ORI.B  #$FFF1,D0                        ; $00CF06
        DC.W    $FFE2                           ; $00CF0A
loc_00CF0C:
        LEA     $9100.W,A0                      ; $00CF0C
        MOVEQ   #$0E,D7                         ; $00CF10
loc_00CF12:
        MOVE.W  D7,-(A7)                        ; $00CF12
        JSR     $007AB6(PC)                     ; $00CF14
        JSR     $007AB6(PC)                     ; $00CF18
        JSR     $007AB6(PC)                     ; $00CF1C
        JSR     $007AB6(PC)                     ; $00CF20
        JSR     $007AB6(PC)                     ; $00CF24
        JSR     $007AB6(PC)                     ; $00CF28
        JSR     $007AB6(PC)                     ; $00CF2C
        JSR     $007AB6(PC)                     ; $00CF30
        JSR     $007AB6(PC)                     ; $00CF34
        LEA     $0093AC2C,A1                    ; $00CF38
        MOVE.W  $00C8(A0),D0                    ; $00CF3E
        SUB.W  $0032(A0),D0                     ; $00CF42
        ADD.W  D0,D0                            ; $00CF46
        BMI.S  loc_00CF54                       ; $00CF48
        ANDI.W  #$03FF,D0                       ; $00CF4A
        MOVE.W  $00(A1,D0.W),D0                 ; $00CF4E
        BRA.S  loc_00CF60                       ; $00CF52
loc_00CF54:
        NEG.W  D0                               ; $00CF54
        ANDI.W  #$03FF,D0                       ; $00CF56
        MOVE.W  $00(A1,D0.W),D0                 ; $00CF5A
        NEG.W  D0                               ; $00CF5E
loc_00CF60:
        MOVE.W  D0,$003A(A0)                    ; $00CF60
        LEA     $0093A82C,A1                    ; $00CF64
        MOVE.W  $0032(A0),D0                    ; $00CF6A
        SUB.W  $00C6(A0),D0                     ; $00CF6E
        ADD.W  D0,D0                            ; $00CF72
        BMI.S  loc_00CF80                       ; $00CF74
        ANDI.W  #$03FF,D0                       ; $00CF76
        MOVE.W  $00(A1,D0.W),D0                 ; $00CF7A
        BRA.S  loc_00CF8C                       ; $00CF7E
loc_00CF80:
        NEG.W  D0                               ; $00CF80
        ANDI.W  #$03FF,D0                       ; $00CF82
        MOVE.W  $00(A1,D0.W),D0                 ; $00CF86
        NEG.W  D0                               ; $00CF8A
loc_00CF8C:
        JSR     $00764E(PC)                     ; $00CF8C
        JSR     $00714A(PC)                     ; $00CF90
        MOVE.W  D0,$003E(A0)                    ; $00CF94
        MOVE.W  $006E(A0),$0046(A0)             ; $00CF98
        LEA     $0100(A0),A0                    ; $00CF9E
        MOVE.W  (A7)+,D7                        ; $00CFA2
        DBRA    D7,loc_00CF12                   ; $00CFA4
        JMP     $008836DE                       ; $00CFA8
loc_00CFAE:
        MOVE.W  $C8CC.W,D0                      ; $00CFAE
        LEA     $008955CC,A1                    ; $00CFB2
        MOVEA.L $00(A1,D0.W),A1                 ; $00CFB8
        LEA     $00FF6178,A2                    ; $00CFBC
loc_00CFC2:
        MOVEQ   #$07,D7                         ; $00CFC2
loc_00CFC4:
        MOVE.L  (A1)+,$0002(A2)                 ; $00CFC4
        MOVE.W  (A1)+,$0006(A2)                 ; $00CFC8
        LEA     $0014(A2),A2                    ; $00CFCC
        DBRA    D7,loc_00CFC4                   ; $00CFD0
        RTS                                     ; $00CFD4
        MOVE.W  $C8CC.W,D0                      ; $00CFD6
        LEA     $008955CC,A1                    ; $00CFDA
        MOVEA.L $00(A1,D0.W),A1                 ; $00CFE0
        MOVEA.L A1,A3                           ; $00CFE4
        LEA     $00FF6178,A2                    ; $00CFE6
        BSR.S  loc_00CFC2                       ; $00CFEC
        MOVEA.L A3,A1                           ; $00CFEE
        LEA     $00FF627C,A2                    ; $00CFF0
        BSR.S  loc_00CFC2                       ; $00CFF6
        MOVEA.L A3,A1                           ; $00CFF8
        LEA     $00FF63A8,A2                    ; $00CFFA
        BSR.S  loc_00CFC2                       ; $00D000
        MOVEA.L A3,A1                           ; $00D002
        LEA     $00FF64AC,A2                    ; $00D004
        BRA.S  loc_00CFC2                       ; $00D00A
loc_00D00C:
        LEA     $C806.W,A1                      ; $00D00C
        MOVE.B  #$0000,(A1)+                    ; $00D010
        MOVE.B  #$00C4,(A1)+                    ; $00D014
        MOVE.B  #$00C4,(A1)                     ; $00D018
        MOVE.W  #$C200,$C076.W                  ; $00D01C
        BTST    #3,$C80E.W                      ; $00D022
        BNE.S  loc_00D03A                       ; $00D028
        MOVE.L  #$61000000,$C254.W              ; $00D02A
        MOVE.L  #$60000000,$C260.W              ; $00D032
loc_00D03A:
        LEA     $0014(PC),A1                    ; $00D03A
        MOVEQ   #$00,D0                         ; $00D03E
        MOVE.B  $FDA9.W,D0                      ; $00D040
        MOVE.B  $00(A1,D0.W),$C051.W            ; $00D044
        RTS                                     ; $00D04A
        ADDQ.W  #8,D1                           ; $00D04C
        DC.W    $4100                           ; $00D04E
        ADDQ.W  #8,A3                           ; $00D050
        NOT.B  D0                               ; $00D052
        JSR     loc_00D00C(PC)                  ; $00D054
        MOVE.W  $C8A0.W,D0                      ; $00D058
        LEA     $00898C0C,A1                    ; $00D05C
        MOVE.L  $00(A1,D0.W),$00FF6868          ; $00D062
loc_00D06A:
        MOVEA.L $04(PC,D0.W),A1                 ; $00D06A
        JMP     (A1)                            ; $00D06E
        DC.W    $0088                           ; $00D070
        ADD.L  A0,D0                            ; $00D072
        DC.W    $0088                           ; $00D074
        ADD.L  A0,D0                            ; $00D076
        DC.W    $0088                           ; $00D078
        ADD.L  A0,D0                            ; $00D07A
        DC.W    $0088                           ; $00D07C
        ADD.L  A0,D0                            ; $00D07E
        DC.W    $0088                           ; $00D080
        ADD.L  A0,D0                            ; $00D082
        DC.W    $0088                           ; $00D084
        ADD.L  A0,D0                            ; $00D086
        RTS                                     ; $00D088
        MOVE.B  #$0000,$C806.W                  ; $00D08A
        MOVE.B  #$00C4,$C807.W                  ; $00D090
        MOVE.B  #$00C4,$C808.W                  ; $00D096
        MOVE.B  #$0000,$C813.W                  ; $00D09C
        MOVE.B  #$00C4,$C814.W                  ; $00D0A2
        MOVE.B  #$00C4,$C815.W                  ; $00D0A8
        MOVE.W  #$C200,$C076.W                  ; $00D0AE
        MOVE.L  #$61000000,$C254.W              ; $00D0B4
        MOVE.L  #$60000000,$C260.W              ; $00D0BC
        MOVE.W  $C8A0.W,D0                      ; $00D0C4
        JMP     loc_00D06A(PC)                  ; $00D0C8
        LEA     $FDAA.W,A1                      ; $00D0CC
        MOVE.W  $C89C.W,D1                      ; $00D0D0
        LSL.W  #5,D1                            ; $00D0D4
        ADD.W  $C8A0.W,D1                       ; $00D0D6
        MOVE.W  $C8C8.W,D0                      ; $00D0DA
        LSL.W  #3,D0                            ; $00D0DE
        ADD.W  $C8CC.W,D0                       ; $00D0E0
        ADD.W  D0,D1                            ; $00D0E4
        LEA     $00(A1,D1.W),A1                 ; $00D0E6
        LEA     $00FF68E0,A2                    ; $00D0EA
        JMP     $00884280                       ; $00D0F0
        MOVE.B  #$0003,$C80A.W                  ; $00D0F6
        LEA     $C200.W,A2                      ; $00D0FC
        LEA     $EEE0.W,A1                      ; $00D100
        JSR     $00884920                       ; $00D104
        MOVE.L  $EEFC.W,$C254.W                 ; $00D10A
        MOVE.W  #$00C0,$C054.W                  ; $00D110
        MOVE.W  #$0540,$C056.W                  ; $00D116
        MOVE.W  #$0000,$C896.W                  ; $00D11C
        LEA     $C200.W,A1                      ; $00D122
        LEA     $00FF68D8,A3                    ; $00D126
        MOVEQ   #$04,D7                         ; $00D12C
loc_00D12E:
        JSR     $00B43C(PC)                     ; $00D12E
        LEA     $0004(A1),A1                    ; $00D132
        LEA     $0010(A3),A3                    ; $00D136
        DBRA    D7,loc_00D12E                   ; $00D13A
        MOVEQ   #-$01,D1                        ; $00D13E
        MOVEQ   #$04,D7                         ; $00D140
        MOVE.L  $C254.W,D0                      ; $00D142
        LEA     $C200.W,A1                      ; $00D146
loc_00D14A:
        ADDQ.W  #1,D1                           ; $00D14A
        CMP.L  (A1)+,D0                         ; $00D14C
        DBEQ    D7,loc_00D14A                   ; $00D14E
        LSL.W  #4,D1                            ; $00D152
        LEA     $00FF68D0,A1                    ; $00D154
        LEA     $00(A1,D1.W),A1                 ; $00D15A
        MOVE.B  #$0001,$0001(A1)                ; $00D15E
        MOVE.L  A1,$C960.W                      ; $00D164
        JSR     $006C46(PC)                     ; $00D168
        JSR     $0088BE(PC)                     ; $00D16C
        MOVE.W  #$00C0,$C0C8.W                  ; $00D170
        MOVE.W  #$07D0,$C8D4.W                  ; $00D176
        MOVE.W  #$0600,$C8D6.W                  ; $00D17C
        MOVE.W  #$3000,$C8D8.W                  ; $00D182
        MOVE.W  #$0000,$C8DA.W                  ; $00D188
        MOVE.W  #$00C0,$C8DC.W                  ; $00D18E
        MOVE.W  #$0540,$C8DE.W                  ; $00D194
        RTS                                     ; $00D19A
        MOVEQ   #$00,D2                         ; $00D19C
        CMPI.W  #$0002,D0                       ; $00D19E
        BNE.S  loc_00D1A6                       ; $00D1A2
        MOVEQ   #$01,D2                         ; $00D1A4
loc_00D1A6:
        CMPI.W  #$0003,D0                       ; $00D1A6
        BNE.S  loc_00D1AE                       ; $00D1AA
        MOVEQ   #$01,D2                         ; $00D1AC
loc_00D1AE:
        MOVE.B  D2,$C826.W                      ; $00D1AE
        MOVE.W  D0,$C89C.W                      ; $00D1B2
        ADD.W  D0,D0                            ; $00D1B6
        MOVE.W  D0,$C89E.W                      ; $00D1B8
        ADD.W  D0,D0                            ; $00D1BC
        MOVE.W  D0,$C8A0.W                      ; $00D1BE
        MOVE.W  D1,$C8C8.W                      ; $00D1C2
        ADD.W  D1,D1                            ; $00D1C6
        MOVE.W  D1,$C8CA.W                      ; $00D1C8
        ADD.W  D1,D1                            ; $00D1CC
        MOVE.W  D1,$C8CC.W                      ; $00D1CE
        RTS                                     ; $00D1D2
        MOVE.W  #$0100,$00A11100                ; $00D1D4
loc_00D1DC:
        BTST    #0,$00A11100                    ; $00D1DC
        BNE.S  loc_00D1DC                       ; $00D1E4
        MOVE.W  $C874.W,D4                      ; $00D1E6
        BSET    #4,D4                           ; $00D1EA
        MOVE.W  D4,(A5)                         ; $00D1EE
        MOVE.W  #$8F01,(A5)                     ; $00D1F0
        MOVE.L  #$93FF941F,(A5)                 ; $00D1F4
        MOVE.W  #$9780,(A5)                     ; $00D1FA
        MOVE.L  #$60000082,(A5)                 ; $00D1FE
        MOVE.W  #$0000,(A6)                     ; $00D204
loc_00D208:
        MOVE.W  (A5),D7                         ; $00D208
        ANDI.W  #$0002,D7                       ; $00D20A
        BNE.S  loc_00D208                       ; $00D20E
        MOVE.W  #$8F02,(A5)                     ; $00D210
        MOVE.W  $C874.W,(A5)                    ; $00D214
        MOVE.W  #$0000,$00A11100                ; $00D218
        MOVEQ   #$07,D0                         ; $00D220
        JSR     $008814BE                       ; $00D222
        MOVE.W  #$0100,$00A11100                ; $00D228
loc_00D230:
        BTST    #0,$00A11100                    ; $00D230
        BNE.S  loc_00D230                       ; $00D238
        MOVE.W  $C874.W,D4                      ; $00D23A
        BSET    #4,D4                           ; $00D23E
        MOVE.W  D4,(A5)                         ; $00D242
        MOVE.L  #$93409400,(A5)                 ; $00D244
        MOVE.L  #$954096C2,(A5)                 ; $00D24A
        MOVE.W  #$977F,(A5)                     ; $00D250
        MOVE.W  #$C000,(A5)                     ; $00D254
        MOVE.W  #$0080,$C876.W                  ; $00D258
        MOVE.W  $C876.W,(A5)                    ; $00D25E
        MOVE.W  $C874.W,(A5)                    ; $00D262
        MOVE.W  #$0000,$00A11100                ; $00D266
        MOVE.W  $C8A0.W,D0                      ; $00D26E
        LEA     $0188(PC),A0                    ; $00D272
        MOVE.L  $00(A0,D0.W),D0                 ; $00D276
        JSR     $008815EA                       ; $00D27A
        MOVE.W  #$0100,$00A11100                ; $00D280
loc_00D288:
        BTST    #0,$00A11100                    ; $00D288
        BNE.S  loc_00D288                       ; $00D290
        MOVE.W  $C874.W,D4                      ; $00D292
        BSET    #4,D4                           ; $00D296
        MOVE.W  D4,(A5)                         ; $00D29A
        MOVE.L  #$93009420,(A5)                 ; $00D29C
        MOVE.L  #$95009688,(A5)                 ; $00D2A2
        MOVE.W  #$977F,(A5)                     ; $00D2A8
        MOVE.W  #$4220,(A5)                     ; $00D2AC
        MOVE.W  #$0080,$C876.W                  ; $00D2B0
        MOVE.W  $C876.W,(A5)                    ; $00D2B6
        MOVE.W  $C874.W,(A5)                    ; $00D2BA
        MOVE.W  #$0000,$00A11100                ; $00D2BE
        MOVE.W  $C89C.W,D1                      ; $00D2C6
        LSL.W  #2,D1                            ; $00D2CA
        LEA     $0146(PC),A0                    ; $00D2CC
        MOVE.L  $00(A0,D1.W),D1                 ; $00D2D0
        JSR     $0088155E                       ; $00D2D4
        MOVE.W  #$8B00,(A5)                     ; $00D2DA
        MOVEQ   #$00,D0                         ; $00D2DE
        MOVEQ   #-$08,D1                        ; $00D2E0
        TST.B  $C80F.W                          ; $00D2E2
        BEQ.S  loc_00D32A                       ; $00D2E6
        MOVEQ   #$00,D0                         ; $00D2E8
        MOVEQ   #$00,D1                         ; $00D2EA
        LEA     $00FF1400,A1                    ; $00D2EC
        LEA     $00FF1000,A2                    ; $00D2F2
        JSR     $008848CA                       ; $00D2F8
        JSR     $008848CE                       ; $00D2FE
        JSR     $008848D2                       ; $00D304
        LEA     $00FF1200,A1                    ; $00D30A
        JSR     $008848CA                       ; $00D310
        JSR     $008848CE                       ; $00D316
        JSR     $008848D2                       ; $00D31C
        MOVE.W  #$8B03,(A5)                     ; $00D322
        BSR.W  loc_00D43A                       ; $00D326
loc_00D32A:
        MOVE.W  #$0100,$00A11100                ; $00D32A
loc_00D332:
        BTST    #0,$00A11100                    ; $00D332
        BNE.S  loc_00D332                       ; $00D33A
        MOVE.W  $C874.W,D4                      ; $00D33C
        BSET    #4,D4                           ; $00D340
        MOVE.W  D4,(A5)                         ; $00D344
        MOVE.L  #$9300940E,(A5)                 ; $00D346
        MOVE.L  #$95009688,(A5)                 ; $00D34C
        MOVE.W  #$977F,(A5)                     ; $00D352
        MOVE.W  #$4000,(A5)                     ; $00D356
        MOVE.W  #$0083,$C876.W                  ; $00D35A
        MOVE.W  $C876.W,(A5)                    ; $00D360
        MOVE.W  $C874.W,(A5)                    ; $00D364
        MOVE.W  #$0000,$00A11100                ; $00D368
        BTST    #3,$C80E.W                      ; $00D370
        BEQ.S  loc_00D3DA                       ; $00D376
        MOVEQ   #$00,D1                         ; $00D378
        MOVE.L  #$000000B0,D2                   ; $00D37A
        MOVEQ   #$1B,D7                         ; $00D380
        LEA     $00FF1A50,A1                    ; $00D382
loc_00D388:
        JSR     $0088485E                       ; $00D388
        ADDA.L  D2,A1                           ; $00D38E
        DBRA    D7,loc_00D388                   ; $00D390
        MOVE.W  #$0100,$00A11100                ; $00D394
loc_00D39C:
        BTST    #0,$00A11100                    ; $00D39C
        BNE.S  loc_00D39C                       ; $00D3A4
        MOVE.W  $C874.W,D4                      ; $00D3A6
        BSET    #4,D4                           ; $00D3AA
        MOVE.W  D4,(A5)                         ; $00D3AE
        MOVE.L  #$9300940E,(A5)                 ; $00D3B0
        MOVE.L  #$9500968D,(A5)                 ; $00D3B6
        MOVE.W  #$977F,(A5)                     ; $00D3BC
        MOVE.W  #$6000,(A5)                     ; $00D3C0
        MOVE.W  #$0082,$C876.W                  ; $00D3C4
        MOVE.W  $C876.W,(A5)                    ; $00D3CA
        MOVE.W  $C874.W,(A5)                    ; $00D3CE
        MOVE.W  #$0000,$00A11100                ; $00D3D2
loc_00D3DA:
        MOVE.W  #$FFFC,$C880.W                  ; $00D3DA
        MOVE.W  D1,$C882.W                      ; $00D3E0
        MOVE.W  D0,$8000.W                      ; $00D3E4
        MOVE.W  D0,$8002.W                      ; $00D3E8
        MOVE.L  #$40000010,(A5)                 ; $00D3EC
        MOVE.W  $C880.W,(A6)                    ; $00D3F2
        MOVE.W  $C882.W,(A6)                    ; $00D3F6
        RTS                                     ; $00D3FA
        ORI.B  #$0001,D0                        ; $00D3FC
        ORI.B  #$0002,D0                        ; $00D400
        ORI.B  #$0003,D0                        ; $00D404
        ORI.B  #$0005,D0                        ; $00D408
        ORI.B  #$0004,D0                        ; $00D40C
        ORI.B  #$0004,D0                        ; $00D410
        ORI.B  #$0001,D0                        ; $00D414
        ORI.B  #$0005,D0                        ; $00D418
        ORI.B  #$0006,D0                        ; $00D41C
        ORI.B  #$0004,D0                        ; $00D420
        ORI.B  #$0007,D0                        ; $00D424
        ORI.B  #$0007,D0                        ; $00D428
        MOVE.L  #$40000000,(A5)                 ; $00D42C
        MOVEQ   #$00,D1                         ; $00D432
        JMP     $008848B8                       ; $00D434
loc_00D43A:
        LEA     $8000.W,A1                      ; $00D43A
        MOVEQ   #$00,D1                         ; $00D43E
        JSR     $0088483E                       ; $00D440
        JMP     $00884842                       ; $00D446
        BTST    D2,A2                           ; $00D44C
        BTST    D7,(A4)                         ; $00D44E
        MOVEQ   #$00,D0                         ; $00D450
        MOVE.B  $FEA8.W,D0                      ; $00D452
        MOVE.B  $C80F.W,D1                      ; $00D456
        BEQ.S  loc_00D460                       ; $00D45A
        MOVE.B  $FEAC.W,D0                      ; $00D45C
loc_00D460:
        MOVE.B  -$16(PC,D0.W),$C81A.W           ; $00D460
        LEA     $00898BFC,A0                    ; $00D466
        LSL.W  #2,D0                            ; $00D46C
        ADDA.L  D0,A0                           ; $00D46E
        MOVE.L  (A0),$00FF6828                  ; $00D470
        TST.B  D1                               ; $00D476
        BEQ.S  loc_00D480                       ; $00D478
        MOVE.L  (A0),$00FF68B8                  ; $00D47A
loc_00D480:
        RTS                                     ; $00D480
        DC.W    $0088                           ; $00D482
        DC.W    $0088                           ; $00D484
        DC.W    $00DC                           ; $00D486
        BTST    D0,$38(A0,D4.W)                 ; $00D488
        MOVE.L  -(A4),D0                        ; $00D48C
        MOVE.B  $FEA5.W,$A019.W                 ; $00D48E
        BTST    #7,$FDA8.W                      ; $00D494
        BEQ.S  loc_00D4CA                       ; $00D49A
        MOVE.B  $FEA6.W,$A019.W                 ; $00D49C
        BRA.S  loc_00D4CA                       ; $00D4A2
        MOVE.B  #$0001,$A024.W                  ; $00D4A4
        MOVE.B  $FEA7.W,$A019.W                 ; $00D4AA
        MOVE.B  $FEA8.W,$A026.W                 ; $00D4B0
        BRA.S  loc_00D4CA                       ; $00D4B6
        MOVE.B  $FEAB.W,$A019.W                 ; $00D4B8
        MOVE.B  $FEAC.W,$A026.W                 ; $00D4BE
        MOVE.B  #$0002,$A024.W                  ; $00D4C4
loc_00D4CA:
        MOVE.W  #$002C,$00FF0008                ; $00D4CA
        MOVE.W  #$002C,$C87A.W                  ; $00D4D2
        BCLR    #6,$C875.W                      ; $00D4D8
        MOVE.W  $C874.W,(A5)                    ; $00D4DE
        MOVE.W  #$0083,$00A15100                ; $00D4E2
        ANDI.B  #$00FC,$00A15181                ; $00D4EA
        JSR     $008826C8                       ; $00D4F2
        MOVE.L  #$000A0907,D0                   ; $00D4F8
        JSR     $008814BE                       ; $00D4FE
        MOVE.B  #$0001,$C80D.W                  ; $00D504
        LEA     $0088D832,A0                    ; $00D50A
        LEA     $00FF2000,A1                    ; $00D510
        MOVE.W  #$0004,D0                       ; $00D516
loc_00D51A:
        MOVE.W  (A0)+,(A1)+                     ; $00D51A
        MOVE.W  (A0)+,(A1)+                     ; $00D51C
        MOVE.W  (A0)+,(A1)+                     ; $00D51E
        MOVE.W  (A0)+,(A1)+                     ; $00D520
        MOVE.W  (A0)+,(A1)+                     ; $00D522
        DBRA    D0,loc_00D51A                   ; $00D524
        MOVEQ   #$00,D0                         ; $00D528
        LEA     $8480.W,A0                      ; $00D52A
        MOVEQ   #$1F,D1                         ; $00D52E
loc_00D530:
        MOVE.L  D0,(A0)+                        ; $00D530
        DBRA    D1,loc_00D530                   ; $00D532
        LEA     $00FF7B80,A0                    ; $00D536
        MOVEQ   #$7F,D1                         ; $00D53C
loc_00D53E:
        MOVE.L  D0,(A0)+                        ; $00D53E
        DBRA    D1,loc_00D53E                   ; $00D540
        MOVE.L  #$60000002,(A5)                 ; $00D544
        MOVE.W  #$17FF,D1                       ; $00D54A
loc_00D54E:
        MOVE.L  D0,(A6)                         ; $00D54E
        DBRA    D1,loc_00D54E                   ; $00D550
        JSR     $008849AA                       ; $00D554
        CLR.W  $C880.W                          ; $00D55A
        CLR.W  $C882.W                          ; $00D55E
        CLR.W  $8000.W                          ; $00D562
        CLR.W  $8002.W                          ; $00D566
        CLR.W  $A012.W                          ; $00D56A
        CLR.B  $A018.W                          ; $00D56E
        JSR     $008849AA                       ; $00D572
        MOVE.L  #$008BB4FC,$C96C.W              ; $00D578
        MOVE.B  #$0001,$C809.W                  ; $00D580
        MOVE.B  #$0001,$C80A.W                  ; $00D586
        BSET    #6,$C80E.W                      ; $00D58C
        MOVE.B  #$0001,$C802.W                  ; $00D592
        MOVE.W  #$0001,$A02C.W                  ; $00D598
        LEA     $00FF1000,A0                    ; $00D59E
        MOVE.W  #$037F,D0                       ; $00D5A4
loc_00D5A8:
        CLR.L  (A0)+                            ; $00D5A8
        DBRA    D0,loc_00D5A8                   ; $00D5AA
        JSR     loc_00E1BC(PC)                  ; $00D5AE
        BCLR    #7,$00A15181                    ; $00D5B2
        LEA     $00FF6E00,A0                    ; $00D5BA
        ADDA.L  #$00000160,A0                   ; $00D5C0
        LEA     $0088D7B2,A1                    ; $00D5C6
        MOVE.W  #$003F,D0                       ; $00D5CC
loc_00D5D0:
        MOVE.W  (A1)+,D1                        ; $00D5D0
        BSET    #15,D1                          ; $00D5D2
        MOVE.W  D1,(A0)+                        ; $00D5D6
        DBRA    D0,loc_00D5D0                   ; $00D5D8
        LEA     $000E8000,A0                    ; $00D5DC
        MOVEA.L #$06037000,A1                   ; $00D5E2
        BSR.W  $00E316                          ; $00D5E8
        BTST    #7,$FDA8.W                      ; $00D5EC
        BEQ.S  loc_00D60C                       ; $00D5F2
loc_00D5F4:
        TST.B  $00A15120                        ; $00D5F4
        BNE.S  loc_00D5F4                       ; $00D5FA
        MOVE.B  #$002E,$00A15121                ; $00D5FC
        MOVE.B  #$0001,$00A15120                ; $00D604
loc_00D60C:
        LEA     $000E8C00,A0                    ; $00D60C
        MOVEA.L #$0603D100,A1                   ; $00D612
        BSR.W  $00E316                          ; $00D618
        TST.B  $A024.W                          ; $00D61C
        BNE.W  loc_00D670                       ; $00D620
        LEA     $000E8A00,A0                    ; $00D624
        MOVEA.L #$0603B600,A1                   ; $00D62A
        BSR.W  $00E316                          ; $00D630
        LEA     $000EB980,A0                    ; $00D634
        MOVEA.L #$0603DA00,A1                   ; $00D63A
        BSR.W  $00E316                          ; $00D640
        MOVE.W  #$0001,D0                       ; $00D644
        MOVE.W  #$0001,D1                       ; $00D648
        MOVE.W  #$0001,D2                       ; $00D64C
        MOVE.W  #$0026,D3                       ; $00D650
        MOVE.W  #$001A,D4                       ; $00D654
        LEA     $00FF1000,A0                    ; $00D658
        JSR     $00E22C(PC)                     ; $00D65E
        LEA     $00FF1000,A0                    ; $00D662
        JSR     $00E2F0(PC)                     ; $00D668
        BRA.W  loc_00D6D6                       ; $00D66C
loc_00D670:
        LEA     $000E8E10,A0                    ; $00D670
        MOVEA.L #$0603B600,A1                   ; $00D676
        BSR.W  $00E316                          ; $00D67C
        LEA     $000E8FB0,A0                    ; $00D680
        MOVEA.L #$0603DA00,A1                   ; $00D686
        BSR.W  $00E316                          ; $00D68C
        MOVE.W  #$0001,D0                       ; $00D690
        MOVE.W  #$0001,D1                       ; $00D694
        MOVE.W  #$0001,D2                       ; $00D698
        MOVE.W  #$0026,D3                       ; $00D69C
        MOVE.W  #$0016,D4                       ; $00D6A0
        LEA     $00FF1000,A0                    ; $00D6A4
        JSR     $00E22C(PC)                     ; $00D6AA
        MOVE.W  #$0002,D0                       ; $00D6AE
        MOVE.W  #$0001,D1                       ; $00D6B2
        MOVE.W  #$0017,D2                       ; $00D6B6
        MOVE.W  #$0026,D3                       ; $00D6BA
        MOVE.W  #$0004,D4                       ; $00D6BE
        LEA     $00FF1000,A0                    ; $00D6C2
        JSR     $00E22C(PC)                     ; $00D6C8
        LEA     $00FF1000,A0                    ; $00D6CC
        JSR     $00E2F0(PC)                     ; $00D6D2
loc_00D6D6:
        CLR.B  $A027.W                          ; $00D6D6
        MOVEQ   #$00,D0                         ; $00D6DA
        MOVEQ   #$00,D1                         ; $00D6DC
        MOVE.B  $FEB1.W,D0                      ; $00D6DE
        BEQ.S  loc_00D6F0                       ; $00D6E2
        SUBQ.W  #1,D0                           ; $00D6E4
loc_00D6E6:
        ADDI.L  #$000003C0,D1                   ; $00D6E6
        DBRA    D0,loc_00D6E6                   ; $00D6EC
loc_00D6F0:
        ADDQ.L  #4,D1                           ; $00D6F0
        MOVE.L  D1,$A028.W                      ; $00D6F2
        JSR     $0088204A                       ; $00D6F6
        ANDI.B  #$00FC,$00A15181                ; $00D6FC
        ORI.B  #$0001,$00A15181                 ; $00D704
        MOVE.W  #$8083,$00A15100                ; $00D70C
        BSET    #6,$C875.W                      ; $00D714
        MOVE.W  $C874.W,(A5)                    ; $00D71A
        MOVE.W  #$0020,$00FF0008                ; $00D71E
        JSR     $00884998                       ; $00D726
        MOVE.W  #$0000,$C87E.W                  ; $00D72C
        MOVE.L  #$0088D864,$00FF0002            ; $00D732
        TST.B  $A024.W                          ; $00D73C
        BEQ.S  loc_00D74C                       ; $00D740
        MOVE.L  #$0088D888,$00FF0002            ; $00D742
loc_00D74C:
        MOVE.B  #$0000,$00FF60D4                ; $00D74C
        BTST    #7,$FDA8.W                      ; $00D754
        BEQ.W  loc_00D766                       ; $00D75A
        MOVE.B  #$0001,$00FF60D4                ; $00D75E
loc_00D766:
        LEA     $00FF6100,A0                    ; $00D766
        MOVE.W  #$007F,D0                       ; $00D76C
loc_00D770:
        CLR.L  (A0)+                            ; $00D770
        CLR.L  (A0)+                            ; $00D772
        CLR.L  (A0)+                            ; $00D774
        CLR.L  (A0)+                            ; $00D776
        CLR.L  (A0)+                            ; $00D778
        DBRA    D0,loc_00D770                   ; $00D77A
loc_00D77E:
        TST.B  $00A15120                        ; $00D77E
        BNE.S  loc_00D77E                       ; $00D784
        CLR.B  $00A15122                        ; $00D786
        CLR.B  $00A15123                        ; $00D78C
        MOVE.B  #$0003,$00A15121                ; $00D792
        MOVE.B  #$0001,$00A15120                ; $00D79A
loc_00D7A2:
        TST.B  $00A15120                        ; $00D7A2
        BNE.S  loc_00D7A2                       ; $00D7A8
        MOVE.B  #$0081,$C8A5.W                  ; $00D7AA
        RTS                                     ; $00D7B0
        NEG.B  D0                               ; $00D7B2
        NEG.L  -(A3)                            ; $00D7B4
        DC.W    $4946                           ; $00D7B6
        LEA     $1C00(A1),A6                    ; $00D7B8
        MOVE.L  -(A3),(A4)                      ; $00D7BC
        MOVE.W  D6,$41E9(A2)                    ; $00D7BE
        DC.W    $7FFF                           ; $00D7C2
        DC.W    $7FFF                           ; $00D7C4
        DC.W    $7FFF                           ; $00D7C6
        DC.W    $7FFF                           ; $00D7C8
        MOVE.B  D0,D6                           ; $00D7CA
        MOVE.L  -(A3),(A4)                      ; $00D7CC
        MOVE.W  D6,$41E9(A2)                    ; $00D7CE
        NEG.B  D0                               ; $00D7D2
        NEG.L  -(A3)                            ; $00D7D4
        DC.W    $4946                           ; $00D7D6
        LEA     $7FFF(A1),A6                    ; $00D7D8
        BLS.S  loc_00D7D3                       ; $00D7DC
        DC.W    $7FFF                           ; $00D7DE
        DC.W    $7FFF                           ; $00D7E0
        ORI.B  #$14AF,(A0)                      ; $00D7E2
        MOVE.L  A6,$3DED(A4)                    ; $00D7E6
        DC.W    $7FFF                           ; $00D7EA
        DC.W    $7FFF                           ; $00D7EC
        DC.W    $7FFF                           ; $00D7EE
        DC.W    $7FFF                           ; $00D7F0
        BLS.S  loc_00D82B                       ; $00D7F2
        BEQ.S  loc_00D82D                       ; $00D7F4
        BMI.S  loc_00D850                       ; $00D7F6
        BLE.S  loc_00D873                       ; $00D7F8
        BMI.S  loc_00D832                       ; $00D7FA
        BMI.S  loc_00D835                       ; $00D7FC
        BLE.S  loc_00D858                       ; $00D7FE
        BLE.S  loc_00D87B                       ; $00D800
        MOVE.W  (A2)+,-$18(A1,D6.W)             ; $00D802
        DC.W    $7FFF                           ; $00D806
        DC.W    $1D4A                           ; $00D808
        DC.W    $4B3A                           ; $00D80A
        BEQ.L  $3AB6FDDC                        ; $00D80C
        MOVE.B  -(A1),(A0)+                     ; $00D812
        MOVE.L  $4670(A0),$37(A4,D6.W)          ; $00D814
loc_00D81A:
        NEG.W  D5                               ; $00D81A
        SUBQ.B  #8,$6212(A3)                    ; $00D81C
        BGT.S  loc_00D81A                       ; $00D820
        DC.W    $7FFF                           ; $00D822
        BTST    D1,(A7)+                        ; $00D824
        DC.W    $7FFF                           ; $00D826
        ORI.B  #$033E,D0                        ; $00D828
        BLS.L  $1AFD8B4                         ; $00D82C
loc_00D832:
        ORI.B  #$0070,D0                        ; $00D832
        BTST    D0,(A0)                         ; $00D836
        BTST    D1,D0                           ; $00D838
        ORI.B  #$0000,D0                        ; $00D83A
        BTST    D0,(A0)                         ; $00D83E
        BTST    D0,-$40(A0,D0.W)                ; $00D840
        ORI.B  #$0000,D0                        ; $00D844
        BTST    D0,-(A0)                        ; $00D848
        BCHG    D0,-$40(A0,D0.W)                ; $00D84A
        ORI.B  #$0000,D0                        ; $00D84E
        ORI.B  #$0150,D0                        ; $00D852
        DC.W    $02C0                           ; $00D856
loc_00D858:
        ORI.B  #$0000,D0                        ; $00D858
        ORI.B  #$0180,D0                        ; $00D85C
        DC.W    $02C0                           ; $00D860
        ORI.B  #$4EB9,D0                        ; $00D862
        DC.W    $0088                           ; $00D866
        MOVE.L  D0,(A0)                         ; $00D868
        MOVE.W  $C87E.W,D0                      ; $00D86A
        MOVEA.L $04(PC,D0.W),A1                 ; $00D86E
        JMP     (A1)                            ; $00D872
        DC.W    $0088                           ; $00D874
        ADDA.W  A4,A4                           ; $00D876
        DC.W    $0088                           ; $00D878
        ADDA.W  D0,A5                           ; $00D87A
        DC.W    $0088                           ; $00D87C
        ADDA.W  (A0),A6                         ; $00D87E
        DC.W    $0088                           ; $00D880
        ADDA.L  $0088(A4),A7                    ; $00D882
        LSR.B  #8,D4                            ; $00D886
        JSR     $00882080                       ; $00D888
        MOVE.W  $C87E.W,D0                      ; $00D88E
        MOVEA.L $04(PC,D0.W),A1                 ; $00D892
        JMP     (A1)                            ; $00D896
        DC.W    $0088                           ; $00D898
        ADDA.W  A4,A4                           ; $00D89A
        DC.W    $0088                           ; $00D89C
        ADDA.W  D0,A5                           ; $00D89E
        DC.W    $0088                           ; $00D8A0
        ADDA.W  A6,A7                           ; $00D8A2
        DC.W    $0088                           ; $00D8A4
        ADDA.L  $0088(A4),A7                    ; $00D8A6
        LSR.B  #8,D4                            ; $00D8AA
        MOVE.B  #$0081,$C8A5.W                  ; $00D8AC
        ADDQ.W  #4,$C87E.W                      ; $00D8B2
        RTS                                     ; $00D8B6
        JSR     $00B684(PC)                     ; $00D8B8
        BTST    #6,$C80E.W                      ; $00D8BC
        BNE.S  loc_00D8CA                       ; $00D8C2
        ADDQ.W  #4,$C87E.W                      ; $00D8C4
        NOP                                     ; $00D8C8
loc_00D8CA:
        RTS                                     ; $00D8CA
        LEA     $00FF6E00,A0                    ; $00D8CC
        LEA     $0088DAA8,A1                    ; $00D8D2
        CLR.W  D0                               ; $00D8D8
        MOVE.B  $A019.W,D0                      ; $00D8DA
        TST.B  $A027.W                          ; $00D8DE
        BEQ.W  loc_00D8EA                       ; $00D8E2
        MOVE.B  $A025.W,D0                      ; $00D8E6
loc_00D8EA:
        ADD.W  D0,D0                            ; $00D8EA
        ADD.W  D0,D0                            ; $00D8EC
        MOVEA.L $00(A1,D0.W),A1                 ; $00D8EE
        MOVE.W  #$007F,D0                       ; $00D8F2
loc_00D8F6:
        MOVE.W  (A1)+,(A0)+                     ; $00D8F6
        DBRA    D0,loc_00D8F6                   ; $00D8F8
        LEA     $00FF6100,A1                    ; $00D8FC
        MOVE.W  #$0001,$0000(A1)                ; $00D902
        MOVE.W  $A01A.W,$0002(A1)               ; $00D908
        MOVE.W  $A01C.W,$0004(A1)               ; $00D90E
        MOVE.W  $A01E.W,$0006(A1)               ; $00D914
        MOVE.L  $A014.W,D0                      ; $00D91A
        MOVE.W  D0,$000A(A1)                    ; $00D91E
        MOVE.W  $A020.W,$0008(A1)               ; $00D922
        MOVE.W  $A022.W,$000C(A1)               ; $00D928
        MOVE.W  #$0000,$000E(A1)                ; $00D92E
        LEA     $0088DA90,A0                    ; $00D934
        CLR.W  D1                               ; $00D93A
        MOVE.B  $A019.W,D1                      ; $00D93C
        TST.B  $A027.W                          ; $00D940
        BEQ.S  loc_00D94A                       ; $00D944
        MOVE.B  $A025.W,D1                      ; $00D946
loc_00D94A:
        ADD.W  D1,D1                            ; $00D94A
        ADD.W  D1,D1                            ; $00D94C
        MOVE.L  $00(A0,D1.W),$0010(A1)          ; $00D94E
        MOVE.W  #$0044,$00A15110                ; $00D954
        MOVE.B  #$0004,$00A15107                ; $00D95C
        CLR.B  $00A15123                        ; $00D964
        MOVE.B  #$002B,$00A15121                ; $00D96A
        MOVE.B  #$0001,$00A15120                ; $00D972
loc_00D97A:
        BTST    #1,$00A15123                    ; $00D97A
        BEQ.S  loc_00D97A                       ; $00D982
        BCLR    #1,$00A15123                    ; $00D984
        LEA     $00FF60C8,A1                    ; $00D98C
        LEA     $00A15112,A2                    ; $00D992
        MOVE.W  #$0043,D7                       ; $00D998
loc_00D99C:
        BTST    #7,$00A15107                    ; $00D99C
        BNE.S  loc_00D99C                       ; $00D9A4
        MOVE.W  (A1)+,(A2)                      ; $00D9A6
        DBRA    D7,loc_00D99C                   ; $00D9A8
        MOVE.L  $A014.W,D0                      ; $00D9AC
        ADDI.L  #$00000080,D0                   ; $00D9B0
        ANDI.L  #$0000FFFF,D0                   ; $00D9B6
        MOVE.L  D0,$A014.W                      ; $00D9BC
        JSR     $0088179E                       ; $00D9C0
        TST.W  $A02C.W                          ; $00D9C6
        BNE.W  loc_00DA82                       ; $00D9CA
        CLR.W  D0                               ; $00D9CE
        MOVE.B  $A027.W,D0                      ; $00D9D0
        BSR.W  $00E52C                          ; $00D9D4
        MOVE.B  $A019.W,D0                      ; $00D9D8
        MOVE.W  $C86C.W,D1                      ; $00D9DC
        BTST    #3,D1                           ; $00D9E0
        BEQ.S  loc_00DA0A                       ; $00D9E4
        MOVE.B  #$00A9,$C8A4.W                  ; $00D9E6
        TST.B  $A027.W                          ; $00D9EC
        BNE.W  loc_00D9FC                       ; $00D9F0
        CMPI.B  #$0004,D0                       ; $00D9F4
        BGE.S  loc_00DA06                       ; $00D9F8
        BRA.S  loc_00DA02                       ; $00D9FA
loc_00D9FC:
        CMPI.B  #$0003,D0                       ; $00D9FC
        BGE.S  loc_00DA06                       ; $00DA00
loc_00DA02:
        ADDQ.B  #1,D0                           ; $00DA02
        BRA.S  loc_00DA7E                       ; $00DA04
loc_00DA06:
        CLR.B  D0                               ; $00DA06
        BRA.S  loc_00DA7E                       ; $00DA08
loc_00DA0A:
        BTST    #2,D1                           ; $00DA0A
        BEQ.S  loc_00DA32                       ; $00DA0E
        MOVE.B  #$00A9,$C8A4.W                  ; $00DA10
        TST.B  D0                               ; $00DA16
        BLE.S  loc_00DA1E                       ; $00DA18
        SUBQ.B  #1,D0                           ; $00DA1A
        BRA.S  loc_00DA7E                       ; $00DA1C
loc_00DA1E:
        TST.B  $A027.W                          ; $00DA1E
        BNE.W  loc_00DA2C                       ; $00DA22
        MOVE.B  #$0004,D0                       ; $00DA26
        BRA.S  loc_00DA7E                       ; $00DA2A
loc_00DA2C:
        MOVE.B  #$0003,D0                       ; $00DA2C
        BRA.S  loc_00DA7E                       ; $00DA30
loc_00DA32:
        TST.B  $A024.W                          ; $00DA32
        BEQ.S  loc_00DA7E                       ; $00DA36
        BTST    #0,D1                           ; $00DA38
        BEQ.W  loc_00DA5A                       ; $00DA3C
        TST.B  $A027.W                          ; $00DA40
        BEQ.S  loc_00DA7E                       ; $00DA44
        MOVE.B  #$00A9,$C8A4.W                  ; $00DA46
        CLR.B  $A027.W                          ; $00DA4C
        MOVE.B  D0,$A026.W                      ; $00DA50
        MOVE.B  $A025.W,D0                      ; $00DA54
        BRA.S  loc_00DA7E                       ; $00DA58
loc_00DA5A:
        BTST    #1,D1                           ; $00DA5A
        BEQ.W  loc_00DA7E                       ; $00DA5E
        CMPI.B  #$0001,$A027.W                  ; $00DA62
        BGE.S  loc_00DA7E                       ; $00DA68
        MOVE.B  #$00A9,$C8A4.W                  ; $00DA6A
        MOVE.B  #$0001,$A027.W                  ; $00DA70
        MOVE.B  D0,$A025.W                      ; $00DA76
        MOVE.B  $A026.W,D0                      ; $00DA7A
loc_00DA7E:
        MOVE.B  D0,$A019.W                      ; $00DA7E
loc_00DA82:
        ADDQ.W  #4,$C87E.W                      ; $00DA82
        MOVE.W  #$0020,$00FF0008                ; $00DA86
        RTS                                     ; $00DA8E
        MOVE.L  $6AE2(A1),D1                    ; $00DA90
        MOVE.L  -$7BF4(A1),D1                   ; $00DA94
        MOVE.L  -$5D12(A1),D1                   ; $00DA98
        MOVE.L  -$4608(A1),D1                   ; $00DA9C
        MOVE.L  -$2CD4(A1),D1                   ; $00DAA0
        MOVE.L  $6AE2(A1),D1                    ; $00DAA4
        DC.W    $008B                           ; $00DAA8
        CMP.W  (A4)+,D3                         ; $00DAAA
        DC.W    $008B                           ; $00DAAC
        EOR.W  D3,(A4)+                         ; $00DAAE
        DC.W    $008B                           ; $00DAB0
        CMP.W  (A4)+,D4                         ; $00DAB2
        DC.W    $008B                           ; $00DAB4
        EOR.W  D4,(A4)+                         ; $00DAB6
        DC.W    $008B                           ; $00DAB8
        CMP.W  (A4)+,D5                         ; $00DABA
        DC.W    $008B                           ; $00DABC
        CMP.W  (A4)+,D3                         ; $00DABE
        CLR.W  D0                               ; $00DAC0
        MOVE.B  $A027.W,D0                      ; $00DAC2
        JSR     $00E52C(PC)                     ; $00DAC6
        MOVEA.L #$0603D100,A0                   ; $00DACA
        MOVEA.L #$24004C58,A1                   ; $00DAD0
        MOVE.W  #$0090,D0                       ; $00DAD6
        MOVE.W  #$0010,D1                       ; $00DADA
        BSR.W  $00E35A                          ; $00DADE
        CLR.W  D0                               ; $00DAE2
        MOVE.B  $A019.W,D0                      ; $00DAE4
        TST.B  $A027.W                          ; $00DAE8
        BEQ.W  loc_00DAF4                       ; $00DAEC
        MOVE.B  $A025.W,D0                      ; $00DAF0
loc_00DAF4:
        ADD.W  D0,D0                            ; $00DAF4
        MOVE.W  D0,D1                           ; $00DAF6
        ADD.W  D0,D0                            ; $00DAF8
        ADD.W  D0,D0                            ; $00DAFA
        ADD.W  D1,D0                            ; $00DAFC
        LEA     $00FF2000,A0                    ; $00DAFE
        MOVE.W  $00(A0,D0.W),$A01A.W            ; $00DB04
        MOVE.W  $02(A0,D0.W),$A01C.W            ; $00DB0A
        MOVE.W  $04(A0,D0.W),$A01E.W            ; $00DB10
        MOVE.W  $06(A0,D0.W),$A020.W            ; $00DB16
        MOVE.W  $08(A0,D0.W),$A022.W            ; $00DB1C
        MOVE.W  $C86E.W,D1                      ; $00DB22
        LSR.L  #8,D1                            ; $00DB26
        BTST    #7,D1                           ; $00DB28
        BEQ.W  loc_00DC5E                       ; $00DB2C
        BTST    #5,D1                           ; $00DB30
        BNE.W  loc_00DC04                       ; $00DB34
        BTST    #0,D1                           ; $00DB38
        BEQ.S  loc_00DB5A                       ; $00DB3C
        MOVE.W  $A01C.W,D0                      ; $00DB3E
        BSR.W  loc_00DCAC                       ; $00DB42
        CMPI.W  #$02F0,D0                       ; $00DB46
        BLT.W  loc_00DB52                       ; $00DB4A
        MOVE.W  #$02F0,D0                       ; $00DB4E
loc_00DB52:
        MOVE.W  D0,$A01C.W                      ; $00DB52
        BRA.W  loc_00DC5E                       ; $00DB56
loc_00DB5A:
        BTST    #1,D1                           ; $00DB5A
        BEQ.S  loc_00DB7C                       ; $00DB5E
        MOVE.W  $A01C.W,D0                      ; $00DB60
        BSR.W  loc_00DCBE                       ; $00DB64
        CMPI.W  #$FBFE,D0                       ; $00DB68
        BGT.W  loc_00DB74                       ; $00DB6C
        MOVE.W  #$FBFE,D0                       ; $00DB70
loc_00DB74:
        MOVE.W  D0,$A01C.W                      ; $00DB74
        BRA.W  loc_00DC5E                       ; $00DB78
loc_00DB7C:
        BTST    #3,D1                           ; $00DB7C
        BEQ.S  loc_00DB9E                       ; $00DB80
        MOVE.W  $A01A.W,D0                      ; $00DB82
        BSR.W  loc_00DCAC                       ; $00DB86
        CMPI.W  #$0120,D0                       ; $00DB8A
        BLT.W  loc_00DB96                       ; $00DB8E
        MOVE.W  #$0120,D0                       ; $00DB92
loc_00DB96:
        MOVE.W  D0,$A01A.W                      ; $00DB96
        BRA.W  loc_00DC5E                       ; $00DB9A
loc_00DB9E:
        BTST    #2,D1                           ; $00DB9E
        BEQ.S  loc_00DBC0                       ; $00DBA2
        MOVE.W  $A01A.W,D0                      ; $00DBA4
        BSR.W  loc_00DCBE                       ; $00DBA8
        CMPI.W  #$FEE0,D0                       ; $00DBAC
        BGT.W  loc_00DBB8                       ; $00DBB0
        MOVE.W  #$FEE0,D0                       ; $00DBB4
loc_00DBB8:
        MOVE.W  D0,$A01A.W                      ; $00DBB8
        BRA.W  loc_00DC5E                       ; $00DBBC
loc_00DBC0:
        BTST    #6,D1                           ; $00DBC0
        BEQ.S  loc_00DBE2                       ; $00DBC4
        MOVE.W  $A01E.W,D0                      ; $00DBC6
        BSR.W  loc_00DCAC                       ; $00DBCA
        CMPI.W  #$0460,D0                       ; $00DBCE
        BLT.W  loc_00DBDA                       ; $00DBD2
        MOVE.W  #$0460,D0                       ; $00DBD6
loc_00DBDA:
        MOVE.W  D0,$A01E.W                      ; $00DBDA
        BRA.W  loc_00DC5E                       ; $00DBDE
loc_00DBE2:
        BTST    #4,D1                           ; $00DBE2
        BEQ.S  loc_00DC5E                       ; $00DBE6
        MOVE.W  $A01E.W,D0                      ; $00DBE8
        BSR.W  loc_00DCBE                       ; $00DBEC
        CMPI.W  #$0050,D0                       ; $00DBF0
        BGT.W  loc_00DBFC                       ; $00DBF4
        MOVE.W  #$0050,D0                       ; $00DBF8
loc_00DBFC:
        MOVE.W  D0,$A01E.W                      ; $00DBFC
        BRA.W  loc_00DC5E                       ; $00DC00
loc_00DC04:
        BTST    #0,D1                           ; $00DC04
        BEQ.S  loc_00DC1A                       ; $00DC08
        MOVE.W  $A020.W,D0                      ; $00DC0A
        BSR.W  loc_00DCB8                       ; $00DC0E
        MOVE.W  D0,$A020.W                      ; $00DC12
        BRA.W  loc_00DC5E                       ; $00DC16
loc_00DC1A:
        BTST    #1,D1                           ; $00DC1A
        BEQ.S  loc_00DC30                       ; $00DC1E
        MOVE.W  $A020.W,D0                      ; $00DC20
        BSR.W  loc_00DCCA                       ; $00DC24
        MOVE.W  D0,$A020.W                      ; $00DC28
        BRA.W  loc_00DC5E                       ; $00DC2C
loc_00DC30:
        BTST    #3,D1                           ; $00DC30
        BEQ.S  loc_00DC46                       ; $00DC34
        MOVE.W  $A022.W,D0                      ; $00DC36
        BSR.W  loc_00DCB8                       ; $00DC3A
        MOVE.W  D0,$A022.W                      ; $00DC3E
        BRA.W  loc_00DC5E                       ; $00DC42
loc_00DC46:
        BTST    #2,D1                           ; $00DC46
        BEQ.S  loc_00DC5E                       ; $00DC4A
        MOVE.W  $A022.W,D0                      ; $00DC4C
        BSR.W  loc_00DCCA                       ; $00DC50
        MOVE.W  D0,$A022.W                      ; $00DC54
        BRA.W  loc_00DC5E                       ; $00DC58
        NOP                                     ; $00DC5C
loc_00DC5E:
        CLR.W  D0                               ; $00DC5E
        MOVE.B  $A019.W,D0                      ; $00DC60
        TST.B  $A027.W                          ; $00DC64
        BEQ.W  loc_00DC70                       ; $00DC68
        MOVE.B  $A025.W,D0                      ; $00DC6C
loc_00DC70:
        ADD.W  D0,D0                            ; $00DC70
        MOVE.W  D0,D1                           ; $00DC72
        ADD.W  D0,D0                            ; $00DC74
        ADD.W  D0,D0                            ; $00DC76
        ADD.W  D1,D0                            ; $00DC78
        LEA     $00FF2000,A0                    ; $00DC7A
        MOVE.W  $A01A.W,$00(A0,D0.W)            ; $00DC80
        MOVE.W  $A01C.W,$02(A0,D0.W)            ; $00DC86
        MOVE.W  $A01E.W,$04(A0,D0.W)            ; $00DC8C
        MOVE.W  $A020.W,$06(A0,D0.W)            ; $00DC92
        MOVE.W  $A022.W,$08(A0,D0.W)            ; $00DC98
        MOVE.W  #$0020,$00FF0008                ; $00DC9E
        ADDQ.W  #4,$C87E.W                      ; $00DCA6
        RTS                                     ; $00DCAA
loc_00DCAC:
        CMPI.W  #$4000,D0                       ; $00DCAC
        BGT.S  loc_00DCBC                       ; $00DCB0
        ADDI.W  #$0010,D0                       ; $00DCB2
        BRA.S  loc_00DCBC                       ; $00DCB6
loc_00DCB8:
        ADDI.W  #$0040,D0                       ; $00DCB8
loc_00DCBC:
        RTS                                     ; $00DCBC
loc_00DCBE:
        CMPI.W  #$C000,D0                       ; $00DCBE
        BLT.S  loc_00DCCE                       ; $00DCC2
        SUBI.W  #$0010,D0                       ; $00DCC4
        BRA.S  loc_00DCCE                       ; $00DCC8
loc_00DCCA:
        SUBI.W  #$0040,D0                       ; $00DCCA
loc_00DCCE:
        RTS                                     ; $00DCCE
        CLR.W  D0                               ; $00DCD0
        JSR     $00E52C(PC)                     ; $00DCD2
        JSR     $00B684(PC)                     ; $00DCD6
        JSR     $00B6DA(PC)                     ; $00DCDA
loc_00DCDE:
        TST.B  $00A15120                        ; $00DCDE
        BNE.S  loc_00DCDE                       ; $00DCE4
        MOVEA.L #$06037000,A0                   ; $00DCE6
        MOVEA.L #$24018010,A1                   ; $00DCEC
        MOVE.W  #$0120,D0                       ; $00DCF2
        MOVE.W  #$0030,D1                       ; $00DCF6
        BSR.W  $00E35A                          ; $00DCFA
        BTST    #7,$FDA8.W                      ; $00DCFE
        BNE.W  loc_00DD3C                       ; $00DD04
        MOVEA.L #$0603A600,A0                   ; $00DD08
        MOVEQ   #$00,D3                         ; $00DD0E
        MOVE.W  #$0004,D4                       ; $00DD10
loc_00DD14:
        BTST    D3,$EF07.W                      ; $00DD14
        BEQ.S  loc_00DD36                       ; $00DD18
        LEA     $0088DEB6,A1                    ; $00DD1A
        MOVE.W  D3,D0                           ; $00DD20
        ADD.W  D0,D0                            ; $00DD22
        ADD.W  D0,D0                            ; $00DD24
        MOVEA.L $00(A1,D0.W),A1                 ; $00DD26
        MOVE.W  #$0010,D0                       ; $00DD2A
        MOVE.W  #$0010,D1                       ; $00DD2E
        BSR.W  $00E35A                          ; $00DD32
loc_00DD36:
        ADDQ.W  #1,D3                           ; $00DD36
        DBRA    D4,loc_00DD14                   ; $00DD38
loc_00DD3C:
        MOVEA.L #$0603B600,A0                   ; $00DD3C
        MOVEA.L #$24014010,A1                   ; $00DD42
        MOVE.W  #$0120,D0                       ; $00DD48
        MOVE.W  #$0018,D1                       ; $00DD4C
        BSR.W  $00E35A                          ; $00DD50
        LEA     $24034850,A1                    ; $00DD54
        LEA     $EF08.W,A2                      ; $00DD5A
        ADDA.L  $A028.W,A2                      ; $00DD5E
        MOVEQ   #$00,D0                         ; $00DD62
        MOVE.B  $A019.W,D0                      ; $00DD64
        ADD.W  D0,D0                            ; $00DD68
        ADD.W  D0,D0                            ; $00DD6A
        ADD.W  D0,D0                            ; $00DD6C
        ADD.W  D0,D0                            ; $00DD6E
        MOVE.W  D0,D1                           ; $00DD70
        ADD.W  D0,D0                            ; $00DD72
        ADD.W  D0,D0                            ; $00DD74
        ADD.W  D1,D0                            ; $00DD76
        ADD.W  D0,D0                            ; $00DD78
        ADDA.L  D0,A2                           ; $00DD7A
        BTST    #7,$FDA8.W                      ; $00DD7C
        BEQ.W  loc_00DD8C                       ; $00DD82
        LEA     $0088DECA,A2                    ; $00DD86
loc_00DD8C:
        JSR     $00E466(PC)                     ; $00DD8C
        LEA     $240348E8,A1                    ; $00DD90
        LEA     $FA48.W,A2                      ; $00DD96
        MOVEQ   #$00,D0                         ; $00DD9A
        MOVE.B  $FEB1.W,D0                      ; $00DD9C
        ADD.W  D0,D0                            ; $00DDA0
        ADD.W  D0,D0                            ; $00DDA2
        ADD.W  D0,D0                            ; $00DDA4
        MOVE.W  D0,D1                           ; $00DDA6
        ADD.W  D0,D0                            ; $00DDA8
        ADD.W  D1,D0                            ; $00DDAA
        ADD.W  D0,D0                            ; $00DDAC
        ADDA.L  D0,A2                           ; $00DDAE
        MOVEQ   #$00,D0                         ; $00DDB0
        MOVE.B  $A019.W,D0                      ; $00DDB2
        ADD.W  D0,D0                            ; $00DDB6
        ADD.W  D0,D0                            ; $00DDB8
        ADD.W  D0,D0                            ; $00DDBA
        ADDQ.W  #4,D0                           ; $00DDBC
        ADDA.L  D0,A2                           ; $00DDBE
        BTST    #7,$FDA8.W                      ; $00DDC0
        BEQ.W  loc_00DDD0                       ; $00DDC6
        LEA     $0088DECA,A2                    ; $00DDCA
loc_00DDD0:
        JSR     $00E466(PC)                     ; $00DDD0
        MOVEQ   #$00,D0                         ; $00DDD4
        MOVE.B  $A019.W,D0                      ; $00DDD6
        LEA     $0088DE98,A1                    ; $00DDDA
        ADD.W  D0,D0                            ; $00DDE0
        MOVE.W  D0,D1                           ; $00DDE2
        ADD.W  D0,D0                            ; $00DDE4
        ADD.W  D1,D0                            ; $00DDE6
        MOVEA.L $00(A1,D0.W),A0                 ; $00DDE8
        MOVE.W  $04(A1,D0.W),D0                 ; $00DDEC
        MOVE.W  #$0030,D1                       ; $00DDF0
        MOVE.W  #$0010,D2                       ; $00DDF4
loc_00DDF8:
        TST.B  $00A15120                        ; $00DDF8
        BNE.S  loc_00DDF8                       ; $00DDFE
        BSR.W  $00E3B4                          ; $00DE00
        MOVE.W  #$0018,$00FF0008                ; $00DE04
        CMPI.W  #$0001,$A02C.W                  ; $00DE0C
        BEQ.W  loc_00DE68                       ; $00DE12
        CMPI.W  #$0002,$A02C.W                  ; $00DE16
        BEQ.W  loc_00DE78                       ; $00DE1C
        MOVE.W  $C86C.W,D1                      ; $00DE20
        ANDI.B  #$00E0,D1                       ; $00DE24
        BNE.S  loc_00DE40                       ; $00DE28
        MOVE.W  $C86C.W,D1                      ; $00DE2A
        ANDI.B  #$0010,D1                       ; $00DE2E
        BNE.S  loc_00DE3C                       ; $00DE32
        SUBQ.W  #8,$C87E.W                      ; $00DE34
        BRA.W  loc_00DE90                       ; $00DE38
loc_00DE3C:
        ST      $A018.W                         ; $00DE3C
loc_00DE40:
        MOVE.B  #$00A8,$C8A4.W                  ; $00DE40
        MOVE.B  #$0001,$C809.W                  ; $00DE46
        MOVE.B  #$0001,$C80A.W                  ; $00DE4C
        BSET    #7,$C80E.W                      ; $00DE52
        MOVE.B  #$0001,$C802.W                  ; $00DE58
        MOVE.W  #$0002,$A02C.W                  ; $00DE5E
        BRA.W  loc_00DE8C                       ; $00DE64
loc_00DE68:
        BTST    #6,$C80E.W                      ; $00DE68
        BNE.S  loc_00DE8C                       ; $00DE6E
        CLR.W  $A02C.W                          ; $00DE70
        BRA.W  loc_00DE8C                       ; $00DE74
loc_00DE78:
        BTST    #7,$C80E.W                      ; $00DE78
        BNE.S  loc_00DE8C                       ; $00DE7E
        CLR.W  $A02C.W                          ; $00DE80
        ADDQ.W  #4,$C87E.W                      ; $00DE84
        BRA.W  loc_00DE90                       ; $00DE88
loc_00DE8C:
        SUBQ.W  #8,$C87E.W                      ; $00DE8C
loc_00DE90:
        MOVE.B  #$0001,$C821.W                  ; $00DE90
        RTS                                     ; $00DE96
        MOVE.L  D1,D2                           ; $00DE98
        OR.B   (A0),D0                          ; $00DE9A
        ORI.B  #$2401,-$7FB7(PC)                ; $00DE9C
        ORI.B  #$2401,-$7D(PC,A0.W)             ; $00DEA2
        ORI.B  #$2401,-$7F44(PC)                ; $00DEA8
        ORI.B  #$2401,-$7F0B(PC)                ; $00DEAE
        ORI.B  #$2403,$12(PC,A0.W)              ; $00DEB4
        MOVE.L  D3,D2                           ; $00DEBA
        OR.W   A4,D2                            ; $00DEBC
        MOVE.L  D3,D2                           ; $00DEBE
        OR.L   D6,D2                            ; $00DEC0
        MOVE.L  D3,D2                           ; $00DEC2
        OR.L   <EA:3E>,D2                       ; $00DEC4
        MOVE.L  D3,D2                           ; $00DEC6
        DIVU    $CCCC.W,D2                      ; $00DEC8
        DC.W    $0CCC                           ; $00DECC
        CLR.W  D0                               ; $00DECE
        MOVE.B  $A027.W,D0                      ; $00DED0
        JSR     $00E52C(PC)                     ; $00DED4
        JSR     $00B684(PC)                     ; $00DED8
        JSR     $00B6DA(PC)                     ; $00DEDC
loc_00DEE0:
        TST.B  $00A15120                        ; $00DEE0
        BNE.S  loc_00DEE0                       ; $00DEE6
        MOVEA.L #$06037000,A0                   ; $00DEE8
        MOVEA.L #$24014010,A1                   ; $00DEEE
        MOVE.W  #$0120,D0                       ; $00DEF4
        MOVE.W  #$0030,D1                       ; $00DEF8
        BSR.W  $00E35A                          ; $00DEFC
        MOVEA.L #$0603B600,A0                   ; $00DF00
        MOVEA.L #$2401C010,A1                   ; $00DF06
        MOVE.W  #$0120,D0                       ; $00DF0C
        MOVE.W  #$0010,D1                       ; $00DF10
        BSR.W  $00E35A                          ; $00DF14
loc_00DF18:
        TST.B  $00A15120                        ; $00DF18
        BNE.S  loc_00DF18                       ; $00DF1E
        BSR.W  loc_00E118                       ; $00DF20
        MOVEA.L #$0603DA00,A0                   ; $00DF24
        MOVEA.L #$2401AC88,A1                   ; $00DF2A
        MOVE.W  #$0038,D0                       ; $00DF30
        MOVE.W  #$0010,D1                       ; $00DF34
        BSR.W  $00E35A                          ; $00DF38
        MOVE.W  #$0018,$00FF0008                ; $00DF3C
        CMPI.W  #$0001,$A02C.W                  ; $00DF44
        BEQ.W  loc_00DFBC                       ; $00DF4A
        CMPI.W  #$0002,$A02C.W                  ; $00DF4E
        BEQ.W  loc_00DFCC                       ; $00DF54
        MOVE.W  $C86C.W,D1                      ; $00DF58
        ANDI.B  #$00E0,D1                       ; $00DF5C
        BNE.S  loc_00DF94                       ; $00DF60
        CMPI.B  #$0002,$A024.W                  ; $00DF62
        BNE.W  loc_00DF7E                       ; $00DF68
        MOVE.W  $C86E.W,D1                      ; $00DF6C
        MOVE.W  D1,D2                           ; $00DF70
        ANDI.B  #$00E0,D2                       ; $00DF72
        BNE.S  loc_00DF94                       ; $00DF76
        ANDI.B  #$0010,D1                       ; $00DF78
        BNE.S  loc_00DF90                       ; $00DF7C
loc_00DF7E:
        MOVE.W  $C86C.W,D1                      ; $00DF7E
        ANDI.B  #$0010,D1                       ; $00DF82
        BNE.S  loc_00DF90                       ; $00DF86
        SUBQ.W  #8,$C87E.W                      ; $00DF88
        BRA.W  loc_00DFE4                       ; $00DF8C
loc_00DF90:
        ST      $A018.W                         ; $00DF90
loc_00DF94:
        MOVE.B  #$00A8,$C8A4.W                  ; $00DF94
        MOVE.B  #$0001,$C809.W                  ; $00DF9A
        MOVE.B  #$0001,$C80A.W                  ; $00DFA0
        BSET    #7,$C80E.W                      ; $00DFA6
        MOVE.B  #$0001,$C802.W                  ; $00DFAC
        MOVE.W  #$0002,$A02C.W                  ; $00DFB2
        BRA.W  loc_00DFE0                       ; $00DFB8
loc_00DFBC:
        BTST    #6,$C80E.W                      ; $00DFBC
        BNE.S  loc_00DFE0                       ; $00DFC2
        CLR.W  $A02C.W                          ; $00DFC4
        BRA.W  loc_00DFE0                       ; $00DFC8
loc_00DFCC:
        BTST    #7,$C80E.W                      ; $00DFCC
        BNE.S  loc_00DFE0                       ; $00DFD2
        CLR.W  $A02C.W                          ; $00DFD4
        ADDQ.W  #4,$C87E.W                      ; $00DFD8
        BRA.W  loc_00DFE4                       ; $00DFDC
loc_00DFE0:
        SUBQ.W  #8,$C87E.W                      ; $00DFE0
loc_00DFE4:
        MOVE.B  #$0001,$C821.W                  ; $00DFE4
        RTS                                     ; $00DFEA
        TST.B  $A018.W                          ; $00DFEC
        BNE.S  loc_00E006                       ; $00DFF0
        MOVE.B  #$00F3,$C822.W                  ; $00DFF2
loc_00DFF8:
        TST.B  $00A15120                        ; $00DFF8
        BNE.S  loc_00DFF8                       ; $00DFFE
        CLR.B  $00A15123                        ; $00E000
loc_00E006:
        ADDQ.W  #4,$C87E.W                      ; $00E006
        RTS                                     ; $00E00A
        TST.B  $A027.W                          ; $00E00C
        BNE.W  loc_00E01C                       ; $00E010
        MOVE.B  $A019.W,$A025.W                 ; $00E014
        BRA.S  loc_00E022                       ; $00E01A
loc_00E01C:
        MOVE.B  $A019.W,$A026.W                 ; $00E01C
loc_00E022:
        TST.B  $A024.W                          ; $00E022
        BEQ.S  loc_00E040                       ; $00E026
        CMPI.B  #$0001,$A024.W                  ; $00E028
        BEQ.S  loc_00E05A                       ; $00E02E
        MOVE.B  $A025.W,$FEAB.W                 ; $00E030
        MOVE.B  $A026.W,$FEAC.W                 ; $00E036
        BRA.W  loc_00E066                       ; $00E03C
loc_00E040:
        MOVE.B  $A019.W,$FEA5.W                 ; $00E040
        BTST    #7,$FDA8.W                      ; $00E046
        BEQ.W  loc_00E066                       ; $00E04C
        MOVE.B  $A019.W,$FEA6.W                 ; $00E050
        BRA.W  loc_00E066                       ; $00E056
loc_00E05A:
        MOVE.B  $A025.W,$FEA7.W                 ; $00E05A
        MOVE.B  $A026.W,$FEA8.W                 ; $00E060
loc_00E066:
        MOVE.W  #$0000,$C87E.W                  ; $00E066
        MOVE.L  #$0088E5CE,$00FF0002            ; $00E06C
        CMPI.B  #$0001,$A024.W                  ; $00E076
        BEQ.S  loc_00E09A                       ; $00E07C
        CMPI.B  #$0002,$A024.W                  ; $00E07E
        BEQ.S  loc_00E0A6                       ; $00E084
        BTST    #7,$FDA8.W                      ; $00E086
        BEQ.S  loc_00E0B0                       ; $00E08C
        MOVE.L  #$0088E5E6,$00FF0002            ; $00E08E
        BRA.S  loc_00E0B0                       ; $00E098
loc_00E09A:
        MOVE.L  #$0088E5FE,$00FF0002            ; $00E09A
        BRA.S  loc_00E0B0                       ; $00E0A4
loc_00E0A6:
        MOVE.L  #$0088F13C,$00FF0002            ; $00E0A6
loc_00E0B0:
        TST.B  $A018.W                          ; $00E0B0
        BNE.S  loc_00E116                       ; $00E0B4
        MOVE.L  #$00884D98,$00FF0002            ; $00E0B6
        CMPI.B  #$0001,$A024.W                  ; $00E0C0
        BEQ.W  loc_00E0E2                       ; $00E0C6
        CMPI.B  #$0002,$A024.W                  ; $00E0CA
        BEQ.W  loc_00E0FC                       ; $00E0D0
        MOVE.L  #$00884A3E,$00FF0002            ; $00E0D4
        BRA.W  loc_00E116                       ; $00E0DE
loc_00E0E2:
        BSET    #5,$C80E.W                      ; $00E0E2
        BCLR    #4,$C80E.W                      ; $00E0E8
        MOVE.L  #$00885100,$00FF0002            ; $00E0EE
        BRA.W  loc_00E116                       ; $00E0F8
loc_00E0FC:
        BSET    #4,$C80E.W                      ; $00E0FC
        BCLR    #5,$C80E.W                      ; $00E102
        MOVE.L  #$00884D98,$00FF0002            ; $00E108
        BRA.W  loc_00E116                       ; $00E112
loc_00E116:
        RTS                                     ; $00E116
loc_00E118:
        MOVEQ   #$00,D0                         ; $00E118
        TST.B  $A027.W                          ; $00E11A
        BNE.S  loc_00E126                       ; $00E11E
        MOVE.B  $A019.W,D0                      ; $00E120
        BRA.S  loc_00E12A                       ; $00E124
loc_00E126:
        MOVE.B  $A025.W,D0                      ; $00E126
loc_00E12A:
        LEA     $0088E19E,A1                    ; $00E12A
        ADD.W  D0,D0                            ; $00E130
        MOVE.W  D0,D1                           ; $00E132
        ADD.W  D0,D0                            ; $00E134
        ADD.W  D1,D0                            ; $00E136
        MOVEA.L $00(A1,D0.W),A0                 ; $00E138
        MOVE.W  $04(A1,D0.W),D0                 ; $00E13C
        MOVE.W  #$0030,D1                       ; $00E140
        MOVE.W  #$0010,D2                       ; $00E144
        JSR     $00E3B4(PC)                     ; $00E148
        MOVEQ   #$00,D0                         ; $00E14C
        TST.B  $A027.W                          ; $00E14E
        BEQ.S  loc_00E15A                       ; $00E152
        MOVE.B  $A019.W,D0                      ; $00E154
        BRA.S  loc_00E15E                       ; $00E158
loc_00E15A:
        MOVE.B  $A026.W,D0                      ; $00E15A
loc_00E15E:
        MOVE.B  D0,D3                           ; $00E15E
        MOVEA.L #$0401C010,A0                   ; $00E160
        ADD.W  D0,D0                            ; $00E166
        ADD.W  D0,D0                            ; $00E168
        ADD.W  D0,D0                            ; $00E16A
        MOVE.W  D0,D1                           ; $00E16C
        ADD.W  D0,D0                            ; $00E16E
        ADD.W  D0,D0                            ; $00E170
        ADD.W  D0,D0                            ; $00E172
        ADD.W  D1,D0                            ; $00E174
        LEA     $00(A0,D0.W),A0                 ; $00E176
        MOVE.W  #$0049,D0                       ; $00E17A
        MOVE.W  #$0010,D1                       ; $00E17E
        MOVE.W  #$0010,D2                       ; $00E182
        TST.B  D3                               ; $00E186
        BEQ.S  loc_00E190                       ; $00E188
        MOVE.W  #$0048,D0                       ; $00E18A
        SUBQ.L  #1,A0                           ; $00E18E
loc_00E190:
        TST.B  $00A15120                        ; $00E190
        BNE.S  loc_00E190                       ; $00E196
        JSR     $00E3B4(PC)                     ; $00E198
        RTS                                     ; $00E19C
        SUBI.B  #$4010,D1                       ; $00E19E
        ORI.B  #$0401,$4049(PC)                 ; $00E1A2
        ORI.B  #$0401,-$7D(PC,D4.W)             ; $00E1A8
        ORI.B  #$0401,$40BC(PC)                 ; $00E1AE
        ORI.B  #$0401,$40F5(PC)                 ; $00E1B4
        ORI.B  #$3ABC,$02(PC,A0.L)              ; $00E1BA
        MOVE.L  #$40000003,(A5)                 ; $00E1C0
        CLR.W  D0                               ; $00E1C6
        MOVEQ   #$1B,D3                         ; $00E1C8
        MOVE.W  D0,D1                           ; $00E1CA
        LSL.W  #3,D1                            ; $00E1CC
        LEA     $0088E20C,A0                    ; $00E1CE
        LEA     $00(A0,D1.W),A0                 ; $00E1D4
        MOVE.W  #$0005,D4                       ; $00E1D8
loc_00E1DC:
        MOVE.W  #$0007,D5                       ; $00E1DC
loc_00E1E0:
        MOVEQ   #$00,D6                         ; $00E1E0
        MOVE.B  $00(A0,D5.W),D6                 ; $00E1E2
        ADDI.W  #$02F0,D6                       ; $00E1E6
        MOVE.W  D6,(A6)                         ; $00E1EA
        DBRA    D5,loc_00E1E0                   ; $00E1EC
        DBRA    D4,loc_00E1DC                   ; $00E1F0
        MOVE.W  #$004F,D4                       ; $00E1F4
loc_00E1F8:
        MOVE.W  #$0000,(A6)                     ; $00E1F8
        DBRA    D4,loc_00E1F8                   ; $00E1FC
