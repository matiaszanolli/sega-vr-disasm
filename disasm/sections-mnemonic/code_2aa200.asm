; Generated assembly for $2AA200-$2AC200
; Branch targets: 75
; Labels: 65
; Format: DC.W with decoded mnemonics as comments

        org     $2AA200

        BCLR    D0,(A0)                         ; $2AA200
        BCLR    D0,D0                           ; $2AA202
        SUBI.B  #$6400,(A0)                     ; $2AA204
        BCHG    D0,-(A0)                        ; $2AA208
        BCHG    D0,(A0)                         ; $2AA20A
        ADDI.B  #$6201,(A1)                     ; $2AA20C
        BCHG    D0,$10(A0,D0.W)                 ; $2AA210
        BPL.W  loc_2AA3B6                       ; $2AA214
        BCLR    D0,-$40(A0,D0.W)                ; $2AA218
        BSET    D0,(A0)                         ; $2AA21C
        DC.W    $0210,$6C00         ; $2AA21E ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AA222
        SUBI.B  #$6B00,(A0)                     ; $2AA226
        BSET    D0,D0                           ; $2AA22A
        BCLR    D0,$11(A0,D0.W)                 ; $2AA22C
        BVS.S  loc_2AA233                       ; $2AA230
        BSET    D0,(A0)                         ; $2AA232
        DC.W    $0010,$6300         ; $2AA234 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AA238 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AA23C ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AA240 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AA244
        SUBI.B  #$6400,(A0)                     ; $2AA248
        DC.W    $0220,$0210         ; $2AA24C ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AA250 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AA254 ANDI.B  #$0010,D0
        BNE.W  loc_2AA4BA                       ; $2AA258
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2AA25C
        ADDI.B  #$6700,(A0)                     ; $2AA262
        ANDI.L  #$02B00410,-(A0)                ; $2AA266
        BVC.W  loc_2AA52E                       ; $2AA26C
        DC.W    $02D0               ; $2AA270 DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2AA272
        ANDI.W  #$0290,-(A0)                    ; $2AA276
        DC.W    $0010,$0300         ; $2AA27A ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2AA27E DC.W    $02E0
        DC.W    $02F0               ; $2AA280 DC.W    $02F0
        BTST    D1,D0                           ; $2AA282
        BTST    D1,(A0)                         ; $2AA284
        DC.W    $0210,$0500         ; $2AA286 ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2AA28A
        SUBI.B  #$0400,(A0)                     ; $2AA28E
        BTST    D1,D0                           ; $2AA292
        DC.W    $02F0               ; $2AA294 DC.W    $02F0
        DC.W    $0010,$6500         ; $2AA296 ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2AA29A
        BCHG    D1,(A0)                         ; $2AA29C
        BCHG    D1,-(A0)                        ; $2AA29E
        BCHG    D1,$10(A0,D0.W)                 ; $2AA2A0
        BLS.W  loc_2AA636                       ; $2AA2A4
        BCLR    D1,D0                           ; $2AA2A8
        SUBI.B  #$6400,(A0)                     ; $2AA2AA
        BCHG    D1,-(A0)                        ; $2AA2AE
        BCHG    D1,(A0)                         ; $2AA2B0
        DC.W    $0010,$0300         ; $2AA2B2 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AA2B6
        BSET    D1,$00(A0,D0.W)                 ; $2AA2B8
        SUBI.B  #$0210,(A0)                     ; $2AA2BC
        BTST    D2,D0                           ; $2AA2C0
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AA2C2
        SUBI.B  #$0400,D0                       ; $2AA2C8
        BSET    D1,$10(A0,D0.W)                 ; $2AA2CC
        BCS.W  loc_2AA712                       ; $2AA2D0
        SUBI.W  #$0460,(A0)                     ; $2AA2D4
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AA2D8
        SUBI.L  #$04800410,(A0)                 ; $2AA2DE
        BCC.W  loc_2AA746                       ; $2AA2E4
        SUBI.W  #$0000,(A0)                     ; $2AA2E8
        BNE.W  loc_2AA68E                       ; $2AA2EC
        BCLR    D1,-$40(A0,D0.W)                ; $2AA2F0
        BSET    D1,(A0)                         ; $2AA2F4
        DC.W    $0000,$6600         ; $2AA2F6 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AA2FA
        DC.W    $04D0               ; $2AA300 DC.W    $04D0
        CMPI.B  #$005E,D0                       ; $2AA302
        ORI.W  #$052D,(A6)+                     ; $2AA306
        DC.W    $02ED               ; $2AA30A DC.W    $02ED
        MOVE.W  $0533(A7),$02F2(A7)             ; $2AA30C
        ORI.L  #$066E03CC,A7                    ; $2AA312
        ORI.L  #$066703C6,-(A0)                 ; $2AA318
        MOVE.W  A0,$04B8(A7)                    ; $2AA31E
        DC.W    $038F               ; $2AA322 BCLR    D1,A7
        ORI.L  #$05D8048D,A7                    ; $2AA324
        ORI.L  #$04B2038A,-(A0)                 ; $2AA32A
        MOVE.W  $05CF(A7),$0487(A7)             ; $2AA330
        MOVE.W  A0,$05FE(A7)                    ; $2AA336
        SUBI.W  #$FF96,$065D(PC)                ; $2AA33A
        BSET    D1,-(A4)                        ; $2AA340
        DC.W    $FFF0,$0729         ; $2AA342 MOVE.W  $29(A0,D0.W),<EA:3F>
        SUBI.L  #$FFE906A0,D3                   ; $2AA346
        DC.W    $04F9               ; $2AA34C DC.W    $04F9
        MOVE.W  (A1),$02(A7,D0.W)               ; $2AA34E
        DC.W    $047D,$0047         ; $2AA352 SUBI.W  #$0047,<EA:3D>
        ADDI.L  #$04FC0041,-(A4)                ; $2AA356
        ADDI.B  #$0407,-(A4)                    ; $2AA35C
        MOVE.W  D2,$05E3(A7)                    ; $2AA360
        SUBI.B  #$FEE5,(A0)+                    ; $2AA364
        BTST    D2,(A6)+                        ; $2AA368
        DC.W    $02F2               ; $2AA36A DC.W    $02F2
        MOVE.W  $4E(PC,D0.W),(A7)               ; $2AA36C
        DC.W    $02C5               ; $2AA370 DC.W    $02C5
        MOVE.W  (A5),-(A7)                      ; $2AA372
        DC.W    $05C8               ; $2AA374 BSET    D2,A0
        SUBI.W  #$FF4D,D2                       ; $2AA376
        DC.W    $04F2               ; $2AA37A DC.W    $04F2
        BTST    D1,D2                           ; $2AA37C
        MOVE.W  -(A0),-(A7)                     ; $2AA37E
        BTST    D2,-(A0)                        ; $2AA380
        BTST    D1,(A7)                         ; $2AA382
        MOVE.W  (A2),-(A7)                      ; $2AA384
        DC.W    $04FE               ; $2AA386 DC.W    $04FE
        DC.W    $0308               ; $2AA388 BTST    D1,A0
        MOVE.W  A0,(A7)+                        ; $2AA38A
        BSET    D2,(A0)+                        ; $2AA38C
        DC.W    $0203,$FE9C         ; $2AA38E ANDI.B  #$FE9C,D3
        ADDI.B  #$01D9,-$0124(A0)               ; $2AA392
        DC.W    $04E0               ; $2AA398 DC.W    $04E0
        DC.W    $02E3               ; $2AA39A DC.W    $02E3
        MOVE.W  A4,-(A7)                        ; $2AA39C
        BSET    D2,$01A4(A0)                    ; $2AA39E
        MOVE.W  (A5),(A7)+                      ; $2AA3A2
        BCHG    D2,-(A1)                        ; $2AA3A4
        DC.W    $02CB               ; $2AA3A6 DC.W    $02CB
        DC.W    $00D9               ; $2AA3A8 DC.W    $00D9
        BTST    D2,-$0B(A3,D0.W)                ; $2AA3AA
        BTST    D0,-$13(A5,D0.W)                ; $2AA3AE
        SUBI.B  #$0109,-(A1)                    ; $2AA3B2
loc_2AA3B6:
        ADDI.B  #$0413,$00A8(A4)                ; $2AA3B6
        BTST    D2,D3                           ; $2AA3BC
        BTST    D1,D5                           ; $2AA3BE
        DC.W    $00D2               ; $2AA3C0 DC.W    $00D2
        DC.W    $05CD               ; $2AA3C2 BSET    D2,A5
        SUBI.W  #$00A2,A4                       ; $2AA3C4
        ADDI.W  #$01EE,A3                       ; $2AA3C8
        BTST    D0,D4                           ; $2AA3CC
        BSET    D2,$11(PC,D0.W)                 ; $2AA3CE
        BCHG    D0,D7                           ; $2AA3D2
        BTST    D2,(A1)                         ; $2AA3D4
        DC.W    $0309               ; $2AA3D6 BTST    D1,A1
        BTST    D0,$052E(A1)                    ; $2AA3D8
        BTST    D1,(A4)+                        ; $2AA3DC
        DC.W    $00DF               ; $2AA3DE DC.W    $00DF
        ADDI.B  #$01B5,A7                       ; $2AA3E0
        DC.W    $010C               ; $2AA3E4 BTST    D0,A4
        DC.W    $04F1               ; $2AA3E6 DC.W    $04F1
        DC.W    $02E3               ; $2AA3E8 DC.W    $02E3
        DC.W    $00E7               ; $2AA3EA DC.W    $00E7
        DC.W    $078E               ; $2AA3EC BCLR    D3,A6
        BCHG    D0,(A6)+                        ; $2AA3EE
        MOVE.W  $077E(A4),(A7)+                 ; $2AA3F0
        ANDI.W  #$FECA,(A1)+                    ; $2AA3F4
        ADDI.B  #$023E,A5                       ; $2AA3F8
        MOVE.W  $061B(A0),(A7)                  ; $2AA3FC
        BCHG    D0,D3                           ; $2AA400
        MOVE.W  A2,(A7)+                        ; $2AA402
        DC.W    $0748               ; $2AA404 BCHG    D3,A0
        BCHG    D1,D2                           ; $2AA406
        ORI.W  #$0741,(A6)+                     ; $2AA408
        ANDI.L  #$012605CF,-(A7)                ; $2AA40C
        ANDI.L  #$010505D7,A5                   ; $2AA412
        BTST    D1,-(A7)                        ; $2AA418
        DC.W    $003B,$0762,$0321   ; $2AA41A ORI.B  #$0762,$21(PC,D0.W)
        MOVE.W  -(A4),$05F0(A7)                 ; $2AA420
        BTST    D1,D7                           ; $2AA424
        MOVE.W  D1,$0787(A7)                    ; $2AA426
        DC.W    $00C3               ; $2AA42A DC.W    $00C3
        MOVE.W  $14(A6,D0.W),-$59(A7,D0.W)      ; $2AA42C
        MOVE.W  (A4),$50(A7,D0.W)               ; $2AA432
        BCLR    D0,$0149(A4)                    ; $2AA436
        BSET    D2,(A6)+                        ; $2AA43A
        BCLR    D0,(A1)                         ; $2AA43C
        BTST    D0,-(A6)                        ; $2AA43E
        BCHG    D3,$00E3(A5)                    ; $2AA440
        DC.W    $00B0,$05FA,$00C8,$008E; $2AA444 ORI.L  #$05FA00C8,-$72(A0,D0.W)
        SUBI.W  #$01CA,A6                       ; $2AA44C
        MOVE.W  A7,$044E(A7)                    ; $2AA450
        DC.W    $01CA               ; $2AA454 BSET    D0,A2
        DC.W    $00B1,$0533,$030B,$0091; $2AA456 ORI.L  #$0533030B,-$6F(A1,D0.W)
        BTST    D2,$0B(A3,D0.W)                 ; $2AA45E
        MOVE.W  $03B8(A7),$0235(A7)             ; $2AA462
        DC.W    $00B1,$049B,$0376,$0091; $2AA468 ORI.L  #$049B0376,-$6F(A1,D0.W)
        BCLR    D1,$0235.W                      ; $2AA470
        MOVE.W  A7,$049B(A7)                    ; $2AA474
        BCHG    D1,$6F(A6,A7.L)                 ; $2AA478
        SUBI.W  #$0074,(A6)                     ; $2AA47C
        MOVE.W  A2,-$34(A7,D0.W)                ; $2AA480
        ORI.L  #$FF2903D1,(A3)                  ; $2AA484
        ANDI.W  #$FFB6,$045B(A0)                ; $2AA48A
        ANDI.W  #$0014,A1                       ; $2AA490
        SUBI.W  #$009D,$00(A0,A7.L)             ; $2AA494
        SUBI.W  #$0272,-$73(A5,A7.L)            ; $2AA49A
        DC.W    $02DC               ; $2AA4A0 DC.W    $02DC
        DC.W    $0024,$FF22         ; $2AA4A2 ORI.B  #$FF22,-(A4)
        DC.W    $02CC               ; $2AA4A6 DC.W    $02CC
        ORI.L  #$FF060457,(A2)                  ; $2AA4A8
        DC.W    $00E0               ; $2AA4AE DC.W    $00E0
        MOVE.W  (A7),$0466(A7)                  ; $2AA4B0
        ORI.W  #$FF73,-$15(A1,D0.W)             ; $2AA4B4
loc_2AA4BA:
        DC.W    $003C,$FEC0,$0475   ; $2AA4BA ORI.B  #$FEC0,#$0475
        ORI.L  #$FF110373,A2                    ; $2AA4C0
        MOVE.W  -$09(A6,A7.L),$4C(A7,D0.W)      ; $2AA4C6
        MOVE.W  A1,-$09(A7,A7.L)                ; $2AA4CC
        ANDI.W  #$0041,-$09(A2,A7.L)            ; $2AA4D0
        DC.W    $02AF,$0088,$FEF7,$042F; $2AA4D6 ANDI.L  #$0088FEF7,$042F(A7)
        DC.W    $0238,$FFE0,$03C5   ; $2AA4DE ANDI.B  #$FFE0,$03C5.W
        BSET    D0,-(A1)                        ; $2AA4E4
        ORI.W  #$0543,D3                        ; $2AA4E6
        BTST    D0,$44(PC,D0.W)                 ; $2AA4EA
        BCLR    D2,$0192(A5)                    ; $2AA4EE
        DC.W    $00DF               ; $2AA4F2 DC.W    $00DF
        SUBI.B  #$0280,D0                       ; $2AA4F4
        ORI.W  #$057D,(A3)                      ; $2AA4F8
        BSET    D0,(A2)+                        ; $2AA4FC
        BCHG    D0,(A3)                         ; $2AA4FE
        BCLR    D2,-(A2)                        ; $2AA500
        BCLR    D0,$00E6(A3)                    ; $2AA502
        BTST    D2,-$4B(A1,D0.W)                ; $2AA506
        DC.W    $00F1               ; $2AA50A DC.W    $00F1
        BTST    D2,-(A7)                        ; $2AA50C
        ORI.W  #$01C5,(A6)                      ; $2AA50E
        BCLR    D2,(A2)+                        ; $2AA512
        ORI.W  #$01BA,A4                        ; $2AA514
        BCLR    D2,D1                           ; $2AA518
        BSET    D0,(A6)+                        ; $2AA51A
        BTST    D0,$0578007E                    ; $2AA51C
        DC.W    $020D,$0645         ; $2AA522 ANDI.B  #$0645,A5
        ORI.W  #$01DF,D4                        ; $2AA526
        ADDI.W  #$0009,D5                       ; $2AA52A
loc_2AA52E:
        BSET    D0,(A7)+                        ; $2AA52E
        BTST    D2,-(A6)                        ; $2AA530
        DC.W    $0009,$01DF         ; $2AA532 ORI.B  #$01DF,A1
        BTST    D2,-(A6)                        ; $2AA536
        ORI.W  #$01DF,-(A6)                     ; $2AA538
        DC.W    $0010,$0500         ; $2AA53C ORI.B  #$0500,(A0)
        ANDI.W  #$0270,-(A0)                    ; $2AA540
        ANDI.L  #$02900210,D0                   ; $2AA544
        ADDI.B  #$0310,D0                       ; $2AA54A
        BTST    D1,D0                           ; $2AA54E
        SUBI.B  #$0500,(A0)                     ; $2AA550
        BCHG    D1,(A0)                         ; $2AA554
        BCHG    D1,D0                           ; $2AA556
        SUBI.B  #$0600,(A0)                     ; $2AA558
        BTST    D1,$20(A0,D0.W)                 ; $2AA55C
        SUBI.B  #$0500,(A0)                     ; $2AA560
        DC.W    $02C0               ; $2AA564 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2AA566 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2AA56E DC.W    $02D0
        DC.W    $0210,$0600         ; $2AA570 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2AA574
        BTST    D2,D0                           ; $2AA57A
        DC.W    $02F0               ; $2AA57C DC.W    $02F0
        DC.W    $02E0               ; $2AA57E DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2AA580
        BCHG    D1,(A0)                         ; $2AA584
        BTST    D1,(A0)                         ; $2AA586
        DC.W    $0210,$0300         ; $2AA588 ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2AA58C
        ADDI.B  #$0270,D0                       ; $2AA592
        DC.W    $02E0               ; $2AA596 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2AA598
        ANDI.W  #$0300,-(A0)                    ; $2AA59C
        DC.W    $0210,$0300         ; $2AA5A0 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2AA5A4
        ANDI.L  #$04100300,-(A0)                ; $2AA5A6
        BTST    D1,-(A0)                        ; $2AA5AC
        DC.W    $02B0,$0010,$6E00,$0000; $2AA5AE ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2AA5B6 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2AA5BA ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AA5C0
        SUBI.B  #$7000,(A0)                     ; $2AA5C4
        ORI.W  #$0070,-(A0)                     ; $2AA5C8
        SUBI.B  #$6F00,(A0)                     ; $2AA5CC
        DC.W    $0000,$0030         ; $2AA5D0 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AA5D4 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AA5D8 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AA5DC ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AA5E0
        DC.W    $00B0,$0210,$0400,$00D0; $2AA5E6 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AA5EE DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AA5F0
        ORI.L  #$00900611,-(A0)                 ; $2AA5F4
        BTST    D3,D1                           ; $2AA5FA
        DC.W    $00B0,$0010,$6A00,$00E0; $2AA5FC ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AA604 DC.W    $00F0
        BTST    D0,D0                           ; $2AA606
        BTST    D0,(A0)                         ; $2AA608
        DC.W    $0210,$6C00         ; $2AA60A ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AA60E
        SUBI.B  #$6B00,(A0)                     ; $2AA612
        BTST    D0,D0                           ; $2AA616
        DC.W    $00F0               ; $2AA618 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AA61A ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AA61E DC.W    $00E0
        DC.W    $0010,$6300         ; $2AA620 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AA624
        BCHG    D0,(A0)                         ; $2AA626
        BCHG    D0,-(A0)                        ; $2AA628
        BCHG    D0,$10(A0,D0.W)                 ; $2AA62A
        BCS.W  loc_2AA7C0                       ; $2AA62E
        BCLR    D0,D0                           ; $2AA632
        SUBI.B  #$6400,(A0)                     ; $2AA634
        BCHG    D0,-(A0)                        ; $2AA638
        BCHG    D0,(A0)                         ; $2AA63A
        ADDI.B  #$6201,(A1)                     ; $2AA63C
        BCHG    D0,$10(A0,D0.W)                 ; $2AA640
        BPL.W  loc_2AA7E6                       ; $2AA644
        BCLR    D0,-$40(A0,D0.W)                ; $2AA648
        BSET    D0,(A0)                         ; $2AA64C
        DC.W    $0210,$6C00         ; $2AA64E ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AA652
        SUBI.B  #$6B00,(A0)                     ; $2AA656
        BSET    D0,D0                           ; $2AA65A
        BCLR    D0,$11(A0,D0.W)                 ; $2AA65C
        BVS.S  loc_2AA663                       ; $2AA660
        BSET    D0,(A0)                         ; $2AA662
        DC.W    $0010,$6300         ; $2AA664 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AA668 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AA66C ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AA670 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AA674
        SUBI.B  #$6400,(A0)                     ; $2AA678
        DC.W    $0220,$0210         ; $2AA67C ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AA680 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AA684 ANDI.B  #$0010,D0
        BNE.W  loc_2AA9EA                       ; $2AA688
        BCHG    D1,-$80(A0,D0.W)                ; $2AA68C
        BCLR    D1,(A0)                         ; $2AA690
        ADDI.B  #$6700,(A0)                     ; $2AA692
        BCLR    D1,-(A0)                        ; $2AA696
        BCLR    D1,$10(A0,D0.W)                 ; $2AA698
        BVC.W  loc_2AAA5E                       ; $2AA69C
        BSET    D1,(A0)                         ; $2AA6A0
        SUBI.B  #$6700,(A0)                     ; $2AA6A2
        BCHG    D1,-(A0)                        ; $2AA6A6
        BCLR    D1,(A0)                         ; $2AA6A8
        DC.W    $0010,$0300         ; $2AA6AA ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AA6AE
        BSET    D1,$00(A0,D0.W)                 ; $2AA6B0
        SUBI.B  #$0210,(A0)                     ; $2AA6B4
        BTST    D2,D0                           ; $2AA6B8
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AA6BA
        SUBI.B  #$0400,D0                       ; $2AA6C0
        BSET    D1,$10(A0,D0.W)                 ; $2AA6C4
        BCS.W  loc_2AAB0A                       ; $2AA6C8
        SUBI.W  #$0460,(A0)                     ; $2AA6CC
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AA6D0
        SUBI.L  #$04800410,(A0)                 ; $2AA6D6
        BCC.W  loc_2AAB3E                       ; $2AA6DC
        SUBI.W  #$0010,(A0)                     ; $2AA6E0
        BTST    D1,D0                           ; $2AA6E4
        DC.W    $04E0               ; $2AA6E6 DC.W    $04E0
        DC.W    $04F0               ; $2AA6E8 DC.W    $04F0
        BTST    D2,D0                           ; $2AA6EA
        BTST    D2,(A0)                         ; $2AA6EC
        DC.W    $0210,$0500         ; $2AA6EE ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2AA6F2
        SUBI.B  #$0400,(A0)                     ; $2AA6F6
        BTST    D2,D0                           ; $2AA6FA
        DC.W    $04F0               ; $2AA6FC DC.W    $04F0
        DC.W    $0010,$6500         ; $2AA6FE ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2AA702
        BCHG    D2,(A0)                         ; $2AA704
        BCHG    D2,-(A0)                        ; $2AA706
        BCHG    D2,$10(A0,D0.W)                 ; $2AA708
        BLS.W  loc_2AAC9E                       ; $2AA70C
        BCLR    D2,D0                           ; $2AA710
loc_2AA712:
        SUBI.B  #$6400,(A0)                     ; $2AA712
        BCHG    D2,-(A0)                        ; $2AA716
        BCHG    D2,(A0)                         ; $2AA718
        DC.W    $0000,$6600         ; $2AA71A ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AA71E
        DC.W    $04D0               ; $2AA724 DC.W    $04D0
        DC.W    $0000,$6600         ; $2AA726 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2AA72A
        BCLR    D2,-$40(A0,D0.W)                ; $2AA72C
        BSET    D2,(A0)                         ; $2AA730
        CMPI.B  #$005E,D0                       ; $2AA732
        ORI.W  #$03BF,(A6)+                     ; $2AA736
        DC.W    $03CD               ; $2AA73A BSET    D1,A5
        MOVE.W  D4,(A7)+                        ; $2AA73C
        DC.W    $04C9               ; $2AA73E DC.W    $04C9
        BCLR    D1,D3                           ; $2AA740
        MOVE.W  (A5),-(A7)                      ; $2AA742
        BCHG    D2,-$57(A2,D0.W)                ; $2AA744
        MOVEA.W -(A1),A7                        ; $2AA748
        SUBI.B  #$0503,-$02(A3,A7.L)            ; $2AA74A
        DC.W    $04B3,$03E9,$FFBE,$0556; $2AA750 SUBI.L  #$03E9FFBE,$56(A3,D0.W)
        BTST    D2,-(A6)                        ; $2AA758
        MOVE.W  -$58(A1,D0.W),-(A7)             ; $2AA75A
        SUBI.B  #$FF6D,$16(A4,D0.W)             ; $2AA75E
        BCLR    D2,D1                           ; $2AA764
        MOVE.W  A7,(A7)+                        ; $2AA766
        SUBI.W  #$056D,-$0147(A6)               ; $2AA768
        DC.W    $04CD               ; $2AA76E DC.W    $04CD
        DC.W    $04EB               ; $2AA770 DC.W    $04EB
        MOVEA.W D4,A7                           ; $2AA772
        BTST    D2,$05BF(A4)                    ; $2AA774
        DC.W    $FDD1               ; $2AA778 MOVE.W  (A1),<EA:3E>
        DC.W    $04B9,$0616,$FE5E,$0512,$0540; $2AA77A SUBI.L  #$0616FE5E,$05120540
        MOVE.W  $055D(A3),(A7)+                 ; $2AA784
        BSET    D2,-$0170(A0)                   ; $2AA788
        SUBI.B  #$0531,(A4)+                    ; $2AA78C
        MOVEA.W (A2),A7                         ; $2AA790
        BCLR    D1,$053D(A6)                    ; $2AA792
        MOVEA.W $31(A2,D0.W),A7                 ; $2AA796
        BSET    D1,-$58(A4,A7.L)                ; $2AA79A
        BCLR    D1,(A4)                         ; $2AA79E
        DC.W    $03C9               ; $2AA7A0 BSET    D1,A1
        MOVE.W  A6,(A7)                         ; $2AA7A2
        SUBI.B  #$054A,D6                       ; $2AA7A4
        MOVE.W  #$037D,(A7)                     ; $2AA7A8
        BSET    D1,-(A4)                        ; $2AA7AC
        MOVE.W  -$75(A7,D0.W),(A7)+             ; $2AA7AE
        SUBI.B  #$FEB5,D6                       ; $2AA7B2
        BTST    D1,$0406FEC1                    ; $2AA7B6
        BTST    D1,(A0)+                        ; $2AA7BC
        DC.W    $02EF               ; $2AA7BE DC.W    $02EF
loc_2AA7C0:
        DC.W    $FDFD               ; $2AA7C0 MOVE.W  <EA:3D>,<EA:3E>
        BCHG    D1,-(A3)                        ; $2AA7C2
        DC.W    $02B2,$FDC5,$036A,$03DC; $2AA7C4 ANDI.L  #$FDC5036A,-$24(A2,D0.W)
        MOVE.W  $41(A5,D0.W),(A7)+              ; $2AA7CC
        ANDI.L  #$FE070528,A0                   ; $2AA7D0
        BCHG    D1,-$007A(A2)                   ; $2AA7D6
        BCHG    D2,-$6F(A3,D0.W)                ; $2AA7DA
        DC.W    $FFCE               ; $2AA7DE MOVE.W  A6,<EA:3F>
        BCLR    D2,$04AD(A4)                    ; $2AA7E0
        DC.W    $FEFE               ; $2AA7E4 MOVE.W  <EA:3E>,(A7)+
loc_2AA7E6:
        BCHG    D2,-(A6)                        ; $2AA7E6
        SUBI.L  #$FEA20508,(A7)+                ; $2AA7E8
        BCLR    D1,-$0028(A5)                   ; $2AA7EE
        BCHG    D2,D5                           ; $2AA7F2
        DC.W    $04E2               ; $2AA7F4 DC.W    $04E2
        MOVE.W  -$60(A4,D0.W),(A7)+             ; $2AA7F6
        DC.W    $02FD               ; $2AA7FA DC.W    $02FD
        MOVEA.W -$38(A3,D0.W),A7                ; $2AA7FC
        DC.W    $02FE               ; $2AA800 DC.W    $02FE
        MOVE.W  (A3)+,(A7)+                     ; $2AA802
        BCHG    D2,(A3)+                        ; $2AA804
        BCLR    D1,(A6)+                        ; $2AA806
        DC.W    $FFF6,$051C         ; $2AA808 MOVE.W  $1C(A6,D0.W),<EA:3F>
        DC.W    $03BF               ; $2AA80C BCLR    D1,<EA:3F>
        DC.W    $FFCB               ; $2AA80E MOVE.W  A3,<EA:3F>
        BCLR    D2,(A0)+                        ; $2AA810
        DC.W    $02B4,$FE99,$0513,$0375; $2AA812 ANDI.L  #$FE990513,$75(A4,D0.W)
        DC.W    $FFF2,$0368         ; $2AA81A MOVE.W  $68(A2,D0.W),<EA:3F>
        ANDI.W  #$FD36,-(A3)                    ; $2AA81E
        BCHG    D1,(A6)                         ; $2AA822
        BCHG    D1,-(A1)                        ; $2AA824
        DC.W    $FD3F               ; $2AA826 MOVE.W  <EA:3F>,-(A6)
        BTST    D1,-(A6)                        ; $2AA828
        DC.W    $034E               ; $2AA82A BCHG    D1,A6
        MOVE.W  $39(A1,D0.W),(A7)               ; $2AA82C
        ANDI.W  #$FEA7,(A1)                     ; $2AA830
        DC.W    $04F5               ; $2AA834 DC.W    $04F5
        SUBI.B  #$FD7D,-$4B(A1,D0.W)            ; $2AA836
        DC.W    $038A               ; $2AA83C BCLR    D1,A2
        MOVE.W  A6,-$7A(A6,D0.W)                ; $2AA83E
        BCHG    D1,$FEFF.W                      ; $2AA842
        DC.W    $04C7               ; $2AA846 DC.W    $04C7
        SUBI.B  #$FEEF,(A7)+                    ; $2AA848
        BSET    D1,$0420FD5E                    ; $2AA84C
        DC.W    $03CB               ; $2AA852 BSET    D1,A3
        SUBI.B  #$FECE,A6                       ; $2AA854
        SUBI.B  #$01BC,-(A6)                    ; $2AA858
        MOVE.W  D5,$03F8(A6)                    ; $2AA85C
        BCLR    D0,-$0149(A3)                   ; $2AA860
        BSET    D2,D7                           ; $2AA864
        ANDI.L  #$FD840598,A5                   ; $2AA866
        ANDI.W  #$FEF5,$0522(PC)                ; $2AA86C
        DC.W    $01CD               ; $2AA872 BSET    D0,A5
        MOVE.W  -(A6),$04F4(A6)                 ; $2AA874
        BCLR    D0,#$FED8                       ; $2AA878
        BTST    D1,-(A5)                        ; $2AA87C
        DC.W    $027C,$FF62,$0473   ; $2AA87E ANDI.W  #$FF62,#$0473
        DC.W    $0234,$FFBD,$04CA   ; $2AA884 ANDI.B  #$FFBD,-$36(A4,D0.W)
        BCLR    D1,(A1)                         ; $2AA88A
        MOVE.W  (A0)+,-(A7)                     ; $2AA88C
        BCLR    D1,$03CCFECD                    ; $2AA88E
        SUBI.W  #$0288,(A2)+                    ; $2AA894
        ORI.W  #$04B1,(A7)+                     ; $2AA898
        BSET    D1,-(A4)                        ; $2AA89C
        MOVE.W  $0C(PC,D0.W),-$30(A7,D0.W)      ; $2AA89E
        DC.W    $0004,$039E         ; $2AA8A4 ORI.B  #$039E,D4
        SUBI.B  #$FF71,-(A0)                    ; $2AA8A8
        SUBI.B  #$0146,(A7)+                    ; $2AA8AC
        MOVE.W  A0,-(A7)                        ; $2AA8B0
        BCHG    D1,$012C.W                      ; $2AA8B2
        MOVE.W  $1F(A6,D0.W),(A7)+              ; $2AA8B6
        DC.W    $02CE               ; $2AA8BA DC.W    $02CE
        DC.W    $FFE3               ; $2AA8BC MOVE.W  -(A3),<EA:3F>
        BSET    D1,D6                           ; $2AA8BE
        DC.W    $02E8               ; $2AA8C0 DC.W    $02E8
        DC.W    $FFF4,$03E4         ; $2AA8C2 MOVE.W  -$1C(A4,D0.W),<EA:3F>
        DC.W    $017D               ; $2AA8C6 BCHG    D0,<EA:3D>
        MOVE.W  A7,(A7)                         ; $2AA8C8
        DC.W    $038B               ; $2AA8CA BCLR    D1,A3
        BTST    D1,-(A0)                        ; $2AA8CC
        MOVE.W  #$0307,$0032(A7)                ; $2AA8CE
        MOVE.W  A4,-(A7)                        ; $2AA8D4
        DC.W    $02B5,$0082,$FF17,$03CE; $2AA8D6 ANDI.L  #$0082FF17,-$32(A5,D0.W)
        BCLR    D0,-$0100(A3)                   ; $2AA8DE
        SUBI.B  #$015B,-(A1)                    ; $2AA8E2
        MOVE.W  -$24(A4,D0.W),(A7)+             ; $2AA8E6
        ORI.W  #$FEB5,(A4)                      ; $2AA8EA
        BSET    D1,$7D(A6,D0.W)                 ; $2AA8EE
        MOVE.W  (A5)+,(A7)                      ; $2AA8F2
        BTST    D1,-$02(A2,A7.L)                ; $2AA8F4
        MOVE.W  $031A(PC),D7                    ; $2AA8F8
        DC.W    $FFC8               ; $2AA8FC MOVE.W  A0,<EA:3F>
        MOVEA.W D2,A7                           ; $2AA8FE
        ANDI.L  #$0021FF31,(A0)+                ; $2AA900
        DC.W    $02BD,$0076,$FF24   ; $2AA906 ANDI.L  #$0076FF24,<EA:3D>
        BCLR    D1,-$53(A0,D0.W)                ; $2AA90C
        MOVE.W  $03F6(A4),-$73(A7,D0.W)         ; $2AA910
        ORI.W  #$0538,D2                        ; $2AA916
        BCHG    D0,(A7)+                        ; $2AA91A
        MOVE.W  $04F0(A7),$017D(A7)             ; $2AA91C
        MOVE.W  (A0)+,(A7)+                     ; $2AA922
        SUBI.B  #$0306,(A4)+                    ; $2AA924
        DC.W    $FFD0               ; $2AA928 MOVE.W  (A0),<EA:3F>
        BCHG    D2,(A5)+                        ; $2AA92A
        BSET    D0,(A7)                         ; $2AA92C
        MOVE.W  #$0503,(A7)+                    ; $2AA92E
        DC.W    $018D               ; $2AA932 BCLR    D0,A5
        MOVE.W  (A0),(A7)+                      ; $2AA934
        DC.W    $04ED               ; $2AA936 DC.W    $04ED
        BSET    D0,(A1)+                        ; $2AA938
        MOVE.W  -(A4),-(A7)                     ; $2AA93A
        BCHG    D2,$00C7(A7)                    ; $2AA93C
        DC.W    $0038,$0585,$007B   ; $2AA940 ORI.B  #$0585,$007B.W
        DC.W    $FFE5               ; $2AA946 MOVE.W  -(A5),<EA:3F>
        DC.W    $054F               ; $2AA948 BCHG    D2,A7
        DC.W    $01CC               ; $2AA94A BSET    D0,A4
        MOVE.W  $05D1(A2),(A7)+                 ; $2AA94C
        DC.W    $00BB,$FFFE,$0656,$0095; $2AA950 ORI.L  #$FFFE0656,-$6B(PC,D0.W)
        MOVE.W  (A7),$56(A7,D0.W)               ; $2AA958
        ORI.W  #$FF97,(A2)+                     ; $2AA95C
        BCHG    D2,$005A(A0)                    ; $2AA960
        DC.W    $0037,$0568,$00B7   ; $2AA964 ORI.B  #$0568,-$49(A7,D0.W)
        DC.W    $0037,$0010,$0500   ; $2AA96A ORI.B  #$0010,$00(A7,D0.W)
        ANDI.W  #$0270,-(A0)                    ; $2AA970
        ANDI.L  #$02900210,D0                   ; $2AA974
        ADDI.B  #$0310,D0                       ; $2AA97A
        BTST    D1,D0                           ; $2AA97E
        SUBI.B  #$0500,(A0)                     ; $2AA980
        BCHG    D1,(A0)                         ; $2AA984
        BCHG    D1,D0                           ; $2AA986
        SUBI.B  #$0600,(A0)                     ; $2AA988
        BTST    D1,$20(A0,D0.W)                 ; $2AA98C
        SUBI.B  #$0500,(A0)                     ; $2AA990
        DC.W    $02C0               ; $2AA994 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2AA996 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2AA99E DC.W    $02D0
        DC.W    $0210,$0600         ; $2AA9A0 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2AA9A4
        BTST    D2,D0                           ; $2AA9AA
        DC.W    $02F0               ; $2AA9AC DC.W    $02F0
        DC.W    $02E0               ; $2AA9AE DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2AA9B0
        BCHG    D1,(A0)                         ; $2AA9B4
        BTST    D1,(A0)                         ; $2AA9B6
        DC.W    $0210,$0300         ; $2AA9B8 ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2AA9BC
        ADDI.B  #$0270,D0                       ; $2AA9C2
        DC.W    $02E0               ; $2AA9C6 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2AA9C8
        ANDI.W  #$0300,-(A0)                    ; $2AA9CC
        DC.W    $0210,$0300         ; $2AA9D0 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2AA9D4
        ANDI.L  #$04100300,-(A0)                ; $2AA9D6
        BTST    D1,-(A0)                        ; $2AA9DC
        DC.W    $02B0,$0010,$6E00,$0000; $2AA9DE ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2AA9E6 ORI.B  #$0020,(A0)
loc_2AA9EA:
        DC.W    $0030,$0610,$6F00   ; $2AA9EA ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AA9F0
        SUBI.B  #$7000,(A0)                     ; $2AA9F4
        ORI.W  #$0070,-(A0)                     ; $2AA9F8
        SUBI.B  #$6F00,(A0)                     ; $2AA9FC
        DC.W    $0000,$0030         ; $2AAA00 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AAA04 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AAA08 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AAA0C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AAA10
        DC.W    $00B0,$0210,$0400,$00D0; $2AAA16 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AAA1E DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AAA20
        ORI.L  #$00900611,-(A0)                 ; $2AAA24
        BTST    D3,D1                           ; $2AAA2A
        DC.W    $00B0,$0010,$6A00,$00E0; $2AAA2C ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AAA34 DC.W    $00F0
        BTST    D0,D0                           ; $2AAA36
        BTST    D0,(A0)                         ; $2AAA38
        DC.W    $0210,$6C00         ; $2AAA3A ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AAA3E
        SUBI.B  #$6B00,(A0)                     ; $2AAA42
        BTST    D0,D0                           ; $2AAA46
        DC.W    $00F0               ; $2AAA48 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AAA4A ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AAA4E DC.W    $00E0
        DC.W    $0010,$6300         ; $2AAA50 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AAA54
        BCHG    D0,(A0)                         ; $2AAA56
        BCHG    D0,-(A0)                        ; $2AAA58
        BCHG    D0,$10(A0,D0.W)                 ; $2AAA5A
loc_2AAA5E:
        BCS.W  loc_2AABF0                       ; $2AAA5E
        BCLR    D0,D0                           ; $2AAA62
        SUBI.B  #$6400,(A0)                     ; $2AAA64
        BCHG    D0,-(A0)                        ; $2AAA68
        BCHG    D0,(A0)                         ; $2AAA6A
        ADDI.B  #$6201,(A1)                     ; $2AAA6C
        BCHG    D0,$10(A0,D0.W)                 ; $2AAA70
        BPL.W  loc_2AAC16                       ; $2AAA74
        BCLR    D0,-$40(A0,D0.W)                ; $2AAA78
        BSET    D0,(A0)                         ; $2AAA7C
        DC.W    $0210,$6C00         ; $2AAA7E ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AAA82
        SUBI.B  #$6B00,(A0)                     ; $2AAA86
        BSET    D0,D0                           ; $2AAA8A
        BCLR    D0,$11(A0,D0.W)                 ; $2AAA8C
        BVS.S  loc_2AAA93                       ; $2AAA90
        BSET    D0,(A0)                         ; $2AAA92
        DC.W    $0010,$6300         ; $2AAA94 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AAA98 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AAA9C ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AAAA0 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AAAA4
        SUBI.B  #$6400,(A0)                     ; $2AAAA8
        DC.W    $0220,$0210         ; $2AAAAC ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AAAB0 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AAAB4 ANDI.B  #$0010,D0
        BNE.W  loc_2AAE1A                       ; $2AAAB8
        BCHG    D1,-$80(A0,D0.W)                ; $2AAABC
        BCLR    D1,(A0)                         ; $2AAAC0
        ADDI.B  #$6700,(A0)                     ; $2AAAC2
        BCLR    D1,-(A0)                        ; $2AAAC6
        BCLR    D1,$10(A0,D0.W)                 ; $2AAAC8
        BVC.W  loc_2AAE8E                       ; $2AAACC
        BSET    D1,(A0)                         ; $2AAAD0
        SUBI.B  #$6700,(A0)                     ; $2AAAD2
        BCHG    D1,-(A0)                        ; $2AAAD6
        BCLR    D1,(A0)                         ; $2AAAD8
        DC.W    $0010,$0300         ; $2AAADA ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AAADE
        BSET    D1,$00(A0,D0.W)                 ; $2AAAE0
        SUBI.B  #$0210,(A0)                     ; $2AAAE4
        BTST    D2,D0                           ; $2AAAE8
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AAAEA
        SUBI.B  #$0400,D0                       ; $2AAAF0
        BSET    D1,$10(A0,D0.W)                 ; $2AAAF4
        BCS.W  loc_2AAF3A                       ; $2AAAF8
        SUBI.W  #$0460,(A0)                     ; $2AAAFC
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AAB00
        SUBI.L  #$04800410,(A0)                 ; $2AAB06
        BCC.W  loc_2AAF6E                       ; $2AAB0C
        SUBI.W  #$0010,(A0)                     ; $2AAB10
        BTST    D1,D0                           ; $2AAB14
        DC.W    $04E0               ; $2AAB16 DC.W    $04E0
        DC.W    $04F0               ; $2AAB18 DC.W    $04F0
        BTST    D2,D0                           ; $2AAB1A
        BTST    D2,(A0)                         ; $2AAB1C
        DC.W    $0210,$0500         ; $2AAB1E ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2AAB22
        SUBI.B  #$0400,(A0)                     ; $2AAB26
        BTST    D2,D0                           ; $2AAB2A
        DC.W    $04F0               ; $2AAB2C DC.W    $04F0
        DC.W    $0010,$6500         ; $2AAB2E ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2AAB32
        BCHG    D2,(A0)                         ; $2AAB34
        BCHG    D2,-(A0)                        ; $2AAB36
        BCHG    D2,$10(A0,D0.W)                 ; $2AAB38
        BLS.W  loc_2AB0CE                       ; $2AAB3C
        BCLR    D2,D0                           ; $2AAB40
        SUBI.B  #$6400,(A0)                     ; $2AAB42
        BCHG    D2,-(A0)                        ; $2AAB46
        BCHG    D2,(A0)                         ; $2AAB48
        DC.W    $0000,$6600         ; $2AAB4A ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AAB4E
        DC.W    $04D0               ; $2AAB54 DC.W    $04D0
        DC.W    $0000,$6600         ; $2AAB56 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2AAB5A
        BCLR    D2,-$40(A0,D0.W)                ; $2AAB5C
        BSET    D2,(A0)                         ; $2AAB60
        CMPI.B  #$005E,D0                       ; $2AAB62
        ORI.W  #$0309,(A6)+                     ; $2AAB66
        BCLR    D1,D2                           ; $2AAB6A
        MOVE.W  $18(A3,D0.W),(A7)+              ; $2AAB6C
        BCHG    D1,-$016D(A3)                   ; $2AAB70
        BSET    D1,(A6)+                        ; $2AAB74
        SUBI.W  #$FD64,A6                       ; $2AAB76
        ANDI.L  #$046AFDD7,(A1)+                ; $2AAB7A
        SUBI.W  #$0403,A6                       ; $2AAB80
        MOVE.W  A1,-(A7)                        ; $2AAB84
        SUBI.B  #$0509,-(A0)                    ; $2AAB86
        DC.W    $FDF4,$0340         ; $2AAB8A MOVE.W  $40(A4,D0.W),<EA:3E>
        SUBI.B  #$FF69,(A1)+                    ; $2AAB8E
        DC.W    $02DC               ; $2AAB92 DC.W    $02DC
        BTST    D2,-(A4)                        ; $2AAB94
        MOVEA.W -(A7),A7                        ; $2AAB96
        BTST    D1,(A6)                         ; $2AAB98
        BTST    D2,(A2)                         ; $2AAB9A
        MOVE.W  -(A2),D7                        ; $2AAB9C
        DC.W    $033E               ; $2AAB9E BTST    D1,<EA:3E>
        SUBI.W  #$FDAC,$08(A6,D0.W)             ; $2AABA0
        BTST    D2,(A5)+                        ; $2AABA6
        MOVE.W  $02EC(A5),(A6)+                 ; $2AABA8
        BCLR    D2,(A6)                         ; $2AABAC
        MOVE.W  A3,-$43(A6,D0.W)                ; $2AABAE
        BTST    D2,D4                           ; $2AABB2
        DC.W    $FDE7               ; $2AABB4 MOVE.W  -(A7),<EA:3E>
        BCLR    D1,(A2)                         ; $2AABB6
        DC.W    $0589               ; $2AABB8 BCLR    D2,A1
        MOVE.W  A7,$02B9(A6)                    ; $2AABBA
        DC.W    $04D2               ; $2AABBE DC.W    $04D2
        MOVE.W  $0271(A7),D7                    ; $2AABC0
        DC.W    $04C6               ; $2AABC4 DC.W    $04C6
        MOVE.W  A1,(A7)                         ; $2AABC6
        ANDI.W  #$0367,D1                       ; $2AABC8
        MOVE.W  -$7B(A0,D0.W),(A7)              ; $2AABCC
        BCHG    D1,(A4)                         ; $2AABD0
        MOVEA.W (A2)+,A7                        ; $2AABD2
        DC.W    $02E3               ; $2AABD4 DC.W    $02E3
        DC.W    $04D9               ; $2AABD6 DC.W    $04D9
        MOVE.W  (A5),(A7)                       ; $2AABD8
        DC.W    $02AF,$035A,$FEC0,$0296; $2AABDA ANDI.L  #$035AFEC0,$0296(A7)
        BCLR    D1,D7                           ; $2AABE2
        MOVE.W  (A1)+,(A7)                      ; $2AABE4
        ANDI.W  #$0370,(A0)+                    ; $2AABE6
        MOVE.W  A3,(A7)+                        ; $2AABEA
        BSET    D0,(A0)                         ; $2AABEC
        DC.W    $02B7,$FDCC,$01F1,$02A5; $2AABEE ANDI.L  #$FDCC01F1,-$5B(A7,D0.W)
        MOVE.W  -(A4),$029C(A6)                 ; $2AABF6
        BCHG    D1,D2                           ; $2AABFA
        MOVE.W  A0,(A7)+                        ; $2AABFC
        BSET    D0,$61(A7,D0.W)                 ; $2AABFE
        MOVE.W  (A3),$3B(A6,D0.W)               ; $2AAC02
        BTST    D1,$33(A7,A7.L)                 ; $2AAC06
        SUBI.L  #$034FFE46,-(A5)                ; $2AAC0A
        SUBI.W  #$0496,-$3E(A3,A7.L)            ; $2AAC10
loc_2AAC16:
        SUBI.B  #$049B,D5                       ; $2AAC16
        MOVE.W  -(A2),$59(A6,D0.W)              ; $2AAC1A
        BCHG    D1,-(A3)                        ; $2AAC1E
        MOVE.W  (A4),(A7)                       ; $2AAC20
        SUBI.B  #$04C7,-(A2)                    ; $2AAC22
        MOVE.W  D4,D7                           ; $2AAC26
        BSET    D1,$02EC(A6)                    ; $2AAC28
        MOVE.W  D6,-(A6)                        ; $2AAC2C
        SUBI.W  #$02E0,A3                       ; $2AAC2E
        MOVE.W  D0,$04AB(A6)                    ; $2AAC32
        BCHG    D1,(A6)                         ; $2AAC36
        MOVEA.W $62(A4,D0.W),A7                 ; $2AAC38
        BCHG    D1,$7C(PC,A7.L)                 ; $2AAC3C
        BSET    D1,$029D.W                      ; $2AAC40
        MOVE.W  -(A0),-(A6)                     ; $2AAC44
        SUBI.W  #$032D,-$0169(A4)               ; $2AAC46
        BCHG    D0,$0235(A6)                    ; $2AAC4C
        MOVE.W  (A2)+,-(A6)                     ; $2AAC50
        BCHG    D0,-(A2)                        ; $2AAC52
        BTST    D1,$08(A3,A7.L)                 ; $2AAC54
        BSET    D0,$52(A1,D0.W)                 ; $2AAC58
        MOVEA.W (A6)+,A7                        ; $2AAC5C
        DC.W    $01FD               ; $2AAC5E BSET    D0,<EA:3D>
        ANDI.W  #$FE70,(A4)                     ; $2AAC60
        DC.W    $02EA               ; $2AAC64 DC.W    $02EA
        BSET    D1,-$03AE(A4)                   ; $2AAC66
        BCLR    D1,(A0)+                        ; $2AAC6A
        BTST    D1,#$FC1A                       ; $2AAC6C
        SUBI.B  #$035C,-(A7)                    ; $2AAC70
        MOVE.W  $79(A0,D0.W),$040C(A6)          ; $2AAC74
        MOVE.W  $0200(A0),-$18(A6,D0.W)         ; $2AAC7A
        MOVE.W  -$71(A5,D0.W),(A6)              ; $2AAC80
        SUBI.B  #$FE0C,A0                       ; $2AAC84
        DC.W    $021C,$0185         ; $2AAC88 ANDI.B  #$0185,(A4)+
        MOVE.W  -(A2),(A6)+                     ; $2AAC8C
        DC.W    $02AC,$01A4,$FE38,$03A4; $2AAC8E ANDI.L  #$01A4FE38,$03A4(A4)
        DC.W    $023E,$FC2D         ; $2AAC96 ANDI.B  #$FC2D,<EA:3E>
        SUBI.B  #$025E,-$7D(A4,A7.L)            ; $2AAC9A
        BTST    D1,D7                           ; $2AACA0
        DC.W    $0189               ; $2AACA2 BCLR    D0,A1
        DC.W    $FC7E               ; $2AACA4 MOVEA.W <EA:3E>,A6
        BCLR    D1,(A6)                         ; $2AACA6
        BCLR    D0,-$022B(A0)                   ; $2AACA8
        BCHG    D1,(A7)+                        ; $2AACAC
        ANDI.W  #$FFF5,(A6)                     ; $2AACAE
        SUBI.L  #$025DFF5D,(A5)+                ; $2AACB2
        SUBI.B  #$038A,A7                       ; $2AACB8
        MOVE.W  A1,(A7)                         ; $2AACBC
        DC.W    $030A               ; $2AACBE BTST    D1,A2
        BCLR    D1,D5                           ; $2AACC0
        MOVE.W  D6,-(A7)                        ; $2AACC2
        DC.W    $04D9               ; $2AACC4 DC.W    $04D9
        DC.W    $02D3               ; $2AACC6 DC.W    $02D3
        DC.W    $FFDE               ; $2AACC8 MOVE.W  (A6)+,<EA:3F>
        SUBI.W  #$0401,A2                       ; $2AACCA
        MOVE.W  A2,-(A7)                        ; $2AACCE
        BCLR    D1,(A1)+                        ; $2AACD0
        DC.W    $02CC               ; $2AACD2 DC.W    $02CC
        ORI.W  #$0344,-$05(A5,D0.W)             ; $2AACD4
        MOVE.W  D7,-$79(A7,D0.W)                ; $2AACDA
        DC.W    $0149               ; $2AACDE BCHG    D0,A1
        MOVE.W  -$07(A5,D0.W),(A7)+             ; $2AACE0
        DC.W    $0148               ; $2AACE4 BCHG    D0,A0
        MOVE.W  (A2),$039C(A7)                  ; $2AACE6
        DC.W    $02C7               ; $2AACEA DC.W    $02C7
        ORI.W  #$042B,(A1)                      ; $2AACEC
        DC.W    $02C9               ; $2AACF0 DC.W    $02C9
        DC.W    $FFF5,$031A         ; $2AACF2 MOVE.W  $1A(A5,D0.W),<EA:3F>
        BCLR    D0,(A2)+                        ; $2AACF6
        MOVE.W  D2,(A7)+                        ; $2AACF8
        DC.W    $03BE               ; $2AACFA BCLR    D1,<EA:3E>
        BTST    D1,(A2)+                        ; $2AACFC
        DC.W    $FFC2               ; $2AACFE MOVE.W  D2,<EA:3F>
        ANDI.L  #$0070FFBF,D1                   ; $2AAD00
        ANDI.W  #$00CC,-(A0)                    ; $2AAD06
        DC.W    $FFFC,$035E         ; $2AAD0A MOVE.W  #$035E,<EA:3F>
        BCLR    D0,$1F(A7,A7.L)                 ; $2AAD0E
        DC.W    $037E               ; $2AAD12 BCHG    D1,<EA:3E>
        BCHG    D0,(A3)+                        ; $2AAD14
        MOVE.W  -(A3),(A7)+                     ; $2AAD16
        DC.W    $0230,$00A4,$FF9B   ; $2AAD18 ANDI.B  #$00A4,-$65(A0,A7.L)
        BTST    D1,$0190(A6)                    ; $2AAD1E
        DC.W    $FEBE               ; $2AAD22 MOVE.W  <EA:3E>,(A7)
        BSET    D0,(A0)                         ; $2AAD24
        ORI.L  #$FF1701D0,A6                    ; $2AAD26
        ORI.W  #$FF17,(A2)                      ; $2AAD2C
        ANDI.W  #$0052,$01(A5,D0.W)             ; $2AAD30
        ANDI.W  #$00B0,$01(A5,D0.W)             ; $2AAD36
        BSET    D1,#$02F5                       ; $2AAD3C
        DC.W    $FFC5               ; $2AAD40 MOVE.W  D5,<EA:3F>
        SUBI.L  #$02A5000B,D1                   ; $2AAD42
        SUBI.W  #$0133,A1                       ; $2AAD48
        MOVE.W  (A0),(A7)+                      ; $2AAD4C
        BSET    D1,D4                           ; $2AAD4E
        BCLR    D0,D3                           ; $2AAD50
        MOVE.W  A3,(A7)                         ; $2AAD52
        DC.W    $047D,$0313         ; $2AAD54 SUBI.W  #$0313,<EA:3D>
        MOVE.W  A2,$45(A7,D0.W)                 ; $2AAD58
        BCLR    D0,-(A1)                        ; $2AAD5C
        MOVEA.W A7,A7                           ; $2AAD5E
        BSET    D1,(A0)                         ; $2AAD60
        DC.W    $0189               ; $2AAD62 BCLR    D0,A1
        MOVEA.W $17(A5,D0.W),A7                 ; $2AAD64
        DC.W    $01CB               ; $2AAD68 BSET    D0,A3
        MOVE.W  -$48(A3,D0.W),(A7)              ; $2AAD6A
        DC.W    $007C,$FF64,$0471   ; $2AAD6E ORI.W  #$FF64,#$0471
        DC.W    $003A,$FF25,$042D   ; $2AAD74 ORI.B  #$FF25,$042D(PC)
        BCLR    D0,(A6)+                        ; $2AAD7A
        MOVEA.W A3,A7                           ; $2AAD7C
        DC.W    $04CC               ; $2AAD7E DC.W    $04CC
        ORI.W  #$FEFB,(A0)                      ; $2AAD80
        DC.W    $04AC,$0042,$FE51,$04AC; $2AAD84 SUBI.L  #$0042FE51,$04AC(A4)
        DC.W    $0007,$FE51         ; $2AAD8C ORI.B  #$FE51,D7
        DC.W    $04B1,$0007,$FF70,$04B1; $2AAD90 SUBI.L  #$0007FF70,-$4F(A1,D0.W)
        ORI.W  #$FF70,-(A4)                     ; $2AAD98
        DC.W    $0010,$0500         ; $2AAD9C ORI.B  #$0500,(A0)
        ANDI.W  #$0270,-(A0)                    ; $2AADA0
        ANDI.L  #$02900210,D0                   ; $2AADA4
        ADDI.B  #$0310,D0                       ; $2AADAA
        BTST    D1,D0                           ; $2AADAE
        SUBI.B  #$0500,(A0)                     ; $2AADB0
        BCHG    D1,(A0)                         ; $2AADB4
        BCHG    D1,D0                           ; $2AADB6
        SUBI.B  #$0600,(A0)                     ; $2AADB8
        BTST    D1,$20(A0,D0.W)                 ; $2AADBC
        SUBI.B  #$0500,(A0)                     ; $2AADC0
        DC.W    $02C0               ; $2AADC4 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2AADC6 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2AADCE DC.W    $02D0
        DC.W    $0210,$0600         ; $2AADD0 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2AADD4
        BTST    D2,D0                           ; $2AADDA
        DC.W    $02F0               ; $2AADDC DC.W    $02F0
        DC.W    $02E0               ; $2AADDE DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2AADE0
        BCHG    D1,(A0)                         ; $2AADE4
        BTST    D1,(A0)                         ; $2AADE6
        DC.W    $0210,$0300         ; $2AADE8 ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2AADEC
        ADDI.B  #$0270,D0                       ; $2AADF2
        DC.W    $02E0               ; $2AADF6 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2AADF8
        ANDI.W  #$0300,-(A0)                    ; $2AADFC
        DC.W    $0210,$0300         ; $2AAE00 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2AAE04
        ANDI.L  #$04100300,-(A0)                ; $2AAE06
        BTST    D1,-(A0)                        ; $2AAE0C
        DC.W    $02B0,$0010,$6E00,$0000; $2AAE0E ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2AAE16 ORI.B  #$0020,(A0)
loc_2AAE1A:
        DC.W    $0030,$0610,$6F00   ; $2AAE1A ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AAE20
        SUBI.B  #$7000,(A0)                     ; $2AAE24
        ORI.W  #$0070,-(A0)                     ; $2AAE28
        SUBI.B  #$6F00,(A0)                     ; $2AAE2C
        DC.W    $0000,$0030         ; $2AAE30 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AAE34 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AAE38 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AAE3C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AAE40
        DC.W    $00B0,$0210,$0400,$00D0; $2AAE46 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AAE4E DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AAE50
        ORI.L  #$00900611,-(A0)                 ; $2AAE54
        BTST    D3,D1                           ; $2AAE5A
        DC.W    $00B0,$0010,$6A00,$00E0; $2AAE5C ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AAE64 DC.W    $00F0
        BTST    D0,D0                           ; $2AAE66
        BTST    D0,(A0)                         ; $2AAE68
        DC.W    $0210,$6C00         ; $2AAE6A ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AAE6E
        SUBI.B  #$6B00,(A0)                     ; $2AAE72
        BTST    D0,D0                           ; $2AAE76
        DC.W    $00F0               ; $2AAE78 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AAE7A ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AAE7E DC.W    $00E0
        DC.W    $0010,$6300         ; $2AAE80 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AAE84
        BCHG    D0,(A0)                         ; $2AAE86
        BCHG    D0,-(A0)                        ; $2AAE88
        BCHG    D0,$10(A0,D0.W)                 ; $2AAE8A
loc_2AAE8E:
        BCS.W  loc_2AB020                       ; $2AAE8E
        BCLR    D0,D0                           ; $2AAE92
        SUBI.B  #$6400,(A0)                     ; $2AAE94
        BCHG    D0,-(A0)                        ; $2AAE98
        BCHG    D0,(A0)                         ; $2AAE9A
        ADDI.B  #$6201,(A1)                     ; $2AAE9C
        BCHG    D0,$10(A0,D0.W)                 ; $2AAEA0
        BPL.W  loc_2AB046                       ; $2AAEA4
        BCLR    D0,-$40(A0,D0.W)                ; $2AAEA8
        BSET    D0,(A0)                         ; $2AAEAC
        DC.W    $0210,$6C00         ; $2AAEAE ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AAEB2
        SUBI.B  #$6B00,(A0)                     ; $2AAEB6
        BSET    D0,D0                           ; $2AAEBA
        BCLR    D0,$11(A0,D0.W)                 ; $2AAEBC
        BVS.S  loc_2AAEC3                       ; $2AAEC0
        BSET    D0,(A0)                         ; $2AAEC2
        DC.W    $0010,$6300         ; $2AAEC4 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AAEC8 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AAECC ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AAED0 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AAED4
        SUBI.B  #$6400,(A0)                     ; $2AAED8
        DC.W    $0220,$0210         ; $2AAEDC ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AAEE0 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AAEE4 ANDI.B  #$0010,D0
        BNE.W  loc_2AB24A                       ; $2AAEE8
        BCHG    D1,-$80(A0,D0.W)                ; $2AAEEC
        BCLR    D1,(A0)                         ; $2AAEF0
        ADDI.B  #$6700,(A0)                     ; $2AAEF2
        BCLR    D1,-(A0)                        ; $2AAEF6
        BCLR    D1,$10(A0,D0.W)                 ; $2AAEF8
        BVC.W  loc_2AB2BE                       ; $2AAEFC
        BSET    D1,(A0)                         ; $2AAF00
        SUBI.B  #$6700,(A0)                     ; $2AAF02
        BCHG    D1,-(A0)                        ; $2AAF06
        BCLR    D1,(A0)                         ; $2AAF08
        DC.W    $0010,$0300         ; $2AAF0A ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AAF0E
        BSET    D1,$00(A0,D0.W)                 ; $2AAF10
        SUBI.B  #$0210,(A0)                     ; $2AAF14
        BTST    D2,D0                           ; $2AAF18
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AAF1A
        SUBI.B  #$0400,D0                       ; $2AAF20
        BSET    D1,$10(A0,D0.W)                 ; $2AAF24
        BCS.W  loc_2AB36A                       ; $2AAF28
        SUBI.W  #$0460,(A0)                     ; $2AAF2C
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AAF30
        SUBI.L  #$04800410,(A0)                 ; $2AAF36
        BCC.W  loc_2AB39E                       ; $2AAF3C
        SUBI.W  #$0010,(A0)                     ; $2AAF40
        BTST    D1,D0                           ; $2AAF44
        DC.W    $04E0               ; $2AAF46 DC.W    $04E0
        DC.W    $04F0               ; $2AAF48 DC.W    $04F0
        BTST    D2,D0                           ; $2AAF4A
        BTST    D2,(A0)                         ; $2AAF4C
        DC.W    $0210,$0500         ; $2AAF4E ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2AAF52
        SUBI.B  #$0400,(A0)                     ; $2AAF56
        BTST    D2,D0                           ; $2AAF5A
        DC.W    $04F0               ; $2AAF5C DC.W    $04F0
        DC.W    $0010,$6500         ; $2AAF5E ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2AAF62
        BCHG    D2,(A0)                         ; $2AAF64
        BCHG    D2,-(A0)                        ; $2AAF66
        BCHG    D2,$10(A0,D0.W)                 ; $2AAF68
        BLS.W  loc_2AB4FE                       ; $2AAF6C
        BCLR    D2,D0                           ; $2AAF70
        SUBI.B  #$6400,(A0)                     ; $2AAF72
        BCHG    D2,-(A0)                        ; $2AAF76
        BCHG    D2,(A0)                         ; $2AAF78
        DC.W    $0000,$6600         ; $2AAF7A ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AAF7E
        DC.W    $04D0               ; $2AAF84 DC.W    $04D0
        DC.W    $0000,$6600         ; $2AAF86 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2AAF8A
        BCLR    D2,-$40(A0,D0.W)                ; $2AAF8C
        BSET    D2,(A0)                         ; $2AAF90
        CMPI.B  #$005E,D0                       ; $2AAF92
        ORI.W  #$025A,(A6)+                     ; $2AAF96
        BTST    D1,$3C(A2,D0.W)                 ; $2AAF9A
        BCHG    D1,D7                           ; $2AAF9E
        DC.W    $02F0               ; $2AAFA0 DC.W    $02F0
        MOVE.W  -(A6),-$40(A7,D0.W)             ; $2AAFA2
        BCLR    D1,D0                           ; $2AAFA6
        MOVEA.W (A5)+,A7                        ; $2AAFA8
        BCLR    D0,-(A4)                        ; $2AAFAA
        DC.W    $03CD               ; $2AAFAC BSET    D1,A5
        MOVE.W  (A1),-(A7)                      ; $2AAFAE
        BCLR    D1,(A1)+                        ; $2AAFB0
        BCLR    D1,(A5)+                        ; $2AAFB2
        DC.W    $FFDD               ; $2AAFB4 MOVE.W  (A5)+,<EA:3F>
        BTST    D1,-(A5)                        ; $2AAFB6
        SUBI.W  #$FE9F,(A3)                     ; $2AAFB8
        DC.W    $02AD,$03DF,$0072,$020A; $2AAFBC ANDI.L  #$03DF0072,$020A(A5)
        SUBI.L  #$FF530231,-(A2)                ; $2AAFC4
        SUBI.W  #$FF0B,$0238(PC)                ; $2AAFCA
        BSET    D1,D3                           ; $2AAFD0
        MOVE.W  #$01D3,(A7)                     ; $2AAFD2
        SUBI.B  #$FDEB,-$20(A6,D0.W)            ; $2AAFD6
        DC.W    $04D6               ; $2AAFDC DC.W    $04D6
        MOVEA.W -(A4),A7                        ; $2AAFDE
        DC.W    $02C2               ; $2AAFE0 DC.W    $02C2
        SUBI.W  #$FEAE,(A2)                     ; $2AAFE2
        ANDI.W  #$04AD,$08(A2,A7.L)             ; $2AAFE6
        BSET    D0,(A7)+                        ; $2AAFEC
        SUBI.W  #$FF45,(A0)+                    ; $2AAFEE
        BCLR    D0,$0458(A4)                    ; $2AAFF2
        MOVE.W  $0183(A5),$03(A7,D0.W)          ; $2AAFF6
        DC.W    $0009,$01B3         ; $2AAFFC ORI.B  #$01B3,A1
        DC.W    $02E3               ; $2AB000 DC.W    $02E3
        MOVE.W  $021D(A2),$68(A7,D0.W)          ; $2AB002
        MOVE.W  (A7)+,-$0F(A7,D0.W)             ; $2AB008
        DC.W    $02F3               ; $2AB00C DC.W    $02F3
        DC.W    $0003,$01D4         ; $2AB00E ORI.B  #$01D4,D3
        BTST    D1,(A4)+                        ; $2AB012
        DC.W    $FFE3               ; $2AB014 MOVE.W  -(A3),<EA:3F>
        BCLR    D0,(A7)+                        ; $2AB016
        DC.W    $030C               ; $2AB018 BTST    D1,A4
        DC.W    $001F,$00E0         ; $2AB01A ORI.B  #$00E0,(A7)+
        ANDI.W  #$FF4B,(A0)                     ; $2AB01E
        DC.W    $00EB               ; $2AB022 DC.W    $00EB
        DC.W    $0238,$FEDF,$01E0   ; $2AB024 ANDI.B  #$FEDF,$01E0.W
        DC.W    $02DA               ; $2AB02A DC.W    $02DA
        DC.W    $0013,$00F7         ; $2AB02C ORI.B  #$00F7,(A3)
        BSET    D0,$10(A4,A7.L)                 ; $2AB030
        BTST    D1,(A6)+                        ; $2AB034
        ANDI.W  #$FECD,-$74(A7,D0.W)            ; $2AB036
        ANDI.L  #$FEDA0372,D3                   ; $2AB03C
        BSET    D1,(A6)+                        ; $2AB042
        MOVE.W  A6,(A7)                         ; $2AB044
loc_2AB046:
        BTST    D1,D3                           ; $2AB046
        BSET    D1,$7B(A2,A7.L)                 ; $2AB048
        DC.W    $0348               ; $2AB04C BCHG    D1,A0
        ANDI.L  #$FF31032D,(A0)                 ; $2AB04E
        SUBI.B  #$FEDF,A3                       ; $2AB054
        DC.W    $02BB,$02F2,$FDB5,$0315; $2AB058 ANDI.L  #$02F2FDB5,$15(PC,D0.W)
        DC.W    $02B8,$FDD4,$0396,$0271; $2AB060 ANDI.L  #$FDD40396,$0271.W
        MOVE.W  A3,-(A7)                        ; $2AB068
        BCHG    D1,(A1)+                        ; $2AB06A
        ANDI.L  #$FF2E02B4,(A4)+                ; $2AB06C
        ANDI.L  #$FDA50350,-(A0)                ; $2AB072
        ANDI.W  #$FF1E,A2                       ; $2AB078
        DC.W    $002E,$023B,$FE2A   ; $2AB07C ORI.B  #$023B,-$01D6(A6)
        DC.W    $0034,$0339,$FE2D   ; $2AB082 ORI.B  #$0339,$2D(A4,A7.L)
        BTST    D0,D2                           ; $2AB088
        BTST    D1,$64(A1,A7.L)                 ; $2AB08A
        DC.W    $00FB               ; $2AB08E DC.W    $00FB
        DC.W    $0233,$FF61,$01A1   ; $2AB090 ANDI.B  #$FF61,-$5F(A3,D0.W)
        BSET    D1,-(A7)                        ; $2AB096
        DC.W    $FD3F               ; $2AB098 MOVE.W  <EA:3F>,-(A6)
        DC.W    $0233,$0331,$FCDA   ; $2AB09A ANDI.B  #$0331,-$26(A3,A7.L)
        BTST    D1,D1                           ; $2AB0A0
        BTST    D1,-(A7)                        ; $2AB0A2
        MOVE.W  (A0),D7                         ; $2AB0A4
        ANDI.W  #$03DF,-$018B(A7)               ; $2AB0A6
        DC.W    $00CD               ; $2AB0AC DC.W    $00CD
        BSET    D1,-$0235(A2)                   ; $2AB0AE
        BCLR    D0,(A3)+                        ; $2AB0B2
        BSET    D1,-(A2)                        ; $2AB0B4
        MOVE.W  D2,-(A7)                        ; $2AB0B6
        DC.W    $00BF,$0185,$FDC5   ; $2AB0B8 ORI.L  #$0185FDC5,<EA:3F>
        DC.W    $018D               ; $2AB0BE BCLR    D0,A5
        BCHG    D0,#$FEFB                       ; $2AB0C0
        DC.W    $022D,$0232,$FCD7   ; $2AB0C4 ANDI.B  #$0232,-$0329(A5)
        DC.W    $02FA               ; $2AB0CA DC.W    $02FA
        DC.W    $0229,$FE0E,$0193   ; $2AB0CC ANDI.B  #$FE0E,$0193(A1)
        BCLR    D0,D1                           ; $2AB0D2
        MOVE.W  $02610178,-(A6)                 ; $2AB0D4
        MOVEA.W $0308(A7),A7                    ; $2AB0DA
        DC.W    $0201,$0113         ; $2AB0DE ANDI.B  #$0113,D1
        BSET    D1,-(A0)                        ; $2AB0E2
        BSET    D0,-$0004(PC)                   ; $2AB0E4
        BTST    D1,(A6)                         ; $2AB0E8
        BTST    D1,-$7E(A7,A7.L)                ; $2AB0EA
        ANDI.W  #$033C,-(A5)                    ; $2AB0EE
        ORI.W  #$0457,-(A6)                     ; $2AB0F2
        ANDI.W  #$0054,$038D(A1)                ; $2AB0F6
        BCLR    D1,-(A5)                        ; $2AB0FC
        DC.W    $FFDB               ; $2AB0FE MOVE.W  (A3)+,<EA:3F>
        DC.W    $037E               ; $2AB100 BCHG    D1,<EA:3E>
        ANDI.W  #$016C,$02DC(A7)                ; $2AB102
        BCLR    D1,$00BF(A3)                    ; $2AB108
        ANDI.W  #$00F8,$6D(A3,D0.W)             ; $2AB10C
        DC.W    $0231,$011E,$0106   ; $2AB112 ANDI.B  #$011E,$06(A1,D0.W)
        BCLR    D1,D2                           ; $2AB118
        ANDI.W  #$0141,-$3C(PC,D0.W)            ; $2AB11A
        ANDI.W  #$00A9,(A7)                     ; $2AB120
        DC.W    $020B,$015E         ; $2AB124 ANDI.B  #$015E,A3
        ORI.W  #$035C,$02BB(A4)                 ; $2AB128
        DC.W    $00A8,$019C,$0028,$0158; $2AB12E ORI.L  #$019C0028,$0158(A0)
        BCLR    D0,(A6)+                        ; $2AB136
        ORI.W  #$01AC,$7C(A7,D0.W)              ; $2AB138
        BCHG    D0,-$44(A0,D0.W)                ; $2AB13E
        DC.W    $0279,$0120,$0068,$014F; $2AB142 ANDI.W  #$0120,$0068014F
        ORI.W  #$0158,$022E(A5)                 ; $2AB14A
        BCHG    D0,-(A6)                        ; $2AB150
        ORI.W  #$00E7,$002C(A1)                 ; $2AB152
        DC.W    $00DB               ; $2AB158 DC.W    $00DB
        DC.W    $00F0               ; $2AB15A DC.W    $00F0
        DC.W    $FFF2,$00DB         ; $2AB15C MOVE.W  -$25(A2,D0.W),<EA:3F>
        BCLR    D0,$12(A5,D0.W)                 ; $2AB160
        BCLR    D0,$01A5(A1)                    ; $2AB164
        ORI.W  #$01A9,$0370(A6)                 ; $2AB168
        ANDI.W  #$00AE,$0419(A1)                ; $2AB16E
        ANDI.W  #$00A6,(A7)                     ; $2AB174
        BSET    D1,-(A7)                        ; $2AB178
        BTST    D0,D5                           ; $2AB17A
        MOVE.W  A1,$033E(A7)                    ; $2AB17C
        BTST    D0,(A7)                         ; $2AB180
        MOVE.W  (A0),$03B5(A7)                  ; $2AB182
        DC.W    $02C0               ; $2AB186 DC.W    $02C0
        ORI.W  #$0382,A7                        ; $2AB188
        BCHG    D0,-$010E(A6)                   ; $2AB18C
        BTST    D1,#$0126                       ; $2AB190
        DC.W    $FF3D               ; $2AB194 MOVE.W  <EA:3D>,-(A7)
        BCLR    D1,D0                           ; $2AB196
        BCHG    D0,$FF6A04BF                    ; $2AB198
        ORI.W  #$FF65,$047C.W                   ; $2AB19E
        DC.W    $0026,$FF38         ; $2AB1A4 ORI.B  #$FF38,-(A6)
        BCHG    D1,$0164(A5)                    ; $2AB1A8
        MOVE.W  $04AD(PC),(A7)+                 ; $2AB1AC
        ORI.W  #$FEF5,-(A4)                     ; $2AB1B0
        SUBI.L  #$003AFE57,D2                   ; $2AB1B4
        SUBI.L  #$0000FE57,A4                   ; $2AB1BA
        DC.W    $04CB               ; $2AB1C0 DC.W    $04CB
        DC.W    $000C,$FF6E         ; $2AB1C2 ORI.B  #$FF6E,A4
        DC.W    $04BA,$0067,$FF6E,$0010; $2AB1C6 SUBI.L  #$0067FF6E,$0010(PC)
        BTST    D2,D0                           ; $2AB1CE
        ANDI.W  #$0270,-(A0)                    ; $2AB1D0
        ANDI.L  #$02900210,D0                   ; $2AB1D4
        ADDI.B  #$0310,D0                       ; $2AB1DA
        BTST    D1,D0                           ; $2AB1DE
        SUBI.B  #$0500,(A0)                     ; $2AB1E0
        BCHG    D1,(A0)                         ; $2AB1E4
        BCHG    D1,D0                           ; $2AB1E6
        SUBI.B  #$0600,(A0)                     ; $2AB1E8
        BTST    D1,$20(A0,D0.W)                 ; $2AB1EC
        SUBI.B  #$0500,(A0)                     ; $2AB1F0
        DC.W    $02C0               ; $2AB1F4 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2AB1F6 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2AB1FE DC.W    $02D0
        DC.W    $0210,$0600         ; $2AB200 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2AB204
        BTST    D2,D0                           ; $2AB20A
        DC.W    $02F0               ; $2AB20C DC.W    $02F0
        DC.W    $02E0               ; $2AB20E DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2AB210
        BCHG    D1,(A0)                         ; $2AB214
        BTST    D1,(A0)                         ; $2AB216
        DC.W    $0210,$0300         ; $2AB218 ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2AB21C
        ADDI.B  #$0270,D0                       ; $2AB222
        DC.W    $02E0               ; $2AB226 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2AB228
        ANDI.W  #$0300,-(A0)                    ; $2AB22C
        DC.W    $0210,$0300         ; $2AB230 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2AB234
        ANDI.L  #$04100300,-(A0)                ; $2AB236
        BTST    D1,-(A0)                        ; $2AB23C
        DC.W    $02B0,$0010,$6E00,$0000; $2AB23E ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2AB246 ORI.B  #$0020,(A0)
loc_2AB24A:
        DC.W    $0030,$0610,$6F00   ; $2AB24A ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AB250
        SUBI.B  #$7000,(A0)                     ; $2AB254
        ORI.W  #$0070,-(A0)                     ; $2AB258
        SUBI.B  #$6F00,(A0)                     ; $2AB25C
        DC.W    $0000,$0030         ; $2AB260 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AB264 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AB268 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AB26C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AB270
        DC.W    $00B0,$0210,$0400,$00D0; $2AB276 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AB27E DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AB280
        ORI.L  #$00900611,-(A0)                 ; $2AB284
        BTST    D3,D1                           ; $2AB28A
        DC.W    $00B0,$0010,$6A00,$00E0; $2AB28C ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AB294 DC.W    $00F0
        BTST    D0,D0                           ; $2AB296
        BTST    D0,(A0)                         ; $2AB298
        DC.W    $0210,$6C00         ; $2AB29A ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AB29E
        SUBI.B  #$6B00,(A0)                     ; $2AB2A2
        BTST    D0,D0                           ; $2AB2A6
        DC.W    $00F0               ; $2AB2A8 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AB2AA ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AB2AE DC.W    $00E0
        DC.W    $0010,$6300         ; $2AB2B0 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AB2B4
        BCHG    D0,(A0)                         ; $2AB2B6
        BCHG    D0,-(A0)                        ; $2AB2B8
        BCHG    D0,$10(A0,D0.W)                 ; $2AB2BA
loc_2AB2BE:
        BCS.W  loc_2AB450                       ; $2AB2BE
        BCLR    D0,D0                           ; $2AB2C2
        SUBI.B  #$6400,(A0)                     ; $2AB2C4
        BCHG    D0,-(A0)                        ; $2AB2C8
        BCHG    D0,(A0)                         ; $2AB2CA
        ADDI.B  #$6201,(A1)                     ; $2AB2CC
        BCHG    D0,$10(A0,D0.W)                 ; $2AB2D0
        BPL.W  loc_2AB476                       ; $2AB2D4
        BCLR    D0,-$40(A0,D0.W)                ; $2AB2D8
        BSET    D0,(A0)                         ; $2AB2DC
        DC.W    $0210,$6C00         ; $2AB2DE ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AB2E2
        SUBI.B  #$6B00,(A0)                     ; $2AB2E6
        BSET    D0,D0                           ; $2AB2EA
        BCLR    D0,$11(A0,D0.W)                 ; $2AB2EC
        BVS.S  loc_2AB2F3                       ; $2AB2F0
        BSET    D0,(A0)                         ; $2AB2F2
        DC.W    $0010,$6300         ; $2AB2F4 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AB2F8 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AB2FC ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AB300 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AB304
        SUBI.B  #$6400,(A0)                     ; $2AB308
        DC.W    $0220,$0210         ; $2AB30C ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AB310 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AB314 ANDI.B  #$0010,D0
        BNE.W  loc_2AB67A                       ; $2AB318
        BCHG    D1,-$80(A0,D0.W)                ; $2AB31C
        BCLR    D1,(A0)                         ; $2AB320
        ADDI.B  #$6700,(A0)                     ; $2AB322
        BCLR    D1,-(A0)                        ; $2AB326
        BCLR    D1,$10(A0,D0.W)                 ; $2AB328
        BVC.W  loc_2AB6EE                       ; $2AB32C
        BSET    D1,(A0)                         ; $2AB330
        SUBI.B  #$6700,(A0)                     ; $2AB332
        BCHG    D1,-(A0)                        ; $2AB336
        BCLR    D1,(A0)                         ; $2AB338
        DC.W    $0010,$0300         ; $2AB33A ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AB33E
        BSET    D1,$00(A0,D0.W)                 ; $2AB340
        SUBI.B  #$0210,(A0)                     ; $2AB344
        BTST    D2,D0                           ; $2AB348
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AB34A
        SUBI.B  #$0400,D0                       ; $2AB350
        BSET    D1,$10(A0,D0.W)                 ; $2AB354
        BCS.W  loc_2AB79A                       ; $2AB358
        SUBI.W  #$0460,(A0)                     ; $2AB35C
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AB360
        SUBI.L  #$04800410,(A0)                 ; $2AB366
        BCC.W  loc_2AB7CE                       ; $2AB36C
        SUBI.W  #$0010,(A0)                     ; $2AB370
        BTST    D1,D0                           ; $2AB374
        DC.W    $04E0               ; $2AB376 DC.W    $04E0
        DC.W    $04F0               ; $2AB378 DC.W    $04F0
        BTST    D2,D0                           ; $2AB37A
        BTST    D2,(A0)                         ; $2AB37C
        DC.W    $0210,$0500         ; $2AB37E ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2AB382
        SUBI.B  #$0400,(A0)                     ; $2AB386
        BTST    D2,D0                           ; $2AB38A
        DC.W    $04F0               ; $2AB38C DC.W    $04F0
        DC.W    $0010,$6500         ; $2AB38E ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2AB392
        BCHG    D2,(A0)                         ; $2AB394
        BCHG    D2,-(A0)                        ; $2AB396
        BCHG    D2,$10(A0,D0.W)                 ; $2AB398
        BLS.W  loc_2AB92E                       ; $2AB39C
        BCLR    D2,D0                           ; $2AB3A0
        SUBI.B  #$6400,(A0)                     ; $2AB3A2
        BCHG    D2,-(A0)                        ; $2AB3A6
        BCHG    D2,(A0)                         ; $2AB3A8
        DC.W    $0000,$6600         ; $2AB3AA ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AB3AE
        DC.W    $04D0               ; $2AB3B4 DC.W    $04D0
        DC.W    $0000,$6600         ; $2AB3B6 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2AB3BA
        BCLR    D2,-$40(A0,D0.W)                ; $2AB3BC
        BSET    D2,(A0)                         ; $2AB3C0
        CMPI.B  #$005E,D0                       ; $2AB3C2
        ORI.W  #$023A,(A6)+                     ; $2AB3C6
        ANDI.W  #$FFF3,$0310(A3)                ; $2AB3CA
        ANDI.W  #$FF33,-(A4)                    ; $2AB3D0
        DC.W    $0230,$02C2,$FE0A   ; $2AB3D4 ANDI.B  #$02C2,$0A(A0,A7.L)
        BTST    D0,$02CB(A7)                    ; $2AB3DA
        MOVE.W  $3D(A1,D0.W),(A7)+              ; $2AB3DE
        BTST    D1,-(A1)                        ; $2AB3E2
        MOVE.W  (A5)+,$0266(A7)                 ; $2AB3E4
        BCLR    D1,-$01C3(A4)                   ; $2AB3E8
        ANDI.W  #$0328,-(A6)                    ; $2AB3EC
        DC.W    $001C,$0165         ; $2AB3F0 ORI.B  #$0165,(A4)+
        BCLR    D1,$24(A5,A7.L)                 ; $2AB3F4
        BCLR    D0,D7                           ; $2AB3F8
        BCLR    D1,(A6)                         ; $2AB3FA
        MOVE.W  (A4),(A7)+                      ; $2AB3FC
        BCLR    D0,$02E4(A7)                    ; $2AB3FE
        MOVE.W  D3,(A7)                         ; $2AB402
        DC.W    $010B               ; $2AB404 BTST    D0,A3
        BTST    D1,-$37(A4,A7.L)                ; $2AB406
        BTST    D0,D6                           ; $2AB40A
        BSET    D1,(A4)                         ; $2AB40C
        MOVEA.W D1,A7                           ; $2AB40E
        DC.W    $020B,$0391         ; $2AB410 ANDI.B  #$0391,A3
        MOVEA.W (A6)+,A7                        ; $2AB414
        DC.W    $0189               ; $2AB416 BCLR    D0,A1
        DC.W    $03CF               ; $2AB418 BSET    D1,A7
        DC.W    $FDCA               ; $2AB41A MOVE.W  A2,<EA:3E>
        BCHG    D0,D5                           ; $2AB41C
        BTST    D1,-$00EF(A5)                   ; $2AB41E
        BTST    D0,-(A7)                        ; $2AB422
        BCHG    D1,(A0)                         ; $2AB424
        MOVE.W  $01A4(PC),$0259(A7)             ; $2AB426
        ORI.W  #$01CC,(A2)+                     ; $2AB42C
        DC.W    $021F,$0004         ; $2AB430 ANDI.B  #$0004,(A7)+
        BCLR    D0,D4                           ; $2AB434
        BCHG    D1,$FF42020C                    ; $2AB436
        ANDI.W  #$0036,$01E8(A4)                ; $2AB43C
        DC.W    $027C,$0020,$01C5   ; $2AB442 ANDI.W  #$0020,#$01C5
        ANDI.W  #$006A,$13(A1,D0.W)             ; $2AB448
        BCHG    D0,-$0010(A0)                   ; $2AB44E
        DC.W    $010F               ; $2AB452 BTST    D0,A7
        BTST    D0,$FF8C020C                    ; $2AB454
        ANDI.W  #$005A,A2                       ; $2AB45A
        BTST    D0,$07(A3,D0.W)                 ; $2AB45E
        DC.W    $FFC4               ; $2AB462 MOVE.W  D4,<EA:3F>
        DC.W    $02D9               ; $2AB464 DC.W    $02D9
        BSET    D0,-$57(A1,A7.L)                ; $2AB466
        BCHG    D1,D1                           ; $2AB46A
        DC.W    $020E,$FE8F         ; $2AB46C ANDI.B  #$FE8F,A6
        DC.W    $02C9               ; $2AB470 DC.W    $02C9
        BCHG    D1,D5                           ; $2AB472
        MOVE.W  (A1),D7                         ; $2AB474
loc_2AB476:
        ANDI.W  #$0344,(A7)                     ; $2AB476
        MOVE.W  -(A1),D7                        ; $2AB47A
        BTST    D1,(A0)+                        ; $2AB47C
        DC.W    $0226,$FEF3         ; $2AB47E ANDI.B  #$FEF3,-(A6)
        ANDI.L  #$037AFE6A,(A6)                 ; $2AB482
        DC.W    $0223,$017A         ; $2AB488 ANDI.B  #$017A,-(A3)
        DC.W    $FDC0               ; $2AB48C MOVE.W  D0,<EA:3E>
        ANDI.L  #$0179FDD0,(A1)                 ; $2AB48E
        BCHG    D1,(A7)                         ; $2AB494
        DC.W    $021A,$FEB6         ; $2AB496 ANDI.B  #$FEB6,(A2)+
        BTST    D1,(A4)                         ; $2AB49A
        DC.W    $023E,$FED7         ; $2AB49C ANDI.B  #$FED7,<EA:3E>
        DC.W    $023E,$0131         ; $2AB4A0 ANDI.B  #$0131,<EA:3E>
        DC.W    $FDDC               ; $2AB4A4 MOVE.W  (A4)+,<EA:3E>
        BTST    D1,$01F4(A7)                    ; $2AB4A6
        MOVE.W  $27(A3,D0.W),(A7)+              ; $2AB4AA
        DC.W    $001B,$FECB         ; $2AB4AE ORI.B  #$FECB,(A3)+
        DC.W    $FFC2               ; $2AB4B2 MOVE.W  D2,<EA:3F>
        DC.W    $00E8               ; $2AB4B4 DC.W    $00E8
        MOVEA.W (A5)+,A7                        ; $2AB4B6
        ORI.W  #$01C3,$52(A1,A7.L)              ; $2AB4B8
        DC.W    $00D8               ; $2AB4BE DC.W    $00D8
        DC.W    $00F6               ; $2AB4C0 DC.W    $00F6
        DC.W    $FFC0               ; $2AB4C2 MOVE.W  D0,<EA:3F>
        DC.W    $00CD               ; $2AB4C4 DC.W    $00CD
        BCLR    D0,(A4)                         ; $2AB4C6
        MOVE.W  D4,-(A6)                        ; $2AB4C8
        BCLR    D0,-(A2)                        ; $2AB4CA
        DC.W    $010E               ; $2AB4CC BTST    D0,A6
        MOVE.W  -(A3),(A6)+                     ; $2AB4CE
        ANDI.W  #$01E9,(A2)                     ; $2AB4D0
        DC.W    $FDD8               ; $2AB4D4 MOVE.W  (A0)+,<EA:3E>
        BCHG    D0,#$026F                       ; $2AB4D6
        DC.W    $FDF8,$0006         ; $2AB4DA MOVE.W  $0006.W,<EA:3E>
        BCLR    D0,D5                           ; $2AB4DE
        MOVE.W  -(A0),-$4B(A6,D0.W)             ; $2AB4E0
        ANDI.W  #$FE96,-(A0)                    ; $2AB4E4
        DC.W    $00FD               ; $2AB4E8 DC.W    $00FD
        MOVE.W  (A6),-$57(A7,A7.L)              ; $2AB4EA
        BCLR    D0,$0070(A5)                    ; $2AB4EE
        MOVE.W  (A7)+,$09(A7,D0.W)              ; $2AB4F2
        ORI.W  #$FD50,D1                        ; $2AB4F6
        DC.W    $02B9,$011C,$FE45,$01C5,$FFA6; $2AB4FA ANDI.L  #$011CFE45,$01C5FFA6
        MOVE.W  A5,D7                           ; $2AB504
        ANDI.W  #$0081,$02(A4,A7.L)             ; $2AB506
        DC.W    $02AF,$0171,$00B8,$03BA; $2AB50C ANDI.L  #$017100B8,$03BA(A7)
        BCHG    D0,-(A5)                        ; $2AB514
        DC.W    $FFD3               ; $2AB516 MOVE.W  (A3),<EA:3F>
        BTST    D1,D5                           ; $2AB518
        ANDI.L  #$FF200229,(A3)                 ; $2AB51A
        ANDI.L  #$FFDE041A,(A5)+                ; $2AB520
        BSET    D0,(A4)+                        ; $2AB526
        DC.W    $003B,$0365,$030B   ; $2AB528 ORI.B  #$0365,$0B(PC,D0.W)
        MOVE.W  A1,$0E(A7,D0.W)                 ; $2AB52E
        BSET    D0,$0121(A1)                    ; $2AB532
        ANDI.L  #$03150045,A1                   ; $2AB536
        DC.W    $023B,$0061,$000B   ; $2AB53C ANDI.B  #$0061,$0B(PC,D0.W)
        BSET    D0,(A5)+                        ; $2AB542
        ORI.L  #$0091031B,A6                    ; $2AB544
        BSET    D0,-$0A(A3,D0.W)                ; $2AB54A
        BCHG    D1,$01C50070                    ; $2AB54E
        BSET    D0,(A4)                         ; $2AB554
        DC.W    $00C3               ; $2AB556 DC.W    $00C3
        DC.W    $FFF1,$0313         ; $2AB558 MOVE.W  $13(A1,D0.W),<EA:3F>
        DC.W    $0228,$0056,$0193   ; $2AB55C ANDI.B  #$0056,$0193(A0)
        DC.W    $0018,$0170         ; $2AB562 ORI.B  #$0170,(A0)+
        BCLR    D0,-(A6)                        ; $2AB566
        ORI.L  #$018E0238,D6                    ; $2AB568
        DC.W    $00D3               ; $2AB56E DC.W    $00D3
        DC.W    $0017,$0224         ; $2AB570 ORI.B  #$0224,(A7)
        ORI.W  #$FFF9,-(A6)                     ; $2AB574
        BCHG    D0,D6                           ; $2AB578
        ORI.W  #$0160,(A3)+                     ; $2AB57A
        BSET    D0,(A0)+                        ; $2AB57E
        DC.W    $00A8,$FFE9,$00DA,$000C; $2AB580 ORI.L  #$FFE900DA,$000C(A0)
        DC.W    $00F5               ; $2AB588 DC.W    $00F5
        DC.W    $00ED               ; $2AB58A DC.W    $00ED
        DC.W    $FFD4               ; $2AB58C MOVE.W  (A4),<EA:3F>
        DC.W    $00F5               ; $2AB58E DC.W    $00F5
        BSET    D0,D5                           ; $2AB590
        DC.W    $001D,$01A2         ; $2AB592 ORI.B  #$01A2,(A5)+
        BCLR    D0,-(A6)                        ; $2AB596
        ORI.W  #$01A2,$31(A5,D0.W)              ; $2AB598
        BSET    D0,D2                           ; $2AB59E
        ORI.W  #$03DA,-$4A(A3,D0.W)             ; $2AB5A0
        ORI.W  #$03CB,-$50(A5,D0.W)             ; $2AB5A6
        MOVE.W  (A2)+,(A7)+                     ; $2AB5AC
        BTST    D1,-(A1)                        ; $2AB5AE
        DC.W    $00BC,$FED8,$0376,$022C,$002E; $2AB5B0 ORI.L  #$FED80376,#$022C002E
        BCHG    D1,$0125(A0)                    ; $2AB5BA
        MOVE.W  (A2),(A7)                       ; $2AB5BE
        BTST    D1,$00BB(A0)                    ; $2AB5C0
        MOVE.W  $3F(A1,D0.W),(A7)               ; $2AB5C4
        BTST    D0,(A2)+                        ; $2AB5C8
        MOVE.W  $04A5(A5),(A7)+                 ; $2AB5CA
        ORI.W  #$FF65,$048F(PC)                 ; $2AB5CE
        DC.W    $001B,$FF28         ; $2AB5D4 ORI.B  #$FF28,(A3)+
        BCHG    D1,(A3)+                        ; $2AB5D8
        BTST    D0,D6                           ; $2AB5DA
        DC.W    $FE7F               ; $2AB5DC MOVEA.W <EA:3F>,A7
        DC.W    $04C1               ; $2AB5DE DC.W    $04C1
        ORI.W  #$FEF6,-(A7)                     ; $2AB5E0
        SUBI.B  #$000F,-$0183(PC)               ; $2AB5E4
        SUBI.W  #$FFDA,(A2)                     ; $2AB5EA
        DC.W    $FE7D               ; $2AB5EE MOVEA.W <EA:3D>,A7
        DC.W    $04F0               ; $2AB5F0 DC.W    $04F0
        DC.W    $001D,$FF62         ; $2AB5F2 ORI.B  #$FF62,(A5)+
        DC.W    $04CB               ; $2AB5F6 DC.W    $04CB
        ORI.W  #$FF62,$10(A2,D0.W)              ; $2AB5F8
        BTST    D2,D0                           ; $2AB5FE
        ANDI.W  #$0270,-(A0)                    ; $2AB600
        ANDI.L  #$02900210,D0                   ; $2AB604
        ADDI.B  #$0310,D0                       ; $2AB60A
        BTST    D1,D0                           ; $2AB60E
        SUBI.B  #$0500,(A0)                     ; $2AB610
        BCHG    D1,(A0)                         ; $2AB614
        BCHG    D1,D0                           ; $2AB616
        SUBI.B  #$0600,(A0)                     ; $2AB618
        BTST    D1,$20(A0,D0.W)                 ; $2AB61C
        SUBI.B  #$0500,(A0)                     ; $2AB620
        DC.W    $02C0               ; $2AB624 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2AB626 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2AB62E DC.W    $02D0
        DC.W    $0210,$0600         ; $2AB630 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2AB634
        BTST    D2,D0                           ; $2AB63A
        DC.W    $02F0               ; $2AB63C DC.W    $02F0
        DC.W    $02E0               ; $2AB63E DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2AB640
        BCHG    D1,(A0)                         ; $2AB644
        BTST    D1,(A0)                         ; $2AB646
        DC.W    $0210,$0300         ; $2AB648 ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2AB64C
        ADDI.B  #$0270,D0                       ; $2AB652
        DC.W    $02E0               ; $2AB656 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2AB658
        ANDI.W  #$0300,-(A0)                    ; $2AB65C
        DC.W    $0210,$0300         ; $2AB660 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2AB664
        ANDI.L  #$04100300,-(A0)                ; $2AB666
        BTST    D1,-(A0)                        ; $2AB66C
        DC.W    $02B0,$0010,$6E00,$0000; $2AB66E ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2AB676 ORI.B  #$0020,(A0)
loc_2AB67A:
        DC.W    $0030,$0610,$6F00   ; $2AB67A ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AB680
        SUBI.B  #$7000,(A0)                     ; $2AB684
        ORI.W  #$0070,-(A0)                     ; $2AB688
        SUBI.B  #$6F00,(A0)                     ; $2AB68C
        DC.W    $0000,$0030         ; $2AB690 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AB694 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AB698 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AB69C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AB6A0
        DC.W    $00B0,$0210,$0400,$00D0; $2AB6A6 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AB6AE DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AB6B0
        ORI.L  #$00900611,-(A0)                 ; $2AB6B4
        BTST    D3,D1                           ; $2AB6BA
        DC.W    $00B0,$0010,$6A00,$00E0; $2AB6BC ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AB6C4 DC.W    $00F0
        BTST    D0,D0                           ; $2AB6C6
        BTST    D0,(A0)                         ; $2AB6C8
        DC.W    $0210,$6C00         ; $2AB6CA ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AB6CE
        SUBI.B  #$6B00,(A0)                     ; $2AB6D2
        BTST    D0,D0                           ; $2AB6D6
        DC.W    $00F0               ; $2AB6D8 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AB6DA ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AB6DE DC.W    $00E0
        DC.W    $0010,$6300         ; $2AB6E0 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AB6E4
        BCHG    D0,(A0)                         ; $2AB6E6
        BCHG    D0,-(A0)                        ; $2AB6E8
        BCHG    D0,$10(A0,D0.W)                 ; $2AB6EA
loc_2AB6EE:
        BCS.W  loc_2AB880                       ; $2AB6EE
        BCLR    D0,D0                           ; $2AB6F2
        SUBI.B  #$6400,(A0)                     ; $2AB6F4
        BCHG    D0,-(A0)                        ; $2AB6F8
        BCHG    D0,(A0)                         ; $2AB6FA
        ADDI.B  #$6201,(A1)                     ; $2AB6FC
        BCHG    D0,$10(A0,D0.W)                 ; $2AB700
        BPL.W  loc_2AB8A6                       ; $2AB704
        BCLR    D0,-$40(A0,D0.W)                ; $2AB708
        BSET    D0,(A0)                         ; $2AB70C
        DC.W    $0210,$6C00         ; $2AB70E ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AB712
        SUBI.B  #$6B00,(A0)                     ; $2AB716
        BSET    D0,D0                           ; $2AB71A
        BCLR    D0,$11(A0,D0.W)                 ; $2AB71C
        BVS.S  loc_2AB723                       ; $2AB720
        BSET    D0,(A0)                         ; $2AB722
        DC.W    $0010,$6300         ; $2AB724 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AB728 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AB72C ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AB730 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AB734
        SUBI.B  #$6400,(A0)                     ; $2AB738
        DC.W    $0220,$0210         ; $2AB73C ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AB740 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AB744 ANDI.B  #$0010,D0
        BNE.W  loc_2ABAAA                       ; $2AB748
        BCHG    D1,-$80(A0,D0.W)                ; $2AB74C
        BCLR    D1,(A0)                         ; $2AB750
        ADDI.B  #$6700,(A0)                     ; $2AB752
        BCLR    D1,-(A0)                        ; $2AB756
        BCLR    D1,$10(A0,D0.W)                 ; $2AB758
        BVC.W  loc_2ABB1E                       ; $2AB75C
        BSET    D1,(A0)                         ; $2AB760
        SUBI.B  #$6700,(A0)                     ; $2AB762
        BCHG    D1,-(A0)                        ; $2AB766
        BCLR    D1,(A0)                         ; $2AB768
        DC.W    $0010,$0300         ; $2AB76A ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AB76E
        BSET    D1,$00(A0,D0.W)                 ; $2AB770
        SUBI.B  #$0210,(A0)                     ; $2AB774
        BTST    D2,D0                           ; $2AB778
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AB77A
        SUBI.B  #$0400,D0                       ; $2AB780
        BSET    D1,$10(A0,D0.W)                 ; $2AB784
        BCS.W  loc_2ABBCA                       ; $2AB788
        SUBI.W  #$0460,(A0)                     ; $2AB78C
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AB790
        SUBI.L  #$04800410,(A0)                 ; $2AB796
        BCC.W  loc_2ABBFE                       ; $2AB79C
        SUBI.W  #$0010,(A0)                     ; $2AB7A0
        BTST    D1,D0                           ; $2AB7A4
        DC.W    $04E0               ; $2AB7A6 DC.W    $04E0
        DC.W    $04F0               ; $2AB7A8 DC.W    $04F0
        BTST    D2,D0                           ; $2AB7AA
        BTST    D2,(A0)                         ; $2AB7AC
        DC.W    $0210,$0500         ; $2AB7AE ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2AB7B2
        SUBI.B  #$0400,(A0)                     ; $2AB7B6
        BTST    D2,D0                           ; $2AB7BA
        DC.W    $04F0               ; $2AB7BC DC.W    $04F0
        DC.W    $0010,$6500         ; $2AB7BE ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2AB7C2
        BCHG    D2,(A0)                         ; $2AB7C4
        BCHG    D2,-(A0)                        ; $2AB7C6
        BCHG    D2,$10(A0,D0.W)                 ; $2AB7C8
        BLS.W  loc_2ABD5E                       ; $2AB7CC
        BCLR    D2,D0                           ; $2AB7D0
        SUBI.B  #$6400,(A0)                     ; $2AB7D2
        BCHG    D2,-(A0)                        ; $2AB7D6
        BCHG    D2,(A0)                         ; $2AB7D8
        DC.W    $0000,$6600         ; $2AB7DA ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AB7DE
        DC.W    $04D0               ; $2AB7E4 DC.W    $04D0
        DC.W    $0000,$6600         ; $2AB7E6 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2AB7EA
        BCLR    D2,-$40(A0,D0.W)                ; $2AB7EC
        BSET    D2,(A0)                         ; $2AB7F0
        CMPI.B  #$004E,D0                       ; $2AB7F2
        ORI.W  #$0267,A6                        ; $2AB7F6
        DC.W    $02D8               ; $2AB7FA DC.W    $02D8
        MOVE.W  $0345(PC),$02E0(A7)             ; $2AB7FC
        MOVE.W  D2,(A7)+                        ; $2AB802
        ANDI.L  #$039DFDB3,D2                   ; $2AB804
        BCHG    D0,$0394.W                      ; $2AB80A
        MOVE.W  (A0),(A7)                       ; $2AB80E
        BCLR    D1,D6                           ; $2AB810
        BCLR    D1,D7                           ; $2AB812
        MOVE.W  (A0)+,-(A7)                     ; $2AB814
        DC.W    $02D2               ; $2AB816 DC.W    $02D2
        SUBI.W  #$FE1D,$02A8(A3)                ; $2AB818
        DC.W    $037E               ; $2AB81E BCHG    D1,<EA:3E>
        DC.W    $FFD0               ; $2AB820 MOVE.W  (A0),<EA:3F>
        DC.W    $01C8               ; $2AB822 BSET    D0,A0
        SUBI.W  #$FEFA,-(A1)                    ; $2AB824
        BSET    D0,$0451(A2)                    ; $2AB828
        MOVE.W  -(A5),(A7)                      ; $2AB82C
        DC.W    $0200,$03B4         ; $2AB82E ANDI.B  #$03B4,D0
        MOVE.W  $0171(A6),D7                    ; $2AB832
        SUBI.W  #$FD89,D1                       ; $2AB836
        BCHG    D0,$04C1FE22                    ; $2AB83A
        ANDI.W  #$0457,$35(A2,A7.L)             ; $2AB840
        DC.W    $0202,$04C6         ; $2AB846 ANDI.B  #$04C6,D2
        MOVE.W  -$62(A2,D0.W),-$46(A6,D0.W)     ; $2AB84A
        MOVE.W  D3,(A7)+                        ; $2AB850
        BCHG    D0,$03EF(PC)                    ; $2AB852
        MOVE.W  -(A3),-(A7)                     ; $2AB856
        BSET    D0,D3                           ; $2AB858
        BTST    D1,(A2)                         ; $2AB85A
        DC.W    $0030,$01EE,$02C8   ; $2AB85C ORI.B  #$01EE,-$38(A0,D0.W)
        DC.W    $FFE9,$01E0         ; $2AB862 MOVE.W  $01E0(A1),<EA:3F>
        SUBI.B  #$FEF1,D7                       ; $2AB866
        DC.W    $022F,$0315,$0015   ; $2AB86A ANDI.B  #$0315,$0015(A7)
        DC.W    $0208,$0320         ; $2AB870 ANDI.B  #$0320,A0
        DC.W    $FFF1,$01E0         ; $2AB874 MOVE.W  -$20(A1,D0.W),<EA:3F>
        BTST    D1,$0039(A4)                    ; $2AB878
        BTST    D0,$03(PC,D0.W)                 ; $2AB87C
loc_2AB880:
        DC.W    $000D,$013E         ; $2AB880 ORI.B  #$013E,A5
        BCLR    D0,-$44(A7,A7.L)                ; $2AB884
        DC.W    $0228,$0304,$0038   ; $2AB888 ANDI.B  #$0304,$0038(A0)
        BCHG    D0,(A7)+                        ; $2AB88E
        BCLR    D0,(A2)+                        ; $2AB890
        DC.W    $0003,$0346         ; $2AB892 ORI.B  #$0346,D3
        ANDI.L  #$FE3603AD,(A5)+                ; $2AB896
        DC.W    $02C6               ; $2AB89C DC.W    $02C6
        MOVE.W  -(A6),D7                        ; $2AB89E
        BTST    D1,-(A1)                        ; $2AB8A0
        SUBI.B  #$FDDA,D6                       ; $2AB8A2
loc_2AB8A6:
        DC.W    $02AF,$03F9,$FDE3,$037D; $2AB8A6 ANDI.L  #$03F9FDE3,$037D(A7)
        DC.W    $02CA               ; $2AB8AE DC.W    $02CA
        MOVE.W  A3,(A7)                         ; $2AB8B0
        DC.W    $02E6               ; $2AB8B2 DC.W    $02E6
        SUBI.B  #$FE38,-(A5)                    ; $2AB8B4
        DC.W    $02C6               ; $2AB8B8 DC.W    $02C6
        BSET    D0,$40(A6,A7.L)                 ; $2AB8BA
        BTST    D1,$0E(A0,D0.W)                 ; $2AB8BE
        MOVE.W  (A1)+,$03BB(A6)                 ; $2AB8C2
        DC.W    $02D3               ; $2AB8C6 DC.W    $02D3
        MOVEA.W A4,A7                           ; $2AB8C8
        BCHG    D1,$02E7(A7)                    ; $2AB8CA
        MOVEA.W $02EE(A0),A7                    ; $2AB8CE
        BCLR    D0,$5F(A4,A7.L)                 ; $2AB8D2
        BCLR    D1,(A0)+                        ; $2AB8D6
        ANDI.L  #$FE8702D6,-(A4)                ; $2AB8D8
        BSET    D0,(A1)                         ; $2AB8DE
        ORI.W  #$03F5,(A3)                      ; $2AB8E0
        DC.W    $01C8               ; $2AB8E4 BSET    D0,A0
        MOVE.W  A1,$4C(A7,D0.W)                 ; $2AB8E6
        DC.W    $02F2               ; $2AB8EA DC.W    $02F2
        MOVE.W  D4,(A7)+                        ; $2AB8EC
        ANDI.W  #$02F9,-(A0)                    ; $2AB8EE
        MOVE.W  $0449(A3),$0242(A7)             ; $2AB8F2
        DC.W    $FFF8,$039F         ; $2AB8F8 MOVE.W  $039F.W,<EA:3F>
        BCHG    D1,-$00CC(A4)                   ; $2AB8FC
        BTST    D1,$024B(A0)                    ; $2AB900
        DC.W    $00C4               ; $2AB904 DC.W    $00C4
        DC.W    $02B3,$0373,$FFDC,$026A; $2AB906 ANDI.L  #$0373FFDC,$6A(A3,D0.W)
        DC.W    $00AB,$001F,$021E,$00F3; $2AB90E ORI.L  #$001F021E,$00F3(A3)
        ORI.L  #$0353026D,-(A5)                 ; $2AB916
        ORI.L  #$039E0224,A0                    ; $2AB91C
        DC.W    $0002,$01FA         ; $2AB922 ORI.B  #$01FA,D2
        BTST    D0,D3                           ; $2AB926
        DC.W    $0000,$0330         ; $2AB928 ORI.B  #$0330,D0
        DC.W    $027C,$FFE3,$01A1   ; $2AB92C ANDI.W  #$FFE3,#$01A1
        DC.W    $0027,$014C         ; $2AB932 ORI.B  #$014C,-(A7)
        BCLR    D0,(A7)+                        ; $2AB936
        ORI.L  #$01800268,A7                    ; $2AB938
        BTST    D0,$41(A2,D0.W)                 ; $2AB93E
        ANDI.W  #$00CA,$000E(A2)                ; $2AB942
        BCHG    D0,(A0)                         ; $2AB948
        ORI.W  #$0138,-(A4)                     ; $2AB94A
        DC.W    $0218,$0106         ; $2AB94E ANDI.B  #$0106,(A0)+
        DC.W    $FFFA,$00D8         ; $2AB952 MOVE.W  $00D8(PC),<EA:3F>
        DC.W    $001D,$00DA         ; $2AB956 ORI.B  #$00DA,(A5)+
        DC.W    $00E8               ; $2AB95A DC.W    $00E8
        DC.W    $FFE5               ; $2AB95C MOVE.W  -(A5),<EA:3F>
        DC.W    $00DA               ; $2AB95E DC.W    $00DA
        BSET    D0,D4                           ; $2AB960
        DC.W    $0022,$0186         ; $2AB962 ORI.B  #$0186,-(A2)
        BCLR    D0,$007B(A4)                    ; $2AB966
        BCLR    D0,D6                           ; $2AB96A
        BCHG    D1,(A6)+                        ; $2AB96C
        ANDI.W  #$0015,D0                       ; $2AB96E
        SUBI.B  #$0218,D1                       ; $2AB972
        DC.W    $0030,$03ED,$00D7   ; $2AB976 ORI.B  #$03ED,-$29(A0,D0.W)
        MOVE.W  D0,(A7)+                        ; $2AB97C
        DC.W    $034A               ; $2AB97E BCHG    D1,A2
        BTST    D0,D0                           ; $2AB980
        MOVE.W  -(A5),(A7)                      ; $2AB982
        DC.W    $03BE               ; $2AB984 BCLR    D1,<EA:3E>
        ANDI.L  #$FFCC03AB,(A0)                 ; $2AB986
        DC.W    $014E               ; $2AB98C BCHG    D0,A6
        MOVEA.W (A3)+,A7                        ; $2AB98E
        BCHG    D1,(A3)                         ; $2AB990
        DC.W    $00FA               ; $2AB992 DC.W    $00FA
        MOVE.W  D3,(A7)                         ; $2AB994
        BCHG    D1,$015B(PC)                    ; $2AB996
        MOVE.W  -$54(A6,D0.W),(A7)              ; $2AB99A
        ORI.L  #$FF5F0485,D3                    ; $2AB99E
        DC.W    $0023,$FF2A         ; $2AB9A4 ORI.B  #$FF2A,-(A3)
        BCLR    D1,(A0)+                        ; $2AB9A8
        BTST    D0,$4E(A3,A7.L)                 ; $2AB9AA
        DC.W    $04C9               ; $2AB9AE DC.W    $04C9
        ORI.W  #$FEF6,(A4)+                     ; $2AB9B0
        SUBI.B  #$FFD3,-$57(A3,A7.L)            ; $2AB9B4
        SUBI.W  #$FFA1,(A2)                     ; $2AB9BA
        MOVE.W  -$03(A4,D0.W),(A7)              ; $2AB9BE
        DC.W    $0034,$FF65,$04CC   ; $2AB9C2 ORI.B  #$FF65,-$34(A4,D0.W)
        ORI.L  #$FF540010,D2                    ; $2AB9C8
        BGT.W  loc_2AB9D0                       ; $2AB9CE
        DC.W    $0010,$0020         ; $2AB9D2 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2AB9D6 ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AB9DC
        SUBI.B  #$7000,(A0)                     ; $2AB9E0
        ORI.W  #$0070,-(A0)                     ; $2AB9E4
        SUBI.B  #$6F00,(A0)                     ; $2AB9E8
        DC.W    $0000,$0030         ; $2AB9EC ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AB9F0 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AB9F4 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AB9F8 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AB9FC
        DC.W    $00B0,$0210,$0400,$00D0; $2ABA02 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2ABA0A DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2ABA0C
        ORI.L  #$00900611,-(A0)                 ; $2ABA10
        BTST    D3,D1                           ; $2ABA16
        DC.W    $00B0,$0010,$6A00,$00E0; $2ABA18 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2ABA20 DC.W    $00F0
        BTST    D0,D0                           ; $2ABA22
        BTST    D0,(A0)                         ; $2ABA24
        DC.W    $0210,$6C00         ; $2ABA26 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2ABA2A
        SUBI.B  #$6B00,(A0)                     ; $2ABA2E
        BTST    D0,D0                           ; $2ABA32
        DC.W    $00F0               ; $2ABA34 DC.W    $00F0
        DC.W    $0211,$6901         ; $2ABA36 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2ABA3A DC.W    $00E0
        DC.W    $0010,$6300         ; $2ABA3C ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2ABA40
        BCHG    D0,(A0)                         ; $2ABA42
        BCHG    D0,-(A0)                        ; $2ABA44
        BCHG    D0,$10(A0,D0.W)                 ; $2ABA46
        BCS.W  loc_2ABBDC                       ; $2ABA4A
        BCLR    D0,D0                           ; $2ABA4E
        SUBI.B  #$6400,(A0)                     ; $2ABA50
        BCHG    D0,-(A0)                        ; $2ABA54
        BCHG    D0,(A0)                         ; $2ABA56
        ADDI.B  #$6201,(A1)                     ; $2ABA58
        BCHG    D0,$10(A0,D0.W)                 ; $2ABA5C
        BPL.W  loc_2ABC02                       ; $2ABA60
        BCLR    D0,-$40(A0,D0.W)                ; $2ABA64
        BSET    D0,(A0)                         ; $2ABA68
        DC.W    $0210,$6C00         ; $2ABA6A ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2ABA6E
        SUBI.B  #$6B00,(A0)                     ; $2ABA72
        BSET    D0,D0                           ; $2ABA76
        BCLR    D0,$11(A0,D0.W)                 ; $2ABA78
        BVS.S  loc_2ABA7F                       ; $2ABA7C
        BSET    D0,(A0)                         ; $2ABA7E
        DC.W    $0010,$6300         ; $2ABA80 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2ABA84 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2ABA88 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2ABA8C ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2ABA90
        SUBI.B  #$6400,(A0)                     ; $2ABA94
        DC.W    $0220,$0210         ; $2ABA98 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2ABA9C ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2ABAA0 ANDI.B  #$0010,D0
        BNE.W  loc_2ABD06                       ; $2ABAA4
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2ABAA8
        ADDI.B  #$6700,(A0)                     ; $2ABAAE
        ANDI.L  #$02B00410,-(A0)                ; $2ABAB2
        BVC.W  loc_2ABD7A                       ; $2ABAB8
        DC.W    $02D0               ; $2ABABC DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2ABABE
        ANDI.W  #$0290,-(A0)                    ; $2ABAC2
        DC.W    $0010,$0300         ; $2ABAC6 ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2ABACA DC.W    $02E0
        DC.W    $02F0               ; $2ABACC DC.W    $02F0
        BTST    D1,D0                           ; $2ABACE
        BTST    D1,(A0)                         ; $2ABAD0
        DC.W    $0210,$0500         ; $2ABAD2 ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2ABAD6
        SUBI.B  #$0400,(A0)                     ; $2ABADA
        BTST    D1,D0                           ; $2ABADE
        DC.W    $02F0               ; $2ABAE0 DC.W    $02F0
        DC.W    $0010,$6500         ; $2ABAE2 ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2ABAE6
        BCHG    D1,(A0)                         ; $2ABAE8
        BCHG    D1,-(A0)                        ; $2ABAEA
        BCHG    D1,$10(A0,D0.W)                 ; $2ABAEC
        BLS.W  loc_2ABE82                       ; $2ABAF0
        BCLR    D1,D0                           ; $2ABAF4
        SUBI.B  #$6400,(A0)                     ; $2ABAF6
        BCHG    D1,-(A0)                        ; $2ABAFA
        BCHG    D1,(A0)                         ; $2ABAFC
        DC.W    $0010,$0300         ; $2ABAFE ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2ABB02
        BSET    D1,$00(A0,D0.W)                 ; $2ABB04
        SUBI.B  #$0210,(A0)                     ; $2ABB08
        BTST    D2,D0                           ; $2ABB0C
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2ABB0E
        SUBI.B  #$0400,D0                       ; $2ABB14
        BSET    D1,$10(A0,D0.W)                 ; $2ABB18
        BCS.W  loc_2ABF5E                       ; $2ABB1C
        SUBI.W  #$0460,(A0)                     ; $2ABB20
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2ABB24
        SUBI.L  #$04800410,(A0)                 ; $2ABB2A
        BCC.W  loc_2ABF92                       ; $2ABB30
        SUBI.W  #$0000,(A0)                     ; $2ABB34
        BNE.W  loc_2ABEDA                       ; $2ABB38
        BCLR    D1,-$40(A0,D0.W)                ; $2ABB3C
        BSET    D1,(A0)                         ; $2ABB40
        DC.W    $0000,$6600         ; $2ABB42 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2ABB46
        DC.W    $04D0               ; $2ABB4C DC.W    $04D0
        CMPI.B  #$004E,D0                       ; $2ABB4E
        ORI.W  #$0314,A6                        ; $2ABB52
        BCHG    D1,(A6)+                        ; $2ABB56
        MOVEA.W -(A0),A7                        ; $2ABB58
        SUBI.B  #$0359,-(A4)                    ; $2ABB5A
        MOVE.W  D2,D7                           ; $2ABB5E
        DC.W    $03C8               ; $2ABB60 BSET    D1,A0
        BSET    D1,D1                           ; $2ABB62
        MOVE.W  (A3)+,(A6)                      ; $2ABB64
        ANDI.L  #$03C7FD0D,D2                   ; $2ABB66
        DC.W    $043D,$0415         ; $2ABB6C SUBI.B  #$0415,<EA:3D>
        DC.W    $FE3E               ; $2ABB70 MOVE.W  <EA:3E>,D7
        BSET    D1,-(A7)                        ; $2ABB72
        DC.W    $04A8,$FCE6,$032D,$041A; $2ABB74 SUBI.L  #$FCE6032D,$041A(A0)
        MOVE.W  (A5)+,(A7)                      ; $2ABB7C
        ANDI.L  #$04AFFD58,-(A0)                ; $2ABB7E
        DC.W    $02DF               ; $2ABB84 DC.W    $02DF
        SUBI.L  #$FD1A0322,(A1)                 ; $2ABB86
        BSET    D1,-(A2)                        ; $2ABB8C
        MOVE.W  (A2)+,(A6)+                     ; $2ABB8E
        DC.W    $02D3               ; $2ABB90 DC.W    $02D3
        SUBI.B  #$FBF1,-$60(A7,D0.W)            ; $2ABB92
        DC.W    $04D6               ; $2ABB98 DC.W    $04D6
        MOVEA.W -(A2),A6                        ; $2ABB9A
        BCLR    D1,D7                           ; $2ABB9C
        SUBI.L  #$FCE00348,A6                   ; $2ABB9E
        DC.W    $04D1               ; $2ABBA4 DC.W    $04D1
        MOVE.W  -(A7),D6                        ; $2ABBA6
        ANDI.L  #$03EEFD44,A6                   ; $2ABBA8
        ANDI.W  #$043A,A2                       ; $2ABBAE
        MOVE.W  $4A(PC,D0.W),$03D6(A6)          ; $2ABBB2
        MOVE.W  (A1),(A7)+                      ; $2ABBB8
        ANDI.L  #$0382FEB9,A6                   ; $2ABBBA
        DC.W    $02B8,$0450,$FD61,$02B8; $2ABBC0 ANDI.L  #$0450FD61,$02B8.W
        BSET    D1,-(A4)                        ; $2ABBC8
loc_2ABBCA:
        MOVE.W  (A5),(A7)+                      ; $2ABBCA
        ANDI.L  #$03E8FEB5,-(A4)                ; $2ABBCC
        ANDI.W  #$03F7,-(A3)                    ; $2ABBD2
        MOVE.W  -(A5),(A7)+                     ; $2ABBD6
        BSET    D0,-(A0)                        ; $2ABBD8
        DC.W    $02C5               ; $2ABBDA DC.W    $02C5
loc_2ABBDC:
        MOVE.W  (A2),(A7)                       ; $2ABBDC
        DC.W    $0206,$0274         ; $2ABBDE ANDI.B  #$0274,D6
        MOVEA.W A7,A7                           ; $2ABBE2
        ANDI.L  #$03D1FF06,-(A5)                ; $2ABBE4
        DC.W    $0206,$025E         ; $2ABBEA ANDI.B  #$025E,D6
        MOVE.W  -(A0),(A7)                      ; $2ABBEE
        SUBI.W  #$0316,-$47(A5,A7.L)            ; $2ABBF0
        DC.W    $04D3               ; $2ABBF6 DC.W    $04D3
        BCHG    D1,(A1)                         ; $2ABBF8
        DC.W    $FDBD,$0449         ; $2ABBFA MOVE.W  <EA:3D>,$49(A6,D0.W)
loc_2ABBFE:
        DC.W    $043C,$FCD8,$03DF   ; $2ABBFE SUBI.B  #$FCD8,#$03DF
        SUBI.B  #$FCBF,(A6)                     ; $2ABC04
        SUBI.L  #$0367FE05,D2                   ; $2ABC08
        BSET    D1,$0467(A2)                    ; $2ABC0E
        MOVE.W  A2,-(A6)                        ; $2ABC12
        SUBI.W  #$0236,(A7)+                    ; $2ABC14
        MOVE.W  (A5),(A6)+                      ; $2ABC18
        DC.W    $04B7,$0263,$FD08,$04D2; $2ABC1A SUBI.L  #$0263FD08,-$2E(A7,D0.W)
        BCHG    D1,-$021E(A2)                   ; $2ABC22
        SUBI.L  #$0376FDDF,D1                   ; $2ABC26
        SUBI.L  #$0203FD0F,D0                   ; $2ABC2C
        SUBI.L  #$0343FE18,-(A2)                ; $2ABC32
        DC.W    $033F               ; $2ABC38 BTST    D1,<EA:3F>
        ANDI.W  #$FF45,(A7)+                    ; $2ABC3A
        SUBI.L  #$025AFECE,A4                   ; $2ABC3E
        SUBI.B  #$0389,(A5)+                    ; $2ABC44
        DC.W    $FDEB,$030D         ; $2ABC48 MOVE.W  $030D(A3),<EA:3E>
        DC.W    $038E               ; $2ABC4C BCLR    D1,A6
        MOVEA.W A4,A7                           ; $2ABC4E
        DC.W    $04BE,$02CF,$FF53   ; $2ABC50 SUBI.L  #$02CFFF53,<EA:3E>
        SUBI.W  #$0400,A7                       ; $2ABC56
        MOVEA.W $71(A0,D0.W),A7                 ; $2ABC5A
        DC.W    $02D4               ; $2ABC5E DC.W    $02D4
        DC.W    $FFCA               ; $2ABC60 MOVE.W  A2,<EA:3F>
        DC.W    $033E               ; $2ABC62 BTST    D1,<EA:3E>
        SUBI.B  #$FED2,D4                       ; $2ABC64
        SUBI.B  #$01D8,D2                       ; $2ABC68
        DC.W    $FDD4               ; $2ABC6C MOVE.W  (A4),<EA:3E>
        BCHG    D1,(A2)+                        ; $2ABC6E
        DC.W    $01BD               ; $2ABC70 BCLR    D0,<EA:3D>
        DC.W    $FDDD               ; $2ABC72 MOVE.W  (A5)+,<EA:3E>
        DC.W    $034D               ; $2ABC74 BCHG    D1,A5
        ANDI.L  #$FF9103F5,(A3)+                ; $2ABC76
        DC.W    $02B6,$FF88,$03AF,$0241; $2ABC7C ANDI.L  #$FF8803AF,$41(A6,D0.W)
        MOVE.W  (A4)+,-$5E(A6,D0.W)             ; $2ABC84
        BTST    D1,(A7)+                        ; $2ABC88
        MOVE.W  A7,$02B6(A7)                    ; $2ABC8A
        BTST    D0,-(A1)                        ; $2ABC8E
        MOVEA.W -(A0),A7                        ; $2ABC90
        ANDI.L  #$0182FE9D,-(A2)                ; $2ABC92
        BSET    D1,-(A2)                        ; $2ABC98
        DC.W    $0236,$FDE4,$03F4   ; $2ABC9A ANDI.B  #$FDE4,-$0C(A6,D0.W)
        BSET    D0,(A6)                         ; $2ABCA0
        MOVE.W  -(A7),$76(A6,D0.W)              ; $2ABCA2
        BCHG    D0,-(A7)                        ; $2ABCA6
        MOVE.W  -$4B(A6,D0.W),D7                ; $2ABCA8
        DC.W    $021A,$FD7D         ; $2ABCAC ANDI.B  #$FD7D,(A2)+
        BSET    D0,$47(A2,D0.W)                 ; $2ABCB0
        DC.W    $FDCD               ; $2ABCB4 MOVE.W  A5,<EA:3E>
        BSET    D0,$0C(A2,D0.W)                 ; $2ABCB6
        DC.W    $FDCD               ; $2ABCBA MOVE.W  A5,<EA:3E>
        DC.W    $02BB,$010C,$FE9A,$02BB; $2ABCBC ANDI.L  #$010CFE9A,-$45(PC,D0.W)
        BCHG    D0,-$0166(A1)                   ; $2ABCC4
        BSET    D1,-(A2)                        ; $2ABCC8
        DC.W    $02F9               ; $2ABCCA DC.W    $02F9
        MOVE.W  (A4),-(A7)                      ; $2ABCCC
        SUBI.W  #$02C1,-(A1)                    ; $2ABCCE
        MOVE.W  $51(A6,D0.W),$0111(A7)          ; $2ABCD2
        MOVE.W  (A3),(A7)                       ; $2ABCD8
        BSET    D1,(A2)                         ; $2ABCDA
        DC.W    $0148               ; $2ABCDC BCHG    D0,A0
        MOVE.W  $68(A1,D0.W),D7                 ; $2ABCDE
        BTST    D1,(A0)                         ; $2ABCE2
        MOVE.W  -(A0),(A7)+                     ; $2ABCE4
        SUBI.W  #$0160,(A1)+                    ; $2ABCE6
        DC.W    $FDFC,$03E2         ; $2ABCEA MOVE.W  #$03E2,<EA:3E>
        DC.W    $0149               ; $2ABCEE BCHG    D0,A1
        MOVE.W  (A3)+,D7                        ; $2ABCF0
        SUBI.B  #$019C,(A7)+                    ; $2ABCF2
        MOVEA.W A6,A7                           ; $2ABCF6
        DC.W    $04B5,$0089,$FF58,$0477; $2ABCF8 SUBI.L  #$0089FF58,$77(A5,D0.W)
        DC.W    $0036,$FF24,$0440   ; $2ABD00 ORI.B  #$FF24,$40(A6,D0.W)
loc_2ABD06:
        BCHG    D0,(A2)+                        ; $2ABD06
        DC.W    $FDF6,$04D6         ; $2ABD08 MOVE.W  -$2A(A6,D0.W),<EA:3E>
        ORI.W  #$FEFF,D6                        ; $2ABD0C
        SUBI.W  #$FFF8,$6C(A5,A7.L)             ; $2ABD10
        SUBI.L  #$FFC1FE7C,D4                   ; $2ABD16
        DC.W    $04D6               ; $2ABD1C DC.W    $04D6
        DC.W    $0022,$FF7D         ; $2ABD1E ORI.B  #$FF7D,-(A2)
        DC.W    $04BF,$0078,$FF63   ; $2ABD22 SUBI.L  #$0078FF63,<EA:3F>
        DC.W    $0010,$6E00         ; $2ABD28 ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2ABD2C ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2ABD30 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2ABD34
        ORI.W  #$0050,D0                        ; $2ABD38
        SUBI.B  #$7000,(A0)                     ; $2ABD3C
        ORI.W  #$0070,-(A0)                     ; $2ABD40
        SUBI.B  #$6F00,(A0)                     ; $2ABD44
        DC.W    $0000,$0030         ; $2ABD48 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2ABD4C ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2ABD50 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2ABD54 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2ABD58
loc_2ABD5E:
        DC.W    $00B0,$0210,$0400,$00D0; $2ABD5E ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2ABD66 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2ABD68
        ORI.L  #$00900611,-(A0)                 ; $2ABD6C
        BTST    D3,D1                           ; $2ABD72
        DC.W    $00B0,$0010,$6A00,$00E0; $2ABD74 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2ABD7C DC.W    $00F0
        BTST    D0,D0                           ; $2ABD7E
        BTST    D0,(A0)                         ; $2ABD80
        DC.W    $0210,$6C00         ; $2ABD82 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2ABD86
        SUBI.B  #$6B00,(A0)                     ; $2ABD8A
        BTST    D0,D0                           ; $2ABD8E
        DC.W    $00F0               ; $2ABD90 DC.W    $00F0
        DC.W    $0211,$6901         ; $2ABD92 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2ABD96 DC.W    $00E0
        DC.W    $0010,$6300         ; $2ABD98 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2ABD9C
        BCHG    D0,(A0)                         ; $2ABD9E
        BCHG    D0,-(A0)                        ; $2ABDA0
        BCHG    D0,$10(A0,D0.W)                 ; $2ABDA2
        BCS.W  loc_2ABF38                       ; $2ABDA6
        BCLR    D0,D0                           ; $2ABDAA
        SUBI.B  #$6400,(A0)                     ; $2ABDAC
        BCHG    D0,-(A0)                        ; $2ABDB0
        BCHG    D0,(A0)                         ; $2ABDB2
        ADDI.B  #$6201,(A1)                     ; $2ABDB4
        BCHG    D0,$10(A0,D0.W)                 ; $2ABDB8
        BPL.W  loc_2ABF5E                       ; $2ABDBC
        BCLR    D0,-$40(A0,D0.W)                ; $2ABDC0
        BSET    D0,(A0)                         ; $2ABDC4
        DC.W    $0210,$6C00         ; $2ABDC6 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2ABDCA
        SUBI.B  #$6B00,(A0)                     ; $2ABDCE
        BSET    D0,D0                           ; $2ABDD2
        BCLR    D0,$11(A0,D0.W)                 ; $2ABDD4
        BVS.S  loc_2ABDDB                       ; $2ABDD8
        BSET    D0,(A0)                         ; $2ABDDA
        DC.W    $0010,$6300         ; $2ABDDC ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2ABDE0 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2ABDE4 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2ABDE8 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2ABDEC
        SUBI.B  #$6400,(A0)                     ; $2ABDF0
        DC.W    $0220,$0210         ; $2ABDF4 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2ABDF8 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2ABDFC ANDI.B  #$0010,D0
        BNE.W  loc_2AC062                       ; $2ABE00
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2ABE04
        ADDI.B  #$6700,(A0)                     ; $2ABE0A
        ANDI.L  #$02B00410,-(A0)                ; $2ABE0E
        BVC.W  loc_2AC0D6                       ; $2ABE14
        DC.W    $02D0               ; $2ABE18 DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2ABE1A
        ANDI.W  #$0290,-(A0)                    ; $2ABE1E
        DC.W    $0010,$0300         ; $2ABE22 ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2ABE26 DC.W    $02E0
        DC.W    $02F0               ; $2ABE28 DC.W    $02F0
        BTST    D1,D0                           ; $2ABE2A
        BTST    D1,(A0)                         ; $2ABE2C
        DC.W    $0210,$0500         ; $2ABE2E ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2ABE32
        SUBI.B  #$0400,(A0)                     ; $2ABE36
        BTST    D1,D0                           ; $2ABE3A
        DC.W    $02F0               ; $2ABE3C DC.W    $02F0
        DC.W    $0010,$6500         ; $2ABE3E ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2ABE42
        BCHG    D1,(A0)                         ; $2ABE44
        BCHG    D1,-(A0)                        ; $2ABE46
        BCHG    D1,$10(A0,D0.W)                 ; $2ABE48
        BLS.W  loc_2AC1DE                       ; $2ABE4C
        BCLR    D1,D0                           ; $2ABE50
        SUBI.B  #$6400,(A0)                     ; $2ABE52
        BCHG    D1,-(A0)                        ; $2ABE56
        BCHG    D1,(A0)                         ; $2ABE58
        DC.W    $0010,$0300         ; $2ABE5A ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2ABE5E
        BSET    D1,$00(A0,D0.W)                 ; $2ABE60
        SUBI.B  #$0210,(A0)                     ; $2ABE64
        BTST    D2,D0                           ; $2ABE68
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2ABE6A
        SUBI.B  #$0400,D0                       ; $2ABE70
        BSET    D1,$10(A0,D0.W)                 ; $2ABE74
        BCS.W  $2AC2BA                          ; $2ABE78
        SUBI.W  #$0460,(A0)                     ; $2ABE7C
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2ABE80
        SUBI.L  #$04800410,(A0)                 ; $2ABE86
        BCC.W  $2AC2EE                          ; $2ABE8C
        SUBI.W  #$0000,(A0)                     ; $2ABE90
        BNE.W  $2AC236                          ; $2ABE94
        BCLR    D1,-$40(A0,D0.W)                ; $2ABE98
        BSET    D1,(A0)                         ; $2ABE9C
        DC.W    $0000,$6600         ; $2ABE9E ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2ABEA2
        DC.W    $04D0               ; $2ABEA8 DC.W    $04D0
        CMPI.B  #$004E,D0                       ; $2ABEAA
        ORI.W  #$0376,A6                        ; $2ABEAE
        DC.W    $02DA               ; $2ABEB2 DC.W    $02DA
        MOVE.W  $0496(A1),$02D7(A6)             ; $2ABEB4
        MOVE.W  (A0),$0496(A6)                  ; $2ABEBA
        DC.W    $0388               ; $2ABEBE BCLR    D1,A0
        DC.W    $FBFB,$033E         ; $2ABEC0 MOVE.W  $3E(PC,D0.W),<EA:3D>
        DC.W    $038B               ; $2ABEC4 BCLR    D1,A3
        MOVE.W  (A1)+,D6                        ; $2ABEC6
        SUBI.L  #$0382FDB6,-(A0)                ; $2ABEC8
        SUBI.L  #$045AFC78,-(A3)                ; $2ABECE
        BCLR    D1,D2                           ; $2ABED4
        BCLR    D1,D5                           ; $2ABED6
        DC.W    $FDCF               ; $2ABED8 MOVE.W  A7,<EA:3E>
loc_2ABEDA:
        DC.W    $034B               ; $2ABEDA BCHG    D1,A3
        SUBI.W  #$FC96,(A6)+                    ; $2ABEDC
        BCLR    D1,(A6)                         ; $2ABEE0
        SUBI.W  #$FC65,A1                       ; $2ABEE2
        BSET    D1,-(A6)                        ; $2ABEE6
        BCLR    D1,-(A5)                        ; $2ABEE8
        MOVE.W  (A4),D6                         ; $2ABEEA
        BSET    D1,(A4)                         ; $2ABEEC
        SUBI.B  #$FB37,$0388(A3)                ; $2ABEEE
        DC.W    $04B3,$FBB5,$0447,$0447; $2ABEF4 SUBI.L  #$FBB50447,$47(A3,D0.W)
        MOVEA.W (A5),A6                         ; $2ABEFC
        SUBI.B  #$04B1,$FBA5.W                  ; $2ABEFE
        DC.W    $033E               ; $2ABF04 BTST    D1,<EA:3E>
        BSET    D1,(A7)                         ; $2ABF06
        MOVEA.W (A4),A6                         ; $2ABF08
        DC.W    $02E6               ; $2ABF0A DC.W    $02E6
        BSET    D1,-$66(A2,A7.L)                ; $2ABF0C
        DC.W    $02BC,$02DD,$FD75,$0310,$02A8; $2ABF10 ANDI.L  #$02DDFD75,#$031002A8
        MOVE.W  D3,$0352(A6)                    ; $2ABF1A
        SUBI.B  #$FCAA,(A0)+                    ; $2ABF1E
        BTST    D1,-(A4)                        ; $2ABF22
        DC.W    $02EA               ; $2ABF24 DC.W    $02EA
        MOVE.W  (A2)+,$14(A6,D0.W)              ; $2ABF26
        DC.W    $02FC               ; $2ABF2A DC.W    $02FC
        MOVE.W  $02CC(A3),$02F4(A6)             ; $2ABF2C
        MOVE.W  (A2),-$7B(A6,D0.W)              ; $2ABF32
        BSET    D0,(A7)+                        ; $2ABF36
loc_2ABF38:
        MOVE.W  (A5),(A6)+                      ; $2ABF38
        DC.W    $02BD,$01AC,$FC85   ; $2ABF3A ANDI.L  #$01ACFC85,<EA:3D>
        DC.W    $030F               ; $2ABF40 BTST    D1,A7
        DC.W    $02CE               ; $2ABF42 DC.W    $02CE
        MOVE.W  -$47(A1,D0.W),$7D(A6,D0.W)      ; $2ABF44
        MOVE.W  A2,(A6)+                        ; $2ABF4A
        DC.W    $04F0               ; $2ABF4C DC.W    $04F0
        ANDI.L  #$FCF3054D,(A3)                 ; $2ABF4E
        DC.W    $02BF,$FD1B,$0506   ; $2ABF54 ANDI.L  #$FD1B0506,<EA:3F>
        BSET    D1,-$0391(A7)                   ; $2ABF5A
loc_2ABF5E:
        SUBI.L  #$03DEFC38,-(A1)                ; $2ABF5E
        DC.W    $04EF               ; $2ABF64 DC.W    $04EF
        DC.W    $02C9               ; $2ABF66 DC.W    $02C9
        MOVE.W  (A3),$04A0(A6)                  ; $2ABF68
        SUBI.B  #$FC99,(A4)                     ; $2ABF6C
        BTST    D2,-(A0)                        ; $2ABF70
        BCLR    D0,D6                           ; $2ABF72
        MOVE.W  $66(A5,D0.W),D6                 ; $2ABF74
        BCLR    D0,-$0386(PC)                   ; $2ABF78
        BCHG    D2,D3                           ; $2ABF7C
        DC.W    $02D6               ; $2ABF7E DC.W    $02D6
        MOVE.W  -$0B(A7,D0.W),-(A6)             ; $2ABF80
        DC.W    $02DF               ; $2ABF84 DC.W    $02DF
        MOVE.W  (A2)+,-(A6)                     ; $2ABF86
        BTST    D2,$0159(A7)                    ; $2ABF88
        MOVEA.W $0505(PC),A6                    ; $2ABF8C
        DC.W    $02B3,$FD60,$035E,$01D7; $2ABF90 ANDI.L  #$FD60035E,-$29(A3,D0.W)
        MOVEA.W $04BF(A2),A7                    ; $2ABF98
        DC.W    $01CB               ; $2ABF9C BSET    D0,A3
        MOVEA.W (A5),A7                         ; $2ABF9E
        SUBI.L  #$02EFFD4D,(A1)+                ; $2ABFA0
        BCHG    D1,-$08(A7,D0.W)                ; $2ABFA6
        MOVE.W  (A7)+,$04CA(A6)                 ; $2ABFAA
        ANDI.W  #$FEDE,A0                       ; $2ABFAE
        SUBI.L  #$036CFDD7,-(A4)                ; $2ABFB2
        BCHG    D1,$0253(A1)                    ; $2ABFB8
        MOVE.W  -$7D(A2,D0.W),(A7)+             ; $2ABFBC
        BCHG    D1,-$19(A5,A7.L)                ; $2ABFC0
        BSET    D1,-(A0)                        ; $2ABFC4
        DC.W    $00FD               ; $2ABFC6 DC.W    $00FD
        MOVE.W  D5,$0338(A6)                    ; $2ABFC8
        DC.W    $010F               ; $2ABFCC BTST    D0,A7
        MOVE.W  A7,$036E(A6)                    ; $2ABFCE
        DC.W    $023A,$FECE,$0416   ; $2ABFD2 ANDI.B  #$FECE,$0416(PC)
        DC.W    $0228,$FEC4,$03A8   ; $2ABFD8 ANDI.B  #$FEC4,$03A8(A0)
        BCHG    D0,-$0309(A3)                   ; $2ABFDE
        BSET    D1,(A7)+                        ; $2ABFE2
        ANDI.L  #$FE7602A5,(A6)                 ; $2ABFE4
        DC.W    $002C,$FCF1,$0260   ; $2ABFEA ORI.B  #$FCF1,$0260(A4)
        ORI.W  #$FD27,-$61(A5,D0.W)             ; $2ABFF0
        BCHG    D0,-$0286(A0)                   ; $2ABFF6
        BSET    D1,-(A5)                        ; $2ABFFA
        BTST    D0,(A6)+                        ; $2ABFFC
        MOVE.W  D4,$027B(A6)                    ; $2ABFFE
        ORI.W  #$FCB8,-$45(A6,D0.W)             ; $2AC002
        BCHG    D0,-$02F5(A1)                   ; $2AC008
        DC.W    $021E,$0036         ; $2AC00C ANDI.B  #$0036,(A6)+
        MOVE.W  -(A2),D6                        ; $2AC010
        DC.W    $0218,$FFFB         ; $2AC012 ANDI.B  #$FFFB,(A0)+
        MOVE.W  $0281(A1),D6                    ; $2AC016
        DC.W    $0012,$FD34         ; $2AC01A ORI.B  #$FD34,(A2)
        ANDI.L  #$006EFD27,A3                   ; $2AC01E
        SUBI.B  #$026E,(A5)                     ; $2AC024
        DC.W    $FE3F               ; $2AC028 MOVE.W  <EA:3F>,D7
        SUBI.W  #$0268,-$012D(A0)               ; $2AC02A
        SUBI.W  #$007E,(A7)+                    ; $2AC030
        MOVE.W  D2,(A7)+                        ; $2AC034
        SUBI.B  #$0086,A4                       ; $2AC036
        MOVE.W  $04A5(A6),D7                    ; $2AC03A
        ANDI.W  #$FE35,$049C(A4)                ; $2AC03E
        ORI.L  #$FE24041F,D4                    ; $2AC044
        ORI.W  #$FE23,$56(A1,D0.W)              ; $2AC04A
        DC.W    $00D7               ; $2AC050 DC.W    $00D7
        MOVE.W  $70(A1,D0.W),D7                 ; $2AC052
        ORI.L  #$FFC4043A,(A3)                  ; $2AC056
        DC.W    $002E,$FFB7,$0487   ; $2AC05C ORI.B  #$FFB7,$0487(A6)
loc_2AC062:
        ORI.W  #$FE1C,$04A0(A7)                 ; $2AC062
        DC.W    $002D,$FFB0,$04A1   ; $2AC068 ORI.B  #$FFB0,$04A1(A5)
        DC.W    $FFC2               ; $2AC06E MOVE.W  D2,<EA:3F>
        MOVE.W  (A2)+,-(A7)                     ; $2AC070
        SUBI.L  #$FF93FF3E,-(A0)                ; $2AC072
        SUBI.W  #$0039,-(A5)                    ; $2AC078
        DC.W    $001E,$0466         ; $2AC07C ORI.B  #$0466,(A6)+
        ORI.L  #$FFE80010,D4                    ; $2AC080
        BGT.W  loc_2AC088                       ; $2AC086
        DC.W    $0010,$0020         ; $2AC08A ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2AC08E ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AC094
        SUBI.B  #$7000,(A0)                     ; $2AC098
        ORI.W  #$0070,-(A0)                     ; $2AC09C
        SUBI.B  #$6F00,(A0)                     ; $2AC0A0
        DC.W    $0000,$0030         ; $2AC0A4 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AC0A8 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AC0AC ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AC0B0 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AC0B4
        DC.W    $00B0,$0210,$0400,$00D0; $2AC0BA ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AC0C2 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AC0C4
        ORI.L  #$00900611,-(A0)                 ; $2AC0C8
        BTST    D3,D1                           ; $2AC0CE
        DC.W    $00B0,$0010,$6A00,$00E0; $2AC0D0 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AC0D8 DC.W    $00F0
        BTST    D0,D0                           ; $2AC0DA
        BTST    D0,(A0)                         ; $2AC0DC
        DC.W    $0210,$6C00         ; $2AC0DE ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AC0E2
        SUBI.B  #$6B00,(A0)                     ; $2AC0E6
        BTST    D0,D0                           ; $2AC0EA
        DC.W    $00F0               ; $2AC0EC DC.W    $00F0
        DC.W    $0211,$6901         ; $2AC0EE ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AC0F2 DC.W    $00E0
        DC.W    $0010,$6300         ; $2AC0F4 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AC0F8
        BCHG    D0,(A0)                         ; $2AC0FA
        BCHG    D0,-(A0)                        ; $2AC0FC
        BCHG    D0,$10(A0,D0.W)                 ; $2AC0FE
        BCS.W  $2AC294                          ; $2AC102
        BCLR    D0,D0                           ; $2AC106
        SUBI.B  #$6400,(A0)                     ; $2AC108
        BCHG    D0,-(A0)                        ; $2AC10C
        BCHG    D0,(A0)                         ; $2AC10E
        ADDI.B  #$6201,(A1)                     ; $2AC110
        BCHG    D0,$10(A0,D0.W)                 ; $2AC114
        BPL.W  $2AC2BA                          ; $2AC118
        BCLR    D0,-$40(A0,D0.W)                ; $2AC11C
        BSET    D0,(A0)                         ; $2AC120
        DC.W    $0210,$6C00         ; $2AC122 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2AC126
        SUBI.B  #$6B00,(A0)                     ; $2AC12A
        BSET    D0,D0                           ; $2AC12E
        BCLR    D0,$11(A0,D0.W)                 ; $2AC130
        BVS.S  loc_2AC137                       ; $2AC134
        BSET    D0,(A0)                         ; $2AC136
        DC.W    $0010,$6300         ; $2AC138 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2AC13C ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2AC140 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2AC144 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2AC148
        SUBI.B  #$6400,(A0)                     ; $2AC14C
        DC.W    $0220,$0210         ; $2AC150 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2AC154 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2AC158 ANDI.B  #$0010,D0
        BNE.W  $2AC3BE                          ; $2AC15C
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2AC160
        ADDI.B  #$6700,(A0)                     ; $2AC166
        ANDI.L  #$02B00410,-(A0)                ; $2AC16A
        BVC.W  $2AC432                          ; $2AC170
        DC.W    $02D0               ; $2AC174 DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2AC176
        ANDI.W  #$0290,-(A0)                    ; $2AC17A
        DC.W    $0010,$0300         ; $2AC17E ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2AC182 DC.W    $02E0
        DC.W    $02F0               ; $2AC184 DC.W    $02F0
        BTST    D1,D0                           ; $2AC186
        BTST    D1,(A0)                         ; $2AC188
        DC.W    $0210,$0500         ; $2AC18A ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2AC18E
        SUBI.B  #$0400,(A0)                     ; $2AC192
        BTST    D1,D0                           ; $2AC196
        DC.W    $02F0               ; $2AC198 DC.W    $02F0
        DC.W    $0010,$6500         ; $2AC19A ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2AC19E
        BCHG    D1,(A0)                         ; $2AC1A0
        BCHG    D1,-(A0)                        ; $2AC1A2
        BCHG    D1,$10(A0,D0.W)                 ; $2AC1A4
        BLS.W  $2AC53A                          ; $2AC1A8
        BCLR    D1,D0                           ; $2AC1AC
        SUBI.B  #$6400,(A0)                     ; $2AC1AE
        BCHG    D1,-(A0)                        ; $2AC1B2
        BCHG    D1,(A0)                         ; $2AC1B4
        DC.W    $0010,$0300         ; $2AC1B6 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2AC1BA
        BSET    D1,$00(A0,D0.W)                 ; $2AC1BC
        SUBI.B  #$0210,(A0)                     ; $2AC1C0
        BTST    D2,D0                           ; $2AC1C4
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2AC1C6
        SUBI.B  #$0400,D0                       ; $2AC1CC
        BSET    D1,$10(A0,D0.W)                 ; $2AC1D0
        BCS.W  $2AC616                          ; $2AC1D4
        SUBI.W  #$0460,(A0)                     ; $2AC1D8
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2AC1DC
        SUBI.L  #$04800410,(A0)                 ; $2AC1E2
        BCC.W  $2AC64A                          ; $2AC1E8
        SUBI.W  #$0000,(A0)                     ; $2AC1EC
        BNE.W  $2AC592                          ; $2AC1F0
        BCLR    D1,-$40(A0,D0.W)                ; $2AC1F4
        BSET    D1,(A0)                         ; $2AC1F8
        DC.W    $0000,$6600         ; $2AC1FA ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2AC1FE
