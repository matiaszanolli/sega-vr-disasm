; Generated assembly for $11E200-$120200
; Branch targets: 68
; Labels: 68
; Format: DC.W with decoded mnemonics as comments

        org     $11E200

        DC.W    $0208,$5300         ; $11E200 ANDI.B  #$5300,A0
        DC.W    $0006,$AE00         ; $11E204 ORI.B  #$AE00,D6
        ADDI.B  #$0501,A0                       ; $11E208
        MOVE.B  D2,D2                           ; $11E20C
        SUBI.B  #$0408,D1                       ; $11E20E
        BCC.W  loc_11E215                       ; $11E212
        MOVE.W  D0,-(A7)                        ; $11E216
        MOVE.W  D0,-(A7)                        ; $11E218
        ORI.L  #$003900C0,-(A7)                 ; $11E21A
        DC.W    $0000,$0C63         ; $11E220 ORI.B  #$0C63,D0
        MOVE.B  D4,(A0)                         ; $11E224
        MOVE.B  -(A5),(A2)                      ; $11E226
        BCHG    #7,D2                           ; $11E228
        SPL     (A6)                            ; $11E22C
        DC.W    $7BDE               ; $11E22E MOVE.W  (A6)+,<EA:3D>
        DC.W    $7FFF               ; $11E230 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.L  $18C6(A1),-(A2)                 ; $11E232
        TST.W  (A2)                             ; $11E236
        CLR.B  (A0)                             ; $11E238
        MOVE.L  A0,-(A0)                        ; $11E23A
        MOVE.L  $318C(A3),$35AD(A6)             ; $11E23C
        NOT.B  -$43(A1,D7.W)                    ; $11E242
        ADDQ.L  #1,(A4)                         ; $11E246
        RTE                                     ; $11E248
        BLS.S  loc_11E264                       ; $11E24A
        BEQ.S  loc_11E287                       ; $11E24C
        SGT     -$32(A7,D3.L)                   ; $11E24E
        ADDQ.L  #3,-$64(A5,D7.W)                ; $11E252
        BLE.S  loc_11E2D3                       ; $11E256
        BMI.S  loc_11E2B4                       ; $11E258
        MOVE.L  A2,$3DEF(A4)                    ; $11E25A
        DC.W    $7FDB               ; $11E25E MOVE.W  (A3)+,<EA:3F>
        MOVE.W  $7FB9(PC),-$48(A7,D7.L)         ; $11E260
        DC.W    $7FFC,$7F98         ; $11E266 MOVE.W  #$7F98,<EA:3F>
        MOVE.W  $69(A5,D7.L),$7668(A7)          ; $11E26A
        MOVEQ   #$48,D3                         ; $11E270
        MOVEQ   #-$54,D7                        ; $11E272
        MOVE.W  (A3),$7F54(A7)                  ; $11E274
        DC.W    $7FFD               ; $11E278 MOVE.W  <EA:3D>,<EA:3F>
        MOVE.W  -$10(A3,D7.L),-(A7)             ; $11E27A
        MOVE.W  (A1),-(A7)                      ; $11E27E
        MOVE.W  (A2),-(A7)                      ; $11E280
        MOVE.W  $55(A2,D7.L),-(A7)              ; $11E282
        MOVE.W  -$69(A6,D7.L),$7FDA(A7)         ; $11E286
        DC.W    $7FFE               ; $11E28C MOVE.W  <EA:3E>,<EA:3F>
        MOVE.W  $34(A7,D7.L),$7B12(A7)          ; $11E28E
        MOVE.W  (A1),-(A5)                      ; $11E294
        MOVEQ   #-$0F,D5                        ; $11E296
        MOVEQ   #-$10,D5                        ; $11E298
        MOVEQ   #-$31,D3                        ; $11E29A
        MOVEQ   #-$32,D3                        ; $11E29C
        MOVEQ   #-$54,D5                        ; $11E29E
        MOVEQ   #$47,D3                         ; $11E2A0
        MOVEQ   #$04,D1                         ; $11E2A2
        MOVEQ   #$25,D3                         ; $11E2A4
        MOVEQ   #$26,D3                         ; $11E2A6
        MOVEQ   #-$33,D7                        ; $11E2A8
        MOVE.W  (A6),$25(A7,D7.W)               ; $11E2AA
        MOVEQ   #$26,D1                         ; $11E2AE
        MOVEQ   #$6A,D3                         ; $11E2B0
        MOVEQ   #-$11,D7                        ; $11E2B2
loc_11E2B4:
        MOVEQ   #-$75,D3                        ; $11E2B4
        MOVEQ   #-$75,D5                        ; $11E2B6
        MOVEQ   #-$53,D7                        ; $11E2B8
        MOVEQ   #$6A,D1                         ; $11E2BA
        MOVEQ   #$69,D1                         ; $11E2BC
        MOVEQ   #$49,D1                         ; $11E2BE
        MOVEQ   #$48,D1                         ; $11E2C0
        MOVEQ   #$27,D1                         ; $11E2C2
        BGT.S  loc_11E2EC                       ; $11E2C4
        BGT.S  loc_11E2CD                       ; $11E2C6
        BGT.S  loc_11E2CE                       ; $11E2C8
        MOVEQ   #-$32,D7                        ; $11E2CA
        MOVEQ   #$04,D3                         ; $11E2CC
loc_11E2CE:
        MOVEQ   #$24,D3                         ; $11E2CE
        MOVE.W  -$76(A7,D7.L),-$76(A7,D7.W)     ; $11E2D0
        MOVEQ   #$6A,D5                         ; $11E2D6
        BGT.S  loc_11E2E0                       ; $11E2D8
        MOVEQ   #-$53,D5                        ; $11E2DA
        DC.W    $7FD9               ; $11E2DC MOVE.W  (A1)+,<EA:3F>
        MOVEQ   #-$55,D7                        ; $11E2DE
loc_11E2E0:
        MOVE.W  (A0),-(A7)                      ; $11E2E0
        MOVEQ   #-$74,D5                        ; $11E2E2
        DC.W    $7FFB,$7EEE         ; $11E2E4 MOVE.W  -$12(PC,D7.L),<EA:3F>
        MOVEQ   #-$54,D3                        ; $11E2E8
        MOVEQ   #$46,D3                         ; $11E2EA
loc_11E2EC:
        MOVEQ   #-$55,D5                        ; $11E2EC
        MOVEQ   #$6B,D1                         ; $11E2EE
        MOVEQ   #-$75,D1                        ; $11E2F0
loc_11E2F2:
        MOVEQ   #-$74,D1                        ; $11E2F2
        MOVEQ   #-$74,D3                        ; $11E2F4
        DC.W    $7FFA,$7224         ; $11E2F6 MOVE.W  $7224(PC),<EA:3F>
        MOVEQ   #$69,D3                         ; $11E2FA
        BGT.S  loc_11E301                       ; $11E2FC
        BGT.S  loc_11E325                       ; $11E2FE
        MOVEQ   #$49,D3                         ; $11E300
loc_11E302:
        MOVEQ   #$05,D1                         ; $11E302
        BLT.S  loc_11E2E9                       ; $11E304
loc_11E306:
        MOVE.W  -(A3),$7247.W                   ; $11E306
        MOVE.W  $46(A4,D7.W),$76AB(A7)          ; $11E30A
loc_11E310:
        MOVEQ   #-$34,D5                        ; $11E310
        MOVEQ   #-$33,D5                        ; $11E312
        MOVEQ   #$68,D1                         ; $11E314
        BGT.S  loc_11E360                       ; $11E316
        BGT.S  loc_11E361                       ; $11E318
        BGT.S  loc_11E343                       ; $11E31A
        BLT.S  loc_11E302                       ; $11E31C
        MOVE.W  $23(A1,D7.W),-(A7)              ; $11E31E
        BVS.S  loc_11E307                       ; $11E322
        BVS.S  loc_11E2E9                       ; $11E324
loc_11E326:
        BVS.S  loc_11E30C                       ; $11E326
loc_11E328:
        MOVEQ   #-$13,D7                        ; $11E328
loc_11E32A:
        MOVEQ   #$27,D3                         ; $11E32A
        MOVE.W  A7,-(A7)                        ; $11E32C
        MOVEQ   #$03,D1                         ; $11E32E
        MOVEQ   #-$32,D5                        ; $11E330
        MOVEQ   #-$31,D5                        ; $11E332
        MOVEQ   #-$11,D5                        ; $11E334
        MOVEQ   #-$53,D3                        ; $11E336
        MOVEQ   #-$77,D5                        ; $11E338
        MOVEQ   #-$34,D7                        ; $11E33A
        MOVEQ   #$68,D5                         ; $11E33C
        MOVE.W  (A1)+,-$3E(A7,D6.L)             ; $11E33E
        BVS.S  loc_11E326                       ; $11E342
        BLT.S  loc_11E328                       ; $11E344
        MOVE.W  -(A2),$7689.W                   ; $11E346
        BGT.S  loc_11E34E                       ; $11E34A
        BLT.S  loc_11E310                       ; $11E34C
loc_11E34E:
        BVS.S  loc_11E2F2                       ; $11E34E
loc_11E350:
        MOVE.W  -(A4),$7E8B.W                   ; $11E350
        MOVEQ   #$05,D3                         ; $11E354
        MOVE.W  D2,$7EAA.W                      ; $11E356
        BLT.S  loc_11E341                       ; $11E35A
        BLT.S  loc_11E321                       ; $11E35C
        MOVEQ   #$47,D5                         ; $11E35E
loc_11E360:
        MOVEQ   #$06,D1                         ; $11E360
loc_11E362:
        BCS.S  loc_11E306                       ; $11E362
        BCS.S  loc_11E329                       ; $11E364
        BCS.S  loc_11E32A                       ; $11E366
        BPL.S  loc_11E36F                       ; $11E368
        BCS.S  loc_11E350                       ; $11E36A
        BVS.S  loc_11E353                       ; $11E36C
        MOVEQ   #-$30,D5                        ; $11E36E
        BCS.S  loc_11E333                       ; $11E370
        BCS.S  loc_11E315                       ; $11E372
        MOVEQ   #-$52,D3                        ; $11E374
        BVS.S  loc_11E339                       ; $11E376
        BPL.S  loc_11E37E                       ; $11E378
        MOVE.W  $52(A6,D7.L),$30(A7,D7.L)       ; $11E37A
        MOVEQ   #$67,D3                         ; $11E380
        DC.W    $7FD8               ; $11E382 MOVE.W  (A0)+,<EA:3F>
        MOVE.W  -$6C(A3,D7.L),$7F95(A7)         ; $11E384
        BVS.S  loc_11E32D                       ; $11E38A
        BCS.S  loc_11E30F                       ; $11E38C
        BVS.S  loc_11E311                       ; $11E38E
        MOVEQ   #$4A,D1                         ; $11E390
        MOVEQ   #-$52,D5                        ; $11E392
        MOVEQ   #$6B,D3                         ; $11E394
        MOVEQ   #-$31,D7                        ; $11E396
        BGT.S  loc_11E3C2                       ; $11E398
        BGT.S  loc_11E3A3                       ; $11E39A
        BVS.S  loc_11E362                       ; $11E39C
        SUBI.B  #$0001,-(A1)                    ; $11E39E
        MOVE.W  D0,-(A7)                        ; $11E3A2
        MOVE.W  D0,-(A7)                        ; $11E3A4
        DC.W    $000A,$D200         ; $11E3A6 ORI.B  #$D200,A2
        DC.W    $0001,$0202         ; $11E3AA ORI.B  #$0202,D1
        DC.W    $0003,$0001         ; $11E3AE ORI.B  #$0001,D3
        BTST    D4,D0                           ; $11E3B2
        DC.W    $0001,$0502         ; $11E3B4 ORI.B  #$0502,D1
        BTST    D0,D0                           ; $11E3B8
        DC.W    $0001,$5200         ; $11E3BA ORI.B  #$5200,D1
        DC.W    $0016,$CF00         ; $11E3BE ORI.B  #$CF00,(A6)
loc_11E3C2:
        DC.W    $0004,$0002         ; $11E3C2 ORI.B  #$0002,D4
        DC.W    $0005,$0006         ; $11E3C6 ORI.B  #$0006,D5
        DC.W    $0007,$0208         ; $11E3CA ORI.B  #$0208,D7
        DC.W    $0006,$0009         ; $11E3CE ORI.B  #$0009,D6
        DC.W    $0005,$0001         ; $11E3D2 ORI.B  #$0001,D5
        ADDI.B  #$0007,D0                       ; $11E3D6
        DC.W    $0508               ; $11E3DA BTST    D2,A0
        DC.W    $0001,$000A         ; $11E3DC ORI.B  #$000A,D1
        DC.W    $0008,$000B         ; $11E3E0 ORI.B  #$000B,A0
        DC.W    $0004,$0100         ; $11E3E4 ORI.B  #$0100,D4
        DC.W    $000C,$0008         ; $11E3E8 ORI.B  #$0008,A4
        DC.W    $4C00               ; $11E3EC DC.W    $4C00
        DC.W    $002B,$6300,$0004   ; $11E3EE ORI.B  #$6300,$0004(A3)
        DC.W    $0003,$0005         ; $11E3F4 ORI.B  #$0005,D3
        DC.W    $010A               ; $11E3F8 BTST    D0,A2
        BTST    D2,D3                           ; $11E3FA
        BTST    D2,D2                           ; $11E3FC
        ADDI.B  #$0304,D1                       ; $11E3FE
        MOVE.L  D0,D5                           ; $11E402
        SUBI.B  #$0401,D4                       ; $11E404
        BTST    D1,D2                           ; $11E408
        BTST    D1,D3                           ; $11E40A
        DC.W    $0005,$000D         ; $11E40C ORI.B  #$000D,D5
        DC.W    $0009,$000E         ; $11E410 ORI.B  #$000E,A1
        DC.W    $000F,$0110         ; $11E414 ORI.B  #$0110,A7
        DC.W    $0001,$0900         ; $11E418 ORI.B  #$0900,D1
        DC.W    $000A,$0011         ; $11E41C ORI.B  #$0011,A2
        DC.W    $0012,$0808         ; $11E420 ORI.B  #$0808,(A2)
        DC.W    $0013,$000F         ; $11E424 ORI.B  #$000F,(A3)
        DC.W    $0001,$0004         ; $11E428 ORI.B  #$0004,D1
        BTST    D1,D0                           ; $11E42C
        DC.W    $0014,$0015         ; $11E42E ORI.B  #$0015,(A4)
        DC.W    $0016,$0108         ; $11E432 ORI.B  #$0108,(A6)
        BTST    D0,(A7)                         ; $11E436
        DC.W    $0004,$000A         ; $11E438 ORI.B  #$000A,D4
        DC.W    $0108               ; $11E43C BTST    D0,A0
        DC.W    $000C,$0000         ; $11E43E ORI.B  #$0000,A4
        DC.W    $0018,$0108         ; $11E442 ORI.B  #$0108,(A0)+
        DC.W    $4C00               ; $11E446 DC.W    $4C00
        ORI.W  #$6000,A4                        ; $11E448
        DC.W    $0004,$000A         ; $11E44C ORI.B  #$000A,D4
        DC.W    $000E,$000C         ; $11E450 ORI.B  #$000C,A6
        DC.W    $0019,$0012         ; $11E454 ORI.B  #$0012,(A1)+
        DC.W    $0B08               ; $11E458 BTST    D5,A0
        DC.W    $0007,$0012         ; $11E45A ORI.B  #$0012,D7
        DC.W    $001A,$001B         ; $11E45E ORI.B  #$001B,(A2)+
        DC.W    $001C,$0116         ; $11E462 ORI.B  #$0116,(A4)+
        DC.W    $0015,$0017         ; $11E466 ORI.B  #$0017,(A5)
        DC.W    $0006,$0019         ; $11E46A ORI.B  #$0019,D6
        DC.W    $0013,$000C         ; $11E46E ORI.B  #$000C,(A3)
        DC.W    $0001,$0200         ; $11E472 ORI.B  #$0200,D1
        DC.W    $0001,$000A         ; $11E476 ORI.B  #$000A,D1
        DC.W    $000E,$000F         ; $11E47A ORI.B  #$000F,A6
        DC.W    $0010,$010F         ; $11E47E ORI.B  #$010F,(A0)
        DC.W    $010E               ; $11E482 BTST    D0,A6
        BTST    D0,(A5)+                        ; $11E484
        DC.W    $0209,$0A0D         ; $11E486 ANDI.B  #$0A0D,A1
        DC.W    $0209,$011D         ; $11E48A ANDI.B  #$011D,A1
        DC.W    $0001,$0200         ; $11E48E ORI.B  #$0200,D1
        DC.W    $0004,$0002         ; $11E492 ORI.B  #$0002,D4
        DC.W    $001D,$001E         ; $11E496 ORI.B  #$001E,(A5)+
        DC.W    $0011,$000B         ; $11E49A ORI.B  #$000B,(A1)
        DC.W    $0014,$0013         ; $11E49E ORI.B  #$0013,(A4)
        DC.W    $0019,$0006         ; $11E4A2 ORI.B  #$0006,(A1)+
        DC.W    $0017,$0015         ; $11E4A6 ORI.B  #$0015,(A7)
        DC.W    $0016,$001C         ; $11E4AA ORI.B  #$001C,(A6)
        DC.W    $001B,$0012         ; $11E4AE ORI.B  #$0012,(A3)+
        DC.W    $0007,$0C08         ; $11E4B2 ORI.B  #$0C08,D7
        DC.W    $0005,$0700         ; $11E4B6 ORI.B  #$0700,D5
        DC.W    $000A,$0018         ; $11E4BA ORI.B  #$0018,A2
        DC.W    $0007,$0C08         ; $11E4BE ORI.B  #$0C08,D7
        DC.W    $0013,$0018         ; $11E4C2 ORI.B  #$0018,(A3)
        DC.W    $0002,$0400         ; $11E4C6 ORI.B  #$0400,D2
        DC.W    $0003,$0008         ; $11E4CA ORI.B  #$0008,D3
        DC.W    $0006,$0200         ; $11E4CE ORI.B  #$0200,D6
        DC.W    $000A,$0008         ; $11E4D2 ORI.B  #$0008,A2
        DC.W    $0007,$0008         ; $11E4D6 ORI.B  #$0008,D7
        DC.W    $001E,$0008         ; $11E4DA ORI.B  #$0008,(A6)+
        DC.W    $0012,$0008         ; $11E4DE ORI.B  #$0008,(A2)
        DC.W    $4C00               ; $11E4E2 DC.W    $4C00
        DC.W    $002F,$5E00,$0001   ; $11E4E4 ORI.B  #$5E00,$0001(A7)
        DC.W    $000A,$0014         ; $11E4EA ORI.B  #$0014,A2
        DC.W    $0015,$1B08         ; $11E4EE ORI.B  #$1B08,(A5)
        DC.W    $0012,$0002         ; $11E4F2 ORI.B  #$0002,(A2)
        DC.W    $0000,$0001         ; $11E4F6 ORI.B  #$0001,D0
        DC.W    $0005,$0013         ; $11E4FA ORI.B  #$0013,D5
        DC.W    $0016,$1B08         ; $11E4FE ORI.B  #$1B08,(A6)
        DC.W    $0009,$0100         ; $11E502 ORI.B  #$0100,A1
        DC.W    $0003,$000C         ; $11E506 ORI.B  #$000C,D3
        DC.W    $0017,$0012         ; $11E50A ORI.B  #$0012,(A7)
        MOVE.B  A0,D5                           ; $11E50E
        DC.W    $0005,$0600         ; $11E510 ORI.B  #$0600,D5
        DC.W    $000E,$0012         ; $11E514 ORI.B  #$0012,A6
        DC.W    $0508               ; $11E518 BTST    D2,A0
        DC.W    $001F,$0020         ; $11E51A ORI.B  #$0020,(A7)+
        DC.W    $0021,$0022         ; $11E51E ORI.B  #$0022,-(A1)
        DC.W    $0023,$0508         ; $11E522 ORI.B  #$0508,-(A3)
        DC.W    $000B,$0002         ; $11E526 ORI.B  #$0002,A3
        BTST    D1,D0                           ; $11E52A
        DC.W    $0003,$0008         ; $11E52C ORI.B  #$0008,D3
        DC.W    $0006,$0200         ; $11E530 ORI.B  #$0200,D6
        DC.W    $000A,$0008         ; $11E534 ORI.B  #$0008,A2
        DC.W    $0014,$000C         ; $11E538 ORI.B  #$000C,(A4)
        DC.W    $0008,$000B         ; $11E53C ORI.B  #$000B,A0
        DC.W    $0011,$0008         ; $11E540 ORI.B  #$0008,(A1)
        DC.W    $4C00               ; $11E544 DC.W    $4C00
        DC.W    $0031,$5C00,$0004   ; $11E546 ORI.B  #$5C00,$04(A1,D0.W)
        DC.W    $0005,$0013         ; $11E54C ORI.B  #$0013,D5
        DC.W    $001A,$1D08         ; $11E550 ORI.B  #$1D08,(A2)+
        DC.W    $0007,$0002         ; $11E554 ORI.B  #$0002,D7
        DC.W    $0003,$0006         ; $11E558 ORI.B  #$0006,D3
        DC.W    $0007,$1D08         ; $11E55C ORI.B  #$1D08,D7
        DC.W    $0009,$0000         ; $11E560 ORI.B  #$0000,A1
        DC.W    $0010,$0016         ; $11E564 ORI.B  #$0016,(A0)
        MOVE.B  A0,-(A6)                        ; $11E568
        DC.W    $0005,$0400         ; $11E56A ORI.B  #$0400,D5
        DC.W    $0004,$000F         ; $11E56E ORI.B  #$000F,D4
        DC.W    $0007,$0308         ; $11E572 ORI.B  #$0308,D7
        DC.W    $0023,$0024         ; $11E576 ORI.B  #$0024,-(A3)
        DC.W    $0025,$0026         ; $11E57A ORI.B  #$0026,-(A5)
        DC.W    $0027,$0128         ; $11E57E ORI.B  #$0128,-(A7)
        DC.W    $0029,$002A,$002B   ; $11E582 ORI.B  #$002A,$002B(A1)
        DC.W    $002C,$0308,$000B   ; $11E588 ORI.B  #$0308,$000B(A4)
        DC.W    $0002,$0200         ; $11E58E ORI.B  #$0200,D2
        DC.W    $0003,$0008         ; $11E592 ORI.B  #$0008,D3
        DC.W    $0006,$0200         ; $11E596 ORI.B  #$0200,D6
        DC.W    $0003,$0008         ; $11E59A ORI.B  #$0008,D3
        DC.W    $0011,$0004         ; $11E59E ORI.B  #$0004,(A1)
        DC.W    $000C,$0001         ; $11E5A2 ORI.B  #$0001,A4
        DC.W    $0018,$0008         ; $11E5A6 ORI.B  #$0008,(A0)+
        DC.W    $4C00               ; $11E5AA DC.W    $4C00
        ORI.W  #$5B00,(A1)                      ; $11E5AC
        DC.W    $0001,$0018         ; $11E5B0 ORI.B  #$0018,D1
        DC.W    $001B,$0608         ; $11E5B4 ORI.B  #$0608,(A3)+
        DC.W    $002D,$002E,$012F   ; $11E5B8 ORI.B  #$002E,$012F(A5)
        DC.W    $0030,$0031,$012D   ; $11E5BE ORI.B  #$0031,$2D(A0,D0.W)
        DC.W    $002A,$002B,$0032   ; $11E5C4 ORI.B  #$002B,$0032(A2)
        DC.W    $0025,$0133         ; $11E5CA ORI.B  #$0133,-(A5)
        BTST    D0,$24(A4,D0.W)                 ; $11E5CE
        DC.W    $0022,$0021         ; $11E5D2 ORI.B  #$0021,-(A2)
        DC.W    $0020,$0035         ; $11E5D6 ORI.B  #$0035,-(A0)
        DC.W    $001F,$0208         ; $11E5DA ORI.B  #$0208,(A7)+
        DC.W    $0007,$0009         ; $11E5DE ORI.B  #$0009,D7
        DC.W    $0006,$1F08         ; $11E5E2 ORI.B  #$1F08,D6
        DC.W    $0011,$000F         ; $11E5E6 ORI.B  #$000F,(A1)
        ADDI.B  #$0036,A0                       ; $11E5EA
        DC.W    $002C,$0023,$011F   ; $11E5EE ORI.B  #$0023,$011F(A4)
        DC.W    $0020,$0021         ; $11E5F4 ORI.B  #$0021,-(A0)
        BTST    D0,-(A4)                        ; $11E5F8
        DC.W    $0037,$0033,$0032   ; $11E5FA ORI.B  #$0033,$32(A7,D0.W)
        DC.W    $002B,$0038,$002D   ; $11E600 ORI.B  #$0038,$002D(A3)
        DC.W    $0039,$003A,$003B,$003C; $11E606 ORI.B  #$003A,$003B003C
        DC.W    $003D,$003E         ; $11E60E ORI.B  #$003E,<EA:3D>
        DC.W    $0038,$0208,$0005   ; $11E612 ORI.B  #$0208,$0005.W
        SUBI.B  #$000F,D0                       ; $11E618
        DC.W    $0012,$0208         ; $11E61C ORI.B  #$0208,(A2)
        DC.W    $002C,$0032,$003F   ; $11E620 ORI.B  #$0032,$003F(A4)
        DC.W    $0028,$0040,$0341   ; $11E626 ORI.B  #$0040,$0341(A0)
        ORI.W  #$0143,D2                        ; $11E62C
        ORI.W  #$002C,D4                        ; $11E630
        DC.W    $0308               ; $11E634 BTST    D1,A0
        DC.W    $000C,$0004         ; $11E636 ORI.B  #$0004,A4
        BTST    D0,D0                           ; $11E63A
        DC.W    $0003,$0008         ; $11E63C ORI.B  #$0008,D3
        DC.W    $0006,$0200         ; $11E640 ORI.B  #$0200,D6
        DC.W    $0003,$0008         ; $11E644 ORI.B  #$0008,D3
        DC.W    $0011,$0200         ; $11E648 ORI.B  #$0200,(A1)
        DC.W    $0018,$0008         ; $11E64C ORI.B  #$0008,(A0)+
        DC.W    $4C00               ; $11E650 DC.W    $4C00
        ORI.W  #$5A00,D4                        ; $11E652
        DC.W    $0002,$0014         ; $11E656 ORI.B  #$0014,D2
        DC.W    $0308               ; $11E65A BTST    D1,A0
        BTST    D0,$45(A6,D0.W)                 ; $11E65C
        DC.W    $013F               ; $11E660 BTST    D0,<EA:3F>
        ORI.W  #$0341,D3                        ; $11E662
        SUBI.W  #$0047,D6                       ; $11E666
        ANDI.W  #$0440,D3                       ; $11E66A
        BTST    D0,$0048(A0)                    ; $11E66E
        DC.W    $0024,$0208         ; $11E672 ORI.B  #$0208,-(A4)
        DC.W    $001C,$0308         ; $11E676 ORI.B  #$0308,(A4)+
        DC.W    $0035,$0049,$044A   ; $11E67A ORI.B  #$0049,$4A(A5,D0.W)
        ORI.W  #$103F,A3                        ; $11E680
        ORI.W  #$0608,A4                        ; $11E684
        DC.W    $002C,$0033,$0148   ; $11E688 ORI.B  #$0033,$0148(A4)
        ORI.W  #$014E,A5                        ; $11E68E
        DC.W    $014F               ; $11E692 BCHG    D0,A7
        ANDI.W  #$0251,(A0)                     ; $11E694
        ANDI.W  #$0353,(A2)                     ; $11E698
        ANDI.W  #$0053,(A4)                     ; $11E69C
        DC.W    $002D,$0208,$000A   ; $11E6A0 ORI.B  #$0208,$000A(A5)
        BTST    D1,D0                           ; $11E6A6
        DC.W    $0003,$0016         ; $11E6A8 ORI.B  #$0016,D3
        DC.W    $0208,$0023         ; $11E6AC ANDI.B  #$0023,A0
        ORI.W  #$0040,(A5)                      ; $11E6B0
        ORI.W  #$0541,D6                        ; $11E6B4
        ANDI.W  #$0057,(A6)                     ; $11E6B8
        DC.W    $0029,$002C,$0208   ; $11E6BC ORI.B  #$002C,$0208(A1)
        DC.W    $0017,$0003         ; $11E6C2 ORI.B  #$0003,(A7)
        BTST    D0,D0                           ; $11E6C6
        DC.W    $0002,$0008         ; $11E6C8 ORI.B  #$0008,D2
        DC.W    $0013,$0200         ; $11E6CC ORI.B  #$0200,(A3)
        DC.W    $0003,$0008         ; $11E6D0 ORI.B  #$0008,D3
        DC.W    $000C,$0200         ; $11E6D4 ORI.B  #$0200,A4
        DC.W    $0018,$0008         ; $11E6D8 ORI.B  #$0008,(A0)+
        DC.W    $4C00               ; $11E6DC DC.W    $4C00
        DC.W    $002E,$5900,$0003   ; $11E6DE ORI.B  #$5900,$0003(A6)
        DC.W    $0013,$0208         ; $11E6E4 ORI.B  #$0208,(A3)
        DC.W    $0023,$0058         ; $11E6E8 ORI.B  #$0058,-(A3)
        ORI.W  #$005A,(A1)+                     ; $11E6EC
        DC.W    $0027,$0256         ; $11E6F0 ORI.B  #$0256,-(A7)
        MOVE.B  D1,$0040(A1)                    ; $11E6F4
        DC.W    $0024,$0508         ; $11E6F8 ORI.B  #$0508,-(A4)
        DC.W    $0033,$002F,$0027   ; $11E6FC ORI.B  #$002F,$27(A3,D0.W)
        ORI.W  #$0541,D3                        ; $11E702
        MOVEA.B (A6),A0                         ; $11E706
        ORI.W  #$0408,A3                        ; $11E708
        DC.W    $0036,$0045,$005B   ; $11E70C ORI.B  #$0045,$5B(A6,D0.W)
        ORI.W  #$0441,(A0)                      ; $11E712
        MOVE.B  (A4),$005C(A0)                  ; $11E716
        DC.W    $002D,$0208,$000A   ; $11E71A ORI.B  #$0208,$000A(A5)
        DC.W    $0200,$0004         ; $11E720 ANDI.B  #$0004,D0
        DC.W    $001E,$0208         ; $11E724 ORI.B  #$0208,(A6)+
        DC.W    $0023,$005D         ; $11E728 ORI.B  #$005D,-(A3)
        ORI.W  #$0741,D6                        ; $11E72C
        SUBI.W  #$0029,(A6)                     ; $11E730
        DC.W    $0023,$0208         ; $11E734 ORI.B  #$0208,-(A3)
        DC.W    $001E,$0004         ; $11E738 ORI.B  #$0004,(A6)+
        SUBQ.B  #5,D0                           ; $11E73C
        DC.W    $002D,$5800,$0003   ; $11E73E ORI.B  #$5800,$0003(A5)
        DC.W    $0019,$0208         ; $11E744 ORI.B  #$0208,(A1)+
        ORI.W  #$005F,(A6)+                     ; $11E748
        DC.W    $0027,$0656         ; $11E74C ORI.B  #$0656,-(A7)
        MOVEA.B D1,A1                           ; $11E750
        ORI.W  #$0024,D0                        ; $11E752
        SUBI.B  #$002D,A0                       ; $11E756
        ORI.W  #$0047,D3                        ; $11E75A
        BCHG    D3,D1                           ; $11E75E
        MOVEA.B (A6),A0                         ; $11E760
        ORI.W  #$0308,A3                        ; $11E762
        DC.W    $0036,$0055,$0040   ; $11E766 ORI.B  #$0055,$40(A6,D0.W)
        ADDI.W  #$1154,D1                       ; $11E76C
        ORI.W  #$002D,(A4)+                     ; $11E770
        DC.W    $0208,$000A         ; $11E774 ANDI.B  #$000A,A0
        DC.W    $0200,$0003         ; $11E778 ANDI.B  #$0003,D0
        DC.W    $0015,$0208         ; $11E77C ORI.B  #$0208,(A5)
        DC.W    $003F,$0541         ; $11E780 ORI.B  #$0541,<EA:3F>
        ORI.W  #$0042,D6                        ; $11E784
        ORI.W  #$0042,D3                        ; $11E788
        ORI.W  #$0356,D1                        ; $11E78C
        ORI.W  #$002E,(A7)                      ; $11E790
        DC.W    $0208,$0017         ; $11E794 ANDI.B  #$0017,A0
        DC.W    $0003,$5B00         ; $11E798 ORI.B  #$5B00,D3
        DC.W    $002D,$5700,$0001   ; $11E79C ORI.B  #$5700,$0001(A5)
        DC.W    $001E,$0208         ; $11E7A2 ORI.B  #$0208,(A6)+
        DC.W    $0022,$0059         ; $11E7A6 ORI.B  #$0059,-(A2)
        ORI.W  #$0856,D2                        ; $11E7AA
        MOVE.B  D1,$0040(A0)                    ; $11E7AE
        DC.W    $0024,$0308         ; $11E7B2 ORI.B  #$0308,-(A4)
        DC.W    $0025,$0043         ; $11E7B6 ORI.B  #$0043,-(A5)
        BCHG    D4,D1                           ; $11E7BA
        MOVEA.B (A6),A0                         ; $11E7BC
        ORI.W  #$0308,A3                        ; $11E7BE
        ORI.W  #$0046,(A5)                      ; $11E7C2
        BCHG    D3,D1                           ; $11E7C6
        MOVE.B  (A4),$005C(A0)                  ; $11E7C8
        DC.W    $002D,$0208,$000A   ; $11E7CC ORI.B  #$0208,$000A(A5)
        BTST    D0,D0                           ; $11E7D2
        DC.W    $0004,$000C         ; $11E7D4 ORI.B  #$000C,D4
        DC.W    $0208,$0035         ; $11E7D8 ANDI.B  #$0035,A0
        ORI.W  #$0441,(A2)+                     ; $11E7DC
        ORI.W  #$005D,D7                        ; $11E7E0
        DC.W    $002F,$0060,$004B   ; $11E7E4 ORI.B  #$0060,$004B(A7)
        ORI.W  #$0356,D3                        ; $11E7EA
        ORI.W  #$004B,(A7)                      ; $11E7EE
        ORI.W  #$0208,(A6)+                     ; $11E7F2
        DC.W    $000F,$5B00         ; $11E7F6 ORI.B  #$5B00,A7
        DC.W    $002E,$5600,$0004   ; $11E7FA ORI.B  #$5600,$0004(A6)
        DC.W    $000D,$0012         ; $11E800 ORI.B  #$0012,A5
        DC.W    $0108               ; $11E804 BTST    D0,A0
        DC.W    $0023,$0026         ; $11E806 ORI.B  #$0026,-(A3)
        ORI.W  #$0A56,(A7)                      ; $11E80A
        MOVEA.B D1,A0                           ; $11E80E
        ORI.W  #$0022,D0                        ; $11E810
        DC.W    $0308               ; $11E814 BTST    D1,A0
        DC.W    $002E,$0046,$0841   ; $11E816 ORI.B  #$0046,$0841(A6)
        MOVE.B  (A6),$004B(A0)                  ; $11E81C
        DC.W    $0208,$0049         ; $11E820 ANDI.B  #$0049,A0
        BCHG    D4,D1                           ; $11E824
        MOVE.B  (A4),$0052(A0)                  ; $11E826
        DC.W    $002D,$0208,$000A   ; $11E82A ORI.B  #$0208,$000A(A5)
        BTST    D0,D0                           ; $11E830
        DC.W    $0001,$0013         ; $11E832 ORI.B  #$0013,D1
        DC.W    $0208,$0061         ; $11E836 ANDI.B  #$0061,A0
        SUBI.W  #$0051,D1                       ; $11E83A
        DC.W    $002F,$002A,$0023   ; $11E83E ORI.B  #$002A,$0023(A7)
        ORI.W  #$002B,-(A2)                     ; $11E844
        ORI.W  #$0046,-(A3)                     ; $11E848
        BCHG    D1,D1                           ; $11E84C
        ORI.W  #$0060,D6                        ; $11E84E
        DC.W    $0208,$0016         ; $11E852 ANDI.B  #$0016,A0
        DC.W    $0002,$5A00         ; $11E856 ORI.B  #$5A00,D2
        DC.W    $003F,$5600         ; $11E85A ORI.B  #$5600,<EA:3F>
        DC.W    $0002,$0019         ; $11E85E ORI.B  #$0019,D2
        DC.W    $0208,$0029         ; $11E862 ANDI.B  #$0029,A0
        DC.W    $0027,$0556         ; $11E866 ORI.B  #$0556,-(A7)
        BCHG    D0,D2                           ; $11E86A
        DC.W    $003F,$025D         ; $11E86C ORI.B  #$025D,<EA:3F>
        DC.W    $033F               ; $11E870 BTST    D1,<EA:3F>
        BCHG    D0,-(A4)                        ; $11E872
        DC.W    $054A               ; $11E874 BCHG    D2,A2
        ANDI.W  #$0148,(A2)+                    ; $11E876
        ORI.W  #$0022,A2                        ; $11E87A
        DC.W    $0208,$0049         ; $11E87E ANDI.B  #$0049,A0
        ORI.W  #$0441,D3                        ; $11E882
        ORI.W  #$0028,D0                        ; $11E886
        BCHG    D5,D0                           ; $11E88A
        BCHG    D3,-(A5)                        ; $11E88C
        ORI.W  #$0066,D0                        ; $11E88E
        DC.W    $0108               ; $11E892 BTST    D0,A0
        DC.W    $002C,$003F,$0441   ; $11E894 ORI.B  #$003F,$0441(A4)
        ORI.W  #$0450,D7                        ; $11E89A
        ANDI.W  #$024E,A7                       ; $11E89E
        DC.W    $034D               ; $11E8A2 BCHG    D1,A5
        BCHG    D0,-(A7)                        ; $11E8A4
        BCHG    D0,$0269(A0)                    ; $11E8A6
        ORI.W  #$0038,$0208(A2)                 ; $11E8AA
        DC.W    $000A,$0100         ; $11E8B0 ORI.B  #$0100,A2
        DC.W    $0005,$0016         ; $11E8B4 ORI.B  #$0016,D5
        DC.W    $0108               ; $11E8B8 BTST    D0,A0
        DC.W    $0034,$004E,$0454   ; $11E8BA ORI.B  #$004E,$54(A4,D0.W)
        ORI.W  #$006B,A2                        ; $11E8C0
        DC.W    $002A,$0160,$0033   ; $11E8C4 ORI.B  #$0160,$0033(A2)
        DC.W    $0025,$0040         ; $11E8CA ORI.B  #$0040,-(A5)
        BCHG    D1,(A4)                         ; $11E8CE
        ORI.W  #$006D,$0022(A4)                 ; $11E8D0
        DC.W    $0208,$000A         ; $11E8D6 ANDI.B  #$000A,A0
        ADDQ.B  #5,D0                           ; $11E8DA
        ORI.W  #$5500,A3                        ; $11E8DC
        DC.W    $0004,$000E         ; $11E8E0 ORI.B  #$000E,D4
        DC.W    $0012,$0108         ; $11E8E4 ORI.B  #$0108,(A2)
        DC.W    $0022,$0059         ; $11E8E8 ORI.B  #$0059,-(A2)
        SUBI.W  #$0042,(A6)                     ; $11E8EC
        ORI.W  #$003F,D0                        ; $11E8F0
        DC.W    $002F,$0062,$015E   ; $11E8F4 ORI.B  #$0062,$015E(A7)
        BTST    D0,$6B(A5,D0.W)                 ; $11E8FA
        BCHG    D1,-(A2)                        ; $11E8FE
        SUBI.B  #$0362,-(A3)                    ; $11E900
        BTST    D0,$08(A5,D0.W)                 ; $11E904
        DC.W    $002C,$006D,$0441   ; $11E908 ORI.B  #$006D,$0441(A4)
        DC.W    $0028,$0033,$0034   ; $11E90E ORI.B  #$0033,$0034(A0)
        BCHG    D1,D5                           ; $11E914
        BTST    D0,$25(A3,D0.L)                 ; $11E916
        DC.W    $0108               ; $11E91A BTST    D0,A0
        DC.W    $002B,$0042,$0241   ; $11E91C ORI.B  #$0042,$0241(A3)
        ORI.W  #$0046,(A4)                      ; $11E922
        ORI.W  #$0045,A1                        ; $11E926
        DC.W    $0234,$0124,$0122   ; $11E92A ANDI.B  #$0124,$22(A4,D0.W)
        BTST    D0,-(A1)                        ; $11E930
        DC.W    $0235,$001F,$0062   ; $11E932 ANDI.B  #$001F,$62(A5,D0.W)
        DC.W    $001F,$0135         ; $11E938 ORI.B  #$0135,(A7)+
        BTST    D0,-(A1)                        ; $11E93C
        DC.W    $0022,$0134         ; $11E93E ORI.B  #$0134,-(A2)
        DC.W    $0023,$0208         ; $11E942 ORI.B  #$0208,-(A3)
        DC.W    $0003,$0000         ; $11E946 ORI.B  #$0000,D3
        DC.W    $0004,$001E         ; $11E94A ORI.B  #$001E,D4
        DC.W    $0208,$004A         ; $11E94E ANDI.B  #$004A,A0
        SUBI.W  #$006F,$002A(A6)                ; $11E952
        DC.W    $0023,$0070         ; $11E958 ORI.B  #$0070,-(A3)
        ORI.W  #$0071,(A4)                      ; $11E95C
        ORI.W  #$0062,A1                        ; $11E960
        DC.W    $002E,$0071,$0272   ; $11E964 ORI.B  #$0071,$0272(A6)
        ORI.W  #$0071,$2D(A3,D0.W)              ; $11E96A
        DC.W    $0208,$000E         ; $11E970 ANDI.B  #$000E,A0
        ADDQ.B  #5,D0                           ; $11E974
        ORI.W  #$5500,A6                        ; $11E976
        DC.W    $0001,$000B         ; $11E97A ORI.B  #$000B,D1
        DC.W    $0208,$0029         ; $11E97E ANDI.B  #$0029,A0
        ORI.W  #$0341,$46(A4,D0.W)              ; $11E982
        ORI.W  #$002B,(A7)+                     ; $11E988
        ORI.W  #$0022,(A6)+                     ; $11E98C
        ORI.W  #$0026,$6D(A5,D0.W)              ; $11E990
        DC.W    $0148               ; $11E996 BCHG    D0,A0
        BCHG    D2,(A2)+                        ; $11E998
        ADDI.W  #$016A,A2                       ; $11E99A
        ORI.W  #$006D,$21(A4,D0.W)              ; $11E99E
        DC.W    $0108               ; $11E9A4 BTST    D0,A0
        DC.W    $0022,$0076         ; $11E9A6 ORI.B  #$0076,-(A2)
        BCHG    D1,(A4)                         ; $11E9AA
        DC.W    $0028,$0045,$0023   ; $11E9AC ORI.B  #$0045,$0023(A0)
        ORI.W  #$0077,(A5)                      ; $11E9B2
        BCHG    D0,-(A6)                        ; $11E9B6
        DC.W    $013F               ; $11E9B8 BTST    D0,<EA:3F>
        ANDI.W  #$0279,$0844.W                  ; $11E9BA
        DC.W    $0079,$0060,$0008,$0023; $11E9C0 ORI.W  #$0060,$00080023
        ORI.W  #$0454,(A2)+                     ; $11E9C8
        ORI.W  #$0062,(A5)                      ; $11E9CC
        DC.W    $002D,$005A,$014E   ; $11E9D0 ORI.B  #$005A,$014E(A5)
        ORI.W  #$007B,$047C(PC)                 ; $11E9D6
        DC.W    $037D               ; $11E9DC BCHG    D1,<EA:3D>
        ADDI.W  #$007D,(A2)                     ; $11E9DE
        DC.W    $0030,$0208,$0003   ; $11E9E2 ORI.B  #$0208,$03(A0,D0.W)
        DC.W    $0000,$0001         ; $11E9E8 ORI.B  #$0001,D0
        DC.W    $000B,$0208         ; $11E9EC ORI.B  #$0208,A3
        ORI.W  #$0472,(A0)                      ; $11E9F0
        DC.W    $0027,$0022         ; $11E9F4 ORI.B  #$0022,-(A7)
        ORI.W  #$007E,A1                        ; $11E9F8
        BCHG    D0,$65(A2,D0.W)                 ; $11E9FC
        DC.W    $002B,$002F,$0041   ; $11EA00 ORI.B  #$002F,$0041(A3)
        ANDI.W  #$0073,$41(A2,D0.W)             ; $11EA06
        ORI.W  #$0208,A1                        ; $11EA0C
        DC.W    $0012,$0003         ; $11EA10 ORI.B  #$0003,(A2)
        SUBQ.B  #4,D0                           ; $11EA14
        ORI.W  #$5500,D1                        ; $11EA16
        DC.W    $0005,$0015         ; $11EA1A ORI.B  #$0015,D5
        DC.W    $0108               ; $11EA1E BTST    D0,A0
        DC.W    $0036,$006D,$0454   ; $11EA20 ORI.B  #$006D,$54(A6,D0.W)
        DC.W    $0027,$005E         ; $11EA26 ORI.B  #$005E,-(A7)
        DC.W    $0021,$002F         ; $11EA2A ORI.B  #$002F,-(A1)
        ORI.W  #$0047,(A1)+                     ; $11EA2E
        MOVE.B  (A4),$0046(A1)                  ; $11EA32
        DC.W    $0034,$0108,$005B   ; $11EA36 ORI.B  #$0108,$5B(A4,D0.W)
        BCHG    D1,(A4)                         ; $11EA3C
        ORI.W  #$007F,$0062(A7)                 ; $11EA3E
        ORI.W  #$0C54,A4                        ; $11EA44
        BCHG    D0,$0480(A4)                    ; $11EA48
        BCHG    D0,$0074(A6)                    ; $11EA4C
        DC.W    $0008,$0021         ; $11EA50 ORI.B  #$0021,A0
        ORI.W  #$026E,D6                        ; $11EA54
        ORI.W  #$0051,$23(A2,D0.W)              ; $11EA58
        DC.W    $002A,$0071,$0581   ; $11EA5E ORI.B  #$0071,$0581(A2)
        DC.W    $0E82               ; $11EA64 DC.W    $0E82
        ORI.L  #$003C0208,D3                    ; $11EA66
        DC.W    $0003,$0000         ; $11EA6C ORI.B  #$0000,D3
        DC.W    $0009,$0012         ; $11EA70 ORI.B  #$0012,A1
        DC.W    $0108               ; $11EA74 BTST    D0,A0
        DC.W    $0031,$007E,$0372   ; $11EA76 ORI.B  #$007E,$72(A1,D0.W)
        ORI.W  #$0075,(A3)                      ; $11EA7C
        DC.W    $0023,$006D         ; $11EA80 ORI.B  #$006D,-(A3)
        ANDI.W  #$0041,$60(A2,D0.W)             ; $11EA84
        ORI.W  #$0040,$72(A5,D0.W)              ; $11EA8A
        BCHG    D0,$65(A3,D0.W)                 ; $11EA90
        DC.W    $0034,$0208,$000A   ; $11EA94 ORI.B  #$0208,$0A(A4,D0.W)
        SUBQ.B  #4,D0                           ; $11EA9A
        DC.W    $003F,$5500         ; $11EA9C ORI.B  #$5500,<EA:3F>
        DC.W    $0010,$0208         ; $11EAA0 ORI.B  #$0208,(A0)
        ORI.L  #$00850472,D4                    ; $11EAA4
        ORI.W  #$005E,(A5)                      ; $11EAAA
        ORI.W  #$0041,(A1)+                     ; $11EAAE
        ORI.W  #$0F72,$026E(A6)                 ; $11EAB2
        BCHG    D0,$71(A2,D0.W)                 ; $11EAB8
        DC.W    $0034,$0108,$0047   ; $11EABC ORI.B  #$0108,$47(A4,D0.W)
        BCHG    D1,$54(A2,D0.W)                 ; $11EAC2
        DC.W    $002F,$0086,$007E   ; $11EAC6 ORI.B  #$0086,$007E(A7)
        BCHG    D6,$73(A2,D0.W)                 ; $11EACC
        BCHG    D1,$47(A2,D0.W)                 ; $11EAD0
        DC.W    $0008,$0022         ; $11EAD4 ORI.B  #$0022,A0
        ORI.W  #$0372,D1                        ; $11EAD8
        ORI.W  #$0021,D7                        ; $11EADC
        ORI.W  #$0072,-$7F(A4,D0.W)             ; $11EAE0
        DC.W    $0E82               ; $11EAE6 DC.W    $0E82
        ORI.L  #$003C0208,D3                    ; $11EAE8
        DC.W    $0003,$0000         ; $11EAEE ORI.B  #$0000,D3
        DC.W    $0010,$0208         ; $11EAF2 ORI.B  #$0208,(A0)
        ORI.W  #$0472,A2                        ; $11EAF6
        ORI.W  #$0025,$63(A1,D0.W)              ; $11EAFA
        ORI.W  #$0272,(A4)                      ; $11EB00
        ORI.W  #$0063,D1                        ; $11EB04
        ORI.W  #$0049,$0041(A3)                 ; $11EB08
        BCHG    D0,$73(A2,D0.W)                 ; $11EB0E
        ORI.W  #$002B,$08(A1,D0.W)              ; $11EB12
        DC.W    $001E,$0004         ; $11EB18 ORI.B  #$0004,(A6)+
        ADDQ.B  #4,D0                           ; $11EB1C
        DC.W    $003A,$5500,$001E   ; $11EB1E ORI.B  #$5500,$001E(PC)
        DC.W    $0208,$0040         ; $11EB24 ANDI.B  #$0040,A0
        SUBI.W  #$0040,$2C(A2,D0.W)             ; $11EB28
        ORI.W  #$0046,D5                        ; $11EB2E
        MOVEA.B $41(A2,D0.W),A3                 ; $11EB32
        DC.W    $0034,$0108,$0047   ; $11EB36 ORI.B  #$0108,$47(A4,D0.W)
        BCHG    D1,$54(A2,D0.W)                 ; $11EB3C
        DC.W    $002F,$0044,$0E72   ; $11EB40 ORI.B  #$0044,$0E72(A7)
        BCHG    D1,$72(A3,D0.W)                 ; $11EB46
        ORI.W  #$0008,D7                        ; $11EB4A
        DC.W    $0022,$0041         ; $11EB4E ORI.B  #$0041,-(A2)
        BCHG    D1,$47(A2,D0.W)                 ; $11EB52
        DC.W    $0022,$0053         ; $11EB56 ORI.B  #$0053,-(A2)
        ORI.W  #$0581,-$7E(A2,D0.L)             ; $11EB5A
        ORI.L  #$003C0208,D3                    ; $11EB60
        DC.W    $0003,$0001         ; $11EB66 ORI.B  #$0001,D3
        DC.W    $000B,$0108         ; $11EB6A ORI.B  #$0108,A3
        DC.W    $0023,$0051         ; $11EB6E ORI.B  #$0051,-(A3)
        ORI.L  #$0372004B,D1                    ; $11EB72
        DC.W    $0022,$004B         ; $11EB78 ORI.B  #$004B,-(A2)
        SUBI.W  #$0047,$75(A2,D0.W)             ; $11EB7C
        ORI.W  #$0040,D5                        ; $11EB82
        BCHG    D0,$73(A2,D0.W)                 ; $11EB86
        ORI.W  #$0044,D1                        ; $11EB8A
        DC.W    $0208,$001A         ; $11EB8E ANDI.B  #$001A,A0
        DC.W    $0002,$5800         ; $11EB92 ORI.B  #$5800,D2
        DC.W    $003C,$5500,$001E   ; $11EB96 ORI.B  #$5500,#$001E
        DC.W    $0208,$0040         ; $11EB9C ANDI.B  #$0040,A0
        BCHG    D0,$73(A2,D0.W)                 ; $11EBA0
        ORI.W  #$0086,D1                        ; $11EBA4
        ORI.W  #$0026,-(A2)                     ; $11EBA8
        MOVE.B  $41(A2,D0.W),$0034(A3)          ; $11EBAC
        DC.W    $0108               ; $11EBB2 BTST    D0,A0
        ORI.W  #$0372,D7                        ; $11EBB4
        ORI.W  #$002F,(A4)                      ; $11EBB8
        ORI.W  #$0E72,D4                        ; $11EBBC
        SUBI.W  #$0272,$47(A3,D0.W)             ; $11EBC0
        DC.W    $0008,$0022         ; $11EBC6 ORI.B  #$0022,A0
        ORI.W  #$0372,D1                        ; $11EBCA
        ORI.W  #$0022,D7                        ; $11EBCE
        ORI.W  #$0072,(A3)                      ; $11EBD2
        ADDI.L  #$0D820083,D1                   ; $11EBD6
        DC.W    $003C,$0208,$0003   ; $11EBDC ORI.B  #$0208,#$0003
        DC.W    $0009,$0208         ; $11EBE2 ORI.B  #$0208,A1
        ORI.W  #$007E,-(A0)                     ; $11EBE6
        ORI.L  #$02720054,D1                    ; $11EBEA
        DC.W    $0031,$0034,$0028   ; $11EBF0 ORI.B  #$0034,$28(A1,D0.W)
        SUBI.W  #$0041,$44(A2,D0.W)             ; $11EBF6
        DC.W    $0035,$004B,$0073   ; $11EBFC ORI.B  #$004B,$73(A5,D0.W)
        ORI.W  #$0273,$43(A2,D0.W)              ; $11EC02
        DC.W    $0035,$0108,$0007   ; $11EC08 ORI.B  #$0108,$07(A5,D0.W)
        DC.W    $000A,$5800         ; $11EC0E ORI.B  #$5800,A2
        DC.W    $003E,$5500         ; $11EC12 ORI.B  #$5500,<EA:3E>
        DC.W    $001E,$0208         ; $11EC16 ORI.B  #$0208,(A6)+
        ORI.W  #$0172,D0                        ; $11EC1A
        BCHG    D0,$43(A3,D0.W)                 ; $11EC1E
        DC.W    $0023,$002B         ; $11EC22 ORI.B  #$002B,-(A3)
        ORI.W  #$0572,$41(A1,D0.L)              ; $11EC26
        BCHG    D2,(A4)                         ; $11EC2C
        DC.W    $027E,$0046         ; $11EC2E ANDI.W  #$0046,<EA:3E>
        DC.W    $0034,$0108,$0047   ; $11EC32 ORI.B  #$0108,$47(A4,D0.W)
        BCHG    D1,$54(A2,D0.W)                 ; $11EC38
        DC.W    $002F,$0044,$0D72   ; $11EC3C ORI.B  #$0044,$0D72(A7)
        BCHG    D2,$72(A3,D0.W)                 ; $11EC42
        ORI.W  #$0008,D7                        ; $11EC46
        DC.W    $0022,$0041         ; $11EC4A ORI.B  #$0041,-(A2)
        BCHG    D1,$47(A2,D0.W)                 ; $11EC4E
        DC.W    $0022,$0053         ; $11EC52 ORI.B  #$0053,-(A2)
        ORI.W  #$0A81,-$7D(A2,D0.L)             ; $11EC56
        ORI.W  #$002F,(A3)                      ; $11EC5C
        DC.W    $0208,$0003         ; $11EC60 ANDI.B  #$0003,A0
        DC.W    $000E,$0208         ; $11EC64 ORI.B  #$0208,A6
        ORI.W  #$0072,(A5)+                     ; $11EC68
        ORI.L  #$02720047,D1                    ; $11EC6C
        DC.W    $002B,$0049,$0054   ; $11EC72 ORI.B  #$0049,$0054(A3)
        BCHG    D2,$47(A2,D0.W)                 ; $11EC78
        ORI.W  #$0055,D5                        ; $11EC7C
        ORI.L  #$00720273,D7                    ; $11EC80
        ORI.W  #$0034,D6                        ; $11EC86
        DC.W    $0208,$0014         ; $11EC8A ANDI.B  #$0014,A0
        DC.W    $0001,$5700         ; $11EC8E ORI.B  #$5700,D1
        ORI.W  #$5500,A6                        ; $11EC92
        DC.W    $001E,$0208         ; $11EC96 ORI.B  #$0208,(A6)+
        ORI.W  #$0072,D0                        ; $11EC9A
        ANDI.W  #$0043,$23(A3,D0.W)             ; $11EC9E
        ORI.W  #$0572,(A7)+                     ; $11ECA4
        DC.W    $0028,$007F,$0431   ; $11ECA8 ORI.B  #$007F,$0431(A0)
        DC.W    $017F               ; $11ECAE BCHG    D0,<EA:3F>
        BTST    D1,$0231(A5)                    ; $11ECB0
        DC.W    $022F,$0031,$002C   ; $11ECB4 ANDI.B  #$0031,$002C(A7)
        DC.W    $0108               ; $11ECBA BTST    D0,A0
        ORI.W  #$0372,D7                        ; $11ECBC
        ORI.W  #$002F,(A4)                      ; $11ECC0
        ORI.W  #$0472,D4                        ; $11ECC4
        ORI.W  #$0066,$3F(A1,D0.W)              ; $11ECC8
        BCHG    D4,-(A6)                        ; $11ECCE
        ORI.W  #$0066,A3                        ; $11ECD0
        DC.W    $023F,$0049         ; $11ECD4 ANDI.B  #$0049,<EA:3F>
        DC.W    $0008,$0022         ; $11ECD8 ORI.B  #$0022,A0
        ORI.W  #$0372,D1                        ; $11ECDC
        ORI.W  #$0022,D7                        ; $11ECE0
        ORI.W  #$0072,(A3)                      ; $11ECE4
        ANDI.L  #$007E0064,D1                   ; $11ECE8
        DC.W    $0079,$0388,$0189,$018A; $11ECEE ORI.W  #$0388,$0189018A
        DC.W    $023C,$022F,$0030   ; $11ECF6 ANDI.B  #$022F,#$0030
        DC.W    $0031,$0035,$0208   ; $11ECFC ORI.B  #$0035,$08(A1,D0.W)
        DC.W    $000D,$0017         ; $11ED02 ORI.B  #$0017,A5
        DC.W    $0108               ; $11ED06 BTST    D0,A0
        DC.W    $0021,$0050         ; $11ED08 ORI.B  #$0050,-(A1)
        BCLR    D0,D1                           ; $11ED0C
        BCHG    D0,$7E(A2,D0.W)                 ; $11ED0E
        ORI.L  #$00350088,A0                    ; $11ED12
        DC.W    $007E,$0572         ; $11ED18 ORI.W  #$0572,<EA:3E>
        ORI.W  #$0045,D6                        ; $11ED1C
        ORI.W  #$0040,-(A2)                     ; $11ED20
        ORI.W  #$0373,$59(A2,D0.W)              ; $11ED24
        DC.W    $0208,$0016         ; $11ED2A ANDI.B  #$0016,A0
        DC.W    $0001,$5700         ; $11ED2E ORI.B  #$5700,D1
        ORI.W  #$5500,A0                        ; $11ED32
        DC.W    $001E,$0208         ; $11ED36 ORI.B  #$0208,(A6)+
        ORI.W  #$0072,D0                        ; $11ED3A
        ANDI.W  #$0043,$23(A3,D0.W)             ; $11ED3E
        DC.W    $0034,$0046,$0472   ; $11ED44 ORI.B  #$0046,$72(A4,D0.W)
        ORI.W  #$003F,D7                        ; $11ED4A
        DC.W    $0029,$0444,$0049   ; $11ED4E ORI.B  #$0444,$0049(A1)
        ORI.W  #$0C08,(A6)+                     ; $11ED54
        ORI.W  #$0372,D7                        ; $11ED58
        ORI.W  #$002F,(A4)                      ; $11ED5C
        ORI.W  #$0472,D4                        ; $11ED60
        ORI.W  #$007F,D7                        ; $11ED64
        DC.W    $0031,$092A,$0075   ; $11ED68 ORI.B  #$092A,$75(A1,D0.W)
        DC.W    $0036,$0408,$0022   ; $11ED6E ORI.B  #$0408,$22(A6,D0.W)
        ORI.W  #$0372,D1                        ; $11ED74
        ORI.W  #$0022,D7                        ; $11ED78
        ORI.W  #$0072,(A3)                      ; $11ED7C
        ANDI.L  #$00530021,D1                   ; $11ED80
        DC.W    $0031,$028A,$0089   ; $11ED86 ORI.B  #$028A,-$77(A1,D0.W)
        DC.W    $0388               ; $11ED8C BCLR    D1,A0
        DC.W    $038B               ; $11ED8E BCLR    D1,A3
        BCHG    D0,-(A4)                        ; $11ED90
        ORI.W  #$0064,$0033(A2)                 ; $11ED92
        DC.W    $0208,$001D         ; $11ED98 ANDI.B  #$001D,A0
        DC.W    $0208,$002B         ; $11ED9C ANDI.B  #$002B,A0
        ORI.W  #$0181,(A3)                      ; $11EDA0
        BCHG    D0,$54(A2,D0.W)                 ; $11EDA4
        ORI.W  #$002A,-(A0)                     ; $11EDA8
        ORI.W  #$0772,D7                        ; $11EDAC
        DC.W    $0026,$0035         ; $11EDB0 ORI.B  #$0035,-(A6)
        DC.W    $0027,$0072         ; $11EDB4 ORI.B  #$0072,-(A7)
        BCHG    D1,$47(A3,D0.W)                 ; $11EDB8
        DC.W    $002C,$0108,$001B   ; $11EDBC ORI.B  #$0108,$001B(A4)
        DC.W    $0005,$5700         ; $11EDC2 ORI.B  #$5700,D5
        DC.W    $003F,$5500         ; $11EDC6 ORI.B  #$5500,<EA:3F>
        DC.W    $001E,$0208         ; $11EDCA ORI.B  #$0208,(A6)+
        ORI.W  #$0072,D0                        ; $11EDCE
        BCHG    D1,$29(A3,D0.W)                 ; $11EDD2
        ORI.W  #$008C,-(A2)                     ; $11EDD6
        CMPI.W  #$0054,$40(A2,D0.W)             ; $11EDDA
        ORI.W  #$0063,(A2)+                     ; $11EDE0
        DC.W    $0036,$0908,$0047   ; $11EDE4 ORI.B  #$0908,$47(A6,D0.W)
        BCHG    D1,$54(A2,D0.W)                 ; $11EDEA
        DC.W    $002F,$0044,$0572   ; $11EDEE ORI.B  #$0044,$0572(A7)
        BCHG    D5,D1                           ; $11EDF4
        ORI.W  #$0035,D3                        ; $11EDF6
        SUBI.B  #$0022,A0                       ; $11EDFA
        ORI.W  #$0372,D1                        ; $11EDFE
        ORI.W  #$0022,D7                        ; $11EE02
        ORI.W  #$0072,(A3)                      ; $11EE06
        ANDI.L  #$00530021,D1                   ; $11EE0A
        ORI.W  #$0283,(A1)                      ; $11EE10
        BCLR    D5,D1                           ; $11EE14
        ORI.L  #$003B0208,D3                    ; $11EE16
        DC.W    $001E,$0208         ; $11EE1C ORI.B  #$0208,(A6)+
        ORI.L  #$007E0181,A2                    ; $11EE20
        BCHG    D0,$47(A2,D0.W)                 ; $11EE26
        DC.W    $002B,$002E,$0054   ; $11EE2A ORI.B  #$002E,$0054(A3)
        BCHG    D3,$47(A2,D0.W)                 ; $11EE30
        ORI.W  #$0086,(A6)+                     ; $11EE34
        ORI.W  #$0373,D1                        ; $11EE38
        ORI.W  #$0045,D6                        ; $11EE3C
        DC.W    $0208,$0014         ; $11EE40 ANDI.B  #$0014,A0
        DC.W    $0001,$5600         ; $11EE44 ORI.B  #$5600,D1
        DC.W    $003B,$5500,$000F   ; $11EE48 ORI.B  #$5500,$0F(PC,D0.W)
        DC.W    $0208,$0028         ; $11EE4E ANDI.B  #$0028,A0
        ORI.W  #$0373,$43(A2,D0.W)              ; $11EE52
        ORI.W  #$0034,$0046(A3)                 ; $11EE58
        BCHG    D7,$40(A2,D0.W)                 ; $11EE5E
        DC.W    $002F,$0808,$0047   ; $11EE62 ORI.B  #$0808,$0047(A7)
        BCHG    D1,$54(A2,D0.W)                 ; $11EE68
        DC.W    $002F,$0079,$0D72   ; $11EE6C ORI.B  #$0079,$0D72(A7)
        BCHG    D1,$71(A3,D0.W)                 ; $11EE72
        DC.W    $0035,$0408,$0022   ; $11EE76 ORI.B  #$0408,$22(A5,D0.W)
        ORI.W  #$0372,D1                        ; $11EE7C
        ORI.W  #$0022,D7                        ; $11EE80
        ORI.W  #$0072,(A3)                      ; $11EE84
        ANDI.L  #$00530021,D1                   ; $11EE88
        ORI.W  #$0081,(A2)                      ; $11EE8E
        BCLR    D6,D2                           ; $11EE92
        ORI.L  #$003B0508,D3                    ; $11EE94
        DC.W    $0033,$0047,$0281   ; $11EE9A ORI.B  #$0047,-$7F(A3,D0.W)
        ORI.W  #$007E,-$78(A2,D0.W)             ; $11EEA0
        DC.W    $0035,$0079,$007E   ; $11EEA6 ORI.B  #$0079,$7E(A5,D0.W)
        BCHG    D3,$71(A2,D0.W)                 ; $11EEAC
        ORI.W  #$0023,$65(A5,D0.W)              ; $11EEB0
        SUBI.W  #$0026,$08(A3,D0.W)             ; $11EEB6
        DC.W    $0006,$0001         ; $11EEBC ORI.B  #$0001,D6
        ADDQ.B  #3,D0                           ; $11EEC0
        DC.W    $003C,$5500,$0005   ; $11EEC2 ORI.B  #$5500,#$0005
        DC.W    $0015,$0108         ; $11EEC8 ORI.B  #$0108,(A5)
        DC.W    $0031,$0041,$0473   ; $11EECC ORI.B  #$0041,$73(A1,D0.W)
        ORI.L  #$0035008D,A5                    ; $11EED2
        ORI.W  #$0073,D6                        ; $11EED8
        DC.W    $0E72               ; $11EEDC DC.W    $0E72
        ORI.W  #$0060,D6                        ; $11EEDE
        DC.W    $0035,$0608,$0047   ; $11EEE2 ORI.B  #$0608,$47(A5,D0.W)
        BCHG    D1,$54(A2,D0.W)                 ; $11EEE8
        DC.W    $002F,$0079,$0D72   ; $11EEEC ORI.B  #$0079,$0D72(A7)
        BCHG    D1,$71(A3,D0.W)                 ; $11EEF2
        DC.W    $0035,$0408,$0022   ; $11EEF6 ORI.B  #$0408,$22(A5,D0.W)
        ORI.W  #$0372,D1                        ; $11EEFC
        ORI.W  #$0022,D7                        ; $11EF00
        ORI.W  #$0072,(A3)                      ; $11EF04
        ANDI.L  #$00530021,D1                   ; $11EF08
        ORI.W  #$0081,(A2)                      ; $11EF0E
        BCLR    D6,D2                           ; $11EF12
        ORI.L  #$003B0508,D3                    ; $11EF14
        DC.W    $002B,$0054,$0281   ; $11EF1A ORI.B  #$0054,$0281(A3)
        ORI.W  #$0054,$49(A2,D0.W)              ; $11EF20
        DC.W    $002A,$0047,$0972   ; $11EF26 ORI.B  #$0047,$0972(A2)
        DC.W    $0027,$0023         ; $11EF2C ORI.B  #$0023,-(A7)
        DC.W    $0026,$0473         ; $11EF30 ORI.B  #$0473,-(A6)
        ORI.W  #$0208,D3                        ; $11EF34
        DC.W    $001A,$001D         ; $11EF38 ORI.B  #$001D,(A2)+
        ADDQ.B  #3,D0                           ; $11EF3C
        DC.W    $003F,$5500         ; $11EF3E ORI.B  #$5500,<EA:3F>
        DC.W    $0001,$0013         ; $11EF42 ORI.B  #$0013,D1
        DC.W    $0208,$008E         ; $11EF46 ANDI.B  #$008E,A0
        SUBI.W  #$0040,$45(A3,D0.W)             ; $11EF4A
        ORI.W  #$002A,(A6)+                     ; $11EF50
        ORI.W  #$0046,(A1)+                     ; $11EF54
        DC.W    $0E72               ; $11EF58 DC.W    $0E72
        ORI.W  #$0040,(A4)                      ; $11EF5A
        DC.W    $002A,$0508,$0047   ; $11EF5E ORI.B  #$0508,$0047(A2)
        BCHG    D1,$54(A2,D0.W)                 ; $11EF64
        DC.W    $002F,$0079,$0D72   ; $11EF68 ORI.B  #$0079,$0D72(A7)
        BCHG    D1,$71(A3,D0.W)                 ; $11EF6E
        DC.W    $0035,$0408,$0022   ; $11EF72 ORI.B  #$0408,$22(A5,D0.W)
        ORI.W  #$0372,D1                        ; $11EF78
        ORI.W  #$0022,D7                        ; $11EF7C
        ORI.W  #$0072,(A3)                      ; $11EF80
        ANDI.L  #$00530021,D1                   ; $11EF84
        ORI.W  #$0081,(A2)                      ; $11EF8A
        BCLR    D6,D2                           ; $11EF8E
        ORI.L  #$003B0408,D3                    ; $11EF90
        DC.W    $002C,$003F,$0083   ; $11EF96 ORI.B  #$003F,$0083(A4)
        ANDI.L  #$00720050,D1                   ; $11EF9C
        DC.W    $0034,$0031,$0054   ; $11EFA2 ORI.B  #$0031,$54(A4,D0.W)
        BCHG    D4,$47(A2,D0.W)                 ; $11EFA8
        DC.W    $0023,$0025         ; $11EFAC ORI.B  #$0025,-(A3)
        ORI.W  #$0373,D6                        ; $11EFB0
        ORI.W  #$0031,D1                        ; $11EFB4
        DC.W    $0208,$000C         ; $11EFB8 ANDI.B  #$000C,A0
        DC.W    $0004,$5500         ; $11EFBC ORI.B  #$5500,D4
        ORI.W  #$5500,D0                        ; $11EFC0
        DC.W    $0004,$0010         ; $11EFC4 ORI.B  #$0010,D4
        DC.W    $0208,$0025         ; $11EFC8 ANDI.B  #$0025,A0
        ORI.W  #$0373,-$79(A1,D0.W)             ; $11EFCC
        DC.W    $0028,$0063,$0022   ; $11EFD2 ORI.B  #$0063,$0022(A0)
        ORI.W  #$0045,(A6)+                     ; $11EFD8
        DC.W    $0026,$0647         ; $11EFDC ORI.B  #$0647,-(A6)
        ORI.W  #$0772,$46(A1,D0.W)              ; $11EFE0
        DC.W    $0031,$0408,$0047   ; $11EFE6 ORI.B  #$0408,$47(A1,D0.W)
        BCHG    D1,$54(A2,D0.W)                 ; $11EFEC
        DC.W    $002F,$0049,$0047   ; $11EFF0 ORI.B  #$0049,$0047(A7)
        MOVEA.B D6,A0                           ; $11EFF6
        ORI.W  #$0062,D0                        ; $11EFF8
        SUBI.B  #$0022,A0                       ; $11EFFC
        ORI.W  #$0372,D1                        ; $11F000
        ORI.W  #$0022,D7                        ; $11F004
        ORI.W  #$0072,(A3)                      ; $11F008
        ANDI.L  #$00530021,D1                   ; $11F00C
        ORI.W  #$0953,$0482(A5)                 ; $11F012
        ORI.L  #$003B0408,D3                    ; $11F018
        ORI.L  #$00530381,A7                    ; $11F01E
        ORI.W  #$004A,$22(A2,D0.W)              ; $11F024
        ORI.W  #$0A72,(A2)+                     ; $11F02A
        ORI.W  #$0049,D1                        ; $11F02E
        ORI.W  #$0047,-(A2)                     ; $11F032
        BCHG    D1,$72(A3,D0.W)                 ; $11F036
        DC.W    $0028,$0208,$0014   ; $11F03A ORI.B  #$0208,$0014(A0)
        DC.W    $0001,$5500         ; $11F040 ORI.B  #$5500,D1
        ORI.W  #$5600,D3                        ; $11F044
        DC.W    $000A,$001C         ; $11F048 ORI.B  #$001C,A2
        DC.W    $0108               ; $11F04C BTST    D0,A0
        DC.W    $002C,$008E,$0573   ; $11F04E ORI.B  #$008E,$0573(A4)
        ORI.W  #$0040,D1                        ; $11F054
        ORI.L  #$00230162,A5                    ; $11F058
        BCHG    D2,$0025(A3)                    ; $11F05E
        DC.W    $0027,$0047         ; $11F062 ORI.B  #$0047,-(A7)
        DC.W    $007E,$0572         ; $11F066 ORI.W  #$0572,<EA:3E>
        ORI.W  #$0031,$08(A1,D0.W)              ; $11F06A
        ORI.W  #$0372,D7                        ; $11F070
        ORI.W  #$002A,(A4)                      ; $11F074
        DC.W    $0023,$0735         ; $11F078 ORI.B  #$0735,-(A3)
        EORI.W  #$0508,$0022(A3)                ; $11F07C
        ORI.W  #$0372,D1                        ; $11F082
        ORI.W  #$0022,D7                        ; $11F086
        ORI.W  #$0072,(A3)                      ; $11F08A
        ANDI.L  #$0053002C,D1                   ; $11F08E
        DC.W    $0035,$0821,$0025   ; $11F094 ORI.B  #$0821,$25(A5,D0.W)
        ORI.W  #$0390,(A4)                      ; $11F09A
        ORI.L  #$003B0408,D1                    ; $11F09E
        DC.W    $0025,$0054         ; $11F0A4 ORI.B  #$0054,-(A5)
        BCLR    D1,(A1)                         ; $11F0A8
        ORI.W  #$0049,$25(A2,D0.W)              ; $11F0AA
        ORI.W  #$0492,(A3)                      ; $11F0B0
        ORI.W  #$0046,D7                        ; $11F0B4
        SUBI.L  #$00400062,(A2)                 ; $11F0B8
        ORI.L  #$03930092,A4                    ; $11F0BE
        ORI.W  #$0036,D0                        ; $11F0C4
        DC.W    $0208,$000E         ; $11F0C8 ANDI.B  #$000E,A0
        SUBQ.B  #2,D0                           ; $11F0CC
        ORI.W  #$5600,A2                        ; $11F0CE
        DC.W    $0001,$0018         ; $11F0D2 ORI.B  #$0018,D1
        DC.W    $0208,$0075         ; $11F0D6 ANDI.B  #$0075,A0
        ORI.L  #$04730272,D7                    ; $11F0DA
        ORI.W  #$0143,D7                        ; $11F0E0
        SUBI.W  #$0055,D7                       ; $11F0E4
        BCHG    D0,$0023(A3)                    ; $11F0E8
        ORI.W  #$006D,-(A0)                     ; $11F0EC
        ORI.W  #$0472,(A4)                      ; $11F0F0
        ORI.W  #$0308,-(A6)                     ; $11F0F4
        ORI.W  #$0372,D7                        ; $11F0F8
        ORI.W  #$007F,(A4)                      ; $11F0FC
        ORI.W  #$0947,-(A0)                     ; $11F100
        BCHG    D3,D3                           ; $11F104
        ORI.L  #$00620408,A6                    ; $11F106
        DC.W    $0022,$0041         ; $11F10C ORI.B  #$0041,-(A2)
        BCLR    D1,(A2)                         ; $11F110
        ORI.W  #$0022,D7                        ; $11F112
        ORI.W  #$0092,(A4)                      ; $11F116
        ANDI.L  #$00530021,(A1)                 ; $11F11A
        ORI.W  #$0452,(A2)+                     ; $11F120
        ORI.W  #$0153,(A4)+                     ; $11F124
        ORI.L  #$00340054,(A4)                  ; $11F128
        BCLR    D1,(A0)                         ; $11F12E
        ORI.L  #$003C0308,D1                    ; $11F130
        DC.W    $0023,$0051         ; $11F136 ORI.B  #$0051,-(A3)
        ANDI.L  #$01910074,(A0)                 ; $11F13A
        ORI.W  #$002A,-(A2)                     ; $11F140
        ORI.W  #$0392,(A4)                      ; $11F144
        ORI.W  #$002C,$34(A6,D0.W)              ; $11F148
        ORI.W  #$0392,$0042(A4)                 ; $11F14E
        ORI.W  #$0022,-(A2)                     ; $11F154
        ORI.W  #$0293,$0192(A4)                 ; $11F158
        ORI.W  #$0208,D4                        ; $11F15E
        DC.W    $0010,$5500         ; $11F162 ORI.B  #$5500,(A0)
        ORI.W  #$5700,D7                        ; $11F166
        DC.W    $0003,$001E         ; $11F16A ORI.B  #$001E,D3
        DC.W    $0108               ; $11F16E BTST    D0,A0
        ORI.W  #$005F,-(A2)                     ; $11F170
        ORI.L  #$03930B92,D7                    ; $11F174
        ORI.W  #$0040,D6                        ; $11F17A
        DC.W    $007F,$0034         ; $11F17E ORI.W  #$0034,<EA:3F>
        DC.W    $0023,$0063         ; $11F182 ORI.B  #$0063,-(A3)
        ORI.L  #$03920041,(A5)                  ; $11F186
        DC.W    $002A,$0208,$0046   ; $11F18C ORI.B  #$0208,$0046(A2)
        BCLR    D1,(A2)                         ; $11F192
        ORI.W  #$002F,$0079(A6)                 ; $11F194
        BCLR    D6,(A2)                         ; $11F19A
        BCLR    D1,(A3)                         ; $11F19C
        ORI.L  #$00350408,D7                    ; $11F19E
        DC.W    $0022,$0087         ; $11F1A4 ORI.B  #$0087,-(A2)
        BCLR    D1,(A2)                         ; $11F1A8
        ORI.W  #$0022,D6                        ; $11F1AA
        ORI.W  #$0096,(A4)                      ; $11F1AE
        ANDI.L  #$00540021,(A0)                 ; $11F1B2
        ORI.W  #$0790,(A3)                      ; $11F1B8
        ORI.W  #$0034,(A3)                      ; $11F1BC
        DC.W    $007E,$0390         ; $11F1C0 ORI.W  #$0390,<EA:3E>
        ORI.L  #$003C0308,D1                    ; $11F1C4
        DC.W    $0035,$007E,$0497   ; $11F1CA ORI.B  #$007E,-$69(A5,D0.W)
        ORI.W  #$0022,$43(A0,D0.W)              ; $11F1D0
        SUBI.L  #$00430008,(A6)                 ; $11F1D6
        DC.W    $0035,$0098,$0496   ; $11F1DC ORI.B  #$0098,-$6A(A5,D0.W)
        ORI.L  #$0022009A,(A1)+                 ; $11F1E2
        ANDI.L  #$01960028,(A3)+                ; $11F1E8
        DC.W    $0023,$0108         ; $11F1EE ORI.B  #$0108,-(A3)
        DC.W    $0014,$0004         ; $11F1F2 ORI.B  #$0004,(A4)
        ADDQ.B  #2,D0                           ; $11F1F6
        ORI.W  #$5800,A4                        ; $11F1F8
        DC.W    $0005,$001B         ; $11F1FC ORI.B  #$001B,D5
        DC.W    $0108               ; $11F200 BTST    D0,A0
        ORI.W  #$009C,-(A2)                     ; $11F202
        ORI.W  #$0293,$0C92(A4)                 ; $11F206
        ORI.L  #$00730043,(A6)                  ; $11F20C
        DC.W    $002A,$005E,$0043   ; $11F212 ORI.B  #$005E,$0043(A2)
        BCLR    D1,(A6)                         ; $11F218
        ORI.L  #$0059002C,(A2)                  ; $11F21A
        DC.W    $0108               ; $11F220 BTST    D0,A0
        ORI.W  #$0396,$72(A1,D0.W)              ; $11F222
        ORI.W  #$003F,-(A0)                     ; $11F228
        ORI.L  #$09960092,(A2)                  ; $11F22C
        BCLR    D0,(A6)                         ; $11F232
        BCLR    D1,(A3)+                        ; $11F234
        ORI.W  #$0035,$08(A3,D0.W)              ; $11F236
        DC.W    $0022,$0073         ; $11F23C ORI.B  #$0073,-(A2)
        BCLR    D1,(A6)                         ; $11F240
        ORI.W  #$0022,$7E(A1,D0.W)              ; $11F242
        ORI.L  #$00900197,(A6)                  ; $11F248
        DC.W    $007E,$0021         ; $11F24E ORI.W  #$0021,<EA:3E>
        ORI.L  #$07970053,(A5)+                 ; $11F252
        DC.W    $0034,$007E,$0397   ; $11F258 ORI.B  #$007E,-$69(A4,D0.W)
        ORI.L  #$003C0308,D2                    ; $11F25E
        DC.W    $002F,$009E,$0397   ; $11F264 ORI.B  #$009E,$0397(A7)
        ORI.L  #$00310034,(A6)+                 ; $11F26A
        DC.W    $007E,$0496         ; $11F270 ORI.W  #$0496,<EA:3E>
        DC.W    $0028,$0008,$0035   ; $11F274 ORI.B  #$0008,$0035(A0)
        ORI.L  #$04960040,(A2)+                 ; $11F27A
        ORI.W  #$0044,$0073(A3)                 ; $11F280
        BCLR    D0,(A3)+                        ; $11F286
        BCLR    D0,(A6)                         ; $11F288
        ORI.W  #$002E,$08(A3,D0.W)              ; $11F28A
        DC.W    $0005,$5400         ; $11F290 ORI.B  #$5400,D5
        ORI.W  #$5800,D3                        ; $11F294
        DC.W    $0004,$0010         ; $11F298 ORI.B  #$0010,D4
        DC.W    $0208,$002C         ; $11F29C ANDI.B  #$002C,A0
        ORI.W  #$009F,D4                        ; $11F2A0
        BCLR    D0,(A3)+                        ; $11F2A4
        BCLR    D7,(A6)                         ; $11F2A6
        ORI.L  #$0062002F,D5                    ; $11F2A8
        ORI.W  #$0396,-$68(A3,D0.W)             ; $11F2AE
        DC.W    $0034,$0108,$0071   ; $11F2B4 ORI.B  #$0108,$71(A4,D0.W)
        BCLR    D1,(A6)                         ; $11F2BA
        ORI.L  #$0060003F,(A6)+                 ; $11F2BC
        BCLR    D6,(A6)                         ; $11F2C2
        BCLR    D1,(A3)+                        ; $11F2C4
        ORI.W  #$0035,$08(A3,D0.W)              ; $11F2C6
        DC.W    $0022,$0073         ; $11F2CC ORI.B  #$0073,-(A2)
        BCLR    D1,(A6)                         ; $11F2D0
        ORI.W  #$0022,$7E(A1,D0.W)              ; $11F2D2
        ORI.L  #$00900197,(A6)                  ; $11F2D8
        DC.W    $007E,$0021         ; $11F2DE ORI.W  #$0021,<EA:3E>
        ORI.L  #$07970053,(A5)+                 ; $11F2E2
        DC.W    $0034,$007E,$0397   ; $11F2E8 ORI.B  #$007E,-$69(A4,D0.W)
        ORI.L  #$003C0308,D2                    ; $11F2EE
        ORI.L  #$04970071,-(A0)                 ; $11F2F4
        ORI.W  #$0088,-(A2)                     ; $11F2FA
        ORI.L  #$03960098,(A6)+                 ; $11F2FE
        DC.W    $0025,$0108         ; $11F304 ORI.B  #$0108,-(A5)
        ORI.W  #$0073,(A5)                      ; $11F308
        BCLR    D1,(A6)                         ; $11F30C
        ORI.W  #$0125,-$68(A1,D0.W)             ; $11F30E
        SUBI.L  #$004C0208,(A6)                 ; $11F314
        DC.W    $001D,$5400         ; $11F31A ORI.B  #$5400,(A5)+
        ORI.W  #$5500,D5                        ; $11F31E
        DC.W    $0004,$0203         ; $11F322 ORI.B  #$0203,D4
        DC.W    $001D,$000B         ; $11F326 ORI.B  #$000B,(A5)+
        DC.W    $0308               ; $11F32A BTST    D1,A0
        ORI.W  #$008E,$0041(A3)                 ; $11F32C
        MOVE.B  (A6),(A0)                       ; $11F332
        ORI.W  #$0045,-(A3)                     ; $11F334
        ORI.W  #$0396,D3                        ; $11F338
        ORI.W  #$0037,$08(A3,D0.W)              ; $11F33C
        ORI.W  #$0396,-$62(A1,D0.W)             ; $11F342
        ORI.W  #$003F,-(A0)                     ; $11F348
        MOVE.B  (A6),$73(A0,D0.W)               ; $11F34C
        DC.W    $0035,$0408,$0022   ; $11F350 ORI.B  #$0408,$22(A5,D0.W)
        ORI.W  #$0396,$71(A3,D0.W)              ; $11F356
        DC.W    $0022,$007E         ; $11F35C ORI.B  #$007E,-(A2)
        ORI.L  #$00900197,(A6)                  ; $11F360
        DC.W    $007E,$0021         ; $11F366 ORI.W  #$0021,<EA:3E>
        ORI.L  #$07A10053,(A5)+                 ; $11F36A
        DC.W    $0034,$0083,$03A1   ; $11F370 ORI.B  #$0083,-$5F(A4,D0.W)
        ORI.L  #$003C0208,-(A2)                 ; $11F376
        DC.W    $0023,$009D         ; $11F37C ORI.B  #$009D,-(A3)
        SUBI.L  #$004F0035,-(A1)                ; $11F380
        ORI.W  #$0490,$71(A1,D0.W)              ; $11F386
        DC.W    $0208,$0033         ; $11F38C ANDI.B  #$0033,A0
        ORI.L  #$00900296,(A0)+                 ; $11F390
        ORI.L  #$00660045,(A0)                  ; $11F396
        ORI.W  #$0490,D7                        ; $11F39C
        ORI.W  #$0021,$08(A4,D0.W)              ; $11F3A0
        DC.W    $0017,$0001         ; $11F3A6 ORI.B  #$0001,(A7)
        SUBQ.B  #1,D0                           ; $11F3AA
        ORI.W  #$5500,D5                        ; $11F3AC
        DC.W    $0010,$0A08         ; $11F3B0 ORI.B  #$0A08,(A0)
        DC.W    $0022,$0026         ; $11F3B4 ORI.B  #$0026,-(A2)
        ORI.W  #$0073,D3                        ; $11F3B8
        BCLR    D6,(A6)                         ; $11F3BC
        DC.W    $0028,$0062,$0060   ; $11F3BE ORI.B  #$0062,$0060(A0)
        ORI.W  #$0296,$72(A2,D0.W)              ; $11F3C4
        DC.W    $0037,$0108,$0071   ; $11F3CA ORI.B  #$0108,$71(A7,D0.W)
        ORI.L  #$02900082,(A6)                  ; $11F3D0
        ORI.W  #$003F,-(A0)                     ; $11F3D6
        BCLR    D2,(A0)                         ; $11F3DA
        ORI.L  #$0A720071,D1                    ; $11F3DC
        DC.W    $0035,$0408,$0022   ; $11F3E2 ORI.B  #$0408,$22(A5,D0.W)
        ORI.W  #$0390,$71(A2,D0.W)              ; $11F3E8
        DC.W    $0022,$007E         ; $11F3EE ORI.B  #$007E,-(A2)
        BCLR    D0,-(A3)                        ; $11F3F2
        BCLR    D0,-(A1)                        ; $11F3F4
        ORI.L  #$0021005C,D3                    ; $11F3F6
        BCLR    D0,-(A3)                        ; $11F3FC
        BCLR    D2,-(A1)                        ; $11F3FE
        ORI.L  #$003400A5,-(A4)                 ; $11F400
        BCLR    D1,-(A1)                        ; $11F406
        ORI.L  #$003C0208,-(A2)                 ; $11F408
        ORI.W  #$04A1,A5                        ; $11F40E
        ORI.L  #$013500A6,-(A6)                 ; $11F412
        BCLR    D0,-(A3)                        ; $11F418
        ANDI.L  #$006D0208,(A0)                 ; $11F41A
        DC.W    $0021,$0047         ; $11F420 ORI.B  #$0047,-(A1)
        SUBI.L  #$005A0023,(A0)                 ; $11F424
        ORI.W  #$0072,-(A0)                     ; $11F42A
        BCLR    D1,(A0)                         ; $11F42E
        ORI.W  #$0031,$08(A2,D0.W)              ; $11F430
        DC.W    $0003,$5300         ; $11F436 ORI.B  #$5300,D3
        ORI.W  #$5500,A4                        ; $11F43A
        DC.W    $001E,$0D08         ; $11F43E ORI.B  #$0D08,(A6)+
        DC.W    $0031,$024B,$0066   ; $11F442 ORI.B  #$024B,$66(A1,D0.W)
        BTST    D1,$0026(A1)                    ; $11F448
        ORI.L  #$03900081,D2                    ; $11F44C
        ORI.W  #$0060,A1                        ; $11F452
        ORI.L  #$02900072,D1                    ; $11F456
        DC.W    $0037,$0108,$0053   ; $11F45C ORI.B  #$0108,$53(A7,D0.W)
        BCLR    D1,(A0)                         ; $11F462
        ORI.L  #$0060003F,D2                    ; $11F464
        SUBI.L  #$00530060,(A0)                 ; $11F46A
        BTST    D2,$2D(A1,D0.W)                 ; $11F470
        DC.W    $022A,$002B,$0036   ; $11F474 ANDI.B  #$002B,$0036(A2)
        SUBI.B  #$0022,A0                       ; $11F47A
        ORI.L  #$03900053,D1                    ; $11F47E
        DC.W    $0022,$0083         ; $11F484 ORI.B  #$0083,-(A2)
        BCLR    D0,-(A3)                        ; $11F488
        BCLR    D0,-(A1)                        ; $11F48A
        ORI.L  #$0021002F,D3                    ; $11F48C
        ORI.L  #$008B00A4,A1                    ; $11F492
        SUBI.L  #$00A40034,-(A1)                ; $11F498
        ORI.L  #$03A100A2,-(A5)                 ; $11F49E
        DC.W    $003C,$0208,$00A4   ; $11F4A4 ORI.B  #$0208,#$00A4
        SUBI.L  #$00A40062,-(A1)                ; $11F4AA
        ORI.W  #$02A3,A6                        ; $11F4B0
        BCLR    D0,(A0)                         ; $11F4B4
        ORI.W  #$0035,(A3)                      ; $11F4B6
        DC.W    $0308               ; $11F4BA BTST    D1,A0
        DC.W    $007F,$0072         ; $11F4BC ORI.W  #$0072,<EA:3F>
        BCLR    D1,(A0)                         ; $11F4C0
        DC.W    $007E,$002F         ; $11F4C2 ORI.W  #$002F,<EA:3E>
        DC.W    $002A,$0072,$0390   ; $11F4C6 ORI.B  #$0072,$0390(A2)
        ORI.L  #$002E0208,D1                    ; $11F4CC
        DC.W    $0009,$5300         ; $11F4D2 ORI.B  #$5300,A1
        ORI.W  #$5500,(A0)+                     ; $11F4D6
        DC.W    $001E,$0208         ; $11F4DA ORI.B  #$0208,(A6)+
        ORI.W  #$0534,(A6)+                     ; $11F4DE
        ORI.W  #$0233,D5                        ; $11F4E2
        DC.W    $002B,$002A,$002D   ; $11F4E6 ORI.B  #$002A,$002D(A3)
        BTST    D1,$7F(A1,D0.W)                 ; $11F4EC
        DC.W    $002F,$005D,$0081   ; $11F4F0 ORI.B  #$005D,$0081(A7)
        BCLR    D1,(A0)                         ; $11F4F6
        ORI.L  #$00490060,D1                    ; $11F4F8
        ORI.L  #$02900081,D1                    ; $11F4FE
        DC.W    $0037,$0108,$0053   ; $11F504 ORI.B  #$0108,$53(A7,D0.W)
        BCLR    D1,(A0)                         ; $11F50A
        ORI.L  #$0060003F,D2                    ; $11F50C
        SUBI.L  #$00720048,(A0)                 ; $11F512
        DC.W    $014A               ; $11F518 BCHG    D0,A2
        BCHG    #8,(A2)+                        ; $11F51A
        ORI.W  #$014A,(A2)+                     ; $11F51E
        DC.W    $0079,$0036,$0008,$0022; $11F522 ORI.W  #$0036,$00080022
        ORI.L  #$03900053,D1                    ; $11F52A
        DC.W    $0022,$0083         ; $11F530 ORI.B  #$0083,-(A2)
        BCLR    D0,-(A3)                        ; $11F534
        BCLR    D0,-(A1)                        ; $11F536
        ORI.L  #$0068018B,-(A3)                 ; $11F538
        ORI.W  #$00A6,$04A1(A2)                 ; $11F53E
        ORI.L  #$003400A5,-(A4)                 ; $11F544
        BCLR    D1,-(A1)                        ; $11F54A
        ORI.L  #$003C0108,-(A2)                 ; $11F54C
        DC.W    $0033,$0083,$03A1   ; $11F552 ORI.B  #$0083,-$5F(A3,D0.W)
        ORI.L  #$005D0062,-(A3)                 ; $11F558
        ORI.L  #$02A30190,-(A4)                 ; $11F55E
        ORI.L  #$00450123,D3                    ; $11F564
        DC.W    $002C,$0023,$002E   ; $11F56A ORI.B  #$0023,$002E(A4)
        ORI.W  #$0390,$72(A2,D0.W)              ; $11F570
        ORI.W  #$0045,(A5)+                     ; $11F576
        ORI.W  #$0490,(A1)                      ; $11F57A
        ORI.W  #$0024,$08(A1,D0.W)              ; $11F57E
        DC.W    $0016,$0002         ; $11F584 ORI.B  #$0002,(A6)
        ADDQ.B  #1,D0                           ; $11F588
        ORI.W  #$5500,D0                        ; $11F58A
        DC.W    $001E,$0208         ; $11F58E ORI.B  #$0208,(A6)+
        DC.W    $0028,$1072,$0281   ; $11F592 ORI.B  #$1072,$0281(A0)
        SUBI.L  #$00500035,(A0)                 ; $11F598
        DC.W    $002F,$0081,$0290   ; $11F59E ORI.B  #$0081,$0290(A7)
        ORI.L  #$00330108,D1                    ; $11F5A4
        ORI.W  #$0390,(A3)                      ; $11F5AA
        ORI.L  #$0060003F,D2                    ; $11F5AE
        MOVE.B  (A0),$7E(A2,D0.W)               ; $11F5B4
        DC.W    $0023,$0008         ; $11F5B8 ORI.B  #$0008,-(A3)
        DC.W    $0024,$0081         ; $11F5BC ORI.B  #$0081,-(A4)
        BCLR    D1,(A0)                         ; $11F5C0
        ORI.W  #$0022,(A3)                      ; $11F5C2
        ORI.L  #$01A302A1,D3                    ; $11F5C6
        BCLR    D1,-(A3)                        ; $11F5CC
        BCLR    D2,-(A1)                        ; $11F5CE
        ORI.L  #$00340083,-(A4)                 ; $11F5D0
        BCLR    D1,-(A1)                        ; $11F5D6
        ORI.L  #$00A70108,-(A3)                 ; $11F5D8
        ORI.W  #$04A1,A5                        ; $11F5DE
        ORI.L  #$0022002B,D3                    ; $11F5E2
        ORI.L  #$02A30290,D3                    ; $11F5E8
        ORI.L  #$017E0154,D3                    ; $11F5EE
        ORI.W  #$0590,$4B(A2,D0.W)              ; $11F5F4
        ORI.W  #$0060,$0072(A3)                 ; $11F5FA
        BCLR    D1,(A0)                         ; $11F600
        ORI.W  #$0025,$08(A2,D0.W)              ; $11F602
        DC.W    $0012,$0002         ; $11F608 ORI.B  #$0002,(A2)
        ADDQ.B  #1,D0                           ; $11F60C
        DC.W    $0034,$5500,$001E   ; $11F60E ORI.B  #$5500,$1E(A4,D0.W)
        DC.W    $0208,$0047         ; $11F614 ANDI.B  #$0047,A0
        MOVE.B  (A0),(A4)                       ; $11F618
        DC.W    $0079,$0034,$0047,$0390; $11F61A ORI.W  #$0034,$00470390
        ORI.L  #$00330108,D1                    ; $11F622
        ORI.W  #$0390,(A3)                      ; $11F628
        ORI.L  #$0060003F,D2                    ; $11F62C
        MOVE.B  (A0),$7E(A2,D0.W)               ; $11F632
        DC.W    $0023,$0008         ; $11F636 ORI.B  #$0008,-(A3)
        DC.W    $0024,$0081         ; $11F63A ORI.B  #$0081,-(A4)
        BCLR    D1,(A0)                         ; $11F63E
        ORI.W  #$0022,(A3)                      ; $11F640
        ORI.L  #$01A30CA1,D3                    ; $11F644
        ORI.L  #$00340083,-(A4)                 ; $11F64A
        BCLR    D1,-(A1)                        ; $11F650
        ORI.L  #$00A70008,-(A3)                 ; $11F652
        DC.W    $002D,$0083,$04A1   ; $11F658 ORI.B  #$0083,$04A1(A5)
        ORI.W  #$0022,(A2)                      ; $11F65E
        ORI.W  #$03A3,(A0)                      ; $11F662
        DC.W    $0E90               ; $11F666 DC.W    $0E90
        DC.W    $007E,$017F         ; $11F668 ORI.W  #$017F,<EA:3E>
        DC.W    $007E,$0390         ; $11F66C ORI.W  #$0390,<EA:3E>
        ORI.L  #$00490208,D1                    ; $11F670
        DC.W    $000F,$5200         ; $11F676 ORI.B  #$5200,A7
        DC.W    $003A,$5500,$001E   ; $11F67A ORI.B  #$5500,$001E(PC)
        DC.W    $0208,$0047         ; $11F680 ANDI.B  #$0047,A0
        MOVE.B  (A0),$52(A3,D0.W)               ; $11F684
        DC.W    $0023,$0031         ; $11F688 ORI.B  #$0031,-(A3)
        ORI.L  #$0390007E,D1                    ; $11F68C
        DC.W    $0034,$0108,$0053   ; $11F692 ORI.B  #$0108,$53(A4,D0.W)
        BCLR    D1,(A0)                         ; $11F698
        ORI.L  #$0060003F,D2                    ; $11F69A
        MOVE.B  (A0),$7E(A2,D0.W)               ; $11F6A0
        DC.W    $0023,$0008         ; $11F6A4 ORI.B  #$0008,-(A3)
        DC.W    $0024,$0081         ; $11F6A8 ORI.B  #$0081,-(A4)
        BCLR    D1,(A0)                         ; $11F6AC
        ORI.W  #$0022,(A3)                      ; $11F6AE
        ORI.L  #$01A30CA1,D3                    ; $11F6B2
        ORI.L  #$00340083,-(A4)                 ; $11F6B8
        BCLR    D1,-(A1)                        ; $11F6BE
        ORI.L  #$00A70008,-(A3)                 ; $11F6C0
        ORI.L  #$00A303A1,A3                    ; $11F6C6
        ORI.L  #$00310062,D1                    ; $11F6CC
        ORI.W  #$02A3,(A2)                      ; $11F6D2
        BCLR    D0,(A0)                         ; $11F6D6
        ORI.L  #$0C900072,D1                    ; $11F6D8
        ORI.W  #$0022,A1                        ; $11F6DE
        ORI.W  #$0490,$0053(A5)                 ; $11F6E2
        DC.W    $001F,$0108         ; $11F6E8 ORI.B  #$0108,(A7)+
        DC.W    $0017,$0002         ; $11F6EC ORI.B  #$0002,(A7)
        SUBQ.B  #8,D0                           ; $11F6F0
        DC.W    $003B,$5500,$0018   ; $11F6F2 ORI.B  #$5500,$18(PC,D0.W)
        DC.W    $0208,$0047         ; $11F6F8 ANDI.B  #$0047,A0
        MOVE.B  (A0),-$7E(A2,D0.W)              ; $11F6FC
        ORI.W  #$002F,(A4)                      ; $11F700
        DC.W    $0035,$0047,$0490   ; $11F704 ORI.B  #$0047,-$70(A5,D0.W)
        ORI.W  #$002C,A0                        ; $11F70A
        DC.W    $0108               ; $11F70E BTST    D0,A0
        ORI.W  #$0390,(A3)                      ; $11F710
        ORI.L  #$00600049,D2                    ; $11F714
        MOVE.B  (A0),$7E(A2,D0.W)               ; $11F71A
        DC.W    $0023,$0008         ; $11F71E ORI.B  #$0008,-(A3)
        DC.W    $0021,$0054         ; $11F722 ORI.B  #$0054,-(A1)
        BCLR    D1,(A0)                         ; $11F726
        ORI.W  #$0021,(A3)                      ; $11F728
        ORI.W  #$01A3,(A4)+                     ; $11F72C
        CMPI.L  #$00A40034,-(A1)                ; $11F730
        ORI.L  #$03A100A3,D3                    ; $11F736
        ORI.L  #$0021004F,A1                    ; $11F73C
        ORI.L  #$03A1007D,-(A3)                 ; $11F742
        DC.W    $0033,$0079,$03A3   ; $11F748 ORI.B  #$0079,-$5D(A3,D0.W)
        ORI.L  #$00810049,(A0)                  ; $11F74E
        ORI.W  #$0C90,(A0)                      ; $11F754
        ORI.W  #$0058,$0049(A5)                 ; $11F758
        ORI.W  #$0390,$7E(A2,D0.W)              ; $11F75E
        DC.W    $0024,$0208         ; $11F764 ORI.B  #$0208,-(A4)
        DC.W    $000F,$5100         ; $11F768 ORI.B  #$5100,A7
        ORI.W  #$5500,D0                        ; $11F76C
        DC.W    $0018,$0208         ; $11F770 ORI.B  #$0208,(A0)+
        ORI.W  #$1390,D7                        ; $11F774
        DC.W    $007E,$0053         ; $11F778 ORI.W  #$0053,<EA:3E>
        ORI.L  #$002B0023,A0                    ; $11F77C
        DC.W    $002E,$0082,$0390   ; $11F782 ORI.B  #$0082,$0390(A6)
        ORI.L  #$00310208,D1                    ; $11F788
        ORI.W  #$0390,(A0)                      ; $11F78E
        ORI.L  #$00600062,D2                    ; $11F792
        ORI.W  #$1490,A3                        ; $11F798
        DC.W    $007E,$0023         ; $11F79C ORI.W  #$0023,<EA:3E>
        DC.W    $0008,$0035         ; $11F7A0 ORI.B  #$0035,A0
        ORI.W  #$0390,D7                        ; $11F7A4
        ORI.W  #$0023,(A3)                      ; $11F7A8
        DC.W    $002D,$0081,$00A8   ; $11F7AC ORI.B  #$0081,$00A8(A5)
        DC.W    $0CA9,$00A6,$0034,$0083; $11F7B2 CMPI.L  #$00A60034,$0083(A1)
        BCLR    D1,$00A3(A1)                    ; $11F7BA
        DC.W    $00AA,$002F,$0081,$03A9; $11F7BE ORI.L  #$002F0081,$03A9(A2)
        ORI.L  #$0030005E,D2                    ; $11F7C6
        ORI.W  #$03A3,(A0)                      ; $11F7CC
        ORI.L  #$00510045,(A0)                  ; $11F7D0
        ORI.W  #$0490,(A2)+                     ; $11F7D6
        BCLR    D3,$0072(A3)                    ; $11F7DA
        DC.W    $0031,$006B,$0050   ; $11F7DE ORI.B  #$006B,$50(A1,D0.W)
        DC.W    $04AB,$004B,$0208,$0011; $11F7E4 SUBI.L  #$004B0208,$0011(A3)
        DC.W    $0004,$5000         ; $11F7EC ORI.B  #$5000,D4
        ORI.W  #$5500,A3                        ; $11F7F0
        DC.W    $0018,$0208         ; $11F7F4 ORI.B  #$0208,(A0)+
        ORI.W  #$0072,$0E7E(A5)                 ; $11F7F8
        ANDI.W  #$006D,(A4)                     ; $11F7FE
        ORI.W  #$0034,D5                        ; $11F802
        ORI.W  #$007F,-(A2)                     ; $11F806
        ORI.W  #$0081,(A2)+                     ; $11F80A
        SUBI.L  #$00480308,(A0)                 ; $11F80E
        ORI.W  #$04AB,$0053(A5)                 ; $11F814
        DC.W    $0025,$0023         ; $11F81A ORI.B  #$0023,-(A5)
        DC.W    $003F,$004E         ; $11F81E ORI.B  #$004E,<EA:3F>
        ANDI.W  #$0048,$035A(A5)                ; $11F822
        ORI.W  #$014B,A2                        ; $11F828
        BCHG    D3,-(A6)                        ; $11F82C
        ORI.W  #$0036,D4                        ; $11F82E
        DC.W    $0108               ; $11F832 BTST    D0,A0
        ORI.W  #$04AB,A1                        ; $11F834
        ORI.W  #$006B,-(A6)                     ; $11F838
        ORI.W  #$007C,-(A0)                     ; $11F83C
        ORI.W  #$006F,(A2)                      ; $11F840
        ORI.W  #$02AC,(A3)                      ; $11F844
        BCLR    D1,D3                           ; $11F848
        ANDI.L  #$00500045,D1                   ; $11F84A
        ORI.L  #$03A900A8,D1                    ; $11F850
        ORI.W  #$004E,(A0)                      ; $11F856
        ORI.L  #$03A90081,-(A3)                 ; $11F85A
        DC.W    $0031,$0088,$0090   ; $11F860 ORI.B  #$0088,-$70(A1,D0.W)
        DC.W    $00A9,$02A8,$0091,$0031; $11F866 ORI.L  #$02A80091,$0031(A1)
        DC.W    $0008,$0064         ; $11F86E ORI.B  #$0064,A0
        ORI.L  #$0CAB0076,(A0)                  ; $11F872
        DC.W    $00AD,$008D,$04AB,$0054; $11F878 ORI.L  #$008D04AB,$0054(A5)
        DC.W    $0036,$0108,$0013   ; $11F880 ORI.B  #$0108,$13(A6,D0.W)
        DC.W    $0001,$5000         ; $11F886 ORI.B  #$5000,D1
        ORI.W  #$5500,A7                        ; $11F88A
        DC.W    $0018,$0208         ; $11F88E ORI.B  #$0208,(A0)+
        ORI.W  #$0075,D5                        ; $11F892
        BTST    D1,-(A5)                        ; $11F896
        BCHG    D1,D5                           ; $11F898
        BTST    D0,$58(A4,D0.W)                 ; $11F89A
        DC.W    $0222,$025E         ; $11F89E ANDI.B  #$025E,-(A2)
        DC.W    $0035,$0062,$0022   ; $11F8A2 ORI.B  #$0062,$22(A5,D0.W)
        ORI.W  #$0052,$0091(A5)                 ; $11F8A8
        BCLR    D2,$0091(A3)                    ; $11F8AE
        DC.W    $002F,$0308,$005E   ; $11F8B2 ORI.B  #$0308,$005E(A7)
        ORI.W  #$04AB,$006C(A6)                 ; $11F8B8
        DC.W    $00AE,$012A,$02AE,$047F; $11F8BE ORI.L  #$012A02AE,$047F(A6)
        BCLR    D1,$0660(A7)                    ; $11F8C6
        DC.W    $007F,$0208         ; $11F8CA ORI.W  #$0208,<EA:3F>
        DC.W    $007F,$05AB         ; $11F8CE ORI.W  #$05AB,<EA:3F>
        ORI.W  #$012A,-(A6)                     ; $11F8D2
        BCHG    D0,$25(A5,D0.W)                 ; $11F8D6
        ANDI.W  #$0058,D5                       ; $11F8DA
        BTST    D0,-(A2)                        ; $11F8DE
        BCHG    D0,(A6)+                        ; $11F8E0
        ORI.W  #$0035,$0045(A3)                 ; $11F8E2
        ORI.L  #$04A90181,D1                    ; $11F8E8
        BCLR    D1,$00A8(A1)                    ; $11F8EE
        ORI.W  #$0058,A6                        ; $11F8F2
        ORI.W  #$00A8,-$57(A7,D0.W)             ; $11F8F6
        DC.W    $02A8,$0081,$002B,$0008; $11F8FC ANDI.L  #$0081002B,$0008(A0)
        DC.W    $002A,$0066,$025A   ; $11F904 ORI.B  #$0066,$025A(A2)
        ORI.L  #$006D0327,(A4)                  ; $11F90A
        DC.W    $00B0,$0040,$0074,$0076; $11F910 ORI.L  #$00400074,$76(A0,D0.W)
        ORI.W  #$005E,$0023(A5)                 ; $11F918
        ORI.W  #$03AB,D6                        ; $11F91E
        ORI.W  #$00B1,$08(A2,D0.W)              ; $11F922
        DC.W    $000E,$5000         ; $11F928 ORI.B  #$5000,A6
        DC.W    $003D,$5500         ; $11F92C ORI.B  #$5500,<EA:3D>
        DC.W    $0018,$0208         ; $11F930 ORI.B  #$0208,(A0)+
        ORI.W  #$0327,-(A3)                     ; $11F934
        DC.W    $00B0,$0174,$0176,$0047; $11F938 ORI.L  #$01740176,$47(A0,D0.W)
        BCHG    D0,D6                           ; $11F940
        ORI.W  #$0654,$0072(A7)                 ; $11F942
        BCLR    D3,$0072(A3)                    ; $11F948
        ORI.L  #$0508003F,D6                    ; $11F94C
        BCLR    D2,$0691(A3)                    ; $11F952
        DC.W    $0E92               ; $11F956 DC.W    $0E92
        ORI.W  #$0062,(A4)                      ; $11F958
        DC.W    $0108               ; $11F95C BTST    D0,A0
        ORI.W  #$0047,-(A2)                     ; $11F95E
        BCLR    D2,$0491(A3)                    ; $11F962
        ORI.L  #$04820581,(A0)                  ; $11F966
        BCLR    D5,$00A8(A1)                    ; $11F96C
        DC.W    $0079,$002A,$0052,$00A8; $11F970 ORI.W  #$002A,$005200A8
        DC.W    $00A9,$01A8,$00AB,$0094; $11F978 ORI.L  #$01A800AB,$0094(A1)
        ORI.W  #$0008,-(A2)                     ; $11F980
        ORI.W  #$017F,D5                        ; $11F984
        BCLR    D0,$002A(A6)                    ; $11F988
        DC.W    $00B2,$0175,$00B3,$01B4; $11F98C ORI.L  #$017500B3,-$4C(A2,D0.W)
        DC.W    $0025,$0133         ; $11F994 ORI.B  #$0133,-(A5)
        ORI.W  #$005E,D5                        ; $11F998
        DC.W    $0034,$0054,$04AB   ; $11F99C ORI.B  #$0054,-$55(A4,D0.W)
        DC.W    $00B0,$0208,$0010,$5000; $11F9A2 ORI.L  #$02080010,$00(A0,D5.W)
        DC.W    $0029,$5500,$0018   ; $11F9AA ORI.B  #$5500,$0018(A1)
        DC.W    $0208,$0047         ; $11F9B0 ANDI.B  #$0047,A0
        MOVE.B  $006E(A3),$60(A5,D0.W)          ; $11F9B4
        DC.W    $0208,$001C         ; $11F9BA ANDI.B  #$001C,A0
        DC.W    $0012,$0108         ; $11F9BE ORI.B  #$0108,(A2)
        ORI.W  #$0046,-$4B(A5,D1.L)             ; $11F9C2
        ORI.W  #$0062,$08(A2,D0.W)              ; $11F9C8
        DC.W    $003F,$04B5         ; $11F9CE ORI.B  #$04B5,<EA:3F>
        BCLR    D2,$17B6(A1)                    ; $11F9D2
        ORI.L  #$002E008A,D2                    ; $11F9D6
        ORI.L  #$00B602A9,(A0)                  ; $11F9DC
        ORI.L  #$008A0108,(A0)                  ; $11F9E2
        DC.W    $003F,$0290         ; $11F9E8 ORI.B  #$0290,<EA:3F>
        BCLR    D0,(A6)                         ; $11F9EC
        BCLR    D0,(A2)                         ; $11F9EE
        SUBI.W  #$049E,-$4B(A2,D0.W)            ; $11F9F0
        DC.W    $007E,$0208         ; $11F9F6 ORI.W  #$0208,<EA:3E>
        DC.W    $0019,$0001         ; $11F9FA ORI.B  #$0001,(A1)+
        DC.W    $4F00               ; $11F9FE DC.W    $4F00
        DC.W    $0026,$5500         ; $11FA00 ORI.B  #$5500,-(A6)
        DC.W    $0018,$0208         ; $11FA04 ORI.B  #$0208,(A0)+
        ORI.W  #$0BAB,-$4B(A6,D0.L)             ; $11FA08
        ORI.W  #$0060,$08(A2,D0.W)              ; $11FA0E
        DC.W    $001C,$000D         ; $11FA14 ORI.B  #$000D,(A4)+
        DC.W    $001D,$0208         ; $11FA18 ORI.B  #$0208,(A5)+
        ORI.W  #$0096,-(A0)                     ; $11FA1C
        MOVE.B  -$62(A5,D0.W),$62(A4,D0.W)      ; $11FA20
        DC.W    $0208,$0036         ; $11FA26 ANDI.B  #$0036,A0
        ORI.W  #$01B5,(A1)+                     ; $11FA2A
        BCLR    D0,-$4A(A7,D1.L)                ; $11FA2E
        DC.W    $00B8,$0020,$00B9,$0097; $11FA32 ORI.L  #$002000B9,$0097.W
        BCLR    D1,-$7E(A6,D0.W)                ; $11FA3A
        DC.W    $0031,$0108,$004A   ; $11FA3E ORI.B  #$0108,$4A(A1,D0.W)
        MOVE.B  -$70(A5,D0.W),(A3)              ; $11FA44
        DC.W    $002B,$0208,$000A   ; $11FA48 ORI.B  #$0208,$000A(A3)
        DC.W    $4F00               ; $11FA4E DC.W    $4F00
        DC.W    $0027,$5500         ; $11FA50 ORI.B  #$5500,-(A7)
        DC.W    $0018,$0208         ; $11FA54 ORI.B  #$0208,(A0)+
        ORI.W  #$19B5,D7                        ; $11FA58
        ORI.L  #$002E0308,(A6)                  ; $11FA5C
        DC.W    $0013,$0001         ; $11FA62 ORI.B  #$0001,(A3)
        DC.W    $0002,$0016         ; $11FA66 ORI.B  #$0016,D2
        DC.W    $0208,$002E         ; $11FA6A ANDI.B  #$002E,A0
        ORI.L  #$18B5009E,(A6)                  ; $11FA6E
        ORI.W  #$0308,-(A2)                     ; $11FA74
        DC.W    $002C,$004B,$0090   ; $11FA78 ORI.B  #$004B,$0090(A4)
        DC.W    $00B5,$00B7,$1CB6,$00A9; $11FA7E ORI.L  #$00B71CB6,-$57(A5,D0.W)
        DC.W    $00BA,$002D,$007E,$03B6; $11FA86 ORI.L  #$002D007E,$03B6(PC)
        DC.W    $00B5,$00BA,$0208,$004A; $11FA8E ORI.L  #$00BA0208,$4A(A5,D0.W)
        MOVE.B  -$49(A5,D0.W),(A3)              ; $11FA96
        ORI.W  #$0208,$0009(A5)                 ; $11FA9A
        DC.W    $4F00               ; $11FAA0 DC.W    $4F00
        DC.W    $002C,$5500,$0010   ; $11FAA2 ORI.B  #$5500,$0010(A4)
        DC.W    $0208,$0047         ; $11FAA8 ANDI.B  #$0047,A0
        MOVE.B  -$63(A5,D0.W),$47(A3,D0.W)      ; $11FAAC
        ORI.W  #$0308,A1                        ; $11FAB2
        DC.W    $0006,$0003         ; $11FAB6 ORI.B  #$0003,D6
        BTST    D0,D0                           ; $11FABA
        DC.W    $0005,$0015         ; $11FABC ORI.B  #$0015,D5
        DC.W    $0208,$002D         ; $11FAC0 ANDI.B  #$002D,A0
        ORI.W  #$007E,(A5)+                     ; $11FAC4
        ORI.L  #$15B5009E,(A6)                  ; $11FAC8
        ORI.W  #$0408,-(A2)                     ; $11FACE
        DC.W    $002C,$002D,$00A0   ; $11FAD2 ORI.B  #$002D,$00A0(A4)
        ORI.L  #$00971BB6,(A0)                  ; $11FAD8
        ORI.L  #$002D0030,D3                    ; $11FADE
        ORI.L  #$03B600B5,(A7)                  ; $11FAE4
        ORI.W  #$0208,(A5)+                     ; $11FAEA
        ORI.W  #$16B5,A2                        ; $11FAEE
        DC.W    $00B7,$0051,$0208,$0015; $11FAF2 ORI.L  #$00510208,$15(A7,D0.W)
        DC.W    $0002,$4E00         ; $11FAFA ORI.B  #$4E00,D2
        DC.W    $0032,$5500,$0010   ; $11FAFE ORI.B  #$5500,$10(A2,D0.W)
        DC.W    $0208,$0051         ; $11FB04 ANDI.B  #$0051,A0
        MOVE.B  -$62(A5,D0.W),$70(A1,D0.W)      ; $11FB08
        ORI.W  #$004C,A0                        ; $11FB0E
        DC.W    $0023,$0308         ; $11FB12 ORI.B  #$0308,-(A3)
        DC.W    $001C,$0014         ; $11FB16 ORI.B  #$0014,(A4)+
        DC.W    $0003,$0300         ; $11FB1A ORI.B  #$0300,D3
        DC.W    $0005,$0017         ; $11FB1E ORI.B  #$0017,D5
        DC.W    $0308               ; $11FB22 BTST    D1,A0
        DC.W    $0021,$0045         ; $11FB24 ORI.B  #$0045,-(A1)
        ORI.W  #$0172,$7E(A0,D1.W)              ; $11FB28
        ORI.W  #$0062,D3                        ; $11FB2E
        ADDI.B  #$0062,A0                       ; $11FB32
        DC.W    $0022,$00BB         ; $11FB36 ORI.B  #$00BB,-(A2)
        DC.W    $007E,$0382         ; $11FB3A ORI.W  #$0382,<EA:3E>
        BCLR    D0,(A7)                         ; $11FB3E
        BCLR    D2,-(A1)                        ; $11FB40
        BCLR    D0,$0CB6(A1)                    ; $11FB42
        ORI.W  #$0034,(A4)+                     ; $11FB46
        ORI.W  #$00A9,A0                        ; $11FB4A
        BCLR    D1,$7E(A6,D0.W)                 ; $11FB4E
        DC.W    $002B,$0208,$004A   ; $11FB52 ORI.B  #$0208,$004A(A3)
        MOVE.B  -$49(A5,D0.W),(A3)              ; $11FB58
        ORI.L  #$002F0208,(A0)                  ; $11FB5C
        DC.W    $0002,$4E00         ; $11FB62 ORI.B  #$4E00,D2
        ORI.W  #$5500,D7                        ; $11FB66
        DC.W    $0010,$0208         ; $11FB6A ORI.B  #$0208,(A0)
        ORI.W  #$047E,A3                        ; $11FB6E
        BCHG    D0,-$60(A1,D0.W)                ; $11FB72
        ORI.W  #$0051,D7                        ; $11FB76
        ORI.W  #$0028,(A0)                      ; $11FB7A
        ORI.W  #$006D,$48(A0,D0.W)              ; $11FB7E
        ORI.W  #$004B,A2                        ; $11FB84
        DC.W    $003F,$005D         ; $11FB88 ORI.B  #$005D,<EA:3F>
        ORI.L  #$002B0608,A0                    ; $11FB8C
        DC.W    $0015,$0005         ; $11FB92 ORI.B  #$0005,(A5)
        DC.W    $0004,$0500         ; $11FB96 ORI.B  #$0500,D4
        DC.W    $000A,$0006         ; $11FB9A ORI.B  #$0006,A2
        MOVE.B  A0,-(A7)                        ; $11FB9E
        DC.W    $0011,$001A         ; $11FBA0 ORI.B  #$001A,(A1)
        SUBI.B  #$0036,A0                       ; $11FBA4
        DC.W    $002C,$0023,$001F   ; $11FBA8 ORI.B  #$0023,$001F(A4)
        DC.W    $0035,$0021,$0024   ; $11FBAE ORI.B  #$0021,$24(A5,D0.W)
        DC.W    $0037,$0033,$0032   ; $11FBB4 ORI.B  #$0033,$32(A7,D0.W)
        DC.W    $0038,$0030,$002F   ; $11FBBA ORI.B  #$0030,$002F.W
        DC.W    $003C,$0089,$003E   ; $11FBC0 ORI.B  #$0089,#$003E
        ORI.L  #$006A0067,A3                    ; $11FBC6
        ORI.W  #$004F,A5                        ; $11FBCC
        DC.W    $00BC,$00BD,$005C,$00A6,$02BE; $11FBD0 ORI.L  #$00BD005C,#$00A602BE
        ORI.W  #$0033,A0                        ; $11FBDA
        ORI.W  #$0482,(A1)                      ; $11FBDE
        ORI.W  #$0308,A0                        ; $11FBE2
        ORI.W  #$0082,(A5)+                     ; $11FBE6
        BCLR    D1,(A7)                         ; $11FBEA
        MOVE.B  -$47(A5,D0.W),$08(A1,D0.W)      ; $11FBEC
        DC.W    $001D,$00BF         ; $11FBF2 ORI.B  #$00BF,(A5)+
        DC.W    $4D00               ; $11FBF6 DC.W    $4D00
        DC.W    $002A,$5500,$0010   ; $11FBF8 ORI.B  #$5500,$0010(A2)
        MOVE.B  A0,-(A6)                        ; $11FBFE
        DC.W    $001B,$0018         ; $11FC00 ORI.B  #$0018,(A3)+
        DC.W    $000A,$0800         ; $11FC04 ORI.B  #$0800,A2
        DC.W    $0001,$000D         ; $11FC08 ORI.B  #$000D,D1
        DC.W    $0016,$1D08         ; $11FC0C ORI.B  #$1D08,(A6)
        DC.W    $0109               ; $11FC10 BTST    D0,A1
        DC.W    $0017,$2108         ; $11FC12 ORI.B  #$2108,(A7)
        DC.W    $0036,$002C,$0023   ; $11FC16 ORI.B  #$002C,$23(A6,D0.W)
        ORI.W  #$0035,-(A2)                     ; $11FC1C
        DC.W    $0021,$0062         ; $11FC20 ORI.B  #$0062,-(A1)
        DC.W    $0308               ; $11FC24 BTST    D1,A0
        ORI.W  #$002A,(A6)+                     ; $11FC26
        DC.W    $0031,$012F,$002E   ; $11FC2A ORI.B  #$012F,$2E(A1,D0.W)
        ORI.W  #$0155,A1                        ; $11FC30
        ORI.W  #$005D,D4                        ; $11FC34
        DC.W    $013F               ; $11FC38 BTST    D0,<EA:3F>
        DC.W    $014B               ; $11FC3A BCHG    D0,A3
        ORI.W  #$005B,(A1)+                     ; $11FC3C
        SUBI.W  #$026D,A0                       ; $11FC40
        ORI.W  #$002B,A0                        ; $11FC44
        DC.W    $0208,$0015         ; $11FC48 ANDI.B  #$0015,A0
        DC.W    $0001,$4D00         ; $11FC4C ORI.B  #$4D00,D1
        DC.W    $0016,$5500         ; $11FC50 ORI.B  #$5500,(A6)
        DC.W    $0010,$1B08         ; $11FC54 ORI.B  #$1B08,(A0)
        DC.W    $0007,$000F         ; $11FC58 ORI.B  #$000F,D7
        DC.W    $0003,$0B00         ; $11FC5C ORI.B  #$0B00,D3
        DC.W    $0004,$0005         ; $11FC60 ORI.B  #$0005,D4
        DC.W    $001E,$0019         ; $11FC64 ORI.B  #$0019,(A6)+
        DC.W    $0007,$1A08         ; $11FC68 ORI.B  #$1A08,D7
        DC.W    $0009,$0000         ; $11FC6C ORI.B  #$0000,A1
        DC.W    $0002,$0010         ; $11FC70 ORI.B  #$0010,D2
        DC.W    $0006,$001B         ; $11FC74 ORI.B  #$001B,D6
        DC.W    $4708               ; $11FC78 DC.W    $4708
        DC.W    $001B,$0002         ; $11FC7A ORI.B  #$0002,(A3)+
        DC.W    $4D00               ; $11FC7E DC.W    $4D00
        DC.W    $002B,$5500,$000F   ; $11FC80 ORI.B  #$5500,$000F(A3)
        MOVE.B  A0,D4                           ; $11FC86
        DC.W    $0016,$0018         ; $11FC88 ORI.B  #$0018,(A6)
        DC.W    $0005,$0003         ; $11FC8C ORI.B  #$0003,D5
        DC.W    $0001,$0E00         ; $11FC90 ORI.B  #$0E00,D1
        DC.W    $0004,$0002         ; $11FC94 ORI.B  #$0002,D4
        DC.W    $001D,$000F         ; $11FC98 ORI.B  #$000F,(A5)+
        BTST    D0,(A0)                         ; $11FC9C
        DC.W    $000F,$010E         ; $11FC9E ORI.B  #$010E,A7
        DC.W    $021D,$0209         ; $11FCA2 ANDI.B  #$0209,(A5)+
        DC.W    $090D               ; $11FCA6 BTST    D4,A5
        DC.W    $0109               ; $11FCA8 BTST    D0,A1
        DC.W    $021D,$0002         ; $11FCAA ANDI.B  #$0002,(A5)+
        DC.W    $0200,$0001         ; $11FCAE ANDI.B  #$0001,D0
        DC.W    $0009,$0010         ; $11FCB2 ORI.B  #$0010,A1
        DC.W    $001E,$0011         ; $11FCB6 ORI.B  #$0011,(A6)+
        DC.W    $000B,$0014         ; $11FCBA ORI.B  #$0014,A3
        DC.W    $0013,$0019         ; $11FCBE ORI.B  #$0019,(A3)
        DC.W    $0006,$0017         ; $11FCC2 ORI.B  #$0017,D6
        DC.W    $0015,$0016         ; $11FCC6 ORI.B  #$0016,(A5)
        DC.W    $001C,$001B         ; $11FCCA ORI.B  #$001B,(A4)+
        DC.W    $0012,$0007         ; $11FCCE ORI.B  #$0007,(A2)
        MOVE.W  A0,-(A4)                        ; $11FCD2
        DC.W    $0010,$00BF         ; $11FCD4 ORI.B  #$00BF,(A0)
        DC.W    $4C00               ; $11FCD8 DC.W    $4C00
        DC.W    $002D,$5500,$0003   ; $11FCDA ORI.B  #$5500,$0003(A5)
        DC.W    $001E,$000C         ; $11FCE0 ORI.B  #$000C,(A6)+
        BTST    D0,(A6)+                        ; $11FCE4
        BTST    D0,(A0)+                        ; $11FCE6
        BTST    D0,(A0)                         ; $11FCE8
        DC.W    $000F,$010E         ; $11FCEA ORI.B  #$010E,A7
        DC.W    $001D,$0109         ; $11FCEE ORI.B  #$0109,(A5)+
        DC.W    $000D,$0005         ; $11FCF2 ORI.B  #$0005,A5
        DC.W    $010A               ; $11FCF6 BTST    D0,A2
        BTST    D2,D3                           ; $11FCF8
        BTST    D0,D2                           ; $11FCFA
        DC.W    $0004,$3800         ; $11FCFC ORI.B  #$3800,D4
        SUBI.B  #$0401,D4                       ; $11FD00
        BTST    D1,D2                           ; $11FD04
        BTST    D1,D3                           ; $11FD06
        DC.W    $0005,$000D         ; $11FD08 ORI.B  #$000D,D5
        DC.W    $0009,$000E         ; $11FD0C ORI.B  #$000E,A1
        DC.W    $000F,$0010         ; $11FD10 ORI.B  #$0010,A7
        DC.W    $0018,$000C         ; $11FD14 ORI.B  #$000C,(A0)+
        DC.W    $0011,$000B         ; $11FD18 ORI.B  #$000B,(A1)
        DC.W    $0014,$0019         ; $11FD1C ORI.B  #$0019,(A4)
        DC.W    $0006,$0017         ; $11FD20 ORI.B  #$0017,D6
        DC.W    $0015,$0016         ; $11FD24 ORI.B  #$0016,(A5)
        DC.W    $001C,$001A         ; $11FD28 ORI.B  #$001A,(A4)+
        DC.W    $0012,$0007         ; $11FD2C ORI.B  #$0007,(A2)
        MOVE.B  A0,-(A7)                        ; $11FD30
        DC.W    $000B,$0004         ; $11FD32 ORI.B  #$0004,A3
        DC.W    $4C00               ; $11FD36 DC.W    $4C00
        DC.W    $0014,$5600         ; $11FD38 ORI.B  #$5600,(A4)
        DC.W    $0004,$5D00         ; $11FD3C ORI.B  #$5D00,D4
        DC.W    $0DBF               ; $11FD40 BCLR    D6,<EA:3F>
        SUBI.B  #$0401,D4                       ; $11FD42
        SUBI.B  #$0403,D2                       ; $11FD46
        DC.W    $000A,$0005         ; $11FD4A ORI.B  #$0005,A2
        DC.W    $010D               ; $11FD4E BTST    D0,A5
        DC.W    $0109               ; $11FD50 BTST    D0,A1
        BTST    D0,(A5)+                        ; $11FD52
        DC.W    $000E,$090F         ; $11FD54 ORI.B  #$090F,A6
        DC.W    $010E               ; $11FD58 BTST    D0,A6
        BTST    D0,(A5)+                        ; $11FD5A
        DC.W    $0109               ; $11FD5C BTST    D0,A1
        DC.W    $0003,$00BF         ; $11FD5E ORI.B  #$00BF,D3
        DC.W    $4C00               ; $11FD62 DC.W    $4C00
        DC.W    $0004,$CE00         ; $11FD64 ORI.B  #$CE00,D4
        DC.W    $03BF               ; $11FD68 BCLR    D1,<EA:3F>
        BTST    D1,D4                           ; $11FD6A
        DC.W    $18BF               ; $11FD6C MOVE.B  <EA:3F>,(A4)
        DC.W    $4F00               ; $11FD6E DC.W    $4F00
        DC.W    $0001,$FF00         ; $11FD70 ORI.B  #$FF00,D1
        MOVE.W  D0,-(A7)                        ; $11FD74
        ORI.L  #$003900A6,-(A7)                 ; $11FD76
        DC.W    $0000,$0C63         ; $11FD7C ORI.B  #$0C63,D0
        BCHG    #5,D2                           ; $11FD80
        MOVE.B  -(A7),(A6)+                     ; $11FD84
        MOVE.W  A6,#$294A                       ; $11FD86
        MOVE.L  $318C(A3),$2529(A6)             ; $11FD8A
        MOVE.L  A0,-(A0)                        ; $11FD90
        MOVE.B  D4,(A0)                         ; $11FD92
        MOVE.B  D6,(A4)+                        ; $11FD94
        NOT.B  -$6C(A1,D5.W)                    ; $11FD96
        ADDQ.L  #3,$73(A5,D4.L)                 ; $11FD9A
        BLS.S  loc_11FDB8                       ; $11FD9E
        DC.W    $7FFF               ; $11FDA0 MOVE.W  <EA:3F>,<EA:3F>
        BLE.S  loc_11FE1F                       ; $11FDA2
        DC.W    $3DEF,$77BD         ; $11FDA4 MOVE.W  $77BD(A7),<EA:3E>
        CLR.B  (A0)                             ; $11FDA8
        BEQ.S  loc_11FDE5                       ; $11FDAA
        DC.W    $7BDE               ; $11FDAC MOVE.W  (A6)+,<EA:3D>
        MOVE.W  (A4)+,$5A(A1,D6.L)              ; $11FDAE
        SGT     -$2A(A7,D5.L)                   ; $11FDB2
        MOVE.W  $4A52(A5),-$02(A2,D7.L)         ; $11FDB6
        DC.W    $7FFD               ; $11FDBC MOVE.W  <EA:3D>,<EA:3F>
        DC.W    $7FFC,$7ECE         ; $11FDBE MOVE.W  #$7ECE,<EA:3F>
        MOVEQ   #-$32,D5                        ; $11FDC2
        MOVEQ   #-$33,D5                        ; $11FDC4
        MOVEQ   #-$53,D5                        ; $11FDC6
        MOVEQ   #-$11,D7                        ; $11FDC8
        MOVE.W  (A7),-$26(A7,D7.L)              ; $11FDCA
        MOVE.W  $33(A2,D7.L),-(A7)              ; $11FDCE
        MOVE.W  (A3),$7F54(A7)                  ; $11FDD2
        MOVE.W  (A5),$7F75(A7)                  ; $11FDD6
        MOVE.W  -$68(A6,D7.L),$7FB9(A7)         ; $11FDDA
        DC.W    $7FDB               ; $11FDE0 MOVE.W  (A3)+,<EA:3F>
        MOVEQ   #$6A,D3                         ; $11FDE2
        MOVEQ   #$69,D3                         ; $11FDE4
        MOVEQ   #$69,D5                         ; $11FDE6
        DC.W    $7FFB,$768B         ; $11FDE8 MOVE.W  -$75(PC,D7.W),<EA:3F>
        MOVEQ   #$04,D1                         ; $11FDEC
        MOVEQ   #$04,D3                         ; $11FDEE
        MOVEQ   #$46,D3                         ; $11FDF0
        MOVEQ   #-$53,D7                        ; $11FDF2
        MOVEQ   #$25,D3                         ; $11FDF4
        MOVEQ   #$26,D3                         ; $11FDF6
        MOVEQ   #$47,D3                         ; $11FDF8
        MOVEQ   #$48,D3                         ; $11FDFA
        MOVEQ   #$68,D3                         ; $11FDFC
        MOVEQ   #-$54,D5                        ; $11FDFE
        MOVEQ   #-$76,D5                        ; $11FE00
        MOVEQ   #-$76,D3                        ; $11FE02
        MOVEQ   #-$75,D5                        ; $11FE04
        MOVEQ   #-$55,D5                        ; $11FE06
        MOVEQ   #$48,D1                         ; $11FE08
        MOVE.W  (A6),-$33(A7,D7.L)              ; $11FE0A
        MOVEQ   #-$74,D3                        ; $11FE0E
        MOVEQ   #-$54,D7                        ; $11FE10
        DC.W    $7FD9               ; $11FE12 MOVE.W  (A1)+,<EA:3F>
        MOVE.W  (A1),-(A7)                      ; $11FE14
        MOVEQ   #$49,D3                         ; $11FE16
        MOVEQ   #$05,D1                         ; $11FE18
        MOVEQ   #$25,D1                         ; $11FE1A
        MOVEQ   #$6A,D5                         ; $11FE1C
        MOVE.W  $7226.W,-$55(A7,D7.L)           ; $11FE1E
        MOVE.W  (A0),-(A7)                      ; $11FE24
        MOVEQ   #-$54,D3                        ; $11FE26
        MOVEQ   #$46,D1                         ; $11FE28
        BGT.S  loc_11FE30                       ; $11FE2A
        MOVE.W  -$06(A7,D7.L),$47(A7,D7.W)      ; $11FE2C
        MOVEQ   #-$10,D7                        ; $11FE32
        BGT.S  loc_11FE3B                       ; $11FE34
        MOVEQ   #$69,D1                         ; $11FE36
        MOVEQ   #$67,D3                         ; $11FE38
        MOVEQ   #-$55,D3                        ; $11FE3A
        MOVEQ   #-$34,D5                        ; $11FE3C
        BGT.S  loc_11FE43                       ; $11FE3E
        MOVEQ   #$68,D1                         ; $11FE40
        BLT.S  loc_11FE27                       ; $11FE42
        MOVEQ   #$27,D1                         ; $11FE44
loc_11FE46:
        MOVEQ   #$06,D1                         ; $11FE46
        BLT.S  loc_11FE2E                       ; $11FE48
        MOVEQ   #-$31,D7                        ; $11FE4A
        BGT.S  loc_11FE75                       ; $11FE4C
        BPL.S  loc_11FE54                       ; $11FE4E
        BGT.S  loc_11FE78                       ; $11FE50
        BGT.S  loc_11FE79                       ; $11FE52
loc_11FE54:
        DC.W    $7FD8               ; $11FE54 MOVE.W  (A0)+,<EA:3F>
        MOVE.W  -(A3),$69E3.W                   ; $11FE56
        MOVE.W  $52(A1,D7.L),-(A7)              ; $11FE5A
loc_11FE5E:
        BGT.S  loc_11FE66                       ; $11FE5E
        MOVE.W  -$34(A4,D7.L),$7EEE(A7)         ; $11FE60
loc_11FE66:
        MOVEQ   #$68,D5                         ; $11FE66
loc_11FE68:
        MOVEQ   #$03,D1                         ; $11FE68
        MOVEQ   #-$11,D5                        ; $11FE6A
        MOVE.W  A7,-(A7)                        ; $11FE6C
        MOVE.W  -(A2),$6DE2.W                   ; $11FE6E
        MOVEQ   #-$77,D5                        ; $11FE72
        MOVEQ   #$67,D5                         ; $11FE74
        MOVEQ   #$24,D1                         ; $11FE76
loc_11FE78:
        MOVEQ   #-$76,D7                        ; $11FE78
        BVS.S  loc_11FE5E                       ; $11FE7A
loc_11FE7C:
        MOVEQ   #$02,D1                         ; $11FE7C
        MOVE.W  D2,$6DC2.W                      ; $11FE7E
        MOVEQ   #$27,D3                         ; $11FE82
        MOVEQ   #$48,D5                         ; $11FE84
        MOVEQ   #$05,D3                         ; $11FE86
        MOVE.W  -(A4),$7F77.W                   ; $11FE88
        MOVEQ   #-$75,D7                        ; $11FE8C
        BLT.S  loc_11FE53                       ; $11FE8E
        BVS.S  loc_11FE54                       ; $11FE90
        MOVEQ   #$47,D5                         ; $11FE92
        BVS.S  loc_11FE59                       ; $11FE94
        BVS.S  loc_11FE7C                       ; $11FE96
        MOVE.W  -$31(A4,D7.L),-(A7)             ; $11FE98
        MOVEQ   #-$10,D5                        ; $11FE9C
        BCS.S  loc_11FE63                       ; $11FE9E
        BVS.S  loc_11FE87                       ; $11FEA0
        BCS.S  loc_11FE46                       ; $11FEA2
        BCS.S  loc_11FE68                       ; $11FEA4
        BVS.S  loc_11FE69                       ; $11FEA6
        MOVEQ   #-$77,D3                        ; $11FEA8
        BLT.S  loc_11FE6D                       ; $11FEAA
        MOVEQ   #-$13,D7                        ; $11FEAC
        MOVE.W  (A5),-$07(A7,D7.L)              ; $11FEAE
        BVS.S  loc_11FE55                       ; $11FEB2
        BCS.S  loc_11FE57                       ; $11FEB4
        BCS.S  loc_11FE79                       ; $11FEB6
        MOVE.W  -$7F(A6,D6.W),-$7F(A7,D6.L)     ; $11FEB8
        BLT.S  loc_11FE61                       ; $11FEBE
        BVS.S  loc_11FE64                       ; $11FEC0
        MOVEQ   #$28,D1                         ; $11FEC2
        MOVEQ   #-$74,D5                        ; $11FEC4
        SUBI.B  #$0001,-(A1)                    ; $11FEC6
        MOVE.W  D0,-(A7)                        ; $11FECA
        MOVE.W  D0,-(A7)                        ; $11FECC
        DC.W    $0001,$FF00         ; $11FECE ORI.B  #$FF00,D1
        MOVE.W  D0,-(A7)                        ; $11FED2
        DC.W    $0009,$E500         ; $11FED4 ORI.B  #$E500,A1
        DC.W    $0001,$0002         ; $11FED8 ORI.B  #$0002,D1
        DC.W    $0000,$0003         ; $11FEDC ORI.B  #$0003,D0
        DC.W    $0004,$0300         ; $11FEE0 ORI.B  #$0300,D4
        DC.W    $0003,$0005         ; $11FEE4 ORI.B  #$0005,D3
        DC.W    $4E00               ; $11FEE8 DC.W    $4E00
        DC.W    $0029,$6300,$0001   ; $11FEEA ORI.B  #$6300,$0001(A1)
        DC.W    $0004,$0106         ; $11FEF0 ORI.B  #$0106,D4
        DC.W    $0207,$0608         ; $11FEF4 ANDI.B  #$0608,D7
        SUBI.B  #$0306,D7                       ; $11FEF8
        DC.W    $0109               ; $11FEFC BTST    D0,A1
        DC.W    $000A,$0004         ; $11FEFE ORI.B  #$0004,A2
        DC.W    $0001,$0400         ; $11FF02 ORI.B  #$0400,D1
        DC.W    $000B,$0503         ; $11FF06 ORI.B  #$0503,A3
        DC.W    $070B               ; $11FF0A BTST    D3,A3
        ADDI.B  #$0602,D1                       ; $11FF0C
        MOVE.L  D0,-(A5)                        ; $11FF10
        DC.W    $0002,$0001         ; $11FF12 ORI.B  #$0001,D2
        DC.W    $000C,$000D         ; $11FF16 ORI.B  #$000D,A4
        DC.W    $000E,$010F         ; $11FF1A ORI.B  #$010F,A6
        DC.W    $0010,$000C         ; $11FF1E ORI.B  #$000C,(A0)
        DC.W    $000B,$0002         ; $11FF22 ORI.B  #$0002,A3
        ADDI.B  #$0011,D0                       ; $11FF26
        BTST    D2,(A2)                         ; $11FF2A
        DC.W    $000E,$0000         ; $11FF2C ORI.B  #$0000,A6
        DC.W    $0013,$0012         ; $11FF30 ORI.B  #$0012,(A3)
        DC.W    $0014,$0100         ; $11FF34 ORI.B  #$0100,(A4)
        DC.W    $0003,$0011         ; $11FF38 ORI.B  #$0011,D3
        DC.W    $0012,$4E00         ; $11FF3C ORI.B  #$4E00,(A2)
        ORI.W  #$6000,D5                        ; $11FF40
        DC.W    $0002,$000C         ; $11FF44 ORI.B  #$000C,D2
        DC.W    $0008,$000D         ; $11FF48 ORI.B  #$000D,A0
        DC.W    $0011,$1712         ; $11FF4C ORI.B  #$1712,(A1)
        DC.W    $0015,$000B         ; $11FF50 ORI.B  #$000B,(A5)
        BTST    D0,D0                           ; $11FF54
        DC.W    $0002,$0006         ; $11FF56 ORI.B  #$0006,D2
        DC.W    $0016,$0017         ; $11FF5A ORI.B  #$0017,(A6)
        DC.W    $0018,$0812         ; $11FF5E ORI.B  #$0812,(A0)+
        BTST    D0,(A0)+                        ; $11FF62
        DC.W    $0015,$0119         ; $11FF64 ORI.B  #$0119,(A5)
        DC.W    $0013,$001A         ; $11FF68 ORI.B  #$001A,(A3)
        BTST    D0,(A7)                         ; $11FF6C
        DC.W    $0011,$011B         ; $11FF6E ORI.B  #$011B,(A1)
        DC.W    $001C,$010F         ; $11FF72 ORI.B  #$010F,(A4)+
        DC.W    $000E,$0010         ; $11FF76 ORI.B  #$0010,A6
        DC.W    $000D,$000B         ; $11FF7A ORI.B  #$000B,A5
        DC.W    $0200,$0002         ; $11FF7E ANDI.B  #$0002,D0
        DC.W    $0003,$0006         ; $11FF82 ORI.B  #$0006,D3
        BTST    D0,D5                           ; $11FF86
        DC.W    $021D,$0208         ; $11FF88 ANDI.B  #$0208,(A5)+
        ADDI.B  #$0006,D7                       ; $11FF8C
        BTST    D1,D7                           ; $11FF90
        DC.W    $0308               ; $11FF92 BTST    D1,A0
        DC.W    $001D,$0006         ; $11FF94 ORI.B  #$0006,(A5)+
        BTST    D4,D0                           ; $11FF98
        DC.W    $0003,$0016         ; $11FF9A ORI.B  #$0016,D3
        DC.W    $001B,$001A         ; $11FF9E ORI.B  #$001A,(A3)+
        SUBI.B  #$0018,(A2)                     ; $11FFA2
        DC.W    $0015,$001E         ; $11FFA6 ORI.B  #$001E,(A5)
        DC.W    $0004,$0002         ; $11FFAA ORI.B  #$0002,D4
        SUBI.B  #$0010,D0                       ; $11FFAE
        DC.W    $0015,$0019         ; $11FFB2 ORI.B  #$0019,(A5)
        BTST    D0,(A2)                         ; $11FFB6
        DC.W    $0011,$001C         ; $11FFB8 ORI.B  #$001C,(A1)
        DC.W    $0007,$0000         ; $11FFBC ORI.B  #$0000,D7
        DC.W    $0013,$0112         ; $11FFC0 ORI.B  #$0112,(A3)
        DC.W    $000E,$000B         ; $11FFC4 ORI.B  #$000B,A6
        DC.W    $001A,$0112         ; $11FFC8 ORI.B  #$0112,(A2)+
        DC.W    $4E00               ; $11FFCC DC.W    $4E00
        DC.W    $0027,$5F00         ; $11FFCE ORI.B  #$5F00,-(A7)
        DC.W    $000B,$0014         ; $11FFD2 ORI.B  #$0014,A3
        DC.W    $001B,$1B12         ; $11FFD6 ORI.B  #$1B12,(A3)+
        DC.W    $000B,$0002         ; $11FFDA ORI.B  #$0002,A3
        DC.W    $0007,$0010         ; $11FFDE ORI.B  #$0010,D7
        MOVE.B  (A2),D7                         ; $11FFE2
        DC.W    $0009,$0000         ; $11FFE4 ORI.B  #$0000,A1
        DC.W    $0002,$0003         ; $11FFE8 ORI.B  #$0003,D2
        DC.W    $001E,$0011         ; $11FFEC ORI.B  #$0011,(A6)+
        DC.W    $0018,$1812         ; $11FFF0 ORI.B  #$1812,(A0)+
        DC.W    $001A,$0001         ; $11FFF4 ORI.B  #$0001,(A2)+
        ADDI.B  #$0003,D0                       ; $11FFF8
        DC.W    $001D,$001A         ; $11FFFC ORI.B  #$001A,(A5)+
        BTST    D5,(A2)                         ; $120000
        DC.W    $001E,$0007         ; $120002 ORI.B  #$0007,(A6)+
        DC.W    $0001,$0500         ; $120006 ORI.B  #$0500,D1
        BTST    D0,(A2)                         ; $12000A
        BTST    D1,D0                           ; $12000C
        DC.W    $0019,$0012         ; $12000E ORI.B  #$0012,(A1)+
        DC.W    $001E,$0012         ; $120012 ORI.B  #$0012,(A6)+
        DC.W    $0015,$0012         ; $120016 ORI.B  #$0012,(A5)
        DC.W    $001B,$0012         ; $12001A ORI.B  #$0012,(A3)+
        DC.W    $4E00               ; $12001E DC.W    $4E00
        DC.W    $0025,$5D00         ; $120020 ORI.B  #$5D00,-(A5)
        DC.W    $000B,$0008         ; $120024 ORI.B  #$0008,A3
        DC.W    $0011,$1D12         ; $120028 ORI.B  #$1D12,(A1)
        DC.W    $000C,$001D         ; $12002C ORI.B  #$001D,A4
        DC.W    $0018,$1F12         ; $120030 ORI.B  #$1F12,(A0)+
        DC.W    $0009,$0002         ; $120034 ORI.B  #$0002,A1
        DC.W    $0014,$0019         ; $120038 ORI.B  #$0019,(A4)
        MOVE.B  (A2),-(A5)                      ; $12003C
        DC.W    $0019,$0001         ; $12003E ORI.B  #$0001,(A1)+
        BTST    D2,D0                           ; $120042
        DC.W    $0009,$0019         ; $120044 ORI.B  #$0019,A1
        BTST    D2,(A2)                         ; $120048
        DC.W    $001F,$0120         ; $12004A ORI.B  #$0120,(A7)+
        DC.W    $0021,$0512         ; $12004E ORI.B  #$0512,-(A1)
        DC.W    $000D,$000B         ; $120052 ORI.B  #$000B,A5
        SUBI.B  #$0112,D0                       ; $120056
        BTST    D1,D0                           ; $12005A
        DC.W    $0019,$0012         ; $12005C ORI.B  #$0012,(A1)+
        DC.W    $0001,$001D         ; $120060 ORI.B  #$001D,D1
        DC.W    $0012,$0004         ; $120064 ORI.B  #$0004,(A2)
        DC.W    $0014,$0012         ; $120068 ORI.B  #$0012,(A4)
        DC.W    $4E00               ; $12006C DC.W    $4E00
        ORI.W  #$5C00,D0                        ; $12006E
        DC.W    $0004,$000D         ; $120072 ORI.B  #$000D,D4
        BTST    D2,(A2)                         ; $120076
        DC.W    $001F,$0022         ; $120078 ORI.B  #$0022,(A7)+
        DC.W    $0023,$0324         ; $12007C ORI.B  #$0324,-(A3)
        DC.W    $0225,$0324         ; $120080 ANDI.B  #$0324,-(A5)
        ADDI.B  #$0026,-(A3)                    ; $120084
        DC.W    $0027,$0212         ; $120088 ORI.B  #$0212,-(A7)
        DC.W    $000D,$0018         ; $12008C ORI.B  #$0018,A5
        BTST    D1,(A2)                         ; $120090
        DC.W    $0028,$0129,$012A   ; $120092 ORI.B  #$0129,$012A(A0)
        DC.W    $002B,$012C,$012D   ; $120098 ORI.B  #$012C,$012D(A3)
        DC.W    $002E,$012F,$0127   ; $12009E ORI.B  #$012F,$0127(A6)
        BTST    D0,$31(A0,D0.W)                 ; $1200A4
        BTST    D0,$0132(A0)                    ; $1200A8
        BTST    D0,-(A1)                        ; $1200AC
        DC.W    $0212,$000E         ; $1200AE ANDI.B  #$000E,(A2)
        DC.W    $0016,$1D12         ; $1200B2 ORI.B  #$1D12,(A6)
        DC.W    $0019,$0001         ; $1200B6 ORI.B  #$0001,(A1)+
        SUBI.B  #$0006,D0                       ; $1200BA
        DC.W    $0015,$0312         ; $1200BE ORI.B  #$0312,(A5)
        DC.W    $0021,$0028         ; $1200C2 ORI.B  #$0028,-(A1)
        DC.W    $002A,$0033,$0134   ; $1200C6 ORI.B  #$0033,$0134(A2)
        DC.W    $0035,$002E,$0027   ; $1200CC ORI.B  #$002E,$27(A5,D0.W)
        DC.W    $0036,$0312,$0010   ; $1200D2 ORI.B  #$0312,$10(A6,D0.W)
        DC.W    $0003,$0300         ; $1200D8 ORI.B  #$0300,D3
        BTST    D0,(A2)                         ; $1200DC
        BTST    D1,D0                           ; $1200DE
        DC.W    $0015,$0012         ; $1200E0 ORI.B  #$0012,(A5)
        DC.W    $0002,$0000         ; $1200E4 ORI.B  #$0000,D2
        DC.W    $0004,$0000         ; $1200E8 ORI.B  #$0000,D4
        DC.W    $0014,$0012         ; $1200EC ORI.B  #$0012,(A4)
        DC.W    $4E00               ; $1200F0 DC.W    $4E00
        DC.W    $003E,$5B00         ; $1200F2 ORI.B  #$5B00,<EA:3E>
        DC.W    $000C,$0017         ; $1200F6 ORI.B  #$0017,A4
        BTST    D1,(A2)                         ; $1200FA
        DC.W    $001F,$002F         ; $1200FC ORI.B  #$002F,(A7)+
        BTST    D0,$38(A7,D0.L)                 ; $120100
        BTST    D4,$003A002F                    ; $120104
        ADDI.B  #$0021,(A2)                     ; $12010A
        DC.W    $003B,$0033,$053C   ; $12010E ORI.B  #$0033,$3C(PC,D0.W)
        DC.W    $053D               ; $120114 BTST    D2,<EA:3D>
        DC.W    $053E               ; $120116 BTST    D2,<EA:3E>
        DC.W    $033F               ; $120118 BTST    D1,<EA:3F>
        ORI.W  #$0034,D0                        ; $12011A
        ORI.W  #$0612,D1                        ; $12011E
        DC.W    $0021,$002F         ; $120122 ORI.B  #$002F,-(A1)
        ORI.W  #$0043,D2                        ; $120126
        ADDI.B  #$0044,$45(A7,D0.W)             ; $12012A
        BCHG    #5,D1                           ; $120130
        ORI.W  #$0027,D1                        ; $120134
        BTST    D0,(A2)                         ; $120138
        DC.W    $0019,$0001         ; $12013A ORI.B  #$0001,(A1)+
        BTST    D1,D0                           ; $12013E
        DC.W    $0006,$0019         ; $120140 ORI.B  #$0019,D6
        DC.W    $0212,$0021         ; $120144 ANDI.B  #$0021,(A2)
        DC.W    $002F,$0035,$0040   ; $120148 ORI.B  #$0035,$0040(A7)
        DC.W    $003E,$0338         ; $12014E ORI.B  #$0338,<EA:3E>
        DC.W    $013E               ; $120152 BTST    D0,<EA:3E>
        ORI.W  #$0028,D1                        ; $120154
        BTST    D1,(A2)                         ; $120158
        DC.W    $001E,$0001         ; $12015A ORI.B  #$0001,(A6)+
        DC.W    $0200,$0112         ; $12015E ANDI.B  #$0112,D0
        BTST    D1,D0                           ; $120162
        DC.W    $0015,$0012         ; $120164 ORI.B  #$0012,(A5)
        DC.W    $0002,$0200         ; $120168 ORI.B  #$0200,D2
        DC.W    $0016,$0012         ; $12016C ORI.B  #$0012,(A6)
        DC.W    $4E00               ; $120170 DC.W    $4E00
        DC.W    $0035,$5A00,$000C   ; $120172 ORI.B  #$5A00,$0C(A5,D0.W)
        DC.W    $001C,$0212         ; $120178 ORI.B  #$0212,(A4)+
        DC.W    $0031,$0025,$0033   ; $12017C ORI.B  #$0025,$33(A1,D0.W)
        ORI.W  #$0B38,D6                        ; $120182
        BTST    D4,$003A0047                    ; $120186
        SUBI.B  #$0020,(A2)                     ; $12018C
        ORI.W  #$0044,A0                        ; $120190
        BTST    D0,$17380049                    ; $120194
        SUBI.B  #$0021,(A2)                     ; $12019A
        DC.W    $002C,$0035,$003F   ; $12019E ORI.B  #$0035,$003F(A4)
        BTST    D4,$0B39.W                      ; $1201A4
        DC.W    $003A,$0027,$0112   ; $1201A8 ORI.B  #$0027,$0112(PC)
        DC.W    $0019,$0001         ; $1201AE ORI.B  #$0001,(A1)+
        DC.W    $0200,$0001         ; $1201B2 ANDI.B  #$0001,D0
        DC.W    $000F,$0212         ; $1201B6 ORI.B  #$0212,A7
        DC.W    $0036,$004A,$003E   ; $1201BA ORI.B  #$004A,$3E(A6,D0.W)
        BTST    D4,$0042.W                      ; $1201C0
        ORI.W  #$0212,A3                        ; $1201C4
        DC.W    $0017,$0004         ; $1201C8 ORI.B  #$0004,(A7)
        DC.W    $0200,$0019         ; $1201CC ANDI.B  #$0019,D0
        DC.W    $001B,$0300         ; $1201D0 ORI.B  #$0300,(A3)+
        DC.W    $000D,$000F         ; $1201D4 ORI.B  #$000F,A5
        BTST    D1,D0                           ; $1201D8
        DC.W    $0004,$0016         ; $1201DA ORI.B  #$0016,D4
        DC.W    $4E00               ; $1201DE DC.W    $4E00
        DC.W    $0029,$5900,$000B   ; $1201E0 ORI.B  #$5900,$000B(A1)
        DC.W    $000F,$0212         ; $1201E6 ORI.B  #$0212,A7
        ORI.W  #$004D,A4                        ; $1201EA
        ORI.W  #$0D38,A6                        ; $1201EE
        BTST    D4,$003A0047                    ; $1201F2
        BTST    D1,(A2)                         ; $1201F8
        DC.W    $001F,$0022         ; $1201FA ORI.B  #$0022,(A7)+
        DC.W    $003C,$0239,$1738   ; $1201FE ORI.B  #$0239,#$1738
