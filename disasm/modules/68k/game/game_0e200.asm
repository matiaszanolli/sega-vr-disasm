; Generated assembly for $00E200-$010200
; Branch targets: 212
; Labels: 198
; Format: DC.W with decoded mnemonics as comments

        org     $00E200

        DC.W    $5240               ; $00E200 ADDQ.W  #1,D0
        DC.W    $0240,$0003         ; $00E202 ANDI.W  #$0003,D0
        DC.W    $51CB,$FFC2         ; $00E206 DBRA    D3,$00E1CA
        DC.W    $4E75               ; $00E20A RTS
        DC.W    $0807,$0605         ; $00E20C BTST    #5,D7
        DC.W    $0403,$0201         ; $00E210 SUBI.B  #$0201,D3
        DC.W    $1110               ; $00E214 MOVE.B  (A0),-(A0)
        DC.W    $0F0E               ; $00E216 BTST    D7,A6
        DC.W    $0D0C               ; $00E218 BTST    D6,A4
        DC.W    $0B0A               ; $00E21A BTST    D5,A2
        DC.W    $0403,$0201         ; $00E21C SUBI.B  #$0201,D3
        DC.W    $0807,$0605         ; $00E220 BTST    #5,D7
        DC.W    $0D0C               ; $00E224 BTST    D6,A4
        DC.W    $0B0A               ; $00E226 BTST    D5,A2
        DC.W    $1110               ; $00E228 MOVE.B  (A0),-(A0)
        DC.W    $0F0E               ; $00E22A BTST    D7,A6
loc_00E22C:
        DC.W    $2248               ; $00E22C MOVEA.L A0,A1
        DC.W    $E349               ; $00E22E LSL.W  #1,D1
        DC.W    $EF4A               ; $00E230 LSL.W  #7,D2
        DC.W    $D242               ; $00E232 ADD.W  D2,D1
        DC.W    $41F0,$1000         ; $00E234 LEA     $00(A0,D1.W),A0
        DC.W    $0240,$0003         ; $00E238 ANDI.W  #$0003,D0
        DC.W    $E148               ; $00E23C LSL.W  #8,D0
        DC.W    $EB48               ; $00E23E LSL.W  #5,D0
        DC.W    $0640,$0100         ; $00E240 ADDI.W  #$0100,D0
        DC.W    $0880,$000B         ; $00E244 BCLR    #11,D0
        DC.W    $0880,$000C         ; $00E248 BCLR    #12,D0
        DC.W    $7200               ; $00E24C MOVEQ   #$00,D1
        DC.W    $343C,$0006         ; $00E24E MOVE.W  #$0006,D2
        DC.W    $D440               ; $00E252 ADD.W  D0,D2
        DC.W    $3082               ; $00E254 MOVE.W  D2,(A0)
        DC.W    $D1FC,$0000,$0080   ; $00E256 ADDA.L  #$00000080,A0
        DC.W    $343C,$0001         ; $00E25C MOVE.W  #$0001,D2
        DC.W    $3A04               ; $00E260 MOVE.W  D4,D5
        DC.W    $5745               ; $00E262 SUBQ.W  #3,D5
loc_00E264:
        DC.W    $4EBA,$007E         ; $00E264 JSR     loc_00E2E4(PC)
        DC.W    $3086               ; $00E268 MOVE.W  D6,(A0)
        DC.W    $D1FC,$0000,$0080   ; $00E26A ADDA.L  #$00000080,A0
        DC.W    $51CD,$FFF2         ; $00E270 DBRA    D5,loc_00E264
        DC.W    $343C,$0007         ; $00E274 MOVE.W  #$0007,D2
        DC.W    $4EBA,$006A         ; $00E278 JSR     loc_00E2E4(PC)
        DC.W    $30C6               ; $00E27C MOVE.W  D6,(A0)+
        DC.W    $343C,$0003         ; $00E27E MOVE.W  #$0003,D2
        DC.W    $3A03               ; $00E282 MOVE.W  D3,D5
        DC.W    $5745               ; $00E284 SUBQ.W  #3,D5
loc_00E286:
        DC.W    $4EBA,$005C         ; $00E286 JSR     loc_00E2E4(PC)
        DC.W    $30C6               ; $00E28A MOVE.W  D6,(A0)+
        DC.W    $51CD,$FFF8         ; $00E28C DBRA    D5,loc_00E286
        DC.W    $08C0,$000B         ; $00E290 BSET    #11,D0
        DC.W    $08C0,$000C         ; $00E294 BSET    #12,D0
        DC.W    $343C,$0005         ; $00E298 MOVE.W  #$0005,D2
        DC.W    $4EBA,$0046         ; $00E29C JSR     loc_00E2E4(PC)
        DC.W    $3086               ; $00E2A0 MOVE.W  D6,(A0)
        DC.W    $91FC,$0000,$0080   ; $00E2A2 SUBA.L  #$00000080,A0
        DC.W    $343C,$0001         ; $00E2A8 MOVE.W  #$0001,D2
        DC.W    $3A04               ; $00E2AC MOVE.W  D4,D5
        DC.W    $5745               ; $00E2AE SUBQ.W  #3,D5
loc_00E2B0:
        DC.W    $4EBA,$0032         ; $00E2B0 JSR     loc_00E2E4(PC)
        DC.W    $3086               ; $00E2B4 MOVE.W  D6,(A0)
        DC.W    $91FC,$0000,$0080   ; $00E2B6 SUBA.L  #$00000080,A0
        DC.W    $51CD,$FFF2         ; $00E2BC DBRA    D5,loc_00E2B0
        DC.W    $343C,$0007         ; $00E2C0 MOVE.W  #$0007,D2
        DC.W    $4EBA,$001E         ; $00E2C4 JSR     loc_00E2E4(PC)
        DC.W    $3086               ; $00E2C8 MOVE.W  D6,(A0)
        DC.W    $5588               ; $00E2CA SUBQ.L  #2,A0
        DC.W    $343C,$0003         ; $00E2CC MOVE.W  #$0003,D2
        DC.W    $3A03               ; $00E2D0 MOVE.W  D3,D5
        DC.W    $5745               ; $00E2D2 SUBQ.W  #3,D5
loc_00E2D4:
        DC.W    $4EBA,$000E         ; $00E2D4 JSR     loc_00E2E4(PC)
        DC.W    $3086               ; $00E2D8 MOVE.W  D6,(A0)
        DC.W    $5588               ; $00E2DA SUBQ.L  #2,A0
        DC.W    $51CD,$FFF6         ; $00E2DC DBRA    D5,loc_00E2D4
        DC.W    $2049               ; $00E2E0 MOVEA.L A1,A0
        DC.W    $4E75               ; $00E2E2 RTS
loc_00E2E4:
        DC.W    $3C02               ; $00E2E4 MOVE.W  D2,D6
        DC.W    $DC40               ; $00E2E6 ADD.W  D0,D6
        DC.W    $DC41               ; $00E2E8 ADD.W  D1,D6
        DC.W    $0841,$0000         ; $00E2EA BCHG    #0,D1
        DC.W    $4E75               ; $00E2EE RTS
loc_00E2F0:
        DC.W    $2ABC,$6000,$0002   ; $00E2F0 MOVE.L  #$60000002,(A5)
        DC.W    $701B               ; $00E2F6 MOVEQ   #$1B,D0
loc_00E2F8:
        DC.W    $323C,$001F         ; $00E2F8 MOVE.W  #$001F,D1
loc_00E2FC:
        DC.W    $2C98               ; $00E2FC MOVE.L  (A0)+,(A6)
        DC.W    $51C9,$FFFC         ; $00E2FE DBRA    D1,loc_00E2FC
        DC.W    $323C,$001F         ; $00E302 MOVE.W  #$001F,D1
loc_00E306:
        DC.W    $2CBC,$0000,$0000   ; $00E306 MOVE.L  #$00000000,(A6)
        DC.W    $51C9,$FFF8         ; $00E30C DBRA    D1,loc_00E306
        DC.W    $51C8,$FFE6         ; $00E310 DBRA    D0,loc_00E2F8
        DC.W    $4E75               ; $00E314 RTS
loc_00E316:
        DC.W    $4A39,$00A1,$5120   ; $00E316 TST.B  $00A15120
        DC.W    $66F8               ; $00E31C BNE.S  loc_00E316
        DC.W    $D1FC,$0200,$0000   ; $00E31E ADDA.L  #$02000000,A0
        DC.W    $23C8,$00A1,$5128   ; $00E324 MOVE.L  A0,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $00E32A MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0025,$00A1,$5121; $00E332 MOVE.B  #$0025,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E33A MOVE.B  #$0001,$00A15120
loc_00E342:
        DC.W    $4A39,$00A1,$512C   ; $00E342 TST.B  $00A1512C
        DC.W    $66F8               ; $00E348 BNE.S  loc_00E342
        DC.W    $23C9,$00A1,$5128   ; $00E34A MOVE.L  A1,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $00E350 MOVE.W  #$0101,$00A1512C
        DC.W    $4E75               ; $00E358 RTS
loc_00E35A:
        DC.W    $4A39,$00A1,$5120   ; $00E35A TST.B  $00A15120
        DC.W    $66F8               ; $00E360 BNE.S  loc_00E35A
        DC.W    $23C9,$00A1,$5128   ; $00E362 MOVE.L  A1,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $00E368 MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0022,$00A1,$5121; $00E370 MOVE.B  #$0022,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E378 MOVE.B  #$0001,$00A15120
loc_00E380:
        DC.W    $4A39,$00A1,$512C   ; $00E380 TST.B  $00A1512C
        DC.W    $66F8               ; $00E386 BNE.S  loc_00E380
        DC.W    $33C0,$00A1,$5128   ; $00E388 MOVE.W  D0,$00A15128
        DC.W    $33C1,$00A1,$512A   ; $00E38E MOVE.W  D1,$00A1512A
        DC.W    $33FC,$0101,$00A1,$512C; $00E394 MOVE.W  #$0101,$00A1512C
loc_00E39C:
        DC.W    $4A39,$00A1,$512C   ; $00E39C TST.B  $00A1512C
        DC.W    $66F8               ; $00E3A2 BNE.S  loc_00E39C
        DC.W    $23C8,$00A1,$5128   ; $00E3A4 MOVE.L  A0,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $00E3AA MOVE.W  #$0101,$00A1512C
        DC.W    $4E75               ; $00E3B2 RTS
loc_00E3B4:
        DC.W    $23C8,$00A1,$5128   ; $00E3B4 MOVE.L  A0,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $00E3BA MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0027,$00A1,$5121; $00E3C2 MOVE.B  #$0027,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E3CA MOVE.B  #$0001,$00A15120
loc_00E3D2:
        DC.W    $4A39,$00A1,$512C   ; $00E3D2 TST.B  $00A1512C
        DC.W    $66F8               ; $00E3D8 BNE.S  loc_00E3D2
        DC.W    $33C0,$00A1,$5128   ; $00E3DA MOVE.W  D0,$00A15128
        DC.W    $33C1,$00A1,$512A   ; $00E3E0 MOVE.W  D1,$00A1512A
        DC.W    $33FC,$0101,$00A1,$512C; $00E3E6 MOVE.W  #$0101,$00A1512C
loc_00E3EE:
        DC.W    $4A39,$00A1,$512C   ; $00E3EE TST.B  $00A1512C
        DC.W    $66F8               ; $00E3F4 BNE.S  loc_00E3EE
        DC.W    $33C2,$00A1,$5128   ; $00E3F6 MOVE.W  D2,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $00E3FC MOVE.W  #$0101,$00A1512C
        DC.W    $4E75               ; $00E404 RTS
loc_00E406:
        DC.W    $4A39,$00A1,$5120   ; $00E406 TST.B  $00A15120
        DC.W    $66F8               ; $00E40C BNE.S  loc_00E406
        DC.W    $23C8,$00A1,$5128   ; $00E40E MOVE.L  A0,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $00E414 MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$002F,$00A1,$5121; $00E41C MOVE.B  #$002F,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E424 MOVE.B  #$0001,$00A15120
loc_00E42C:
        DC.W    $4A39,$00A1,$512C   ; $00E42C TST.B  $00A1512C
        DC.W    $66F8               ; $00E432 BNE.S  loc_00E42C
        DC.W    $33C0,$00A1,$5128   ; $00E434 MOVE.W  D0,$00A15128
        DC.W    $33C1,$00A1,$512A   ; $00E43A MOVE.W  D1,$00A1512A
        DC.W    $33FC,$0101,$00A1,$512C; $00E440 MOVE.W  #$0101,$00A1512C
loc_00E448:
        DC.W    $4A39,$00A1,$512C   ; $00E448 TST.B  $00A1512C
        DC.W    $66F8               ; $00E44E BNE.S  loc_00E448
        DC.W    $33C2,$00A1,$5128   ; $00E450 MOVE.W  D2,$00A15128
        DC.W    $33C3,$00A1,$512A   ; $00E456 MOVE.W  D3,$00A1512A
        DC.W    $33FC,$0101,$00A1,$512C; $00E45C MOVE.W  #$0101,$00A1512C
        DC.W    $4E75               ; $00E464 RTS
        DC.W    $121A               ; $00E466 MOVE.B  (A2)+,D1
        DC.W    $0241,$000F         ; $00E468 ANDI.W  #$000F,D1
        DC.W    $6100,$004E         ; $00E46C BSR.W  loc_00E4BC
        DC.W    $5089               ; $00E470 ADDQ.L  #8,A1
        DC.W    $323C,$000A         ; $00E472 MOVE.W  #$000A,D1
        DC.W    $6100,$0044         ; $00E476 BSR.W  loc_00E4BC
        DC.W    $5089               ; $00E47A ADDQ.L  #8,A1
        DC.W    $141A               ; $00E47C MOVE.B  (A2)+,D2
        DC.W    $6100,$0020         ; $00E47E BSR.W  loc_00E4A0
        DC.W    $323C,$000B         ; $00E482 MOVE.W  #$000B,D1
        DC.W    $6100,$0034         ; $00E486 BSR.W  loc_00E4BC
        DC.W    $5089               ; $00E48A ADDQ.L  #8,A1
        DC.W    $121A               ; $00E48C MOVE.B  (A2)+,D1
        DC.W    $0241,$000F         ; $00E48E ANDI.W  #$000F,D1
        DC.W    $6100,$0028         ; $00E492 BSR.W  loc_00E4BC
        DC.W    $5089               ; $00E496 ADDQ.L  #8,A1
        DC.W    $141A               ; $00E498 MOVE.B  (A2)+,D2
        DC.W    $6100,$0004         ; $00E49A BSR.W  loc_00E4A0
        DC.W    $4E75               ; $00E49E RTS
loc_00E4A0:
        DC.W    $1202               ; $00E4A0 MOVE.B  D2,D1
        DC.W    $E809               ; $00E4A2 LSR.B  #4,D1
        DC.W    $0241,$000F         ; $00E4A4 ANDI.W  #$000F,D1
        DC.W    $6100,$0012         ; $00E4A8 BSR.W  loc_00E4BC
        DC.W    $5089               ; $00E4AC ADDQ.L  #8,A1
        DC.W    $3202               ; $00E4AE MOVE.W  D2,D1
        DC.W    $0241,$000F         ; $00E4B0 ANDI.W  #$000F,D1
        DC.W    $6100,$0006         ; $00E4B4 BSR.W  loc_00E4BC
        DC.W    $5089               ; $00E4B8 ADDQ.L  #8,A1
        DC.W    $4E75               ; $00E4BA RTS
loc_00E4BC:
        DC.W    $ED49               ; $00E4BC LSL.W  #6,D1
        DC.W    $3001               ; $00E4BE MOVE.W  D1,D0
        DC.W    $E349               ; $00E4C0 LSL.W  #1,D1
        DC.W    $D240               ; $00E4C2 ADD.W  D0,D1
        DC.W    $207C,$0603,$DA00   ; $00E4C4 MOVEA.L #$0603DA00,A0
        DC.W    $D0C1               ; $00E4CA ADDA.W  D1,A0
        DC.W    $303C,$000C         ; $00E4CC MOVE.W  #$000C,D0
        DC.W    $323C,$0010         ; $00E4D0 MOVE.W  #$0010,D1
        DC.W    $4EBA,$FE84         ; $00E4D4 JSR     loc_00E35A(PC)
        DC.W    $4E75               ; $00E4D8 RTS
        DC.W    $23C9,$00A1,$5128   ; $00E4DA MOVE.L  A1,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $00E4E0 MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0021,$00A1,$5121; $00E4E8 MOVE.B  #$0021,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E4F0 MOVE.B  #$0001,$00A15120
loc_00E4F8:
        DC.W    $4A39,$00A1,$512C   ; $00E4F8 TST.B  $00A1512C
        DC.W    $66F8               ; $00E4FE BNE.S  loc_00E4F8
        DC.W    $33C0,$00A1,$5128   ; $00E500 MOVE.W  D0,$00A15128
        DC.W    $33C1,$00A1,$512A   ; $00E506 MOVE.W  D1,$00A1512A
        DC.W    $33FC,$0101,$00A1,$512C; $00E50C MOVE.W  #$0101,$00A1512C
loc_00E514:
        DC.W    $4A39,$00A1,$512C   ; $00E514 TST.B  $00A1512C
        DC.W    $66F8               ; $00E51A BNE.S  loc_00E514
        DC.W    $23C8,$00A1,$5128   ; $00E51C MOVE.L  A0,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $00E522 MOVE.W  #$0101,$00A1512C
        DC.W    $4E75               ; $00E52A RTS
loc_00E52C:
        DC.W    $41F8,$84A2         ; $00E52C LEA     $84A2.W,A0
        DC.W    $43F8,$84C2         ; $00E530 LEA     $84C2.W,A1
        DC.W    $45F8,$84E2         ; $00E534 LEA     $84E2.W,A2
        DC.W    $4242               ; $00E538 CLR.W  D2
        DC.W    $323C,$0007         ; $00E53A MOVE.W  #$0007,D1
loc_00E53E:
        DC.W    $31BC,$0000,$2000   ; $00E53E MOVE.W  #$0000,$00(A0,D2.W)
        DC.W    $33BC,$0000,$2000   ; $00E544 MOVE.W  #$0000,$00(A1,D2.W)
        DC.W    $35BC,$0000,$2000   ; $00E54A MOVE.W  #$0000,$00(A2,D2.W)
        DC.W    $5442               ; $00E550 ADDQ.W  #2,D2
        DC.W    $51C9,$FFEA         ; $00E552 DBRA    D1,loc_00E53E
        DC.W    $4A40               ; $00E556 TST.W  D0
        DC.W    $6608               ; $00E558 BNE.S  loc_00E562
        DC.W    $41F8,$84A2         ; $00E55A LEA     $84A2.W,A0
        DC.W    $6000,$0016         ; $00E55E BRA.W  loc_00E576
loc_00E562:
        DC.W    $0C40,$0001         ; $00E562 CMPI.W  #$0001,D0
        DC.W    $6600,$000A         ; $00E566 BNE.W  loc_00E572
        DC.W    $41F8,$84C2         ; $00E56A LEA     $84C2.W,A0
        DC.W    $6000,$0006         ; $00E56E BRA.W  loc_00E576
loc_00E572:
        DC.W    $41F8,$84E2         ; $00E572 LEA     $84E2.W,A0
loc_00E576:
        DC.W    $47F9,$0088,$E5AC   ; $00E576 LEA     $0088E5AC,A3
        DC.W    $7200               ; $00E57C MOVEQ   #$00,D1
        DC.W    $3238,$A012         ; $00E57E MOVE.W  $A012.W,D1
        DC.W    $D241               ; $00E582 ADD.W  D1,D1
        DC.W    $D7C1               ; $00E584 ADDA.L  D1,A3
        DC.W    $4242               ; $00E586 CLR.W  D2
        DC.W    $323C,$0007         ; $00E588 MOVE.W  #$0007,D1
loc_00E58C:
        DC.W    $319B,$2000         ; $00E58C MOVE.W  (A3)+,$00(A0,D2.W)
        DC.W    $5442               ; $00E590 ADDQ.W  #2,D2
        DC.W    $51C9,$FFF8         ; $00E592 DBRA    D1,loc_00E58C
        DC.W    $3238,$A012         ; $00E596 MOVE.W  $A012.W,D1
        DC.W    $5241               ; $00E59A ADDQ.W  #1,D1
        DC.W    $0C41,$0007         ; $00E59C CMPI.W  #$0007,D1
        DC.W    $6F00,$0004         ; $00E5A0 BLE.W  loc_00E5A6
        DC.W    $4241               ; $00E5A4 CLR.W  D1
loc_00E5A6:
        DC.W    $31C1,$A012         ; $00E5A6 MOVE.W  D1,$A012.W
        DC.W    $4E75               ; $00E5AA RTS
        DC.W    $0EEE               ; $00E5AC DC.W    $0EEE
        DC.W    $0EEE               ; $00E5AE DC.W    $0EEE
        DC.W    $0EEE               ; $00E5B0 DC.W    $0EEE
        DC.W    $0EEE               ; $00E5B2 DC.W    $0EEE
        DC.W    $0000,$0000         ; $00E5B4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00E5B8 ORI.B  #$0000,D0
        DC.W    $0EEE               ; $00E5BC DC.W    $0EEE
        DC.W    $0EEE               ; $00E5BE DC.W    $0EEE
        DC.W    $0EEE               ; $00E5C0 DC.W    $0EEE
        DC.W    $0EEE               ; $00E5C2 DC.W    $0EEE
        DC.W    $0000,$0000         ; $00E5C4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00E5C8 ORI.B  #$0000,D0
        DC.W    $4E75               ; $00E5CC RTS
        DC.W    $4238,$A01F         ; $00E5CE CLR.B  $A01F.W
        DC.W    $11F8,$FEA9,$A01D   ; $00E5D2 MOVE.B  $FEA9.W,$A01D.W
        DC.W    $11F8,$FEB1,$A019   ; $00E5D8 MOVE.B  $FEB1.W,$A019.W
        DC.W    $08B8,$0007,$FDA8   ; $00E5DE BCLR    #7,$FDA8.W
        DC.W    $6030               ; $00E5E4 BRA.S  loc_00E616
        DC.W    $4238,$A01F         ; $00E5E6 CLR.B  $A01F.W
        DC.W    $11F8,$FEA9,$A01D   ; $00E5EA MOVE.B  $FEA9.W,$A01D.W
        DC.W    $11F8,$FEB1,$A019   ; $00E5F0 MOVE.B  $FEB1.W,$A019.W
        DC.W    $08F8,$0007,$FDA8   ; $00E5F6 BSET    #7,$FDA8.W
        DC.W    $6018               ; $00E5FC BRA.S  loc_00E616
        DC.W    $11FC,$0001,$A01F   ; $00E5FE MOVE.B  #$0001,$A01F.W
        DC.W    $11F8,$FEAA,$A01D   ; $00E604 MOVE.B  $FEAA.W,$A01D.W
        DC.W    $08B8,$0007,$FDA8   ; $00E60A BCLR    #7,$FDA8.W
        DC.W    $11F8,$FEB2,$A019   ; $00E610 MOVE.B  $FEB2.W,$A019.W
loc_00E616:
        DC.W    $33FC,$002C,$00FF,$0008; $00E616 MOVE.W  #$002C,$00FF0008
        DC.W    $31FC,$002C,$C87A   ; $00E61E MOVE.W  #$002C,$C87A.W
        DC.W    $08B8,$0006,$C875   ; $00E624 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00E62A MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $00E62E MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $00E636 ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$26C8   ; $00E63E JSR     $008826C8
        DC.W    $203C,$000A,$0907   ; $00E644 MOVE.L  #$000A0907,D0
        DC.W    $4EB9,$0088,$14BE   ; $00E64A JSR     $008814BE
        DC.W    $11FC,$0001,$C80D   ; $00E650 MOVE.B  #$0001,$C80D.W
        DC.W    $7000               ; $00E656 MOVEQ   #$00,D0
        DC.W    $41F8,$8480         ; $00E658 LEA     $8480.W,A0
        DC.W    $721F               ; $00E65C MOVEQ   #$1F,D1
loc_00E65E:
        DC.W    $20C0               ; $00E65E MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $00E660 DBRA    D1,loc_00E65E
        DC.W    $41F9,$00FF,$7B80   ; $00E664 LEA     $00FF7B80,A0
        DC.W    $727F               ; $00E66A MOVEQ   #$7F,D1
loc_00E66C:
        DC.W    $20C0               ; $00E66C MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $00E66E DBRA    D1,loc_00E66C
        DC.W    $2ABC,$6000,$0002   ; $00E672 MOVE.L  #$60000002,(A5)
        DC.W    $323C,$17FF         ; $00E678 MOVE.W  #$17FF,D1
loc_00E67C:
        DC.W    $2C80               ; $00E67C MOVE.L  D0,(A6)
        DC.W    $51C9,$FFFC         ; $00E67E DBRA    D1,loc_00E67C
        DC.W    $4EB9,$0088,$49AA   ; $00E682 JSR     $008849AA
        DC.W    $4278,$C880         ; $00E688 CLR.W  $C880.W
        DC.W    $4278,$C882         ; $00E68C CLR.W  $C882.W
        DC.W    $4278,$8000         ; $00E690 CLR.W  $8000.W
        DC.W    $4278,$8002         ; $00E694 CLR.W  $8002.W
        DC.W    $4278,$A012         ; $00E698 CLR.W  $A012.W
        DC.W    $4238,$A018         ; $00E69C CLR.B  $A018.W
        DC.W    $4EB9,$0088,$49AA   ; $00E6A0 JSR     $008849AA
        DC.W    $21FC,$008B,$B4FC,$C96C; $00E6A6 MOVE.L  #$008BB4FC,$C96C.W
        DC.W    $11FC,$0001,$C809   ; $00E6AE MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00E6B4 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $00E6BA BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00E6C0 MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0001,$A020   ; $00E6C6 MOVE.W  #$0001,$A020.W
        DC.W    $41F9,$00FF,$1000   ; $00E6CC LEA     $00FF1000,A0
        DC.W    $303C,$037F         ; $00E6D2 MOVE.W  #$037F,D0
loc_00E6D6:
        DC.W    $4298               ; $00E6D6 CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $00E6D8 DBRA    D0,loc_00E6D6
        DC.W    $303C,$0001         ; $00E6DC MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $00E6E0 MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $00E6E4 MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $00E6E8 MOVE.W  #$0026,D3
        DC.W    $383C,$0014         ; $00E6EC MOVE.W  #$0014,D4
        DC.W    $41F9,$00FF,$1000   ; $00E6F0 LEA     $00FF1000,A0
        DC.W    $4EBA,$FB34         ; $00E6F6 JSR     loc_00E22C(PC)
        DC.W    $303C,$0002         ; $00E6FA MOVE.W  #$0002,D0
        DC.W    $323C,$0001         ; $00E6FE MOVE.W  #$0001,D1
        DC.W    $343C,$0016         ; $00E702 MOVE.W  #$0016,D2
        DC.W    $363C,$0026         ; $00E706 MOVE.W  #$0026,D3
        DC.W    $383C,$0005         ; $00E70A MOVE.W  #$0005,D4
        DC.W    $41F9,$00FF,$1000   ; $00E70E LEA     $00FF1000,A0
        DC.W    $4EBA,$FB16         ; $00E714 JSR     loc_00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $00E718 LEA     $00FF1000,A0
        DC.W    $4EBA,$FBD0         ; $00E71E JSR     loc_00E2F0(PC)
        DC.W    $4EBA,$FA98         ; $00E722 JSR     $00E1BC(PC)
        DC.W    $08B9,$0007,$00A1,$5181; $00E726 BCLR    #7,$00A15181
        DC.W    $41F9,$00FF,$6E00   ; $00E72E LEA     $00FF6E00,A0
        DC.W    $43F9,$008B,$A220   ; $00E734 LEA     $008BA220,A1
        DC.W    $2251               ; $00E73A MOVEA.L (A1),A1
        DC.W    $303C,$007F         ; $00E73C MOVE.W  #$007F,D0
loc_00E740:
        DC.W    $30D9               ; $00E740 MOVE.W  (A1)+,(A0)+
        DC.W    $51C8,$FFFC         ; $00E742 DBRA    D0,loc_00E740
        DC.W    $41F9,$00FF,$6E00   ; $00E746 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0160   ; $00E74C ADDA.L  #$00000160,A0
        DC.W    $43F9,$0088,$E88C   ; $00E752 LEA     $0088E88C,A1
        DC.W    $303C,$003F         ; $00E758 MOVE.W  #$003F,D0
loc_00E75C:
        DC.W    $3219               ; $00E75C MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $00E75E BSET    #15,D1
        DC.W    $30C1               ; $00E762 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $00E764 DBRA    D0,loc_00E75C
        DC.W    $41F9,$000E,$9680   ; $00E768 LEA     $000E9680,A0
        DC.W    $227C,$0603,$8000   ; $00E76E MOVEA.L #$06038000,A1
        DC.W    $4EBA,$FBA0         ; $00E774 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$9450   ; $00E778 LEA     $000E9450,A0
        DC.W    $227C,$0603,$B600   ; $00E77E MOVEA.L #$0603B600,A1
        DC.W    $4EBA,$FB90         ; $00E784 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$90A0   ; $00E788 LEA     $000E90A0,A0
        DC.W    $227C,$0603,$D100   ; $00E78E MOVEA.L #$0603D100,A1
        DC.W    $4EBA,$FB80         ; $00E794 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$9240   ; $00E798 LEA     $000E9240,A0
        DC.W    $227C,$0603,$D800   ; $00E79E MOVEA.L #$0603D800,A1
        DC.W    $4EBA,$FB70         ; $00E7A4 JSR     loc_00E316(PC)
        DC.W    $11F8,$A019,$A01E   ; $00E7A8 MOVE.B  $A019.W,$A01E.W
        DC.W    $4238,$A01A         ; $00E7AE CLR.B  $A01A.W
        DC.W    $33FC,$0080,$00FF,$2000; $00E7B2 MOVE.W  #$0080,$00FF2000
        DC.W    $33FC,$FF80,$00FF,$2002; $00E7BA MOVE.W  #$FF80,$00FF2002
        DC.W    $33FC,$003C,$00FF,$2004; $00E7C2 MOVE.W  #$003C,$00FF2004
        DC.W    $33FC,$00BC,$00FF,$2006; $00E7CA MOVE.W  #$00BC,$00FF2006
        DC.W    $33FC,$FF60,$00FF,$2008; $00E7D2 MOVE.W  #$FF60,$00FF2008
        DC.W    $33FC,$0044,$00FF,$200A; $00E7DA MOVE.W  #$0044,$00FF200A
        DC.W    $33FC,$0080,$00FF,$200C; $00E7E2 MOVE.W  #$0080,$00FF200C
        DC.W    $33FC,$FF80,$00FF,$200E; $00E7EA MOVE.W  #$FF80,$00FF200E
        DC.W    $33FC,$003C,$00FF,$2010; $00E7F2 MOVE.W  #$003C,$00FF2010
        DC.W    $4EB9,$0088,$204A   ; $00E7FA JSR     $0088204A
        DC.W    $0239,$00FC,$00A1,$5181; $00E800 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $00E808 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $00E810 MOVE.W  #$8083,$00A15100
        DC.W    $08F8,$0006,$C875   ; $00E818 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00E81E MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0020,$00FF,$0008; $00E822 MOVE.W  #$0020,$00FF0008
        DC.W    $4EB9,$0088,$4998   ; $00E82A JSR     $00884998
        DC.W    $31FC,$0000,$C87E   ; $00E830 MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0088,$E90C,$00FF,$0002; $00E836 MOVE.L  #$0088E90C,$00FF0002
        DC.W    $11FC,$0081,$C8A5   ; $00E840 MOVE.B  #$0081,$C8A5.W
        DC.W    $13FC,$0000,$00FF,$60D4; $00E846 MOVE.B  #$0000,$00FF60D4
        DC.W    $41F9,$00FF,$6100   ; $00E84E LEA     $00FF6100,A0
        DC.W    $303C,$007F         ; $00E854 MOVE.W  #$007F,D0
loc_00E858:
        DC.W    $4298               ; $00E858 CLR.L  (A0)+
        DC.W    $4298               ; $00E85A CLR.L  (A0)+
        DC.W    $4298               ; $00E85C CLR.L  (A0)+
        DC.W    $4298               ; $00E85E CLR.L  (A0)+
        DC.W    $4298               ; $00E860 CLR.L  (A0)+
        DC.W    $51C8,$FFF4         ; $00E862 DBRA    D0,loc_00E858
loc_00E866:
        DC.W    $4A39,$00A1,$5120   ; $00E866 TST.B  $00A15120
        DC.W    $66F8               ; $00E86C BNE.S  loc_00E866
        DC.W    $4239,$00A1,$5122   ; $00E86E CLR.B  $00A15122
        DC.W    $4239,$00A1,$5123   ; $00E874 CLR.B  $00A15123
        DC.W    $13FC,$0003,$00A1,$5121; $00E87A MOVE.B  #$0003,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E882 MOVE.B  #$0001,$00A15120
        DC.W    $4E75               ; $00E88A RTS
        DC.W    $4400               ; $00E88C NEG.B  D0
        DC.W    $44A3               ; $00E88E NEG.L  -(A3)
        DC.W    $4946               ; $00E890 DC.W    $4946
        DC.W    $4DE9,$1C00         ; $00E892 LEA     $1C00(A1),A6
        DC.W    $28A3               ; $00E896 MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $00E898 MOVE.W  D6,$41E9(A2)
        DC.W    $7FFF               ; $00E89C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E89E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $1C00               ; $00E8A4 MOVE.B  D0,D6
        DC.W    $28A3               ; $00E8A6 MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $00E8A8 MOVE.W  D6,$41E9(A2)
        DC.W    $4400               ; $00E8AC NEG.B  D0
        DC.W    $44A3               ; $00E8AE NEG.L  -(A3)
        DC.W    $4946               ; $00E8B0 DC.W    $4946
        DC.W    $4DE9,$7FFF         ; $00E8B2 LEA     $7FFF(A1),A6
        DC.W    $63F5               ; $00E8B6 BLS.S  loc_00E8AD
        DC.W    $7FFF               ; $00E8B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $00E8BC ORI.B  #$14AF,(A0)
        DC.W    $294E,$3DED         ; $00E8C0 MOVE.L  A6,$3DED(A4)
        DC.W    $7FFF               ; $00E8C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $77BA,$7BBC,$779A   ; $00E8CC MOVE.W  $7BBC(PC),-$66(A3,D7.W)
        DC.W    $77BC,$6B36,$6B37   ; $00E8D2 MOVE.W  #$6B36,$37(A3,D6.L)
        DC.W    $6F58               ; $00E8D8 BLE.S  loc_00E932
        DC.W    $6F79               ; $00E8DA BLE.S  loc_00E955
        DC.W    $739A,$61E8         ; $00E8DC MOVE.W  (A2)+,-$18(A1,D6.W)
        DC.W    $7FFF               ; $00E8E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FBC,$7F7A,$7FDE   ; $00E8EC MOVE.W  #$7F7A,-$22(A7,D7.L)
        DC.W    $7F9B,$4445         ; $00E8F2 MOVE.W  (A3)+,$45(A7,D4.W)
        DC.W    $512B,$6212         ; $00E8F6 SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $00E8FA BGT.S  loc_00E8F4
        DC.W    $7FFF               ; $00E8FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $031F               ; $00E8FE BTST    D1,(A7)+
        DC.W    $7FFF               ; $00E900 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E902 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E904 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E906 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E908 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E90A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $4EB9,$0088,$2080   ; $00E90C JSR     $00882080
        DC.W    $3038,$C87E         ; $00E912 MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $00E916 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00E91A JMP     (A1)
        DC.W    $0088,$E93A,$0088   ; $00E91C ORI.L  #$E93A0088,A0
        DC.W    $EDDA               ; $00E922 ROXL.W  (A2)+
        DC.W    $0088,$EEF2,$4EBA   ; $00E924 ORI.L  #$EEF24EBA,A0
        DC.W    $CD5A               ; $00E92A AND.W  D6,(A2)+
        DC.W    $0838,$0006,$C80E   ; $00E92C BTST    #6,$C80E.W
loc_00E932:
        DC.W    $6604               ; $00E932 BNE.S  loc_00E938
        DC.W    $5878,$C87E         ; $00E934 ADDQ.W  #4,$C87E.W
loc_00E938:
        DC.W    $4E75               ; $00E938 RTS
        DC.W    $207C,$0603,$8000   ; $00E93A MOVEA.L #$06038000,A0
        DC.W    $227C,$0401,$2010   ; $00E940 MOVEA.L #$04012010,A1
        DC.W    $303C,$0120         ; $00E946 MOVE.W  #$0120,D0
        DC.W    $323C,$0030         ; $00E94A MOVE.W  #$0030,D1
        DC.W    $4EBA,$FA0A         ; $00E94E JSR     loc_00E35A(PC)
        DC.W    $207C,$0603,$B600   ; $00E952 MOVEA.L #$0603B600,A0
        DC.W    $227C,$0401,$B010   ; $00E958 MOVEA.L #$0401B010,A1
        DC.W    $303C,$0120         ; $00E95E MOVE.W  #$0120,D0
        DC.W    $323C,$0018         ; $00E962 MOVE.W  #$0018,D1
        DC.W    $4EBA,$F9F2         ; $00E966 JSR     loc_00E35A(PC)
        DC.W    $7000               ; $00E96A MOVEQ   #$00,D0
        DC.W    $4A38,$A01A         ; $00E96C TST.B  $A01A.W
        DC.W    $6606               ; $00E970 BNE.S  loc_00E978
        DC.W    $1038,$A019         ; $00E972 MOVE.B  $A019.W,D0
        DC.W    $6004               ; $00E976 BRA.S  loc_00E97C
loc_00E978:
        DC.W    $1038,$A01E         ; $00E978 MOVE.B  $A01E.W,D0
loc_00E97C:
        DC.W    $3200               ; $00E97C MOVE.W  D0,D1
        DC.W    $D241               ; $00E97E ADD.W  D1,D1
        DC.W    $D241               ; $00E980 ADD.W  D1,D1
        DC.W    $41F9,$00FF,$6E00   ; $00E982 LEA     $00FF6E00,A0
        DC.W    $43F9,$0088,$EACE   ; $00E988 LEA     $0088EACE,A1
        DC.W    $2271,$1000         ; $00E98E MOVEA.L $00(A1,D1.W),A1
        DC.W    $323C,$007F         ; $00E992 MOVE.W  #$007F,D1
loc_00E996:
        DC.W    $30D9               ; $00E996 MOVE.W  (A1)+,(A0)+
        DC.W    $51C9,$FFFC         ; $00E998 DBRA    D1,loc_00E996
        DC.W    $41F9,$0088,$EAC2   ; $00E99C LEA     $0088EAC2,A0
        DC.W    $D040               ; $00E9A2 ADD.W  D0,D0
        DC.W    $D040               ; $00E9A4 ADD.W  D0,D0
        DC.W    $2070,$0000         ; $00E9A6 MOVEA.L $00(A0,D0.W),A0
        DC.W    $2038,$A014         ; $00E9AA MOVE.L  $A014.W,D0
        DC.W    $4E90               ; $00E9AE JSR     (A0)
loc_00E9B0:
        DC.W    $0839,$0001,$00A1,$5123; $00E9B0 BTST    #1,$00A15123
        DC.W    $67F6               ; $00E9B8 BEQ.S  loc_00E9B0
        DC.W    $08B9,$0001,$00A1,$5123; $00E9BA BCLR    #1,$00A15123
        DC.W    $43F9,$00FF,$60C8   ; $00E9C2 LEA     $00FF60C8,A1
        DC.W    $45F9,$00A1,$5112   ; $00E9C8 LEA     $00A15112,A2
        DC.W    $3E3C,$0043         ; $00E9CE MOVE.W  #$0043,D7
loc_00E9D2:
        DC.W    $0839,$0007,$00A1,$5107; $00E9D2 BTST    #7,$00A15107
        DC.W    $66F6               ; $00E9DA BNE.S  loc_00E9D2
        DC.W    $3499               ; $00E9DC MOVE.W  (A1)+,(A2)
        DC.W    $51CF,$FFF2         ; $00E9DE DBRA    D7,loc_00E9D2
        DC.W    $2038,$A014         ; $00E9E2 MOVE.L  $A014.W,D0
        DC.W    $0680,$0000,$0080   ; $00E9E6 ADDI.L  #$00000080,D0
        DC.W    $0280,$0000,$FFFF   ; $00E9EC ANDI.L  #$0000FFFF,D0
        DC.W    $21C0,$A014         ; $00E9F2 MOVE.L  D0,$A014.W
        DC.W    $4240               ; $00E9F6 CLR.W  D0
        DC.W    $1038,$A01A         ; $00E9F8 MOVE.B  $A01A.W,D0
        DC.W    $6100,$FB2E         ; $00E9FC BSR.W  loc_00E52C
        DC.W    $4EB9,$0088,$179E   ; $00EA00 JSR     $0088179E
        DC.W    $4A78,$A020         ; $00EA06 TST.W  $A020.W
        DC.W    $6600,$00A8         ; $00EA0A BNE.W  loc_00EAB4
        DC.W    $1038,$A019         ; $00EA0E MOVE.B  $A019.W,D0
        DC.W    $3238,$C86C         ; $00EA12 MOVE.W  $C86C.W,D1
        DC.W    $0801,$0003         ; $00EA16 BTST    #3,D1
        DC.W    $6726               ; $00EA1A BEQ.S  loc_00EA42
        DC.W    $11FC,$00A9,$C8A4   ; $00EA1C MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A38,$A01A         ; $00EA22 TST.B  $A01A.W
        DC.W    $6700,$000C         ; $00EA26 BEQ.W  loc_00EA34
        DC.W    $0C00,$0001         ; $00EA2A CMPI.B  #$0001,D0
        DC.W    $6C0E               ; $00EA2E BGE.S  loc_00EA3E
        DC.W    $6000,$0008         ; $00EA30 BRA.W  loc_00EA3A
loc_00EA34:
        DC.W    $0C00,$0002         ; $00EA34 CMPI.B  #$0002,D0
        DC.W    $6C04               ; $00EA38 BGE.S  loc_00EA3E
loc_00EA3A:
        DC.W    $5200               ; $00EA3A ADDQ.B  #1,D0
        DC.W    $6072               ; $00EA3C BRA.S  loc_00EAB0
loc_00EA3E:
        DC.W    $4200               ; $00EA3E CLR.B  D0
        DC.W    $606E               ; $00EA40 BRA.S  loc_00EAB0
loc_00EA42:
        DC.W    $0801,$0002         ; $00EA42 BTST    #2,D1
        DC.W    $6722               ; $00EA46 BEQ.S  loc_00EA6A
        DC.W    $11FC,$00A9,$C8A4   ; $00EA48 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A00               ; $00EA4E TST.B  D0
        DC.W    $6F04               ; $00EA50 BLE.S  loc_00EA56
        DC.W    $5300               ; $00EA52 SUBQ.B  #1,D0
        DC.W    $605A               ; $00EA54 BRA.S  loc_00EAB0
loc_00EA56:
        DC.W    $4A38,$A01A         ; $00EA56 TST.B  $A01A.W
        DC.W    $6700,$0008         ; $00EA5A BEQ.W  loc_00EA64
        DC.W    $103C,$0001         ; $00EA5E MOVE.B  #$0001,D0
        DC.W    $604C               ; $00EA62 BRA.S  loc_00EAB0
loc_00EA64:
        DC.W    $103C,$0002         ; $00EA64 MOVE.B  #$0002,D0
        DC.W    $6046               ; $00EA68 BRA.S  loc_00EAB0
loc_00EA6A:
        DC.W    $0801,$0000         ; $00EA6A BTST    #0,D1
        DC.W    $6700,$001C         ; $00EA6E BEQ.W  loc_00EA8C
        DC.W    $4A38,$A01A         ; $00EA72 TST.B  $A01A.W
        DC.W    $6738               ; $00EA76 BEQ.S  loc_00EAB0
        DC.W    $11FC,$00A9,$C8A4   ; $00EA78 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4238,$A01A         ; $00EA7E CLR.B  $A01A.W
        DC.W    $11C0,$A01D         ; $00EA82 MOVE.B  D0,$A01D.W
        DC.W    $1038,$A01E         ; $00EA86 MOVE.B  $A01E.W,D0
        DC.W    $6024               ; $00EA8A BRA.S  loc_00EAB0
loc_00EA8C:
        DC.W    $0801,$0001         ; $00EA8C BTST    #1,D1
        DC.W    $6700,$001E         ; $00EA90 BEQ.W  loc_00EAB0
        DC.W    $0C38,$0001,$A01A   ; $00EA94 CMPI.B  #$0001,$A01A.W
        DC.W    $6C14               ; $00EA9A BGE.S  loc_00EAB0
        DC.W    $11FC,$00A9,$C8A4   ; $00EA9C MOVE.B  #$00A9,$C8A4.W
        DC.W    $11FC,$0001,$A01A   ; $00EAA2 MOVE.B  #$0001,$A01A.W
        DC.W    $11C0,$A01E         ; $00EAA8 MOVE.B  D0,$A01E.W
        DC.W    $1038,$A01D         ; $00EAAC MOVE.B  $A01D.W,D0
loc_00EAB0:
        DC.W    $11C0,$A019         ; $00EAB0 MOVE.B  D0,$A019.W
loc_00EAB4:
        DC.W    $5878,$C87E         ; $00EAB4 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $00EAB8 MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $00EAC0 RTS
        DC.W    $0088,$EFC2,$0088   ; $00EAC2 ORI.L  #$EFC20088,A0
        DC.W    $F040               ; $00EAC8 MOVEA.W D0,A0
        DC.W    $0088,$F0BE,$0088   ; $00EACA ORI.L  #$F0BE0088,A0
        DC.W    $EADA               ; $00EAD0 LSR.W  (A2)+
        DC.W    $0088,$EBDA,$0088   ; $00EAD2 ORI.L  #$EBDA0088,A0
        DC.W    $ECDA               ; $00EAD8 ROXR.W  (A2)+
        DC.W    $0000,$8000         ; $00EADA ORI.B  #$8000,D0
        DC.W    $8421               ; $00EADE OR.B   -(A1),D2
        DC.W    $8842               ; $00EAE0 OR.W   D2,D4
        DC.W    $8C63               ; $00EAE2 OR.W   -(A3),D6
        DC.W    $9084               ; $00EAE4 SUB.L  D4,D0
        DC.W    $94A5               ; $00EAE6 SUB.L  -(A5),D2
        DC.W    $98C6               ; $00EAE8 SUBA.W  D6,A4
        DC.W    $9CE7               ; $00EAEA SUBA.W  -(A7),A6
        DC.W    $A108               ; $00EAEC MOVE.L  A0,-(A0)
        DC.W    $A529,$A94A         ; $00EAEE MOVE.L  -$56B6(A1),-(A2)
        DC.W    $AD6B,$B18C,$B5AD   ; $00EAF2 MOVE.L  -$4E74(A3),-$4A53(A6)
        DC.W    $B9CE               ; $00EAF8 CMPA.L  A6,A4
        DC.W    $BDEF,$C210         ; $00EAFA CMPA.L  -$3DF0(A7),A6
        DC.W    $C631,$CA52         ; $00EAFE AND.B  $52(A1,A4.L),D3
        DC.W    $CE73,$D294         ; $00EB02 AND.W  -$6C(A3,A5.W),D7
        DC.W    $D6B5,$DAD6         ; $00EB06 ADD.L  -$2A(A5,A5.L),D3
        DC.W    $DEF7,$E318         ; $00EB0A ADDA.W  $18(A7,A6.W),A7
        DC.W    $E739               ; $00EB0E ROL.B  D3,D1
        DC.W    $EB5A               ; $00EB10 ROL.W  #5,D2
        DC.W    $EF7B               ; $00EB12 ROL.W  D7,D3
        DC.W    $F39C,$F7BD         ; $00EB14 MOVE.W  (A4)+,-$43(A1,A7.W)
        DC.W    $FBDE               ; $00EB18 MOVE.W  (A6)+,<EA:3D>
        DC.W    $FFFF               ; $00EB1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $800A               ; $00EB1C OR.B   A2,D0
        DC.W    $800B               ; $00EB1E OR.B   A3,D0
        DC.W    $800C               ; $00EB20 OR.B   A4,D0
        DC.W    $800D               ; $00EB22 OR.B   A5,D0
        DC.W    $800E               ; $00EB24 OR.B   A6,D0
        DC.W    $800F               ; $00EB26 OR.B   A7,D0
        DC.W    $8010               ; $00EB28 OR.B   (A0),D0
        DC.W    $8011               ; $00EB2A OR.B   (A1),D0
        DC.W    $8012               ; $00EB2C OR.B   (A2),D0
        DC.W    $8432,$8C73         ; $00EB2E OR.B   $73(A2,A0.L),D2
        DC.W    $9094               ; $00EB32 SUB.L  (A4),D0
        DC.W    $98D4               ; $00EB34 SUBA.W  (A4),A4
        DC.W    $A536,$BC00         ; $00EB36 MOVE.L  $00(A6,A3.L),-(A2)
        DC.W    $C800               ; $00EB3A AND.B  D0,D4
        DC.W    $D800               ; $00EB3C ADD.B  D0,D4
        DC.W    $E000               ; $00EB3E ASR.B  #8,D0
        DC.W    $E063               ; $00EB40 ASR.W  D0,D3
        DC.W    $E484               ; $00EB42 ASR.L  #2,D4
        DC.W    $E4C6               ; $00EB44 ROXR.W  D6
        DC.W    $E4E7               ; $00EB46 ROXR.W  -(A7)
        DC.W    $E929               ; $00EB48 LSL.B  D4,D1
        DC.W    $F2B5,$F718         ; $00EB4A MOVE.W  $18(A5,A7.W),(A1)
        DC.W    $8000               ; $00EB4E OR.B   D0,D0
        DC.W    $8000               ; $00EB50 OR.B   D0,D0
        DC.W    $8000               ; $00EB52 OR.B   D0,D0
        DC.W    $8000               ; $00EB54 OR.B   D0,D0
        DC.W    $8000               ; $00EB56 OR.B   D0,D0
        DC.W    $8000               ; $00EB58 OR.B   D0,D0
        DC.W    $8000               ; $00EB5A OR.B   D0,D0
        DC.W    $8000               ; $00EB5C OR.B   D0,D0
        DC.W    $8000               ; $00EB5E OR.B   D0,D0
        DC.W    $8000               ; $00EB60 OR.B   D0,D0
        DC.W    $8000               ; $00EB62 OR.B   D0,D0
        DC.W    $8000               ; $00EB64 OR.B   D0,D0
        DC.W    $94A0               ; $00EB66 SUB.L  -(A0),D2
        DC.W    $8840               ; $00EB68 OR.W   D0,D4
        DC.W    $8000               ; $00EB6A OR.B   D0,D0
        DC.W    $8840               ; $00EB6C OR.W   D0,D4
        DC.W    $9080               ; $00EB6E SUB.L  D0,D0
        DC.W    $98C1               ; $00EB70 SUBA.W  D1,A4
        DC.W    $A103               ; $00EB72 MOVE.L  D3,-(A0)
        DC.W    $A945,$0000         ; $00EB74 MOVE.L  D5,$0000(A4)
        DC.W    $0000,$0000         ; $00EB78 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB7C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB80 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB84 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB88 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB8C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB90 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB94 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB98 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB9C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBA0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBA4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBA8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBAC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBB0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBB4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBB8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBBC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBC0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBC4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBC8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBCC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBD0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBD4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBD8 ORI.B  #$0000,D0
        DC.W    $8000               ; $00EBDC OR.B   D0,D0
        DC.W    $8421               ; $00EBDE OR.B   -(A1),D2
        DC.W    $8842               ; $00EBE0 OR.W   D2,D4
        DC.W    $8C63               ; $00EBE2 OR.W   -(A3),D6
        DC.W    $9084               ; $00EBE4 SUB.L  D4,D0
        DC.W    $94A5               ; $00EBE6 SUB.L  -(A5),D2
        DC.W    $98C6               ; $00EBE8 SUBA.W  D6,A4
        DC.W    $9CE7               ; $00EBEA SUBA.W  -(A7),A6
        DC.W    $A108               ; $00EBEC MOVE.L  A0,-(A0)
        DC.W    $A529,$A94A         ; $00EBEE MOVE.L  -$56B6(A1),-(A2)
        DC.W    $AD6B,$B18C,$B5AD   ; $00EBF2 MOVE.L  -$4E74(A3),-$4A53(A6)
        DC.W    $B9CE               ; $00EBF8 CMPA.L  A6,A4
        DC.W    $BDEF,$C210         ; $00EBFA CMPA.L  -$3DF0(A7),A6
        DC.W    $C631,$CA52         ; $00EBFE AND.B  $52(A1,A4.L),D3
        DC.W    $CE73,$D294         ; $00EC02 AND.W  -$6C(A3,A5.W),D7
        DC.W    $D6B5,$DAD6         ; $00EC06 ADD.L  -$2A(A5,A5.L),D3
        DC.W    $DEF7,$E318         ; $00EC0A ADDA.W  $18(A7,A6.W),A7
        DC.W    $E739               ; $00EC0E ROL.B  D3,D1
        DC.W    $EB5A               ; $00EC10 ROL.W  #5,D2
        DC.W    $EF7B               ; $00EC12 ROL.W  D7,D3
        DC.W    $F39C,$F7BD         ; $00EC14 MOVE.W  (A4)+,-$43(A1,A7.W)
        DC.W    $FBDE               ; $00EC18 MOVE.W  (A6)+,<EA:3D>
        DC.W    $FFFF               ; $00EC1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $9060               ; $00EC1C SUB.W  -(A0),D0
        DC.W    $9481               ; $00EC1E SUB.L  D1,D2
        DC.W    $9CC3               ; $00EC20 SUBA.W  D3,A6
        DC.W    $A4E4               ; $00EC22 MOVE.L  -(A4),(A2)+
        DC.W    $AD26               ; $00EC24 MOVE.L  -(A6),-(A6)
        DC.W    $AC61               ; $00EC26 MOVEA.L -(A1),A6
        DC.W    $B082               ; $00EC28 CMP.L  D2,D0
        DC.W    $B4A3               ; $00EC2A CMP.L  -(A3),D2
        DC.W    $B8C4               ; $00EC2C CMPA.W  D4,A4
        DC.W    $BCE5               ; $00EC2E CMPA.W  -(A5),A6
        DC.W    $C106               ; $00EC30 AND.B  D0,D6
        DC.W    $800A               ; $00EC32 OR.B   A2,D0
        DC.W    $800C               ; $00EC34 OR.B   A4,D0
        DC.W    $800E               ; $00EC36 OR.B   A6,D0
        DC.W    $8010               ; $00EC38 OR.B   (A0),D0
        DC.W    $8431,$8C72         ; $00EC3A OR.B   $72(A1,A0.L),D2
        DC.W    $94B3,$9CF4         ; $00EC3E SUB.L  -$0C(A3,A1.L),D2
        DC.W    $8000               ; $00EC42 OR.B   D0,D0
        DC.W    $8000               ; $00EC44 OR.B   D0,D0
        DC.W    $8000               ; $00EC46 OR.B   D0,D0
        DC.W    $8000               ; $00EC48 OR.B   D0,D0
        DC.W    $8000               ; $00EC4A OR.B   D0,D0
        DC.W    $8000               ; $00EC4C OR.B   D0,D0
        DC.W    $8000               ; $00EC4E OR.B   D0,D0
        DC.W    $8000               ; $00EC50 OR.B   D0,D0
        DC.W    $8000               ; $00EC52 OR.B   D0,D0
        DC.W    $8000               ; $00EC54 OR.B   D0,D0
        DC.W    $8000               ; $00EC56 OR.B   D0,D0
        DC.W    $8000               ; $00EC58 OR.B   D0,D0
        DC.W    $8000               ; $00EC5A OR.B   D0,D0
        DC.W    $8000               ; $00EC5C OR.B   D0,D0
        DC.W    $8000               ; $00EC5E OR.B   D0,D0
        DC.W    $8000               ; $00EC60 OR.B   D0,D0
        DC.W    $8000               ; $00EC62 OR.B   D0,D0
        DC.W    $8000               ; $00EC64 OR.B   D0,D0
        DC.W    $8C60               ; $00EC66 OR.W   -(A0),D6
        DC.W    $8840               ; $00EC68 OR.W   D0,D4
        DC.W    $8000               ; $00EC6A OR.B   D0,D0
        DC.W    $8840               ; $00EC6C OR.W   D0,D4
        DC.W    $9080               ; $00EC6E SUB.L  D0,D0
        DC.W    $98C1               ; $00EC70 SUBA.W  D1,A4
        DC.W    $A103               ; $00EC72 MOVE.L  D3,-(A0)
        DC.W    $A945,$0000         ; $00EC74 MOVE.L  D5,$0000(A4)
        DC.W    $0000,$0000         ; $00EC78 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC7C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC80 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC84 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC88 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC8C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC90 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC94 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC98 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC9C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECA0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECA4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECA8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECAC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECB0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECB4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECB8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECBC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECC0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECC4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECC8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECCC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECD0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECD4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECD8 ORI.B  #$0000,D0
        DC.W    $8000               ; $00ECDC OR.B   D0,D0
        DC.W    $8421               ; $00ECDE OR.B   -(A1),D2
        DC.W    $8842               ; $00ECE0 OR.W   D2,D4
        DC.W    $8C63               ; $00ECE2 OR.W   -(A3),D6
        DC.W    $9084               ; $00ECE4 SUB.L  D4,D0
        DC.W    $94A5               ; $00ECE6 SUB.L  -(A5),D2
        DC.W    $98C6               ; $00ECE8 SUBA.W  D6,A4
        DC.W    $9CE7               ; $00ECEA SUBA.W  -(A7),A6
        DC.W    $A108               ; $00ECEC MOVE.L  A0,-(A0)
        DC.W    $A529,$A94A         ; $00ECEE MOVE.L  -$56B6(A1),-(A2)
        DC.W    $AD6B,$B18C,$B5AD   ; $00ECF2 MOVE.L  -$4E74(A3),-$4A53(A6)
        DC.W    $B9CE               ; $00ECF8 CMPA.L  A6,A4
        DC.W    $BDEF,$C210         ; $00ECFA CMPA.L  -$3DF0(A7),A6
        DC.W    $C631,$CA52         ; $00ECFE AND.B  $52(A1,A4.L),D3
        DC.W    $CE73,$D294         ; $00ED02 AND.W  -$6C(A3,A5.W),D7
        DC.W    $D6B5,$DAD6         ; $00ED06 ADD.L  -$2A(A5,A5.L),D3
        DC.W    $DEF7,$E318         ; $00ED0A ADDA.W  $18(A7,A6.W),A7
        DC.W    $E739               ; $00ED0E ROL.B  D3,D1
        DC.W    $EB5A               ; $00ED10 ROL.W  #5,D2
        DC.W    $EF7B               ; $00ED12 ROL.W  D7,D3
        DC.W    $F39C,$F7BD         ; $00ED14 MOVE.W  (A4)+,-$43(A1,A7.W)
        DC.W    $FBDE               ; $00ED18 MOVE.W  (A6)+,<EA:3D>
        DC.W    $FFFF               ; $00ED1A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $9060               ; $00ED1C SUB.W  -(A0),D0
        DC.W    $9481               ; $00ED1E SUB.L  D1,D2
        DC.W    $9CC3               ; $00ED20 SUBA.W  D3,A6
        DC.W    $A4E4               ; $00ED22 MOVE.L  -(A4),(A2)+
        DC.W    $AD26               ; $00ED24 MOVE.L  -(A6),-(A6)
        DC.W    $8009               ; $00ED26 OR.B   A1,D0
        DC.W    $800B               ; $00ED28 OR.B   A3,D0
        DC.W    $800D               ; $00ED2A OR.B   A5,D0
        DC.W    $8010               ; $00ED2C OR.B   (A0),D0
        DC.W    $8852               ; $00ED2E OR.W   (A2),D4
        DC.W    $8C73,$98D4         ; $00ED30 OR.W   -$2C(A3,A1.L),D6
        DC.W    $A535,$BC00         ; $00ED34 MOVE.L  $00(A5,A3.L),-(A2)
        DC.W    $C400               ; $00ED38 AND.B  D0,D2
        DC.W    $CC40               ; $00ED3A AND.W  D0,D6
        DC.W    $D482               ; $00ED3C ADD.L  D2,D2
        DC.W    $E0E5               ; $00ED3E ASR.W  -(A5)
        DC.W    $E927               ; $00ED40 ASL.B  D4,D7
        DC.W    $8000               ; $00ED42 OR.B   D0,D0
        DC.W    $8000               ; $00ED44 OR.B   D0,D0
        DC.W    $8000               ; $00ED46 OR.B   D0,D0
        DC.W    $8000               ; $00ED48 OR.B   D0,D0
        DC.W    $8000               ; $00ED4A OR.B   D0,D0
        DC.W    $8000               ; $00ED4C OR.B   D0,D0
        DC.W    $8000               ; $00ED4E OR.B   D0,D0
        DC.W    $8000               ; $00ED50 OR.B   D0,D0
        DC.W    $8000               ; $00ED52 OR.B   D0,D0
        DC.W    $8000               ; $00ED54 OR.B   D0,D0
        DC.W    $8000               ; $00ED56 OR.B   D0,D0
        DC.W    $8000               ; $00ED58 OR.B   D0,D0
        DC.W    $8000               ; $00ED5A OR.B   D0,D0
        DC.W    $8000               ; $00ED5C OR.B   D0,D0
        DC.W    $8000               ; $00ED5E OR.B   D0,D0
        DC.W    $8000               ; $00ED60 OR.B   D0,D0
        DC.W    $8000               ; $00ED62 OR.B   D0,D0
        DC.W    $8000               ; $00ED64 OR.B   D0,D0
        DC.W    $8C60               ; $00ED66 OR.W   -(A0),D6
        DC.W    $8840               ; $00ED68 OR.W   D0,D4
        DC.W    $8000               ; $00ED6A OR.B   D0,D0
        DC.W    $8840               ; $00ED6C OR.W   D0,D4
        DC.W    $9080               ; $00ED6E SUB.L  D0,D0
        DC.W    $98C1               ; $00ED70 SUBA.W  D1,A4
        DC.W    $A103               ; $00ED72 MOVE.L  D3,-(A0)
        DC.W    $A945,$0000         ; $00ED74 MOVE.L  D5,$0000(A4)
        DC.W    $0000,$0000         ; $00ED78 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED7C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED80 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED84 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED88 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED8C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED90 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED94 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED98 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED9C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDA0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDA4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDA8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDAC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDB0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDB4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDB8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDBC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDC0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDC4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDC8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDCC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDD0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDD4 ORI.B  #$0000,D0
        DC.W    $0000,$207C         ; $00EDD8 ORI.B  #$207C,D0
        DC.W    $0603,$D100         ; $00EDDC ADDI.B  #$D100,D3
        DC.W    $227C,$0400,$4C68   ; $00EDE0 MOVEA.L #$04004C68,A1
        DC.W    $303C,$0070         ; $00EDE6 MOVE.W  #$0070,D0
        DC.W    $323C,$0010         ; $00EDEA MOVE.W  #$0010,D1
        DC.W    $4EBA,$F56A         ; $00EDEE JSR     loc_00E35A(PC)
loc_00EDF2:
        DC.W    $4A39,$00A1,$5120   ; $00EDF2 TST.B  $00A15120
        DC.W    $66F8               ; $00EDF8 BNE.S  loc_00EDF2
        DC.W    $6100,$0136         ; $00EDFA BSR.W  loc_00EF32
        DC.W    $207C,$0603,$D800   ; $00EDFE MOVEA.L #$0603D800,A0
        DC.W    $227C,$0401,$985C   ; $00EE04 MOVEA.L #$0401985C,A1
        DC.W    $303C,$0088         ; $00EE0A MOVE.W  #$0088,D0
        DC.W    $323C,$0010         ; $00EE0E MOVE.W  #$0010,D1
        DC.W    $4EBA,$F546         ; $00EE12 JSR     loc_00E35A(PC)
        DC.W    $4240               ; $00EE16 CLR.W  D0
        DC.W    $1038,$A01A         ; $00EE18 MOVE.B  $A01A.W,D0
        DC.W    $6100,$F70E         ; $00EE1C BSR.W  loc_00E52C
        DC.W    $4EBA,$C862         ; $00EE20 JSR     $00B684(PC)
        DC.W    $4EBA,$C8B4         ; $00EE24 JSR     $00B6DA(PC)
        DC.W    $0C78,$0001,$A020   ; $00EE28 CMPI.W  #$0001,$A020.W
        DC.W    $6700,$008A         ; $00EE2E BEQ.W  loc_00EEBA
        DC.W    $0C78,$0002,$A020   ; $00EE32 CMPI.W  #$0002,$A020.W
        DC.W    $6700,$0090         ; $00EE38 BEQ.W  loc_00EECA
        DC.W    $3238,$C86C         ; $00EE3C MOVE.W  $C86C.W,D1
        DC.W    $0201,$00E0         ; $00EE40 ANDI.B  #$00E0,D1
        DC.W    $6616               ; $00EE44 BNE.S  loc_00EE5C
        DC.W    $3238,$C86C         ; $00EE46 MOVE.W  $C86C.W,D1
        DC.W    $0201,$0010         ; $00EE4A ANDI.B  #$0010,D1
        DC.W    $6608               ; $00EE4E BNE.S  loc_00EE58
        DC.W    $5978,$C87E         ; $00EE50 SUBQ.W  #4,$C87E.W
        DC.W    $6000,$008C         ; $00EE54 BRA.W  loc_00EEE2
loc_00EE58:
        DC.W    $50F8,$A018         ; $00EE58 ST      $A018.W
loc_00EE5C:
        DC.W    $11FC,$00A8,$C8A4   ; $00EE5C MOVE.B  #$00A8,$C8A4.W
        DC.W    $4A38,$A01A         ; $00EE62 TST.B  $A01A.W
        DC.W    $660A               ; $00EE66 BNE.S  loc_00EE72
        DC.W    $11F8,$A019,$A01E   ; $00EE68 MOVE.B  $A019.W,$A01E.W
        DC.W    $6000,$0008         ; $00EE6E BRA.W  loc_00EE78
loc_00EE72:
        DC.W    $11F8,$A019,$A01D   ; $00EE72 MOVE.B  $A019.W,$A01D.W
loc_00EE78:
        DC.W    $4A38,$A01F         ; $00EE78 TST.B  $A01F.W
        DC.W    $660E               ; $00EE7C BNE.S  loc_00EE8C
        DC.W    $11F8,$A01E,$FEB1   ; $00EE7E MOVE.B  $A01E.W,$FEB1.W
        DC.W    $11F8,$A01D,$FEA9   ; $00EE84 MOVE.B  $A01D.W,$FEA9.W
        DC.W    $600C               ; $00EE8A BRA.S  loc_00EE98
loc_00EE8C:
        DC.W    $11F8,$A01E,$FEB2   ; $00EE8C MOVE.B  $A01E.W,$FEB2.W
        DC.W    $11F8,$A01D,$FEAA   ; $00EE92 MOVE.B  $A01D.W,$FEAA.W
loc_00EE98:
        DC.W    $11FC,$0001,$C809   ; $00EE98 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00EE9E MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $00EEA4 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00EEAA MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0002,$A020   ; $00EEB0 MOVE.W  #$0002,$A020.W
        DC.W    $6000,$0026         ; $00EEB6 BRA.W  loc_00EEDE
loc_00EEBA:
        DC.W    $0838,$0006,$C80E   ; $00EEBA BTST    #6,$C80E.W
        DC.W    $661C               ; $00EEC0 BNE.S  loc_00EEDE
        DC.W    $4278,$A020         ; $00EEC2 CLR.W  $A020.W
        DC.W    $6000,$0016         ; $00EEC6 BRA.W  loc_00EEDE
loc_00EECA:
        DC.W    $0838,$0007,$C80E   ; $00EECA BTST    #7,$C80E.W
        DC.W    $660C               ; $00EED0 BNE.S  loc_00EEDE
        DC.W    $4278,$A020         ; $00EED2 CLR.W  $A020.W
        DC.W    $5878,$C87E         ; $00EED6 ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $00EEDA BRA.W  loc_00EEE2
loc_00EEDE:
        DC.W    $5978,$C87E         ; $00EEDE SUBQ.W  #4,$C87E.W
loc_00EEE2:
        DC.W    $33FC,$0018,$00FF,$0008; $00EEE2 MOVE.W  #$0018,$00FF0008
        DC.W    $11FC,$0001,$C821   ; $00EEEA MOVE.B  #$0001,$C821.W
        DC.W    $4E75               ; $00EEF0 RTS
loc_00EEF2:
        DC.W    $4A39,$00A1,$5120   ; $00EEF2 TST.B  $00A15120
        DC.W    $66F8               ; $00EEF8 BNE.S  loc_00EEF2
        DC.W    $4239,$00A1,$5123   ; $00EEFA CLR.B  $00A15123
        DC.W    $31FC,$0000,$C87E   ; $00EF00 MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0089,$26D2,$00FF,$0002; $00EF06 MOVE.L  #$008926D2,$00FF0002
        DC.W    $4A38,$A018         ; $00EF10 TST.B  $A018.W
        DC.W    $661A               ; $00EF14 BNE.S  loc_00EF30
        DC.W    $23FC,$0088,$D4A4,$00FF,$0002; $00EF16 MOVE.L  #$0088D4A4,$00FF0002
        DC.W    $4A38,$A01F         ; $00EF20 TST.B  $A01F.W
        DC.W    $660A               ; $00EF24 BNE.S  loc_00EF30
        DC.W    $23FC,$0088,$D48A,$00FF,$0002; $00EF26 MOVE.L  #$0088D48A,$00FF0002
loc_00EF30:
        DC.W    $4E75               ; $00EF30 RTS
loc_00EF32:
        DC.W    $7000               ; $00EF32 MOVEQ   #$00,D0
        DC.W    $4A38,$A01A         ; $00EF34 TST.B  $A01A.W
        DC.W    $6606               ; $00EF38 BNE.S  loc_00EF40
        DC.W    $1038,$A019         ; $00EF3A MOVE.B  $A019.W,D0
        DC.W    $6004               ; $00EF3E BRA.S  loc_00EF44
loc_00EF40:
        DC.W    $1038,$A01E         ; $00EF40 MOVE.B  $A01E.W,D0
loc_00EF44:
        DC.W    $43F9,$0088,$EFA4   ; $00EF44 LEA     $0088EFA4,A1
        DC.W    $D040               ; $00EF4A ADD.W  D0,D0
        DC.W    $3200               ; $00EF4C MOVE.W  D0,D1
        DC.W    $D040               ; $00EF4E ADD.W  D0,D0
        DC.W    $D041               ; $00EF50 ADD.W  D1,D0
        DC.W    $2071,$0000         ; $00EF52 MOVEA.L $00(A1,D0.W),A0
        DC.W    $3031,$0004         ; $00EF56 MOVE.W  $04(A1,D0.W),D0
        DC.W    $323C,$0030         ; $00EF5A MOVE.W  #$0030,D1
        DC.W    $343C,$0010         ; $00EF5E MOVE.W  #$0010,D2
        DC.W    $4EBA,$F450         ; $00EF62 JSR     loc_00E3B4(PC)
        DC.W    $7000               ; $00EF66 MOVEQ   #$00,D0
        DC.W    $4A38,$A01A         ; $00EF68 TST.B  $A01A.W
        DC.W    $6706               ; $00EF6C BEQ.S  loc_00EF74
        DC.W    $1038,$A019         ; $00EF6E MOVE.B  $A019.W,D0
        DC.W    $6004               ; $00EF72 BRA.S  loc_00EF78
loc_00EF74:
        DC.W    $1038,$A01D         ; $00EF74 MOVE.B  $A01D.W,D0
loc_00EF78:
        DC.W    $43F9,$0088,$EFB6   ; $00EF78 LEA     $0088EFB6,A1
        DC.W    $D040               ; $00EF7E ADD.W  D0,D0
        DC.W    $3200               ; $00EF80 MOVE.W  D0,D1
        DC.W    $D040               ; $00EF82 ADD.W  D0,D0
        DC.W    $D041               ; $00EF84 ADD.W  D1,D0
        DC.W    $2071,$0000         ; $00EF86 MOVEA.L $00(A1,D0.W),A0
        DC.W    $3031,$0004         ; $00EF8A MOVE.W  $04(A1,D0.W),D0
        DC.W    $323C,$0018         ; $00EF8E MOVE.W  #$0018,D1
        DC.W    $343C,$0010         ; $00EF92 MOVE.W  #$0010,D2
loc_00EF96:
        DC.W    $4A39,$00A1,$5120   ; $00EF96 TST.B  $00A15120
        DC.W    $66F8               ; $00EF9C BNE.S  loc_00EF96
        DC.W    $4EBA,$F414         ; $00EF9E JSR     loc_00E3B4(PC)
        DC.W    $4E75               ; $00EFA2 RTS
        DC.W    $0401,$2010         ; $00EFA4 SUBI.B  #$2010,D1
        DC.W    $0060,$0401         ; $00EFA8 ORI.W  #$0401,-(A0)
        DC.W    $206F,$0061         ; $00EFAC MOVEA.L $0061(A7),A0
        DC.W    $0401,$20CF         ; $00EFB0 SUBI.B  #$20CF,D1
        DC.W    $0061,$0401         ; $00EFB4 ORI.W  #$0401,-(A1)
        DC.W    $B010               ; $00EFB8 CMP.B  (A0),D0
        DC.W    $0091,$0401,$B0A0   ; $00EFBA ORI.L  #$0401B0A0,(A1)
        DC.W    $0090,$43F9,$00FF   ; $00EFC0 ORI.L  #$43F900FF,(A0)
        DC.W    $6100,$337C         ; $00EFC6 BSR.W  $012344
        DC.W    $0001,$0000         ; $00EFCA ORI.B  #$0000,D1
        DC.W    $337C,$0000,$0002   ; $00EFCE MOVE.W  #$0000,$0002(A1)
        DC.W    $3379,$00FF,$2002,$0004; $00EFD4 MOVE.W  $00FF2002,$0004(A1)
        DC.W    $3379,$00FF,$2004,$0006; $00EFDC MOVE.W  $00FF2004,$0006(A1)
        DC.W    $3379,$00FF,$2000,$0008; $00EFE4 MOVE.W  $00FF2000,$0008(A1)
        DC.W    $3340,$000A         ; $00EFEC MOVE.W  D0,$000A(A1)
        DC.W    $337C,$0000,$000C   ; $00EFF0 MOVE.W  #$0000,$000C(A1)
        DC.W    $337C,$0000,$000E   ; $00EFF6 MOVE.W  #$0000,$000E(A1)
        DC.W    $237C,$222B,$DAE6,$0010; $00EFFC MOVE.L  #$222BDAE6,$0010(A1)
        DC.W    $D3FC,$0000,$0014   ; $00F004 ADDA.L  #$00000014,A1
        DC.W    $33FC,$0044,$00A1,$5110; $00F00A MOVE.W  #$0044,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $00F012 MOVE.B  #$0004,$00A15107
loc_00F01A:
        DC.W    $4A39,$00A1,$5120   ; $00F01A TST.B  $00A15120
        DC.W    $66F8               ; $00F020 BNE.S  loc_00F01A
        DC.W    $13FC,$002A,$00A1,$5121; $00F022 MOVE.B  #$002A,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00F02A MOVE.B  #$0001,$00A15120
        DC.W    $4E75               ; $00F032 RTS
        DC.W    $2228,$1450         ; $00F034 MOVE.L  $1450(A0),D1
        DC.W    $2228,$155A         ; $00F038 MOVE.L  $155A(A0),D1
        DC.W    $2228,$1664         ; $00F03C MOVE.L  $1664(A0),D1
        DC.W    $43F9,$00FF,$6100   ; $00F040 LEA     $00FF6100,A1
        DC.W    $337C,$0001,$0000   ; $00F046 MOVE.W  #$0001,$0000(A1)
        DC.W    $337C,$0000,$0002   ; $00F04C MOVE.W  #$0000,$0002(A1)
        DC.W    $3379,$00FF,$2008,$0004; $00F052 MOVE.W  $00FF2008,$0004(A1)
        DC.W    $3379,$00FF,$200A,$0006; $00F05A MOVE.W  $00FF200A,$0006(A1)
        DC.W    $3379,$00FF,$2006,$0008; $00F062 MOVE.W  $00FF2006,$0008(A1)
        DC.W    $3340,$000A         ; $00F06A MOVE.W  D0,$000A(A1)
        DC.W    $337C,$0000,$000C   ; $00F06E MOVE.W  #$0000,$000C(A1)
        DC.W    $337C,$0000,$000E   ; $00F074 MOVE.W  #$0000,$000E(A1)
        DC.W    $237C,$222B,$EA76,$0010; $00F07A MOVE.L  #$222BEA76,$0010(A1)
        DC.W    $D3FC,$0000,$0014   ; $00F082 ADDA.L  #$00000014,A1
        DC.W    $33FC,$0044,$00A1,$5110; $00F088 MOVE.W  #$0044,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $00F090 MOVE.B  #$0004,$00A15107
loc_00F098:
        DC.W    $4A39,$00A1,$5120   ; $00F098 TST.B  $00A15120
        DC.W    $66F8               ; $00F09E BNE.S  loc_00F098
        DC.W    $13FC,$002A,$00A1,$5121; $00F0A0 MOVE.B  #$002A,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00F0A8 MOVE.B  #$0001,$00A15120
        DC.W    $4E75               ; $00F0B0 RTS
        DC.W    $2228,$4FAA         ; $00F0B2 MOVE.L  $4FAA(A0),D1
        DC.W    $2228,$506C         ; $00F0B6 MOVE.L  $506C(A0),D1
        DC.W    $2228,$512E         ; $00F0BA MOVE.L  $512E(A0),D1
        DC.W    $43F9,$00FF,$6100   ; $00F0BE LEA     $00FF6100,A1
        DC.W    $337C,$0001,$0000   ; $00F0C4 MOVE.W  #$0001,$0000(A1)
        DC.W    $337C,$0000,$0002   ; $00F0CA MOVE.W  #$0000,$0002(A1)
        DC.W    $3379,$00FF,$200E,$0004; $00F0D0 MOVE.W  $00FF200E,$0004(A1)
        DC.W    $3379,$00FF,$2010,$0006; $00F0D8 MOVE.W  $00FF2010,$0006(A1)
        DC.W    $3379,$00FF,$200C,$0008; $00F0E0 MOVE.W  $00FF200C,$0008(A1)
        DC.W    $3340,$000A         ; $00F0E8 MOVE.W  D0,$000A(A1)
        DC.W    $337C,$0000,$000C   ; $00F0EC MOVE.W  #$0000,$000C(A1)
        DC.W    $337C,$0000,$000E   ; $00F0F2 MOVE.W  #$0000,$000E(A1)
        DC.W    $237C,$222B,$F710,$0010; $00F0F8 MOVE.L  #$222BF710,$0010(A1)
        DC.W    $D3FC,$0000,$0014   ; $00F100 ADDA.L  #$00000014,A1
        DC.W    $33FC,$0044,$00A1,$5110; $00F106 MOVE.W  #$0044,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $00F10E MOVE.B  #$0004,$00A15107
loc_00F116:
        DC.W    $4A39,$00A1,$5120   ; $00F116 TST.B  $00A15120
        DC.W    $66F8               ; $00F11C BNE.S  loc_00F116
        DC.W    $13FC,$002A,$00A1,$5121; $00F11E MOVE.B  #$002A,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00F126 MOVE.B  #$0001,$00A15120
        DC.W    $4E75               ; $00F12E RTS
        DC.W    $2228,$819A         ; $00F130 MOVE.L  -$7E66(A0),D1
        DC.W    $2228,$825C         ; $00F134 MOVE.L  -$7DA4(A0),D1
        DC.W    $2228,$831E         ; $00F138 MOVE.L  -$7CE2(A0),D1
        DC.W    $08B8,$0007,$FDA8   ; $00F13C BCLR    #7,$FDA8.W
        DC.W    $33FC,$002C,$00FF,$0008; $00F142 MOVE.W  #$002C,$00FF0008
        DC.W    $31FC,$002C,$C87A   ; $00F14A MOVE.W  #$002C,$C87A.W
        DC.W    $08B8,$0006,$C875   ; $00F150 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00F156 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $00F15A MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $00F162 ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$26C8   ; $00F16A JSR     $008826C8
        DC.W    $203C,$000A,$0907   ; $00F170 MOVE.L  #$000A0907,D0
        DC.W    $4EB9,$0088,$14BE   ; $00F176 JSR     $008814BE
        DC.W    $11FC,$0001,$C80D   ; $00F17C MOVE.B  #$0001,$C80D.W
        DC.W    $7000               ; $00F182 MOVEQ   #$00,D0
        DC.W    $41F8,$8480         ; $00F184 LEA     $8480.W,A0
        DC.W    $721F               ; $00F188 MOVEQ   #$1F,D1
loc_00F18A:
        DC.W    $20C0               ; $00F18A MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $00F18C DBRA    D1,loc_00F18A
        DC.W    $41F9,$00FF,$7B80   ; $00F190 LEA     $00FF7B80,A0
        DC.W    $727F               ; $00F196 MOVEQ   #$7F,D1
loc_00F198:
        DC.W    $20C0               ; $00F198 MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $00F19A DBRA    D1,loc_00F198
        DC.W    $2ABC,$6000,$0002   ; $00F19E MOVE.L  #$60000002,(A5)
        DC.W    $323C,$17FF         ; $00F1A4 MOVE.W  #$17FF,D1
loc_00F1A8:
        DC.W    $2C80               ; $00F1A8 MOVE.L  D0,(A6)
        DC.W    $51C9,$FFFC         ; $00F1AA DBRA    D1,loc_00F1A8
        DC.W    $4EB9,$0088,$49AA   ; $00F1AE JSR     $008849AA
        DC.W    $4278,$C880         ; $00F1B4 CLR.W  $C880.W
        DC.W    $4278,$C882         ; $00F1B8 CLR.W  $C882.W
        DC.W    $4278,$8000         ; $00F1BC CLR.W  $8000.W
        DC.W    $4278,$8002         ; $00F1C0 CLR.W  $8002.W
        DC.W    $4278,$A012         ; $00F1C4 CLR.W  $A012.W
        DC.W    $4238,$A018         ; $00F1C8 CLR.B  $A018.W
        DC.W    $4EB9,$0088,$49AA   ; $00F1CC JSR     $008849AA
        DC.W    $21FC,$008B,$B4FC,$C96C; $00F1D2 MOVE.L  #$008BB4FC,$C96C.W
        DC.W    $11FC,$0001,$C809   ; $00F1DA MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00F1E0 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $00F1E6 BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00F1EC MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0001,$A024   ; $00F1F2 MOVE.W  #$0001,$A024.W
        DC.W    $41F9,$00FF,$1000   ; $00F1F8 LEA     $00FF1000,A0
        DC.W    $303C,$037F         ; $00F1FE MOVE.W  #$037F,D0
loc_00F202:
        DC.W    $4298               ; $00F202 CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $00F204 DBRA    D0,loc_00F202
        DC.W    $303C,$0001         ; $00F208 MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $00F20C MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $00F210 MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $00F214 MOVE.W  #$0026,D3
        DC.W    $383C,$0009         ; $00F218 MOVE.W  #$0009,D4
        DC.W    $41F9,$00FF,$1000   ; $00F21C LEA     $00FF1000,A0
        DC.W    $4EBA,$F008         ; $00F222 JSR     loc_00E22C(PC)
        DC.W    $303C,$0002         ; $00F226 MOVE.W  #$0002,D0
        DC.W    $323C,$0001         ; $00F22A MOVE.W  #$0001,D1
        DC.W    $343C,$000B         ; $00F22E MOVE.W  #$000B,D2
        DC.W    $363C,$0013         ; $00F232 MOVE.W  #$0013,D3
        DC.W    $383C,$0010         ; $00F236 MOVE.W  #$0010,D4
        DC.W    $41F9,$00FF,$1000   ; $00F23A LEA     $00FF1000,A0
        DC.W    $4EBA,$EFEA         ; $00F240 JSR     loc_00E22C(PC)
        DC.W    $303C,$0003         ; $00F244 MOVE.W  #$0003,D0
        DC.W    $323C,$0014         ; $00F248 MOVE.W  #$0014,D1
        DC.W    $343C,$000B         ; $00F24C MOVE.W  #$000B,D2
        DC.W    $363C,$0013         ; $00F250 MOVE.W  #$0013,D3
        DC.W    $383C,$0010         ; $00F254 MOVE.W  #$0010,D4
        DC.W    $41F9,$00FF,$1000   ; $00F258 LEA     $00FF1000,A0
        DC.W    $4EBA,$EFCC         ; $00F25E JSR     loc_00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $00F262 LEA     $00FF1000,A0
        DC.W    $4EBA,$F086         ; $00F268 JSR     loc_00E2F0(PC)
        DC.W    $4EBA,$EF4E         ; $00F26C JSR     $00E1BC(PC)
        DC.W    $08B9,$0007,$00A1,$5181; $00F270 BCLR    #7,$00A15181
        DC.W    $41F9,$00FF,$6E00   ; $00F278 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0160   ; $00F27E ADDA.L  #$00000160,A0
        DC.W    $43F9,$0088,$F39C   ; $00F284 LEA     $0088F39C,A1
        DC.W    $303C,$003F         ; $00F28A MOVE.W  #$003F,D0
loc_00F28E:
        DC.W    $3219               ; $00F28E MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $00F290 BSET    #15,D1
        DC.W    $30C1               ; $00F294 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $00F296 DBRA    D0,loc_00F28E
        DC.W    $41F9,$000E,$9680   ; $00F29A LEA     $000E9680,A0
        DC.W    $227C,$0603,$8000   ; $00F2A0 MOVEA.L #$06038000,A1
        DC.W    $4EBA,$F06E         ; $00F2A6 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$9F60   ; $00F2AA LEA     $000E9F60,A0
        DC.W    $227C,$0603,$B600   ; $00F2B0 MOVEA.L #$0603B600,A1
        DC.W    $4EBA,$F05E         ; $00F2B6 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$A080   ; $00F2BA LEA     $000EA080,A0
        DC.W    $227C,$0603,$BC00   ; $00F2C0 MOVEA.L #$0603BC00,A1
        DC.W    $4EBA,$F04E         ; $00F2C6 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$A240   ; $00F2CA LEA     $000EA240,A0
        DC.W    $227C,$0603,$C400   ; $00F2D0 MOVEA.L #$0603C400,A1
        DC.W    $4EBA,$F03E         ; $00F2D6 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$A340   ; $00F2DA LEA     $000EA340,A0
        DC.W    $227C,$0603,$C880   ; $00F2E0 MOVEA.L #$0603C880,A1
        DC.W    $4EBA,$F02E         ; $00F2E6 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$90A0   ; $00F2EA LEA     $000E90A0,A0
        DC.W    $227C,$0603,$D780   ; $00F2F0 MOVEA.L #$0603D780,A1
        DC.W    $4EBA,$F01E         ; $00F2F6 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$A5F0   ; $00F2FA LEA     $000EA5F0,A0
        DC.W    $227C,$0603,$DE80   ; $00F300 MOVEA.L #$0603DE80,A1
        DC.W    $4EBA,$F00E         ; $00F306 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$A710   ; $00F30A LEA     $000EA710,A0
        DC.W    $227C,$0603,$F200   ; $00F310 MOVEA.L #$0603F200,A1
        DC.W    $4EBA,$EFFE         ; $00F316 JSR     loc_00E316(PC)
        DC.W    $11F8,$A01F,$A019   ; $00F31A MOVE.B  $A01F.W,$A019.W
        DC.W    $4238,$A01B         ; $00F320 CLR.B  $A01B.W
        DC.W    $11F8,$FEB3,$A019   ; $00F324 MOVE.B  $FEB3.W,$A019.W
        DC.W    $11F8,$FEB0,$A01A   ; $00F32A MOVE.B  $FEB0.W,$A01A.W
        DC.W    $11FC,$0001,$A01C   ; $00F330 MOVE.B  #$0001,$A01C.W
        DC.W    $11F8,$FEAF,$A020   ; $00F336 MOVE.B  $FEAF.W,$A020.W
        DC.W    $11F8,$FEB0,$A022   ; $00F33C MOVE.B  $FEB0.W,$A022.W
        DC.W    $11F8,$FEAD,$A021   ; $00F342 MOVE.B  $FEAD.W,$A021.W
        DC.W    $11F8,$FEAE,$A023   ; $00F348 MOVE.B  $FEAE.W,$A023.W
        DC.W    $4EB9,$0088,$204A   ; $00F34E JSR     $0088204A
        DC.W    $0239,$00FC,$00A1,$5181; $00F354 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $00F35C ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $00F364 MOVE.W  #$8083,$00A15100
        DC.W    $08F8,$0006,$C875   ; $00F36C BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00F372 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0020,$00FF,$0008; $00F376 MOVE.W  #$0020,$00FF0008
        DC.W    $4EB9,$0088,$4998   ; $00F37E JSR     $00884998
        DC.W    $31FC,$0000,$C87E   ; $00F384 MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0088,$F41C,$00FF,$0002; $00F38A MOVE.L  #$0088F41C,$00FF0002
        DC.W    $11FC,$0081,$C8A5   ; $00F394 MOVE.B  #$0081,$C8A5.W
        DC.W    $4E75               ; $00F39A RTS
        DC.W    $4400               ; $00F39C NEG.B  D0
        DC.W    $44A3               ; $00F39E NEG.L  -(A3)
        DC.W    $4946               ; $00F3A0 DC.W    $4946
        DC.W    $4DE9,$1C00         ; $00F3A2 LEA     $1C00(A1),A6
        DC.W    $28A3               ; $00F3A6 MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $00F3A8 MOVE.W  D6,$41E9(A2)
        DC.W    $7FFF               ; $00F3AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $1C00               ; $00F3B4 MOVE.B  D0,D6
        DC.W    $28A3               ; $00F3B6 MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $00F3B8 MOVE.W  D6,$41E9(A2)
        DC.W    $4400               ; $00F3BC NEG.B  D0
        DC.W    $44A3               ; $00F3BE NEG.L  -(A3)
        DC.W    $4946               ; $00F3C0 DC.W    $4946
        DC.W    $4DE9,$7FFF         ; $00F3C2 LEA     $7FFF(A1),A6
        DC.W    $63F5               ; $00F3C6 BLS.S  loc_00F3BD
        DC.W    $7FFF               ; $00F3C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $00F3CC ORI.B  #$14AF,(A0)
        DC.W    $294E,$3DED         ; $00F3D0 MOVE.L  A6,$3DED(A4)
        DC.W    $7FFF               ; $00F3D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $77BA,$7BBC,$779A   ; $00F3DC MOVE.W  $7BBC(PC),-$66(A3,D7.W)
        DC.W    $77BC,$6B36,$6B37   ; $00F3E2 MOVE.W  #$6B36,$37(A3,D6.L)
        DC.W    $6F58               ; $00F3E8 BLE.S  loc_00F442
        DC.W    $6F79               ; $00F3EA BLE.S  loc_00F465
        DC.W    $739A,$61E8         ; $00F3EC MOVE.W  (A2)+,-$18(A1,D6.W)
        DC.W    $7FFF               ; $00F3F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FBC,$7F7A,$7FDE   ; $00F3FC MOVE.W  #$7F7A,-$22(A7,D7.L)
        DC.W    $7F9B,$4445         ; $00F402 MOVE.W  (A3)+,$45(A7,D4.W)
        DC.W    $512B,$6212         ; $00F406 SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $00F40A BGT.S  loc_00F404
        DC.W    $7FFF               ; $00F40C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $031F               ; $00F40E BTST    D1,(A7)+
        DC.W    $7FFF               ; $00F410 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F412 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F414 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F416 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F418 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F41A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $4EB9,$0088,$2080   ; $00F41C JSR     $00882080
        DC.W    $3038,$C87E         ; $00F422 MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $00F426 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00F42A JMP     (A1)
        DC.W    $0088,$F44C,$0088   ; $00F42C ORI.L  #$F44C0088,A0
        DC.W    $F6E2               ; $00F432 MOVE.W  -(A2),(A3)+
        DC.W    $0088,$F85C,$4EBA   ; $00F434 ORI.L  #$F85C4EBA,A0
        DC.W    $C24A               ; $00F43A AND.W  A2,D1
        DC.W    $0838,$0006,$C80E   ; $00F43C BTST    #6,$C80E.W
loc_00F442:
        DC.W    $6606               ; $00F442 BNE.S  loc_00F44A
        DC.W    $5878,$C87E         ; $00F444 ADDQ.W  #4,$C87E.W
        DC.W    $4E71               ; $00F448 NOP
loc_00F44A:
        DC.W    $4E75               ; $00F44A RTS
        DC.W    $4240               ; $00F44C CLR.W  D0
        DC.W    $1038,$A01B         ; $00F44E MOVE.B  $A01B.W,D0
        DC.W    $6100,$0438         ; $00F452 BSR.W  loc_00F88C
        DC.W    $4EB9,$0088,$179E   ; $00F456 JSR     $0088179E
        DC.W    $4A78,$A024         ; $00F45C TST.W  $A024.W
        DC.W    $6600,$01E0         ; $00F460 BNE.W  loc_00F642
        DC.W    $1038,$A019         ; $00F464 MOVE.B  $A019.W,D0
        DC.W    $3238,$C86C         ; $00F468 MOVE.W  $C86C.W,D1
        DC.W    $0801,$0003         ; $00F46C BTST    #3,D1
        DC.W    $6748               ; $00F470 BEQ.S  loc_00F4BA
        DC.W    $11FC,$00A9,$C8A4   ; $00F472 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A38,$A01B         ; $00F478 TST.B  $A01B.W
        DC.W    $6700,$001A         ; $00F47C BEQ.W  loc_00F498
        DC.W    $0C38,$0001,$A01B   ; $00F480 CMPI.B  #$0001,$A01B.W
        DC.W    $6700,$001E         ; $00F486 BEQ.W  loc_00F4A6
        DC.W    $0C00,$0004         ; $00F48A CMPI.B  #$0004,D0
        DC.W    $6D00,$0024         ; $00F48E BLT.W  loc_00F4B4
        DC.W    $4200               ; $00F492 CLR.B  D0
        DC.W    $6000,$00E4         ; $00F494 BRA.W  loc_00F57A
loc_00F498:
        DC.W    $0C00,$0002         ; $00F498 CMPI.B  #$0002,D0
        DC.W    $6D00,$0016         ; $00F49C BLT.W  loc_00F4B4
        DC.W    $4200               ; $00F4A0 CLR.B  D0
        DC.W    $6000,$00D6         ; $00F4A2 BRA.W  loc_00F57A
loc_00F4A6:
        DC.W    $0C00,$0001         ; $00F4A6 CMPI.B  #$0001,D0
        DC.W    $6D00,$0008         ; $00F4AA BLT.W  loc_00F4B4
        DC.W    $4200               ; $00F4AE CLR.B  D0
        DC.W    $6000,$00C8         ; $00F4B0 BRA.W  loc_00F57A
loc_00F4B4:
        DC.W    $5200               ; $00F4B4 ADDQ.B  #1,D0
        DC.W    $6000,$00C2         ; $00F4B6 BRA.W  loc_00F57A
loc_00F4BA:
        DC.W    $0801,$0002         ; $00F4BA BTST    #2,D1
        DC.W    $673C               ; $00F4BE BEQ.S  loc_00F4FC
        DC.W    $11FC,$00A9,$C8A4   ; $00F4C0 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A00               ; $00F4C6 TST.B  D0
        DC.W    $6F00,$0008         ; $00F4C8 BLE.W  loc_00F4D2
        DC.W    $5300               ; $00F4CC SUBQ.B  #1,D0
        DC.W    $6000,$00AA         ; $00F4CE BRA.W  loc_00F57A
loc_00F4D2:
        DC.W    $4A38,$A01B         ; $00F4D2 TST.B  $A01B.W
        DC.W    $6700,$0014         ; $00F4D6 BEQ.W  loc_00F4EC
        DC.W    $0C38,$0001,$A01B   ; $00F4DA CMPI.B  #$0001,$A01B.W
        DC.W    $6700,$0012         ; $00F4E0 BEQ.W  loc_00F4F4
        DC.W    $103C,$0004         ; $00F4E4 MOVE.B  #$0004,D0
        DC.W    $6000,$0090         ; $00F4E8 BRA.W  loc_00F57A
loc_00F4EC:
        DC.W    $103C,$0002         ; $00F4EC MOVE.B  #$0002,D0
        DC.W    $6000,$0088         ; $00F4F0 BRA.W  loc_00F57A
loc_00F4F4:
        DC.W    $103C,$0001         ; $00F4F4 MOVE.B  #$0001,D0
        DC.W    $6000,$0080         ; $00F4F8 BRA.W  loc_00F57A
loc_00F4FC:
        DC.W    $0801,$0000         ; $00F4FC BTST    #0,D1
        DC.W    $6700,$003A         ; $00F500 BEQ.W  loc_00F53C
        DC.W    $4A38,$A01B         ; $00F504 TST.B  $A01B.W
        DC.W    $6700,$0070         ; $00F508 BEQ.W  loc_00F57A
        DC.W    $11FC,$00A9,$C8A4   ; $00F50C MOVE.B  #$00A9,$C8A4.W
        DC.W    $0C38,$0001,$A01B   ; $00F512 CMPI.B  #$0001,$A01B.W
        DC.W    $6712               ; $00F518 BEQ.S  loc_00F52C
        DC.W    $11FC,$0001,$A01B   ; $00F51A MOVE.B  #$0001,$A01B.W
        DC.W    $11C0,$A021         ; $00F520 MOVE.B  D0,$A021.W
        DC.W    $1038,$A020         ; $00F524 MOVE.B  $A020.W,D0
        DC.W    $6000,$0050         ; $00F528 BRA.W  loc_00F57A
loc_00F52C:
        DC.W    $4238,$A01B         ; $00F52C CLR.B  $A01B.W
        DC.W    $11C0,$A020         ; $00F530 MOVE.B  D0,$A020.W
        DC.W    $1038,$A01F         ; $00F534 MOVE.B  $A01F.W,D0
        DC.W    $6000,$0040         ; $00F538 BRA.W  loc_00F57A
loc_00F53C:
        DC.W    $0801,$0001         ; $00F53C BTST    #1,D1
        DC.W    $6700,$0038         ; $00F540 BEQ.W  loc_00F57A
        DC.W    $0C38,$0002,$A01B   ; $00F544 CMPI.B  #$0002,$A01B.W
        DC.W    $6C00,$002E         ; $00F54A BGE.W  loc_00F57A
        DC.W    $11FC,$00A9,$C8A4   ; $00F54E MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A38,$A01B         ; $00F554 TST.B  $A01B.W
        DC.W    $6712               ; $00F558 BEQ.S  loc_00F56C
        DC.W    $11FC,$0002,$A01B   ; $00F55A MOVE.B  #$0002,$A01B.W
        DC.W    $11C0,$A020         ; $00F560 MOVE.B  D0,$A020.W
        DC.W    $1038,$A021         ; $00F564 MOVE.B  $A021.W,D0
        DC.W    $6000,$0010         ; $00F568 BRA.W  loc_00F57A
loc_00F56C:
        DC.W    $11FC,$0001,$A01B   ; $00F56C MOVE.B  #$0001,$A01B.W
        DC.W    $11C0,$A01F         ; $00F572 MOVE.B  D0,$A01F.W
        DC.W    $1038,$A020         ; $00F576 MOVE.B  $A020.W,D0
loc_00F57A:
        DC.W    $11C0,$A019         ; $00F57A MOVE.B  D0,$A019.W
        DC.W    $1038,$A01A         ; $00F57E MOVE.B  $A01A.W,D0
        DC.W    $3238,$C86E         ; $00F582 MOVE.W  $C86E.W,D1
        DC.W    $0801,$0003         ; $00F586 BTST    #3,D1
        DC.W    $6732               ; $00F58A BEQ.S  loc_00F5BE
        DC.W    $11FC,$00A9,$C8A4   ; $00F58C MOVE.B  #$00A9,$C8A4.W
        DC.W    $0C38,$0001,$A01C   ; $00F592 CMPI.B  #$0001,$A01C.W
        DC.W    $6700,$0010         ; $00F598 BEQ.W  loc_00F5AA
        DC.W    $0C00,$0004         ; $00F59C CMPI.B  #$0004,D0
        DC.W    $6D00,$0016         ; $00F5A0 BLT.W  loc_00F5B8
        DC.W    $4200               ; $00F5A4 CLR.B  D0
        DC.W    $6000,$0096         ; $00F5A6 BRA.W  loc_00F63E
loc_00F5AA:
        DC.W    $0C00,$0001         ; $00F5AA CMPI.B  #$0001,D0
        DC.W    $6D00,$0008         ; $00F5AE BLT.W  loc_00F5B8
        DC.W    $4200               ; $00F5B2 CLR.B  D0
        DC.W    $6000,$0088         ; $00F5B4 BRA.W  loc_00F63E
loc_00F5B8:
        DC.W    $5200               ; $00F5B8 ADDQ.B  #1,D0
        DC.W    $6000,$0082         ; $00F5BA BRA.W  loc_00F63E
loc_00F5BE:
        DC.W    $0801,$0002         ; $00F5BE BTST    #2,D1
        DC.W    $672C               ; $00F5C2 BEQ.S  loc_00F5F0
        DC.W    $11FC,$00A9,$C8A4   ; $00F5C4 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A00               ; $00F5CA TST.B  D0
        DC.W    $6F00,$0008         ; $00F5CC BLE.W  loc_00F5D6
        DC.W    $5300               ; $00F5D0 SUBQ.B  #1,D0
        DC.W    $6000,$006A         ; $00F5D2 BRA.W  loc_00F63E
loc_00F5D6:
        DC.W    $0C38,$0001,$A01C   ; $00F5D6 CMPI.B  #$0001,$A01C.W
        DC.W    $6700,$000A         ; $00F5DC BEQ.W  loc_00F5E8
        DC.W    $103C,$0004         ; $00F5E0 MOVE.B  #$0004,D0
        DC.W    $6000,$0058         ; $00F5E4 BRA.W  loc_00F63E
loc_00F5E8:
        DC.W    $103C,$0001         ; $00F5E8 MOVE.B  #$0001,D0
        DC.W    $6000,$0050         ; $00F5EC BRA.W  loc_00F63E
loc_00F5F0:
        DC.W    $0801,$0000         ; $00F5F0 BTST    #0,D1
        DC.W    $6700,$0022         ; $00F5F4 BEQ.W  loc_00F618
        DC.W    $0C38,$0001,$A01C   ; $00F5F8 CMPI.B  #$0001,$A01C.W
        DC.W    $673E               ; $00F5FE BEQ.S  loc_00F63E
        DC.W    $11FC,$00A9,$C8A4   ; $00F600 MOVE.B  #$00A9,$C8A4.W
        DC.W    $11FC,$0001,$A01C   ; $00F606 MOVE.B  #$0001,$A01C.W
        DC.W    $11C0,$A023         ; $00F60C MOVE.B  D0,$A023.W
        DC.W    $1038,$A022         ; $00F610 MOVE.B  $A022.W,D0
        DC.W    $6000,$0028         ; $00F614 BRA.W  loc_00F63E
loc_00F618:
        DC.W    $0801,$0001         ; $00F618 BTST    #1,D1
        DC.W    $6700,$0020         ; $00F61C BEQ.W  loc_00F63E
        DC.W    $0C38,$0002,$A01C   ; $00F620 CMPI.B  #$0002,$A01C.W
        DC.W    $6C00,$0016         ; $00F626 BGE.W  loc_00F63E
        DC.W    $11FC,$00A9,$C8A4   ; $00F62A MOVE.B  #$00A9,$C8A4.W
        DC.W    $11FC,$0002,$A01C   ; $00F630 MOVE.B  #$0002,$A01C.W
        DC.W    $11C0,$A022         ; $00F636 MOVE.B  D0,$A022.W
        DC.W    $1038,$A023         ; $00F63A MOVE.B  $A023.W,D0
loc_00F63E:
        DC.W    $11C0,$A01A         ; $00F63E MOVE.B  D0,$A01A.W
loc_00F642:
        DC.W    $207C,$0603,$8000   ; $00F642 MOVEA.L #$06038000,A0
        DC.W    $227C,$0400,$7010   ; $00F648 MOVEA.L #$04007010,A1
        DC.W    $303C,$0120         ; $00F64E MOVE.W  #$0120,D0
        DC.W    $323C,$0030         ; $00F652 MOVE.W  #$0030,D1
        DC.W    $4EBA,$ED02         ; $00F656 JSR     loc_00E35A(PC)
        DC.W    $45F9,$0088,$F682   ; $00F65A LEA     $0088F682,A2
        DC.W    $343C,$0007         ; $00F660 MOVE.W  #$0007,D2
loc_00F664:
        DC.W    $205A               ; $00F664 MOVEA.L (A2)+,A0
        DC.W    $225A               ; $00F666 MOVEA.L (A2)+,A1
        DC.W    $301A               ; $00F668 MOVE.W  (A2)+,D0
        DC.W    $321A               ; $00F66A MOVE.W  (A2)+,D1
        DC.W    $4EBA,$ECEC         ; $00F66C JSR     loc_00E35A(PC)
        DC.W    $51CA,$FFF2         ; $00F670 DBRA    D2,loc_00F664
        DC.W    $5878,$C87E         ; $00F674 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $00F678 MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $00F680 RTS
        DC.W    $0603,$B600         ; $00F682 ADDI.B  #$B600,D3
        DC.W    $0401,$2024         ; $00F686 SUBI.B  #$2024,D1
        DC.W    $0060,$0010         ; $00F68A ORI.W  #$0010,-(A0)
        DC.W    $0603,$BC00         ; $00F68E ADDI.B  #$BC00,D3
        DC.W    $0401,$4014         ; $00F692 SUBI.B  #$4014,D1
        DC.W    $0080,$0010,$0603   ; $00F696 ORI.L  #$00100603,D0
        DC.W    $C400               ; $00F69C AND.B  D0,D2
        DC.W    $0401,$7030         ; $00F69E SUBI.B  #$7030,D1
        DC.W    $0048,$0010         ; $00F6A2 ORI.W  #$0010,A0
        DC.W    $0603,$C880         ; $00F6A6 ADDI.B  #$C880,D3
        DC.W    $0401,$9018         ; $00F6AA SUBI.B  #$9018,D1
        DC.W    $0078,$0020,$0603   ; $00F6AE ORI.W  #$0020,$0603.W
        DC.W    $B600               ; $00F6B4 CMP.B  D0,D3
        DC.W    $0401,$20BC         ; $00F6B6 SUBI.B  #$20BC,D1
        DC.W    $0060,$0010         ; $00F6BA ORI.W  #$0010,-(A0)
        DC.W    $0603,$BC00         ; $00F6BE ADDI.B  #$BC00,D3
        DC.W    $0401,$40AC         ; $00F6C2 SUBI.B  #$40AC,D1
        DC.W    $0080,$0010,$0603   ; $00F6C6 ORI.L  #$00100603,D0
        DC.W    $C400               ; $00F6CC AND.B  D0,D2
        DC.W    $0401,$70C8         ; $00F6CE SUBI.B  #$70C8,D1
        DC.W    $0048,$0010         ; $00F6D2 ORI.W  #$0010,A0
        DC.W    $0603,$C880         ; $00F6D6 ADDI.B  #$C880,D3
        DC.W    $0401,$90B0         ; $00F6DA SUBI.B  #$90B0,D1
        DC.W    $0078,$0020,$4A39   ; $00F6DE ORI.W  #$0020,$4A39.W
        DC.W    $00A1,$5120,$66F8   ; $00F6E4 ORI.L  #$512066F8,-(A1)
        DC.W    $6100,$022A         ; $00F6EA BSR.W  loc_00F916
        DC.W    $45F9,$0088,$F838   ; $00F6EE LEA     $0088F838,A2
        DC.W    $343C,$0002         ; $00F6F4 MOVE.W  #$0002,D2
loc_00F6F8:
        DC.W    $205A               ; $00F6F8 MOVEA.L (A2)+,A0
        DC.W    $225A               ; $00F6FA MOVEA.L (A2)+,A1
        DC.W    $301A               ; $00F6FC MOVE.W  (A2)+,D0
        DC.W    $321A               ; $00F6FE MOVE.W  (A2)+,D1
        DC.W    $4EBA,$EC58         ; $00F700 JSR     loc_00E35A(PC)
        DC.W    $51CA,$FFF2         ; $00F704 DBRA    D2,loc_00F6F8
        DC.W    $4240               ; $00F708 CLR.W  D0
        DC.W    $1038,$A01B         ; $00F70A MOVE.B  $A01B.W,D0
        DC.W    $6100,$017C         ; $00F70E BSR.W  loc_00F88C
        DC.W    $4EBA,$BF70         ; $00F712 JSR     $00B684(PC)
        DC.W    $4EBA,$BFC2         ; $00F716 JSR     $00B6DA(PC)
        DC.W    $0C78,$0001,$A024   ; $00F71A CMPI.W  #$0001,$A024.W
        DC.W    $6700,$00D6         ; $00F720 BEQ.W  loc_00F7F8
        DC.W    $0C78,$0002,$A024   ; $00F724 CMPI.W  #$0002,$A024.W
        DC.W    $6700,$00E0         ; $00F72A BEQ.W  loc_00F80C
        DC.W    $3238,$C86C         ; $00F72E MOVE.W  $C86C.W,D1
        DC.W    $0201,$00E0         ; $00F732 ANDI.B  #$00E0,D1
        DC.W    $6628               ; $00F736 BNE.S  loc_00F760
        DC.W    $3238,$C86E         ; $00F738 MOVE.W  $C86E.W,D1
        DC.W    $3401               ; $00F73C MOVE.W  D1,D2
        DC.W    $0202,$00E0         ; $00F73E ANDI.B  #$00E0,D2
        DC.W    $661C               ; $00F742 BNE.S  loc_00F760
        DC.W    $0201,$0010         ; $00F744 ANDI.B  #$0010,D1
        DC.W    $6612               ; $00F748 BNE.S  loc_00F75C
        DC.W    $3238,$C86C         ; $00F74A MOVE.W  $C86C.W,D1
        DC.W    $0201,$0010         ; $00F74E ANDI.B  #$0010,D1
        DC.W    $6608               ; $00F752 BNE.S  loc_00F75C
        DC.W    $5978,$C87E         ; $00F754 SUBQ.W  #4,$C87E.W
        DC.W    $6000,$00CE         ; $00F758 BRA.W  loc_00F828
loc_00F75C:
        DC.W    $50F8,$A018         ; $00F75C ST      $A018.W
loc_00F760:
        DC.W    $11FC,$00A8,$C8A4   ; $00F760 MOVE.B  #$00A8,$C8A4.W
        DC.W    $4A38,$A01B         ; $00F766 TST.B  $A01B.W
        DC.W    $671E               ; $00F76A BEQ.S  loc_00F78A
        DC.W    $0C38,$0001,$A01B   ; $00F76C CMPI.B  #$0001,$A01B.W
        DC.W    $672A               ; $00F772 BEQ.S  loc_00F79E
        DC.W    $11F8,$A01F,$FEB3   ; $00F774 MOVE.B  $A01F.W,$FEB3.W
        DC.W    $11F8,$A020,$FEAF   ; $00F77A MOVE.B  $A020.W,$FEAF.W
        DC.W    $11F8,$A019,$FEAD   ; $00F780 MOVE.B  $A019.W,$FEAD.W
        DC.W    $6000,$0028         ; $00F786 BRA.W  loc_00F7B0
loc_00F78A:
        DC.W    $11F8,$A019,$FEB3   ; $00F78A MOVE.B  $A019.W,$FEB3.W
        DC.W    $11F8,$A020,$FEAF   ; $00F790 MOVE.B  $A020.W,$FEAF.W
        DC.W    $11F8,$A021,$FEAD   ; $00F796 MOVE.B  $A021.W,$FEAD.W
        DC.W    $6012               ; $00F79C BRA.S  loc_00F7B0
loc_00F79E:
        DC.W    $11F8,$A01F,$FEB3   ; $00F79E MOVE.B  $A01F.W,$FEB3.W
        DC.W    $11F8,$A019,$FEAF   ; $00F7A4 MOVE.B  $A019.W,$FEAF.W
        DC.W    $11F8,$A021,$FEAD   ; $00F7AA MOVE.B  $A021.W,$FEAD.W
loc_00F7B0:
        DC.W    $0C38,$0001,$A01C   ; $00F7B0 CMPI.B  #$0001,$A01C.W
        DC.W    $670E               ; $00F7B6 BEQ.S  loc_00F7C6
        DC.W    $11F8,$A022,$FEB0   ; $00F7B8 MOVE.B  $A022.W,$FEB0.W
        DC.W    $11F8,$A01A,$FEAE   ; $00F7BE MOVE.B  $A01A.W,$FEAE.W
        DC.W    $600C               ; $00F7C4 BRA.S  loc_00F7D2
loc_00F7C6:
        DC.W    $11F8,$A01A,$FEB0   ; $00F7C6 MOVE.B  $A01A.W,$FEB0.W
        DC.W    $11F8,$A023,$FEAE   ; $00F7CC MOVE.B  $A023.W,$FEAE.W
loc_00F7D2:
        DC.W    $4238,$A01E         ; $00F7D2 CLR.B  $A01E.W
        DC.W    $11FC,$0001,$C809   ; $00F7D6 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00F7DC MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $00F7E2 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00F7E8 MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0002,$A024   ; $00F7EE MOVE.W  #$0002,$A024.W
        DC.W    $6000,$002E         ; $00F7F4 BRA.W  loc_00F824
loc_00F7F8:
        DC.W    $6100,$033C         ; $00F7F8 BSR.W  loc_00FB36
        DC.W    $0838,$0006,$C80E   ; $00F7FC BTST    #6,$C80E.W
        DC.W    $6620               ; $00F802 BNE.S  loc_00F824
        DC.W    $4278,$A024         ; $00F804 CLR.W  $A024.W
        DC.W    $6000,$001A         ; $00F808 BRA.W  loc_00F824
loc_00F80C:
        DC.W    $6100,$0328         ; $00F80C BSR.W  loc_00FB36
        DC.W    $0838,$0007,$C80E   ; $00F810 BTST    #7,$C80E.W
        DC.W    $660C               ; $00F816 BNE.S  loc_00F824
        DC.W    $4278,$A024         ; $00F818 CLR.W  $A024.W
        DC.W    $5878,$C87E         ; $00F81C ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $00F820 BRA.W  loc_00F828
loc_00F824:
        DC.W    $5978,$C87E         ; $00F824 SUBQ.W  #4,$C87E.W
loc_00F828:
        DC.W    $33FC,$0018,$00FF,$0008; $00F828 MOVE.W  #$0018,$00FF0008
        DC.W    $11FC,$0001,$C821   ; $00F830 MOVE.B  #$0001,$C821.W
        DC.W    $4E75               ; $00F836 RTS
        DC.W    $0603,$D780         ; $00F838 ADDI.B  #$D780,D3
        DC.W    $0400,$4C68         ; $00F83C SUBI.B  #$4C68,D0
        DC.W    $0070,$0010,$0603   ; $00F840 ORI.W  #$0010,$03(A0,D0.W)
        DC.W    $DE80               ; $00F846 ADD.L  D0,D7
        DC.W    $0400,$EC2C         ; $00F848 SUBI.B  #$EC2C,D0
        DC.W    $0048,$0010         ; $00F84C ORI.W  #$0010,A0
        DC.W    $0603,$F200         ; $00F850 ADDI.B  #$F200,D3
        DC.W    $0400,$ECC4         ; $00F854 SUBI.B  #$ECC4,D0
        DC.W    $0048,$0010         ; $00F858 ORI.W  #$0010,A0
loc_00F85C:
        DC.W    $4A39,$00A1,$5120   ; $00F85C TST.B  $00A15120
        DC.W    $66F8               ; $00F862 BNE.S  loc_00F85C
        DC.W    $4239,$00A1,$5123   ; $00F864 CLR.B  $00A15123
        DC.W    $31FC,$0000,$C87E   ; $00F86A MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0089,$26D2,$00FF,$0002; $00F870 MOVE.L  #$008926D2,$00FF0002
        DC.W    $4A38,$A018         ; $00F87A TST.B  $A018.W
        DC.W    $660A               ; $00F87E BNE.S  loc_00F88A
        DC.W    $23FC,$0088,$D4B8,$00FF,$0002; $00F880 MOVE.L  #$0088D4B8,$00FF0002
loc_00F88A:
        DC.W    $4E75               ; $00F88A RTS
loc_00F88C:
        DC.W    $41F8,$84A2         ; $00F88C LEA     $84A2.W,A0
        DC.W    $43F8,$84C2         ; $00F890 LEA     $84C2.W,A1
        DC.W    $45F8,$84E2         ; $00F894 LEA     $84E2.W,A2
        DC.W    $4242               ; $00F898 CLR.W  D2
        DC.W    $323C,$0007         ; $00F89A MOVE.W  #$0007,D1
loc_00F89E:
        DC.W    $31BC,$0000,$2000   ; $00F89E MOVE.W  #$0000,$00(A0,D2.W)
        DC.W    $33BC,$0000,$2000   ; $00F8A4 MOVE.W  #$0000,$00(A1,D2.W)
        DC.W    $5442               ; $00F8AA ADDQ.W  #2,D2
        DC.W    $51C9,$FFF0         ; $00F8AC DBRA    D1,loc_00F89E
        DC.W    $41F8,$84C2         ; $00F8B0 LEA     $84C2.W,A0
        DC.W    $4A40               ; $00F8B4 TST.W  D0
        DC.W    $6604               ; $00F8B6 BNE.S  loc_00F8BC
        DC.W    $41F8,$84A2         ; $00F8B8 LEA     $84A2.W,A0
loc_00F8BC:
        DC.W    $47F9,$0088,$F8F6   ; $00F8BC LEA     $0088F8F6,A3
        DC.W    $7200               ; $00F8C2 MOVEQ   #$00,D1
        DC.W    $3238,$A012         ; $00F8C4 MOVE.W  $A012.W,D1
        DC.W    $D241               ; $00F8C8 ADD.W  D1,D1
        DC.W    $D7C1               ; $00F8CA ADDA.L  D1,A3
        DC.W    $4242               ; $00F8CC CLR.W  D2
        DC.W    $323C,$0007         ; $00F8CE MOVE.W  #$0007,D1
loc_00F8D2:
        DC.W    $3193,$2000         ; $00F8D2 MOVE.W  (A3),$00(A0,D2.W)
        DC.W    $359B,$2000         ; $00F8D6 MOVE.W  (A3)+,$00(A2,D2.W)
        DC.W    $5442               ; $00F8DA ADDQ.W  #2,D2
        DC.W    $51C9,$FFF4         ; $00F8DC DBRA    D1,loc_00F8D2
        DC.W    $3238,$A012         ; $00F8E0 MOVE.W  $A012.W,D1
        DC.W    $5241               ; $00F8E4 ADDQ.W  #1,D1
        DC.W    $0C41,$0007         ; $00F8E6 CMPI.W  #$0007,D1
        DC.W    $6F00,$0004         ; $00F8EA BLE.W  loc_00F8F0
        DC.W    $4241               ; $00F8EE CLR.W  D1
loc_00F8F0:
        DC.W    $31C1,$A012         ; $00F8F0 MOVE.W  D1,$A012.W
        DC.W    $4E75               ; $00F8F4 RTS
        DC.W    $0EEE               ; $00F8F6 DC.W    $0EEE
        DC.W    $0EEE               ; $00F8F8 DC.W    $0EEE
        DC.W    $0EEE               ; $00F8FA DC.W    $0EEE
        DC.W    $0EEE               ; $00F8FC DC.W    $0EEE
        DC.W    $0000,$0000         ; $00F8FE ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00F902 ORI.B  #$0000,D0
        DC.W    $0EEE               ; $00F906 DC.W    $0EEE
        DC.W    $0EEE               ; $00F908 DC.W    $0EEE
        DC.W    $0EEE               ; $00F90A DC.W    $0EEE
        DC.W    $0EEE               ; $00F90C DC.W    $0EEE
        DC.W    $0000,$0000         ; $00F90E ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00F912 ORI.B  #$0000,D0
loc_00F916:
        DC.W    $7000               ; $00F916 MOVEQ   #$00,D0
        DC.W    $4A38,$A01B         ; $00F918 TST.B  $A01B.W
        DC.W    $6606               ; $00F91C BNE.S  loc_00F924
        DC.W    $1038,$A019         ; $00F91E MOVE.B  $A019.W,D0
        DC.W    $6004               ; $00F922 BRA.S  loc_00F928
loc_00F924:
        DC.W    $1038,$A01F         ; $00F924 MOVE.B  $A01F.W,D0
loc_00F928:
        DC.W    $43F9,$0088,$FB24   ; $00F928 LEA     $0088FB24,A1
        DC.W    $D040               ; $00F92E ADD.W  D0,D0
        DC.W    $3200               ; $00F930 MOVE.W  D0,D1
        DC.W    $D040               ; $00F932 ADD.W  D0,D0
        DC.W    $D041               ; $00F934 ADD.W  D1,D0
        DC.W    $2071,$0000         ; $00F936 MOVEA.L $00(A1,D0.W),A0
        DC.W    $3031,$0004         ; $00F93A MOVE.W  $04(A1,D0.W),D0
        DC.W    $323C,$0030         ; $00F93E MOVE.W  #$0030,D1
        DC.W    $343C,$0010         ; $00F942 MOVE.W  #$0010,D2
        DC.W    $4EBA,$EA6C         ; $00F946 JSR     loc_00E3B4(PC)
        DC.W    $7000               ; $00F94A MOVEQ   #$00,D0
        DC.W    $0C38,$0001,$A01B   ; $00F94C CMPI.B  #$0001,$A01B.W
        DC.W    $6624               ; $00F952 BNE.S  loc_00F978
        DC.W    $207C,$0401,$2024   ; $00F954 MOVEA.L #$04012024,A0
        DC.W    $303C,$0060         ; $00F95A MOVE.W  #$0060,D0
        DC.W    $323C,$0010         ; $00F95E MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00F962 MOVE.W  #$0010,D2
loc_00F966:
        DC.W    $4A39,$00A1,$5120   ; $00F966 TST.B  $00A15120
        DC.W    $66F8               ; $00F96C BNE.S  loc_00F966
        DC.W    $4EBA,$EA44         ; $00F96E JSR     loc_00E3B4(PC)
        DC.W    $1038,$A019         ; $00F972 MOVE.B  $A019.W,D0
        DC.W    $6004               ; $00F976 BRA.S  loc_00F97C
loc_00F978:
        DC.W    $1038,$A020         ; $00F978 MOVE.B  $A020.W,D0
loc_00F97C:
        DC.W    $207C,$0401,$4014   ; $00F97C MOVEA.L #$04014014,A0
        DC.W    $4A00               ; $00F982 TST.B  D0
        DC.W    $6606               ; $00F984 BNE.S  loc_00F98C
        DC.W    $303C,$0048         ; $00F986 MOVE.W  #$0048,D0
        DC.W    $600A               ; $00F98A BRA.S  loc_00F996
loc_00F98C:
        DC.W    $D1FC,$0000,$0047   ; $00F98C ADDA.L  #$00000047,A0
        DC.W    $303C,$0039         ; $00F992 MOVE.W  #$0039,D0
loc_00F996:
        DC.W    $323C,$0010         ; $00F996 MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00F99A MOVE.W  #$0010,D2
loc_00F99E:
        DC.W    $4A39,$00A1,$5120   ; $00F99E TST.B  $00A15120
        DC.W    $66F8               ; $00F9A4 BNE.S  loc_00F99E
        DC.W    $4EBA,$EA0C         ; $00F9A6 JSR     loc_00E3B4(PC)
        DC.W    $7000               ; $00F9AA MOVEQ   #$00,D0
        DC.W    $0C38,$0002,$A01B   ; $00F9AC CMPI.B  #$0002,$A01B.W
        DC.W    $6642               ; $00F9B2 BNE.S  loc_00F9F6
        DC.W    $207C,$0401,$7030   ; $00F9B4 MOVEA.L #$04017030,A0
        DC.W    $303C,$0048         ; $00F9BA MOVE.W  #$0048,D0
        DC.W    $323C,$0010         ; $00F9BE MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00F9C2 MOVE.W  #$0010,D2
loc_00F9C6:
        DC.W    $4A39,$00A1,$5120   ; $00F9C6 TST.B  $00A15120
        DC.W    $66F8               ; $00F9CC BNE.S  loc_00F9C6
        DC.W    $4EBA,$E9E4         ; $00F9CE JSR     loc_00E3B4(PC)
        DC.W    $207C,$0401,$9018   ; $00F9D2 MOVEA.L #$04019018,A0
        DC.W    $303C,$0078         ; $00F9D8 MOVE.W  #$0078,D0
        DC.W    $323C,$0010         ; $00F9DC MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00F9E0 MOVE.W  #$0010,D2
loc_00F9E4:
        DC.W    $4A39,$00A1,$5120   ; $00F9E4 TST.B  $00A15120
        DC.W    $66F8               ; $00F9EA BNE.S  loc_00F9E4
        DC.W    $4EBA,$E9C6         ; $00F9EC JSR     loc_00E3B4(PC)
        DC.W    $1038,$A019         ; $00F9F0 MOVE.B  $A019.W,D0
        DC.W    $6004               ; $00F9F4 BRA.S  loc_00F9FA
loc_00F9F6:
        DC.W    $1038,$A021         ; $00F9F6 MOVE.B  $A021.W,D0
loc_00F9FA:
        DC.W    $1400               ; $00F9FA MOVE.B  D0,D2
        DC.W    $207C,$0401,$B018   ; $00F9FC MOVEA.L #$0401B018,A0
        DC.W    $D040               ; $00FA02 ADD.W  D0,D0
        DC.W    $D040               ; $00FA04 ADD.W  D0,D0
        DC.W    $D040               ; $00FA06 ADD.W  D0,D0
        DC.W    $3200               ; $00FA08 MOVE.W  D0,D1
        DC.W    $D040               ; $00FA0A ADD.W  D0,D0
        DC.W    $D041               ; $00FA0C ADD.W  D1,D0
        DC.W    $41F0,$0000         ; $00FA0E LEA     $00(A0,D0.W),A0
        DC.W    $303C,$0018         ; $00FA12 MOVE.W  #$0018,D0
        DC.W    $4A02               ; $00FA16 TST.B  D2
        DC.W    $6700,$0008         ; $00FA18 BEQ.W  loc_00FA22
        DC.W    $5388               ; $00FA1C SUBQ.L  #1,A0
        DC.W    $303C,$0019         ; $00FA1E MOVE.W  #$0019,D0
loc_00FA22:
        DC.W    $323C,$0010         ; $00FA22 MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00FA26 MOVE.W  #$0010,D2
loc_00FA2A:
        DC.W    $4A39,$00A1,$5120   ; $00FA2A TST.B  $00A15120
        DC.W    $66F8               ; $00FA30 BNE.S  loc_00FA2A
        DC.W    $4EBA,$E980         ; $00FA32 JSR     loc_00E3B4(PC)
        DC.W    $7000               ; $00FA36 MOVEQ   #$00,D0
        DC.W    $0C38,$0001,$A01C   ; $00FA38 CMPI.B  #$0001,$A01C.W
        DC.W    $6624               ; $00FA3E BNE.S  loc_00FA64
        DC.W    $207C,$0401,$20BC   ; $00FA40 MOVEA.L #$040120BC,A0
        DC.W    $303C,$0060         ; $00FA46 MOVE.W  #$0060,D0
        DC.W    $323C,$0010         ; $00FA4A MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00FA4E MOVE.W  #$0010,D2
loc_00FA52:
        DC.W    $4A39,$00A1,$5120   ; $00FA52 TST.B  $00A15120
        DC.W    $66F8               ; $00FA58 BNE.S  loc_00FA52
        DC.W    $4EBA,$E958         ; $00FA5A JSR     loc_00E3B4(PC)
        DC.W    $1038,$A01A         ; $00FA5E MOVE.B  $A01A.W,D0
        DC.W    $6004               ; $00FA62 BRA.S  loc_00FA68
loc_00FA64:
        DC.W    $1038,$A022         ; $00FA64 MOVE.B  $A022.W,D0
loc_00FA68:
        DC.W    $207C,$0401,$40AC   ; $00FA68 MOVEA.L #$040140AC,A0
        DC.W    $4A00               ; $00FA6E TST.B  D0
        DC.W    $6606               ; $00FA70 BNE.S  loc_00FA78
        DC.W    $303C,$0048         ; $00FA72 MOVE.W  #$0048,D0
        DC.W    $600A               ; $00FA76 BRA.S  loc_00FA82
loc_00FA78:
        DC.W    $D1FC,$0000,$0047   ; $00FA78 ADDA.L  #$00000047,A0
        DC.W    $303C,$0039         ; $00FA7E MOVE.W  #$0039,D0
loc_00FA82:
        DC.W    $323C,$0010         ; $00FA82 MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00FA86 MOVE.W  #$0010,D2
loc_00FA8A:
        DC.W    $4A39,$00A1,$5120   ; $00FA8A TST.B  $00A15120
        DC.W    $66F8               ; $00FA90 BNE.S  loc_00FA8A
        DC.W    $4EBA,$E920         ; $00FA92 JSR     loc_00E3B4(PC)
        DC.W    $7000               ; $00FA96 MOVEQ   #$00,D0
        DC.W    $0C38,$0002,$A01C   ; $00FA98 CMPI.B  #$0002,$A01C.W
        DC.W    $6642               ; $00FA9E BNE.S  loc_00FAE2
        DC.W    $207C,$0401,$70C8   ; $00FAA0 MOVEA.L #$040170C8,A0
        DC.W    $303C,$0048         ; $00FAA6 MOVE.W  #$0048,D0
        DC.W    $323C,$0010         ; $00FAAA MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00FAAE MOVE.W  #$0010,D2
loc_00FAB2:
        DC.W    $4A39,$00A1,$5120   ; $00FAB2 TST.B  $00A15120
        DC.W    $66F8               ; $00FAB8 BNE.S  loc_00FAB2
        DC.W    $4EBA,$E8F8         ; $00FABA JSR     loc_00E3B4(PC)
        DC.W    $207C,$0401,$90B0   ; $00FABE MOVEA.L #$040190B0,A0
        DC.W    $303C,$0078         ; $00FAC4 MOVE.W  #$0078,D0
        DC.W    $323C,$0010         ; $00FAC8 MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00FACC MOVE.W  #$0010,D2
loc_00FAD0:
        DC.W    $4A39,$00A1,$5120   ; $00FAD0 TST.B  $00A15120
        DC.W    $66F8               ; $00FAD6 BNE.S  loc_00FAD0
        DC.W    $4EBA,$E8DA         ; $00FAD8 JSR     loc_00E3B4(PC)
        DC.W    $1038,$A01A         ; $00FADC MOVE.B  $A01A.W,D0
        DC.W    $6004               ; $00FAE0 BRA.S  loc_00FAE6
loc_00FAE2:
        DC.W    $1038,$A023         ; $00FAE2 MOVE.B  $A023.W,D0
loc_00FAE6:
        DC.W    $1400               ; $00FAE6 MOVE.B  D0,D2
        DC.W    $207C,$0401,$B0B0   ; $00FAE8 MOVEA.L #$0401B0B0,A0
        DC.W    $D040               ; $00FAEE ADD.W  D0,D0
        DC.W    $D040               ; $00FAF0 ADD.W  D0,D0
        DC.W    $D040               ; $00FAF2 ADD.W  D0,D0
        DC.W    $3200               ; $00FAF4 MOVE.W  D0,D1
        DC.W    $D040               ; $00FAF6 ADD.W  D0,D0
        DC.W    $D041               ; $00FAF8 ADD.W  D1,D0
        DC.W    $41F0,$0000         ; $00FAFA LEA     $00(A0,D0.W),A0
        DC.W    $303C,$0018         ; $00FAFE MOVE.W  #$0018,D0
        DC.W    $4A02               ; $00FB02 TST.B  D2
        DC.W    $6700,$0008         ; $00FB04 BEQ.W  loc_00FB0E
        DC.W    $5388               ; $00FB08 SUBQ.L  #1,A0
        DC.W    $303C,$0019         ; $00FB0A MOVE.W  #$0019,D0
loc_00FB0E:
        DC.W    $323C,$0010         ; $00FB0E MOVE.W  #$0010,D1
        DC.W    $343C,$0010         ; $00FB12 MOVE.W  #$0010,D2
loc_00FB16:
        DC.W    $4A39,$00A1,$5120   ; $00FB16 TST.B  $00A15120
        DC.W    $66F8               ; $00FB1C BNE.S  loc_00FB16
        DC.W    $4EBA,$E894         ; $00FB1E JSR     loc_00E3B4(PC)
        DC.W    $4E75               ; $00FB22 RTS
        DC.W    $0400,$7010         ; $00FB24 SUBI.B  #$7010,D0
        DC.W    $0060,$0400         ; $00FB28 ORI.W  #$0400,-(A0)
        DC.W    $706F               ; $00FB2C MOVEQ   #$6F,D0
        DC.W    $0061,$0400         ; $00FB2E ORI.W  #$0400,-(A1)
        DC.W    $70CF               ; $00FB32 MOVEQ   #-$31,D0
        DC.W    $0061,$4A39         ; $00FB34 ORI.W  #$4A39,-(A1)
        DC.W    $00A1,$5120,$66F8   ; $00FB38 ORI.L  #$512066F8,-(A1)
        DC.W    $33FC,$001C,$00A1,$5110; $00FB3E MOVE.W  #$001C,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $00FB46 MOVE.B  #$0004,$00A15107
        DC.W    $4239,$00A1,$5123   ; $00FB4E CLR.B  $00A15123
        DC.W    $13FC,$002D,$00A1,$5121; $00FB54 MOVE.B  #$002D,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00FB5C MOVE.B  #$0001,$00A15120
loc_00FB64:
        DC.W    $0839,$0001,$00A1,$5123; $00FB64 BTST    #1,$00A15123
        DC.W    $67F6               ; $00FB6C BEQ.S  loc_00FB64
        DC.W    $08B9,$0001,$00A1,$5123; $00FB6E BCLR    #1,$00A15123
        DC.W    $43F9,$00FF,$60C8   ; $00FB76 LEA     $00FF60C8,A1
        DC.W    $45F9,$00A1,$5112   ; $00FB7C LEA     $00A15112,A2
        DC.W    $3E3C,$001B         ; $00FB82 MOVE.W  #$001B,D7
loc_00FB86:
        DC.W    $0839,$0007,$00A1,$5107; $00FB86 BTST    #7,$00A15107
        DC.W    $66F6               ; $00FB8E BNE.S  loc_00FB86
        DC.W    $3499               ; $00FB90 MOVE.W  (A1)+,(A2)
        DC.W    $51CF,$FFF2         ; $00FB92 DBRA    D7,loc_00FB86
        DC.W    $4E75               ; $00FB96 RTS
        DC.W    $33FC,$002C,$00FF,$0008; $00FB98 MOVE.W  #$002C,$00FF0008
        DC.W    $31FC,$002C,$C87A   ; $00FBA0 MOVE.W  #$002C,$C87A.W
        DC.W    $08B8,$0006,$C875   ; $00FBA6 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00FBAC MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $00FBB0 MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $00FBB8 ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$26C8   ; $00FBC0 JSR     $008826C8
        DC.W    $203C,$000A,$0907   ; $00FBC6 MOVE.L  #$000A0907,D0
        DC.W    $4EB9,$0088,$14BE   ; $00FBCC JSR     $008814BE
        DC.W    $11FC,$0001,$C80D   ; $00FBD2 MOVE.B  #$0001,$C80D.W
        DC.W    $31FC,$0000,$A014   ; $00FBD8 MOVE.W  #$0000,$A014.W
        DC.W    $0838,$0004,$C80E   ; $00FBDE BTST    #4,$C80E.W
        DC.W    $6600,$017E         ; $00FBE4 BNE.W  loc_00FD64
        DC.W    $0838,$0005,$C80E   ; $00FBE8 BTST    #5,$C80E.W
        DC.W    $6600,$0174         ; $00FBEE BNE.W  loc_00FD64
        DC.W    $0838,$0007,$FDA8   ; $00FBF2 BTST    #7,$FDA8.W
        DC.W    $6600,$016A         ; $00FBF8 BNE.W  loc_00FD64
        DC.W    $2038,$C260         ; $00FBFC MOVE.L  $C260.W,D0
        DC.W    $0C80,$6000,$0000   ; $00FC00 CMPI.L  #$60000000,D0
        DC.W    $6C00,$00D6         ; $00FC06 BGE.W  loc_00FCDE
        DC.W    $11FC,$0000,$A021   ; $00FC0A MOVE.B  #$0000,$A021.W
        DC.W    $3038,$C0A2         ; $00FC10 MOVE.W  $C0A2.W,D0
        DC.W    $3238,$C0A4         ; $00FC14 MOVE.W  $C0A4.W,D1
        DC.W    $B240               ; $00FC18 CMP.W  D0,D1
        DC.W    $6500,$000A         ; $00FC1A BCS.W  loc_00FC26
        DC.W    $11FC,$0001,$A021   ; $00FC1E MOVE.B  #$0001,$A021.W
        DC.W    $3001               ; $00FC24 MOVE.W  D1,D0
loc_00FC26:
        DC.W    $3238,$C0A6         ; $00FC26 MOVE.W  $C0A6.W,D1
        DC.W    $B240               ; $00FC2A CMP.W  D0,D1
        DC.W    $6500,$000A         ; $00FC2C BCS.W  loc_00FC38
        DC.W    $11FC,$0002,$A021   ; $00FC30 MOVE.B  #$0002,$A021.W
        DC.W    $3001               ; $00FC36 MOVE.W  D1,D0
loc_00FC38:
        DC.W    $3238,$C0A8         ; $00FC38 MOVE.W  $C0A8.W,D1
        DC.W    $B240               ; $00FC3C CMP.W  D0,D1
        DC.W    $6500,$0008         ; $00FC3E BCS.W  loc_00FC48
        DC.W    $11FC,$0003,$A021   ; $00FC42 MOVE.B  #$0003,$A021.W
loc_00FC48:
        DC.W    $7000               ; $00FC48 MOVEQ   #$00,D0
        DC.W    $7200               ; $00FC4A MOVEQ   #$00,D1
        DC.W    $1038,$FEB1         ; $00FC4C MOVE.B  $FEB1.W,D0
        DC.W    $670C               ; $00FC50 BEQ.S  loc_00FC5E
        DC.W    $5340               ; $00FC52 SUBQ.W  #1,D0
loc_00FC54:
        DC.W    $0681,$0000,$03C0   ; $00FC54 ADDI.L  #$000003C0,D1
        DC.W    $51C8,$FFF8         ; $00FC5A DBRA    D0,loc_00FC54
loc_00FC5E:
        DC.W    $41F8,$EF08         ; $00FC5E LEA     $EF08.W,A0
        DC.W    $D1C1               ; $00FC62 ADDA.L  D1,A0
        DC.W    $7000               ; $00FC64 MOVEQ   #$00,D0
        DC.W    $1038,$FEA5         ; $00FC66 MOVE.B  $FEA5.W,D0
        DC.W    $D040               ; $00FC6A ADD.W  D0,D0
        DC.W    $D040               ; $00FC6C ADD.W  D0,D0
        DC.W    $D040               ; $00FC6E ADD.W  D0,D0
        DC.W    $D040               ; $00FC70 ADD.W  D0,D0
        DC.W    $3200               ; $00FC72 MOVE.W  D0,D1
        DC.W    $D040               ; $00FC74 ADD.W  D0,D0
        DC.W    $D040               ; $00FC76 ADD.W  D0,D0
        DC.W    $D041               ; $00FC78 ADD.W  D1,D0
        DC.W    $D040               ; $00FC7A ADD.W  D0,D0
        DC.W    $D1C0               ; $00FC7C ADDA.L  D0,A0
        DC.W    $2038,$C260         ; $00FC7E MOVE.L  $C260.W,D0
        DC.W    $B0A8,$009C         ; $00FC82 CMP.L  $009C(A0),D0
        DC.W    $6200,$0056         ; $00FC86 BHI.W  loc_00FCDE
        DC.W    $7200               ; $00FC8A MOVEQ   #$00,D1
        DC.W    $343C,$0013         ; $00FC8C MOVE.W  #$0013,D2
        DC.W    $1A38,$A021         ; $00FC90 MOVE.B  $A021.W,D5
loc_00FC94:
        DC.W    $B0B0,$1004         ; $00FC94 CMP.L  $04(A0,D1.W),D0
        DC.W    $6500,$000C         ; $00FC98 BCS.W  loc_00FCA6
        DC.W    $5041               ; $00FC9C ADDQ.W  #8,D1
        DC.W    $51CA,$FFF4         ; $00FC9E DBRA    D2,loc_00FC94
        DC.W    $6000,$003A         ; $00FCA2 BRA.W  loc_00FCDE
loc_00FCA6:
        DC.W    $11FC,$0001,$A014   ; $00FCA6 MOVE.B  #$0001,$A014.W
        DC.W    $363C,$0013         ; $00FCAC MOVE.W  #$0013,D3
        DC.W    $9642               ; $00FCB0 SUB.W  D2,D3
        DC.W    $31C3,$A022         ; $00FCB2 MOVE.W  D3,$A022.W
        DC.W    $21C8,$A018         ; $00FCB6 MOVE.L  A0,$A018.W
        DC.W    $0281,$0000,$FFFF   ; $00FCBA ANDI.L  #$0000FFFF,D1
        DC.W    $D3B8,$A018         ; $00FCC0 ADD.L  D1,$A018.W
loc_00FCC4:
        DC.W    $2630,$1000         ; $00FCC4 MOVE.L  $00(A0,D1.W),D3
        DC.W    $2830,$1004         ; $00FCC8 MOVE.L  $04(A0,D1.W),D4
        DC.W    $2185,$1000         ; $00FCCC MOVE.L  D5,$00(A0,D1.W)
        DC.W    $2180,$1004         ; $00FCD0 MOVE.L  D0,$04(A0,D1.W)
        DC.W    $2004               ; $00FCD4 MOVE.L  D4,D0
        DC.W    $2A03               ; $00FCD6 MOVE.L  D3,D5
        DC.W    $5041               ; $00FCD8 ADDQ.W  #8,D1
        DC.W    $51CA,$FFE8         ; $00FCDA DBRA    D2,loc_00FCC4
loc_00FCDE:
        DC.W    $41F8,$C200         ; $00FCDE LEA     $C200.W,A0
        DC.W    $203C,$6000,$0000   ; $00FCE2 MOVE.L  #$60000000,D0
        DC.W    $363C,$0013         ; $00FCE8 MOVE.W  #$0013,D3
loc_00FCEC:
        DC.W    $2218               ; $00FCEC MOVE.L  (A0)+,D1
        DC.W    $6706               ; $00FCEE BEQ.S  loc_00FCF6
        DC.W    $B081               ; $00FCF0 CMP.L  D1,D0
        DC.W    $6F02               ; $00FCF2 BLE.S  loc_00FCF6
        DC.W    $2001               ; $00FCF4 MOVE.L  D1,D0
loc_00FCF6:
        DC.W    $0682,$0000,$0D80   ; $00FCF6 ADDI.L  #$00000D80,D2
        DC.W    $51CB,$FFEE         ; $00FCFC DBRA    D3,loc_00FCEC
        DC.W    $2400               ; $00FD00 MOVE.L  D0,D2
        DC.W    $41F8,$FA48         ; $00FD02 LEA     $FA48.W,A0
        DC.W    $7000               ; $00FD06 MOVEQ   #$00,D0
        DC.W    $1038,$FEB1         ; $00FD08 MOVE.B  $FEB1.W,D0
        DC.W    $D040               ; $00FD0C ADD.W  D0,D0
        DC.W    $D040               ; $00FD0E ADD.W  D0,D0
        DC.W    $D040               ; $00FD10 ADD.W  D0,D0
        DC.W    $3200               ; $00FD12 MOVE.W  D0,D1
        DC.W    $D040               ; $00FD14 ADD.W  D0,D0
        DC.W    $D041               ; $00FD16 ADD.W  D1,D0
        DC.W    $D040               ; $00FD18 ADD.W  D0,D0
        DC.W    $D1C0               ; $00FD1A ADDA.L  D0,A0
        DC.W    $7000               ; $00FD1C MOVEQ   #$00,D0
        DC.W    $1038,$FEA5         ; $00FD1E MOVE.B  $FEA5.W,D0
        DC.W    $D040               ; $00FD22 ADD.W  D0,D0
        DC.W    $D040               ; $00FD24 ADD.W  D0,D0
        DC.W    $D040               ; $00FD26 ADD.W  D0,D0
        DC.W    $5840               ; $00FD28 ADDQ.W  #4,D0
        DC.W    $B4B0,$0000         ; $00FD2A CMP.L  $00(A0,D0.W),D2
        DC.W    $6200,$001C         ; $00FD2E BHI.W  loc_00FD4C
        DC.W    $5438,$A014         ; $00FD32 ADDQ.B  #2,$A014.W
        DC.W    $21C8,$A01C         ; $00FD36 MOVE.L  A0,$A01C.W
        DC.W    $0280,$0000,$FFFF   ; $00FD3A ANDI.L  #$0000FFFF,D0
        DC.W    $D1B8,$A01C         ; $00FD40 ADD.L  D0,$A01C.W
        DC.W    $59B8,$A01C         ; $00FD44 SUBQ.L  #4,$A01C.W
        DC.W    $2182,$0000         ; $00FD48 MOVE.L  D2,$00(A0,D0.W)
loc_00FD4C:
        DC.W    $21F8,$C260,$A032   ; $00FD4C MOVE.L  $C260.W,$A032.W
        DC.W    $2038,$C260         ; $00FD52 MOVE.L  $C260.W,D0
        DC.W    $0C80,$6000,$0000   ; $00FD56 CMPI.L  #$60000000,D0
        DC.W    $6C00,$0006         ; $00FD5C BGE.W  loc_00FD64
        DC.W    $6000,$00A2         ; $00FD60 BRA.W  loc_00FE04
loc_00FD64:
        DC.W    $41F8,$C200         ; $00FD64 LEA     $C200.W,A0
        DC.W    $303C,$0013         ; $00FD68 MOVE.W  #$0013,D0
loc_00FD6C:
        DC.W    $4A90               ; $00FD6C TST.L  (A0)
        DC.W    $6700,$0008         ; $00FD6E BEQ.W  loc_00FD78
        DC.W    $5888               ; $00FD72 ADDQ.L  #4,A0
        DC.W    $51C8,$FFF6         ; $00FD74 DBRA    D0,loc_00FD6C
loc_00FD78:
        DC.W    $42B8,$A032         ; $00FD78 CLR.L  $A032.W
        DC.W    $41F8,$A032         ; $00FD7C LEA     $A032.W,A0
        DC.W    $43F8,$C200         ; $00FD80 LEA     $C200.W,A1
        DC.W    $343C,$0013         ; $00FD84 MOVE.W  #$0013,D2
loc_00FD88:
        DC.W    $0600,$0000         ; $00FD88 ADDI.B  #$0000,D0
        DC.W    $1028,$0003         ; $00FD8C MOVE.B  $0003(A0),D0
        DC.W    $1229,$0003         ; $00FD90 MOVE.B  $0003(A1),D1
        DC.W    $C101               ; $00FD94 AND.B  D0,D1
        DC.W    $1140,$0003         ; $00FD96 MOVE.B  D0,$0003(A0)
        DC.W    $1028,$0002         ; $00FD9A MOVE.B  $0002(A0),D0
        DC.W    $1229,$0002         ; $00FD9E MOVE.B  $0002(A1),D1
        DC.W    $C101               ; $00FDA2 AND.B  D0,D1
        DC.W    $1200               ; $00FDA4 MOVE.B  D0,D1
        DC.W    $0200,$000F         ; $00FDA6 ANDI.B  #$000F,D0
        DC.W    $1140,$0002         ; $00FDAA MOVE.B  D0,$0002(A0)
        DC.W    $E809               ; $00FDAE LSR.B  #4,D1
        DC.W    $0600,$0000         ; $00FDB0 ADDI.B  #$0000,D0
        DC.W    $1028,$0001         ; $00FDB4 MOVE.B  $0001(A0),D0
        DC.W    $C101               ; $00FDB8 AND.B  D0,D1
        DC.W    $1229,$0001         ; $00FDBA MOVE.B  $0001(A1),D1
        DC.W    $C101               ; $00FDBE AND.B  D0,D1
        DC.W    $6400,$0012         ; $00FDC0 BCC.W  loc_00FDD4
        DC.W    $0600,$0000         ; $00FDC4 ADDI.B  #$0000,D0
        DC.W    $123C,$0040         ; $00FDC8 MOVE.B  #$0040,D1
        DC.W    $C101               ; $00FDCC AND.B  D0,D1
        DC.W    $123C,$0001         ; $00FDCE MOVE.B  #$0001,D1
        DC.W    $6018               ; $00FDD2 BRA.S  loc_00FDEC
loc_00FDD4:
        DC.W    $4201               ; $00FDD4 CLR.B  D1
        DC.W    $0C00,$0060         ; $00FDD6 CMPI.B  #$0060,D0
        DC.W    $6500,$0010         ; $00FDDA BCS.W  loc_00FDEC
        DC.W    $0600,$0000         ; $00FDDE ADDI.B  #$0000,D0
        DC.W    $123C,$0060         ; $00FDE2 MOVE.B  #$0060,D1
        DC.W    $8101               ; $00FDE6 OR.B   D0,D1
        DC.W    $123C,$0001         ; $00FDE8 MOVE.B  #$0001,D1
loc_00FDEC:
        DC.W    $1140,$0001         ; $00FDEC MOVE.B  D0,$0001(A0)
        DC.W    $0600,$0000         ; $00FDF0 ADDI.B  #$0000,D0
        DC.W    $1010               ; $00FDF4 MOVE.B  (A0),D0
        DC.W    $C101               ; $00FDF6 AND.B  D0,D1
        DC.W    $1211               ; $00FDF8 MOVE.B  (A1),D1
        DC.W    $C101               ; $00FDFA AND.B  D0,D1
        DC.W    $1080               ; $00FDFC MOVE.B  D0,(A0)
        DC.W    $5889               ; $00FDFE ADDQ.L  #4,A1
        DC.W    $51CA,$FF86         ; $00FE00 DBRA    D2,loc_00FD88
loc_00FE04:
        DC.W    $4A38,$A014         ; $00FE04 TST.B  $A014.W
        DC.W    $6600,$0024         ; $00FE08 BNE.W  loc_00FE2E
        DC.W    $31FC,$0000,$C87E   ; $00FE0C MOVE.W  #$0000,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $00FE12 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0089,$09AE,$00FF,$0002; $00FE1A MOVE.L  #$008909AE,$00FF0002
        DC.W    $4239,$00A1,$5123   ; $00FE24 CLR.B  $00A15123
        DC.W    $6000,$0256         ; $00FE2A BRA.W  loc_010082
loc_00FE2E:
        DC.W    $7000               ; $00FE2E MOVEQ   #$00,D0
        DC.W    $41F8,$8480         ; $00FE30 LEA     $8480.W,A0
        DC.W    $721F               ; $00FE34 MOVEQ   #$1F,D1
loc_00FE36:
        DC.W    $20C0               ; $00FE36 MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $00FE38 DBRA    D1,loc_00FE36
        DC.W    $41F9,$00FF,$7B80   ; $00FE3C LEA     $00FF7B80,A0
        DC.W    $727F               ; $00FE42 MOVEQ   #$7F,D1
loc_00FE44:
        DC.W    $20C0               ; $00FE44 MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $00FE46 DBRA    D1,loc_00FE44
        DC.W    $2ABC,$6000,$0002   ; $00FE4A MOVE.L  #$60000002,(A5)
        DC.W    $323C,$17FF         ; $00FE50 MOVE.W  #$17FF,D1
loc_00FE54:
        DC.W    $2C80               ; $00FE54 MOVE.L  D0,(A6)
        DC.W    $51C9,$FFFC         ; $00FE56 DBRA    D1,loc_00FE54
        DC.W    $4EB9,$0088,$49AA   ; $00FE5A JSR     $008849AA
        DC.W    $4278,$C880         ; $00FE60 CLR.W  $C880.W
        DC.W    $4278,$C882         ; $00FE64 CLR.W  $C882.W
        DC.W    $4278,$8000         ; $00FE68 CLR.W  $8000.W
        DC.W    $4278,$8002         ; $00FE6C CLR.W  $8002.W
        DC.W    $4278,$A012         ; $00FE70 CLR.W  $A012.W
        DC.W    $4EB9,$0088,$49AA   ; $00FE74 JSR     $008849AA
        DC.W    $21FC,$008B,$B4FC,$C96C; $00FE7A MOVE.L  #$008BB4FC,$C96C.W
        DC.W    $11FC,$0001,$C809   ; $00FE82 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00FE88 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $00FE8E BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00FE94 MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0001,$A036   ; $00FE9A MOVE.W  #$0001,$A036.W
        DC.W    $41F9,$00FF,$1000   ; $00FEA0 LEA     $00FF1000,A0
        DC.W    $303C,$037F         ; $00FEA6 MOVE.W  #$037F,D0
loc_00FEAA:
        DC.W    $4298               ; $00FEAA CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $00FEAC DBRA    D0,loc_00FEAA
        DC.W    $303C,$0001         ; $00FEB0 MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $00FEB4 MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $00FEB8 MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $00FEBC MOVE.W  #$0026,D3
        DC.W    $383C,$001A         ; $00FEC0 MOVE.W  #$001A,D4
        DC.W    $41F9,$00FF,$1000   ; $00FEC4 LEA     $00FF1000,A0
        DC.W    $4EBA,$E360         ; $00FECA JSR     loc_00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $00FECE LEA     $00FF1000,A0
        DC.W    $4EBA,$E41A         ; $00FED4 JSR     loc_00E2F0(PC)
        DC.W    $4EBA,$E2E2         ; $00FED8 JSR     $00E1BC(PC)
        DC.W    $08B9,$0007,$00A1,$5181; $00FEDC BCLR    #7,$00A15181
        DC.W    $41F9,$00FF,$6E00   ; $00FEE4 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0160   ; $00FEEA ADDA.L  #$00000160,A0
        DC.W    $43F9,$0089,$00A8   ; $00FEF0 LEA     $008900A8,A1
        DC.W    $303C,$003F         ; $00FEF6 MOVE.W  #$003F,D0
loc_00FEFA:
        DC.W    $3219               ; $00FEFA MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $00FEFC BSET    #15,D1
        DC.W    $30C1               ; $00FF00 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $00FF02 DBRA    D0,loc_00FEFA
        DC.W    $41F9,$000F,$3D80   ; $00FF06 LEA     $000F3D80,A0
        DC.W    $227C,$0601,$4000   ; $00FF0C MOVEA.L #$06014000,A1
        DC.W    $4EBA,$E402         ; $00FF12 JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$CC90   ; $00FF16 LEA     $000ECC90,A0
        DC.W    $227C,$0601,$9000   ; $00FF1C MOVEA.L #$06019000,A1
        DC.W    $4EBA,$E3F2         ; $00FF22 JSR     loc_00E316(PC)
        DC.W    $7000               ; $00FF26 MOVEQ   #$00,D0
        DC.W    $1038,$FEB1         ; $00FF28 MOVE.B  $FEB1.W,D0
        DC.W    $D080               ; $00FF2C ADD.L  D0,D0
        DC.W    $D080               ; $00FF2E ADD.L  D0,D0
        DC.W    $41F9,$0089,$0084   ; $00FF30 LEA     $00890084,A0
        DC.W    $2070,$0000         ; $00FF36 MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0601,$9700   ; $00FF3A MOVEA.L #$06019700,A1
        DC.W    $4EBA,$E3D4         ; $00FF40 JSR     loc_00E316(PC)
        DC.W    $7000               ; $00FF44 MOVEQ   #$00,D0
        DC.W    $1038,$FEA5         ; $00FF46 MOVE.B  $FEA5.W,D0
        DC.W    $D080               ; $00FF4A ADD.L  D0,D0
        DC.W    $D080               ; $00FF4C ADD.L  D0,D0
        DC.W    $41F9,$0089,$0090   ; $00FF4E LEA     $00890090,A0
        DC.W    $2070,$0000         ; $00FF54 MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0601,$9C80   ; $00FF58 MOVEA.L #$06019C80,A1
        DC.W    $4EBA,$E3B6         ; $00FF5E JSR     loc_00E316(PC)
        DC.W    $41F9,$000F,$4620   ; $00FF62 LEA     $000F4620,A0
        DC.W    $227C,$0601,$A200   ; $00FF68 MOVEA.L #$0601A200,A1
        DC.W    $4EBA,$E3A6         ; $00FF6E JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$BB40   ; $00FF72 LEA     $000EBB40,A0
        DC.W    $227C,$0602,$0000   ; $00FF78 MOVEA.L #$06020000,A1
        DC.W    $4EBA,$E396         ; $00FF7E JSR     loc_00E316(PC)
        DC.W    $41F9,$000E,$B980   ; $00FF82 LEA     $000EB980,A0
        DC.W    $227C,$0602,$3200   ; $00FF88 MOVEA.L #$06023200,A1
        DC.W    $4EBA,$E386         ; $00FF8E JSR     loc_00E316(PC)
        DC.W    $41F9,$000F,$4E40   ; $00FF92 LEA     $000F4E40,A0
        DC.W    $227C,$0602,$4000   ; $00FF98 MOVEA.L #$06024000,A1
        DC.W    $4EBA,$E376         ; $00FF9E JSR     loc_00E316(PC)
        DC.W    $11FC,$0000,$A020   ; $00FFA2 MOVE.B  #$0000,$A020.W
        DC.W    $31FC,$0041,$A024   ; $00FFA8 MOVE.W  #$0041,$A024.W
        DC.W    $31FC,$0000,$A026   ; $00FFAE MOVE.W  #$0000,$A026.W
        DC.W    $31FC,$0000,$A028   ; $00FFB4 MOVE.W  #$0000,$A028.W
        DC.W    $11FC,$00FF,$A02A   ; $00FFBA MOVE.B  #$00FF,$A02A.W
        DC.W    $11FC,$0000,$A02B   ; $00FFC0 MOVE.B  #$0000,$A02B.W
        DC.W    $11FC,$0001,$A02C   ; $00FFC6 MOVE.B  #$0001,$A02C.W
        DC.W    $11FC,$0000,$A02D   ; $00FFCC MOVE.B  #$0000,$A02D.W
        DC.W    $31FC,$000E,$A02E   ; $00FFD2 MOVE.W  #$000E,$A02E.W
        DC.W    $31FC,$004A,$A030   ; $00FFD8 MOVE.W  #$004A,$A030.W
        DC.W    $0838,$0000,$A014   ; $00FFDE BTST    #0,$A014.W
        DC.W    $6700,$0018         ; $00FFE4 BEQ.W  loc_00FFFE
        DC.W    $2078,$A018         ; $00FFE8 MOVEA.L $A018.W,A0
        DC.W    $117C,$0020,$0000   ; $00FFEC MOVE.B  #$0020,$0000(A0)
        DC.W    $117C,$0020,$0001   ; $00FFF2 MOVE.B  #$0020,$0001(A0)
        DC.W    $117C,$0020,$0002   ; $00FFF8 MOVE.B  #$0020,$0002(A0)
loc_00FFFE:
        DC.W    $0838,$0001,$A014   ; $00FFFE BTST    #1,$A014.W
        DC.W    $6700,$0018         ; $010004 BEQ.W  loc_01001E
        DC.W    $2078,$A01C         ; $010008 MOVEA.L $A01C.W,A0
        DC.W    $117C,$0020,$0000   ; $01000C MOVE.B  #$0020,$0000(A0)
        DC.W    $117C,$0020,$0001   ; $010012 MOVE.B  #$0020,$0001(A0)
        DC.W    $117C,$0020,$0002   ; $010018 MOVE.B  #$0020,$0002(A0)
loc_01001E:
        DC.W    $11FC,$0001,$C821   ; $01001E MOVE.B  #$0001,$C821.W
        DC.W    $4EB9,$0088,$204A   ; $010024 JSR     $0088204A
        DC.W    $0239,$00FC,$00A1,$5181; $01002A ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $010032 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $01003A MOVE.W  #$8083,$00A15100
        DC.W    $08F8,$0006,$C875   ; $010042 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $010048 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0018,$00FF,$0008; $01004C MOVE.W  #$0018,$00FF0008
        DC.W    $4EB9,$0088,$4998   ; $010054 JSR     $00884998
        DC.W    $11FC,$0092,$C8A5   ; $01005A MOVE.B  #$0092,$C8A5.W
        DC.W    $31FC,$0000,$C87E   ; $010060 MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0089,$0128,$00FF,$0002; $010066 MOVE.L  #$00890128,$00FF0002
        DC.W    $0838,$0000,$A014   ; $010070 BTST    #0,$A014.W
        DC.W    $660A               ; $010076 BNE.S  loc_010082
        DC.W    $23FC,$0089,$0148,$00FF,$0002; $010078 MOVE.L  #$00890148,$00FF0002
loc_010082:
        DC.W    $4E75               ; $010082 RTS
        DC.W    $000E,$D310         ; $010084 ORI.B  #$D310,A6
        DC.W    $000E,$D440         ; $010088 ORI.B  #$D440,A6
        DC.W    $000E,$D530         ; $01008C ORI.B  #$D530,A6
        DC.W    $000E,$D670         ; $010090 ORI.B  #$D670,A6
        DC.W    $000E,$D7D0         ; $010094 ORI.B  #$D7D0,A6
        DC.W    $000E,$D930         ; $010098 ORI.B  #$D930,A6
        DC.W    $000E,$DA70         ; $01009C ORI.B  #$DA70,A6
        DC.W    $000E,$DBA0         ; $0100A0 ORI.B  #$DBA0,A6
        DC.W    $000E,$DD10         ; $0100A4 ORI.B  #$DD10,A6
        DC.W    $4400               ; $0100A8 NEG.B  D0
        DC.W    $44A3               ; $0100AA NEG.L  -(A3)
        DC.W    $4946               ; $0100AC DC.W    $4946
        DC.W    $4DE9,$1C00         ; $0100AE LEA     $1C00(A1),A6
        DC.W    $28A3               ; $0100B2 MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $0100B4 MOVE.W  D6,$41E9(A2)
        DC.W    $7FFF               ; $0100B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $1C00               ; $0100C0 MOVE.B  D0,D6
        DC.W    $28A3               ; $0100C2 MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $0100C4 MOVE.W  D6,$41E9(A2)
        DC.W    $4400               ; $0100C8 NEG.B  D0
        DC.W    $44A3               ; $0100CA NEG.L  -(A3)
        DC.W    $4946               ; $0100CC DC.W    $4946
        DC.W    $4DE9,$033E         ; $0100CE LEA     $033E(A1),A6
        DC.W    $63FF,$01AF,$00E8   ; $0100D2 BLS.L  $1B001BC
        DC.W    $0815,$1075         ; $0100D8 BTST    #21,(A5)
        DC.W    $18D1               ; $0100DC MOVE.B  (A1),(A4)+
        DC.W    $212D,$21C2         ; $0100DE MOVE.L  $21C2(A5),-(A0)
        DC.W    $2642               ; $0100E2 MOVEA.L D2,A3
        DC.W    $2A62               ; $0100E4 MOVEA.L -(A2),A5
        DC.W    $2EE3               ; $0100E6 MOVE.L  -(A3),(A7)+
        DC.W    $7FFF               ; $0100E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100EE MOVE.W  <EA:3F>,<EA:3F>
loc_0100F0:
        DC.W    $4445               ; $0100F0 NEG.W  D5
        DC.W    $512B,$6212         ; $0100F2 SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $0100F6 BGT.S  loc_0100F0
        DC.W    $7FFF               ; $0100F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0E9A               ; $0100FA DC.W    $0E9A
        DC.W    $7FFF               ; $0100FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $00E1               ; $0100FE DC.W    $00E1
        DC.W    $1100               ; $010100 MOVE.B  D0,-(A0)
        DC.W    $31C6,$5779         ; $010102 MOVE.W  D6,$5779.W
        DC.W    $7FFF               ; $010106 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $010108 ORI.B  #$14AF,(A0)
        DC.W    $294E,$3DED         ; $01010C MOVE.L  A6,$3DED(A4)
loc_010110:
        DC.W    $4445               ; $010110 NEG.W  D5
        DC.W    $512B,$6212         ; $010112 SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $010116 BGT.S  loc_010110
        DC.W    $7FFF               ; $010118 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0E9A               ; $01011A DC.W    $0E9A
        DC.W    $7FFF               ; $01011C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $3B5D,$02DB         ; $01011E MOVE.W  (A5)+,$02DB(A5)
        DC.W    $0277,$01B0,$63FF   ; $010122 ANDI.W  #$01B0,-$01(A7,D6.W)
        DC.W    $4EB9,$0088,$2080   ; $010128 JSR     $00882080
        DC.W    $3038,$C87E         ; $01012E MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $010132 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $010136 JMP     (A1)
        DC.W    $0089,$017A,$0089   ; $010138 ORI.L  #$017A0089,A1
        DC.W    $0244,$0089         ; $01013E ANDI.W  #$0089,D4
        DC.W    $04A2,$0089,$05DE   ; $010142 SUBI.L  #$008905DE,-(A2)
        DC.W    $4EB9,$0088,$2080   ; $010148 JSR     $00882080
        DC.W    $3038,$C87E         ; $01014E MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $010152 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $010156 JMP     (A1)
        DC.W    $0089,$035C,$0089   ; $010158 ORI.L  #$035C0089,A1
        DC.W    $03C4               ; $01015E BSET    D1,D4
        DC.W    $0089,$04A2,$0089   ; $010160 ORI.L  #$04A20089,A1
        DC.W    $05DE               ; $010166 BSET    D2,(A6)+
        DC.W    $4EBA,$B51A         ; $010168 JSR     $00B684(PC)
        DC.W    $0838,$0006,$C80E   ; $01016C BTST    #6,$C80E.W
        DC.W    $6604               ; $010172 BNE.S  loc_010178
        DC.W    $5878,$C87E         ; $010174 ADDQ.W  #4,$C87E.W
loc_010178:
        DC.W    $4E75               ; $010178 RTS
        DC.W    $4240               ; $01017A CLR.W  D0
        DC.W    $6100,$E3AE         ; $01017C BSR.W  loc_00E52C
        DC.W    $4EBA,$B502         ; $010180 JSR     $00B684(PC)
        DC.W    $6100,$0596         ; $010184 BSR.W  $01071C
        DC.W    $207C,$0601,$AA00   ; $010188 MOVEA.L #$0601AA00,A0
        DC.W    $227C,$2400,$C060   ; $01018E MOVEA.L #$2400C060,A1
        DC.W    $303C,$0038         ; $010194 MOVE.W  #$0038,D0
        DC.W    $323C,$0010         ; $010198 MOVE.W  #$0010,D1
        DC.W    $4EBA,$E1BC         ; $01019C JSR     loc_00E35A(PC)
        DC.W    $43F9,$2402,$C0A0   ; $0101A0 LEA     $2402C0A0,A1
        DC.W    $45F8,$A032         ; $0101A6 LEA     $A032.W,A2
        DC.W    $6100,$045A         ; $0101AA BSR.W  $010606
        DC.W    $0838,$0001,$A014   ; $0101AE BTST    #1,$A014.W
        DC.W    $661A               ; $0101B4 BNE.S  loc_0101D0
        DC.W    $207C,$0601,$AD80   ; $0101B6 MOVEA.L #$0601AD80,A0
        DC.W    $227C,$2400,$E050   ; $0101BC MOVEA.L #$2400E050,A1
        DC.W    $303C,$0048         ; $0101C2 MOVE.W  #$0048,D0
        DC.W    $323C,$0010         ; $0101C6 MOVE.W  #$0010,D1
        DC.W    $4EBA,$E18E         ; $0101CA JSR     loc_00E35A(PC)
        DC.W    $6018               ; $0101CE BRA.S  loc_0101E8
loc_0101D0:
        DC.W    $207C,$0601,$B200   ; $0101D0 MOVEA.L #$0601B200,A0
        DC.W    $227C,$2400,$E038   ; $0101D6 MOVEA.L #$2400E038,A1
        DC.W    $303C,$0068         ; $0101DC MOVE.W  #$0068,D0
        DC.W    $323C,$0010         ; $0101E0 MOVE.W  #$0010,D1
        DC.W    $4EBA,$E174         ; $0101E4 JSR     loc_00E35A(PC)
loc_0101E8:
        DC.W    $43F9,$2402,$E0A0   ; $0101E8 LEA     $2402E0A0,A1
        DC.W    $45F8,$C254         ; $0101EE LEA     $C254.W,A2
        DC.W    $6100,$0412         ; $0101F2 BSR.W  $010606
        DC.W    $207C,$0601,$B880   ; $0101F6 MOVEA.L #$0601B880,A0
        DC.W    $227C,$2401,$1050   ; $0101FC MOVEA.L #$24011050,A1
