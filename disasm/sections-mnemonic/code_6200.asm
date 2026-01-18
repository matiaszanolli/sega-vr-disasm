; Generated assembly for $006200-$008200
; Branch targets: 312
; Labels: 245

        org     $006200

        BEQ.S  loc_006204                       ; $006200
        MOVEQ   #$04,D0                         ; $006202
loc_006204:
        MOVEA.L $3A(PC,D0.W),A1                 ; $006204
        JSR     (A1)                            ; $006208
        CMPI.W  #$0014,$C8AA.W                  ; $00620A
        BNE.S  loc_00623E                       ; $006210
        MOVE.B  #$0000,$C800.W                  ; $006212
        MOVE.W  $C092.W,$C07A.W                 ; $006218
        MOVE.W  #$0004,$C8AC.W                  ; $00621E
        TST.W  $C89C.W                          ; $006224
        BEQ.S  loc_006230                       ; $006228
        MOVE.W  #$0020,$C8AC.W                  ; $00622A
loc_006230:
        BTST    #7,$C81C.W                      ; $006230
        BEQ.S  loc_00623E                       ; $006236
        MOVE.W  #$0020,$C8AC.W                  ; $006238
loc_00623E:
        RTS                                     ; $00623E
        ORI.L  #$3C7E0088,A0                    ; $006240
        MOVE.W  (A2)+,$0088(A6)                 ; $006246
        MOVE.W  (A2)+,$0088(A6)                 ; $00624A
        MOVE.W  (A2)+,$0088(A6)                 ; $00624E
        MOVE.W  (A2)+,$0088(A6)                 ; $006252
        MOVE.W  (A2)+,$7000(A6)                 ; $006256
        MOVE.W  D0,$0044(A0)                    ; $00625A
        MOVE.W  D0,$0046(A0)                    ; $00625E
        MOVE.W  D0,$004A(A0)                    ; $006262
        JSR     loc_00714A(PC)                  ; $006266
        JSR     loc_00764E(PC)                  ; $00626A
        JSR     $0086C8(PC)                     ; $00626E
        JSR     $003126(PC)                     ; $006272
        JSR     $003160(PC)                     ; $006276
        JSR     loc_007624(PC)                  ; $00627A
        JSR     loc_00734E(PC)                  ; $00627E
        MOVE.B  $C304.W,$C30C.W                 ; $006282
        JSR     $00886C88                       ; $006288
        JMP     $0049AA(PC)                     ; $00628E
        MOVEQ   #$00,D0                         ; $006292
        MOVE.W  D0,$0044(A0)                    ; $006294
        MOVE.W  D0,$0046(A0)                    ; $006298
        MOVE.W  D0,$004A(A0)                    ; $00629C
        MOVE.L  #$00100010,$C970.W              ; $0062A0
        MOVE.W  #$0002,$0092(A0)                ; $0062A8
        JSR     $00859A(PC)                     ; $0062AE
        JSR     $00A350(PC)                     ; $0062B2
        JSR     loc_008170(PC)                  ; $0062B6
        JSR     loc_0080CC(PC)                  ; $0062BA
        JSR     $008548(PC)                     ; $0062BE
        JSR     $0094FA(PC)                     ; $0062C2
        JSR     $009312(PC)                     ; $0062C6
        JSR     $009B12(PC)                     ; $0062CA
        JSR     $009182(PC)                     ; $0062CE
        JSR     $00961E(PC)                     ; $0062D2
        JSR     $009688(PC)                     ; $0062D6
        JSR     $009802(PC)                     ; $0062DA
        JSR     loc_007E7A(PC)                  ; $0062DE
        JSR     loc_006F98(PC)                  ; $0062E2
        JSR     loc_007CD8(PC)                  ; $0062E6
        JSR     $00A434(PC)                     ; $0062EA
        JSR     loc_0070AA(PC)                  ; $0062EE
        JSR     loc_007F04(PC)                  ; $0062F2
        JSR     loc_007C4E(PC)                  ; $0062F6
        JSR     loc_00714A(PC)                  ; $0062FA
        JSR     loc_00764E(PC)                  ; $0062FE
        JSR     loc_007F50(PC)                  ; $006302
        JSR     $009CCE(PC)                     ; $006306
        JSR     $009B54(PC)                     ; $00630A
        JSR     $0086C8(PC)                     ; $00630E
        JSR     $00ACD4(PC)                     ; $006312
        JSR     $00442E(PC)                     ; $006316
        JSR     $003126(PC)                     ; $00631A
        JSR     $003160(PC)                     ; $00631E
        JSR     loc_007624(PC)                  ; $006322
        JSR     loc_00734E(PC)                  ; $006326
        JSR     $0036DE(PC)                     ; $00632A
        JSR     $0037B6(PC)                     ; $00632E
        JSR     $003F86(PC)                     ; $006332
        JMP     $009064(PC)                     ; $006336
        MOVEQ   #$00,D0                         ; $00633A
        MOVE.W  D0,$0044(A0)                    ; $00633C
        MOVE.W  D0,$0046(A0)                    ; $006340
        MOVE.W  D0,$004A(A0)                    ; $006344
        JSR     loc_0080CC(PC)                  ; $006348
        JSR     $008548(PC)                     ; $00634C
        JSR     $009802(PC)                     ; $006350
        JSR     loc_007E7A(PC)                  ; $006354
        JSR     loc_006F98(PC)                  ; $006358
        JSR     loc_007CD8(PC)                  ; $00635C
        JSR     loc_0070AA(PC)                  ; $006360
        JSR     loc_00714A(PC)                  ; $006364
        JSR     loc_00764E(PC)                  ; $006368
        JSR     loc_007F50(PC)                  ; $00636C
        JSR     $009CCE(PC)                     ; $006370
        JSR     $009B54(PC)                     ; $006374
        JSR     $00877A(PC)                     ; $006378
        JSR     $0090A4(PC)                     ; $00637C
        JSR     $003126(PC)                     ; $006380
        JSR     loc_0075FE(PC)                  ; $006384
        JSR     loc_0071A6(PC)                  ; $006388
        JSR     $0036DE(PC)                     ; $00638C
        JMP     $0037B6(PC)                     ; $006390
        MOVEQ   #$00,D0                         ; $006394
        MOVE.W  D0,$0044(A0)                    ; $006396
        MOVE.W  D0,$0046(A0)                    ; $00639A
        MOVE.W  D0,$004A(A0)                    ; $00639E
        MOVE.L  #$00100010,$C970.W              ; $0063A2
        MOVE.W  #$0002,$0092(A0)                ; $0063AA
        BCLR    #4,$C30E.W                      ; $0063B0
        JSR     $00859A(PC)                     ; $0063B6
        JSR     $008548(PC)                     ; $0063BA
        JSR     $009312(PC)                     ; $0063BE
        JSR     $009B12(PC)                     ; $0063C2
        JSR     $009182(PC)                     ; $0063C6
        JSR     $00961E(PC)                     ; $0063CA
        JSR     loc_006F98(PC)                  ; $0063CE
        JSR     $00A434(PC)                     ; $0063D2
        JSR     loc_0070AA(PC)                  ; $0063D6
        JSR     loc_007C4E(PC)                  ; $0063DA
        JSR     loc_00714A(PC)                  ; $0063DE
        JSR     loc_00764E(PC)                  ; $0063E2
        JSR     $009CCE(PC)                     ; $0063E6
        JSR     $009B54(PC)                     ; $0063EA
        JSR     $00877A(PC)                     ; $0063EE
        JSR     $0090A4(PC)                     ; $0063F2
        JSR     $003126(PC)                     ; $0063F6
        JSR     loc_0075FE(PC)                  ; $0063FA
        JSR     loc_0071A6(PC)                  ; $0063FE
        JSR     $0036DE(PC)                     ; $006402
        JSR     $0037B6(PC)                     ; $006406
        JMP     $003F86(PC)                     ; $00640A
        LEA     $A000.W,A4                      ; $00640E
        LEA     $9000.W,A0                      ; $006412
        MOVE.B  $FEAF.W,$C30F.W                 ; $006416
        JSR     loc_006BBE(PC)                  ; $00641C
        MOVE.L  $00B2(A0),$0018(A0)             ; $006420
        MOVE.B  $00E5(A0),D1                    ; $006426
        ANDI.B  #$0006,D1                       ; $00642A
        BEQ.S  loc_006436                       ; $00642E
        MOVE.L  $C70C.W,$0018(A0)               ; $006430
loc_006436:
        MOVE.W  $C07A.W,D0                      ; $006436
        LEA     $0160(PC),A1                    ; $00643A
        MOVEA.L $00(A1,D0.W),A1                 ; $00643E
        JSR     (A1)                            ; $006442
        JSR     loc_007F04(PC)                  ; $006444
        JSR     $0083BC(PC)                     ; $006448
        LEA     $9F00.W,A1                      ; $00644C
        JSR     $008672(PC)                     ; $006450
        LEA     $819C.W,A1                      ; $006454
        JSR     $0090CE(PC)                     ; $006458
        LEA     $C000.W,A2                      ; $00645C
        LEA     $B400.W,A1                      ; $006460
        MOVEQ   #$1F,D7                         ; $006464
loc_006466:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A2)+   ; $006466
        MOVEM.L -(A1),D4/A1/A2/A3/A4/A5/A6/A7   ; $00646A
        DBRA    D7,loc_006466                   ; $00646E
        MOVE.L  $C970.W,$C978.W                 ; $006472
        MOVE.L  $C974.W,$C970.W                 ; $006478
        LEA     $B400.W,A1                      ; $00647E
        LEA     $C400.W,A2                      ; $006482
        MOVEQ   #$1F,D7                         ; $006486
loc_006488:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A1)+   ; $006488
        MOVEM.L -(A2),D4/A1/A2/A3/A4/A5/A6/A7   ; $00648C
        DBRA    D7,loc_006488                   ; $006490
        RTS                                     ; $006494
        LEA     $A000.W,A4                      ; $006496
        LEA     $9F00.W,A0                      ; $00649A
        MOVE.B  $FEB0.W,$C30F.W                 ; $00649E
        JSR     loc_006BBE(PC)                  ; $0064A4
        MOVE.L  $00B2(A0),$0018(A0)             ; $0064A8
        MOVE.B  $00E5(A0),D1                    ; $0064AE
        ANDI.B  #$0006,D1                       ; $0064B2
        BEQ.S  loc_0064BE                       ; $0064B6
        MOVE.L  $C70C.W,$0018(A0)               ; $0064B8
loc_0064BE:
        MOVE.W  $C07A.W,D0                      ; $0064BE
        LEA     $00D8(PC),A1                    ; $0064C2
        MOVEA.L $00(A1,D0.W),A1                 ; $0064C6
        JSR     (A1)                            ; $0064CA
        JSR     $009E5A(PC)                     ; $0064CC
        JSR     loc_007EFC(PC)                  ; $0064D0
        JSR     $0083DA(PC)                     ; $0064D4
        JSR     $0087E2(PC)                     ; $0064D8
        LEA     $9F00.W,A0                      ; $0064DC
        LEA     $9000.W,A1                      ; $0064E0
        JSR     $008672(PC)                     ; $0064E4
        LEA     $831C.W,A1                      ; $0064E8
        JSR     $0090CE(PC)                     ; $0064EC
        LEA     $9000.W,A0                      ; $0064F0
        JSR     $009E5A(PC)                     ; $0064F4
        JSR     $00AF18(PC)                     ; $0064F8
        LEA     $9F00.W,A0                      ; $0064FC
        MOVE.W  #$0000,$008A(A0)                ; $006500
        JSR     $00A1FC(PC)                     ; $006506
        JSR     loc_0075FE(PC)                  ; $00650A
        JSR     loc_007270(PC)                  ; $00650E
        JSR     $002C04(PC)                     ; $006512
        JSR     $00337A(PC)                     ; $006516
        JSR     $003B28(PC)                     ; $00651A
        JSR     $003F5A(PC)                     ; $00651E
        MOVE.B  $C304.W,$C30C.W                 ; $006522
        JSR     loc_006BEA(PC)                  ; $006528
        LEA     $C000.W,A2                      ; $00652C
        LEA     $B800.W,A1                      ; $006530
        MOVEQ   #$1F,D7                         ; $006534
loc_006536:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A2)+   ; $006536
        MOVEM.L -(A1),D4/A1/A2/A3/A4/A5/A6/A7   ; $00653A
        DBRA    D7,loc_006536                   ; $00653E
        MOVE.L  $C978.W,$C970.W                 ; $006542
        LEA     $B000.W,A1                      ; $006548
        LEA     $C400.W,A2                      ; $00654C
        MOVEQ   #$1F,D7                         ; $006550
loc_006552:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A1)+   ; $006552
        MOVEM.L -(A2),D4/A1/A2/A3/A4/A5/A6/A7   ; $006556
        DBRA    D7,loc_006552                   ; $00655A
        LEA     $9000.W,A0                      ; $00655E
        LEA     $9F00.W,A1                      ; $006562
        JSR     $008418(PC)                     ; $006566
        JSR     $009EC0(PC)                     ; $00656A
        MOVE.W  #$0000,$008A(A0)                ; $00656E
        JSR     $00A1FC(PC)                     ; $006574
        JSR     loc_0075FE(PC)                  ; $006578
        JSR     loc_007260(PC)                  ; $00657C
        JSR     $002BB0(PC)                     ; $006580
        JSR     $00337A(PC)                     ; $006584
        JSR     $0037B6(PC)                     ; $006588
        JSR     $003F2E(PC)                     ; $00658C
        MOVE.B  $C304.W,$C30C.W                 ; $006590
        JSR     loc_006BEA(PC)                  ; $006596
        RTS                                     ; $00659A
        ORI.L  #$65BC0088,A0                    ; $00659C
        BVC.S  loc_0065A8                       ; $0065A2
        ORI.L  #$662A0088,A0                    ; $0065A4
        BNE.S  loc_006560                       ; $0065AA
        ORI.L  #$671A0088,A0                    ; $0065AC
        BEQ.S  loc_0065CC                       ; $0065B2
        ORI.L  #$677A0088,A0                    ; $0065B4
        BNE.S  loc_0065F2                       ; $0065BA
        JSR     $00B770(PC)                     ; $0065BC
        MOVEQ   #$00,D0                         ; $0065C0
        MOVE.W  D0,$0044(A0)                    ; $0065C2
        MOVE.W  D0,$0046(A0)                    ; $0065C6
        MOVE.W  D0,$004A(A0)                    ; $0065CA
        JSR     $008610(PC)                     ; $0065CE
        JSR     $00859A(PC)                     ; $0065D2
        JSR     $00A350(PC)                     ; $0065D6
        JSR     loc_008170(PC)                  ; $0065DA
        JSR     loc_0080CC(PC)                  ; $0065DE
        JSR     $008548(PC)                     ; $0065E2
        JSR     $0094FA(PC)                     ; $0065E6
        JSR     $009312(PC)                     ; $0065EA
        JSR     $009B12(PC)                     ; $0065EE
loc_0065F2:
        JSR     $009182(PC)                     ; $0065F2
        JSR     $00961E(PC)                     ; $0065F6
        JSR     $009688(PC)                     ; $0065FA
        JSR     $009802(PC)                     ; $0065FE
        JSR     loc_007E7A(PC)                  ; $006602
        JSR     loc_006F98(PC)                  ; $006606
        JSR     loc_007CD8(PC)                  ; $00660A
        JSR     $00A434(PC)                     ; $00660E
        JSR     loc_0070AA(PC)                  ; $006612
        JSR     loc_007C4E(PC)                  ; $006616
        JSR     loc_00714A(PC)                  ; $00661A
        JSR     loc_00764E(PC)                  ; $00661E
        JSR     loc_008032(PC)                  ; $006622
        JMP     $009B54(PC)                     ; $006626
        MOVE.W  #$0000,$0006(A0)                ; $00662A
        MOVE.W  #$0000,$0074(A0)                ; $006630
        JSR     $00B770(PC)                     ; $006636
        MOVEQ   #$00,D0                         ; $00663A
        MOVE.W  D0,$0044(A0)                    ; $00663C
        MOVE.W  D0,$0046(A0)                    ; $006640
        MOVE.W  D0,$004A(A0)                    ; $006644
        JSR     $004A0C(PC)                     ; $006648
        JSR     $00859A(PC)                     ; $00664C
        JSR     $00A350(PC)                     ; $006650
        JSR     loc_008170(PC)                  ; $006654
        JSR     loc_0080CC(PC)                  ; $006658
        JSR     $008548(PC)                     ; $00665C
        JSR     $0094FA(PC)                     ; $006660
        CMPI.W  #$0004,$C26C.W                  ; $006664
        BEQ.S  loc_006670                       ; $00666A
        JSR     $009312(PC)                     ; $00666C
loc_006670:
        JSR     $009B12(PC)                     ; $006670
        JSR     $009182(PC)                     ; $006674
        JSR     $009802(PC)                     ; $006678
        JSR     loc_007084(PC)                  ; $00667C
        JSR     loc_0070AA(PC)                  ; $006680
        JSR     loc_007816(PC)                  ; $006684
        SUBQ.W  #1,$C02C.W                      ; $006688
        BGT.S  loc_0066A0                       ; $00668C
        MOVE.W  #$0000,$C02C.W                  ; $00668E
        MOVE.W  #$0000,$0074(A0)                ; $006694
        MOVE.W  $C08C.W,$C07A.W                 ; $00669A
loc_0066A0:
        JSR     loc_007C4E(PC)                  ; $0066A0
        JSR     loc_00714A(PC)                  ; $0066A4
        JSR     loc_00764E(PC)                  ; $0066A8
        JSR     loc_008032(PC)                  ; $0066AC
        JMP     $009B54(PC)                     ; $0066B0
        JSR     $00B770(PC)                     ; $0066B4
        MOVEQ   #$00,D0                         ; $0066B8
        MOVE.W  D0,$0044(A0)                    ; $0066BA
        MOVE.W  D0,$0046(A0)                    ; $0066BE
        MOVE.W  D0,$004A(A0)                    ; $0066C2
        JSR     $00859A(PC)                     ; $0066C6
        JSR     $00A350(PC)                     ; $0066CA
        JSR     loc_008170(PC)                  ; $0066CE
        JSR     loc_0080CC(PC)                  ; $0066D2
        JSR     $008548(PC)                     ; $0066D6
        JSR     $009802(PC)                     ; $0066DA
        JSR     loc_007E7A(PC)                  ; $0066DE
        JSR     loc_006F98(PC)                  ; $0066E2
        JSR     loc_007CD8(PC)                  ; $0066E6
        JSR     $00A434(PC)                     ; $0066EA
        JSR     loc_0070AA(PC)                  ; $0066EE
        JSR     loc_007C4E(PC)                  ; $0066F2
        JSR     loc_00714A(PC)                  ; $0066F6
        JSR     loc_00764E(PC)                  ; $0066FA
        JSR     loc_008032(PC)                  ; $0066FE
        JSR     $00961E(PC)                     ; $006702
        JSR     $00A8F8(PC)                     ; $006706
        BTST    #4,$C30E.W                      ; $00670A
        BEQ.S  loc_006718                       ; $006710
        MOVE.W  $C08C.W,$C07A.W                 ; $006712
loc_006718:
        RTS                                     ; $006718
        JSR     $00B770(PC)                     ; $00671A
        MOVE.B  #$0001,$C800.W                  ; $00671E
        MOVEQ   #$00,D0                         ; $006724
        MOVE.W  D0,$0044(A0)                    ; $006726
        MOVE.W  D0,$0046(A0)                    ; $00672A
        MOVE.W  D0,$004A(A0)                    ; $00672E
        JSR     loc_0080CC(PC)                  ; $006732
        JSR     $008548(PC)                     ; $006736
        JSR     $009802(PC)                     ; $00673A
        JSR     loc_007E7A(PC)                  ; $00673E
        JSR     loc_006F98(PC)                  ; $006742
        JSR     loc_007CD8(PC)                  ; $006746
        JSR     loc_0070AA(PC)                  ; $00674A
        JSR     loc_00714A(PC)                  ; $00674E
        JSR     loc_00764E(PC)                  ; $006752
        JSR     loc_008032(PC)                  ; $006756
        JSR     $009B54(PC)                     ; $00675A
        CMPI.W  #$0014,$C8AA.W                  ; $00675E
        BNE.S  loc_006778                       ; $006764
        MOVE.W  $C092.W,$C07A.W                 ; $006766
        MOVE.B  #$0000,$C800.W                  ; $00676C
        MOVE.W  #$0030,$C8AC.W                  ; $006772
loc_006778:
        RTS                                     ; $006778
        MOVEQ   #$00,D0                         ; $00677A
        MOVE.W  D0,$0044(A0)                    ; $00677C
        MOVE.W  D0,$0046(A0)                    ; $006780
        MOVE.W  D0,$004A(A0)                    ; $006784
        MOVE.L  #$00100010,$C970.W              ; $006788
        MOVE.B  #$0000,$C30F.W                  ; $006790
        JSR     $00B770(PC)                     ; $006796
        MOVE.W  #$0002,$0092(A0)                ; $00679A
        JSR     $00859A(PC)                     ; $0067A0
        JSR     $00A350(PC)                     ; $0067A4
        JSR     loc_008170(PC)                  ; $0067A8
        JSR     loc_0080CC(PC)                  ; $0067AC
        JSR     $008548(PC)                     ; $0067B0
        JSR     $0094FA(PC)                     ; $0067B4
        JSR     $009312(PC)                     ; $0067B8
        JSR     $009B12(PC)                     ; $0067BC
        JSR     $009182(PC)                     ; $0067C0
        JSR     $00961E(PC)                     ; $0067C4
        JSR     $009688(PC)                     ; $0067C8
        JSR     $009802(PC)                     ; $0067CC
        JSR     loc_007E7A(PC)                  ; $0067D0
        JSR     loc_006F98(PC)                  ; $0067D4
        JSR     loc_007CD8(PC)                  ; $0067D8
        JSR     $00A434(PC)                     ; $0067DC
        JSR     loc_0070AA(PC)                  ; $0067E0
        JSR     loc_007C4E(PC)                  ; $0067E4
        JSR     loc_00714A(PC)                  ; $0067E8
        JSR     loc_00764E(PC)                  ; $0067EC
        JSR     loc_008032(PC)                  ; $0067F0
        JSR     $009B54(PC)                     ; $0067F4
        JSR     $0044E8(PC)                     ; $0067F8
        JSR     $003116(PC)                     ; $0067FC
        JMP     $00451C(PC)                     ; $006800
        JSR     $00B770(PC)                     ; $006804
        JSR     $00A350(PC)                     ; $006808
        JSR     loc_008170(PC)                  ; $00680C
        JSR     loc_0080CC(PC)                  ; $006810
        JSR     $008548(PC)                     ; $006814
        JSR     $00961E(PC)                     ; $006818
        JSR     loc_007816(PC)                  ; $00681C
        JSR     loc_00764E(PC)                  ; $006820
        JSR     loc_0070AA(PC)                  ; $006824
        JSR     $00A8E0(PC)                     ; $006828
        JSR     $009B54(PC)                     ; $00682C
        JSR     $009182(PC)                     ; $006830
        JSR     $009802(PC)                     ; $006834
        JSR     loc_00714A(PC)                  ; $006838
        JMP     $003CC4(PC)                     ; $00683C
        LEA     $A000.W,A4                      ; $006840
        LEA     $9000.W,A0                      ; $006844
        MOVE.W  #$0002,$00AC(A0)                ; $006848
        MOVE.B  $FEAA.W,$C30F.W                 ; $00684E
        JSR     loc_006BBE(PC)                  ; $006854
        MOVE.L  $00B2(A0),$0018(A0)             ; $006858
        MOVE.B  $00E5(A0),D1                    ; $00685E
        ANDI.B  #$0006,D1                       ; $006862
        BEQ.S  loc_00686E                       ; $006866
        MOVE.L  $C70C.W,$0018(A0)               ; $006868
loc_00686E:
        MOVE.W  $C07A.W,D0                      ; $00686E
        MOVEA.L $34(PC,D0.W),A1                 ; $006872
        JSR     (A1)                            ; $006876
        JSR     loc_007F04(PC)                  ; $006878
loc_00687C:
        JSR     $009040(PC)                     ; $00687C
        JSR     $00825C(PC)                     ; $006880
        JSR     $009EC0(PC)                     ; $006884
loc_006888:
        JSR     loc_0075FE(PC)                  ; $006888
        JSR     loc_0071A6(PC)                  ; $00688C
        JSR     $002984(PC)                     ; $006890
        JSR     $0034E8(PC)                     ; $006894
        JSR     $0037B6(PC)                     ; $006898
        JSR     $003F86(PC)                     ; $00689C
        JSR     $003CC4(PC)                     ; $0068A0
        JMP     loc_006BEA(PC)                  ; $0068A4
        ORI.L  #$68C80088,A0                    ; $0068A8
        BPL.S  loc_00687C                       ; $0068AE
        ORI.L  #$693E0088,A0                    ; $0068B0
        BVS.S  loc_006888                       ; $0068B6
        ORI.L  #$6A3A0088,A0                    ; $0068B8
        BPL.S  loc_0068F8                       ; $0068BE
        ORI.L  #$6B040088,A0                    ; $0068C0
        BVS.S  loc_006912                       ; $0068C6
        JSR     $00B770(PC)                     ; $0068C8
        MOVEQ   #$00,D0                         ; $0068CC
        MOVE.W  D0,$0044(A0)                    ; $0068CE
        MOVE.W  D0,$0046(A0)                    ; $0068D2
        MOVE.W  D0,$004A(A0)                    ; $0068D6
        JSR     $0085C4(PC)                     ; $0068DA
        JSR     $00859A(PC)                     ; $0068DE
        JSR     $00A350(PC)                     ; $0068E2
        JSR     loc_008170(PC)                  ; $0068E6
        JSR     loc_0080CC(PC)                  ; $0068EA
        JSR     $008548(PC)                     ; $0068EE
        JSR     $0094FA(PC)                     ; $0068F2
        JSR     $009312(PC)                     ; $0068F6
        JSR     $009B12(PC)                     ; $0068FA
        JSR     $009182(PC)                     ; $0068FE
        JSR     $00961E(PC)                     ; $006902
        JSR     $009688(PC)                     ; $006906
        JSR     $009802(PC)                     ; $00690A
        JSR     loc_007E7A(PC)                  ; $00690E
loc_006912:
        JSR     loc_006F98(PC)                  ; $006912
        JSR     loc_007CD8(PC)                  ; $006916
        JSR     $00A434(PC)                     ; $00691A
        JSR     loc_0070AA(PC)                  ; $00691E
        JSR     $009E6E(PC)                     ; $006922
        JSR     loc_007C4E(PC)                  ; $006926
        JSR     loc_00714A(PC)                  ; $00692A
        JSR     loc_00764E(PC)                  ; $00692E
        JSR     loc_007F50(PC)                  ; $006932
        JSR     $00AC3E(PC)                     ; $006936
        JMP     $009B54(PC)                     ; $00693A
        MOVE.W  #$0000,$0006(A0)                ; $00693E
        MOVE.W  #$0000,$0074(A0)                ; $006944
        JSR     $00B770(PC)                     ; $00694A
        MOVEQ   #$00,D0                         ; $00694E
        MOVE.W  D0,$0044(A0)                    ; $006950
        MOVE.W  D0,$0046(A0)                    ; $006954
        MOVE.W  D0,$004A(A0)                    ; $006958
        JSR     $004A0C(PC)                     ; $00695C
        JSR     $00859A(PC)                     ; $006960
        JSR     $00A350(PC)                     ; $006964
        JSR     loc_008170(PC)                  ; $006968
        JSR     loc_0080CC(PC)                  ; $00696C
        JSR     $008548(PC)                     ; $006970
        JSR     $0094FA(PC)                     ; $006974
        CMPI.W  #$0004,$C26C.W                  ; $006978
        BEQ.S  loc_006984                       ; $00697E
        JSR     $009312(PC)                     ; $006980
loc_006984:
        JSR     $009B12(PC)                     ; $006984
        JSR     $009182(PC)                     ; $006988
        JSR     $009802(PC)                     ; $00698C
        JSR     loc_007084(PC)                  ; $006990
        JSR     loc_0070AA(PC)                  ; $006994
        JSR     loc_007816(PC)                  ; $006998
        SUBQ.W  #1,$C02C.W                      ; $00699C
        BGT.S  loc_0069B4                       ; $0069A0
        MOVE.W  #$0000,$C02C.W                  ; $0069A2
        MOVE.W  #$0000,$0074(A0)                ; $0069A8
        MOVE.W  $C08C.W,$C07A.W                 ; $0069AE
loc_0069B4:
        JSR     $009E6E(PC)                     ; $0069B4
        JSR     loc_007C4E(PC)                  ; $0069B8
        JSR     loc_00714A(PC)                  ; $0069BC
        JSR     loc_00764E(PC)                  ; $0069C0
        JSR     loc_007F50(PC)                  ; $0069C4
        JSR     $00AC3E(PC)                     ; $0069C8
        JMP     $009B54(PC)                     ; $0069CC
        JSR     $00B770(PC)                     ; $0069D0
        MOVEQ   #$00,D0                         ; $0069D4
        MOVE.W  D0,$0044(A0)                    ; $0069D6
        MOVE.W  D0,$0046(A0)                    ; $0069DA
        MOVE.W  D0,$004A(A0)                    ; $0069DE
        JSR     $00859A(PC)                     ; $0069E2
        JSR     $00A350(PC)                     ; $0069E6
        JSR     loc_008170(PC)                  ; $0069EA
        JSR     loc_0080CC(PC)                  ; $0069EE
        JSR     $008548(PC)                     ; $0069F2
        JSR     $009802(PC)                     ; $0069F6
        JSR     loc_007E7A(PC)                  ; $0069FA
        JSR     loc_006F98(PC)                  ; $0069FE
        JSR     loc_007CD8(PC)                  ; $006A02
        JSR     $00A434(PC)                     ; $006A06
        JSR     loc_0070AA(PC)                  ; $006A0A
        JSR     $009E6E(PC)                     ; $006A0E
        JSR     loc_007C4E(PC)                  ; $006A12
        JSR     loc_00714A(PC)                  ; $006A16
        JSR     loc_00764E(PC)                  ; $006A1A
        JSR     loc_007F50(PC)                  ; $006A1E
        JSR     $00961E(PC)                     ; $006A22
        JSR     $00A8F8(PC)                     ; $006A26
        BTST    #4,$C30E.W                      ; $006A2A
        BEQ.S  loc_006A38                       ; $006A30
        MOVE.W  $C08C.W,$C07A.W                 ; $006A32
loc_006A38:
        RTS                                     ; $006A38
        JSR     $00B770(PC)                     ; $006A3A
        MOVE.B  #$0001,$C800.W                  ; $006A3E
        MOVEQ   #$00,D0                         ; $006A44
        MOVE.W  D0,$0044(A0)                    ; $006A46
        MOVE.W  D0,$0046(A0)                    ; $006A4A
        MOVE.W  D0,$004A(A0)                    ; $006A4E
        JSR     loc_0080CC(PC)                  ; $006A52
        JSR     $008548(PC)                     ; $006A56
        JSR     $009802(PC)                     ; $006A5A
        JSR     loc_007E7A(PC)                  ; $006A5E
        JSR     loc_006F98(PC)                  ; $006A62
        JSR     loc_007CD8(PC)                  ; $006A66
        JSR     loc_0070AA(PC)                  ; $006A6A
        JSR     loc_00714A(PC)                  ; $006A6E
        JSR     loc_00764E(PC)                  ; $006A72
        JSR     loc_007F50(PC)                  ; $006A76
        JSR     $00AC3E(PC)                     ; $006A7A
        JSR     $009B54(PC)                     ; $006A7E
        MOVE.W  $C8A0.W,D0                      ; $006A82
        MOVEA.L $2C(PC,D0.W),A1                 ; $006A86
        JSR     (A1)                            ; $006A8A
        CMPI.W  #$0014,$C8AA.W                  ; $006A8C
        BNE.S  loc_006AB2                       ; $006A92
        MOVE.W  $C092.W,$C07A.W                 ; $006A94
        MOVE.B  #$0000,$C800.W                  ; $006A9A
        MOVE.W  #$0004,$C8AC.W                  ; $006AA0
        TST.W  $C89C.W                          ; $006AA6
        BEQ.S  loc_006AB2                       ; $006AAA
        MOVE.W  #$0020,$C8AC.W                  ; $006AAC
loc_006AB2:
        RTS                                     ; $006AB2
        ORI.L  #$3C7E0088,A0                    ; $006AB4
        MOVE.W  (A2)+,$0088(A6)                 ; $006ABA
        MOVE.W  (A2)+,$0088(A6)                 ; $006ABE
        MOVE.W  (A2)+,$0088(A6)                 ; $006AC2
        MOVE.W  (A2)+,$0088(A6)                 ; $006AC6
        MOVE.W  (A2)+,$4EBA(A6)                 ; $006ACA
        MOVEM.W D1/D4/D5/D6/A0/A2/A3/A4/A6,-(A2); $006ACE
        MOVEA.W <EA:3E>,A4                      ; $006AD2
        JSR     loc_008170(PC)                  ; $006AD4
        JSR     loc_0080CC(PC)                  ; $006AD8
        JSR     $008548(PC)                     ; $006ADC
        JSR     $00961E(PC)                     ; $006AE0
        JSR     loc_007816(PC)                  ; $006AE4
        JSR     loc_00764E(PC)                  ; $006AE8
        JSR     loc_0070AA(PC)                  ; $006AEC
        JSR     $00A8E0(PC)                     ; $006AF0
        JSR     $009B54(PC)                     ; $006AF4
        JSR     $009182(PC)                     ; $006AF8
        JSR     $009802(PC)                     ; $006AFC
        JMP     loc_00714A(PC)                  ; $006B00
        MOVEQ   #$00,D0                         ; $006B04
        MOVE.W  D0,$0044(A0)                    ; $006B06
        MOVE.W  D0,$0046(A0)                    ; $006B0A
        MOVE.W  D0,$004A(A0)                    ; $006B0E
        MOVE.L  #$00100010,$C970.W              ; $006B12
        MOVE.B  #$0000,$C30F.W                  ; $006B1A
        JSR     $00B770(PC)                     ; $006B20
        MOVE.W  #$0002,$0092(A0)                ; $006B24
        JSR     $00859A(PC)                     ; $006B2A
        JSR     $00A350(PC)                     ; $006B2E
        JSR     loc_008170(PC)                  ; $006B32
        JSR     loc_0080CC(PC)                  ; $006B36
        JSR     $008548(PC)                     ; $006B3A
        JSR     $0094FA(PC)                     ; $006B3E
        JSR     $009312(PC)                     ; $006B42
        JSR     $009B12(PC)                     ; $006B46
        JSR     $009182(PC)                     ; $006B4A
        JSR     $00961E(PC)                     ; $006B4E
        JSR     $009688(PC)                     ; $006B52
        JSR     $009802(PC)                     ; $006B56
        JSR     loc_007E7A(PC)                  ; $006B5A
        JSR     loc_006F98(PC)                  ; $006B5E
        JSR     loc_007CD8(PC)                  ; $006B62
        JSR     $00A434(PC)                     ; $006B66
        JSR     loc_0070AA(PC)                  ; $006B6A
        JSR     loc_007C4E(PC)                  ; $006B6E
        JSR     loc_00714A(PC)                  ; $006B72
        JSR     loc_00764E(PC)                  ; $006B76
        JSR     loc_007F50(PC)                  ; $006B7A
        JSR     $009B54(PC)                     ; $006B7E
        JSR     $00476A(PC)                     ; $006B82
        JMP     $003116(PC)                     ; $006B86
loc_006B8A:
        MOVE.W  $C07A.W,D0                      ; $006B8A
        MOVE.W  $06(PC,D0.W),$C26C.W            ; $006B8E
        RTS                                     ; $006B94
        ORI.B  #$0001,D1                        ; $006B96
        ORI.B  #$0002,D2                        ; $006B9A
        ORI.B  #$0004,D4                        ; $006B9E
        ORI.B  #$0008,A0                        ; $006BA2
        ORI.B  #$0010,(A0)                      ; $006BA6
        ORI.B  #$0020,-(A0)                     ; $006BAA
        ORI.W  #$0040,D0                        ; $006BAE
        ORI.L  #$00800100,D0                    ; $006BB2
        BTST    D0,D0                           ; $006BB8
        ANDI.B  #$0200,D0                       ; $006BBA
loc_006BBE:
        MOVE.W  $C07A.W,D0                      ; $006BBE
        MOVE.W  $06(PC,D0.W),$C26C.W            ; $006BC2
        RTS                                     ; $006BC8
        ORI.B  #$0001,D1                        ; $006BCA
        ORI.B  #$0002,D2                        ; $006BCE
        ORI.B  #$0004,D4                        ; $006BD2
        ORI.B  #$0008,A0                        ; $006BD6
        ORI.B  #$0010,(A0)                      ; $006BDA
        ORI.B  #$0020,-(A0)                     ; $006BDE
        ORI.W  #$0040,D0                        ; $006BE2
        ORI.L  #$00801038,D0                    ; $006BE6
        AND.B  D1,A6                            ; $006BEC
        ANDI.B  #$0021,D0                       ; $006BEE
        BEQ.S  loc_006C06                       ; $006BF2
        BCLR    #4,$C30E.W                      ; $006BF4
        BTST    #5,D0                           ; $006BFA
        BEQ.S  loc_006C06                       ; $006BFE
        MOVE.W  $C098.W,$C07A.W                 ; $006C00
loc_006C06:
        RTS                                     ; $006C06
        MOVE.B  $C30E.W,D0                      ; $006C08
        ANDI.B  #$0021,D0                       ; $006C0C
        BEQ.S  loc_006C26                       ; $006C10
        BCLR    #4,$C30E.W                      ; $006C12
        BTST    #5,D0                           ; $006C18
        BEQ.S  loc_006C26                       ; $006C1C
        MOVE.W  $C098.W,$C07A.W                 ; $006C1E
        RTS                                     ; $006C24
loc_006C26:
        MOVE.W  $C050.W,D0                      ; $006C26
        BPL.S  loc_006C44                       ; $006C2A
        BSET    #0,$C30E.W                      ; $006C2C
        MOVE.W  $C096.W,$C07A.W                 ; $006C32
        MOVE.W  #$0014,$C07C.W                  ; $006C38
        MOVE.W  #$0000,$C050.W                  ; $006C3E
loc_006C44:
        RTS                                     ; $006C44
loc_006C46:
        MOVE.L  A4,-(A7)                        ; $006C46
        MOVE.W  #$0001,$00FF3000                ; $006C48
        LEA     $0089B844,A1                    ; $006C50
        LEA     $00FF304A,A2                    ; $006C56
        LEA     $00FF301A,A3                    ; $006C5C
        LEA     $00FF3002,A4                    ; $006C62
        MOVEQ   #$05,D5                         ; $006C68
loc_006C6A:
        MOVEQ   #$01,D6                         ; $006C6A
loc_006C6C:
        MOVE.L  A2,(A3)+                        ; $006C6C
        MOVE.W  (A1),D7                         ; $006C6E
        MOVE.W  (A1)+,(A2)+                     ; $006C70
loc_006C72:
        JSR     $004922(PC)                     ; $006C72
        DBRA    D7,loc_006C72                   ; $006C76
        DBRA    D6,loc_006C6C                   ; $006C7A
        MOVE.L  A2,(A4)+                        ; $006C7E
        DBRA    D5,loc_006C6A                   ; $006C80
        MOVEA.L (A7)+,A4                        ; $006C84
        RTS                                     ; $006C86
        TST.W  $00FF3000                        ; $006C88
        BNE.S  loc_006C94                       ; $006C8E
        JSR     loc_006C46(PC)                  ; $006C90
loc_006C94:
        MOVE.B  $C86E.W,D1                      ; $006C94
        MOVEQ   #$30,D0                         ; $006C98
        BTST    #6,D1                           ; $006C9A
        BNE.S  loc_006CA2                       ; $006C9E
        MOVEQ   #$08,D0                         ; $006CA0
loc_006CA2:
        BTST    #2,D1                           ; $006CA2
        BNE.W  loc_006D38                       ; $006CA6
        BTST    #3,D1                           ; $006CAA
        BNE.W  loc_006D3E                       ; $006CAE
        BTST    #1,D1                           ; $006CB2
        BNE.W  loc_006D44                       ; $006CB6
        BTST    #0,D1                           ; $006CBA
        BNE.W  loc_006D4A                       ; $006CBE
        BTST    #4,D1                           ; $006CC2
        BNE.W  loc_006D50                       ; $006CC6
        BTST    #5,D1                           ; $006CCA
        BNE.W  loc_006D6E                       ; $006CCE
        BTST    #7,D1                           ; $006CD2
        BNE.W  loc_006D8C                       ; $006CD6
        RTS                                     ; $006CDA
        BSR.S  loc_006D00                       ; $006CDC
        BEQ.S  loc_006CFE                       ; $006CDE
        ADD.W  D0,(A1)                          ; $006CE0
        RTS                                     ; $006CE2
        BSR.S  loc_006D00                       ; $006CE4
        BEQ.S  loc_006CFE                       ; $006CE6
        SUB.W  D0,(A1)                          ; $006CE8
        RTS                                     ; $006CEA
        BSR.S  loc_006D00                       ; $006CEC
        BEQ.S  loc_006CFE                       ; $006CEE
        ADD.W  D0,$0004(A1)                     ; $006CF0
        RTS                                     ; $006CF4
        BSR.S  loc_006D00                       ; $006CF6
        BEQ.S  loc_006CFE                       ; $006CF8
        SUB.W  D0,$0004(A1)                     ; $006CFA
loc_006CFE:
        RTS                                     ; $006CFE
loc_006D00:
        MOVEQ   #$00,D7                         ; $006D00
        BTST    #2,$C313.W                      ; $006D02
        BEQ.S  loc_006D0C                       ; $006D08
        MOVEQ   #$04,D7                         ; $006D0A
loc_006D0C:
        ADD.W  $C8A0.W,D7                       ; $006D0C
        ADD.W  $C8A0.W,D7                       ; $006D10
        LEA     $00FF301A,A2                    ; $006D14
        MOVEA.L $00(A2,D7.W),A1                 ; $006D1A
        MOVE.W  $C0BA.W,D1                      ; $006D1E
        MOVE.W  (A1)+,D7                        ; $006D22
loc_006D24:
        CMP.W  (A1),D1                          ; $006D24
        BEQ.S  loc_006D34                       ; $006D26
        LEA     $0010(A1),A1                    ; $006D28
        DBRA    D7,loc_006D24                   ; $006D2C
        MOVEQ   #$00,D1                         ; $006D30
        RTS                                     ; $006D32
loc_006D34:
        MOVEQ   #$01,D1                         ; $006D34
        RTS                                     ; $006D36
loc_006D38:
        SUB.W  D0,$0030(A0)                     ; $006D38
        RTS                                     ; $006D3C
loc_006D3E:
        ADD.W  D0,$0030(A0)                     ; $006D3E
        RTS                                     ; $006D42
loc_006D44:
        SUB.W  D0,$0034(A0)                     ; $006D44
        RTS                                     ; $006D48
loc_006D4A:
        ADD.W  D0,$0034(A0)                     ; $006D4A
        RTS                                     ; $006D4E
loc_006D50:
        ADDQ.W  #1,$001C(A0)                    ; $006D50
        MOVE.W  $001C(A0),D0                    ; $006D54
        MOVEA.L $C700.W,A2                      ; $006D58
        ADD.W  D0,D0                            ; $006D5C
        ADD.W  D0,D0                            ; $006D5E
        MOVE.W  $00(A2,D0.W),$0030(A0)          ; $006D60
        MOVE.W  $02(A2,D0.W),$0034(A0)          ; $006D66
        RTS                                     ; $006D6C
loc_006D6E:
        SUBQ.W  #1,$001C(A0)                    ; $006D6E
        MOVE.W  $001C(A0),D0                    ; $006D72
        MOVEA.L $C700.W,A2                      ; $006D76
        ADD.W  D0,D0                            ; $006D7A
        ADD.W  D0,D0                            ; $006D7C
        MOVE.W  $00(A2,D0.W),$0030(A0)          ; $006D7E
        MOVE.W  $02(A2,D0.W),$0034(A0)          ; $006D84
        RTS                                     ; $006D8A
loc_006D8C:
        MOVEM.L -(A7),D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6/A7; $006D8C
        JSR     $00886F98                       ; $006D90
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,(A7)+; $006D96
        RTS                                     ; $006D9A
        JSR     loc_006B8A(PC)                  ; $006D9C
        LEA     $A000.W,A4                      ; $006DA0
        MOVE.B  #$0000,$00FF5FFE                ; $006DA4
        LEA     $9100.W,A0                      ; $006DAC
        JSR     $0059EC(PC)                     ; $006DB0
        JSR     $0059EC(PC)                     ; $006DB4
        JSR     $0059EC(PC)                     ; $006DB8
        JSR     $0059EC(PC)                     ; $006DBC
        JSR     $0059EC(PC)                     ; $006DC0
        JMP     $0059EC(PC)                     ; $006DC4
        LEA     $A000.W,A4                      ; $006DC8
        LEA     $9700.W,A0                      ; $006DCC
        JSR     $0059EC(PC)                     ; $006DD0
loc_006DD4:
        JSR     $0059EC(PC)                     ; $006DD4
        JSR     $0059EC(PC)                     ; $006DD8
        JSR     $0059EC(PC)                     ; $006DDC
        JSR     $0059EC(PC)                     ; $006DE0
        JSR     $0059EC(PC)                     ; $006DE4
        JSR     $0059EC(PC)                     ; $006DE8
        JMP     $0059EC(PC)                     ; $006DEC
        LEA     $A000.W,A4                      ; $006DF0
        LEA     $9F00.W,A0                      ; $006DF4
        JSR     $0059EC(PC)                     ; $006DF8
        LEA     $9000.W,A0                      ; $006DFC
        MOVE.L  $00B2(A0),$0018(A0)             ; $006E00
        MOVE.B  $00E5(A0),D1                    ; $006E06
        ANDI.B  #$0006,D1                       ; $006E0A
        BEQ.S  loc_006E16                       ; $006E0E
        MOVE.L  $C70C.W,$0018(A0)               ; $006E10
loc_006E16:
        MOVE.W  $C07A.W,D0                      ; $006E16
        MOVEA.L $04(PC,D0.W),A1                 ; $006E1A
        JMP     (A1)                            ; $006E1E
        ORI.L  #$6E480088,A0                    ; $006E20
        SUBQ.L  #7,(A2)+                        ; $006E26
        ORI.L  #$6EBE0088,A0                    ; $006E28
        BRA.S  loc_006E04                       ; $006E2E
        ORI.L  #$617A0088,A0                    ; $006E30
        SLT     -(A0)                           ; $006E36
        ORI.L  #$62920088,A0                    ; $006E38
        BLS.S  loc_006DD4                       ; $006E3E
        ORI.L  #$633A0088,A0                    ; $006E40
        BGT.S  loc_006E12                       ; $006E46
        MOVEQ   #$00,D0                         ; $006E48
        MOVE.W  D0,$0044(A0)                    ; $006E4A
        MOVE.W  D0,$0046(A0)                    ; $006E4E
        MOVE.W  D0,$004A(A0)                    ; $006E52
        JSR     $00A350(PC)                     ; $006E56
        JSR     loc_008170(PC)                  ; $006E5A
        JSR     loc_0080CC(PC)                  ; $006E5E
        JSR     $008548(PC)                     ; $006E62
        JSR     $0094FA(PC)                     ; $006E66
        JSR     $009312(PC)                     ; $006E6A
        JSR     $009B12(PC)                     ; $006E6E
        JSR     $009182(PC)                     ; $006E72
        JSR     $00961E(PC)                     ; $006E76
        JSR     $009688(PC)                     ; $006E7A
        JSR     $009802(PC)                     ; $006E7E
        JSR     loc_007E7A(PC)                  ; $006E82
        JSR     loc_006F98(PC)                  ; $006E86
        JSR     loc_007CD8(PC)                  ; $006E8A
        JSR     $00A434(PC)                     ; $006E8E
        JSR     loc_0070AA(PC)                  ; $006E92
        JSR     loc_007F04(PC)                  ; $006E96
        JSR     $009E6E(PC)                     ; $006E9A
        JSR     loc_007C4E(PC)                  ; $006E9E
        JSR     loc_00714A(PC)                  ; $006EA2
        JSR     loc_00764E(PC)                  ; $006EA6
        JSR     loc_007F50(PC)                  ; $006EAA
        JSR     $009CCE(PC)                     ; $006EAE
        JSR     $009B54(PC)                     ; $006EB2
        JSR     $0086C8(PC)                     ; $006EB6
        JMP     $00ACD4(PC)                     ; $006EBA
        MOVE.W  #$0000,$0006(A0)                ; $006EBE
        MOVE.W  #$0000,$0074(A0)                ; $006EC4
        MOVEQ   #$00,D0                         ; $006ECA
        MOVE.W  D0,$0044(A0)                    ; $006ECC
        MOVE.W  D0,$0046(A0)                    ; $006ED0
        MOVE.W  D0,$004A(A0)                    ; $006ED4
        JSR     $0049EE(PC)                     ; $006ED8
        JSR     $00859A(PC)                     ; $006EDC
        JSR     $00A350(PC)                     ; $006EE0
        JSR     loc_008170(PC)                  ; $006EE4
        JSR     loc_0080CC(PC)                  ; $006EE8
        JSR     $008548(PC)                     ; $006EEC
        JSR     $0094FA(PC)                     ; $006EF0
        CMPI.W  #$0004,$C26C.W                  ; $006EF4
        BEQ.S  loc_006F00                       ; $006EFA
        JSR     $009312(PC)                     ; $006EFC
loc_006F00:
        JSR     $009B12(PC)                     ; $006F00
        JSR     $009182(PC)                     ; $006F04
        JSR     $009802(PC)                     ; $006F08
        JSR     loc_007084(PC)                  ; $006F0C
        JSR     loc_0070AA(PC)                  ; $006F10
        JSR     loc_007816(PC)                  ; $006F14
        SUBQ.W  #1,$C02C.W                      ; $006F18
        BGT.S  loc_006F30                       ; $006F1C
        MOVE.W  #$0000,$C02C.W                  ; $006F1E
        MOVE.W  #$0000,$0074(A0)                ; $006F24
        MOVE.W  $C08C.W,$C07A.W                 ; $006F2A
loc_006F30:
        JSR     loc_007F04(PC)                  ; $006F30
        JSR     $009E6E(PC)                     ; $006F34
        JSR     loc_007C4E(PC)                  ; $006F38
        JSR     loc_00714A(PC)                  ; $006F3C
        JSR     loc_00764E(PC)                  ; $006F40
        JSR     loc_007F50(PC)                  ; $006F44
        JSR     $009CCE(PC)                     ; $006F48
        JSR     $00AC3E(PC)                     ; $006F4C
        JSR     $009B54(PC)                     ; $006F50
        JSR     $0086C8(PC)                     ; $006F54
        JMP     $00ACD4(PC)                     ; $006F58
        MOVE.L  A4,-(A7)                        ; $006F5C
        MOVE.W  #$0001,$00FF3000                ; $006F5E
        LEA     $0089C064,A1                    ; $006F66
        LEA     $00FF3022,A2                    ; $006F6C
        LEA     $00FF301A,A3                    ; $006F72
        LEA     $00FF3002,A4                    ; $006F78
        MOVEQ   #$01,D6                         ; $006F7E
loc_006F80:
        MOVE.L  A2,(A3)+                        ; $006F80
        MOVE.W  (A1),D7                         ; $006F82
        MOVE.W  (A1)+,(A2)+                     ; $006F84
loc_006F86:
        JSR     $004922(PC)                     ; $006F86
        DBRA    D7,loc_006F86                   ; $006F8A
        DBRA    D6,loc_006F80                   ; $006F8E
        MOVE.L  A2,(A4)+                        ; $006F92
        MOVEA.L (A7)+,A4                        ; $006F94
        RTS                                     ; $006F96
loc_006F98:
        TST.W  $0062(A0)                        ; $006F98
        BNE.S  loc_006FD6                       ; $006F9C
        TST.W  $0092(A0)                        ; $006F9E
        BGT.S  loc_006FCE                       ; $006FA2
        MOVE.W  $003C(A0),D0                    ; $006FA4
        ADD.W  $0096(A0),D0                     ; $006FA8
        MOVE.W  D0,$0040(A0)                    ; $006FAC
        NEG.W  D0                               ; $006FB0
        MOVE.W  $0006(A0),D2                    ; $006FB2
        MOVE.W  $0030(A0),D3                    ; $006FB6
        MOVE.W  $0034(A0),D4                    ; $006FBA
        JSR     loc_006FDE(PC)                  ; $006FBE
        MOVE.W  D3,$0030(A0)                    ; $006FC2
        MOVE.W  D4,$0034(A0)                    ; $006FC6
        JMP     loc_007700(PC)                  ; $006FCA
loc_006FCE:
        JSR     loc_006FFA(PC)                  ; $006FCE
        JMP     loc_007816(PC)                  ; $006FD2
loc_006FD6:
        JSR     loc_007008(PC)                  ; $006FD6
        JMP     loc_007816(PC)                  ; $006FDA
loc_006FDE:
        MOVEQ   #$0C,D6                         ; $006FDE
        MOVE.W  D0,D5                           ; $006FE0
        JSR     $008F52(PC)                     ; $006FE2
        MULS    D2,D0                           ; $006FE6
        ASR.L  D6,D0                            ; $006FE8
        ADD.W  D0,D3                            ; $006FEA
        MOVE.W  D5,D0                           ; $006FEC
        JSR     $008F4E(PC)                     ; $006FEE
        MULS    D2,D0                           ; $006FF2
        ASR.L  D6,D0                            ; $006FF4
        ADD.W  D0,D4                            ; $006FF6
        RTS                                     ; $006FF8
loc_006FFA:
        SUBQ.W  #1,$0092(A0)                    ; $006FFA
        TST.W  $0006(A0)                        ; $006FFE
        BNE.W  $00A470                          ; $007002
        RTS                                     ; $007006
loc_007008:
        MOVEQ   #$01,D0                         ; $007008
        TST.W  $0072(A0)                        ; $00700A
        BGT.S  loc_007016                       ; $00700E
        BMI.S  loc_007014                       ; $007010
        MOVEQ   #$00,D0                         ; $007012
loc_007014:
        NEG.W  D0                               ; $007014
loc_007016:
        CMP.W  $0068(A0),D0                     ; $007016
        BNE.S  loc_007034                       ; $00701A
        MOVE.W  $0066(A0),D0                    ; $00701C
        MOVE.W  D0,D1                           ; $007020
        ASR.W  #3,D0                            ; $007022
        SUB.W  D0,$003C(A0)                     ; $007024
        MOVE.W  $003C(A0),D0                    ; $007028
        SUB.W  D1,D0                            ; $00702C
        MOVE.W  D0,$0040(A0)                    ; $00702E
        BRA.S  loc_00705A                       ; $007032
loc_007034:
        MOVE.W  $001E(A0),D0                    ; $007034
        MOVE.W  D0,D1                           ; $007038
        SUB.W  $003C(A0),D1                     ; $00703A
        ASR.W  #1,D1                            ; $00703E
        ADD.W  D1,$003C(A0)                     ; $007040
        MOVE.W  D0,D1                           ; $007044
        SUB.W  $0040(A0),D1                     ; $007046
        ASR.W  #1,D1                            ; $00704A
        ADD.W  D1,$0040(A0)                     ; $00704C
        SUB.W  $0064(A0),D0                     ; $007050
        ASR.W  #1,D0                            ; $007054
        ADD.W  D0,$0064(A0)                     ; $007056
loc_00705A:
        MOVE.W  $0064(A0),D0                    ; $00705A
        NEG.W  D0                               ; $00705E
        MOVE.W  #$01AB,D3                       ; $007060
        MOVEQ   #$0C,D6                         ; $007064
        MOVE.W  D0,D2                           ; $007066
        JSR     $008F52(PC)                     ; $007068
        MULS    D3,D0                           ; $00706C
        ASR.L  D6,D0                            ; $00706E
        ADD.W  D0,$0030(A0)                     ; $007070
        MOVE.W  D2,D0                           ; $007074
        JSR     $008F4E(PC)                     ; $007076
        MULS    D3,D0                           ; $00707A
        ASR.L  D6,D0                            ; $00707C
        ADD.W  D0,$0034(A0)                     ; $00707E
        RTS                                     ; $007082
loc_007084:
        MOVE.W  $0052(A0),D0                    ; $007084
        ADD.W  D0,$003C(A0)                     ; $007088
        MOVE.W  $003C(A0),D0                    ; $00708C
        ADD.W  $0096(A0),D0                     ; $007090
        MOVE.W  D0,$0040(A0)                    ; $007094
        MOVE.W  $004E(A0),D0                    ; $007098
        ADD.W  D0,$0030(A0)                     ; $00709C
        MOVE.W  $0050(A0),D0                    ; $0070A0
        ADD.W  D0,$0034(A0)                     ; $0070A4
        RTS                                     ; $0070A8
loc_0070AA:
        LEA     $0093A02C,A1                    ; $0070AA
        MOVE.W  $005C(A0),D0                    ; $0070B0
        SUB.W  $005A(A0),D0                     ; $0070B4
        ADD.W  D0,D0                            ; $0070B8
        BMI.S  loc_0070C6                       ; $0070BA
        ANDI.W  #$03FF,D0                       ; $0070BC
        MOVE.W  $00(A1,D0.W),D0                 ; $0070C0
        BRA.S  loc_0070D2                       ; $0070C4
loc_0070C6:
        NEG.W  D0                               ; $0070C6
        ANDI.W  #$03FF,D0                       ; $0070C8
        MOVE.W  $00(A1,D0.W),D0                 ; $0070CC
        NEG.W  D0                               ; $0070D0
loc_0070D2:
        MOVE.W  D0,$003E(A0)                    ; $0070D2
        LEA     $0093A42C,A1                    ; $0070D6
        MOVE.W  $005E(A0),D0                    ; $0070DC
        SUB.W  $005A(A0),D0                     ; $0070E0
        ADD.W  D0,D0                            ; $0070E4
        BMI.S  loc_0070F2                       ; $0070E6
        ANDI.W  #$03FF,D0                       ; $0070E8
        MOVE.W  $00(A1,D0.W),D0                 ; $0070EC
        BRA.S  loc_0070FE                       ; $0070F0
loc_0070F2:
        NEG.W  D0                               ; $0070F2
        ANDI.W  #$03FF,D0                       ; $0070F4
        MOVE.W  $00(A1,D0.W),D0                 ; $0070F8
        NEG.W  D0                               ; $0070FC
loc_0070FE:
        MOVE.W  D0,$003A(A0)                    ; $0070FE
        MOVE.W  $008E(A0),D0                    ; $007102
        NEG.W  D0                               ; $007106
        MULS    $0004(A0),D0                    ; $007108
        MOVEQ   #$0F,D1                         ; $00710C
        ASR.L  D1,D0                            ; $00710E
        ADD.W  $00A2(A0),D0                     ; $007110
        MOVE.W  D0,$004A(A0)                    ; $007114
        MOVE.W  $009E(A0),$0044(A0)             ; $007118
        MOVE.W  $00A0(A0),D0                    ; $00711E
        BNE.S  loc_00712E                       ; $007122
        MOVE.W  $0094(A0),D0                    ; $007124
        ASL.W  #3,D0                            ; $007128
        ADD.W  $006E(A0),D0                     ; $00712A
loc_00712E:
        ADD.W  $004C(A0),D0                     ; $00712E
        MOVE.W  D0,$0046(A0)                    ; $007132
        MOVE.W  $008E(A0),D0                    ; $007136
        ASR.W  #8,D0                            ; $00713A
        NEG.W  D0                               ; $00713C
        MULS    $0004(A0),D0                    ; $00713E
        ASR.L  #5,D0                            ; $007142
        MOVE.W  D0,$004C(A0)                    ; $007144
        RTS                                     ; $007148
loc_00714A:
        MOVEQ   #$00,D0                         ; $00714A
        MOVEA.L $00CE(A0),A1                    ; $00714C
        MOVE.B  $001B(A1),D0                    ; $007150
        MOVE.B  D0,$001D(A0)                    ; $007154
        MOVE.B  $0025(A0),$0027(A0)             ; $007158
        MOVEA.L $C704.W,A2                      ; $00715E
        MOVE.B  $00(A2,D0.W),D1                 ; $007162
        MOVE.B  D1,$0025(A0)                    ; $007166
        MOVEA.L $C700.W,A2                      ; $00716A
        ADD.W  D0,D0                            ; $00716E
        ADD.W  D0,D0                            ; $007170
        MOVE.W  $00(A2,D0.W),$0020(A0)          ; $007172
        MOVE.W  $02(A2,D0.W),$0022(A0)          ; $007178
        MOVE.W  $001A(A1),D1                    ; $00717E
        ANDI.W  #$FF00,D1                       ; $007182
        MOVE.W  D1,$001E(A0)                    ; $007186
        MOVE.B  $0019(A1),$00E5(A0)             ; $00718A
        MOVE.B  #$0000,$00E4(A0)                ; $007190
        BTST    #0,$00E5(A0)                    ; $007196
        BEQ.S  loc_0071A4                       ; $00719C
        MOVE.B  #$0001,$00E4(A0)                ; $00719E
loc_0071A4:
        RTS                                     ; $0071A4
loc_0071A6:
        MOVE.L  A4,-(A7)                        ; $0071A6
        MOVE.W  #$0400,D1                       ; $0071A8
        MOVE.W  $0030(A0),D2                    ; $0071AC
        ASR.W  #4,D2                            ; $0071B0
        ADD.W  D1,D2                            ; $0071B2
        ASR.W  #6,D2                            ; $0071B4
        MOVE.W  $0034(A0),D3                    ; $0071B6
        ASR.W  #4,D3                            ; $0071BA
        SUB.W  D3,D1                            ; $0071BC
        ANDI.W  #$FFC0,D1                       ; $0071BE
        ASR.W  #1,D1                            ; $0071C2
        ADD.W  D2,D1                            ; $0071C4
        ADD.W  D1,D1                            ; $0071C6
        ADD.W  D1,D1                            ; $0071C8
        MOVE.W  D1,$00CA(A0)                    ; $0071CA
        MOVEQ   #$00,D0                         ; $0071CE
        MOVE.W  $00CC(A0),D0                    ; $0071D0
        ASL.L  #6,D0                            ; $0071D4
        SWAP    D0                              ; $0071D6
        ANDI.W  #$003C,D0                       ; $0071D8
        LEA     $0089A0D4,A3                    ; $0071DC
        MOVE.W  $C8A0.W,D2                      ; $0071E2
        CMPI.W  #$0004,D2                       ; $0071E6
        BNE.S  loc_007202                       ; $0071EA
        CMPI.B  #$0088,$001D(A0)                ; $0071EC
        BLT.S  loc_007202                       ; $0071F2
        CMPI.B  #$0098,$001D(A0)                ; $0071F4
        BGT.S  loc_007202                       ; $0071FA
        LEA     $0089A434,A3                    ; $0071FC
loc_007202:
        MOVEA.L $00(A3,D0.W),A3                 ; $007202
        MOVE.L  #$2207FFFE,D3                   ; $007206
        LEA     $003A(PC),A1                    ; $00720C
        MOVEA.L $00(A1,D2.W),A1                 ; $007210
        LEA     $00FF6000,A2                    ; $007214
        MOVEQ   #$00,D4                         ; $00721A
        MOVEA.L $00(A1,D1.W),A4                 ; $00721C
        CMPA.L  D3,A4                           ; $007220
        BEQ.S  loc_007228                       ; $007222
        MOVE.L  A4,(A2)+                        ; $007224
        ADDQ.W  #1,D4                           ; $007226
loc_007228:
        MOVE.W  (A3)+,D7                        ; $007228
loc_00722A:
        MOVE.W  D1,D0                           ; $00722A
        ADD.W  (A3)+,D0                         ; $00722C
        MOVEA.L $00(A1,D0.W),A4                 ; $00722E
        CMPA.L  D3,A4                           ; $007232
        BEQ.S  loc_00723A                       ; $007234
        MOVE.L  A4,(A2)+                        ; $007236
        ADDQ.W  #1,D4                           ; $007238
loc_00723A:
        DBRA    D7,loc_00722A                   ; $00723A
        MOVE.W  D4,$00FF610E                    ; $00723E
        MOVEA.L (A7)+,A4                        ; $007244
        RTS                                     ; $007246
        ORI.L  #$C0000095,(A5)                  ; $007248
        ADD.B  D0,D0                            ; $00724E
        ORI.L  #$E0000095,(A5)                  ; $007250
        MOVE.W  D0,D0                           ; $007256
        ORI.L  #$10000096,(A6)                  ; $007258
        MOVE.B  D0,D0                           ; $00725E
loc_007260:
        LEA     $00FF6000,A2                    ; $007260
        BSR.S  loc_007280                       ; $007266
        MOVE.W  D4,$00FF610E                    ; $007268
        RTS                                     ; $00726E
loc_007270:
        LEA     $00FF6064,A2                    ; $007270
        BSR.S  loc_007280                       ; $007276
        MOVE.W  D4,$00FF633E                    ; $007278
        RTS                                     ; $00727E
loc_007280:
        MOVE.L  A4,-(A7)                        ; $007280
        MOVE.W  #$0400,D1                       ; $007282
        MOVE.W  $0030(A0),D2                    ; $007286
        ASR.W  #4,D2                            ; $00728A
        ADD.W  D1,D2                            ; $00728C
        MOVE.W  D2,D3                           ; $00728E
        MOVEQ   #$00,D6                         ; $007290
        ANDI.W  #$0020,D3                       ; $007292
        BNE.S  loc_00729A                       ; $007296
        MOVEQ   #$01,D6                         ; $007298
loc_00729A:
        ASR.W  #6,D2                            ; $00729A
        MOVE.W  $0034(A0),D3                    ; $00729C
        ASR.W  #4,D3                            ; $0072A0
        SUB.W  D3,D1                            ; $0072A2
        MOVE.W  D1,D3                           ; $0072A4
        ANDI.W  #$0020,D3                       ; $0072A6
        BEQ.S  loc_0072AE                       ; $0072AA
        ADDQ.B  #2,D6                           ; $0072AC
loc_0072AE:
        ANDI.W  #$FFC0,D1                       ; $0072AE
        ASR.W  #1,D1                            ; $0072B2
        ADD.W  D2,D1                            ; $0072B4
        ADD.W  D1,D1                            ; $0072B6
        ADD.W  D1,D1                            ; $0072B8
        MOVE.W  D1,$00CA(A0)                    ; $0072BA
        MOVEQ   #$00,D0                         ; $0072BE
        MOVE.W  $00CC(A0),D0                    ; $0072C0
        ADDI.W  #$1000,D0                       ; $0072C4
        ASL.L  #5,D0                            ; $0072C8
        SWAP    D0                              ; $0072CA
        ANDI.W  #$001C,D0                       ; $0072CC
        LEA     $0089A932,A3                    ; $0072D0
        MOVEA.L $00(A3,D0.W),A3                 ; $0072D6
        BTST    #2,D0                           ; $0072DA
        BNE.S  loc_0072FC                       ; $0072DE
        ANDI.B  #$0008,D0                       ; $0072E0
        BNE.S  loc_0072F2                       ; $0072E4
        ANDI.B  #$0002,D6                       ; $0072E6
        BEQ.S  loc_007314                       ; $0072EA
        ADDI.W  #$0080,D1                       ; $0072EC
        BRA.S  loc_007314                       ; $0072F0
loc_0072F2:
        ANDI.B  #$0001,D6                       ; $0072F2
        BEQ.S  loc_007314                       ; $0072F6
        SUBQ.W  #4,D1                           ; $0072F8
        BRA.S  loc_007314                       ; $0072FA
loc_0072FC:
        ANDI.B  #$0010,D0                       ; $0072FC
        BEQ.S  loc_00730C                       ; $007300
        ANDI.B  #$0001,D6                       ; $007302
        BEQ.S  loc_007314                       ; $007306
        SUBQ.W  #4,D1                           ; $007308
        BRA.S  loc_007314                       ; $00730A
loc_00730C:
        ANDI.B  #$0001,D6                       ; $00730C
        BNE.S  loc_007314                       ; $007310
        ADDQ.W  #4,D1                           ; $007312
loc_007314:
        MOVE.L  #$2207FFFE,D3                   ; $007314
        MOVE.W  $C8A0.W,D0                      ; $00731A
        LEA     -$00D8(PC),A1                   ; $00731E
        MOVEA.L $00(A1,D0.W),A1                 ; $007322
        MOVEQ   #$00,D4                         ; $007326
        MOVEA.L $00(A1,D1.W),A4                 ; $007328
        CMPA.L  D3,A4                           ; $00732C
        BEQ.S  loc_007334                       ; $00732E
        MOVE.L  A4,(A2)+                        ; $007330
        ADDQ.W  #1,D4                           ; $007332
loc_007334:
        MOVEQ   #$0B,D7                         ; $007334
loc_007336:
        MOVE.W  D1,D0                           ; $007336
        ADD.W  (A3)+,D0                         ; $007338
        MOVEA.L $00(A1,D0.W),A4                 ; $00733A
        CMPA.L  D3,A4                           ; $00733E
        BEQ.S  loc_007346                       ; $007340
        MOVE.L  A4,(A2)+                        ; $007342
        ADDQ.W  #1,D4                           ; $007344
loc_007346:
        DBRA    D7,loc_007336                   ; $007346
        MOVEA.L (A7)+,A4                        ; $00734A
        RTS                                     ; $00734C
loc_00734E:
        TST.W  $C0BA.W                          ; $00734E
        BEQ.W  loc_0071A6                       ; $007352
        MOVE.L  A4,-(A7)                        ; $007356
        MOVE.W  #$0400,D1                       ; $007358
        MOVE.W  $00FF6102,D2                    ; $00735C
        ASR.W  #4,D2                            ; $007362
        ADD.W  D1,D2                            ; $007364
        ASR.W  #6,D2                            ; $007366
        MOVE.W  $00FF6106,D3                    ; $007368
        ASR.W  #4,D3                            ; $00736E
        SUB.W  D3,D1                            ; $007370
        ANDI.W  #$FFC0,D1                       ; $007372
        ASR.W  #1,D1                            ; $007376
        ADD.W  D2,D1                            ; $007378
        ADD.W  D1,D1                            ; $00737A
        ADD.W  D1,D1                            ; $00737C
        MOVEQ   #$00,D0                         ; $00737E
        MOVE.W  $00CC(A0),D0                    ; $007380
        ASL.L  #6,D0                            ; $007384
        SWAP    D0                              ; $007386
        ANDI.W  #$003C,D0                       ; $007388
        LEA     $0089A5D2,A3                    ; $00738C
        TST.W  $C0BA.W                          ; $007392
        BNE.S  loc_00739E                       ; $007396
        LEA     $0089A0D4,A3                    ; $007398
loc_00739E:
        MOVEA.L $00(A3,D0.W),A3                 ; $00739E
        MOVE.L  #$2207FFFE,D3                   ; $0073A2
        MOVE.W  $C8A0.W,D0                      ; $0073A8
        LEA     -$0166(PC),A1                   ; $0073AC
        MOVEA.L $00(A1,D0.W),A1                 ; $0073B0
        LEA     $00FF6000,A2                    ; $0073B4
        MOVEQ   #$00,D4                         ; $0073BA
        MOVEA.L $00(A1,D1.W),A4                 ; $0073BC
        CMPA.L  D3,A4                           ; $0073C0
        BEQ.S  loc_0073C8                       ; $0073C2
        MOVE.L  A4,(A2)+                        ; $0073C4
        ADDQ.W  #1,D4                           ; $0073C6
loc_0073C8:
        MOVE.W  (A3)+,D7                        ; $0073C8
loc_0073CA:
        MOVE.W  D1,D0                           ; $0073CA
        ADD.W  (A3)+,D0                         ; $0073CC
        MOVEA.L $00(A1,D0.W),A4                 ; $0073CE
        CMPA.L  D3,A4                           ; $0073D2
        BEQ.S  loc_0073DA                       ; $0073D4
        MOVE.L  A4,(A2)+                        ; $0073D6
        ADDQ.W  #1,D4                           ; $0073D8
loc_0073DA:
        DBRA    D7,loc_0073CA                   ; $0073DA
        MOVE.W  D4,$00FF610E                    ; $0073DE
        MOVEA.L (A7)+,A4                        ; $0073E4
        RTS                                     ; $0073E6
loc_0073E8:
        MOVE.L  #$00000400,D3                   ; $0073E8
        MOVE.W  D1,D4                           ; $0073EE
        ASR.W  #4,D4                            ; $0073F0
        ADD.W  D3,D4                            ; $0073F2
        ASR.W  #5,D4                            ; $0073F4
        MOVE.W  D2,D5                           ; $0073F6
        ASR.W  #4,D5                            ; $0073F8
        ADD.W  D5,D3                            ; $0073FA
        ANDI.W  #$FFE0,D3                       ; $0073FC
        ASL.W  #1,D3                            ; $007400
        ADD.W  D4,D3                            ; $007402
        ADD.W  D3,D3                            ; $007404
        MOVE.W  $C8A0.W,D0                      ; $007406
        ADD.W  D0,D0                            ; $00740A
        LEA     $001E(PC),A2                    ; $00740C
        TST.B  $00E4(A0)                        ; $007410
        BEQ.S  loc_00741A                       ; $007414
        LEA     $0044(PC),A2                    ; $007416
loc_00741A:
        MOVEA.L $00(A2,D0.W),A1                 ; $00741A
        MOVE.W  $00(A1,D3.W),D3                 ; $00741E
        MOVEA.L $04(A2,D0.W),A1                 ; $007422
        ADD.L  D3,D3                            ; $007426
        ADDA.L  D3,A1                           ; $007428
        RTS                                     ; $00742A
        ORI.L  #$C0000097,(A4)                  ; $00742C
        ORI.B  #$0094,D0                        ; $007432
        ASR.B  #8,D0                            ; $007436
        ORI.L  #$80000095,(A0)+                 ; $007438
        ORI.B  #$009A,D0                        ; $00743E
        ORI.B  #$0095,D0                        ; $007442
        NEGX.B D0                               ; $007446
        ORI.L  #$80000095,(A3)+                 ; $007448
        OR.B   D0,D0                            ; $00744E
        ORI.L  #$00000095,(A5)+                 ; $007450
        MOVE.L  D0,D0                           ; $007456
        ORI.L  #$00000000,(A5)+                 ; $007458
        ORI.B  #$0000,D0                        ; $00745E
        ORI.B  #$0000,D0                        ; $007462
        ORI.B  #$0000,D0                        ; $007466
        ORI.B  #$0000,D0                        ; $00746A
        ORI.B  #$0000,D0                        ; $00746E
        ORI.B  #$0095,D0                        ; $007472
        BRA.W  loc_007514                       ; $007476
        DC.W    $4110                           ; $00747A
        ORI.B  #$0000,D0                        ; $00747C
        ORI.B  #$0000,D0                        ; $007480
        ORI.B  #$0000,D0                        ; $007484
        ORI.B  #$0000,D0                        ; $007488
loc_00748C:
        ADDI.W  #$4000,D1                       ; $00748C
        ANDI.W  #$01FF,D1                       ; $007490
        ASL.W  #1,D1                            ; $007494
        EXT.L   D1                              ; $007496
        ADDI.W  #$4000,D2                       ; $007498
        ANDI.W  #$01FF,D2                       ; $00749C
        ASL.W  #1,D2                            ; $0074A0
        EXT.L   D2                              ; $0074A2
loc_0074A4:
        MOVE.W  (A1)+,D7                        ; $0074A4
        BPL.S  loc_0074AC                       ; $0074A6
        MOVEQ   #$00,D0                         ; $0074A8
        RTS                                     ; $0074AA
loc_0074AC:
        MOVEA.L A1,A2                           ; $0074AC
        MOVEQ   #$09,D5                         ; $0074AE
loc_0074B0:
        MOVE.W  (A1)+,D3                        ; $0074B0
        MOVEQ   #$03,D6                         ; $0074B2
loc_0074B4:
        ASL.W  #1,D3                            ; $0074B4
        BCS.S  loc_0074EA                       ; $0074B6
        ASL.W  #1,D3                            ; $0074B8
        BCS.S  loc_0074DA                       ; $0074BA
        MOVE.W  D1,D0                           ; $0074BC
        MULS    (A1)+,D0                        ; $0074BE
        MOVE.W  (A1)+,D4                        ; $0074C0
        EXT.L   D4                              ; $0074C2
        ASL.L  D5,D4                            ; $0074C4
        ADD.L  D4,D0                            ; $0074C6
        ASR.L  D5,D0                            ; $0074C8
        CMP.L  D0,D2                            ; $0074CA
        BLT.S  loc_0074D4                       ; $0074CC
        ASL.W  #1,D3                            ; $0074CE
        BCS.S  loc_007524                       ; $0074D0
        BRA.S  loc_00751C                       ; $0074D2
loc_0074D4:
        ASL.W  #1,D3                            ; $0074D4
        BCC.S  loc_007524                       ; $0074D6
        BRA.S  loc_00751C                       ; $0074D8
loc_0074DA:
        CMP.W  (A1),D1                          ; $0074DA
        BLT.S  loc_0074E4                       ; $0074DC
        ASL.W  #1,D3                            ; $0074DE
        BCC.S  loc_007524                       ; $0074E0
        BRA.S  loc_00751A                       ; $0074E2
loc_0074E4:
        ASL.W  #1,D3                            ; $0074E4
        BCS.S  loc_007524                       ; $0074E6
        BRA.S  loc_00751A                       ; $0074E8
loc_0074EA:
        ASL.W  #1,D3                            ; $0074EA
        BCS.S  loc_00750C                       ; $0074EC
        MOVE.W  D2,D0                           ; $0074EE
        MULS    (A1)+,D0                        ; $0074F0
        MOVE.W  (A1)+,D4                        ; $0074F2
        EXT.L   D4                              ; $0074F4
        ASL.L  D5,D4                            ; $0074F6
        ADD.L  D4,D0                            ; $0074F8
        ASR.L  D5,D0                            ; $0074FA
        CMP.L  D0,D1                            ; $0074FC
        BLT.S  loc_007506                       ; $0074FE
        ASL.W  #1,D3                            ; $007500
        BCC.S  loc_007524                       ; $007502
        BRA.S  loc_00751C                       ; $007504
loc_007506:
        ASL.W  #1,D3                            ; $007506
        BCS.S  loc_007524                       ; $007508
        BRA.S  loc_00751C                       ; $00750A
loc_00750C:
        CMP.W  (A1),D2                          ; $00750C
        BLT.S  loc_007516                       ; $00750E
        ASL.W  #1,D3                            ; $007510
        BCS.S  loc_007524                       ; $007512
loc_007514:
        BRA.S  loc_00751A                       ; $007514
loc_007516:
        ASL.W  #1,D3                            ; $007516
        BCC.S  loc_007524                       ; $007518
loc_00751A:
        ADDQ.L  #4,A1                           ; $00751A
loc_00751C:
        DBRA    D6,loc_0074B4                   ; $00751C
        MOVEQ   #$01,D0                         ; $007520
        BRA.S  loc_007532                       ; $007522
loc_007524:
        ADDA.L  #$0000001C,A2                   ; $007524
        MOVEA.L A2,A1                           ; $00752A
        DBRA    D7,loc_0074B0                   ; $00752C
        MOVEQ   #$00,D0                         ; $007530
loc_007532:
        RTS                                     ; $007532
loc_007534:
        ADDI.W  #$4000,D1                       ; $007534
        ANDI.W  #$01FF,D1                       ; $007538
        ASL.W  #1,D1                            ; $00753C
        EXT.L   D1                              ; $00753E
        ADDI.W  #$4000,D2                       ; $007540
        ANDI.W  #$01FF,D2                       ; $007544
        ASL.W  #1,D2                            ; $007548
        EXT.L   D2                              ; $00754A
        MOVEA.L A1,A2                           ; $00754C
        MOVEQ   #$09,D5                         ; $00754E
        MOVE.W  (A1)+,D3                        ; $007550
        MOVEQ   #$03,D6                         ; $007552
loc_007554:
        ASL.W  #1,D3                            ; $007554
        BCS.S  loc_00758A                       ; $007556
        ASL.W  #1,D3                            ; $007558
        BCS.S  loc_00757A                       ; $00755A
        MOVE.W  D1,D0                           ; $00755C
        MULS    (A1)+,D0                        ; $00755E
        MOVE.W  (A1)+,D4                        ; $007560
        EXT.L   D4                              ; $007562
        ASL.L  D5,D4                            ; $007564
        ADD.L  D4,D0                            ; $007566
        ASR.L  D5,D0                            ; $007568
        CMP.L  D0,D2                            ; $00756A
        BLT.S  loc_007574                       ; $00756C
        ASL.W  #1,D3                            ; $00756E
        BCS.S  loc_0075C4                       ; $007570
        BRA.S  loc_0075BC                       ; $007572
loc_007574:
        ASL.W  #1,D3                            ; $007574
        BCC.S  loc_0075C4                       ; $007576
        BRA.S  loc_0075BC                       ; $007578
loc_00757A:
        CMP.W  (A1),D1                          ; $00757A
        BLT.S  loc_007584                       ; $00757C
        ASL.W  #1,D3                            ; $00757E
        BCC.S  loc_0075C4                       ; $007580
        BRA.S  loc_0075BA                       ; $007582
loc_007584:
        ASL.W  #1,D3                            ; $007584
        BCS.S  loc_0075C4                       ; $007586
        BRA.S  loc_0075BA                       ; $007588
loc_00758A:
        ASL.W  #1,D3                            ; $00758A
        BCS.S  loc_0075AC                       ; $00758C
        MOVE.W  D2,D0                           ; $00758E
        MULS    (A1)+,D0                        ; $007590
        MOVE.W  (A1)+,D4                        ; $007592
        EXT.L   D4                              ; $007594
        ASL.L  D5,D4                            ; $007596
        ADD.L  D4,D0                            ; $007598
        ASR.L  D5,D0                            ; $00759A
        CMP.L  D0,D1                            ; $00759C
        BLT.S  loc_0075A6                       ; $00759E
        ASL.W  #1,D3                            ; $0075A0
        BCC.S  loc_0075C4                       ; $0075A2
        BRA.S  loc_0075BC                       ; $0075A4
loc_0075A6:
        ASL.W  #1,D3                            ; $0075A6
        BCS.S  loc_0075C4                       ; $0075A8
        BRA.S  loc_0075BC                       ; $0075AA
loc_0075AC:
        CMP.W  (A1),D2                          ; $0075AC
        BLT.S  loc_0075B6                       ; $0075AE
        ASL.W  #1,D3                            ; $0075B0
        BCS.S  loc_0075C4                       ; $0075B2
        BRA.S  loc_0075BA                       ; $0075B4
loc_0075B6:
        ASL.W  #1,D3                            ; $0075B6
        BCC.S  loc_0075C4                       ; $0075B8
loc_0075BA:
        ADDQ.L  #4,A1                           ; $0075BA
loc_0075BC:
        DBRA    D6,loc_007554                   ; $0075BC
        MOVEQ   #$01,D0                         ; $0075C0
        BRA.S  loc_0075C6                       ; $0075C2
loc_0075C4:
        MOVEQ   #$00,D0                         ; $0075C4
loc_0075C6:
        RTS                                     ; $0075C6
loc_0075C8:
        MULS    $0012(A2),D1                    ; $0075C8
        MULS    $0014(A2),D2                    ; $0075CC
        ADD.L  D2,D1                            ; $0075D0
        MOVE.W  $0016(A2),D2                    ; $0075D2
        EXT.L   D2                              ; $0075D6
        ASL.L  #5,D2                            ; $0075D8
        ADD.L  D2,D1                            ; $0075DA
        ASR.L  #6,D1                            ; $0075DC
        RTS                                     ; $0075DE
loc_0075E0:
        TST.B  $0019(A2)                        ; $0075E0
        BPL.S  loc_0075C8                       ; $0075E4
        MULS    $0012(A2),D1                    ; $0075E6
        MULS    $0014(A2),D2                    ; $0075EA
        ADD.L  D2,D1                            ; $0075EE
        MOVE.W  $0016(A2),D2                    ; $0075F0
        EXT.L   D2                              ; $0075F4
        ASL.L  #5,D2                            ; $0075F6
        ADD.L  D2,D1                            ; $0075F8
        ASR.L  #5,D1                            ; $0075FA
        RTS                                     ; $0075FC
loc_0075FE:
        TST.W  $C04C.W                          ; $0075FE
        BNE.S  loc_007612                       ; $007602
        MOVE.W  $003C(A0),D0                    ; $007604
        ADD.W  $0096(A0),D0                     ; $007608
        MOVE.W  D0,$00CC(A0)                    ; $00760C
        RTS                                     ; $007610
loc_007612:
        MOVE.W  $003C(A0),D0                    ; $007612
        ADD.W  $0096(A0),D0                     ; $007616
        SUB.W  $0046(A0),D0                     ; $00761A
        MOVE.W  D0,$00CC(A0)                    ; $00761E
        RTS                                     ; $007622
loc_007624:
        TST.W  $C0BA.W                          ; $007624
        BEQ.S  loc_007636                       ; $007628
        MOVE.W  $C0C2.W,D0                      ; $00762A
        NEG.W  D0                               ; $00762E
        MOVE.W  D0,$00CC(A0)                    ; $007630
        RTS                                     ; $007634
loc_007636:
        MOVE.W  $C0CA.W,D0                      ; $007636
        ADD.W  $C0B0.W,D0                       ; $00763A
        ASL.W  #3,D0                            ; $00763E
        ADD.W  $003C(A0),D0                     ; $007640
        ADD.W  $0096(A0),D0                     ; $007644
        MOVE.W  D0,$00CC(A0)                    ; $007648
        RTS                                     ; $00764C
loc_00764E:
        MOVE.W  $001E(A0),D0                    ; $00764E
        JSR     $008F4E(PC)                     ; $007652
        MOVE.W  D0,D4                           ; $007656
        MOVE.W  $0020(A0),D2                    ; $007658
        SUB.W  $0030(A0),D2                     ; $00765C
        MULS    D0,D2                           ; $007660
        MOVE.W  $001E(A0),D0                    ; $007662
        JSR     $008F52(PC)                     ; $007666
        MOVE.W  D0,D5                           ; $00766A
        MOVE.W  $0022(A0),D3                    ; $00766C
        SUB.W  $0034(A0),D3                     ; $007670
        MULS    D0,D3                           ; $007674
        ADD.L  D2,D3                            ; $007676
        ASR.L  #8,D3                            ; $007678
        NEG.W  D3                               ; $00767A
        MOVE.W  D3,$0072(A0)                    ; $00767C
        MOVE.W  D5,D0                           ; $007680
        MOVE.W  $0020(A0),D2                    ; $007682
        SUB.W  $0030(A0),D2                     ; $007686
        MULS    D0,D2                           ; $00768A
        MOVE.W  D4,D0                           ; $00768C
        MOVE.W  $0022(A0),D3                    ; $00768E
        SUB.W  $0034(A0),D3                     ; $007692
        MULS    D0,D3                           ; $007696
        SUB.L  D3,D2                            ; $007698
        ASR.L  #8,D2                            ; $00769A
        MOVE.W  D2,$00E2(A0)                    ; $00769C
        RTS                                     ; $0076A0
loc_0076A2:
        MOVEA.L $C268.W,A1                      ; $0076A2
        LEA     $C02E.W,A2                      ; $0076A6
        LSR.W  #6,D0                            ; $0076AA
        ADD.W  D0,D0                            ; $0076AC
        LEA     $00(A1,D0.W),A1                 ; $0076AE
        MOVE.B  (A1)+,D2                        ; $0076B2
        EXT.W   D2                              ; $0076B4
        MOVE.W  D2,$0000(A2)                    ; $0076B6
        MOVE.B  (A1),D2                         ; $0076BA
        EXT.W   D2                              ; $0076BC
        MOVE.W  D2,$0004(A2)                    ; $0076BE
        LEA     $07FF(A1),A1                    ; $0076C2
        MOVE.B  (A1)+,D2                        ; $0076C6
        EXT.W   D2                              ; $0076C8
        MOVE.W  D2,$0006(A2)                    ; $0076CA
        MOVE.B  (A1),D2                         ; $0076CE
        EXT.W   D2                              ; $0076D0
        MOVE.W  D2,$000A(A2)                    ; $0076D2
        LEA     $07FF(A1),A1                    ; $0076D6
        MOVE.B  (A1)+,D2                        ; $0076DA
        EXT.W   D2                              ; $0076DC
        MOVE.W  D2,$000C(A2)                    ; $0076DE
        MOVE.B  (A1),D2                         ; $0076E2
        EXT.W   D2                              ; $0076E4
        MOVE.W  D2,$0010(A2)                    ; $0076E6
        LEA     $07FF(A1),A1                    ; $0076EA
        MOVE.B  (A1)+,D2                        ; $0076EE
        EXT.W   D2                              ; $0076F0
        MOVE.W  D2,$0012(A2)                    ; $0076F2
        MOVE.B  (A1),D2                         ; $0076F6
        EXT.W   D2                              ; $0076F8
        MOVE.W  D2,$0016(A2)                    ; $0076FA
        RTS                                     ; $0076FE
loc_007700:
        JSR     loc_00789C(PC)                  ; $007700
        CMPI.W  #$0000,$0062(A0)                ; $007704
        BGT.W  loc_0077FA                       ; $00770A
        BTST    #0,$0055(A0)                    ; $00770E
        BEQ.W  loc_0077FA                       ; $007714
        MOVE.W  $0040(A0),D3                    ; $007718
        SUB.W  $0042(A0),D3                     ; $00771C
        ASR.W  #2,D3                            ; $007720
        MOVE.W  $0046(A0),D4                    ; $007722
        SUB.W  $0048(A0),D4                     ; $007726
        ASR.W  #2,D4                            ; $00772A
        MOVE.W  $0030(A0),D5                    ; $00772C
        SUB.W  $0036(A0),D5                     ; $007730
        ASR.W  #2,D5                            ; $007734
        MOVE.W  $0034(A0),D6                    ; $007736
        SUB.W  $0038(A0),D6                     ; $00773A
        ASR.W  #2,D6                            ; $00773E
        MOVE.W  $0036(A0),$0030(A0)             ; $007740
        MOVE.W  $0038(A0),$0034(A0)             ; $007746
        MOVE.W  $0042(A0),$0040(A0)             ; $00774C
        MOVE.W  $0048(A0),$0046(A0)             ; $007752
        ADD.W  D3,$0040(A0)                     ; $007758
        ADD.W  D4,$0046(A0)                     ; $00775C
        ADD.W  D5,$0030(A0)                     ; $007760
        ADD.W  D6,$0034(A0)                     ; $007764
        MOVEM.L -(A7),A0/A1/A2/A3/A4/A5/A6/A7   ; $007768
        JSR     loc_00789C(PC)                  ; $00776C
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,(A7)+   ; $007770
        BTST    #0,$0055(A0)                    ; $007774
        BNE.W  loc_0077EA                       ; $00777A
        ADD.W  D3,$0040(A0)                     ; $00777E
        ADD.W  D4,$0046(A0)                     ; $007782
        ADD.W  D5,$0030(A0)                     ; $007786
        ADD.W  D6,$0034(A0)                     ; $00778A
        MOVEM.L -(A7),A0/A1/A2/A3/A4/A5/A6/A7   ; $00778E
        JSR     loc_00789C(PC)                  ; $007792
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,(A7)+   ; $007796
        BTST    #0,$0055(A0)                    ; $00779A
        BNE.S  loc_0077EA                       ; $0077A0
        ADD.W  D3,$0040(A0)                     ; $0077A2
        ADD.W  D4,$0046(A0)                     ; $0077A6
        ADD.W  D5,$0030(A0)                     ; $0077AA
        ADD.W  D6,$0034(A0)                     ; $0077AE
        MOVEM.L -(A7),A0/A1/A2/A3/A4/A5/A6/A7   ; $0077B2
        JSR     loc_00789C(PC)                  ; $0077B6
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,(A7)+   ; $0077BA
        BTST    #0,$0055(A0)                    ; $0077BE
        BNE.S  loc_0077EA                       ; $0077C4
        ADD.W  D3,$0040(A0)                     ; $0077C6
        ADD.W  D4,$0046(A0)                     ; $0077CA
        ADD.W  D5,$0030(A0)                     ; $0077CE
        ADD.W  D6,$0034(A0)                     ; $0077D2
        MOVEM.L -(A7),A0/A1/A2/A3/A4/A5/A6/A7   ; $0077D6
        JSR     loc_00789C(PC)                  ; $0077DA
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,(A7)+   ; $0077DE
        BTST    #0,$0055(A0)                    ; $0077E2
        BEQ.S  loc_0077FA                       ; $0077E8
loc_0077EA:
        SUB.W  D3,$0040(A0)                     ; $0077EA
        SUB.W  D4,$0046(A0)                     ; $0077EE
        SUB.W  D5,$0030(A0)                     ; $0077F2
        SUB.W  D6,$0034(A0)                     ; $0077F6
loc_0077FA:
        MOVE.W  $0040(A0),$0042(A0)             ; $0077FA
        MOVE.W  $0046(A0),$0048(A0)             ; $007800
        MOVE.W  $0030(A0),$0036(A0)             ; $007806
        MOVE.W  $0034(A0),$0038(A0)             ; $00780C
        BRA.W  loc_00781A                       ; $007812
loc_007816:
        JSR     loc_00789C(PC)                  ; $007816
loc_00781A:
        MOVEA.L $00D2(A0),A2                    ; $00781A
        MOVE.W  $C0D4.W,D1                      ; $00781E
        MOVE.W  $C0D6.W,D2                      ; $007822
        JSR     loc_0075E0(PC)                  ; $007826
        BLE.S  loc_00783A                       ; $00782A
        MOVE.W  $005A(A0),D2                    ; $00782C
        EXT.L   D2                              ; $007830
        ADD.L  D2,D1                            ; $007832
        ASR.L  #1,D1                            ; $007834
        MOVE.W  D1,$005A(A0)                    ; $007836
loc_00783A:
        MOVEA.L $00D6(A0),A2                    ; $00783A
        MOVE.W  $C0D8.W,D1                      ; $00783E
        MOVE.W  $C0DA.W,D2                      ; $007842
        JSR     loc_0075E0(PC)                  ; $007846
        BLE.S  loc_00785A                       ; $00784A
        MOVE.W  $005C(A0),D2                    ; $00784C
        EXT.L   D2                              ; $007850
        ADD.L  D2,D1                            ; $007852
        ASR.L  #1,D1                            ; $007854
        MOVE.W  D1,$005C(A0)                    ; $007856
loc_00785A:
        MOVEA.L $00DA(A0),A2                    ; $00785A
        MOVE.W  $C0DC.W,D1                      ; $00785E
        MOVE.W  $C0DE.W,D2                      ; $007862
        JSR     loc_0075E0(PC)                  ; $007866
        BLE.S  loc_00787A                       ; $00786A
        MOVE.W  $005E(A0),D2                    ; $00786C
        EXT.L   D2                              ; $007870
        ADD.L  D2,D1                            ; $007872
        ASR.L  #1,D1                            ; $007874
        MOVE.W  D1,$005E(A0)                    ; $007876
loc_00787A:
        MOVEA.L $00CE(A0),A2                    ; $00787A
        MOVE.W  $C0D0.W,D1                      ; $00787E
        MOVE.W  $C0D2.W,D2                      ; $007882
        JSR     loc_0075E0(PC)                  ; $007886
        BLE.S  loc_00789A                       ; $00788A
        MOVE.W  $0032(A0),D2                    ; $00788C
        EXT.L   D2                              ; $007890
        ADD.L  D2,D1                            ; $007892
        ASR.L  #1,D1                            ; $007894
        MOVE.W  D1,$0032(A0)                    ; $007896
loc_00789A:
        RTS                                     ; $00789A
loc_00789C:
        MOVE.B  #$0000,$C31A.W                  ; $00789C
        MOVE.W  $0040(A0),D0                    ; $0078A2
        ADD.W  $0046(A0),D0                     ; $0078A6
        JSR     loc_0076A2(PC)                  ; $0078AA
        MOVE.W  $0030(A0),D1                    ; $0078AE
        MOVE.W  $0034(A0),D2                    ; $0078B2
        JSR     loc_0073E8(PC)                  ; $0078B6
        MOVE.L  A1,(A4)                         ; $0078BA
        JSR     loc_00748C(PC)                  ; $0078BC
        BNE.S  loc_0078D2                       ; $0078C0
        MOVE.L  #$00000000,(A4)                 ; $0078C2
        MOVE.L  #$00000000,$0004(A4)            ; $0078C8
        BRA.S  loc_0078EA                       ; $0078D0
loc_0078D2:
        MOVE.L  A2,$0004(A4)                    ; $0078D2
        MOVE.L  A2,$00CE(A0)                    ; $0078D6
        MOVE.B  $0018(A2),D0                    ; $0078DA
        MOVE.B  D0,$C319.W                      ; $0078DE
        MOVE.W  D1,$C0D0.W                      ; $0078E2
        MOVE.W  D2,$C0D2.W                      ; $0078E6
loc_0078EA:
        MOVE.W  $0030(A0),D1                    ; $0078EA
        ADD.W  $C02E.W,D1                       ; $0078EE
        MOVE.W  $0034(A0),D2                    ; $0078F2
        ADD.W  $C032.W,D2                       ; $0078F6
        MOVE.B  #$0001,$0056(A0)                ; $0078FA
        JSR     loc_0073E8(PC)                  ; $007900
        MOVE.L  (A4),D0                         ; $007904
        BEQ.S  loc_007920                       ; $007906
        CMPA.L  D0,A1                           ; $007908
        BNE.S  loc_007920                       ; $00790A
        MOVEA.L A1,A3                           ; $00790C
        MOVEA.L $0004(A4),A1                    ; $00790E
        JSR     loc_007534(PC)                  ; $007912
        BNE.S  loc_007926                       ; $007916
        MOVEA.L A3,A1                           ; $007918
        JSR     loc_0074A4(PC)                  ; $00791A
        BRA.S  loc_007924                       ; $00791E
loc_007920:
        JSR     loc_00748C(PC)                  ; $007920
loc_007924:
        BEQ.S  loc_00793A                       ; $007924
loc_007926:
        MOVE.L  A2,$00D2(A0)                    ; $007926
        MOVE.W  D1,$C0D4.W                      ; $00792A
        MOVE.W  D2,$C0D6.W                      ; $00792E
        JSR     loc_007A40(PC)                  ; $007932
        MOVE.B  D0,$0056(A0)                    ; $007936
loc_00793A:
        MOVE.W  $0030(A0),D1                    ; $00793A
        ADD.W  $C034.W,D1                       ; $00793E
        MOVE.W  $0034(A0),D2                    ; $007942
        ADD.W  $C038.W,D2                       ; $007946
        MOVE.B  #$0001,$0057(A0)                ; $00794A
        JSR     loc_0073E8(PC)                  ; $007950
        MOVE.L  (A4),D0                         ; $007954
        BEQ.S  loc_007970                       ; $007956
        CMPA.L  D0,A1                           ; $007958
        BNE.S  loc_007970                       ; $00795A
        MOVEA.L A1,A3                           ; $00795C
        MOVEA.L $0004(A4),A1                    ; $00795E
        JSR     loc_007534(PC)                  ; $007962
        BNE.S  loc_007976                       ; $007966
        MOVEA.L A3,A1                           ; $007968
        JSR     loc_0074A4(PC)                  ; $00796A
        BRA.S  loc_007974                       ; $00796E
loc_007970:
        JSR     loc_00748C(PC)                  ; $007970
loc_007974:
        BEQ.S  loc_00798A                       ; $007974
loc_007976:
        MOVE.L  A2,$00D6(A0)                    ; $007976
        MOVE.W  D1,$C0D8.W                      ; $00797A
        MOVE.W  D2,$C0DA.W                      ; $00797E
        JSR     loc_007A40(PC)                  ; $007982
        MOVE.B  D0,$0057(A0)                    ; $007986
loc_00798A:
        MOVE.W  $0030(A0),D1                    ; $00798A
        ADD.W  $C03A.W,D1                       ; $00798E
        MOVE.W  $0034(A0),D2                    ; $007992
        ADD.W  $C03E.W,D2                       ; $007996
        MOVE.B  #$0001,$0058(A0)                ; $00799A
        JSR     loc_0073E8(PC)                  ; $0079A0
        MOVE.L  (A4),D0                         ; $0079A4
        BEQ.S  loc_0079C0                       ; $0079A6
        CMPA.L  D0,A1                           ; $0079A8
        BNE.S  loc_0079C0                       ; $0079AA
        MOVEA.L A1,A3                           ; $0079AC
        MOVEA.L $0004(A4),A1                    ; $0079AE
        JSR     loc_007534(PC)                  ; $0079B2
        BNE.S  loc_0079C6                       ; $0079B6
        MOVEA.L A3,A1                           ; $0079B8
        JSR     loc_0074A4(PC)                  ; $0079BA
        BRA.S  loc_0079C4                       ; $0079BE
loc_0079C0:
        JSR     loc_00748C(PC)                  ; $0079C0
loc_0079C4:
        BEQ.S  loc_0079DA                       ; $0079C4
loc_0079C6:
        MOVE.L  A2,$00DA(A0)                    ; $0079C6
        MOVE.W  D1,$C0DC.W                      ; $0079CA
        MOVE.W  D2,$C0DE.W                      ; $0079CE
        JSR     loc_007A40(PC)                  ; $0079D2
        MOVE.B  D0,$0058(A0)                    ; $0079D6
loc_0079DA:
        MOVE.W  $0030(A0),D1                    ; $0079DA
        ADD.W  $C040.W,D1                       ; $0079DE
        MOVE.W  $0034(A0),D2                    ; $0079E2
        ADD.W  $C044.W,D2                       ; $0079E6
        MOVE.B  #$0001,$0059(A0)                ; $0079EA
        JSR     loc_0073E8(PC)                  ; $0079F0
        MOVE.L  (A4),D0                         ; $0079F4
        BEQ.S  loc_007A10                       ; $0079F6
        CMPA.L  D0,A1                           ; $0079F8
        BNE.S  loc_007A10                       ; $0079FA
        MOVEA.L A1,A3                           ; $0079FC
        MOVEA.L $0004(A4),A1                    ; $0079FE
        JSR     loc_007534(PC)                  ; $007A02
        BNE.S  loc_007A16                       ; $007A06
        MOVEA.L A3,A1                           ; $007A08
        JSR     loc_0074A4(PC)                  ; $007A0A
        BRA.S  loc_007A14                       ; $007A0E
loc_007A10:
        JSR     loc_00748C(PC)                  ; $007A10
loc_007A14:
        BEQ.S  loc_007A2A                       ; $007A14
loc_007A16:
        MOVE.L  A2,$00DE(A0)                    ; $007A16
        MOVE.W  D1,$C0E0.W                      ; $007A1A
        MOVE.W  D2,$C0E2.W                      ; $007A1E
        JSR     loc_007A40(PC)                  ; $007A22
        MOVE.B  D0,$0059(A0)                    ; $007A26
loc_007A2A:
        MOVE.B  $0056(A0),D0                    ; $007A2A
        OR.B   $0057(A0),D0                     ; $007A2E
        OR.B   $0058(A0),D0                     ; $007A32
        OR.B   $0059(A0),D0                     ; $007A36
        MOVE.B  D0,$0055(A0)                    ; $007A3A
        RTS                                     ; $007A3E
loc_007A40:
        MOVE.B  $0018(A2),D0                    ; $007A40
        ANDI.W  #$000F,D0                       ; $007A44
        ADD.W  D0,D0                            ; $007A48
        ADD.W  D0,D0                            ; $007A4A
        MOVEA.L $04(PC,D0.W),A1                 ; $007A4C
        JMP     (A1)                            ; $007A50
        ORI.L  #$7A8A0088,A0                    ; $007A52
        MOVEQ   #-$72,D5                        ; $007A58
        ORI.L  #$7A920088,A0                    ; $007A5A
        MOVEQ   #-$66,D5                        ; $007A60
        ORI.L  #$7AAA0088,A0                    ; $007A62
        MOVEQ   #-$4E,D5                        ; $007A68
        ORI.L  #$7AB20088,A0                    ; $007A6A
        MOVEQ   #-$4E,D5                        ; $007A70
        ORI.L  #$7AA20088,A0                    ; $007A72
        MOVEQ   #-$4E,D5                        ; $007A78
        ORI.L  #$7AB20088,A0                    ; $007A7A
        MOVEQ   #-$4E,D5                        ; $007A80
        ORI.L  #$7AB20088,A0                    ; $007A82
        MOVEQ   #-$52,D5                        ; $007A88
        MOVEQ   #$01,D0                         ; $007A8A
        RTS                                     ; $007A8C
        MOVEQ   #$02,D0                         ; $007A8E
        RTS                                     ; $007A90
        ADDQ.B  #1,$C31A.W                      ; $007A92
        MOVEQ   #$04,D0                         ; $007A96
        RTS                                     ; $007A98
        ADDQ.B  #1,$C31A.W                      ; $007A9A
        MOVEQ   #$08,D0                         ; $007A9E
        RTS                                     ; $007AA0
        ADDQ.B  #1,$C31A.W                      ; $007AA2
        MOVEQ   #$10,D0                         ; $007AA6
        RTS                                     ; $007AA8
        MOVEQ   #$02,D0                         ; $007AAA
        RTS                                     ; $007AAC
        MOVEQ   #$02,D0                         ; $007AAE
        RTS                                     ; $007AB0
        DIVU    #$0000,D0                       ; $007AB2
        BTST    #7,$00C0(A0)                    ; $007AB6
        BNE.S  loc_007AD6                       ; $007ABC
        JSR     loc_007BAC(PC)                  ; $007ABE
        MOVE.W  $0032(A0),D1                    ; $007AC2
        MOVE.W  D1,$00C6(A0)                    ; $007AC6
        MOVE.W  D1,$00C8(A0)                    ; $007ACA
        ADDQ.B  #1,$00FF5FFE                    ; $007ACE
        RTS                                     ; $007AD4
loc_007AD6:
        MOVE.W  $0040(A0),D0                    ; $007AD6
        ADD.W  $0046(A0),D0                     ; $007ADA
        LEA     $0093661E,A3                    ; $007ADE
        LSR.W  #6,D0                            ; $007AE4
        ADD.W  D0,D0                            ; $007AE6
        LEA     $00(A3,D0.W),A3                 ; $007AE8
        MOVE.B  (A3)+,D1                        ; $007AEC
        EXT.W   D1                              ; $007AEE
        MOVE.B  (A3),D2                         ; $007AF0
        EXT.W   D2                              ; $007AF2
        ADD.W  $0030(A0),D1                     ; $007AF4
        ADD.W  $0034(A0),D2                     ; $007AF8
        JSR     loc_0073E8(PC)                  ; $007AFC
        MOVE.L  A1,(A4)                         ; $007B00
        JSR     loc_00748C(PC)                  ; $007B02
        BNE.S  loc_007B18                       ; $007B06
        MOVE.L  #$00000000,(A4)                 ; $007B08
        MOVE.L  #$00000000,$0004(A4)            ; $007B0E
        BRA.S  loc_007B30                       ; $007B16
loc_007B18:
        MOVE.L  A2,$0004(A4)                    ; $007B18
        JSR     loc_0075C8(PC)                  ; $007B1C
        BLE.S  loc_007B30                       ; $007B20
        MOVE.W  $00C6(A0),D2                    ; $007B22
        EXT.L   D2                              ; $007B26
        ADD.L  D2,D1                            ; $007B28
        ASR.L  #1,D1                            ; $007B2A
        MOVE.W  D1,$00C6(A0)                    ; $007B2C
loc_007B30:
        LEA     $07FF(A3),A3                    ; $007B30
        MOVE.B  (A3)+,D1                        ; $007B34
        EXT.W   D1                              ; $007B36
        MOVE.B  (A3),D2                         ; $007B38
        EXT.W   D2                              ; $007B3A
        ADD.W  $0030(A0),D1                     ; $007B3C
        ADD.W  $0034(A0),D2                     ; $007B40
        JSR     loc_0073E8(PC)                  ; $007B44
        MOVE.L  (A4),D0                         ; $007B48
        BEQ.S  loc_007B64                       ; $007B4A
        CMPA.L  D0,A1                           ; $007B4C
        BNE.S  loc_007B64                       ; $007B4E
        MOVEA.L A1,A3                           ; $007B50
        MOVEA.L $0004(A4),A1                    ; $007B52
        JSR     loc_007534(PC)                  ; $007B56
        BNE.S  loc_007B68                       ; $007B5A
        MOVEA.L A3,A1                           ; $007B5C
        JSR     loc_0074A4(PC)                  ; $007B5E
        BRA.S  loc_007B68                       ; $007B62
loc_007B64:
        JSR     loc_00748C(PC)                  ; $007B64
loc_007B68:
        JSR     loc_0075C8(PC)                  ; $007B68
        BLE.S  loc_007B7C                       ; $007B6C
        MOVE.W  $00C8(A0),D2                    ; $007B6E
        EXT.L   D2                              ; $007B72
        ADD.L  D2,D1                            ; $007B74
        ASR.L  #1,D1                            ; $007B76
        MOVE.W  D1,$00C8(A0)                    ; $007B78
loc_007B7C:
        MOVE.W  $0030(A0),D1                    ; $007B7C
        MOVE.W  $0034(A0),D2                    ; $007B80
        MOVE.B  #$0001,$0055(A0)                ; $007B84
        JSR     loc_0073E8(PC)                  ; $007B8A
        MOVE.L  (A4),D0                         ; $007B8E
        BEQ.S  loc_007BBE                       ; $007B90
        CMPA.L  D0,A1                           ; $007B92
        BNE.S  loc_007BBE                       ; $007B94
        MOVEA.L A1,A3                           ; $007B96
        MOVEA.L $0004(A4),A1                    ; $007B98
        JSR     loc_007534(PC)                  ; $007B9C
        BNE.S  loc_007BC4                       ; $007BA0
        MOVEA.L A3,A1                           ; $007BA2
        JSR     loc_0074A4(PC)                  ; $007BA4
        BNE.S  loc_007BC4                       ; $007BA8
        RTS                                     ; $007BAA
loc_007BAC:
        MOVE.W  $0030(A0),D1                    ; $007BAC
        MOVE.W  $0034(A0),D2                    ; $007BB0
        MOVE.B  #$0001,$0055(A0)                ; $007BB4
        JSR     loc_0073E8(PC)                  ; $007BBA
loc_007BBE:
        JSR     loc_00748C(PC)                  ; $007BBE
        BEQ.S  loc_007BE2                       ; $007BC2
loc_007BC4:
        MOVE.L  A2,$00CE(A0)                    ; $007BC4
        BSR.S  loc_007BE4                       ; $007BC8
        MOVE.B  D0,$0055(A0)                    ; $007BCA
        JSR     loc_0075C8(PC)                  ; $007BCE
        BLE.S  loc_007BE2                       ; $007BD2
        MOVE.W  $0032(A0),D2                    ; $007BD4
        EXT.L   D2                              ; $007BD8
        ADD.L  D2,D1                            ; $007BDA
        ASR.L  #1,D1                            ; $007BDC
        MOVE.W  D1,$0032(A0)                    ; $007BDE
loc_007BE2:
        RTS                                     ; $007BE2
loc_007BE4:
        MOVE.B  $0018(A2),D0                    ; $007BE4
        ANDI.W  #$000F,D0                       ; $007BE8
        ADD.W  D0,D0                            ; $007BEC
        ADD.W  D0,D0                            ; $007BEE
        MOVEA.L $04(PC,D0.W),A1                 ; $007BF0
        JMP     (A1)                            ; $007BF4
        ORI.L  #$7C2E0088,A0                    ; $007BF6
        MOVEQ   #$32,D6                         ; $007BFC
        ORI.L  #$7C360088,A0                    ; $007BFE
        MOVEQ   #$3A,D6                         ; $007C04
        ORI.L  #$7C420088,A0                    ; $007C06
        MOVEQ   #$46,D6                         ; $007C0C
        ORI.L  #$7C460088,A0                    ; $007C0E
        MOVEQ   #$46,D6                         ; $007C14
        ORI.L  #$7C3E0088,A0                    ; $007C16
        MOVEQ   #$46,D6                         ; $007C1C
        ORI.L  #$7C460088,A0                    ; $007C1E
        MOVEQ   #$46,D6                         ; $007C24
        ORI.L  #$7C460088,A0                    ; $007C26
        MOVEQ   #$42,D6                         ; $007C2C
        MOVEQ   #$01,D0                         ; $007C2E
        RTS                                     ; $007C30
        MOVEQ   #$02,D0                         ; $007C32
        RTS                                     ; $007C34
        MOVEQ   #$04,D0                         ; $007C36
        RTS                                     ; $007C38
        MOVEQ   #$08,D0                         ; $007C3A
        RTS                                     ; $007C3C
        MOVEQ   #$10,D0                         ; $007C3E
        RTS                                     ; $007C40
        MOVEQ   #$02,D0                         ; $007C42
        RTS                                     ; $007C44
        MOVEQ   #$02,D0                         ; $007C46
        RTS                                     ; $007C48
        DIVU    #$0000,D0                       ; $007C4A
loc_007C4E:
        TST.W  $0004(A0)                        ; $007C4E
        BNE.S  loc_007C56                       ; $007C52
        RTS                                     ; $007C54
loc_007C56:
        TST.W  $0098(A0)                        ; $007C56
        BNE.S  loc_007C76                       ; $007C5A
        BTST    #3,$0058(A0)                    ; $007C5C
        BEQ.S  loc_007C76                       ; $007C62
        MOVE.W  #$000F,$0098(A0)                ; $007C64
        TST.B  $C8A4.W                          ; $007C6A
        BNE.S  loc_007C76                       ; $007C6E
        MOVE.B  #$00D2,$C8A4.W                  ; $007C70
loc_007C76:
        TST.W  $009A(A0)                        ; $007C76
        BNE.S  loc_007C96                       ; $007C7A
        BTST    #3,$0059(A0)                    ; $007C7C
        BEQ.S  loc_007C96                       ; $007C82
        MOVE.W  #$000F,$009A(A0)                ; $007C84
        TST.B  $C8A4.W                          ; $007C8A
        BNE.S  loc_007C96                       ; $007C8E
        MOVE.B  #$00D2,$C8A4.W                  ; $007C90
loc_007C96:
        TST.W  $00E6(A0)                        ; $007C96
        BNE.S  loc_007CB6                       ; $007C9A
        BTST    #4,$0058(A0)                    ; $007C9C
        BEQ.S  loc_007CB6                       ; $007CA2
        MOVE.W  #$000F,$00E6(A0)                ; $007CA4
        TST.B  $C8A4.W                          ; $007CAA
        BNE.S  loc_007CB6                       ; $007CAE
        MOVE.B  #$00D2,$C8A4.W                  ; $007CB0
loc_007CB6:
        TST.W  $00E8(A0)                        ; $007CB6
        BNE.S  loc_007CD6                       ; $007CBA
        BTST    #4,$0059(A0)                    ; $007CBC
        BEQ.S  loc_007CD6                       ; $007CC2
        MOVE.W  #$000F,$00E8(A0)                ; $007CC4
        TST.B  $C8A4.W                          ; $007CCA
        BNE.S  loc_007CD6                       ; $007CCE
        MOVE.B  #$00D2,$C8A4.W                  ; $007CD0
loc_007CD6:
        RTS                                     ; $007CD6
loc_007CD8:
        MOVE.B  $0057(A0),D0                    ; $007CD8
        AND.B  $0056(A0),D0                     ; $007CDC
        AND.B  $0059(A0),D0                     ; $007CE0
        AND.B  $0058(A0),D0                     ; $007CE4
        BTST    #1,D0                           ; $007CE8
        BEQ.S  loc_007CF0                       ; $007CEC
        RTS                                     ; $007CEE
loc_007CF0:
        ANDI.B  #$000C,D0                       ; $007CF0
        BEQ.S  loc_007D30                       ; $007CF4
        CMPI.W  #$0064,$0004(A0)                ; $007CF6
        BLE.S  loc_007D30                       ; $007CFC
        TST.W  $006A(A0)                        ; $007CFE
        BNE.S  loc_007D30                       ; $007D02
        TST.W  $008C(A0)                        ; $007D04
        BNE.S  loc_007D30                       ; $007D08
        MOVE.W  $C8D2.W,D0                      ; $007D0A
        CMP.W  $0094(A0),D0                     ; $007D0E
        BGT.S  loc_007D1C                       ; $007D12
        ORI.W  #$1000,$0002(A0)                 ; $007D14
        BRA.S  loc_007D2A                       ; $007D1A
loc_007D1C:
        NEG.W  D0                               ; $007D1C
        CMP.W  $0094(A0),D0                     ; $007D1E
        BLT.S  loc_007D30                       ; $007D22
        ORI.W  #$2000,$0002(A0)                 ; $007D24
loc_007D2A:
        MOVE.B  #$00B2,$C8A4.W                  ; $007D2A
loc_007D30:
        TST.W  $0062(A0)                        ; $007D30
        BEQ.S  loc_007D4C                       ; $007D34
        MOVE.B  $0057(A0),D1                    ; $007D36
        AND.B  $0056(A0),D1                     ; $007D3A
        ANDI.B  #$0001,D1                       ; $007D3E
        BEQ.S  loc_007D54                       ; $007D42
        MOVE.W  $001C(A0),D0                    ; $007D44
        JMP     loc_007EA4(PC)                  ; $007D48
loc_007D4C:
        BTST    #0,$0055(A0)                    ; $007D4C
        BNE.S  loc_007D56                       ; $007D52
loc_007D54:
        RTS                                     ; $007D54
loc_007D56:
        MOVE.B  #$00B5,$C8A4.W                  ; $007D56
        MOVE.W  $0040(A0),D0                    ; $007D5C
        SUB.W  $001E(A0),D0                     ; $007D60
        BPL.S  loc_007D68                       ; $007D64
        NEG.W  D0                               ; $007D66
loc_007D68:
        CMPI.W  #$0118,$0004(A0)                ; $007D68
        BLE.W  loc_007E0C                       ; $007D6E
        CMPI.W  #$0800,D0                       ; $007D72
        BLE.W  loc_007E0C                       ; $007D76
        TST.W  $008C(A0)                        ; $007D7A
        BEQ.S  loc_007D82                       ; $007D7E
        RTS                                     ; $007D80
loc_007D82:
        CMPI.W  #$0001,$C89C.W                  ; $007D82
        BNE.S  loc_007D94                       ; $007D88
        BTST    #2,$00E5(A0)                    ; $007D8A
        BNE.W  loc_007E30                       ; $007D90
loc_007D94:
        TST.W  $C04C.W                          ; $007D94
        BEQ.S  loc_007DA6                       ; $007D98
        MOVE.W  #$0001,$C004.W                  ; $007D9A
        MOVE.W  #$0001,$C048.W                  ; $007DA0
loc_007DA6:
        MOVE.W  $0024(A0),D0                    ; $007DA6
        ADDQ.W  #2,D0                           ; $007DAA
        TST.B  $C312.W                          ; $007DAC
        BEQ.S  loc_007DB4                       ; $007DB0
        SUBQ.W  #4,D0                           ; $007DB2
loc_007DB4:
        LEA     $00BE(PC),A1                    ; $007DB4
        MOVE.W  $C89C.W,D6                      ; $007DB8
        MOVE.B  $00(A1,D6.W),D6                 ; $007DBC
        LSL.W  D6,D0                            ; $007DC0
        MOVE.B  $00E5(A0),D1                    ; $007DC2
        ANDI.B  #$0006,D1                       ; $007DC6
        BEQ.S  loc_007DCE                       ; $007DCA
        ADDQ.W  #1,D0                           ; $007DCC
loc_007DCE:
        MOVEA.L $C708.W,A1                      ; $007DCE
        MOVE.B  $00(A1,D0.W),D0                 ; $007DD2
        ANDI.W  #$00FF,D0                       ; $007DD6
        MOVEQ   #$28,D1                         ; $007DDA
        MOVE.W  D1,$008C(A0)                    ; $007DDC
        MOVE.W  D1,$0014(A0)                    ; $007DE0
        MOVE.W  $C09A.W,$C07A.W                 ; $007DE4
        JSR     loc_007EB8(PC)                  ; $007DEA
        TST.B  $C826.W                          ; $007DEE
        BEQ.S  loc_007E04                       ; $007DF2
        CMPI.W  #$000F,$008A(A0)                ; $007DF4
        BGE.S  loc_007E04                       ; $007DFA
        ADDQ.W  #1,$008A(A0)                    ; $007DFC
        JSR     $00A1FC(PC)                     ; $007E00
loc_007E04:
        MOVE.B  #$00B0,$C8A4.W                  ; $007E04
        RTS                                     ; $007E0A
loc_007E0C:
        CMPI.W  #$0001,$C89C.W                  ; $007E0C
        BNE.S  loc_007E1C                       ; $007E12
        CMPI.B  #$00B1,$001D(A0)                ; $007E14
        BEQ.S  loc_007E30                       ; $007E1A
loc_007E1C:
        MOVE.B  $0057(A0),D1                    ; $007E1C
        AND.B  $0056(A0),D1                     ; $007E20
        ANDI.B  #$0001,D1                       ; $007E24
        BNE.S  loc_007E30                       ; $007E28
        CMPI.W  #$3000,D0                       ; $007E2A
        BLE.S  loc_007E38                       ; $007E2E
loc_007E30:
        MOVE.W  $001C(A0),D0                    ; $007E30
        JMP     loc_007EA4(PC)                  ; $007E34
loc_007E38:
        TST.W  $0092(A0)                        ; $007E38
        BGT.S  loc_007E72                       ; $007E3C
        ADDI.W  #$1000,D0                       ; $007E3E
        ASL.W  #1,D0                            ; $007E42
        MOVE.W  #$FFFF,$0068(A0)                ; $007E44
        TST.W  $0072(A0)                        ; $007E4A
        BLE.S  loc_007E58                       ; $007E4E
        MOVE.W  #$0001,$0068(A0)                ; $007E50
        NEG.W  D0                               ; $007E56
loc_007E58:
        MOVE.W  D0,$0066(A0)                    ; $007E58
        SUB.W  $0040(A0),D0                     ; $007E5C
        NEG.W  D0                               ; $007E60
        MOVE.W  D0,$0064(A0)                    ; $007E62
        MOVE.W  #$0004,$0062(A0)                ; $007E66
        MOVE.W  #$0004,$0014(A0)                ; $007E6C
loc_007E72:
        RTS                                     ; $007E72
        BTST    D0,D1                           ; $007E74
        BTST    D0,D1                           ; $007E76
        BTST    D0,D1                           ; $007E78
loc_007E7A:
        BTST    #1,$0055(A0)                    ; $007E7A
        BNE.S  loc_007E9E                       ; $007E80
        ADDQ.W  #1,$C02A.W                      ; $007E82
        CMPI.W  #$0050,$C02A.W                  ; $007E86
        BLE.S  loc_007EA2                       ; $007E8C
        CLR.W  $C02A.W                          ; $007E8E
        CLR.W  $0006(A0)                        ; $007E92
        MOVE.W  $001C(A0),D0                    ; $007E96
        JMP     loc_007EA4(PC)                  ; $007E9A
loc_007E9E:
        CLR.W  $C02A.W                          ; $007E9E
loc_007EA2:
        RTS                                     ; $007EA2
loc_007EA4:
        MOVEQ   #$14,D1                         ; $007EA4
        MOVE.W  $C07A.W,D4                      ; $007EA6
        CMP.W  $C098.W,D4                       ; $007EAA
        BNE.S  loc_007EB2                       ; $007EAE
        RTS                                     ; $007EB0
loc_007EB2:
        MOVE.W  $C090.W,$C07A.W                 ; $007EB2
loc_007EB8:
        MOVE.W  D1,$C02C.W                      ; $007EB8
        ADD.W  D0,D0                            ; $007EBC
        MOVE.W  D0,D2                           ; $007EBE
        ADD.W  D2,D2                            ; $007EC0
        MOVEA.L $C700.W,A1                      ; $007EC2
        MOVE.W  $00(A1,D2.W),D3                 ; $007EC6
        SUB.W  $0030(A0),D3                     ; $007ECA
        EXT.L   D3                              ; $007ECE
        DIVS    D1,D3                           ; $007ED0
        ADDQ.W  #1,D3                           ; $007ED2
        MOVE.W  D3,$004E(A0)                    ; $007ED4
        MOVE.W  $02(A1,D2.W),D3                 ; $007ED8
        SUB.W  $0034(A0),D3                     ; $007EDC
        EXT.L   D3                              ; $007EE0
        DIVS    D1,D3                           ; $007EE2
        ADDQ.W  #1,D3                           ; $007EE4
        MOVE.W  D3,$0050(A0)                    ; $007EE6
        MOVE.W  $001E(A0),D0                    ; $007EEA
        SUB.W  $003C(A0),D0                     ; $007EEE
        EXT.L   D0                              ; $007EF2
        DIVS    D1,D0                           ; $007EF4
        MOVE.W  D0,$0052(A0)                    ; $007EF6
        RTS                                     ; $007EFA
loc_007EFC:
        LEA     $00FF6940,A2                    ; $007EFC
        BRA.S  loc_007F0A                       ; $007F02
loc_007F04:
        LEA     $00FF6930,A2                    ; $007F04
loc_007F0A:
        MOVE.W  $003C(A0),D0                    ; $007F0A
        SUB.W  $001E(A0),D0                     ; $007F0E
        EXT.L   D0                              ; $007F12
        BPL.S  loc_007F1C                       ; $007F14
        ADDI.L  #$00010000,D0                   ; $007F16
loc_007F1C:
        CMPI.L  #$00004000,D0                   ; $007F1C
        BLE.S  loc_007F42                       ; $007F22
        CMPI.L  #$0000C000,D0                   ; $007F24
        BGE.S  loc_007F42                       ; $007F2A
        MOVE.B  #$0001,$C312.W                  ; $007F2C
        CLR.B  (A2)                             ; $007F32
        BTST    #2,$C8AB.W                      ; $007F34
        BEQ.S  loc_007F4E                       ; $007F3A
        MOVE.B  #$0001,(A2)                     ; $007F3C
        BRA.S  loc_007F4E                       ; $007F40
loc_007F42:
        TST.B  $C312.W                          ; $007F42
        BEQ.S  loc_007F4E                       ; $007F46
        CLR.B  (A2)                             ; $007F48
        CLR.B  $C312.W                          ; $007F4A
loc_007F4E:
        RTS                                     ; $007F4E
loc_007F50:
        MOVE.W  $0024(A0),D0                    ; $007F50
        SUB.W  $0026(A0),D0                     ; $007F54
        CMPI.W  #$0064,D0                       ; $007F58
        BLE.S  loc_007F64                       ; $007F5C
        SUBQ.W  #1,$002E(A0)                    ; $007F5E
        RTS                                     ; $007F62
loc_007F64:
        CMPI.W  #$FF9C,D0                       ; $007F64
        BGE.W  loc_008004                       ; $007F68
        ADDQ.W  #1,$002E(A0)                    ; $007F6C
        MOVE.W  #$0497,$0008(A0)                ; $007F70
        MOVE.W  $002C(A0),D1                    ; $007F76
        ADDQ.W  #1,D1                           ; $007F7A
        CMP.W  $002E(A0),D1                     ; $007F7C
        BNE.S  loc_007FD8                       ; $007F80
        MOVE.B  #$0004,$C305.W                  ; $007F82
        ADDQ.W  #1,$002C(A0)                    ; $007F88
        CLR.W  $0028(A0)                        ; $007F8C
        TST.W  $00AC(A0)                        ; $007F90
        BLE.S  loc_007F9E                       ; $007F94
        CMPI.W  #$0003,$001C(A0)                ; $007F96
        BGT.S  loc_007FAE                       ; $007F9C
loc_007F9E:
        ORI.W  #$4000,$0002(A0)                 ; $007F9E
        MOVE.W  #$0050,$C04E.W                  ; $007FA4
        CLR.W  $C8AA.W                          ; $007FAA
loc_007FAE:
        MOVE.B  $C310.W,D0                      ; $007FAE
        SUBQ.B  #1,D0                           ; $007FB2
        CMP.B  $002D(A0),D0                     ; $007FB4
        BGE.S  loc_007FEE                       ; $007FB8
        BSET    #5,$C30E.W                      ; $007FBA
        BTST    #5,$C80E.W                      ; $007FC0
        BEQ.S  loc_007FDA                       ; $007FC6
        ORI.W  #$4000,$0002(A0)                 ; $007FC8
        MOVE.W  #$0050,$C04E.W                  ; $007FCE
        CLR.W  $C8AA.W                          ; $007FD4
loc_007FD8:
        RTS                                     ; $007FD8
loc_007FDA:
        ANDI.W  #$BFFF,$0002(A0)                ; $007FDA
        MOVE.W  #$0000,$C04E.W                  ; $007FE0
        MOVE.B  #$0000,$C305.W                  ; $007FE6
        RTS                                     ; $007FEC
loc_007FEE:
        CMP.B  $002D(A0),D0                     ; $007FEE
        BNE.S  loc_008002                       ; $007FF2
        CMPI.W  #$0064,$001C(A0)                ; $007FF4
        BCC.S  loc_008002                       ; $007FFA
        MOVE.B  #$00BE,$C8A4.W                  ; $007FFC
loc_008002:
        RTS                                     ; $008002
loc_008004:
        MOVE.W  $002C(A0),D0                    ; $008004
        CMP.W  $002E(A0),D0                     ; $008008
        BNE.S  loc_008030                       ; $00800C
        MOVE.W  $0024(A0),D0                    ; $00800E
        CMP.W  $0028(A0),D0                     ; $008012
        BLE.S  loc_008030                       ; $008016
        MOVE.W  $0024(A0),$0028(A0)             ; $008018
        TST.B  $C319.W                          ; $00801E
        BPL.S  loc_008030                       ; $008022
        ORI.W  #$4000,$0002(A0)                 ; $008024
        MOVE.W  #$0050,$C04E.W                  ; $00802A
loc_008030:
        RTS                                     ; $008030
loc_008032:
        TST.W  $C07C.W                          ; $008032
        BNE.S  loc_008052                       ; $008036
        CMPI.W  #$0014,$002C(A0)                ; $008038
        BGE.S  loc_008052                       ; $00803E
        MOVE.W  $0024(A0),D0                    ; $008040
        SUB.W  $0026(A0),D0                     ; $008044
        CMPI.W  #$0064,D0                       ; $008048
        BLE.S  loc_008054                       ; $00804C
        SUBQ.W  #1,$002E(A0)                    ; $00804E
loc_008052:
        RTS                                     ; $008052
loc_008054:
        CMPI.W  #$FF9C,D0                       ; $008054
        BGE.S  loc_008004                       ; $008058
        ADDQ.W  #1,$002E(A0)                    ; $00805A
        MOVE.W  #$0497,$0008(A0)                ; $00805E
        MOVE.W  $002C(A0),D1                    ; $008064
        ADDQ.W  #1,D1                           ; $008068
        CMP.W  $002E(A0),D1                     ; $00806A
        BNE.S  loc_0080AC                       ; $00806E
        MOVE.B  #$0004,$C305.W                  ; $008070
        ADDQ.W  #1,$002C(A0)                    ; $008076
        CLR.W  $0028(A0)                        ; $00807A
        ORI.W  #$4000,$0002(A0)                 ; $00807E
        MOVE.W  #$0050,$C04E.W                  ; $008084
        CLR.W  $C8AA.W                          ; $00808A
        MOVE.B  $C310.W,D0                      ; $00808E
        SUBQ.B  #1,D0                           ; $008092
        CMP.B  $002D(A0),D0                     ; $008094
        BGE.S  loc_0080AE                       ; $008098
        ANDI.W  #$BFFF,$0002(A0)                ; $00809A
        MOVE.W  #$0000,$C04E.W                  ; $0080A0
        BSET    #5,$C30E.W                      ; $0080A6
loc_0080AC:
        RTS                                     ; $0080AC
loc_0080AE:
        CMP.B  $002D(A0),D0                     ; $0080AE
        BNE.S  loc_0080CA                       ; $0080B2
        MOVE.W  $C08E.W,D0                      ; $0080B4
        CMP.W  $C07A.W,D0                       ; $0080B8
        BEQ.S  loc_0080CA                       ; $0080BC
        TST.B  $C819.W                          ; $0080BE
        BNE.S  loc_0080CA                       ; $0080C2
        MOVE.B  #$00BE,$C8A4.W                  ; $0080C4
loc_0080CA:
        RTS                                     ; $0080CA
loc_0080CC:
        MOVEQ   #$00,D2                         ; $0080CC
        MOVE.W  $008C(A0),D2                    ; $0080CE
        BNE.S  loc_0080D6                       ; $0080D2
        RTS                                     ; $0080D4
loc_0080D6:
        TST.W  $C04C.W                          ; $0080D6
        BEQ.S  loc_0080E8                       ; $0080DA
        MOVE.W  #$0001,$C004.W                  ; $0080DC
        MOVE.W  #$0001,$C048.W                  ; $0080E2
loc_0080E8:
        LEA     $00939EEC,A1                    ; $0080E8
        LSL.W  #3,D2                            ; $0080EE
        ADDA.L  D2,A1                           ; $0080F0
        MOVE.W  (A1)+,$009C(A0)                 ; $0080F2
        MOVE.W  (A1)+,$009E(A0)                 ; $0080F6
        MOVE.W  (A1)+,$00A0(A0)                 ; $0080FA
        MOVE.W  (A1),$00A2(A0)                  ; $0080FE
        SUBQ.W  #1,$008C(A0)                    ; $008102
        BGT.S  loc_00816E                       ; $008106
        TST.W  $C004.W                          ; $008108
        BEQ.S  loc_008116                       ; $00810C
        CLR.W  $C048.W                          ; $00810E
        CLR.W  $C004.W                          ; $008112
loc_008116:
        MOVEQ   #$00,D0                         ; $008116
        MOVE.W  D0,$008C(A0)                    ; $008118
        MOVE.W  D0,$009E(A0)                    ; $00811C
        MOVE.W  D0,$00A0(A0)                    ; $008120
        MOVE.W  D0,$00A2(A0)                    ; $008124
        MOVE.W  D0,$009C(A0)                    ; $008128
        CMPI.W  #$011C,$0006(A0)                ; $00812C
        BGE.S  loc_00813A                       ; $008132
        MOVE.W  #$011C,$0006(A0)                ; $008134
loc_00813A:
        CMPI.W  #$0001,$C89C.W                  ; $00813A
        BNE.S  loc_00815C                       ; $008140
        MOVE.B  $00E5(A0),D0                    ; $008142
        ANDI.B  #$0006,D0                       ; $008146
        BEQ.S  loc_00815C                       ; $00814A
        MOVE.W  $0024(A0),D0                    ; $00814C
        CMPI.W  #$0069,D0                       ; $008150
        BLT.S  loc_00815C                       ; $008154
        CMPI.W  #$0071,D0                       ; $008156
        BLE.S  loc_00816E                       ; $00815A
loc_00815C:
        MOVE.W  #$0027,$C0AC.W                  ; $00815C
        MOVE.W  #$0028,$0092(A0)                ; $008162
        MOVE.W  $003C(A0),$0040(A0)             ; $008168
loc_00816E:
        RTS                                     ; $00816E
loc_008170:
        TST.W  $0062(A0)                        ; $008170
        BLE.S  loc_0081BE                       ; $008174
        SUBQ.W  #1,$0062(A0)                    ; $008176
        BNE.S  loc_0081BE                       ; $00817A
        CMPI.W  #$0001,$C89C.W                  ; $00817C
        BNE.S  loc_00819E                       ; $008182
        MOVE.B  $00E5(A0),D0                    ; $008184
        ANDI.B  #$0006,D0                       ; $008188
        BEQ.S  loc_00819E                       ; $00818C
        MOVE.W  $0024(A0),D0                    ; $00818E
        CMPI.W  #$0069,D0                       ; $008192
        BLT.S  loc_00819E                       ; $008196
        CMPI.W  #$006F,D0                       ; $008198
        BLE.S  loc_0081BE                       ; $00819C
loc_00819E:
        MOVE.W  #$000F,$C0AC.W                  ; $00819E
        CMPI.W  #$0002,$C8C8.W                  ; $0081A4
        BNE.S  loc_0081B2                       ; $0081AA
        MOVE.W  #$0004,$C0AC.W                  ; $0081AC
loc_0081B2:
        MOVE.W  #$0028,$0092(A0)                ; $0081B2
        MOVE.W  $003C(A0),$0040(A0)             ; $0081B8
loc_0081BE:
        RTS                                     ; $0081BE
        EORI.B  #$0E0A,A2                       ; $0081C0
        MOVE.B  A2,D1                           ; $0081C4
        ORI.B  #$0B0B,D0                        ; $0081C6
        MOVE.B  A3,D0                           ; $0081CA
        MOVE.B  A3,D2                           ; $0081CC
        ORI.B  #$0A0A,D0                        ; $0081CE
        DC.W    $0E0A                           ; $0081D2
        MOVE.B  A2,D1                           ; $0081D4
        ORI.B  #$0828,D0                        ; $0081D6
        ORI.B  #$0002,D6                        ; $0081DA
        BEQ.S  $00820A                          ; $0081DE
        ANDI.W  #$BFFF,$0002(A0)                ; $0081E0
        MOVE.W  $C8CC.W,D0                      ; $0081E6
        ADD.W  D0,D0                            ; $0081EA
        ADD.W  $C89C.W,D0                       ; $0081EC
        MOVE.B  -$32(PC,D0.W),D0                ; $0081F0
        ADD.W  D0,$C050.W                       ; $0081F4
        CLR.W  $C8AA.W                          ; $0081F8
        CMPI.B  #$00BE,$C8A4.W                  ; $0081FC
