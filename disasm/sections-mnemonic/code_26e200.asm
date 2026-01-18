; Generated assembly for $26E200-$270200
; Branch targets: 3
; Labels: 3
; Format: DC.W with decoded mnemonics as comments

        org     $26E200

        DC.W    $883E               ; $26E200 OR.B   <EA:3E>,D4
        DC.W    $883F               ; $26E202 OR.B   <EA:3F>,D4
        OR.W   D4,D4                            ; $26E204
        OR.W   D3,(A6)                          ; $26E206
        OR.W   $869A.W,D3                       ; $26E208
        OR.L   D2,$83D3.W                       ; $26E20C
        DIVU    $7EF7(A5),D0                    ; $26E210
        DC.W    $7DFB,$7CFC         ; $26E214 MOVE.W  -$04(PC,D7.L),<EA:3E>
        MOVEQ   #-$05,D5                        ; $26E218
        DC.W    $79F9,$78F7,$77F5,$76F3; $26E21A MOVE.W  $78F777F5,#$76F3
        MOVE.W  -$0F(A2,D7.W),$76EF(PC)         ; $26E222
        MOVE.W  $77EC(A6),-$15(PC,D7.W)         ; $26E228
        MOVE.W  $7BE8(A2),#$7BE7                ; $26E22E
        MOVE.W  -(A4),#$78D8                    ; $26E234
        DC.W    $79BF,$7CA8         ; $26E238 MOVE.W  <EA:3F>,-$58(A4,D7.L)
        MOVEQ   #-$6E,D7                        ; $26E23C
        DC.W    $807D               ; $26E23E OR.W   <EA:3D>,D0
        OR.W   D0,-$7F9D(A6)                    ; $26E240
        MOVEQ   #$54,D7                         ; $26E244
        MOVE.W  A1,$7C3F(A6)                    ; $26E246
        MOVEQ   #$31,D7                         ; $26E24A
        OR.B   D0,-$7DD8(A2)                    ; $26E24C
        OR.B   D0,-(A7)                         ; $26E250
        OR.B   D0,-(A7)                         ; $26E252
        OR.B   D0,-$7DD6(A1)                    ; $26E254
        OR.B   -$7DD4(A3),D1                    ; $26E258
        MOVE.W  $7D2E(A5),-(A7)                 ; $26E25C
        MOVEQ   #$2F,D6                         ; $26E260
        MOVE.W  $37(A1,D7.L),-(A6)              ; $26E262
        OR.B   D0,#$843F                        ; $26E266
        DC.W    $873D               ; $26E26A OR.B   D3,<EA:3D>
        OR.B   D4,$8939.W                       ; $26E26C
        DC.W    $873F               ; $26E270 OR.B   D3,<EA:3F>
        OR.W   D1,D3                            ; $26E272
        OR.W   D5,D3                            ; $26E274
        OR.W   (A2),D3                          ; $26E276
        OR.W   D2,-(A0)                         ; $26E278
        OR.W   D1,-$71(A4,A0.W)                 ; $26E27A
        MOVEQ   #-$55,D7                        ; $26E27E
        MOVE.W  $7CC2(PC),-$39(A6,D7.L)         ; $26E280
        DC.W    $7BC5               ; $26E286 MOVE.W  D5,<EA:3D>
        DC.W    $7DB9,$80A3,$857D,$8952; $26E288 MOVE.W  $80A3857D,$52(A6,A0.L)
        OR.W   D3,D5                            ; $26E290
        OR.B   #$8837,D5                        ; $26E292
        OR.B   $48(A7,A0.W),D3                  ; $26E296
        OR.W   D0,-$7F81(A1)                    ; $26E29A
        OR.L   A5,D1                            ; $26E29E
        OR.L   $7ECC(A4),D1                     ; $26E2A0
        DC.W    $7BDF               ; $26E2A4 MOVE.W  (A7)+,<EA:3D>
        MOVEQ   #-$12,D4                        ; $26E2A6
        MOVEQ   #-$0E,D4                        ; $26E2A8
        MOVE.W  -$0C(A4,D7.W),-$0E(PC,D7.W)     ; $26E2AA
        MOVEQ   #-$10,D1                        ; $26E2B0
        MOVEQ   #-$12,D0                        ; $26E2B2
        BGT.S  loc_26E2A3                       ; $26E2B4
        BGT.S  loc_26E2A3                       ; $26E2B6
        MOVEQ   #-$16,D1                        ; $26E2B8
        MOVEQ   #-$17,D3                        ; $26E2BA
        MOVE.W  -(A7),#$7CE6                    ; $26E2BC
        MOVEQ   #-$1B,D7                        ; $26E2C0
        DC.W    $7FE0               ; $26E2C2 MOVE.W  -(A0),<EA:3F>
        MOVEQ   #-$2B,D7                        ; $26E2C4
        MOVEQ   #-$3B,D7                        ; $26E2C6
        MOVE.W  -$58(A2,D7.L),-$5A(A6,D7.L)     ; $26E2C8
        MOVEQ   #-$5A,D5                        ; $26E2CE
        MOVE.W  (A0)+,$7B(A5,D7.L)              ; $26E2D0
        MOVE.W  -(A2),-$7FB4(A7)                ; $26E2D4
        OR.B   $27(A4,A0.W),D0                  ; $26E2D8
        OR.B   D0,-(A4)                         ; $26E2DC
        OR.B   -(A1),D1                         ; $26E2DE
        OR.B   D1,-(A2)                         ; $26E2E0
        OR.B   D2,-(A3)                         ; $26E2E2
        OR.B   D2,-(A4)                         ; $26E2E4
        OR.B   -(A6),D3                         ; $26E2E6
        OR.B   D3,-(A7)                         ; $26E2E8
        OR.B   -$75D7(A0),D4                    ; $26E2EA
        OR.B   -$76D5(A2),D5                    ; $26E2EE
        OR.B   -$75D2(A4),D5                    ; $26E2F2
        OR.B   D3,$39(A0,A0.W)                  ; $26E2F6
        OR.W   D1,A3                            ; $26E2FA
        OR.W   D0,-(A6)                         ; $26E2FC
        MOVEQ   #-$73,D7                        ; $26E2FE
        MOVEQ   #-$5B,D6                        ; $26E300
        MOVE.W  -$44(A2,D7.L),-$40(A5,D7.L)     ; $26E302
        DC.W    $7BBD,$7BBE         ; $26E308 MOVE.W  <EA:3D>,-$42(A5,D7.L)
        DC.W    $7DBD,$7FB4         ; $26E30C MOVE.W  <EA:3D>,-$4C(A6,D7.L)
        OR.L   D0,-$7E5E(A4)                    ; $26E310
        OR.L   D0,(A2)                          ; $26E314
        OR.L   D0,D2                            ; $26E316
        OR.W   D1,-$7BB9(A0)                    ; $26E318
        OR.B   D2,$8536.W                       ; $26E31C
        OR.B   D1,$37(A2,A0.W)                  ; $26E320
        OR.W   A1,D1                            ; $26E324
        OR.W   (A7)+,D0                         ; $26E326
        MOVE.W  -$76(A3,D7.L),$7D96(A7)         ; $26E328
        MOVEQ   #-$69,D7                        ; $26E32E
        MOVE.W  A5,-$6E(A7,D7.L)                ; $26E330
        MOVE.W  -(A2),-$41(A6,D7.L)             ; $26E334
        MOVEQ   #-$26,D4                        ; $26E338
        MOVE.W  -(A2),-$19(PC,D7.W)             ; $26E33A
        MOVE.W  $75EA(A2),$75E9(PC)             ; $26E33E
        MOVEQ   #-$19,D3                        ; $26E344
        MOVE.W  -(A5),-$1C(PC,D7.L)             ; $26E346
        MOVEQ   #-$1E,D4                        ; $26E34A
        MOVEQ   #-$1F,D4                        ; $26E34C
        MOVEQ   #-$20,D4                        ; $26E34E
        MOVE.W  (A7)+,#$7BDD                    ; $26E350
        MOVEQ   #-$25,D6                        ; $26E354
        DC.W    $7DD6               ; $26E356 MOVE.W  (A6),<EA:3E>
        MOVEQ   #-$3D,D7                        ; $26E358
        OR.L   (A6)+,D0                         ; $26E35A
        OR.W   $63(A7,A0.W),D1                  ; $26E35C
        OR.W   (A2)+,D0                         ; $26E360
        OR.W   A1,D0                            ; $26E362
        OR.B   D1,-$7ADD(A7)                    ; $26E364
        OR.B   D2,-(A0)                         ; $26E368
        OR.B   D2,(A6)+                         ; $26E36A
        OR.B   D2,(A5)+                         ; $26E36C
        OR.B   (A6)+,D3                         ; $26E36E
        OR.B   -(A0),D4                         ; $26E370
        OR.B   -(A1),D4                         ; $26E372
        OR.B   -(A3),D4                         ; $26E374
        OR.B   D3,-(A4)                         ; $26E376
        OR.B   -(A5),D3                         ; $26E378
        OR.B   D3,-(A6)                         ; $26E37A
        OR.B   -(A7),D4                         ; $26E37C
        OR.B   -$76D7(A0),D4                    ; $26E37E
        OR.B   -$7CD3(A3),D3                    ; $26E382
        MOVE.W  $7D5B.W,-(A7)                   ; $26E386
        MOVE.W  D3,-$61(A5,D7.L)                ; $26E38A
        MOVE.W  $7EB3(A5),-$49(A6,D7.L)         ; $26E38E
        MOVE.W  -$54(A1,A0.W),-$5B(A7,A0.W)     ; $26E394
        OR.L   D2,(A6)                          ; $26E39A
        OR.L   A4,D2                            ; $26E39C
        OR.L   D1,A6                            ; $26E39E
        MOVE.W  (A7),-$64(A7,D7.L)              ; $26E3A0
        MOVE.W  (A6)+,-$6B(A6,D7.L)             ; $26E3A4
        OR.L   D6,D0                            ; $26E3A8
        OR.W   D0,$8264.W                       ; $26E3AA
        OR.W   A6,D1                            ; $26E3AE
        OR.W   D3,D1                            ; $26E3B0
        DC.W    $803F               ; $26E3B2 OR.B   <EA:3F>,D0
        MOVE.W  A0,$7C5A(A6)                    ; $26E3B4
        MOVEQ   #$71,D5                         ; $26E3B8
        MOVE.W  A3,-$5A(A4,D7.L)                ; $26E3BA
        MOVEQ   #-$50,D5                        ; $26E3BE
        MOVE.W  -$51(A2,D7.L),-$50(A5,D7.L)     ; $26E3C0
        MOVEQ   #-$47,D7                        ; $26E3C6
        MOVEQ   #-$3C,D7                        ; $26E3C8
        DC.W    $7DD2               ; $26E3CA MOVE.W  (A2),<EA:3E>
        MOVEQ   #-$23,D6                        ; $26E3CC
        DC.W    $7BE0               ; $26E3CE MOVE.W  -(A0),<EA:3D>
        MOVE.W  -(A2),#$77E2                    ; $26E3D0
        MOVE.W  -(A1),-$20(PC,D7.W)             ; $26E3D4
        MOVE.W  (A7)+,-$23(PC,D7.L)             ; $26E3D8
        MOVEQ   #-$24,D5                        ; $26E3DC
        MOVEQ   #-$25,D6                        ; $26E3DE
        DC.W    $7DD9               ; $26E3E0 MOVE.W  (A1)+,<EA:3E>
        DC.W    $7DD7               ; $26E3E2 MOVE.W  (A7),<EA:3E>
        MOVEQ   #-$32,D7                        ; $26E3E4
        MOVEQ   #-$41,D7                        ; $26E3E6
        MOVE.W  -$60(A1,A0.W),-$7B(A7,A0.W)     ; $26E3E8
        OR.W   D0,-$7EA3(A6)                    ; $26E3EE
        OR.W   D0,D5                            ; $26E3F2
        OR.B   D0,-$7EE1(A0)                    ; $26E3F4
        OR.B   D0,(A3)+                         ; $26E3F8
        OR.B   D0,(A0)+                         ; $26E3FA
        OR.B   (A0)+,D1                         ; $26E3FC
        OR.B   (A2)+,D3                         ; $26E3FE
        OR.B   (A4)+,D4                         ; $26E400
        OR.B   (A5)+,D5                         ; $26E402
        OR.B   (A6)+,D5                         ; $26E404
        OR.B   D4,-(A0)                         ; $26E406
        OR.B   D3,-(A1)                         ; $26E408
        OR.B   D3,-(A2)                         ; $26E40A
        OR.B   -(A3),D3                         ; $26E40C
        OR.B   D2,-(A5)                         ; $26E40E
        OR.B   D1,-$7FB5(A3)                    ; $26E410
        MOVE.W  -$7F7A(A6),-$7F5F(A7)           ; $26E414
        OR.L   D0,-$3F(A4,A0.W)                 ; $26E41A
        DIVS    D7,D0                           ; $26E41E
        DIVS    A3,D1                           ; $26E420
        DIVS    D7,D1                           ; $26E422
        DIVS    D1,D0                           ; $26E424
        DC.W    $7DC4               ; $26E426 MOVE.W  D4,<EA:3E>
        MOVE.W  (A0),#$76D4                     ; $26E428
        MOVEQ   #-$33,D3                        ; $26E42C
        MOVE.W  A1,$75C3(PC)                    ; $26E42E
        MOVEQ   #-$4C,D3                        ; $26E432
        MOVEQ   #-$61,D3                        ; $26E434
        MOVEQ   #-$7C,D4                        ; $26E436
        MOVE.W  (A7)+,$7D37(A5)                 ; $26E438
        MOVE.W  -$7FDF(A1),-(A7)                ; $26E43C
        OR.B   D0,(A6)+                         ; $26E440
        OR.B   (A5)+,D1                         ; $26E442
        OR.B   (A7)+,D2                         ; $26E444
        OR.B   D1,-(A1)                         ; $26E446
        OR.B   -$7FC1(A4),D0                    ; $26E448
        OR.W   A6,D0                            ; $26E44C
        OR.W   (A6)+,D1                         ; $26E44E
        OR.W   -$7B85(A2),D2                    ; $26E450
        OR.L   D1,A7                            ; $26E454
        OR.L   D0,-(A0)                         ; $26E456
        MOVE.W  -$2C(PC,D7.L),-$25(A7,D7.L)     ; $26E458
        MOVE.W  (A7)+,#$77E1                    ; $26E45E
        MOVEQ   #-$1F,D3                        ; $26E462
        MOVE.W  (A7)+,-$22(PC,D7.L)             ; $26E464
        MOVE.W  (A4)+,-$25(PC,D7.W)             ; $26E468
        MOVEQ   #-$26,D2                        ; $26E46C
        MOVEQ   #-$28,D3                        ; $26E46E
        MOVE.W  (A6),#$7BCF                     ; $26E470
        DC.W    $7BC2               ; $26E474 MOVE.W  D2,<EA:3D>
        MOVEQ   #-$4E,D5                        ; $26E476
        MOVEQ   #-$5E,D6                        ; $26E478
        MOVEQ   #-$6F,D7                        ; $26E47A
        OR.W   $5D(PC,A0.W),D0                  ; $26E47C
        OR.W   D4,D0                            ; $26E480
        MOVE.W  $20(A1,A0.W),-(A7)              ; $26E482
        OR.B   (A2)+,D1                         ; $26E486
        OR.B   (A0)+,D3                         ; $26E488
        OR.B   D4,(A7)                          ; $26E48A
        OR.B   D4,(A0)+                         ; $26E48C
        OR.B   (A2)+,D5                         ; $26E48E
        OR.B   D6,(A4)+                         ; $26E490
        SUB.B  (A5)+,D1                         ; $26E492
        SUB.B  (A6)+,D2                         ; $26E494
        SUB.B  D0,-(A0)                         ; $26E496
        OR.B   -(A1),D6                         ; $26E498
        OR.B   -(A2),D4                         ; $26E49A
        OR.B   -(A4),D3                         ; $26E49C
        OR.B   -$7DBD(A1),D3                    ; $26E49E
        MOVEQ   #$6F,D7                         ; $26E4A2
        MOVEQ   #-$68,D5                        ; $26E4A4
        MOVEQ   #-$4C,D4                        ; $26E4A6
        MOVE.W  D4,-$34(PC,D7.W)                ; $26E4A8
        MOVE.W  (A4),$75D7(PC)                  ; $26E4AC
        MOVE.W  (A2)+,$75DE(PC)                 ; $26E4B0
        MOVEQ   #-$22,D2                        ; $26E4B4
        MOVEQ   #-$23,D1                        ; $26E4B6
        MOVE.W  (A2)+,$72D1.W                   ; $26E4B8
        MOVEQ   #-$43,D2                        ; $26E4BC
        MOVEQ   #-$5D,D4                        ; $26E4BE
        MOVE.W  (A0),$7F(A4,D7.L)               ; $26E4C0
        MOVE.W  $7F5C(A3),-$7FAB(A6)            ; $26E4C4
        OR.W   A0,D1                            ; $26E4CA
        OR.B   D1,$24(A2,A0.W)                  ; $26E4CC
        OR.B   -(A1),D6                         ; $26E4D0
        SUB.B  (A7)+,D0                         ; $26E4D2
loc_26E4D4:
        OR.B   D7,(A6)+                         ; $26E4D4
        OR.B   D6,(A7)+                         ; $26E4D6
        OR.B   -(A0),D5                         ; $26E4D8
        OR.B   -(A2),D4                         ; $26E4DA
        OR.B   -$78C3(A0),D4                    ; $26E4DC
        OR.W   (A7)+,D2                         ; $26E4E0
        OR.L   D0,D6                            ; $26E4E2
        OR.L   (A7)+,D0                         ; $26E4E4
        OR.L   -$3B(A1,D7.L),D0                 ; $26E4E6
        MOVEQ   #-$27,D6                        ; $26E4EA
        MOVEQ   #-$22,D4                        ; $26E4EC
        MOVE.W  -(A0),-$1F(PC,D7.W)             ; $26E4EE
        MOVEQ   #-$20,D1                        ; $26E4F2
        BLE.S  loc_26E4D4                       ; $26E4F4
        BGT.S  loc_26E4D5                       ; $26E4F6
        BLE.S  loc_26E4D5                       ; $26E4F8
        MOVEQ   #-$26,D0                        ; $26E4FA
        MOVE.W  (A1)+,$71D7.W                   ; $26E4FC
        MOVE.W  (A6),$78D57BD2                  ; $26E500
        DC.W    $7DCA               ; $26E506 MOVE.W  A2,<EA:3E>
        MOVE.W  #$7EA8,-$6D(A6,A0.W)            ; $26E508
        OR.W   $4B(A3,A0.W),D1                  ; $26E50E
        OR.B   D3,-(A7)                         ; $26E512
        OR.B   D4,(A5)+                         ; $26E514
        OR.B   D5,(A6)                          ; $26E516
        OR.B   (A3),D7                          ; $26E518
        SUB.B  D0,(A4)                          ; $26E51A
        SUB.B  (A6),D0                          ; $26E51C
        OR.B   (A7),D6                          ; $26E51E
        OR.B   D3,(A1)+                         ; $26E520
        OR.B   D2,(A3)+                         ; $26E522
        OR.B   (A5)+,D2                         ; $26E524
        OR.B   D0,(A7)+                         ; $26E526
        MOVEQ   #$31,D6                         ; $26E528
        MOVEQ   #$4D,D5                         ; $26E52A
        MOVE.W  -(A3),$7C69(A5)                 ; $26E52C
        MOVE.W  $7974(A4),$787A(A5)             ; $26E530
        MOVEQ   #$7C,D4                         ; $26E536
        MOVEQ   #-$80,D4                        ; $26E538
        MOVE.W  A1,-$73(A3,D7.W)                ; $26E53A
        MOVEQ   #-$75,D4                        ; $26E53E
        MOVE.W  A4,-$71(A5,D7.L)                ; $26E540
        MOVE.W  (A0),-$71(A5,D7.L)              ; $26E544
        MOVEQ   #-$6D,D5                        ; $26E548
        MOVEQ   #-$69,D5                        ; $26E54A
        MOVE.W  (A7),-$72(A5,D7.L)              ; $26E54C
        MOVE.W  #$816D,-$7D9D(A7)               ; $26E550
        OR.W   D1,(A0)+                         ; $26E556
        OR.W   D1,A2                            ; $26E558
        OR.B   $29(A7,A0.W),D3                  ; $26E55A
        OR.B   -(A6),D3                         ; $26E55E
        OR.B   -(A4),D2                         ; $26E560
        OR.B   D1,-(A3)                         ; $26E562
        OR.B   D1,-(A4)                         ; $26E564
        OR.B   D1,-(A6)                         ; $26E566
        OR.B   -$7DC7(A2),D1                    ; $26E568
        OR.W   A4,D1                            ; $26E56C
        OR.W   D1,(A1)+                         ; $26E56E
        OR.W   D2,-(A0)                         ; $26E570
        OR.W   -$7D81(A3),D2                    ; $26E572
        MOVE.W  (A7),-$4E(A7,D7.L)              ; $26E576
        DC.W    $7BCD               ; $26E57A MOVE.W  A5,<EA:3D>
        MOVE.W  (A6)+,#$76E3                    ; $26E57C
        MOVE.W  -(A6),$73E675E5                 ; $26E580
        MOVEQ   #-$1D,D3                        ; $26E586
        MOVEQ   #-$1E,D4                        ; $26E588
        MOVEQ   #-$20,D4                        ; $26E58A
        MOVE.W  (A7)+,#$7BDE                    ; $26E58C
        MOVEQ   #-$24,D6                        ; $26E590
        MOVEQ   #-$25,D6                        ; $26E592
        MOVEQ   #-$26,D6                        ; $26E594
        MOVEQ   #-$29,D6                        ; $26E596
        DC.W    $7DCB               ; $26E598 MOVE.W  A3,<EA:3E>
        OR.L   -$7E7B(A1),D0                    ; $26E59A
        OR.W   -(A6),D0                         ; $26E59E
        OR.W   A7,D0                            ; $26E5A0
        OR.B   D0,$21(A5,A0.W)                  ; $26E5A2
        OR.B   (A5)+,D4                         ; $26E5A6
        OR.B   (A2)+,D6                         ; $26E5A8
        OR.B   D5,(A2)+                         ; $26E5AA
        OR.B   D4,(A3)+                         ; $26E5AC
        OR.B   (A5)+,D3                         ; $26E5AE
        OR.B   D1,(A6)+                         ; $26E5B0
        MOVE.W  -(A0),-(A7)                     ; $26E5B2
        MOVE.W  -(A1),-(A5)                     ; $26E5B4
        MOVEQ   #$27,D5                         ; $26E5B6
        MOVEQ   #$2B,D6                         ; $26E5B8
        MOVE.W  -(A7),-(A7)                     ; $26E5BA
        OR.B   D0,-(A7)                         ; $26E5BC
        OR.B   $7E34(A2),D0                     ; $26E5BE
        MOVEQ   #$46,D6                         ; $26E5C2
        MOVEQ   #$60,D5                         ; $26E5C4
        MOVE.W  -$77(PC,D7.L),$7D8A(A4)         ; $26E5C6
        OR.L   D0,D6                            ; $26E5CC
        OR.L   D0,D5                            ; $26E5CE
        OR.L   A5,D0                            ; $26E5D0
        MOVEQ   #-$5E,D7                        ; $26E5D2
        MOVE.W  -$43(A3,D7.L),-$3F(A5,D7.L)     ; $26E5D4
        MOVEQ   #-$40,D6                        ; $26E5DA
        MOVEQ   #-$3F,D6                        ; $26E5DC
        MOVEQ   #-$40,D6                        ; $26E5DE
        MOVE.W  $7EAB.W,-$63(A6,A0.W)           ; $26E5E0
        OR.L   A5,D1                            ; $26E5E6
        OR.W   $59(A3,A0.W),D2                  ; $26E5E8
        OR.W   D0,D5                            ; $26E5EC
        OR.B   D5,-$73D8(A6)                    ; $26E5EE
        OR.B   D5,-(A6)                         ; $26E5F2
        OR.B   D4,-(A5)                         ; $26E5F4
        OR.B   D2,-(A7)                         ; $26E5F6
        OR.B   $3C(A1,A0.W),D1                  ; $26E5F8
        OR.W   D1,(A2)                          ; $26E5FC
        OR.W   -$7C7F(A5),D2                    ; $26E5FE
        OR.L   D0,(A7)                          ; $26E602
        MOVE.W  -$39(A3,D7.L),-$2D(A7,D7.L)     ; $26E604
        MOVEQ   #-$21,D5                        ; $26E60A
        MOVE.W  -(A4),-$1B(PC,D7.W)             ; $26E60C
        MOVE.W  -(A5),$71E472E2                 ; $26E610
        MOVE.W  -(A1),$73DF74DE                 ; $26E616
        MOVEQ   #-$23,D2                        ; $26E61C
        MOVEQ   #-$25,D2                        ; $26E61E
        MOVE.W  (A0)+,-$36(PC,D7.L)             ; $26E620
        MOVEQ   #-$48,D6                        ; $26E624
        MOVEQ   #-$60,D7                        ; $26E626
        DC.W    $817D               ; $26E628 OR.W   D0,<EA:3D>
        OR.W   D1,-(A2)                         ; $26E62A
        OR.W   D2,D5                            ; $26E62C
        OR.B   -$79E0(A2),D3                    ; $26E62E
        OR.B   D2,(A4)+                         ; $26E632
        OR.B   (A2)+,D2                         ; $26E634
        OR.B   (A3)+,D1                         ; $26E636
        OR.B   (A4)+,D1                         ; $26E638
        OR.B   (A6)+,D2                         ; $26E63A
        OR.B   D1,-(A0)                         ; $26E63C
        OR.B   -(A1),D1                         ; $26E63E
        OR.B   -(A3),D0                         ; $26E640
        OR.B   -$7FD2(A0),D0                    ; $26E642
        OR.B   D0,-$7DCD(A7)                    ; $26E646
        OR.B   $32(A3,A0.W),D2                  ; $26E64A
        DC.W    $853F               ; $26E64E OR.B   D2,<EA:3F>
        OR.W   D2,D5                            ; $26E650
        OR.W   D2,D1                            ; $26E652
        OR.W   D2,(A0)                          ; $26E654
        OR.W   -$77(A0,D7.L),D1                 ; $26E656
        MOVE.W  (A1),-$69(A7,A0.W)              ; $26E65A
        OR.L   D0,-(A2)                         ; $26E65E
        MOVE.W  -$47(A4,D7.L),-$4A(A7,D7.L)     ; $26E660
        MOVEQ   #-$42,D6                        ; $26E666
        DC.W    $7BCA               ; $26E668 MOVE.W  A2,<EA:3D>
        MOVE.W  A2,#$7AC5                       ; $26E66A
        MOVEQ   #-$45,D6                        ; $26E66E
        MOVEQ   #-$56,D7                        ; $26E670
        MOVEQ   #-$60,D7                        ; $26E672
        MOVEQ   #-$6E,D7                        ; $26E674
        MOVEQ   #$77,D7                         ; $26E676
        OR.W   (A5)+,D0                         ; $26E678
        OR.W   D0,D5                            ; $26E67A
        OR.B   $2B(A1,A0.W),D1                  ; $26E67C
        OR.B   D3,-(A7)                         ; $26E680
        OR.B   -(A6),D3                         ; $26E682
        OR.B   -(A7),D2                         ; $26E684
        OR.B   -$79D6(A1),D2                    ; $26E686
        OR.B   D3,-$79D0(A4)                    ; $26E68A
        DC.W    $853F               ; $26E68E OR.B   D2,<EA:3F>
        OR.W   D1,(A6)+                         ; $26E690
        MOVE.W  D0,-$66(A7,D7.L)                ; $26E692
        MOVEQ   #-$4F,D5                        ; $26E696
        MOVEQ   #-$34,D4                        ; $26E698
        MOVE.W  -(A2),-$19(PC,D7.W)             ; $26E69A
        MOVE.W  $78EA(A1),$7BE9(PC)             ; $26E69E
        MOVEQ   #-$18,D5                        ; $26E6A4
        MOVEQ   #-$1A,D3                        ; $26E6A6
        MOVE.W  -(A4),$74E377E1                 ; $26E6A8
        MOVEQ   #-$20,D4                        ; $26E6AE
        MOVE.W  (A7)+,#$7BDB                    ; $26E6B0
        DC.W    $7DCE               ; $26E6B4 MOVE.W  A6,<EA:3E>
        MOVE.W  -$7D7C(A7),$66(A7,A0.W)         ; $26E6B6
        OR.W   D2,(A6)                          ; $26E6BC
        OR.W   A0,D2                            ; $26E6BE
        OR.B   D2,$28(A7,A0.W)                  ; $26E6C0
        OR.B   -$7DCC(A3),D2                    ; $26E6C4
        OR.B   $81318429,D0                     ; $26E6C8
        OR.B   D2,-$7BD4(A2)                    ; $26E6CE
        OR.B   -$79D7(A3),D2                    ; $26E6D2
        OR.B   -$76D7(A0),D4                    ; $26E6D6
        OR.B   -$79D6(A1),D4                    ; $26E6DA
        OR.B   -$7AD2(A3),D2                    ; $26E6DE
        OR.B   D2,$53(A5,A0.W)                  ; $26E6E2
        OR.W   -$7F(A2,D7.L),D0                 ; $26E6E6
        MOVE.W  (A6),-$45(A6,D7.L)              ; $26E6EA
        MOVE.W  (A2)+,-$21(PC,D7.W)             ; $26E6EE
        MOVE.W  (A7),-$2D(PC,D7.L)              ; $26E6F2
        MOVEQ   #-$29,D4                        ; $26E6F6
        MOVEQ   #-$23,D3                        ; $26E6F8
        MOVE.W  (A2)+,$78CA(PC)                 ; $26E6FA
        MOVE.W  -$7F69(A7),-$6D(A6,D7.L)        ; $26E6FE
        MOVE.W  (A4),-$72(A7,A0.W)              ; $26E704
        DC.W    $827F               ; $26E708 OR.W   <EA:3F>,D1
        OR.W   -$79AB(A5),D2                    ; $26E70A
        OR.B   $8B2E.W,D4                       ; $26E70E
        OR.B   -$74DA(A2),D6                    ; $26E712
        OR.B   -(A6),D4                         ; $26E716
        OR.B   -$7AD6(A0),D3                    ; $26E718
        OR.B   D1,$7F45(A6)                     ; $26E71C
        MOVE.W  -(A4),$7B81(A6)                 ; $26E720
        MOVE.W  $77CF(A3),-$21(A4,D7.W)         ; $26E724
        MOVE.W  -(A6),-$17(PC,D7.W)             ; $26E72A
        DC.W    $73EA,$71E8,$71E6,$73E4; $26E72E MOVE.W  $71E8(A2),$71E673E4
        MOVEQ   #-$1D,D2                        ; $26E736
        MOVEQ   #-$1F,D3                        ; $26E738
        MOVE.W  -(A0),#$7EDF                    ; $26E73A
        DC.W    $7FDD               ; $26E73E MOVE.W  (A5)+,<EA:3F>
        DC.W    $7FDC               ; $26E740 MOVE.W  (A4)+,<EA:3F>
        DIVU    (A5),D0                         ; $26E742
        DIVS    D4,D0                           ; $26E744
        OR.L   -$64(A1,A0.W),D2                 ; $26E746
        OR.L   D5,D3                            ; $26E74A
        OR.W   -$79A4(A7),D3                    ; $26E74C
        OR.W   D2,(A2)                          ; $26E750
        OR.W   D1,A3                            ; $26E752
        OR.W   A0,D1                            ; $26E754
        OR.W   D0,D2                            ; $26E756
        OR.B   $27(A5,A0.W),D1                  ; $26E758
        OR.B   -(A2),D1                         ; $26E75C
        OR.B   -(A0),D1                         ; $26E75E
        OR.B   D2,(A7)+                         ; $26E760
        OR.B   D3,-(A0)                         ; $26E762
        OR.B   -(A1),D4                         ; $26E764
        OR.B   D3,-(A2)                         ; $26E766
        OR.B   D2,-(A3)                         ; $26E768
        OR.B   -(A5),D2                         ; $26E76A
        OR.B   -(A6),D1                         ; $26E76C
        MOVE.W  $7C34(A0),-(A7)                 ; $26E76E
        MOVEQ   #$4C,D5                         ; $26E772
        MOVEQ   #$64,D5                         ; $26E774
        MOVE.W  D1,-$64(A5,D7.L)                ; $26E776
        MOVEQ   #-$4F,D4                        ; $26E77A
        MOVEQ   #-$43,D4                        ; $26E77C
        MOVEQ   #-$3B,D5                        ; $26E77E
        MOVEQ   #-$32,D5                        ; $26E780
        MOVEQ   #-$32,D5                        ; $26E782
        MOVE.W  D3,#$7AB5                       ; $26E784
        MOVEQ   #-$62,D6                        ; $26E788
        MOVE.W  $5D(PC,A0.W),-$7CB1(A7)         ; $26E78A
        OR.W   D1,A1                            ; $26E790
        OR.W   D1,A2                            ; $26E792
        OR.W   A1,D2                            ; $26E794
        OR.W   D1,D1                            ; $26E796
        OR.B   $31(A6,A0.W),D1                  ; $26E798
        OR.B   -$7CD5(A5),D1                    ; $26E79C
        OR.B   -$7ED4(A3),D1                    ; $26E7A0
        OR.B   $7F37(A5),D0                     ; $26E7A4
        MOVE.W  A4,$7D55(A6)                    ; $26E7A8
        MOVEQ   #$5B,D7                         ; $26E7AC
        OR.W   $7F85(A3),D0                     ; $26E7AE
        MOVE.W  -(A3),-$3F(A6,D7.L)             ; $26E7B2
        DC.W    $7BD7               ; $26E7B6 MOVE.W  (A7),<EA:3D>
        MOVEQ   #-$1B,D6                        ; $26E7B8
        MOVEQ   #-$16,D6                        ; $26E7BA
        MOVEQ   #-$14,D6                        ; $26E7BC
        DC.W    $7DEC,$7DEA         ; $26E7BE MOVE.W  $7DEA(A4),<EA:3E>
        MOVEQ   #-$18,D6                        ; $26E7C2
        MOVE.W  -(A7),#$79E5                    ; $26E7C4
        MOVE.W  -(A3),#$7BE1                    ; $26E7C8
        DIVU    (A4)+,D0                        ; $26E7CC
        OR.L   -$766A(PC),D3                    ; $26E7CE
        OR.L   D4,A2                            ; $26E7D2
        OR.L   D6,D3                            ; $26E7D4
        OR.L   D4,D2                            ; $26E7D6
        OR.L   D1,D3                            ; $26E7D8
        OR.L   D0,A0                            ; $26E7DA
        MOVE.W  (A2),-$6A(A7,D7.L)              ; $26E7DC
        MOVE.W  (A0),-$7D(A6,D7.L)              ; $26E7E0
        MOVE.W  $67(A3,D7.L),$7D57(A7)          ; $26E7E4
        MOVE.W  $2A(PC,A0.W),-(A7)              ; $26E7EA
        OR.B   D2,-(A6)                         ; $26E7EE
        OR.B   D2,-(A2)                         ; $26E7F0
        OR.B   D1,-(A1)                         ; $26E7F2
        OR.B   -(A2),D1                         ; $26E7F4
        OR.B   D0,-(A3)                         ; $26E7F6
        OR.B   D1,-(A5)                         ; $26E7F8
        OR.B   -(A7),D2                         ; $26E7FA
        OR.B   -$7CD4(A0),D2                    ; $26E7FC
        OR.W   D6,D0                            ; $26E800
        MOVEQ   #$74,D6                         ; $26E802
        MOVEQ   #-$68,D5                        ; $26E804
        MOVEQ   #-$59,D5                        ; $26E806
        MOVE.W  -$3A(A3,D7.L),-$2E(A5,D7.L)     ; $26E808
        DC.W    $7BCE               ; $26E80E MOVE.W  A6,<EA:3D>
        DC.W    $7BC9               ; $26E810 MOVE.W  A1,<EA:3D>
        DC.W    $7BC3               ; $26E812 MOVE.W  D3,<EA:3D>
        MOVEQ   #-$47,D6                        ; $26E814
        MOVE.W  $7DA1(A5),-$66(A6,D7.L)         ; $26E816
        MOVEQ   #-$6E,D7                        ; $26E81C
        MOVEQ   #-$74,D7                        ; $26E81E
        MOVE.W  A2,-$7D(A6,D7.L)                ; $26E820
        MOVE.W  $6A(A7,D7.L),$7E57(A7)          ; $26E824
        OR.B   -$7DD3(PC),D0                    ; $26E82A
        OR.B   -$7ADA(A1),D2                    ; $26E82E
        OR.B   D2,-(A5)                         ; $26E832
        OR.B   D2,-(A7)                         ; $26E834
        OR.B   -$7DC3(A2),D2                    ; $26E836
        OR.W   (A6)+,D0                         ; $26E83A
        MOVE.W  $808C.W,$7FA9(A7)               ; $26E83C
        MOVEQ   #-$3B,D7                        ; $26E842
        MOVEQ   #-$28,D6                        ; $26E844
        MOVEQ   #-$1F,D6                        ; $26E846
        MOVEQ   #-$1C,D6                        ; $26E848
        MOVEQ   #-$22,D6                        ; $26E84A
        MOVEQ   #-$26,D5                        ; $26E84C
        MOVEQ   #-$2B,D5                        ; $26E84E
        MOVEQ   #-$39,D6                        ; $26E850
        MOVE.W  -$51(A6,D7.L),-$50(A6,A0.W)     ; $26E852
        OR.L   -$59(A1,A0.W),D0                 ; $26E858
        OR.L   D1,-(A3)                         ; $26E85C
        OR.L   D0,-$3E(A3,D7.L)                 ; $26E85E
        MOVEQ   #-$40,D6                        ; $26E862
        MOVEQ   #-$3E,D6                        ; $26E864
        DC.W    $7DC6               ; $26E866 MOVE.W  D6,<EA:3E>
        DC.W    $7DB9,$809D,$818B,$7F8F; $26E868 MOVE.W  $809D818B,-$71(A6,D7.L)
        MOVEQ   #-$77,D6                        ; $26E870
        MOVEQ   #$7B,D5                         ; $26E872
        MOVE.W  $5A(A2,D7.L),-$7CC9(A5)         ; $26E874
        OR.B   D3,-(A6)                         ; $26E87A
        OR.B   -(A1),D4                         ; $26E87C
        OR.B   (A4)+,D3                         ; $26E87E
        OR.B   D2,(A3)+                         ; $26E880
        OR.B   D2,(A4)+                         ; $26E882
        OR.B   (A6)+,D3                         ; $26E884
        OR.B   -(A0),D4                         ; $26E886
        OR.B   D3,-(A1)                         ; $26E888
        OR.B   -(A3),D2                         ; $26E88A
        OR.B   -(A5),D1                         ; $26E88C
        OR.B   -$7FC3(A7),D1                    ; $26E88E
        MOVEQ   #$48,D7                         ; $26E892
        MOVE.W  -(A2),$7B87(A6)                 ; $26E894
        MOVEQ   #-$5D,D4                        ; $26E898
        MOVE.W  -$3E(A1,D7.L),-$2A(A4,D7.L)     ; $26E89A
        MOVE.W  (A7)+,-$26(PC,D7.L)             ; $26E8A0
        MOVEQ   #-$30,D5                        ; $26E8A4
        MOVE.W  (A0),#$77CD                     ; $26E8A6
        MOVE.W  D0,-$4E(PC,D7.L)                ; $26E8AA
        MOVE.W  -(A4),-$7A(A6,A0.W)             ; $26E8AE
        OR.W   D1,(A6)+                         ; $26E8B2
        DC.W    $863F               ; $26E8B4 OR.B   <EA:3F>,D3
        OR.B   -$78DC(A3),D4                    ; $26E8B6
        OR.B   D2,-(A0)                         ; $26E8BA
        OR.B   (A7)+,D2                         ; $26E8BC
        OR.B   -(A0),D2                         ; $26E8BE
        OR.B   -(A2),D2                         ; $26E8C0
        OR.B   D1,-(A4)                         ; $26E8C2
        OR.B   -$7BC5(A1),D2                    ; $26E8C4
        OR.W   D0,A7                            ; $26E8C8
        MOVE.W  (A6)+,$7E6B(A7)                 ; $26E8CA
        MOVE.W  -$7F(A6,D7.L),$7B91(A6)         ; $26E8CE
        MOVEQ   #-$65,D5                        ; $26E8D4
        MOVEQ   #-$67,D6                        ; $26E8D6
        MOVEQ   #-$62,D7                        ; $26E8D8
        MOVEQ   #-$53,D7                        ; $26E8DA
        MOVEQ   #-$44,D6                        ; $26E8DC
        MOVEQ   #-$3E,D6                        ; $26E8DE
        MOVEQ   #-$3A,D7                        ; $26E8E0
        DIVU    D5,D0                           ; $26E8E2
        DC.W    $82BE               ; $26E8E4 OR.L   <EA:3E>,D1
        OR.L   -$7B47(PC),D2                    ; $26E8E6
        DC.W    $83BD               ; $26E8EA OR.L   D1,<EA:3D>
        DIVS    A0,D0                           ; $26E8EC
        DC.W    $7FD6               ; $26E8EE MOVE.W  (A6),<EA:3F>
        DC.W    $7DDA               ; $26E8F0 MOVE.W  (A2)+,<EA:3E>
        DC.W    $7DDB               ; $26E8F2 MOVE.W  (A3)+,<EA:3E>
        MOVEQ   #-$24,D5                        ; $26E8F4
        MOVEQ   #-$25,D4                        ; $26E8F6
        MOVE.W  (A1)+,#$7BD0                    ; $26E8F8
        MOVEQ   #-$49,D6                        ; $26E8FC
        MOVEQ   #-$68,D7                        ; $26E8FE
        DC.W    $807E               ; $26E900 OR.W   <EA:3E>,D0
        OR.W   -$7FA6(A4),D0                    ; $26E902
        OR.W   D0,D1                            ; $26E906
        OR.B   D1,-$7CDC(A5)                    ; $26E908
        OR.B   D1,(A6)+                         ; $26E90C
        OR.B   (A3)+,D2                         ; $26E90E
        OR.B   (A4)+,D3                         ; $26E910
        OR.B   D3,(A5)+                         ; $26E912
        OR.B   D3,(A6)+                         ; $26E914
        OR.B   -(A0),D2                         ; $26E916
        OR.B   -(A2),D0                         ; $26E918
        MOVEQ   #$2D,D7                         ; $26E91A
        MOVE.W  A3,$7B64(A5)                    ; $26E91C
        MOVE.W  $7F73(A3),$7E90(A6)             ; $26E920
        MOVEQ   #-$4B,D4                        ; $26E926
        MOVE.W  A7,$74D9(PC)                    ; $26E928
        MOVEQ   #-$23,D2                        ; $26E92C
        MOVE.W  (A5)+,-$3A(PC,D7.L)             ; $26E92E
        MOVEQ   #-$4E,D7                        ; $26E932
        MOVE.W  -$7F5D(A1),-$62(A7,D7.L)        ; $26E934
        MOVE.W  (A1)+,-$69(A7,D7.L)             ; $26E93A
        MOVEQ   #-$6F,D7                        ; $26E93E
        MOVE.W  A1,$7A(A6,D7.L)                 ; $26E940
        OR.W   D0,(A2)+                         ; $26E944
        OR.B   $28(A6,A0.W),D2                  ; $26E946
        OR.B   -(A3),D3                         ; $26E94A
        OR.B   D2,(A6)+                         ; $26E94C
        OR.B   (A6)+,D2                         ; $26E94E
        OR.B   D0,(A7)+                         ; $26E950
        MOVE.W  -(A1),-(A6)                     ; $26E952
        MOVEQ   #$27,D6                         ; $26E954
        MOVEQ   #$3C,D7                         ; $26E956
        MOVE.W  (A6),$7F6A(A7)                  ; $26E958
        DC.W    $7D7D,$7B87         ; $26E95C MOVE.W  <EA:3D>,$7B87(A6)
        MOVEQ   #-$75,D5                        ; $26E960
        MOVE.W  A0,-$79(A6,D7.L)                ; $26E962
        MOVEQ   #-$70,D7                        ; $26E966
        OR.L   (A5)+,D0                         ; $26E968
        MOVE.W  -$33(A1,D7.L),-$28(A7,A0.W)     ; $26E96A
        DIVS    (A5)+,D0                        ; $26E970
        DIVU    -(A0),D1                        ; $26E972
        DIVU    -(A0),D1                        ; $26E974
        MOVEQ   #-$21,D7                        ; $26E976
        DC.W    $7BDE               ; $26E978 MOVE.W  (A6)+,<EA:3D>
        MOVEQ   #-$24,D5                        ; $26E97A
        DC.W    $7BDB               ; $26E97C MOVE.W  (A3)+,<EA:3D>
        DC.W    $7BD9               ; $26E97E MOVE.W  (A1)+,<EA:3D>
        DC.W    $7BD7               ; $26E980 MOVE.W  (A7),<EA:3D>
        DC.W    $7BD1               ; $26E982 MOVE.W  (A1),<EA:3D>
        MOVEQ   #-$46,D6                        ; $26E984
        MOVE.W  (A4)+,-$79(A6,D7.L)             ; $26E986
        MOVEQ   #$77,D7                         ; $26E98A
        OR.W   -(A0),D0                         ; $26E98C
        OR.W   D1,D6                            ; $26E98E
        OR.B   $2A(A7,A0.W),D2                  ; $26E990
        OR.B   D1,(A7)+                         ; $26E994
        OR.B   (A3)+,D2                         ; $26E996
        OR.B   (A2)+,D3                         ; $26E998
        OR.B   (A2)+,D3                         ; $26E99A
        OR.B   D1,(A4)+                         ; $26E99C
        OR.B   D1,(A6)+                         ; $26E99E
        OR.B   D1,(A7)+                         ; $26E9A0
        OR.B   D1,-(A0)                         ; $26E9A2
        OR.B   D0,$7E3F(A1)                     ; $26E9A4
        MOVEQ   #$4E,D6                         ; $26E9A8
        MOVEQ   #$58,D6                         ; $26E9AA
        MOVE.W  $7A83(A3),$7990(A5)             ; $26E9AC
        MOVE.W  (A3),-$67(A4,D7.L)              ; $26E9B2
        MOVE.W  -(A1),-$57(A4,D7.L)             ; $26E9B6
        MOVEQ   #-$52,D4                        ; $26E9BA
        MOVE.W  -(A7),-$66(A4,D7.L)             ; $26E9BC
        MOVE.W  D5,$6F(A6,D7.L)                 ; $26E9C0
        MOVE.W  -(A1),$7F54(A7)                 ; $26E9C4
        MOVE.W  D6,-$7FC3(A7)                   ; $26E9C8
        OR.B   D0,$2E(A7,A0.W)                  ; $26E9CC
        OR.B   -$7CD9(A0),D1                    ; $26E9D0
        OR.B   -(A7),D1                         ; $26E9D4
        OR.B   -(A7),D2                         ; $26E9D6
        OR.B   D2,-$7BD6(A0)                    ; $26E9D8
        OR.B   -$7FD2(A3),D1                    ; $26E9DC
        MOVE.W  $56(PC,D7.L),-(A7)              ; $26E9E0
        MOVE.W  $7F81(A7),-$7F7B(A7)            ; $26E9E4
        OR.L   D0,A3                            ; $26E9EA
        OR.L   D0,(A7)+                         ; $26E9EC
        DC.W    $7FB9,$7FCB,$80D1,$82CF; $26E9EE MOVE.W  $7FCB80D1,-$31(A7,A0.W)
        DIVU    D3,D2                           ; $26E9F6
        DC.W    $86BD               ; $26E9F8 OR.L   <EA:3D>,D3
        DC.W    $86BE               ; $26E9FA OR.L   <EA:3E>,D3
        DIVS    D1,D2                           ; $26E9FC
        DIVU    A3,D2                           ; $26E9FE
        DIVU    (A1)+,D1                        ; $26EA00
        DIVU    (A7)+,D0                        ; $26EA02
        MOVEQ   #-$1F,D7                        ; $26EA04
        MOVEQ   #-$1E,D6                        ; $26EA06
        MOVEQ   #-$1E,D6                        ; $26EA08
        DC.W    $7BE1               ; $26EA0A MOVE.W  -(A1),<EA:3D>
        DC.W    $7BDF               ; $26EA0C MOVE.W  (A7)+,<EA:3D>
        MOVEQ   #-$23,D6                        ; $26EA0E
        DC.W    $7DDB               ; $26EA10 MOVE.W  (A3)+,<EA:3E>
        DIVU    A4,D0                           ; $26EA12
        OR.L   D0,-$7B7C(A3)                    ; $26EA14
        OR.W   -(A7),D3                         ; $26EA18
        OR.W   -(A2),D2                         ; $26EA1A
        OR.W   (A6)+,D1                         ; $26EA1C
        OR.W   D0,(A3)                          ; $26EA1E
        OR.W   (A1)+,D0                         ; $26EA20
        OR.W   $7F74(A4),D0                     ; $26EA22
        MOVE.W  $70(A3,A0.W),-$7F98(A7)         ; $26EA26
        OR.W   (A6),D0                          ; $26EA2C
        OR.B   D0,$2B(PC,A0.W)                  ; $26EA2E
        OR.B   D1,-(A5)                         ; $26EA32
        OR.B   -(A7),D0                         ; $26EA34
        MOVEQ   #$3D,D6                         ; $26EA36
        MOVE.W  (A3),$7A59(A4)                  ; $26EA38
        MOVEQ   #$5D,D6                         ; $26EA3C
        MOVE.W  (A4)+,$7D58(A6)                 ; $26EA3E
        MOVEQ   #$60,D7                         ; $26EA42
        MOVE.W  -$7E(A3,D7.L),$7B97(A6)         ; $26EA44
        MOVE.W  -(A1),-$58(A5,D7.L)             ; $26EA4A
        MOVE.W  -(A5),-$6F(A6,D7.L)             ; $26EA4E
        MOVEQ   #-$80,D7                        ; $26EA52
        OR.W   $71(A7,A0.W),D0                  ; $26EA54
        OR.W   -(A3),D0                         ; $26EA58
        OR.W   D0,(A2)                          ; $26EA5A
        OR.W   D0,D1                            ; $26EA5C
        OR.B   D0,$32(A7,A0.W)                  ; $26EA5E
        OR.B   -$7CD8(A2),D1                    ; $26EA62
        OR.B   -$7CD7(A0),D2                    ; $26EA66
        OR.B   D0,-$7FD0(A2)                    ; $26EA6A
        MOVEQ   #$52,D7                         ; $26EA6E
        MOVEQ   #-$7E,D5                        ; $26EA70
        MOVE.W  -(A0),-$4D(A5,D7.L)             ; $26EA72
        MOVEQ   #-$45,D7                        ; $26EA76
        DIVU    D0,D0                           ; $26EA78
        DC.W    $80BE               ; $26EA7A OR.L   <EA:3E>,D0
        OR.L   -$5F(A1,A0.W),D1                 ; $26EA7C
        OR.L   D2,(A6)                          ; $26EA80
        OR.L   A6,D2                            ; $26EA82
        OR.L   D1,A6                            ; $26EA84
        OR.L   D1,(A5)                          ; $26EA86
        OR.L   D1,-(A1)                         ; $26EA88
        OR.L   D1,-$4C(A0,A0.W)                 ; $26EA8A
        OR.L   D1,-$36(A7,A0.W)                 ; $26EA8E
        DIVU    (A2)+,D0                        ; $26EA92
        DC.W    $7DDD               ; $26EA94 MOVE.W  (A5)+,<EA:3E>
        MOVEQ   #-$21,D6                        ; $26EA96
        DC.W    $7BE0               ; $26EA98 MOVE.W  -(A0),<EA:3D>
        DC.W    $7BDF               ; $26EA9A MOVE.W  (A7)+,<EA:3D>
        DC.W    $7DDD               ; $26EA9C MOVE.W  (A5)+,<EA:3E>
        DC.W    $7FD0               ; $26EA9E MOVE.W  (A0),<EA:3F>
        OR.L   D1,(A2)+                         ; $26EAA0
        OR.W   D2,-$7AA3(A6)                    ; $26EAA2
        OR.W   (A1),D1                          ; $26EAA6
        DC.W    $7F3D               ; $26EAA8 MOVE.W  <EA:3D>,-(A7)
        MOVE.W  D0,$7E52(A7)                    ; $26EAAA
        MOVE.W  (A2),$7F48(A6)                  ; $26EAAE
        OR.W   A5,D0                            ; $26EAB2
        MOVEQ   #$60,D7                         ; $26EAB4
        MOVEQ   #$68,D6                         ; $26EAB6
        MOVEQ   #$65,D6                         ; $26EAB8
        MOVEQ   #$5A,D7                         ; $26EABA
        OR.W   D2,D0                            ; $26EABC
        OR.B   D0,$2B(A0,A0.W)                  ; $26EABE
        MOVE.W  $7E34(A2),-(A7)                 ; $26EAC2
        MOVEQ   #$38,D7                         ; $26EAC6
        MOVEQ   #$38,D6                         ; $26EAC8
        MOVEQ   #$3E,D6                         ; $26EACA
        MOVE.W  A0,$7E56(A6)                    ; $26EACC
        MOVEQ   #$6D,D7                         ; $26EAD0
        MOVEQ   #-$7B,D6                        ; $26EAD2
        MOVEQ   #-$6A,D5                        ; $26EAD4
        MOVE.W  -(A5),-$53(A4,D7.L)             ; $26EAD6
        MOVE.W  $7CA6(A1),-$5C(A5,D7.L)         ; $26EADA
        MOVEQ   #-$66,D6                        ; $26EAE0
        MOVEQ   #-$6E,D6                        ; $26EAE2
        MOVE.W  (A0)+,-$6B(A5,D7.L)             ; $26EAE4
        MOVE.W  $5B(PC,D7.L),-$7EC3(A5)         ; $26EAE8
        OR.B   $2C(A1,A0.W),D2                  ; $26EAEE
        OR.B   D2,-$7CD8(A0)                    ; $26EAF2
        OR.B   D1,-$7DC9(A2)                    ; $26EAF6
        OR.W   (A2)+,D0                         ; $26EAFA
        MOVEQ   #$73,D7                         ; $26EAFC
        DC.W    $7F7F,$8187         ; $26EAFE MOVE.W  <EA:3F>,-$7E79(A7)
        OR.L   D1,A5                            ; $26EB02
        OR.L   A3,D2                            ; $26EB04
        OR.L   D2,D6                            ; $26EB06
        OR.L   D3,D6                            ; $26EB08
        OR.L   D4,D6                            ; $26EB0A
        DC.W    $8B7F               ; $26EB0C OR.W   D5,<EA:3F>
        OR.W   D5,$7E(PC,A0.L)                  ; $26EB0E
        OR.L   D7,D4                            ; $26EB12
        OR.L   A7,D3                            ; $26EB14
        OR.L   -(A0),D2                         ; $26EB16
        OR.L   -$34(A7,A0.W),D2                 ; $26EB18
        DC.W    $7FDD               ; $26EB1C MOVE.W  (A5)+,<EA:3F>
        DC.W    $7DE4               ; $26EB1E MOVE.W  -(A4),<EA:3E>
        MOVEQ   #-$1A,D6                        ; $26EB20
        MOVEQ   #-$19,D5                        ; $26EB22
        MOVE.W  -(A6),#$77E5                    ; $26EB24
        MOVEQ   #-$1E,D3                        ; $26EB28
        MOVEQ   #-$23,D4                        ; $26EB2A
        DC.W    $7BC6               ; $26EB2C MOVE.W  D6,<EA:3D>
        MOVE.W  -$5B(A4,D7.L),-$6F(A6,D7.L)     ; $26EB2E
        MOVE.W  D2,$7E(A7,D7.L)                 ; $26EB34
        MOVEQ   #-$7F,D7                        ; $26EB38
        MOVE.W  D0,$7F(A7,D7.L)                 ; $26EB3A
        MOVE.W  D7,-$74(A7,D7.L)                ; $26EB3E
        MOVEQ   #-$7E,D6                        ; $26EB42
        MOVEQ   #$75,D6                         ; $26EB44
        MOVE.W  $7C5F(A5),$7C51(A6)             ; $26EB46
        MOVEQ   #$53,D6                         ; $26EB4C
        MOVEQ   #$57,D6                         ; $26EB4E
        MOVE.W  (A5),$7C54(A5)                  ; $26EB50
        MOVE.W  (A2),$7F4C(A6)                  ; $26EB54
        OR.W   D6,D0                            ; $26EB58
        OR.W   D0,D5                            ; $26EB5A
        OR.W   A0,D0                            ; $26EB5C
        MOVE.W  A2,$7E4F(A7)                    ; $26EB5E
        MOVEQ   #$5A,D7                         ; $26EB62
        MOVEQ   #$67,D7                         ; $26EB64
        MOVEQ   #$78,D7                         ; $26EB66
        MOVEQ   #-$72,D6                        ; $26EB68
        MOVE.W  (A4)+,-$64(A5,D7.L)             ; $26EB6A
        MOVE.W  (A2)+,-$5F(A5,D7.L)             ; $26EB6E
        MOVE.W  -(A4),-$5F(A5,D7.L)             ; $26EB72
        MOVEQ   #-$64,D6                        ; $26EB76
        MOVE.W  A7,$78(A6,D7.L)                 ; $26EB78
        OR.W   (A6),D0                          ; $26EB7C
        OR.B   $882D.W,D2                       ; $26EB7E
        OR.B   -$76DB(A0),D5                    ; $26EB82
        OR.B   -(A5),D2                         ; $26EB86
        OR.B   -$7CC6(A0),D1                    ; $26EB88
        OR.W   (A7),D2                          ; $26EB8C
        OR.W   D2,-(A5)                         ; $26EB8E
        OR.W   (A6)+,D4                         ; $26EB90
        OR.W   D4,A6                            ; $26EB92
        OR.W   D4,D6                            ; $26EB94
        OR.W   D4,A1                            ; $26EB96
        OR.W   D3,(A3)                          ; $26EB98
        OR.W   -(A3),D2                         ; $26EB9A
        OR.W   -$76(A4,A0.W),D2                 ; $26EB9C
        OR.L   D1,-(A1)                         ; $26EBA0
        OR.L   -$7E45(A6),D1                    ; $26EBA2
        DC.W    $7FD1               ; $26EBA6 MOVE.W  (A1),<EA:3F>
        DC.W    $7DE2               ; $26EBA8 MOVE.W  -(A2),<EA:3E>
        DC.W    $7BE5               ; $26EBAA MOVE.W  -(A5),<EA:3D>
        MOVEQ   #-$19,D5                        ; $26EBAC
        DC.W    $7BE8,$7DE7         ; $26EBAE MOVE.W  $7DE7(A0),<EA:3D>
        DC.W    $7DE5               ; $26EBB2 MOVE.W  -(A5),<EA:3E>
        DC.W    $7DE4               ; $26EBB4 MOVE.W  -(A4),<EA:3E>
        MOVEQ   #-$1E,D6                        ; $26EBB6
        DC.W    $7BE1               ; $26EBB8 MOVE.W  -(A1),<EA:3D>
        MOVE.W  (A7)+,#$78DD                    ; $26EBBA
        MOVEQ   #-$2A,D4                        ; $26EBBE
        MOVE.W  A4,#$79C0                       ; $26EBC0
        MOVEQ   #-$47,D4                        ; $26EBC4
        MOVE.W  $76B8.W,-$54(A3,D7.W)           ; $26EBC6
        MOVE.W  (A5),-$7C(A4,D7.L)              ; $26EBCC
        MOVE.W  $68(A5,D7.L),$7D61(A6)          ; $26EBD0
        MOVE.W  (A2)+,$7D4B(A6)                 ; $26EBD6
        MOVEQ   #$37,D7                         ; $26EBDA
        MOVEQ   #$28,D7                         ; $26EBDC
        MOVEQ   #$21,D7                         ; $26EBDE
        MOVE.W  (A6)+,-(A6)                     ; $26EBE0
        MOVE.W  (A5)+,-(A6)                     ; $26EBE2
        MOVE.W  (A5)+,-(A6)                     ; $26EBE4
        MOVEQ   #$1E,D7                         ; $26EBE6
        OR.B   -(A0),D0                         ; $26EBE8
        OR.B   -(A1),D0                         ; $26EBEA
        OR.B   -(A2),D0                         ; $26EBEC
        OR.B   D0,-(A4)                         ; $26EBEE
        OR.B   -(A7),D0                         ; $26EBF0
        MOVE.W  $39(A1,D7.L),-(A7)              ; $26EBF2
        MOVE.W  D5,$7F55(A7)                    ; $26EBF6
        OR.W   (A5)+,D0                         ; $26EBFA
        OR.W   (A6)+,D1                         ; $26EBFC
        OR.W   D0,-(A3)                         ; $26EBFE
        OR.W   -(A7),D0                         ; $26EC00
        OR.W   D0,-$7E9B(A0)                    ; $26EC02
        OR.W   D1,(A3)                          ; $26EC06
        OR.B   D2,$34(PC,A0.W)                  ; $26EC08
        OR.B   D2,$2E(A1,A0.W)                  ; $26EC0C
        OR.B   -$7CCF(A6),D2                    ; $26EC10
        OR.B   D1,#$824E                        ; $26EC14
        OR.W   D0,-$7D7E(A0)                    ; $26EC18
        OR.L   D2,D5                            ; $26EC1C
        OR.W   D4,$64(A6,A0.L)                  ; $26EC1E
        OR.W   -(A1),D7                         ; $26EC22
        OR.W   D5,-$6C(A4,A0.W)                 ; $26EC24
        OR.L   D1,$7FD6.W                       ; $26EC28
        MOVEQ   #-$1A,D7                        ; $26EC2C
        DC.W    $7FEC,$7FEF         ; $26EC2E MOVE.W  $7FEF(A4),<EA:3F>
        DC.W    $7FEF,$7EEE         ; $26EC32 MOVE.W  $7EEE(A7),<EA:3F>
        DC.W    $7DEC,$7CEA         ; $26EC36 MOVE.W  $7CEA(A4),<EA:3E>
        DC.W    $7BE8,$78E7         ; $26EC3A MOVE.W  $78E7(A0),<EA:3D>
        MOVE.W  -(A5),$74E4(PC)                 ; $26EC3E
        MOVEQ   #-$1D,D2                        ; $26EC42
        MOVEQ   #-$1F,D3                        ; $26EC44
        MOVEQ   #-$21,D5                        ; $26EC46
        MOVEQ   #-$2D,D6                        ; $26EC48
        DC.W    $7BC0               ; $26EC4A MOVE.W  D0,<EA:3D>
        DC.W    $79BF,$77C6         ; $26EC4C MOVE.W  <EA:3F>,-$3A(A4,D7.W)
        MOVEQ   #-$37,D3                        ; $26EC50
        MOVE.W  A7,-$2E(PC,D7.L)                ; $26EC52
        MOVEQ   #-$37,D4                        ; $26EC56
        DC.W    $79B9,$7AAA,$7C99,$7D84; $26EC58 MOVE.W  $7AAA7C99,-$7C(A4,D7.L)
        MOVE.W  $60(A2,D7.L),$7F4A(A6)          ; $26EC60
        OR.B   $802D.W,D0                       ; $26EC66
        MOVE.W  -(A4),-(A7)                     ; $26EC6A
        MOVE.W  (A5)+,-(A7)                     ; $26EC6C
        OR.B   D0,(A4)+                         ; $26EC6E
        OR.B   (A4)+,D1                         ; $26EC70
        OR.B   D1,(A5)+                         ; $26EC72
        OR.B   (A6)+,D2                         ; $26EC74
        OR.B   D2,(A7)+                         ; $26EC76
        OR.B   -(A0),D2                         ; $26EC78
        OR.B   -(A2),D2                         ; $26EC7A
        OR.B   D1,-(A3)                         ; $26EC7C
        OR.B   D1,-(A7)                         ; $26EC7E
        OR.B   $47(A7,A0.W),D1                  ; $26EC80
        OR.W   (A0),D1                          ; $26EC84
        OR.W   D1,(A0)                          ; $26EC86
        OR.W   D1,(A4)                          ; $26EC88
        OR.W   (A4)+,D1                         ; $26EC8A
        OR.W   D0,-(A3)                         ; $26EC8C
        OR.W   -$7F87(A5),D0                    ; $26EC8E
        OR.W   -$7E92(PC),D0                    ; $26EC92
        OR.W   D0,(A7)                          ; $26EC96
        OR.W   D7,D0                            ; $26EC98
        OR.B   D0,$30(A6,A0.W)                  ; $26EC9A
        OR.B   -$77D3(A6),D3                    ; $26EC9E
        OR.B   -$77D1(A6),D4                    ; $26ECA2
        OR.B   D3,$8557817B                     ; $26ECA6
        MOVE.W  (A7),-$55(A7,A0.W)              ; $26ECAC
        DC.W    $81BE               ; $26ECB0 OR.L   D0,<EA:3E>
        DIVS    A5,D0                           ; $26ECB2
        DC.W    $7FD8               ; $26ECB4 MOVE.W  (A0)+,<EA:3F>
        MOVEQ   #-$20,D6                        ; $26ECB6
        MOVEQ   #-$17,D5                        ; $26ECB8
        MOVEQ   #-$16,D4                        ; $26ECBA
        MOVEQ   #-$17,D4                        ; $26ECBC
        MOVEQ   #-$19,D5                        ; $26ECBE
        MOVEQ   #-$2B,D7                        ; $26ECC0
        OR.L   D0,-$60(A6,A0.W)                 ; $26ECC2
        OR.L   D0,-(A3)                         ; $26ECC6
        MOVEQ   #-$47,D6                        ; $26ECC8
        MOVEQ   #-$37,D4                        ; $26ECCA
        MOVE.W  (A0),-$2C(PC,D7.L)              ; $26ECCC
        MOVE.W  A7,#$7BBA                       ; $26ECD0
        MOVE.W  $7CB0(A2),-$3E(A6,D7.L)         ; $26ECD4
        MOVEQ   #-$32,D3                        ; $26ECDA
        MOVEQ   #-$32,D3                        ; $26ECDC
        MOVEQ   #-$33,D4                        ; $26ECDE
        MOVEQ   #-$30,D4                        ; $26ECE0
        MOVE.W  (A0),#$78C6                     ; $26ECE2
        MOVEQ   #-$47,D5                        ; $26ECE6
        MOVE.W  -(A5),-$73(A6,D7.L)             ; $26ECE8
        MOVEQ   #$75,D7                         ; $26ECEC
        MOVE.W  $7F66(A2),-$7FAA(A7)            ; $26ECEE
        OR.W   D0,D5                            ; $26ECF4
        OR.B   D1,$23(A1,A0.W)                  ; $26ECF6
        OR.B   D2,(A6)+                         ; $26ECFA
        OR.B   (A4)+,D3                         ; $26ECFC
        OR.B   (A3)+,D3                         ; $26ECFE
        OR.B   D2,(A4)+                         ; $26ED00
        OR.B   D1,(A6)+                         ; $26ED02
        OR.B   D0,(A7)+                         ; $26ED04
        OR.B   D0,-(A1)                         ; $26ED06
        OR.B   -(A2),D1                         ; $26ED08
        OR.B   -(A7),D1                         ; $26ED0A
        OR.B   D0,$3D(A0,A0.W)                  ; $26ED0C
        MOVE.W  (A4),$7D6C(A7)                  ; $26ED10
        DC.W    $7B79,$7A7D,$7C78,$7F6E; $26ED14 MOVE.W  $7A7D7C78,$7F6E(A5)
        OR.W   D0,-(A0)                         ; $26ED1C
        OR.W   A6,D1                            ; $26ED1E
        OR.B   D1,#$8330                        ; $26ED20
        OR.B   -$79D5(A5),D2                    ; $26ED24
        OR.B   -$75D4(A3),D4                    ; $26ED28
        OR.B   D5,-$75D0(A5)                    ; $26ED2C
        DC.W    $893D               ; $26ED30 OR.B   D4,<EA:3D>
        OR.W   D3,(A4)+                         ; $26ED32
        OR.W   D2,$8291.W                       ; $26ED34
        OR.L   D0,$7FC1(A5)                     ; $26ED38
        DC.W    $7DD5               ; $26ED3C MOVE.W  (A5),<EA:3E>
        MOVEQ   #-$1C,D6                        ; $26ED3E
        MOVEQ   #-$16,D5                        ; $26ED40
        MOVEQ   #-$15,D3                        ; $26ED42
        MOVE.W  $75EA(A3),$76E8(PC)             ; $26ED44
        MOVE.W  -(A6),#$7CDF                    ; $26ED4A
        DIVU    D1,D0                           ; $26ED4E
        OR.L   D0,-$4B(A0,A0.W)                 ; $26ED50
        DC.W    $7DC2               ; $26ED54 MOVE.W  D2,<EA:3E>
        DC.W    $7DC4               ; $26ED56 MOVE.W  D4,<EA:3E>
        MOVE.W  -$7F4E(PC),-$4B(A7,D7.L)        ; $26ED58
        MOVEQ   #-$3E,D5                        ; $26ED5E
        MOVEQ   #-$31,D4                        ; $26ED60
        MOVE.W  (A1),#$7ACD                     ; $26ED62
        MOVE.W  D5,#$78C1                       ; $26ED66
        MOVE.W  D6,-$36(PC,D7.L)                ; $26ED6A
        MOVE.W  A2,#$7BBF                       ; $26ED6E
        MOVE.W  $7F90(A1),$76(A6,A0.W)          ; $26ED72
        OR.W   -(A1),D1                         ; $26ED78
        OR.W   D0,A7                            ; $26ED7A
        MOVE.W  D5,$7F3A(A7)                    ; $26ED7C
        OR.B   -$7BE1(A4),D0                    ; $26ED80
        OR.B   (A4)+,D3                         ; $26ED84
        OR.B   D3,(A3)+                         ; $26ED86
        OR.B   D2,(A2)+                         ; $26ED88
        OR.B   (A3)+,D1                         ; $26ED8A
        OR.B   (A5)+,D0                         ; $26ED8C
        OR.B   (A6)+,D0                         ; $26ED8E
        OR.B   D0,-(A0)                         ; $26ED90
        OR.B   $7E3F(A0),D0                     ; $26ED92
        MOVEQ   #$4B,D7                         ; $26ED96
        MOVE.W  D7,-$7DBD(A7)                   ; $26ED98
        OR.W   A7,D0                            ; $26ED9C
        MOVE.W  -(A1),$7D6A(A6)                 ; $26ED9E
        MOVEQ   #$72,D7                         ; $26EDA2
        OR.W   -$7F7C(PC),D0                    ; $26EDA4
        OR.L   A0,D0                            ; $26EDA8
        OR.L   D5,D1                            ; $26EDAA
        DC.W    $857E               ; $26EDAC OR.W   D2,<EA:3E>
        OR.W   $5A(A0,A0.W),D3                  ; $26EDAE
        DC.W    $883D               ; $26EDB2 OR.B   <EA:3D>,D4
        OR.B   D4,$2C(A1,A0.L)                  ; $26EDB4
        OR.B   D4,-$77D7(A1)                    ; $26EDB8
        OR.B   D1,$7C3F(A4)                     ; $26EDBC
        MOVE.W  #$76AE,$77D1(A3)                ; $26EDC0
        MOVE.W  (A7)+,-$18(PC,D7.W)             ; $26EDC6
        MOVE.W  $7AE5(A2),-$2B(PC,D7.L)         ; $26EDCA
        MOVE.W  $7D(A0,A0.W),$63(A7,A0.W)       ; $26EDD0
        OR.W   D2,$7E87(A1)                     ; $26EDD6
        MOVEQ   #-$5A,D5                        ; $26EDDA
        MOVE.W  $7DC5(PC),-$3E(A5,D7.L)         ; $26EDDC
        MOVEQ   #-$40,D7                        ; $26EDE2
        MOVEQ   #-$36,D6                        ; $26EDE4
        MOVEQ   #-$2B,D5                        ; $26EDE6
        MOVEQ   #-$26,D4                        ; $26EDE8
        MOVE.W  (A2)+,-$2B(PC,D7.L)             ; $26EDEA
        MOVEQ   #-$38,D5                        ; $26EDEE
        MOVEQ   #-$3A,D5                        ; $26EDF0
        MOVE.W  A5,-$2D(PC,D7.W)                ; $26EDF2
        MOVE.W  (A3),-$36(PC,D7.L)              ; $26EDF6
        MOVE.W  -$59(A6,D7.L),-$5D(A6,D7.L)     ; $26EDFA
        MOVEQ   #-$61,D7                        ; $26EE00
        MOVEQ   #-$64,D7                        ; $26EE02
        MOVE.W  (A5)+,-$6F(A7,A0.W)             ; $26EE04
        OR.W   D0,$6F(PC,A0.W)                  ; $26EE08
        OR.W   D0,-(A7)                         ; $26EE0C
        OR.W   (A3)+,D0                         ; $26EE0E
        DC.W    $803F               ; $26EE10 OR.B   <EA:3F>,D0
        OR.B   D0,-(A5)                         ; $26EE12
        OR.B   (A5)+,D1                         ; $26EE14
        OR.B   (A2)+,D1                         ; $26EE16
        OR.B   (A7),D1                          ; $26EE18
        OR.B   (A7),D2                          ; $26EE1A
        OR.B   (A1)+,D3                         ; $26EE1C
        OR.B   D2,(A2)+                         ; $26EE1E
        OR.B   (A4)+,D2                         ; $26EE20
        OR.B   (A5)+,D2                         ; $26EE22
        OR.B   D2,(A7)+                         ; $26EE24
        OR.B   -(A0),D3                         ; $26EE26
        OR.B   D3,-(A1)                         ; $26EE28
        OR.B   D3,-(A3)                         ; $26EE2A
        OR.B   D3,-(A5)                         ; $26EE2C
        OR.B   D2,$4C(A5,A0.W)                  ; $26EE2E
        OR.W   (A0)+,D0                         ; $26EE32
        OR.W   (A2)+,D0                         ; $26EE34
        OR.W   (A5)+,D0                         ; $26EE36
        MOVE.W  -(A1),$7F5F(A7)                 ; $26EE38
        OR.W   A5,D0                            ; $26EE3C
        OR.B   D1,$31(A7,A0.W)                  ; $26EE3E
        OR.B   -$7CD5(A6),D3                    ; $26EE42
        OR.B   D0,$7F31(A4)                     ; $26EE46
        MOVE.W  A6,$7B77(A6)                    ; $26EE4A
        MOVE.W  (A5),-$54(A5,D7.L)              ; $26EE4E
        MOVEQ   #-$39,D5                        ; $26EE52
        DC.W    $7BDE               ; $26EE54 MOVE.W  (A6)+,<EA:3D>
        DC.W    $7BE5               ; $26EE56 MOVE.W  -(A5),<EA:3D>
        MOVEQ   #-$23,D7                        ; $26EE58
        DIVU    (A3),D1                         ; $26EE5A
        DIVS    (A1),D1                         ; $26EE5C
        DIVS    (A4),D0                         ; $26EE5E
        DC.W    $7FD9               ; $26EE60 MOVE.W  (A1)+,<EA:3F>
        DC.W    $7FE0               ; $26EE62 MOVE.W  -(A0),<EA:3F>
        DIVU    -(A1),D0                        ; $26EE64
        DIVS    -(A1),D0                        ; $26EE66
        DIVU    (A4)+,D1                        ; $26EE68
        DIVU    (A7),D1                         ; $26EE6A
        DIVU    (A4)+,D0                        ; $26EE6C
        DC.W    $7DDD               ; $26EE6E MOVE.W  (A5)+,<EA:3E>
        MOVEQ   #-$24,D5                        ; $26EE70
        MOVE.W  (A3)+,-$25(PC,D7.W)             ; $26EE72
        MOVEQ   #-$26,D4                        ; $26EE76
        MOVEQ   #-$29,D5                        ; $26EE78
        MOVEQ   #-$2A,D6                        ; $26EE7A
        MOVEQ   #-$2A,D5                        ; $26EE7C
        MOVEQ   #-$2B,D4                        ; $26EE7E
        MOVEQ   #-$2E,D5                        ; $26EE80
        DC.W    $7DC4               ; $26EE82 MOVE.W  D4,<EA:3E>
        DC.W    $7DBE,$7AC4         ; $26EE84 MOVE.W  <EA:3E>,-$3C(A6,D7.L)
        MOVE.W  A3,-$37(PC,D7.L)                ; $26EE88
        MOVEQ   #-$44,D7                        ; $26EE8C
        OR.L   -(A1),D0                         ; $26EE8E
        OR.L   D0,A3                            ; $26EE90
        DC.W    $7F7E,$7F6B         ; $26EE92 MOVE.W  <EA:3E>,$7F6B(A7)
        MOVE.W  (A6)+,$7E55(A7)                 ; $26EE96
        MOVE.W  A3,$7F3D(A6)                    ; $26EE9A
        OR.B   -$7DDF(A6),D0                    ; $26EE9E
        OR.B   (A0)+,D1                         ; $26EEA2
        OR.B   D1,(A5)                          ; $26EEA4
        OR.B   D2,(A4)                          ; $26EEA6
        OR.B   D3,(A4)                          ; $26EEA8
        OR.B   D3,(A6)                          ; $26EEAA
        OR.B   (A7),D3                          ; $26EEAC
        OR.B   D3,(A0)+                         ; $26EEAE
        OR.B   D3,(A2)+                         ; $26EEB0
        OR.B   (A3)+,D3                         ; $26EEB2
        OR.B   D2,(A4)+                         ; $26EEB4
        OR.B   D2,(A5)+                         ; $26EEB6
        OR.B   D2,(A7)+                         ; $26EEB8
        OR.B   -(A0),D2                         ; $26EEBA
        OR.B   -(A1),D1                         ; $26EEBC
        OR.B   D0,-(A2)                         ; $26EEBE
        OR.B   -(A3),D1                         ; $26EEC0
        OR.B   D1,-(A4)                         ; $26EEC2
        OR.B   -(A6),D1                         ; $26EEC4
        OR.B   D0,-$7FCB(A2)                    ; $26EEC6
        OR.B   $8233832E,D0                     ; $26EECA
        OR.B   -$7FD2(A6),D1                    ; $26EED0
        MOVE.W  $793B(A7),-(A6)                 ; $26EED4
        MOVE.W  $74A1(A4),$74CA(A3)             ; $26EED8
        MOVEQ   #-$22,D3                        ; $26EEDE
        MOVE.W  -(A7),#$7CED                    ; $26EEE0
        DC.W    $7FED,$81EB         ; $26EEE4 MOVE.W  -$7E15(A5),<EA:3F>
        DC.W    $7FE9,$7DE7         ; $26EEE8 MOVE.W  $7DE7(A1),<EA:3F>
        DC.W    $7DE4               ; $26EEEC MOVE.W  -(A4),<EA:3E>
        DC.W    $7FDF               ; $26EEEE MOVE.W  (A7)+,<EA:3F>
        DIVU    D5,D1                           ; $26EEF0
        OR.L   -(A2),D2                         ; $26EEF2
        OR.L   A6,D2                            ; $26EEF4
        OR.L   D0,A4                            ; $26EEF6
        MOVE.W  (A3),-$5B(A7,D7.L)              ; $26EEF8
        DC.W    $7BBE,$7AD1         ; $26EEFC MOVE.W  <EA:3E>,-$2F(A5,D7.L)
        MOVEQ   #-$29,D5                        ; $26EF00
        MOVEQ   #-$25,D5                        ; $26EF02
        DC.W    $7BDC               ; $26EF04 MOVE.W  (A4)+,<EA:3D>
        DC.W    $7DD6               ; $26EF06 MOVE.W  (A6),<EA:3E>
        MOVEQ   #-$38,D7                        ; $26EF08
        MOVEQ   #-$46,D7                        ; $26EF0A
        MOVE.W  -$54(A2,D7.L),-$50(A6,D7.L)     ; $26EF0C
        MOVE.W  #$79BF,-$44(A4,D7.L)            ; $26EF12
        MOVE.W  $7FB3.W,-$49(A7,D7.L)           ; $26EF18
        DC.W    $7BBE,$7CAC         ; $26EF1E MOVE.W  <EA:3E>,-$54(A5,D7.L)
        OR.L   D6,D0                            ; $26EF22
        OR.W   D1,(A6)+                         ; $26EF24
        OR.W   A2,D1                            ; $26EF26
        OR.W   A5,D0                            ; $26EF28
        MOVE.W  (A1)+,$7E52(A6)                 ; $26EF2A
        OR.B   $8525841D,D1                     ; $26EF2E
        OR.B   (A2)+,D1                         ; $26EF34
        OR.B   (A7),D1                          ; $26EF36
        OR.B   D1,(A7)                          ; $26EF38
        OR.B   (A0)+,D2                         ; $26EF3A
        OR.B   (A1)+,D2                         ; $26EF3C
        OR.B   D1,(A3)+                         ; $26EF3E
        OR.B   (A4)+,D2                         ; $26EF40
        OR.B   D2,(A6)+                         ; $26EF42
        OR.B   (A7)+,D2                         ; $26EF44
        OR.B   D1,-(A0)                         ; $26EF46
        OR.B   D2,-(A1)                         ; $26EF48
        OR.B   D2,-(A2)                         ; $26EF4A
        OR.B   -(A3),D2                         ; $26EF4C
        OR.B   -(A4),D1                         ; $26EF4E
        OR.B   D0,-(A5)                         ; $26EF50
        OR.B   -(A6),D1                         ; $26EF52
        OR.B   D1,-$7DD7(A0)                    ; $26EF54
        OR.B   D0,-$7FD5(A2)                    ; $26EF58
        MOVEQ   #$2D,D7                         ; $26EF5C
        MOVEQ   #$32,D5                         ; $26EF5E
        MOVEQ   #$4D,D4                         ; $26EF60
        DC.W    $7779,$78A1,$79CA,$79DE; $26EF62 MOVE.W  $78A179CA,$79DE(A3)
        MOVE.W  -(A7),#$7BEB                    ; $26EF6A
        DIVU    -$7C1C(A3),D0                   ; $26EF6E
        DIVS    -(A0),D1                        ; $26EF72
        DIVU    -(A2),D1                        ; $26EF74
        DIVU    -(A3),D0                        ; $26EF76
        DC.W    $7FE2               ; $26EF78 MOVE.W  -(A2),<EA:3F>
        DIVS    (A7)+,D0                        ; $26EF7A
        DIVS    (A4),D1                         ; $26EF7C
        DIVS    A2,D1                           ; $26EF7E
        DIVU    D4,D1                           ; $26EF80
        DC.W    $80BE               ; $26EF82 OR.L   <EA:3E>,D0
        MOVE.W  #$7EBE,-$3C(A7,D7.L)            ; $26EF84
        DC.W    $7BC6               ; $26EF8A MOVE.W  D6,<EA:3D>
        DC.W    $7BC1               ; $26EF8C MOVE.W  D1,<EA:3D>
        MOVEQ   #-$45,D6                        ; $26EF8E
        MOVEQ   #-$40,D6                        ; $26EF90
        MOVEQ   #-$34,D5                        ; $26EF92
        MOVE.W  A5,#$7AC5                       ; $26EF94
        MOVE.W  $7FA7.W,-$66(A6,A0.W)           ; $26EF98
        MOVE.W  (A3)+,-$55(A7,D7.L)             ; $26EF9E
        MOVE.W  -$4A(A6,D7.L),-$4D(A6,D7.L)     ; $26EFA2
        MOVEQ   #-$54,D7                        ; $26EFA8
        MOVE.W  (A7)+,-$70(A7,A0.W)             ; $26EFAA
        OR.L   D1,D0                            ; $26EFAE
        MOVEQ   #$77,D7                         ; $26EFB0
        MOVEQ   #$69,D7                         ; $26EFB2
        MOVE.W  A6,-$7FC9(A7)                   ; $26EFB4
        OR.B   $7E22(A5),D0                     ; $26EFB8
        MOVEQ   #$17,D7                         ; $26EFBC
        MOVE.W  (A5),-(A7)                      ; $26EFBE
        OR.B   (A5),D0                          ; $26EFC0
        OR.B   D0,(A5)                          ; $26EFC2
        OR.B   D1,(A6)                          ; $26EFC4
        OR.B   D2,(A0)+                         ; $26EFC6
        OR.B   D3,(A1)+                         ; $26EFC8
        OR.B   D3,(A2)+                         ; $26EFCA
        OR.B   D2,(A4)+                         ; $26EFCC
        OR.B   D2,(A5)+                         ; $26EFCE
        OR.B   D2,(A6)+                         ; $26EFD0
        OR.B   D2,(A7)+                         ; $26EFD2
        OR.B   D1,-(A0)                         ; $26EFD4
        OR.B   -(A2),D1                         ; $26EFD6
        OR.B   -(A4),D0                         ; $26EFD8
        MOVEQ   #$2F,D7                         ; $26EFDA
        DC.W    $7D3F               ; $26EFDC MOVE.W  <EA:3F>,-(A6)
        MOVE.W  A6,$7D60(A6)                    ; $26EFDE
        MOVEQ   #$76,D6                         ; $26EFE2
        MOVEQ   #-$79,D5                        ; $26EFE4
        MOVEQ   #-$6C,D5                        ; $26EFE6
        MOVE.W  (A3)+,-$6B(A5,D7.L)             ; $26EFE8
        MOVEQ   #$71,D7                         ; $26EFEC
        OR.W   D0,D5                            ; $26EFEE
        OR.B   $823B.W,D1                       ; $26EFF0
        OR.W   D0,(A7)                          ; $26EFF4
        OR.L   D3,D0                            ; $26EFF6
        MOVE.W  -$2E(A7,D7.L),-$22(A7,D7.L)     ; $26EFF8
        DC.W    $7DE4               ; $26EFFE MOVE.W  -(A4),<EA:3E>
        MOVEQ   #-$1B,D7                        ; $26F000
        MOVEQ   #-$23,D7                        ; $26F002
        DC.W    $7DD6               ; $26F004 MOVE.W  (A6),<EA:3E>
        MOVEQ   #-$31,D6                        ; $26F006
        DC.W    $7BCA               ; $26F008 MOVE.W  A2,<EA:3D>
        MOVEQ   #-$33,D5                        ; $26F00A
        MOVE.W  A4,#$7AC5                       ; $26F00C
        DC.W    $7BBF,$7CBE         ; $26F010 MOVE.W  <EA:3F>,-$42(A5,D7.L)
        DC.W    $7BC0               ; $26F014 MOVE.W  D0,<EA:3D>
        DC.W    $7BC7               ; $26F016 MOVE.W  D7,<EA:3D>
        MOVEQ   #-$36,D5                        ; $26F018
        DC.W    $7BCE               ; $26F01A MOVE.W  A6,<EA:3D>
        DC.W    $7BD2               ; $26F01C MOVE.W  (A2),<EA:3D>
        MOVEQ   #-$36,D6                        ; $26F01E
        MOVEQ   #-$44,D7                        ; $26F020
        MOVE.W  -$58(A0,A0.W),-$5D(A7,A0.W)     ; $26F022
        OR.L   D0,-(A0)                         ; $26F028
        OR.L   -(A1),D0                         ; $26F02A
        OR.L   D0,(A4)+                         ; $26F02C
        OR.L   (A5),D1                          ; $26F02E
        OR.L   D0,(A0)+                         ; $26F030
        MOVE.W  (A7)+,-$5E(A7,D7.L)             ; $26F032
        MOVEQ   #-$62,D7                        ; $26F036
        MOVEQ   #-$68,D7                        ; $26F038
        MOVE.W  A1,$70(A7,D7.L)                 ; $26F03A
        OR.W   (A2)+,D0                         ; $26F03E
        OR.W   A5,D0                            ; $26F040
        DC.W    $7F3F               ; $26F042 MOVE.W  <EA:3F>,-(A7)
        MOVE.W  -$7FE5(A4),-(A7)                ; $26F044
        OR.B   D0,(A7)                          ; $26F048
        OR.B   (A5),D2                          ; $26F04A
        OR.B   D2,(A4)                          ; $26F04C
        OR.B   (A5),D3                          ; $26F04E
        OR.B   (A7),D3                          ; $26F050
        OR.B   (A0)+,D3                         ; $26F052
        OR.B   D2,(A2)+                         ; $26F054
        OR.B   (A3)+,D2                         ; $26F056
        OR.B   (A4)+,D2                         ; $26F058
        OR.B   (A5)+,D2                         ; $26F05A
        OR.B   (A6)+,D2                         ; $26F05C
        OR.B   D2,-(A0)                         ; $26F05E
        OR.B   D2,-(A1)                         ; $26F060
        OR.B   D1,-(A2)                         ; $26F062
        OR.B   D0,-(A3)                         ; $26F064
        MOVE.W  -(A7),-(A7)                     ; $26F066
        MOVEQ   #$37,D7                         ; $26F068
        MOVE.W  A4,$7C62(A6)                    ; $26F06A
        MOVE.W  $7E(A7,D7.L),$7F75(A6)          ; $26F06E
        OR.W   -(A2),D0                         ; $26F074
        OR.W   (A0),D0                          ; $26F076
        DC.W    $803F               ; $26F078 OR.B   <EA:3F>,D0
        OR.B   $33(A7,A0.W),D0                  ; $26F07A
        DC.W    $813D               ; $26F07E OR.B   D0,<EA:3D>
        OR.W   (A3),D0                          ; $26F080
        MOVE.W  -$6E(A4,D7.L),$7DA7(A7)         ; $26F082
        MOVE.W  $7ECD(PC),-$21(A6,D7.L)         ; $26F088
        MOVEQ   #-$1B,D5                        ; $26F08E
        MOVE.W  -(A6),#$7AE7                    ; $26F090
        MOVEQ   #-$1A,D5                        ; $26F094
        MOVE.W  -(A4),#$79E3                    ; $26F096
        MOVE.W  -(A1),#$7CE0                    ; $26F09A
        DC.W    $7DDF               ; $26F09E MOVE.W  (A7)+,<EA:3E>
        MOVEQ   #-$23,D6                        ; $26F0A0
        MOVEQ   #-$24,D6                        ; $26F0A2
        DC.W    $7DDB               ; $26F0A4 MOVE.W  (A3)+,<EA:3E>
        MOVEQ   #-$26,D7                        ; $26F0A6
        DC.W    $7DD9               ; $26F0A8 MOVE.W  (A1)+,<EA:3E>
        DC.W    $7DD8               ; $26F0AA MOVE.W  (A0)+,<EA:3E>
        DC.W    $7FD6               ; $26F0AC MOVE.W  (A6),<EA:3F>
        DIVS    (A5),D0                         ; $26F0AE
        DIVS    (A2),D0                         ; $26F0B0
        DIVU    D2,D1                           ; $26F0B2
        OR.L   -$7E58(A6),D1                    ; $26F0B4
        OR.L   -(A3),D0                         ; $26F0B8
        MOVE.W  -(A2),-$58(A7,D7.L)             ; $26F0BA
        MOVE.W  $7DA3(A1),-$6C(A6,D7.L)         ; $26F0BE
        MOVE.W  D3,$70(A6,D7.L)                 ; $26F0C4
        MOVEQ   #$59,D7                         ; $26F0C8
        DC.W    $7F3E               ; $26F0CA MOVE.W  <EA:3E>,-(A7)
        MOVE.W  $2D(A1,D7.L),-(A7)              ; $26F0CC
        MOVEQ   #$29,D7                         ; $26F0D0
        MOVEQ   #$21,D7                         ; $26F0D2
        OR.B   (A0)+,D0                         ; $26F0D4
        OR.B   D1,(A7)                          ; $26F0D6
        OR.B   D2,(A7)                          ; $26F0D8
        OR.B   D2,(A7)                          ; $26F0DA
        OR.B   (A0)+,D1                         ; $26F0DC
        OR.B   D1,(A1)+                         ; $26F0DE
        OR.B   D1,(A2)+                         ; $26F0E0
        OR.B   (A4)+,D2                         ; $26F0E2
        OR.B   D1,(A5)+                         ; $26F0E4
        OR.B   D1,(A6)+                         ; $26F0E6
        OR.B   D2,(A7)+                         ; $26F0E8
        OR.B   -(A1),D3                         ; $26F0EA
        OR.B   D2,-(A2)                         ; $26F0EC
        OR.B   -(A3),D1                         ; $26F0EE
        MOVE.W  -(A4),-(A7)                     ; $26F0F0
        MOVE.W  -(A5),-(A6)                     ; $26F0F2
        MOVE.W  -(A7),-(A5)                     ; $26F0F4
        MOVE.W  $7C3F(A4),-(A5)                 ; $26F0F6
        MOVE.W  (A5),$7C68(A6)                  ; $26F0FA
        MOVEQ   #$70,D6                         ; $26F0FE
        MOVEQ   #$6E,D6                         ; $26F100
        MOVE.W  $7E6A(A5),-$7EA8(A6)            ; $26F102
        OR.W   D2,D2                            ; $26F108
        OR.W   D1,D2                            ; $26F10A
        OR.W   (A3),D1                          ; $26F10C
        MOVE.W  -$69(A6,D7.L),$7EB7(A7)         ; $26F10E
        DIVU    A7,D0                           ; $26F114
        DIVU    -(A0),D0                        ; $26F116
        MOVEQ   #-$19,D7                        ; $26F118
        DC.W    $7DE9,$7CE9         ; $26F11A MOVE.W  $7CE9(A1),<EA:3E>
        MOVEQ   #-$18,D6                        ; $26F11E
        DC.W    $7BE6               ; $26F120 MOVE.W  -(A6),<EA:3D>
        MOVEQ   #-$1C,D6                        ; $26F122
        MOVEQ   #-$1D,D6                        ; $26F124
        DC.W    $7DE1               ; $26F126 MOVE.W  -(A1),<EA:3E>
        DC.W    $7FE0               ; $26F128 MOVE.W  -(A0),<EA:3F>
        DIVU    (A7)+,D0                        ; $26F12A
        DIVS    (A5)+,D0                        ; $26F12C
        DIVS    (A0)+,D0                        ; $26F12E
        DIVU    (A6),D0                         ; $26F130
        DC.W    $7FD4               ; $26F132 MOVE.W  (A4),<EA:3F>
        DC.W    $7FD5               ; $26F134 MOVE.W  (A5),<EA:3F>
        DIVU    (A2),D0                         ; $26F136
        DIVS    D4,D0                           ; $26F138
        OR.L   D1,-$7B6B(A3)                    ; $26F13A
        OR.L   D1,A7                            ; $26F13E
        OR.L   (A5),D0                          ; $26F140
        MOVE.W  (A7)+,-$5F(A7,A0.W)             ; $26F142
        OR.L   (A2)+,D0                         ; $26F146
        MOVE.W  (A1),-$6D(A7,D7.L)              ; $26F148
        MOVEQ   #-$60,D5                        ; $26F14C
        MOVE.W  -(A3),-$68(A4,D7.L)             ; $26F14E
        MOVE.W  A3,$7C(A4,D7.L)                 ; $26F152
        MOVEQ   #$79,D5                         ; $26F156
        MOVE.W  $61(A7,D7.L),$7F3E(A5)          ; $26F158
        OR.B   D0,-$7ED8(A3)                    ; $26F15E
        MOVE.W  -(A2),-(A7)                     ; $26F162
        MOVE.W  (A1)+,-(A7)                     ; $26F164
        OR.B   D0,(A7)                          ; $26F166
        OR.B   D0,(A0)+                         ; $26F168
        OR.B   D0,(A1)+                         ; $26F16A
        OR.B   D0,(A2)+                         ; $26F16C
        OR.B   D0,(A3)+                         ; $26F16E
        OR.B   D1,(A5)+                         ; $26F170
        OR.B   (A6)+,D2                         ; $26F172
        OR.B   D1,(A7)+                         ; $26F174
        OR.B   -(A0),D1                         ; $26F176
        OR.B   D0,-(A1)                         ; $26F178
        MOVE.W  -(A5),-(A7)                     ; $26F17A
        MOVEQ   #$2C,D7                         ; $26F17C
        MOVE.W  $7F28(A2),-(A7)                 ; $26F17E
        MOVE.W  $3C(A1,D7.L),-(A7)              ; $26F182
        MOVE.W  A4,-$7FA8(A7)                   ; $26F186
        OR.W   D0,(A7)+                         ; $26F18A
        OR.W   D0,-(A3)                         ; $26F18C
        OR.W   (A6)+,D1                         ; $26F18E
        OR.W   D2,A1                            ; $26F190
        OR.B   $34(A7,A0.L),D4                  ; $26F192
        OR.B   D2,-$7EA4(PC)                    ; $26F196
        DC.W    $807F               ; $26F19A OR.W   <EA:3F>,D0
        OR.L   D0,(A4)+                         ; $26F19C
        OR.L   $80D380DA,D1                     ; $26F19E
        DIVU    (A0)+,D0                        ; $26F1A4
        DIVU    (A4)+,D0                        ; $26F1A6
        MOVEQ   #-$23,D7                        ; $26F1A8
        MOVEQ   #-$1D,D5                        ; $26F1AA
        MOVE.W  -(A4),-$1C(PC,D7.W)             ; $26F1AC
        MOVE.W  -(A4),#$7CE3                    ; $26F1B0
        DC.W    $7DE2               ; $26F1B4 MOVE.W  -(A2),<EA:3E>
        MOVEQ   #-$20,D7                        ; $26F1B6
        DIVS    (A7)+,D0                        ; $26F1B8
        DIVU    (A1)+,D1                        ; $26F1BA
        DIVU    A6,D1                           ; $26F1BC
        DIVU    D7,D1                           ; $26F1BE
        DIVU    D6,D1                           ; $26F1C0
        DIVS    D7,D0                           ; $26F1C2
        DIVS    D4,D0                           ; $26F1C4
        DC.W    $81BF               ; $26F1C6 OR.L   D0,<EA:3F>
        OR.L   -$58(A5,A0.W),D0                 ; $26F1C8
        OR.L   -(A6),D0                         ; $26F1CC
        MOVEQ   #-$58,D7                        ; $26F1CE
        MOVEQ   #-$5C,D6                        ; $26F1D0
        MOVEQ   #-$66,D6                        ; $26F1D2
        MOVE.W  (A5),-$66(A5,D7.L)              ; $26F1D4
        MOVEQ   #-$65,D4                        ; $26F1D8
        MOVEQ   #-$73,D4                        ; $26F1DA
        DC.W    $797F,$7A79         ; $26F1DC MOVE.W  <EA:3F>,$7A79(A4)
        MOVEQ   #$76,D5                         ; $26F1E0
        MOVEQ   #$72,D5                         ; $26F1E2
        MOVE.W  -(A4),$7C53(A5)                 ; $26F1E4
        MOVE.W  D5,$7C39(A6)                    ; $26F1E8
        MOVEQ   #$2D,D6                         ; $26F1EC
        MOVE.W  -(A3),-(A6)                     ; $26F1EE
        MOVE.W  (A6)+,-(A7)                     ; $26F1F0
        OR.B   (A2)+,D0                         ; $26F1F2
        OR.B   (A2)+,D1                         ; $26F1F4
        OR.B   D1,(A3)+                         ; $26F1F6
        OR.B   D1,(A3)+                         ; $26F1F8
        OR.B   D1,(A5)+                         ; $26F1FA
        OR.B   (A6)+,D1                         ; $26F1FC
        OR.B   D1,(A7)+                         ; $26F1FE
        OR.B   D1,-(A1)                         ; $26F200
        OR.B   D1,-(A2)                         ; $26F202
        OR.B   D0,-(A3)                         ; $26F204
        OR.B   D0,-(A4)                         ; $26F206
        OR.B   -(A5),D1                         ; $26F208
        OR.B   -(A6),D1                         ; $26F20A
        OR.B   D0,-$7ED3(A0)                    ; $26F20C
        DC.W    $803F               ; $26F210 OR.B   <EA:3F>,D0
        OR.W   (A5),D0                          ; $26F212
        MOVE.W  $7D77(A2),$7E7F(A7)             ; $26F214
        OR.L   D0,D4                            ; $26F21A
        OR.L   D1,D0                            ; $26F21C
        DC.W    $847F               ; $26F21E OR.W   <EA:3F>,D2
        DC.W    $847E               ; $26F220 OR.W   <EA:3E>,D2
        OR.W   $8563.W,D2                       ; $26F222
        OR.W   D3,D3                            ; $26F226
        OR.B   $8336.W,D3                       ; $26F228
        MOVEQ   #$4A,D7                         ; $26F22C
        MOVE.W  -$56(A4,D7.L),$78D0(A5)         ; $26F22E
        MOVE.W  -(A0),-$18(PC,D7.W)             ; $26F234
        MOVE.W  $7BEC(A4),#$7DEA                ; $26F238
        DC.W    $7DE8,$7DE6         ; $26F23E MOVE.W  $7DE6(A0),<EA:3E>
        MOVEQ   #-$1C,D7                        ; $26F242
        MOVEQ   #-$1D,D7                        ; $26F244
        MOVEQ   #-$1F,D7                        ; $26F246
        MOVEQ   #-$21,D7                        ; $26F248
        DIVU    (A3),D0                         ; $26F24A
        DIVS    D4,D0                           ; $26F24C
        OR.L   D0,-$55(A6,A0.W)                 ; $26F24E
        OR.L   D0,-(A2)                         ; $26F252
        OR.L   D0,(A1)                          ; $26F254
        OR.L   D0,D2                            ; $26F256
        MOVE.W  D4,-$75(A7,D7.L)                ; $26F258
        MOVE.W  A6,-$74(A4,D7.L)                ; $26F25C
        MOVEQ   #-$7B,D5                        ; $26F260
        MOVEQ   #-$7D,D5                        ; $26F262
        MOVE.W  D2,$7F(A4,D7.L)                 ; $26F264
        MOVE.W  D0,-$73(A4,D7.L)                ; $26F268
        MOVE.W  (A6),-$6D(A4,D7.L)              ; $26F26C
        MOVE.W  (A2),-$75(A5,D7.L)              ; $26F270
        DC.W    $7F7E,$806E         ; $26F274 MOVE.W  <EA:3E>,-$7F92(A7)
        OR.W   D0,(A3)+                         ; $26F278
        OR.W   D0,A2                            ; $26F27A
        DC.W    $803E               ; $26F27C OR.B   <EA:3E>,D0
        OR.B   -$7DDE(A5),D0                    ; $26F27E
        OR.B   (A7)+,D3                         ; $26F282
        OR.B   D3,(A6)+                         ; $26F284
        OR.B   D3,(A6)+                         ; $26F286
        OR.B   (A7)+,D3                         ; $26F288
        OR.B   -(A1),D2                         ; $26F28A
        OR.B   D0,-(A4)                         ; $26F28C
        MOVE.W  $7F26(A0),-(A7)                 ; $26F28E
        OR.B   -(A6),D0                         ; $26F292
        OR.B   D0,-(A7)                         ; $26F294
        OR.B   -$7DD7(A0),D1                    ; $26F296
        OR.B   D0,-$7FD0(A2)                    ; $26F29A
        MOVEQ   #$3B,D7                         ; $26F29E
        MOVE.W  D4,-$7BC0(A7)                   ; $26F2A0
        OR.B   D4,$34(A5,A0.L)                  ; $26F2A4
        OR.B   D4,$8641.W                       ; $26F2A8
        OR.W   D1,A5                            ; $26F2AC
        OR.W   D1,(A2)+                         ; $26F2AE
        OR.W   -(A2),D2                         ; $26F2B0
        OR.W   D2,(A4)+                         ; $26F2B2
        OR.W   (A4),D3                          ; $26F2B4
        OR.W   (A4)+,D2                         ; $26F2B6
        DC.W    $7F7F,$7AAF         ; $26F2B8 MOVE.W  <EA:3F>,$7AAF(A7)
        MOVEQ   #-$2A,D3                        ; $26F2BC
        MOVEQ   #-$1C,D3                        ; $26F2BE
        MOVE.W  $78F1(A5),-$0F(PC,D7.L)         ; $26F2C0
        DC.W    $7BEF,$7BED         ; $26F2C6 MOVE.W  $7BED(A7),<EA:3D>
        MOVEQ   #-$15,D5                        ; $26F2CA
        MOVEQ   #-$16,D5                        ; $26F2CC
        MOVEQ   #-$18,D6                        ; $26F2CE
        MOVEQ   #-$19,D7                        ; $26F2D0
        DIVU    -(A6),D0                        ; $26F2D2
        DC.W    $7FE4               ; $26F2D4 MOVE.W  -(A4),<EA:3F>
        DC.W    $7FE3               ; $26F2D6 MOVE.W  -(A3),<EA:3F>
        MOVEQ   #-$21,D7                        ; $26F2D8
        MOVEQ   #-$2F,D7                        ; $26F2DA
        MOVEQ   #-$42,D7                        ; $26F2DC
        MOVE.W  $7E9A(A2),-$6C(A7,D7.L)         ; $26F2DE
        MOVE.W  D6,$75(A6,D7.L)                 ; $26F2E4
        MOVEQ   #$75,D6                         ; $26F2E8
        MOVE.W  A0,-$63(A5,D7.L)                ; $26F2EA
        MOVEQ   #-$5C,D5                        ; $26F2EE
        MOVE.W  (A0)+,$7D(A6,D7.L)              ; $26F2F0
        MOVE.W  $7C(A0,D7.L),$7A9B(A7)          ; $26F2F4
        DC.W    $79BE,$7CC3         ; $26F2FA MOVE.W  <EA:3E>,-$3D(A4,D7.L)
        MOVE.W  -$64(A2,A0.W),-$78(A7,A0.W)     ; $26F2FE
        DC.W    $807F               ; $26F304 OR.W   <EA:3F>,D0
        OR.W   D0,-(A6)                         ; $26F306
        OR.W   D6,D1                            ; $26F308
        OR.B   $33(PC,A0.W),D1                  ; $26F30A
        MOVE.W  $28(A0,A0.W),-(A7)              ; $26F30E
        OR.B   -(A1),D1                         ; $26F312
        OR.B   D1,-(A0)                         ; $26F314
        OR.B   -(A1),D1                         ; $26F316
        OR.B   -(A1),D0                         ; $26F318
        OR.B   -(A2),D0                         ; $26F31A
        OR.B   D0,-(A3)                         ; $26F31C
        OR.B   D0,-(A4)                         ; $26F31E
        OR.B   -(A5),D0                         ; $26F320
        MOVE.W  -(A6),-(A7)                     ; $26F322
        MOVEQ   #$28,D7                         ; $26F324
        MOVE.W  $7F2B(A1),-(A7)                 ; $26F326
        OR.B   D0,-$7CD4(A7)                    ; $26F32A
        OR.B   -$76D2(A5),D3                    ; $26F32E
        OR.B   -$79D0(A7),D4                    ; $26F332
        OR.B   D2,$3C(A2,A0.W)                  ; $26F336
        OR.W   D6,D2                            ; $26F33A
        OR.W   A7,D3                            ; $26F33C
        OR.W   D3,(A7)+                         ; $26F33E
        OR.W   D3,-(A2)                         ; $26F340
        OR.W   -(A1),D2                         ; $26F342
        OR.W   D0,$7F(A5,D7.L)                  ; $26F344
        DC.W    $7D7F,$809B         ; $26F348 MOVE.W  <EA:3F>,-$7F65(A6)
        DC.W    $7FC5               ; $26F34C MOVE.W  D5,<EA:3F>
        DC.W    $7BE0               ; $26F34E MOVE.W  -(A0),<EA:3D>
        MOVE.W  $78EE(A0),#$74F1                ; $26F350
        MOVE.W  -$11(A0,D7.L),$7DED(PC)         ; $26F356
        MOVEQ   #-$15,D7                        ; $26F35C
        DC.W    $7BE9,$77E8         ; $26F35E MOVE.W  $77E8(A1),<EA:3D>
        MOVE.W  -(A6),-$1B(PC,D7.L)             ; $26F362
        DC.W    $7BE1               ; $26F366 MOVE.W  -(A1),<EA:3D>
        DC.W    $7DD0               ; $26F368 MOVE.W  (A0),<EA:3E>
        MOVE.W  -$7F7E(A3),$7D(A7,D7.L)         ; $26F36A
        MOVEQ   #-$73,D6                        ; $26F370
        MOVE.W  (A7)+,-$57(A4,D7.L)             ; $26F372
        MOVE.W  $7E92(A0),$66(A6,A0.W)          ; $26F376
        OR.W   D0,(A4)                          ; $26F37C
        MOVE.W  -$62(A4,D7.L),$7BB5(A6)         ; $26F37E
        OR.L   D0,-$67(A1,A0.W)                 ; $26F384
        OR.L   D1,D0                            ; $26F388
        OR.L   D0,D1                            ; $26F38A
        MOVE.W  A5,-$73(A6,D7.L)                ; $26F38C
        OR.L   D0,D5                            ; $26F390
        DC.W    $817F               ; $26F392 OR.W   D0,<EA:3F>
        OR.W   -$7EAF(A1),D0                    ; $26F394
        OR.W   A1,D1                            ; $26F398
        OR.W   D3,D0                            ; $26F39A
        MOVE.W  $34(PC,A0.W),-(A7)              ; $26F39C
        OR.B   D1,-$7CDB(A1)                    ; $26F3A0
        OR.B   D1,-(A5)                         ; $26F3A4
        MOVE.W  -(A5),-(A7)                     ; $26F3A6
        MOVE.W  $41(A0,D7.L),-(A5)              ; $26F3A8
        MOVEQ   #$48,D7                         ; $26F3AC
        MOVEQ   #$4B,D7                         ; $26F3AE
        MOVEQ   #$51,D7                         ; $26F3B0
        MOVE.W  (A2)+,$7C58(A6)                 ; $26F3B2
        MOVEQ   #$51,D7                         ; $26F3B6
        OR.W   D0,A7                            ; $26F3B8
        OR.W   D1,A3                            ; $26F3BA
        OR.W   D2,D3                            ; $26F3BC
        OR.B   D4,$31(A7,A0.L)                  ; $26F3BE
        OR.B   D6,$30(A0,A0.L)                  ; $26F3C2
        OR.B   $4C(A6,A0.W),D4                  ; $26F3C6
        OR.W   (A4)+,D2                         ; $26F3CA
        OR.W   D1,(A6)                          ; $26F3CC
        OR.W   D1,A3                            ; $26F3CE
        OR.W   D0,A6                            ; $26F3D0
        MOVEQ   #$54,D7                         ; $26F3D2
        MOVE.W  $799C(A5),$77CC(A5)             ; $26F3D4
        MOVEQ   #-$20,D3                        ; $26F3DA
        MOVE.W  (A7)+,#$7CDB                    ; $26F3DC
        MOVEQ   #-$1F,D6                        ; $26F3E0
        DC.W    $7BEB,$7AEB         ; $26F3E2 MOVE.W  $7AEB(A3),<EA:3D>
        MOVEQ   #-$16,D5                        ; $26F3E6
        DC.W    $7DE4               ; $26F3E8 MOVE.W  -(A4),<EA:3E>
        DC.W    $7DDE               ; $26F3EA MOVE.W  (A6)+,<EA:3E>
        MOVEQ   #-$22,D5                        ; $26F3EC
        MOVE.W  -(A1),#$7AE3                    ; $26F3EE
        MOVEQ   #-$1D,D6                        ; $26F3F2
        DC.W    $7DE2               ; $26F3F4 MOVE.W  -(A2),<EA:3E>
        MOVEQ   #-$27,D7                        ; $26F3F6
        DIVU    D1,D0                           ; $26F3F8
        OR.L   D0,-$7F59(A5)                    ; $26F3FA
        MOVEQ   #-$5C,D7                        ; $26F3FE
        MOVE.W  (A6),-$7F(A6,D7.L)              ; $26F400
        OR.W   $6E(A5,A0.W),D0                  ; $26F404
        MOVEQ   #$6A,D7                         ; $26F408
        MOVEQ   #$6F,D7                         ; $26F40A
        MOVEQ   #$76,D7                         ; $26F40C
        MOVE.W  $7D76.W,$7D7C(A6)               ; $26F40E
        MOVE.W  D3,-$80(A6,D7.L)                ; $26F414
        MOVEQ   #$7E,D7                         ; $26F418
        MOVEQ   #-$78,D7                        ; $26F41A
        MOVEQ   #-$7A,D7                        ; $26F41C
        OR.W   $75(PC,A0.W),D0                  ; $26F41E
        OR.W   $65(A3,A0.W),D1                  ; $26F422
        OR.W   (A5),D1                          ; $26F426
        OR.W   D0,(A1)                          ; $26F428
        MOVE.W  (A3),$7E52(A7)                  ; $26F42A
        MOVE.W  (A3),$7F5B(A7)                  ; $26F42E
        OR.W   -(A1),D0                         ; $26F432
        OR.W   -(A3),D0                         ; $26F434
        OR.W   -(A6),D0                         ; $26F436
        OR.W   -(A3),D0                         ; $26F438
        OR.W   D0,(A0)+                         ; $26F43A
        OR.W   (A2),D0                          ; $26F43C
        OR.W   A7,D0                            ; $26F43E
        OR.W   D0,A4                            ; $26F440
        OR.W   D1,D2                            ; $26F442
        OR.B   $2D(A2,A0.L),D3                  ; $26F444
        OR.B   -$77D6(A3),D5                    ; $26F448
        OR.B   D2,-$7DCD(A3)                    ; $26F44C
        OR.W   D5,D1                            ; $26F450
        OR.W   D0,(A7)                          ; $26F452
        OR.W   D0,(A4)+                         ; $26F454
        OR.W   (A4)+,D0                         ; $26F456
        MOVE.W  $7F83(A3),$7D99(A7)             ; $26F458
        MOVEQ   #-$5B,D6                        ; $26F45E
        MOVEQ   #-$5C,D6                        ; $26F460
        MOVEQ   #-$69,D7                        ; $26F462
        DC.W    $807E               ; $26F464 OR.W   <EA:3E>,D0
        OR.W   (A4),D0                          ; $26F466
        MOVEQ   #$55,D7                         ; $26F468
        MOVE.W  D1,-$56(A5,D7.W)                ; $26F46A
        MOVE.W  A0,-$23(PC,D7.L)                ; $26F46E
        MOVE.W  -(A6),#$78EA                    ; $26F472
        MOVEQ   #-$15,D5                        ; $26F476
        MOVEQ   #-$19,D6                        ; $26F478
        MOVEQ   #-$1B,D6                        ; $26F47A
        MOVEQ   #-$1B,D6                        ; $26F47C
        DC.W    $7BE3               ; $26F47E MOVE.W  -(A3),<EA:3D>
        DC.W    $7BE0               ; $26F480 MOVE.W  -(A0),<EA:3D>
        MOVEQ   #-$2C,D7                        ; $26F482
        DIVU    D3,D0                           ; $26F484
        MOVE.W  -$55(A5,D7.L),-$65(A7,D7.L)     ; $26F486
        DC.W    $807E               ; $26F48C OR.W   <EA:3E>,D0
        OR.W   -(A1),D0                         ; $26F48E
        OR.W   D0,A1                            ; $26F490
        DC.W    $813D               ; $26F492 OR.B   D0,<EA:3D>
        MOVE.W  D2,$7F4E(A7)                    ; $26F494
        MOVEQ   #$5E,D7                         ; $26F498
        MOVE.W  $7D7D(A7),$7E84(A6)             ; $26F49A
        MOVE.W  A5,-$6A(A7,D7.L)                ; $26F4A0
        MOVE.W  -(A6),-$54(A6,D7.L)             ; $26F4A4
        MOVEQ   #-$5E,D7                        ; $26F4A8
        OR.L   (A3),D0                          ; $26F4AA
        OR.L   (A5),D1                          ; $26F4AC
        OR.L   (A6),D1                          ; $26F4AE
        OR.L   A6,D1                            ; $26F4B0
        OR.L   D4,D2                            ; $26F4B2
        DC.W    $847E               ; $26F4B4 OR.W   <EA:3E>,D2
        OR.W   $8079807D,D1                     ; $26F4B6
        MOVE.W  D3,-$7E(A7,D7.L)                ; $26F4BC
        MOVE.W  $69(A7,A0.W),-$7FA3(A7)         ; $26F4C0
        MOVE.W  (A0)+,$7E54(A7)                 ; $26F4C6
        MOVEQ   #$52,D7                         ; $26F4CA
        MOVE.W  A1,-$7FCA(A7)                   ; $26F4CC
        OR.B   -$79D9(A2),D1                    ; $26F4D0
        OR.B   D4,-(A5)                         ; $26F4D4
        OR.B   -(A4),D5                         ; $26F4D6
        OR.B   D4,-(A5)                         ; $26F4D8
        OR.B   D2,-(A6)                         ; $26F4DA
        OR.B   -(A7),D2                         ; $26F4DC
        OR.B   D2,-$78D6(A1)                    ; $26F4DE
        OR.B   -$7ECB(A4),D3                    ; $26F4E2
        MOVEQ   #$54,D7                         ; $26F4E6
        MOVE.W  $7D9E.W,$7DB0(A6)               ; $26F4E8
        MOVE.W  -(A0),-$80(A7,A0.W)             ; $26F4EE
        OR.W   D1,-$7F8A(A5)                    ; $26F4F2
        MOVE.W  (A0),-$57(A5,D7.L)              ; $26F4F6
        MOVEQ   #-$3F,D5                        ; $26F4FA
        MOVEQ   #-$27,D6                        ; $26F4FC
        MOVEQ   #-$1E,D6                        ; $26F4FE
        MOVEQ   #-$1B,D6                        ; $26F500
        MOVEQ   #-$1B,D6                        ; $26F502
        MOVEQ   #-$19,D6                        ; $26F504
        MOVE.W  -(A6),#$78E4                    ; $26F506
        MOVE.W  -(A2),#$7BE1                    ; $26F50A
        MOVEQ   #-$21,D6                        ; $26F50E
        MOVEQ   #-$26,D7                        ; $26F510
        DC.W    $7FC5               ; $26F512 MOVE.W  D5,<EA:3F>
        OR.L   D0,-$7D61(A6)                    ; $26F514
        OR.L   D0,(A0)                          ; $26F518
        OR.W   $805D823F,D0                     ; $26F51A
        OR.B   $7E36(A5),D0                     ; $26F520
        MOVE.W  A2,$7D60(A6)                    ; $26F524
        DC.W    $7D7E,$7D99         ; $26F528 MOVE.W  <EA:3E>,$7D99(A6)
        MOVEQ   #-$52,D6                        ; $26F52C
        MOVE.W  -$40(PC,A0.W),-$46(A6,A0.W)     ; $26F52E
        OR.L   -$4B(A5,A0.W),D0                 ; $26F534
        MOVE.W  -$4E(A7,A0.W),-$5D(A7,A0.W)     ; $26F538
        OR.L   D0,(A4)                          ; $26F53E
        OR.L   A0,D0                            ; $26F540
        MOVEQ   #$7B,D7                         ; $26F542
        MOVE.W  $7F5A(A0),-$7EB5(A7)            ; $26F544
        OR.W   D0,D4                            ; $26F54A
        OR.W   A3,D0                            ; $26F54C
        MOVE.W  D6,-$7FCB(A7)                   ; $26F54E
        OR.B   D0,$7F2E(A3)                     ; $26F552
        MOVEQ   #$34,D7                         ; $26F556
        MOVE.W  $8032.W,-(A7)                   ; $26F558
        OR.B   D0,-$7BDA(A1)                    ; $26F55C
        OR.B   D2,-(A5)                         ; $26F560
        OR.B   -(A5),D2                         ; $26F562
        OR.B   D2,-(A5)                         ; $26F564
        OR.B   D3,-(A6)                         ; $26F566
        OR.B   -(A7),D4                         ; $26F568
        OR.B   -$77D6(A0),D4                    ; $26F56A
        OR.B   -$7BC7(A5),D3                    ; $26F56E
        OR.W   D6,D2                            ; $26F572
        OR.W   (A7)+,D1                         ; $26F574
        MOVE.W  D1,-$66(A7,D7.L)                ; $26F576
        MOVE.W  -(A6),-$56(A5,D7.L)             ; $26F57A
        MOVEQ   #-$5F,D7                        ; $26F57E
        OR.L   D0,D0                            ; $26F580
        OR.W   D1,(A7)                          ; $26F582
        OR.W   D0,A3                            ; $26F584
        MOVEQ   #$61,D7                         ; $26F586
        MOVEQ   #-$7B,D5                        ; $26F588
        MOVEQ   #-$55,D4                        ; $26F58A
        MOVE.W  A4,#$79DF                       ; $26F58C
        MOVEQ   #-$1A,D4                        ; $26F590
        MOVEQ   #-$16,D4                        ; $26F592
        MOVE.W  $7AE8(A2),#$79E6                ; $26F594
        MOVEQ   #-$1C,D5                        ; $26F59A
        DC.W    $7DDD               ; $26F59C MOVE.W  (A5)+,<EA:3E>
        MOVEQ   #-$35,D7                        ; $26F59E
        DC.W    $7DBE,$7CB6         ; $26F5A0 MOVE.W  <EA:3E>,-$4A(A6,D7.L)
        MOVEQ   #-$52,D6                        ; $26F5A4
        MOVE.W  -(A6),-$6C(A6,D7.L)             ; $26F5A6
        OR.W   D0,$57(A3,A0.W)                  ; $26F5AA
        OR.W   (A3),D0                          ; $26F5AE
        MOVE.W  (A7),$7F5A(A7)                  ; $26F5B0
        OR.W   -(A3),D0                         ; $26F5B4
        OR.W   D0,$70(A3,A0.W)                  ; $26F5B6
        OR.W   D1,-(A2)                         ; $26F5BA
        OR.W   D1,-$7D79(A6)                    ; $26F5BC
        OR.L   (A0)+,D0                         ; $26F5C0
        OR.L   -(A2),D0                         ; $26F5C2
        OR.L   D0,-(A4)                         ; $26F5C4
        OR.L   D0,$7FAD(A1)                     ; $26F5C6
        MOVEQ   #-$54,D7                        ; $26F5CA
        MOVEQ   #-$52,D7                        ; $26F5CC
        MOVEQ   #-$52,D7                        ; $26F5CE
        MOVE.W  $7DA0(A0),-$69(A6,D7.L)         ; $26F5D0
        MOVE.W  A2,$66(A7,A0.W)                 ; $26F5D6
        OR.W   D0,D1                            ; $26F5DA
        OR.W   D6,D0                            ; $26F5DC
        MOVE.W  (A2),$7A51(A6)                  ; $26F5DE
        MOVE.W  (A3)+,$7C6A(A5)                 ; $26F5E2
        MOVE.W  $7E5F(A6),-$7CB6(A5)            ; $26F5E6
        DC.W    $843F               ; $26F5EC OR.B   <EA:3F>,D2
        OR.B   $28(A4,A0.W),D2                  ; $26F5EE
        OR.B   -(A4),D2                         ; $26F5F2
        OR.B   -(A3),D3                         ; $26F5F4
        OR.B   D3,-(A4)                         ; $26F5F6
        OR.B   D3,-(A5)                         ; $26F5F8
        OR.B   D2,-$7CC6(A1)                    ; $26F5FA
        OR.W   A2,D1                            ; $26F5FE
        OR.W   D0,A4                            ; $26F600
        OR.W   A7,D0                            ; $26F602
        MOVE.W  (A4)+,$7F5F(A7)                 ; $26F604
        OR.W   (A1)+,D0                         ; $26F608
        OR.W   A3,D1                            ; $26F60A
        OR.B   $8334.W,D2                       ; $26F60C
        DC.W    $803D               ; $26F610 OR.B   <EA:3D>,D0
        MOVEQ   #$54,D6                         ; $26F612
        MOVEQ   #$6B,D5                         ; $26F614
        MOVE.W  A1,-$58(A5,D7.L)                ; $26F616
        MOVE.W  D3,#$7ADC                       ; $26F61A
        MOVE.W  -(A6),#$78EA                    ; $26F61E
        MOVEQ   #-$15,D4                        ; $26F622
        MOVEQ   #-$16,D4                        ; $26F624
        MOVE.W  $7AE4(A0),#$7ADE                ; $26F626
        MOVE.W  (A5),#$7AC8                     ; $26F62C
        MOVEQ   #-$43,D6                        ; $26F630
        MOVEQ   #-$52,D7                        ; $26F632
        MOVEQ   #-$66,D7                        ; $26F634
        OR.L   D5,D0                            ; $26F636
        OR.W   D0,$61(A0,A0.W)                  ; $26F638
        OR.W   D0,-(A2)                         ; $26F63C
        OR.W   -$7F95(A2),D0                    ; $26F63E
        OR.W   -(A1),D1                         ; $26F642
        OR.W   D1,(A4)+                         ; $26F644
        OR.W   -(A7),D1                         ; $26F646
        OR.W   $76(A3,A0.W),D0                  ; $26F648
        DC.W    $817F               ; $26F64C OR.W   D0,<EA:3F>
        OR.L   D0,(A2)                          ; $26F64E
        MOVE.W  -(A3),-$5C(A7,A0.W)             ; $26F650
        OR.L   D0,(A0)+                         ; $26F654
        OR.L   A5,D0                            ; $26F656
        MOVEQ   #-$6E,D7                        ; $26F658
        MOVE.W  (A2)+,-$68(A5,D7.L)             ; $26F65A
        MOVEQ   #-$6D,D7                        ; $26F65E
        MOVE.W  (A5),-$6A(A7,D7.L)              ; $26F660
        MOVE.W  (A1),-$80(A6,D7.L)              ; $26F664
        MOVE.W  $6E(A2,D7.L),$7F66(A7)          ; $26F668
        MOVE.W  (A2)+,-$7EAE(A7)                ; $26F66E
        OR.W   D1,D5                            ; $26F672
        OR.B   D2,$28(A2,A0.W)                  ; $26F674
        OR.B   -(A6),D3                         ; $26F678
        OR.B   D2,-(A4)                         ; $26F67A
        OR.B   -(A4),D2                         ; $26F67C
        OR.B   D2,-(A5)                         ; $26F67E
        OR.B   -(A7),D4                         ; $26F680
        OR.B   D3,-$7DCF(A1)                    ; $26F682
        MOVEQ   #$4B,D7                         ; $26F686
        MOVE.W  $7D83(A2),$7D94(A6)             ; $26F688
        MOVE.W  -(A0),-$5A(A6,D7.L)             ; $26F68E
        MOVEQ   #-$5A,D7                        ; $26F692
        MOVEQ   #-$55,D7                        ; $26F694
        MOVEQ   #-$44,D6                        ; $26F696
        DC.W    $7BCA               ; $26F698 MOVE.W  A2,<EA:3D>
        DC.W    $7BC5               ; $26F69A MOVE.W  D5,<EA:3D>
        MOVEQ   #-$58,D6                        ; $26F69C
        MOVE.W  $48(A7,A0.W),-$7FC8(A7)         ; $26F69E
        MOVE.W  $75637290,-(A5)                 ; $26F6A4
        MOVEQ   #-$54,D4                        ; $26F6AA
        DC.W    $7BC6               ; $26F6AC MOVE.W  D6,<EA:3D>
        MOVE.W  (A3)+,-$1D(PC,D7.W)             ; $26F6AE
        MOVE.W  -(A4),-$1C(PC,D7.L)             ; $26F6B2
        DC.W    $7BE2               ; $26F6B6 MOVE.W  -(A2),<EA:3D>
        MOVEQ   #-$2C,D6                        ; $26F6B8
        MOVEQ   #-$47,D7                        ; $26F6BA
        OR.L   D0,(A4)+                         ; $26F6BC
        OR.W   -$7B9D(PC),D2                    ; $26F6BE
        OR.W   (A3),D2                          ; $26F6C2
        OR.W   A0,D2                            ; $26F6C4
        OR.W   D1,D4                            ; $26F6C6
        OR.W   A6,D1                            ; $26F6C8
        OR.W   (A7)+,D0                         ; $26F6CA
        MOVEQ   #$72,D7                         ; $26F6CC
        MOVEQ   #-$7D,D7                        ; $26F6CE
        MOVEQ   #-$71,D7                        ; $26F6D0
        MOVE.W  (A6),-$6B(A6,D7.L)              ; $26F6D2
        MOVE.W  (A3),-$67(A7,D7.L)              ; $26F6D6
        MOVE.W  -(A3),-$58(A6,D7.L)             ; $26F6DA
        MOVEQ   #-$56,D7                        ; $26F6DE
        MOVE.W  $7FB1(A6),-$4C(A7,D7.L)         ; $26F6E0
        MOVE.W  -$56(A2,A0.W),-$54(A7,D7.L)     ; $26F6E6
        MOVE.W  -$46(A7,D7.L),-$4B(A6,D7.L)     ; $26F6EC
        MOVE.W  -(A7),-$6C(A7,A0.W)             ; $26F6F2
        OR.L   D0,D6                            ; $26F6F6
        DC.W    $817D               ; $26F6F8 OR.W   D0,<EA:3D>
        OR.W   D0,$62(A2,A0.W)                  ; $26F6FA
        OR.W   A3,D1                            ; $26F6FE
        OR.B   -$7ADC(A7),D2                    ; $26F700
        OR.B   D1,-(A1)                         ; $26F704
        OR.B   -(A1),D1                         ; $26F706
        OR.B   D1,(A5)+                         ; $26F708
        OR.B   D3,(A5)+                         ; $26F70A
        OR.B   (A7)+,D4                         ; $26F70C
        OR.B   D2,-(A1)                         ; $26F70E
        OR.B   -(A6),D0                         ; $26F710
        MOVE.W  $4B(A5,D7.L),-(A6)              ; $26F712
        MOVE.W  -(A2),$7C6B(A5)                 ; $26F716
        MOVE.W  -(A4),$7D62(A6)                 ; $26F71A
        MOVEQ   #$68,D7                         ; $26F71E
        MOVEQ   #$67,D7                         ; $26F720
        MOVE.W  (A7)+,-$7FA9(A7)                ; $26F722
        OR.W   D0,(A1)                          ; $26F726
        MOVE.W  D7,$7E38(A7)                    ; $26F728
        MOVEQ   #$2F,D7                         ; $26F72C
        MOVEQ   #$30,D7                         ; $26F72E
        MOVEQ   #$42,D6                         ; $26F730
        MOVE.W  -(A2),$7888(A4)                 ; $26F732
        MOVE.W  $7ABB(A0),-$3F(A4,D7.L)         ; $26F736
        MOVEQ   #-$3B,D5                        ; $26F73C
        DC.W    $7BC4               ; $26F73E MOVE.W  D4,<EA:3D>
        MOVEQ   #-$40,D6                        ; $26F740
        DC.W    $7DBF,$7DC0         ; $26F742 MOVE.W  <EA:3F>,-$40(A6,D7.L)
        MOVE.W  -$5F(A6,A0.W),-$77(A7,A0.W)     ; $26F746
        OR.W   $68(A7,A0.W),D3                  ; $26F74C
        OR.W   -(A1),D2                         ; $26F750
        OR.W   D1,-(A6)                         ; $26F752
        OR.W   D0,-$7B(A2,D7.L)                 ; $26F754
        MOVE.W  (A2)+,-$59(A6,D7.L)             ; $26F758
        MOVE.W  $7BA9(A5),-$56(A4,D7.L)         ; $26F75C
        MOVEQ   #-$44,D6                        ; $26F762
        MOVEQ   #-$31,D6                        ; $26F764
        MOVEQ   #-$29,D6                        ; $26F766
        DC.W    $7DD7               ; $26F768 MOVE.W  (A7),<EA:3E>
        MOVEQ   #-$37,D7                        ; $26F76A
        MOVE.W  $7FB4(PC),-$4A(A7,D7.L)         ; $26F76C
        DC.W    $7DBD,$7DC4         ; $26F772 MOVE.W  <EA:3D>,-$3C(A6,D7.L)
        MOVEQ   #-$40,D7                        ; $26F776
        DC.W    $7FB9,$80B9,$7EB8,$7EB2; $26F778 MOVE.W  $80B97EB8,-$4E(A7,D7.L)
        OR.L   -(A3),D0                         ; $26F780
        OR.L   D0,A1                            ; $26F782
        OR.W   $77(A7,A0.W),D1                  ; $26F784
        OR.W   -$7EA9(A4),D0                    ; $26F788
        DC.W    $853F               ; $26F78C OR.B   D2,<EA:3F>
        OR.B   -$7AE0(A1),D3                    ; $26F78E
        OR.B   (A4)+,D2                         ; $26F792
        OR.B   D1,(A2)+                         ; $26F794
        OR.B   D2,(A2)+                         ; $26F796
        OR.B   D3,(A4)+                         ; $26F798
        OR.B   (A5)+,D3                         ; $26F79A
        OR.B   D1,(A7)+                         ; $26F79C
        OR.B   -(A3),D0                         ; $26F79E
        MOVEQ   #$29,D7                         ; $26F7A0
        MOVEQ   #$2C,D7                         ; $26F7A2
        MOVE.W  $7C4C.W,-(A6)                   ; $26F7A4
        MOVEQ   #$58,D6                         ; $26F7A8
        MOVEQ   #$5A,D7                         ; $26F7AA
        MOVE.W  (A4),-$7FB1(A7)                 ; $26F7AC
        MOVE.W  (A1),$7D5C(A7)                  ; $26F7B0
        MOVEQ   #$63,D6                         ; $26F7B4
        MOVEQ   #$5F,D6                         ; $26F7B6
        MOVEQ   #$58,D6                         ; $26F7B8
        MOVEQ   #$4F,D6                         ; $26F7BA
        MOVEQ   #$45,D5                         ; $26F7BC
        MOVEQ   #$3E,D5                         ; $26F7BE
        MOVE.W  (A0),$7977(A4)                  ; $26F7C0
        MOVE.W  (A6),-$54(A4,D7.L)              ; $26F7C4
        MOVE.W  -$41(A7,D7.L),-$40(A6,D7.L)     ; $26F7C8
        DC.W    $7FC5               ; $26F7CE MOVE.W  D5,<EA:3F>
        DC.W    $7FCA               ; $26F7D0 MOVE.W  A2,<EA:3F>
        DC.W    $7FC8               ; $26F7D2 MOVE.W  A0,<EA:3F>
        DIVU    D5,D0                           ; $26F7D4
        DIVU    D1,D0                           ; $26F7D6
        DC.W    $80BD               ; $26F7D8 OR.L   <EA:3D>,D0
        OR.L   $7FA8.W,D0                       ; $26F7DA
        MOVEQ   #-$6A,D7                        ; $26F7DE
        MOVE.W  A5,-$77(A7,D7.L)                ; $26F7E0
        MOVE.W  A0,-$75(A6,D7.L)                ; $26F7E4
        MOVE.W  A6,-$72(A7,A0.W)                ; $26F7E8
        OR.W   D0,$6C(PC,A0.W)                  ; $26F7EC
        DC.W    $817D               ; $26F7F0 OR.W   D0,<EA:3D>
        MOVE.W  (A4)+,-$51(A7,D7.L)             ; $26F7F2
        OR.L   D0,-$36(PC,A0.W)                 ; $26F7F6
        DIVU    (A0)+,D0                        ; $26F7FA
        DC.W    $7FDB               ; $26F7FC MOVE.W  (A3)+,<EA:3F>
        DC.W    $7FDC               ; $26F7FE MOVE.W  (A4)+,<EA:3F>
        DC.W    $7FDC               ; $26F800 MOVE.W  (A4)+,<EA:3F>
        MOVEQ   #-$26,D7                        ; $26F802
        MOVEQ   #-$2A,D6                        ; $26F804
        DC.W    $7DC2               ; $26F806 MOVE.W  D2,<EA:3E>
        MOVE.W  -$56(A3,A0.W),-$60(A7,D7.L)     ; $26F808
        MOVE.W  (A2)+,-$6F(A7,A0.W)             ; $26F80E
        OR.W   -$7EAB(PC),D0                    ; $26F812
        DC.W    $813D               ; $26F816 OR.B   D0,<EA:3D>
        OR.B   $23(A1,A0.W),D0                  ; $26F818
        OR.B   D1,(A3)+                         ; $26F81C
        OR.B   (A1)+,D2                         ; $26F81E
        OR.B   D1,(A2)+                         ; $26F820
        OR.B   D0,(A3)+                         ; $26F822
        OR.B   (A4)+,D1                         ; $26F824
        OR.B   D1,(A5)+                         ; $26F826
        OR.B   (A7)+,D1                         ; $26F828
        OR.B   -(A3),D0                         ; $26F82A
        MOVEQ   #$2F,D7                         ; $26F82C
        DC.W    $7D3E               ; $26F82E MOVE.W  <EA:3E>,-(A6)
        MOVE.W  (A2),$7B62(A6)                  ; $26F830
        MOVEQ   #$61,D5                         ; $26F834
        MOVE.W  (A5),$7C52(A5)                  ; $26F836
        MOVE.W  (A5),$7A5C(A5)                  ; $26F83A
        MOVE.W  (A5)+,$7D5A(A5)                 ; $26F83E
        MOVEQ   #$5A,D7                         ; $26F842
        OR.W   A2,D0                            ; $26F844
        OR.B   $34(A5,A0.W),D0                  ; $26F846
        MOVEQ   #$4C,D7                         ; $26F84A
        MOVEQ   #$71,D5                         ; $26F84C
        MOVEQ   #-$74,D5                        ; $26F84E
        MOVEQ   #-$64,D7                        ; $26F850
        OR.L   D0,-(A1)                         ; $26F852
        OR.L   D0,(A6)                          ; $26F854
        OR.L   D0,A5                            ; $26F856
        OR.L   A6,D0                            ; $26F858
        MOVE.W  (A7),-$61(A7,D7.L)              ; $26F85A
        MOVEQ   #-$59,D7                        ; $26F85E
        MOVEQ   #-$53,D7                        ; $26F860
        MOVE.W  -$7F53(A7),-$58(A7,A0.W)        ; $26F862
        OR.L   D0,-(A4)                         ; $26F868
        OR.L   D0,-(A0)                         ; $26F86A
        OR.L   (A1)+,D0                         ; $26F86C
        MOVE.W  (A5)+,-$60(A7,D7.L)             ; $26F86E
        MOVE.W  -(A0),-$61(A6,D7.L)             ; $26F872
        MOVEQ   #-$6A,D7                        ; $26F876
        OR.L   A1,D0                            ; $26F878
        OR.L   A1,D0                            ; $26F87A
        OR.L   (A0)+,D0                         ; $26F87C
        MOVE.W  -(A2),-$5D(A7,A0.W)             ; $26F87E
        OR.L   -$7E54(A0),D0                    ; $26F882
        OR.L   D0,-$7E58(A1)                    ; $26F886
        OR.L   D0,-$7E54(A4)                    ; $26F88A
        OR.L   D0,-(A4)                         ; $26F88E
        OR.L   (A5)+,D1                         ; $26F890
        OR.L   (A6)+,D1                         ; $26F892
        OR.L   (A7)+,D0                         ; $26F894
        MOVEQ   #-$69,D7                        ; $26F896
        MOVE.W  (A0)+,-$68(A6,D7.L)             ; $26F898
        MOVE.W  (A0),-$78(A6,D7.L)              ; $26F89C
        MOVEQ   #$7E,D7                         ; $26F8A0
        MOVEQ   #$6E,D7                         ; $26F8A2
        OR.W   (A5),D0                          ; $26F8A4
        OR.B   D1,$27(A4,A0.W)                  ; $26F8A6
        OR.B   D1,-(A1)                         ; $26F8AA
        OR.B   D1,(A6)+                         ; $26F8AC
        OR.B   D1,(A6)+                         ; $26F8AE
        OR.B   (A7)+,D2                         ; $26F8B0
        OR.B   -(A2),D1                         ; $26F8B2
        MOVEQ   #$34,D7                         ; $26F8B4
        MOVEQ   #$52,D6                         ; $26F8B6
        MOVE.W  $7B7F(A3),$799C(A5)             ; $26F8B8
        MOVE.W  -$45(A2,D7.W),-$47(A3,D7.L)     ; $26F8BE
        MOVEQ   #-$4D,D5                        ; $26F8C4
        MOVE.W  -$43(A6,D7.L),-$46(A4,D7.L)     ; $26F8C6
        MOVEQ   #-$50,D6                        ; $26F8CC
        MOVEQ   #-$64,D7                        ; $26F8CE
        MOVEQ   #-$71,D7                        ; $26F8D0
        MOVE.W  A3,-$7B(A6,D7.L)                ; $26F8D2
        MOVEQ   #$6A,D7                         ; $26F8D6
        DC.W    $823E               ; $26F8D8 OR.B   <EA:3E>,D1
        OR.B   D2,-$7BD9(A5)                    ; $26F8DA
        OR.B   -(A3),D0                         ; $26F8DE
        MOVE.W  $7F41(A4),-(A6)                 ; $26F8E0
        MOVE.W  (A7)+,$7D74(A7)                 ; $26F8E4
        DC.W    $7D7D,$7E7D         ; $26F8E8 MOVE.W  <EA:3D>,$7E7D(A6)
        MOVE.W  $8075.W,$7F76(A7)               ; $26F8EC
        MOVE.W  #$7D84,$7E8C(A6)                ; $26F8F2
        MOVEQ   #-$72,D7                        ; $26F8F8
        MOVE.W  A5,-$75(A6,D7.L)                ; $26F8FA
        MOVE.W  A2,-$75(A7,D7.L)                ; $26F8FE
        MOVE.W  A1,-$80(A7,A0.W)                ; $26F902
        OR.W   D0,$6E(A6,A0.W)                  ; $26F906
        OR.W   D2,-(A2)                         ; $26F90A
        OR.W   D3,(A3)+                         ; $26F90C
        OR.W   (A7)+,D4                         ; $26F90E
        OR.W   D3,-$7A7D(A7)                    ; $26F910
        OR.L   (A4),D2                          ; $26F914
        OR.L   -(A3),D2                         ; $26F916
        OR.L   -$3A(A7,A0.W),D1                 ; $26F918
        DC.W    $7FCA               ; $26F91C MOVE.W  A2,<EA:3F>
        DC.W    $7FC8               ; $26F91E MOVE.W  A0,<EA:3F>
        MOVEQ   #-$33,D7                        ; $26F920
        MOVEQ   #-$29,D6                        ; $26F922
        MOVEQ   #-$26,D5                        ; $26F924
        MOVE.W  (A2)+,#$79D9                    ; $26F926
        MOVE.W  A5,#$79B6                       ; $26F92A
        MOVE.W  (A3)+,$79(A5,D7.L)              ; $26F92E
        OR.W   A4,D1                            ; $26F932
        OR.B   D2,-$7ADD(A5)                    ; $26F934
        OR.B   D1,(A5)+                         ; $26F938
        OR.B   (A3)+,D1                         ; $26F93A
        OR.B   (A4)+,D1                         ; $26F93C
        OR.B   D0,-(A6)                         ; $26F93E
        DC.W    $803D               ; $26F940 OR.B   <EA:3D>,D0
        MOVE.W  (A2)+,$7B7E(A6)                 ; $26F942
        MOVE.W  (A3)+,-$5D(A5,D7.L)             ; $26F946
        MOVE.W  (A5)+,-$65(A6,D7.L)             ; $26F94A
        MOVEQ   #-$65,D6                        ; $26F94E
        MOVE.W  (A5),-$74(A5,D7.L)              ; $26F950
        MOVE.W  D5,$78(A5,D7.L)                 ; $26F954
        MOVEQ   #$6D,D6                         ; $26F958
        MOVEQ   #$68,D7                         ; $26F95A
        MOVE.W  -(A4),-$7FA1(A7)                ; $26F95C
        MOVE.W  (A4)+,$7F52(A7)                 ; $26F960
        MOVE.W  D0,$7F31(A7)                    ; $26F964
        MOVE.W  $7D2A(A1),-(A7)                 ; $26F968
        MOVEQ   #$2A,D7                         ; $26F96C
        OR.B   -(A7),D0                         ; $26F96E
        OR.B   D0,-$7ECB(A1)                    ; $26F970
        MOVE.W  D7,$7D5F(A7)                    ; $26F974
        MOVE.W  $7B(A4,D7.L),-$7F82(A6)         ; $26F978
        OR.L   D0,D7                            ; $26F97E
        OR.L   D0,(A3)                          ; $26F980
        OR.L   (A2)+,D0                         ; $26F982
        OR.L   D0,(A2)                          ; $26F984
        OR.L   D1,D2                            ; $26F986
        OR.W   D2,$73(A5,A0.W)                  ; $26F988
        OR.W   D1,$837D.W                       ; $26F98C
        OR.L   D5,D2                            ; $26F990
        OR.L   (A0),D2                          ; $26F992
        OR.L   D1,(A2)+                         ; $26F994
        OR.L   -(A1),D1                         ; $26F996
        OR.L   -$7D4A(A2),D1                    ; $26F998
        DIVS    D1,D0                           ; $26F99C
        DIVU    D7,D0                           ; $26F99E
        DC.W    $7FCD               ; $26F9A0 MOVE.W  A5,<EA:3F>
        DC.W    $7FD1               ; $26F9A2 MOVE.W  (A1),<EA:3F>
        DC.W    $7FD1               ; $26F9A4 MOVE.W  (A1),<EA:3F>
        DC.W    $7DD4               ; $26F9A6 MOVE.W  (A4),<EA:3E>
        DC.W    $7BDA               ; $26F9A8 MOVE.W  (A2)+,<EA:3D>
        MOVE.W  (A5)+,#$78D9                    ; $26F9AA
        MOVEQ   #-$2B,D4                        ; $26F9AE
        MOVEQ   #-$2C,D4                        ; $26F9B0
        MOVE.W  (A6),-$32(PC,D7.L)              ; $26F9B2
        MOVEQ   #-$42,D5                        ; $26F9B6
        MOVE.W  $7C95(A3),$7F(A5,D7.L)          ; $26F9B8
        OR.W   -$7CAE(A2),D0                    ; $26F9BE
        DC.W    $853E               ; $26F9C2 OR.B   D2,<EA:3E>
        OR.B   $2D(A3,A0.W),D3                  ; $26F9C4
        OR.B   D3,-(A5)                         ; $26F9C8
        OR.B   (A7)+,D4                         ; $26F9CA
        OR.B   D3,-(A0)                         ; $26F9CC
        OR.B   -$7FBB(A7),D2                    ; $26F9CE
        MOVE.W  -(A0),$7C77(A6)                 ; $26F9D2
        MOVE.W  D3,-$7D(A5,D7.L)                ; $26F9D6
        MOVE.W  D3,-$80(A5,D7.L)                ; $26F9DA
        MOVEQ   #$78,D5                         ; $26F9DE
        MOVEQ   #$6A,D6                         ; $26F9E0
        MOVE.W  (A0)+,$7C51(A6)                 ; $26F9E2
        MOVEQ   #$56,D5                         ; $26F9E6
        MOVE.W  (A5)+,$7A5B(A4)                 ; $26F9E8
        MOVE.W  (A5),$7E51(A6)                  ; $26F9EC
        MOVEQ   #$4C,D7                         ; $26F9F0
        MOVEQ   #$3F,D7                         ; $26F9F2
        MOVE.W  $2D(A1,D7.L),-(A7)              ; $26F9F4
        MOVEQ   #$2D,D7                         ; $26F9F8
        MOVE.W  $42(A4,D7.L),-(A6)              ; $26F9FA
        MOVEQ   #$51,D7                         ; $26F9FE
        MOVE.W  (A1)+,$7F60(A7)                 ; $26FA00
        MOVE.W  $7F79(A2),$7F88(A7)             ; $26FA04
        OR.L   D0,A5                            ; $26FA0A
        OR.L   A3,D1                            ; $26FA0C
        OR.L   D7,D2                            ; $26FA0E
        OR.L   D2,D0                            ; $26FA10
        OR.W   -$7C81(PC),D2                    ; $26FA12
        OR.L   D1,A1                            ; $26FA16
        OR.L   A3,D1                            ; $26FA18
        OR.L   D1,D7                            ; $26FA1A
        OR.L   A1,D2                            ; $26FA1C
        OR.L   D1,A7                            ; $26FA1E
        OR.L   D0,(A5)                          ; $26FA20
        OR.L   (A5)+,D0                         ; $26FA22
        OR.L   D0,-(A3)                         ; $26FA24
        OR.L   -(A5),D1                         ; $26FA26
        OR.L   D0,-$7F4E(A0)                    ; $26FA28
        DC.W    $7FC1               ; $26FA2C MOVE.W  D1,<EA:3F>
        DC.W    $7DCE               ; $26FA2E MOVE.W  A6,<EA:3E>
        MOVEQ   #-$2D,D6                        ; $26FA30
        DC.W    $7BD7               ; $26FA32 MOVE.W  (A7),<EA:3D>
        MOVEQ   #-$24,D5                        ; $26FA34
        MOVE.W  -(A0),#$77E0                    ; $26FA36
        MOVEQ   #-$21,D3                        ; $26FA3A
        MOVEQ   #-$22,D3                        ; $26FA3C
        MOVE.W  (A5)+,-$25(PC,D7.L)             ; $26FA3E
        MOVE.W  (A2)+,#$7BD6                    ; $26FA42
        DC.W    $7DC4               ; $26FA46 MOVE.W  D4,<EA:3E>
        MOVE.W  -$7E71(A2),$72(A7,A0.W)         ; $26FA48
        OR.W   (A1)+,D3                         ; $26FA4E
        OR.W   D3,D0                            ; $26FA50
        OR.B   -$7BD6(A7),D3                    ; $26FA52
        OR.B   -(A2),D1                         ; $26FA56
        OR.B   D0,(A4)+                         ; $26FA58
        OR.B   (A4)+,D1                         ; $26FA5A
        OR.B   D0,-(A0)                         ; $26FA5C
        MOVEQ   #$31,D7                         ; $26FA5E
        MOVE.W  D2,$7C51(A6)                    ; $26FA60
        MOVE.W  -(A3),$7977(A5)                 ; $26FA64
        MOVEQ   #-$7C,D4                        ; $26FA68
        MOVEQ   #-$78,D4                        ; $26FA6A
        MOVE.W  D2,$7C(A4,D7.L)                 ; $26FA6C
        MOVEQ   #$77,D5                         ; $26FA70
        MOVEQ   #$71,D5                         ; $26FA72
        MOVE.W  $7C5B(A2),$7D48(A5)             ; $26FA74
        MOVEQ   #$38,D7                         ; $26FA7A
        OR.B   -$7ED8(A4),D0                    ; $26FA7C
        OR.B   D0,-(A7)                         ; $26FA80
        OR.B   D0,-$7ED3(A0)                    ; $26FA82
        OR.B   $35(A1,A0.W),D1                  ; $26FA86
        OR.B   D1,$843A843A                     ; $26FA8A
        OR.B   -$7CC1(PC),D2                    ; $26FA90
        OR.W   A1,D1                            ; $26FA94
        OR.W   D0,(A6)                          ; $26FA96
        OR.W   D0,-(A3)                         ; $26FA98
        OR.W   -$7F89(A6),D0                    ; $26FA9A
        OR.L   D0,D2                            ; $26FA9E
        OR.L   D0,A2                            ; $26FAA0
        OR.L   A6,D1                            ; $26FAA2
        OR.L   (A4),D1                          ; $26FAA4
        OR.L   D0,(A2)+                         ; $26FAA6
        OR.L   (A6)+,D0                         ; $26FAA8
        OR.L   -(A4),D0                         ; $26FAAA
        MOVE.W  $7EC0(A7),-$35(A7,D7.L)         ; $26FAAC
        DC.W    $7DD3               ; $26FAB2 MOVE.W  (A3),<EA:3E>
        DC.W    $7DDB               ; $26FAB4 MOVE.W  (A3)+,<EA:3E>
        DC.W    $7DE1               ; $26FAB6 MOVE.W  -(A1),<EA:3E>
        DC.W    $7DE2               ; $26FAB8 MOVE.W  -(A2),<EA:3E>
        MOVEQ   #-$1C,D6                        ; $26FABA
        MOVEQ   #-$1B,D6                        ; $26FABC
        DC.W    $7BE4               ; $26FABE MOVE.W  -(A4),<EA:3D>
        MOVEQ   #-$1D,D6                        ; $26FAC0
        MOVEQ   #-$1E,D6                        ; $26FAC2
        DC.W    $7BE0               ; $26FAC4 MOVE.W  -(A0),<EA:3D>
        MOVEQ   #-$25,D6                        ; $26FAC6
        DC.W    $7DD3               ; $26FAC8 MOVE.W  (A3),<EA:3E>
        DC.W    $7DC9               ; $26FACA MOVE.W  A1,<EA:3E>
        DC.W    $7DBE,$7DB5         ; $26FACC MOVE.W  <EA:3E>,-$4B(A6,D7.L)
        MOVEQ   #-$55,D6                        ; $26FAD0
        MOVE.W  (A3)+,-$7C(A6,A0.W)             ; $26FAD2
        OR.W   -(A7),D2                         ; $26FAD6
        OR.W   A3,D3                            ; $26FAD8
        DC.W    $873E               ; $26FADA OR.B   D3,<EA:3E>
        OR.B   $2A(A7,A0.W),D3                  ; $26FADC
        OR.B   D2,-(A2)                         ; $26FAE0
        OR.B   D2,-(A1)                         ; $26FAE2
        OR.B   $7F45(A2),D1                     ; $26FAE4
        MOVE.W  -(A6),$7B82(A6)                 ; $26FAE8
        MOVE.W  (A5),-$58(A5,D7.L)              ; $26FAEC
        MOVE.W  $76C6(PC),-$39(A3,D7.W)         ; $26FAF0
        MOVEQ   #-$43,D3                        ; $26FAF6
        MOVE.W  -$57(A3,D7.W),-$64(A3,D7.L)     ; $26FAF8
        MOVE.W  A3,$7C(A5,D7.L)                 ; $26FAFE
        MOVEQ   #$6E,D7                         ; $26FB02
        MOVEQ   #$61,D7                         ; $26FB04
        MOVEQ   #$5C,D7                         ; $26FB06
        MOVE.W  (A0)+,-$7EB9(A7)                ; $26FB08
        OR.B   D1,$28(A3,A0.W)                  ; $26FB0C
        OR.B   -(A4),D3                         ; $26FB10
        OR.B   D3,-(A2)                         ; $26FB12
        OR.B   -(A1),D4                         ; $26FB14
        OR.B   -(A2),D4                         ; $26FB16
        OR.B   D2,-(A3)                         ; $26FB18
        OR.B   -(A5),D1                         ; $26FB1A
        OR.B   -(A6),D0                         ; $26FB1C
        OR.B   -(A7),D1                         ; $26FB1E
        OR.B   -$7AD5(A0),D2                    ; $26FB20
        OR.B   $40(A2,A0.W),D2                  ; $26FB24
        OR.W   (A2),D0                          ; $26FB28
        MOVE.W  -(A6),$7E7A(A7)                 ; $26FB2A
        MOVE.W  A5,-$63(A6,D7.L)                ; $26FB2E
        MOVEQ   #-$54,D7                        ; $26FB32
        MOVEQ   #-$44,D7                        ; $26FB34
        DC.W    $7DCD               ; $26FB36 MOVE.W  A5,<EA:3E>
        DC.W    $7DDB               ; $26FB38 MOVE.W  (A3)+,<EA:3E>
        DC.W    $7DE1               ; $26FB3A MOVE.W  -(A1),<EA:3E>
        DC.W    $7FDD               ; $26FB3C MOVE.W  (A5)+,<EA:3F>
        DIVU    (A4),D0                         ; $26FB3E
        DC.W    $7FCF               ; $26FB40 MOVE.W  A7,<EA:3F>
        MOVEQ   #-$31,D7                        ; $26FB42
        DC.W    $7DD1               ; $26FB44 MOVE.W  (A1),<EA:3E>
        DC.W    $7DD2               ; $26FB46 MOVE.W  (A2),<EA:3E>
        DC.W    $7DD2               ; $26FB48 MOVE.W  (A2),<EA:3E>
        DC.W    $7DD7               ; $26FB4A MOVE.W  (A7),<EA:3E>
        MOVEQ   #-$24,D6                        ; $26FB4C
        DC.W    $7BDD               ; $26FB4E MOVE.W  (A5)+,<EA:3D>
        DC.W    $7BDC               ; $26FB50 MOVE.W  (A4)+,<EA:3D>
        MOVEQ   #-$24,D6                        ; $26FB52
        MOVEQ   #-$25,D6                        ; $26FB54
        MOVEQ   #-$2B,D6                        ; $26FB56
        DC.W    $7BCA               ; $26FB58 MOVE.W  A2,<EA:3D>
        DC.W    $7BBD,$7BB1         ; $26FB5A MOVE.W  <EA:3D>,-$4F(A5,D7.L)
        MOVE.W  -(A7),-$67(A6,D7.L)             ; $26FB5E
        OR.L   D6,D1                            ; $26FB62
        OR.W   D1,-$7A93(PC)                    ; $26FB64
        OR.W   (A3),D3                          ; $26FB68
        OR.B   D3,$23(A0,A0.W)                  ; $26FB6A
        OR.B   -(A4),D2                         ; $26FB6E
        MOVE.W  #$7B5A,-(A7)                    ; $26FB70
        MOVE.W  -$6C(A6,D7.L),$78AD(A4)         ; $26FB74
        MOVEQ   #-$44,D4                        ; $26FB7A
        MOVEQ   #-$3B,D4                        ; $26FB7C
        MOVEQ   #-$3C,D4                        ; $26FB7E
        MOVEQ   #-$4A,D4                        ; $26FB80
        MOVEQ   #-$60,D4                        ; $26FB82
        MOVE.W  A3,$79(A4,D7.L)                 ; $26FB84
        MOVE.W  -(A3),$7F4E(A6)                 ; $26FB88
        DC.W    $803F               ; $26FB8C OR.B   <EA:3F>,D0
        OR.B   D0,$32(A5,A0.W)                  ; $26FB8E
        OR.B   D0,$25(A0,A0.W)                  ; $26FB92
        OR.B   (A6)+,D2                         ; $26FB96
        OR.B   D2,(A6)+                         ; $26FB98
        OR.B   D2,(A6)+                         ; $26FB9A
        OR.B   D1,(A6)+                         ; $26FB9C
        OR.B   (A7)+,D2                         ; $26FB9E
        OR.B   D2,-(A0)                         ; $26FBA0
        OR.B   D2,-(A1)                         ; $26FBA2
        OR.B   -(A3),D3                         ; $26FBA4
        OR.B   -(A4),D3                         ; $26FBA6
        OR.B   -(A5),D3                         ; $26FBA8
        OR.B   -(A6),D3                         ; $26FBAA
        OR.B   -(A7),D2                         ; $26FBAC
        OR.B   D1,-$7DD2(A1)                    ; $26FBAE
        OR.W   D2,D0                            ; $26FBB2
        MOVEQ   #$61,D7                         ; $26FBB4
        DC.W    $7D7F,$7C96         ; $26FBB6 MOVE.W  <EA:3F>,$7C96(A6)
        MOVE.W  -(A7),-$54(A6,D7.L)             ; $26FBBA
        MOVE.W  -(A6),-$5C(A7,D7.L)             ; $26FBBE
        MOVEQ   #-$56,D7                        ; $26FBC2
        MOVE.W  -$3C(A6,D7.L),-$30(A6,D7.L)     ; $26FBC4
        DC.W    $7FD8               ; $26FBCA MOVE.W  (A0)+,<EA:3F>
        DIVU    (A1)+,D0                        ; $26FBCC
        DIVU    (A1)+,D0                        ; $26FBCE
        MOVEQ   #-$21,D7                        ; $26FBD0
        DC.W    $7DE0               ; $26FBD2 MOVE.W  -(A0),<EA:3E>
        DC.W    $7BE0               ; $26FBD4 MOVE.W  -(A0),<EA:3D>
        MOVEQ   #-$21,D5                        ; $26FBD6
        MOVE.W  (A6)+,#$79DD                    ; $26FBD8
        MOVEQ   #-$24,D5                        ; $26FBDC
        DC.W    $7BDB               ; $26FBDE MOVE.W  (A3)+,<EA:3D>
        MOVEQ   #-$27,D6                        ; $26FBE0
        MOVEQ   #-$28,D6                        ; $26FBE2
        MOVEQ   #-$2B,D6                        ; $26FBE4
        MOVEQ   #-$34,D6                        ; $26FBE6
        DC.W    $7DC0               ; $26FBE8 MOVE.W  D0,<EA:3E>
        MOVE.W  -$59(A4,A0.W),-$74(A7,A0.W)     ; $26FBEA
        OR.W   D2,-$7AB3(A0)                    ; $26FBF0
        DC.W    $833E               ; $26FBF4 OR.B   D1,<EA:3E>
        OR.B   -$7CDF(A4),D1                    ; $26FBF6
        OR.B   D1,-(A5)                         ; $26FBFA
        OR.B   D0,$53(A7,D7.L)                  ; $26FBFC
        MOVEQ   #$6A,D6                         ; $26FC00
        MOVE.W  $7B86(PC),$7B8D(A5)             ; $26FC02
        MOVE.W  (A1),-$76(A5,D7.L)              ; $26FC08
        MOVE.W  $71(PC,D7.L),$7E6D(A6)          ; $26FC0C
        MOVEQ   #$64,D7                         ; $26FC12
        MOVE.W  (A6),-$7FB2(A7)                 ; $26FC14
        MOVE.W  (A1),$7F55(A7)                  ; $26FC18
        MOVE.W  (A1),-$7FB6(A7)                 ; $26FC1C
        OR.W   D4,D0                            ; $26FC20
        DC.W    $7F3E               ; $26FC22 MOVE.W  <EA:3E>,-(A7)
        MOVE.W  $26(A3,A0.W),-(A7)              ; $26FC24
        OR.B   -(A3),D0                         ; $26FC28
        OR.B   D0,-(A2)                         ; $26FC2A
        OR.B   -(A1),D0                         ; $26FC2C
        OR.B   D0,-(A2)                         ; $26FC2E
        OR.B   -(A3),D1                         ; $26FC30
        OR.B   -(A4),D1                         ; $26FC32
        OR.B   D0,-(A6)                         ; $26FC34
        OR.B   D0,-(A7)                         ; $26FC36
        OR.B   -$7DD5(A0),D1                    ; $26FC38
        OR.B   D0,$49(A6,D7.L)                  ; $26FC3C
        MOVE.W  (A3)+,-$7E98(A7)                ; $26FC40
        OR.W   -$7A(A5,A0.W),D1                 ; $26FC44
        OR.L   (A0)+,D0                         ; $26FC48
        OR.L   -(A4),D0                         ; $26FC4A
        OR.L   -(A7),D1                         ; $26FC4C
        OR.L   D1,-(A7)                         ; $26FC4E
        OR.L   -$7D4E(A1),D2                    ; $26FC50
        DIVS    D2,D0                           ; $26FC54
        DC.W    $7FD5               ; $26FC56 MOVE.W  (A5),<EA:3F>
        DC.W    $7DDF               ; $26FC58 MOVE.W  (A7)+,<EA:3E>
        MOVEQ   #-$1D,D6                        ; $26FC5A
        MOVEQ   #-$1B,D6                        ; $26FC5C
        MOVEQ   #-$1B,D6                        ; $26FC5E
        MOVEQ   #-$1C,D6                        ; $26FC60
        MOVEQ   #-$1E,D6                        ; $26FC62
        MOVEQ   #-$1F,D6                        ; $26FC64
        DC.W    $7BDF               ; $26FC66 MOVE.W  (A7)+,<EA:3D>
        DC.W    $7BDE               ; $26FC68 MOVE.W  (A6)+,<EA:3D>
        DC.W    $7BDD               ; $26FC6A MOVE.W  (A5)+,<EA:3D>
        MOVEQ   #-$25,D6                        ; $26FC6C
        DC.W    $7DD4               ; $26FC6E MOVE.W  (A4),<EA:3E>
        DC.W    $7DCE               ; $26FC70 MOVE.W  A6,<EA:3E>
        MOVEQ   #-$38,D6                        ; $26FC72
        DC.W    $7DBE,$7EAE         ; $26FC74 MOVE.W  <EA:3E>,-$52(A6,D7.L)
        OR.L   (A7),D0                          ; $26FC78
        OR.W   -$7C9B(PC),D1                    ; $26FC7A
        OR.W   D1,(A1)+                         ; $26FC7E
        OR.W   A6,D2                            ; $26FC80
        DC.W    $853D               ; $26FC82 OR.B   D2,<EA:3D>
        OR.B   D2,-$7ADA(A4)                    ; $26FC84
        OR.B   D2,-$7CC5(A3)                    ; $26FC88
        OR.W   (A4),D0                          ; $26FC8C
        MOVE.W  -(A6),$7F6C(A7)                 ; $26FC8E
        MOVEQ   #$6D,D7                         ; $26FC92
        MOVE.W  $7D(A5,D7.L),$7B84(A6)          ; $26FC94
        MOVEQ   #-$74,D6                        ; $26FC9A
        MOVEQ   #-$74,D6                        ; $26FC9C
        MOVE.W  D0,$73(A6,D7.L)                 ; $26FC9E
        MOVE.W  $79(A1,D7.L),$7C7A(A6)          ; $26FCA2
        MOVEQ   #$76,D6                         ; $26FCA8
        MOVEQ   #$73,D6                         ; $26FCAA
        MOVEQ   #$72,D6                         ; $26FCAC
        MOVEQ   #$69,D6                         ; $26FCAE
        MOVE.W  (A1),$7F36(A6)                  ; $26FCB0
        OR.B   D0,-$7EDB(A1)                    ; $26FCB4
        OR.B   D0,-(A1)                         ; $26FCB8
        OR.B   D0,-(A0)                         ; $26FCBA
        OR.B   D0,-(A1)                         ; $26FCBC
        OR.B   D0,-(A3)                         ; $26FCBE
        OR.B   -(A4),D1                         ; $26FCC0
        OR.B   D2,-(A6)                         ; $26FCC2
        OR.B   -(A7),D3                         ; $26FCC4
        OR.B   -$7DCA(A3),D2                    ; $26FCC6
        OR.B   D0,#$8240                        ; $26FCCA
        OR.W   A3,D1                            ; $26FCCE
        OR.W   D0,(A4)+                         ; $26FCD0
        OR.W   -$7E(A0,D7.L),D0                 ; $26FCD2
        MOVE.W  (A3),-$5D(A7,D7.L)              ; $26FCD6
        MOVE.W  $7FBB(A5),-$34(A7,D7.L)         ; $26FCDA
        DC.W    $7DDE               ; $26FCE0 MOVE.W  (A6)+,<EA:3E>
        MOVEQ   #-$1D,D6                        ; $26FCE2
        DC.W    $7DE6               ; $26FCE4 MOVE.W  -(A6),<EA:3E>
        MOVEQ   #-$19,D7                        ; $26FCE6
        MOVEQ   #-$1A,D7                        ; $26FCE8
        MOVEQ   #-$1B,D7                        ; $26FCEA
        MOVEQ   #-$1D,D7                        ; $26FCEC
        DC.W    $7FE2               ; $26FCEE MOVE.W  -(A2),<EA:3F>
        MOVEQ   #-$20,D7                        ; $26FCF0
        DC.W    $7DDF               ; $26FCF2 MOVE.W  (A7)+,<EA:3E>
        DC.W    $7DDE               ; $26FCF4 MOVE.W  (A6)+,<EA:3E>
        DC.W    $7DDC               ; $26FCF6 MOVE.W  (A4)+,<EA:3E>
        DC.W    $7DD5               ; $26FCF8 MOVE.W  (A5),<EA:3E>
        MOVEQ   #-$36,D6                        ; $26FCFA
        MOVEQ   #-$43,D6                        ; $26FCFC
        MOVE.W  -$7F68(A5),$7D(A6,A0.W)         ; $26FCFE
        OR.W   (A5),D3                          ; $26FD04
        OR.B   $30(A6,A0.L),D4                  ; $26FD06
        OR.B   -$7BDA(A7),D3                    ; $26FD0A
        OR.B   D1,-(A3)                         ; $26FD0E
        OR.B   $7F48(A4),D1                     ; $26FD10
        MOVE.W  $7896(A7),$79B0(A5)             ; $26FD14
        MOVEQ   #-$44,D5                        ; $26FD1A
        MOVEQ   #-$3D,D5                        ; $26FD1C
        MOVEQ   #-$38,D5                        ; $26FD1E
        MOVE.W  A1,#$79C6                       ; $26FD20
        MOVEQ   #-$40,D5                        ; $26FD24
        MOVE.W  -$5E(A2,D7.L),-$72(A5,D7.L)     ; $26FD26
        MOVEQ   #$77,D7                         ; $26FD2C
        MOVEQ   #$67,D7                         ; $26FD2E
        MOVE.W  (A6)+,$7C5D(A6)                 ; $26FD30
        MOVE.W  (A7)+,$7B5E(A5)                 ; $26FD34
        MOVE.W  (A7)+,$7C5D(A5)                 ; $26FD38
        MOVEQ   #$53,D7                         ; $26FD3C
        OR.W   D0,D4                            ; $26FD3E
        OR.B   $26(A3,A0.W),D1                  ; $26FD40
        OR.B   D2,-(A1)                         ; $26FD44
        OR.B   D2,(A7)+                         ; $26FD46
        OR.B   (A6)+,D3                         ; $26FD48
        OR.B   (A7)+,D3                         ; $26FD4A
        OR.B   -(A0),D3                         ; $26FD4C
        OR.B   D3,-(A2)                         ; $26FD4E
        OR.B   D3,-(A3)                         ; $26FD50
        OR.B   -(A5),D3                         ; $26FD52
        OR.B   -(A6),D2                         ; $26FD54
        OR.B   -(A7),D1                         ; $26FD56
        MOVE.W  $7F43(A5),-(A7)                 ; $26FD58
        MOVEQ   #$5E,D7                         ; $26FD5C
        MOVEQ   #$72,D7                         ; $26FD5E
        MOVE.W  D0,-$73(A7,D7.L)                ; $26FD60
        MOVEQ   #-$65,D7                        ; $26FD64
        MOVE.W  -(A6),-$51(A6,D7.L)             ; $26FD66
        MOVEQ   #-$48,D7                        ; $26FD6A
        DC.W    $7FC4               ; $26FD6C MOVE.W  D4,<EA:3F>
        DC.W    $7FCF               ; $26FD6E MOVE.W  A7,<EA:3F>
        MOVEQ   #-$29,D7                        ; $26FD70
        MOVEQ   #-$21,D7                        ; $26FD72
        DC.W    $7DE2               ; $26FD74 MOVE.W  -(A2),<EA:3E>
        MOVEQ   #-$1E,D6                        ; $26FD76
        MOVEQ   #-$1E,D6                        ; $26FD78
        DC.W    $7DE1               ; $26FD7A MOVE.W  -(A1),<EA:3E>
        MOVEQ   #-$21,D7                        ; $26FD7C
        MOVEQ   #-$22,D7                        ; $26FD7E
        DC.W    $7DDC               ; $26FD80 MOVE.W  (A4)+,<EA:3E>
        MOVEQ   #-$2B,D6                        ; $26FD82
        MOVEQ   #-$30,D6                        ; $26FD84
        DC.W    $7BCF               ; $26FD86 MOVE.W  A7,<EA:3D>
        DC.W    $7BCA               ; $26FD88 MOVE.W  A2,<EA:3D>
        MOVEQ   #-$3B,D6                        ; $26FD8A
        MOVEQ   #-$47,D7                        ; $26FD8C
        OR.L   D0,(A4)+                         ; $26FD8E
        OR.W   D2,$56(A5,A0.W)                  ; $26FD90
        OR.W   D2,D3                            ; $26FD94
        OR.B   $30(A6,A0.W),D2                  ; $26FD96
        MOVE.W  $7C517A75,-(A7)                 ; $26FD9A
        MOVE.W  -(A1),-$3D(A3,D7.W)             ; $26FDA0
        MOVEQ   #-$33,D4                        ; $26FDA4
        MOVEQ   #-$2C,D5                        ; $26FDA6
        DC.W    $7BD5               ; $26FDA8 MOVE.W  (A5),<EA:3D>
        MOVEQ   #-$38,D6                        ; $26FDAA
        MOVEQ   #-$48,D6                        ; $26FDAC
        MOVEQ   #-$53,D6                        ; $26FDAE
        MOVE.W  -(A3),-$68(A6,D7.L)             ; $26FDB0
        MOVE.W  A3,$79(A7,A0.W)                 ; $26FDB4
        OR.W   D0,-(A5)                         ; $26FDB8
        OR.W   D0,A7                            ; $26FDBA
        OR.B   D0,$7F2F7D30                     ; $26FDBC
        MOVE.W  $2D(A3,D7.L),-(A6)              ; $26FDC2
        OR.B   -(A0),D1                         ; $26FDC6
        OR.B   D1,(A5)+                         ; $26FDC8
        OR.B   D1,(A4)+                         ; $26FDCA
        OR.B   D1,(A3)+                         ; $26FDCC
        OR.B   (A3)+,D2                         ; $26FDCE
        OR.B   D2,(A4)+                         ; $26FDD0
        OR.B   D2,(A6)+                         ; $26FDD2
        OR.B   D2,(A7)+                         ; $26FDD4
        OR.B   -(A0),D3                         ; $26FDD6
        OR.B   -(A1),D3                         ; $26FDD8
        OR.B   -(A3),D3                         ; $26FDDA
        OR.B   D2,-(A4)                         ; $26FDDC
        OR.B   -(A5),D2                         ; $26FDDE
        OR.B   D1,-(A6)                         ; $26FDE0
        OR.B   -$7ED2(A0),D1                    ; $26FDE2
        MOVEQ   #$44,D7                         ; $26FDE6
        MOVE.W  (A6)+,$7C77(A6)                 ; $26FDE8
        MOVE.W  (A2),-$5B(A6,D7.L)              ; $26FDEC
        MOVEQ   #-$52,D7                        ; $26FDF0
        MOVE.W  -$42(A5,D7.L),-$3F(A7,D7.L)     ; $26FDF2
        MOVEQ   #-$3D,D7                        ; $26FDF8
        DC.W    $7FC8               ; $26FDFA MOVE.W  A0,<EA:3F>
        MOVEQ   #-$37,D7                        ; $26FDFC
        MOVEQ   #-$34,D7                        ; $26FDFE
        MOVEQ   #-$2C,D7                        ; $26FE00
        DC.W    $7DDC               ; $26FE02 MOVE.W  (A4)+,<EA:3E>
        MOVEQ   #-$22,D6                        ; $26FE04
        DC.W    $7DDF               ; $26FE06 MOVE.W  (A7)+,<EA:3E>
        MOVEQ   #-$21,D6                        ; $26FE08
        MOVEQ   #-$22,D6                        ; $26FE0A
        MOVEQ   #-$23,D6                        ; $26FE0C
        MOVEQ   #-$25,D6                        ; $26FE0E
        MOVEQ   #-$26,D7                        ; $26FE10
        DC.W    $7FD9               ; $26FE12 MOVE.W  (A1)+,<EA:3F>
        DC.W    $7FD7               ; $26FE14 MOVE.W  (A7),<EA:3F>
        DC.W    $7FD5               ; $26FE16 MOVE.W  (A5),<EA:3F>
        DIVU    A1,D0                           ; $26FE18
        OR.L   D1,-$60(A4,A0.W)                 ; $26FE1A
        OR.L   D2,(A0)                          ; $26FE1E
        OR.L   D6,D2                            ; $26FE20
        DC.W    $827F               ; $26FE22 OR.W   <EA:3F>,D1
        OR.W   D0,$806D.W                       ; $26FE24
        MOVEQ   #$6F,D7                         ; $26FE28
        MOVE.W  D0,-$74(A5,D7.L)                ; $26FE2A
        MOVE.W  (A4),-$67(A4,D7.L)              ; $26FE2E
        MOVE.W  (A3)+,-$64(A5,D7.L)             ; $26FE32
        MOVE.W  (A6)+,-$68(A5,D7.L)             ; $26FE36
        MOVE.W  A1,$7A(A7,A0.W)                 ; $26FE3A
        MOVE.W  $65(A0,D7.L),$7F54(A7)          ; $26FE3E
        OR.W   D0,D1                            ; $26FE44
        OR.B   D0,$37(A7,D7.L)                  ; $26FE46
        DC.W    $7D3D               ; $26FE4A MOVE.W  <EA:3D>,-(A6)
        MOVEQ   #$41,D6                         ; $26FE4C
        MOVE.W  D0,$7D3E(A6)                    ; $26FE4E
        MOVE.W  $8031812A,-(A7)                 ; $26FE52
        OR.B   D0,-(A7)                         ; $26FE58
        OR.B   D0,-(A1)                         ; $26FE5A
        OR.B   (A6)+,D1                         ; $26FE5C
        OR.B   D1,(A6)+                         ; $26FE5E
        OR.B   D2,(A6)+                         ; $26FE60
        OR.B   D2,(A7)+                         ; $26FE62
        OR.B   D2,-(A0)                         ; $26FE64
        OR.B   D2,-(A1)                         ; $26FE66
        OR.B   D2,-(A2)                         ; $26FE68
        OR.B   -(A4),D2                         ; $26FE6A
        OR.B   D1,-(A5)                         ; $26FE6C
        OR.B   D0,-(A6)                         ; $26FE6E
        OR.B   -(A7),D0                         ; $26FE70
        OR.B   -$7FD1(A1),D0                    ; $26FE72
        MOVE.W  D4,$7F5B(A7)                    ; $26FE76
        MOVEQ   #$72,D7                         ; $26FE7A
        MOVE.W  A1,-$5B(A7,D7.L)                ; $26FE7C
        MOVEQ   #-$46,D7                        ; $26FE80
        DC.W    $7DC8               ; $26FE82 MOVE.W  A0,<EA:3E>
        DC.W    $7DD6               ; $26FE84 MOVE.W  (A6),<EA:3E>
        DC.W    $7DE2               ; $26FE86 MOVE.W  -(A2),<EA:3E>
        MOVEQ   #-$1B,D6                        ; $26FE88
        MOVEQ   #-$1B,D6                        ; $26FE8A
        DC.W    $7DE5               ; $26FE8C MOVE.W  -(A5),<EA:3E>
        MOVEQ   #-$1C,D7                        ; $26FE8E
        DC.W    $7FE3               ; $26FE90 MOVE.W  -(A3),<EA:3F>
        DIVU    -(A1),D0                        ; $26FE92
        DIVU    -(A0),D0                        ; $26FE94
        DC.W    $7FDE               ; $26FE96 MOVE.W  (A6)+,<EA:3F>
        MOVEQ   #-$23,D7                        ; $26FE98
        DC.W    $7FDB               ; $26FE9A MOVE.W  (A3)+,<EA:3F>
        DC.W    $7FD7               ; $26FE9C MOVE.W  (A7),<EA:3F>
        DIVU    A0,D0                           ; $26FE9E
        MOVE.W  $7EB3.W,-$50(A7,D7.L)           ; $26FEA0
        MOVEQ   #-$5B,D7                        ; $26FEA6
        OR.L   (A3),D0                          ; $26FEA8
        DC.W    $827E               ; $26FEAA OR.W   <EA:3E>,D1
        OR.W   D1,-$7D9C(A5)                    ; $26FEAC
        OR.W   -(A4),D0                         ; $26FEB0
        MOVE.W  $7E6F(A0),$7C7A(A7)             ; $26FEB2
        MOVEQ   #-$6E,D5                        ; $26FEB8
        MOVE.W  $78BE(A4),-$3B(A4,D7.L)         ; $26FEBA
        DC.W    $7BC7               ; $26FEC0 MOVE.W  D7,<EA:3D>
        DC.W    $7DC9               ; $26FEC2 MOVE.W  A1,<EA:3E>
        DC.W    $7FC4               ; $26FEC4 MOVE.W  D4,<EA:3F>
        OR.L   D0,-$67(A2,A0.W)                 ; $26FEC6
        OR.L   D1,D2                            ; $26FECA
        OR.W   -$7D9B(A4),D2                    ; $26FECC
        OR.W   D0,-(A1)                         ; $26FED0
        OR.W   D0,(A3)                          ; $26FED2
        OR.W   D2,D1                            ; $26FED4
        OR.B   $35(A6,A0.W),D1                  ; $26FED6
        MOVE.W  $7E3A7F32,-(A7)                 ; $26FEDA
        OR.B   $7E34(A6),D0                     ; $26FEE0
        MOVEQ   #$3E,D6                         ; $26FEE4
        MOVEQ   #$46,D6                         ; $26FEE6
        MOVE.W  D5,$7F32(A6)                    ; $26FEE8
        OR.B   D0,-(A5)                         ; $26FEEC
        OR.B   D0,-(A3)                         ; $26FEEE
        OR.B   D0,-(A0)                         ; $26FEF0
        OR.B   D0,(A7)+                         ; $26FEF2
        OR.B   (A7)+,D1                         ; $26FEF4
        OR.B   D1,-(A0)                         ; $26FEF6
        OR.B   D1,-(A2)                         ; $26FEF8
        OR.B   -(A3),D1                         ; $26FEFA
        OR.B   -(A5),D0                         ; $26FEFC
        OR.B   -(A6),D0                         ; $26FEFE
        MOVE.W  $7F35(A4),-(A7)                 ; $26FF00
        MOVE.W  #$8145,-(A7)                    ; $26FF04
        OR.W   (A0),D1                          ; $26FF08
        OR.W   D0,(A3)+                         ; $26FF0A
        OR.W   $7E7C(A0),D0                     ; $26FF0C
        MOVE.W  (A4),-$4E(A6,D7.L)              ; $26FF10
        MOVEQ   #-$30,D6                        ; $26FF14
        MOVEQ   #-$22,D6                        ; $26FF16
        DC.W    $7DE4               ; $26FF18 MOVE.W  -(A4),<EA:3E>
        DC.W    $7FE7               ; $26FF1A MOVE.W  -(A7),<EA:3F>
        DIVU    $7FE6(A0),D0                    ; $26FF1C
        DC.W    $7FE4               ; $26FF20 MOVE.W  -(A4),<EA:3F>
        DC.W    $7FE1               ; $26FF22 MOVE.W  -(A1),<EA:3F>
        DIVU    (A1)+,D0                        ; $26FF24
        DIVU    (A6),D0                         ; $26FF26
        MOVEQ   #-$26,D7                        ; $26FF28
        MOVEQ   #-$25,D6                        ; $26FF2A
        DC.W    $7DD6               ; $26FF2C MOVE.W  (A6),<EA:3E>
        DC.W    $7FC6               ; $26FF2E MOVE.W  D6,<EA:3F>
        OR.L   D0,-$7C74(A5)                    ; $26FF30
        OR.W   -$7BA6(A6),D2                    ; $26FF34
        OR.W   D1,A7                            ; $26FF38
        OR.W   D0,A5                            ; $26FF3A
        MOVEQ   #$61,D7                         ; $26FF3C
        MOVEQ   #-$7D,D5                        ; $26FF3E
        MOVE.W  $76C6(A2),-$2F(A3,D7.W)         ; $26FF40
        MOVE.W  (A7),#$7ADA                     ; $26FF46
        DC.W    $7BD9               ; $26FF4A MOVE.W  (A1)+,<EA:3D>
        MOVEQ   #-$29,D6                        ; $26FF4C
        DC.W    $7DD6               ; $26FF4E MOVE.W  (A6),<EA:3E>
        MOVEQ   #-$2C,D7                        ; $26FF50
        DC.W    $7FD1               ; $26FF52 MOVE.W  (A1),<EA:3F>
        DIVU    A0,D0                           ; $26FF54
        OR.L   D0,$82A1.W                       ; $26FF56
        OR.L   D1,D1                            ; $26FF5A
        OR.W   -(A0),D2                         ; $26FF5C
        OR.W   D1,D3                            ; $26FF5E
        OR.B   -$7BE2(A5),D3                    ; $26FF60
        OR.B   (A2)+,D1                         ; $26FF64
        MOVEQ   #$26,D7                         ; $26FF66
        MOVE.W  $46(A6,D7.L),-(A5)              ; $26FF68
        MOVEQ   #$53,D5                         ; $26FF6C
        MOVEQ   #$53,D6                         ; $26FF6E
        MOVE.W  A3,$7D40(A6)                    ; $26FF70
        MOVE.W  $2B(A6,D7.L),-(A6)              ; $26FF74
        MOVEQ   #$23,D7                         ; $26FF78
        MOVE.W  (A6)+,-(A7)                     ; $26FF7A
        OR.B   (A5)+,D0                         ; $26FF7C
        OR.B   D0,(A5)+                         ; $26FF7E
        OR.B   D0,(A6)+                         ; $26FF80
        OR.B   D0,(A7)+                         ; $26FF82
        OR.B   -(A1),D1                         ; $26FF84
        OR.B   D1,-(A2)                         ; $26FF86
        OR.B   D1,-(A3)                         ; $26FF88
        OR.B   D1,-(A4)                         ; $26FF8A
        OR.B   -(A6),D1                         ; $26FF8C
        OR.B   D0,-(A7)                         ; $26FF8E
        OR.B   $7F34(A1),D0                     ; $26FF90
        MOVE.W  A5,-$7E9D(A7)                   ; $26FF94
        OR.W   D0,-$80(A7,A0.W)                 ; $26FF98
        OR.L   D1,D1                            ; $26FF9C
        OR.L   D0,D7                            ; $26FF9E
        MOVE.W  (A0)+,-$56(A7,D7.L)             ; $26FFA0
        MOVEQ   #-$46,D6                        ; $26FFA4
        DC.W    $7DCB               ; $26FFA6 MOVE.W  A3,<EA:3E>
        MOVEQ   #-$25,D7                        ; $26FFA8
        DC.W    $7FE2               ; $26FFAA MOVE.W  -(A2),<EA:3F>
        DIVS    -(A0),D0                        ; $26FFAC
        DIVS    -(A1),D0                        ; $26FFAE
        DIVS    -(A3),D0                        ; $26FFB0
        DC.W    $7FE2               ; $26FFB2 MOVE.W  -(A2),<EA:3F>
        DC.W    $7FE1               ; $26FFB4 MOVE.W  -(A1),<EA:3F>
        DC.W    $7FDF               ; $26FFB6 MOVE.W  (A7)+,<EA:3F>
        DC.W    $7FDC               ; $26FFB8 MOVE.W  (A4)+,<EA:3F>
        MOVEQ   #-$31,D7                        ; $26FFBA
        MOVEQ   #-$4A,D7                        ; $26FFBC
        OR.L   (A5),D1                          ; $26FFBE
        OR.L   D1,A2                            ; $26FFC0
        OR.L   D1,A0                            ; $26FFC2
        OR.W   -$7E97(PC),D1                    ; $26FFC4
        OR.W   D0,$7D87(A1)                     ; $26FFC8
        MOVE.W  -$39(A2,D7.W),-$30(A4,D7.L)     ; $26FFCC
        DC.W    $7BD6               ; $26FFD2 MOVE.W  (A6),<EA:3D>
        MOVEQ   #-$27,D6                        ; $26FFD4
        MOVEQ   #-$27,D6                        ; $26FFD6
        MOVEQ   #-$29,D6                        ; $26FFD8
        MOVEQ   #-$2B,D7                        ; $26FFDA
        DC.W    $7FD3               ; $26FFDC MOVE.W  (A3),<EA:3F>
        DC.W    $7FC8               ; $26FFDE MOVE.W  A0,<EA:3F>
        OR.L   -$61(A4,A0.W),D0                 ; $26FFE0
        OR.L   D4,D1                            ; $26FFE4
        OR.W   D1,-(A7)                         ; $26FFE6
        OR.W   D1,(A2)                          ; $26FFE8
        OR.W   D0,A2                            ; $26FFEA
        MOVE.W  D7,$7E44(A7)                    ; $26FFEC
        MOVE.W  D0,$7D3D(A6)                    ; $26FFF0
        MOVEQ   #$3F,D6                         ; $26FFF4
        MOVE.W  D3,$7B43(A5)                    ; $26FFF6
        MOVEQ   #$3D,D6                         ; $26FFFA
        MOVE.W  $2F(A7,D7.L),-(A6)              ; $26FFFC
        MOVEQ   #$25,D7                         ; $270000
        MOVE.W  (A7)+,-(A7)                     ; $270002
        OR.B   D0,(A5)+                         ; $270004
        OR.B   (A5)+,D1                         ; $270006
        OR.B   (A5)+,D1                         ; $270008
        OR.B   (A6)+,D1                         ; $27000A
        OR.B   (A7)+,D1                         ; $27000C
        OR.B   -(A1),D2                         ; $27000E
        OR.B   D1,-(A2)                         ; $270010
        OR.B   D0,-(A3)                         ; $270012
        OR.B   D0,-(A4)                         ; $270014
        OR.B   D0,-(A5)                         ; $270016
        OR.B   D0,-(A6)                         ; $270018
        OR.B   D0,$7F2C(A0)                     ; $27001A
        MOVE.W  $4E(PC,D7.L),-(A7)              ; $27001E
        MOVE.W  (A7)+,-$7F8E(A7)                ; $270022
        OR.L   D0,D3                            ; $270026
        OR.L   D0,A6                            ; $270028
        OR.L   D0,(A2)                          ; $27002A
        OR.L   D0,(A0)+                         ; $27002C
        OR.L   D0,-(A0)                         ; $27002E
        OR.L   D0,-(A4)                         ; $270030
        OR.L   -(A6),D1                         ; $270032
        OR.L   -$43(A0,A0.W),D1                 ; $270034
        DIVU    D5,D0                           ; $270038
        DIVS    A2,D0                           ; $27003A
        DIVS    A7,D0                           ; $27003C
        DIVU    (A3),D0                         ; $27003E
        MOVEQ   #-$2A,D7                        ; $270040
        MOVEQ   #-$24,D6                        ; $270042
        MOVEQ   #-$21,D6                        ; $270044
        DC.W    $7DDF               ; $270046 MOVE.W  (A7)+,<EA:3E>
        DC.W    $7FDE               ; $270048 MOVE.W  (A6)+,<EA:3F>
        DIVS    (A7),D0                         ; $27004A
        DIVS    A0,D1                           ; $27004C
        OR.L   D2,$85A8.W                       ; $27004E
        OR.L   (A7),D2                          ; $270052
        OR.L   (A1),D1                          ; $270054
        OR.L   (A5)+,D0                         ; $270056
        MOVE.W  -$36(A6,D7.L),-$30(A6,D7.L)     ; $270058
        MOVE.W  (A4),#$79D7                     ; $27005E
        MOVEQ   #-$29,D5                        ; $270062
        MOVEQ   #-$2B,D6                        ; $270064
        DC.W    $7DD3               ; $270066 MOVE.W  (A3),<EA:3E>
        MOVEQ   #-$32,D7                        ; $270068
        MOVE.W  -$57(PC,D7.L),-$66(A7,D7.L)     ; $27006A
        MOVE.W  A1,$7D(A7,D7.L)                 ; $270070
        OR.W   -$7F9F(A6),D0                    ; $270074
        MOVE.W  (A3),$7E45(A7)                  ; $270078
        MOVE.W  $7C39(PC),-(A6)                 ; $27007C
        DC.W    $7B3E               ; $270080 MOVE.W  <EA:3E>,-(A5)
        MOVEQ   #$40,D6                         ; $270082
        MOVE.W  $7E2E7E23,-(A6)                 ; $270084
        MOVEQ   #$1D,D7                         ; $27008A
        MOVEQ   #$1A,D7                         ; $27008C
        MOVE.W  (A1)+,-(A7)                     ; $27008E
        OR.B   (A1)+,D0                         ; $270090
        OR.B   (A3)+,D0                         ; $270092
        OR.B   (A4)+,D0                         ; $270094
        OR.B   (A5)+,D0                         ; $270096
        OR.B   D0,(A7)+                         ; $270098
        OR.B   D1,-(A0)                         ; $27009A
        OR.B   -(A1),D2                         ; $27009C
        OR.B   -(A2),D2                         ; $27009E
        OR.B   -(A3),D1                         ; $2700A0
        OR.B   D0,-(A4)                         ; $2700A2
        OR.B   -(A5),D1                         ; $2700A4
        OR.B   D1,-(A7)                         ; $2700A6
        OR.B   D1,-$7DD7(A0)                    ; $2700A8
        OR.B   -$7FC2(A5),D0                    ; $2700AC
        OR.W   (A6),D0                          ; $2700B0
        OR.W   -$75(A1,A0.W),D0                 ; $2700B2
        OR.L   D0,(A7)+                         ; $2700B6
        OR.L   -(A7),D1                         ; $2700B8
        OR.L   D1,-$7D4B(A7)                    ; $2700BA
        OR.L   -$4C(A1,A0.W),D1                 ; $2700BE
        DIVU    D5,D1                           ; $2700C2
        DIVS    (A6),D0                         ; $2700C4
        DIVU    (A7)+,D0                        ; $2700C6
        DIVU    -(A2),D0                        ; $2700C8
        DIVU    -(A4),D0                        ; $2700CA
        DC.W    $7FE4               ; $2700CC MOVE.W  -(A4),<EA:3F>
        DC.W    $7FE3               ; $2700CE MOVE.W  -(A3),<EA:3F>
        MOVEQ   #-$1F,D7                        ; $2700D0
        DC.W    $7DDE               ; $2700D2 MOVE.W  (A6)+,<EA:3E>
        DC.W    $7DD8               ; $2700D4 MOVE.W  (A0)+,<EA:3E>
        MOVEQ   #-$32,D7                        ; $2700D6
        OR.L   D0,-$7C5D(PC)                    ; $2700D8
        OR.L   A5,D3                            ; $2700DC
        OR.L   D2,D4                            ; $2700DE
        OR.L   D1,D2                            ; $2700E0
        OR.L   D0,A3                            ; $2700E2
        MOVE.W  -(A1),-$44(A7,D7.L)             ; $2700E4
        DC.W    $7BCC               ; $2700E8 MOVE.W  A4,<EA:3D>
        MOVEQ   #-$2D,D5                        ; $2700EA
        DC.W    $7BD6               ; $2700EC MOVE.W  (A6),<EA:3D>
        MOVEQ   #-$29,D5                        ; $2700EE
        MOVEQ   #-$2A,D5                        ; $2700F0
        MOVE.W  (A5),#$7AD3                     ; $2700F2
        DC.W    $7BD2               ; $2700F6 MOVE.W  (A2),<EA:3D>
        MOVEQ   #-$30,D6                        ; $2700F8
        MOVEQ   #-$32,D6                        ; $2700FA
        DC.W    $7DC5               ; $2700FC MOVE.W  D5,<EA:3E>
        MOVE.W  -$62(A3,D7.L),-$75(A6,D7.L)     ; $2700FE
        MOVEQ   #$79,D7                         ; $270104
        MOVEQ   #$6A,D7                         ; $270106
        MOVEQ   #$54,D7                         ; $270108
        DC.W    $7F3D               ; $27010A MOVE.W  <EA:3D>,-(A7)
        MOVE.W  $7F1B(A2),-(A7)                 ; $27010C
        MOVE.W  (A7),-(A6)                      ; $270110
        MOVE.W  (A7),-(A6)                      ; $270112
        MOVE.W  (A4),-(A6)                      ; $270114
        MOVE.W  (A3),-(A6)                      ; $270116
        MOVEQ   #$15,D7                         ; $270118
        MOVE.W  (A6),-(A7)                      ; $27011A
        OR.B   (A7),D0                          ; $27011C
        OR.B   (A0)+,D0                         ; $27011E
        OR.B   (A2)+,D0                         ; $270120
        OR.B   (A3)+,D0                         ; $270122
        OR.B   (A4)+,D0                         ; $270124
        OR.B   D0,(A5)+                         ; $270126
        OR.B   D0,(A7)+                         ; $270128
        OR.B   D0,-(A0)                         ; $27012A
        OR.B   D0,-(A1)                         ; $27012C
        OR.B   -(A2),D1                         ; $27012E
        OR.B   D1,-(A3)                         ; $270130
        OR.B   -(A4),D1                         ; $270132
        OR.B   -(A6),D0                         ; $270134
        MOVEQ   #$2D,D7                         ; $270136
        MOVE.W  D6,$7D60(A6)                    ; $270138
        MOVEQ   #$6C,D7                         ; $27013C
        MOVE.W  $76(A1,A0.W),-$7E84(A7)         ; $27013E
        OR.L   D0,D2                            ; $270144
        OR.L   A1,D1                            ; $270146
        OR.L   A5,D1                            ; $270148
        OR.L   D1,A3                            ; $27014A
        OR.L   A5,D2                            ; $27014C
        OR.L   (A3),D2                          ; $27014E
        OR.L   D1,(A6)+                         ; $270150
        OR.L   -$7E46(A5),D1                    ; $270152
        DIVU    D7,D0                           ; $270156
        DIVU    (A2),D0                         ; $270158
        DIVU    (A4),D0                         ; $27015A
        DIVU    A7,D0                           ; $27015C
        DIVS    D1,D0                           ; $27015E
        OR.L   D1,-$64(A0,A0.W)                 ; $270160
        OR.L   A6,D3                            ; $270164
        OR.L   D7,D3                            ; $270166
        OR.L   D7,D2                            ; $270168
        OR.L   A7,D1                            ; $27016A
        MOVE.W  -(A2),-$42(A7,D7.L)             ; $27016C
        MOVE.W  (A1),#$77D7                     ; $270170
        MOVEQ   #-$25,D3                        ; $270174
        MOVEQ   #-$23,D3                        ; $270176
        MOVEQ   #-$24,D3                        ; $270178
        MOVE.W  (A2)+,-$27(PC,D7.W)             ; $27017A
        MOVEQ   #-$29,D4                        ; $27017E
        MOVEQ   #-$2A,D4                        ; $270180
        MOVE.W  (A5),#$79D3                     ; $270182
        MOVEQ   #-$2E,D5                        ; $270186
        DC.W    $7BC8               ; $270188 MOVE.W  A0,<EA:3D>
        MOVEQ   #-$4E,D6                        ; $27018A
        MOVE.W  (A7),$7C(A6,D7.L)               ; $27018C
        MOVE.W  -$7FA5(A3),-$7FB6(A7)           ; $270190
        OR.B   D0,$33(PC,A0.W)                  ; $270196
        MOVE.W  $7F1C(A0),-(A7)                 ; $27019A
        OR.B   D0,(A0)+                         ; $27019E
        OR.B   (A7),D1                          ; $2701A0
        OR.B   (A7),D1                          ; $2701A2
        OR.B   D0,(A0)+                         ; $2701A4
        OR.B   D0,(A1)+                         ; $2701A6
        OR.B   (A2)+,D0                         ; $2701A8
        MOVE.W  (A4)+,-(A7)                     ; $2701AA
        MOVE.W  (A5)+,-(A7)                     ; $2701AC
        MOVEQ   #$1E,D7                         ; $2701AE
        MOVE.W  (A7)+,-(A7)                     ; $2701B0
        OR.B   -(A0),D0                         ; $2701B2
        OR.B   D0,-(A2)                         ; $2701B4
        OR.B   D0,-(A3)                         ; $2701B6
        OR.B   -(A5),D0                         ; $2701B8
        OR.B   -$7FCE(A4),D0                    ; $2701BA
        OR.B   D0,$30(A3,A0.W)                  ; $2701BE
        OR.B   D1,-$7BD4(A4)                    ; $2701C2
        OR.B   -$7BD4(A4),D2                    ; $2701C6
        OR.B   D1,-$7EC9(A6)                    ; $2701CA
        OR.W   (A3),D0                          ; $2701CE
        OR.W   -$7E86(A4),D0                    ; $2701D0
        OR.L   D0,D1                            ; $2701D4
        DC.W    $847E               ; $2701D6 OR.W   <EA:3E>,D2
        OR.L   D2,D0                            ; $2701D8
        OR.L   D2,A6                            ; $2701DA
        OR.L   -(A1),D2                         ; $2701DC
        OR.L   D1,-$7D46(A5)                    ; $2701DE
        DIVU    (A0),D0                         ; $2701E2
        MOVEQ   #-$1E,D7                        ; $2701E4
        DC.W    $7DE6               ; $2701E6 MOVE.W  -(A6),<EA:3E>
        DC.W    $7FE8,$81E6         ; $2701E8 MOVE.W  -$7E1A(A0),<EA:3F>
        DIVS    (A3),D1                         ; $2701EC
        OR.L   $85A18592,D2                     ; $2701EE
        OR.L   D1,(A2)                          ; $2701F4
        MOVE.W  (A7)+,-$51(A7,D7.L)             ; $2701F6
        MOVEQ   #-$3E,D5                        ; $2701FA
        MOVEQ   #-$2A,D4                        ; $2701FC
        MOVEQ   #-$24,D3                        ; $2701FE
