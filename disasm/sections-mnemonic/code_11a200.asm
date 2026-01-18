; Generated assembly for $11A200-$11C200
; Branch targets: 71
; Labels: 67
; Format: DC.W with decoded mnemonics as comments

        org     $11A200

        SGT     $18(A7,D6.W)                    ; $11A200
        BMI.S  loc_11A260                       ; $11A204
        BLE.S  loc_11A283                       ; $11A206
        MOVE.W  (A4)+,-$43(A1,D7.W)             ; $11A208
        DC.W    $7FFF               ; $11A20C MOVE.W  <EA:3F>,<EA:3F>
loc_11A20E:
        DC.W    $7BDE               ; $11A20E MOVE.W  (A6)+,<EA:3D>
        MOVE.B  -(A7),(A6)+                     ; $11A210
        BEQ.S  loc_11A24D                       ; $11A212
        ADDQ.L  #3,$52(A5,D4.L)                 ; $11A214
        DC.W    $3DEF,$318C         ; $11A218 MOVE.W  $318C(A7),<EA:3E>
        MOVE.L  $7FFE(A1),-(A2)                 ; $11A21C
        DC.W    $7FFD               ; $11A220 MOVE.W  <EA:3D>,<EA:3F>
        DC.W    $7FDC               ; $11A222 MOVE.W  (A4)+,<EA:3F>
        DC.W    $7FDB               ; $11A224 MOVE.W  (A3)+,<EA:3F>
        DC.W    $7FDA               ; $11A226 MOVE.W  (A2)+,<EA:3F>
        DC.W    $7FFB,$7FB8         ; $11A228 MOVE.W  -$48(PC,D7.L),<EA:3F>
        DC.W    $7FB9,$7FBA,$7BDD,$7FDE; $11A22C MOVE.W  $7FBA7BDD,-$22(A7,D7.L)
        DC.W    $7FDD               ; $11A234 MOVE.W  (A5)+,<EA:3F>
        DC.W    $7FBD,$7758         ; $11A236 MOVE.W  <EA:3D>,$58(A7,D7.W)
        MOVE.W  $14(A5,D7.W),-(A3)              ; $11A23A
        MOVE.W  (A3),-(A1)                      ; $11A23E
        MOVEQ   #-$0E,D1                        ; $11A240
        MOVEQ   #-$2E,D1                        ; $11A242
        BGT.S  loc_11A217                       ; $11A244
        BGT.S  $11A1F8                          ; $11A246
        BGT.S  $11A1F9                          ; $11A248
        BGT.S  $11A1DA                          ; $11A24A
        BGT.S  $11A1DA                          ; $11A24C
loc_11A24E:
        BGT.S  loc_11A2BB                       ; $11A24E
        BGT.S  loc_11A29C                       ; $11A250
        MOVEQ   #$6A,D1                         ; $11A252
        MOVEQ   #$69,D1                         ; $11A254
        MOVEQ   #-$76,D3                        ; $11A256
        MOVE.W  (A4),$7F75(A7)                  ; $11A258
        MOVEQ   #-$55,D7                        ; $11A25C
        MOVEQ   #$48,D3                         ; $11A25E
loc_11A260:
        MOVEQ   #$49,D1                         ; $11A260
loc_11A262:
        BGT.S  loc_11A2AD                       ; $11A262
loc_11A264:
        BPL.S  loc_11A2B1                       ; $11A264
        BPL.S  loc_11A2D4                       ; $11A266
        BPL.S  $11A1F7                          ; $11A268
        MOVE.W  #$7B9B,$15(A5,D7.W)             ; $11A26A
loc_11A270:
        BGT.S  loc_11A264                       ; $11A270
loc_11A272:
        BGT.S  loc_11A267                       ; $11A272
        MOVE.W  (A2)+,$78(A7,D7.L)              ; $11A274
        MOVE.W  (A7),$7736(A3)                  ; $11A278
        BPL.S  loc_11A20D                       ; $11A27C
        BPL.S  loc_11A20E                       ; $11A27E
        BNE.S  loc_11A289                       ; $11A280
        BHI.S  loc_11A28B                       ; $11A282
        BSR.S  loc_11A26C                       ; $11A284
        BCS.S  loc_11A26D                       ; $11A286
        BCS.S  loc_11A24E                       ; $11A288
        BVS.S  loc_11A270                       ; $11A28A
        BLT.S  loc_11A272                       ; $11A28C
        BGT.S  loc_11A294                       ; $11A28E
        MOVEQ   #$04,D1                         ; $11A290
        MOVEQ   #$26,D1                         ; $11A292
loc_11A294:
        MOVE.W  (A3),$7ECD(A7)                  ; $11A294
        MOVEQ   #$46,D3                         ; $11A298
        MOVEQ   #$25,D3                         ; $11A29A
loc_11A29C:
        BSR.S  loc_11A262                       ; $11A29C
        DC.W    $7779,$664C,$6209,$5DC5; $11A29E MOVE.W  $664C6209,$5DC5(A3)
        SLT     D6                              ; $11A2A6
        MOVE.W  $4A(A4,D6.L),-(A7)              ; $11A2A8
        BPL.S  loc_11A2F7                       ; $11A2AC
        BNE.S  loc_11A2D9                       ; $11A2AE
        BNE.S  loc_11A2DA                       ; $11A2B0
        BNE.S  loc_11A2BC                       ; $11A2B2
        BSR.S  loc_11A29D                       ; $11A2B4
        SLT     D4                              ; $11A2B6
        SUBQ.L  #6,-(A4)                        ; $11A2B8
        MOVE.W  (A2)+,-$0D(A5,D7.W)             ; $11A2BA
        BSR.S  loc_11A283                       ; $11A2BE
        MOVEQ   #-$32,D7                        ; $11A2C0
        DC.W    $7BBD,$5DA3         ; $11A2C2 MOVE.W  <EA:3D>,-$5D(A5,D5.L)
        BPL.S  loc_11A335                       ; $11A2C6
        MOVEQ   #-$31,D5                        ; $11A2C8
        BGT.S  loc_11A314                       ; $11A2CA
        MOVE.W  $05(A6,D6.L),$7337(A7)          ; $11A2CC
        BHI.S  loc_11A2DC                       ; $11A2D2
loc_11A2D4:
        MOVEQ   #-$11,D7                        ; $11A2D4
        MOVEQ   #$27,D1                         ; $11A2D6
        MOVEQ   #-$53,D5                        ; $11A2D8
loc_11A2DA:
        MOVEQ   #$05,D1                         ; $11A2DA
loc_11A2DC:
        BPL.S  loc_11A306                       ; $11A2DC
loc_11A2DE:
        MOVEQ   #-$75,D1                        ; $11A2DE
        MOVEQ   #-$74,D1                        ; $11A2E0
        MOVEQ   #-$73,D1                        ; $11A2E2
        MOVEQ   #-$53,D3                        ; $11A2E4
        MOVEQ   #-$52,D3                        ; $11A2E6
        MOVEQ   #-$32,D5                        ; $11A2E8
loc_11A2EA:
        MOVE.W  (A1),-(A7)                      ; $11A2EA
        MOVEQ   #-$10,D7                        ; $11A2EC
        MOVEQ   #-$11,D5                        ; $11A2EE
        BPL.S  loc_11A2F8                       ; $11A2F0
        BHI.S  loc_11A31D                       ; $11A2F2
        BHI.S  loc_11A320                       ; $11A2F4
        BNE.S  loc_11A322                       ; $11A2F6
loc_11A2F8:
        MOVE.W  $34(A4,D7.L),-(A3)              ; $11A2F8
        MOVE.W  (A6),$7B57(A5)                  ; $11A2FC
        MOVE.W  (A7),-$68(A7,D7.L)              ; $11A300
        MOVE.W  (A6),$78(A7,D7.L)               ; $11A304
        ADDQ.B  #7,D7                           ; $11A308
        BHI.S  loc_11A337                       ; $11A30A
        SUBQ.L  #4,-(A3)                        ; $11A30C
        BGT.S  loc_11A337                       ; $11A30E
        MOVE.W  (A3),-(A5)                      ; $11A310
        MOVE.W  (A6),$664A(A3)                  ; $11A312
        BNE.S  loc_11A361                       ; $11A316
        BPL.S  loc_11A321                       ; $11A318
loc_11A31A:
        BPL.S  loc_11A342                       ; $11A31A
        BGT.S  loc_11A344                       ; $11A31C
        MOVEQ   #$47,D1                         ; $11A31E
loc_11A320:
        MOVE.W  $69(A2,D7.W),-(A7)              ; $11A320
        SUBQ.L  #4,-(A4)                        ; $11A324
        BNE.S  loc_11A373                       ; $11A326
        MOVE.W  (A5),$72CF(A7)                  ; $11A328
        MOVEQ   #-$51,D1                        ; $11A32C
        BGT.S  loc_11A2DE                       ; $11A32E
        SVS     D4                              ; $11A330
        BCS.S  loc_11A2F7                       ; $11A332
        BGT.S  loc_11A339                       ; $11A334
        MOVE.W  -$1D(A4,D6.L),$69C2(A7)         ; $11A336
        SUBQ.L  #4,D2                           ; $11A33C
        MOVE.W  -$7D(A6,D5.L),-(A1)             ; $11A33E
loc_11A342:
        BNE.S  loc_11A3B1                       ; $11A342
loc_11A344:
        SUBQ.L  #6,-(A5)                        ; $11A344
        SUBQ.L  #6,D2                           ; $11A346
        BPL.S  loc_11A34E                       ; $11A348
        SLT     D3                              ; $11A34A
        SUBQ.L  #6,-(A2)                        ; $11A34C
loc_11A34E:
        MOVEQ   #-$75,D5                        ; $11A34E
        BGT.S  loc_11A358                       ; $11A350
loc_11A352:
        MOVEQ   #-$2F,D1                        ; $11A352
        MOVEQ   #-$30,D3                        ; $11A354
        MOVEQ   #-$0F,D3                        ; $11A356
loc_11A358:
        MOVEQ   #-$30,D1                        ; $11A358
        BVS.S  loc_11A341                       ; $11A35A
        BPL.S  loc_11A363                       ; $11A35C
        DC.W    $7FD9               ; $11A35E MOVE.W  (A1)+,<EA:3F>
        MOVE.W  (A6),$6ED0(A7)                  ; $11A360
loc_11A364:
        MOVEQ   #-$0D,D3                        ; $11A364
        BSR.S  loc_11A2EA                       ; $11A366
        SUBQ.L  #4,D1                           ; $11A368
        BLT.S  loc_11A34E                       ; $11A36A
        MOVE.W  -(A2),$7B32.W                   ; $11A36C
        BSR.S  loc_11A313                       ; $11A370
        SUBQ.L  #6,D1                           ; $11A372
        BCS.S  loc_11A338                       ; $11A374
        BCS.S  loc_11A31A                       ; $11A376
        MOVEQ   #-$34,D7                        ; $11A378
        MOVEQ   #-$10,D3                        ; $11A37A
        SUBQ.W  #4,-(A1)                        ; $11A37C
        SUBQ.W  #4,-(A2)                        ; $11A37E
        MOVEQ   #-$0C,D1                        ; $11A380
        BNE.S  loc_11A38D                       ; $11A382
        MOVE.W  -$19(A7,D6.W),-$31(A7,D7.L)     ; $11A384
        BLT.S  loc_11A34E                       ; $11A38A
        MOVE.W  -(A4),$61A4.W                   ; $11A38C
        MOVE.W  (A2)+,$61(A3,D5.W)              ; $11A390
        SUBQ.W  #2,-(A2)                        ; $11A394
        BCS.S  loc_11A33B                       ; $11A396
        SUBQ.L  #2,D3                           ; $11A398
        MOVEQ   #-$0F,D5                        ; $11A39A
        MOVEQ   #-$54,D5                        ; $11A39C
        MOVEQ   #-$54,D3                        ; $11A39E
        SUBQ.L  #2,D2                           ; $11A3A0
loc_11A3A2:
        SLT     $6E8F(A0)                       ; $11A3A2
        SUBQ.W  #2,-(A0)                        ; $11A3A6
        SUBQ.W  #4,-(A0)                        ; $11A3A8
        SUBQ.L  #4,D0                           ; $11A3AA
        SUBQ.W  #6,-(A0)                        ; $11A3AC
        BVS.S  loc_11A371                       ; $11A3AE
        BCS.S  loc_11A373                       ; $11A3B0
        BCS.S  loc_11A355                       ; $11A3B2
        MOVEQ   #-$31,D3                        ; $11A3B4
        MOVEQ   #-$0E,D3                        ; $11A3B6
        MOVEQ   #$46,D1                         ; $11A3B8
        SUBQ.L  #2,D1                           ; $11A3BA
        BGT.S  loc_11A3AF                       ; $11A3BC
loc_11A3BE:
        BGT.S  loc_11A38F                       ; $11A3BE
        MOVE.W  (A2),-(A3)                      ; $11A3C0
        BSR.S  loc_11A364                       ; $11A3C2
        BGT.S  loc_11A40D                       ; $11A3C4
        SUBQ.W  #2,D0                           ; $11A3C6
        SUBQ.W  #4,D0                           ; $11A3C8
        BGT.S  loc_11A3D3                       ; $11A3CA
        BVS.S  loc_11A36F                       ; $11A3CC
        BCS.S  loc_11A351                       ; $11A3CE
        BSR.S  loc_11A352                       ; $11A3D0
        BSR.S  loc_11A434                       ; $11A3D2
        BSR.S  loc_11A3BE                       ; $11A3D4
        MOVEQ   #$6B,D3                         ; $11A3D6
        SUBQ.L  #4,D4                           ; $11A3D8
        MOVEQ   #$6B,D1                         ; $11A3DA
        BVS.S  loc_11A3A2                       ; $11A3DC
        DC.W    $0001,$FF00         ; $11A3DE ORI.B  #$FF00,D1
        MOVE.W  D0,-(A7)                        ; $11A3E2
        DC.W    $000F,$8B00         ; $11A3E4 ORI.B  #$8B00,A7
        DC.W    $0201,$0302         ; $11A3E8 ANDI.B  #$0302,D1
        BTST    D1,D3                           ; $11A3EC
        SUBI.B  #$0505,D4                       ; $11A3EE
        BTST    D2,D0                           ; $11A3F2
        DC.W    $0003,$0005         ; $11A3F4 ORI.B  #$0005,D3
        DC.W    $0006,$0505         ; $11A3F8 ORI.B  #$0505,D6
        BTST    D1,D4                           ; $11A3FC
        BTST    D1,D3                           ; $11A3FE
        BTST    D1,D2                           ; $11A400
        BTST    D1,D1                           ; $11A402
        MOVEQ   #$00,D7                         ; $11A404
        DC.W    $0038,$7C00,$0201   ; $11A406 ORI.B  #$7C00,$0201.W
        BTST    D1,D0                           ; $11A40C
        DC.W    $0002,$0003         ; $11A40E ORI.B  #$0003,D2
        DC.W    $0204,$0005         ; $11A412 ANDI.B  #$0005,D4
        DC.W    $0006,$0007         ; $11A416 ORI.B  #$0007,D6
        DC.W    $0008,$0009         ; $11A41A ORI.B  #$0009,A0
        DC.W    $000A,$000B         ; $11A41E ORI.B  #$000B,A2
        DC.W    $000C,$000D         ; $11A422 ORI.B  #$000D,A4
        DC.W    $000E,$000F         ; $11A426 ORI.B  #$000F,A6
        DC.W    $0010,$0011         ; $11A42A ORI.B  #$0011,(A0)
        DC.W    $0012,$0013         ; $11A42E ORI.B  #$0013,(A2)
        DC.W    $0014,$0015         ; $11A432 ORI.B  #$0015,(A4)
        DC.W    $0016,$0517         ; $11A436 ORI.B  #$0517,(A6)
        DC.W    $0018,$0019         ; $11A43A ORI.B  #$0019,(A0)+
        DC.W    $0200,$0005         ; $11A43E ANDI.B  #$0005,D0
        DC.W    $0009,$000E         ; $11A442 ORI.B  #$000E,A1
        DC.W    $0015,$0617         ; $11A446 ORI.B  #$0617,(A5)
        DC.W    $0018,$0016         ; $11A44A ORI.B  #$0016,(A0)+
        DC.W    $0015,$0014         ; $11A44E ORI.B  #$0014,(A5)
        DC.W    $001A,$0012         ; $11A452 ORI.B  #$0012,(A2)+
        DC.W    $0011,$001B         ; $11A456 ORI.B  #$001B,(A1)
        DC.W    $000F,$001C         ; $11A45A ORI.B  #$001C,A7
        DC.W    $000D,$001D         ; $11A45E ORI.B  #$001D,A5
        DC.W    $000B,$001E         ; $11A462 ORI.B  #$001E,A3
        DC.W    $0008,$001F         ; $11A466 ORI.B  #$001F,A0
        DC.W    $0019,$0006         ; $11A46A ORI.B  #$0006,(A1)+
        BTST    D0,D4                           ; $11A46E
        BTST    D5,D0                           ; $11A470
        DC.W    $0001,$0203         ; $11A472 ORI.B  #$0203,D1
        DC.W    $0002,$6900         ; $11A476 ORI.B  #$6900,D2
        DC.W    $002F,$6A00,$0301   ; $11A47A ORI.B  #$6A00,$0301(A7)
        BTST    D1,D2                           ; $11A480
        BTST    D1,D3                           ; $11A482
        DC.W    $0204,$0006         ; $11A484 ANDI.B  #$0006,D4
        DC.W    $0019,$001F         ; $11A488 ORI.B  #$001F,(A1)+
        DC.W    $0009,$0007         ; $11A48C ORI.B  #$0007,A1
        DC.W    $0001,$0100         ; $11A490 ORI.B  #$0100,D1
        DC.W    $0002,$0006         ; $11A494 ORI.B  #$0006,D2
        DC.W    $000B,$001B         ; $11A498 ORI.B  #$001B,A3
        DC.W    $001A,$0015         ; $11A49C ORI.B  #$0015,(A2)+
        DC.W    $0216,$0118         ; $11A4A0 ANDI.B  #$0118,(A6)
        MOVE.B  (A7),D2                         ; $11A4A4
        DC.W    $0019,$0000         ; $11A4A6 ORI.B  #$0000,(A1)+
        DC.W    $0004,$001E         ; $11A4AA ORI.B  #$001E,D4
        DC.W    $0011,$1717         ; $11A4AE ORI.B  #$1717,(A1)
        BTST    D0,(A0)+                        ; $11A4B2
        BTST    D0,(A6)                         ; $11A4B4
        DC.W    $0015,$0012         ; $11A4B6 ORI.B  #$0012,(A5)
        DC.W    $0003,$0700         ; $11A4BA ORI.B  #$0700,D3
        DC.W    $0002,$0005         ; $11A4BE ORI.B  #$0005,D2
        DC.W    $0019,$001E         ; $11A4C2 ORI.B  #$001E,(A1)+
        BTST    D0,(A2)+                        ; $11A4C6
        DC.W    $0011,$000E         ; $11A4C8 ORI.B  #$000E,(A1)
        DC.W    $0005,$0003         ; $11A4CC ORI.B  #$0003,D5
        DC.W    $0001,$0400         ; $11A4D0 ORI.B  #$0400,D1
        DC.W    $0002,$0003         ; $11A4D4 ORI.B  #$0003,D2
        DC.W    $0001,$5E00         ; $11A4D8 ORI.B  #$5E00,D1
        DC.W    $003B,$6400,$0101   ; $11A4DC ORI.B  #$6400,$01(PC,D0.W)
        DC.W    $0004,$0019         ; $11A4E2 ORI.B  #$0019,D4
        DC.W    $001F,$0008         ; $11A4E6 ORI.B  #$0008,(A7)+
        DC.W    $001E,$000A         ; $11A4EA ORI.B  #$000A,(A6)+
        DC.W    $000B,$001D         ; $11A4EE ORI.B  #$001D,A3
        DC.W    $000C,$001C         ; $11A4F2 ORI.B  #$001C,A4
        DC.W    $000E,$000F         ; $11A4F6 ORI.B  #$000F,A6
        DC.W    $0010,$0011         ; $11A4FA ORI.B  #$0011,(A0)
        DC.W    $001A,$0013         ; $11A4FE ORI.B  #$0013,(A2)+
        DC.W    $0014,$0315         ; $11A502 ORI.B  #$0315,(A4)
        BTST    D0,(A6)                         ; $11A506
        DC.W    $000D,$0002         ; $11A508 ORI.B  #$0002,A5
        DC.W    $0000,$0004         ; $11A50C ORI.B  #$0004,D0
        DC.W    $001D,$001A         ; $11A510 ORI.B  #$001A,(A5)+
        DC.W    $0015,$1C17         ; $11A514 ORI.B  #$1C17,(A5)
        DC.W    $0008,$0005         ; $11A518 ORI.B  #$0005,A0
        DC.W    $000F,$1E17         ; $11A51C ORI.B  #$1E17,A7
        DC.W    $0015,$0003         ; $11A520 ORI.B  #$0003,(A5)
        BTST    D2,D0                           ; $11A524
        DC.W    $0001,$0004         ; $11A526 ORI.B  #$0004,D1
        DC.W    $000B,$001B         ; $11A52A ORI.B  #$001B,A3
        DC.W    $0014,$0015         ; $11A52E ORI.B  #$0015,(A4)
        DC.W    $0018,$0117         ; $11A532 ORI.B  #$0117,(A0)+
        DC.W    $0018,$001A         ; $11A536 ORI.B  #$001A,(A0)+
        DC.W    $001B,$0007         ; $11A53A ORI.B  #$0007,(A3)+
        DC.W    $0002,$0300         ; $11A53E ORI.B  #$0300,D2
        DC.W    $001F,$0417         ; $11A542 ORI.B  #$0417,(A7)+
        DC.W    $000B,$0000         ; $11A546 ORI.B  #$0000,A3
        DC.W    $0017,$0009         ; $11A54A ORI.B  #$0009,(A7)
        DC.W    $0200,$0016         ; $11A54E ANDI.B  #$0016,D0
        DC.W    $0011,$5200         ; $11A552 ORI.B  #$5200,(A1)
        DC.W    $003E,$6300         ; $11A556 ORI.B  #$6300,<EA:3E>
        DC.W    $0002,$0006         ; $11A55A ORI.B  #$0006,D2
        DC.W    $0009,$000D         ; $11A55E ORI.B  #$000D,A1
        DC.W    $0013,$0016         ; $11A562 ORI.B  #$0016,(A3)
        MOVE.B  (A7),-(A1)                      ; $11A566
        DC.W    $000E,$0002         ; $11A568 ORI.B  #$0002,A6
        DC.W    $0019,$0011         ; $11A56C ORI.B  #$0011,(A1)+
        DC.W    $0016,$0D17         ; $11A570 ORI.B  #$0D17,(A6)
        SUBI.B  #$0121,-(A0)                    ; $11A574
        BTST    D0,-(A2)                        ; $11A578
        BTST    D0,-(A3)                        ; $11A57A
        BTST    D0,-(A4)                        ; $11A57C
        DC.W    $0020,$0217         ; $11A57E ORI.B  #$0217,-(A0)
        BTST    D0,(A2)                         ; $11A582
        BTST    D1,(A7)                         ; $11A584
        DC.W    $0025,$0226         ; $11A586 ORI.B  #$0226,-(A5)
        DC.W    $0227,$0328         ; $11A58A ANDI.B  #$0328,-(A7)
        BTST    D0,-(A3)                        ; $11A58E
        BTST    D0,-(A2)                        ; $11A590
        BTST    D0,-(A1)                        ; $11A592
        BTST    #23,-(A0)                       ; $11A594
        DC.W    $0015,$0003         ; $11A598 ORI.B  #$0003,(A5)
        SUBI.B  #$0001,D0                       ; $11A59C
        DC.W    $001E,$001B         ; $11A5A0 ORI.B  #$001B,(A6)+
        DC.W    $0015,$0318         ; $11A5A4 ORI.B  #$0318,(A5)
        DC.W    $0029,$0018,$002A   ; $11A5A8 ORI.B  #$0018,$002A(A1)
        BTST    D0,(A7)                         ; $11A5AE
        DC.W    $0014,$001C         ; $11A5B0 ORI.B  #$001C,(A4)
        DC.W    $0005,$0200         ; $11A5B4 ORI.B  #$0200,D5
        DC.W    $0004,$001D         ; $11A5B8 ORI.B  #$001D,D4
        DC.W    $000D,$0017         ; $11A5BC ORI.B  #$0017,A5
        DC.W    $0011,$0010         ; $11A5C0 ORI.B  #$0010,(A1)
        DC.W    $0008,$0000         ; $11A5C4 ORI.B  #$0000,A0
        BTST    D0,(A7)                         ; $11A5C8
        DC.W    $0019,$0003         ; $11A5CA ORI.B  #$0003,(A1)+
        DC.W    $001A,$0017         ; $11A5CE ORI.B  #$0017,(A2)+
        DC.W    $001A,$5200         ; $11A5D2 ORI.B  #$5200,(A2)+
        ORI.W  #$6200,A6                        ; $11A5D6
        DC.W    $0004,$001D         ; $11A5DA ORI.B  #$001D,D4
        DC.W    $0011,$0F17         ; $11A5DE ORI.B  #$0F17,(A1)
        DC.W    $0020,$012A         ; $11A5E2 ORI.B  #$012A,-(A0)
        DC.W    $002B,$002C,$002A   ; $11A5E6 ORI.B  #$002C,$002A(A3)
        BTST    D0,(A7)                         ; $11A5EC
        DC.W    $000E,$0019         ; $11A5EE ORI.B  #$0019,A6
        DC.W    $0011,$0217         ; $11A5F2 ORI.B  #$0217,(A1)
        DC.W    $002B,$002D,$002E   ; $11A5F6 ORI.B  #$002D,$002E(A3)
        DC.W    $002F,$0030,$0031   ; $11A5FC ORI.B  #$0030,$0031(A7)
        DC.W    $0032,$0033,$0034   ; $11A602 ORI.B  #$0033,$34(A2,D0.W)
        DC.W    $0035,$0036,$0237   ; $11A608 ORI.B  #$0036,$37(A5,D0.W)
        DC.W    $0238,$0139,$013A   ; $11A60E ANDI.B  #$0139,$013A.W
        BTST    D1,$3C(PC,D0.W)                 ; $11A614
        DC.W    $003D,$0617         ; $11A618 ORI.B  #$0617,<EA:3D>
        DC.W    $0022,$003E         ; $11A61C ORI.B  #$003E,-(A2)
        DC.W    $003F,$0540         ; $11A620 ORI.B  #$0540,<EA:3F>
        SUBI.W  #$0042,D1                       ; $11A624
        DC.W    $0439,$0243,$0044,$0045; $11A628 SUBI.B  #$0243,$00440045
        DC.W    $0036,$0035,$0031   ; $11A630 ORI.B  #$0035,$31(A6,D0.W)
        BTST    D0,(A7)                         ; $11A636
        DC.W    $0015,$0003         ; $11A638 ORI.B  #$0003,(A5)
        BTST    D1,D0                           ; $11A63C
        DC.W    $0001,$0009         ; $11A63E ORI.B  #$0009,D1
        DC.W    $0013,$0218         ; $11A642 ORI.B  #$0218,(A3)
        ORI.W  #$0047,D6                        ; $11A646
        ORI.W  #$0049,A0                        ; $11A64A
        ORI.W  #$002F,A2                        ; $11A64E
        ORI.W  #$002A,D6                        ; $11A652
        BTST    D0,(A7)                         ; $11A656
        DC.W    $001A,$0007         ; $11A658 ORI.B  #$0007,(A2)+
        BTST    D1,D0                           ; $11A65C
        DC.W    $0001,$0017         ; $11A65E ORI.B  #$0017,D1
        DC.W    $0019,$0200         ; $11A662 ORI.B  #$0200,(A1)+
        DC.W    $0017,$0015         ; $11A666 ORI.B  #$0015,(A7)
        DC.W    $0017,$001B         ; $11A66A ORI.B  #$001B,(A7)
        DC.W    $0015,$0017         ; $11A66E ORI.B  #$0017,(A5)
        DC.W    $0013,$5200         ; $11A672 ORI.B  #$5200,(A3)
        ORI.W  #$6000,(A0)+                     ; $11A676
        DC.W    $0003,$0008         ; $11A67A ORI.B  #$0008,D3
        DC.W    $0011,$0517         ; $11A67E ORI.B  #$0517,(A1)
        BTST    D0,-(A0)                        ; $11A682
        DC.W    $002B,$0022,$0023   ; $11A684 ORI.B  #$0022,$0023(A3)
        ORI.W  #$014C,A3                        ; $11A68A
        ORI.W  #$004E,A5                        ; $11A68E
        ORI.W  #$002F,A0                        ; $11A692
        ORI.W  #$0049,A2                        ; $11A696
        DC.W    $0034,$004F,$0050   ; $11A69A ORI.B  #$004F,$50(A4,D0.W)
        ORI.W  #$002A,A1                        ; $11A6A0
        DC.W    $0017,$0011         ; $11A6A4 ORI.B  #$0011,(A7)
        DC.W    $000F,$0117         ; $11A6A8 ORI.B  #$0117,A7
        DC.W    $002A,$004D,$0033   ; $11A6AC ORI.B  #$004D,$0033(A2)
        ORI.W  #$0052,(A1)                      ; $11A6B2
        ANDI.W  #$0254,(A3)                     ; $11A6B6
        SUBI.W  #$0456,(A5)                     ; $11A6BA
        ANDI.W  #$0158,(A7)                     ; $11A6BE
        ORI.W  #$005A,(A1)+                     ; $11A6C2
        DC.W    $003D,$0417         ; $11A6C6 ORI.B  #$0417,<EA:3D>
        DC.W    $0021,$005B         ; $11A6CA ORI.B  #$005B,-(A1)
        ORI.W  #$005D,(A4)+                     ; $11A6CE
        ORI.W  #$0759,(A6)+                     ; $11A6D2
        BCHG    D0,(A0)+                        ; $11A6D6
        ANDI.W  #$0356,(A7)                     ; $11A6D8
        BCHG    D2,(A5)                         ; $11A6DC
        ORI.W  #$0050,(A7)+                     ; $11A6DE
        DC.W    $002A,$0017,$0015   ; $11A6E2 ORI.B  #$0017,$0015(A2)
        DC.W    $0003,$0200         ; $11A6E8 ORI.B  #$0200,D3
        DC.W    $0001,$0008         ; $11A6EC ORI.B  #$0008,D1
        DC.W    $001A,$0117         ; $11A6F0 ORI.B  #$0117,(A2)+
        DC.W    $0018,$0060         ; $11A6F4 ORI.B  #$0060,(A0)+
        ORI.W  #$0061,(A0)                      ; $11A6F8
        ORI.W  #$0063,-(A2)                     ; $11A6FC
        ORI.W  #$0053,-(A4)                     ; $11A700
        DC.W    $0034,$004A,$0047   ; $11A704 ORI.B  #$004A,$47(A4,D0.W)
        BTST    D0,(A7)                         ; $11A70A
        DC.W    $001A,$0019         ; $11A70C ORI.B  #$0019,(A2)+
        DC.W    $0001,$0200         ; $11A710 ORI.B  #$0200,D1
        DC.W    $0017,$0007         ; $11A714 ORI.B  #$0007,(A7)
        DC.W    $0200,$0017         ; $11A718 ANDI.B  #$0017,D0
        DC.W    $001D,$000D         ; $11A71C ORI.B  #$000D,(A5)+
        DC.W    $0016,$0007         ; $11A720 ORI.B  #$0007,(A6)
        DC.W    $0017,$0013         ; $11A724 ORI.B  #$0013,(A7)
        ADDQ.B  #1,D0                           ; $11A728
        ORI.W  #$5F00,A6                        ; $11A72A
        DC.W    $0006,$000C         ; $11A72E ORI.B  #$000C,D6
        SUBI.B  #$0020,(A7)                     ; $11A732
        ORI.W  #$0038,-(A5)                     ; $11A736
        ANDI.W  #$0067,-(A6)                    ; $11A73A
        ORI.W  #$0069,$006A(A0)                 ; $11A73E
        BCHG    D0,(A1)                         ; $11A744
        ORI.W  #$0253,$015F(A3)                 ; $11A746
        ORI.W  #$006D,$0034(A4)                 ; $11A74C
        DC.W    $002A,$0017,$0118   ; $11A752 ORI.B  #$0017,$0118(A2)
        DC.W    $0017,$006E         ; $11A758 ORI.B  #$006E,(A7)
        ORI.W  #$006A,$0053(A7)                 ; $11A75C
        BCHG    D1,$5F(A0,D0.W)                 ; $11A762
        BCHG    D2,(A5)                         ; $11A766
        SUBI.W  #$0257,(A6)                     ; $11A768
        BCHG    D0,(A0)+                        ; $11A76C
        ORI.W  #$005A,(A1)+                     ; $11A76E
        DC.W    $003D,$0317         ; $11A772 ORI.B  #$0317,<EA:3D>
        DC.W    $0020,$0071         ; $11A776 ORI.B  #$0071,-(A0)
        ORI.W  #$005E,(A5)+                     ; $11A77A
        BCHG    D4,(A1)+                        ; $11A77E
        BCHG    D0,(A0)+                        ; $11A780
        ANDI.W  #$0356,(A7)                     ; $11A782
        BCHG    D2,(A5)                         ; $11A786
        ORI.W  #$0050,(A7)+                     ; $11A788
        DC.W    $002A,$0017,$0015   ; $11A78C ORI.B  #$0017,$0015(A2)
        DC.W    $0003,$0200         ; $11A792 ORI.B  #$0200,D3
        DC.W    $0003,$000F         ; $11A796 ORI.B  #$000F,D3
        BTST    D0,(A7)                         ; $11A79A
        ORI.W  #$004A,$62(A2,D0.W)              ; $11A79C
        ORI.W  #$0473,-(A3)                     ; $11A7A2
        BCHG    D0,-(A3)                        ; $11A7A6
        ORI.W  #$0046,$17(A4,D0.W)              ; $11A7A8
        DC.W    $0010,$0004         ; $11A7AE ORI.B  #$0004,(A0)
        DC.W    $0200,$0017         ; $11A7B2 ANDI.B  #$0017,D0
        DC.W    $0007,$0200         ; $11A7B6 ORI.B  #$0200,D7
        DC.W    $0017,$000B         ; $11A7BA ORI.B  #$000B,(A7)
        DC.W    $0001,$0007         ; $11A7BE ORI.B  #$0007,D1
        DC.W    $0000,$0017         ; $11A7C2 ORI.B  #$0017,D0
        DC.W    $0013,$5200         ; $11A7C6 ORI.B  #$5200,(A3)
        ORI.W  #$5E00,D5                        ; $11A7CA
        DC.W    $0005,$0011         ; $11A7CE ORI.B  #$0011,D5
        DC.W    $0217,$0022         ; $11A7D2 ANDI.B  #$0022,(A7)
        DC.W    $0028,$0075,$0039   ; $11A7D6 ORI.B  #$0075,$0039(A0)
        ORI.W  #$0156,$55(A6,D0.W)              ; $11A7DC
        ANDI.W  #$0370,(A7)+                    ; $11A7E2
        SUBI.W  #$004F,$2A(A3,D0.W)             ; $11A7E6
        DC.W    $0217,$0046         ; $11A7EC ANDI.B  #$0046,(A7)
        ORI.W  #$0053,(A0)                      ; $11A7F0
        ORI.W  #$0570,(A7)+                     ; $11A7F4
        BCHG    D0,(A7)+                        ; $11A7F8
        BCHG    D2,(A5)                         ; $11A7FA
        SUBI.W  #$0257,(A6)                     ; $11A7FC
        BCHG    D0,(A0)+                        ; $11A800
        ORI.W  #$005A,(A1)+                     ; $11A802
        DC.W    $003D,$0217         ; $11A806 ORI.B  #$0217,<EA:3D>
        DC.W    $0020,$0071         ; $11A80A ORI.B  #$0071,-(A0)
        ORI.W  #$0B59,(A6)+                     ; $11A80E
        BCHG    D0,(A0)+                        ; $11A812
        ANDI.W  #$0356,(A7)                     ; $11A814
        BCHG    D2,(A5)                         ; $11A818
        ORI.W  #$0050,(A7)+                     ; $11A81A
        DC.W    $002A,$0017,$0015   ; $11A81E ORI.B  #$0017,$0015(A2)
        DC.W    $0003,$0100         ; $11A824 ORI.B  #$0100,D3
        DC.W    $0001,$0008         ; $11A828 ORI.B  #$0008,D1
        DC.W    $0013,$0017         ; $11A82C ORI.B  #$0017,(A3)
        DC.W    $0029,$006F,$006B   ; $11A830 ORI.B  #$006F,$006B(A1)
        BCHG    #12,$35(A3,D0.W)                ; $11A836
        DC.W    $002B,$0017,$0018   ; $11A83C ORI.B  #$0017,$0018(A3)
        DC.W    $0009,$0200         ; $11A842 ORI.B  #$0200,A1
        DC.W    $0017,$0007         ; $11A846 ORI.B  #$0007,(A7)
        DC.W    $0200,$0017         ; $11A84A ANDI.B  #$0017,D0
        DC.W    $000B,$0200         ; $11A84E ORI.B  #$0200,A3
        DC.W    $0017,$0013         ; $11A852 ORI.B  #$0013,(A7)
        ADDQ.B  #1,D0                           ; $11A856
        ORI.W  #$5D00,D0                        ; $11A858
        DC.W    $0004,$001B         ; $11A85C ORI.B  #$001B,D4
        DC.W    $0217,$0077         ; $11A860 ANDI.B  #$0077,(A7)
        DC.W    $003B,$0076,$0078   ; $11A864 ORI.B  #$0076,$78(PC,D0.W)
        BCHG    D1,(A6)                         ; $11A86A
        SUBI.W  #$015F,(A5)                     ; $11A86C
        BCHG    D1,$73(A0,D0.W)                 ; $11A870
        ORI.W  #$002A,A7                        ; $11A874
        BTST    D0,(A7)                         ; $11A878
        DC.W    $002A,$0034,$005F   ; $11A87A ORI.B  #$0034,$005F(A2)
        BCHG    D0,$70(A3,D0.W)                 ; $11A880
        BCHG    D0,(A7)+                        ; $11A884
        BCHG    D2,(A5)                         ; $11A886
        SUBI.W  #$0257,(A6)                     ; $11A888
        BCHG    D0,(A0)+                        ; $11A88C
        ORI.W  #$005A,(A1)+                     ; $11A88E
        DC.W    $003D,$0217         ; $11A892 ORI.B  #$0217,<EA:3D>
        ORI.W  #$0D59,$58(A1,D0.W)              ; $11A896
        BCHG    D0,(A7)                         ; $11A89C
        SUBI.W  #$0455,(A6)                     ; $11A89E
        ORI.W  #$0050,(A7)+                     ; $11A8A2
        DC.W    $002A,$0017,$0015   ; $11A8A6 ORI.B  #$0017,$0015(A2)
        DC.W    $0004,$0100         ; $11A8AC ORI.B  #$0100,D4
        DC.W    $0001,$001D         ; $11A8B0 ORI.B  #$001D,D1
        DC.W    $0016,$0017         ; $11A8B4 ORI.B  #$0017,(A6)
        DC.W    $0079,$007A,$0A73,$005F; $11A8B8 ORI.W  #$007A,$0A73005F
        DC.W    $0031,$0117,$0011   ; $11A8C0 ORI.B  #$0117,$11(A1,D0.W)
        DC.W    $0003,$0100         ; $11A8C6 ORI.B  #$0100,D3
        DC.W    $001E,$0004         ; $11A8CA ORI.B  #$0004,(A6)+
        DC.W    $0200,$001C         ; $11A8CE ANDI.B  #$001C,D0
        DC.W    $0007,$0200         ; $11A8D2 ORI.B  #$0200,D7
        DC.W    $0010,$000C         ; $11A8D6 ORI.B  #$000C,(A0)
        ADDQ.B  #1,D0                           ; $11A8DA
        DC.W    $003C,$5C00,$0005   ; $11A8DC ORI.B  #$5C00,#$0005
        DC.W    $001B,$0217         ; $11A8E2 ORI.B  #$0217,(A3)+
        ORI.W  #$007C,$58(PC,D0.W)              ; $11A8E6
        BCHG    D0,(A7)                         ; $11A8EC
        BCHG    D1,(A6)                         ; $11A8EE
        SUBI.W  #$015F,(A5)                     ; $11A8F0
        BCHG    D1,$73(A0,D0.W)                 ; $11A8F4
        ORI.W  #$002A,A7                        ; $11A8F8
        BTST    D0,(A7)                         ; $11A8FC
        ORI.W  #$0061,D7                        ; $11A8FE
        ANDI.W  #$0570,$5F(A3,D0.W)             ; $11A902
        BCHG    D2,(A5)                         ; $11A908
        BCHG    D1,(A6)                         ; $11A90A
        ANDI.W  #$0258,(A7)                     ; $11A90C
        ORI.W  #$003D,(A2)+                     ; $11A910
        BTST    D0,(A7)                         ; $11A914
        DC.W    $0021,$007D         ; $11A916 ORI.B  #$007D,-(A1)
        BCHG    D2,(A1)+                        ; $11A91A
        ANDI.W  #$027E,(A6)+                    ; $11A91C
        ANDI.W  #$0158,(A1)+                    ; $11A920
        BCHG    D0,(A7)                         ; $11A924
        SUBI.W  #$0455,(A6)                     ; $11A926
        ORI.W  #$0045,(A7)+                     ; $11A92A
        DC.W    $002A,$0017,$0015   ; $11A92E ORI.B  #$0017,$0015(A2)
        DC.W    $0004,$0100         ; $11A934 ORI.B  #$0100,D4
        DC.W    $0006,$0013         ; $11A938 ORI.B  #$0013,D6
        BTST    D0,(A7)                         ; $11A93C
        ORI.W  #$0063,A2                        ; $11A93E
        BCHG    D1,$63(A3,D0.W)                 ; $11A942
        BCHG    D0,$0063(A3)                    ; $11A946
        BCHG    D1,$52(A3,D0.W)                 ; $11A94A
        ORI.W  #$0017,$0016(A6)                 ; $11A94E
        DC.W    $0019,$6000         ; $11A954 ORI.B  #$6000,(A1)+
        ORI.W  #$5B00,(A0)                      ; $11A958
        DC.W    $0002,$000B         ; $11A95C ORI.B  #$000B,D2
        DC.W    $0217,$007B         ; $11A960 ANDI.B  #$007B,(A7)
        DC.W    $007E,$0158         ; $11A964 ORI.W  #$0158,<EA:3E>
        BCHG    D0,(A7)                         ; $11A968
        BCHG    D1,(A6)                         ; $11A96A
        SUBI.W  #$015F,(A5)                     ; $11A96C
        BCHG    D1,$73(A0,D0.W)                 ; $11A970
        ORI.W  #$002B,(A0)                      ; $11A974
        DC.W    $0017,$002B         ; $11A978 ORI.B  #$002B,(A7)
        DC.W    $0034,$005F,$0273   ; $11A97C ORI.B  #$005F,$73(A4,D0.W)
        ORI.W  #$005F,$53(A0,D0.W)              ; $11A982
        ANDI.W  #$006A,(A1)                     ; $11A988
        ORI.W  #$007F,$0267(A1)                 ; $11A98C
        ORI.W  #$0139,-(A6)                     ; $11A992
        BTST    D0,$0080.W                      ; $11A996
        BCLR    D0,D1                           ; $11A99A
        ORI.L  #$00830084,D2                    ; $11A99C
        ORI.L  #$003E0117,D5                    ; $11A9A2
        ORI.L  #$005E0459,D6                    ; $11A9A8
        ORI.W  #$007B,(A5)+                     ; $11A9AE
        ANDI.L  #$01880075,D7                   ; $11A9B2
        ORI.L  #$01840083,D5                    ; $11A9B8
        ORI.L  #$01810338,D2                    ; $11A9BE
        BCHG    D0,-(A6)                        ; $11A9C4
        BCHG    D0,-(A7)                        ; $11A9C6
        ORI.W  #$0069,$0037(A0)                 ; $11A9C8
        DC.W    $002A,$0017,$0015   ; $11A9CE ORI.B  #$0017,$0015(A2)
        DC.W    $0004,$0100         ; $11A9D4 ORI.B  #$0100,D4
        DC.W    $0019,$0015         ; $11A9D8 ORI.B  #$0015,(A1)+
        DC.W    $0017,$006E         ; $11A9DC ORI.B  #$006E,(A7)
        ORI.W  #$0373,$006D(PC)                 ; $11A9E0
        ORI.W  #$0049,-(A2)                     ; $11A9E6
        DC.W    $0033,$0062,$0373   ; $11A9EA ORI.B  #$0062,$73(A3,D0.W)
        ORI.W  #$0031,(A3)                      ; $11A9F0
        BTST    D0,(A7)                         ; $11A9F4
        DC.W    $0010,$0003         ; $11A9F6 ORI.B  #$0003,(A0)
        SUBQ.B  #7,D0                           ; $11A9FA
        ORI.W  #$5B00,(A3)                      ; $11A9FC
        DC.W    $0019,$0015         ; $11AA00 ORI.B  #$0015,(A1)+
        BTST    D0,(A7)                         ; $11AA04
        ORI.W  #$007E,(A3)+                     ; $11AA06
        ANDI.W  #$0157,(A0)+                    ; $11AA0A
        BCHG    D0,(A6)                         ; $11AA0E
        DC.W    $0389               ; $11AA10 BCLR    D1,A1
        SUBI.W  #$016A,(A1)                     ; $11AA12
        ANDI.W  #$0062,$018A(PC)                ; $11AA16
        ORI.L  #$0050002B,A3                    ; $11AA1C
        DC.W    $0017,$004D         ; $11AA22 ORI.B  #$004D,(A7)
        ORI.W  #$0373,$005F(A3)                 ; $11AA26
        ORI.L  #$01330031,A4                    ; $11AA2C
        ORI.W  #$0030,$008D(A7)                 ; $11AA32
        DC.W    $002E,$008E,$008F   ; $11AA38 ORI.B  #$008E,$008F(A6)
        ORI.L  #$00910192,(A0)                  ; $11AA3E
        DC.W    $0027,$0128         ; $11AA44 ORI.B  #$0128,-(A7)
        DC.W    $0227,$0026         ; $11AA48 ANDI.B  #$0026,-(A7)
        BCLR    D0,(A2)                         ; $11AA4C
        BCLR    D0,(A1)                         ; $11AA4E
        DC.W    $0022,$0017         ; $11AA50 ORI.B  #$0017,-(A2)
        DC.W    $0022,$007D         ; $11AA54 ORI.B  #$007D,-(A2)
        DC.W    $007E,$0359         ; $11AA58 ORI.W  #$0359,<EA:3E>
        ORI.W  #$007B,(A2)+                     ; $11AA5C
        DC.W    $0025,$0026         ; $11AA60 ORI.B  #$0026,-(A5)
        ANDI.L  #$05910392,(A3)                 ; $11AA64
        SUBI.B  #$0094,-(A7)                    ; $11AA6A
        ORI.L  #$0090008F,(A1)                  ; $11AA6E
        ORI.L  #$01170015,(A0)                  ; $11AA74
        DC.W    $0004,$0000         ; $11AA7A ORI.B  #$0000,D4
        DC.W    $0002,$000C         ; $11AA7E ORI.B  #$000C,D2
        DC.W    $0018,$002A         ; $11AA82 ORI.B  #$002A,(A0)+
        ORI.W  #$0095,$0373(A7)                 ; $11AA86
        ORI.L  #$024D0048,(A6)                  ; $11AA8C
        ORI.W  #$0197,-(A4)                     ; $11AA92
        BCHG    D0,$7A(A3,D0.W)                 ; $11AA96
        DC.W    $0022,$0017         ; $11AA9A ORI.B  #$0017,-(A2)
        DC.W    $0015,$001F         ; $11AA9E ORI.B  #$001F,(A5)
        DC.W    $0001,$5E00         ; $11AAA2 ORI.B  #$5E00,D1
        ORI.W  #$5A00,(A2)                      ; $11AAA6
        DC.W    $0002,$001C         ; $11AAAA ORI.B  #$001C,D2
        BTST    D0,(A7)                         ; $11AAAE
        DC.W    $0022,$003C         ; $11AAB0 ORI.B  #$003C,-(A2)
        DC.W    $007E,$0059         ; $11AAB4 ORI.W  #$0059,<EA:3E>
        BCHG    D0,(A0)+                        ; $11AAB8
        BCHG    D0,(A7)                         ; $11AABA
        ORI.L  #$003A0299,(A0)+                 ; $11AABC
        ORI.L  #$038D012E,A6                    ; $11AAC2
        ORI.W  #$019A,A6                        ; $11AAC8
        ANDI.W  #$009A,A5                       ; $11AACC
        ORI.W  #$004D,A6                        ; $11AAD0
        BTST    D0,(A7)                         ; $11AAD4
        ORI.W  #$0064,A5                        ; $11AAD6
        BCHG    D1,$6A(A3,D0.W)                 ; $11AADA
        ORI.L  #$006F0045,A5                    ; $11AADE
        ORI.W  #$0043,D4                        ; $11AAE4
        ORI.W  #$009B,-(A6)                     ; $11AAE8
        ORI.L  #$00680169,(A4)+                 ; $11AAEC
        BCHG    D1,(A1)                         ; $11AAF2
        ORI.L  #$039E039F,(A5)+                 ; $11AAF4
        ORI.L  #$005B0017,-(A0)                 ; $11AAFA
        ORI.L  #$007E0358,-(A1)                 ; $11AB00
        DC.W    $007E,$0071         ; $11AB06 ORI.W  #$0071,<EA:3E>
        DC.W    $0024,$0093         ; $11AB0A ORI.B  #$0093,-(A4)
        ORI.L  #$045A049F,-(A2)                 ; $11AB0E
        BCLR    D1,(A6)+                        ; $11AB14
        ORI.L  #$05510069,A1                    ; $11AB16
        DC.W    $0036,$0020,$0017   ; $11AB1C ORI.B  #$0020,$17(A6,D0.W)
        DC.W    $0015,$0004         ; $11AB22 ORI.B  #$0004,(A5)
        DC.W    $0000,$0003         ; $11AB26 ORI.B  #$0003,D0
        DC.W    $0013,$0017         ; $11AB2A ORI.B  #$0017,(A3)
        ORI.W  #$0062,D6                        ; $11AB2E
        BCLR    D1,(A7)                         ; $11AB32
        ORI.L  #$00500033,-(A3)                 ; $11AB34
        BCHG    D0,-(A4)                        ; $11AB3A
        DC.W    $0033,$00A4,$0397   ; $11AB3C ORI.B  #$00A4,-$69(A3,D0.W)
        ORI.W  #$006F,$0117(A4)                 ; $11AB42
        DC.W    $000C,$0001         ; $11AB48 ORI.B  #$0001,A4
        ADDQ.B  #7,D0                           ; $11AB4C
        ORI.W  #$5A00,(A2)                      ; $11AB4E
        DC.W    $0019,$0015         ; $11AB52 ORI.B  #$0015,(A1)+
        BTST    D0,(A7)                         ; $11AB56
        ORI.L  #$005D0159,-(A1)                 ; $11AB58
        BCHG    D0,(A0)+                        ; $11AB5E
        ORI.W  #$003B,$00A5.W                   ; $11AB60
        ORI.L  #$006500A6,(A1)                  ; $11AB66
        ORI.L  #$00A80137,-(A7)                 ; $11AB6C
        BCHG    D0,D4                           ; $11AB72
        ORI.W  #$00A4,D3                        ; $11AB74
        ORI.L  #$008C008B,(A3)+                 ; $11AB78
        ANDI.L  #$00950063,A2                   ; $11AB7E
        ORI.W  #$002B,D4                        ; $11AB84
        DC.W    $002A,$004F,$00A9   ; $11AB88 ORI.B  #$004F,$00A9(A2)
        ANDI.L  #$0063002F,(A7)                 ; $11AB8E
        ORI.L  #$0069056C,A5                    ; $11AB94
        SUBI.W  #$0170,(A7)+                    ; $11AB9A
        DC.W    $04AA,$0356,$0058,$0086; $11AB9E SUBI.L  #$03560058,$0086(A2)
        DC.W    $0017,$0087         ; $11ABA6 ORI.B  #$0087,(A7)
        ORI.W  #$03AB,(A0)+                     ; $11ABAA
        DC.W    $007E,$00AC         ; $11ABAE ORI.W  #$00AC,<EA:3E>
        ORI.L  #$00A206AD,(A3)                  ; $11ABB2
        BCHG    D0,(A6)                         ; $11ABB8
        DC.W    $02AE,$04AA,$0470,$0073; $11ABBA ANDI.L  #$04AA0470,$0073(A6)
        ORI.W  #$002A,$0017(A0)                 ; $11ABC2
        DC.W    $0015,$0004         ; $11ABC8 ORI.B  #$0004,(A5)
        DC.W    $0000,$0006         ; $11ABCC ORI.B  #$0006,D0
        DC.W    $0014,$0017         ; $11ABD0 ORI.B  #$0017,(A4)
        ORI.W  #$0064,$03AF(A6)                 ; $11ABD4
        ORI.W  #$00B0,-(A4)                     ; $11ABDA
        ORI.W  #$01B1,-(A1)                     ; $11ABDE
        DC.W    $00B2,$004D,$00B3,$02AF; $11ABE2 ORI.L  #$004D00B3,-$51(A2,D0.W)
        DC.W    $00B4,$0074,$0117,$001C; $11ABEA ORI.L  #$00740117,$1C(A4,D0.W)
        DC.W    $0001,$5E00         ; $11ABF2 ORI.B  #$5E00,D1
        ORI.W  #$5900,A1                        ; $11ABF6
        DC.W    $0003,$0008         ; $11ABFA ORI.B  #$0008,D3
        DC.W    $0217,$003C         ; $11ABFE ANDI.B  #$003C,(A7)
        ORI.W  #$0158,$01B5.W                   ; $11AC02
        ORI.L  #$01240080,D5                    ; $11AC08
        ORI.L  #$0155025F,A1                    ; $11AC0E
        ORI.W  #$05B6,-$69(A0,D0.W)             ; $11AC14
        ORI.L  #$002B0046,A3                    ; $11AC1A
        ORI.W  #$0397,$0063(A3)                 ; $11AC20
        ORI.W  #$0069,A5                        ; $11AC26
        ORI.W  #$05B7,$70(A3,D0.W)              ; $11AC2A
        DC.W    $04AA,$02AE,$0056,$0057; $11AC30 SUBI.L  #$02AE0056,$0057(A2)
        ORI.L  #$00170087,D7                    ; $11AC38
        ORI.W  #$03AD,(A0)+                     ; $11AC3E
        DC.W    $007E,$00AC         ; $11AC42 ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,-$53(A1,D0.W)             ; $11AC46
        BCHG    D0,(A6)                         ; $11AC4C
        DC.W    $02AE,$04AA,$0470,$0073; $11AC4E ANDI.L  #$04AA0470,$0073(A6)
        ORI.W  #$002A,$0017(A1)                 ; $11AC56
        DC.W    $0015,$0004         ; $11AC5C ORI.B  #$0004,(A5)
        DC.W    $0002,$001C         ; $11AC60 ORI.B  #$001C,D2
        BTST    D0,(A7)                         ; $11AC64
        ORI.W  #$0097,A1                        ; $11AC66
        DC.W    $02AF,$00B1,$0050,$00B0; $11AC6A ANDI.L  #$00B10050,$00B0(A7)
        ORI.W  #$01AF,-(A3)                     ; $11AC72
        ORI.W  #$00B0,-(A3)                     ; $11AC76
        ORI.W  #$02AF,-(A3)                     ; $11AC7A
        DC.W    $00B4,$008C,$002B,$0017; $11AC7E ORI.L  #$008C002B,$17(A4,D0.W)
        DC.W    $0016,$0019         ; $11AC86 ORI.B  #$0019,(A6)
        ADDQ.B  #7,D0                           ; $11AC8A
        ORI.W  #$5900,A2                        ; $11AC8C
        DC.W    $0003,$0011         ; $11AC90 ORI.B  #$0011,D3
        BTST    D0,(A7)                         ; $11AC94
        DC.W    $0024,$00A0         ; $11AC96 ORI.B  #$00A0,-(A4)
        BCHG    D0,(A0)+                        ; $11AC9A
        BCLR    D0,$76(A5,D0.W)                 ; $11AC9C
        DC.W    $0023,$0086         ; $11ACA0 ORI.B  #$0086,-(A3)
        ORI.L  #$025500AA,(A0)+                 ; $11ACA4
        BCHG    D1,-$4A(A0,D0.W)                ; $11ACAA
        DC.W    $04B7,$04AF,$008A,$002B; $11ACAE SUBI.L  #$04AF008A,$2B(A7,D0.W)
        ORI.W  #$0063,D6                        ; $11ACB6
        BCLR    D1,$0063(A7)                    ; $11ACBA
        ORI.W  #$006C,A5                        ; $11ACBE
        DC.W    $06B7,$0073,$0570,$04AA; $11ACC2 ADDI.L  #$00730570,-$56(A7,D0.W)
        DC.W    $02AE,$0056,$0057,$0087; $11ACCA ANDI.L  #$00560057,$0087(A6)
        DC.W    $0017,$0087         ; $11ACD2 ORI.B  #$0087,(A7)
        ORI.W  #$03AD,(A0)+                     ; $11ACD6
        DC.W    $007E,$00AC         ; $11ACDA ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11ACDE
        DC.W    $06AD,$0156,$02AE,$04AA; $11ACE2 ADDI.L  #$015602AE,$04AA(A5)
        SUBI.W  #$0073,$69(A0,D0.W)             ; $11ACEA
        DC.W    $002A,$0017,$0015   ; $11ACF0 ORI.B  #$0017,$0015(A2)
        DC.W    $0004,$0003         ; $11ACF6 ORI.B  #$0003,D4
        DC.W    $001B,$0017         ; $11ACFA ORI.B  #$0017,(A3)+
        DC.W    $002A,$00B2,$03AF   ; $11ACFE ORI.B  #$00B2,$03AF(A2)
        ORI.L  #$003300A4,(A7)                  ; $11AD04
        DC.W    $00B1,$01AF,$00A3,$00B0; $11AD0A ORI.L  #$01AF00A3,-$50(A1,D0.W)
        ORI.W  #$0097,D5                        ; $11AD12
        BCLR    D0,$00B4(A7)                    ; $11AD16
        ORI.W  #$004E,$0117(A4)                 ; $11AD1A
        DC.W    $001F,$5E00         ; $11AD20 ORI.B  #$5E00,(A7)+
        ORI.W  #$5900,D7                        ; $11AD24
        DC.W    $0005,$0217         ; $11AD28 ORI.B  #$0217,D5
        DC.W    $00B8,$0078,$01AD,$0056; $11AD2C ORI.L  #$007801AD,$0056.W
        ORI.W  #$0087,(A7)                      ; $11AD34
        ORI.L  #$00B904AA,(A2)                  ; $11AD38
        BCHG    D1,$73(A0,D0.W)                 ; $11AD3E
        DC.W    $04B7,$04AF,$0062,$002B; $11AD42 SUBI.L  #$04AF0062,$2B(A7,D0.W)
        ORI.W  #$0063,D6                        ; $11AD4A
        BCLR    D1,$0063(A7)                    ; $11AD4E
        ORI.W  #$0063,A5                        ; $11AD52
        DC.W    $06B7,$0073,$0570,$04AA; $11AD56 ADDI.L  #$00730570,-$56(A7,D0.W)
        DC.W    $02AE,$0056,$0057,$0087; $11AD5E ANDI.L  #$00560057,$0087(A6)
        DC.W    $0017,$0087         ; $11AD66 ORI.B  #$0087,(A7)
        ORI.W  #$03AD,(A0)+                     ; $11AD6A
        DC.W    $007E,$00AC         ; $11AD6E ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11AD72
        DC.W    $06AD,$0156,$02AE,$04AA; $11AD76 ADDI.L  #$015602AE,$04AA(A5)
        SUBI.W  #$0073,$69(A0,D0.W)             ; $11AD7E
        DC.W    $002A,$0017,$0015   ; $11AD84 ORI.B  #$0017,$0015(A2)
        DC.W    $0004,$0019         ; $11AD8A ORI.B  #$0019,D4
        DC.W    $0012,$0017         ; $11AD8E ORI.B  #$0017,(A2)
        ORI.W  #$008A,D7                        ; $11AD92
        BCLR    D1,$0063(A7)                    ; $11AD96
        ORI.W  #$0063,A1                        ; $11AD9A
        BCLR    D1,$00A4(A7)                    ; $11AD9E
        ORI.W  #$006C,$01AF(A7)                 ; $11ADA2
        DC.W    $00B4,$0073,$002F,$0117; $11ADA8 ORI.L  #$0073002F,$17(A4,D0.W)
        DC.W    $000E,$0002         ; $11ADB0 ORI.B  #$0002,A6
        SUBQ.B  #6,D0                           ; $11ADB4
        ORI.W  #$5900,D7                        ; $11ADB6
        DC.W    $0005,$0217         ; $11ADBA ORI.B  #$0217,D5
        ORI.W  #$03AD,(A2)+                     ; $11ADBE
        ORI.W  #$0026,(A2)+                     ; $11ADC2
        ORI.L  #$005600AE,D5                    ; $11ADC6
        BCLR    D1,$0370(A2)                    ; $11ADCC
        ORI.W  #$04B7,-$51(A3,D0.W)             ; $11ADD0
        ORI.W  #$002B,-(A2)                     ; $11ADD6
        ORI.W  #$0063,D6                        ; $11ADDA
        BCLR    D1,$0063(A7)                    ; $11ADDE
        ORI.W  #$0063,A5                        ; $11ADE2
        DC.W    $06B7,$0073,$0570,$04AA; $11ADE6 ADDI.L  #$00730570,-$56(A7,D0.W)
        DC.W    $02AE,$0056,$0057,$0087; $11ADEE ANDI.L  #$00560057,$0087(A6)
        DC.W    $0017,$0087         ; $11ADF6 ORI.B  #$0087,(A7)
        ORI.W  #$03AD,(A0)+                     ; $11ADFA
        DC.W    $007E,$00AC         ; $11ADFE ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11AE02
        DC.W    $06AD,$0156,$03AE,$03AA; $11AE06 ADDI.L  #$015603AE,$03AA(A5)
        SUBI.W  #$0073,$69(A0,D0.W)             ; $11AE0E
        DC.W    $002A,$0017,$0015   ; $11AE14 ORI.B  #$0017,$0015(A2)
        DC.W    $0004,$000B         ; $11AE1A ORI.B  #$000B,D4
        DC.W    $0018,$0017         ; $11AE1E ORI.B  #$0017,(A0)+
        ORI.W  #$006C,A0                        ; $11AE22
        BCLR    D1,$008B(A7)                    ; $11AE26
        ORI.W  #$0063,A0                        ; $11AE2A
        BCLR    D1,$0063(A7)                    ; $11AE2E
        ORI.W  #$00A4,A5                        ; $11AE32
        BCLR    D0,$00B4(A7)                    ; $11AE36
        ORI.W  #$0068,$2B(A3,D0.W)              ; $11AE3A
        DC.W    $0017,$0016         ; $11AE40 ORI.B  #$0016,(A7)
        DC.W    $0004,$5D00         ; $11AE44 ORI.B  #$5D00,D4
        ORI.W  #$5900,A1                        ; $11AE48
        DC.W    $0005,$0217         ; $11AE4C ORI.B  #$0217,D5
        ORI.W  #$03AD,(A2)+                     ; $11AE50
        ORI.L  #$0025009F,D7                    ; $11AE54
        BCLR    D0,$03AA(A6)                    ; $11AE5A
        SUBI.W  #$0973,$68(A0,D0.W)             ; $11AE5E
        DC.W    $002B,$0046,$0063   ; $11AE64 ORI.B  #$0046,$0063(A3)
        BCLR    D1,$006C(A7)                    ; $11AE6A
        ORI.W  #$0063,A5                        ; $11AE6E
        DC.W    $04B7,$015F,$0153,$0454; $11AE72 SUBI.L  #$015F0153,$54(A7,D0.W)
        SUBI.L  #$00B9019F,A1                   ; $11AE7A
        ORI.L  #$00A0003D,(A0)+                 ; $11AE80
        DC.W    $0017,$0087         ; $11AE86 ORI.B  #$0087,(A7)
        ORI.W  #$03AD,(A0)+                     ; $11AE8A
        DC.W    $007E,$00AC         ; $11AE8E ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11AE92
        DC.W    $04AD,$005A,$01A0,$007C; $11AE96 SUBI.L  #$005A01A0,$007C(A5)
        ORI.L  #$019F00B9,(A0)+                 ; $11AE9E
        DC.W    $0389               ; $11AEA4 BCLR    D1,A1
        ORI.W  #$0354,(A1)                      ; $11AEA6
        ORI.W  #$0038,(A3)                      ; $11AEAA
        DC.W    $002A,$0017,$0015   ; $11AEAE ORI.B  #$0017,$0015(A2)
        DC.W    $0005,$000C         ; $11AEB4 ORI.B  #$000C,D5
        DC.W    $0018,$0017         ; $11AEB8 ORI.B  #$0017,(A0)+
        ORI.W  #$0097,$03AF(A7)                 ; $11AEBC
        ORI.L  #$00B205AF,-(A4)                 ; $11AEC2
        ORI.W  #$0061,-$51(A4,D0.W)             ; $11AEC8
        DC.W    $00B4,$00B7,$005F,$0022; $11AECE ORI.L  #$00B7005F,$22(A4,D0.W)
        DC.W    $0017,$0016         ; $11AED6 ORI.B  #$0016,(A7)
        DC.W    $0019,$5D00         ; $11AEDA ORI.B  #$5D00,(A1)+
        ORI.W  #$5900,A2                        ; $11AEDE
        DC.W    $0005,$0217         ; $11AEE2 ORI.B  #$0217,D5
        ORI.W  #$03AD,(A2)+                     ; $11AEE6
        ORI.L  #$007102AE,D6                    ; $11AEEA
        DC.W    $02AA,$0239,$0038,$0243; $11AEF0 ANDI.L  #$02390038,$0243(A2)
        ORI.W  #$0045,$50(A4,D0.W)              ; $11AEF8
        DC.W    $014F               ; $11AEFE BCHG    D0,A7
        BTST    D0,$2F(A4,D0.W)                 ; $11AF00
        DC.W    $002A,$0046,$0063   ; $11AF04 ORI.B  #$0046,$0063(A2)
        BCLR    D1,$006C(A7)                    ; $11AF0A
        ORI.W  #$0063,A5                        ; $11AF0E
        BCLR    D1,$5F(A7,D0.W)                 ; $11AF12
        DC.W    $00BA,$008F,$0190,$0094; $11AF16 ORI.L  #$008F0190,$0094(PC)
        ORI.L  #$07270021,(A2)                  ; $11AF1E
        BTST    D2,(A7)                         ; $11AF24
        ORI.L  #$005803AD,D7                    ; $11AF26
        DC.W    $007E,$00AC         ; $11AF2C ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11AF30
        BCLR    D1,$007E(A5)                    ; $11AF34
        ORI.W  #$0024,$27(A7,D0.W)              ; $11AF38
        DC.W    $0026,$0A27         ; $11AF3E ORI.B  #$0A27,-(A6)
        ORI.L  #$01940117,(A2)                  ; $11AF42
        DC.W    $0015,$0008         ; $11AF48 ORI.B  #$0008,(A5)
        DC.W    $001A,$0117         ; $11AF4C ORI.B  #$0117,(A2)+
        ORI.L  #$00B102AF,A4                    ; $11AF50
        ORI.L  #$006F0061,-(A3)                 ; $11AF56
        BCLR    D2,$008C(A7)                    ; $11AF5C
        DC.W    $0031,$0073,$00AF   ; $11AF60 ORI.B  #$0073,-$51(A1,D0.W)
        DC.W    $00B4,$00B7,$006C,$002E; $11AF66 ORI.L  #$00B7006C,$2E(A4,D0.W)
        BTST    D0,(A7)                         ; $11AF6E
        DC.W    $000F,$0002         ; $11AF70 ORI.B  #$0002,A7
        ADDQ.B  #6,D0                           ; $11AF74
        ORI.W  #$5900,(A0)                      ; $11AF76
        DC.W    $0005,$0217         ; $11AF7A ORI.B  #$0217,D5
        ORI.W  #$03AD,(A2)+                     ; $11AF7E
        ORI.L  #$005B0056,D6                    ; $11AF82
        BCLR    D0,$01AA(A6)                    ; $11AF88
        ORI.W  #$00BB,(A5)                      ; $11AF8C
        DC.W    $00BC,$00BB,$00BD,$00A6,$00A7; $11AF90 ORI.L  #$00BB00BD,#$00A600A7
        DC.W    $00BD,$004C,$0022   ; $11AF9A ORI.L  #$004C0022,<EA:3D>
        DC.W    $002B,$0020,$052A   ; $11AFA0 ORI.B  #$0020,$052A(A3)
        DC.W    $0017,$0046         ; $11AFA6 ORI.B  #$0046,(A7)
        ORI.W  #$03AF,-(A3)                     ; $11AFAA
        ORI.W  #$004D,$0063(A4)                 ; $11AFAE
        DC.W    $04B7,$0253,$0554,$00BE; $11AFB4 SUBI.L  #$02530554,-$42(A7,D0.W)
        DC.W    $02BF,$0098,$0091   ; $11AFBC ANDI.L  #$00980091,<EA:3F>
        BTST    D2,(A7)                         ; $11AFC2
        ORI.L  #$005803AD,D7                    ; $11AFC4
        DC.W    $007E,$00AC         ; $11AFCA ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11AFCE
        BCLR    D1,$007E(A5)                    ; $11AFD2
        ORI.W  #$007D,-$47(A7,D0.W)             ; $11AFD6
        BCHG    D1,$03BF.W                      ; $11AFDC
        DC.W    $00BE,$0454,$0053   ; $11AFE0 ORI.L  #$04540053,<EA:3E>
        DC.W    $0038,$002A,$0017   ; $11AFE6 ORI.B  #$002A,$0017.W
        DC.W    $0015,$0009         ; $11AFEC ORI.B  #$0009,(A5)
        DC.W    $0016,$0017         ; $11AFF0 ORI.B  #$0017,(A6)
        ORI.W  #$0052,D7                        ; $11AFF4
        BCLR    D1,$0063(A7)                    ; $11AFF8
        DC.W    $002F,$0064,$05AF   ; $11AFFC ORI.B  #$0064,$05AF(A7)
        ORI.W  #$002F,-(A4)                     ; $11B002
        ORI.W  #$00AF,-(A3)                     ; $11B006
        DC.W    $00B4,$01B7,$0068,$0020; $11B00A ORI.L  #$01B70068,$20(A4,D0.W)
        DC.W    $0017,$0011         ; $11B012 ORI.B  #$0011,(A7)
        DC.W    $0003,$5C00         ; $11B016 ORI.B  #$5C00,D3
        ORI.W  #$5900,A0                        ; $11B01A
        DC.W    $0005,$0217         ; $11B01E ORI.B  #$0217,D5
        ORI.W  #$03AD,(A2)+                     ; $11B022
        DC.W    $003C,$00C0,$00A0   ; $11B026 ORI.B  #$00C0,#$00A0
        BCLR    D0,$02AA(A6)                    ; $11B02C
        ANDI.W  #$0270,(A5)                     ; $11B030
        ORI.W  #$0068,(A7)+                     ; $11B034
        ORI.W  #$008D,D3                        ; $11B038
        DC.W    $0022,$0617         ; $11B03C ORI.B  #$0617,-(A2)
        ORI.W  #$0063,D6                        ; $11B040
        BCLR    D1,$006C(A7)                    ; $11B044
        ORI.W  #$0063,A5                        ; $11B048
        DC.W    $06B7,$0073,$0570,$03AA; $11B04C ADDI.L  #$00730570,-$56(A7,D0.W)
        ORI.W  #$00C1,(A6)                      ; $11B054
        BTST    D2,(A7)                         ; $11B058
        ORI.L  #$005803AD,D7                    ; $11B05A
        DC.W    $007E,$00AC         ; $11B060 ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11B064
        BCLR    D1,$007E(A5)                    ; $11B068
        ORI.W  #$003C,-$53(A7,D0.W)             ; $11B06C
        ORI.W  #$03AE,(A6)                      ; $11B072
        BCLR    D1,$0570(A2)                    ; $11B076
        ORI.W  #$002A,$0017(A2)                 ; $11B07A
        DC.W    $0016,$000D         ; $11B080 ORI.B  #$000D,(A6)
        DC.W    $0018,$0017         ; $11B084 ORI.B  #$0017,(A0)+
        ORI.W  #$006C,A6                        ; $11B088
        BCLR    D1,$0068(A7)                    ; $11B08C
        ORI.W  #$0097,A1                        ; $11B090
        BCLR    D2,$0097(A7)                    ; $11B094
        DC.W    $0033,$0069,$00AF   ; $11B098 ORI.B  #$0069,-$51(A3,D0.W)
        DC.W    $00B4,$01B7,$0052,$002B; $11B09E ORI.L  #$01B70052,$2B(A4,D0.W)
        DC.W    $0017,$0016         ; $11B0A6 ORI.B  #$0016,(A7)
        DC.W    $001F,$5C00         ; $11B0AA ORI.B  #$5C00,(A7)+
        ORI.W  #$5900,D6                        ; $11B0AE
        DC.W    $0005,$0217         ; $11B0B2 ORI.B  #$0217,D5
        ORI.W  #$03AD,(A2)+                     ; $11B0B6
        ORI.W  #$0092,$0091.W                   ; $11B0BA
        ORI.W  #$00AE,(A6)                      ; $11B0C0
        BCLR    D1,$0370(A2)                    ; $11B0C4
        ORI.W  #$02B7,$6C(A3,D0.W)              ; $11B0C8
        ORI.W  #$006E,-(A7)                     ; $11B0CE
        BTST    D2,(A7)                         ; $11B0D2
        ORI.W  #$0063,D6                        ; $11B0D4
        BCLR    D1,$006C(A7)                    ; $11B0D8
        ORI.W  #$0063,A5                        ; $11B0DC
        DC.W    $06B7,$0073,$0570,$03AA; $11B0E0 ADDI.L  #$00730570,-$56(A7,D0.W)
        ORI.W  #$00C1,(A6)                      ; $11B0E8
        BTST    D2,(A7)                         ; $11B0EC
        ORI.L  #$005803AD,D7                    ; $11B0EE
        DC.W    $007E,$00AC         ; $11B0F4 ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11B0F8
        BCLR    D1,$007E(A5)                    ; $11B0FC
        ORI.W  #$003C,-$53(A7,D0.W)             ; $11B100
        ORI.W  #$03AE,(A6)                      ; $11B106
        BCLR    D1,$0570(A2)                    ; $11B10A
        ORI.W  #$002A,$0117(A2)                 ; $11B10E
        DC.W    $0016,$0017         ; $11B114 ORI.B  #$0017,(A6)
        DC.W    $002C,$0069,$03AF   ; $11B118 ORI.B  #$0069,$03AF(A4)
        ORI.L  #$00480034,-(A3)                 ; $11B11E
        ORI.L  #$05AF0097,(A7)                  ; $11B124
        DC.W    $00C2               ; $11B12A DC.W    $00C2
        ORI.L  #$006C00B4,(A2)+                 ; $11B12C
        BCLR    D0,$73(A7,D0.W)                 ; $11B132
        DC.W    $00C3               ; $11B136 DC.W    $00C3
        BTST    D0,(A7)                         ; $11B138
        DC.W    $000A,$5C00         ; $11B13A ORI.B  #$5C00,A2
        ORI.W  #$5900,D4                        ; $11B13E
        DC.W    $0003,$000F         ; $11B142 ORI.B  #$000F,D3
        BTST    D0,(A7)                         ; $11B146
        ORI.W  #$03AD,(A4)+                     ; $11B148
        ORI.W  #$00A2,(A6)                      ; $11B14C
        DC.W    $0027,$003B         ; $11B150 ORI.B  #$003B,-(A7)
        ORI.W  #$03AA,(A6)                      ; $11B154
        BCHG    D1,$73(A0,D0.W)                 ; $11B158
        DC.W    $04B7,$0043,$002E,$002B; $11B15C SUBI.L  #$0043002E,$2B(A7,D0.W)
        BTST    D1,(A7)                         ; $11B164
        ORI.W  #$0063,D6                        ; $11B166
        BCLR    D1,$006C(A7)                    ; $11B16A
        ORI.W  #$0063,A5                        ; $11B16E
        DC.W    $06B7,$0073,$0570,$03AA; $11B172 ADDI.L  #$00730570,-$56(A7,D0.W)
        ORI.W  #$00C1,(A6)                      ; $11B17A
        BTST    D2,(A7)                         ; $11B17E
        ORI.L  #$005803AD,D7                    ; $11B180
        DC.W    $007E,$00AC         ; $11B186 ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11B18A
        BCLR    D1,$007E(A5)                    ; $11B18E
        ORI.W  #$003C,-$53(A7,D0.W)             ; $11B192
        ORI.W  #$03AE,(A6)                      ; $11B198
        BCLR    D1,$0570(A2)                    ; $11B19C
        ORI.W  #$002A,$0317(A2)                 ; $11B1A0
        ORI.W  #$0064,D7                        ; $11B1A6
        BCLR    D1,$0063(A7)                    ; $11B1AA
        DC.W    $00B0,$0064,$07AF,$0053; $11B1AE ORI.L  #$006407AF,$53(A0,D0.W)
        ORI.W  #$0063,A5                        ; $11B1B6
        DC.W    $00B4,$01B7,$0073,$0034; $11B1BA ORI.L  #$01B70073,$34(A4,D0.W)
        BTST    D0,(A7)                         ; $11B1C2
        DC.W    $001C,$0001         ; $11B1C4 ORI.B  #$0001,(A4)+
        SUBQ.B  #5,D0                           ; $11B1C8
        ORI.W  #$5900,D7                        ; $11B1CA
        DC.W    $0002,$0009         ; $11B1CE ORI.B  #$0009,D2
        BTST    D0,(A7)                         ; $11B1D2
        DC.W    $0021,$00A0         ; $11B1D4 ORI.B  #$00A0,-(A1)
        DC.W    $02AD,$0056,$0078,$0177; $11B1D8 ANDI.L  #$00560078,$0177(A5)
        ORI.W  #$00B9,-$56(A5,D0.W)             ; $11B1E0
        SUBI.W  #$04B7,$73(A0,D0.W)             ; $11B1E6
        ORI.W  #$00BA,(A3)                      ; $11B1EC
        DC.W    $002B,$0217,$0046   ; $11B1F0 ORI.B  #$0217,$0046(A3)
        ORI.W  #$03AF,-(A3)                     ; $11B1F6
        ORI.W  #$004D,$0063(A4)                 ; $11B1FA
        DC.W    $06B7,$0073,$0570,$03AA; $11B200 ADDI.L  #$00730570,-$56(A7,D0.W)
        ORI.W  #$00C1,(A6)                      ; $11B208
        BTST    D2,(A7)                         ; $11B20C
        ORI.L  #$005803AD,D7                    ; $11B20E
        DC.W    $007E,$00AC         ; $11B214 ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11B218
        BCLR    D1,$007E(A5)                    ; $11B21C
        ORI.W  #$003C,-$53(A7,D0.W)             ; $11B220
        ORI.W  #$03AE,(A6)                      ; $11B226
        BCLR    D1,$0570(A2)                    ; $11B22A
        ORI.W  #$002A,$0317(A2)                 ; $11B22E
        DC.W    $0030,$006D,$02AF   ; $11B234 ORI.B  #$006D,-$51(A0,D0.W)
        DC.W    $00B1,$00A4,$004E,$00A3; $11B23A ORI.L  #$00A4004E,-$5D(A1,D0.W)
        BCLR    D3,$006C(A7)                    ; $11B242
        ORI.W  #$00A4,A5                        ; $11B246
        ORI.W  #$01B7,$73(A3,D0.W)              ; $11B24A
        ORI.W  #$002B,-(A6)                     ; $11B250
        DC.W    $0017,$0016         ; $11B254 ORI.B  #$0016,(A7)
        DC.W    $0005,$5B00         ; $11B258 ORI.B  #$5B00,D5
        ORI.W  #$5A00,A4                        ; $11B25C
        DC.W    $0007,$0217         ; $11B260 ORI.B  #$0217,D7
        ORI.L  #$005801AD,D6                    ; $11B264
        BCHG    D0,(A6)                         ; $11B26A
        DC.W    $007C,$0088,$0027   ; $11B26C ORI.W  #$0088,#$0027
        ORI.L  #$008400BF,-(A5)                 ; $11B272
        BCHG    D1,(A4)                         ; $11B278
        ORI.W  #$005F,(A3)                      ; $11B27A
        DC.W    $04B7,$00B4,$00AF,$0063; $11B27E SUBI.L  #$00B400AF,$63(A7,D0.W)
        ORI.W  #$002A,$0117(A7)                 ; $11B286
        ORI.W  #$0063,D6                        ; $11B28C
        BCLR    D1,$006C(A7)                    ; $11B290
        ORI.W  #$0051,A5                        ; $11B294
        BCHG    D0,-(A3)                        ; $11B298
        SUBI.W  #$0153,(A7)+                    ; $11B29A
        BCHG    D2,(A4)                         ; $11B29E
        DC.W    $02BF,$0098,$0091   ; $11B2A0 ANDI.L  #$00980091,<EA:3F>
        BTST    D2,(A7)                         ; $11B2A6
        ORI.L  #$005803AD,D7                    ; $11B2A8
        DC.W    $007E,$00AC         ; $11B2AE ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11B2B2
        BCLR    D1,$007E(A5)                    ; $11B2B6
        ORI.W  #$005C,$5A(A7,D0.W)              ; $11B2BA
        ORI.L  #$03B90089,(A7)+                 ; $11B2C0
        DC.W    $01BF               ; $11B2C6 BCLR    D0,<EA:3F>
        DC.W    $00BE,$00AA,$0470   ; $11B2C8 ORI.L  #$00AA0470,<EA:3E>
        ORI.W  #$002A,$0217(A2)                 ; $11B2CE
        DC.W    $002A,$0074,$03AF   ; $11B2D4 ORI.B  #$0074,$03AF(A2)
        ORI.L  #$004F0050,(A7)                  ; $11B2DA
        DC.W    $00B1,$07AF,$0097,$0036; $11B2E0 ORI.L  #$07AF0097,$36(A1,D0.W)
        DC.W    $0034,$0073,$02B7   ; $11B2E8 ORI.B  #$0073,-$49(A4,D0.W)
        ORI.W  #$0027,(A7)+                     ; $11B2EE
        BTST    D0,(A7)                         ; $11B2F2
        DC.W    $0019,$5B00         ; $11B2F4 ORI.B  #$5B00,(A1)+
        ORI.W  #$5A00,A5                        ; $11B2F8
        DC.W    $0003,$0010         ; $11B2FC ORI.B  #$0010,D3
        BTST    D0,(A7)                         ; $11B300
        DC.W    $0024,$005A         ; $11B302 ORI.B  #$005A,-(A4)
        BCLR    D0,$0356(A5)                    ; $11B306
        ORI.W  #$0085,$27(A6,D0.W)              ; $11B30A
        ORI.L  #$03910090,(A2)                  ; $11B310
        ORI.L  #$00510053,A7                    ; $11B316
        DC.W    $02B7,$00B4,$01AF,$0053; $11B31C ANDI.L  #$00B401AF,$53(A7,D0.W)
        ORI.W  #$0117,A5                        ; $11B324
        ORI.W  #$0063,D6                        ; $11B328
        BCLR    D1,$006C(A7)                    ; $11B32C
        ORI.W  #$039A,$008F(A6)                 ; $11B330
        SUBI.L  #$00910194,(A0)                 ; $11B336
        ANDI.L  #$03270617,(A2)                 ; $11B33C
        ORI.L  #$005803AD,D7                    ; $11B342
        DC.W    $007E,$00AC         ; $11B348 ORI.W  #$00AC,<EA:3E>
        ORI.W  #$0059,(A4)+                     ; $11B34C
        BCLR    D1,$007E(A5)                    ; $11B350
        DC.W    $0027,$0022         ; $11B354 ORI.B  #$0022,-(A7)
        DC.W    $0023,$0324         ; $11B358 ORI.B  #$0324,-(A3)
        DC.W    $0028,$0327,$0039   ; $11B35C ORI.B  #$0327,$0039(A0)
        ORI.W  #$03C4,$6A(A0,D0.W)              ; $11B362
        DC.W    $002A,$0217,$002B   ; $11B368 ORI.B  #$0217,$002B(A2)
        ORI.L  #$00AF02C5,-(A4)                 ; $11B36E
        ORI.W  #$0033,-$6B(A3,D0.W)             ; $11B374
        BSET    D1,D5                           ; $11B37A
        ORI.L  #$006303C5,-(A3)                 ; $11B37C
        ORI.W  #$00BA,(A3)                      ; $11B382
        ORI.W  #$02B7,$70(A3,D0.W)              ; $11B386
        ORI.L  #$01170010,A7                    ; $11B38C
        DC.W    $0003,$5A00         ; $11B392 ORI.B  #$5A00,D3
        ORI.W  #$5B00,(A1)                      ; $11B396
        DC.W    $0009,$0217         ; $11B39A ORI.B  #$0217,A1
        ORI.W  #$01AD,$56(A1,D0.W)              ; $11B39E
        BCLR    D1,$0189(A6)                    ; $11B3A4
        DC.W    $00BF,$0254,$007F   ; $11B3A8 ORI.L  #$0254007F,<EA:3F>
        DC.W    $018F               ; $11B3AE BCLR    D0,A7
        ORI.W  #$0043,A4                        ; $11B3B0
        ORI.W  #$00B7,(A7)+                     ; $11B3B4
        DC.W    $00B4,$01AF,$0073,$0049; $11B3B8 ORI.L  #$01AF0073,$49(A4,D0.W)
        BTST    D0,(A7)                         ; $11B3C0
        ORI.W  #$0063,D6                        ; $11B3C2
        BCLR    D1,$006C(A7)                    ; $11B3C6
        ORI.W  #$006A,A5                        ; $11B3CA
        ANDI.W  #$0453,(A7)+                    ; $11B3CE
        SUBI.W  #$0051,(A4)                     ; $11B3D2
        DC.W    $0389               ; $11B3D6 BCLR    D1,A1
        ORI.W  #$0091,$17(A6,D0.W)              ; $11B3D8
        ORI.W  #$00AB,-$3A(PC,D0.W)             ; $11B3DE
        ORI.W  #$00AC,(A1)+                     ; $11B3E4
        ORI.W  #$00C7,(A4)+                     ; $11B3E8
        BSET    D1,D6                           ; $11B3EC
        ORI.W  #$0077,(A1)+                     ; $11B3EE
        ORI.W  #$005A,(A4)+                     ; $11B3F2
        ANDI.L  #$01B90089,(A7)+                ; $11B3F6
        DC.W    $00BF,$009F,$00C8   ; $11B3FC ORI.L  #$009F00C8,<EA:3F>
        DC.W    $0039,$0070,$01C4,$01C9; $11B402 ORI.B  #$0070,$01C401C9
        ORI.W  #$002A,(A1)                      ; $11B40A
        DC.W    $0217,$008D         ; $11B40E ANDI.B  #$008D,(A7)
        DC.W    $00B6,$03C5,$008A,$004E; $11B412 ORI.L  #$03C5008A,$4E(A6,D0.W)
        ORI.W  #$02C5,-(A4)                     ; $11B41A
        DC.W    $00AF,$0049,$00B0,$0097; $11B41E ORI.L  #$004900B0,$0097(A7)
        DC.W    $02C5               ; $11B426 DC.W    $02C5
        ORI.W  #$009A,-(A3)                     ; $11B428
        ORI.W  #$03CA,$009D(A2)                 ; $11B42C
        DC.W    $0020,$0017         ; $11B432 ORI.B  #$0017,-(A0)
        DC.W    $0015,$0003         ; $11B436 ORI.B  #$0003,(A5)
        ADDQ.B  #5,D0                           ; $11B43A
        ORI.W  #$5B00,(A0)                      ; $11B43C
        DC.W    $0004,$000A         ; $11B440 ORI.B  #$000A,D4
        BTST    D0,(A7)                         ; $11B444
        DC.W    $0026,$0040         ; $11B446 ORI.B  #$0040,-(A6)
        DC.W    $00C6               ; $11B44A DC.W    $00C6
        DC.W    $04AE,$03CB,$0070,$01C4; $11B44C SUBI.L  #$03CB0070,$01C4(A6)
        DC.W    $00C9               ; $11B454 DC.W    $00C9
        ORI.W  #$0054,(A7)+                     ; $11B456
        DC.W    $00BD,$008D,$0031   ; $11B45A ORI.L  #$008D0031,<EA:3D>
        DC.W    $00B6,$00CA,$02C5,$0053; $11B460 ORI.L  #$00CA02C5,$53(A6,D0.W)
        ORI.W  #$0017,D7                        ; $11B468
        ORI.W  #$0063,D6                        ; $11B46C
        BSET    D1,D5                           ; $11B470
        ORI.W  #$004D,$006C(A4)                 ; $11B472
        DC.W    $07CA               ; $11B478 BSET    D3,A2
        DC.W    $02C9               ; $11B47A DC.W    $02C9
        DC.W    $02C4               ; $11B47C DC.W    $02C4
        DC.W    $00CC               ; $11B47E DC.W    $00CC
        DC.W    $02CB               ; $11B480 DC.W    $02CB
        ORI.W  #$00A5,(A6)                      ; $11B482
        BTST    D2,(A7)                         ; $11B486
        ORI.W  #$04C6,$59(PC,D0.W)              ; $11B488
        ORI.W  #$00CD,(A3)+                     ; $11B48E
        DC.W    $00C7               ; $11B492 DC.W    $00C7
        BSET    D1,D6                           ; $11B494
        ORI.W  #$003E,(A1)+                     ; $11B496
        ORI.L  #$00C604AE,-(A2)                 ; $11B49A
        DC.W    $01CB               ; $11B4A0 BSET    D0,A3
        DC.W    $00AA,$00CE,$0039,$02C4; $11B4A2 ORI.L  #$00CE0039,$02C4(A2)
        DC.W    $01C9               ; $11B4AA BSET    D0,A1
        ORI.W  #$002A,(A1)                      ; $11B4AC
        DC.W    $0217,$0032         ; $11B4B0 ANDI.B  #$0032,(A7)
        DC.W    $00B4,$03CF,$008C,$0050; $11B4B4 ORI.L  #$03CF008C,$50(A4,D0.W)
        DC.W    $00D0               ; $11B4BC DC.W    $00D0
        DC.W    $02CF               ; $11B4BE DC.W    $02CF
        DC.W    $00AF,$00D1,$0060,$00B1; $11B4C0 ORI.L  #$00D10060,$00B1(A7)
        DC.W    $02CF               ; $11B4C8 DC.W    $02CF
        DC.W    $00D0               ; $11B4CA DC.W    $00D0
        DC.W    $0036,$00D2,$03CA   ; $11B4CC ORI.B  #$00D2,-$36(A6,D0.W)
        ORI.W  #$008F,$17(A0,D0.W)              ; $11B4D2
        DC.W    $0018,$001F         ; $11B4D8 ORI.B  #$001F,(A0)+
        DC.W    $0001,$5900         ; $11B4DC ORI.B  #$5900,D1
        ORI.W  #$5C00,A5                        ; $11B4E0
        DC.W    $0006,$001A         ; $11B4E4 ORI.B  #$001A,D6
        BTST    D0,(A7)                         ; $11B4E8
        DC.W    $00D3               ; $11B4EA DC.W    $00D3
        ORI.W  #$00AD,(A5)+                     ; $11B4EC
        BCLR    D1,$03CC(A6)                    ; $11B4F0
        DC.W    $02C4               ; $11B4F4 DC.W    $02C4
        DC.W    $01C9               ; $11B4F6 BSET    D0,A1
        DC.W    $00CA               ; $11B4F8 DC.W    $00CA
        ORI.W  #$00D4,-$73(A0,D0.W)             ; $11B4FA
        ORI.W  #$00CA,$02C5(A2)                 ; $11B500
        DC.W    $00B7,$00BA,$002A,$0046; $11B506 ORI.L  #$00BA002A,$46(A7,D0.W)
        ORI.W  #$03C5,$0073(A4)                 ; $11B50E
        ORI.W  #$006C,A5                        ; $11B514
        DC.W    $07CA               ; $11B518 BSET    D3,A2
        DC.W    $02C9               ; $11B51A DC.W    $02C9
        DC.W    $02C4               ; $11B51C DC.W    $02C4
        DC.W    $03CC               ; $11B51E BSET    D1,A4
        DC.W    $00AE,$00A5,$0517,$00D5; $11B520 ORI.L  #$00A50517,$00D5(A6)
        DC.W    $04D6               ; $11B528 DC.W    $04D6
        DC.W    $00D7               ; $11B52A DC.W    $00D7
        ORI.W  #$00CD,(A3)+                     ; $11B52C
        DC.W    $00C7               ; $11B530 DC.W    $00C7
        BSET    D1,(A6)                         ; $11B532
        DC.W    $00D7               ; $11B534 DC.W    $00D7
        DC.W    $003E,$00A2         ; $11B536 ORI.B  #$00A2,<EA:3E>
        DC.W    $00D6               ; $11B53A DC.W    $00D6
        DC.W    $04AE,$01CC,$00AA,$00CE; $11B53C SUBI.L  #$01CC00AA,$00CE(A6)
        DC.W    $0039,$02C4,$01C9,$00D4; $11B544 ORI.B  #$02C4,$01C900D4
        DC.W    $002A,$0117,$002B   ; $11B54C ORI.B  #$0117,$002B(A2)
        ORI.W  #$00B4,D4                        ; $11B552
        DC.W    $02CF               ; $11B556 DC.W    $02CF
        DC.W    $00AF,$0033,$0061,$00D0; $11B558 ORI.L  #$00330061,$00D0(A7)
        DC.W    $02CF               ; $11B560 DC.W    $02CF
        DC.W    $00B1,$0048,$0060,$006D; $11B562 ORI.L  #$00480060,$6D(A1,D0.W)
        DC.W    $03CF               ; $11B56A BSET    D1,A7
        ORI.W  #$0031,$73(A4,D0.W)              ; $11B56C
        DC.W    $03CA               ; $11B572 BSET    D1,A2
        DC.W    $0037,$0117,$001C   ; $11B574 ORI.B  #$0117,$1C(A7,D0.W)
        DC.W    $0001,$5900         ; $11B57A ORI.B  #$5900,D1
        ORI.W  #$5D00,A2                        ; $11B57E
        DC.W    $001E,$0217         ; $11B582 ORI.B  #$0217,(A6)+
        DC.W    $0023,$00B8         ; $11B586 ORI.B  #$00B8,-(A3)
        DC.W    $00AD,$02AE,$03CC,$02C4; $11B58A ORI.L  #$02AE03CC,$02C4(A5)
        DC.W    $01C9               ; $11B592 BSET    D0,A1
        DC.W    $01CA               ; $11B594 BSET    D0,A2
        DC.W    $00B4,$00BD,$008D,$0073; $11B596 ORI.L  #$00BD008D,$73(A4,D0.W)
        DC.W    $03CF               ; $11B59E BSET    D1,A7
        ORI.W  #$002C,$0046(A2)                 ; $11B5A0
        ORI.W  #$03CF,$0073(A5)                 ; $11B5A6
        ORI.W  #$006D,A5                        ; $11B5AC
        DC.W    $07CA               ; $11B5B0 BSET    D3,A2
        DC.W    $02C9               ; $11B5B2 DC.W    $02C9
        DC.W    $02C4               ; $11B5B4 DC.W    $02C4
        DC.W    $03CC               ; $11B5B6 BSET    D1,A4
        DC.W    $00AE,$00A5,$0517,$00D5; $11B5B8 ORI.L  #$00A50517,$00D5(A6)
        DC.W    $04D6               ; $11B5C0 DC.W    $04D6
        DC.W    $00D7               ; $11B5C2 DC.W    $00D7
        ORI.W  #$00CD,(A3)+                     ; $11B5C4
        DC.W    $00C7               ; $11B5C8 DC.W    $00C7
        BSET    D1,(A6)                         ; $11B5CA
        DC.W    $00D7               ; $11B5CC DC.W    $00D7
        DC.W    $003E,$00A2         ; $11B5CE ORI.B  #$00A2,<EA:3E>
        DC.W    $00D6               ; $11B5D2 DC.W    $00D6
        DC.W    $04AE,$01CC,$00AA,$00CE; $11B5D4 SUBI.L  #$01CC00AA,$00CE(A6)
        DC.W    $0039,$02C4,$01C9,$00D4; $11B5DC ORI.B  #$02C4,$01C900D4
        DC.W    $002A,$0117,$004C   ; $11B5E4 ORI.B  #$0117,$004C(A2)
        DC.W    $00D8               ; $11B5EA DC.W    $00D8
        DC.W    $03CF               ; $11B5EC BSET    D1,A7
        ORI.W  #$0048,$006B(A5)                 ; $11B5EE
        DC.W    $03CF               ; $11B5F4 BSET    D1,A7
        ORI.W  #$00D9,$0046(PC)                 ; $11B5F6
        ORI.L  #$00D002CF,-(A4)                 ; $11B5FC
        ORI.W  #$004E,(A3)                      ; $11B602
        ORI.W  #$02C5,$00CA(A5)                 ; $11B606
        ORI.W  #$0117,-(A6)                     ; $11B60C
        DC.W    $000F,$0002         ; $11B610 ORI.B  #$0002,A7
        SUBQ.B  #4,D0                           ; $11B614
        ORI.W  #$5A00,A4                        ; $11B616
        DC.W    $0007,$011F         ; $11B61A ORI.B  #$011F,D7
        DC.W    $000A,$000F         ; $11B61E ORI.B  #$000F,A2
        BTST    D1,(A7)                         ; $11B622
        ORI.W  #$007C,-$52(PC,D0.W)             ; $11B624
        DC.W    $03CC               ; $11B62A BSET    D1,A4
        DC.W    $02C4               ; $11B62C DC.W    $02C4
        DC.W    $00C9               ; $11B62E DC.W    $00C9
        DC.W    $03CA               ; $11B630 BSET    D1,A2
        ORI.W  #$0090,(A4)                      ; $11B632
        ORI.W  #$03CF,(A4)                      ; $11B636
        ORI.W  #$002B,$0046(A3)                 ; $11B63A
        ORI.W  #$03CF,$0073(A5)                 ; $11B640
        ORI.W  #$006D,A5                        ; $11B646
        DC.W    $07CA               ; $11B64A BSET    D3,A2
        DC.W    $02C9               ; $11B64C DC.W    $02C9
        DC.W    $02C4               ; $11B64E DC.W    $02C4
        DC.W    $03CC               ; $11B650 BSET    D1,A4
        DC.W    $00AE,$00A5,$0517,$00D5; $11B652 ORI.L  #$00A50517,$00D5(A6)
        DC.W    $04D6               ; $11B65A DC.W    $04D6
        DC.W    $00D7               ; $11B65C DC.W    $00D7
        ORI.W  #$00CD,(A3)+                     ; $11B65E
        DC.W    $00C7               ; $11B662 DC.W    $00C7
        BSET    D1,(A6)                         ; $11B664
        DC.W    $00D7               ; $11B666 DC.W    $00D7
        DC.W    $003E,$00A2         ; $11B668 ORI.B  #$00A2,<EA:3E>
        DC.W    $02AE,$04CC,$00AA,$00CE; $11B66C ANDI.L  #$04CC00AA,$00CE(A6)
        DC.W    $0039,$00C4,$01B4,$01CA; $11B674 ORI.B  #$00C4,$01B401CA
        DC.W    $00D4               ; $11B67C DC.W    $00D4
        DC.W    $002A,$0117,$009A   ; $11B67E ORI.B  #$0117,$009A(A2)
        ORI.W  #$01CF,-$26(A3,D0.W)             ; $11B684
        ORI.W  #$004A,$00B1(A3)                 ; $11B68A
        BSET    D1,(A2)+                        ; $11B690
        ORI.W  #$0029,-(A1)                     ; $11B692
        DC.W    $002A,$0034,$00DB   ; $11B696 ORI.B  #$0034,$00DB(A2)
        DC.W    $02DA               ; $11B69C DC.W    $02DA
        DC.W    $00B1,$002E,$006B,$03C5; $11B69E ORI.L  #$002E006B,-$3B(A1,D0.W)
        ORI.W  #$008F,$17(A3,D0.W)              ; $11B6A6
        DC.W    $0018,$001F         ; $11B6AC ORI.B  #$001F,(A0)+
        SUBQ.B  #4,D0                           ; $11B6B0
        ORI.W  #$5900,(A1)                      ; $11B6B2
        DC.W    $0005,$0917         ; $11B6B6 ORI.B  #$0917,D5
        DC.W    $0021,$0087         ; $11B6BA ORI.B  #$0087,-(A1)
        ORI.L  #$005600AE,D3                    ; $11B6BE
        DC.W    $02DC               ; $11B6C4 DC.W    $02DC
        DC.W    $00CC               ; $11B6C6 DC.W    $00CC
        BSET    D0,D4                           ; $11B6C8
        DC.W    $03CA               ; $11B6CA BSET    D1,A2
        ORI.W  #$008D,$32(A3,D0.W)              ; $11B6CC
        DC.W    $00B4,$02CF,$006B,$002B; $11B6D2 ORI.L  #$02CF006B,$2B(A4,D0.W)
        ORI.W  #$006D,D6                        ; $11B6DA
        DC.W    $00CF               ; $11B6DE DC.W    $00CF
        DC.W    $02DA               ; $11B6E0 DC.W    $02DA
        ORI.W  #$004D,$6D(A3,D0.W)              ; $11B6E2
        DC.W    $06C5               ; $11B6E8 DC.W    $06C5
        DC.W    $02CA               ; $11B6EA DC.W    $02CA
        DC.W    $02B4,$04C4,$00AA,$00A5; $11B6EC ANDI.L  #$04C400AA,-$5B(A4,D0.W)
        BTST    D2,(A7)                         ; $11B6F4
        DC.W    $00D5               ; $11B6F6 DC.W    $00D5
        DC.W    $00D6               ; $11B6F8 DC.W    $00D6
        DC.W    $00AE,$02D6,$00D7,$005B; $11B6FA ORI.L  #$02D600D7,$005B(A6)
        DC.W    $00CD               ; $11B702 DC.W    $00CD
        BSET    D1,(A6)                         ; $11B704
        DC.W    $00AE,$0057,$003E,$0041; $11B706 ORI.L  #$0057003E,$0041(A6)
        DC.W    $00CB               ; $11B70E DC.W    $00CB
        DC.W    $03CC               ; $11B710 BSET    D1,A4
        DC.W    $02C4               ; $11B712 DC.W    $02C4
        ORI.W  #$00CE,$39(A0,D0.W)              ; $11B714
        DC.W    $02B4,$00CA,$00C5,$006B; $11B71A ANDI.L  #$00CA00C5,$6B(A4,D0.W)
        DC.W    $002A,$0017,$002B   ; $11B722 ORI.B  #$0017,$002B(A2)
        ORI.L  #$00AF02DA,A4                    ; $11B728
        DC.W    $00B1,$0048,$0049,$00DD; $11B72E ORI.L  #$00480049,-$23(A1,D0.W)
        BSET    D1,(A2)+                        ; $11B736
        ORI.W  #$0018,A7                        ; $11B738
        DC.W    $002A,$004A,$00DD   ; $11B73C ORI.B  #$004A,$00DD(A2)
        DC.W    $02DA               ; $11B742 DC.W    $02DA
        DC.W    $00AF,$0031,$006F,$00AF; $11B744 ORI.L  #$0031006F,$00AF(A7)
        DC.W    $02C5               ; $11B74C DC.W    $02C5
        DC.W    $00B7,$008D,$0117,$0009; $11B74E ORI.L  #$008D0117,$09(A7,D0.W)
        SUBQ.B  #4,D0                           ; $11B756
        ORI.W  #$5900,A4                        ; $11B758
        DC.W    $0005,$0B17         ; $11B75C ORI.B  #$0B17,D5
        DC.W    $0020,$005B         ; $11B760 ORI.B  #$005B,-(A0)
        BSET    D0,(A6)+                        ; $11B764
        DC.W    $00CE               ; $11B766 DC.W    $00CE
        BCLR    D0,-$5A(PC,D0.W)                ; $11B768
        ORI.L  #$007303C5,D2                    ; $11B76C
        ORI.W  #$0033,$00AF(A3)                 ; $11B772
        DC.W    $02DA               ; $11B778 DC.W    $02DA
        ORI.W  #$002B,$0046(A3)                 ; $11B77A
        ORI.W  #$03DA,$0097(A5)                 ; $11B780
        ORI.W  #$00A3,A5                        ; $11B786
        DC.W    $04C5               ; $11B78A DC.W    $04C5
        ORI.W  #$016C,$065F(A5)                 ; $11B78C
        ANDI.W  #$0089,(A5)                     ; $11B792
        ORI.L  #$05170075,(A1)                  ; $11B796
        DC.W    $04AE,$0057,$005B,$00DF; $11B79C SUBI.L  #$0057005B,$00DF(A6)
        DC.W    $04AE,$0056,$003E,$00E0; $11B7A4 SUBI.L  #$0056003E,$00E0(A6)
        ANDI.W  #$01CC,(A6)                     ; $11B7AC
        DC.W    $02C4               ; $11B7B0 DC.W    $02C4
        ORI.W  #$00CE,$66(A0,D0.W)              ; $11B7B2
        DC.W    $02B4,$00CA,$00C5,$0052; $11B7B8 ANDI.L  #$00CA00C5,$52(A4,D0.W)
        DC.W    $002A,$0017,$002C   ; $11B7C0 ORI.B  #$0017,$002C(A2)
        ORI.W  #$00CF,$02DA(A5)                 ; $11B7C6
        ORI.L  #$00B00064,(A7)                  ; $11B7CC
        BSET    D1,(A2)+                        ; $11B7D2
        ORI.L  #$00600118,-(A3)                 ; $11B7D4
        ORI.W  #$0064,$03DA(A6)                 ; $11B7DA
        ORI.W  #$0030,-(A4)                     ; $11B7E0
        ORI.L  #$02C500B4,(A7)                  ; $11B7E4
        DC.W    $0037,$0117,$001B   ; $11B7EA ORI.B  #$0117,$1B(A7,D0.W)
        DC.W    $0003,$5800         ; $11B7F0 ORI.B  #$5800,D3
        ORI.W  #$5900,(A2)                      ; $11B7F4
        DC.W    $0005,$0217         ; $11B7F8 ORI.B  #$0217,D5
        DC.W    $007D,$0541         ; $11B7FC ORI.W  #$0541,<EA:3D>
        SUBI.W  #$0267,D2                       ; $11B800
        BCHG    D0,-(A6)                        ; $11B804
        ORI.W  #$00B7,$03C5(A0)                 ; $11B806
        ORI.W  #$0033,$00AF(A3)                 ; $11B80C
        DC.W    $02DA               ; $11B812 DC.W    $02DA
        ORI.L  #$002B0046,(A5)                  ; $11B814
        ORI.L  #$03DA0097,-(A3)                 ; $11B81A
        ORI.W  #$00A3,A5                        ; $11B820
        BSET    D1,D5                           ; $11B824
        ORI.W  #$00BD,-$71(A3,D0.W)             ; $11B826
        ORI.L  #$00940092,(A0)                  ; $11B82C
        BTST    D3,-(A7)                        ; $11B832
        DC.W    $0021,$0517         ; $11B834 ORI.B  #$0517,-(A1)
        ORI.W  #$04AE,$57(A5,D0.W)              ; $11B838
        ORI.W  #$00DF,(A3)+                     ; $11B83E
        DC.W    $04AE,$0056,$003E,$0024; $11B842 SUBI.L  #$0056003E,$0024(A6)
        DC.W    $0026,$0092         ; $11B84A ORI.B  #$0092,-(A6)
        ORI.L  #$00AA00CC,A0                    ; $11B84E
        DC.W    $02C4               ; $11B854 DC.W    $02C4
        ORI.W  #$00BC,$66(A0,D0.W)              ; $11B856
        DC.W    $02B4,$00CA,$00C5,$0052; $11B85C ANDI.L  #$00CA00C5,$52(A4,D0.W)
        DC.W    $002A,$0017,$0090   ; $11B864 ORI.B  #$0017,$0090(A2)
        ORI.L  #$00CF01DA,-(A3)                 ; $11B86A
        DC.W    $00DB               ; $11B870 DC.W    $00DB
        ORI.W  #$004E,$00A3(PC)                 ; $11B872
        BSET    D1,(A2)+                        ; $11B878
        DC.W    $00DD               ; $11B87A DC.W    $00DD
        ORI.W  #$0134,A7                        ; $11B87C
        ORI.W  #$00A3,(A0)                      ; $11B880
        BSET    D1,(A2)+                        ; $11B884
        ORI.L  #$009A007A,-(A3)                 ; $11B886
        DC.W    $02C5               ; $11B88C DC.W    $02C5
        DC.W    $00CA               ; $11B88E DC.W    $00CA
        ORI.W  #$0020,(A7)+                     ; $11B890
        DC.W    $0017,$0018         ; $11B894 ORI.B  #$0018,(A7)
        DC.W    $0004,$5800         ; $11B898 ORI.B  #$5800,D4
        ORI.W  #$5900,A4                        ; $11B89C
        DC.W    $0005,$0217         ; $11B8A0 ORI.B  #$0217,D5
        ORI.W  #$01AE,$01CB.W                   ; $11B8A4
        DC.W    $03CC               ; $11B8AA BSET    D1,A4
        DC.W    $04C4               ; $11B8AC DC.W    $04C4
        BCLR    D1,-$3B(A4,D0.W)                ; $11B8AE
        ORI.L  #$002E0033,(A7)                  ; $11B8B2
        DC.W    $00AF,$02DA,$0095,$002B; $11B8B8 ORI.L  #$02DA0095,$002B(A7)
        ORI.W  #$00A3,D6                        ; $11B8C0
        BSET    D1,(A2)+                        ; $11B8C4
        ORI.L  #$004D00A3,(A7)                  ; $11B8C6
        DC.W    $04C5               ; $11B8CC DC.W    $04C5
        ORI.W  #$006D,$6C(A3,D0.W)              ; $11B8CE
        BCHG    D2,(A7)+                        ; $11B8D4
        BCHG    D1,(A4)                         ; $11B8D6
        DC.W    $01BE               ; $11B8D8 BCLR    D0,<EA:3E>
        DC.W    $00BF,$0089,$007B   ; $11B8DA ORI.L  #$0089007B,<EA:3F>
        BTST    D0,(A7)                         ; $11B8E0
        ORI.W  #$04AE,$57(A5,D0.W)              ; $11B8E2
        ORI.W  #$00DF,(A3)+                     ; $11B8E8
        BCLR    D2,$0078(A6)                    ; $11B8EC
        ORI.L  #$01B90056,(A7)+                 ; $11B8F0
        DC.W    $01CC               ; $11B8F6 BSET    D0,A4
        DC.W    $02C4               ; $11B8F8 DC.W    $02C4
        ORI.W  #$00BC,$66(A0,D0.W)              ; $11B8FA
        DC.W    $02B4,$00CA,$00C5,$0052; $11B900 ANDI.L  #$00CA00C5,$52(A4,D0.W)
        DC.W    $002A,$002B,$008C   ; $11B908 ORI.B  #$002B,$008C(A2)
        DC.W    $00C5               ; $11B90E DC.W    $00C5
        DC.W    $00CF               ; $11B910 DC.W    $00CF
        BSET    D0,(A2)+                        ; $11B912
        DC.W    $00E1               ; $11B914 DC.W    $00E1
        DC.W    $0034,$0033,$00E1   ; $11B916 ORI.B  #$0033,-$1F(A4,D0.W)
        DC.W    $04DA               ; $11B91C DC.W    $04DA
        BSET    D1,-(A1)                        ; $11B91E
        DC.W    $04DA               ; $11B920 DC.W    $04DA
        DC.W    $00AF,$0036,$009B,$02C5; $11B922 ORI.L  #$0036009B,$02C5(A7)
        DC.W    $00CA               ; $11B92A DC.W    $00CA
        ORI.W  #$0027,(A7)+                     ; $11B92C
        BTST    D0,(A7)                         ; $11B930
        DC.W    $001F,$0001         ; $11B932 ORI.B  #$0001,(A7)+
        SUBQ.B  #3,D0                           ; $11B936
        ORI.W  #$5900,D5                        ; $11B938
        DC.W    $0005,$0217         ; $11B93C ORI.B  #$0217,D5
        ORI.W  #$01AE,$01CB.W                   ; $11B940
        DC.W    $03CC               ; $11B946 BSET    D1,A4
        DC.W    $04C4               ; $11B948 DC.W    $04C4
        DC.W    $02B4,$00CA,$02C5,$00AF; $11B94A ANDI.L  #$00CA02C5,-$51(A4,D0.W)
        ORI.W  #$0090,$0064(A3)                 ; $11B952
        BSET    D1,(A2)+                        ; $11B958
        DC.W    $00E2               ; $11B95A DC.W    $00E2
        DC.W    $002B,$0046,$00A3   ; $11B95C ORI.B  #$0046,$00A3(A3)
        BSET    D1,(A2)+                        ; $11B962
        ORI.L  #$004D00A3,-(A3)                 ; $11B964
        BSET    D3,D5                           ; $11B96A
        DC.W    $01CA               ; $11B96C BSET    D0,A2
        BCLR    D1,-$3C(A4,D0.W)                ; $11B96E
        DC.W    $01CC               ; $11B972 BSET    D0,A4
        DC.W    $00CB               ; $11B974 DC.W    $00CB
        DC.W    $00E0               ; $11B976 DC.W    $00E0
        BTST    D0,(A7)                         ; $11B978
        ORI.W  #$04AE,$57(A5,D0.W)              ; $11B97A
        ORI.W  #$00DF,(A3)+                     ; $11B980
        DC.W    $06AE,$01CB,$03CC,$02C4; $11B984 ADDI.L  #$01CB03CC,$02C4(A6)
        ORI.W  #$00BC,$66(A0,D0.W)              ; $11B98C
        BCLR    D0,-$36(A4,D0.W)                ; $11B992
        DC.W    $00C5               ; $11B996 DC.W    $00C5
        ORI.W  #$002B,(A2)                      ; $11B998
        ORI.L  #$006300C5,(A0)                  ; $11B99C
        DC.W    $00CF               ; $11B9A2 DC.W    $00CF
        BSET    D0,(A2)+                        ; $11B9A4
        DC.W    $00B1,$0033,$0095,$0EDA; $11B9A6 ORI.L  #$00330095,-$26(A1,D0.L)
        DC.W    $00CF               ; $11B9AE DC.W    $00CF
        ORI.L  #$003500AF,A4                    ; $11B9B0
        BSET    D0,D5                           ; $11B9B6
        DC.W    $00CA               ; $11B9B8 DC.W    $00CA
        DC.W    $00B4,$0066,$0117,$0012; $11B9BA ORI.L  #$00660117,$12(A4,D0.W)
        DC.W    $0003,$5700         ; $11B9C2 ORI.B  #$5700,D3
        ORI.W  #$5900,A0                        ; $11B9C6
        DC.W    $0005,$0217         ; $11B9CA ORI.B  #$0217,D5
        ORI.W  #$01AE,$01CB.W                   ; $11B9CE
        DC.W    $03CC               ; $11B9D4 BSET    D1,A4
        DC.W    $04C4               ; $11B9D6 DC.W    $04C4
        DC.W    $02B4,$00CA,$02C5,$00B1; $11B9D8 ANDI.L  #$00CA02C5,-$4F(A4,D0.W)
        DC.W    $00BA,$002F,$00B1,$03DA; $11B9E0 ORI.L  #$002F00B1,$03DA(PC)
        ORI.W  #$002B,$0046(PC)                 ; $11B9E8
        ORI.L  #$03DA00A3,-(A3)                 ; $11B9EE
        ORI.W  #$00A3,A5                        ; $11B9F4
        BSET    D3,D5                           ; $11B9F8
        DC.W    $01CA               ; $11B9FA BSET    D0,A2
        BCLR    D1,-$3C(A4,D0.W)                ; $11B9FC
        DC.W    $01CC               ; $11BA00 BSET    D0,A4
        DC.W    $00CB               ; $11BA02 DC.W    $00CB
        DC.W    $00E0               ; $11BA04 DC.W    $00E0
        BTST    D0,(A7)                         ; $11BA06
        ORI.W  #$04AE,$57(A5,D0.W)              ; $11BA08
        ORI.W  #$00DF,(A3)+                     ; $11BA0E
        DC.W    $06AE,$00CB,$04CC,$02C4; $11BA12 ADDI.L  #$00CB04CC,$02C4(A6)
        ORI.W  #$00BC,$66(A0,D0.W)              ; $11BA1A
        BCLR    D0,-$36(A4,D0.W)                ; $11BA20
        DC.W    $00C5               ; $11BA24 DC.W    $00C5
        ORI.W  #$0022,(A2)                      ; $11BA26
        DC.W    $00E3               ; $11BA2A DC.W    $00E3
        DC.W    $00AF,$00C5,$00CF,$01DA; $11BA2C ORI.L  #$00C500CF,$01DA(A7)
        ORI.W  #$004E,$00A9(PC)                 ; $11BA34
        BSET    D1,(A2)+                        ; $11BA3A
        DC.W    $00DD               ; $11BA3C DC.W    $00DD
        BSET    D4,(A2)+                        ; $11BA3E
        DC.W    $00CF               ; $11BA40 DC.W    $00CF
        ORI.W  #$009A,$0053(PC)                 ; $11BA42
        BSET    D0,D5                           ; $11BA48
        DC.W    $00CA               ; $11BA4A DC.W    $00CA
        DC.W    $00B4,$0051,$0117,$0018; $11BA4C ORI.L  #$00510117,$18(A4,D0.W)
        DC.W    $0008,$0001         ; $11BA54 ORI.B  #$0001,A0
        ADDQ.B  #3,D0                           ; $11BA58
        ORI.W  #$5900,A5                        ; $11BA5A
        DC.W    $0005,$0217         ; $11BA5E ORI.B  #$0217,D5
        ORI.W  #$01AE,$00CB.W                   ; $11BA62
        DC.W    $04CC               ; $11BA68 DC.W    $04CC
        BSET    D1,D4                           ; $11BA6A
        DC.W    $00B7,$01B4,$01CA,$01C5; $11BA6C ORI.L  #$01B401CA,-$3B(A7,D0.W)
        ORI.W  #$0069,$2E(A3,D0.W)              ; $11BA74
        ORI.W  #$03DA,$00AF(A3)                 ; $11BA7A
        ORI.W  #$002A,A7                        ; $11BA80
        ORI.W  #$00A3,D6                        ; $11BA84
        BSET    D1,(A2)+                        ; $11BA88
        ORI.L  #$004D0097,-(A3)                 ; $11BA8A
        BSET    D3,D5                           ; $11BA90
        DC.W    $01CA               ; $11BA92 BSET    D0,A2
        BCLR    D1,-$3C(A4,D0.W)                ; $11BA94
        DC.W    $01CC               ; $11BA98 BSET    D0,A4
        DC.W    $00CB               ; $11BA9A DC.W    $00CB
        DC.W    $00E0               ; $11BA9C DC.W    $00E0
        BTST    D0,(A7)                         ; $11BA9E
        ORI.W  #$04AE,$57(A5,D0.W)              ; $11BAA0
        ORI.W  #$00DF,(A3)+                     ; $11BAA6
        DC.W    $06AE,$00CB,$04CC,$02C4; $11BAAA ADDI.L  #$00CB04CC,$02C4(A6)
        ORI.W  #$00BC,$66(A0,D0.W)              ; $11BAB2
        BCLR    D0,-$36(A4,D0.W)                ; $11BAB8
        DC.W    $00C5               ; $11BABC DC.W    $00C5
        ORI.W  #$004B,(A2)                      ; $11BABE
        ORI.L  #$00AF00C5,-(A4)                 ; $11BAC2
        DC.W    $00CF               ; $11BAC8 DC.W    $00CF
        DC.W    $00DA               ; $11BACA DC.W    $00DA
        DC.W    $00DB               ; $11BACC DC.W    $00DB
        ORI.W  #$0050,-$25(A4,D0.W)             ; $11BACE
        DC.W    $02DA               ; $11BAD4 DC.W    $02DA
        DC.W    $00E1               ; $11BAD6 DC.W    $00E1
        ORI.W  #$00A3,(A0)                      ; $11BAD8
        BSET    #15,(A2)+                       ; $11BADC
        DC.W    $00AF,$0030,$00BA,$00B7; $11BAE0 ORI.L  #$003000BA,$00B7(A7)
        DC.W    $00C5               ; $11BAE8 DC.W    $00C5
        DC.W    $01CA               ; $11BAEA BSET    D0,A2
        ORI.W  #$008F,$17(A0,D0.W)              ; $11BAEC
        DC.W    $000C,$0001         ; $11BAF2 ORI.B  #$0001,A4
        ADDQ.B  #3,D0                           ; $11BAF6
        ORI.W  #$5900,(A0)                      ; $11BAF8
        DC.W    $0005,$0217         ; $11BAFC ORI.B  #$0217,D5
        DC.W    $00B9,$02AE,$01CB,$02CC,$03C4; $11BB00 ORI.L  #$02AE01CB,$02CC03C4
        DC.W    $00B7,$01B4,$01CA,$006C; $11BB0A ORI.L  #$01B401CA,$6C(A7,D0.W)
        ORI.W  #$0030,(A3)                      ; $11BB12
        DC.W    $002E,$00BA,$00AF   ; $11BB16 ORI.B  #$00BA,$00AF(A6)
        BSET    D1,(A2)+                        ; $11BB1C
        ORI.W  #$006E,-(A4)                     ; $11BB1E
        DC.W    $0017,$0046         ; $11BB22 ORI.B  #$0046,(A7)
        ORI.W  #$03DA,-(A3)                     ; $11BB26
        ORI.L  #$004D0052,-(A3)                 ; $11BB2A
        DC.W    $00AF,$06C5,$01CA,$03B4; $11BB30 ORI.L  #$06C501CA,$03B4(A7)
        BSET    D2,D4                           ; $11BB38
        DC.W    $01CC               ; $11BB3A BSET    D0,A4
        DC.W    $00CB               ; $11BB3C DC.W    $00CB
        DC.W    $00E0               ; $11BB3E DC.W    $00E0
        BTST    D0,(A7)                         ; $11BB40
        ORI.L  #$005603AE,D7                    ; $11BB42
        ORI.W  #$005B,(A7)                      ; $11BB48
        DC.W    $007D,$00AD         ; $11BB4C ORI.W  #$00AD,<EA:3D>
        BCLR    D2,$00CB(A6)                    ; $11BB50
        DC.W    $04CC               ; $11BB54 DC.W    $04CC
        DC.W    $02C4               ; $11BB56 DC.W    $02C4
        ORI.W  #$00BC,$67(A0,D0.W)              ; $11BB58
        BCLR    D0,-$36(A4,D0.W)                ; $11BB5E
        DC.W    $00C5               ; $11BB62 DC.W    $00C5
        ORI.W  #$004E,$006C(PC)                 ; $11BB64
        BSET    D0,D5                           ; $11BB6A
        DC.W    $00CF               ; $11BB6C DC.W    $00CF
        DC.W    $00DA               ; $11BB6E DC.W    $00DA
        DC.W    $00A9,$004D,$008B,$03DA; $11BB70 ORI.L  #$004D008B,$03DA(A1)
        DC.W    $00A9,$002F,$00A3,$03DA; $11BB78 ORI.L  #$002F00A3,$03DA(A1)
        DC.W    $04E4               ; $11BB80 DC.W    $04E4
        DC.W    $00E5               ; $11BB82 DC.W    $00E5
        DC.W    $00C5               ; $11BB84 DC.W    $00C5
        ORI.W  #$008F,$005F(A1)                 ; $11BB86
        DC.W    $00E6               ; $11BB8C DC.W    $00E6
        BSET    D0,-(A7)                        ; $11BB8E
        DC.W    $00CA               ; $11BB90 DC.W    $00CA
        DC.W    $00CE               ; $11BB92 DC.W    $00CE
        BTST    D0,(A7)                         ; $11BB94
        DC.W    $000F,$0002         ; $11BB96 ORI.B  #$0002,A7
        ADDQ.B  #3,D0                           ; $11BB9A
        ORI.W  #$5900,(A5)                      ; $11BB9C
        DC.W    $0005,$0217         ; $11BBA0 ORI.B  #$0217,D5
        ORI.L  #$0185007D,D6                    ; $11BBA4
        ANDI.L  #$01810080,D3                   ; $11BBAA
        DC.W    $0038,$0139,$0167   ; $11BBB0 ORI.B  #$0139,$0167.W
        ORI.W  #$0051,$0066(A1)                 ; $11BBB6
        ORI.L  #$014C006A,(A4)                  ; $11BBBC
        ORI.L  #$00C502DA,(A7)                  ; $11BBC2
        DC.W    $00AF,$00C2,$002A,$0017; $11BBC8 ORI.L  #$00C2002A,$0017(A7)
        DC.W    $002A,$006B,$03DA   ; $11BBD0 ORI.B  #$006B,$03DA(A2)
        DC.W    $00B1,$0030,$002F,$006B; $11BBD6 ORI.L  #$0030002F,$6B(A1,D0.W)
        DC.W    $04AF,$01C5,$01CA,$03B4; $11BBDE SUBI.L  #$01C501CA,$03B4(A7)
        DC.W    $04C4               ; $11BBE6 DC.W    $04C4
        DC.W    $02CC               ; $11BBE8 DC.W    $02CC
        DC.W    $00CB               ; $11BBEA DC.W    $00CB
        DC.W    $00E0               ; $11BBEC DC.W    $00E0
        BTST    D0,(A7)                         ; $11BBEE
        ORI.L  #$005703AE,-(A1)                 ; $11BBF0
        ORI.W  #$005B,(A7)                      ; $11BBF6
        ORI.L  #$004005E8,(A3)                  ; $11BBFA
        DC.W    $00E9               ; $11BC00 DC.W    $00E9
        DC.W    $04EA               ; $11BC02 DC.W    $04EA
        DC.W    $02C9               ; $11BC04 DC.W    $02C9
        DC.W    $00C4               ; $11BC06 DC.W    $00C4
        DC.W    $00BC,$0067,$03CA,$00C5,$006B; $11BC08 ORI.L  #$006703CA,#$00C5006B
        DC.W    $0037,$00AF,$01E6   ; $11BC12 ORI.B  #$00AF,-$1A(A7,D0.W)
        DC.W    $00E5               ; $11BC18 DC.W    $00E5
        DC.W    $00E4               ; $11BC1A DC.W    $00E4
        ORI.W  #$0049,-(A4)                     ; $11BC1C
        ORI.L  #$03E4008B,(A7)                  ; $11BC20
        ORI.W  #$0064,-(A0)                     ; $11BC26
        BSET    D0,-(A1)                        ; $11BC2A
        DC.W    $00AF,$0597,$0073,$00B6; $11BC2C ORI.L  #$05970073,$00B6(A7)
        ORI.W  #$0023,(A1)                      ; $11BC34
        DC.W    $00A8,$00CA,$01E7,$00CA; $11BC38 ORI.L  #$00CA01E7,$00CA(A0)
        DC.W    $0037,$0020,$0117   ; $11BC40 ORI.B  #$0020,$17(A7,D0.W)
        DC.W    $0019,$5600         ; $11BC46 ORI.B  #$5600,(A1)+
        ORI.W  #$5900,(A2)                      ; $11BC4A
        DC.W    $0005,$0217         ; $11BC4E ORI.B  #$0217,D5
        ORI.L  #$047D0384,D7                    ; $11BC52
        DC.W    $02EB               ; $11BC58 DC.W    $02EB
        DC.W    $01CE               ; $11BC5A BSET    D0,A6
        BCLR    D0,#$00EC                       ; $11BC5C
        DC.W    $00BD,$005F,$006D   ; $11BC60 ORI.L  #$005F006D,<EA:3D>
        DC.W    $02E6               ; $11BC66 DC.W    $02E6
        DC.W    $02E4               ; $11BC68 DC.W    $02E4
        ORI.W  #$002D,$0217(A4)                 ; $11BC6A
        DC.W    $0034,$00C5,$03E4   ; $11BC70 ORI.B  #$00C5,-$1C(A4,D0.W)
        ORI.W  #$0030,-(A3)                     ; $11BC76
        DC.W    $0031,$00A4,$009B   ; $11BC7A ORI.B  #$00A4,-$65(A1,D0.W)
        BCHG    D0,$006A(A0)                    ; $11BC80
        BCHG    D0,(A2)                         ; $11BC84
        BCHG    D0,(A3)                         ; $11BC86
        BCHG    D1,(A7)+                        ; $11BC88
        BCHG    D2,(A5)                         ; $11BC8A
        ANDI.W  #$0085,(A6)                     ; $11BC8C
        BTST    D0,(A7)                         ; $11BC90
        DC.W    $0025,$00A0         ; $11BC92 ORI.B  #$00A0,-(A5)
        BSET    D1,$00C6(A0)                    ; $11BC96
        DC.W    $00DF               ; $11BC9A DC.W    $00DF
        DC.W    $0024,$0093         ; $11BC9C ORI.B  #$0093,-(A4)
        DC.W    $00ED               ; $11BCA0 DC.W    $00ED
        DC.W    $02AD,$0556,$04AA,$0054; $11BCA2 ANDI.L  #$055604AA,$0054(A5)
        DC.W    $00DE               ; $11BCAA DC.W    $00DE
        DC.W    $007F,$03E7         ; $11BCAC ORI.W  #$03E7,<EA:3F>
        DC.W    $00E6               ; $11BCB0 DC.W    $00E6
        ORI.W  #$0053,$00C5(A4)                 ; $11BCB2
        BSET    D0,-(A6)                        ; $11BCB8
        DC.W    $00E5               ; $11BCBA DC.W    $00E5
        DC.W    $00C5               ; $11BCBC DC.W    $00C5
        ORI.W  #$00C2,D5                        ; $11BCBE
        DC.W    $00EE               ; $11BCC2 DC.W    $00EE
        BSET    D1,-(A4)                        ; $11BCC4
        ORI.W  #$0047,-(A1)                     ; $11BCC6
        DC.W    $0149               ; $11BCCA BCHG    D0,A1
        DC.W    $0030,$002F,$0048   ; $11BCCC ORI.B  #$002F,$48(A0,D0.W)
        BCLR    D0,(A2)+                        ; $11BCD2
        DC.W    $002E,$008D,$002F   ; $11BCD4 ORI.B  #$008D,$002F(A6)
        ORI.W  #$0031,$0032(A7)                 ; $11BCDA
        ORI.L  #$006700CA,A5                    ; $11BCE0
        DC.W    $02E7               ; $11BCE6 DC.W    $02E7
        ORI.W  #$0028,$17(A0,D0.W)              ; $11BCE8
        DC.W    $001F,$5600         ; $11BCEE ORI.B  #$5600,(A7)+
        ORI.W  #$5900,A6                        ; $11BCF2
        DC.W    $0005,$0217         ; $11BCF6 ORI.B  #$0217,D5
        ORI.W  #$01E8,$05E9.W                   ; $11BCFA
        DC.W    $03C9               ; $11BD00 BSET    D1,A1
        BSET    D0,D4                           ; $11BD02
        BCLR    D1,-$1A(A7,D0.W)                ; $11BD04
        BSET    D0,-(A4)                        ; $11BD08
        ORI.L  #$00EF0021,(A7)                  ; $11BD0A
        DC.W    $0217,$004E         ; $11BD10 ANDI.B  #$004E,(A7)
        ORI.L  #$03E400C5,(A7)                  ; $11BD14
        ORI.W  #$0044,(A3)                      ; $11BD1A
        ORI.W  #$00A8,D5                        ; $11BD1E
        DC.W    $00F0               ; $11BD22 DC.W    $00F0
        DC.W    $00BD,$00BA,$00F1   ; $11BD24 ORI.L  #$00BA00F1,<EA:3D>
        DC.W    $00C3               ; $11BD2A DC.W    $00C3
        ORI.L  #$008E00A5,(A1)+                 ; $11BD2C
        ORI.W  #$0091,-$6E(A7,D0.W)             ; $11BD32
        DC.W    $0027,$0226         ; $11BD38 ORI.B  #$0226,-(A7)
        BCLR    D0,(A1)                         ; $11BD3C
        ANDI.L  #$00240217,(A3)                 ; $11BD3E
        DC.W    $003C,$04E8,$00C6   ; $11BD44 ORI.B  #$04E8,#$00C6
        DC.W    $00CD               ; $11BD4A DC.W    $00CD
        DC.W    $0024,$0093         ; $11BD4C ORI.B  #$0093,-(A4)
        BCLR    D0,$053E(A4)                    ; $11BD50
        ANDI.L  #$02910126,(A3)                 ; $11BD54
        DC.W    $007F,$03E7         ; $11BD5A ORI.W  #$03E7,<EA:3F>
        DC.W    $00E6               ; $11BD5E DC.W    $00E6
        DC.W    $00C5               ; $11BD60 DC.W    $00C5
        DC.W    $00AF,$02E6,$00E4,$0097; $11BD62 ORI.L  #$02E600E4,$0097(A7)
        ORI.L  #$009C00DA,(A2)+                 ; $11BD6A
        DC.W    $02E4               ; $11BD70 DC.W    $02E4
        ORI.L  #$004D0047,(A7)                  ; $11BD72
        ORI.W  #$0497,$01B1(PC)                 ; $11BD78
        DC.W    $04AF,$00B4,$00CA,$03E7; $11BD7E SUBI.L  #$00B400CA,$03E7(A7)
        DC.W    $00C4               ; $11BD86 DC.W    $00C4
        ORI.L  #$01170012,(A1)                  ; $11BD88
        DC.W    $0003,$5500         ; $11BD8E ORI.B  #$5500,D3
        ORI.W  #$5900,D4                        ; $11BD92
        DC.W    $0005,$0217         ; $11BD96 ORI.B  #$0217,D5
        ORI.W  #$00E8,(A0)+                     ; $11BD9A
        BSET    D2,$04F2(A2)                    ; $11BD9E
        BSET    D1,-(A7)                        ; $11BDA2
        DC.W    $06E6               ; $11BDA4 DC.W    $06E6
        DC.W    $00E4               ; $11BDA6 DC.W    $00E4
        ORI.L  #$00F00022,(A7)                  ; $11BDA8
        DC.W    $0017,$0015         ; $11BDAE ORI.B  #$0015,(A7)
        DC.W    $0014,$0017         ; $11BDB2 ORI.B  #$0017,(A4)
        DC.W    $0022,$0061         ; $11BDB6 ORI.B  #$0061,-(A2)
        DC.W    $00EE               ; $11BDBA DC.W    $00EE
        BSET    D1,-(A4)                        ; $11BDBC
        DC.W    $02C5               ; $11BDBE DC.W    $02C5
        BCLR    D0,$04B7(A7)                    ; $11BDC0
        SUBI.W  #$01AA,$55(A0,D0.W)             ; $11BDC4
        ORI.W  #$00B5,(A6)                      ; $11BDCA
        DC.W    $00BF,$019F,$0087   ; $11BDCE ORI.L  #$019F0087,<EA:3F>
        DC.W    $0217,$005C         ; $11BDD4 ANDI.B  #$005C,(A7)
        BSET    D2,$00C6(A0)                    ; $11BDD8
        ORI.W  #$01A2,D0                        ; $11BDDC
        ORI.W  #$013B,D0                        ; $11BDE0
        BCLR    D0,-(A0)                        ; $11BDE4
        DC.W    $00F3               ; $11BDE6 DC.W    $00F3
        BCLR    D0,(A7)+                        ; $11BDE8
        DC.W    $00BF,$00B5,$0255   ; $11BDEA ORI.L  #$00B50255,<EA:3F>
        DC.W    $00AA,$0070,$00CA,$03E7; $11BDF0 ORI.L  #$007000CA,$03E7(A2)
        DC.W    $00E6               ; $11BDF8 DC.W    $00E6
        DC.W    $04E5               ; $11BDFA DC.W    $04E5
        DC.W    $00E4               ; $11BDFC DC.W    $00E4
        ORI.W  #$002E,-(A3)                     ; $11BDFE
        ORI.L  #$03F40097,(A7)                  ; $11BE02
        BCHG    D0,D7                           ; $11BE08
        ORI.L  #$08F400F5,(A7)                  ; $11BE0A
        BSET    D1,-(A5)                        ; $11BE10
        BSET    D1,-(A7)                        ; $11BE12
        DC.W    $00CA               ; $11BE14 DC.W    $00CA
        DC.W    $00F6               ; $11BE16 DC.W    $00F6
        DC.W    $0217,$0004         ; $11BE18 ANDI.B  #$0004,(A7)
        SUBQ.B  #2,D0                           ; $11BE1C
        DC.W    $003A,$5900,$0005   ; $11BE1E ORI.B  #$5900,$0005(PC)
        DC.W    $0217,$0057         ; $11BE24 ANDI.B  #$0057,(A7)
        DC.W    $00F7               ; $11BE28 DC.W    $00F7
        BSET    D2,$03F9.W                      ; $11BE2A
        DC.W    $04E7               ; $11BE2E DC.W    $04E7
        DC.W    $06E5               ; $11BE30 DC.W    $06E5
        DC.W    $00B1,$0035,$0022,$0017; $11BE32 ORI.L  #$00350022,$17(A1,D0.W)
        DC.W    $0018,$001D         ; $11BE3A ORI.B  #$001D,(A0)+
        DC.W    $000B,$0016         ; $11BE3E ORI.B  #$0016,A3
        DC.W    $002B,$00C2,$0063   ; $11BE42 ORI.B  #$00C2,$0063(A3)
        DC.W    $02F4               ; $11BE48 DC.W    $02F4
        DC.W    $00F5               ; $11BE4A DC.W    $00F5
        BSET    D3,-(A5)                        ; $11BE4C
        DC.W    $06E7               ; $11BE4E DC.W    $06E7
        BSET    D0,$02F202EA                    ; $11BE50
        DC.W    $00E9               ; $11BE56 DC.W    $00E9
        DC.W    $003C,$0217,$0022   ; $11BE58 ORI.B  #$0217,#$0022
        DC.W    $007E,$0BE8         ; $11BE5E ORI.W  #$0BE8,<EA:3E>
        DC.W    $00F7               ; $11BE62 DC.W    $00F7
        DC.W    $04F8               ; $11BE64 DC.W    $04F8
        BSET    D1,$00FA05E7                    ; $11BE66
        DC.W    $04E5               ; $11BE6C DC.W    $04E5
        DC.W    $00F5               ; $11BE6E DC.W    $00F5
        DC.W    $00CF               ; $11BE70 DC.W    $00CF
        DC.W    $0034,$002E,$00AF   ; $11BE72 ORI.B  #$002E,-$51(A4,D0.W)
        DC.W    $02F4               ; $11BE78 DC.W    $02F4
        DC.W    $00DA               ; $11BE7A DC.W    $00DA
        ORI.L  #$00460047,A4                    ; $11BE7C
        DC.W    $00B1,$08F4,$00F5,$03E5; $11BE82 ORI.L  #$08F400F5,-$1B(A1,D0.W)
        DC.W    $04E7               ; $11BE8A DC.W    $04E7
        DC.W    $00DC               ; $11BE8C DC.W    $00DC
        DC.W    $0020,$0117         ; $11BE8E ORI.B  #$0117,-(A0)
        DC.W    $0009,$5500         ; $11BE92 ORI.B  #$5500,A1
        DC.W    $0037,$5900,$0005   ; $11BE96 ORI.B  #$5900,$05(A7,D0.W)
        DC.W    $0217,$0057         ; $11BE9C ANDI.B  #$0057,(A7)
        BSET    D2,$03F9.W                      ; $11BEA0
        DC.W    $00FA               ; $11BEA4 DC.W    $00FA
        DC.W    $04E7               ; $11BEA6 DC.W    $04E7
        BSET    D2,-(A5)                        ; $11BEA8
        DC.W    $00CF               ; $11BEAA DC.W    $00CF
        ORI.W  #$0022,$17(A4,D0.W)              ; $11BEAC
        DC.W    $001A,$0104         ; $11BEB2 ORI.B  #$0104,(A2)+
        DC.W    $0012,$0017         ; $11BEB6 ORI.B  #$0017,(A2)
        DC.W    $0022,$0050         ; $11BEBA ORI.B  #$0050,-(A2)
        DC.W    $00D0               ; $11BEBE DC.W    $00D0
        BSET    D0,-$0B(A4,D0.W)                ; $11BEC0
        BSET    D3,-(A5)                        ; $11BEC4
        BSET    D2,-(A7)                        ; $11BEC6
        DC.W    $00FA               ; $11BEC8 DC.W    $00FA
        DC.W    $04F9               ; $11BECA DC.W    $04F9
        DC.W    $02F8               ; $11BECC DC.W    $02F8
        DC.W    $00EA               ; $11BECE DC.W    $00EA
        DC.W    $003C,$0317,$00B8   ; $11BED0 ORI.B  #$0317,#$00B8
        DC.W    $0CF7               ; $11BED6 DC.W    $0CF7
        DC.W    $04F8               ; $11BED8 DC.W    $04F8
        BSET    D1,$00FA04E7                    ; $11BEDA
        BSET    D2,-(A5)                        ; $11BEE0
        DC.W    $00F5               ; $11BEE2 DC.W    $00F5
        DC.W    $00D0               ; $11BEE4 DC.W    $00D0
        DC.W    $0031,$006B,$03F4   ; $11BEE6 ORI.B  #$006B,-$0C(A1,D0.W)
        DC.W    $00D0               ; $11BEEC DC.W    $00D0
        ORI.W  #$0018,A5                        ; $11BEEE
        ORI.W  #$00B1,D7                        ; $11BEF2
        BSET    #5,-$19(A4,D0.W)                ; $11BEF6
        DC.W    $00C4               ; $11BEFC DC.W    $00C4
        ORI.W  #$0117,-(A5)                     ; $11BEFE
        DC.W    $0010,$0002         ; $11BF02 ORI.B  #$0002,(A0)
        ADDQ.B  #2,D0                           ; $11BF06
        DC.W    $003C,$5900,$0005   ; $11BF08 ORI.B  #$5900,#$0005
        DC.W    $0217,$0057         ; $11BF0E ANDI.B  #$0057,(A7)
        BSET    D2,$03F9.W                      ; $11BF12
        DC.W    $00FA               ; $11BF16 DC.W    $00FA
        DC.W    $04E7               ; $11BF18 DC.W    $04E7
        DC.W    $00E5               ; $11BF1A DC.W    $00E5
        DC.W    $02CF               ; $11BF1C DC.W    $02CF
        ORI.W  #$00FB,-(A3)                     ; $11BF1E
        ORI.W  #$0023,D4                        ; $11BF22
        BTST    D0,(A7)                         ; $11BF26
        DC.W    $0014,$0009         ; $11BF28 ORI.B  #$0009,(A4)
        BTST    D0,D1                           ; $11BF2C
        DC.W    $000A,$0015         ; $11BF2E ORI.B  #$0015,A2
        DC.W    $0017,$0047         ; $11BF32 ORI.B  #$0047,(A7)
        ORI.W  #$00AF,D4                        ; $11BF36
        DC.W    $00CF               ; $11BF3A DC.W    $00CF
        DC.W    $00F5               ; $11BF3C DC.W    $00F5
        BSET    D3,-(A5)                        ; $11BF3E
        BSET    D2,-(A7)                        ; $11BF40
        DC.W    $00FA               ; $11BF42 DC.W    $00FA
        DC.W    $04F9               ; $11BF44 DC.W    $04F9
        BSET    D1,$00FC.W                      ; $11BF46
        BTST    D1,(A7)                         ; $11BF4A
        DC.W    $0021,$00B8         ; $11BF4C ORI.B  #$00B8,-(A1)
        DC.W    $0AF7               ; $11BF50 DC.W    $0AF7
        BSET    D2,$03F9.W                      ; $11BF52
        DC.W    $00FA               ; $11BF56 DC.W    $00FA
        DC.W    $04E7               ; $11BF58 DC.W    $04E7
        BSET    D2,-(A5)                        ; $11BF5A
        DC.W    $00F5               ; $11BF5C DC.W    $00F5
        DC.W    $00B3,$002F,$00B1,$03F4; $11BF5E ORI.L  #$002F00B1,-$0C(A3,D0.W)
        DC.W    $00FD               ; $11BF66 DC.W    $00FD
        ORI.W  #$0018,$0047(A6)                 ; $11BF68
        DC.W    $00B1,$07F4,$00F5,$04E5; $11BF6E ORI.L  #$07F400F5,-$1B(A1,D0.W)
        DC.W    $04E7               ; $11BF76 DC.W    $04E7
        DC.W    $00F9               ; $11BF78 DC.W    $00F9
        DC.W    $00FE               ; $11BF7A DC.W    $00FE
        BTST    D0,(A7)                         ; $11BF7C
        DC.W    $0012,$0003         ; $11BF7E ORI.B  #$0003,(A2)
        ADDQ.B  #2,D0                           ; $11BF82
        ORI.W  #$5900,A5                        ; $11BF84
        DC.W    $0005,$0217         ; $11BF88 ORI.B  #$0217,D5
        DC.W    $00B8,$007C,$0098,$00F6; $11BF8C ORI.L  #$007C0098,$00F6.W
        DC.W    $00B9,$0089,$00BE,$00FF,$0255; $11BF94 ORI.L  #$008900BE,$00FF0255
        DC.W    $00DC               ; $11BF9E DC.W    $00DC
        BCHG    D1,$73(A0,D0.W)                 ; $11BFA0
        DC.W    $00B4,$006A,$00BD,$0035; $11BFA4 ORI.L  #$006A00BD,$35(A4,D0.W)
        DC.W    $002E,$0022,$002B   ; $11BFAC ORI.B  #$0022,$002B(A6)
        DC.W    $0017,$0018         ; $11BFB2 ORI.B  #$0018,(A7)
        DC.W    $0011,$000A         ; $11BFB6 ORI.B  #$000A,(A1)
        DC.W    $0001,$0100         ; $11BFBA ORI.B  #$0100,D1
        DC.W    $0001,$001D         ; $11BFBE ORI.B  #$001D,D1
        DC.W    $0016,$0017         ; $11BFC2 ORI.B  #$0017,(A6)
        ORI.W  #$0034,$0063(A6)                 ; $11BFC6
        DC.W    $00D0               ; $11BFCC DC.W    $00D0
        DC.W    $00CF               ; $11BFCE DC.W    $00CF
        DC.W    $06E5               ; $11BFD0 DC.W    $06E5
        BSET    D2,-(A7)                        ; $11BFD2
        DC.W    $00FA               ; $11BFD4 DC.W    $00FA
        BSET    D1,$04F800FC                    ; $11BFD6
        SUBI.B  #$0022,(A7)                     ; $11BFDC
        DC.W    $00B8,$00D6,$08F7,$05F8; $11BFE0 ORI.L  #$00D608F7,$05F8.W
        BSET    D1,$00FA04E7                    ; $11BFE8
        BSET    D2,-(A5)                        ; $11BFEE
        DC.W    $00CF               ; $11BFF0 DC.W    $00CF
        ORI.W  #$006F,-$30(A4,D0.W)             ; $11BFF2
        DC.W    $02F4               ; $11BFF8 DC.W    $02F4
        DC.W    $00DA               ; $11BFFA DC.W    $00DA
        DC.W    $00B2,$0029,$0018,$0047; $11BFFC ORI.L  #$00290018,$47(A2,D0.W)
        DC.W    $00B1,$00F4,$04DA,$00CF; $11C004 ORI.L  #$00F404DA,-$31(A1,D0.W)
        BSET    D0,(A0)                         ; $11C00C
        BCLR    D0,$00B4(A7)                    ; $11C00E
        ANDI.W  #$0270,-$28(A3,D0.W)            ; $11C012
        ORI.W  #$0084,(A5)                      ; $11C018
        DC.W    $0217,$001E         ; $11C01C ANDI.B  #$001E,(A7)
        ADDQ.B  #2,D0                           ; $11C020
        ORI.W  #$5900,A1                        ; $11C022
        DC.W    $0005,$0C17         ; $11C026 ORI.B  #$0C17,D5
        BTST    D0,-(A0)                        ; $11C02A
        BTST    D0,-(A1)                        ; $11C02C
        DC.W    $0022,$0023         ; $11C02E ORI.B  #$0023,-(A2)
        DC.W    $0028,$0027,$0028   ; $11C032 ORI.B  #$0027,$0028(A0)
        SUBI.B  #$0015,(A7)                     ; $11C038
        DC.W    $001C,$0005         ; $11C03C ORI.B  #$0005,(A4)+
        DC.W    $0001,$0300         ; $11C040 ORI.B  #$0300,D1
        DC.W    $0003,$000E         ; $11C044 ORI.B  #$000E,D3
        BTST    D0,(A7)                         ; $11C048
        DC.W    $002B,$002E,$0033   ; $11C04A ORI.B  #$002E,$0033(A3)
        ORI.L  #$00B400D0,A4                    ; $11C050
        DC.W    $02CF               ; $11C056 DC.W    $02CF
        DC.W    $03CA               ; $11C058 BSET    D1,A2
        BSET    D1,-(A7)                        ; $11C05A
        DC.W    $00FA               ; $11C05C DC.W    $00FA
        BSET    D1,$03F800EA                    ; $11C05E
        DC.W    $00FC               ; $11C064 DC.W    $00FC
        BTST    D2,(A7)                         ; $11C066
        DC.W    $0022,$007B         ; $11C068 ORI.B  #$007B,-(A2)
        ORI.W  #$01D6,D0                        ; $11C06C
        BSET    D2,-$08(A7,D0.W)                ; $11C070
        DC.W    $04F9               ; $11C074 DC.W    $04F9
        BSET    D2,-(A7)                        ; $11C076
        DC.W    $00E5               ; $11C078 DC.W    $00E5
        DC.W    $04CF               ; $11C07A DC.W    $04CF
        DC.W    $00AF,$0036,$008C,$02D0; $11C07C ORI.L  #$0036008C,$02D0(A7)
        DC.W    $00AF,$00A3,$002F,$0118; $11C084 ORI.L  #$00A3002F,$0118(A7)
        ORI.W  #$0062,D7                        ; $11C08C
        DC.W    $00E2               ; $11C090 DC.W    $00E2
        ORI.W  #$0096,-(A2)                     ; $11C092
        ORI.W  #$0050,-(A1)                     ; $11C096
        ORI.W  #$0033,A7                        ; $11C09A
        DC.W    $0031,$002F,$002E   ; $11C09E ORI.B  #$002F,$2E(A1,D0.W)
        ORI.L  #$004C004B,(A0)                  ; $11C0A4
        DC.W    $0023,$0122         ; $11C0AA ORI.B  #$0122,-(A3)
        BTST    D0,-(A1)                        ; $11C0AE
        BTST    D0,-(A0)                        ; $11C0B0
        BTST    D1,(A7)                         ; $11C0B2
        DC.W    $001D,$5400         ; $11C0B4 ORI.B  #$5400,(A5)+
        ORI.W  #$5900,D0                        ; $11C0B8
        DC.W    $0005,$1817         ; $11C0BC ORI.B  #$1817,D5
        DC.W    $0016,$0011         ; $11C0C0 ORI.B  #$0011,(A6)
        DC.W    $001E,$0004         ; $11C0C4 ORI.B  #$0004,(A6)+
        ADDI.B  #$0005,D0                       ; $11C0C8
        DC.W    $0011,$0016         ; $11C0CC ORI.B  #$0016,(A1)
        BTST    D0,(A7)                         ; $11C0D0
        DC.W    $0020,$0023         ; $11C0D2 ORI.B  #$0023,-(A0)
        DC.W    $0030,$00BA,$0035   ; $11C0D6 ORI.B  #$00BA,$35(A0,D0.W)
        DC.W    $0036,$0074,$0043   ; $11C0DC ORI.B  #$0074,$43(A6,D0.W)
        ORI.W  #$0067,-(A6)                     ; $11C0E2
        ORI.W  #$0154,$0155(A2)                 ; $11C0E6
        BCLR    D2,$03AE(A2)                    ; $11C0EC
        DC.W    $007D,$0717         ; $11C0F0 ORI.W  #$0717,<EA:3D>
        DC.W    $0024,$00A1         ; $11C0F4 ORI.B  #$00A1,-(A4)
        ORI.W  #$005A,-$2A(PC,D0.W)             ; $11C0F8
        BCLR    D2,$06DC(A6)                    ; $11C0FE
        BCHG    D0,-$28(A0,D0.W)                ; $11C102
        ORI.W  #$0054,(A7)+                     ; $11C106
        ORI.W  #$00D2,$008C(A2)                 ; $11C10A
        ORI.W  #$0074,D3                        ; $11C110
        ORI.W  #$0034,(A0)                      ; $11C114
        ORI.W  #$0048,A5                        ; $11C118
        ORI.W  #$0048,$004E(A7)                 ; $11C11C
        DC.W    $002D,$0060,$0029   ; $11C122 ORI.B  #$0060,$0029(A5)
        DC.W    $0218,$0047         ; $11C128 ANDI.B  #$0047,(A0)+
        ANDI.W  #$0129,D6                       ; $11C12C
        DC.W    $002A,$0020,$1017   ; $11C130 ORI.B  #$0020,$1017(A2)
        DC.W    $0012,$0003         ; $11C136 ORI.B  #$0003,(A2)
        SUBQ.B  #1,D0                           ; $11C13A
        DC.W    $0032,$5900,$0005   ; $11C13C ORI.B  #$5900,$05(A2,D0.W)
        DC.W    $0016,$1417         ; $11C142 ORI.B  #$1417,(A6)
        DC.W    $0014,$0013         ; $11C146 ORI.B  #$0013,(A4)
        DC.W    $001A,$0008         ; $11C14A ORI.B  #$0008,(A2)+
        DC.W    $0004,$0001         ; $11C14E ORI.B  #$0001,D4
        BTST    #4,D0                           ; $11C152
        DC.W    $001E,$0015         ; $11C156 ORI.B  #$0015,(A6)+
        BTST    D2,(A7)                         ; $11C15A
        BTST    #1,-(A0)                        ; $11C15C
        DC.W    $0022,$0023         ; $11C160 ORI.B  #$0023,-(A2)
        DC.W    $0024,$0027         ; $11C164 ORI.B  #$0027,-(A4)
        DC.W    $0026,$0092         ; $11C168 ORI.B  #$0092,-(A6)
        ORI.L  #$00250317,(A1)                  ; $11C16C
        DC.W    $0012,$0517         ; $11C172 ORI.B  #$0517,(A2)
        DC.W    $00D3               ; $11C176 DC.W    $00D3
        DC.W    $023D,$013E         ; $11C178 ANDI.B  #$013E,<EA:3D>
        BCHG    D0,-$6F(A7,D0.W)                ; $11C17C
        ORI.L  #$00270028,(A2)                  ; $11C180
        DC.W    $0024,$0023         ; $11C186 ORI.B  #$0023,-(A4)
        DC.W    $0022,$0821         ; $11C18A ORI.B  #$0821,-(A2)
        DC.W    $002B,$002A,$0120   ; $11C18E ORI.B  #$002A,$0120(A3)
        DC.W    $0017,$0120         ; $11C194 ORI.B  #$0120,(A7)
        SUBI.B  #$0418,(A7)                     ; $11C198
        MOVE.B  (A7),D3                         ; $11C19C
        DC.W    $0016,$0005         ; $11C19E ORI.B  #$0005,(A6)
        SUBQ.B  #1,D0                           ; $11C1A2
        DC.W    $0030,$5A00,$0905   ; $11C1A4 ORI.B  #$5A00,$05(A0,D0.L)
        DC.W    $0006,$0019         ; $11C1AA ORI.B  #$0019,D6
        BTST    D0,D7                           ; $11C1AE
        DC.W    $001F,$0009         ; $11C1B0 ORI.B  #$0009,(A7)+
        DC.W    $001E,$000A         ; $11C1B4 ORI.B  #$000A,(A6)+
        DC.W    $000B,$001D         ; $11C1B8 ORI.B  #$001D,A3
        DC.W    $000C,$000D         ; $11C1BC ORI.B  #$000D,A4
        DC.W    $001E,$0006         ; $11C1C0 ORI.B  #$0006,(A6)+
        DC.W    $0003,$0002         ; $11C1C4 ORI.B  #$0002,D3
        BTST    D5,D0                           ; $11C1C8
        DC.W    $0003,$0009         ; $11C1CA ORI.B  #$0009,D3
        DC.W    $000F,$0014         ; $11C1CE ORI.B  #$0014,A7
        MOVE.B  (A7),D6                         ; $11C1D2
        DC.W    $0008,$001C         ; $11C1D4 ORI.B  #$001C,A0
        MOVE.L  (A7),D2                         ; $11C1D8
        DC.W    $0218,$0216         ; $11C1DA ANDI.B  #$0216,(A0)+
        DC.W    $0215,$0214         ; $11C1DE ANDI.B  #$0214,(A5)
        DC.W    $0013,$0012         ; $11C1E2 ORI.B  #$0012,(A3)
        DC.W    $0011,$001B         ; $11C1E6 ORI.B  #$001B,(A1)
        DC.W    $000F,$000E         ; $11C1EA ORI.B  #$000E,A7
        DC.W    $000D,$000C         ; $11C1EE ORI.B  #$000C,A5
        DC.W    $000B,$000A         ; $11C1F2 ORI.B  #$000A,A3
        DC.W    $001E,$0009         ; $11C1F6 ORI.B  #$0009,(A6)+
        DC.W    $0008,$001F         ; $11C1FA ORI.B  #$001F,A0
        DC.W    $0007,$0019         ; $11C1FE ORI.B  #$0019,D7
