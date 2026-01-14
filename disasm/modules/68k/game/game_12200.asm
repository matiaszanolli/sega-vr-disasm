; Generated assembly for $012200-$014200
; Branch targets: 243
; Labels: 221
; Format: DC.W with decoded mnemonics as comments

        org     $012200

        DC.W    $906F,$0401         ; $012200 SUB.W  $0401(A7),D0
        DC.W    $90CF               ; $012204 SUBA.W  A7,A0
        DC.W    $0401,$C010         ; $012206 SUBI.B  #$C010,D1
        DC.W    $003A,$0401,$C049   ; $01220A ORI.B  #$0401,-$3FB7(PC)
        DC.W    $003B,$0401,$C083   ; $012210 ORI.B  #$0401,-$7D(PC,A4.W)
        DC.W    $003A,$0401,$C0BC   ; $012216 ORI.B  #$0401,-$3F44(PC)
        DC.W    $003A,$0401,$C0F5   ; $01221C ORI.B  #$0401,-$3F0B(PC)
        DC.W    $003B,$4240,$4EBA   ; $012222 ORI.B  #$4240,-$46(PC,D4.L)
        DC.W    $C304               ; $012228 AND.B  D1,D4
        DC.W    $4EBA,$9458         ; $01222A JSR     $00B684(PC)
        DC.W    $4EBA,$94AA         ; $01222E JSR     $00B6DA(PC)
        DC.W    $2278,$A030         ; $012232 MOVEA.L $A030.W,A1
        DC.W    $2038,$A01E         ; $012236 MOVE.L  $A01E.W,D0
        DC.W    $2238,$A022         ; $01223A MOVE.L  $A022.W,D1
        DC.W    $7400               ; $01223E MOVEQ   #$00,D2
        DC.W    $3438,$A02C         ; $012240 MOVE.W  $A02C.W,D2
        DC.W    $6100,$02EE         ; $012244 BSR.W  loc_012534
        DC.W    $207C,$0601,$AD00   ; $012248 MOVEA.L #$0601AD00,A0
        DC.W    $227C,$0400,$8020   ; $01224E MOVEA.L #$04008020,A1
        DC.W    $303C,$0110         ; $012254 MOVE.W  #$0110,D0
        DC.W    $323C,$0010         ; $012258 MOVE.W  #$0010,D1
        DC.W    $4EBA,$C0FC         ; $01225C JSR     $00E35A(PC)
loc_012260:
        DC.W    $4A39,$00A1,$5120   ; $012260 TST.B  $00A15120
        DC.W    $66F8               ; $012266 BNE.S  loc_012260
        DC.W    $33FC,$0101,$00A1,$512C; $012268 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$A000,$00A1,$5128; $012270 MOVE.W  #$A000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $012278 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $012280 MOVE.B  #$0001,$00A15120
loc_012288:
        DC.W    $4A39,$00A1,$512C   ; $012288 TST.B  $00A1512C
        DC.W    $66F8               ; $01228E BNE.S  loc_012288
        DC.W    $33FC,$0018,$00A1,$5128; $012290 MOVE.W  #$0018,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $012298 MOVE.W  #$0101,$00A1512C
        DC.W    $207C,$0601,$8580   ; $0122A0 MOVEA.L #$06018580,A0
        DC.W    $43F9,$0403,$5018   ; $0122A6 LEA     $04035018,A1
        DC.W    $303C,$0038         ; $0122AC MOVE.W  #$0038,D0
        DC.W    $323C,$0010         ; $0122B0 MOVE.W  #$0010,D1
        DC.W    $4EBA,$C0A4         ; $0122B4 JSR     $00E35A(PC)
        DC.W    $43F9,$0403,$5060   ; $0122B8 LEA     $04035060,A1
        DC.W    $45F8,$FA48         ; $0122BE LEA     $FA48.W,A2
        DC.W    $2038,$A01E         ; $0122C2 MOVE.L  $A01E.W,D0
        DC.W    $D040               ; $0122C6 ADD.W  D0,D0
        DC.W    $D040               ; $0122C8 ADD.W  D0,D0
        DC.W    $D040               ; $0122CA ADD.W  D0,D0
        DC.W    $3200               ; $0122CC MOVE.W  D0,D1
        DC.W    $D040               ; $0122CE ADD.W  D0,D0
        DC.W    $D041               ; $0122D0 ADD.W  D1,D0
        DC.W    $D040               ; $0122D2 ADD.W  D0,D0
        DC.W    $D5C0               ; $0122D4 ADDA.L  D0,A2
        DC.W    $2038,$A022         ; $0122D6 MOVE.L  $A022.W,D0
        DC.W    $D040               ; $0122DA ADD.W  D0,D0
        DC.W    $D040               ; $0122DC ADD.W  D0,D0
        DC.W    $D040               ; $0122DE ADD.W  D0,D0
        DC.W    $D5C0               ; $0122E0 ADDA.L  D0,A2
        DC.W    $6100,$0326         ; $0122E2 BSR.W  loc_01260A
        DC.W    $D3FC,$0000,$0010   ; $0122E6 ADDA.L  #$00000010,A1
        DC.W    $1A1A               ; $0122EC MOVE.B  (A2)+,D5
        DC.W    $6100,$02AC         ; $0122EE BSR.W  loc_01259C
        DC.W    $D3FC,$0000,$0020   ; $0122F2 ADDA.L  #$00000020,A1
        DC.W    $6100,$03AC         ; $0122F8 BSR.W  loc_0126A6
        DC.W    $207C,$0603,$0000   ; $0122FC MOVEA.L #$06030000,A0
        DC.W    $43F9,$0403,$78A2   ; $012302 LEA     $040378A2,A1
        DC.W    $303C,$0088         ; $012308 MOVE.W  #$0088,D0
        DC.W    $323C,$0008         ; $01230C MOVE.W  #$0008,D1
        DC.W    $4EBA,$C048         ; $012310 JSR     $00E35A(PC)
        DC.W    $4AB8,$A026         ; $012314 TST.L  $A026.W
        DC.W    $6700,$0040         ; $012318 BEQ.W  loc_01235A
        DC.W    $2238,$A030         ; $01231C MOVE.L  $A030.W,D1
        DC.W    $2438,$A026         ; $012320 MOVE.L  $A026.W,D2
        DC.W    $D282               ; $012324 ADD.L  D2,D1
        DC.W    $21C1,$A030         ; $012326 MOVE.L  D1,$A030.W
        DC.W    $2238,$A034         ; $01232A MOVE.L  $A034.W,D1
        DC.W    $D282               ; $01232E ADD.L  D2,D1
        DC.W    $21C1,$A034         ; $012330 MOVE.L  D1,$A034.W
        DC.W    $5378,$A02A         ; $012334 SUBQ.W  #1,$A02A.W
        DC.W    $6400,$01C4         ; $012338 BCC.W  loc_0124FE
        DC.W    $4AB8,$A026         ; $01233C TST.L  $A026.W
        DC.W    $6A04               ; $012340 BPL.S  loc_012346
        DC.W    $5278,$A02C         ; $012342 ADDQ.W  #1,$A02C.W
loc_012346:
        DC.W    $42B8,$A026         ; $012346 CLR.L  $A026.W
        DC.W    $21FC,$0402,$A060,$A030; $01234A MOVE.L  #$0402A060,$A030.W
        DC.W    $21FC,$0402,$A020,$A034; $012352 MOVE.L  #$0402A020,$A034.W
loc_01235A:
        DC.W    $0C78,$0001,$A038   ; $01235A CMPI.W  #$0001,$A038.W
        DC.W    $6700,$016C         ; $012360 BEQ.W  loc_0124CE
        DC.W    $0C78,$0002,$A038   ; $012364 CMPI.W  #$0002,$A038.W
        DC.W    $6700,$0178         ; $01236A BEQ.W  loc_0124E4
        DC.W    $4EB9,$0088,$179E   ; $01236E JSR     $0088179E
        DC.W    $3238,$C86C         ; $012374 MOVE.W  $C86C.W,D1
        DC.W    $0801,$0004         ; $012378 BTST    #4,D1
        DC.W    $6702               ; $01237C BEQ.S  loc_012380
        DC.W    $6006               ; $01237E BRA.S  loc_012386
loc_012380:
        DC.W    $0801,$0007         ; $012380 BTST    #7,D1
        DC.W    $672E               ; $012384 BEQ.S  loc_0123B4
loc_012386:
        DC.W    $11FC,$00A8,$C8A4   ; $012386 MOVE.B  #$00A8,$C8A4.W
        DC.W    $31FC,$0002,$A038   ; $01238C MOVE.W  #$0002,$A038.W
        DC.W    $11FC,$0001,$C809   ; $012392 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $012398 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $01239E BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $0123A4 MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $0123AA JSR     $0088205E
        DC.W    $6000,$014C         ; $0123B0 BRA.W  loc_0124FE
loc_0123B4:
        DC.W    $0801,$0002         ; $0123B4 BTST    #2,D1
        DC.W    $672E               ; $0123B8 BEQ.S  loc_0123E8
        DC.W    $11FC,$00A9,$C8A4   ; $0123BA MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A38,$A019         ; $0123C0 TST.B  $A019.W
        DC.W    $6708               ; $0123C4 BEQ.S  loc_0123CE
        DC.W    $5338,$A019         ; $0123C6 SUBQ.B  #1,$A019.W
        DC.W    $6000,$0132         ; $0123CA BRA.W  loc_0124FE
loc_0123CE:
        DC.W    $4A38,$A01A         ; $0123CE TST.B  $A01A.W
        DC.W    $660A               ; $0123D2 BNE.S  loc_0123DE
        DC.W    $11FC,$0002,$A019   ; $0123D4 MOVE.B  #$0002,$A019.W
        DC.W    $6000,$0122         ; $0123DA BRA.W  loc_0124FE
loc_0123DE:
        DC.W    $11FC,$0004,$A019   ; $0123DE MOVE.B  #$0004,$A019.W
        DC.W    $6000,$0118         ; $0123E4 BRA.W  loc_0124FE
loc_0123E8:
        DC.W    $0801,$0003         ; $0123E8 BTST    #3,D1
        DC.W    $6734               ; $0123EC BEQ.S  loc_012422
        DC.W    $11FC,$00A9,$C8A4   ; $0123EE MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A38,$A01A         ; $0123F4 TST.B  $A01A.W
        DC.W    $6610               ; $0123F8 BNE.S  loc_01240A
        DC.W    $0C38,$0002,$A019   ; $0123FA CMPI.B  #$0002,$A019.W
        DC.W    $6C18               ; $012400 BGE.S  loc_01241A
        DC.W    $5238,$A019         ; $012402 ADDQ.B  #1,$A019.W
        DC.W    $6000,$00F6         ; $012406 BRA.W  loc_0124FE
loc_01240A:
        DC.W    $0C38,$0004,$A019   ; $01240A CMPI.B  #$0004,$A019.W
        DC.W    $6C08               ; $012410 BGE.S  loc_01241A
        DC.W    $5238,$A019         ; $012412 ADDQ.B  #1,$A019.W
        DC.W    $6000,$00E6         ; $012416 BRA.W  loc_0124FE
loc_01241A:
        DC.W    $4238,$A019         ; $01241A CLR.B  $A019.W
        DC.W    $6000,$00DE         ; $01241E BRA.W  loc_0124FE
loc_012422:
        DC.W    $0801,$0000         ; $012422 BTST    #0,D1
        DC.W    $6722               ; $012426 BEQ.S  loc_01244A
        DC.W    $4A38,$A01A         ; $012428 TST.B  $A01A.W
        DC.W    $6700,$00D0         ; $01242C BEQ.W  loc_0124FE
        DC.W    $11FC,$00A9,$C8A4   ; $012430 MOVE.B  #$00A9,$C8A4.W
        DC.W    $11F8,$A019,$A01C   ; $012436 MOVE.B  $A019.W,$A01C.W
        DC.W    $11F8,$A01B,$A019   ; $01243C MOVE.B  $A01B.W,$A019.W
        DC.W    $4238,$A01A         ; $012442 CLR.B  $A01A.W
        DC.W    $6000,$00B6         ; $012446 BRA.W  loc_0124FE
loc_01244A:
        DC.W    $0801,$0001         ; $01244A BTST    #1,D1
        DC.W    $6724               ; $01244E BEQ.S  loc_012474
        DC.W    $4A38,$A01A         ; $012450 TST.B  $A01A.W
        DC.W    $6600,$00A8         ; $012454 BNE.W  loc_0124FE
        DC.W    $11FC,$00A9,$C8A4   ; $012458 MOVE.B  #$00A9,$C8A4.W
        DC.W    $11F8,$A019,$A01B   ; $01245E MOVE.B  $A019.W,$A01B.W
        DC.W    $11F8,$A01C,$A019   ; $012464 MOVE.B  $A01C.W,$A019.W
        DC.W    $11FC,$0001,$A01A   ; $01246A MOVE.B  #$0001,$A01A.W
        DC.W    $6000,$008C         ; $012470 BRA.W  loc_0124FE
loc_012474:
        DC.W    $E049               ; $012474 LSR.W  #8,D1
        DC.W    $0801,$0006         ; $012476 BTST    #6,D1
        DC.W    $672E               ; $01247A BEQ.S  loc_0124AA
        DC.W    $4A78,$A02C         ; $01247C TST.W  $A02C.W
        DC.W    $6700,$007C         ; $012480 BEQ.W  loc_0124FE
        DC.W    $21FC,$0000,$0400,$A026; $012484 MOVE.L  #$00000400,$A026.W
        DC.W    $31FC,$0007,$A02A   ; $01248C MOVE.W  #$0007,$A02A.W
        DC.W    $5378,$A02C         ; $012492 SUBQ.W  #1,$A02C.W
        DC.W    $04B8,$0000,$2000,$A030; $012496 SUBI.L  #$00002000,$A030.W
        DC.W    $04B8,$0000,$2000,$A034; $01249E SUBI.L  #$00002000,$A034.W
        DC.W    $6000,$0056         ; $0124A6 BRA.W  loc_0124FE
loc_0124AA:
        DC.W    $0801,$0005         ; $0124AA BTST    #5,D1
        DC.W    $6700,$004E         ; $0124AE BEQ.W  loc_0124FE
        DC.W    $0C78,$000F,$A02C   ; $0124B2 CMPI.W  #$000F,$A02C.W
        DC.W    $6C00,$0044         ; $0124B8 BGE.W  loc_0124FE
        DC.W    $21FC,$FFFF,$FC00,$A026; $0124BC MOVE.L  #$FFFFFC00,$A026.W
        DC.W    $31FC,$0007,$A02A   ; $0124C4 MOVE.W  #$0007,$A02A.W
        DC.W    $6000,$0032         ; $0124CA BRA.W  loc_0124FE
loc_0124CE:
        DC.W    $4EB9,$0088,$FB36   ; $0124CE JSR     $0088FB36
        DC.W    $0838,$0006,$C80E   ; $0124D4 BTST    #6,$C80E.W
        DC.W    $6622               ; $0124DA BNE.S  loc_0124FE
        DC.W    $4278,$A038         ; $0124DC CLR.W  $A038.W
        DC.W    $6000,$001C         ; $0124E0 BRA.W  loc_0124FE
loc_0124E4:
        DC.W    $4EB9,$0088,$FB36   ; $0124E4 JSR     $0088FB36
        DC.W    $0838,$0007,$C80E   ; $0124EA BTST    #7,$C80E.W
        DC.W    $660C               ; $0124F0 BNE.S  loc_0124FE
        DC.W    $4278,$A038         ; $0124F2 CLR.W  $A038.W
        DC.W    $5878,$C87E         ; $0124F6 ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $0124FA BRA.W  loc_012502
loc_0124FE:
        DC.W    $5978,$C87E         ; $0124FE SUBQ.W  #4,$C87E.W
loc_012502:
        DC.W    $33FC,$0018,$00FF,$0008; $012502 MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $01250A RTS
loc_01250C:
        DC.W    $4A39,$00A1,$5120   ; $01250C TST.B  $00A15120
        DC.W    $66F8               ; $012512 BNE.S  loc_01250C
        DC.W    $4239,$00A1,$5123   ; $012514 CLR.B  $00A15123
        DC.W    $31FC,$0000,$C87E   ; $01251A MOVE.W  #$0000,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $012520 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0089,$26D2,$00FF,$0002; $012528 MOVE.L  #$008926D2,$00FF0002
        DC.W    $4E75               ; $012532 RTS
loc_012534:
        DC.W    $45F8,$EF08         ; $012534 LEA     $EF08.W,A2
        DC.W    $7600               ; $012538 MOVEQ   #$00,D3
        DC.W    $4A00               ; $01253A TST.B  D0
        DC.W    $670C               ; $01253C BEQ.S  loc_01254A
        DC.W    $5340               ; $01253E SUBQ.W  #1,D0
loc_012540:
        DC.W    $0683,$0000,$03C0   ; $012540 ADDI.L  #$000003C0,D3
        DC.W    $51C8,$FFF8         ; $012546 DBRA    D0,loc_012540
loc_01254A:
        DC.W    $D5C3               ; $01254A ADDA.L  D3,A2
        DC.W    $D241               ; $01254C ADD.W  D1,D1
        DC.W    $D241               ; $01254E ADD.W  D1,D1
        DC.W    $D241               ; $012550 ADD.W  D1,D1
        DC.W    $D241               ; $012552 ADD.W  D1,D1
        DC.W    $3601               ; $012554 MOVE.W  D1,D3
        DC.W    $D241               ; $012556 ADD.W  D1,D1
        DC.W    $D241               ; $012558 ADD.W  D1,D1
        DC.W    $D243               ; $01255A ADD.W  D3,D1
        DC.W    $D241               ; $01255C ADD.W  D1,D1
        DC.W    $D5C1               ; $01255E ADDA.L  D1,A2
        DC.W    $D442               ; $012560 ADD.W  D2,D2
        DC.W    $D442               ; $012562 ADD.W  D2,D2
        DC.W    $D442               ; $012564 ADD.W  D2,D2
        DC.W    $D5C2               ; $012566 ADDA.L  D2,A2
        DC.W    $383C,$0005         ; $012568 MOVE.W  #$0005,D4
        DC.W    $2649               ; $01256C MOVEA.L A1,A3
        DC.W    $284A               ; $01256E MOVEA.L A2,A4
loc_012570:
        DC.W    $224B               ; $012570 MOVEA.L A3,A1
        DC.W    $244C               ; $012572 MOVEA.L A4,A2
        DC.W    $6100,$0094         ; $012574 BSR.W  loc_01260A
        DC.W    $D3FC,$0000,$0010   ; $012578 ADDA.L  #$00000010,A1
        DC.W    $1A1A               ; $01257E MOVE.B  (A2)+,D5
        DC.W    $6100,$001A         ; $012580 BSR.W  loc_01259C
        DC.W    $D3FC,$0000,$0020   ; $012584 ADDA.L  #$00000020,A1
        DC.W    $6100,$011A         ; $01258A BSR.W  loc_0126A6
        DC.W    $D7FC,$0000,$2000   ; $01258E ADDA.L  #$00002000,A3
        DC.W    $508C               ; $012594 ADDQ.L  #8,A4
        DC.W    $51CC,$FFD8         ; $012596 DBRA    D4,loc_012570
        DC.W    $4E75               ; $01259A RTS
loc_01259C:
        DC.W    $161A               ; $01259C MOVE.B  (A2)+,D3
        DC.W    $6100,$0030         ; $01259E BSR.W  loc_0125D0
        DC.W    $323C,$000A         ; $0125A2 MOVE.W  #$000A,D1
        DC.W    $6100,$0044         ; $0125A6 BSR.W  loc_0125EC
        DC.W    $5089               ; $0125AA ADDQ.L  #8,A1
        DC.W    $161A               ; $0125AC MOVE.B  (A2)+,D3
        DC.W    $6100,$0020         ; $0125AE BSR.W  loc_0125D0
        DC.W    $323C,$000B         ; $0125B2 MOVE.W  #$000B,D1
        DC.W    $6100,$0034         ; $0125B6 BSR.W  loc_0125EC
        DC.W    $5089               ; $0125BA ADDQ.L  #8,A1
        DC.W    $121A               ; $0125BC MOVE.B  (A2)+,D1
        DC.W    $0241,$000F         ; $0125BE ANDI.W  #$000F,D1
        DC.W    $6100,$0028         ; $0125C2 BSR.W  loc_0125EC
        DC.W    $5089               ; $0125C6 ADDQ.L  #8,A1
        DC.W    $161A               ; $0125C8 MOVE.B  (A2)+,D3
        DC.W    $6100,$0004         ; $0125CA BSR.W  loc_0125D0
        DC.W    $4E75               ; $0125CE RTS
loc_0125D0:
        DC.W    $1203               ; $0125D0 MOVE.B  D3,D1
        DC.W    $E809               ; $0125D2 LSR.B  #4,D1
        DC.W    $0241,$000F         ; $0125D4 ANDI.W  #$000F,D1
        DC.W    $6100,$0012         ; $0125D8 BSR.W  loc_0125EC
        DC.W    $5089               ; $0125DC ADDQ.L  #8,A1
        DC.W    $3203               ; $0125DE MOVE.W  D3,D1
        DC.W    $0241,$000F         ; $0125E0 ANDI.W  #$000F,D1
        DC.W    $6100,$0006         ; $0125E4 BSR.W  loc_0125EC
        DC.W    $5089               ; $0125E8 ADDQ.L  #8,A1
        DC.W    $4E75               ; $0125EA RTS
loc_0125EC:
        DC.W    $ED49               ; $0125EC LSL.W  #6,D1
        DC.W    $3001               ; $0125EE MOVE.W  D1,D0
        DC.W    $E349               ; $0125F0 LSL.W  #1,D1
        DC.W    $D240               ; $0125F2 ADD.W  D0,D1
        DC.W    $207C,$0601,$F000   ; $0125F4 MOVEA.L #$0601F000,A0
        DC.W    $D0C1               ; $0125FA ADDA.W  D1,A0
        DC.W    $303C,$000C         ; $0125FC MOVE.W  #$000C,D0
        DC.W    $323C,$0010         ; $012600 MOVE.W  #$0010,D1
        DC.W    $4EBA,$BD54         ; $012604 JSR     $00E35A(PC)
        DC.W    $4E75               ; $012608 RTS
loc_01260A:
        DC.W    $343C,$0002         ; $01260A MOVE.W  #$0002,D2
loc_01260E:
        DC.W    $121A               ; $01260E MOVE.B  (A2)+,D1
        DC.W    $6106               ; $012610 BSR.S  loc_012618
        DC.W    $51CA,$FFFA         ; $012612 DBRA    D2,loc_01260E
        DC.W    $4E75               ; $012616 RTS
loc_012618:
        DC.W    $0C01,$0060         ; $012618 CMPI.B  #$0060,D1
        DC.W    $6E00,$002A         ; $01261C BGT.W  loc_012648
        DC.W    $0C01,$0040         ; $012620 CMPI.B  #$0040,D1
        DC.W    $6E00,$003A         ; $012624 BGT.W  loc_012660
        DC.W    $0C01,$0020         ; $012628 CMPI.B  #$0020,D1
        DC.W    $6700,$0074         ; $01262C BEQ.W  loc_0126A2
        DC.W    $0C01,$0021         ; $012630 CMPI.B  #$0021,D1
        DC.W    $6700,$0040         ; $012634 BEQ.W  loc_012676
        DC.W    $0C01,$002E         ; $012638 CMPI.B  #$002E,D1
        DC.W    $6700,$003E         ; $01263C BEQ.W  loc_01267C
        DC.W    $323C,$0036         ; $012640 MOVE.W  #$0036,D1
        DC.W    $6000,$003A         ; $012644 BRA.W  loc_012680
loc_012648:
        DC.W    $0401,$0047         ; $012648 SUBI.B  #$0047,D1
        DC.W    $0241,$00FF         ; $01264C ANDI.W  #$00FF,D1
        DC.W    $0C41,$0033         ; $012650 CMPI.W  #$0033,D1
        DC.W    $6F00,$002A         ; $012654 BLE.W  loc_012680
        DC.W    $323C,$0036         ; $012658 MOVE.W  #$0036,D1
        DC.W    $6000,$0022         ; $01265C BRA.W  loc_012680
loc_012660:
        DC.W    $0401,$0041         ; $012660 SUBI.B  #$0041,D1
        DC.W    $0241,$00FF         ; $012664 ANDI.W  #$00FF,D1
        DC.W    $0C41,$0019         ; $012668 CMPI.W  #$0019,D1
        DC.W    $6F00,$0012         ; $01266C BLE.W  loc_012680
        DC.W    $323C,$0036         ; $012670 MOVE.W  #$0036,D1
        DC.W    $600A               ; $012674 BRA.S  loc_012680
loc_012676:
        DC.W    $323C,$0035         ; $012676 MOVE.W  #$0035,D1
        DC.W    $6004               ; $01267A BRA.S  loc_012680
loc_01267C:
        DC.W    $323C,$0034         ; $01267C MOVE.W  #$0034,D1
loc_012680:
        DC.W    $41F9,$0602,$07C0   ; $012680 LEA     $060207C0,A0
        DC.W    $4A41               ; $012686 TST.W  D1
        DC.W    $670C               ; $012688 BEQ.S  loc_012696
        DC.W    $5341               ; $01268A SUBQ.W  #1,D1
loc_01268C:
        DC.W    $D1FC,$0000,$00C0   ; $01268C ADDA.L  #$000000C0,A0
        DC.W    $51C9,$FFF8         ; $012692 DBRA    D1,loc_01268C
loc_012696:
        DC.W    $303C,$000C         ; $012696 MOVE.W  #$000C,D0
        DC.W    $323C,$0010         ; $01269A MOVE.W  #$0010,D1
        DC.W    $4EBA,$BCBA         ; $01269E JSR     $00E35A(PC)
loc_0126A2:
        DC.W    $5089               ; $0126A2 ADDQ.L  #8,A1
        DC.W    $4E75               ; $0126A4 RTS
loc_0126A6:
        DC.W    $207C,$0601,$F9C0   ; $0126A6 MOVEA.L #$0601F9C0,A0
        DC.W    $7000               ; $0126AC MOVEQ   #$00,D0
        DC.W    $0245,$0003         ; $0126AE ANDI.W  #$0003,D5
        DC.W    $4A45               ; $0126B2 TST.W  D5
        DC.W    $670C               ; $0126B4 BEQ.S  loc_0126C2
        DC.W    $5345               ; $0126B6 SUBQ.W  #1,D5
loc_0126B8:
        DC.W    $0680,$0000,$0380   ; $0126B8 ADDI.L  #$00000380,D0
        DC.W    $51CD,$FFF8         ; $0126BE DBRA    D5,loc_0126B8
loc_0126C2:
        DC.W    $D1C0               ; $0126C2 ADDA.L  D0,A0
        DC.W    $303C,$0038         ; $0126C4 MOVE.W  #$0038,D0
        DC.W    $323C,$0010         ; $0126C8 MOVE.W  #$0010,D1
        DC.W    $4EBA,$BC8C         ; $0126CC JSR     $00E35A(PC)
        DC.W    $4E75               ; $0126D0 RTS
        DC.W    $33FC,$002C,$00FF,$0008; $0126D2 MOVE.W  #$002C,$00FF0008
        DC.W    $31FC,$002C,$C87A   ; $0126DA MOVE.W  #$002C,$C87A.W
        DC.W    $08B8,$0006,$C875   ; $0126E0 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $0126E6 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $0126EA MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $0126F2 ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$26C8   ; $0126FA JSR     $008826C8
        DC.W    $203C,$000A,$0907   ; $012700 MOVE.L  #$000A0907,D0
        DC.W    $4EB9,$0088,$14BE   ; $012706 JSR     $008814BE
        DC.W    $11FC,$0001,$C80D   ; $01270C MOVE.B  #$0001,$C80D.W
        DC.W    $41F9,$00FF,$2000   ; $012712 LEA     $00FF2000,A0
        DC.W    $4298               ; $012718 CLR.L  (A0)+
        DC.W    $4298               ; $01271A CLR.L  (A0)+
        DC.W    $4298               ; $01271C CLR.L  (A0)+
        DC.W    $4298               ; $01271E CLR.L  (A0)+
        DC.W    $4298               ; $012720 CLR.L  (A0)+
        DC.W    $4298               ; $012722 CLR.L  (A0)+
        DC.W    $4298               ; $012724 CLR.L  (A0)+
        DC.W    $4298               ; $012726 CLR.L  (A0)+
        DC.W    $4298               ; $012728 CLR.L  (A0)+
        DC.W    $4298               ; $01272A CLR.L  (A0)+
        DC.W    $4298               ; $01272C CLR.L  (A0)+
        DC.W    $4298               ; $01272E CLR.L  (A0)+
        DC.W    $4298               ; $012730 CLR.L  (A0)+
        DC.W    $7000               ; $012732 MOVEQ   #$00,D0
        DC.W    $41F8,$8480         ; $012734 LEA     $8480.W,A0
        DC.W    $721F               ; $012738 MOVEQ   #$1F,D1
loc_01273A:
        DC.W    $20C0               ; $01273A MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $01273C DBRA    D1,loc_01273A
        DC.W    $41F9,$00FF,$7B80   ; $012740 LEA     $00FF7B80,A0
        DC.W    $727F               ; $012746 MOVEQ   #$7F,D1
loc_012748:
        DC.W    $20C0               ; $012748 MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $01274A DBRA    D1,loc_012748
        DC.W    $2ABC,$6000,$0002   ; $01274E MOVE.L  #$60000002,(A5)
        DC.W    $323C,$17FF         ; $012754 MOVE.W  #$17FF,D1
loc_012758:
        DC.W    $2C80               ; $012758 MOVE.L  D0,(A6)
        DC.W    $51C9,$FFFC         ; $01275A DBRA    D1,loc_012758
        DC.W    $4EB9,$0088,$49AA   ; $01275E JSR     $008849AA
        DC.W    $4278,$C880         ; $012764 CLR.W  $C880.W
        DC.W    $4278,$C882         ; $012768 CLR.W  $C882.W
        DC.W    $4278,$8000         ; $01276C CLR.W  $8000.W
        DC.W    $31FC,$FFFC,$8002   ; $012770 MOVE.W  #$FFFC,$8002.W
        DC.W    $4278,$A012         ; $012776 CLR.W  $A012.W
        DC.W    $4238,$A018         ; $01277A CLR.B  $A018.W
        DC.W    $21FC,$0000,$0014,$A020; $01277E MOVE.L  #$00000014,$A020.W
        DC.W    $42B8,$A024         ; $012786 CLR.L  $A024.W
        DC.W    $4278,$A028         ; $01278A CLR.W  $A028.W
        DC.W    $0838,$0007,$FDA8   ; $01278E BTST    #7,$FDA8.W
        DC.W    $6716               ; $012794 BEQ.S  loc_0127AC
        DC.W    $0C38,$0005,$C817   ; $012796 CMPI.B  #$0005,$C817.W
        DC.W    $660E               ; $01279C BNE.S  loc_0127AC
        DC.W    $21FC,$FFFF,$FFFC,$A024; $01279E MOVE.L  #$FFFFFFFC,$A024.W
        DC.W    $31FC,$0037,$A028   ; $0127A6 MOVE.W  #$0037,$A028.W
loc_0127AC:
        DC.W    $4EB9,$0088,$49AA   ; $0127AC JSR     $008849AA
        DC.W    $31FC,$0001,$A03A   ; $0127B2 MOVE.W  #$0001,$A03A.W
        DC.W    $21FC,$008B,$B4FC,$C96C; $0127B8 MOVE.L  #$008BB4FC,$C96C.W
        DC.W    $11FC,$0001,$C809   ; $0127C0 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $0127C6 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $0127CC BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $0127D2 MOVE.B  #$0001,$C802.W
        DC.W    $41F9,$00FF,$1000   ; $0127D8 LEA     $00FF1000,A0
        DC.W    $303C,$037F         ; $0127DE MOVE.W  #$037F,D0
loc_0127E2:
        DC.W    $4298               ; $0127E2 CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $0127E4 DBRA    D0,loc_0127E2
        DC.W    $303C,$0001         ; $0127E8 MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $0127EC MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $0127F0 MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $0127F4 MOVE.W  #$0026,D3
        DC.W    $383C,$001A         ; $0127F8 MOVE.W  #$001A,D4
        DC.W    $41F9,$00FF,$1000   ; $0127FC LEA     $00FF1000,A0
        DC.W    $4EBA,$BA28         ; $012802 JSR     $00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $012806 LEA     $00FF1000,A0
        DC.W    $4EBA,$BAE2         ; $01280C JSR     $00E2F0(PC)
        DC.W    $4EBA,$B9AA         ; $012810 JSR     $00E1BC(PC)
        DC.W    $203C,$0000,$D006   ; $012814 MOVE.L  #$0000D006,D0
        DC.W    $323C,$0022         ; $01281A MOVE.W  #$0022,D1
        DC.W    $343C,$0008         ; $01281E MOVE.W  #$0008,D2
        DC.W    $363C,$0000         ; $012822 MOVE.W  #$0000,D3
        DC.W    $6100,$0798         ; $012826 BSR.W  loc_012FC0
        DC.W    $08B9,$0007,$00A1,$5181; $01282A BCLR    #7,$00A15181
        DC.W    $41F9,$00FF,$6E00   ; $012832 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0120   ; $012838 ADDA.L  #$00000120,A0
        DC.W    $43F9,$0089,$29E0   ; $01283E LEA     $008929E0,A1
        DC.W    $303C,$000F         ; $012844 MOVE.W  #$000F,D0
loc_012848:
        DC.W    $3219               ; $012848 MOVE.W  (A1)+,D1
        DC.W    $30C1               ; $01284A MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFFA         ; $01284C DBRA    D0,loc_012848
        DC.W    $41F9,$00FF,$6E00   ; $012850 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$01A0   ; $012856 ADDA.L  #$000001A0,A0
        DC.W    $43F9,$0089,$2A00   ; $01285C LEA     $00892A00,A1
        DC.W    $303C,$001F         ; $012862 MOVE.W  #$001F,D0
loc_012866:
        DC.W    $3219               ; $012866 MOVE.W  (A1)+,D1
        DC.W    $30C1               ; $012868 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFFA         ; $01286A DBRA    D0,loc_012866
        DC.W    $41F9,$000E,$A840   ; $01286E LEA     $000EA840,A0
        DC.W    $227C,$0603,$8000   ; $012874 MOVEA.L #$06038000,A1
        DC.W    $4EBA,$BA9A         ; $01287A JSR     $00E316(PC)
        DC.W    $0838,$0003,$C818   ; $01287E BTST    #3,$C818.W
        DC.W    $6608               ; $012884 BNE.S  loc_01288E
        DC.W    $4A38,$C81B         ; $012886 TST.B  $C81B.W
        DC.W    $6626               ; $01288A BNE.S  loc_0128B2
        DC.W    $6062               ; $01288C BRA.S  loc_0128F0
loc_01288E:
        DC.W    $207C,$0603,$8000   ; $01288E MOVEA.L #$06038000,A0
        DC.W    $D1FC,$0000,$0070   ; $012894 ADDA.L  #$00000070,A0
        DC.W    $303C,$0037         ; $01289A MOVE.W  #$0037,D0
        DC.W    $323C,$0048         ; $01289E MOVE.W  #$0048,D1
        DC.W    $343C,$FFC0         ; $0128A2 MOVE.W  #$FFC0,D2
        DC.W    $363C,$0150         ; $0128A6 MOVE.W  #$0150,D3
        DC.W    $4EB9,$0088,$E406   ; $0128AA JSR     $0088E406
        DC.W    $603E               ; $0128B0 BRA.S  loc_0128F0
loc_0128B2:
        DC.W    $207C,$0603,$8000   ; $0128B2 MOVEA.L #$06038000,A0
        DC.W    $303C,$006F         ; $0128B8 MOVE.W  #$006F,D0
        DC.W    $323C,$0048         ; $0128BC MOVE.W  #$0048,D1
        DC.W    $343C,$FFC0         ; $0128C0 MOVE.W  #$FFC0,D2
        DC.W    $363C,$0150         ; $0128C4 MOVE.W  #$0150,D3
        DC.W    $4EB9,$0088,$E406   ; $0128C8 JSR     $0088E406
        DC.W    $207C,$0603,$8000   ; $0128CE MOVEA.L #$06038000,A0
        DC.W    $D1FC,$0000,$00A8   ; $0128D4 ADDA.L  #$000000A8,A0
        DC.W    $303C,$0037         ; $0128DA MOVE.W  #$0037,D0
        DC.W    $323C,$0048         ; $0128DE MOVE.W  #$0048,D1
        DC.W    $343C,$FFC0         ; $0128E2 MOVE.W  #$FFC0,D2
        DC.W    $363C,$0150         ; $0128E6 MOVE.W  #$0150,D3
        DC.W    $4EB9,$0088,$E406   ; $0128EA JSR     $0088E406
loc_0128F0:
        DC.W    $41F9,$000E,$B790   ; $0128F0 LEA     $000EB790,A0
        DC.W    $227C,$0603,$DE80   ; $0128F6 MOVEA.L #$0603DE80,A1
        DC.W    $4EBA,$BA18         ; $0128FC JSR     $00E316(PC)
        DC.W    $11F8,$C817,$A019   ; $012900 MOVE.B  $C817.W,$A019.W
        DC.W    $31FC,$0010,$A02C   ; $012906 MOVE.W  #$0010,$A02C.W
        DC.W    $31FC,$0020,$A02E   ; $01290C MOVE.W  #$0020,$A02E.W
        DC.W    $31FC,$00A0,$A030   ; $012912 MOVE.W  #$00A0,$A030.W
        DC.W    $31FC,$0380,$A032   ; $012918 MOVE.W  #$0380,$A032.W
        DC.W    $31FC,$0000,$A034   ; $01291E MOVE.W  #$0000,$A034.W
        DC.W    $31FC,$0013,$A036   ; $012924 MOVE.W  #$0013,$A036.W
        DC.W    $4A38,$C81B         ; $01292A TST.B  $C81B.W
        DC.W    $6700,$0018         ; $01292E BEQ.W  loc_012948
        DC.W    $0C38,$0002,$A019   ; $012932 CMPI.B  #$0002,$A019.W
        DC.W    $670E               ; $012938 BEQ.S  loc_012948
        DC.W    $0C38,$0004,$A019   ; $01293A CMPI.B  #$0004,$A019.W
        DC.W    $6706               ; $012940 BEQ.S  loc_012948
        DC.W    $11FC,$0002,$A019   ; $012942 MOVE.B  #$0002,$A019.W
loc_012948:
        DC.W    $4EB9,$0088,$204A   ; $012948 JSR     $0088204A
        DC.W    $0239,$00FC,$00A1,$5181; $01294E ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $012956 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $01295E MOVE.W  #$8083,$00A15100
        DC.W    $08F8,$0006,$C875   ; $012966 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $01296C MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0020,$00FF,$0008; $012970 MOVE.W  #$0020,$00FF0008
        DC.W    $4EB9,$0088,$4998   ; $012978 JSR     $00884998
        DC.W    $31FC,$0000,$C87E   ; $01297E MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0089,$2A40,$00FF,$0002; $012984 MOVE.L  #$00892A40,$00FF0002
        DC.W    $08B8,$0000,$C80B   ; $01298E BCLR    #0,$C80B.W
        DC.W    $11FC,$0081,$C8A5   ; $012994 MOVE.B  #$0081,$C8A5.W
        DC.W    $41F9,$00FF,$6100   ; $01299A LEA     $00FF6100,A0
        DC.W    $303C,$007F         ; $0129A0 MOVE.W  #$007F,D0
loc_0129A4:
        DC.W    $4298               ; $0129A4 CLR.L  (A0)+
        DC.W    $4298               ; $0129A6 CLR.L  (A0)+
        DC.W    $4298               ; $0129A8 CLR.L  (A0)+
        DC.W    $4298               ; $0129AA CLR.L  (A0)+
        DC.W    $4298               ; $0129AC CLR.L  (A0)+
        DC.W    $51C8,$FFF4         ; $0129AE DBRA    D0,loc_0129A4
loc_0129B2:
        DC.W    $4A39,$00A1,$5120   ; $0129B2 TST.B  $00A15120
        DC.W    $66F8               ; $0129B8 BNE.S  loc_0129B2
        DC.W    $4239,$00A1,$5122   ; $0129BA CLR.B  $00A15122
        DC.W    $4239,$00A1,$5123   ; $0129C0 CLR.B  $00A15123
        DC.W    $13FC,$0003,$00A1,$5121; $0129C6 MOVE.B  #$0003,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $0129CE MOVE.B  #$0001,$00A15120
loc_0129D6:
        DC.W    $4A39,$00A1,$5120   ; $0129D6 TST.B  $00A15120
        DC.W    $66F8               ; $0129DC BNE.S  loc_0129D6
        DC.W    $4E75               ; $0129DE RTS
        DC.W    $5AD4               ; $0129E0 SPL     (A4)
        DC.W    $5AD6               ; $0129E2 SPL     (A6)
        DC.W    $7FFF               ; $0129E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $52B0,$52B1         ; $0129E8 ADDQ.L  #1,-$4F(A0,D5.W)
        DC.W    $56D2               ; $0129EC SNE     (A2)
        DC.W    $5AD3               ; $0129EE SPL     (A3)
        DC.W    $5EF4,$2964         ; $0129F0 SGT     $64(A4,D2.L)
        DC.W    $7FFF               ; $0129F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0129FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $6B58               ; $012A00 BMI.S  loc_012A5A
        DC.W    $6737               ; $012A02 BEQ.S  loc_012A3B
        DC.W    $7FFF               ; $012A04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A06 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $5A92               ; $012A08 ADDQ.L  #5,(A2)
        DC.W    $5ED4               ; $012A0A SGT     (A4)
        DC.W    $6716               ; $012A0C BEQ.S  loc_012A24
        DC.W    $6B58               ; $012A0E BMI.S  loc_012A68
        DC.W    $739A,$61E8         ; $012A10 MOVE.W  (A2)+,-$18(A1,D6.W)
        DC.W    $7FFF               ; $012A14 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A16 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A18 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A1C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012A1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFBC,$FF7A,$FFFF   ; $012A20 MOVE.W  #$FF7A,-$01(A7,A7.L)
        DC.W    $FFFF               ; $012A26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $C445               ; $012A28 AND.W  D5,D2
        DC.W    $D12B,$E212         ; $012A2A ADD.B  D0,-$1DEE(A3)
        DC.W    $EEF8,$FFFF         ; $012A2E ROR.W  $FFFF.W
        DC.W    $831F               ; $012A32 OR.B   D1,(A7)+
        DC.W    $FFFF               ; $012A34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A38 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $FFFF               ; $012A3E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $4EB9,$0088,$2080   ; $012A40 JSR     $00882080
        DC.W    $3038,$C87E         ; $012A46 MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $012A4A MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $012A4E JMP     (A1)
        DC.W    $0089,$2A72,$0089   ; $012A50 ORI.L  #$2A720089,A1
        DC.W    $2C8A               ; $012A56 MOVE.L  A2,(A6)
        DC.W    $0089,$2CC2,$0089   ; $012A58 ORI.L  #$2CC20089,A1
        DC.W    $2F0A               ; $012A5E MOVE.L  A2,-(A7)
        DC.W    $4EBA,$8C22         ; $012A60 JSR     $00B684(PC)
        DC.W    $0838,$0006,$C80E   ; $012A64 BTST    #6,$C80E.W
        DC.W    $6604               ; $012A6A BNE.S  loc_012A70
        DC.W    $5878,$C87E         ; $012A6C ADDQ.W  #4,$C87E.W
loc_012A70:
        DC.W    $4E75               ; $012A70 RTS
        DC.W    $4240               ; $012A72 CLR.W  D0
        DC.W    $6100,$BAB6         ; $012A74 BSR.W  $00E52C
        DC.W    $5378,$A036         ; $012A78 SUBQ.W  #1,$A036.W
        DC.W    $6400,$0014         ; $012A7C BCC.W  loc_012A92
        DC.W    $31FC,$0001,$A036   ; $012A80 MOVE.W  #$0001,$A036.W
        DC.W    $0478,$0080,$A038   ; $012A86 SUBI.W  #$0080,$A038.W
        DC.W    $0278,$1FFF,$A038   ; $012A8C ANDI.W  #$1FFF,$A038.W
loc_012A92:
        DC.W    $41F9,$00FF,$6E00   ; $012A92 LEA     $00FF6E00,A0
        DC.W    $43F9,$0089,$2C72   ; $012A98 LEA     $00892C72,A1
        DC.W    $4240               ; $012A9E CLR.W  D0
        DC.W    $1038,$A019         ; $012AA0 MOVE.B  $A019.W,D0
        DC.W    $D040               ; $012AA4 ADD.W  D0,D0
        DC.W    $D040               ; $012AA6 ADD.W  D0,D0
        DC.W    $2271,$0000         ; $012AA8 MOVEA.L $00(A1,D0.W),A1
        DC.W    $303C,$007F         ; $012AAC MOVE.W  #$007F,D0
loc_012AB0:
        DC.W    $30D9               ; $012AB0 MOVE.W  (A1)+,(A0)+
        DC.W    $51C8,$FFFC         ; $012AB2 DBRA    D0,loc_012AB0
        DC.W    $41F9,$0089,$2C12   ; $012AB6 LEA     $00892C12,A0
        DC.W    $43F8,$A02C         ; $012ABC LEA     $A02C.W,A1
        DC.W    $4280               ; $012AC0 CLR.L  D0
        DC.W    $1038,$A019         ; $012AC2 MOVE.B  $A019.W,D0
        DC.W    $E948               ; $012AC6 LSL.W  #4,D0
        DC.W    $D1C0               ; $012AC8 ADDA.L  D0,A0
        DC.W    $323C,$0004         ; $012ACA MOVE.W  #$0004,D1
loc_012ACE:
        DC.W    $32D8               ; $012ACE MOVE.W  (A0)+,(A1)+
        DC.W    $51C9,$FFFC         ; $012AD0 DBRA    D1,loc_012ACE
        DC.W    $13FC,$0000,$00FF,$60D4; $012AD4 MOVE.B  #$0000,$00FF60D4
        DC.W    $43F9,$00FF,$6100   ; $012ADC LEA     $00FF6100,A1
        DC.W    $337C,$0001,$0000   ; $012AE2 MOVE.W  #$0001,$0000(A1)
        DC.W    $3378,$A02C,$0002   ; $012AE8 MOVE.W  $A02C.W,$0002(A1)
        DC.W    $3378,$A02E,$0004   ; $012AEE MOVE.W  $A02E.W,$0004(A1)
        DC.W    $3378,$A030,$0006   ; $012AF4 MOVE.W  $A030.W,$0006(A1)
        DC.W    $2038,$A014         ; $012AFA MOVE.L  $A014.W,D0
        DC.W    $3340,$000A         ; $012AFE MOVE.W  D0,$000A(A1)
        DC.W    $3378,$A032,$0008   ; $012B02 MOVE.W  $A032.W,$0008(A1)
        DC.W    $3378,$A034,$000C   ; $012B08 MOVE.W  $A034.W,$000C(A1)
        DC.W    $337C,$0000,$000E   ; $012B0E MOVE.W  #$0000,$000E(A1)
        DC.W    $41F9,$0089,$2BFA   ; $012B14 LEA     $00892BFA,A0
        DC.W    $4241               ; $012B1A CLR.W  D1
        DC.W    $1238,$A019         ; $012B1C MOVE.B  $A019.W,D1
        DC.W    $0C01,$0005         ; $012B20 CMPI.B  #$0005,D1
        DC.W    $6608               ; $012B24 BNE.S  loc_012B2E
        DC.W    $13FC,$0001,$00FF,$60D4; $012B26 MOVE.B  #$0001,$00FF60D4
loc_012B2E:
        DC.W    $D241               ; $012B2E ADD.W  D1,D1
        DC.W    $D241               ; $012B30 ADD.W  D1,D1
        DC.W    $2370,$1000,$0010   ; $012B32 MOVE.L  $00(A0,D1.W),$0010(A1)
        DC.W    $D3FC,$0000,$0014   ; $012B38 ADDA.L  #$00000014,A1
        DC.W    $337C,$0000,$0000   ; $012B3E MOVE.W  #$0000,$0000(A1)
        DC.W    $0C38,$0001,$A019   ; $012B44 CMPI.B  #$0001,$A019.W
        DC.W    $661A               ; $012B4A BNE.S  loc_012B66
        DC.W    $337C,$0001,$0000   ; $012B4C MOVE.W  #$0001,$0000(A1)
        DC.W    $3378,$A038,$000A   ; $012B52 MOVE.W  $A038.W,$000A(A1)
        DC.W    $337C,$0000,$000E   ; $012B58 MOVE.W  #$0000,$000E(A1)
        DC.W    $237C,$222B,$90F8,$0010; $012B5E MOVE.L  #$222B90F8,$0010(A1)
loc_012B66:
        DC.W    $33FC,$0041,$00A1,$5110; $012B66 MOVE.W  #$0041,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $012B6E MOVE.B  #$0004,$00A15107
        DC.W    $4239,$00A1,$5123   ; $012B76 CLR.B  $00A15123
        DC.W    $13FC,$002B,$00A1,$5121; $012B7C MOVE.B  #$002B,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $012B84 MOVE.B  #$0001,$00A15120
loc_012B8C:
        DC.W    $0839,$0001,$00A1,$5123; $012B8C BTST    #1,$00A15123
        DC.W    $67F6               ; $012B94 BEQ.S  loc_012B8C
        DC.W    $08B9,$0001,$00A1,$5123; $012B96 BCLR    #1,$00A15123
        DC.W    $43F9,$00FF,$60C8   ; $012B9E LEA     $00FF60C8,A1
        DC.W    $45F9,$00A1,$5112   ; $012BA4 LEA     $00A15112,A2
        DC.W    $3E3C,$0040         ; $012BAA MOVE.W  #$0040,D7
loc_012BAE:
        DC.W    $0839,$0007,$00A1,$5107; $012BAE BTST    #7,$00A15107
        DC.W    $66F6               ; $012BB6 BNE.S  loc_012BAE
        DC.W    $3499               ; $012BB8 MOVE.W  (A1)+,(A2)
        DC.W    $51CF,$FFF2         ; $012BBA DBRA    D7,loc_012BAE
        DC.W    $2038,$A014         ; $012BBE MOVE.L  $A014.W,D0
        DC.W    $0680,$0000,$0080   ; $012BC2 ADDI.L  #$00000080,D0
        DC.W    $0280,$0000,$FFFF   ; $012BC8 ANDI.L  #$0000FFFF,D0
        DC.W    $21C0,$A014         ; $012BCE MOVE.L  D0,$A014.W
        DC.W    $4280               ; $012BD2 CLR.L  D0
        DC.W    $D0B8,$A024         ; $012BD4 ADD.L  $A024.W,D0
        DC.W    $D1B8,$A020         ; $012BD8 ADD.L  D0,$A020.W
        DC.W    $5978,$A028         ; $012BDC SUBQ.W  #4,$A028.W
        DC.W    $6400,$000A         ; $012BE0 BCC.W  loc_012BEC
        DC.W    $21FC,$0000,$0000,$A024; $012BE4 MOVE.L  #$00000000,$A024.W
loc_012BEC:
        DC.W    $5878,$C87E         ; $012BEC ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $012BF0 MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $012BF8 RTS
        DC.W    $222B,$5FF6         ; $012BFA MOVE.L  $5FF6(A3),D1
        DC.W    $222B,$710A         ; $012BFE MOVE.L  $710A(A3),D1
        DC.W    $222B,$9122         ; $012C02 MOVE.L  -$6EDE(A3),D1
        DC.W    $222B,$A9F0         ; $012C06 MOVE.L  -$5610(A3),D1
        DC.W    $222B,$C8F4         ; $012C0A MOVE.L  -$370C(A3),D1
        DC.W    $222B,$5FF6         ; $012C0E MOVE.L  $5FF6(A3),D1
        DC.W    $0000,$FFB0         ; $012C12 ORI.B  #$FFB0,D0
        DC.W    $0060,$0140         ; $012C16 ORI.W  #$0140,-(A0)
        DC.W    $0000,$0000         ; $012C1A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C1E ORI.B  #$0000,D0
        DC.W    $0000,$FFB0         ; $012C22 ORI.B  #$FFB0,D0
        DC.W    $0060,$0140         ; $012C26 ORI.W  #$0140,-(A0)
        DC.W    $0000,$0000         ; $012C2A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C2E ORI.B  #$0000,D0
        DC.W    $0000,$FFB0         ; $012C32 ORI.B  #$FFB0,D0
        DC.W    $0070,$0140,$0000   ; $012C36 ORI.W  #$0140,$00(A0,D0.W)
        DC.W    $0000,$0000         ; $012C3C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C40 ORI.B  #$0000,D0
        DC.W    $FFA0,$0080         ; $012C44 MOVE.W  -(A0),-$80(A7,D0.W)
        DC.W    $0180               ; $012C48 BCLR    D0,D0
        DC.W    $0000,$0000         ; $012C4A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C4E ORI.B  #$0000,D0
        DC.W    $0000,$FF10         ; $012C52 ORI.B  #$FF10,D0
        DC.W    $0050,$0140         ; $012C56 ORI.W  #$0140,(A0)
        DC.W    $0000,$0000         ; $012C5A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C5E ORI.B  #$0000,D0
        DC.W    $0000,$FFB0         ; $012C62 ORI.B  #$FFB0,D0
        DC.W    $0060,$0140         ; $012C66 ORI.W  #$0140,-(A0)
        DC.W    $0000,$0000         ; $012C6A ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $012C6E ORI.B  #$0000,D0
        DC.W    $008B,$BBDC,$008B   ; $012C72 ORI.L  #$BBDC008B,A3
        DC.W    $BCDC               ; $012C78 CMPA.W  (A4)+,A6
        DC.W    $008B,$BBDC,$008B   ; $012C7A ORI.L  #$BBDC008B,A3
        DC.W    $BDDC               ; $012C80 CMPA.L  (A4)+,A6
        DC.W    $008B,$BEDC,$008B   ; $012C82 ORI.L  #$BEDC008B,A3
        DC.W    $BBDC               ; $012C88 CMPA.L  (A4)+,A5
        DC.W    $4240               ; $012C8A CLR.W  D0
        DC.W    $6100,$B89E         ; $012C8C BSR.W  $00E52C
        DC.W    $33FC,$0020,$00FF,$0008; $012C90 MOVE.W  #$0020,$00FF0008
        DC.W    $5878,$C87E         ; $012C98 ADDQ.W  #4,$C87E.W
        DC.W    $4E75               ; $012C9C RTS
        DC.W    $0C40,$4000         ; $012C9E CMPI.W  #$4000,D0
        DC.W    $6E0A               ; $012CA2 BGT.S  loc_012CAE
        DC.W    $0640,$0010         ; $012CA4 ADDI.W  #$0010,D0
        DC.W    $6004               ; $012CA8 BRA.S  loc_012CAE
        DC.W    $0640,$0040         ; $012CAA ADDI.W  #$0040,D0
loc_012CAE:
        DC.W    $4E75               ; $012CAE RTS
        DC.W    $0C40,$C000         ; $012CB0 CMPI.W  #$C000,D0
        DC.W    $6D0A               ; $012CB4 BLT.S  loc_012CC0
        DC.W    $0440,$0010         ; $012CB6 SUBI.W  #$0010,D0
        DC.W    $6004               ; $012CBA BRA.S  loc_012CC0
        DC.W    $0440,$0040         ; $012CBC SUBI.W  #$0040,D0
loc_012CC0:
        DC.W    $4E75               ; $012CC0 RTS
        DC.W    $4240               ; $012CC2 CLR.W  D0
        DC.W    $6100,$B866         ; $012CC4 BSR.W  $00E52C
        DC.W    $4EBA,$89BA         ; $012CC8 JSR     $00B684(PC)
        DC.W    $4EBA,$8A0C         ; $012CCC JSR     $00B6DA(PC)
        DC.W    $4EB9,$0088,$179E   ; $012CD0 JSR     $0088179E
        DC.W    $4A78,$A03A         ; $012CD6 TST.W  $A03A.W
        DC.W    $6600,$0136         ; $012CDA BNE.W  loc_012E12
        DC.W    $4A38,$C81B         ; $012CDE TST.B  $C81B.W
        DC.W    $6600,$00FA         ; $012CE2 BNE.W  loc_012DDE
        DC.W    $1038,$A019         ; $012CE6 MOVE.B  $A019.W,D0
        DC.W    $3238,$C86C         ; $012CEA MOVE.W  $C86C.W,D1
        DC.W    $4AB8,$A024         ; $012CEE TST.L  $A024.W
        DC.W    $6600,$011A         ; $012CF2 BNE.W  loc_012E0E
        DC.W    $0801,$0003         ; $012CF6 BTST    #3,D1
        DC.W    $6778               ; $012CFA BEQ.S  loc_012D74
        DC.W    $11FC,$00A9,$C8A4   ; $012CFC MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A38,$FDA8         ; $012D02 TST.B  $FDA8.W
        DC.W    $6748               ; $012D06 BEQ.S  loc_012D50
        DC.W    $0C00,$0005         ; $012D08 CMPI.B  #$0005,D0
        DC.W    $6D14               ; $012D0C BLT.S  loc_012D22
        DC.W    $4200               ; $012D0E CLR.B  D0
        DC.W    $21FC,$0000,$0004,$A024; $012D10 MOVE.L  #$00000004,$A024.W
        DC.W    $31FC,$0037,$A028   ; $012D18 MOVE.W  #$0037,$A028.W
        DC.W    $6000,$00EE         ; $012D1E BRA.W  loc_012E0E
loc_012D22:
        DC.W    $5200               ; $012D22 ADDQ.B  #1,D0
        DC.W    $0838,$0003,$C818   ; $012D24 BTST    #3,$C818.W
        DC.W    $670A               ; $012D2A BEQ.S  loc_012D36
        DC.W    $0C00,$0002         ; $012D2C CMPI.B  #$0002,D0
        DC.W    $6604               ; $012D30 BNE.S  loc_012D36
        DC.W    $103C,$0003         ; $012D32 MOVE.B  #$0003,D0
loc_012D36:
        DC.W    $0C00,$0005         ; $012D36 CMPI.B  #$0005,D0
        DC.W    $6600,$00D2         ; $012D3A BNE.W  loc_012E0E
        DC.W    $21FC,$FFFF,$FFFC,$A024; $012D3E MOVE.L  #$FFFFFFFC,$A024.W
        DC.W    $31FC,$0037,$A028   ; $012D46 MOVE.W  #$0037,$A028.W
        DC.W    $6000,$00C0         ; $012D4C BRA.W  loc_012E0E
loc_012D50:
        DC.W    $0C00,$0004         ; $012D50 CMPI.B  #$0004,D0
        DC.W    $6D06               ; $012D54 BLT.S  loc_012D5C
        DC.W    $4200               ; $012D56 CLR.B  D0
        DC.W    $6000,$00B4         ; $012D58 BRA.W  loc_012E0E
loc_012D5C:
        DC.W    $5200               ; $012D5C ADDQ.B  #1,D0
        DC.W    $0838,$0003,$C818   ; $012D5E BTST    #3,$C818.W
        DC.W    $670A               ; $012D64 BEQ.S  loc_012D70
        DC.W    $0C00,$0002         ; $012D66 CMPI.B  #$0002,D0
        DC.W    $6604               ; $012D6A BNE.S  loc_012D70
        DC.W    $103C,$0003         ; $012D6C MOVE.B  #$0003,D0
loc_012D70:
        DC.W    $6000,$009C         ; $012D70 BRA.W  loc_012E0E
loc_012D74:
        DC.W    $0801,$0002         ; $012D74 BTST    #2,D1
        DC.W    $6700,$0094         ; $012D78 BEQ.W  loc_012E0E
        DC.W    $11FC,$00A9,$C8A4   ; $012D7C MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A00               ; $012D82 TST.B  D0
        DC.W    $6E22               ; $012D84 BGT.S  loc_012DA8
        DC.W    $103C,$0004         ; $012D86 MOVE.B  #$0004,D0
        DC.W    $4A38,$FDA8         ; $012D8A TST.B  $FDA8.W
        DC.W    $6700,$007E         ; $012D8E BEQ.W  loc_012E0E
        DC.W    $103C,$0005         ; $012D92 MOVE.B  #$0005,D0
        DC.W    $21FC,$FFFF,$FFFC,$A024; $012D96 MOVE.L  #$FFFFFFFC,$A024.W
        DC.W    $31FC,$0037,$A028   ; $012D9E MOVE.W  #$0037,$A028.W
        DC.W    $6000,$0068         ; $012DA4 BRA.W  loc_012E0E
loc_012DA8:
        DC.W    $5300               ; $012DA8 SUBQ.B  #1,D0
        DC.W    $0838,$0003,$C818   ; $012DAA BTST    #3,$C818.W
        DC.W    $670A               ; $012DB0 BEQ.S  loc_012DBC
        DC.W    $0C00,$0002         ; $012DB2 CMPI.B  #$0002,D0
        DC.W    $6604               ; $012DB6 BNE.S  loc_012DBC
        DC.W    $103C,$0001         ; $012DB8 MOVE.B  #$0001,D0
loc_012DBC:
        DC.W    $4A38,$FDA8         ; $012DBC TST.B  $FDA8.W
        DC.W    $6700,$004C         ; $012DC0 BEQ.W  loc_012E0E
        DC.W    $0C00,$0004         ; $012DC4 CMPI.B  #$0004,D0
        DC.W    $6600,$0044         ; $012DC8 BNE.W  loc_012E0E
        DC.W    $21FC,$0000,$0004,$A024; $012DCC MOVE.L  #$00000004,$A024.W
        DC.W    $31FC,$0037,$A028   ; $012DD4 MOVE.W  #$0037,$A028.W
        DC.W    $6000,$0032         ; $012DDA BRA.W  loc_012E0E
loc_012DDE:
        DC.W    $1038,$A019         ; $012DDE MOVE.B  $A019.W,D0
        DC.W    $3238,$C86E         ; $012DE2 MOVE.W  $C86E.W,D1
        DC.W    $0801,$0003         ; $012DE6 BTST    #3,D1
        DC.W    $660A               ; $012DEA BNE.S  loc_012DF6
        DC.W    $0801,$0002         ; $012DEC BTST    #2,D1
        DC.W    $6604               ; $012DF0 BNE.S  loc_012DF6
        DC.W    $6000,$001A         ; $012DF2 BRA.W  loc_012E0E
loc_012DF6:
        DC.W    $11FC,$00A9,$C8A4   ; $012DF6 MOVE.B  #$00A9,$C8A4.W
        DC.W    $0C00,$0002         ; $012DFC CMPI.B  #$0002,D0
        DC.W    $6708               ; $012E00 BEQ.S  loc_012E0A
        DC.W    $103C,$0002         ; $012E02 MOVE.B  #$0002,D0
        DC.W    $6000,$0006         ; $012E06 BRA.W  loc_012E0E
loc_012E0A:
        DC.W    $103C,$0004         ; $012E0A MOVE.B  #$0004,D0
loc_012E0E:
        DC.W    $11C0,$A019         ; $012E0E MOVE.B  D0,$A019.W
loc_012E12:
        DC.W    $207C,$0603,$8000   ; $012E12 MOVEA.L #$06038000,A0
        DC.W    $227C,$0401,$4000   ; $012E18 MOVEA.L #$04014000,A1
        DC.W    $D3F8,$A020         ; $012E1E ADDA.L  $A020.W,A1
        DC.W    $303C,$0150         ; $012E22 MOVE.W  #$0150,D0
        DC.W    $323C,$0048         ; $012E26 MOVE.W  #$0048,D1
        DC.W    $4EBA,$B52E         ; $012E2A JSR     $00E35A(PC)
        DC.W    $4AB8,$A024         ; $012E2E TST.L  $A024.W
        DC.W    $6600,$000E         ; $012E32 BNE.W  loc_012E42
loc_012E36:
        DC.W    $4A39,$00A1,$5120   ; $012E36 TST.B  $00A15120
        DC.W    $66F8               ; $012E3C BNE.S  loc_012E36
        DC.W    $6100,$0132         ; $012E3E BSR.W  loc_012F72
loc_012E42:
        DC.W    $207C,$0603,$DE80   ; $012E42 MOVEA.L #$0603DE80,A0
        DC.W    $227C,$0400,$4C60   ; $012E48 MOVEA.L #$04004C60,A1
        DC.W    $303C,$0080         ; $012E4E MOVE.W  #$0080,D0
        DC.W    $323C,$0010         ; $012E52 MOVE.W  #$0010,D1
        DC.W    $4EBA,$B502         ; $012E56 JSR     $00E35A(PC)
loc_012E5A:
        DC.W    $4A39,$00A1,$5120   ; $012E5A TST.B  $00A15120
        DC.W    $66F8               ; $012E60 BNE.S  loc_012E5A
        DC.W    $4AB8,$A024         ; $012E62 TST.L  $A024.W
        DC.W    $6600,$002E         ; $012E66 BNE.W  loc_012E96
        DC.W    $0C78,$0001,$A03A   ; $012E6A CMPI.W  #$0001,$A03A.W
        DC.W    $6700,$0060         ; $012E70 BEQ.W  loc_012ED2
        DC.W    $0C78,$0002,$A03A   ; $012E74 CMPI.W  #$0002,$A03A.W
        DC.W    $6700,$0066         ; $012E7A BEQ.W  loc_012EE2
        DC.W    $3238,$C86C         ; $012E7E MOVE.W  $C86C.W,D1
        DC.W    $4A38,$C81B         ; $012E82 TST.B  $C81B.W
        DC.W    $6700,$0006         ; $012E86 BEQ.W  loc_012E8E
        DC.W    $3238,$C86E         ; $012E8A MOVE.W  $C86E.W,D1
loc_012E8E:
        DC.W    $3401               ; $012E8E MOVE.W  D1,D2
        DC.W    $0202,$00E0         ; $012E90 ANDI.B  #$00E0,D2
        DC.W    $6608               ; $012E94 BNE.S  loc_012E9E
loc_012E96:
        DC.W    $5178,$C87E         ; $012E96 SUBQ.W  #8,$C87E.W
        DC.W    $6000,$005E         ; $012E9A BRA.W  loc_012EFA
loc_012E9E:
        DC.W    $0801,$0000         ; $012E9E BTST    #0,D1
        DC.W    $6706               ; $012EA2 BEQ.S  loc_012EAA
        DC.W    $08F8,$0000,$C80B   ; $012EA4 BSET    #0,$C80B.W
loc_012EAA:
        DC.W    $11FC,$00A8,$C8A4   ; $012EAA MOVE.B  #$00A8,$C8A4.W
        DC.W    $11FC,$0001,$C809   ; $012EB0 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $012EB6 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $012EBC BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $012EC2 MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0002,$A03A   ; $012EC8 MOVE.W  #$0002,$A03A.W
        DC.W    $6000,$0026         ; $012ECE BRA.W  loc_012EF6
loc_012ED2:
        DC.W    $0838,$0006,$C80E   ; $012ED2 BTST    #6,$C80E.W
        DC.W    $661C               ; $012ED8 BNE.S  loc_012EF6
        DC.W    $4278,$A03A         ; $012EDA CLR.W  $A03A.W
        DC.W    $6000,$0016         ; $012EDE BRA.W  loc_012EF6
loc_012EE2:
        DC.W    $0838,$0007,$C80E   ; $012EE2 BTST    #7,$C80E.W
        DC.W    $660C               ; $012EE8 BNE.S  loc_012EF6
        DC.W    $4278,$A03A         ; $012EEA CLR.W  $A03A.W
        DC.W    $5878,$C87E         ; $012EEE ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $012EF2 BRA.W  loc_012EFA
loc_012EF6:
        DC.W    $5178,$C87E         ; $012EF6 SUBQ.W  #8,$C87E.W
loc_012EFA:
        DC.W    $33FC,$0018,$00FF,$0008; $012EFA MOVE.W  #$0018,$00FF0008
        DC.W    $11FC,$0001,$C821   ; $012F02 MOVE.B  #$0001,$C821.W
        DC.W    $4E75               ; $012F08 RTS
loc_012F0A:
        DC.W    $4A39,$00A1,$5120   ; $012F0A TST.B  $00A15120
        DC.W    $66F8               ; $012F10 BNE.S  loc_012F0A
        DC.W    $4239,$00A1,$5123   ; $012F12 CLR.B  $00A15123
        DC.W    $31FC,$0000,$C87E   ; $012F18 MOVE.W  #$0000,$C87E.W
        DC.W    $7200               ; $012F1E MOVEQ   #$00,D1
        DC.W    $1238,$A019         ; $012F20 MOVE.B  $A019.W,D1
        DC.W    $11C1,$C817         ; $012F24 MOVE.B  D1,$C817.W
        DC.W    $0C01,$0002         ; $012F28 CMPI.B  #$0002,D1
        DC.W    $660C               ; $012F2C BNE.S  loc_012F3A
        DC.W    $0838,$0003,$C818   ; $012F2E BTST    #3,$C818.W
        DC.W    $6704               ; $012F34 BEQ.S  loc_012F3A
        DC.W    $323C,$0006         ; $012F36 MOVE.W  #$0006,D1
loc_012F3A:
        DC.W    $D241               ; $012F3A ADD.W  D1,D1
        DC.W    $D241               ; $012F3C ADD.W  D1,D1
        DC.W    $31FC,$0000,$C87E   ; $012F3E MOVE.W  #$0000,$C87E.W
        DC.W    $23FB,$1010,$00FF,$0002; $012F44 MOVE.L  $10(PC,D1.W),$00FF0002
        DC.W    $33FC,$0020,$00FF,$0008; $012F4C MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $012F54 RTS
        DC.W    $0088,$E5CE,$0088   ; $012F56 ORI.L  #$E5CE0088,A0
        DC.W    $E5FE               ; $012F5C ROXL.W  <EA:3E>
        DC.W    $0088,$F13C,$0089   ; $012F5E ORI.L  #$F13C0089,A0
        DC.W    $1D0A               ; $012F64 MOVE.B  A2,-(A6)
        DC.W    $0089,$3054,$0088   ; $012F66 ORI.L  #$30540088,A1
        DC.W    $E5E6               ; $012F6C ROXL.W  -(A6)
        DC.W    $0089,$26D2,$7000   ; $012F6E ORI.L  #$26D27000,A1
        DC.W    $1038,$A019         ; $012F74 MOVE.B  $A019.W,D0
        DC.W    $43F9,$0089,$2F9C   ; $012F78 LEA     $00892F9C,A1
        DC.W    $D040               ; $012F7E ADD.W  D0,D0
        DC.W    $3200               ; $012F80 MOVE.W  D0,D1
        DC.W    $D040               ; $012F82 ADD.W  D0,D0
        DC.W    $D041               ; $012F84 ADD.W  D1,D0
        DC.W    $2071,$0000         ; $012F86 MOVEA.L $00(A1,D0.W),A0
        DC.W    $3031,$0004         ; $012F8A MOVE.W  $04(A1,D0.W),D0
        DC.W    $323C,$0048         ; $012F8E MOVE.W  #$0048,D1
        DC.W    $343C,$0010         ; $012F92 MOVE.W  #$0010,D2
        DC.W    $4EBA,$B41C         ; $012F96 JSR     $00E3B4(PC)
        DC.W    $4E75               ; $012F9A RTS
        DC.W    $0401,$4014         ; $012F9C SUBI.B  #$4014,D1
        DC.W    $0039,$0401,$404C,$0038; $012FA0 ORI.B  #$0401,$404C0038
        DC.W    $0401,$4083         ; $012FA8 SUBI.B  #$4083,D1
        DC.W    $0039,$0401,$40BB,$0039; $012FAC ORI.B  #$0401,$40BB0039
        DC.W    $0401,$40F3         ; $012FB4 SUBI.B  #$40F3,D1
        DC.W    $0039,$0401,$40F3,$0039; $012FB8 ORI.B  #$0401,$40F30039
loc_012FC0:
        DC.W    $383C,$0100         ; $012FC0 MOVE.W  #$0100,D4
loc_012FC4:
        DC.W    $3C00               ; $012FC4 MOVE.W  D0,D6
        DC.W    $0886,$000F         ; $012FC6 BCLR    #15,D6
        DC.W    $08C6,$000E         ; $012FCA BSET    #14,D6
        DC.W    $3A86               ; $012FCE MOVE.W  D6,(A5)
        DC.W    $3ABC,$0003         ; $012FD0 MOVE.W  #$0003,(A5)
        DC.W    $3A01               ; $012FD4 MOVE.W  D1,D5
loc_012FD6:
        DC.W    $3C83               ; $012FD6 MOVE.W  D3,(A6)
        DC.W    $51CD,$FFFC         ; $012FD8 DBRA    D5,loc_012FD6
        DC.W    $D084               ; $012FDC ADD.L  D4,D0
        DC.W    $51CA,$FFE4         ; $012FDE DBRA    D2,loc_012FC4
        DC.W    $4E75               ; $012FE2 RTS
loc_012FE4:
        DC.W    $4A39,$00A1,$5120   ; $012FE4 TST.B  $00A15120
        DC.W    $66F8               ; $012FEA BNE.S  loc_012FE4
        DC.W    $23C9,$00A1,$5128   ; $012FEC MOVE.L  A1,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $012FF2 MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0021,$00A1,$5121; $012FFA MOVE.B  #$0021,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $013002 MOVE.B  #$0001,$00A15120
loc_01300A:
        DC.W    $4A39,$00A1,$512C   ; $01300A TST.B  $00A1512C
        DC.W    $66F8               ; $013010 BNE.S  loc_01300A
        DC.W    $33C0,$00A1,$5128   ; $013012 MOVE.W  D0,$00A15128
        DC.W    $33C1,$00A1,$512A   ; $013018 MOVE.W  D1,$00A1512A
        DC.W    $33FC,$0101,$00A1,$512C; $01301E MOVE.W  #$0101,$00A1512C
        DC.W    $4A39,$00A1,$512C   ; $013026 TST.B  $00A1512C
        DC.W    $66DC               ; $01302C BNE.S  loc_01300A
        DC.W    $33C2,$00A1,$5128   ; $01302E MOVE.W  D2,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $013034 MOVE.W  #$0101,$00A1512C
loc_01303C:
        DC.W    $4A39,$00A1,$512C   ; $01303C TST.B  $00A1512C
        DC.W    $66F8               ; $013042 BNE.S  loc_01303C
        DC.W    $23C8,$00A1,$5128   ; $013044 MOVE.L  A0,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $01304A MOVE.W  #$0101,$00A1512C
        DC.W    $4E75               ; $013052 RTS
        DC.W    $11FC,$0000,$A019   ; $013054 MOVE.B  #$0000,$A019.W
        DC.W    $6000,$0008         ; $01305A BRA.W  loc_013064
        DC.W    $11FC,$0004,$A019   ; $01305E MOVE.B  #$0004,$A019.W
loc_013064:
        DC.W    $33FC,$002C,$00FF,$0008; $013064 MOVE.W  #$002C,$00FF0008
        DC.W    $31FC,$002C,$C87A   ; $01306C MOVE.W  #$002C,$C87A.W
        DC.W    $08B8,$0006,$C875   ; $013072 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $013078 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $01307C MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $013084 ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$26C8   ; $01308C JSR     $008826C8
        DC.W    $203C,$000A,$0907   ; $013092 MOVE.L  #$000A0907,D0
        DC.W    $4EB9,$0088,$14BE   ; $013098 JSR     $008814BE
        DC.W    $11FC,$0001,$C80D   ; $01309E MOVE.B  #$0001,$C80D.W
        DC.W    $7000               ; $0130A4 MOVEQ   #$00,D0
        DC.W    $41F8,$8480         ; $0130A6 LEA     $8480.W,A0
        DC.W    $721F               ; $0130AA MOVEQ   #$1F,D1
loc_0130AC:
        DC.W    $20C0               ; $0130AC MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $0130AE DBRA    D1,loc_0130AC
        DC.W    $41F9,$00FF,$7B80   ; $0130B2 LEA     $00FF7B80,A0
        DC.W    $727F               ; $0130B8 MOVEQ   #$7F,D1
loc_0130BA:
        DC.W    $20C0               ; $0130BA MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $0130BC DBRA    D1,loc_0130BA
        DC.W    $2ABC,$6000,$0002   ; $0130C0 MOVE.L  #$60000002,(A5)
        DC.W    $323C,$17FF         ; $0130C6 MOVE.W  #$17FF,D1
loc_0130CA:
        DC.W    $2C80               ; $0130CA MOVE.L  D0,(A6)
        DC.W    $51C9,$FFFC         ; $0130CC DBRA    D1,loc_0130CA
        DC.W    $4EB9,$0088,$49AA   ; $0130D0 JSR     $008849AA
        DC.W    $4278,$C880         ; $0130D6 CLR.W  $C880.W
        DC.W    $4278,$C882         ; $0130DA CLR.W  $C882.W
        DC.W    $4278,$8000         ; $0130DE CLR.W  $8000.W
        DC.W    $4278,$8002         ; $0130E2 CLR.W  $8002.W
        DC.W    $4278,$A012         ; $0130E6 CLR.W  $A012.W
        DC.W    $4238,$A018         ; $0130EA CLR.B  $A018.W
        DC.W    $4EB9,$0088,$49AA   ; $0130EE JSR     $008849AA
        DC.W    $21FC,$008B,$B57C,$C96C; $0130F4 MOVE.L  #$008BB57C,$C96C.W
        DC.W    $11FC,$0001,$C809   ; $0130FC MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $013102 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $013108 BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $01310E MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0001,$A028   ; $013114 MOVE.W  #$0001,$A028.W
        DC.W    $41F9,$00FF,$1000   ; $01311A LEA     $00FF1000,A0
        DC.W    $303C,$037F         ; $013120 MOVE.W  #$037F,D0
loc_013124:
        DC.W    $4298               ; $013124 CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $013126 DBRA    D0,loc_013124
        DC.W    $303C,$0001         ; $01312A MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $01312E MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $013132 MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $013136 MOVE.W  #$0026,D3
        DC.W    $383C,$001A         ; $01313A MOVE.W  #$001A,D4
        DC.W    $41F9,$00FF,$1000   ; $01313E LEA     $00FF1000,A0
        DC.W    $4EBA,$B0E6         ; $013144 JSR     $00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $013148 LEA     $00FF1000,A0
        DC.W    $4EBA,$B1A0         ; $01314E JSR     $00E2F0(PC)
        DC.W    $4EBA,$B068         ; $013152 JSR     $00E1BC(PC)
        DC.W    $08B9,$0007,$00A1,$5181; $013156 BCLR    #7,$00A15181
        DC.W    $41F9,$00FF,$6E00   ; $01315E LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0160   ; $013164 ADDA.L  #$00000160,A0
        DC.W    $43F9,$0089,$3292   ; $01316A LEA     $00893292,A1
        DC.W    $303C,$003F         ; $013170 MOVE.W  #$003F,D0
loc_013174:
        DC.W    $3219               ; $013174 MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $013176 BSET    #15,D1
        DC.W    $30C1               ; $01317A MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $01317C DBRA    D0,loc_013174
        DC.W    $41F9,$00FF,$6E00   ; $013180 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0020   ; $013186 ADDA.L  #$00000020,A0
        DC.W    $30BC,$0000         ; $01318C MOVE.W  #$0000,(A0)
        DC.W    $41F9,$000E,$EB30   ; $013190 LEA     $000EEB30,A0
        DC.W    $227C,$0601,$8000   ; $013196 MOVEA.L #$06018000,A1
        DC.W    $4EBA,$B178         ; $01319C JSR     $00E316(PC)
        DC.W    $41F9,$000E,$EDD0   ; $0131A0 LEA     $000EEDD0,A0
        DC.W    $227C,$0601,$AD00   ; $0131A6 MOVEA.L #$0601AD00,A1
        DC.W    $4EBA,$B168         ; $0131AC JSR     $00E316(PC)
        DC.W    $41F9,$000E,$F210   ; $0131B0 LEA     $000EF210,A0
        DC.W    $227C,$0601,$DA00   ; $0131B6 MOVEA.L #$0601DA00,A1
        DC.W    $4EBA,$B158         ; $0131BC JSR     $00E316(PC)
        DC.W    $41F9,$000E,$F780   ; $0131C0 LEA     $000EF780,A0
        DC.W    $227C,$0601,$ED00   ; $0131C6 MOVEA.L #$0601ED00,A1
        DC.W    $4EBA,$B148         ; $0131CC JSR     $00E316(PC)
        DC.W    $41F9,$000F,$0C00   ; $0131D0 LEA     $000F0C00,A0
        DC.W    $227C,$0602,$B780   ; $0131D6 MOVEA.L #$0602B780,A1
        DC.W    $4EBA,$B138         ; $0131DC JSR     $00E316(PC)
        DC.W    $41F9,$000F,$1570   ; $0131E0 LEA     $000F1570,A0
        DC.W    $227C,$0603,$0C00   ; $0131E6 MOVEA.L #$06030C00,A1
        DC.W    $4EBA,$B128         ; $0131EC JSR     $00E316(PC)
        DC.W    $41F9,$000E,$F530   ; $0131F0 LEA     $000EF530,A0
        DC.W    $227C,$0603,$6100   ; $0131F6 MOVEA.L #$06036100,A1
        DC.W    $4EBA,$B118         ; $0131FC JSR     $00E316(PC)
        DC.W    $4240               ; $013200 CLR.W  D0
        DC.W    $1038,$FDA9         ; $013202 MOVE.B  $FDA9.W,D0
        DC.W    $31C0,$A01A         ; $013206 MOVE.W  D0,$A01A.W
        DC.W    $31FC,$0000,$A01C   ; $01320A MOVE.W  #$0000,$A01C.W
        DC.W    $31FC,$0000,$A01E   ; $013210 MOVE.W  #$0000,$A01E.W
        DC.W    $31FC,$0000,$A020   ; $013216 MOVE.W  #$0000,$A020.W
        DC.W    $31FC,$0000,$A022   ; $01321C MOVE.W  #$0000,$A022.W
        DC.W    $33FC,$000F,$00FF,$2100; $013222 MOVE.W  #$000F,$00FF2100
        DC.W    $31F9,$00FF,$2100,$A024; $01322A MOVE.W  $00FF2100,$A024.W
        DC.W    $31FC,$0001,$A026   ; $013232 MOVE.W  #$0001,$A026.W
        DC.W    $4EB9,$0088,$204A   ; $013238 JSR     $0088204A
        DC.W    $11FC,$0001,$C821   ; $01323E MOVE.B  #$0001,$C821.W
        DC.W    $0239,$00FC,$00A1,$5181; $013244 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $01324C ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $013254 MOVE.W  #$8083,$00A15100
        DC.W    $4EB9,$0088,$205E   ; $01325C JSR     $0088205E
        DC.W    $4EB9,$0088,$2080   ; $013262 JSR     $00882080
        DC.W    $08F8,$0006,$C875   ; $013268 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $01326E MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0018,$00FF,$0008; $013272 MOVE.W  #$0018,$00FF0008
        DC.W    $4EB9,$0088,$4998   ; $01327A JSR     $00884998
        DC.W    $31FC,$0000,$C87E   ; $013280 MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0089,$3312,$00FF,$0002; $013286 MOVE.L  #$00893312,$00FF0002
        DC.W    $4E75               ; $013290 RTS
        DC.W    $7FFF               ; $013292 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013294 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013296 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013298 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01329A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01329C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01329E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132A8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $4DC8               ; $0132AA LEA     A0,A6
        DC.W    $520B               ; $0132AC ADDQ.B  #1,A3
        DC.W    $5A6E,$62D1         ; $0132AE ADDQ.W  #5,$62D1(A6)
        DC.W    $4DC8               ; $0132B2 LEA     A0,A6
        DC.W    $520B               ; $0132B4 ADDQ.B  #1,A3
        DC.W    $5A6E,$62D1         ; $0132B6 ADDQ.W  #5,$62D1(A6)
        DC.W    $4DC8               ; $0132BA LEA     A0,A6
        DC.W    $520B               ; $0132BC ADDQ.B  #1,A3
        DC.W    $5A6E,$62D1         ; $0132BE ADDQ.W  #5,$62D1(A6)
        DC.W    $4DC8               ; $0132C2 LEA     A0,A6
        DC.W    $520B               ; $0132C4 ADDQ.B  #1,A3
        DC.W    $5A6E,$62D1         ; $0132C6 ADDQ.W  #5,$62D1(A6)
        DC.W    $4DC8               ; $0132CA LEA     A0,A6
        DC.W    $520B               ; $0132CC ADDQ.B  #1,A3
        DC.W    $5A6E,$62D1         ; $0132CE ADDQ.W  #5,$62D1(A6)
        DC.W    $31CA,$35EB         ; $0132D2 MOVE.W  A2,$35EB.W
        DC.W    $3E2D,$466F         ; $0132D6 MOVE.W  $466F(A5),D7
        DC.W    $7FFF               ; $0132DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0132E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $31CA,$35EB         ; $0132EA MOVE.W  A2,$35EB.W
        DC.W    $3E2D,$466F         ; $0132EE MOVE.W  $466F(A5),D7
        DC.W    $14C1               ; $0132F2 MOVE.B  D1,(A2)+
        DC.W    $1D22               ; $0132F4 MOVE.B  -(A2),-(A6)
        DC.W    $2984,$35E6         ; $0132F6 MOVE.L  D4,-$1A(A4,D3.W)
loc_0132FA:
        DC.W    $4445               ; $0132FA NEG.W  D5
        DC.W    $512B,$6212         ; $0132FC SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $013300 BGT.S  loc_0132FA
        DC.W    $7FFF               ; $013302 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $031F               ; $013304 BTST    D1,(A7)+
        DC.W    $7FFF               ; $013306 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013308 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $14C1               ; $01330A MOVE.B  D1,(A2)+
        DC.W    $1D22               ; $01330C MOVE.B  -(A2),-(A6)
        DC.W    $2984,$35E6         ; $01330E MOVE.L  D4,-$1A(A4,D3.W)
        DC.W    $4EB9,$0088,$2080   ; $013312 JSR     $00882080
        DC.W    $3038,$C87E         ; $013318 MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $01331C MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $013320 JMP     (A1)
        DC.W    $0089,$3346,$0089   ; $013322 ORI.L  #$33460089,A1
        DC.W    $34F0,$0089         ; $013328 MOVE.W  -$77(A0,D0.W),(A2)+
        DC.W    $3824               ; $01332C MOVE.W  -(A4),D4
        DC.W    $4EBA,$8354         ; $01332E JSR     $00B684(PC)
        DC.W    $0838,$0006,$C80E   ; $013332 BTST    #6,$C80E.W
        DC.W    $6604               ; $013338 BNE.S  loc_01333E
        DC.W    $5878,$C87E         ; $01333A ADDQ.W  #4,$C87E.W
loc_01333E:
        DC.W    $4EB9,$0088,$205E   ; $01333E JSR     $0088205E
        DC.W    $4E75               ; $013344 RTS
        DC.W    $4240               ; $013346 CLR.W  D0
        DC.W    $4EBA,$B1E2         ; $013348 JSR     $00E52C(PC)
        DC.W    $207C,$0601,$8000   ; $01334C MOVEA.L #$06018000,A0
        DC.W    $227C,$0400,$4C74   ; $013352 MOVEA.L #$04004C74,A1
        DC.W    $303C,$0058         ; $013358 MOVE.W  #$0058,D0
        DC.W    $323C,$0010         ; $01335C MOVE.W  #$0010,D1
        DC.W    $4EBA,$AFF8         ; $013360 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$AD00   ; $013364 MOVEA.L #$0601AD00,A0
        DC.W    $227C,$0400,$9038   ; $01336A MOVEA.L #$04009038,A1
        DC.W    $303C,$0048         ; $013370 MOVE.W  #$0048,D0
        DC.W    $323C,$00A0         ; $013374 MOVE.W  #$00A0,D1
        DC.W    $4EBA,$AFE0         ; $013378 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$DA00   ; $01337C MOVEA.L #$0601DA00,A0
        DC.W    $227C,$0401,$5088   ; $013382 MOVEA.L #$04015088,A1
        DC.W    $303C,$0098         ; $013388 MOVE.W  #$0098,D0
        DC.W    $323C,$0020         ; $01338C MOVE.W  #$0020,D1
        DC.W    $4EBA,$AFC8         ; $013390 JSR     $00E35A(PC)
        DC.W    $41F9,$0089,$ABEE   ; $013394 LEA     $0089ABEE,A0
        DC.W    $3038,$A01A         ; $01339A MOVE.W  $A01A.W,D0
        DC.W    $D040               ; $01339E ADD.W  D0,D0
        DC.W    $D040               ; $0133A0 ADD.W  D0,D0
        DC.W    $2070,$0000         ; $0133A2 MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0400,$9088   ; $0133A6 MOVEA.L #$04009088,A1
        DC.W    $303C,$0040         ; $0133AC MOVE.W  #$0040,D0
        DC.W    $323C,$0010         ; $0133B0 MOVE.W  #$0010,D1
        DC.W    $4EBA,$AFA4         ; $0133B4 JSR     $00E35A(PC)
        DC.W    $41F9,$0089,$ABFA   ; $0133B8 LEA     $0089ABFA,A0
        DC.W    $3038,$A01C         ; $0133BE MOVE.W  $A01C.W,D0
        DC.W    $D040               ; $0133C2 ADD.W  D0,D0
        DC.W    $D040               ; $0133C4 ADD.W  D0,D0
        DC.W    $2070,$0000         ; $0133C6 MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0400,$C088   ; $0133CA MOVEA.L #$0400C088,A1
        DC.W    $303C,$0078         ; $0133D0 MOVE.W  #$0078,D0
        DC.W    $323C,$0010         ; $0133D4 MOVE.W  #$0010,D1
        DC.W    $4EBA,$AF80         ; $0133D8 JSR     $00E35A(PC)
        DC.W    $41F9,$0089,$AC7C   ; $0133DC LEA     $0089AC7C,A0
        DC.W    $3038,$A01E         ; $0133E2 MOVE.W  $A01E.W,D0
        DC.W    $D040               ; $0133E6 ADD.W  D0,D0
        DC.W    $D040               ; $0133E8 ADD.W  D0,D0
        DC.W    $2070,$0000         ; $0133EA MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0400,$F088   ; $0133EE MOVEA.L #$0400F088,A1
        DC.W    $303C,$0068         ; $0133F4 MOVE.W  #$0068,D0
        DC.W    $323C,$0010         ; $0133F8 MOVE.W  #$0010,D1
        DC.W    $4EBA,$AF5C         ; $0133FC JSR     $00E35A(PC)
        DC.W    $41F9,$0089,$ACBE   ; $013400 LEA     $0089ACBE,A0
        DC.W    $3038,$A020         ; $013406 MOVE.W  $A020.W,D0
        DC.W    $D040               ; $01340A ADD.W  D0,D0
        DC.W    $D040               ; $01340C ADD.W  D0,D0
        DC.W    $2070,$0000         ; $01340E MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0401,$2088   ; $013412 MOVEA.L #$04012088,A1
        DC.W    $303C,$0088         ; $013418 MOVE.W  #$0088,D0
        DC.W    $323C,$0010         ; $01341C MOVE.W  #$0010,D1
        DC.W    $4EBA,$AF38         ; $013420 JSR     $00E35A(PC)
        DC.W    $4A78,$A026         ; $013424 TST.W  $A026.W
        DC.W    $672C               ; $013428 BEQ.S  loc_013456
        DC.W    $7000               ; $01342A MOVEQ   #$00,D0
        DC.W    $1038,$A019         ; $01342C MOVE.B  $A019.W,D0
        DC.W    $43F9,$0089,$34C8   ; $013430 LEA     $008934C8,A1
        DC.W    $D040               ; $013436 ADD.W  D0,D0
        DC.W    $D040               ; $013438 ADD.W  D0,D0
        DC.W    $2071,$0000         ; $01343A MOVEA.L $00(A1,D0.W),A0
        DC.W    $303C,$0048         ; $01343E MOVE.W  #$0048,D0
        DC.W    $323C,$0010         ; $013442 MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $013446 MOVE.W  #$0010,D2
loc_01344A:
        DC.W    $4A39,$00A1,$5120   ; $01344A TST.B  $00A15120
        DC.W    $66F8               ; $013450 BNE.S  loc_01344A
        DC.W    $4EBA,$AF60         ; $013452 JSR     $00E3B4(PC)
loc_013456:
        DC.W    $43F9,$00FF,$6E00   ; $013456 LEA     $00FF6E00,A1
        DC.W    $D3FC,$0000,$0178   ; $01345C ADDA.L  #$00000178,A1
        DC.W    $343C,$0004         ; $013462 MOVE.W  #$0004,D2
loc_013466:
        DC.W    $41F9,$0089,$34E8   ; $013466 LEA     $008934E8,A0
        DC.W    $32D8               ; $01346C MOVE.W  (A0)+,(A1)+
        DC.W    $32D8               ; $01346E MOVE.W  (A0)+,(A1)+
        DC.W    $32D8               ; $013470 MOVE.W  (A0)+,(A1)+
        DC.W    $32D0               ; $013472 MOVE.W  (A0),(A1)+
        DC.W    $51CA,$FFF0         ; $013474 DBRA    D2,loc_013466
        DC.W    $4A78,$A026         ; $013478 TST.W  $A026.W
        DC.W    $6736               ; $01347C BEQ.S  loc_0134B4
        DC.W    $0C38,$0005,$A019   ; $01347E CMPI.B  #$0005,$A019.W
        DC.W    $672E               ; $013484 BEQ.S  loc_0134B4
        DC.W    $4240               ; $013486 CLR.W  D0
        DC.W    $1038,$A019         ; $013488 MOVE.B  $A019.W,D0
        DC.W    $D040               ; $01348C ADD.W  D0,D0
        DC.W    $D040               ; $01348E ADD.W  D0,D0
        DC.W    $D040               ; $013490 ADD.W  D0,D0
        DC.W    $43F9,$00FF,$6E00   ; $013492 LEA     $00FF6E00,A1
        DC.W    $D3FC,$0000,$0178   ; $013498 ADDA.L  #$00000178,A1
        DC.W    $41F9,$0089,$34E0   ; $01349E LEA     $008934E0,A0
        DC.W    $3398,$0000         ; $0134A4 MOVE.W  (A0)+,$00(A1,D0.W)
        DC.W    $3398,$0002         ; $0134A8 MOVE.W  (A0)+,$02(A1,D0.W)
        DC.W    $3398,$0004         ; $0134AC MOVE.W  (A0)+,$04(A1,D0.W)
        DC.W    $3390,$0006         ; $0134B0 MOVE.W  (A0),$06(A1,D0.W)
loc_0134B4:
        DC.W    $11FC,$0001,$C821   ; $0134B4 MOVE.B  #$0001,$C821.W
        DC.W    $5878,$C87E         ; $0134BA ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $0134BE MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $0134C6 RTS
        DC.W    $0400,$9038         ; $0134C8 SUBI.B  #$9038,D0
        DC.W    $0400,$C038         ; $0134CC SUBI.B  #$C038,D0
        DC.W    $0400,$F038         ; $0134D0 SUBI.B  #$F038,D0
        DC.W    $0401,$2038         ; $0134D4 SUBI.B  #$2038,D1
        DC.W    $0401,$5038         ; $0134D8 SUBI.B  #$5038,D1
        DC.W    $0401,$B038         ; $0134DC SUBI.B  #$B038,D1
        DC.W    $9C00               ; $0134E0 SUB.B  D0,D6
        DC.W    $A8A3               ; $0134E2 MOVE.L  -(A3),(A4)
        DC.W    $B546               ; $0134E4 EOR.W  D2,D6
        DC.W    $C1E9,$CDC8         ; $0134E6 MULS    -$3238(A1),D0
        DC.W    $D20B               ; $0134EA ADD.B  A3,D1
        DC.W    $DA6E,$E2D1         ; $0134EC ADD.W  -$1D2F(A6),D5
        DC.W    $4240               ; $0134F0 CLR.W  D0
        DC.W    $4EBA,$B038         ; $0134F2 JSR     $00E52C(PC)
        DC.W    $4EBA,$818C         ; $0134F6 JSR     $00B684(PC)
        DC.W    $4EBA,$81DE         ; $0134FA JSR     $00B6DA(PC)
        DC.W    $0C78,$0001,$A028   ; $0134FE CMPI.W  #$0001,$A028.W
        DC.W    $6700,$007C         ; $013504 BEQ.W  loc_013582
        DC.W    $0C78,$0002,$A028   ; $013508 CMPI.W  #$0002,$A028.W
        DC.W    $6700,$0088         ; $01350E BEQ.W  loc_013598
        DC.W    $4EB9,$0088,$179E   ; $013512 JSR     $0088179E
        DC.W    $3238,$C86C         ; $013518 MOVE.W  $C86C.W,D1
        DC.W    $6100,$00A6         ; $01351C BSR.W  loc_0135C4
        DC.W    $3238,$C86E         ; $013520 MOVE.W  $C86E.W,D1
        DC.W    $6100,$009E         ; $013524 BSR.W  loc_0135C4
        DC.W    $4A78,$A022         ; $013528 TST.W  $A022.W
        DC.W    $6700,$0084         ; $01352C BEQ.W  loc_0135B2
        DC.W    $0C78,$0001,$A022   ; $013530 CMPI.W  #$0001,$A022.W
        DC.W    $6600,$002A         ; $013536 BNE.W  loc_013562
        DC.W    $11FC,$0001,$C809   ; $01353A MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $013540 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $013546 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $01354C MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $013552 JSR     $0088205E
        DC.W    $31FC,$0002,$A028   ; $013558 MOVE.W  #$0002,$A028.W
        DC.W    $6000,$0056         ; $01355E BRA.W  loc_0135B6
loc_013562:
        DC.W    $4240               ; $013562 CLR.W  D0
        DC.W    $41F9,$0089,$36AA   ; $013564 LEA     $008936AA,A0
        DC.W    $4242               ; $01356A CLR.W  D2
        DC.W    $1438,$A019         ; $01356C MOVE.B  $A019.W,D2
        DC.W    $D442               ; $013570 ADD.W  D2,D2
        DC.W    $D442               ; $013572 ADD.W  D2,D2
        DC.W    $2070,$2000         ; $013574 MOVEA.L $00(A0,D2.W),A0
        DC.W    $343C,$0001         ; $013578 MOVE.W  #$0001,D2
        DC.W    $4E90               ; $01357C JSR     (A0)
        DC.W    $6000,$0036         ; $01357E BRA.W  loc_0135B6
loc_013582:
        DC.W    $4EB9,$0088,$FB36   ; $013582 JSR     $0088FB36
        DC.W    $0838,$0006,$C80E   ; $013588 BTST    #6,$C80E.W
        DC.W    $6622               ; $01358E BNE.S  loc_0135B2
        DC.W    $4278,$A028         ; $013590 CLR.W  $A028.W
        DC.W    $6000,$001C         ; $013594 BRA.W  loc_0135B2
loc_013598:
        DC.W    $4EB9,$0088,$FB36   ; $013598 JSR     $0088FB36
        DC.W    $0838,$0007,$C80E   ; $01359E BTST    #7,$C80E.W
        DC.W    $660C               ; $0135A4 BNE.S  loc_0135B2
        DC.W    $4278,$A028         ; $0135A6 CLR.W  $A028.W
        DC.W    $5878,$C87E         ; $0135AA ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $0135AE BRA.W  loc_0135B6
loc_0135B2:
        DC.W    $5978,$C87E         ; $0135B2 SUBQ.W  #4,$C87E.W
loc_0135B6:
        DC.W    $4278,$A022         ; $0135B6 CLR.W  $A022.W
        DC.W    $33FC,$0018,$00FF,$0008; $0135BA MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $0135C2 RTS
loc_0135C4:
        DC.W    $3401               ; $0135C4 MOVE.W  D1,D2
        DC.W    $0202,$00F0         ; $0135C6 ANDI.B  #$00F0,D2
        DC.W    $6600,$00A6         ; $0135CA BNE.W  loc_013672
        DC.W    $0801,$0000         ; $0135CE BTST    #0,D1
        DC.W    $671E               ; $0135D2 BEQ.S  loc_0135F2
        DC.W    $4EB9,$0088,$205E   ; $0135D4 JSR     $0088205E
        DC.W    $11FC,$00A9,$C8A4   ; $0135DA MOVE.B  #$00A9,$C8A4.W
        DC.W    $5338,$A019         ; $0135E0 SUBQ.B  #1,$A019.W
        DC.W    $6400,$00AA         ; $0135E4 BCC.W  loc_013690
        DC.W    $11FC,$0005,$A019   ; $0135E8 MOVE.B  #$0005,$A019.W
        DC.W    $6000,$00A0         ; $0135EE BRA.W  loc_013690
loc_0135F2:
        DC.W    $0801,$0001         ; $0135F2 BTST    #1,D1
        DC.W    $6722               ; $0135F6 BEQ.S  loc_01361A
        DC.W    $4EB9,$0088,$205E   ; $0135F8 JSR     $0088205E
        DC.W    $11FC,$00A9,$C8A4   ; $0135FE MOVE.B  #$00A9,$C8A4.W
        DC.W    $5238,$A019         ; $013604 ADDQ.B  #1,$A019.W
        DC.W    $0C38,$0005,$A019   ; $013608 CMPI.B  #$0005,$A019.W
        DC.W    $6F00,$0080         ; $01360E BLE.W  loc_013690
        DC.W    $4238,$A019         ; $013612 CLR.B  $A019.W
        DC.W    $6000,$0078         ; $013616 BRA.W  loc_013690
loc_01361A:
        DC.W    $0801,$0002         ; $01361A BTST    #2,D1
        DC.W    $6726               ; $01361E BEQ.S  loc_013646
        DC.W    $11FC,$00A9,$C8A4   ; $013620 MOVE.B  #$00A9,$C8A4.W
        DC.W    $303C,$FFFF         ; $013626 MOVE.W  #$FFFF,D0
        DC.W    $41F9,$0089,$36AA   ; $01362A LEA     $008936AA,A0
        DC.W    $4242               ; $013630 CLR.W  D2
        DC.W    $1438,$A019         ; $013632 MOVE.B  $A019.W,D2
        DC.W    $D442               ; $013636 ADD.W  D2,D2
        DC.W    $D442               ; $013638 ADD.W  D2,D2
        DC.W    $2070,$2000         ; $01363A MOVEA.L $00(A0,D2.W),A0
        DC.W    $4242               ; $01363E CLR.W  D2
        DC.W    $4E90               ; $013640 JSR     (A0)
        DC.W    $6000,$004C         ; $013642 BRA.W  loc_013690
loc_013646:
        DC.W    $0801,$0003         ; $013646 BTST    #3,D1
        DC.W    $6744               ; $01364A BEQ.S  loc_013690
        DC.W    $11FC,$00A9,$C8A4   ; $01364C MOVE.B  #$00A9,$C8A4.W
        DC.W    $303C,$0001         ; $013652 MOVE.W  #$0001,D0
        DC.W    $41F9,$0089,$36AA   ; $013656 LEA     $008936AA,A0
        DC.W    $4242               ; $01365C CLR.W  D2
        DC.W    $1438,$A019         ; $01365E MOVE.B  $A019.W,D2
        DC.W    $D442               ; $013662 ADD.W  D2,D2
        DC.W    $D442               ; $013664 ADD.W  D2,D2
        DC.W    $2070,$2000         ; $013666 MOVEA.L $00(A0,D2.W),A0
        DC.W    $4242               ; $01366A CLR.W  D2
        DC.W    $4E90               ; $01366C JSR     (A0)
        DC.W    $6000,$0020         ; $01366E BRA.W  loc_013690
loc_013672:
        DC.W    $31FC,$0001,$A022   ; $013672 MOVE.W  #$0001,$A022.W
        DC.W    $0801,$0007         ; $013678 BTST    #7,D1
        DC.W    $6612               ; $01367C BNE.S  loc_013690
        DC.W    $31FC,$0002,$A022   ; $01367E MOVE.W  #$0002,$A022.W
        DC.W    $0801,$0004         ; $013684 BTST    #4,D1
        DC.W    $6706               ; $013688 BEQ.S  loc_013690
        DC.W    $31FC,$0003,$A022   ; $01368A MOVE.W  #$0003,$A022.W
loc_013690:
        DC.W    $5378,$A024         ; $013690 SUBQ.W  #1,$A024.W
        DC.W    $6400,$0012         ; $013694 BCC.W  loc_0136A8
        DC.W    $31F9,$00FF,$2100,$A024; $013698 MOVE.W  $00FF2100,$A024.W
        DC.W    $5378,$A026         ; $0136A0 SUBQ.W  #1,$A026.W
        DC.W    $4478,$A026         ; $0136A4 NEG.W  $A026.W
loc_0136A8:
        DC.W    $4E75               ; $0136A8 RTS
        DC.W    $0089,$36C2,$0089   ; $0136AA ORI.L  #$36C20089,A1
        DC.W    $36EA,$0089         ; $0136B0 MOVE.W  $0089(A2),(A3)+
        DC.W    $3734,$0089         ; $0136B4 MOVE.W  -$77(A4,D0.W),-(A3)
        DC.W    $377A,$0089,$37C0   ; $0136B8 MOVE.W  $0089(PC),$37C0(A3)
        DC.W    $0089,$37F4,$4A42   ; $0136BE ORI.L  #$37F44A42,A1
        DC.W    $661E               ; $0136C4 BNE.S  loc_0136E4
        DC.W    $D178,$A01A         ; $0136C6 ADD.W  D0,$A01A.W
        DC.W    $4A78,$A01A         ; $0136CA TST.W  $A01A.W
        DC.W    $6C06               ; $0136CE BGE.S  loc_0136D6
        DC.W    $31FC,$0002,$A01A   ; $0136D0 MOVE.W  #$0002,$A01A.W
loc_0136D6:
        DC.W    $0C78,$0002,$A01A   ; $0136D6 CMPI.W  #$0002,$A01A.W
        DC.W    $6F0A               ; $0136DC BLE.S  loc_0136E8
        DC.W    $4278,$A01A         ; $0136DE CLR.W  $A01A.W
        DC.W    $6004               ; $0136E2 BRA.S  loc_0136E8
loc_0136E4:
        DC.W    $5978,$C87E         ; $0136E4 SUBQ.W  #4,$C87E.W
loc_0136E8:
        DC.W    $4E75               ; $0136E8 RTS
        DC.W    $4A42               ; $0136EA TST.W  D2
        DC.W    $661E               ; $0136EC BNE.S  loc_01370C
        DC.W    $D178,$A01C         ; $0136EE ADD.W  D0,$A01C.W
        DC.W    $4A78,$A01C         ; $0136F2 TST.W  $A01C.W
        DC.W    $6C06               ; $0136F6 BGE.S  loc_0136FE
        DC.W    $31FC,$0019,$A01C   ; $0136F8 MOVE.W  #$0019,$A01C.W
loc_0136FE:
        DC.W    $0C78,$0019,$A01C   ; $0136FE CMPI.W  #$0019,$A01C.W
        DC.W    $6F2C               ; $013704 BLE.S  loc_013732
        DC.W    $4278,$A01C         ; $013706 CLR.W  $A01C.W
        DC.W    $6026               ; $01370A BRA.S  loc_013732
loc_01370C:
        DC.W    $0C78,$0002,$A022   ; $01370C CMPI.W  #$0002,$A022.W
        DC.W    $6706               ; $013712 BEQ.S  loc_01371A
        DC.W    $11FC,$00F3,$C822   ; $013714 MOVE.B  #$00F3,$C822.W
loc_01371A:
        DC.W    $4238,$C8A7         ; $01371A CLR.B  $C8A7.W
        DC.W    $41F9,$0089,$AC62   ; $01371E LEA     $0089AC62,A0
        DC.W    $3038,$A01C         ; $013724 MOVE.W  $A01C.W,D0
        DC.W    $11F0,$0000,$C8A5   ; $013728 MOVE.B  $00(A0,D0.W),$C8A5.W
        DC.W    $5978,$C87E         ; $01372E SUBQ.W  #4,$C87E.W
loc_013732:
        DC.W    $4E75               ; $013732 RTS
        DC.W    $4A42               ; $013734 TST.W  D2
        DC.W    $661E               ; $013736 BNE.S  loc_013756
        DC.W    $D178,$A01E         ; $013738 ADD.W  D0,$A01E.W
        DC.W    $4A78,$A01E         ; $01373C TST.W  $A01E.W
        DC.W    $6C06               ; $013740 BGE.S  loc_013748
        DC.W    $31FC,$000C,$A01E   ; $013742 MOVE.W  #$000C,$A01E.W
loc_013748:
        DC.W    $0C78,$000C,$A01E   ; $013748 CMPI.W  #$000C,$A01E.W
        DC.W    $6F28               ; $01374E BLE.S  loc_013778
        DC.W    $4278,$A01E         ; $013750 CLR.W  $A01E.W
        DC.W    $6022               ; $013754 BRA.S  loc_013778
loc_013756:
        DC.W    $0C78,$0002,$A022   ; $013756 CMPI.W  #$0002,$A022.W
        DC.W    $6706               ; $01375C BEQ.S  loc_013764
        DC.W    $11FC,$00CA,$C822   ; $01375E MOVE.B  #$00CA,$C822.W
loc_013764:
        DC.W    $41F9,$0089,$ACB0   ; $013764 LEA     $0089ACB0,A0
        DC.W    $3038,$A01E         ; $01376A MOVE.W  $A01E.W,D0
        DC.W    $11F0,$0000,$C8A4   ; $01376E MOVE.B  $00(A0,D0.W),$C8A4.W
        DC.W    $5978,$C87E         ; $013774 SUBQ.W  #4,$C87E.W
loc_013778:
        DC.W    $4E75               ; $013778 RTS
        DC.W    $4A42               ; $01377A TST.W  D2
        DC.W    $661E               ; $01377C BNE.S  loc_01379C
        DC.W    $D178,$A020         ; $01377E ADD.W  D0,$A020.W
        DC.W    $4A78,$A020         ; $013782 TST.W  $A020.W
        DC.W    $6C06               ; $013786 BGE.S  loc_01378E
        DC.W    $31FC,$0009,$A020   ; $013788 MOVE.W  #$0009,$A020.W
loc_01378E:
        DC.W    $0C78,$0009,$A020   ; $01378E CMPI.W  #$0009,$A020.W
        DC.W    $6F28               ; $013794 BLE.S  loc_0137BE
        DC.W    $4278,$A020         ; $013796 CLR.W  $A020.W
        DC.W    $6022               ; $01379A BRA.S  loc_0137BE
loc_01379C:
        DC.W    $0C78,$0002,$A022   ; $01379C CMPI.W  #$0002,$A022.W
        DC.W    $6706               ; $0137A2 BEQ.S  loc_0137AA
        DC.W    $11FC,$00CA,$C822   ; $0137A4 MOVE.B  #$00CA,$C822.W
loc_0137AA:
        DC.W    $41F9,$0089,$ACE6   ; $0137AA LEA     $0089ACE6,A0
        DC.W    $3038,$A020         ; $0137B0 MOVE.W  $A020.W,D0
        DC.W    $11F0,$0000,$C8A4   ; $0137B4 MOVE.B  $00(A0,D0.W),$C8A4.W
        DC.W    $5978,$C87E         ; $0137BA SUBQ.W  #4,$C87E.W
loc_0137BE:
        DC.W    $4E75               ; $0137BE RTS
        DC.W    $4A42               ; $0137C0 TST.W  D2
        DC.W    $672E               ; $0137C2 BEQ.S  loc_0137F2
        DC.W    $11FC,$00A8,$C8A4   ; $0137C4 MOVE.B  #$00A8,$C8A4.W
        DC.W    $50F8,$A018         ; $0137CA ST      $A018.W
        DC.W    $11FC,$0001,$C809   ; $0137CE MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $0137D4 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $0137DA BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $0137E0 MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $0137E6 JSR     $0088205E
        DC.W    $31FC,$0002,$A028   ; $0137EC MOVE.W  #$0002,$A028.W
loc_0137F2:
        DC.W    $4E75               ; $0137F2 RTS
        DC.W    $4A42               ; $0137F4 TST.W  D2
        DC.W    $672A               ; $0137F6 BEQ.S  loc_013822
        DC.W    $11FC,$00A8,$C8A4   ; $0137F8 MOVE.B  #$00A8,$C8A4.W
        DC.W    $11FC,$0001,$C809   ; $0137FE MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $013804 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $01380A BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $013810 MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $013816 JSR     $0088205E
        DC.W    $31FC,$0002,$A028   ; $01381C MOVE.W  #$0002,$A028.W
loc_013822:
        DC.W    $4E75               ; $013822 RTS
loc_013824:
        DC.W    $4A39,$00A1,$5120   ; $013824 TST.B  $00A15120
        DC.W    $66F8               ; $01382A BNE.S  loc_013824
        DC.W    $4239,$00A1,$5123   ; $01382C CLR.B  $00A15123
        DC.W    $3038,$A01A         ; $013832 MOVE.W  $A01A.W,D0
        DC.W    $11C0,$FDA9         ; $013836 MOVE.B  D0,$FDA9.W
        DC.W    $23FC,$0089,$3864,$00FF,$0002; $01383A MOVE.L  #$00893864,$00FF0002
        DC.W    $4A38,$A018         ; $013844 TST.B  $A018.W
        DC.W    $660A               ; $013848 BNE.S  loc_013854
        DC.W    $23FC,$0089,$26D2,$00FF,$0002; $01384A MOVE.L  #$008926D2,$00FF0002
loc_013854:
        DC.W    $31FC,$0000,$C87E   ; $013854 MOVE.W  #$0000,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $01385A MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $013862 RTS
        DC.W    $33FC,$002C,$00FF,$0008; $013864 MOVE.W  #$002C,$00FF0008
        DC.W    $31FC,$002C,$C87A   ; $01386C MOVE.W  #$002C,$C87A.W
        DC.W    $08B8,$0006,$C875   ; $013872 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $013878 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $01387C MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $013884 ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$26C8   ; $01388C JSR     $008826C8
        DC.W    $203C,$000A,$0907   ; $013892 MOVE.L  #$000A0907,D0
        DC.W    $4EB9,$0088,$14BE   ; $013898 JSR     $008814BE
        DC.W    $11FC,$0001,$C80D   ; $01389E MOVE.B  #$0001,$C80D.W
        DC.W    $7000               ; $0138A4 MOVEQ   #$00,D0
        DC.W    $41F8,$8480         ; $0138A6 LEA     $8480.W,A0
        DC.W    $721F               ; $0138AA MOVEQ   #$1F,D1
loc_0138AC:
        DC.W    $20C0               ; $0138AC MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $0138AE DBRA    D1,loc_0138AC
        DC.W    $41F9,$00FF,$7B80   ; $0138B2 LEA     $00FF7B80,A0
        DC.W    $727F               ; $0138B8 MOVEQ   #$7F,D1
loc_0138BA:
        DC.W    $20C0               ; $0138BA MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $0138BC DBRA    D1,loc_0138BA
        DC.W    $2ABC,$6000,$0002   ; $0138C0 MOVE.L  #$60000002,(A5)
        DC.W    $323C,$17FF         ; $0138C6 MOVE.W  #$17FF,D1
loc_0138CA:
        DC.W    $2C80               ; $0138CA MOVE.L  D0,(A6)
        DC.W    $51C9,$FFFC         ; $0138CC DBRA    D1,loc_0138CA
        DC.W    $4EB9,$0088,$49AA   ; $0138D0 JSR     $008849AA
        DC.W    $4278,$C880         ; $0138D6 CLR.W  $C880.W
        DC.W    $4278,$C882         ; $0138DA CLR.W  $C882.W
        DC.W    $4278,$8000         ; $0138DE CLR.W  $8000.W
        DC.W    $4278,$8002         ; $0138E2 CLR.W  $8002.W
        DC.W    $4278,$A012         ; $0138E6 CLR.W  $A012.W
        DC.W    $4238,$A018         ; $0138EA CLR.B  $A018.W
        DC.W    $4EB9,$0088,$49AA   ; $0138EE JSR     $008849AA
        DC.W    $21FC,$008B,$B57C,$C96C; $0138F4 MOVE.L  #$008BB57C,$C96C.W
        DC.W    $11FC,$0001,$C809   ; $0138FC MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $013902 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $013908 BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $01390E MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0001,$A024   ; $013914 MOVE.W  #$0001,$A024.W
        DC.W    $41F9,$00FF,$1000   ; $01391A LEA     $00FF1000,A0
        DC.W    $303C,$037F         ; $013920 MOVE.W  #$037F,D0
loc_013924:
        DC.W    $4298               ; $013924 CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $013926 DBRA    D0,loc_013924
        DC.W    $303C,$0001         ; $01392A MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $01392E MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $013932 MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $013936 MOVE.W  #$0026,D3
        DC.W    $383C,$001A         ; $01393A MOVE.W  #$001A,D4
        DC.W    $41F9,$00FF,$1000   ; $01393E LEA     $00FF1000,A0
        DC.W    $4EBA,$A8E6         ; $013944 JSR     $00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $013948 LEA     $00FF1000,A0
        DC.W    $4EBA,$A9A0         ; $01394E JSR     $00E2F0(PC)
        DC.W    $4EBA,$A868         ; $013952 JSR     $00E1BC(PC)
        DC.W    $08B9,$0007,$00A1,$5181; $013956 BCLR    #7,$00A15181
        DC.W    $41F9,$00FF,$6E00   ; $01395E LEA     $00FF6E00,A0
        DC.W    $43F9,$0089,$3A88   ; $013964 LEA     $00893A88,A1
        DC.W    $5488               ; $01396A ADDQ.L  #2,A0
        DC.W    $303C,$002E         ; $01396C MOVE.W  #$002E,D0
loc_013970:
        DC.W    $3219               ; $013970 MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $013972 BSET    #15,D1
        DC.W    $30C1               ; $013976 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $013978 DBRA    D0,loc_013970
        DC.W    $41F9,$00FF,$6E00   ; $01397C LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0140   ; $013982 ADDA.L  #$00000140,A0
        DC.W    $43F9,$0089,$3B06   ; $013988 LEA     $00893B06,A1
        DC.W    $303C,$005F         ; $01398E MOVE.W  #$005F,D0
loc_013992:
        DC.W    $3219               ; $013992 MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $013994 BSET    #15,D1
        DC.W    $30C1               ; $013998 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $01399A DBRA    D0,loc_013992
        DC.W    $41F9,$00FF,$6E00   ; $01399E LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0080   ; $0139A4 ADDA.L  #$00000080,A0
        DC.W    $30BC,$0000         ; $0139AA MOVE.W  #$0000,(A0)
        DC.W    $41F9,$00FF,$6E00   ; $0139AE LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0078   ; $0139B4 ADDA.L  #$00000078,A0
        DC.W    $30BC,$0000         ; $0139BA MOVE.W  #$0000,(A0)
        DC.W    $41F9,$000F,$35F0   ; $0139BE LEA     $000F35F0,A0
        DC.W    $227C,$0601,$4000   ; $0139C4 MOVEA.L #$06014000,A1
        DC.W    $4EBA,$A94A         ; $0139CA JSR     $00E316(PC)
        DC.W    $41F9,$000F,$30D0   ; $0139CE LEA     $000F30D0,A0
        DC.W    $0838,$0002,$C818   ; $0139D4 BTST    #2,$C818.W
        DC.W    $6614               ; $0139DA BNE.S  loc_0139F0
        DC.W    $41F9,$000F,$1DB0   ; $0139DC LEA     $000F1DB0,A0
        DC.W    $0838,$0000,$C818   ; $0139E2 BTST    #0,$C818.W
        DC.W    $6706               ; $0139E8 BEQ.S  loc_0139F0
        DC.W    $41F9,$000F,$2710   ; $0139EA LEA     $000F2710,A0
loc_0139F0:
        DC.W    $227C,$0601,$7CC0   ; $0139F0 MOVEA.L #$06017CC0,A1
        DC.W    $4EBA,$A91E         ; $0139F6 JSR     $00E316(PC)
        DC.W    $41F9,$000F,$30D0   ; $0139FA LEA     $000F30D0,A0
        DC.W    $0838,$0003,$C818   ; $013A00 BTST    #3,$C818.W
        DC.W    $6614               ; $013A06 BNE.S  loc_013A1C
        DC.W    $41F9,$000F,$1DB0   ; $013A08 LEA     $000F1DB0,A0
        DC.W    $0838,$0001,$C818   ; $013A0E BTST    #1,$C818.W
        DC.W    $6706               ; $013A14 BEQ.S  loc_013A1C
        DC.W    $41F9,$000F,$2710   ; $013A16 LEA     $000F2710,A0
loc_013A1C:
        DC.W    $227C,$0601,$DFC0   ; $013A1C MOVEA.L #$0601DFC0,A1
        DC.W    $4EBA,$A8F2         ; $013A22 JSR     $00E316(PC)
        DC.W    $4238,$A019         ; $013A26 CLR.B  $A019.W
        DC.W    $4238,$A01A         ; $013A2A CLR.B  $A01A.W
        DC.W    $4278,$A01E         ; $013A2E CLR.W  $A01E.W
        DC.W    $4278,$A020         ; $013A32 CLR.W  $A020.W
        DC.W    $4278,$A022         ; $013A36 CLR.W  $A022.W
        DC.W    $4EB9,$0088,$204A   ; $013A3A JSR     $0088204A
        DC.W    $11FC,$0001,$C821   ; $013A40 MOVE.B  #$0001,$C821.W
        DC.W    $0239,$00FC,$00A1,$5181; $013A46 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $013A4E ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $013A56 MOVE.W  #$8083,$00A15100
        DC.W    $08F8,$0006,$C875   ; $013A5E BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $013A64 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0018,$00FF,$0008; $013A68 MOVE.W  #$0018,$00FF0008
        DC.W    $4EB9,$0088,$4998   ; $013A70 JSR     $00884998
        DC.W    $31FC,$0000,$C87E   ; $013A76 MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0089,$3BC6,$00FF,$0002; $013A7C MOVE.L  #$00893BC6,$00FF0002
        DC.W    $4E75               ; $013A86 RTS
        DC.W    $0000,$0421         ; $013A88 ORI.B  #$0421,D0
        DC.W    $0842,$0C63         ; $013A8C BCHG    #3,D2
        DC.W    $1084               ; $013A90 MOVE.B  D4,(A0)
        DC.W    $14A5               ; $013A92 MOVE.B  -(A5),(A2)
        DC.W    $18C6               ; $013A94 MOVE.B  D6,(A4)+
        DC.W    $1CE7               ; $013A96 MOVE.B  -(A7),(A6)+
        DC.W    $2108               ; $013A98 MOVE.L  A0,-(A0)
        DC.W    $2529,$294A         ; $013A9A MOVE.L  $294A(A1),-(A2)
        DC.W    $2D6B,$318C,$35AD   ; $013A9E MOVE.L  $318C(A3),$35AD(A6)
        DC.W    $39CE,$3DEF         ; $013AA4 MOVE.W  A6,#$3DEF
        DC.W    $4210               ; $013AA8 CLR.B  (A0)
        DC.W    $4631,$4A52         ; $013AAA NOT.B  $52(A1,D4.L)
        DC.W    $4E73               ; $013AAE RTE
        DC.W    $7FFF               ; $013AB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $56B5,$5AD6         ; $013AB2 ADDQ.L  #3,-$2A(A5,D5.L)
        DC.W    $5EF7,$6318         ; $013AB6 SGT     $18(A7,D6.W)
        DC.W    $6739               ; $013ABA BEQ.S  loc_013AF5
loc_013ABC:
        DC.W    $6B5A               ; $013ABC BMI.S  loc_013B18
        DC.W    $7FFF               ; $013ABE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $739C,$77BD         ; $013AC0 MOVE.W  (A4)+,-$43(A1,D7.W)
        DC.W    $7BDE               ; $013AC4 MOVE.W  (A6)+,<EA:3D>
        DC.W    $7FFF               ; $013AC6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7E2C               ; $013AC8 MOVEQ   #$2C,D7
        DC.W    $7F97,$7F55         ; $013ACA MOVE.W  (A7),$55(A7,D7.L)
        DC.W    $7F13               ; $013ACE MOVE.W  (A3),-(A7)
        DC.W    $7E8F               ; $013AD0 MOVEQ   #-$71,D7
        DC.W    $7F75,$7F76,$2883   ; $013AD2 MOVE.W  $76(A5,D7.L),$2883(A7)
        DC.W    $7EB0               ; $013AD8 MOVEQ   #-$50,D7
        DC.W    $7EF2               ; $013ADA MOVEQ   #-$0E,D7
        DC.W    $7F34,$0C42         ; $013ADC MOVE.W  $42(A4,D0.L),-(A7)
        DC.W    $4926               ; $013AE0 DC.W    $4926
        DC.W    $2CA4               ; $013AE2 MOVE.L  -(A4),(A6)
        DC.W    $1483               ; $013AE4 MOVE.B  D3,(A2)
        DC.W    $4506               ; $013AE6 DC.W    $4506
        DC.W    $34C4               ; $013AE8 MOVE.W  D4,(A2)+
        DC.W    $7FFF               ; $013AEA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AEC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $65CC               ; $013AEE BCS.S  loc_013ABC
        DC.W    $7FFF               ; $013AF0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AF2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AF4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AF6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AF8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AFA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AFC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013AFE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B00 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B02 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B04 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $10E1               ; $013B06 MOVE.B  -(A1),(A0)+
        DC.W    $2143,$31A6         ; $013B08 MOVE.L  D3,$31A6(A0)
        DC.W    $4209               ; $013B0C CLR.B  A1
        DC.W    $1C00               ; $013B0E MOVE.B  D0,D6
        DC.W    $28A3               ; $013B10 MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $013B12 MOVE.W  D6,$41E9(A2)
        DC.W    $0818,$0010         ; $013B16 BTST    #16,(A0)+
        DC.W    $084D,$108A         ; $013B1A BCHG    #10,A5
        DC.W    $7FFF               ; $013B1E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $6F7B               ; $013B20 BLE.S  loc_013B9D
        DC.W    $5AD6               ; $013B22 SPL     (A6)
        DC.W    $4A52               ; $013B24 TST.W  (A2)
        DC.W    $7FFF               ; $013B26 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B28 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B2A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B2C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B2E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B30 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B32 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B34 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B36 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B38 MOVE.W  <EA:3F>,<EA:3F>
loc_013B3A:
        DC.W    $7FFF               ; $013B3A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B3C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0000,$4E73         ; $013B3E ORI.B  #$4E73,D0
        DC.W    $6739               ; $013B42 BEQ.S  loc_013B7D
        DC.W    $7FFF               ; $013B44 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B46 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B48 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B4A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B4C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $4445               ; $013B4E NEG.W  D5
        DC.W    $44C6               ; $013B50 NEG    D6
        DC.W    $4968               ; $013B52 DC.W    $4968
        DC.W    $4DEA,$7FFF         ; $013B54 LEA     $7FFF(A2),A6
        DC.W    $63F5               ; $013B58 BLS.S  loc_013B4F
        DC.W    $7FFF               ; $013B5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B60 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B62 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B64 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7714               ; $013B66 MOVE.W  (A4),-(A3)
        DC.W    $6EF1               ; $013B68 BGT.S  loc_013B5B
        DC.W    $66CE               ; $013B6A BNE.S  loc_013B3A
        DC.W    $5EAB,$7FFF         ; $013B6C ADDQ.L  #7,$7FFF(A3)
        DC.W    $7FFF               ; $013B70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B74 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $6337               ; $013B7E BLS.S  loc_013BB7
        DC.W    $5F14               ; $013B80 SUBQ.B  #7,(A4)
        DC.W    $5AF0,$56CC         ; $013B82 SPL     -$34(A0,D5.W)
        DC.W    $10E1               ; $013B86 MOVE.B  -(A1),(A0)+
        DC.W    $29A8,$4670,$6337   ; $013B88 MOVE.L  $4670(A0),$37(A4,D6.W)
loc_013B8E:
        DC.W    $4445               ; $013B8E NEG.W  D5
        DC.W    $512B,$6212         ; $013B90 SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $013B94 BGT.S  loc_013B8E
        DC.W    $7FFF               ; $013B96 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $031F               ; $013B98 BTST    D1,(A7)+
        DC.W    $7FFF               ; $013B9A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B9C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013B9E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BA8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $013BB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0000,$021F         ; $013BB6 ORI.B  #$021F,D0
        DC.W    $027F,$06DF         ; $013BBA ANDI.W  #$06DF,<EA:3F>
        DC.W    $2D08               ; $013BBE MOVE.L  A0,-(A6)
        DC.W    $49CD               ; $013BC0 LEA     A5,A4
        DC.W    $5650               ; $013BC2 ADDQ.W  #3,(A0)
        DC.W    $66D1               ; $013BC4 BNE.S  loc_013B97
        DC.W    $4EB9,$0088,$2080   ; $013BC6 JSR     $00882080
        DC.W    $3038,$C87E         ; $013BCC MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $013BD0 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $013BD4 JMP     (A1)
        DC.W    $0089,$3BE6,$0089   ; $013BD6 ORI.L  #$3BE60089,A1
        DC.W    $3C30,$0089         ; $013BDC MOVE.W  -$77(A0,D0.W),D6
        DC.W    $3CBA,$0089         ; $013BE0 MOVE.W  $0089(PC),(A6)
        DC.W    $3F80,$4240         ; $013BE4 MOVE.W  D0,$40(A7,D4.W)
        DC.W    $0838,$0000,$C818   ; $013BE8 BTST    #0,$C818.W
        DC.W    $6704               ; $013BEE BEQ.S  loc_013BF4
        DC.W    $303C,$0001         ; $013BF0 MOVE.W  #$0001,D0
loc_013BF4:
        DC.W    $363C,$00FF         ; $013BF4 MOVE.W  #$00FF,D3
        DC.W    $41F8,$FE92         ; $013BF8 LEA     $FE92.W,A0
        DC.W    $43F8,$FE82         ; $013BFC LEA     $FE82.W,A1
        DC.W    $45F8,$FE94         ; $013C00 LEA     $FE94.W,A2
        DC.W    $6100,$03DA         ; $013C04 BSR.W  loc_013FE0
        DC.W    $4240               ; $013C08 CLR.W  D0
        DC.W    $0838,$0001,$C818   ; $013C0A BTST    #1,$C818.W
        DC.W    $6704               ; $013C10 BEQ.S  loc_013C16
        DC.W    $303C,$0001         ; $013C12 MOVE.W  #$0001,D0
loc_013C16:
        DC.W    $363C,$00FF         ; $013C16 MOVE.W  #$00FF,D3
        DC.W    $41F8,$FE93         ; $013C1A LEA     $FE93.W,A0
        DC.W    $43F8,$FE8A         ; $013C1E LEA     $FE8A.W,A1
        DC.W    $45F8,$FE9C         ; $013C22 LEA     $FE9C.W,A2
        DC.W    $6100,$03B8         ; $013C26 BSR.W  loc_013FE0
        DC.W    $5878,$C87E         ; $013C2A ADDQ.W  #4,$C87E.W
        DC.W    $4E75               ; $013C2E RTS
        DC.W    $4EB9,$0088,$205E   ; $013C30 JSR     $0088205E
        DC.W    $4240               ; $013C36 CLR.W  D0
        DC.W    $4EBA,$A8F2         ; $013C38 JSR     $00E52C(PC)
loc_013C3C:
        DC.W    $4A39,$00A1,$5120   ; $013C3C TST.B  $00A15120
        DC.W    $66F8               ; $013C42 BNE.S  loc_013C3C
        DC.W    $33FC,$0101,$00A1,$512C; $013C44 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$4000,$00A1,$5128; $013C4C MOVE.W  #$4000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $013C54 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $013C5C MOVE.B  #$0001,$00A15120
loc_013C64:
        DC.W    $4A39,$00A1,$512C   ; $013C64 TST.B  $00A1512C
        DC.W    $66F8               ; $013C6A BNE.S  loc_013C64
        DC.W    $33FC,$00B8,$00A1,$5128; $013C6C MOVE.W  #$00B8,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $013C74 MOVE.W  #$0101,$00A1512C
        DC.W    $207C,$0601,$7CC0   ; $013C7C MOVEA.L #$06017CC0,A0
        DC.W    $227C,$0400,$7010   ; $013C82 MOVEA.L #$04007010,A1
        DC.W    $303C,$0120         ; $013C88 MOVE.W  #$0120,D0
        DC.W    $323C,$0058         ; $013C8C MOVE.W  #$0058,D1
        DC.W    $4EBA,$A6C8         ; $013C90 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$DFC0   ; $013C94 MOVEA.L #$0601DFC0,A0
        DC.W    $227C,$0401,$3010   ; $013C9A MOVEA.L #$04013010,A1
        DC.W    $303C,$0120         ; $013CA0 MOVE.W  #$0120,D0
        DC.W    $323C,$0058         ; $013CA4 MOVE.W  #$0058,D1
        DC.W    $4EBA,$A6B0         ; $013CA8 JSR     $00E35A(PC)
        DC.W    $5878,$C87E         ; $013CAC ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $013CB0 MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $013CB8 RTS
        DC.W    $4240               ; $013CBA CLR.W  D0
        DC.W    $4EBA,$A86E         ; $013CBC JSR     $00E52C(PC)
        DC.W    $4EB9,$0088,$B684   ; $013CC0 JSR     $0088B684
        DC.W    $4EB9,$0088,$B6DA   ; $013CC6 JSR     $0088B6DA
        DC.W    $207C,$0601,$4000   ; $013CCC MOVEA.L #$06014000,A0
        DC.W    $227C,$0400,$4C74   ; $013CD2 MOVEA.L #$04004C74,A1
        DC.W    $303C,$0058         ; $013CD8 MOVE.W  #$0058,D0
        DC.W    $323C,$0010         ; $013CDC MOVE.W  #$0010,D1
        DC.W    $4EBA,$A678         ; $013CE0 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$4580   ; $013CE4 MOVEA.L #$06014580,A0
        DC.W    $227C,$0400,$7018   ; $013CEA MOVEA.L #$04007018,A1
        DC.W    $303C,$0048         ; $013CF0 MOVE.W  #$0048,D0
        DC.W    $323C,$0010         ; $013CF4 MOVE.W  #$0010,D1
        DC.W    $4EBA,$A660         ; $013CF8 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$4A00   ; $013CFC MOVEA.L #$06014A00,A0
        DC.W    $227C,$0401,$3018   ; $013D02 MOVEA.L #$04013018,A1
        DC.W    $303C,$0048         ; $013D08 MOVE.W  #$0048,D0
        DC.W    $323C,$0010         ; $013D0C MOVE.W  #$0010,D1
        DC.W    $4EBA,$A648         ; $013D10 JSR     $00E35A(PC)
        DC.W    $0838,$0002,$C818   ; $013D14 BTST    #2,$C818.W
        DC.W    $6626               ; $013D1A BNE.S  loc_013D42
        DC.W    $41F9,$0089,$AA12   ; $013D1C LEA     $0089AA12,A0
        DC.W    $4240               ; $013D22 CLR.W  D0
        DC.W    $1038,$FE92         ; $013D24 MOVE.B  $FE92.W,D0
        DC.W    $D040               ; $013D28 ADD.W  D0,D0
        DC.W    $D040               ; $013D2A ADD.W  D0,D0
        DC.W    $2070,$0000         ; $013D2C MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0400,$707C   ; $013D30 MOVEA.L #$0400707C,A1
        DC.W    $303C,$0048         ; $013D36 MOVE.W  #$0048,D0
        DC.W    $323C,$0010         ; $013D3A MOVE.W  #$0010,D1
        DC.W    $4EBA,$A61A         ; $013D3E JSR     $00E35A(PC)
loc_013D42:
        DC.W    $0838,$0003,$C818   ; $013D42 BTST    #3,$C818.W
        DC.W    $6626               ; $013D48 BNE.S  loc_013D70
        DC.W    $41F9,$0089,$AA12   ; $013D4A LEA     $0089AA12,A0
        DC.W    $4240               ; $013D50 CLR.W  D0
        DC.W    $1038,$FE93         ; $013D52 MOVE.B  $FE93.W,D0
        DC.W    $D040               ; $013D56 ADD.W  D0,D0
        DC.W    $D040               ; $013D58 ADD.W  D0,D0
        DC.W    $2070,$0000         ; $013D5A MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0401,$307C   ; $013D5E MOVEA.L #$0401307C,A1
        DC.W    $303C,$0048         ; $013D64 MOVE.W  #$0048,D0
        DC.W    $323C,$0010         ; $013D68 MOVE.W  #$0010,D1
        DC.W    $4EBA,$A5EC         ; $013D6C JSR     $00E35A(PC)
loc_013D70:
        DC.W    $45F8,$FE82         ; $013D70 LEA     $FE82.W,A2
        DC.W    $47F9,$0089,$AA2E   ; $013D74 LEA     $0089AA2E,A3
        DC.W    $4244               ; $013D7A CLR.W  D4
        DC.W    $363C,$0004         ; $013D7C MOVE.W  #$0004,D3
        DC.W    $0838,$0000,$C818   ; $013D80 BTST    #0,$C818.W
        DC.W    $6704               ; $013D86 BEQ.S  loc_013D8C
        DC.W    $363C,$0007         ; $013D88 MOVE.W  #$0007,D3
loc_013D8C:
        DC.W    $2073,$4000         ; $013D8C MOVEA.L $00(A3,D4.W),A0
        DC.W    $3033,$4008         ; $013D90 MOVE.W  $08(A3,D4.W),D0
        DC.W    $2873,$4004         ; $013D94 MOVEA.L $04(A3,D4.W),A4
        DC.W    $4241               ; $013D98 CLR.W  D1
        DC.W    $121A               ; $013D9A MOVE.B  (A2)+,D1
        DC.W    $D241               ; $013D9C ADD.W  D1,D1
        DC.W    $D241               ; $013D9E ADD.W  D1,D1
        DC.W    $2274,$1000         ; $013DA0 MOVEA.L $00(A4,D1.W),A1
        DC.W    $0838,$0000,$C818   ; $013DA4 BTST    #0,$C818.W
        DC.W    $6620               ; $013DAA BNE.S  loc_013DCC
        DC.W    $B1FC,$0601,$7780   ; $013DAC CMPA.L  #$06017780,A0
        DC.W    $6618               ; $013DB2 BNE.S  loc_013DCC
        DC.W    $207C,$0601,$7500   ; $013DB4 MOVEA.L #$06017500,A0
        DC.W    $303C,$0018         ; $013DBA MOVE.W  #$0018,D0
        DC.W    $0C41,$0004         ; $013DBE CMPI.W  #$0004,D1
        DC.W    $6F00,$0008         ; $013DC2 BLE.W  loc_013DCC
        DC.W    $D3FC,$0000,$0020   ; $013DC6 ADDA.L  #$00000020,A1
loc_013DCC:
        DC.W    $323C,$0008         ; $013DCC MOVE.W  #$0008,D1
        DC.W    $4EBA,$A588         ; $013DD0 JSR     $00E35A(PC)
        DC.W    $0644,$000A         ; $013DD4 ADDI.W  #$000A,D4
        DC.W    $51CB,$FFB2         ; $013DD8 DBRA    D3,loc_013D8C
        DC.W    $4A78,$A020         ; $013DDC TST.W  $A020.W
        DC.W    $671A               ; $013DE0 BEQ.S  loc_013DFC
        DC.W    $303C,$0000         ; $013DE2 MOVE.W  #$0000,D0
        DC.W    $0838,$0000,$C818   ; $013DE6 BTST    #0,$C818.W
        DC.W    $6704               ; $013DEC BEQ.S  loc_013DF2
        DC.W    $303C,$0001         ; $013DEE MOVE.W  #$0001,D0
loc_013DF2:
        DC.W    $7200               ; $013DF2 MOVEQ   #$00,D1
        DC.W    $41F8,$A019         ; $013DF4 LEA     $A019.W,A0
        DC.W    $6100,$03F0         ; $013DF8 BSR.W  loc_0141EA
loc_013DFC:
        DC.W    $0838,$0003,$C818   ; $013DFC BTST    #3,$C818.W
        DC.W    $6600,$0098         ; $013E02 BNE.W  loc_013E9C
        DC.W    $45F8,$FE8A         ; $013E06 LEA     $FE8A.W,A2
        DC.W    $47F9,$0089,$AA2E   ; $013E0A LEA     $0089AA2E,A3
        DC.W    $4244               ; $013E10 CLR.W  D4
        DC.W    $363C,$0004         ; $013E12 MOVE.W  #$0004,D3
        DC.W    $0838,$0001,$C818   ; $013E16 BTST    #1,$C818.W
        DC.W    $6704               ; $013E1C BEQ.S  loc_013E22
        DC.W    $363C,$0007         ; $013E1E MOVE.W  #$0007,D3
loc_013E22:
        DC.W    $2073,$4000         ; $013E22 MOVEA.L $00(A3,D4.W),A0
        DC.W    $3033,$4008         ; $013E26 MOVE.W  $08(A3,D4.W),D0
        DC.W    $2873,$4004         ; $013E2A MOVEA.L $04(A3,D4.W),A4
        DC.W    $4241               ; $013E2E CLR.W  D1
        DC.W    $121A               ; $013E30 MOVE.B  (A2)+,D1
        DC.W    $D241               ; $013E32 ADD.W  D1,D1
        DC.W    $D241               ; $013E34 ADD.W  D1,D1
        DC.W    $2274,$1000         ; $013E36 MOVEA.L $00(A4,D1.W),A1
        DC.W    $0838,$0001,$C818   ; $013E3A BTST    #1,$C818.W
        DC.W    $6620               ; $013E40 BNE.S  loc_013E62
        DC.W    $B1FC,$0601,$7780   ; $013E42 CMPA.L  #$06017780,A0
        DC.W    $6618               ; $013E48 BNE.S  loc_013E62
        DC.W    $207C,$0601,$7500   ; $013E4A MOVEA.L #$06017500,A0
        DC.W    $303C,$0018         ; $013E50 MOVE.W  #$0018,D0
        DC.W    $0C41,$0004         ; $013E54 CMPI.W  #$0004,D1
        DC.W    $6F00,$0008         ; $013E58 BLE.W  loc_013E62
        DC.W    $D3FC,$0000,$0020   ; $013E5C ADDA.L  #$00000020,A1
loc_013E62:
        DC.W    $D3FC,$0000,$C000   ; $013E62 ADDA.L  #$0000C000,A1
        DC.W    $323C,$0008         ; $013E68 MOVE.W  #$0008,D1
        DC.W    $4EBA,$A4EC         ; $013E6C JSR     $00E35A(PC)
        DC.W    $0644,$000A         ; $013E70 ADDI.W  #$000A,D4
        DC.W    $51CB,$FFAC         ; $013E74 DBRA    D3,loc_013E22
        DC.W    $4A78,$A022         ; $013E78 TST.W  $A022.W
        DC.W    $671E               ; $013E7C BEQ.S  loc_013E9C
        DC.W    $303C,$0000         ; $013E7E MOVE.W  #$0000,D0
        DC.W    $0838,$0001,$C818   ; $013E82 BTST    #1,$C818.W
        DC.W    $6704               ; $013E88 BEQ.S  loc_013E8E
        DC.W    $303C,$0001         ; $013E8A MOVE.W  #$0001,D0
loc_013E8E:
        DC.W    $223C,$0000,$C000   ; $013E8E MOVE.L  #$0000C000,D1
        DC.W    $41F8,$A01A         ; $013E94 LEA     $A01A.W,A0
        DC.W    $6100,$0350         ; $013E98 BSR.W  loc_0141EA
loc_013E9C:
        DC.W    $0C78,$0001,$A024   ; $013E9C CMPI.W  #$0001,$A024.W
        DC.W    $6700,$009E         ; $013EA2 BEQ.W  loc_013F42
        DC.W    $0C78,$0002,$A024   ; $013EA6 CMPI.W  #$0002,$A024.W
        DC.W    $6700,$00AA         ; $013EAC BEQ.W  loc_013F58
        DC.W    $4EB9,$0088,$179E   ; $013EB0 JSR     $0088179E
        DC.W    $4240               ; $013EB6 CLR.W  D0
        DC.W    $0838,$0000,$C818   ; $013EB8 BTST    #0,$C818.W
        DC.W    $6704               ; $013EBE BEQ.S  loc_013EC4
        DC.W    $303C,$0001         ; $013EC0 MOVE.W  #$0001,D0
loc_013EC4:
        DC.W    $3238,$C86C         ; $013EC4 MOVE.W  $C86C.W,D1
        DC.W    $4242               ; $013EC8 CLR.W  D2
        DC.W    $4243               ; $013ECA CLR.W  D3
        DC.W    $41F8,$FE92         ; $013ECC LEA     $FE92.W,A0
        DC.W    $43F8,$FE82         ; $013ED0 LEA     $FE82.W,A1
        DC.W    $45F8,$FE94         ; $013ED4 LEA     $FE94.W,A2
        DC.W    $47F8,$A019         ; $013ED8 LEA     $A019.W,A3
        DC.W    $49F8,$A020         ; $013EDC LEA     $A020.W,A4
        DC.W    $6100,$00FE         ; $013EE0 BSR.W  loc_013FE0
        DC.W    $4240               ; $013EE4 CLR.W  D0
        DC.W    $0838,$0001,$C818   ; $013EE6 BTST    #1,$C818.W
        DC.W    $6704               ; $013EEC BEQ.S  loc_013EF2
        DC.W    $303C,$0001         ; $013EEE MOVE.W  #$0001,D0
loc_013EF2:
        DC.W    $3238,$C86E         ; $013EF2 MOVE.W  $C86E.W,D1
        DC.W    $343C,$0001         ; $013EF6 MOVE.W  #$0001,D2
        DC.W    $4243               ; $013EFA CLR.W  D3
        DC.W    $41F8,$FE93         ; $013EFC LEA     $FE93.W,A0
        DC.W    $43F8,$FE8A         ; $013F00 LEA     $FE8A.W,A1
        DC.W    $45F8,$FE9C         ; $013F04 LEA     $FE9C.W,A2
        DC.W    $47F8,$A01A         ; $013F08 LEA     $A01A.W,A3
        DC.W    $49F8,$A022         ; $013F0C LEA     $A022.W,A4
        DC.W    $6100,$00CE         ; $013F10 BSR.W  loc_013FE0
        DC.W    $4A78,$A01E         ; $013F14 TST.W  $A01E.W
        DC.W    $6700,$0058         ; $013F18 BEQ.W  loc_013F72
        DC.W    $11FC,$0001,$C809   ; $013F1C MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $013F22 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $013F28 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $013F2E MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $013F34 JSR     $0088205E
        DC.W    $31FC,$0002,$A024   ; $013F3A MOVE.W  #$0002,$A024.W
        DC.W    $6034               ; $013F40 BRA.S  loc_013F76
loc_013F42:
        DC.W    $4EB9,$0088,$FB36   ; $013F42 JSR     $0088FB36
        DC.W    $0838,$0006,$C80E   ; $013F48 BTST    #6,$C80E.W
        DC.W    $6622               ; $013F4E BNE.S  loc_013F72
        DC.W    $4278,$A024         ; $013F50 CLR.W  $A024.W
        DC.W    $6000,$001C         ; $013F54 BRA.W  loc_013F72
loc_013F58:
        DC.W    $4EB9,$0088,$FB36   ; $013F58 JSR     $0088FB36
        DC.W    $0838,$0007,$C80E   ; $013F5E BTST    #7,$C80E.W
        DC.W    $660C               ; $013F64 BNE.S  loc_013F72
        DC.W    $4278,$A024         ; $013F66 CLR.W  $A024.W
        DC.W    $5878,$C87E         ; $013F6A ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $013F6E BRA.W  loc_013F76
loc_013F72:
        DC.W    $5978,$C87E         ; $013F72 SUBQ.W  #4,$C87E.W
loc_013F76:
        DC.W    $33FC,$0018,$00FF,$0008; $013F76 MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $013F7E RTS
loc_013F80:
        DC.W    $0C38,$0006,$FE92   ; $013F80 CMPI.B  #$0006,$FE92.W
        DC.W    $6600,$0014         ; $013F86 BNE.W  loc_013F9C
        DC.W    $41F8,$FE82         ; $013F8A LEA     $FE82.W,A0
        DC.W    $43F8,$FE94         ; $013F8E LEA     $FE94.W,A1
        DC.W    $303C,$0007         ; $013F92 MOVE.W  #$0007,D0
loc_013F96:
        DC.W    $12D8               ; $013F96 MOVE.B  (A0)+,(A1)+
        DC.W    $51C8,$FFFC         ; $013F98 DBRA    D0,loc_013F96
loc_013F9C:
        DC.W    $0C38,$0006,$FE93   ; $013F9C CMPI.B  #$0006,$FE93.W
        DC.W    $6600,$0014         ; $013FA2 BNE.W  loc_013FB8
        DC.W    $41F8,$FE8A         ; $013FA6 LEA     $FE8A.W,A0
        DC.W    $43F8,$FE9C         ; $013FAA LEA     $FE9C.W,A1
        DC.W    $303C,$0007         ; $013FAE MOVE.W  #$0007,D0
loc_013FB2:
        DC.W    $12D8               ; $013FB2 MOVE.B  (A0)+,(A1)+
        DC.W    $51C8,$FFFC         ; $013FB4 DBRA    D0,loc_013FB2
loc_013FB8:
        DC.W    $4A39,$00A1,$5120   ; $013FB8 TST.B  $00A15120
        DC.W    $66C0               ; $013FBE BNE.S  loc_013F80
        DC.W    $4239,$00A1,$5123   ; $013FC0 CLR.B  $00A15123
        DC.W    $31FC,$0000,$C87E   ; $013FC6 MOVE.W  #$0000,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $013FCC MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0089,$305E,$00FF,$0002; $013FD4 MOVE.L  #$0089305E,$00FF0002
        DC.W    $4E75               ; $013FDE RTS
loc_013FE0:
        DC.W    $4A43               ; $013FE0 TST.W  D3
        DC.W    $6600,$0168         ; $013FE2 BNE.W  loc_01414C
        DC.W    $0801,$0007         ; $013FE6 BTST    #7,D1
        DC.W    $6600,$0150         ; $013FEA BNE.W  loc_01413C
        DC.W    $1601               ; $013FEE MOVE.B  D1,D3
        DC.W    $0203,$0060         ; $013FF0 ANDI.B  #$0060,D3
        DC.W    $6600,$0110         ; $013FF4 BNE.W  loc_014106
        DC.W    $0801,$0004         ; $013FF8 BTST    #4,D1
        DC.W    $6600,$012E         ; $013FFC BNE.W  loc_01412C
        DC.W    $0801,$0000         ; $014000 BTST    #0,D1
        DC.W    $6718               ; $014004 BEQ.S  loc_01401E
        DC.W    $4A54               ; $014006 TST.W  (A4)
        DC.W    $6700,$0058         ; $014008 BEQ.W  loc_014062
        DC.W    $11FC,$00A9,$C8A4   ; $01400C MOVE.B  #$00A9,$C8A4.W
        DC.W    $5313               ; $014012 SUBQ.B  #1,(A3)
        DC.W    $6400,$0176         ; $014014 BCC.W  loc_01418C
        DC.W    $4213               ; $014018 CLR.B  (A3)
        DC.W    $6000,$0170         ; $01401A BRA.W  loc_01418C
loc_01401E:
        DC.W    $0801,$0001         ; $01401E BTST    #1,D1
        DC.W    $673E               ; $014022 BEQ.S  loc_014062
        DC.W    $4A54               ; $014024 TST.W  (A4)
        DC.W    $6700,$003A         ; $014026 BEQ.W  loc_014062
        DC.W    $11FC,$00A9,$C8A4   ; $01402A MOVE.B  #$00A9,$C8A4.W
        DC.W    $5213               ; $014030 ADDQ.B  #1,(A3)
        DC.W    $1613               ; $014032 MOVE.B  (A3),D3
        DC.W    $183C,$0004         ; $014034 MOVE.B  #$0004,D4
        DC.W    $4A40               ; $014038 TST.W  D0
        DC.W    $6704               ; $01403A BEQ.S  loc_014040
        DC.W    $183C,$0007         ; $01403C MOVE.B  #$0007,D4
loc_014040:
        DC.W    $B604               ; $014040 CMP.B  D4,D3
        DC.W    $6F00,$0004         ; $014042 BLE.W  loc_014048
        DC.W    $1684               ; $014046 MOVE.B  D4,(A3)
loc_014048:
        DC.W    $49F8,$A01B         ; $014048 LEA     $A01B.W,A4
        DC.W    $4A42               ; $01404C TST.W  D2
        DC.W    $6704               ; $01404E BEQ.S  loc_014054
        DC.W    $49F8,$A01C         ; $014050 LEA     $A01C.W,A4
loc_014054:
        DC.W    $1013               ; $014054 MOVE.B  (A3),D0
        DC.W    $B014               ; $014056 CMP.B  (A4),D0
        DC.W    $6D00,$0132         ; $014058 BLT.W  loc_01418C
        DC.W    $1880               ; $01405C MOVE.B  D0,(A4)
        DC.W    $6000,$012C         ; $01405E BRA.W  loc_01418C
loc_014062:
        DC.W    $0801,$0002         ; $014062 BTST    #2,D1
        DC.W    $674A               ; $014066 BEQ.S  loc_0140B2
        DC.W    $11FC,$00A9,$C8A4   ; $014068 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A54               ; $01406E TST.W  (A4)
        DC.W    $6600,$0010         ; $014070 BNE.W  loc_014082
        DC.W    $5310               ; $014074 SUBQ.B  #1,(A0)
        DC.W    $6400,$00D4         ; $014076 BCC.W  loc_01414C
        DC.W    $10BC,$0006         ; $01407A MOVE.B  #$0006,(A0)
        DC.W    $6000,$00CC         ; $01407E BRA.W  loc_01414C
loc_014082:
        DC.W    $49F8,$A01B         ; $014082 LEA     $A01B.W,A4
        DC.W    $4A42               ; $014086 TST.W  D2
        DC.W    $6704               ; $014088 BEQ.S  loc_01408E
        DC.W    $49F8,$A01C         ; $01408A LEA     $A01C.W,A4
loc_01408E:
        DC.W    $6100,$00FE         ; $01408E BSR.W  loc_01418E
        DC.W    $5314               ; $014092 SUBQ.B  #1,(A4)
        DC.W    $1614               ; $014094 MOVE.B  (A4),D3
        DC.W    $B613               ; $014096 CMP.B  (A3),D3
        DC.W    $6C00,$0010         ; $014098 BGE.W  loc_0140AA
        DC.W    $18BC,$0004         ; $01409C MOVE.B  #$0004,(A4)
        DC.W    $4A40               ; $0140A0 TST.W  D0
        DC.W    $6700,$0006         ; $0140A2 BEQ.W  loc_0140AA
        DC.W    $18BC,$0007         ; $0140A6 MOVE.B  #$0007,(A4)
loc_0140AA:
        DC.W    $6100,$00E2         ; $0140AA BSR.W  loc_01418E
        DC.W    $6000,$00DC         ; $0140AE BRA.W  loc_01418C
loc_0140B2:
        DC.W    $0801,$0003         ; $0140B2 BTST    #3,D1
        DC.W    $6700,$00D4         ; $0140B6 BEQ.W  loc_01418C
        DC.W    $11FC,$00A9,$C8A4   ; $0140BA MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A54               ; $0140C0 TST.W  (A4)
        DC.W    $6600,$0012         ; $0140C2 BNE.W  loc_0140D6
        DC.W    $5210               ; $0140C6 ADDQ.B  #1,(A0)
        DC.W    $0C10,$0006         ; $0140C8 CMPI.B  #$0006,(A0)
        DC.W    $6F00,$007E         ; $0140CC BLE.W  loc_01414C
        DC.W    $4210               ; $0140D0 CLR.B  (A0)
        DC.W    $6000,$0078         ; $0140D2 BRA.W  loc_01414C
loc_0140D6:
        DC.W    $49F8,$A01B         ; $0140D6 LEA     $A01B.W,A4
        DC.W    $4A42               ; $0140DA TST.W  D2
        DC.W    $6704               ; $0140DC BEQ.S  loc_0140E2
        DC.W    $49F8,$A01C         ; $0140DE LEA     $A01C.W,A4
loc_0140E2:
        DC.W    $6100,$00AA         ; $0140E2 BSR.W  loc_01418E
        DC.W    $5214               ; $0140E6 ADDQ.B  #1,(A4)
        DC.W    $163C,$0004         ; $0140E8 MOVE.B  #$0004,D3
        DC.W    $4A40               ; $0140EC TST.W  D0
        DC.W    $6700,$0006         ; $0140EE BEQ.W  loc_0140F6
        DC.W    $163C,$0007         ; $0140F2 MOVE.B  #$0007,D3
loc_0140F6:
        DC.W    $B614               ; $0140F6 CMP.B  (A4),D3
        DC.W    $6C00,$0004         ; $0140F8 BGE.W  loc_0140FE
        DC.W    $1893               ; $0140FC MOVE.B  (A3),(A4)
loc_0140FE:
        DC.W    $6100,$008E         ; $0140FE BSR.W  loc_01418E
        DC.W    $6000,$0088         ; $014102 BRA.W  loc_01418C
loc_014106:
        DC.W    $0C10,$0006         ; $014106 CMPI.B  #$0006,(A0)
        DC.W    $6600,$0080         ; $01410A BNE.W  loc_01418C
        DC.W    $4A54               ; $01410E TST.W  (A4)
        DC.W    $6600,$007A         ; $014110 BNE.W  loc_01418C
        DC.W    $38BC,$0001         ; $014114 MOVE.W  #$0001,(A4)
        DC.W    $4213               ; $014118 CLR.B  (A3)
        DC.W    $49F8,$A01B         ; $01411A LEA     $A01B.W,A4
        DC.W    $4A42               ; $01411E TST.W  D2
        DC.W    $6704               ; $014120 BEQ.S  loc_014126
        DC.W    $49F8,$A01C         ; $014122 LEA     $A01C.W,A4
loc_014126:
        DC.W    $4214               ; $014126 CLR.B  (A4)
        DC.W    $6000,$0062         ; $014128 BRA.W  loc_01418C
loc_01412C:
        DC.W    $4254               ; $01412C CLR.W  (A4)
        DC.W    $303C,$0007         ; $01412E MOVE.W  #$0007,D0
loc_014132:
        DC.W    $14D9               ; $014132 MOVE.B  (A1)+,(A2)+
        DC.W    $51C8,$FFFC         ; $014134 DBRA    D0,loc_014132
        DC.W    $6000,$0052         ; $014138 BRA.W  loc_01418C
loc_01413C:
        DC.W    $11FC,$00A8,$C8A4   ; $01413C MOVE.B  #$00A8,$C8A4.W
        DC.W    $31FC,$0001,$A01E   ; $014142 MOVE.W  #$0001,$A01E.W
        DC.W    $6000,$0042         ; $014148 BRA.W  loc_01418C
loc_01414C:
        DC.W    $0C10,$0006         ; $01414C CMPI.B  #$0006,(A0)
        DC.W    $660A               ; $014150 BNE.S  loc_01415C
        DC.W    $264A               ; $014152 MOVEA.L A2,A3
        DC.W    $343C,$0007         ; $014154 MOVE.W  #$0007,D2
        DC.W    $6000,$002C         ; $014158 BRA.W  loc_014186
loc_01415C:
        DC.W    $4243               ; $01415C CLR.W  D3
        DC.W    $1610               ; $01415E MOVE.B  (A0),D3
        DC.W    $D643               ; $014160 ADD.W  D3,D3
        DC.W    $D643               ; $014162 ADD.W  D3,D3
        DC.W    $D643               ; $014164 ADD.W  D3,D3
        DC.W    $47F9,$0089,$AB8E   ; $014166 LEA     $0089AB8E,A3
        DC.W    $47F3,$3000         ; $01416C LEA     $00(A3,D3.W),A3
        DC.W    $343C,$0004         ; $014170 MOVE.W  #$0004,D2
        DC.W    $4A40               ; $014174 TST.W  D0
        DC.W    $670E               ; $014176 BEQ.S  loc_014186
        DC.W    $47F9,$0089,$ABBE   ; $014178 LEA     $0089ABBE,A3
        DC.W    $47F3,$3000         ; $01417E LEA     $00(A3,D3.W),A3
        DC.W    $343C,$0007         ; $014182 MOVE.W  #$0007,D2
loc_014186:
        DC.W    $12DB               ; $014186 MOVE.B  (A3)+,(A1)+
        DC.W    $51CA,$FFFC         ; $014188 DBRA    D2,loc_014186
loc_01418C:
        DC.W    $4E75               ; $01418C RTS
loc_01418E:
        DC.W    $4243               ; $01418E CLR.W  D3
        DC.W    $1613               ; $014190 MOVE.B  (A3),D3
        DC.W    $41F9,$0089,$41DC   ; $014192 LEA     $008941DC,A0
        DC.W    $4A40               ; $014198 TST.W  D0
        DC.W    $6706               ; $01419A BEQ.S  loc_0141A2
        DC.W    $41F9,$0089,$41E2   ; $01419C LEA     $008941E2,A0
loc_0141A2:
        DC.W    $1230,$3000         ; $0141A2 MOVE.B  $00(A0,D3.W),D1
        DC.W    $4243               ; $0141A6 CLR.W  D3
loc_0141A8:
        DC.W    $B231,$3000         ; $0141A8 CMP.B  $00(A1,D3.W),D1
        DC.W    $6700,$0006         ; $0141AC BEQ.W  loc_0141B4
        DC.W    $5243               ; $0141B0 ADDQ.W  #1,D3
        DC.W    $60F4               ; $0141B2 BRA.S  loc_0141A8
loc_0141B4:
        DC.W    $1A31,$3000         ; $0141B4 MOVE.B  $00(A1,D3.W),D5
        DC.W    $4244               ; $0141B8 CLR.W  D4
        DC.W    $1814               ; $0141BA MOVE.B  (A4),D4
        DC.W    $1230,$4000         ; $0141BC MOVE.B  $00(A0,D4.W),D1
        DC.W    $4244               ; $0141C0 CLR.W  D4
loc_0141C2:
        DC.W    $B231,$4000         ; $0141C2 CMP.B  $00(A1,D4.W),D1
        DC.W    $6700,$0006         ; $0141C6 BEQ.W  loc_0141CE
        DC.W    $5244               ; $0141CA ADDQ.W  #1,D4
        DC.W    $60F4               ; $0141CC BRA.S  loc_0141C2
loc_0141CE:
        DC.W    $1C31,$4000         ; $0141CE MOVE.B  $00(A1,D4.W),D6
        DC.W    $1385,$4000         ; $0141D2 MOVE.B  D5,$00(A1,D4.W)
        DC.W    $1386,$3000         ; $0141D6 MOVE.B  D6,$00(A1,D3.W)
        DC.W    $4E75               ; $0141DA RTS
        DC.W    $0001,$0504         ; $0141DC ORI.B  #$0504,D1
        DC.W    $0600,$0001         ; $0141E0 ADDI.B  #$0001,D0
        DC.W    $0A09,$0805         ; $0141E4 EORI.B  #$0805,A1
        DC.W    $0406,$2A01         ; $0141E8 SUBI.B  #$2A01,D6
        DC.W    $43F9,$0089,$AB5A   ; $0141EC LEA     $0089AB5A,A1
        DC.W    $363C,$0003         ; $0141F2 MOVE.W  #$0003,D3
        DC.W    $4A00               ; $0141F6 TST.B  D0
        DC.W    $6700,$000C         ; $0141F8 BEQ.W  $014206
        DC.W    $43F9,$0089,$AB6E   ; $0141FC LEA     $0089AB6E,A1
