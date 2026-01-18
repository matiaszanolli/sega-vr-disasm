; Generated assembly for $2B0200-$2B2200
; Branch targets: 103
; Labels: 95
; Format: DC.W with decoded mnemonics as comments

        org     $2B0200

        MOVE.W  $0571(A1),-$45(A4,A7.L)         ; $2B0200
        MOVE.W  -(A0),$65(A4,D0.W)              ; $2B0206
        DC.W    $00BF,$F9DC,$0447   ; $2B020A ORI.L  #$F9DC0447,<EA:3F>
        BTST    D0,(A6)+                        ; $2B0210
        MOVEA.W (A5)+,A5                        ; $2B0212
        BTST    D1,D1                           ; $2B0214
        DC.W    $00E1               ; $2B0216 DC.W    $00E1
        MOVE.W  $0302(A6),D5                    ; $2B0218
        ORI.W  #$FA08,-$74(PC,D0.W)             ; $2B021C
        DC.W    $00CC               ; $2B0222 DC.W    $00CC
        MOVE.W  (A5),(A5)                       ; $2B0224
        BTST    D1,-(A7)                        ; $2B0226
        ORI.L  #$FA850380,A1                    ; $2B0228
        DC.W    $00AB,$FA95,$034C,$00EA; $2B022E ORI.L  #$FA95034C,$00EA(A3)
        MOVE.W  -(A4),$02B7(A4)                 ; $2B0236
        DC.W    $00BC,$F912,$02C9,$0072,$FAAA; $2B023A ORI.L  #$F91202C9,#$0072FAAA
        BTST    D1,-$63(A6,D0.W)                ; $2B0244
        MOVE.W  $0281.W,-(A4)                   ; $2B0248
        ORI.W  #$FA26,-(A5)                     ; $2B024C
        ANDI.W  #$0061,-(A0)                    ; $2B0250
        MOVE.W  D3,D4                           ; $2B0254
        DC.W    $02D9               ; $2B0256 DC.W    $02D9
        ORI.W  #$F90A,(A7)+                     ; $2B0258
        BSET    D0,$003A(A1)                    ; $2B025C
        MOVEA.W D4,A5                           ; $2B0260
        BCLR    D0,(A6)                         ; $2B0262
        DC.W    $0038,$F94C,$0331   ; $2B0264 ORI.B  #$F94C,$0331.W
        MOVE.W  A1,-(A7)                        ; $2B026A
        MOVE.W  A7,$2E(A4,D0.W)                 ; $2B026C
        MOVE.W  -$0E(A1,A7.L),(A7)              ; $2B0270
        DC.W    $047D,$FEF1         ; $2B0274 SUBI.W  #$FEF1,<EA:3D>
        MOVE.W  $049E.W,$50(A4,A7.L)            ; $2B0278
        MOVE.W  $0F(A5,D0.W),$14(A4,A7.L)       ; $2B027E
        MOVE.W  -(A1),D5                        ; $2B0284
        DC.W    $047D,$FF5B         ; $2B0286 SUBI.W  #$FF5B,<EA:3D>
        MOVE.W  $037B.W,D4                      ; $2B028A
        MOVE.W  (A3)+,(A7)+                     ; $2B028E
        MOVE.W  A3,(A4)                         ; $2B0290
        BCHG    D1,(A2)+                        ; $2B0292
        MOVE.W  (A1)+,(A7)                      ; $2B0294
        MOVE.W  (A6)+,#$034A                    ; $2B0296
        MOVE.W  A1,(A7)+                        ; $2B029A
        MOVE.W  (A4),#$0369                     ; $2B029C
        MOVE.W  (A6),-(A7)                      ; $2B02A0
        MOVE.W  $28(A6,D0.W),D4                 ; $2B02A2
        MOVE.W  A5,(A7)+                        ; $2B02A6
        MOVE.W  (A2),#$0316                     ; $2B02A8
        MOVE.W  A1,-(A7)                        ; $2B02AC
        MOVEA.W D7,A5                           ; $2B02AE
        BCLR    D0,(A0)+                        ; $2B02B0
        DC.W    $00B1,$FA47,$0198,$FF4F; $2B02B2 ORI.L  #$FA470198,$4F(A1,A7.L)
        MOVE.W  D5,D5                           ; $2B02BA
        BTST    D1,(A4)+                        ; $2B02BC
        MOVE.W  -$05FB(A7),$031C(A7)            ; $2B02BE
        ORI.L  #$FAFD01B7,(A1)                  ; $2B02C4
        MOVE.W  A7,-$0544(A7)                   ; $2B02CA
        BTST    D1,$6F(PC,A7.L)                 ; $2B02CE
        DC.W    $FAFD               ; $2B02D2 MOVE.W  <EA:3D>,(A5)+
        BCLR    D0,-$4F(A7,D0.W)                ; $2B02D4
        MOVE.W  #$033B,(A5)                     ; $2B02D8
        ORI.L  #$F96100DC,(A1)                  ; $2B02DC
        DC.W    $003A,$F9C9,$00A1   ; $2B02E2 ORI.B  #$F9C9,$00A1(PC)
        DC.W    $00B3,$FB08,$0207,$004B; $2B02E8 ORI.L  #$FB080207,$4B(A3,D0.W)
        MOVE.W  (A7)+,(A5)                      ; $2B02F0
        ANDI.W  #$FFD3,D0                       ; $2B02F2
        MOVE.W  A4,$0114(A4)                    ; $2B02F6
        DC.W    $00BE,$FA8B,$0278   ; $2B02FA ORI.L  #$FA8B0278,<EA:3E>
        ORI.W  #$FB2C,(A7)                      ; $2B0300
        ORI.L  #$00B4FB12,(A3)+                 ; $2B0304
        DC.W    $010C               ; $2B030A BTST    D0,A4
        DC.W    $00B8,$F983,$00B3,$00A0; $2B030C ORI.L  #$F98300B3,$00A0.W
        MOVE.W  (A4)+,$42(A4,D0.W)              ; $2B0314
        ORI.L  #$FB1D00C4,(A3)+                 ; $2B0318
        BTST    D0,(A1)                         ; $2B031E
        MOVE.W  A5,$6B(A4,D0.W)                 ; $2B0320
        DC.W    $00F9               ; $2B0324 DC.W    $00F9
        MOVE.W  $0000(A0),(A5)                  ; $2B0326
        DC.W    $00B9,$FADD,$FFE5,$00B9,$FB61; $2B032A ORI.L  #$FADDFFE5,$00B9FB61
        DC.W    $00E3               ; $2B0334 DC.W    $00E3
        DC.W    $00B9,$FB0E,$010E,$00B9,$FAA1; $2B0336 ORI.L  #$FB0E010E,$00B9FAA1
        ANDI.W  #$0023,A4                       ; $2B0340
        MOVE.W  A2,-(A5)                        ; $2B0344
        DC.W    $01FD               ; $2B0346 BSET    D0,<EA:3D>
        DC.W    $FFB9,$F9A9,$00BD,$FF4A; $2B0348 MOVE.W  $F9A900BD,$4A(A7,A7.L)
        MOVE.W  D0,$010C(A4)                    ; $2B0350
        MOVE.W  -$61(A7,A7.L),$7D(A7,D0.W)      ; $2B0354
        MOVE.W  (A4)+,$3E(A7,A7.L)              ; $2B035A
        DC.W    $013E               ; $2B035E BTST    D0,<EA:3E>
        MOVE.W  -$06C1(A6),-(A7)                ; $2B0360
        ORI.L  #$FF74F96C,(A4)                  ; $2B0364
        DC.W    $00FC               ; $2B036A DC.W    $00FC
        MOVE.W  -(A3),-$0525(A7)                ; $2B036C
        ORI.W  #$FF1E,(A1)                      ; $2B0370
        MOVE.W  -$0016(A5),(A5)                 ; $2B0374
        MOVE.W  $3D(A0,A7.L),-(A7)              ; $2B0378
        DC.W    $00B8,$FF14,$FAAC,$000C; $2B037C ORI.L  #$FF14FAAC,$000C.W
        MOVE.W  A7,(A7)+                        ; $2B0384
        MOVE.W  -$0050(A5),#$FF18               ; $2B0386
        MOVE.W  A1,D5                           ; $2B038C
        MOVE.W  -$00E8(PC),-$04FA(A7)           ; $2B038E
        DC.W    $0001,$FF18         ; $2B0394 ORI.B  #$FF18,D1
        MOVE.W  (A3)+,(A5)+                     ; $2B0398
        ORI.W  #$FF18,(A2)                      ; $2B039A
        DC.W    $0010,$6E00         ; $2B039E ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2B03A2 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B03A6 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B03AA
        ORI.W  #$0050,D0                        ; $2B03AE
        SUBI.B  #$7000,(A0)                     ; $2B03B2
        ORI.W  #$0070,-(A0)                     ; $2B03B6
        SUBI.B  #$6F00,(A0)                     ; $2B03BA
        DC.W    $0000,$0030         ; $2B03BE ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B03C2 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B03C6 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B03CA ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B03CE
        DC.W    $00B0,$0210,$0400,$00D0; $2B03D4 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B03DC DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B03DE
        ORI.L  #$00900611,-(A0)                 ; $2B03E2
        BTST    D3,D1                           ; $2B03E8
        DC.W    $00B0,$0010,$6A00,$00E0; $2B03EA ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B03F2 DC.W    $00F0
        BTST    D0,D0                           ; $2B03F4
        BTST    D0,(A0)                         ; $2B03F6
        DC.W    $0210,$6C00         ; $2B03F8 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B03FC
        SUBI.B  #$6B00,(A0)                     ; $2B0400
        BTST    D0,D0                           ; $2B0404
        DC.W    $00F0               ; $2B0406 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B0408 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B040C DC.W    $00E0
        DC.W    $0010,$6300         ; $2B040E ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B0412
        BCHG    D0,(A0)                         ; $2B0414
        BCHG    D0,-(A0)                        ; $2B0416
        BCHG    D0,$10(A0,D0.W)                 ; $2B0418
        BCS.W  loc_2B05AE                       ; $2B041C
        BCLR    D0,D0                           ; $2B0420
        SUBI.B  #$6400,(A0)                     ; $2B0422
        BCHG    D0,-(A0)                        ; $2B0426
        BCHG    D0,(A0)                         ; $2B0428
        ADDI.B  #$6201,(A1)                     ; $2B042A
        BCHG    D0,$10(A0,D0.W)                 ; $2B042E
        BPL.W  loc_2B0614                       ; $2B0432
        BSET    D0,$00(A0,D0.W)                 ; $2B0436
        DC.W    $0210,$0210         ; $2B043A ANDI.B  #$0210,(A0)
        BGE.W  loc_2B0670                       ; $2B043E
        DC.W    $0220,$0410         ; $2B0442 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B0648                       ; $2B0446
        BSET    D0,$11(A0,D0.W)                 ; $2B044A
        BVS.S  loc_2B0451                       ; $2B044E
        DC.W    $0210,$0010         ; $2B0450 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B0696                       ; $2B0454
        ANDI.W  #$0260,(A0)                     ; $2B0458
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B045C
        ANDI.L  #$02800410,(A0)                 ; $2B0462
        BCC.W  loc_2B06CA                       ; $2B0468
        ANDI.W  #$0211,(A0)                     ; $2B046C
        BHI.S  loc_2B0473                       ; $2B0470
        ANDI.W  #$0010,D0                       ; $2B0472
        BNE.W  loc_2B0718                       ; $2B0476
        DC.W    $02B0,$02C0,$02D0,$0610; $2B047A ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B0764                       ; $2B0482
        DC.W    $02F0               ; $2B0486 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B0488
        BTST    D1,D0                           ; $2B048C
        BTST    D1,(A0)                         ; $2B048E
        SUBI.B  #$6700,(A0)                     ; $2B0490
        ANDI.L  #$02D00010,-(A0)                ; $2B0494
        BTST    D1,D0                           ; $2B049A
        BTST    D1,-(A0)                        ; $2B049C
        BTST    D1,$40(A0,D0.W)                 ; $2B049E
        BCHG    D1,(A0)                         ; $2B04A2
        DC.W    $0210,$0500         ; $2B04A4 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B04A8
        SUBI.B  #$0400,(A0)                     ; $2B04AC
        BCHG    D1,D0                           ; $2B04B0
        BTST    D1,$10(A0,D0.W)                 ; $2B04B2
        BCS.W  loc_2B0838                       ; $2B04B6
        BCLR    D1,(A0)                         ; $2B04BA
        BCLR    D1,-(A0)                        ; $2B04BC
        BCLR    D1,$10(A0,D0.W)                 ; $2B04BE
        BLS.W  loc_2B0894                       ; $2B04C2
        BSET    D1,D0                           ; $2B04C6
        SUBI.B  #$6400,(A0)                     ; $2B04C8
        BCLR    D1,-(A0)                        ; $2B04CC
        BCLR    D1,(A0)                         ; $2B04CE
        DC.W    $0010,$0300         ; $2B04D0 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B04D4
        SUBI.W  #$0450,D0                       ; $2B04D8
        DC.W    $0210,$0500         ; $2B04DC ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B04E0
        SUBI.B  #$0440,D0                       ; $2B04E6
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B04EA
        SUBI.L  #$049004A0,D0                   ; $2B04F0
        DC.W    $04B0,$0210,$6300,$04D0; $2B04F6 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B04FE DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B0500
        SUBI.L  #$04900000,-(A0)                ; $2B0504
        BVS.W  loc_2B06AC                       ; $2B050A
        BCLR    D0,-$40(A0,D0.W)                ; $2B050E
        BSET    D0,(A0)                         ; $2B0512
        DC.W    $0000,$6600         ; $2B0514 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B0518
        BSET    D1,$00(A0,D0.W)                 ; $2B051A
        SUBI.B  #$0000,(A0)                     ; $2B051E
        BNE.W  loc_2B0A04                       ; $2B0522
        DC.W    $04F0               ; $2B0526 DC.W    $04F0
        BTST    D2,D0                           ; $2B0528
        BTST    D2,(A0)                         ; $2B052A
        CMPI.B  #$0052,D0                       ; $2B052C
        ORI.W  #$F8F8,(A2)                      ; $2B0530
        ANDI.W  #$0091,-(A4)                    ; $2B0534
        MOVE.W  $6A(A6,D0.W),(A4)+              ; $2B0538
        MOVE.W  $60(A1,A7.L),$03CA(A7)          ; $2B053C
        MOVE.W  (A5)+,-$079E(A7)                ; $2B0542
        BSET    D1,D3                           ; $2B0546
        DC.W    $00B6,$F9B2,$02AE,$FF71; $2B0548 ORI.L  #$F9B202AE,$71(A6,A7.L)
        MOVE.W  D6,$041D(A4)                    ; $2B0550
        MOVE.W  (A5)+,-$064C(A7)                ; $2B0554
        ANDI.L  #$0091F948,-(A7)                ; $2B0558
        SUBI.B  #$00B6,(A6)                     ; $2B055E
        MOVE.W  (A2)+,-(A4)                     ; $2B0562
        SUBI.B  #$0067,-(A3)                    ; $2B0564
        MOVEA.W $03D7(PC),A4                    ; $2B0568
        DC.W    $000E,$F822         ; $2B056C ORI.B  #$F822,A6
        DC.W    $04CA               ; $2B0570 DC.W    $04CA
        DC.W    $0013,$F8D4         ; $2B0572 ORI.B  #$F8D4,(A3)
        DC.W    $04E6               ; $2B0576 DC.W    $04E6
        ORI.W  #$F919,$0427(A3)                 ; $2B0578
        MOVE.W  -$2D(A7,A7.L),-$17(A7,D0.W)     ; $2B057E
        MOVE.W  -$4B(PC,A7.L),-$1B(A7,D0.W)     ; $2B0584
        DC.W    $00C4               ; $2B058A DC.W    $00C4
        MOVE.W  $03B4(A3),(A4)+                 ; $2B058C
        BTST    D0,(A5)+                        ; $2B0590
        MOVE.W  -(A5),$027A(A4)                 ; $2B0592
        ORI.L  #$F93B0290,-(A7)                 ; $2B0596
        ORI.W  #$F91C,D3                        ; $2B059C
        SUBI.B  #$00DC,D5                       ; $2B05A0
        MOVE.W  -(A2),-$50(A4,D0.W)             ; $2B05A4
        ORI.W  #$F985,(A3)+                     ; $2B05A8
        DC.W    $02FC               ; $2B05AC DC.W    $02FC
loc_2B05AE:
        ORI.L  #$F99502C0,A2                    ; $2B05AE
        DC.W    $00C0               ; $2B05B4 DC.W    $00C0
        MOVEA.W $0218(PC),A4                    ; $2B05B6
        ORI.W  #$F82D,(A6)+                     ; $2B05BA
        DC.W    $0231,$0012,$F9B3   ; $2B05BE ANDI.B  #$0012,-$4D(A1,A7.L)
        DC.W    $02BB,$0073,$F85C,$01EF; $2B05C4 ANDI.L  #$0073F85C,-$11(PC,D0.W)
        DC.W    $FFFC,$F94C         ; $2B05CC MOVE.W  #$F94C,<EA:3F>
        BSET    D0,-(A7)                        ; $2B05D0
        DC.W    $0006,$F720         ; $2B05D2 ORI.B  #$F720,D6
        DC.W    $0227,$FFEA         ; $2B05D6 ANDI.B  #$FFEA,-(A7)
        MOVEA.W D2,A4                           ; $2B05DA
        BCHG    D0,(A6)+                        ; $2B05DC
        MOVE.W  -$7C(A3,A7.L),$2D(A7,D0.W)      ; $2B05DE
        DC.W    $FFBF,$F859         ; $2B05E4 MOVE.W  <EA:3F>,$59(A7,A7.L)
        DC.W    $02AB,$FF48,$F88D,$029B; $2B05E8 ANDI.L  #$FF48F88D,$029B(A3)
        MOVE.W  -(A7),(A7)+                     ; $2B05F0
        MOVE.W  D2,-(A4)                        ; $2B05F2
        BSET    D1,-$010F(A4)                   ; $2B05F4
        MOVE.W  (A0)+,(A4)+                     ; $2B05F8
        SUBI.B  #$FF52,(A2)+                    ; $2B05FA
        MOVE.W  D2,(A4)+                        ; $2B05FE
        ANDI.L  #$FF47F940,D7                   ; $2B0600
        BSET    D1,$51(A5,A7.L)                 ; $2B0606
        MOVE.W  -$58(A1,D0.W),-(A3)             ; $2B060A
        MOVE.W  $7F(A7,A7.W),-(A7)              ; $2B060E
        ANDI.L  #$FEEFF8D3,A4                   ; $2B0612
        DC.W    $02BE,$FEF1,$F8CD   ; $2B0618 ANDI.L  #$FEF1F8CD,<EA:3E>
        DC.W    $02E5               ; $2B061E DC.W    $02E5
        MOVE.W  -$08C3(PC),-(A7)                ; $2B0620
        ANDI.W  #$FF35,(A6)                     ; $2B0624
        MOVE.W  (A2)+,(A4)+                     ; $2B0628
        ANDI.L  #$FF37F93F,(A2)                 ; $2B062A
        DC.W    $00FC               ; $2B0630 DC.W    $00FC
        DC.W    $00B1,$F93F,$00FC,$FF4F; $2B0632 ORI.L  #$F93F00FC,$4F(A1,A7.L)
        MOVE.W  #$0281,(A4)+                    ; $2B063A
        MOVE.W  -$0704(A7),$0281(A7)            ; $2B063E
        ORI.L  #$F9F5011B,(A1)                  ; $2B0644
        MOVE.W  A7,-$064D(A7)                   ; $2B064A
        ANDI.L  #$FF6FF9F5,(A7)+                ; $2B064E
        BTST    D0,(A3)+                        ; $2B0654
        DC.W    $00B1,$F9B3,$029F,$0091; $2B0656 ORI.L  #$F9B3029F,-$6F(A1,D0.W)
        MOVE.W  -(A2),D4                        ; $2B065E
        BSET    D0,-$6D(A1,D0.W)                ; $2B0660
        MOVE.W  #$0172,D4                       ; $2B0664
        BTST    D0,D1                           ; $2B0668
        MOVE.W  $23(A5,D0.W),#$003D             ; $2B066A
loc_2B0670:
        MOVE.W  (A4)+,#$01A3                    ; $2B0670
        DC.W    $FFD0               ; $2B0674 MOVE.W  (A0),<EA:3F>
        MOVEA.W -(A1),A4                        ; $2B0676
        DC.W    $0217,$0111         ; $2B0678 ANDI.B  #$0111,(A7)
        MOVE.W  (A2)+,D5                        ; $2B067C
        DC.W    $01C9               ; $2B067E BSET    D0,A1
        ORI.W  #$F79B,A5                        ; $2B0680
        ORI.W  #$0168,(A4)+                     ; $2B0684
        MOVE.W  A5,D4                           ; $2B0688
        ORI.W  #$0171,A0                        ; $2B068A
        MOVEA.W (A1)+,A4                        ; $2B068E
        DC.W    $01BF               ; $2B0690 BCLR    D0,<EA:3F>
        DC.W    $00DC               ; $2B0692 DC.W    $00DC
        MOVE.W  -(A7),-$2F(PC,D0.W)             ; $2B0694
        DC.W    $00D2               ; $2B0698 DC.W    $00D2
        MOVE.W  D7,$76(PC,D0.W)                 ; $2B069A
        BSET    D0,D1                           ; $2B069E
        MOVE.W  (A3),D4                         ; $2B06A0
        BSET    D0,$012C(A4)                    ; $2B06A2
        MOVE.W  $002C(A3),(A3)+                 ; $2B06A6
        BCHG    D0,-$14(A3,A7.W)                ; $2B06AA
        DC.W    $FFF1,$0173         ; $2B06AE MOVE.W  $73(A1,D0.W),<EA:3F>
        MOVE.W  A3,D4                           ; $2B06B2
        DC.W    $FFF2,$0173         ; $2B06B4 MOVE.W  $73(A2,D0.W),<EA:3F>
        MOVE.W  A2,D4                           ; $2B06B8
        ORI.W  #$0173,A6                        ; $2B06BA
        MOVE.W  (A3),$0159(A4)                  ; $2B06BE
        DC.W    $0024,$F9C9         ; $2B06C2 ORI.B  #$F9C9,-(A4)
        BCLR    D0,(A5)                         ; $2B06C6
        MOVE.W  $44(PC,A7.L),-$33(A7,A7.L)      ; $2B06C8
        MOVE.W  D0,-$0631(A7)                   ; $2B06CE
        MOVE.W  (A1),-$56(A7,A7.L)              ; $2B06D2
        MOVE.W  -(A6),-(A4)                     ; $2B06D6
        BCHG    D0,-$62(A1,A7.L)                ; $2B06D8
        MOVE.W  -(A1),-$58(A4,A7.L)             ; $2B06DC
        MOVE.W  -(A3),-(A7)                     ; $2B06E0
        MOVE.W  -$00A6(A0),D5                   ; $2B06E2
        MOVE.W  -$0613(A4),-$0045(A7)           ; $2B06E6
        MOVE.W  (A3)+,-$04B5(A7)                ; $2B06EC
        ORI.L  #$FF08FB86,D1                    ; $2B06F0
        DC.W    $001F,$FF19         ; $2B06F6 ORI.B  #$FF19,(A7)+
        MOVE.W  A0,D5                           ; $2B06FA
        MOVE.W  -$00F4(A3),-$049A(A7)           ; $2B06FC
        DC.W    $0030,$FEB9,$FB08   ; $2B0702 ORI.B  #$FEB9,$08(A0,A7.L)
        MOVE.W  -$00FE(A2),-$04C1(A7)           ; $2B0708
        MOVE.W  (A5),-$00FE(A7)                 ; $2B070E
        MOVE.W  -(A3),$62(A5,D0.W)              ; $2B0712
        MOVE.W  D2,-(A7)                        ; $2B0716
loc_2B0718:
        MOVE.W  A4,$0082(A5)                    ; $2B0718
        MOVE.W  D2,-(A7)                        ; $2B071C
        DC.W    $0010,$6E00         ; $2B071E ORI.B  #$6E00,(A0)
        DC.W    $0000,$0010         ; $2B0722 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B0726 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B072A
        ORI.W  #$0050,D0                        ; $2B072E
        SUBI.B  #$7000,(A0)                     ; $2B0732
        ORI.W  #$0070,-(A0)                     ; $2B0736
        SUBI.B  #$6F00,(A0)                     ; $2B073A
        DC.W    $0000,$0030         ; $2B073E ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B0742 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B0746 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B074A ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B074E
        DC.W    $00B0,$0210,$0400,$00D0; $2B0754 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B075C DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B075E
        ORI.L  #$00900611,-(A0)                 ; $2B0762
        BTST    D3,D1                           ; $2B0768
        DC.W    $00B0,$0010,$6A00,$00E0; $2B076A ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B0772 DC.W    $00F0
        BTST    D0,D0                           ; $2B0774
        BTST    D0,(A0)                         ; $2B0776
        DC.W    $0210,$6C00         ; $2B0778 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B077C
        SUBI.B  #$6B00,(A0)                     ; $2B0780
        BTST    D0,D0                           ; $2B0784
        DC.W    $00F0               ; $2B0786 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B0788 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B078C DC.W    $00E0
        DC.W    $0010,$6300         ; $2B078E ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B0792
        BCHG    D0,(A0)                         ; $2B0794
        BCHG    D0,-(A0)                        ; $2B0796
        BCHG    D0,$10(A0,D0.W)                 ; $2B0798
        BCS.W  loc_2B092E                       ; $2B079C
        BCLR    D0,D0                           ; $2B07A0
        SUBI.B  #$6400,(A0)                     ; $2B07A2
        BCHG    D0,-(A0)                        ; $2B07A6
        BCHG    D0,(A0)                         ; $2B07A8
        ADDI.B  #$6201,(A1)                     ; $2B07AA
        BCHG    D0,$10(A0,D0.W)                 ; $2B07AE
        BPL.W  loc_2B0994                       ; $2B07B2
        BSET    D0,$00(A0,D0.W)                 ; $2B07B6
        DC.W    $0210,$0210         ; $2B07BA ANDI.B  #$0210,(A0)
        BGE.W  loc_2B09F0                       ; $2B07BE
        DC.W    $0220,$0410         ; $2B07C2 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B09C8                       ; $2B07C6
        BSET    D0,$11(A0,D0.W)                 ; $2B07CA
        BVS.S  loc_2B07D1                       ; $2B07CE
        DC.W    $0210,$0010         ; $2B07D0 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B0A16                       ; $2B07D4
        ANDI.W  #$0260,(A0)                     ; $2B07D8
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B07DC
        ANDI.L  #$02800410,(A0)                 ; $2B07E2
        BCC.W  loc_2B0A4A                       ; $2B07E8
        ANDI.W  #$0211,(A0)                     ; $2B07EC
        BHI.S  loc_2B07F3                       ; $2B07F0
        ANDI.W  #$0010,D0                       ; $2B07F2
        BNE.W  loc_2B0A98                       ; $2B07F6
        DC.W    $02B0,$02C0,$02D0,$0610; $2B07FA ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B0AE4                       ; $2B0802
        DC.W    $02F0               ; $2B0806 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B0808
        BTST    D1,D0                           ; $2B080C
        BTST    D1,(A0)                         ; $2B080E
        SUBI.B  #$6700,(A0)                     ; $2B0810
        ANDI.L  #$02D00010,-(A0)                ; $2B0814
        BTST    D1,D0                           ; $2B081A
        BTST    D1,-(A0)                        ; $2B081C
        BTST    D1,$40(A0,D0.W)                 ; $2B081E
        BCHG    D1,(A0)                         ; $2B0822
        DC.W    $0210,$0500         ; $2B0824 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B0828
        SUBI.B  #$0400,(A0)                     ; $2B082C
        BCHG    D1,D0                           ; $2B0830
        BTST    D1,$10(A0,D0.W)                 ; $2B0832
        BCS.W  loc_2B0BB8                       ; $2B0836
        BCLR    D1,(A0)                         ; $2B083A
        BCLR    D1,-(A0)                        ; $2B083C
        BCLR    D1,$10(A0,D0.W)                 ; $2B083E
        BLS.W  loc_2B0C14                       ; $2B0842
        BSET    D1,D0                           ; $2B0846
        SUBI.B  #$6400,(A0)                     ; $2B0848
        BCLR    D1,-(A0)                        ; $2B084C
        BCLR    D1,(A0)                         ; $2B084E
        DC.W    $0010,$0300         ; $2B0850 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B0854
        SUBI.W  #$0450,D0                       ; $2B0858
        DC.W    $0210,$0500         ; $2B085C ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B0860
        SUBI.B  #$0440,D0                       ; $2B0866
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B086A
        SUBI.L  #$049004A0,D0                   ; $2B0870
        DC.W    $04B0,$0210,$6300,$04D0; $2B0876 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B087E DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B0880
        SUBI.L  #$04900000,-(A0)                ; $2B0884
        BVS.W  loc_2B0A2C                       ; $2B088A
        BCLR    D0,-$40(A0,D0.W)                ; $2B088E
        BSET    D0,(A0)                         ; $2B0892
loc_2B0894:
        DC.W    $0000,$6600         ; $2B0894 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B0898
        BSET    D1,$00(A0,D0.W)                 ; $2B089A
        SUBI.B  #$0000,(A0)                     ; $2B089E
        BNE.W  loc_2B0D84                       ; $2B08A2
        DC.W    $04F0               ; $2B08A6 DC.W    $04F0
        BTST    D2,D0                           ; $2B08A8
        BTST    D2,(A0)                         ; $2B08AA
        CMPI.B  #$0052,D0                       ; $2B08AC
        ORI.W  #$F8F6,(A2)                      ; $2B08B0
        DC.W    $023C,$0081,$F8F5   ; $2B08B4 ANDI.B  #$0081,#$F8F5
        DC.W    $023E,$FF62         ; $2B08BA ANDI.B  #$FF62,<EA:3E>
        MOVEA.W D2,A4                           ; $2B08BE
        BCLR    D1,(A1)                         ; $2B08C0
        MOVE.W  D7,-$07BD(A7)                   ; $2B08C2
        DC.W    $038F               ; $2B08C6 BCLR    D1,A7
        ORI.L  #$F9AA0291,-(A0)                 ; $2B08C8
        MOVE.W  -(A2),-$06DF(A7)                ; $2B08CE
        BSET    D1,$47(A6,A7.L)                 ; $2B08D2
        MOVE.W  $028F(A2),-$7F(A4,D0.W)         ; $2B08D6
        MOVE.W  -(A2),-(A4)                     ; $2B08DC
        BSET    D1,-$60(A4,D0.W)                ; $2B08DE
        MOVE.W  -$04(A3,D0.W),(A4)+             ; $2B08E2
        ORI.W  #$F85B,(A0)                      ; $2B08E6
        BCLR    D1,-(A1)                        ; $2B08EA
        DC.W    $FFF8,$F7EF         ; $2B08EC MOVE.W  $F7EF.W,<EA:3F>
        SUBI.L  #$FFFAF89E,A5                   ; $2B08F0
        DC.W    $04B9,$0051,$F8F3,$03FD,$FFA0; $2B08F6 SUBI.L  #$0051F8F3,$03FDFFA0
        MOVE.W  (A6)+,(A4)                      ; $2B0900
        DC.W    $04BA,$FFA1,$F896,$03BA; $2B0902 SUBI.L  #$FFA1F896,$03BA(PC)
        DC.W    $00AB,$F8CB,$038D,$0107; $2B090A ORI.L  #$F8CB038D,$0107(A3)
        MOVE.W  (A6)+,$025B(A4)                 ; $2B0912
        ORI.L  #$F936026B,(A3)+                 ; $2B0916
        DC.W    $0035,$F8FA,$03E0   ; $2B091C ORI.B  #$F8FA,-$20(A5,D0.W)
        DC.W    $00C5               ; $2B0922 DC.W    $00C5
        MOVE.W  (A2)+,-$6E(A4,D0.W)             ; $2B0924
        ORI.W  #$F989,A7                        ; $2B0928
        DC.W    $02E2               ; $2B092C DC.W    $02E2
loc_2B092E:
        ORI.L  #$F99402A4,D0                    ; $2B092E
        DC.W    $00B5,$F866,$021D,$005D; $2B0934 ORI.L  #$F866021D,$5D(A5,D0.W)
        MOVE.W  (A0)+,D4                        ; $2B093C
        DC.W    $023E,$0014         ; $2B093E ANDI.B  #$0014,<EA:3E>
        MOVE.W  $029C(A7),$67(A4,D0.W)          ; $2B0942
        DC.W    $F83F               ; $2B0948 MOVE.W  <EA:3F>,D4
        BSET    D0,$FFFC.W                      ; $2B094A
        MOVE.W  $01D6(A6),-(A4)                 ; $2B094E
        DC.W    $FFFE               ; $2B0952 MOVE.W  <EA:3E>,<EA:3F>
        MOVE.W  A3,-(A3)                        ; $2B0954
        ANDI.W  #$FFF4,(A3)                     ; $2B0956
        MOVE.W  (A3),D4                         ; $2B095A
        BCHG    D0,-$004C(A4)                   ; $2B095C
        MOVE.W  A4,$0116(A4)                    ; $2B0960
        MOVE.W  $59(A5,A7.L),$6F(A7,D0.W)       ; $2B0964
        MOVE.W  #$F88E,-(A7)                    ; $2B096A
        ANDI.W  #$FEDB,-(A3)                    ; $2B096E
        MOVE.W  -(A1),(A4)+                     ; $2B0972
        DC.W    $03BD               ; $2B0974 BCLR    D1,<EA:3D>
        MOVE.W  (A4)+,(A7)+                     ; $2B0976
        MOVE.W  -$17(A3,D0.W),(A4)              ; $2B0978
        MOVE.W  #$F8C4,-(A7)                    ; $2B097C
        ANDI.W  #$FF3B,(A6)                     ; $2B0980
        MOVE.W  (A6)+,-(A4)                     ; $2B0984
        DC.W    $03CF               ; $2B0986 BSET    D1,A7
        MOVE.W  #$F73E,-(A7)                    ; $2B0988
        DC.W    $02AD,$FF2D,$F788,$0284; $2B098C ANDI.L  #$FF2DF788,$0284(A5)
loc_2B0994:
        MOVE.W  -(A5),(A7)+                     ; $2B0994
        MOVE.W  (A7)+,(A4)+                     ; $2B0996
        ANDI.L  #$FEE4F8DF,D6                   ; $2B0998
        DC.W    $02B0,$FF2A,$F73E,$0259; $2B099E ANDI.L  #$FF2AF73E,$59(A0,D0.W)
        MOVE.W  -$0720(A5),-(A7)                ; $2B09A6
        ANDI.W  #$FF2A,(A4)+                    ; $2B09AA
        MOVE.W  #$00E0,-(A4)                    ; $2B09AE
        ORI.L  #$F93C00E0,-(A1)                 ; $2B09B2
        MOVE.W  D1,-$0708(A7)                   ; $2B09B8
        ANDI.W  #$FF61,-(A4)                    ; $2B09BC
        MOVE.W  $0264.W,(A4)+                   ; $2B09C0
        ORI.L  #$F9F20100,D2                    ; $2B09C4
        MOVE.W  D1,-$0651(A7)                   ; $2B09CA
        ANDI.L  #$FF61F9F2,D4                   ; $2B09CE
        BTST    D0,D0                           ; $2B09D4
        ORI.L  #$F9AF0284,-(A1)                 ; $2B09D6
        ORI.L  #$F82701E8,D2                    ; $2B09DC
        ORI.L  #$F83F016A,A3                    ; $2B09E2
        DC.W    $00FA               ; $2B09E8 DC.W    $00FA
        MOVE.W  $05(A0,D0.W),#$002E             ; $2B09EA
loc_2B09F0:
        MOVE.W  (A1)+,#$0184                    ; $2B09F0
        DC.W    $FFBF,$F86B         ; $2B09F4 MOVE.W  <EA:3F>,$6B(A7,A7.L)
        DC.W    $020E,$0106         ; $2B09F8 ANDI.B  #$0106,A6
        MOVE.W  (A4)+,D5                        ; $2B09FC
        BCLR    D0,$003A(A0)                    ; $2B09FE
        MOVE.W  (A4)+,$59(A3,D0.W)              ; $2B0A02
        BCHG    D0,-$07F3(A2)                   ; $2B0A06
        ORI.W  #$016F,D2                        ; $2B0A0A
        MOVEA.W (A5)+,A4                        ; $2B0A0E
        BCLR    D0,-$2D(A5,D0.W)                ; $2B0A10
        MOVE.W  $01CB(A4),-$33(PC,D0.W)         ; $2B0A14
        MOVE.W  A3,$73(PC,D0.W)                 ; $2B0A1A
        BSET    D0,D1                           ; $2B0A1E
        MOVE.W  (A3)+,D4                        ; $2B0A20
        BSET    D0,-(A6)                        ; $2B0A22
        BTST    D0,-(A4)                        ; $2B0A24
        MOVE.W  $0026(A3),(A3)+                 ; $2B0A26
        BCHG    D0,-$14(A1,A7.W)                ; $2B0A2A
        DC.W    $FFEC,$0171         ; $2B0A2E MOVE.W  $0171(A4),<EA:3F>
        MOVE.W  A3,D4                           ; $2B0A32
        DC.W    $FFED,$0171         ; $2B0A34 MOVE.W  $0171(A5),<EA:3F>
        MOVE.W  A2,D4                           ; $2B0A38
        ORI.W  #$0171,A1                        ; $2B0A3A
        MOVE.W  A5,$0114(A4)                    ; $2B0A3E
        DC.W    $0010,$F9AC         ; $2B0A42 ORI.B  #$F9AC,(A0)
        BCHG    D0,$FFAEFAC5                    ; $2B0A46
        DC.W    $FFFD               ; $2B0A4C MOVE.W  <EA:3D>,<EA:3F>
        MOVE.W  $67(A3,A7.L),-(A7)              ; $2B0A4E
        MOVE.W  (A0)+,-$6B(A7,A7.L)             ; $2B0A52
        MOVE.W  -(A0),-(A4)                     ; $2B0A56
        BTST    D0,(A7)+                        ; $2B0A58
        MOVE.W  D7,$3B(A7,A7.L)                 ; $2B0A5A
        MOVE.W  -(A3),$0C(A7,A7.L)              ; $2B0A5E
        MOVE.W  -$7E(A1,A7.L),(A5)              ; $2B0A62
        MOVE.W  -(A5),-$0590(A7)                ; $2B0A66
        DC.W    $FFDE               ; $2B0A6A MOVE.W  (A6)+,<EA:3F>
        MOVE.W  A3,-$043D(A7)                   ; $2B0A6C
        DC.W    $00B1,$FEEF,$FC04,$0054; $2B0A70 ORI.L  #$FEEFFC04,$54(A1,D0.W)
        MOVE.W  A1,-(A7)                        ; $2B0A78
        MOVE.W  (A1),(A5)                       ; $2B0A7A
        MOVE.W  A2,$04(A7,A7.L)                 ; $2B0A7C
        DC.W    $FBE4               ; $2B0A80 MOVE.W  -(A4),<EA:3D>
        ORI.W  #$FEA7,(A5)+                     ; $2B0A82
        DC.W    $FBFB,$FF96         ; $2B0A86 MOVE.W  -$6A(PC,A7.L),<EA:3D>
        MOVE.W  -$03CA(A2),(A7)+                ; $2B0A8A
        MOVE.W  (A3)+,-$16(A7,A7.L)             ; $2B0A8E
        MOVE.W  (A5)+,D6                        ; $2B0A92
        DC.W    $00B8,$FEEA,$FBC1,$00B0; $2B0A94 ORI.L  #$FEEAFBC1,$00B0.W
        MOVE.W  $0010(A2),(A7)+                 ; $2B0A9C
        BGT.W  loc_2B0AA2                       ; $2B0AA0
        DC.W    $0010,$0020         ; $2B0AA4 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2B0AA8 ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2B0AAE
        SUBI.B  #$7000,(A0)                     ; $2B0AB2
        ORI.W  #$0070,-(A0)                     ; $2B0AB6
        SUBI.B  #$6F00,(A0)                     ; $2B0ABA
        DC.W    $0000,$0030         ; $2B0ABE ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B0AC2 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B0AC6 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B0ACA ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B0ACE
        DC.W    $00B0,$0210,$0400,$00D0; $2B0AD4 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B0ADC DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B0ADE
        ORI.L  #$00900611,-(A0)                 ; $2B0AE2
        BTST    D3,D1                           ; $2B0AE8
        DC.W    $00B0,$0010,$6A00,$00E0; $2B0AEA ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B0AF2 DC.W    $00F0
        BTST    D0,D0                           ; $2B0AF4
        BTST    D0,(A0)                         ; $2B0AF6
        DC.W    $0210,$6C00         ; $2B0AF8 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B0AFC
        SUBI.B  #$6B00,(A0)                     ; $2B0B00
        BTST    D0,D0                           ; $2B0B04
        DC.W    $00F0               ; $2B0B06 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B0B08 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B0B0C DC.W    $00E0
        DC.W    $0010,$6300         ; $2B0B0E ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B0B12
        BCHG    D0,(A0)                         ; $2B0B14
        BCHG    D0,-(A0)                        ; $2B0B16
        BCHG    D0,$10(A0,D0.W)                 ; $2B0B18
        BCS.W  loc_2B0CAE                       ; $2B0B1C
        BCLR    D0,D0                           ; $2B0B20
        SUBI.B  #$6400,(A0)                     ; $2B0B22
        BCHG    D0,-(A0)                        ; $2B0B26
        BCHG    D0,(A0)                         ; $2B0B28
        ADDI.B  #$6201,(A1)                     ; $2B0B2A
        BCHG    D0,$10(A0,D0.W)                 ; $2B0B2E
        BPL.W  loc_2B0D14                       ; $2B0B32
        BSET    D0,$00(A0,D0.W)                 ; $2B0B36
        DC.W    $0210,$0210         ; $2B0B3A ANDI.B  #$0210,(A0)
        BGE.W  loc_2B0D70                       ; $2B0B3E
        DC.W    $0220,$0410         ; $2B0B42 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B0D48                       ; $2B0B46
        BSET    D0,$11(A0,D0.W)                 ; $2B0B4A
        BVS.S  loc_2B0B51                       ; $2B0B4E
        DC.W    $0210,$0010         ; $2B0B50 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B0D96                       ; $2B0B54
        ANDI.W  #$0260,(A0)                     ; $2B0B58
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B0B5C
        ANDI.L  #$02800410,(A0)                 ; $2B0B62
        BCC.W  loc_2B0DCA                       ; $2B0B68
        ANDI.W  #$0211,(A0)                     ; $2B0B6C
        BHI.S  loc_2B0B73                       ; $2B0B70
        ANDI.W  #$0010,D0                       ; $2B0B72
        BNE.W  loc_2B0E18                       ; $2B0B76
        DC.W    $02B0,$02C0,$02D0,$0610; $2B0B7A ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B0E64                       ; $2B0B82
        DC.W    $02F0               ; $2B0B86 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B0B88
        BTST    D1,D0                           ; $2B0B8C
        BTST    D1,(A0)                         ; $2B0B8E
        SUBI.B  #$6700,(A0)                     ; $2B0B90
        ANDI.L  #$02D00010,-(A0)                ; $2B0B94
        BTST    D1,D0                           ; $2B0B9A
        BTST    D1,-(A0)                        ; $2B0B9C
        BTST    D1,$40(A0,D0.W)                 ; $2B0B9E
        BCHG    D1,(A0)                         ; $2B0BA2
        DC.W    $0210,$0500         ; $2B0BA4 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B0BA8
        SUBI.B  #$0400,(A0)                     ; $2B0BAC
        BCHG    D1,D0                           ; $2B0BB0
        BTST    D1,$10(A0,D0.W)                 ; $2B0BB2
        BCS.W  loc_2B0F38                       ; $2B0BB6
        BCLR    D1,(A0)                         ; $2B0BBA
        BCLR    D1,-(A0)                        ; $2B0BBC
        BCLR    D1,$10(A0,D0.W)                 ; $2B0BBE
        BLS.W  loc_2B0F94                       ; $2B0BC2
        BSET    D1,D0                           ; $2B0BC6
        SUBI.B  #$6400,(A0)                     ; $2B0BC8
        BCLR    D1,-(A0)                        ; $2B0BCC
        BCLR    D1,(A0)                         ; $2B0BCE
        DC.W    $0010,$0300         ; $2B0BD0 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B0BD4
        SUBI.W  #$0450,D0                       ; $2B0BD8
        DC.W    $0210,$0500         ; $2B0BDC ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B0BE0
        SUBI.B  #$0440,D0                       ; $2B0BE6
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B0BEA
        SUBI.L  #$049004A0,D0                   ; $2B0BF0
        DC.W    $04B0,$0210,$6300,$04D0; $2B0BF6 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B0BFE DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B0C00
        SUBI.L  #$04900000,-(A0)                ; $2B0C04
        BVS.W  loc_2B0DAC                       ; $2B0C0A
        BCLR    D0,-$40(A0,D0.W)                ; $2B0C0E
        BSET    D0,(A0)                         ; $2B0C12
loc_2B0C14:
        DC.W    $0000,$6600         ; $2B0C14 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B0C18
        BSET    D1,$00(A0,D0.W)                 ; $2B0C1A
        SUBI.B  #$0000,(A0)                     ; $2B0C1E
        BNE.W  loc_2B1104                       ; $2B0C22
        DC.W    $04F0               ; $2B0C26 DC.W    $04F0
        BTST    D2,D0                           ; $2B0C28
        BTST    D2,(A0)                         ; $2B0C2A
        CMPI.B  #$0052,D0                       ; $2B0C2C
        ORI.W  #$F8F4,(A2)                      ; $2B0C30
        DC.W    $020D,$006E         ; $2B0C34 ANDI.B  #$006E,A5
        MOVE.W  D4,-(A4)                        ; $2B0C38
        BSET    D0,$50(A7,A7.L)                 ; $2B0C3A
        MOVE.W  (A6),D4                         ; $2B0C3E
        BTST    D1,(A7)+                        ; $2B0C40
        MOVE.W  (A2),-(A7)                      ; $2B0C42
        MOVE.W  D4,D4                           ; $2B0C44
        BTST    D1,$0069.W                      ; $2B0C46
        MOVE.W  -(A5),$6B(A4,D0.W)              ; $2B0C4A
        MOVE.W  (A0),-$0722(A7)                 ; $2B0C4E
        BCLR    D1,-$00EE(A5)                   ; $2B0C52
        MOVE.W  (A7),-$7F(A4,D0.W)              ; $2B0C56
        ORI.W  #$F8CB,$03C6(A6)                 ; $2B0C5A
        ORI.W  #$F8A1,$03BF(A1)                 ; $2B0C60
        DC.W    $0018,$F821         ; $2B0C66 ORI.B  #$F821,(A0)+
        BCHG    D1,D1                           ; $2B0C6A
        DC.W    $FFC2               ; $2B0C6C MOVE.W  D2,<EA:3F>
        MOVE.W  A3,$14(A3,D0.W)                 ; $2B0C6E
        MOVE.W  -$07D7(A4),$67(A7,D0.W)         ; $2B0C72
        DC.W    $0006,$F8A9         ; $2B0C78 ORI.B  #$F8A9,D6
        BCLR    D1,$68(A3,A7.L)                 ; $2B0C7C
        MOVE.W  $5A(A3,D0.W),D4                 ; $2B0C80
        MOVE.W  (A5),-$07B0(A7)                 ; $2B0C84
        BCHG    D1,$6D(A4,D0.W)                 ; $2B0C88
        MOVE.W  D4,(A4)                         ; $2B0C8C
        BCHG    D1,(A2)+                        ; $2B0C8E
        DC.W    $00D1               ; $2B0C90 DC.W    $00D1
        MOVE.W  (A0),$023E(A4)                  ; $2B0C92
        ORI.L  #$F9310240,A7                    ; $2B0C96
        DC.W    $0024,$F8AA         ; $2B0C9C ORI.B  #$F8AA,-(A4)
        BCLR    D1,$008D(A6)                    ; $2B0CA0
        MOVE.W  A2,$79(A4,D0.W)                 ; $2B0CA4
        ORI.W  #$F984,D4                        ; $2B0CA8
        DC.W    $02CD               ; $2B0CAC DC.W    $02CD
loc_2B0CAE:
        ORI.W  #$F98A,-$6F(A1,D0.W)             ; $2B0CAE
        DC.W    $00A9,$F84F,$0222,$0058; $2B0CB4 ORI.L  #$F84F0222,$0058(A1)
        MOVE.W  D6,D4                           ; $2B0CBC
        ANDI.W  #$000E,D6                       ; $2B0CBE
        MOVE.W  -(A3),-$7D(A4,D0.W)             ; $2B0CC2
        ORI.W  #$F825,(A5)+                     ; $2B0CC6
        BSET    D0,#$FFF9                       ; $2B0CCA
        MOVE.W  (A0),-(A4)                      ; $2B0CCE
        BSET    D0,D4                           ; $2B0CD0
        DC.W    $FFFE               ; $2B0CD2 MOVE.W  <EA:3E>,<EA:3F>
        MOVE.W  $73(PC,D0.W),(A3)+              ; $2B0CD4
        DC.W    $FFEE,$F7EC         ; $2B0CD8 MOVE.W  -$0814(A6),<EA:3F>
        BCHG    D0,-$47(A1,A7.L)                ; $2B0CDC
        MOVE.W  (A5)+,-(A4)                     ; $2B0CE0
        BTST    D0,D0                           ; $2B0CE2
        DC.W    $FFBD,$F847         ; $2B0CE4 MOVE.W  <EA:3D>,$47(A7,A7.L)
        DC.W    $021A,$FF35         ; $2B0CE8 ANDI.B  #$FF35,(A2)+
        DC.W    $F87D               ; $2B0CEC MOVEA.W <EA:3D>,A4
        DC.W    $0207,$FED5         ; $2B0CEE ANDI.B  #$FED5,D7
        MOVE.W  $64(A2,D0.W),(A4)               ; $2B0CF2
        MOVE.W  -$0780(A1),(A7)                 ; $2B0CF6
        BCLR    D1,(A0)+                        ; $2B0CFA
        MOVE.W  D5,-(A7)                        ; $2B0CFC
        MOVE.W  $0B(A5,D0.W),(A4)               ; $2B0CFE
        MOVE.W  -$12(A6,A7.L),-(A7)             ; $2B0D02
        DC.W    $0388               ; $2B0D06 BCLR    D1,A0
        MOVE.W  D6,-(A7)                        ; $2B0D08
        MOVE.W  A0,$02A5(A3)                    ; $2B0D0A
        MOVE.W  (A6),-(A7)                      ; $2B0D0E
        MOVE.W  A1,$66(A3,D0.W)                 ; $2B0D10
loc_2B0D14:
        MOVE.W  (A4),(A7)+                      ; $2B0D14
        MOVE.W  (A3)+,(A4)+                     ; $2B0D16
        DC.W    $0228,$FEDA,$F8E3   ; $2B0D18 ANDI.B  #$FEDA,-$071D(A0)
        ANDI.W  #$FF1B,(A2)+                    ; $2B0D1E
        MOVE.W  $0253FF20,-(A3)                 ; $2B0D22
        MOVE.W  (A3),(A4)+                      ; $2B0D28
        DC.W    $0208,$FF25         ; $2B0D2A ANDI.B  #$FF25,A0
        MOVE.W  $00C4.W,-(A4)                   ; $2B0D2E
        ORI.L  #$F93800C4,(A2)                  ; $2B0D32
        MOVE.W  -$0D(A2,A7.L),-(A7)             ; $2B0D38
        ANDI.W  #$FF51,A0                       ; $2B0D3C
        MOVE.W  $48(A3,D0.W),(A4)+              ; $2B0D40
        ORI.W  #$F9EE,-$1C(A2,D0.W)             ; $2B0D44
        MOVE.W  -$57(A2,A7.L),-(A7)             ; $2B0D4A
        ANDI.W  #$FF51,-$0612(A0)               ; $2B0D4E
        DC.W    $00E4               ; $2B0D54 DC.W    $00E4
        ORI.L  #$F9A90268,(A2)                  ; $2B0D56
        ORI.W  #$F830,-$1F(A2,D0.W)             ; $2B0D5C
        ORI.L  #$F8450164,D5                    ; $2B0D62
        DC.W    $00F5               ; $2B0D68 DC.W    $00F5
        MOVE.W  $00E6(A2),#$001E                ; $2B0D6A
loc_2B0D70:
        MOVE.W  (A4),#$0163                     ; $2B0D70
        MOVE.W  -$0788(A6),$06(A7,D0.W)         ; $2B0D74
        DC.W    $00FC               ; $2B0D7A DC.W    $00FC
        MOVE.W  (A5)+,D5                        ; $2B0D7C
        DC.W    $0188               ; $2B0D7E BCLR    D0,A0
        DC.W    $0024,$F79C         ; $2B0D80 ORI.B  #$F79C,-(A4)
loc_2B0D84:
        ORI.W  #$016F,(A2)+                     ; $2B0D84
        MOVE.W  A5,D4                           ; $2B0D88
        ORI.W  #$0171,D0                        ; $2B0D8A
        MOVEA.W -(A4),A4                        ; $2B0D8E
        BCLR    D0,$00CC(A6)                    ; $2B0D90
        MOVE.W  -$39(A4,D0.W),-$36(PC,D0.W)     ; $2B0D94
        MOVE.W  A7,$74(PC,D0.W)                 ; $2B0D9A
        BSET    D0,D4                           ; $2B0D9E
        MOVE.W  -(A7),D4                        ; $2B0DA0
        BSET    D0,-(A1)                        ; $2B0DA2
        BTST    D0,(A7)+                        ; $2B0DA4
        MOVE.W  $0024(A3),(A3)+                 ; $2B0DA6
        BCHG    D0,-$15(A3,A7.W)                ; $2B0DAA
        DC.W    $FFEA,$0173         ; $2B0DAE MOVE.W  $0173(A2),<EA:3F>
        MOVE.W  A2,D4                           ; $2B0DB2
        DC.W    $FFEA,$0173         ; $2B0DB4 MOVE.W  $0173(A2),<EA:3F>
        MOVE.W  A2,D4                           ; $2B0DB8
        ORI.W  #$0173,D6                        ; $2B0DBA
        MOVE.W  A1,$00F4(A4)                    ; $2B0DBE
        DC.W    $FFFF               ; $2B0DC2 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  -(A4),$5D(A4,D0.W)              ; $2B0DC4
        MOVE.W  (A6)+,-$31(A7,A7.L)             ; $2B0DC8
        DC.W    $FFEC,$FF2D         ; $2B0DCC MOVE.W  -$00D3(A4),<EA:3F>
        MOVEA.W -$7C(A4,A7.L),A5                ; $2B0DD0
        MOVE.W  A6,$1E(A7,A7.L)                 ; $2B0DD4
        DC.W    $00FD               ; $2B0DD8 DC.W    $00FD
        MOVE.W  $49(A5,A7.L),-$0074(A7)         ; $2B0DDA
        MOVE.W  D4,-(A7)                        ; $2B0DE0
        MOVE.W  D2,(A5)+                        ; $2B0DE2
        MOVE.W  $5F(A0,A7.L),-$0585(A7)         ; $2B0DE4
        DC.W    $FFC7               ; $2B0DEA MOVE.W  D7,<EA:3F>
        MOVE.W  D3,-$043E(A7)                   ; $2B0DEC
        DC.W    $00B1,$FEEF,$FC08,$0059; $2B0DF0 ORI.L  #$FEEFFC08,$59(A1,D0.W)
        MOVE.W  A2,-(A7)                        ; $2B0DF8
        MOVE.W  -(A4),(A5)                      ; $2B0DFA
        MOVE.W  -$04(A5,A7.L),-$0416(A7)        ; $2B0DFC
        ORI.W  #$FEA7,(A7)+                     ; $2B0E02
        MOVEA.W -$003A(A4),A6                   ; $2B0E06
        MOVE.W  -$0361(A2),(A7)+                ; $2B0E0A
        DC.W    $FFE4               ; $2B0E0E MOVE.W  -(A4),<EA:3F>
        MOVE.W  -$03F1(A2),(A7)+                ; $2B0E10
        DC.W    $00DB               ; $2B0E14 DC.W    $00DB
        MOVE.W  -$0442(A2),(A7)+                ; $2B0E16
        DC.W    $00AC,$FEEA,$0010,$6E00; $2B0E1A ORI.L  #$FEEA0010,$6E00(A4)
        DC.W    $0000,$0010         ; $2B0E22 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B0E26 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B0E2A
        ORI.W  #$0050,D0                        ; $2B0E2E
        SUBI.B  #$7000,(A0)                     ; $2B0E32
        ORI.W  #$0070,-(A0)                     ; $2B0E36
        SUBI.B  #$6F00,(A0)                     ; $2B0E3A
        DC.W    $0000,$0030         ; $2B0E3E ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B0E42 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B0E46 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B0E4A ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B0E4E
        DC.W    $00B0,$0210,$0400,$00D0; $2B0E54 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B0E5C DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B0E5E
        ORI.L  #$00900611,-(A0)                 ; $2B0E62
        BTST    D3,D1                           ; $2B0E68
        DC.W    $00B0,$0010,$6A00,$00E0; $2B0E6A ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B0E72 DC.W    $00F0
        BTST    D0,D0                           ; $2B0E74
        BTST    D0,(A0)                         ; $2B0E76
        DC.W    $0210,$6C00         ; $2B0E78 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B0E7C
        SUBI.B  #$6B00,(A0)                     ; $2B0E80
        BTST    D0,D0                           ; $2B0E84
        DC.W    $00F0               ; $2B0E86 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B0E88 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B0E8C DC.W    $00E0
        DC.W    $0010,$6300         ; $2B0E8E ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B0E92
        BCHG    D0,(A0)                         ; $2B0E94
        BCHG    D0,-(A0)                        ; $2B0E96
        BCHG    D0,$10(A0,D0.W)                 ; $2B0E98
        BCS.W  loc_2B102E                       ; $2B0E9C
        BCLR    D0,D0                           ; $2B0EA0
        SUBI.B  #$6400,(A0)                     ; $2B0EA2
        BCHG    D0,-(A0)                        ; $2B0EA6
        BCHG    D0,(A0)                         ; $2B0EA8
        ADDI.B  #$6201,(A1)                     ; $2B0EAA
        BCHG    D0,$10(A0,D0.W)                 ; $2B0EAE
        BPL.W  loc_2B1094                       ; $2B0EB2
        BSET    D0,$00(A0,D0.W)                 ; $2B0EB6
        DC.W    $0210,$0210         ; $2B0EBA ANDI.B  #$0210,(A0)
        BGE.W  loc_2B10F0                       ; $2B0EBE
        DC.W    $0220,$0410         ; $2B0EC2 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B10C8                       ; $2B0EC6
        BSET    D0,$11(A0,D0.W)                 ; $2B0ECA
        BVS.S  loc_2B0ED1                       ; $2B0ECE
        DC.W    $0210,$0010         ; $2B0ED0 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B1116                       ; $2B0ED4
        ANDI.W  #$0260,(A0)                     ; $2B0ED8
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B0EDC
        ANDI.L  #$02800410,(A0)                 ; $2B0EE2
        BCC.W  loc_2B114A                       ; $2B0EE8
        ANDI.W  #$0211,(A0)                     ; $2B0EEC
        BHI.S  loc_2B0EF3                       ; $2B0EF0
        ANDI.W  #$0010,D0                       ; $2B0EF2
        BNE.W  loc_2B1198                       ; $2B0EF6
        DC.W    $02B0,$02C0,$02D0,$0610; $2B0EFA ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B11E4                       ; $2B0F02
        DC.W    $02F0               ; $2B0F06 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B0F08
        BTST    D1,D0                           ; $2B0F0C
        BTST    D1,(A0)                         ; $2B0F0E
        SUBI.B  #$6700,(A0)                     ; $2B0F10
        ANDI.L  #$02D00010,-(A0)                ; $2B0F14
        BTST    D1,D0                           ; $2B0F1A
        BTST    D1,-(A0)                        ; $2B0F1C
        BTST    D1,$40(A0,D0.W)                 ; $2B0F1E
        BCHG    D1,(A0)                         ; $2B0F22
        DC.W    $0210,$0500         ; $2B0F24 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B0F28
        SUBI.B  #$0400,(A0)                     ; $2B0F2C
        BCHG    D1,D0                           ; $2B0F30
        BTST    D1,$10(A0,D0.W)                 ; $2B0F32
        BCS.W  loc_2B12B8                       ; $2B0F36
        BCLR    D1,(A0)                         ; $2B0F3A
        BCLR    D1,-(A0)                        ; $2B0F3C
        BCLR    D1,$10(A0,D0.W)                 ; $2B0F3E
        BLS.W  loc_2B1314                       ; $2B0F42
        BSET    D1,D0                           ; $2B0F46
        SUBI.B  #$6400,(A0)                     ; $2B0F48
        BCLR    D1,-(A0)                        ; $2B0F4C
        BCLR    D1,(A0)                         ; $2B0F4E
        DC.W    $0010,$0300         ; $2B0F50 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B0F54
        SUBI.W  #$0450,D0                       ; $2B0F58
        DC.W    $0210,$0500         ; $2B0F5C ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B0F60
        SUBI.B  #$0440,D0                       ; $2B0F66
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B0F6A
        SUBI.L  #$049004A0,D0                   ; $2B0F70
        DC.W    $04B0,$0210,$6300,$04D0; $2B0F76 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B0F7E DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B0F80
        SUBI.L  #$04900000,-(A0)                ; $2B0F84
        BVS.W  loc_2B112C                       ; $2B0F8A
        BCLR    D0,-$40(A0,D0.W)                ; $2B0F8E
        BSET    D0,(A0)                         ; $2B0F92
loc_2B0F94:
        DC.W    $0000,$6600         ; $2B0F94 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B0F98
        BSET    D1,$00(A0,D0.W)                 ; $2B0F9A
        SUBI.B  #$0000,(A0)                     ; $2B0F9E
        BNE.W  loc_2B1484                       ; $2B0FA2
        DC.W    $04F0               ; $2B0FA6 DC.W    $04F0
        BTST    D2,D0                           ; $2B0FA8
        BTST    D2,(A0)                         ; $2B0FAA
        CMPI.B  #$0052,D0                       ; $2B0FAC
        ORI.W  #$F93E,(A2)                      ; $2B0FB0
        BCLR    D0,-(A1)                        ; $2B0FB4
        ORI.L  #$F8EB01F2,A1                    ; $2B0FB6
        MOVE.W  D2,-$27(A7,A7.W)                ; $2B0FBC
        DC.W    $02DF               ; $2B0FC0 DC.W    $02DF
        DC.W    $0001,$F83C         ; $2B0FC2 ORI.B  #$F83C,D1
        DC.W    $027D,$013D         ; $2B0FC6 ANDI.W  #$013D,<EA:3D>
        MOVE.W  -$7E(A6,D0.W),-$007E(A4)        ; $2B0FCA
        MOVE.W  D3,(A4)                         ; $2B0FD0
        DC.W    $038E               ; $2B0FD2 BCLR    D1,A6
        DC.W    $0001,$F9C9         ; $2B0FD4 ORI.B  #$F9C9,D1
        DC.W    $0231,$0089,$F8E7   ; $2B0FD8 ANDI.B  #$0089,-$19(A1,A7.L)
        BTST    D1,$013D(A6)                    ; $2B0FDE
        MOVE.W  -(A3),(A4)                      ; $2B0FE2
        BTST    D1,$00FEF81C                    ; $2B0FE4
        DC.W    $02C5               ; $2B0FEA DC.W    $02C5
        ORI.L  #$F771036B,-(A5)                 ; $2B0FEC
        DC.W    $010D               ; $2B0FF2 BTST    D0,A5
        MOVE.W  (A4)+,D4                        ; $2B0FF4
        BCLR    D1,#$0151                       ; $2B0FF6
        MOVEA.W $6A(A0,D0.W),A4                 ; $2B0FFA
        ORI.W  #$F7E9,(A5)+                     ; $2B0FFE
        BSET    D1,$00AF(A6)                    ; $2B1002
        DC.W    $F87E               ; $2B1006 MOVEA.W <EA:3E>,A4
        DC.W    $02D9               ; $2B1008 DC.W    $02D9
        BCHG    D0,-$0718(A3)                   ; $2B100A
        DC.W    $02CC               ; $2B100E DC.W    $02CC
        BCLR    D0,(A2)+                        ; $2B1010
        MOVE.W  $71(A7,D0.W),-(A4)              ; $2B1012
        BCLR    D0,D4                           ; $2B1016
        MOVE.W  (A5),(A4)+                      ; $2B1018
        BCHG    D0,(A7)+                        ; $2B101A
        BCHG    D0,(A2)                         ; $2B101C
        MOVE.W  (A0)+,(A4)+                     ; $2B101E
        DC.W    $02F0               ; $2B1020 DC.W    $02F0
        BTST    D0,-$06D2(A5)                   ; $2B1022
        BCHG    D0,$15(A6,D0.W)                 ; $2B1026
        MOVE.W  -(A0),$01C6(A4)                 ; $2B102A
loc_2B102E:
        BTST    D0,D0                           ; $2B102E
        MOVE.W  D2,-$5D(A4,D0.W)                ; $2B1030
        BCHG    D0,D2                           ; $2B1034
        MOVEA.W $01F0(A1),A4                    ; $2B1036
        BSET    D0,$F80B.W                      ; $2B103A
        DC.W    $0223,$01DD         ; $2B103E ANDI.B  #$01DD,-(A3)
        MOVE.W  (A3),$0175(A4)                  ; $2B1042
        DC.W    $010F               ; $2B1046 BTST    D0,A7
        DC.W    $F7FE,$01D2         ; $2B1048 MOVE.W  <EA:3E>,-$2E(PC,D0.W)
        BSET    D0,-$0779(A4)                   ; $2B104C
        BTST    D0,(A7)+                        ; $2B1050
        BCLR    D0,(A5)                         ; $2B1052
        MOVE.W  (A7),$02D9(A3)                  ; $2B1054
        DC.W    $023A,$F78C,$0177   ; $2B1058 ANDI.B  #$F78C,$0177(PC)
        DC.W    $0236,$F834,$0070   ; $2B105E ANDI.B  #$F834,$70(A6,D0.W)
        BSET    D0,(A5)+                        ; $2B1064
        MOVEA.W $0201(A4),A4                    ; $2B1066
        MOVE.W  (A0),-(A7)                      ; $2B106A
        MOVE.W  (A2),(A4)                       ; $2B106C
        ANDI.W  #$FEC3,D7                       ; $2B106E
        MOVE.W  $035BFF92,D4                    ; $2B1072
        MOVE.W  A3,D4                           ; $2B1078
        BTST    D1,-$000E(A6)                   ; $2B107A
        MOVE.W  (A5),(A4)+                      ; $2B107E
        DC.W    $0221,$FF13         ; $2B1080 ANDI.B  #$FF13,-(A1)
        MOVEA.W $4E(A4,D0.W),A4                 ; $2B1084
        DC.W    $FFF4,$F74A         ; $2B1088 MOVE.W  $4A(A4,A7.W),<EA:3F>
        DC.W    $020A,$FF39         ; $2B108C ANDI.B  #$FF39,A2
        MOVE.W  (A0),$24(A3,D0.W)               ; $2B1090
loc_2B1094:
        MOVE.W  -(A7),(A7)+                     ; $2B1094
        MOVE.W  (A3)+,(A4)+                     ; $2B1096
        DC.W    $027E,$FEE7         ; $2B1098 ANDI.W  #$FEE7,<EA:3E>
        MOVE.W  (A5)+,(A4)+                     ; $2B109C
        ANDI.W  #$FF3A,$5D(A7,A7.W)             ; $2B109E
        DC.W    $01C8               ; $2B10A4 BSET    D0,A0
        MOVE.W  A0,-(A7)                        ; $2B10A6
        MOVE.W  $0236(A7),(A4)+                 ; $2B10A8
        MOVE.W  A1,-(A7)                        ; $2B10AC
        MOVE.W  D0,$00A8(A4)                    ; $2B10AE
        DC.W    $00A8,$F940,$00A8,$FF48; $2B10B2 ORI.L  #$F94000A8,-$00B8(A0)
        MOVE.W  $2D(PC,D0.W),(A4)+              ; $2B10BA
        MOVE.W  -$0705(A0),$022D(A7)            ; $2B10BE
        ORI.L  #$F9F600C9,A1                    ; $2B10C4
        MOVE.W  A0,-$064E(A7)                   ; $2B10CA
        ANDI.W  #$FF68,A4                       ; $2B10CE
        MOVE.W  -$37(A6,D0.W),#$00A8            ; $2B10D2
        MOVE.W  $4C(A2,D0.W),-$77(A4,D0.W)      ; $2B10D8
        MOVEA.W D7,A4                           ; $2B10DE
        BSET    D0,-(A5)                        ; $2B10E0
        ORI.L  #$F84E0167,A6                    ; $2B10E2
        BTST    D0,D0                           ; $2B10E8
        MOVE.W  $00C7(A6),#$0036                ; $2B10EA
loc_2B10F0:
        MOVE.W  -(A7),#$0145                    ; $2B10F0
        DC.W    $FFC5               ; $2B10F4 MOVE.W  D5,<EA:3F>
        MOVE.W  A7,(A4)                         ; $2B10F6
        DC.W    $0204,$0109         ; $2B10F8 ANDI.B  #$0109,D4
        MOVE.W  $0164(A7),D5                    ; $2B10FC
        DC.W    $003E,$F79D         ; $2B1100 ORI.B  #$F79D,<EA:3E>
loc_2B1104:
        ORI.W  #$016E,(A5)+                     ; $2B1104
        MOVE.W  A5,D4                           ; $2B1108
        ORI.W  #$0171,D0                        ; $2B110A
        MOVEA.W -$50(A2,D0.W),A4                ; $2B110E
        DC.W    $00D9               ; $2B1112 DC.W    $00D9
        MOVE.W  D3,D4                           ; $2B1114
loc_2B1116:
        DC.W    $01CC               ; $2B1116 BSET    D0,A4
        DC.W    $00D6               ; $2B1118 DC.W    $00D6
        MOVE.W  (A0),$73(PC,D0.W)               ; $2B111A
        BSET    D0,D4                           ; $2B111E
        MOVE.W  -$1D(A5,D0.W),D4                ; $2B1120
        BTST    D0,-$0915(A5)                   ; $2B1124
        DC.W    $0024,$0173         ; $2B1128 ORI.B  #$0173,-(A4)
loc_2B112C:
        MOVE.W  -$0016(A3),(A3)+                ; $2B112C
        BCHG    D0,$0A(A3,A7.L)                 ; $2B1130
        DC.W    $FFEA,$0173         ; $2B1134 MOVE.W  $0173(A2),<EA:3F>
        MOVE.W  A2,D4                           ; $2B1138
        ORI.W  #$0173,D6                        ; $2B113A
        MOVE.W  (A7),$00D4(A4)                  ; $2B113E
        DC.W    $0019,$F9AA         ; $2B1142 ORI.B  #$F9AA,(A1)+
        BCHG    D0,D1                           ; $2B1146
        MOVE.W  -$21(A5,A7.L),-$23(A7,A7.L)     ; $2B1148
        MOVE.W  -$75(A4,A7.L),-(A7)             ; $2B114E
        MOVE.W  -$67(A0,A7.L),-$06DA(A7)        ; $2B1152
        DC.W    $00DD               ; $2B1158 DC.W    $00DD
        MOVE.W  (A2),$5B(A7,A7.L)               ; $2B115A
        MOVE.W  $10(A7,A7.L),-$0526(A7)         ; $2B115E
        MOVE.W  -(A0),-$009A(A7)                ; $2B1164
        MOVE.W  A6,(A5)                         ; $2B1168
        MOVE.W  $4E(A4,A7.L),-$3F(A7,A7.L)      ; $2B116A
        DC.W    $00B0,$FEEF,$FC0D,$005D; $2B1170 ORI.L  #$FEEFFC0D,$5D(A0,D0.W)
        MOVE.W  D6,-(A7)                        ; $2B1178
        MOVE.W  $65(A7,A7.L),(A5)               ; $2B117A
        MOVE.W  D5,-(A7)                        ; $2B117E
        DC.W    $FBEB,$0062         ; $2B1180 MOVE.W  $0062(A3),<EA:3D>
        MOVE.W  -(A5),(A7)                      ; $2B1184
        MOVEA.W -$003A(A4),A6                   ; $2B1186
        MOVE.W  -$0361(A1),(A7)+                ; $2B118A
        DC.W    $FFE4               ; $2B118E MOVE.W  -(A4),<EA:3F>
        MOVE.W  -$03F1(A1),(A7)+                ; $2B1190
        DC.W    $00DB               ; $2B1194 DC.W    $00DB
        MOVE.W  -$0442(A1),(A7)+                ; $2B1196
        DC.W    $00AC,$FEE9,$0010,$6E00; $2B119A ORI.L  #$FEE90010,$6E00(A4)
        DC.W    $0000,$0010         ; $2B11A2 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B11A6 ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B11AA
        ORI.W  #$0050,D0                        ; $2B11AE
        SUBI.B  #$7000,(A0)                     ; $2B11B2
        ORI.W  #$0070,-(A0)                     ; $2B11B6
        SUBI.B  #$6F00,(A0)                     ; $2B11BA
        DC.W    $0000,$0030         ; $2B11BE ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B11C2 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B11C6 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B11CA ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B11CE
        DC.W    $00B0,$0210,$0400,$00D0; $2B11D4 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B11DC DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B11DE
        ORI.L  #$00900611,-(A0)                 ; $2B11E2
        BTST    D3,D1                           ; $2B11E8
        DC.W    $00B0,$0010,$6A00,$00E0; $2B11EA ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B11F2 DC.W    $00F0
        BTST    D0,D0                           ; $2B11F4
        BTST    D0,(A0)                         ; $2B11F6
        DC.W    $0210,$6C00         ; $2B11F8 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B11FC
        SUBI.B  #$6B00,(A0)                     ; $2B1200
        BTST    D0,D0                           ; $2B1204
        DC.W    $00F0               ; $2B1206 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B1208 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B120C DC.W    $00E0
        DC.W    $0010,$6300         ; $2B120E ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B1212
        BCHG    D0,(A0)                         ; $2B1214
        BCHG    D0,-(A0)                        ; $2B1216
        BCHG    D0,$10(A0,D0.W)                 ; $2B1218
        BCS.W  loc_2B13AE                       ; $2B121C
        BCLR    D0,D0                           ; $2B1220
        SUBI.B  #$6400,(A0)                     ; $2B1222
        BCHG    D0,-(A0)                        ; $2B1226
        BCHG    D0,(A0)                         ; $2B1228
        ADDI.B  #$6201,(A1)                     ; $2B122A
        BCHG    D0,$10(A0,D0.W)                 ; $2B122E
        BPL.W  loc_2B1414                       ; $2B1232
        BSET    D0,$00(A0,D0.W)                 ; $2B1236
        DC.W    $0210,$0210         ; $2B123A ANDI.B  #$0210,(A0)
        BGE.W  loc_2B1470                       ; $2B123E
        DC.W    $0220,$0410         ; $2B1242 ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B1448                       ; $2B1246
        BSET    D0,$11(A0,D0.W)                 ; $2B124A
        BVS.S  loc_2B1251                       ; $2B124E
        DC.W    $0210,$0010         ; $2B1250 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B1496                       ; $2B1254
        ANDI.W  #$0260,(A0)                     ; $2B1258
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B125C
        ANDI.L  #$02800410,(A0)                 ; $2B1262
        BCC.W  loc_2B14CA                       ; $2B1268
        ANDI.W  #$0211,(A0)                     ; $2B126C
        BHI.S  loc_2B1273                       ; $2B1270
        ANDI.W  #$0010,D0                       ; $2B1272
        BNE.W  loc_2B1518                       ; $2B1276
        DC.W    $02B0,$02C0,$02D0,$0610; $2B127A ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B1564                       ; $2B1282
        DC.W    $02F0               ; $2B1286 DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B1288
        BTST    D1,D0                           ; $2B128C
        BTST    D1,(A0)                         ; $2B128E
        SUBI.B  #$6700,(A0)                     ; $2B1290
        ANDI.L  #$02D00010,-(A0)                ; $2B1294
        BTST    D1,D0                           ; $2B129A
        BTST    D1,-(A0)                        ; $2B129C
        BTST    D1,$40(A0,D0.W)                 ; $2B129E
        BCHG    D1,(A0)                         ; $2B12A2
        DC.W    $0210,$0500         ; $2B12A4 ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B12A8
        SUBI.B  #$0400,(A0)                     ; $2B12AC
        BCHG    D1,D0                           ; $2B12B0
        BTST    D1,$10(A0,D0.W)                 ; $2B12B2
        BCS.W  loc_2B1638                       ; $2B12B6
        BCLR    D1,(A0)                         ; $2B12BA
        BCLR    D1,-(A0)                        ; $2B12BC
        BCLR    D1,$10(A0,D0.W)                 ; $2B12BE
        BLS.W  loc_2B1694                       ; $2B12C2
        BSET    D1,D0                           ; $2B12C6
        SUBI.B  #$6400,(A0)                     ; $2B12C8
        BCLR    D1,-(A0)                        ; $2B12CC
        BCLR    D1,(A0)                         ; $2B12CE
        DC.W    $0010,$0300         ; $2B12D0 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B12D4
        SUBI.W  #$0450,D0                       ; $2B12D8
        DC.W    $0210,$0500         ; $2B12DC ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B12E0
        SUBI.B  #$0440,D0                       ; $2B12E6
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B12EA
        SUBI.L  #$049004A0,D0                   ; $2B12F0
        DC.W    $04B0,$0210,$6300,$04D0; $2B12F6 SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B12FE DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B1300
        SUBI.L  #$04900000,-(A0)                ; $2B1304
        BVS.W  loc_2B14AC                       ; $2B130A
        BCLR    D0,-$40(A0,D0.W)                ; $2B130E
        BSET    D0,(A0)                         ; $2B1312
loc_2B1314:
        DC.W    $0000,$6600         ; $2B1314 ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B1318
        BSET    D1,$00(A0,D0.W)                 ; $2B131A
        SUBI.B  #$0000,(A0)                     ; $2B131E
        BNE.W  loc_2B1804                       ; $2B1322
        DC.W    $04F0               ; $2B1326 DC.W    $04F0
        BTST    D2,D0                           ; $2B1328
        BTST    D2,(A0)                         ; $2B132A
        CMPI.B  #$004E,D0                       ; $2B132C
        ORI.W  #$F945,A6                        ; $2B1330
        BCLR    D0,$7D(A6,D0.W)                 ; $2B1334
        MOVE.W  $0208(A4),(A4)+                 ; $2B1338
        MOVE.W  $F7D4.W,$02EB(A7)               ; $2B133C
        DC.W    $FFFE               ; $2B1342 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $F83F               ; $2B1344 MOVE.W  <EA:3F>,D4
        ANDI.L  #$0137F973,A1                   ; $2B1346
        ANDI.L  #$FF78F87A,(A2)+                ; $2B134C
        BCLR    D1,(A7)+                        ; $2B1352
        DC.W    $FFFE               ; $2B1354 MOVE.W  <EA:3E>,<EA:3F>
        MOVE.W  A3,#$0248                       ; $2B1356
        DC.W    $007D,$F8E5         ; $2B135A ORI.W  #$F8E5,<EA:3D>
        DC.W    $033D               ; $2B135E BTST    D1,<EA:3D>
        BTST    D0,-$5F(A7,A7.L)                ; $2B1360
        BCHG    D1,D7                           ; $2B1364
        DC.W    $00FA               ; $2B1366 DC.W    $00FA
        MOVE.W  (A3)+,D4                        ; $2B1368
        DC.W    $02D1               ; $2B136A DC.W    $02D1
        ORI.L  #$F76E0371,-(A1)                 ; $2B136C
        DC.W    $010D               ; $2B1372 BTST    D0,A5
        MOVE.W  (A7),D4                         ; $2B1374
        BSET    D1,D6                           ; $2B1376
        BCHG    D0,(A0)                         ; $2B1378
        MOVEA.W $0379(A2),A4                    ; $2B137A
        ORI.W  #$F7E1,(A1)+                     ; $2B137E
        BSET    D1,$00AF.W                      ; $2B1382
        MOVE.W  (A0),(A4)                       ; $2B1386
        DC.W    $030C               ; $2B1388 BTST    D1,A4
        BCHG    D0,(A2)                         ; $2B138A
        MOVE.W  -$12(A1,D0.W),(A4)+             ; $2B138C
        DC.W    $018A               ; $2B1390 BCLR    D0,A2
        MOVE.W  -(A4),(A4)+                     ; $2B1392
        DC.W    $018D               ; $2B1394 BCLR    D0,A5
        BCLR    D0,-$80(A7,A7.L)                ; $2B1396
        DC.W    $018B               ; $2B139A BCLR    D0,A3
        BCLR    D0,D4                           ; $2B139C
        MOVE.W  $0301(A5),(A4)+                 ; $2B139E
        BTST    D0,(A0)+                        ; $2B13A2
        MOVE.W  (A6)+,(A4)+                     ; $2B13A4
        BCLR    D0,D0                           ; $2B13A6
        DC.W    $0149               ; $2B13A8 BCHG    D0,A1
        MOVE.W  (A4),(A4)+                      ; $2B13AA
        BSET    D0,(A6)+                        ; $2B13AC
loc_2B13AE:
        BCHG    D0,(A1)+                        ; $2B13AE
        MOVE.W  A4,-(A4)                        ; $2B13B0
        DC.W    $01BE               ; $2B13B2 BCLR    D0,<EA:3E>
        DC.W    $018D               ; $2B13B4 BCLR    D0,A5
        MOVE.W  A5,D4                           ; $2B13B6
        BTST    D0,$41(A1,D0.W)                 ; $2B13B8
        MOVE.W  (A6)+,$32(A3,D0.W)              ; $2B13BC
        DC.W    $0233,$F8F5,$0192   ; $2B13C0 ANDI.B  #$F8F5,-$6E(A3,D0.W)
        DC.W    $014B               ; $2B13C6 BCHG    D0,A3
        DC.W    $F7BF,$00E6         ; $2B13C8 MOVE.W  <EA:3F>,-$1A(A3,D0.W)
        DC.W    $0225,$F873         ; $2B13CC ANDI.B  #$F873,-(A5)
        DC.W    $020F,$FF15         ; $2B13D0 ANDI.B  #$FF15,A7
        MOVE.W  (A1),(A4)                       ; $2B13D4
        ANDI.W  #$FEC5,(A6)                     ; $2B13D6
        MOVE.W  $69(A0,D0.W),D4                 ; $2B13DA
        MOVE.W  (A1),$0A(A7,A7.L)               ; $2B13DE
        BTST    D1,-$0C(PC,A7.L)                ; $2B13E2
        MOVE.W  (A3)+,(A4)+                     ; $2B13E6
        DC.W    $0237,$FF12,$F871   ; $2B13E8 ANDI.B  #$FF12,$71(A7,A7.L)
        BCHG    D1,-(A3)                        ; $2B13EE
        DC.W    $FFF0,$F761         ; $2B13F0 MOVE.W  $61(A0,A7.W),<EA:3F>
        BCLR    D0,$15(A4,A7.L)                 ; $2B13F4
        MOVE.W  -(A3),-$1D(A3,D0.W)             ; $2B13F8
        MOVE.W  A1,(A7)+                        ; $2B13FC
        MOVE.W  D7,(A4)+                        ; $2B13FE
        ANDI.L  #$FEE8F8C4,(A3)                 ; $2B1400
        ANDI.L  #$FF3AF788,A2                   ; $2B1406
        BCHG    D0,-$011B(PC)                   ; $2B140C
        MOVE.W  $0251(A4),(A4)+                 ; $2B1410
loc_2B1414:
        MOVE.W  A3,-(A7)                        ; $2B1414
        MOVE.W  D1,$00C1(A4)                    ; $2B1416
        ORI.L  #$F94100C1,(A5)+                 ; $2B141A
        DC.W    $FF3D               ; $2B1420 MOVE.W  <EA:3D>,-(A7)
        MOVE.W  #$0245,(A4)+                    ; $2B1422
        MOVE.W  (A5)+,-$0704(A7)                ; $2B1426
        ANDI.W  #$007D,D5                       ; $2B142A
        MOVE.W  -$1E(A7,D0.W),#$FF3D            ; $2B142E
        MOVE.W  $66(A3,D0.W),$5D(A4,A7.L)       ; $2B1434
        MOVE.W  -$1E(A7,D0.W),#$009D            ; $2B143A
        MOVE.W  $66(A3,D0.W),$7D(A4,D0.W)       ; $2B1440
        MOVE.W  $01E3(PC),D4                    ; $2B1446
        ORI.L  #$F84B0165,A2                    ; $2B144A
        DC.W    $00FA               ; $2B1450 DC.W    $00FA
        MOVE.W  -$1D(A2,D0.W),#$0029            ; $2B1452
        MOVE.W  -(A1),#$0162                    ; $2B1458
        MOVE.W  -$0780(PC),$06(A7,D0.W)         ; $2B145C
        BTST    D0,D4                           ; $2B1462
        MOVE.W  -(A7),D5                        ; $2B1464
        BCLR    D0,D4                           ; $2B1466
        DC.W    $0033,$F79D,$005B   ; $2B1468 ORI.B  #$F79D,$5B(A3,D0.W)
        BCHG    D0,-$07F3(A5)                   ; $2B146E
        ORI.W  #$0171,D0                        ; $2B1472
        MOVEA.W $01AE(A4),A4                    ; $2B1476
        DC.W    $00D2               ; $2B147A DC.W    $00D2
        MOVE.W  #$01C9,-$32(PC,D0.W)            ; $2B147C
        MOVE.W  A7,$73(PC,D0.W)                 ; $2B1482
        BSET    D0,D3                           ; $2B1486
        MOVE.W  $01E2(A7),D4                    ; $2B1488
        BTST    D0,-(A4)                        ; $2B148C
        MOVE.W  $0024(A3),(A3)+                 ; $2B148E
        BCHG    D0,-$15(A3,A7.W)                ; $2B1492
loc_2B1496:
        DC.W    $FFEA,$0173         ; $2B1496 MOVE.W  $0173(A2),<EA:3F>
        MOVE.W  A2,D4                           ; $2B149A
        DC.W    $FFEA,$0173         ; $2B149C MOVE.W  $0173(A2),<EA:3F>
        MOVE.W  A2,D4                           ; $2B14A0
        ORI.W  #$0173,D6                        ; $2B14A2
        MOVE.W  (A4),$00F3(A4)                  ; $2B14A6
        DC.W    $000C,$F9AF         ; $2B14AA ORI.B  #$F9AF,A4
        BCHG    D0,(A3)+                        ; $2B14AE
        MOVE.W  -$052D(A1),-$19(A7,A7.L)        ; $2B14B0
        MOVE.W  $79(A0,A7.L),-(A7)              ; $2B14B6
        DC.W    $FF7F,$FF93         ; $2B14BA MOVE.W  <EA:3F>,-$006D(A7)
        MOVE.W  -(A6),-(A4)                     ; $2B14BE
        DC.W    $00FC               ; $2B14C0 DC.W    $00FC
        MOVE.W  D4,$4B(A7,A7.L)                 ; $2B14C2
        MOVE.W  A1,$0A(A7,A7.L)                 ; $2B14C6
loc_2B14CA:
        MOVE.W  A0,(A5)+                        ; $2B14CA
        MOVE.W  -$009F(A3),-$0580(A7)           ; $2B14CC
        DC.W    $FFC2               ; $2B14D2 MOVE.W  D2,<EA:3F>
        MOVE.W  A0,-$043F(A7)                   ; $2B14D4
        DC.W    $00B1,$FEEE,$FC09,$005A; $2B14D8 ORI.L  #$FEEEFC09,$5A(A1,D0.W)
        MOVE.W  D7,-(A7)                        ; $2B14E0
        MOVE.W  -(A7),(A5)                      ; $2B14E2
        MOVE.W  -$01(A2,A7.L),-$0417(A7)        ; $2B14E4
        ORI.W  #$FEA5,-(A0)                     ; $2B14EA
        MOVEA.W -$003A(A3),A6                   ; $2B14EE
        MOVE.W  -$0361(A1),(A7)+                ; $2B14F2
        DC.W    $FFE4               ; $2B14F6 MOVE.W  -(A4),<EA:3F>
        MOVE.W  -$03F2(A1),(A7)+                ; $2B14F8
        DC.W    $00DB               ; $2B14FC DC.W    $00DB
        MOVE.W  -$0442(A1),(A7)+                ; $2B14FE
        DC.W    $00AC,$FEE9,$0010,$6E00; $2B1502 ORI.L  #$FEE90010,$6E00(A4)
        DC.W    $0000,$0010         ; $2B150A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B150E ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B1512
        ORI.W  #$0050,D0                        ; $2B1516
        SUBI.B  #$7000,(A0)                     ; $2B151A
        ORI.W  #$0070,-(A0)                     ; $2B151E
        SUBI.B  #$6F00,(A0)                     ; $2B1522
        DC.W    $0000,$0030         ; $2B1526 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B152A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B152E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B1532 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B1536
        DC.W    $00B0,$0210,$0400,$00D0; $2B153C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B1544 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B1546
        ORI.L  #$00900611,-(A0)                 ; $2B154A
        BTST    D3,D1                           ; $2B1550
        DC.W    $00B0,$0010,$6A00,$00E0; $2B1552 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B155A DC.W    $00F0
        BTST    D0,D0                           ; $2B155C
        BTST    D0,(A0)                         ; $2B155E
        DC.W    $0210,$6C00         ; $2B1560 ANDI.B  #$6C00,(A0)
loc_2B1564:
        BTST    D0,$20(A0,D0.W)                 ; $2B1564
        SUBI.B  #$6B00,(A0)                     ; $2B1568
        BTST    D0,D0                           ; $2B156C
        DC.W    $00F0               ; $2B156E DC.W    $00F0
        DC.W    $0211,$6901         ; $2B1570 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B1574 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B1576 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B157A
        BCHG    D0,(A0)                         ; $2B157C
        BCHG    D0,-(A0)                        ; $2B157E
        BCHG    D0,$10(A0,D0.W)                 ; $2B1580
        BCS.W  loc_2B1716                       ; $2B1584
        BCLR    D0,D0                           ; $2B1588
        SUBI.B  #$6400,(A0)                     ; $2B158A
        BCHG    D0,-(A0)                        ; $2B158E
        BCHG    D0,(A0)                         ; $2B1590
        ADDI.B  #$6201,(A1)                     ; $2B1592
        BCHG    D0,$10(A0,D0.W)                 ; $2B1596
        BPL.W  loc_2B173C                       ; $2B159A
        BCLR    D0,-$40(A0,D0.W)                ; $2B159E
        BSET    D0,(A0)                         ; $2B15A2
        DC.W    $0210,$6C00         ; $2B15A4 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B15A8
        SUBI.B  #$6B00,(A0)                     ; $2B15AC
        BSET    D0,D0                           ; $2B15B0
        BCLR    D0,$11(A0,D0.W)                 ; $2B15B2
        BVS.S  loc_2B15B9                       ; $2B15B6
        BSET    D0,(A0)                         ; $2B15B8
        DC.W    $0010,$6300         ; $2B15BA ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B15BE ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B15C2 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B15C6 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B15CA
        SUBI.B  #$6400,(A0)                     ; $2B15CE
        DC.W    $0220,$0210         ; $2B15D2 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B15D6 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B15DA ANDI.B  #$0010,D0
        BNE.W  loc_2B1840                       ; $2B15DE
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2B15E2
        ADDI.B  #$6700,(A0)                     ; $2B15E8
        ANDI.L  #$02B00410,-(A0)                ; $2B15EC
        BVC.W  loc_2B18B4                       ; $2B15F2
        DC.W    $02D0               ; $2B15F6 DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2B15F8
        ANDI.W  #$0290,-(A0)                    ; $2B15FC
        DC.W    $0010,$0300         ; $2B1600 ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2B1604 DC.W    $02E0
        DC.W    $02F0               ; $2B1606 DC.W    $02F0
        BTST    D1,D0                           ; $2B1608
        BTST    D1,(A0)                         ; $2B160A
        DC.W    $0210,$0500         ; $2B160C ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2B1610
        SUBI.B  #$0400,(A0)                     ; $2B1614
        BTST    D1,D0                           ; $2B1618
        DC.W    $02F0               ; $2B161A DC.W    $02F0
        DC.W    $0010,$6500         ; $2B161C ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2B1620
        BCHG    D1,(A0)                         ; $2B1622
        BCHG    D1,-(A0)                        ; $2B1624
        BCHG    D1,$10(A0,D0.W)                 ; $2B1626
        BLS.W  loc_2B19BC                       ; $2B162A
        BCLR    D1,D0                           ; $2B162E
        SUBI.B  #$6400,(A0)                     ; $2B1630
        BCHG    D1,-(A0)                        ; $2B1634
        BCHG    D1,(A0)                         ; $2B1636
loc_2B1638:
        DC.W    $0010,$0300         ; $2B1638 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B163C
        BSET    D1,$00(A0,D0.W)                 ; $2B163E
        SUBI.B  #$0210,(A0)                     ; $2B1642
        BTST    D2,D0                           ; $2B1646
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B1648
        SUBI.B  #$0400,D0                       ; $2B164E
        BSET    D1,$10(A0,D0.W)                 ; $2B1652
        BCS.W  loc_2B1A98                       ; $2B1656
        SUBI.W  #$0460,(A0)                     ; $2B165A
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B165E
        SUBI.L  #$04800410,(A0)                 ; $2B1664
        BCC.W  loc_2B1ACC                       ; $2B166A
        SUBI.W  #$0000,(A0)                     ; $2B166E
        BNE.W  loc_2B1A14                       ; $2B1672
        BCLR    D1,-$40(A0,D0.W)                ; $2B1676
        BSET    D1,(A0)                         ; $2B167A
        DC.W    $0000,$6600         ; $2B167C ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B1680
        DC.W    $04D0               ; $2B1686 DC.W    $04D0
        CMPI.B  #$004E,D0                       ; $2B1688
        ORI.W  #$F906,A6                        ; $2B168C
        DC.W    $023E,$0050         ; $2B1690 ANDI.B  #$0050,<EA:3E>
loc_2B1694:
        MOVE.W  D3,-(A4)                        ; $2B1694
        ANDI.W  #$FF31,D1                       ; $2B1696
        MOVE.W  $0358(PC),$1B(PC,A7.L)          ; $2B169A
        DC.W    $F7FE,$0352         ; $2B16A0 MOVE.W  <EA:3E>,$52(PC,D0.W)
        ORI.W  #$F99B,-$3E(A3,D0.W)             ; $2B16A4
        MOVE.W  -$4A(A1,A7.L),-(A7)             ; $2B16AA
        BSET    D1,$1B(A5,A7.L)                 ; $2B16AE
        MOVE.W  (A6)+,-$42(A4,D0.W)             ; $2B16B2
        ORI.W  #$F8BA,(A0)                      ; $2B16B6
        BSET    D1,$73(A1,D0.W)                 ; $2B16BA
        MOVE.W  A2,(A4)                         ; $2B16BE
        BSET    D1,$0024(A5)                    ; $2B16C0
        MOVE.W  A7,D4                           ; $2B16C4
        BCHG    D1,-$0034(A4)                   ; $2B16C6
        MOVE.W  $0432(A0),-$0030(A3)            ; $2B16CA
        MOVE.W  D5,D4                           ; $2B16D0
        SUBI.L  #$0027F888,A3                   ; $2B16D2
        BSET    D1,-$008C(A7)                   ; $2B16D8
        MOVE.W  D3,D4                           ; $2B16DC
        SUBI.L  #$FF77F855,A5                   ; $2B16DE
        BSET    D1,D6                           ; $2B16E4
        ORI.W  #$F895,-$4C(PC,D0.W)             ; $2B16E6
        DC.W    $00DA               ; $2B16EC DC.W    $00DA
        MOVEA.W $5B(A4,D0.W),A4                 ; $2B16EE
        BTST    D0,-$07CF(A1)                   ; $2B16F2
        ANDI.W  #$00D2,A5                       ; $2B16F6
        MOVE.W  D2,(A4)+                        ; $2B16FA
        BCLR    D1,$006FF89E                    ; $2B16FC
        ANDI.W  #$00C6,D0                       ; $2B1702
        MOVEA.W $029A(PC),A4                    ; $2B1706
        DC.W    $00C8               ; $2B170A DC.W    $00C8
        MOVE.W  (A5)+,(A4)                      ; $2B170C
        ANDI.L  #$0111F78E,A0                   ; $2B170E
        BSET    D0,D6                           ; $2B1714
loc_2B1716:
        BCHG    D0,-(A0)                        ; $2B1716
        MOVE.W  -$52(A1,D0.W),-(A3)             ; $2B1718
        BTST    D0,-(A7)                        ; $2B171C
        MOVE.W  $0258(A5),(A4)                  ; $2B171E
        DC.W    $00CF               ; $2B1722 DC.W    $00CF
        MOVE.W  -(A3),$016B(A3)                 ; $2B1724
        BTST    D0,$65(A0,A7.L)                 ; $2B1728
        ANDI.W  #$FEF4,D1                       ; $2B172C
        MOVE.W  (A5)+,(A4)                      ; $2B1730
        ANDI.W  #$FE95,A3                       ; $2B1732
        MOVE.W  D6,(A4)                         ; $2B1736
        BCLR    D1,-$0150(A6)                   ; $2B1738
loc_2B173C:
        MOVEA.W A3,A4                           ; $2B173C
        BSET    D1,D3                           ; $2B173E
        MOVE.W  (A1),-(A7)                      ; $2B1740
        MOVE.W  (A3),(A4)+                      ; $2B1742
        ANDI.W  #$FEF6,D7                       ; $2B1744
        MOVE.W  $03CA(PC),(A4)                  ; $2B1748
        MOVE.W  (A3),-(A7)                      ; $2B174C
        MOVE.W  $0194(A2),-$012C(A3)            ; $2B174E
        DC.W    $F7BF,$01A9         ; $2B1754 MOVE.W  <EA:3F>,-$57(A3,D0.W)
        MOVE.W  A7,(A7)                         ; $2B1758
        MOVE.W  D6,(A4)+                        ; $2B175A
        ANDI.L  #$FEA3F8AA,D4                   ; $2B175C
        ANDI.L  #$FEECF79F,(A7)+                ; $2B1762
        BCHG    D0,(A4)                         ; $2B1768
        MOVE.W  (A0),(A7)+                      ; $2B176A
        MOVE.W  -(A0),(A4)+                     ; $2B176C
        ANDI.W  #$FEE8,(A7)+                    ; $2B176E
        MOVE.W  $0E(PC,D0.W),-(A4)              ; $2B1772
        ORI.W  #$F93B,$0E(A0,D0.W)              ; $2B1776
        MOVE.W  (A0),-(A7)                      ; $2B177C
        MOVE.W  -$6E(A6,D0.W),(A4)+             ; $2B177E
        MOVE.W  -$0A(A0,A7.L),-(A7)             ; $2B1782
        ANDI.L  #$0050F9F1,(A2)                 ; $2B1786
        BTST    D0,-$00F0(A7)                   ; $2B178C
        MOVE.W  $02B2(A5),$30(A4,A7.L)          ; $2B1790
        MOVE.W  $2F(A1,D0.W),#$0070             ; $2B1796
        MOVE.W  $02B2(A5),$50(A4,D0.W)          ; $2B179C
        MOVE.W  (A5),D4                         ; $2B17A2
        BSET    D0,(A2)                         ; $2B17A4
        ORI.W  #$F848,$0159.W                   ; $2B17A6
        DC.W    $00E3               ; $2B17AC DC.W    $00E3
        MOVE.W  $3D(A4,D0.W),#$FFF8             ; $2B17AE
        MOVE.W  D2,#$01B8                       ; $2B17B4
        MOVE.W  A6,$5A(A7,A7.L)                 ; $2B17B8
        DC.W    $0202,$00EF         ; $2B17BC ANDI.B  #$00EF,D2
        MOVE.W  D6,D5                           ; $2B17C0
        BSET    D0,-(A6)                        ; $2B17C2
        DC.W    $0005,$F79C         ; $2B17C4 ORI.B  #$F79C,D5
        ORI.W  #$016A,(A7)                      ; $2B17C8
        MOVE.W  A5,D4                           ; $2B17CC
        ORI.W  #$0171,D0                        ; $2B17CE
        MOVEA.W -(A1),A4                        ; $2B17D2
        BCLR    D0,-(A3)                        ; $2B17D4
        DC.W    $00B7,$F7F0,$01BB,$00B1; $2B17D6 ORI.L  #$F7F001BB,-$4F(A7,D0.W)
        MOVE.W  A4,$77(PC,D0.W)                 ; $2B17DE
        DC.W    $01BF               ; $2B17E2 BCLR    D0,<EA:3F>
        MOVE.W  -(A1),D4                        ; $2B17E4
        BSET    D0,(A4)+                        ; $2B17E6
        BTST    D0,D5                           ; $2B17E8
        MOVE.W  $0024(A3),(A3)+                 ; $2B17EA
        BCHG    D0,-$15(A3,A7.W)                ; $2B17EE
        DC.W    $FFEA,$0173         ; $2B17F2 MOVE.W  $0173(A2),<EA:3F>
        MOVE.W  A2,D4                           ; $2B17F6
        DC.W    $FFEA,$0173         ; $2B17F8 MOVE.W  $0173(A2),<EA:3F>
        MOVE.W  A2,D4                           ; $2B17FC
        ORI.W  #$0173,D6                        ; $2B17FE
        MOVE.W  D2,$014D(A4)                    ; $2B1802
        DC.W    $FFD7               ; $2B1806 MOVE.W  (A7),<EA:3F>
        MOVE.W  -$58(A0,D0.W),$7A(A4,A7.L)      ; $2B1808
        MOVE.W  $13(A3,D0.W),(A5)               ; $2B180E
        MOVE.W  (A7)+,-(A7)                     ; $2B1812
        MOVEA.W D5,A5                           ; $2B1814
        MOVE.W  -$0085(PC),$21(A7,A7.L)         ; $2B1816
        BCHG    D0,(A1)+                        ; $2B181C
        MOVE.W  A2,-$05DC(A7)                   ; $2B181E
        DC.W    $FFC5               ; $2B1822 MOVE.W  D5,<EA:3F>
        MOVE.W  -$0570(A6),(A7)+                ; $2B1824
        MOVE.W  (A4)+,$52(A7,A7.L)              ; $2B1828
        MOVEA.W (A1)+,A5                        ; $2B182C
        DC.W    $FFFB,$FF32         ; $2B182E MOVE.W  $32(PC,A7.L),<EA:3F>
        DC.W    $FBC2               ; $2B1832 MOVE.W  D2,<EA:3D>
        DC.W    $00B2,$FEED,$FBF8,$0051; $2B1834 ORI.L  #$FEEDFBF8,$51(A2,D0.W)
        MOVE.W  A6,-(A7)                        ; $2B183C
        MOVEA.W $FFA3.W,A5                      ; $2B183E
        MOVE.W  -$041E(A6),(A7)+                ; $2B1842
        ORI.W  #$FEA9,(A2)+                     ; $2B1846
        MOVEA.W -$003A(A3),A6                   ; $2B184A
        MOVE.W  -$0362(A0),(A7)+                ; $2B184E
        DC.W    $FFE4               ; $2B1852 MOVE.W  -(A4),<EA:3F>
        MOVE.W  -$03F2(A0),(A7)+                ; $2B1854
        DC.W    $00DB               ; $2B1858 DC.W    $00DB
        MOVE.W  -$0442(A0),(A7)+                ; $2B185A
        DC.W    $00AC,$FEE8,$0010,$6E00; $2B185E ORI.L  #$FEE80010,$6E00(A4)
        DC.W    $0000,$0010         ; $2B1866 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B186A ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B186E
        ORI.W  #$0050,D0                        ; $2B1872
        SUBI.B  #$7000,(A0)                     ; $2B1876
        ORI.W  #$0070,-(A0)                     ; $2B187A
        SUBI.B  #$6F00,(A0)                     ; $2B187E
        DC.W    $0000,$0030         ; $2B1882 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B1886 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B188A ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B188E ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B1892
        DC.W    $00B0,$0210,$0400,$00D0; $2B1898 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B18A0 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B18A2
        ORI.L  #$00900611,-(A0)                 ; $2B18A6
        BTST    D3,D1                           ; $2B18AC
        DC.W    $00B0,$0010,$6A00,$00E0; $2B18AE ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B18B6 DC.W    $00F0
        BTST    D0,D0                           ; $2B18B8
        BTST    D0,(A0)                         ; $2B18BA
        DC.W    $0210,$6C00         ; $2B18BC ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B18C0
        SUBI.B  #$6B00,(A0)                     ; $2B18C4
        BTST    D0,D0                           ; $2B18C8
        DC.W    $00F0               ; $2B18CA DC.W    $00F0
        DC.W    $0211,$6901         ; $2B18CC ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B18D0 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B18D2 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B18D6
        BCHG    D0,(A0)                         ; $2B18D8
        BCHG    D0,-(A0)                        ; $2B18DA
        BCHG    D0,$10(A0,D0.W)                 ; $2B18DC
        BCS.W  loc_2B1A72                       ; $2B18E0
        BCLR    D0,D0                           ; $2B18E4
        SUBI.B  #$6400,(A0)                     ; $2B18E6
        BCHG    D0,-(A0)                        ; $2B18EA
        BCHG    D0,(A0)                         ; $2B18EC
        ADDI.B  #$6201,(A1)                     ; $2B18EE
        BCHG    D0,$10(A0,D0.W)                 ; $2B18F2
        BPL.W  loc_2B1A98                       ; $2B18F6
        BCLR    D0,-$40(A0,D0.W)                ; $2B18FA
        BSET    D0,(A0)                         ; $2B18FE
        DC.W    $0210,$6C00         ; $2B1900 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B1904
        SUBI.B  #$6B00,(A0)                     ; $2B1908
        BSET    D0,D0                           ; $2B190C
        BCLR    D0,$11(A0,D0.W)                 ; $2B190E
        BVS.S  loc_2B1915                       ; $2B1912
        BSET    D0,(A0)                         ; $2B1914
        DC.W    $0010,$6300         ; $2B1916 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B191A ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B191E ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B1922 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B1926
        SUBI.B  #$6400,(A0)                     ; $2B192A
        DC.W    $0220,$0210         ; $2B192E ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B1932 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B1936 ANDI.B  #$0010,D0
        BNE.W  loc_2B1B9C                       ; $2B193A
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2B193E
        ADDI.B  #$6700,(A0)                     ; $2B1944
        ANDI.L  #$02B00410,-(A0)                ; $2B1948
        BVC.W  loc_2B1C10                       ; $2B194E
        DC.W    $02D0               ; $2B1952 DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2B1954
        ANDI.W  #$0290,-(A0)                    ; $2B1958
        DC.W    $0010,$0300         ; $2B195C ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2B1960 DC.W    $02E0
        DC.W    $02F0               ; $2B1962 DC.W    $02F0
        BTST    D1,D0                           ; $2B1964
        BTST    D1,(A0)                         ; $2B1966
        DC.W    $0210,$0500         ; $2B1968 ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2B196C
        SUBI.B  #$0400,(A0)                     ; $2B1970
        BTST    D1,D0                           ; $2B1974
        DC.W    $02F0               ; $2B1976 DC.W    $02F0
        DC.W    $0010,$6500         ; $2B1978 ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2B197C
        BCHG    D1,(A0)                         ; $2B197E
        BCHG    D1,-(A0)                        ; $2B1980
        BCHG    D1,$10(A0,D0.W)                 ; $2B1982
        BLS.W  loc_2B1D18                       ; $2B1986
        BCLR    D1,D0                           ; $2B198A
        SUBI.B  #$6400,(A0)                     ; $2B198C
        BCHG    D1,-(A0)                        ; $2B1990
        BCHG    D1,(A0)                         ; $2B1992
        DC.W    $0010,$0300         ; $2B1994 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B1998
        BSET    D1,$00(A0,D0.W)                 ; $2B199A
        SUBI.B  #$0210,(A0)                     ; $2B199E
        BTST    D2,D0                           ; $2B19A2
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B19A4
        SUBI.B  #$0400,D0                       ; $2B19AA
        BSET    D1,$10(A0,D0.W)                 ; $2B19AE
        BCS.W  loc_2B1DF4                       ; $2B19B2
        SUBI.W  #$0460,(A0)                     ; $2B19B6
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B19BA
        SUBI.L  #$04800410,(A0)                 ; $2B19C0
        BCC.W  loc_2B1E28                       ; $2B19C6
        SUBI.W  #$0000,(A0)                     ; $2B19CA
        BNE.W  loc_2B1D70                       ; $2B19CE
        BCLR    D1,-$40(A0,D0.W)                ; $2B19D2
        BSET    D1,(A0)                         ; $2B19D6
        DC.W    $0000,$6600         ; $2B19D8 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B19DC
        DC.W    $04D0               ; $2B19E2 DC.W    $04D0
        CMPI.B  #$005E,D0                       ; $2B19E4
        ORI.W  #$F84A,(A6)+                     ; $2B19E8
        DC.W    $02CB               ; $2B19EC DC.W    $02CB
        ORI.W  #$F83A,A3                        ; $2B19EE
        DC.W    $02E2               ; $2B19F2 DC.W    $02E2
        MOVE.W  -$08B9(A5),-(A7)                ; $2B19F4
        SUBI.B  #$FF36,A4                       ; $2B19F8
        MOVE.W  (A3)+,$03F0(A3)                 ; $2B19FC
        ORI.L  #$F8DB0357,A5                    ; $2B1A00
        MOVE.W  -$07F3(A5),-(A7)                ; $2B1A06
        SUBI.L  #$FF36F8EC,(A3)+                ; $2B1A0A
        BCHG    D1,D0                           ; $2B1A10
        ORI.W  #$F821,A3                        ; $2B1A12
        SUBI.L  #$008DF7EE,D0                   ; $2B1A16
        SUBI.L  #$0040F765,D5                   ; $2B1A1C
        SUBI.B  #$FFE7,(A3)                     ; $2B1A22
        MOVE.W  A5,(A3)+                        ; $2B1A26
        DC.W    $04E4               ; $2B1A28 DC.W    $04E4
        DC.W    $0000,$F775         ; $2B1A2A ORI.B  #$F775,D0
        BTST    D2,$0054(A3)                    ; $2B1A2E
        MOVE.W  -(A4),-$6D(PC,D0.W)             ; $2B1A32
        MOVE.W  (A1),$6B(A7,A7.W)               ; $2B1A36
        BTST    D2,$FFA4F7A9                    ; $2B1A3A
        DC.W    $043E,$0098         ; $2B1A40 SUBI.B  #$0098,<EA:3E>
        MOVE.W  $36(A3,D0.W),-$0F(PC,D0.W)      ; $2B1A44
        MOVE.W  (A0),D4                         ; $2B1A4A
        DC.W    $02DB               ; $2B1A4C DC.W    $02DB
        BTST    D0,-$0838(PC)                   ; $2B1A4E
        DC.W    $02C3               ; $2B1A52 DC.W    $02C3
        DC.W    $00E9               ; $2B1A54 DC.W    $00E9
        MOVE.W  (A6),D4                         ; $2B1A56
        SUBI.W  #$0084,D3                       ; $2B1A58
        MOVE.W  -$38(A5,D0.W),D4                ; $2B1A5C
        DC.W    $00D3               ; $2B1A60 DC.W    $00D3
        MOVE.W  (A2),D4                         ; $2B1A62
        BTST    D1,-(A2)                        ; $2B1A64
        DC.W    $00D6               ; $2B1A66 DC.W    $00D6
        MOVE.W  $0310011D,D4                    ; $2B1A68
        MOVE.W  $024D(A7),-(A3)                 ; $2B1A6E
loc_2B1A72:
        BCHG    D0,-$31(PC,A7.W)                ; $2B1A72
        DC.W    $0235,$0148,$F845   ; $2B1A76 ANDI.B  #$0148,$45(A5,A7.L)
        DC.W    $02E0               ; $2B1A7C DC.W    $02E0
        DC.W    $00DC               ; $2B1A7E DC.W    $00DC
        MOVE.W  D2,-(A3)                        ; $2B1A80
        BSET    D0,$4E(A2,D0.W)                 ; $2B1A82
        MOVE.W  D4,(A4)                         ; $2B1A86
        DC.W    $02F6               ; $2B1A88 DC.W    $02F6
        MOVE.W  D4,-(A7)                        ; $2B1A8A
        MOVE.W  $0320(A0),(A4)                  ; $2B1A8C
        MOVE.W  -(A4),(A7)                      ; $2B1A90
        MOVE.W  D7,$33(PC,D0.W)                 ; $2B1A92
        MOVE.W  D5,(A7)+                        ; $2B1A96
loc_2B1A98:
        MOVE.W  A6,$21(A3,D0.W)                 ; $2B1A98
        MOVE.W  -$0727(A0),-(A7)                ; $2B1A9C
        DC.W    $033D               ; $2B1AA0 BTST    D1,<EA:3D>
        MOVE.W  D4,-(A7)                        ; $2B1AA2
        MOVE.W  -(A3),$67(PC,D0.W)              ; $2B1AA4
        MOVE.W  -$08A9(A0),-(A7)                ; $2B1AA8
        DC.W    $02E9               ; $2B1AAC DC.W    $02E9
        MOVE.W  D4,-(A7)                        ; $2B1AAE
        MOVE.W  -(A7),-$18(A3,D0.W)             ; $2B1AB0
        MOVE.W  $F8DD.W,(A7)                    ; $2B1AB4
        BCHG    D1,-$4F(PC,A7.L)                ; $2B1AB8
        MOVE.W  A7,(A4)+                        ; $2B1ABC
        BCLR    D1,(A3)+                        ; $2B1ABE
        MOVE.W  $79(PC,A7.W),(A7)+              ; $2B1AC0
        ANDI.L  #$FEFCF8F2,(A5)+                ; $2B1AC4
        BCHG    D1,(A0)                         ; $2B1ACA
loc_2B1ACC:
        MOVE.W  $66(A4,A7.W),(A7)+              ; $2B1ACC
        DC.W    $02FE               ; $2B1AD0 DC.W    $02FE
        MOVE.W  -$6D(A2,A7.W),(A7)+             ; $2B1AD2
        DC.W    $0206,$FEDD         ; $2B1AD6 ANDI.B  #$FEDD,D6
        MOVE.W  D2,D4                           ; $2B1ADA
        ANDI.W  #$FEDB,D7                       ; $2B1ADC
        MOVE.W  (A5),$41(PC,D0.W)               ; $2B1AE0
        MOVE.W  -$45(A0,A7.W),(A7)+             ; $2B1AE4
        BTST    D0,$7D(A2,D0.W)                 ; $2B1AE8
        MOVE.W  (A6)+,(A3)                      ; $2B1AEC
        BSET    D0,(A3)                         ; $2B1AEE
        DC.W    $013F               ; $2B1AF0 BTST    D0,<EA:3F>
        MOVE.W  A6,D4                           ; $2B1AF2
        DC.W    $0216,$013E         ; $2B1AF4 ANDI.B  #$013E,(A6)
        MOVE.W  $0174(A1),D4                    ; $2B1AF8
        ORI.W  #$F6B6,$46(PC,D0.W)              ; $2B1AFC
        MOVE.W  D0,$24(A7,A7.L)                 ; $2B1B02
        DC.W    $0189               ; $2B1B06 BCLR    D0,A1
        DC.W    $FF7F,$F64A         ; $2B1B08 MOVE.W  <EA:3F>,-$09B6(A7)
        BCLR    D1,-(A0)                        ; $2B1B0C
        MOVE.W  -$47(A4,A7.W),-$1D(A7,D0.W)     ; $2B1B0E
        MOVE.W  $72(A3,A7.W),-$33(A7,D0.W)      ; $2B1B14
        BCHG    D0,(A4)                         ; $2B1B1A
        MOVE.W  -(A1),$0F(PC,D0.W)              ; $2B1B1C
        BCHG    D0,(A2)                         ; $2B1B20
        MOVEA.W A7,A3                           ; $2B1B22
        DC.W    $038C               ; $2B1B24 BCLR    D1,A4
        DC.W    $00B1,$F7BE,$03CD,$00AF; $2B1B26 ORI.L  #$F7BE03CD,-$51(A1,D0.W)
        MOVE.W  D2,(A4)                         ; $2B1B2E
        BCLR    D0,(A1)+                        ; $2B1B30
        ORI.W  #$F882,$0199(A1)                 ; $2B1B32
        MOVE.W  A1,-(A7)                        ; $2B1B38
        MOVE.W  $031CFF28,D4                    ; $2B1B3A
        MOVE.W  $031C0049,D4                    ; $2B1B40
        MOVE.W  -$45(A7,D0.W),-(A4)             ; $2B1B46
        MOVE.W  A1,-(A7)                        ; $2B1B4A
        MOVE.W  $033E(A7),(A4)+                 ; $2B1B4C
        MOVE.W  -$06C9(A0),-(A7)                ; $2B1B50
        BCLR    D0,$69(PC,D0.W)                 ; $2B1B54
        MOVE.W  $033E(A7),(A4)+                 ; $2B1B58
        ORI.W  #$F752,A1                        ; $2B1B5C
        BCLR    D0,-(A4)                        ; $2B1B60
        ORI.W  #$F7B6,$50(A7,D0.W)              ; $2B1B62
        DC.W    $00E5               ; $2B1B68 DC.W    $00E5
        MOVE.W  D3,$01E6(A4)                    ; $2B1B6A
        DC.W    $FFF1,$F8E0         ; $2B1B6E MOVE.W  -$20(A1,A7.L),<EA:3F>
        DC.W    $023A,$FF84,$F77D   ; $2B1B72 ANDI.B  #$FF84,-$0883(PC)
        BSET    D0,-$15(A0,D0.W)                ; $2B1B78
        MOVE.W  A3,-(A4)                        ; $2B1B7C
        ANDI.L  #$FFF8F79D,D6                   ; $2B1B7E
        DC.W    $001F,$0174         ; $2B1B84 ORI.B  #$0174,(A7)+
        MOVE.W  A4,D4                           ; $2B1B88
        ORI.W  #$0176,D0                        ; $2B1B8A
        MOVE.W  $019D(A1),-$49(A3,D0.W)         ; $2B1B8E
        MOVE.W  $7C(PC,D0.W),-(A3)              ; $2B1B94
        DC.W    $00B5,$F7BC,$0056,$01C7; $2B1B98 ORI.L  #$F7BC0056,-$39(A5,D0.W)
        MOVE.W  (A1)+,$01B3(A3)                 ; $2B1BA0
        BTST    D0,D7                           ; $2B1BA4
        MOVE.W  $0024(A3),(A3)+                 ; $2B1BA6
        BCHG    D0,$F6EB.W                      ; $2B1BAA
        DC.W    $FFEA,$0178         ; $2B1BAE MOVE.W  $0178(A2),<EA:3F>
        MOVE.W  A2,D4                           ; $2B1BB2
        DC.W    $FFEA,$0178         ; $2B1BB4 MOVE.W  $0178(A2),<EA:3F>
        MOVE.W  A2,D4                           ; $2B1BB8
        ORI.W  #$0178,D6                        ; $2B1BBA
        MOVE.W  A5,(A4)                         ; $2B1BBE
        DC.W    $01FE               ; $2B1BC0 BSET    D0,<EA:3E>
        DC.W    $FFD5               ; $2B1BC2 MOVE.W  (A5),<EA:3F>
        MOVE.W  A6,-(A4)                        ; $2B1BC4
        DC.W    $0233,$FF74,$F979   ; $2B1BC6 ANDI.B  #$FF74,$79(A3,A7.L)
        ORI.W  #$FF08,-(A3)                     ; $2B1BCC
        MOVE.W  $002EFF6A,(A4)+                 ; $2B1BD0
        MOVEA.W $0217(A3),A4                    ; $2B1BD6
        MOVE.W  A3,-$0728(A7)                   ; $2B1BDA
        ORI.W  #$FEDF,D6                        ; $2B1BDE
        DC.W    $F93D               ; $2B1BE2 MOVE.W  <EA:3D>,-(A4)
        DC.W    $FFF7,$FF3A         ; $2B1BE4 MOVE.W  $3A(A7,A7.L),<EA:3F>
        MOVE.W  (A6)+,-(A4)                     ; $2B1BE8
        ORI.W  #$FF1E,-(A3)                     ; $2B1BEA
        MOVE.W  -(A5),(A5)                      ; $2B1BEE
        DC.W    $00BF,$FECF,$FAC4   ; $2B1BF0 ORI.L  #$FECFFAC4,<EA:3F>
        ORI.W  #$FEEB,(A3)                      ; $2B1BF6
        MOVE.W  -(A4),-(A4)                     ; $2B1BFA
        DC.W    $0008,$FED7         ; $2B1BFC ORI.B  #$FED7,A0
        MOVE.W  $0065(A5),(A5)                  ; $2B1C00
        MOVE.W  A0,(A7)                         ; $2B1C04
        MOVE.W  A6,(A5)                         ; $2B1C06
        MOVE.W  (A7)+,-$36(A7,A7.L)             ; $2B1C08
        MOVE.W  A0,(A5)+                        ; $2B1C0C
        MOVE.W  (A4),-$36(A7,A7.L)              ; $2B1C0E
        DC.W    $FAFE               ; $2B1C12 MOVE.W  <EA:3E>,(A5)+
        DC.W    $00AD,$FECA,$FAA3,$00BF; $2B1C14 ORI.L  #$FECAFAA3,$00BF(A5)
        MOVE.W  A2,(A7)+                        ; $2B1C1C
        DC.W    $0010,$0500         ; $2B1C1E ORI.B  #$0500,(A0)
        ANDI.W  #$0270,-(A0)                    ; $2B1C22
        ANDI.L  #$02900210,D0                   ; $2B1C26
        ADDI.B  #$0310,D0                       ; $2B1C2C
        BTST    D1,D0                           ; $2B1C30
        SUBI.B  #$0500,(A0)                     ; $2B1C32
        BCHG    D1,(A0)                         ; $2B1C36
        BCHG    D1,D0                           ; $2B1C38
        SUBI.B  #$0600,(A0)                     ; $2B1C3A
        BTST    D1,$20(A0,D0.W)                 ; $2B1C3E
        SUBI.B  #$0500,(A0)                     ; $2B1C42
        DC.W    $02C0               ; $2B1C46 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2B1C48 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2B1C50 DC.W    $02D0
        DC.W    $0210,$0600         ; $2B1C52 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2B1C56
        BTST    D2,D0                           ; $2B1C5C
        DC.W    $02F0               ; $2B1C5E DC.W    $02F0
        DC.W    $02E0               ; $2B1C60 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2B1C62
        BCHG    D1,(A0)                         ; $2B1C66
        BTST    D1,(A0)                         ; $2B1C68
        DC.W    $0210,$0300         ; $2B1C6A ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2B1C6E
        ADDI.B  #$0270,D0                       ; $2B1C74
        DC.W    $02E0               ; $2B1C78 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2B1C7A
        ANDI.W  #$0300,-(A0)                    ; $2B1C7E
        DC.W    $0210,$0300         ; $2B1C82 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2B1C86
        ANDI.L  #$04100300,-(A0)                ; $2B1C88
        BTST    D1,-(A0)                        ; $2B1C8E
        DC.W    $02B0,$0010,$6E00,$0000; $2B1C90 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2B1C98 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2B1C9C ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2B1CA2
        SUBI.B  #$7000,(A0)                     ; $2B1CA6
        ORI.W  #$0070,-(A0)                     ; $2B1CAA
        SUBI.B  #$6F00,(A0)                     ; $2B1CAE
        DC.W    $0000,$0030         ; $2B1CB2 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B1CB6 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B1CBA ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B1CBE ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B1CC2
        DC.W    $00B0,$0210,$0400,$00D0; $2B1CC8 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B1CD0 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B1CD2
        ORI.L  #$00900611,-(A0)                 ; $2B1CD6
        BTST    D3,D1                           ; $2B1CDC
        DC.W    $00B0,$0010,$6A00,$00E0; $2B1CDE ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B1CE6 DC.W    $00F0
        BTST    D0,D0                           ; $2B1CE8
        BTST    D0,(A0)                         ; $2B1CEA
        DC.W    $0210,$6C00         ; $2B1CEC ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B1CF0
        SUBI.B  #$6B00,(A0)                     ; $2B1CF4
        BTST    D0,D0                           ; $2B1CF8
        DC.W    $00F0               ; $2B1CFA DC.W    $00F0
        DC.W    $0211,$6901         ; $2B1CFC ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B1D00 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B1D02 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B1D06
        BCHG    D0,(A0)                         ; $2B1D08
        BCHG    D0,-(A0)                        ; $2B1D0A
        BCHG    D0,$10(A0,D0.W)                 ; $2B1D0C
        BCS.W  loc_2B1EA2                       ; $2B1D10
        BCLR    D0,D0                           ; $2B1D14
        SUBI.B  #$6400,(A0)                     ; $2B1D16
        BCHG    D0,-(A0)                        ; $2B1D1A
        BCHG    D0,(A0)                         ; $2B1D1C
        ADDI.B  #$6201,(A1)                     ; $2B1D1E
        BCHG    D0,$10(A0,D0.W)                 ; $2B1D22
        BPL.W  loc_2B1EC8                       ; $2B1D26
        BCLR    D0,-$40(A0,D0.W)                ; $2B1D2A
        BSET    D0,(A0)                         ; $2B1D2E
        DC.W    $0210,$6C00         ; $2B1D30 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B1D34
        SUBI.B  #$6B00,(A0)                     ; $2B1D38
        BSET    D0,D0                           ; $2B1D3C
        BCLR    D0,$11(A0,D0.W)                 ; $2B1D3E
        BVS.S  loc_2B1D45                       ; $2B1D42
        BSET    D0,(A0)                         ; $2B1D44
        DC.W    $0010,$6300         ; $2B1D46 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B1D4A ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B1D4E ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B1D52 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B1D56
        SUBI.B  #$6400,(A0)                     ; $2B1D5A
        DC.W    $0220,$0210         ; $2B1D5E ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B1D62 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B1D66 ANDI.B  #$0010,D0
        BNE.W  loc_2B20CC                       ; $2B1D6A
        BCHG    D1,-$80(A0,D0.W)                ; $2B1D6E
        BCLR    D1,(A0)                         ; $2B1D72
        ADDI.B  #$6700,(A0)                     ; $2B1D74
        BCLR    D1,-(A0)                        ; $2B1D78
        BCLR    D1,$10(A0,D0.W)                 ; $2B1D7A
        BVC.W  loc_2B2140                       ; $2B1D7E
        BSET    D1,(A0)                         ; $2B1D82
        SUBI.B  #$6700,(A0)                     ; $2B1D84
        BCHG    D1,-(A0)                        ; $2B1D88
        BCLR    D1,(A0)                         ; $2B1D8A
        DC.W    $0010,$0300         ; $2B1D8C ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B1D90
        BSET    D1,$00(A0,D0.W)                 ; $2B1D92
        SUBI.B  #$0210,(A0)                     ; $2B1D96
        BTST    D2,D0                           ; $2B1D9A
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B1D9C
        SUBI.B  #$0400,D0                       ; $2B1DA2
        BSET    D1,$10(A0,D0.W)                 ; $2B1DA6
        BCS.W  loc_2B21EC                       ; $2B1DAA
        SUBI.W  #$0460,(A0)                     ; $2B1DAE
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B1DB2
        SUBI.L  #$04800410,(A0)                 ; $2B1DB8
        BCC.W  $2B2220                          ; $2B1DBE
        SUBI.W  #$0010,(A0)                     ; $2B1DC2
        BTST    D1,D0                           ; $2B1DC6
        DC.W    $04E0               ; $2B1DC8 DC.W    $04E0
        DC.W    $04F0               ; $2B1DCA DC.W    $04F0
        BTST    D2,D0                           ; $2B1DCC
        BTST    D2,(A0)                         ; $2B1DCE
        DC.W    $0210,$0500         ; $2B1DD0 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2B1DD4
        SUBI.B  #$0400,(A0)                     ; $2B1DD8
        BTST    D2,D0                           ; $2B1DDC
        DC.W    $04F0               ; $2B1DDE DC.W    $04F0
        DC.W    $0010,$6500         ; $2B1DE0 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2B1DE4
        BCHG    D2,(A0)                         ; $2B1DE6
        BCHG    D2,-(A0)                        ; $2B1DE8
        BCHG    D2,$10(A0,D0.W)                 ; $2B1DEA
        BLS.W  $2B2380                          ; $2B1DEE
        BCLR    D2,D0                           ; $2B1DF2
loc_2B1DF4:
        SUBI.B  #$6400,(A0)                     ; $2B1DF4
        BCHG    D2,-(A0)                        ; $2B1DF8
        BCHG    D2,(A0)                         ; $2B1DFA
        DC.W    $0000,$6600         ; $2B1DFC ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B1E00
        DC.W    $04D0               ; $2B1E06 DC.W    $04D0
        DC.W    $0000,$6600         ; $2B1E08 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2B1E0C
        BCLR    D2,-$40(A0,D0.W)                ; $2B1E0E
        BSET    D2,(A0)                         ; $2B1E12
        CMPI.B  #$005E,D0                       ; $2B1E14
        ORI.W  #$F7ED,(A6)+                     ; $2B1E18
        BTST    D1,-(A5)                        ; $2B1E1C
        DC.W    $FFD3               ; $2B1E1E MOVE.W  (A3),<EA:3F>
        MOVE.W  $0331(A4),D4                    ; $2B1E20
        MOVE.W  $50(PC,A7.W),(A7)               ; $2B1E24
loc_2B1E28:
        SUBI.W  #$FE79,-(A6)                    ; $2B1E28
        MOVE.W  D6,-(A3)                        ; $2B1E2C
        SUBI.W  #$FFCA,(A0)+                    ; $2B1E2E
        MOVE.W  A4,(A4)+                        ; $2B1E32
        BCLR    D1,(A6)+                        ; $2B1E34
        MOVE.W  -(A3),(A7)+                     ; $2B1E36
        MOVE.W  (A7),D4                         ; $2B1E38
        DC.W    $04EB               ; $2B1E3A DC.W    $04EB
        MOVE.W  -$0771(A2),(A7)                 ; $2B1E3C
        BCLR    D1,(A2)                         ; $2B1E40
        DC.W    $FFFC,$F7CC         ; $2B1E42 MOVE.W  #$F7CC,<EA:3F>
        DC.W    $04DE               ; $2B1E46 DC.W    $04DE
        DC.W    $FFFC,$F7B0         ; $2B1E48 MOVE.W  #$F7B0,<EA:3F>
        DC.W    $04E2               ; $2B1E4C DC.W    $04E2
        MOVE.W  -(A4),$3E(A7,A7.W)              ; $2B1E4E
        SUBI.W  #$FF2D,-$4E(A3,A7.W)            ; $2B1E52
        DC.W    $054C               ; $2B1E58 BCHG    D2,A4
        MOVE.W  (A6),-(A7)                      ; $2B1E5A
        MOVE.W  D0,$058E(A3)                    ; $2B1E5C
        MOVE.W  (A3),-$29(A7,A7.W)              ; $2B1E60
        DC.W    $04E9               ; $2B1E64 DC.W    $04E9
        MOVE.W  $67(A7,A7.W),(A7)+              ; $2B1E66
        BCLR    D2,(A5)                         ; $2B1E6A
        MOVE.W  -(A6),(A7)+                     ; $2B1E6C
        MOVE.W  A1,$048D(A3)                    ; $2B1E6E
        DC.W    $FFEB,$F77A         ; $2B1E72 MOVE.W  -$0886(A3),<EA:3F>
        SUBI.L  #$0052F7B9,A5                   ; $2B1E76
        BTST    D1,$00A3.W                      ; $2B1E7C
        MOVE.W  A6,$19(A3,D0.W)                 ; $2B1E80
        ORI.W  #$F7B5,D2                        ; $2B1E84
        SUBI.L  #$FFF2F7FA,-(A2)                ; $2B1E88
        BTST    D1,$0049(A7)                    ; $2B1E8E
        MOVE.W  $038D(A3),$44(PC,D0.W)          ; $2B1E92
        MOVE.W  $77(A5,D0.W),-$6C(PC,D0.W)      ; $2B1E98
        DC.W    $F6BF               ; $2B1E9E MOVE.W  <EA:3F>,(A3)
        DC.W    $02E4               ; $2B1EA0 DC.W    $02E4
loc_2B1EA2:
        ORI.L  #$F67202DB,(A0)                  ; $2B1EA2
        ORI.W  #$F80E,D0                        ; $2B1EA8
        BCHG    D1,D3                           ; $2B1EAC
        ORI.W  #$F695,(A1)+                     ; $2B1EAE
        ANDI.L  #$0053F85E,(A1)                 ; $2B1EB2
        BTST    D1,-$7C(A2,A7.L)                ; $2B1EB8
        MOVE.W  -(A2),(A4)                      ; $2B1EBC
        BCHG    D1,(A1)+                        ; $2B1EBE
        MOVE.W  -$14(A5,A7.W),D7                ; $2B1EC0
        SUBI.L  #$FE2FF797,A4                   ; $2B1EC4
        SUBI.L  #$FE7CF8B9,D0                   ; $2B1ECA
        BCHG    D1,-$0160(A1)                   ; $2B1ED0
        MOVE.W  -$49(A3,D0.W),-$67(PC,A7.L)     ; $2B1ED4
        DC.W    $F73E               ; $2B1EDA MOVE.W  <EA:3E>,-(A3)
        BCHG    D1,(A6)                         ; $2B1EDC
        MOVE.W  -$60(A1,A7.W),D7                ; $2B1EDE
        DC.W    $034B               ; $2B1EE2 BCHG    D1,A3
        DC.W    $FDFD               ; $2B1EE4 MOVE.W  <EA:3D>,<EA:3E>
        MOVE.W  (A6)+,(A4)+                     ; $2B1EE6
        BCLR    D1,-$01A9(A0)                   ; $2B1EE8
        MOVE.W  D0,(A4)+                        ; $2B1EEC
        DC.W    $03C8               ; $2B1EEE BSET    D1,A0
        MOVE.W  (A5)+,(A7)                      ; $2B1EF0
        MOVE.W  (A7),$0306(A3)                  ; $2B1EF2
        MOVE.W  -$0727(A5),D7                   ; $2B1EF6
        BCHG    D1,$FE9A.W                      ; $2B1EFA
        MOVEA.W -(A5),A3                        ; $2B1EFE
        BCLR    D1,-(A2)                        ; $2B1F00
        MOVE.W  (A1),D7                         ; $2B1F02
        MOVEA.W -(A2),A3                        ; $2B1F04
        ANDI.L  #$FDF1F7D2,-(A6)                ; $2B1F06
        ANDI.L  #$FE27F7D5,(A3)+                ; $2B1F0C
        BCLR    D1,(A7)                         ; $2B1F12
        MOVEA.W A0,A7                           ; $2B1F14
        MOVE.W  (A7)+,D3                        ; $2B1F16
        DC.W    $01BE               ; $2B1F18 BCLR    D0,<EA:3E>
        MOVE.W  D4,$06(A7,A7.W)                 ; $2B1F1A
        ANDI.W  #$004A,(A2)+                    ; $2B1F1E
        MOVE.W  $4F(A6,D0.W),$0081(A3)          ; $2B1F22
        MOVE.W  (A0),-$4D(A3,D0.W)              ; $2B1F28
        MOVE.W  $45(PC,A7.W),-$22(A7,D0.W)      ; $2B1F2C
        MOVE.W  A3,(A7)                         ; $2B1F32
        MOVE.W  -$2E(A6,D0.W),-$3F(A3,A7.L)     ; $2B1F34
        MOVEA.W A3,A3                           ; $2B1F3A
        DC.W    $043E,$FED9         ; $2B1F3C SUBI.B  #$FED9,<EA:3E>
        MOVE.W  #$0434,$10(A3,A7.L)             ; $2B1F40
        MOVE.W  A1,D3                           ; $2B1F46
        BCHG    D1,(A7)                         ; $2B1F48
        ORI.W  #$F779,$034B(A2)                 ; $2B1F4A
        ORI.L  #$F625041E,-(A1)                 ; $2B1F50
        DC.W    $FFD1               ; $2B1F56 MOVE.W  (A1),<EA:3F>
        MOVE.W  (A6),$14(A3,D0.W)               ; $2B1F58
        DC.W    $0008,$F84F         ; $2B1F5C ORI.B  #$F84F,A0
        BSET    D0,$0028(A2)                    ; $2B1F60
        MOVE.W  -$31(A5,D0.W),(A4)              ; $2B1F64
        MOVE.W  (A0)+,(A7)+                     ; $2B1F68
        MOVE.W  $43(A5,D0.W),D4                 ; $2B1F6A
        MOVE.W  -$1F(A5,A7.W),(A7)              ; $2B1F6E
        BCHG    D1,(A2)+                        ; $2B1F72
        DC.W    $FFC9               ; $2B1F74 MOVE.W  A1,<EA:3F>
        MOVE.W  (A6)+,$020E(A4)                 ; $2B1F76
        MOVE.W  D6,-(A7)                        ; $2B1F7A
        MOVE.W  (A5)+,(A4)+                     ; $2B1F7C
        BCLR    D1,D2                           ; $2B1F7E
        MOVE.W  -(A3),(A7)+                     ; $2B1F80
        MOVE.W  $28(A7,D0.W),(A4)+              ; $2B1F82
        ORI.W  #$F889,(A7)                      ; $2B1F86
        BCLR    D1,(A0)+                        ; $2B1F8A
        DC.W    $FFF7,$F736         ; $2B1F8C MOVE.W  $36(A7,A7.W),<EA:3F>
        BSET    D0,$5C(A1,A7.L)                 ; $2B1F90
        MOVE.W  (A6)+,$0185(A3)                 ; $2B1F94
        DC.W    $FFD8               ; $2B1F98 MOVE.W  (A0)+,<EA:3F>
        MOVE.W  (A6)+,-(A4)                     ; $2B1F9A
        ANDI.W  #$FFF3,D6                       ; $2B1F9C
        MOVE.W  -$4D(A6,D0.W),(A4)+             ; $2B1FA0
        MOVE.W  $1A(A6,A7.W),$0220(A7)          ; $2B1FA4
        DC.W    $FFE2               ; $2B1FAA MOVE.W  -(A2),<EA:3F>
        MOVE.W  (A2)+,(A4)+                     ; $2B1FAC
        DC.W    $02E2               ; $2B1FAE DC.W    $02E2
        DC.W    $FFFD               ; $2B1FB0 MOVE.W  <EA:3D>,<EA:3F>
        MOVE.W  A4,$4C(PC,D0.W)                 ; $2B1FB2
        DC.W    $0022,$F818         ; $2B1FB6 ORI.B  #$F818,-(A2)
        ORI.L  #$0050F746,(A5)                  ; $2B1FBA
        BSET    D0,(A2)                         ; $2B1FC0
        MOVE.W  $F6FA.W,-$76(A7,D0.W)           ; $2B1FC2
        MOVE.W  A2,-$48(A7,A7.W)                ; $2B1FC8
        ORI.W  #$0082,-$091A(A5)                ; $2B1FCC
        BCLR    D0,-$0017(A3)                   ; $2B1FD2
        MOVE.W  (A5)+,-(A3)                     ; $2B1FD6
        ORI.W  #$FFC5,$F71D.W                   ; $2B1FD8
        DC.W    $003D,$FFC5         ; $2B1FDE ORI.B  #$FFC5,<EA:3D>
        MOVE.W  (A7),D4                         ; $2B1FE2
        DC.W    $003D,$0051         ; $2B1FE4 ORI.B  #$0051,<EA:3D>
        MOVE.W  (A7),D4                         ; $2B1FE8
        ORI.L  #$0051F8A6,(A2)+                 ; $2B1FEA
        ANDI.L  #$FFA4F93C,(A6)                 ; $2B1FF0
        ANDI.W  #$FF67,-(A4)                    ; $2B1FF6
        MOVEA.W $00CC(A4),A4                    ; $2B1FFA
        MOVE.W  $F7D50100,(A7)                  ; $2B1FFE
        MOVE.W  -$3D(A6,A7.L),(A7)+             ; $2B2004
        DC.W    $02C1               ; $2B2008 DC.W    $02C1
        MOVE.W  (A5)+,-(A7)                     ; $2B200A
        MOVE.W  $2B(A3,D0.W),$6F(PC,A7.L)       ; $2B200C
        MOVE.W  -$5F(A1,D0.W),-$38(PC,A7.L)     ; $2B2012
        MOVE.W  -(A3),D4                        ; $2B2018
        DC.W    $0109               ; $2B201A BTST    D0,A1
        DC.W    $FEBD               ; $2B201C MOVE.W  <EA:3D>,(A7)
        MOVE.W  (A5),$58(A4,D0.W)               ; $2B201E
        MOVE.W  (A3),(A7)+                      ; $2B2022
        MOVE.W  -(A3),-$000F(A4)                ; $2B2024
        MOVE.W  -(A0),(A7)+                     ; $2B2028
        MOVE.W  D6,D4                           ; $2B202A
        DC.W    $00C0               ; $2B202C DC.W    $00C0
        MOVEA.W -$0689(A0),A7                   ; $2B202E
        DC.W    $000F,$FE7F         ; $2B2032 ORI.B  #$FE7F,A7
        MOVE.W  $7B(A2,A7.L),(A4)+              ; $2B2036
        MOVEA.W $1D(A4,A7.L),A7                 ; $2B203A
        MOVE.W  (A3),-$018C(A7)                 ; $2B203E
        MOVE.W  (A7),#$0019                     ; $2B2042
        MOVE.W  (A0),(A7)+                      ; $2B2046
        MOVE.W  (A3),$59(A4,D0.W)               ; $2B2048
        MOVE.W  (A0),(A7)+                      ; $2B204C
        DC.W    $0010,$0500         ; $2B204E ORI.B  #$0500,(A0)
        ANDI.W  #$0270,-(A0)                    ; $2B2052
        ANDI.L  #$02900210,D0                   ; $2B2056
        ADDI.B  #$0310,D0                       ; $2B205C
        BTST    D1,D0                           ; $2B2060
        SUBI.B  #$0500,(A0)                     ; $2B2062
        BCHG    D1,(A0)                         ; $2B2066
        BCHG    D1,D0                           ; $2B2068
        SUBI.B  #$0600,(A0)                     ; $2B206A
        BTST    D1,$20(A0,D0.W)                 ; $2B206E
        SUBI.B  #$0500,(A0)                     ; $2B2072
        DC.W    $02C0               ; $2B2076 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2B2078 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2B2080 DC.W    $02D0
        DC.W    $0210,$0600         ; $2B2082 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2B2086
        BTST    D2,D0                           ; $2B208C
        DC.W    $02F0               ; $2B208E DC.W    $02F0
        DC.W    $02E0               ; $2B2090 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2B2092
        BCHG    D1,(A0)                         ; $2B2096
        BTST    D1,(A0)                         ; $2B2098
        DC.W    $0210,$0300         ; $2B209A ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2B209E
        ADDI.B  #$0270,D0                       ; $2B20A4
        DC.W    $02E0               ; $2B20A8 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2B20AA
        ANDI.W  #$0300,-(A0)                    ; $2B20AE
        DC.W    $0210,$0300         ; $2B20B2 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2B20B6
        ANDI.L  #$04100300,-(A0)                ; $2B20B8
        BTST    D1,-(A0)                        ; $2B20BE
        DC.W    $02B0,$0010,$6E00,$0000; $2B20C0 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2B20C8 ORI.B  #$0020,(A0)
loc_2B20CC:
        DC.W    $0030,$0610,$6F00   ; $2B20CC ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2B20D2
        SUBI.B  #$7000,(A0)                     ; $2B20D6
        ORI.W  #$0070,-(A0)                     ; $2B20DA
        SUBI.B  #$6F00,(A0)                     ; $2B20DE
        DC.W    $0000,$0030         ; $2B20E2 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B20E6 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B20EA ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B20EE ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B20F2
        DC.W    $00B0,$0210,$0400,$00D0; $2B20F8 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B2100 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B2102
        ORI.L  #$00900611,-(A0)                 ; $2B2106
        BTST    D3,D1                           ; $2B210C
        DC.W    $00B0,$0010,$6A00,$00E0; $2B210E ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B2116 DC.W    $00F0
        BTST    D0,D0                           ; $2B2118
        BTST    D0,(A0)                         ; $2B211A
        DC.W    $0210,$6C00         ; $2B211C ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B2120
        SUBI.B  #$6B00,(A0)                     ; $2B2124
        BTST    D0,D0                           ; $2B2128
        DC.W    $00F0               ; $2B212A DC.W    $00F0
        DC.W    $0211,$6901         ; $2B212C ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B2130 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B2132 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B2136
        BCHG    D0,(A0)                         ; $2B2138
        BCHG    D0,-(A0)                        ; $2B213A
        BCHG    D0,$10(A0,D0.W)                 ; $2B213C
loc_2B2140:
        BCS.W  $2B22D2                          ; $2B2140
        BCLR    D0,D0                           ; $2B2144
        SUBI.B  #$6400,(A0)                     ; $2B2146
        BCHG    D0,-(A0)                        ; $2B214A
        BCHG    D0,(A0)                         ; $2B214C
        ADDI.B  #$6201,(A1)                     ; $2B214E
        BCHG    D0,$10(A0,D0.W)                 ; $2B2152
        BPL.W  $2B22F8                          ; $2B2156
        BCLR    D0,-$40(A0,D0.W)                ; $2B215A
        BSET    D0,(A0)                         ; $2B215E
        DC.W    $0210,$6C00         ; $2B2160 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B2164
        SUBI.B  #$6B00,(A0)                     ; $2B2168
        BSET    D0,D0                           ; $2B216C
        BCLR    D0,$11(A0,D0.W)                 ; $2B216E
        BVS.S  loc_2B2175                       ; $2B2172
        BSET    D0,(A0)                         ; $2B2174
        DC.W    $0010,$6300         ; $2B2176 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B217A ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B217E ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B2182 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B2186
        SUBI.B  #$6400,(A0)                     ; $2B218A
        DC.W    $0220,$0210         ; $2B218E ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B2192 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B2196 ANDI.B  #$0010,D0
        BNE.W  $2B24FC                          ; $2B219A
        BCHG    D1,-$80(A0,D0.W)                ; $2B219E
        BCLR    D1,(A0)                         ; $2B21A2
        ADDI.B  #$6700,(A0)                     ; $2B21A4
        BCLR    D1,-(A0)                        ; $2B21A8
        BCLR    D1,$10(A0,D0.W)                 ; $2B21AA
        BVC.W  $2B2570                          ; $2B21AE
        BSET    D1,(A0)                         ; $2B21B2
        SUBI.B  #$6700,(A0)                     ; $2B21B4
        BCHG    D1,-(A0)                        ; $2B21B8
        BCLR    D1,(A0)                         ; $2B21BA
        DC.W    $0010,$0300         ; $2B21BC ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B21C0
        BSET    D1,$00(A0,D0.W)                 ; $2B21C2
        SUBI.B  #$0210,(A0)                     ; $2B21C6
        BTST    D2,D0                           ; $2B21CA
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B21CC
        SUBI.B  #$0400,D0                       ; $2B21D2
        BSET    D1,$10(A0,D0.W)                 ; $2B21D6
        BCS.W  $2B261C                          ; $2B21DA
        SUBI.W  #$0460,(A0)                     ; $2B21DE
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B21E2
        SUBI.L  #$04800410,(A0)                 ; $2B21E8
        BCC.W  $2B2650                          ; $2B21EE
        SUBI.W  #$0010,(A0)                     ; $2B21F2
        BTST    D1,D0                           ; $2B21F6
        DC.W    $04E0               ; $2B21F8 DC.W    $04E0
        DC.W    $04F0               ; $2B21FA DC.W    $04F0
        BTST    D2,D0                           ; $2B21FC
        BTST    D2,(A0)                         ; $2B21FE
