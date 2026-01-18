; Generated assembly for $2AC200-$2AE200
; Branch targets: 77
; Labels: 71
; Format: DC.W with decoded mnemonics as comments

        org     $2AC200

        DC.W    $04B0,$04C0,$04D0,$0C00; $2AC200 SUBI.L  #$04C004D0,$00(A0,D0.L)
        ORI.W  #$005E,(A6)+                     ; $2AC208
        SUBI.B  #$0345,$3D(A6,A7.L)             ; $2AC20C
        DC.W    $050A               ; $2AC212 BTST    D2,A2
        BCHG    D1,(A1)+                        ; $2AC214
        DC.W    $FDFF               ; $2AC216 MOVE.W  <EA:3F>,<EA:3E>
        ADDI.B  #$03FD,D2                       ; $2AC218
        MOVE.W  A5,-(A6)                        ; $2AC21C
        BTST    D2,D4                           ; $2AC21E
        BSET    D1,-(A6)                        ; $2AC220
        MOVE.W  -(A3),D6                        ; $2AC222
        DC.W    $04C0               ; $2AC224 DC.W    $04C0
        SUBI.B  #$FE3E,A0                       ; $2AC226
        BCLR    D2,-(A7)                        ; $2AC22A
        DC.W    $04D4               ; $2AC22C DC.W    $04D4
        MOVE.W  (A2)+,$03ED(A6)                 ; $2AC22E
        BSET    D1,$7B(A3,A7.L)                 ; $2AC232
        DC.W    $04A9,$04BD,$FC70,$0501; $2AC236 SUBI.L  #$04BDFC70,$0501(A1)
        DC.W    $04AE,$FC88,$0577,$040E; $2AC23E SUBI.L  #$FC880577,$040E(A6)
        MOVE.W  (A2)+,(A6)                      ; $2AC246
        ADDI.B  #$048A,A4                       ; $2AC248
        DC.W    $FBED,$0576         ; $2AC24C MOVE.W  $0576(A5),<EA:3D>
        BTST    D2,(A0)                         ; $2AC250
        DC.W    $FBFD               ; $2AC252 MOVE.W  <EA:3D>,<EA:3D>
        BCLR    D2,D3                           ; $2AC254
        DC.W    $04B9,$FCFF,$05F8,$051B,$FC76; $2AC256 SUBI.L  #$FCFF05F8,$051BFC76
        DC.W    $04C3               ; $2AC260 DC.W    $04C3
        SUBI.W  #$FC53,$0451(A0)                ; $2AC262
        SUBI.W  #$FC4A,(A6)                     ; $2AC268
        SUBI.B  #$02F5,-$03D8(A0)               ; $2AC26C
        SUBI.L  #$02E8FC30,(A6)                 ; $2AC272
        SUBI.L  #$0466FCB0,D6                   ; $2AC278
        SUBI.W  #$02E6,(A1)+                    ; $2AC27E
        MOVE.W  A4,(A6)                         ; $2AC282
        SUBI.W  #$030F,(A4)+                    ; $2AC284
        MOVEA.W $18(A4,D0.W),A6                 ; $2AC288
        DC.W    $02F0               ; $2AC28C DC.W    $02F0
        MOVEA.W (A0),A6                         ; $2AC28E
        DC.W    $04CB               ; $2AC290 DC.W    $04CB
        DC.W    $02B8,$FB32,$0536,$02C9; $2AC292 ANDI.L  #$FB320536,$02C9.W
        MOVE.W  (A0)+,-(A5)                     ; $2AC29A
        SUBI.W  #$02BD,A2                       ; $2AC29C
        MOVEA.W $05240278,A6                    ; $2AC2A0
        MOVE.W  (A5)+,-(A5)                     ; $2AC2A6
        BCHG    D2,$0313FDCB                    ; $2AC2A8
        BCLR    D2,(A5)+                        ; $2AC2AE
        BTST    D1,$30(A2,A7.L)                 ; $2AC2B0
        BSET    D2,$71(A5,D0.W)                 ; $2AC2B4
        MOVE.W  $05DA(A5),$6E(A6,D0.W)          ; $2AC2B8
        MOVE.W  #$0533,-(A6)                    ; $2AC2BE
        BCHG    D1,D3                           ; $2AC2C2
        MOVE.W  (A2),D7                         ; $2AC2C4
        BCLR    D2,(A4)                         ; $2AC2C6
        SUBI.L  #$FD83065E,(A7)+                ; $2AC2C8
        BTST    D1,D0                           ; $2AC2CE
        MOVE.W  $065D(A6),(A6)+                 ; $2AC2D0
        DC.W    $02EC               ; $2AC2D4 DC.W    $02EC
        MOVE.W  (A4)+,$0575(A6)                 ; $2AC2D6
        BTST    D1,$4E(A4,A7.L)                 ; $2AC2DA
        BCHG    D2,D4                           ; $2AC2DE
        BCHG    D1,(A7)                         ; $2AC2E0
        MOVE.W  (A5),D7                         ; $2AC2E2
        ADDI.W  #$02AE,(A7)                     ; $2AC2E4
        DC.W    $FCFF               ; $2AC2E8 MOVE.W  <EA:3F>,(A6)+
        DC.W    $053D               ; $2AC2EA BTST    D2,<EA:3D>
        BTST    D1,D6                           ; $2AC2EC
        MOVE.W  -(A6),D7                        ; $2AC2EE
        BCLR    D2,$4E(A6,D0.W)                 ; $2AC2F0
        MOVE.W  (A3),(A5)                       ; $2AC2F4
        BCLR    D2,(A6)+                        ; $2AC2F6
        DC.W    $034B               ; $2AC2F8 BCHG    D1,A3
        MOVE.W  (A0),(A5)                       ; $2AC2FA
        SUBI.L  #$0334FB83,D5                   ; $2AC2FC
        SUBI.L  #$0237FB86,(A4)+                ; $2AC302
        ADDI.L  #$041CFBD7,-(A7)                ; $2AC308
        BTST    D3,$0375(A5)                    ; $2AC30E
        MOVEA.W -(A1),A6                        ; $2AC312
        ADDI.B  #$035F,(A3)                     ; $2AC314
        MOVE.W  (A4),$058E(A6)                  ; $2AC318
        SUBI.B  #$FCC9,D5                       ; $2AC31C
        ADDI.B  #$040B,D3                       ; $2AC320
        MOVE.W  (A6),-(A5)                      ; $2AC324
        DC.W    $04E9               ; $2AC326 DC.W    $04E9
        BSET    D1,$09(A3,A7.L)                 ; $2AC328
        ADDI.B  #$01A7,$1D(PC,A7.L)             ; $2AC32C
        BTST    D2,-(A1)                        ; $2AC332
        BCLR    D0,(A0)                         ; $2AC334
        MOVE.W  (A0),D6                         ; $2AC336
        BCHG    D3,D4                           ; $2AC338
        ANDI.W  #$FC64,$062B.W                  ; $2AC33A
        ANDI.W  #$FD58,-(A1)                    ; $2AC340
        DC.W    $06E0               ; $2AC344 DC.W    $06E0
        BCLR    D0,$FBDE05C6                    ; $2AC346
        BCLR    D0,-(A2)                        ; $2AC34C
        MOVE.W  (A1),(A6)+                      ; $2AC34E
        BCLR    D1,(A1)+                        ; $2AC350
        DC.W    $0235,$FE1D,$04B7   ; $2AC352 ANDI.B  #$FE1D,-$49(A5,D0.W)
        ANDI.W  #$FEE7,$0513(A0)                ; $2AC358
        BCLR    D1,D4                           ; $2AC35E
        DC.W    $FDE3               ; $2AC360 MOVE.W  -(A3),<EA:3E>
        SUBI.B  #$0359,-$02C2(A0)               ; $2AC362
        SUBI.W  #$02E4,(A2)+                    ; $2AC368
        MOVE.W  A4,$04B5(A7)                    ; $2AC36C
        DC.W    $03FE               ; $2AC370 BSET    D1,<EA:3E>
        MOVEA.W A0,A7                           ; $2AC372
        BTST    D1,-$50(PC,D0.W)                ; $2AC374
        MOVE.W  D3,(A7)                         ; $2AC378
        DC.W    $03CA               ; $2AC37A BSET    D1,A2
        BSET    D1,(A4)                         ; $2AC37C
        MOVE.W  -(A3),-$55(A6,D0.W)             ; $2AC37E
        BCHG    D0,D7                           ; $2AC382
        DC.W    $FDC1               ; $2AC384 MOVE.W  D1,<EA:3E>
        SUBI.B  #$0138,(A0)+                    ; $2AC386
        MOVE.W  $035B(A4),$02A6(A6)             ; $2AC38A
        MOVEA.W -$13(A3,D0.W),A7                ; $2AC390
        DC.W    $02B6,$FEC7,$04A0,$0198; $2AC394 ANDI.L  #$FEC704A0,-$68(A6,D0.W)
        MOVE.W  A0,$03E3(A6)                    ; $2AC39C
        BTST    D1,D7                           ; $2AC3A0
        MOVEA.W A7,A7                           ; $2AC3A2
        DC.W    $038D               ; $2AC3A4 BCLR    D1,A5
        ORI.W  #$FD37,(A2)+                     ; $2AC3A6
        BCHG    D1,D2                           ; $2AC3AA
        DC.W    $00B1,$FD36,$046C,$01B0; $2AC3AC ORI.L  #$FD36046C,-$50(A1,D0.W)
        MOVE.W  $04B7(A7),$58(A6,D0.W)          ; $2AC3B4
        MOVE.W  $0384(A7),-$72(A6,D0.W)         ; $2AC3BA
        MOVE.W  (A7)+,(A6)+                     ; $2AC3C0
        DC.W    $04AE,$018C,$FD57,$0384; $2AC3C2 SUBI.L  #$018CFD57,$0384(A6)
        ORI.W  #$FC36,-$7E(A7,D0.W)             ; $2AC3CA
        DC.W    $003C,$FC35,$0359   ; $2AC3D0 ORI.B  #$FC35,#$0359
        DC.W    $0039,$FD50,$035D,$0096; $2AC3D6 ORI.B  #$FD50,$035D0096
        MOVE.W  (A1),$0430(A6)                  ; $2AC3DE
        DC.W    $02C8               ; $2AC3E2 DC.W    $02C8
        MOVEA.W A2,A7                           ; $2AC3E4
        SUBI.B  #$0310,(A7)                     ; $2AC3E6
        MOVE.W  -(A3),(A7)+                     ; $2AC3EA
        SUBI.B  #$0158,-$4A(A7,A7.L)            ; $2AC3EC
        SUBI.W  #$0110,A6                       ; $2AC3F2
        MOVE.W  (A5)+,-(A7)                     ; $2AC3F6
        SUBI.L  #$02F2FE8F,-(A7)                ; $2AC3F8
        DC.W    $04C7               ; $2AC3FE DC.W    $04C7
        BTST    D0,-$009E(PC)                   ; $2AC400
        SUBI.W  #$0145,(A4)+                    ; $2AC404
        MOVE.W  (A3),-(A7)                      ; $2AC408
        SUBI.W  #$019A,(A0)                     ; $2AC40A
        MOVE.W  -(A1),$0408(A7)                 ; $2AC40E
        ORI.L  #$00850414,D4                    ; $2AC412
        DC.W    $0030,$0038,$04B1   ; $2AC418 ORI.B  #$0038,-$4F(A0,D0.W)
        BCHG    D0,-(A3)                        ; $2AC41E
        MOVE.W  D4,$0469(A7)                    ; $2AC420
        ORI.W  #$0069,A5                        ; $2AC424
        SUBI.L  #$FFF1FFCA,-(A4)                ; $2AC428
        SUBI.L  #$FFBBFFE2,-(A1)                ; $2AC42E
        SUBI.B  #$0023,D6                       ; $2AC434
        DC.W    $00BA,$040A,$0078,$0094; $2AC438 ORI.L  #$040A0078,$0094(PC)
        DC.W    $0010,$0500         ; $2AC440 ORI.B  #$0500,(A0)
        ANDI.W  #$0270,-(A0)                    ; $2AC444
        ANDI.L  #$02900210,D0                   ; $2AC448
        ADDI.B  #$0310,D0                       ; $2AC44E
        BTST    D1,D0                           ; $2AC452
        SUBI.B  #$0500,(A0)                     ; $2AC454
        BCHG    D1,(A0)                         ; $2AC458
        BCHG    D1,D0                           ; $2AC45A
        SUBI.B  #$0600,(A0)                     ; $2AC45C
        BTST    D1,$20(A0,D0.W)                 ; $2AC460
        SUBI.B  #$0500,(A0)                     ; $2AC464
        DC.W    $02C0               ; $2AC468 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2AC46A ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2AC472 DC.W    $02D0
        DC.W    $0210,$0600         ; $2AC474 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2AC478
        BTST    D2,D0                           ; $2AC47E
        DC.W    $02F0               ; $2AC480 DC.W    $02F0
        DC.W    $02E0               ; $2AC482 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2AC484
        BCHG    D1,(A0)                         ; $2AC488
        BTST    D1,(A0)                         ; $2AC48A
        DC.W    $0210,$0300         ; $2AC48C ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2AC490
        ADDI.B  #$0270,D0                       ; $2AC496
        DC.W    $02E0               ; $2AC49A DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2AC49C
        ANDI.W  #$0300,-(A0)                    ; $2AC4A0
        DC.W    $0210,$0300         ; $2AC4A4 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2AC4A8
        ANDI.L  #$04100300,-(A0)                ; $2AC4AA
        BTST    D1,-(A0)                        ; $2AC4B0
        DC.W    $02B0,$0010,$6E00,$0000; $2AC4B2 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2AC4BA ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2AC4BE ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AC4C4
        SUBI.B  #$7000,(A0)                     ; $2AC4C8
        ORI.W  #$0070,-(A0)                     ; $2AC4CC
        SUBI.B  #$6F00,(A0)                     ; $2AC4D0
        DC.W    $0000,$0030         ; $2AC4D4 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AC4D8 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AC4DC ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AC4E0 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AC4E4
        DC.W    $00B0,$0210,$0400,$00D0; $2AC4EA ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AC4F2 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AC4F4
        ORI.L  #$00900611,-(A0)                 ; $2AC4F8
        BTST    D3,D1                           ; $2AC4FE
        DC.W    $00B0,$0010,$6A00,$00E0; $2AC500 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AC508 DC.W    $00F0
        BTST    D0,D0                           ; $2AC50A
        BTST    D0,(A0)                         ; $2AC50C
        DC.W    $0210,$6C00         ; $2AC50E ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AC512
        SUBI.B  #$6B00,(A0)                     ; $2AC516
        BTST    D0,D0                           ; $2AC51A
        DC.W    $00F0               ; $2AC51C DC.W    $00F0
        DC.W    $0211,$6901         ; $2AC51E ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AC522 DC.W    $00E0
        DC.W    $0010,$6300         ; $2AC524 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AC528
        BCHG    D0,(A0)                         ; $2AC52A
        BCHG    D0,-(A0)                        ; $2AC52C
        BCHG    D0,$10(A0,D0.W)                 ; $2AC52E
        BCS.W  loc_2AC6C4                       ; $2AC532
        BCLR    D0,D0                           ; $2AC536
        SUBI.B  #$6400,(A0)                     ; $2AC538
        BCHG    D0,-(A0)                        ; $2AC53C
        BCHG    D0,(A0)                         ; $2AC53E
        ADDI.B  #$6201,(A1)                     ; $2AC540
        BCHG    D0,$10(A0,D0.W)                 ; $2AC544
        BPL.W  loc_2AC6EA                       ; $2AC548
        BCLR    D0,-$40(A0,D0.W)                ; $2AC54C
        BSET    D0,(A0)                         ; $2AC550
        DC.W    $0210,$6C00         ; $2AC552 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AC556
        SUBI.B  #$6B00,(A0)                     ; $2AC55A
        BSET    D0,D0                           ; $2AC55E
        BCLR    D0,$11(A0,D0.W)                 ; $2AC560
        BVS.S  loc_2AC567                       ; $2AC564
        BSET    D0,(A0)                         ; $2AC566
        DC.W    $0010,$6300         ; $2AC568 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AC56C ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AC570 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AC574 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AC578
        SUBI.B  #$6400,(A0)                     ; $2AC57C
        DC.W    $0220,$0210         ; $2AC580 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AC584 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AC588 ANDI.B  #$0010,D0
        BNE.W  loc_2AC8EE                       ; $2AC58C
        BCHG    D1,-$80(A0,D0.W)                ; $2AC590
        BCLR    D1,(A0)                         ; $2AC594
        ADDI.B  #$6700,(A0)                     ; $2AC596
        BCLR    D1,-(A0)                        ; $2AC59A
        BCLR    D1,$10(A0,D0.W)                 ; $2AC59C
        BVC.W  loc_2AC962                       ; $2AC5A0
        BSET    D1,(A0)                         ; $2AC5A4
        SUBI.B  #$6700,(A0)                     ; $2AC5A6
        BCHG    D1,-(A0)                        ; $2AC5AA
        BCLR    D1,(A0)                         ; $2AC5AC
        DC.W    $0010,$0300         ; $2AC5AE ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AC5B2
        BSET    D1,$00(A0,D0.W)                 ; $2AC5B4
        SUBI.B  #$0210,(A0)                     ; $2AC5B8
        BTST    D2,D0                           ; $2AC5BC
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AC5BE
        SUBI.B  #$0400,D0                       ; $2AC5C4
        BSET    D1,$10(A0,D0.W)                 ; $2AC5C8
        BCS.W  loc_2ACA0E                       ; $2AC5CC
        SUBI.W  #$0460,(A0)                     ; $2AC5D0
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AC5D4
        SUBI.L  #$04800410,(A0)                 ; $2AC5DA
        BCC.W  loc_2ACA42                       ; $2AC5E0
        SUBI.W  #$0010,(A0)                     ; $2AC5E4
        BTST    D1,D0                           ; $2AC5E8
        DC.W    $04E0               ; $2AC5EA DC.W    $04E0
        DC.W    $04F0               ; $2AC5EC DC.W    $04F0
        BTST    D2,D0                           ; $2AC5EE
        BTST    D2,(A0)                         ; $2AC5F0
        DC.W    $0210,$0500         ; $2AC5F2 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2AC5F6
        SUBI.B  #$0400,(A0)                     ; $2AC5FA
        BTST    D2,D0                           ; $2AC5FE
        DC.W    $04F0               ; $2AC600 DC.W    $04F0
        DC.W    $0010,$6500         ; $2AC602 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2AC606
        BCHG    D2,(A0)                         ; $2AC608
        BCHG    D2,-(A0)                        ; $2AC60A
        BCHG    D2,$10(A0,D0.W)                 ; $2AC60C
        BLS.W  loc_2ACBA2                       ; $2AC610
        BCLR    D2,D0                           ; $2AC614
        SUBI.B  #$6400,(A0)                     ; $2AC616
        BCHG    D2,-(A0)                        ; $2AC61A
        BCHG    D2,(A0)                         ; $2AC61C
        DC.W    $0000,$6600         ; $2AC61E ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AC622
        DC.W    $04D0               ; $2AC628 DC.W    $04D0
        DC.W    $0000,$6600         ; $2AC62A ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2AC62E
        BCLR    D2,-$40(A0,D0.W)                ; $2AC630
        BSET    D2,(A0)                         ; $2AC634
        CMPI.B  #$005E,D0                       ; $2AC636
        ORI.W  #$04D6,(A6)+                     ; $2AC63A
        BCLR    D1,$07(A7,A7.L)                 ; $2AC63E
        BTST    D2,-$34(A7,D0.W)                ; $2AC642
        MOVE.W  (A5),-(A7)                      ; $2AC646
        DC.W    $0639,$04DC,$FEC0,$05C4; $2AC648 ADDI.B  #$04DC,$FEC005C4
        DC.W    $04C1               ; $2AC650 DC.W    $04C1
        MOVE.W  -$58(PC,D0.W),$0450(A6)         ; $2AC652
        DC.W    $FF3E               ; $2AC658 MOVE.W  <EA:3E>,-(A7)
        DC.W    $058A               ; $2AC65A BCLR    D2,A2
        DC.W    $057E               ; $2AC65C BCHG    D2,<EA:3E>
        MOVE.W  $46(A2,D0.W),(A7)+              ; $2AC65E
        SUBI.B  #$FE30,$14(PC,D0.W)             ; $2AC662
        BCHG    D2,-(A4)                        ; $2AC668
        MOVE.W  $055B(A7),$64(A6,D0.W)          ; $2AC66A
        DC.W    $FDE9,$05EC         ; $2AC670 MOVE.W  $05EC(A1),<EA:3E>
        DC.W    $04E6               ; $2AC674 DC.W    $04E6
        MOVE.W  (A6)+,D7                        ; $2AC676
        ADDI.L  #$05A6FDD5,A2                   ; $2AC678
        BSET    D2,(A1)+                        ; $2AC67E
        DC.W    $05FD               ; $2AC680 BSET    D2,<EA:3D>
        MOVE.W  -$69(A0,D0.W),$72(A6,D0.W)      ; $2AC682
        MOVE.W  (A0),(A7)                       ; $2AC688
        ADDI.B  #$060B,(A4)                     ; $2AC68A
        MOVEA.W (A5),A7                         ; $2AC68E
        BCHG    D2,$050C(A1)                    ; $2AC690
        MOVE.W  (A4),$0A(A6,D0.W)               ; $2AC694
        DC.W    $04FB               ; $2AC698 DC.W    $04FB
        MOVE.W  (A3),$04F0(A6)                  ; $2AC69A
        BCLR    D1,(A3)+                        ; $2AC69E
        MOVE.W  -(A3),-(A6)                     ; $2AC6A0
        DC.W    $054C               ; $2AC6A2 BCHG    D2,A4
        DC.W    $038C               ; $2AC6A4 BCLR    D1,A4
        MOVE.W  (A7)+,$0506(A6)                 ; $2AC6A6
        DC.W    $050C               ; $2AC6AA BTST    D2,A4
        DC.W    $FDC6               ; $2AC6AC MOVE.W  D6,<EA:3E>
        DC.W    $04EA               ; $2AC6AE DC.W    $04EA
        DC.W    $038D               ; $2AC6B0 BCLR    D1,A5
        MOVE.W  (A1),$08(A6,D0.W)               ; $2AC6B2
        BCLR    D1,$77(PC,A7.L)                 ; $2AC6B6
        DC.W    $04D4               ; $2AC6BA DC.W    $04D4
        BCLR    D1,-(A1)                        ; $2AC6BC
        MOVE.W  #$05DA,-(A6)                    ; $2AC6BE
        DC.W    $0308               ; $2AC6C2 BTST    D1,A0
loc_2AC6C4:
        MOVE.W  (A4)+,(A6)                      ; $2AC6C4
        ADDI.W  #$0301,D6                       ; $2AC6C6
        MOVE.W  -$1F(A5,D0.W),(A6)              ; $2AC6CA
        BCHG    D1,$7E(A1,A7.L)                 ; $2AC6CE
        ADDI.B  #$02B7,(A7)+                    ; $2AC6D2
        MOVE.W  $38(PC,D0.W),(A6)               ; $2AC6D6
        DC.W    $03CA               ; $2AC6DA BSET    D1,A2
        MOVE.W  A2,$052C(A7)                    ; $2AC6DC
        BSET    D1,-$4F(A4,A7.L)                ; $2AC6E0
        BSET    D2,(A5)+                        ; $2AC6E4
        BTST    D2,(A0)+                        ; $2AC6E6
        MOVE.W  A5,$05F9(A7)                    ; $2AC6E8
        DC.W    $0509               ; $2AC6EC BTST    D2,A1
        MOVE.W  (A7)+,(A7)+                     ; $2AC6EE
        DC.W    $04DF               ; $2AC6F0 DC.W    $04DF
        SUBI.B  #$FF62,A0                       ; $2AC6F2
        BCLR    D2,-(A1)                        ; $2AC6F6
        BCHG    D2,D7                           ; $2AC6F8
        MOVE.W  $60(A6,D0.W),(A7)+              ; $2AC6FA
        BCHG    D1,-$03(A3,A7.L)                ; $2AC6FE
        ADDI.B  #$0373,-$00A2(A0)               ; $2AC702
        DC.W    $04FB               ; $2AC708 DC.W    $04FB
        DC.W    $03FE               ; $2AC70A BSET    D1,<EA:3E>
        MOVE.W  -$0E(A7,D0.W),$1C(A7,D0.W)      ; $2AC70C
        MOVE.W  $0643(A2),$0326(A7)             ; $2AC712
        MOVE.W  (A1),-(A7)                      ; $2AC718
        DC.W    $04D6               ; $2AC71A DC.W    $04D6
        BSET    D1,(A0)                         ; $2AC71C
        DC.W    $FF7D,$06D6         ; $2AC71E MOVE.W  <EA:3D>,$06D6(A7)
        ANDI.W  #$FCBC,-(A1)                    ; $2AC722
        DC.W    $06F6               ; $2AC726 DC.W    $06F6
        BCHG    D1,(A1)+                        ; $2AC728
        MOVE.W  (A1),(A6)                       ; $2AC72A
        DC.W    $058C               ; $2AC72C BCLR    D2,A4
        BCLR    D1,(A4)                         ; $2AC72E
        MOVE.W  (A1),(A6)+                      ; $2AC730
        BCHG    D2,$029C(A3)                    ; $2AC732
        MOVE.W  $63(PC,D0.W),(A6)+              ; $2AC736
        SUBI.W  #$FE19,D5                       ; $2AC73A
        BCHG    D3,$03AF(A6)                    ; $2AC73E
        MOVE.W  -(A5),(A7)+                     ; $2AC742
        ADDI.B  #$03EA,D4                       ; $2AC744
        MOVE.W  -(A5),-(A7)                     ; $2AC748
        BSET    D2,$0481.W                      ; $2AC74A
        MOVEA.W (A1)+,A7                        ; $2AC74E
        BTST    D3,$22(A1,D0.W)                 ; $2AC750
        MOVE.W  -(A2),-(A6)                     ; $2AC754
        BSET    D2,D6                           ; $2AC756
        SUBI.W  #$FD62,(A5)+                    ; $2AC758
        DC.W    $06E2               ; $2AC75C DC.W    $06E2
        DC.W    $01CA               ; $2AC75E BSET    D0,A2
        MOVE.W  A0,$77(A6,D0.W)                 ; $2AC760
        DC.W    $0205,$FDC8         ; $2AC764 ANDI.B  #$FDC8,D5
        DC.W    $074D               ; $2AC768 BCHG    D3,A5
        DC.W    $02B6,$FF10,$05E3,$02F1; $2AC76A ANDI.L  #$FF1005E3,-$0F(A6,D0.W)
        MOVE.W  A7,$0713(A7)                    ; $2AC772
        BSET    D0,-$0182(A5)                   ; $2AC776
        BCLR    D2,$0228(A0)                    ; $2AC77A
        DC.W    $FEBF               ; $2AC77E MOVE.W  <EA:3F>,(A7)
        SUBI.W  #$026E,-$01EF(A2)               ; $2AC780
        DC.W    $04D4               ; $2AC786 DC.W    $04D4
        ANDI.W  #$FF62,$31(A7,D0.W)             ; $2AC788
        BSET    D1,$1A(A0,A7.L)                 ; $2AC78E
        DC.W    $04D9               ; $2AC792 DC.W    $04D9
        BSET    D1,-$01FA(A1)                   ; $2AC794
        SUBI.B  #$02AB,-$006A(A3)               ; $2AC798
        SUBI.L  #$0424FF4E,D7                   ; $2AC79E
        BSET    D1,D0                           ; $2AC7A4
        ANDI.L  #$FE45042F,-(A1)                ; $2AC7A6
        SUBI.B  #$FE3A,(A4)+                    ; $2AC7AC
        BCHG    D2,-$51(A5,D0.W)                ; $2AC7B0
        MOVE.W  $0553(A1),-(A7)                 ; $2AC7B4
        BCHG    D0,(A5)+                        ; $2AC7B8
        MOVE.W  (A1)+,(A7)                      ; $2AC7BA
        BSET    D1,-$62(A1,D0.W)                ; $2AC7BC
        MOVE.W  $13(A4,D0.W),D7                 ; $2AC7C0
        DC.W    $02F1               ; $2AC7C4 DC.W    $02F1
        MOVE.W  D4,(A7)+                        ; $2AC7C6
        DC.W    $05BF               ; $2AC7C8 BCLR    D2,<EA:3F>
        BSET    D0,(A4)+                        ; $2AC7CA
        MOVE.W  $5E(A5,D0.W),(A7)               ; $2AC7CC
        BTST    D1,(A6)+                        ; $2AC7D0
        MOVEA.W (A0),A7                         ; $2AC7D2
        BCHG    D2,(A7)                         ; $2AC7D4
        ORI.W  #$FE86,A2                        ; $2AC7D6
        BTST    D2,(A2)+                        ; $2AC7DA
        ORI.W  #$FE2D,$47(A5,D0.W)              ; $2AC7DC
        BSET    D0,-$013C(A7)                   ; $2AC7E2
        BCLR    D2,D3                           ; $2AC7E6
        BSET    D0,D5                           ; $2AC7E8
        MOVE.W  (A5)+,-(A7)                     ; $2AC7EA
        DC.W    $058D               ; $2AC7EC BCLR    D2,A5
        ORI.W  #$FE32,-(A5)                     ; $2AC7EE
        BCLR    D2,$01E0FECA                    ; $2AC7F2
        DC.W    $05FE               ; $2AC7F8 BSET    D2,<EA:3E>
        ORI.W  #$FDB2,A0                        ; $2AC7FA
        DC.W    $05FE               ; $2AC7FE BSET    D2,<EA:3E>
        DC.W    $000D,$FDB2         ; $2AC800 ORI.B  #$FDB2,A5
        BTST    D2,-(A0)                        ; $2AC804
        DC.W    $000D,$FE68         ; $2AC806 ORI.B  #$FE68,A5
        BTST    D2,-(A0)                        ; $2AC80A
        ORI.W  #$FE68,$0488(A2)                 ; $2AC80C
        DC.W    $02E0               ; $2AC812 DC.W    $02E0
        MOVE.W  -(A4),(A7)                      ; $2AC814
        SUBI.B  #$02F7,(A2)+                    ; $2AC816
        MOVE.W  -(A4),-(A7)                     ; $2AC81A
        SUBI.L  #$013AFFD1,D2                   ; $2AC81C
        DC.W    $04EF               ; $2AC822 DC.W    $04EF
        BTST    D0,-(A1)                        ; $2AC824
        MOVE.W  (A1),$04C0(A7)                  ; $2AC826
        BTST    D1,(A3)+                        ; $2AC82A
        MOVE.W  (A4)+,-(A7)                     ; $2AC82C
        BTST    D2,-(A7)                        ; $2AC82E
        BCHG    D0,(A5)+                        ; $2AC830
        DC.W    $FFC9               ; $2AC832 MOVE.W  A1,<EA:3F>
        DC.W    $04F9               ; $2AC834 DC.W    $04F9
        BCHG    D0,D5                           ; $2AC836
        MOVE.W  (A4),$04BC(A7)                  ; $2AC838
        BCLR    D0,(A1)+                        ; $2AC83C
        MOVE.W  D7,-$05(A7,D0.W)                ; $2AC83E
        ORI.L  #$006C0439,D1                    ; $2AC842
        DC.W    $002E,$003A,$0521   ; $2AC848 ORI.B  #$003A,$0521(A6)
        BCHG    D0,-$0057(A7)                   ; $2AC84E
        SUBI.W  #$0058,-(A1)                    ; $2AC852
        ORI.L  #$04B90044,A7                    ; $2AC856
        DC.W    $FFBE,$04B9         ; $2AC85C MOVE.W  <EA:3E>,-$47(A7,D0.W)
        DC.W    $0009,$FFBE         ; $2AC860 ORI.B  #$FFBE,A1
        SUBI.B  #$0009,D4                       ; $2AC864
        ORI.L  #$04040066,(A3)+                 ; $2AC868
        ORI.L  #$00100500,(A3)+                 ; $2AC86E
        ANDI.W  #$0270,-(A0)                    ; $2AC874
        ANDI.L  #$02900210,D0                   ; $2AC878
        ADDI.B  #$0310,D0                       ; $2AC87E
        BTST    D1,D0                           ; $2AC882
        SUBI.B  #$0500,(A0)                     ; $2AC884
        BCHG    D1,(A0)                         ; $2AC888
        BCHG    D1,D0                           ; $2AC88A
        SUBI.B  #$0600,(A0)                     ; $2AC88C
        BTST    D1,$20(A0,D0.W)                 ; $2AC890
        SUBI.B  #$0500,(A0)                     ; $2AC894
        DC.W    $02C0               ; $2AC898 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2AC89A ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2AC8A2 DC.W    $02D0
        DC.W    $0210,$0600         ; $2AC8A4 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2AC8A8
        BTST    D2,D0                           ; $2AC8AE
        DC.W    $02F0               ; $2AC8B0 DC.W    $02F0
        DC.W    $02E0               ; $2AC8B2 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2AC8B4
        BCHG    D1,(A0)                         ; $2AC8B8
        BTST    D1,(A0)                         ; $2AC8BA
        DC.W    $0210,$0300         ; $2AC8BC ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2AC8C0
        ADDI.B  #$0270,D0                       ; $2AC8C6
        DC.W    $02E0               ; $2AC8CA DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2AC8CC
        ANDI.W  #$0300,-(A0)                    ; $2AC8D0
        DC.W    $0210,$0300         ; $2AC8D4 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2AC8D8
        ANDI.L  #$04100300,-(A0)                ; $2AC8DA
        BTST    D1,-(A0)                        ; $2AC8E0
        DC.W    $02B0,$0010,$6E00,$0000; $2AC8E2 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2AC8EA ORI.B  #$0020,(A0)
loc_2AC8EE:
        DC.W    $0030,$0610,$6F00   ; $2AC8EE ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AC8F4
        SUBI.B  #$7000,(A0)                     ; $2AC8F8
        ORI.W  #$0070,-(A0)                     ; $2AC8FC
        SUBI.B  #$6F00,(A0)                     ; $2AC900
        DC.W    $0000,$0030         ; $2AC904 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AC908 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AC90C ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AC910 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AC914
        DC.W    $00B0,$0210,$0400,$00D0; $2AC91A ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AC922 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AC924
        ORI.L  #$00900611,-(A0)                 ; $2AC928
        BTST    D3,D1                           ; $2AC92E
        DC.W    $00B0,$0010,$6A00,$00E0; $2AC930 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AC938 DC.W    $00F0
        BTST    D0,D0                           ; $2AC93A
        BTST    D0,(A0)                         ; $2AC93C
        DC.W    $0210,$6C00         ; $2AC93E ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AC942
        SUBI.B  #$6B00,(A0)                     ; $2AC946
        BTST    D0,D0                           ; $2AC94A
        DC.W    $00F0               ; $2AC94C DC.W    $00F0
        DC.W    $0211,$6901         ; $2AC94E ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AC952 DC.W    $00E0
        DC.W    $0010,$6300         ; $2AC954 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AC958
        BCHG    D0,(A0)                         ; $2AC95A
        BCHG    D0,-(A0)                        ; $2AC95C
        BCHG    D0,$10(A0,D0.W)                 ; $2AC95E
loc_2AC962:
        BCS.W  loc_2ACAF4                       ; $2AC962
        BCLR    D0,D0                           ; $2AC966
        SUBI.B  #$6400,(A0)                     ; $2AC968
        BCHG    D0,-(A0)                        ; $2AC96C
        BCHG    D0,(A0)                         ; $2AC96E
        ADDI.B  #$6201,(A1)                     ; $2AC970
        BCHG    D0,$10(A0,D0.W)                 ; $2AC974
        BPL.W  loc_2ACB1A                       ; $2AC978
        BCLR    D0,-$40(A0,D0.W)                ; $2AC97C
        BSET    D0,(A0)                         ; $2AC980
        DC.W    $0210,$6C00         ; $2AC982 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AC986
        SUBI.B  #$6B00,(A0)                     ; $2AC98A
        BSET    D0,D0                           ; $2AC98E
        BCLR    D0,$11(A0,D0.W)                 ; $2AC990
        BVS.S  loc_2AC997                       ; $2AC994
        BSET    D0,(A0)                         ; $2AC996
        DC.W    $0010,$6300         ; $2AC998 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AC99C ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AC9A0 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AC9A4 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AC9A8
        SUBI.B  #$6400,(A0)                     ; $2AC9AC
        DC.W    $0220,$0210         ; $2AC9B0 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AC9B4 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AC9B8 ANDI.B  #$0010,D0
        BNE.W  loc_2ACD1E                       ; $2AC9BC
        BCHG    D1,-$80(A0,D0.W)                ; $2AC9C0
        BCLR    D1,(A0)                         ; $2AC9C4
        ADDI.B  #$6700,(A0)                     ; $2AC9C6
        BCLR    D1,-(A0)                        ; $2AC9CA
        BCLR    D1,$10(A0,D0.W)                 ; $2AC9CC
        BVC.W  loc_2ACD92                       ; $2AC9D0
        BSET    D1,(A0)                         ; $2AC9D4
        SUBI.B  #$6700,(A0)                     ; $2AC9D6
        BCHG    D1,-(A0)                        ; $2AC9DA
        BCLR    D1,(A0)                         ; $2AC9DC
        DC.W    $0010,$0300         ; $2AC9DE ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AC9E2
        BSET    D1,$00(A0,D0.W)                 ; $2AC9E4
        SUBI.B  #$0210,(A0)                     ; $2AC9E8
        BTST    D2,D0                           ; $2AC9EC
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AC9EE
        SUBI.B  #$0400,D0                       ; $2AC9F4
        BSET    D1,$10(A0,D0.W)                 ; $2AC9F8
        BCS.W  loc_2ACE3E                       ; $2AC9FC
        SUBI.W  #$0460,(A0)                     ; $2ACA00
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2ACA04
        SUBI.L  #$04800410,(A0)                 ; $2ACA0A
        BCC.W  loc_2ACE72                       ; $2ACA10
        SUBI.W  #$0010,(A0)                     ; $2ACA14
        BTST    D1,D0                           ; $2ACA18
        DC.W    $04E0               ; $2ACA1A DC.W    $04E0
        DC.W    $04F0               ; $2ACA1C DC.W    $04F0
        BTST    D2,D0                           ; $2ACA1E
        BTST    D2,(A0)                         ; $2ACA20
        DC.W    $0210,$0500         ; $2ACA22 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2ACA26
        SUBI.B  #$0400,(A0)                     ; $2ACA2A
        BTST    D2,D0                           ; $2ACA2E
        DC.W    $04F0               ; $2ACA30 DC.W    $04F0
        DC.W    $0010,$6500         ; $2ACA32 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2ACA36
        BCHG    D2,(A0)                         ; $2ACA38
        BCHG    D2,-(A0)                        ; $2ACA3A
        BCHG    D2,$10(A0,D0.W)                 ; $2ACA3C
        BLS.W  loc_2ACFD2                       ; $2ACA40
        BCLR    D2,D0                           ; $2ACA44
        SUBI.B  #$6400,(A0)                     ; $2ACA46
        BCHG    D2,-(A0)                        ; $2ACA4A
        BCHG    D2,(A0)                         ; $2ACA4C
        DC.W    $0000,$6600         ; $2ACA4E ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2ACA52
        DC.W    $04D0               ; $2ACA58 DC.W    $04D0
        DC.W    $0000,$6600         ; $2ACA5A ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2ACA5E
        BCLR    D2,-$40(A0,D0.W)                ; $2ACA60
        BSET    D2,(A0)                         ; $2ACA64
        CMPI.B  #$005E,D0                       ; $2ACA66
        ORI.W  #$04E8,(A6)+                     ; $2ACA6A
        BSET    D1,D6                           ; $2ACA6E
        MOVE.W  -$13(A7,D0.W),$03C4(A7)         ; $2ACA70
        ORI.L  #$05F104DD,(A6)                  ; $2ACA76
        DC.W    $00B1,$05EC,$04DF,$FF59; $2ACA7C ORI.L  #$05EC04DF,$59(A1,A7.L)
        SUBI.W  #$0443,(A3)                     ; $2ACA84
        ORI.L  #$05350578,(A2)+                 ; $2ACA88
        DC.W    $00B5,$044E,$0444,$FF7A; $2ACA8E ORI.L  #$044E0444,$7A(A5,A7.L)
        BTST    D2,$057A(A7)                    ; $2ACA96
        MOVE.W  (A4)+,$055F(A7)                 ; $2ACA9A
        BCHG    D2,-$56(A6,A7.L)                ; $2ACA9E
        BSET    D2,(A4)+                        ; $2ACAA2
        DC.W    $04F5               ; $2ACAA4 DC.W    $04F5
        DC.W    $0000,$0681         ; $2ACAA6 ORI.B  #$0681,D0
        DC.W    $05BD               ; $2ACAAA BCLR    D2,<EA:3D>
        DC.W    $FFFF               ; $2ACAAC MOVE.W  <EA:3F>,<EA:3F>
        BSET    D2,-(A2)                        ; $2ACAAE
        ADDI.B  #$FFA9,(A5)                     ; $2ACAB0
        BCHG    D2,-(A2)                        ; $2ACAB4
        BCHG    D2,$5B(A5,D0.W)                 ; $2ACAB6
        BSET    D2,-(A5)                        ; $2ACABA
        ADDI.B  #$005A,(A4)                     ; $2ACABC
        BCLR    D2,(A2)                         ; $2ACAC0
        BTST    D2,-(A0)                        ; $2ACAC2
        MOVE.W  (A5),$054F(A7)                  ; $2ACAC4
        BTST    D2,(A1)+                        ; $2ACAC8
        MOVE.W  $1D(A7,D0.W),(A7)+              ; $2ACACA
        DC.W    $03BD               ; $2ACACE BCLR    D1,<EA:3D>
        DC.W    $FEBD               ; $2ACAD0 MOVE.W  <EA:3D>,(A7)
        BCHG    D2,(A4)+                        ; $2ACAD2
        BCLR    D1,-(A5)                        ; $2ACAD4
        MOVE.W  (A6),-(A7)                      ; $2ACAD6
        BTST    D2,-(A4)                        ; $2ACAD8
        BTST    D2,-$009F(A7)                   ; $2ACADA
        DC.W    $04EE               ; $2ACADE DC.W    $04EE
        BCLR    D1,$21(A3,A7.L)                 ; $2ACAE0
        BTST    D2,(A3)+                        ; $2ACAE4
        BSET    D1,(A5)+                        ; $2ACAE6
        MOVE.W  (A5),-(A7)                      ; $2ACAE8
        DC.W    $04FC               ; $2ACAEA DC.W    $04FC
        DC.W    $03C8               ; $2ACAEC BSET    D1,A0
        MOVE.W  A2,(A7)+                        ; $2ACAEE
        ADDI.B  #$0301,A5                       ; $2ACAF0
loc_2ACAF4:
        MOVE.W  (A2),(A7)                       ; $2ACAF4
        ADDI.W  #$02E9,-(A7)                    ; $2ACAF6
        MOVE.W  A7,(A7)+                        ; $2ACAFA
        DC.W    $04E9               ; $2ACAFC DC.W    $04E9
        BCLR    D1,(A2)+                        ; $2ACAFE
        MOVE.W  A5,-(A7)                        ; $2ACB00
        ADDI.B  #$02A7,-$39(A5,A7.L)            ; $2ACB02
        DC.W    $04DC               ; $2ACB08 DC.W    $04DC
        BCLR    D1,$00DA(PC)                    ; $2ACB0A
        DC.W    $04AD,$03E0,$0137,$056A; $2ACB0E SUBI.L  #$03E00137,$056A(A5)
        DC.W    $050D               ; $2ACB16 BTST    D2,A5
        BTST    D0,(A3)+                        ; $2ACB18
loc_2ACB1A:
        BCLR    D2,$0502(A3)                    ; $2ACB1A
        DC.W    $00BC,$047D,$03F5,$00D3,$054C; $2ACB1E ORI.L  #$047D03F5,#$00D3054C
        DC.W    $053D               ; $2ACB28 BTST    D2,<EA:3D>
        DC.W    $00B6,$05FD,$0336,$00F5; $2ACB2A ORI.L  #$05FD0336,-$0B(A6,D0.W)
        BCLR    D2,-(A7)                        ; $2ACB32
        DC.W    $033E               ; $2ACB34 BTST    D1,<EA:3E>
        BTST    D0,#$0482                       ; $2ACB36
        BSET    D1,$012D(A6)                    ; $2ACB3A
        SUBI.L  #$040C00E2,(A7)                 ; $2ACB3E
        BSET    D2,(A2)                         ; $2ACB44
        DC.W    $02EE               ; $2ACB46 DC.W    $02EE
        DC.W    $00FB               ; $2ACB48 DC.W    $00FB
        SUBI.W  #$03C4,$00E9(A4)                ; $2ACB4A
        DC.W    $06BB,$0275,$FE9D,$06C5; $2ACB50 ADDI.L  #$0275FE9D,-$3B(PC,D0.W)
        BCHG    D1,-$79(A2,A7.L)                ; $2ACB58
        BCHG    D2,(A2)                         ; $2ACB5C
        BCLR    D1,D5                           ; $2ACB5E
        MOVE.W  -(A1),(A7)                      ; $2ACB60
        BCHG    D2,D7                           ; $2ACB62
        ANDI.L  #$FEB806EE,A0                   ; $2ACB64
        SUBI.W  #$0024,A2                       ; $2ACB6A
        DC.W    $06F4               ; $2ACB6E DC.W    $06F4
        BCLR    D1,-(A6)                        ; $2ACB70
        DC.W    $00E7               ; $2ACB72 DC.W    $00E7
        BCLR    D2,D1                           ; $2ACB74
        BCLR    D1,$0102(PC)                    ; $2ACB76
        BCHG    D2,$5D(PC,D0.W)                 ; $2ACB7A
        DC.W    $003F,$06DB         ; $2ACB7E ORI.B  #$06DB,<EA:3F>
        SUBI.B  #$FF29,$68(A5,D0.W)             ; $2ACB82
        SUBI.W  #$FF44,D7                       ; $2ACB88
        DC.W    $06C0               ; $2ACB8C DC.W    $06C0
        BSET    D0,(A1)                         ; $2ACB8E
        MOVE.W  -(A0),$054D(A7)                 ; $2ACB90
        BSET    D0,-(A4)                        ; $2ACB94
        MOVE.W  $06E9(PC),$02A9(A7)             ; $2ACB96
        DC.W    $00FD               ; $2ACB9C DC.W    $00FD
        BCHG    D2,-$43(A6,D0.W)                ; $2ACB9E
loc_2ACBA2:
        BTST    D0,(A1)+                        ; $2ACBA2
        DC.W    $06D3               ; $2ACBA4 DC.W    $06D3
        BSET    D0,$005C(A0)                    ; $2ACBA6
        BCHG    D2,-(A1)                        ; $2ACBAA
        BSET    D0,$0076(PC)                    ; $2ACBAC
        SUBI.W  #$0275,-(A1)                    ; $2ACBB0
        MOVE.W  (A4),$0464(A7)                  ; $2ACBB4
        ANDI.W  #$00B5,-$17(A2,D0.W)            ; $2ACBB8
        BSET    D1,-(A5)                        ; $2ACBBE
        ORI.L  #$04E603E8,(A0)+                 ; $2ACBC0
        MOVE.W  -$4A(A7,D0.W),$02B0(A7)         ; $2ACBC6
        DC.W    $00B8,$043B,$0423,$009B; $2ACBCC ORI.L  #$043B0423,$009B.W
        BCLR    D1,-$4C(A2,D0.W)                ; $2ACBD4
        MOVE.W  (A0)+,$0437(A7)                 ; $2ACBD8
        SUBI.B  #$FF79,-(A6)                    ; $2ACBDC
        BTST    D2,(A1)+                        ; $2ACBE0
        BCHG    D0,(A7)                         ; $2ACBE2
        MOVE.W  -(A7),-$2A(A7,D0.W)             ; $2ACBE4
        BCHG    D0,(A0)+                        ; $2ACBE8
        MOVE.W  A4,-(A7)                        ; $2ACBEA
        BSET    D1,D5                           ; $2ACBEC
        DC.W    $02DC               ; $2ACBEE DC.W    $02DC
        MOVE.W  D4,$09(A7,D0.W)                 ; $2ACBF0
        DC.W    $02DB               ; $2ACBF4 DC.W    $02DB
        DC.W    $001E,$0560         ; $2ACBF6 ORI.B  #$0560,(A6)+
        BCLR    D0,-(A6)                        ; $2ACBFA
        MOVE.W  D6,$044F(A7)                    ; $2ACBFC
        BTST    D1,-$0042(A3)                   ; $2ACC00
        BTST    D2,(A6)                         ; $2ACC04
        DC.W    $003C,$FEAE,$04D7   ; $2ACC06 ORI.B  #$FEAE,#$04D7
        ORI.W  #$FE61,-$2C(A5,D0.W)             ; $2ACC0C
        BCLR    D0,#$FF5A                       ; $2ACC12
        BTST    D2,(A4)                         ; $2ACC16
        BCLR    D0,D3                           ; $2ACC18
        MOVE.W  -(A6),$49(A7,D0.W)              ; $2ACC1A
        ORI.W  #$FE67,$47(A2,D0.W)              ; $2ACC1E
        BCLR    D0,$FF5F05E3                    ; $2ACC24
        ORI.W  #$FE23,A1                        ; $2ACC2A
        BSET    D2,-(A3)                        ; $2ACC2E
        DC.W    $000E,$FE23         ; $2ACC30 ORI.B  #$FE23,A6
        DC.W    $04D6               ; $2ACC34 DC.W    $04D6
        DC.W    $000E,$FE87         ; $2ACC36 ORI.B  #$FE87,A6
        DC.W    $04D6               ; $2ACC3A DC.W    $04D6
        ORI.W  #$FE87,$0436(A3)                 ; $2ACC3C
        BTST    D1,(A0)                         ; $2ACC42
        DC.W    $0008,$03B7         ; $2ACC44 ORI.B  #$03B7,A0
        DC.W    $02BE,$0054,$04C7   ; $2ACC48 ANDI.L  #$005404C7,<EA:3E>
        BTST    D0,-(A7)                        ; $2ACC4E
        ORI.W  #$0546,-(A2)                     ; $2ACC50
        BCHG    D0,$0015(PC)                    ; $2ACC54
        SUBI.B  #$0316,$0098.W                  ; $2ACC58
        DC.W    $0548               ; $2ACC5E BCHG    D2,A0
        BCLR    D0,D1                           ; $2ACC60
        ORI.L  #$05560179,-(A5)                 ; $2ACC62
        DC.W    $0029,$0507,$01BE   ; $2ACC68 ORI.B  #$0507,$01BE(A1)
        ORI.W  #$03FE,(A3)+                     ; $2ACC6E
        ORI.L  #$006B044D,D5                    ; $2ACC72
        ORI.W  #$003A,D0                        ; $2ACC78
        BCHG    D2,(A7)                         ; $2ACC7C
        DC.W    $017D               ; $2ACC7E BCHG    D0,<EA:3D>
        ORI.L  #$044E0044,(A0)                  ; $2ACC80
        ORI.L  #$04F6003B,-(A0)                 ; $2ACC86
        DC.W    $00CE               ; $2ACC8C DC.W    $00CE
        DC.W    $04F3               ; $2ACC8E DC.W    $04F3
        DC.W    $0000,$00CF         ; $2ACC90 ORI.B  #$00CF,D0
        BSET    D1,$000B(A5)                    ; $2ACC94
        ORI.W  #$03F2,(A3)+                     ; $2ACC98
        ORI.W  #$0058,$0010(A0)                 ; $2ACC9C
        BTST    D2,D0                           ; $2ACCA2
        ANDI.W  #$0270,-(A0)                    ; $2ACCA4
        ANDI.L  #$02900210,D0                   ; $2ACCA8
        ADDI.B  #$0310,D0                       ; $2ACCAE
        BTST    D1,D0                           ; $2ACCB2
        SUBI.B  #$0500,(A0)                     ; $2ACCB4
        BCHG    D1,(A0)                         ; $2ACCB8
        BCHG    D1,D0                           ; $2ACCBA
        SUBI.B  #$0600,(A0)                     ; $2ACCBC
        BTST    D1,$20(A0,D0.W)                 ; $2ACCC0
        SUBI.B  #$0500,(A0)                     ; $2ACCC4
        DC.W    $02C0               ; $2ACCC8 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2ACCCA ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2ACCD2 DC.W    $02D0
        DC.W    $0210,$0600         ; $2ACCD4 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2ACCD8
        BTST    D2,D0                           ; $2ACCDE
        DC.W    $02F0               ; $2ACCE0 DC.W    $02F0
        DC.W    $02E0               ; $2ACCE2 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2ACCE4
        BCHG    D1,(A0)                         ; $2ACCE8
        BTST    D1,(A0)                         ; $2ACCEA
        DC.W    $0210,$0300         ; $2ACCEC ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2ACCF0
        ADDI.B  #$0270,D0                       ; $2ACCF6
        DC.W    $02E0               ; $2ACCFA DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2ACCFC
        ANDI.W  #$0300,-(A0)                    ; $2ACD00
        DC.W    $0210,$0300         ; $2ACD04 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2ACD08
        ANDI.L  #$04100300,-(A0)                ; $2ACD0A
        BTST    D1,-(A0)                        ; $2ACD10
        DC.W    $02B0,$0010,$6E00,$0000; $2ACD12 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2ACD1A ORI.B  #$0020,(A0)
loc_2ACD1E:
        DC.W    $0030,$0610,$6F00   ; $2ACD1E ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2ACD24
        SUBI.B  #$7000,(A0)                     ; $2ACD28
        ORI.W  #$0070,-(A0)                     ; $2ACD2C
        SUBI.B  #$6F00,(A0)                     ; $2ACD30
        DC.W    $0000,$0030         ; $2ACD34 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2ACD38 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2ACD3C ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2ACD40 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2ACD44
        DC.W    $00B0,$0210,$0400,$00D0; $2ACD4A ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2ACD52 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2ACD54
        ORI.L  #$00900611,-(A0)                 ; $2ACD58
        BTST    D3,D1                           ; $2ACD5E
        DC.W    $00B0,$0010,$6A00,$00E0; $2ACD60 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2ACD68 DC.W    $00F0
        BTST    D0,D0                           ; $2ACD6A
        BTST    D0,(A0)                         ; $2ACD6C
        DC.W    $0210,$6C00         ; $2ACD6E ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2ACD72
        SUBI.B  #$6B00,(A0)                     ; $2ACD76
        BTST    D0,D0                           ; $2ACD7A
        DC.W    $00F0               ; $2ACD7C DC.W    $00F0
        DC.W    $0211,$6901         ; $2ACD7E ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2ACD82 DC.W    $00E0
        DC.W    $0010,$6300         ; $2ACD84 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2ACD88
        BCHG    D0,(A0)                         ; $2ACD8A
        BCHG    D0,-(A0)                        ; $2ACD8C
        BCHG    D0,$10(A0,D0.W)                 ; $2ACD8E
loc_2ACD92:
        BCS.W  loc_2ACF24                       ; $2ACD92
        BCLR    D0,D0                           ; $2ACD96
        SUBI.B  #$6400,(A0)                     ; $2ACD98
        BCHG    D0,-(A0)                        ; $2ACD9C
        BCHG    D0,(A0)                         ; $2ACD9E
        ADDI.B  #$6201,(A1)                     ; $2ACDA0
        BCHG    D0,$10(A0,D0.W)                 ; $2ACDA4
        BPL.W  loc_2ACF4A                       ; $2ACDA8
        BCLR    D0,-$40(A0,D0.W)                ; $2ACDAC
        BSET    D0,(A0)                         ; $2ACDB0
        DC.W    $0210,$6C00         ; $2ACDB2 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2ACDB6
        SUBI.B  #$6B00,(A0)                     ; $2ACDBA
        BSET    D0,D0                           ; $2ACDBE
        BCLR    D0,$11(A0,D0.W)                 ; $2ACDC0
        BVS.S  loc_2ACDC7                       ; $2ACDC4
        BSET    D0,(A0)                         ; $2ACDC6
        DC.W    $0010,$6300         ; $2ACDC8 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2ACDCC ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2ACDD0 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2ACDD4 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2ACDD8
        SUBI.B  #$6400,(A0)                     ; $2ACDDC
        DC.W    $0220,$0210         ; $2ACDE0 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2ACDE4 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2ACDE8 ANDI.B  #$0010,D0
        BNE.W  loc_2AD14E                       ; $2ACDEC
        BCHG    D1,-$80(A0,D0.W)                ; $2ACDF0
        BCLR    D1,(A0)                         ; $2ACDF4
        ADDI.B  #$6700,(A0)                     ; $2ACDF6
        BCLR    D1,-(A0)                        ; $2ACDFA
        BCLR    D1,$10(A0,D0.W)                 ; $2ACDFC
        BVC.W  loc_2AD1C2                       ; $2ACE00
        BSET    D1,(A0)                         ; $2ACE04
        SUBI.B  #$6700,(A0)                     ; $2ACE06
        BCHG    D1,-(A0)                        ; $2ACE0A
        BCLR    D1,(A0)                         ; $2ACE0C
        DC.W    $0010,$0300         ; $2ACE0E ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2ACE12
        BSET    D1,$00(A0,D0.W)                 ; $2ACE14
        SUBI.B  #$0210,(A0)                     ; $2ACE18
        BTST    D2,D0                           ; $2ACE1C
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2ACE1E
        SUBI.B  #$0400,D0                       ; $2ACE24
        BSET    D1,$10(A0,D0.W)                 ; $2ACE28
        BCS.W  loc_2AD26E                       ; $2ACE2C
        SUBI.W  #$0460,(A0)                     ; $2ACE30
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2ACE34
        SUBI.L  #$04800410,(A0)                 ; $2ACE3A
        BCC.W  loc_2AD2A2                       ; $2ACE40
        SUBI.W  #$0010,(A0)                     ; $2ACE44
        BTST    D1,D0                           ; $2ACE48
        DC.W    $04E0               ; $2ACE4A DC.W    $04E0
        DC.W    $04F0               ; $2ACE4C DC.W    $04F0
        BTST    D2,D0                           ; $2ACE4E
        BTST    D2,(A0)                         ; $2ACE50
        DC.W    $0210,$0500         ; $2ACE52 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2ACE56
        SUBI.B  #$0400,(A0)                     ; $2ACE5A
        BTST    D2,D0                           ; $2ACE5E
        DC.W    $04F0               ; $2ACE60 DC.W    $04F0
        DC.W    $0010,$6500         ; $2ACE62 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2ACE66
        BCHG    D2,(A0)                         ; $2ACE68
        BCHG    D2,-(A0)                        ; $2ACE6A
        BCHG    D2,$10(A0,D0.W)                 ; $2ACE6C
        BLS.W  loc_2AD402                       ; $2ACE70
        BCLR    D2,D0                           ; $2ACE74
        SUBI.B  #$6400,(A0)                     ; $2ACE76
        BCHG    D2,-(A0)                        ; $2ACE7A
        BCHG    D2,(A0)                         ; $2ACE7C
        DC.W    $0000,$6600         ; $2ACE7E ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2ACE82
        DC.W    $04D0               ; $2ACE88 DC.W    $04D0
        DC.W    $0000,$6600         ; $2ACE8A ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2ACE8E
        BCLR    D2,-$40(A0,D0.W)                ; $2ACE90
        BSET    D2,(A0)                         ; $2ACE94
        CMPI.B  #$005E,D0                       ; $2ACE96
        ORI.W  #$04E9,(A6)+                     ; $2ACE9A
        ANDI.W  #$FF76,A3                       ; $2ACE9E
        DC.W    $04F1               ; $2ACEA2 DC.W    $04F1
        ANDI.W  #$0096,A3                       ; $2ACEA4
        DC.W    $05CB               ; $2ACEA8 BSET    D2,A3
        BCLR    D1,D7                           ; $2ACEAA
        DC.W    $00AD,$05C1,$0387,$FF53; $2ACEAC ORI.L  #$05C10387,-$00AD(A5)
        SUBI.W  #$02B2,D7                       ; $2ACEB4
        ORI.L  #$04F90406,(A2)+                 ; $2ACEB8
        DC.W    $00B2,$043F,$02B2,$FF7B; $2ACEBE ORI.L  #$043F02B2,$7B(A2,A7.L)
        DC.W    $04F0               ; $2ACEC6 DC.W    $04F0
        SUBI.B  #$FF5A,D6                       ; $2ACEC8
        BTST    D2,-(A1)                        ; $2ACECC
        SUBI.B  #$FFA7,A0                       ; $2ACECE
        BCLR    D2,-$66(A1,D0.W)                ; $2ACED2
        DC.W    $FFFC,$0637         ; $2ACED6 MOVE.W  #$0637,<EA:3F>
        SUBI.W  #$FFF8,$058C.W                  ; $2ACEDA
        DC.W    $04B8,$FFA4,$0525,$0408; $2ACEE0 SUBI.L  #$FFA40525,$0408.W
        ORI.W  #$0591,(A0)+                     ; $2ACEE8
        DC.W    $04B8,$0054,$056B,$03AD; $2ACEEC SUBI.L  #$0054056B,$03AD.W
        MOVE.W  (A0),$0521(A7)                  ; $2ACEF4
        BCLR    D1,-$0109(A1)                   ; $2ACEF8
        DC.W    $04EF               ; $2ACEFC DC.W    $04EF
        ANDI.W  #$FEAE,(A0)                     ; $2ACEFE
        BTST    D2,$35(A5,D0.W)                 ; $2ACF02
        DC.W    $FEFF               ; $2ACF06 MOVE.W  <EA:3F>,(A7)+
        DC.W    $04FE               ; $2ACF08 DC.W    $04FE
        BCLR    D1,$FF6404C8                    ; $2ACF0A
        ANDI.W  #$FF14,D0                       ; $2ACF10
        DC.W    $04E0               ; $2ACF14 DC.W    $04E0
        ANDI.W  #$FF09,-(A7)                    ; $2ACF16
        DC.W    $04C7               ; $2ACF1A DC.W    $04C7
        ANDI.W  #$FEBD,(A0)                     ; $2ACF1C
        ADDI.B  #$01F2,A1                       ; $2ACF20
loc_2ACF24:
        MOVEA.W $67(A3,D0.W),A7                 ; $2ACF24
        BSET    D0,-$50(A4,A7.L)                ; $2ACF28
        DC.W    $04C5               ; $2ACF2C DC.W    $04C5
        DC.W    $0219,$FEFA         ; $2ACF2E ANDI.B  #$FEFA,(A1)+
        ADDI.W  #$01A6,A4                       ; $2ACF32
        MOVE.W  -(A1),(A7)                      ; $2ACF36
        BTST    D2,(A7)                         ; $2ACF38
        DC.W    $0234,$00FE,$04DD   ; $2ACF3A ANDI.B  #$00FE,-$23(A4,D0.W)
        ANDI.W  #$0157,(A6)                     ; $2ACF40
        BTST    D2,$03A7.W                      ; $2ACF44
        BTST    D0,(A3)                         ; $2ACF48
loc_2ACF4A:
        BCHG    D2,-$5D(PC,D0.W)                ; $2ACF4A
        DC.W    $00B5,$04AD,$024E,$00F3; $2ACF4E ORI.L  #$04AD024E,-$0D(A5,D0.W)
        BTST    D2,(A0)                         ; $2ACF56
        DC.W    $03BF               ; $2ACF58 BCLR    D1,<EA:3F>
        DC.W    $00A9,$0642,$01C7,$0137; $2ACF5A ORI.L  #$064201C7,$0137(A1)
        BSET    D2,$01CF(A1)                    ; $2ACF62
        BCHG    D0,$04B4025C                    ; $2ACF66
        DC.W    $014A               ; $2ACF6C BCHG    D0,A2
        DC.W    $04C9               ; $2ACF6E DC.W    $04C9
        ANDI.W  #$00FD,$1E(A1,D0.W)             ; $2ACF70
        BCHG    D0,#$0145                       ; $2ACF76
        SUBI.L  #$0227010C,-(A5)                ; $2ACF7A
        DC.W    $074B               ; $2ACF80 BCHG    D3,A3
        DC.W    $00D4               ; $2ACF82 DC.W    $00D4
        MOVE.W  (A5),-(A7)                      ; $2ACF84
        BCHG    D3,D1                           ; $2ACF86
        DC.W    $01CC               ; $2ACF88 BSET    D0,A4
        MOVE.W  (A7)+,(A7)+                     ; $2ACF8A
        DC.W    $05CD               ; $2ACF8C BSET    D2,A5
        BCLR    D0,#$FED8                       ; $2ACF8E
        BSET    D2,(A0)+                        ; $2ACF92
        DC.W    $00C3               ; $2ACF94 DC.W    $00C3
        MOVE.W  A6,-(A7)                        ; $2ACF96
        BTST    D3,$02D8(A7)                    ; $2ACF98
        ORI.W  #$0731,-(A0)                     ; $2ACF9C
        ANDI.W  #$0136,A6                       ; $2ACFA0
        BCLR    D2,#$023E                       ; $2ACFA4
        BTST    D0,$05BA(A7)                    ; $2ACFA8
        DC.W    $02C7               ; $2ACFAC DC.W    $02C7
        ORI.W  #$0736,(A1)+                     ; $2ACFAE
        ANDI.L  #$FF6805C1,-(A2)                ; $2ACFB2
        ANDI.L  #$FF61074D,(A1)                 ; $2ACFB8
        ORI.W  #$FFEB,A2                        ; $2ACFBE
        BSET    D2,(A2)+                        ; $2ACFC2
        DC.W    $003A,$FFE4,$073A   ; $2ACFC4 ORI.B  #$FFE4,$073A(PC)
        BCHG    D0,(A7)                         ; $2ACFCA
        BCHG    D0,$05C6(A4)                    ; $2ACFCC
        BCHG    D0,D5                           ; $2ACFD0
loc_2ACFD2:
        BCHG    D0,-(A5)                        ; $2ACFD2
        BCHG    D3,D6                           ; $2ACFD4
        ORI.L  #$00E305D2,D1                    ; $2ACFD6
        ORI.W  #$00DC,$5F(A0,D0.W)              ; $2ACFDC
        DC.W    $00ED               ; $2ACFE2 DC.W    $00ED
        MOVE.W  (A4),$0466(A7)                  ; $2ACFE4
        DC.W    $00E8               ; $2ACFE8 DC.W    $00E8
        DC.W    $00B5,$04EA,$025C,$0097; $2ACFEA ORI.L  #$04EA025C,-$69(A5,D0.W)
        DC.W    $04E3               ; $2ACFF2 DC.W    $04E3
        ANDI.W  #$FF76,(A7)+                    ; $2ACFF4
        BCLR    D1,$0126.W                      ; $2ACFF8
        DC.W    $00BA,$043B,$0299,$009C; $2ACFFC ORI.L  #$043B0299,$009C(PC)
        BCLR    D1,$2B(A0,D0.W)                 ; $2AD004
        MOVE.W  (A2)+,$0435(A7)                 ; $2AD008
        ANDI.L  #$FF7B05B2,(A5)+                ; $2AD00C
        ORI.L  #$FFEE05AE,D4                    ; $2AD012
        ORI.L  #$FF4503DC,(A1)                  ; $2AD018
        BTST    D0,-(A5)                        ; $2AD01E
        MOVE.W  (A6)+,$03E0(A7)                 ; $2AD020
        BTST    D0,(A0)+                        ; $2AD024
        DC.W    $0006,$05D9         ; $2AD026 ORI.B  #$05D9,D6
        BTST    D0,D6                           ; $2AD02A
        DC.W    $FFB9,$0407,$0199,$FFD1; $2AD02C MOVE.W  $04070199,-$2F(A7,A7.L)
        BTST    D2,-(A3)                        ; $2AD034
        DC.W    $001D,$FE84         ; $2AD036 ORI.B  #$FE84,(A5)+
        DC.W    $04DD               ; $2AD03A DC.W    $04DD
        ORI.W  #$FE8F,-$64(A7,D0.W)             ; $2AD03C
        DC.W    $00E2               ; $2AD042 DC.W    $00E2
        DC.W    $FFE9,$05E3         ; $2AD044 MOVE.W  $05E3(A1),<EA:3F>
        ORI.L  #$FFDE0542,A0                    ; $2AD048
        ORI.W  #$FE58,$02(A4,D0.W)              ; $2AD04E
        DC.W    $00E0               ; $2AD054 DC.W    $00E0
        MOVE.W  -$1D(A2,D0.W),$48(A7,D0.W)      ; $2AD056
        MOVE.W  -(A7),D7                        ; $2AD05C
        BSET    D2,-(A3)                        ; $2AD05E
        DC.W    $000D,$FE27         ; $2AD060 ORI.B  #$FE27,A5
        DC.W    $04D4               ; $2AD064 DC.W    $04D4
        DC.W    $000D,$FE86         ; $2AD066 ORI.B  #$FE86,A5
        DC.W    $04D4               ; $2AD06A DC.W    $04D4
        ORI.W  #$FE86,$0466(A1)                 ; $2AD06C
        DC.W    $014C               ; $2AD072 BCHG    D0,A4
        DC.W    $FFF0,$0405         ; $2AD074 MOVE.W  $05(A0,D0.W),<EA:3F>
        BCLR    D0,-(A4)                        ; $2AD078
        ORI.W  #$0323,(A4)+                     ; $2AD07A
        DC.W    $0007,$00E1         ; $2AD07E ORI.B  #$00E1,D7
        BCLR    D1,D5                           ; $2AD082
        MOVE.W  $74(A0,D0.W),-$65(A7,D0.W)      ; $2AD084
        BCHG    D0,(A3)+                        ; $2AD08A
        ORI.W  #$03BB,-$42(A5,A7.L)             ; $2AD08C
        DC.W    $00FA               ; $2AD092 DC.W    $00FA
        BCLR    D1,D4                           ; $2AD094
        MOVE.W  (A7),-$72(A7,D0.W)              ; $2AD096
        BSET    D1,D5                           ; $2AD09A
        DC.W    $FFF3,$00A2         ; $2AD09C MOVE.W  -$5E(A3,D0.W),<EA:3F>
        ANDI.W  #$00C7,$0112.W                  ; $2AD0A0
        DC.W    $0237,$006A,$00FE   ; $2AD0A6 ANDI.B  #$006A,-$02(A7,D0.W)
        BCLR    D1,-$005F(A1)                   ; $2AD0AC
        DC.W    $00ED               ; $2AD0B0 DC.W    $00ED
        ANDI.W  #$0074,(A5)+                    ; $2AD0B2
        BCHG    D0,(A5)+                        ; $2AD0B6
        BSET    D0,D7                           ; $2AD0B8
        DC.W    $FFE9,$0147         ; $2AD0BA MOVE.W  $0147(A1),<EA:3F>
        BCLR    D0,(A6)                         ; $2AD0BE
        DC.W    $0008,$0140         ; $2AD0C0 ORI.B  #$0140,A0
        DC.W    $0235,$00F2,$0116   ; $2AD0C4 ANDI.B  #$00F2,$16(A5,D0.W)
        ANDI.L  #$00C00120,D3                   ; $2AD0CA
        DC.W    $0010,$0500         ; $2AD0D0 ORI.B  #$0500,(A0)
        ANDI.W  #$0270,-(A0)                    ; $2AD0D4
        ANDI.L  #$02900210,D0                   ; $2AD0D8
        ADDI.B  #$0310,D0                       ; $2AD0DE
        BTST    D1,D0                           ; $2AD0E2
        SUBI.B  #$0500,(A0)                     ; $2AD0E4
        BCHG    D1,(A0)                         ; $2AD0E8
        BCHG    D1,D0                           ; $2AD0EA
        SUBI.B  #$0600,(A0)                     ; $2AD0EC
        BTST    D1,$20(A0,D0.W)                 ; $2AD0F0
        SUBI.B  #$0500,(A0)                     ; $2AD0F4
        DC.W    $02C0               ; $2AD0F8 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2AD0FA ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2AD102 DC.W    $02D0
        DC.W    $0210,$0600         ; $2AD104 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2AD108
        BTST    D2,D0                           ; $2AD10E
        DC.W    $02F0               ; $2AD110 DC.W    $02F0
        DC.W    $02E0               ; $2AD112 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2AD114
        BCHG    D1,(A0)                         ; $2AD118
        BTST    D1,(A0)                         ; $2AD11A
        DC.W    $0210,$0300         ; $2AD11C ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2AD120
        ADDI.B  #$0270,D0                       ; $2AD126
        DC.W    $02E0               ; $2AD12A DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2AD12C
        ANDI.W  #$0300,-(A0)                    ; $2AD130
        DC.W    $0210,$0300         ; $2AD134 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2AD138
        ANDI.L  #$04100300,-(A0)                ; $2AD13A
        BTST    D1,-(A0)                        ; $2AD140
        DC.W    $02B0,$0010,$6E00,$0000; $2AD142 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2AD14A ORI.B  #$0020,(A0)
loc_2AD14E:
        DC.W    $0030,$0610,$6F00   ; $2AD14E ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AD154
        SUBI.B  #$7000,(A0)                     ; $2AD158
        ORI.W  #$0070,-(A0)                     ; $2AD15C
        SUBI.B  #$6F00,(A0)                     ; $2AD160
        DC.W    $0000,$0030         ; $2AD164 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AD168 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AD16C ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AD170 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AD174
        DC.W    $00B0,$0210,$0400,$00D0; $2AD17A ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AD182 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AD184
        ORI.L  #$00900611,-(A0)                 ; $2AD188
        BTST    D3,D1                           ; $2AD18E
        DC.W    $00B0,$0010,$6A00,$00E0; $2AD190 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AD198 DC.W    $00F0
        BTST    D0,D0                           ; $2AD19A
        BTST    D0,(A0)                         ; $2AD19C
        DC.W    $0210,$6C00         ; $2AD19E ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AD1A2
        SUBI.B  #$6B00,(A0)                     ; $2AD1A6
        BTST    D0,D0                           ; $2AD1AA
        DC.W    $00F0               ; $2AD1AC DC.W    $00F0
        DC.W    $0211,$6901         ; $2AD1AE ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AD1B2 DC.W    $00E0
        DC.W    $0010,$6300         ; $2AD1B4 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AD1B8
        BCHG    D0,(A0)                         ; $2AD1BA
        BCHG    D0,-(A0)                        ; $2AD1BC
        BCHG    D0,$10(A0,D0.W)                 ; $2AD1BE
loc_2AD1C2:
        BCS.W  loc_2AD354                       ; $2AD1C2
        BCLR    D0,D0                           ; $2AD1C6
        SUBI.B  #$6400,(A0)                     ; $2AD1C8
        BCHG    D0,-(A0)                        ; $2AD1CC
        BCHG    D0,(A0)                         ; $2AD1CE
        ADDI.B  #$6201,(A1)                     ; $2AD1D0
        BCHG    D0,$10(A0,D0.W)                 ; $2AD1D4
        BPL.W  loc_2AD37A                       ; $2AD1D8
        BCLR    D0,-$40(A0,D0.W)                ; $2AD1DC
        BSET    D0,(A0)                         ; $2AD1E0
        DC.W    $0210,$6C00         ; $2AD1E2 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AD1E6
        SUBI.B  #$6B00,(A0)                     ; $2AD1EA
        BSET    D0,D0                           ; $2AD1EE
        BCLR    D0,$11(A0,D0.W)                 ; $2AD1F0
        BVS.S  loc_2AD1F7                       ; $2AD1F4
        BSET    D0,(A0)                         ; $2AD1F6
        DC.W    $0010,$6300         ; $2AD1F8 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AD1FC ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AD200 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AD204 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AD208
        SUBI.B  #$6400,(A0)                     ; $2AD20C
        DC.W    $0220,$0210         ; $2AD210 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AD214 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AD218 ANDI.B  #$0010,D0
        BNE.W  loc_2AD57E                       ; $2AD21C
        BCHG    D1,-$80(A0,D0.W)                ; $2AD220
        BCLR    D1,(A0)                         ; $2AD224
        ADDI.B  #$6700,(A0)                     ; $2AD226
        BCLR    D1,-(A0)                        ; $2AD22A
        BCLR    D1,$10(A0,D0.W)                 ; $2AD22C
        BVC.W  loc_2AD5F2                       ; $2AD230
        BSET    D1,(A0)                         ; $2AD234
        SUBI.B  #$6700,(A0)                     ; $2AD236
        BCHG    D1,-(A0)                        ; $2AD23A
        BCLR    D1,(A0)                         ; $2AD23C
        DC.W    $0010,$0300         ; $2AD23E ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AD242
        BSET    D1,$00(A0,D0.W)                 ; $2AD244
        SUBI.B  #$0210,(A0)                     ; $2AD248
        BTST    D2,D0                           ; $2AD24C
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AD24E
        SUBI.B  #$0400,D0                       ; $2AD254
        BSET    D1,$10(A0,D0.W)                 ; $2AD258
        BCS.W  loc_2AD69E                       ; $2AD25C
        SUBI.W  #$0460,(A0)                     ; $2AD260
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AD264
        SUBI.L  #$04800410,(A0)                 ; $2AD26A
        BCC.W  loc_2AD6D2                       ; $2AD270
        SUBI.W  #$0010,(A0)                     ; $2AD274
        BTST    D1,D0                           ; $2AD278
        DC.W    $04E0               ; $2AD27A DC.W    $04E0
        DC.W    $04F0               ; $2AD27C DC.W    $04F0
        BTST    D2,D0                           ; $2AD27E
        BTST    D2,(A0)                         ; $2AD280
        DC.W    $0210,$0500         ; $2AD282 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2AD286
        SUBI.B  #$0400,(A0)                     ; $2AD28A
        BTST    D2,D0                           ; $2AD28E
        DC.W    $04F0               ; $2AD290 DC.W    $04F0
        DC.W    $0010,$6500         ; $2AD292 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2AD296
        BCHG    D2,(A0)                         ; $2AD298
        BCHG    D2,-(A0)                        ; $2AD29A
        BCHG    D2,$10(A0,D0.W)                 ; $2AD29C
        BLS.W  loc_2AD832                       ; $2AD2A0
        BCLR    D2,D0                           ; $2AD2A4
        SUBI.B  #$6400,(A0)                     ; $2AD2A6
        BCHG    D2,-(A0)                        ; $2AD2AA
        BCHG    D2,(A0)                         ; $2AD2AC
        DC.W    $0000,$6600         ; $2AD2AE ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AD2B2
        DC.W    $04D0               ; $2AD2B8 DC.W    $04D0
        DC.W    $0000,$6600         ; $2AD2BA ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2AD2BE
        BCLR    D2,-$40(A0,D0.W)                ; $2AD2C0
        BSET    D2,(A0)                         ; $2AD2C4
        CMPI.B  #$004E,D0                       ; $2AD2C6
        ORI.W  #$0535,A6                        ; $2AD2CA
        DC.W    $0226,$FF75         ; $2AD2CE ANDI.B  #$FF75,-(A6)
        DC.W    $053E               ; $2AD2D2 BTST    D2,<EA:3E>
        DC.W    $0221,$0095         ; $2AD2D4 ANDI.B  #$0095,-(A1)
        ADDI.W  #$0322,(A2)+                    ; $2AD2D8
        DC.W    $00AE,$064F,$0328,$FF55; $2AD2DC ORI.L  #$064F0328,-$00AB(A6)
        DC.W    $04B0,$02AD,$009C,$05AB; $2AD2E4 SUBI.L  #$02AD009C,-$55(A0,D0.W)
        DC.W    $03CD               ; $2AD2EC BSET    D1,A5
        DC.W    $00B7,$04A6,$02B2,$FF7C; $2AD2EE ORI.L  #$04A602B2,$7C(A7,A7.L)
        BCLR    D2,-(A0)                        ; $2AD2F6
        BSET    D1,(A4)                         ; $2AD2F8
        MOVE.W  (A6)+,$05D0(A7)                 ; $2AD2FA
        DC.W    $03CA               ; $2AD2FE BSET    D1,A2
        MOVE.W  $0644(A4),$3E(A7,D0.W)          ; $2AD300
        DC.W    $FFFE               ; $2AD306 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $06F9               ; $2AD308 DC.W    $06F9
        BSET    D1,-$04(A7,A7.L)                ; $2AD30A
        ADDI.W  #$045E,-(A1)                    ; $2AD30E
        MOVE.W  $05D7(A2),-$39(A7,D0.W)         ; $2AD312
        ORI.W  #$0666,(A4)+                     ; $2AD318
        SUBI.W  #$005B,(A3)+                    ; $2AD31C
        BSET    D2,(A4)+                        ; $2AD320
        DC.W    $038C               ; $2AD322 BCLR    D1,A4
        MOVE.W  (A1)+,$059F(A7)                 ; $2AD324
        BCHG    D1,-$07(A0,A7.L)                ; $2AD328
        BSET    D2,$1F(A3,D0.W)                 ; $2AD32C
        MOVE.W  $0638(A6),(A7)                  ; $2AD330
        DC.W    $021C,$FF05         ; $2AD334 ANDI.B  #$FF05,(A4)+
        BCHG    D2,$6F(A1,D0.W)                 ; $2AD338
        MOVE.W  -(A4),$05CD(A7)                 ; $2AD33C
        DC.W    $01FE               ; $2AD340 BSET    D0,<EA:3E>
        MOVE.W  (A0),-(A7)                      ; $2AD342
        BSET    D2,$3B(A3,D0.W)                 ; $2AD344
        MOVE.W  D5,-(A7)                        ; $2AD348
        BSET    D2,(A6)                         ; $2AD34A
        DC.W    $0223,$FEBC         ; $2AD34C ANDI.B  #$FEBC,-(A3)
        BTST    D3,D6                           ; $2AD350
        BCLR    D0,(A6)                         ; $2AD352
loc_2AD354:
        MOVEA.W $65(A1,D0.W),A7                 ; $2AD354
        BCLR    D0,(A1)                         ; $2AD358
        MOVE.W  $05CE(A2),(A7)                  ; $2AD35A
        BSET    D0,-$04(A0,A7.L)                ; $2AD35E
        BCHG    D3,D0                           ; $2AD362
        BCHG    D0,D6                           ; $2AD364
        MOVE.W  -(A2),(A7)                      ; $2AD366
        BCLR    D2,-$0A(PC,D0.W)                ; $2AD368
        DC.W    $00D1               ; $2AD36C DC.W    $00D1
        BCLR    D2,D4                           ; $2AD36E
        DC.W    $0207,$0131         ; $2AD370 ANDI.B  #$0131,D7
        BSET    D2,D6                           ; $2AD374
        BCHG    D1,-(A4)                        ; $2AD376
        BTST    D0,(A4)+                        ; $2AD378
loc_2AD37A:
        ADDI.B  #$0373,D4                       ; $2AD37A
        DC.W    $00BB,$054E,$020B,$00CF; $2AD37E ORI.L  #$054E020B,-$31(PC,D0.W)
        BCLR    D2,(A6)                         ; $2AD386
        DC.W    $0388               ; $2AD388 BCLR    D1,A0
        DC.W    $00B9,$06F6,$01BF,$00E9,$06A2; $2AD38A ORI.L  #$06F601BF,$00E906A2
        BCLR    D0,$0131(A7)                    ; $2AD394
        BCHG    D2,(A0)+                        ; $2AD398
        DC.W    $0208,$0127         ; $2AD39A ANDI.B  #$0127,A0
        BCHG    D2,-(A4)                        ; $2AD39E
        DC.W    $022C,$00DE,$06E1   ; $2AD3A0 ANDI.B  #$00DE,$06E1(A4)
        BCHG    D0,$00EE(A6)                    ; $2AD3A6
        DC.W    $054D               ; $2AD3AA BCHG    D2,A5
        BSET    D0,(A3)+                        ; $2AD3AC
        DC.W    $00E2               ; $2AD3AE DC.W    $00E2
        DC.W    $04AB,$00D8,$FF63,$04C1; $2AD3B0 SUBI.L  #$00D8FF63,$04C1(A3)
        DC.W    $00DF               ; $2AD3B8 DC.W    $00DF
        DC.W    $00C2               ; $2AD3BA DC.W    $00C2
        BCHG    D2,D2                           ; $2AD3BC
        ANDI.W  #$0093,(A0)                     ; $2AD3BE
        BTST    D2,$4B(A0,D0.W)                 ; $2AD3C2
        MOVE.W  $13(A2,D0.W),$011C(A7)          ; $2AD3C6
        DC.W    $00CC               ; $2AD3CC DC.W    $00CC
        SUBI.L  #$028F009D,(A4)                 ; $2AD3CE
        BSET    D1,#$0115                       ; $2AD3D4
        MOVE.W  $0482(A5),$0289(A7)             ; $2AD3D8
        MOVE.W  #$0615,$00A9(A7)                ; $2AD3DE
        DC.W    $000A,$0616         ; $2AD3E4 ORI.B  #$0616,A2
        DC.W    $00BA,$FF62,$0433,$0109; $2AD3E8 ORI.L  #$FF620433,$0109(PC)
        MOVE.W  -(A7),$0432(A7)                 ; $2AD3F0
        DC.W    $00F8               ; $2AD3F4 DC.W    $00F8
        DC.W    $000F,$062B         ; $2AD3F6 ORI.B  #$062B,A7
        BTST    D0,-$26(A1,A7.L)                ; $2AD3FA
        SUBI.W  #$0180,D7                       ; $2AD3FE
loc_2AD402:
        DC.W    $FFDF               ; $2AD402 MOVE.W  (A7)+,<EA:3F>
        ADDI.B  #$0023,D6                       ; $2AD404
        MOVE.W  A7,(A7)                         ; $2AD408
        BCLR    D2,$0069(A4)                    ; $2AD40A
        DC.W    $FE7E               ; $2AD40E MOVEA.W <EA:3E>,A7
        BSET    D2,(A3)+                        ; $2AD410
        BTST    D0,D2                           ; $2AD412
        DC.W    $FFF7,$0636         ; $2AD414 MOVE.W  $36(A7,D0.W),<EA:3F>
        DC.W    $00BD,$0008,$0619   ; $2AD418 ORI.L  #$00080619,<EA:3D>
        ORI.L  #$FE670649,D1                    ; $2AD41E
        BTST    D0,(A1)+                        ; $2AD424
        DC.W    $FFE0               ; $2AD426 MOVE.W  -(A0),<EA:3F>
        DC.W    $06BE,$0046,$FE28   ; $2AD428 ADDI.L  #$0046FE28,<EA:3E>
        DC.W    $06BE,$000B,$FE28   ; $2AD42E ADDI.L  #$000BFE28,<EA:3E>
        BCLR    D2,$000B(A7)                    ; $2AD434
        MOVE.W  D6,(A7)                         ; $2AD438
        BCLR    D2,$0068(A7)                    ; $2AD43A
        MOVE.W  D6,(A7)                         ; $2AD43E
        DC.W    $04C9               ; $2AD440 DC.W    $04C9
        BTST    D0,$00(A2,D0.W)                 ; $2AD442
        SUBI.W  #$019E,$60(A0,D0.W)             ; $2AD446
        BCHG    D1,D1                           ; $2AD44C
        DC.W    $0035,$00E1,$0399   ; $2AD44E ORI.B  #$00E1,-$67(A5,D0.W)
        DC.W    $FFC9               ; $2AD454 MOVE.W  A1,<EA:3F>
        ORI.L  #$04F5013D,D1                    ; $2AD456
        ORI.L  #$03C6FFD4,A2                    ; $2AD45C
        DC.W    $010A               ; $2AD462 BTST    D0,A2
        BCLR    D1,-(A3)                        ; $2AD464
        DC.W    $FFBD,$0094         ; $2AD466 MOVE.W  <EA:3D>,-$6C(A7,D0.W)
        BSET    D1,(A3)+                        ; $2AD46A
        DC.W    $001D,$00B1         ; $2AD46C ORI.B  #$00B1,(A5)+
        ANDI.W  #$00CA,$16(A5,D0.W)             ; $2AD470
        DC.W    $023E,$0069         ; $2AD476 ANDI.B  #$0069,<EA:3E>
        DC.W    $00FA               ; $2AD47A DC.W    $00FA
        BSET    D1,D3                           ; $2AD47C
        DC.W    $FFC5               ; $2AD47E MOVE.W  D5,<EA:3F>
        DC.W    $00F6               ; $2AD480 DC.W    $00F6
        ANDI.W  #$0071,(A6)+                    ; $2AD482
        BCHG    D0,(A4)+                        ; $2AD486
        BSET    D0,D7                           ; $2AD488
        DC.W    $FFE8,$0145         ; $2AD48A MOVE.W  $0145(A0),<EA:3F>
        BCLR    D0,(A6)                         ; $2AD48E
        DC.W    $0007,$013D         ; $2AD490 ORI.B  #$013D,D7
        DC.W    $0235,$00F2,$0115   ; $2AD494 ANDI.B  #$00F2,$15(A5,D0.W)
        ANDI.L  #$00C00121,D3                   ; $2AD49A
        DC.W    $0010,$6E00         ; $2AD4A0 ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2AD4A4 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AD4A8 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2AD4AC
        ORI.W  #$0050,D0                        ; $2AD4B0
        SUBI.B  #$7000,(A0)                     ; $2AD4B4
        ORI.W  #$0070,-(A0)                     ; $2AD4B8
        SUBI.B  #$6F00,(A0)                     ; $2AD4BC
        DC.W    $0000,$0030         ; $2AD4C0 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AD4C4 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AD4C8 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AD4CC ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AD4D0
        DC.W    $00B0,$0210,$0400,$00D0; $2AD4D6 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AD4DE DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AD4E0
        ORI.L  #$00900611,-(A0)                 ; $2AD4E4
        BTST    D3,D1                           ; $2AD4EA
        DC.W    $00B0,$0010,$6A00,$00E0; $2AD4EC ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AD4F4 DC.W    $00F0
        BTST    D0,D0                           ; $2AD4F6
        BTST    D0,(A0)                         ; $2AD4F8
        DC.W    $0210,$6C00         ; $2AD4FA ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AD4FE
        SUBI.B  #$6B00,(A0)                     ; $2AD502
        BTST    D0,D0                           ; $2AD506
        DC.W    $00F0               ; $2AD508 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AD50A ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AD50E DC.W    $00E0
        DC.W    $0010,$6300         ; $2AD510 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AD514
        BCHG    D0,(A0)                         ; $2AD516
        BCHG    D0,-(A0)                        ; $2AD518
        BCHG    D0,$10(A0,D0.W)                 ; $2AD51A
        BCS.W  loc_2AD6B0                       ; $2AD51E
        BCLR    D0,D0                           ; $2AD522
        SUBI.B  #$6400,(A0)                     ; $2AD524
        BCHG    D0,-(A0)                        ; $2AD528
        BCHG    D0,(A0)                         ; $2AD52A
        ADDI.B  #$6201,(A1)                     ; $2AD52C
        BCHG    D0,$10(A0,D0.W)                 ; $2AD530
        BPL.W  loc_2AD6D6                       ; $2AD534
        BCLR    D0,-$40(A0,D0.W)                ; $2AD538
        BSET    D0,(A0)                         ; $2AD53C
        DC.W    $0210,$6C00         ; $2AD53E ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AD542
        SUBI.B  #$6B00,(A0)                     ; $2AD546
        BSET    D0,D0                           ; $2AD54A
        BCLR    D0,$11(A0,D0.W)                 ; $2AD54C
        BVS.S  loc_2AD553                       ; $2AD550
        BSET    D0,(A0)                         ; $2AD552
        DC.W    $0010,$6300         ; $2AD554 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AD558 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AD55C ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AD560 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AD564
        SUBI.B  #$6400,(A0)                     ; $2AD568
        DC.W    $0220,$0210         ; $2AD56C ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AD570 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AD574 ANDI.B  #$0010,D0
        BNE.W  loc_2AD7DA                       ; $2AD578
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2AD57C
        ADDI.B  #$6700,(A0)                     ; $2AD582
        ANDI.L  #$02B00410,-(A0)                ; $2AD586
        BVC.W  loc_2AD84E                       ; $2AD58C
        DC.W    $02D0               ; $2AD590 DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2AD592
        ANDI.W  #$0290,-(A0)                    ; $2AD596
        DC.W    $0010,$0300         ; $2AD59A ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2AD59E DC.W    $02E0
        DC.W    $02F0               ; $2AD5A0 DC.W    $02F0
        BTST    D1,D0                           ; $2AD5A2
        BTST    D1,(A0)                         ; $2AD5A4
        DC.W    $0210,$0500         ; $2AD5A6 ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2AD5AA
        SUBI.B  #$0400,(A0)                     ; $2AD5AE
        BTST    D1,D0                           ; $2AD5B2
        DC.W    $02F0               ; $2AD5B4 DC.W    $02F0
        DC.W    $0010,$6500         ; $2AD5B6 ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2AD5BA
        BCHG    D1,(A0)                         ; $2AD5BC
        BCHG    D1,-(A0)                        ; $2AD5BE
        BCHG    D1,$10(A0,D0.W)                 ; $2AD5C0
        BLS.W  loc_2AD956                       ; $2AD5C4
        BCLR    D1,D0                           ; $2AD5C8
        SUBI.B  #$6400,(A0)                     ; $2AD5CA
        BCHG    D1,-(A0)                        ; $2AD5CE
        BCHG    D1,(A0)                         ; $2AD5D0
        DC.W    $0010,$0300         ; $2AD5D2 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AD5D6
        BSET    D1,$00(A0,D0.W)                 ; $2AD5D8
        SUBI.B  #$0210,(A0)                     ; $2AD5DC
        BTST    D2,D0                           ; $2AD5E0
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AD5E2
        SUBI.B  #$0400,D0                       ; $2AD5E8
        BSET    D1,$10(A0,D0.W)                 ; $2AD5EC
        BCS.W  loc_2ADA32                       ; $2AD5F0
        SUBI.W  #$0460,(A0)                     ; $2AD5F4
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AD5F8
        SUBI.L  #$04800410,(A0)                 ; $2AD5FE
        BCC.W  loc_2ADA66                       ; $2AD604
        SUBI.W  #$0000,(A0)                     ; $2AD608
        BNE.W  loc_2AD9AE                       ; $2AD60C
        BCLR    D1,-$40(A0,D0.W)                ; $2AD610
        BSET    D1,(A0)                         ; $2AD614
        DC.W    $0000,$6600         ; $2AD616 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AD61A
        DC.W    $04D0               ; $2AD620 DC.W    $04D0
        CMPI.B  #$004E,D0                       ; $2AD622
        ORI.W  #$04F7,A6                        ; $2AD626
        BSET    D0,-$00B3(A2)                   ; $2AD62A
        BCHG    D2,$024E(A7)                    ; $2AD62E
        DC.W    $003F,$0681         ; $2AD632 ORI.B  #$0681,<EA:3F>
        BTST    D1,(A4)                         ; $2AD636
        MOVE.W  A1,-$0E(A7,D0.W)                ; $2AD638
        ANDI.L  #$FE6704EF,(A3)+                ; $2AD63C
        DC.W    $02E7               ; $2AD642 DC.W    $02E7
        DC.W    $003E,$05E4         ; $2AD644 ORI.B  #$05E4,<EA:3E>
        BSET    D1,(A0)                         ; $2AD648
        MOVE.W  A0,$78(A7,D0.W)                 ; $2AD64A
        ANDI.L  #$FF4C0556,D3                   ; $2AD64E
        BCHG    D1,(A0)+                        ; $2AD654
        MOVEA.W -(A5),A7                        ; $2AD656
        BCLR    D2,(A7)+                        ; $2AD658
        BCHG    D1,-(A4)                        ; $2AD65A
        MOVE.W  (A2)+,(A7)                      ; $2AD65C
        ADDI.B  #$02EF,-$0110(A0)               ; $2AD65E
        DC.W    $06D0               ; $2AD664 DC.W    $06D0
        BCHG    D1,-$019C(PC)                   ; $2AD666
        ADDI.B  #$03D2,-(A5)                    ; $2AD66A
        MOVE.W  $05E9(A2),D7                    ; $2AD66E
        BCLR    D1,-(A1)                        ; $2AD672
        MOVE.W  $066E(A7),-(A7)                 ; $2AD674
        SUBI.B  #$FEBF,(A0)                     ; $2AD678
        DC.W    $058A               ; $2AD67C BCLR    D2,A2
        DC.W    $030A               ; $2AD67E BTST    D1,A2
        MOVEA.W $052C(A2),A7                    ; $2AD680
        DC.W    $02D9               ; $2AD684 DC.W    $02D9
        MOVE.W  #$055C,D7                       ; $2AD686
        BCHG    D0,$FE55.W                      ; $2AD68A
        DC.W    $05BE               ; $2AD68E BCLR    D2,<EA:3E>
        DC.W    $018A               ; $2AD690 BCLR    D0,A2
        MOVE.W  D7,(A7)                         ; $2AD692
        BTST    D2,$0302(A6)                    ; $2AD694
        MOVE.W  $0562(A0),(A7)                  ; $2AD698
        BCLR    D0,D2                           ; $2AD69C
loc_2AD69E:
        MOVE.W  D4,(A7)+                        ; $2AD69E
        BCHG    D2,#$01B1                       ; $2AD6A0
        MOVE.W  (A0)+,(A7)                      ; $2AD6A4
        BCHG    D2,D5                           ; $2AD6A6
        BCLR    D0,D4                           ; $2AD6A8
        MOVEA.W $0643(A5),A7                    ; $2AD6AA
        DC.W    $00CA               ; $2AD6AE DC.W    $00CA
loc_2AD6B0:
        DC.W    $FDE4               ; $2AD6B0 MOVE.W  -(A4),<EA:3E>
        DC.W    $06B2,$00CE,$FDF1,$055C; $2AD6B2 ADDI.L  #$00CEFDF1,$5C(A2,D0.W)
        BCHG    D0,-$0147(A3)                   ; $2AD6BA
        ADDI.L  #$0089FE12,(A0)                 ; $2AD6BE
        DC.W    $058F               ; $2AD6C4 BCLR    D2,A7
        ANDI.W  #$0095,-(A0)                    ; $2AD6C6
        BCLR    D2,D7                           ; $2AD6CA
        DC.W    $02B5,$00DD,$0631,$0389; $2AD6CC ANDI.L  #$00DD0631,-$77(A5,D0.W)
        DC.W    $FFF8,$0649         ; $2AD6D4 MOVE.W  $0649.W,<EA:3F>
        BCHG    D1,D7                           ; $2AD6D8
        MOVE.W  (A3)+,$37(A7,D0.W)              ; $2AD6DA
        ANDI.L  #$009205F1,-(A3)                ; $2AD6DE
        DC.W    $038A               ; $2AD6E4 BCLR    D1,A2
        MOVE.W  (A0)+,-$45(A7,D0.W)             ; $2AD6E6
        DC.W    $0207,$0057         ; $2AD6EA ANDI.B  #$0057,D7
        ADDI.L  #$022E00B3,A1                   ; $2AD6EE
        BCHG    D2,(A6)                         ; $2AD6F4
        DC.W    $02BF,$00E2,$0546   ; $2AD6F6 ANDI.L  #$00E20546,<EA:3F>
        DC.W    $02B8,$0091,$06A6,$01C9; $2AD6FC ANDI.L  #$009106A6,$01C9.W
        ORI.L  #$0531027A,A4                    ; $2AD704
        DC.W    $00C6               ; $2AD70A DC.W    $00C6
        DC.W    $04AF,$00DC,$FF3A,$04C7; $2AD70C SUBI.L  #$00DCFF3A,$04C7(A7)
        DC.W    $00E7               ; $2AD714 DC.W    $00E7
        ORI.L  #$05460259,(A1)+                 ; $2AD716
        ORI.W  #$0533,-(A5)                     ; $2AD71C
        ANDI.W  #$FF45,(A0)                     ; $2AD720
        SUBI.B  #$0124,(A0)+                    ; $2AD724
        ORI.L  #$04980296,-(A3)                 ; $2AD728
        ORI.W  #$0400,$0119(A7)                 ; $2AD72E
        MOVE.W  D4,$0484(A7)                    ; $2AD734
        ANDI.L  #$FF4F0621,A6                   ; $2AD738
        DC.W    $00CC               ; $2AD73E DC.W    $00CC
        DC.W    $FFDE               ; $2AD740 MOVE.W  (A6)+,<EA:3F>
        BSET    D2,$003A(A4)                    ; $2AD742
        MOVE.W  (A3)+,$1E(A7,D0.W)              ; $2AD746
        DC.W    $00DE               ; $2AD74A DC.W    $00DE
        MOVE.W  -(A3),$53(A7,D0.W)              ; $2AD74C
        BCHG    D0,-$1B(A0,A7.L)                ; $2AD750
        ADDI.B  #$00C8,(A5)+                    ; $2AD754
        MOVE.W  A4,$044F(A7)                    ; $2AD758
        BCHG    D0,-$00AC(A4)                   ; $2AD75C
        BCLR    D2,(A1)+                        ; $2AD760
        MOVE.W  (A2),-$0015(A7)                 ; $2AD762
        BTST    D2,$77(PC,A7.L)                 ; $2AD766
        MOVE.W  -$1E(A4,D0.W),-$15(A7,D0.W)     ; $2AD76A
        MOVE.W  A7,$40(A7,D0.W)                 ; $2AD770
        DC.W    $00C6               ; $2AD774 DC.W    $00C6
        DC.W    $FFC6               ; $2AD776 MOVE.W  D6,<EA:3F>
        BCLR    D2,(A0)+                        ; $2AD778
        MOVE.W  A0,-$007B(A7)                   ; $2AD77A
        ADDI.W  #$00BC,D0                       ; $2AD77E
        MOVE.W  -(A0),$0647(A7)                 ; $2AD782
        MOVE.W  D3,-$0093(A7)                   ; $2AD786
        ADDI.W  #$FF08,D7                       ; $2AD78A
        MOVE.W  $0537(A5),-$00F8(A7)            ; $2AD78E
        DC.W    $FFC8               ; $2AD794 MOVE.W  A0,<EA:3F>
        BTST    D2,$65(A7,A7.L)                 ; $2AD796
        DC.W    $FFC8               ; $2AD79A MOVE.W  A0,<EA:3F>
        DC.W    $04C9               ; $2AD79C DC.W    $04C9
        BTST    D0,-$2C(A4,A7.L)                ; $2AD79E
        SUBI.W  #$01A5,$0034.W                  ; $2AD7A2
        BCHG    D1,D7                           ; $2AD7A8
        ORI.W  #$00D0,A1                        ; $2AD7AA
        BCLR    D1,(A0)+                        ; $2AD7AE
        DC.W    $FFD8               ; $2AD7B0 MOVE.W  (A0)+,<EA:3F>
        ORI.W  #$04FC,$43(A0,D0.W)              ; $2AD7B2
        ORI.W  #$03CB,(A2)+                     ; $2AD7B8
        DC.W    $FFE7               ; $2AD7BC MOVE.W  -(A7),<EA:3F>
        DC.W    $00F6               ; $2AD7BE DC.W    $00F6
        BCLR    D1,-(A7)                        ; $2AD7C0
        DC.W    $FFD0               ; $2AD7C2 MOVE.W  (A0),<EA:3F>
        ORI.L  #$03DA0034,D2                    ; $2AD7C4
        ORI.L  #$027100CB,(A2)+                 ; $2AD7CA
        BTST    D0,(A4)                         ; $2AD7D0
        DC.W    $023E,$0067         ; $2AD7D2 ANDI.B  #$0067,<EA:3E>
        DC.W    $00FB               ; $2AD7D6 DC.W    $00FB
        DC.W    $03CC               ; $2AD7D8 BSET    D1,A4
loc_2AD7DA:
        DC.W    $FFDB               ; $2AD7DA MOVE.W  (A3)+,<EA:3F>
        DC.W    $00E1               ; $2AD7DC DC.W    $00E1
        ANDI.W  #$0072,-(A3)                    ; $2AD7DE
        BCHG    D0,(A3)+                        ; $2AD7E2
        BSET    D0,D6                           ; $2AD7E4
        DC.W    $FFE6               ; $2AD7E6 MOVE.W  -(A6),<EA:3F>
        BTST    D0,-$6B(A6,D0.W)                ; $2AD7E8
        DC.W    $0006,$0132         ; $2AD7EC ORI.B  #$0132,D6
        DC.W    $0236,$00F2,$011E   ; $2AD7F0 ANDI.B  #$00F2,$1E(A6,D0.W)
        ANDI.L  #$00BF0124,D3                   ; $2AD7F6
        DC.W    $0010,$6E00         ; $2AD7FC ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2AD800 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AD804 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2AD808
        ORI.W  #$0050,D0                        ; $2AD80C
        SUBI.B  #$7000,(A0)                     ; $2AD810
        ORI.W  #$0070,-(A0)                     ; $2AD814
        SUBI.B  #$6F00,(A0)                     ; $2AD818
        DC.W    $0000,$0030         ; $2AD81C ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AD820 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AD824 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AD828 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AD82C
loc_2AD832:
        DC.W    $00B0,$0210,$0400,$00D0; $2AD832 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AD83A DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AD83C
        ORI.L  #$00900611,-(A0)                 ; $2AD840
        BTST    D3,D1                           ; $2AD846
        DC.W    $00B0,$0010,$6A00,$00E0; $2AD848 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AD850 DC.W    $00F0
        BTST    D0,D0                           ; $2AD852
        BTST    D0,(A0)                         ; $2AD854
        DC.W    $0210,$6C00         ; $2AD856 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AD85A
        SUBI.B  #$6B00,(A0)                     ; $2AD85E
        BTST    D0,D0                           ; $2AD862
        DC.W    $00F0               ; $2AD864 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AD866 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AD86A DC.W    $00E0
        DC.W    $0010,$6300         ; $2AD86C ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AD870
        BCHG    D0,(A0)                         ; $2AD872
        BCHG    D0,-(A0)                        ; $2AD874
        BCHG    D0,$10(A0,D0.W)                 ; $2AD876
        BCS.W  loc_2ADA0C                       ; $2AD87A
        BCLR    D0,D0                           ; $2AD87E
        SUBI.B  #$6400,(A0)                     ; $2AD880
        BCHG    D0,-(A0)                        ; $2AD884
        BCHG    D0,(A0)                         ; $2AD886
        ADDI.B  #$6201,(A1)                     ; $2AD888
        BCHG    D0,$10(A0,D0.W)                 ; $2AD88C
        BPL.W  loc_2ADA32                       ; $2AD890
        BCLR    D0,-$40(A0,D0.W)                ; $2AD894
        BSET    D0,(A0)                         ; $2AD898
        DC.W    $0210,$6C00         ; $2AD89A ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AD89E
        SUBI.B  #$6B00,(A0)                     ; $2AD8A2
        BSET    D0,D0                           ; $2AD8A6
        BCLR    D0,$11(A0,D0.W)                 ; $2AD8A8
        BVS.S  loc_2AD8AF                       ; $2AD8AC
        BSET    D0,(A0)                         ; $2AD8AE
        DC.W    $0010,$6300         ; $2AD8B0 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AD8B4 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AD8B8 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AD8BC ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AD8C0
        SUBI.B  #$6400,(A0)                     ; $2AD8C4
        DC.W    $0220,$0210         ; $2AD8C8 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AD8CC ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AD8D0 ANDI.B  #$0010,D0
        BNE.W  loc_2ADB36                       ; $2AD8D4
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2AD8D8
        ADDI.B  #$6700,(A0)                     ; $2AD8DE
        ANDI.L  #$02B00410,-(A0)                ; $2AD8E2
        BVC.W  loc_2ADBAA                       ; $2AD8E8
        DC.W    $02D0               ; $2AD8EC DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2AD8EE
        ANDI.W  #$0290,-(A0)                    ; $2AD8F2
        DC.W    $0010,$0300         ; $2AD8F6 ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2AD8FA DC.W    $02E0
        DC.W    $02F0               ; $2AD8FC DC.W    $02F0
        BTST    D1,D0                           ; $2AD8FE
        BTST    D1,(A0)                         ; $2AD900
        DC.W    $0210,$0500         ; $2AD902 ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2AD906
        SUBI.B  #$0400,(A0)                     ; $2AD90A
        BTST    D1,D0                           ; $2AD90E
        DC.W    $02F0               ; $2AD910 DC.W    $02F0
        DC.W    $0010,$6500         ; $2AD912 ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2AD916
        BCHG    D1,(A0)                         ; $2AD918
        BCHG    D1,-(A0)                        ; $2AD91A
        BCHG    D1,$10(A0,D0.W)                 ; $2AD91C
        BLS.W  loc_2ADCB2                       ; $2AD920
        BCLR    D1,D0                           ; $2AD924
        SUBI.B  #$6400,(A0)                     ; $2AD926
        BCHG    D1,-(A0)                        ; $2AD92A
        BCHG    D1,(A0)                         ; $2AD92C
        DC.W    $0010,$0300         ; $2AD92E ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AD932
        BSET    D1,$00(A0,D0.W)                 ; $2AD934
        SUBI.B  #$0210,(A0)                     ; $2AD938
        BTST    D2,D0                           ; $2AD93C
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AD93E
        SUBI.B  #$0400,D0                       ; $2AD944
        BSET    D1,$10(A0,D0.W)                 ; $2AD948
        BCS.W  loc_2ADD8E                       ; $2AD94C
        SUBI.W  #$0460,(A0)                     ; $2AD950
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AD954
        SUBI.L  #$04800410,(A0)                 ; $2AD95A
        BCC.W  loc_2ADDC2                       ; $2AD960
        SUBI.W  #$0000,(A0)                     ; $2AD964
        BNE.W  loc_2ADD0A                       ; $2AD968
        BCLR    D1,-$40(A0,D0.W)                ; $2AD96C
        BSET    D1,(A0)                         ; $2AD970
        DC.W    $0000,$6600         ; $2AD972 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AD976
        DC.W    $04D0               ; $2AD97C DC.W    $04D0
        CMPI.B  #$0052,D0                       ; $2AD97E
        ORI.W  #$04C4,(A2)                      ; $2AD982
        BSET    D0,$55(A2,A7.L)                 ; $2AD986
        BTST    D2,-(A5)                        ; $2AD98A
        ANDI.W  #$0058,D2                       ; $2AD98C
        ADDI.W  #$030E,A2                       ; $2AD990
        DC.W    $FFCB               ; $2AD994 MOVE.W  A3,<EA:3F>
        BSET    D2,(A7)                         ; $2AD996
        DC.W    $02AE,$FE94,$04A9,$02DE; $2AD998 ANDI.L  #$FE9404A9,$02DE(A6)
        ORI.W  #$05B2,(A6)                      ; $2AD9A0
        DC.W    $03CD               ; $2AD9A4 BSET    D1,A5
        DC.W    $FFC9               ; $2AD9A6 MOVE.W  A1,<EA:3F>
        SUBI.W  #$028E,A0                       ; $2AD9A8
        MOVE.W  (A3),$053D(A7)                  ; $2AD9AC
        BCHG    D1,-$016E(A5)                   ; $2AD9B0
        BCLR    D2,D3                           ; $2AD9B4
        BCHG    D1,-$32(A4,A7.L)                ; $2AD9B6
        ADDI.B  #$02F6,D1                       ; $2AD9BA
        MOVE.W  $06B8(A0),-(A7)                 ; $2AD9BE
        DC.W    $0388               ; $2AD9C2 BCLR    D1,A0
        MOVE.W  $14(A7,D0.W),(A7)               ; $2AD9C4
        BSET    D1,-(A7)                        ; $2AD9C8
        MOVEA.W -$41(A4,D0.W),A7                ; $2AD9CA
        BCLR    D1,-(A5)                        ; $2AD9CE
        MOVE.W  $0650(A6),$0418(A7)             ; $2AD9D0
        MOVE.W  (A4),-(A7)                      ; $2AD9D6
        DC.W    $0589               ; $2AD9D8 BCLR    D2,A1
        BTST    D1,D5                           ; $2AD9DA
        MOVE.W  A2,(A7)                         ; $2AD9DC
        BTST    D2,$02EC(A0)                    ; $2AD9DE
        MOVEA.W A7,A7                           ; $2AD9E2
        DC.W    $04C7               ; $2AD9E4 DC.W    $04C7
        BCLR    D0,-(A5)                        ; $2AD9E6
        MOVE.W  $1F(A7,D0.W),(A7)               ; $2AD9E8
        BCLR    D0,-(A0)                        ; $2AD9EC
        MOVE.W  $0528(PC),(A7)+                 ; $2AD9EE
        BTST    D1,-$0151(A6)                   ; $2AD9F2
        DC.W    $04BF,$01C9,$FF1F   ; $2AD9F6 SUBI.L  #$01C9FF1F,<EA:3F>
        DC.W    $04B5,$01D1,$FF11,$049D; $2AD9FC SUBI.L  #$01D1FF11,-$63(A5,D0.W)
        BCLR    D0,(A5)+                        ; $2ADA04
        MOVE.W  (A5),(A7)+                      ; $2ADA06
        BSET    D2,(A2)                         ; $2ADA08
        BCLR    D0,$43(A7,A7.L)                 ; $2ADA0A
        ADDI.B  #$01F2,-$01A1(A5)               ; $2ADA0E
        DC.W    $04C0               ; $2ADA14 DC.W    $04C0
        BCLR    D0,D0                           ; $2ADA16
        MOVE.W  (A2)+,-(A7)                     ; $2ADA18
        ADDI.B  #$019F,$FE69.W                  ; $2ADA1A
        BCLR    D2,(A1)+                        ; $2ADA20
        DC.W    $014B               ; $2ADA22 BCHG    D0,A3
        MOVE.W  (A3)+,(A7)+                     ; $2ADA24
        DC.W    $06F1               ; $2ADA26 DC.W    $06F1
        DC.W    $02C8               ; $2ADA28 DC.W    $02C8
        DC.W    $FDF8,$06AF         ; $2ADA2A MOVE.W  $06AF.W,<EA:3E>
        BCHG    D0,$53(A6,A7.L)                 ; $2ADA2E
loc_2ADA32:
        BSET    D2,-$71(A1,D0.W)                ; $2ADA32
        MOVE.W  (A4),(A7)+                      ; $2ADA36
        BCLR    D2,(A0)                         ; $2ADA38
        DC.W    $0228,$00A2,$0575   ; $2ADA3A ANDI.B  #$00A2,$0575(A0)
        ANDI.W  #$00F6,$05E8(A4)                ; $2ADA40
        BCLR    D1,D4                           ; $2ADA46
        DC.W    $003B,$060D,$035A   ; $2ADA48 ORI.B  #$060D,$5A(PC,D0.W)
        DC.W    $FFD7               ; $2ADA4E MOVE.W  (A7),<EA:3F>
        BTST    D2,$0256(A3)                    ; $2ADA50
        ORI.L  #$05A70387,-(A7)                 ; $2ADA54
        DC.W    $FFDC               ; $2ADA5A MOVE.W  (A4)+,<EA:3F>
        DC.W    $06C7               ; $2ADA5C DC.W    $06C7
        DC.W    $021A,$0060         ; $2ADA5E ANDI.B  #$0060,(A2)+
        ADDI.L  #$022600BF,A6                   ; $2ADA62
        BCHG    D2,D3                           ; $2ADA68
        ANDI.W  #$00FB,$0535(A2)                ; $2ADA6A
        ANDI.W  #$00A9,$06C0(A5)                ; $2ADA70
        BSET    D0,(A2)                         ; $2ADA76
        ORI.L  #$052E0224,A2                    ; $2ADA78
        DC.W    $00D3               ; $2ADA7E DC.W    $00D3
        SUBI.W  #$00DA,$48(A0,A7.L)             ; $2ADA80
        SUBI.L  #$00E700A7,A0                   ; $2ADA86
        BTST    D2,D7                           ; $2ADA8C
        ANDI.W  #$0071,(A1)+                    ; $2ADA8E
        DC.W    $04F3               ; $2ADA92 DC.W    $04F3
        ANDI.W  #$FF50,A5                       ; $2ADA94
        BSET    D1,(A2)+                        ; $2ADA98
        BTST    D0,-(A4)                        ; $2ADA9A
        DC.W    $00B1,$0459,$0296,$007A; $2ADA9C ORI.L  #$04590296,$7A(A1,D0.W)
        BSET    D1,D2                           ; $2ADAA4
        BTST    D0,(A6)                         ; $2ADAA6
        MOVE.W  (A1),$0445(A7)                  ; $2ADAA8
        ANDI.L  #$FF5A05E5,A3                   ; $2ADAAC
        DC.W    $00D8               ; $2ADAB2 DC.W    $00D8
        DC.W    $FFEE,$05B4         ; $2ADAB4 MOVE.W  $05B4(A6),<EA:3F>
        ORI.W  #$FFAC,D2                        ; $2ADAB8
        BSET    D1,-(A3)                        ; $2ADABC
        DC.W    $00D9               ; $2ADABE DC.W    $00D9
        MOVE.W  $13(A0,D0.W),$6D(A7,D0.W)       ; $2ADAC0
        DC.W    $FFF2,$05E2         ; $2ADAC6 MOVE.W  -$1E(A2,D0.W),<EA:3F>
        DC.W    $00D1               ; $2ADACA DC.W    $00D1
        MOVE.W  (A5)+,$0410(A7)                 ; $2ADACC
        BCHG    D0,-$009F(A0)                   ; $2ADAD0
        DC.W    $058B               ; $2ADAD4 BCLR    D2,A3
        MOVE.W  A7,-$0004(A7)                   ; $2ADAD6
        BTST    D2,-$0099(A0)                   ; $2ADADA
        DC.W    $FFC5               ; $2ADADE MOVE.W  D5,<EA:3F>
        BCLR    D2,(A4)+                        ; $2ADAE0
        DC.W    $00EE               ; $2ADAE2 DC.W    $00EE
        MOVE.W  (A7)+,-$02(A7,D0.W)             ; $2ADAE4
        DC.W    $00D7               ; $2ADAE8 DC.W    $00D7
        DC.W    $FFD7               ; $2ADAEA MOVE.W  (A7),<EA:3F>
        DC.W    $058C               ; $2ADAEC BCLR    D2,A4
        MOVE.W  D5,-$006A(A7)                   ; $2ADAEE
        ADDI.B  #$00CC,D0                       ; $2ADAF2
        MOVE.W  $3A(A0,D0.W),-$00C5(A7)         ; $2ADAF6
        MOVE.W  D0,$3A(A7,D0.W)                 ; $2ADAFC
        DC.W    $FEFF               ; $2ADB00 MOVE.W  <EA:3F>,(A7)+
        MOVE.W  D0,$29(A7,D0.W)                 ; $2ADB02
        DC.W    $FEFF               ; $2ADB06 MOVE.W  <EA:3F>,(A7)+
        DC.W    $FFDA               ; $2ADB08 MOVE.W  (A2)+,<EA:3F>
        BTST    D2,-$00A3(A1)                   ; $2ADB0A
        DC.W    $FFDA               ; $2ADB0E MOVE.W  (A2)+,<EA:3F>
        SUBI.L  #$0132FFE3,A5                   ; $2ADB10
        SUBI.B  #$01A5,$0040(PC)                ; $2ADB16
        BTST    D1,D4                           ; $2ADB1C
        ORI.W  #$00D7,A2                        ; $2ADB1E
        BCHG    D1,(A6)                         ; $2ADB22
        DC.W    $FFD9               ; $2ADB24 MOVE.W  (A1)+,<EA:3F>
        ORI.W  #$04BD,$0142.W                   ; $2ADB26
        ORI.W  #$0387,-$0018(A2)                ; $2ADB2C
        BTST    D0,D1                           ; $2ADB32
        BCHG    D1,-(A6)                        ; $2ADB34
loc_2ADB36:
        DC.W    $FFD1               ; $2ADB36 MOVE.W  (A1),<EA:3F>
        ORI.L  #$03970035,A2                    ; $2ADB38
        ORI.L  #$022B00CB,-(A4)                 ; $2ADB3E
        BTST    D0,(A5)                         ; $2ADB44
        BSET    D0,$006600FB                    ; $2ADB46
        DC.W    $0388               ; $2ADB4C BCLR    D1,A0
        DC.W    $FFDD               ; $2ADB4E MOVE.W  (A5)+,<EA:3F>
        DC.W    $00EA               ; $2ADB50 DC.W    $00EA
        DC.W    $021B,$0071         ; $2ADB52 ANDI.B  #$0071,(A3)+
        BCHG    D0,(A4)+                        ; $2ADB56
        BCLR    D0,D0                           ; $2ADB58
        DC.W    $FFE5               ; $2ADB5A MOVE.W  -(A5),<EA:3F>
        BTST    D0,-(A7)                        ; $2ADB5C
        DC.W    $014E               ; $2ADB5E BCHG    D0,A6
        DC.W    $0005,$0127         ; $2ADB60 ORI.B  #$0127,D5
        BSET    D0,$00F2(A7)                    ; $2ADB64
        BTST    D0,-(A7)                        ; $2ADB68
        DC.W    $023C,$00BE,$0127   ; $2ADB6A ANDI.B  #$00BE,#$0127
        DC.W    $0010,$6E00         ; $2ADB70 ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2ADB74 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2ADB78 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2ADB7C
        ORI.W  #$0050,D0                        ; $2ADB80
        SUBI.B  #$7000,(A0)                     ; $2ADB84
        ORI.W  #$0070,-(A0)                     ; $2ADB88
        SUBI.B  #$6F00,(A0)                     ; $2ADB8C
        DC.W    $0000,$0030         ; $2ADB90 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2ADB94 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2ADB98 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2ADB9C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2ADBA0
        DC.W    $00B0,$0210,$0400,$00D0; $2ADBA6 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2ADBAE DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2ADBB0
        ORI.L  #$00900611,-(A0)                 ; $2ADBB4
        BTST    D3,D1                           ; $2ADBBA
        DC.W    $00B0,$0010,$6A00,$00E0; $2ADBBC ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2ADBC4 DC.W    $00F0
        BTST    D0,D0                           ; $2ADBC6
        BTST    D0,(A0)                         ; $2ADBC8
        DC.W    $0210,$6C00         ; $2ADBCA ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2ADBCE
        SUBI.B  #$6B00,(A0)                     ; $2ADBD2
        BTST    D0,D0                           ; $2ADBD6
        DC.W    $00F0               ; $2ADBD8 DC.W    $00F0
        DC.W    $0211,$6901         ; $2ADBDA ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2ADBDE DC.W    $00E0
        DC.W    $0010,$6300         ; $2ADBE0 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2ADBE4
        BCHG    D0,(A0)                         ; $2ADBE6
        BCHG    D0,-(A0)                        ; $2ADBE8
        BCHG    D0,$10(A0,D0.W)                 ; $2ADBEA
        BCS.W  loc_2ADD80                       ; $2ADBEE
        BCLR    D0,D0                           ; $2ADBF2
        SUBI.B  #$6400,(A0)                     ; $2ADBF4
        BCHG    D0,-(A0)                        ; $2ADBF8
        BCHG    D0,(A0)                         ; $2ADBFA
        ADDI.B  #$6201,(A1)                     ; $2ADBFC
        BCHG    D0,$10(A0,D0.W)                 ; $2ADC00
        BPL.W  loc_2ADDE6                       ; $2ADC04
        BSET    D0,$00(A0,D0.W)                 ; $2ADC08
        DC.W    $0210,$0210         ; $2ADC0C ANDI.B  #$0210,(A0)
        BGE.W  loc_2ADE42                       ; $2ADC10
        DC.W    $0220,$0410         ; $2ADC14 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2ADE1A                       ; $2ADC18
        BSET    D0,$11(A0,D0.W)                 ; $2ADC1C
        BVS.S  loc_2ADC23                       ; $2ADC20
        DC.W    $0210,$0010         ; $2ADC22 ANDI.B  #$0010,(A0)
        BLS.W  loc_2ADE68                       ; $2ADC26
        ANDI.W  #$0260,(A0)                     ; $2ADC2A
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2ADC2E
        ANDI.L  #$02800410,(A0)                 ; $2ADC34
        BCC.W  loc_2ADE9C                       ; $2ADC3A
        ANDI.W  #$0211,(A0)                     ; $2ADC3E
        BHI.S  loc_2ADC45                       ; $2ADC42
        ANDI.W  #$0010,D0                       ; $2ADC44
        BNE.W  loc_2ADEEA                       ; $2ADC48
        DC.W    $02B0,$02C0,$02D0,$0610; $2ADC4C ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2ADF36                       ; $2ADC54
        DC.W    $02F0               ; $2ADC58 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2ADC5A
        BTST    D1,D0                           ; $2ADC5E
        BTST    D1,(A0)                         ; $2ADC60
        SUBI.B  #$6700,(A0)                     ; $2ADC62
        ANDI.L  #$02D00010,-(A0)                ; $2ADC66
        BTST    D1,D0                           ; $2ADC6C
        BTST    D1,-(A0)                        ; $2ADC6E
        BTST    D1,$40(A0,D0.W)                 ; $2ADC70
        BCHG    D1,(A0)                         ; $2ADC74
        DC.W    $0210,$0500         ; $2ADC76 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2ADC7A
        SUBI.B  #$0400,(A0)                     ; $2ADC7E
        BCHG    D1,D0                           ; $2ADC82
        BTST    D1,$10(A0,D0.W)                 ; $2ADC84
        BCS.W  loc_2AE00A                       ; $2ADC88
        BCLR    D1,(A0)                         ; $2ADC8C
        BCLR    D1,-(A0)                        ; $2ADC8E
        BCLR    D1,$10(A0,D0.W)                 ; $2ADC90
        BLS.W  loc_2AE066                       ; $2ADC94
        BSET    D1,D0                           ; $2ADC98
        SUBI.B  #$6400,(A0)                     ; $2ADC9A
        BCLR    D1,-(A0)                        ; $2ADC9E
        BCLR    D1,(A0)                         ; $2ADCA0
        DC.W    $0010,$0300         ; $2ADCA2 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2ADCA6
        SUBI.W  #$0450,D0                       ; $2ADCAA
        DC.W    $0210,$0500         ; $2ADCAE ANDI.B  #$0500,(A0)
loc_2ADCB2:
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2ADCB2
        SUBI.B  #$0440,D0                       ; $2ADCB8
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2ADCBC
        SUBI.L  #$049004A0,D0                   ; $2ADCC2
        DC.W    $04B0,$0210,$6300,$04D0; $2ADCC8 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2ADCD0 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2ADCD2
        SUBI.L  #$04900000,-(A0)                ; $2ADCD6
        BVS.W  loc_2ADE7E                       ; $2ADCDC
        BCLR    D0,-$40(A0,D0.W)                ; $2ADCE0
        BSET    D0,(A0)                         ; $2ADCE4
        DC.W    $0000,$6600         ; $2ADCE6 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2ADCEA
        BSET    D1,$00(A0,D0.W)                 ; $2ADCEC
        SUBI.B  #$0000,(A0)                     ; $2ADCF0
        BNE.W  loc_2AE1D6                       ; $2ADCF4
        DC.W    $04F0               ; $2ADCF8 DC.W    $04F0
        BTST    D2,D0                           ; $2ADCFA
        BTST    D2,(A0)                         ; $2ADCFC
        CMPI.B  #$0052,D0                       ; $2ADCFE
        ORI.W  #$04BC,(A2)                      ; $2ADD02
        DC.W    $0236,$FFA0,$04A3   ; $2ADD06 ANDI.B  #$FFA0,-$5D(A6,D0.W)
        DC.W    $0210,$00BC         ; $2ADD0C ANDI.B  #$00BC,(A0)
        BCLR    D2,$0316(A7)                    ; $2ADD10
        BTST    D0,(A3)                         ; $2ADD14
        DC.W    $05CC               ; $2ADD16 BSET    D2,A4
        BCHG    D1,D4                           ; $2ADD18
        DC.W    $FFBF,$040F         ; $2ADD1A MOVE.W  <EA:3F>,$0F(A7,D0.W)
        ANDI.L  #$00C104F7,(A5)                 ; $2ADD1E
        BCLR    D1,$0119(PC)                    ; $2ADD24
        SUBI.B  #$02BB,-(A7)                    ; $2ADD28
        MOVE.W  -(A5),$15(A7,D0.W)              ; $2ADD2C
        BSET    D1,-(A7)                        ; $2ADD30
        DC.W    $FFC5               ; $2ADD32 MOVE.W  D5,<EA:3F>
        DC.W    $053D               ; $2ADD34 BTST    D2,<EA:3D>
        BSET    D1,(A7)                         ; $2ADD36
        DC.W    $0015,$05AC         ; $2ADD38 ORI.B  #$05AC,(A5)
        BCHG    D1,D5                           ; $2ADD3C
        ORI.W  #$0657,-(A6)                     ; $2ADD3E
        SUBI.B  #$008E,D4                       ; $2ADD42
        BSET    D2,D5                           ; $2ADD46
        SUBI.W  #$0036,$052E(A6)                ; $2ADD48
        DC.W    $03BF               ; $2ADD4E BCLR    D1,<EA:3F>
        DC.W    $00C4               ; $2ADD50 DC.W    $00C4
        BCLR    D2,$57(A6,D0.W)                 ; $2ADD52
        DC.W    $00E5               ; $2ADD56 DC.W    $00E5
        DC.W    $0589               ; $2ADD58 BCLR    D2,A1
        BCHG    D1,#$FFAF                       ; $2ADD5A
        BCHG    D2,(A4)                         ; $2ADD5E
        BCHG    D1,-$00B9(PC)                   ; $2ADD60
        SUBI.W  #$0276,-(A2)                    ; $2ADD64
        MOVE.W  (A2)+,$0480(A7)                 ; $2ADD68
        ANDI.W  #$FFC2,-(A2)                    ; $2ADD6C
        BTST    D2,$03C6FF9A                    ; $2ADD70
        SUBI.B  #$02AC,-$52(A0,A7.L)            ; $2ADD76
        SUBI.W  #$02B8,D2                       ; $2ADD7C
loc_2ADD80:
        MOVE.W  (A5)+,$34(A7,D0.W)              ; $2ADD80
        ANDI.L  #$FF5B0557,A1                   ; $2ADD84
        BSET    D0,(A5)+                        ; $2ADD8A
        MOVE.W  (A5),-$5D(A7,D0.W)              ; $2ADD8C
        BSET    D0,-(A7)                        ; $2ADD90
        DC.W    $FFE4               ; $2ADD92 MOVE.W  -(A4),<EA:3F>
        SUBI.B  #$0271,(A7)                     ; $2ADD94
        MOVE.W  -(A4),$78(A7,D0.W)              ; $2ADD98
        BCLR    D0,(A7)+                        ; $2ADD9C
        DC.W    $FFEC,$04A7         ; $2ADD9E MOVE.W  $04A7(A4),<EA:3F>
        DC.W    $01C8               ; $2ADDA2 BSET    D0,A0
        DC.W    $FFE7               ; $2ADDA4 MOVE.W  -(A7),<EA:3F>
        DC.W    $06D0               ; $2ADDA6 DC.W    $06D0
        DC.W    $0219,$0011         ; $2ADDA8 ANDI.B  #$0011,(A1)+
        BCLR    D2,$013C0019                    ; $2ADDAC
        SUBI.W  #$0100,$0003(PC)                ; $2ADDB2
        DC.W    $05CE               ; $2ADDB8 BSET    D2,A6
        DC.W    $022D,$00FD,$0596   ; $2ADDBA ANDI.B  #$00FD,$0596(A5)
        DC.W    $0206,$0156         ; $2ADDC0 ANDI.B  #$0156,D6
        DC.W    $04F1               ; $2ADDC4 DC.W    $04F1
        BCHG    D1,D0                           ; $2ADDC6
        BCHG    D0,$1B(A5,D0.W)                 ; $2ADDC8
        BCLR    D1,D4                           ; $2ADDCC
        BTST    D0,-(A1)                        ; $2ADDCE
        BCHG    D2,$01FA(A4)                    ; $2ADDD0
        DC.W    $00EF               ; $2ADDD4 DC.W    $00EF
        DC.W    $04B9,$0351,$0112,$0710,$019B; $2ADDD6 SUBI.L  #$03510112,$0710019B
        BTST    D0,(A1)                         ; $2ADDE0
        DC.W    $06B6,$0188,$014F,$057A; $2ADDE2 ADDI.L  #$0188014F,$7A(A6,D0.W)
        DC.W    $020D,$014B         ; $2ADDEA ANDI.B  #$014B,A5
        BCLR    D2,(A0)                         ; $2ADDEE
        DC.W    $023D,$010B         ; $2ADDF0 ANDI.B  #$010B,<EA:3D>
        DC.W    $06F0               ; $2ADDF4 DC.W    $06F0
        DC.W    $014E               ; $2ADDF6 BCHG    D0,A6
        BTST    D0,D4                           ; $2ADDF8
        BCHG    D2,-$0F(A0,D0.W)                ; $2ADDFA
        DC.W    $00FD               ; $2ADDFE DC.W    $00FD
        SUBI.B  #$00CE,-(A3)                    ; $2ADE00
        MOVE.W  A4,$37(A7,D0.W)                 ; $2ADE04
        DC.W    $00DE               ; $2ADE08 DC.W    $00DE
        DC.W    $00EB               ; $2ADE0A DC.W    $00EB
        DC.W    $04B6,$0250,$00B5,$04A6; $2ADE0C SUBI.L  #$025000B5,-$5A(A6,D0.W)
        ANDI.W  #$FF94,D3                       ; $2ADE14
        DC.W    $0389               ; $2ADE18 BCLR    D1,A1
loc_2ADE1A:
        BTST    D0,(A3)+                        ; $2ADE1A
        DC.W    $00F2               ; $2ADE1C DC.W    $00F2
        SUBI.B  #$028D,A0                       ; $2ADE1E
        DC.W    $00BC,$0375,$010C,$FF93,$03F7; $2ADE22 ORI.L  #$0375010C,#$FF9303F7
        ANDI.L  #$FF9B059C,D1                   ; $2ADE2C
        DC.W    $00DA               ; $2ADE32 DC.W    $00DA
        DC.W    $001A,$056E         ; $2ADE34 ORI.B  #$056E,(A2)+
        ORI.W  #$FFD0,A0                        ; $2ADE38
        BCLR    D1,(A0)+                        ; $2ADE3C
        DC.W    $00CA               ; $2ADE3E DC.W    $00CA
        DC.W    $FFF1,$03C5         ; $2ADE40 MOVE.W  -$3B(A1,D0.W),<EA:3F>
        BCHG    D0,(A4)+                        ; $2ADE44
        DC.W    $003B,$0593,$00DF   ; $2ADE46 ORI.B  #$0593,-$21(PC,D0.W)
        MOVE.W  A3,-$44(A7,D0.W)                ; $2ADE4C
        BCHG    D0,-(A1)                        ; $2ADE50
        MOVE.W  $057E(A4),$4B(A7,A7.L)          ; $2ADE52
        DC.W    $000C,$0517         ; $2ADE58 ORI.B  #$0517,A4
        MOVE.W  (A5),-$0024(A7)                 ; $2ADE5C
        BCHG    D2,D5                           ; $2ADE60
        DC.W    $00EC               ; $2ADE62 DC.W    $00EC
        DC.W    $FFD2               ; $2ADE64 MOVE.W  (A2),<EA:3F>
        BCLR    D2,$00E2(A5)                    ; $2ADE66
        DC.W    $0002,$057B         ; $2ADE6A ORI.B  #$057B,D2
        MOVE.W  A0,-$005B(A7)                   ; $2ADE6E
        BCLR    D2,$00DF(A1)                    ; $2ADE72
        MOVE.W  (A4)+,$2C(A7,D0.W)              ; $2ADE76
        MOVE.W  -$6E(A3,A7.L),-(A7)             ; $2ADE7A
loc_2ADE7E:
        ADDI.B  #$FEF7,-$006E(A4)               ; $2ADE7E
        BTST    D2,(A3)+                        ; $2ADE84
        MOVE.W  -$14(A7,A7.L),(A7)+             ; $2ADE86
        BTST    D2,(A3)+                        ; $2ADE8A
        MOVE.W  (A3),-$0014(A7)                 ; $2ADE8C
        SUBI.W  #$0130,D5                       ; $2ADE90
        DC.W    $002B,$03E5,$019A   ; $2ADE94 ORI.B  #$03E5,$019A(A3)
        ORI.L  #$02B4002C,D5                    ; $2ADE9A
        DC.W    $00F3               ; $2ADEA0 DC.W    $00F3
        BTST    D1,(A5)                         ; $2ADEA2
        DC.W    $FFC1               ; $2ADEA4 MOVE.W  D1,<EA:3F>
        ORI.L  #$0468013C,(A1)+                 ; $2ADEA6
        DC.W    $00B7,$0338,$FFCE,$0125; $2ADEAC ORI.L  #$0338FFCE,$25(A7,D0.W)
        BTST    D1,(A4)+                        ; $2ADEB4
        MOVE.W  -$51(A4,D0.W),$52(A7,D0.W)      ; $2ADEB6
        DC.W    $0013,$00CD         ; $2ADEBC ORI.B  #$00CD,(A3)
        BSET    D0,$00C8(A2)                    ; $2ADEC0
        BTST    D0,(A0)+                        ; $2ADEC4
        BCLR    D0,$67(A3,D0.W)                 ; $2ADEC6
        DC.W    $00F9               ; $2ADECA DC.W    $00F9
        BTST    D1,-$43(A5,A7.L)                ; $2ADECC
        BTST    D0,(A2)                         ; $2ADED0
        DC.W    $01CC               ; $2ADED2 BSET    D0,A4
        ORI.W  #$015D,$39(A0,D0.W)              ; $2ADED4
        DC.W    $FFE4               ; $2ADEDA MOVE.W  -(A4),<EA:3F>
        BTST    D0,-(A7)                        ; $2ADEDC
        DC.W    $0108               ; $2ADEDE BTST    D0,A0
        DC.W    $0005,$0127         ; $2ADEE0 ORI.B  #$0127,D5
        BCLR    D0,$00F2(A0)                    ; $2ADEE4
        BTST    D0,-(A7)                        ; $2ADEE8
loc_2ADEEA:
        BSET    D0,-$42(A5,D0.W)                ; $2ADEEA
        BTST    D0,-(A7)                        ; $2ADEEE
        DC.W    $0010,$6E00         ; $2ADEF0 ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2ADEF4 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2ADEF8 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2ADEFC
        ORI.W  #$0050,D0                        ; $2ADF00
        SUBI.B  #$7000,(A0)                     ; $2ADF04
        ORI.W  #$0070,-(A0)                     ; $2ADF08
        SUBI.B  #$6F00,(A0)                     ; $2ADF0C
        DC.W    $0000,$0030         ; $2ADF10 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2ADF14 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2ADF18 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2ADF1C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2ADF20
        DC.W    $00B0,$0210,$0400,$00D0; $2ADF26 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2ADF2E DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2ADF30
        ORI.L  #$00900611,-(A0)                 ; $2ADF34
        BTST    D3,D1                           ; $2ADF3A
        DC.W    $00B0,$0010,$6A00,$00E0; $2ADF3C ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2ADF44 DC.W    $00F0
        BTST    D0,D0                           ; $2ADF46
        BTST    D0,(A0)                         ; $2ADF48
        DC.W    $0210,$6C00         ; $2ADF4A ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2ADF4E
        SUBI.B  #$6B00,(A0)                     ; $2ADF52
        BTST    D0,D0                           ; $2ADF56
        DC.W    $00F0               ; $2ADF58 DC.W    $00F0
        DC.W    $0211,$6901         ; $2ADF5A ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2ADF5E DC.W    $00E0
        DC.W    $0010,$6300         ; $2ADF60 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2ADF64
        BCHG    D0,(A0)                         ; $2ADF66
        BCHG    D0,-(A0)                        ; $2ADF68
        BCHG    D0,$10(A0,D0.W)                 ; $2ADF6A
        BCS.W  loc_2AE100                       ; $2ADF6E
        BCLR    D0,D0                           ; $2ADF72
        SUBI.B  #$6400,(A0)                     ; $2ADF74
        BCHG    D0,-(A0)                        ; $2ADF78
        BCHG    D0,(A0)                         ; $2ADF7A
        ADDI.B  #$6201,(A1)                     ; $2ADF7C
        BCHG    D0,$10(A0,D0.W)                 ; $2ADF80
        BPL.W  loc_2AE166                       ; $2ADF84
        BSET    D0,$00(A0,D0.W)                 ; $2ADF88
        DC.W    $0210,$0210         ; $2ADF8C ANDI.B  #$0210,(A0)
        BGE.W  loc_2AE1C2                       ; $2ADF90
        DC.W    $0220,$0410         ; $2ADF94 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2AE19A                       ; $2ADF98
        BSET    D0,$11(A0,D0.W)                 ; $2ADF9C
        BVS.S  loc_2ADFA3                       ; $2ADFA0
        DC.W    $0210,$0010         ; $2ADFA2 ANDI.B  #$0010,(A0)
        BLS.W  loc_2AE1E8                       ; $2ADFA6
        ANDI.W  #$0260,(A0)                     ; $2ADFAA
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2ADFAE
        ANDI.L  #$02800410,(A0)                 ; $2ADFB4
        BCC.W  $2AE21C                          ; $2ADFBA
        ANDI.W  #$0211,(A0)                     ; $2ADFBE
        BHI.S  loc_2ADFC5                       ; $2ADFC2
        ANDI.W  #$0010,D0                       ; $2ADFC4
        BNE.W  $2AE26A                          ; $2ADFC8
        DC.W    $02B0,$02C0,$02D0,$0610; $2ADFCC ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  $2AE2B6                          ; $2ADFD4
        DC.W    $02F0               ; $2ADFD8 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2ADFDA
        BTST    D1,D0                           ; $2ADFDE
        BTST    D1,(A0)                         ; $2ADFE0
        SUBI.B  #$6700,(A0)                     ; $2ADFE2
        ANDI.L  #$02D00010,-(A0)                ; $2ADFE6
        BTST    D1,D0                           ; $2ADFEC
        BTST    D1,-(A0)                        ; $2ADFEE
        BTST    D1,$40(A0,D0.W)                 ; $2ADFF0
        BCHG    D1,(A0)                         ; $2ADFF4
        DC.W    $0210,$0500         ; $2ADFF6 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2ADFFA
        SUBI.B  #$0400,(A0)                     ; $2ADFFE
        BCHG    D1,D0                           ; $2AE002
        BTST    D1,$10(A0,D0.W)                 ; $2AE004
        BCS.W  $2AE38A                          ; $2AE008
        BCLR    D1,(A0)                         ; $2AE00C
        BCLR    D1,-(A0)                        ; $2AE00E
        BCLR    D1,$10(A0,D0.W)                 ; $2AE010
        BLS.W  $2AE3E6                          ; $2AE014
        BSET    D1,D0                           ; $2AE018
        SUBI.B  #$6400,(A0)                     ; $2AE01A
        BCLR    D1,-(A0)                        ; $2AE01E
        BCLR    D1,(A0)                         ; $2AE020
        DC.W    $0010,$0300         ; $2AE022 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2AE026
        SUBI.W  #$0450,D0                       ; $2AE02A
        DC.W    $0210,$0500         ; $2AE02E ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2AE032
        SUBI.B  #$0440,D0                       ; $2AE038
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2AE03C
        SUBI.L  #$049004A0,D0                   ; $2AE042
        DC.W    $04B0,$0210,$6300,$04D0; $2AE048 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2AE050 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2AE052
        SUBI.L  #$04900000,-(A0)                ; $2AE056
        BVS.W  loc_2AE1FE                       ; $2AE05C
        BCLR    D0,-$40(A0,D0.W)                ; $2AE060
        BSET    D0,(A0)                         ; $2AE064
loc_2AE066:
        DC.W    $0000,$6600         ; $2AE066 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2AE06A
        BSET    D1,$00(A0,D0.W)                 ; $2AE06C
        SUBI.B  #$0000,(A0)                     ; $2AE070
        BNE.W  $2AE556                          ; $2AE074
        DC.W    $04F0               ; $2AE078 DC.W    $04F0
        BTST    D2,D0                           ; $2AE07A
        BTST    D2,(A0)                         ; $2AE07C
        CMPI.B  #$0052,D0                       ; $2AE07E
        ORI.W  #$04BE,(A2)                      ; $2AE082
        DC.W    $022E,$FFA2,$04A0   ; $2AE086 ANDI.B  #$FFA2,$04A0(A6)
        DC.W    $020B,$00BE         ; $2AE08C ANDI.B  #$00BE,A3
        BCLR    D2,$08(A3,D0.W)                 ; $2AE090
        BTST    D0,(A6)                         ; $2AE094
        BSET    D2,(A7)                         ; $2AE096
        BTST    D1,-$3E(A2,A7.L)                ; $2AE098
        SUBI.B  #$0295,(A0)                     ; $2AE09C
        DC.W    $00C0               ; $2AE0A0 DC.W    $00C0
        BTST    D2,D2                           ; $2AE0A2
        BCLR    D1,$19(A2,D0.W)                 ; $2AE0A4
        SUBI.B  #$02B8,-$005C(A6)               ; $2AE0A8
        BTST    D2,-(A5)                        ; $2AE0AE
        BSET    D1,(A4)+                        ; $2AE0B0
        DC.W    $FFC4               ; $2AE0B2 MOVE.W  D4,<EA:3F>
        DC.W    $054B               ; $2AE0B4 BCHG    D2,A3
        DC.W    $03CA               ; $2AE0B6 BSET    D1,A2
        DC.W    $0016,$05B4         ; $2AE0B8 ORI.B  #$05B4,(A6)
        BTST    D1,$68(A6,D0.W)                 ; $2AE0BC
        ADDI.W  #$03EE,-(A6)                    ; $2AE0C0
        ORI.L  #$05D9045D,(A1)                  ; $2AE0C4
        DC.W    $0037,$0539,$03B5   ; $2AE0CA ORI.B  #$0539,-$4B(A7,D0.W)
        DC.W    $00C5               ; $2AE0D0 DC.W    $00C5
        BSET    D2,D6                           ; $2AE0D2
        SUBI.W  #$00E6,D7                       ; $2AE0D4
        BCLR    D2,(A5)                         ; $2AE0D8
        BCHG    D1,-$50(A1,A7.L)                ; $2AE0DA
        BCHG    D2,-(A2)                        ; $2AE0DE
        BCHG    D1,-$00B8(A4)                   ; $2AE0E0
        SUBI.W  #$026B,-$00A0(A4)               ; $2AE0E4
        SUBI.L  #$025AFFC9,A1                   ; $2AE0EA
        BCHG    D2,D6                           ; $2AE0F0
        BCLR    D1,-$69(PC,A7.L)                ; $2AE0F2
        DC.W    $0439,$02A3,$FFB1,$044C; $2AE0F6 SUBI.B  #$02A3,$FFB1044C
        DC.W    $02B0,$FFA0,$043E,$027E; $2AE0FE ANDI.L  #$FFA0043E,$7E(A0,D0.W)
        MOVE.W  -(A0),$055D(A7)                 ; $2AE106
        DC.W    $01CE               ; $2AE10A BSET    D0,A6
        MOVE.W  -(A4),-$57(A7,D0.W)             ; $2AE10C
        BSET    D0,(A2)+                        ; $2AE110
        DC.W    $FFF4,$041F         ; $2AE112 MOVE.W  $1F(A4,D0.W),<EA:3F>
        ANDI.W  #$FFA9,$057C(A1)                ; $2AE116
        BCLR    D0,(A4)                         ; $2AE11C
        DC.W    $FFFD               ; $2AE11E MOVE.W  <EA:3D>,<EA:3F>
        DC.W    $04AD,$01C0,$FFF4,$06D7; $2AE120 SUBI.L  #$01C0FFF4,$06D7(A5)
        DC.W    $0209,$0024         ; $2AE128 ANDI.B  #$0024,A1
        BCLR    D2,$0131(PC)                    ; $2AE12C
        DC.W    $0030,$047A,$00FA   ; $2AE130 ORI.B  #$047A,-$06(A0,D0.W)
        DC.W    $0016,$05DD         ; $2AE136 ORI.B  #$05DD,(A6)
        DC.W    $022E,$0100,$05A5   ; $2AE13A ANDI.B  #$0100,$05A5(A6)
        DC.W    $0205,$0157         ; $2AE140 ANDI.B  #$0157,D5
        DC.W    $04F4               ; $2AE144 DC.W    $04F4
        BTST    D1,$0176.W                      ; $2AE146
        BTST    D2,(A3)+                        ; $2AE14A
        BCHG    D1,#$0122                       ; $2AE14C
        BCHG    D2,#$01F7                       ; $2AE150
        DC.W    $00F0               ; $2AE154 DC.W    $00F0
        DC.W    $04BB,$0346,$0113,$0722; $2AE156 SUBI.L  #$03460113,$22(PC,D0.W)
        BCLR    D0,-(A3)                        ; $2AE15E
        BTST    D0,(A4)                         ; $2AE160
        DC.W    $06C9               ; $2AE162 DC.W    $06C9
        DC.W    $018D               ; $2AE164 BCLR    D0,A5
loc_2AE166:
        BCHG    D0,(A2)                         ; $2AE166
        DC.W    $058A               ; $2AE168 BCLR    D2,A2
        DC.W    $020B,$014C         ; $2AE16A ANDI.B  #$014C,A3
        BCLR    D2,(A6)+                        ; $2AE16E
        DC.W    $023B,$010D,$0705   ; $2AE170 ANDI.B  #$010D,$05(PC,D0.W)
        BCHG    D0,(A7)                         ; $2AE176
        BTST    D0,D7                           ; $2AE178
        BCLR    D2,D1                           ; $2AE17A
        BSET    D0,$0100(A6)                    ; $2AE17C
        SUBI.B  #$00CA,-(A6)                    ; $2AE180
        MOVE.W  A5,$36(A7,D0.W)                 ; $2AE184
        DC.W    $00DC               ; $2AE188 DC.W    $00DC
        DC.W    $00ED               ; $2AE18A DC.W    $00ED
        DC.W    $04B5,$024D,$00B6,$04A8; $2AE18C SUBI.L  #$024D00B6,-$58(A5,D0.W)
        ANDI.W  #$FF96,D0                       ; $2AE194
        BCLR    D1,D7                           ; $2AE198
loc_2AE19A:
        BTST    D0,(A0)+                        ; $2AE19A
        DC.W    $00F2               ; $2AE19C DC.W    $00F2
        SUBI.B  #$028B,D6                       ; $2AE19E
        DC.W    $00BB,$0377,$0108,$FF92; $2AE1A2 ORI.L  #$03770108,-$6E(PC,A7.L)
        BSET    D1,$027CFF9A                    ; $2AE1AA
        BCLR    D2,(A3)+                        ; $2AE1B0
        DC.W    $00D0               ; $2AE1B2 DC.W    $00D0
        DC.W    $0025,$056C         ; $2AE1B4 ORI.B  #$056C,-(A5)
        DC.W    $003E,$FFDE         ; $2AE1B8 ORI.B  #$FFDE,<EA:3E>
        BCLR    D1,(A0)+                        ; $2AE1BC
        DC.W    $00C8               ; $2AE1BE DC.W    $00C8
        DC.W    $FFF1,$03C6         ; $2AE1C0 MOVE.W  -$3A(A1,D0.W),<EA:3F>
        BCHG    D0,(A3)+                        ; $2AE1C4
        DC.W    $0039,$0595,$00D2,$FF95; $2AE1C6 ORI.B  #$0595,$00D2FF95
        BSET    D1,D0                           ; $2AE1CE
        BCHG    D0,(A5)+                        ; $2AE1D0
        MOVE.W  $056F(A1),$42(A7,A7.L)          ; $2AE1D2
        DC.W    $001E,$050A         ; $2AE1D8 ORI.B  #$050A,(A6)+
        MOVE.W  A7,-$0014(A7)                   ; $2AE1DC
        BCHG    D2,D7                           ; $2AE1E0
        DC.W    $00E4               ; $2AE1E2 DC.W    $00E4
        DC.W    $FFDB               ; $2AE1E4 MOVE.W  (A3)+,<EA:3F>
        BCLR    D2,$00D6(A6)                    ; $2AE1E6
        DC.W    $000E,$056F         ; $2AE1EA ORI.B  #$056F,A6
        DC.W    $FF3E               ; $2AE1EE MOVE.W  <EA:3E>,-(A7)
        DC.W    $FFB9,$05AE,$00D1,$FFA7; $2AE1F0 MOVE.W  $05AE00D1,-$59(A7,A7.L)
        ADDI.B  #$FF29,(A5)+                    ; $2AE1F8
        MOVE.W  -(A4),$1D(A7,D0.W)              ; $2AE1FC
