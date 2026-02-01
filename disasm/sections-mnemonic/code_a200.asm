; ============================================================================
; Code Section ($00A200-$00C1FF)
; Regenerated with fixed disassembler - proper mnemonics
; ============================================================================

        org     $00A200

        MOVE.B  $C30F.W,D1                      ; $00A200
        ADD.B  D1,D0                            ; $00A204
        ASL.W  #5,D0                            ; $00A206
        MOVE.W  $008A(A0),D1                    ; $00A208
        ADD.W  D1,D1                            ; $00A20C
        ADD.W  D1,D0                            ; $00A20E
        MOVE.W  $06(PC,D0.W),$000A(A0)          ; $00A210
        RTS                                     ; $00A216
        DC.W    $048F                           ; $00A218
        DC.W    $048B                           ; $00A21A
        DC.W    $048B                           ; $00A21C
        SUBI.L  #$04810468,D1                   ; $00A21E
        SUBI.W  #$03D0,(A6)                     ; $00A224
        BSET    D1,(A0)                         ; $00A228
        BSET    D1,(A0)                         ; $00A22A
        BSET    D1,(A0)                         ; $00A22C
        BSET    D1,A7                           ; $00A22E
        BSET    D1,A7                           ; $00A230
        BCHG    D1,(A2)+                        ; $00A232
        BCHG    D1,(A2)+                        ; $00A234
        BCHG    D1,(A2)+                        ; $00A236
        SUBI.L  #$04950495,(A6)                 ; $00A238
        SUBI.L  #$048F0481,(A5)                 ; $00A23E
        SUBI.W  #$046B,$59(A7,D0.W)             ; $00A244
        BSET    D1,$03E0(A1)                    ; $00A24A
        BSET    D1,-(A0)                        ; $00A24E
        BSET    D1,(A7)+                        ; $00A250
        BSET    D1,(A7)+                        ; $00A252
        BSET    D1,(A7)+                        ; $00A254
        BSET    D1,(A7)+                        ; $00A256
        BSET    D1,#$03EB                       ; $00A258
        BSET    D1,$03EA(A2)                    ; $00A25C
        BSET    D1,$03EA(A2)                    ; $00A260
        BSET    D1,$03EA(A2)                    ; $00A264
        BSET    D1,$03E4(A2)                    ; $00A268
        BSET    D1,-(A4)                        ; $00A26C
        BSET    D1,-(A4)                        ; $00A26E
        BSET    D1,-(A4)                        ; $00A270
        BSET    D1,-(A1)                        ; $00A272
        BSET    D1,(A1)+                        ; $00A274
        BSET    D1,(A1)+                        ; $00A276
        DC.W    $040B                           ; $00A278
        DC.W    $0408                           ; $00A27A
        SUBI.B  #$03FC,D4                       ; $00A27C
        BSET    D1,#$03FC                       ; $00A280
        BSET    D1,#$03F4                       ; $00A284
        BSET    D1,-$0D(A4,D0.W)                ; $00A288
        BSET    D1,-$0D(A3,D0.W)                ; $00A28C
        BSET    D1,-$0E(A3,D0.W)                ; $00A290
        BSET    D1,$03EA(A3)                    ; $00A294
        BCHG    D2,A4                           ; $00A298
        BTST    D2,<EA:3D>                      ; $00A29A
        BTST    D2,$043C(A0)                    ; $00A29C
        SUBI.B  #$043C,#$043C                   ; $00A2A0
        SUBI.B  #$042B,#$042A                   ; $00A2A6
        SUBI.B  #$0429,$0429(A1)                ; $00A2AC
        SUBI.B  #$0429,$03A8(A1)                ; $00A2B2
        BCHG    D2,-(A3)                        ; $00A2B8
        BCHG    D2,A3                           ; $00A2BA
        BCHG    D2,A3                           ; $00A2BC
        BTST    D2,$2B(A6,D0.W)                 ; $00A2BE
        BTST    D2,A3                           ; $00A2C2
        DC.W    $04DD                           ; $00A2C4
        DC.W    $04D2                           ; $00A2C6
        DC.W    $04CF                           ; $00A2C8
        DC.W    $04C7                           ; $00A2CA
        SUBI.L  #$04980498,#$04160416           ; $00A2CC
        SUBI.B  #$0200,(A0)                     ; $00A2D6
        BCHG    D7,-$25(A4,D1.L)                ; $00A2DA
        MOVE.L  -(A5),D7                        ; $00A2DE
        MOVE.W  D3,$4C29(A6)                    ; $00A2E0
        SPL     D7                              ; $00A2E4
        BVS.S  loc_00A2F8                       ; $00A2E6
        MOVEQ   #-$08,D3                        ; $00A2E8
        OR.W   $6C(A0,A1.W),D2                  ; $00A2EA
        SUBA.L  -(A1),A6                        ; $00A2EE
        DC.W    $A9C2                           ; $00A2F0
        EOR.B  D2,D4                            ; $00A2F2
        EOR.L  D7,(A6)+                         ; $00A2F4
        AND.L  D4,D4                            ; $00A2F6
loc_00A2F8:
        ADD.L  -$24EC(A7),D1                    ; $00A2F8
        LSR.L  D1,D5                            ; $00A2FC
        ROXL.W  D4,D2                           ; $00A2FE
        ROL.W  #7,D5                            ; $00A300
        MOVEA.W -$0771(A0),A2                   ; $00A302
        DC.W    $FBCE                           ; $00A306
        MOVE.W  -(A2),D7                        ; $00A308
        MOVE.W  A0,$60(A7,D0.W)                 ; $00A30A
        ORI.W  #$0020,D0                        ; $00A30E
        ORI.B  #$FF88,D0                        ; $00A312
        MOVE.W  -(A2),D7                        ; $00A316
        DC.W    $FBCE                           ; $00A318
        MOVE.W  A7,(A4)                         ; $00A31A
        MOVEA.W -$10A3(A0),A2                   ; $00A31C
        ROXL.W  D4,D2                           ; $00A320
        LSR.L  D1,D5                            ; $00A322
        ADD.B  D5,(A4)                          ; $00A324
        ADD.L  -$367C(A7),D1                    ; $00A326
        EOR.L  D7,(A6)+                         ; $00A32A
        EOR.B  D2,D4                            ; $00A32C
        DC.W    $A9C2                           ; $00A32E
        SUBA.L  -(A1),A6                        ; $00A330
        SUB.W  D0,-$7B90(A4)                    ; $00A332
        MOVEQ   #-$08,D3                        ; $00A336
        BVS.S  loc_00A34A                       ; $00A338
        SPL     D7                              ; $00A33A
        DC.W    $4C29                           ; $00A33C
        MOVE.W  D3,$2E25(A6)                    ; $00A33E
        MOVE.B  (A3)+,(A7)+                     ; $00A342
        BCHG    D7,$00(A4,D0.W)                 ; $00A344
        MOVE.W  -(A0),-$40(A7,A7.L)             ; $00A348
        DC.W    $FFE0                           ; $00A34C
        ORI.B  #$4A68,D0                        ; $00A34E
        ORI.W  #$6F1A,$3028(A2)                 ; $00A352
        ORI.W  #$D040,$43FA(A4)                 ; $00A358
        MOVE.W  $3171(PC),$0000(A7)             ; $00A35E
        ORI.W  #$5368,$006A(A6)                 ; $00A364
        ADDQ.W  #1,$006C(A0)                    ; $00A36A
        BRA.S  loc_00A3B8                       ; $00A36E
        MOVE.W  $0002(A0),D0                    ; $00A370
        ANDI.W  #$2000,D0                       ; $00A374
        BEQ.S  loc_00A394                       ; $00A378
        ANDI.W  #$DFFF,$0002(A0)                ; $00A37A
        MOVEQ   #$1E,D0                         ; $00A380
        MOVE.W  D0,$006C(A0)                    ; $00A382
        MOVE.W  D0,$006A(A0)                    ; $00A386
        MOVE.W  D0,$0014(A0)                    ; $00A38A
        CLR.W  $000E(A0)                        ; $00A38E
        BRA.S  loc_00A3B8                       ; $00A392
loc_00A394:
        MOVE.W  $0002(A0),D0                    ; $00A394
        ANDI.W  #$1000,D0                       ; $00A398
        BEQ.S  loc_00A3B8                       ; $00A39C
        ANDI.W  #$EFFF,$0002(A0)                ; $00A39E
        MOVEQ   #$00,D0                         ; $00A3A4
        MOVE.W  D0,$000E(A0)                    ; $00A3A6
        MOVE.W  D0,$006C(A0)                    ; $00A3AA
        MOVEQ   #$1E,D0                         ; $00A3AE
        MOVE.W  D0,$006A(A0)                    ; $00A3B0
        MOVE.W  D0,$0014(A0)                    ; $00A3B4
loc_00A3B8:
        RTS                                     ; $00A3B8
        LEA     $0093925E,A1                    ; $00A3BA
        MOVE.W  $0004(A0),D0                    ; $00A3C0
        ADD.W  D0,D0                            ; $00A3C4
        MOVE.W  $00(A1,D0.W),D0                 ; $00A3C6
        CMPI.W  #$0002,$C8C8.W                  ; $00A3CA
        BNE.S  loc_00A3D4                       ; $00A3D0
        ASR.W  #2,D0                            ; $00A3D2
loc_00A3D4:
        MOVE.W  D0,$0016(A0)                    ; $00A3D4
        TST.W  $0014(A0)                        ; $00A3D8
        BLE.S  loc_00A3E8                       ; $00A3DC
        SUBQ.W  #1,$0014(A0)                    ; $00A3DE
        ADDI.W  #$0738,$0016(A0)                ; $00A3E2
loc_00A3E8:
        RTS                                     ; $00A3E8
        LEA     $00899DA4,A1                    ; $00A3EA
        MOVE.W  $0004(A0),D0                    ; $00A3F0
        ADD.W  D0,D0                            ; $00A3F4
        MOVE.W  $00(A1,D0.W),D1                 ; $00A3F6
        SUB.W  $0016(A0),D1                     ; $00A3FA
        EXT.L   D1                              ; $00A3FE
        DIVS    #$0067,D1                       ; $00A400
        MOVE.W  $0008(A0),D0                    ; $00A404
        SUB.W  $0006(A0),D0                     ; $00A408
        CMP.W  $C0F8.W,D1                       ; $00A40C
        BLE.S  loc_00A416                       ; $00A410
        MOVE.W  $C0F8.W,D1                      ; $00A412
loc_00A416:
        CMP.W  D1,D0                            ; $00A416
        BGE.S  loc_00A426                       ; $00A418
        CMP.W  $C0FA.W,D0                       ; $00A41A
        BGE.S  loc_00A428                       ; $00A41E
        MOVE.W  $C0FA.W,D0                      ; $00A420
        BRA.S  loc_00A428                       ; $00A424
loc_00A426:
        MOVE.W  D1,D0                           ; $00A426
loc_00A428:
        ADD.W  D0,$0006(A0)                     ; $00A428
        BGE.S  loc_00A432                       ; $00A42C
        CLR.W  $0006(A0)                        ; $00A42E
loc_00A432:
        RTS                                     ; $00A432
        CMPI.W  #$0001,$C8C8.W                  ; $00A434
        BEQ.S  loc_00A46E                       ; $00A43A
        CMPI.W  #$0059,$0004(A0)                ; $00A43C
        BLT.S  loc_00A46E                       ; $00A442
        CMPI.B  #$0004,$C319.W                  ; $00A444
        BNE.S  loc_00A46E                       ; $00A44A
        TST.W  $0086(A0)                        ; $00A44C
        BNE.S  loc_00A46E                       ; $00A450
        MOVE.W  #$000F,$0086(A0)                ; $00A452
        MOVE.B  #$00B7,$C8A4.W                  ; $00A458
        MOVEQ   #$00,D0                         ; $00A45E
        CMPI.W  #$00C8,$0004(A0)                ; $00A460
        BLT.S  loc_00A46A                       ; $00A466
        MOVEQ   #$01,D0                         ; $00A468
loc_00A46A:
        MOVE.W  D0,$00BE(A0)                    ; $00A46A
loc_00A46E:
        RTS                                     ; $00A46E
        MOVEA.L $0018(A0),A3                    ; $00A470
        MOVE.W  $0024(A0),D0                    ; $00A474
        MOVE.W  D0,D1                           ; $00A478
        ADD.W  D0,D0                            ; $00A47A
        ADD.W  D0,D1                            ; $00A47C
        ADD.W  D1,D1                            ; $00A47E
        MOVE.L  $0C(A3,D1.W),$A000.W            ; $00A480
        MOVE.W  #$0096,D0                       ; $00A486
        TST.W  $006A(A0)                        ; $00A48A
        BNE.S  loc_00A4AA                       ; $00A48E
        MOVE.W  $000A(A0),D0                    ; $00A490
        MOVEA.L $C280.W,A1                      ; $00A494
        MOVE.W  $00C2(A0),D2                    ; $00A498
        ASR.W  #3,D2                            ; $00A49C
        MOVE.W  $00(A1,D2.W),D2                 ; $00A49E
        MULS    $04(A3,D1.W),D2                 ; $00A4A2
        ASR.L  #8,D2                            ; $00A4A6
        ADD.W  D2,D0                            ; $00A4A8
loc_00A4AA:
        MOVE.W  D0,$0008(A0)                    ; $00A4AA
        BTST    #1,$0055(A0)                    ; $00A4AE
        BEQ.W  loc_00A666                       ; $00A4B4
        MOVE.W  $00A4(A0),D0                    ; $00A4B8
        BEQ.W  loc_00A6F8                       ; $00A4BC
        LEA     $9000.W,A1                      ; $00A4C0
        ASL.W  #8,D0                            ; $00A4C4
        LEA     $00(A1,D0.W),A1                 ; $00A4C6
        TST.W  $00A4(A1)                        ; $00A4CA
        BEQ.W  loc_00A6F8                       ; $00A4CE
        LEA     $9000.W,A1                      ; $00A4D2
        MOVE.W  $00A6(A0),D0                    ; $00A4D6
        BEQ.S  loc_00A4E6                       ; $00A4DA
        CMPI.W  #$0082,$0004(A0)                ; $00A4DC
        BLT.W  loc_00A666                       ; $00A4E2
loc_00A4E6:
        ASL.W  #8,D0                            ; $00A4E6
        LEA     $00(A1,D0.W),A1                 ; $00A4E8
        MOVE.W  $0030(A1),D0                    ; $00A4EC
        SUB.W  $0030(A0),D0                     ; $00A4F0
        BPL.S  loc_00A4F8                       ; $00A4F4
        NEG.W  D0                               ; $00A4F6
loc_00A4F8:
        MOVE.W  $0034(A1),D7                    ; $00A4F8
        SUB.W  $0034(A0),D7                     ; $00A4FC
        BPL.S  loc_00A504                       ; $00A500
        NEG.W  D7                               ; $00A502
loc_00A504:
        ADD.W  D0,D7                            ; $00A504
        MOVE.W  $0072(A1),D3                    ; $00A506
        SUB.W  $0072(A0),D3                     ; $00A50A
        MOVE.W  D3,D6                           ; $00A50E
        BPL.S  loc_00A514                       ; $00A510
        NEG.W  D6                               ; $00A512
loc_00A514:
        CMPI.W  #$0140,D7                       ; $00A514
        BGE.W  loc_00A582                       ; $00A518
        CMPI.W  #$00A0,D7                       ; $00A51C
        BLE.S  loc_00A52E                       ; $00A520
        MOVE.W  $0004(A0),D0                    ; $00A522
        SUB.W  $0004(A1),D0                     ; $00A526
        BGT.W  loc_00A55C                       ; $00A52A
loc_00A52E:
        CMPI.W  #$0040,D6                       ; $00A52E
        BGE.S  loc_00A55C                       ; $00A532
        MOVEQ   #$40,D0                         ; $00A534
        SUB.W  D6,D0                            ; $00A536
        TST.W  D3                               ; $00A538
        BPL.S  loc_00A53E                       ; $00A53A
        NEG.W  D0                               ; $00A53C
loc_00A53E:
        CMPI.W  #$001C,$C07A.W                  ; $00A53E
        BEQ.S  loc_00A550                       ; $00A544
        ADD.W  D0,D0                            ; $00A546
        MOVE.W  D0,D1                           ; $00A548
        ADD.W  D0,D0                            ; $00A54A
        ADD.W  D1,D0                            ; $00A54C
        BRA.S  loc_00A558                       ; $00A54E
loc_00A550:
        ASL.W  #2,D0                            ; $00A550
        MOVE.W  D0,D1                           ; $00A552
        ASL.W  #3,D1                            ; $00A554
        ADD.W  D1,D0                            ; $00A556
loc_00A558:
        ADD.W  D0,$0040(A0)                     ; $00A558
loc_00A55C:
        CMPI.W  #$0070,D7                       ; $00A55C
        BGE.S  loc_00A582                       ; $00A560
        MOVE.W  $0040(A1),D0                    ; $00A562
        SUB.W  $0040(A0),D0                     ; $00A566
        MOVE.W  D0,D1                           ; $00A56A
        TST.W  D3                               ; $00A56C
        BLT.S  loc_00A572                       ; $00A56E
        NEG.W  D1                               ; $00A570
loc_00A572:
        TST.W  D1                               ; $00A572
        BLT.S  loc_00A582                       ; $00A574
        CMPI.W  #$1800,D1                       ; $00A576
        BGE.S  loc_00A582                       ; $00A57A
        ASR.W  #1,D0                            ; $00A57C
        ADD.W  D0,$0040(A0)                     ; $00A57E
loc_00A582:
        LEA     $9000.W,A2                      ; $00A582
        MOVE.W  $00A4(A0),D0                    ; $00A586
        LSL.W  #8,D0                            ; $00A58A
        LEA     $00(A2,D0.W),A1                 ; $00A58C
        MOVE.W  $00A4(A1),D0                    ; $00A590
        BNE.S  loc_00A5AC                       ; $00A594
        LSL.W  #8,D0                            ; $00A596
        LEA     $00(A2,D0.W),A2                 ; $00A598
        MOVE.W  $0024(A2),D0                    ; $00A59C
        SUB.W  $0024(A1),D0                     ; $00A5A0
        CMPI.W  #$0004,D0                       ; $00A5A4
        BGT.S  loc_00A5AC                       ; $00A5A8
        LEA     (A2),A1                         ; $00A5AA
loc_00A5AC:
        MOVE.W  $0030(A1),D0                    ; $00A5AC
        SUB.W  $0030(A0),D0                     ; $00A5B0
        BPL.S  loc_00A5B8                       ; $00A5B4
        NEG.W  D0                               ; $00A5B6
loc_00A5B8:
        MOVE.W  $0034(A1),D7                    ; $00A5B8
        SUB.W  $0034(A0),D7                     ; $00A5BC
        BPL.S  loc_00A5C4                       ; $00A5C0
        NEG.W  D7                               ; $00A5C2
loc_00A5C4:
        ADD.W  D0,D7                            ; $00A5C4
        MOVE.W  $0072(A1),D3                    ; $00A5C6
        SUB.W  $0072(A0),D3                     ; $00A5CA
        MOVE.W  D3,D6                           ; $00A5CE
        BPL.S  loc_00A5D4                       ; $00A5D0
        NEG.W  D6                               ; $00A5D2
loc_00A5D4:
        MOVE.W  $0006(A1),D0                    ; $00A5D4
        SUB.W  $0006(A0),D0                     ; $00A5D8
        BGE.S  loc_00A606                       ; $00A5DC
        CMPI.W  #$01E0,D7                       ; $00A5DE
        BGT.S  loc_00A606                       ; $00A5E2
        CMPI.W  #$0040,D7                       ; $00A5E4
        BLE.S  loc_00A606                       ; $00A5E8
        CMPI.W  #$0030,D6                       ; $00A5EA
        BGT.S  loc_00A606                       ; $00A5EE
        CMPI.W  #$0064,$0004(A0)                ; $00A5F0
        BLE.S  loc_00A606                       ; $00A5F6
        MOVE.W  #$01E0,D1                       ; $00A5F8
        SUB.W  D7,D1                            ; $00A5FC
        ASR.W  #6,D1                            ; $00A5FE
        ASL.W  D1,D0                            ; $00A600
        ADD.W  D0,$0008(A0)                     ; $00A602
loc_00A606:
        CMPI.W  #$0070,D6                       ; $00A606
        BGE.W  loc_00A640                       ; $00A60A
        TST.W  D0                               ; $00A60E
        BLE.S  loc_00A618                       ; $00A610
        CMPI.W  #$00A0,D7                       ; $00A612
        BGT.S  loc_00A640                       ; $00A616
loc_00A618:
        NEG.W  D0                               ; $00A618
        ASR.W  #1,D0                            ; $00A61A
        ADDI.W  #$0A00,D0                       ; $00A61C
        MOVE.W  D7,D1                           ; $00A620
        ASL.W  #4,D1                            ; $00A622
        CMP.W  D1,D0                            ; $00A624
        BGT.S  loc_00A640                       ; $00A626
        CMPI.W  #$0040,D6                       ; $00A628
        BGE.S  loc_00A640                       ; $00A62C
        MOVEQ   #$40,D0                         ; $00A62E
        SUB.W  D6,D0                            ; $00A630
        TST.W  D3                               ; $00A632
        BPL.S  loc_00A638                       ; $00A634
        NEG.W  D0                               ; $00A636
loc_00A638:
        ADD.W  D0,D0                            ; $00A638
        ADD.W  D0,D0                            ; $00A63A
        ADD.W  D0,$0040(A0)                     ; $00A63C
loc_00A640:
        CMPI.W  #$0070,D7                       ; $00A640
        BGE.S  loc_00A666                       ; $00A644
        MOVE.W  $0040(A1),D0                    ; $00A646
        SUB.W  $0040(A0),D0                     ; $00A64A
        MOVE.W  D0,D1                           ; $00A64E
        TST.W  D3                               ; $00A650
        BLT.S  loc_00A656                       ; $00A652
        NEG.W  D1                               ; $00A654
loc_00A656:
        TST.W  D1                               ; $00A656
        BLE.S  loc_00A666                       ; $00A658
        CMPI.W  #$1800,D1                       ; $00A65A
        BGE.S  loc_00A666                       ; $00A65E
        ASR.W  #1,D0                            ; $00A660
        ADD.W  D0,$0040(A0)                     ; $00A662
loc_00A666:
        MOVE.W  $A000.W,D0                      ; $00A666
        SUB.W  $0030(A0),D0                     ; $00A66A
        BPL.S  loc_00A672                       ; $00A66E
        NEG.W  D0                               ; $00A670
loc_00A672:
        MOVE.W  $A002.W,D1                      ; $00A672
        SUB.W  $0034(A0),D1                     ; $00A676
        BPL.S  loc_00A67E                       ; $00A67A
        NEG.W  D1                               ; $00A67C
loc_00A67E:
        ADD.W  D1,D0                            ; $00A67E
        EXT.L   D0                              ; $00A680
        LSL.L  #4,D0                            ; $00A682
        MOVE.W  $0006(A0),D1                    ; $00A684
        ADDQ.W  #1,D1                           ; $00A688
        DIVS    D1,D0                           ; $00A68A
        MOVE.W  D0,D6                           ; $00A68C
        ASR.W  #1,D6                            ; $00A68E
        BGT.S  loc_00A696                       ; $00A690
        MOVEQ   #$01,D6                         ; $00A692
        BRA.S  loc_00A6A2                       ; $00A694
loc_00A696:
        MOVE.W  $0054(A0),D1                    ; $00A696
        ANDI.W  #$0001,D1                       ; $00A69A
        BEQ.S  loc_00A6A2                       ; $00A69E
        MOVEQ   #$02,D6                         ; $00A6A0
loc_00A6A2:
        MOVE.W  $0034(A0),D0                    ; $00A6A2
        MOVE.W  $0030(A0),D1                    ; $00A6A6
        NEG.W  D1                               ; $00A6AA
        MOVE.W  $A002.W,D2                      ; $00A6AC
        MOVE.W  $A000.W,D3                      ; $00A6B0
        NEG.W  D3                               ; $00A6B4
        JSR     loc_00A7A0(PC)                  ; $00A6B6
        SUB.W  $0040(A0),D0                     ; $00A6BA
        EXT.L   D0                              ; $00A6BE
        DIVS    D6,D0                           ; $00A6C0
        ADD.W  D0,$0040(A0)                     ; $00A6C2
        MOVE.W  $0040(A0),D0                    ; $00A6C6
        MOVE.W  D0,$003C(A0)                    ; $00A6CA
        NEG.W  D0                               ; $00A6CE
        JSR     $008F52(PC)                     ; $00A6D0
        MULS    $0006(A0),D0                    ; $00A6D4
        ASR.L  #8,D0                            ; $00A6D8
        ASR.W  #4,D0                            ; $00A6DA
        ADD.W  D0,$0030(A0)                     ; $00A6DC
        MOVE.W  $0040(A0),D0                    ; $00A6E0
        NEG.W  D0                               ; $00A6E4
        JSR     $008F4E(PC)                     ; $00A6E6
        MULS    $0006(A0),D0                    ; $00A6EA
        ASR.L  #8,D0                            ; $00A6EE
        ASR.W  #4,D0                            ; $00A6F0
        ADD.W  D0,$0034(A0)                     ; $00A6F2
        RTS                                     ; $00A6F6
loc_00A6F8:
        LEA     $9000.W,A1                      ; $00A6F8
        MOVE.W  $0030(A1),D0                    ; $00A6FC
        SUB.W  $0030(A0),D0                     ; $00A700
        BPL.S  loc_00A708                       ; $00A704
        NEG.W  D0                               ; $00A706
loc_00A708:
        MOVE.W  $0034(A1),D7                    ; $00A708
        SUB.W  $0034(A0),D7                     ; $00A70C
        BPL.S  loc_00A714                       ; $00A710
        NEG.W  D7                               ; $00A712
loc_00A714:
        ADD.W  D0,D7                            ; $00A714
        MOVE.W  $0072(A1),D3                    ; $00A716
        SUB.W  $0072(A0),D3                     ; $00A71A
        MOVE.W  D3,D6                           ; $00A71E
        BPL.S  loc_00A724                       ; $00A720
        NEG.W  D6                               ; $00A722
loc_00A724:
        MOVE.W  $0006(A1),D0                    ; $00A724
        SUB.W  $0006(A0),D0                     ; $00A728
        BGE.W  loc_00A666                       ; $00A72C
        CMPI.W  #$0230,D7                       ; $00A730
        BGT.W  loc_00A666                       ; $00A734
        CMPI.W  #$0040,D6                       ; $00A738
        BGT.W  loc_00A666                       ; $00A73C
        CMPI.W  #$0064,$0004(A0)                ; $00A740
        BLE.S  loc_00A79C                       ; $00A746
        MOVE.W  #$0230,D1                       ; $00A748
        SUB.W  D7,D1                            ; $00A74C
        ASR.W  #6,D1                            ; $00A74E
        ASL.W  D1,D0                            ; $00A750
        ADD.W  D0,$0008(A0)                     ; $00A752
        BPL.S  loc_00A75C                       ; $00A756
        CLR.W  $0008(A0)                        ; $00A758
loc_00A75C:
        CMPI.W  #$0070,D6                       ; $00A75C
        BGE.W  loc_00A79C                       ; $00A760
        TST.W  D0                               ; $00A764
        BLE.S  loc_00A76E                       ; $00A766
        CMPI.W  #$00F0,D7                       ; $00A768
        BGT.S  loc_00A79C                       ; $00A76C
loc_00A76E:
        NEG.W  D0                               ; $00A76E
        ASR.W  #1,D0                            ; $00A770
        ADDI.W  #$0F00,D0                       ; $00A772
        MOVE.W  D7,D1                           ; $00A776
        ASL.W  #4,D1                            ; $00A778
        CMP.W  D1,D0                            ; $00A77A
        BGT.S  loc_00A79C                       ; $00A77C
        CMPI.W  #$0060,D6                       ; $00A77E
        BGE.W  loc_00A79C                       ; $00A782
        MOVEQ   #$60,D0                         ; $00A786
        SUB.W  D6,D0                            ; $00A788
        TST.W  D3                               ; $00A78A
        BPL.S  loc_00A790                       ; $00A78C
        NEG.W  D0                               ; $00A78E
loc_00A790:
        ASL.W  #3,D0                            ; $00A790
        MOVE.W  D0,D1                           ; $00A792
        ADD.W  D1,D1                            ; $00A794
        ADD.W  D1,D0                            ; $00A796
        ADD.W  D0,$0040(A0)                     ; $00A798
loc_00A79C:
        BRA.W  loc_00A666                       ; $00A79C
loc_00A7A0:
        SUB.W  D1,D3                            ; $00A7A0
        SUB.W  D0,D2                            ; $00A7A2
        BNE.S  loc_00A7B0                       ; $00A7A4
        TST.W  D3                               ; $00A7A6
        BGT.S  loc_00A7BE                       ; $00A7A8
        BLT.S  loc_00A7C4                       ; $00A7AA
        MOVEQ   #$00,D0                         ; $00A7AC
        RTS                                     ; $00A7AE
loc_00A7B0:
        MOVE.W  D3,D0                           ; $00A7B0
        EXT.L   D0                              ; $00A7B2
        ASL.L  #8,D0                            ; $00A7B4
        DIVS    D2,D0                           ; $00A7B6
        BVC.S  loc_00A7CA                       ; $00A7B8
        TST.W  D3                               ; $00A7BA
        BMI.S  loc_00A7C4                       ; $00A7BC
loc_00A7BE:
        MOVE.W  #$4000,D0                       ; $00A7BE
        RTS                                     ; $00A7C2
loc_00A7C4:
        MOVE.W  #$C000,D0                       ; $00A7C4
        RTS                                     ; $00A7C8
loc_00A7CA:
        EXT.L   D0                              ; $00A7CA
        MOVEM.L D2/A1,-(A7)                     ; $00A7CC
        JSR     $008FC8(PC)                     ; $00A7D0
        MOVEM.L (A7)+,D2/A1                     ; $00A7D4
        TST.W  D2                               ; $00A7D8
        BGE.S  loc_00A7E0                       ; $00A7DA
        ADDI.W  #$8000,D0                       ; $00A7DC
loc_00A7E0:
        RTS                                     ; $00A7E0
        LEA     $00938F2E,A1                    ; $00A7E2
        MOVE.W  $C89C.W,D0                      ; $00A7E8
        ASL.W  #5,D0                            ; $00A7EC
        LEA     $00(A1,D0.W),A1                 ; $00A7EE
        LEA     $9100.W,A2                      ; $00A7F2
        MOVEQ   #$0E,D0                         ; $00A7F6
loc_00A7F8:
        MOVE.W  (A1),$00B6(A2)                  ; $00A7F8
        MOVE.W  (A1)+,$000A(A2)                 ; $00A7FC
        LEA     $0100(A2),A2                    ; $00A800
        DBRA    D0,loc_00A7F8                   ; $00A804
        RTS                                     ; $00A808
        MOVEQ   #$00,D1                         ; $00A80A
        MOVE.B  $FDA9.W,D1                      ; $00A80C
        LEA     $FAD8.W,A1                      ; $00A810
        MOVE.W  $C8C8.W,D0                      ; $00A814
        MULS    #$0060,D0                       ; $00A818
        MULS    #$0020,D1                       ; $00A81C
        ADD.W  D1,D0                            ; $00A820
        LEA     $00(A1,D0.W),A1                 ; $00A822
        LEA     $9100.W,A2                      ; $00A826
        MOVEQ   #$0E,D0                         ; $00A82A
loc_00A82C:
        MOVE.W  (A1),$00B6(A2)                  ; $00A82C
        MOVE.W  (A1)+,$000A(A2)                 ; $00A830
        LEA     $0100(A2),A2                    ; $00A834
        DBRA    D0,loc_00A82C                   ; $00A838
        RTS                                     ; $00A83C
        LEA     $00937E7E,A1                    ; $00A83E
        LEA     $FAD8.W,A2                      ; $00A844
        MOVE.W  #$0047,D0                       ; $00A848
loc_00A84C:
        MOVE.L  (A1)+,(A2)+                     ; $00A84C
        DBRA    D0,loc_00A84C                   ; $00A84E
        LEA     $00937F9E,A1                    ; $00A852
        LEA     $FBF8.W,A2                      ; $00A858
        MOVE.W  #$006B,D0                       ; $00A85C
loc_00A860:
        MOVE.L  (A1)+,(A2)+                     ; $00A860
        DBRA    D0,loc_00A860                   ; $00A862
        RTS                                     ; $00A866
        MOVE.W  (A0),-$10(A0,A7.W)              ; $00A868
        MOVE.W  -$0FA0(A0),-(A0)                ; $00A86C
        MOVE.W  -$1130(A0),-(A0)                ; $00A870
        MOVE.W  -$12C0(A0),-(A0)                ; $00A874
        MOVE.W  -$0C80(A0),-(A0)                ; $00A878
        MOVE.W  -$0FA0(A0),-(A0)                ; $00A87C
        MOVE.W  -$12C0(A0),-(A0)                ; $00A880
        MOVE.W  -$15E0(A0),-(A0)                ; $00A884
        ROXR.W  D5,D0                           ; $00A888
        MOVE.W  (A0),-$1590(A5)                 ; $00A88A
        MOVE.W  A0,(A5)                         ; $00A88E
        ROXR.W  D5,D0                           ; $00A890
        DC.W    $F9C0                           ; $00A892
        ROXR.W  D5,D0                           ; $00A894
        MOVE.W  $E900.W,(A4)+                   ; $00A896
        BTST    #8,D0                           ; $00A89A
        MOVEA.W -(A0),A0                        ; $00A89E
        MOVE.W  -$12C0(A0),-(A0)                ; $00A8A0
        MOVE.W  -$15E0(A0),-(A0)                ; $00A8A4
        MOVE.W  -$0C80(A0),-(A0)                ; $00A8A8
        MOVE.W  -$0FA0(A0),-(A0)                ; $00A8AC
        MOVE.W  -$12C0(A0),-(A0)                ; $00A8B0
        MOVE.W  -$15E0(A0),-(A0)                ; $00A8B4
        MOVE.W  -$0C80(A0),-(A0)                ; $00A8B8
        MOVE.W  -$0FA0(A0),-(A0)                ; $00A8BC
        MOVE.W  -$12C0(A0),-(A0)                ; $00A8C0
        MOVE.W  -$15E0(A0),-(A0)                ; $00A8C4
        BTST    D0,D0                           ; $00A8C8
        ORI.L  #$00800080,D0                    ; $00A8CA
        ORI.L  #$00800088,D0                    ; $00A8D0
        MOVE.L  -$78(A2,D0.W),-$5478(A4)        ; $00A8D6
        DC.W    $0088                           ; $00A8DC
        DC.W    $ABCE                           ; $00A8DE
        MOVE.W  $00AE(A0),D0                    ; $00A8E0
        ADD.W  D0,D0                            ; $00A8E4
        LEA     $C05C.W,A1                      ; $00A8E6
        MOVE.W  $00(A1,D0.W),D0                 ; $00A8EA
        ADD.W  D0,D0                            ; $00A8EE
        ADD.W  D0,D0                            ; $00A8F0
        MOVEA.L -$24(PC,D0.W),A1                ; $00A8F2
        JMP     (A1)                            ; $00A8F6
loc_00A8F8:
        TST.W  $0004(A0)                        ; $00A8F8
        BEQ.S  loc_00A932                       ; $00A8FC
        MOVE.W  $0006(A0),D0                    ; $00A8FE
        MOVEA.L $C278.W,A1                      ; $00A902
        MOVE.W  $007A(A0),D1                    ; $00A906
        ADD.W  D1,D1                            ; $00A90A
        MULS    $00(A1,D1.W),D0                 ; $00A90C
        MULS    #$0254,D0                       ; $00A910
        LSR.W  #8,D0                            ; $00A914
        LSR.W  #4,D0                            ; $00A916
        CMPI.W  #$4268,D0                       ; $00A918
        BLE.S  loc_00A922                       ; $00A91C
        MOVE.W  #$4268,D0                       ; $00A91E
loc_00A922:
        CMPI.W  #$0000,D0                       ; $00A922
        BGE.S  loc_00A92C                       ; $00A926
        MOVE.W  #$0000,D0                       ; $00A928
loc_00A92C:
        MOVE.W  D0,$0074(A0)                    ; $00A92C
        BRA.S  loc_00A970                       ; $00A930
loc_00A932:
        MOVE.W  $000E(A0),D0                    ; $00A932
        LSL.W  #6,D0                            ; $00A936
        SUB.W  $0074(A0),D0                     ; $00A938
        CMPI.W  #$0400,D0                       ; $00A93C
        BLE.S  loc_00A946                       ; $00A940
        MOVE.W  #$0400,D0                       ; $00A942
loc_00A946:
        CMPI.W  #$FD00,D0                       ; $00A946
        BGE.S  loc_00A950                       ; $00A94A
        MOVE.W  #$FD00,D0                       ; $00A94C
loc_00A950:
        ADD.W  $0074(A0),D0                     ; $00A950
        CMPI.W  #$3E80,D0                       ; $00A954
        BLE.S  loc_00A95E                       ; $00A958
        MOVE.W  #$3E80,D0                       ; $00A95A
loc_00A95E:
        CMPI.W  #$0000,D0                       ; $00A95E
        BGE.S  loc_00A968                       ; $00A962
        MOVE.W  #$0000,D0                       ; $00A964
loc_00A968:
        MOVE.W  D0,$007E(A0)                    ; $00A968
        MOVE.W  D0,$0074(A0)                    ; $00A96C
loc_00A970:
        RTS                                     ; $00A970
        JSR     loc_00ACC0(PC)                  ; $00A972
        TST.W  $C04E.W                          ; $00A976
        BNE.S  loc_00A980                       ; $00A97A
        SUBQ.W  #1,$C04E.W                      ; $00A97C
loc_00A980:
        CLR.W  $C026.W                          ; $00A980
        CLR.B  $C306.W                          ; $00A984
        JSR     $003C7E(PC)                     ; $00A988
        LEA     -$00C6(PC),A1                   ; $00A98C
        MOVE.W  $C89E.W,D0                      ; $00A990
        MOVE.W  $00(A1,D0.W),D5                 ; $00A994
        LEA     -$0132(PC),A1                   ; $00A998
        MOVE.W  $C8A0.W,D1                      ; $00A99C
        ADD.W  D1,D1                            ; $00A9A0
        ADD.W  D1,D1                            ; $00A9A2
        MOVE.W  $00AE(A0),D0                    ; $00A9A4
        ADD.W  D0,D0                            ; $00A9A8
        ADD.W  D0,D0                            ; $00A9AA
        ADD.W  D1,D0                            ; $00A9AC
        MOVE.W  $00(A1,D0.W),D1                 ; $00A9AE
        MOVE.W  $02(A1,D0.W),D2                 ; $00A9B2
        MOVE.W  D2,D4                           ; $00A9B6
        SUB.W  $0034(A0),D4                     ; $00A9B8
        CMPI.W  #$0002,D4                       ; $00A9BC
        BGE.S  loc_00AA1A                       ; $00A9C0
        MOVE.W  D1,$0030(A0)                    ; $00A9C2
        MOVE.W  D2,$0034(A0)                    ; $00A9C6
        MOVEQ   #$00,D0                         ; $00A9CA
        MOVE.W  D0,$003C(A0)                    ; $00A9CC
        MOVE.W  D0,$0040(A0)                    ; $00A9D0
        MOVE.W  D0,$008E(A0)                    ; $00A9D4
        MOVE.W  D0,$0090(A0)                    ; $00A9D8
        MOVE.W  D0,$0006(A0)                    ; $00A9DC
        MOVE.W  D0,$0004(A0)                    ; $00A9E0
        MOVE.W  D0,$007A(A0)                    ; $00A9E4
        MOVE.W  D0,$0092(A0)                    ; $00A9E8
        MOVE.W  D0,$0014(A0)                    ; $00A9EC
        MOVE.W  D0,$008C(A0)                    ; $00A9F0
        MOVE.W  D0,$00B8(A0)                    ; $00A9F4
        CLR.W  $C02C.W                          ; $00A9F8
        LEA     $C05C.W,A1                      ; $00A9FC
        MOVE.W  $00AE(A0),D0                    ; $00AA00
        ADD.W  D0,D0                            ; $00AA04
        MOVE.W  #$0002,$00(A1,D0.W)             ; $00AA06
        MOVE.W  #$0078,$00B0(A0)                ; $00AA0C
        CLR.W  $C04E.W                          ; $00AA12
        JMP     $009312(PC)                     ; $00AA16
loc_00AA1A:
        CMPI.W  #$0080,D4                       ; $00AA1A
        BGT.S  loc_00AA32                       ; $00AA1E
        MOVE.W  D1,$A002.W                      ; $00AA20
        MOVE.W  D2,$A004.W                      ; $00AA24
        MOVE.W  #$0020,$A006.W                  ; $00AA28
        BRA.W  loc_00AAA8                       ; $00AA2E
loc_00AA32:
        CMPI.W  #$0180,D4                       ; $00AA32
        BGT.S  loc_00AA58                       ; $00AA36
        MOVE.W  D1,$A002.W                      ; $00AA38
        MOVE.W  D2,$A004.W                      ; $00AA3C
        SUBI.W  #$0040,$A004.W                  ; $00AA40
        MOVE.W  D4,D0                           ; $00AA46
        ASR.W  #4,D0                            ; $00AA48
        MOVE.W  D0,D3                           ; $00AA4A
        ADD.W  D0,D0                            ; $00AA4C
        ADD.W  D3,D0                            ; $00AA4E
        ADDQ.W  #8,D0                           ; $00AA50
        MOVE.W  D0,$A006.W                      ; $00AA52
        BRA.S  loc_00AAA8                       ; $00AA56
loc_00AA58:
        CMPI.W  #$0400,D4                       ; $00AA58
        BGT.S  loc_00AA80                       ; $00AA5C
        MOVE.W  D1,$A002.W                      ; $00AA5E
        ADD.W  D5,$A002.W                       ; $00AA62
        MOVE.W  D2,$A004.W                      ; $00AA66
        SUBI.W  #$0080,$A004.W                  ; $00AA6A
        MOVE.W  D4,D0                           ; $00AA70
        ASR.W  #4,D0                            ; $00AA72
        ADD.W  D0,D0                            ; $00AA74
        ADDI.W  #$0020,D0                       ; $00AA76
        MOVE.W  D0,$A006.W                      ; $00AA7A
        BRA.S  loc_00AAA8                       ; $00AA7E
loc_00AA80:
        MOVE.W  D1,$A002.W                      ; $00AA80
        ADD.W  D5,$A002.W                       ; $00AA84
        MOVE.W  D2,$A004.W                      ; $00AA88
        SUBI.W  #$0080,$A004.W                  ; $00AA8C
        MOVE.W  D4,D0                           ; $00AA92
        ASR.W  #4,D0                            ; $00AA94
        ADDI.W  #$0064,D0                       ; $00AA96
        CMPI.W  #$00C8,D0                       ; $00AA9A
        BLE.S  loc_00AAA4                       ; $00AA9E
        MOVE.W  #$00C8,D0                       ; $00AAA0
loc_00AAA4:
        MOVE.W  D0,$A006.W                      ; $00AAA4
loc_00AAA8:
        MOVE.W  $0034(A0),D0                    ; $00AAA8
        MOVE.W  $0030(A0),D1                    ; $00AAAC
        NEG.W  D1                               ; $00AAB0
        MOVE.W  $A004.W,D2                      ; $00AAB2
        MOVE.W  $A002.W,D3                      ; $00AAB6
        NEG.W  D3                               ; $00AABA
        JSR     loc_00A7A0(PC)                  ; $00AABC
        MOVE.W  D0,$A008.W                      ; $00AAC0
        SUB.W  $003C(A0),D0                     ; $00AAC4
        CMPI.W  #$0140,D0                       ; $00AAC8
        BLE.S  loc_00AAD2                       ; $00AACC
        MOVE.W  #$0140,D0                       ; $00AACE
loc_00AAD2:
        CMPI.W  #$FEC0,D0                       ; $00AAD2
        BGE.S  loc_00AADC                       ; $00AAD6
        MOVE.W  #$FEC0,D0                       ; $00AAD8
loc_00AADC:
        ADD.W  D0,$003C(A0)                     ; $00AADC
        MOVE.W  $003C(A0),D3                    ; $00AAE0
        BPL.S  loc_00AAE8                       ; $00AAE4
        NEG.W  D3                               ; $00AAE6
loc_00AAE8:
        CMPI.W  #$0100,D3                       ; $00AAE8
        BGE.S  loc_00AAF2                       ; $00AAEC
        CLR.W  $003C(A0)                        ; $00AAEE
loc_00AAF2:
        MOVE.W  D0,$008E(A0)                    ; $00AAF2
        MOVE.W  D0,$0090(A0)                    ; $00AAF6
        ADD.W  D0,D0                            ; $00AAFA
        NEG.W  D0                               ; $00AAFC
        MOVE.W  D0,$0046(A0)                    ; $00AAFE
        MOVE.W  $A008.W,D0                      ; $00AB02
        SUB.W  $0040(A0),D0                     ; $00AB06
        ASR.W  #2,D0                            ; $00AB0A
        ADD.W  D0,$0040(A0)                     ; $00AB0C
        MOVE.W  $A006.W,D0                      ; $00AB10
        MULS    #$03E8,D0                       ; $00AB14
        LSL.L  #8,D0                            ; $00AB18
        DIVS    #$0E10,D0                       ; $00AB1A
        EXT.L   D0                              ; $00AB1E
        DIVS    #$0014,D0                       ; $00AB20
        MOVE.W  D0,$A006.W                      ; $00AB24
        SUB.W  $0006(A0),D0                     ; $00AB28
        CMPI.W  #$002F,D0                       ; $00AB2C
        BLE.S  loc_00AB36                       ; $00AB30
        MOVE.W  #$002F,D0                       ; $00AB32
loc_00AB36:
        CMPI.W  #$FFB0,D0                       ; $00AB36
        BGE.S  loc_00AB40                       ; $00AB3A
        MOVE.W  #$FFB0,D0                       ; $00AB3C
loc_00AB40:
        ADD.W  D0,$0006(A0)                     ; $00AB40
        JSR     $009B12(PC)                     ; $00AB44
        MOVE.W  $0004(A0),D0                    ; $00AB48
        ASL.W  #5,D0                            ; $00AB4C
        CMPI.W  #$11F8,D0                       ; $00AB4E
        BLE.S  loc_00AB58                       ; $00AB52
        MOVE.W  #$11F8,D0                       ; $00AB54
loc_00AB58:
        CMPI.W  #$0000,D0                       ; $00AB58
        BGE.S  loc_00AB62                       ; $00AB5C
        MOVE.W  #$0000,D0                       ; $00AB5E
loc_00AB62:
        SUB.W  D0,$00BC(A0)                     ; $00AB62
        MOVE.W  $0040(A0),D0                    ; $00AB66
        NEG.W  D0                               ; $00AB6A
        MOVE.W  $0006(A0),D2                    ; $00AB6C
        MOVE.W  $0030(A0),D3                    ; $00AB70
        MOVE.W  $0034(A0),D4                    ; $00AB74
        JSR     $006FDE(PC)                     ; $00AB78
        MOVE.W  D3,$0030(A0)                    ; $00AB7C
        MOVE.W  D4,$0034(A0)                    ; $00AB80
        JMP     $009312(PC)                     ; $00AB84
        JSR     loc_00ACC0(PC)                  ; $00AB88
        MOVEQ   #$78,D0                         ; $00AB8C
        SUB.W  $00B0(A0),D0                     ; $00AB8E
        MULU    #$3BBB,D0                       ; $00AB92
        SWAP    D0                              ; $00AB96
        MOVE.W  D0,$C026.W                      ; $00AB98
        CMPI.W  #$0014,$C026.W                  ; $00AB9C
        BNE.S  loc_00ABAE                       ; $00ABA2
        MOVE.W  #$0000,$008A(A0)                ; $00ABA4
        JSR     $00A1FC(PC)                     ; $00ABAA
loc_00ABAE:
        SUBQ.W  #1,$00B0(A0)                    ; $00ABAE
        BNE.S  loc_00ABCA                       ; $00ABB2
        CLR.B  $00FF6970                        ; $00ABB4
        LEA     $C05C.W,A1                      ; $00ABBA
        MOVE.W  $00AE(A0),D0                    ; $00ABBE
        ADD.W  D0,D0                            ; $00ABC2
        MOVE.W  #$0003,$00(A1,D0.W)             ; $00ABC4
loc_00ABCA:
        JMP     loc_00A8F8(PC)                  ; $00ABCA
        LEA     $C05C.W,A1                      ; $00ABCE
        MOVEQ   #$00,D0                         ; $00ABD2
        MOVE.W  $00AE(A0),D1                    ; $00ABD4
        ADD.W  D1,D1                            ; $00ABD8
loc_00ABDA:
        CMP.W  D1,D0                            ; $00ABDA
        BGE.S  loc_00ABEC                       ; $00ABDC
        CMPI.W  #$0001,$00(A1,D1.W)             ; $00ABDE
        BEQ.W  loc_00A8F8                       ; $00ABE4
        ADDQ.W  #2,D0                           ; $00ABE8
        BRA.S  loc_00ABDA                       ; $00ABEA
loc_00ABEC:
        MOVE.W  $00AE(A0),D0                    ; $00ABEC
        ADDQ.W  #1,D0                           ; $00ABF0
        ADD.W  D0,D0                            ; $00ABF2
loc_00ABF4:
        CMPI.W  #$0008,D0                       ; $00ABF4
        BGE.S  loc_00AC08                       ; $00ABF8
        CMPI.W  #$0004,$00(A1,D0.W)             ; $00ABFA
        BEQ.W  loc_00A8F8                       ; $00AC00
        ADDQ.W  #2,D0                           ; $00AC04
        BRA.S  loc_00ABF4                       ; $00AC06
loc_00AC08:
        ORI.W  #$4000,$0002(A0)                 ; $00AC08
        MOVE.W  #$0050,$C04E.W                  ; $00AC0E
        LEA     $C05C.W,A1                      ; $00AC14
        MOVE.W  $00AE(A0),D0                    ; $00AC18
        ADD.W  D0,D0                            ; $00AC1C
        MOVE.W  #$0000,$00(A1,D0.W)             ; $00AC1E
        MOVE.W  #$003C,$C8AE.W                  ; $00AC24
        MOVE.W  $C08C.W,$C07A.W                 ; $00AC2A
        BCLR    #1,$C30E.W                      ; $00AC30
        MOVE.B  #$0091,$C8A5.W                  ; $00AC36
        RTS                                     ; $00AC3C
        TST.W  $C8AE.W                          ; $00AC3E
        BEQ.S  loc_00AC64                       ; $00AC42
        SUBQ.W  #1,$C8AE.W                      ; $00AC44
        BNE.S  loc_00AC64                       ; $00AC48
        LEA     $00FF66DC,A1                    ; $00AC4A
        CLR.W  (A1)                             ; $00AC50
        CLR.W  $0014(A1)                        ; $00AC52
        CLR.W  $0028(A1)                        ; $00AC56
        CLR.W  $003C(A1)                        ; $00AC5A
        MOVE.W  #$FFFF,$C026.W                  ; $00AC5E
loc_00AC64:
        MOVE.B  $C319.W,D0                      ; $00AC64
        ANDI.B  #$003F,D0                       ; $00AC68
        CMPI.B  #$000D,D0                       ; $00AC6C
        BNE.S  loc_00ACBE                       ; $00AC70
        MOVE.B  $C30E.W,D0                      ; $00AC72
        ANDI.B  #$0021,D0                       ; $00AC76
        BNE.S  loc_00ACBE                       ; $00AC7A
        LEA     $C05C.W,A1                      ; $00AC7C
        MOVE.W  $00AE(A0),D0                    ; $00AC80
        ADD.W  D0,D0                            ; $00AC84
        TST.W  $00(A1,D0.W)                     ; $00AC86
        BNE.S  loc_00ACBE                       ; $00AC8A
        TST.W  $00AC(A0)                        ; $00AC8C
        BLE.S  loc_00ACBE                       ; $00AC90
        TST.B  $C312.W                          ; $00AC92
        BNE.S  loc_00ACBE                       ; $00AC96
        CLR.W  $C8AA.W                          ; $00AC98
        SUBQ.W  #1,$00AC(A0)                    ; $00AC9C
        MOVE.W  #$0001,$00(A1,D0.W)             ; $00ACA0
        ORI.W  #$0200,$0002(A0)                 ; $00ACA6
        MOVE.W  $C08E.W,$C07A.W                 ; $00ACAC
        MOVE.B  #$0090,$C8A5.W                  ; $00ACB2
        BSET    #1,$C30E.W                      ; $00ACB8
loc_00ACBE:
        RTS                                     ; $00ACBE
loc_00ACC0:
        MOVEQ   #$00,D0                         ; $00ACC0
        BTST    #2,$C8AB.W                      ; $00ACC2
        BNE.S  loc_00ACCC                       ; $00ACC8
        MOVEQ   #$01,D0                         ; $00ACCA
loc_00ACCC:
        MOVE.B  D0,$00FF6970                    ; $00ACCC
        RTS                                     ; $00ACD2
        TST.W  $006A(A0)                        ; $00ACD4
        BNE.S  loc_00AD12                       ; $00ACD8
        TST.W  $C02C.W                          ; $00ACDA
        BGT.S  loc_00AD12                       ; $00ACDE
        TST.W  $008C(A0)                        ; $00ACE0
        BNE.S  loc_00AD12                       ; $00ACE4
        CLR.W  $0088(A0)                        ; $00ACE6
        LEA     $9000.W,A1                      ; $00ACEA
        MOVE.W  $00A4(A0),D0                    ; $00ACEE
        LSL.W  #8,D0                            ; $00ACF2
        LEA     $00(A1,D0.W),A1                 ; $00ACF4
        JSR     loc_00ADC4(PC)                  ; $00ACF8
        BNE.S  loc_00AD14                       ; $00ACFC
        LEA     $9000.W,A1                      ; $00ACFE
        MOVE.W  $00A6(A0),D0                    ; $00AD02
        LSL.W  #8,D0                            ; $00AD06
        LEA     $00(A1,D0.W),A1                 ; $00AD08
        JSR     loc_00ADC4(PC)                  ; $00AD0C
        BNE.S  loc_00AD14                       ; $00AD10
loc_00AD12:
        RTS                                     ; $00AD12
loc_00AD14:
        MOVE.B  #$00B8,$C8A4.W                  ; $00AD14
        MOVE.W  $0004(A0),D0                    ; $00AD1A
        SUB.W  $0004(A1),D0                     ; $00AD1E
        BPL.S  loc_00AD26                       ; $00AD22
        NEG.W  D0                               ; $00AD24
loc_00AD26:
        CMP.W  $C8CE.W,D0                       ; $00AD26
        BLE.W  loc_00ADC0                       ; $00AD2A
        MOVE.W  $0006(A0),D0                    ; $00AD2E
        ADD.W  $0006(A1),D0                     ; $00AD32
        MOVE.W  D0,D2                           ; $00AD36
        ASR.W  #1,D2                            ; $00AD38
        ASR.W  #2,D0                            ; $00AD3A
        ADD.W  D0,D2                            ; $00AD3C
        MOVE.W  D0,D1                           ; $00AD3E
        ASR.W  #1,D1                            ; $00AD40
        ADD.W  D0,D1                            ; $00AD42
        CMPI.W  #$04DC,D1                       ; $00AD44
        BLE.S  loc_00AD4E                       ; $00AD48
        MOVE.W  #$04DC,D1                       ; $00AD4A
loc_00AD4E:
        CMPI.W  #$04DC,D2                       ; $00AD4E
        BLE.S  loc_00AD58                       ; $00AD52
        MOVE.W  #$04DC,D2                       ; $00AD54
loc_00AD58:
        MOVE.W  $0006(A1),D0                    ; $00AD58
        CMP.W  $0006(A0),D0                     ; $00AD5C
        BLE.S  loc_00AD64                       ; $00AD60
        AND.W  D1,D2                            ; $00AD62
loc_00AD64:
        MOVE.W  D2,$0006(A1)                    ; $00AD64
        MOVE.W  $0004(A0),D3                    ; $00AD68
        SUB.W  $0004(A1),D3                     ; $00AD6C
        CMP.W  $C8D0.W,D3                       ; $00AD70
        BLE.S  loc_00AD84                       ; $00AD74
        ORI.W  #$1000,$0002(A1)                 ; $00AD76
        ORI.W  #$0800,$0002(A0)                 ; $00AD7C
        RTS                                     ; $00AD82
loc_00AD84:
        MOVE.W  D1,$0006(A0)                    ; $00AD84
        MOVE.W  $0088(A0),D0                    ; $00AD88
        MOVEQ   #$01,D1                         ; $00AD8C
        AND.W  D0,D1                            ; $00AD8E
        BNE.S  loc_00ADAC                       ; $00AD90
        MOVEQ   #$04,D1                         ; $00AD92
        AND.W  D0,D1                            ; $00AD94
        BNE.S  loc_00ADAC                       ; $00AD96
        ORI.W  #$2000,$0002(A0)                 ; $00AD98
        ORI.W  #$1000,$0002(A1)                 ; $00AD9E
        MOVE.B  #$00B2,$C8A4.W                  ; $00ADA4
        RTS                                     ; $00ADAA
loc_00ADAC:
        ORI.W  #$1000,$0002(A0)                 ; $00ADAC
        ORI.W  #$2000,$0002(A1)                 ; $00ADB2
        MOVE.B  #$00B2,$C8A4.W                  ; $00ADB8
        RTS                                     ; $00ADBE
loc_00ADC0:
        JMP     loc_00AED8(PC)                  ; $00ADC0
loc_00ADC4:
        CLR.W  $0088(A1)                        ; $00ADC4
        MOVE.W  $0032(A1),D0                    ; $00ADC8
        SUB.W  $0032(A0),D0                     ; $00ADCC
        BPL.S  loc_00ADD4                       ; $00ADD0
        NEG.W  D0                               ; $00ADD2
loc_00ADD4:
        CMPI.W  #$0200,D0                       ; $00ADD4
        BGE.S  loc_00AE02                       ; $00ADD8
        MOVE.W  $0030(A1),D0                    ; $00ADDA
        SUB.W  $0030(A0),D0                     ; $00ADDE
        BPL.S  loc_00ADE6                       ; $00ADE2
        NEG.W  D0                               ; $00ADE4
loc_00ADE6:
        CMPI.W  #$0040,D0                       ; $00ADE6
        BGE.S  loc_00AE02                       ; $00ADEA
        MOVE.W  $0034(A1),D0                    ; $00ADEC
        SUB.W  $0034(A0),D0                     ; $00ADF0
        BPL.S  loc_00ADF8                       ; $00ADF4
        NEG.W  D0                               ; $00ADF6
loc_00ADF8:
        CMPI.W  #$0040,D0                       ; $00ADF8
        BGE.S  loc_00AE02                       ; $00ADFC
        JMP     loc_00AE0A(PC)                  ; $00ADFE
loc_00AE02:
        MOVEQ   #$00,D0                         ; $00AE02
        RTS                                     ; $00AE04
        BTST    D0,D2                           ; $00AE06
        DC.W    $0408                           ; $00AE08
loc_00AE0A:
        MOVE.W  $003C(A1),D0                    ; $00AE0A
        SUB.W  $0040(A0),D0                     ; $00AE0E
        ASR.W  #5,D0                            ; $00AE12
        ADDI.W  #$0800,D0                       ; $00AE14
        ANDI.W  #$07FE,D0                       ; $00AE18
        MOVE.W  $0030(A0),D3                    ; $00AE1C
        SUB.W  $0030(A1),D3                     ; $00AE20
        MOVE.W  $0034(A0),D4                    ; $00AE24
        SUB.W  $0034(A1),D4                     ; $00AE28
        MOVEA.L $C268.W,A2                      ; $00AE2C
        LEA     $00(A2,D0.W),A2                 ; $00AE30
        MOVEQ   #$03,D2                         ; $00AE34
loc_00AE36:
        MOVE.B  (A2),D6                         ; $00AE36
        EXT.W   D6                              ; $00AE38
        ADD.W  D3,D6                            ; $00AE3A
        MOVE.B  $0001(A2),D7                    ; $00AE3C
        EXT.W   D7                              ; $00AE40
        ADD.W  D4,D7                            ; $00AE42
        CMP.W  $C8E4.W,D6                       ; $00AE44
        BLT.S  loc_00AE64                       ; $00AE48
        CMP.W  $C8E8.W,D6                       ; $00AE4A
        BGT.S  loc_00AE64                       ; $00AE4E
        CMP.W  $C8EA.W,D7                       ; $00AE50
        BLT.S  loc_00AE64                       ; $00AE54
        CMP.W  $C8E6.W,D7                       ; $00AE56
        BGT.S  loc_00AE64                       ; $00AE5A
        MOVEQ   #$03,D0                         ; $00AE5C
        SUB.W  D2,D0                            ; $00AE5E
        BSET    D0,$0089(A0)                    ; $00AE60
loc_00AE64:
        LEA     $0800(A2),A2                    ; $00AE64
        DBRA    D2,loc_00AE36                   ; $00AE68
        MOVE.W  $003C(A0),D0                    ; $00AE6C
        SUB.W  $003C(A1),D0                     ; $00AE70
        ASR.W  #5,D0                            ; $00AE74
        ADDI.W  #$0800,D0                       ; $00AE76
        ANDI.W  #$07FE,D0                       ; $00AE7A
        MOVE.W  $0030(A1),D3                    ; $00AE7E
        SUB.W  $0030(A0),D3                     ; $00AE82
        MOVE.W  $0034(A1),D4                    ; $00AE86
        SUB.W  $0034(A0),D4                     ; $00AE8A
        MOVEA.L $C268.W,A2                      ; $00AE8E
        LEA     $00(A2,D0.W),A2                 ; $00AE92
        MOVEQ   #$03,D2                         ; $00AE96
loc_00AE98:
        MOVE.B  (A2),D6                         ; $00AE98
        EXT.W   D6                              ; $00AE9A
        ADD.W  D3,D6                            ; $00AE9C
        MOVE.B  $0001(A2),D7                    ; $00AE9E
        EXT.W   D7                              ; $00AEA2
        ADD.W  D4,D7                            ; $00AEA4
        CMP.W  $C8EC.W,D6                       ; $00AEA6
        BLT.S  loc_00AECA                       ; $00AEAA
        CMP.W  $C8EE.W,D6                       ; $00AEAC
        BGT.S  loc_00AECA                       ; $00AEB0
        CMP.W  $C8F0.W,D7                       ; $00AEB2
        BLT.S  loc_00AECA                       ; $00AEB6
        CMP.W  $C8F2.W,D7                       ; $00AEB8
        BGT.S  loc_00AECA                       ; $00AEBC
        LEA     -$00BA(PC),A2                   ; $00AEBE
        MOVEQ   #$03,D0                         ; $00AEC2
        SUB.W  D2,D0                            ; $00AEC4
        BSET    D0,$0089(A1)                    ; $00AEC6
loc_00AECA:
        LEA     $0800(A2),A2                    ; $00AECA
        DBRA    D2,loc_00AE98                   ; $00AECE
        MOVE.B  $0089(A0),D0                    ; $00AED2
        RTS                                     ; $00AED6
loc_00AED8:
        MOVE.W  $0088(A0),D0                    ; $00AED8
        MOVEQ   #$18,D1                         ; $00AEDC
        BTST    #0,D0                           ; $00AEDE
        BEQ.S  loc_00AEEC                       ; $00AEE2
        ADD.W  D1,$0030(A0)                     ; $00AEE4
        SUB.W  D1,$0034(A0)                     ; $00AEE8
loc_00AEEC:
        BTST    #1,D0                           ; $00AEEC
        BEQ.S  loc_00AEFA                       ; $00AEF0
        SUB.W  D1,$0030(A0)                     ; $00AEF2
        SUB.W  D1,$0034(A0)                     ; $00AEF6
loc_00AEFA:
        BTST    #2,D0                           ; $00AEFA
        BEQ.S  loc_00AF08                       ; $00AEFE
        ADD.W  D1,$0030(A0)                     ; $00AF00
        ADD.W  D1,$0034(A0)                     ; $00AF04
loc_00AF08:
        BTST    #3,D0                           ; $00AF08
        BEQ.S  loc_00AF16                       ; $00AF0C
        SUB.W  D1,$0030(A0)                     ; $00AF0E
        ADD.W  D1,$0034(A0)                     ; $00AF12
loc_00AF16:
        RTS                                     ; $00AF16
        LEA     $9F00.W,A1                      ; $00AF18
        CLR.W  $0088(A0)                        ; $00AF1C
        CLR.W  $0088(A1)                        ; $00AF20
        MOVE.W  $006A(A0),D0                    ; $00AF24
        ADD.W  $006A(A1),D0                     ; $00AF28
        ADD.W  $008C(A0),D0                     ; $00AF2C
        ADD.W  $008C(A1),D0                     ; $00AF30
        BNE.W  loc_00AFC0                       ; $00AF34
        MOVE.W  $0032(A1),D0                    ; $00AF38
        SUB.W  $0032(A0),D0                     ; $00AF3C
        BPL.S  loc_00AF44                       ; $00AF40
        NEG.W  D0                               ; $00AF42
loc_00AF44:
        CMPI.W  #$0200,D0                       ; $00AF44
        BGE.S  loc_00AFC0                       ; $00AF48
        JSR     loc_00AE0A(PC)                  ; $00AF4A
        BEQ.W  loc_00AFC0                       ; $00AF4E
        MOVE.B  #$00B8,$C8A4.W                  ; $00AF52
        MOVE.W  $0004(A0),D0                    ; $00AF58
        SUB.W  $0004(A1),D0                     ; $00AF5C
        BPL.S  loc_00AF64                       ; $00AF60
        NEG.W  D0                               ; $00AF62
loc_00AF64:
        CMP.W  $C8CE.W,D0                       ; $00AF64
        BLE.W  loc_00AFFE                       ; $00AF68
        MOVE.W  $0006(A0),D0                    ; $00AF6C
        ADD.W  $0006(A1),D0                     ; $00AF70
        MOVE.W  D0,D2                           ; $00AF74
        ASR.W  #1,D2                            ; $00AF76
        ASR.W  #2,D0                            ; $00AF78
        ADD.W  D0,D2                            ; $00AF7A
        MOVE.W  D0,D1                           ; $00AF7C
        ASR.W  #1,D1                            ; $00AF7E
        ADD.W  D0,D1                            ; $00AF80
        CMPI.W  #$04DC,D1                       ; $00AF82
        BLE.S  loc_00AF8C                       ; $00AF86
        MOVE.W  #$04DC,D1                       ; $00AF88
loc_00AF8C:
        CMPI.W  #$04DC,D2                       ; $00AF8C
        BLE.S  loc_00AF96                       ; $00AF90
        MOVE.W  #$04DC,D2                       ; $00AF92
loc_00AF96:
        MOVE.W  $0006(A1),D0                    ; $00AF96
        CMP.W  $0006(A0),D0                     ; $00AF9A
        BLE.S  loc_00AFA2                       ; $00AF9E
        AND.W  D1,D2                            ; $00AFA0
loc_00AFA2:
        MOVE.W  D2,$0006(A1)                    ; $00AFA2
        MOVE.W  $0004(A0),D3                    ; $00AFA6
        SUB.W  $0004(A1),D3                     ; $00AFAA
        CMP.W  $C8D0.W,D3                       ; $00AFAE
        BLE.S  loc_00AFC2                       ; $00AFB2
        ORI.W  #$0800,$0002(A0)                 ; $00AFB4
        ORI.W  #$0800,$0002(A1)                 ; $00AFBA
loc_00AFC0:
        RTS                                     ; $00AFC0
loc_00AFC2:
        MOVE.W  D1,$0006(A0)                    ; $00AFC2
        MOVE.W  $0088(A0),D0                    ; $00AFC6
        MOVEQ   #$01,D1                         ; $00AFCA
        AND.W  D0,D1                            ; $00AFCC
        BNE.S  loc_00AFEA                       ; $00AFCE
        MOVEQ   #$04,D1                         ; $00AFD0
        AND.W  D0,D1                            ; $00AFD2
        BNE.S  loc_00AFEA                       ; $00AFD4
        ORI.W  #$2000,$0002(A0)                 ; $00AFD6
        ORI.W  #$1000,$0002(A1)                 ; $00AFDC
        MOVE.B  #$00B2,$C8A4.W                  ; $00AFE2
        RTS                                     ; $00AFE8
loc_00AFEA:
        ORI.W  #$1000,$0002(A0)                 ; $00AFEA
        ORI.W  #$2000,$0002(A1)                 ; $00AFF0
        MOVE.B  #$00B2,$C8A4.W                  ; $00AFF6
        RTS                                     ; $00AFFC
loc_00AFFE:
        MOVEQ   #$10,D1                         ; $00AFFE
        MOVE.W  $0030(A0),D0                    ; $00B000
        CMP.W  $0030(A1),D0                     ; $00B004
        BGT.S  loc_00B00C                       ; $00B008
        NEG.W  D1                               ; $00B00A
loc_00B00C:
        ADD.W  D1,$0030(A0)                     ; $00B00C
        SUB.W  D1,$0030(A1)                     ; $00B010
        MOVEQ   #$10,D1                         ; $00B014
        MOVE.W  $0034(A0),D0                    ; $00B016
        CMP.W  $0034(A1),D0                     ; $00B01A
        BGT.S  loc_00B022                       ; $00B01E
        NEG.W  D1                               ; $00B020
loc_00B022:
        ADD.W  D1,$0034(A0)                     ; $00B022
        SUB.W  D1,$0034(A1)                     ; $00B026
        RTS                                     ; $00B02A
        MOVEQ   #$00,D0                         ; $00B02C
        MOVE.W  $907E.W,D0                      ; $00B02E
        BSR.S  loc_00B06A                       ; $00B032
        MOVE.W  D0,$00FF674C                    ; $00B034
        RTS                                     ; $00B03A
        BTST    #5,$C30E.W                      ; $00B03C
        BNE.S  loc_00B052                       ; $00B042
        MOVEQ   #$00,D0                         ; $00B044
        MOVE.W  $907E.W,D0                      ; $00B046
        BSR.S  loc_00B06A                       ; $00B04A
        MOVE.W  D0,$00FF6328                    ; $00B04C
loc_00B052:
        BTST    #5,$B4EE.W                      ; $00B052
        BNE.S  loc_00B068                       ; $00B058
        MOVEQ   #$00,D0                         ; $00B05A
        MOVE.W  $9F7E.W,D0                      ; $00B05C
        BSR.S  loc_00B06A                       ; $00B060
        MOVE.W  D0,$00FF6558                    ; $00B062
loc_00B068:
        RTS                                     ; $00B068
loc_00B06A:
        SUBI.W  #$1770,D0                       ; $00B06A
        BPL.S  loc_00B072                       ; $00B06E
        MOVEQ   #$00,D0                         ; $00B070
loc_00B072:
        CMPI.W  #$2AF8,D0                       ; $00B072
        BLT.S  loc_00B07C                       ; $00B076
        MOVE.W  #$2AF8,D0                       ; $00B078
loc_00B07C:
        LSR.W  #3,D0                            ; $00B07C
        MOVE.W  D0,D1                           ; $00B07E
        LSR.W  #1,D0                            ; $00B080
        ADD.W  D1,D0                            ; $00B082
        CMPI.W  #$0800,D0                       ; $00B084
        BLE.S  loc_00B08E                       ; $00B088
        MOVE.W  #$0800,D0                       ; $00B08A
loc_00B08E:
        ADDI.W  #$0800,D0                       ; $00B08E
        RTS                                     ; $00B092
        LEA     $C813.W,A0                      ; $00B094
        MOVE.B  $B4EE.W,D0                      ; $00B098
        BRA.S  loc_00B0A6                       ; $00B09C
        LEA     $C806.W,A0                      ; $00B09E
        MOVE.B  $C30E.W,D0                      ; $00B0A2
loc_00B0A6:
        BTST    #4,D0                           ; $00B0A6
        BEQ.S  loc_00B0DC                       ; $00B0AA
        CMPI.B  #$003C,(A0)                     ; $00B0AC
        BGE.S  loc_00B0DC                       ; $00B0B0
        ADDQ.B  #1,$0002(A0)                    ; $00B0B2
        BNE.S  loc_00B0DC                       ; $00B0B6
        MOVE.B  #$00C4,$0002(A0)                ; $00B0B8
        ANDI.B  #$0023,D0                       ; $00B0BE
        BNE.S  loc_00B0CE                       ; $00B0C2
        TST.B  $C30D.W                          ; $00B0C4
        BNE.S  loc_00B0CE                       ; $00B0C8
        SUBQ.W  #1,$C050.W                      ; $00B0CA
loc_00B0CE:
        ADDQ.B  #1,$0001(A0)                    ; $00B0CE
        BNE.S  loc_00B0DC                       ; $00B0D2
        MOVE.B  #$00C4,$0001(A0)                ; $00B0D4
        ADDQ.B  #1,(A0)                         ; $00B0DA
loc_00B0DC:
        RTS                                     ; $00B0DC
        LEA     $A9E7.W,A0                      ; $00B0DE
        MOVE.B  $B4EE.W,D0                      ; $00B0E2
        JSR     loc_00B0F2(PC)                  ; $00B0E6
        LEA     $A9E3.W,A0                      ; $00B0EA
        MOVE.B  $C30E.W,D0                      ; $00B0EE
loc_00B0F2:
        BTST    #4,D0                           ; $00B0F2
        BEQ.S  loc_00B118                       ; $00B0F6
        CMPI.B  #$003C,(A0)                     ; $00B0F8
        BGE.S  loc_00B118                       ; $00B0FC
        ADDQ.B  #1,$0002(A0)                    ; $00B0FE
        BNE.S  loc_00B118                       ; $00B102
        MOVE.B  #$00C4,$0002(A0)                ; $00B104
        ADDQ.B  #1,$0001(A0)                    ; $00B10A
        BNE.S  loc_00B118                       ; $00B10E
        MOVE.B  #$00C4,$0001(A0)                ; $00B110
        ADDQ.B  #1,(A0)                         ; $00B116
loc_00B118:
        RTS                                     ; $00B118
        LEA     $00FF68D9,A1                    ; $00B11A
        LEA     $C806.W,A2                      ; $00B120
        MOVEQ   #$00,D3                         ; $00B124
        BRA.S  loc_00B15E                       ; $00B126
        LEA     $00FF68D9,A1                    ; $00B128
        LEA     $C806.W,A2                      ; $00B12E
        MOVEQ   #$00,D3                         ; $00B132
        BRA.S  loc_00B15E                       ; $00B134
        LEA     $00FF6959,A1                    ; $00B136
        LEA     $C813.W,A2                      ; $00B13C
        MOVEQ   #$00,D3                         ; $00B140
        BRA.S  loc_00B15E                       ; $00B142
        LEA     $00FF68D9,A1                    ; $00B144
        LEA     $C806.W,A2                      ; $00B14A
        MOVE.W  $902C.W,D3                      ; $00B14E
        MOVE.B  $C30E.W,D0                      ; $00B152
        ANDI.B  #$0021,D0                       ; $00B156
        BEQ.S  loc_00B15E                       ; $00B15A
        RTS                                     ; $00B15C
loc_00B15E:
        LSL.W  #4,D3                            ; $00B15E
        LEA     $00(A1,D3.W),A1                 ; $00B160
        MOVE.B  #$0002,-$0009(A1)               ; $00B164
        MOVEQ   #$00,D0                         ; $00B16A
        MOVE.B  (A2)+,D0                        ; $00B16C
        ADD.W  D0,D0                            ; $00B16E
        LEA     $00899884,A0                    ; $00B170
        MOVE.W  $00(A0,D0.W),D0                 ; $00B176
        BSR.S  loc_00B1AA                       ; $00B17A
        MOVEQ   #$00,D0                         ; $00B17C
        MOVE.B  (A2)+,D0                        ; $00B17E
        SUBI.B  #$00C4,D0                       ; $00B180
        ADD.W  D0,D0                            ; $00B184
        LEA     $00899884,A0                    ; $00B186
        MOVE.W  $00(A0,D0.W),D0                 ; $00B18C
        BSR.S  loc_00B1AA                       ; $00B190
        MOVEQ   #$00,D0                         ; $00B192
        MOVE.B  (A2)+,D0                        ; $00B194
        SUBI.B  #$00C4,D0                       ; $00B196
        ADD.W  D0,D0                            ; $00B19A
        LEA     $0089980C,A0                    ; $00B19C
        MOVE.B  $00(A0,D0.W),(A1)+              ; $00B1A2
        MOVE.B  $01(A0,D0.W),D0                 ; $00B1A6
loc_00B1AA:
        MOVE.B  D0,D1                           ; $00B1AA
        LSR.B  #4,D1                            ; $00B1AC
        MOVE.B  D1,(A1)+                        ; $00B1AE
        ANDI.B  #$000F,D0                       ; $00B1B0
        MOVE.B  D0,(A1)+                        ; $00B1B4
        RTS                                     ; $00B1B6
        MOVEQ   #$00,D0                         ; $00B1B8
        MOVE.W  $902C.W,D0                      ; $00B1BA
        CMPI.W  #$0005,D0                       ; $00B1BE
        BNE.S  loc_00B1C6                       ; $00B1C2
        SUBQ.W  #1,D0                           ; $00B1C4
loc_00B1C6:
        LEA     $C200.W,A1                      ; $00B1C6
        ADD.W  D0,D0                            ; $00B1CA
        ADD.W  D0,D0                            ; $00B1CC
        MOVE.W  D0,D3                           ; $00B1CE
        ADDA.L  D0,A1                           ; $00B1D0
        MOVEQ   #$00,D0                         ; $00B1D2
        MOVE.B  $C806.W,D0                      ; $00B1D4
        ADD.W  D0,D0                            ; $00B1D8
        LEA     $00899884,A3                    ; $00B1DA
        MOVE.W  $00(A3,D0.W),D0                 ; $00B1E0
        MOVE.B  D0,(A1)+                        ; $00B1E4
        MOVEQ   #$00,D0                         ; $00B1E6
        MOVE.B  $C807.W,D0                      ; $00B1E8
        SUBI.B  #$00C4,D0                       ; $00B1EC
        ADD.W  D0,D0                            ; $00B1F0
        LEA     $00899884,A3                    ; $00B1F2
        MOVE.W  $00(A3,D0.W),D0                 ; $00B1F8
        MOVE.B  D0,(A1)+                        ; $00B1FC
        MOVEQ   #$00,D0                         ; $00B1FE
        MOVE.B  $C808.W,D0                      ; $00B200
        SUBI.B  #$00C4,D0                       ; $00B204
        ADD.W  D0,D0                            ; $00B208
        LEA     $0089980C,A3                    ; $00B20A
        MOVE.W  $00(A3,D0.W),D0                 ; $00B210
        MOVE.W  D0,(A1)                         ; $00B214
        JSR     loc_00B2EC(PC)                  ; $00B216
        JSR     loc_00B422(PC)                  ; $00B21A
        MOVEQ   #$03,D3                         ; $00B21E
        JSR     loc_00B260(PC)                  ; $00B220
        CMPI.W  #$0005,$902C.W                  ; $00B224
        BNE.S  loc_00B25C                       ; $00B22A
        MOVE.L  $C210.W,D0                      ; $00B22C
        CMP.L  $C254.W,D0                       ; $00B230
        BGE.S  loc_00B25C                       ; $00B234
        MOVE.L  D0,$C254.W                      ; $00B236
        MOVEQ   #$00,D0                         ; $00B23A
        MOVE.B  $C307.W,D0                      ; $00B23C
        LEA     $00FF68D1,A1                    ; $00B240
        LEA     $00(A1,D0.W),A1                 ; $00B246
        MOVE.B  #$0000,(A1)                     ; $00B24A
        MOVE.B  #$0050,$C307.W                  ; $00B24E
        MOVE.B  #$0001,$00FF6911                ; $00B254
loc_00B25C:
        RTS                                     ; $00B25C
        MOVEQ   #$12,D3                         ; $00B25E
loc_00B260:
        LEA     $C200.W,A1                      ; $00B260
        MOVE.L  #$00010060,D7                   ; $00B264
        MOVEQ   #$00,D0                         ; $00B26A
        MOVE.B  (A1)+,D0                        ; $00B26C
        MOVE.B  (A1)+,D1                        ; $00B26E
        MOVE.B  (A1)+,D2                        ; $00B270
        MOVE.B  (A1)+,D6                        ; $00B272
loc_00B274:
        SWAP    D3                              ; $00B274
        MOVE.B  (A1)+,D3                        ; $00B276
        MOVE.B  (A1)+,D4                        ; $00B278
        MOVE.B  (A1)+,D5                        ; $00B27A
        SWAP    D5                              ; $00B27C
        MOVE.B  (A1)+,D5                        ; $00B27E
        ANDI.B  #$00EF,#$CD05                   ; $00B280
        SWAP    D5                              ; $00B286
        AND.B  D2,D5                            ; $00B288
        CMPI.B  #$0010,D2                       ; $00B28A
        BLT.S  loc_00B298                       ; $00B28E
        SUBI.B  #$0010,D2                       ; $00B290
        ORI.B  #$0010,#$C304                    ; $00B294
        BCC.S  loc_00B2A6                       ; $00B29A
        AND.B  D0,D3                            ; $00B29C
        BCS.S  loc_00B2C2                       ; $00B29E
        ADDI.B  #$0040,D1                       ; $00B2A0
        BRA.S  loc_00B2AA                       ; $00B2A4
loc_00B2A6:
        AND.B  D0,D3                            ; $00B2A6
        BCS.S  loc_00B2C2                       ; $00B2A8
loc_00B2AA:
        CMP.B  D7,D1                            ; $00B2AA
        BCS.S  loc_00B2B8                       ; $00B2AC
        OR.B   D1,D7                            ; $00B2AE
        SWAP    D7                              ; $00B2B0
        AND.B  D0,D7                            ; $00B2B2
        BCS.S  loc_00B2C2                       ; $00B2B4
        SWAP    D7                              ; $00B2B6
loc_00B2B8:
        SWAP    D3                              ; $00B2B8
        DBRA    D3,loc_00B274                   ; $00B2BA
        CMP.W  D7,D0                            ; $00B2BE
        BCS.S  loc_00B2CA                       ; $00B2C0
loc_00B2C2:
        MOVEQ   #$60,D0                         ; $00B2C2
        MOVEQ   #$00,D1                         ; $00B2C4
        MOVEQ   #$00,D2                         ; $00B2C6
        MOVEQ   #$00,D6                         ; $00B2C8
loc_00B2CA:
        LEA     $C260.W,A1                      ; $00B2CA
        MOVE.B  D0,(A1)+                        ; $00B2CE
        MOVE.B  D1,(A1)+                        ; $00B2D0
        MOVE.B  D2,(A1)+                        ; $00B2D2
        MOVE.B  D6,(A1)                         ; $00B2D4
        RTS                                     ; $00B2D6
        ORI.L  #$01100080,-(A0)                 ; $00B2D8
        ORI.L  #$00D00100,D0                    ; $00B2DE
        MOVE.W  $002C(A0),D3                    ; $00B2E4
        SUBQ.W  #1,D3                           ; $00B2E8
        LSL.W  #2,D3                            ; $00B2EA
loc_00B2EC:
        LEA     $C200.W,A1                      ; $00B2EC
        LEA     $00(A1,D3.W),A1                 ; $00B2F0
        CMPI.B  #$0060,(A1)                     ; $00B2F4
        BLT.S  loc_00B2FC                       ; $00B2F8
        RTS                                     ; $00B2FA
loc_00B2FC:
        MOVE.W  $C89E.W,D0                      ; $00B2FC
        MOVE.W  -$2A(PC,D0.W),D0                ; $00B300
loc_00B304:
        ADD.W  $00E2(A0),D0                     ; $00B304
        BMI.S  loc_00B36C                       ; $00B308
        MULS    #$0320,D0                       ; $00B30A
        MOVE.W  $0006(A0),D1                    ; $00B30E
        BEQ.S  loc_00B36C                       ; $00B312
        DIVS    D1,D0                           ; $00B314
        CMPI.W  #$0032,D0                       ; $00B316
        BLT.S  loc_00B31E                       ; $00B31A
        MOVEQ   #$32,D0                         ; $00B31C
loc_00B31E:
        ADD.W  D0,D0                            ; $00B31E
        LEA     $00899884,A3                    ; $00B320
        ANDI.B  #$00EF,#$3033                   ; $00B326
        ORI.B  #$1229,D0                        ; $00B32C
        ORI.B  #$8300,D3                        ; $00B330
        MOVE.B  D1,$0003(A1)                    ; $00B334
        MOVEQ   #$00,D2                         ; $00B338
        MOVE.B  $0002(A1),D1                    ; $00B33A
        OR.B   D1,D2                            ; $00B33E
        ANDI.B  #$000F,D1                       ; $00B340
        MOVE.B  D1,$0002(A1)                    ; $00B344
        MOVE.B  $0001(A1),D1                    ; $00B348
        OR.B   D1,D2                            ; $00B34C
        BCC.S  loc_00B358                       ; $00B34E
        SUBI.B  #$0040,D1                       ; $00B350
        ORI.B  #$0010,#$1341                    ; $00B354
        ORI.B  #$1211,D1                        ; $00B35A
        OR.B   D1,D2                            ; $00B35E
        CMPI.B  #$0059,D1                       ; $00B360
        BLE.S  loc_00B36A                       ; $00B364
        MOVE.B  #$0059,D1                       ; $00B366
loc_00B36A:
        MOVE.B  D1,(A1)                         ; $00B36A
loc_00B36C:
        RTS                                     ; $00B36C
        DC.W    $00D0                           ; $00B36E
        DC.W    $00C0                           ; $00B370
        ORI.L  #$009000A0,(A0)                  ; $00B372
        BTST    D0,D0                           ; $00B378
        ORI.L  #$008000E0,D0                    ; $00B37A
        DC.W    $00D0                           ; $00B380
        BTST    D0,D0                           ; $00B382
        BTST    D0,D0                           ; $00B384
        ADD.W  $C8A0.W,D0                       ; $00B386
        MOVE.W  -$1E(PC,D0.W),D0                ; $00B38A
        CMPI.B  #$0060,(A1)                     ; $00B38E
        BLT.W  loc_00B304                       ; $00B392
        RTS                                     ; $00B396
        ORI.L  #$00D000C0,-(A0)                 ; $00B398
        BTST    D0,(A0)                         ; $00B39E
        ORI.L  #$00900080,(A0)                  ; $00B3A0
        ORI.L  #$01000080,-(A0)                 ; $00B3A6
        ORI.L  #$008000D0,D0                    ; $00B3AC
        DC.W    $00E0                           ; $00B3B2
        DC.W    $00D0                           ; $00B3B4
        BTST    D0,D0                           ; $00B3B6
        BTST    D0,D0                           ; $00B3B8
        BTST    D0,D0                           ; $00B3BA
        ADD.W  $C8A0.W,D0                       ; $00B3BC
        MOVE.W  -$2A(PC,D0.W),D0                ; $00B3C0
        CMPI.B  #$0060,(A1)                     ; $00B3C4
        BLT.W  loc_00B304                       ; $00B3C8
        RTS                                     ; $00B3CC
        MOVEQ   #$00,D0                         ; $00B3CE
        MOVE.B  (A1)+,D0                        ; $00B3D0
        ADD.W  D0,D0                            ; $00B3D2
        LEA     $00899884,A3                    ; $00B3D4
        MOVE.W  $00(A3,D0.W),D0                 ; $00B3DA
        MOVE.B  D0,(A2)+                        ; $00B3DE
        MOVEQ   #$00,D0                         ; $00B3E0
        MOVE.B  (A1)+,D0                        ; $00B3E2
        SUBI.B  #$00C4,D0                       ; $00B3E4
        ADD.W  D0,D0                            ; $00B3E8
        LEA     $00899884,A3                    ; $00B3EA
        MOVE.W  $00(A3,D0.W),D0                 ; $00B3F0
        MOVE.B  D0,(A2)+                        ; $00B3F4
        MOVEQ   #$00,D0                         ; $00B3F6
        MOVE.B  (A1)+,D0                        ; $00B3F8
        SUBI.B  #$00C4,D0                       ; $00B3FA
        ADD.W  D0,D0                            ; $00B3FE
        LEA     $0089980C,A3                    ; $00B400
        MOVE.W  $00(A3,D0.W),D0                 ; $00B406
        MOVE.W  D0,(A2)+                        ; $00B40A
        RTS                                     ; $00B40C
        LEA     $00FF68D8,A3                    ; $00B40E
        BSR.S  loc_00B43C                       ; $00B414
        LEA     $00FF6958,A1                    ; $00B416
        MOVE.L  (A3)+,(A1)+                     ; $00B41C
        MOVE.L  (A3),(A1)                       ; $00B41E
        RTS                                     ; $00B420
loc_00B422:
        LSL.W  #2,D3                            ; $00B422
        LEA     $00FF68D8,A3                    ; $00B424
        LEA     $00(A3,D3.W),A3                 ; $00B42A
        BSR.S  loc_00B43C                       ; $00B42E
        LEA     $00FF6958,A1                    ; $00B430
        MOVE.L  (A3)+,(A1)+                     ; $00B436
        MOVE.L  (A3),(A1)                       ; $00B438
        RTS                                     ; $00B43A
loc_00B43C:
        MOVE.W  $0002(A1),D0                    ; $00B43C
        MOVE.B  D0,$0007(A3)                    ; $00B440
        LSR.W  #4,D0                            ; $00B444
        MOVE.B  D0,$0006(A3)                    ; $00B446
        LSR.W  #4,D0                            ; $00B44A
        MOVE.B  D0,$0005(A3)                    ; $00B44C
        MOVE.W  (A1),D0                         ; $00B450
        MOVE.B  D0,$0004(A3)                    ; $00B452
        LSR.W  #4,D0                            ; $00B456
        MOVE.B  D0,$0003(A3)                    ; $00B458
        LSR.W  #4,D0                            ; $00B45C
        MOVE.B  D0,$0002(A3)                    ; $00B45E
        LSR.W  #4,D0                            ; $00B462
        MOVE.B  D0,$0001(A3)                    ; $00B464
        ANDI.W  #$0F0F,$0002(A3)                ; $00B468
        ANDI.L  #$0F0F0F0F,$0004(A3)            ; $00B46E
        RTS                                     ; $00B476
        ANDI.B  #$00EF,#$122C                   ; $00B478
        ORI.B  #$102C,D3                        ; $00B47E
        ORI.B  #$8300,D7                        ; $00B482
        MOVE.B  D1,$0003(A4)                    ; $00B486
        MOVE.B  $0002(A4),D1                    ; $00B48A
        MOVE.B  $0006(A4),D0                    ; $00B48E
        OR.B   D1,D0                            ; $00B492
        ANDI.B  #$000F,D1                       ; $00B494
        MOVE.B  D1,$0002(A4)                    ; $00B498
        MOVE.B  $0001(A4),D1                    ; $00B49C
        MOVE.B  $0005(A4),D0                    ; $00B4A0
        OR.B   D1,D0                            ; $00B4A4
        BCC.S  loc_00B4B0                       ; $00B4A6
        SUBI.B  #$0040,D1                       ; $00B4A8
        ORI.B  #$0010,#$1941                    ; $00B4AC
        ORI.B  #$1214,D1                        ; $00B4B2
        MOVE.B  $0004(A4),D0                    ; $00B4B6
        OR.B   D1,D0                            ; $00B4BA
        CMPI.B  #$0059,D1                       ; $00B4BC
        BLE.S  loc_00B4C6                       ; $00B4C0
        MOVE.B  #$0059,D1                       ; $00B4C2
loc_00B4C6:
        MOVE.B  D1,(A4)                         ; $00B4C6
        RTS                                     ; $00B4C8
        MOVE.L  $C254.W,$EEFC.W                 ; $00B4CA
        LEA     $C200.W,A1                      ; $00B4D0
        LEA     $EEE0.W,A2                      ; $00B4D4
        JMP     $004920(PC)                     ; $00B4D8
        MOVE.W  $C050.W,D0                      ; $00B4DC
        BPL.S  loc_00B4E4                       ; $00B4E0
        MOVEQ   #$00,D0                         ; $00B4E2
loc_00B4E4:
        ADD.W  D0,D0                            ; $00B4E4
        LEA     $00899884,A0                    ; $00B4E6
        MOVE.W  $00(A0,D0.W),D0                 ; $00B4EC
        LEA     $00FF68BA,A1                    ; $00B4F0
        BRA.S  loc_00B54C                       ; $00B4F6
        LEA     $00FF6908,A1                    ; $00B4F8
        MOVE.W  $9F04.W,D0                      ; $00B4FE
        BRA.S  loc_00B50E                       ; $00B502
        LEA     $00FF68C8,A1                    ; $00B504
        MOVE.W  $9004.W,D0                      ; $00B50A
loc_00B50E:
        ADD.W  D0,D0                            ; $00B50E
        LEA     $00899884,A0                    ; $00B510
        MOVE.W  $00(A0,D0.W),D0                 ; $00B516
        MOVE.W  D0,D1                           ; $00B51A
        LSR.W  #8,D1                            ; $00B51C
        MOVE.W  D1,(A1)+                        ; $00B51E
        BRA.S  loc_00B54C                       ; $00B520
        MOVEQ   #$00,D0                         ; $00B522
        MOVE.B  $C30C.W,D0                      ; $00B524
        ADD.W  D0,D0                            ; $00B528
        MOVE.W  D0,D1                           ; $00B52A
        ADD.W  D0,D0                            ; $00B52C
        LEA     $00898C24,A0                    ; $00B52E
        MOVE.L  $00(A0,D0.W),$00FF68A8          ; $00B534
        LEA     $00899884,A0                    ; $00B53C
        MOVE.W  $00(A0,D1.W),D0                 ; $00B542
        LEA     $00FF689A,A1                    ; $00B546
loc_00B54C:
        MOVE.B  D0,D1                           ; $00B54C
        LSR.B  #4,D1                            ; $00B54E
        MOVE.B  D1,(A1)+                        ; $00B550
        ANDI.B  #$000F,D0                       ; $00B552
        MOVE.B  D0,(A1)                         ; $00B556
        RTS                                     ; $00B558
        TST.B  $C819.W                          ; $00B55A
        BNE.S  loc_00B58E                       ; $00B55E
        LEA     $00FF69E0,A1                    ; $00B560
        MOVE.L  #$04027AFC,D0                   ; $00B566
        MOVE.W  $902A.W,D1                      ; $00B56C
        CMP.W  $9F2A.W,D1                       ; $00B570
        BLE.S  loc_00B57C                       ; $00B574
        MOVE.L  #$040382FC,D0                   ; $00B576
loc_00B57C:
        MOVE.L  D0,$0004(A1)                    ; $00B57C
        MOVEQ   #$01,D0                         ; $00B580
        BTST    #4,$C967.W                      ; $00B582
        BNE.S  loc_00B58C                       ; $00B588
        MOVEQ   #$00,D0                         ; $00B58A
loc_00B58C:
        MOVE.B  D0,(A1)                         ; $00B58C
loc_00B58E:
        RTS                                     ; $00B58E
        TST.B  $C819.W                          ; $00B590
        BEQ.S  loc_00B598                       ; $00B594
        RTS                                     ; $00B596
loc_00B598:
        LEA     $00FF69CA,A1                    ; $00B598
        MOVE.W  $9F2C.W,D0                      ; $00B59E
        BSR.S  loc_00B5B8                       ; $00B5A2
        BTST    #5,$C30E.W                      ; $00B5A4
        BEQ.S  loc_00B5AE                       ; $00B5AA
        RTS                                     ; $00B5AC
loc_00B5AE:
        LEA     $00FF689A,A1                    ; $00B5AE
        MOVE.W  $902C.W,D0                      ; $00B5B4
loc_00B5B8:
        ADDQ.W  #1,D0                           ; $00B5B8
        ADD.W  D0,D0                            ; $00B5BA
        LEA     $00899884,A0                    ; $00B5BC
        MOVE.W  $00(A0,D0.W),D0                 ; $00B5C2
        JMP     loc_00B54C(PC)                  ; $00B5C6
        MOVE.W  $902C.W,D0                      ; $00B5CA
        CMPI.W  #$0004,D0                       ; $00B5CE
        BLE.S  loc_00B5D8                       ; $00B5D2
        MOVE.W  #$0004,D0                       ; $00B5D4
loc_00B5D8:
        LSL.W  #4,D0                            ; $00B5D8
        TST.B  $C305.W                          ; $00B5DA
        BEQ.S  loc_00B604                       ; $00B5DE
        SUBI.W  #$0010,D0                       ; $00B5E0
        LEA     $00FF68D0,A1                    ; $00B5E4
        LEA     $00(A1,D0.W),A1                 ; $00B5EA
        MOVE.W  #$0201,(A1)                     ; $00B5EE
        CMPA.L  $C960.W,A1                      ; $00B5F2
        BEQ.S  loc_00B5FC                       ; $00B5F6
        MOVE.W  #$0200,(A1)                     ; $00B5F8
loc_00B5FC:
        MOVE.B  #$0000,$C305.W                  ; $00B5FC
        RTS                                     ; $00B602
loc_00B604:
        LEA     $00FF68D0,A1                    ; $00B604
        LEA     $00(A1,D0.W),A1                 ; $00B60A
        MOVE.B  #$0000,(A1)                     ; $00B60E
        BTST    #4,$C967.W                      ; $00B612
        BNE.S  loc_00B61E                       ; $00B618
        MOVE.B  #$0002,(A1)                     ; $00B61A
loc_00B61E:
        MOVEQ   #$09,D0                         ; $00B61E
        BTST    #5,$C967.W                      ; $00B620
        BNE.S  loc_00B62A                       ; $00B626
        MOVEQ   #$00,D0                         ; $00B628
loc_00B62A:
        MOVE.B  D0,$00FF68B0                    ; $00B62A
        RTS                                     ; $00B630
        TST.B  $C30F.W                          ; $00B632
        BEQ.S  loc_00B644                       ; $00B636
        MOVE.W  $907A.W,D0                      ; $00B638
        ADDQ.W  #1,D0                           ; $00B63C
        MOVE.B  D0,$00FF692B                    ; $00B63E
loc_00B644:
        RTS                                     ; $00B644
        TST.B  $FEB0.W                          ; $00B646
        BEQ.S  loc_00B658                       ; $00B64A
        MOVE.W  $9F7A.W,D0                      ; $00B64C
        ADDQ.W  #1,D0                           ; $00B650
        MOVE.B  D0,$00FF691B                    ; $00B652
loc_00B658:
        RTS                                     ; $00B658
        MOVE.B  #$0001,$C802.W                  ; $00B65A
        LEA     $8480.W,A2                      ; $00B660
        JSR     loc_00B670(PC)                  ; $00B664
        JSR     loc_00B670(PC)                  ; $00B668
        JSR     loc_00B670(PC)                  ; $00B66C
loc_00B670:
        LEA     $008BA000,A1                    ; $00B670
        MOVEQ   #$00,D1                         ; $00B676
        MOVE.B  D0,D1                           ; $00B678
        ROR.L  #8,D0                            ; $00B67A
        LSL.W  #5,D1                            ; $00B67C
        ADDA.W  D1,A1                           ; $00B67E
        JMP     $00491A(PC)                     ; $00B680
        BTST    #6,$C80E.W                      ; $00B684
        BEQ.S  loc_00B6CE                       ; $00B68A
        SUBQ.B  #1,$C80A.W                      ; $00B68C
        BNE.S  loc_00B6CE                       ; $00B690
        MOVE.B  $C809.W,$C80A.W                 ; $00B692
        MOVEQ   #$00,D0                         ; $00B698
        MOVE.B  $C825.W,D0                      ; $00B69A
        BNE.S  loc_00B6AC                       ; $00B69E
        MOVEA.L $C96C.W,A1                      ; $00B6A0
        LEA     $8480.W,A2                      ; $00B6A4
        JSR     $0048EA(PC)                     ; $00B6A8
loc_00B6AC:
        MOVE.B  $22(PC,D0.W),D1                 ; $00B6AC
        MOVE.B  D1,$00FF60D5                    ; $00B6B0
        ADDQ.B  #1,D0                           ; $00B6B6
        MOVE.B  D0,$C825.W                      ; $00B6B8
        CMPI.B  #$000A,D0                       ; $00B6BC
        BNE.S  loc_00B6CE                       ; $00B6C0
        MOVE.B  #$0000,$C825.W                  ; $00B6C2
        BCLR    #6,$C80E.W                      ; $00B6C8
loc_00B6CE:
        RTS                                     ; $00B6CE
        DC.W    $FFFE                           ; $00B6D0
        DC.W    $FDFC                           ; $00B6D2
        DC.W    $FBFA                           ; $00B6D4
        DC.W    $F9F8                           ; $00B6D6
        MOVE.W  D0,(A4)                         ; $00B6D8
        BTST    #7,$C80E.W                      ; $00B6DA
        BEQ.S  loc_00B720                       ; $00B6E0
        SUBQ.B  #1,$C80A.W                      ; $00B6E2
        BNE.S  loc_00B720                       ; $00B6E6
        MOVE.B  $C809.W,$C80A.W                 ; $00B6E8
        MOVEQ   #$00,D0                         ; $00B6EE
        MOVE.B  $C825.W,D0                      ; $00B6F0
        MOVE.B  $2C(PC,D0.W),D1                 ; $00B6F4
        MOVE.B  D1,$00FF60D5                    ; $00B6F8
        ADDQ.B  #1,D0                           ; $00B6FE
        MOVE.B  D0,$C825.W                      ; $00B700
        CMPI.B  #$000A,D0                       ; $00B704
        BNE.S  loc_00B720                       ; $00B708
        MOVEQ   #$00,D1                         ; $00B70A
        LEA     $8480.W,A1                      ; $00B70C
        JSR     $004846(PC)                     ; $00B710
        MOVE.B  #$0000,$C825.W                  ; $00B714
        BCLR    #7,$C80E.W                      ; $00B71A
loc_00B720:
        RTS                                     ; $00B720
        BTST    D0,D2                           ; $00B722
        BTST    D1,D4                           ; $00B724
        BTST    D2,D6                           ; $00B726
        BTST    D3,A0                           ; $00B728
        BTST    #0,D0                           ; $00B72A
        MOVEQ   #$00,D1                         ; $00B72E
        MOVEQ   #$00,D2                         ; $00B730
        LEA     $8480.W,A0                      ; $00B732
loc_00B736:
        SUBQ.B  #1,$01(A1,D0.W)                 ; $00B736
        BNE.S  loc_00B768                       ; $00B73A
        MOVEA.L A2,A3                           ; $00B73C
        ADDA.W  $00(A2,D0.W),A3                 ; $00B73E
        MOVE.B  $00(A1,D0.W),D2                 ; $00B742
        ADD.W  D2,D2                            ; $00B746
        MOVE.B  (A3),D1                         ; $00B748
        MOVE.B  $0001(A3),$01(A1,D0.W)          ; $00B74A
        MOVE.W  $00(A3,D2.W),D3                 ; $00B750
        BPL.S  loc_00B760                       ; $00B754
        MOVE.B  #$0001,$00(A1,D0.W)             ; $00B756
        MOVE.W  $0002(A3),D3                    ; $00B75C
loc_00B760:
        MOVE.W  D3,$00(A0,D1.W)                 ; $00B760
        ADDQ.B  #1,$00(A1,D0.W)                 ; $00B764
loc_00B768:
        ADDQ.B  #2,D0                           ; $00B768
        DBRA    D7,loc_00B736                   ; $00B76A
        RTS                                     ; $00B76E
        LEA     $00FF6344,A2                    ; $00B770
        CMPA.W  #$9000,A0                       ; $00B776
        BNE.S  loc_00B782                       ; $00B77A
        LEA     $00FF6114,A2                    ; $00B77C
loc_00B782:
        MOVE.W  $C048.W,D0                      ; $00B782
        ADD.W  D0,D0                            ; $00B786
        LEA     $C0A2.W,A1                      ; $00B788
        ADDQ.W  #1,$00(A1,D0.W)                 ; $00B78C
        TST.B  $C064.W                          ; $00B790
        BNE.S  loc_00B7EE                       ; $00B794
        MOVE.W  $C048.W,D0                      ; $00B796
        ADD.W  D0,D0                            ; $00B79A
        ADD.W  D0,D0                            ; $00B79C
        CMP.B  $C302.W,D0                       ; $00B79E
        BNE.S  loc_00B7FA                       ; $00B7A2
        MOVE.W  $C972.W,D0                      ; $00B7A4
        TST.B  $C314.W                          ; $00B7A8
        BEQ.S  loc_00B7E6                       ; $00B7AC
        BTST    #10,D0                          ; $00B7AE
        BEQ.S  loc_00B7BC                       ; $00B7B2
        MOVE.W  #$0001,$C048.W                  ; $00B7B4
        BRA.S  loc_00B7E4                       ; $00B7BA
loc_00B7BC:
        BTST    #9,D0                           ; $00B7BC
        BEQ.S  loc_00B7CA                       ; $00B7C0
        MOVE.W  #$0002,$C048.W                  ; $00B7C2
        BRA.S  loc_00B7E4                       ; $00B7C8
loc_00B7CA:
        BTST    #8,D0                           ; $00B7CA
        BEQ.S  loc_00B7D8                       ; $00B7CE
        MOVE.W  #$0003,$C048.W                  ; $00B7D0
        BRA.S  loc_00B7E4                       ; $00B7D6
loc_00B7D8:
        BTST    #5,D0                           ; $00B7D8
        BEQ.S  loc_00B7E4                       ; $00B7DC
        MOVE.W  #$0000,$C048.W                  ; $00B7DE
loc_00B7E4:
        RTS                                     ; $00B7E4
loc_00B7E6:
        BTST    #10,D0                          ; $00B7E6
        BNE.S  loc_00B802                       ; $00B7EA
        RTS                                     ; $00B7EC
loc_00B7EE:
        MOVEQ   #$00,D0                         ; $00B7EE
        MOVE.B  $C065.W,D0                      ; $00B7F0
        MOVEA.L $6E(PC,D0.W),A1                 ; $00B7F4
        JMP     (A1)                            ; $00B7F8
loc_00B7FA:
        MOVEQ   #$00,D2                         ; $00B7FA
        MOVE.B  $C302.W,D2                      ; $00B7FC
        BRA.S  loc_00B844                       ; $00B800
loc_00B802:
        MOVEQ   #$00,D0                         ; $00B802
        MOVE.B  $C302.W,D0                      ; $00B804
        MOVE.W  D0,D2                           ; $00B808
        TST.B  $C311.W                          ; $00B80A
        BEQ.S  loc_00B82A                       ; $00B80E
        SUBQ.W  #4,D0                           ; $00B810
        SUBQ.W  #1,$C048.W                      ; $00B812
        TST.W  D0                               ; $00B816
        BGE.S  loc_00B844                       ; $00B818
        MOVE.B  #$0000,$C311.W                  ; $00B81A
        MOVE.W  #$0001,$C048.W                  ; $00B820
        MOVEQ   #$04,D0                         ; $00B826
        BRA.S  loc_00B844                       ; $00B828
loc_00B82A:
        ADDQ.W  #4,D0                           ; $00B82A
        ADDQ.W  #1,$C048.W                      ; $00B82C
        CMPI.W  #$0010,D0                       ; $00B830
        BLT.S  loc_00B844                       ; $00B834
        MOVE.B  #$0001,$C311.W                  ; $00B836
        MOVE.W  #$0002,$C048.W                  ; $00B83C
        MOVEQ   #$08,D0                         ; $00B842
loc_00B844:
        MOVE.B  D0,$C302.W                      ; $00B844
        ADD.W  D2,D2                            ; $00B848
        ADD.W  D2,D2                            ; $00B84A
        ADD.W  D2,D0                            ; $00B84C
        MOVE.B  #$0001,$C064.W                  ; $00B84E
        MOVE.B  D0,$C065.W                      ; $00B854
        MOVE.B  #$0014,$C303.W                  ; $00B858
        MOVEA.L $04(PC,D0.W),A1                 ; $00B85E
        JMP     (A1)                            ; $00B862
        DC.W    $0088                           ; $00B864
        CMP.L  -(A4),D4                         ; $00B866
        DC.W    $0088                           ; $00B868
        EOR.W  D4,-(A4)                         ; $00B86A
        DC.W    $0088                           ; $00B86C
        EOR.W  D4,-(A4)                         ; $00B86E
        DC.W    $0088                           ; $00B870
        EOR.W  D4,$0088(PC)                     ; $00B872
        CMP.L  -(A4),D4                         ; $00B876
        DC.W    $0088                           ; $00B878
        CMP.L  -(A4),D4                         ; $00B87A
        DC.W    $0088                           ; $00B87C
        EOR.W  D4,-(A4)                         ; $00B87E
        DC.W    $0088                           ; $00B880
        EOR.W  D4,$0088(PC)                     ; $00B882
        CMP.L  -(A4),D4                         ; $00B886
        DC.W    $0088                           ; $00B888
        EOR.W  D4,-(A4)                         ; $00B88A
        DC.W    $0088                           ; $00B88C
        CMP.L  -(A4),D4                         ; $00B88E
        DC.W    $0088                           ; $00B890
        EOR.W  D4,$0088(PC)                     ; $00B892
        CMP.L  -(A4),D4                         ; $00B896
        DC.W    $0088                           ; $00B898
        EOR.W  D4,-(A4)                         ; $00B89A
        DC.W    $0088                           ; $00B89C
        EOR.W  D4,-(A4)                         ; $00B89E
        DC.W    $0088                           ; $00B8A0
        CMP.L  -(A4),D4                         ; $00B8A2
        MOVEA.L $C744.W,A1                      ; $00B8A4
        ADD.W  $C8BC.W,D0                       ; $00B8A8
        MOVEA.L $00(A1,D0.W),A1                 ; $00B8AC
        MOVEQ   #$00,D0                         ; $00B8B0
        MOVE.B  $C303.W,D0                      ; $00B8B2
        ADD.W  D0,D0                            ; $00B8B6
        ADD.W  D0,D0                            ; $00B8B8
        MOVE.L  $00(A1,D0.W),D0                 ; $00B8BA
        MOVE.W  D0,$C056.W                      ; $00B8BE
        SWAP    D0                              ; $00B8C2
        MOVE.W  D0,$C054.W                      ; $00B8C4
        MOVE.B  #$0000,$C31C.W                  ; $00B8C8
        SUBQ.B  #1,$C303.W                      ; $00B8CE
        BNE.W  loc_00B962                       ; $00B8D2
        MOVE.B  #$0000,$C064.W                  ; $00B8D6
        MOVE.L  $C750.W,$0010(A2)               ; $00B8DC
        TST.W  $008A(A0)                        ; $00B8E2
        BNE.S  loc_00B8EE                       ; $00B8E6
        MOVE.L  $C724.W,$0010(A2)               ; $00B8E8
loc_00B8EE:
        MOVEQ   #$00,D2                         ; $00B8EE
        MOVE.L  $C728.W,D1                      ; $00B8F0
        BEQ.S  loc_00B902                       ; $00B8F4
        MOVE.L  D1,$0024(A2)                    ; $00B8F6
        MOVE.L  $C72C.W,$0038(A2)               ; $00B8FA
        MOVEQ   #$01,D2                         ; $00B900
loc_00B902:
        MOVE.W  D2,$0014(A2)                    ; $00B902
        MOVE.W  D2,$0028(A2)                    ; $00B906
        MOVE.W  #$0001,$C04C.W                  ; $00B90A
        MOVE.W  #$0002,$0000(A2)                ; $00B910
        MOVEA.L $C738.W,A1                      ; $00B916
        MOVE.W  (A1)+,$0016(A2)                 ; $00B91A
        MOVE.W  (A1)+,$0018(A2)                 ; $00B91E
        MOVE.W  (A1)+,$001A(A2)                 ; $00B922
        MOVE.W  (A1)+,$002A(A2)                 ; $00B926
        MOVE.W  (A1)+,$002C(A2)                 ; $00B92A
        MOVE.W  (A1),$002E(A2)                  ; $00B92E
        MOVE.W  #$0000,$003C(A2)                ; $00B932
        MOVE.W  #$0000,$0050(A2)                ; $00B938
        MOVEA.L $C740.W,A1                      ; $00B93E
        CMPA.L  #$00000000,A1                   ; $00B942
        BEQ.S  loc_00B962                       ; $00B948
        MOVE.W  (A1)+,$0052(A2)                 ; $00B94A
        MOVE.W  (A1)+,$0054(A2)                 ; $00B94E
        MOVE.W  (A1),$0056(A2)                  ; $00B952
        MOVE.W  #$0001,$0050(A2)                ; $00B956
        MOVE.L  $C730.W,$0060(A2)               ; $00B95C
loc_00B962:
        RTS                                     ; $00B962
        BSR.S  loc_00B990                       ; $00B964
        MOVE.B  #$0000,$C31C.W                  ; $00B966
        SUBQ.B  #1,$C303.W                      ; $00B96C
        BNE.S  loc_00B978                       ; $00B970
        MOVE.B  #$0000,$C064.W                  ; $00B972
loc_00B978:
        RTS                                     ; $00B978
        BSR.S  loc_00B990                       ; $00B97A
        SUBQ.B  #1,$C303.W                      ; $00B97C
        BNE.S  loc_00B98E                       ; $00B980
        MOVE.B  #$0000,$C064.W                  ; $00B982
        MOVE.B  #$0001,$C31C.W                  ; $00B988
loc_00B98E:
        RTS                                     ; $00B98E
loc_00B990:
        MOVEA.L $C744.W,A1                      ; $00B990
        ADD.W  $C8BC.W,D0                       ; $00B994
        MOVEA.L $00(A1,D0.W),A1                 ; $00B998
        MOVEQ   #$00,D0                         ; $00B99C
        MOVE.B  $C303.W,D0                      ; $00B99E
        ADD.W  D0,D0                            ; $00B9A2
        ADD.W  D0,D0                            ; $00B9A4
        MOVE.L  $00(A1,D0.W),D0                 ; $00B9A6
        MOVE.W  D0,$C056.W                      ; $00B9AA
        SWAP    D0                              ; $00B9AE
        MOVE.W  D0,$C054.W                      ; $00B9B0
        MOVE.L  $C710.W,$0010(A2)               ; $00B9B4
        MOVE.L  $C714.W,$0024(A2)               ; $00B9BA
        MOVE.L  $C718.W,$0038(A2)               ; $00B9C0
        MOVE.L  $C71C.W,$004C(A2)               ; $00B9C6
        MOVE.L  $C720.W,$0060(A2)               ; $00B9CC
        MOVEA.L $C734.W,A1                      ; $00B9D2
        MOVE.W  (A1)+,$0016(A2)                 ; $00B9D6
        MOVE.W  (A1)+,$0018(A2)                 ; $00B9DA
        MOVE.W  (A1)+,$001A(A2)                 ; $00B9DE
        MOVE.W  (A1)+,$002A(A2)                 ; $00B9E2
        MOVE.W  (A1)+,$002C(A2)                 ; $00B9E6
        MOVE.W  (A1)+,$002E(A2)                 ; $00B9EA
        MOVE.W  (A1)+,$003E(A2)                 ; $00B9EE
        MOVE.W  (A1)+,$0040(A2)                 ; $00B9F2
        MOVE.W  (A1),$0042(A2)                  ; $00B9F6
        MOVE.W  #$0000,$C04C.W                  ; $00B9FA
        MOVEQ   #$01,D0                         ; $00BA00
        MOVE.W  D0,$0000(A2)                    ; $00BA02
        MOVE.W  D0,$0014(A2)                    ; $00BA06
        MOVE.W  D0,$0028(A2)                    ; $00BA0A
        MOVE.W  D0,$0050(A2)                    ; $00BA0E
        MOVE.W  D0,$003C(A2)                    ; $00BA12
        RTS                                     ; $00BA16
        RTS                                     ; $00BA18
        MOVEQ   #$00,D0                         ; $00BA1A
        MOVE.B  $C86C.W,D0                      ; $00BA1C
        ADD.W  D0,D0                            ; $00BA20
        ADD.W  D0,D0                            ; $00BA22
        LEA     $00894888,A1                    ; $00BA24
        MOVEA.L $00(A1,D0.W),A1                 ; $00BA2A
        JSR     (A1)                            ; $00BA2E
        MOVEQ   #$00,D0                         ; $00BA30
        MOVE.B  $C86D.W,D0                      ; $00BA32
        ADD.W  D0,D0                            ; $00BA36
        ADD.W  D0,D0                            ; $00BA38
        LEA     $00894C88,A1                    ; $00BA3A
        MOVEA.L $00(A1,D0.W),A1                 ; $00BA40
        JSR     (A1)                            ; $00BA44
        MOVEQ   #$00,D0                         ; $00BA46
        MOVE.B  $C86E.W,D0                      ; $00BA48
        ADD.W  D0,D0                            ; $00BA4C
        ADD.W  D0,D0                            ; $00BA4E
        LEA     $00895088,A1                    ; $00BA50
        MOVEA.L $00(A1,D0.W),A1                 ; $00BA56
        JSR     (A1)                            ; $00BA5A
        RTS                                     ; $00BA5C
        MOVE.W  #$0000,$C0CE.W                  ; $00BA5E
        MOVE.W  #$0020,$C07A.W                  ; $00BA64
        MOVE.B  #$0000,$C308.W                  ; $00BA6A
        MOVE.W  #$0000,$C082.W                  ; $00BA70
        MOVE.W  #$0001,$C048.W                  ; $00BA76
        MOVE.B  #$0004,$C302.W                  ; $00BA7C
        CLR.W  $A0E8.W                          ; $00BA82
        CLR.W  $A0EC.W                          ; $00BA86
        CLR.W  $A0EA.W                          ; $00BA8A
        CLR.W  $A0EE.W                          ; $00BA8E
        CLR.W  $A0F0.W                          ; $00BA92
        CLR.W  $A0F4.W                          ; $00BA96
        CLR.W  $A0F6.W                          ; $00BA9A
        LEA     $9000.W,A0                      ; $00BA9E
        MOVE.W  #$0001,$002A(A0)                ; $00BAA2
        MOVE.W  #$0100,$0076(A0)                ; $00BAA8
        MOVE.W  #$0100,$0078(A0)                ; $00BAAE
        CLR.B  $C30F.W                          ; $00BAB4
        MOVE.W  #$0010,$A0E6.W                  ; $00BAB8
        LEA     $00897000,A0                    ; $00BABE
        MOVE.W  $C8A0.W,D0                      ; $00BAC4
        MOVEA.L $00(A0,D0.W),A0                 ; $00BAC8
        LEA     $0010(A0),A0                    ; $00BACC
        JMP     loc_00BCDA(PC)                  ; $00BAD0
        BTST    #6,$C80E.W                      ; $00BAD4
        BNE.W  loc_00BC1A                       ; $00BADA
        TST.W  $C080.W                          ; $00BADE
        BNE.W  loc_00BB88                       ; $00BAE2
        CMPI.B  #$000D,$C810.W                  ; $00BAE6
        BNE.S  loc_00BB0E                       ; $00BAEC
        MOVE.B  $C86F.W,D0                      ; $00BAEE
        MOVE.B  #$0001,$C81B.W                  ; $00BAF2
        BTST    #7,D0                           ; $00BAF8
        BNE.S  loc_00BB3C                       ; $00BAFC
        MOVE.B  #$0000,$C81B.W                  ; $00BAFE
        MOVE.B  $C86D.W,D0                      ; $00BB04
        BTST    #7,D0                           ; $00BB08
        BNE.S  loc_00BB3C                       ; $00BB0C
loc_00BB0E:
        TST.B  $C308.W                          ; $00BB0E
        BEQ.W  loc_00BC1A                       ; $00BB12
        MOVE.B  #$00F0,$C822.W                  ; $00BB16
        MOVE.B  #$0001,$C809.W                  ; $00BB1C
        MOVE.B  #$0002,$C80A.W                  ; $00BB22
        BSET    #7,$C80E.W                      ; $00BB28
        MOVE.B  #$0001,$C802.W                  ; $00BB2E
        MOVE.W  #$0001,$C080.W                  ; $00BB34
        BRA.S  loc_00BB88                       ; $00BB3A
loc_00BB3C:
        OR.B   $C86C.W,D0                       ; $00BB3C
        MOVE.B  #$0001,$C809.W                  ; $00BB40
        MOVE.B  #$004B,$C80A.W                  ; $00BB46
        BSET    #7,$C80E.W                      ; $00BB4C
        MOVE.B  #$0001,$C802.W                  ; $00BB52
        MOVE.W  #$0002,$C080.W                  ; $00BB58
        MOVE.W  #$0038,$A0EA.W                  ; $00BB5E
        TST.W  $A0F0.W                          ; $00BB64
        BNE.S  loc_00BB7C                       ; $00BB68
        MOVE.W  #$0001,$A0F0.W                  ; $00BB6A
        MOVE.B  #$009D,$850A.W                  ; $00BB70
        MOVE.B  #$00F0,$C822.W                  ; $00BB76
loc_00BB7C:
        TST.W  $A0F4.W                          ; $00BB7C
        BNE.S  loc_00BB88                       ; $00BB80
        MOVE.W  #$003C,$A0F4.W                  ; $00BB82
loc_00BB88:
        TST.W  $A0F4.W                          ; $00BB88
        BEQ.S  loc_00BB96                       ; $00BB8C
        SUBQ.W  #1,$A0F4.W                      ; $00BB8E
        BGT.W  loc_00BC1A                       ; $00BB92
loc_00BB96:
        BTST    #7,$C80E.W                      ; $00BB96
        BNE.W  loc_00BC1A                       ; $00BB9C
        MOVEQ   #$00,D0                         ; $00BBA0
        MOVE.W  D0,$C880.W                      ; $00BBA2
        MOVE.W  D0,$C882.W                      ; $00BBA6
        MOVE.W  #$0000,$C8A8.W                  ; $00BBAA
        MOVE.W  #$0020,$00FF0008                ; $00BBB0
        MOVE.L  #$008926D2,$00FF0002            ; $00BBB8
        LEA     $00897000,A0                    ; $00BBC2
        MOVE.W  $C8A0.W,D0                      ; $00BBC8
        MOVEA.L $00(A0,D0.W),A0                 ; $00BBCC
        MOVE.W  $C082.W,D0                      ; $00BBD0
        ASL.W  #4,D0                            ; $00BBD4
        LEA     $00(A0,D0.W),A0                 ; $00BBD6
        CMPI.W  #$0002,$C080.W                  ; $00BBDA
        BEQ.S  loc_00BC14                       ; $00BBE0
        CMPI.B  #$0010,$0000(A0)                ; $00BBE2
        BNE.S  loc_00BC1A                       ; $00BBE8
        MOVE.L  #$00894262,$00FF0002            ; $00BBEA
        ADDQ.B  #1,$FEB6.W                      ; $00BBF4
        CMPI.B  #$0004,$FEB6.W                  ; $00BBF8
        BLE.S  loc_00BC14                       ; $00BBFE
        CLR.B  $FEB6.W                          ; $00BC00
        ADDQ.B  #1,$FEB5.W                      ; $00BC04
        CMPI.B  #$0002,$FEB5.W                  ; $00BC08
        BLE.S  loc_00BC14                       ; $00BC0E
        CLR.B  $FEB5.W                          ; $00BC10
loc_00BC14:
        JMP     $00882890                       ; $00BC14
loc_00BC1A:
        RTS                                     ; $00BC1A
        BRA.W  loc_00BCCA                       ; $00BC1C
        BRA.W  loc_00BD2A                       ; $00BC20
        BRA.W  loc_00BD2A                       ; $00BC24
        BRA.W  loc_00BD00                       ; $00BC28
        BRA.W  loc_00BD9E                       ; $00BC2C
        DC.W    $0088                           ; $00BC30
        EOR.L  D6,-(A6)                         ; $00BC32
        DC.W    $0088                           ; $00BC34
        EOR.L  D6,$0088(A0)                     ; $00BC36
        CMPA.L  A0,A6                           ; $00BC3A
        DC.W    $0088                           ; $00BC3C
        EOR.L  D6,-(A6)                         ; $00BC3E
        LEA     $00FF60C8,A1                    ; $00BC40
        MOVE.W  #$0010,(A1)                     ; $00BC46
        MOVE.W  #$00CF,$0002(A1)                ; $00BC4A
        MOVE.B  #$0000,$00FF6850                ; $00BC50
        JSR     loc_00BE68(PC)                  ; $00BC58
        JSR     $00A050(PC)                     ; $00BC5C
        JSR     loc_00BDD6(PC)                  ; $00BC60
        LEA     $00897000,A0                    ; $00BC64
        MOVE.W  $C8A0.W,D0                      ; $00BC6A
        MOVEA.L $00(A0,D0.W),A0                 ; $00BC6E
        MOVE.W  $C082.W,D0                      ; $00BC72
        ASL.W  #4,D0                            ; $00BC76
        LEA     $00(A0,D0.W),A0                 ; $00BC78
        MOVEQ   #$00,D0                         ; $00BC7C
        MOVE.B  $0000(A0),D0                    ; $00BC7E
        JSR     -$68(PC,D0.W)                   ; $00BC82
        LEA     $00FF6830,A1                    ; $00BC86
        MOVEQ   #$00,D0                         ; $00BC8C
        ADDQ.W  #1,$A0E8.W                      ; $00BC8E
        BTST    #3,$A0E9.W                      ; $00BC92
        BEQ.S  loc_00BC9C                       ; $00BC98
        MOVEQ   #$01,D0                         ; $00BC9A
loc_00BC9C:
        MOVE.B  D0,(A1)                         ; $00BC9C
        MOVE.W  $000E(A0),D0                    ; $00BC9E
        ADD.W  D0,D0                            ; $00BCA2
        ADD.W  D0,D0                            ; $00BCA4
        MOVEA.L -$78(PC,D0.W),A1                ; $00BCA6
        JSR     (A1)                            ; $00BCAA
        SUBQ.W  #1,$C084.W                      ; $00BCAC
        BPL.S  loc_00BCC8                       ; $00BCB0
        ADDQ.W  #1,$C082.W                      ; $00BCB2
        CLR.W  $C8AA.W                          ; $00BCB6
        LEA     $0010(A0),A0                    ; $00BCBA
        MOVEQ   #$00,D0                         ; $00BCBE
        MOVE.B  $0001(A0),D0                    ; $00BCC0
        MOVE.W  D0,$C084.W                      ; $00BCC4
loc_00BCC8:
        RTS                                     ; $00BCC8
loc_00BCCA:
        CLR.W  $C8AA.W                          ; $00BCCA
        CLR.W  $C084.W                          ; $00BCCE
        MOVE.W  #$001C,$C07A.W                  ; $00BCD2
        RTS                                     ; $00BCD8
loc_00BCDA:
        CLR.W  $C8AA.W                          ; $00BCDA
        CLR.W  $C084.W                          ; $00BCDE
        LEA     $0002(A0),A1                    ; $00BCE2
        MOVE.W  (A1)+,$C086.W                   ; $00BCE6
        MOVE.W  (A1)+,$C054.W                   ; $00BCEA
        MOVE.W  (A1)+,$C056.W                   ; $00BCEE
        MOVE.W  (A1)+,$C0AE.W                   ; $00BCF2
        MOVE.W  (A1)+,$C0B0.W                   ; $00BCF6
        MOVE.W  (A1)+,$C0B2.W                   ; $00BCFA
        RTS                                     ; $00BCFE
loc_00BD00:
        LEA     $0002(A0),A1                    ; $00BD00
loc_00BD04:
        LEA     -$0010(A1),A1                   ; $00BD04
        CMPI.B  #$000C,-$0002(A1)               ; $00BD08
        BEQ.S  loc_00BD04                       ; $00BD0E
        MOVE.W  (A1)+,$C086.W                   ; $00BD10
        MOVE.W  (A1)+,$C054.W                   ; $00BD14
        MOVE.W  (A1)+,$C056.W                   ; $00BD18
        MOVE.W  (A1)+,$C0AE.W                   ; $00BD1C
        MOVE.W  (A1)+,$C0B0.W                   ; $00BD20
        MOVE.W  (A1)+,$C0B2.W                   ; $00BD24
        RTS                                     ; $00BD28
loc_00BD2A:
        MOVEQ   #$00,D2                         ; $00BD2A
        MOVE.B  $0001(A0),D2                    ; $00BD2C
        ADDQ.W  #1,D2                           ; $00BD30
        MOVE.W  $C8AA.W,D0                      ; $00BD32
        LEA     $0002(A0),A2                    ; $00BD36
        LEA     (A2),A1                         ; $00BD3A
loc_00BD3C:
        LEA     -$0010(A1),A1                   ; $00BD3C
        CMPI.B  #$000C,-$0002(A1)               ; $00BD40
        BEQ.S  loc_00BD3C                       ; $00BD46
        MOVE.W  (A2)+,D1                        ; $00BD48
        SUB.W  (A1),D1                          ; $00BD4A
        MULS    D0,D1                           ; $00BD4C
        DIVS    D2,D1                           ; $00BD4E
        ADD.W  (A1)+,D1                         ; $00BD50
        MOVE.W  D1,$C086.W                      ; $00BD52
        MOVE.W  (A2)+,D1                        ; $00BD56
        SUB.W  (A1),D1                          ; $00BD58
        MULS    D0,D1                           ; $00BD5A
        DIVS    D2,D1                           ; $00BD5C
        ADD.W  (A1)+,D1                         ; $00BD5E
        MOVE.W  D1,$C054.W                      ; $00BD60
        MOVE.W  (A2)+,D1                        ; $00BD64
        SUB.W  (A1),D1                          ; $00BD66
        MULS    D0,D1                           ; $00BD68
        DIVS    D2,D1                           ; $00BD6A
        ADD.W  (A1)+,D1                         ; $00BD6C
        MOVE.W  D1,$C056.W                      ; $00BD6E
        MOVE.W  (A2)+,D1                        ; $00BD72
        SUB.W  (A1),D1                          ; $00BD74
        MULS    D0,D1                           ; $00BD76
        DIVS    D2,D1                           ; $00BD78
        ADD.W  (A1)+,D1                         ; $00BD7A
        MOVE.W  D1,$C0AE.W                      ; $00BD7C
        MOVE.W  (A2)+,D1                        ; $00BD80
        SUB.W  (A1),D1                          ; $00BD82
        MULS    D0,D1                           ; $00BD84
        DIVS    D2,D1                           ; $00BD86
        ADD.W  (A1)+,D1                         ; $00BD88
        MOVE.W  D1,$C0B0.W                      ; $00BD8A
        MOVE.W  (A2)+,D1                        ; $00BD8E
        SUB.W  (A1),D1                          ; $00BD90
        MULS    D0,D1                           ; $00BD92
        DIVS    D2,D1                           ; $00BD94
        ADD.W  (A1)+,D1                         ; $00BD96
        MOVE.W  D1,$C0B2.W                      ; $00BD98
        RTS                                     ; $00BD9C
loc_00BD9E:
        ADDQ.W  #4,A7                           ; $00BD9E
        MOVE.B  #$0001,$C308.W                  ; $00BDA0
        RTS                                     ; $00BDA6
        TST.W  $A0F0.W                          ; $00BDA8
        BNE.S  loc_00BDC6                       ; $00BDAC
        BTST    #1,$C8AB.W                      ; $00BDAE
        BEQ.S  loc_00BDC6                       ; $00BDB4
        MOVE.W  #$FFFF,$00FF60C8                ; $00BDB6
        MOVE.B  #$0009,$00FF6850                ; $00BDBE
loc_00BDC6:
        RTS                                     ; $00BDC6
        TST.W  $A0F0.W                          ; $00BDC8
        BNE.S  loc_00BDD4                       ; $00BDCC
        MOVE.W  #$0001,$A0F0.W                  ; $00BDCE
loc_00BDD4:
        RTS                                     ; $00BDD4
loc_00BDD6:
        MOVE.W  $A0F0.W,D1                      ; $00BDD6
        BEQ.S  loc_00BDFC                       ; $00BDDA
        LEA     $00FF6860,A1                    ; $00BDDC
        MOVE.B  #$000B,$0000(A1)                ; $00BDE2
        MOVE.B  #$000C,$0010(A1)                ; $00BDE8
        CMPI.W  #$000C,D1                       ; $00BDEE
        BLT.S  loc_00BDFE                       ; $00BDF2
        MOVE.W  #$FFFF,$00FF60C8                ; $00BDF4
loc_00BDFC:
        RTS                                     ; $00BDFC
loc_00BDFE:
        ADD.W  D1,D1                            ; $00BDFE
        MOVE.W  $4E(PC,D1.W),D0                 ; $00BE00
        ADDI.W  #$0010,D0                       ; $00BE04
        MOVE.W  D0,$A0E6.W                      ; $00BE08
        MOVE.W  D0,D2                           ; $00BE0C
        SUBI.W  #$0010,D2                       ; $00BE0E
        MOVE.W  D2,$0002(A1)                    ; $00BE12
        MOVE.W  D2,$0012(A1)                    ; $00BE16
        MOVE.W  #$00E0,D1                       ; $00BE1A
        SUB.W  D0,D1                            ; $00BE1E
        LEA     $00FF60C8,A2                    ; $00BE20
        MOVE.W  D0,(A2)                         ; $00BE26
        MOVE.W  D1,$0002(A2)                    ; $00BE28
        SUBQ.W  #1,D0                           ; $00BE2C
        MOVEQ   #$09,D2                         ; $00BE2E
        EXT.L   D0                              ; $00BE30
        ASL.L  D2,D0                            ; $00BE32
        EXT.L   D1                              ; $00BE34
        ASL.L  D2,D1                            ; $00BE36
        MOVE.L  #$04024140,D2                   ; $00BE38
        ADD.L  D2,D0                            ; $00BE3E
        ADD.L  D2,D1                            ; $00BE40
        MOVE.L  D0,$0004(A1)                    ; $00BE42
        MOVE.L  D1,$0014(A1)                    ; $00BE46
        ADDQ.W  #1,$A0F0.W                      ; $00BE4A
        RTS                                     ; $00BE4E
        ORI.B  #$0002,D0                        ; $00BE50
        ORI.B  #$0008,D4                        ; $00BE54
        DC.W    $000C                           ; $00BE58
        ORI.B  #$001A,(A2)                      ; $00BE5A
        ORI.B  #$0030,-(A4)                     ; $00BE5E
        ORI.B  #$004E,<EA:3E>                   ; $00BE62
        ORI.W  #$3038,-(A0)                     ; $00BE66
        MOVE.L  $207B(A2),(A0)+                 ; $00BE6A
        ORI.B  #$4ED0,D4                        ; $00BE6E
        DC.W    $0088                           ; $00BE72
        CMP.L  $0088(A6),D7                     ; $00BE74
        CMPA.W  D4,A7                           ; $00BE78
        DC.W    $0088                           ; $00BE7A
        EOR.B  D7,(A4)                          ; $00BE7C
        DC.W    $0088                           ; $00BE7E
        EOR.L  D7,(A6)+                         ; $00BE80
        DC.W    $0088                           ; $00BE82
        CMPA.L  (A6)+,A7                        ; $00BE84
        DC.W    $0088                           ; $00BE86
        EOR.B  D7,(A4)                          ; $00BE88
        DC.W    $0088                           ; $00BE8A
        EOR.L  D7,(A6)+                         ; $00BE8C
        DC.W    $0088                           ; $00BE8E
        CMPA.L  (A6)+,A7                        ; $00BE90
        DC.W    $0088                           ; $00BE92
        EOR.B  D7,(A4)                          ; $00BE94
        DC.W    $0088                           ; $00BE96
        EOR.L  D7,(A6)+                         ; $00BE98
        DC.W    $0088                           ; $00BE9A
        CMPA.L  (A6)+,A7                        ; $00BE9C
        DC.W    $0088                           ; $00BE9E
        EOR.B  D7,(A4)                          ; $00BEA0
        DC.W    $0088                           ; $00BEA2
        EOR.L  D7,(A6)+                         ; $00BEA4
        DC.W    $0088                           ; $00BEA6
        CMPA.L  (A6)+,A7                        ; $00BEA8
        DC.W    $0088                           ; $00BEAA
        AND.B  $5278(A0),D0                     ; $00BEAC
        MOVE.L  $0C78(A4),(A0)+                 ; $00BEB0
        ORI.W  #$A0EC,$6D08.W                   ; $00BEB4
        ADDQ.W  #4,$A0EA.W                      ; $00BEBA
        CLR.W  $A0EC.W                          ; $00BEBE
        RTS                                     ; $00BEC2
        ADDQ.W  #4,$A0EA.W                      ; $00BEC4
        CLR.W  $A0EC.W                          ; $00BEC8
        LEA     $00FF6800,A1                    ; $00BECC
        MOVE.B  #$0001,$0000(A1)                ; $00BED2
        LEA     $00FF6810,A1                    ; $00BED8
        MOVE.B  #$0001,$0000(A1)                ; $00BEDE
        LEA     $00FF6820,A1                    ; $00BEE4
        MOVE.B  #$0001,$0000(A1)                ; $00BEEA
        MOVE.W  $C8A0.W,D0                      ; $00BEF0
        MOVE.L  $06(PC,D0.W),$0008(A1)          ; $00BEF4
        RTS                                     ; $00BEFA
        MOVE.L  $35E0(A6),D1                    ; $00BEFC
        MOVE.L  $3CE4(A6),D1                    ; $00BF00
        MOVE.L  $43E8(A6),D1                    ; $00BF04
        MOVE.L  $4A6C(A6),D1                    ; $00BF08
        MOVE.L  $5070(A6),D1                    ; $00BF0C
        MOVE.L  $35E0(A6),D1                    ; $00BF10
        LEA     $00FF6900,A1                    ; $00BF14
        LEA     $EF08.W,A2                      ; $00BF1A
        LEA     $0088C05C,A3                    ; $00BF1E
        MOVE.W  $A0EE.W,D0                      ; $00BF24
        MOVE.W  D0,D1                           ; $00BF28
        ADDQ.W  #1,D1                           ; $00BF2A
        ASL.W  #3,D0                            ; $00BF2C
        LEA     $00(A2,D0.W),A2                 ; $00BF2E
        MOVE.W  $C89C.W,D0                      ; $00BF32
        ADD.W  $C8CA.W,D0                       ; $00BF36
        ADD.W  $C8CC.W,D0                       ; $00BF3A
        LSL.W  #5,D0                            ; $00BF3E
        MOVE.W  D0,D2                           ; $00BF40
        ADD.W  D2,D2                            ; $00BF42
        ADD.W  D2,D2                            ; $00BF44
        ADD.W  D2,D0                            ; $00BF46
        ADDA.W  D0,A2                           ; $00BF48
        MOVEQ   #$04,D0                         ; $00BF4A
loc_00BF4C:
        CLR.W  (A1)+                            ; $00BF4C
        MOVE.B  D1,(A1)+                        ; $00BF4E
        MOVE.B  $0003(A2),(A1)+                 ; $00BF50
        MOVE.L  (A3)+,(A1)+                     ; $00BF54
        CLR.W  (A1)+                            ; $00BF56
        MOVE.B  $0004(A2),(A1)+                 ; $00BF58
        MOVE.B  $0005(A2),D2                    ; $00BF5C
        MOVE.B  D2,D3                           ; $00BF60
        LSR.W  #4,D3                            ; $00BF62
        MOVE.B  D3,(A1)+                        ; $00BF64
        ANDI.B  #$000F,D2                       ; $00BF66
        MOVE.B  D2,(A1)+                        ; $00BF6A
        MOVE.B  $0006(A2),(A1)+                 ; $00BF6C
        MOVE.B  $0007(A2),D2                    ; $00BF70
        MOVE.B  D2,D3                           ; $00BF74
        LSR.W  #4,D3                            ; $00BF76
        MOVE.B  D3,(A1)+                        ; $00BF78
        ANDI.B  #$000F,D2                       ; $00BF7A
        MOVE.B  D2,(A1)+                        ; $00BF7E
        MOVE.L  (A2),D2                         ; $00BF80
        ANDI.L  #$FFFFFF00,D2                   ; $00BF82
        MOVE.L  D2,(A1)+                        ; $00BF88
        ADDQ.W  #1,D1                           ; $00BF8A
        LEA     $0008(A2),A2                    ; $00BF8C
        DBRA    D0,loc_00BF4C                   ; $00BF90
        ADDQ.W  #4,$A0EA.W                      ; $00BF94
        ADDQ.W  #5,$A0EE.W                      ; $00BF98
        RTS                                     ; $00BF9C
        ADDQ.W  #1,$A0EC.W                      ; $00BF9E
        MOVEQ   #$00,D0                         ; $00BFA2
        MOVE.W  $A0EC.W,D0                      ; $00BFA4
        ADD.W  D0,D0                            ; $00BFA8
        DIVU    #$001C,D0                       ; $00BFAA
        CMPI.W  #$0005,D0                       ; $00BFAE
        BGE.S  loc_00BFD4                       ; $00BFB2
        MOVE.W  D0,D1                           ; $00BFB4
        SWAP    D0                              ; $00BFB6
        ADDQ.W  #2,D0                           ; $00BFB8
        ADD.W  D1,D1                            ; $00BFBA
        ADD.W  D1,D1                            ; $00BFBC
        MOVE.W  D1,D2                           ; $00BFBE
        ADD.W  D1,D1                            ; $00BFC0
        ADD.W  D1,D1                            ; $00BFC2
        ADD.W  D2,D1                            ; $00BFC4
        LEA     $00FF6900,A1                    ; $00BFC6
        LEA     $00(A1,D1.W),A1                 ; $00BFCC
        MOVE.W  D0,(A1)                         ; $00BFD0
        RTS                                     ; $00BFD2
loc_00BFD4:
        ADDQ.W  #4,$A0EA.W                      ; $00BFD4
        CLR.W  $A0EC.W                          ; $00BFD8
        RTS                                     ; $00BFDC
        ADDQ.W  #1,$A0EC.W                      ; $00BFDE
        MOVEQ   #$00,D0                         ; $00BFE2
        MOVE.W  $A0EC.W,D0                      ; $00BFE4
        ADD.W  D0,D0                            ; $00BFE8
        DIVU    #$001C,D0                       ; $00BFEA
        CMPI.W  #$0005,D0                       ; $00BFEE
        BGE.S  loc_00C01E                       ; $00BFF2
        MOVE.W  D0,D1                           ; $00BFF4
        SWAP    D0                              ; $00BFF6
        ADDQ.W  #2,D0                           ; $00BFF8
        NEG.W  D0                               ; $00BFFA
        CMPI.W  #$FFE4,D0                       ; $00BFFC
        BNE.S  loc_00C004                       ; $00C000
        MOVEQ   #$00,D0                         ; $00C002
loc_00C004:
        ADD.W  D1,D1                            ; $00C004
        ADD.W  D1,D1                            ; $00C006
        MOVE.W  D1,D2                           ; $00C008
        ADD.W  D1,D1                            ; $00C00A
        ADD.W  D1,D1                            ; $00C00C
        ADD.W  D2,D1                            ; $00C00E
        LEA     $00FF6900,A1                    ; $00C010
        LEA     $00(A1,D1.W),A1                 ; $00C016
        MOVE.W  D0,(A1)                         ; $00C01A
        RTS                                     ; $00C01C
loc_00C01E:
        ADDQ.W  #4,$A0EA.W                      ; $00C01E
        CLR.W  $A0EC.W                          ; $00C022
        RTS                                     ; $00C026
        MOVEQ   #$00,D0                         ; $00C028
        LEA     $00FF6800,A1                    ; $00C02A
        MOVE.B  D0,$0000(A1)                    ; $00C030
        LEA     $00FF6810,A1                    ; $00C034
        MOVE.B  D0,$0000(A1)                    ; $00C03A
        LEA     $00FF6820,A1                    ; $00C03E
        MOVE.B  D0,$0000(A1)                    ; $00C044
        LEA     $00FF6900,A1                    ; $00C048
        MOVEQ   #$05,D1                         ; $00C04E
loc_00C050:
        CLR.W  (A1)                             ; $00C050
        LEA     $0014(A1),A1                    ; $00C052
        DBRA    D1,loc_00C050                   ; $00C056
        RTS                                     ; $00C05A
        SUBI.B  #$C030,D2                       ; $00C05C
        SUBI.B  #$E030,D2                       ; $00C060
        SUBI.B  #$0030,D3                       ; $00C064
        SUBI.B  #$2030,D3                       ; $00C068
        SUBI.B  #$4030,D3                       ; $00C06C
        LEA     $00FF6800,A1                    ; $00C070
        MOVEQ   #$10,D1                         ; $00C076
        MOVEQ   #$0F,D0                         ; $00C078
loc_00C07A:
        CLR.W  (A1)                             ; $00C07A
        ADDA.W  D1,A1                           ; $00C07C
        DBRA    D0,loc_00C07A                   ; $00C07E
        MOVE.W  $C0FC.W,D2                      ; $00C082
        BEQ.W  loc_00C0DC                       ; $00C086
        BMI.S  loc_00C096                       ; $00C08A
        CLR.W  $C0FE.W                          ; $00C08C
        BSET    #7,$C0FC.W                      ; $00C090
loc_00C096:
        SUBQ.W  #1,D2                           ; $00C096
        ANDI.W  #$0007,D2                       ; $00C098
        ADD.W  D2,D2                            ; $00C09C
        ADD.W  D2,D2                            ; $00C09E
        LEA     $0089ACF0,A2                    ; $00C0A0
        MOVEA.L $00(A2,D2.W),A2                 ; $00C0A6
        LEA     $00FF6800,A1                    ; $00C0AA
        MOVE.W  (A2)+,D1                        ; $00C0B0
loc_00C0B2:
        MOVE.W  (A2)+,(A1)+                     ; $00C0B2
        MOVE.W  (A2)+,D3                        ; $00C0B4
        CLR.W  (A1)+                            ; $00C0B6
        MOVE.L  (A2)+,(A1)+                     ; $00C0B8
        MOVE.L  (A2)+,(A1)+                     ; $00C0BA
        CLR.L  (A1)+                            ; $00C0BC
        SUB.W  $C0FE.W,D3                       ; $00C0BE
        BMI.S  loc_00C0D8                       ; $00C0C2
        CMPI.W  #$0050,D3                       ; $00C0C4
        BLE.S  loc_00C0CE                       ; $00C0C8
        MOVE.W  #$0050,D3                       ; $00C0CA
loc_00C0CE:
        ADD.W  D3,D3                            ; $00C0CE
        ADD.W  D3,D3                            ; $00C0D0
        EXT.L   D3                              ; $00C0D2
        ADD.L  D3,-$000C(A1)                    ; $00C0D4
loc_00C0D8:
        DBRA    D1,loc_00C0B2                   ; $00C0D8
loc_00C0DC:
        ADDQ.W  #8,$C0FE.W                      ; $00C0DC
        CMPI.W  #$7FFF,$C0FE.W                  ; $00C0E0
        BLE.S  loc_00C0EE                       ; $00C0E6
        MOVE.W  #$7FFF,$C0FE.W                  ; $00C0E8
loc_00C0EE:
        RTS                                     ; $00C0EE
        NOT    #$2700                           ; $00C0F0
        BCLR    #6,$C875.W                      ; $00C0F4
        MOVE.W  $C874.W,(A5)                    ; $00C0FA
        MOVE.W  #$0083,$00A15100                ; $00C0FE
        ANDI.B  #$00FC,$00A15181                ; $00C106
        JSR     $0088270A                       ; $00C10E
        MOVE.B  #$0001,$C80D.W                  ; $00C114
        ANDI.B  #$0009,$C80E.W                  ; $00C11A
        BSET    #3,$C80E.W                      ; $00C120
        MOVEQ   #$00,D0                         ; $00C126
        MOVEQ   #$00,D1                         ; $00C128
        MOVE.B  #$0000,D0                       ; $00C12A
        MOVE.B  #$0000,D1                       ; $00C12E
        JSR     $00D19C(PC)                     ; $00C132
        MOVE.B  $C8C9.W,D0                      ; $00C136
        ADDQ.B  #1,D0                           ; $00C13A
        MOVE.B  D0,$00A15122                    ; $00C13C
        MOVE.W  #$0103,$C8A8.W                  ; $00C142
        MOVE.B  $C8A9.W,$00A15121               ; $00C148
        MOVE.B  $C8A8.W,$00A15120               ; $00C150
        MOVE.B  #$0000,$C80F.W                  ; $00C158
        MOVE.W  #$0000,$C8BC.W                  ; $00C15E
        JSR     $0088D1D4                       ; $00C164
        JSR     $0088D42C                       ; $00C16A
        LEA     $008BA220,A0                    ; $00C170
        MOVE.W  $C8A0.W,D0                      ; $00C176
        MOVEA.L $00(A0,D0.W),A2                 ; $00C17A
        JSR     $0088284C                       ; $00C17E
        LEA     $008BAE38,A0                    ; $00C184
        MOVE.W  $C8CC.W,D0                      ; $00C18A
        MOVEA.L $00(A0,D0.W),A2                 ; $00C18E
        JSR     $00882862                       ; $00C192
        MOVE.W  #$0010,$00FF0008                ; $00C198
        MOVE.W  #$0000,$C8AA.W                  ; $00C1A0
        JSR     $008849AA                       ; $00C1A6
        JSR     $00CD92(PC)                     ; $00C1AC
        MOVE.B  #$0000,$C314.W                  ; $00C1B0
        BTST    #0,$C818.W                      ; $00C1B6
        BEQ.S  loc_00C1C4                       ; $00C1BC
        MOVE.B  #$0001,$C314.W                  ; $00C1BE
loc_00C1C4:
        MOVEQ   #$00,D0                         ; $00C1C4
        JSR     $00CC74(PC)                     ; $00C1C6
        JSR     $00C870(PC)                     ; $00C1CA
        JSR     $00C9F0(PC)                     ; $00C1CE
        JSR     $00D00C(PC)                     ; $00C1D2
        MOVE.B  #$0005,$C310.W                  ; $00C1D6
        MOVE.B  #$0000,$C30F.W                  ; $00C1DC
        LEA     $9000.W,A0                      ; $00C1E2
        JSR     $00CC92(PC)                     ; $00C1E6
        MOVEQ   #$00,D1                         ; $00C1EA
        JSR     $00CE56(PC)                     ; $00C1EC
        JSR     $00CD4C(PC)                     ; $00C1F0
        JSR     $0088A80A                       ; $00C1F4
        JSR     $0088A144                       ; $00C1FA
