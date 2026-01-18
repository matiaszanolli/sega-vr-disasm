; Generated assembly for $2AE200-$2B0200
; Branch targets: 129
; Labels: 116
; Format: DC.W with decoded mnemonics as comments

        org     $2AE200

        MOVE.W  -$005C(A6),(A7)+                ; $2AE200
        DC.W    $050D               ; $2AE204 BTST    D2,A5
        MOVE.W  -$0003(A6),(A7)+                ; $2AE206
        DC.W    $050D               ; $2AE20A BTST    D2,A5
        MOVE.W  A3,-$0003(A7)                   ; $2AE20C
        SUBI.W  #$012C,D5                       ; $2AE210
        DC.W    $002C,$03E4,$0197   ; $2AE214 ORI.B  #$03E4,$0197(A4)
        ORI.L  #$02B40028,D5                    ; $2AE21A
        DC.W    $00F4               ; $2AE220 DC.W    $00F4
        BTST    D1,(A5)                         ; $2AE222
        DC.W    $FFBE,$009C         ; $2AE224 MOVE.W  <EA:3E>,-$64(A7,D0.W)
        SUBI.W  #$013A,$00B8(A0)                ; $2AE228
        BTST    D1,$FFCC.W                      ; $2AE22E
        BTST    D0,$031B(A0)                    ; $2AE232
        MOVE.W  -$4E(A1,D0.W),$52(A7,D0.W)      ; $2AE236
        DC.W    $0010,$00CF         ; $2AE23C ORI.B  #$00CF,(A0)
        BSET    D0,$00C7(A2)                    ; $2AE240
        BTST    D0,(A7)                         ; $2AE244
        BCLR    D0,$67(A4,D0.W)                 ; $2AE246
        DC.W    $00F9               ; $2AE24A DC.W    $00F9
        BTST    D1,-$46(A4,A7.L)                ; $2AE24C
        BTST    D0,(A5)                         ; $2AE250
        DC.W    $01CC               ; $2AE252 BSET    D0,A4
        ORI.W  #$015D,$39(A0,D0.W)              ; $2AE254
        DC.W    $FFE4               ; $2AE25A MOVE.W  -(A4),<EA:3F>
        BTST    D0,-(A7)                        ; $2AE25C
        DC.W    $0108               ; $2AE25E BTST    D0,A0
        DC.W    $0004,$0127         ; $2AE260 ORI.B  #$0127,D4
        BCLR    D0,$00F1(A0)                    ; $2AE264
        BTST    D0,-(A7)                        ; $2AE268
        BSET    D0,-$43(A5,D0.W)                ; $2AE26A
        BTST    D0,-(A7)                        ; $2AE26E
        DC.W    $0010,$6E00         ; $2AE270 ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2AE274 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AE278 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2AE27C
        ORI.W  #$0050,D0                        ; $2AE280
        SUBI.B  #$7000,(A0)                     ; $2AE284
        ORI.W  #$0070,-(A0)                     ; $2AE288
        SUBI.B  #$6F00,(A0)                     ; $2AE28C
        DC.W    $0000,$0030         ; $2AE290 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AE294 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AE298 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AE29C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AE2A0
        DC.W    $00B0,$0210,$0400,$00D0; $2AE2A6 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AE2AE DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AE2B0
        ORI.L  #$00900611,-(A0)                 ; $2AE2B4
        BTST    D3,D1                           ; $2AE2BA
        DC.W    $00B0,$0010,$6A00,$00E0; $2AE2BC ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AE2C4 DC.W    $00F0
        BTST    D0,D0                           ; $2AE2C6
        BTST    D0,(A0)                         ; $2AE2C8
        DC.W    $0210,$6C00         ; $2AE2CA ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AE2CE
        SUBI.B  #$6B00,(A0)                     ; $2AE2D2
        BTST    D0,D0                           ; $2AE2D6
        DC.W    $00F0               ; $2AE2D8 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AE2DA ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AE2DE DC.W    $00E0
        DC.W    $0010,$6300         ; $2AE2E0 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AE2E4
        BCHG    D0,(A0)                         ; $2AE2E6
        BCHG    D0,-(A0)                        ; $2AE2E8
        BCHG    D0,$10(A0,D0.W)                 ; $2AE2EA
        BCS.W  loc_2AE480                       ; $2AE2EE
        BCLR    D0,D0                           ; $2AE2F2
        SUBI.B  #$6400,(A0)                     ; $2AE2F4
        BCHG    D0,-(A0)                        ; $2AE2F8
        BCHG    D0,(A0)                         ; $2AE2FA
        ADDI.B  #$6201,(A1)                     ; $2AE2FC
        BCHG    D0,$10(A0,D0.W)                 ; $2AE300
        BPL.W  loc_2AE4E6                       ; $2AE304
        BSET    D0,$00(A0,D0.W)                 ; $2AE308
        DC.W    $0210,$0210         ; $2AE30C ANDI.B  #$0210,(A0)
        BGE.W  loc_2AE542                       ; $2AE310
        DC.W    $0220,$0410         ; $2AE314 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2AE51A                       ; $2AE318
        BSET    D0,$11(A0,D0.W)                 ; $2AE31C
        BVS.S  loc_2AE323                       ; $2AE320
        DC.W    $0210,$0010         ; $2AE322 ANDI.B  #$0010,(A0)
        BLS.W  loc_2AE568                       ; $2AE326
        ANDI.W  #$0260,(A0)                     ; $2AE32A
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2AE32E
        ANDI.L  #$02800410,(A0)                 ; $2AE334
        BCC.W  loc_2AE59C                       ; $2AE33A
        ANDI.W  #$0211,(A0)                     ; $2AE33E
        BHI.S  loc_2AE345                       ; $2AE342
        ANDI.W  #$0010,D0                       ; $2AE344
        BNE.W  loc_2AE5EA                       ; $2AE348
        DC.W    $02B0,$02C0,$02D0,$0610; $2AE34C ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2AE636                       ; $2AE354
        DC.W    $02F0               ; $2AE358 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2AE35A
        BTST    D1,D0                           ; $2AE35E
        BTST    D1,(A0)                         ; $2AE360
        SUBI.B  #$6700,(A0)                     ; $2AE362
        ANDI.L  #$02D00010,-(A0)                ; $2AE366
        BTST    D1,D0                           ; $2AE36C
        BTST    D1,-(A0)                        ; $2AE36E
        BTST    D1,$40(A0,D0.W)                 ; $2AE370
        BCHG    D1,(A0)                         ; $2AE374
        DC.W    $0210,$0500         ; $2AE376 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2AE37A
        SUBI.B  #$0400,(A0)                     ; $2AE37E
        BCHG    D1,D0                           ; $2AE382
        BTST    D1,$10(A0,D0.W)                 ; $2AE384
        BCS.W  loc_2AE70A                       ; $2AE388
        BCLR    D1,(A0)                         ; $2AE38C
        BCLR    D1,-(A0)                        ; $2AE38E
        BCLR    D1,$10(A0,D0.W)                 ; $2AE390
        BLS.W  loc_2AE766                       ; $2AE394
        BSET    D1,D0                           ; $2AE398
        SUBI.B  #$6400,(A0)                     ; $2AE39A
        BCLR    D1,-(A0)                        ; $2AE39E
        BCLR    D1,(A0)                         ; $2AE3A0
        DC.W    $0010,$0300         ; $2AE3A2 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2AE3A6
        SUBI.W  #$0450,D0                       ; $2AE3AA
        DC.W    $0210,$0500         ; $2AE3AE ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2AE3B2
        SUBI.B  #$0440,D0                       ; $2AE3B8
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2AE3BC
        SUBI.L  #$049004A0,D0                   ; $2AE3C2
        DC.W    $04B0,$0210,$6300,$04D0; $2AE3C8 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2AE3D0 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2AE3D2
        SUBI.L  #$04900000,-(A0)                ; $2AE3D6
        BVS.W  loc_2AE57E                       ; $2AE3DC
        BCLR    D0,-$40(A0,D0.W)                ; $2AE3E0
        BSET    D0,(A0)                         ; $2AE3E4
        DC.W    $0000,$6600         ; $2AE3E6 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2AE3EA
        BSET    D1,$00(A0,D0.W)                 ; $2AE3EC
        SUBI.B  #$0000,(A0)                     ; $2AE3F0
        BNE.W  loc_2AE8D6                       ; $2AE3F4
        DC.W    $04F0               ; $2AE3F8 DC.W    $04F0
        BTST    D2,D0                           ; $2AE3FA
        BTST    D2,(A0)                         ; $2AE3FC
        CMPI.B  #$0052,D0                       ; $2AE3FE
        ORI.W  #$04BE,(A2)                      ; $2AE402
        DC.W    $0225,$FFA3         ; $2AE406 ANDI.B  #$FFA3,-(A5)
        SUBI.L  #$020600BF,(A4)+                ; $2AE40A
        BCLR    D2,-$06(A7,D0.W)                ; $2AE410
        BTST    D0,(A1)+                        ; $2AE414
        BSET    D2,-(A0)                        ; $2AE416
        BTST    D1,-(A0)                        ; $2AE418
        DC.W    $FFC5               ; $2AE41A MOVE.W  D5,<EA:3F>
        SUBI.B  #$0295,(A1)                     ; $2AE41C
        DC.W    $00BF,$050C,$03A9   ; $2AE420 ORI.L  #$050C03A9,<EA:3F>
        BTST    D0,(A0)+                        ; $2AE426
        SUBI.B  #$02B5,-$5D(A4,A7.L)            ; $2AE428
        BTST    D2,-$31(A5,D0.W)                ; $2AE42E
        DC.W    $FFC4               ; $2AE432 MOVE.W  D4,<EA:3F>
        BCHG    D2,(A1)+                        ; $2AE434
        DC.W    $03BE               ; $2AE436 BCLR    D1,<EA:3E>
        DC.W    $0016,$05BC         ; $2AE438 ORI.B  #$05BC,(A6)
        BTST    D1,-(A6)                        ; $2AE43C
        ORI.W  #$0672,$03DA(A3)                 ; $2AE43E
        ORI.L  #$05EA044B,(A5)                  ; $2AE444
        DC.W    $0038,$0544,$03AB   ; $2AE44A ORI.B  #$0544,$03AB.W
        DC.W    $00C5               ; $2AE450 DC.W    $00C5
        BSET    D2,(A6)                         ; $2AE452
        SUBI.B  #$00E7,$059F.W                  ; $2AE454
        BCHG    D1,-(A4)                        ; $2AE45A
        MOVE.W  $6E(A2,D0.W),$5E(A7,D0.W)       ; $2AE45C
        MOVE.W  A1,$0475(A7)                    ; $2AE462
        ANDI.W  #$FF61,-(A0)                    ; $2AE466
        SUBI.L  #$024FFFCC,(A0)                 ; $2AE46A
        BCHG    D2,(A1)                         ; $2AE470
        BCLR    D1,-$0069(A7)                   ; $2AE472
        SUBI.W  #$0299,D2                       ; $2AE476
        MOVE.W  $57(A2,D0.W),-$5B(A7,D0.W)      ; $2AE47A
loc_2AE480:
        MOVE.W  -(A0),$48(A7,D0.W)              ; $2AE480
        ANDI.W  #$FF60,$63(A3,D0.W)             ; $2AE484
        BSET    D0,D1                           ; $2AE48A
        MOVE.W  $05AF(A5),-$33(A7,D0.W)         ; $2AE48C
        DC.W    $FFFD               ; $2AE492 MOVE.W  <EA:3D>,<EA:3F>
        SUBI.B  #$0260,-$0056(A0)               ; $2AE494
        BCLR    D2,D1                           ; $2AE49A
        DC.W    $0188               ; $2AE49C BCLR    D0,A0
        DC.W    $0006,$04B2         ; $2AE49E ORI.B  #$04B2,D6
        BCLR    D0,-$07(A6,A7.L)                ; $2AE4A2
        DC.W    $06DC               ; $2AE4A6 DC.W    $06DC
        BSET    D0,$003205BD                    ; $2AE4A8
        BTST    D0,-(A4)                        ; $2AE4AE
        DC.W    $003C,$047C,$00F1   ; $2AE4B0 ORI.B  #$047C,#$00F1
        DC.W    $001D,$05E9         ; $2AE4B6 ORI.B  #$05E9,(A5)+
        DC.W    $022E,$0101,$05B3   ; $2AE4BA ANDI.B  #$0101,$05B3(A6)
        DC.W    $0203,$0159         ; $2AE4C0 ANDI.B  #$0159,D3
        DC.W    $04F6               ; $2AE4C4 DC.W    $04F6
        BTST    D1,$0177(A7)                    ; $2AE4C6
        BTST    D2,(A3)+                        ; $2AE4CA
        BCHG    D1,$23(A5,D0.W)                 ; $2AE4CC
        DC.W    $058B               ; $2AE4D0 BCLR    D2,A3
        BSET    D0,-$0F(A4,D0.W)                ; $2AE4D2
        DC.W    $04BD,$033C,$0114   ; $2AE4D6 SUBI.L  #$033C0114,<EA:3D>
        BTST    D3,-$4E(A4,D0.W)                ; $2AE4DC
        BTST    D0,(A7)                         ; $2AE4E0
        DC.W    $06DB               ; $2AE4E2 DC.W    $06DB
        BCLR    D0,(A0)+                        ; $2AE4E4
loc_2AE4E6:
        BCHG    D0,(A4)                         ; $2AE4E6
        BCLR    D2,(A7)                         ; $2AE4E8
        DC.W    $0208,$014D         ; $2AE4EA ANDI.B  #$014D,A0
        BCLR    D2,$0239(A1)                    ; $2AE4EE
        DC.W    $010E               ; $2AE4F2 BTST    D0,A6
        BTST    D3,(A1)+                        ; $2AE4F4
        BCHG    D0,-(A4)                        ; $2AE4F6
        DC.W    $010A               ; $2AE4F8 BTST    D0,A2
        DC.W    $058F               ; $2AE4FA BCLR    D2,A7
        BSET    D0,$0101(A3)                    ; $2AE4FC
        SUBI.B  #$00C7,-$0071(A0)               ; $2AE500
        SUBI.B  #$00DA,-$11(A4,D0.W)            ; $2AE506
        DC.W    $04B3,$024B,$00B8,$04A9; $2AE50C SUBI.L  #$024B00B8,-$57(A3,D0.W)
        DC.W    $023C,$FF97,$0385   ; $2AE514 ANDI.B  #$FF97,#$0385
loc_2AE51A:
        BTST    D0,(A6)                         ; $2AE51A
        DC.W    $00F1               ; $2AE51C DC.W    $00F1
        SUBI.B  #$0288,D4                       ; $2AE51E
        DC.W    $00BA,$0379,$0104,$FF91; $2AE522 ORI.L  #$03790104,-$006F(PC)
        BSET    D1,$0278(PC)                    ; $2AE52A
        MOVE.W  (A1)+,-$67(A7,D0.W)             ; $2AE52E
        DC.W    $00C6               ; $2AE532 DC.W    $00C6
        DC.W    $0031,$056A,$0033   ; $2AE534 ORI.B  #$056A,$33(A1,D0.W)
        DC.W    $FFEB,$0397         ; $2AE53A MOVE.W  $0397(A3),<EA:3F>
        DC.W    $00C6               ; $2AE53E DC.W    $00C6
        DC.W    $FFF1,$03C7         ; $2AE540 MOVE.W  -$39(A1,D0.W),<EA:3F>
        BCHG    D0,(A2)+                        ; $2AE544
        DC.W    $0038,$0597,$00C5   ; $2AE546 ORI.B  #$0597,$00C5.W
        MOVE.W  -(A1),-$3C(A7,D0.W)             ; $2AE54C
        BCHG    D0,(A1)+                        ; $2AE550
        MOVE.W  -(A7),$61(A7,D0.W)              ; $2AE552
        MOVE.W  $003204FC,-(A7)                 ; $2AE556
        MOVE.W  A1,-$0004(A7)                   ; $2AE55C
        DC.W    $0549               ; $2AE560 BCHG    D2,A1
        DC.W    $00DB               ; $2AE562 DC.W    $00DB
        DC.W    $FFE4               ; $2AE564 MOVE.W  -(A4),<EA:3F>
        BCLR    D2,$00CA(A6)                    ; $2AE566
        DC.W    $0019,$0562         ; $2AE56A ORI.B  #$0562,(A1)+
        MOVE.W  -$35(A3,A7.L),-(A7)             ; $2AE56E
        BCLR    D2,-$3C(A0,D0.W)                ; $2AE572
        MOVE.W  $10(A4,D0.W),$21(A7,A7.L)       ; $2AE576
        MOVE.W  $10(A6,D0.W),-$1A(A7,A7.L)      ; $2AE57C
        MOVE.W  $00(A6,D0.W),-$1A(A7,A7.L)      ; $2AE582
        DC.W    $000F,$0500         ; $2AE588 ORI.B  #$0500,A7
        MOVE.W  D3,$000F(A7)                    ; $2AE58C
        SUBI.W  #$0128,D4                       ; $2AE590
        DC.W    $002D,$03E3,$0195   ; $2AE594 ORI.B  #$03E3,$0195(A5)
        ORI.L  #$02B40026,D5                    ; $2AE59A
        DC.W    $00F6               ; $2AE5A0 DC.W    $00F6
        BTST    D1,(A5)                         ; $2AE5A2
        MOVE.W  -$62(PC,D0.W),$67(A7,D0.W)      ; $2AE5A4
        BTST    D0,$00B9.W                      ; $2AE5AA
        BTST    D1,$FFCA.W                      ; $2AE5AE
        BTST    D0,$031B(A3)                    ; $2AE5B2
        MOVE.W  $00B4(A6),$52(A7,D0.W)          ; $2AE5B6
        DC.W    $000D,$00D1         ; $2AE5BC ORI.B  #$00D1,A5
        BSET    D0,$00C6(A3)                    ; $2AE5C0
        BTST    D0,(A7)                         ; $2AE5C4
        BCLR    D0,$66(A4,D0.W)                 ; $2AE5C6
        DC.W    $00F9               ; $2AE5CA DC.W    $00F9
        BTST    D1,-$48(A4,A7.L)                ; $2AE5CC
        BTST    D0,(A0)+                        ; $2AE5D0
        DC.W    $01CC               ; $2AE5D2 BSET    D0,A4
        ORI.W  #$015D,$3A(A0,D0.W)              ; $2AE5D4
        DC.W    $FFE3               ; $2AE5DA MOVE.W  -(A3),<EA:3F>
        BTST    D0,-(A7)                        ; $2AE5DC
        DC.W    $0109               ; $2AE5DE BTST    D0,A1
        DC.W    $0004,$0127         ; $2AE5E0 ORI.B  #$0127,D4
        BCLR    D0,$00F1(A1)                    ; $2AE5E4
        BTST    D0,-(A7)                        ; $2AE5E8
loc_2AE5EA:
        BSET    D0,-$43(A6,D0.W)                ; $2AE5EA
        BTST    D0,-(A7)                        ; $2AE5EE
        DC.W    $0010,$6E00         ; $2AE5F0 ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2AE5F4 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AE5F8 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2AE5FC
        ORI.W  #$0050,D0                        ; $2AE600
        SUBI.B  #$7000,(A0)                     ; $2AE604
        ORI.W  #$0070,-(A0)                     ; $2AE608
        SUBI.B  #$6F00,(A0)                     ; $2AE60C
        DC.W    $0000,$0030         ; $2AE610 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AE614 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AE618 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AE61C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AE620
        DC.W    $00B0,$0210,$0400,$00D0; $2AE626 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AE62E DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AE630
        ORI.L  #$00900611,-(A0)                 ; $2AE634
        BTST    D3,D1                           ; $2AE63A
        DC.W    $00B0,$0010,$6A00,$00E0; $2AE63C ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AE644 DC.W    $00F0
        BTST    D0,D0                           ; $2AE646
        BTST    D0,(A0)                         ; $2AE648
        DC.W    $0210,$6C00         ; $2AE64A ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AE64E
        SUBI.B  #$6B00,(A0)                     ; $2AE652
        BTST    D0,D0                           ; $2AE656
        DC.W    $00F0               ; $2AE658 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AE65A ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AE65E DC.W    $00E0
        DC.W    $0010,$6300         ; $2AE660 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AE664
        BCHG    D0,(A0)                         ; $2AE666
        BCHG    D0,-(A0)                        ; $2AE668
        BCHG    D0,$10(A0,D0.W)                 ; $2AE66A
        BCS.W  loc_2AE800                       ; $2AE66E
        BCLR    D0,D0                           ; $2AE672
        SUBI.B  #$6400,(A0)                     ; $2AE674
        BCHG    D0,-(A0)                        ; $2AE678
        BCHG    D0,(A0)                         ; $2AE67A
        ADDI.B  #$6201,(A1)                     ; $2AE67C
        BCHG    D0,$10(A0,D0.W)                 ; $2AE680
        BPL.W  loc_2AE866                       ; $2AE684
        BSET    D0,$00(A0,D0.W)                 ; $2AE688
        DC.W    $0210,$0210         ; $2AE68C ANDI.B  #$0210,(A0)
        BGE.W  loc_2AE8C2                       ; $2AE690
        DC.W    $0220,$0410         ; $2AE694 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2AE89A                       ; $2AE698
        BSET    D0,$11(A0,D0.W)                 ; $2AE69C
        BVS.S  loc_2AE6A3                       ; $2AE6A0
        DC.W    $0210,$0010         ; $2AE6A2 ANDI.B  #$0010,(A0)
        BLS.W  loc_2AE8E8                       ; $2AE6A6
        ANDI.W  #$0260,(A0)                     ; $2AE6AA
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2AE6AE
        ANDI.L  #$02800410,(A0)                 ; $2AE6B4
        BCC.W  loc_2AE91C                       ; $2AE6BA
        ANDI.W  #$0211,(A0)                     ; $2AE6BE
        BHI.S  loc_2AE6C5                       ; $2AE6C2
        ANDI.W  #$0010,D0                       ; $2AE6C4
        BNE.W  loc_2AE96A                       ; $2AE6C8
        DC.W    $02B0,$02C0,$02D0,$0610; $2AE6CC ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2AE9B6                       ; $2AE6D4
        DC.W    $02F0               ; $2AE6D8 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2AE6DA
        BTST    D1,D0                           ; $2AE6DE
        BTST    D1,(A0)                         ; $2AE6E0
        SUBI.B  #$6700,(A0)                     ; $2AE6E2
        ANDI.L  #$02D00010,-(A0)                ; $2AE6E6
        BTST    D1,D0                           ; $2AE6EC
        BTST    D1,-(A0)                        ; $2AE6EE
        BTST    D1,$40(A0,D0.W)                 ; $2AE6F0
        BCHG    D1,(A0)                         ; $2AE6F4
        DC.W    $0210,$0500         ; $2AE6F6 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2AE6FA
        SUBI.B  #$0400,(A0)                     ; $2AE6FE
        BCHG    D1,D0                           ; $2AE702
        BTST    D1,$10(A0,D0.W)                 ; $2AE704
        BCS.W  loc_2AEA8A                       ; $2AE708
        BCLR    D1,(A0)                         ; $2AE70C
        BCLR    D1,-(A0)                        ; $2AE70E
        BCLR    D1,$10(A0,D0.W)                 ; $2AE710
        BLS.W  loc_2AEAE6                       ; $2AE714
        BSET    D1,D0                           ; $2AE718
        SUBI.B  #$6400,(A0)                     ; $2AE71A
        BCLR    D1,-(A0)                        ; $2AE71E
        BCLR    D1,(A0)                         ; $2AE720
        DC.W    $0010,$0300         ; $2AE722 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2AE726
        SUBI.W  #$0450,D0                       ; $2AE72A
        DC.W    $0210,$0500         ; $2AE72E ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2AE732
        SUBI.B  #$0440,D0                       ; $2AE738
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2AE73C
        SUBI.L  #$049004A0,D0                   ; $2AE742
        DC.W    $04B0,$0210,$6300,$04D0; $2AE748 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2AE750 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2AE752
        SUBI.L  #$04900000,-(A0)                ; $2AE756
        BVS.W  loc_2AE8FE                       ; $2AE75C
        BCLR    D0,-$40(A0,D0.W)                ; $2AE760
        BSET    D0,(A0)                         ; $2AE764
loc_2AE766:
        DC.W    $0000,$6600         ; $2AE766 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2AE76A
        BSET    D1,$00(A0,D0.W)                 ; $2AE76C
        SUBI.B  #$0000,(A0)                     ; $2AE770
        BNE.W  loc_2AEC56                       ; $2AE774
        DC.W    $04F0               ; $2AE778 DC.W    $04F0
        BTST    D2,D0                           ; $2AE77A
        BTST    D2,(A0)                         ; $2AE77C
        CMPI.B  #$0052,D0                       ; $2AE77E
        ORI.W  #$04BF,(A2)                      ; $2AE782
        DC.W    $0222,$FFA5         ; $2AE786 ANDI.B  #$FFA5,-(A2)
        SUBI.L  #$020500C0,(A1)+                ; $2AE78A
        BCLR    D2,$02F1(PC)                    ; $2AE790
        BTST    D0,(A4)+                        ; $2AE794
        BSET    D2,-(A7)                        ; $2AE796
        BTST    D1,(A5)                         ; $2AE798
        DC.W    $FFC8               ; $2AE79A MOVE.W  A0,<EA:3F>
        SUBI.B  #$0298,(A2)                     ; $2AE79C
        DC.W    $00BE,$0514,$03A5   ; $2AE7A0 ORI.L  #$051403A5,<EA:3E>
        BTST    D0,(A1)+                        ; $2AE7A6
        SUBI.B  #$02B5,$FFA2.W                  ; $2AE7A8
        BCHG    D2,D1                           ; $2AE7AE
        DC.W    $03C9               ; $2AE7B0 BSET    D1,A1
        DC.W    $FFC5               ; $2AE7B2 MOVE.W  D5,<EA:3F>
        BCHG    D2,-(A4)                        ; $2AE7B4
        BCLR    D1,$17(A7,D0.W)                 ; $2AE7B6
        BSET    D2,D1                           ; $2AE7BA
        BTST    D1,(A5)+                        ; $2AE7BC
        ORI.W  #$067D,$03CA(A6)                 ; $2AE7BE
        ORI.L  #$05F90440,(A0)+                 ; $2AE7C4
        DC.W    $0039,$054C,$03A4,$00C6; $2AE7CA ORI.B  #$054C,$03A400C6
        BSET    D2,-(A2)                        ; $2AE7D2
        SUBI.B  #$00E8,$05A7(A7)                ; $2AE7D4
        BCHG    D1,(A5)+                        ; $2AE7DA
        MOVE.W  $77(A4,D0.W),$57(A7,D0.W)       ; $2AE7DC
        MOVE.W  A3,$0480(A7)                    ; $2AE7E2
        ANDI.W  #$FF60,(A0)+                    ; $2AE7E6
        SUBI.L  #$0247FFCA,(A1)+                ; $2AE7EA
        BCHG    D2,(A2)+                        ; $2AE7F0
        BCLR    D1,-(A6)                        ; $2AE7F2
        MOVE.W  (A1)+,$4B(A7,D0.W)              ; $2AE7F4
        ANDI.L  #$FFB00461,(A1)                 ; $2AE7F8
        ANDI.L  #$FF9F0452,(A4)+                ; $2AE7FE
        ANDI.W  #$FF5F,$056A(A3)                ; $2AE804
        BCLR    D0,-$52(A5,A7.L)                ; $2AE80A
        BCLR    D2,-$42(A4,D0.W)                ; $2AE80E
        DC.W    $FFFF               ; $2AE812 MOVE.W  <EA:3F>,<EA:3F>
        SUBI.B  #$0259,-$59(A2,A7.L)            ; $2AE814
        BCLR    D2,D5                           ; $2AE81A
        BCHG    D0,$000704B7                    ; $2AE81C
        BCLR    D0,-$0009(A4)                   ; $2AE822
        DC.W    $06E1               ; $2AE826 DC.W    $06E1
        BSET    D0,-(A5)                        ; $2AE828
        DC.W    $0038,$05BE,$0115   ; $2AE82A ORI.B  #$05BE,$0115.W
        DC.W    $003C,$047E,$00E7   ; $2AE830 ORI.B  #$047E,#$00E7
        DC.W    $0019,$05C9         ; $2AE836 ORI.B  #$05C9,(A1)+
        DC.W    $020F,$00FD         ; $2AE83A ANDI.B  #$00FD,A7
        DC.W    $058F               ; $2AE83E BCLR    D2,A7
        BSET    D0,$0156(A3)                    ; $2AE840
        DC.W    $04FE               ; $2AE844 DC.W    $04FE
        BTST    D1,$0179(A7)                    ; $2AE846
        BTST    D2,$036F(A4)                    ; $2AE84A
        BTST    D0,-(A5)                        ; $2AE84E
        BCHG    D2,-(A5)                        ; $2AE850
        BSET    D0,-(A3)                        ; $2AE852
        DC.W    $00EF               ; $2AE854 DC.W    $00EF
        DC.W    $04C7               ; $2AE856 DC.W    $04C7
        BCHG    D1,D4                           ; $2AE858
        BTST    D0,(A6)                         ; $2AE85A
        BTST    D3,(A4)                         ; $2AE85C
        DC.W    $01C8               ; $2AE85E BSET    D0,A0
        BTST    D0,(A7)+                        ; $2AE860
        DC.W    $06BE,$01A4,$015B   ; $2AE862 ADDI.L  #$01A4015B,<EA:3E>
        BCHG    D2,$01EA(A6)                    ; $2AE868
        DC.W    $0149               ; $2AE86C BCHG    D0,A1
        BCHG    D2,#$021D                       ; $2AE86E
        DC.W    $010A               ; $2AE872 BTST    D0,A2
        BTST    D3,D4                           ; $2AE874
        BCHG    D0,$12(A7,D0.W)                 ; $2AE876
        BCHG    D2,$01CC(A4)                    ; $2AE87A
        DC.W    $00FC               ; $2AE87E DC.W    $00FC
        SUBI.B  #$00C7,-$0070(A3)               ; $2AE880
        SUBI.B  #$00DB,-$11(A3,D0.W)            ; $2AE886
        DC.W    $04B2,$024C,$00B9,$04AB; $2AE88C SUBI.L  #$024C00B9,-$55(A2,D0.W)
        DC.W    $023D,$FF98         ; $2AE894 ANDI.B  #$FF98,<EA:3D>
        BCLR    D1,D4                           ; $2AE898
loc_2AE89A:
        BTST    D0,(A6)                         ; $2AE89A
        DC.W    $00F0               ; $2AE89C DC.W    $00F0
        SUBI.B  #$0289,D3                       ; $2AE89E
        DC.W    $00B9,$037B,$0103,$FF90,$03FB; $2AE8A2 ORI.L  #$037B0103,$FF9003FB
        ANDI.W  #$FF99,$056E.W                  ; $2AE8AC
        BSET    D0,-(A2)                        ; $2AE8B2
        DC.W    $FFC6               ; $2AE8B4 MOVE.W  D6,<EA:3F>
        BCLR    D2,D7                           ; $2AE8B6
        BCHG    D0,-(A2)                        ; $2AE8B8
        MOVE.W  (A2)+,$03E1(A7)                 ; $2AE8BA
        ORI.L  #$FFE903C8,(A7)                  ; $2AE8BE
        BTST    D0,(A7)                         ; $2AE8C4
        ORI.W  #$0538,(A4)                      ; $2AE8C6
        BSET    D0,$42(A5,A7.L)                 ; $2AE8CA
        BCLR    D1,(A2)                         ; $2AE8CE
        BTST    D0,-$002F(A4)                   ; $2AE8D0
        DC.W    $05CB               ; $2AE8D4 BSET    D2,A3
loc_2AE8D6:
        ORI.W  #$FF63,-(A5)                     ; $2AE8D6
        BCHG    D2,(A3)+                        ; $2AE8DA
        ORI.W  #$FF50,(A6)                      ; $2AE8DC
        BTST    D2,(A0)+                        ; $2AE8E0
        BSET    D0,-(A5)                        ; $2AE8E2
        MOVE.W  (A3),-$77(A7,D0.W)              ; $2AE8E4
loc_2AE8E8:
        BSET    D0,-$5B(A4,A7.L)                ; $2AE8E8
        BCLR    D2,$0070(A3)                    ; $2AE8EC
        MOVE.W  D2,-(A7)                        ; $2AE8F0
        BCHG    D2,$0200(A0)                    ; $2AE8F2
        MOVE.W  D5,$066F(A7)                    ; $2AE8F6
        ORI.W  #$FEF5,D6                        ; $2AE8FA
loc_2AE8FE:
        ADDI.W  #$000A,-$010B(A7)               ; $2AE8FE
        BCHG    D2,(A7)+                        ; $2AE904
        DC.W    $000A,$FF4E         ; $2AE906 ORI.B  #$FF4E,A2
        BCHG    D2,(A7)+                        ; $2AE90A
        ORI.W  #$FF4E,-(A7)                     ; $2AE90C
        SUBI.W  #$0129,D4                       ; $2AE910
        DC.W    $002D,$03E2,$0195   ; $2AE914 ORI.B  #$03E2,$0195(A5)
        ORI.L  #$02B40026,D5                    ; $2AE91A
        DC.W    $00F7               ; $2AE920 DC.W    $00F7
        BTST    D1,(A6)                         ; $2AE922
        MOVE.W  -$60(PC,D0.W),$67(A7,D0.W)      ; $2AE924
        BTST    D0,$00B90338                    ; $2AE92A
        DC.W    $FFCA               ; $2AE930 MOVE.W  A2,<EA:3F>
        BTST    D0,$031B(A4)                    ; $2AE932
        MOVE.W  $00B6(A6),$53(A7,D0.W)          ; $2AE936
        DC.W    $000D,$00D2         ; $2AE93C ORI.B  #$00D2,A5
        BSET    D0,$00C6(A3)                    ; $2AE940
        BTST    D0,(A7)                         ; $2AE944
        BCLR    D0,$66(A4,D0.W)                 ; $2AE946
        DC.W    $00FA               ; $2AE94A DC.W    $00FA
        BTST    D1,-$48(A4,A7.L)                ; $2AE94C
        BTST    D0,(A1)+                        ; $2AE950
        DC.W    $01CC               ; $2AE952 BSET    D0,A4
        ORI.W  #$015E,$3A(A0,D0.W)              ; $2AE954
        DC.W    $FFE3               ; $2AE95A MOVE.W  -(A3),<EA:3F>
        BTST    D0,-(A7)                        ; $2AE95C
        DC.W    $0109               ; $2AE95E BTST    D0,A1
        DC.W    $0004,$0127         ; $2AE960 ORI.B  #$0127,D4
        BCLR    D0,$00F1(A1)                    ; $2AE964
        BTST    D0,-(A7)                        ; $2AE968
loc_2AE96A:
        BSET    D0,-$43(A6,D0.W)                ; $2AE96A
        BTST    D0,-(A7)                        ; $2AE96E
        DC.W    $0010,$6E00         ; $2AE970 ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2AE974 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AE978 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2AE97C
        ORI.W  #$0050,D0                        ; $2AE980
        SUBI.B  #$7000,(A0)                     ; $2AE984
        ORI.W  #$0070,-(A0)                     ; $2AE988
        SUBI.B  #$6F00,(A0)                     ; $2AE98C
        DC.W    $0000,$0030         ; $2AE990 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AE994 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AE998 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AE99C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AE9A0
        DC.W    $00B0,$0210,$0400,$00D0; $2AE9A6 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AE9AE DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AE9B0
        ORI.L  #$00900611,-(A0)                 ; $2AE9B4
        BTST    D3,D1                           ; $2AE9BA
        DC.W    $00B0,$0010,$6A00,$00E0; $2AE9BC ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AE9C4 DC.W    $00F0
        BTST    D0,D0                           ; $2AE9C6
        BTST    D0,(A0)                         ; $2AE9C8
        DC.W    $0210,$6C00         ; $2AE9CA ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AE9CE
        SUBI.B  #$6B00,(A0)                     ; $2AE9D2
        BTST    D0,D0                           ; $2AE9D6
        DC.W    $00F0               ; $2AE9D8 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AE9DA ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AE9DE DC.W    $00E0
        DC.W    $0010,$6300         ; $2AE9E0 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AE9E4
        BCHG    D0,(A0)                         ; $2AE9E6
        BCHG    D0,-(A0)                        ; $2AE9E8
        BCHG    D0,$10(A0,D0.W)                 ; $2AE9EA
        BCS.W  loc_2AEB80                       ; $2AE9EE
        BCLR    D0,D0                           ; $2AE9F2
        SUBI.B  #$6400,(A0)                     ; $2AE9F4
        BCHG    D0,-(A0)                        ; $2AE9F8
        BCHG    D0,(A0)                         ; $2AE9FA
        ADDI.B  #$6201,(A1)                     ; $2AE9FC
        BCHG    D0,$10(A0,D0.W)                 ; $2AEA00
        BPL.W  loc_2AEBE6                       ; $2AEA04
        BSET    D0,$00(A0,D0.W)                 ; $2AEA08
        DC.W    $0210,$0210         ; $2AEA0C ANDI.B  #$0210,(A0)
        BGE.W  loc_2AEC42                       ; $2AEA10
        DC.W    $0220,$0410         ; $2AEA14 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2AEC1A                       ; $2AEA18
        BSET    D0,$11(A0,D0.W)                 ; $2AEA1C
        BVS.S  loc_2AEA23                       ; $2AEA20
        DC.W    $0210,$0010         ; $2AEA22 ANDI.B  #$0010,(A0)
        BLS.W  loc_2AEC68                       ; $2AEA26
        ANDI.W  #$0260,(A0)                     ; $2AEA2A
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2AEA2E
        ANDI.L  #$02800410,(A0)                 ; $2AEA34
        BCC.W  loc_2AEC9C                       ; $2AEA3A
        ANDI.W  #$0211,(A0)                     ; $2AEA3E
        BHI.S  loc_2AEA45                       ; $2AEA42
        ANDI.W  #$0010,D0                       ; $2AEA44
        BNE.W  loc_2AECEA                       ; $2AEA48
        DC.W    $02B0,$02C0,$02D0,$0610; $2AEA4C ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2AED36                       ; $2AEA54
        DC.W    $02F0               ; $2AEA58 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2AEA5A
        BTST    D1,D0                           ; $2AEA5E
        BTST    D1,(A0)                         ; $2AEA60
        SUBI.B  #$6700,(A0)                     ; $2AEA62
        ANDI.L  #$02D00010,-(A0)                ; $2AEA66
        BTST    D1,D0                           ; $2AEA6C
        BTST    D1,-(A0)                        ; $2AEA6E
        BTST    D1,$40(A0,D0.W)                 ; $2AEA70
        BCHG    D1,(A0)                         ; $2AEA74
        DC.W    $0210,$0500         ; $2AEA76 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2AEA7A
        SUBI.B  #$0400,(A0)                     ; $2AEA7E
        BCHG    D1,D0                           ; $2AEA82
        BTST    D1,$10(A0,D0.W)                 ; $2AEA84
        BCS.W  loc_2AEE0A                       ; $2AEA88
        BCLR    D1,(A0)                         ; $2AEA8C
        BCLR    D1,-(A0)                        ; $2AEA8E
        BCLR    D1,$10(A0,D0.W)                 ; $2AEA90
        BLS.W  loc_2AEE66                       ; $2AEA94
        BSET    D1,D0                           ; $2AEA98
        SUBI.B  #$6400,(A0)                     ; $2AEA9A
        BCLR    D1,-(A0)                        ; $2AEA9E
        BCLR    D1,(A0)                         ; $2AEAA0
        DC.W    $0010,$0300         ; $2AEAA2 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2AEAA6
        SUBI.W  #$0450,D0                       ; $2AEAAA
        DC.W    $0210,$0500         ; $2AEAAE ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2AEAB2
        SUBI.B  #$0440,D0                       ; $2AEAB8
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2AEABC
        SUBI.L  #$049004A0,D0                   ; $2AEAC2
        DC.W    $04B0,$0210,$6300,$04D0; $2AEAC8 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2AEAD0 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2AEAD2
        SUBI.L  #$04900000,-(A0)                ; $2AEAD6
        BVS.W  loc_2AEC7E                       ; $2AEADC
        BCLR    D0,-$40(A0,D0.W)                ; $2AEAE0
        BSET    D0,(A0)                         ; $2AEAE4
loc_2AEAE6:
        DC.W    $0000,$6600         ; $2AEAE6 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2AEAEA
        BSET    D1,$00(A0,D0.W)                 ; $2AEAEC
        SUBI.B  #$0000,(A0)                     ; $2AEAF0
        BNE.W  loc_2AEFD6                       ; $2AEAF4
        DC.W    $04F0               ; $2AEAF8 DC.W    $04F0
        BTST    D2,D0                           ; $2AEAFA
        BTST    D2,(A0)                         ; $2AEAFC
        CMPI.B  #$0052,D0                       ; $2AEAFE
        ORI.W  #$047A,(A2)                      ; $2AEB02
        BTST    D1,-$003E(A0)                   ; $2AEB06
        SUBI.B  #$0340,(A2)+                    ; $2AEB0A
        DC.W    $00D0               ; $2AEB0E DC.W    $00D0
        BTST    D2,D0                           ; $2AEB10
        SUBI.W  #$0126,$0572(A0)                ; $2AEB12
        SUBI.W  #$FFE3,A4                       ; $2AEB18
        BCLR    D1,D7                           ; $2AEB1C
        BCLR    D1,-$6E(A6,D0.W)                ; $2AEB1E
        SUBI.W  #$04F8,A1                       ; $2AEB22
        DC.W    $00DB               ; $2AEB26 DC.W    $00DB
        BSET    D1,-(A6)                        ; $2AEB28
        BCLR    D1,(A6)+                        ; $2AEB2A
        MOVE.W  D4,-$44(A7,D0.W)                ; $2AEB2C
        DC.W    $04DD               ; $2AEB30 DC.W    $04DD
        MOVE.W  (A6),-$33(A7,D0.W)              ; $2AEB32
        DC.W    $04E2               ; $2AEB36 DC.W    $04E2
        DC.W    $FFF0,$0528         ; $2AEB38 MOVE.W  $28(A0,D0.W),<EA:3F>
        SUBI.W  #$0077,$05BF(A7)                ; $2AEB3C
        DC.W    $053F               ; $2AEB42 BTST    D2,<EA:3F>
        ORI.L  #$05450587,(A3)+                 ; $2AEB44
        DC.W    $000C,$0493         ; $2AEB4A ORI.B  #$0493,A4
        DC.W    $04F0               ; $2AEB4E DC.W    $04F0
        ORI.L  #$050B0595,(A6)                  ; $2AEB50
        DC.W    $00B3,$0484,$0459,$FF7E; $2AEB56 ORI.L  #$04840459,$7E(A3,A7.L)
        DC.W    $04D9               ; $2AEB5E DC.W    $04D9
        SUBI.B  #$FF39,$04(A5,D0.W)             ; $2AEB60
        DC.W    $04CB               ; $2AEB66 DC.W    $04CB
        MOVE.W  -$36(A3,D0.W),-$03(A7,D0.W)     ; $2AEB68
        DC.W    $0002,$04B0         ; $2AEB6E ORI.B  #$04B0,D2
        BSET    D1,-$70(A4,A7.L)                ; $2AEB72
        BSET    D2,-$67(A5,D0.W)                ; $2AEB76
        DC.W    $0014,$05CD         ; $2AEB7A ORI.B  #$05CD,(A4)
        SUBI.L  #$FFF3060F,-(A1)                ; $2AEB7E
        SUBI.L  #$FFC105E4,-(A6)                ; $2AEB84
        BSET    D2,-$0051(PC)                   ; $2AEB8A
        BCLR    D2,(A1)+                        ; $2AEB8E
        DC.W    $063E,$FFDE         ; $2AEB90 ADDI.B  #$FFDE,<EA:3E>
        ADDI.B  #$04AC,(A2)+                    ; $2AEB94
        DC.W    $0011,$05E6         ; $2AEB98 ORI.B  #$05E6,(A1)
        ADDI.W  #$FFFD,A1                       ; $2AEB9C
        ADDI.B  #$058F,$0037(PC)                ; $2AEBA0
        DC.W    $04C0               ; $2AEBA6 DC.W    $04C0
        DC.W    $070F               ; $2AEBA8 BTST    D3,A7
        MOVE.W  (A5)+,$02(A7,D0.W)              ; $2AEBAA
        DC.W    $06C0               ; $2AEBAE DC.W    $06C0
        DC.W    $0020,$06E6         ; $2AEBB0 ORI.B  #$06E6,-(A0)
        BSET    D2,$007D(A4)                    ; $2AEBB4
        SUBI.B  #$0332,(A3)+                    ; $2AEBB8
        DC.W    $010A               ; $2AEBBC BTST    D0,A2
        DC.W    $03CB               ; $2AEBBE BSET    D1,A3
        BCHG    D1,(A1)                         ; $2AEBC0
        BCHG    D0,(A0)                         ; $2AEBC2
        SUBI.W  #$049A,(A7)                     ; $2AEBC4
        BCHG    D0,(A7)                         ; $2AEBC8
        DC.W    $04B3,$0497,$0111,$03BD; $2AEBCA SUBI.L  #$04970111,-$43(A3,D0.W)
        BCHG    D1,(A3)+                        ; $2AEBD2
        DC.W    $00E2               ; $2AEBD4 DC.W    $00E2
        SUBI.W  #$04C0,(A3)                     ; $2AEBD6
        DC.W    $00EA               ; $2AEBDA DC.W    $00EA
        DC.W    $04EE               ; $2AEBDC DC.W    $04EE
        ANDI.W  #$0184,(A1)                     ; $2AEBDE
        SUBI.L  #$027101A7,A2                   ; $2AEBE2
        BCLR    D1,$64(A1,D0.W)                 ; $2AEBE8
        BTST    D0,-$1A(PC,D0.W)                ; $2AEBEC
        BCHG    D1,$00FE.W                      ; $2AEBF0
        DC.W    $04B4,$0217,$0176,$03AC; $2AEBF4 SUBI.L  #$02170176,-$54(A4,D0.W)
        DC.W    $033E               ; $2AEBFC BTST    D1,<EA:3E>
        DC.W    $00F1               ; $2AEBFE DC.W    $00F1
        SUBI.B  #$01DD,-(A6)                    ; $2AEC00
        MOVE.W  #$039E,$01DB(A7)                ; $2AEC04
        DC.W    $00C1               ; $2AEC0A DC.W    $00C1
        SUBI.B  #$0356,A4                       ; $2AEC0C
        DC.W    $00D0               ; $2AEC10 DC.W    $00D0
        DC.W    $047C,$0358,$FFC5   ; $2AEC12 SUBI.W  #$0358,#$FFC5
        DC.W    $02F9               ; $2AEC18 DC.W    $02F9
loc_2AEC1A:
        DC.W    $020D,$007C         ; $2AEC1A ANDI.B  #$007C,A5
        BCHG    D1,$0388(A0)                    ; $2AEC1E
        ORI.L  #$03820210,A4                    ; $2AEC22
        MOVE.W  $03D8.W,-(A7)                   ; $2AEC28
        DC.W    $038A               ; $2AEC2C BCLR    D1,A2
        MOVE.W  D2,$1F(A7,D0.W)                 ; $2AEC2E
        BTST    D0,-$009A(A1)                   ; $2AEC32
        DC.W    $04AF,$00F4,$FEF2,$0356; $2AEC36 SUBI.L  #$00F4FEF2,$0356(A7)
        DC.W    $020B,$FFBE         ; $2AEC3E ANDI.B  #$FFBE,A3
loc_2AEC42:
        BSET    D1,D5                           ; $2AEC42
        ANDI.W  #$0031,D1                       ; $2AEC44
        BTST    D2,(A0)+                        ; $2AEC48
        BCHG    D0,$FEEC03BE                    ; $2AEC4A
        ANDI.L  #$FFB905F9,(A1)                 ; $2AEC50
loc_2AEC56:
        ORI.W  #$FEBC,-(A3)                     ; $2AEC56
        BCLR    D2,$0040(A7)                    ; $2AEC5A
        MOVEA.W $048D(A4),A7                    ; $2AEC5E
        BTST    D0,-$00E8(A3)                   ; $2AEC62
        DC.W    $04D8               ; $2AEC66 DC.W    $04D8
loc_2AEC68:
        DC.W    $014D               ; $2AEC68 BCHG    D0,A5
        MOVE.W  $05F4(A0),$009C(A7)             ; $2AEC6A
        MOVEA.W -(A7),A7                        ; $2AEC70
        DC.W    $04D2               ; $2AEC72 DC.W    $04D2
        BCLR    D0,D6                           ; $2AEC74
        MOVE.W  (A2),-(A7)                      ; $2AEC76
        DC.W    $06BA,$004D,$FE36,$06BA; $2AEC78 ADDI.L  #$004DFE36,$06BA(PC)
        DC.W    $0012,$FE36         ; $2AEC80 ORI.B  #$FE36,(A2)
        BCLR    D2,$0012(A1)                    ; $2AEC84
        MOVE.W  A7,(A7)                         ; $2AEC88
        BCLR    D2,$006F(A1)                    ; $2AEC8A
        MOVE.W  A7,(A7)                         ; $2AEC8E
        BSET    D1,(A2)+                        ; $2AEC90
        DC.W    $0233,$FFF9,$0345   ; $2AEC92 ANDI.B  #$FFF9,$45(A3,D0.W)
        ANDI.W  #$0028,-$3A(A6,D0.W)            ; $2AEC98
        DC.W    $00CC               ; $2AEC9E DC.W    $00CC
        DC.W    $00F5               ; $2AECA0 DC.W    $00F5
        BCHG    D1,(A3)+                        ; $2AECA2
        ORI.L  #$00C503DA,A1                    ; $2AECA4
        ANDI.W  #$007A,$5C(A1,D0.W)             ; $2AECAA
        DC.W    $00C7               ; $2AECB0 DC.W    $00C7
        DC.W    $0148               ; $2AECB2 BCHG    D0,A0
        BCHG    D1,$0098(A2)                    ; $2AECB4
        DC.W    $00D6               ; $2AECB8 DC.W    $00D6
        DC.W    $034D               ; $2AECBA BCHG    D1,A5
        DC.W    $0108               ; $2AECBC BTST    D0,A0
        DC.W    $00D9               ; $2AECBE DC.W    $00D9
        BSET    D0,D3                           ; $2AECC0
        ORI.L  #$010B01E0,-(A2)                 ; $2AECC2
        DC.W    $0033,$0107,$036A   ; $2AECC8 ORI.B  #$0107,$6A(A3,D0.W)
        DC.W    $00C4               ; $2AECCE DC.W    $00C4
        BTST    D0,-$20(A2,D0.W)                ; $2AECD0
        ORI.W  #$0164,(A7)+                     ; $2AECD4
        DC.W    $0226,$FF9A         ; $2AECD8 ANDI.B  #$FF9A,-(A6)
        BTST    D0,$01F2(A5)                    ; $2AECDC
        DC.W    $FF7E,$012C         ; $2AECE0 MOVE.W  <EA:3E>,$012C(A7)
        BCHG    D0,$0079(A3)                    ; $2AECE4
        BTST    D0,-(A5)                        ; $2AECE8
loc_2AECEA:
        DC.W    $01BD               ; $2AECEA BCLR    D0,<EA:3D>
        ORI.L  #$01260010,-(A5)                 ; $2AECEC
        BGT.W  loc_2AECF4                       ; $2AECF2
        DC.W    $0010,$0020         ; $2AECF6 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2AECFA ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AED00
        SUBI.B  #$7000,(A0)                     ; $2AED04
        ORI.W  #$0070,-(A0)                     ; $2AED08
        SUBI.B  #$6F00,(A0)                     ; $2AED0C
        DC.W    $0000,$0030         ; $2AED10 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AED14 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AED18 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AED1C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AED20
        DC.W    $00B0,$0210,$0400,$00D0; $2AED26 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AED2E DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AED30
        ORI.L  #$00900611,-(A0)                 ; $2AED34
        BTST    D3,D1                           ; $2AED3A
        DC.W    $00B0,$0010,$6A00,$00E0; $2AED3C ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AED44 DC.W    $00F0
        BTST    D0,D0                           ; $2AED46
        BTST    D0,(A0)                         ; $2AED48
        DC.W    $0210,$6C00         ; $2AED4A ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AED4E
        SUBI.B  #$6B00,(A0)                     ; $2AED52
        BTST    D0,D0                           ; $2AED56
        DC.W    $00F0               ; $2AED58 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AED5A ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AED5E DC.W    $00E0
        DC.W    $0010,$6300         ; $2AED60 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AED64
        BCHG    D0,(A0)                         ; $2AED66
        BCHG    D0,-(A0)                        ; $2AED68
        BCHG    D0,$10(A0,D0.W)                 ; $2AED6A
        BCS.W  loc_2AEF00                       ; $2AED6E
        BCLR    D0,D0                           ; $2AED72
        SUBI.B  #$6400,(A0)                     ; $2AED74
        BCHG    D0,-(A0)                        ; $2AED78
        BCHG    D0,(A0)                         ; $2AED7A
        ADDI.B  #$6201,(A1)                     ; $2AED7C
        BCHG    D0,$10(A0,D0.W)                 ; $2AED80
        BPL.W  loc_2AEF66                       ; $2AED84
        BSET    D0,$00(A0,D0.W)                 ; $2AED88
        DC.W    $0210,$0210         ; $2AED8C ANDI.B  #$0210,(A0)
        BGE.W  loc_2AEFC2                       ; $2AED90
        DC.W    $0220,$0410         ; $2AED94 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2AEF9A                       ; $2AED98
        BSET    D0,$11(A0,D0.W)                 ; $2AED9C
        BVS.S  loc_2AEDA3                       ; $2AEDA0
        DC.W    $0210,$0010         ; $2AEDA2 ANDI.B  #$0010,(A0)
        BLS.W  loc_2AEFE8                       ; $2AEDA6
        ANDI.W  #$0260,(A0)                     ; $2AEDAA
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2AEDAE
        ANDI.L  #$02800410,(A0)                 ; $2AEDB4
        BCC.W  loc_2AF01C                       ; $2AEDBA
        ANDI.W  #$0211,(A0)                     ; $2AEDBE
        BHI.S  loc_2AEDC5                       ; $2AEDC2
        ANDI.W  #$0010,D0                       ; $2AEDC4
        BNE.W  loc_2AF06A                       ; $2AEDC8
        DC.W    $02B0,$02C0,$02D0,$0610; $2AEDCC ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2AF0B6                       ; $2AEDD4
        DC.W    $02F0               ; $2AEDD8 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2AEDDA
        BTST    D1,D0                           ; $2AEDDE
        BTST    D1,(A0)                         ; $2AEDE0
        SUBI.B  #$6700,(A0)                     ; $2AEDE2
        ANDI.L  #$02D00010,-(A0)                ; $2AEDE6
        BTST    D1,D0                           ; $2AEDEC
        BTST    D1,-(A0)                        ; $2AEDEE
        BTST    D1,$40(A0,D0.W)                 ; $2AEDF0
        BCHG    D1,(A0)                         ; $2AEDF4
        DC.W    $0210,$0500         ; $2AEDF6 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2AEDFA
        SUBI.B  #$0400,(A0)                     ; $2AEDFE
        BCHG    D1,D0                           ; $2AEE02
        BTST    D1,$10(A0,D0.W)                 ; $2AEE04
        BCS.W  loc_2AF18A                       ; $2AEE08
        BCLR    D1,(A0)                         ; $2AEE0C
        BCLR    D1,-(A0)                        ; $2AEE0E
        BCLR    D1,$10(A0,D0.W)                 ; $2AEE10
        BLS.W  loc_2AF1E6                       ; $2AEE14
        BSET    D1,D0                           ; $2AEE18
        SUBI.B  #$6400,(A0)                     ; $2AEE1A
        BCLR    D1,-(A0)                        ; $2AEE1E
        BCLR    D1,(A0)                         ; $2AEE20
        DC.W    $0010,$0300         ; $2AEE22 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2AEE26
        SUBI.W  #$0450,D0                       ; $2AEE2A
        DC.W    $0210,$0500         ; $2AEE2E ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2AEE32
        SUBI.B  #$0440,D0                       ; $2AEE38
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2AEE3C
        SUBI.L  #$049004A0,D0                   ; $2AEE42
        DC.W    $04B0,$0210,$6300,$04D0; $2AEE48 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2AEE50 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2AEE52
        SUBI.L  #$04900000,-(A0)                ; $2AEE56
        BVS.W  loc_2AEFFE                       ; $2AEE5C
        BCLR    D0,-$40(A0,D0.W)                ; $2AEE60
        BSET    D0,(A0)                         ; $2AEE64
loc_2AEE66:
        DC.W    $0000,$6600         ; $2AEE66 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2AEE6A
        BSET    D1,$00(A0,D0.W)                 ; $2AEE6C
        SUBI.B  #$0000,(A0)                     ; $2AEE70
        BNE.W  loc_2AF356                       ; $2AEE74
        DC.W    $04F0               ; $2AEE78 DC.W    $04F0
        BTST    D2,D0                           ; $2AEE7A
        BTST    D2,(A0)                         ; $2AEE7C
        CMPI.B  #$0052,D0                       ; $2AEE7E
        ORI.W  #$0397,(A2)                      ; $2AEE82
        BSET    D1,(A3)+                        ; $2AEE86
        DC.W    $FFE6               ; $2AEE88 MOVE.W  -(A6),<EA:3F>
        BCHG    D1,-(A3)                        ; $2AEE8A
        BSET    D1,(A1)                         ; $2AEE8C
        BTST    D0,D1                           ; $2AEE8E
        SUBI.B  #$0507,$014E(PC)                ; $2AEE90
        SUBI.W  #$0511,$FFFC.W                  ; $2AEE96
        DC.W    $02BE,$043D,$00E5   ; $2AEE9C ANDI.L  #$043D00E5,<EA:3E>
        BCHG    D1,$058B(A6)                    ; $2AEEA2
        BTST    D0,$02F2(A6)                    ; $2AEEA6
        SUBI.W  #$FFCB,D6                       ; $2AEEAA
        BCLR    D1,$0595(A5)                    ; $2AEEAE
        DC.W    $FFDB               ; $2AEEB2 MOVE.W  (A3)+,<EA:3F>
        DC.W    $03CC               ; $2AEEB4 BSET    D1,A4
        BCLR    D2,(A4)                         ; $2AEEB6
        DC.W    $0031,$0445,$0520   ; $2AEEB8 ORI.B  #$0445,$20(A1,D0.W)
        ORI.L  #$04CD05FA,(A5)+                 ; $2AEEBE
        DC.W    $00BD,$0439,$0641   ; $2AEEC4 ORI.L  #$04390641,<EA:3D>
        ORI.W  #$03AD,A2                        ; $2AEECA
        DC.W    $058F               ; $2AEECE BCLR    D2,A7
        DC.W    $00DF               ; $2AEED0 DC.W    $00DF
        SUBI.B  #$063C,(A1)+                    ; $2AEED2
        DC.W    $00F8               ; $2AEED6 DC.W    $00F8
        BCLR    D1,$5E(A5,D0.W)                 ; $2AEED8
        DC.W    $FFCF               ; $2AEEDC MOVE.W  A7,<EA:3F>
        DC.W    $03C8               ; $2AEEDE BSET    D1,A0
        BTST    D2,-(A1)                        ; $2AEEE0
        MOVE.W  $04F8(A6),$0470(A7)             ; $2AEEE2
        MOVE.W  -(A3),$02(A7,D0.W)              ; $2AEEE8
        SUBI.L  #$00080380,(A5)+                ; $2AEEEC
        DC.W    $04FD               ; $2AEEF2 DC.W    $04FD
        DC.W    $FFC1               ; $2AEEF4 MOVE.W  D1,<EA:3F>
        DC.W    $04CC               ; $2AEEF6 DC.W    $04CC
        DC.W    $043D,$FFFB         ; $2AEEF8 SUBI.B  #$FFFB,<EA:3D>
        DC.W    $04C1               ; $2AEEFC DC.W    $04C1
        SUBI.W  #$FFE9,D0                       ; $2AEEFE
        DC.W    $04F7               ; $2AEF02 DC.W    $04F7
        DC.W    $043D,$FFAA         ; $2AEF04 SUBI.B  #$FFAA,<EA:3D>
        BTST    D2,-(A3)                        ; $2AEF08
        BCLR    D2,(A0)                         ; $2AEF0A
        DC.W    $FFBE,$04F6         ; $2AEF0C MOVE.W  <EA:3E>,-$0A(A7,D0.W)
        BSET    D2,(A6)+                        ; $2AEF10
        DC.W    $0001,$0513         ; $2AEF12 ORI.B  #$0513,D1
        SUBI.B  #$FFF8,$47(A5,D0.W)             ; $2AEF16
        BSET    D2,(A1)                         ; $2AEF1C
        DC.W    $0010,$0572         ; $2AEF1E ORI.B  #$0572,(A0)
        BTST    D2,D3                           ; $2AEF22
        DC.W    $0028,$0451,$06E2   ; $2AEF24 ORI.B  #$0451,$06E2(A0)
        DC.W    $0001,$0587         ; $2AEF2A ORI.B  #$0587,D1
        DC.W    $0639,$0037,$063A,$052B; $2AEF2E ADDI.B  #$0037,$063A052B
        ORI.W  #$037D,(A0)                      ; $2AEF36
        BCLR    D1,$6A(A6,D0.W)                 ; $2AEF3A
        BTST    D1,-$2E(A4,D0.W)                ; $2AEF3E
        BCLR    D0,$03940527                    ; $2AEF42
        BCLR    D0,(A6)                         ; $2AEF48
        BSET    D1,-(A6)                        ; $2AEF4A
        BTST    D2,$0145(A1)                    ; $2AEF4C
        BTST    D1,(A6)                         ; $2AEF50
        BSET    D1,(A0)                         ; $2AEF52
        DC.W    $014D               ; $2AEF54 BCHG    D0,A5
        DC.W    $037E               ; $2AEF56 BCHG    D1,<EA:3E>
        BCHG    D2,D4                           ; $2AEF58
        BTST    D0,$0468(A0)                    ; $2AEF5A
        DC.W    $02E2               ; $2AEF5E DC.W    $02E2
        BSET    D0,(A6)                         ; $2AEF60
        SUBI.B  #$0300,A0                       ; $2AEF62
loc_2AEF66:
        DC.W    $0205,$0317         ; $2AEF66 ANDI.B  #$0317,D5
        BSET    D1,-(A1)                        ; $2AEF6A
        BCLR    D0,-(A6)                        ; $2AEF6C
        BCHG    D1,D3                           ; $2AEF6E
        BSET    D1,$63(A4,D0.W)                 ; $2AEF70
        SUBI.B  #$02A4,-$2E(A0,D0.W)            ; $2AEF74
        DC.W    $030B               ; $2AEF7A BTST    D1,A3
        BCLR    D1,$60(A7,D0.W)                 ; $2AEF7C
        DC.W    $0349               ; $2AEF80 BCHG    D1,A1
        ANDI.L  #$FF9A0300,D6                   ; $2AEF82
        ANDI.W  #$00F2,$0358(A2)                ; $2AEF88
        BSET    D1,$0103(A3)                    ; $2AEF8E
        BCLR    D1,(A3)                         ; $2AEF92
        SUBI.B  #$FFE9,D2                       ; $2AEF94
        ANDI.W  #$0294,A6                       ; $2AEF98
        DC.W    $00CF               ; $2AEF9C DC.W    $00CF
        ANDI.L  #$041500E1,-(A6)                ; $2AEF9E
        ANDI.L  #$02B0FF78,(A0)+                ; $2AEFA4
        DC.W    $02E2               ; $2AEFAA DC.W    $02E2
        SUBI.B  #$FFC7,$0496(A4)                ; $2AEFAC
        ANDI.W  #$FFF3,D5                       ; $2AEFB2
        SUBI.W  #$01F8,(A6)+                    ; $2AEFB6
        MOVE.W  -(A7),$0295(A7)                 ; $2AEFBA
        ANDI.L  #$FFCD02CC,D5                   ; $2AEFBE
        DC.W    $02D1               ; $2AEFC4 DC.W    $02D1
        ORI.W  #$0494,(A2)+                     ; $2AEFC6
        ANDI.L  #$FF7C02CB,(A7)                 ; $2AEFCA
        BTST    D1,-(A4)                        ; $2AEFD0
        DC.W    $FFE4               ; $2AEFD2 MOVE.W  -(A4),<EA:3F>
        SUBI.B  #$0108,-(A3)                    ; $2AEFD4
        MOVE.W  (A6),-(A7)                      ; $2AEFD8
        BSET    D1,D3                           ; $2AEFDA
        BCHG    D0,D2                           ; $2AEFDC
        MOVE.W  $50(PC,D0.W),(A7)+              ; $2AEFDE
        ANDI.L  #$FFC404B1,A3                   ; $2AEFE2
loc_2AEFE8:
        ANDI.W  #$FFE0,(A0)                     ; $2AEFE8
        SUBI.B  #$013D,-(A4)                    ; $2AEFEC
        DC.W    $FEBE               ; $2AEFF0 MOVE.W  <EA:3E>,(A7)
        DC.W    $04B2,$0286,$FF87,$04C4; $2AEFF2 SUBI.L  #$0286FF87,-$3C(A2,D0.W)
        DC.W    $00DA               ; $2AEFFA DC.W    $00DA
        MOVE.W  -(A4),(A7)                      ; $2AEFFC
loc_2AEFFE:
        DC.W    $04B4,$00A0,$FEA4,$03AF; $2AEFFE SUBI.L  #$00A0FEA4,-$51(A4,D0.W)
        DC.W    $00EC               ; $2AF006 DC.W    $00EC
        DC.W    $FEFE               ; $2AF008 MOVE.W  <EA:3E>,(A7)+
        DC.W    $03C8               ; $2AF00A BSET    D1,A0
        BCHG    D0,D6                           ; $2AF00C
        DC.W    $FEFE               ; $2AF00E MOVE.W  <EA:3E>,(A7)+
        BTST    D1,(A3)                         ; $2AF010
        DC.W    $02E8               ; $2AF012 DC.W    $02E8
        DC.W    $0034,$0275,$02F3   ; $2AF014 ORI.B  #$0275,-$0D(A4,D0.W)
        ORI.W  #$028A,$1D(A2,D0.W)              ; $2AF01A
        DC.W    $00F8               ; $2AF020 DC.W    $00F8
        BTST    D1,-(A7)                        ; $2AF022
        BTST    D0,(A2)                         ; $2AF024
        DC.W    $00BA,$030A,$0310,$00BF; $2AF026 ORI.L  #$030A0310,$00BF(PC)
        BTST    D1,(A6)+                        ; $2AF02E
        BTST    D0,$0145(PC)                    ; $2AF030
        BTST    D1,$28(A2,D0.W)                 ; $2AF034
        DC.W    $00CA               ; $2AF038 DC.W    $00CA
        DC.W    $02EE               ; $2AF03A DC.W    $02EE
        BCLR    D0,D4                           ; $2AF03C
        DC.W    $00E2               ; $2AF03E DC.W    $00E2
        BCLR    D0,$008A(A5)                    ; $2AF040
        BTST    D0,(A4)                         ; $2AF044
        BSET    D0,$2F(A0,D0.W)                 ; $2AF046
        DC.W    $00FC               ; $2AF04A DC.W    $00FC
        BTST    D1,$0144(A4)                    ; $2AF04C
        BTST    D0,$01EA(A6)                    ; $2AF050
        ORI.W  #$0160,A2                        ; $2AF054
        ANDI.L  #$FFFF016C,(A3)                 ; $2AF058
        ANDI.L  #$FFC70163,D3                   ; $2AF05E
        BCLR    D0,D2                           ; $2AF064
        DC.W    $001F,$010A         ; $2AF066 ORI.B  #$010A,(A7)+
loc_2AF06A:
        BCLR    D0,(A3)+                        ; $2AF06A
        ORI.W  #$0118,$10(A7,D0.W)              ; $2AF06C
        BGT.W  loc_2AF074                       ; $2AF072
        DC.W    $0010,$0020         ; $2AF076 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2AF07A ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AF080
        SUBI.B  #$7000,(A0)                     ; $2AF084
        ORI.W  #$0070,-(A0)                     ; $2AF088
        SUBI.B  #$6F00,(A0)                     ; $2AF08C
        DC.W    $0000,$0030         ; $2AF090 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AF094 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AF098 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AF09C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AF0A0
        DC.W    $00B0,$0210,$0400,$00D0; $2AF0A6 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AF0AE DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AF0B0
        ORI.L  #$00900611,-(A0)                 ; $2AF0B4
        BTST    D3,D1                           ; $2AF0BA
        DC.W    $00B0,$0010,$6A00,$00E0; $2AF0BC ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AF0C4 DC.W    $00F0
        BTST    D0,D0                           ; $2AF0C6
        BTST    D0,(A0)                         ; $2AF0C8
        DC.W    $0210,$6C00         ; $2AF0CA ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AF0CE
        SUBI.B  #$6B00,(A0)                     ; $2AF0D2
        BTST    D0,D0                           ; $2AF0D6
        DC.W    $00F0               ; $2AF0D8 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AF0DA ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AF0DE DC.W    $00E0
        DC.W    $0010,$6300         ; $2AF0E0 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AF0E4
        BCHG    D0,(A0)                         ; $2AF0E6
        BCHG    D0,-(A0)                        ; $2AF0E8
        BCHG    D0,$10(A0,D0.W)                 ; $2AF0EA
        BCS.W  loc_2AF280                       ; $2AF0EE
        BCLR    D0,D0                           ; $2AF0F2
        SUBI.B  #$6400,(A0)                     ; $2AF0F4
        BCHG    D0,-(A0)                        ; $2AF0F8
        BCHG    D0,(A0)                         ; $2AF0FA
        ADDI.B  #$6201,(A1)                     ; $2AF0FC
        BCHG    D0,$10(A0,D0.W)                 ; $2AF100
        BPL.W  loc_2AF2E6                       ; $2AF104
        BSET    D0,$00(A0,D0.W)                 ; $2AF108
        DC.W    $0210,$0210         ; $2AF10C ANDI.B  #$0210,(A0)
        BGE.W  loc_2AF342                       ; $2AF110
        DC.W    $0220,$0410         ; $2AF114 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2AF31A                       ; $2AF118
        BSET    D0,$11(A0,D0.W)                 ; $2AF11C
        BVS.S  loc_2AF123                       ; $2AF120
        DC.W    $0210,$0010         ; $2AF122 ANDI.B  #$0010,(A0)
        BLS.W  loc_2AF368                       ; $2AF126
        ANDI.W  #$0260,(A0)                     ; $2AF12A
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2AF12E
        ANDI.L  #$02800410,(A0)                 ; $2AF134
        BCC.W  loc_2AF39C                       ; $2AF13A
        ANDI.W  #$0211,(A0)                     ; $2AF13E
        BHI.S  loc_2AF145                       ; $2AF142
        ANDI.W  #$0010,D0                       ; $2AF144
        BNE.W  loc_2AF3EA                       ; $2AF148
        DC.W    $02B0,$02C0,$02D0,$0610; $2AF14C ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2AF436                       ; $2AF154
        DC.W    $02F0               ; $2AF158 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2AF15A
        BTST    D1,D0                           ; $2AF15E
        BTST    D1,(A0)                         ; $2AF160
        SUBI.B  #$6700,(A0)                     ; $2AF162
        ANDI.L  #$02D00010,-(A0)                ; $2AF166
        BTST    D1,D0                           ; $2AF16C
        BTST    D1,-(A0)                        ; $2AF16E
        BTST    D1,$40(A0,D0.W)                 ; $2AF170
        BCHG    D1,(A0)                         ; $2AF174
        DC.W    $0210,$0500         ; $2AF176 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2AF17A
        SUBI.B  #$0400,(A0)                     ; $2AF17E
        BCHG    D1,D0                           ; $2AF182
        BTST    D1,$10(A0,D0.W)                 ; $2AF184
        BCS.W  loc_2AF50A                       ; $2AF188
        BCLR    D1,(A0)                         ; $2AF18C
        BCLR    D1,-(A0)                        ; $2AF18E
        BCLR    D1,$10(A0,D0.W)                 ; $2AF190
        BLS.W  loc_2AF566                       ; $2AF194
        BSET    D1,D0                           ; $2AF198
        SUBI.B  #$6400,(A0)                     ; $2AF19A
        BCLR    D1,-(A0)                        ; $2AF19E
        BCLR    D1,(A0)                         ; $2AF1A0
        DC.W    $0010,$0300         ; $2AF1A2 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2AF1A6
        SUBI.W  #$0450,D0                       ; $2AF1AA
        DC.W    $0210,$0500         ; $2AF1AE ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2AF1B2
        SUBI.B  #$0440,D0                       ; $2AF1B8
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2AF1BC
        SUBI.L  #$049004A0,D0                   ; $2AF1C2
        DC.W    $04B0,$0210,$6300,$04D0; $2AF1C8 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2AF1D0 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2AF1D2
        SUBI.L  #$04900000,-(A0)                ; $2AF1D6
        BVS.W  loc_2AF37E                       ; $2AF1DC
        BCLR    D0,-$40(A0,D0.W)                ; $2AF1E0
        BSET    D0,(A0)                         ; $2AF1E4
loc_2AF1E6:
        DC.W    $0000,$6600         ; $2AF1E6 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2AF1EA
        BSET    D1,$00(A0,D0.W)                 ; $2AF1EC
        SUBI.B  #$0000,(A0)                     ; $2AF1F0
        BNE.W  loc_2AF6D6                       ; $2AF1F4
        DC.W    $04F0               ; $2AF1F8 DC.W    $04F0
        BTST    D2,D0                           ; $2AF1FA
        BTST    D2,(A0)                         ; $2AF1FC
        CMPI.B  #$0052,D0                       ; $2AF1FE
        ORI.W  #$0293,(A2)                      ; $2AF202
        SUBI.B  #$FFFF,(A2)+                    ; $2AF206
        DC.W    $02C1               ; $2AF20A DC.W    $02C1
        BSET    D1,$0117(A3)                    ; $2AF20C
        BCHG    D1,$053E(A5)                    ; $2AF210
        BCHG    D0,(A0)                         ; $2AF214
        BTST    D1,$75(A6,D0.W)                 ; $2AF216
        DC.W    $0000,$020D         ; $2AF21A ORI.B  #$020D,D0
        SUBI.B  #$0141,-$71(A3,D0.W)            ; $2AF21E
        BCLR    D2,(A6)                         ; $2AF224
        BCLR    D0,D4                           ; $2AF226
        BSET    D0,(A6)+                        ; $2AF228
        SUBI.W  #$0028,-(A2)                    ; $2AF22A
        ANDI.W  #$05CE,(A7)                     ; $2AF22E
        DC.W    $0034,$0291,$05CB   ; $2AF232 ORI.B  #$0291,-$35(A4,D0.W)
        ORI.W  #$0339,$056B(PC)                 ; $2AF238
        DC.W    $00A9,$039C,$0659,$00C1; $2AF23E ORI.L  #$039C0659,$00C1(A1)
        DC.W    $02E0               ; $2AF246 DC.W    $02E0
        ADDI.L  #$008D02AE,A1                   ; $2AF248
        BCLR    D2,$0127(A7)                    ; $2AF24E
        DC.W    $02FC               ; $2AF252 DC.W    $02FC
        ADDI.W  #$013A,$0289(A4)                ; $2AF254
        BCLR    D2,$15(A0,D0.W)                 ; $2AF25A
        ANDI.W  #$0582,-$52(A6,A7.L)            ; $2AF25E
        BCHG    D1,D7                           ; $2AF264
        SUBI.W  #$FF97,-(A3)                    ; $2AF266
        BCHG    D1,$0476(A6)                    ; $2AF26A
        DC.W    $FFFD               ; $2AF26E MOVE.W  <EA:3D>,<EA:3F>
        DC.W    $0230,$056F,$0007   ; $2AF270 ANDI.B  #$056F,$07(A0,D0.W)
        BTST    D1,(A4)                         ; $2AF276
        SUBI.B  #$FFEF,$0A(A6,D0.W)             ; $2AF278
        SUBI.W  #$FFE2,A4                       ; $2AF27E
        BTST    D1,$0439(A5)                    ; $2AF282
        MOVE.W  (A1)+,$16(A7,D0.W)              ; $2AF286
        BTST    D2,-$37(A0,A7.L)                ; $2AF28A
        SUBI.B  #$0579,-(A4)                    ; $2AF28E
        DC.W    $001A,$0346         ; $2AF292 ORI.B  #$0346,(A2)+
        SUBI.B  #$FFDF,(A4)                     ; $2AF296
        SUBI.W  #$0540,-(A2)                    ; $2AF29A
        DC.W    $0017,$0410         ; $2AF29E ORI.B  #$0410,(A7)
        DC.W    $047C,$0010,$0436   ; $2AF2A2 SUBI.W  #$0010,#$0436
        ADDI.L  #$005A04D6,-(A6)                ; $2AF2A8
        BCHG    D2,$003C(A1)                    ; $2AF2AE
        DC.W    $04CC               ; $2AF2B2 DC.W    $04CC
        SUBI.B  #$0012,-(A6)                    ; $2AF2B4
        DC.W    $02E7               ; $2AF2B8 DC.W    $02E7
        BSET    D1,D4                           ; $2AF2BA
        BSET    D0,(A7)                         ; $2AF2BC
        DC.W    $02AF,$03EC,$022E,$02E8; $2AF2BE ANDI.L  #$03EC022E,$02E8(A7)
        BTST    D2,$01BD0325                    ; $2AF2C6
        BTST    D2,$5C(A0,D0.W)                 ; $2AF2CC
        DC.W    $0279,$03D4,$01CE,$02B8; $2AF2D0 ANDI.W  #$03D4,$01CE02B8
        BCHG    D2,D0                           ; $2AF2D8
        BCHG    D0,(A3)                         ; $2AF2DA
        SUBI.B  #$032C,D2                       ; $2AF2DC
        DC.W    $0222,$03AC         ; $2AF2E0 ANDI.B  #$03AC,-(A2)
        BCHG    D1,D6                           ; $2AF2E4
loc_2AF2E6:
        ANDI.W  #$028B,-(A2)                    ; $2AF2E6
        BSET    D1,$21(A3,D0.W)                 ; $2AF2EA
        ANDI.L  #$03FD01D2,-(A2)                ; $2AF2EE
        BSET    D1,(A4)                         ; $2AF2F4
        DC.W    $02E8               ; $2AF2F6 DC.W    $02E8
        DC.W    $0238,$0275,$03BB   ; $2AF2F8 ANDI.B  #$0275,$03BB.W
        BSET    D0,$023A(A1)                    ; $2AF2FE
        DC.W    $02B0,$FFB3,$0274,$0278; $2AF302 ANDI.L  #$FFB30274,$78(A0,D0.W)
        DC.W    $010B               ; $2AF30A BTST    D0,A3
        DC.W    $02B9,$03FD,$011C,$0289,$042B; $2AF30C ANDI.L  #$03FD011C,$0289042B
        DC.W    $0002,$01C1         ; $2AF316 ORI.B  #$01C1,D2
loc_2AF31A:
        ANDI.L  #$012E0206,(A7)                 ; $2AF31A
        SUBI.B  #$013F,(A3)+                    ; $2AF320
        BCLR    D0,D7                           ; $2AF324
        DC.W    $02CD               ; $2AF326 DC.W    $02CD
        DC.W    $FFD5               ; $2AF328 MOVE.W  (A5),<EA:3F>
        BSET    D0,(A6)                         ; $2AF32A
        SUBI.W  #$0024,A0                       ; $2AF32C
        BCLR    D1,(A3)                         ; $2AF330
        ANDI.W  #$FFB9,A4                       ; $2AF332
        BTST    D1,$14(A6,D0.W)                 ; $2AF336
        MOVE.W  -$62(A6,D0.W),-(A7)             ; $2AF33A
        DC.W    $02AE,$0013,$01FB,$02E7; $2AF33E ANDI.L  #$001301FB,$02E7(A6)
        ORI.L  #$037C02AD,(A6)                  ; $2AF346
        MOVE.W  A6,$01E5(A7)                    ; $2AF34C
        BCHG    D1,D6                           ; $2AF350
        DC.W    $002C,$0229,$01BC   ; $2AF352 ORI.B  #$0229,$01BC(A4)
        DC.W    $FF79,$020A,$0228,$FF90; $2AF358 MOVE.W  $020A0228,-$0070(A7)
        BCLR    D1,(A4)                         ; $2AF360
        ANDI.L  #$FF9103B4,(A3)+                ; $2AF362
loc_2AF368:
        DC.W    $022F,$FF7A,$0218   ; $2AF368 ANDI.B  #$FF7A,$0218(A7)
        BSET    D0,$FF27.W                      ; $2AF36E
        BCLR    D1,-(A2)                        ; $2AF372
        ANDI.W  #$FF29,$027B(A3)                ; $2AF374
        BTST    D0,$23(PC,A7.L)                 ; $2AF37A
loc_2AF37E:
        ANDI.W  #$0119,A2                       ; $2AF37E
        MOVE.W  -(A3),-(A7)                     ; $2AF382
        BCLR    D0,$01F8(A7)                    ; $2AF384
        MOVE.W  #$01FA,$022E(A7)                ; $2AF388
        MOVE.W  #$022E,$0312(A7)                ; $2AF38E
        ORI.W  #$01B4,-(A7)                     ; $2AF394
        DC.W    $02E3               ; $2AF398 DC.W    $02E3
        DC.W    $00D3               ; $2AF39A DC.W    $00D3
loc_2AF39C:
        ANDI.W  #$011F,$00E5(A7)                ; $2AF39C
        DC.W    $02EA               ; $2AF3A2 DC.W    $02EA
        DC.W    $014E               ; $2AF3A4 BCHG    D0,A6
        ORI.W  #$024D,$0324.W                   ; $2AF3A6
        DC.W    $00F4               ; $2AF3AC DC.W    $00F4
        DC.W    $0309               ; $2AF3AE BTST    D1,A1
        BCHG    D0,-(A1)                        ; $2AF3B0
        BTST    D0,D5                           ; $2AF3B2
        DC.W    $02FA               ; $2AF3B4 DC.W    $02FA
        BCHG    D0,(A6)                         ; $2AF3B6
        ORI.L  #$02BD01A4,A2                    ; $2AF3B8
        DC.W    $00C2               ; $2AF3BE DC.W    $00C2
        BCLR    D0,-(A6)                        ; $2AF3C0
        ORI.L  #$012601E4,A1                    ; $2AF3C2
        DC.W    $0039,$00ED,$0310,$0162; $2AF3C8 ORI.B  #$00ED,$03100162
        DC.W    $00ED               ; $2AF3D0 DC.W    $00ED
        BSET    D0,$0046(PC)                    ; $2AF3D2
        BCHG    D0,(A1)                         ; $2AF3D6
        ANDI.L  #$003C016C,-(A4)                ; $2AF3D8
        ANDI.L  #$00020163,-(A4)                ; $2AF3DE
        BCLR    D0,(A4)                         ; $2AF3E4
        DC.W    $000C,$010A         ; $2AF3E6 ORI.B  #$010A,A4
loc_2AF3EA:
        BCLR    D0,(A3)                         ; $2AF3EA
        ORI.W  #$0118,$0010(A0)                 ; $2AF3EC
        BGT.W  loc_2AF3F4                       ; $2AF3F2
        DC.W    $0010,$0020         ; $2AF3F6 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2AF3FA ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2AF400
        SUBI.B  #$7000,(A0)                     ; $2AF404
        ORI.W  #$0070,-(A0)                     ; $2AF408
        SUBI.B  #$6F00,(A0)                     ; $2AF40C
        DC.W    $0000,$0030         ; $2AF410 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AF414 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AF418 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AF41C ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AF420
        DC.W    $00B0,$0210,$0400,$00D0; $2AF426 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AF42E DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AF430
        ORI.L  #$00900611,-(A0)                 ; $2AF434
        BTST    D3,D1                           ; $2AF43A
        DC.W    $00B0,$0010,$6A00,$00E0; $2AF43C ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AF444 DC.W    $00F0
        BTST    D0,D0                           ; $2AF446
        BTST    D0,(A0)                         ; $2AF448
        DC.W    $0210,$6C00         ; $2AF44A ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AF44E
        SUBI.B  #$6B00,(A0)                     ; $2AF452
        BTST    D0,D0                           ; $2AF456
        DC.W    $00F0               ; $2AF458 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AF45A ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AF45E DC.W    $00E0
        DC.W    $0010,$6300         ; $2AF460 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AF464
        BCHG    D0,(A0)                         ; $2AF466
        BCHG    D0,-(A0)                        ; $2AF468
        BCHG    D0,$10(A0,D0.W)                 ; $2AF46A
        BCS.W  loc_2AF600                       ; $2AF46E
        BCLR    D0,D0                           ; $2AF472
        SUBI.B  #$6400,(A0)                     ; $2AF474
        BCHG    D0,-(A0)                        ; $2AF478
        BCHG    D0,(A0)                         ; $2AF47A
        ADDI.B  #$6201,(A1)                     ; $2AF47C
        BCHG    D0,$10(A0,D0.W)                 ; $2AF480
        BPL.W  loc_2AF666                       ; $2AF484
        BSET    D0,$00(A0,D0.W)                 ; $2AF488
        DC.W    $0210,$0210         ; $2AF48C ANDI.B  #$0210,(A0)
        BGE.W  loc_2AF6C2                       ; $2AF490
        DC.W    $0220,$0410         ; $2AF494 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2AF69A                       ; $2AF498
        BSET    D0,$11(A0,D0.W)                 ; $2AF49C
        BVS.S  loc_2AF4A3                       ; $2AF4A0
        DC.W    $0210,$0010         ; $2AF4A2 ANDI.B  #$0010,(A0)
        BLS.W  loc_2AF6E8                       ; $2AF4A6
        ANDI.W  #$0260,(A0)                     ; $2AF4AA
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2AF4AE
        ANDI.L  #$02800410,(A0)                 ; $2AF4B4
        BCC.W  loc_2AF71C                       ; $2AF4BA
        ANDI.W  #$0211,(A0)                     ; $2AF4BE
        BHI.S  loc_2AF4C5                       ; $2AF4C2
        ANDI.W  #$0010,D0                       ; $2AF4C4
        BNE.W  loc_2AF76A                       ; $2AF4C8
        DC.W    $02B0,$02C0,$02D0,$0610; $2AF4CC ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2AF7B6                       ; $2AF4D4
        DC.W    $02F0               ; $2AF4D8 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2AF4DA
        BTST    D1,D0                           ; $2AF4DE
        BTST    D1,(A0)                         ; $2AF4E0
        SUBI.B  #$6700,(A0)                     ; $2AF4E2
        ANDI.L  #$02D00010,-(A0)                ; $2AF4E6
        BTST    D1,D0                           ; $2AF4EC
        BTST    D1,-(A0)                        ; $2AF4EE
        BTST    D1,$40(A0,D0.W)                 ; $2AF4F0
        BCHG    D1,(A0)                         ; $2AF4F4
        DC.W    $0210,$0500         ; $2AF4F6 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2AF4FA
        SUBI.B  #$0400,(A0)                     ; $2AF4FE
        BCHG    D1,D0                           ; $2AF502
        BTST    D1,$10(A0,D0.W)                 ; $2AF504
        BCS.W  loc_2AF88A                       ; $2AF508
        BCLR    D1,(A0)                         ; $2AF50C
        BCLR    D1,-(A0)                        ; $2AF50E
        BCLR    D1,$10(A0,D0.W)                 ; $2AF510
        BLS.W  loc_2AF8E6                       ; $2AF514
        BSET    D1,D0                           ; $2AF518
        SUBI.B  #$6400,(A0)                     ; $2AF51A
        BCLR    D1,-(A0)                        ; $2AF51E
        BCLR    D1,(A0)                         ; $2AF520
        DC.W    $0010,$0300         ; $2AF522 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2AF526
        SUBI.W  #$0450,D0                       ; $2AF52A
        DC.W    $0210,$0500         ; $2AF52E ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2AF532
        SUBI.B  #$0440,D0                       ; $2AF538
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2AF53C
        SUBI.L  #$049004A0,D0                   ; $2AF542
        DC.W    $04B0,$0210,$6300,$04D0; $2AF548 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2AF550 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2AF552
        SUBI.L  #$04900000,-(A0)                ; $2AF556
        BVS.W  loc_2AF6FE                       ; $2AF55C
        BCLR    D0,-$40(A0,D0.W)                ; $2AF560
        BSET    D0,(A0)                         ; $2AF564
loc_2AF566:
        DC.W    $0000,$6600         ; $2AF566 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2AF56A
        BSET    D1,$00(A0,D0.W)                 ; $2AF56C
        SUBI.B  #$0000,(A0)                     ; $2AF570
        BNE.W  loc_2AFA56                       ; $2AF574
        DC.W    $04F0               ; $2AF578 DC.W    $04F0
        BTST    D2,D0                           ; $2AF57A
        BTST    D2,(A0)                         ; $2AF57C
        CMPI.B  #$0004,D0                       ; $2AF57E
        DC.W    $0004,$F890         ; $2AF582 ORI.B  #$F890,D4
        ORI.W  #$01F3,-$08DA(A0)                ; $2AF586
        BTST    D0,(A5)                         ; $2AF58C
        BCHG    D1,-$3A(PC,A7.W)                ; $2AF58E
        DC.W    $000A,$02CD         ; $2AF592 ORI.B  #$02CD,A2
        MOVE.W  (A5),(A4)                       ; $2AF596
        MOVE.W  (A2)+,-$14(A7,D0.W)             ; $2AF598
        DC.W    $0000,$6900         ; $2AF59C ORI.B  #$6900,D0
        DC.W    $0000,$0010         ; $2AF5A0 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AF5A4 ORI.B  #$0030,-(A0)
        CMPI.B  #$0010,D0                       ; $2AF5A8
        DC.W    $0010,$F88D         ; $2AF5AC ORI.B  #$F88D,(A0)
        DC.W    $0013,$FCCF         ; $2AF5B0 ORI.B  #$FCCF,(A3)
        MOVE.W  D6,-(A4)                        ; $2AF5B4
        DC.W    $0017,$FBF0         ; $2AF5B6 ORI.B  #$FBF0,(A7)
        MOVE.W  A6,-(A4)                        ; $2AF5BA
        DC.W    $018C               ; $2AF5BC BCLR    D0,A4
        DC.W    $FBFA,$F895         ; $2AF5BE MOVE.W  -$076B(PC),<EA:3D>
        DC.W    $0188               ; $2AF5C2 BCLR    D0,A0
        MOVE.W  (A2)+,(A6)+                     ; $2AF5C4
        MOVE.W  (A2)+,(A5)+                     ; $2AF5C6
        DC.W    $000C,$FC20         ; $2AF5C8 ORI.B  #$FC20,A4
        MOVE.W  -(A1),-(A5)                     ; $2AF5CC
        DC.W    $0004,$FD14         ; $2AF5CE ORI.B  #$FD14,D4
        MOVE.W  $0178(A1),-(A5)                 ; $2AF5D2
        MOVE.W  (A6)+,-(A6)                     ; $2AF5D6
        MOVE.W  -(A1),(A5)+                     ; $2AF5D8
        BCLR    D0,D1                           ; $2AF5DA
        MOVE.W  -$0607(A2),D6                   ; $2AF5DC
        DC.W    $0014,$FBA7         ; $2AF5E0 ORI.B  #$FBA7,(A4)
        MOVE.W  D2,D5                           ; $2AF5E4
        DC.W    $0189               ; $2AF5E6 BCLR    D0,A1
        MOVE.W  -$2B(A2,A7.L),$0B(A5,D0.W)      ; $2AF5E8
        DC.W    $FDC3               ; $2AF5EE MOVE.W  D3,<EA:3E>
        MOVE.W  (A5)+,(A4)+                     ; $2AF5F0
        BCLR    D0,D0                           ; $2AF5F2
        DC.W    $FDCD               ; $2AF5F4 MOVE.W  A5,<EA:3E>
        MOVE.W  $0000(A0),(A5)                  ; $2AF5F6
        DC.W    $FDF3,$FAB0         ; $2AF5FA MOVE.W  -$50(A3,A7.L),<EA:3E>
        BCHG    D0,-$02(A4,A7.L)                ; $2AF5FE
        MOVE.W  $03(A5,D0.W),$3C(A4,A7.L)       ; $2AF602
        MOVE.W  #$0177,$46(A4,A7.L)             ; $2AF608
        DC.W    $0010,$0600         ; $2AF60E ORI.B  #$0600,(A0)
        DC.W    $0000,$0010         ; $2AF612 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AF616 ORI.B  #$0030,-(A0)
        DC.W    $0210,$0500         ; $2AF61A ANDI.B  #$0500,(A0)
        DC.W    $00B0,$00A0,$0410,$0600; $2AF61E ORI.L  #$00A00410,$00(A0,D0.W)
        DC.W    $00F0               ; $2AF626 DC.W    $00F0
        DC.W    $00E0               ; $2AF628 DC.W    $00E0
        SUBI.B  #$0700,(A0)                     ; $2AF62A
        DC.W    $00D0               ; $2AF62E DC.W    $00D0
        DC.W    $00C0               ; $2AF630 DC.W    $00C0
        SUBI.B  #$0600,(A0)                     ; $2AF632
        ORI.W  #$0050,-(A0)                     ; $2AF636
        SUBI.B  #$0500,(A0)                     ; $2AF63A
        ORI.W  #$0040,$10(A0,D0.W)              ; $2AF63E
        ADDI.B  #$0090,D0                       ; $2AF644
        ORI.L  #$04100700,D0                    ; $2AF648
        DC.W    $0020,$0010         ; $2AF64E ORI.B  #$0010,-(A0)
        ADDI.B  #$0800,(A0)                     ; $2AF652
        DC.W    $00B0,$0030,$0610,$0800; $2AF656 ORI.L  #$00300610,$00(A0,D0.L)
        ORI.W  #$00F0,$10(A0,D0.W)              ; $2AF65E
        BTST    #0,D0                           ; $2AF664
        DC.W    $00D0               ; $2AF668 DC.W    $00D0
        CMPI.B  #$0010,D0                       ; $2AF66A
        DC.W    $0010,$F666         ; $2AF66E ORI.B  #$F666,(A0)
        DC.W    $0013,$FE40         ; $2AF672 ORI.B  #$FE40,(A3)
        MOVE.W  (A2)+,D3                        ; $2AF676
        DC.W    $0017,$FD4D         ; $2AF678 ORI.B  #$FD4D,(A7)
        MOVE.W  -(A7),D3                        ; $2AF67C
        DC.W    $018C               ; $2AF67E BCLR    D0,A4
        MOVE.W  A7,-$098D(A6)                   ; $2AF680
        DC.W    $0188               ; $2AF684 BCLR    D0,A0
        MOVEA.W D2,A7                           ; $2AF686
        MOVE.W  D4,$0C(A3,D0.W)                 ; $2AF688
        MOVE.W  -(A0),D6                        ; $2AF68C
        MOVEA.W -(A4),A4                        ; $2AF68E
        DC.W    $0004,$FC97         ; $2AF690 ORI.B  #$FC97,D4
        MOVEA.W $78(A1,D0.W),A4                 ; $2AF694
        MOVE.W  (A1)+,(A6)                      ; $2AF698
loc_2AF69A:
        MOVE.W  (A0),-$7F(A3,D0.W)              ; $2AF69A
        MOVE.W  -(A2),D6                        ; $2AF69E
        MOVE.W  (A1),(A3)                       ; $2AF6A0
        DC.W    $0014,$FC6C         ; $2AF6A2 ORI.B  #$FC6C,(A4)
        MOVE.W  (A5)+,(A3)                      ; $2AF6A6
        DC.W    $0189               ; $2AF6A8 BCLR    D0,A1
        MOVEA.W -$08B9(A6),A6                   ; $2AF6AA
        DC.W    $000B,$FEB6         ; $2AF6AE ORI.B  #$FEB6,A3
        MOVE.W  (A3),$0180(A3)                  ; $2AF6B2
        MOVE.W  $F8B0.W,(A7)                    ; $2AF6B6
        DC.W    $0000,$FD8A         ; $2AF6BA ORI.B  #$FD8A,D0
        DC.W    $F8BD               ; $2AF6BE MOVE.W  <EA:3D>,(A4)
        BCHG    D0,-$74(A4,A7.L)                ; $2AF6C0
        MOVE.W  $0003FE6B,D4                    ; $2AF6C4
        MOVEA.W D6,A4                           ; $2AF6CA
        BCHG    D0,$6D(A7,A7.L)                 ; $2AF6CC
        DC.W    $0010,$0500         ; $2AF6D0 ORI.B  #$0500,(A0)
        DC.W    $0000,$0010         ; $2AF6D4 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AF6D8 ORI.B  #$0030,-(A0)
        DC.W    $0210,$0600         ; $2AF6DC ANDI.B  #$0600,(A0)
        DC.W    $00B0,$00A0,$0410,$0700; $2AF6E0 ORI.L  #$00A00410,$00(A0,D0.W)
loc_2AF6E8:
        DC.W    $00F0               ; $2AF6E8 DC.W    $00F0
        DC.W    $00E0               ; $2AF6EA DC.W    $00E0
        SUBI.B  #$0600,(A0)                     ; $2AF6EC
        DC.W    $00D0               ; $2AF6F0 DC.W    $00D0
        DC.W    $00C0               ; $2AF6F2 DC.W    $00C0
        SUBI.B  #$0500,(A0)                     ; $2AF6F4
        ORI.W  #$0050,-(A0)                     ; $2AF6F8
        SUBI.B  #$0600,(A0)                     ; $2AF6FC
        ORI.W  #$0040,$10(A0,D0.W)              ; $2AF700
        BTST    D3,D0                           ; $2AF706
        ORI.L  #$00800410,(A0)                  ; $2AF708
        ADDI.B  #$0020,D0                       ; $2AF70E
        DC.W    $0010,$0610         ; $2AF712 ORI.B  #$0610,(A0)
        BTST    #16,D0                          ; $2AF716
        DC.W    $0030,$0610,$0800   ; $2AF71A ORI.B  #$0610,$00(A0,D0.L)
        ORI.W  #$00F0,$10(A0,D0.W)              ; $2AF720
        BTST    #0,D0                           ; $2AF726
        DC.W    $00D0               ; $2AF72A DC.W    $00D0
        CMPI.B  #$0052,D0                       ; $2AF72C
        ORI.W  #$FF4F,(A2)                      ; $2AF730
        DC.W    $04AF,$0090,$FF4F,$04AF; $2AF734 SUBI.L  #$0090FF4F,$04AF(A7)
        MOVE.W  $39(A0,A7.L),$062E(A7)          ; $2AF73C
        MOVE.W  (A3),-$00C7(A7)                 ; $2AF742
        ADDI.B  #$00AD,$0015(A6)                ; $2AF746
        DC.W    $04AF,$FF70,$002D,$062E; $2AF74C SUBI.L  #$FF70002D,$062E(A7)
        MOVE.W  (A3),$0015(A7)                  ; $2AF754
        DC.W    $04AF,$0090,$002D,$062E; $2AF758 SUBI.L  #$0090002D,$062E(A7)
        DC.W    $00AD,$0006,$0648,$005D; $2AF760 ORI.L  #$00060648,$005D(A5)
        MOVE.W  (A5),$0634(A7)                  ; $2AF768
        DC.W    $0005,$FF55         ; $2AF76C ORI.B  #$FF55,D5
        BTST    D3,$05(A7,D0.W)                 ; $2AF770
        DC.W    $0006,$0716         ; $2AF774 ORI.B  #$0716,D6
        ORI.W  #$0006,(A5)+                     ; $2AF778
        ADDI.W  #$FFAD,A0                       ; $2AF77C
        DC.W    $0006,$0716         ; $2AF780 ORI.B  #$0716,D6
        MOVE.W  -$007D(A5),$1A(A7,D0.W)         ; $2AF784
        DC.W    $00B8,$FFBA,$05FA,$0118; $2AF78A ORI.L  #$FFBA05FA,$0118.W
        MOVE.W  $0496(PC),$18(A7,D0.W)          ; $2AF792
        MOVE.W  D3,-$6A(A7,D0.W)                ; $2AF798
        DC.W    $00B8,$FFF1,$061A,$00B8; $2AF79C ORI.L  #$FFF1061A,$00B8.W
        DC.W    $FFF1,$0496         ; $2AF7A4 MOVE.W  -$6A(A1,D0.W),<EA:3F>
        DC.W    $00B8,$FF8B,$04AC,$00C7; $2AF7A8 ORI.L  #$FF8B04AC,$00C7.W
        MOVE.W  -$54(A5,D0.W),$0F(A7,D0.W)      ; $2AF7B0
loc_2AF7B6:
        MOVE.W  $54(A5,D0.W),$0F(A7,D0.W)       ; $2AF7B6
        MOVE.W  A3,$0B(A7,D0.W)                 ; $2AF7BC
        DC.W    $00C7               ; $2AF7C0 DC.W    $00C7
        DC.W    $FFDF               ; $2AF7C2 MOVE.W  (A7)+,<EA:3F>
        DC.W    $04AC,$00C7,$FFDF,$030B; $2AF7C4 SUBI.L  #$00C7FFDF,$030B(A4)
        DC.W    $00C7               ; $2AF7CC DC.W    $00C7
        ORI.W  #$03D0,$00BE(A0)                 ; $2AF7CE
        MOVE.W  D7,-(A7)                        ; $2AF7D4
        DC.W    $021D,$00BE         ; $2AF7D6 ANDI.B  #$00BE,(A5)+
        ORI.W  #$029A,(A4)                      ; $2AF7DA
        DC.W    $00BE,$012C,$038E   ; $2AF7DE ORI.L  #$012C038E,<EA:3E>
        DC.W    $00BE,$FF83,$0496   ; $2AF7E4 ORI.L  #$FF830496,<EA:3E>
        MOVE.W  A0,-$0046(A7)                   ; $2AF7EA
        SUBI.L  #$FEE8FFBA,(A6)                 ; $2AF7EE
        BSET    D2,-$0118(PC)                   ; $2AF7F4
        MOVE.W  D3,$1A(A7,D0.W)                 ; $2AF7F8
        MOVE.W  A0,-$000F(A7)                   ; $2AF7FC
        SUBI.L  #$FF48FFF1,(A6)                 ; $2AF800
        ADDI.B  #$FF48,(A2)+                    ; $2AF806
        MOVE.W  A3,$0B(A7,D0.W)                 ; $2AF80A
        MOVE.W  $FFB50354,-(A7)                 ; $2AF80E
        MOVE.W  -$4B(A1,A7.L),(A7)+             ; $2AF814
        DC.W    $04AC,$FEF1,$FF8C,$04AC; $2AF818 SUBI.L  #$FEF1FF8C,$04AC(A4)
        MOVE.W  $FFDF030B,-(A7)                 ; $2AF820
        MOVE.W  $FFDF04AC,-(A7)                 ; $2AF826
        MOVE.W  $FF55031F,-(A7)                 ; $2AF82C
        DC.W    $00B1,$FF55,$031F,$FF4F; $2AF832 ORI.L  #$FF55031F,$4F(A1,A7.L)
        MOVE.W  (A5),$04A9(A7)                  ; $2AF83A
        MOVE.W  -$00AB(A7),$04A9(A7)            ; $2AF83E
        ORI.L  #$000D031F,(A1)                  ; $2AF844
        MOVE.W  A7,$000D(A7)                    ; $2AF84A
        DC.W    $04A9,$FF6F,$000D,$031F; $2AF84E SUBI.L  #$FF6F000D,$031F(A1)
        DC.W    $00B1,$000D,$04A9,$0091; $2AF856 ORI.L  #$000D04A9,-$6F(A1,D0.W)
        MOVE.W  -(A5),$01B4(A7)                 ; $2AF85E
        DC.W    $0005,$FFFE         ; $2AF862 ORI.B  #$FFFE,D5
        BCLR    D0,$4D(A4,D0.W)                 ; $2AF866
        DC.W    $FFFE               ; $2AF86A MOVE.W  <EA:3E>,<EA:3F>
        BCLR    D1,(A4)+                        ; $2AF86C
        ORI.W  #$FF65,A5                        ; $2AF86E
        BCLR    D1,(A4)+                        ; $2AF872
        DC.W    $0005,$FF65         ; $2AF874 ORI.B  #$FF65,D5
        BCLR    D0,-$6A(A4,D0.W)                ; $2AF878
        MOVE.W  -(A5),$039C(A7)                 ; $2AF87C
        ORI.L  #$FF800061,(A6)                  ; $2AF880
        DC.W    $001A,$FFE8         ; $2AF886 ORI.B  #$FFE8,(A2)+
loc_2AF88A:
        ORI.W  #$004D,-(A1)                     ; $2AF88A
        DC.W    $FFE8,$01FB         ; $2AF88E MOVE.W  $01FB(A0),<EA:3F>
        ORI.W  #$FF80,A5                        ; $2AF892
        BSET    D0,$1A(PC,D0.W)                 ; $2AF896
        MOVE.W  D0,$61(A7,D0.W)                 ; $2AF89A
        ORI.L  #$FF8001FB,D1                    ; $2AF89E
        ORI.L  #$FEC60044,D1                    ; $2AF8A4
        ORI.W  #$FEC6,A5                        ; $2AF8AA
        DC.W    $0009,$004D         ; $2AF8AE ORI.B  #$004D,A1
        DC.W    $FFE5               ; $2AF8B2 MOVE.W  -(A5),<EA:3F>
        DC.W    $0009,$004D         ; $2AF8B4 ORI.B  #$004D,A1
        DC.W    $FFE5               ; $2AF8B8 MOVE.W  -(A5),<EA:3F>
        ORI.W  #$004D,-(A6)                     ; $2AF8BA
        MOVE.W  -(A5),$039C(A7)                 ; $2AF8BE
        DC.W    $FFFB,$FFFE         ; $2AF8C2 MOVE.W  -$02(PC,A7.L),<EA:3F>
        BCLR    D1,(A4)+                        ; $2AF8C6
        MOVE.W  -$02(A3,A7.L),-$4C(A7,D0.W)     ; $2AF8C8
        MOVE.W  $65(A3,A7.L),-$4C(A7,D0.W)      ; $2AF8CE
        DC.W    $FFFB,$FF65         ; $2AF8D4 MOVE.W  $65(PC,A7.L),<EA:3F>
        BCLR    D1,(A4)+                        ; $2AF8D8
        MOVE.W  -$009B(A2),$01B4(A7)            ; $2AF8DA
        MOVE.W  -$0080(A2),$01FB(A7)            ; $2AF8E0
loc_2AF8E6:
        DC.W    $FFE6               ; $2AF8E6 MOVE.W  -(A6),<EA:3F>
        DC.W    $FFE8,$01FB         ; $2AF8E8 MOVE.W  $01FB(A0),<EA:3F>
        MOVE.W  -$18(A3,A7.L),$61(A7,D0.W)      ; $2AF8EC
        MOVE.W  -$80(A3,A7.L),$61(A7,D0.W)      ; $2AF8F2
        DC.W    $FFE6               ; $2AF8F8 MOVE.W  -(A6),<EA:3F>
        MOVE.W  D0,-$05(A7,D0.W)                ; $2AF8FA
        DC.W    $FF7F,$FF80         ; $2AF8FE MOVE.W  <EA:3F>,-$0080(A7)
        ORI.W  #$FF7F,-(A1)                     ; $2AF902
        MOVE.W  D6,(A7)+                        ; $2AF906
        ORI.W  #$FFB0,D4                        ; $2AF908
        MOVE.W  D6,(A7)+                        ; $2AF90C
        DC.W    $0009,$FFB0         ; $2AF90E ORI.B  #$FFB0,A1
        DC.W    $FFE5               ; $2AF912 MOVE.W  -(A5),<EA:3F>
        DC.W    $0009,$FFB0         ; $2AF914 ORI.B  #$FFB0,A1
        DC.W    $FFE5               ; $2AF918 MOVE.W  -(A5),<EA:3F>
        ORI.W  #$FFB0,-(A6)                     ; $2AF91A
        DC.W    $0010,$6E00         ; $2AF91E ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2AF922 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AF926 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2AF92A
        ORI.W  #$0050,D0                        ; $2AF92E
        SUBI.B  #$7000,(A0)                     ; $2AF932
        ORI.W  #$0070,-(A0)                     ; $2AF936
        SUBI.B  #$6F00,(A0)                     ; $2AF93A
        DC.W    $0000,$0030         ; $2AF93E ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AF942 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AF946 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AF94A ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AF94E
        DC.W    $00B0,$0210,$0400,$00D0; $2AF954 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AF95C DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AF95E
        ORI.L  #$00900611,-(A0)                 ; $2AF962
        BTST    D3,D1                           ; $2AF968
        DC.W    $00B0,$0010,$6A00,$00E0; $2AF96A ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AF972 DC.W    $00F0
        BTST    D0,D0                           ; $2AF974
        BTST    D0,(A0)                         ; $2AF976
        DC.W    $0210,$6C00         ; $2AF978 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AF97C
        SUBI.B  #$6B00,(A0)                     ; $2AF980
        BTST    D0,D0                           ; $2AF984
        DC.W    $00F0               ; $2AF986 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AF988 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AF98C DC.W    $00E0
        DC.W    $0010,$6300         ; $2AF98E ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AF992
        BCHG    D0,(A0)                         ; $2AF994
        BCHG    D0,-(A0)                        ; $2AF996
        BCHG    D0,$10(A0,D0.W)                 ; $2AF998
        BCS.W  loc_2AFB2E                       ; $2AF99C
        BCLR    D0,D0                           ; $2AF9A0
        SUBI.B  #$6400,(A0)                     ; $2AF9A2
        BCHG    D0,-(A0)                        ; $2AF9A6
        BCHG    D0,(A0)                         ; $2AF9A8
        ADDI.B  #$6201,(A1)                     ; $2AF9AA
        BCHG    D0,$10(A0,D0.W)                 ; $2AF9AE
        BPL.W  loc_2AFB94                       ; $2AF9B2
        BSET    D0,$00(A0,D0.W)                 ; $2AF9B6
        DC.W    $0210,$0210         ; $2AF9BA ANDI.B  #$0210,(A0)
        BGE.W  loc_2AFBF0                       ; $2AF9BE
        DC.W    $0220,$0410         ; $2AF9C2 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2AFBC8                       ; $2AF9C6
        BSET    D0,$11(A0,D0.W)                 ; $2AF9CA
        BVS.S  loc_2AF9D1                       ; $2AF9CE
        DC.W    $0210,$0010         ; $2AF9D0 ANDI.B  #$0010,(A0)
        BLS.W  loc_2AFC16                       ; $2AF9D4
        ANDI.W  #$0260,(A0)                     ; $2AF9D8
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2AF9DC
        ANDI.L  #$02800410,(A0)                 ; $2AF9E2
        BCC.W  loc_2AFC4A                       ; $2AF9E8
        ANDI.W  #$0211,(A0)                     ; $2AF9EC
        BHI.S  loc_2AF9F3                       ; $2AF9F0
        ANDI.W  #$0010,D0                       ; $2AF9F2
        BNE.W  loc_2AFC98                       ; $2AF9F6
        DC.W    $02B0,$02C0,$02D0,$0610; $2AF9FA ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2AFCE4                       ; $2AFA02
        DC.W    $02F0               ; $2AFA06 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2AFA08
        BTST    D1,D0                           ; $2AFA0C
        BTST    D1,(A0)                         ; $2AFA0E
        SUBI.B  #$6700,(A0)                     ; $2AFA10
        ANDI.L  #$02D00010,-(A0)                ; $2AFA14
        BTST    D1,D0                           ; $2AFA1A
        BTST    D1,-(A0)                        ; $2AFA1C
        BTST    D1,$40(A0,D0.W)                 ; $2AFA1E
        BCHG    D1,(A0)                         ; $2AFA22
        DC.W    $0210,$0500         ; $2AFA24 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2AFA28
        SUBI.B  #$0400,(A0)                     ; $2AFA2C
        BCHG    D1,D0                           ; $2AFA30
        BTST    D1,$10(A0,D0.W)                 ; $2AFA32
        BCS.W  loc_2AFDB8                       ; $2AFA36
        BCLR    D1,(A0)                         ; $2AFA3A
        BCLR    D1,-(A0)                        ; $2AFA3C
        BCLR    D1,$10(A0,D0.W)                 ; $2AFA3E
        BLS.W  loc_2AFE14                       ; $2AFA42
        BSET    D1,D0                           ; $2AFA46
        SUBI.B  #$6400,(A0)                     ; $2AFA48
        BCLR    D1,-(A0)                        ; $2AFA4C
        BCLR    D1,(A0)                         ; $2AFA4E
        DC.W    $0010,$0300         ; $2AFA50 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2AFA54
        SUBI.W  #$0450,D0                       ; $2AFA58
        DC.W    $0210,$0500         ; $2AFA5C ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2AFA60
        SUBI.B  #$0440,D0                       ; $2AFA66
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2AFA6A
        SUBI.L  #$049004A0,D0                   ; $2AFA70
        DC.W    $04B0,$0210,$6300,$04D0; $2AFA76 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2AFA7E DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2AFA80
        SUBI.L  #$04900000,-(A0)                ; $2AFA84
        BVS.W  loc_2AFC2C                       ; $2AFA8A
        BCLR    D0,-$40(A0,D0.W)                ; $2AFA8E
        BSET    D0,(A0)                         ; $2AFA92
        DC.W    $0000,$6600         ; $2AFA94 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2AFA98
        BSET    D1,$00(A0,D0.W)                 ; $2AFA9A
        SUBI.B  #$0000,(A0)                     ; $2AFA9E
        BNE.W  loc_2AFF84                       ; $2AFAA2
        DC.W    $04F0               ; $2AFAA6 DC.W    $04F0
        BTST    D2,D0                           ; $2AFAA8
        BTST    D2,(A0)                         ; $2AFAAA
        CMPI.B  #$0052,D0                       ; $2AFAAC
        ORI.W  #$FD60,(A2)                      ; $2AFAB0
        BSET    D1,-$6F(A7,D0.W)                ; $2AFAB4
        MOVE.W  (A5)+,$0403(A6)                 ; $2AFAB8
        MOVE.W  -$23(A2,A7.L),$056C(A7)         ; $2AFABC
        MOVE.W  -(A5),-$031F(A7)                ; $2AFAC2
        BCHG    D2,(A7)+                        ; $2AFAC6
        DC.W    $00BD,$FE1C,$043A   ; $2AFAC8 ORI.L  #$FE1C043A,<EA:3D>
        MOVE.W  -$38(A2,A7.L),$05B1(A7)         ; $2AFACE
        MOVE.W  -(A5),-$01E1(A7)                ; $2AFAD4
        SUBI.B  #$0091,-$0234(A7)               ; $2AFAD8
        BCLR    D2,-(A3)                        ; $2AFADE
        DC.W    $00BD,$FD9E,$05B5   ; $2AFAE0 ORI.L  #$FD9E05B5,<EA:3D>
        ORI.W  #$FCF9,$0573(A7)                 ; $2AFAE6
        DC.W    $0015,$FCB1         ; $2AFAEC ORI.B  #$FCB1,(A5)
        ADDI.W  #$001F,-$029B(A4)               ; $2AFAF0
        ADDI.W  #$0077,-$0264(PC)               ; $2AFAF6
        BCLR    D2,#$FFBF                       ; $2AFAFC
        MOVE.W  -(A3),$0682(A6)                 ; $2AFB00
        DC.W    $FFC7               ; $2AFB04 MOVE.W  D7,<EA:3F>
        MOVE.W  $0B(A2,D0.W),-(A6)              ; $2AFB06
        DC.W    $00C4               ; $2AFB0A DC.W    $00C4
        MOVE.W  $0523(A5),$0125(A6)             ; $2AFB0C
        MOVE.W  (A0),(A7)                       ; $2AFB12
        SUBI.W  #$0120,(A7)                     ; $2AFB14
        MOVEA.W $042B(A7),A7                    ; $2AFB18
        DC.W    $00BF,$FD71,$0565   ; $2AFB1C ORI.L  #$FD710565,<EA:3F>
        DC.W    $00C5               ; $2AFB22 DC.W    $00C5
        MOVE.W  $0485(A7),(A7)                  ; $2AFB24
        DC.W    $00C0               ; $2AFB28 DC.W    $00C0
        MOVE.W  D6,(A7)                         ; $2AFB2A
        DC.W    $04D9               ; $2AFB2C DC.W    $04D9
loc_2AFB2E:
        DC.W    $00D1               ; $2AFB2E DC.W    $00D1
        MOVE.W  -(A3),(A7)                      ; $2AFB30
        DC.W    $04BB,$0118,$FDB4,$03C5; $2AFB32 SUBI.L  #$0118FDB4,-$3B(PC,D0.W)
        BTST    D0,(A7)                         ; $2AFB3A
        MOVE.W  -(A1),$03AF(A6)                 ; $2AFB3C
        DC.W    $00CF               ; $2AFB40 DC.W    $00CF
        MOVE.W  D1,(A7)+                        ; $2AFB42
        SUBI.L  #$00D0FD9D,(A6)+                ; $2AFB44
        BCHG    D1,-$32(A4,D0.W)                ; $2AFB4A
        MOVE.W  A2,(A7)                         ; $2AFB4E
        BCLR    D1,-(A1)                        ; $2AFB50
        DC.W    $00C4               ; $2AFB52 DC.W    $00C4
        MOVEA.W (A5)+,A6                        ; $2AFB54
        BCHG    D1,-(A2)                        ; $2AFB56
        DC.W    $00C6               ; $2AFB58 DC.W    $00C6
        MOVE.W  -(A3),-$30(A6,D0.W)             ; $2AFB5A
        DC.W    $00C2               ; $2AFB5E DC.W    $00C2
        MOVE.W  -(A7),(A7)+                     ; $2AFB60
        DC.W    $02E8               ; $2AFB62 DC.W    $02E8
        DC.W    $00C0               ; $2AFB64 DC.W    $00C0
        MOVEA.W (A2),A6                         ; $2AFB66
        BTST    D2,$58(A4,A7.L)                 ; $2AFB68
        MOVEA.W $0504(A0),A6                    ; $2AFB6C
        MOVE.W  -$50(A5,A7.L),(A7)+             ; $2AFB70
        DC.W    $058E               ; $2AFB74 BCLR    D2,A6
        MOVE.W  $FDB9.W,(A7)+                   ; $2AFB76
        DC.W    $05CA               ; $2AFB7A BSET    D2,A2
        MOVE.W  (A3)+,-$0383(A7)                ; $2AFB7C
        DC.W    $04CD               ; $2AFB80 DC.W    $04CD
        MOVE.W  (A3),-$021C(A7)                 ; $2AFB82
        BCHG    D2,-(A4)                        ; $2AFB86
        MOVE.W  (A7),-$0391(A7)                 ; $2AFB88
        ADDI.W  #$FF52,(A2)+                    ; $2AFB8C
        MOVEA.W (A2)+,A6                        ; $2AFB90
        ADDI.B  #$FF08,A2                       ; $2AFB92
        MOVE.W  -$41(A3,D0.W),(A6)              ; $2AFB96
        MOVE.W  -$24(PC,A7.L),(A7)+             ; $2AFB9A
        DC.W    $04C7               ; $2AFB9E DC.W    $04C7
        MOVE.W  D2,-$03E2(A7)                   ; $2AFBA0
        ADDI.W  #$FF51,D4                       ; $2AFBA4
        MOVE.W  A3,(A6)                         ; $2AFBA8
        DC.W    $04B2,$FF42,$FDA6,$0288; $2AFBAA SUBI.L  #$FF42FDA6,-$78(A2,D0.W)
        DC.W    $00B1,$FDA6,$0288,$FF4F; $2AFBB2 ORI.L  #$FDA60288,$4F(A1,A7.L)
        MOVE.W  -(A5),$040C(A6)                 ; $2AFBBA
        MOVE.W  -$029B(A7),$040C(A7)            ; $2AFBBE
        ORI.L  #$FE5D02A6,(A1)                  ; $2AFBC4
        MOVE.W  A7,-$01E5(A7)                   ; $2AFBCA
        SUBI.B  #$FF6F,-$01A3(A3)               ; $2AFBCE
        ANDI.L  #$00B1FE1B,-(A6)                ; $2AFBD4
        SUBI.B  #$0091,-$0362(A3)               ; $2AFBDA
        DC.W    $020B,$0008         ; $2AFBE0 ANDI.B  #$0008,A3
        MOVE.W  A1,-(A6)                        ; $2AFBE4
        BCLR    D0,(A4)+                        ; $2AFBE6
        ORI.W  #$FE6A,(A0)                      ; $2AFBE8
        DC.W    $02EE               ; $2AFBEC DC.W    $02EE
        ORI.W  #$FDFF,A5                        ; $2AFBEE
        BCHG    D1,(A5)+                        ; $2AFBF2
        DC.W    $0004,$FC9E         ; $2AFBF4 ORI.B  #$FC9E,D4
        DC.W    $020C,$0099         ; $2AFBF8 ANDI.B  #$0099,A4
        DC.W    $FDFF               ; $2AFBFC MOVE.W  <EA:3F>,<EA:3E>
        BCHG    D1,(A6)+                        ; $2AFBFE
        ORI.L  #$FC9F0059,(A5)                  ; $2AFC00
        DC.W    $0020,$FD07         ; $2AFC06 ORI.B  #$FD07,-(A0)
        ORI.W  #$0052,(A2)+                     ; $2AFC0A
        MOVE.W  D4,-(A6)                        ; $2AFC0E
        BSET    D0,$50(A4,D0.W)                 ; $2AFC10
        MOVE.W  (A4)+,(A6)                      ; $2AFC14
loc_2AFC16:
        BSET    D0,$1D(A3,D0.W)                 ; $2AFC16
        MOVE.W  -(A0),(A6)                      ; $2AFC1A
        ORI.W  #$0087,(A2)+                     ; $2AFC1C
        MOVE.W  (A4)+,(A6)                      ; $2AFC20
        BSET    D0,-$7C(A3,D0.W)                ; $2AFC22
        DC.W    $FBE5               ; $2AFC26 MOVE.W  -(A5),<EA:3D>
        ORI.W  #$0053,A3                        ; $2AFC28
loc_2AFC2C:
        DC.W    $FBE2               ; $2AFC2C MOVE.W  -(A2),<EA:3D>
        DC.W    $0010,$0053         ; $2AFC2E ORI.B  #$0053,(A0)
        DC.W    $FCFF               ; $2AFC32 MOVE.W  <EA:3F>,(A6)+
        DC.W    $0003,$0053         ; $2AFC34 ORI.B  #$0053,D3
        MOVE.W  D5,-(A6)                        ; $2AFC38
        ORI.W  #$0053,(A7)+                     ; $2AFC3A
        DC.W    $FDC2               ; $2AFC3E MOVE.W  D2,<EA:3E>
        BTST    D1,#$FFF9                       ; $2AFC40
        MOVEA.W (A5),A7                         ; $2AFC44
        DC.W    $030E               ; $2AFC46 BTST    D1,A6
        MOVE.W  -$38(A3,A7.L),$3A(A7,D0.W)      ; $2AFC48
        MOVE.W  $35(A7,A7.L),$67(A7,D0.W)       ; $2AFC4E
        DC.W    $FFFE               ; $2AFC54 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $FDC3               ; $2AFC56 MOVE.W  D3,<EA:3E>
        BTST    D1,-$0098(PC)                   ; $2AFC58
        MOVE.W  $66(A6,D0.W),-(A6)              ; $2AFC5C
        MOVE.W  -$02A3(A5),$0105(A7)            ; $2AFC60
        DC.W    $FFEB,$FD76         ; $2AFC66 MOVE.W  -$028A(A3),<EA:3F>
        BCHG    D0,-$004A(A0)                   ; $2AFC6A
        MOVE.W  D4,-(A7)                        ; $2AFC6E
        BTST    D0,D2                           ; $2AFC70
        MOVE.W  -$0116(PC),-$62(A7,D0.W)        ; $2AFC72
        DC.W    $FFEE,$FD5D         ; $2AFC78 MOVE.W  -$02A3(A6),<EA:3F>
        BTST    D0,D4                           ; $2AFC7C
        MOVE.W  D4,-$16(A7,A7.L)                ; $2AFC7E
        ORI.L  #$FF88FE79,(A5)+                 ; $2AFC82
        DC.W    $0003,$FFB7         ; $2AFC88 ORI.B  #$FFB7,D3
        MOVE.W  -$001E(A1),(A7)                 ; $2AFC8C
        MOVE.W  $4D(A7,A7.L),-$34(A7,D0.W)      ; $2AFC90
        MOVE.W  $02(A7,A7.L),$02(A7,D0.W)       ; $2AFC96
        MOVE.W  $10(A7,D0.W),$00(A7,D6.L)       ; $2AFC9C
        DC.W    $0000,$0010         ; $2AFCA2 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2AFCA6 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2AFCAA
        ORI.W  #$0050,D0                        ; $2AFCAE
        SUBI.B  #$7000,(A0)                     ; $2AFCB2
        ORI.W  #$0070,-(A0)                     ; $2AFCB6
        SUBI.B  #$6F00,(A0)                     ; $2AFCBA
        DC.W    $0000,$0030         ; $2AFCBE ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2AFCC2 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2AFCC6 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2AFCCA ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2AFCCE
        DC.W    $00B0,$0210,$0400,$00D0; $2AFCD4 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2AFCDC DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2AFCDE
        ORI.L  #$00900611,-(A0)                 ; $2AFCE2
        BTST    D3,D1                           ; $2AFCE8
        DC.W    $00B0,$0010,$6A00,$00E0; $2AFCEA ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2AFCF2 DC.W    $00F0
        BTST    D0,D0                           ; $2AFCF4
        BTST    D0,(A0)                         ; $2AFCF6
        DC.W    $0210,$6C00         ; $2AFCF8 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2AFCFC
        SUBI.B  #$6B00,(A0)                     ; $2AFD00
        BTST    D0,D0                           ; $2AFD04
        DC.W    $00F0               ; $2AFD06 DC.W    $00F0
        DC.W    $0211,$6901         ; $2AFD08 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2AFD0C DC.W    $00E0
        DC.W    $0010,$6300         ; $2AFD0E ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2AFD12
        BCHG    D0,(A0)                         ; $2AFD14
        BCHG    D0,-(A0)                        ; $2AFD16
        BCHG    D0,$10(A0,D0.W)                 ; $2AFD18
        BCS.W  loc_2AFEAE                       ; $2AFD1C
        BCLR    D0,D0                           ; $2AFD20
        SUBI.B  #$6400,(A0)                     ; $2AFD22
        BCHG    D0,-(A0)                        ; $2AFD26
        BCHG    D0,(A0)                         ; $2AFD28
        ADDI.B  #$6201,(A1)                     ; $2AFD2A
        BCHG    D0,$10(A0,D0.W)                 ; $2AFD2E
        BPL.W  loc_2AFF14                       ; $2AFD32
        BSET    D0,$00(A0,D0.W)                 ; $2AFD36
        DC.W    $0210,$0210         ; $2AFD3A ANDI.B  #$0210,(A0)
        BGE.W  loc_2AFF70                       ; $2AFD3E
        DC.W    $0220,$0410         ; $2AFD42 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2AFF48                       ; $2AFD46
        BSET    D0,$11(A0,D0.W)                 ; $2AFD4A
        BVS.S  loc_2AFD51                       ; $2AFD4E
        DC.W    $0210,$0010         ; $2AFD50 ANDI.B  #$0010,(A0)
        BLS.W  loc_2AFF96                       ; $2AFD54
        ANDI.W  #$0260,(A0)                     ; $2AFD58
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2AFD5C
        ANDI.L  #$02800410,(A0)                 ; $2AFD62
        BCC.W  loc_2AFFCA                       ; $2AFD68
        ANDI.W  #$0211,(A0)                     ; $2AFD6C
        BHI.S  loc_2AFD73                       ; $2AFD70
        ANDI.W  #$0010,D0                       ; $2AFD72
        BNE.W  loc_2B0018                       ; $2AFD76
        DC.W    $02B0,$02C0,$02D0,$0610; $2AFD7A ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B0064                       ; $2AFD82
        DC.W    $02F0               ; $2AFD86 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2AFD88
        BTST    D1,D0                           ; $2AFD8C
        BTST    D1,(A0)                         ; $2AFD8E
        SUBI.B  #$6700,(A0)                     ; $2AFD90
        ANDI.L  #$02D00010,-(A0)                ; $2AFD94
        BTST    D1,D0                           ; $2AFD9A
        BTST    D1,-(A0)                        ; $2AFD9C
        BTST    D1,$40(A0,D0.W)                 ; $2AFD9E
        BCHG    D1,(A0)                         ; $2AFDA2
        DC.W    $0210,$0500         ; $2AFDA4 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2AFDA8
        SUBI.B  #$0400,(A0)                     ; $2AFDAC
        BCHG    D1,D0                           ; $2AFDB0
        BTST    D1,$10(A0,D0.W)                 ; $2AFDB2
        BCS.W  loc_2B0138                       ; $2AFDB6
        BCLR    D1,(A0)                         ; $2AFDBA
        BCLR    D1,-(A0)                        ; $2AFDBC
        BCLR    D1,$10(A0,D0.W)                 ; $2AFDBE
        BLS.W  loc_2B0194                       ; $2AFDC2
        BSET    D1,D0                           ; $2AFDC6
        SUBI.B  #$6400,(A0)                     ; $2AFDC8
        BCLR    D1,-(A0)                        ; $2AFDCC
        BCLR    D1,(A0)                         ; $2AFDCE
        DC.W    $0010,$0300         ; $2AFDD0 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2AFDD4
        SUBI.W  #$0450,D0                       ; $2AFDD8
        DC.W    $0210,$0500         ; $2AFDDC ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2AFDE0
        SUBI.B  #$0440,D0                       ; $2AFDE6
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2AFDEA
        SUBI.L  #$049004A0,D0                   ; $2AFDF0
        DC.W    $04B0,$0210,$6300,$04D0; $2AFDF6 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2AFDFE DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2AFE00
        SUBI.L  #$04900000,-(A0)                ; $2AFE04
        BVS.W  loc_2AFFAC                       ; $2AFE0A
        BCLR    D0,-$40(A0,D0.W)                ; $2AFE0E
        BSET    D0,(A0)                         ; $2AFE12
loc_2AFE14:
        DC.W    $0000,$6600         ; $2AFE14 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2AFE18
        BSET    D1,$00(A0,D0.W)                 ; $2AFE1A
        SUBI.B  #$0000,(A0)                     ; $2AFE1E
        BNE.W  $2B0304                          ; $2AFE22
        DC.W    $04F0               ; $2AFE26 DC.W    $04F0
        BTST    D2,D0                           ; $2AFE28
        BTST    D2,(A0)                         ; $2AFE2A
        CMPI.B  #$0052,D0                       ; $2AFE2C
        ORI.W  #$FBA5,(A2)                      ; $2AFE30
        BCLR    D1,$0091(A0)                    ; $2AFE34
        MOVE.W  -(A3),-$50(A5,D0.W)             ; $2AFE38
        MOVE.W  $10(A1,A7.L),$0512(A7)          ; $2AFE3C
        MOVE.W  (A7)+,-$04ED(A7)                ; $2AFE42
        DC.W    $0509               ; $2AFE46 BTST    D2,A1
        DC.W    $00B8,$FC5F,$03F1,$FF71; $2AFE48 ORI.L  #$FC5F03F1,$FF71.W
        DC.W    $FBF7,$0562         ; $2AFE50 MOVE.W  $62(A7,D0.W),<EA:3D>
        MOVE.W  (A7)+,-$039E(A7)                ; $2AFE54
        BSET    D1,$0091(A2)                    ; $2AFE58
        DC.W    $FBFA,$055A         ; $2AFE5C MOVE.W  $055A(PC),<EA:3D>
        DC.W    $00B8,$FBCC,$0568,$0069; $2AFE60 ORI.L  #$FBCC0568,$0069.W
        MOVE.W  $051C(A4),-(A5)                 ; $2AFE68
        DC.W    $0010,$FAD5         ; $2AFE6C ORI.B  #$FAD5,(A0)
        ADDI.B  #$0016,(A1)                     ; $2AFE70
        MOVE.W  A1,$2B(A5,D0.W)                 ; $2AFE74
        ORI.W  #$FBCB,$056C(A6)                 ; $2AFE78
        DC.W    $FFB9,$FB87,$062F,$FFBE; $2AFE7E MOVE.W  $FB87062F,-$42(A7,A7.L)
        MOVE.W  (A4)+,$04ED(A5)                 ; $2AFE86
        DC.W    $00C1               ; $2AFE8A DC.W    $00C1
        MOVE.W  (A4)+,-$10(A5,D0.W)             ; $2AFE8C
        BTST    D0,-(A1)                        ; $2AFE90
        MOVEA.W -(A4),A6                        ; $2AFE92
        DC.W    $03C9               ; $2AFE94 BSET    D1,A1
        BTST    D0,(A4)+                        ; $2AFE96
        MOVE.W  -$54(A5,D0.W),D6                ; $2AFE98
        DC.W    $00BC,$FBB7,$052C,$00C1,$FC91; $2AFE9C ORI.L  #$FBB7052C,#$00C1FC91
        BSET    D1,$00BC(A1)                    ; $2AFEA6
        MOVE.W  D3,(A6)                         ; $2AFEAA
        SUBI.W  #$00CC,D6                       ; $2AFEAC
        MOVE.W  (A7),(A6)                       ; $2AFEB0
        SUBI.B  #$0113,-(A0)                    ; $2AFEB2
        MOVE.W  -(A7),$0383(A5)                 ; $2AFEB6
        BTST    D0,(A5)                         ; $2AFEBA
        MOVE.W  (A1),-(A5)                      ; $2AFEBC
        BCLR    D1,D6                           ; $2AFEBE
        DC.W    $00CE               ; $2AFEC0 DC.W    $00CE
        MOVE.W  $03FB(A1),(A6)                  ; $2AFEC2
        DC.W    $00CB               ; $2AFEC6 DC.W    $00CB
        MOVE.W  $033C.W,-(A5)                   ; $2AFEC8
        DC.W    $00CD               ; $2AFECC DC.W    $00CD
        MOVE.W  -(A6),D6                        ; $2AFECE
        BTST    D1,(A4)+                        ; $2AFED0
        DC.W    $00C1               ; $2AFED2 DC.W    $00C1
        MOVE.W  D2,D5                           ; $2AFED4
        DC.W    $038E               ; $2AFED6 BCLR    D1,A6
        DC.W    $00C8               ; $2AFED8 DC.W    $00C8
        MOVE.W  A2,-(A5)                        ; $2AFEDA
        ANDI.L  #$00C3FC45,(A6)+                ; $2AFEDC
        ANDI.W  #$00BF,A7                       ; $2AFEE2
        MOVE.W  (A3)+,(A5)+                     ; $2AFEE6
        SUBI.B  #$FEF2,(A3)                     ; $2AFEE8
        MOVE.W  -(A4),-(A5)                     ; $2AFEEC
        SUBI.B  #$FEA0,D4                       ; $2AFEEE
        DC.W    $FBC1               ; $2AFEF2 MOVE.W  D1,<EA:3D>
        BTST    D2,$FEF1FB86                    ; $2AFEF4
        BCHG    D2,-(A5)                        ; $2AFEFA
        MOVE.W  A2,-$04C6(A7)                   ; $2AFEFC
        BSET    D1,(A6)+                        ; $2AFF00
        MOVE.W  D6,-(A7)                        ; $2AFF02
        DC.W    $FBE5               ; $2AFF04 MOVE.W  -(A5),<EA:3D>
        BTST    D2,$5F(A0,A7.L)                 ; $2AFF06
        MOVEA.W D2,A5                           ; $2AFF0A
        BTST    D2,(A0)                         ; $2AFF0C
        MOVE.W  (A4),(A7)+                      ; $2AFF0E
        MOVEA.W $04C9.W,A5                      ; $2AFF10
loc_2AFF14:
        MOVE.W  (A0),(A7)                       ; $2AFF14
        MOVE.W  D5,-$06(A5,D0.W)                ; $2AFF16
        MOVE.W  D3,(A7)+                        ; $2AFF1A
        MOVE.W  A1,$13(A5,D0.W)                 ; $2AFF1C
        MOVE.W  (A2),-(A7)                      ; $2AFF20
        MOVE.W  (A3),D5                         ; $2AFF22
        DC.W    $04CD               ; $2AFF24 DC.W    $04CD
        DC.W    $FEBF               ; $2AFF26 MOVE.W  <EA:3F>,(A7)
        MOVE.W  (A2)+,$03D0(A5)                 ; $2AFF28
        MOVE.W  #$FBEB,(A7)+                    ; $2AFF2C
        ANDI.W  #$00B1,D0                       ; $2AFF30
        DC.W    $FBEB,$0240         ; $2AFF34 MOVE.W  $0240(A3),<EA:3D>
        MOVE.W  A7,-$0457(A7)                   ; $2AFF38
        BSET    D1,D4                           ; $2AFF3C
        MOVE.W  -$0457(A7),$03C4(A7)            ; $2AFF3E
        ORI.L  #$FCA1025F,(A1)                  ; $2AFF44
        MOVE.W  A7,-$03A0(A7)                   ; $2AFF4A
        BSET    D1,-(A3)                        ; $2AFF4E
        MOVE.W  -$035F(A7),$025F(A7)            ; $2AFF50
        DC.W    $00B1,$FC60,$03E3,$0091; $2AFF56 ORI.L  #$FC6003E3,-$6F(A1,D0.W)
        MOVE.W  D3,$0147(A5)                    ; $2AFF5E
        DC.W    $0009,$FBCD         ; $2AFF62 ORI.B  #$FBCD,A1
        BTST    D0,D5                           ; $2AFF66
        ORI.W  #$FCA2,(A2)                      ; $2AFF68
        DC.W    $02BE,$004D,$FC18   ; $2AFF6C ANDI.L  #$004DFC18,<EA:3E>
        BTST    D1,D0                           ; $2AFF72
        DC.W    $0004,$FB43         ; $2AFF74 ORI.B  #$FB43,D4
        DC.W    $0149               ; $2AFF78 BCHG    D0,A1
        ORI.L  #$FC180302,(A1)+                 ; $2AFF7A
        ORI.L  #$FCA40005,(A4)                  ; $2AFF80
        DC.W    $0022,$FCDF         ; $2AFF86 ORI.B  #$FCDF,-(A2)
        ORI.W  #$0054,(A3)+                     ; $2AFF8A
        MOVE.W  A5,$43(A5,D0.W)                 ; $2AFF8E
        ORI.W  #$FB52,(A1)                      ; $2AFF92
loc_2AFF96:
        DC.W    $00ED               ; $2AFF96 DC.W    $00ED
        DC.W    $001E,$FCA4         ; $2AFF98 ORI.B  #$FCA4,(A6)+
        DC.W    $0007,$008A         ; $2AFF9C ORI.B  #$008A,D7
        MOVE.W  (A2),$00EF(A5)                  ; $2AFFA0
        ORI.L  #$FBC0003E,D6                    ; $2AFFA4
        ORI.W  #$FBC0,(A6)                      ; $2AFFAA
        DC.W    $0003,$0056         ; $2AFFAE ORI.B  #$0056,D3
        MOVE.W  (A7)+,(A6)+                     ; $2AFFB2
        DC.W    $0003,$0056         ; $2AFFB4 ORI.B  #$0056,D3
        MOVE.W  (A7)+,(A6)+                     ; $2AFFB8
        ORI.W  #$0056,(A7)+                     ; $2AFFBA
        MOVEA.W $1B(A1,D0.W),A6                 ; $2AFFBE
        DC.W    $FFF8,$FCB2         ; $2AFFC2 MOVE.W  $FCB2.W,<EA:3F>
        ANDI.L  #$FFB3FAF5,A7                   ; $2AFFC6
        BSET    D0,D2                           ; $2AFFCC
        MOVE.W  $FAB6.W,$4E(A7,D0.W)            ; $2AFFCE
        DC.W    $FFFE               ; $2AFFD4 MOVE.W  <EA:3E>,<EA:3F>
        MOVEA.W $19(A1,D0.W),A6                 ; $2AFFD6
        MOVE.W  -$054B(A0),$024C(A7)            ; $2AFFDA
        MOVE.W  -$0574(A5),$01C1(A7)            ; $2AFFE0
        DC.W    $FFEC,$FACB         ; $2AFFE6 MOVE.W  -$0535(A4),<EA:3F>
        DC.W    $0211,$FFB7         ; $2AFFEA ANDI.B  #$FFB7,(A1)
        MOVE.W  A5,D6                           ; $2AFFEE
        BTST    D0,(A2)                         ; $2AFFF0
        MOVE.W  -$0433(PC),-$3E(A7,D0.W)        ; $2AFFF2
        DC.W    $FFEF,$FA8C         ; $2AFFF8 MOVE.W  -$0574(A7),<EA:3F>
        DC.W    $01BF               ; $2AFFFC BCLR    D0,<EA:3F>
        MOVE.W  D5,-$34(A7,A7.L)                ; $2AFFFE
        DC.W    $00C0               ; $2B0002 DC.W    $00C0
        MOVE.W  A0,$37(A7,A7.L)                 ; $2B0004
        ORI.W  #$FFB7,A5                        ; $2B0008
        MOVE.W  (A3)+,$001E(A5)                 ; $2B000C
        MOVE.W  $41(A7,A7.L),-$38(A7,D0.W)      ; $2B0010
        MOVE.W  $0A(A7,A7.L),$13(A7,D0.W)       ; $2B0016
        MOVE.W  $10(A7,D0.W),$00(A7,D6.L)       ; $2B001C
        DC.W    $0000,$0010         ; $2B0022 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B0026 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B002A
        ORI.W  #$0050,D0                        ; $2B002E
        SUBI.B  #$7000,(A0)                     ; $2B0032
        ORI.W  #$0070,-(A0)                     ; $2B0036
        SUBI.B  #$6F00,(A0)                     ; $2B003A
        DC.W    $0000,$0030         ; $2B003E ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B0042 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B0046 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B004A ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B004E
        DC.W    $00B0,$0210,$0400,$00D0; $2B0054 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B005C DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B005E
        ORI.L  #$00900611,-(A0)                 ; $2B0062
        BTST    D3,D1                           ; $2B0068
        DC.W    $00B0,$0010,$6A00,$00E0; $2B006A ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B0072 DC.W    $00F0
        BTST    D0,D0                           ; $2B0074
        BTST    D0,(A0)                         ; $2B0076
        DC.W    $0210,$6C00         ; $2B0078 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B007C
        SUBI.B  #$6B00,(A0)                     ; $2B0080
        BTST    D0,D0                           ; $2B0084
        DC.W    $00F0               ; $2B0086 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B0088 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B008C DC.W    $00E0
        DC.W    $0010,$6300         ; $2B008E ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B0092
        BCHG    D0,(A0)                         ; $2B0094
        BCHG    D0,-(A0)                        ; $2B0096
        BCHG    D0,$10(A0,D0.W)                 ; $2B0098
        BCS.W  $2B022E                          ; $2B009C
        BCLR    D0,D0                           ; $2B00A0
        SUBI.B  #$6400,(A0)                     ; $2B00A2
        BCHG    D0,-(A0)                        ; $2B00A6
        BCHG    D0,(A0)                         ; $2B00A8
        ADDI.B  #$6201,(A1)                     ; $2B00AA
        BCHG    D0,$10(A0,D0.W)                 ; $2B00AE
        BPL.W  $2B0294                          ; $2B00B2
        BSET    D0,$00(A0,D0.W)                 ; $2B00B6
        DC.W    $0210,$0210         ; $2B00BA ANDI.B  #$0210,(A0)
        BGE.W  $2B02F0                          ; $2B00BE
        DC.W    $0220,$0410         ; $2B00C2 ANDI.B  #$0410,-(A0)
        BMI.W  $2B02C8                          ; $2B00C6
        BSET    D0,$11(A0,D0.W)                 ; $2B00CA
        BVS.S  loc_2B00D1                       ; $2B00CE
        DC.W    $0210,$0010         ; $2B00D0 ANDI.B  #$0010,(A0)
        BLS.W  $2B0316                          ; $2B00D4
        ANDI.W  #$0260,(A0)                     ; $2B00D8
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B00DC
        ANDI.L  #$02800410,(A0)                 ; $2B00E2
        BCC.W  $2B034A                          ; $2B00E8
        ANDI.W  #$0211,(A0)                     ; $2B00EC
        BHI.S  loc_2B00F3                       ; $2B00F0
        ANDI.W  #$0010,D0                       ; $2B00F2
        BNE.W  $2B0398                          ; $2B00F6
        DC.W    $02B0,$02C0,$02D0,$0610; $2B00FA ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  $2B03E4                          ; $2B0102
        DC.W    $02F0               ; $2B0106 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B0108
        BTST    D1,D0                           ; $2B010C
        BTST    D1,(A0)                         ; $2B010E
        SUBI.B  #$6700,(A0)                     ; $2B0110
        ANDI.L  #$02D00010,-(A0)                ; $2B0114
        BTST    D1,D0                           ; $2B011A
        BTST    D1,-(A0)                        ; $2B011C
        BTST    D1,$40(A0,D0.W)                 ; $2B011E
        BCHG    D1,(A0)                         ; $2B0122
        DC.W    $0210,$0500         ; $2B0124 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B0128
        SUBI.B  #$0400,(A0)                     ; $2B012C
        BCHG    D1,D0                           ; $2B0130
        BTST    D1,$10(A0,D0.W)                 ; $2B0132
        BCS.W  $2B04B8                          ; $2B0136
        BCLR    D1,(A0)                         ; $2B013A
        BCLR    D1,-(A0)                        ; $2B013C
        BCLR    D1,$10(A0,D0.W)                 ; $2B013E
        BLS.W  $2B0514                          ; $2B0142
        BSET    D1,D0                           ; $2B0146
        SUBI.B  #$6400,(A0)                     ; $2B0148
        BCLR    D1,-(A0)                        ; $2B014C
        BCLR    D1,(A0)                         ; $2B014E
        DC.W    $0010,$0300         ; $2B0150 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B0154
        SUBI.W  #$0450,D0                       ; $2B0158
        DC.W    $0210,$0500         ; $2B015C ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B0160
        SUBI.B  #$0440,D0                       ; $2B0166
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B016A
        SUBI.L  #$049004A0,D0                   ; $2B0170
        DC.W    $04B0,$0210,$6300,$04D0; $2B0176 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B017E DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B0180
        SUBI.L  #$04900000,-(A0)                ; $2B0184
        BVS.W  $2B032C                          ; $2B018A
        BCLR    D0,-$40(A0,D0.W)                ; $2B018E
        BSET    D0,(A0)                         ; $2B0192
loc_2B0194:
        DC.W    $0000,$6600         ; $2B0194 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B0198
        BSET    D1,$00(A0,D0.W)                 ; $2B019A
        SUBI.B  #$0000,(A0)                     ; $2B019E
        BNE.W  $2B0684                          ; $2B01A2
        DC.W    $04F0               ; $2B01A6 DC.W    $04F0
        BTST    D2,D0                           ; $2B01A8
        BTST    D2,(A0)                         ; $2B01AA
        CMPI.B  #$0052,D0                       ; $2B01AC
        ORI.W  #$FA04,(A2)                      ; $2B01B0
        DC.W    $02F1               ; $2B01B4 DC.W    $02F1
        ORI.L  #$FA0202F7,(A1)                  ; $2B01B6
        MOVE.W  $4D(A1,A7.L),$0449(A7)          ; $2B01BC
        MOVE.W  (A5)+,-$06B0(A7)                ; $2B01C2
        SUBI.W  #$00B6,D3                       ; $2B01C6
        MOVE.W  $4A(A7,D0.W),(A5)               ; $2B01CA
        MOVE.W  $2D(A1,A7.L),$04B0(A7)          ; $2B01CE
        MOVE.W  (A5)+,-$0547(A7)                ; $2B01D4
        BCHG    D1,D4                           ; $2B01D8
        ORI.L  #$FA3004A8,(A1)                  ; $2B01DA
        DC.W    $00B6,$FA00,$04B3,$0067; $2B01E0 ORI.L  #$FA0004B3,$67(A6,D0.W)
        MOVE.W  -(A7),$0458(A4)                 ; $2B01E8
        DC.W    $000E,$F8FB         ; $2B01EC ORI.B  #$F8FB,A6
        BCHG    D2,D3                           ; $2B01F0
        DC.W    $0013,$F9AA         ; $2B01F2 ORI.B  #$F9AA,(A3)
        BCHG    D2,$006B(A6)                    ; $2B01F6
        DC.W    $F9FF,$04B6         ; $2B01FA MOVE.W  <EA:3F>,#$04B6
        MOVE.W  -$57(A6,A7.L),$71(A7,D0.W)      ; $2B01FE
