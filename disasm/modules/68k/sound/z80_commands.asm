; Generated assembly for $00D1D4-$00E200
; Branch targets: 151
; Labels: 126
; Format: DC.W with decoded mnemonics as comments

        org     $00D1D4

        DC.W    $33FC,$0100,$00A1,$1100; $00D1D4 MOVE.W  #$0100,$00A11100
loc_00D1DC:
        DC.W    $0839,$0000,$00A1,$1100; $00D1DC BTST    #0,$00A11100
        DC.W    $66F6               ; $00D1E4 BNE.S  loc_00D1DC
        DC.W    $3838,$C874         ; $00D1E6 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $00D1EA BSET    #4,D4
        DC.W    $3A84               ; $00D1EE MOVE.W  D4,(A5)
        DC.W    $3ABC,$8F01         ; $00D1F0 MOVE.W  #$8F01,(A5)
        DC.W    $2ABC,$93FF,$941F   ; $00D1F4 MOVE.L  #$93FF941F,(A5)
        DC.W    $3ABC,$9780         ; $00D1FA MOVE.W  #$9780,(A5)
        DC.W    $2ABC,$6000,$0082   ; $00D1FE MOVE.L  #$60000082,(A5)
        DC.W    $3CBC,$0000         ; $00D204 MOVE.W  #$0000,(A6)
loc_00D208:
        DC.W    $3E15               ; $00D208 MOVE.W  (A5),D7
        DC.W    $0247,$0002         ; $00D20A ANDI.W  #$0002,D7
        DC.W    $66F8               ; $00D20E BNE.S  loc_00D208
        DC.W    $3ABC,$8F02         ; $00D210 MOVE.W  #$8F02,(A5)
        DC.W    $3AB8,$C874         ; $00D214 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $00D218 MOVE.W  #$0000,$00A11100
        DC.W    $7007               ; $00D220 MOVEQ   #$07,D0
        DC.W    $4EB9,$0088,$14BE   ; $00D222 JSR     $008814BE
        DC.W    $33FC,$0100,$00A1,$1100; $00D228 MOVE.W  #$0100,$00A11100
loc_00D230:
        DC.W    $0839,$0000,$00A1,$1100; $00D230 BTST    #0,$00A11100
        DC.W    $66F6               ; $00D238 BNE.S  loc_00D230
        DC.W    $3838,$C874         ; $00D23A MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $00D23E BSET    #4,D4
        DC.W    $3A84               ; $00D242 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9340,$9400   ; $00D244 MOVE.L  #$93409400,(A5)
        DC.W    $2ABC,$9540,$96C2   ; $00D24A MOVE.L  #$954096C2,(A5)
        DC.W    $3ABC,$977F         ; $00D250 MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$C000         ; $00D254 MOVE.W  #$C000,(A5)
        DC.W    $31FC,$0080,$C876   ; $00D258 MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $00D25E MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $00D262 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $00D266 MOVE.W  #$0000,$00A11100
        DC.W    $3038,$C8A0         ; $00D26E MOVE.W  $C8A0.W,D0
        DC.W    $41FA,$0188         ; $00D272 LEA     $0188(PC),A0
        DC.W    $2030,$0000         ; $00D276 MOVE.L  $00(A0,D0.W),D0
        DC.W    $4EB9,$0088,$15EA   ; $00D27A JSR     $008815EA
        DC.W    $33FC,$0100,$00A1,$1100; $00D280 MOVE.W  #$0100,$00A11100
loc_00D288:
        DC.W    $0839,$0000,$00A1,$1100; $00D288 BTST    #0,$00A11100
        DC.W    $66F6               ; $00D290 BNE.S  loc_00D288
        DC.W    $3838,$C874         ; $00D292 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $00D296 BSET    #4,D4
        DC.W    $3A84               ; $00D29A MOVE.W  D4,(A5)
        DC.W    $2ABC,$9300,$9420   ; $00D29C MOVE.L  #$93009420,(A5)
        DC.W    $2ABC,$9500,$9688   ; $00D2A2 MOVE.L  #$95009688,(A5)
        DC.W    $3ABC,$977F         ; $00D2A8 MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$4220         ; $00D2AC MOVE.W  #$4220,(A5)
        DC.W    $31FC,$0080,$C876   ; $00D2B0 MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $00D2B6 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $00D2BA MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $00D2BE MOVE.W  #$0000,$00A11100
        DC.W    $3238,$C89C         ; $00D2C6 MOVE.W  $C89C.W,D1
        DC.W    $E549               ; $00D2CA LSL.W  #2,D1
        DC.W    $41FA,$0146         ; $00D2CC LEA     $0146(PC),A0
        DC.W    $2230,$1000         ; $00D2D0 MOVE.L  $00(A0,D1.W),D1
        DC.W    $4EB9,$0088,$155E   ; $00D2D4 JSR     $0088155E
        DC.W    $3ABC,$8B00         ; $00D2DA MOVE.W  #$8B00,(A5)
        DC.W    $7000               ; $00D2DE MOVEQ   #$00,D0
        DC.W    $72F8               ; $00D2E0 MOVEQ   #-$08,D1
        DC.W    $4A38,$C80F         ; $00D2E2 TST.B  $C80F.W
        DC.W    $6742               ; $00D2E6 BEQ.S  loc_00D32A
        DC.W    $7000               ; $00D2E8 MOVEQ   #$00,D0
        DC.W    $7200               ; $00D2EA MOVEQ   #$00,D1
        DC.W    $43F9,$00FF,$1400   ; $00D2EC LEA     $00FF1400,A1
        DC.W    $45F9,$00FF,$1000   ; $00D2F2 LEA     $00FF1000,A2
        DC.W    $4EB9,$0088,$48CA   ; $00D2F8 JSR     $008848CA
        DC.W    $4EB9,$0088,$48CE   ; $00D2FE JSR     $008848CE
        DC.W    $4EB9,$0088,$48D2   ; $00D304 JSR     $008848D2
        DC.W    $43F9,$00FF,$1200   ; $00D30A LEA     $00FF1200,A1
        DC.W    $4EB9,$0088,$48CA   ; $00D310 JSR     $008848CA
        DC.W    $4EB9,$0088,$48CE   ; $00D316 JSR     $008848CE
        DC.W    $4EB9,$0088,$48D2   ; $00D31C JSR     $008848D2
        DC.W    $3ABC,$8B03         ; $00D322 MOVE.W  #$8B03,(A5)
        DC.W    $6100,$0112         ; $00D326 BSR.W  loc_00D43A
loc_00D32A:
        DC.W    $33FC,$0100,$00A1,$1100; $00D32A MOVE.W  #$0100,$00A11100
loc_00D332:
        DC.W    $0839,$0000,$00A1,$1100; $00D332 BTST    #0,$00A11100
        DC.W    $66F6               ; $00D33A BNE.S  loc_00D332
        DC.W    $3838,$C874         ; $00D33C MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $00D340 BSET    #4,D4
        DC.W    $3A84               ; $00D344 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9300,$940E   ; $00D346 MOVE.L  #$9300940E,(A5)
        DC.W    $2ABC,$9500,$9688   ; $00D34C MOVE.L  #$95009688,(A5)
        DC.W    $3ABC,$977F         ; $00D352 MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$4000         ; $00D356 MOVE.W  #$4000,(A5)
        DC.W    $31FC,$0083,$C876   ; $00D35A MOVE.W  #$0083,$C876.W
        DC.W    $3AB8,$C876         ; $00D360 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $00D364 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $00D368 MOVE.W  #$0000,$00A11100
        DC.W    $0838,$0003,$C80E   ; $00D370 BTST    #3,$C80E.W
        DC.W    $6762               ; $00D376 BEQ.S  loc_00D3DA
        DC.W    $7200               ; $00D378 MOVEQ   #$00,D1
        DC.W    $243C,$0000,$00B0   ; $00D37A MOVE.L  #$000000B0,D2
        DC.W    $7E1B               ; $00D380 MOVEQ   #$1B,D7
        DC.W    $43F9,$00FF,$1A50   ; $00D382 LEA     $00FF1A50,A1
loc_00D388:
        DC.W    $4EB9,$0088,$485E   ; $00D388 JSR     $0088485E
        DC.W    $D3C2               ; $00D38E ADDA.L  D2,A1
        DC.W    $51CF,$FFF6         ; $00D390 DBRA    D7,loc_00D388
        DC.W    $33FC,$0100,$00A1,$1100; $00D394 MOVE.W  #$0100,$00A11100
loc_00D39C:
        DC.W    $0839,$0000,$00A1,$1100; $00D39C BTST    #0,$00A11100
        DC.W    $66F6               ; $00D3A4 BNE.S  loc_00D39C
        DC.W    $3838,$C874         ; $00D3A6 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $00D3AA BSET    #4,D4
        DC.W    $3A84               ; $00D3AE MOVE.W  D4,(A5)
        DC.W    $2ABC,$9300,$940E   ; $00D3B0 MOVE.L  #$9300940E,(A5)
        DC.W    $2ABC,$9500,$968D   ; $00D3B6 MOVE.L  #$9500968D,(A5)
        DC.W    $3ABC,$977F         ; $00D3BC MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$6000         ; $00D3C0 MOVE.W  #$6000,(A5)
        DC.W    $31FC,$0082,$C876   ; $00D3C4 MOVE.W  #$0082,$C876.W
        DC.W    $3AB8,$C876         ; $00D3CA MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $00D3CE MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $00D3D2 MOVE.W  #$0000,$00A11100
loc_00D3DA:
        DC.W    $31FC,$FFFC,$C880   ; $00D3DA MOVE.W  #$FFFC,$C880.W
        DC.W    $31C1,$C882         ; $00D3E0 MOVE.W  D1,$C882.W
        DC.W    $31C0,$8000         ; $00D3E4 MOVE.W  D0,$8000.W
        DC.W    $31C0,$8002         ; $00D3E8 MOVE.W  D0,$8002.W
        DC.W    $2ABC,$4000,$0010   ; $00D3EC MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $00D3F2 MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $00D3F6 MOVE.W  $C882.W,(A6)
        DC.W    $4E75               ; $00D3FA RTS
        DC.W    $0000,$0001         ; $00D3FC ORI.B  #$0001,D0
        DC.W    $0000,$0002         ; $00D400 ORI.B  #$0002,D0
        DC.W    $0000,$0003         ; $00D404 ORI.B  #$0003,D0
        DC.W    $0000,$0005         ; $00D408 ORI.B  #$0005,D0
        DC.W    $0000,$0004         ; $00D40C ORI.B  #$0004,D0
        DC.W    $0000,$0004         ; $00D410 ORI.B  #$0004,D0
        DC.W    $0000,$0001         ; $00D414 ORI.B  #$0001,D0
        DC.W    $0000,$0005         ; $00D418 ORI.B  #$0005,D0
        DC.W    $0000,$0006         ; $00D41C ORI.B  #$0006,D0
        DC.W    $0000,$0004         ; $00D420 ORI.B  #$0004,D0
        DC.W    $0000,$0007         ; $00D424 ORI.B  #$0007,D0
        DC.W    $0000,$0007         ; $00D428 ORI.B  #$0007,D0
        DC.W    $2ABC,$4000,$0000   ; $00D42C MOVE.L  #$40000000,(A5)
        DC.W    $7200               ; $00D432 MOVEQ   #$00,D1
        DC.W    $4EF9,$0088,$48B8   ; $00D434 JMP     $008848B8
loc_00D43A:
        DC.W    $43F8,$8000         ; $00D43A LEA     $8000.W,A1
        DC.W    $7200               ; $00D43E MOVEQ   #$00,D1
        DC.W    $4EB9,$0088,$483E   ; $00D440 JSR     $0088483E
        DC.W    $4EF9,$0088,$4842   ; $00D446 JMP     $00884842
        DC.W    $050A               ; $00D44C BTST    D2,A2
        DC.W    $0F14               ; $00D44E BTST    D7,(A4)
        DC.W    $7000               ; $00D450 MOVEQ   #$00,D0
        DC.W    $1038,$FEA8         ; $00D452 MOVE.B  $FEA8.W,D0
        DC.W    $1238,$C80F         ; $00D456 MOVE.B  $C80F.W,D1
        DC.W    $6704               ; $00D45A BEQ.S  loc_00D460
        DC.W    $1038,$FEAC         ; $00D45C MOVE.B  $FEAC.W,D0
loc_00D460:
        DC.W    $11FB,$00EA,$C81A   ; $00D460 MOVE.B  -$16(PC,D0.W),$C81A.W
        DC.W    $41F9,$0089,$8BFC   ; $00D466 LEA     $00898BFC,A0
        DC.W    $E548               ; $00D46C LSL.W  #2,D0
        DC.W    $D1C0               ; $00D46E ADDA.L  D0,A0
        DC.W    $23D0,$00FF,$6828   ; $00D470 MOVE.L  (A0),$00FF6828
        DC.W    $4A01               ; $00D476 TST.B  D1
        DC.W    $6706               ; $00D478 BEQ.S  loc_00D480
        DC.W    $23D0,$00FF,$68B8   ; $00D47A MOVE.L  (A0),$00FF68B8
loc_00D480:
        DC.W    $4E75               ; $00D480 RTS
        DC.W    $0088,$0088,$00DC   ; $00D482 ORI.L  #$008800DC,A0
        DC.W    $0130,$4238         ; $00D488 BTST    D0,$38(A0,D4.W)
        DC.W    $A024               ; $00D48C MOVE.L  -(A4),D0
        DC.W    $11F8,$FEA5,$A019   ; $00D48E MOVE.B  $FEA5.W,$A019.W
        DC.W    $0838,$0007,$FDA8   ; $00D494 BTST    #7,$FDA8.W
        DC.W    $672E               ; $00D49A BEQ.S  loc_00D4CA
        DC.W    $11F8,$FEA6,$A019   ; $00D49C MOVE.B  $FEA6.W,$A019.W
        DC.W    $6026               ; $00D4A2 BRA.S  loc_00D4CA
        DC.W    $11FC,$0001,$A024   ; $00D4A4 MOVE.B  #$0001,$A024.W
        DC.W    $11F8,$FEA7,$A019   ; $00D4AA MOVE.B  $FEA7.W,$A019.W
        DC.W    $11F8,$FEA8,$A026   ; $00D4B0 MOVE.B  $FEA8.W,$A026.W
        DC.W    $6012               ; $00D4B6 BRA.S  loc_00D4CA
        DC.W    $11F8,$FEAB,$A019   ; $00D4B8 MOVE.B  $FEAB.W,$A019.W
        DC.W    $11F8,$FEAC,$A026   ; $00D4BE MOVE.B  $FEAC.W,$A026.W
        DC.W    $11FC,$0002,$A024   ; $00D4C4 MOVE.B  #$0002,$A024.W
loc_00D4CA:
        DC.W    $33FC,$002C,$00FF,$0008; $00D4CA MOVE.W  #$002C,$00FF0008
        DC.W    $31FC,$002C,$C87A   ; $00D4D2 MOVE.W  #$002C,$C87A.W
        DC.W    $08B8,$0006,$C875   ; $00D4D8 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00D4DE MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $00D4E2 MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $00D4EA ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$26C8   ; $00D4F2 JSR     $008826C8
        DC.W    $203C,$000A,$0907   ; $00D4F8 MOVE.L  #$000A0907,D0
        DC.W    $4EB9,$0088,$14BE   ; $00D4FE JSR     $008814BE
        DC.W    $11FC,$0001,$C80D   ; $00D504 MOVE.B  #$0001,$C80D.W
        DC.W    $41F9,$0088,$D832   ; $00D50A LEA     $0088D832,A0
        DC.W    $43F9,$00FF,$2000   ; $00D510 LEA     $00FF2000,A1
        DC.W    $303C,$0004         ; $00D516 MOVE.W  #$0004,D0
loc_00D51A:
        DC.W    $32D8               ; $00D51A MOVE.W  (A0)+,(A1)+
        DC.W    $32D8               ; $00D51C MOVE.W  (A0)+,(A1)+
        DC.W    $32D8               ; $00D51E MOVE.W  (A0)+,(A1)+
        DC.W    $32D8               ; $00D520 MOVE.W  (A0)+,(A1)+
        DC.W    $32D8               ; $00D522 MOVE.W  (A0)+,(A1)+
        DC.W    $51C8,$FFF4         ; $00D524 DBRA    D0,loc_00D51A
        DC.W    $7000               ; $00D528 MOVEQ   #$00,D0
        DC.W    $41F8,$8480         ; $00D52A LEA     $8480.W,A0
        DC.W    $721F               ; $00D52E MOVEQ   #$1F,D1
loc_00D530:
        DC.W    $20C0               ; $00D530 MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $00D532 DBRA    D1,loc_00D530
        DC.W    $41F9,$00FF,$7B80   ; $00D536 LEA     $00FF7B80,A0
        DC.W    $727F               ; $00D53C MOVEQ   #$7F,D1
loc_00D53E:
        DC.W    $20C0               ; $00D53E MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $00D540 DBRA    D1,loc_00D53E
        DC.W    $2ABC,$6000,$0002   ; $00D544 MOVE.L  #$60000002,(A5)
        DC.W    $323C,$17FF         ; $00D54A MOVE.W  #$17FF,D1
loc_00D54E:
        DC.W    $2C80               ; $00D54E MOVE.L  D0,(A6)
        DC.W    $51C9,$FFFC         ; $00D550 DBRA    D1,loc_00D54E
        DC.W    $4EB9,$0088,$49AA   ; $00D554 JSR     $008849AA
        DC.W    $4278,$C880         ; $00D55A CLR.W  $C880.W
        DC.W    $4278,$C882         ; $00D55E CLR.W  $C882.W
        DC.W    $4278,$8000         ; $00D562 CLR.W  $8000.W
        DC.W    $4278,$8002         ; $00D566 CLR.W  $8002.W
        DC.W    $4278,$A012         ; $00D56A CLR.W  $A012.W
        DC.W    $4238,$A018         ; $00D56E CLR.B  $A018.W
        DC.W    $4EB9,$0088,$49AA   ; $00D572 JSR     $008849AA
        DC.W    $21FC,$008B,$B4FC,$C96C; $00D578 MOVE.L  #$008BB4FC,$C96C.W
        DC.W    $11FC,$0001,$C809   ; $00D580 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00D586 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $00D58C BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00D592 MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0001,$A02C   ; $00D598 MOVE.W  #$0001,$A02C.W
        DC.W    $41F9,$00FF,$1000   ; $00D59E LEA     $00FF1000,A0
        DC.W    $303C,$037F         ; $00D5A4 MOVE.W  #$037F,D0
loc_00D5A8:
        DC.W    $4298               ; $00D5A8 CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $00D5AA DBRA    D0,loc_00D5A8
        DC.W    $4EBA,$0C0C         ; $00D5AE JSR     loc_00E1BC(PC)
        DC.W    $08B9,$0007,$00A1,$5181; $00D5B2 BCLR    #7,$00A15181
        DC.W    $41F9,$00FF,$6E00   ; $00D5BA LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0160   ; $00D5C0 ADDA.L  #$00000160,A0
        DC.W    $43F9,$0088,$D7B2   ; $00D5C6 LEA     $0088D7B2,A1
        DC.W    $303C,$003F         ; $00D5CC MOVE.W  #$003F,D0
loc_00D5D0:
        DC.W    $3219               ; $00D5D0 MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $00D5D2 BSET    #15,D1
        DC.W    $30C1               ; $00D5D6 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $00D5D8 DBRA    D0,loc_00D5D0
        DC.W    $41F9,$000E,$8000   ; $00D5DC LEA     $000E8000,A0
        DC.W    $227C,$0603,$7000   ; $00D5E2 MOVEA.L #$06037000,A1
        DC.W    $6100,$0D2C         ; $00D5E8 BSR.W  $00E316
        DC.W    $0838,$0007,$FDA8   ; $00D5EC BTST    #7,$FDA8.W
        DC.W    $6718               ; $00D5F2 BEQ.S  loc_00D60C
loc_00D5F4:
        DC.W    $4A39,$00A1,$5120   ; $00D5F4 TST.B  $00A15120
        DC.W    $66F8               ; $00D5FA BNE.S  loc_00D5F4
        DC.W    $13FC,$002E,$00A1,$5121; $00D5FC MOVE.B  #$002E,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00D604 MOVE.B  #$0001,$00A15120
loc_00D60C:
        DC.W    $41F9,$000E,$8C00   ; $00D60C LEA     $000E8C00,A0
        DC.W    $227C,$0603,$D100   ; $00D612 MOVEA.L #$0603D100,A1
        DC.W    $6100,$0CFC         ; $00D618 BSR.W  $00E316
        DC.W    $4A38,$A024         ; $00D61C TST.B  $A024.W
        DC.W    $6600,$004E         ; $00D620 BNE.W  loc_00D670
        DC.W    $41F9,$000E,$8A00   ; $00D624 LEA     $000E8A00,A0
        DC.W    $227C,$0603,$B600   ; $00D62A MOVEA.L #$0603B600,A1
        DC.W    $6100,$0CE4         ; $00D630 BSR.W  $00E316
        DC.W    $41F9,$000E,$B980   ; $00D634 LEA     $000EB980,A0
        DC.W    $227C,$0603,$DA00   ; $00D63A MOVEA.L #$0603DA00,A1
        DC.W    $6100,$0CD4         ; $00D640 BSR.W  $00E316
        DC.W    $303C,$0001         ; $00D644 MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $00D648 MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $00D64C MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $00D650 MOVE.W  #$0026,D3
        DC.W    $383C,$001A         ; $00D654 MOVE.W  #$001A,D4
        DC.W    $41F9,$00FF,$1000   ; $00D658 LEA     $00FF1000,A0
        DC.W    $4EBA,$0BCC         ; $00D65E JSR     $00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $00D662 LEA     $00FF1000,A0
        DC.W    $4EBA,$0C86         ; $00D668 JSR     $00E2F0(PC)
        DC.W    $6000,$0068         ; $00D66C BRA.W  loc_00D6D6
loc_00D670:
        DC.W    $41F9,$000E,$8E10   ; $00D670 LEA     $000E8E10,A0
        DC.W    $227C,$0603,$B600   ; $00D676 MOVEA.L #$0603B600,A1
        DC.W    $6100,$0C98         ; $00D67C BSR.W  $00E316
        DC.W    $41F9,$000E,$8FB0   ; $00D680 LEA     $000E8FB0,A0
        DC.W    $227C,$0603,$DA00   ; $00D686 MOVEA.L #$0603DA00,A1
        DC.W    $6100,$0C88         ; $00D68C BSR.W  $00E316
        DC.W    $303C,$0001         ; $00D690 MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $00D694 MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $00D698 MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $00D69C MOVE.W  #$0026,D3
        DC.W    $383C,$0016         ; $00D6A0 MOVE.W  #$0016,D4
        DC.W    $41F9,$00FF,$1000   ; $00D6A4 LEA     $00FF1000,A0
        DC.W    $4EBA,$0B80         ; $00D6AA JSR     $00E22C(PC)
        DC.W    $303C,$0002         ; $00D6AE MOVE.W  #$0002,D0
        DC.W    $323C,$0001         ; $00D6B2 MOVE.W  #$0001,D1
        DC.W    $343C,$0017         ; $00D6B6 MOVE.W  #$0017,D2
        DC.W    $363C,$0026         ; $00D6BA MOVE.W  #$0026,D3
        DC.W    $383C,$0004         ; $00D6BE MOVE.W  #$0004,D4
        DC.W    $41F9,$00FF,$1000   ; $00D6C2 LEA     $00FF1000,A0
        DC.W    $4EBA,$0B62         ; $00D6C8 JSR     $00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $00D6CC LEA     $00FF1000,A0
        DC.W    $4EBA,$0C1C         ; $00D6D2 JSR     $00E2F0(PC)
loc_00D6D6:
        DC.W    $4238,$A027         ; $00D6D6 CLR.B  $A027.W
        DC.W    $7000               ; $00D6DA MOVEQ   #$00,D0
        DC.W    $7200               ; $00D6DC MOVEQ   #$00,D1
        DC.W    $1038,$FEB1         ; $00D6DE MOVE.B  $FEB1.W,D0
        DC.W    $670C               ; $00D6E2 BEQ.S  loc_00D6F0
        DC.W    $5340               ; $00D6E4 SUBQ.W  #1,D0
loc_00D6E6:
        DC.W    $0681,$0000,$03C0   ; $00D6E6 ADDI.L  #$000003C0,D1
        DC.W    $51C8,$FFF8         ; $00D6EC DBRA    D0,loc_00D6E6
loc_00D6F0:
        DC.W    $5881               ; $00D6F0 ADDQ.L  #4,D1
        DC.W    $21C1,$A028         ; $00D6F2 MOVE.L  D1,$A028.W
        DC.W    $4EB9,$0088,$204A   ; $00D6F6 JSR     $0088204A
        DC.W    $0239,$00FC,$00A1,$5181; $00D6FC ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $00D704 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $00D70C MOVE.W  #$8083,$00A15100
        DC.W    $08F8,$0006,$C875   ; $00D714 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00D71A MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0020,$00FF,$0008; $00D71E MOVE.W  #$0020,$00FF0008
        DC.W    $4EB9,$0088,$4998   ; $00D726 JSR     $00884998
        DC.W    $31FC,$0000,$C87E   ; $00D72C MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0088,$D864,$00FF,$0002; $00D732 MOVE.L  #$0088D864,$00FF0002
        DC.W    $4A38,$A024         ; $00D73C TST.B  $A024.W
        DC.W    $670A               ; $00D740 BEQ.S  loc_00D74C
        DC.W    $23FC,$0088,$D888,$00FF,$0002; $00D742 MOVE.L  #$0088D888,$00FF0002
loc_00D74C:
        DC.W    $13FC,$0000,$00FF,$60D4; $00D74C MOVE.B  #$0000,$00FF60D4
        DC.W    $0838,$0007,$FDA8   ; $00D754 BTST    #7,$FDA8.W
        DC.W    $6700,$000A         ; $00D75A BEQ.W  loc_00D766
        DC.W    $13FC,$0001,$00FF,$60D4; $00D75E MOVE.B  #$0001,$00FF60D4
loc_00D766:
        DC.W    $41F9,$00FF,$6100   ; $00D766 LEA     $00FF6100,A0
        DC.W    $303C,$007F         ; $00D76C MOVE.W  #$007F,D0
loc_00D770:
        DC.W    $4298               ; $00D770 CLR.L  (A0)+
        DC.W    $4298               ; $00D772 CLR.L  (A0)+
        DC.W    $4298               ; $00D774 CLR.L  (A0)+
        DC.W    $4298               ; $00D776 CLR.L  (A0)+
        DC.W    $4298               ; $00D778 CLR.L  (A0)+
        DC.W    $51C8,$FFF4         ; $00D77A DBRA    D0,loc_00D770
loc_00D77E:
        DC.W    $4A39,$00A1,$5120   ; $00D77E TST.B  $00A15120
        DC.W    $66F8               ; $00D784 BNE.S  loc_00D77E
        DC.W    $4239,$00A1,$5122   ; $00D786 CLR.B  $00A15122
        DC.W    $4239,$00A1,$5123   ; $00D78C CLR.B  $00A15123
        DC.W    $13FC,$0003,$00A1,$5121; $00D792 MOVE.B  #$0003,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00D79A MOVE.B  #$0001,$00A15120
loc_00D7A2:
        DC.W    $4A39,$00A1,$5120   ; $00D7A2 TST.B  $00A15120
        DC.W    $66F8               ; $00D7A8 BNE.S  loc_00D7A2
        DC.W    $11FC,$0081,$C8A5   ; $00D7AA MOVE.B  #$0081,$C8A5.W
        DC.W    $4E75               ; $00D7B0 RTS
        DC.W    $4400               ; $00D7B2 NEG.B  D0
        DC.W    $44A3               ; $00D7B4 NEG.L  -(A3)
        DC.W    $4946               ; $00D7B6 DC.W    $4946
        DC.W    $4DE9,$1C00         ; $00D7B8 LEA     $1C00(A1),A6
        DC.W    $28A3               ; $00D7BC MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $00D7BE MOVE.W  D6,$41E9(A2)
        DC.W    $7FFF               ; $00D7C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $1C00               ; $00D7CA MOVE.B  D0,D6
        DC.W    $28A3               ; $00D7CC MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $00D7CE MOVE.W  D6,$41E9(A2)
        DC.W    $4400               ; $00D7D2 NEG.B  D0
        DC.W    $44A3               ; $00D7D4 NEG.L  -(A3)
        DC.W    $4946               ; $00D7D6 DC.W    $4946
        DC.W    $4DE9,$7FFF         ; $00D7D8 LEA     $7FFF(A1),A6
        DC.W    $63F5               ; $00D7DC BLS.S  loc_00D7D3
        DC.W    $7FFF               ; $00D7DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $00D7E2 ORI.B  #$14AF,(A0)
        DC.W    $294E,$3DED         ; $00D7E6 MOVE.L  A6,$3DED(A4)
        DC.W    $7FFF               ; $00D7EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $6337               ; $00D7F2 BLS.S  loc_00D82B
        DC.W    $6737               ; $00D7F4 BEQ.S  loc_00D82D
        DC.W    $6B58               ; $00D7F6 BMI.S  loc_00D850
        DC.W    $6F79               ; $00D7F8 BLE.S  loc_00D873
        DC.W    $6B36               ; $00D7FA BMI.S  loc_00D832
        DC.W    $6B37               ; $00D7FC BMI.S  loc_00D835
        DC.W    $6F58               ; $00D7FE BLE.S  loc_00D858
        DC.W    $6F79               ; $00D800 BLE.S  loc_00D87B
        DC.W    $739A,$61E8         ; $00D802 MOVE.W  (A2)+,-$18(A1,D6.W)
        DC.W    $7FFF               ; $00D806 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $1D4A,$4B3A         ; $00D808 MOVE.B  A2,$4B3A(A6)
        DC.W    $67FF,$3AB6,$25CE   ; $00D80C BEQ.L  $3AB6FDDC
        DC.W    $10E1               ; $00D812 MOVE.B  -(A1),(A0)+
        DC.W    $29A8,$4670,$6337   ; $00D814 MOVE.L  $4670(A0),$37(A4,D6.W)
loc_00D81A:
        DC.W    $4445               ; $00D81A NEG.W  D5
        DC.W    $512B,$6212         ; $00D81C SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $00D820 BGT.S  loc_00D81A
        DC.W    $7FFF               ; $00D822 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $031F               ; $00D824 BTST    D1,(A7)+
        DC.W    $7FFF               ; $00D826 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0000,$033E         ; $00D828 ORI.B  #$033E,D0
        DC.W    $63FF,$01AF,$0086   ; $00D82C BLS.L  $1AFD8B4
loc_00D832:
        DC.W    $0000,$0070         ; $00D832 ORI.B  #$0070,D0
        DC.W    $0110               ; $00D836 BTST    D0,(A0)
        DC.W    $0300               ; $00D838 BTST    D1,D0
        DC.W    $0000,$0000         ; $00D83A ORI.B  #$0000,D0
        DC.W    $0110               ; $00D83E BTST    D0,(A0)
        DC.W    $0130,$02C0         ; $00D840 BTST    D0,-$40(A0,D0.W)
        DC.W    $0000,$0000         ; $00D844 ORI.B  #$0000,D0
        DC.W    $0120               ; $00D848 BTST    D0,-(A0)
        DC.W    $0170,$02C0         ; $00D84A BCHG    D0,-$40(A0,D0.W)
        DC.W    $0000,$0000         ; $00D84E ORI.B  #$0000,D0
        DC.W    $0000,$0150         ; $00D852 ORI.B  #$0150,D0
        DC.W    $02C0               ; $00D856 DC.W    $02C0
loc_00D858:
        DC.W    $0000,$0000         ; $00D858 ORI.B  #$0000,D0
        DC.W    $0000,$0180         ; $00D85C ORI.B  #$0180,D0
        DC.W    $02C0               ; $00D860 DC.W    $02C0
        DC.W    $0000,$4EB9         ; $00D862 ORI.B  #$4EB9,D0
        DC.W    $0088,$2080,$3038   ; $00D866 ORI.L  #$20803038,A0
        DC.W    $C87E               ; $00D86C AND.W  <EA:3E>,D4
        DC.W    $227B,$0004         ; $00D86E MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00D872 JMP     (A1)
        DC.W    $0088,$D8CC,$0088   ; $00D874 ORI.L  #$D8CC0088,A0
        DC.W    $DAC0               ; $00D87A ADDA.W  D0,A5
        DC.W    $0088,$DCD0,$0088   ; $00D87C ORI.L  #$DCD00088,A0
        DC.W    $DFEC,$0088         ; $00D882 ADDA.L  $0088(A4),A7
        DC.W    $E00C               ; $00D886 LSR.B  #8,D4
        DC.W    $4EB9,$0088,$2080   ; $00D888 JSR     $00882080
        DC.W    $3038,$C87E         ; $00D88E MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $00D892 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00D896 JMP     (A1)
        DC.W    $0088,$D8CC,$0088   ; $00D898 ORI.L  #$D8CC0088,A0
        DC.W    $DAC0               ; $00D89E ADDA.W  D0,A5
        DC.W    $0088,$DECE,$0088   ; $00D8A0 ORI.L  #$DECE0088,A0
        DC.W    $DFEC,$0088         ; $00D8A6 ADDA.L  $0088(A4),A7
        DC.W    $E00C               ; $00D8AA LSR.B  #8,D4
        DC.W    $11FC,$0081,$C8A5   ; $00D8AC MOVE.B  #$0081,$C8A5.W
        DC.W    $5878,$C87E         ; $00D8B2 ADDQ.W  #4,$C87E.W
        DC.W    $4E75               ; $00D8B6 RTS
        DC.W    $4EBA,$DDCA         ; $00D8B8 JSR     $00B684(PC)
        DC.W    $0838,$0006,$C80E   ; $00D8BC BTST    #6,$C80E.W
        DC.W    $6606               ; $00D8C2 BNE.S  loc_00D8CA
        DC.W    $5878,$C87E         ; $00D8C4 ADDQ.W  #4,$C87E.W
        DC.W    $4E71               ; $00D8C8 NOP
loc_00D8CA:
        DC.W    $4E75               ; $00D8CA RTS
        DC.W    $41F9,$00FF,$6E00   ; $00D8CC LEA     $00FF6E00,A0
        DC.W    $43F9,$0088,$DAA8   ; $00D8D2 LEA     $0088DAA8,A1
        DC.W    $4240               ; $00D8D8 CLR.W  D0
        DC.W    $1038,$A019         ; $00D8DA MOVE.B  $A019.W,D0
        DC.W    $4A38,$A027         ; $00D8DE TST.B  $A027.W
        DC.W    $6700,$0006         ; $00D8E2 BEQ.W  loc_00D8EA
        DC.W    $1038,$A025         ; $00D8E6 MOVE.B  $A025.W,D0
loc_00D8EA:
        DC.W    $D040               ; $00D8EA ADD.W  D0,D0
        DC.W    $D040               ; $00D8EC ADD.W  D0,D0
        DC.W    $2271,$0000         ; $00D8EE MOVEA.L $00(A1,D0.W),A1
        DC.W    $303C,$007F         ; $00D8F2 MOVE.W  #$007F,D0
loc_00D8F6:
        DC.W    $30D9               ; $00D8F6 MOVE.W  (A1)+,(A0)+
        DC.W    $51C8,$FFFC         ; $00D8F8 DBRA    D0,loc_00D8F6
        DC.W    $43F9,$00FF,$6100   ; $00D8FC LEA     $00FF6100,A1
        DC.W    $337C,$0001,$0000   ; $00D902 MOVE.W  #$0001,$0000(A1)
        DC.W    $3378,$A01A,$0002   ; $00D908 MOVE.W  $A01A.W,$0002(A1)
        DC.W    $3378,$A01C,$0004   ; $00D90E MOVE.W  $A01C.W,$0004(A1)
        DC.W    $3378,$A01E,$0006   ; $00D914 MOVE.W  $A01E.W,$0006(A1)
        DC.W    $2038,$A014         ; $00D91A MOVE.L  $A014.W,D0
        DC.W    $3340,$000A         ; $00D91E MOVE.W  D0,$000A(A1)
        DC.W    $3378,$A020,$0008   ; $00D922 MOVE.W  $A020.W,$0008(A1)
        DC.W    $3378,$A022,$000C   ; $00D928 MOVE.W  $A022.W,$000C(A1)
        DC.W    $337C,$0000,$000E   ; $00D92E MOVE.W  #$0000,$000E(A1)
        DC.W    $41F9,$0088,$DA90   ; $00D934 LEA     $0088DA90,A0
        DC.W    $4241               ; $00D93A CLR.W  D1
        DC.W    $1238,$A019         ; $00D93C MOVE.B  $A019.W,D1
        DC.W    $4A38,$A027         ; $00D940 TST.B  $A027.W
        DC.W    $6704               ; $00D944 BEQ.S  loc_00D94A
        DC.W    $1238,$A025         ; $00D946 MOVE.B  $A025.W,D1
loc_00D94A:
        DC.W    $D241               ; $00D94A ADD.W  D1,D1
        DC.W    $D241               ; $00D94C ADD.W  D1,D1
        DC.W    $2370,$1000,$0010   ; $00D94E MOVE.L  $00(A0,D1.W),$0010(A1)
        DC.W    $33FC,$0044,$00A1,$5110; $00D954 MOVE.W  #$0044,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $00D95C MOVE.B  #$0004,$00A15107
        DC.W    $4239,$00A1,$5123   ; $00D964 CLR.B  $00A15123
        DC.W    $13FC,$002B,$00A1,$5121; $00D96A MOVE.B  #$002B,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00D972 MOVE.B  #$0001,$00A15120
loc_00D97A:
        DC.W    $0839,$0001,$00A1,$5123; $00D97A BTST    #1,$00A15123
        DC.W    $67F6               ; $00D982 BEQ.S  loc_00D97A
        DC.W    $08B9,$0001,$00A1,$5123; $00D984 BCLR    #1,$00A15123
        DC.W    $43F9,$00FF,$60C8   ; $00D98C LEA     $00FF60C8,A1
        DC.W    $45F9,$00A1,$5112   ; $00D992 LEA     $00A15112,A2
        DC.W    $3E3C,$0043         ; $00D998 MOVE.W  #$0043,D7
loc_00D99C:
        DC.W    $0839,$0007,$00A1,$5107; $00D99C BTST    #7,$00A15107
        DC.W    $66F6               ; $00D9A4 BNE.S  loc_00D99C
        DC.W    $3499               ; $00D9A6 MOVE.W  (A1)+,(A2)
        DC.W    $51CF,$FFF2         ; $00D9A8 DBRA    D7,loc_00D99C
        DC.W    $2038,$A014         ; $00D9AC MOVE.L  $A014.W,D0
        DC.W    $0680,$0000,$0080   ; $00D9B0 ADDI.L  #$00000080,D0
        DC.W    $0280,$0000,$FFFF   ; $00D9B6 ANDI.L  #$0000FFFF,D0
        DC.W    $21C0,$A014         ; $00D9BC MOVE.L  D0,$A014.W
        DC.W    $4EB9,$0088,$179E   ; $00D9C0 JSR     $0088179E
        DC.W    $4A78,$A02C         ; $00D9C6 TST.W  $A02C.W
        DC.W    $6600,$00B6         ; $00D9CA BNE.W  loc_00DA82
        DC.W    $4240               ; $00D9CE CLR.W  D0
        DC.W    $1038,$A027         ; $00D9D0 MOVE.B  $A027.W,D0
        DC.W    $6100,$0B56         ; $00D9D4 BSR.W  $00E52C
        DC.W    $1038,$A019         ; $00D9D8 MOVE.B  $A019.W,D0
        DC.W    $3238,$C86C         ; $00D9DC MOVE.W  $C86C.W,D1
        DC.W    $0801,$0003         ; $00D9E0 BTST    #3,D1
        DC.W    $6724               ; $00D9E4 BEQ.S  loc_00DA0A
        DC.W    $11FC,$00A9,$C8A4   ; $00D9E6 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A38,$A027         ; $00D9EC TST.B  $A027.W
        DC.W    $6600,$000A         ; $00D9F0 BNE.W  loc_00D9FC
        DC.W    $0C00,$0004         ; $00D9F4 CMPI.B  #$0004,D0
        DC.W    $6C0C               ; $00D9F8 BGE.S  loc_00DA06
        DC.W    $6006               ; $00D9FA BRA.S  loc_00DA02
loc_00D9FC:
        DC.W    $0C00,$0003         ; $00D9FC CMPI.B  #$0003,D0
        DC.W    $6C04               ; $00DA00 BGE.S  loc_00DA06
loc_00DA02:
        DC.W    $5200               ; $00DA02 ADDQ.B  #1,D0
        DC.W    $6078               ; $00DA04 BRA.S  loc_00DA7E
loc_00DA06:
        DC.W    $4200               ; $00DA06 CLR.B  D0
        DC.W    $6074               ; $00DA08 BRA.S  loc_00DA7E
loc_00DA0A:
        DC.W    $0801,$0002         ; $00DA0A BTST    #2,D1
        DC.W    $6722               ; $00DA0E BEQ.S  loc_00DA32
        DC.W    $11FC,$00A9,$C8A4   ; $00DA10 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A00               ; $00DA16 TST.B  D0
        DC.W    $6F04               ; $00DA18 BLE.S  loc_00DA1E
        DC.W    $5300               ; $00DA1A SUBQ.B  #1,D0
        DC.W    $6060               ; $00DA1C BRA.S  loc_00DA7E
loc_00DA1E:
        DC.W    $4A38,$A027         ; $00DA1E TST.B  $A027.W
        DC.W    $6600,$0008         ; $00DA22 BNE.W  loc_00DA2C
        DC.W    $103C,$0004         ; $00DA26 MOVE.B  #$0004,D0
        DC.W    $6052               ; $00DA2A BRA.S  loc_00DA7E
loc_00DA2C:
        DC.W    $103C,$0003         ; $00DA2C MOVE.B  #$0003,D0
        DC.W    $604C               ; $00DA30 BRA.S  loc_00DA7E
loc_00DA32:
        DC.W    $4A38,$A024         ; $00DA32 TST.B  $A024.W
        DC.W    $6746               ; $00DA36 BEQ.S  loc_00DA7E
        DC.W    $0801,$0000         ; $00DA38 BTST    #0,D1
        DC.W    $6700,$001C         ; $00DA3C BEQ.W  loc_00DA5A
        DC.W    $4A38,$A027         ; $00DA40 TST.B  $A027.W
        DC.W    $6738               ; $00DA44 BEQ.S  loc_00DA7E
        DC.W    $11FC,$00A9,$C8A4   ; $00DA46 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4238,$A027         ; $00DA4C CLR.B  $A027.W
        DC.W    $11C0,$A026         ; $00DA50 MOVE.B  D0,$A026.W
        DC.W    $1038,$A025         ; $00DA54 MOVE.B  $A025.W,D0
        DC.W    $6024               ; $00DA58 BRA.S  loc_00DA7E
loc_00DA5A:
        DC.W    $0801,$0001         ; $00DA5A BTST    #1,D1
        DC.W    $6700,$001E         ; $00DA5E BEQ.W  loc_00DA7E
        DC.W    $0C38,$0001,$A027   ; $00DA62 CMPI.B  #$0001,$A027.W
        DC.W    $6C14               ; $00DA68 BGE.S  loc_00DA7E
        DC.W    $11FC,$00A9,$C8A4   ; $00DA6A MOVE.B  #$00A9,$C8A4.W
        DC.W    $11FC,$0001,$A027   ; $00DA70 MOVE.B  #$0001,$A027.W
        DC.W    $11C0,$A025         ; $00DA76 MOVE.B  D0,$A025.W
        DC.W    $1038,$A026         ; $00DA7A MOVE.B  $A026.W,D0
loc_00DA7E:
        DC.W    $11C0,$A019         ; $00DA7E MOVE.B  D0,$A019.W
loc_00DA82:
        DC.W    $5878,$C87E         ; $00DA82 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $00DA86 MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $00DA8E RTS
        DC.W    $2229,$6AE2         ; $00DA90 MOVE.L  $6AE2(A1),D1
        DC.W    $2229,$840C         ; $00DA94 MOVE.L  -$7BF4(A1),D1
        DC.W    $2229,$A2EE         ; $00DA98 MOVE.L  -$5D12(A1),D1
        DC.W    $2229,$B9F8         ; $00DA9C MOVE.L  -$4608(A1),D1
        DC.W    $2229,$D32C         ; $00DAA0 MOVE.L  -$2CD4(A1),D1
        DC.W    $2229,$6AE2         ; $00DAA4 MOVE.L  $6AE2(A1),D1
        DC.W    $008B,$B65C,$008B   ; $00DAA8 ORI.L  #$B65C008B,A3
        DC.W    $B75C               ; $00DAAE EOR.W  D3,(A4)+
        DC.W    $008B,$B85C,$008B   ; $00DAB0 ORI.L  #$B85C008B,A3
        DC.W    $B95C               ; $00DAB6 EOR.W  D4,(A4)+
        DC.W    $008B,$BA5C,$008B   ; $00DAB8 ORI.L  #$BA5C008B,A3
        DC.W    $B65C               ; $00DABE CMP.W  (A4)+,D3
        DC.W    $4240               ; $00DAC0 CLR.W  D0
        DC.W    $1038,$A027         ; $00DAC2 MOVE.B  $A027.W,D0
        DC.W    $4EBA,$0A64         ; $00DAC6 JSR     $00E52C(PC)
        DC.W    $207C,$0603,$D100   ; $00DACA MOVEA.L #$0603D100,A0
        DC.W    $227C,$2400,$4C58   ; $00DAD0 MOVEA.L #$24004C58,A1
        DC.W    $303C,$0090         ; $00DAD6 MOVE.W  #$0090,D0
        DC.W    $323C,$0010         ; $00DADA MOVE.W  #$0010,D1
        DC.W    $6100,$087A         ; $00DADE BSR.W  $00E35A
        DC.W    $4240               ; $00DAE2 CLR.W  D0
        DC.W    $1038,$A019         ; $00DAE4 MOVE.B  $A019.W,D0
        DC.W    $4A38,$A027         ; $00DAE8 TST.B  $A027.W
        DC.W    $6700,$0006         ; $00DAEC BEQ.W  loc_00DAF4
        DC.W    $1038,$A025         ; $00DAF0 MOVE.B  $A025.W,D0
loc_00DAF4:
        DC.W    $D040               ; $00DAF4 ADD.W  D0,D0
        DC.W    $3200               ; $00DAF6 MOVE.W  D0,D1
        DC.W    $D040               ; $00DAF8 ADD.W  D0,D0
        DC.W    $D040               ; $00DAFA ADD.W  D0,D0
        DC.W    $D041               ; $00DAFC ADD.W  D1,D0
        DC.W    $41F9,$00FF,$2000   ; $00DAFE LEA     $00FF2000,A0
        DC.W    $31F0,$0000,$A01A   ; $00DB04 MOVE.W  $00(A0,D0.W),$A01A.W
        DC.W    $31F0,$0002,$A01C   ; $00DB0A MOVE.W  $02(A0,D0.W),$A01C.W
        DC.W    $31F0,$0004,$A01E   ; $00DB10 MOVE.W  $04(A0,D0.W),$A01E.W
        DC.W    $31F0,$0006,$A020   ; $00DB16 MOVE.W  $06(A0,D0.W),$A020.W
        DC.W    $31F0,$0008,$A022   ; $00DB1C MOVE.W  $08(A0,D0.W),$A022.W
        DC.W    $3238,$C86E         ; $00DB22 MOVE.W  $C86E.W,D1
        DC.W    $E089               ; $00DB26 LSR.L  #8,D1
        DC.W    $0801,$0007         ; $00DB28 BTST    #7,D1
        DC.W    $6700,$0130         ; $00DB2C BEQ.W  loc_00DC5E
        DC.W    $0801,$0005         ; $00DB30 BTST    #5,D1
        DC.W    $6600,$00CE         ; $00DB34 BNE.W  loc_00DC04
        DC.W    $0801,$0000         ; $00DB38 BTST    #0,D1
        DC.W    $671C               ; $00DB3C BEQ.S  loc_00DB5A
        DC.W    $3038,$A01C         ; $00DB3E MOVE.W  $A01C.W,D0
        DC.W    $6100,$0168         ; $00DB42 BSR.W  loc_00DCAC
        DC.W    $0C40,$02F0         ; $00DB46 CMPI.W  #$02F0,D0
        DC.W    $6D00,$0006         ; $00DB4A BLT.W  loc_00DB52
        DC.W    $303C,$02F0         ; $00DB4E MOVE.W  #$02F0,D0
loc_00DB52:
        DC.W    $31C0,$A01C         ; $00DB52 MOVE.W  D0,$A01C.W
        DC.W    $6000,$0106         ; $00DB56 BRA.W  loc_00DC5E
loc_00DB5A:
        DC.W    $0801,$0001         ; $00DB5A BTST    #1,D1
        DC.W    $671C               ; $00DB5E BEQ.S  loc_00DB7C
        DC.W    $3038,$A01C         ; $00DB60 MOVE.W  $A01C.W,D0
        DC.W    $6100,$0158         ; $00DB64 BSR.W  loc_00DCBE
        DC.W    $0C40,$FBFE         ; $00DB68 CMPI.W  #$FBFE,D0
        DC.W    $6E00,$0006         ; $00DB6C BGT.W  loc_00DB74
        DC.W    $303C,$FBFE         ; $00DB70 MOVE.W  #$FBFE,D0
loc_00DB74:
        DC.W    $31C0,$A01C         ; $00DB74 MOVE.W  D0,$A01C.W
        DC.W    $6000,$00E4         ; $00DB78 BRA.W  loc_00DC5E
loc_00DB7C:
        DC.W    $0801,$0003         ; $00DB7C BTST    #3,D1
        DC.W    $671C               ; $00DB80 BEQ.S  loc_00DB9E
        DC.W    $3038,$A01A         ; $00DB82 MOVE.W  $A01A.W,D0
        DC.W    $6100,$0124         ; $00DB86 BSR.W  loc_00DCAC
        DC.W    $0C40,$0120         ; $00DB8A CMPI.W  #$0120,D0
        DC.W    $6D00,$0006         ; $00DB8E BLT.W  loc_00DB96
        DC.W    $303C,$0120         ; $00DB92 MOVE.W  #$0120,D0
loc_00DB96:
        DC.W    $31C0,$A01A         ; $00DB96 MOVE.W  D0,$A01A.W
        DC.W    $6000,$00C2         ; $00DB9A BRA.W  loc_00DC5E
loc_00DB9E:
        DC.W    $0801,$0002         ; $00DB9E BTST    #2,D1
        DC.W    $671C               ; $00DBA2 BEQ.S  loc_00DBC0
        DC.W    $3038,$A01A         ; $00DBA4 MOVE.W  $A01A.W,D0
        DC.W    $6100,$0114         ; $00DBA8 BSR.W  loc_00DCBE
        DC.W    $0C40,$FEE0         ; $00DBAC CMPI.W  #$FEE0,D0
        DC.W    $6E00,$0006         ; $00DBB0 BGT.W  loc_00DBB8
        DC.W    $303C,$FEE0         ; $00DBB4 MOVE.W  #$FEE0,D0
loc_00DBB8:
        DC.W    $31C0,$A01A         ; $00DBB8 MOVE.W  D0,$A01A.W
        DC.W    $6000,$00A0         ; $00DBBC BRA.W  loc_00DC5E
loc_00DBC0:
        DC.W    $0801,$0006         ; $00DBC0 BTST    #6,D1
        DC.W    $671C               ; $00DBC4 BEQ.S  loc_00DBE2
        DC.W    $3038,$A01E         ; $00DBC6 MOVE.W  $A01E.W,D0
        DC.W    $6100,$00E0         ; $00DBCA BSR.W  loc_00DCAC
        DC.W    $0C40,$0460         ; $00DBCE CMPI.W  #$0460,D0
        DC.W    $6D00,$0006         ; $00DBD2 BLT.W  loc_00DBDA
        DC.W    $303C,$0460         ; $00DBD6 MOVE.W  #$0460,D0
loc_00DBDA:
        DC.W    $31C0,$A01E         ; $00DBDA MOVE.W  D0,$A01E.W
        DC.W    $6000,$007E         ; $00DBDE BRA.W  loc_00DC5E
loc_00DBE2:
        DC.W    $0801,$0004         ; $00DBE2 BTST    #4,D1
        DC.W    $6776               ; $00DBE6 BEQ.S  loc_00DC5E
        DC.W    $3038,$A01E         ; $00DBE8 MOVE.W  $A01E.W,D0
        DC.W    $6100,$00D0         ; $00DBEC BSR.W  loc_00DCBE
        DC.W    $0C40,$0050         ; $00DBF0 CMPI.W  #$0050,D0
        DC.W    $6E00,$0006         ; $00DBF4 BGT.W  loc_00DBFC
        DC.W    $303C,$0050         ; $00DBF8 MOVE.W  #$0050,D0
loc_00DBFC:
        DC.W    $31C0,$A01E         ; $00DBFC MOVE.W  D0,$A01E.W
        DC.W    $6000,$005C         ; $00DC00 BRA.W  loc_00DC5E
loc_00DC04:
        DC.W    $0801,$0000         ; $00DC04 BTST    #0,D1
        DC.W    $6710               ; $00DC08 BEQ.S  loc_00DC1A
        DC.W    $3038,$A020         ; $00DC0A MOVE.W  $A020.W,D0
        DC.W    $6100,$00A8         ; $00DC0E BSR.W  loc_00DCB8
        DC.W    $31C0,$A020         ; $00DC12 MOVE.W  D0,$A020.W
        DC.W    $6000,$0046         ; $00DC16 BRA.W  loc_00DC5E
loc_00DC1A:
        DC.W    $0801,$0001         ; $00DC1A BTST    #1,D1
        DC.W    $6710               ; $00DC1E BEQ.S  loc_00DC30
        DC.W    $3038,$A020         ; $00DC20 MOVE.W  $A020.W,D0
        DC.W    $6100,$00A4         ; $00DC24 BSR.W  loc_00DCCA
        DC.W    $31C0,$A020         ; $00DC28 MOVE.W  D0,$A020.W
        DC.W    $6000,$0030         ; $00DC2C BRA.W  loc_00DC5E
loc_00DC30:
        DC.W    $0801,$0003         ; $00DC30 BTST    #3,D1
        DC.W    $6710               ; $00DC34 BEQ.S  loc_00DC46
        DC.W    $3038,$A022         ; $00DC36 MOVE.W  $A022.W,D0
        DC.W    $6100,$007C         ; $00DC3A BSR.W  loc_00DCB8
        DC.W    $31C0,$A022         ; $00DC3E MOVE.W  D0,$A022.W
        DC.W    $6000,$001A         ; $00DC42 BRA.W  loc_00DC5E
loc_00DC46:
        DC.W    $0801,$0002         ; $00DC46 BTST    #2,D1
        DC.W    $6712               ; $00DC4A BEQ.S  loc_00DC5E
        DC.W    $3038,$A022         ; $00DC4C MOVE.W  $A022.W,D0
        DC.W    $6100,$0078         ; $00DC50 BSR.W  loc_00DCCA
        DC.W    $31C0,$A022         ; $00DC54 MOVE.W  D0,$A022.W
        DC.W    $6000,$0004         ; $00DC58 BRA.W  loc_00DC5E
        DC.W    $4E71               ; $00DC5C NOP
loc_00DC5E:
        DC.W    $4240               ; $00DC5E CLR.W  D0
        DC.W    $1038,$A019         ; $00DC60 MOVE.B  $A019.W,D0
        DC.W    $4A38,$A027         ; $00DC64 TST.B  $A027.W
        DC.W    $6700,$0006         ; $00DC68 BEQ.W  loc_00DC70
        DC.W    $1038,$A025         ; $00DC6C MOVE.B  $A025.W,D0
loc_00DC70:
        DC.W    $D040               ; $00DC70 ADD.W  D0,D0
        DC.W    $3200               ; $00DC72 MOVE.W  D0,D1
        DC.W    $D040               ; $00DC74 ADD.W  D0,D0
        DC.W    $D040               ; $00DC76 ADD.W  D0,D0
        DC.W    $D041               ; $00DC78 ADD.W  D1,D0
        DC.W    $41F9,$00FF,$2000   ; $00DC7A LEA     $00FF2000,A0
        DC.W    $31B8,$A01A,$0000   ; $00DC80 MOVE.W  $A01A.W,$00(A0,D0.W)
        DC.W    $31B8,$A01C,$0002   ; $00DC86 MOVE.W  $A01C.W,$02(A0,D0.W)
        DC.W    $31B8,$A01E,$0004   ; $00DC8C MOVE.W  $A01E.W,$04(A0,D0.W)
        DC.W    $31B8,$A020,$0006   ; $00DC92 MOVE.W  $A020.W,$06(A0,D0.W)
        DC.W    $31B8,$A022,$0008   ; $00DC98 MOVE.W  $A022.W,$08(A0,D0.W)
        DC.W    $33FC,$0020,$00FF,$0008; $00DC9E MOVE.W  #$0020,$00FF0008
        DC.W    $5878,$C87E         ; $00DCA6 ADDQ.W  #4,$C87E.W
        DC.W    $4E75               ; $00DCAA RTS
loc_00DCAC:
        DC.W    $0C40,$4000         ; $00DCAC CMPI.W  #$4000,D0
        DC.W    $6E0A               ; $00DCB0 BGT.S  loc_00DCBC
        DC.W    $0640,$0010         ; $00DCB2 ADDI.W  #$0010,D0
        DC.W    $6004               ; $00DCB6 BRA.S  loc_00DCBC
loc_00DCB8:
        DC.W    $0640,$0040         ; $00DCB8 ADDI.W  #$0040,D0
loc_00DCBC:
        DC.W    $4E75               ; $00DCBC RTS
loc_00DCBE:
        DC.W    $0C40,$C000         ; $00DCBE CMPI.W  #$C000,D0
        DC.W    $6D0A               ; $00DCC2 BLT.S  loc_00DCCE
        DC.W    $0440,$0010         ; $00DCC4 SUBI.W  #$0010,D0
        DC.W    $6004               ; $00DCC8 BRA.S  loc_00DCCE
loc_00DCCA:
        DC.W    $0440,$0040         ; $00DCCA SUBI.W  #$0040,D0
loc_00DCCE:
        DC.W    $4E75               ; $00DCCE RTS
        DC.W    $4240               ; $00DCD0 CLR.W  D0
        DC.W    $4EBA,$0858         ; $00DCD2 JSR     $00E52C(PC)
        DC.W    $4EBA,$D9AC         ; $00DCD6 JSR     $00B684(PC)
        DC.W    $4EBA,$D9FE         ; $00DCDA JSR     $00B6DA(PC)
loc_00DCDE:
        DC.W    $4A39,$00A1,$5120   ; $00DCDE TST.B  $00A15120
        DC.W    $66F8               ; $00DCE4 BNE.S  loc_00DCDE
        DC.W    $207C,$0603,$7000   ; $00DCE6 MOVEA.L #$06037000,A0
        DC.W    $227C,$2401,$8010   ; $00DCEC MOVEA.L #$24018010,A1
        DC.W    $303C,$0120         ; $00DCF2 MOVE.W  #$0120,D0
        DC.W    $323C,$0030         ; $00DCF6 MOVE.W  #$0030,D1
        DC.W    $6100,$065E         ; $00DCFA BSR.W  $00E35A
        DC.W    $0838,$0007,$FDA8   ; $00DCFE BTST    #7,$FDA8.W
        DC.W    $6600,$0036         ; $00DD04 BNE.W  loc_00DD3C
        DC.W    $207C,$0603,$A600   ; $00DD08 MOVEA.L #$0603A600,A0
        DC.W    $7600               ; $00DD0E MOVEQ   #$00,D3
        DC.W    $383C,$0004         ; $00DD10 MOVE.W  #$0004,D4
loc_00DD14:
        DC.W    $0738,$EF07         ; $00DD14 BTST    D3,$EF07.W
        DC.W    $671C               ; $00DD18 BEQ.S  loc_00DD36
        DC.W    $43F9,$0088,$DEB6   ; $00DD1A LEA     $0088DEB6,A1
        DC.W    $3003               ; $00DD20 MOVE.W  D3,D0
        DC.W    $D040               ; $00DD22 ADD.W  D0,D0
        DC.W    $D040               ; $00DD24 ADD.W  D0,D0
        DC.W    $2271,$0000         ; $00DD26 MOVEA.L $00(A1,D0.W),A1
        DC.W    $303C,$0010         ; $00DD2A MOVE.W  #$0010,D0
        DC.W    $323C,$0010         ; $00DD2E MOVE.W  #$0010,D1
        DC.W    $6100,$0626         ; $00DD32 BSR.W  $00E35A
loc_00DD36:
        DC.W    $5243               ; $00DD36 ADDQ.W  #1,D3
        DC.W    $51CC,$FFDA         ; $00DD38 DBRA    D4,loc_00DD14
loc_00DD3C:
        DC.W    $207C,$0603,$B600   ; $00DD3C MOVEA.L #$0603B600,A0
        DC.W    $227C,$2401,$4010   ; $00DD42 MOVEA.L #$24014010,A1
        DC.W    $303C,$0120         ; $00DD48 MOVE.W  #$0120,D0
        DC.W    $323C,$0018         ; $00DD4C MOVE.W  #$0018,D1
        DC.W    $6100,$0608         ; $00DD50 BSR.W  $00E35A
        DC.W    $43F9,$2403,$4850   ; $00DD54 LEA     $24034850,A1
        DC.W    $45F8,$EF08         ; $00DD5A LEA     $EF08.W,A2
        DC.W    $D5F8,$A028         ; $00DD5E ADDA.L  $A028.W,A2
        DC.W    $7000               ; $00DD62 MOVEQ   #$00,D0
        DC.W    $1038,$A019         ; $00DD64 MOVE.B  $A019.W,D0
        DC.W    $D040               ; $00DD68 ADD.W  D0,D0
        DC.W    $D040               ; $00DD6A ADD.W  D0,D0
        DC.W    $D040               ; $00DD6C ADD.W  D0,D0
        DC.W    $D040               ; $00DD6E ADD.W  D0,D0
        DC.W    $3200               ; $00DD70 MOVE.W  D0,D1
        DC.W    $D040               ; $00DD72 ADD.W  D0,D0
        DC.W    $D040               ; $00DD74 ADD.W  D0,D0
        DC.W    $D041               ; $00DD76 ADD.W  D1,D0
        DC.W    $D040               ; $00DD78 ADD.W  D0,D0
        DC.W    $D5C0               ; $00DD7A ADDA.L  D0,A2
        DC.W    $0838,$0007,$FDA8   ; $00DD7C BTST    #7,$FDA8.W
        DC.W    $6700,$0008         ; $00DD82 BEQ.W  loc_00DD8C
        DC.W    $45F9,$0088,$DECA   ; $00DD86 LEA     $0088DECA,A2
loc_00DD8C:
        DC.W    $4EBA,$06D8         ; $00DD8C JSR     $00E466(PC)
        DC.W    $43F9,$2403,$48E8   ; $00DD90 LEA     $240348E8,A1
        DC.W    $45F8,$FA48         ; $00DD96 LEA     $FA48.W,A2
        DC.W    $7000               ; $00DD9A MOVEQ   #$00,D0
        DC.W    $1038,$FEB1         ; $00DD9C MOVE.B  $FEB1.W,D0
        DC.W    $D040               ; $00DDA0 ADD.W  D0,D0
        DC.W    $D040               ; $00DDA2 ADD.W  D0,D0
        DC.W    $D040               ; $00DDA4 ADD.W  D0,D0
        DC.W    $3200               ; $00DDA6 MOVE.W  D0,D1
        DC.W    $D040               ; $00DDA8 ADD.W  D0,D0
        DC.W    $D041               ; $00DDAA ADD.W  D1,D0
        DC.W    $D040               ; $00DDAC ADD.W  D0,D0
        DC.W    $D5C0               ; $00DDAE ADDA.L  D0,A2
        DC.W    $7000               ; $00DDB0 MOVEQ   #$00,D0
        DC.W    $1038,$A019         ; $00DDB2 MOVE.B  $A019.W,D0
        DC.W    $D040               ; $00DDB6 ADD.W  D0,D0
        DC.W    $D040               ; $00DDB8 ADD.W  D0,D0
        DC.W    $D040               ; $00DDBA ADD.W  D0,D0
        DC.W    $5840               ; $00DDBC ADDQ.W  #4,D0
        DC.W    $D5C0               ; $00DDBE ADDA.L  D0,A2
        DC.W    $0838,$0007,$FDA8   ; $00DDC0 BTST    #7,$FDA8.W
        DC.W    $6700,$0008         ; $00DDC6 BEQ.W  loc_00DDD0
        DC.W    $45F9,$0088,$DECA   ; $00DDCA LEA     $0088DECA,A2
loc_00DDD0:
        DC.W    $4EBA,$0694         ; $00DDD0 JSR     $00E466(PC)
        DC.W    $7000               ; $00DDD4 MOVEQ   #$00,D0
        DC.W    $1038,$A019         ; $00DDD6 MOVE.B  $A019.W,D0
        DC.W    $43F9,$0088,$DE98   ; $00DDDA LEA     $0088DE98,A1
        DC.W    $D040               ; $00DDE0 ADD.W  D0,D0
        DC.W    $3200               ; $00DDE2 MOVE.W  D0,D1
        DC.W    $D040               ; $00DDE4 ADD.W  D0,D0
        DC.W    $D041               ; $00DDE6 ADD.W  D1,D0
        DC.W    $2071,$0000         ; $00DDE8 MOVEA.L $00(A1,D0.W),A0
        DC.W    $3031,$0004         ; $00DDEC MOVE.W  $04(A1,D0.W),D0
        DC.W    $323C,$0030         ; $00DDF0 MOVE.W  #$0030,D1
        DC.W    $343C,$0010         ; $00DDF4 MOVE.W  #$0010,D2
loc_00DDF8:
        DC.W    $4A39,$00A1,$5120   ; $00DDF8 TST.B  $00A15120
        DC.W    $66F8               ; $00DDFE BNE.S  loc_00DDF8
        DC.W    $6100,$05B2         ; $00DE00 BSR.W  $00E3B4
        DC.W    $33FC,$0018,$00FF,$0008; $00DE04 MOVE.W  #$0018,$00FF0008
        DC.W    $0C78,$0001,$A02C   ; $00DE0C CMPI.W  #$0001,$A02C.W
        DC.W    $6700,$0054         ; $00DE12 BEQ.W  loc_00DE68
        DC.W    $0C78,$0002,$A02C   ; $00DE16 CMPI.W  #$0002,$A02C.W
        DC.W    $6700,$005A         ; $00DE1C BEQ.W  loc_00DE78
        DC.W    $3238,$C86C         ; $00DE20 MOVE.W  $C86C.W,D1
        DC.W    $0201,$00E0         ; $00DE24 ANDI.B  #$00E0,D1
        DC.W    $6616               ; $00DE28 BNE.S  loc_00DE40
        DC.W    $3238,$C86C         ; $00DE2A MOVE.W  $C86C.W,D1
        DC.W    $0201,$0010         ; $00DE2E ANDI.B  #$0010,D1
        DC.W    $6608               ; $00DE32 BNE.S  loc_00DE3C
        DC.W    $5178,$C87E         ; $00DE34 SUBQ.W  #8,$C87E.W
        DC.W    $6000,$0056         ; $00DE38 BRA.W  loc_00DE90
loc_00DE3C:
        DC.W    $50F8,$A018         ; $00DE3C ST      $A018.W
loc_00DE40:
        DC.W    $11FC,$00A8,$C8A4   ; $00DE40 MOVE.B  #$00A8,$C8A4.W
        DC.W    $11FC,$0001,$C809   ; $00DE46 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00DE4C MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $00DE52 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00DE58 MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0002,$A02C   ; $00DE5E MOVE.W  #$0002,$A02C.W
        DC.W    $6000,$0026         ; $00DE64 BRA.W  loc_00DE8C
loc_00DE68:
        DC.W    $0838,$0006,$C80E   ; $00DE68 BTST    #6,$C80E.W
        DC.W    $661C               ; $00DE6E BNE.S  loc_00DE8C
        DC.W    $4278,$A02C         ; $00DE70 CLR.W  $A02C.W
        DC.W    $6000,$0016         ; $00DE74 BRA.W  loc_00DE8C
loc_00DE78:
        DC.W    $0838,$0007,$C80E   ; $00DE78 BTST    #7,$C80E.W
        DC.W    $660C               ; $00DE7E BNE.S  loc_00DE8C
        DC.W    $4278,$A02C         ; $00DE80 CLR.W  $A02C.W
        DC.W    $5878,$C87E         ; $00DE84 ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $00DE88 BRA.W  loc_00DE90
loc_00DE8C:
        DC.W    $5178,$C87E         ; $00DE8C SUBQ.W  #8,$C87E.W
loc_00DE90:
        DC.W    $11FC,$0001,$C821   ; $00DE90 MOVE.B  #$0001,$C821.W
        DC.W    $4E75               ; $00DE96 RTS
        DC.W    $2401               ; $00DE98 MOVE.L  D1,D2
        DC.W    $8010               ; $00DE9A OR.B   (A0),D0
        DC.W    $003A,$2401,$8049   ; $00DE9C ORI.B  #$2401,-$7FB7(PC)
        DC.W    $003B,$2401,$8083   ; $00DEA2 ORI.B  #$2401,-$7D(PC,A0.W)
        DC.W    $003A,$2401,$80BC   ; $00DEA8 ORI.B  #$2401,-$7F44(PC)
        DC.W    $003A,$2401,$80F5   ; $00DEAE ORI.B  #$2401,-$7F0B(PC)
        DC.W    $003B,$2403,$8412   ; $00DEB4 ORI.B  #$2403,$12(PC,A0.W)
        DC.W    $2403               ; $00DEBA MOVE.L  D3,D2
        DC.W    $844C               ; $00DEBC OR.W   A4,D2
        DC.W    $2403               ; $00DEBE MOVE.L  D3,D2
        DC.W    $8486               ; $00DEC0 OR.L   D6,D2
        DC.W    $2403               ; $00DEC2 MOVE.L  D3,D2
        DC.W    $84BE               ; $00DEC4 OR.L   <EA:3E>,D2
        DC.W    $2403               ; $00DEC6 MOVE.L  D3,D2
        DC.W    $84F8,$CCCC         ; $00DEC8 DIVU    $CCCC.W,D2
        DC.W    $0CCC               ; $00DECC DC.W    $0CCC
        DC.W    $4240               ; $00DECE CLR.W  D0
        DC.W    $1038,$A027         ; $00DED0 MOVE.B  $A027.W,D0
        DC.W    $4EBA,$0656         ; $00DED4 JSR     $00E52C(PC)
        DC.W    $4EBA,$D7AA         ; $00DED8 JSR     $00B684(PC)
        DC.W    $4EBA,$D7FC         ; $00DEDC JSR     $00B6DA(PC)
loc_00DEE0:
        DC.W    $4A39,$00A1,$5120   ; $00DEE0 TST.B  $00A15120
        DC.W    $66F8               ; $00DEE6 BNE.S  loc_00DEE0
        DC.W    $207C,$0603,$7000   ; $00DEE8 MOVEA.L #$06037000,A0
        DC.W    $227C,$2401,$4010   ; $00DEEE MOVEA.L #$24014010,A1
        DC.W    $303C,$0120         ; $00DEF4 MOVE.W  #$0120,D0
        DC.W    $323C,$0030         ; $00DEF8 MOVE.W  #$0030,D1
        DC.W    $6100,$045C         ; $00DEFC BSR.W  $00E35A
        DC.W    $207C,$0603,$B600   ; $00DF00 MOVEA.L #$0603B600,A0
        DC.W    $227C,$2401,$C010   ; $00DF06 MOVEA.L #$2401C010,A1
        DC.W    $303C,$0120         ; $00DF0C MOVE.W  #$0120,D0
        DC.W    $323C,$0010         ; $00DF10 MOVE.W  #$0010,D1
        DC.W    $6100,$0444         ; $00DF14 BSR.W  $00E35A
loc_00DF18:
        DC.W    $4A39,$00A1,$5120   ; $00DF18 TST.B  $00A15120
        DC.W    $66F8               ; $00DF1E BNE.S  loc_00DF18
        DC.W    $6100,$01F6         ; $00DF20 BSR.W  loc_00E118
        DC.W    $207C,$0603,$DA00   ; $00DF24 MOVEA.L #$0603DA00,A0
        DC.W    $227C,$2401,$AC88   ; $00DF2A MOVEA.L #$2401AC88,A1
        DC.W    $303C,$0038         ; $00DF30 MOVE.W  #$0038,D0
        DC.W    $323C,$0010         ; $00DF34 MOVE.W  #$0010,D1
        DC.W    $6100,$0420         ; $00DF38 BSR.W  $00E35A
        DC.W    $33FC,$0018,$00FF,$0008; $00DF3C MOVE.W  #$0018,$00FF0008
        DC.W    $0C78,$0001,$A02C   ; $00DF44 CMPI.W  #$0001,$A02C.W
        DC.W    $6700,$0070         ; $00DF4A BEQ.W  loc_00DFBC
        DC.W    $0C78,$0002,$A02C   ; $00DF4E CMPI.W  #$0002,$A02C.W
        DC.W    $6700,$0076         ; $00DF54 BEQ.W  loc_00DFCC
        DC.W    $3238,$C86C         ; $00DF58 MOVE.W  $C86C.W,D1
        DC.W    $0201,$00E0         ; $00DF5C ANDI.B  #$00E0,D1
        DC.W    $6632               ; $00DF60 BNE.S  loc_00DF94
        DC.W    $0C38,$0002,$A024   ; $00DF62 CMPI.B  #$0002,$A024.W
        DC.W    $6600,$0014         ; $00DF68 BNE.W  loc_00DF7E
        DC.W    $3238,$C86E         ; $00DF6C MOVE.W  $C86E.W,D1
        DC.W    $3401               ; $00DF70 MOVE.W  D1,D2
        DC.W    $0202,$00E0         ; $00DF72 ANDI.B  #$00E0,D2
        DC.W    $661C               ; $00DF76 BNE.S  loc_00DF94
        DC.W    $0201,$0010         ; $00DF78 ANDI.B  #$0010,D1
        DC.W    $6612               ; $00DF7C BNE.S  loc_00DF90
loc_00DF7E:
        DC.W    $3238,$C86C         ; $00DF7E MOVE.W  $C86C.W,D1
        DC.W    $0201,$0010         ; $00DF82 ANDI.B  #$0010,D1
        DC.W    $6608               ; $00DF86 BNE.S  loc_00DF90
        DC.W    $5178,$C87E         ; $00DF88 SUBQ.W  #8,$C87E.W
        DC.W    $6000,$0056         ; $00DF8C BRA.W  loc_00DFE4
loc_00DF90:
        DC.W    $50F8,$A018         ; $00DF90 ST      $A018.W
loc_00DF94:
        DC.W    $11FC,$00A8,$C8A4   ; $00DF94 MOVE.B  #$00A8,$C8A4.W
        DC.W    $11FC,$0001,$C809   ; $00DF9A MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00DFA0 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $00DFA6 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00DFAC MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0002,$A02C   ; $00DFB2 MOVE.W  #$0002,$A02C.W
        DC.W    $6000,$0026         ; $00DFB8 BRA.W  loc_00DFE0
loc_00DFBC:
        DC.W    $0838,$0006,$C80E   ; $00DFBC BTST    #6,$C80E.W
        DC.W    $661C               ; $00DFC2 BNE.S  loc_00DFE0
        DC.W    $4278,$A02C         ; $00DFC4 CLR.W  $A02C.W
        DC.W    $6000,$0016         ; $00DFC8 BRA.W  loc_00DFE0
loc_00DFCC:
        DC.W    $0838,$0007,$C80E   ; $00DFCC BTST    #7,$C80E.W
        DC.W    $660C               ; $00DFD2 BNE.S  loc_00DFE0
        DC.W    $4278,$A02C         ; $00DFD4 CLR.W  $A02C.W
        DC.W    $5878,$C87E         ; $00DFD8 ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $00DFDC BRA.W  loc_00DFE4
loc_00DFE0:
        DC.W    $5178,$C87E         ; $00DFE0 SUBQ.W  #8,$C87E.W
loc_00DFE4:
        DC.W    $11FC,$0001,$C821   ; $00DFE4 MOVE.B  #$0001,$C821.W
        DC.W    $4E75               ; $00DFEA RTS
        DC.W    $4A38,$A018         ; $00DFEC TST.B  $A018.W
        DC.W    $6614               ; $00DFF0 BNE.S  loc_00E006
        DC.W    $11FC,$00F3,$C822   ; $00DFF2 MOVE.B  #$00F3,$C822.W
loc_00DFF8:
        DC.W    $4A39,$00A1,$5120   ; $00DFF8 TST.B  $00A15120
        DC.W    $66F8               ; $00DFFE BNE.S  loc_00DFF8
        DC.W    $4239,$00A1,$5123   ; $00E000 CLR.B  $00A15123
loc_00E006:
        DC.W    $5878,$C87E         ; $00E006 ADDQ.W  #4,$C87E.W
        DC.W    $4E75               ; $00E00A RTS
        DC.W    $4A38,$A027         ; $00E00C TST.B  $A027.W
        DC.W    $6600,$000A         ; $00E010 BNE.W  loc_00E01C
        DC.W    $11F8,$A019,$A025   ; $00E014 MOVE.B  $A019.W,$A025.W
        DC.W    $6006               ; $00E01A BRA.S  loc_00E022
loc_00E01C:
        DC.W    $11F8,$A019,$A026   ; $00E01C MOVE.B  $A019.W,$A026.W
loc_00E022:
        DC.W    $4A38,$A024         ; $00E022 TST.B  $A024.W
        DC.W    $6718               ; $00E026 BEQ.S  loc_00E040
        DC.W    $0C38,$0001,$A024   ; $00E028 CMPI.B  #$0001,$A024.W
        DC.W    $672A               ; $00E02E BEQ.S  loc_00E05A
        DC.W    $11F8,$A025,$FEAB   ; $00E030 MOVE.B  $A025.W,$FEAB.W
        DC.W    $11F8,$A026,$FEAC   ; $00E036 MOVE.B  $A026.W,$FEAC.W
        DC.W    $6000,$0028         ; $00E03C BRA.W  loc_00E066
loc_00E040:
        DC.W    $11F8,$A019,$FEA5   ; $00E040 MOVE.B  $A019.W,$FEA5.W
        DC.W    $0838,$0007,$FDA8   ; $00E046 BTST    #7,$FDA8.W
        DC.W    $6700,$0018         ; $00E04C BEQ.W  loc_00E066
        DC.W    $11F8,$A019,$FEA6   ; $00E050 MOVE.B  $A019.W,$FEA6.W
        DC.W    $6000,$000E         ; $00E056 BRA.W  loc_00E066
loc_00E05A:
        DC.W    $11F8,$A025,$FEA7   ; $00E05A MOVE.B  $A025.W,$FEA7.W
        DC.W    $11F8,$A026,$FEA8   ; $00E060 MOVE.B  $A026.W,$FEA8.W
loc_00E066:
        DC.W    $31FC,$0000,$C87E   ; $00E066 MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0088,$E5CE,$00FF,$0002; $00E06C MOVE.L  #$0088E5CE,$00FF0002
        DC.W    $0C38,$0001,$A024   ; $00E076 CMPI.B  #$0001,$A024.W
        DC.W    $671C               ; $00E07C BEQ.S  loc_00E09A
        DC.W    $0C38,$0002,$A024   ; $00E07E CMPI.B  #$0002,$A024.W
        DC.W    $6720               ; $00E084 BEQ.S  loc_00E0A6
        DC.W    $0838,$0007,$FDA8   ; $00E086 BTST    #7,$FDA8.W
        DC.W    $6722               ; $00E08C BEQ.S  loc_00E0B0
        DC.W    $23FC,$0088,$E5E6,$00FF,$0002; $00E08E MOVE.L  #$0088E5E6,$00FF0002
        DC.W    $6016               ; $00E098 BRA.S  loc_00E0B0
loc_00E09A:
        DC.W    $23FC,$0088,$E5FE,$00FF,$0002; $00E09A MOVE.L  #$0088E5FE,$00FF0002
        DC.W    $600A               ; $00E0A4 BRA.S  loc_00E0B0
loc_00E0A6:
        DC.W    $23FC,$0088,$F13C,$00FF,$0002; $00E0A6 MOVE.L  #$0088F13C,$00FF0002
loc_00E0B0:
        DC.W    $4A38,$A018         ; $00E0B0 TST.B  $A018.W
        DC.W    $6660               ; $00E0B4 BNE.S  loc_00E116
        DC.W    $23FC,$0088,$4D98,$00FF,$0002; $00E0B6 MOVE.L  #$00884D98,$00FF0002
        DC.W    $0C38,$0001,$A024   ; $00E0C0 CMPI.B  #$0001,$A024.W
        DC.W    $6700,$001A         ; $00E0C6 BEQ.W  loc_00E0E2
        DC.W    $0C38,$0002,$A024   ; $00E0CA CMPI.B  #$0002,$A024.W
        DC.W    $6700,$002A         ; $00E0D0 BEQ.W  loc_00E0FC
        DC.W    $23FC,$0088,$4A3E,$00FF,$0002; $00E0D4 MOVE.L  #$00884A3E,$00FF0002
        DC.W    $6000,$0036         ; $00E0DE BRA.W  loc_00E116
loc_00E0E2:
        DC.W    $08F8,$0005,$C80E   ; $00E0E2 BSET    #5,$C80E.W
        DC.W    $08B8,$0004,$C80E   ; $00E0E8 BCLR    #4,$C80E.W
        DC.W    $23FC,$0088,$5100,$00FF,$0002; $00E0EE MOVE.L  #$00885100,$00FF0002
        DC.W    $6000,$001C         ; $00E0F8 BRA.W  loc_00E116
loc_00E0FC:
        DC.W    $08F8,$0004,$C80E   ; $00E0FC BSET    #4,$C80E.W
        DC.W    $08B8,$0005,$C80E   ; $00E102 BCLR    #5,$C80E.W
        DC.W    $23FC,$0088,$4D98,$00FF,$0002; $00E108 MOVE.L  #$00884D98,$00FF0002
        DC.W    $6000,$0002         ; $00E112 BRA.W  loc_00E116
loc_00E116:
        DC.W    $4E75               ; $00E116 RTS
loc_00E118:
        DC.W    $7000               ; $00E118 MOVEQ   #$00,D0
        DC.W    $4A38,$A027         ; $00E11A TST.B  $A027.W
        DC.W    $6606               ; $00E11E BNE.S  loc_00E126
        DC.W    $1038,$A019         ; $00E120 MOVE.B  $A019.W,D0
        DC.W    $6004               ; $00E124 BRA.S  loc_00E12A
loc_00E126:
        DC.W    $1038,$A025         ; $00E126 MOVE.B  $A025.W,D0
loc_00E12A:
        DC.W    $43F9,$0088,$E19E   ; $00E12A LEA     $0088E19E,A1
        DC.W    $D040               ; $00E130 ADD.W  D0,D0
        DC.W    $3200               ; $00E132 MOVE.W  D0,D1
        DC.W    $D040               ; $00E134 ADD.W  D0,D0
        DC.W    $D041               ; $00E136 ADD.W  D1,D0
        DC.W    $2071,$0000         ; $00E138 MOVEA.L $00(A1,D0.W),A0
        DC.W    $3031,$0004         ; $00E13C MOVE.W  $04(A1,D0.W),D0
        DC.W    $323C,$0030         ; $00E140 MOVE.W  #$0030,D1
        DC.W    $343C,$0010         ; $00E144 MOVE.W  #$0010,D2
        DC.W    $4EBA,$026A         ; $00E148 JSR     $00E3B4(PC)
        DC.W    $7000               ; $00E14C MOVEQ   #$00,D0
        DC.W    $4A38,$A027         ; $00E14E TST.B  $A027.W
        DC.W    $6706               ; $00E152 BEQ.S  loc_00E15A
        DC.W    $1038,$A019         ; $00E154 MOVE.B  $A019.W,D0
        DC.W    $6004               ; $00E158 BRA.S  loc_00E15E
loc_00E15A:
        DC.W    $1038,$A026         ; $00E15A MOVE.B  $A026.W,D0
loc_00E15E:
        DC.W    $1600               ; $00E15E MOVE.B  D0,D3
        DC.W    $207C,$0401,$C010   ; $00E160 MOVEA.L #$0401C010,A0
        DC.W    $D040               ; $00E166 ADD.W  D0,D0
        DC.W    $D040               ; $00E168 ADD.W  D0,D0
        DC.W    $D040               ; $00E16A ADD.W  D0,D0
        DC.W    $3200               ; $00E16C MOVE.W  D0,D1
        DC.W    $D040               ; $00E16E ADD.W  D0,D0
        DC.W    $D040               ; $00E170 ADD.W  D0,D0
        DC.W    $D040               ; $00E172 ADD.W  D0,D0
        DC.W    $D041               ; $00E174 ADD.W  D1,D0
        DC.W    $41F0,$0000         ; $00E176 LEA     $00(A0,D0.W),A0
        DC.W    $303C,$0049         ; $00E17A MOVE.W  #$0049,D0
        DC.W    $323C,$0010         ; $00E17E MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00E182 MOVE.W  #$0010,D2
        DC.W    $4A03               ; $00E186 TST.B  D3
        DC.W    $6706               ; $00E188 BEQ.S  loc_00E190
        DC.W    $303C,$0048         ; $00E18A MOVE.W  #$0048,D0
        DC.W    $5388               ; $00E18E SUBQ.L  #1,A0
loc_00E190:
        DC.W    $4A39,$00A1,$5120   ; $00E190 TST.B  $00A15120
        DC.W    $66F8               ; $00E196 BNE.S  loc_00E190
        DC.W    $4EBA,$021A         ; $00E198 JSR     $00E3B4(PC)
        DC.W    $4E75               ; $00E19C RTS
        DC.W    $0401,$4010         ; $00E19E SUBI.B  #$4010,D1
        DC.W    $003A,$0401,$4049   ; $00E1A2 ORI.B  #$0401,$4049(PC)
        DC.W    $003B,$0401,$4083   ; $00E1A8 ORI.B  #$0401,-$7D(PC,D4.W)
        DC.W    $003A,$0401,$40BC   ; $00E1AE ORI.B  #$0401,$40BC(PC)
        DC.W    $003A,$0401,$40F5   ; $00E1B4 ORI.B  #$0401,$40F5(PC)
        DC.W    $003B,$3ABC,$8F02   ; $00E1BA ORI.B  #$3ABC,$02(PC,A0.L)
        DC.W    $2ABC,$4000,$0003   ; $00E1C0 MOVE.L  #$40000003,(A5)
        DC.W    $4240               ; $00E1C6 CLR.W  D0
        DC.W    $761B               ; $00E1C8 MOVEQ   #$1B,D3
        DC.W    $3200               ; $00E1CA MOVE.W  D0,D1
        DC.W    $E749               ; $00E1CC LSL.W  #3,D1
        DC.W    $41F9,$0088,$E20C   ; $00E1CE LEA     $0088E20C,A0
        DC.W    $41F0,$1000         ; $00E1D4 LEA     $00(A0,D1.W),A0
        DC.W    $383C,$0005         ; $00E1D8 MOVE.W  #$0005,D4
loc_00E1DC:
        DC.W    $3A3C,$0007         ; $00E1DC MOVE.W  #$0007,D5
loc_00E1E0:
        DC.W    $7C00               ; $00E1E0 MOVEQ   #$00,D6
        DC.W    $1C30,$5000         ; $00E1E2 MOVE.B  $00(A0,D5.W),D6
        DC.W    $0646,$02F0         ; $00E1E6 ADDI.W  #$02F0,D6
        DC.W    $3C86               ; $00E1EA MOVE.W  D6,(A6)
        DC.W    $51CD,$FFF2         ; $00E1EC DBRA    D5,loc_00E1E0
        DC.W    $51CC,$FFEA         ; $00E1F0 DBRA    D4,loc_00E1DC
        DC.W    $383C,$004F         ; $00E1F4 MOVE.W  #$004F,D4
loc_00E1F8:
        DC.W    $3CBC,$0000         ; $00E1F8 MOVE.W  #$0000,(A6)
        DC.W    $51CC,$FFFA         ; $00E1FC DBRA    D4,loc_00E1F8
