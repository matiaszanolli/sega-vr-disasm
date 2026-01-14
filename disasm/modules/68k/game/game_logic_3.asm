; Generated assembly for $00A200-$00C200
; Branch targets: 266
; Labels: 235
; Format: DC.W with decoded mnemonics as comments

        org     $00A200

        DC.W    $1238,$C30F         ; $00A200 MOVE.B  $C30F.W,D1
        DC.W    $D001               ; $00A204 ADD.B  D1,D0
        DC.W    $EB40               ; $00A206 ASL.W  #5,D0
        DC.W    $3228,$008A         ; $00A208 MOVE.W  $008A(A0),D1
        DC.W    $D241               ; $00A20C ADD.W  D1,D1
        DC.W    $D041               ; $00A20E ADD.W  D1,D0
        DC.W    $317B,$0006,$000A   ; $00A210 MOVE.W  $06(PC,D0.W),$000A(A0)
        DC.W    $4E75               ; $00A216 RTS
        DC.W    $048F,$048B,$048B   ; $00A218 SUBI.L  #$048B048B,A7
        DC.W    $0481,$0481,$0468   ; $00A21E SUBI.L  #$04810468,D1
        DC.W    $0456,$03D0         ; $00A224 SUBI.W  #$03D0,(A6)
        DC.W    $03D0               ; $00A228 BSET    D1,(A0)
        DC.W    $03D0               ; $00A22A BSET    D1,(A0)
        DC.W    $03D0               ; $00A22C BSET    D1,(A0)
        DC.W    $03CF               ; $00A22E BSET    D1,A7
        DC.W    $03CF               ; $00A230 BSET    D1,A7
        DC.W    $035A               ; $00A232 BCHG    D1,(A2)+
        DC.W    $035A               ; $00A234 BCHG    D1,(A2)+
        DC.W    $035A               ; $00A236 BCHG    D1,(A2)+
        DC.W    $0496,$0495,$0495   ; $00A238 SUBI.L  #$04950495,(A6)
        DC.W    $0495,$048F,$0481   ; $00A23E SUBI.L  #$048F0481,(A5)
        DC.W    $0477,$046B,$0459   ; $00A244 SUBI.W  #$046B,$59(A7,D0.W)
        DC.W    $03E9,$03E0         ; $00A24A BSET    D1,$03E0(A1)
        DC.W    $03E0               ; $00A24E BSET    D1,-(A0)
        DC.W    $03DF               ; $00A250 BSET    D1,(A7)+
        DC.W    $03DF               ; $00A252 BSET    D1,(A7)+
        DC.W    $03DF               ; $00A254 BSET    D1,(A7)+
        DC.W    $03DF               ; $00A256 BSET    D1,(A7)+
        DC.W    $03FC,$03EB         ; $00A258 BSET    D1,#$03EB
        DC.W    $03EA,$03EA         ; $00A25C BSET    D1,$03EA(A2)
        DC.W    $03EA,$03EA         ; $00A260 BSET    D1,$03EA(A2)
        DC.W    $03EA,$03EA         ; $00A264 BSET    D1,$03EA(A2)
        DC.W    $03EA,$03E4         ; $00A268 BSET    D1,$03E4(A2)
        DC.W    $03E4               ; $00A26C BSET    D1,-(A4)
        DC.W    $03E4               ; $00A26E BSET    D1,-(A4)
        DC.W    $03E4               ; $00A270 BSET    D1,-(A4)
        DC.W    $03E1               ; $00A272 BSET    D1,-(A1)
        DC.W    $03D9               ; $00A274 BSET    D1,(A1)+
        DC.W    $03D9               ; $00A276 BSET    D1,(A1)+
        DC.W    $040B,$0408         ; $00A278 SUBI.B  #$0408,A3
        DC.W    $0404,$03FC         ; $00A27C SUBI.B  #$03FC,D4
        DC.W    $03FC,$03FC         ; $00A280 BSET    D1,#$03FC
        DC.W    $03FC,$03F4         ; $00A284 BSET    D1,#$03F4
        DC.W    $03F4,$03F3         ; $00A288 BSET    D1,-$0D(A4,D0.W)
        DC.W    $03F3,$03F3         ; $00A28C BSET    D1,-$0D(A3,D0.W)
        DC.W    $03F3,$03F2         ; $00A290 BSET    D1,-$0E(A3,D0.W)
        DC.W    $03EB,$03EA         ; $00A294 BSET    D1,$03EA(A3)
        DC.W    $054C               ; $00A298 BCHG    D2,A4
        DC.W    $053D               ; $00A29A BTST    D2,<EA:3D>
        DC.W    $0528,$043C         ; $00A29C BTST    D2,$043C(A0)
        DC.W    $043C,$043C,$043C   ; $00A2A0 SUBI.B  #$043C,#$043C
        DC.W    $043C,$042B,$042A   ; $00A2A6 SUBI.B  #$042B,#$042A
        DC.W    $0429,$0429,$0429   ; $00A2AC SUBI.B  #$0429,$0429(A1)
        DC.W    $0429,$0429,$03A8   ; $00A2B2 SUBI.B  #$0429,$03A8(A1)
        DC.W    $0563               ; $00A2B8 BCHG    D2,-(A3)
        DC.W    $054B               ; $00A2BA BCHG    D2,A3
        DC.W    $054B               ; $00A2BC BCHG    D2,A3
        DC.W    $0536,$052B         ; $00A2BE BTST    D2,$2B(A6,D0.W)
        DC.W    $050B               ; $00A2C2 BTST    D2,A3
        DC.W    $04DD               ; $00A2C4 DC.W    $04DD
        DC.W    $04D2               ; $00A2C6 DC.W    $04D2
        DC.W    $04CF               ; $00A2C8 DC.W    $04CF
        DC.W    $04C7               ; $00A2CA DC.W    $04C7
        DC.W    $04BC,$0498,$0498,$0416,$0416; $00A2CC SUBI.L  #$04980498,#$04160416
        DC.W    $0410,$0200         ; $00A2D6 SUBI.B  #$0200,(A0)
        DC.W    $0F74,$1EDB         ; $00A2DA BCHG    D7,-$25(A4,D1.L)
        DC.W    $2E25               ; $00A2DE MOVE.L  -(A5),D7
        DC.W    $3D43,$4C29         ; $00A2E0 MOVE.W  D3,$4C29(A6)
        DC.W    $5AC7               ; $00A2E4 SPL     D7
        DC.W    $6910               ; $00A2E6 BVS.S  loc_00A2F8
        DC.W    $76F8               ; $00A2E8 MOVEQ   #-$08,D3
        DC.W    $8470,$916C         ; $00A2EA OR.W   $6C(A0,A1.W),D2
        DC.W    $9DE1               ; $00A2EE SUBA.L  -(A1),A6
        DC.W    $A9C2,$B504,$BF9E   ; $00A2F0 MOVE.L  D2,#$B504BF9E
        DC.W    $C984               ; $00A2F6 AND.L  D4,D4
loc_00A2F8:
        DC.W    $D2AF,$DB14         ; $00A2F8 ADD.L  -$24EC(A7),D1
        DC.W    $E2AD               ; $00A2FC LSR.L  D1,D5
        DC.W    $E972               ; $00A2FE ROXL.W  D4,D2
        DC.W    $EF5D               ; $00A300 ROL.W  #7,D5
        DC.W    $F468,$F88F         ; $00A302 MOVEA.W -$0771(A0),A2
        DC.W    $FBCE               ; $00A306 MOVE.W  A6,<EA:3D>
        DC.W    $FE22               ; $00A308 MOVE.W  -(A2),D7
        DC.W    $FF88,$0060         ; $00A30A MOVE.W  A0,$60(A7,D0.W)
        DC.W    $0040,$0020         ; $00A30E ORI.W  #$0020,D0
        DC.W    $0000,$FF88         ; $00A312 ORI.B  #$FF88,D0
        DC.W    $FE22               ; $00A316 MOVE.W  -(A2),D7
        DC.W    $FBCE               ; $00A318 MOVE.W  A6,<EA:3D>
        DC.W    $F88F               ; $00A31A MOVE.W  A7,(A4)
        DC.W    $F468,$EF5D         ; $00A31C MOVEA.W -$10A3(A0),A2
        DC.W    $E972               ; $00A320 ROXL.W  D4,D2
        DC.W    $E2AD               ; $00A322 LSR.L  D1,D5
        DC.W    $DB14               ; $00A324 ADD.B  D5,(A4)
        DC.W    $D2AF,$C984         ; $00A326 ADD.L  -$367C(A7),D1
        DC.W    $BF9E               ; $00A32A EOR.L  D7,(A6)+
        DC.W    $B504               ; $00A32C EOR.B  D2,D4
        DC.W    $A9C2,$9DE1,$916C   ; $00A32E MOVE.L  D2,#$9DE1916C
        DC.W    $8470,$76F8         ; $00A334 OR.W   -$08(A0,D7.W),D2
        DC.W    $6910               ; $00A338 BVS.S  loc_00A34A
        DC.W    $5AC7               ; $00A33A SPL     D7
        DC.W    $4C29               ; $00A33C DC.W    $4C29
        DC.W    $3D43,$2E25         ; $00A33E MOVE.W  D3,$2E25(A6)
        DC.W    $1EDB               ; $00A342 MOVE.B  (A3)+,(A7)+
        DC.W    $0F74,$0200         ; $00A344 BCHG    D7,$00(A4,D0.W)
        DC.W    $FFA0,$FFC0         ; $00A348 MOVE.W  -(A0),-$40(A7,A7.L)
        DC.W    $FFE0               ; $00A34C MOVE.W  -(A0),<EA:3F>
        DC.W    $0000,$4A68         ; $00A34E ORI.B  #$4A68,D0
        DC.W    $006A,$6F1A,$3028   ; $00A352 ORI.W  #$6F1A,$3028(A2)
        DC.W    $006C,$D040,$43FA   ; $00A358 ORI.W  #$D040,$43FA(A4)
        DC.W    $FF7A,$3171,$0000   ; $00A35E MOVE.W  $3171(PC),$0000(A7)
        DC.W    $006E,$5368,$006A   ; $00A364 ORI.W  #$5368,$006A(A6)
        DC.W    $5268,$006C         ; $00A36A ADDQ.W  #1,$006C(A0)
        DC.W    $6048               ; $00A36E BRA.S  loc_00A3B8
        DC.W    $3028,$0002         ; $00A370 MOVE.W  $0002(A0),D0
        DC.W    $0240,$2000         ; $00A374 ANDI.W  #$2000,D0
        DC.W    $671A               ; $00A378 BEQ.S  loc_00A394
        DC.W    $0268,$DFFF,$0002   ; $00A37A ANDI.W  #$DFFF,$0002(A0)
        DC.W    $701E               ; $00A380 MOVEQ   #$1E,D0
        DC.W    $3140,$006C         ; $00A382 MOVE.W  D0,$006C(A0)
        DC.W    $3140,$006A         ; $00A386 MOVE.W  D0,$006A(A0)
        DC.W    $3140,$0014         ; $00A38A MOVE.W  D0,$0014(A0)
        DC.W    $4268,$000E         ; $00A38E CLR.W  $000E(A0)
        DC.W    $6024               ; $00A392 BRA.S  loc_00A3B8
loc_00A394:
        DC.W    $3028,$0002         ; $00A394 MOVE.W  $0002(A0),D0
        DC.W    $0240,$1000         ; $00A398 ANDI.W  #$1000,D0
        DC.W    $671A               ; $00A39C BEQ.S  loc_00A3B8
        DC.W    $0268,$EFFF,$0002   ; $00A39E ANDI.W  #$EFFF,$0002(A0)
        DC.W    $7000               ; $00A3A4 MOVEQ   #$00,D0
        DC.W    $3140,$000E         ; $00A3A6 MOVE.W  D0,$000E(A0)
        DC.W    $3140,$006C         ; $00A3AA MOVE.W  D0,$006C(A0)
        DC.W    $701E               ; $00A3AE MOVEQ   #$1E,D0
        DC.W    $3140,$006A         ; $00A3B0 MOVE.W  D0,$006A(A0)
        DC.W    $3140,$0014         ; $00A3B4 MOVE.W  D0,$0014(A0)
loc_00A3B8:
        DC.W    $4E75               ; $00A3B8 RTS
        DC.W    $43F9,$0093,$925E   ; $00A3BA LEA     $0093925E,A1
        DC.W    $3028,$0004         ; $00A3C0 MOVE.W  $0004(A0),D0
        DC.W    $D040               ; $00A3C4 ADD.W  D0,D0
        DC.W    $3031,$0000         ; $00A3C6 MOVE.W  $00(A1,D0.W),D0
        DC.W    $0C78,$0002,$C8C8   ; $00A3CA CMPI.W  #$0002,$C8C8.W
        DC.W    $6602               ; $00A3D0 BNE.S  loc_00A3D4
        DC.W    $E440               ; $00A3D2 ASR.W  #2,D0
loc_00A3D4:
        DC.W    $3140,$0016         ; $00A3D4 MOVE.W  D0,$0016(A0)
        DC.W    $4A68,$0014         ; $00A3D8 TST.W  $0014(A0)
        DC.W    $6F0A               ; $00A3DC BLE.S  loc_00A3E8
        DC.W    $5368,$0014         ; $00A3DE SUBQ.W  #1,$0014(A0)
        DC.W    $0668,$0738,$0016   ; $00A3E2 ADDI.W  #$0738,$0016(A0)
loc_00A3E8:
        DC.W    $4E75               ; $00A3E8 RTS
        DC.W    $43F9,$0089,$9DA4   ; $00A3EA LEA     $00899DA4,A1
        DC.W    $3028,$0004         ; $00A3F0 MOVE.W  $0004(A0),D0
        DC.W    $D040               ; $00A3F4 ADD.W  D0,D0
        DC.W    $3231,$0000         ; $00A3F6 MOVE.W  $00(A1,D0.W),D1
        DC.W    $9268,$0016         ; $00A3FA SUB.W  $0016(A0),D1
        DC.W    $48C1               ; $00A3FE EXT.L   D1
        DC.W    $83FC,$0067         ; $00A400 DIVS    #$0067,D1
        DC.W    $3028,$0008         ; $00A404 MOVE.W  $0008(A0),D0
        DC.W    $9068,$0006         ; $00A408 SUB.W  $0006(A0),D0
        DC.W    $B278,$C0F8         ; $00A40C CMP.W  $C0F8.W,D1
        DC.W    $6F04               ; $00A410 BLE.S  loc_00A416
        DC.W    $3238,$C0F8         ; $00A412 MOVE.W  $C0F8.W,D1
loc_00A416:
        DC.W    $B041               ; $00A416 CMP.W  D1,D0
        DC.W    $6C0C               ; $00A418 BGE.S  loc_00A426
        DC.W    $B078,$C0FA         ; $00A41A CMP.W  $C0FA.W,D0
        DC.W    $6C08               ; $00A41E BGE.S  loc_00A428
        DC.W    $3038,$C0FA         ; $00A420 MOVE.W  $C0FA.W,D0
        DC.W    $6002               ; $00A424 BRA.S  loc_00A428
loc_00A426:
        DC.W    $3001               ; $00A426 MOVE.W  D1,D0
loc_00A428:
        DC.W    $D168,$0006         ; $00A428 ADD.W  D0,$0006(A0)
        DC.W    $6C04               ; $00A42C BGE.S  loc_00A432
        DC.W    $4268,$0006         ; $00A42E CLR.W  $0006(A0)
loc_00A432:
        DC.W    $4E75               ; $00A432 RTS
        DC.W    $0C78,$0001,$C8C8   ; $00A434 CMPI.W  #$0001,$C8C8.W
        DC.W    $6732               ; $00A43A BEQ.S  loc_00A46E
        DC.W    $0C68,$0059,$0004   ; $00A43C CMPI.W  #$0059,$0004(A0)
        DC.W    $6D2A               ; $00A442 BLT.S  loc_00A46E
        DC.W    $0C38,$0004,$C319   ; $00A444 CMPI.B  #$0004,$C319.W
        DC.W    $6622               ; $00A44A BNE.S  loc_00A46E
        DC.W    $4A68,$0086         ; $00A44C TST.W  $0086(A0)
        DC.W    $661C               ; $00A450 BNE.S  loc_00A46E
        DC.W    $317C,$000F,$0086   ; $00A452 MOVE.W  #$000F,$0086(A0)
        DC.W    $11FC,$00B7,$C8A4   ; $00A458 MOVE.B  #$00B7,$C8A4.W
        DC.W    $7000               ; $00A45E MOVEQ   #$00,D0
        DC.W    $0C68,$00C8,$0004   ; $00A460 CMPI.W  #$00C8,$0004(A0)
        DC.W    $6D02               ; $00A466 BLT.S  loc_00A46A
        DC.W    $7001               ; $00A468 MOVEQ   #$01,D0
loc_00A46A:
        DC.W    $3140,$00BE         ; $00A46A MOVE.W  D0,$00BE(A0)
loc_00A46E:
        DC.W    $4E75               ; $00A46E RTS
        DC.W    $2668,$0018         ; $00A470 MOVEA.L $0018(A0),A3
        DC.W    $3028,$0024         ; $00A474 MOVE.W  $0024(A0),D0
        DC.W    $3200               ; $00A478 MOVE.W  D0,D1
        DC.W    $D040               ; $00A47A ADD.W  D0,D0
        DC.W    $D240               ; $00A47C ADD.W  D0,D1
        DC.W    $D241               ; $00A47E ADD.W  D1,D1
        DC.W    $21F3,$100C,$A000   ; $00A480 MOVE.L  $0C(A3,D1.W),$A000.W
        DC.W    $303C,$0096         ; $00A486 MOVE.W  #$0096,D0
        DC.W    $4A68,$006A         ; $00A48A TST.W  $006A(A0)
        DC.W    $661A               ; $00A48E BNE.S  loc_00A4AA
        DC.W    $3028,$000A         ; $00A490 MOVE.W  $000A(A0),D0
        DC.W    $2278,$C280         ; $00A494 MOVEA.L $C280.W,A1
        DC.W    $3428,$00C2         ; $00A498 MOVE.W  $00C2(A0),D2
        DC.W    $E642               ; $00A49C ASR.W  #3,D2
        DC.W    $3431,$2000         ; $00A49E MOVE.W  $00(A1,D2.W),D2
        DC.W    $C5F3,$1004         ; $00A4A2 MULS    $04(A3,D1.W),D2
        DC.W    $E082               ; $00A4A6 ASR.L  #8,D2
        DC.W    $D042               ; $00A4A8 ADD.W  D2,D0
loc_00A4AA:
        DC.W    $3140,$0008         ; $00A4AA MOVE.W  D0,$0008(A0)
        DC.W    $0828,$0001,$0055   ; $00A4AE BTST    #1,$0055(A0)
        DC.W    $6700,$01B0         ; $00A4B4 BEQ.W  loc_00A666
        DC.W    $3028,$00A4         ; $00A4B8 MOVE.W  $00A4(A0),D0
        DC.W    $6700,$023A         ; $00A4BC BEQ.W  loc_00A6F8
        DC.W    $43F8,$9000         ; $00A4C0 LEA     $9000.W,A1
        DC.W    $E140               ; $00A4C4 ASL.W  #8,D0
        DC.W    $43F1,$0000         ; $00A4C6 LEA     $00(A1,D0.W),A1
        DC.W    $4A69,$00A4         ; $00A4CA TST.W  $00A4(A1)
        DC.W    $6700,$0228         ; $00A4CE BEQ.W  loc_00A6F8
        DC.W    $43F8,$9000         ; $00A4D2 LEA     $9000.W,A1
        DC.W    $3028,$00A6         ; $00A4D6 MOVE.W  $00A6(A0),D0
        DC.W    $670A               ; $00A4DA BEQ.S  loc_00A4E6
        DC.W    $0C68,$0082,$0004   ; $00A4DC CMPI.W  #$0082,$0004(A0)
        DC.W    $6D00,$0182         ; $00A4E2 BLT.W  loc_00A666
loc_00A4E6:
        DC.W    $E140               ; $00A4E6 ASL.W  #8,D0
        DC.W    $43F1,$0000         ; $00A4E8 LEA     $00(A1,D0.W),A1
        DC.W    $3029,$0030         ; $00A4EC MOVE.W  $0030(A1),D0
        DC.W    $9068,$0030         ; $00A4F0 SUB.W  $0030(A0),D0
        DC.W    $6A02               ; $00A4F4 BPL.S  loc_00A4F8
        DC.W    $4440               ; $00A4F6 NEG.W  D0
loc_00A4F8:
        DC.W    $3E29,$0034         ; $00A4F8 MOVE.W  $0034(A1),D7
        DC.W    $9E68,$0034         ; $00A4FC SUB.W  $0034(A0),D7
        DC.W    $6A02               ; $00A500 BPL.S  loc_00A504
        DC.W    $4447               ; $00A502 NEG.W  D7
loc_00A504:
        DC.W    $DE40               ; $00A504 ADD.W  D0,D7
        DC.W    $3629,$0072         ; $00A506 MOVE.W  $0072(A1),D3
        DC.W    $9668,$0072         ; $00A50A SUB.W  $0072(A0),D3
        DC.W    $3C03               ; $00A50E MOVE.W  D3,D6
        DC.W    $6A02               ; $00A510 BPL.S  loc_00A514
        DC.W    $4446               ; $00A512 NEG.W  D6
loc_00A514:
        DC.W    $0C47,$0140         ; $00A514 CMPI.W  #$0140,D7
        DC.W    $6C00,$0068         ; $00A518 BGE.W  loc_00A582
        DC.W    $0C47,$00A0         ; $00A51C CMPI.W  #$00A0,D7
        DC.W    $6F0C               ; $00A520 BLE.S  loc_00A52E
        DC.W    $3028,$0004         ; $00A522 MOVE.W  $0004(A0),D0
        DC.W    $9069,$0004         ; $00A526 SUB.W  $0004(A1),D0
        DC.W    $6E00,$0030         ; $00A52A BGT.W  loc_00A55C
loc_00A52E:
        DC.W    $0C46,$0040         ; $00A52E CMPI.W  #$0040,D6
        DC.W    $6C28               ; $00A532 BGE.S  loc_00A55C
        DC.W    $7040               ; $00A534 MOVEQ   #$40,D0
        DC.W    $9046               ; $00A536 SUB.W  D6,D0
        DC.W    $4A43               ; $00A538 TST.W  D3
        DC.W    $6A02               ; $00A53A BPL.S  loc_00A53E
        DC.W    $4440               ; $00A53C NEG.W  D0
loc_00A53E:
        DC.W    $0C78,$001C,$C07A   ; $00A53E CMPI.W  #$001C,$C07A.W
        DC.W    $670A               ; $00A544 BEQ.S  loc_00A550
        DC.W    $D040               ; $00A546 ADD.W  D0,D0
        DC.W    $3200               ; $00A548 MOVE.W  D0,D1
        DC.W    $D040               ; $00A54A ADD.W  D0,D0
        DC.W    $D041               ; $00A54C ADD.W  D1,D0
        DC.W    $6008               ; $00A54E BRA.S  loc_00A558
loc_00A550:
        DC.W    $E540               ; $00A550 ASL.W  #2,D0
        DC.W    $3200               ; $00A552 MOVE.W  D0,D1
        DC.W    $E741               ; $00A554 ASL.W  #3,D1
        DC.W    $D041               ; $00A556 ADD.W  D1,D0
loc_00A558:
        DC.W    $D168,$0040         ; $00A558 ADD.W  D0,$0040(A0)
loc_00A55C:
        DC.W    $0C47,$0070         ; $00A55C CMPI.W  #$0070,D7
        DC.W    $6C20               ; $00A560 BGE.S  loc_00A582
        DC.W    $3029,$0040         ; $00A562 MOVE.W  $0040(A1),D0
        DC.W    $9068,$0040         ; $00A566 SUB.W  $0040(A0),D0
        DC.W    $3200               ; $00A56A MOVE.W  D0,D1
        DC.W    $4A43               ; $00A56C TST.W  D3
        DC.W    $6D02               ; $00A56E BLT.S  loc_00A572
        DC.W    $4441               ; $00A570 NEG.W  D1
loc_00A572:
        DC.W    $4A41               ; $00A572 TST.W  D1
        DC.W    $6D0C               ; $00A574 BLT.S  loc_00A582
        DC.W    $0C41,$1800         ; $00A576 CMPI.W  #$1800,D1
        DC.W    $6C06               ; $00A57A BGE.S  loc_00A582
        DC.W    $E240               ; $00A57C ASR.W  #1,D0
        DC.W    $D168,$0040         ; $00A57E ADD.W  D0,$0040(A0)
loc_00A582:
        DC.W    $45F8,$9000         ; $00A582 LEA     $9000.W,A2
        DC.W    $3028,$00A4         ; $00A586 MOVE.W  $00A4(A0),D0
        DC.W    $E148               ; $00A58A LSL.W  #8,D0
        DC.W    $43F2,$0000         ; $00A58C LEA     $00(A2,D0.W),A1
        DC.W    $3029,$00A4         ; $00A590 MOVE.W  $00A4(A1),D0
        DC.W    $6616               ; $00A594 BNE.S  loc_00A5AC
        DC.W    $E148               ; $00A596 LSL.W  #8,D0
        DC.W    $45F2,$0000         ; $00A598 LEA     $00(A2,D0.W),A2
        DC.W    $302A,$0024         ; $00A59C MOVE.W  $0024(A2),D0
        DC.W    $9069,$0024         ; $00A5A0 SUB.W  $0024(A1),D0
        DC.W    $0C40,$0004         ; $00A5A4 CMPI.W  #$0004,D0
        DC.W    $6E02               ; $00A5A8 BGT.S  loc_00A5AC
        DC.W    $43D2               ; $00A5AA LEA     (A2),A1
loc_00A5AC:
        DC.W    $3029,$0030         ; $00A5AC MOVE.W  $0030(A1),D0
        DC.W    $9068,$0030         ; $00A5B0 SUB.W  $0030(A0),D0
        DC.W    $6A02               ; $00A5B4 BPL.S  loc_00A5B8
        DC.W    $4440               ; $00A5B6 NEG.W  D0
loc_00A5B8:
        DC.W    $3E29,$0034         ; $00A5B8 MOVE.W  $0034(A1),D7
        DC.W    $9E68,$0034         ; $00A5BC SUB.W  $0034(A0),D7
        DC.W    $6A02               ; $00A5C0 BPL.S  loc_00A5C4
        DC.W    $4447               ; $00A5C2 NEG.W  D7
loc_00A5C4:
        DC.W    $DE40               ; $00A5C4 ADD.W  D0,D7
        DC.W    $3629,$0072         ; $00A5C6 MOVE.W  $0072(A1),D3
        DC.W    $9668,$0072         ; $00A5CA SUB.W  $0072(A0),D3
        DC.W    $3C03               ; $00A5CE MOVE.W  D3,D6
        DC.W    $6A02               ; $00A5D0 BPL.S  loc_00A5D4
        DC.W    $4446               ; $00A5D2 NEG.W  D6
loc_00A5D4:
        DC.W    $3029,$0006         ; $00A5D4 MOVE.W  $0006(A1),D0
        DC.W    $9068,$0006         ; $00A5D8 SUB.W  $0006(A0),D0
        DC.W    $6C28               ; $00A5DC BGE.S  loc_00A606
        DC.W    $0C47,$01E0         ; $00A5DE CMPI.W  #$01E0,D7
        DC.W    $6E22               ; $00A5E2 BGT.S  loc_00A606
        DC.W    $0C47,$0040         ; $00A5E4 CMPI.W  #$0040,D7
        DC.W    $6F1C               ; $00A5E8 BLE.S  loc_00A606
        DC.W    $0C46,$0030         ; $00A5EA CMPI.W  #$0030,D6
        DC.W    $6E16               ; $00A5EE BGT.S  loc_00A606
        DC.W    $0C68,$0064,$0004   ; $00A5F0 CMPI.W  #$0064,$0004(A0)
        DC.W    $6F0E               ; $00A5F6 BLE.S  loc_00A606
        DC.W    $323C,$01E0         ; $00A5F8 MOVE.W  #$01E0,D1
        DC.W    $9247               ; $00A5FC SUB.W  D7,D1
        DC.W    $EC41               ; $00A5FE ASR.W  #6,D1
        DC.W    $E360               ; $00A600 ASL.W  D1,D0
        DC.W    $D168,$0008         ; $00A602 ADD.W  D0,$0008(A0)
loc_00A606:
        DC.W    $0C46,$0070         ; $00A606 CMPI.W  #$0070,D6
        DC.W    $6C00,$0034         ; $00A60A BGE.W  loc_00A640
        DC.W    $4A40               ; $00A60E TST.W  D0
        DC.W    $6F06               ; $00A610 BLE.S  loc_00A618
        DC.W    $0C47,$00A0         ; $00A612 CMPI.W  #$00A0,D7
        DC.W    $6E28               ; $00A616 BGT.S  loc_00A640
loc_00A618:
        DC.W    $4440               ; $00A618 NEG.W  D0
        DC.W    $E240               ; $00A61A ASR.W  #1,D0
        DC.W    $0640,$0A00         ; $00A61C ADDI.W  #$0A00,D0
        DC.W    $3207               ; $00A620 MOVE.W  D7,D1
        DC.W    $E941               ; $00A622 ASL.W  #4,D1
        DC.W    $B041               ; $00A624 CMP.W  D1,D0
        DC.W    $6E18               ; $00A626 BGT.S  loc_00A640
        DC.W    $0C46,$0040         ; $00A628 CMPI.W  #$0040,D6
        DC.W    $6C12               ; $00A62C BGE.S  loc_00A640
        DC.W    $7040               ; $00A62E MOVEQ   #$40,D0
        DC.W    $9046               ; $00A630 SUB.W  D6,D0
        DC.W    $4A43               ; $00A632 TST.W  D3
        DC.W    $6A02               ; $00A634 BPL.S  loc_00A638
        DC.W    $4440               ; $00A636 NEG.W  D0
loc_00A638:
        DC.W    $D040               ; $00A638 ADD.W  D0,D0
        DC.W    $D040               ; $00A63A ADD.W  D0,D0
        DC.W    $D168,$0040         ; $00A63C ADD.W  D0,$0040(A0)
loc_00A640:
        DC.W    $0C47,$0070         ; $00A640 CMPI.W  #$0070,D7
        DC.W    $6C20               ; $00A644 BGE.S  loc_00A666
        DC.W    $3029,$0040         ; $00A646 MOVE.W  $0040(A1),D0
        DC.W    $9068,$0040         ; $00A64A SUB.W  $0040(A0),D0
        DC.W    $3200               ; $00A64E MOVE.W  D0,D1
        DC.W    $4A43               ; $00A650 TST.W  D3
        DC.W    $6D02               ; $00A652 BLT.S  loc_00A656
        DC.W    $4441               ; $00A654 NEG.W  D1
loc_00A656:
        DC.W    $4A41               ; $00A656 TST.W  D1
        DC.W    $6F0C               ; $00A658 BLE.S  loc_00A666
        DC.W    $0C41,$1800         ; $00A65A CMPI.W  #$1800,D1
        DC.W    $6C06               ; $00A65E BGE.S  loc_00A666
        DC.W    $E240               ; $00A660 ASR.W  #1,D0
        DC.W    $D168,$0040         ; $00A662 ADD.W  D0,$0040(A0)
loc_00A666:
        DC.W    $3038,$A000         ; $00A666 MOVE.W  $A000.W,D0
        DC.W    $9068,$0030         ; $00A66A SUB.W  $0030(A0),D0
        DC.W    $6A02               ; $00A66E BPL.S  loc_00A672
        DC.W    $4440               ; $00A670 NEG.W  D0
loc_00A672:
        DC.W    $3238,$A002         ; $00A672 MOVE.W  $A002.W,D1
        DC.W    $9268,$0034         ; $00A676 SUB.W  $0034(A0),D1
        DC.W    $6A02               ; $00A67A BPL.S  loc_00A67E
        DC.W    $4441               ; $00A67C NEG.W  D1
loc_00A67E:
        DC.W    $D041               ; $00A67E ADD.W  D1,D0
        DC.W    $48C0               ; $00A680 EXT.L   D0
        DC.W    $E988               ; $00A682 LSL.L  #4,D0
        DC.W    $3228,$0006         ; $00A684 MOVE.W  $0006(A0),D1
        DC.W    $5241               ; $00A688 ADDQ.W  #1,D1
        DC.W    $81C1               ; $00A68A DIVS    D1,D0
        DC.W    $3C00               ; $00A68C MOVE.W  D0,D6
        DC.W    $E246               ; $00A68E ASR.W  #1,D6
        DC.W    $6E04               ; $00A690 BGT.S  loc_00A696
        DC.W    $7C01               ; $00A692 MOVEQ   #$01,D6
        DC.W    $600C               ; $00A694 BRA.S  loc_00A6A2
loc_00A696:
        DC.W    $3228,$0054         ; $00A696 MOVE.W  $0054(A0),D1
        DC.W    $0241,$0001         ; $00A69A ANDI.W  #$0001,D1
        DC.W    $6702               ; $00A69E BEQ.S  loc_00A6A2
        DC.W    $7C02               ; $00A6A0 MOVEQ   #$02,D6
loc_00A6A2:
        DC.W    $3028,$0034         ; $00A6A2 MOVE.W  $0034(A0),D0
        DC.W    $3228,$0030         ; $00A6A6 MOVE.W  $0030(A0),D1
        DC.W    $4441               ; $00A6AA NEG.W  D1
        DC.W    $3438,$A002         ; $00A6AC MOVE.W  $A002.W,D2
        DC.W    $3638,$A000         ; $00A6B0 MOVE.W  $A000.W,D3
        DC.W    $4443               ; $00A6B4 NEG.W  D3
        DC.W    $4EBA,$00E8         ; $00A6B6 JSR     loc_00A7A0(PC)
        DC.W    $9068,$0040         ; $00A6BA SUB.W  $0040(A0),D0
        DC.W    $48C0               ; $00A6BE EXT.L   D0
        DC.W    $81C6               ; $00A6C0 DIVS    D6,D0
        DC.W    $D168,$0040         ; $00A6C2 ADD.W  D0,$0040(A0)
        DC.W    $3028,$0040         ; $00A6C6 MOVE.W  $0040(A0),D0
        DC.W    $3140,$003C         ; $00A6CA MOVE.W  D0,$003C(A0)
        DC.W    $4440               ; $00A6CE NEG.W  D0
        DC.W    $4EBA,$E880         ; $00A6D0 JSR     $008F52(PC)
        DC.W    $C1E8,$0006         ; $00A6D4 MULS    $0006(A0),D0
        DC.W    $E080               ; $00A6D8 ASR.L  #8,D0
        DC.W    $E840               ; $00A6DA ASR.W  #4,D0
        DC.W    $D168,$0030         ; $00A6DC ADD.W  D0,$0030(A0)
        DC.W    $3028,$0040         ; $00A6E0 MOVE.W  $0040(A0),D0
        DC.W    $4440               ; $00A6E4 NEG.W  D0
        DC.W    $4EBA,$E866         ; $00A6E6 JSR     $008F4E(PC)
        DC.W    $C1E8,$0006         ; $00A6EA MULS    $0006(A0),D0
        DC.W    $E080               ; $00A6EE ASR.L  #8,D0
        DC.W    $E840               ; $00A6F0 ASR.W  #4,D0
        DC.W    $D168,$0034         ; $00A6F2 ADD.W  D0,$0034(A0)
        DC.W    $4E75               ; $00A6F6 RTS
loc_00A6F8:
        DC.W    $43F8,$9000         ; $00A6F8 LEA     $9000.W,A1
        DC.W    $3029,$0030         ; $00A6FC MOVE.W  $0030(A1),D0
        DC.W    $9068,$0030         ; $00A700 SUB.W  $0030(A0),D0
        DC.W    $6A02               ; $00A704 BPL.S  loc_00A708
        DC.W    $4440               ; $00A706 NEG.W  D0
loc_00A708:
        DC.W    $3E29,$0034         ; $00A708 MOVE.W  $0034(A1),D7
        DC.W    $9E68,$0034         ; $00A70C SUB.W  $0034(A0),D7
        DC.W    $6A02               ; $00A710 BPL.S  loc_00A714
        DC.W    $4447               ; $00A712 NEG.W  D7
loc_00A714:
        DC.W    $DE40               ; $00A714 ADD.W  D0,D7
        DC.W    $3629,$0072         ; $00A716 MOVE.W  $0072(A1),D3
        DC.W    $9668,$0072         ; $00A71A SUB.W  $0072(A0),D3
        DC.W    $3C03               ; $00A71E MOVE.W  D3,D6
        DC.W    $6A02               ; $00A720 BPL.S  loc_00A724
        DC.W    $4446               ; $00A722 NEG.W  D6
loc_00A724:
        DC.W    $3029,$0006         ; $00A724 MOVE.W  $0006(A1),D0
        DC.W    $9068,$0006         ; $00A728 SUB.W  $0006(A0),D0
        DC.W    $6C00,$FF38         ; $00A72C BGE.W  loc_00A666
        DC.W    $0C47,$0230         ; $00A730 CMPI.W  #$0230,D7
        DC.W    $6E00,$FF30         ; $00A734 BGT.W  loc_00A666
        DC.W    $0C46,$0040         ; $00A738 CMPI.W  #$0040,D6
        DC.W    $6E00,$FF28         ; $00A73C BGT.W  loc_00A666
        DC.W    $0C68,$0064,$0004   ; $00A740 CMPI.W  #$0064,$0004(A0)
        DC.W    $6F54               ; $00A746 BLE.S  loc_00A79C
        DC.W    $323C,$0230         ; $00A748 MOVE.W  #$0230,D1
        DC.W    $9247               ; $00A74C SUB.W  D7,D1
        DC.W    $EC41               ; $00A74E ASR.W  #6,D1
        DC.W    $E360               ; $00A750 ASL.W  D1,D0
        DC.W    $D168,$0008         ; $00A752 ADD.W  D0,$0008(A0)
        DC.W    $6A04               ; $00A756 BPL.S  loc_00A75C
        DC.W    $4268,$0008         ; $00A758 CLR.W  $0008(A0)
loc_00A75C:
        DC.W    $0C46,$0070         ; $00A75C CMPI.W  #$0070,D6
        DC.W    $6C00,$003A         ; $00A760 BGE.W  loc_00A79C
        DC.W    $4A40               ; $00A764 TST.W  D0
        DC.W    $6F06               ; $00A766 BLE.S  loc_00A76E
        DC.W    $0C47,$00F0         ; $00A768 CMPI.W  #$00F0,D7
        DC.W    $6E2E               ; $00A76C BGT.S  loc_00A79C
loc_00A76E:
        DC.W    $4440               ; $00A76E NEG.W  D0
        DC.W    $E240               ; $00A770 ASR.W  #1,D0
        DC.W    $0640,$0F00         ; $00A772 ADDI.W  #$0F00,D0
        DC.W    $3207               ; $00A776 MOVE.W  D7,D1
        DC.W    $E941               ; $00A778 ASL.W  #4,D1
        DC.W    $B041               ; $00A77A CMP.W  D1,D0
        DC.W    $6E1E               ; $00A77C BGT.S  loc_00A79C
        DC.W    $0C46,$0060         ; $00A77E CMPI.W  #$0060,D6
        DC.W    $6C00,$0018         ; $00A782 BGE.W  loc_00A79C
        DC.W    $7060               ; $00A786 MOVEQ   #$60,D0
        DC.W    $9046               ; $00A788 SUB.W  D6,D0
        DC.W    $4A43               ; $00A78A TST.W  D3
        DC.W    $6A02               ; $00A78C BPL.S  loc_00A790
        DC.W    $4440               ; $00A78E NEG.W  D0
loc_00A790:
        DC.W    $E740               ; $00A790 ASL.W  #3,D0
        DC.W    $3200               ; $00A792 MOVE.W  D0,D1
        DC.W    $D241               ; $00A794 ADD.W  D1,D1
        DC.W    $D041               ; $00A796 ADD.W  D1,D0
        DC.W    $D168,$0040         ; $00A798 ADD.W  D0,$0040(A0)
loc_00A79C:
        DC.W    $6000,$FEC8         ; $00A79C BRA.W  loc_00A666
loc_00A7A0:
        DC.W    $9641               ; $00A7A0 SUB.W  D1,D3
        DC.W    $9440               ; $00A7A2 SUB.W  D0,D2
        DC.W    $660A               ; $00A7A4 BNE.S  loc_00A7B0
        DC.W    $4A43               ; $00A7A6 TST.W  D3
        DC.W    $6E14               ; $00A7A8 BGT.S  loc_00A7BE
        DC.W    $6D18               ; $00A7AA BLT.S  loc_00A7C4
        DC.W    $7000               ; $00A7AC MOVEQ   #$00,D0
        DC.W    $4E75               ; $00A7AE RTS
loc_00A7B0:
        DC.W    $3003               ; $00A7B0 MOVE.W  D3,D0
        DC.W    $48C0               ; $00A7B2 EXT.L   D0
        DC.W    $E180               ; $00A7B4 ASL.L  #8,D0
        DC.W    $81C2               ; $00A7B6 DIVS    D2,D0
        DC.W    $6810               ; $00A7B8 BVC.S  loc_00A7CA
        DC.W    $4A43               ; $00A7BA TST.W  D3
        DC.W    $6B06               ; $00A7BC BMI.S  loc_00A7C4
loc_00A7BE:
        DC.W    $303C,$4000         ; $00A7BE MOVE.W  #$4000,D0
        DC.W    $4E75               ; $00A7C2 RTS
loc_00A7C4:
        DC.W    $303C,$C000         ; $00A7C4 MOVE.W  #$C000,D0
        DC.W    $4E75               ; $00A7C8 RTS
loc_00A7CA:
        DC.W    $48C0               ; $00A7CA EXT.L   D0
        DC.W    $48E7,$2040         ; $00A7CC MOVEM.L -(A7),D6/A5
        DC.W    $4EBA,$E7F6         ; $00A7D0 JSR     $008FC8(PC)
        DC.W    $4CDF,$0204         ; $00A7D4 MOVEM.L D2/A1,(A7)+
        DC.W    $4A42               ; $00A7D8 TST.W  D2
        DC.W    $6C04               ; $00A7DA BGE.S  loc_00A7E0
        DC.W    $0640,$8000         ; $00A7DC ADDI.W  #$8000,D0
loc_00A7E0:
        DC.W    $4E75               ; $00A7E0 RTS
        DC.W    $43F9,$0093,$8F2E   ; $00A7E2 LEA     $00938F2E,A1
        DC.W    $3038,$C89C         ; $00A7E8 MOVE.W  $C89C.W,D0
        DC.W    $EB40               ; $00A7EC ASL.W  #5,D0
        DC.W    $43F1,$0000         ; $00A7EE LEA     $00(A1,D0.W),A1
        DC.W    $45F8,$9100         ; $00A7F2 LEA     $9100.W,A2
        DC.W    $700E               ; $00A7F6 MOVEQ   #$0E,D0
loc_00A7F8:
        DC.W    $3551,$00B6         ; $00A7F8 MOVE.W  (A1),$00B6(A2)
        DC.W    $3559,$000A         ; $00A7FC MOVE.W  (A1)+,$000A(A2)
        DC.W    $45EA,$0100         ; $00A800 LEA     $0100(A2),A2
        DC.W    $51C8,$FFF2         ; $00A804 DBRA    D0,loc_00A7F8
        DC.W    $4E75               ; $00A808 RTS
        DC.W    $7200               ; $00A80A MOVEQ   #$00,D1
        DC.W    $1238,$FDA9         ; $00A80C MOVE.B  $FDA9.W,D1
        DC.W    $43F8,$FAD8         ; $00A810 LEA     $FAD8.W,A1
        DC.W    $3038,$C8C8         ; $00A814 MOVE.W  $C8C8.W,D0
        DC.W    $C1FC,$0060         ; $00A818 MULS    #$0060,D0
        DC.W    $C3FC,$0020         ; $00A81C MULS    #$0020,D1
        DC.W    $D041               ; $00A820 ADD.W  D1,D0
        DC.W    $43F1,$0000         ; $00A822 LEA     $00(A1,D0.W),A1
        DC.W    $45F8,$9100         ; $00A826 LEA     $9100.W,A2
        DC.W    $700E               ; $00A82A MOVEQ   #$0E,D0
loc_00A82C:
        DC.W    $3551,$00B6         ; $00A82C MOVE.W  (A1),$00B6(A2)
        DC.W    $3559,$000A         ; $00A830 MOVE.W  (A1)+,$000A(A2)
        DC.W    $45EA,$0100         ; $00A834 LEA     $0100(A2),A2
        DC.W    $51C8,$FFF2         ; $00A838 DBRA    D0,loc_00A82C
        DC.W    $4E75               ; $00A83C RTS
        DC.W    $43F9,$0093,$7E7E   ; $00A83E LEA     $00937E7E,A1
        DC.W    $45F8,$FAD8         ; $00A844 LEA     $FAD8.W,A2
        DC.W    $303C,$0047         ; $00A848 MOVE.W  #$0047,D0
loc_00A84C:
        DC.W    $24D9               ; $00A84C MOVE.L  (A1)+,(A2)+
        DC.W    $51C8,$FFFC         ; $00A84E DBRA    D0,loc_00A84C
        DC.W    $43F9,$0093,$7F9E   ; $00A852 LEA     $00937F9E,A1
        DC.W    $45F8,$FBF8         ; $00A858 LEA     $FBF8.W,A2
        DC.W    $303C,$006B         ; $00A85C MOVE.W  #$006B,D0
loc_00A860:
        DC.W    $24D9               ; $00A860 MOVE.L  (A1)+,(A2)+
        DC.W    $51C8,$FFFC         ; $00A862 DBRA    D0,loc_00A860
        DC.W    $4E75               ; $00A866 RTS
        DC.W    $F190,$F1F0         ; $00A868 MOVE.W  (A0),-$10(A0,A7.W)
        DC.W    $F128,$F060         ; $00A86C MOVE.W  -$0FA0(A0),-(A0)
        DC.W    $F128,$EED0         ; $00A870 MOVE.W  -$1130(A0),-(A0)
        DC.W    $F128,$ED40         ; $00A874 MOVE.W  -$12C0(A0),-(A0)
        DC.W    $F128,$F380         ; $00A878 MOVE.W  -$0C80(A0),-(A0)
        DC.W    $F128,$F060         ; $00A87C MOVE.W  -$0FA0(A0),-(A0)
        DC.W    $F128,$ED40         ; $00A880 MOVE.W  -$12C0(A0),-(A0)
        DC.W    $F128,$EA20         ; $00A884 MOVE.W  -$15E0(A0),-(A0)
        DC.W    $EA70               ; $00A888 ROXR.W  D5,D0
        DC.W    $FB50,$EA70         ; $00A88A MOVE.W  (A0),-$1590(A5)
        DC.W    $FA88               ; $00A88E MOVE.W  A0,(A5)
        DC.W    $EA70               ; $00A890 ROXR.W  D5,D0
        DC.W    $F9C0,$EA70         ; $00A892 MOVE.W  D0,#$EA70
        DC.W    $F8F8,$E900         ; $00A896 MOVE.W  $E900.W,(A4)+
        DC.W    $0800,$F128         ; $00A89A BTST    #8,D0
        DC.W    $F060               ; $00A89E MOVEA.W -(A0),A0
        DC.W    $F128,$ED40         ; $00A8A0 MOVE.W  -$12C0(A0),-(A0)
        DC.W    $F128,$EA20         ; $00A8A4 MOVE.W  -$15E0(A0),-(A0)
        DC.W    $F128,$F380         ; $00A8A8 MOVE.W  -$0C80(A0),-(A0)
        DC.W    $F128,$F060         ; $00A8AC MOVE.W  -$0FA0(A0),-(A0)
        DC.W    $F128,$ED40         ; $00A8B0 MOVE.W  -$12C0(A0),-(A0)
        DC.W    $F128,$EA20         ; $00A8B4 MOVE.W  -$15E0(A0),-(A0)
        DC.W    $F128,$F380         ; $00A8B8 MOVE.W  -$0C80(A0),-(A0)
        DC.W    $F128,$F060         ; $00A8BC MOVE.W  -$0FA0(A0),-(A0)
        DC.W    $F128,$ED40         ; $00A8C0 MOVE.W  -$12C0(A0),-(A0)
        DC.W    $F128,$EA20         ; $00A8C4 MOVE.W  -$15E0(A0),-(A0)
        DC.W    $0100               ; $00A8C8 BTST    D0,D0
        DC.W    $0080,$0080,$0080   ; $00A8CA ORI.L  #$00800080,D0
        DC.W    $0080,$0080,$0088   ; $00A8D0 ORI.L  #$00800088,D0
        DC.W    $A972,$0088,$AB88   ; $00A8D6 MOVE.L  -$78(A2,D0.W),-$5478(A4)
        DC.W    $0088,$ABCE,$3028   ; $00A8DC ORI.L  #$ABCE3028,A0
        DC.W    $00AE,$D040,$43F8,$C05C; $00A8E2 ORI.L  #$D04043F8,-$3FA4(A6)
        DC.W    $3031,$0000         ; $00A8EA MOVE.W  $00(A1,D0.W),D0
        DC.W    $D040               ; $00A8EE ADD.W  D0,D0
        DC.W    $D040               ; $00A8F0 ADD.W  D0,D0
        DC.W    $227B,$00DC         ; $00A8F2 MOVEA.L -$24(PC,D0.W),A1
        DC.W    $4ED1               ; $00A8F6 JMP     (A1)
loc_00A8F8:
        DC.W    $4A68,$0004         ; $00A8F8 TST.W  $0004(A0)
        DC.W    $6734               ; $00A8FC BEQ.S  loc_00A932
        DC.W    $3028,$0006         ; $00A8FE MOVE.W  $0006(A0),D0
        DC.W    $2278,$C278         ; $00A902 MOVEA.L $C278.W,A1
        DC.W    $3228,$007A         ; $00A906 MOVE.W  $007A(A0),D1
        DC.W    $D241               ; $00A90A ADD.W  D1,D1
        DC.W    $C1F1,$1000         ; $00A90C MULS    $00(A1,D1.W),D0
        DC.W    $C1FC,$0254         ; $00A910 MULS    #$0254,D0
        DC.W    $E048               ; $00A914 LSR.W  #8,D0
        DC.W    $E848               ; $00A916 LSR.W  #4,D0
        DC.W    $0C40,$4268         ; $00A918 CMPI.W  #$4268,D0
        DC.W    $6F04               ; $00A91C BLE.S  loc_00A922
        DC.W    $303C,$4268         ; $00A91E MOVE.W  #$4268,D0
loc_00A922:
        DC.W    $0C40,$0000         ; $00A922 CMPI.W  #$0000,D0
        DC.W    $6C04               ; $00A926 BGE.S  loc_00A92C
        DC.W    $303C,$0000         ; $00A928 MOVE.W  #$0000,D0
loc_00A92C:
        DC.W    $3140,$0074         ; $00A92C MOVE.W  D0,$0074(A0)
        DC.W    $603E               ; $00A930 BRA.S  loc_00A970
loc_00A932:
        DC.W    $3028,$000E         ; $00A932 MOVE.W  $000E(A0),D0
        DC.W    $ED48               ; $00A936 LSL.W  #6,D0
        DC.W    $9068,$0074         ; $00A938 SUB.W  $0074(A0),D0
        DC.W    $0C40,$0400         ; $00A93C CMPI.W  #$0400,D0
        DC.W    $6F04               ; $00A940 BLE.S  loc_00A946
        DC.W    $303C,$0400         ; $00A942 MOVE.W  #$0400,D0
loc_00A946:
        DC.W    $0C40,$FD00         ; $00A946 CMPI.W  #$FD00,D0
        DC.W    $6C04               ; $00A94A BGE.S  loc_00A950
        DC.W    $303C,$FD00         ; $00A94C MOVE.W  #$FD00,D0
loc_00A950:
        DC.W    $D068,$0074         ; $00A950 ADD.W  $0074(A0),D0
        DC.W    $0C40,$3E80         ; $00A954 CMPI.W  #$3E80,D0
        DC.W    $6F04               ; $00A958 BLE.S  loc_00A95E
        DC.W    $303C,$3E80         ; $00A95A MOVE.W  #$3E80,D0
loc_00A95E:
        DC.W    $0C40,$0000         ; $00A95E CMPI.W  #$0000,D0
        DC.W    $6C04               ; $00A962 BGE.S  loc_00A968
        DC.W    $303C,$0000         ; $00A964 MOVE.W  #$0000,D0
loc_00A968:
        DC.W    $3140,$007E         ; $00A968 MOVE.W  D0,$007E(A0)
        DC.W    $3140,$0074         ; $00A96C MOVE.W  D0,$0074(A0)
loc_00A970:
        DC.W    $4E75               ; $00A970 RTS
        DC.W    $4EBA,$034C         ; $00A972 JSR     loc_00ACC0(PC)
        DC.W    $4A78,$C04E         ; $00A976 TST.W  $C04E.W
        DC.W    $6604               ; $00A97A BNE.S  loc_00A980
        DC.W    $5378,$C04E         ; $00A97C SUBQ.W  #1,$C04E.W
loc_00A980:
        DC.W    $4278,$C026         ; $00A980 CLR.W  $C026.W
        DC.W    $4238,$C306         ; $00A984 CLR.B  $C306.W
        DC.W    $4EBA,$92F4         ; $00A988 JSR     $003C7E(PC)
        DC.W    $43FA,$FF3A         ; $00A98C LEA     -$00C6(PC),A1
        DC.W    $3038,$C89E         ; $00A990 MOVE.W  $C89E.W,D0
        DC.W    $3A31,$0000         ; $00A994 MOVE.W  $00(A1,D0.W),D5
        DC.W    $43FA,$FECE         ; $00A998 LEA     -$0132(PC),A1
        DC.W    $3238,$C8A0         ; $00A99C MOVE.W  $C8A0.W,D1
        DC.W    $D241               ; $00A9A0 ADD.W  D1,D1
        DC.W    $D241               ; $00A9A2 ADD.W  D1,D1
        DC.W    $3028,$00AE         ; $00A9A4 MOVE.W  $00AE(A0),D0
        DC.W    $D040               ; $00A9A8 ADD.W  D0,D0
        DC.W    $D040               ; $00A9AA ADD.W  D0,D0
        DC.W    $D041               ; $00A9AC ADD.W  D1,D0
        DC.W    $3231,$0000         ; $00A9AE MOVE.W  $00(A1,D0.W),D1
        DC.W    $3431,$0002         ; $00A9B2 MOVE.W  $02(A1,D0.W),D2
        DC.W    $3802               ; $00A9B6 MOVE.W  D2,D4
        DC.W    $9868,$0034         ; $00A9B8 SUB.W  $0034(A0),D4
        DC.W    $0C44,$0002         ; $00A9BC CMPI.W  #$0002,D4
        DC.W    $6C58               ; $00A9C0 BGE.S  loc_00AA1A
        DC.W    $3141,$0030         ; $00A9C2 MOVE.W  D1,$0030(A0)
        DC.W    $3142,$0034         ; $00A9C6 MOVE.W  D2,$0034(A0)
        DC.W    $7000               ; $00A9CA MOVEQ   #$00,D0
        DC.W    $3140,$003C         ; $00A9CC MOVE.W  D0,$003C(A0)
        DC.W    $3140,$0040         ; $00A9D0 MOVE.W  D0,$0040(A0)
        DC.W    $3140,$008E         ; $00A9D4 MOVE.W  D0,$008E(A0)
        DC.W    $3140,$0090         ; $00A9D8 MOVE.W  D0,$0090(A0)
        DC.W    $3140,$0006         ; $00A9DC MOVE.W  D0,$0006(A0)
        DC.W    $3140,$0004         ; $00A9E0 MOVE.W  D0,$0004(A0)
        DC.W    $3140,$007A         ; $00A9E4 MOVE.W  D0,$007A(A0)
        DC.W    $3140,$0092         ; $00A9E8 MOVE.W  D0,$0092(A0)
        DC.W    $3140,$0014         ; $00A9EC MOVE.W  D0,$0014(A0)
        DC.W    $3140,$008C         ; $00A9F0 MOVE.W  D0,$008C(A0)
        DC.W    $3140,$00B8         ; $00A9F4 MOVE.W  D0,$00B8(A0)
        DC.W    $4278,$C02C         ; $00A9F8 CLR.W  $C02C.W
        DC.W    $43F8,$C05C         ; $00A9FC LEA     $C05C.W,A1
        DC.W    $3028,$00AE         ; $00AA00 MOVE.W  $00AE(A0),D0
        DC.W    $D040               ; $00AA04 ADD.W  D0,D0
        DC.W    $33BC,$0002,$0000   ; $00AA06 MOVE.W  #$0002,$00(A1,D0.W)
        DC.W    $317C,$0078,$00B0   ; $00AA0C MOVE.W  #$0078,$00B0(A0)
        DC.W    $4278,$C04E         ; $00AA12 CLR.W  $C04E.W
        DC.W    $4EFA,$E8FA         ; $00AA16 JMP     $009312(PC)
loc_00AA1A:
        DC.W    $0C44,$0080         ; $00AA1A CMPI.W  #$0080,D4
        DC.W    $6E12               ; $00AA1E BGT.S  loc_00AA32
        DC.W    $31C1,$A002         ; $00AA20 MOVE.W  D1,$A002.W
        DC.W    $31C2,$A004         ; $00AA24 MOVE.W  D2,$A004.W
        DC.W    $31FC,$0020,$A006   ; $00AA28 MOVE.W  #$0020,$A006.W
        DC.W    $6000,$0078         ; $00AA2E BRA.W  loc_00AAA8
loc_00AA32:
        DC.W    $0C44,$0180         ; $00AA32 CMPI.W  #$0180,D4
        DC.W    $6E20               ; $00AA36 BGT.S  loc_00AA58
        DC.W    $31C1,$A002         ; $00AA38 MOVE.W  D1,$A002.W
        DC.W    $31C2,$A004         ; $00AA3C MOVE.W  D2,$A004.W
        DC.W    $0478,$0040,$A004   ; $00AA40 SUBI.W  #$0040,$A004.W
        DC.W    $3004               ; $00AA46 MOVE.W  D4,D0
        DC.W    $E840               ; $00AA48 ASR.W  #4,D0
        DC.W    $3600               ; $00AA4A MOVE.W  D0,D3
        DC.W    $D040               ; $00AA4C ADD.W  D0,D0
        DC.W    $D043               ; $00AA4E ADD.W  D3,D0
        DC.W    $5040               ; $00AA50 ADDQ.W  #8,D0
        DC.W    $31C0,$A006         ; $00AA52 MOVE.W  D0,$A006.W
        DC.W    $6050               ; $00AA56 BRA.S  loc_00AAA8
loc_00AA58:
        DC.W    $0C44,$0400         ; $00AA58 CMPI.W  #$0400,D4
        DC.W    $6E22               ; $00AA5C BGT.S  loc_00AA80
        DC.W    $31C1,$A002         ; $00AA5E MOVE.W  D1,$A002.W
        DC.W    $DB78,$A002         ; $00AA62 ADD.W  D5,$A002.W
        DC.W    $31C2,$A004         ; $00AA66 MOVE.W  D2,$A004.W
        DC.W    $0478,$0080,$A004   ; $00AA6A SUBI.W  #$0080,$A004.W
        DC.W    $3004               ; $00AA70 MOVE.W  D4,D0
        DC.W    $E840               ; $00AA72 ASR.W  #4,D0
        DC.W    $D040               ; $00AA74 ADD.W  D0,D0
        DC.W    $0640,$0020         ; $00AA76 ADDI.W  #$0020,D0
        DC.W    $31C0,$A006         ; $00AA7A MOVE.W  D0,$A006.W
        DC.W    $6028               ; $00AA7E BRA.S  loc_00AAA8
loc_00AA80:
        DC.W    $31C1,$A002         ; $00AA80 MOVE.W  D1,$A002.W
        DC.W    $DB78,$A002         ; $00AA84 ADD.W  D5,$A002.W
        DC.W    $31C2,$A004         ; $00AA88 MOVE.W  D2,$A004.W
        DC.W    $0478,$0080,$A004   ; $00AA8C SUBI.W  #$0080,$A004.W
        DC.W    $3004               ; $00AA92 MOVE.W  D4,D0
        DC.W    $E840               ; $00AA94 ASR.W  #4,D0
        DC.W    $0640,$0064         ; $00AA96 ADDI.W  #$0064,D0
        DC.W    $0C40,$00C8         ; $00AA9A CMPI.W  #$00C8,D0
        DC.W    $6F04               ; $00AA9E BLE.S  loc_00AAA4
        DC.W    $303C,$00C8         ; $00AAA0 MOVE.W  #$00C8,D0
loc_00AAA4:
        DC.W    $31C0,$A006         ; $00AAA4 MOVE.W  D0,$A006.W
loc_00AAA8:
        DC.W    $3028,$0034         ; $00AAA8 MOVE.W  $0034(A0),D0
        DC.W    $3228,$0030         ; $00AAAC MOVE.W  $0030(A0),D1
        DC.W    $4441               ; $00AAB0 NEG.W  D1
        DC.W    $3438,$A004         ; $00AAB2 MOVE.W  $A004.W,D2
        DC.W    $3638,$A002         ; $00AAB6 MOVE.W  $A002.W,D3
        DC.W    $4443               ; $00AABA NEG.W  D3
        DC.W    $4EBA,$FCE2         ; $00AABC JSR     loc_00A7A0(PC)
        DC.W    $31C0,$A008         ; $00AAC0 MOVE.W  D0,$A008.W
        DC.W    $9068,$003C         ; $00AAC4 SUB.W  $003C(A0),D0
        DC.W    $0C40,$0140         ; $00AAC8 CMPI.W  #$0140,D0
        DC.W    $6F04               ; $00AACC BLE.S  loc_00AAD2
        DC.W    $303C,$0140         ; $00AACE MOVE.W  #$0140,D0
loc_00AAD2:
        DC.W    $0C40,$FEC0         ; $00AAD2 CMPI.W  #$FEC0,D0
        DC.W    $6C04               ; $00AAD6 BGE.S  loc_00AADC
        DC.W    $303C,$FEC0         ; $00AAD8 MOVE.W  #$FEC0,D0
loc_00AADC:
        DC.W    $D168,$003C         ; $00AADC ADD.W  D0,$003C(A0)
        DC.W    $3628,$003C         ; $00AAE0 MOVE.W  $003C(A0),D3
        DC.W    $6A02               ; $00AAE4 BPL.S  loc_00AAE8
        DC.W    $4443               ; $00AAE6 NEG.W  D3
loc_00AAE8:
        DC.W    $0C43,$0100         ; $00AAE8 CMPI.W  #$0100,D3
        DC.W    $6C04               ; $00AAEC BGE.S  loc_00AAF2
        DC.W    $4268,$003C         ; $00AAEE CLR.W  $003C(A0)
loc_00AAF2:
        DC.W    $3140,$008E         ; $00AAF2 MOVE.W  D0,$008E(A0)
        DC.W    $3140,$0090         ; $00AAF6 MOVE.W  D0,$0090(A0)
        DC.W    $D040               ; $00AAFA ADD.W  D0,D0
        DC.W    $4440               ; $00AAFC NEG.W  D0
        DC.W    $3140,$0046         ; $00AAFE MOVE.W  D0,$0046(A0)
        DC.W    $3038,$A008         ; $00AB02 MOVE.W  $A008.W,D0
        DC.W    $9068,$0040         ; $00AB06 SUB.W  $0040(A0),D0
        DC.W    $E440               ; $00AB0A ASR.W  #2,D0
        DC.W    $D168,$0040         ; $00AB0C ADD.W  D0,$0040(A0)
        DC.W    $3038,$A006         ; $00AB10 MOVE.W  $A006.W,D0
        DC.W    $C1FC,$03E8         ; $00AB14 MULS    #$03E8,D0
        DC.W    $E188               ; $00AB18 LSL.L  #8,D0
        DC.W    $81FC,$0E10         ; $00AB1A DIVS    #$0E10,D0
        DC.W    $48C0               ; $00AB1E EXT.L   D0
        DC.W    $81FC,$0014         ; $00AB20 DIVS    #$0014,D0
        DC.W    $31C0,$A006         ; $00AB24 MOVE.W  D0,$A006.W
        DC.W    $9068,$0006         ; $00AB28 SUB.W  $0006(A0),D0
        DC.W    $0C40,$002F         ; $00AB2C CMPI.W  #$002F,D0
        DC.W    $6F04               ; $00AB30 BLE.S  loc_00AB36
        DC.W    $303C,$002F         ; $00AB32 MOVE.W  #$002F,D0
loc_00AB36:
        DC.W    $0C40,$FFB0         ; $00AB36 CMPI.W  #$FFB0,D0
        DC.W    $6C04               ; $00AB3A BGE.S  loc_00AB40
        DC.W    $303C,$FFB0         ; $00AB3C MOVE.W  #$FFB0,D0
loc_00AB40:
        DC.W    $D168,$0006         ; $00AB40 ADD.W  D0,$0006(A0)
        DC.W    $4EBA,$EFCC         ; $00AB44 JSR     $009B12(PC)
        DC.W    $3028,$0004         ; $00AB48 MOVE.W  $0004(A0),D0
        DC.W    $EB40               ; $00AB4C ASL.W  #5,D0
        DC.W    $0C40,$11F8         ; $00AB4E CMPI.W  #$11F8,D0
        DC.W    $6F04               ; $00AB52 BLE.S  loc_00AB58
        DC.W    $303C,$11F8         ; $00AB54 MOVE.W  #$11F8,D0
loc_00AB58:
        DC.W    $0C40,$0000         ; $00AB58 CMPI.W  #$0000,D0
        DC.W    $6C04               ; $00AB5C BGE.S  loc_00AB62
        DC.W    $303C,$0000         ; $00AB5E MOVE.W  #$0000,D0
loc_00AB62:
        DC.W    $9168,$00BC         ; $00AB62 SUB.W  D0,$00BC(A0)
        DC.W    $3028,$0040         ; $00AB66 MOVE.W  $0040(A0),D0
        DC.W    $4440               ; $00AB6A NEG.W  D0
        DC.W    $3428,$0006         ; $00AB6C MOVE.W  $0006(A0),D2
        DC.W    $3628,$0030         ; $00AB70 MOVE.W  $0030(A0),D3
        DC.W    $3828,$0034         ; $00AB74 MOVE.W  $0034(A0),D4
        DC.W    $4EBA,$C464         ; $00AB78 JSR     $006FDE(PC)
        DC.W    $3143,$0030         ; $00AB7C MOVE.W  D3,$0030(A0)
        DC.W    $3144,$0034         ; $00AB80 MOVE.W  D4,$0034(A0)
        DC.W    $4EFA,$E78C         ; $00AB84 JMP     $009312(PC)
        DC.W    $4EBA,$0136         ; $00AB88 JSR     loc_00ACC0(PC)
        DC.W    $7078               ; $00AB8C MOVEQ   #$78,D0
        DC.W    $9068,$00B0         ; $00AB8E SUB.W  $00B0(A0),D0
        DC.W    $C0FC,$3BBB         ; $00AB92 MULU    #$3BBB,D0
        DC.W    $4840               ; $00AB96 SWAP    D0
        DC.W    $31C0,$C026         ; $00AB98 MOVE.W  D0,$C026.W
        DC.W    $0C78,$0014,$C026   ; $00AB9C CMPI.W  #$0014,$C026.W
        DC.W    $660A               ; $00ABA2 BNE.S  loc_00ABAE
        DC.W    $317C,$0000,$008A   ; $00ABA4 MOVE.W  #$0000,$008A(A0)
        DC.W    $4EBA,$F650         ; $00ABAA JSR     $00A1FC(PC)
loc_00ABAE:
        DC.W    $5368,$00B0         ; $00ABAE SUBQ.W  #1,$00B0(A0)
        DC.W    $6616               ; $00ABB2 BNE.S  loc_00ABCA
        DC.W    $4239,$00FF,$6970   ; $00ABB4 CLR.B  $00FF6970
        DC.W    $43F8,$C05C         ; $00ABBA LEA     $C05C.W,A1
        DC.W    $3028,$00AE         ; $00ABBE MOVE.W  $00AE(A0),D0
        DC.W    $D040               ; $00ABC2 ADD.W  D0,D0
        DC.W    $33BC,$0003,$0000   ; $00ABC4 MOVE.W  #$0003,$00(A1,D0.W)
loc_00ABCA:
        DC.W    $4EFA,$FD2C         ; $00ABCA JMP     loc_00A8F8(PC)
        DC.W    $43F8,$C05C         ; $00ABCE LEA     $C05C.W,A1
        DC.W    $7000               ; $00ABD2 MOVEQ   #$00,D0
        DC.W    $3228,$00AE         ; $00ABD4 MOVE.W  $00AE(A0),D1
        DC.W    $D241               ; $00ABD8 ADD.W  D1,D1
loc_00ABDA:
        DC.W    $B041               ; $00ABDA CMP.W  D1,D0
        DC.W    $6C0E               ; $00ABDC BGE.S  loc_00ABEC
        DC.W    $0C71,$0001,$1000   ; $00ABDE CMPI.W  #$0001,$00(A1,D1.W)
        DC.W    $6700,$FD12         ; $00ABE4 BEQ.W  loc_00A8F8
        DC.W    $5440               ; $00ABE8 ADDQ.W  #2,D0
        DC.W    $60EE               ; $00ABEA BRA.S  loc_00ABDA
loc_00ABEC:
        DC.W    $3028,$00AE         ; $00ABEC MOVE.W  $00AE(A0),D0
        DC.W    $5240               ; $00ABF0 ADDQ.W  #1,D0
        DC.W    $D040               ; $00ABF2 ADD.W  D0,D0
loc_00ABF4:
        DC.W    $0C40,$0008         ; $00ABF4 CMPI.W  #$0008,D0
        DC.W    $6C0E               ; $00ABF8 BGE.S  loc_00AC08
        DC.W    $0C71,$0004,$0000   ; $00ABFA CMPI.W  #$0004,$00(A1,D0.W)
        DC.W    $6700,$FCF6         ; $00AC00 BEQ.W  loc_00A8F8
        DC.W    $5440               ; $00AC04 ADDQ.W  #2,D0
        DC.W    $60EC               ; $00AC06 BRA.S  loc_00ABF4
loc_00AC08:
        DC.W    $0068,$4000,$0002   ; $00AC08 ORI.W  #$4000,$0002(A0)
        DC.W    $31FC,$0050,$C04E   ; $00AC0E MOVE.W  #$0050,$C04E.W
        DC.W    $43F8,$C05C         ; $00AC14 LEA     $C05C.W,A1
        DC.W    $3028,$00AE         ; $00AC18 MOVE.W  $00AE(A0),D0
        DC.W    $D040               ; $00AC1C ADD.W  D0,D0
        DC.W    $33BC,$0000,$0000   ; $00AC1E MOVE.W  #$0000,$00(A1,D0.W)
        DC.W    $31FC,$003C,$C8AE   ; $00AC24 MOVE.W  #$003C,$C8AE.W
        DC.W    $31F8,$C08C,$C07A   ; $00AC2A MOVE.W  $C08C.W,$C07A.W
        DC.W    $08B8,$0001,$C30E   ; $00AC30 BCLR    #1,$C30E.W
        DC.W    $11FC,$0091,$C8A5   ; $00AC36 MOVE.B  #$0091,$C8A5.W
        DC.W    $4E75               ; $00AC3C RTS
        DC.W    $4A78,$C8AE         ; $00AC3E TST.W  $C8AE.W
        DC.W    $6720               ; $00AC42 BEQ.S  loc_00AC64
        DC.W    $5378,$C8AE         ; $00AC44 SUBQ.W  #1,$C8AE.W
        DC.W    $661A               ; $00AC48 BNE.S  loc_00AC64
        DC.W    $43F9,$00FF,$66DC   ; $00AC4A LEA     $00FF66DC,A1
        DC.W    $4251               ; $00AC50 CLR.W  (A1)
        DC.W    $4269,$0014         ; $00AC52 CLR.W  $0014(A1)
        DC.W    $4269,$0028         ; $00AC56 CLR.W  $0028(A1)
        DC.W    $4269,$003C         ; $00AC5A CLR.W  $003C(A1)
        DC.W    $31FC,$FFFF,$C026   ; $00AC5E MOVE.W  #$FFFF,$C026.W
loc_00AC64:
        DC.W    $1038,$C319         ; $00AC64 MOVE.B  $C319.W,D0
        DC.W    $0200,$003F         ; $00AC68 ANDI.B  #$003F,D0
        DC.W    $0C00,$000D         ; $00AC6C CMPI.B  #$000D,D0
        DC.W    $664C               ; $00AC70 BNE.S  loc_00ACBE
        DC.W    $1038,$C30E         ; $00AC72 MOVE.B  $C30E.W,D0
        DC.W    $0200,$0021         ; $00AC76 ANDI.B  #$0021,D0
        DC.W    $6642               ; $00AC7A BNE.S  loc_00ACBE
        DC.W    $43F8,$C05C         ; $00AC7C LEA     $C05C.W,A1
        DC.W    $3028,$00AE         ; $00AC80 MOVE.W  $00AE(A0),D0
        DC.W    $D040               ; $00AC84 ADD.W  D0,D0
        DC.W    $4A71,$0000         ; $00AC86 TST.W  $00(A1,D0.W)
        DC.W    $6632               ; $00AC8A BNE.S  loc_00ACBE
        DC.W    $4A68,$00AC         ; $00AC8C TST.W  $00AC(A0)
        DC.W    $6F2C               ; $00AC90 BLE.S  loc_00ACBE
        DC.W    $4A38,$C312         ; $00AC92 TST.B  $C312.W
        DC.W    $6626               ; $00AC96 BNE.S  loc_00ACBE
        DC.W    $4278,$C8AA         ; $00AC98 CLR.W  $C8AA.W
        DC.W    $5368,$00AC         ; $00AC9C SUBQ.W  #1,$00AC(A0)
        DC.W    $33BC,$0001,$0000   ; $00ACA0 MOVE.W  #$0001,$00(A1,D0.W)
        DC.W    $0068,$0200,$0002   ; $00ACA6 ORI.W  #$0200,$0002(A0)
        DC.W    $31F8,$C08E,$C07A   ; $00ACAC MOVE.W  $C08E.W,$C07A.W
        DC.W    $11FC,$0090,$C8A5   ; $00ACB2 MOVE.B  #$0090,$C8A5.W
        DC.W    $08F8,$0001,$C30E   ; $00ACB8 BSET    #1,$C30E.W
loc_00ACBE:
        DC.W    $4E75               ; $00ACBE RTS
loc_00ACC0:
        DC.W    $7000               ; $00ACC0 MOVEQ   #$00,D0
        DC.W    $0838,$0002,$C8AB   ; $00ACC2 BTST    #2,$C8AB.W
        DC.W    $6602               ; $00ACC8 BNE.S  loc_00ACCC
        DC.W    $7001               ; $00ACCA MOVEQ   #$01,D0
loc_00ACCC:
        DC.W    $13C0,$00FF,$6970   ; $00ACCC MOVE.B  D0,$00FF6970
        DC.W    $4E75               ; $00ACD2 RTS
        DC.W    $4A68,$006A         ; $00ACD4 TST.W  $006A(A0)
        DC.W    $6638               ; $00ACD8 BNE.S  loc_00AD12
        DC.W    $4A78,$C02C         ; $00ACDA TST.W  $C02C.W
        DC.W    $6E32               ; $00ACDE BGT.S  loc_00AD12
        DC.W    $4A68,$008C         ; $00ACE0 TST.W  $008C(A0)
        DC.W    $662C               ; $00ACE4 BNE.S  loc_00AD12
        DC.W    $4268,$0088         ; $00ACE6 CLR.W  $0088(A0)
        DC.W    $43F8,$9000         ; $00ACEA LEA     $9000.W,A1
        DC.W    $3028,$00A4         ; $00ACEE MOVE.W  $00A4(A0),D0
        DC.W    $E148               ; $00ACF2 LSL.W  #8,D0
        DC.W    $43F1,$0000         ; $00ACF4 LEA     $00(A1,D0.W),A1
        DC.W    $4EBA,$00CA         ; $00ACF8 JSR     loc_00ADC4(PC)
        DC.W    $6616               ; $00ACFC BNE.S  loc_00AD14
        DC.W    $43F8,$9000         ; $00ACFE LEA     $9000.W,A1
        DC.W    $3028,$00A6         ; $00AD02 MOVE.W  $00A6(A0),D0
        DC.W    $E148               ; $00AD06 LSL.W  #8,D0
        DC.W    $43F1,$0000         ; $00AD08 LEA     $00(A1,D0.W),A1
        DC.W    $4EBA,$00B6         ; $00AD0C JSR     loc_00ADC4(PC)
        DC.W    $6602               ; $00AD10 BNE.S  loc_00AD14
loc_00AD12:
        DC.W    $4E75               ; $00AD12 RTS
loc_00AD14:
        DC.W    $11FC,$00B8,$C8A4   ; $00AD14 MOVE.B  #$00B8,$C8A4.W
        DC.W    $3028,$0004         ; $00AD1A MOVE.W  $0004(A0),D0
        DC.W    $9069,$0004         ; $00AD1E SUB.W  $0004(A1),D0
        DC.W    $6A02               ; $00AD22 BPL.S  loc_00AD26
        DC.W    $4440               ; $00AD24 NEG.W  D0
loc_00AD26:
        DC.W    $B078,$C8CE         ; $00AD26 CMP.W  $C8CE.W,D0
        DC.W    $6F00,$0094         ; $00AD2A BLE.W  loc_00ADC0
        DC.W    $3028,$0006         ; $00AD2E MOVE.W  $0006(A0),D0
        DC.W    $D069,$0006         ; $00AD32 ADD.W  $0006(A1),D0
        DC.W    $3400               ; $00AD36 MOVE.W  D0,D2
        DC.W    $E242               ; $00AD38 ASR.W  #1,D2
        DC.W    $E440               ; $00AD3A ASR.W  #2,D0
        DC.W    $D440               ; $00AD3C ADD.W  D0,D2
        DC.W    $3200               ; $00AD3E MOVE.W  D0,D1
        DC.W    $E241               ; $00AD40 ASR.W  #1,D1
        DC.W    $D240               ; $00AD42 ADD.W  D0,D1
        DC.W    $0C41,$04DC         ; $00AD44 CMPI.W  #$04DC,D1
        DC.W    $6F04               ; $00AD48 BLE.S  loc_00AD4E
        DC.W    $323C,$04DC         ; $00AD4A MOVE.W  #$04DC,D1
loc_00AD4E:
        DC.W    $0C42,$04DC         ; $00AD4E CMPI.W  #$04DC,D2
        DC.W    $6F04               ; $00AD52 BLE.S  loc_00AD58
        DC.W    $343C,$04DC         ; $00AD54 MOVE.W  #$04DC,D2
loc_00AD58:
        DC.W    $3029,$0006         ; $00AD58 MOVE.W  $0006(A1),D0
        DC.W    $B068,$0006         ; $00AD5C CMP.W  $0006(A0),D0
        DC.W    $6F02               ; $00AD60 BLE.S  loc_00AD64
        DC.W    $C342               ; $00AD62 AND.W  D1,D2
loc_00AD64:
        DC.W    $3342,$0006         ; $00AD64 MOVE.W  D2,$0006(A1)
        DC.W    $3628,$0004         ; $00AD68 MOVE.W  $0004(A0),D3
        DC.W    $9669,$0004         ; $00AD6C SUB.W  $0004(A1),D3
        DC.W    $B678,$C8D0         ; $00AD70 CMP.W  $C8D0.W,D3
        DC.W    $6F0E               ; $00AD74 BLE.S  loc_00AD84
        DC.W    $0069,$1000,$0002   ; $00AD76 ORI.W  #$1000,$0002(A1)
        DC.W    $0068,$0800,$0002   ; $00AD7C ORI.W  #$0800,$0002(A0)
        DC.W    $4E75               ; $00AD82 RTS
loc_00AD84:
        DC.W    $3141,$0006         ; $00AD84 MOVE.W  D1,$0006(A0)
        DC.W    $3028,$0088         ; $00AD88 MOVE.W  $0088(A0),D0
        DC.W    $7201               ; $00AD8C MOVEQ   #$01,D1
        DC.W    $C240               ; $00AD8E AND.W  D0,D1
        DC.W    $661A               ; $00AD90 BNE.S  loc_00ADAC
        DC.W    $7204               ; $00AD92 MOVEQ   #$04,D1
        DC.W    $C240               ; $00AD94 AND.W  D0,D1
        DC.W    $6614               ; $00AD96 BNE.S  loc_00ADAC
        DC.W    $0068,$2000,$0002   ; $00AD98 ORI.W  #$2000,$0002(A0)
        DC.W    $0069,$1000,$0002   ; $00AD9E ORI.W  #$1000,$0002(A1)
        DC.W    $11FC,$00B2,$C8A4   ; $00ADA4 MOVE.B  #$00B2,$C8A4.W
        DC.W    $4E75               ; $00ADAA RTS
loc_00ADAC:
        DC.W    $0068,$1000,$0002   ; $00ADAC ORI.W  #$1000,$0002(A0)
        DC.W    $0069,$2000,$0002   ; $00ADB2 ORI.W  #$2000,$0002(A1)
        DC.W    $11FC,$00B2,$C8A4   ; $00ADB8 MOVE.B  #$00B2,$C8A4.W
        DC.W    $4E75               ; $00ADBE RTS
loc_00ADC0:
        DC.W    $4EFA,$0116         ; $00ADC0 JMP     loc_00AED8(PC)
loc_00ADC4:
        DC.W    $4269,$0088         ; $00ADC4 CLR.W  $0088(A1)
        DC.W    $3029,$0032         ; $00ADC8 MOVE.W  $0032(A1),D0
        DC.W    $9068,$0032         ; $00ADCC SUB.W  $0032(A0),D0
        DC.W    $6A02               ; $00ADD0 BPL.S  loc_00ADD4
        DC.W    $4440               ; $00ADD2 NEG.W  D0
loc_00ADD4:
        DC.W    $0C40,$0200         ; $00ADD4 CMPI.W  #$0200,D0
        DC.W    $6C28               ; $00ADD8 BGE.S  loc_00AE02
        DC.W    $3029,$0030         ; $00ADDA MOVE.W  $0030(A1),D0
        DC.W    $9068,$0030         ; $00ADDE SUB.W  $0030(A0),D0
        DC.W    $6A02               ; $00ADE2 BPL.S  loc_00ADE6
        DC.W    $4440               ; $00ADE4 NEG.W  D0
loc_00ADE6:
        DC.W    $0C40,$0040         ; $00ADE6 CMPI.W  #$0040,D0
        DC.W    $6C16               ; $00ADEA BGE.S  loc_00AE02
        DC.W    $3029,$0034         ; $00ADEC MOVE.W  $0034(A1),D0
        DC.W    $9068,$0034         ; $00ADF0 SUB.W  $0034(A0),D0
        DC.W    $6A02               ; $00ADF4 BPL.S  loc_00ADF8
        DC.W    $4440               ; $00ADF6 NEG.W  D0
loc_00ADF8:
        DC.W    $0C40,$0040         ; $00ADF8 CMPI.W  #$0040,D0
        DC.W    $6C04               ; $00ADFC BGE.S  loc_00AE02
        DC.W    $4EFA,$000A         ; $00ADFE JMP     loc_00AE0A(PC)
loc_00AE02:
        DC.W    $7000               ; $00AE02 MOVEQ   #$00,D0
        DC.W    $4E75               ; $00AE04 RTS
        DC.W    $0102               ; $00AE06 BTST    D0,D2
        DC.W    $0408,$3029         ; $00AE08 SUBI.B  #$3029,A0
        DC.W    $003C,$9068,$0040   ; $00AE0C ORI.B  #$9068,#$0040
        DC.W    $EA40               ; $00AE12 ASR.W  #5,D0
        DC.W    $0640,$0800         ; $00AE14 ADDI.W  #$0800,D0
        DC.W    $0240,$07FE         ; $00AE18 ANDI.W  #$07FE,D0
        DC.W    $3628,$0030         ; $00AE1C MOVE.W  $0030(A0),D3
        DC.W    $9669,$0030         ; $00AE20 SUB.W  $0030(A1),D3
        DC.W    $3828,$0034         ; $00AE24 MOVE.W  $0034(A0),D4
        DC.W    $9869,$0034         ; $00AE28 SUB.W  $0034(A1),D4
        DC.W    $2478,$C268         ; $00AE2C MOVEA.L $C268.W,A2
        DC.W    $45F2,$0000         ; $00AE30 LEA     $00(A2,D0.W),A2
        DC.W    $7403               ; $00AE34 MOVEQ   #$03,D2
loc_00AE36:
        DC.W    $1C12               ; $00AE36 MOVE.B  (A2),D6
        DC.W    $4886               ; $00AE38 EXT.W   D6
        DC.W    $DC43               ; $00AE3A ADD.W  D3,D6
        DC.W    $1E2A,$0001         ; $00AE3C MOVE.B  $0001(A2),D7
        DC.W    $4887               ; $00AE40 EXT.W   D7
        DC.W    $DE44               ; $00AE42 ADD.W  D4,D7
        DC.W    $BC78,$C8E4         ; $00AE44 CMP.W  $C8E4.W,D6
        DC.W    $6D1A               ; $00AE48 BLT.S  loc_00AE64
        DC.W    $BC78,$C8E8         ; $00AE4A CMP.W  $C8E8.W,D6
        DC.W    $6E14               ; $00AE4E BGT.S  loc_00AE64
        DC.W    $BE78,$C8EA         ; $00AE50 CMP.W  $C8EA.W,D7
        DC.W    $6D0E               ; $00AE54 BLT.S  loc_00AE64
        DC.W    $BE78,$C8E6         ; $00AE56 CMP.W  $C8E6.W,D7
        DC.W    $6E08               ; $00AE5A BGT.S  loc_00AE64
        DC.W    $7003               ; $00AE5C MOVEQ   #$03,D0
        DC.W    $9042               ; $00AE5E SUB.W  D2,D0
        DC.W    $01E8,$0089         ; $00AE60 BSET    D0,$0089(A0)
loc_00AE64:
        DC.W    $45EA,$0800         ; $00AE64 LEA     $0800(A2),A2
        DC.W    $51CA,$FFCC         ; $00AE68 DBRA    D2,loc_00AE36
        DC.W    $3028,$003C         ; $00AE6C MOVE.W  $003C(A0),D0
        DC.W    $9069,$003C         ; $00AE70 SUB.W  $003C(A1),D0
        DC.W    $EA40               ; $00AE74 ASR.W  #5,D0
        DC.W    $0640,$0800         ; $00AE76 ADDI.W  #$0800,D0
        DC.W    $0240,$07FE         ; $00AE7A ANDI.W  #$07FE,D0
        DC.W    $3629,$0030         ; $00AE7E MOVE.W  $0030(A1),D3
        DC.W    $9668,$0030         ; $00AE82 SUB.W  $0030(A0),D3
        DC.W    $3829,$0034         ; $00AE86 MOVE.W  $0034(A1),D4
        DC.W    $9868,$0034         ; $00AE8A SUB.W  $0034(A0),D4
        DC.W    $2478,$C268         ; $00AE8E MOVEA.L $C268.W,A2
        DC.W    $45F2,$0000         ; $00AE92 LEA     $00(A2,D0.W),A2
        DC.W    $7403               ; $00AE96 MOVEQ   #$03,D2
loc_00AE98:
        DC.W    $1C12               ; $00AE98 MOVE.B  (A2),D6
        DC.W    $4886               ; $00AE9A EXT.W   D6
        DC.W    $DC43               ; $00AE9C ADD.W  D3,D6
        DC.W    $1E2A,$0001         ; $00AE9E MOVE.B  $0001(A2),D7
        DC.W    $4887               ; $00AEA2 EXT.W   D7
        DC.W    $DE44               ; $00AEA4 ADD.W  D4,D7
        DC.W    $BC78,$C8EC         ; $00AEA6 CMP.W  $C8EC.W,D6
        DC.W    $6D1E               ; $00AEAA BLT.S  loc_00AECA
        DC.W    $BC78,$C8EE         ; $00AEAC CMP.W  $C8EE.W,D6
        DC.W    $6E18               ; $00AEB0 BGT.S  loc_00AECA
        DC.W    $BE78,$C8F0         ; $00AEB2 CMP.W  $C8F0.W,D7
        DC.W    $6D12               ; $00AEB6 BLT.S  loc_00AECA
        DC.W    $BE78,$C8F2         ; $00AEB8 CMP.W  $C8F2.W,D7
        DC.W    $6E0C               ; $00AEBC BGT.S  loc_00AECA
        DC.W    $45FA,$FF46         ; $00AEBE LEA     -$00BA(PC),A2
        DC.W    $7003               ; $00AEC2 MOVEQ   #$03,D0
        DC.W    $9042               ; $00AEC4 SUB.W  D2,D0
        DC.W    $01E9,$0089         ; $00AEC6 BSET    D0,$0089(A1)
loc_00AECA:
        DC.W    $45EA,$0800         ; $00AECA LEA     $0800(A2),A2
        DC.W    $51CA,$FFC8         ; $00AECE DBRA    D2,loc_00AE98
        DC.W    $1028,$0089         ; $00AED2 MOVE.B  $0089(A0),D0
        DC.W    $4E75               ; $00AED6 RTS
loc_00AED8:
        DC.W    $3028,$0088         ; $00AED8 MOVE.W  $0088(A0),D0
        DC.W    $7218               ; $00AEDC MOVEQ   #$18,D1
        DC.W    $0800,$0000         ; $00AEDE BTST    #0,D0
        DC.W    $6708               ; $00AEE2 BEQ.S  loc_00AEEC
        DC.W    $D368,$0030         ; $00AEE4 ADD.W  D1,$0030(A0)
        DC.W    $9368,$0034         ; $00AEE8 SUB.W  D1,$0034(A0)
loc_00AEEC:
        DC.W    $0800,$0001         ; $00AEEC BTST    #1,D0
        DC.W    $6708               ; $00AEF0 BEQ.S  loc_00AEFA
        DC.W    $9368,$0030         ; $00AEF2 SUB.W  D1,$0030(A0)
        DC.W    $9368,$0034         ; $00AEF6 SUB.W  D1,$0034(A0)
loc_00AEFA:
        DC.W    $0800,$0002         ; $00AEFA BTST    #2,D0
        DC.W    $6708               ; $00AEFE BEQ.S  loc_00AF08
        DC.W    $D368,$0030         ; $00AF00 ADD.W  D1,$0030(A0)
        DC.W    $D368,$0034         ; $00AF04 ADD.W  D1,$0034(A0)
loc_00AF08:
        DC.W    $0800,$0003         ; $00AF08 BTST    #3,D0
        DC.W    $6708               ; $00AF0C BEQ.S  loc_00AF16
        DC.W    $9368,$0030         ; $00AF0E SUB.W  D1,$0030(A0)
        DC.W    $D368,$0034         ; $00AF12 ADD.W  D1,$0034(A0)
loc_00AF16:
        DC.W    $4E75               ; $00AF16 RTS
        DC.W    $43F8,$9F00         ; $00AF18 LEA     $9F00.W,A1
        DC.W    $4268,$0088         ; $00AF1C CLR.W  $0088(A0)
        DC.W    $4269,$0088         ; $00AF20 CLR.W  $0088(A1)
        DC.W    $3028,$006A         ; $00AF24 MOVE.W  $006A(A0),D0
        DC.W    $D069,$006A         ; $00AF28 ADD.W  $006A(A1),D0
        DC.W    $D068,$008C         ; $00AF2C ADD.W  $008C(A0),D0
        DC.W    $D069,$008C         ; $00AF30 ADD.W  $008C(A1),D0
        DC.W    $6600,$008A         ; $00AF34 BNE.W  loc_00AFC0
        DC.W    $3029,$0032         ; $00AF38 MOVE.W  $0032(A1),D0
        DC.W    $9068,$0032         ; $00AF3C SUB.W  $0032(A0),D0
        DC.W    $6A02               ; $00AF40 BPL.S  loc_00AF44
        DC.W    $4440               ; $00AF42 NEG.W  D0
loc_00AF44:
        DC.W    $0C40,$0200         ; $00AF44 CMPI.W  #$0200,D0
        DC.W    $6C76               ; $00AF48 BGE.S  loc_00AFC0
        DC.W    $4EBA,$FEBE         ; $00AF4A JSR     loc_00AE0A(PC)
        DC.W    $6700,$0070         ; $00AF4E BEQ.W  loc_00AFC0
        DC.W    $11FC,$00B8,$C8A4   ; $00AF52 MOVE.B  #$00B8,$C8A4.W
        DC.W    $3028,$0004         ; $00AF58 MOVE.W  $0004(A0),D0
        DC.W    $9069,$0004         ; $00AF5C SUB.W  $0004(A1),D0
        DC.W    $6A02               ; $00AF60 BPL.S  loc_00AF64
        DC.W    $4440               ; $00AF62 NEG.W  D0
loc_00AF64:
        DC.W    $B078,$C8CE         ; $00AF64 CMP.W  $C8CE.W,D0
        DC.W    $6F00,$0094         ; $00AF68 BLE.W  loc_00AFFE
        DC.W    $3028,$0006         ; $00AF6C MOVE.W  $0006(A0),D0
        DC.W    $D069,$0006         ; $00AF70 ADD.W  $0006(A1),D0
        DC.W    $3400               ; $00AF74 MOVE.W  D0,D2
        DC.W    $E242               ; $00AF76 ASR.W  #1,D2
        DC.W    $E440               ; $00AF78 ASR.W  #2,D0
        DC.W    $D440               ; $00AF7A ADD.W  D0,D2
        DC.W    $3200               ; $00AF7C MOVE.W  D0,D1
        DC.W    $E241               ; $00AF7E ASR.W  #1,D1
        DC.W    $D240               ; $00AF80 ADD.W  D0,D1
        DC.W    $0C41,$04DC         ; $00AF82 CMPI.W  #$04DC,D1
        DC.W    $6F04               ; $00AF86 BLE.S  loc_00AF8C
        DC.W    $323C,$04DC         ; $00AF88 MOVE.W  #$04DC,D1
loc_00AF8C:
        DC.W    $0C42,$04DC         ; $00AF8C CMPI.W  #$04DC,D2
        DC.W    $6F04               ; $00AF90 BLE.S  loc_00AF96
        DC.W    $343C,$04DC         ; $00AF92 MOVE.W  #$04DC,D2
loc_00AF96:
        DC.W    $3029,$0006         ; $00AF96 MOVE.W  $0006(A1),D0
        DC.W    $B068,$0006         ; $00AF9A CMP.W  $0006(A0),D0
        DC.W    $6F02               ; $00AF9E BLE.S  loc_00AFA2
        DC.W    $C342               ; $00AFA0 AND.W  D1,D2
loc_00AFA2:
        DC.W    $3342,$0006         ; $00AFA2 MOVE.W  D2,$0006(A1)
        DC.W    $3628,$0004         ; $00AFA6 MOVE.W  $0004(A0),D3
        DC.W    $9669,$0004         ; $00AFAA SUB.W  $0004(A1),D3
        DC.W    $B678,$C8D0         ; $00AFAE CMP.W  $C8D0.W,D3
        DC.W    $6F0E               ; $00AFB2 BLE.S  loc_00AFC2
        DC.W    $0068,$0800,$0002   ; $00AFB4 ORI.W  #$0800,$0002(A0)
        DC.W    $0069,$0800,$0002   ; $00AFBA ORI.W  #$0800,$0002(A1)
loc_00AFC0:
        DC.W    $4E75               ; $00AFC0 RTS
loc_00AFC2:
        DC.W    $3141,$0006         ; $00AFC2 MOVE.W  D1,$0006(A0)
        DC.W    $3028,$0088         ; $00AFC6 MOVE.W  $0088(A0),D0
        DC.W    $7201               ; $00AFCA MOVEQ   #$01,D1
        DC.W    $C240               ; $00AFCC AND.W  D0,D1
        DC.W    $661A               ; $00AFCE BNE.S  loc_00AFEA
        DC.W    $7204               ; $00AFD0 MOVEQ   #$04,D1
        DC.W    $C240               ; $00AFD2 AND.W  D0,D1
        DC.W    $6614               ; $00AFD4 BNE.S  loc_00AFEA
        DC.W    $0068,$2000,$0002   ; $00AFD6 ORI.W  #$2000,$0002(A0)
        DC.W    $0069,$1000,$0002   ; $00AFDC ORI.W  #$1000,$0002(A1)
        DC.W    $11FC,$00B2,$C8A4   ; $00AFE2 MOVE.B  #$00B2,$C8A4.W
        DC.W    $4E75               ; $00AFE8 RTS
loc_00AFEA:
        DC.W    $0068,$1000,$0002   ; $00AFEA ORI.W  #$1000,$0002(A0)
        DC.W    $0069,$2000,$0002   ; $00AFF0 ORI.W  #$2000,$0002(A1)
        DC.W    $11FC,$00B2,$C8A4   ; $00AFF6 MOVE.B  #$00B2,$C8A4.W
        DC.W    $4E75               ; $00AFFC RTS
loc_00AFFE:
        DC.W    $7210               ; $00AFFE MOVEQ   #$10,D1
        DC.W    $3028,$0030         ; $00B000 MOVE.W  $0030(A0),D0
        DC.W    $B069,$0030         ; $00B004 CMP.W  $0030(A1),D0
        DC.W    $6E02               ; $00B008 BGT.S  loc_00B00C
        DC.W    $4441               ; $00B00A NEG.W  D1
loc_00B00C:
        DC.W    $D368,$0030         ; $00B00C ADD.W  D1,$0030(A0)
        DC.W    $9369,$0030         ; $00B010 SUB.W  D1,$0030(A1)
        DC.W    $7210               ; $00B014 MOVEQ   #$10,D1
        DC.W    $3028,$0034         ; $00B016 MOVE.W  $0034(A0),D0
        DC.W    $B069,$0034         ; $00B01A CMP.W  $0034(A1),D0
        DC.W    $6E02               ; $00B01E BGT.S  loc_00B022
        DC.W    $4441               ; $00B020 NEG.W  D1
loc_00B022:
        DC.W    $D368,$0034         ; $00B022 ADD.W  D1,$0034(A0)
        DC.W    $9369,$0034         ; $00B026 SUB.W  D1,$0034(A1)
        DC.W    $4E75               ; $00B02A RTS
        DC.W    $7000               ; $00B02C MOVEQ   #$00,D0
        DC.W    $3038,$907E         ; $00B02E MOVE.W  $907E.W,D0
        DC.W    $6136               ; $00B032 BSR.S  loc_00B06A
        DC.W    $33C0,$00FF,$674C   ; $00B034 MOVE.W  D0,$00FF674C
        DC.W    $4E75               ; $00B03A RTS
        DC.W    $0838,$0005,$C30E   ; $00B03C BTST    #5,$C30E.W
        DC.W    $660E               ; $00B042 BNE.S  loc_00B052
        DC.W    $7000               ; $00B044 MOVEQ   #$00,D0
        DC.W    $3038,$907E         ; $00B046 MOVE.W  $907E.W,D0
        DC.W    $611E               ; $00B04A BSR.S  loc_00B06A
        DC.W    $33C0,$00FF,$6328   ; $00B04C MOVE.W  D0,$00FF6328
loc_00B052:
        DC.W    $0838,$0005,$B4EE   ; $00B052 BTST    #5,$B4EE.W
        DC.W    $660E               ; $00B058 BNE.S  loc_00B068
        DC.W    $7000               ; $00B05A MOVEQ   #$00,D0
        DC.W    $3038,$9F7E         ; $00B05C MOVE.W  $9F7E.W,D0
        DC.W    $6108               ; $00B060 BSR.S  loc_00B06A
        DC.W    $33C0,$00FF,$6558   ; $00B062 MOVE.W  D0,$00FF6558
loc_00B068:
        DC.W    $4E75               ; $00B068 RTS
loc_00B06A:
        DC.W    $0440,$1770         ; $00B06A SUBI.W  #$1770,D0
        DC.W    $6A02               ; $00B06E BPL.S  loc_00B072
        DC.W    $7000               ; $00B070 MOVEQ   #$00,D0
loc_00B072:
        DC.W    $0C40,$2AF8         ; $00B072 CMPI.W  #$2AF8,D0
        DC.W    $6D04               ; $00B076 BLT.S  loc_00B07C
        DC.W    $303C,$2AF8         ; $00B078 MOVE.W  #$2AF8,D0
loc_00B07C:
        DC.W    $E648               ; $00B07C LSR.W  #3,D0
        DC.W    $3200               ; $00B07E MOVE.W  D0,D1
        DC.W    $E248               ; $00B080 LSR.W  #1,D0
        DC.W    $D041               ; $00B082 ADD.W  D1,D0
        DC.W    $0C40,$0800         ; $00B084 CMPI.W  #$0800,D0
        DC.W    $6F04               ; $00B088 BLE.S  loc_00B08E
        DC.W    $303C,$0800         ; $00B08A MOVE.W  #$0800,D0
loc_00B08E:
        DC.W    $0640,$0800         ; $00B08E ADDI.W  #$0800,D0
        DC.W    $4E75               ; $00B092 RTS
        DC.W    $41F8,$C813         ; $00B094 LEA     $C813.W,A0
        DC.W    $1038,$B4EE         ; $00B098 MOVE.B  $B4EE.W,D0
        DC.W    $6008               ; $00B09C BRA.S  loc_00B0A6
        DC.W    $41F8,$C806         ; $00B09E LEA     $C806.W,A0
        DC.W    $1038,$C30E         ; $00B0A2 MOVE.B  $C30E.W,D0
loc_00B0A6:
        DC.W    $0800,$0004         ; $00B0A6 BTST    #4,D0
        DC.W    $6730               ; $00B0AA BEQ.S  loc_00B0DC
        DC.W    $0C10,$003C         ; $00B0AC CMPI.B  #$003C,(A0)
        DC.W    $6C2A               ; $00B0B0 BGE.S  loc_00B0DC
        DC.W    $5228,$0002         ; $00B0B2 ADDQ.B  #1,$0002(A0)
        DC.W    $6624               ; $00B0B6 BNE.S  loc_00B0DC
        DC.W    $117C,$00C4,$0002   ; $00B0B8 MOVE.B  #$00C4,$0002(A0)
        DC.W    $0200,$0023         ; $00B0BE ANDI.B  #$0023,D0
        DC.W    $660A               ; $00B0C2 BNE.S  loc_00B0CE
        DC.W    $4A38,$C30D         ; $00B0C4 TST.B  $C30D.W
        DC.W    $6604               ; $00B0C8 BNE.S  loc_00B0CE
        DC.W    $5378,$C050         ; $00B0CA SUBQ.W  #1,$C050.W
loc_00B0CE:
        DC.W    $5228,$0001         ; $00B0CE ADDQ.B  #1,$0001(A0)
        DC.W    $6608               ; $00B0D2 BNE.S  loc_00B0DC
        DC.W    $117C,$00C4,$0001   ; $00B0D4 MOVE.B  #$00C4,$0001(A0)
        DC.W    $5210               ; $00B0DA ADDQ.B  #1,(A0)
loc_00B0DC:
        DC.W    $4E75               ; $00B0DC RTS
        DC.W    $41F8,$A9E7         ; $00B0DE LEA     $A9E7.W,A0
        DC.W    $1038,$B4EE         ; $00B0E2 MOVE.B  $B4EE.W,D0
        DC.W    $4EBA,$000A         ; $00B0E6 JSR     loc_00B0F2(PC)
        DC.W    $41F8,$A9E3         ; $00B0EA LEA     $A9E3.W,A0
        DC.W    $1038,$C30E         ; $00B0EE MOVE.B  $C30E.W,D0
loc_00B0F2:
        DC.W    $0800,$0004         ; $00B0F2 BTST    #4,D0
        DC.W    $6720               ; $00B0F6 BEQ.S  loc_00B118
        DC.W    $0C10,$003C         ; $00B0F8 CMPI.B  #$003C,(A0)
        DC.W    $6C1A               ; $00B0FC BGE.S  loc_00B118
        DC.W    $5228,$0002         ; $00B0FE ADDQ.B  #1,$0002(A0)
        DC.W    $6614               ; $00B102 BNE.S  loc_00B118
        DC.W    $117C,$00C4,$0002   ; $00B104 MOVE.B  #$00C4,$0002(A0)
        DC.W    $5228,$0001         ; $00B10A ADDQ.B  #1,$0001(A0)
        DC.W    $6608               ; $00B10E BNE.S  loc_00B118
        DC.W    $117C,$00C4,$0001   ; $00B110 MOVE.B  #$00C4,$0001(A0)
        DC.W    $5210               ; $00B116 ADDQ.B  #1,(A0)
loc_00B118:
        DC.W    $4E75               ; $00B118 RTS
        DC.W    $43F9,$00FF,$68D9   ; $00B11A LEA     $00FF68D9,A1
        DC.W    $45F8,$C806         ; $00B120 LEA     $C806.W,A2
        DC.W    $7600               ; $00B124 MOVEQ   #$00,D3
        DC.W    $6036               ; $00B126 BRA.S  loc_00B15E
        DC.W    $43F9,$00FF,$68D9   ; $00B128 LEA     $00FF68D9,A1
        DC.W    $45F8,$C806         ; $00B12E LEA     $C806.W,A2
        DC.W    $7600               ; $00B132 MOVEQ   #$00,D3
        DC.W    $6028               ; $00B134 BRA.S  loc_00B15E
        DC.W    $43F9,$00FF,$6959   ; $00B136 LEA     $00FF6959,A1
        DC.W    $45F8,$C813         ; $00B13C LEA     $C813.W,A2
        DC.W    $7600               ; $00B140 MOVEQ   #$00,D3
        DC.W    $601A               ; $00B142 BRA.S  loc_00B15E
        DC.W    $43F9,$00FF,$68D9   ; $00B144 LEA     $00FF68D9,A1
        DC.W    $45F8,$C806         ; $00B14A LEA     $C806.W,A2
        DC.W    $3638,$902C         ; $00B14E MOVE.W  $902C.W,D3
        DC.W    $1038,$C30E         ; $00B152 MOVE.B  $C30E.W,D0
        DC.W    $0200,$0021         ; $00B156 ANDI.B  #$0021,D0
        DC.W    $6702               ; $00B15A BEQ.S  loc_00B15E
        DC.W    $4E75               ; $00B15C RTS
loc_00B15E:
        DC.W    $E94B               ; $00B15E LSL.W  #4,D3
        DC.W    $43F1,$3000         ; $00B160 LEA     $00(A1,D3.W),A1
        DC.W    $137C,$0002,$FFF7   ; $00B164 MOVE.B  #$0002,-$0009(A1)
        DC.W    $7000               ; $00B16A MOVEQ   #$00,D0
        DC.W    $101A               ; $00B16C MOVE.B  (A2)+,D0
        DC.W    $D040               ; $00B16E ADD.W  D0,D0
        DC.W    $41F9,$0089,$9884   ; $00B170 LEA     $00899884,A0
        DC.W    $3030,$0000         ; $00B176 MOVE.W  $00(A0,D0.W),D0
        DC.W    $612E               ; $00B17A BSR.S  loc_00B1AA
        DC.W    $7000               ; $00B17C MOVEQ   #$00,D0
        DC.W    $101A               ; $00B17E MOVE.B  (A2)+,D0
        DC.W    $0400,$00C4         ; $00B180 SUBI.B  #$00C4,D0
        DC.W    $D040               ; $00B184 ADD.W  D0,D0
        DC.W    $41F9,$0089,$9884   ; $00B186 LEA     $00899884,A0
        DC.W    $3030,$0000         ; $00B18C MOVE.W  $00(A0,D0.W),D0
        DC.W    $6118               ; $00B190 BSR.S  loc_00B1AA
        DC.W    $7000               ; $00B192 MOVEQ   #$00,D0
        DC.W    $101A               ; $00B194 MOVE.B  (A2)+,D0
        DC.W    $0400,$00C4         ; $00B196 SUBI.B  #$00C4,D0
        DC.W    $D040               ; $00B19A ADD.W  D0,D0
        DC.W    $41F9,$0089,$980C   ; $00B19C LEA     $0089980C,A0
        DC.W    $12F0,$0000         ; $00B1A2 MOVE.B  $00(A0,D0.W),(A1)+
        DC.W    $1030,$0001         ; $00B1A6 MOVE.B  $01(A0,D0.W),D0
loc_00B1AA:
        DC.W    $1200               ; $00B1AA MOVE.B  D0,D1
        DC.W    $E809               ; $00B1AC LSR.B  #4,D1
        DC.W    $12C1               ; $00B1AE MOVE.B  D1,(A1)+
        DC.W    $0200,$000F         ; $00B1B0 ANDI.B  #$000F,D0
        DC.W    $12C0               ; $00B1B4 MOVE.B  D0,(A1)+
        DC.W    $4E75               ; $00B1B6 RTS
        DC.W    $7000               ; $00B1B8 MOVEQ   #$00,D0
        DC.W    $3038,$902C         ; $00B1BA MOVE.W  $902C.W,D0
        DC.W    $0C40,$0005         ; $00B1BE CMPI.W  #$0005,D0
        DC.W    $6602               ; $00B1C2 BNE.S  loc_00B1C6
        DC.W    $5340               ; $00B1C4 SUBQ.W  #1,D0
loc_00B1C6:
        DC.W    $43F8,$C200         ; $00B1C6 LEA     $C200.W,A1
        DC.W    $D040               ; $00B1CA ADD.W  D0,D0
        DC.W    $D040               ; $00B1CC ADD.W  D0,D0
        DC.W    $3600               ; $00B1CE MOVE.W  D0,D3
        DC.W    $D3C0               ; $00B1D0 ADDA.L  D0,A1
        DC.W    $7000               ; $00B1D2 MOVEQ   #$00,D0
        DC.W    $1038,$C806         ; $00B1D4 MOVE.B  $C806.W,D0
        DC.W    $D040               ; $00B1D8 ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $00B1DA LEA     $00899884,A3
        DC.W    $3033,$0000         ; $00B1E0 MOVE.W  $00(A3,D0.W),D0
        DC.W    $12C0               ; $00B1E4 MOVE.B  D0,(A1)+
        DC.W    $7000               ; $00B1E6 MOVEQ   #$00,D0
        DC.W    $1038,$C807         ; $00B1E8 MOVE.B  $C807.W,D0
        DC.W    $0400,$00C4         ; $00B1EC SUBI.B  #$00C4,D0
        DC.W    $D040               ; $00B1F0 ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $00B1F2 LEA     $00899884,A3
        DC.W    $3033,$0000         ; $00B1F8 MOVE.W  $00(A3,D0.W),D0
        DC.W    $12C0               ; $00B1FC MOVE.B  D0,(A1)+
        DC.W    $7000               ; $00B1FE MOVEQ   #$00,D0
        DC.W    $1038,$C808         ; $00B200 MOVE.B  $C808.W,D0
        DC.W    $0400,$00C4         ; $00B204 SUBI.B  #$00C4,D0
        DC.W    $D040               ; $00B208 ADD.W  D0,D0
        DC.W    $47F9,$0089,$980C   ; $00B20A LEA     $0089980C,A3
        DC.W    $3033,$0000         ; $00B210 MOVE.W  $00(A3,D0.W),D0
        DC.W    $3280               ; $00B214 MOVE.W  D0,(A1)
        DC.W    $4EBA,$00D4         ; $00B216 JSR     loc_00B2EC(PC)
        DC.W    $4EBA,$0206         ; $00B21A JSR     loc_00B422(PC)
        DC.W    $7603               ; $00B21E MOVEQ   #$03,D3
        DC.W    $4EBA,$003E         ; $00B220 JSR     loc_00B260(PC)
        DC.W    $0C78,$0005,$902C   ; $00B224 CMPI.W  #$0005,$902C.W
        DC.W    $6630               ; $00B22A BNE.S  loc_00B25C
        DC.W    $2038,$C210         ; $00B22C MOVE.L  $C210.W,D0
        DC.W    $B0B8,$C254         ; $00B230 CMP.L  $C254.W,D0
        DC.W    $6C26               ; $00B234 BGE.S  loc_00B25C
        DC.W    $21C0,$C254         ; $00B236 MOVE.L  D0,$C254.W
        DC.W    $7000               ; $00B23A MOVEQ   #$00,D0
        DC.W    $1038,$C307         ; $00B23C MOVE.B  $C307.W,D0
        DC.W    $43F9,$00FF,$68D1   ; $00B240 LEA     $00FF68D1,A1
        DC.W    $43F1,$0000         ; $00B246 LEA     $00(A1,D0.W),A1
        DC.W    $12BC,$0000         ; $00B24A MOVE.B  #$0000,(A1)
        DC.W    $11FC,$0050,$C307   ; $00B24E MOVE.B  #$0050,$C307.W
        DC.W    $13FC,$0001,$00FF,$6911; $00B254 MOVE.B  #$0001,$00FF6911
loc_00B25C:
        DC.W    $4E75               ; $00B25C RTS
        DC.W    $7612               ; $00B25E MOVEQ   #$12,D3
loc_00B260:
        DC.W    $43F8,$C200         ; $00B260 LEA     $C200.W,A1
        DC.W    $2E3C,$0001,$0060   ; $00B264 MOVE.L  #$00010060,D7
        DC.W    $7000               ; $00B26A MOVEQ   #$00,D0
        DC.W    $1019               ; $00B26C MOVE.B  (A1)+,D0
        DC.W    $1219               ; $00B26E MOVE.B  (A1)+,D1
        DC.W    $1419               ; $00B270 MOVE.B  (A1)+,D2
        DC.W    $1C19               ; $00B272 MOVE.B  (A1)+,D6
loc_00B274:
        DC.W    $4843               ; $00B274 SWAP    D3
        DC.W    $1619               ; $00B276 MOVE.B  (A1)+,D3
        DC.W    $1819               ; $00B278 MOVE.B  (A1)+,D4
        DC.W    $1A19               ; $00B27A MOVE.B  (A1)+,D5
        DC.W    $4845               ; $00B27C SWAP    D5
        DC.W    $1A19               ; $00B27E MOVE.B  (A1)+,D5
        DC.W    $023C,$00EF,$CD05   ; $00B280 ANDI.B  #$00EF,#$CD05
        DC.W    $4845               ; $00B286 SWAP    D5
        DC.W    $C505               ; $00B288 AND.B  D2,D5
        DC.W    $0C02,$0010         ; $00B28A CMPI.B  #$0010,D2
        DC.W    $6D08               ; $00B28E BLT.S  loc_00B298
        DC.W    $0402,$0010         ; $00B290 SUBI.B  #$0010,D2
        DC.W    $003C,$0010,$C304   ; $00B294 ORI.B  #$0010,#$C304
        DC.W    $640A               ; $00B29A BCC.S  loc_00B2A6
        DC.W    $C103               ; $00B29C AND.B  D0,D3
        DC.W    $6522               ; $00B29E BCS.S  loc_00B2C2
        DC.W    $0601,$0040         ; $00B2A0 ADDI.B  #$0040,D1
        DC.W    $6004               ; $00B2A4 BRA.S  loc_00B2AA
loc_00B2A6:
        DC.W    $C103               ; $00B2A6 AND.B  D0,D3
        DC.W    $6518               ; $00B2A8 BCS.S  loc_00B2C2
loc_00B2AA:
        DC.W    $B207               ; $00B2AA CMP.B  D7,D1
        DC.W    $650A               ; $00B2AC BCS.S  loc_00B2B8
        DC.W    $8307               ; $00B2AE OR.B   D1,D7
        DC.W    $4847               ; $00B2B0 SWAP    D7
        DC.W    $C107               ; $00B2B2 AND.B  D0,D7
        DC.W    $650C               ; $00B2B4 BCS.S  loc_00B2C2
        DC.W    $4847               ; $00B2B6 SWAP    D7
loc_00B2B8:
        DC.W    $4843               ; $00B2B8 SWAP    D3
        DC.W    $51CB,$FFB8         ; $00B2BA DBRA    D3,loc_00B274
        DC.W    $B047               ; $00B2BE CMP.W  D7,D0
        DC.W    $6508               ; $00B2C0 BCS.S  loc_00B2CA
loc_00B2C2:
        DC.W    $7060               ; $00B2C2 MOVEQ   #$60,D0
        DC.W    $7200               ; $00B2C4 MOVEQ   #$00,D1
        DC.W    $7400               ; $00B2C6 MOVEQ   #$00,D2
        DC.W    $7C00               ; $00B2C8 MOVEQ   #$00,D6
loc_00B2CA:
        DC.W    $43F8,$C260         ; $00B2CA LEA     $C260.W,A1
        DC.W    $12C0               ; $00B2CE MOVE.B  D0,(A1)+
        DC.W    $12C1               ; $00B2D0 MOVE.B  D1,(A1)+
        DC.W    $12C2               ; $00B2D2 MOVE.B  D2,(A1)+
        DC.W    $1286               ; $00B2D4 MOVE.B  D6,(A1)
        DC.W    $4E75               ; $00B2D6 RTS
        DC.W    $00A0,$0110,$0080   ; $00B2D8 ORI.L  #$01100080,-(A0)
        DC.W    $0080,$00D0,$0100   ; $00B2DE ORI.L  #$00D00100,D0
        DC.W    $3628,$002C         ; $00B2E4 MOVE.W  $002C(A0),D3
        DC.W    $5343               ; $00B2E8 SUBQ.W  #1,D3
        DC.W    $E54B               ; $00B2EA LSL.W  #2,D3
loc_00B2EC:
        DC.W    $43F8,$C200         ; $00B2EC LEA     $C200.W,A1
        DC.W    $43F1,$3000         ; $00B2F0 LEA     $00(A1,D3.W),A1
        DC.W    $0C11,$0060         ; $00B2F4 CMPI.B  #$0060,(A1)
        DC.W    $6D02               ; $00B2F8 BLT.S  loc_00B2FC
        DC.W    $4E75               ; $00B2FA RTS
loc_00B2FC:
        DC.W    $3038,$C89E         ; $00B2FC MOVE.W  $C89E.W,D0
        DC.W    $303B,$00D6         ; $00B300 MOVE.W  -$2A(PC,D0.W),D0
loc_00B304:
        DC.W    $D068,$00E2         ; $00B304 ADD.W  $00E2(A0),D0
        DC.W    $6B62               ; $00B308 BMI.S  loc_00B36C
        DC.W    $C1FC,$0320         ; $00B30A MULS    #$0320,D0
        DC.W    $3228,$0006         ; $00B30E MOVE.W  $0006(A0),D1
        DC.W    $6758               ; $00B312 BEQ.S  loc_00B36C
        DC.W    $81C1               ; $00B314 DIVS    D1,D0
        DC.W    $0C40,$0032         ; $00B316 CMPI.W  #$0032,D0
        DC.W    $6D02               ; $00B31A BLT.S  loc_00B31E
        DC.W    $7032               ; $00B31C MOVEQ   #$32,D0
loc_00B31E:
        DC.W    $D040               ; $00B31E ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $00B320 LEA     $00899884,A3
        DC.W    $023C,$00EF,$3033   ; $00B326 ANDI.B  #$00EF,#$3033
        DC.W    $0000,$1229         ; $00B32C ORI.B  #$1229,D0
        DC.W    $0003,$8300         ; $00B330 ORI.B  #$8300,D3
        DC.W    $1341,$0003         ; $00B334 MOVE.B  D1,$0003(A1)
        DC.W    $7400               ; $00B338 MOVEQ   #$00,D2
        DC.W    $1229,$0002         ; $00B33A MOVE.B  $0002(A1),D1
        DC.W    $8302               ; $00B33E OR.B   D1,D2
        DC.W    $0201,$000F         ; $00B340 ANDI.B  #$000F,D1
        DC.W    $1341,$0002         ; $00B344 MOVE.B  D1,$0002(A1)
        DC.W    $1229,$0001         ; $00B348 MOVE.B  $0001(A1),D1
        DC.W    $8302               ; $00B34C OR.B   D1,D2
        DC.W    $6408               ; $00B34E BCC.S  loc_00B358
        DC.W    $0401,$0040         ; $00B350 SUBI.B  #$0040,D1
        DC.W    $003C,$0010,$1341   ; $00B354 ORI.B  #$0010,#$1341
        DC.W    $0001,$1211         ; $00B35A ORI.B  #$1211,D1
        DC.W    $8302               ; $00B35E OR.B   D1,D2
        DC.W    $0C01,$0059         ; $00B360 CMPI.B  #$0059,D1
        DC.W    $6F04               ; $00B364 BLE.S  loc_00B36A
        DC.W    $123C,$0059         ; $00B366 MOVE.B  #$0059,D1
loc_00B36A:
        DC.W    $1281               ; $00B36A MOVE.B  D1,(A1)
loc_00B36C:
        DC.W    $4E75               ; $00B36C RTS
        DC.W    $00D0               ; $00B36E DC.W    $00D0
        DC.W    $00C0               ; $00B370 DC.W    $00C0
        DC.W    $0090,$0090,$00A0   ; $00B372 ORI.L  #$009000A0,(A0)
        DC.W    $0100               ; $00B378 BTST    D0,D0
        DC.W    $0080,$0080,$00E0   ; $00B37A ORI.L  #$008000E0,D0
        DC.W    $00D0               ; $00B380 DC.W    $00D0
        DC.W    $0100               ; $00B382 BTST    D0,D0
        DC.W    $0100               ; $00B384 BTST    D0,D0
        DC.W    $D078,$C8A0         ; $00B386 ADD.W  $C8A0.W,D0
        DC.W    $303B,$00E2         ; $00B38A MOVE.W  -$1E(PC,D0.W),D0
        DC.W    $0C11,$0060         ; $00B38E CMPI.B  #$0060,(A1)
        DC.W    $6D00,$FF70         ; $00B392 BLT.W  loc_00B304
        DC.W    $4E75               ; $00B396 RTS
        DC.W    $00A0,$00D0,$00C0   ; $00B398 ORI.L  #$00D000C0,-(A0)
        DC.W    $0110               ; $00B39E BTST    D0,(A0)
        DC.W    $0090,$0090,$0080   ; $00B3A0 ORI.L  #$00900080,(A0)
        DC.W    $00A0,$0100,$0080   ; $00B3A6 ORI.L  #$01000080,-(A0)
        DC.W    $0080,$0080,$00D0   ; $00B3AC ORI.L  #$008000D0,D0
        DC.W    $00E0               ; $00B3B2 DC.W    $00E0
        DC.W    $00D0               ; $00B3B4 DC.W    $00D0
        DC.W    $0100               ; $00B3B6 BTST    D0,D0
        DC.W    $0100               ; $00B3B8 BTST    D0,D0
        DC.W    $0100               ; $00B3BA BTST    D0,D0
        DC.W    $D078,$C8A0         ; $00B3BC ADD.W  $C8A0.W,D0
        DC.W    $303B,$00D6         ; $00B3C0 MOVE.W  -$2A(PC,D0.W),D0
        DC.W    $0C11,$0060         ; $00B3C4 CMPI.B  #$0060,(A1)
        DC.W    $6D00,$FF3A         ; $00B3C8 BLT.W  loc_00B304
        DC.W    $4E75               ; $00B3CC RTS
        DC.W    $7000               ; $00B3CE MOVEQ   #$00,D0
        DC.W    $1019               ; $00B3D0 MOVE.B  (A1)+,D0
        DC.W    $D040               ; $00B3D2 ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $00B3D4 LEA     $00899884,A3
        DC.W    $3033,$0000         ; $00B3DA MOVE.W  $00(A3,D0.W),D0
        DC.W    $14C0               ; $00B3DE MOVE.B  D0,(A2)+
        DC.W    $7000               ; $00B3E0 MOVEQ   #$00,D0
        DC.W    $1019               ; $00B3E2 MOVE.B  (A1)+,D0
        DC.W    $0400,$00C4         ; $00B3E4 SUBI.B  #$00C4,D0
        DC.W    $D040               ; $00B3E8 ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $00B3EA LEA     $00899884,A3
        DC.W    $3033,$0000         ; $00B3F0 MOVE.W  $00(A3,D0.W),D0
        DC.W    $14C0               ; $00B3F4 MOVE.B  D0,(A2)+
        DC.W    $7000               ; $00B3F6 MOVEQ   #$00,D0
        DC.W    $1019               ; $00B3F8 MOVE.B  (A1)+,D0
        DC.W    $0400,$00C4         ; $00B3FA SUBI.B  #$00C4,D0
        DC.W    $D040               ; $00B3FE ADD.W  D0,D0
        DC.W    $47F9,$0089,$980C   ; $00B400 LEA     $0089980C,A3
        DC.W    $3033,$0000         ; $00B406 MOVE.W  $00(A3,D0.W),D0
        DC.W    $34C0               ; $00B40A MOVE.W  D0,(A2)+
        DC.W    $4E75               ; $00B40C RTS
        DC.W    $47F9,$00FF,$68D8   ; $00B40E LEA     $00FF68D8,A3
        DC.W    $6126               ; $00B414 BSR.S  loc_00B43C
        DC.W    $43F9,$00FF,$6958   ; $00B416 LEA     $00FF6958,A1
        DC.W    $22DB               ; $00B41C MOVE.L  (A3)+,(A1)+
        DC.W    $2293               ; $00B41E MOVE.L  (A3),(A1)
        DC.W    $4E75               ; $00B420 RTS
loc_00B422:
        DC.W    $E54B               ; $00B422 LSL.W  #2,D3
        DC.W    $47F9,$00FF,$68D8   ; $00B424 LEA     $00FF68D8,A3
        DC.W    $47F3,$3000         ; $00B42A LEA     $00(A3,D3.W),A3
        DC.W    $610C               ; $00B42E BSR.S  loc_00B43C
        DC.W    $43F9,$00FF,$6958   ; $00B430 LEA     $00FF6958,A1
        DC.W    $22DB               ; $00B436 MOVE.L  (A3)+,(A1)+
        DC.W    $2293               ; $00B438 MOVE.L  (A3),(A1)
        DC.W    $4E75               ; $00B43A RTS
loc_00B43C:
        DC.W    $3029,$0002         ; $00B43C MOVE.W  $0002(A1),D0
        DC.W    $1740,$0007         ; $00B440 MOVE.B  D0,$0007(A3)
        DC.W    $E848               ; $00B444 LSR.W  #4,D0
        DC.W    $1740,$0006         ; $00B446 MOVE.B  D0,$0006(A3)
        DC.W    $E848               ; $00B44A LSR.W  #4,D0
        DC.W    $1740,$0005         ; $00B44C MOVE.B  D0,$0005(A3)
        DC.W    $3011               ; $00B450 MOVE.W  (A1),D0
        DC.W    $1740,$0004         ; $00B452 MOVE.B  D0,$0004(A3)
        DC.W    $E848               ; $00B456 LSR.W  #4,D0
        DC.W    $1740,$0003         ; $00B458 MOVE.B  D0,$0003(A3)
        DC.W    $E848               ; $00B45C LSR.W  #4,D0
        DC.W    $1740,$0002         ; $00B45E MOVE.B  D0,$0002(A3)
        DC.W    $E848               ; $00B462 LSR.W  #4,D0
        DC.W    $1740,$0001         ; $00B464 MOVE.B  D0,$0001(A3)
        DC.W    $026B,$0F0F,$0002   ; $00B468 ANDI.W  #$0F0F,$0002(A3)
        DC.W    $02AB,$0F0F,$0F0F,$0004; $00B46E ANDI.L  #$0F0F0F0F,$0004(A3)
        DC.W    $4E75               ; $00B476 RTS
        DC.W    $023C,$00EF,$122C   ; $00B478 ANDI.B  #$00EF,#$122C
        DC.W    $0003,$102C         ; $00B47E ORI.B  #$102C,D3
        DC.W    $0007,$8300         ; $00B482 ORI.B  #$8300,D7
        DC.W    $1941,$0003         ; $00B486 MOVE.B  D1,$0003(A4)
        DC.W    $122C,$0002         ; $00B48A MOVE.B  $0002(A4),D1
        DC.W    $102C,$0006         ; $00B48E MOVE.B  $0006(A4),D0
        DC.W    $8300               ; $00B492 OR.B   D1,D0
        DC.W    $0201,$000F         ; $00B494 ANDI.B  #$000F,D1
        DC.W    $1941,$0002         ; $00B498 MOVE.B  D1,$0002(A4)
        DC.W    $122C,$0001         ; $00B49C MOVE.B  $0001(A4),D1
        DC.W    $102C,$0005         ; $00B4A0 MOVE.B  $0005(A4),D0
        DC.W    $8300               ; $00B4A4 OR.B   D1,D0
        DC.W    $6408               ; $00B4A6 BCC.S  loc_00B4B0
        DC.W    $0401,$0040         ; $00B4A8 SUBI.B  #$0040,D1
        DC.W    $003C,$0010,$1941   ; $00B4AC ORI.B  #$0010,#$1941
        DC.W    $0001,$1214         ; $00B4B2 ORI.B  #$1214,D1
        DC.W    $102C,$0004         ; $00B4B6 MOVE.B  $0004(A4),D0
        DC.W    $8300               ; $00B4BA OR.B   D1,D0
        DC.W    $0C01,$0059         ; $00B4BC CMPI.B  #$0059,D1
        DC.W    $6F04               ; $00B4C0 BLE.S  loc_00B4C6
        DC.W    $123C,$0059         ; $00B4C2 MOVE.B  #$0059,D1
loc_00B4C6:
        DC.W    $1881               ; $00B4C6 MOVE.B  D1,(A4)
        DC.W    $4E75               ; $00B4C8 RTS
        DC.W    $21F8,$C254,$EEFC   ; $00B4CA MOVE.L  $C254.W,$EEFC.W
        DC.W    $43F8,$C200         ; $00B4D0 LEA     $C200.W,A1
        DC.W    $45F8,$EEE0         ; $00B4D4 LEA     $EEE0.W,A2
        DC.W    $4EFA,$9446         ; $00B4D8 JMP     $004920(PC)
        DC.W    $3038,$C050         ; $00B4DC MOVE.W  $C050.W,D0
        DC.W    $6A02               ; $00B4E0 BPL.S  loc_00B4E4
        DC.W    $7000               ; $00B4E2 MOVEQ   #$00,D0
loc_00B4E4:
        DC.W    $D040               ; $00B4E4 ADD.W  D0,D0
        DC.W    $41F9,$0089,$9884   ; $00B4E6 LEA     $00899884,A0
        DC.W    $3030,$0000         ; $00B4EC MOVE.W  $00(A0,D0.W),D0
        DC.W    $43F9,$00FF,$68BA   ; $00B4F0 LEA     $00FF68BA,A1
        DC.W    $6054               ; $00B4F6 BRA.S  loc_00B54C
        DC.W    $43F9,$00FF,$6908   ; $00B4F8 LEA     $00FF6908,A1
        DC.W    $3038,$9F04         ; $00B4FE MOVE.W  $9F04.W,D0
        DC.W    $600A               ; $00B502 BRA.S  loc_00B50E
        DC.W    $43F9,$00FF,$68C8   ; $00B504 LEA     $00FF68C8,A1
        DC.W    $3038,$9004         ; $00B50A MOVE.W  $9004.W,D0
loc_00B50E:
        DC.W    $D040               ; $00B50E ADD.W  D0,D0
        DC.W    $41F9,$0089,$9884   ; $00B510 LEA     $00899884,A0
        DC.W    $3030,$0000         ; $00B516 MOVE.W  $00(A0,D0.W),D0
        DC.W    $3200               ; $00B51A MOVE.W  D0,D1
        DC.W    $E049               ; $00B51C LSR.W  #8,D1
        DC.W    $32C1               ; $00B51E MOVE.W  D1,(A1)+
        DC.W    $602A               ; $00B520 BRA.S  loc_00B54C
        DC.W    $7000               ; $00B522 MOVEQ   #$00,D0
        DC.W    $1038,$C30C         ; $00B524 MOVE.B  $C30C.W,D0
        DC.W    $D040               ; $00B528 ADD.W  D0,D0
        DC.W    $3200               ; $00B52A MOVE.W  D0,D1
        DC.W    $D040               ; $00B52C ADD.W  D0,D0
        DC.W    $41F9,$0089,$8C24   ; $00B52E LEA     $00898C24,A0
        DC.W    $23F0,$0000,$00FF,$68A8; $00B534 MOVE.L  $00(A0,D0.W),$00FF68A8
        DC.W    $41F9,$0089,$9884   ; $00B53C LEA     $00899884,A0
        DC.W    $3030,$1000         ; $00B542 MOVE.W  $00(A0,D1.W),D0
        DC.W    $43F9,$00FF,$689A   ; $00B546 LEA     $00FF689A,A1
loc_00B54C:
        DC.W    $1200               ; $00B54C MOVE.B  D0,D1
        DC.W    $E809               ; $00B54E LSR.B  #4,D1
        DC.W    $12C1               ; $00B550 MOVE.B  D1,(A1)+
        DC.W    $0200,$000F         ; $00B552 ANDI.B  #$000F,D0
        DC.W    $1280               ; $00B556 MOVE.B  D0,(A1)
        DC.W    $4E75               ; $00B558 RTS
        DC.W    $4A38,$C819         ; $00B55A TST.B  $C819.W
        DC.W    $662E               ; $00B55E BNE.S  loc_00B58E
        DC.W    $43F9,$00FF,$69E0   ; $00B560 LEA     $00FF69E0,A1
        DC.W    $203C,$0402,$7AFC   ; $00B566 MOVE.L  #$04027AFC,D0
        DC.W    $3238,$902A         ; $00B56C MOVE.W  $902A.W,D1
        DC.W    $B278,$9F2A         ; $00B570 CMP.W  $9F2A.W,D1
        DC.W    $6F06               ; $00B574 BLE.S  loc_00B57C
        DC.W    $203C,$0403,$82FC   ; $00B576 MOVE.L  #$040382FC,D0
loc_00B57C:
        DC.W    $2340,$0004         ; $00B57C MOVE.L  D0,$0004(A1)
        DC.W    $7001               ; $00B580 MOVEQ   #$01,D0
        DC.W    $0838,$0004,$C967   ; $00B582 BTST    #4,$C967.W
        DC.W    $6602               ; $00B588 BNE.S  loc_00B58C
        DC.W    $7000               ; $00B58A MOVEQ   #$00,D0
loc_00B58C:
        DC.W    $1280               ; $00B58C MOVE.B  D0,(A1)
loc_00B58E:
        DC.W    $4E75               ; $00B58E RTS
        DC.W    $4A38,$C819         ; $00B590 TST.B  $C819.W
        DC.W    $6702               ; $00B594 BEQ.S  loc_00B598
        DC.W    $4E75               ; $00B596 RTS
loc_00B598:
        DC.W    $43F9,$00FF,$69CA   ; $00B598 LEA     $00FF69CA,A1
        DC.W    $3038,$9F2C         ; $00B59E MOVE.W  $9F2C.W,D0
        DC.W    $6114               ; $00B5A2 BSR.S  loc_00B5B8
        DC.W    $0838,$0005,$C30E   ; $00B5A4 BTST    #5,$C30E.W
        DC.W    $6702               ; $00B5AA BEQ.S  loc_00B5AE
        DC.W    $4E75               ; $00B5AC RTS
loc_00B5AE:
        DC.W    $43F9,$00FF,$689A   ; $00B5AE LEA     $00FF689A,A1
        DC.W    $3038,$902C         ; $00B5B4 MOVE.W  $902C.W,D0
loc_00B5B8:
        DC.W    $5240               ; $00B5B8 ADDQ.W  #1,D0
        DC.W    $D040               ; $00B5BA ADD.W  D0,D0
        DC.W    $41F9,$0089,$9884   ; $00B5BC LEA     $00899884,A0
        DC.W    $3030,$0000         ; $00B5C2 MOVE.W  $00(A0,D0.W),D0
        DC.W    $4EFA,$FF84         ; $00B5C6 JMP     loc_00B54C(PC)
        DC.W    $3038,$902C         ; $00B5CA MOVE.W  $902C.W,D0
        DC.W    $0C40,$0004         ; $00B5CE CMPI.W  #$0004,D0
        DC.W    $6F04               ; $00B5D2 BLE.S  loc_00B5D8
        DC.W    $303C,$0004         ; $00B5D4 MOVE.W  #$0004,D0
loc_00B5D8:
        DC.W    $E948               ; $00B5D8 LSL.W  #4,D0
        DC.W    $4A38,$C305         ; $00B5DA TST.B  $C305.W
        DC.W    $6724               ; $00B5DE BEQ.S  loc_00B604
        DC.W    $0440,$0010         ; $00B5E0 SUBI.W  #$0010,D0
        DC.W    $43F9,$00FF,$68D0   ; $00B5E4 LEA     $00FF68D0,A1
        DC.W    $43F1,$0000         ; $00B5EA LEA     $00(A1,D0.W),A1
        DC.W    $32BC,$0201         ; $00B5EE MOVE.W  #$0201,(A1)
        DC.W    $B3F8,$C960         ; $00B5F2 CMPA.L  $C960.W,A1
        DC.W    $6704               ; $00B5F6 BEQ.S  loc_00B5FC
        DC.W    $32BC,$0200         ; $00B5F8 MOVE.W  #$0200,(A1)
loc_00B5FC:
        DC.W    $11FC,$0000,$C305   ; $00B5FC MOVE.B  #$0000,$C305.W
        DC.W    $4E75               ; $00B602 RTS
loc_00B604:
        DC.W    $43F9,$00FF,$68D0   ; $00B604 LEA     $00FF68D0,A1
        DC.W    $43F1,$0000         ; $00B60A LEA     $00(A1,D0.W),A1
        DC.W    $12BC,$0000         ; $00B60E MOVE.B  #$0000,(A1)
        DC.W    $0838,$0004,$C967   ; $00B612 BTST    #4,$C967.W
        DC.W    $6604               ; $00B618 BNE.S  loc_00B61E
        DC.W    $12BC,$0002         ; $00B61A MOVE.B  #$0002,(A1)
loc_00B61E:
        DC.W    $7009               ; $00B61E MOVEQ   #$09,D0
        DC.W    $0838,$0005,$C967   ; $00B620 BTST    #5,$C967.W
        DC.W    $6602               ; $00B626 BNE.S  loc_00B62A
        DC.W    $7000               ; $00B628 MOVEQ   #$00,D0
loc_00B62A:
        DC.W    $13C0,$00FF,$68B0   ; $00B62A MOVE.B  D0,$00FF68B0
        DC.W    $4E75               ; $00B630 RTS
        DC.W    $4A38,$C30F         ; $00B632 TST.B  $C30F.W
        DC.W    $670C               ; $00B636 BEQ.S  loc_00B644
        DC.W    $3038,$907A         ; $00B638 MOVE.W  $907A.W,D0
        DC.W    $5240               ; $00B63C ADDQ.W  #1,D0
        DC.W    $13C0,$00FF,$692B   ; $00B63E MOVE.B  D0,$00FF692B
loc_00B644:
        DC.W    $4E75               ; $00B644 RTS
        DC.W    $4A38,$FEB0         ; $00B646 TST.B  $FEB0.W
        DC.W    $670C               ; $00B64A BEQ.S  loc_00B658
        DC.W    $3038,$9F7A         ; $00B64C MOVE.W  $9F7A.W,D0
        DC.W    $5240               ; $00B650 ADDQ.W  #1,D0
        DC.W    $13C0,$00FF,$691B   ; $00B652 MOVE.B  D0,$00FF691B
loc_00B658:
        DC.W    $4E75               ; $00B658 RTS
        DC.W    $11FC,$0001,$C802   ; $00B65A MOVE.B  #$0001,$C802.W
        DC.W    $45F8,$8480         ; $00B660 LEA     $8480.W,A2
        DC.W    $4EBA,$000A         ; $00B664 JSR     loc_00B670(PC)
        DC.W    $4EBA,$0006         ; $00B668 JSR     loc_00B670(PC)
        DC.W    $4EBA,$0002         ; $00B66C JSR     loc_00B670(PC)
loc_00B670:
        DC.W    $43F9,$008B,$A000   ; $00B670 LEA     $008BA000,A1
        DC.W    $7200               ; $00B676 MOVEQ   #$00,D1
        DC.W    $1200               ; $00B678 MOVE.B  D0,D1
        DC.W    $E098               ; $00B67A ROR.L  #8,D0
        DC.W    $EB49               ; $00B67C LSL.W  #5,D1
        DC.W    $D2C1               ; $00B67E ADDA.W  D1,A1
        DC.W    $4EFA,$9298         ; $00B680 JMP     $00491A(PC)
        DC.W    $0838,$0006,$C80E   ; $00B684 BTST    #6,$C80E.W
        DC.W    $6742               ; $00B68A BEQ.S  loc_00B6CE
        DC.W    $5338,$C80A         ; $00B68C SUBQ.B  #1,$C80A.W
        DC.W    $663C               ; $00B690 BNE.S  loc_00B6CE
        DC.W    $11F8,$C809,$C80A   ; $00B692 MOVE.B  $C809.W,$C80A.W
        DC.W    $7000               ; $00B698 MOVEQ   #$00,D0
        DC.W    $1038,$C825         ; $00B69A MOVE.B  $C825.W,D0
        DC.W    $660C               ; $00B69E BNE.S  loc_00B6AC
        DC.W    $2278,$C96C         ; $00B6A0 MOVEA.L $C96C.W,A1
        DC.W    $45F8,$8480         ; $00B6A4 LEA     $8480.W,A2
        DC.W    $4EBA,$9240         ; $00B6A8 JSR     $0048EA(PC)
loc_00B6AC:
        DC.W    $123B,$0022         ; $00B6AC MOVE.B  $22(PC,D0.W),D1
        DC.W    $13C1,$00FF,$60D5   ; $00B6B0 MOVE.B  D1,$00FF60D5
        DC.W    $5200               ; $00B6B6 ADDQ.B  #1,D0
        DC.W    $11C0,$C825         ; $00B6B8 MOVE.B  D0,$C825.W
        DC.W    $0C00,$000A         ; $00B6BC CMPI.B  #$000A,D0
        DC.W    $660C               ; $00B6C0 BNE.S  loc_00B6CE
        DC.W    $11FC,$0000,$C825   ; $00B6C2 MOVE.B  #$0000,$C825.W
        DC.W    $08B8,$0006,$C80E   ; $00B6C8 BCLR    #6,$C80E.W
loc_00B6CE:
        DC.W    $4E75               ; $00B6CE RTS
        DC.W    $FFFE               ; $00B6D0 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $FDFC,$FBFA         ; $00B6D2 MOVE.W  #$FBFA,<EA:3E>
        DC.W    $F9F8,$F880,$0838   ; $00B6D6 MOVE.W  $F880.W,#$0838
        DC.W    $0007,$C80E         ; $00B6DC ORI.B  #$C80E,D7
        DC.W    $673E               ; $00B6E0 BEQ.S  loc_00B720
        DC.W    $5338,$C80A         ; $00B6E2 SUBQ.B  #1,$C80A.W
        DC.W    $6638               ; $00B6E6 BNE.S  loc_00B720
        DC.W    $11F8,$C809,$C80A   ; $00B6E8 MOVE.B  $C809.W,$C80A.W
        DC.W    $7000               ; $00B6EE MOVEQ   #$00,D0
        DC.W    $1038,$C825         ; $00B6F0 MOVE.B  $C825.W,D0
        DC.W    $123B,$002C         ; $00B6F4 MOVE.B  $2C(PC,D0.W),D1
        DC.W    $13C1,$00FF,$60D5   ; $00B6F8 MOVE.B  D1,$00FF60D5
        DC.W    $5200               ; $00B6FE ADDQ.B  #1,D0
        DC.W    $11C0,$C825         ; $00B700 MOVE.B  D0,$C825.W
        DC.W    $0C00,$000A         ; $00B704 CMPI.B  #$000A,D0
        DC.W    $6616               ; $00B708 BNE.S  loc_00B720
        DC.W    $7200               ; $00B70A MOVEQ   #$00,D1
        DC.W    $43F8,$8480         ; $00B70C LEA     $8480.W,A1
        DC.W    $4EBA,$9134         ; $00B710 JSR     $004846(PC)
        DC.W    $11FC,$0000,$C825   ; $00B714 MOVE.B  #$0000,$C825.W
        DC.W    $08B8,$0007,$C80E   ; $00B71A BCLR    #7,$C80E.W
loc_00B720:
        DC.W    $4E75               ; $00B720 RTS
        DC.W    $0102               ; $00B722 BTST    D0,D2
        DC.W    $0304               ; $00B724 BTST    D1,D4
        DC.W    $0506               ; $00B726 BTST    D2,D6
        DC.W    $0708               ; $00B728 BTST    D3,A0
        DC.W    $0800,$7000         ; $00B72A BTST    #0,D0
        DC.W    $7200               ; $00B72E MOVEQ   #$00,D1
        DC.W    $7400               ; $00B730 MOVEQ   #$00,D2
        DC.W    $41F8,$8480         ; $00B732 LEA     $8480.W,A0
loc_00B736:
        DC.W    $5331,$0001         ; $00B736 SUBQ.B  #1,$01(A1,D0.W)
        DC.W    $662C               ; $00B73A BNE.S  loc_00B768
        DC.W    $264A               ; $00B73C MOVEA.L A2,A3
        DC.W    $D6F2,$0000         ; $00B73E ADDA.W  $00(A2,D0.W),A3
        DC.W    $1431,$0000         ; $00B742 MOVE.B  $00(A1,D0.W),D2
        DC.W    $D442               ; $00B746 ADD.W  D2,D2
        DC.W    $1213               ; $00B748 MOVE.B  (A3),D1
        DC.W    $13AB,$0001,$0001   ; $00B74A MOVE.B  $0001(A3),$01(A1,D0.W)
        DC.W    $3633,$2000         ; $00B750 MOVE.W  $00(A3,D2.W),D3
        DC.W    $6A0A               ; $00B754 BPL.S  loc_00B760
        DC.W    $13BC,$0001,$0000   ; $00B756 MOVE.B  #$0001,$00(A1,D0.W)
        DC.W    $362B,$0002         ; $00B75C MOVE.W  $0002(A3),D3
loc_00B760:
        DC.W    $3183,$1000         ; $00B760 MOVE.W  D3,$00(A0,D1.W)
        DC.W    $5231,$0000         ; $00B764 ADDQ.B  #1,$00(A1,D0.W)
loc_00B768:
        DC.W    $5400               ; $00B768 ADDQ.B  #2,D0
        DC.W    $51CF,$FFCA         ; $00B76A DBRA    D7,loc_00B736
        DC.W    $4E75               ; $00B76E RTS
        DC.W    $45F9,$00FF,$6344   ; $00B770 LEA     $00FF6344,A2
        DC.W    $B0FC,$9000         ; $00B776 CMPA.W  #$9000,A0
        DC.W    $6606               ; $00B77A BNE.S  loc_00B782
        DC.W    $45F9,$00FF,$6114   ; $00B77C LEA     $00FF6114,A2
loc_00B782:
        DC.W    $3038,$C048         ; $00B782 MOVE.W  $C048.W,D0
        DC.W    $D040               ; $00B786 ADD.W  D0,D0
        DC.W    $43F8,$C0A2         ; $00B788 LEA     $C0A2.W,A1
        DC.W    $5271,$0000         ; $00B78C ADDQ.W  #1,$00(A1,D0.W)
        DC.W    $4A38,$C064         ; $00B790 TST.B  $C064.W
        DC.W    $6658               ; $00B794 BNE.S  loc_00B7EE
        DC.W    $3038,$C048         ; $00B796 MOVE.W  $C048.W,D0
        DC.W    $D040               ; $00B79A ADD.W  D0,D0
        DC.W    $D040               ; $00B79C ADD.W  D0,D0
        DC.W    $B038,$C302         ; $00B79E CMP.B  $C302.W,D0
        DC.W    $6656               ; $00B7A2 BNE.S  loc_00B7FA
        DC.W    $3038,$C972         ; $00B7A4 MOVE.W  $C972.W,D0
        DC.W    $4A38,$C314         ; $00B7A8 TST.B  $C314.W
        DC.W    $6738               ; $00B7AC BEQ.S  loc_00B7E6
        DC.W    $0800,$000A         ; $00B7AE BTST    #10,D0
        DC.W    $6708               ; $00B7B2 BEQ.S  loc_00B7BC
        DC.W    $31FC,$0001,$C048   ; $00B7B4 MOVE.W  #$0001,$C048.W
        DC.W    $6028               ; $00B7BA BRA.S  loc_00B7E4
loc_00B7BC:
        DC.W    $0800,$0009         ; $00B7BC BTST    #9,D0
        DC.W    $6708               ; $00B7C0 BEQ.S  loc_00B7CA
        DC.W    $31FC,$0002,$C048   ; $00B7C2 MOVE.W  #$0002,$C048.W
        DC.W    $601A               ; $00B7C8 BRA.S  loc_00B7E4
loc_00B7CA:
        DC.W    $0800,$0008         ; $00B7CA BTST    #8,D0
        DC.W    $6708               ; $00B7CE BEQ.S  loc_00B7D8
        DC.W    $31FC,$0003,$C048   ; $00B7D0 MOVE.W  #$0003,$C048.W
        DC.W    $600C               ; $00B7D6 BRA.S  loc_00B7E4
loc_00B7D8:
        DC.W    $0800,$0005         ; $00B7D8 BTST    #5,D0
        DC.W    $6706               ; $00B7DC BEQ.S  loc_00B7E4
        DC.W    $31FC,$0000,$C048   ; $00B7DE MOVE.W  #$0000,$C048.W
loc_00B7E4:
        DC.W    $4E75               ; $00B7E4 RTS
loc_00B7E6:
        DC.W    $0800,$000A         ; $00B7E6 BTST    #10,D0
        DC.W    $6616               ; $00B7EA BNE.S  loc_00B802
        DC.W    $4E75               ; $00B7EC RTS
loc_00B7EE:
        DC.W    $7000               ; $00B7EE MOVEQ   #$00,D0
        DC.W    $1038,$C065         ; $00B7F0 MOVE.B  $C065.W,D0
        DC.W    $227B,$006E         ; $00B7F4 MOVEA.L $6E(PC,D0.W),A1
        DC.W    $4ED1               ; $00B7F8 JMP     (A1)
loc_00B7FA:
        DC.W    $7400               ; $00B7FA MOVEQ   #$00,D2
        DC.W    $1438,$C302         ; $00B7FC MOVE.B  $C302.W,D2
        DC.W    $6042               ; $00B800 BRA.S  loc_00B844
loc_00B802:
        DC.W    $7000               ; $00B802 MOVEQ   #$00,D0
        DC.W    $1038,$C302         ; $00B804 MOVE.B  $C302.W,D0
        DC.W    $3400               ; $00B808 MOVE.W  D0,D2
        DC.W    $4A38,$C311         ; $00B80A TST.B  $C311.W
        DC.W    $671A               ; $00B80E BEQ.S  loc_00B82A
        DC.W    $5940               ; $00B810 SUBQ.W  #4,D0
        DC.W    $5378,$C048         ; $00B812 SUBQ.W  #1,$C048.W
        DC.W    $4A40               ; $00B816 TST.W  D0
        DC.W    $6C2A               ; $00B818 BGE.S  loc_00B844
        DC.W    $11FC,$0000,$C311   ; $00B81A MOVE.B  #$0000,$C311.W
        DC.W    $31FC,$0001,$C048   ; $00B820 MOVE.W  #$0001,$C048.W
        DC.W    $7004               ; $00B826 MOVEQ   #$04,D0
        DC.W    $601A               ; $00B828 BRA.S  loc_00B844
loc_00B82A:
        DC.W    $5840               ; $00B82A ADDQ.W  #4,D0
        DC.W    $5278,$C048         ; $00B82C ADDQ.W  #1,$C048.W
        DC.W    $0C40,$0010         ; $00B830 CMPI.W  #$0010,D0
        DC.W    $6D0E               ; $00B834 BLT.S  loc_00B844
        DC.W    $11FC,$0001,$C311   ; $00B836 MOVE.B  #$0001,$C311.W
        DC.W    $31FC,$0002,$C048   ; $00B83C MOVE.W  #$0002,$C048.W
        DC.W    $7008               ; $00B842 MOVEQ   #$08,D0
loc_00B844:
        DC.W    $11C0,$C302         ; $00B844 MOVE.B  D0,$C302.W
        DC.W    $D442               ; $00B848 ADD.W  D2,D2
        DC.W    $D442               ; $00B84A ADD.W  D2,D2
        DC.W    $D042               ; $00B84C ADD.W  D2,D0
        DC.W    $11FC,$0001,$C064   ; $00B84E MOVE.B  #$0001,$C064.W
        DC.W    $11C0,$C065         ; $00B854 MOVE.B  D0,$C065.W
        DC.W    $11FC,$0014,$C303   ; $00B858 MOVE.B  #$0014,$C303.W
        DC.W    $227B,$0004         ; $00B85E MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00B862 JMP     (A1)
        DC.W    $0088,$B8A4,$0088   ; $00B864 ORI.L  #$B8A40088,A0
        DC.W    $B964               ; $00B86A EOR.W  D4,-(A4)
        DC.W    $0088,$B964,$0088   ; $00B86C ORI.L  #$B9640088,A0
        DC.W    $B97A,$0088         ; $00B872 EOR.W  D4,$0088(PC)
        DC.W    $B8A4               ; $00B876 CMP.L  -(A4),D4
        DC.W    $0088,$B8A4,$0088   ; $00B878 ORI.L  #$B8A40088,A0
        DC.W    $B964               ; $00B87E EOR.W  D4,-(A4)
        DC.W    $0088,$B97A,$0088   ; $00B880 ORI.L  #$B97A0088,A0
        DC.W    $B8A4               ; $00B886 CMP.L  -(A4),D4
        DC.W    $0088,$B964,$0088   ; $00B888 ORI.L  #$B9640088,A0
        DC.W    $B8A4               ; $00B88E CMP.L  -(A4),D4
        DC.W    $0088,$B97A,$0088   ; $00B890 ORI.L  #$B97A0088,A0
        DC.W    $B8A4               ; $00B896 CMP.L  -(A4),D4
        DC.W    $0088,$B964,$0088   ; $00B898 ORI.L  #$B9640088,A0
        DC.W    $B964               ; $00B89E EOR.W  D4,-(A4)
        DC.W    $0088,$B8A4,$2278   ; $00B8A0 ORI.L  #$B8A42278,A0
        DC.W    $C744               ; $00B8A6 AND.W  D3,D4
        DC.W    $D078,$C8BC         ; $00B8A8 ADD.W  $C8BC.W,D0
        DC.W    $2271,$0000         ; $00B8AC MOVEA.L $00(A1,D0.W),A1
        DC.W    $7000               ; $00B8B0 MOVEQ   #$00,D0
        DC.W    $1038,$C303         ; $00B8B2 MOVE.B  $C303.W,D0
        DC.W    $D040               ; $00B8B6 ADD.W  D0,D0
        DC.W    $D040               ; $00B8B8 ADD.W  D0,D0
        DC.W    $2031,$0000         ; $00B8BA MOVE.L  $00(A1,D0.W),D0
        DC.W    $31C0,$C056         ; $00B8BE MOVE.W  D0,$C056.W
        DC.W    $4840               ; $00B8C2 SWAP    D0
        DC.W    $31C0,$C054         ; $00B8C4 MOVE.W  D0,$C054.W
        DC.W    $11FC,$0000,$C31C   ; $00B8C8 MOVE.B  #$0000,$C31C.W
        DC.W    $5338,$C303         ; $00B8CE SUBQ.B  #1,$C303.W
        DC.W    $6600,$008E         ; $00B8D2 BNE.W  loc_00B962
        DC.W    $11FC,$0000,$C064   ; $00B8D6 MOVE.B  #$0000,$C064.W
        DC.W    $2578,$C750,$0010   ; $00B8DC MOVE.L  $C750.W,$0010(A2)
        DC.W    $4A68,$008A         ; $00B8E2 TST.W  $008A(A0)
        DC.W    $6606               ; $00B8E6 BNE.S  loc_00B8EE
        DC.W    $2578,$C724,$0010   ; $00B8E8 MOVE.L  $C724.W,$0010(A2)
loc_00B8EE:
        DC.W    $7400               ; $00B8EE MOVEQ   #$00,D2
        DC.W    $2238,$C728         ; $00B8F0 MOVE.L  $C728.W,D1
        DC.W    $670C               ; $00B8F4 BEQ.S  loc_00B902
        DC.W    $2541,$0024         ; $00B8F6 MOVE.L  D1,$0024(A2)
        DC.W    $2578,$C72C,$0038   ; $00B8FA MOVE.L  $C72C.W,$0038(A2)
        DC.W    $7401               ; $00B900 MOVEQ   #$01,D2
loc_00B902:
        DC.W    $3542,$0014         ; $00B902 MOVE.W  D2,$0014(A2)
        DC.W    $3542,$0028         ; $00B906 MOVE.W  D2,$0028(A2)
        DC.W    $31FC,$0001,$C04C   ; $00B90A MOVE.W  #$0001,$C04C.W
        DC.W    $357C,$0002,$0000   ; $00B910 MOVE.W  #$0002,$0000(A2)
        DC.W    $2278,$C738         ; $00B916 MOVEA.L $C738.W,A1
        DC.W    $3559,$0016         ; $00B91A MOVE.W  (A1)+,$0016(A2)
        DC.W    $3559,$0018         ; $00B91E MOVE.W  (A1)+,$0018(A2)
        DC.W    $3559,$001A         ; $00B922 MOVE.W  (A1)+,$001A(A2)
        DC.W    $3559,$002A         ; $00B926 MOVE.W  (A1)+,$002A(A2)
        DC.W    $3559,$002C         ; $00B92A MOVE.W  (A1)+,$002C(A2)
        DC.W    $3551,$002E         ; $00B92E MOVE.W  (A1),$002E(A2)
        DC.W    $357C,$0000,$003C   ; $00B932 MOVE.W  #$0000,$003C(A2)
        DC.W    $357C,$0000,$0050   ; $00B938 MOVE.W  #$0000,$0050(A2)
        DC.W    $2278,$C740         ; $00B93E MOVEA.L $C740.W,A1
        DC.W    $B3FC,$0000,$0000   ; $00B942 CMPA.L  #$00000000,A1
        DC.W    $6718               ; $00B948 BEQ.S  loc_00B962
        DC.W    $3559,$0052         ; $00B94A MOVE.W  (A1)+,$0052(A2)
        DC.W    $3559,$0054         ; $00B94E MOVE.W  (A1)+,$0054(A2)
        DC.W    $3551,$0056         ; $00B952 MOVE.W  (A1),$0056(A2)
        DC.W    $357C,$0001,$0050   ; $00B956 MOVE.W  #$0001,$0050(A2)
        DC.W    $2578,$C730,$0060   ; $00B95C MOVE.L  $C730.W,$0060(A2)
loc_00B962:
        DC.W    $4E75               ; $00B962 RTS
        DC.W    $612A               ; $00B964 BSR.S  loc_00B990
        DC.W    $11FC,$0000,$C31C   ; $00B966 MOVE.B  #$0000,$C31C.W
        DC.W    $5338,$C303         ; $00B96C SUBQ.B  #1,$C303.W
        DC.W    $6606               ; $00B970 BNE.S  loc_00B978
        DC.W    $11FC,$0000,$C064   ; $00B972 MOVE.B  #$0000,$C064.W
loc_00B978:
        DC.W    $4E75               ; $00B978 RTS
        DC.W    $6114               ; $00B97A BSR.S  loc_00B990
        DC.W    $5338,$C303         ; $00B97C SUBQ.B  #1,$C303.W
        DC.W    $660C               ; $00B980 BNE.S  loc_00B98E
        DC.W    $11FC,$0000,$C064   ; $00B982 MOVE.B  #$0000,$C064.W
        DC.W    $11FC,$0001,$C31C   ; $00B988 MOVE.B  #$0001,$C31C.W
loc_00B98E:
        DC.W    $4E75               ; $00B98E RTS
loc_00B990:
        DC.W    $2278,$C744         ; $00B990 MOVEA.L $C744.W,A1
        DC.W    $D078,$C8BC         ; $00B994 ADD.W  $C8BC.W,D0
        DC.W    $2271,$0000         ; $00B998 MOVEA.L $00(A1,D0.W),A1
        DC.W    $7000               ; $00B99C MOVEQ   #$00,D0
        DC.W    $1038,$C303         ; $00B99E MOVE.B  $C303.W,D0
        DC.W    $D040               ; $00B9A2 ADD.W  D0,D0
        DC.W    $D040               ; $00B9A4 ADD.W  D0,D0
        DC.W    $2031,$0000         ; $00B9A6 MOVE.L  $00(A1,D0.W),D0
        DC.W    $31C0,$C056         ; $00B9AA MOVE.W  D0,$C056.W
        DC.W    $4840               ; $00B9AE SWAP    D0
        DC.W    $31C0,$C054         ; $00B9B0 MOVE.W  D0,$C054.W
        DC.W    $2578,$C710,$0010   ; $00B9B4 MOVE.L  $C710.W,$0010(A2)
        DC.W    $2578,$C714,$0024   ; $00B9BA MOVE.L  $C714.W,$0024(A2)
        DC.W    $2578,$C718,$0038   ; $00B9C0 MOVE.L  $C718.W,$0038(A2)
        DC.W    $2578,$C71C,$004C   ; $00B9C6 MOVE.L  $C71C.W,$004C(A2)
        DC.W    $2578,$C720,$0060   ; $00B9CC MOVE.L  $C720.W,$0060(A2)
        DC.W    $2278,$C734         ; $00B9D2 MOVEA.L $C734.W,A1
        DC.W    $3559,$0016         ; $00B9D6 MOVE.W  (A1)+,$0016(A2)
        DC.W    $3559,$0018         ; $00B9DA MOVE.W  (A1)+,$0018(A2)
        DC.W    $3559,$001A         ; $00B9DE MOVE.W  (A1)+,$001A(A2)
        DC.W    $3559,$002A         ; $00B9E2 MOVE.W  (A1)+,$002A(A2)
        DC.W    $3559,$002C         ; $00B9E6 MOVE.W  (A1)+,$002C(A2)
        DC.W    $3559,$002E         ; $00B9EA MOVE.W  (A1)+,$002E(A2)
        DC.W    $3559,$003E         ; $00B9EE MOVE.W  (A1)+,$003E(A2)
        DC.W    $3559,$0040         ; $00B9F2 MOVE.W  (A1)+,$0040(A2)
        DC.W    $3551,$0042         ; $00B9F6 MOVE.W  (A1),$0042(A2)
        DC.W    $31FC,$0000,$C04C   ; $00B9FA MOVE.W  #$0000,$C04C.W
        DC.W    $7001               ; $00BA00 MOVEQ   #$01,D0
        DC.W    $3540,$0000         ; $00BA02 MOVE.W  D0,$0000(A2)
        DC.W    $3540,$0014         ; $00BA06 MOVE.W  D0,$0014(A2)
        DC.W    $3540,$0028         ; $00BA0A MOVE.W  D0,$0028(A2)
        DC.W    $3540,$0050         ; $00BA0E MOVE.W  D0,$0050(A2)
        DC.W    $3540,$003C         ; $00BA12 MOVE.W  D0,$003C(A2)
        DC.W    $4E75               ; $00BA16 RTS
        DC.W    $4E75               ; $00BA18 RTS
        DC.W    $7000               ; $00BA1A MOVEQ   #$00,D0
        DC.W    $1038,$C86C         ; $00BA1C MOVE.B  $C86C.W,D0
        DC.W    $D040               ; $00BA20 ADD.W  D0,D0
        DC.W    $D040               ; $00BA22 ADD.W  D0,D0
        DC.W    $43F9,$0089,$4888   ; $00BA24 LEA     $00894888,A1
        DC.W    $2271,$0000         ; $00BA2A MOVEA.L $00(A1,D0.W),A1
        DC.W    $4E91               ; $00BA2E JSR     (A1)
        DC.W    $7000               ; $00BA30 MOVEQ   #$00,D0
        DC.W    $1038,$C86D         ; $00BA32 MOVE.B  $C86D.W,D0
        DC.W    $D040               ; $00BA36 ADD.W  D0,D0
        DC.W    $D040               ; $00BA38 ADD.W  D0,D0
        DC.W    $43F9,$0089,$4C88   ; $00BA3A LEA     $00894C88,A1
        DC.W    $2271,$0000         ; $00BA40 MOVEA.L $00(A1,D0.W),A1
        DC.W    $4E91               ; $00BA44 JSR     (A1)
        DC.W    $7000               ; $00BA46 MOVEQ   #$00,D0
        DC.W    $1038,$C86E         ; $00BA48 MOVE.B  $C86E.W,D0
        DC.W    $D040               ; $00BA4C ADD.W  D0,D0
        DC.W    $D040               ; $00BA4E ADD.W  D0,D0
        DC.W    $43F9,$0089,$5088   ; $00BA50 LEA     $00895088,A1
        DC.W    $2271,$0000         ; $00BA56 MOVEA.L $00(A1,D0.W),A1
        DC.W    $4E91               ; $00BA5A JSR     (A1)
        DC.W    $4E75               ; $00BA5C RTS
        DC.W    $31FC,$0000,$C0CE   ; $00BA5E MOVE.W  #$0000,$C0CE.W
        DC.W    $31FC,$0020,$C07A   ; $00BA64 MOVE.W  #$0020,$C07A.W
        DC.W    $11FC,$0000,$C308   ; $00BA6A MOVE.B  #$0000,$C308.W
        DC.W    $31FC,$0000,$C082   ; $00BA70 MOVE.W  #$0000,$C082.W
        DC.W    $31FC,$0001,$C048   ; $00BA76 MOVE.W  #$0001,$C048.W
        DC.W    $11FC,$0004,$C302   ; $00BA7C MOVE.B  #$0004,$C302.W
        DC.W    $4278,$A0E8         ; $00BA82 CLR.W  $A0E8.W
        DC.W    $4278,$A0EC         ; $00BA86 CLR.W  $A0EC.W
        DC.W    $4278,$A0EA         ; $00BA8A CLR.W  $A0EA.W
        DC.W    $4278,$A0EE         ; $00BA8E CLR.W  $A0EE.W
        DC.W    $4278,$A0F0         ; $00BA92 CLR.W  $A0F0.W
        DC.W    $4278,$A0F4         ; $00BA96 CLR.W  $A0F4.W
        DC.W    $4278,$A0F6         ; $00BA9A CLR.W  $A0F6.W
        DC.W    $41F8,$9000         ; $00BA9E LEA     $9000.W,A0
        DC.W    $317C,$0001,$002A   ; $00BAA2 MOVE.W  #$0001,$002A(A0)
        DC.W    $317C,$0100,$0076   ; $00BAA8 MOVE.W  #$0100,$0076(A0)
        DC.W    $317C,$0100,$0078   ; $00BAAE MOVE.W  #$0100,$0078(A0)
        DC.W    $4238,$C30F         ; $00BAB4 CLR.B  $C30F.W
        DC.W    $31FC,$0010,$A0E6   ; $00BAB8 MOVE.W  #$0010,$A0E6.W
        DC.W    $41F9,$0089,$7000   ; $00BABE LEA     $00897000,A0
        DC.W    $3038,$C8A0         ; $00BAC4 MOVE.W  $C8A0.W,D0
        DC.W    $2070,$0000         ; $00BAC8 MOVEA.L $00(A0,D0.W),A0
        DC.W    $41E8,$0010         ; $00BACC LEA     $0010(A0),A0
        DC.W    $4EFA,$0208         ; $00BAD0 JMP     loc_00BCDA(PC)
        DC.W    $0838,$0006,$C80E   ; $00BAD4 BTST    #6,$C80E.W
        DC.W    $6600,$013E         ; $00BADA BNE.W  loc_00BC1A
        DC.W    $4A78,$C080         ; $00BADE TST.W  $C080.W
        DC.W    $6600,$00A4         ; $00BAE2 BNE.W  loc_00BB88
        DC.W    $0C38,$000D,$C810   ; $00BAE6 CMPI.B  #$000D,$C810.W
        DC.W    $6620               ; $00BAEC BNE.S  loc_00BB0E
        DC.W    $1038,$C86F         ; $00BAEE MOVE.B  $C86F.W,D0
        DC.W    $11FC,$0001,$C81B   ; $00BAF2 MOVE.B  #$0001,$C81B.W
        DC.W    $0800,$0007         ; $00BAF8 BTST    #7,D0
        DC.W    $663E               ; $00BAFC BNE.S  loc_00BB3C
        DC.W    $11FC,$0000,$C81B   ; $00BAFE MOVE.B  #$0000,$C81B.W
        DC.W    $1038,$C86D         ; $00BB04 MOVE.B  $C86D.W,D0
        DC.W    $0800,$0007         ; $00BB08 BTST    #7,D0
        DC.W    $662E               ; $00BB0C BNE.S  loc_00BB3C
loc_00BB0E:
        DC.W    $4A38,$C308         ; $00BB0E TST.B  $C308.W
        DC.W    $6700,$0106         ; $00BB12 BEQ.W  loc_00BC1A
        DC.W    $11FC,$00F0,$C822   ; $00BB16 MOVE.B  #$00F0,$C822.W
        DC.W    $11FC,$0001,$C809   ; $00BB1C MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0002,$C80A   ; $00BB22 MOVE.B  #$0002,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $00BB28 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00BB2E MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0001,$C080   ; $00BB34 MOVE.W  #$0001,$C080.W
        DC.W    $604C               ; $00BB3A BRA.S  loc_00BB88
loc_00BB3C:
        DC.W    $8038,$C86C         ; $00BB3C OR.B   $C86C.W,D0
        DC.W    $11FC,$0001,$C809   ; $00BB40 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$004B,$C80A   ; $00BB46 MOVE.B  #$004B,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $00BB4C BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00BB52 MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0002,$C080   ; $00BB58 MOVE.W  #$0002,$C080.W
        DC.W    $31FC,$0038,$A0EA   ; $00BB5E MOVE.W  #$0038,$A0EA.W
        DC.W    $4A78,$A0F0         ; $00BB64 TST.W  $A0F0.W
        DC.W    $6612               ; $00BB68 BNE.S  loc_00BB7C
        DC.W    $31FC,$0001,$A0F0   ; $00BB6A MOVE.W  #$0001,$A0F0.W
        DC.W    $11FC,$009D,$850A   ; $00BB70 MOVE.B  #$009D,$850A.W
        DC.W    $11FC,$00F0,$C822   ; $00BB76 MOVE.B  #$00F0,$C822.W
loc_00BB7C:
        DC.W    $4A78,$A0F4         ; $00BB7C TST.W  $A0F4.W
        DC.W    $6606               ; $00BB80 BNE.S  loc_00BB88
        DC.W    $31FC,$003C,$A0F4   ; $00BB82 MOVE.W  #$003C,$A0F4.W
loc_00BB88:
        DC.W    $4A78,$A0F4         ; $00BB88 TST.W  $A0F4.W
        DC.W    $6708               ; $00BB8C BEQ.S  loc_00BB96
        DC.W    $5378,$A0F4         ; $00BB8E SUBQ.W  #1,$A0F4.W
        DC.W    $6E00,$0086         ; $00BB92 BGT.W  loc_00BC1A
loc_00BB96:
        DC.W    $0838,$0007,$C80E   ; $00BB96 BTST    #7,$C80E.W
        DC.W    $6600,$007C         ; $00BB9C BNE.W  loc_00BC1A
        DC.W    $7000               ; $00BBA0 MOVEQ   #$00,D0
        DC.W    $31C0,$C880         ; $00BBA2 MOVE.W  D0,$C880.W
        DC.W    $31C0,$C882         ; $00BBA6 MOVE.W  D0,$C882.W
        DC.W    $31FC,$0000,$C8A8   ; $00BBAA MOVE.W  #$0000,$C8A8.W
        DC.W    $33FC,$0020,$00FF,$0008; $00BBB0 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0089,$26D2,$00FF,$0002; $00BBB8 MOVE.L  #$008926D2,$00FF0002
        DC.W    $41F9,$0089,$7000   ; $00BBC2 LEA     $00897000,A0
        DC.W    $3038,$C8A0         ; $00BBC8 MOVE.W  $C8A0.W,D0
        DC.W    $2070,$0000         ; $00BBCC MOVEA.L $00(A0,D0.W),A0
        DC.W    $3038,$C082         ; $00BBD0 MOVE.W  $C082.W,D0
        DC.W    $E940               ; $00BBD4 ASL.W  #4,D0
        DC.W    $41F0,$0000         ; $00BBD6 LEA     $00(A0,D0.W),A0
        DC.W    $0C78,$0002,$C080   ; $00BBDA CMPI.W  #$0002,$C080.W
        DC.W    $6732               ; $00BBE0 BEQ.S  loc_00BC14
        DC.W    $0C28,$0010,$0000   ; $00BBE2 CMPI.B  #$0010,$0000(A0)
        DC.W    $6630               ; $00BBE8 BNE.S  loc_00BC1A
        DC.W    $23FC,$0089,$4262,$00FF,$0002; $00BBEA MOVE.L  #$00894262,$00FF0002
        DC.W    $5238,$FEB6         ; $00BBF4 ADDQ.B  #1,$FEB6.W
        DC.W    $0C38,$0004,$FEB6   ; $00BBF8 CMPI.B  #$0004,$FEB6.W
        DC.W    $6F14               ; $00BBFE BLE.S  loc_00BC14
        DC.W    $4238,$FEB6         ; $00BC00 CLR.B  $FEB6.W
        DC.W    $5238,$FEB5         ; $00BC04 ADDQ.B  #1,$FEB5.W
        DC.W    $0C38,$0002,$FEB5   ; $00BC08 CMPI.B  #$0002,$FEB5.W
loc_00BC0E:
        DC.W    $6F04               ; $00BC0E BLE.S  loc_00BC14
        DC.W    $4238,$FEB5         ; $00BC10 CLR.B  $FEB5.W
loc_00BC14:
        DC.W    $4EF9,$0088,$2890   ; $00BC14 JMP     $00882890
loc_00BC1A:
        DC.W    $4E75               ; $00BC1A RTS
        DC.W    $6000,$00AC         ; $00BC1C BRA.W  loc_00BCCA
        DC.W    $6000,$0108         ; $00BC20 BRA.W  loc_00BD2A
        DC.W    $6000,$0104         ; $00BC24 BRA.W  loc_00BD2A
        DC.W    $6000,$00D6         ; $00BC28 BRA.W  loc_00BD00
        DC.W    $6000,$0170         ; $00BC2C BRA.W  loc_00BD9E
        DC.W    $0088,$BDA6,$0088   ; $00BC30 ORI.L  #$BDA60088,A0
        DC.W    $BDA8,$0088         ; $00BC36 EOR.L  D6,$0088(A0)
        DC.W    $BDC8               ; $00BC3A CMPA.L  A0,A6
        DC.W    $0088,$BDA6,$43F9   ; $00BC3C ORI.L  #$BDA643F9,A0
        DC.W    $00FF               ; $00BC42 DC.W    $00FF
        DC.W    $60C8               ; $00BC44 BRA.S  loc_00BC0E
        DC.W    $32BC,$0010         ; $00BC46 MOVE.W  #$0010,(A1)
        DC.W    $337C,$00CF,$0002   ; $00BC4A MOVE.W  #$00CF,$0002(A1)
        DC.W    $13FC,$0000,$00FF,$6850; $00BC50 MOVE.B  #$0000,$00FF6850
        DC.W    $4EBA,$020E         ; $00BC58 JSR     loc_00BE68(PC)
        DC.W    $4EBA,$E3F2         ; $00BC5C JSR     $00A050(PC)
        DC.W    $4EBA,$0174         ; $00BC60 JSR     loc_00BDD6(PC)
        DC.W    $41F9,$0089,$7000   ; $00BC64 LEA     $00897000,A0
        DC.W    $3038,$C8A0         ; $00BC6A MOVE.W  $C8A0.W,D0
        DC.W    $2070,$0000         ; $00BC6E MOVEA.L $00(A0,D0.W),A0
        DC.W    $3038,$C082         ; $00BC72 MOVE.W  $C082.W,D0
        DC.W    $E940               ; $00BC76 ASL.W  #4,D0
        DC.W    $41F0,$0000         ; $00BC78 LEA     $00(A0,D0.W),A0
        DC.W    $7000               ; $00BC7C MOVEQ   #$00,D0
        DC.W    $1028,$0000         ; $00BC7E MOVE.B  $0000(A0),D0
        DC.W    $4EBB,$0098         ; $00BC82 JSR     -$68(PC,D0.W)
        DC.W    $43F9,$00FF,$6830   ; $00BC86 LEA     $00FF6830,A1
        DC.W    $7000               ; $00BC8C MOVEQ   #$00,D0
        DC.W    $5278,$A0E8         ; $00BC8E ADDQ.W  #1,$A0E8.W
        DC.W    $0838,$0003,$A0E9   ; $00BC92 BTST    #3,$A0E9.W
        DC.W    $6702               ; $00BC98 BEQ.S  loc_00BC9C
        DC.W    $7001               ; $00BC9A MOVEQ   #$01,D0
loc_00BC9C:
        DC.W    $1280               ; $00BC9C MOVE.B  D0,(A1)
        DC.W    $3028,$000E         ; $00BC9E MOVE.W  $000E(A0),D0
        DC.W    $D040               ; $00BCA2 ADD.W  D0,D0
        DC.W    $D040               ; $00BCA4 ADD.W  D0,D0
        DC.W    $227B,$0088         ; $00BCA6 MOVEA.L -$78(PC,D0.W),A1
        DC.W    $4E91               ; $00BCAA JSR     (A1)
        DC.W    $5378,$C084         ; $00BCAC SUBQ.W  #1,$C084.W
        DC.W    $6A16               ; $00BCB0 BPL.S  loc_00BCC8
        DC.W    $5278,$C082         ; $00BCB2 ADDQ.W  #1,$C082.W
        DC.W    $4278,$C8AA         ; $00BCB6 CLR.W  $C8AA.W
        DC.W    $41E8,$0010         ; $00BCBA LEA     $0010(A0),A0
        DC.W    $7000               ; $00BCBE MOVEQ   #$00,D0
        DC.W    $1028,$0001         ; $00BCC0 MOVE.B  $0001(A0),D0
        DC.W    $31C0,$C084         ; $00BCC4 MOVE.W  D0,$C084.W
loc_00BCC8:
        DC.W    $4E75               ; $00BCC8 RTS
loc_00BCCA:
        DC.W    $4278,$C8AA         ; $00BCCA CLR.W  $C8AA.W
        DC.W    $4278,$C084         ; $00BCCE CLR.W  $C084.W
        DC.W    $31FC,$001C,$C07A   ; $00BCD2 MOVE.W  #$001C,$C07A.W
        DC.W    $4E75               ; $00BCD8 RTS
loc_00BCDA:
        DC.W    $4278,$C8AA         ; $00BCDA CLR.W  $C8AA.W
        DC.W    $4278,$C084         ; $00BCDE CLR.W  $C084.W
        DC.W    $43E8,$0002         ; $00BCE2 LEA     $0002(A0),A1
        DC.W    $31D9,$C086         ; $00BCE6 MOVE.W  (A1)+,$C086.W
        DC.W    $31D9,$C054         ; $00BCEA MOVE.W  (A1)+,$C054.W
        DC.W    $31D9,$C056         ; $00BCEE MOVE.W  (A1)+,$C056.W
        DC.W    $31D9,$C0AE         ; $00BCF2 MOVE.W  (A1)+,$C0AE.W
        DC.W    $31D9,$C0B0         ; $00BCF6 MOVE.W  (A1)+,$C0B0.W
        DC.W    $31D9,$C0B2         ; $00BCFA MOVE.W  (A1)+,$C0B2.W
        DC.W    $4E75               ; $00BCFE RTS
loc_00BD00:
        DC.W    $43E8,$0002         ; $00BD00 LEA     $0002(A0),A1
loc_00BD04:
        DC.W    $43E9,$FFF0         ; $00BD04 LEA     -$0010(A1),A1
        DC.W    $0C29,$000C,$FFFE   ; $00BD08 CMPI.B  #$000C,-$0002(A1)
        DC.W    $67F4               ; $00BD0E BEQ.S  loc_00BD04
        DC.W    $31D9,$C086         ; $00BD10 MOVE.W  (A1)+,$C086.W
        DC.W    $31D9,$C054         ; $00BD14 MOVE.W  (A1)+,$C054.W
        DC.W    $31D9,$C056         ; $00BD18 MOVE.W  (A1)+,$C056.W
        DC.W    $31D9,$C0AE         ; $00BD1C MOVE.W  (A1)+,$C0AE.W
        DC.W    $31D9,$C0B0         ; $00BD20 MOVE.W  (A1)+,$C0B0.W
        DC.W    $31D9,$C0B2         ; $00BD24 MOVE.W  (A1)+,$C0B2.W
        DC.W    $4E75               ; $00BD28 RTS
loc_00BD2A:
        DC.W    $7400               ; $00BD2A MOVEQ   #$00,D2
        DC.W    $1428,$0001         ; $00BD2C MOVE.B  $0001(A0),D2
        DC.W    $5242               ; $00BD30 ADDQ.W  #1,D2
        DC.W    $3038,$C8AA         ; $00BD32 MOVE.W  $C8AA.W,D0
        DC.W    $45E8,$0002         ; $00BD36 LEA     $0002(A0),A2
        DC.W    $43D2               ; $00BD3A LEA     (A2),A1
loc_00BD3C:
        DC.W    $43E9,$FFF0         ; $00BD3C LEA     -$0010(A1),A1
        DC.W    $0C29,$000C,$FFFE   ; $00BD40 CMPI.B  #$000C,-$0002(A1)
        DC.W    $67F4               ; $00BD46 BEQ.S  loc_00BD3C
        DC.W    $321A               ; $00BD48 MOVE.W  (A2)+,D1
        DC.W    $9251               ; $00BD4A SUB.W  (A1),D1
        DC.W    $C3C0               ; $00BD4C MULS    D0,D1
        DC.W    $83C2               ; $00BD4E DIVS    D2,D1
        DC.W    $D259               ; $00BD50 ADD.W  (A1)+,D1
        DC.W    $31C1,$C086         ; $00BD52 MOVE.W  D1,$C086.W
        DC.W    $321A               ; $00BD56 MOVE.W  (A2)+,D1
        DC.W    $9251               ; $00BD58 SUB.W  (A1),D1
        DC.W    $C3C0               ; $00BD5A MULS    D0,D1
        DC.W    $83C2               ; $00BD5C DIVS    D2,D1
        DC.W    $D259               ; $00BD5E ADD.W  (A1)+,D1
        DC.W    $31C1,$C054         ; $00BD60 MOVE.W  D1,$C054.W
        DC.W    $321A               ; $00BD64 MOVE.W  (A2)+,D1
        DC.W    $9251               ; $00BD66 SUB.W  (A1),D1
        DC.W    $C3C0               ; $00BD68 MULS    D0,D1
        DC.W    $83C2               ; $00BD6A DIVS    D2,D1
        DC.W    $D259               ; $00BD6C ADD.W  (A1)+,D1
        DC.W    $31C1,$C056         ; $00BD6E MOVE.W  D1,$C056.W
        DC.W    $321A               ; $00BD72 MOVE.W  (A2)+,D1
        DC.W    $9251               ; $00BD74 SUB.W  (A1),D1
        DC.W    $C3C0               ; $00BD76 MULS    D0,D1
        DC.W    $83C2               ; $00BD78 DIVS    D2,D1
        DC.W    $D259               ; $00BD7A ADD.W  (A1)+,D1
        DC.W    $31C1,$C0AE         ; $00BD7C MOVE.W  D1,$C0AE.W
        DC.W    $321A               ; $00BD80 MOVE.W  (A2)+,D1
        DC.W    $9251               ; $00BD82 SUB.W  (A1),D1
        DC.W    $C3C0               ; $00BD84 MULS    D0,D1
        DC.W    $83C2               ; $00BD86 DIVS    D2,D1
        DC.W    $D259               ; $00BD88 ADD.W  (A1)+,D1
        DC.W    $31C1,$C0B0         ; $00BD8A MOVE.W  D1,$C0B0.W
        DC.W    $321A               ; $00BD8E MOVE.W  (A2)+,D1
        DC.W    $9251               ; $00BD90 SUB.W  (A1),D1
        DC.W    $C3C0               ; $00BD92 MULS    D0,D1
        DC.W    $83C2               ; $00BD94 DIVS    D2,D1
        DC.W    $D259               ; $00BD96 ADD.W  (A1)+,D1
        DC.W    $31C1,$C0B2         ; $00BD98 MOVE.W  D1,$C0B2.W
        DC.W    $4E75               ; $00BD9C RTS
loc_00BD9E:
        DC.W    $584F               ; $00BD9E ADDQ.W  #4,A7
        DC.W    $11FC,$0001,$C308   ; $00BDA0 MOVE.B  #$0001,$C308.W
        DC.W    $4E75               ; $00BDA6 RTS
        DC.W    $4A78,$A0F0         ; $00BDA8 TST.W  $A0F0.W
        DC.W    $6618               ; $00BDAC BNE.S  loc_00BDC6
        DC.W    $0838,$0001,$C8AB   ; $00BDAE BTST    #1,$C8AB.W
        DC.W    $6710               ; $00BDB4 BEQ.S  loc_00BDC6
        DC.W    $33FC,$FFFF,$00FF,$60C8; $00BDB6 MOVE.W  #$FFFF,$00FF60C8
        DC.W    $13FC,$0009,$00FF,$6850; $00BDBE MOVE.B  #$0009,$00FF6850
loc_00BDC6:
        DC.W    $4E75               ; $00BDC6 RTS
        DC.W    $4A78,$A0F0         ; $00BDC8 TST.W  $A0F0.W
        DC.W    $6606               ; $00BDCC BNE.S  loc_00BDD4
        DC.W    $31FC,$0001,$A0F0   ; $00BDCE MOVE.W  #$0001,$A0F0.W
loc_00BDD4:
        DC.W    $4E75               ; $00BDD4 RTS
loc_00BDD6:
        DC.W    $3238,$A0F0         ; $00BDD6 MOVE.W  $A0F0.W,D1
        DC.W    $6720               ; $00BDDA BEQ.S  loc_00BDFC
        DC.W    $43F9,$00FF,$6860   ; $00BDDC LEA     $00FF6860,A1
        DC.W    $137C,$000B,$0000   ; $00BDE2 MOVE.B  #$000B,$0000(A1)
        DC.W    $137C,$000C,$0010   ; $00BDE8 MOVE.B  #$000C,$0010(A1)
        DC.W    $0C41,$000C         ; $00BDEE CMPI.W  #$000C,D1
        DC.W    $6D0A               ; $00BDF2 BLT.S  loc_00BDFE
        DC.W    $33FC,$FFFF,$00FF,$60C8; $00BDF4 MOVE.W  #$FFFF,$00FF60C8
loc_00BDFC:
        DC.W    $4E75               ; $00BDFC RTS
loc_00BDFE:
        DC.W    $D241               ; $00BDFE ADD.W  D1,D1
        DC.W    $303B,$104E         ; $00BE00 MOVE.W  $4E(PC,D1.W),D0
        DC.W    $0640,$0010         ; $00BE04 ADDI.W  #$0010,D0
        DC.W    $31C0,$A0E6         ; $00BE08 MOVE.W  D0,$A0E6.W
        DC.W    $3400               ; $00BE0C MOVE.W  D0,D2
        DC.W    $0442,$0010         ; $00BE0E SUBI.W  #$0010,D2
        DC.W    $3342,$0002         ; $00BE12 MOVE.W  D2,$0002(A1)
        DC.W    $3342,$0012         ; $00BE16 MOVE.W  D2,$0012(A1)
        DC.W    $323C,$00E0         ; $00BE1A MOVE.W  #$00E0,D1
        DC.W    $9240               ; $00BE1E SUB.W  D0,D1
        DC.W    $45F9,$00FF,$60C8   ; $00BE20 LEA     $00FF60C8,A2
        DC.W    $3480               ; $00BE26 MOVE.W  D0,(A2)
        DC.W    $3541,$0002         ; $00BE28 MOVE.W  D1,$0002(A2)
        DC.W    $5340               ; $00BE2C SUBQ.W  #1,D0
        DC.W    $7409               ; $00BE2E MOVEQ   #$09,D2
        DC.W    $48C0               ; $00BE30 EXT.L   D0
        DC.W    $E5A0               ; $00BE32 ASL.L  D2,D0
        DC.W    $48C1               ; $00BE34 EXT.L   D1
        DC.W    $E5A1               ; $00BE36 ASL.L  D2,D1
        DC.W    $243C,$0402,$4140   ; $00BE38 MOVE.L  #$04024140,D2
        DC.W    $D082               ; $00BE3E ADD.L  D2,D0
        DC.W    $D282               ; $00BE40 ADD.L  D2,D1
        DC.W    $2340,$0004         ; $00BE42 MOVE.L  D0,$0004(A1)
        DC.W    $2341,$0014         ; $00BE46 MOVE.L  D1,$0014(A1)
        DC.W    $5278,$A0F0         ; $00BE4A ADDQ.W  #1,$A0F0.W
        DC.W    $4E75               ; $00BE4E RTS
        DC.W    $0000,$0002         ; $00BE50 ORI.B  #$0002,D0
        DC.W    $0004,$0008         ; $00BE54 ORI.B  #$0008,D4
        DC.W    $000C,$0012         ; $00BE58 ORI.B  #$0012,A4
        DC.W    $001A,$0024         ; $00BE5C ORI.B  #$0024,(A2)+
        DC.W    $0030,$003E,$004E   ; $00BE60 ORI.B  #$003E,$4E(A0,D0.W)
        DC.W    $0060,$3038         ; $00BE66 ORI.W  #$3038,-(A0)
        DC.W    $A0EA,$207B         ; $00BE6A MOVE.L  $207B(A2),(A0)+
        DC.W    $0004,$4ED0         ; $00BE6E ORI.B  #$4ED0,D4
        DC.W    $0088,$BEAE,$0088   ; $00BE72 ORI.L  #$BEAE0088,A0
        DC.W    $BEC4               ; $00BE78 CMPA.W  D4,A7
        DC.W    $0088,$BF14,$0088   ; $00BE7A ORI.L  #$BF140088,A0
        DC.W    $BF9E               ; $00BE80 EOR.L  D7,(A6)+
        DC.W    $0088,$BFDE,$0088   ; $00BE82 ORI.L  #$BFDE0088,A0
        DC.W    $BF14               ; $00BE88 EOR.B  D7,(A4)
        DC.W    $0088,$BF9E,$0088   ; $00BE8A ORI.L  #$BF9E0088,A0
        DC.W    $BFDE               ; $00BE90 CMPA.L  (A6)+,A7
        DC.W    $0088,$BF14,$0088   ; $00BE92 ORI.L  #$BF140088,A0
        DC.W    $BF9E               ; $00BE98 EOR.L  D7,(A6)+
        DC.W    $0088,$BFDE,$0088   ; $00BE9A ORI.L  #$BFDE0088,A0
        DC.W    $BF14               ; $00BEA0 EOR.B  D7,(A4)
        DC.W    $0088,$BF9E,$0088   ; $00BEA2 ORI.L  #$BF9E0088,A0
        DC.W    $BFDE               ; $00BEA8 CMPA.L  (A6)+,A7
        DC.W    $0088,$C028,$5278   ; $00BEAA ORI.L  #$C0285278,A0
        DC.W    $A0EC,$0C78         ; $00BEB0 MOVE.L  $0C78(A4),(A0)+
        DC.W    $0078,$A0EC,$6D08   ; $00BEB4 ORI.W  #$A0EC,$6D08.W
        DC.W    $5878,$A0EA         ; $00BEBA ADDQ.W  #4,$A0EA.W
        DC.W    $4278,$A0EC         ; $00BEBE CLR.W  $A0EC.W
        DC.W    $4E75               ; $00BEC2 RTS
        DC.W    $5878,$A0EA         ; $00BEC4 ADDQ.W  #4,$A0EA.W
        DC.W    $4278,$A0EC         ; $00BEC8 CLR.W  $A0EC.W
        DC.W    $43F9,$00FF,$6800   ; $00BECC LEA     $00FF6800,A1
        DC.W    $137C,$0001,$0000   ; $00BED2 MOVE.B  #$0001,$0000(A1)
        DC.W    $43F9,$00FF,$6810   ; $00BED8 LEA     $00FF6810,A1
        DC.W    $137C,$0001,$0000   ; $00BEDE MOVE.B  #$0001,$0000(A1)
        DC.W    $43F9,$00FF,$6820   ; $00BEE4 LEA     $00FF6820,A1
        DC.W    $137C,$0001,$0000   ; $00BEEA MOVE.B  #$0001,$0000(A1)
        DC.W    $3038,$C8A0         ; $00BEF0 MOVE.W  $C8A0.W,D0
        DC.W    $237B,$0006,$0008   ; $00BEF4 MOVE.L  $06(PC,D0.W),$0008(A1)
        DC.W    $4E75               ; $00BEFA RTS
        DC.W    $222E,$35E0         ; $00BEFC MOVE.L  $35E0(A6),D1
        DC.W    $222E,$3CE4         ; $00BF00 MOVE.L  $3CE4(A6),D1
        DC.W    $222E,$43E8         ; $00BF04 MOVE.L  $43E8(A6),D1
        DC.W    $222E,$4A6C         ; $00BF08 MOVE.L  $4A6C(A6),D1
        DC.W    $222E,$5070         ; $00BF0C MOVE.L  $5070(A6),D1
        DC.W    $222E,$35E0         ; $00BF10 MOVE.L  $35E0(A6),D1
        DC.W    $43F9,$00FF,$6900   ; $00BF14 LEA     $00FF6900,A1
        DC.W    $45F8,$EF08         ; $00BF1A LEA     $EF08.W,A2
        DC.W    $47F9,$0088,$C05C   ; $00BF1E LEA     $0088C05C,A3
        DC.W    $3038,$A0EE         ; $00BF24 MOVE.W  $A0EE.W,D0
        DC.W    $3200               ; $00BF28 MOVE.W  D0,D1
        DC.W    $5241               ; $00BF2A ADDQ.W  #1,D1
        DC.W    $E740               ; $00BF2C ASL.W  #3,D0
        DC.W    $45F2,$0000         ; $00BF2E LEA     $00(A2,D0.W),A2
        DC.W    $3038,$C89C         ; $00BF32 MOVE.W  $C89C.W,D0
        DC.W    $D078,$C8CA         ; $00BF36 ADD.W  $C8CA.W,D0
        DC.W    $D078,$C8CC         ; $00BF3A ADD.W  $C8CC.W,D0
        DC.W    $EB48               ; $00BF3E LSL.W  #5,D0
        DC.W    $3400               ; $00BF40 MOVE.W  D0,D2
        DC.W    $D442               ; $00BF42 ADD.W  D2,D2
        DC.W    $D442               ; $00BF44 ADD.W  D2,D2
        DC.W    $D042               ; $00BF46 ADD.W  D2,D0
        DC.W    $D4C0               ; $00BF48 ADDA.W  D0,A2
        DC.W    $7004               ; $00BF4A MOVEQ   #$04,D0
loc_00BF4C:
        DC.W    $4259               ; $00BF4C CLR.W  (A1)+
        DC.W    $12C1               ; $00BF4E MOVE.B  D1,(A1)+
        DC.W    $12EA,$0003         ; $00BF50 MOVE.B  $0003(A2),(A1)+
        DC.W    $22DB               ; $00BF54 MOVE.L  (A3)+,(A1)+
        DC.W    $4259               ; $00BF56 CLR.W  (A1)+
        DC.W    $12EA,$0004         ; $00BF58 MOVE.B  $0004(A2),(A1)+
        DC.W    $142A,$0005         ; $00BF5C MOVE.B  $0005(A2),D2
        DC.W    $1602               ; $00BF60 MOVE.B  D2,D3
        DC.W    $E84B               ; $00BF62 LSR.W  #4,D3
        DC.W    $12C3               ; $00BF64 MOVE.B  D3,(A1)+
        DC.W    $0202,$000F         ; $00BF66 ANDI.B  #$000F,D2
        DC.W    $12C2               ; $00BF6A MOVE.B  D2,(A1)+
        DC.W    $12EA,$0006         ; $00BF6C MOVE.B  $0006(A2),(A1)+
        DC.W    $142A,$0007         ; $00BF70 MOVE.B  $0007(A2),D2
        DC.W    $1602               ; $00BF74 MOVE.B  D2,D3
        DC.W    $E84B               ; $00BF76 LSR.W  #4,D3
        DC.W    $12C3               ; $00BF78 MOVE.B  D3,(A1)+
        DC.W    $0202,$000F         ; $00BF7A ANDI.B  #$000F,D2
        DC.W    $12C2               ; $00BF7E MOVE.B  D2,(A1)+
        DC.W    $2412               ; $00BF80 MOVE.L  (A2),D2
        DC.W    $0282,$FFFF,$FF00   ; $00BF82 ANDI.L  #$FFFFFF00,D2
        DC.W    $22C2               ; $00BF88 MOVE.L  D2,(A1)+
        DC.W    $5241               ; $00BF8A ADDQ.W  #1,D1
        DC.W    $45EA,$0008         ; $00BF8C LEA     $0008(A2),A2
        DC.W    $51C8,$FFBA         ; $00BF90 DBRA    D0,loc_00BF4C
        DC.W    $5878,$A0EA         ; $00BF94 ADDQ.W  #4,$A0EA.W
        DC.W    $5A78,$A0EE         ; $00BF98 ADDQ.W  #5,$A0EE.W
        DC.W    $4E75               ; $00BF9C RTS
        DC.W    $5278,$A0EC         ; $00BF9E ADDQ.W  #1,$A0EC.W
        DC.W    $7000               ; $00BFA2 MOVEQ   #$00,D0
        DC.W    $3038,$A0EC         ; $00BFA4 MOVE.W  $A0EC.W,D0
        DC.W    $D040               ; $00BFA8 ADD.W  D0,D0
        DC.W    $80FC,$001C         ; $00BFAA DIVU    #$001C,D0
        DC.W    $0C40,$0005         ; $00BFAE CMPI.W  #$0005,D0
        DC.W    $6C20               ; $00BFB2 BGE.S  loc_00BFD4
        DC.W    $3200               ; $00BFB4 MOVE.W  D0,D1
        DC.W    $4840               ; $00BFB6 SWAP    D0
        DC.W    $5440               ; $00BFB8 ADDQ.W  #2,D0
        DC.W    $D241               ; $00BFBA ADD.W  D1,D1
        DC.W    $D241               ; $00BFBC ADD.W  D1,D1
        DC.W    $3401               ; $00BFBE MOVE.W  D1,D2
        DC.W    $D241               ; $00BFC0 ADD.W  D1,D1
        DC.W    $D241               ; $00BFC2 ADD.W  D1,D1
        DC.W    $D242               ; $00BFC4 ADD.W  D2,D1
        DC.W    $43F9,$00FF,$6900   ; $00BFC6 LEA     $00FF6900,A1
        DC.W    $43F1,$1000         ; $00BFCC LEA     $00(A1,D1.W),A1
        DC.W    $3280               ; $00BFD0 MOVE.W  D0,(A1)
        DC.W    $4E75               ; $00BFD2 RTS
loc_00BFD4:
        DC.W    $5878,$A0EA         ; $00BFD4 ADDQ.W  #4,$A0EA.W
        DC.W    $4278,$A0EC         ; $00BFD8 CLR.W  $A0EC.W
        DC.W    $4E75               ; $00BFDC RTS
        DC.W    $5278,$A0EC         ; $00BFDE ADDQ.W  #1,$A0EC.W
        DC.W    $7000               ; $00BFE2 MOVEQ   #$00,D0
        DC.W    $3038,$A0EC         ; $00BFE4 MOVE.W  $A0EC.W,D0
        DC.W    $D040               ; $00BFE8 ADD.W  D0,D0
        DC.W    $80FC,$001C         ; $00BFEA DIVU    #$001C,D0
        DC.W    $0C40,$0005         ; $00BFEE CMPI.W  #$0005,D0
        DC.W    $6C2A               ; $00BFF2 BGE.S  loc_00C01E
        DC.W    $3200               ; $00BFF4 MOVE.W  D0,D1
        DC.W    $4840               ; $00BFF6 SWAP    D0
        DC.W    $5440               ; $00BFF8 ADDQ.W  #2,D0
        DC.W    $4440               ; $00BFFA NEG.W  D0
        DC.W    $0C40,$FFE4         ; $00BFFC CMPI.W  #$FFE4,D0
        DC.W    $6602               ; $00C000 BNE.S  loc_00C004
        DC.W    $7000               ; $00C002 MOVEQ   #$00,D0
loc_00C004:
        DC.W    $D241               ; $00C004 ADD.W  D1,D1
        DC.W    $D241               ; $00C006 ADD.W  D1,D1
        DC.W    $3401               ; $00C008 MOVE.W  D1,D2
        DC.W    $D241               ; $00C00A ADD.W  D1,D1
        DC.W    $D241               ; $00C00C ADD.W  D1,D1
        DC.W    $D242               ; $00C00E ADD.W  D2,D1
        DC.W    $43F9,$00FF,$6900   ; $00C010 LEA     $00FF6900,A1
        DC.W    $43F1,$1000         ; $00C016 LEA     $00(A1,D1.W),A1
        DC.W    $3280               ; $00C01A MOVE.W  D0,(A1)
        DC.W    $4E75               ; $00C01C RTS
loc_00C01E:
        DC.W    $5878,$A0EA         ; $00C01E ADDQ.W  #4,$A0EA.W
        DC.W    $4278,$A0EC         ; $00C022 CLR.W  $A0EC.W
        DC.W    $4E75               ; $00C026 RTS
        DC.W    $7000               ; $00C028 MOVEQ   #$00,D0
        DC.W    $43F9,$00FF,$6800   ; $00C02A LEA     $00FF6800,A1
        DC.W    $1340,$0000         ; $00C030 MOVE.B  D0,$0000(A1)
        DC.W    $43F9,$00FF,$6810   ; $00C034 LEA     $00FF6810,A1
        DC.W    $1340,$0000         ; $00C03A MOVE.B  D0,$0000(A1)
        DC.W    $43F9,$00FF,$6820   ; $00C03E LEA     $00FF6820,A1
        DC.W    $1340,$0000         ; $00C044 MOVE.B  D0,$0000(A1)
        DC.W    $43F9,$00FF,$6900   ; $00C048 LEA     $00FF6900,A1
        DC.W    $7205               ; $00C04E MOVEQ   #$05,D1
loc_00C050:
        DC.W    $4251               ; $00C050 CLR.W  (A1)
        DC.W    $43E9,$0014         ; $00C052 LEA     $0014(A1),A1
        DC.W    $51C9,$FFF8         ; $00C056 DBRA    D1,loc_00C050
        DC.W    $4E75               ; $00C05A RTS
        DC.W    $0402,$C030         ; $00C05C SUBI.B  #$C030,D2
        DC.W    $0402,$E030         ; $00C060 SUBI.B  #$E030,D2
        DC.W    $0403,$0030         ; $00C064 SUBI.B  #$0030,D3
        DC.W    $0403,$2030         ; $00C068 SUBI.B  #$2030,D3
        DC.W    $0403,$4030         ; $00C06C SUBI.B  #$4030,D3
        DC.W    $43F9,$00FF,$6800   ; $00C070 LEA     $00FF6800,A1
        DC.W    $7210               ; $00C076 MOVEQ   #$10,D1
        DC.W    $700F               ; $00C078 MOVEQ   #$0F,D0
loc_00C07A:
        DC.W    $4251               ; $00C07A CLR.W  (A1)
        DC.W    $D2C1               ; $00C07C ADDA.W  D1,A1
        DC.W    $51C8,$FFFA         ; $00C07E DBRA    D0,loc_00C07A
        DC.W    $3438,$C0FC         ; $00C082 MOVE.W  $C0FC.W,D2
        DC.W    $6700,$0054         ; $00C086 BEQ.W  loc_00C0DC
        DC.W    $6B0A               ; $00C08A BMI.S  loc_00C096
        DC.W    $4278,$C0FE         ; $00C08C CLR.W  $C0FE.W
        DC.W    $08F8,$0007,$C0FC   ; $00C090 BSET    #7,$C0FC.W
loc_00C096:
        DC.W    $5342               ; $00C096 SUBQ.W  #1,D2
        DC.W    $0242,$0007         ; $00C098 ANDI.W  #$0007,D2
        DC.W    $D442               ; $00C09C ADD.W  D2,D2
        DC.W    $D442               ; $00C09E ADD.W  D2,D2
        DC.W    $45F9,$0089,$ACF0   ; $00C0A0 LEA     $0089ACF0,A2
        DC.W    $2472,$2000         ; $00C0A6 MOVEA.L $00(A2,D2.W),A2
        DC.W    $43F9,$00FF,$6800   ; $00C0AA LEA     $00FF6800,A1
        DC.W    $321A               ; $00C0B0 MOVE.W  (A2)+,D1
loc_00C0B2:
        DC.W    $32DA               ; $00C0B2 MOVE.W  (A2)+,(A1)+
        DC.W    $361A               ; $00C0B4 MOVE.W  (A2)+,D3
        DC.W    $4259               ; $00C0B6 CLR.W  (A1)+
        DC.W    $22DA               ; $00C0B8 MOVE.L  (A2)+,(A1)+
        DC.W    $22DA               ; $00C0BA MOVE.L  (A2)+,(A1)+
        DC.W    $4299               ; $00C0BC CLR.L  (A1)+
        DC.W    $9678,$C0FE         ; $00C0BE SUB.W  $C0FE.W,D3
        DC.W    $6B14               ; $00C0C2 BMI.S  loc_00C0D8
        DC.W    $0C43,$0050         ; $00C0C4 CMPI.W  #$0050,D3
        DC.W    $6F04               ; $00C0C8 BLE.S  loc_00C0CE
        DC.W    $363C,$0050         ; $00C0CA MOVE.W  #$0050,D3
loc_00C0CE:
        DC.W    $D643               ; $00C0CE ADD.W  D3,D3
        DC.W    $D643               ; $00C0D0 ADD.W  D3,D3
        DC.W    $48C3               ; $00C0D2 EXT.L   D3
        DC.W    $D7A9,$FFF4         ; $00C0D4 ADD.L  D3,-$000C(A1)
loc_00C0D8:
        DC.W    $51C9,$FFD8         ; $00C0D8 DBRA    D1,loc_00C0B2
loc_00C0DC:
        DC.W    $5078,$C0FE         ; $00C0DC ADDQ.W  #8,$C0FE.W
        DC.W    $0C78,$7FFF,$C0FE   ; $00C0E0 CMPI.W  #$7FFF,$C0FE.W
        DC.W    $6F06               ; $00C0E6 BLE.S  loc_00C0EE
        DC.W    $31FC,$7FFF,$C0FE   ; $00C0E8 MOVE.W  #$7FFF,$C0FE.W
loc_00C0EE:
        DC.W    $4E75               ; $00C0EE RTS
        DC.W    $46FC,$2700         ; $00C0F0 NOT    #$2700
        DC.W    $08B8,$0006,$C875   ; $00C0F4 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00C0FA MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $00C0FE MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $00C106 ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$270A   ; $00C10E JSR     $0088270A
        DC.W    $11FC,$0001,$C80D   ; $00C114 MOVE.B  #$0001,$C80D.W
        DC.W    $0238,$0009,$C80E   ; $00C11A ANDI.B  #$0009,$C80E.W
        DC.W    $08F8,$0003,$C80E   ; $00C120 BSET    #3,$C80E.W
        DC.W    $7000               ; $00C126 MOVEQ   #$00,D0
        DC.W    $7200               ; $00C128 MOVEQ   #$00,D1
        DC.W    $103C,$0000         ; $00C12A MOVE.B  #$0000,D0
        DC.W    $123C,$0000         ; $00C12E MOVE.B  #$0000,D1
        DC.W    $4EBA,$1068         ; $00C132 JSR     $00D19C(PC)
        DC.W    $1038,$C8C9         ; $00C136 MOVE.B  $C8C9.W,D0
        DC.W    $5200               ; $00C13A ADDQ.B  #1,D0
        DC.W    $13C0,$00A1,$5122   ; $00C13C MOVE.B  D0,$00A15122
        DC.W    $31FC,$0103,$C8A8   ; $00C142 MOVE.W  #$0103,$C8A8.W
        DC.W    $13F8,$C8A9,$00A1,$5121; $00C148 MOVE.B  $C8A9.W,$00A15121
        DC.W    $13F8,$C8A8,$00A1,$5120; $00C150 MOVE.B  $C8A8.W,$00A15120
        DC.W    $11FC,$0000,$C80F   ; $00C158 MOVE.B  #$0000,$C80F.W
        DC.W    $31FC,$0000,$C8BC   ; $00C15E MOVE.W  #$0000,$C8BC.W
        DC.W    $4EB9,$0088,$D1D4   ; $00C164 JSR     $0088D1D4
        DC.W    $4EB9,$0088,$D42C   ; $00C16A JSR     $0088D42C
        DC.W    $41F9,$008B,$A220   ; $00C170 LEA     $008BA220,A0
        DC.W    $3038,$C8A0         ; $00C176 MOVE.W  $C8A0.W,D0
        DC.W    $2470,$0000         ; $00C17A MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EB9,$0088,$284C   ; $00C17E JSR     $0088284C
        DC.W    $41F9,$008B,$AE38   ; $00C184 LEA     $008BAE38,A0
        DC.W    $3038,$C8CC         ; $00C18A MOVE.W  $C8CC.W,D0
        DC.W    $2470,$0000         ; $00C18E MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EB9,$0088,$2862   ; $00C192 JSR     $00882862
        DC.W    $33FC,$0010,$00FF,$0008; $00C198 MOVE.W  #$0010,$00FF0008
        DC.W    $31FC,$0000,$C8AA   ; $00C1A0 MOVE.W  #$0000,$C8AA.W
        DC.W    $4EB9,$0088,$49AA   ; $00C1A6 JSR     $008849AA
        DC.W    $4EBA,$0BE4         ; $00C1AC JSR     $00CD92(PC)
        DC.W    $11FC,$0000,$C314   ; $00C1B0 MOVE.B  #$0000,$C314.W
        DC.W    $0838,$0000,$C818   ; $00C1B6 BTST    #0,$C818.W
        DC.W    $6706               ; $00C1BC BEQ.S  loc_00C1C4
        DC.W    $11FC,$0001,$C314   ; $00C1BE MOVE.B  #$0001,$C314.W
loc_00C1C4:
        DC.W    $7000               ; $00C1C4 MOVEQ   #$00,D0
        DC.W    $4EBA,$0AAC         ; $00C1C6 JSR     $00CC74(PC)
        DC.W    $4EBA,$06A4         ; $00C1CA JSR     $00C870(PC)
        DC.W    $4EBA,$0820         ; $00C1CE JSR     $00C9F0(PC)
        DC.W    $4EBA,$0E38         ; $00C1D2 JSR     $00D00C(PC)
        DC.W    $11FC,$0005,$C310   ; $00C1D6 MOVE.B  #$0005,$C310.W
        DC.W    $11FC,$0000,$C30F   ; $00C1DC MOVE.B  #$0000,$C30F.W
        DC.W    $41F8,$9000         ; $00C1E2 LEA     $9000.W,A0
        DC.W    $4EBA,$0AAA         ; $00C1E6 JSR     $00CC92(PC)
        DC.W    $7200               ; $00C1EA MOVEQ   #$00,D1
        DC.W    $4EBA,$0C68         ; $00C1EC JSR     $00CE56(PC)
        DC.W    $4EBA,$0B5A         ; $00C1F0 JSR     $00CD4C(PC)
        DC.W    $4EB9,$0088,$A80A   ; $00C1F4 JSR     $0088A80A
        DC.W    $4EB9,$0088,$A144   ; $00C1FA JSR     $0088A144
