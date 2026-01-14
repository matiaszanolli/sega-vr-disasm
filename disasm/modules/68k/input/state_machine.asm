; Generated assembly for $004200-$006200
; Branch targets: 287
; Labels: 123
; Format: DC.W with decoded mnemonics as comments

        org     $004200

        DC.W    $CA20               ; $004200 AND.B  -(A0),D5
        DC.W    $7E07               ; $004202 MOVEQ   #$07,D7
        DC.W    $7000               ; $004204 MOVEQ   #$00,D0
        DC.W    $1038,$C30C         ; $004206 MOVE.B  $C30C.W,D0
        DC.W    $3200               ; $00420A MOVE.W  D0,D1
        DC.W    $0C00,$0009         ; $00420C CMPI.B  #$0009,D0
        DC.W    $6F16               ; $004210 BLE.S  loc_004228
        DC.W    $45F9,$00FF,$6830   ; $004212 LEA     $00FF6830,A2
        DC.W    $1547,$0000         ; $004218 MOVE.B  D7,$0000(A2)
        DC.W    $257C,$222E,$A436,$0008; $00421C MOVE.L  #$222EA436,$0008(A2)
        DC.W    $0400,$000A         ; $004224 SUBI.B  #$000A,D0
loc_004228:
        DC.W    $45F9,$00FF,$6820   ; $004228 LEA     $00FF6820,A2
        DC.W    $1547,$0000         ; $00422E MOVE.B  D7,$0000(A2)
        DC.W    $E548               ; $004232 LSL.W  #2,D0
        DC.W    $47F9,$0089,$97C4   ; $004234 LEA     $008997C4,A3
        DC.W    $2573,$0000,$0008   ; $00423A MOVE.L  $00(A3,D0.W),$0008(A2)
        DC.W    $E549               ; $004240 LSL.W  #2,D1
        DC.W    $45F9,$00FF,$6810   ; $004242 LEA     $00FF6810,A2
        DC.W    $47F9,$0089,$9780   ; $004248 LEA     $00899780,A3
        DC.W    $2573,$1000,$0008   ; $00424E MOVE.L  $00(A3,D1.W),$0008(A2)
        DC.W    $43F8,$C260         ; $004254 LEA     $C260.W,A1
        DC.W    $45F9,$00FF,$6860   ; $004258 LEA     $00FF6860,A2
        DC.W    $6120               ; $00425E BSR.S  loc_004280
        DC.W    $43F8,$C254         ; $004260 LEA     $C254.W,A1
        DC.W    $45F9,$00FF,$6870   ; $004264 LEA     $00FF6870,A2
        DC.W    $0C91,$6100,$0000   ; $00426A CMPI.L  #$61000000,(A1)
        DC.W    $6702               ; $004270 BEQ.S  loc_004274
        DC.W    $610C               ; $004272 BSR.S  loc_004280
loc_004274:
        DC.W    $31FC,$0040,$C25C   ; $004274 MOVE.W  #$0040,$C25C.W
        DC.W    $5878,$C07C         ; $00427A ADDQ.W  #4,$C07C.W
        DC.W    $4E75               ; $00427E RTS
loc_004280:
        DC.W    $1019               ; $004280 MOVE.B  (A1)+,D0
        DC.W    $1540,$000A         ; $004282 MOVE.B  D0,$000A(A2)
        DC.W    $E808               ; $004286 LSR.B  #4,D0
        DC.W    $1540,$0009         ; $004288 MOVE.B  D0,$0009(A2)
        DC.W    $1019               ; $00428C MOVE.B  (A1)+,D0
        DC.W    $1540,$000C         ; $00428E MOVE.B  D0,$000C(A2)
        DC.W    $E808               ; $004292 LSR.B  #4,D0
        DC.W    $1540,$000B         ; $004294 MOVE.B  D0,$000B(A2)
        DC.W    $3019               ; $004298 MOVE.W  (A1)+,D0
        DC.W    $1540,$000F         ; $00429A MOVE.B  D0,$000F(A2)
        DC.W    $E848               ; $00429E LSR.W  #4,D0
        DC.W    $1540,$000E         ; $0042A0 MOVE.B  D0,$000E(A2)
        DC.W    $E848               ; $0042A4 LSR.W  #4,D0
        DC.W    $1540,$000D         ; $0042A6 MOVE.B  D0,$000D(A2)
        DC.W    $026A,$0F0F,$000A   ; $0042AA ANDI.W  #$0F0F,$000A(A2)
        DC.W    $02AA,$0F0F,$0F0F,$000C; $0042B0 ANDI.L  #$0F0F0F0F,$000C(A2)
        DC.W    $4E75               ; $0042B8 RTS
        DC.W    $0C78,$0014,$C8AA   ; $0042BA CMPI.W  #$0014,$C8AA.W
        DC.W    $6F3C               ; $0042C0 BLE.S  loc_0042FE
        DC.W    $11FC,$0095,$C8A5   ; $0042C2 MOVE.B  #$0095,$C8A5.W
        DC.W    $31FC,$0000,$C084   ; $0042C8 MOVE.W  #$0000,$C084.W
        DC.W    $5878,$C07C         ; $0042CE ADDQ.W  #4,$C07C.W
        DC.W    $31FC,$0000,$C8AA   ; $0042D2 MOVE.W  #$0000,$C8AA.W
        DC.W    $45F9,$00FF,$6754   ; $0042D8 LEA     $00FF6754,A2
        DC.W    $357C,$FFE0,$0004   ; $0042DE MOVE.W  #$FFE0,$0004(A2)
        DC.W    $357C,$0040,$0006   ; $0042E4 MOVE.W  #$0040,$0006(A2)
        DC.W    $357C,$F600,$0008   ; $0042EA MOVE.W  #$F600,$0008(A2)
        DC.W    $257C,$2229,$5ADE,$0010; $0042F0 MOVE.L  #$22295ADE,$0010(A2)
        DC.W    $357C,$0001,$0000   ; $0042F8 MOVE.W  #$0001,$0000(A2)
loc_0042FE:
        DC.W    $4E75               ; $0042FE RTS
        DC.W    $45F9,$00FF,$6754   ; $004300 LEA     $00FF6754,A2
        DC.W    $5078,$C25C         ; $004306 ADDQ.W  #8,$C25C.W
        DC.W    $3038,$C25C         ; $00430A MOVE.W  $C25C.W,D0
        DC.W    $3540,$0006         ; $00430E MOVE.W  D0,$0006(A2)
        DC.W    $546A,$0004         ; $004312 ADDQ.W  #2,$0004(A2)
        DC.W    $066A,$01C0,$0008   ; $004316 ADDI.W  #$01C0,$0008(A2)
        DC.W    $0C40,$0100         ; $00431C CMPI.W  #$0100,D0
        DC.W    $660A               ; $004320 BNE.S  loc_00432C
        DC.W    $5878,$C07C         ; $004322 ADDQ.W  #4,$C07C.W
        DC.W    $31FC,$0000,$C8AA   ; $004326 MOVE.W  #$0000,$C8AA.W
loc_00432C:
        DC.W    $4E75               ; $00432C RTS
        DC.W    $0C78,$003C,$C8AA   ; $00432E CMPI.W  #$003C,$C8AA.W
        DC.W    $6612               ; $004334 BNE.S  loc_004348
        DC.W    $5878,$C07C         ; $004336 ADDQ.W  #4,$C07C.W
        DC.W    $31FC,$0000,$C8AA   ; $00433A MOVE.W  #$0000,$C8AA.W
        DC.W    $33FC,$0000,$00FF,$6754; $004340 MOVE.W  #$0000,$00FF6754
loc_004348:
        DC.W    $4E75               ; $004348 RTS
        DC.W    $3038,$C084         ; $00434A MOVE.W  $C084.W,D0
        DC.W    $0C40,$000A         ; $00434E CMPI.W  #$000A,D0
        DC.W    $6E30               ; $004352 BGT.S  loc_004384
        DC.W    $5240               ; $004354 ADDQ.W  #1,D0
        DC.W    $31C0,$C084         ; $004356 MOVE.W  D0,$C084.W
        DC.W    $701E               ; $00435A MOVEQ   #$1E,D0
        DC.W    $45F9,$00FF,$6802   ; $00435C LEA     $00FF6802,A2
        DC.W    $916A,$0000         ; $004362 SUB.W  D0,$0000(A2)
        DC.W    $916A,$0010         ; $004366 SUB.W  D0,$0010(A2)
        DC.W    $916A,$0020         ; $00436A SUB.W  D0,$0020(A2)
        DC.W    $916A,$0030         ; $00436E SUB.W  D0,$0030(A2)
        DC.W    $916A,$0040         ; $004372 SUB.W  D0,$0040(A2)
        DC.W    $916A,$0050         ; $004376 SUB.W  D0,$0050(A2)
        DC.W    $916A,$0060         ; $00437A SUB.W  D0,$0060(A2)
        DC.W    $916A,$0070         ; $00437E SUB.W  D0,$0070(A2)
        DC.W    $4E75               ; $004382 RTS
loc_004384:
        DC.W    $5878,$C07C         ; $004384 ADDQ.W  #4,$C07C.W
        DC.W    $31FC,$0000,$C8AA   ; $004388 MOVE.W  #$0000,$C8AA.W
        DC.W    $4E75               ; $00438E RTS
        DC.W    $0C78,$0028,$C8AA   ; $004390 CMPI.W  #$0028,$C8AA.W
        DC.W    $6622               ; $004396 BNE.S  loc_0043BA
        DC.W    $5878,$C07C         ; $004398 ADDQ.W  #4,$C07C.W
        DC.W    $31FC,$0000,$C8AA   ; $00439C MOVE.W  #$0000,$C8AA.W
        DC.W    $11FC,$0001,$C809   ; $0043A2 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $0043A8 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $0043AE BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $0043B4 MOVE.B  #$0001,$C802.W
loc_0043BA:
        DC.W    $4E75               ; $0043BA RTS
        DC.W    $0838,$0007,$C80E   ; $0043BC BTST    #7,$C80E.W
        DC.W    $660A               ; $0043C2 BNE.S  loc_0043CE
        DC.W    $11FC,$00F3,$C822   ; $0043C4 MOVE.B  #$00F3,$C822.W
        DC.W    $5878,$C07C         ; $0043CA ADDQ.W  #4,$C07C.W
loc_0043CE:
        DC.W    $4E75               ; $0043CE RTS
        DC.W    $23FC,$0088,$FB98,$00FF,$0002; $0043D0 MOVE.L  #$0088FB98,$00FF0002
        DC.W    $0838,$0005,$C30E   ; $0043DA BTST    #5,$C30E.W
        DC.W    $6620               ; $0043E0 BNE.S  loc_004402
        DC.W    $21FC,$6000,$0000,$C260; $0043E2 MOVE.L  #$60000000,$C260.W
        DC.W    $43F8,$C200         ; $0043EA LEA     $C200.W,A1
        DC.W    $3028,$002C         ; $0043EE MOVE.W  $002C(A0),D0
        DC.W    $E548               ; $0043F2 LSL.W  #2,D0
        DC.W    $23BC,$0000,$0000,$0000; $0043F4 MOVE.L  #$00000000,$00(A1,D0.W)
        DC.W    $08B8,$0003,$C80E   ; $0043FC BCLR    #3,$C80E.W
loc_004402:
        DC.W    $0238,$007F,$C80E   ; $004402 ANDI.B  #$007F,$C80E.W
        DC.W    $31FC,$0000,$C87E   ; $004408 MOVE.W  #$0000,$C87E.W
        DC.W    $7000               ; $00440E MOVEQ   #$00,D0
        DC.W    $31C0,$C880         ; $004410 MOVE.W  D0,$C880.W
        DC.W    $31C0,$C882         ; $004414 MOVE.W  D0,$C882.W
        DC.W    $33FC,$0020,$00FF,$0008; $004418 MOVE.W  #$0020,$00FF0008
        DC.W    $4EBA,$70A8         ; $004420 JSR     $00B4CA(PC)
        DC.W    $11FC,$0000,$C800   ; $004424 MOVE.B  #$0000,$C800.W
        DC.W    $4EFA,$E464         ; $00442A JMP     $002890(PC)
        DC.W    $31FC,$0001,$C048   ; $00442E MOVE.W  #$0001,$C048.W
        DC.W    $3038,$C07C         ; $004434 MOVE.W  $C07C.W,D0
        DC.W    $227B,$0004         ; $004438 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00443C JMP     (A1)
        DC.W    $0088,$444E,$0088   ; $00443E ORI.L  #$444E0088,A0
        DC.W    $4460               ; $004444 NEG.W  -(A0)
        DC.W    $0088,$4498,$0088   ; $004446 ORI.L  #$44980088,A0
        DC.W    $44A6               ; $00444C NEG.L  -(A6)
        DC.W    $11FC,$0001,$C800   ; $00444E MOVE.B  #$0001,$C800.W
        DC.W    $5878,$C07C         ; $004454 ADDQ.W  #4,$C07C.W
        DC.W    $31FC,$0000,$C8AA   ; $004458 MOVE.W  #$0000,$C8AA.W
        DC.W    $4E75               ; $00445E RTS
        DC.W    $0C78,$0001,$C8AA   ; $004460 CMPI.W  #$0001,$C8AA.W
        DC.W    $6604               ; $004466 BNE.S  loc_00446C
        DC.W    $4EBA,$DBFC         ; $004468 JSR     $002066(PC)
loc_00446C:
        DC.W    $0C78,$003C,$C8AA   ; $00446C CMPI.W  #$003C,$C8AA.W
        DC.W    $6622               ; $004472 BNE.S  loc_004496
        DC.W    $5878,$C07C         ; $004474 ADDQ.W  #4,$C07C.W
        DC.W    $31FC,$0000,$C8AA   ; $004478 MOVE.W  #$0000,$C8AA.W
        DC.W    $11FC,$0001,$C809   ; $00447E MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $004484 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $00448A BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $004490 MOVE.B  #$0001,$C802.W
loc_004496:
        DC.W    $4E75               ; $004496 RTS
        DC.W    $0838,$0007,$C80E   ; $004498 BTST    #7,$C80E.W
        DC.W    $6604               ; $00449E BNE.S  loc_0044A4
        DC.W    $5878,$C07C         ; $0044A0 ADDQ.W  #4,$C07C.W
loc_0044A4:
        DC.W    $4E75               ; $0044A4 RTS
        DC.W    $0238,$0077,$C80E   ; $0044A6 ANDI.B  #$0077,$C80E.W
        DC.W    $31FC,$0000,$C87E   ; $0044AC MOVE.W  #$0000,$C87E.W
        DC.W    $31FC,$0000,$C8A8   ; $0044B2 MOVE.W  #$0000,$C8A8.W
        DC.W    $7000               ; $0044B8 MOVEQ   #$00,D0
        DC.W    $31C0,$C880         ; $0044BA MOVE.W  D0,$C880.W
        DC.W    $31C0,$C882         ; $0044BE MOVE.W  D0,$C882.W
        DC.W    $33FC,$0020,$00FF,$0008; $0044C2 MOVE.W  #$0020,$00FF0008
        DC.W    $0238,$00C7,$C80E   ; $0044CA ANDI.B  #$00C7,$C80E.W
        DC.W    $11FC,$0000,$C800   ; $0044D0 MOVE.B  #$0000,$C800.W
        DC.W    $08B8,$0003,$C80E   ; $0044D6 BCLR    #3,$C80E.W
        DC.W    $23FC,$0089,$09AE,$00FF,$0002; $0044DC MOVE.L  #$008909AE,$00FF0002
        DC.W    $4E75               ; $0044E6 RTS
        DC.W    $31FC,$0001,$C048   ; $0044E8 MOVE.W  #$0001,$C048.W
        DC.W    $3038,$C07C         ; $0044EE MOVE.W  $C07C.W,D0
        DC.W    $227B,$0004         ; $0044F2 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $0044F6 JMP     (A1)
        DC.W    $0088,$4536,$0088   ; $0044F8 ORI.L  #$45360088,A0
        DC.W    $4538               ; $0044FE DC.W    $4538
        DC.W    $0088,$4566,$0088   ; $004500 ORI.L  #$45660088,A0
        DC.W    $4566               ; $004506 DC.W    $4566
        DC.W    $0088,$456C,$0088   ; $004508 ORI.L  #$456C0088,A0
        DC.W    $4638,$0088         ; $00450E NOT.B  $0088.W
        DC.W    $464A               ; $004512 NOT.W  A2
        DC.W    $0088,$465C,$0088   ; $004514 ORI.L  #$465C0088,A0
        DC.W    $4682               ; $00451A NOT.L  D2
        DC.W    $3038,$C8BE         ; $00451C MOVE.W  $C8BE.W,D0
        DC.W    $227B,$0004         ; $004520 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $004524 JMP     (A1)
        DC.W    $0088,$4696,$0088   ; $004526 ORI.L  #$46960088,A0
        DC.W    $46AA,$0088         ; $00452C NOT.L  $0088(A2)
        DC.W    $46EE,$0088         ; $004530 NOT    $0088(A6)
        DC.W    $471E               ; $004534 DC.W    $471E
        DC.W    $4E75               ; $004536 RTS
        DC.W    $4EBA,$6D24         ; $004538 JSR     $00B25E(PC)
        DC.W    $5878,$C07C         ; $00453C ADDQ.W  #4,$C07C.W
        DC.W    $B0FC,$9000         ; $004540 CMPA.W  #$9000,A0
        DC.W    $6610               ; $004544 BNE.S  loc_004556
        DC.W    $11FC,$00AA,$C8A5   ; $004546 MOVE.B  #$00AA,$C8A5.W
        DC.W    $13FC,$0000,$00FF,$6930; $00454C MOVE.B  #$0000,$00FF6930
        DC.W    $4E75               ; $004554 RTS
loc_004556:
        DC.W    $11FC,$00AB,$C8A5   ; $004556 MOVE.B  #$00AB,$C8A5.W
        DC.W    $13FC,$0000,$00FF,$6940; $00455C MOVE.B  #$0000,$00FF6940
        DC.W    $4E75               ; $004564 RTS
        DC.W    $5878,$C07C         ; $004566 ADDQ.W  #4,$C07C.W
        DC.W    $4E75               ; $00456A RTS
        DC.W    $7000               ; $00456C MOVEQ   #$00,D0
        DC.W    $1038,$C819         ; $00456E MOVE.B  $C819.W,D0
        DC.W    $E548               ; $004572 LSL.W  #2,D0
        DC.W    $227B,$0004         ; $004574 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $004578 JMP     (A1)
        DC.W    $0088,$4636,$0088   ; $00457A ORI.L  #$46360088,A0
        DC.W    $458A               ; $004580 DC.W    $458A
        DC.W    $0088,$45CE,$0088   ; $004582 ORI.L  #$45CE0088,A0
        DC.W    $4630,$45F9         ; $004588 NOT.B  -$07(A0,D4.W)
        DC.W    $00FF               ; $00458C DC.W    $00FF
        DC.W    $69E0               ; $00458E BVS.S  loc_004570
        DC.W    $14BC,$0007         ; $004590 MOVE.B  #$0007,(A2)
        DC.W    $357C,$01AE,$0002   ; $004594 MOVE.W  #$01AE,$0002(A2)
        DC.W    $257C,$222E,$DB1A,$0008; $00459A MOVE.L  #$222EDB1A,$0008(A2)
        DC.W    $11FC,$0000,$C816   ; $0045A2 MOVE.B  #$0000,$C816.W
        DC.W    $257C,$0402,$C000,$0004; $0045A8 MOVE.L  #$0402C000,$0004(A2)
        DC.W    $B0FC,$9000         ; $0045B0 CMPA.W  #$9000,A0
        DC.W    $670E               ; $0045B4 BEQ.S  loc_0045C4
        DC.W    $11FC,$0001,$C816   ; $0045B6 MOVE.B  #$0001,$C816.W
        DC.W    $257C,$0403,$8000,$0004; $0045BC MOVE.L  #$04038000,$0004(A2)
loc_0045C4:
        DC.W    $5238,$C819         ; $0045C4 ADDQ.B  #1,$C819.W
        DC.W    $5878,$C07C         ; $0045C8 ADDQ.W  #4,$C07C.W
        DC.W    $4E75               ; $0045CC RTS
        DC.W    $14BC,$0007         ; $0045CE MOVE.B  #$0007,(A2)
        DC.W    $357C,$01AE,$0002   ; $0045D2 MOVE.W  #$01AE,$0002(A2)
        DC.W    $257C,$222E,$DB1A,$0008; $0045D8 MOVE.L  #$222EDB1A,$0008(A2)
        DC.W    $11FC,$0003,$C819   ; $0045E0 MOVE.B  #$0003,$C819.W
        DC.W    $B0FC,$9000         ; $0045E6 CMPA.W  #$9000,A0
        DC.W    $670C               ; $0045EA BEQ.S  loc_0045F8
        DC.W    $2038,$B180         ; $0045EC MOVE.L  $B180.W,D0
        DC.W    $B0B8,$C260         ; $0045F0 CMP.L  $C260.W,D0
        DC.W    $6F24               ; $0045F4 BLE.S  loc_00461A
        DC.W    $600C               ; $0045F6 BRA.S  loc_004604
loc_0045F8:
        DC.W    $2038,$B580         ; $0045F8 MOVE.L  $B580.W,D0
        DC.W    $B0B8,$C260         ; $0045FC CMP.L  $C260.W,D0
        DC.W    $6F02               ; $004600 BLE.S  loc_004604
        DC.W    $6016               ; $004602 BRA.S  loc_00461A
loc_004604:
        DC.W    $11FC,$0001,$C816   ; $004604 MOVE.B  #$0001,$C816.W
        DC.W    $257C,$0403,$8000,$0004; $00460A MOVE.L  #$04038000,$0004(A2)
        DC.W    $31FC,$0000,$B39C   ; $004612 MOVE.W  #$0000,$B39C.W
        DC.W    $4E75               ; $004618 RTS
loc_00461A:
        DC.W    $11FC,$0000,$C816   ; $00461A MOVE.B  #$0000,$C816.W
        DC.W    $257C,$0402,$C000,$0004; $004620 MOVE.L  #$0402C000,$0004(A2)
        DC.W    $31FC,$0000,$B79C   ; $004628 MOVE.W  #$0000,$B79C.W
        DC.W    $4E75               ; $00462E RTS
        DC.W    $11FC,$0003,$C819   ; $004630 MOVE.B  #$0003,$C819.W
        DC.W    $4E75               ; $004636 RTS
        DC.W    $11FC,$00F2,$C822   ; $004638 MOVE.B  #$00F2,$C822.W
        DC.W    $5D79,$00FF,$69E2   ; $00463E SUBQ.W  #6,$00FF69E2
        DC.W    $5878,$C07C         ; $004644 ADDQ.W  #4,$C07C.W
        DC.W    $4E75               ; $004648 RTS
        DC.W    $11FC,$0096,$C8A5   ; $00464A MOVE.B  #$0096,$C8A5.W
        DC.W    $5D79,$00FF,$69E2   ; $004650 SUBQ.W  #6,$00FF69E2
        DC.W    $5878,$C07C         ; $004656 ADDQ.W  #4,$C07C.W
        DC.W    $4E75               ; $00465A RTS
        DC.W    $317C,$0014,$002C   ; $00465C MOVE.W  #$0014,$002C(A0)
        DC.W    $45F9,$00FF,$69E0   ; $004662 LEA     $00FF69E0,A2
        DC.W    $046A,$000A,$0002   ; $004668 SUBI.W  #$000A,$0002(A2)
        DC.W    $0C6A,$00E6,$0002   ; $00466E CMPI.W  #$00E6,$0002(A2)
        DC.W    $6E0A               ; $004674 BGT.S  loc_004680
        DC.W    $357C,$00E6,$0002   ; $004676 MOVE.W  #$00E6,$0002(A2)
        DC.W    $5878,$C07C         ; $00467C ADDQ.W  #4,$C07C.W
loc_004680:
        DC.W    $4E75               ; $004680 RTS
        DC.W    $7000               ; $004682 MOVEQ   #$00,D0
        DC.W    $0838,$0002,$C8AB   ; $004684 BTST    #2,$C8AB.W
        DC.W    $6602               ; $00468A BNE.S  loc_00468E
        DC.W    $7007               ; $00468C MOVEQ   #$07,D0
loc_00468E:
        DC.W    $13C0,$00FF,$69E0   ; $00468E MOVE.B  D0,$00FF69E0
        DC.W    $4E75               ; $004694 RTS
        DC.W    $0C38,$0003,$C819   ; $004696 CMPI.B  #$0003,$C819.W
        DC.W    $660A               ; $00469C BNE.S  loc_0046A8
        DC.W    $5878,$C8BE         ; $00469E ADDQ.W  #4,$C8BE.W
        DC.W    $31FC,$0000,$C8AA   ; $0046A2 MOVE.W  #$0000,$C8AA.W
loc_0046A8:
        DC.W    $4E75               ; $0046A8 RTS
        DC.W    $0C78,$0028,$C8AA   ; $0046AA CMPI.W  #$0028,$C8AA.W
        DC.W    $663A               ; $0046B0 BNE.S  loc_0046EC
        DC.W    $5878,$C8BE         ; $0046B2 ADDQ.W  #4,$C8BE.W
        DC.W    $31FC,$0000,$C8AA   ; $0046B6 MOVE.W  #$0000,$C8AA.W
        DC.W    $11FC,$00AB,$C8A5   ; $0046BC MOVE.B  #$00AB,$C8A5.W
        DC.W    $4A38,$C816         ; $0046C2 TST.B  $C816.W
        DC.W    $6706               ; $0046C6 BEQ.S  loc_0046CE
        DC.W    $11FC,$00AA,$C8A5   ; $0046C8 MOVE.B  #$00AA,$C8A5.W
loc_0046CE:
        DC.W    $11FC,$0001,$C800   ; $0046CE MOVE.B  #$0001,$C800.W
        DC.W    $11FC,$0001,$C809   ; $0046D4 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $0046DA MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $0046E0 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $0046E6 MOVE.B  #$0001,$C802.W
loc_0046EC:
        DC.W    $4E75               ; $0046EC RTS
        DC.W    $31FC,$0001,$C048   ; $0046EE MOVE.W  #$0001,$C048.W
        DC.W    $0838,$0007,$C80E   ; $0046F4 BTST    #7,$C80E.W
        DC.W    $6620               ; $0046FA BNE.S  loc_00471C
        DC.W    $43F8,$B400         ; $0046FC LEA     $B400.W,A1
        DC.W    $45F8,$A400         ; $004700 LEA     $A400.W,A2
        DC.W    $7E1F               ; $004704 MOVEQ   #$1F,D7
loc_004706:
        DC.W    $4CD9,$087F         ; $004706 MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A1)+
        DC.W    $48E2,$FE10         ; $00470A MOVEM.L -(A2),D4/A1/A2/A3/A4/A5/A6/A7
        DC.W    $51CF,$FFF6         ; $00470E DBRA    D7,loc_004706
        DC.W    $11FC,$00F3,$C822   ; $004712 MOVE.B  #$00F3,$C822.W
        DC.W    $5878,$C8BE         ; $004718 ADDQ.W  #4,$C8BE.W
loc_00471C:
        DC.W    $4E75               ; $00471C RTS
        DC.W    $0838,$0005,$C30E   ; $00471E BTST    #5,$C30E.W
        DC.W    $6608               ; $004724 BNE.S  loc_00472E
        DC.W    $21FC,$6000,$0000,$C260; $004726 MOVE.L  #$60000000,$C260.W
loc_00472E:
        DC.W    $0238,$007F,$C80E   ; $00472E ANDI.B  #$007F,$C80E.W
        DC.W    $31FC,$0000,$C87E   ; $004734 MOVE.W  #$0000,$C87E.W
        DC.W    $7000               ; $00473A MOVEQ   #$00,D0
        DC.W    $31C0,$C880         ; $00473C MOVE.W  D0,$C880.W
        DC.W    $31C0,$C882         ; $004740 MOVE.W  D0,$C882.W
        DC.W    $3ABC,$8B00         ; $004744 MOVE.W  #$8B00,(A5)
        DC.W    $31FC,$0000,$C8A8   ; $004748 MOVE.W  #$0000,$C8A8.W
        DC.W    $33FC,$0020,$00FF,$0008; $00474E MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0088,$FB98,$00FF,$0002; $004756 MOVE.L  #$0088FB98,$00FF0002
        DC.W    $11FC,$0000,$C800   ; $004760 MOVE.B  #$0000,$C800.W
        DC.W    $4EFA,$E128         ; $004766 JMP     $002890(PC)
        DC.W    $31FC,$0001,$C048   ; $00476A MOVE.W  #$0001,$C048.W
        DC.W    $3038,$C07C         ; $004770 MOVE.W  $C07C.W,D0
        DC.W    $227B,$0004         ; $004774 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $004778 JMP     (A1)
        DC.W    $0088,$478A,$0088   ; $00477A ORI.L  #$478A0088,A0
        DC.W    $479E               ; $004780 DC.W    $479E
        DC.W    $0088,$47CA,$0088   ; $004782 ORI.L  #$47CA0088,A0
        DC.W    $47E4               ; $004788 LEA     -(A4),A3
        DC.W    $11FC,$0001,$C800   ; $00478A MOVE.B  #$0001,$C800.W
        DC.W    $31FC,$0000,$C8AA   ; $004790 MOVE.W  #$0000,$C8AA.W
        DC.W    $5878,$C07C         ; $004796 ADDQ.W  #4,$C07C.W
        DC.W    $4EFA,$6AC2         ; $00479A JMP     $00B25E(PC)
        DC.W    $0C78,$0028,$C8AA   ; $00479E CMPI.W  #$0028,$C8AA.W
        DC.W    $6622               ; $0047A4 BNE.S  loc_0047C8
        DC.W    $31FC,$0000,$C8AA   ; $0047A6 MOVE.W  #$0000,$C8AA.W
        DC.W    $5878,$C07C         ; $0047AC ADDQ.W  #4,$C07C.W
        DC.W    $11FC,$0001,$C809   ; $0047B0 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $0047B6 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $0047BC BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $0047C2 MOVE.B  #$0001,$C802.W
loc_0047C8:
        DC.W    $4E75               ; $0047C8 RTS
        DC.W    $31FC,$0001,$C048   ; $0047CA MOVE.W  #$0001,$C048.W
        DC.W    $0838,$0007,$C80E   ; $0047D0 BTST    #7,$C80E.W
        DC.W    $660A               ; $0047D6 BNE.S  loc_0047E2
        DC.W    $11FC,$00F3,$C822   ; $0047D8 MOVE.B  #$00F3,$C822.W
        DC.W    $5878,$C07C         ; $0047DE ADDQ.W  #4,$C07C.W
loc_0047E2:
        DC.W    $4E75               ; $0047E2 RTS
        DC.W    $0838,$0005,$C30E   ; $0047E4 BTST    #5,$C30E.W
        DC.W    $6608               ; $0047EA BNE.S  loc_0047F4
        DC.W    $21FC,$6000,$0000,$C260; $0047EC MOVE.L  #$60000000,$C260.W
loc_0047F4:
        DC.W    $0238,$007F,$C80E   ; $0047F4 ANDI.B  #$007F,$C80E.W
        DC.W    $31FC,$0000,$C87E   ; $0047FA MOVE.W  #$0000,$C87E.W
        DC.W    $7000               ; $004800 MOVEQ   #$00,D0
        DC.W    $31C0,$C880         ; $004802 MOVE.W  D0,$C880.W
        DC.W    $31C0,$C882         ; $004806 MOVE.W  D0,$C882.W
        DC.W    $31FC,$0000,$C8A8   ; $00480A MOVE.W  #$0000,$C8A8.W
        DC.W    $33FC,$0020,$00FF,$0008; $004810 MOVE.W  #$0020,$00FF0008
        DC.W    $11FC,$0000,$C800   ; $004818 MOVE.B  #$0000,$C800.W
        DC.W    $23FC,$0088,$FB98,$00FF,$0002; $00481E MOVE.L  #$0088FB98,$00FF0002
        DC.W    $4E75               ; $004828 RTS
        DC.W    $E588               ; $00482A LSL.L  #2,D0
        DC.W    $E448               ; $00482C LSR.W  #2,D0
        DC.W    $0040,$4000         ; $00482E ORI.W  #$4000,D0
        DC.W    $4840               ; $004832 SWAP    D0
        DC.W    $4E75               ; $004834 RTS
        DC.W    $4EBA,$0002         ; $004836 JSR     loc_00483A(PC)
loc_00483A:
        DC.W    $4EBA,$0002         ; $00483A JSR     loc_00483E(PC)
loc_00483E:
        DC.W    $4EBA,$0002         ; $00483E JSR     loc_004842(PC)
loc_004842:
        DC.W    $4EBA,$0002         ; $004842 JSR     loc_004846(PC)
loc_004846:
        DC.W    $22C1               ; $004846 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004848 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00484A MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00484C MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00484E MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004850 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004852 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004854 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004856 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004858 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00485A MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00485C MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00485E MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004860 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004862 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004864 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004866 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004868 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00486A MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00486C MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00486E MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004870 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004872 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004874 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004876 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004878 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00487A MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00487C MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00487E MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004880 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004882 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $004884 MOVE.L  D1,(A1)+
        DC.W    $4E75               ; $004886 RTS
        DC.W    $2C81               ; $004888 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $00488A MOVE.L  D1,(A6)
        DC.W    $2C81               ; $00488C MOVE.L  D1,(A6)
        DC.W    $2C81               ; $00488E MOVE.L  D1,(A6)
        DC.W    $2C81               ; $004890 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $004892 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $004894 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $004896 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $004898 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $00489A MOVE.L  D1,(A6)
        DC.W    $2C81               ; $00489C MOVE.L  D1,(A6)
        DC.W    $2C81               ; $00489E MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048A0 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048A2 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048A4 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048A6 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048A8 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048AA MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048AC MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048AE MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048B0 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048B2 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048B4 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048B6 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048B8 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048BA MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048BC MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048BE MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048C0 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048C2 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048C4 MOVE.L  D1,(A6)
        DC.W    $2C81               ; $0048C6 MOVE.L  D1,(A6)
        DC.W    $4E75               ; $0048C8 RTS
        DC.W    $4EBA,$0002         ; $0048CA JSR     loc_0048CE(PC)
loc_0048CE:
        DC.W    $4EBA,$0002         ; $0048CE JSR     loc_0048D2(PC)
loc_0048D2:
        DC.W    $4EBA,$0002         ; $0048D2 JSR     loc_0048D6(PC)
loc_0048D6:
        DC.W    $4EBA,$0022         ; $0048D6 JSR     loc_0048FA(PC)
        DC.W    $24D9               ; $0048DA MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048DC MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048DE MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048E0 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048E2 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048E4 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048E6 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048E8 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048EA MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048EC MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048EE MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048F0 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048F2 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048F4 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048F6 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048F8 MOVE.L  (A1)+,(A2)+
loc_0048FA:
        DC.W    $24D9               ; $0048FA MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048FC MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $0048FE MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004900 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004902 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004904 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004906 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004908 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $00490A MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $00490C MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $00490E MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004910 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004912 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004914 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004916 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004918 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $00491A MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $00491C MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $00491E MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004920 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004922 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004924 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004926 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $004928 MOVE.L  (A1)+,(A2)+
        DC.W    $4E75               ; $00492A RTS
        DC.W    $2C99               ; $00492C MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00492E MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004930 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004932 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004934 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004936 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004938 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00493A MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00493C MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00493E MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004940 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004942 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004944 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004946 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004948 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00494A MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00494C MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00494E MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004950 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004952 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004954 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004956 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004958 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00495A MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00495C MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00495E MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004960 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004962 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004964 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004966 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $004968 MOVE.L  (A1)+,(A6)
        DC.W    $2C99               ; $00496A MOVE.L  (A1)+,(A6)
        DC.W    $4E75               ; $00496C RTS
        DC.W    $2F01               ; $00496E MOVE.L  D1,-(A7)
        DC.W    $2238,$EF00         ; $004970 MOVE.L  $EF00.W,D1
        DC.W    $6606               ; $004974 BNE.S  loc_00497C
        DC.W    $223C,$2A6D,$365A   ; $004976 MOVE.L  #$2A6D365A,D1
loc_00497C:
        DC.W    $2001               ; $00497C MOVE.L  D1,D0
        DC.W    $E581               ; $00497E ASL.L  #2,D1
        DC.W    $D280               ; $004980 ADD.L  D0,D1
        DC.W    $E781               ; $004982 ASL.L  #3,D1
        DC.W    $D280               ; $004984 ADD.L  D0,D1
        DC.W    $3001               ; $004986 MOVE.W  D1,D0
        DC.W    $4841               ; $004988 SWAP    D1
        DC.W    $D041               ; $00498A ADD.W  D1,D0
        DC.W    $3200               ; $00498C MOVE.W  D0,D1
        DC.W    $4841               ; $00498E SWAP    D1
        DC.W    $21C1,$EF00         ; $004990 MOVE.L  D1,$EF00.W
        DC.W    $221F               ; $004994 MOVE.L  (A7)+,D1
        DC.W    $4E75               ; $004996 RTS
loc_004998:
        DC.W    $31FC,$0004,$C87A   ; $004998 MOVE.W  #$0004,$C87A.W
        DC.W    $46FC,$2300         ; $00499E NOT    #$2300
loc_0049A2:
        DC.W    $4A78,$C87A         ; $0049A2 TST.W  $C87A.W
        DC.W    $66FA               ; $0049A6 BNE.S  loc_0049A2
        DC.W    $4E75               ; $0049A8 RTS
loc_0049AA:
        DC.W    $31FC,$FF00,$C86C   ; $0049AA MOVE.W  #$FF00,$C86C.W
        DC.W    $31FC,$FF00,$C86E   ; $0049B0 MOVE.W  #$FF00,$C86E.W
        DC.W    $21FC,$FFFF,$0000,$C970; $0049B6 MOVE.L  #$FFFF0000,$C970.W
        DC.W    $21FC,$FFFF,$0000,$C974; $0049BE MOVE.L  #$FFFF0000,$C974.W
        DC.W    $4E75               ; $0049C6 RTS
        DC.W    $31FC,$FF00,$C86C   ; $0049C8 MOVE.W  #$FF00,$C86C.W
        DC.W    $31FC,$FF00,$C86E   ; $0049CE MOVE.W  #$FF00,$C86E.W
        DC.W    $21FC,$FFFF,$0000,$C970; $0049D4 MOVE.L  #$FFFF0000,$C970.W
        DC.W    $4E75               ; $0049DC RTS
        DC.W    $31FC,$FF00,$C86E   ; $0049DE MOVE.W  #$FF00,$C86E.W
        DC.W    $21FC,$FFFF,$0000,$C974; $0049E4 MOVE.L  #$FFFF0000,$C974.W
        DC.W    $4E75               ; $0049EC RTS
loc_0049EE:
        DC.W    $0278,$FF80,$C86C   ; $0049EE ANDI.W  #$FF80,$C86C.W
        DC.W    $0278,$FF80,$C86E   ; $0049F4 ANDI.W  #$FF80,$C86E.W
        DC.W    $21FC,$FFFF,$0000,$C970; $0049FA MOVE.L  #$FFFF0000,$C970.W
        DC.W    $21FC,$FFFF,$0000,$C974; $004A02 MOVE.L  #$FFFF0000,$C974.W
        DC.W    $4E75               ; $004A0A RTS
        DC.W    $0278,$FF80,$C86C   ; $004A0C ANDI.W  #$FF80,$C86C.W
        DC.W    $0278,$FF80,$C86E   ; $004A12 ANDI.W  #$FF80,$C86E.W
        DC.W    $21FC,$FFFF,$0000,$C970; $004A18 MOVE.L  #$FFFF0000,$C970.W
        DC.W    $4E75               ; $004A20 RTS
        DC.W    $0278,$FF80,$C86E   ; $004A22 ANDI.W  #$FF80,$C86E.W
        DC.W    $21FC,$FFFF,$0000,$C974; $004A28 MOVE.L  #$FFFF0000,$C974.W
        DC.W    $4E75               ; $004A30 RTS
        DC.W    $7200               ; $004A32 MOVEQ   #$00,D1
        DC.W    $43F9,$00FF,$7B80   ; $004A34 LEA     $00FF7B80,A1
        DC.W    $4EFA,$FE02         ; $004A3A JMP     loc_00483E(PC)
        DC.W    $46FC,$2700         ; $004A3E NOT    #$2700
        DC.W    $08B8,$0006,$C875   ; $004A42 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $004A48 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $004A4C MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $004A54 ANDI.B  #$00FC,$00A15181
        DC.W    $4EBA,$DCAC         ; $004A5C JSR     $00270A(PC)
        DC.W    $11FC,$0001,$C80D   ; $004A60 MOVE.B  #$0001,$C80D.W
        DC.W    $0238,$0009,$C80E   ; $004A66 ANDI.B  #$0009,$C80E.W
        DC.W    $7000               ; $004A6C MOVEQ   #$00,D0
        DC.W    $7200               ; $004A6E MOVEQ   #$00,D1
        DC.W    $1038,$FEA5         ; $004A70 MOVE.B  $FEA5.W,D0
        DC.W    $1238,$FEB1         ; $004A74 MOVE.B  $FEB1.W,D1
        DC.W    $0838,$0007,$FDA8   ; $004A78 BTST    #7,$FDA8.W
        DC.W    $6704               ; $004A7E BEQ.S  loc_004A84
        DC.W    $1038,$FEA6         ; $004A80 MOVE.B  $FEA6.W,D0
loc_004A84:
        DC.W    $4EB9,$0088,$D19C   ; $004A84 JSR     $0088D19C
        DC.W    $1038,$C8C9         ; $004A8A MOVE.B  $C8C9.W,D0
        DC.W    $5200               ; $004A8E ADDQ.B  #1,D0
        DC.W    $13C0,$00A1,$5122   ; $004A90 MOVE.B  D0,$00A15122
        DC.W    $31FC,$0103,$C8A8   ; $004A96 MOVE.W  #$0103,$C8A8.W
        DC.W    $13F8,$C8A9,$00A1,$5121; $004A9C MOVE.B  $C8A9.W,$00A15121
        DC.W    $13F8,$C8A8,$00A1,$5120; $004AA4 MOVE.B  $C8A8.W,$00A15120
        DC.W    $11FC,$0000,$C80F   ; $004AAC MOVE.B  #$0000,$C80F.W
        DC.W    $31FC,$0000,$C8BC   ; $004AB2 MOVE.W  #$0000,$C8BC.W
        DC.W    $4EB9,$0088,$D1D4   ; $004AB8 JSR     $0088D1D4
        DC.W    $4EB9,$0088,$D42C   ; $004ABE JSR     $0088D42C
        DC.W    $41F9,$008B,$A220   ; $004AC4 LEA     $008BA220,A0
        DC.W    $3038,$C8A0         ; $004ACA MOVE.W  $C8A0.W,D0
        DC.W    $2470,$0000         ; $004ACE MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EBA,$DD78         ; $004AD2 JSR     $00284C(PC)
        DC.W    $41F9,$008B,$AE38   ; $004AD6 LEA     $008BAE38,A0
        DC.W    $3038,$C8CC         ; $004ADC MOVE.W  $C8CC.W,D0
        DC.W    $2470,$0000         ; $004AE0 MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EBA,$DD7C         ; $004AE4 JSR     $002862(PC)
        DC.W    $33FC,$0010,$00FF,$0008; $004AE8 MOVE.W  #$0010,$00FF0008
        DC.W    $31FC,$0000,$C8AA   ; $004AF0 MOVE.W  #$0000,$C8AA.W
        DC.W    $4EBA,$FEB2         ; $004AF6 JSR     loc_0049AA(PC)
        DC.W    $4EB9,$0088,$CD92   ; $004AFA JSR     $0088CD92
        DC.W    $11FC,$0000,$C314   ; $004B00 MOVE.B  #$0000,$C314.W
        DC.W    $0838,$0000,$C818   ; $004B06 BTST    #0,$C818.W
        DC.W    $6706               ; $004B0C BEQ.S  loc_004B14
        DC.W    $11FC,$0001,$C314   ; $004B0E MOVE.B  #$0001,$C314.W
loc_004B14:
        DC.W    $7000               ; $004B14 MOVEQ   #$00,D0
        DC.W    $4EB9,$0088,$CC74   ; $004B16 JSR     $0088CC74
        DC.W    $4EBA,$7D52         ; $004B1C JSR     $00C870(PC)
        DC.W    $4EBA,$7E94         ; $004B20 JSR     $00C9B6(PC)
        DC.W    $4A38,$FEA9         ; $004B24 TST.B  $FEA9.W
        DC.W    $6704               ; $004B28 BEQ.S  loc_004B2E
        DC.W    $4EBA,$7F20         ; $004B2A JSR     $00CA4C(PC)
loc_004B2E:
        DC.W    $0838,$0007,$FDA8   ; $004B2E BTST    #7,$FDA8.W
        DC.W    $670A               ; $004B34 BEQ.S  loc_004B40
        DC.W    $23FC,$0403,$131C,$00FF,$69B4; $004B36 MOVE.L  #$0403131C,$00FF69B4
loc_004B40:
        DC.W    $4EB9,$0088,$D054   ; $004B40 JSR     $0088D054
        DC.W    $4EB9,$0088,$CA9A   ; $004B46 JSR     $0088CA9A
        DC.W    $11FC,$0005,$C310   ; $004B4C MOVE.B  #$0005,$C310.W
        DC.W    $4EB9,$0088,$CC88   ; $004B52 JSR     $0088CC88
        DC.W    $7018               ; $004B58 MOVEQ   #$18,D0
        DC.W    $72FF               ; $004B5A MOVEQ   #-$01,D1
        DC.W    $4A78,$C89C         ; $004B5C TST.W  $C89C.W
        DC.W    $6702               ; $004B60 BEQ.S  loc_004B64
        DC.W    $7200               ; $004B62 MOVEQ   #$00,D1
loc_004B64:
        DC.W    $4EB9,$0088,$CDD2   ; $004B64 JSR     $0088CDD2
        DC.W    $4EB9,$0088,$CD4C   ; $004B6A JSR     $0088CD4C
        DC.W    $4EBA,$5C98         ; $004B70 JSR     $00A80A(PC)
        DC.W    $4EBA,$55CE         ; $004B74 JSR     $00A144(PC)
        DC.W    $41F8,$9000         ; $004B78 LEA     $9000.W,A0
        DC.W    $4EBA,$567E         ; $004B7C JSR     $00A1FC(PC)
        DC.W    $4EBA,$7DF2         ; $004B80 JSR     $00C974(PC)
        DC.W    $4EB9,$0088,$CF0C   ; $004B84 JSR     $0088CF0C
        DC.W    $4EB9,$0088,$CC06   ; $004B8A JSR     $0088CC06
        DC.W    $4EB9,$0088,$CFAE   ; $004B90 JSR     $0088CFAE
        DC.W    $31FC,$0000,$C87E   ; $004B96 MOVE.W  #$0000,$C87E.W
        DC.W    $31FC,$C9A0,$C8C0   ; $004B9C MOVE.W  #$C9A0,$C8C0.W
        DC.W    $11FC,$0002,$C80A   ; $004BA2 MOVE.B  #$0002,$C80A.W
        DC.W    $0838,$0003,$C80E   ; $004BA8 BTST    #3,$C80E.W
        DC.W    $6706               ; $004BAE BEQ.S  loc_004BB6
        DC.W    $4EB9,$0088,$D0F6   ; $004BB0 JSR     $0088D0F6
loc_004BB6:
        DC.W    $4EBA,$0D10         ; $004BB6 JSR     loc_0058C8(PC)
        DC.W    $4EBA,$0D4C         ; $004BBA JSR     loc_005908(PC)
        DC.W    $4EBA,$0D7C         ; $004BBE JSR     loc_00593C(PC)
        DC.W    $0239,$00FC,$00A1,$5181; $004BC2 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $004BCA ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $004BD2 MOVE.W  #$8083,$00A15100
        DC.W    $4EBA,$D46E         ; $004BDA JSR     $00204A(PC)
        DC.W    $4EBA,$D4E6         ; $004BDE JSR     $0020C6(PC)
        DC.W    $08F8,$0006,$C875   ; $004BE2 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $004BE8 MOVE.W  $C874.W,(A5)
        DC.W    $4EBA,$FDAA         ; $004BEC JSR     loc_004998(PC)
        DC.W    $3038,$C8A0         ; $004BF0 MOVE.W  $C8A0.W,D0
        DC.W    $41F9,$008B,$B1C4   ; $004BF4 LEA     $008BB1C4,A0
        DC.W    $21F0,$0000,$C96C   ; $004BFA MOVE.L  $00(A0,D0.W),$C96C.W
        DC.W    $11FC,$0001,$C809   ; $004C00 MOVE.B  #$0001,$C809.W
        DC.W    $08F8,$0006,$C80E   ; $004C06 BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $004C0C MOVE.B  #$0001,$C802.W
        DC.W    $0838,$0007,$FDA8   ; $004C12 BTST    #7,$FDA8.W
        DC.W    $6708               ; $004C18 BEQ.S  loc_004C22
        DC.W    $13FC,$0001,$00FF,$60D4; $004C1A MOVE.B  #$0001,$00FF60D4
loc_004C22:
        DC.W    $0839,$0000,$00A1,$5123; $004C22 BTST    #0,$00A15123
        DC.W    $67F6               ; $004C2A BEQ.S  loc_004C22
        DC.W    $08B9,$0000,$00A1,$5123; $004C2C BCLR    #0,$00A15123
        DC.W    $31FC,$0102,$C8A8   ; $004C34 MOVE.W  #$0102,$C8A8.W
        DC.W    $0838,$0003,$C80E   ; $004C3A BTST    #3,$C80E.W
        DC.W    $6648               ; $004C40 BNE.S  loc_004C8A
        DC.W    $3038,$C8C8         ; $004C42 MOVE.W  $C8C8.W,D0
        DC.W    $31FC,$0000,$8790   ; $004C46 MOVE.W  #$0000,$8790.W
        DC.W    $43FA,$006A         ; $004C4C LEA     $006A(PC),A1
        DC.W    $0838,$0000,$C80B   ; $004C50 BTST    #0,$C80B.W
        DC.W    $6606               ; $004C56 BNE.S  loc_004C5E
        DC.W    $11F1,$0000,$C8A5   ; $004C58 MOVE.B  $00(A1,D0.W),$C8A5.W
loc_004C5E:
        DC.W    $4EBA,$D420         ; $004C5E JSR     $002080(PC)
        DC.W    $4EBA,$FD34         ; $004C62 JSR     loc_004998(PC)
        DC.W    $4EBA,$D586         ; $004C66 JSR     $0021EE(PC)
        DC.W    $23FC,$0088,$4CBC,$00FF,$0002; $004C6A MOVE.L  #$00884CBC,$00FF0002
        DC.W    $23FC,$0000,$0000,$00FF,$5FF8; $004C74 MOVE.L  #$00000000,$00FF5FF8
        DC.W    $23FC,$0000,$0000,$00FF,$5FFC; $004C7E MOVE.L  #$00000000,$00FF5FFC
        DC.W    $4E75               ; $004C88 RTS
loc_004C8A:
        DC.W    $11FC,$009A,$C8A5   ; $004C8A MOVE.B  #$009A,$C8A5.W
        DC.W    $4EBA,$D3EE         ; $004C90 JSR     $002080(PC)
        DC.W    $4EBA,$FD02         ; $004C94 JSR     loc_004998(PC)
        DC.W    $23FC,$0088,$5618,$00FF,$0002; $004C98 MOVE.L  #$00885618,$00FF0002
        DC.W    $23FC,$0000,$0000,$00FF,$5FF8; $004CA2 MOVE.L  #$00000000,$00FF5FF8
        DC.W    $23FC,$0000,$0000,$00FF,$5FFC; $004CAC MOVE.L  #$00000000,$00FF5FFC
        DC.W    $4E75               ; $004CB6 RTS
        DC.W    $A2A0               ; $004CB8 MOVE.L  -(A0),(A1)
        DC.W    $A100               ; $004CBA MOVE.L  D0,-(A0)
        DC.W    $3038,$C87E         ; $004CBC MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $004CC0 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $004CC4 JMP     (A1)
        DC.W    $0088,$4CDA,$0088   ; $004CC6 ORI.L  #$4CDA0088,A0
        DC.W    $4D00               ; $004CCC DC.W    $4D00
        DC.W    $0088,$4D1A,$0088   ; $004CCE ORI.L  #$4D1A0088,A0
        DC.W    $4D7A               ; $004CD4 DC.W    $4D7A
        DC.W    $0088,$573C,$4EBA   ; $004CD6 ORI.L  #$573C4EBA,A0
        DC.W    $DBE6               ; $004CDC ADDA.L  -(A6),A5
        DC.W    $4EBA,$D3F6         ; $004CDE JSR     $0020D6(PC)
        DC.W    $4EBA,$63BA         ; $004CE2 JSR     $00B09E(PC)
        DC.W    $4EBA,$6344         ; $004CE6 JSR     $00B02C(PC)
        DC.W    $4EBA,$6946         ; $004CEA JSR     $00B632(PC)
        DC.W    $4EBA,$0BD8         ; $004CEE JSR     loc_0058C8(PC)
        DC.W    $5878,$C87E         ; $004CF2 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $004CF6 MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $004CFE RTS
        DC.W    $4EBA,$D408         ; $004D00 JSR     $00210A(PC)
        DC.W    $4EBA,$6398         ; $004D04 JSR     $00B09E(PC)
        DC.W    $4EBA,$0BFE         ; $004D08 JSR     loc_005908(PC)
        DC.W    $5878,$C87E         ; $004D0C ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $004D10 MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $004D18 RTS
        DC.W    $4EBA,$D412         ; $004D1A JSR     $00212E(PC)
        DC.W    $4EBA,$CA7E         ; $004D1E JSR     $00179E(PC)
        DC.W    $4EBA,$637A         ; $004D22 JSR     $00B09E(PC)
        DC.W    $4EBA,$641C         ; $004D26 JSR     $00B144(PC)
        DC.W    $4EBA,$67D8         ; $004D2A JSR     $00B504(PC)
        DC.W    $4EBA,$67AC         ; $004D2E JSR     $00B4DC(PC)
        DC.W    $4EBA,$67EE         ; $004D32 JSR     $00B522(PC)
        DC.W    $5278,$C8AA         ; $004D36 ADDQ.W  #1,$C8AA.W
        DC.W    $3078,$C8C0         ; $004D3A MOVEA.W $C8C0.W,A0
        DC.W    $B0FC,$EF00         ; $004D3E CMPA.W  #$EF00,A0
        DC.W    $6700,$001A         ; $004D42 BEQ.W  loc_004D5E
        DC.W    $1038,$C971         ; $004D46 MOVE.B  $C971.W,D0
        DC.W    $0200,$005C         ; $004D4A ANDI.B  #$005C,D0
        DC.W    $1238,$C973         ; $004D4E MOVE.B  $C973.W,D1
        DC.W    $0201,$0003         ; $004D52 ANDI.B  #$0003,D1
        DC.W    $8001               ; $004D56 OR.B   D1,D0
        DC.W    $10C0               ; $004D58 MOVE.B  D0,(A0)+
        DC.W    $31C8,$C8C0         ; $004D5A MOVE.W  A0,$C8C0.W
loc_004D5E:
        DC.W    $4EBA,$0BDC         ; $004D5E JSR     loc_00593C(PC)
        DC.W    $4EBA,$6976         ; $004D62 JSR     $00B6DA(PC)
        DC.W    $4EBA,$691C         ; $004D66 JSR     $00B684(PC)
        DC.W    $5878,$C87E         ; $004D6A ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0054,$00FF,$0008; $004D6E MOVE.W  #$0054,$00FF0008
        DC.W    $4EFA,$0980         ; $004D76 JMP     loc_0056F8(PC)
        DC.W    $4EBA,$D3B2         ; $004D7A JSR     $00212E(PC)
        DC.W    $4EBA,$CA1E         ; $004D7E JSR     $00179E(PC)
        DC.W    $4EBA,$631A         ; $004D82 JSR     $00B09E(PC)
        DC.W    $4EBA,$63BC         ; $004D86 JSR     $00B144(PC)
        DC.W    $5238,$C886         ; $004D8A ADDQ.B  #1,$C886.W
        DC.W    $33FC,$0054,$00FF,$0008; $004D8E MOVE.W  #$0054,$00FF0008
        DC.W    $4E75               ; $004D96 RTS
        DC.W    $46FC,$2700         ; $004D98 NOT    #$2700
        DC.W    $08B8,$0006,$C875   ; $004D9C BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $004DA2 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $004DA6 MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $004DAE ANDI.B  #$00FC,$00A15181
        DC.W    $4EBA,$D952         ; $004DB6 JSR     $00270A(PC)
        DC.W    $11FC,$0001,$C80D   ; $004DBA MOVE.B  #$0001,$C80D.W
        DC.W    $11FC,$0000,$C80E   ; $004DC0 MOVE.B  #$0000,$C80E.W
        DC.W    $0038,$0010,$C80E   ; $004DC6 ORI.B  #$0010,$C80E.W
        DC.W    $08B8,$0007,$FDA8   ; $004DCC BCLR    #7,$FDA8.W
        DC.W    $7000               ; $004DD2 MOVEQ   #$00,D0
        DC.W    $7200               ; $004DD4 MOVEQ   #$00,D1
        DC.W    $1038,$FEAB         ; $004DD6 MOVE.B  $FEAB.W,D0
        DC.W    $1238,$FEB3         ; $004DDA MOVE.B  $FEB3.W,D1
        DC.W    $4EB9,$0088,$D19C   ; $004DDE JSR     $0088D19C
        DC.W    $13FC,$0004,$00A1,$5122; $004DE4 MOVE.B  #$0004,$00A15122
        DC.W    $31FC,$0103,$C8A8   ; $004DEC MOVE.W  #$0103,$C8A8.W
        DC.W    $13F8,$C8A9,$00A1,$5121; $004DF2 MOVE.B  $C8A9.W,$00A15121
        DC.W    $13F8,$C8A8,$00A1,$5120; $004DFA MOVE.B  $C8A8.W,$00A15120
        DC.W    $11FC,$0001,$C80F   ; $004E02 MOVE.B  #$0001,$C80F.W
        DC.W    $31FC,$0040,$C8BC   ; $004E08 MOVE.W  #$0040,$C8BC.W
        DC.W    $4EB9,$0088,$D1D4   ; $004E0E JSR     $0088D1D4
        DC.W    $4EB9,$0088,$D42C   ; $004E14 JSR     $0088D42C
        DC.W    $41F9,$008B,$A220   ; $004E1A LEA     $008BA220,A0
        DC.W    $3038,$C8A0         ; $004E20 MOVE.W  $C8A0.W,D0
        DC.W    $2470,$0000         ; $004E24 MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EBA,$DA22         ; $004E28 JSR     $00284C(PC)
        DC.W    $41F9,$008B,$AE38   ; $004E2C LEA     $008BAE38,A0
        DC.W    $3038,$C8CC         ; $004E32 MOVE.W  $C8CC.W,D0
        DC.W    $2470,$0000         ; $004E36 MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EBA,$DA26         ; $004E3A JSR     $002862(PC)
        DC.W    $33FC,$0010,$00FF,$0008; $004E3E MOVE.W  #$0010,$00FF0008
        DC.W    $31FC,$0000,$C8AA   ; $004E46 MOVE.W  #$0000,$C8AA.W
        DC.W    $4EBA,$FB5C         ; $004E4C JSR     loc_0049AA(PC)
        DC.W    $4EBA,$7F40         ; $004E50 JSR     $00CD92(PC)
        DC.W    $7010               ; $004E54 MOVEQ   #$10,D0
        DC.W    $4EBA,$7E1C         ; $004E56 JSR     $00CC74(PC)
        DC.W    $4EBA,$7A14         ; $004E5A JSR     $00C870(PC)
        DC.W    $4EBA,$7B80         ; $004E5E JSR     $00C9E0(PC)
        DC.W    $4A38,$FEAF         ; $004E62 TST.B  $FEAF.W
        DC.W    $6704               ; $004E66 BEQ.S  loc_004E6C
        DC.W    $4EBA,$7BFC         ; $004E68 JSR     $00CA66(PC)
loc_004E6C:
        DC.W    $4A38,$FEB0         ; $004E6C TST.B  $FEB0.W
        DC.W    $6704               ; $004E70 BEQ.S  loc_004E76
        DC.W    $4EBA,$7C0C         ; $004E72 JSR     $00CA80(PC)
loc_004E76:
        DC.W    $4EB9,$0088,$D450   ; $004E76 JSR     $0088D450
        DC.W    $4EB9,$0088,$D08A   ; $004E7C JSR     $0088D08A
        DC.W    $4EBA,$7CBA         ; $004E82 JSR     $00CB3E(PC)
        DC.W    $4EBA,$7E00         ; $004E86 JSR     $00CC88(PC)
        DC.W    $41F8,$9F00         ; $004E8A LEA     $9F00.W,A0
        DC.W    $4EBA,$7E02         ; $004E8E JSR     $00CC92(PC)
        DC.W    $7030               ; $004E92 MOVEQ   #$30,D0
        DC.W    $4EB9,$0088,$CE02   ; $004E94 JSR     $0088CE02
        DC.W    $11F8,$FEB0,$C30F   ; $004E9A MOVE.B  $FEB0.W,$C30F.W
        DC.W    $4EBA,$52A2         ; $004EA0 JSR     $00A144(PC)
        DC.W    $41F8,$9F00         ; $004EA4 LEA     $9F00.W,A0
        DC.W    $4EBA,$5352         ; $004EA8 JSR     $00A1FC(PC)
        DC.W    $4EBA,$7A44         ; $004EAC JSR     $00C8F2(PC)
        DC.W    $4EB9,$0088,$CFD6   ; $004EB0 JSR     $0088CFD6
        DC.W    $4EB9,$0088,$CE76   ; $004EB6 JSR     $0088CE76
        DC.W    $4EB9,$0088,$CECC   ; $004EBC JSR     $0088CECC
        DC.W    $11FC,$0000,$C314   ; $004EC2 MOVE.B  #$0000,$C314.W
        DC.W    $0838,$0001,$C818   ; $004EC8 BTST    #1,$C818.W
        DC.W    $6706               ; $004ECE BEQ.S  loc_004ED6
        DC.W    $11FC,$0001,$C314   ; $004ED0 MOVE.B  #$0001,$C314.W
loc_004ED6:
        DC.W    $45F8,$C000         ; $004ED6 LEA     $C000.W,A2
        DC.W    $43F8,$B800         ; $004EDA LEA     $B800.W,A1
        DC.W    $7E1F               ; $004EDE MOVEQ   #$1F,D7
loc_004EE0:
        DC.W    $4CDA,$087F         ; $004EE0 MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A2)+
        DC.W    $48E1,$FE10         ; $004EE4 MOVEM.L -(A1),D4/A1/A2/A3/A4/A5/A6/A7
        DC.W    $51CF,$FFF6         ; $004EE8 DBRA    D7,loc_004EE0
        DC.W    $11FC,$0000,$C314   ; $004EEC MOVE.B  #$0000,$C314.W
        DC.W    $0838,$0000,$C818   ; $004EF2 BTST    #0,$C818.W
        DC.W    $6706               ; $004EF8 BEQ.S  loc_004F00
        DC.W    $11FC,$0001,$C314   ; $004EFA MOVE.B  #$0001,$C314.W
loc_004F00:
        DC.W    $11F8,$FEAF,$C30F   ; $004F00 MOVE.B  $FEAF.W,$C30F.W
        DC.W    $4EBA,$523C         ; $004F06 JSR     $00A144(PC)
        DC.W    $41F8,$9000         ; $004F0A LEA     $9000.W,A0
        DC.W    $4EBA,$52EC         ; $004F0E JSR     $00A1FC(PC)
        DC.W    $4EB9,$0088,$CEC2   ; $004F12 JSR     $0088CEC2
        DC.W    $31FC,$0000,$C87E   ; $004F18 MOVE.W  #$0000,$C87E.W
        DC.W    $08F8,$0004,$C80E   ; $004F1E BSET    #4,$C80E.W
        DC.W    $4EBA,$14E8         ; $004F24 JSR     $00640E(PC)
        DC.W    $4EBA,$156C         ; $004F28 JSR     $006496(PC)
        DC.W    $0239,$00FC,$00A1,$5181; $004F2C ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $004F34 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $004F3C MOVE.W  #$8083,$00A15100
        DC.W    $4EBA,$D104         ; $004F44 JSR     $00204A(PC)
        DC.W    $4EBA,$D17C         ; $004F48 JSR     $0020C6(PC)
        DC.W    $08F8,$0006,$C875   ; $004F4C BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $004F52 MOVE.W  $C874.W,(A5)
        DC.W    $4EB9,$0088,$4998   ; $004F56 JSR     $00884998
        DC.W    $3038,$C8C8         ; $004F5C MOVE.W  $C8C8.W,D0
        DC.W    $31FC,$0000,$8790   ; $004F60 MOVE.W  #$0000,$8790.W
        DC.W    $43FA,$FD50         ; $004F66 LEA     -$02B0(PC),A1
        DC.W    $0838,$0000,$C80B   ; $004F6A BTST    #0,$C80B.W
        DC.W    $6606               ; $004F70 BNE.S  loc_004F78
        DC.W    $11F1,$0000,$C8A5   ; $004F72 MOVE.B  $00(A1,D0.W),$C8A5.W
loc_004F78:
        DC.W    $4EB9,$0088,$2080   ; $004F78 JSR     $00882080
        DC.W    $4EB9,$0088,$4998   ; $004F7E JSR     $00884998
        DC.W    $3038,$C8C8         ; $004F84 MOVE.W  $C8C8.W,D0
        DC.W    $31FC,$0000,$8760   ; $004F88 MOVE.W  #$0000,$8760.W
        DC.W    $43FA,$0090         ; $004F8E LEA     $0090(PC),A1
        DC.W    $0838,$0000,$C80B   ; $004F92 BTST    #0,$C80B.W
        DC.W    $6606               ; $004F98 BNE.S  loc_004FA0
        DC.W    $11F1,$0000,$C8A5   ; $004F9A MOVE.B  $00(A1,D0.W),$C8A5.W
loc_004FA0:
        DC.W    $4EB9,$0088,$2080   ; $004FA0 JSR     $00882080
        DC.W    $4EB9,$0088,$4998   ; $004FA6 JSR     $00884998
        DC.W    $4EBA,$D240         ; $004FAC JSR     $0021EE(PC)
        DC.W    $3038,$C8A0         ; $004FB0 MOVE.W  $C8A0.W,D0
        DC.W    $41F9,$008B,$B1C4   ; $004FB4 LEA     $008BB1C4,A0
        DC.W    $21F0,$0000,$C96C   ; $004FBA MOVE.L  $00(A0,D0.W),$C96C.W
        DC.W    $11FC,$0001,$C809   ; $004FC0 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0002,$C80A   ; $004FC6 MOVE.B  #$0002,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $004FCC BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $004FD2 MOVE.B  #$0001,$C802.W
        DC.W    $0838,$0007,$FDA8   ; $004FD8 BTST    #7,$FDA8.W
        DC.W    $6708               ; $004FDE BEQ.S  loc_004FE8
        DC.W    $13FC,$0001,$00FF,$60D4; $004FE0 MOVE.B  #$0001,$00FF60D4
loc_004FE8:
        DC.W    $0839,$0000,$00A1,$5123; $004FE8 BTST    #0,$00A15123
        DC.W    $67F6               ; $004FF0 BEQ.S  loc_004FE8
        DC.W    $08B9,$0000,$00A1,$5123; $004FF2 BCLR    #0,$00A15123
        DC.W    $31FC,$0104,$C8A8   ; $004FFA MOVE.W  #$0104,$C8A8.W
        DC.W    $23FC,$0088,$5024,$00FF,$0002; $005000 MOVE.L  #$00885024,$00FF0002
        DC.W    $23FC,$0000,$0000,$00FF,$5FF8; $00500A MOVE.L  #$00000000,$00FF5FF8
        DC.W    $23FC,$0000,$0000,$00FF,$5FFC; $005014 MOVE.L  #$00000000,$00FF5FFC
        DC.W    $4E75               ; $00501E RTS
        DC.W    $A5A3,$A400         ; $005020 MOVE.L  -(A3),$00(A2,A2.W)
        DC.W    $3038,$C87E         ; $005024 MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $005028 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00502C JMP     (A1)
        DC.W    $0088,$5042,$0088   ; $00502E ORI.L  #$50420088,A0
        DC.W    $5070,$0088         ; $005034 ADDQ.W  #8,-$78(A0,D0.W)
        DC.W    $509E               ; $005038 ADDQ.L  #8,(A6)+
        DC.W    $0088,$50DE,$0088   ; $00503A ORI.L  #$50DE0088,A0
        DC.W    $573C,$4EBA         ; $005040 SUBQ.B  #3,#$4EBA
        DC.W    $D87E               ; $005044 ADD.W  <EA:3E>,D4
        DC.W    $4EBA,$D10C         ; $005046 JSR     $002154(PC)
        DC.W    $4EBA,$6052         ; $00504A JSR     $00B09E(PC)
        DC.W    $4EBA,$6044         ; $00504E JSR     $00B094(PC)
        DC.W    $4EBA,$608A         ; $005052 JSR     $00B0DE(PC)
        DC.W    $4EBA,$5FE4         ; $005056 JSR     $00B03C(PC)
        DC.W    $4EBA,$65D6         ; $00505A JSR     $00B632(PC)
        DC.W    $4EBA,$65E6         ; $00505E JSR     $00B646(PC)
        DC.W    $5878,$C87E         ; $005062 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0014,$00FF,$0008; $005066 MOVE.W  #$0014,$00FF0008
        DC.W    $4E75               ; $00506E RTS
        DC.W    $4EBA,$D10E         ; $005070 JSR     $002180(PC)
        DC.W    $4EBA,$C728         ; $005074 JSR     $00179E(PC)
        DC.W    $4EBA,$6024         ; $005078 JSR     $00B09E(PC)
        DC.W    $4EBA,$6016         ; $00507C JSR     $00B094(PC)
        DC.W    $4EBA,$605C         ; $005080 JSR     $00B0DE(PC)
        DC.W    $4EBA,$60A2         ; $005084 JSR     $00B128(PC)
        DC.W    $4EBA,$60AC         ; $005088 JSR     $00B136(PC)
        DC.W    $4EBA,$1380         ; $00508C JSR     $00640E(PC)
        DC.W    $5878,$C87E         ; $005090 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$001C,$00FF,$0008; $005094 MOVE.W  #$001C,$00FF0008
        DC.W    $4E75               ; $00509C RTS
        DC.W    $4EBA,$D104         ; $00509E JSR     $0021A4(PC)
        DC.W    $4EBA,$13F2         ; $0050A2 JSR     $006496(PC)
        DC.W    $4EBA,$5FF6         ; $0050A6 JSR     $00B09E(PC)
        DC.W    $4EBA,$5FE8         ; $0050AA JSR     $00B094(PC)
        DC.W    $4EBA,$602E         ; $0050AE JSR     $00B0DE(PC)
        DC.W    $4EBA,$6450         ; $0050B2 JSR     $00B504(PC)
        DC.W    $4EBA,$6440         ; $0050B6 JSR     $00B4F8(PC)
        DC.W    $4EBA,$649E         ; $0050BA JSR     $00B55A(PC)
        DC.W    $4EBA,$64D0         ; $0050BE JSR     $00B590(PC)
        DC.W    $5278,$C8AA         ; $0050C2 ADDQ.W  #1,$C8AA.W
        DC.W    $4EBA,$6612         ; $0050C6 JSR     $00B6DA(PC)
        DC.W    $4EBA,$65B8         ; $0050CA JSR     $00B684(PC)
        DC.W    $5878,$C87E         ; $0050CE ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0054,$00FF,$0008; $0050D2 MOVE.W  #$0054,$00FF0008
        DC.W    $4EFA,$061C         ; $0050DA JMP     loc_0056F8(PC)
        DC.W    $4EBA,$D0C4         ; $0050DE JSR     $0021A4(PC)
        DC.W    $4EBA,$C6BA         ; $0050E2 JSR     $00179E(PC)
        DC.W    $4EBA,$5FB6         ; $0050E6 JSR     $00B09E(PC)
        DC.W    $4EBA,$5FA8         ; $0050EA JSR     $00B094(PC)
        DC.W    $4EBA,$5FEE         ; $0050EE JSR     $00B0DE(PC)
        DC.W    $5238,$C886         ; $0050F2 ADDQ.B  #1,$C886.W
        DC.W    $33FC,$0054,$00FF,$0008; $0050F6 MOVE.W  #$0054,$00FF0008
        DC.W    $4E75               ; $0050FE RTS
        DC.W    $46FC,$2700         ; $005100 NOT    #$2700
        DC.W    $08B8,$0006,$C875   ; $005104 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00510A MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $00510E MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $005116 ANDI.B  #$00FC,$00A15181
        DC.W    $4EBA,$D5EA         ; $00511E JSR     $00270A(PC)
        DC.W    $11FC,$0001,$C80D   ; $005122 MOVE.B  #$0001,$C80D.W
        DC.W    $11FC,$0000,$C80E   ; $005128 MOVE.B  #$0000,$C80E.W
        DC.W    $0038,$0020,$C80E   ; $00512E ORI.B  #$0020,$C80E.W
        DC.W    $08B8,$0007,$FDA8   ; $005134 BCLR    #7,$FDA8.W
        DC.W    $7000               ; $00513A MOVEQ   #$00,D0
        DC.W    $7200               ; $00513C MOVEQ   #$00,D1
        DC.W    $1038,$FEA7         ; $00513E MOVE.B  $FEA7.W,D0
        DC.W    $1238,$FEB2         ; $005142 MOVE.B  $FEB2.W,D1
        DC.W    $4EB9,$0088,$D19C   ; $005146 JSR     $0088D19C
        DC.W    $1038,$C8C9         ; $00514C MOVE.B  $C8C9.W,D0
        DC.W    $5200               ; $005150 ADDQ.B  #1,D0
        DC.W    $13C0,$00A1,$5122   ; $005152 MOVE.B  D0,$00A15122
        DC.W    $31FC,$0103,$C8A8   ; $005158 MOVE.W  #$0103,$C8A8.W
        DC.W    $13F8,$C8A9,$00A1,$5121; $00515E MOVE.B  $C8A9.W,$00A15121
        DC.W    $13F8,$C8A8,$00A1,$5120; $005166 MOVE.B  $C8A8.W,$00A15120
        DC.W    $11FC,$0000,$C80F   ; $00516E MOVE.B  #$0000,$C80F.W
        DC.W    $31FC,$0000,$C8BC   ; $005174 MOVE.W  #$0000,$C8BC.W
        DC.W    $4EB9,$0088,$D1D4   ; $00517A JSR     $0088D1D4
        DC.W    $4EB9,$0088,$D42C   ; $005180 JSR     $0088D42C
        DC.W    $41F9,$008B,$A220   ; $005186 LEA     $008BA220,A0
        DC.W    $3038,$C8A0         ; $00518C MOVE.W  $C8A0.W,D0
        DC.W    $2470,$0000         ; $005190 MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EBA,$D6B6         ; $005194 JSR     $00284C(PC)
        DC.W    $41F9,$008B,$AE38   ; $005198 LEA     $008BAE38,A0
        DC.W    $3038,$C8CC         ; $00519E MOVE.W  $C8CC.W,D0
        DC.W    $2470,$0000         ; $0051A2 MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EBA,$D6BA         ; $0051A6 JSR     $002862(PC)
        DC.W    $33FC,$0010,$00FF,$0008; $0051AA MOVE.W  #$0010,$00FF0008
        DC.W    $31FC,$0000,$C8AA   ; $0051B2 MOVE.W  #$0000,$C8AA.W
        DC.W    $4EBA,$F7F0         ; $0051B8 JSR     loc_0049AA(PC)
        DC.W    $4EBA,$7BD4         ; $0051BC JSR     $00CD92(PC)
        DC.W    $11FC,$0000,$C314   ; $0051C0 MOVE.B  #$0000,$C314.W
        DC.W    $0838,$0000,$C818   ; $0051C6 BTST    #0,$C818.W
        DC.W    $6706               ; $0051CC BEQ.S  loc_0051D4
        DC.W    $11FC,$0001,$C314   ; $0051CE MOVE.B  #$0001,$C314.W
loc_0051D4:
        DC.W    $7010               ; $0051D4 MOVEQ   #$10,D0
        DC.W    $4EBA,$7A9C         ; $0051D6 JSR     $00CC74(PC)
        DC.W    $4EBA,$7694         ; $0051DA JSR     $00C870(PC)
        DC.W    $4EBA,$7820         ; $0051DE JSR     $00CA00(PC)
        DC.W    $4EBA,$7EE8         ; $0051E2 JSR     $00D0CC(PC)
        DC.W    $4A38,$FEAA         ; $0051E6 TST.B  $FEAA.W
        DC.W    $6704               ; $0051EA BEQ.S  loc_0051F0
        DC.W    $4EBA,$785E         ; $0051EC JSR     $00CA4C(PC)
loc_0051F0:
        DC.W    $4EB9,$0088,$D450   ; $0051F0 JSR     $0088D450
        DC.W    $4EB9,$0088,$D054   ; $0051F6 JSR     $0088D054
        DC.W    $4EBA,$78A2         ; $0051FC JSR     $00CAA0(PC)
        DC.W    $11F8,$C81A,$C310   ; $005200 MOVE.B  $C81A.W,$C310.W
        DC.W    $4EBA,$7A80         ; $005206 JSR     $00CC88(PC)
        DC.W    $7018               ; $00520A MOVEQ   #$18,D0
        DC.W    $7200               ; $00520C MOVEQ   #$00,D1
        DC.W    $4EBA,$7C12         ; $00520E JSR     $00CE22(PC)
        DC.W    $11F8,$FEAA,$C30F   ; $005212 MOVE.B  $FEAA.W,$C30F.W
        DC.W    $4EBA,$4F2A         ; $005218 JSR     $00A144(PC)
        DC.W    $41F8,$9000         ; $00521C LEA     $9000.W,A0
        DC.W    $4EBA,$4FDA         ; $005220 JSR     $00A1FC(PC)
        DC.W    $4EBA,$774E         ; $005224 JSR     $00C974(PC)
        DC.W    $4EBA,$7D84         ; $005228 JSR     $00CFAE(PC)
        DC.W    $11FC,$0000,$C819   ; $00522C MOVE.B  #$0000,$C819.W
        DC.W    $31FC,$0000,$C8BE   ; $005232 MOVE.W  #$0000,$C8BE.W
        DC.W    $31FC,$0000,$C87E   ; $005238 MOVE.W  #$0000,$C87E.W
        DC.W    $4EBA,$1600         ; $00523E JSR     $006840(PC)
        DC.W    $0239,$00FC,$00A1,$5181; $005242 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $00524A ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $005252 MOVE.W  #$8083,$00A15100
        DC.W    $4EBA,$CDEE         ; $00525A JSR     $00204A(PC)
        DC.W    $4EBA,$CE66         ; $00525E JSR     $0020C6(PC)
        DC.W    $08F8,$0006,$C875   ; $005262 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $005268 MOVE.W  $C874.W,(A5)
        DC.W    $4EB9,$0088,$4998   ; $00526C JSR     $00884998
        DC.W    $3038,$C8C8         ; $005272 MOVE.W  $C8C8.W,D0
        DC.W    $43FA,$FA40         ; $005276 LEA     -$05C0(PC),A1
        DC.W    $0838,$0000,$C80B   ; $00527A BTST    #0,$C80B.W
        DC.W    $6606               ; $005280 BNE.S  loc_005288
        DC.W    $11F1,$0000,$C8A5   ; $005282 MOVE.B  $00(A1,D0.W),$C8A5.W
loc_005288:
        DC.W    $4EB9,$0088,$2080   ; $005288 JSR     $00882080
        DC.W    $4EB9,$0088,$4998   ; $00528E JSR     $00884998
        DC.W    $4EBA,$CF58         ; $005294 JSR     $0021EE(PC)
        DC.W    $3038,$C8A0         ; $005298 MOVE.W  $C8A0.W,D0
        DC.W    $41F9,$008B,$B1C4   ; $00529C LEA     $008BB1C4,A0
        DC.W    $21F0,$0000,$C96C   ; $0052A2 MOVE.L  $00(A0,D0.W),$C96C.W
        DC.W    $11FC,$0001,$C809   ; $0052A8 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0002,$C80A   ; $0052AE MOVE.B  #$0002,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $0052B4 BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $0052BA MOVE.B  #$0001,$C802.W
        DC.W    $0838,$0007,$FDA8   ; $0052C0 BTST    #7,$FDA8.W
        DC.W    $6708               ; $0052C6 BEQ.S  loc_0052D0
        DC.W    $13FC,$0001,$00FF,$60D4; $0052C8 MOVE.B  #$0001,$00FF60D4
loc_0052D0:
        DC.W    $0839,$0000,$00A1,$5123; $0052D0 BTST    #0,$00A15123
        DC.W    $67F6               ; $0052D8 BEQ.S  loc_0052D0
        DC.W    $08B9,$0000,$00A1,$5123; $0052DA BCLR    #0,$00A15123
        DC.W    $31FC,$0102,$C8A8   ; $0052E2 MOVE.W  #$0102,$C8A8.W
        DC.W    $23FC,$0088,$5308,$00FF,$0002; $0052E8 MOVE.L  #$00885308,$00FF0002
        DC.W    $23FC,$0000,$0000,$00FF,$5FF8; $0052F2 MOVE.L  #$00000000,$00FF5FF8
        DC.W    $23FC,$0000,$0000,$00FF,$5FFC; $0052FC MOVE.L  #$00000000,$00FF5FFC
        DC.W    $4E75               ; $005306 RTS
        DC.W    $3038,$C87E         ; $005308 MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $00530C MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $005310 JMP     (A1)
        DC.W    $0088,$5326,$0088   ; $005312 ORI.L  #$53260088,A0
        DC.W    $5348               ; $005318 SUBQ.W  #1,A0
        DC.W    $0088,$535E,$0088   ; $00531A ORI.L  #$535E0088,A0
        DC.W    $5396               ; $005320 SUBQ.L  #1,(A6)
        DC.W    $0088,$573C,$4EBA   ; $005322 ORI.L  #$573C4EBA,A0
        DC.W    $D59A               ; $005328 ADD.L  D2,(A2)+
        DC.W    $4EBA,$CDAA         ; $00532A JSR     $0020D6(PC)
        DC.W    $4EBA,$5D6E         ; $00532E JSR     $00B09E(PC)
        DC.W    $4EBA,$5CF8         ; $005332 JSR     $00B02C(PC)
        DC.W    $4EBA,$62FA         ; $005336 JSR     $00B632(PC)
        DC.W    $5878,$C87E         ; $00533A ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $00533E MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $005346 RTS
        DC.W    $4EBA,$CDC0         ; $005348 JSR     $00210A(PC)
        DC.W    $4EBA,$5D50         ; $00534C JSR     $00B09E(PC)
        DC.W    $5878,$C87E         ; $005350 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $005354 MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $00535C RTS
        DC.W    $4EBA,$CDCE         ; $00535E JSR     $00212E(PC)
        DC.W    $4EBA,$C43A         ; $005362 JSR     $00179E(PC)
        DC.W    $4EBA,$5D36         ; $005366 JSR     $00B09E(PC)
        DC.W    $4EBA,$5DAE         ; $00536A JSR     $00B11A(PC)
        DC.W    $4EBA,$6194         ; $00536E JSR     $00B504(PC)
        DC.W    $4EBA,$6230         ; $005372 JSR     $00B5A4(PC)
        DC.W    $5278,$C8AA         ; $005376 ADDQ.W  #1,$C8AA.W
        DC.W    $4EBA,$14C4         ; $00537A JSR     $006840(PC)
        DC.W    $4EBA,$635A         ; $00537E JSR     $00B6DA(PC)
        DC.W    $4EBA,$6300         ; $005382 JSR     $00B684(PC)
        DC.W    $5878,$C87E         ; $005386 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0054,$00FF,$0008; $00538A MOVE.W  #$0054,$00FF0008
        DC.W    $4EFA,$0364         ; $005392 JMP     loc_0056F8(PC)
        DC.W    $4EBA,$CD96         ; $005396 JSR     $00212E(PC)
        DC.W    $4EBA,$C402         ; $00539A JSR     $00179E(PC)
        DC.W    $4EBA,$5CFE         ; $00539E JSR     $00B09E(PC)
        DC.W    $5238,$C886         ; $0053A2 ADDQ.B  #1,$C886.W
        DC.W    $33FC,$0054,$00FF,$0008; $0053A6 MOVE.W  #$0054,$00FF0008
        DC.W    $4E75               ; $0053AE RTS
        DC.W    $46FC,$2700         ; $0053B0 NOT    #$2700
        DC.W    $08B8,$0006,$C875   ; $0053B4 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $0053BA MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $0053BE MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $0053C6 ANDI.B  #$00FC,$00A15181
        DC.W    $4EBA,$D33A         ; $0053CE JSR     $00270A(PC)
        DC.W    $7007               ; $0053D2 MOVEQ   #$07,D0
        DC.W    $4EB9,$0088,$14BE   ; $0053D4 JSR     $008814BE
        DC.W    $7200               ; $0053DA MOVEQ   #$00,D1
        DC.W    $1038,$FEB6         ; $0053DC MOVE.B  $FEB6.W,D0
        DC.W    $0C00,$0005         ; $0053E0 CMPI.B  #$0005,D0
        DC.W    $6502               ; $0053E4 BCS.S  loc_0053E8
        DC.W    $7000               ; $0053E6 MOVEQ   #$00,D0
loc_0053E8:
        DC.W    $1238,$FEB5         ; $0053E8 MOVE.B  $FEB5.W,D1
        DC.W    $11FC,$0001,$C80D   ; $0053EC MOVE.B  #$0001,$C80D.W
        DC.W    $4EBA,$7DA8         ; $0053F2 JSR     $00D19C(PC)
        DC.W    $1038,$C8C9         ; $0053F6 MOVE.B  $C8C9.W,D0
        DC.W    $5200               ; $0053FA ADDQ.B  #1,D0
        DC.W    $13C0,$00A1,$5122   ; $0053FC MOVE.B  D0,$00A15122
        DC.W    $31FC,$0103,$C8A8   ; $005402 MOVE.W  #$0103,$C8A8.W
        DC.W    $13F8,$C8A9,$00A1,$5121; $005408 MOVE.B  $C8A9.W,$00A15121
        DC.W    $13F8,$C8A8,$00A1,$5120; $005410 MOVE.B  $C8A8.W,$00A15120
        DC.W    $11FC,$0000,$C80F   ; $005418 MOVE.B  #$0000,$C80F.W
        DC.W    $31FC,$0000,$C8BC   ; $00541E MOVE.W  #$0000,$C8BC.W
        DC.W    $4EB9,$0088,$D1D4   ; $005424 JSR     $0088D1D4
        DC.W    $4EB9,$0088,$D42C   ; $00542A JSR     $0088D42C
        DC.W    $41F9,$008B,$A220   ; $005430 LEA     $008BA220,A0
        DC.W    $3038,$C8A0         ; $005436 MOVE.W  $C8A0.W,D0
        DC.W    $2470,$0000         ; $00543A MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EBA,$D40C         ; $00543E JSR     $00284C(PC)
        DC.W    $41F9,$008B,$AE38   ; $005442 LEA     $008BAE38,A0
        DC.W    $3038,$C8CC         ; $005448 MOVE.W  $C8CC.W,D0
        DC.W    $2470,$0000         ; $00544C MOVEA.L $00(A0,D0.W),A2
        DC.W    $4EBA,$D410         ; $005450 JSR     $002862(PC)
        DC.W    $33FC,$0010,$00FF,$0008; $005454 MOVE.W  #$0010,$00FF0008
        DC.W    $31FC,$0000,$C8AA   ; $00545C MOVE.W  #$0000,$C8AA.W
        DC.W    $31FC,$0000,$C080   ; $005462 MOVE.W  #$0000,$C080.W
        DC.W    $4EBA,$F540         ; $005468 JSR     loc_0049AA(PC)
        DC.W    $4EBA,$7924         ; $00546C JSR     $00CD92(PC)
        DC.W    $11FC,$0000,$C314   ; $005470 MOVE.B  #$0000,$C314.W
        DC.W    $0838,$0000,$C818   ; $005476 BTST    #0,$C818.W
        DC.W    $6706               ; $00547C BEQ.S  loc_005484
        DC.W    $11FC,$0001,$C314   ; $00547E MOVE.B  #$0001,$C314.W
loc_005484:
        DC.W    $7000               ; $005484 MOVEQ   #$00,D0
        DC.W    $4EBA,$77EC         ; $005486 JSR     $00CC74(PC)
        DC.W    $4EBA,$73E4         ; $00548A JSR     $00C870(PC)
        DC.W    $4EBA,$7580         ; $00548E JSR     $00CA10(PC)
        DC.W    $4EBA,$77F4         ; $005492 JSR     $00CC88(PC)
        DC.W    $4EBA,$65C6         ; $005496 JSR     $00BA5E(PC)
        DC.W    $7000               ; $00549A MOVEQ   #$00,D0
        DC.W    $7200               ; $00549C MOVEQ   #$00,D1
        DC.W    $4EBA,$7932         ; $00549E JSR     $00CDD2(PC)
        DC.W    $4EBA,$78A8         ; $0054A2 JSR     $00CD4C(PC)
        DC.W    $4EBA,$533A         ; $0054A6 JSR     $00A7E2(PC)
        DC.W    $4EBA,$4C98         ; $0054AA JSR     $00A144(PC)
        DC.W    $41F8,$9000         ; $0054AE LEA     $9000.W,A0
        DC.W    $4EBA,$4D48         ; $0054B2 JSR     $00A1FC(PC)
        DC.W    $4EBA,$74BC         ; $0054B6 JSR     $00C974(PC)
        DC.W    $4EBA,$7A50         ; $0054BA JSR     $00CF0C(PC)
        DC.W    $4EBA,$7746         ; $0054BE JSR     $00CC06(PC)
        DC.W    $4EBA,$7AEA         ; $0054C2 JSR     $00CFAE(PC)
        DC.W    $4EBA,$77AA         ; $0054C6 JSR     $00CC72(PC)
        DC.W    $33FC,$0090,$00FF,$60CC; $0054CA MOVE.W  #$0090,$00FF60CC
        DC.W    $31FC,$0000,$C87E   ; $0054D2 MOVE.W  #$0000,$C87E.W
        DC.W    $4EBA,$03EE         ; $0054D8 JSR     loc_0058C8(PC)
        DC.W    $4EBA,$042A         ; $0054DC JSR     loc_005908(PC)
        DC.W    $4EBA,$045A         ; $0054E0 JSR     loc_00593C(PC)
        DC.W    $0239,$00FC,$00A1,$5181; $0054E4 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $0054EC ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $0054F4 MOVE.W  #$8083,$00A15100
        DC.W    $4EBA,$CB4C         ; $0054FC JSR     $00204A(PC)
        DC.W    $4EBA,$CBC4         ; $005500 JSR     $0020C6(PC)
        DC.W    $08F8,$0006,$C875   ; $005504 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00550A MOVE.W  $C874.W,(A5)
        DC.W    $4EB9,$0088,$4998   ; $00550E JSR     $00884998
        DC.W    $3038,$C8A0         ; $005514 MOVE.W  $C8A0.W,D0
        DC.W    $41F9,$008B,$B1C4   ; $005518 LEA     $008BB1C4,A0
        DC.W    $21F0,$0000,$C96C   ; $00551E MOVE.L  $00(A0,D0.W),$C96C.W
        DC.W    $11FC,$0001,$C809   ; $005524 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0002,$C80A   ; $00552A MOVE.B  #$0002,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $005530 BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $005536 MOVE.B  #$0001,$C802.W
loc_00553C:
        DC.W    $0839,$0000,$00A1,$5123; $00553C BTST    #0,$00A15123
        DC.W    $67F6               ; $005544 BEQ.S  loc_00553C
        DC.W    $08B9,$0000,$00A1,$5123; $005546 BCLR    #0,$00A15123
        DC.W    $11FC,$009B,$C8A5   ; $00554E MOVE.B  #$009B,$C8A5.W
        DC.W    $4EB9,$0088,$2080   ; $005554 JSR     $00882080
        DC.W    $4EB9,$0088,$4998   ; $00555A JSR     $00884998
        DC.W    $31FC,$0105,$C8A8   ; $005560 MOVE.W  #$0105,$C8A8.W
        DC.W    $23FC,$0088,$5586,$00FF,$0002; $005566 MOVE.L  #$00885586,$00FF0002
        DC.W    $23FC,$0000,$0000,$00FF,$5FF8; $005570 MOVE.L  #$00000000,$00FF5FF8
        DC.W    $23FC,$0000,$0000,$00FF,$5FFC; $00557A MOVE.L  #$00000000,$00FF5FFC
        DC.W    $4E75               ; $005584 RTS
        DC.W    $3038,$C87E         ; $005586 MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $00558A MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00558E JMP     (A1)
        DC.W    $0088,$55A0,$0088   ; $005590 ORI.L  #$55A00088,A0
        DC.W    $55BA,$0088         ; $005596 SUBQ.L  #2,$0088(PC)
        DC.W    $55D0               ; $00559A SCS     (A0)
        DC.W    $0088,$55FE,$4EBA   ; $00559C ORI.L  #$55FE4EBA,A0
        DC.W    $D320               ; $0055A2 ADD.B  D1,-(A0)
        DC.W    $4EBA,$CC24         ; $0055A4 JSR     $0021CA(PC)
        DC.W    $4EBA,$031E         ; $0055A8 JSR     loc_0058C8(PC)
        DC.W    $5878,$C87E         ; $0055AC ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $0055B0 MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $0055B8 RTS
        DC.W    $4EBA,$CC0E         ; $0055BA JSR     $0021CA(PC)
        DC.W    $4EBA,$0348         ; $0055BE JSR     loc_005908(PC)
        DC.W    $5878,$C87E         ; $0055C2 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $0055C6 MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $0055CE RTS
        DC.W    $4EBA,$CBF8         ; $0055D0 JSR     $0021CA(PC)
        DC.W    $4EBA,$C1C8         ; $0055D4 JSR     $00179E(PC)
        DC.W    $5278,$C8AA         ; $0055D8 ADDQ.W  #1,$C8AA.W
        DC.W    $4EBA,$035E         ; $0055DC JSR     loc_00593C(PC)
        DC.W    $4EBA,$665E         ; $0055E0 JSR     $00BC40(PC)
        DC.W    $4EBA,$64EE         ; $0055E4 JSR     $00BAD4(PC)
        DC.W    $4EBA,$60F0         ; $0055E8 JSR     $00B6DA(PC)
        DC.W    $4EBA,$6096         ; $0055EC JSR     $00B684(PC)
        DC.W    $5878,$C87E         ; $0055F0 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0054,$00FF,$0008; $0055F4 MOVE.W  #$0054,$00FF0008
        DC.W    $4E75               ; $0055FC RTS
        DC.W    $4EBA,$CBCA         ; $0055FE JSR     $0021CA(PC)
        DC.W    $4EBA,$C19A         ; $005602 JSR     $00179E(PC)
        DC.W    $4EBA,$64CC         ; $005606 JSR     $00BAD4(PC)
        DC.W    $5238,$C886         ; $00560A ADDQ.B  #1,$C886.W
        DC.W    $33FC,$0054,$00FF,$0008; $00560E MOVE.W  #$0054,$00FF0008
        DC.W    $4E75               ; $005616 RTS
        DC.W    $3038,$C87E         ; $005618 MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $00561C MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $005620 JMP     (A1)
        DC.W    $0088,$5636,$0088   ; $005622 ORI.L  #$56360088,A0
        DC.W    $5658               ; $005628 ADDQ.W  #3,(A0)+
        DC.W    $0088,$5676,$0088   ; $00562A ORI.L  #$56760088,A0
        DC.W    $56CE,$0088         ; $005630 DBNE    D6,loc_0056BA
        DC.W    $573C,$4EBA         ; $005634 SUBQ.B  #3,#$4EBA
        DC.W    $D28A               ; $005638 ADD.L  A2,D1
        DC.W    $4EBA,$CB8E         ; $00563A JSR     $0021CA(PC)
        DC.W    $4EBA,$327E         ; $00563E JSR     $0088BE(PC)
        DC.W    $4EBA,$0284         ; $005642 JSR     loc_0058C8(PC)
        DC.W    $5238,$C886         ; $005646 ADDQ.B  #1,$C886.W
        DC.W    $5878,$C87E         ; $00564A ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $00564E MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $005656 RTS
        DC.W    $4EBA,$CB70         ; $005658 JSR     $0021CA(PC)
        DC.W    $4EBA,$59CE         ; $00565C JSR     $00B02C(PC)
        DC.W    $4EBA,$5FD0         ; $005660 JSR     $00B632(PC)
        DC.W    $4EBA,$02A2         ; $005664 JSR     loc_005908(PC)
        DC.W    $5878,$C87E         ; $005668 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $00566C MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $005674 RTS
        DC.W    $4EBA,$CB52         ; $005676 JSR     $0021CA(PC)
        DC.W    $4EBA,$C122         ; $00567A JSR     $00179E(PC)
        DC.W    $4EBA,$5E84         ; $00567E JSR     $00B504(PC)
        DC.W    $4EBA,$5E9E         ; $005682 JSR     $00B522(PC)
        DC.W    $5278,$C8AA         ; $005686 ADDQ.W  #1,$C8AA.W
        DC.W    $21FC,$FFFF,$0000,$C970; $00568A MOVE.L  #$FFFF0000,$C970.W
        DC.W    $3078,$C8C0         ; $005692 MOVEA.W $C8C0.W,A0
        DC.W    $1018               ; $005696 MOVE.B  (A0)+,D0
        DC.W    $1200               ; $005698 MOVE.B  D0,D1
        DC.W    $0200,$005C         ; $00569A ANDI.B  #$005C,D0
        DC.W    $11C0,$C971         ; $00569E MOVE.B  D0,$C971.W
        DC.W    $0201,$0003         ; $0056A2 ANDI.B  #$0003,D1
        DC.W    $11C1,$C973         ; $0056A6 MOVE.B  D1,$C973.W
        DC.W    $31C8,$C8C0         ; $0056AA MOVE.W  A0,$C8C0.W
        DC.W    $4EBA,$5F1A         ; $0056AE JSR     $00B5CA(PC)
        DC.W    $4EBA,$0288         ; $0056B2 JSR     loc_00593C(PC)
        DC.W    $4EBA,$6022         ; $0056B6 JSR     $00B6DA(PC)
loc_0056BA:
        DC.W    $4EBA,$5FC8         ; $0056BA JSR     $00B684(PC)
        DC.W    $5878,$C87E         ; $0056BE ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0054,$00FF,$0008; $0056C2 MOVE.W  #$0054,$00FF0008
        DC.W    $4EFA,$002C         ; $0056CA JMP     loc_0056F8(PC)
        DC.W    $4EBA,$CAFA         ; $0056CE JSR     $0021CA(PC)
        DC.W    $4EBA,$C0CA         ; $0056D2 JSR     $00179E(PC)
        DC.W    $5238,$C886         ; $0056D6 ADDQ.B  #1,$C886.W
        DC.W    $33FC,$0054,$00FF,$0008; $0056DA MOVE.W  #$0054,$00FF0008
        DC.W    $4E75               ; $0056E2 RTS
        DC.W    $08B8,$0007,$FDA8   ; $0056E4 BCLR    #7,$FDA8.W
        DC.W    $4EFA,$7D9E         ; $0056EA JMP     $00D48A(PC)
        DC.W    $08F8,$0007,$FDA8   ; $0056EE BSET    #7,$FDA8.W
        DC.W    $4EFA,$7D94         ; $0056F4 JMP     $00D48A(PC)
loc_0056F8:
        DC.W    $1038,$C86D         ; $0056F8 MOVE.B  $C86D.W,D0
        DC.W    $0838,$0004,$C80E   ; $0056FC BTST    #4,$C80E.W
        DC.W    $6704               ; $005702 BEQ.S  loc_005708
        DC.W    $8038,$C86F         ; $005704 OR.B   $C86F.W,D0
loc_005708:
        DC.W    $0800,$0007         ; $005708 BTST    #7,D0
        DC.W    $672C               ; $00570C BEQ.S  loc_00573A
        DC.W    $4A38,$C800         ; $00570E TST.B  $C800.W
        DC.W    $6626               ; $005712 BNE.S  loc_00573A
        DC.W    $13FC,$0001,$00FF,$69F0; $005714 MOVE.B  #$0001,$00FF69F0
        DC.W    $4EBA,$F28C         ; $00571C JSR     loc_0049AA(PC)
        DC.W    $11FC,$0000,$A510   ; $005720 MOVE.B  #$0000,$A510.W
        DC.W    $31FC,$0C00,$C8C4   ; $005726 MOVE.W  #$0C00,$C8C4.W
        DC.W    $31FC,$0010,$C87E   ; $00572C MOVE.W  #$0010,$C87E.W
        DC.W    $33FC,$0044,$00FF,$0008; $005732 MOVE.W  #$0044,$00FF0008
loc_00573A:
        DC.W    $4E75               ; $00573A RTS
        DC.W    $4EBA,$CA8C         ; $00573C JSR     $0021CA(PC)
        DC.W    $5238,$A510         ; $005740 ADDQ.B  #1,$A510.W
        DC.W    $7000               ; $005744 MOVEQ   #$00,D0
        DC.W    $1038,$C8C4         ; $005746 MOVE.B  $C8C4.W,D0
        DC.W    $227B,$0004         ; $00574A MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00574E JMP     (A1)
        DC.W    $0088,$5760,$0088   ; $005750 ORI.L  #$57600088,A0
        DC.W    $5772,$0088         ; $005756 SUBQ.W  #3,-$78(A2,D0.W)
        DC.W    $5780               ; $00575A SUBQ.L  #3,D0
        DC.W    $0088,$57BC,$4EBA   ; $00575C ORI.L  #$57BC4EBA,A0
        DC.W    $D160               ; $005762 ADD.W  D0,-(A0)
        DC.W    $5838,$C8C4         ; $005764 ADDQ.B  #4,$C8C4.W
        DC.W    $33FC,$0020,$00FF,$0008; $005768 MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $005770 RTS
        DC.W    $5838,$C8C4         ; $005772 ADDQ.B  #4,$C8C4.W
        DC.W    $33FC,$0020,$00FF,$0008; $005776 MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $00577E RTS
        DC.W    $4EBA,$C01C         ; $005780 JSR     $00179E(PC)
        DC.W    $5838,$C8C4         ; $005784 ADDQ.B  #4,$C8C4.W
        DC.W    $33FC,$0044,$00FF,$0008; $005788 MOVE.W  #$0044,$00FF0008
        DC.W    $7000               ; $005790 MOVEQ   #$00,D0
        DC.W    $1038,$C8C5         ; $005792 MOVE.B  $C8C5.W,D0
        DC.W    $227B,$000C         ; $005796 MOVEA.L $0C(PC,D0.W),A1
        DC.W    $4E91               ; $00579A JSR     (A1)
        DC.W    $4EBA,$5F3C         ; $00579C JSR     $00B6DA(PC)
        DC.W    $4EFA,$5EE2         ; $0057A0 JMP     $00B684(PC)
        DC.W    $0088,$57CA,$0088   ; $0057A4 ORI.L  #$57CA0088,A0
        DC.W    $57D0               ; $0057AA SEQ     (A0)
        DC.W    $0088,$57D8,$0088   ; $0057AC ORI.L  #$57D80088,A0
        DC.W    $584A               ; $0057B2 ADDQ.W  #4,A2
        DC.W    $0088,$5866,$0088   ; $0057B4 ORI.L  #$58660088,A0
        DC.W    $58B4,$5238         ; $0057BA ADDQ.L  #4,$38(A4,D5.W)
        DC.W    $C886               ; $0057BE AND.L  D6,D4
        DC.W    $33FC,$0044,$00FF,$0008; $0057C0 MOVE.W  #$0044,$00FF0008
        DC.W    $4E75               ; $0057C8 RTS
        DC.W    $5838,$C8C5         ; $0057CA ADDQ.B  #4,$C8C5.W
        DC.W    $4E75               ; $0057CE RTS
        DC.W    $5838,$C8C5         ; $0057D0 ADDQ.B  #4,$C8C5.W
        DC.W    $4EFA,$CC96         ; $0057D4 JMP     $00246C(PC)
        DC.W    $7000               ; $0057D8 MOVEQ   #$00,D0
        DC.W    $0838,$0005,$A510   ; $0057DA BTST    #5,$A510.W
        DC.W    $6604               ; $0057E0 BNE.S  loc_0057E6
        DC.W    $303C,$0001         ; $0057E2 MOVE.W  #$0001,D0
loc_0057E6:
        DC.W    $13C0,$00FF,$69F0   ; $0057E6 MOVE.B  D0,$00FF69F0
        DC.W    $1038,$C86C         ; $0057EC MOVE.B  $C86C.W,D0
        DC.W    $0838,$0004,$C80E   ; $0057F0 BTST    #4,$C80E.W
        DC.W    $6704               ; $0057F6 BEQ.S  loc_0057FC
        DC.W    $8038,$C86E         ; $0057F8 OR.B   $C86E.W,D0
loc_0057FC:
        DC.W    $0C00,$0070         ; $0057FC CMPI.B  #$0070,D0
        DC.W    $6720               ; $005800 BEQ.S  loc_005822
        DC.W    $1038,$C86D         ; $005802 MOVE.B  $C86D.W,D0
        DC.W    $0838,$0004,$C80E   ; $005806 BTST    #4,$C80E.W
        DC.W    $6704               ; $00580C BEQ.S  loc_005812
        DC.W    $8038,$C86F         ; $00580E OR.B   $C86F.W,D0
loc_005812:
        DC.W    $0800,$0007         ; $005812 BTST    #7,D0
        DC.W    $6602               ; $005816 BNE.S  loc_00581A
        DC.W    $4E75               ; $005818 RTS
loc_00581A:
        DC.W    $11FC,$0014,$C8C5   ; $00581A MOVE.B  #$0014,$C8C5.W
        DC.W    $4E75               ; $005820 RTS
loc_005822:
        DC.W    $4EBA,$CC50         ; $005822 JSR     $002474(PC)
        DC.W    $11FC,$0001,$C809   ; $005826 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00582C MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $005832 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $005838 MOVE.B  #$0001,$C802.W
        DC.W    $11FC,$00F3,$C822   ; $00583E MOVE.B  #$00F3,$C822.W
        DC.W    $5838,$C8C5         ; $005844 ADDQ.B  #4,$C8C5.W
        DC.W    $4E75               ; $005848 RTS
        DC.W    $0838,$0007,$C80E   ; $00584A BTST    #7,$C80E.W
        DC.W    $6612               ; $005850 BNE.S  loc_005864
        DC.W    $3ABC,$8B00         ; $005852 MOVE.W  #$8B00,(A5)
        DC.W    $7000               ; $005856 MOVEQ   #$00,D0
        DC.W    $11C0,$C304         ; $005858 MOVE.B  D0,$C304.W
        DC.W    $11C0,$C30C         ; $00585C MOVE.B  D0,$C30C.W
        DC.W    $5838,$C8C5         ; $005860 ADDQ.B  #4,$C8C5.W
loc_005864:
        DC.W    $4E75               ; $005864 RTS
        DC.W    $4EBA,$5C62         ; $005866 JSR     $00B4CA(PC)
        DC.W    $2039,$00FF,$0002   ; $00586A MOVE.L  $00FF0002,D0
        DC.W    $72FC               ; $005870 MOVEQ   #-$04,D1
        DC.W    $7E03               ; $005872 MOVEQ   #$03,D7
        DC.W    $43FA,$001E         ; $005874 LEA     $001E(PC),A1
loc_005878:
        DC.W    $5841               ; $005878 ADDQ.W  #4,D1
        DC.W    $B099               ; $00587A CMP.L  (A1)+,D0
        DC.W    $57CF,$FFFA         ; $00587C DBEQ    D7,loc_005878
        DC.W    $23FB,$1022,$00FF,$0002; $005880 MOVE.L  $22(PC,D1.W),$00FF0002
        DC.W    $33FC,$0020,$00FF,$0008; $005888 MOVE.W  #$0020,$00FF0008
        DC.W    $4EFA,$CFFE         ; $005890 JMP     $002890(PC)
        DC.W    $0088,$5618,$0088   ; $005894 ORI.L  #$56180088,A0
        DC.W    $5308               ; $00589A SUBQ.B  #1,A0
        DC.W    $0088,$5024,$0088   ; $00589C ORI.L  #$50240088,A0
        DC.W    $4CBC,$0089,$09AE   ; $0058A2 MOVEM.W D0/D3/D7,#$09AE
        DC.W    $0088,$FB98,$0088   ; $0058A8 ORI.L  #$FB980088,A0
        DC.W    $FB98,$0088         ; $0058AE MOVE.W  (A0)+,-$78(A5,D0.W)
        DC.W    $FB98,$13FC         ; $0058B2 MOVE.W  (A0)+,-$04(A5,D1.W)
        DC.W    $0000,$00FF         ; $0058B6 ORI.B  #$00FF,D0
        DC.W    $69F0               ; $0058BA BVS.S  loc_0058AC
        DC.W    $4EBA,$F0EC         ; $0058BC JSR     loc_0049AA(PC)
        DC.W    $5838,$C8C5         ; $0058C0 ADDQ.B  #4,$C8C5.W
        DC.W    $4EFA,$CBAE         ; $0058C4 JMP     $002474(PC)
loc_0058C8:
        DC.W    $4EBA,$12C0         ; $0058C8 JSR     $006B8A(PC)
        DC.W    $49F8,$A000         ; $0058CC LEA     $A000.W,A4
        DC.W    $3038,$C26C         ; $0058D0 MOVE.W  $C26C.W,D0
        DC.W    $0838,$0007,$C81C   ; $0058D4 BTST    #7,$C81C.W
        DC.W    $6606               ; $0058DA BNE.S  loc_0058E2
        DC.W    $4A78,$C89C         ; $0058DC TST.W  $C89C.W
        DC.W    $6708               ; $0058E0 BEQ.S  loc_0058EA
loc_0058E2:
        DC.W    $0240,$0138         ; $0058E2 ANDI.W  #$0138,D0
        DC.W    $6708               ; $0058E6 BEQ.S  loc_0058F0
loc_0058E8:
        DC.W    $4E75               ; $0058E8 RTS
loc_0058EA:
        DC.W    $0240,$0130         ; $0058EA ANDI.W  #$0130,D0
        DC.W    $66F8               ; $0058EE BNE.S  loc_0058E8
loc_0058F0:
        DC.W    $13FC,$0000,$00FF,$5FFE; $0058F0 MOVE.B  #$0000,$00FF5FFE
        DC.W    $41F8,$9100         ; $0058F8 LEA     $9100.W,A0
        DC.W    $7E05               ; $0058FC MOVEQ   #$05,D7
loc_0058FE:
        DC.W    $4EBA,$00EC         ; $0058FE JSR     loc_0059EC(PC)
        DC.W    $51CF,$FFFA         ; $005902 DBRA    D7,loc_0058FE
        DC.W    $4E75               ; $005906 RTS
loc_005908:
        DC.W    $49F8,$A000         ; $005908 LEA     $A000.W,A4
        DC.W    $3038,$C26C         ; $00590C MOVE.W  $C26C.W,D0
        DC.W    $0838,$0007,$C81C   ; $005910 BTST    #7,$C81C.W
        DC.W    $6606               ; $005916 BNE.S  loc_00591E
        DC.W    $4A78,$C89C         ; $005918 TST.W  $C89C.W
        DC.W    $6708               ; $00591C BEQ.S  loc_005926
loc_00591E:
        DC.W    $0240,$0138         ; $00591E ANDI.W  #$0138,D0
        DC.W    $6708               ; $005922 BEQ.S  loc_00592C
loc_005924:
        DC.W    $4E75               ; $005924 RTS
loc_005926:
        DC.W    $0240,$0130         ; $005926 ANDI.W  #$0130,D0
        DC.W    $66F8               ; $00592A BNE.S  loc_005924
loc_00592C:
        DC.W    $41F8,$9700         ; $00592C LEA     $9700.W,A0
        DC.W    $7E07               ; $005930 MOVEQ   #$07,D7
loc_005932:
        DC.W    $4EBA,$00B8         ; $005932 JSR     loc_0059EC(PC)
        DC.W    $51CF,$FFFA         ; $005936 DBRA    D7,loc_005932
        DC.W    $4E75               ; $00593A RTS
loc_00593C:
        DC.W    $49F8,$A000         ; $00593C LEA     $A000.W,A4
        DC.W    $3038,$C26C         ; $005940 MOVE.W  $C26C.W,D0
        DC.W    $0838,$0007,$C81C   ; $005944 BTST    #7,$C81C.W
        DC.W    $6606               ; $00594A BNE.S  loc_005952
        DC.W    $4A78,$C89C         ; $00594C TST.W  $C89C.W
loc_005950:
        DC.W    $6708               ; $005950 BEQ.S  loc_00595A
loc_005952:
        DC.W    $0240,$0138         ; $005952 ANDI.W  #$0138,D0
        DC.W    $670A               ; $005956 BEQ.S  loc_005962
        DC.W    $6010               ; $005958 BRA.S  loc_00596A
loc_00595A:
        DC.W    $0240,$0130         ; $00595A ANDI.W  #$0130,D0
        DC.W    $6702               ; $00595E BEQ.S  loc_005962
        DC.W    $6008               ; $005960 BRA.S  loc_00596A
loc_005962:
        DC.W    $41F8,$9F00         ; $005962 LEA     $9F00.W,A0
        DC.W    $4EBA,$0084         ; $005966 JSR     loc_0059EC(PC)
loc_00596A:
        DC.W    $41F8,$9000         ; $00596A LEA     $9000.W,A0
        DC.W    $2168,$00B2,$0018   ; $00596E MOVE.L  $00B2(A0),$0018(A0)
        DC.W    $1228,$00E5         ; $005974 MOVE.B  $00E5(A0),D1
loc_005978:
        DC.W    $0201,$0006         ; $005978 ANDI.B  #$0006,D1
        DC.W    $6706               ; $00597C BEQ.S  loc_005984
        DC.W    $2178,$C70C,$0018   ; $00597E MOVE.L  $C70C.W,$0018(A0)
loc_005984:
        DC.W    $3038,$C07A         ; $005984 MOVE.W  $C07A.W,D0
        DC.W    $0838,$0003,$C80E   ; $005988 BTST    #3,$C80E.W
        DC.W    $6606               ; $00598E BNE.S  loc_005996
        DC.W    $227B,$000A         ; $005990 MOVEA.L $0A(PC,D0.W),A1
        DC.W    $4ED1               ; $005994 JMP     (A1)
loc_005996:
        DC.W    $227B,$002C         ; $005996 MOVEA.L $2C(PC,D0.W),A1
        DC.W    $4ED1               ; $00599A JMP     (A1)
        DC.W    $0088,$5AB6,$0088   ; $00599C ORI.L  #$5AB60088,A0
        DC.W    $5B6E,$0088         ; $0059A2 SUBQ.W  #5,$0088(A6)
        DC.W    $5BE0               ; $0059A6 SMI     -(A0)
loc_0059A8:
        DC.W    $0088,$5C5A,$0088   ; $0059A8 ORI.L  #$5C5A0088,A0
        DC.W    $5D08               ; $0059AE SUBQ.B  #6,A0
        DC.W    $0088,$5DE0,$0088   ; $0059B0 ORI.L  #$5DE00088,A0
        DC.W    $5E38,$0088         ; $0059B6 ADDQ.B  #7,$0088.W
        DC.W    $6394               ; $0059BA BLS.S  loc_005950
        DC.W    $0088,$633A,$0088   ; $0059BC ORI.L  #$633A0088,A0
        DC.W    $5BEC,$0088         ; $0059C2 SMI     $0088(A4)
        DC.W    $5EEA,$0088         ; $0059C6 SGT     $0088(A2)
        DC.W    $5F9A               ; $0059CA SUBQ.L  #7,(A2)+
        DC.W    $0088,$6008,$0088   ; $0059CC ORI.L  #$60080088,A0
        DC.W    $60D4               ; $0059D2 BRA.S  loc_0059A8
        DC.W    $0088,$617A,$0088   ; $0059D4 ORI.L  #$617A0088,A0
        DC.W    $5DE0               ; $0059DA SLT     -(A0)
        DC.W    $0088,$6292,$0088   ; $0059DC ORI.L  #$62920088,A0
        DC.W    $6394               ; $0059E2 BLS.S  loc_005978
        DC.W    $0088,$633A,$0088   ; $0059E4 ORI.L  #$633A0088,A0
        DC.W    $6014               ; $0059EA BRA.S  loc_005A00
loc_0059EC:
        DC.W    $3F07               ; $0059EC MOVE.W  D7,-(A7)
        DC.W    $4EBA,$4122         ; $0059EE JSR     $009B12(PC)
        DC.W    $4EBA,$49C6         ; $0059F2 JSR     $00A3BA(PC)
        DC.W    $4EBA,$49F2         ; $0059F6 JSR     $00A3EA(PC)
        DC.W    $4EBA,$4A74         ; $0059FA JSR     $00A470(PC)
        DC.W    $3028,$0054         ; $0059FE MOVE.W  $0054(A0),D0
        DC.W    $0240,$0009         ; $005A02 ANDI.W  #$0009,D0
        DC.W    $6714               ; $005A06 BEQ.S  loc_005A1C
        DC.W    $4A68,$006A         ; $005A08 TST.W  $006A(A0)
        DC.W    $660E               ; $005A0C BNE.S  loc_005A1C
        DC.W    $0C68,$0064,$0004   ; $005A0E CMPI.W  #$0064,$0004(A0)
        DC.W    $6F06               ; $005A14 BLE.S  loc_005A1C
        DC.W    $0068,$1000,$0002   ; $005A16 ORI.W  #$1000,$0002(A0)
loc_005A1C:
        DC.W    $4EBA,$4932         ; $005A1C JSR     $00A350(PC)
        DC.W    $4A68,$0004         ; $005A20 TST.W  $0004(A0)
        DC.W    $670C               ; $005A24 BEQ.S  loc_005A32
        DC.W    $0468,$2000,$00BC   ; $005A26 SUBI.W  #$2000,$00BC(A0)
        DC.W    $0468,$1800,$00C4   ; $005A2C SUBI.W  #$1800,$00C4(A0)
loc_005A32:
        DC.W    $4EBA,$2082         ; $005A32 JSR     $007AB6(PC)
        DC.W    $43F9,$0093,$AC2C   ; $005A36 LEA     $0093AC2C,A1
        DC.W    $3028,$00C8         ; $005A3C MOVE.W  $00C8(A0),D0
        DC.W    $9068,$0032         ; $005A40 SUB.W  $0032(A0),D0
        DC.W    $D040               ; $005A44 ADD.W  D0,D0
        DC.W    $6B0A               ; $005A46 BMI.S  loc_005A52
        DC.W    $0240,$03FF         ; $005A48 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $005A4C MOVE.W  $00(A1,D0.W),D0
        DC.W    $600C               ; $005A50 BRA.S  loc_005A5E
loc_005A52:
        DC.W    $4440               ; $005A52 NEG.W  D0
        DC.W    $0240,$03FF         ; $005A54 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $005A58 MOVE.W  $00(A1,D0.W),D0
        DC.W    $4440               ; $005A5C NEG.W  D0
loc_005A5E:
        DC.W    $3140,$003A         ; $005A5E MOVE.W  D0,$003A(A0)
        DC.W    $43F9,$0093,$A82C   ; $005A62 LEA     $0093A82C,A1
        DC.W    $3028,$0032         ; $005A68 MOVE.W  $0032(A0),D0
        DC.W    $9068,$00C6         ; $005A6C SUB.W  $00C6(A0),D0
        DC.W    $D040               ; $005A70 ADD.W  D0,D0
        DC.W    $6B0A               ; $005A72 BMI.S  loc_005A7E
        DC.W    $0240,$03FF         ; $005A74 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $005A78 MOVE.W  $00(A1,D0.W),D0
        DC.W    $600C               ; $005A7C BRA.S  loc_005A8A
loc_005A7E:
        DC.W    $4440               ; $005A7E NEG.W  D0
        DC.W    $0240,$03FF         ; $005A80 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $005A84 MOVE.W  $00(A1,D0.W),D0
        DC.W    $4440               ; $005A88 NEG.W  D0
loc_005A8A:
        DC.W    $3140,$003E         ; $005A8A MOVE.W  D0,$003E(A0)
        DC.W    $3168,$006E,$0046   ; $005A8E MOVE.W  $006E(A0),$0046(A0)
        DC.W    $4EBA,$1BB8         ; $005A94 JSR     $00764E(PC)
        DC.W    $4EBA,$16B0         ; $005A98 JSR     $00714A(PC)
        DC.W    $3028,$0026         ; $005A9C MOVE.W  $0026(A0),D0
        DC.W    $9068,$0024         ; $005AA0 SUB.W  $0024(A0),D0
        DC.W    $0C40,$0064         ; $005AA4 CMPI.W  #$0064,D0
        DC.W    $6D04               ; $005AA8 BLT.S  loc_005AAE
        DC.W    $5268,$002C         ; $005AAA ADDQ.W  #1,$002C(A0)
loc_005AAE:
        DC.W    $41E8,$0100         ; $005AAE LEA     $0100(A0),A0
        DC.W    $3E1F               ; $005AB2 MOVE.W  (A7)+,D7
        DC.W    $4E75               ; $005AB4 RTS
        DC.W    $4EBA,$5CC4         ; $005AB6 JSR     $00B77C(PC)
        DC.W    $7000               ; $005ABA MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $005ABC MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $005AC0 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $005AC4 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$2AFA         ; $005AC8 JSR     $0085C4(PC)
        DC.W    $4EBA,$2ACC         ; $005ACC JSR     $00859A(PC)
        DC.W    $4EBA,$487E         ; $005AD0 JSR     $00A350(PC)
        DC.W    $4EBA,$269A         ; $005AD4 JSR     $008170(PC)
        DC.W    $4EBA,$25F2         ; $005AD8 JSR     $0080CC(PC)
        DC.W    $4EBA,$2A6A         ; $005ADC JSR     $008548(PC)
        DC.W    $4EBA,$3A18         ; $005AE0 JSR     $0094FA(PC)
        DC.W    $4EBA,$382C         ; $005AE4 JSR     $009312(PC)
        DC.W    $4EBA,$4028         ; $005AE8 JSR     $009B12(PC)
        DC.W    $4EBA,$3694         ; $005AEC JSR     $009182(PC)
        DC.W    $4EBA,$3B2C         ; $005AF0 JSR     $00961E(PC)
        DC.W    $4EBA,$3B92         ; $005AF4 JSR     $009688(PC)
        DC.W    $4EBA,$3D08         ; $005AF8 JSR     $009802(PC)
        DC.W    $4EBA,$237C         ; $005AFC JSR     $007E7A(PC)
        DC.W    $4EBA,$1496         ; $005B00 JSR     $006F98(PC)
        DC.W    $4EBA,$21D2         ; $005B04 JSR     $007CD8(PC)
        DC.W    $4EBA,$492A         ; $005B08 JSR     $00A434(PC)
        DC.W    $4EBA,$159C         ; $005B0C JSR     $0070AA(PC)
loc_005B10:
        DC.W    $4EBA,$23F2         ; $005B10 JSR     $007F04(PC)
        DC.W    $4EBA,$4358         ; $005B14 JSR     $009E6E(PC)
        DC.W    $4EBA,$2134         ; $005B18 JSR     $007C4E(PC)
        DC.W    $4EBA,$162C         ; $005B1C JSR     $00714A(PC)
        DC.W    $4EBA,$1B2C         ; $005B20 JSR     $00764E(PC)
        DC.W    $4EBA,$242A         ; $005B24 JSR     $007F50(PC)
        DC.W    $4EBA,$41A4         ; $005B28 JSR     $009CCE(PC)
        DC.W    $4EBA,$5110         ; $005B2C JSR     $00AC3E(PC)
        DC.W    $4EBA,$4022         ; $005B30 JSR     $009B54(PC)
        DC.W    $4EBA,$2BC8         ; $005B34 JSR     $0086FE(PC)
        DC.W    $4EBA,$3506         ; $005B38 JSR     $009040(PC)
        DC.W    $4EBA,$5196         ; $005B3C JSR     $00ACD4(PC)
        DC.W    $4EBA,$2696         ; $005B40 JSR     $0081D8(PC)
        DC.W    $4EBA,$437A         ; $005B44 JSR     $009EC0(PC)
        DC.W    $4EBA,$1AB4         ; $005B48 JSR     $0075FE(PC)
        DC.W    $4EBA,$1658         ; $005B4C JSR     $0071A6(PC)
        DC.W    $4EBA,$CE32         ; $005B50 JSR     $002984(PC)
        DC.W    $4EBA,$D650         ; $005B54 JSR     $0031A6(PC)
        DC.W    $4EBA,$DB84         ; $005B58 JSR     $0036DE(PC)
        DC.W    $4EBA,$DC58         ; $005B5C JSR     $0037B6(PC)
        DC.W    $4EBA,$E424         ; $005B60 JSR     $003F86(PC)
        DC.W    $11F8,$C304,$C30C   ; $005B64 MOVE.B  $C304.W,$C30C.W
        DC.W    $4EFA,$109C         ; $005B6A JMP     $006C08(PC)
        DC.W    $4EBA,$5C0C         ; $005B6E JSR     $00B77C(PC)
        DC.W    $4EBA,$47DC         ; $005B72 JSR     $00A350(PC)
        DC.W    $4EBA,$25F8         ; $005B76 JSR     $008170(PC)
        DC.W    $4EBA,$2550         ; $005B7A JSR     $0080CC(PC)
        DC.W    $4EBA,$29C8         ; $005B7E JSR     $008548(PC)
        DC.W    $4EBA,$3A9A         ; $005B82 JSR     $00961E(PC)
        DC.W    $4EBA,$1C8E         ; $005B86 JSR     $007816(PC)
        DC.W    $4EBA,$1AC2         ; $005B8A JSR     $00764E(PC)
        DC.W    $4EBA,$151A         ; $005B8E JSR     $0070AA(PC)
        DC.W    $4EBA,$4D4C         ; $005B92 JSR     $00A8E0(PC)
        DC.W    $4EBA,$3FBC         ; $005B96 JSR     $009B54(PC)
        DC.W    $4EBA,$35E6         ; $005B9A JSR     $009182(PC)
        DC.W    $4EBA,$3C62         ; $005B9E JSR     $009802(PC)
        DC.W    $4EBA,$15A6         ; $005BA2 JSR     $00714A(PC)
        DC.W    $4EBA,$4126         ; $005BA6 JSR     $009CCE(PC)
        DC.W    $4EBA,$2B52         ; $005BAA JSR     $0086FE(PC)
        DC.W    $4EBA,$3490         ; $005BAE JSR     $009040(PC)
        DC.W    $4EBA,$5120         ; $005BB2 JSR     $00ACD4(PC)
        DC.W    $4EBA,$1A46         ; $005BB6 JSR     $0075FE(PC)
        DC.W    $4EBA,$15EA         ; $005BBA JSR     $0071A6(PC)
        DC.W    $4EBA,$CDC4         ; $005BBE JSR     $002984(PC)
        DC.W    $4EBA,$D5E2         ; $005BC2 JSR     $0031A6(PC)
        DC.W    $4EBA,$DB16         ; $005BC6 JSR     $0036DE(PC)
        DC.W    $4EBA,$DBEA         ; $005BCA JSR     $0037B6(PC)
        DC.W    $4EBA,$E3B6         ; $005BCE JSR     $003F86(PC)
        DC.W    $4EBA,$E0F0         ; $005BD2 JSR     $003CC4(PC)
        DC.W    $11F8,$C304,$C30C   ; $005BD6 MOVE.B  $C304.W,$C30C.W
        DC.W    $4EFA,$100C         ; $005BDC JMP     $006BEA(PC)
        DC.W    $317C,$0000,$0006   ; $005BE0 MOVE.W  #$0000,$0006(A0)
        DC.W    $317C,$0000,$0074   ; $005BE6 MOVE.W  #$0000,$0074(A0)
        DC.W    $4EBA,$5B8E         ; $005BEC JSR     $00B77C(PC)
        DC.W    $7000               ; $005BF0 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $005BF2 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $005BF6 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $005BFA MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$EDEE         ; $005BFE JSR     loc_0049EE(PC)
        DC.W    $4EBA,$2996         ; $005C02 JSR     $00859A(PC)
        DC.W    $4EBA,$4748         ; $005C06 JSR     $00A350(PC)
        DC.W    $4EBA,$2564         ; $005C0A JSR     $008170(PC)
        DC.W    $4EBA,$24BC         ; $005C0E JSR     $0080CC(PC)
        DC.W    $4EBA,$2934         ; $005C12 JSR     $008548(PC)
        DC.W    $4EBA,$38E2         ; $005C16 JSR     $0094FA(PC)
        DC.W    $0C78,$0004,$C26C   ; $005C1A CMPI.W  #$0004,$C26C.W
        DC.W    $6704               ; $005C20 BEQ.S  loc_005C26
        DC.W    $4EBA,$36EE         ; $005C22 JSR     $009312(PC)
loc_005C26:
        DC.W    $4EBA,$3EEA         ; $005C26 JSR     $009B12(PC)
        DC.W    $4EBA,$3556         ; $005C2A JSR     $009182(PC)
        DC.W    $4EBA,$3BD2         ; $005C2E JSR     $009802(PC)
        DC.W    $4EBA,$1450         ; $005C32 JSR     $007084(PC)
        DC.W    $4EBA,$1472         ; $005C36 JSR     $0070AA(PC)
        DC.W    $4EBA,$1BDA         ; $005C3A JSR     $007816(PC)
        DC.W    $5378,$C02C         ; $005C3E SUBQ.W  #1,$C02C.W
        DC.W    $6E12               ; $005C42 BGT.S  loc_005C56
        DC.W    $31FC,$0000,$C02C   ; $005C44 MOVE.W  #$0000,$C02C.W
        DC.W    $317C,$0000,$0074   ; $005C4A MOVE.W  #$0000,$0074(A0)
        DC.W    $31F8,$C08C,$C07A   ; $005C50 MOVE.W  $C08C.W,$C07A.W
loc_005C56:
        DC.W    $4EFA,$FEB8         ; $005C56 JMP     loc_005B10(PC)
        DC.W    $4EBA,$5B20         ; $005C5A JSR     $00B77C(PC)
        DC.W    $7000               ; $005C5E MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $005C60 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $005C64 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $005C68 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$292C         ; $005C6C JSR     $00859A(PC)
        DC.W    $4EBA,$46DE         ; $005C70 JSR     $00A350(PC)
        DC.W    $4EBA,$24FA         ; $005C74 JSR     $008170(PC)
        DC.W    $4EBA,$2452         ; $005C78 JSR     $0080CC(PC)
        DC.W    $4EBA,$28CA         ; $005C7C JSR     $008548(PC)
        DC.W    $4EBA,$3B80         ; $005C80 JSR     $009802(PC)
        DC.W    $4EBA,$21F4         ; $005C84 JSR     $007E7A(PC)
        DC.W    $4EBA,$130E         ; $005C88 JSR     $006F98(PC)
        DC.W    $4EBA,$204A         ; $005C8C JSR     $007CD8(PC)
        DC.W    $4EBA,$47A2         ; $005C90 JSR     $00A434(PC)
        DC.W    $4EBA,$1414         ; $005C94 JSR     $0070AA(PC)
        DC.W    $4EBA,$226A         ; $005C98 JSR     $007F04(PC)
        DC.W    $4EBA,$41D0         ; $005C9C JSR     $009E6E(PC)
        DC.W    $4EBA,$1FAC         ; $005CA0 JSR     $007C4E(PC)
        DC.W    $4EBA,$14A4         ; $005CA4 JSR     $00714A(PC)
        DC.W    $4EBA,$19A4         ; $005CA8 JSR     $00764E(PC)
        DC.W    $4EBA,$22A2         ; $005CAC JSR     $007F50(PC)
        DC.W    $4EBA,$401C         ; $005CB0 JSR     $009CCE(PC)
        DC.W    $4EBA,$4F88         ; $005CB4 JSR     $00AC3E(PC)
        DC.W    $4EBA,$2A44         ; $005CB8 JSR     $0086FE(PC)
        DC.W    $4EBA,$3382         ; $005CBC JSR     $009040(PC)
        DC.W    $4EBA,$2516         ; $005CC0 JSR     $0081D8(PC)
        DC.W    $4EBA,$41FA         ; $005CC4 JSR     $009EC0(PC)
        DC.W    $4EBA,$3954         ; $005CC8 JSR     $00961E(PC)
        DC.W    $4EBA,$4C2A         ; $005CCC JSR     $00A8F8(PC)
        DC.W    $0838,$0004,$C30E   ; $005CD0 BTST    #4,$C30E.W
        DC.W    $6706               ; $005CD6 BEQ.S  loc_005CDE
        DC.W    $31F8,$C08C,$C07A   ; $005CD8 MOVE.W  $C08C.W,$C07A.W
loc_005CDE:
        DC.W    $4EBA,$191E         ; $005CDE JSR     $0075FE(PC)
        DC.W    $4EBA,$14C2         ; $005CE2 JSR     $0071A6(PC)
        DC.W    $4EBA,$CC9C         ; $005CE6 JSR     $002984(PC)
        DC.W    $4EBA,$D4BA         ; $005CEA JSR     $0031A6(PC)
        DC.W    $4EBA,$D9EE         ; $005CEE JSR     $0036DE(PC)
        DC.W    $4EBA,$DAC2         ; $005CF2 JSR     $0037B6(PC)
        DC.W    $4A78,$C89C         ; $005CF6 TST.W  $C89C.W
        DC.W    $6604               ; $005CFA BNE.S  loc_005D00
        DC.W    $4EBA,$DFC6         ; $005CFC JSR     $003CC4(PC)
loc_005D00:
        DC.W    $11F8,$C304,$C30C   ; $005D00 MOVE.B  $C304.W,$C30C.W
        DC.W    $4E75               ; $005D06 RTS
        DC.W    $11FC,$0001,$C800   ; $005D08 MOVE.B  #$0001,$C800.W
        DC.W    $7000               ; $005D0E MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $005D10 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $005D14 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $005D18 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$23AE         ; $005D1C JSR     $0080CC(PC)
        DC.W    $4EBA,$2826         ; $005D20 JSR     $008548(PC)
        DC.W    $4EBA,$3ADC         ; $005D24 JSR     $009802(PC)
        DC.W    $4EBA,$2150         ; $005D28 JSR     $007E7A(PC)
        DC.W    $4EBA,$126A         ; $005D2C JSR     $006F98(PC)
        DC.W    $4EBA,$1FA6         ; $005D30 JSR     $007CD8(PC)
        DC.W    $4EBA,$1374         ; $005D34 JSR     $0070AA(PC)
        DC.W    $4EBA,$1410         ; $005D38 JSR     $00714A(PC)
        DC.W    $4EBA,$1910         ; $005D3C JSR     $00764E(PC)
        DC.W    $4EBA,$220E         ; $005D40 JSR     $007F50(PC)
        DC.W    $4EBA,$3F88         ; $005D44 JSR     $009CCE(PC)
        DC.W    $4EBA,$4EF4         ; $005D48 JSR     $00AC3E(PC)
        DC.W    $4EBA,$3E06         ; $005D4C JSR     $009B54(PC)
        DC.W    $4EBA,$29AC         ; $005D50 JSR     $0086FE(PC)
        DC.W    $4EBA,$32EA         ; $005D54 JSR     $009040(PC)
        DC.W    $4EBA,$247E         ; $005D58 JSR     $0081D8(PC)
        DC.W    $4EBA,$18A0         ; $005D5C JSR     $0075FE(PC)
        DC.W    $4EBA,$1444         ; $005D60 JSR     $0071A6(PC)
        DC.W    $4EBA,$CC1E         ; $005D64 JSR     $002984(PC)
        DC.W    $4EBA,$D43C         ; $005D68 JSR     $0031A6(PC)
        DC.W    $4EBA,$D970         ; $005D6C JSR     $0036DE(PC)
        DC.W    $4EBA,$DA44         ; $005D70 JSR     $0037B6(PC)
        DC.W    $4EBA,$E210         ; $005D74 JSR     $003F86(PC)
        DC.W    $11F8,$C304,$C30C   ; $005D78 MOVE.B  $C304.W,$C30C.W
        DC.W    $3038,$C8A0         ; $005D7E MOVE.W  $C8A0.W,D0
        DC.W    $0838,$0007,$C81C   ; $005D82 BTST    #7,$C81C.W
        DC.W    $6702               ; $005D88 BEQ.S  loc_005D8C
        DC.W    $7004               ; $005D8A MOVEQ   #$04,D0
loc_005D8C:
        DC.W    $227B,$003A         ; $005D8C MOVEA.L $3A(PC,D0.W),A1
        DC.W    $4E91               ; $005D90 JSR     (A1)
        DC.W    $0C78,$0014,$C8AA   ; $005D92 CMPI.W  #$0014,$C8AA.W
        DC.W    $662C               ; $005D98 BNE.S  loc_005DC6
        DC.W    $11FC,$0000,$C800   ; $005D9A MOVE.B  #$0000,$C800.W
        DC.W    $31F8,$C092,$C07A   ; $005DA0 MOVE.W  $C092.W,$C07A.W
        DC.W    $31FC,$0004,$C8AC   ; $005DA6 MOVE.W  #$0004,$C8AC.W
        DC.W    $4A78,$C89C         ; $005DAC TST.W  $C89C.W
        DC.W    $6706               ; $005DB0 BEQ.S  loc_005DB8
        DC.W    $31FC,$0020,$C8AC   ; $005DB2 MOVE.W  #$0020,$C8AC.W
loc_005DB8:
        DC.W    $0838,$0007,$C81C   ; $005DB8 BTST    #7,$C81C.W
        DC.W    $6706               ; $005DBE BEQ.S  loc_005DC6
        DC.W    $31FC,$0020,$C8AC   ; $005DC0 MOVE.W  #$0020,$C8AC.W
loc_005DC6:
        DC.W    $4E75               ; $005DC6 RTS
        DC.W    $0088,$3C7E,$0088   ; $005DC8 ORI.L  #$3C7E0088,A0
        DC.W    $3D5A,$0088         ; $005DCE MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$0088         ; $005DD2 MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$0088         ; $005DD6 MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$0088         ; $005DDA MOVE.W  (A2)+,$0088(A6)
        DC.W    $3D5A,$4EBA         ; $005DDE MOVE.W  (A2)+,$4EBA(A6)
        DC.W    $EBC8               ; $005DE2 LSL.W  A0
        DC.W    $4EBA,$5996         ; $005DE4 JSR     $00B77C(PC)
        DC.W    $7000               ; $005DE8 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $005DEA MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $005DEE MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $005DF2 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$12B2         ; $005DF6 JSR     $0070AA(PC)
        DC.W    $4EBA,$134E         ; $005DFA JSR     $00714A(PC)
        DC.W    $4EBA,$184E         ; $005DFE JSR     $00764E(PC)
        DC.W    $4EBA,$214C         ; $005E02 JSR     $007F50(PC)
        DC.W    $4EBA,$3EC6         ; $005E06 JSR     $009CCE(PC)
        DC.W    $4EBA,$28F2         ; $005E0A JSR     $0086FE(PC)
        DC.W    $4EBA,$3230         ; $005E0E JSR     $009040(PC)
        DC.W    $4EBA,$23C4         ; $005E12 JSR     $0081D8(PC)
        DC.W    $4EBA,$E26C         ; $005E16 JSR     $004084(PC)
        DC.W    $4EBA,$17E2         ; $005E1A JSR     $0075FE(PC)
        DC.W    $4EBA,$1386         ; $005E1E JSR     $0071A6(PC)
        DC.W    $4EBA,$CB60         ; $005E22 JSR     $002984(PC)
        DC.W    $4EBA,$D37E         ; $005E26 JSR     $0031A6(PC)
        DC.W    $4EBA,$D8B2         ; $005E2A JSR     $0036DE(PC)
        DC.W    $4EBA,$D986         ; $005E2E JSR     $0037B6(PC)
        DC.W    $4EBA,$D292         ; $005E32 JSR     $0030C6(PC)
        DC.W    $4E75               ; $005E36 RTS
        DC.W    $7000               ; $005E38 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $005E3A MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $005E3E MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $005E42 MOVE.W  D0,$004A(A0)
        DC.W    $21FC,$0010,$0010,$C970; $005E46 MOVE.L  #$00100010,$C970.W
        DC.W    $4EBA,$592C         ; $005E4E JSR     $00B77C(PC)
        DC.W    $317C,$0002,$0092   ; $005E52 MOVE.W  #$0002,$0092(A0)
        DC.W    $4EBA,$2740         ; $005E58 JSR     $00859A(PC)
        DC.W    $4EBA,$44F2         ; $005E5C JSR     $00A350(PC)
        DC.W    $4EBA,$230E         ; $005E60 JSR     $008170(PC)
        DC.W    $4EBA,$2266         ; $005E64 JSR     $0080CC(PC)
        DC.W    $4EBA,$26DE         ; $005E68 JSR     $008548(PC)
        DC.W    $4EBA,$368C         ; $005E6C JSR     $0094FA(PC)
        DC.W    $4EBA,$34A0         ; $005E70 JSR     $009312(PC)
        DC.W    $4EBA,$3C9C         ; $005E74 JSR     $009B12(PC)
        DC.W    $4EBA,$3308         ; $005E78 JSR     $009182(PC)
        DC.W    $4EBA,$37A0         ; $005E7C JSR     $00961E(PC)
        DC.W    $4EBA,$3806         ; $005E80 JSR     $009688(PC)
        DC.W    $4EBA,$397C         ; $005E84 JSR     $009802(PC)
        DC.W    $4EBA,$1FF0         ; $005E88 JSR     $007E7A(PC)
        DC.W    $4EBA,$110A         ; $005E8C JSR     $006F98(PC)
        DC.W    $4EBA,$1E46         ; $005E90 JSR     $007CD8(PC)
        DC.W    $4EBA,$459E         ; $005E94 JSR     $00A434(PC)
        DC.W    $4EBA,$1210         ; $005E98 JSR     $0070AA(PC)
        DC.W    $4EBA,$2066         ; $005E9C JSR     $007F04(PC)
        DC.W    $4EBA,$1DAC         ; $005EA0 JSR     $007C4E(PC)
        DC.W    $4EBA,$12A4         ; $005EA4 JSR     $00714A(PC)
        DC.W    $4EBA,$17A4         ; $005EA8 JSR     $00764E(PC)
        DC.W    $4EBA,$20A2         ; $005EAC JSR     $007F50(PC)
        DC.W    $4EBA,$3E1C         ; $005EB0 JSR     $009CCE(PC)
        DC.W    $4EBA,$3C9E         ; $005EB4 JSR     $009B54(PC)
        DC.W    $4EBA,$2844         ; $005EB8 JSR     $0086FE(PC)
        DC.W    $4EBA,$3182         ; $005EBC JSR     $009040(PC)
        DC.W    $4EBA,$4E12         ; $005EC0 JSR     $00ACD4(PC)
        DC.W    $4EBA,$E1BE         ; $005EC4 JSR     $004084(PC)
        DC.W    $4EBA,$1734         ; $005EC8 JSR     $0075FE(PC)
        DC.W    $4EBA,$12D8         ; $005ECC JSR     $0071A6(PC)
        DC.W    $4EBA,$CAB2         ; $005ED0 JSR     $002984(PC)
        DC.W    $4EBA,$D2D0         ; $005ED4 JSR     $0031A6(PC)
        DC.W    $4EBA,$D804         ; $005ED8 JSR     $0036DE(PC)
        DC.W    $4EBA,$D8D8         ; $005EDC JSR     $0037B6(PC)
        DC.W    $4EBA,$E0A4         ; $005EE0 JSR     $003F86(PC)
        DC.W    $4EBA,$D1E0         ; $005EE4 JSR     $0030C6(PC)
        DC.W    $4E75               ; $005EE8 RTS
        DC.W    $7000               ; $005EEA MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $005EEC MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $005EF0 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $005EF4 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$26CA         ; $005EF8 JSR     $0085C4(PC)
        DC.W    $4EBA,$269C         ; $005EFC JSR     $00859A(PC)
        DC.W    $4EBA,$444E         ; $005F00 JSR     $00A350(PC)
        DC.W    $4EBA,$226A         ; $005F04 JSR     $008170(PC)
        DC.W    $4EBA,$21C2         ; $005F08 JSR     $0080CC(PC)
        DC.W    $4EBA,$263A         ; $005F0C JSR     $008548(PC)
        DC.W    $4EBA,$35E8         ; $005F10 JSR     $0094FA(PC)
        DC.W    $4EBA,$33FC         ; $005F14 JSR     $009312(PC)
        DC.W    $4EBA,$3BF8         ; $005F18 JSR     $009B12(PC)
        DC.W    $4EBA,$3264         ; $005F1C JSR     $009182(PC)
        DC.W    $4EBA,$36FC         ; $005F20 JSR     $00961E(PC)
        DC.W    $4EBA,$3762         ; $005F24 JSR     $009688(PC)
        DC.W    $4EBA,$38D8         ; $005F28 JSR     $009802(PC)
        DC.W    $4EBA,$1F4C         ; $005F2C JSR     $007E7A(PC)
        DC.W    $4EBA,$1066         ; $005F30 JSR     $006F98(PC)
        DC.W    $4EBA,$1DA2         ; $005F34 JSR     $007CD8(PC)
        DC.W    $4EBA,$44FA         ; $005F38 JSR     $00A434(PC)
        DC.W    $4EBA,$116C         ; $005F3C JSR     $0070AA(PC)
        DC.W    $4EBA,$1FC2         ; $005F40 JSR     $007F04(PC)
        DC.W    $4EBA,$3F28         ; $005F44 JSR     $009E6E(PC)
        DC.W    $4EBA,$1D04         ; $005F48 JSR     $007C4E(PC)
        DC.W    $4EBA,$11FC         ; $005F4C JSR     $00714A(PC)
        DC.W    $4EBA,$16FC         ; $005F50 JSR     $00764E(PC)
        DC.W    $4EBA,$1FFA         ; $005F54 JSR     $007F50(PC)
        DC.W    $4EBA,$3D74         ; $005F58 JSR     $009CCE(PC)
        DC.W    $4EBA,$4CE0         ; $005F5C JSR     $00AC3E(PC)
        DC.W    $4EBA,$3BF2         ; $005F60 JSR     $009B54(PC)
        DC.W    $4EBA,$2762         ; $005F64 JSR     $0086C8(PC)
        DC.W    $4EBA,$4D6A         ; $005F68 JSR     $00ACD4(PC)
        DC.W    $4EBA,$3F52         ; $005F6C JSR     $009EC0(PC)
        DC.W    $4EBA,$D1B4         ; $005F70 JSR     $003126(PC)
        DC.W    $4EBA,$D1EA         ; $005F74 JSR     $003160(PC)
        DC.W    $4EBA,$16AA         ; $005F78 JSR     $007624(PC)
        DC.W    $4EBA,$13D0         ; $005F7C JSR     $00734E(PC)
        DC.W    $4EBA,$D75C         ; $005F80 JSR     $0036DE(PC)
        DC.W    $4EBA,$D830         ; $005F84 JSR     $0037B6(PC)
        DC.W    $4EBA,$DFFC         ; $005F88 JSR     $003F86(PC)
        DC.W    $4EBA,$30D6         ; $005F8C JSR     $009064(PC)
        DC.W    $11F8,$C304,$C30C   ; $005F90 MOVE.B  $C304.W,$C30C.W
        DC.W    $4EFA,$0C70         ; $005F96 JMP     $006C08(PC)
        DC.W    $4EBA,$43B4         ; $005F9A JSR     $00A350(PC)
        DC.W    $4EBA,$21D0         ; $005F9E JSR     $008170(PC)
        DC.W    $4EBA,$2128         ; $005FA2 JSR     $0080CC(PC)
        DC.W    $4EBA,$25A0         ; $005FA6 JSR     $008548(PC)
        DC.W    $4EBA,$3672         ; $005FAA JSR     $00961E(PC)
        DC.W    $4EBA,$1866         ; $005FAE JSR     $007816(PC)
        DC.W    $4EBA,$169A         ; $005FB2 JSR     $00764E(PC)
        DC.W    $4EBA,$10F2         ; $005FB6 JSR     $0070AA(PC)
        DC.W    $4EBA,$4924         ; $005FBA JSR     $00A8E0(PC)
        DC.W    $4EBA,$3B94         ; $005FBE JSR     $009B54(PC)
        DC.W    $4EBA,$31BE         ; $005FC2 JSR     $009182(PC)
        DC.W    $4EBA,$383A         ; $005FC6 JSR     $009802(PC)
        DC.W    $4EBA,$117E         ; $005FCA JSR     $00714A(PC)
        DC.W    $4EBA,$3CFE         ; $005FCE JSR     $009CCE(PC)
        DC.W    $4EBA,$26F4         ; $005FD2 JSR     $0086C8(PC)
        DC.W    $4EBA,$4CFC         ; $005FD6 JSR     $00ACD4(PC)
        DC.W    $4EBA,$D14A         ; $005FDA JSR     $003126(PC)
        DC.W    $4EBA,$D180         ; $005FDE JSR     $003160(PC)
        DC.W    $4EBA,$1640         ; $005FE2 JSR     $007624(PC)
        DC.W    $4EBA,$1366         ; $005FE6 JSR     $00734E(PC)
        DC.W    $4EBA,$D6F2         ; $005FEA JSR     $0036DE(PC)
        DC.W    $4EBA,$D7C6         ; $005FEE JSR     $0037B6(PC)
        DC.W    $4EBA,$DF92         ; $005FF2 JSR     $003F86(PC)
        DC.W    $4EBA,$DCCC         ; $005FF6 JSR     $003CC4(PC)
        DC.W    $4EBA,$3068         ; $005FFA JSR     $009064(PC)
        DC.W    $11F8,$C304,$C30C   ; $005FFE MOVE.B  $C304.W,$C30C.W
        DC.W    $4EFA,$0C02         ; $006004 JMP     $006C08(PC)
        DC.W    $317C,$0000,$0006   ; $006008 MOVE.W  #$0000,$0006(A0)
        DC.W    $317C,$0000,$0074   ; $00600E MOVE.W  #$0000,$0074(A0)
        DC.W    $7000               ; $006014 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $006016 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $00601A MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $00601E MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$E9CA         ; $006022 JSR     loc_0049EE(PC)
        DC.W    $4EBA,$2572         ; $006026 JSR     $00859A(PC)
        DC.W    $4EBA,$4324         ; $00602A JSR     $00A350(PC)
        DC.W    $4EBA,$2140         ; $00602E JSR     $008170(PC)
        DC.W    $4EBA,$2098         ; $006032 JSR     $0080CC(PC)
        DC.W    $4EBA,$2510         ; $006036 JSR     $008548(PC)
        DC.W    $4EBA,$34BE         ; $00603A JSR     $0094FA(PC)
        DC.W    $0C78,$0004,$C26C   ; $00603E CMPI.W  #$0004,$C26C.W
        DC.W    $6704               ; $006044 BEQ.S  loc_00604A
        DC.W    $4EBA,$32CA         ; $006046 JSR     $009312(PC)
loc_00604A:
        DC.W    $4EBA,$3AC6         ; $00604A JSR     $009B12(PC)
        DC.W    $4EBA,$3132         ; $00604E JSR     $009182(PC)
        DC.W    $4EBA,$37AE         ; $006052 JSR     $009802(PC)
        DC.W    $4EBA,$102C         ; $006056 JSR     $007084(PC)
        DC.W    $4EBA,$104E         ; $00605A JSR     $0070AA(PC)
        DC.W    $4EBA,$17B6         ; $00605E JSR     $007816(PC)
        DC.W    $5378,$C02C         ; $006062 SUBQ.W  #1,$C02C.W
        DC.W    $6E12               ; $006066 BGT.S  loc_00607A
        DC.W    $31FC,$0000,$C02C   ; $006068 MOVE.W  #$0000,$C02C.W
        DC.W    $317C,$0000,$0074   ; $00606E MOVE.W  #$0000,$0074(A0)
        DC.W    $31F8,$C08C,$C07A   ; $006074 MOVE.W  $C08C.W,$C07A.W
loc_00607A:
        DC.W    $4EBA,$1E88         ; $00607A JSR     $007F04(PC)
        DC.W    $4EBA,$3DEE         ; $00607E JSR     $009E6E(PC)
        DC.W    $4EBA,$1BCA         ; $006082 JSR     $007C4E(PC)
        DC.W    $4EBA,$10C2         ; $006086 JSR     $00714A(PC)
        DC.W    $4EBA,$15C2         ; $00608A JSR     $00764E(PC)
        DC.W    $4EBA,$1EC0         ; $00608E JSR     $007F50(PC)
        DC.W    $4EBA,$3C3A         ; $006092 JSR     $009CCE(PC)
        DC.W    $4EBA,$4BA6         ; $006096 JSR     $00AC3E(PC)
        DC.W    $4EBA,$3AB8         ; $00609A JSR     $009B54(PC)
        DC.W    $4EBA,$2628         ; $00609E JSR     $0086C8(PC)
        DC.W    $4EBA,$4C30         ; $0060A2 JSR     $00ACD4(PC)
        DC.W    $4EBA,$3E18         ; $0060A6 JSR     $009EC0(PC)
        DC.W    $4EBA,$D07A         ; $0060AA JSR     $003126(PC)
        DC.W    $4EBA,$D0B0         ; $0060AE JSR     $003160(PC)
        DC.W    $4EBA,$1570         ; $0060B2 JSR     $007624(PC)
        DC.W    $4EBA,$1296         ; $0060B6 JSR     $00734E(PC)
        DC.W    $4EBA,$D622         ; $0060BA JSR     $0036DE(PC)
        DC.W    $4EBA,$D6F6         ; $0060BE JSR     $0037B6(PC)
        DC.W    $4EBA,$DEC2         ; $0060C2 JSR     $003F86(PC)
        DC.W    $4EBA,$2F9C         ; $0060C6 JSR     $009064(PC)
        DC.W    $11F8,$C304,$C30C   ; $0060CA MOVE.B  $C304.W,$C30C.W
        DC.W    $4EFA,$0B36         ; $0060D0 JMP     $006C08(PC)
        DC.W    $7000               ; $0060D4 MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $0060D6 MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $0060DA MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $0060DE MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$24B6         ; $0060E2 JSR     $00859A(PC)
        DC.W    $4EBA,$4268         ; $0060E6 JSR     $00A350(PC)
        DC.W    $4EBA,$2084         ; $0060EA JSR     $008170(PC)
        DC.W    $4EBA,$1FDC         ; $0060EE JSR     $0080CC(PC)
        DC.W    $4EBA,$2454         ; $0060F2 JSR     $008548(PC)
        DC.W    $4EBA,$370A         ; $0060F6 JSR     $009802(PC)
        DC.W    $4EBA,$1D7E         ; $0060FA JSR     $007E7A(PC)
        DC.W    $4EBA,$0E98         ; $0060FE JSR     $006F98(PC)
        DC.W    $4EBA,$1BD4         ; $006102 JSR     $007CD8(PC)
        DC.W    $4EBA,$432C         ; $006106 JSR     $00A434(PC)
        DC.W    $4EBA,$0F9E         ; $00610A JSR     $0070AA(PC)
        DC.W    $4EBA,$1DF4         ; $00610E JSR     $007F04(PC)
        DC.W    $4EBA,$3D5A         ; $006112 JSR     $009E6E(PC)
        DC.W    $4EBA,$1B36         ; $006116 JSR     $007C4E(PC)
        DC.W    $4EBA,$102E         ; $00611A JSR     $00714A(PC)
        DC.W    $4EBA,$152E         ; $00611E JSR     $00764E(PC)
        DC.W    $4EBA,$1E2C         ; $006122 JSR     $007F50(PC)
        DC.W    $4EBA,$3BA6         ; $006126 JSR     $009CCE(PC)
        DC.W    $4EBA,$4B12         ; $00612A JSR     $00AC3E(PC)
        DC.W    $4EBA,$2598         ; $00612E JSR     $0086C8(PC)
        DC.W    $4EBA,$3D8C         ; $006132 JSR     $009EC0(PC)
        DC.W    $4EBA,$34E6         ; $006136 JSR     $00961E(PC)
        DC.W    $4EBA,$47BC         ; $00613A JSR     $00A8F8(PC)
        DC.W    $0838,$0004,$C30E   ; $00613E BTST    #4,$C30E.W
        DC.W    $6706               ; $006144 BEQ.S  loc_00614C
        DC.W    $31F8,$C08C,$C07A   ; $006146 MOVE.W  $C08C.W,$C07A.W
loc_00614C:
        DC.W    $4EBA,$CFD8         ; $00614C JSR     $003126(PC)
        DC.W    $4EBA,$D00E         ; $006150 JSR     $003160(PC)
        DC.W    $4EBA,$14CE         ; $006154 JSR     $007624(PC)
        DC.W    $4EBA,$11F4         ; $006158 JSR     $00734E(PC)
        DC.W    $4EBA,$D580         ; $00615C JSR     $0036DE(PC)
        DC.W    $4EBA,$D654         ; $006160 JSR     $0037B6(PC)
        DC.W    $4A78,$C89C         ; $006164 TST.W  $C89C.W
        DC.W    $6604               ; $006168 BNE.S  loc_00616E
        DC.W    $4EBA,$DB58         ; $00616A JSR     $003CC4(PC)
loc_00616E:
        DC.W    $4EBA,$2EF4         ; $00616E JSR     $009064(PC)
        DC.W    $11F8,$C304,$C30C   ; $006172 MOVE.B  $C304.W,$C30C.W
        DC.W    $4E75               ; $006178 RTS
        DC.W    $0838,$0000,$C80E   ; $00617A BTST    #0,$C80E.W
        DC.W    $6600,$00D6         ; $006180 BNE.W  $006258
        DC.W    $11FC,$0001,$C800   ; $006184 MOVE.B  #$0001,$C800.W
        DC.W    $7000               ; $00618A MOVEQ   #$00,D0
        DC.W    $3140,$0044         ; $00618C MOVE.W  D0,$0044(A0)
        DC.W    $3140,$0046         ; $006190 MOVE.W  D0,$0046(A0)
        DC.W    $3140,$004A         ; $006194 MOVE.W  D0,$004A(A0)
        DC.W    $4EBA,$1F32         ; $006198 JSR     $0080CC(PC)
        DC.W    $4EBA,$23AA         ; $00619C JSR     $008548(PC)
        DC.W    $4EBA,$3660         ; $0061A0 JSR     $009802(PC)
        DC.W    $4EBA,$1CD4         ; $0061A4 JSR     $007E7A(PC)
        DC.W    $4EBA,$0DEE         ; $0061A8 JSR     $006F98(PC)
        DC.W    $4EBA,$1B2A         ; $0061AC JSR     $007CD8(PC)
        DC.W    $4EBA,$0EF8         ; $0061B0 JSR     $0070AA(PC)
        DC.W    $4EBA,$0F94         ; $0061B4 JSR     $00714A(PC)
        DC.W    $4EBA,$1494         ; $0061B8 JSR     $00764E(PC)
        DC.W    $4EBA,$1D92         ; $0061BC JSR     $007F50(PC)
        DC.W    $4EBA,$3B0C         ; $0061C0 JSR     $009CCE(PC)
        DC.W    $4EBA,$4A78         ; $0061C4 JSR     $00AC3E(PC)
        DC.W    $4EBA,$398A         ; $0061C8 JSR     $009B54(PC)
        DC.W    $4EBA,$24FA         ; $0061CC JSR     $0086C8(PC)
        DC.W    $4EBA,$CF54         ; $0061D0 JSR     $003126(PC)
        DC.W    $4EBA,$CF8A         ; $0061D4 JSR     $003160(PC)
        DC.W    $4EBA,$144A         ; $0061D8 JSR     $007624(PC)
        DC.W    $4EBA,$1170         ; $0061DC JSR     $00734E(PC)
        DC.W    $4EBA,$D4FC         ; $0061E0 JSR     $0036DE(PC)
        DC.W    $4EBA,$D5D0         ; $0061E4 JSR     $0037B6(PC)
        DC.W    $4EBA,$DD9C         ; $0061E8 JSR     $003F86(PC)
        DC.W    $4EBA,$2E76         ; $0061EC JSR     $009064(PC)
        DC.W    $11F8,$C304,$C30C   ; $0061F0 MOVE.B  $C304.W,$C30C.W
        DC.W    $3038,$C8A0         ; $0061F6 MOVE.W  $C8A0.W,D0
        DC.W    $0838,$0007,$C81C   ; $0061FA BTST    #7,$C81C.W
