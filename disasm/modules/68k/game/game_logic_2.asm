; Generated assembly for $008200-$008B9C
; Branch targets: 103
; Labels: 97
; Format: DC.W with decoded mnemonics as comments

        org     $008200

        DC.W    $C8A4               ; $008200 AND.L  -(A4),D4
        DC.W    $6706               ; $008202 BEQ.S  loc_00820A
        DC.W    $11FC,$00BF,$C8A4   ; $008204 MOVE.B  #$00BF,$C8A4.W
loc_00820A:
        DC.W    $4A78,$C04E         ; $00820A TST.W  $C04E.W
        DC.W    $6744               ; $00820E BEQ.S  loc_008254
        DC.W    $7000               ; $008210 MOVEQ   #$00,D0
        DC.W    $5378,$C04E         ; $008212 SUBQ.W  #1,$C04E.W
        DC.W    $670A               ; $008216 BEQ.S  loc_008222
        DC.W    $0838,$0002,$C8AB   ; $008218 BTST    #2,$C8AB.W
        DC.W    $6602               ; $00821E BNE.S  loc_008222
        DC.W    $7001               ; $008220 MOVEQ   #$01,D0
loc_008222:
        DC.W    $13C0,$00FF,$6960   ; $008222 MOVE.B  D0,$00FF6960
        DC.W    $4A38,$C305         ; $008228 TST.B  $C305.W
        DC.W    $6626               ; $00822C BNE.S  loc_008254
        DC.W    $0C78,$003C,$C04E   ; $00822E CMPI.W  #$003C,$C04E.W
        DC.W    $661E               ; $008234 BNE.S  loc_008254
        DC.W    $0828,$0001,$0002   ; $008236 BTST    #1,$0002(A0)
        DC.W    $6708               ; $00823C BEQ.S  loc_008246
        DC.W    $0268,$FDFF,$0002   ; $00823E ANDI.W  #$FDFF,$0002(A0)
        DC.W    $4E75               ; $008244 RTS
loc_008246:
        DC.W    $3028,$002C         ; $008246 MOVE.W  $002C(A0),D0
        DC.W    $43FA,$000A         ; $00824A LEA     $000A(PC),A1
        DC.W    $11F1,$0000,$C8A5   ; $00824E MOVE.B  $00(A1,D0.W),$C8A5.W
loc_008254:
        DC.W    $4E75               ; $008254 RTS
        DC.W    $8586               ; $008256 OR.L   D2,D6
        DC.W    $8788               ; $008258 OR.L   D3,A0
        DC.W    $8900               ; $00825A OR.B   D4,D0
        DC.W    $0828,$0006,$0002   ; $00825C BTST    #6,$0002(A0)
        DC.W    $6742               ; $008262 BEQ.S  loc_0082A6
        DC.W    $0268,$BFFF,$0002   ; $008264 ANDI.W  #$BFFF,$0002(A0)
        DC.W    $0828,$0001,$0002   ; $00826A BTST    #1,$0002(A0)
        DC.W    $670E               ; $008270 BEQ.S  loc_008280
        DC.W    $31FC,$0000,$C04E   ; $008272 MOVE.W  #$0000,$C04E.W
        DC.W    $0268,$FDFF,$0002   ; $008278 ANDI.W  #$FDFF,$0002(A0)
        DC.W    $4E75               ; $00827E RTS
loc_008280:
        DC.W    $4278,$C8AA         ; $008280 CLR.W  $C8AA.W
        DC.W    $7C00               ; $008284 MOVEQ   #$00,D6
        DC.W    $1038,$C319         ; $008286 MOVE.B  $C319.W,D0
        DC.W    $0240,$00C0         ; $00828A ANDI.W  #$00C0,D0
        DC.W    $E808               ; $00828E LSR.B  #4,D0
        DC.W    $227B,$0056         ; $008290 MOVEA.L $56(PC,D0.W),A1
        DC.W    $4E91               ; $008294 JSR     (A1)
        DC.W    $43F9,$00FF,$68F8   ; $008296 LEA     $00FF68F8,A1
        DC.W    $1340,$FFF9         ; $00829C MOVE.B  D0,-$0007(A1)
        DC.W    $12C1               ; $0082A0 MOVE.B  D1,(A1)+
        DC.W    $4EBA,$00F6         ; $0082A2 JSR     loc_00839A(PC)
loc_0082A6:
        DC.W    $3038,$C04E         ; $0082A6 MOVE.W  $C04E.W,D0
        DC.W    $673A               ; $0082AA BEQ.S  loc_0082E6
        DC.W    $7E00               ; $0082AC MOVEQ   #$00,D7
        DC.W    $5378,$C04E         ; $0082AE SUBQ.W  #1,$C04E.W
        DC.W    $672C               ; $0082B2 BEQ.S  loc_0082E0
        DC.W    $0838,$0002,$C8AB   ; $0082B4 BTST    #2,$C8AB.W
        DC.W    $6602               ; $0082BA BNE.S  loc_0082BE
        DC.W    $7E03               ; $0082BC MOVEQ   #$03,D7
loc_0082BE:
        DC.W    $4A38,$C305         ; $0082BE TST.B  $C305.W
        DC.W    $6622               ; $0082C2 BNE.S  loc_0082E6
        DC.W    $4A40               ; $0082C4 TST.W  D0
        DC.W    $6B1E               ; $0082C6 BMI.S  loc_0082E6
        DC.W    $3228,$0002         ; $0082C8 MOVE.W  $0002(A0),D1
        DC.W    $0241,$0200         ; $0082CC ANDI.W  #$0200,D1
        DC.W    $670E               ; $0082D0 BEQ.S  loc_0082E0
        DC.W    $0268,$FDFF,$0002   ; $0082D2 ANDI.W  #$FDFF,$0002(A0)
        DC.W    $31FC,$0000,$C04E   ; $0082D8 MOVE.W  #$0000,$C04E.W
        DC.W    $4E75               ; $0082DE RTS
loc_0082E0:
        DC.W    $13C7,$00FF,$68F0   ; $0082E0 MOVE.B  D7,$00FF68F0
loc_0082E6:
        DC.W    $4E75               ; $0082E6 RTS
        DC.W    $0088,$82F8,$0088   ; $0082E8 ORI.L  #$82F80088,A0
        DC.W    $82F8,$0088         ; $0082EE DIVU    $0088.W,D1
        DC.W    $82FA,$0088         ; $0082F2 DIVU    $0088(PC),D1
        DC.W    $8318               ; $0082F6 OR.B   D1,(A0)+
        DC.W    $4E75               ; $0082F8 RTS
        DC.W    $43F8,$C806         ; $0082FA LEA     $C806.W,A1
        DC.W    $45F8,$C270         ; $0082FE LEA     $C270.W,A2
        DC.W    $4EBA,$30CA         ; $008302 JSR     $00B3CE(PC)
        DC.W    $7000               ; $008306 MOVEQ   #$00,D0
        DC.W    $43F8,$C270         ; $008308 LEA     $C270.W,A1
        DC.W    $4EBA,$3078         ; $00830C JSR     $00B386(PC)
        DC.W    $2A38,$C270         ; $008310 MOVE.L  $C270.W,D5
        DC.W    $7C04               ; $008314 MOVEQ   #$04,D6
        DC.W    $601C               ; $008316 BRA.S  loc_008334
        DC.W    $43F8,$C806         ; $008318 LEA     $C806.W,A1
        DC.W    $45F8,$C274         ; $00831C LEA     $C274.W,A2
        DC.W    $4EBA,$30AC         ; $008320 JSR     $00B3CE(PC)
        DC.W    $7002               ; $008324 MOVEQ   #$02,D0
        DC.W    $43F8,$C274         ; $008326 LEA     $C274.W,A1
        DC.W    $4EBA,$305A         ; $00832A JSR     $00B386(PC)
        DC.W    $2A38,$C274         ; $00832E MOVE.L  $C274.W,D5
        DC.W    $7C08               ; $008332 MOVEQ   #$08,D6
loc_008334:
        DC.W    $47F8,$FDAA         ; $008334 LEA     $FDAA.W,A3
        DC.W    $3238,$C89C         ; $008338 MOVE.W  $C89C.W,D1
        DC.W    $EB49               ; $00833C LSL.W  #5,D1
        DC.W    $D278,$C8A0         ; $00833E ADD.W  $C8A0.W,D1
        DC.W    $3438,$C8C8         ; $008342 MOVE.W  $C8C8.W,D2
        DC.W    $E74A               ; $008346 LSL.W  #3,D2
        DC.W    $D478,$C8CC         ; $008348 ADD.W  $C8CC.W,D2
        DC.W    $D242               ; $00834C ADD.W  D2,D1
        DC.W    $D246               ; $00834E ADD.W  D6,D1
        DC.W    $47F3,$1000         ; $008350 LEA     $00(A3,D1.W),A3
        DC.W    $0C85,$6000,$0000   ; $008354 CMPI.L  #$60000000,D5
        DC.W    $6D0C               ; $00835A BLT.S  loc_008368
        DC.W    $28BC,$DDDD,$0DDD   ; $00835C MOVE.L  #$DDDD0DDD,(A4)
        DC.W    $7001               ; $008362 MOVEQ   #$01,D0
        DC.W    $7200               ; $008364 MOVEQ   #$00,D1
        DC.W    $4E75               ; $008366 RTS
loc_008368:
        DC.W    $BA93               ; $008368 CMP.L  (A3),D5
        DC.W    $6D0E               ; $00836A BLT.S  loc_00837A
        DC.W    $6E1C               ; $00836C BGT.S  loc_00838A
        DC.W    $28BC,$0000,$0000   ; $00836E MOVE.L  #$00000000,(A4)
        DC.W    $720E               ; $008374 MOVEQ   #$0E,D1
        DC.W    $7000               ; $008376 MOVEQ   #$00,D0
        DC.W    $4E75               ; $008378 RTS
loc_00837A:
        DC.W    $2893               ; $00837A MOVE.L  (A3),(A4)
        DC.W    $2945,$0004         ; $00837C MOVE.L  D5,$0004(A4)
        DC.W    $4EBA,$30F6         ; $008380 JSR     $00B478(PC)
        DC.W    $7002               ; $008384 MOVEQ   #$02,D0
        DC.W    $720D               ; $008386 MOVEQ   #$0D,D1
        DC.W    $4E75               ; $008388 RTS
loc_00838A:
        DC.W    $2885               ; $00838A MOVE.L  D5,(A4)
        DC.W    $2953,$0004         ; $00838C MOVE.L  (A3),$0004(A4)
        DC.W    $4EBA,$30E6         ; $008390 JSR     $00B478(PC)
        DC.W    $7001               ; $008394 MOVEQ   #$01,D0
        DC.W    $720C               ; $008396 MOVEQ   #$0C,D1
        DC.W    $4E75               ; $008398 RTS
loc_00839A:
        DC.W    $1214               ; $00839A MOVE.B  (A4),D1
        DC.W    $6110               ; $00839C BSR.S  loc_0083AE
        DC.W    $122C,$0001         ; $00839E MOVE.B  $0001(A4),D1
        DC.W    $610A               ; $0083A2 BSR.S  loc_0083AE
        DC.W    $122C,$0002         ; $0083A4 MOVE.B  $0002(A4),D1
        DC.W    $12C1               ; $0083A8 MOVE.B  D1,(A1)+
        DC.W    $122C,$0003         ; $0083AA MOVE.B  $0003(A4),D1
loc_0083AE:
        DC.W    $1401               ; $0083AE MOVE.B  D1,D2
        DC.W    $E80A               ; $0083B0 LSR.B  #4,D2
        DC.W    $12C2               ; $0083B2 MOVE.B  D2,(A1)+
        DC.W    $0201,$000F         ; $0083B4 ANDI.B  #$000F,D1
        DC.W    $12C1               ; $0083B8 MOVE.B  D1,(A1)+
        DC.W    $4E75               ; $0083BA RTS
        DC.W    $0828,$0006,$0002   ; $0083BC BTST    #6,$0002(A0)
        DC.W    $6602               ; $0083C2 BNE.S  loc_0083C6
        DC.W    $4E75               ; $0083C4 RTS
loc_0083C6:
        DC.W    $7000               ; $0083C6 MOVEQ   #$00,D0
        DC.W    $1038,$A9E0         ; $0083C8 MOVE.B  $A9E0.W,D0
        DC.W    $5238,$A9E0         ; $0083CC ADDQ.B  #1,$A9E0.W
        DC.W    $43F8,$A9E3         ; $0083D0 LEA     $A9E3.W,A1
        DC.W    $45F8,$A800         ; $0083D4 LEA     $A800.W,A2
        DC.W    $601C               ; $0083D8 BRA.S  loc_0083F6
        DC.W    $0828,$0006,$0002   ; $0083DA BTST    #6,$0002(A0)
        DC.W    $6602               ; $0083E0 BNE.S  loc_0083E4
        DC.W    $4E75               ; $0083E2 RTS
loc_0083E4:
        DC.W    $7000               ; $0083E4 MOVEQ   #$00,D0
        DC.W    $1038,$A9E1         ; $0083E6 MOVE.B  $A9E1.W,D0
        DC.W    $5238,$A9E1         ; $0083EA ADDQ.B  #1,$A9E1.W
        DC.W    $43F8,$A9E7         ; $0083EE LEA     $A9E7.W,A1
        DC.W    $45F8,$A8F0         ; $0083F2 LEA     $A8F0.W,A2
loc_0083F6:
        DC.W    $E548               ; $0083F6 LSL.W  #2,D0
        DC.W    $45F2,$0000         ; $0083F8 LEA     $00(A2,D0.W),A2
        DC.W    $2F0A               ; $0083FC MOVE.L  A2,-(A7)
        DC.W    $4EBA,$2FCE         ; $0083FE JSR     $00B3CE(PC)
        DC.W    $225F               ; $008402 MOVEA.L (A7)+,A1
        DC.W    $7000               ; $008404 MOVEQ   #$00,D0
        DC.W    $1038,$C319         ; $008406 MOVE.B  $C319.W,D0
        DC.W    $0240,$00C0         ; $00840A ANDI.W  #$00C0,D0
        DC.W    $EC48               ; $00840E LSR.W  #6,D0
        DC.W    $5340               ; $008410 SUBQ.W  #1,D0
        DC.W    $D040               ; $008412 ADD.W  D0,D0
        DC.W    $4EFA,$2FA6         ; $008414 JMP     $00B3BC(PC)
        DC.W    $0828,$0006,$0002   ; $008418 BTST    #6,$0002(A0)
        DC.W    $674C               ; $00841E BEQ.S  loc_00846C
        DC.W    $0268,$BFFF,$0002   ; $008420 ANDI.W  #$BFFF,$0002(A0)
        DC.W    $4278,$C8AA         ; $008426 CLR.W  $C8AA.W
        DC.W    $45F8,$A800         ; $00842A LEA     $A800.W,A2
        DC.W    $47F8,$A8F0         ; $00842E LEA     $A8F0.W,A3
        DC.W    $7200               ; $008432 MOVEQ   #$00,D1
        DC.W    $1238,$A9E0         ; $008434 MOVE.B  $A9E0.W,D1
        DC.W    $4EBA,$00BA         ; $008438 JSR     loc_0084F4(PC)
        DC.W    $6708               ; $00843C BEQ.S  loc_008446
        DC.W    $31FC,$0000,$C04E   ; $00843E MOVE.W  #$0000,$C04E.W
        DC.W    $6044               ; $008444 BRA.S  loc_00848A
loc_008446:
        DC.W    $0269,$BFFF,$0002   ; $008446 ANDI.W  #$BFFF,$0002(A1)
        DC.W    $4EBA,$00C0         ; $00844C JSR     loc_00850E(PC)
        DC.W    $43F9,$00FF,$68F8   ; $008450 LEA     $00FF68F8,A1
        DC.W    $237C,$0402,$8070,$FFFC; $008456 MOVE.L  #$04028070,-$0004(A1)
        DC.W    $1340,$FFF9         ; $00845E MOVE.B  D0,-$0007(A1)
        DC.W    $12C1               ; $008462 MOVE.B  D1,(A1)+
        DC.W    $4EBA,$FF34         ; $008464 JSR     loc_00839A(PC)
        DC.W    $43F8,$9F00         ; $008468 LEA     $9F00.W,A1
loc_00846C:
        DC.W    $4A78,$C04E         ; $00846C TST.W  $C04E.W
        DC.W    $6718               ; $008470 BEQ.S  loc_00848A
        DC.W    $7E00               ; $008472 MOVEQ   #$00,D7
        DC.W    $5378,$C04E         ; $008474 SUBQ.W  #1,$C04E.W
        DC.W    $670A               ; $008478 BEQ.S  loc_008484
        DC.W    $0838,$0002,$C8AB   ; $00847A BTST    #2,$C8AB.W
        DC.W    $6602               ; $008480 BNE.S  loc_008484
        DC.W    $7E03               ; $008482 MOVEQ   #$03,D7
loc_008484:
        DC.W    $13C7,$00FF,$68F0   ; $008484 MOVE.B  D7,$00FF68F0
loc_00848A:
        DC.W    $0829,$0006,$0002   ; $00848A BTST    #6,$0002(A1)
        DC.W    $6742               ; $008490 BEQ.S  loc_0084D4
        DC.W    $0269,$BFFF,$0002   ; $008492 ANDI.W  #$BFFF,$0002(A1)
        DC.W    $4278,$C8AA         ; $008498 CLR.W  $C8AA.W
        DC.W    $45F8,$A8F0         ; $00849C LEA     $A8F0.W,A2
        DC.W    $47F8,$A800         ; $0084A0 LEA     $A800.W,A3
        DC.W    $7200               ; $0084A4 MOVEQ   #$00,D1
        DC.W    $1238,$A9E1         ; $0084A6 MOVE.B  $A9E1.W,D1
        DC.W    $4EBA,$0048         ; $0084AA JSR     loc_0084F4(PC)
        DC.W    $6708               ; $0084AE BEQ.S  loc_0084B8
        DC.W    $31FC,$0000,$B7AE   ; $0084B0 MOVE.W  #$0000,$B7AE.W
        DC.W    $603A               ; $0084B6 BRA.S  loc_0084F2
loc_0084B8:
        DC.W    $4EBA,$0054         ; $0084B8 JSR     loc_00850E(PC)
        DC.W    $43F9,$00FF,$68F8   ; $0084BC LEA     $00FF68F8,A1
        DC.W    $237C,$0403,$4070,$FFFC; $0084C2 MOVE.L  #$04034070,-$0004(A1)
        DC.W    $1340,$FFF9         ; $0084CA MOVE.B  D0,-$0007(A1)
        DC.W    $12C1               ; $0084CE MOVE.B  D1,(A1)+
        DC.W    $4EBA,$FEC8         ; $0084D0 JSR     loc_00839A(PC)
loc_0084D4:
        DC.W    $4A78,$B7AE         ; $0084D4 TST.W  $B7AE.W
        DC.W    $6718               ; $0084D8 BEQ.S  loc_0084F2
        DC.W    $7E00               ; $0084DA MOVEQ   #$00,D7
        DC.W    $5378,$B7AE         ; $0084DC SUBQ.W  #1,$B7AE.W
        DC.W    $670A               ; $0084E0 BEQ.S  loc_0084EC
        DC.W    $0838,$0002,$C8AB   ; $0084E2 BTST    #2,$C8AB.W
        DC.W    $6602               ; $0084E8 BNE.S  loc_0084EC
        DC.W    $7E03               ; $0084EA MOVEQ   #$03,D7
loc_0084EC:
        DC.W    $13C7,$00FF,$68F0   ; $0084EC MOVE.B  D7,$00FF68F0
loc_0084F2:
        DC.W    $4E75               ; $0084F2 RTS
loc_0084F4:
        DC.W    $5341               ; $0084F4 SUBQ.W  #1,D1
        DC.W    $E549               ; $0084F6 LSL.W  #2,D1
        DC.W    $2A32,$1000         ; $0084F8 MOVE.L  $00(A2,D1.W),D5
        DC.W    $2833,$1000         ; $0084FC MOVE.L  $00(A3,D1.W),D4
        DC.W    $6708               ; $008500 BEQ.S  loc_00850A
        DC.W    $BA84               ; $008502 CMP.L  D4,D5
        DC.W    $6D04               ; $008504 BLT.S  loc_00850A
        DC.W    $7000               ; $008506 MOVEQ   #$00,D0
        DC.W    $4E75               ; $008508 RTS
loc_00850A:
        DC.W    $7001               ; $00850A MOVEQ   #$01,D0
        DC.W    $4E75               ; $00850C RTS
loc_00850E:
        DC.W    $0C85,$6000,$0000   ; $00850E CMPI.L  #$60000000,D5
        DC.W    $6D0C               ; $008514 BLT.S  loc_008522
        DC.W    $28BC,$DDDD,$0DDD   ; $008516 MOVE.L  #$DDDD0DDD,(A4)
        DC.W    $7001               ; $00851C MOVEQ   #$01,D0
        DC.W    $7200               ; $00851E MOVEQ   #$00,D1
        DC.W    $4E75               ; $008520 RTS
loc_008522:
        DC.W    $BA84               ; $008522 CMP.L  D4,D5
        DC.W    $6612               ; $008524 BNE.S  loc_008538
        DC.W    $28BC,$0000,$0000   ; $008526 MOVE.L  #$00000000,(A4)
        DC.W    $720E               ; $00852C MOVEQ   #$0E,D1
        DC.W    $7000               ; $00852E MOVEQ   #$00,D0
        DC.W    $4E75               ; $008530 RTS
        DC.W    $0C80,$003C,$0000   ; $008532 CMPI.L  #$003C0000,D0
loc_008538:
        DC.W    $2885               ; $008538 MOVE.L  D5,(A4)
        DC.W    $2944,$0004         ; $00853A MOVE.L  D4,$0004(A4)
        DC.W    $4EBA,$2F38         ; $00853E JSR     $00B478(PC)
        DC.W    $7001               ; $008542 MOVEQ   #$01,D0
        DC.W    $720C               ; $008544 MOVEQ   #$0C,D1
        DC.W    $4E75               ; $008546 RTS
        DC.W    $4A68,$0098         ; $008548 TST.W  $0098(A0)
        DC.W    $6F04               ; $00854C BLE.S  loc_008552
        DC.W    $5368,$0098         ; $00854E SUBQ.W  #1,$0098(A0)
loc_008552:
        DC.W    $4A68,$009A         ; $008552 TST.W  $009A(A0)
        DC.W    $6F04               ; $008556 BLE.S  loc_00855C
        DC.W    $5368,$009A         ; $008558 SUBQ.W  #1,$009A(A0)
loc_00855C:
        DC.W    $4A68,$0086         ; $00855C TST.W  $0086(A0)
        DC.W    $6F04               ; $008560 BLE.S  loc_008566
        DC.W    $5368,$0086         ; $008562 SUBQ.W  #1,$0086(A0)
loc_008566:
        DC.W    $4A68,$0080         ; $008566 TST.W  $0080(A0)
        DC.W    $6F04               ; $00856A BLE.S  loc_008570
        DC.W    $5368,$0080         ; $00856C SUBQ.W  #1,$0080(A0)
loc_008570:
        DC.W    $4A68,$0082         ; $008570 TST.W  $0082(A0)
        DC.W    $6F04               ; $008574 BLE.S  loc_00857A
        DC.W    $5368,$0082         ; $008576 SUBQ.W  #1,$0082(A0)
loc_00857A:
        DC.W    $4A68,$0084         ; $00857A TST.W  $0084(A0)
        DC.W    $6F04               ; $00857E BLE.S  loc_008584
        DC.W    $5368,$0084         ; $008580 SUBQ.W  #1,$0084(A0)
loc_008584:
        DC.W    $4A68,$00E6         ; $008584 TST.W  $00E6(A0)
        DC.W    $6F04               ; $008588 BLE.S  loc_00858E
        DC.W    $5368,$00E6         ; $00858A SUBQ.W  #1,$00E6(A0)
loc_00858E:
        DC.W    $4A68,$00E8         ; $00858E TST.W  $00E8(A0)
        DC.W    $6F04               ; $008592 BLE.S  loc_008598
        DC.W    $5368,$00E8         ; $008594 SUBQ.W  #1,$00E8(A0)
loc_008598:
        DC.W    $4E75               ; $008598 RTS
        DC.W    $3028,$0004         ; $00859A MOVE.W  $0004(A0),D0
        DC.W    $48C0               ; $00859E EXT.L   D0
        DC.W    $7206               ; $0085A0 MOVEQ   #$06,D1
        DC.W    $E3A8               ; $0085A2 LSL.L  D1,D0
        DC.W    $6A02               ; $0085A4 BPL.S  loc_0085A8
        DC.W    $7000               ; $0085A6 MOVEQ   #$00,D0
loc_0085A8:
        DC.W    $0C80,$0000,$1900   ; $0085A8 CMPI.L  #$00001900,D0
        DC.W    $650E               ; $0085AE BCS.S  loc_0085BE
        DC.W    $E588               ; $0085B0 LSL.L  #2,D0
        DC.W    $0C80,$0000,$7000   ; $0085B2 CMPI.L  #$00007000,D0
        DC.W    $6504               ; $0085B8 BCS.S  loc_0085BE
        DC.W    $303C,$7080         ; $0085BA MOVE.W  #$7080,D0
loc_0085BE:
        DC.W    $9168,$00BC         ; $0085BE SUB.W  D0,$00BC(A0)
        DC.W    $4E75               ; $0085C2 RTS
        DC.W    $4A38,$C8A2         ; $0085C4 TST.B  $C8A2.W
        DC.W    $670C               ; $0085C8 BEQ.S  loc_0085D6
        DC.W    $5338,$C8A2         ; $0085CA SUBQ.B  #1,$C8A2.W
        DC.W    $6606               ; $0085CE BNE.S  loc_0085D6
        DC.W    $11FC,$0000,$C8A6   ; $0085D0 MOVE.B  #$0000,$C8A6.W
loc_0085D6:
        DC.W    $3028,$0094         ; $0085D6 MOVE.W  $0094(A0),D0
        DC.W    $6A02               ; $0085DA BPL.S  loc_0085DE
        DC.W    $4440               ; $0085DC NEG.W  D0
loc_0085DE:
        DC.W    $0C40,$0010         ; $0085DE CMPI.W  #$0010,D0
        DC.W    $6F1C               ; $0085E2 BLE.S  loc_008600
        DC.W    $0C40,$0020         ; $0085E4 CMPI.W  #$0020,D0
        DC.W    $6F24               ; $0085E8 BLE.S  loc_00860E
        DC.W    $0C38,$00BD,$C8A6   ; $0085EA CMPI.B  #$00BD,$C8A6.W
        DC.W    $671C               ; $0085F0 BEQ.S  loc_00860E
        DC.W    $11FC,$00BD,$C8A4   ; $0085F2 MOVE.B  #$00BD,$C8A4.W
        DC.W    $11FC,$0020,$C8A2   ; $0085F8 MOVE.B  #$0020,$C8A2.W
        DC.W    $4E75               ; $0085FE RTS
loc_008600:
        DC.W    $0C38,$00BD,$C8A6   ; $008600 CMPI.B  #$00BD,$C8A6.W
        DC.W    $6606               ; $008606 BNE.S  loc_00860E
        DC.W    $11FC,$00C8,$C8A4   ; $008608 MOVE.B  #$00C8,$C8A4.W
loc_00860E:
        DC.W    $4E75               ; $00860E RTS
        DC.W    $4A38,$C8A2         ; $008610 TST.B  $C8A2.W
        DC.W    $670C               ; $008614 BEQ.S  loc_008622
        DC.W    $5338,$C8A2         ; $008616 SUBQ.B  #1,$C8A2.W
        DC.W    $6606               ; $00861A BNE.S  loc_008622
        DC.W    $11FC,$0000,$C8A6   ; $00861C MOVE.B  #$0000,$C8A6.W
loc_008622:
        DC.W    $3038,$9094         ; $008622 MOVE.W  $9094.W,D0
        DC.W    $6A02               ; $008626 BPL.S  loc_00862A
        DC.W    $4440               ; $008628 NEG.W  D0
loc_00862A:
        DC.W    $3438,$9F94         ; $00862A MOVE.W  $9F94.W,D2
        DC.W    $6A02               ; $00862E BPL.S  loc_008632
        DC.W    $4442               ; $008630 NEG.W  D2
loc_008632:
        DC.W    $0C40,$0010         ; $008632 CMPI.W  #$0010,D0
        DC.W    $6E0E               ; $008636 BGT.S  loc_008646
        DC.W    $0C42,$0010         ; $008638 CMPI.W  #$0010,D2
        DC.W    $6F24               ; $00863C BLE.S  loc_008662
loc_00863E:
        DC.W    $0C42,$0020         ; $00863E CMPI.W  #$0020,D2
        DC.W    $6E08               ; $008642 BGT.S  loc_00864C
        DC.W    $4E75               ; $008644 RTS
loc_008646:
        DC.W    $0C40,$0020         ; $008646 CMPI.W  #$0020,D0
        DC.W    $6FF2               ; $00864A BLE.S  loc_00863E
loc_00864C:
        DC.W    $0C38,$00BD,$C8A6   ; $00864C CMPI.B  #$00BD,$C8A6.W
        DC.W    $671C               ; $008652 BEQ.S  loc_008670
        DC.W    $11FC,$00BD,$C8A4   ; $008654 MOVE.B  #$00BD,$C8A4.W
        DC.W    $11FC,$0020,$C8A2   ; $00865A MOVE.B  #$0020,$C8A2.W
        DC.W    $4E75               ; $008660 RTS
loc_008662:
        DC.W    $0C38,$00BD,$C8A6   ; $008662 CMPI.B  #$00BD,$C8A6.W
        DC.W    $6606               ; $008668 BNE.S  loc_008670
        DC.W    $11FC,$00C8,$C8A4   ; $00866A MOVE.B  #$00C8,$C8A4.W
loc_008670:
        DC.W    $4E75               ; $008670 RTS
        DC.W    $383C,$0100         ; $008672 MOVE.W  #$0100,D4
        DC.W    $3A3C,$0200         ; $008676 MOVE.W  #$0200,D5
        DC.W    $3C3C,$1000         ; $00867A MOVE.W  #$1000,D6
        DC.W    $337C,$0000,$00C0   ; $00867E MOVE.W  #$0000,$00C0(A1)
        DC.W    $3429,$0030         ; $008684 MOVE.W  $0030(A1),D2
        DC.W    $3829,$0034         ; $008688 MOVE.W  $0034(A1),D4
        DC.W    $9468,$0030         ; $00868C SUB.W  $0030(A0),D2
        DC.W    $6A02               ; $008690 BPL.S  loc_008694
        DC.W    $4442               ; $008692 NEG.W  D2
loc_008694:
        DC.W    $B446               ; $008694 CMP.W  D6,D2
        DC.W    $6E2E               ; $008696 BGT.S  loc_0086C6
        DC.W    $9868,$0034         ; $008698 SUB.W  $0034(A0),D4
        DC.W    $6A02               ; $00869C BPL.S  loc_0086A0
        DC.W    $4444               ; $00869E NEG.W  D4
loc_0086A0:
        DC.W    $B846               ; $0086A0 CMP.W  D6,D4
        DC.W    $6E22               ; $0086A2 BGT.S  loc_0086C6
        DC.W    $337C,$0003,$00C0   ; $0086A4 MOVE.W  #$0003,$00C0(A1)
        DC.W    $B445               ; $0086AA CMP.W  D5,D2
        DC.W    $6E18               ; $0086AC BGT.S  loc_0086C6
        DC.W    $B845               ; $0086AE CMP.W  D5,D4
        DC.W    $6E14               ; $0086B0 BGT.S  loc_0086C6
        DC.W    $337C,$0002,$00C0   ; $0086B2 MOVE.W  #$0002,$00C0(A1)
        DC.W    $B444               ; $0086B8 CMP.W  D4,D2
        DC.W    $6E0A               ; $0086BA BGT.S  loc_0086C6
        DC.W    $B844               ; $0086BC CMP.W  D4,D4
        DC.W    $6E06               ; $0086BE BGT.S  loc_0086C6
        DC.W    $337C,$0001,$00C0   ; $0086C0 MOVE.W  #$0001,$00C0(A1)
loc_0086C6:
        DC.W    $4E75               ; $0086C6 RTS
        DC.W    $3028,$0030         ; $0086C8 MOVE.W  $0030(A0),D0
        DC.W    $3228,$0034         ; $0086CC MOVE.W  $0034(A0),D1
        DC.W    $4A78,$C0BA         ; $0086D0 TST.W  $C0BA.W
        DC.W    $6708               ; $0086D4 BEQ.S  loc_0086DE
        DC.W    $3038,$C0BA         ; $0086D6 MOVE.W  $C0BA.W,D0
        DC.W    $3238,$C0BE         ; $0086DA MOVE.W  $C0BE.W,D1
loc_0086DE:
        DC.W    $283C,$0140,$01C0   ; $0086DE MOVE.L  #$014001C0,D4
        DC.W    $3A3C,$0400         ; $0086E4 MOVE.W  #$0400,D5
        DC.W    $3C3C,$0800         ; $0086E8 MOVE.W  #$0800,D6
        DC.W    $0838,$0000,$C313   ; $0086EC BTST    #0,$C313.W
        DC.W    $6620               ; $0086F2 BNE.S  loc_008714
        DC.W    $3A3C,$0800         ; $0086F4 MOVE.W  #$0800,D5
        DC.W    $3C3C,$0FA0         ; $0086F8 MOVE.W  #$0FA0,D6
        DC.W    $6016               ; $0086FC BRA.S  loc_008714
        DC.W    $3028,$0030         ; $0086FE MOVE.W  $0030(A0),D0
        DC.W    $3228,$0034         ; $008702 MOVE.W  $0034(A0),D1
        DC.W    $283C,$0140,$01C0   ; $008706 MOVE.L  #$014001C0,D4
        DC.W    $3A3C,$02C0         ; $00870C MOVE.W  #$02C0,D5
        DC.W    $3C3C,$1000         ; $008710 MOVE.W  #$1000,D6
loc_008714:
        DC.W    $7E0E               ; $008714 MOVEQ   #$0E,D7
        DC.W    $43F8,$9100         ; $008716 LEA     $9100.W,A1
loc_00871A:
        DC.W    $337C,$0000,$00C0   ; $00871A MOVE.W  #$0000,$00C0(A1)
        DC.W    $3429,$0030         ; $008720 MOVE.W  $0030(A1),D2
        DC.W    $9440               ; $008724 SUB.W  D0,D2
        DC.W    $6A02               ; $008726 BPL.S  loc_00872A
        DC.W    $4442               ; $008728 NEG.W  D2
loc_00872A:
        DC.W    $B446               ; $00872A CMP.W  D6,D2
        DC.W    $6E42               ; $00872C BGT.S  loc_008770
        DC.W    $3629,$0034         ; $00872E MOVE.W  $0034(A1),D3
        DC.W    $9641               ; $008732 SUB.W  D1,D3
        DC.W    $6A02               ; $008734 BPL.S  loc_008738
        DC.W    $4443               ; $008736 NEG.W  D3
loc_008738:
        DC.W    $B646               ; $008738 CMP.W  D6,D3
        DC.W    $6E34               ; $00873A BGT.S  loc_008770
        DC.W    $337C,$0003,$00C0   ; $00873C MOVE.W  #$0003,$00C0(A1)
        DC.W    $B445               ; $008742 CMP.W  D5,D2
        DC.W    $6E2A               ; $008744 BGT.S  loc_008770
        DC.W    $B645               ; $008746 CMP.W  D5,D3
        DC.W    $6E26               ; $008748 BGT.S  loc_008770
        DC.W    $337C,$0002,$00C0   ; $00874A MOVE.W  #$0002,$00C0(A1)
        DC.W    $B444               ; $008750 CMP.W  D4,D2
        DC.W    $6E1C               ; $008752 BGT.S  loc_008770
        DC.W    $B644               ; $008754 CMP.W  D4,D3
        DC.W    $6E18               ; $008756 BGT.S  loc_008770
        DC.W    $337C,$8002,$00C0   ; $008758 MOVE.W  #$8002,$00C0(A1)
        DC.W    $4844               ; $00875E SWAP    D4
        DC.W    $B444               ; $008760 CMP.W  D4,D2
        DC.W    $6E0A               ; $008762 BGT.S  loc_00876E
        DC.W    $B644               ; $008764 CMP.W  D4,D3
        DC.W    $6E06               ; $008766 BGT.S  loc_00876E
        DC.W    $337C,$8001,$00C0   ; $008768 MOVE.W  #$8001,$00C0(A1)
loc_00876E:
        DC.W    $4844               ; $00876E SWAP    D4
loc_008770:
        DC.W    $43E9,$0100         ; $008770 LEA     $0100(A1),A1
        DC.W    $51CF,$FFA4         ; $008774 DBRA    D7,loc_00871A
        DC.W    $4E75               ; $008778 RTS
        DC.W    $3028,$0030         ; $00877A MOVE.W  $0030(A0),D0
        DC.W    $3228,$0034         ; $00877E MOVE.W  $0034(A0),D1
        DC.W    $383C,$0140         ; $008782 MOVE.W  #$0140,D4
        DC.W    $3A3C,$02C0         ; $008786 MOVE.W  #$02C0,D5
        DC.W    $3C3C,$1000         ; $00878A MOVE.W  #$1000,D6
        DC.W    $7E0E               ; $00878E MOVEQ   #$0E,D7
        DC.W    $43F8,$9100         ; $008790 LEA     $9100.W,A1
loc_008794:
        DC.W    $337C,$0000,$00C0   ; $008794 MOVE.W  #$0000,$00C0(A1)
        DC.W    $3429,$0030         ; $00879A MOVE.W  $0030(A1),D2
        DC.W    $9440               ; $00879E SUB.W  D0,D2
        DC.W    $6A02               ; $0087A0 BPL.S  loc_0087A4
        DC.W    $4442               ; $0087A2 NEG.W  D2
loc_0087A4:
        DC.W    $B446               ; $0087A4 CMP.W  D6,D2
        DC.W    $6E30               ; $0087A6 BGT.S  loc_0087D8
        DC.W    $3629,$0034         ; $0087A8 MOVE.W  $0034(A1),D3
        DC.W    $9641               ; $0087AC SUB.W  D1,D3
        DC.W    $6A02               ; $0087AE BPL.S  loc_0087B2
        DC.W    $4443               ; $0087B0 NEG.W  D3
loc_0087B2:
        DC.W    $B646               ; $0087B2 CMP.W  D6,D3
        DC.W    $6E22               ; $0087B4 BGT.S  loc_0087D8
        DC.W    $337C,$0003,$00C0   ; $0087B6 MOVE.W  #$0003,$00C0(A1)
        DC.W    $B445               ; $0087BC CMP.W  D5,D2
        DC.W    $6E18               ; $0087BE BGT.S  loc_0087D8
        DC.W    $B645               ; $0087C0 CMP.W  D5,D3
        DC.W    $6E14               ; $0087C2 BGT.S  loc_0087D8
        DC.W    $337C,$0002,$00C0   ; $0087C4 MOVE.W  #$0002,$00C0(A1)
        DC.W    $B444               ; $0087CA CMP.W  D4,D2
        DC.W    $6E0A               ; $0087CC BGT.S  loc_0087D8
        DC.W    $B644               ; $0087CE CMP.W  D4,D3
        DC.W    $6E06               ; $0087D0 BGT.S  loc_0087D8
        DC.W    $337C,$8001,$00C0   ; $0087D2 MOVE.W  #$8001,$00C0(A1)
loc_0087D8:
        DC.W    $43E9,$0100         ; $0087D8 LEA     $0100(A1),A1
        DC.W    $51CF,$FFB6         ; $0087DC DBRA    D7,loc_008794
        DC.W    $4E75               ; $0087E0 RTS
        DC.W    $41F8,$9000         ; $0087E2 LEA     $9000.W,A0
        DC.W    $45F8,$9F00         ; $0087E6 LEA     $9F00.W,A2
        DC.W    $3028,$002E         ; $0087EA MOVE.W  $002E(A0),D0
        DC.W    $E148               ; $0087EE LSL.W  #8,D0
        DC.W    $D068,$0024         ; $0087F0 ADD.W  $0024(A0),D0
        DC.W    $322A,$002E         ; $0087F4 MOVE.W  $002E(A2),D1
        DC.W    $E149               ; $0087F8 LSL.W  #8,D1
        DC.W    $D26A,$0024         ; $0087FA ADD.W  $0024(A2),D1
        DC.W    $7402               ; $0087FE MOVEQ   #$02,D2
        DC.W    $7601               ; $008800 MOVEQ   #$01,D3
        DC.W    $B240               ; $008802 CMP.W  D0,D1
        DC.W    $6E52               ; $008804 BGT.S  loc_008858
        DC.W    $664C               ; $008806 BNE.S  loc_008854
        DC.W    $3028,$001E         ; $008808 MOVE.W  $001E(A0),D0
        DC.W    $4440               ; $00880C NEG.W  D0
        DC.W    $3400               ; $00880E MOVE.W  D0,D2
        DC.W    $4EBA,$0740         ; $008810 JSR     $008F52(PC)
        DC.W    $E840               ; $008814 ASR.W  #4,D0
        DC.W    $C1E8,$0030         ; $008816 MULS    $0030(A0),D0
        DC.W    $2800               ; $00881A MOVE.L  D0,D4
        DC.W    $3002               ; $00881C MOVE.W  D2,D0
        DC.W    $4EBA,$072E         ; $00881E JSR     $008F4E(PC)
        DC.W    $E840               ; $008822 ASR.W  #4,D0
        DC.W    $C1E8,$0034         ; $008824 MULS    $0034(A0),D0
        DC.W    $D880               ; $008828 ADD.L  D0,D4
        DC.W    $302A,$001E         ; $00882A MOVE.W  $001E(A2),D0
        DC.W    $4440               ; $00882E NEG.W  D0
        DC.W    $3400               ; $008830 MOVE.W  D0,D2
        DC.W    $4EBA,$071E         ; $008832 JSR     $008F52(PC)
        DC.W    $E840               ; $008836 ASR.W  #4,D0
        DC.W    $C1EA,$0030         ; $008838 MULS    $0030(A2),D0
        DC.W    $2600               ; $00883C MOVE.L  D0,D3
        DC.W    $3002               ; $00883E MOVE.W  D2,D0
        DC.W    $4EBA,$070C         ; $008840 JSR     $008F4E(PC)
        DC.W    $E840               ; $008844 ASR.W  #4,D0
        DC.W    $C1EA,$0034         ; $008846 MULS    $0034(A2),D0
        DC.W    $D083               ; $00884A ADD.L  D3,D0
        DC.W    $7402               ; $00884C MOVEQ   #$02,D2
        DC.W    $7601               ; $00884E MOVEQ   #$01,D3
        DC.W    $B084               ; $008850 CMP.L  D4,D0
        DC.W    $6E04               ; $008852 BGT.S  loc_008858
loc_008854:
        DC.W    $7401               ; $008854 MOVEQ   #$01,D2
        DC.W    $7602               ; $008856 MOVEQ   #$02,D3
loc_008858:
        DC.W    $B468,$002A         ; $008858 CMP.W  $002A(A0),D2
        DC.W    $6756               ; $00885C BEQ.S  loc_0088B4
        DC.W    $3828,$0004         ; $00885E MOVE.W  $0004(A0),D4
        DC.W    $986A,$0004         ; $008862 SUB.W  $0004(A2),D4
        DC.W    $6A02               ; $008866 BPL.S  loc_00886A
        DC.W    $4444               ; $008868 NEG.W  D4
loc_00886A:
        DC.W    $0C44,$0014         ; $00886A CMPI.W  #$0014,D4
        DC.W    $6F44               ; $00886E BLE.S  loc_0088B4
        DC.W    $3828,$0004         ; $008870 MOVE.W  $0004(A0),D4
        DC.W    $D86A,$0004         ; $008874 ADD.W  $0004(A2),D4
        DC.W    $0C44,$0064         ; $008878 CMPI.W  #$0064,D4
        DC.W    $6F36               ; $00887C BLE.S  loc_0088B4
        DC.W    $0C78,$0004,$C89C   ; $00887E CMPI.W  #$0004,$C89C.W
        DC.W    $660C               ; $008884 BNE.S  loc_008892
        DC.W    $1228,$00E5         ; $008886 MOVE.B  $00E5(A0),D1
        DC.W    $B302               ; $00888A EOR.B  D1,D2
        DC.W    $0202,$0006         ; $00888C ANDI.B  #$0006,D2
        DC.W    $6622               ; $008890 BNE.S  loc_0088B4
loc_008892:
        DC.W    $11FC,$00CC,$C8A4   ; $008892 MOVE.B  #$00CC,$C8A4.W
        DC.W    $0C78,$0001,$C8C8   ; $008898 CMPI.W  #$0001,$C8C8.W
        DC.W    $6714               ; $00889E BEQ.S  loc_0088B4
        DC.W    $11FC,$00CF,$C8A4   ; $0088A0 MOVE.B  #$00CF,$C8A4.W
        DC.W    $0C78,$0002,$C8C8   ; $0088A6 CMPI.W  #$0002,$C8C8.W
        DC.W    $6706               ; $0088AC BEQ.S  loc_0088B4
        DC.W    $11FC,$00B3,$C8A4   ; $0088AE MOVE.B  #$00B3,$C8A4.W
loc_0088B4:
        DC.W    $3142,$002A         ; $0088B4 MOVE.W  D2,$002A(A0)
        DC.W    $3543,$002A         ; $0088B8 MOVE.W  D3,$002A(A2)
        DC.W    $4E75               ; $0088BC RTS
        DC.W    $1038,$C86D         ; $0088BE MOVE.B  $C86D.W,D0
        DC.W    $0200,$0060         ; $0088C2 ANDI.B  #$0060,D0
        DC.W    $6706               ; $0088C6 BEQ.S  loc_0088CE
        DC.W    $0878,$0000,$C313   ; $0088C8 BCHG    #0,$C313.W
loc_0088CE:
        DC.W    $41F8,$9000         ; $0088CE LEA     $9000.W,A0
        DC.W    $0838,$0000,$C313   ; $0088D2 BTST    #0,$C313.W
        DC.W    $6700,$00EA         ; $0088D8 BEQ.W  loc_0089C4
        DC.W    $08F8,$0003,$C313   ; $0088DC BSET    #3,$C313.W
        DC.W    $31FC,$0000,$C0C8   ; $0088E2 MOVE.W  #$0000,$C0C8.W
        DC.W    $0838,$0000,$C86C   ; $0088E8 BTST    #0,$C86C.W
        DC.W    $667E               ; $0088EE BNE.S  loc_00896E
        DC.W    $0838,$0001,$C86C   ; $0088F0 BTST    #1,$C86C.W
        DC.W    $6600,$00A0         ; $0088F6 BNE.W  loc_008998
        DC.W    $31FC,$0010,$C8E0   ; $0088FA MOVE.W  #$0010,$C8E0.W
loc_008900:
        DC.W    $3038,$C8D8         ; $008900 MOVE.W  $C8D8.W,D0
        DC.W    $0C40,$3000         ; $008904 CMPI.W  #$3000,D0
        DC.W    $6E1C               ; $008908 BGT.S  loc_008926
        DC.W    $672E               ; $00890A BEQ.S  loc_00893A
        DC.W    $31FC,$07D0,$C8D4   ; $00890C MOVE.W  #$07D0,$C8D4.W
        DC.W    $33FC,$0200,$00FF,$60CC; $008912 MOVE.W  #$0200,$00FF60CC
        DC.W    $E648               ; $00891A LSR.W  #3,D0
        DC.W    $0440,$00A0         ; $00891C SUBI.W  #$00A0,D0
        DC.W    $31C0,$C8D6         ; $008920 MOVE.W  D0,$C8D6.W
        DC.W    $601C               ; $008924 BRA.S  loc_008942
loc_008926:
        DC.W    $31FC,$0600,$C8D6   ; $008926 MOVE.W  #$0600,$C8D6.W
        DC.W    $7209               ; $00892C MOVEQ   #$09,D1
        DC.W    $E268               ; $00892E LSR.W  D1,D0
        DC.W    $4440               ; $008930 NEG.W  D0
        DC.W    $0640,$07D0         ; $008932 ADDI.W  #$07D0,D0
        DC.W    $31C0,$C8D4         ; $008936 MOVE.W  D0,$C8D4.W
loc_00893A:
        DC.W    $33FC,$0100,$00FF,$60CC; $00893A MOVE.W  #$0100,$00FF60CC
loc_008942:
        DC.W    $31F8,$C8D4,$C0AE   ; $008942 MOVE.W  $C8D4.W,$C0AE.W
        DC.W    $31FC,$0000,$C0B0   ; $008948 MOVE.W  #$0000,$C0B0.W
        DC.W    $31FC,$0000,$C0B2   ; $00894E MOVE.W  #$0000,$C0B2.W
        DC.W    $31F8,$C8D6,$C054   ; $008954 MOVE.W  $C8D6.W,$C054.W
        DC.W    $31F8,$C8D8,$C056   ; $00895A MOVE.W  $C8D8.W,$C056.W
        DC.W    $31FC,$0000,$C0C6   ; $008960 MOVE.W  #$0000,$C0C6.W
        DC.W    $31FC,$0000,$C0BA   ; $008966 MOVE.W  #$0000,$C0BA.W
        DC.W    $4E75               ; $00896C RTS
loc_00896E:
        DC.W    $3038,$C8E0         ; $00896E MOVE.W  $C8E0.W,D0
        DC.W    $D040               ; $008972 ADD.W  D0,D0
        DC.W    $0C40,$0400         ; $008974 CMPI.W  #$0400,D0
        DC.W    $6F04               ; $008978 BLE.S  loc_00897E
        DC.W    $303C,$0400         ; $00897A MOVE.W  #$0400,D0
loc_00897E:
        DC.W    $31C0,$C8E0         ; $00897E MOVE.W  D0,$C8E0.W
        DC.W    $D078,$C8D8         ; $008982 ADD.W  $C8D8.W,D0
        DC.W    $0C40,$7800         ; $008986 CMPI.W  #$7800,D0
        DC.W    $6F04               ; $00898A BLE.S  loc_008990
        DC.W    $303C,$7800         ; $00898C MOVE.W  #$7800,D0
loc_008990:
        DC.W    $31C0,$C8D8         ; $008990 MOVE.W  D0,$C8D8.W
        DC.W    $6000,$FF6A         ; $008994 BRA.W  loc_008900
loc_008998:
        DC.W    $3038,$C8E0         ; $008998 MOVE.W  $C8E0.W,D0
        DC.W    $D040               ; $00899C ADD.W  D0,D0
        DC.W    $0C40,$0400         ; $00899E CMPI.W  #$0400,D0
        DC.W    $6F04               ; $0089A2 BLE.S  loc_0089A8
        DC.W    $303C,$0400         ; $0089A4 MOVE.W  #$0400,D0
loc_0089A8:
        DC.W    $31C0,$C8E0         ; $0089A8 MOVE.W  D0,$C8E0.W
        DC.W    $4440               ; $0089AC NEG.W  D0
        DC.W    $D078,$C8D8         ; $0089AE ADD.W  $C8D8.W,D0
        DC.W    $0C40,$0500         ; $0089B2 CMPI.W  #$0500,D0
        DC.W    $6C04               ; $0089B6 BGE.S  loc_0089BC
        DC.W    $303C,$0500         ; $0089B8 MOVE.W  #$0500,D0
loc_0089BC:
        DC.W    $31C0,$C8D8         ; $0089BC MOVE.W  D0,$C8D8.W
        DC.W    $6000,$FF3E         ; $0089C0 BRA.W  loc_008900
loc_0089C4:
        DC.W    $0838,$0004,$C86D   ; $0089C4 BTST    #4,$C86D.W
        DC.W    $670C               ; $0089CA BEQ.S  loc_0089D8
        DC.W    $0878,$0002,$C313   ; $0089CC BCHG    #2,$C313.W
        DC.W    $08B8,$0004,$C313   ; $0089D2 BCLR    #4,$C313.W
loc_0089D8:
        DC.W    $31FC,$00C0,$C0C8   ; $0089D8 MOVE.W  #$00C0,$C0C8.W
        DC.W    $33FC,$0100,$00FF,$60CC; $0089DE MOVE.W  #$0100,$00FF60CC
        DC.W    $31F8,$C8DA,$C0AE   ; $0089E6 MOVE.W  $C8DA.W,$C0AE.W
        DC.W    $31FC,$0000,$C0B0   ; $0089EC MOVE.W  #$0000,$C0B0.W
        DC.W    $31FC,$0000,$C0B2   ; $0089F2 MOVE.W  #$0000,$C0B2.W
        DC.W    $31F8,$C8DC,$C054   ; $0089F8 MOVE.W  $C8DC.W,$C054.W
        DC.W    $31F8,$C8DE,$C056   ; $0089FE MOVE.W  $C8DE.W,$C056.W
        DC.W    $3038,$C8A0         ; $008A04 MOVE.W  $C8A0.W,D0
        DC.W    $227B,$0004         ; $008A08 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $008A0C JMP     (A1)
        DC.W    $0088,$8A68,$0088   ; $008A0E ORI.L  #$8A680088,A0
        DC.W    $8A26               ; $008A14 OR.B   -(A6),D5
        DC.W    $0088,$8A68,$0088   ; $008A16 ORI.L  #$8A680088,A0
        DC.W    $8A68,$0088         ; $008A1C OR.W   $0088(A0),D5
        DC.W    $8A42               ; $008A20 OR.W   D2,D5
        DC.W    $0088,$8A68,$1028   ; $008A22 ORI.L  #$8A681028,A0
        DC.W    $00E5               ; $008A28 DC.W    $00E5
        DC.W    $0800,$0002         ; $008A2A BTST    #2,D0
        DC.W    $6600,$014C         ; $008A2E BNE.W  loc_008B7C
        DC.W    $0C68,$00E0,$001C   ; $008A32 CMPI.W  #$00E0,$001C(A0)
        DC.W    $6F2E               ; $008A38 BLE.S  loc_008A68
        DC.W    $0200,$0002         ; $008A3A ANDI.B  #$0002,D0
        DC.W    $6600,$013C         ; $008A3E BNE.W  loc_008B7C
        DC.W    $3028,$0024         ; $008A42 MOVE.W  $0024(A0),D0
        DC.W    $0C40,$0042         ; $008A46 CMPI.W  #$0042,D0
        DC.W    $651C               ; $008A4A BCS.S  loc_008A68
        DC.W    $0C40,$0048         ; $008A4C CMPI.W  #$0048,D0
        DC.W    $6416               ; $008A50 BCC.S  loc_008A68
        DC.W    $43FA,$0108         ; $008A52 LEA     $0108(PC),A1
        DC.W    $0838,$0002,$C313   ; $008A56 BTST    #2,$C313.W
        DC.W    $6704               ; $008A5C BEQ.S  loc_008A62
        DC.W    $43FA,$010C         ; $008A5E LEA     $010C(PC),A1
loc_008A62:
        DC.W    $45F8,$C0BA         ; $008A62 LEA     $C0BA.W,A2
        DC.W    $606A               ; $008A66 BRA.S  loc_008AD2
loc_008A68:
        DC.W    $0838,$0004,$C313   ; $008A68 BTST    #4,$C313.W
        DC.W    $6706               ; $008A6E BEQ.S  loc_008A76
        DC.W    $2278,$C288         ; $008A70 MOVEA.L $C288.W,A1
        DC.W    $605C               ; $008A74 BRA.S  loc_008AD2
loc_008A76:
        DC.W    $7000               ; $008A76 MOVEQ   #$00,D0
        DC.W    $0838,$0002,$C313   ; $008A78 BTST    #2,$C313.W
        DC.W    $6702               ; $008A7E BEQ.S  loc_008A82
        DC.W    $7004               ; $008A80 MOVEQ   #$04,D0
loc_008A82:
        DC.W    $43F9,$00FF,$301A   ; $008A82 LEA     $00FF301A,A1
        DC.W    $D078,$C8A0         ; $008A88 ADD.W  $C8A0.W,D0
        DC.W    $D078,$C8A0         ; $008A8C ADD.W  $C8A0.W,D0
        DC.W    $2271,$0000         ; $008A90 MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F8,$C0BA         ; $008A94 LEA     $C0BA.W,A2
        DC.W    $3028,$0030         ; $008A98 MOVE.W  $0030(A0),D0
        DC.W    $3228,$0034         ; $008A9C MOVE.W  $0034(A0),D1
        DC.W    $3C3C,$0640         ; $008AA0 MOVE.W  #$0640,D6
        DC.W    $3E19               ; $008AA4 MOVE.W  (A1)+,D7
loc_008AA6:
        DC.W    $3429,$0000         ; $008AA6 MOVE.W  $0000(A1),D2
        DC.W    $3829,$0004         ; $008AAA MOVE.W  $0004(A1),D4
        DC.W    $3602               ; $008AAE MOVE.W  D2,D3
        DC.W    $9640               ; $008AB0 SUB.W  D0,D3
        DC.W    $6A02               ; $008AB2 BPL.S  loc_008AB6
        DC.W    $4443               ; $008AB4 NEG.W  D3
loc_008AB6:
        DC.W    $B646               ; $008AB6 CMP.W  D6,D3
        DC.W    $6E0C               ; $008AB8 BGT.S  loc_008AC6
        DC.W    $3604               ; $008ABA MOVE.W  D4,D3
        DC.W    $9641               ; $008ABC SUB.W  D1,D3
        DC.W    $6A02               ; $008ABE BPL.S  loc_008AC2
        DC.W    $4443               ; $008AC0 NEG.W  D3
loc_008AC2:
        DC.W    $B646               ; $008AC2 CMP.W  D6,D3
        DC.W    $6F0C               ; $008AC4 BLE.S  loc_008AD2
loc_008AC6:
        DC.W    $43E9,$0010         ; $008AC6 LEA     $0010(A1),A1
        DC.W    $51CF,$FFDA         ; $008ACA DBRA    D7,loc_008AA6
        DC.W    $4EFA,$00AC         ; $008ACE JMP     loc_008B7C(PC)
loc_008AD2:
        DC.W    $08B8,$0003,$C313   ; $008AD2 BCLR    #3,$C313.W
        DC.W    $B3F8,$C288         ; $008AD8 CMPA.L  $C288.W,A1
        DC.W    $6716               ; $008ADC BEQ.S  loc_008AF4
        DC.W    $21C9,$C288         ; $008ADE MOVE.L  A1,$C288.W
        DC.W    $31E9,$0006,$C100   ; $008AE2 MOVE.W  $0006(A1),$C100.W
        DC.W    $31E9,$0008,$C102   ; $008AE8 MOVE.W  $0008(A1),$C102.W
        DC.W    $31E9,$000A,$C104   ; $008AEE MOVE.W  $000A(A1),$C104.W
loc_008AF4:
        DC.W    $3429,$000E         ; $008AF4 MOVE.W  $000E(A1),D2
        DC.W    $0802,$000F         ; $008AF8 BTST    #15,D2
        DC.W    $6706               ; $008AFC BEQ.S  loc_008B04
        DC.W    $08F8,$0003,$C313   ; $008AFE BSET    #3,$C313.W
loc_008B04:
        DC.W    $0242,$7FFF         ; $008B04 ANDI.W  #$7FFF,D2
        DC.W    $24D9               ; $008B08 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $008B0A MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $008B0C MOVE.L  (A1)+,(A2)+
        DC.W    $3491               ; $008B0E MOVE.W  (A1),(A2)
        DC.W    $3011               ; $008B10 MOVE.W  (A1),D0
        DC.W    $D040               ; $008B12 ADD.W  D0,D0
        DC.W    $D179,$00FF,$60CC   ; $008B14 ADD.W  D0,$00FF60CC
        DC.W    $227B,$200C         ; $008B1A MOVEA.L $0C(PC,D2.W),A1
        DC.W    $4E91               ; $008B1E JSR     (A1)
        DC.W    $08B8,$0001,$C313   ; $008B20 BCLR    #1,$C313.W
        DC.W    $4E75               ; $008B26 RTS
        DC.W    $0088,$8D62,$0088   ; $008B28 ORI.L  #$8D620088,A0
        DC.W    $8EB6,$0088         ; $008B2E OR.L   -$78(A6,D0.W),D7
        DC.W    $8ED6               ; $008B32 DIVU    (A6),D7
        DC.W    $0088,$8EF2,$0088   ; $008B34 ORI.L  #$8EF20088,A0
        DC.W    $8EF4,$0088         ; $008B3A DIVU    -$78(A4,D0.W),D7
        DC.W    $8EFC,$0088         ; $008B3E DIVU    #$0088,D7
        DC.W    $8C40               ; $008B42 OR.W   D0,D6
        DC.W    $0088,$8CCE,$0088   ; $008B44 ORI.L  #$8CCE0088,A0
        DC.W    $8B9C               ; $008B4A OR.L   D5,(A4)+
        DC.W    $0088,$8DC0,$0088   ; $008B4C ORI.L  #$8DC00088,A0
        DC.W    $8BC2               ; $008B52 DIVS    D2,D5
        DC.W    $0088,$8BF2,$0088   ; $008B54 ORI.L  #$8BF20088,A0
        DC.W    $8C16               ; $008B5A OR.B   (A6),D6
        DC.W    $FA30,$5800         ; $008B5C MOVE.W  $00(A0,D5.L),D5
        DC.W    $1D58,$0000         ; $008B60 MOVE.B  (A0)+,$0000(A6)
        DC.W    $0000,$0000         ; $008B64 ORI.B  #$0000,D0
        DC.W    $0000,$0024         ; $008B68 ORI.B  #$0024,D0
        DC.W    $ED68               ; $008B6C LSL.W  D6,D0
        DC.W    $4400               ; $008B6E NEG.B  D0
        DC.W    $1E93               ; $008B70 MOVE.B  (A3),(A7)
        DC.W    $0000,$0000         ; $008B72 ORI.B  #$0000,D0
        DC.W    $0000,$0100         ; $008B76 ORI.B  #$0100,D0
        DC.W    $0024,$31FC         ; $008B7A ORI.B  #$31FC,-(A4)
        DC.W    $0000,$C0C6         ; $008B7E ORI.B  #$C0C6,D0
        DC.W    $31FC,$0000,$C0BA   ; $008B82 MOVE.W  #$0000,$C0BA.W
        DC.W    $08F8,$0001,$C313   ; $008B88 BSET    #1,$C313.W
        DC.W    $08B8,$0003,$C313   ; $008B8E BCLR    #3,$C313.W
        DC.W    $11FC,$0000,$C896   ; $008B94 MOVE.B  #$0000,$C896.W
        DC.W    $4E75               ; $008B9A RTS
