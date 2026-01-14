; Generated assembly for $002200-$0027F8
; Branch targets: 49
; Labels: 46
; Format: DC.W with decoded mnemonics as comments

        org     $002200

        DC.W    $5238,$C828         ; $002200 ADDQ.B  #1,$C828.W
        DC.W    $08F8,$0001,$C80B   ; $002204 BSET    #1,$C80B.W
        DC.W    $4E75               ; $00220A RTS
        DC.W    $3038,$9F74         ; $00220C MOVE.W  $9F74.W,D0
        DC.W    $1238,$9FE5         ; $002210 MOVE.B  $9FE5.W,D1
        DC.W    $47F8,$8759         ; $002214 LEA     $8759.W,A3
        DC.W    $45F8,$8517         ; $002218 LEA     $8517.W,A2
        DC.W    $43F8,$8760         ; $00221C LEA     $8760.W,A1
        DC.W    $6114               ; $002220 BSR.S  loc_002236
        DC.W    $3038,$9074         ; $002222 MOVE.W  $9074.W,D0
        DC.W    $1238,$90E5         ; $002226 MOVE.B  $90E5.W,D1
        DC.W    $47F8,$8789         ; $00222A LEA     $8789.W,A3
        DC.W    $45F8,$8516         ; $00222E LEA     $8516.W,A2
        DC.W    $43F8,$8790         ; $002232 LEA     $8790.W,A1
loc_002236:
        DC.W    $0801,$0004         ; $002236 BTST    #4,D1
        DC.W    $6710               ; $00223A BEQ.S  loc_00224C
        DC.W    $1238,$C827         ; $00223C MOVE.B  $C827.W,D1
        DC.W    $B213               ; $002240 CMP.B  (A3),D1
        DC.W    $6716               ; $002242 BEQ.S  loc_00225A
        DC.W    $1681               ; $002244 MOVE.B  D1,(A3)
        DC.W    $14BC,$0001         ; $002246 MOVE.B  #$0001,(A2)
        DC.W    $600E               ; $00224A BRA.S  loc_00225A
loc_00224C:
        DC.W    $1238,$C828         ; $00224C MOVE.B  $C828.W,D1
        DC.W    $B213               ; $002250 CMP.B  (A3),D1
        DC.W    $6706               ; $002252 BEQ.S  loc_00225A
        DC.W    $1681               ; $002254 MOVE.B  D1,(A3)
        DC.W    $14BC,$0001         ; $002256 MOVE.B  #$0001,(A2)
loc_00225A:
        DC.W    $0C78,$0000,$C8C8   ; $00225A CMPI.W  #$0000,$C8C8.W
        DC.W    $6748               ; $002260 BEQ.S  loc_0022AA
        DC.W    $0C78,$0002,$C8C8   ; $002262 CMPI.W  #$0002,$C8C8.W
        DC.W    $6700,$0082         ; $002268 BEQ.W  loc_0022EC
        DC.W    $EA48               ; $00226C LSR.W  #5,D0
        DC.W    $3200               ; $00226E MOVE.W  D0,D1
        DC.W    $E448               ; $002270 LSR.W  #2,D0
        DC.W    $D240               ; $002272 ADD.W  D0,D1
        DC.W    $E248               ; $002274 LSR.W  #1,D0
        DC.W    $D240               ; $002276 ADD.W  D0,D1
        DC.W    $0641,$1A5E         ; $002278 ADDI.W  #$1A5E,D1
        DC.W    $D251               ; $00227C ADD.W  (A1),D1
        DC.W    $E249               ; $00227E LSR.W  #1,D1
        DC.W    $0C41,$1E00         ; $002280 CMPI.W  #$1E00,D1
        DC.W    $6E0E               ; $002284 BGT.S  loc_002294
        DC.W    $0C41,$1A5E         ; $002286 CMPI.W  #$1A5E,D1
        DC.W    $6E0C               ; $00228A BGT.S  loc_002298
        DC.W    $323C,$1A5E         ; $00228C MOVE.W  #$1A5E,D1
        DC.W    $3281               ; $002290 MOVE.W  D1,(A1)
        DC.W    $4E75               ; $002292 RTS
loc_002294:
        DC.W    $323C,$1E00         ; $002294 MOVE.W  #$1E00,D1
loc_002298:
        DC.W    $B251               ; $002298 CMP.W  (A1),D1
        DC.W    $660A               ; $00229A BNE.S  loc_0022A6
        DC.W    $4EBA,$26D0         ; $00229C JSR     $00496E(PC)
        DC.W    $0240,$000F         ; $0022A0 ANDI.W  #$000F,D0
        DC.W    $9240               ; $0022A4 SUB.W  D0,D1
loc_0022A6:
        DC.W    $3281               ; $0022A6 MOVE.W  D1,(A1)
        DC.W    $4E75               ; $0022A8 RTS
loc_0022AA:
        DC.W    $E848               ; $0022AA LSR.W  #4,D0
        DC.W    $3200               ; $0022AC MOVE.W  D0,D1
        DC.W    $E248               ; $0022AE LSR.W  #1,D0
        DC.W    $D240               ; $0022B0 ADD.W  D0,D1
        DC.W    $E248               ; $0022B2 LSR.W  #1,D0
        DC.W    $D240               ; $0022B4 ADD.W  D0,D1
        DC.W    $E448               ; $0022B6 LSR.W  #2,D0
        DC.W    $D240               ; $0022B8 ADD.W  D0,D1
        DC.W    $0641,$1A5E         ; $0022BA ADDI.W  #$1A5E,D1
        DC.W    $D251               ; $0022BE ADD.W  (A1),D1
        DC.W    $E249               ; $0022C0 LSR.W  #1,D1
        DC.W    $0C41,$21D0         ; $0022C2 CMPI.W  #$21D0,D1
        DC.W    $6E0E               ; $0022C6 BGT.S  loc_0022D6
        DC.W    $0C41,$1A5E         ; $0022C8 CMPI.W  #$1A5E,D1
        DC.W    $6E0C               ; $0022CC BGT.S  loc_0022DA
        DC.W    $323C,$1A5E         ; $0022CE MOVE.W  #$1A5E,D1
        DC.W    $3281               ; $0022D2 MOVE.W  D1,(A1)
        DC.W    $4E75               ; $0022D4 RTS
loc_0022D6:
        DC.W    $323C,$21D0         ; $0022D6 MOVE.W  #$21D0,D1
loc_0022DA:
        DC.W    $B251               ; $0022DA CMP.W  (A1),D1
        DC.W    $660A               ; $0022DC BNE.S  loc_0022E8
        DC.W    $4EBA,$268E         ; $0022DE JSR     $00496E(PC)
        DC.W    $0240,$000F         ; $0022E2 ANDI.W  #$000F,D0
        DC.W    $9240               ; $0022E6 SUB.W  D0,D1
loc_0022E8:
        DC.W    $3281               ; $0022E8 MOVE.W  D1,(A1)
        DC.W    $4E75               ; $0022EA RTS
loc_0022EC:
        DC.W    $E848               ; $0022EC LSR.W  #4,D0
        DC.W    $3200               ; $0022EE MOVE.W  D0,D1
        DC.W    $E248               ; $0022F0 LSR.W  #1,D0
        DC.W    $D240               ; $0022F2 ADD.W  D0,D1
        DC.W    $E248               ; $0022F4 LSR.W  #1,D0
        DC.W    $D240               ; $0022F6 ADD.W  D0,D1
        DC.W    $0641,$1A5E         ; $0022F8 ADDI.W  #$1A5E,D1
        DC.W    $D251               ; $0022FC ADD.W  (A1),D1
        DC.W    $E249               ; $0022FE LSR.W  #1,D1
        DC.W    $0C41,$21A0         ; $002300 CMPI.W  #$21A0,D1
        DC.W    $6E0E               ; $002304 BGT.S  loc_002314
        DC.W    $0C41,$1A5E         ; $002306 CMPI.W  #$1A5E,D1
        DC.W    $6E0C               ; $00230A BGT.S  loc_002318
        DC.W    $323C,$1A5E         ; $00230C MOVE.W  #$1A5E,D1
        DC.W    $3281               ; $002310 MOVE.W  D1,(A1)
        DC.W    $4E75               ; $002312 RTS
loc_002314:
        DC.W    $323C,$21A0         ; $002314 MOVE.W  #$21A0,D1
loc_002318:
        DC.W    $B251               ; $002318 CMP.W  (A1),D1
        DC.W    $660A               ; $00231A BNE.S  loc_002326
        DC.W    $4EBA,$2650         ; $00231C JSR     $00496E(PC)
        DC.W    $0240,$000F         ; $002320 ANDI.W  #$000F,D0
        DC.W    $9240               ; $002324 SUB.W  D0,D1
loc_002326:
        DC.W    $3281               ; $002326 MOVE.W  D1,(A1)
        DC.W    $4E75               ; $002328 RTS
        DC.W    $AFAD,$AE00,$3038   ; $00232A MOVE.L  -$5200(A5),$38(A7,D3.W)
        DC.W    $9074,$43F8         ; $002330 SUB.W  -$08(A4,D4.W),D0
        DC.W    $8790               ; $002334 OR.L   D3,(A0)
        DC.W    $0838,$0004,$90E5   ; $002336 BTST    #4,$90E5.W
        DC.W    $671A               ; $00233C BEQ.S  loc_002358
        DC.W    $0C38,$0001,$C823   ; $00233E CMPI.B  #$0001,$C823.W
        DC.W    $6724               ; $002344 BEQ.S  loc_00236A
        DC.W    $11FC,$0001,$C823   ; $002346 MOVE.B  #$0001,$C823.W
        DC.W    $3038,$C8C8         ; $00234C MOVE.W  $C8C8.W,D0
        DC.W    $11FB,$00D8,$C8A5   ; $002350 MOVE.B  -$28(PC,D0.W),$C8A5.W
        DC.W    $6012               ; $002356 BRA.S  loc_00236A
loc_002358:
        DC.W    $4A38,$C823         ; $002358 TST.B  $C823.W
        DC.W    $670C               ; $00235C BEQ.S  loc_00236A
        DC.W    $11FC,$0000,$C823   ; $00235E MOVE.B  #$0000,$C823.W
        DC.W    $11FC,$00AB,$C8A5   ; $002364 MOVE.B  #$00AB,$C8A5.W
loc_00236A:
        DC.W    $0838,$0001,$C80B   ; $00236A BTST    #1,$C80B.W
        DC.W    $6712               ; $002370 BEQ.S  loc_002384
        DC.W    $11F8,$C828,$8789   ; $002372 MOVE.B  $C828.W,$8789.W
        DC.W    $11FC,$0001,$8516   ; $002378 MOVE.B  #$0001,$8516.W
        DC.W    $08B8,$0001,$C80B   ; $00237E BCLR    #1,$C80B.W
loc_002384:
        DC.W    $0C78,$0000,$C8C8   ; $002384 CMPI.W  #$0000,$C8C8.W
        DC.W    $6750               ; $00238A BEQ.S  loc_0023DC
        DC.W    $0C78,$0002,$C8C8   ; $00238C CMPI.W  #$0002,$C8C8.W
        DC.W    $6700,$0092         ; $002392 BEQ.W  loc_002426
        DC.W    $EA48               ; $002396 LSR.W  #5,D0
        DC.W    $3200               ; $002398 MOVE.W  D0,D1
        DC.W    $E448               ; $00239A LSR.W  #2,D0
        DC.W    $D240               ; $00239C ADD.W  D0,D1
        DC.W    $E248               ; $00239E LSR.W  #1,D0
        DC.W    $D240               ; $0023A0 ADD.W  D0,D1
        DC.W    $0641,$1A5E         ; $0023A2 ADDI.W  #$1A5E,D1
        DC.W    $D251               ; $0023A6 ADD.W  (A1),D1
        DC.W    $E249               ; $0023A8 LSR.W  #1,D1
        DC.W    $0C41,$1E00         ; $0023AA CMPI.W  #$1E00,D1
        DC.W    $6E12               ; $0023AE BGT.S  loc_0023C2
        DC.W    $0C41,$1A5E         ; $0023B0 CMPI.W  #$1A5E,D1
        DC.W    $6E10               ; $0023B4 BGT.S  loc_0023C6
        DC.W    $323C,$1A5E         ; $0023B6 MOVE.W  #$1A5E,D1
        DC.W    $3281               ; $0023BA MOVE.W  D1,(A1)
        DC.W    $31D1,$8760         ; $0023BC MOVE.W  (A1),$8760.W
        DC.W    $4E75               ; $0023C0 RTS
loc_0023C2:
        DC.W    $323C,$1E00         ; $0023C2 MOVE.W  #$1E00,D1
loc_0023C6:
        DC.W    $B251               ; $0023C6 CMP.W  (A1),D1
        DC.W    $660A               ; $0023C8 BNE.S  loc_0023D4
        DC.W    $4EBA,$25A2         ; $0023CA JSR     $00496E(PC)
        DC.W    $0240,$000F         ; $0023CE ANDI.W  #$000F,D0
        DC.W    $9240               ; $0023D2 SUB.W  D0,D1
loc_0023D4:
        DC.W    $3281               ; $0023D4 MOVE.W  D1,(A1)
        DC.W    $31D1,$8760         ; $0023D6 MOVE.W  (A1),$8760.W
        DC.W    $4E75               ; $0023DA RTS
loc_0023DC:
        DC.W    $E848               ; $0023DC LSR.W  #4,D0
        DC.W    $3200               ; $0023DE MOVE.W  D0,D1
        DC.W    $E248               ; $0023E0 LSR.W  #1,D0
        DC.W    $D240               ; $0023E2 ADD.W  D0,D1
        DC.W    $E248               ; $0023E4 LSR.W  #1,D0
        DC.W    $D240               ; $0023E6 ADD.W  D0,D1
        DC.W    $E448               ; $0023E8 LSR.W  #2,D0
        DC.W    $D240               ; $0023EA ADD.W  D0,D1
        DC.W    $0641,$1A5E         ; $0023EC ADDI.W  #$1A5E,D1
        DC.W    $D251               ; $0023F0 ADD.W  (A1),D1
        DC.W    $E249               ; $0023F2 LSR.W  #1,D1
        DC.W    $0C41,$21D0         ; $0023F4 CMPI.W  #$21D0,D1
        DC.W    $6E12               ; $0023F8 BGT.S  loc_00240C
        DC.W    $0C41,$1A5E         ; $0023FA CMPI.W  #$1A5E,D1
        DC.W    $6E10               ; $0023FE BGT.S  loc_002410
        DC.W    $323C,$1A5E         ; $002400 MOVE.W  #$1A5E,D1
        DC.W    $3281               ; $002404 MOVE.W  D1,(A1)
        DC.W    $31D1,$8760         ; $002406 MOVE.W  (A1),$8760.W
        DC.W    $4E75               ; $00240A RTS
loc_00240C:
        DC.W    $323C,$21D0         ; $00240C MOVE.W  #$21D0,D1
loc_002410:
        DC.W    $B251               ; $002410 CMP.W  (A1),D1
        DC.W    $660A               ; $002412 BNE.S  loc_00241E
        DC.W    $4EBA,$2558         ; $002414 JSR     $00496E(PC)
        DC.W    $0240,$000F         ; $002418 ANDI.W  #$000F,D0
        DC.W    $9240               ; $00241C SUB.W  D0,D1
loc_00241E:
        DC.W    $3281               ; $00241E MOVE.W  D1,(A1)
        DC.W    $31D1,$8760         ; $002420 MOVE.W  (A1),$8760.W
        DC.W    $4E75               ; $002424 RTS
loc_002426:
        DC.W    $E848               ; $002426 LSR.W  #4,D0
        DC.W    $3200               ; $002428 MOVE.W  D0,D1
        DC.W    $E248               ; $00242A LSR.W  #1,D0
        DC.W    $D240               ; $00242C ADD.W  D0,D1
        DC.W    $E248               ; $00242E LSR.W  #1,D0
        DC.W    $D240               ; $002430 ADD.W  D0,D1
        DC.W    $0641,$1A5E         ; $002432 ADDI.W  #$1A5E,D1
        DC.W    $D251               ; $002436 ADD.W  (A1),D1
        DC.W    $E249               ; $002438 LSR.W  #1,D1
        DC.W    $0C41,$21A0         ; $00243A CMPI.W  #$21A0,D1
        DC.W    $6E12               ; $00243E BGT.S  loc_002452
        DC.W    $0C41,$1A5E         ; $002440 CMPI.W  #$1A5E,D1
        DC.W    $6E10               ; $002444 BGT.S  loc_002456
        DC.W    $323C,$1A5E         ; $002446 MOVE.W  #$1A5E,D1
        DC.W    $3281               ; $00244A MOVE.W  D1,(A1)
        DC.W    $31D1,$8760         ; $00244C MOVE.W  (A1),$8760.W
        DC.W    $4E75               ; $002450 RTS
loc_002452:
        DC.W    $323C,$21A0         ; $002452 MOVE.W  #$21A0,D1
loc_002456:
        DC.W    $B251               ; $002456 CMP.W  (A1),D1
        DC.W    $660A               ; $002458 BNE.S  loc_002464
        DC.W    $4EBA,$2512         ; $00245A JSR     $00496E(PC)
        DC.W    $0240,$000F         ; $00245E ANDI.W  #$000F,D0
        DC.W    $9240               ; $002462 SUB.W  D0,D1
loc_002464:
        DC.W    $3281               ; $002464 MOVE.W  D1,(A1)
        DC.W    $31D1,$8760         ; $002466 MOVE.W  (A1),$8760.W
        DC.W    $4E75               ; $00246A RTS
        DC.W    $11FC,$0001,$8507   ; $00246C MOVE.B  #$0001,$8507.W
        DC.W    $4E75               ; $002472 RTS
        DC.W    $11FC,$0080,$8507   ; $002474 MOVE.B  #$0080,$8507.W
        DC.W    $4E75               ; $00247A RTS
loc_00247C:
        DC.W    $3C3C,$E001         ; $00247C MOVE.W  #$E001,D6
        DC.W    $7000               ; $002480 MOVEQ   #$00,D0
        DC.W    $7200               ; $002482 MOVEQ   #$00,D1
        DC.W    $1018               ; $002484 MOVE.B  (A0)+,D0
        DC.W    $1200               ; $002486 MOVE.B  D0,D1
        DC.W    $E808               ; $002488 LSR.B  #4,D0
        DC.W    $0201,$000F         ; $00248A ANDI.B  #$000F,D1
        DC.W    $D046               ; $00248E ADD.W  D6,D0
        DC.W    $D246               ; $002490 ADD.W  D6,D1
        DC.W    $3C80               ; $002492 MOVE.W  D0,(A6)
        DC.W    $3C81               ; $002494 MOVE.W  D1,(A6)
        DC.W    $7000               ; $002496 MOVEQ   #$00,D0
        DC.W    $7200               ; $002498 MOVEQ   #$00,D1
        DC.W    $1018               ; $00249A MOVE.B  (A0)+,D0
        DC.W    $1200               ; $00249C MOVE.B  D0,D1
        DC.W    $E808               ; $00249E LSR.B  #4,D0
        DC.W    $0201,$000F         ; $0024A0 ANDI.B  #$000F,D1
        DC.W    $D046               ; $0024A4 ADD.W  D6,D0
        DC.W    $D246               ; $0024A6 ADD.W  D6,D1
        DC.W    $3C80               ; $0024A8 MOVE.W  D0,(A6)
        DC.W    $3C81               ; $0024AA MOVE.W  D1,(A6)
        DC.W    $4E75               ; $0024AC RTS
loc_0024AE:
        DC.W    $3C3C,$E001         ; $0024AE MOVE.W  #$E001,D6
        DC.W    $7000               ; $0024B2 MOVEQ   #$00,D0
        DC.W    $7200               ; $0024B4 MOVEQ   #$00,D1
        DC.W    $1018               ; $0024B6 MOVE.B  (A0)+,D0
        DC.W    $1200               ; $0024B8 MOVE.B  D0,D1
        DC.W    $E808               ; $0024BA LSR.B  #4,D0
        DC.W    $0201,$000F         ; $0024BC ANDI.B  #$000F,D1
        DC.W    $D046               ; $0024C0 ADD.W  D6,D0
        DC.W    $D246               ; $0024C2 ADD.W  D6,D1
        DC.W    $3C80               ; $0024C4 MOVE.W  D0,(A6)
        DC.W    $3C81               ; $0024C6 MOVE.W  D1,(A6)
        DC.W    $4E75               ; $0024C8 RTS
        DC.W    $4A38,$C80D         ; $0024CA TST.B  $C80D.W
        DC.W    $6600,$00C2         ; $0024CE BNE.W  loc_002592
        DC.W    $31FC,$0000,$8000   ; $0024D2 MOVE.W  #$0000,$8000.W
        DC.W    $31FC,$FFF8,$C880   ; $0024D8 MOVE.W  #$FFF8,$C880.W
        DC.W    $41F9,$00FF,$6116   ; $0024DE LEA     $00FF6116,A0
        DC.W    $2ABC,$6202,$0002   ; $0024E4 MOVE.L  #$62020002,(A5)
        DC.W    $4EBA,$FF90         ; $0024EA JSR     loc_00247C(PC)
        DC.W    $41F8,$9032         ; $0024EE LEA     $9032.W,A0
        DC.W    $2ABC,$620C,$0002   ; $0024F2 MOVE.L  #$620C0002,(A5)
        DC.W    $4EBA,$FF82         ; $0024F8 JSR     loc_00247C(PC)
        DC.W    $41F9,$00FF,$611A   ; $0024FC LEA     $00FF611A,A0
        DC.W    $2ABC,$6216,$0002   ; $002502 MOVE.L  #$62160002,(A5)
        DC.W    $4EBA,$FF72         ; $002508 JSR     loc_00247C(PC)
        DC.W    $41F9,$00FF,$6108   ; $00250C LEA     $00FF6108,A0
        DC.W    $2ABC,$6302,$0002   ; $002512 MOVE.L  #$63020002,(A5)
        DC.W    $4EBA,$FF62         ; $002518 JSR     loc_00247C(PC)
        DC.W    $41F9,$00FF,$610A   ; $00251C LEA     $00FF610A,A0
        DC.W    $2ABC,$630C,$0002   ; $002522 MOVE.L  #$630C0002,(A5)
        DC.W    $4EBA,$FF52         ; $002528 JSR     loc_00247C(PC)
        DC.W    $41F9,$00FF,$610C   ; $00252C LEA     $00FF610C,A0
        DC.W    $2ABC,$6316,$0002   ; $002532 MOVE.L  #$63160002,(A5)
        DC.W    $4EBA,$FF42         ; $002538 JSR     loc_00247C(PC)
        DC.W    $41F9,$00FF,$6104   ; $00253C LEA     $00FF6104,A0
        DC.W    $2ABC,$632A,$0002   ; $002542 MOVE.L  #$632A0002,(A5)
        DC.W    $4EBA,$FF32         ; $002548 JSR     loc_00247C(PC)
        DC.W    $41F9,$00FF,$6106   ; $00254C LEA     $00FF6106,A0
        DC.W    $2ABC,$6334,$0002   ; $002552 MOVE.L  #$63340002,(A5)
        DC.W    $4EBA,$FF22         ; $002558 JSR     loc_00247C(PC)
        DC.W    $41F9,$00FF,$5FF8   ; $00255C LEA     $00FF5FF8,A0
        DC.W    $2ABC,$640C,$0002   ; $002562 MOVE.L  #$640C0002,(A5)
        DC.W    $4EBA,$FF12         ; $002568 JSR     loc_00247C(PC)
        DC.W    $2ABC,$6416,$0002   ; $00256C MOVE.L  #$64160002,(A5)
        DC.W    $4EBA,$FF08         ; $002572 JSR     loc_00247C(PC)
        DC.W    $2ABC,$6420,$0002   ; $002576 MOVE.L  #$64200002,(A5)
        DC.W    $4EBA,$FEFE         ; $00257C JSR     loc_00247C(PC)
        DC.W    $2ABC,$642A,$0002   ; $002580 MOVE.L  #$642A0002,(A5)
        DC.W    $4EBA,$FEF4         ; $002586 JSR     loc_00247C(PC)
        DC.W    $13FC,$0000,$00FF,$5FFF; $00258A MOVE.B  #$0000,$00FF5FFF
loc_002592:
        DC.W    $4E75               ; $002592 RTS
        DC.W    $4A38,$C80D         ; $002594 TST.B  $C80D.W
        DC.W    $6614               ; $002598 BNE.S  loc_0025AE
        DC.W    $41F8,$C886         ; $00259A LEA     $C886.W,A0
        DC.W    $2ABC,$622A,$0002   ; $00259E MOVE.L  #$622A0002,(A5)
        DC.W    $4EBA,$FF08         ; $0025A4 JSR     loc_0024AE(PC)
        DC.W    $11FC,$0000,$C886   ; $0025A8 MOVE.B  #$0000,$C886.W
loc_0025AE:
        DC.W    $4E75               ; $0025AE RTS
        DC.W    $4A38,$C80D         ; $0025B0 TST.B  $C80D.W
        DC.W    $6600,$0086         ; $0025B4 BNE.W  loc_00263C
        DC.W    $41F8,$C888         ; $0025B8 LEA     $C888.W,A0
        DC.W    $2ABC,$6502,$0002   ; $0025BC MOVE.L  #$65020002,(A5)
        DC.W    $4EBA,$FEB8         ; $0025C2 JSR     loc_00247C(PC)
        DC.W    $4EBA,$FEB4         ; $0025C6 JSR     loc_00247C(PC)
        DC.W    $2078,$C888         ; $0025CA MOVEA.L $C888.W,A0
        DC.W    $2ABC,$6514,$0002   ; $0025CE MOVE.L  #$65140002,(A5)
        DC.W    $4EBA,$FEA6         ; $0025D4 JSR     loc_00247C(PC)
        DC.W    $2ABC,$651E,$0002   ; $0025D8 MOVE.L  #$651E0002,(A5)
        DC.W    $4EBA,$FE9C         ; $0025DE JSR     loc_00247C(PC)
        DC.W    $2ABC,$6528,$0002   ; $0025E2 MOVE.L  #$65280002,(A5)
        DC.W    $4EBA,$FE92         ; $0025E8 JSR     loc_00247C(PC)
        DC.W    $2ABC,$6532,$0002   ; $0025EC MOVE.L  #$65320002,(A5)
        DC.W    $4EBA,$FE88         ; $0025F2 JSR     loc_00247C(PC)
        DC.W    $50B8,$C888         ; $0025F6 ADDQ.L  #8,$C888.W
        DC.W    $41F8,$C888         ; $0025FA LEA     $C888.W,A0
        DC.W    $2ABC,$6602,$0002   ; $0025FE MOVE.L  #$66020002,(A5)
        DC.W    $4EBA,$FE76         ; $002604 JSR     loc_00247C(PC)
        DC.W    $4EBA,$FE72         ; $002608 JSR     loc_00247C(PC)
        DC.W    $2078,$C888         ; $00260C MOVEA.L $C888.W,A0
        DC.W    $2ABC,$6614,$0002   ; $002610 MOVE.L  #$66140002,(A5)
        DC.W    $4EBA,$FE64         ; $002616 JSR     loc_00247C(PC)
        DC.W    $2ABC,$661E,$0002   ; $00261A MOVE.L  #$661E0002,(A5)
        DC.W    $4EBA,$FE5A         ; $002620 JSR     loc_00247C(PC)
        DC.W    $2ABC,$6628,$0002   ; $002624 MOVE.L  #$66280002,(A5)
        DC.W    $4EBA,$FE50         ; $00262A JSR     loc_00247C(PC)
        DC.W    $2ABC,$6632,$0002   ; $00262E MOVE.L  #$66320002,(A5)
        DC.W    $4EBA,$FE46         ; $002634 JSR     loc_00247C(PC)
        DC.W    $51B8,$C888         ; $002638 SUBQ.L  #8,$C888.W
loc_00263C:
        DC.W    $4E75               ; $00263C RTS
        DC.W    $43FA,$0012         ; $00263E LEA     $0012(PC),A1
        DC.W    $45F9,$00A1,$5100   ; $002642 LEA     $00A15100,A2
        DC.W    $7E0C               ; $002648 MOVEQ   #$0C,D7
loc_00264A:
        DC.W    $34D9               ; $00264A MOVE.W  (A1)+,(A2)+
        DC.W    $51CF,$FFFC         ; $00264C DBRA    D7,loc_00264A
        DC.W    $4E75               ; $002650 RTS
        DC.W    $0083,$0000,$0001   ; $002652 ORI.L  #$00000001,D3
        DC.W    $0000,$0000         ; $002658 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00265C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $002660 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $002664 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $002668 ORI.B  #$0000,D0
        DC.W    $43FA,$0012         ; $00266C LEA     $0012(PC),A1
        DC.W    $45F9,$00A1,$5180   ; $002670 LEA     $00A15180,A2
        DC.W    $7E05               ; $002676 MOVEQ   #$05,D7
loc_002678:
        DC.W    $34D9               ; $002678 MOVE.W  (A1)+,(A2)+
        DC.W    $51CF,$FFFC         ; $00267A DBRA    D7,loc_002678
        DC.W    $4E75               ; $00267E RTS
        DC.W    $8000               ; $002680 OR.B   D0,D0
        DC.W    $0000,$0000         ; $002682 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $002686 ORI.B  #$0000,D0
        DC.W    $0000,$49F9         ; $00268A ORI.B  #$49F9,D0
        DC.W    $00A1,$5100,$08AC   ; $00268E ORI.L  #$510008AC,-(A1)
        DC.W    $0000,$008B         ; $002694 ORI.B  #$008B,D0
        DC.W    $4EBA,$00A8         ; $002698 JSR     loc_002742(PC)
        DC.W    $4EBA,$0120         ; $00269C JSR     loc_0027BE(PC)
        DC.W    $4EBA,$017C         ; $0026A0 JSR     $00281E(PC)
        DC.W    $08EC,$0000,$008B   ; $0026A4 BSET    #0,$008B(A4)
        DC.W    $4EBA,$0096         ; $0026AA JSR     loc_002742(PC)
        DC.W    $4EBA,$010E         ; $0026AE JSR     loc_0027BE(PC)
        DC.W    $4EBA,$016A         ; $0026B2 JSR     $00281E(PC)
        DC.W    $08AC,$0000,$008B   ; $0026B6 BCLR    #0,$008B(A4)
        DC.W    $11FC,$0000,$C80C   ; $0026BC MOVE.B  #$0000,$C80C.W
        DC.W    $7000               ; $0026C2 MOVEQ   #$00,D0
        DC.W    $4EFA,$00BC         ; $0026C4 JMP     loc_002782(PC)
        DC.W    $49F9,$00A1,$5100   ; $0026C8 LEA     $00A15100,A4
        DC.W    $08AC,$0000,$008B   ; $0026CE BCLR    #0,$008B(A4)
        DC.W    $616C               ; $0026D4 BSR.S  loc_002742
        DC.W    $4EBA,$00C8         ; $0026D6 JSR     loc_0027A0(PC)
        DC.W    $4EBA,$0142         ; $0026DA JSR     $00281E(PC)
        DC.W    $08EC,$0000,$008B   ; $0026DE BSET    #0,$008B(A4)
        DC.W    $615C               ; $0026E4 BSR.S  loc_002742
        DC.W    $4EBA,$00B8         ; $0026E6 JSR     loc_0027A0(PC)
        DC.W    $4EBA,$0132         ; $0026EA JSR     $00281E(PC)
        DC.W    $08AC,$0000,$008B   ; $0026EE BCLR    #0,$008B(A4)
        DC.W    $11FC,$0000,$C80C   ; $0026F4 MOVE.B  #$0000,$C80C.W
        DC.W    $7000               ; $0026FA MOVEQ   #$00,D0
        DC.W    $4EBA,$0084         ; $0026FC JSR     loc_002782(PC)
        DC.W    $33FC,$8000,$00A1,$5202; $002700 MOVE.W  #$8000,$00A15202
        DC.W    $4E75               ; $002708 RTS
        DC.W    $49F9,$00A1,$5100   ; $00270A LEA     $00A15100,A4
        DC.W    $6130               ; $002710 BSR.S  loc_002742
        DC.W    $4EBA,$008C         ; $002712 JSR     loc_0027A0(PC)
        DC.W    $4EBA,$00C2         ; $002716 JSR     loc_0027DA(PC)
        DC.W    $7001               ; $00271A MOVEQ   #$01,D0
        DC.W    $7400               ; $00271C MOVEQ   #$00,D2
        DC.W    $0838,$0000,$C80C   ; $00271E BTST    #0,$C80C.W
        DC.W    $6704               ; $002724 BEQ.S  loc_00272A
        DC.W    $7000               ; $002726 MOVEQ   #$00,D0
        DC.W    $7401               ; $002728 MOVEQ   #$01,D2
loc_00272A:
        DC.W    $1940,$008B         ; $00272A MOVE.B  D0,$008B(A4)
        DC.W    $6112               ; $00272E BSR.S  loc_002742
        DC.W    $616E               ; $002730 BSR.S  loc_0027A0
        DC.W    $4EBA,$00A6         ; $002732 JSR     loc_0027DA(PC)
        DC.W    $1942,$008B         ; $002736 MOVE.B  D2,$008B(A4)
        DC.W    $4E75               ; $00273A RTS
        DC.W    $49F9,$00A1,$5100   ; $00273C LEA     $00A15100,A4
loc_002742:
        DC.W    $45F9,$00A1,$5186   ; $002742 LEA     $00A15186,A2
        DC.W    $47F9,$00A1,$5188   ; $002748 LEA     $00A15188,A3
        DC.W    $022C,$0040,$0081   ; $00274E ANDI.B  #$0040,$0081(A4)
        DC.W    $3E3C,$00FF         ; $002754 MOVE.W  #$00FF,D7
        DC.W    $7000               ; $002758 MOVEQ   #$00,D0
        DC.W    $7200               ; $00275A MOVEQ   #$00,D1
        DC.W    $343C,$0100         ; $00275C MOVE.W  #$0100,D2
        DC.W    $397C,$00FF,$0084   ; $002760 MOVE.W  #$00FF,$0084(A4)
loc_002766:
        DC.W    $3481               ; $002766 MOVE.W  D1,(A2)
        DC.W    $3680               ; $002768 MOVE.W  D0,(A3)
loc_00276A:
        DC.W    $082C,$0001,$008B   ; $00276A BTST    #1,$008B(A4)
        DC.W    $66F8               ; $002770 BNE.S  loc_00276A
        DC.W    $D242               ; $002772 ADD.W  D2,D1
        DC.W    $51CF,$FFF0         ; $002774 DBRA    D7,loc_002766
        DC.W    $4E75               ; $002778 RTS
        DC.W    $0239,$0040,$00A1,$5181; $00277A ANDI.B  #$0040,$00A15181
loc_002782:
        DC.W    $45F9,$00A1,$5200   ; $002782 LEA     $00A15200,A2
        DC.W    $7E1F               ; $002788 MOVEQ   #$1F,D7
loc_00278A:
        DC.W    $24C0               ; $00278A MOVE.L  D0,(A2)+
        DC.W    $24C0               ; $00278C MOVE.L  D0,(A2)+
        DC.W    $24C0               ; $00278E MOVE.L  D0,(A2)+
        DC.W    $24C0               ; $002790 MOVE.L  D0,(A2)+
        DC.W    $51CF,$FFF6         ; $002792 DBRA    D7,loc_00278A
        DC.W    $4E75               ; $002796 RTS
        DC.W    $0239,$0040,$00A1,$5181; $002798 ANDI.B  #$0040,$00A15181
loc_0027A0:
        DC.W    $43F9,$0084,$0000   ; $0027A0 LEA     $00840000,A1
        DC.W    $343C,$1F00         ; $0027A6 MOVE.W  #$1F00,D2
        DC.W    $3E3C,$00DF         ; $0027AA MOVE.W  #$00DF,D7
loc_0027AE:
        DC.W    $32C2               ; $0027AE MOVE.W  D2,(A1)+
        DC.W    $51CF,$FFFC         ; $0027B0 DBRA    D7,loc_0027AE
        DC.W    $4E75               ; $0027B4 RTS
        DC.W    $0239,$0040,$00A1,$5181; $0027B6 ANDI.B  #$0040,$00A15181
loc_0027BE:
        DC.W    $43F9,$0084,$0000   ; $0027BE LEA     $00840000,A1
        DC.W    $303C,$0100         ; $0027C4 MOVE.W  #$0100,D0
        DC.W    $323C,$2000         ; $0027C8 MOVE.W  #$2000,D1
        DC.W    $3E3C,$00DF         ; $0027CC MOVE.W  #$00DF,D7
loc_0027D0:
        DC.W    $32C1               ; $0027D0 MOVE.W  D1,(A1)+
        DC.W    $D240               ; $0027D2 ADD.W  D0,D1
        DC.W    $51CF,$FFFA         ; $0027D4 DBRA    D7,loc_0027D0
        DC.W    $4E75               ; $0027D8 RTS
loc_0027DA:
        DC.W    $6142               ; $0027DA BSR.S  $00281E
        DC.W    $49F9,$00A1,$5100   ; $0027DC LEA     $00A15100,A4
        DC.W    $45F9,$00A1,$5186   ; $0027E2 LEA     $00A15186,A2
        DC.W    $47F9,$00A1,$5188   ; $0027E8 LEA     $00A15188,A3
        DC.W    $323C,$2000         ; $0027EE MOVE.W  #$2000,D1
        DC.W    $6104               ; $0027F2 BSR.S  $0027F8
        DC.W    $323C,$F000         ; $0027F4 MOVE.W  #$F000,D1
