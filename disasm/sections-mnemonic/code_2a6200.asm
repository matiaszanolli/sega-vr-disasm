; Generated assembly for $2A6200-$2A8200
; Branch targets: 67
; Labels: 64
; Format: DC.W with decoded mnemonics as comments

        org     $2A6200

        BCC.W  loc_2A6242                       ; $2A6200
        ORI.W  #$0060,(A0)                      ; $2A6204
        ORI.W  #$0000,$00(A0,D6.L)              ; $2A6208
        ORI.L  #$009000A0,D0                    ; $2A620E
        DC.W    $00B0,$0000,$6400,$00C0; $2A6214 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A621C DC.W    $00D0
        DC.W    $00E0               ; $2A621E DC.W    $00E0
        DC.W    $00F0               ; $2A6220 DC.W    $00F0
        DC.W    $0000,$6B00         ; $2A6222 ORI.B  #$6B00,D0
        BTST    D0,D0                           ; $2A6226
        BTST    D0,(A0)                         ; $2A6228
        BTST    D0,-(A0)                        ; $2A622A
        BTST    D0,$00(A0,D0.W)                 ; $2A622C
        BCC.W  loc_2A6372                       ; $2A6230
        BCHG    D0,(A0)                         ; $2A6234
        BCHG    D0,-(A0)                        ; $2A6236
        BCHG    D0,$00(A0,D0.W)                 ; $2A6238
        BEQ.W  loc_2A63BE                       ; $2A623C
        BCLR    D0,(A0)                         ; $2A6240
loc_2A6242:
        BCLR    D0,-(A0)                        ; $2A6242
        BCLR    D0,$00(A0,D0.W)                 ; $2A6244
        SUBI.B  #$01C0,D0                       ; $2A6248
        BSET    D0,(A0)                         ; $2A624C
        BSET    D0,-(A0)                        ; $2A624E
        BSET    D0,$00(A0,D0.W)                 ; $2A6250
        BCC.W  loc_2A6456                       ; $2A6254
        DC.W    $0210,$0220         ; $2A6258 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$0400   ; $2A625C ANDI.B  #$0000,$00(A0,D0.W)
        ANDI.W  #$0250,D0                       ; $2A6262
        ANDI.W  #$0270,-(A0)                    ; $2A6266
        DC.W    $0000,$6400         ; $2A626A ORI.B  #$6400,D0
        ANDI.L  #$029002A0,D0                   ; $2A626E
        DC.W    $02B0,$0C00,$002C,$002C; $2A6274 ANDI.L  #$0C00002C,$2C(A0,D0.W)
        MOVE.W  A6,$1A(PC,D0.W)                 ; $2A627C
        DC.W    $00C1               ; $2A6280 DC.W    $00C1
        MOVE.W  (A2)+,(A4)+                     ; $2A6282
        DC.W    $0221,$FF72         ; $2A6284 ANDI.B  #$FF72,-(A1)
        MOVE.W  -$39(A3,D0.W),-$008E(A4)        ; $2A6288
        MOVEA.W $03BF(A0),A4                    ; $2A628E
        DC.W    $00C1               ; $2A6292 DC.W    $00C1
        MOVE.W  (A1)+,-(A3)                     ; $2A6294
        BSET    D1,-(A3)                        ; $2A6296
        DC.W    $007C,$F7C1,$0347   ; $2A6298 ORI.W  #$F7C1,#$0347
        DC.W    $FFC2               ; $2A629E MOVE.W  D2,<EA:3F>
        MOVE.W  $03C8FFC2,D4                    ; $2A62A0
        MOVE.W  (A1),$65(A3,D0.W)               ; $2A62A6
        DC.W    $007C,$F7FC,$0376   ; $2A62AA ORI.W  #$F7FC,#$0376
        MOVE.W  -(A1),-$0772(A7)                ; $2A62B0
        DC.W    $022E,$FEC4,$F8F5   ; $2A62B4 ANDI.B  #$FEC4,-$070B(A6)
        ANDI.W  #$FECB,(A0)+                    ; $2A62BA
        MOVEA.W -(A4),A4                        ; $2A62BE
        BCLR    D1,-(A1)                        ; $2A62C0
        MOVE.W  -$0733(A0),$0247(A7)            ; $2A62C2
        MOVE.W  (A4)+,-(A7)                     ; $2A62C8
        MOVE.W  D7,$63(A3,D0.W)                 ; $2A62CA
        MOVE.W  -$084C(A5),(A7)                 ; $2A62CE
        BTST    D0,-(A7)                        ; $2A62D2
        MOVE.W  -(A2),(A7)                      ; $2A62D4
        MOVE.W  $0C(PC,D0.W),(A4)+              ; $2A62D6
        MOVE.W  (A1),-(A7)                      ; $2A62DA
        MOVE.W  $0394(A4),D4                    ; $2A62DC
        BTST    D0,-$07E0(A3)                   ; $2A62E0
        DC.W    $0218,$00C9         ; $2A62E4 ANDI.B  #$00C9,(A0)+
        MOVE.W  (A0),(A4)                       ; $2A62E8
        DC.W    $0216,$00C4         ; $2A62EA ANDI.B  #$00C4,(A6)
        MOVE.W  (A3)+,(A4)                      ; $2A62EE
        BCLR    D1,(A2)                         ; $2A62F0
        BTST    D0,-(A5)                        ; $2A62F2
        MOVEA.W (A4)+,A4                        ; $2A62F4
        DC.W    $0227,$011B         ; $2A62F6 ANDI.B  #$011B,-(A7)
        MOVE.W  (A7),-(A3)                      ; $2A62FA
        BTST    D0,$00E2(A5)                    ; $2A62FC
        MOVE.W  D5,$00F1(A3)                    ; $2A6300
        DC.W    $00E0               ; $2A6304 DC.W    $00E0
        MOVE.W  A2,(A4)                         ; $2A6306
        BSET    D0,$0118(A4)                    ; $2A6308
        MOVE.W  $0235(A2),(A4)+                 ; $2A630C
        ORI.L  #$F9E3010A,(A1)                  ; $2A6310
        MOVE.W  (A4),-$058D(A7)                 ; $2A6316
        BCLR    D0,D2                           ; $2A631A
        MOVE.W  (A4),-$0686(A7)                 ; $2A631C
        DC.W    $02AD,$0091,$F9BA,$014E; $2A6320 ANDI.L  #$0091F9BA,$014E(A5)
        ORI.L  #$FA3DFFF6,A6                    ; $2A6328
        DC.W    $002C,$FACD,$0026   ; $2A632E ORI.B  #$FACD,$0026(A4)
        DC.W    $003E,$FA4B         ; $2A6334 ORI.B  #$FA4B,<EA:3E>
        BCLR    D0,D1                           ; $2A6338
        ORI.L  #$FA61FFAF,-(A0)                 ; $2A633A
        DC.W    $00B2,$FC20,$0087,$0083; $2A6340 ORI.L  #$FC200087,-$7D(A2,D0.W)
        DC.W    $FBF2,$00E2         ; $2A6348 MOVE.W  -$1E(A2,D0.W),<EA:3D>
        ORI.W  #$FA33,$09(A4,D0.W)              ; $2A634C
        ORI.L  #$F9E501AC,-(A3)                 ; $2A6352
        DC.W    $0002,$F8BB         ; $2A6358 ORI.B  #$F8BB,D2
        DC.W    $01FE               ; $2A635C BSET    D0,<EA:3E>
        MOVE.W  -(A1),-(A7)                     ; $2A635E
        MOVE.W  $0169(A7),(A4)                  ; $2A6360
        MOVE.W  -$28(PC,A7.L),(A7)+             ; $2A6364
        BTST    D0,(A7)                         ; $2A6368
        DC.W    $FFDD               ; $2A636A MOVE.W  (A5)+,<EA:3F>
        DC.W    $F83D               ; $2A636C MOVE.W  <EA:3D>,D4
        BSET    D0,(A2)+                        ; $2A636E
        MOVE.W  $6A(A6,A7.L),$0010(A7)          ; $2A6370
        MOVE.W  -$33(A3,A7.L),(A7)              ; $2A6376
        DC.W    $000E,$FED0         ; $2A637A ORI.B  #$FED0,A6
        MOVE.W  (A7)+,(A4)                      ; $2A637E
        BSET    D0,(A0)+                        ; $2A6380
        MOVE.W  (A3),$00(A7,D0.W)               ; $2A6382
        BGT.W  loc_2A6388                       ; $2A6386
        DC.W    $0010,$0020         ; $2A638A ORI.B  #$0020,(A0)
        DC.W    $0030,$0000,$6400   ; $2A638E ORI.B  #$0000,$00(A0,D6.W)
        ORI.W  #$0050,D0                        ; $2A6394
        ORI.W  #$0070,-(A0)                     ; $2A6398
        DC.W    $0000,$6B00         ; $2A639C ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A63A0
        DC.W    $00B0,$0000,$6400,$00C0; $2A63A6 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A63AE DC.W    $00D0
        DC.W    $00E0               ; $2A63B0 DC.W    $00E0
        DC.W    $00F0               ; $2A63B2 DC.W    $00F0
        DC.W    $0000,$6B00         ; $2A63B4 ORI.B  #$6B00,D0
        BTST    D0,D0                           ; $2A63B8
        BTST    D0,(A0)                         ; $2A63BA
        BTST    D0,-(A0)                        ; $2A63BC
loc_2A63BE:
        BTST    D0,$00(A0,D0.W)                 ; $2A63BE
        BCC.W  loc_2A6504                       ; $2A63C2
        BCHG    D0,(A0)                         ; $2A63C6
        BCHG    D0,-(A0)                        ; $2A63C8
        BCHG    D0,$00(A0,D0.W)                 ; $2A63CA
        BEQ.W  loc_2A6550                       ; $2A63CE
        BCLR    D0,(A0)                         ; $2A63D2
        BCLR    D0,-(A0)                        ; $2A63D4
        BCLR    D0,$00(A0,D0.W)                 ; $2A63D6
        SUBI.B  #$01C0,D0                       ; $2A63DA
        BSET    D0,(A0)                         ; $2A63DE
        BSET    D0,-(A0)                        ; $2A63E0
        BSET    D0,$00(A0,D0.W)                 ; $2A63E2
        BCC.W  loc_2A65E8                       ; $2A63E6
        DC.W    $0210,$0220         ; $2A63EA ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$0400   ; $2A63EE ANDI.B  #$0000,$00(A0,D0.W)
        ANDI.W  #$0250,D0                       ; $2A63F4
        ANDI.W  #$0270,-(A0)                    ; $2A63F8
        DC.W    $0000,$6400         ; $2A63FC ORI.B  #$6400,D0
        ANDI.L  #$029002A0,D0                   ; $2A6400
        DC.W    $02B0,$0C00,$0030,$0030; $2A6406 ANDI.L  #$0C000030,$30(A0,D0.W)
        MOVE.W  -(A4),(A4)                      ; $2A640E
        BCLR    D1,#$00C5                       ; $2A6410
        MOVE.W  -$69(A7,D0.W),-$008D(A4)        ; $2A6414
        MOVE.W  $031B(A7),D5                    ; $2A641A
        MOVE.W  $5C(A3,A7.L),$0440(A7)          ; $2A641E
        DC.W    $00C5               ; $2A6424 DC.W    $00C5
        MOVE.W  (A2)+,D4                        ; $2A6426
        SUBI.L  #$0084F89F,-(A5)                ; $2A6428
        BSET    D1,-$003A(A5)                   ; $2A642E
        MOVE.W  $0454(A7),-(A4)                 ; $2A6432
        DC.W    $FFC6               ; $2A6436 MOVE.W  D6,<EA:3F>
        MOVE.W  $050D(A1),(A4)                  ; $2A6438
        ORI.L  #$F8F10421,D4                    ; $2A643C
        MOVE.W  -(A5),-$0707(A7)                ; $2A6442
        DC.W    $02B3,$FED7,$F969,$02B5; $2A6446 ANDI.L  #$FED7F969,-$4B(A3,D0.W)
        MOVE.W  (A0)+,(A7)+                     ; $2A644E
        MOVE.W  -(A1),$0423(A4)                 ; $2A6450
        MOVE.W  -(A6),-$06C7(A7)                ; $2A6454
        DC.W    $02BA,$FF2A,$F7CD,$020D; $2A6458 ANDI.L  #$FF2AF7CD,$020D(PC)
        MOVE.W  A3,(A7)+                        ; $2A6460
        MOVE.W  $01CA(A7),-$3D(PC,A7.L)         ; $2A6462
        MOVE.W  (A3)+,$0276(A4)                 ; $2A6468
        MOVE.W  -(A2),-(A7)                     ; $2A646C
        MOVE.W  $02B7.W,$14(A3,D0.W)            ; $2A646E
        MOVE.W  $0218(A6),(A3)                  ; $2A6474
        MOVE.W  A3,-(A7)                        ; $2A6478
        MOVE.W  $0096(A2),-$21(PC,A7.L)         ; $2A647A
        MOVE.W  $36(A4,D0.W),(A4)+              ; $2A6480
        DC.W    $00E8               ; $2A6484 DC.W    $00E8
        MOVE.W  $07(A6,D0.W),(A4)+              ; $2A6486
        BTST    D0,$3E(A0,A7.L)                 ; $2A648A
        ANDI.L  #$00C7F9AC,(A3)                 ; $2A648E
        DC.W    $02A9,$00C1,$F963,$041D; $2A6494 ANDI.L  #$00C1F963,$041D(A1)
        BTST    D0,-$0675(A1)                   ; $2A649C
        DC.W    $02B2,$0117,$F817,$0206; $2A64A0 ANDI.L  #$0117F817,$06(A2,D0.W)
        DC.W    $00E0               ; $2A64A8 DC.W    $00E0
        MOVE.W  -$3F(A7,D0.W),D4                ; $2A64AA
        DC.W    $00DE               ; $2A64AE DC.W    $00DE
        MOVE.W  $026D(A4),$15(A4,D0.W)          ; $2A64B0
        MOVE.W  A6,-$5D(A4,D0.W)                ; $2A64B6
        ORI.L  #$FA4E0150,(A1)                  ; $2A64BA
        MOVE.W  (A4),-$050F(A7)                 ; $2A64C0
        BCLR    D0,-$00AC(A5)                   ; $2A64C4
        MOVE.W  $00(A1,D0.W),D5                 ; $2A64C8
        ORI.L  #$FA2E01AE,(A1)                  ; $2A64CC
        ORI.L  #$FA24003C,A5                    ; $2A64D2
        DC.W    $002C,$FABD,$0033   ; $2A64D8 ORI.B  #$FABD,$0033(A4)
        ORI.W  #$FAC6,D0                        ; $2A64DE
        BCLR    D0,-(A3)                        ; $2A64E2
        ORI.L  #$FA2FFFE8,-(A1)                 ; $2A64E4
        DC.W    $00B4,$FC19,$003B,$0084; $2A64EA ORI.L  #$FC19003B,-$7C(A4,D0.W)
        MOVE.W  D7,D6                           ; $2A64F2
        ORI.L  #$0073FA1C,(A7)+                 ; $2A64F4
        ORI.W  #$00A4,A2                        ; $2A64FA
        MOVEA.W (A0),A5                         ; $2A64FE
        BSET    D0,(A7)                         ; $2A6500
        DC.W    $0005,$F91A         ; $2A6502 ORI.B  #$F91A,D5
        BSET    D0,(A0)                         ; $2A6506
        MOVE.W  -(A6),-(A7)                     ; $2A6508
        MOVE.W  D0,$0143(A4)                    ; $2A650A
        MOVE.W  $76(A5,A7.L),(A7)+              ; $2A650E
        DC.W    $0149               ; $2A6512 BCHG    D0,A1
        DC.W    $FFD5               ; $2A6514 MOVE.W  (A5),<EA:3F>
        MOVE.W  $016B(A1),(A4)                  ; $2A6516
        MOVE.W  -$061B(A5),$0014(A7)            ; $2A651A
        MOVE.W  -$05CB(PC),(A7)                 ; $2A6520
        ORI.W  #$FEDF,A2                        ; $2A6524
        MOVE.W  $01A1FF93,(A4)+                 ; $2A6528
        DC.W    $0000,$6E00         ; $2A652E ORI.B  #$6E00,D0
        DC.W    $0000,$0010         ; $2A6532 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A6536 ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A653A ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A653E
        ORI.W  #$0070,-(A0)                     ; $2A6542
        DC.W    $0000,$6B00         ; $2A6546 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A654A
loc_2A6550:
        DC.W    $00B0,$0000,$6400,$00C0; $2A6550 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A6558 DC.W    $00D0
        DC.W    $00E0               ; $2A655A DC.W    $00E0
        DC.W    $00F0               ; $2A655C DC.W    $00F0
        DC.W    $0000,$0300         ; $2A655E ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A6562
        BTST    D0,(A0)                         ; $2A6564
        BTST    D0,-(A0)                        ; $2A6566
        BTST    D0,$00(A0,D0.W)                 ; $2A6568
        BMI.W  loc_2A66AE                       ; $2A656C
        BCHG    D0,(A0)                         ; $2A6570
        BCHG    D0,-(A0)                        ; $2A6572
        BCHG    D0,$00(A0,D0.W)                 ; $2A6574
        BCC.W  loc_2A66FA                       ; $2A6578
        BCLR    D0,(A0)                         ; $2A657C
        BCLR    D0,-(A0)                        ; $2A657E
        BCLR    D0,$00(A0,D0.W)                 ; $2A6580
        BEQ.W  loc_2A6746                       ; $2A6584
        BSET    D0,(A0)                         ; $2A6588
        BSET    D0,-(A0)                        ; $2A658A
        BSET    D0,$00(A0,D0.W)                 ; $2A658C
        SUBI.B  #$0200,D0                       ; $2A6590
        DC.W    $0210,$0220         ; $2A6594 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A6598 ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A659E
        ANDI.W  #$0270,-(A0)                    ; $2A65A2
        DC.W    $0000,$0400         ; $2A65A6 ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A65AA
        DC.W    $02B0,$0000,$6400,$02C0; $2A65B0 ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A65B8 DC.W    $02D0
        DC.W    $02E0               ; $2A65BA DC.W    $02E0
        DC.W    $02F0               ; $2A65BC DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A65BE
        DC.W    $0030,$FA1A,$051A   ; $2A65C2 ORI.B  #$FA1A,$1A(A0,D0.W)
        DC.W    $00C7               ; $2A65C8 DC.W    $00C7
        MOVE.W  -(A6),(A5)                      ; $2A65CA
        DC.W    $03CE               ; $2A65CC BSET    D1,A6
        MOVE.W  $76(A3,A7.L),$0425(A7)          ; $2A65CE
        MOVE.W  -$16(A3,A7.L),$0571(A7)         ; $2A65D4
        DC.W    $00C7               ; $2A65DA DC.W    $00C7
        MOVE.W  D7,#$061C                       ; $2A65DC
        ORI.L  #$FA1F054B,D7                    ; $2A65E0
        DC.W    $FFC8               ; $2A65E6 MOVE.W  A0,<EA:3F>
loc_2A65E8:
        MOVE.W  D2,(A5)+                        ; $2A65E8
        BCLR    D2,(A0)                         ; $2A65EA
        DC.W    $FFC8               ; $2A65EC MOVE.W  A0,<EA:3F>
        MOVEA.W $0661(A2),A5                    ; $2A65EE
        ORI.L  #$FA53054B,D7                    ; $2A65F2
        MOVE.W  -(A3),-$0525(A7)                ; $2A65F8
        BSET    D1,-$0117(A7)                   ; $2A65FC
        MOVE.W  D3,$0418(A5)                    ; $2A6600
        MOVE.W  -$0545(A1),(A7)+                ; $2A6604
        BCHG    D2,$63(A4,A7.L)                 ; $2A6608
        MOVE.W  $0412(A0),-(A5)                 ; $2A660C
        MOVE.W  #$F9AC,-(A7)                    ; $2A6610
        DC.W    $037E               ; $2A6614 BCHG    D1,<EA:3E>
        MOVE.W  -$38(A4,A7.L),(A7)+             ; $2A6616
        BTST    D1,$FEEF.W                      ; $2A661A
        MOVE.W  D4,$03CB(A5)                    ; $2A661E
        MOVE.W  -$33(A7,A7.L),-(A7)             ; $2A6622
        SUBI.W  #$0134,A6                       ; $2A6626
        MOVE.W  $0417(A2),(A4)                  ; $2A662A
        MOVE.W  -(A2),-(A7)                     ; $2A662E
        DC.W    $F93F               ; $2A6630 MOVE.W  <EA:3F>,-(A4)
        DC.W    $023A,$FF03,$FA62   ; $2A6632 ANDI.B  #$FF03,-$059E(PC)
        ANDI.W  #$0114,$75(A1,A7.L)             ; $2A6638
        DC.W    $054C               ; $2A663E BCHG    D2,A4
        BTST    D0,-$7E(A1,A7.L)                ; $2A6640
        BSET    D1,(A1)                         ; $2A6644
        DC.W    $00C7               ; $2A6646 DC.W    $00C7
        MOVE.W  -$29(A1,D0.W),(A5)+             ; $2A6648
        DC.W    $00C3               ; $2A664C DC.W    $00C3
        MOVE.W  -(A5),(A5)+                     ; $2A664E
        BCHG    D2,(A0)                         ; $2A6650
        BTST    D0,-$053E(A4)                   ; $2A6652
        BSET    D1,-(A5)                        ; $2A6656
        BTST    D0,(A1)+                        ; $2A6658
        MOVE.W  $0301(A6),$00DB(A4)             ; $2A665A
        MOVE.W  (A0)+,-$3E(A4,D0.W)             ; $2A6660
        DC.W    $00D8               ; $2A6664 DC.W    $00D8
        MOVE.W  $03A6(A4),(A5)+                 ; $2A6666
        BTST    D0,(A6)                         ; $2A666A
        DC.W    $FABE               ; $2A666C MOVE.W  <EA:3E>,(A5)
        BSET    D1,(A4)+                        ; $2A666E
        ORI.L  #$FB190261,(A1)                  ; $2A6670
        MOVE.W  (A4),-$0431(A7)                 ; $2A6676
        ANDI.L  #$FF54FB74,A4                   ; $2A667A
        SUBI.B  #$0091,D7                       ; $2A6680
        MOVE.W  (A2)+,-(A5)                     ; $2A6684
        DC.W    $02C9               ; $2A6686 DC.W    $02C9
        ORI.L  #$FA7F017B,(A1)                  ; $2A6688
        DC.W    $002C,$FB09,$0137   ; $2A668E ORI.B  #$FB09,$0137(A4)
        DC.W    $0038,$FBA4,$0286   ; $2A6694 ORI.B  #$FBA4,$0286.W
        ORI.L  #$FA640148,(A5)+                 ; $2A669A
        DC.W    $00AE,$FBD8,$FFFD,$0081; $2A66A0 ORI.L  #$FBD8FFFD,$0081(A6)
        MOVE.W  (A3)+,D6                        ; $2A66A8
        ORI.W  #$0076,A2                        ; $2A66AA
loc_2A66AE:
        MOVE.W  -(A7),(A5)                      ; $2A66AE
        BCLR    D0,(A5)                         ; $2A66B0
        ORI.L  #$FB1D02A3,-(A3)                 ; $2A66B2
        DC.W    $FFFC,$FA93         ; $2A66B8 MOVE.W  #$FA93,<EA:3F>
        BCLR    D0,(A2)                         ; $2A66BC
        MOVE.W  (A0)+,-(A7)                     ; $2A66BE
        MOVE.W  -(A1),-(A5)                     ; $2A66C0
        BCHG    D0,(A5)+                        ; $2A66C2
        MOVE.W  D0,-(A7)                        ; $2A66C4
        MOVE.W  $026E(A5),-$1A(A5,A7.L)         ; $2A66C6
        MOVE.W  D5,(A5)                         ; $2A66CC
        BTST    D0,$7D(A7,A7.L)                 ; $2A66CE
        DC.W    $FBD4               ; $2A66D2 MOVE.W  (A4),<EA:3D>
        DC.W    $0008,$FEA8         ; $2A66D4 ORI.B  #$FEA8,A0
        MOVE.W  (A6)+,D6                        ; $2A66D8
        ORI.W  #$FEBB,A5                        ; $2A66DA
        MOVE.W  A6,(A5)+                        ; $2A66DE
        BCHG    D0,#$FF8F                       ; $2A66E0
        DC.W    $0000,$6E00         ; $2A66E4 ORI.B  #$6E00,D0
        DC.W    $0000,$0010         ; $2A66E8 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A66EC ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A66F0 ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A66F4
        ORI.W  #$0070,-(A0)                     ; $2A66F8
        DC.W    $0000,$6B00         ; $2A66FC ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A6700
        DC.W    $00B0,$0000,$6400,$00C0; $2A6706 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A670E DC.W    $00D0
        DC.W    $00E0               ; $2A6710 DC.W    $00E0
        DC.W    $00F0               ; $2A6712 DC.W    $00F0
        DC.W    $0000,$0300         ; $2A6714 ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A6718
        BTST    D0,(A0)                         ; $2A671A
        BTST    D0,-(A0)                        ; $2A671C
        BTST    D0,$00(A0,D0.W)                 ; $2A671E
        BMI.W  loc_2A6864                       ; $2A6722
        BCHG    D0,(A0)                         ; $2A6726
        BCHG    D0,-(A0)                        ; $2A6728
        BCHG    D0,$00(A0,D0.W)                 ; $2A672A
        BCC.W  loc_2A68B0                       ; $2A672E
        BCLR    D0,(A0)                         ; $2A6732
        BCLR    D0,-(A0)                        ; $2A6734
        BCLR    D0,$00(A0,D0.W)                 ; $2A6736
        BEQ.W  loc_2A68FC                       ; $2A673A
        BSET    D0,(A0)                         ; $2A673E
        BSET    D0,-(A0)                        ; $2A6740
        BSET    D0,$00(A0,D0.W)                 ; $2A6742
loc_2A6746:
        SUBI.B  #$0200,D0                       ; $2A6746
        DC.W    $0210,$0220         ; $2A674A ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A674E ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A6754
        ANDI.W  #$0270,-(A0)                    ; $2A6758
        DC.W    $0000,$0400         ; $2A675C ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A6760
        DC.W    $02B0,$0000,$6400,$02C0; $2A6766 ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A676E DC.W    $02D0
        DC.W    $02E0               ; $2A6770 DC.W    $02E0
        DC.W    $02F0               ; $2A6772 DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A6774
        DC.W    $0030,$FA05,$04B7   ; $2A6778 ORI.B  #$FA05,-$49(A0,D0.W)
        MOVE.W  A5,-(A7)                        ; $2A677E
        MOVE.W  -(A2),-(A5)                     ; $2A6780
        BTST    D1,-$0092(A6)                   ; $2A6782
        MOVE.W  $6C(A0,D0.W),-(A5)              ; $2A6786
        ORI.W  #$FA12,D5                        ; $2A678A
        DC.W    $04F5               ; $2A678E DC.W    $04F5
        DC.W    $FFE6               ; $2A6790 MOVE.W  -(A6),<EA:3F>
        MOVEA.W $05B5(A4),A5                    ; $2A6792
        MOVE.W  (A7),(A7)+                      ; $2A6796
        MOVE.W  A1,-(A5)                        ; $2A6798
        DC.W    $04C0               ; $2A679A DC.W    $04C0
        MOVE.W  (A4),-(A7)                      ; $2A679C
        MOVE.W  (A4),-(A5)                      ; $2A679E
        DC.W    $04F1               ; $2A67A0 DC.W    $04F1
        DC.W    $FFBD,$FA76         ; $2A67A2 MOVE.W  <EA:3D>,$76(A7,A7.L)
        BSET    D2,-(A6)                        ; $2A67A6
        DC.W    $FF7F,$FB69         ; $2A67A8 MOVE.W  <EA:3F>,-$0497(A7)
        DC.W    $04AF,$FF4D,$FC07,$0346; $2A67AC SUBI.L  #$FF4DFC07,$0346(A7)
        MOVE.W  A6,-$040D(A7)                   ; $2A67B4
        DC.W    $033E               ; $2A67B8 BTST    D1,<EA:3E>
        MOVE.W  #$FB55,-$5A(A7,D0.W)            ; $2A67BA
        MOVE.W  -$5A(PC,A7.L),$3E(A7,D0.W)      ; $2A67C0
        MOVE.W  A7,$3C(A7,A7.L)                 ; $2A67C6
        BCHG    D1,D5                           ; $2A67CA
        MOVE.W  A4,D7                           ; $2A67CC
        MOVEA.W D7,A6                           ; $2A67CE
        DC.W    $02FA               ; $2A67D0 DC.W    $02FA
        MOVE.W  A7,D7                           ; $2A67D2
        MOVE.W  -$0D(A2,D0.W),-$6E(A5,A7.L)     ; $2A67D4
        MOVE.W  -(A3),#$03DF                    ; $2A67DA
        MOVEA.W D1,A7                           ; $2A67DE
        DC.W    $FBEB,$03C3         ; $2A67E0 MOVE.W  $03C3(A3),<EA:3D>
        MOVE.W  A0,-(A6)                        ; $2A67E4
        MOVE.W  (A5)+,D6                        ; $2A67E6
        BSET    D0,-(A2)                        ; $2A67E8
        MOVE.W  D7,$16(A6,A7.L)                 ; $2A67EA
        DC.W    $01FD               ; $2A67EE BSET    D0,<EA:3D>
        MOVE.W  D0,(A7)+                        ; $2A67F0
        MOVE.W  (A0)+,-$10(A4,D0.W)             ; $2A67F2
        DC.W    $FF79,$FA24,$0389,$FF30; $2A67F6 MOVE.W  $FA240389,-$00D0(A7)
        MOVE.W  (A2)+,D5                        ; $2A67FE
        BCHG    D1,-$0064(A7)                   ; $2A6800
        MOVE.W  A6,-$29(A4,D0.W)                ; $2A6804
        DC.W    $FFE5               ; $2A6808 MOVE.W  -(A5),<EA:3F>
        MOVE.W  A1,#$0385                       ; $2A680A
        MOVE.W  -(A4),-$05B7(A7)                ; $2A680E
        DC.W    $02FD               ; $2A6812 DC.W    $02FD
        DC.W    $FDF2,$FA4C         ; $2A6814 MOVE.W  $4C(A2,A7.L),<EA:3E>
        DC.W    $02B7,$FE0D,$F9CC,$033E; $2A6818 ANDI.L  #$FE0DF9CC,$3E(A7,D0.W)
        DC.W    $FF7E,$F9FC         ; $2A6820 MOVE.W  <EA:3E>,-$0604(A7)
        DC.W    $034F               ; $2A6824 BCHG    D1,A7
        MOVE.W  (A0)+,$58(A7,A7.L)              ; $2A6826
        BSET    D0,-(A4)                        ; $2A682A
        DC.W    $FF7D,$FB67         ; $2A682C MOVE.W  <EA:3D>,-$0499(A7)
        BSET    D0,-(A5)                        ; $2A6830
        DC.W    $0037,$FA0D,$0350   ; $2A6832 ORI.B  #$FA0D,$50(A7,D0.W)
        ORI.W  #$FA2D,(A1)                      ; $2A6838
        ANDI.W  #$FFAA,D6                       ; $2A683C
        MOVEA.W -(A1),A5                        ; $2A6840
        BTST    D0,-(A1)                        ; $2A6842
        MOVE.W  $3A(PC,A7.L),(A7)               ; $2A6844
        DC.W    $00BF,$FF2C,$FA06   ; $2A6848 ORI.L  #$FF2CFA06,<EA:3F>
        BSET    D0,-(A4)                        ; $2A684E
        DC.W    $001A,$F9C2         ; $2A6850 ORI.B  #$F9C2,(A2)+
        DC.W    $00D0               ; $2A6854 DC.W    $00D0
        MOVE.W  (A6)+,(A7)                      ; $2A6856
        MOVE.W  (A2)+,D5                        ; $2A6858
        DC.W    $00C2               ; $2A685A DC.W    $00C2
        ORI.L  #$FA3D0122,A1                    ; $2A685C
        ORI.L  #$F9E60132,D6                    ; $2A6862
        MOVE.W  (A3)+,(A7)                      ; $2A6868
        MOVE.W  -(A7),(A5)                      ; $2A686A
        DC.W    $0235,$FFAE,$FB78   ; $2A686C ANDI.B  #$FFAE,$78(A5,A7.L)
        BSET    D0,-$018B(A6)                   ; $2A6872
        MOVE.W  $016A(A2),-$4C(A5,A7.L)         ; $2A6876
        MOVE.W  (A2)+,(A5)+                     ; $2A687C
        BCLR    D0,-$14(A1,A7.L)                ; $2A687E
        MOVE.W  (A7)+,-(A5)                     ; $2A6882
        BCLR    D0,(A2)                         ; $2A6884
        MOVE.W  -(A5),D7                        ; $2A6886
        MOVE.W  (A3)+,D6                        ; $2A6888
        DC.W    $0011,$FEE9         ; $2A688A ORI.B  #$FEE9,(A1)
        MOVE.W  D7,D6                           ; $2A688E
        DC.W    $0034,$FF48,$FB0A   ; $2A6890 ORI.B  #$FF48,$0A(A4,A7.L)
        BCLR    D0,-$7B(A4,A7.L)                ; $2A6896
        DC.W    $0000,$6E00         ; $2A689A ORI.B  #$6E00,D0
        DC.W    $0000,$0010         ; $2A689E ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A68A2 ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A68A6 ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A68AA
        ORI.W  #$0070,-(A0)                     ; $2A68AE
        DC.W    $0000,$6B00         ; $2A68B2 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A68B6
        DC.W    $00B0,$0000,$6400,$00C0; $2A68BC ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A68C4 DC.W    $00D0
        DC.W    $00E0               ; $2A68C6 DC.W    $00E0
        DC.W    $00F0               ; $2A68C8 DC.W    $00F0
        DC.W    $0000,$0300         ; $2A68CA ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A68CE
        BTST    D0,(A0)                         ; $2A68D0
        BTST    D0,-(A0)                        ; $2A68D2
        BTST    D0,$00(A0,D0.W)                 ; $2A68D4
        BMI.W  loc_2A6A1A                       ; $2A68D8
        BCHG    D0,(A0)                         ; $2A68DC
        BCHG    D0,-(A0)                        ; $2A68DE
        BCHG    D0,$00(A0,D0.W)                 ; $2A68E0
        BCC.W  loc_2A6A66                       ; $2A68E4
        BCLR    D0,(A0)                         ; $2A68E8
        BCLR    D0,-(A0)                        ; $2A68EA
        BCLR    D0,$00(A0,D0.W)                 ; $2A68EC
        BEQ.W  loc_2A6AB2                       ; $2A68F0
        BSET    D0,(A0)                         ; $2A68F4
        BSET    D0,-(A0)                        ; $2A68F6
        BSET    D0,$00(A0,D0.W)                 ; $2A68F8
loc_2A68FC:
        SUBI.B  #$0200,D0                       ; $2A68FC
        DC.W    $0210,$0220         ; $2A6900 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A6904 ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A690A
        ANDI.W  #$0270,-(A0)                    ; $2A690E
        DC.W    $0000,$0400         ; $2A6912 ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A6916
        DC.W    $02B0,$0000,$6400,$02C0; $2A691C ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A6924 DC.W    $02D0
        DC.W    $02E0               ; $2A6926 DC.W    $02E0
        DC.W    $02F0               ; $2A6928 DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A692A
        DC.W    $0030,$FBAF,$0401   ; $2A692E ORI.B  #$FBAF,$01(A0,D0.W)
        MOVE.W  D4,(A7)+                        ; $2A6934
        MOVE.W  D7,$7B(A5,D0.W)                 ; $2A6936
        DC.W    $FFF4,$FB0A         ; $2A693A MOVE.W  $0A(A4,A7.L),<EA:3F>
        DC.W    $02F7               ; $2A693E DC.W    $02F7
        ORI.L  #$FB33047C,D2                    ; $2A6940
        MOVE.W  (A1),-$0391(A7)                 ; $2A6946
        DC.W    $04C8               ; $2A694A DC.W    $04C8
        MOVE.W  -(A5),(A7)+                     ; $2A694C
        MOVEA.W A1,A6                           ; $2A694E
        BSET    D1,(A3)+                        ; $2A6950
        MOVE.W  (A3),-$18(A7,A7.L)              ; $2A6952
        DC.W    $043C,$0001,$FC0E   ; $2A6956 SUBI.B  #$0001,#$FC0E
        BTST    D2,-$00AD(A1)                   ; $2A695C
        MOVE.W  -$0A(A5,D0.W),D6                ; $2A6960
        DC.W    $0025,$FCA2         ; $2A6964 ORI.B  #$FCA2,-(A5)
        DC.W    $027D,$0018         ; $2A6968 ANDI.W  #$0018,<EA:3D>
        MOVEA.W D2,A6                           ; $2A696C
        ANDI.W  #$0049,-(A0)                    ; $2A696E
        DC.W    $FBD5               ; $2A6972 MOVE.W  (A5),<EA:3D>
        BSET    D1,(A1)+                        ; $2A6974
        ORI.W  #$FC40,(A7)                      ; $2A6976
        ANDI.L  #$FFF2FDBC,D7                   ; $2A697A
        DC.W    $0234,$FF62,$FDAA   ; $2A6980 ANDI.B  #$FF62,-$56(A4,A7.L)
        BSET    D0,-$00A1(A2)                   ; $2A6986
        MOVE.W  $023E(A7),D6                    ; $2A698A
        DC.W    $FFEF,$FBCC         ; $2A698E MOVE.W  -$0434(A7),<EA:3F>
        DC.W    $034D               ; $2A6992 BCHG    D1,A5
        MOVE.W  -$01FB(A0),D7                   ; $2A6994
        BCHG    D1,-$0103(A3)                   ; $2A6998
        MOVEA.W A4,A7                           ; $2A699C
        DC.W    $018C               ; $2A699E BCLR    D0,A4
        DC.W    $FE7F               ; $2A69A0 MOVEA.W <EA:3F>,A7
        MOVE.W  (A5),D6                         ; $2A69A2
        BCHG    D0,-$0256(A6)                   ; $2A69A4
        MOVE.W  $78(A2,D0.W),-(A5)              ; $2A69A8
        MOVE.W  D0,(A7)+                        ; $2A69AC
        MOVE.W  D7,$02F0(A5)                    ; $2A69AE
        MOVE.W  D2,(A7)+                        ; $2A69B2
        MOVE.W  $02EB(A3),(A5)+                 ; $2A69B4
        MOVE.W  D0,-(A7)                        ; $2A69B8
        MOVE.W  (A5),(A5)+                      ; $2A69BA
        SUBI.W  #$FEFE,-$1F(A3,A7.L)            ; $2A69BC
        BTST    D1,(A0)                         ; $2A69C2
        MOVE.W  -$03CD(A1),(A7)                 ; $2A69C4
        DC.W    $0279,$FDF0,$FC15,$0234; $2A69C8 ANDI.W  #$FDF0,$FC150234
        DC.W    $FDF2,$FAC3         ; $2A69D0 MOVE.W  -$3D(A2,A7.L),<EA:3E>
        DC.W    $02CA               ; $2A69D4 DC.W    $02CA
        MOVE.W  -$054D(A4),(A7)                 ; $2A69D6
        DC.W    $02F0               ; $2A69DA DC.W    $02F0
        MOVE.W  -$045E(A4),-(A7)                ; $2A69DC
        BCHG    D0,-$0003(A2)                   ; $2A69E0
        MOVE.W  -(A6),-(A5)                     ; $2A69E4
        BCHG    D0,$0089(A2)                    ; $2A69E6
        MOVE.W  $02F0.W,D5                      ; $2A69EA
        MOVE.W  $FABD.W,-$65(A7,D0.W)           ; $2A69EE
        MOVE.W  $FAA8.W,-(A7)                   ; $2A69F4
        DC.W    $0024,$FF7D         ; $2A69F8 ORI.B  #$FF7D,-(A4)
        MOVE.W  $003B(A0),D5                    ; $2A69FC
        DC.W    $FFD1               ; $2A6A00 MOVE.W  (A1),<EA:3F>
        DC.W    $FA3E               ; $2A6A02 MOVE.W  <EA:3E>,D5
        BCLR    D0,-$75(A3,A7.L)                ; $2A6A04
        MOVEA.W D1,A5                           ; $2A6A08
        DC.W    $FFF0,$FF18         ; $2A6A0A MOVE.W  $18(A0,A7.L),<EA:3F>
        MOVE.W  -(A6),(A4)+                     ; $2A6A0E
        DC.W    $003D,$0076         ; $2A6A10 ORI.B  #$0076,<EA:3D>
        MOVE.W  D7,-(A4)                        ; $2A6A14
        ORI.L  #$0082FA62,(A6)+                 ; $2A6A16
        ORI.W  #$FF23,(A0)                      ; $2A6A1C
        MOVE.W  -$11(A3,D0.W),(A5)+             ; $2A6A20
        DC.W    $FFCA               ; $2A6A24 MOVE.W  A2,<EA:3F>
        MOVEA.W D7,A6                           ; $2A6A26
        BSET    D0,#$FF1D                       ; $2A6A28
        MOVEA.W A2,A6                           ; $2A6A2C
        BCHG    D0,-(A2)                        ; $2A6A2E
        MOVE.W  (A0)+,-(A7)                     ; $2A6A30
        MOVE.W  $56(A6,D0.W),(A5)+              ; $2A6A32
        DC.W    $FFC5               ; $2A6A36 MOVE.W  D5,<EA:3F>
        MOVE.W  $01E4(A2),D6                    ; $2A6A38
        MOVE.W  D3,(A7)                         ; $2A6A3C
        MOVEA.W D3,A6                           ; $2A6A3E
        DC.W    $FFFF               ; $2A6A40 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  $00(A7,A7.L),(A7)+              ; $2A6A42
        DC.W    $000E,$FF45         ; $2A6A46 ORI.B  #$FF45,A6
        DC.W    $FBE8,$01F3         ; $2A6A4A MOVE.W  $01F3(A0),<EA:3D>
        MOVE.W  A7,(A7)+                        ; $2A6A4E
        DC.W    $0000,$6E00         ; $2A6A50 ORI.B  #$6E00,D0
        DC.W    $0000,$0010         ; $2A6A54 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A6A58 ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A6A5C ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A6A60
        ORI.W  #$0070,-(A0)                     ; $2A6A64
        DC.W    $0000,$6B00         ; $2A6A68 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A6A6C
        DC.W    $00B0,$0000,$6400,$00C0; $2A6A72 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A6A7A DC.W    $00D0
        DC.W    $00E0               ; $2A6A7C DC.W    $00E0
        DC.W    $00F0               ; $2A6A7E DC.W    $00F0
        DC.W    $0000,$0300         ; $2A6A80 ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A6A84
        BTST    D0,(A0)                         ; $2A6A86
        BTST    D0,-(A0)                        ; $2A6A88
        BTST    D0,$00(A0,D0.W)                 ; $2A6A8A
        BMI.W  loc_2A6BD0                       ; $2A6A8E
        BCHG    D0,(A0)                         ; $2A6A92
        BCHG    D0,-(A0)                        ; $2A6A94
        BCHG    D0,$00(A0,D0.W)                 ; $2A6A96
        BCC.W  loc_2A6C1C                       ; $2A6A9A
        BCLR    D0,(A0)                         ; $2A6A9E
        BCLR    D0,-(A0)                        ; $2A6AA0
        BCLR    D0,$00(A0,D0.W)                 ; $2A6AA2
        BEQ.W  loc_2A6C68                       ; $2A6AA6
        BSET    D0,(A0)                         ; $2A6AAA
        BSET    D0,-(A0)                        ; $2A6AAC
        BSET    D0,$00(A0,D0.W)                 ; $2A6AAE
loc_2A6AB2:
        SUBI.B  #$0200,D0                       ; $2A6AB2
        DC.W    $0210,$0220         ; $2A6AB6 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A6ABA ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A6AC0
        ANDI.W  #$0270,-(A0)                    ; $2A6AC4
        DC.W    $0000,$0400         ; $2A6AC8 ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A6ACC
        DC.W    $02B0,$0000,$6400,$02C0; $2A6AD2 ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A6ADA DC.W    $02D0
        DC.W    $02E0               ; $2A6ADC DC.W    $02E0
        DC.W    $02F0               ; $2A6ADE DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A6AE0
        DC.W    $0030,$FC42,$02CB   ; $2A6AE4 ORI.B  #$FC42,-$35(A0,D0.W)
        MOVE.W  -(A3),D7                        ; $2A6AEA
        DC.W    $FBDA               ; $2A6AEC MOVE.W  (A2)+,<EA:3D>
        DC.W    $0222,$FFE9         ; $2A6AEE ANDI.B  #$FFE9,-(A2)
        MOVE.W  (A5),-$10(A5,D0.W)              ; $2A6AF2
        DC.W    $0025,$FBFD         ; $2A6AF6 ORI.B  #$FBFD,-(A5)
        BCLR    D1,(A2)+                        ; $2A6AFA
        MOVEA.W -(A0),A7                        ; $2A6AFC
        MOVE.W  $49(A4,D0.W),-(A6)              ; $2A6AFE
        DC.W    $FDE3               ; $2A6B02 MOVE.W  -(A3),<EA:3E>
        MOVE.W  -(A6),(A6)+                     ; $2A6B04
        DC.W    $02E0               ; $2A6B06 DC.W    $02E0
        MOVE.W  -$0350(A5),(A7)+                ; $2A6B08
        BCLR    D1,D2                           ; $2A6B0C
        MOVE.W  (A5)+,-(A7)                     ; $2A6B0E
        DC.W    $FCFD               ; $2A6B10 MOVE.W  <EA:3D>,(A6)+
        BSET    D1,-$01ED(A2)                   ; $2A6B12
        MOVE.W  (A7),(A6)+                      ; $2A6B16
        BCHG    D1,-$0082(A2)                   ; $2A6B18
        MOVE.W  -(A5),-(A6)                     ; $2A6B1C
        BSET    D0,-$0069(A2)                   ; $2A6B1E
        MOVE.W  A3,(A6)+                        ; $2A6B22
        BSET    D0,(A4)+                        ; $2A6B24
        DC.W    $FFD8               ; $2A6B26 MOVE.W  (A0)+,<EA:3F>
        MOVEA.W #$035C,A6                       ; $2A6B28
        DC.W    $FFBF,$FCC6         ; $2A6B2C MOVE.W  <EA:3F>,-$3A(A7,A7.L)
        BSET    D0,$FF78.W                      ; $2A6B30
        MOVE.W  A1,D7                           ; $2A6B34
        BTST    D0,-$30(A3,A7.L)                ; $2A6B36
        DC.W    $FDE9,$00F0         ; $2A6B3A MOVE.W  $00F0(A1),<EA:3E>
        MOVE.W  -(A2),(A7)+                     ; $2A6B3E
        MOVE.W  -(A6),(A6)                      ; $2A6B40
        BCLR    D0,-$77(A7,A7.L)                ; $2A6B42
        MOVE.W  D6,-(A6)                        ; $2A6B46
        DC.W    $0221,$FCEA         ; $2A6B48 ANDI.B  #$FCEA,-(A1)
        MOVE.W  $0169(A6),(A7)+                 ; $2A6B4C
        MOVE.W  -(A1),D7                        ; $2A6B50
        DC.W    $FDF8,$FFCD         ; $2A6B52 MOVE.W  $FFCD.W,<EA:3E>
        MOVE.W  -$03F0(A7),(A7)                 ; $2A6B56
        ORI.L  #$FD77FBE5,D5                    ; $2A6B5A
        BCHG    D1,-$020B(A6)                   ; $2A6B60
        MOVE.W  -(A5),-$11(A5,D0.W)             ; $2A6B64
        MOVE.W  $55(A2,A7.L),D7                 ; $2A6B68
        DC.W    $0208,$FE7C         ; $2A6B6C ANDI.B  #$FE7C,A0
        MOVE.W  (A5),-$79(A5,D0.W)              ; $2A6B70
        MOVEA.W D0,A7                           ; $2A6B74
        DC.W    $FB3F               ; $2A6B76 MOVE.W  <EA:3F>,-(A5)
        DC.W    $0222,$FE27         ; $2A6B78 ANDI.B  #$FE27,-(A2)
        MOVEA.W $0163(A2),A6                    ; $2A6B7C
        MOVE.W  (A3),-$03BA(A6)                 ; $2A6B80
        BTST    D0,-(A1)                        ; $2A6B84
        MOVE.W  (A4)+,-$04E5(A6)                ; $2A6B86
        BSET    D0,-(A1)                        ; $2A6B8A
        MOVE.W  $3C(A1,A7.L),D7                 ; $2A6B8C
        DC.W    $02B3,$FEEE,$FC10,$012E; $2A6B90 ANDI.L  #$FEEEFC10,$2E(A3,D0.W)
        DC.W    $FFDC               ; $2A6B98 MOVE.W  (A4)+,<EA:3F>
        MOVE.W  D4,$2E(A5,D0.W)                 ; $2A6B9A
        ORI.W  #$FAB0,(A0)+                     ; $2A6B9E
        DC.W    $02B3,$FF6B,$FB27,$0135; $2A6BA2 ANDI.L  #$FF6BFB27,$35(A3,D0.W)
        MOVE.W  D4,-(A7)                        ; $2A6BAA
        MOVE.W  $0C(A1,D0.W),(A5)               ; $2A6BAC
        DC.W    $FFD4               ; $2A6BB0 MOVE.W  (A4),<EA:3F>
        MOVEA.W A1,A5                           ; $2A6BB2
        ORI.W  #$001A,-(A6)                     ; $2A6BB4
        MOVE.W  D0,(A5)+                        ; $2A6BB8
        BCLR    D0,(A0)                         ; $2A6BBA
        MOVE.W  A2,-$05B1(A7)                   ; $2A6BBC
        DC.W    $FFE8,$FF7C         ; $2A6BC0 MOVE.W  -$0084(A0),<EA:3F>
        MOVE.W  $0044(A1),(A4)+                 ; $2A6BC4
        DC.W    $00CC               ; $2A6BC8 DC.W    $00CC
        MOVE.W  D0,-(A4)                        ; $2A6BCA
        DC.W    $00A8,$00C8,$FA66,$004B; $2A6BCC ORI.L  #$00C8FA66,$004B(A0)
        DC.W    $FF79,$FB61,$01B5,$FF9B; $2A6BD4 MOVE.W  $FB6101B5,-$0065(A7)
        MOVE.W  D4,(A6)+                        ; $2A6BDC
        BSET    D0,$1C(A1,A7.L)                 ; $2A6BDE
        MOVE.W  (A7),(A6)+                      ; $2A6BE2
        BCHG    D0,(A2)+                        ; $2A6BE4
        MOVE.W  A1,-(A7)                        ; $2A6BE6
        MOVE.W  $1C(A4,D0.W),-$0077(A5)         ; $2A6BE8
        MOVE.W  D3,(A6)+                        ; $2A6BEE
        BSET    D0,(A4)+                        ; $2A6BF0
        MOVEA.W -$4B(A7,A7.L),A7                ; $2A6BF2
        DC.W    $FFFD               ; $2A6BF6 MOVE.W  <EA:3D>,<EA:3F>
        MOVE.W  D4,-(A7)                        ; $2A6BF8
        MOVEA.W $0013(A2),A6                    ; $2A6BFA
        MOVE.W  D7,-$0388(A7)                   ; $2A6BFE
        BSET    D0,-$45(A2,A7.L)                ; $2A6C02
        DC.W    $0000,$6E00         ; $2A6C06 ORI.B  #$6E00,D0
        DC.W    $0000,$0010         ; $2A6C0A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A6C0E ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A6C12 ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A6C16
        ORI.W  #$0070,-(A0)                     ; $2A6C1A
        DC.W    $0000,$6B00         ; $2A6C1E ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A6C22
        DC.W    $00B0,$0000,$6400,$00C0; $2A6C28 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A6C30 DC.W    $00D0
        DC.W    $00E0               ; $2A6C32 DC.W    $00E0
        DC.W    $00F0               ; $2A6C34 DC.W    $00F0
        DC.W    $0000,$0300         ; $2A6C36 ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A6C3A
        BTST    D0,(A0)                         ; $2A6C3C
        BTST    D0,-(A0)                        ; $2A6C3E
        BTST    D0,$00(A0,D0.W)                 ; $2A6C40
        BMI.W  loc_2A6D86                       ; $2A6C44
        BCHG    D0,(A0)                         ; $2A6C48
        BCHG    D0,-(A0)                        ; $2A6C4A
        BCHG    D0,$00(A0,D0.W)                 ; $2A6C4C
        BCC.W  loc_2A6DD2                       ; $2A6C50
        BCLR    D0,(A0)                         ; $2A6C54
        BCLR    D0,-(A0)                        ; $2A6C56
        BCLR    D0,$00(A0,D0.W)                 ; $2A6C58
        BEQ.W  loc_2A6E1E                       ; $2A6C5C
        BSET    D0,(A0)                         ; $2A6C60
        BSET    D0,-(A0)                        ; $2A6C62
        BSET    D0,$00(A0,D0.W)                 ; $2A6C64
loc_2A6C68:
        SUBI.B  #$0200,D0                       ; $2A6C68
        DC.W    $0210,$0220         ; $2A6C6C ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A6C70 ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A6C76
        ANDI.W  #$0270,-(A0)                    ; $2A6C7A
        DC.W    $0000,$0400         ; $2A6C7E ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A6C82
        DC.W    $02B0,$0000,$6400,$02C0; $2A6C88 ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A6C90 DC.W    $02D0
        DC.W    $02E0               ; $2A6C92 DC.W    $02E0
        DC.W    $02F0               ; $2A6C94 DC.W    $02F0
        CMPI.B  #$002C,D0                       ; $2A6C96
        DC.W    $002C,$FBF1,$0362   ; $2A6C9A ORI.B  #$FBF1,$0362(A4)
        MOVE.W  (A4),D7                         ; $2A6CA0
        MOVE.W  A0,D6                           ; $2A6CA2
        DC.W    $0222,$FF8F         ; $2A6CA4 ANDI.B  #$FF8F,-(A2)
        MOVE.W  -(A5),-$45(A5,D0.W)             ; $2A6CA8
        DC.W    $0014,$FB8E         ; $2A6CAC ORI.B  #$FB8E,(A4)
        BSET    D1,-$0166(PC)                   ; $2A6CB0
        MOVE.W  $28(A0,D0.W),(A6)               ; $2A6CB4
        DC.W    $FDE9,$FCAF         ; $2A6CB8 MOVE.W  -$0351(A1),<EA:3E>
        BCHG    D1,-(A4)                        ; $2A6CBC
        MOVE.W  D7,(A7)+                        ; $2A6CBE
        MOVEA.W -(A1),A6                        ; $2A6CC0
        BSET    D1,(A3)+                        ; $2A6CC2
        MOVE.W  $63(A0,A7.L),-(A7)              ; $2A6CC4
        SUBI.L  #$FE51FCAC,-(A0)                ; $2A6CC8
        BCLR    D1,-$0095(A6)                   ; $2A6CCE
        MOVE.W  -(A7),-(A6)                     ; $2A6CD2
        DC.W    $023C,$FF37,$FCDA   ; $2A6CD4 ANDI.B  #$FF37,#$FCDA
        DC.W    $0218,$FF7E         ; $2A6CDA ANDI.B  #$FF7E,(A0)+
        MOVEA.W (A6)+,A6                        ; $2A6CDE
        DC.W    $0389               ; $2A6CE0 BCLR    D1,A1
        MOVE.W  -$4F(A4,A7.L),$33(A7,D0.W)      ; $2A6CE2
        MOVE.W  -$02(A7,A7.L),-(A7)             ; $2A6CE8
        DC.W    $02AD,$FE62,$FE09,$0266; $2A6CEC ANDI.L  #$FE62FE09,$0266(A5)
        MOVEA.W A1,A7                           ; $2A6CF4
        MOVE.W  #$01EC,(A6)                     ; $2A6CF6
        MOVE.W  (A7)+,-(A7)                     ; $2A6CFA
        MOVE.W  $03D2(PC),-$01F4(A5)            ; $2A6CFC
        MOVE.W  (A4)+,$0251(A5)                 ; $2A6D02
        MOVEA.W (A0)+,A7                        ; $2A6D06
        MOVE.W  (A6),-(A5)                      ; $2A6D08
        ANDI.W  #$FEAD,-$04CB(A0)               ; $2A6D0A
        BSET    D1,-$019F(A0)                   ; $2A6D10
        MOVE.W  -(A6),(A5)+                     ; $2A6D14
        ANDI.W  #$FE67,$24(PC,A7.L)             ; $2A6D16
        ANDI.W  #$FD63,A2                       ; $2A6D1C
        MOVE.W  (A5),D6                         ; $2A6D20
        DC.W    $0200,$FD5F         ; $2A6D22 ANDI.B  #$FD5F,D0
        MOVE.W  (A7),(A5)+                      ; $2A6D26
        DC.W    $0231,$FE63,$FB23   ; $2A6D28 ANDI.B  #$FE63,$23(A1,A7.L)
        ANDI.L  #$FED8FC23,(A5)                 ; $2A6D2E
        DC.W    $010F               ; $2A6D34 BTST    D0,A7
        MOVE.W  (A5),-$4C(A7,A7.L)              ; $2A6D36
        DC.W    $010F               ; $2A6D3A BTST    D0,A7
        DC.W    $002B,$FAB4,$0295   ; $2A6D3C ORI.B  #$FAB4,$0295(A3)
        MOVE.W  -$04E9(A6),$0114(A7)            ; $2A6D42
        MOVE.W  -$66(A1,A7.L),(A7)+             ; $2A6D48
        DC.W    $0000,$FFDA         ; $2A6D4C ORI.B  #$FFDA,D0
        MOVEA.W D5,A5                           ; $2A6D50
        ORI.W  #$0025,-(A6)                     ; $2A6D52
        MOVE.W  D1,(A5)+                        ; $2A6D56
        BCHG    D0,$3F(PC,A7.L)                 ; $2A6D58
        MOVE.W  -$19(A2,A7.L),D5                ; $2A6D5C
        MOVE.W  A3,-$0F(A7,A7.L)                ; $2A6D60
        ORI.W  #$00FD,D3                        ; $2A6D64
        MOVE.W  A2,-(A4)                        ; $2A6D68
        ORI.L  #$00F9FA4A,-(A7)                 ; $2A6D6A
        ORI.W  #$FF87,A2                        ; $2A6D70
        MOVE.W  $0161.W,-$00B6(A5)              ; $2A6D74
        MOVE.W  -(A5),(A6)+                     ; $2A6D7A
        BCHG    D0,#$FEDB                       ; $2A6D7C
        MOVE.W  D6,-(A6)                        ; $2A6D80
        DC.W    $00F9               ; $2A6D82 DC.W    $00F9
        MOVE.W  -(A6),-(A7)                     ; $2A6D84
loc_2A6D86:
        MOVE.W  (A1)+,-$22(A5,D0.W)             ; $2A6D86
        MOVE.W  (A5),$09(A7,A7.L)               ; $2A6D8A
        DC.W    $00F6               ; $2A6D8E DC.W    $00F6
        MOVEA.W -$037E(A2),A7                   ; $2A6D90
        DC.W    $0023,$0019         ; $2A6D94 ORI.B  #$0019,-(A3)
        MOVE.W  $68(A6,D0.W),D6                 ; $2A6D98
        DC.W    $0023,$FCBD         ; $2A6D9C ORI.B  #$FCBD,-(A3)
        BTST    D0,$74(PC,A7.L)                 ; $2A6DA0
        DC.W    $0000,$6E00         ; $2A6DA4 ORI.B  #$6E00,D0
        DC.W    $0000,$0010         ; $2A6DA8 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A6DAC ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A6DB0 ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A6DB4
        ORI.W  #$0070,-(A0)                     ; $2A6DB8
        DC.W    $0000,$6B00         ; $2A6DBC ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A6DC0
        DC.W    $00B0,$0000,$6400,$00C0; $2A6DC6 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A6DCE DC.W    $00D0
        DC.W    $00E0               ; $2A6DD0 DC.W    $00E0
loc_2A6DD2:
        DC.W    $00F0               ; $2A6DD2 DC.W    $00F0
        DC.W    $0000,$6B00         ; $2A6DD4 ORI.B  #$6B00,D0
        BTST    D0,D0                           ; $2A6DD8
        BTST    D0,(A0)                         ; $2A6DDA
        BTST    D0,-(A0)                        ; $2A6DDC
        BTST    D0,$00(A0,D0.W)                 ; $2A6DDE
        BCC.W  loc_2A6F24                       ; $2A6DE2
        BCHG    D0,(A0)                         ; $2A6DE6
        BCHG    D0,-(A0)                        ; $2A6DE8
        BCHG    D0,$00(A0,D0.W)                 ; $2A6DEA
        BEQ.W  loc_2A6F70                       ; $2A6DEE
        BCLR    D0,(A0)                         ; $2A6DF2
        BCLR    D0,-(A0)                        ; $2A6DF4
        BCLR    D0,$00(A0,D0.W)                 ; $2A6DF6
        SUBI.B  #$01C0,D0                       ; $2A6DFA
        BSET    D0,(A0)                         ; $2A6DFE
        BSET    D0,-(A0)                        ; $2A6E00
        BSET    D0,$00(A0,D0.W)                 ; $2A6E02
        BCC.W  loc_2A7008                       ; $2A6E06
        DC.W    $0210,$0220         ; $2A6E0A ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$0400   ; $2A6E0E ANDI.B  #$0000,$00(A0,D0.W)
        ANDI.W  #$0250,D0                       ; $2A6E14
        ANDI.W  #$0270,-(A0)                    ; $2A6E18
        DC.W    $0000,$6400         ; $2A6E1C ORI.B  #$6400,D0
        ANDI.L  #$029002A0,D0                   ; $2A6E20
        DC.W    $02B0,$0C00,$002C,$002C; $2A6E26 ANDI.L  #$0C00002C,$2C(A0,D0.W)
        MOVE.W  $0310FD58,(A5)+                 ; $2A6E2E
        DC.W    $FBCA               ; $2A6E34 MOVE.W  A2,<EA:3D>
        DC.W    $0201,$FEBE         ; $2A6E36 ANDI.B  #$FEBE,D1
        DC.W    $FBC0               ; $2A6E3A MOVE.W  D0,<EA:3D>
        DC.W    $02B2,$FF4A,$FAEF,$03C0; $2A6E3C ANDI.L  #$FF4AFAEF,-$40(A2,D0.W)
        DC.W    $FDE3               ; $2A6E44 MOVE.W  -(A3),<EA:3E>
        MOVE.W  A4,-$46(A5,D0.W)                ; $2A6E46
        MOVE.W  -$08(A1,A7.L),(A6)              ; $2A6E4A
        BTST    D1,(A3)                         ; $2A6E4E
        MOVE.W  A5,-$0F(A6,A7.L)                ; $2A6E50
        BCLR    D1,(A5)+                        ; $2A6E54
        DC.W    $FDF9,$FB84,$0444   ; $2A6E56 MOVE.W  $FB840444,<EA:3E>
        MOVE.W  (A6)+,-(A6)                     ; $2A6E5C
        MOVEA.W A7,A6                           ; $2A6E5E
        BCHG    D1,(A2)+                        ; $2A6E60
        DC.W    $FDF1,$FC85         ; $2A6E62 MOVE.W  -$7B(A1,A7.L),<EA:3E>
        BSET    D0,(A4)+                        ; $2A6E66
        DC.W    $FE3D               ; $2A6E68 MOVE.W  <EA:3D>,D7
        MOVEA.W $01ED(A1),A6                    ; $2A6E6A
        MOVE.W  -(A7),(A7)                      ; $2A6E6E
        MOVE.W  $6B(A5,D0.W),D6                 ; $2A6E70
        MOVEA.W (A5)+,A7                        ; $2A6E74
        MOVE.W  -(A4),D6                        ; $2A6E76
        BSET    D0,-$0194(PC)                   ; $2A6E78
        DC.W    $FCBF               ; $2A6E7C MOVE.W  <EA:3F>,(A6)
        BCHG    D0,(A2)                         ; $2A6E7E
        MOVE.W  (A3),-(A6)                      ; $2A6E80
        MOVE.W  $0E(A3,D0.W),(A6)               ; $2A6E82
        MOVE.W  -$03E8(A7),-(A6)                ; $2A6E86
        BCLR    D0,-$77(A6,A7.L)                ; $2A6E8A
        MOVE.W  (A4),(A5)                       ; $2A6E8E
        BCLR    D1,(A1)                         ; $2A6E90
        DC.W    $FD7F,$FA9A         ; $2A6E92 MOVE.W  <EA:3F>,-$0566(A6)
        DC.W    $0218,$FDF0         ; $2A6E96 ANDI.B  #$FDF0,(A0)+
        MOVE.W  A1,(A5)                         ; $2A6E9A
        DC.W    $0238,$FE5B,$FA83   ; $2A6E9C ANDI.B  #$FE5B,$FA83.W
        BCLR    D1,-$16(A0,A7.L)                ; $2A6EA2
        MOVEA.W D2,A5                           ; $2A6EA6
        ANDI.W  #$FE22,A3                       ; $2A6EA8
        MOVE.W  $0165(A2),(A5)                  ; $2A6EAC
        MOVE.W  (A3)+,(A6)+                     ; $2A6EB0
        MOVE.W  (A6),(A5)                       ; $2A6EB2
        BTST    D0,-(A6)                        ; $2A6EB4
        DC.W    $FCFF               ; $2A6EB6 MOVE.W  <EA:3F>,(A6)+
        MOVE.W  $020D(A6),D5                    ; $2A6EB8
        MOVEA.W A0,A7                           ; $2A6EBC
        MOVE.W  $0285(A0),(A5)                  ; $2A6EBE
        MOVE.W  A3,(A7)                         ; $2A6EC2
        DC.W    $FBE6               ; $2A6EC4 MOVE.W  -(A6),<EA:3D>
        DC.W    $00FE               ; $2A6EC6 DC.W    $00FE
        MOVE.W  -(A2),(A7)                      ; $2A6EC8
        DC.W    $FBD8               ; $2A6ECA MOVE.W  (A0)+,<EA:3D>
        DC.W    $00FE               ; $2A6ECC DC.W    $00FE
        MOVE.W  (A5)+,-$0566(A7)                ; $2A6ECE
        ANDI.L  #$FF46FABE,D5                   ; $2A6ED2
        DC.W    $010E               ; $2A6ED8 BTST    D0,A6
        MOVE.W  (A5),(A7)                       ; $2A6EDA
        MOVEA.W (A7),A5                         ; $2A6EDC
        DC.W    $FFF4,$FF80         ; $2A6EDE MOVE.W  -$80(A4,A7.L),<EA:3F>
        MOVE.W  -(A2),D5                        ; $2A6EE2
        ORI.W  #$FFE6,(A3)+                     ; $2A6EE4
        MOVE.W  A3,(A5)                         ; $2A6EE8
        BCHG    D0,-$05(A5,A7.L)                ; $2A6EEA
        MOVE.W  (A6)+,#$FFF0                    ; $2A6EEE
        MOVE.W  A1,-$06FD(A7)                   ; $2A6EF2
        DC.W    $003E,$0103         ; $2A6EF6 ORI.B  #$0103,<EA:3E>
        MOVE.W  -(A4),-(A4)                     ; $2A6EFA
        ORI.L  #$0103F9FF,(A7)+                 ; $2A6EFC
        ORI.W  #$FF49,(A0)                      ; $2A6F02
        MOVE.W  $0137(A5),-(A5)                 ; $2A6F06
        MOVE.W  $21(PC,A7.L),(A7)               ; $2A6F0A
        DC.W    $00CA               ; $2A6F0E DC.W    $00CA
        MOVE.W  -$039D(A1),$68(A6,D0.W)         ; $2A6F10
        MOVE.W  A4,D7                           ; $2A6F16
        MOVE.W  $00D4(A7),-$00E3(A5)            ; $2A6F18
        MOVE.W  D2,D6                           ; $2A6F1E
        DC.W    $001B,$FD83         ; $2A6F20 ORI.B  #$FD83,(A3)+
loc_2A6F24:
        MOVEA.W (A6)+,A6                        ; $2A6F24
        ORI.W  #$FF6C,D6                        ; $2A6F26
        MOVE.W  -(A4),D6                        ; $2A6F2A
        ORI.L  #$FF6FFBC8,(A4)+                 ; $2A6F2C
        ORI.W  #$FD86,$00(A1,D0.W)              ; $2A6F32
        BGT.W  loc_2A6F3A                       ; $2A6F38
        DC.W    $0010,$0020         ; $2A6F3C ORI.B  #$0020,(A0)
        DC.W    $0030,$0000,$6400   ; $2A6F40 ORI.B  #$0000,$00(A0,D6.W)
        ORI.W  #$0050,D0                        ; $2A6F46
        ORI.W  #$0070,-(A0)                     ; $2A6F4A
        DC.W    $0000,$6B00         ; $2A6F4E ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A6F52
        DC.W    $00B0,$0000,$6400,$00C0; $2A6F58 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A6F60 DC.W    $00D0
        DC.W    $00E0               ; $2A6F62 DC.W    $00E0
        DC.W    $00F0               ; $2A6F64 DC.W    $00F0
        DC.W    $0000,$6B00         ; $2A6F66 ORI.B  #$6B00,D0
        BTST    D0,D0                           ; $2A6F6A
        BTST    D0,(A0)                         ; $2A6F6C
        BTST    D0,-(A0)                        ; $2A6F6E
loc_2A6F70:
        BTST    D0,$00(A0,D0.W)                 ; $2A6F70
        BCC.W  loc_2A70B6                       ; $2A6F74
        BCHG    D0,(A0)                         ; $2A6F78
        BCHG    D0,-(A0)                        ; $2A6F7A
        BCHG    D0,$00(A0,D0.W)                 ; $2A6F7C
        BEQ.W  loc_2A7102                       ; $2A6F80
        BCLR    D0,(A0)                         ; $2A6F84
        BCLR    D0,-(A0)                        ; $2A6F86
        BCLR    D0,$00(A0,D0.W)                 ; $2A6F88
        SUBI.B  #$01C0,D0                       ; $2A6F8C
        BSET    D0,(A0)                         ; $2A6F90
        BSET    D0,-(A0)                        ; $2A6F92
        BSET    D0,$00(A0,D0.W)                 ; $2A6F94
        BCC.W  loc_2A719A                       ; $2A6F98
        DC.W    $0210,$0220         ; $2A6F9C ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$0400   ; $2A6FA0 ANDI.B  #$0000,$00(A0,D0.W)
        ANDI.W  #$0250,D0                       ; $2A6FA6
        ANDI.W  #$0270,-(A0)                    ; $2A6FAA
        DC.W    $0000,$6400         ; $2A6FAE ORI.B  #$6400,D0
        ANDI.L  #$029002A0,D0                   ; $2A6FB2
        DC.W    $02B0,$0C00,$0030,$0030; $2A6FB8 ANDI.L  #$0C000030,$30(A0,D0.W)
        MOVE.W  $0412(A5),#$FDC9                ; $2A6FC0
        MOVE.W  D0,$12(A5,D0.W)                 ; $2A6FC6
        MOVEA.W A4,A7                           ; $2A6FCA
        MOVE.W  -(A5),-$5E(A5,D0.W)             ; $2A6FCC
        MOVE.W  $11(A6,A7.L),(A7)+              ; $2A6FD0
        SUBI.L  #$FE72F9F6,-(A1)                ; $2A6FD4
        DC.W    $04F4               ; $2A6FDA DC.W    $04F4
        MOVE.W  -(A6),-(A6)                     ; $2A6FDC
        MOVE.W  (A7)+,(A5)+                     ; $2A6FDE
        SUBI.W  #$FD7E,(A1)                     ; $2A6FE0
        MOVE.W  $04C3(PC),(A5)+                 ; $2A6FE4
        MOVE.W  D4,D7                           ; $2A6FE8
        MOVE.W  (A3),D5                         ; $2A6FEA
        BCHG    D2,-(A5)                        ; $2A6FEC
        MOVE.W  -$04B5(A2),$62(A6,D0.W)         ; $2A6FEE
        MOVE.W  (A4),$32(A6,A7.L)               ; $2A6FF4
        DC.W    $034C               ; $2A6FF8 BCHG    D1,A4
        MOVE.W  $38(A2,A7.L),D7                 ; $2A6FFA
        DC.W    $0388               ; $2A6FFE BCLR    D1,A0
        MOVE.W  (A0),(A7)                       ; $2A7000
        MOVE.W  (A2),$049D(A5)                  ; $2A7002
        DC.W    $FDF3,$FBEB         ; $2A7006 MOVE.W  -$15(A3,A7.L),<EA:3E>
        BCHG    D1,-$016A(A0)                   ; $2A700A
        DC.W    $FBEE,$0303         ; $2A700E MOVE.W  $0303(A6),<EA:3D>
        MOVE.W  D5,-(A6)                        ; $2A7012
        MOVE.W  D7,D6                           ; $2A7014
        DC.W    $02BE,$FD16,$FC04   ; $2A7016 ANDI.L  #$FD16FC04,<EA:3E>
        BTST    D1,-(A3)                        ; $2A701C
        MOVE.W  -(A7),(A7)                      ; $2A701E
        MOVE.W  $0349(A0),-$47(A4,A7.L)         ; $2A7020
        MOVE.W  -(A2),$037D(A5)                 ; $2A7026
        MOVE.W  (A3)+,D6                        ; $2A702A
        MOVE.W  A2,D6                           ; $2A702C
        BCLR    D0,-$6B(A6,A7.L)                ; $2A702E
        MOVEA.W (A1),A5                         ; $2A7032
        BCLR    D0,D2                           ; $2A7034
        MOVE.W  -$6D(A3,A7.L),D7                ; $2A7036
        SUBI.W  #$FE3D,-(A6)                    ; $2A703A
        DC.W    $FA3D               ; $2A703E MOVE.W  <EA:3D>,D5
        BTST    D1,D4                           ; $2A7040
        MOVE.W  -$05A8(A5),D7                   ; $2A7042
        DC.W    $030C               ; $2A7046 BTST    D1,A4
        MOVE.W  (A1)+,(A7)                      ; $2A7048
        MOVE.W  $046E(A6),-$58(A4,A7.L)         ; $2A704A
        DC.W    $F9F9,$030A,$FE82,$FA0B; $2A7050 MOVE.W  $030AFE82,#$FA0B
        ANDI.W  #$FD13,A1                       ; $2A7058
        MOVE.W  -(A1),D5                        ; $2A705C
        DC.W    $020A,$FD36         ; $2A705E ANDI.B  #$FD36,A2
        MOVE.W  A7,D5                           ; $2A7062
        DC.W    $02CA               ; $2A7064 DC.W    $02CA
        MOVE.W  -(A4),(A7)                      ; $2A7066
        MOVEA.W $5C(A0,D0.W),A5                 ; $2A7068
        MOVE.W  (A4)+,(A7)                      ; $2A706C
        MOVE.W  -(A7),-$2A(A5,D0.W)             ; $2A706E
        MOVEA.W (A3)+,A7                        ; $2A7072
        DC.W    $FBCD               ; $2A7074 MOVE.W  A5,<EA:3D>
        BSET    D0,(A6)                         ; $2A7076
        MOVE.W  (A2),-(A7)                      ; $2A7078
        MOVE.W  (A7),(A5)                       ; $2A707A
        BCHG    D1,(A4)+                        ; $2A707C
        MOVE.W  (A4),-$0583(A7)                 ; $2A707E
        DC.W    $0205,$FE9E         ; $2A7082 ANDI.B  #$FE9E,D5
        MOVE.W  -(A2),D5                        ; $2A7086
        DC.W    $00C6               ; $2A7088 DC.W    $00C6
        MOVE.W  (A5)+,-$05D8(A7)                ; $2A708A
        BTST    D0,(A4)                         ; $2A708E
        DC.W    $FFE2               ; $2A7090 MOVE.W  -(A2),<EA:3F>
        MOVE.W  D4,(A5)                         ; $2A7092
        ANDI.W  #$FF23,(A2)                     ; $2A7094
        MOVE.W  $0102(PC),$45(A4,A7.L)          ; $2A7098
        MOVE.W  A7,-(A4)                        ; $2A709E
        DC.W    $0008,$00D1         ; $2A70A0 ORI.B  #$00D1,A0
        MOVE.W  $0056(A5),-(A4)                 ; $2A70A4
        DC.W    $010F               ; $2A70A8 BTST    D0,A7
        MOVE.W  (A0)+,#$014F                    ; $2A70AA
        MOVE.W  D3,$02(A7,A7.L)                 ; $2A70AE
        DC.W    $021D,$FE9A         ; $2A70B2 ANDI.B  #$FE9A,(A5)+
loc_2A70B6:
        MOVE.W  -(A1),$60(A5,D0.W)              ; $2A70B6
        MOVE.W  -$23(A7,A7.L),$00F9(A6)         ; $2A70BA
        DC.W    $FDDB               ; $2A70C0 MOVE.W  (A3)+,<EA:3E>
        DC.W    $FB3D               ; $2A70C2 MOVE.W  <EA:3D>,-(A5)
        BCLR    D0,-$03(A7,A7.L)                ; $2A70C4
        MOVE.W  D4,$00DE(A5)                    ; $2A70C8
        MOVE.W  (A5)+,-$03B5(A6)                ; $2A70CC
        DC.W    $0018,$FED4         ; $2A70D0 ORI.B  #$FED4,(A0)+
        MOVE.W  $006D(PC),D6                    ; $2A70D4
        MOVE.W  A5,-(A7)                        ; $2A70D8
        MOVE.W  $33(A3,D0.W),-(A5)              ; $2A70DA
        MOVE.W  (A5),$00(A6,D0.W)               ; $2A70DE
        BGT.W  loc_2A70E4                       ; $2A70E2
        DC.W    $0010,$0020         ; $2A70E6 ORI.B  #$0020,(A0)
        DC.W    $0030,$0000,$6400   ; $2A70EA ORI.B  #$0000,$00(A0,D6.W)
        ORI.W  #$0050,D0                        ; $2A70F0
        ORI.W  #$0070,-(A0)                     ; $2A70F4
        DC.W    $0000,$6B00         ; $2A70F8 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A70FC
loc_2A7102:
        DC.W    $00B0,$0000,$6400,$00C0; $2A7102 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A710A DC.W    $00D0
        DC.W    $00E0               ; $2A710C DC.W    $00E0
        DC.W    $00F0               ; $2A710E DC.W    $00F0
        DC.W    $0000,$0300         ; $2A7110 ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A7114
        BTST    D0,(A0)                         ; $2A7116
        BTST    D0,-(A0)                        ; $2A7118
        BTST    D0,$00(A0,D0.W)                 ; $2A711A
        BMI.W  loc_2A7260                       ; $2A711E
        BCHG    D0,(A0)                         ; $2A7122
        BCHG    D0,-(A0)                        ; $2A7124
        BCHG    D0,$00(A0,D0.W)                 ; $2A7126
        BCC.W  loc_2A72AC                       ; $2A712A
        BCLR    D0,(A0)                         ; $2A712E
        BCLR    D0,-(A0)                        ; $2A7130
        BCLR    D0,$00(A0,D0.W)                 ; $2A7132
        BEQ.W  loc_2A72F8                       ; $2A7136
        BSET    D0,(A0)                         ; $2A713A
        BSET    D0,-(A0)                        ; $2A713C
        BSET    D0,$00(A0,D0.W)                 ; $2A713E
        SUBI.B  #$0200,D0                       ; $2A7142
        DC.W    $0210,$0220         ; $2A7146 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A714A ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A7150
        ANDI.W  #$0270,-(A0)                    ; $2A7154
        DC.W    $0000,$0400         ; $2A7158 ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A715C
        DC.W    $02B0,$0000,$6400,$02C0; $2A7162 ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A716A DC.W    $02D0
        DC.W    $02E0               ; $2A716C DC.W    $02E0
        DC.W    $02F0               ; $2A716E DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A7170
        DC.W    $0030,$F962,$046B   ; $2A7174 ORI.B  #$F962,$6B(A0,D0.W)
        MOVE.W  (A4),-(A7)                      ; $2A717A
        MOVE.W  $0353(A4),(A5)+                 ; $2A717C
        MOVE.W  -$0490(A0),(A7)                 ; $2A7180
        BSET    D1,-(A0)                        ; $2A7184
        MOVE.W  (A5)+,-(A7)                     ; $2A7186
        MOVE.W  -(A6),#$04F8                    ; $2A7188
        MOVE.W  A1,$1B(A7,A7.L)                 ; $2A718C
        DC.W    $054D               ; $2A7190 BCHG    D2,A5
        MOVE.W  D0,(A7)                         ; $2A7192
        MOVE.W  D5,D5                           ; $2A7194
        SUBI.L  #$FE4EFA6C,(A5)+                ; $2A7196
        DC.W    $050C               ; $2A719C BTST    D2,A4
        MOVE.W  -$067D(A1),(A7)                 ; $2A719E
        BCLR    D2,#$FEDC                       ; $2A71A2
        MOVEA.W -$3E(A4,D0.W),A5                ; $2A71A6
        MOVE.W  -$04D1(A4),D7                   ; $2A71AA
        BCHG    D1,-$01EE(A2)                   ; $2A71AE
        MOVE.W  -$72(PC,D0.W),-$01A4(A5)        ; $2A71B2
        MOVE.W  D0,(A5)+                        ; $2A71B8
        DC.W    $04E7               ; $2A71BA DC.W    $04E7
        MOVEA.W $38(A5,A7.L),A7                 ; $2A71BC
        BCLR    D1,D0                           ; $2A71C0
        MOVE.W  A4,(A7)                         ; $2A71C2
        MOVE.W  $5A(PC,D0.W),D5                 ; $2A71C4
        MOVE.W  D6,-$05B8(A6)                   ; $2A71C8
        DC.W    $030F               ; $2A71CC BTST    D1,A7
        MOVE.W  D4,-$04BC(A6)                   ; $2A71CE
        BTST    D1,-$75(A5,A7.L)                ; $2A71D2
        MOVE.W  (A0),-(A4)                      ; $2A71D6
        BSET    D1,$4F(A4,A7.L)                 ; $2A71D8
        MOVE.W  A7,$54(A4,D0.W)                 ; $2A71DC
        MOVE.W  D5,-(A6)                        ; $2A71E0
        MOVE.W  (A4),$66(A4,D0.W)               ; $2A71E2
        MOVE.W  $15(A5,A7.L),(A6)               ; $2A71E6
        DC.W    $0206,$FEFF         ; $2A71EA ANDI.B  #$FEFF,D6
        MOVE.W  -(A6),$04CD(A4)                 ; $2A71EE
        MOVE.W  -(A3),-$62(A7,A7.L)             ; $2A71F2
        DC.W    $034F               ; $2A71F6 BCHG    D1,A7
        MOVE.W  (A1)+,-$0609(A7)                ; $2A71F8
        DC.W    $034F               ; $2A71FC BCHG    D1,A7
        MOVE.W  (A4)+,-$41(A7,A7.L)             ; $2A71FE
        DC.W    $04CD               ; $2A7202 DC.W    $04CD
        DC.W    $FFE7               ; $2A7204 MOVE.W  -(A7),<EA:3F>
        MOVE.W  -(A7),$61(A4,D0.W)              ; $2A7206
        DC.W    $FFC8               ; $2A720A MOVE.W  A0,<EA:3F>
        MOVE.W  (A3)+,(A4)                      ; $2A720C
        DC.W    $02E6               ; $2A720E DC.W    $02E6
        MOVE.W  -(A5),(A7)                      ; $2A7210
        MOVE.W  $029E(A5),(A4)                  ; $2A7212
        MOVE.W  -$47(A4,A7.L),(A7)              ; $2A7216
        BTST    D1,(A1)+                        ; $2A721A
        DC.W    $FFD7               ; $2A721C MOVE.W  (A7),<EA:3F>
        MOVE.W  -$6D(PC,D0.W),D5                ; $2A721E
        MOVE.W  (A3),$23(A7,A7.L)               ; $2A7222
        DC.W    $021F,$FE9B         ; $2A7226 ANDI.B  #$FE9B,(A7)+
        MOVE.W  $2D(A5,D0.W),$12(A5,A7.L)       ; $2A722A
        MOVE.W  A3,(A5)+                        ; $2A7230
        BCLR    D1,(A7)+                        ; $2A7232
        DC.W    $0008,$FA83         ; $2A7234 ORI.B  #$FA83,A0
        ANDI.L  #$FF9CF983,-(A0)                ; $2A7238
        DC.W    $0189               ; $2A723E BCLR    D0,A1
        MOVE.W  -$0634(A0),$0132(A7)            ; $2A7240
        DC.W    $FFD0               ; $2A7246 MOVE.W  (A0),<EA:3F>
        MOVE.W  A3,(A5)+                        ; $2A7248
        ANDI.W  #$0005,A1                       ; $2A724A
        MOVE.W  D3,$01C3(A4)                    ; $2A724E
        DC.W    $FFC5               ; $2A7252 MOVE.W  D5,<EA:3F>
        MOVE.W  $000A(A3),(A4)+                 ; $2A7254
        ORI.L  #$F94B000A,(A6)+                 ; $2A7258
        DC.W    $00C4               ; $2A725E DC.W    $00C4
loc_2A7260:
        MOVE.W  -(A2),-$3E(A4,D0.W)             ; $2A7260
        DC.W    $FFEA,$FAC5         ; $2A7264 MOVE.W  -$053B(A2),<EA:3F>
        ANDI.W  #$FF30,(A1)                     ; $2A7268
        MOVE.W  (A0),(A5)+                      ; $2A726C
        BCHG    D0,-(A2)                        ; $2A726E
        MOVE.W  D6,D7                           ; $2A7270
        MOVE.W  A7,$0120(A5)                    ; $2A7272
        MOVEA.W D0,A7                           ; $2A7276
        MOVE.W  D3,$0210(A5)                    ; $2A7278
        MOVE.W  -$0575(A1),$00EA(A7)            ; $2A727C
        DC.W    $FE3D               ; $2A7282 MOVE.W  <EA:3D>,D7
        MOVEA.W A1,A6                           ; $2A7284
        DC.W    $0019,$FE92         ; $2A7286 ORI.B  #$FE92,(A1)+
        MOVEA.W -(A4),A6                        ; $2A728A
        ORI.W  #$FECC,-$055A(A2)                ; $2A728C
        BTST    D0,#$FE77                       ; $2A7292
        DC.W    $0000,$6E00         ; $2A7296 ORI.B  #$6E00,D0
        DC.W    $0000,$0010         ; $2A729A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A729E ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A72A2 ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A72A6
        ORI.W  #$0070,-(A0)                     ; $2A72AA
        DC.W    $0000,$6B00         ; $2A72AE ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A72B2
        DC.W    $00B0,$0000,$6400,$00C0; $2A72B8 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A72C0 DC.W    $00D0
        DC.W    $00E0               ; $2A72C2 DC.W    $00E0
        DC.W    $00F0               ; $2A72C4 DC.W    $00F0
        DC.W    $0000,$0300         ; $2A72C6 ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A72CA
        BTST    D0,(A0)                         ; $2A72CC
        BTST    D0,-(A0)                        ; $2A72CE
        BTST    D0,$00(A0,D0.W)                 ; $2A72D0
        BMI.W  loc_2A7416                       ; $2A72D4
        BCHG    D0,(A0)                         ; $2A72D8
        BCHG    D0,-(A0)                        ; $2A72DA
        BCHG    D0,$00(A0,D0.W)                 ; $2A72DC
        BCC.W  loc_2A7462                       ; $2A72E0
        BCLR    D0,(A0)                         ; $2A72E4
        BCLR    D0,-(A0)                        ; $2A72E6
        BCLR    D0,$00(A0,D0.W)                 ; $2A72E8
        BEQ.W  loc_2A74AE                       ; $2A72EC
        BSET    D0,(A0)                         ; $2A72F0
        BSET    D0,-(A0)                        ; $2A72F2
        BSET    D0,$00(A0,D0.W)                 ; $2A72F4
loc_2A72F8:
        SUBI.B  #$0200,D0                       ; $2A72F8
        DC.W    $0210,$0220         ; $2A72FC ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A7300 ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A7306
        ANDI.W  #$0270,-(A0)                    ; $2A730A
        DC.W    $0000,$0400         ; $2A730E ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A7312
        DC.W    $02B0,$0000,$6400,$02C0; $2A7318 ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A7320 DC.W    $02D0
        DC.W    $02E0               ; $2A7322 DC.W    $02E0
        DC.W    $02F0               ; $2A7324 DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A7326
        DC.W    $0030,$F9A8,$051F   ; $2A732A ORI.B  #$F9A8,$1F(A0,D0.W)
        ORI.W  #$FA47,-$52(A4,D0.W)             ; $2A7330
        MOVE.W  (A3),-$04EA(A7)                 ; $2A7336
        SUBI.B  #$FF53,D7                       ; $2A733A
        DC.W    $FA77,$0578         ; $2A733E MOVEA.W $78(A7,D0.W),A5
        ORI.W  #$F958,$17(A4,D0.W)              ; $2A7342
        DC.W    $0010,$F9BB         ; $2A7348 ORI.B  #$F9BB,(A0)
        BTST    D2,$72(A2,A7.L)                 ; $2A734C
        MOVEA.W (A5)+,A5                        ; $2A7350
        BCHG    D2,$72(A7,A7.L)                 ; $2A7352
        DC.W    $F9F9,$065D,$0010,$F9F0; $2A7356 MOVE.W  $065D0010,#$F9F0
        BTST    D2,(A4)+                        ; $2A735E
        MOVE.W  (A3),-(A7)                      ; $2A7360
        MOVEA.W -$3D(A2,D0.W),A5                ; $2A7362
        MOVE.W  A5,(A7)                         ; $2A7366
        MOVE.W  (A3)+,(A5)+                     ; $2A7368
        BSET    D1,-(A3)                        ; $2A736A
        MOVE.W  (A7)+,(A7)                      ; $2A736C
        MOVEA.W (A2)+,A5                        ; $2A736E
        DC.W    $053D               ; $2A7370 BTST    D2,<EA:3D>
        MOVE.W  -(A5),-(A7)                     ; $2A7372
        MOVE.W  $03D6FEED,(A5)                  ; $2A7374
        MOVE.W  -$6A(A7,D0.W),-(A4)             ; $2A737A
        MOVEA.W -(A5),A7                        ; $2A737E
        MOVE.W  D6,$034D(A4)                    ; $2A7380
        MOVEA.W (A4)+,A7                        ; $2A7384
        MOVE.W  A0,(A5)+                        ; $2A7386
        DC.W    $038C               ; $2A7388 BCLR    D1,A4
        MOVE.W  -(A4),(A7)+                     ; $2A738A
        MOVE.W  $34(A4,D0.W),$00BF(A4)          ; $2A738C
        MOVEA.W A6,A4                           ; $2A7392
        SUBI.W  #$FEAE,A6                       ; $2A7394
        MOVE.W  (A5),(A4)                       ; $2A7398
        ANDI.W  #$FE6E,-(A3)                    ; $2A739A
        MOVE.W  $48(PC,D0.W),-$80(A4,D0.W)      ; $2A739E
        MOVE.W  D6,D5                           ; $2A73A4
        BCHG    D2,-(A4)                        ; $2A73A6
        DC.W    $00E2               ; $2A73A8 DC.W    $00E2
        MOVE.W  -$16(A2,D0.W),#$0077            ; $2A73AA
        MOVEA.W -(A2),A5                        ; $2A73B0
        BSET    D1,-(A2)                        ; $2A73B2
        ORI.L  #$FA74055C,D0                    ; $2A73B4
        DC.W    $00EA               ; $2A73BA DC.W    $00EA
        MOVE.W  -(A3),D5                        ; $2A73BC
        BSET    D1,-$31(A5,D0.W)                ; $2A73BE
        MOVE.W  -(A1),(A4)+                     ; $2A73C2
        BTST    D1,D7                           ; $2A73C4
        ORI.W  #$F90E,$02C9(A2)                 ; $2A73C6
        ORI.W  #$FA50,$03B9(A4)                 ; $2A73CC
        DC.W    $00D1               ; $2A73D2 DC.W    $00D1
        MOVEA.W (A0)+,A5                        ; $2A73D4
        BSET    D1,(A6)                         ; $2A73D6
        ORI.W  #$FA9A,$56(A6,D0.W)              ; $2A73D8
        MOVE.W  $FB520275,-(A7)                 ; $2A73DE
        MOVE.W  $FB1003F5,-(A7)                 ; $2A73E4
        ORI.W  #$FAB7,-$28(A6,D0.W)             ; $2A73EA
        DC.W    $0079,$F991,$01F4,$001F; $2A73F0 ORI.W  #$F991,$01F4001F
        MOVE.W  $0179(A6),#$0025                ; $2A73F8
        MOVE.W  (A4),-(A5)                      ; $2A73FE
        ANDI.W  #$007E,(A5)+                    ; $2A7400
        MOVE.W  (A3),-$0A(A4,D0.W)              ; $2A7404
        ORI.L  #$F8CC002D,(A2)+                 ; $2A7408
        ORI.L  #$F92C0004,D2                    ; $2A740E
        DC.W    $007C,$F9F1,$01CD   ; $2A7414 ORI.W  #$F9F1,#$01CD
        ORI.L  #$FAAC0276,(A6)                  ; $2A741A
        DC.W    $FFDF               ; $2A7420 MOVE.W  (A7)+,<EA:3F>
        MOVE.W  (A2),(A5)                       ; $2A7422
        DC.W    $014F               ; $2A7424 BCHG    D0,A7
        MOVE.W  -$04D6(A6),(A7)+                ; $2A7426
        BCHG    D0,(A3)                         ; $2A742A
        MOVE.W  (A1)+,(A7)+                     ; $2A742C
        MOVE.W  D4,$027A(A5)                    ; $2A742E
        DC.W    $FFCA               ; $2A7432 MOVE.W  A2,<EA:3F>
        MOVE.W  -(A2),(A5)                      ; $2A7434
        BTST    D0,D0                           ; $2A7436
        MOVE.W  (A4),-$03E9(A7)                 ; $2A7438
        DC.W    $0012,$FE6B         ; $2A743C ORI.B  #$FE6B,(A2)
        MOVEA.W (A4),A6                         ; $2A7440
        ORI.W  #$FE7B,-(A3)                     ; $2A7442
        MOVE.W  -(A0),(A5)+                     ; $2A7446
        BCHG    D0,(A0)                         ; $2A7448
        MOVE.W  -(A5),$0000(A7)                 ; $2A744A
        BGT.W  loc_2A7450                       ; $2A744E
        DC.W    $0010,$0020         ; $2A7452 ORI.B  #$0020,(A0)
        DC.W    $0030,$0000,$6400   ; $2A7456 ORI.B  #$0000,$00(A0,D6.W)
        ORI.W  #$0050,D0                        ; $2A745C
        ORI.W  #$0070,-(A0)                     ; $2A7460
        DC.W    $0000,$6B00         ; $2A7464 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A7468
        DC.W    $00B0,$0000,$6400,$00C0; $2A746E ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A7476 DC.W    $00D0
        DC.W    $00E0               ; $2A7478 DC.W    $00E0
        DC.W    $00F0               ; $2A747A DC.W    $00F0
        DC.W    $0000,$0300         ; $2A747C ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A7480
        BTST    D0,(A0)                         ; $2A7482
        BTST    D0,-(A0)                        ; $2A7484
        BTST    D0,$00(A0,D0.W)                 ; $2A7486
        BMI.W  loc_2A75CC                       ; $2A748A
        BCHG    D0,(A0)                         ; $2A748E
        BCHG    D0,-(A0)                        ; $2A7490
        BCHG    D0,$00(A0,D0.W)                 ; $2A7492
        BCC.W  loc_2A7618                       ; $2A7496
        BCLR    D0,(A0)                         ; $2A749A
        BCLR    D0,-(A0)                        ; $2A749C
        BCLR    D0,$00(A0,D0.W)                 ; $2A749E
        BEQ.W  loc_2A7664                       ; $2A74A2
        BSET    D0,(A0)                         ; $2A74A6
        BSET    D0,-(A0)                        ; $2A74A8
        BSET    D0,$00(A0,D0.W)                 ; $2A74AA
loc_2A74AE:
        SUBI.B  #$0200,D0                       ; $2A74AE
        DC.W    $0210,$0220         ; $2A74B2 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A74B6 ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A74BC
        ANDI.W  #$0270,-(A0)                    ; $2A74C0
        DC.W    $0000,$0400         ; $2A74C4 ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A74C8
        DC.W    $02B0,$0000,$6400,$02C0; $2A74CE ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A74D6 DC.W    $02D0
        DC.W    $02E0               ; $2A74D8 DC.W    $02E0
        DC.W    $02F0               ; $2A74DA DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A74DC
        DC.W    $0030,$F923,$0457   ; $2A74E0 ORI.B  #$F923,$57(A0,D0.W)
        DC.W    $007C,$F9E4,$02FA   ; $2A74E6 ORI.W  #$F9E4,#$02FA
        MOVE.W  (A4),-$0557(A7)                 ; $2A74EC
        BCHG    D1,-(A7)                        ; $2A74F0
        MOVE.W  (A4),-$0617(A7)                 ; $2A74F2
        DC.W    $04C3               ; $2A74F6 DC.W    $04C3
        DC.W    $007C,$F8BB,$0546   ; $2A74F8 ORI.W  #$F8BB,#$0546
        DC.W    $001C,$F932         ; $2A74FE ORI.B  #$F932,(A4)+
        SUBI.W  #$FF79,-$0634(A6)               ; $2A7502
        DC.W    $04C3               ; $2A7508 DC.W    $04C3
        DC.W    $FF79,$F955,$059C,$001C; $2A750A MOVE.W  $F955059C,$001C(A7)
        MOVE.W  -(A5),$0456(A4)                 ; $2A7512
        MOVE.W  (A2)+,-(A7)                     ; $2A7516
        MOVE.W  -(A4),D5                        ; $2A7518
        BTST    D1,(A6)+                        ; $2A751A
        MOVE.W  A1,(A7)                         ; $2A751C
        MOVE.W  D6,(A5)                         ; $2A751E
        BCHG    D1,(A0)                         ; $2A7520
        MOVE.W  (A5)+,(A7)                      ; $2A7522
        MOVE.W  D7,#$0488                       ; $2A7524
        MOVE.W  -$0598(A7),-(A7)                ; $2A7528
        BTST    D1,-$16(PC,A7.L)                ; $2A752C
        MOVE.W  -$3F(A5,D0.W),(A4)+             ; $2A7530
        MOVEA.W -(A1),A7                        ; $2A7534
        MOVE.W  (A0),-(A4)                      ; $2A7536
        ANDI.W  #$FE55,-$7C(PC,A7.L)            ; $2A7538
        DC.W    $02F5               ; $2A753E DC.W    $02F5
        MOVE.W  (A6)+,(A7)+                     ; $2A7540
        MOVE.W  $0356(A6),$00C3(A4)             ; $2A7542
        MOVE.W  (A1),D4                         ; $2A7548
        BCLR    D1,D0                           ; $2A754A
        MOVE.W  (A4),(A7)+                      ; $2A754C
        MOVEA.W (A3)+,A4                        ; $2A754E
        BCLR    D0,(A0)+                        ; $2A7550
        MOVEA.W $F9B8.W,A7                      ; $2A7552
        BCHG    D0,$0066(A7)                    ; $2A7556
        MOVE.W  -(A2),$0485(A4)                 ; $2A755A
        DC.W    $00EA               ; $2A755E DC.W    $00EA
        DC.W    $F9F9,$032C,$0078,$FA60; $2A7560 MOVE.W  $032C0078,#$FA60
        BCHG    D1,(A7)                         ; $2A7568
        ORI.L  #$F9C904AF,D2                    ; $2A756A
        DC.W    $00F2               ; $2A7570 DC.W    $00F2
        MOVE.W  $035200D3,D5                    ; $2A7572
        MOVE.W  $0278(A1),(A4)+                 ; $2A7578
        ORI.W  #$F912,$0239(A1)                 ; $2A757C
        ORI.W  #$FA62,-(A7)                     ; $2A7582
        BTST    D1,(A3)                         ; $2A7586
        DC.W    $00D1               ; $2A7588 DC.W    $00D1
        MOVE.W  $13(A2,D0.W),#$0076             ; $2A758A
        MOVE.W  D4,(A5)                         ; $2A7590
        BCLR    D0,-$00C6(A1)                   ; $2A7592
        MOVE.W  -$10(A2,D0.W),-(A5)             ; $2A7596
        MOVE.W  -$0560(PC),-(A7)                ; $2A759A
        BCHG    D1,(A2)+                        ; $2A759E
        ORI.W  #$FAB0,$51(A6,D0.W)              ; $2A75A0
        ORI.W  #$F942,$0B(A4,D0.W)              ; $2A75A6
        DC.W    $001D,$F95C         ; $2A75AC ORI.B  #$F95C,(A5)+
        BCHG    D0,$2E(A3,D0.W)                 ; $2A75B0
        MOVE.W  A0,(A5)+                        ; $2A75B4
        BCLR    D0,$0086(PC)                    ; $2A75B6
        MOVE.W  A3,-(A4)                        ; $2A75BA
        DC.W    $0207,$00A1         ; $2A75BC ANDI.B  #$00A1,D7
        MOVE.W  -(A2),(A4)+                     ; $2A75C0
        DC.W    $0015,$0085         ; $2A75C2 ORI.B  #$0085,(A5)
        MOVE.W  A0,$000E(A4)                    ; $2A75C6
        ORI.W  #$F971,$01FE.W                   ; $2A75CA
        ORI.L  #$FA9301D8,(A4)                  ; $2A75D0
        DC.W    $FFE8,$FA4F         ; $2A75D6 MOVE.W  -$05B1(A0),<EA:3F>
        DC.W    $00B8,$FEF6,$FAE2,$00BE; $2A75DA ORI.L  #$FEF6FAE2,$00BE.W
        MOVE.W  D7,(A7)+                        ; $2A75E2
        MOVE.W  -(A5),-(A5)                     ; $2A75E4
        BSET    D0,(A6)+                        ; $2A75E6
        DC.W    $FFB9,$FA87,$0038,$FF3E; $2A75E8 MOVE.W  $FA870038,$3E(A7,A7.L)
        MOVE.W  -$57(PC,D0.W),D6                ; $2A75F0
        MOVEA.W -(A6),A7                        ; $2A75F4
        MOVE.W  $0A(A4,D0.W),D6                 ; $2A75F6
        MOVE.W  A3,(A7)                         ; $2A75FA
        MOVE.W  D0,(A5)                         ; $2A75FC
        ORI.L  #$FF630000,(A0)+                 ; $2A75FE
        BGT.W  loc_2A7606                       ; $2A7604
        DC.W    $0010,$0020         ; $2A7608 ORI.B  #$0020,(A0)
        DC.W    $0030,$0000,$6400   ; $2A760C ORI.B  #$0000,$00(A0,D6.W)
        ORI.W  #$0050,D0                        ; $2A7612
        ORI.W  #$0070,-(A0)                     ; $2A7616
        DC.W    $0000,$6B00         ; $2A761A ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A761E
        DC.W    $00B0,$0000,$6400,$00C0; $2A7624 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A762C DC.W    $00D0
        DC.W    $00E0               ; $2A762E DC.W    $00E0
        DC.W    $00F0               ; $2A7630 DC.W    $00F0
        DC.W    $0000,$0300         ; $2A7632 ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A7636
        BTST    D0,(A0)                         ; $2A7638
        BTST    D0,-(A0)                        ; $2A763A
        BTST    D0,$00(A0,D0.W)                 ; $2A763C
        BMI.W  loc_2A7782                       ; $2A7640
        BCHG    D0,(A0)                         ; $2A7644
        BCHG    D0,-(A0)                        ; $2A7646
        BCHG    D0,$00(A0,D0.W)                 ; $2A7648
        BCC.W  loc_2A77CE                       ; $2A764C
        BCLR    D0,(A0)                         ; $2A7650
        BCLR    D0,-(A0)                        ; $2A7652
        BCLR    D0,$00(A0,D0.W)                 ; $2A7654
        BEQ.W  loc_2A781A                       ; $2A7658
        BSET    D0,(A0)                         ; $2A765C
        BSET    D0,-(A0)                        ; $2A765E
        BSET    D0,$00(A0,D0.W)                 ; $2A7660
loc_2A7664:
        SUBI.B  #$0200,D0                       ; $2A7664
        DC.W    $0210,$0220         ; $2A7668 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A766C ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A7672
        ANDI.W  #$0270,-(A0)                    ; $2A7676
        DC.W    $0000,$0400         ; $2A767A ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A767E
        DC.W    $02B0,$0000,$6400,$02C0; $2A7684 ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A768C DC.W    $02D0
        DC.W    $02E0               ; $2A768E DC.W    $02E0
        DC.W    $02F0               ; $2A7690 DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A7692
        DC.W    $0030,$F8AE,$0381   ; $2A7696 ORI.B  #$F8AE,-$7F(A0,D0.W)
        ORI.L  #$F9B2025C,D4                    ; $2A769C
        MOVE.W  (A4),-$05A5(A7)                 ; $2A76A2
        DC.W    $02F2               ; $2A76A6 DC.W    $02F2
        MOVE.W  (A4),-$06A9(A7)                 ; $2A76A8
        SUBI.B  #$0084,(A6)                     ; $2A76AC
        MOVE.W  (A1),D4                         ; $2A76B0
        SUBI.W  #$0029,(A6)                     ; $2A76B2
        MOVE.W  -$62(A3,D0.W),(A4)              ; $2A76B6
        MOVE.W  D2,$37(A7,A7.L)                 ; $2A76BA
        SUBI.B  #$FF82,(A4)                     ; $2A76BE
        MOVE.W  (A5),(A4)                       ; $2A76C2
        DC.W    $04CA               ; $2A76C4 DC.W    $04CA
        DC.W    $0029,$F8EA,$03A3   ; $2A76C6 ORI.B  #$F8EA,$03A3(A1)
        MOVE.W  -(A0),-(A7)                     ; $2A76CC
        MOVE.W  A2,#$027E                       ; $2A76CE
        MOVE.W  (A7),(A7)                       ; $2A76D2
        MOVE.W  -(A5),D5                        ; $2A76D4
        DC.W    $02BD,$FEA7,$F946   ; $2A76D6 ANDI.L  #$FEA7F946,<EA:3D>
        BSET    D1,-(A1)                        ; $2A76DC
        MOVE.W  $0E(A1,A7.L),-(A7)              ; $2A76DE
        ANDI.L  #$FEF5F8A3,-(A6)                ; $2A76E2
        DC.W    $0208,$FE7A         ; $2A76E8 ANDI.B  #$FE7A,A0
        MOVE.W  D4,(A4)+                        ; $2A76EC
        BSET    D0,D4                           ; $2A76EE
        MOVEA.W $2F(A0,A7.L),A7                 ; $2A76F0
        ANDI.W  #$FEEB,-(A3)                    ; $2A76F4
        MOVE.W  (A0),$02A6(A4)                  ; $2A76F8
        DC.W    $00D7               ; $2A76FC DC.W    $00D7
        MOVE.W  $030C(A6),-$0C(PC,A7.L)         ; $2A76FE
        MOVE.W  (A1)+,$1F(PC,D0.W)              ; $2A7704
        MOVE.W  (A5)+,(A7)                      ; $2A7708
        MOVE.W  $00BA(PC),-(A4)                 ; $2A770A
        DC.W    $007E,$F8E2         ; $2A770E ORI.W  #$F8E2,<EA:3E>
        BCLR    D1,#$00EF                       ; $2A7712
        DC.W    $F9BE,$0287         ; $2A7716 MOVE.W  <EA:3E>,-$79(A4,D0.W)
        ORI.L  #$FA1902C6,A1                    ; $2A771A
        ORI.L  #$F93E03FB,A6                    ; $2A7720
        DC.W    $00F4               ; $2A7726 DC.W    $00F4
        DC.W    $F9FE,$02BF         ; $2A7728 MOVE.W  <EA:3E>,#$02BF
        DC.W    $00E1               ; $2A772C DC.W    $00E1
        MOVE.W  -$25(A1,D0.W),(A4)              ; $2A772E
        ORI.L  #$F8DB019C,D7                    ; $2A7732
        ORI.L  #$FA280281,D6                    ; $2A7738
        DC.W    $00E1               ; $2A773E DC.W    $00E1
        MOVE.W  #$0277,$75(A4,D0.W)             ; $2A7740
        MOVE.W  (A6),(A5)                       ; $2A7746
        BTST    D0,$39(A4,A7.L)                 ; $2A7748
        MOVE.W  -$63(A2,D0.W),-(A5)             ; $2A774C
        MOVE.W  $FA5802E0,-(A7)                 ; $2A7750
        ORI.W  #$FAC2,-$14(A5,D0.W)             ; $2A7756
        ORI.W  #$F94E,$02(A0,D0.W)              ; $2A775C
        DC.W    $001C,$F940         ; $2A7762 ORI.B  #$F940,(A4)+
        BCHG    D0,$0033(A2)                    ; $2A7766
        MOVE.W  $53(A5,D0.W),(A5)               ; $2A776A
        ORI.L  #$F9090207,D7                    ; $2A776E
        ORI.L  #$F8E10015,-(A4)                 ; $2A7774
        ORI.L  #$F946000E,D7                    ; $2A777A
        ORI.W  #$F96E,$00(A6,D0.W)              ; $2A7780
        ORI.L  #$FA9E0166,(A3)                  ; $2A7786
        DC.W    $FFEA,$FA70         ; $2A778C MOVE.W  -$0590(A2),<EA:3F>
        ORI.W  #$FEF8,D2                        ; $2A7790
        MOVE.W  $5D(PC,D0.W),(A5)+              ; $2A7794
        MOVE.W  #$FB2A,(A7)                     ; $2A7798
        BCLR    D0,D2                           ; $2A779C
        MOVE.W  -$0533(A7),-$3B(A7,A7.L)        ; $2A779E
        MOVE.W  $38(A0,A7.L),-(A7)              ; $2A77A4
        DC.W    $00D9               ; $2A77A8 DC.W    $00D9
        MOVEA.W -(A5),A7                        ; $2A77AA
        MOVE.W  (A2),D6                         ; $2A77AC
        BTST    D0,-$016D(A5)                   ; $2A77AE
        MOVE.W  -(A7),(A5)                      ; $2A77B2
        DC.W    $0018,$FF5E         ; $2A77B4 ORI.B  #$FF5E,(A0)+
        DC.W    $0000,$6E00         ; $2A77B8 ORI.B  #$6E00,D0
        DC.W    $0000,$0010         ; $2A77BC ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A77C0 ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A77C4 ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A77C8
        ORI.W  #$0070,-(A0)                     ; $2A77CC
        DC.W    $0000,$6B00         ; $2A77D0 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A77D4
        DC.W    $00B0,$0000,$6400,$00C0; $2A77DA ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A77E2 DC.W    $00D0
        DC.W    $00E0               ; $2A77E4 DC.W    $00E0
        DC.W    $00F0               ; $2A77E6 DC.W    $00F0
        DC.W    $0000,$0300         ; $2A77E8 ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A77EC
        BTST    D0,(A0)                         ; $2A77EE
        BTST    D0,-(A0)                        ; $2A77F0
        BTST    D0,$00(A0,D0.W)                 ; $2A77F2
        BMI.W  loc_2A7938                       ; $2A77F6
        BCHG    D0,(A0)                         ; $2A77FA
        BCHG    D0,-(A0)                        ; $2A77FC
        BCHG    D0,$00(A0,D0.W)                 ; $2A77FE
        BCC.W  loc_2A7984                       ; $2A7802
        BCLR    D0,(A0)                         ; $2A7806
        BCLR    D0,-(A0)                        ; $2A7808
        BCLR    D0,$00(A0,D0.W)                 ; $2A780A
        BEQ.W  loc_2A79D0                       ; $2A780E
        BSET    D0,(A0)                         ; $2A7812
        BSET    D0,-(A0)                        ; $2A7814
        BSET    D0,$00(A0,D0.W)                 ; $2A7816
loc_2A781A:
        SUBI.B  #$0200,D0                       ; $2A781A
        DC.W    $0210,$0220         ; $2A781E ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A7822 ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A7828
        ANDI.W  #$0270,-(A0)                    ; $2A782C
        DC.W    $0000,$0400         ; $2A7830 ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A7834
        DC.W    $02B0,$0000,$6400,$02C0; $2A783A ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A7842 DC.W    $02D0
        DC.W    $02E0               ; $2A7844 DC.W    $02E0
        DC.W    $02F0               ; $2A7846 DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A7848
        DC.W    $0030,$F851,$02A9   ; $2A784C ORI.B  #$F851,-$57(A0,D0.W)
        ORI.L  #$F99901DF,A3                    ; $2A7852
        MOVE.W  (A3),-$05F1(A7)                 ; $2A7858
        ANDI.L  #$FF53F8C7,(A6)+                ; $2A785C
        BCHG    D1,$008B(A1)                    ; $2A7862
        MOVE.W  #$0348,$0036(A3)                ; $2A7866
        MOVEA.W A1,A4                           ; $2A786C
        DC.W    $02CA               ; $2A786E DC.W    $02CA
        MOVE.W  A2,-$5A(A7,A7.L)                ; $2A7870
        BCHG    D1,-(A1)                        ; $2A7874
        MOVE.W  A2,-$26(A7,A7.W)                ; $2A7876
        BSET    D1,(A7)+                        ; $2A787A
        DC.W    $0036,$F87C,$0300   ; $2A787C ORI.B  #$F87C,$00(A6,D0.W)
        MOVE.W  -(A6),-(A7)                     ; $2A7882
        MOVE.W  $01DB(A2),-$0149(A4)            ; $2A7884
        MOVE.W  D2,#$021F                       ; $2A788A
        DC.W    $FEBD               ; $2A788E MOVE.W  <EA:3D>,(A7)
        MOVE.W  (A4),(A4)+                      ; $2A7890
        BCHG    D1,D4                           ; $2A7892
        MOVE.W  -$064F(A5),-(A7)                ; $2A7894
        DC.W    $0210,$FF0E         ; $2A7898 ANDI.B  #$FF0E,(A0)
        DC.W    $F83F               ; $2A789C MOVE.W  <EA:3F>,D4
        BCHG    D0,-$014E(A6)                   ; $2A789E
        MOVEA.W (A6)+,A4                        ; $2A78A2
        BTST    D0,-$0151(A1)                   ; $2A78A4
        MOVE.W  (A0),#$01CB                     ; $2A78A8
        MOVE.W  A2,-(A7)                        ; $2A78AC
        DC.W    $F8BE               ; $2A78AE MOVE.W  <EA:3E>,(A4)
        ANDI.W  #$00F8,A4                       ; $2A78B0
        MOVE.W  D5,$7A(A3,D0.W)                 ; $2A78B4
        MOVE.W  $74(A2,A7.W),(A7)+              ; $2A78B8
        ORI.L  #$FED0F8AD,D7                    ; $2A78BC
        ORI.W  #$00D7,(A2)+                     ; $2A78C2
        MOVEA.W $031200F4,A4                    ; $2A78C6
        MOVE.W  A7,$01D0(A4)                    ; $2A78CC
        DC.W    $00AC,$F9AC,$020F,$00A7; $2A78D0 ORI.L  #$F9AC020F,$00A7(A4)
        MOVE.W  (A7),(A4)+                      ; $2A78D8
        BCHG    D1,(A0)                         ; $2A78DA
        DC.W    $00EF               ; $2A78DC DC.W    $00EF
        MOVE.W  (A6),$12(A4,D0.W)               ; $2A78DE
        DC.W    $00FB               ; $2A78E2 DC.W    $00FB
        MOVE.W  $42(A5,D0.W),D4                 ; $2A78E4
        DC.W    $00C2               ; $2A78E8 DC.W    $00C2
        MOVEA.W (A2)+,A4                        ; $2A78EA
        BTST    D0,D1                           ; $2A78EC
        DC.W    $00C7               ; $2A78EE DC.W    $00C7
        MOVE.W  #$01D0,$01(A4,D0.W)             ; $2A78F0
        MOVE.W  (A0)+,$02(A4,D0.W)              ; $2A78F6
        ORI.W  #$FAB1,-$0D(A4,D0.W)             ; $2A78FA
        MOVE.W  $33(A7,A7.L),-(A7)              ; $2A7900
        BCHG    D0,-$00C9(PC)                   ; $2A7904
        MOVE.W  (A2)+,D5                        ; $2A7908
        ANDI.L  #$0074FAD3,A1                   ; $2A790A
        BCLR    D0,$6E(A2,D0.W)                 ; $2A7910
        MOVE.W  -(A5),$01FA(A4)                 ; $2A7914
        DC.W    $001B,$F942         ; $2A7918 ORI.B  #$F942,(A3)+
        BCHG    D0,-(A6)                        ; $2A791C
        DC.W    $0034,$FAB0,$011D   ; $2A791E ORI.B  #$FAB0,$1D(A4,D0.W)
        ORI.L  #$F91C0207,D7                    ; $2A7924
        ORI.L  #$F8DD0018,-(A5)                 ; $2A792A
        ORI.L  #$F941000D,A0                    ; $2A7930
        ORI.W  #$F980,-$05(A5,D0.W)             ; $2A7936
        ORI.L  #$FAA1012E,(A3)                  ; $2A793C
        DC.W    $FFE9,$FA6B         ; $2A7942 MOVE.W  -$0595(A1),<EA:3F>
        DC.W    $000A,$FEF7         ; $2A7946 ORI.B  #$FEF7,A2
        MOVE.W  $21(A7,D0.W),(A5)+              ; $2A794A
        MOVE.W  #$FB2E,(A7)                     ; $2A794E
        BCHG    D0,D4                           ; $2A7952
        MOVE.W  -$053C(A6),-$75(A7,A7.L)        ; $2A7954
        MOVE.W  $39(A0,A7.L),-(A7)              ; $2A795A
        ORI.L  #$FE65FC16,(A1)                  ; $2A795E
        DC.W    $00E6               ; $2A7964 DC.W    $00E6
        MOVE.W  (A3),(A7)                       ; $2A7966
        MOVE.W  -(A0),(A5)                      ; $2A7968
        DC.W    $FFE0               ; $2A796A MOVE.W  -(A0),<EA:3F>
        MOVE.W  (A6)+,$0000(A7)                 ; $2A796C
        BGT.W  loc_2A7972                       ; $2A7970
        DC.W    $0010,$0020         ; $2A7974 ORI.B  #$0020,(A0)
        DC.W    $0030,$0000,$6400   ; $2A7978 ORI.B  #$0000,$00(A0,D6.W)
        ORI.W  #$0050,D0                        ; $2A797E
        ORI.W  #$0070,-(A0)                     ; $2A7982
        DC.W    $0000,$6B00         ; $2A7986 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A798A
        DC.W    $00B0,$0000,$6400,$00C0; $2A7990 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A7998 DC.W    $00D0
        DC.W    $00E0               ; $2A799A DC.W    $00E0
        DC.W    $00F0               ; $2A799C DC.W    $00F0
        DC.W    $0000,$0300         ; $2A799E ORI.B  #$0300,D0
        BTST    D0,D0                           ; $2A79A2
        BTST    D0,(A0)                         ; $2A79A4
        BTST    D0,-(A0)                        ; $2A79A6
        BTST    D0,$00(A0,D0.W)                 ; $2A79A8
        BMI.W  loc_2A7AEE                       ; $2A79AC
        BCHG    D0,(A0)                         ; $2A79B0
        BCHG    D0,-(A0)                        ; $2A79B2
        BCHG    D0,$00(A0,D0.W)                 ; $2A79B4
        BCC.W  loc_2A7B3A                       ; $2A79B8
        BCLR    D0,(A0)                         ; $2A79BC
        BCLR    D0,-(A0)                        ; $2A79BE
        BCLR    D0,$00(A0,D0.W)                 ; $2A79C0
        BEQ.W  loc_2A7B86                       ; $2A79C4
        BSET    D0,(A0)                         ; $2A79C8
        BSET    D0,-(A0)                        ; $2A79CA
        BSET    D0,$00(A0,D0.W)                 ; $2A79CC
loc_2A79D0:
        SUBI.B  #$0200,D0                       ; $2A79D0
        DC.W    $0210,$0220         ; $2A79D4 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A79D8 ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A79DE
        ANDI.W  #$0270,-(A0)                    ; $2A79E2
        DC.W    $0000,$0400         ; $2A79E6 ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A79EA
        DC.W    $02B0,$0000,$6400,$02C0; $2A79F0 ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A79F8 DC.W    $02D0
        DC.W    $02E0               ; $2A79FA DC.W    $02E0
        DC.W    $02F0               ; $2A79FC DC.W    $02F0
        CMPI.B  #$002C,D0                       ; $2A79FE
        DC.W    $002C,$F82F,$02C2   ; $2A7A02 ORI.B  #$F82F,$02C2(A4)
        ORI.L  #$F96801F9,(A2)+                 ; $2A7A08
        MOVE.W  (A3),-$061E(A7)                 ; $2A7A0E
        DC.W    $02B8,$FF53,$F8A8,$0380; $2A7A12 ANDI.L  #$FF53F8A8,$0380.W
        ORI.L  #$F75A0366,(A2)+                 ; $2A7A1A
        ORI.W  #$F81E,(A0)                      ; $2A7A20
        DC.W    $02E8               ; $2A7A24 DC.W    $02E8
        MOVE.W  (A2)+,$7D(A7,A7.L)              ; $2A7A26
        DC.W    $037D               ; $2A7A2A BCHG    D1,<EA:3D>
        MOVE.W  (A2)+,-$47(A7,A7.W)             ; $2A7A2C
        BSET    D1,$50(PC,D0.W)                 ; $2A7A30
        MOVEA.W -(A1),A4                        ; $2A7A34
        BCHG    D1,D2                           ; $2A7A36
        MOVE.W  -$3C(A7,A7.L),-(A7)             ; $2A7A38
        BSET    D0,(A4)+                        ; $2A7A3C
        MOVE.W  $F93001F8,(A7)                  ; $2A7A3E
        MOVE.W  #$F8CC,(A7)                     ; $2A7A44
        BCHG    D1,(A7)+                        ; $2A7A48
        MOVE.W  $12(PC,A7.L),-(A7)              ; $2A7A4A
        BSET    D0,$0E(A3,A7.L)                 ; $2A7A4E
        MOVE.W  A3,-$76(A3,D0.W)                ; $2A7A52
        MOVE.W  $F79F0142,(A7)                  ; $2A7A56
        MOVE.W  $26(A3,A7.L),(A7)               ; $2A7A5C
        BCLR    D0,-$00F7(A3)                   ; $2A7A60
        MOVEA.W $4B(A3,D0.W),A4                 ; $2A7A64
        BTST    D0,D5                           ; $2A7A68
        MOVE.W  $01D1(A7),(A4)                  ; $2A7A6A
        DC.W    $00A9,$F91D,$01E5,$00A4; $2A7A6E ORI.L  #$F91D01E5,$00A4(A1)
        MOVE.W  -(A1),(A4)+                     ; $2A7A76
        BCHG    D1,(A7)+                        ; $2A7A78
        DC.W    $00FE               ; $2A7A7A DC.W    $00FE
        MOVE.W  D7,-(A4)                        ; $2A7A7C
        BSET    D0,$00F9(A6)                    ; $2A7A7E
        MOVE.W  -$63(A4,D0.W),$00C4(A3)         ; $2A7A82
        MOVE.W  D3,$52(A3,D0.W)                 ; $2A7A88
        DC.W    $00C5               ; $2A7A8C DC.W    $00C5
        MOVE.W  (A5),-(A4)                      ; $2A7A8E
        BCLR    D0,-(A3)                        ; $2A7A90
        DC.W    $00FA               ; $2A7A92 DC.W    $00FA
        MOVE.W  $0218(A6),$0073(A4)             ; $2A7A94
        MOVE.W  D7,(A5)                         ; $2A7A9A
        DC.W    $010A               ; $2A7A9C BTST    D0,A2
        MOVE.W  $09(A6,A7.L),-(A7)              ; $2A7A9E
        BCLR    D0,(A1)                         ; $2A7AA2
        MOVE.W  -$10(A6,A7.L),-(A7)             ; $2A7AA4
        ANDI.L  #$0073FAA4,(A7)+                ; $2A7AA8
        DC.W    $01C9               ; $2A7AAE BSET    D0,A1
        ORI.W  #$F933,$01FC(A4)                 ; $2A7AB0
        DC.W    $001B,$F918         ; $2A7AB6 ORI.B  #$F918,(A3)+
        BCHG    D0,-(A7)                        ; $2A7ABA
        DC.W    $0036,$FA8B,$0134   ; $2A7ABC ORI.B  #$FA8B,$34(A6,D0.W)
        ORI.L  #$F8E60203,D7                    ; $2A7AC2
        ORI.L  #$F8E70010,-(A7)                 ; $2A7AC8
        ORI.L  #$F94C0012,A1                    ; $2A7ACE
        ORI.W  #$F94B,$05(A4,D0.W)              ; $2A7AD4
        ORI.L  #$FA750142,(A2)                  ; $2A7ADA
        DC.W    $FFE6               ; $2A7AE0 MOVE.W  -(A6),<EA:3F>
        MOVEA.W -(A0),A5                        ; $2A7AE2
        DC.W    $001A,$FEF5         ; $2A7AE4 ORI.B  #$FEF5,(A2)+
        MOVE.W  $0039(A6),(A5)+                 ; $2A7AE8
        MOVE.W  D2,(A7)+                        ; $2A7AEC
loc_2A7AEE:
        MOVE.W  D4,-(A5)                        ; $2A7AEE
        BCHG    D0,-(A1)                        ; $2A7AF0
        MOVE.W  -$4B(A3,A7.L),-$5D(A7,A7.L)     ; $2A7AF2
        MOVE.W  $FC3B.W,-(A7)                   ; $2A7AF8
        ORI.L  #$FE66FC1B,A1                    ; $2A7AFC
        DC.W    $00E3               ; $2A7B02 DC.W    $00E3
        MOVE.W  A6,(A7)                         ; $2A7B04
        MOVE.W  (A5),(A5)                       ; $2A7B06
        DC.W    $FFFD               ; $2A7B08 MOVE.W  <EA:3D>,<EA:3F>
        MOVE.W  -(A0),$0000(A7)                 ; $2A7B0A
        BGT.W  loc_2A7B10                       ; $2A7B0E
        DC.W    $0010,$0020         ; $2A7B12 ORI.B  #$0020,(A0)
        DC.W    $0030,$0000,$6400   ; $2A7B16 ORI.B  #$0000,$00(A0,D6.W)
        ORI.W  #$0050,D0                        ; $2A7B1C
        ORI.W  #$0070,-(A0)                     ; $2A7B20
        DC.W    $0000,$6B00         ; $2A7B24 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A7B28
        DC.W    $00B0,$0000,$6400,$00C0; $2A7B2E ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A7B36 DC.W    $00D0
        DC.W    $00E0               ; $2A7B38 DC.W    $00E0
loc_2A7B3A:
        DC.W    $00F0               ; $2A7B3A DC.W    $00F0
        DC.W    $0000,$6B00         ; $2A7B3C ORI.B  #$6B00,D0
        BTST    D0,D0                           ; $2A7B40
        BTST    D0,(A0)                         ; $2A7B42
        BTST    D0,-(A0)                        ; $2A7B44
        BTST    D0,$00(A0,D0.W)                 ; $2A7B46
        BCC.W  loc_2A7C8C                       ; $2A7B4A
        BCHG    D0,(A0)                         ; $2A7B4E
        BCHG    D0,-(A0)                        ; $2A7B50
        BCHG    D0,$00(A0,D0.W)                 ; $2A7B52
        BEQ.W  loc_2A7CD8                       ; $2A7B56
        BCLR    D0,(A0)                         ; $2A7B5A
        BCLR    D0,-(A0)                        ; $2A7B5C
        BCLR    D0,$00(A0,D0.W)                 ; $2A7B5E
        SUBI.B  #$01C0,D0                       ; $2A7B62
        BSET    D0,(A0)                         ; $2A7B66
        BSET    D0,-(A0)                        ; $2A7B68
        BSET    D0,$00(A0,D0.W)                 ; $2A7B6A
        BCC.W  loc_2A7D70                       ; $2A7B6E
        DC.W    $0210,$0220         ; $2A7B72 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$0400   ; $2A7B76 ANDI.B  #$0000,$00(A0,D0.W)
        ANDI.W  #$0250,D0                       ; $2A7B7C
        ANDI.W  #$0270,-(A0)                    ; $2A7B80
        DC.W    $0000,$6400         ; $2A7B84 ORI.B  #$6400,D0
        ANDI.L  #$029002A0,D0                   ; $2A7B88
        DC.W    $02B0,$0C00,$002C,$002C; $2A7B8E ANDI.L  #$0C00002C,$2C(A0,D0.W)
        MOVE.W  (A3),D4                         ; $2A7B96
        ANDI.W  #$00E5,-(A3)                    ; $2A7B98
        DC.W    $F93D               ; $2A7B9C MOVE.W  <EA:3D>,-(A4)
        DC.W    $01CB               ; $2A7B9E BSET    D0,A3
        MOVE.W  -$5D(A7,A7.L),$0295(A7)         ; $2A7BA0
        MOVE.W  $79(A7,A7.L),$032C(A7)          ; $2A7BA6
        DC.W    $00E5               ; $2A7BAC DC.W    $00E5
        MOVE.W  $02F4(A1),-(A3)                 ; $2A7BAE
        DC.W    $00B9,$F7E6,$0294,$FFEA,$F836; $2A7BB2 ORI.L  #$F7E60294,$FFEAF836
        BTST    D1,-$16(A2,A7.L)                ; $2A7BBC
        DC.W    $F779,$0392,$00B9,$F830; $2A7BC0 MOVE.W  $039200B9,-$07D0(A3)
        BTST    D1,(A1)+                        ; $2A7BC8
        MOVE.W  D4,$25(A7,A7.L)                 ; $2A7BCA
        BCLR    D0,-(A2)                        ; $2A7BCE
        MOVE.W  A6,-(A7)                        ; $2A7BD0
        MOVE.W  (A4),(A4)                       ; $2A7BD2
        BCLR    D0,-(A3)                        ; $2A7BD4
        DC.W    $FEFF               ; $2A7BD6 MOVE.W  <EA:3F>,(A7)+
        MOVE.W  (A7)+,(A4)                      ; $2A7BD8
        BTST    D1,(A2)+                        ; $2A7BDA
        MOVE.W  -$6E(A5,A7.L),$019A(A7)         ; $2A7BDC
        MOVE.W  (A2),-$08EB(A7)                 ; $2A7BE2
        DC.W    $023D,$FF43         ; $2A7BE6 ANDI.B  #$FF43,<EA:3D>
        MOVE.W  -$09(A7,D0.W),(A3)+             ; $2A7BEA
        MOVE.W  D3,-$078C(A7)                   ; $2A7BEE
        BCHG    D0,(A4)                         ; $2A7BF2
        MOVE.W  (A2),-$07B7(A7)                 ; $2A7BF4
        DC.W    $02E0               ; $2A7BF8 DC.W    $02E0
        DC.W    $014B               ; $2A7BFA BCHG    D0,A3
        MOVE.W  -$7E(A1,D0.W),(A4)+             ; $2A7BFC
        DC.W    $010F               ; $2A7C00 BTST    D0,A7
        MOVE.W  (A0),$01B5(A4)                  ; $2A7C02
        DC.W    $00F2               ; $2A7C06 DC.W    $00F2
        MOVE.W  $0312(A0),(A4)                  ; $2A7C08
        BTST    D0,-$06B8(A7)                   ; $2A7C0C
        BSET    D0,D4                           ; $2A7C10
        BCHG    D0,D7                           ; $2A7C12
        MOVE.W  (A0)+,$0A(PC,D0.W)              ; $2A7C14
        BCHG    D0,-$0806(A0)                   ; $2A7C18
        DC.W    $00C6               ; $2A7C1C DC.W    $00C6
        BCHG    D0,-$0695(A7)                   ; $2A7C1E
        BCLR    D0,D1                           ; $2A7C22
        DC.W    $014F               ; $2A7C24 BCHG    D0,A7
        MOVE.W  D3,$01F1(A4)                    ; $2A7C26
        ORI.L  #$FA5000D7,(A2)                  ; $2A7C2A
        MOVE.W  (A5),-$0528(A7)                 ; $2A7C30
        BCHG    D0,(A1)+                        ; $2A7C34
        MOVE.W  (A5),-$0635(A7)                 ; $2A7C36
        ANDI.W  #$0092,$7B(A2,A7.L)             ; $2A7C3A
        BCLR    D0,(A4)                         ; $2A7C40
        ORI.L  #$F91601F5,A3                    ; $2A7C42
        DC.W    $002D,$F8E8,$0164   ; $2A7C48 ORI.B  #$F8E8,$0164(A5)
        ORI.W  #$FA4D,D6                        ; $2A7C4E
        BTST    D0,D4                           ; $2A7C52
        ORI.L  #$F8B901F9,-(A4)                 ; $2A7C54
        DC.W    $00B9,$F8F1,$000C,$0085,$F955; $2A7C5A ORI.L  #$F8F1000C,$0085F955
        DC.W    $0019,$0071         ; $2A7C64 ORI.B  #$0071,(A1)+
        MOVE.W  (A5)+,-(A4)                     ; $2A7C68
        DC.W    $0208,$00A5         ; $2A7C6A ANDI.B  #$00A5,A0
        MOVEA.W (A1),A5                         ; $2A7C6E
        BTST    D0,D5                           ; $2A7C70
        DC.W    $0003,$FA70         ; $2A7C72 ORI.B  #$FA70,D3
        DC.W    $FFE8,$FF08         ; $2A7C76 MOVE.W  -$00F8(A0),<EA:3F>
        MOVE.W  $23(A3,D0.W),(A5)+              ; $2A7C7A
        MOVE.W  (A2),(A7)+                      ; $2A7C7E
        MOVE.W  (A4),(A5)+                      ; $2A7C80
        BCHG    D0,D2                           ; $2A7C82
        DC.W    $FFCE               ; $2A7C84 MOVE.W  A6,<EA:3F>
        MOVE.W  (A7),(A5)+                      ; $2A7C86
        MOVE.W  D4,$48(A7,A7.L)                 ; $2A7C88
loc_2A7C8C:
        MOVE.W  -$6F(A6,D0.W),D6                ; $2A7C8C
        MOVEA.W -(A2),A7                        ; $2A7C90
        MOVE.W  A7,D6                           ; $2A7C92
        DC.W    $00E7               ; $2A7C94 DC.W    $00E7
        MOVE.W  A4,(A7)                         ; $2A7C96
        MOVE.W  -$0026(A7),(A5)                 ; $2A7C98
        MOVE.W  $00(A1,D0.W),$6E00(A7)          ; $2A7C9C
        DC.W    $0000,$0010         ; $2A7CA2 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A7CA6 ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A7CAA ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A7CAE
        ORI.W  #$0070,-(A0)                     ; $2A7CB2
        DC.W    $0000,$6B00         ; $2A7CB6 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A7CBA
        DC.W    $00B0,$0000,$6400,$00C0; $2A7CC0 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A7CC8 DC.W    $00D0
        DC.W    $00E0               ; $2A7CCA DC.W    $00E0
        DC.W    $00F0               ; $2A7CCC DC.W    $00F0
        DC.W    $0000,$6B00         ; $2A7CCE ORI.B  #$6B00,D0
        BTST    D0,D0                           ; $2A7CD2
        BTST    D0,(A0)                         ; $2A7CD4
        BTST    D0,-(A0)                        ; $2A7CD6
loc_2A7CD8:
        BTST    D0,$00(A0,D0.W)                 ; $2A7CD8
        BCC.W  loc_2A7E1E                       ; $2A7CDC
        BCHG    D0,(A0)                         ; $2A7CE0
        BCHG    D0,-(A0)                        ; $2A7CE2
        BCHG    D0,$00(A0,D0.W)                 ; $2A7CE4
        BEQ.W  loc_2A7E6A                       ; $2A7CE8
        BCLR    D0,(A0)                         ; $2A7CEC
        BCLR    D0,-(A0)                        ; $2A7CEE
        BCLR    D0,$00(A0,D0.W)                 ; $2A7CF0
        SUBI.B  #$01C0,D0                       ; $2A7CF4
        BSET    D0,(A0)                         ; $2A7CF8
        BSET    D0,-(A0)                        ; $2A7CFA
        BSET    D0,$00(A0,D0.W)                 ; $2A7CFC
        BCC.W  loc_2A7F02                       ; $2A7D00
        DC.W    $0210,$0220         ; $2A7D04 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$0400   ; $2A7D08 ANDI.B  #$0000,$00(A0,D0.W)
        ANDI.W  #$0250,D0                       ; $2A7D0E
        ANDI.W  #$0270,-(A0)                    ; $2A7D12
        DC.W    $0000,$6400         ; $2A7D16 ORI.B  #$6400,D0
        ANDI.L  #$029002A0,D0                   ; $2A7D1A
        DC.W    $02B0,$0C00,$0030,$0030; $2A7D20 ANDI.L  #$0C000030,$30(A0,D0.W)
        MOVE.W  #$026A,-$09(PC,D0.W)            ; $2A7D28
        MOVE.W  A4,-(A4)                        ; $2A7D2E
        DC.W    $01CD               ; $2A7D30 BSET    D0,A5
        MOVE.W  $7C(A7,A7.L),$0290(A7)          ; $2A7D32
        MOVE.W  $6E(A7,A7.L),$032E(A7)          ; $2A7D38
        DC.W    $00F7               ; $2A7D3E DC.W    $00F7
        MOVE.W  (A1)+,-(A3)                     ; $2A7D40
        DC.W    $030A               ; $2A7D42 BTST    D1,A2
        DC.W    $00DB               ; $2A7D44 DC.W    $00DB
        MOVE.W  D6,-$5B(PC,D0.W)                ; $2A7D46
        DC.W    $0000,$F81F         ; $2A7D4A ORI.B  #$F81F,D0
        DC.W    $033E               ; $2A7D4E BTST    D1,<EA:3E>
        DC.W    $0000,$F772         ; $2A7D50 ORI.B  #$F772,D0
        BCLR    D1,-(A2)                        ; $2A7D54
        DC.W    $00DB               ; $2A7D56 DC.W    $00DB
        MOVE.W  #$0314,-$64(PC,A7.L)            ; $2A7D58
        MOVE.W  -$4F(PC,D0.W),D4                ; $2A7D5E
        MOVE.W  D0,-(A7)                        ; $2A7D62
        MOVE.W  -(A7),(A4)                      ; $2A7D64
        DC.W    $01C9               ; $2A7D66 BSET    D0,A1
        MOVE.W  $68(A4,A7.L),(A7)+              ; $2A7D68
        BTST    D1,-$006F(A5)                   ; $2A7D6C
loc_2A7D70:
        MOVE.W  $01B6(A0),(A4)                  ; $2A7D70
        MOVE.W  D6,-$08EA(A7)                   ; $2A7D74
        DC.W    $0218,$FF40         ; $2A7D78 ANDI.B  #$FF40,(A0)+
        MOVE.W  D5,-(A3)                        ; $2A7D7C
        DC.W    $01CE               ; $2A7D7E BSET    D0,A6
        MOVE.W  $F897016C,-(A7)                 ; $2A7D80
        DC.W    $FF3E               ; $2A7D86 MOVE.W  <EA:3E>,-(A7)
        MOVEA.W (A0)+,A4                        ; $2A7D88
        DC.W    $02F9               ; $2A7D8A DC.W    $02F9
        BCHG    D0,-(A4)                        ; $2A7D8C
        MOVEA.W -(A0),A4                        ; $2A7D8E
        BCHG    D0,$08(PC,D0.W)                 ; $2A7D90
        MOVE.W  A0,(A4)+                        ; $2A7D94
        BCLR    D0,D7                           ; $2A7D96
        DC.W    $00E3               ; $2A7D98 DC.W    $00E3
        MOVE.W  D1,(A4)+                        ; $2A7D9A
        BTST    D1,D5                           ; $2A7D9C
        DC.W    $013F               ; $2A7D9E BTST    D0,<EA:3F>
        MOVE.W  $016D(A1),(A4)+                 ; $2A7DA0
        BTST    D0,-$2F(A2,A7.W)                ; $2A7DA4
        ANDI.L  #$013CF79C,(A6)+                ; $2A7DA8
        ANDI.W  #$0150,-$074C(A5)               ; $2A7DAE
        BTST    D0,#$0146                       ; $2A7DB4
        MOVE.W  (A5)+,$73(PC,D0.W)              ; $2A7DB8
        DC.W    $013E               ; $2A7DBC BTST    D0,<EA:3E>
        MOVE.W  (A5)+,$2C(A3,D0.W)              ; $2A7DBE
        BTST    D0,-$19(PC,A7.W)                ; $2A7DC2
        ANDI.L  #$018BF700,(A6)                 ; $2A7DC6
        BTST    D0,(A4)                         ; $2A7DCC
        BCLR    D0,(A0)                         ; $2A7DCE
        MOVE.W  (A6)+,-(A4)                     ; $2A7DD0
        BSET    D0,$0090(A0)                    ; $2A7DD2
        MOVE.W  $00CE(A2),D5                    ; $2A7DD6
        MOVE.W  (A2),-$054D(A7)                 ; $2A7DDA
        BCHG    D0,(A0)                         ; $2A7DDE
        MOVE.W  (A2),-$065B(A7)                 ; $2A7DE0
        ANDI.W  #$0090,-$05A8(A2)               ; $2A7DE4
        DC.W    $018D               ; $2A7DEA BCLR    D0,A5
        ORI.L  #$F8F001EC,D7                    ; $2A7DEC
        DC.W    $002C,$F8C3,$015C   ; $2A7DF2 ORI.B  #$F8C3,$015C(A4)
        ORI.W  #$FA29,A1                        ; $2A7DF8
        DC.W    $00FC               ; $2A7DFC DC.W    $00FC
        ORI.L  #$F89101ED,-(A4)                 ; $2A7DFE
        DC.W    $00BC,$F8FA,$0008,$0086,$F95C; $2A7E04 ORI.L  #$F8FA0008,#$0086F95C
        DC.W    $001F,$006F         ; $2A7E0E ORI.B  #$006F,(A7)+
        MOVE.W  $05(A3,D0.W),(A4)+              ; $2A7E12
        ORI.L  #$FA2E00FA,-(A5)                 ; $2A7E16
        DC.W    $0000,$FA6F         ; $2A7E1C ORI.B  #$FA6F,D0
        DC.W    $FFE2               ; $2A7E20 MOVE.W  -(A2),<EA:3F>
        MOVE.W  D6,-(A7)                        ; $2A7E22
        MOVE.W  $0029(A6),(A5)+                 ; $2A7E24
        MOVE.W  (A5),(A7)+                      ; $2A7E28
        MOVE.W  $0142(A6),(A5)                  ; $2A7E2A
        DC.W    $FFD0               ; $2A7E2E MOVE.W  (A0),<EA:3F>
        MOVE.W  (A5),(A5)+                      ; $2A7E30
        MOVE.W  A1,$4C(A7,A7.L)                 ; $2A7E32
        MOVE.W  $008F.W,D6                      ; $2A7E36
        MOVEA.W -(A4),A7                        ; $2A7E3A
        MOVE.W  A7,D6                           ; $2A7E3C
        DC.W    $00E7               ; $2A7E3E DC.W    $00E7
        MOVE.W  A1,(A7)                         ; $2A7E40
        MOVE.W  -$0020(A5),(A5)                 ; $2A7E42
        MOVE.W  $00(A1,D0.W),$6E00(A7)          ; $2A7E46
        DC.W    $0000,$0010         ; $2A7E4C ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A7E50 ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A7E54 ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A7E58
        ORI.W  #$0070,-(A0)                     ; $2A7E5C
        DC.W    $0000,$6B00         ; $2A7E60 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A7E64
loc_2A7E6A:
        DC.W    $00B0,$0000,$6400,$00C0; $2A7E6A ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A7E72 DC.W    $00D0
        DC.W    $00E0               ; $2A7E74 DC.W    $00E0
        DC.W    $00F0               ; $2A7E76 DC.W    $00F0
        DC.W    $0000,$6B00         ; $2A7E78 ORI.B  #$6B00,D0
        BTST    D0,D0                           ; $2A7E7C
        BTST    D0,(A0)                         ; $2A7E7E
        BTST    D0,-(A0)                        ; $2A7E80
        BTST    D0,$00(A0,D0.W)                 ; $2A7E82
        BCC.W  loc_2A7FC8                       ; $2A7E86
        BCHG    D0,(A0)                         ; $2A7E8A
        BCHG    D0,-(A0)                        ; $2A7E8C
        BCHG    D0,$00(A0,D0.W)                 ; $2A7E8E
        BVS.W  loc_2A8014                       ; $2A7E92
        BCLR    D0,(A0)                         ; $2A7E96
        BCLR    D0,-(A0)                        ; $2A7E98
        BCLR    D0,$00(A0,D0.W)                 ; $2A7E9A
        BEQ.W  loc_2A8060                       ; $2A7E9E
        BSET    D0,(A0)                         ; $2A7EA2
        BSET    D0,-(A0)                        ; $2A7EA4
        BSET    D0,$00(A0,D0.W)                 ; $2A7EA6
        SUBI.B  #$0200,D0                       ; $2A7EAA
        DC.W    $0210,$0220         ; $2A7EAE ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A7EB2 ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A7EB8
        ANDI.W  #$0270,-(A0)                    ; $2A7EBC
        DC.W    $0000,$0400         ; $2A7EC0 ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A7EC4
        DC.W    $02B0,$0000,$6400,$02C0; $2A7ECA ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A7ED2 DC.W    $02D0
        DC.W    $02E0               ; $2A7ED4 DC.W    $02E0
        DC.W    $02F0               ; $2A7ED6 DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A7ED8
        DC.W    $0030,$F7D2,$02C1   ; $2A7EDC ORI.B  #$F7D2,-$3F(A0,D0.W)
        ORI.L  #$F90301C8,(A3)+                 ; $2A7EE2
        MOVE.W  -$066E(A5),$0277(A7)            ; $2A7EE8
        MOVE.W  -$079E(A5),$036F(A7)            ; $2A7EEE
        ORI.L  #$F7170379,(A3)+                 ; $2A7EF4
        ORI.W  #$F7D4,D0                        ; $2A7EFA
        DC.W    $02DF               ; $2A7EFE DC.W    $02DF
        MOVE.W  (A1)+,$44(A7,A7.L)              ; $2A7F00
        BCHG    D1,-$0067(A0)                   ; $2A7F04
        MOVE.W  D7,$03(A3,D0.W)                 ; $2A7F08
        ORI.W  #$F836,D0                        ; $2A7F0C
        BCHG    D1,D0                           ; $2A7F10
        MOVE.W  $4C(A2,A7.L),-(A7)              ; $2A7F12
        BCLR    D0,$FF0EF8BC                    ; $2A7F16
        BSET    D0,D0                           ; $2A7F1C
        MOVE.W  D2,-(A7)                        ; $2A7F1E
        MOVE.W  -(A4),(A4)                      ; $2A7F20
        BCHG    D1,D7                           ; $2A7F22
        MOVE.W  -(A5),-(A7)                     ; $2A7F24
        MOVE.W  -$32(A2,D0.W),(A4)              ; $2A7F26
        MOVE.W  (A3),-$08E7(A7)                 ; $2A7F2A
        DC.W    $0204,$FF28         ; $2A7F2E ANDI.B  #$FF28,D4
        MOVE.W  A6,-(A3)                        ; $2A7F32
        BCLR    D0,-$00C9(PC)                   ; $2A7F34
        MOVE.W  -(A6),(A4)                      ; $2A7F38
        BCLR    D0,D5                           ; $2A7F3A
        MOVE.W  -(A1),-$0805(A7)                ; $2A7F3C
        DC.W    $02F3               ; $2A7F40 DC.W    $02F3
        BTST    D0,D7                           ; $2A7F42
        MOVE.W  (A5),-(A4)                      ; $2A7F44
        DC.W    $023C,$003A,$F962   ; $2A7F46 ANDI.B  #$003A,#$F962
        ANDI.L  #$0066F848,D1                   ; $2A7F4C
        BTST    D1,$0133.W                      ; $2A7F52
        MOVE.W  (A5),$0250(A4)                  ; $2A7F56
        DC.W    $00AB,$F7F6,$01CE,$FFFA; $2A7F5A ORI.L  #$F7F601CE,-$0006(A3)
        MOVE.W  (A3)+,D4                        ; $2A7F62
        BCLR    D0,(A4)                         ; $2A7F64
        DC.W    $FFDC               ; $2A7F66 MOVE.W  (A4)+,<EA:3F>
        MOVE.W  $0217(PC),$008B(A4)             ; $2A7F68
        MOVE.W  (A5)+,-(A4)                     ; $2A7F6E
        BCLR    D0,(A7)+                        ; $2A7F70
        DC.W    $FFEA,$F668         ; $2A7F72 MOVE.W  -$0998(A2),<EA:3F>
        BSET    D0,-$09(A3,A7.L)                ; $2A7F76
        MOVE.W  A5,-$03(PC,D0.W)                ; $2A7F7A
        MOVE.W  $4B(PC,A7.L),$00C6(A7)          ; $2A7F7E
        MOVE.W  -$0704(A7),$0201(A7)            ; $2A7F84
        ORI.L  #$F9B700AB,A6                    ; $2A7F8A
        MOVE.W  (A1),-$05A4(A7)                 ; $2A7F90
        BTST    D0,D5                           ; $2A7F94
        MOVE.W  (A1),-$0660(A7)                 ; $2A7F96
        ANDI.W  #$008E,(A3)+                    ; $2A7F9A
        MOVE.W  D4,D5                           ; $2A7F9E
        BCHG    D0,-(A2)                        ; $2A7FA0
        DC.W    $007D,$F89A         ; $2A7FA2 ORI.W  #$F89A,<EA:3D>
        BSET    D0,D3                           ; $2A7FA6
        DC.W    $0031,$F86B,$0137   ; $2A7FA8 ORI.B  #$F86B,$37(A1,D0.W)
        ORI.W  #$F9D4,(A4)+                     ; $2A7FAE
        DC.W    $00D6               ; $2A7FB2 DC.W    $00D6
        ORI.L  #$F83B01C0,-(A7)                 ; $2A7FB4
        DC.W    $00CC               ; $2A7FBA DC.W    $00CC
        MOVE.W  (A0),-(A4)                      ; $2A7FBC
        DC.W    $0001,$008A         ; $2A7FBE ORI.B  #$008A,D1
        MOVE.W  -(A6),$002F(A4)                 ; $2A7FC2
        ORI.W  #$F891,$01EE(A1)                 ; $2A7FC6
        DC.W    $00AC,$F9E0,$00C6,$FFFB; $2A7FCC ORI.L  #$F9E000C6,-$0005(A4)
        MOVEA.W -$33(A0,A7.L),A5                ; $2A7FD4
        MOVE.W  D0,-(A7)                        ; $2A7FD8
        MOVE.W  (A6)+,(A5)+                     ; $2A7FDA
        DC.W    $0033,$FEDB,$FA4D   ; $2A7FDC ORI.B  #$FEDB,$4D(A3,A7.L)
        BTST    D0,-$0029(A4)                   ; $2A7FE2
        MOVE.W  (A4),(A5)+                      ; $2A7FE6
        MOVE.W  (A0),$54(A7,A7.L)               ; $2A7FE8
        MOVE.W  -$75(PC,D0.W),D6                ; $2A7FEC
        MOVEA.W -(A4),A7                        ; $2A7FF0
        MOVE.W  A7,D6                           ; $2A7FF2
        DC.W    $00E4               ; $2A7FF4 DC.W    $00E4
        MOVE.W  D2,(A7)                         ; $2A7FF6
        MOVE.W  -$0017(A1),(A5)                 ; $2A7FF8
        MOVE.W  $00(A1,D0.W),$6E00(A7)          ; $2A7FFC
        DC.W    $0000,$0010         ; $2A8002 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A8006 ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A800A ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A800E
        ORI.W  #$0070,-(A0)                     ; $2A8012
        DC.W    $0000,$6B00         ; $2A8016 ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A801A
        DC.W    $00B0,$0000,$6400,$00C0; $2A8020 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A8028 DC.W    $00D0
        DC.W    $00E0               ; $2A802A DC.W    $00E0
        DC.W    $00F0               ; $2A802C DC.W    $00F0
        DC.W    $0000,$6B00         ; $2A802E ORI.B  #$6B00,D0
        BTST    D0,D0                           ; $2A8032
        BTST    D0,(A0)                         ; $2A8034
        BTST    D0,-(A0)                        ; $2A8036
        BTST    D0,$00(A0,D0.W)                 ; $2A8038
        BCC.W  loc_2A817E                       ; $2A803C
        BCHG    D0,(A0)                         ; $2A8040
        BCHG    D0,-(A0)                        ; $2A8042
        BCHG    D0,$00(A0,D0.W)                 ; $2A8044
        BVS.W  loc_2A81CA                       ; $2A8048
        BCLR    D0,(A0)                         ; $2A804C
        BCLR    D0,-(A0)                        ; $2A804E
        BCLR    D0,$00(A0,D0.W)                 ; $2A8050
        BEQ.W  $2A8216                          ; $2A8054
        BSET    D0,(A0)                         ; $2A8058
        BSET    D0,-(A0)                        ; $2A805A
        BSET    D0,$00(A0,D0.W)                 ; $2A805C
loc_2A8060:
        SUBI.B  #$0200,D0                       ; $2A8060
        DC.W    $0210,$0220         ; $2A8064 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0000,$6400   ; $2A8068 ANDI.B  #$0000,$00(A0,D6.W)
        ANDI.W  #$0250,D0                       ; $2A806E
        ANDI.W  #$0270,-(A0)                    ; $2A8072
        DC.W    $0000,$0400         ; $2A8076 ORI.B  #$0400,D0
        ANDI.L  #$029002A0,D0                   ; $2A807A
        DC.W    $02B0,$0000,$6400,$02C0; $2A8080 ANDI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $02D0               ; $2A8088 DC.W    $02D0
        DC.W    $02E0               ; $2A808A DC.W    $02E0
        DC.W    $02F0               ; $2A808C DC.W    $02F0
        CMPI.B  #$0030,D0                       ; $2A808E
        DC.W    $0030,$F7E1,$02B5   ; $2A8092 ORI.B  #$F7E1,-$4B(A0,D0.W)
        ORI.L  #$F91901C5,(A1)+                 ; $2A8098
        MOVE.W  -$065E(A4),$0278(A7)            ; $2A809E
        MOVE.W  -$0796(A4),$0368(A7)            ; $2A80A4
        ORI.L  #$F71E0367,(A1)+                 ; $2A80AA
        DC.W    $003D,$F7E1         ; $2A80B0 ORI.B  #$F7E1,<EA:3D>
        DC.W    $02D2               ; $2A80B4 DC.W    $02D2
        MOVE.W  (A7),$4C(A7,A7.L)               ; $2A80B6
        BCHG    D1,(A7)+                        ; $2A80BA
        MOVE.W  (A7),-$76(A7,A7.W)              ; $2A80BC
        BSET    D1,$3D(A3,D0.W)                 ; $2A80C0
        MOVEA.W D7,A4                           ; $2A80C4
        BTST    D1,$2F(PC,A7.L)                 ; $2A80C6
        MOVEA.W A6,A4                           ; $2A80CA
        BCLR    D0,$0F(A3,A7.L)                 ; $2A80CC
        DC.W    $F8BD               ; $2A80D0 MOVE.W  <EA:3D>,(A4)
        BCLR    D0,$03(A6,A7.L)                 ; $2A80D2
        MOVE.W  $3D(A6,D0.W),(A4)               ; $2A80D6
        MOVE.W  -(A1),-(A7)                     ; $2A80DA
        MOVE.W  -$3B(A4,D0.W),(A4)              ; $2A80DC
        MOVE.W  (A4),-$08E3(A7)                 ; $2A80E0
        DC.W    $020A,$FF2C         ; $2A80E4 ANDI.B  #$FF2C,A2
        MOVE.W  (A0),-(A3)                      ; $2A80E8
        BSET    D0,D1                           ; $2A80EA
        MOVE.W  -$075A(PC),-(A7)                ; $2A80EC
        BCHG    D0,#$FF63                       ; $2A80F0
        MOVE.W  A3,D4                           ; $2A80F4
        DC.W    $02D2               ; $2A80F6 DC.W    $02D2
        BTST    D0,D6                           ; $2A80F8
        MOVE.W  A0,$0262(A4)                    ; $2A80FA
        DC.W    $003B,$F982,$02B8   ; $2A80FE ORI.B  #$F982,-$48(PC,D0.W)
        ORI.W  #$F844,-(A5)                     ; $2A8104
        BTST    D1,$0130(A0)                    ; $2A8108
        MOVE.W  D0,-$79(A4,D0.W)                ; $2A810C
        DC.W    $00A9,$F84E,$01AE,$FFFC; $2A8110 ORI.L  #$F84E01AE,-$0004(A1)
        MOVE.W  D0,(A4)                         ; $2A8118
        DC.W    $017E               ; $2A811A BCHG    D0,<EA:3E>
        DC.W    $FFDF               ; $2A811C MOVE.W  (A7)+,<EA:3F>
        MOVE.W  $58(A4,D0.W),-$74(A4,D0.W)      ; $2A811E
        MOVE.W  -$36(A7,D0.W),-$0014(A4)        ; $2A8124
        MOVE.W  D3,(A3)+                        ; $2A812A
        BCHG    D0,-$0007(A5)                   ; $2A812C
        MOVEA.W (A5)+,A4                        ; $2A8130
        DC.W    $00D8               ; $2A8132 DC.W    $00D8
        MOVE.W  D2,-$24(A7,A7.L)                ; $2A8134
        BTST    D0,D2                           ; $2A8138
        MOVE.W  $0F(A5,A7.L),$0201(A7)          ; $2A813A
        ORI.L  #$F9C900AC,A6                    ; $2A8140
        MOVE.W  (A0),-$0592(A7)                 ; $2A8146
        BTST    D0,D6                           ; $2A814A
        MOVE.W  (A0),-$064D(A7)                 ; $2A814C
        ANDI.W  #$008E,(A3)+                    ; $2A8150
        MOVE.W  (A0)+,D5                        ; $2A8154
        BCHG    D0,-(A2)                        ; $2A8156
        DC.W    $007D,$F8B3         ; $2A8158 ORI.W  #$F8B3,<EA:3D>
        DC.W    $01CE               ; $2A815C BSET    D0,A6
        DC.W    $0030,$F87E,$0143   ; $2A815E ORI.B  #$F87E,$43(A0,D0.W)
        ORI.W  #$F9E4,(A0)+                     ; $2A8164
        DC.W    $00D6               ; $2A8168 DC.W    $00D6
        ORI.L  #$F85201CF,-(A6)                 ; $2A816A
        DC.W    $00C8               ; $2A8170 DC.W    $00C8
        MOVE.W  A1,-(A4)                        ; $2A8172
        DC.W    $0003,$008A         ; $2A8174 ORI.B  #$008A,D3
        MOVE.W  -(A3),$002B(A4)                 ; $2A8178
        ORI.W  #$F8AD,$01F7(A2)                 ; $2A817C
        DC.W    $00A9,$F9F0,$00C7,$FFFB; $2A8182 ORI.L  #$F9F000C7,-$0005(A1)
        MOVEA.W -$39(A4,A7.L),A5                ; $2A818A
        MOVE.W  D2,-(A7)                        ; $2A818E
        MOVE.W  -(A5),(A5)+                     ; $2A8190
        DC.W    $0027,$FEDA         ; $2A8192 ORI.B  #$FEDA,-(A7)
        MOVEA.W -(A1),A5                        ; $2A8196
        BTST    D0,-$002D(A0)                   ; $2A8198
        MOVE.W  (A3)+,(A5)+                     ; $2A819C
        MOVE.W  D5,$52(A7,A7.L)                 ; $2A819E
        MOVE.W  $008D(PC),D6                    ; $2A81A2
        MOVEA.W -(A6),A7                        ; $2A81A6
        MOVE.W  A5,D6                           ; $2A81A8
        DC.W    $00E4               ; $2A81AA DC.W    $00E4
        MOVE.W  D5,(A7)                         ; $2A81AC
        MOVE.W  -$0024(A6),(A5)                 ; $2A81AE
        MOVE.W  $00(A2,D0.W),$6E00(A7)          ; $2A81B2
        DC.W    $0000,$0010         ; $2A81B8 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2A81BC ORI.B  #$0030,-(A0)
        DC.W    $0000,$6400         ; $2A81C0 ORI.B  #$6400,D0
        ORI.W  #$0050,D0                        ; $2A81C4
        ORI.W  #$0070,-(A0)                     ; $2A81C8
        DC.W    $0000,$6B00         ; $2A81CC ORI.B  #$6B00,D0
        ORI.L  #$009000A0,D0                    ; $2A81D0
        DC.W    $00B0,$0000,$6400,$00C0; $2A81D6 ORI.L  #$00006400,-$40(A0,D0.W)
        DC.W    $00D0               ; $2A81DE DC.W    $00D0
        DC.W    $00E0               ; $2A81E0 DC.W    $00E0
        DC.W    $00F0               ; $2A81E2 DC.W    $00F0
        DC.W    $0000,$6B00         ; $2A81E4 ORI.B  #$6B00,D0
        BTST    D0,D0                           ; $2A81E8
        BTST    D0,(A0)                         ; $2A81EA
        BTST    D0,-(A0)                        ; $2A81EC
        BTST    D0,$00(A0,D0.W)                 ; $2A81EE
        BCC.W  $2A8334                          ; $2A81F2
        BCHG    D0,(A0)                         ; $2A81F6
        BCHG    D0,-(A0)                        ; $2A81F8
        BCHG    D0,$00(A0,D0.W)                 ; $2A81FA
        BVS.W  $2A8380                          ; $2A81FE
