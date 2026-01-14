; Generated assembly for $010200-$012200
; Branch targets: 239
; Labels: 220
; Format: DC.W with decoded mnemonics as comments

        org     $010200

        DC.W    $1050               ; $010200 MOVEA.B (A0),A0
        DC.W    $303C,$00A8         ; $010202 MOVE.W  #$00A8,D0
        DC.W    $323C,$0010         ; $010206 MOVE.W  #$0010,D1
        DC.W    $4EBA,$E14E         ; $01020A JSR     $00E35A(PC)
        DC.W    $207C,$0602,$0000   ; $01020E MOVEA.L #$06020000,A0
        DC.W    $3038,$A022         ; $010214 MOVE.W  $A022.W,D0
        DC.W    $EF48               ; $010218 LSL.W  #7,D0
        DC.W    $3200               ; $01021A MOVE.W  D0,D1
        DC.W    $E548               ; $01021C LSL.W  #2,D0
        DC.W    $D041               ; $01021E ADD.W  D1,D0
        DC.W    $41F0,$0000         ; $010220 LEA     $00(A0,D0.W),A0
        DC.W    $227C,$2403,$10CC   ; $010224 MOVEA.L #$240310CC,A1
        DC.W    $303C,$0028         ; $01022A MOVE.W  #$0028,D0
        DC.W    $323C,$0010         ; $01022E MOVE.W  #$0010,D1
        DC.W    $4EBA,$E126         ; $010232 JSR     $00E35A(PC)
        DC.W    $5878,$C87E         ; $010236 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $01023A MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $010242 RTS
        DC.W    $4240               ; $010244 CLR.W  D0
        DC.W    $4EBA,$E2E4         ; $010246 JSR     $00E52C(PC)
        DC.W    $2078,$A018         ; $01024A MOVEA.L $A018.W,A0
        DC.W    $6100,$0546         ; $01024E BSR.W  loc_010796
        DC.W    $4EB9,$0088,$179E   ; $010252 JSR     $0088179E
        DC.W    $0C78,$0001,$A036   ; $010258 CMPI.W  #$0001,$A036.W
        DC.W    $6700,$00DC         ; $01025E BEQ.W  loc_01033C
        DC.W    $3238,$C86C         ; $010262 MOVE.W  $C86C.W,D1
        DC.W    $0801,$0004         ; $010266 BTST    #4,D1
        DC.W    $6600,$0074         ; $01026A BNE.W  loc_0102E0
        DC.W    $3401               ; $01026E MOVE.W  D1,D2
        DC.W    $0202,$00E0         ; $010270 ANDI.B  #$00E0,D2
        DC.W    $6700,$00C2         ; $010274 BEQ.W  loc_010338
        DC.W    $11FC,$0001,$A02C   ; $010278 MOVE.B  #$0001,$A02C.W
        DC.W    $11FC,$0000,$A02D   ; $01027E MOVE.B  #$0000,$A02D.W
        DC.W    $11FC,$00A8,$C8A4   ; $010284 MOVE.B  #$00A8,$C8A4.W
        DC.W    $0801,$0007         ; $01028A BTST    #7,D1
        DC.W    $6600,$0048         ; $01028E BNE.W  loc_0102D8
        DC.W    $3038,$A024         ; $010292 MOVE.W  $A024.W,D0
        DC.W    $0C00,$0003         ; $010296 CMPI.B  #$0003,D0
        DC.W    $6700,$003C         ; $01029A BEQ.W  loc_0102D8
        DC.W    $0C00,$0008         ; $01029E CMPI.B  #$0008,D0
        DC.W    $6700,$003C         ; $0102A2 BEQ.W  loc_0102E0
        DC.W    $4241               ; $0102A6 CLR.W  D1
        DC.W    $1238,$A020         ; $0102A8 MOVE.B  $A020.W,D1
        DC.W    $2078,$A018         ; $0102AC MOVEA.L $A018.W,A0
        DC.W    $1180,$1000         ; $0102B0 MOVE.B  D0,$00(A0,D1.W)
        DC.W    $0838,$0001,$A014   ; $0102B4 BTST    #1,$A014.W
        DC.W    $6700,$000A         ; $0102BA BEQ.W  loc_0102C6
        DC.W    $2078,$A01C         ; $0102BE MOVEA.L $A01C.W,A0
        DC.W    $1180,$1000         ; $0102C2 MOVE.B  D0,$00(A0,D1.W)
loc_0102C6:
        DC.W    $5238,$A020         ; $0102C6 ADDQ.B  #1,$A020.W
        DC.W    $0C38,$0003,$A020   ; $0102CA CMPI.B  #$0003,$A020.W
        DC.W    $6C00,$0006         ; $0102D0 BGE.W  loc_0102D8
        DC.W    $6000,$0078         ; $0102D4 BRA.W  loc_01034E
loc_0102D8:
        DC.W    $5878,$C87E         ; $0102D8 ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0074         ; $0102DC BRA.W  loc_010352
loc_0102E0:
        DC.W    $4A38,$A020         ; $0102E0 TST.B  $A020.W
        DC.W    $6700,$0068         ; $0102E4 BEQ.W  loc_01034E
        DC.W    $4241               ; $0102E8 CLR.W  D1
        DC.W    $1238,$A020         ; $0102EA MOVE.B  $A020.W,D1
        DC.W    $2078,$A018         ; $0102EE MOVEA.L $A018.W,A0
        DC.W    $11BC,$0020,$1000   ; $0102F2 MOVE.B  #$0020,$00(A0,D1.W)
        DC.W    $0838,$0001,$A014   ; $0102F8 BTST    #1,$A014.W
        DC.W    $6700,$000C         ; $0102FE BEQ.W  loc_01030C
        DC.W    $2078,$A01C         ; $010302 MOVEA.L $A01C.W,A0
        DC.W    $11BC,$0020,$1000   ; $010306 MOVE.B  #$0020,$00(A0,D1.W)
loc_01030C:
        DC.W    $5338,$A020         ; $01030C SUBQ.B  #1,$A020.W
        DC.W    $4241               ; $010310 CLR.W  D1
        DC.W    $1238,$A020         ; $010312 MOVE.B  $A020.W,D1
        DC.W    $2078,$A018         ; $010316 MOVEA.L $A018.W,A0
        DC.W    $11BC,$0020,$1000   ; $01031A MOVE.B  #$0020,$00(A0,D1.W)
        DC.W    $0838,$0001,$A014   ; $010320 BTST    #1,$A014.W
        DC.W    $6700,$000C         ; $010326 BEQ.W  loc_010334
        DC.W    $2078,$A01C         ; $01032A MOVEA.L $A01C.W,A0
        DC.W    $11BC,$0020,$1000   ; $01032E MOVE.B  #$0020,$00(A0,D1.W)
loc_010334:
        DC.W    $6000,$0018         ; $010334 BRA.W  loc_01034E
loc_010338:
        DC.W    $6100,$0512         ; $010338 BSR.W  loc_01084C
loc_01033C:
        DC.W    $4EB9,$0088,$FB36   ; $01033C JSR     $0088FB36
        DC.W    $0838,$0006,$C80E   ; $010342 BTST    #6,$C80E.W
        DC.W    $6604               ; $010348 BNE.S  loc_01034E
        DC.W    $4278,$A036         ; $01034A CLR.W  $A036.W
loc_01034E:
        DC.W    $5978,$C87E         ; $01034E SUBQ.W  #4,$C87E.W
loc_010352:
        DC.W    $33FC,$0018,$00FF,$0008; $010352 MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $01035A RTS
        DC.W    $4240               ; $01035C CLR.W  D0
        DC.W    $6100,$E1CC         ; $01035E BSR.W  $00E52C
        DC.W    $4EBA,$B320         ; $010362 JSR     $00B684(PC)
        DC.W    $6100,$03B4         ; $010366 BSR.W  loc_01071C
        DC.W    $207C,$0601,$C300   ; $01036A MOVEA.L #$0601C300,A0
        DC.W    $227C,$2400,$E030   ; $010370 MOVEA.L #$2400E030,A1
        DC.W    $303C,$0080         ; $010376 MOVE.W  #$0080,D0
        DC.W    $323C,$0020         ; $01037A MOVE.W  #$0020,D1
        DC.W    $4EBA,$DFDA         ; $01037E JSR     $00E35A(PC)
        DC.W    $43F9,$2402,$F0C0   ; $010382 LEA     $2402F0C0,A1
        DC.W    $45F8,$FA48         ; $010388 LEA     $FA48.W,A2
        DC.W    $7000               ; $01038C MOVEQ   #$00,D0
        DC.W    $1038,$FEB1         ; $01038E MOVE.B  $FEB1.W,D0
        DC.W    $D040               ; $010392 ADD.W  D0,D0
        DC.W    $D040               ; $010394 ADD.W  D0,D0
        DC.W    $D040               ; $010396 ADD.W  D0,D0
        DC.W    $3200               ; $010398 MOVE.W  D0,D1
        DC.W    $D040               ; $01039A ADD.W  D0,D0
        DC.W    $D041               ; $01039C ADD.W  D1,D0
        DC.W    $D040               ; $01039E ADD.W  D0,D0
        DC.W    $D5C0               ; $0103A0 ADDA.L  D0,A2
        DC.W    $7000               ; $0103A2 MOVEQ   #$00,D0
        DC.W    $1038,$FEA5         ; $0103A4 MOVE.B  $FEA5.W,D0
        DC.W    $D040               ; $0103A8 ADD.W  D0,D0
        DC.W    $D040               ; $0103AA ADD.W  D0,D0
        DC.W    $D040               ; $0103AC ADD.W  D0,D0
        DC.W    $5840               ; $0103AE ADDQ.W  #4,D0
        DC.W    $D5C0               ; $0103B0 ADDA.L  D0,A2
        DC.W    $6100,$0252         ; $0103B2 BSR.W  loc_010606
        DC.W    $5878,$C87E         ; $0103B6 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $0103BA MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $0103C2 RTS
        DC.W    $4240               ; $0103C4 CLR.W  D0
        DC.W    $4EBA,$E164         ; $0103C6 JSR     $00E52C(PC)
        DC.W    $2078,$A01C         ; $0103CA MOVEA.L $A01C.W,A0
        DC.W    $6100,$03C6         ; $0103CE BSR.W  loc_010796
        DC.W    $4EB9,$0088,$179E   ; $0103D2 JSR     $0088179E
        DC.W    $0C78,$0001,$A036   ; $0103D8 CMPI.W  #$0001,$A036.W
        DC.W    $6700,$00A2         ; $0103DE BEQ.W  loc_010482
        DC.W    $3238,$C86C         ; $0103E2 MOVE.W  $C86C.W,D1
        DC.W    $0801,$0004         ; $0103E6 BTST    #4,D1
        DC.W    $6600,$0062         ; $0103EA BNE.W  loc_01044E
        DC.W    $3401               ; $0103EE MOVE.W  D1,D2
        DC.W    $0202,$00E0         ; $0103F0 ANDI.B  #$00E0,D2
        DC.W    $6700,$0088         ; $0103F4 BEQ.W  loc_01047E
        DC.W    $11FC,$0001,$A02C   ; $0103F8 MOVE.B  #$0001,$A02C.W
        DC.W    $11FC,$0000,$A02D   ; $0103FE MOVE.B  #$0000,$A02D.W
        DC.W    $11FC,$00A8,$C8A4   ; $010404 MOVE.B  #$00A8,$C8A4.W
        DC.W    $0801,$0007         ; $01040A BTST    #7,D1
        DC.W    $6600,$0036         ; $01040E BNE.W  loc_010446
        DC.W    $3038,$A024         ; $010412 MOVE.W  $A024.W,D0
        DC.W    $0C00,$0003         ; $010416 CMPI.B  #$0003,D0
        DC.W    $6700,$002A         ; $01041A BEQ.W  loc_010446
        DC.W    $0C00,$0008         ; $01041E CMPI.B  #$0008,D0
        DC.W    $6700,$002A         ; $010422 BEQ.W  loc_01044E
        DC.W    $4241               ; $010426 CLR.W  D1
        DC.W    $1238,$A020         ; $010428 MOVE.B  $A020.W,D1
        DC.W    $2078,$A01C         ; $01042C MOVEA.L $A01C.W,A0
        DC.W    $1180,$1000         ; $010430 MOVE.B  D0,$00(A0,D1.W)
        DC.W    $5238,$A020         ; $010434 ADDQ.B  #1,$A020.W
        DC.W    $0C38,$0003,$A020   ; $010438 CMPI.B  #$0003,$A020.W
        DC.W    $6C00,$0006         ; $01043E BGE.W  loc_010446
        DC.W    $6000,$0050         ; $010442 BRA.W  loc_010494
loc_010446:
        DC.W    $5878,$C87E         ; $010446 ADDQ.W  #4,$C87E.W
        DC.W    $6000,$004C         ; $01044A BRA.W  loc_010498
loc_01044E:
        DC.W    $4241               ; $01044E CLR.W  D1
        DC.W    $1238,$A020         ; $010450 MOVE.B  $A020.W,D1
        DC.W    $2078,$A01C         ; $010454 MOVEA.L $A01C.W,A0
        DC.W    $11BC,$0020,$1000   ; $010458 MOVE.B  #$0020,$00(A0,D1.W)
        DC.W    $4A38,$A020         ; $01045E TST.B  $A020.W
        DC.W    $6700,$0030         ; $010462 BEQ.W  loc_010494
        DC.W    $5338,$A020         ; $010466 SUBQ.B  #1,$A020.W
        DC.W    $4241               ; $01046A CLR.W  D1
        DC.W    $1238,$A020         ; $01046C MOVE.B  $A020.W,D1
        DC.W    $2078,$A01C         ; $010470 MOVEA.L $A01C.W,A0
        DC.W    $11BC,$0020,$1000   ; $010474 MOVE.B  #$0020,$00(A0,D1.W)
        DC.W    $6000,$0018         ; $01047A BRA.W  loc_010494
loc_01047E:
        DC.W    $6100,$03CC         ; $01047E BSR.W  loc_01084C
loc_010482:
        DC.W    $4EB9,$0088,$FB36   ; $010482 JSR     $0088FB36
        DC.W    $0838,$0006,$C80E   ; $010488 BTST    #6,$C80E.W
        DC.W    $6604               ; $01048E BNE.S  loc_010494
        DC.W    $4278,$A036         ; $010490 CLR.W  $A036.W
loc_010494:
        DC.W    $5978,$C87E         ; $010494 SUBQ.W  #4,$C87E.W
loc_010498:
        DC.W    $33FC,$0018,$00FF,$0008; $010498 MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $0104A0 RTS
        DC.W    $4240               ; $0104A2 CLR.W  D0
        DC.W    $4EBA,$E086         ; $0104A4 JSR     $00E52C(PC)
        DC.W    $4EBA,$B230         ; $0104A8 JSR     $00B6DA(PC)
        DC.W    $207C,$0601,$4000   ; $0104AC MOVEA.L #$06014000,A0
        DC.W    $227C,$2401,$4034   ; $0104B2 MOVEA.L #$24014034,A1
        DC.W    $303C,$00D8         ; $0104B8 MOVE.W  #$00D8,D0
        DC.W    $323C,$0050         ; $0104BC MOVE.W  #$0050,D1
        DC.W    $4EBA,$DE98         ; $0104C0 JSR     $00E35A(PC)
        DC.W    $4A78,$A02E         ; $0104C4 TST.W  $A02E.W
        DC.W    $6A3C               ; $0104C8 BPL.S  loc_010506
        DC.W    $11FC,$0001,$A02C   ; $0104CA MOVE.B  #$0001,$A02C.W
        DC.W    $11FC,$0001,$A02D   ; $0104D0 MOVE.B  #$0001,$A02D.W
        DC.W    $5378,$A030         ; $0104D6 SUBQ.W  #1,$A030.W
        DC.W    $642A               ; $0104DA BCC.S  loc_010506
        DC.W    $31FC,$0002,$A036   ; $0104DC MOVE.W  #$0002,$A036.W
        DC.W    $11FC,$0001,$C809   ; $0104E2 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $0104E8 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $0104EE BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $0104F4 MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $0104FA JSR     $0088205E
        DC.W    $31FC,$0BB8,$A030   ; $010500 MOVE.W  #$0BB8,$A030.W
loc_010506:
        DC.W    $2078,$A018         ; $010506 MOVEA.L $A018.W,A0
        DC.W    $0838,$0000,$A014   ; $01050A BTST    #0,$A014.W
        DC.W    $6600,$0006         ; $010510 BNE.W  loc_010518
        DC.W    $2078,$A01C         ; $010514 MOVEA.L $A01C.W,A0
loc_010518:
        DC.W    $4A38,$A02C         ; $010518 TST.B  $A02C.W
        DC.W    $6700,$0022         ; $01051C BEQ.W  loc_010540
        DC.W    $2848               ; $010520 MOVEA.L A0,A4
        DC.W    $4240               ; $010522 CLR.W  D0
        DC.W    $1010               ; $010524 MOVE.B  (A0),D0
        DC.W    $0C00,$0020         ; $010526 CMPI.B  #$0020,D0
        DC.W    $6700,$0014         ; $01052A BEQ.W  loc_010540
        DC.W    $0C00,$0003         ; $01052E CMPI.B  #$0003,D0
        DC.W    $6700,$000C         ; $010532 BEQ.W  loc_010540
        DC.W    $227C,$2403,$4060   ; $010536 MOVEA.L #$24034060,A1
        DC.W    $6100,$0136         ; $01053C BSR.W  loc_010674
loc_010540:
        DC.W    $4A38,$A02C         ; $010540 TST.B  $A02C.W
        DC.W    $6700,$0022         ; $010544 BEQ.W  loc_010568
        DC.W    $3014               ; $010548 MOVE.W  (A4),D0
        DC.W    $0240,$00FF         ; $01054A ANDI.W  #$00FF,D0
        DC.W    $0C00,$0020         ; $01054E CMPI.B  #$0020,D0
        DC.W    $6700,$0014         ; $010552 BEQ.W  loc_010568
        DC.W    $0C00,$0003         ; $010556 CMPI.B  #$0003,D0
        DC.W    $6700,$000C         ; $01055A BEQ.W  loc_010568
        DC.W    $227C,$2403,$4090   ; $01055E MOVEA.L #$24034090,A1
        DC.W    $6100,$010E         ; $010564 BSR.W  loc_010674
loc_010568:
        DC.W    $4A38,$A02C         ; $010568 TST.B  $A02C.W
        DC.W    $6700,$0024         ; $01056C BEQ.W  loc_010592
        DC.W    $102C,$0002         ; $010570 MOVE.B  $0002(A4),D0
        DC.W    $0240,$00FF         ; $010574 ANDI.W  #$00FF,D0
        DC.W    $0C00,$0020         ; $010578 CMPI.B  #$0020,D0
        DC.W    $6700,$0014         ; $01057C BEQ.W  loc_010592
        DC.W    $0C00,$0003         ; $010580 CMPI.B  #$0003,D0
        DC.W    $6700,$000C         ; $010584 BEQ.W  loc_010592
        DC.W    $227C,$2403,$40C0   ; $010588 MOVEA.L #$240340C0,A1
        DC.W    $6100,$00E4         ; $01058E BSR.W  loc_010674
loc_010592:
        DC.W    $0C78,$0002,$A036   ; $010592 CMPI.W  #$0002,$A036.W
        DC.W    $6700,$0024         ; $010598 BEQ.W  loc_0105BE
        DC.W    $5338,$A02D         ; $01059C SUBQ.B  #1,$A02D.W
        DC.W    $6418               ; $0105A0 BCC.S  loc_0105BA
        DC.W    $0878,$0000,$A02C   ; $0105A2 BCHG    #0,$A02C.W
        DC.W    $11FC,$0001,$A02D   ; $0105A8 MOVE.B  #$0001,$A02D.W
        DC.W    $0838,$0000,$A02C   ; $0105AE BTST    #0,$A02C.W
        DC.W    $6704               ; $0105B4 BEQ.S  loc_0105BA
        DC.W    $5378,$A02E         ; $0105B6 SUBQ.W  #1,$A02E.W
loc_0105BA:
        DC.W    $6000,$0018         ; $0105BA BRA.W  loc_0105D4
loc_0105BE:
        DC.W    $4EB9,$0088,$FB36   ; $0105BE JSR     $0088FB36
        DC.W    $0838,$0007,$C80E   ; $0105C4 BTST    #7,$C80E.W
        DC.W    $6608               ; $0105CA BNE.S  loc_0105D4
        DC.W    $4278,$A036         ; $0105CC CLR.W  $A036.W
        DC.W    $5878,$C87E         ; $0105D0 ADDQ.W  #4,$C87E.W
loc_0105D4:
        DC.W    $33FC,$0018,$00FF,$0008; $0105D4 MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $0105DC RTS
loc_0105DE:
        DC.W    $4A39,$00A1,$5120   ; $0105DE TST.B  $00A15120
        DC.W    $66F8               ; $0105E4 BNE.S  loc_0105DE
        DC.W    $4239,$00A1,$5123   ; $0105E6 CLR.B  $00A15123
        DC.W    $31FC,$0000,$C87E   ; $0105EC MOVE.W  #$0000,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $0105F2 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0089,$09AE,$00FF,$0002; $0105FA MOVE.L  #$008909AE,$00FF0002
        DC.W    $4E75               ; $010604 RTS
loc_010606:
        DC.W    $161A               ; $010606 MOVE.B  (A2)+,D3
        DC.W    $6100,$0030         ; $010608 BSR.W  loc_01063A
        DC.W    $323C,$000A         ; $01060C MOVE.W  #$000A,D1
        DC.W    $6100,$0044         ; $010610 BSR.W  loc_010656
        DC.W    $5089               ; $010614 ADDQ.L  #8,A1
        DC.W    $161A               ; $010616 MOVE.B  (A2)+,D3
        DC.W    $6100,$0020         ; $010618 BSR.W  loc_01063A
        DC.W    $323C,$000B         ; $01061C MOVE.W  #$000B,D1
        DC.W    $6100,$0034         ; $010620 BSR.W  loc_010656
        DC.W    $5089               ; $010624 ADDQ.L  #8,A1
        DC.W    $121A               ; $010626 MOVE.B  (A2)+,D1
        DC.W    $0241,$000F         ; $010628 ANDI.W  #$000F,D1
        DC.W    $6100,$0028         ; $01062C BSR.W  loc_010656
        DC.W    $5089               ; $010630 ADDQ.L  #8,A1
        DC.W    $161A               ; $010632 MOVE.B  (A2)+,D3
        DC.W    $6100,$0004         ; $010634 BSR.W  loc_01063A
        DC.W    $4E75               ; $010638 RTS
loc_01063A:
        DC.W    $1203               ; $01063A MOVE.B  D3,D1
        DC.W    $E809               ; $01063C LSR.B  #4,D1
        DC.W    $0241,$000F         ; $01063E ANDI.W  #$000F,D1
        DC.W    $6100,$0012         ; $010642 BSR.W  loc_010656
        DC.W    $5089               ; $010646 ADDQ.L  #8,A1
        DC.W    $3203               ; $010648 MOVE.W  D3,D1
        DC.W    $0241,$000F         ; $01064A ANDI.W  #$000F,D1
        DC.W    $6100,$0006         ; $01064E BSR.W  loc_010656
        DC.W    $5089               ; $010652 ADDQ.L  #8,A1
        DC.W    $4E75               ; $010654 RTS
loc_010656:
        DC.W    $ED49               ; $010656 LSL.W  #6,D1
        DC.W    $3001               ; $010658 MOVE.W  D1,D0
        DC.W    $E349               ; $01065A LSL.W  #1,D1
        DC.W    $D240               ; $01065C ADD.W  D0,D1
        DC.W    $207C,$0602,$3200   ; $01065E MOVEA.L #$06023200,A0
        DC.W    $D0C1               ; $010664 ADDA.W  D1,A0
        DC.W    $303C,$000C         ; $010666 MOVE.W  #$000C,D0
        DC.W    $323C,$0010         ; $01066A MOVE.W  #$0010,D1
        DC.W    $4EBA,$DCEA         ; $01066E JSR     $00E35A(PC)
        DC.W    $4E75               ; $010672 RTS
loc_010674:
        DC.W    $0C40,$0020         ; $010674 CMPI.W  #$0020,D0
        DC.W    $6700,$0042         ; $010678 BEQ.W  loc_0106BC
        DC.W    $0C40,$0008         ; $01067C CMPI.W  #$0008,D0
        DC.W    $6700,$0042         ; $010680 BEQ.W  loc_0106C4
        DC.W    $0C40,$0003         ; $010684 CMPI.W  #$0003,D0
        DC.W    $6700,$0042         ; $010688 BEQ.W  loc_0106CC
        DC.W    $0C40,$002E         ; $01068C CMPI.W  #$002E,D0
        DC.W    $6700,$0042         ; $010690 BEQ.W  loc_0106D4
        DC.W    $0C40,$0021         ; $010694 CMPI.W  #$0021,D0
        DC.W    $6700,$0042         ; $010698 BEQ.W  loc_0106DC
        DC.W    $0C40,$003F         ; $01069C CMPI.W  #$003F,D0
        DC.W    $6700,$0012         ; $0106A0 BEQ.W  loc_0106B4
        DC.W    $0C40,$005A         ; $0106A4 CMPI.W  #$005A,D0
        DC.W    $6F00,$003A         ; $0106A8 BLE.W  loc_0106E4
        DC.W    $0C40,$007A         ; $0106AC CMPI.W  #$007A,D0
        DC.W    $6F00,$003A         ; $0106B0 BLE.W  loc_0106EC
loc_0106B4:
        DC.W    $303C,$0036         ; $0106B4 MOVE.W  #$0036,D0
        DC.W    $6000,$0036         ; $0106B8 BRA.W  loc_0106F0
loc_0106BC:
        DC.W    $303C,$0037         ; $0106BC MOVE.W  #$0037,D0
        DC.W    $6000,$002E         ; $0106C0 BRA.W  loc_0106F0
loc_0106C4:
        DC.W    $303C,$0038         ; $0106C4 MOVE.W  #$0038,D0
        DC.W    $6000,$0026         ; $0106C8 BRA.W  loc_0106F0
loc_0106CC:
        DC.W    $303C,$0039         ; $0106CC MOVE.W  #$0039,D0
        DC.W    $6000,$001E         ; $0106D0 BRA.W  loc_0106F0
loc_0106D4:
        DC.W    $303C,$0034         ; $0106D4 MOVE.W  #$0034,D0
        DC.W    $6000,$0016         ; $0106D8 BRA.W  loc_0106F0
loc_0106DC:
        DC.W    $303C,$0035         ; $0106DC MOVE.W  #$0035,D0
        DC.W    $6000,$000E         ; $0106E0 BRA.W  loc_0106F0
loc_0106E4:
        DC.W    $0440,$0041         ; $0106E4 SUBI.W  #$0041,D0
        DC.W    $6000,$0006         ; $0106E8 BRA.W  loc_0106F0
loc_0106EC:
        DC.W    $0440,$0047         ; $0106EC SUBI.W  #$0047,D0
loc_0106F0:
        DC.W    $0280,$0000,$FFFF   ; $0106F0 ANDI.L  #$0000FFFF,D0
        DC.W    $ED88               ; $0106F6 LSL.L  #6,D0
        DC.W    $2200               ; $0106F8 MOVE.L  D0,D1
        DC.W    $E388               ; $0106FA LSL.L  #1,D0
        DC.W    $D280               ; $0106FC ADD.L  D0,D1
        DC.W    $E388               ; $0106FE LSL.L  #1,D0
        DC.W    $D280               ; $010700 ADD.L  D0,D1
        DC.W    $E388               ; $010702 LSL.L  #1,D0
        DC.W    $D081               ; $010704 ADD.L  D1,D0
        DC.W    $207C,$0602,$4000   ; $010706 MOVEA.L #$06024000,A0
        DC.W    $D1C0               ; $01070C ADDA.L  D0,A0
        DC.W    $303C,$0018         ; $01070E MOVE.W  #$0018,D0
        DC.W    $323C,$0028         ; $010712 MOVE.W  #$0028,D1
        DC.W    $4EBA,$DC42         ; $010716 JSR     $00E35A(PC)
        DC.W    $4E75               ; $01071A RTS
loc_01071C:
        DC.W    $207C,$0601,$4000   ; $01071C MOVEA.L #$06014000,A0
        DC.W    $227C,$2401,$4034   ; $010722 MOVEA.L #$24014034,A1
        DC.W    $303C,$00D8         ; $010728 MOVE.W  #$00D8,D0
        DC.W    $323C,$0050         ; $01072C MOVE.W  #$0050,D1
        DC.W    $4EBA,$DC28         ; $010730 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$9700   ; $010734 MOVEA.L #$06019700,A0
        DC.W    $227C,$2400,$80A0   ; $01073A MOVEA.L #$240080A0,A1
        DC.W    $303C,$0058         ; $010740 MOVE.W  #$0058,D0
        DC.W    $323C,$0010         ; $010744 MOVE.W  #$0010,D1
        DC.W    $4EBA,$DC10         ; $010748 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$9C80   ; $01074C MOVEA.L #$06019C80,A0
        DC.W    $227C,$2400,$A0A0   ; $010752 MOVEA.L #$2400A0A0,A1
        DC.W    $303C,$0058         ; $010758 MOVE.W  #$0058,D0
        DC.W    $323C,$0010         ; $01075C MOVE.W  #$0010,D1
        DC.W    $4EBA,$DBF8         ; $010760 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$9000   ; $010764 MOVEA.L #$06019000,A0
        DC.W    $227C,$2400,$8060   ; $01076A MOVEA.L #$24008060,A1
        DC.W    $303C,$0038         ; $010770 MOVE.W  #$0038,D0
        DC.W    $323C,$0020         ; $010774 MOVE.W  #$0020,D1
        DC.W    $4EBA,$DBE0         ; $010778 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$A200   ; $01077C MOVEA.L #$0601A200,A0
        DC.W    $227C,$2400,$4C60   ; $010782 MOVEA.L #$24004C60,A1
        DC.W    $303C,$0080         ; $010788 MOVE.W  #$0080,D0
        DC.W    $323C,$0010         ; $01078C MOVE.W  #$0010,D1
        DC.W    $4EBA,$DBC8         ; $010790 JSR     $00E35A(PC)
        DC.W    $4E75               ; $010794 RTS
loc_010796:
        DC.W    $5338,$A02D         ; $010796 SUBQ.B  #1,$A02D.W
        DC.W    $640C               ; $01079A BCC.S  loc_0107A8
        DC.W    $0878,$0000,$A02C   ; $01079C BCHG    #0,$A02C.W
        DC.W    $11FC,$0000,$A02D   ; $0107A2 MOVE.B  #$0000,$A02D.W
loc_0107A8:
        DC.W    $4A38,$A020         ; $0107A8 TST.B  $A020.W
        DC.W    $6700,$0056         ; $0107AC BEQ.W  loc_010804
        DC.W    $0C38,$0001,$A020   ; $0107B0 CMPI.B  #$0001,$A020.W
        DC.W    $6700,$0066         ; $0107B6 BEQ.W  loc_01081E
        DC.W    $2848               ; $0107BA MOVEA.L A0,A4
        DC.W    $4240               ; $0107BC CLR.W  D0
        DC.W    $1010               ; $0107BE MOVE.B  (A0),D0
        DC.W    $0C00,$0020         ; $0107C0 CMPI.B  #$0020,D0
        DC.W    $6700,$000C         ; $0107C4 BEQ.W  loc_0107D2
        DC.W    $227C,$2403,$4060   ; $0107C8 MOVEA.L #$24034060,A1
        DC.W    $6100,$FEA4         ; $0107CE BSR.W  loc_010674
loc_0107D2:
        DC.W    $3014               ; $0107D2 MOVE.W  (A4),D0
        DC.W    $0240,$00FF         ; $0107D4 ANDI.W  #$00FF,D0
        DC.W    $0C00,$0020         ; $0107D8 CMPI.B  #$0020,D0
        DC.W    $6700,$000C         ; $0107DC BEQ.W  loc_0107EA
        DC.W    $227C,$2403,$4090   ; $0107E0 MOVEA.L #$24034090,A1
        DC.W    $6100,$FE8C         ; $0107E6 BSR.W  loc_010674
loc_0107EA:
        DC.W    $4A38,$A02C         ; $0107EA TST.B  $A02C.W
        DC.W    $6700,$005A         ; $0107EE BEQ.W  loc_01084A
        DC.W    $3038,$A024         ; $0107F2 MOVE.W  $A024.W,D0
        DC.W    $227C,$2403,$40C0   ; $0107F6 MOVEA.L #$240340C0,A1
        DC.W    $6100,$FE76         ; $0107FC BSR.W  loc_010674
        DC.W    $6000,$0048         ; $010800 BRA.W  loc_01084A
loc_010804:
        DC.W    $4A38,$A02C         ; $010804 TST.B  $A02C.W
        DC.W    $6700,$0040         ; $010808 BEQ.W  loc_01084A
        DC.W    $3038,$A024         ; $01080C MOVE.W  $A024.W,D0
        DC.W    $227C,$2403,$4060   ; $010810 MOVEA.L #$24034060,A1
        DC.W    $6100,$FE5C         ; $010816 BSR.W  loc_010674
        DC.W    $6000,$002E         ; $01081A BRA.W  loc_01084A
loc_01081E:
        DC.W    $4240               ; $01081E CLR.W  D0
        DC.W    $1010               ; $010820 MOVE.B  (A0),D0
        DC.W    $0C00,$0020         ; $010822 CMPI.B  #$0020,D0
        DC.W    $6700,$000C         ; $010826 BEQ.W  loc_010834
        DC.W    $227C,$2403,$4060   ; $01082A MOVEA.L #$24034060,A1
        DC.W    $6100,$FE42         ; $010830 BSR.W  loc_010674
loc_010834:
        DC.W    $4A38,$A02C         ; $010834 TST.B  $A02C.W
        DC.W    $6700,$0010         ; $010838 BEQ.W  loc_01084A
        DC.W    $3038,$A024         ; $01083C MOVE.W  $A024.W,D0
        DC.W    $227C,$2403,$4090   ; $010840 MOVEA.L #$24034090,A1
        DC.W    $6100,$FE2C         ; $010846 BSR.W  loc_010674
loc_01084A:
        DC.W    $4E75               ; $01084A RTS
loc_01084C:
        DC.W    $3401               ; $01084C MOVE.W  D1,D2
        DC.W    $E04A               ; $01084E LSR.W  #8,D2
        DC.W    $B438,$A02A         ; $010850 CMP.B  $A02A.W,D2
        DC.W    $6600,$001C         ; $010854 BNE.W  loc_010872
        DC.W    $5238,$A02B         ; $010858 ADDQ.B  #1,$A02B.W
        DC.W    $0C38,$000F,$A02B   ; $01085C CMPI.B  #$000F,$A02B.W
        DC.W    $6D00,$0012         ; $010862 BLT.W  loc_010876
        DC.W    $11FC,$000C,$A02B   ; $010866 MOVE.B  #$000C,$A02B.W
        DC.W    $3202               ; $01086C MOVE.W  D2,D1
        DC.W    $6000,$0006         ; $01086E BRA.W  loc_010876
loc_010872:
        DC.W    $4238,$A02B         ; $010872 CLR.B  $A02B.W
loc_010876:
        DC.W    $11C2,$A02A         ; $010876 MOVE.B  D2,$A02A.W
        DC.W    $0801,$0002         ; $01087A BTST    #2,D1
        DC.W    $673A               ; $01087E BEQ.S  loc_0108BA
        DC.W    $11FC,$0001,$A02C   ; $010880 MOVE.B  #$0001,$A02C.W
        DC.W    $11FC,$0000,$A02D   ; $010886 MOVE.B  #$0000,$A02D.W
        DC.W    $11FC,$00A9,$C8A4   ; $01088C MOVE.B  #$00A9,$C8A4.W
        DC.W    $4A78,$A026         ; $010892 TST.W  $A026.W
        DC.W    $6718               ; $010896 BEQ.S  loc_0108B0
        DC.W    $5378,$A026         ; $010898 SUBQ.W  #1,$A026.W
        DC.W    $0C78,$0033,$A026   ; $01089C CMPI.W  #$0033,$A026.W
        DC.W    $6600,$00A4         ; $0108A2 BNE.W  loc_010948
        DC.W    $31FC,$0019,$A026   ; $0108A6 MOVE.W  #$0019,$A026.W
        DC.W    $6000,$009A         ; $0108AC BRA.W  loc_010948
loc_0108B0:
        DC.W    $31FC,$0039,$A026   ; $0108B0 MOVE.W  #$0039,$A026.W
        DC.W    $6000,$0090         ; $0108B6 BRA.W  loc_010948
loc_0108BA:
        DC.W    $0801,$0003         ; $0108BA BTST    #3,D1
        DC.W    $673A               ; $0108BE BEQ.S  loc_0108FA
        DC.W    $11FC,$0001,$A02C   ; $0108C0 MOVE.B  #$0001,$A02C.W
        DC.W    $11FC,$0000,$A02D   ; $0108C6 MOVE.B  #$0000,$A02D.W
        DC.W    $11FC,$00A9,$C8A4   ; $0108CC MOVE.B  #$00A9,$C8A4.W
        DC.W    $0C78,$0039,$A026   ; $0108D2 CMPI.W  #$0039,$A026.W
        DC.W    $6C18               ; $0108D8 BGE.S  loc_0108F2
        DC.W    $5278,$A026         ; $0108DA ADDQ.W  #1,$A026.W
        DC.W    $0C78,$001A,$A026   ; $0108DE CMPI.W  #$001A,$A026.W
        DC.W    $6600,$0062         ; $0108E4 BNE.W  loc_010948
        DC.W    $31FC,$0034,$A026   ; $0108E8 MOVE.W  #$0034,$A026.W
        DC.W    $6000,$0058         ; $0108EE BRA.W  loc_010948
loc_0108F2:
        DC.W    $4278,$A026         ; $0108F2 CLR.W  $A026.W
        DC.W    $6000,$0050         ; $0108F6 BRA.W  loc_010948
loc_0108FA:
        DC.W    $0801,$0000         ; $0108FA BTST    #0,D1
        DC.W    $6722               ; $0108FE BEQ.S  loc_010922
        DC.W    $4A78,$A028         ; $010900 TST.W  $A028.W
        DC.W    $6700,$0042         ; $010904 BEQ.W  loc_010948
        DC.W    $11FC,$0001,$A02C   ; $010908 MOVE.B  #$0001,$A02C.W
        DC.W    $11FC,$0000,$A02D   ; $01090E MOVE.B  #$0000,$A02D.W
        DC.W    $4278,$A028         ; $010914 CLR.W  $A028.W
        DC.W    $11FC,$00A9,$C8A4   ; $010918 MOVE.B  #$00A9,$C8A4.W
        DC.W    $6000,$0028         ; $01091E BRA.W  loc_010948
loc_010922:
        DC.W    $0801,$0001         ; $010922 BTST    #1,D1
        DC.W    $6720               ; $010926 BEQ.S  loc_010948
        DC.W    $4A78,$A028         ; $010928 TST.W  $A028.W
        DC.W    $6600,$001A         ; $01092C BNE.W  loc_010948
        DC.W    $11FC,$0001,$A02C   ; $010930 MOVE.B  #$0001,$A02C.W
        DC.W    $11FC,$0000,$A02D   ; $010936 MOVE.B  #$0000,$A02D.W
        DC.W    $31FC,$0001,$A028   ; $01093C MOVE.W  #$0001,$A028.W
        DC.W    $11FC,$00A9,$C8A4   ; $010942 MOVE.B  #$00A9,$C8A4.W
loc_010948:
        DC.W    $3038,$A026         ; $010948 MOVE.W  $A026.W,D0
        DC.W    $0C40,$0019         ; $01094C CMPI.W  #$0019,D0
        DC.W    $6E00,$000E         ; $010950 BGT.W  loc_010960
        DC.W    $4A78,$A028         ; $010954 TST.W  $A028.W
        DC.W    $6700,$0006         ; $010958 BEQ.W  loc_010960
        DC.W    $0640,$001A         ; $01095C ADDI.W  #$001A,D0
loc_010960:
        DC.W    $41F9,$0089,$0974   ; $010960 LEA     $00890974,A0
        DC.W    $1030,$0000         ; $010966 MOVE.B  $00(A0,D0.W),D0
        DC.W    $0240,$00FF         ; $01096A ANDI.W  #$00FF,D0
        DC.W    $31C0,$A024         ; $01096E MOVE.W  D0,$A024.W
        DC.W    $4E75               ; $010972 RTS
        DC.W    $4142               ; $010974 DC.W    $4142
        DC.W    $4344               ; $010976 DC.W    $4344
        DC.W    $4546               ; $010978 DC.W    $4546
        DC.W    $4748               ; $01097A DC.W    $4748
        DC.W    $494A               ; $01097C DC.W    $494A
        DC.W    $4B4C               ; $01097E DC.W    $4B4C
        DC.W    $4D4E               ; $010980 DC.W    $4D4E
        DC.W    $4F50               ; $010982 DC.W    $4F50
        DC.W    $5152               ; $010984 SUBQ.W  #8,(A2)
        DC.W    $5354               ; $010986 SUBQ.W  #1,(A4)
        DC.W    $5556               ; $010988 SUBQ.W  #2,(A6)
        DC.W    $5758               ; $01098A SUBQ.W  #3,(A0)+
        DC.W    $595A               ; $01098C SUBQ.W  #4,(A2)+
        DC.W    $6162               ; $01098E BSR.S  loc_0109F2
        DC.W    $6364               ; $010990 BLS.S  loc_0109F6
        DC.W    $6566               ; $010992 BCS.S  loc_0109FA
        DC.W    $6768               ; $010994 BEQ.S  loc_0109FE
        DC.W    $696A               ; $010996 BVS.S  loc_010A02
        DC.W    $6B6C               ; $010998 BMI.S  loc_010A06
        DC.W    $6D6E               ; $01099A BLT.S  loc_010A0A
        DC.W    $6F70               ; $01099C BLE.S  loc_010A0E
        DC.W    $7172,$7374,$7576   ; $01099E MOVE.W  $74(A2,D7.W),$7576(A0)
        DC.W    $7778,$797A,$2E21   ; $0109A4 MOVE.W  $797A.W,$2E21(A3)
        DC.W    $3F20               ; $0109AA MOVE.W  -(A0),-(A7)
        DC.W    $0803,$33FC         ; $0109AC BTST    #28,D3
        DC.W    $002C,$00FF,$0008   ; $0109B0 ORI.B  #$00FF,$0008(A4)
        DC.W    $31FC,$002C,$C87A   ; $0109B6 MOVE.W  #$002C,$C87A.W
        DC.W    $08B8,$0006,$C875   ; $0109BC BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $0109C2 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $0109C6 MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $0109CE ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$26C8   ; $0109D6 JSR     $008826C8
        DC.W    $203C,$000A,$0907   ; $0109DC MOVE.L  #$000A0907,D0
        DC.W    $4EB9,$0088,$14BE   ; $0109E2 JSR     $008814BE
        DC.W    $11FC,$0001,$C80D   ; $0109E8 MOVE.B  #$0001,$C80D.W
        DC.W    $7000               ; $0109EE MOVEQ   #$00,D0
        DC.W    $41F8,$8480         ; $0109F0 LEA     $8480.W,A0
        DC.W    $721F               ; $0109F4 MOVEQ   #$1F,D1
loc_0109F6:
        DC.W    $20C0               ; $0109F6 MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $0109F8 DBRA    D1,loc_0109F6
        DC.W    $41F9,$00FF,$7B80   ; $0109FC LEA     $00FF7B80,A0
loc_010A02:
        DC.W    $727F               ; $010A02 MOVEQ   #$7F,D1
loc_010A04:
        DC.W    $20C0               ; $010A04 MOVE.L  D0,(A0)+
loc_010A06:
        DC.W    $51C9,$FFFC         ; $010A06 DBRA    D1,loc_010A04
loc_010A0A:
        DC.W    $2ABC,$6000,$0002   ; $010A0A MOVE.L  #$60000002,(A5)
        DC.W    $323C,$17FF         ; $010A10 MOVE.W  #$17FF,D1
loc_010A14:
        DC.W    $2C80               ; $010A14 MOVE.L  D0,(A6)
        DC.W    $51C9,$FFFC         ; $010A16 DBRA    D1,loc_010A14
        DC.W    $4EB9,$0088,$49AA   ; $010A1A JSR     $008849AA
        DC.W    $4278,$C880         ; $010A20 CLR.W  $C880.W
        DC.W    $4278,$C882         ; $010A24 CLR.W  $C882.W
        DC.W    $4278,$8000         ; $010A28 CLR.W  $8000.W
        DC.W    $4278,$8002         ; $010A2C CLR.W  $8002.W
        DC.W    $4278,$A012         ; $010A30 CLR.W  $A012.W
        DC.W    $4238,$A018         ; $010A34 CLR.B  $A018.W
        DC.W    $4EB9,$0088,$49AA   ; $010A38 JSR     $008849AA
        DC.W    $21FC,$008B,$B4FC,$C96C; $010A3E MOVE.L  #$008BB4FC,$C96C.W
        DC.W    $11FC,$0001,$C809   ; $010A46 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $010A4C MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $010A52 BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $010A58 MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0001,$A05C   ; $010A5E MOVE.W  #$0001,$A05C.W
        DC.W    $41F9,$00FF,$1000   ; $010A64 LEA     $00FF1000,A0
        DC.W    $303C,$037F         ; $010A6A MOVE.W  #$037F,D0
loc_010A6E:
        DC.W    $4298               ; $010A6E CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $010A70 DBRA    D0,loc_010A6E
        DC.W    $303C,$0001         ; $010A74 MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $010A78 MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $010A7C MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $010A80 MOVE.W  #$0026,D3
        DC.W    $383C,$001A         ; $010A84 MOVE.W  #$001A,D4
        DC.W    $41F9,$00FF,$1000   ; $010A88 LEA     $00FF1000,A0
        DC.W    $4EBA,$D79C         ; $010A8E JSR     $00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $010A92 LEA     $00FF1000,A0
        DC.W    $4EBA,$D856         ; $010A98 JSR     $00E2F0(PC)
        DC.W    $4EBA,$D71E         ; $010A9C JSR     $00E1BC(PC)
        DC.W    $08B9,$0007,$00A1,$5181; $010AA0 BCLR    #7,$00A15181
        DC.W    $41F9,$00FF,$6E00   ; $010AA8 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0160   ; $010AAE ADDA.L  #$00000160,A0
        DC.W    $43F9,$0089,$1062   ; $010AB4 LEA     $00891062,A1
        DC.W    $303C,$003F         ; $010ABA MOVE.W  #$003F,D0
loc_010ABE:
        DC.W    $3219               ; $010ABE MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $010AC0 BSET    #15,D1
        DC.W    $30C1               ; $010AC4 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $010AC6 DBRA    D0,loc_010ABE
        DC.W    $0838,$0004,$C80E   ; $010ACA BTST    #4,$C80E.W
        DC.W    $6700,$0024         ; $010AD0 BEQ.W  loc_010AF6
        DC.W    $41F9,$00FF,$6E00   ; $010AD4 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0180   ; $010ADA ADDA.L  #$00000180,A0
        DC.W    $43F9,$0089,$10E2   ; $010AE0 LEA     $008910E2,A1
        DC.W    $303C,$000F         ; $010AE6 MOVE.W  #$000F,D0
loc_010AEA:
        DC.W    $3219               ; $010AEA MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $010AEC BSET    #15,D1
        DC.W    $30C1               ; $010AF0 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $010AF2 DBRA    D0,loc_010AEA
loc_010AF6:
        DC.W    $41F9,$000E,$C980   ; $010AF6 LEA     $000EC980,A0
        DC.W    $227C,$0601,$8000   ; $010AFC MOVEA.L #$06018000,A1
        DC.W    $4EBA,$D812         ; $010B02 JSR     $00E316(PC)
        DC.W    $41F9,$000E,$CC90   ; $010B06 LEA     $000ECC90,A0
        DC.W    $227C,$0601,$8500   ; $010B0C MOVEA.L #$06018500,A1
        DC.W    $4EBA,$D802         ; $010B12 JSR     $00E316(PC)
        DC.W    $41F9,$000E,$CE20   ; $010B16 LEA     $000ECE20,A0
        DC.W    $227C,$0601,$8C00   ; $010B1C MOVEA.L #$06018C00,A1
        DC.W    $4EBA,$D7F2         ; $010B22 JSR     $00E316(PC)
        DC.W    $0838,$0004,$C80E   ; $010B26 BTST    #4,$C80E.W
        DC.W    $6700,$0012         ; $010B2C BEQ.W  loc_010B40
        DC.W    $41F9,$000E,$CAB0   ; $010B30 LEA     $000ECAB0,A0
        DC.W    $227C,$0601,$8F80   ; $010B36 MOVEA.L #$06018F80,A1
        DC.W    $4EBA,$D7D8         ; $010B3C JSR     $00E316(PC)
loc_010B40:
        DC.W    $41F9,$000E,$BB40   ; $010B40 LEA     $000EBB40,A0
        DC.W    $227C,$0601,$AD00   ; $010B46 MOVEA.L #$0601AD00,A1
        DC.W    $4EBA,$D7C8         ; $010B4C JSR     $00E316(PC)
        DC.W    $41F9,$000E,$B980   ; $010B50 LEA     $000EB980,A0
        DC.W    $227C,$0601,$DF00   ; $010B56 MOVEA.L #$0601DF00,A1
        DC.W    $4EBA,$D7B8         ; $010B5C JSR     $00E316(PC)
        DC.W    $7000               ; $010B60 MOVEQ   #$00,D0
        DC.W    $1038,$FEB1         ; $010B62 MOVE.B  $FEB1.W,D0
        DC.W    $0838,$0005,$C80E   ; $010B66 BTST    #5,$C80E.W
        DC.W    $6700,$0006         ; $010B6C BEQ.W  loc_010B74
        DC.W    $1038,$FEB2         ; $010B70 MOVE.B  $FEB2.W,D0
loc_010B74:
        DC.W    $0838,$0004,$C80E   ; $010B74 BTST    #4,$C80E.W
        DC.W    $6700,$0006         ; $010B7A BEQ.W  loc_010B82
        DC.W    $1038,$FEB3         ; $010B7E MOVE.B  $FEB3.W,D0
loc_010B82:
        DC.W    $D080               ; $010B82 ADD.L  D0,D0
        DC.W    $D080               ; $010B84 ADD.L  D0,D0
        DC.W    $41F9,$0089,$103E   ; $010B86 LEA     $0089103E,A0
        DC.W    $2070,$0000         ; $010B8C MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0601,$E8C0   ; $010B90 MOVEA.L #$0601E8C0,A1
        DC.W    $4EBA,$D77E         ; $010B96 JSR     $00E316(PC)
        DC.W    $7000               ; $010B9A MOVEQ   #$00,D0
        DC.W    $1038,$FEA5         ; $010B9C MOVE.B  $FEA5.W,D0
        DC.W    $0838,$0005,$C80E   ; $010BA0 BTST    #5,$C80E.W
        DC.W    $6700,$0006         ; $010BA6 BEQ.W  loc_010BAE
        DC.W    $1038,$FEA7         ; $010BAA MOVE.B  $FEA7.W,D0
loc_010BAE:
        DC.W    $0838,$0004,$C80E   ; $010BAE BTST    #4,$C80E.W
        DC.W    $6700,$0006         ; $010BB4 BEQ.W  loc_010BBC
        DC.W    $1038,$FEAB         ; $010BB8 MOVE.B  $FEAB.W,D0
loc_010BBC:
        DC.W    $D080               ; $010BBC ADD.L  D0,D0
        DC.W    $D080               ; $010BBE ADD.L  D0,D0
        DC.W    $41F9,$0089,$104A   ; $010BC0 LEA     $0089104A,A0
        DC.W    $2070,$0000         ; $010BC6 MOVEA.L $00(A0,D0.W),A0
        DC.W    $227C,$0601,$EE40   ; $010BCA MOVEA.L #$0601EE40,A1
        DC.W    $4EBA,$D744         ; $010BD0 JSR     $00E316(PC)
        DC.W    $41F9,$000E,$DE10   ; $010BD4 LEA     $000EDE10,A0
        DC.W    $227C,$0601,$0000   ; $010BDA MOVEA.L #$06010000,A1
        DC.W    $4EBA,$D734         ; $010BE0 JSR     $00E316(PC)
        DC.W    $11FC,$0000,$A019   ; $010BE4 MOVE.B  #$0000,$A019.W
        DC.W    $11FC,$0000,$A01A   ; $010BEA MOVE.B  #$0000,$A01A.W
        DC.W    $11FC,$0002,$A01C   ; $010BF0 MOVE.B  #$0002,$A01C.W
        DC.W    $21FC,$0000,$0000,$A022; $010BF6 MOVE.L  #$00000000,$A022.W
        DC.W    $21FC,$0000,$0000,$A026; $010BFE MOVE.L  #$00000000,$A026.W
        DC.W    $11FC,$0000,$A02E   ; $010C06 MOVE.B  #$0000,$A02E.W
        DC.W    $21FC,$0000,$0000,$A032; $010C0C MOVE.L  #$00000000,$A032.W
        DC.W    $21FC,$0000,$0000,$A036; $010C14 MOVE.L  #$00000000,$A036.W
        DC.W    $11FC,$0000,$A03E   ; $010C1C MOVE.B  #$0000,$A03E.W
        DC.W    $4278,$A050         ; $010C22 CLR.W  $A050.W
        DC.W    $31FC,$0010,$A052   ; $010C26 MOVE.W  #$0010,$A052.W
        DC.W    $7000               ; $010C2C MOVEQ   #$00,D0
        DC.W    $1038,$FEA8         ; $010C2E MOVE.B  $FEA8.W,D0
        DC.W    $41F9,$0089,$1102   ; $010C32 LEA     $00891102,A0
        DC.W    $0838,$0005,$C80E   ; $010C38 BTST    #5,$C80E.W
        DC.W    $6616               ; $010C3E BNE.S  loc_010C56
        DC.W    $1038,$FEAC         ; $010C40 MOVE.B  $FEAC.W,D0
        DC.W    $41F9,$0089,$1112   ; $010C44 LEA     $00891112,A0
        DC.W    $0838,$0004,$C80E   ; $010C4A BTST    #4,$C80E.W
        DC.W    $6604               ; $010C50 BNE.S  loc_010C56
        DC.W    $103C,$0000         ; $010C52 MOVE.B  #$0000,D0
loc_010C56:
        DC.W    $D040               ; $010C56 ADD.W  D0,D0
        DC.W    $D040               ; $010C58 ADD.W  D0,D0
        DC.W    $21F0,$0000,$A02A   ; $010C5A MOVE.L  $00(A0,D0.W),$A02A.W
        DC.W    $21F0,$0000,$A03A   ; $010C60 MOVE.L  $00(A0,D0.W),$A03A.W
        DC.W    $42B8,$A046         ; $010C66 CLR.L  $A046.W
        DC.W    $41F8,$A046         ; $010C6A LEA     $A046.W,A0
        DC.W    $43F8,$C200         ; $010C6E LEA     $C200.W,A1
        DC.W    $343C,$0013         ; $010C72 MOVE.W  #$0013,D2
loc_010C76:
        DC.W    $0600,$0000         ; $010C76 ADDI.B  #$0000,D0
        DC.W    $1028,$0003         ; $010C7A MOVE.B  $0003(A0),D0
        DC.W    $1229,$0003         ; $010C7E MOVE.B  $0003(A1),D1
        DC.W    $C101               ; $010C82 AND.B  D0,D1
        DC.W    $1140,$0003         ; $010C84 MOVE.B  D0,$0003(A0)
        DC.W    $1028,$0002         ; $010C88 MOVE.B  $0002(A0),D0
        DC.W    $1229,$0002         ; $010C8C MOVE.B  $0002(A1),D1
        DC.W    $C101               ; $010C90 AND.B  D0,D1
        DC.W    $1200               ; $010C92 MOVE.B  D0,D1
        DC.W    $0200,$000F         ; $010C94 ANDI.B  #$000F,D0
        DC.W    $1140,$0002         ; $010C98 MOVE.B  D0,$0002(A0)
        DC.W    $E809               ; $010C9C LSR.B  #4,D1
        DC.W    $0600,$0000         ; $010C9E ADDI.B  #$0000,D0
        DC.W    $1028,$0001         ; $010CA2 MOVE.B  $0001(A0),D0
        DC.W    $C101               ; $010CA6 AND.B  D0,D1
        DC.W    $1229,$0001         ; $010CA8 MOVE.B  $0001(A1),D1
        DC.W    $C101               ; $010CAC AND.B  D0,D1
        DC.W    $6400,$0012         ; $010CAE BCC.W  loc_010CC2
        DC.W    $0600,$0000         ; $010CB2 ADDI.B  #$0000,D0
        DC.W    $123C,$0040         ; $010CB6 MOVE.B  #$0040,D1
        DC.W    $C101               ; $010CBA AND.B  D0,D1
        DC.W    $123C,$0001         ; $010CBC MOVE.B  #$0001,D1
        DC.W    $6018               ; $010CC0 BRA.S  loc_010CDA
loc_010CC2:
        DC.W    $4201               ; $010CC2 CLR.B  D1
        DC.W    $0C00,$0060         ; $010CC4 CMPI.B  #$0060,D0
        DC.W    $6500,$0010         ; $010CC8 BCS.W  loc_010CDA
        DC.W    $0600,$0000         ; $010CCC ADDI.B  #$0000,D0
        DC.W    $123C,$0060         ; $010CD0 MOVE.B  #$0060,D1
        DC.W    $8101               ; $010CD4 OR.B   D0,D1
        DC.W    $123C,$0001         ; $010CD6 MOVE.B  #$0001,D1
loc_010CDA:
        DC.W    $1140,$0001         ; $010CDA MOVE.B  D0,$0001(A0)
        DC.W    $0600,$0000         ; $010CDE ADDI.B  #$0000,D0
        DC.W    $1010               ; $010CE2 MOVE.B  (A0),D0
        DC.W    $C101               ; $010CE4 AND.B  D0,D1
        DC.W    $1211               ; $010CE6 MOVE.B  (A1),D1
        DC.W    $C101               ; $010CE8 AND.B  D0,D1
        DC.W    $1080               ; $010CEA MOVE.B  D0,(A0)
        DC.W    $5889               ; $010CEC ADDQ.L  #4,A1
        DC.W    $51CA,$FF86         ; $010CEE DBRA    D2,loc_010C76
        DC.W    $4AB8,$A046         ; $010CF2 TST.L  $A046.W
        DC.W    $6608               ; $010CF6 BNE.S  loc_010D00
        DC.W    $21FC,$CCCC,$0CCC,$A046; $010CF8 MOVE.L  #$CCCC0CCC,$A046.W
loc_010D00:
        DC.W    $41F8,$C200         ; $010D00 LEA     $C200.W,A0
        DC.W    $303C,$0013         ; $010D04 MOVE.W  #$0013,D0
loc_010D08:
        DC.W    $4A90               ; $010D08 TST.L  (A0)
        DC.W    $6700,$000A         ; $010D0A BEQ.W  loc_010D16
        DC.W    $5888               ; $010D0E ADDQ.L  #4,A0
        DC.W    $51C8,$FFF6         ; $010D10 DBRA    D0,loc_010D08
        DC.W    $600A               ; $010D14 BRA.S  loc_010D20
loc_010D16:
        DC.W    $20FC,$CCCC,$0CCC   ; $010D16 MOVE.L  #$CCCC0CCC,(A0)+
        DC.W    $51C8,$FFF8         ; $010D1C DBRA    D0,loc_010D16
loc_010D20:
        DC.W    $31FC,$0000,$A042   ; $010D20 MOVE.W  #$0000,$A042.W
        DC.W    $41F8,$C200         ; $010D26 LEA     $C200.W,A0
        DC.W    $2028,$0010         ; $010D2A MOVE.L  $0010(A0),D0
        DC.W    $0C80,$CCCC,$0CCC   ; $010D2E CMPI.L  #$CCCC0CCC,D0
        DC.W    $6606               ; $010D34 BNE.S  loc_010D3C
        DC.W    $31FC,$0001,$A042   ; $010D36 MOVE.W  #$0001,$A042.W
loc_010D3C:
        DC.W    $7400               ; $010D3C MOVEQ   #$00,D2
        DC.W    $21C2,$A01E         ; $010D3E MOVE.L  D2,$A01E.W
        DC.W    $41F8,$C200         ; $010D42 LEA     $C200.W,A0
        DC.W    $203C,$6000,$0000   ; $010D46 MOVE.L  #$60000000,D0
        DC.W    $363C,$0013         ; $010D4C MOVE.W  #$0013,D3
loc_010D50:
        DC.W    $2218               ; $010D50 MOVE.L  (A0)+,D1
        DC.W    $6712               ; $010D52 BEQ.S  loc_010D66
        DC.W    $0C81,$CCCC,$0CCC   ; $010D54 CMPI.L  #$CCCC0CCC,D1
        DC.W    $670A               ; $010D5A BEQ.S  loc_010D66
        DC.W    $B081               ; $010D5C CMP.L  D1,D0
        DC.W    $6F06               ; $010D5E BLE.S  loc_010D66
        DC.W    $2001               ; $010D60 MOVE.L  D1,D0
        DC.W    $21C2,$A01E         ; $010D62 MOVE.L  D2,$A01E.W
loc_010D66:
        DC.W    $0682,$0000,$0D80   ; $010D66 ADDI.L  #$00000D80,D2
        DC.W    $51CB,$FFE2         ; $010D6C DBRA    D3,loc_010D50
loc_010D70:
        DC.W    $4A39,$00A1,$5120   ; $010D70 TST.B  $00A15120
        DC.W    $66F8               ; $010D76 BNE.S  loc_010D70
        DC.W    $23FC,$0602,$0000,$00A1,$5128; $010D78 MOVE.L  #$06020000,$00A15128
        DC.W    $13FC,$0026,$00A1,$5121; $010D82 MOVE.B  #$0026,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $010D8A MOVE.B  #$0001,$00A15120
        DC.W    $0838,$0004,$C80E   ; $010D92 BTST    #4,$C80E.W
        DC.W    $6600,$00E4         ; $010D98 BNE.W  loc_010E7E
        DC.W    $207C,$0601,$AD00   ; $010D9C MOVEA.L #$0601AD00,A0
        DC.W    $227C,$0602,$8000   ; $010DA2 MOVEA.L #$06028000,A1
        DC.W    $303C,$0028         ; $010DA8 MOVE.W  #$0028,D0
        DC.W    $323C,$0140         ; $010DAC MOVE.W  #$0140,D1
        DC.W    $343C,$00D8         ; $010DB0 MOVE.W  #$00D8,D2
        DC.W    $4EBA,$0CE2         ; $010DB4 JSR     loc_011A98(PC)
        DC.W    $7600               ; $010DB8 MOVEQ   #$00,D3
        DC.W    $7800               ; $010DBA MOVEQ   #$00,D4
        DC.W    $3A3C,$0013         ; $010DBC MOVE.W  #$0013,D5
loc_010DC0:
        DC.W    $227C,$0602,$8030   ; $010DC0 MOVEA.L #$06028030,A1
        DC.W    $D3C3               ; $010DC6 ADDA.L  D3,A1
        DC.W    $0683,$0000,$0D80   ; $010DC8 ADDI.L  #$00000D80,D3
        DC.W    $45F8,$C200         ; $010DCE LEA     $C200.W,A2
        DC.W    $D5C4               ; $010DD2 ADDA.L  D4,A2
        DC.W    $5884               ; $010DD4 ADDQ.L  #4,D4
        DC.W    $343C,$00D8         ; $010DD6 MOVE.W  #$00D8,D2
        DC.W    $4EBA,$0B66         ; $010DDA JSR     loc_011942(PC)
        DC.W    $51CD,$FFE0         ; $010DDE DBRA    D5,loc_010DC0
        DC.W    $0CB8,$6100,$0000,$C254; $010DE2 CMPI.L  #$61000000,$C254.W
        DC.W    $6700,$008E         ; $010DEA BEQ.W  loc_010E7A
        DC.W    $45F8,$C200         ; $010DEE LEA     $C200.W,A2
        DC.W    $223C,$6000,$0000   ; $010DF2 MOVE.L  #$60000000,D1
        DC.W    $4243               ; $010DF8 CLR.W  D3
        DC.W    $343C,$0001         ; $010DFA MOVE.W  #$0001,D2
        DC.W    $383C,$0013         ; $010DFE MOVE.W  #$0013,D4
loc_010E02:
        DC.W    $201A               ; $010E02 MOVE.L  (A2)+,D0
        DC.W    $0C80,$CCCC,$0CCC   ; $010E04 CMPI.L  #$CCCC0CCC,D0
        DC.W    $6708               ; $010E0A BEQ.S  loc_010E14
        DC.W    $B081               ; $010E0C CMP.L  D1,D0
        DC.W    $6404               ; $010E0E BCC.S  loc_010E14
        DC.W    $2200               ; $010E10 MOVE.L  D0,D1
        DC.W    $3602               ; $010E12 MOVE.W  D2,D3
loc_010E14:
        DC.W    $5242               ; $010E14 ADDQ.W  #1,D2
        DC.W    $51CC,$FFEA         ; $010E16 DBRA    D4,loc_010E02
        DC.W    $4A43               ; $010E1A TST.W  D3
        DC.W    $6736               ; $010E1C BEQ.S  loc_010E54
        DC.W    $207C,$0602,$8030   ; $010E1E MOVEA.L #$06028030,A0
        DC.W    $5343               ; $010E24 SUBQ.W  #1,D3
        DC.W    $0283,$0000,$FFFF   ; $010E26 ANDI.L  #$0000FFFF,D3
        DC.W    $EF8B               ; $010E2C LSL.L  #7,D3
        DC.W    $2803               ; $010E2E MOVE.L  D3,D4
        DC.W    $E38B               ; $010E30 LSL.L  #1,D3
        DC.W    $D883               ; $010E32 ADD.L  D3,D4
        DC.W    $E58B               ; $010E34 LSL.L  #2,D3
        DC.W    $D883               ; $010E36 ADD.L  D3,D4
        DC.W    $E38B               ; $010E38 LSL.L  #1,D3
        DC.W    $D684               ; $010E3A ADD.L  D4,D3
        DC.W    $D1C3               ; $010E3C ADDA.L  D3,A0
        DC.W    $303C,$0078         ; $010E3E MOVE.W  #$0078,D0
        DC.W    $323C,$0010         ; $010E42 MOVE.W  #$0010,D1
        DC.W    $343C,$0008         ; $010E46 MOVE.W  #$0008,D2
        DC.W    $363C,$00D8         ; $010E4A MOVE.W  #$00D8,D3
        DC.W    $4EB9,$0088,$E406   ; $010E4E JSR     $0088E406
loc_010E54:
        DC.W    $207C,$0601,$9D00   ; $010E54 MOVEA.L #$06019D00,A0
        DC.W    $227C,$0602,$8088   ; $010E5A MOVEA.L #$06028088,A1
        DC.W    $D3F8,$A01E         ; $010E60 ADDA.L  $A01E.W,A1
        DC.W    $303C,$0050         ; $010E64 MOVE.W  #$0050,D0
        DC.W    $323C,$0010         ; $010E68 MOVE.W  #$0010,D1
        DC.W    $343C,$00D8         ; $010E6C MOVE.W  #$00D8,D2
        DC.W    $0683,$0000,$0D80   ; $010E70 ADDI.L  #$00000D80,D3
        DC.W    $4EBA,$0C20         ; $010E76 JSR     loc_011A98(PC)
loc_010E7A:
        DC.W    $6000,$014C         ; $010E7A BRA.W  loc_010FC8
loc_010E7E:
        DC.W    $207C,$0601,$AD00   ; $010E7E MOVEA.L #$0601AD00,A0
        DC.W    $227C,$0602,$8000   ; $010E84 MOVEA.L #$06028000,A1
        DC.W    $303C,$0028         ; $010E8A MOVE.W  #$0028,D0
        DC.W    $323C,$0140         ; $010E8E MOVE.W  #$0140,D1
        DC.W    $343C,$0080         ; $010E92 MOVE.W  #$0080,D2
        DC.W    $4EBA,$0C00         ; $010E96 JSR     loc_011A98(PC)
        DC.W    $7600               ; $010E9A MOVEQ   #$00,D3
        DC.W    $7800               ; $010E9C MOVEQ   #$00,D4
        DC.W    $3A3C,$0013         ; $010E9E MOVE.W  #$0013,D5
loc_010EA2:
        DC.W    $227C,$0602,$8030   ; $010EA2 MOVEA.L #$06028030,A1
        DC.W    $D3C3               ; $010EA8 ADDA.L  D3,A1
        DC.W    $0683,$0000,$0800   ; $010EAA ADDI.L  #$00000800,D3
        DC.W    $45F8,$C200         ; $010EB0 LEA     $C200.W,A2
        DC.W    $D5C4               ; $010EB4 ADDA.L  D4,A2
        DC.W    $5884               ; $010EB6 ADDQ.L  #4,D4
        DC.W    $343C,$0080         ; $010EB8 MOVE.W  #$0080,D2
        DC.W    $4EBA,$0A84         ; $010EBC JSR     loc_011942(PC)
        DC.W    $51CD,$FFE0         ; $010EC0 DBRA    D5,loc_010EA2
        DC.W    $45F8,$C200         ; $010EC4 LEA     $C200.W,A2
        DC.W    $223C,$6000,$0000   ; $010EC8 MOVE.L  #$60000000,D1
        DC.W    $4243               ; $010ECE CLR.W  D3
        DC.W    $343C,$0001         ; $010ED0 MOVE.W  #$0001,D2
        DC.W    $383C,$0013         ; $010ED4 MOVE.W  #$0013,D4
loc_010ED8:
        DC.W    $201A               ; $010ED8 MOVE.L  (A2)+,D0
        DC.W    $0C80,$CCCC,$0CCC   ; $010EDA CMPI.L  #$CCCC0CCC,D0
        DC.W    $6708               ; $010EE0 BEQ.S  loc_010EEA
        DC.W    $B081               ; $010EE2 CMP.L  D1,D0
        DC.W    $6404               ; $010EE4 BCC.S  loc_010EEA
        DC.W    $2200               ; $010EE6 MOVE.L  D0,D1
        DC.W    $3602               ; $010EE8 MOVE.W  D2,D3
loc_010EEA:
        DC.W    $5242               ; $010EEA ADDQ.W  #1,D2
        DC.W    $51CC,$FFEA         ; $010EEC DBRA    D4,loc_010ED8
        DC.W    $4A43               ; $010EF0 TST.W  D3
        DC.W    $672A               ; $010EF2 BEQ.S  loc_010F1E
        DC.W    $207C,$0602,$8000   ; $010EF4 MOVEA.L #$06028000,A0
        DC.W    $5343               ; $010EFA SUBQ.W  #1,D3
        DC.W    $0283,$0000,$FFFF   ; $010EFC ANDI.L  #$0000FFFF,D3
        DC.W    $E18B               ; $010F02 LSL.L  #8,D3
        DC.W    $E78B               ; $010F04 LSL.L  #3,D3
        DC.W    $D1C3               ; $010F06 ADDA.L  D3,A0
        DC.W    $303C,$0080         ; $010F08 MOVE.W  #$0080,D0
        DC.W    $323C,$0010         ; $010F0C MOVE.W  #$0010,D1
        DC.W    $343C,$0008         ; $010F10 MOVE.W  #$0008,D2
        DC.W    $363C,$0080         ; $010F14 MOVE.W  #$0080,D3
        DC.W    $4EB9,$0088,$E406   ; $010F18 JSR     $0088E406
loc_010F1E:
        DC.W    $6100,$0C4A         ; $010F1E BSR.W  loc_011B6A
        DC.W    $207C,$2601,$AD00   ; $010F22 MOVEA.L #$2601AD00,A0
        DC.W    $227C,$2603,$2000   ; $010F28 MOVEA.L #$26032000,A1
        DC.W    $303C,$0028         ; $010F2E MOVE.W  #$0028,D0
        DC.W    $323C,$0140         ; $010F32 MOVE.W  #$0140,D1
        DC.W    $343C,$0080         ; $010F36 MOVE.W  #$0080,D2
        DC.W    $4EBA,$0B5C         ; $010F3A JSR     loc_011A98(PC)
        DC.W    $7600               ; $010F3E MOVEQ   #$00,D3
        DC.W    $7800               ; $010F40 MOVEQ   #$00,D4
        DC.W    $3A3C,$0013         ; $010F42 MOVE.W  #$0013,D5
loc_010F46:
        DC.W    $227C,$0603,$2030   ; $010F46 MOVEA.L #$06032030,A1
        DC.W    $D3C3               ; $010F4C ADDA.L  D3,A1
        DC.W    $0683,$0000,$0800   ; $010F4E ADDI.L  #$00000800,D3
        DC.W    $45F8,$C200         ; $010F54 LEA     $C200.W,A2
        DC.W    $D5C4               ; $010F58 ADDA.L  D4,A2
        DC.W    $5884               ; $010F5A ADDQ.L  #4,D4
        DC.W    $343C,$0080         ; $010F5C MOVE.W  #$0080,D2
        DC.W    $4EBA,$09E0         ; $010F60 JSR     loc_011942(PC)
        DC.W    $51CD,$FFE0         ; $010F64 DBRA    D5,loc_010F46
        DC.W    $45F8,$C200         ; $010F68 LEA     $C200.W,A2
        DC.W    $223C,$6000,$0000   ; $010F6C MOVE.L  #$60000000,D1
        DC.W    $4243               ; $010F72 CLR.W  D3
        DC.W    $343C,$0001         ; $010F74 MOVE.W  #$0001,D2
        DC.W    $383C,$0013         ; $010F78 MOVE.W  #$0013,D4
loc_010F7C:
        DC.W    $201A               ; $010F7C MOVE.L  (A2)+,D0
        DC.W    $0C80,$CCCC,$0CCC   ; $010F7E CMPI.L  #$CCCC0CCC,D0
        DC.W    $6708               ; $010F84 BEQ.S  loc_010F8E
        DC.W    $B081               ; $010F86 CMP.L  D1,D0
        DC.W    $6404               ; $010F88 BCC.S  loc_010F8E
        DC.W    $2200               ; $010F8A MOVE.L  D0,D1
        DC.W    $3602               ; $010F8C MOVE.W  D2,D3
loc_010F8E:
        DC.W    $5242               ; $010F8E ADDQ.W  #1,D2
        DC.W    $51CC,$FFEA         ; $010F90 DBRA    D4,loc_010F7C
        DC.W    $4A43               ; $010F94 TST.W  D3
        DC.W    $672A               ; $010F96 BEQ.S  loc_010FC2
        DC.W    $207C,$0603,$2000   ; $010F98 MOVEA.L #$06032000,A0
        DC.W    $5343               ; $010F9E SUBQ.W  #1,D3
        DC.W    $0283,$0000,$FFFF   ; $010FA0 ANDI.L  #$0000FFFF,D3
        DC.W    $E18B               ; $010FA6 LSL.L  #8,D3
        DC.W    $E78B               ; $010FA8 LSL.L  #3,D3
        DC.W    $D1C3               ; $010FAA ADDA.L  D3,A0
        DC.W    $303C,$0080         ; $010FAC MOVE.W  #$0080,D0
        DC.W    $323C,$0010         ; $010FB0 MOVE.W  #$0010,D1
        DC.W    $343C,$0008         ; $010FB4 MOVE.W  #$0008,D2
        DC.W    $363C,$0080         ; $010FB8 MOVE.W  #$0080,D3
        DC.W    $4EB9,$0088,$E406   ; $010FBC JSR     $0088E406
loc_010FC2:
        DC.W    $4EB9,$0088,$204A   ; $010FC2 JSR     $0088204A
loc_010FC8:
        DC.W    $11FC,$0001,$C821   ; $010FC8 MOVE.B  #$0001,$C821.W
        DC.W    $0239,$00FC,$00A1,$5181; $010FCE ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $010FD6 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $010FDE MOVE.W  #$8083,$00A15100
        DC.W    $08F8,$0006,$C875   ; $010FE6 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $010FEC MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0018,$00FF,$0008; $010FF0 MOVE.W  #$0018,$00FF0008
        DC.W    $4EB9,$0088,$4998   ; $010FF8 JSR     $00884998
        DC.W    $31FC,$0000,$C87E   ; $010FFE MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0089,$1166,$00FF,$0002; $011004 MOVE.L  #$00891166,$00FF0002
        DC.W    $0838,$0004,$C80E   ; $01100E BTST    #4,$C80E.W
        DC.W    $6600,$0020         ; $011014 BNE.W  loc_011036
        DC.W    $23FC,$0089,$1142,$00FF,$0002; $011018 MOVE.L  #$00891142,$00FF0002
        DC.W    $0838,$0005,$C80E   ; $011022 BTST    #5,$C80E.W
        DC.W    $6600,$000C         ; $011028 BNE.W  loc_011036
        DC.W    $23FC,$0089,$1122,$00FF,$0002; $01102C MOVE.L  #$00891122,$00FF0002
loc_011036:
        DC.W    $11FC,$008E,$C8A5   ; $011036 MOVE.B  #$008E,$C8A5.W
        DC.W    $4E75               ; $01103C RTS
        DC.W    $000E,$D310         ; $01103E ORI.B  #$D310,A6
        DC.W    $000E,$D440         ; $011042 ORI.B  #$D440,A6
        DC.W    $000E,$D530         ; $011046 ORI.B  #$D530,A6
        DC.W    $000E,$D670         ; $01104A ORI.B  #$D670,A6
        DC.W    $000E,$D7D0         ; $01104E ORI.B  #$D7D0,A6
        DC.W    $000E,$D930         ; $011052 ORI.B  #$D930,A6
        DC.W    $000E,$DA70         ; $011056 ORI.B  #$DA70,A6
        DC.W    $000E,$DBA0         ; $01105A ORI.B  #$DBA0,A6
        DC.W    $000E,$DD10         ; $01105E ORI.B  #$DD10,A6
        DC.W    $4400               ; $011062 NEG.B  D0
        DC.W    $44A3               ; $011064 NEG.L  -(A3)
        DC.W    $4946               ; $011066 DC.W    $4946
        DC.W    $4DE9,$1C00         ; $011068 LEA     $1C00(A1),A6
        DC.W    $28A3               ; $01106C MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $01106E MOVE.W  D6,$41E9(A2)
        DC.W    $0010,$14AF         ; $011072 ORI.B  #$14AF,(A0)
        DC.W    $294E,$3DED         ; $011076 MOVE.L  A6,$3DED(A4)
        DC.W    $1C00               ; $01107A MOVE.B  D0,D6
        DC.W    $28A3               ; $01107C MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $01107E MOVE.W  D6,$41E9(A2)
        DC.W    $4400               ; $011082 NEG.B  D0
        DC.W    $44A3               ; $011084 NEG.L  -(A3)
        DC.W    $4946               ; $011086 DC.W    $4946
        DC.W    $4DE9,$7FFF         ; $011088 LEA     $7FFF(A1),A6
        DC.W    $63F5               ; $01108C BLS.S  loc_011083
        DC.W    $7FFF               ; $01108E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011090 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $011092 ORI.B  #$14AF,(A0)
        DC.W    $294E,$3DED         ; $011096 MOVE.L  A6,$3DED(A4)
        DC.W    $7FFF               ; $01109A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01109C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01109E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110A8 MOVE.W  <EA:3F>,<EA:3F>
loc_0110AA:
        DC.W    $4445               ; $0110AA NEG.W  D5
        DC.W    $512B,$6212         ; $0110AC SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $0110B0 BGT.S  loc_0110AA
        DC.W    $7FFF               ; $0110B2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0E9A               ; $0110B4 DC.W    $0E9A
        DC.W    $7FFF               ; $0110B6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110BE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110C0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $0110C2 ORI.B  #$14AF,(A0)
        DC.W    $294E,$3DED         ; $0110C6 MOVE.L  A6,$3DED(A4)
loc_0110CA:
        DC.W    $4445               ; $0110CA NEG.W  D5
        DC.W    $512B,$6212         ; $0110CC SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $0110D0 BGT.S  loc_0110CA
        DC.W    $7FFF               ; $0110D2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $031F               ; $0110D4 BTST    D1,(A7)+
        DC.W    $7FFF               ; $0110D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110DA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110DC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $4400               ; $0110E2 NEG.B  D0
        DC.W    $44A3               ; $0110E4 NEG.L  -(A3)
        DC.W    $4946               ; $0110E6 DC.W    $4946
        DC.W    $4DE9,$4445         ; $0110E8 LEA     $4445(A1),A6
        DC.W    $44C6               ; $0110EC NEG    D6
        DC.W    $4968               ; $0110EE DC.W    $4968
        DC.W    $4DEA,$7FFF         ; $0110F0 LEA     $7FFF(A2),A6
        DC.W    $63F5               ; $0110F4 BLS.S  loc_0110EB
        DC.W    $7FFF               ; $0110F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110FA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0110FE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011100 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0000,$0000         ; $011102 ORI.B  #$0000,D0
        DC.W    $0000,$4380         ; $011106 ORI.B  #$4380,D0
        DC.W    $0000,$8700         ; $01110A ORI.B  #$8700,D0
        DC.W    $0000,$CA80         ; $01110E ORI.B  #$CA80,D0
        DC.W    $0000,$0000         ; $011112 ORI.B  #$0000,D0
        DC.W    $0000,$2800         ; $011116 ORI.B  #$2800,D0
        DC.W    $0000,$5000         ; $01111A ORI.B  #$5000,D0
        DC.W    $0000,$7800         ; $01111E ORI.B  #$7800,D0
        DC.W    $4EB9,$0088,$2080   ; $011122 JSR     $00882080
        DC.W    $3038,$C87E         ; $011128 MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $01112C MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $011130 JMP     (A1)
        DC.W    $0089,$11A4,$0089   ; $011132 ORI.L  #$11A40089,A1
        DC.W    $11A4,$0089         ; $011138 MOVE.B  -(A4),-$77(A0,D0.W)
        DC.W    $1240               ; $01113C MOVEA.B D0,A1
        DC.W    $0089,$17F4,$4EB9   ; $01113E ORI.L  #$17F44EB9,A1
        DC.W    $0088,$2080,$3038   ; $011144 ORI.L  #$20803038,A0
        DC.W    $C87E               ; $01114A AND.W  <EA:3E>,D4
        DC.W    $227B,$0004         ; $01114C MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $011150 JMP     (A1)
        DC.W    $0089,$11A4,$0089   ; $011152 ORI.L  #$11A40089,A1
        DC.W    $11A4,$0089         ; $011158 MOVE.B  -(A4),-$77(A0,D0.W)
        DC.W    $141A               ; $01115C MOVE.B  (A2)+,D2
        DC.W    $0089,$146E,$0089   ; $01115E ORI.L  #$146E0089,A1
        DC.W    $1862               ; $011164 MOVEA.B -(A2),A4
        DC.W    $4EB9,$0088,$2080   ; $011166 JSR     $00882080
        DC.W    $3038,$C87E         ; $01116C MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $011170 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $011174 JMP     (A1)
        DC.W    $0089,$11A4,$0089   ; $011176 ORI.L  #$11A40089,A1
        DC.W    $11A4,$0089         ; $01117C MOVE.B  -(A4),-$77(A0,D0.W)
        DC.W    $11B6,$0089,$11B6   ; $011180 MOVE.B  -$77(A6,D0.W),-$4A(A0,D1.W)
        DC.W    $0089,$15A8,$0089   ; $011186 ORI.L  #$15A80089,A1
        DC.W    $1630,$0089         ; $01118C MOVE.B  -$77(A0,D0.W),D3
        DC.W    $188A               ; $011190 MOVE.B  A2,(A4)
        DC.W    $4EBA,$A4F0         ; $011192 JSR     $00B684(PC)
        DC.W    $0838,$0006,$C80E   ; $011196 BTST    #6,$C80E.W
        DC.W    $6604               ; $01119C BNE.S  loc_0111A2
        DC.W    $5878,$C87E         ; $01119E ADDQ.W  #4,$C87E.W
loc_0111A2:
        DC.W    $4E75               ; $0111A2 RTS
        DC.W    $4EBA,$0962         ; $0111A4 JSR     loc_011B08(PC)
        DC.W    $5878,$C87E         ; $0111A8 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0018,$00FF,$0008; $0111AC MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $0111B4 RTS
        DC.W    $207C,$0601,$8F80   ; $0111B6 MOVEA.L #$06018F80,A0
        DC.W    $227C,$0400,$D018   ; $0111BC MOVEA.L #$0400D018,A1
        DC.W    $303C,$0078         ; $0111C2 MOVE.W  #$0078,D0
        DC.W    $323C,$0018         ; $0111C6 MOVE.W  #$0018,D1
        DC.W    $4EBA,$D18E         ; $0111CA JSR     $00E35A(PC)
        DC.W    $207C,$0601,$9AC0   ; $0111CE MOVEA.L #$06019AC0,A0
        DC.W    $227C,$0400,$D0A0   ; $0111D4 MOVEA.L #$0400D0A0,A1
        DC.W    $303C,$0078         ; $0111DA MOVE.W  #$0078,D0
        DC.W    $323C,$0018         ; $0111DE MOVE.W  #$0018,D1
        DC.W    $4EBA,$D176         ; $0111E2 JSR     $00E35A(PC)
        DC.W    $43F9,$0403,$B048   ; $0111E6 LEA     $0403B048,A1
        DC.W    $45F8,$A046         ; $0111EC LEA     $A046.W,A2
        DC.W    $4EBA,$06E2         ; $0111F0 JSR     loc_0118D4(PC)
        DC.W    $43F9,$0403,$B0D0   ; $0111F4 LEA     $0403B0D0,A1
        DC.W    $45F8,$A04A         ; $0111FA LEA     $A04A.W,A2
        DC.W    $4EBA,$06D4         ; $0111FE JSR     loc_0118D4(PC)
        DC.W    $207C,$0601,$8C00   ; $011202 MOVEA.L #$06018C00,A0
        DC.W    $227C,$0401,$B010   ; $011208 MOVEA.L #$0401B010,A1
        DC.W    $303C,$0038         ; $01120E MOVE.W  #$0038,D0
        DC.W    $323C,$0010         ; $011212 MOVE.W  #$0010,D1
        DC.W    $4EBA,$D142         ; $011216 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$8C00   ; $01121A MOVEA.L #$06018C00,A0
        DC.W    $227C,$0401,$B098   ; $011220 MOVEA.L #$0401B098,A1
        DC.W    $303C,$0038         ; $011226 MOVE.W  #$0038,D0
        DC.W    $323C,$0010         ; $01122A MOVE.W  #$0010,D1
        DC.W    $4EBA,$D12A         ; $01122E JSR     $00E35A(PC)
        DC.W    $5878,$C87E         ; $011232 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0018,$00FF,$0008; $011236 MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $01123E RTS
        DC.W    $4240               ; $011240 CLR.W  D0
        DC.W    $4EBA,$D2E8         ; $011242 JSR     $00E52C(PC)
        DC.W    $4EBA,$A43C         ; $011246 JSR     $00B684(PC)
        DC.W    $4EBA,$A48E         ; $01124A JSR     $00B6DA(PC)
        DC.W    $207C,$0601,$8F80   ; $01124E MOVEA.L #$06018F80,A0
        DC.W    $227C,$0400,$E038   ; $011254 MOVEA.L #$0400E038,A1
        DC.W    $303C,$00D8         ; $01125A MOVE.W  #$00D8,D0
        DC.W    $323C,$0010         ; $01125E MOVE.W  #$0010,D1
        DC.W    $4EBA,$D0F6         ; $011262 JSR     $00E35A(PC)
        DC.W    $207C,$0602,$8000   ; $011266 MOVEA.L #$06028000,A0
        DC.W    $227C,$0401,$0038   ; $01126C MOVEA.L #$04010038,A1
        DC.W    $303C,$00D8         ; $011272 MOVE.W  #$00D8,D0
        DC.W    $323C,$0050         ; $011276 MOVE.W  #$0050,D1
        DC.W    $4EBA,$D0DE         ; $01127A JSR     $00E35A(PC)
        DC.W    $43F9,$0402,$C090   ; $01127E LEA     $0402C090,A1
        DC.W    $45F8,$A046         ; $011284 LEA     $A046.W,A2
        DC.W    $4EBA,$064A         ; $011288 JSR     loc_0118D4(PC)
        DC.W    $207C,$0601,$8C00   ; $01128C MOVEA.L #$06018C00,A0
        DC.W    $227C,$0400,$C048   ; $011292 MOVEA.L #$0400C048,A1
        DC.W    $303C,$0038         ; $011298 MOVE.W  #$0038,D0
        DC.W    $323C,$0010         ; $01129C MOVE.W  #$0010,D1
        DC.W    $4EBA,$D0B8         ; $0112A0 JSR     $00E35A(PC)
        DC.W    $4A78,$A042         ; $0112A4 TST.W  $A042.W
        DC.W    $6600,$004A         ; $0112A8 BNE.W  loc_0112F4
        DC.W    $207C,$0601,$A200   ; $0112AC MOVEA.L #$0601A200,A0
        DC.W    $227C,$0401,$B030   ; $0112B2 MOVEA.L #$0401B030,A1
        DC.W    $303C,$0080         ; $0112B8 MOVE.W  #$0080,D0
        DC.W    $323C,$0010         ; $0112BC MOVE.W  #$0010,D1
        DC.W    $4EBA,$D098         ; $0112C0 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$AA00   ; $0112C4 MOVEA.L #$0601AA00,A0
        DC.W    $227C,$0401,$B0D0   ; $0112CA MOVEA.L #$0401B0D0,A1
        DC.W    $303C,$0018         ; $0112D0 MOVE.W  #$0018,D0
        DC.W    $323C,$0010         ; $0112D4 MOVE.W  #$0010,D1
        DC.W    $4EBA,$D080         ; $0112D8 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$AB80   ; $0112DC MOVEA.L #$0601AB80,A0
        DC.W    $227C,$0401,$B100   ; $0112E2 MOVEA.L #$0401B100,A1
        DC.W    $303C,$0018         ; $0112E8 MOVE.W  #$0018,D0
        DC.W    $323C,$0010         ; $0112EC MOVE.W  #$0010,D1
        DC.W    $4EBA,$D068         ; $0112F0 JSR     $00E35A(PC)
loc_0112F4:
        DC.W    $0C78,$0001,$A05C   ; $0112F4 CMPI.W  #$0001,$A05C.W
        DC.W    $6700,$00E0         ; $0112FA BEQ.W  loc_0113DC
        DC.W    $0C78,$0002,$A05C   ; $0112FE CMPI.W  #$0002,$A05C.W
        DC.W    $6700,$00EC         ; $011304 BEQ.W  loc_0113F2
        DC.W    $4EB9,$0088,$179E   ; $011308 JSR     $0088179E
        DC.W    $3238,$C86C         ; $01130E MOVE.W  $C86C.W,D1
        DC.W    $3401               ; $011312 MOVE.W  D1,D2
        DC.W    $0202,$00E0         ; $011314 ANDI.B  #$00E0,D2
        DC.W    $672E               ; $011318 BEQ.S  loc_011348
        DC.W    $11FC,$00A8,$C8A4   ; $01131A MOVE.B  #$00A8,$C8A4.W
        DC.W    $11FC,$0001,$C809   ; $011320 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $011326 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $01132C BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $011332 MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $011338 JSR     $0088205E
        DC.W    $31FC,$0002,$A05C   ; $01133E MOVE.W  #$0002,$A05C.W
        DC.W    $6000,$00C6         ; $011344 BRA.W  loc_01140C
loc_011348:
        DC.W    $0801,$0004         ; $011348 BTST    #4,D1
        DC.W    $674E               ; $01134C BEQ.S  loc_01139C
        DC.W    $4A38,$A019         ; $01134E TST.B  $A019.W
        DC.W    $6600,$001A         ; $011352 BNE.W  loc_01136E
        DC.W    $4A78,$A042         ; $011356 TST.W  $A042.W
        DC.W    $6600,$0012         ; $01135A BNE.W  loc_01136E
        DC.W    $11FC,$00A9,$C8A4   ; $01135E MOVE.B  #$00A9,$C8A4.W
        DC.W    $11FC,$0001,$A019   ; $011364 MOVE.B  #$0001,$A019.W
        DC.W    $6000,$00A0         ; $01136A BRA.W  loc_01140C
loc_01136E:
        DC.W    $11FC,$00A8,$C8A4   ; $01136E MOVE.B  #$00A8,$C8A4.W
        DC.W    $11FC,$0001,$C809   ; $011374 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $01137A MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $011380 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $011386 MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $01138C JSR     $0088205E
        DC.W    $31FC,$0002,$A05C   ; $011392 MOVE.W  #$0002,$A05C.W
        DC.W    $6000,$0072         ; $011398 BRA.W  loc_01140C
loc_01139C:
        DC.W    $4A78,$A042         ; $01139C TST.W  $A042.W
        DC.W    $666A               ; $0113A0 BNE.S  loc_01140C
        DC.W    $0801,$0002         ; $0113A2 BTST    #2,D1
        DC.W    $6716               ; $0113A6 BEQ.S  loc_0113BE
        DC.W    $4A38,$A019         ; $0113A8 TST.B  $A019.W
        DC.W    $6700,$005E         ; $0113AC BEQ.W  loc_01140C
        DC.W    $11FC,$00A9,$C8A4   ; $0113B0 MOVE.B  #$00A9,$C8A4.W
        DC.W    $4238,$A019         ; $0113B6 CLR.B  $A019.W
        DC.W    $6000,$0050         ; $0113BA BRA.W  loc_01140C
loc_0113BE:
        DC.W    $0801,$0003         ; $0113BE BTST    #3,D1
        DC.W    $6748               ; $0113C2 BEQ.S  loc_01140C
        DC.W    $4A38,$A019         ; $0113C4 TST.B  $A019.W
        DC.W    $6600,$0042         ; $0113C8 BNE.W  loc_01140C
        DC.W    $11FC,$00A9,$C8A4   ; $0113CC MOVE.B  #$00A9,$C8A4.W
        DC.W    $11FC,$0001,$A019   ; $0113D2 MOVE.B  #$0001,$A019.W
        DC.W    $6000,$0032         ; $0113D8 BRA.W  loc_01140C
loc_0113DC:
        DC.W    $4EB9,$0088,$FB36   ; $0113DC JSR     $0088FB36
        DC.W    $0838,$0006,$C80E   ; $0113E2 BTST    #6,$C80E.W
        DC.W    $6622               ; $0113E8 BNE.S  loc_01140C
        DC.W    $4278,$A05C         ; $0113EA CLR.W  $A05C.W
        DC.W    $6000,$001C         ; $0113EE BRA.W  loc_01140C
loc_0113F2:
        DC.W    $4EB9,$0088,$FB36   ; $0113F2 JSR     $0088FB36
        DC.W    $0838,$0007,$C80E   ; $0113F8 BTST    #7,$C80E.W
        DC.W    $660C               ; $0113FE BNE.S  loc_01140C
        DC.W    $4278,$A05C         ; $011400 CLR.W  $A05C.W
        DC.W    $5878,$C87E         ; $011404 ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $011408 BRA.W  loc_011410
loc_01140C:
        DC.W    $6100,$05AA         ; $01140C BSR.W  loc_0119B8
loc_011410:
        DC.W    $33FC,$0018,$00FF,$0008; $011410 MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $011418 RTS
        DC.W    $4240               ; $01141A CLR.W  D0
        DC.W    $4EBA,$D10E         ; $01141C JSR     $00E52C(PC)
loc_011420:
        DC.W    $4A39,$00A1,$5120   ; $011420 TST.B  $00A15120
        DC.W    $66F8               ; $011426 BNE.S  loc_011420
        DC.W    $33FC,$0101,$00A1,$512C; $011428 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$8000,$00A1,$5128; $011430 MOVE.W  #$8000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $011438 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $011440 MOVE.B  #$0001,$00A15120
loc_011448:
        DC.W    $4A39,$00A1,$512C   ; $011448 TST.B  $00A1512C
        DC.W    $66F8               ; $01144E BNE.S  loc_011448
        DC.W    $33FC,$0050,$00A1,$5128; $011450 MOVE.W  #$0050,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $011458 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$0020,$00FF,$0008; $011460 MOVE.W  #$0020,$00FF0008
        DC.W    $5878,$C87E         ; $011468 ADDQ.W  #4,$C87E.W
        DC.W    $4E75               ; $01146C RTS
        DC.W    $4240               ; $01146E CLR.W  D0
        DC.W    $4EBA,$D0BA         ; $011470 JSR     $00E52C(PC)
        DC.W    $4EBA,$A20E         ; $011474 JSR     $00B684(PC)
        DC.W    $4EBA,$A260         ; $011478 JSR     $00B6DA(PC)
        DC.W    $207C,$0601,$8F80   ; $01147C MOVEA.L #$06018F80,A0
        DC.W    $227C,$0400,$E038   ; $011482 MOVEA.L #$0400E038,A1
        DC.W    $303C,$00D8         ; $011488 MOVE.W  #$00D8,D0
        DC.W    $323C,$0010         ; $01148C MOVE.W  #$0010,D1
        DC.W    $4EBA,$CEC8         ; $011490 JSR     $00E35A(PC)
        DC.W    $207C,$2602,$8000   ; $011494 MOVEA.L #$26028000,A0
        DC.W    $2038,$A022         ; $01149A MOVE.L  $A022.W,D0
        DC.W    $D1C0               ; $01149E ADDA.L  D0,A0
        DC.W    $227C,$2401,$0038   ; $0114A0 MOVEA.L #$24010038,A1
        DC.W    $303C,$00D8         ; $0114A6 MOVE.W  #$00D8,D0
        DC.W    $323C,$0050         ; $0114AA MOVE.W  #$0050,D1
        DC.W    $4EBA,$CEAA         ; $0114AE JSR     $00E35A(PC)
        DC.W    $4AB8,$A026         ; $0114B2 TST.L  $A026.W
        DC.W    $6700,$001C         ; $0114B6 BEQ.W  loc_0114D4
        DC.W    $2038,$A022         ; $0114BA MOVE.L  $A022.W,D0
        DC.W    $2238,$A026         ; $0114BE MOVE.L  $A026.W,D1
        DC.W    $D081               ; $0114C2 ADD.L  D1,D0
        DC.W    $21C0,$A022         ; $0114C4 MOVE.L  D0,$A022.W
        DC.W    $5338,$A02E         ; $0114C8 SUBQ.B  #1,$A02E.W
        DC.W    $6400,$00CC         ; $0114CC BCC.W  loc_01159A
        DC.W    $42B8,$A026         ; $0114D0 CLR.L  $A026.W
loc_0114D4:
        DC.W    $0C78,$0001,$A05C   ; $0114D4 CMPI.W  #$0001,$A05C.W
        DC.W    $6700,$008E         ; $0114DA BEQ.W  loc_01156A
        DC.W    $0C78,$0002,$A05C   ; $0114DE CMPI.W  #$0002,$A05C.W
        DC.W    $6700,$009A         ; $0114E4 BEQ.W  loc_011580
        DC.W    $4EB9,$0088,$179E   ; $0114E8 JSR     $0088179E
        DC.W    $3238,$C86C         ; $0114EE MOVE.W  $C86C.W,D1
        DC.W    $3401               ; $0114F2 MOVE.W  D1,D2
        DC.W    $0202,$00F0         ; $0114F4 ANDI.B  #$00F0,D2
        DC.W    $672E               ; $0114F8 BEQ.S  loc_011528
        DC.W    $11FC,$00A8,$C8A4   ; $0114FA MOVE.B  #$00A8,$C8A4.W
        DC.W    $31FC,$0002,$A05C   ; $011500 MOVE.W  #$0002,$A05C.W
        DC.W    $11FC,$0001,$C809   ; $011506 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $01150C MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $011512 BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $011518 MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $01151E JSR     $0088205E
        DC.W    $6000,$0078         ; $011524 BRA.W  loc_01159E
loc_011528:
        DC.W    $E049               ; $011528 LSR.W  #8,D1
        DC.W    $0801,$0000         ; $01152A BTST    #0,D1
        DC.W    $671A               ; $01152E BEQ.S  loc_01154A
        DC.W    $4AB8,$A022         ; $011530 TST.L  $A022.W
        DC.W    $6F00,$0064         ; $011534 BLE.W  loc_01159A
        DC.W    $21FC,$FFFF,$FE50,$A026; $011538 MOVE.L  #$FFFFFE50,$A026.W
        DC.W    $11FC,$0007,$A02E   ; $011540 MOVE.B  #$0007,$A02E.W
        DC.W    $6000,$0052         ; $011546 BRA.W  loc_01159A
loc_01154A:
        DC.W    $0801,$0001         ; $01154A BTST    #1,D1
        DC.W    $674A               ; $01154E BEQ.S  loc_01159A
        DC.W    $2038,$A022         ; $011550 MOVE.L  $A022.W,D0
        DC.W    $B0B8,$A02A         ; $011554 CMP.L  $A02A.W,D0
        DC.W    $6C00,$0040         ; $011558 BGE.W  loc_01159A
        DC.W    $21FC,$0000,$01B0,$A026; $01155C MOVE.L  #$000001B0,$A026.W
        DC.W    $11FC,$0007,$A02E   ; $011564 MOVE.B  #$0007,$A02E.W
loc_01156A:
        DC.W    $4EB9,$0088,$FB36   ; $01156A JSR     $0088FB36
        DC.W    $0838,$0006,$C80E   ; $011570 BTST    #6,$C80E.W
        DC.W    $6622               ; $011576 BNE.S  loc_01159A
        DC.W    $4278,$A05C         ; $011578 CLR.W  $A05C.W
        DC.W    $6000,$001C         ; $01157C BRA.W  loc_01159A
loc_011580:
        DC.W    $4EB9,$0088,$FB36   ; $011580 JSR     $0088FB36
        DC.W    $0838,$0007,$C80E   ; $011586 BTST    #7,$C80E.W
        DC.W    $660C               ; $01158C BNE.S  loc_01159A
        DC.W    $4278,$A05C         ; $01158E CLR.W  $A05C.W
        DC.W    $5878,$C87E         ; $011592 ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $011596 BRA.W  loc_01159E
loc_01159A:
        DC.W    $5978,$C87E         ; $01159A SUBQ.W  #4,$C87E.W
loc_01159E:
        DC.W    $33FC,$0018,$00FF,$0008; $01159E MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $0115A6 RTS
        DC.W    $4240               ; $0115A8 CLR.W  D0
        DC.W    $4EBA,$CF80         ; $0115AA JSR     $00E52C(PC)
loc_0115AE:
        DC.W    $4A39,$00A1,$5120   ; $0115AE TST.B  $00A15120
        DC.W    $66F8               ; $0115B4 BNE.S  loc_0115AE
        DC.W    $33FC,$0101,$00A1,$512C; $0115B6 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$8000,$00A1,$5128; $0115BE MOVE.W  #$8000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $0115C6 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $0115CE MOVE.B  #$0001,$00A15120
loc_0115D6:
        DC.W    $4A39,$00A1,$512C   ; $0115D6 TST.B  $00A1512C
        DC.W    $66F8               ; $0115DC BNE.S  loc_0115D6
        DC.W    $33FC,$0050,$00A1,$5128; $0115DE MOVE.W  #$0050,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $0115E6 MOVE.W  #$0101,$00A1512C
        DC.W    $207C,$2602,$8000   ; $0115EE MOVEA.L #$26028000,A0
        DC.W    $2038,$A022         ; $0115F4 MOVE.L  $A022.W,D0
        DC.W    $D1C0               ; $0115F8 ADDA.L  D0,A0
        DC.W    $227C,$2401,$0018   ; $0115FA MOVEA.L #$24010018,A1
        DC.W    $303C,$0080         ; $011600 MOVE.W  #$0080,D0
        DC.W    $323C,$0050         ; $011604 MOVE.W  #$0050,D1
        DC.W    $4EBA,$CD50         ; $011608 JSR     $00E35A(PC)
        DC.W    $5378,$A052         ; $01160C SUBQ.W  #1,$A052.W
        DC.W    $640C               ; $011610 BCC.S  loc_01161E
        DC.W    $31FC,$0010,$A052   ; $011612 MOVE.W  #$0010,$A052.W
        DC.W    $0878,$0000,$A050   ; $011618 BCHG    #0,$A050.W
loc_01161E:
        DC.W    $6100,$065E         ; $01161E BSR.W  loc_011C7E
        DC.W    $33FC,$0020,$00FF,$0008; $011622 MOVE.W  #$0020,$00FF0008
        DC.W    $5878,$C87E         ; $01162A ADDQ.W  #4,$C87E.W
        DC.W    $4E75               ; $01162E RTS
        DC.W    $4240               ; $011630 CLR.W  D0
        DC.W    $4EBA,$CEF8         ; $011632 JSR     $00E52C(PC)
        DC.W    $4EBA,$A04C         ; $011636 JSR     $00B684(PC)
        DC.W    $4EBA,$A09E         ; $01163A JSR     $00B6DA(PC)
        DC.W    $207C,$2603,$2000   ; $01163E MOVEA.L #$26032000,A0
        DC.W    $2038,$A032         ; $011644 MOVE.L  $A032.W,D0
        DC.W    $D1C0               ; $011648 ADDA.L  D0,A0
        DC.W    $227C,$2401,$00A0   ; $01164A MOVEA.L #$240100A0,A1
        DC.W    $303C,$0080         ; $011650 MOVE.W  #$0080,D0
        DC.W    $323C,$0050         ; $011654 MOVE.W  #$0050,D1
        DC.W    $4EBA,$CD00         ; $011658 JSR     $00E35A(PC)
        DC.W    $4AB8,$A026         ; $01165C TST.L  $A026.W
        DC.W    $6700,$001C         ; $011660 BEQ.W  loc_01167E
        DC.W    $2038,$A022         ; $011664 MOVE.L  $A022.W,D0
        DC.W    $2238,$A026         ; $011668 MOVE.L  $A026.W,D1
        DC.W    $D081               ; $01166C ADD.L  D1,D0
        DC.W    $21C0,$A022         ; $01166E MOVE.L  D0,$A022.W
        DC.W    $5338,$A02E         ; $011672 SUBQ.B  #1,$A02E.W
        DC.W    $6400,$009C         ; $011676 BCC.W  loc_011714
        DC.W    $42B8,$A026         ; $01167A CLR.L  $A026.W
loc_01167E:
        DC.W    $0C78,$0001,$A05C   ; $01167E CMPI.W  #$0001,$A05C.W
        DC.W    $6700,$0130         ; $011684 BEQ.W  loc_0117B6
        DC.W    $0C78,$0002,$A05C   ; $011688 CMPI.W  #$0002,$A05C.W
        DC.W    $6700,$013C         ; $01168E BEQ.W  loc_0117CC
        DC.W    $4EB9,$0088,$179E   ; $011692 JSR     $0088179E
        DC.W    $3238,$C86C         ; $011698 MOVE.W  $C86C.W,D1
        DC.W    $3401               ; $01169C MOVE.W  D1,D2
        DC.W    $0202,$00F0         ; $01169E ANDI.B  #$00F0,D2
        DC.W    $672E               ; $0116A2 BEQ.S  loc_0116D2
        DC.W    $11FC,$00A8,$C8A4   ; $0116A4 MOVE.B  #$00A8,$C8A4.W
        DC.W    $31FC,$0002,$A05C   ; $0116AA MOVE.W  #$0002,$A05C.W
        DC.W    $11FC,$0001,$C809   ; $0116B0 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $0116B6 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $0116BC BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $0116C2 MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $0116C8 JSR     $0088205E
        DC.W    $6000,$0116         ; $0116CE BRA.W  loc_0117E6
loc_0116D2:
        DC.W    $E049               ; $0116D2 LSR.W  #8,D1
        DC.W    $0801,$0000         ; $0116D4 BTST    #0,D1
        DC.W    $671A               ; $0116D8 BEQ.S  loc_0116F4
        DC.W    $4AB8,$A022         ; $0116DA TST.L  $A022.W
        DC.W    $6F00,$0034         ; $0116DE BLE.W  loc_011714
        DC.W    $21FC,$FFFF,$FE00,$A026; $0116E2 MOVE.L  #$FFFFFE00,$A026.W
        DC.W    $11FC,$0003,$A02E   ; $0116EA MOVE.B  #$0003,$A02E.W
        DC.W    $6000,$0022         ; $0116F0 BRA.W  loc_011714
loc_0116F4:
        DC.W    $0801,$0001         ; $0116F4 BTST    #1,D1
        DC.W    $671A               ; $0116F8 BEQ.S  loc_011714
        DC.W    $2038,$A022         ; $0116FA MOVE.L  $A022.W,D0
        DC.W    $B0B8,$A02A         ; $0116FE CMP.L  $A02A.W,D0
        DC.W    $6C00,$0010         ; $011702 BGE.W  loc_011714
        DC.W    $21FC,$0000,$0200,$A026; $011706 MOVE.L  #$00000200,$A026.W
        DC.W    $11FC,$0003,$A02E   ; $01170E MOVE.B  #$0003,$A02E.W
loc_011714:
        DC.W    $4AB8,$A036         ; $011714 TST.L  $A036.W
        DC.W    $6700,$001C         ; $011718 BEQ.W  loc_011736
        DC.W    $2038,$A032         ; $01171C MOVE.L  $A032.W,D0
        DC.W    $2238,$A036         ; $011720 MOVE.L  $A036.W,D1
        DC.W    $D081               ; $011724 ADD.L  D1,D0
        DC.W    $21C0,$A032         ; $011726 MOVE.L  D0,$A032.W
        DC.W    $5338,$A03E         ; $01172A SUBQ.B  #1,$A03E.W
        DC.W    $6400,$00B6         ; $01172E BCC.W  loc_0117E6
        DC.W    $42B8,$A036         ; $011732 CLR.L  $A036.W
loc_011736:
        DC.W    $3238,$C86E         ; $011736 MOVE.W  $C86E.W,D1
        DC.W    $3401               ; $01173A MOVE.W  D1,D2
        DC.W    $0202,$00F0         ; $01173C ANDI.B  #$00F0,D2
        DC.W    $672E               ; $011740 BEQ.S  loc_011770
        DC.W    $11FC,$00A8,$C8A4   ; $011742 MOVE.B  #$00A8,$C8A4.W
        DC.W    $31FC,$0002,$A05C   ; $011748 MOVE.W  #$0002,$A05C.W
        DC.W    $11FC,$0001,$C809   ; $01174E MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $011754 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $01175A BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $011760 MOVE.B  #$0001,$C802.W
        DC.W    $4EB9,$0088,$205E   ; $011766 JSR     $0088205E
        DC.W    $6000,$0078         ; $01176C BRA.W  loc_0117E6
loc_011770:
        DC.W    $E049               ; $011770 LSR.W  #8,D1
        DC.W    $0801,$0000         ; $011772 BTST    #0,D1
        DC.W    $671A               ; $011776 BEQ.S  loc_011792
        DC.W    $4AB8,$A032         ; $011778 TST.L  $A032.W
        DC.W    $6F00,$0068         ; $01177C BLE.W  loc_0117E6
        DC.W    $21FC,$FFFF,$FE00,$A036; $011780 MOVE.L  #$FFFFFE00,$A036.W
        DC.W    $11FC,$0003,$A03E   ; $011788 MOVE.B  #$0003,$A03E.W
        DC.W    $6000,$0056         ; $01178E BRA.W  loc_0117E6
loc_011792:
        DC.W    $0801,$0001         ; $011792 BTST    #1,D1
        DC.W    $674E               ; $011796 BEQ.S  loc_0117E6
        DC.W    $2038,$A032         ; $011798 MOVE.L  $A032.W,D0
        DC.W    $B0B8,$A03A         ; $01179C CMP.L  $A03A.W,D0
        DC.W    $6C00,$0044         ; $0117A0 BGE.W  loc_0117E6
        DC.W    $21FC,$0000,$0200,$A036; $0117A4 MOVE.L  #$00000200,$A036.W
        DC.W    $11FC,$0003,$A03E   ; $0117AC MOVE.B  #$0003,$A03E.W
        DC.W    $6000,$0032         ; $0117B2 BRA.W  loc_0117E6
loc_0117B6:
        DC.W    $4EB9,$0088,$FB36   ; $0117B6 JSR     $0088FB36
        DC.W    $0838,$0006,$C80E   ; $0117BC BTST    #6,$C80E.W
        DC.W    $6622               ; $0117C2 BNE.S  loc_0117E6
        DC.W    $4278,$A05C         ; $0117C4 CLR.W  $A05C.W
        DC.W    $6000,$001C         ; $0117C8 BRA.W  loc_0117E6
loc_0117CC:
        DC.W    $4EB9,$0088,$FB36   ; $0117CC JSR     $0088FB36
        DC.W    $0838,$0007,$C80E   ; $0117D2 BTST    #7,$C80E.W
        DC.W    $660C               ; $0117D8 BNE.S  loc_0117E6
        DC.W    $4278,$A05C         ; $0117DA CLR.W  $A05C.W
        DC.W    $5878,$C87E         ; $0117DE ADDQ.W  #4,$C87E.W
        DC.W    $6000,$0006         ; $0117E2 BRA.W  loc_0117EA
loc_0117E6:
        DC.W    $5978,$C87E         ; $0117E6 SUBQ.W  #4,$C87E.W
loc_0117EA:
        DC.W    $33FC,$0018,$00FF,$0008; $0117EA MOVE.W  #$0018,$00FF0008
        DC.W    $4E75               ; $0117F2 RTS
loc_0117F4:
        DC.W    $4A39,$00A1,$5120   ; $0117F4 TST.B  $00A15120
        DC.W    $66F8               ; $0117FA BNE.S  loc_0117F4
        DC.W    $4239,$00A1,$5123   ; $0117FC CLR.B  $00A15123
        DC.W    $31FC,$0000,$C87E   ; $011802 MOVE.W  #$0000,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $011808 MOVE.W  #$0020,$00FF0008
        DC.W    $4A38,$A019         ; $011810 TST.B  $A019.W
        DC.W    $661A               ; $011814 BNE.S  loc_011830
        DC.W    $4A78,$A042         ; $011816 TST.W  $A042.W
        DC.W    $6614               ; $01181A BNE.S  loc_011830
        DC.W    $08F8,$0003,$C80E   ; $01181C BSET    #3,$C80E.W
        DC.W    $23FC,$0088,$4A3E,$00FF,$0002; $011822 MOVE.L  #$00884A3E,$00FF0002
        DC.W    $6000,$0032         ; $01182C BRA.W  loc_011860
loc_011830:
        DC.W    $08B8,$0003,$C80E   ; $011830 BCLR    #3,$C80E.W
        DC.W    $08B8,$0007,$C81C   ; $011836 BCLR    #7,$C81C.W
        DC.W    $0838,$0007,$FEB7   ; $01183C BTST    #7,$FEB7.W
        DC.W    $6712               ; $011842 BEQ.S  loc_011856
        DC.W    $08F8,$0007,$C81C   ; $011844 BSET    #7,$C81C.W
        DC.W    $23FC,$0088,$C0F0,$00FF,$0002; $01184A MOVE.L  #$0088C0F0,$00FF0002
        DC.W    $600A               ; $011854 BRA.S  loc_011860
loc_011856:
        DC.W    $23FC,$0088,$D48A,$00FF,$0002; $011856 MOVE.L  #$0088D48A,$00FF0002
loc_011860:
        DC.W    $4E75               ; $011860 RTS
loc_011862:
        DC.W    $4A39,$00A1,$5120   ; $011862 TST.B  $00A15120
        DC.W    $66F8               ; $011868 BNE.S  loc_011862
        DC.W    $4239,$00A1,$5123   ; $01186A CLR.B  $00A15123
        DC.W    $31FC,$0000,$C87E   ; $011870 MOVE.W  #$0000,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $011876 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0088,$D4A4,$00FF,$0002; $01187E MOVE.L  #$0088D4A4,$00FF0002
        DC.W    $4E75               ; $011888 RTS
        DC.W    $41F9,$00FF,$6E00   ; $01188A LEA     $00FF6E00,A0
        DC.W    $303C,$007F         ; $011890 MOVE.W  #$007F,D0
loc_011894:
        DC.W    $4298               ; $011894 CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $011896 DBRA    D0,loc_011894
        DC.W    $11FC,$0001,$C821   ; $01189A MOVE.B  #$0001,$C821.W
        DC.W    $4EBA,$9E38         ; $0118A0 JSR     $00B6DA(PC)
        DC.W    $0838,$0007,$C80E   ; $0118A4 BTST    #7,$C80E.W
        DC.W    $6626               ; $0118AA BNE.S  loc_0118D2
loc_0118AC:
        DC.W    $4A39,$00A1,$5120   ; $0118AC TST.B  $00A15120
        DC.W    $66F8               ; $0118B2 BNE.S  loc_0118AC
        DC.W    $4239,$00A1,$5123   ; $0118B4 CLR.B  $00A15123
        DC.W    $31FC,$0000,$C87E   ; $0118BA MOVE.W  #$0000,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $0118C0 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0088,$D4B8,$00FF,$0002; $0118C8 MOVE.L  #$0088D4B8,$00FF0002
loc_0118D2:
        DC.W    $4E75               ; $0118D2 RTS
loc_0118D4:
        DC.W    $161A               ; $0118D4 MOVE.B  (A2)+,D3
        DC.W    $6100,$0030         ; $0118D6 BSR.W  loc_011908
        DC.W    $323C,$000A         ; $0118DA MOVE.W  #$000A,D1
        DC.W    $6100,$0044         ; $0118DE BSR.W  loc_011924
        DC.W    $5089               ; $0118E2 ADDQ.L  #8,A1
        DC.W    $161A               ; $0118E4 MOVE.B  (A2)+,D3
        DC.W    $6100,$0020         ; $0118E6 BSR.W  loc_011908
        DC.W    $323C,$000B         ; $0118EA MOVE.W  #$000B,D1
        DC.W    $6100,$0034         ; $0118EE BSR.W  loc_011924
        DC.W    $5089               ; $0118F2 ADDQ.L  #8,A1
        DC.W    $121A               ; $0118F4 MOVE.B  (A2)+,D1
        DC.W    $0241,$000F         ; $0118F6 ANDI.W  #$000F,D1
        DC.W    $6100,$0028         ; $0118FA BSR.W  loc_011924
        DC.W    $5089               ; $0118FE ADDQ.L  #8,A1
        DC.W    $161A               ; $011900 MOVE.B  (A2)+,D3
        DC.W    $6100,$0004         ; $011902 BSR.W  loc_011908
        DC.W    $4E75               ; $011906 RTS
loc_011908:
        DC.W    $1203               ; $011908 MOVE.B  D3,D1
        DC.W    $E809               ; $01190A LSR.B  #4,D1
        DC.W    $0241,$000F         ; $01190C ANDI.W  #$000F,D1
        DC.W    $6100,$0012         ; $011910 BSR.W  loc_011924
        DC.W    $5089               ; $011914 ADDQ.L  #8,A1
        DC.W    $3203               ; $011916 MOVE.W  D3,D1
        DC.W    $0241,$000F         ; $011918 ANDI.W  #$000F,D1
        DC.W    $6100,$0006         ; $01191C BSR.W  loc_011924
        DC.W    $5089               ; $011920 ADDQ.L  #8,A1
        DC.W    $4E75               ; $011922 RTS
loc_011924:
        DC.W    $ED49               ; $011924 LSL.W  #6,D1
        DC.W    $3001               ; $011926 MOVE.W  D1,D0
        DC.W    $E349               ; $011928 LSL.W  #1,D1
        DC.W    $D240               ; $01192A ADD.W  D0,D1
        DC.W    $207C,$0601,$DF00   ; $01192C MOVEA.L #$0601DF00,A0
        DC.W    $D0C1               ; $011932 ADDA.W  D1,A0
        DC.W    $303C,$000C         ; $011934 MOVE.W  #$000C,D0
        DC.W    $323C,$0010         ; $011938 MOVE.W  #$0010,D1
        DC.W    $4EBA,$CA1C         ; $01193C JSR     $00E35A(PC)
        DC.W    $4E75               ; $011940 RTS
loc_011942:
        DC.W    $48E7,$1800         ; $011942 MOVEM.L -(A7),A3/A4
        DC.W    $161A               ; $011946 MOVE.B  (A2)+,D3
        DC.W    $6100,$0034         ; $011948 BSR.W  loc_01197E
        DC.W    $323C,$000A         ; $01194C MOVE.W  #$000A,D1
        DC.W    $6100,$0048         ; $011950 BSR.W  loc_01199A
        DC.W    $5089               ; $011954 ADDQ.L  #8,A1
        DC.W    $161A               ; $011956 MOVE.B  (A2)+,D3
        DC.W    $6100,$0024         ; $011958 BSR.W  loc_01197E
        DC.W    $323C,$000B         ; $01195C MOVE.W  #$000B,D1
        DC.W    $6100,$0038         ; $011960 BSR.W  loc_01199A
        DC.W    $5089               ; $011964 ADDQ.L  #8,A1
        DC.W    $121A               ; $011966 MOVE.B  (A2)+,D1
        DC.W    $0241,$000F         ; $011968 ANDI.W  #$000F,D1
        DC.W    $6100,$002C         ; $01196C BSR.W  loc_01199A
        DC.W    $5089               ; $011970 ADDQ.L  #8,A1
        DC.W    $161A               ; $011972 MOVE.B  (A2)+,D3
        DC.W    $6100,$0008         ; $011974 BSR.W  loc_01197E
        DC.W    $4CDF,$0018         ; $011978 MOVEM.L D3/D4,(A7)+
        DC.W    $4E75               ; $01197C RTS
loc_01197E:
        DC.W    $1203               ; $01197E MOVE.B  D3,D1
        DC.W    $E809               ; $011980 LSR.B  #4,D1
        DC.W    $0241,$000F         ; $011982 ANDI.W  #$000F,D1
        DC.W    $6100,$0012         ; $011986 BSR.W  loc_01199A
        DC.W    $5089               ; $01198A ADDQ.L  #8,A1
        DC.W    $3203               ; $01198C MOVE.W  D3,D1
        DC.W    $0241,$000F         ; $01198E ANDI.W  #$000F,D1
        DC.W    $6100,$0006         ; $011992 BSR.W  loc_01199A
        DC.W    $5089               ; $011996 ADDQ.L  #8,A1
        DC.W    $4E75               ; $011998 RTS
loc_01199A:
        DC.W    $ED49               ; $01199A LSL.W  #6,D1
        DC.W    $3001               ; $01199C MOVE.W  D1,D0
        DC.W    $E349               ; $01199E LSL.W  #1,D1
        DC.W    $D240               ; $0119A0 ADD.W  D0,D1
        DC.W    $207C,$0601,$DF00   ; $0119A2 MOVEA.L #$0601DF00,A0
        DC.W    $D0C1               ; $0119A8 ADDA.W  D1,A0
        DC.W    $303C,$000C         ; $0119AA MOVE.W  #$000C,D0
        DC.W    $323C,$0010         ; $0119AE MOVE.W  #$0010,D1
        DC.W    $4EBA,$00E4         ; $0119B2 JSR     loc_011A98(PC)
        DC.W    $4E75               ; $0119B6 RTS
loc_0119B8:
        DC.W    $41F9,$00FF,$6E00   ; $0119B8 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$01E0   ; $0119BE ADDA.L  #$000001E0,A0
        DC.W    $43F9,$0089,$1A70   ; $0119C4 LEA     $00891A70,A1
        DC.W    $303C,$0007         ; $0119CA MOVE.W  #$0007,D0
loc_0119CE:
        DC.W    $3219               ; $0119CE MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $0119D0 BSET    #15,D1
        DC.W    $30C1               ; $0119D4 MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $0119D6 DBRA    D0,loc_0119CE
        DC.W    $7000               ; $0119DA MOVEQ   #$00,D0
        DC.W    $1038,$A019         ; $0119DC MOVE.B  $A019.W,D0
        DC.W    $D080               ; $0119E0 ADD.L  D0,D0
        DC.W    $D080               ; $0119E2 ADD.L  D0,D0
        DC.W    $D080               ; $0119E4 ADD.L  D0,D0
        DC.W    $41F9,$00FF,$6E00   ; $0119E6 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$01E0   ; $0119EC ADDA.L  #$000001E0,A0
        DC.W    $D1C0               ; $0119F2 ADDA.L  D0,A0
        DC.W    $43F9,$0089,$1A80   ; $0119F4 LEA     $00891A80,A1
        DC.W    $7200               ; $0119FA MOVEQ   #$00,D1
        DC.W    $1238,$A01A         ; $0119FC MOVE.B  $A01A.W,D1
        DC.W    $343C,$0003         ; $011A00 MOVE.W  #$0003,D2
loc_011A04:
        DC.W    $3A19               ; $011A04 MOVE.W  (A1)+,D5
        DC.W    $6154               ; $011A06 BSR.S  loc_011A5C
        DC.W    $3605               ; $011A08 MOVE.W  D5,D3
        DC.W    $3A19               ; $011A0A MOVE.W  (A1)+,D5
        DC.W    $614E               ; $011A0C BSR.S  loc_011A5C
        DC.W    $3805               ; $011A0E MOVE.W  D5,D4
        DC.W    $3A19               ; $011A10 MOVE.W  (A1)+,D5
        DC.W    $6148               ; $011A12 BSR.S  loc_011A5C
        DC.W    $EB4C               ; $011A14 LSL.W  #5,D4
        DC.W    $E14D               ; $011A16 LSL.W  #8,D5
        DC.W    $E54D               ; $011A18 LSL.W  #2,D5
        DC.W    $8644               ; $011A1A OR.W   D4,D3
        DC.W    $8645               ; $011A1C OR.W   D5,D3
        DC.W    $08C3,$000F         ; $011A1E BSET    #15,D3
        DC.W    $30C3               ; $011A22 MOVE.W  D3,(A0)+
        DC.W    $51CA,$FFDE         ; $011A24 DBRA    D2,loc_011A04
        DC.W    $1038,$A01A         ; $011A28 MOVE.B  $A01A.W,D0
        DC.W    $1238,$A01C         ; $011A2C MOVE.B  $A01C.W,D1
        DC.W    $D001               ; $011A30 ADD.B  D1,D0
        DC.W    $0C00,$001F         ; $011A32 CMPI.B  #$001F,D0
        DC.W    $6F0A               ; $011A36 BLE.S  loc_011A42
        DC.W    $103C,$001F         ; $011A38 MOVE.B  #$001F,D0
        DC.W    $123C,$00FE         ; $011A3C MOVE.B  #$00FE,D1
        DC.W    $600A               ; $011A40 BRA.S  loc_011A4C
loc_011A42:
        DC.W    $4A00               ; $011A42 TST.B  D0
        DC.W    $6C06               ; $011A44 BGE.S  loc_011A4C
        DC.W    $4200               ; $011A46 CLR.B  D0
        DC.W    $123C,$0002         ; $011A48 MOVE.B  #$0002,D1
loc_011A4C:
        DC.W    $11C0,$A01A         ; $011A4C MOVE.B  D0,$A01A.W
        DC.W    $11C1,$A01C         ; $011A50 MOVE.B  D1,$A01C.W
        DC.W    $11FC,$0001,$C821   ; $011A54 MOVE.B  #$0001,$C821.W
        DC.W    $4E75               ; $011A5A RTS
loc_011A5C:
        DC.W    $DA41               ; $011A5C ADD.W  D1,D5
        DC.W    $0C45,$001F         ; $011A5E CMPI.W  #$001F,D5
        DC.W    $6F04               ; $011A62 BLE.S  loc_011A68
        DC.W    $3A3C,$001F         ; $011A64 MOVE.W  #$001F,D5
loc_011A68:
        DC.W    $4A45               ; $011A68 TST.W  D5
        DC.W    $6E02               ; $011A6A BGT.S  loc_011A6E
        DC.W    $4245               ; $011A6C CLR.W  D5
loc_011A6E:
        DC.W    $4E75               ; $011A6E RTS
        DC.W    $4400               ; $011A70 NEG.B  D0
        DC.W    $44A3               ; $011A72 NEG.L  -(A3)
        DC.W    $4946               ; $011A74 DC.W    $4946
        DC.W    $4DE9,$4400         ; $011A76 LEA     $4400(A1),A6
        DC.W    $44A3               ; $011A7A NEG.L  -(A3)
        DC.W    $4946               ; $011A7C DC.W    $4946
        DC.W    $4DE9,$0000         ; $011A7E LEA     $0000(A1),A6
        DC.W    $0000,$0011         ; $011A82 ORI.B  #$0011,D0
        DC.W    $0003,$0005         ; $011A86 ORI.B  #$0005,D3
        DC.W    $0011,$0006         ; $011A8A ORI.B  #$0006,(A1)
        DC.W    $000A,$0012         ; $011A8E ORI.B  #$0012,A2
        DC.W    $0008,$000F         ; $011A92 ORI.B  #$000F,A0
        DC.W    $0013,$4A39         ; $011A96 ORI.B  #$4A39,(A3)
        DC.W    $00A1,$5120,$66F8   ; $011A9A ORI.L  #$512066F8,-(A1)
        DC.W    $23C9,$00A1,$5128   ; $011AA0 MOVE.L  A1,$00A15128
        DC.W    $13FC,$0001,$00A1,$512C; $011AA6 MOVE.B  #$0001,$00A1512C
        DC.W    $13FC,$0020,$00A1,$5121; $011AAE MOVE.B  #$0020,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $011AB6 MOVE.B  #$0001,$00A15120
loc_011ABE:
        DC.W    $4A39,$00A1,$512C   ; $011ABE TST.B  $00A1512C
        DC.W    $66F8               ; $011AC4 BNE.S  loc_011ABE
        DC.W    $33C0,$00A1,$5128   ; $011AC6 MOVE.W  D0,$00A15128
        DC.W    $33C1,$00A1,$512A   ; $011ACC MOVE.W  D1,$00A1512A
        DC.W    $13FC,$0001,$00A1,$512C; $011AD2 MOVE.B  #$0001,$00A1512C
loc_011ADA:
        DC.W    $4A39,$00A1,$512C   ; $011ADA TST.B  $00A1512C
        DC.W    $66F8               ; $011AE0 BNE.S  loc_011ADA
        DC.W    $33C2,$00A1,$5128   ; $011AE2 MOVE.W  D2,$00A15128
        DC.W    $13FC,$0001,$00A1,$512C; $011AE8 MOVE.B  #$0001,$00A1512C
loc_011AF0:
        DC.W    $4A39,$00A1,$512C   ; $011AF0 TST.B  $00A1512C
        DC.W    $66F8               ; $011AF6 BNE.S  loc_011AF0
        DC.W    $23C8,$00A1,$5128   ; $011AF8 MOVE.L  A0,$00A15128
        DC.W    $13FC,$0001,$00A1,$512C; $011AFE MOVE.B  #$0001,$00A1512C
        DC.W    $4E75               ; $011B06 RTS
loc_011B08:
        DC.W    $207C,$0601,$8000   ; $011B08 MOVEA.L #$06018000,A0
        DC.W    $227C,$0400,$4C78   ; $011B0E MOVEA.L #$04004C78,A1
        DC.W    $303C,$0050         ; $011B14 MOVE.W  #$0050,D0
        DC.W    $323C,$0010         ; $011B18 MOVE.W  #$0010,D1
        DC.W    $4EBA,$C83C         ; $011B1C JSR     $00E35A(PC)
        DC.W    $207C,$0601,$E8C0   ; $011B20 MOVEA.L #$0601E8C0,A0
        DC.W    $227C,$0400,$8090   ; $011B26 MOVEA.L #$04008090,A1
        DC.W    $303C,$0058         ; $011B2C MOVE.W  #$0058,D0
        DC.W    $323C,$0010         ; $011B30 MOVE.W  #$0010,D1
        DC.W    $4EBA,$C824         ; $011B34 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$EE40   ; $011B38 MOVEA.L #$0601EE40,A0
        DC.W    $227C,$0400,$A090   ; $011B3E MOVEA.L #$0400A090,A1
        DC.W    $303C,$0058         ; $011B44 MOVE.W  #$0058,D0
        DC.W    $323C,$0010         ; $011B48 MOVE.W  #$0010,D1
        DC.W    $4EBA,$C80C         ; $011B4C JSR     $00E35A(PC)
        DC.W    $207C,$0601,$8500   ; $011B50 MOVEA.L #$06018500,A0
        DC.W    $227C,$0400,$8048   ; $011B56 MOVEA.L #$04008048,A1
        DC.W    $303C,$0038         ; $011B5C MOVE.W  #$0038,D0
        DC.W    $323C,$0020         ; $011B60 MOVE.W  #$0020,D1
        DC.W    $4EBA,$C7F4         ; $011B64 JSR     $00E35A(PC)
        DC.W    $4E75               ; $011B68 RTS
loc_011B6A:
        DC.W    $2038,$C260         ; $011B6A MOVE.L  $C260.W,D0
        DC.W    $21C0,$A058         ; $011B6E MOVE.L  D0,$A058.W
        DC.W    $43F8,$B400         ; $011B72 LEA     $B400.W,A1
        DC.W    $45F8,$C400         ; $011B76 LEA     $C400.W,A2
        DC.W    $7E1F               ; $011B7A MOVEQ   #$1F,D7
loc_011B7C:
        DC.W    $4CD9,$087F         ; $011B7C MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,(A1)+
        DC.W    $48E2,$FE10         ; $011B80 MOVEM.L -(A2),D4/A1/A2/A3/A4/A5/A6/A7
        DC.W    $51CF,$FFF6         ; $011B84 DBRA    D7,loc_011B7C
        DC.W    $42B8,$A04A         ; $011B88 CLR.L  $A04A.W
        DC.W    $41F8,$A04A         ; $011B8C LEA     $A04A.W,A0
        DC.W    $43F8,$C200         ; $011B90 LEA     $C200.W,A1
        DC.W    $343C,$0013         ; $011B94 MOVE.W  #$0013,D2
loc_011B98:
        DC.W    $0600,$0000         ; $011B98 ADDI.B  #$0000,D0
        DC.W    $1028,$0003         ; $011B9C MOVE.B  $0003(A0),D0
        DC.W    $1229,$0003         ; $011BA0 MOVE.B  $0003(A1),D1
        DC.W    $C101               ; $011BA4 AND.B  D0,D1
        DC.W    $1140,$0003         ; $011BA6 MOVE.B  D0,$0003(A0)
        DC.W    $1028,$0002         ; $011BAA MOVE.B  $0002(A0),D0
        DC.W    $1229,$0002         ; $011BAE MOVE.B  $0002(A1),D1
        DC.W    $C101               ; $011BB2 AND.B  D0,D1
        DC.W    $1200               ; $011BB4 MOVE.B  D0,D1
        DC.W    $0200,$000F         ; $011BB6 ANDI.B  #$000F,D0
        DC.W    $1140,$0002         ; $011BBA MOVE.B  D0,$0002(A0)
        DC.W    $E809               ; $011BBE LSR.B  #4,D1
        DC.W    $0600,$0000         ; $011BC0 ADDI.B  #$0000,D0
        DC.W    $1028,$0001         ; $011BC4 MOVE.B  $0001(A0),D0
        DC.W    $C101               ; $011BC8 AND.B  D0,D1
        DC.W    $1229,$0001         ; $011BCA MOVE.B  $0001(A1),D1
        DC.W    $C101               ; $011BCE AND.B  D0,D1
        DC.W    $6400,$0012         ; $011BD0 BCC.W  loc_011BE4
        DC.W    $0600,$0000         ; $011BD4 ADDI.B  #$0000,D0
        DC.W    $123C,$0040         ; $011BD8 MOVE.B  #$0040,D1
        DC.W    $C101               ; $011BDC AND.B  D0,D1
        DC.W    $123C,$0001         ; $011BDE MOVE.B  #$0001,D1
        DC.W    $6018               ; $011BE2 BRA.S  loc_011BFC
loc_011BE4:
        DC.W    $4201               ; $011BE4 CLR.B  D1
        DC.W    $0C00,$0060         ; $011BE6 CMPI.B  #$0060,D0
        DC.W    $6500,$0010         ; $011BEA BCS.W  loc_011BFC
        DC.W    $0600,$0000         ; $011BEE ADDI.B  #$0000,D0
        DC.W    $123C,$0060         ; $011BF2 MOVE.B  #$0060,D1
        DC.W    $8101               ; $011BF6 OR.B   D0,D1
        DC.W    $123C,$0001         ; $011BF8 MOVE.B  #$0001,D1
loc_011BFC:
        DC.W    $1140,$0001         ; $011BFC MOVE.B  D0,$0001(A0)
        DC.W    $0600,$0000         ; $011C00 ADDI.B  #$0000,D0
        DC.W    $1010               ; $011C04 MOVE.B  (A0),D0
        DC.W    $C101               ; $011C06 AND.B  D0,D1
        DC.W    $1211               ; $011C08 MOVE.B  (A1),D1
        DC.W    $C101               ; $011C0A AND.B  D0,D1
        DC.W    $1080               ; $011C0C MOVE.B  D0,(A0)
        DC.W    $5889               ; $011C0E ADDQ.L  #4,A1
        DC.W    $51CA,$FF86         ; $011C10 DBRA    D2,loc_011B98
        DC.W    $4AB8,$A04A         ; $011C14 TST.L  $A04A.W
        DC.W    $6608               ; $011C18 BNE.S  loc_011C22
        DC.W    $21FC,$CCCC,$0CCC,$A04A; $011C1A MOVE.L  #$CCCC0CCC,$A04A.W
loc_011C22:
        DC.W    $41F8,$C200         ; $011C22 LEA     $C200.W,A0
        DC.W    $303C,$0013         ; $011C26 MOVE.W  #$0013,D0
loc_011C2A:
        DC.W    $4A90               ; $011C2A TST.L  (A0)
        DC.W    $6700,$000A         ; $011C2C BEQ.W  loc_011C38
        DC.W    $5888               ; $011C30 ADDQ.L  #4,A0
        DC.W    $51C8,$FFF6         ; $011C32 DBRA    D0,loc_011C2A
        DC.W    $600A               ; $011C36 BRA.S  loc_011C42
loc_011C38:
        DC.W    $20FC,$CCCC,$0CCC   ; $011C38 MOVE.L  #$CCCC0CCC,(A0)+
        DC.W    $51C8,$FFF8         ; $011C3E DBRA    D0,loc_011C38
loc_011C42:
        DC.W    $31FC,$0002,$A04E   ; $011C42 MOVE.W  #$0002,$A04E.W
        DC.W    $2038,$A058         ; $011C48 MOVE.L  $A058.W,D0
        DC.W    $2238,$C260         ; $011C4C MOVE.L  $C260.W,D1
        DC.W    $B280               ; $011C50 CMP.L  D0,D1
        DC.W    $6700,$0028         ; $011C52 BEQ.W  loc_011C7C
        DC.W    $31FC,$0001,$A04E   ; $011C56 MOVE.W  #$0001,$A04E.W
        DC.W    $0C80,$CCCC,$0CCC   ; $011C5C CMPI.L  #$CCCC0CCC,D0
        DC.W    $6718               ; $011C62 BEQ.S  loc_011C7C
        DC.W    $4278,$A04E         ; $011C64 CLR.W  $A04E.W
        DC.W    $0C81,$CCCC,$0CCC   ; $011C68 CMPI.L  #$CCCC0CCC,D1
        DC.W    $670C               ; $011C6E BEQ.S  loc_011C7C
        DC.W    $B280               ; $011C70 CMP.L  D0,D1
        DC.W    $6200,$0008         ; $011C72 BHI.W  loc_011C7C
        DC.W    $31FC,$0001,$A04E   ; $011C76 MOVE.W  #$0001,$A04E.W
loc_011C7C:
        DC.W    $4E75               ; $011C7C RTS
loc_011C7E:
        DC.W    $4A78,$A04E         ; $011C7E TST.W  $A04E.W
        DC.W    $6640               ; $011C82 BNE.S  loc_011CC4
        DC.W    $0838,$0000,$A050   ; $011C84 BTST    #0,$A050.W
        DC.W    $661C               ; $011C8A BNE.S  loc_011CA8
        DC.W    $207C,$0601,$8F80   ; $011C8C MOVEA.L #$06018F80,A0
        DC.W    $227C,$0400,$D018   ; $011C92 MOVEA.L #$0400D018,A1
        DC.W    $303C,$0078         ; $011C98 MOVE.W  #$0078,D0
        DC.W    $323C,$0018         ; $011C9C MOVE.W  #$0018,D1
        DC.W    $4EBA,$C6B8         ; $011CA0 JSR     $00E35A(PC)
        DC.W    $6000,$0062         ; $011CA4 BRA.W  loc_011D08
loc_011CA8:
        DC.W    $207C,$0601,$0000   ; $011CA8 MOVEA.L #$06010000,A0
        DC.W    $227C,$0400,$D018   ; $011CAE MOVEA.L #$0400D018,A1
        DC.W    $303C,$0078         ; $011CB4 MOVE.W  #$0078,D0
        DC.W    $323C,$0018         ; $011CB8 MOVE.W  #$0018,D1
        DC.W    $4EBA,$C69C         ; $011CBC JSR     $00E35A(PC)
        DC.W    $6000,$0046         ; $011CC0 BRA.W  loc_011D08
loc_011CC4:
        DC.W    $0C78,$0002,$A04E   ; $011CC4 CMPI.W  #$0002,$A04E.W
        DC.W    $673C               ; $011CCA BEQ.S  loc_011D08
        DC.W    $0838,$0000,$A050   ; $011CCC BTST    #0,$A050.W
        DC.W    $661C               ; $011CD2 BNE.S  loc_011CF0
        DC.W    $207C,$0601,$9AC0   ; $011CD4 MOVEA.L #$06019AC0,A0
        DC.W    $227C,$0400,$D0A0   ; $011CDA MOVEA.L #$0400D0A0,A1
        DC.W    $303C,$0078         ; $011CE0 MOVE.W  #$0078,D0
        DC.W    $323C,$0018         ; $011CE4 MOVE.W  #$0018,D1
        DC.W    $4EBA,$C670         ; $011CE8 JSR     $00E35A(PC)
        DC.W    $6000,$001A         ; $011CEC BRA.W  loc_011D08
loc_011CF0:
        DC.W    $207C,$0601,$0000   ; $011CF0 MOVEA.L #$06010000,A0
        DC.W    $227C,$0400,$D0A0   ; $011CF6 MOVEA.L #$0400D0A0,A1
        DC.W    $303C,$0078         ; $011CFC MOVE.W  #$0078,D0
        DC.W    $323C,$0018         ; $011D00 MOVE.W  #$0018,D1
        DC.W    $4EBA,$C654         ; $011D04 JSR     $00E35A(PC)
loc_011D08:
        DC.W    $4E75               ; $011D08 RTS
        DC.W    $33FC,$002C,$00FF,$0008; $011D0A MOVE.W  #$002C,$00FF0008
        DC.W    $31FC,$002C,$C87A   ; $011D12 MOVE.W  #$002C,$C87A.W
        DC.W    $08B8,$0006,$C875   ; $011D18 BCLR    #6,$C875.W
        DC.W    $3AB8,$C874         ; $011D1E MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0083,$00A1,$5100; $011D22 MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $011D2A ANDI.B  #$00FC,$00A15181
        DC.W    $4EB9,$0088,$26C8   ; $011D32 JSR     $008826C8
        DC.W    $203C,$000A,$0907   ; $011D38 MOVE.L  #$000A0907,D0
        DC.W    $4EB9,$0088,$14BE   ; $011D3E JSR     $008814BE
        DC.W    $11FC,$0001,$C80D   ; $011D44 MOVE.B  #$0001,$C80D.W
        DC.W    $7000               ; $011D4A MOVEQ   #$00,D0
        DC.W    $41F8,$8480         ; $011D4C LEA     $8480.W,A0
        DC.W    $721F               ; $011D50 MOVEQ   #$1F,D1
loc_011D52:
        DC.W    $20C0               ; $011D52 MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $011D54 DBRA    D1,loc_011D52
        DC.W    $41F9,$00FF,$7B80   ; $011D58 LEA     $00FF7B80,A0
        DC.W    $727F               ; $011D5E MOVEQ   #$7F,D1
loc_011D60:
        DC.W    $20C0               ; $011D60 MOVE.L  D0,(A0)+
        DC.W    $51C9,$FFFC         ; $011D62 DBRA    D1,loc_011D60
        DC.W    $2ABC,$6000,$0002   ; $011D66 MOVE.L  #$60000002,(A5)
        DC.W    $323C,$17FF         ; $011D6C MOVE.W  #$17FF,D1
loc_011D70:
        DC.W    $2C80               ; $011D70 MOVE.L  D0,(A6)
        DC.W    $51C9,$FFFC         ; $011D72 DBRA    D1,loc_011D70
        DC.W    $4EB9,$0088,$49AA   ; $011D76 JSR     $008849AA
        DC.W    $4278,$C880         ; $011D7C CLR.W  $C880.W
        DC.W    $4278,$C882         ; $011D80 CLR.W  $C882.W
        DC.W    $4278,$8000         ; $011D84 CLR.W  $8000.W
        DC.W    $4278,$8002         ; $011D88 CLR.W  $8002.W
        DC.W    $4278,$A012         ; $011D8C CLR.W  $A012.W
        DC.W    $4238,$A018         ; $011D90 CLR.B  $A018.W
        DC.W    $4EB9,$0088,$49AA   ; $011D94 JSR     $008849AA
        DC.W    $21FC,$008B,$B4FC,$C96C; $011D9A MOVE.L  #$008BB4FC,$C96C.W
        DC.W    $11FC,$0001,$C809   ; $011DA2 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $011DA8 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0006,$C80E   ; $011DAE BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $011DB4 MOVE.B  #$0001,$C802.W
        DC.W    $31FC,$0001,$A038   ; $011DBA MOVE.W  #$0001,$A038.W
        DC.W    $41F9,$00FF,$1000   ; $011DC0 LEA     $00FF1000,A0
        DC.W    $303C,$037F         ; $011DC6 MOVE.W  #$037F,D0
loc_011DCA:
        DC.W    $4298               ; $011DCA CLR.L  (A0)+
        DC.W    $51C8,$FFFC         ; $011DCC DBRA    D0,loc_011DCA
        DC.W    $303C,$0001         ; $011DD0 MOVE.W  #$0001,D0
        DC.W    $323C,$0001         ; $011DD4 MOVE.W  #$0001,D1
        DC.W    $343C,$0001         ; $011DD8 MOVE.W  #$0001,D2
        DC.W    $363C,$0026         ; $011DDC MOVE.W  #$0026,D3
        DC.W    $383C,$001A         ; $011DE0 MOVE.W  #$001A,D4
        DC.W    $41F9,$00FF,$1000   ; $011DE4 LEA     $00FF1000,A0
        DC.W    $4EBA,$C440         ; $011DEA JSR     $00E22C(PC)
        DC.W    $41F9,$00FF,$1000   ; $011DEE LEA     $00FF1000,A0
        DC.W    $4EBA,$C4FA         ; $011DF4 JSR     $00E2F0(PC)
        DC.W    $4EBA,$C3C2         ; $011DF8 JSR     $00E1BC(PC)
        DC.W    $08B9,$0007,$00A1,$5181; $011DFC BCLR    #7,$00A15181
        DC.W    $41F9,$00FF,$6E00   ; $011E04 LEA     $00FF6E00,A0
        DC.W    $5488               ; $011E0A ADDQ.L  #2,A0
        DC.W    $43F9,$0089,$1F38   ; $011E0C LEA     $00891F38,A1
        DC.W    $303C,$002E         ; $011E12 MOVE.W  #$002E,D0
loc_011E16:
        DC.W    $3219               ; $011E16 MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $011E18 BSET    #15,D1
        DC.W    $30C1               ; $011E1C MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $011E1E DBRA    D0,loc_011E16
        DC.W    $41F9,$00FF,$6E00   ; $011E22 LEA     $00FF6E00,A0
        DC.W    $D1FC,$0000,$0120   ; $011E28 ADDA.L  #$00000120,A0
        DC.W    $43F9,$0089,$1F96   ; $011E2E LEA     $00891F96,A1
        DC.W    $303C,$005F         ; $011E34 MOVE.W  #$005F,D0
loc_011E38:
        DC.W    $3219               ; $011E38 MOVE.W  (A1)+,D1
        DC.W    $08C1,$000F         ; $011E3A BSET    #15,D1
        DC.W    $30C1               ; $011E3E MOVE.W  D1,(A0)+
        DC.W    $51C8,$FFF6         ; $011E40 DBRA    D0,loc_011E38
        DC.W    $41F9,$000E,$DF70   ; $011E44 LEA     $000EDF70,A0
        DC.W    $227C,$0601,$8000   ; $011E4A MOVEA.L #$06018000,A1
        DC.W    $4EBA,$C4C4         ; $011E50 JSR     $00E316(PC)
        DC.W    $41F9,$000E,$E770   ; $011E54 LEA     $000EE770,A0
        DC.W    $227C,$0601,$AD00   ; $011E5A MOVEA.L #$0601AD00,A1
        DC.W    $4EBA,$C4B4         ; $011E60 JSR     $00E316(PC)
        DC.W    $41F9,$000E,$BB40   ; $011E64 LEA     $000EBB40,A0
        DC.W    $227C,$0601,$BE00   ; $011E6A MOVEA.L #$0601BE00,A1
        DC.W    $4EBA,$C4A4         ; $011E70 JSR     $00E316(PC)
        DC.W    $41F9,$000E,$B980   ; $011E74 LEA     $000EB980,A0
        DC.W    $227C,$0601,$F000   ; $011E7A MOVEA.L #$0601F000,A1
        DC.W    $4EBA,$C494         ; $011E80 JSR     $00E316(PC)
        DC.W    $41F9,$000E,$C6F0   ; $011E84 LEA     $000EC6F0,A0
        DC.W    $227C,$0601,$F9C0   ; $011E8A MOVEA.L #$0601F9C0,A1
        DC.W    $4EBA,$C484         ; $011E90 JSR     $00E316(PC)
        DC.W    $41F9,$000E,$C150   ; $011E94 LEA     $000EC150,A0
        DC.W    $227C,$0602,$07C0   ; $011E9A MOVEA.L #$060207C0,A1
        DC.W    $4EBA,$C474         ; $011EA0 JSR     $00E316(PC)
        DC.W    $41F9,$000E,$EA40   ; $011EA4 LEA     $000EEA40,A0
        DC.W    $227C,$0603,$0000   ; $011EAA MOVEA.L #$06030000,A1
        DC.W    $4EBA,$C464         ; $011EB0 JSR     $00E316(PC)
        DC.W    $11FC,$0000,$A019   ; $011EB4 MOVE.B  #$0000,$A019.W
        DC.W    $11FC,$0000,$A01A   ; $011EBA MOVE.B  #$0000,$A01A.W
        DC.W    $11FC,$0000,$A01B   ; $011EC0 MOVE.B  #$0000,$A01B.W
        DC.W    $11FC,$0000,$A01C   ; $011EC6 MOVE.B  #$0000,$A01C.W
        DC.W    $42B8,$A026         ; $011ECC CLR.L  $A026.W
        DC.W    $4278,$A02C         ; $011ED0 CLR.W  $A02C.W
        DC.W    $21FC,$0402,$A060,$A030; $011ED4 MOVE.L  #$0402A060,$A030.W
        DC.W    $21FC,$0402,$A020,$A034; $011EDC MOVE.L  #$0402A020,$A034.W
        DC.W    $4EB9,$0088,$204A   ; $011EE4 JSR     $0088204A
        DC.W    $11FC,$0001,$C821   ; $011EEA MOVE.B  #$0001,$C821.W
        DC.W    $0239,$00FC,$00A1,$5181; $011EF0 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $011EF8 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $011F00 MOVE.W  #$8083,$00A15100
        DC.W    $08F8,$0006,$C875   ; $011F08 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $011F0E MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0018,$00FF,$0008; $011F12 MOVE.W  #$0018,$00FF0008
        DC.W    $4EB9,$0088,$4998   ; $011F1A JSR     $00884998
        DC.W    $31FC,$0000,$C87E   ; $011F20 MOVE.W  #$0000,$C87E.W
        DC.W    $23FC,$0089,$2056,$00FF,$0002; $011F26 MOVE.L  #$00892056,$00FF0002
        DC.W    $11FC,$008F,$C8A5   ; $011F30 MOVE.B  #$008F,$C8A5.W
        DC.W    $4E75               ; $011F36 RTS
        DC.W    $0000,$0421         ; $011F38 ORI.B  #$0421,D0
        DC.W    $0842,$0C63         ; $011F3C BCHG    #3,D2
        DC.W    $1084               ; $011F40 MOVE.B  D4,(A0)
        DC.W    $14A5               ; $011F42 MOVE.B  -(A5),(A2)
        DC.W    $18C6               ; $011F44 MOVE.B  D6,(A4)+
        DC.W    $1CE7               ; $011F46 MOVE.B  -(A7),(A6)+
        DC.W    $2108               ; $011F48 MOVE.L  A0,-(A0)
        DC.W    $2529,$7FFF         ; $011F4A MOVE.L  $7FFF(A1),-(A2)
        DC.W    $7FFF               ; $011F4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $318C,$7FFF         ; $011F50 MOVE.W  A4,-$01(A0,D7.L)
        DC.W    $39CE,$3DEF         ; $011F54 MOVE.W  A6,#$3DEF
        DC.W    $7FFF               ; $011F58 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F5A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F5C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F5E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $5294               ; $011F60 ADDQ.L  #1,(A4)
        DC.W    $56B5,$7FFF         ; $011F62 ADDQ.L  #3,-$01(A5,D7.L)
        DC.W    $5EF7,$6318         ; $011F66 SGT     $18(A7,D6.W)
        DC.W    $7FFF               ; $011F6A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $6B5A               ; $011F6C BMI.S  loc_011FC8
        DC.W    $6F7B               ; $011F6E BLE.S  loc_011FEB
        DC.W    $7FFF               ; $011F70 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F72 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7BDE               ; $011F74 MOVE.W  (A6)+,<EA:3D>
        DC.W    $7FFF               ; $011F76 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F78 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F7A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F7C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F7E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F80 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F82 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F84 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F86 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F88 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F8A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F8C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F8E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F90 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F92 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011F94 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $6337               ; $011F96 BLS.S  loc_011FCF
        DC.W    $6737               ; $011F98 BEQ.S  loc_011FD1
        DC.W    $6B58               ; $011F9A BMI.S  loc_011FF4
        DC.W    $6F79               ; $011F9C BLE.S  loc_012017
loc_011F9E:
        DC.W    $4445               ; $011F9E NEG.W  D5
        DC.W    $512B,$6212         ; $011FA0 SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $011FA4 BGT.S  loc_011F9E
        DC.W    $739A,$61E8         ; $011FA6 MOVE.W  (A2)+,-$18(A1,D6.W)
        DC.W    $7FFF               ; $011FAA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FAC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FAE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FB0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FB2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FB4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FB6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7000               ; $011FB8 MOVEQ   #$00,D0
        DC.W    $7CA0               ; $011FBA MOVEQ   #-$60,D6
        DC.W    $70E7               ; $011FBC MOVEQ   #-$19,D0
        DC.W    $7FFF               ; $011FBE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $5800               ; $011FC0 ADDQ.B  #4,D0
        DC.W    $0180               ; $011FC2 BCLR    D0,D0
        DC.W    $0200,$000E         ; $011FC4 ANDI.B  #$000E,D0
loc_011FC8:
        DC.W    $0014,$1CFB         ; $011FC8 ORI.B  #$1CFB,(A4)
        DC.W    $7FFF               ; $011FCC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FCE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FD0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FD2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $011FD4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $4400               ; $011FD6 NEG.B  D0
        DC.W    $44A3               ; $011FD8 NEG.L  -(A3)
        DC.W    $4946               ; $011FDA DC.W    $4946
        DC.W    $4DE9,$1C00         ; $011FDC LEA     $1C00(A1),A6
        DC.W    $28A3               ; $011FE0 MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $011FE2 MOVE.W  D6,$41E9(A2)
        DC.W    $5940               ; $011FE6 SUBQ.W  #4,D0
        DC.W    $5983               ; $011FE8 SUBQ.L  #4,D3
        DC.W    $55E6               ; $011FEA SCS     -(A6)
        DC.W    $5629,$1C00         ; $011FEC ADDQ.B  #3,$1C00(A1)
        DC.W    $28A3               ; $011FF0 MOVE.L  -(A3),(A4)
        DC.W    $3546,$41E9         ; $011FF2 MOVE.W  D6,$41E9(A2)
        DC.W    $4400               ; $011FF6 NEG.B  D0
        DC.W    $44A3               ; $011FF8 NEG.L  -(A3)
        DC.W    $4946               ; $011FFA DC.W    $4946
        DC.W    $4DE9,$7FFF         ; $011FFC LEA     $7FFF(A1),A6
        DC.W    $63F5               ; $012000 BLS.S  loc_011FF7
        DC.W    $7FFF               ; $012002 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012004 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$7FFF         ; $012006 ORI.B  #$7FFF,(A0)
        DC.W    $294E,$7FFF         ; $01200A MOVE.L  A6,$7FFF(A4)
        DC.W    $0000,$4E73         ; $01200E ORI.B  #$4E73,D0
        DC.W    $6739               ; $012012 BEQ.S  loc_01204D
        DC.W    $7FFF               ; $012014 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $6337               ; $012016 BLS.S  loc_01204F
        DC.W    $6737               ; $012018 BEQ.S  loc_012051
        DC.W    $6B58               ; $01201A BMI.S  loc_012074
        DC.W    $6F79               ; $01201C BLE.S  loc_012097
        DC.W    $6B36               ; $01201E BMI.S  loc_012056
        DC.W    $6B37               ; $012020 BMI.S  loc_012059
        DC.W    $6F58               ; $012022 BLE.S  loc_01207C
        DC.W    $6F79               ; $012024 BLE.S  loc_01209F
        DC.W    $739A,$61E8         ; $012026 MOVE.W  (A2)+,-$18(A1,D6.W)
        DC.W    $7FFF               ; $01202A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01202C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01202E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012030 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012032 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012034 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $10E1               ; $012036 MOVE.B  -(A1),(A0)+
        DC.W    $29A8,$4670,$6337   ; $012038 MOVE.L  $4670(A0),$37(A4,D6.W)
loc_01203E:
        DC.W    $4445               ; $01203E NEG.W  D5
        DC.W    $512B,$6212         ; $012040 SUBQ.B  #8,$6212(A3)
        DC.W    $6EF8               ; $012044 BGT.S  loc_01203E
        DC.W    $7FFF               ; $012046 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $031F               ; $012048 BTST    D1,(A7)+
        DC.W    $7FFF               ; $01204A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01204C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $01204E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012050 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012052 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $012054 MOVE.W  <EA:3F>,<EA:3F>
loc_012056:
        DC.W    $4EB9,$0088,$2080   ; $012056 JSR     $00882080
        DC.W    $3038,$C87E         ; $01205C MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $012060 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $012064 JMP     (A1)
        DC.W    $0089,$2084,$0089   ; $012066 ORI.L  #$20840089,A1
        DC.W    $2224               ; $01206C MOVE.L  -(A4),D1
        DC.W    $0089,$250C,$4EBA   ; $01206E ORI.L  #$250C4EBA,A1
loc_012074:
        DC.W    $9610               ; $012074 SUB.B  (A0),D3
        DC.W    $0838,$0006,$C80E   ; $012076 BTST    #6,$C80E.W
loc_01207C:
        DC.W    $6604               ; $01207C BNE.S  loc_012082
        DC.W    $5878,$C87E         ; $01207E ADDQ.W  #4,$C87E.W
loc_012082:
        DC.W    $4E75               ; $012082 RTS
        DC.W    $4240               ; $012084 CLR.W  D0
        DC.W    $4EBA,$C4A4         ; $012086 JSR     $00E52C(PC)
        DC.W    $207C,$0601,$8000   ; $01208A MOVEA.L #$06018000,A0
        DC.W    $227C,$0400,$4C74   ; $012090 MOVEA.L #$04004C74,A1
        DC.W    $303C,$0058         ; $012096 MOVE.W  #$0058,D0
        DC.W    $323C,$0010         ; $01209A MOVE.W  #$0010,D1
        DC.W    $4EBA,$C2BA         ; $01209E JSR     $00E35A(PC)
        DC.W    $207C,$0601,$8900   ; $0120A2 MOVEA.L #$06018900,A0
        DC.W    $227C,$0401,$9010   ; $0120A8 MOVEA.L #$04019010,A1
        DC.W    $303C,$0120         ; $0120AE MOVE.W  #$0120,D0
        DC.W    $323C,$0010         ; $0120B2 MOVE.W  #$0010,D1
        DC.W    $4EBA,$C2A2         ; $0120B6 JSR     $00E35A(PC)
        DC.W    $207C,$0601,$9B00   ; $0120BA MOVEA.L #$06019B00,A0
        DC.W    $227C,$0401,$C010   ; $0120C0 MOVEA.L #$0401C010,A1
        DC.W    $303C,$0120         ; $0120C6 MOVE.W  #$0120,D0
        DC.W    $323C,$0010         ; $0120CA MOVE.W  #$0010,D1
        DC.W    $4EBA,$C28A         ; $0120CE JSR     $00E35A(PC)
        DC.W    $7000               ; $0120D2 MOVEQ   #$00,D0
        DC.W    $4A38,$A01A         ; $0120D4 TST.B  $A01A.W
        DC.W    $660A               ; $0120D8 BNE.S  loc_0120E4
        DC.W    $1038,$A019         ; $0120DA MOVE.B  $A019.W,D0
        DC.W    $343C,$0010         ; $0120DE MOVE.W  #$0010,D2
        DC.W    $6008               ; $0120E2 BRA.S  loc_0120EC
loc_0120E4:
        DC.W    $1038,$A01B         ; $0120E4 MOVE.B  $A01B.W,D0
        DC.W    $343C,$FFC0         ; $0120E8 MOVE.W  #$FFC0,D2
loc_0120EC:
        DC.W    $1600               ; $0120EC MOVE.B  D0,D3
        DC.W    $43F9,$0089,$21FA   ; $0120EE LEA     $008921FA,A1
        DC.W    $D040               ; $0120F4 ADD.W  D0,D0
        DC.W    $D040               ; $0120F6 ADD.W  D0,D0
        DC.W    $2071,$0000         ; $0120F8 MOVEA.L $00(A1,D0.W),A0
        DC.W    $303C,$0061         ; $0120FC MOVE.W  #$0061,D0
        DC.W    $4A03               ; $012100 TST.B  D3
        DC.W    $6604               ; $012102 BNE.S  loc_012108
        DC.W    $303C,$0060         ; $012104 MOVE.W  #$0060,D0
loc_012108:
        DC.W    $323C,$0010         ; $012108 MOVE.W  #$0010,D1
loc_01210C:
        DC.W    $4A39,$00A1,$5120   ; $01210C TST.B  $00A15120
        DC.W    $66F8               ; $012112 BNE.S  loc_01210C
        DC.W    $4EBA,$C29E         ; $012114 JSR     $00E3B4(PC)
        DC.W    $7000               ; $012118 MOVEQ   #$00,D0
        DC.W    $4A38,$A01A         ; $01211A TST.B  $A01A.W
        DC.W    $670A               ; $01211E BEQ.S  loc_01212A
        DC.W    $1038,$A019         ; $012120 MOVE.B  $A019.W,D0
        DC.W    $343C,$0010         ; $012124 MOVE.W  #$0010,D2
        DC.W    $6008               ; $012128 BRA.S  loc_012132
loc_01212A:
        DC.W    $1038,$A01C         ; $01212A MOVE.B  $A01C.W,D0
        DC.W    $343C,$FFC0         ; $01212E MOVE.W  #$FFC0,D2
loc_012132:
        DC.W    $43F9,$0089,$2206   ; $012132 LEA     $00892206,A1
        DC.W    $D040               ; $012138 ADD.W  D0,D0
        DC.W    $3200               ; $01213A MOVE.W  D0,D1
        DC.W    $D040               ; $01213C ADD.W  D0,D0
        DC.W    $D041               ; $01213E ADD.W  D1,D0
        DC.W    $2071,$0000         ; $012140 MOVEA.L $00(A1,D0.W),A0
        DC.W    $3031,$0004         ; $012144 MOVE.W  $04(A1,D0.W),D0
        DC.W    $323C,$0010         ; $012148 MOVE.W  #$0010,D1
loc_01214C:
        DC.W    $4A39,$00A1,$5120   ; $01214C TST.B  $00A15120
        DC.W    $66F8               ; $012152 BNE.S  loc_01214C
        DC.W    $4EBA,$C25E         ; $012154 JSR     $00E3B4(PC)
loc_012158:
        DC.W    $4A39,$00A1,$5120   ; $012158 TST.B  $00A15120
        DC.W    $66F8               ; $01215E BNE.S  loc_012158
        DC.W    $33FC,$0101,$00A1,$512C; $012160 MOVE.W  #$0101,$00A1512C
        DC.W    $33FC,$4000,$00A1,$5128; $012168 MOVE.W  #$4000,$00A15128
        DC.W    $13FC,$002C,$00A1,$5121; $012170 MOVE.B  #$002C,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $012178 MOVE.B  #$0001,$00A15120
loc_012180:
        DC.W    $4A39,$00A1,$512C   ; $012180 TST.B  $00A1512C
        DC.W    $66F8               ; $012186 BNE.S  loc_012180
        DC.W    $33FC,$0078,$00A1,$5128; $012188 MOVE.W  #$0078,$00A15128
        DC.W    $33FC,$0101,$00A1,$512C; $012190 MOVE.W  #$0101,$00A1512C
        DC.W    $7000               ; $012198 MOVEQ   #$00,D0
        DC.W    $1038,$A019         ; $01219A MOVE.B  $A019.W,D0
        DC.W    $4A38,$A01A         ; $01219E TST.B  $A01A.W
        DC.W    $6704               ; $0121A2 BEQ.S  loc_0121A8
        DC.W    $1038,$A01B         ; $0121A4 MOVE.B  $A01B.W,D0
loc_0121A8:
        DC.W    $21C0,$A01E         ; $0121A8 MOVE.L  D0,$A01E.W
        DC.W    $7000               ; $0121AC MOVEQ   #$00,D0
        DC.W    $1038,$A019         ; $0121AE MOVE.B  $A019.W,D0
        DC.W    $4A38,$A01A         ; $0121B2 TST.B  $A01A.W
        DC.W    $6604               ; $0121B6 BNE.S  loc_0121BC
        DC.W    $1038,$A01C         ; $0121B8 MOVE.B  $A01C.W,D0
loc_0121BC:
        DC.W    $21C0,$A022         ; $0121BC MOVE.L  D0,$A022.W
        DC.W    $207C,$0601,$BE00   ; $0121C0 MOVEA.L #$0601BE00,A0
        DC.W    $7200               ; $0121C6 MOVEQ   #$00,D1
        DC.W    $3038,$A02C         ; $0121C8 MOVE.W  $A02C.W,D0
        DC.W    $670E               ; $0121CC BEQ.S  loc_0121DC
        DC.W    $5340               ; $0121CE SUBQ.W  #1,D0
loc_0121D0:
        DC.W    $0681,$0000,$0280   ; $0121D0 ADDI.L  #$00000280,D1
        DC.W    $51C8,$FFF8         ; $0121D6 DBRA    D0,loc_0121D0
        DC.W    $D1C1               ; $0121DA ADDA.L  D1,A0
loc_0121DC:
        DC.W    $2278,$A034         ; $0121DC MOVEA.L $A034.W,A1
        DC.W    $303C,$0028         ; $0121E0 MOVE.W  #$0028,D0
        DC.W    $323C,$0060         ; $0121E4 MOVE.W  #$0060,D1
        DC.W    $4EBA,$C170         ; $0121E8 JSR     $00E35A(PC)
        DC.W    $5878,$C87E         ; $0121EC ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0020,$00FF,$0008; $0121F0 MOVE.W  #$0020,$00FF0008
        DC.W    $4E75               ; $0121F8 RTS
        DC.W    $0401,$9010         ; $0121FA SUBI.B  #$9010,D1
        DC.W    $0401,$906F         ; $0121FE SUBI.B  #$906F,D1
