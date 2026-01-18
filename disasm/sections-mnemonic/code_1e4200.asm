; Generated assembly for $1E4200-$1E6200
; Branch targets: 5
; Labels: 5
; Format: DC.W with decoded mnemonics as comments

        org     $1E4200

        MOVE.W  (A0)+,-$35(A7,D0.W)             ; $1E4200
        DC.W    $FFFF               ; $1E4204 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0015,$7003         ; $1E4206 ORI.B  #$7003,(A5)
        BTST    D0,D0                           ; $1E420A
        AND.B  D4,$2840(A1)                     ; $1E420C
        ORI.L  #$00E20400,-(A6)                 ; $1E4210
        DC.W    $0000,$00A6         ; $1E4216 ORI.B  #$00A6,D0
        DC.W    $FFE6               ; $1E421A MOVE.W  -(A6),<EA:3F>
        MOVE.W  -$51(A0,D0.W),$0005(A7)         ; $1E421C
        DC.W    $0021,$6F4D         ; $1E4222 ORI.B  #$6F4D,-(A1)
        BTST    D0,D0                           ; $1E4226
        AND.B  $3440(A0),D6                     ; $1E4228
        ORI.W  #$00EA,$70(PC,A7.L)              ; $1E422C
        DC.W    $00AF,$007B,$FFF4,$FF98; $1E4232 ORI.L  #$007BFFF4,-$0068(A7)
        DC.W    $03CB               ; $1E423A BSET    D1,A3
        DC.W    $0005,$0017         ; $1E423C ORI.B  #$0017,D5
        BLE.S  loc_1E42B9                       ; $1E4240
        BTST    D0,D0                           ; $1E4242
        AND.B  D4,$3420(A1)                     ; $1E4244
        ORI.W  #$0129,(A7)                      ; $1E4248
        MOVE.W  (A0)+,-$35(A7,D0.W)             ; $1E424C
        ORI.W  #$0035,(A7)                      ; $1E4250
        SUBI.B  #$0000,D0                       ; $1E4254
        DC.W    $0004,$000D         ; $1E4258 ORI.B  #$000D,D4
        BLE.S  loc_1E4256                       ; $1E425C
        BTST    D0,D0                           ; $1E425E
        AND.B  $3420(A2),D3                     ; $1E4260
        ORI.W  #$030F,(A7)                      ; $1E4264
        MOVE.W  (A0)+,-$35(A7,D0.W)             ; $1E4268
loc_1E426C:
        ORI.W  #$021C,(A7)                      ; $1E426C
        SUBI.B  #$0000,D0                       ; $1E4270
        DC.W    $0000,$000C         ; $1E4274 ORI.B  #$000C,D0
        MOVEQ   #-$2C,D0                        ; $1E4278
        BTST    D0,D0                           ; $1E427A
        AND.B  $3440(A2),D3                     ; $1E427C
        ORI.W  #$02D8,$70(PC,A7.L)              ; $1E4280
        DC.W    $00B0,$007B,$01E1,$FF98; $1E4286 ORI.L  #$007B01E1,-$68(A0,A7.L)
        DC.W    $03CB               ; $1E428E BSET    D1,A3
        DC.W    $0000,$0016         ; $1E4290 ORI.B  #$0016,D0
        BLE.S  loc_1E426C                       ; $1E4294
        BTST    D0,D0                           ; $1E4296
        AND.B  D4,$4840(A1)                     ; $1E4298
        SUBI.B  #$0000,D0                       ; $1E429C
        SUBI.B  #$0000,D0                       ; $1E42A0
        ORI.L  #$01DEFF70,-(A6)                 ; $1E42A4
        DC.W    $00B0,$0000,$001F,$6F26; $1E42AA ORI.L  #$0000001F,$26(A0,D6.L)
        BTST    D0,D0                           ; $1E42B2
        AND.B  $2840(A0),D6                     ; $1E42B4
        ORI.L  #$01DE0400,-(A6)                 ; $1E42B8
        DC.W    $0000,$00A6         ; $1E42BE ORI.B  #$00A6,D0
        DC.W    $00E2               ; $1E42C2 DC.W    $00E2
        MOVE.W  -$50(A0,D0.W),$0002(A7)         ; $1E42C4
        DC.W    $0020,$6F39         ; $1E42CA ORI.B  #$6F39,-(A0)
        BTST    D0,D0                           ; $1E42CE
        AND.B  $3440(A0),D6                     ; $1E42D0
        ORI.W  #$01E1,$70(PC,A7.L)              ; $1E42D4
        DC.W    $00B0,$007B,$00EA,$FF98; $1E42DA ORI.L  #$007B00EA,-$68(A0,A7.L)
        DC.W    $03CB               ; $1E42E2 BSET    D1,A3
        DC.W    $0003,$0016         ; $1E42E4 ORI.B  #$0016,D3
        BLE.S  loc_1E4292                       ; $1E42E8
        BTST    D0,D0                           ; $1E42EA
        AND.B  D4,$3420(A1)                     ; $1E42EC
        ORI.W  #$021C,(A7)                      ; $1E42F0
        MOVE.W  (A0)+,-$35(A7,D0.W)             ; $1E42F4
        ORI.W  #$0129,(A7)                      ; $1E42F8
        SUBI.B  #$0000,D0                       ; $1E42FC
        DC.W    $0002,$000D         ; $1E4300 ORI.B  #$000D,D2
        MOVEQ   #$68,D0                         ; $1E4304
        BTST    D0,D0                           ; $1E4306
        AND.B  $0920(A2),D3                     ; $1E4308
        ORI.W  #$03CE,$00(PC,D0.W)              ; $1E430C
        DC.W    $0000,$0400         ; $1E4312 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $1E4316 ORI.B  #$0400,D0
        DC.W    $0000,$FFEA         ; $1E431A ORI.B  #$FFEA,D0
        ORI.W  #$66B8,-(A4)                     ; $1E431E
        BTST    #9,D0                           ; $1E4322
        ADDQ.L  #8,-(A0)                        ; $1E4326
        SUBI.B  #$0000,D0                       ; $1E4328
        MOVE.W  $00B0(A5),$00A6(A7)             ; $1E432C
        DC.W    $FFE6               ; $1E4332 MOVE.W  -(A6),<EA:3F>
        SUBI.B  #$0000,D0                       ; $1E4334
        DC.W    $002F,$FFA4,$6EF2   ; $1E4338 ORI.B  #$FFA4,$6EF2(A7)
        BTST    #8,D0                           ; $1E433E
        NOT.L  D0                               ; $1E4342
        SUBI.B  #$0000,D0                       ; $1E4344
        ORI.W  #$0035,(A7)                      ; $1E4348
        MOVE.W  (A5),-$33(A7,D0.W)              ; $1E434C
        ORI.L  #$FF2D0019,A6                    ; $1E4350
        MOVE.W  (A5)+,$7D(A7,D7.W)              ; $1E4356
        BTST    #10,D0                          ; $1E435A
        MOVE.L  -(A0),D4                        ; $1E435E
        ORI.W  #$FF50,$00(PC,D0.W)              ; $1E4360
        DC.W    $0000,$00B5         ; $1E4366 ORI.B  #$00B5,D0
        MOVE.W  -(A3),(A7)+                     ; $1E436A
        SUBI.B  #$0000,D0                       ; $1E436C
        DC.W    $003C,$FF3D,$6D0B   ; $1E4370 ORI.B  #$FF3D,#$6D0B
        BTST    #9,D0                           ; $1E4376
        MOVE.B  (A0),(A0)+                      ; $1E437A
        ORI.W  #$FF50,-$6B(PC,A7.L)             ; $1E437C
        DC.W    $03CD               ; $1E4382 BSET    D1,A5
        ORI.W  #$FFF4,$6D(PC,A7.L)              ; $1E4384
        DC.W    $00B0,$0024,$FFA0,$6F2F; $1E438A ORI.L  #$0024FFA0,$2F(A0,D6.L)
        BTST    #9,D0                           ; $1E4392
        DC.W    $0008,$4820         ; $1E4396 ORI.B  #$4820,A0
        SUBI.B  #$0000,D0                       ; $1E439A
        SUBI.B  #$0000,D0                       ; $1E439E
        ORI.W  #$03BE,(A7)                      ; $1E43A2
        SUBI.B  #$0000,D0                       ; $1E43A6
        DC.W    $FFFE               ; $1E43AA MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $000C,$70E0         ; $1E43AC ORI.B  #$70E0,A4
        BTST    D0,D0                           ; $1E43B0
        AND.B  $2840(A2),D3                     ; $1E43B2
        ORI.W  #$01D7,(A7)                      ; $1E43B6
        SUBI.B  #$0000,D0                       ; $1E43BA
        ORI.W  #$00E4,(A7)                      ; $1E43BE
        MOVE.W  $02D7(PC),$04(A7,D0.W)          ; $1E43C2
        DC.W    $000D,$7090         ; $1E43C8 ORI.B  #$7090,A5
        BTST    D0,D0                           ; $1E43CC
        AND.B  $5420(A2),D3                     ; $1E43CE
        SUBI.B  #$0000,D0                       ; $1E43D2
        DC.W    $FFB9,$02D7,$0038,$02F0; $1E43D6 MOVE.W  $02D70038,-$10(A7,D0.W)
        SUBI.B  #$0000,D0                       ; $1E43DE
        DC.W    $FFFE               ; $1E43E2 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $0003,$71F6         ; $1E43E4 ORI.B  #$71F6,D3
        BTST    D0,D0                           ; $1E43E8
        AND.B  $2840(A3),D2                     ; $1E43EA
        ORI.W  #$03BE,(A7)                      ; $1E43EE
        SUBI.B  #$0000,D0                       ; $1E43F2
        ORI.W  #$02CB,(A7)                      ; $1E43F6
        DC.W    $FFB9,$02D7,$0000,$000C; $1E43FA MOVE.W  $02D70000,$0C(A7,D0.W)
        MOVEQ   #-$3A,D0                        ; $1E4402
        BTST    D0,D0                           ; $1E4404
        AND.B  $3420(A2),D3                     ; $1E4406
        DC.W    $0038,$01FF,$FFBA   ; $1E440A ORI.B  #$01FF,$FFBA.W
        DC.W    $02D7               ; $1E4410 DC.W    $02D7
        DC.W    $0038,$010D,$0400   ; $1E4412 ORI.B  #$010D,$0400.W
        DC.W    $0000,$0002         ; $1E4418 ORI.B  #$0002,D0
        DC.W    $0004,$7146         ; $1E441C ORI.B  #$7146,D4
        BTST    D0,D0                           ; $1E4420
        AND.B  $3420(A3),D2                     ; $1E4422
        DC.W    $0038,$02F0,$FFBA   ; $1E4426 ORI.B  #$02F0,$FFBA.W
        DC.W    $02D7               ; $1E442C DC.W    $02D7
        DC.W    $0038,$01FF,$0400   ; $1E442E ORI.B  #$01FF,$0400.W
        DC.W    $0000,$0000         ; $1E4434 ORI.B  #$0000,D0
        DC.W    $0004,$719F         ; $1E4438 ORI.B  #$719F,D4
        BTST    D0,D0                           ; $1E443C
        AND.B  $2840(A3),D2                     ; $1E443E
        ORI.W  #$02CB,(A7)                      ; $1E4442
        SUBI.B  #$0000,D0                       ; $1E4446
        ORI.W  #$01D7,(A7)                      ; $1E444A
        MOVE.W  $02D7(PC),$02(A7,D0.W)          ; $1E444E
        DC.W    $000D,$70AB         ; $1E4454 ORI.B  #$70AB,A5
        BTST    D0,D0                           ; $1E4458
        AND.B  $3420(A2),D3                     ; $1E445A
        DC.W    $0038,$010D,$FFB6   ; $1E445E ORI.B  #$010D,$FFB6.W
        DC.W    $02D9               ; $1E4464 DC.W    $02D9
        ORI.W  #$0075,$0400(A5)                 ; $1E4466
        DC.W    $0000,$000F         ; $1E446C ORI.B  #$000F,D0
        MOVE.W  (A3)+,-$69(A7,D7.W)             ; $1E4470
        BTST    #11,D0                          ; $1E4474
        OR.B   D2,D0                            ; $1E4478
        MOVE.W  -$27(A6,D0.W),$57(A7,D0.W)      ; $1E447A
        DC.W    $00E4               ; $1E4480 DC.W    $00E4
        SUBI.B  #$0000,D0                       ; $1E4482
        ORI.L  #$00490019,A6                    ; $1E4486
        MOVE.W  (A5)+,-$54(A7,D7.W)             ; $1E448C
        BTST    #10,D0                          ; $1E4490
        DC.W    $0006,$4840         ; $1E4494 ORI.B  #$4840,D6
        SUBI.B  #$0000,D0                       ; $1E4498
        SUBI.B  #$0000,D0                       ; $1E449C
        DC.W    $0038,$0361,$FFD6   ; $1E44A0 ORI.B  #$0361,$FFD6.W
        BSET    D0,(A5)+                        ; $1E44A6
        DC.W    $FFFE               ; $1E44A8 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $0003,$71A0         ; $1E44AA ORI.B  #$71A0,D3
        BTST    D0,D0                           ; $1E44AE
        AND.B  $2840(A3),D2                     ; $1E44B0
        DC.W    $0038,$026F,$0400   ; $1E44B4 ORI.B  #$026F,$0400.W
        DC.W    $0000,$0038         ; $1E44BA ORI.B  #$0038,D0
        DC.W    $017E               ; $1E44BE BCHG    D0,<EA:3E>
        DC.W    $FFD6               ; $1E44C0 MOVE.W  (A6),<EA:3F>
        BSET    D0,(A5)+                        ; $1E44C2
        DC.W    $0002,$0004         ; $1E44C4 ORI.B  #$0004,D2
        MOVE.W  (A2),$00(A0,D0.W)               ; $1E44C8
        AND.B  $2840(A3),D2                     ; $1E44CC
        DC.W    $0038,$0361,$0400   ; $1E44D0 ORI.B  #$0361,$0400.W
        DC.W    $0000,$0038         ; $1E44D6 ORI.B  #$0038,D0
        ANDI.W  #$FFD6,$01DD(A7)                ; $1E44DA
        DC.W    $0000,$0004         ; $1E44E0 ORI.B  #$0004,D0
        MOVE.W  (A1)+,$00(A0,D0.W)              ; $1E44E4
        AND.B  $5420(A3),D2                     ; $1E44E8
        SUBI.B  #$0000,D0                       ; $1E44EC
        DC.W    $FFD6               ; $1E44F0 MOVE.W  (A6),<EA:3F>
        BSET    D0,(A5)+                        ; $1E44F2
        BCHG    D0,(A0)                         ; $1E44F4
        ANDI.L  #$04000000,D4                   ; $1E44F6
        DC.W    $0000,$0000         ; $1E44FC ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4500
        BTST    D0,(A0)                         ; $1E4502
        AND.B  -$5EF0(A4),D4                    ; $1E4504
        DC.W    $FFD6               ; $1E4508 MOVE.W  (A6),<EA:3F>
        BSET    D0,(A5)+                        ; $1E450A
        MOVE.W  D6,$02(A7,D0.W)                 ; $1E450C
        SUBI.B  #$0000,D0                       ; $1E4510
        BCHG    D0,(A0)                         ; $1E4514
        ANDI.L  #$00000000,D4                   ; $1E4516
        MOVEQ   #$00,D1                         ; $1E451C
        BTST    D0,(A0)                         ; $1E451E
        AND.B  -$5F60(A4),D4                    ; $1E4520
        DC.W    $FFD6               ; $1E4524 MOVE.W  (A6),<EA:3F>
        BSET    D0,(A5)+                        ; $1E4526
        DC.W    $001D,$0195         ; $1E4528 ORI.B  #$0195,(A5)+
        MOVE.W  D6,$02(A7,D0.W)                 ; $1E452C
        SUBI.B  #$0000,D0                       ; $1E4530
        DC.W    $0000,$0000         ; $1E4534 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4538
        BTST    D0,(A0)                         ; $1E453A
        AND.B  $2820(A4),D4                     ; $1E453C
        DC.W    $0038,$017E,$0400   ; $1E4540 ORI.B  #$017E,$0400.W
        DC.W    $0000,$006D         ; $1E4546 ORI.B  #$006D,D0
        BCHG    D0,(A0)                         ; $1E454A
        SUBI.B  #$0000,D0                       ; $1E454C
        DC.W    $000F,$FF9B         ; $1E4550 ORI.B  #$FF9B,A7
        MOVEQ   #-$80,D3                        ; $1E4554
        BTST    #11,D0                          ; $1E4556
        DC.W    $0003,$1150         ; $1E455A ORI.B  #$1150,D3
        DC.W    $0005,$01D9         ; $1E455E ORI.B  #$01D9,D5
        DC.W    $0004,$03EA         ; $1E4562 ORI.B  #$03EA,D4
        SUBI.B  #$0000,D0                       ; $1E4566
        DC.W    $FFEF,$00E2         ; $1E456A MOVE.W  $00E2(A7),<EA:3F>
        DC.W    $0000,$0000         ; $1E456E ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4572
        BTST    D0,(A0)                         ; $1E4574
        AND.B  $4220(A5),D0                     ; $1E4576
        SUBI.B  #$0000,D0                       ; $1E457A
        MOVE.W  D6,$0E(A7,D0.W)                 ; $1E457E
        DC.W    $FFEF,$00E2         ; $1E4582 MOVE.W  $00E2(A7),<EA:3F>
        SUBI.B  #$0000,D0                       ; $1E4586
        DC.W    $0000,$0000         ; $1E458A ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E458E
        BTST    D0,(A0)                         ; $1E4590
        AND.B  $40A0(A4),D4                     ; $1E4592
        SUBI.B  #$0000,D0                       ; $1E4596
        DC.W    $001D,$01D0         ; $1E459A ORI.B  #$01D0,(A5)+
        MOVE.W  D6,$0E(A7,D0.W)                 ; $1E459E
        SUBI.B  #$0000,D0                       ; $1E45A2
        DC.W    $0000,$0000         ; $1E45A6 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E45AA
        BTST    D0,(A0)                         ; $1E45AC
        AND.B  $0950(A4),D4                     ; $1E45AE
        DC.W    $FFF1,$0203         ; $1E45B2 MOVE.W  $03(A1,D0.W),<EA:3F>
        SUBI.B  #$0000,D0                       ; $1E45B6
        SUBI.B  #$0000,D0                       ; $1E45BA
        DC.W    $0004,$03EA         ; $1E45BE ORI.B  #$03EA,D4
        DC.W    $0000,$0000         ; $1E45C2 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E45C6
        BTST    D0,(A0)                         ; $1E45C8
        CMP.B  $0001(A6),D7                     ; $1E45CA
        BCHG    D4,(A0)                         ; $1E45CE
        DC.W    $FFDA               ; $1E45D0 MOVE.W  (A2)+,<EA:3F>
        DC.W    $0207,$0400         ; $1E45D2 ANDI.B  #$0400,D7
        DC.W    $0000,$0400         ; $1E45D6 ORI.B  #$0400,D0
        DC.W    $0000,$001A         ; $1E45DA ORI.B  #$001A,D0
        DC.W    $02F3               ; $1E45DE DC.W    $02F3
        DC.W    $0000,$0000         ; $1E45E0 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E45E4
        BTST    D0,(A0)                         ; $1E45E6
        CMP.B  $1120(A7),D6                     ; $1E45E8
        DC.W    $FFF1,$01E4         ; $1E45EC MOVE.W  -$1C(A1,D0.W),<EA:3F>
        DC.W    $001A,$02F3         ; $1E45F0 ORI.B  #$02F3,(A2)+
        SUBI.B  #$0000,D0                       ; $1E45F4
        SUBI.B  #$0000,D0                       ; $1E45F8
        DC.W    $0000,$0000         ; $1E45FC ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4600
        BTST    D0,(A0)                         ; $1E4602
        CMP.B  $0001(A6),D7                     ; $1E4604
        BCHG    D4,(A0)                         ; $1E4608
        DC.W    $FFC0               ; $1E460A MOVE.W  D0,<EA:3F>
        BSET    D0,(A5)                         ; $1E460C
        SUBI.B  #$0000,D0                       ; $1E460E
        SUBI.B  #$0000,D0                       ; $1E4612
        DC.W    $0032,$01FC,$0000   ; $1E4616 ORI.B  #$01FC,$00(A2,D0.W)
        DC.W    $0000,$7200         ; $1E461C ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E4620
        CMP.B  $20(A0,D1.W),D5                  ; $1E4622
        DC.W    $FFDA               ; $1E4626 MOVE.W  (A2)+,<EA:3F>
        BCLR    D0,$0032(PC)                    ; $1E4628
        BSET    D0,#$0400                       ; $1E462C
        DC.W    $0000,$0400         ; $1E4630 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $1E4634 ORI.B  #$0000,D0
        DC.W    $0000,$7200         ; $1E4638 ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E463C
        CMP.B  $0001(A7),D6                     ; $1E463E
        MOVE.B  -(A0),-(A0)                     ; $1E4642
        DC.W    $FFC0               ; $1E4644 MOVE.W  D0,<EA:3F>
        BCHG    D0,(A5)                         ; $1E4646
        ORI.W  #$0108,A6                        ; $1E4648
        SUBI.B  #$0000,D0                       ; $1E464C
        SUBI.B  #$0000,D0                       ; $1E4650
        DC.W    $0000,$0000         ; $1E4654 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4658
        BTST    D0,(A0)                         ; $1E465A
        CMP.B  $50(A0,D0.L),D5                  ; $1E465C
        MOVE.W  -(A3),$67(A7,D0.W)              ; $1E4660
        SUBI.B  #$0000,D0                       ; $1E4664
        SUBI.B  #$0000,D0                       ; $1E4668
        ORI.W  #$0108,A6                        ; $1E466C
        DC.W    $0000,$0000         ; $1E4670 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4674
        BTST    D0,(A0)                         ; $1E4676
        CMP.B  $02(A1,D0.W),D4                  ; $1E4678
        DC.W    $4950               ; $1E467C DC.W    $4950
        SUBI.B  #$0000,D0                       ; $1E467E
        SUBI.B  #$0000,D0                       ; $1E4682
        SUBI.B  #$0000,D0                       ; $1E4686
        ORI.L  #$033F0000,(A0)                  ; $1E468A
        DC.W    $0000,$7200         ; $1E4690 ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E4694
        EOR.B  D1,$20(A3,D1.W)                  ; $1E4696
        MOVE.W  -(A3),-$54(A7,D0.W)             ; $1E469A
        ORI.W  #$001C,$0400(A5)                 ; $1E469E
        DC.W    $0000,$0400         ; $1E46A4 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $1E46A8 ORI.B  #$0000,D0
        DC.W    $0000,$7200         ; $1E46AC ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E46B0
        CMP.B  -$30(A1,D1.W),D4                 ; $1E46B2
        MOVE.W  D2,-$50(A7,D0.W)                ; $1E46B6
        ORI.L  #$033FFF82,(A0)                  ; $1E46BA
        SUBI.L  #$006D001C,A5                   ; $1E46C0
        DC.W    $0000,$0000         ; $1E46C6 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E46CA
        BTST    D0,(A0)                         ; $1E46CC
        CMP.B  $02(A2,D0.W),D3                  ; $1E46CE
        MOVEM.L (A0),A2                         ; $1E46D2
        DC.W    $0000,$0400         ; $1E46D6 ORI.B  #$0400,D0
        DC.W    $0000,$FF2F         ; $1E46DA ORI.B  #$FF2F,D0
        BSET    D1,-(A0)                        ; $1E46DE
        DC.W    $00BA,$0280,$0000,$0000; $1E46E0 ORI.L  #$02800000,$0000(PC)
        MOVEQ   #$00,D1                         ; $1E46E8
        BTST    D0,(A0)                         ; $1E46EA
        CMP.B  -$30(A4,D5.W),D0                 ; $1E46EC
        SUBI.B  #$0000,D0                       ; $1E46F0
        DC.W    $00BA,$0280,$FF5C,$0394; $1E46F4 ORI.L  #$0280FF5C,$0394(PC)
        ORI.L  #$FF400000,(A0)                  ; $1E46FC
        DC.W    $0000,$7200         ; $1E4702 ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E4706
        EOR.B  D1,-$60(A3,D5.W)                 ; $1E4708
        SUBI.B  #$0000,D0                       ; $1E470C
        ORI.L  #$FF40FF82,(A0)                  ; $1E4710
        BCLR    D1,(A0)                         ; $1E4716
        SUBI.B  #$0000,D0                       ; $1E4718
        DC.W    $0000,$0000         ; $1E471C ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4720
        BTST    D0,(A0)                         ; $1E4722
        CMP.B  $01(A2,D0.W),D3                  ; $1E4724
        MOVE.W  -(A0),-(A2)                     ; $1E4728
        MOVE.W  (A2)+,(A7)                      ; $1E472A
        DC.W    $02F7               ; $1E472C DC.W    $02F7
        DC.W    $00EA               ; $1E472E DC.W    $00EA
        BSET    D0,$00(A1,D0.W)                 ; $1E4730
        DC.W    $0000,$0400         ; $1E4734 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $1E4738 ORI.B  #$0000,D0
        DC.W    $0000,$7200         ; $1E473C ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E4740
        MOVE.L  -$60(A5,D5.W),-(A3)             ; $1E4742
        SUBI.B  #$0000,D0                       ; $1E4746
        DC.W    $00EA               ; $1E474A DC.W    $00EA
        BSET    D0,$2F(A1,A7.L)                 ; $1E474C
        DC.W    $023D,$0400         ; $1E4750 ANDI.B  #$0400,<EA:3D>
        DC.W    $0000,$0000         ; $1E4754 ORI.B  #$0000,D0
        DC.W    $0000,$7200         ; $1E4758 ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E475C
        CMP.B  $00(A4,D0.W),D0                  ; $1E475E
        MOVE.L  -(A0),-(A4)                     ; $1E4762
        MOVE.W  (A2)+,(A7)                      ; $1E4764
        DC.W    $002A,$0400,$0000   ; $1E4766 ORI.B  #$0400,$0000(A2)
        SUBI.B  #$0000,D0                       ; $1E476C
        SUBI.B  #$0000,D0                       ; $1E4770
        DC.W    $0000,$0000         ; $1E4774 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4778
        BTST    D0,(A0)                         ; $1E477A
        MOVE.L  $03(A5,D0.W),-(A3)              ; $1E477C
        ADDQ.L  #8,-(A0)                        ; $1E4780
        SUBI.B  #$0000,D0                       ; $1E4782
        MOVE.W  -$70(A4,D0.W),$00A6(A7)         ; $1E4786
        MOVE.W  $00(A2,D0.W),-(A7)              ; $1E478C
        DC.W    $0000,$FFE6         ; $1E4790 ORI.B  #$FFE6,D0
        ORI.W  #$7674,-(A3)                     ; $1E4794
        BTST    #8,D0                           ; $1E4798
        MOVEM.L (A0),A2                         ; $1E479C
        DC.W    $0000,$0400         ; $1E47A0 ORI.B  #$0400,D0
        DC.W    $0000,$007B         ; $1E47A4 ORI.B  #$007B,D0
        DC.W    $FF7D,$FF74         ; $1E47A8 MOVE.W  <EA:3D>,-$008C(A7)
        BCLR    D1,(A0)                         ; $1E47AC
        DC.W    $FFEA,$0064         ; $1E47AE MOVE.W  $0064(A2),<EA:3F>
        DC.W    $75FF,$0800         ; $1E47B2 MOVE.W  <EA:3F>,$0800(PC)
        AND.B  D4,$4210(A1)                     ; $1E47B6
        SUBI.B  #$0000,D0                       ; $1E47BA
        ORI.L  #$FF32FF70,-(A6)                 ; $1E47BE
        BCLR    D1,(A1)                         ; $1E47C4
        ORI.W  #$FFDA,-$3A(A4,A7.L)             ; $1E47C6
        DC.W    $00C4               ; $1E47CC DC.W    $00C4
        MOVEQ   #-$14,D4                        ; $1E47CE
        BTST    #8,D0                           ; $1E47D0
        MOVE.L  -(A0),(A0)                      ; $1E47D4
        MOVE.W  -$6F(A0,D0.W),$007B(A7)         ; $1E47D6
        DC.W    $FF7D,$004A         ; $1E47DC MOVE.W  <EA:3D>,$004A(A7)
        DC.W    $0021,$0400         ; $1E47E0 ORI.B  #$0400,-(A1)
        DC.W    $0000,$FFD2         ; $1E47E4 ORI.B  #$FFD2,D0
        DC.W    $00C7               ; $1E47E8 DC.W    $00C7
        MOVE.W  (A2)+,$00(A3,D0.L)              ; $1E47EA
        AND.B  D4,$0004(A1)                     ; $1E47EE
        MOVE.W  -(A0),-(A2)                     ; $1E47F2
        ORI.W  #$0003,(A7)                      ; $1E47F4
        MOVE.W  (A0)+,-$06(A7,D0.W)             ; $1E47F8
        SUBI.B  #$0000,D0                       ; $1E47FC
        SUBI.B  #$0000,D0                       ; $1E4800
        DC.W    $FFFE               ; $1E4804 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $000C,$72CC         ; $1E4806 ORI.B  #$72CC,A4
        BTST    D0,D0                           ; $1E480A
        AND.B  $2940(A2),D3                     ; $1E480C
        ORI.W  #$FFCF,$00(PC,D0.W)              ; $1E4810
        DC.W    $0000,$0400         ; $1E4816 ORI.B  #$0400,D0
        DC.W    $0000,$FF98         ; $1E481A ORI.B  #$FF98,D0
        DC.W    $02FA               ; $1E481E DC.W    $02FA
        DC.W    $FFFF               ; $1E4820 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0015,$72B3         ; $1E4822 ORI.B  #$72B3,(A5)
        BTST    D0,D0                           ; $1E4826
        AND.B  D4,$10A0(A1)                     ; $1E4828
        ORI.W  #$FFCF,-$65(PC,A7.L)             ; $1E482C
        DC.W    $02F9               ; $1E4832 DC.W    $02F9
        ORI.W  #$0073,$00(PC,D0.W)              ; $1E4834
        DC.W    $0000,$FFEA         ; $1E483A ORI.B  #$FFEA,D0
        ORI.W  #$7338,-(A4)                     ; $1E483E
        BTST    #9,D0                           ; $1E4842
        NEGX.L -(A0)                            ; $1E4846
        SUBI.B  #$0000,D0                       ; $1E4848
        ORI.W  #$0073,$4A(PC,D0.W)              ; $1E484C
        DC.W    $00B6,$0400,$0000,$FFD2; $1E4852 ORI.L  #$04000000,-$2E(A6,A7.L)
        DC.W    $00C7               ; $1E485A DC.W    $00C7
        MOVE.W  (A0),$0800.W                    ; $1E485C
        AND.B  D4,-$5EF0(A1)                    ; $1E4860
        MOVE.W  (A3)+,-$07(A7,D0.W)             ; $1E4864
        ORI.W  #$0003,(A7)                      ; $1E4868
        SUBI.B  #$0000,D0                       ; $1E486C
        DC.W    $0026,$00E8         ; $1E4870 ORI.B  #$00E8,-(A6)
        DC.W    $FFED,$0064         ; $1E4874 MOVE.W  $0064(A5),<EA:3F>
        MOVEQ   #-$11,D1                        ; $1E4878
        BTST    #10,D0                          ; $1E487A
        DC.W    $0005,$3420         ; $1E487E ORI.B  #$3420,D5
        DC.W    $0038,$00D3,$FFBA   ; $1E4882 ORI.B  #$00D3,$FFBA.W
        ANDI.W  #$0038,A1                       ; $1E4888
        DC.W    $FFE2               ; $1E488C MOVE.W  -(A2),<EA:3F>
        SUBI.B  #$0000,D0                       ; $1E488E
        DC.W    $FFFB,$0003         ; $1E4892 MOVE.W  $03(PC,D0.W),<EA:3F>
        MOVEQ   #-$3F,D1                        ; $1E4896
        BTST    D0,D0                           ; $1E4898
        AND.B  $2840(A3),D2                     ; $1E489A
        ORI.W  #$00B1,(A7)                      ; $1E489E
        SUBI.B  #$0000,D0                       ; $1E48A2
        ORI.W  #$FFBF,(A7)                      ; $1E48A6
        MOVE.W  $0249(PC),-$02(A7,A7.L)         ; $1E48AA
        DC.W    $000C,$7270         ; $1E48B0 ORI.B  #$7270,A4
        BTST    D0,D0                           ; $1E48B4
        AND.B  $3520(A2),D3                     ; $1E48B6
        DC.W    $0038,$FFE2,$FFB9   ; $1E48BA ORI.B  #$FFE2,$FFB9.W
        ANDI.W  #$0400,A1                       ; $1E48C0
        DC.W    $0000,$0400         ; $1E48C4 ORI.B  #$0400,D0
        DC.W    $0000,$FFFE         ; $1E48C8 ORI.B  #$FFFE,D0
        DC.W    $0003,$7276         ; $1E48CC ORI.B  #$7276,D3
        BTST    D0,D0                           ; $1E48D0
        AND.B  $2940(A3),D2                     ; $1E48D2
        ORI.W  #$FFBF,(A7)                      ; $1E48D6
        SUBI.B  #$0000,D0                       ; $1E48DA
        SUBI.B  #$0000,D0                       ; $1E48DE
        DC.W    $FFB9,$0249,$0000,$000C; $1E48E2 MOVE.W  $02490000,$0C(A7,D0.W)
        MOVEQ   #$64,D1                         ; $1E48EA
        BTST    D0,D0                           ; $1E48EC
        AND.B  $4210(A2),D3                     ; $1E48EE
        SUBI.B  #$0000,D0                       ; $1E48F2
        ORI.W  #$00B1,(A7)                      ; $1E48F6
        DC.W    $FFBD,$0248         ; $1E48FA MOVE.W  <EA:3D>,$48(A7,D0.W)
        DC.W    $0026,$0136         ; $1E48FE ORI.B  #$0136,-(A6)
        DC.W    $FFED,$0064         ; $1E4902 MOVE.W  $0064(A5),<EA:3F>
        MOVEQ   #-$75,D0                        ; $1E4906
        BTST    #10,D0                          ; $1E4908
        MOVE.L  -(A0),(A0)                      ; $1E490C
        DC.W    $FFBD,$0248         ; $1E490E MOVE.W  <EA:3D>,$48(A7,D0.W)
        DC.W    $0038,$00D3,$0007   ; $1E4912 ORI.B  #$00D3,$0007.W
        BCHG    D0,(A6)                         ; $1E4918
        SUBI.B  #$0000,D0                       ; $1E491A
        DC.W    $FFF0,$0065         ; $1E491E MOVE.W  $65(A0,D0.W),<EA:3F>
        MOVEQ   #$62,D0                         ; $1E4922
        BTST    #11,D0                          ; $1E4924
        DC.W    $0005,$2840         ; $1E4928 ORI.B  #$2840,D5
        DC.W    $0038,$0143,$0400   ; $1E492C ORI.B  #$0143,$0400.W
        DC.W    $0000,$0038         ; $1E4932 ORI.B  #$0038,D0
        ORI.W  #$FFD6,(A2)                      ; $1E4936
        DC.W    $0188               ; $1E493A BCLR    D0,A0
        DC.W    $FFFB,$0003         ; $1E493C MOVE.W  $03(PC,D0.W),<EA:3F>
        MOVEQ   #$1E,D1                         ; $1E4940
        BTST    D0,D0                           ; $1E4942
        AND.B  $2940(A3),D2                     ; $1E4944
        DC.W    $0038,$0052,$0400   ; $1E4948 ORI.B  #$0052,$0400.W
        DC.W    $0000,$0400         ; $1E494E ORI.B  #$0400,D0
        DC.W    $0000,$FFD6         ; $1E4952 ORI.B  #$FFD6,D0
        DC.W    $0189               ; $1E4956 BCLR    D0,A1
        DC.W    $FFFE               ; $1E4958 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $0003,$7220         ; $1E495A ORI.B  #$7220,D3
        BTST    D0,D0                           ; $1E495E
        AND.B  $3420(A3),D2                     ; $1E4960
        DC.W    $00B3,$FFF7,$FFD6,$0189; $1E4964 ORI.L  #$FFF7FFD6,-$77(A3,D0.W)
        BCHG    D0,(A0)                         ; $1E496C
        MOVE.W  D5,(A7)                         ; $1E496E
        SUBI.B  #$0000,D0                       ; $1E4970
        DC.W    $0000,$0000         ; $1E4974 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4978
        BTST    D0,(A0)                         ; $1E497A
        AND.B  $4910(A4),D4                     ; $1E497C
        SUBI.B  #$0000,D0                       ; $1E4980
        SUBI.B  #$0000,D0                       ; $1E4984
        SUBI.B  #$0000,D0                       ; $1E4988
        BCHG    D0,(A0)                         ; $1E498C
        MOVE.W  D5,(A7)                         ; $1E498E
        DC.W    $0000,$0000         ; $1E4990 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4994
        BTST    D0,(A0)                         ; $1E4996
        AND.B  $3420(A4),D4                     ; $1E4998
        DC.W    $001D,$0156         ; $1E499C ORI.B  #$0156,(A5)+
        DC.W    $FFD6               ; $1E49A0 MOVE.W  (A6),<EA:3F>
        DC.W    $0188               ; $1E49A2 BCLR    D0,A0
        DC.W    $00B3,$FFF7,$0400,$0000; $1E49A4 ORI.L  #$FFF70400,$00(A3,D0.W)
        DC.W    $0000,$0000         ; $1E49AC ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E49B0
        BTST    D0,(A0)                         ; $1E49B2
        AND.B  $40A0(A4),D4                     ; $1E49B4
        SUBI.B  #$0000,D0                       ; $1E49B8
        DC.W    $0038,$0143,$0007   ; $1E49BC ORI.B  #$0143,$0007.W
        BCHG    D0,-(A6)                        ; $1E49C2
        SUBI.B  #$0000,D0                       ; $1E49C4
        DC.W    $FFF0,$0065         ; $1E49C8 MOVE.W  $65(A0,D0.W),<EA:3F>
        BGT.S  loc_1E4A12                       ; $1E49CC
        BTST    #11,D0                          ; $1E49CE
        DC.W    $0004,$2820         ; $1E49D2 ORI.B  #$2820,D4
        DC.W    $00B3,$015D,$0400,$0000; $1E49D6 ORI.L  #$015D0400,$00(A3,D0.W)
        BCHG    D0,(A0)                         ; $1E49DE
        BTST    D0,-(A6)                        ; $1E49E0
        SUBI.B  #$0000,D0                       ; $1E49E2
        DC.W    $0000,$0000         ; $1E49E6 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E49EA
        BTST    D0,(A0)                         ; $1E49EC
        AND.B  $50D0(A4),D4                     ; $1E49EE
        SUBI.B  #$0000,D0                       ; $1E49F2
        DC.W    $0004,$03F4         ; $1E49F6 ORI.B  #$03F4,D4
        DC.W    $0005,$0199         ; $1E49FA ORI.B  #$0199,D5
        DC.W    $FFEF,$00C0         ; $1E49FE MOVE.W  $00C0(A7),<EA:3F>
        DC.W    $0000,$0000         ; $1E4A02 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4A06
        BTST    D0,(A0)                         ; $1E4A08
        AND.B  $4A10(A5),D0                     ; $1E4A0A
        SUBI.B  #$0000,D0                       ; $1E4A0E
loc_1E4A12:
        SUBI.B  #$0000,D0                       ; $1E4A12
        DC.W    $FFEF,$00C0         ; $1E4A16 MOVE.W  $00C0(A7),<EA:3F>
        BCHG    D0,(A0)                         ; $1E4A1A
        BTST    D0,-(A6)                        ; $1E4A1C
        DC.W    $0000,$0000         ; $1E4A1E ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4A22
        BTST    D0,(A0)                         ; $1E4A24
        AND.B  $2820(A4),D4                     ; $1E4A26
        DC.W    $001D,$0191         ; $1E4A2A ORI.B  #$0191,(A5)+
        SUBI.B  #$0000,D0                       ; $1E4A2E
        DC.W    $00B3,$015D,$0400,$0000; $1E4A32 ORI.L  #$015D0400,$00(A3,D0.W)
        DC.W    $0000,$0000         ; $1E4A3A ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4A3E
        BTST    D0,(A0)                         ; $1E4A40
        AND.B  $48D0(A4),D4                     ; $1E4A42
        SUBI.B  #$0000,D0                       ; $1E4A46
        SUBI.B  #$0000,D0                       ; $1E4A4A
        DC.W    $FFF1,$01C4         ; $1E4A4E MOVE.W  -$3C(A1,D0.W),<EA:3F>
        DC.W    $0004,$03F4         ; $1E4A52 ORI.B  #$03F4,D4
        DC.W    $0000,$0000         ; $1E4A56 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4A5A
        BTST    D0,(A0)                         ; $1E4A5C
        CMP.B  $0001(A6),D7                     ; $1E4A5E
        MOVEM.L (A0),A2                         ; $1E4A62
        DC.W    $0000,$0400         ; $1E4A66 ORI.B  #$0400,D0
        DC.W    $0000,$FFDA         ; $1E4A6A ORI.B  #$FFDA,D0
        DC.W    $01C9               ; $1E4A6E BSET    D0,A1
        DC.W    $001A,$0329         ; $1E4A70 ORI.B  #$0329,(A2)+
        DC.W    $0000,$0000         ; $1E4A74 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4A78
        BTST    D0,(A0)                         ; $1E4A7A
        CMP.B  $50A0(A7),D6                     ; $1E4A7C
        SUBI.B  #$0000,D0                       ; $1E4A80
        DC.W    $001A,$0329         ; $1E4A84 ORI.B  #$0329,(A2)+
        DC.W    $FFF1,$01A4         ; $1E4A88 MOVE.W  -$5C(A1,D0.W),<EA:3F>
        SUBI.B  #$0000,D0                       ; $1E4A8C
        DC.W    $0000,$0000         ; $1E4A90 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4A94
        BTST    D0,(A0)                         ; $1E4A96
        CMP.B  $0001(A6),D7                     ; $1E4A98
        MOVEM.L (A0),A2                         ; $1E4A9C
        DC.W    $0000,$0400         ; $1E4AA0 ORI.B  #$0400,D0
        DC.W    $0000,$FFC0         ; $1E4AA4 ORI.B  #$FFC0,D0
        BCLR    D0,(A5)+                        ; $1E4AA8
        DC.W    $0032,$0262,$0000   ; $1E4AAA ORI.B  #$0262,$00(A2,D0.W)
        DC.W    $0000,$7200         ; $1E4AB0 ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E4AB4
        CMP.B  -$60(A0,D5.W),D5                 ; $1E4AB6
        SUBI.B  #$0000,D0                       ; $1E4ABA
        DC.W    $0032,$0262,$FFDA   ; $1E4ABE ORI.B  #$0262,-$26(A2,A7.L)
        BCHG    D0,#$0400                       ; $1E4AC4
        DC.W    $0000,$0000         ; $1E4AC8 ORI.B  #$0000,D0
        DC.W    $0000,$7200         ; $1E4ACC ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E4AD0
        CMP.B  $0001(A7),D6                     ; $1E4AD2
        ADDQ.L  #8,-(A0)                        ; $1E4AD6
        SUBI.B  #$0000,D0                       ; $1E4AD8
        ORI.W  #$01A4,A6                        ; $1E4ADC
        DC.W    $FFC0               ; $1E4AE0 MOVE.W  D0,<EA:3F>
        BTST    D0,(A4)+                        ; $1E4AE2
        SUBI.B  #$0000,D0                       ; $1E4AE4
        DC.W    $0000,$0000         ; $1E4AE8 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4AEC
        BTST    D0,(A0)                         ; $1E4AEE
        CMP.B  -$30(A0,D4.L),D5                 ; $1E4AF0
        SUBI.B  #$0000,D0                       ; $1E4AF4
        SUBI.B  #$0000,D0                       ; $1E4AF8
        MOVE.W  -(A3),$36(A7,D0.W)              ; $1E4AFC
        ORI.W  #$01A4,A6                        ; $1E4B00
        DC.W    $0000,$0000         ; $1E4B04 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4B08
        BTST    D0,(A0)                         ; $1E4B0A
        CMP.B  $01(A1,D0.W),D4                  ; $1E4B0C
        ADDQ.L  #8,-(A0)                        ; $1E4B10
        SUBI.B  #$0000,D0                       ; $1E4B12
        ORI.W  #$00F6,-$005D(A5)                ; $1E4B16
        ORI.W  #$0400,$00(PC,D0.W)              ; $1E4B1C
        DC.W    $0000,$0000         ; $1E4B22 ORI.B  #$0000,D0
        MOVEQ   #$00,D1                         ; $1E4B26
        BTST    D0,(A0)                         ; $1E4B28
        CMP.B  -$30(A1,D4.L),D4                 ; $1E4B2A
        SUBI.B  #$0000,D0                       ; $1E4B2E
        SUBI.B  #$0000,D0                       ; $1E4B32
        MOVE.W  D2,-$73(A7,D0.W)                ; $1E4B36
        ORI.W  #$00F6,$0000(A5)                 ; $1E4B3A
        DC.W    $0000,$7200         ; $1E4B40 ORI.B  #$7200,D0
        BTST    D0,(A0)                         ; $1E4B44
        CMP.B  -$01(A2,A7.L),D3                 ; $1E4B46
        DC.W    $FFFF               ; $1E4B4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4B9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BCA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BD6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BD8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4BFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4C9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CCA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CD6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CD8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4CFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4D9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DCA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DD6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DD8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4DFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4E9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4ECA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4ECC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4ECE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4ED0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4ED2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4ED4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4ED6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4ED8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4EFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4F9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FCA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FD6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FD8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E4FFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5000 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5002 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5004 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5006 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5008 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E500A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E500C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E500E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5010 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5012 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5014 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5016 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5018 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E501A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E501C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E501E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5020 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5022 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5024 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5026 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5028 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E502A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E502C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E502E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5030 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5032 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5034 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5036 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5038 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E503A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E503C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E503E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5040 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5042 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5044 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5046 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5048 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E504A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E504C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E504E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5050 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5052 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5054 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5056 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5058 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E505A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E505C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E505E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5060 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5062 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5064 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5066 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5068 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E506A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E506C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E506E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5070 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5072 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5074 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5076 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5078 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E507A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E507C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E507E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5080 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5082 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5084 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5086 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5088 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E508A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E508C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E508E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5090 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5092 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5094 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5096 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5098 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E509A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E509C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E509E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E50FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5100 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5102 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5104 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5106 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5108 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E510A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E510C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E510E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5110 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5112 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5114 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5116 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5118 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E511A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E511C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E511E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5120 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5122 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5124 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5126 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5128 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E512A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E512C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E512E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5130 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5132 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5134 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5136 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5138 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E513A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E513C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E513E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5140 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5142 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5144 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5146 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5148 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E514A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E514C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E514E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5150 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5152 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5154 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5156 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5158 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E515A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E515C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E515E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5160 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5162 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5164 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5166 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5168 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E516A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E516C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E516E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5170 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5172 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5174 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5176 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5178 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E517A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E517C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E517E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5180 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5182 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5184 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5186 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5188 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E518A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E518C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E518E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5190 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5192 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5194 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5196 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5198 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E519A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E519C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E519E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E51FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5200 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5202 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5204 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5206 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5208 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E520A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E520C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E520E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5210 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5212 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5214 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5216 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5218 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E521A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E521C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E521E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5220 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5222 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5224 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5226 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5228 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E522A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E522C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E522E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5230 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5232 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5234 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5236 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5238 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E523A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E523C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E523E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5240 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5242 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5244 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5246 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5248 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E524A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E524C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E524E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5250 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5252 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5254 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5256 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5258 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E525A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E525C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E525E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5260 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5262 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5264 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5266 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5268 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E526A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E526C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E526E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5270 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5272 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5274 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5276 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5278 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E527A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E527C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E527E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5280 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5282 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5284 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5286 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5288 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E528A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E528C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E528E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5290 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5292 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5294 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5296 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5298 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E529A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E529C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E529E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E52FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5300 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5302 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5304 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5306 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5308 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E530A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E530C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E530E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5310 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5312 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5314 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5316 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5318 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E531A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E531C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E531E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5320 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5322 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5324 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5326 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5328 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E532A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E532C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E532E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5330 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5332 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5334 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5336 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5338 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E533A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E533C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E533E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5340 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5342 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5344 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5346 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5348 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E534A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E534C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E534E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5350 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5352 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5354 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5356 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5358 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E535A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E535C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E535E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5360 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5362 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5364 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5366 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5368 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E536A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E536C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E536E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5370 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5372 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5374 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5376 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5378 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E537A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E537C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E537E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5380 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5382 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5384 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5386 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5388 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E538A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E538C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E538E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5390 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5392 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5394 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5396 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5398 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E539A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E539C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E539E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E53FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5400 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5402 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5404 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5406 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5408 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E540A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E540C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E540E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5410 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5412 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5414 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5416 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5418 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E541A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E541C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E541E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5420 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5422 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5424 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5426 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5428 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E542A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E542C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E542E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5430 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5432 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5434 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5436 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5438 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E543A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E543C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E543E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5440 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5442 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5444 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5446 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5448 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E544A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E544C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E544E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5450 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5452 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5454 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5456 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5458 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E545A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E545C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E545E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5460 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5462 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5464 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5466 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5468 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E546A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E546C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E546E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5470 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5472 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5474 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5476 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5478 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E547A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E547C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E547E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5480 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5482 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5484 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5486 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5488 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E548A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E548C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E548E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5490 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5492 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5494 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5496 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5498 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E549A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E549C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E549E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E54FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5500 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5502 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5504 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5506 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5508 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E550A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E550C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E550E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5510 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5512 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5514 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5516 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5518 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E551A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E551C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E551E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5520 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5522 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5524 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5526 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5528 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E552A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E552C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E552E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5530 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5532 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5534 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5536 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5538 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E553A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E553C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E553E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5540 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5542 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5544 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5546 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5548 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E554A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E554C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E554E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5550 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5552 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5554 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5556 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5558 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E555A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E555C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E555E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5560 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5562 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5564 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5566 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5568 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E556A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E556C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E556E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5570 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5572 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5574 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5576 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5578 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E557A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E557C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E557E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5580 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5582 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5584 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5586 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5588 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E558A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E558C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E558E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5590 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5592 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5594 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5596 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5598 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E559A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E559C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E559E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E55FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5600 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5602 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5604 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5606 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5608 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E560A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E560C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E560E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5610 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5612 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5614 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5616 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5618 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E561A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E561C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E561E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5620 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5622 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5624 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5626 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5628 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E562A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E562C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E562E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5630 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5632 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5634 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5636 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5638 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E563A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E563C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E563E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5640 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5642 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5644 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5646 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5648 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E564A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E564C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E564E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5650 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5652 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5654 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5656 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5658 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E565A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E565C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E565E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5660 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5662 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5664 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5666 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5668 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E566A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E566C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E566E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5670 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5672 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5674 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5676 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5678 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E567A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E567C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E567E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5680 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5682 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5684 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5686 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5688 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E568A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E568C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E568E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5690 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5692 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5694 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5696 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5698 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E569A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E569C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E569E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E56FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5700 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5702 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5704 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5706 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5708 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E570A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E570C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E570E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5710 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5712 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5714 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5716 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5718 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E571A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E571C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E571E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5720 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5722 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5724 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5726 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5728 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E572A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E572C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E572E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5730 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5732 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5734 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5736 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5738 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E573A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E573C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E573E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5740 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5742 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5744 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5746 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5748 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E574A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E574C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E574E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5750 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5752 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5754 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5756 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5758 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E575A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E575C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E575E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5760 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5762 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5764 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5766 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5768 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E576A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E576C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E576E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5770 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5772 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5774 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5776 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5778 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E577A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E577C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E577E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5780 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5782 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5784 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5786 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5788 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E578A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E578C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E578E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5790 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5792 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5794 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5796 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5798 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E579A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E579C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E579E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E57FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5800 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5802 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5804 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5806 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5808 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E580A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E580C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E580E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5810 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5812 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5814 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5816 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5818 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E581A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E581C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E581E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5820 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5822 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5824 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5826 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5828 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E582A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E582C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E582E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5830 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5832 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5834 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5836 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5838 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E583A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E583C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E583E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5840 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5842 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5844 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5846 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5848 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E584A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E584C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E584E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5850 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5852 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5854 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5856 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5858 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E585A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E585C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E585E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5860 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5862 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5864 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5866 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5868 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E586A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E586C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E586E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5870 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5872 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5874 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5876 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5878 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E587A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E587C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E587E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5880 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5882 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5884 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5886 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5888 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E588A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E588C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E588E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5890 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5892 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5894 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5896 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5898 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E589A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E589C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E589E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E58FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5900 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5902 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5904 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5906 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5908 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E590A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E590C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E590E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5910 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5912 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5914 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5916 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5918 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E591A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E591C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E591E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5920 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5922 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5924 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5926 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5928 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E592A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E592C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E592E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5930 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5932 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5934 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5936 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5938 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E593A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E593C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E593E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5940 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5942 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5944 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5946 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5948 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E594A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E594C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E594E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5950 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5952 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5954 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5956 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5958 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E595A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E595C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E595E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5960 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5962 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5964 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5966 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5968 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E596A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E596C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E596E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5970 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5972 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5974 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5976 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5978 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E597A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E597C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E597E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5980 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5982 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5984 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5986 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5988 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E598A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E598C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E598E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5990 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5992 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5994 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5996 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5998 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E599A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E599C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E599E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E59FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5A9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ABA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ABC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ABE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ACA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ACC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ACE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AD6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AD8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ADA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ADC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ADE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5AFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5B9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BCA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BD6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BD8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5BFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5C9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CCA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CD6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CD8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5CFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5D9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DCA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DD6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DD8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5DFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5E9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ECA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ECC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ECE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ED0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ED2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ED4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ED6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5ED8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5EFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F08 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F0A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F0C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F0E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F10 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F12 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F20 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F22 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F24 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F40 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F42 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F50 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F52 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F54 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F56 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F66 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F68 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F6C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F6E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F98 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5F9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FB8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FBA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FBC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FC0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FC2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FC4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FC8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FCA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FD6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FD8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FDA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FDC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FDE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FE0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FE2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FE4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FE6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FE8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FEE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E5FFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6000 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6002 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6004 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6006 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6008 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E600A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E600C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E600E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6010 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6012 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6014 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6016 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6018 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E601A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E601C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E601E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6020 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6022 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6024 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6026 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6028 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E602A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E602C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E602E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6030 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6032 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6034 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6036 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6038 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E603A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E603C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E603E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6040 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6042 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6044 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6046 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6048 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E604A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E604C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E604E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6050 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6052 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6054 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6056 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6058 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E605A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E605C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E605E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6060 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6062 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6064 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6066 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6068 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E606A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E606C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E606E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6070 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6072 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6074 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6076 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6078 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E607A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E607C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E607E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6080 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6082 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6084 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6086 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6088 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E608A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E608C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E608E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6090 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6092 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6094 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6096 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6098 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E609A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E609C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E609E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E60FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6100 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6102 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6104 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6106 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6108 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E610A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E610C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E610E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6110 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6112 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6114 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6116 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6118 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E611A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E611C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E611E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6120 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6122 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6124 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6126 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6128 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E612A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E612C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E612E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6130 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6132 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6134 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6136 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6138 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E613A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E613C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E613E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6140 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6142 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6144 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6146 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6148 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E614A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E614C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E614E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6150 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6152 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6154 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6156 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6158 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E615A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E615C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E615E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6160 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6162 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6164 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6166 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6168 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E616A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E616C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E616E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6170 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6172 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6174 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6176 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6178 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E617A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E617C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E617E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6180 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6182 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6184 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6186 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6188 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E618A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E618C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E618E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6190 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6192 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6194 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6196 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E6198 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E619A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E619C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E619E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61AA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61B4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61CC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61CE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61D0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $1E61FE MOVE.W  <EA:3F>,<EA:3F>
