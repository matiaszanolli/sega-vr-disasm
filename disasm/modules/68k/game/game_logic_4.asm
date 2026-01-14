; Generated assembly for $00C200-$00D1D4
; Branch targets: 111
; Labels: 61
; Format: DC.W with decoded mnemonics as comments

        org     $00C200

        DC.W    $41F8,$9000         ; $00C200 LEA     $9000.W,A0
        DC.W    $4EBA,$DFF6         ; $00C204 JSR     $00A1FC(PC)
        DC.W    $4EBA,$076A         ; $00C208 JSR     loc_00C974(PC)
        DC.W    $4EBA,$0CFE         ; $00C20C JSR     loc_00CF0C(PC)
        DC.W    $4EBA,$09F4         ; $00C210 JSR     loc_00CC06(PC)
        DC.W    $4EBA,$0D98         ; $00C214 JSR     loc_00CFAE(PC)
        DC.W    $31FC,$0000,$C87E   ; $00C218 MOVE.W  #$0000,$C87E.W
        DC.W    $31FC,$0000,$C8F4   ; $00C21E MOVE.W  #$0000,$C8F4.W
        DC.W    $08B8,$0007,$FEB7   ; $00C224 BCLR    #7,$FEB7.W
        DC.W    $08B8,$0000,$C81C   ; $00C22A BCLR    #0,$C81C.W
        DC.W    $31FC,$C9A0,$C8C0   ; $00C230 MOVE.W  #$C9A0,$C8C0.W
        DC.W    $11FC,$0002,$C80A   ; $00C236 MOVE.B  #$0002,$C80A.W
        DC.W    $4EBA,$049C         ; $00C23C JSR     loc_00C6DA(PC)
        DC.W    $4EBA,$9686         ; $00C240 JSR     $0058C8(PC)
        DC.W    $4EBA,$96C2         ; $00C244 JSR     $005908(PC)
        DC.W    $4EBA,$96F2         ; $00C248 JSR     $00593C(PC)
        DC.W    $0239,$00FC,$00A1,$5181; $00C24C ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $00C254 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $00C25C MOVE.W  #$8083,$00A15100
        DC.W    $4EB9,$0088,$204A   ; $00C264 JSR     $0088204A
        DC.W    $4EB9,$0088,$20C6   ; $00C26A JSR     $008820C6
        DC.W    $08F8,$0006,$C875   ; $00C270 BSET    #6,$C875.W
        DC.W    $3AB8,$C874         ; $00C276 MOVE.W  $C874.W,(A5)
        DC.W    $4EB9,$0088,$4998   ; $00C27A JSR     $00884998
        DC.W    $31FC,$0080,$A000   ; $00C280 MOVE.W  #$0080,$A000.W
        DC.W    $11FC,$00C5,$C8A4   ; $00C286 MOVE.B  #$00C5,$C8A4.W
loc_00C28C:
        DC.W    $4EB9,$0088,$2080   ; $00C28C JSR     $00882080
        DC.W    $4EB9,$0088,$4998   ; $00C292 JSR     $00884998
        DC.W    $5378,$A000         ; $00C298 SUBQ.W  #1,$A000.W
        DC.W    $66EE               ; $00C29C BNE.S  loc_00C28C
        DC.W    $3038,$C8A0         ; $00C29E MOVE.W  $C8A0.W,D0
        DC.W    $41F9,$008B,$B1C4   ; $00C2A2 LEA     $008BB1C4,A0
        DC.W    $21F0,$0000,$C96C   ; $00C2A8 MOVE.L  $00(A0,D0.W),$C96C.W
        DC.W    $11FC,$0001,$C809   ; $00C2AE MOVE.B  #$0001,$C809.W
        DC.W    $08F8,$0006,$C80E   ; $00C2B4 BSET    #6,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00C2BA MOVE.B  #$0001,$C802.W
loc_00C2C0:
        DC.W    $0839,$0000,$00A1,$5123; $00C2C0 BTST    #0,$00A15123
        DC.W    $67F6               ; $00C2C8 BEQ.S  loc_00C2C0
        DC.W    $08B9,$0000,$00A1,$5123; $00C2CA BCLR    #0,$00A15123
        DC.W    $31FC,$0102,$C8A8   ; $00C2D2 MOVE.W  #$0102,$C8A8.W
        DC.W    $11FC,$009C,$C8A5   ; $00C2D8 MOVE.B  #$009C,$C8A5.W
        DC.W    $4EB9,$0088,$2080   ; $00C2DE JSR     $00882080
        DC.W    $4EB9,$0088,$4998   ; $00C2E4 JSR     $00884998
        DC.W    $23FC,$0088,$C30A,$00FF,$0002; $00C2EA MOVE.L  #$0088C30A,$00FF0002
        DC.W    $23FC,$0000,$0000,$00FF,$5FF8; $00C2F4 MOVE.L  #$00000000,$00FF5FF8
        DC.W    $23FC,$0000,$0000,$00FF,$5FFC; $00C2FE MOVE.L  #$00000000,$00FF5FFC
        DC.W    $4E75               ; $00C308 RTS
        DC.W    $3038,$C87E         ; $00C30A MOVE.W  $C87E.W,D0
        DC.W    $227B,$0004         ; $00C30E MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00C312 JMP     (A1)
        DC.W    $0088,$C328,$0088   ; $00C314 ORI.L  #$C3280088,A0
        DC.W    $C368,$0088         ; $00C31A AND.W  D1,$0088(A0)
        DC.W    $C390               ; $00C31E AND.L  D1,(A0)
        DC.W    $0088,$C3FC,$0088   ; $00C320 ORI.L  #$C3FC0088,A0
        DC.W    $C45E               ; $00C326 AND.W  (A6)+,D2
        DC.W    $4EB9,$0088,$28C2   ; $00C328 JSR     $008828C2
        DC.W    $4EB9,$0088,$21CA   ; $00C32E JSR     $008821CA
        DC.W    $3F38,$C86C         ; $00C334 MOVE.W  $C86C.W,-(A7)
        DC.W    $31FC,$FF00,$C86C   ; $00C338 MOVE.W  #$FF00,$C86C.W
        DC.W    $0838,$0000,$C81C   ; $00C33E BTST    #0,$C81C.W
        DC.W    $6606               ; $00C344 BNE.S  loc_00C34C
        DC.W    $4EB9,$0088,$88BE   ; $00C346 JSR     $008888BE
loc_00C34C:
        DC.W    $31DF,$C86C         ; $00C34C MOVE.W  (A7)+,$C86C.W
        DC.W    $4EB9,$0088,$58C8   ; $00C350 JSR     $008858C8
        DC.W    $5238,$C886         ; $00C356 ADDQ.B  #1,$C886.W
        DC.W    $5878,$C87E         ; $00C35A ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $00C35E MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $00C366 RTS
        DC.W    $4EB9,$0088,$21CA   ; $00C368 JSR     $008821CA
        DC.W    $4EB9,$0088,$25B0   ; $00C36E JSR     $008825B0
        DC.W    $4EBA,$F6A2         ; $00C374 JSR     $00BA18(PC)
        DC.W    $4EB9,$0088,$5908   ; $00C378 JSR     $00885908
        DC.W    $5238,$C886         ; $00C37E ADDQ.B  #1,$C886.W
        DC.W    $5878,$C87E         ; $00C382 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0010,$00FF,$0008; $00C386 MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $00C38E RTS
        DC.W    $4EB9,$0088,$21CA   ; $00C390 JSR     $008821CA
        DC.W    $4EB9,$0088,$179E   ; $00C396 JSR     $0088179E
        DC.W    $5278,$C080         ; $00C39C ADDQ.W  #1,$C080.W
        DC.W    $5278,$C8AA         ; $00C3A0 ADDQ.W  #1,$C8AA.W
        DC.W    $21FC,$FFFF,$0000,$C970; $00C3A4 MOVE.L  #$FFFF0000,$C970.W
        DC.W    $3078,$C8C0         ; $00C3AC MOVEA.W $C8C0.W,A0
        DC.W    $1018               ; $00C3B0 MOVE.B  (A0)+,D0
        DC.W    $1200               ; $00C3B2 MOVE.B  D0,D1
        DC.W    $0200,$005C         ; $00C3B4 ANDI.B  #$005C,D0
        DC.W    $11C0,$C971         ; $00C3B8 MOVE.B  D0,$C971.W
        DC.W    $0201,$0003         ; $00C3BC ANDI.B  #$0003,D1
        DC.W    $11C1,$C973         ; $00C3C0 MOVE.B  D1,$C973.W
        DC.W    $31C8,$C8C0         ; $00C3C4 MOVE.W  A0,$C8C0.W
        DC.W    $4EB9,$0088,$593C   ; $00C3C8 JSR     $0088593C
        DC.W    $4EB9,$0088,$24CA   ; $00C3CE JSR     $008824CA
        DC.W    $4EBA,$F304         ; $00C3D4 JSR     $00B6DA(PC)
        DC.W    $4EBA,$F2AA         ; $00C3D8 JSR     $00B684(PC)
        DC.W    $5238,$C886         ; $00C3DC ADDQ.B  #1,$C886.W
        DC.W    $5878,$C87E         ; $00C3E0 ADDQ.W  #4,$C87E.W
        DC.W    $33FC,$0038,$00FF,$0008; $00C3E4 MOVE.W  #$0038,$00FF0008
        DC.W    $4EBA,$0028         ; $00C3EC JSR     loc_00C416(PC)
        DC.W    $4EBA,$01BC         ; $00C3F0 JSR     loc_00C5AE(PC)
        DC.W    $4EBA,$FC7A         ; $00C3F4 JSR     $00C070(PC)
        DC.W    $4EFA,$0268         ; $00C3F8 JMP     loc_00C662(PC)
        DC.W    $4EB9,$0088,$21CA   ; $00C3FC JSR     $008821CA
        DC.W    $4EB9,$0088,$179E   ; $00C402 JSR     $0088179E
        DC.W    $5238,$C886         ; $00C408 ADDQ.B  #1,$C886.W
        DC.W    $33FC,$0038,$00FF,$0008; $00C40C MOVE.W  #$0038,$00FF0008
        DC.W    $4E75               ; $00C414 RTS
loc_00C416:
        DC.W    $7000               ; $00C416 MOVEQ   #$00,D0
        DC.W    $1038,$C8F5         ; $00C418 MOVE.B  $C8F5.W,D0
        DC.W    $303B,$002E         ; $00C41C MOVE.W  $2E(PC,D0.W),D0
        DC.W    $B078,$C080         ; $00C420 CMP.W  $C080.W,D0
        DC.W    $6624               ; $00C424 BNE.S  loc_00C44A
        DC.W    $4EB9,$0088,$49AA   ; $00C426 JSR     $008849AA
        DC.W    $31FC,$0010,$C87E   ; $00C42C MOVE.W  #$0010,$C87E.W
        DC.W    $31FC,$0C00,$C8C4   ; $00C432 MOVE.W  #$0C00,$C8C4.W
        DC.W    $11FC,$0004,$C082   ; $00C438 MOVE.B  #$0004,$C082.W
        DC.W    $5438,$C8F5         ; $00C43E ADDQ.B  #2,$C8F5.W
        DC.W    $33FC,$0044,$00FF,$0008; $00C442 MOVE.W  #$0044,$00FF0008
loc_00C44A:
        DC.W    $4E75               ; $00C44A RTS
        DC.W    $0089,$0117,$016A   ; $00C44C ORI.L  #$0117016A,A1
        DC.W    $01E0               ; $00C452 BSET    D0,-(A0)
        DC.W    $025E,$02E2         ; $00C454 ANDI.W  #$02E2,(A6)+
        DC.W    $034D               ; $00C458 BCHG    D1,A5
        DC.W    $1000               ; $00C45A MOVE.B  D0,D0
        DC.W    $1000               ; $00C45C MOVE.B  D0,D0
        DC.W    $4EB9,$0088,$21CA   ; $00C45E JSR     $008821CA
        DC.W    $7000               ; $00C464 MOVEQ   #$00,D0
        DC.W    $1038,$C8C4         ; $00C466 MOVE.B  $C8C4.W,D0
        DC.W    $227B,$0004         ; $00C46A MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00C46E JMP     (A1)
        DC.W    $0088,$C480,$0088   ; $00C470 ORI.L  #$C4800088,A0
        DC.W    $C4A4               ; $00C476 AND.L  -(A4),D2
        DC.W    $0088,$C4C2,$0088   ; $00C478 ORI.L  #$C4C20088,A0
        DC.W    $C53C,$4EB9         ; $00C47E AND.B  D2,#$4EB9
        DC.W    $0088,$28C2,$4EB9   ; $00C482 ORI.L  #$28C24EB9,A0
        DC.W    $0088,$25B0,$4EB9   ; $00C488 ORI.L  #$25B04EB9,A0
        DC.W    $0088,$6D9C,$5238   ; $00C48E ORI.L  #$6D9C5238,A0
        DC.W    $C886               ; $00C494 AND.L  D6,D4
        DC.W    $5838,$C8C4         ; $00C496 ADDQ.B  #4,$C8C4.W
        DC.W    $33FC,$0010,$00FF,$0008; $00C49A MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $00C4A2 RTS
        DC.W    $4EB9,$0088,$BA18   ; $00C4A4 JSR     $0088BA18
        DC.W    $4EB9,$0088,$6DC8   ; $00C4AA JSR     $00886DC8
        DC.W    $5238,$C886         ; $00C4B0 ADDQ.B  #1,$C886.W
        DC.W    $5838,$C8C4         ; $00C4B4 ADDQ.B  #4,$C8C4.W
        DC.W    $33FC,$0010,$00FF,$0008; $00C4B8 MOVE.W  #$0010,$00FF0008
        DC.W    $4E75               ; $00C4C0 RTS
        DC.W    $4EB9,$0088,$179E   ; $00C4C2 JSR     $0088179E
        DC.W    $5278,$C080         ; $00C4C8 ADDQ.W  #1,$C080.W
        DC.W    $5278,$C8AA         ; $00C4CC ADDQ.W  #1,$C8AA.W
        DC.W    $21FC,$FFFF,$0000,$C970; $00C4D0 MOVE.L  #$FFFF0000,$C970.W
        DC.W    $3078,$C8C0         ; $00C4D8 MOVEA.W $C8C0.W,A0
        DC.W    $1018               ; $00C4DC MOVE.B  (A0)+,D0
        DC.W    $1200               ; $00C4DE MOVE.B  D0,D1
        DC.W    $0200,$005C         ; $00C4E0 ANDI.B  #$005C,D0
        DC.W    $11C0,$C971         ; $00C4E4 MOVE.B  D0,$C971.W
        DC.W    $0201,$0003         ; $00C4E8 ANDI.B  #$0003,D1
        DC.W    $11C1,$C973         ; $00C4EC MOVE.B  D1,$C973.W
        DC.W    $31C8,$C8C0         ; $00C4F0 MOVE.W  A0,$C8C0.W
        DC.W    $4EB9,$0088,$6DF0   ; $00C4F4 JSR     $00886DF0
        DC.W    $4EB9,$0088,$24CA   ; $00C4FA JSR     $008824CA
        DC.W    $5238,$C886         ; $00C500 ADDQ.B  #1,$C886.W
        DC.W    $5838,$C8C4         ; $00C504 ADDQ.B  #4,$C8C4.W
        DC.W    $33FC,$0044,$00FF,$0008; $00C508 MOVE.W  #$0044,$00FF0008
        DC.W    $7000               ; $00C510 MOVEQ   #$00,D0
        DC.W    $1038,$C082         ; $00C512 MOVE.B  $C082.W,D0
        DC.W    $227B,$0014         ; $00C516 MOVEA.L $14(PC,D0.W),A1
        DC.W    $4E91               ; $00C51A JSR     (A1)
        DC.W    $4EBA,$FB52         ; $00C51C JSR     $00C070(PC)
        DC.W    $4EBA,$F1B8         ; $00C520 JSR     $00B6DA(PC)
        DC.W    $4EBA,$F15E         ; $00C524 JSR     $00B684(PC)
        DC.W    $4EFA,$0138         ; $00C528 JMP     loc_00C662(PC)
        DC.W    $0088,$C542,$0088   ; $00C52C ORI.L  #$C5420088,A0
        DC.W    $C544               ; $00C532 AND.W  D2,D4
        DC.W    $0088,$C586,$0088   ; $00C534 ORI.L  #$C5860088,A0
        DC.W    $C592               ; $00C53A AND.L  D2,(A2)
        DC.W    $5238,$C886         ; $00C53C ADDQ.B  #1,$C886.W
        DC.W    $4E75               ; $00C540 RTS
        DC.W    $4E75               ; $00C542 RTS
        DC.W    $5838,$C082         ; $00C544 ADDQ.B  #4,$C082.W
        DC.W    $7000               ; $00C548 MOVEQ   #$00,D0
        DC.W    $1038,$C8F5         ; $00C54A MOVE.B  $C8F5.W,D0
        DC.W    $E248               ; $00C54E LSR.W  #1,D0
        DC.W    $5340               ; $00C550 SUBQ.W  #1,D0
        DC.W    $11FB,$0016,$C083   ; $00C552 MOVE.B  $16(PC,D0.W),$C083.W
        DC.W    $D040               ; $00C558 ADD.W  D0,D0
        DC.W    $31FB,$0018,$C0FC   ; $00C55A MOVE.W  $18(PC,D0.W),$C0FC.W
        DC.W    $33FC,$0034,$00FF,$0008; $00C560 MOVE.W  #$0034,$00FF0008
        DC.W    $4E75               ; $00C568 RTS
        DC.W    $283C,$6464,$6450   ; $00C56A MOVE.L  #$64646450,D4
        DC.W    $6478               ; $00C570 BCC.S  loc_00C5EA
        DC.W    $5000               ; $00C572 ADDQ.B  #8,D0
        DC.W    $0001,$0002         ; $00C574 ORI.B  #$0002,D1
        DC.W    $0003,$0004         ; $00C578 ORI.B  #$0004,D3
        DC.W    $0005,$0006         ; $00C57C ORI.B  #$0006,D5
        DC.W    $0007,$0008         ; $00C580 ORI.B  #$0008,D7
        DC.W    $0000,$5338         ; $00C584 ORI.B  #$5338,D0
        DC.W    $C083               ; $00C588 AND.L  D3,D0
        DC.W    $6604               ; $00C58A BNE.S  loc_00C590
        DC.W    $5838,$C082         ; $00C58C ADDQ.B  #4,$C082.W
loc_00C590:
        DC.W    $4E75               ; $00C590 RTS
        DC.W    $33FC,$003C,$00FF,$0008; $00C592 MOVE.W  #$003C,$00FF0008
        DC.W    $11FC,$0000,$C082   ; $00C59A MOVE.B  #$0000,$C082.W
        DC.W    $31FC,$0000,$C0FC   ; $00C5A0 MOVE.W  #$0000,$C0FC.W
        DC.W    $11FC,$0018,$C8C5   ; $00C5A6 MOVE.B  #$0018,$C8C5.W
        DC.W    $4E75               ; $00C5AC RTS
loc_00C5AE:
        DC.W    $3038,$C080         ; $00C5AE MOVE.W  $C080.W,D0
        DC.W    $0C40,$03E3         ; $00C5B2 CMPI.W  #$03E3,D0
        DC.W    $6D00,$00A8         ; $00C5B6 BLT.W  loc_00C660
        DC.W    $0C40,$03E3         ; $00C5BA CMPI.W  #$03E3,D0
        DC.W    $6658               ; $00C5BE BNE.S  loc_00C618
        DC.W    $08F8,$0000,$C81C   ; $00C5C0 BSET    #0,$C81C.W
        DC.W    $31FC,$00C0,$C0C8   ; $00C5C6 MOVE.W  #$00C0,$C0C8.W
        DC.W    $33FC,$0100,$00FF,$60CC; $00C5CC MOVE.W  #$0100,$00FF60CC
        DC.W    $31F8,$C8DA,$C0AE   ; $00C5D4 MOVE.W  $C8DA.W,$C0AE.W
        DC.W    $31FC,$0000,$C0B0   ; $00C5DA MOVE.W  #$0000,$C0B0.W
        DC.W    $31FC,$0000,$C0B2   ; $00C5E0 MOVE.W  #$0000,$C0B2.W
        DC.W    $31F8,$C8DC,$C054   ; $00C5E6 MOVE.W  $C8DC.W,$C054.W
        DC.W    $31F8,$C8DE,$C056   ; $00C5EC MOVE.W  $C8DE.W,$C056.W
        DC.W    $31FC,$0000,$C0C6   ; $00C5F2 MOVE.W  #$0000,$C0C6.W
        DC.W    $31FC,$0000,$C0BA   ; $00C5F8 MOVE.W  #$0000,$C0BA.W
        DC.W    $08F8,$0001,$C313   ; $00C5FE BSET    #1,$C313.W
        DC.W    $08B8,$0003,$C313   ; $00C604 BCLR    #3,$C313.W
        DC.W    $11FC,$0000,$C896   ; $00C60A MOVE.B  #$0000,$C896.W
        DC.W    $31FC,$0008,$C0FC   ; $00C610 MOVE.W  #$0008,$C0FC.W
        DC.W    $4E75               ; $00C616 RTS
loc_00C618:
        DC.W    $5478,$C0C6         ; $00C618 ADDQ.W  #2,$C0C6.W
        DC.W    $0C78,$0030,$C0C6   ; $00C61C CMPI.W  #$0030,$C0C6.W
        DC.W    $6F06               ; $00C622 BLE.S  loc_00C62A
        DC.W    $31FC,$0030,$C0C6   ; $00C624 MOVE.W  #$0030,$C0C6.W
loc_00C62A:
        DC.W    $0678,$0080,$C0B0   ; $00C62A ADDI.W  #$0080,$C0B0.W
        DC.W    $0C78,$1000,$C0B0   ; $00C630 CMPI.W  #$1000,$C0B0.W
        DC.W    $6F06               ; $00C636 BLE.S  loc_00C63E
        DC.W    $31FC,$1000,$C0B0   ; $00C638 MOVE.W  #$1000,$C0B0.W
loc_00C63E:
        DC.W    $0C78,$04D9,$C080   ; $00C63E CMPI.W  #$04D9,$C080.W
        DC.W    $6606               ; $00C644 BNE.S  loc_00C64C
        DC.W    $4EB9,$0088,$2066   ; $00C646 JSR     $00882066
loc_00C64C:
        DC.W    $0C78,$0510,$C080   ; $00C64C CMPI.W  #$0510,$C080.W
        DC.W    $6D0C               ; $00C652 BLT.S  loc_00C660
        DC.W    $4A38,$C8F4         ; $00C654 TST.B  $C8F4.W
        DC.W    $6606               ; $00C658 BNE.S  loc_00C660
        DC.W    $11FC,$0004,$C8F4   ; $00C65A MOVE.B  #$0004,$C8F4.W
loc_00C660:
        DC.W    $4E75               ; $00C660 RTS
loc_00C662:
        DC.W    $7000               ; $00C662 MOVEQ   #$00,D0
        DC.W    $1038,$C8F4         ; $00C664 MOVE.B  $C8F4.W,D0
        DC.W    $227B,$0004         ; $00C668 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00C66C JMP     (A1)
        DC.W    $0088,$C67E,$0088   ; $00C66E ORI.L  #$C67E0088,A0
        DC.W    $C680               ; $00C674 AND.L  D0,D3
        DC.W    $0088,$C6A4,$0088   ; $00C676 ORI.L  #$C6A40088,A0
        DC.W    $C6B6,$4E75         ; $00C67C AND.L  $75(A6,D4.L),D3
        DC.W    $11FC,$0001,$C809   ; $00C680 MOVE.B  #$0001,$C809.W
        DC.W    $11FC,$0001,$C80A   ; $00C686 MOVE.B  #$0001,$C80A.W
        DC.W    $08F8,$0007,$C80E   ; $00C68C BSET    #7,$C80E.W
        DC.W    $11FC,$0001,$C802   ; $00C692 MOVE.B  #$0001,$C802.W
        DC.W    $11FC,$00F3,$C822   ; $00C698 MOVE.B  #$00F3,$C822.W
        DC.W    $5838,$C8F4         ; $00C69E ADDQ.B  #4,$C8F4.W
        DC.W    $4E75               ; $00C6A2 RTS
        DC.W    $0838,$0007,$C80E   ; $00C6A4 BTST    #7,$C80E.W
        DC.W    $6608               ; $00C6AA BNE.S  loc_00C6B4
        DC.W    $3ABC,$8B00         ; $00C6AC MOVE.W  #$8B00,(A5)
        DC.W    $5838,$C8F4         ; $00C6B0 ADDQ.B  #4,$C8F4.W
loc_00C6B4:
        DC.W    $4E75               ; $00C6B4 RTS
        DC.W    $11FC,$0000,$C8F4   ; $00C6B6 MOVE.B  #$0000,$C8F4.W
        DC.W    $08B8,$0007,$C81C   ; $00C6BC BCLR    #7,$C81C.W
        DC.W    $23FC,$0089,$4262,$00FF,$0002; $00C6C2 MOVE.L  #$00894262,$00FF0002
        DC.W    $33FC,$0020,$00FF,$0008; $00C6CC MOVE.W  #$0020,$00FF0008
        DC.W    $4EF9,$0088,$2890   ; $00C6D4 JMP     $00882890
loc_00C6DA:
        DC.W    $43F9,$008B,$B45C   ; $00C6DA LEA     $008BB45C,A1
        DC.W    $45F8,$B000         ; $00C6E0 LEA     $B000.W,A2
        DC.W    $4EBA,$8204         ; $00C6E4 JSR     $0048EA(PC)
        DC.W    $43F9,$008B,$AFC4   ; $00C6E8 LEA     $008BAFC4,A1
        DC.W    $45F8,$B400         ; $00C6EE LEA     $B400.W,A2
        DC.W    $4EBA,$81DE         ; $00C6F2 JSR     $0048D2(PC)
        DC.W    $43F9,$008B,$A220   ; $00C6F6 LEA     $008BA220,A1
        DC.W    $3038,$C8A0         ; $00C6FC MOVE.W  $C8A0.W,D0
        DC.W    $2271,$0000         ; $00C700 MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F9,$00FF,$6E00   ; $00C704 LEA     $00FF6E00,A2
        DC.W    $4EBA,$81C6         ; $00C70A JSR     $0048D2(PC)
        DC.W    $43F9,$008B,$AE38   ; $00C70E LEA     $008BAE38,A1
        DC.W    $3038,$C8CC         ; $00C714 MOVE.W  $C8CC.W,D0
        DC.W    $2271,$0000         ; $00C718 MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F9,$00FF,$6E40   ; $00C71C LEA     $00FF6E40,A2
        DC.W    $4EBA,$81C6         ; $00C722 JSR     $0048EA(PC)
        DC.W    $11FC,$0003,$C80A   ; $00C726 MOVE.B  #$0003,$C80A.W
        DC.W    $45F8,$C200         ; $00C72C LEA     $C200.W,A2
        DC.W    $43F8,$EEE0         ; $00C730 LEA     $EEE0.W,A1
        DC.W    $4EB9,$0088,$4920   ; $00C734 JSR     $00884920
        DC.W    $21F8,$EEFC,$C254   ; $00C73A MOVE.L  $EEFC.W,$C254.W
        DC.W    $31FC,$00C0,$C054   ; $00C740 MOVE.W  #$00C0,$C054.W
        DC.W    $31FC,$0540,$C056   ; $00C746 MOVE.W  #$0540,$C056.W
        DC.W    $31FC,$0000,$C896   ; $00C74C MOVE.W  #$0000,$C896.W
        DC.W    $4EBA,$A808         ; $00C752 JSR     $006F5C(PC)
        DC.W    $4EBA,$C166         ; $00C756 JSR     $0088BE(PC)
        DC.W    $31FC,$00C0,$C0C8   ; $00C75A MOVE.W  #$00C0,$C0C8.W
        DC.W    $31FC,$07D0,$C8D4   ; $00C760 MOVE.W  #$07D0,$C8D4.W
        DC.W    $31FC,$0600,$C8D6   ; $00C766 MOVE.W  #$0600,$C8D6.W
        DC.W    $31FC,$3000,$C8D8   ; $00C76C MOVE.W  #$3000,$C8D8.W
        DC.W    $31FC,$0000,$C8DA   ; $00C772 MOVE.W  #$0000,$C8DA.W
        DC.W    $31FC,$00C0,$C8DC   ; $00C778 MOVE.W  #$00C0,$C8DC.W
        DC.W    $31FC,$0540,$C8DE   ; $00C77E MOVE.W  #$0540,$C8DE.W
        DC.W    $48E7,$FFFE         ; $00C784 MOVEM.L -(A7),D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6/A7
        DC.W    $7200               ; $00C788 MOVEQ   #$00,D1
        DC.W    $43FA,$0036         ; $00C78A LEA     $0036(PC),A1
        DC.W    $45F8,$9100         ; $00C78E LEA     $9100.W,A2
        DC.W    $700E               ; $00C792 MOVEQ   #$0E,D0
loc_00C794:
        DC.W    $3551,$00B6         ; $00C794 MOVE.W  (A1),$00B6(A2)
        DC.W    $3559,$000A         ; $00C798 MOVE.W  (A1)+,$000A(A2)
        DC.W    $45EA,$0100         ; $00C79C LEA     $0100(A2),A2
        DC.W    $51C8,$FFF2         ; $00C7A0 DBRA    D0,loc_00C794
        DC.W    $21FC,$0088,$C7E0,$C280; $00C7A4 MOVE.L  #$0088C7E0,$C280.W
        DC.W    $41F9,$0093,$C0EC   ; $00C7AC LEA     $0093C0EC,A0
        DC.W    $3278,$C8C0         ; $00C7B2 MOVEA.W $C8C0.W,A1
        DC.W    $4EB9,$0088,$13B4   ; $00C7B6 JSR     $008813B4
        DC.W    $4CDF,$7FFF         ; $00C7BC MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,(A7)+
        DC.W    $4E75               ; $00C7C0 RTS
        DC.W    $04A9,$0483,$0471,$046E; $00C7C2 SUBI.L  #$04830471,$046E(A1)
        DC.W    $0462,$0456         ; $00C7CA SUBI.W  #$0456,-(A2)
        DC.W    $0444,$0433         ; $00C7CE SUBI.W  #$0433,D4
        DC.W    $0429,$040E,$03F3   ; $00C7D2 SUBI.B  #$040E,$03F3(A1)
        DC.W    $03E2               ; $00C7D8 BSET    D1,-(A2)
        DC.W    $03D7               ; $00C7DA BSET    D1,(A7)
        DC.W    $03C1               ; $00C7DC BSET    D1,D1
        DC.W    $03C0               ; $00C7DE BSET    D1,D0
        DC.W    $003A,$0050,$0064   ; $00C7E0 ORI.B  #$0050,$0064(PC)
        DC.W    $0083,$41F9,$0089   ; $00C7E6 ORI.L  #$41F90089,D3
        DC.W    $AF3C,$43F8,$EF08   ; $00C7EC MOVE.L  #$43F8EF08,-(A7)
        DC.W    $4EB9,$0088,$13B4   ; $00C7F2 JSR     $008813B4
        DC.W    $43F9,$0089,$B6AC   ; $00C7F8 LEA     $0089B6AC,A1
        DC.W    $45F8,$FA48         ; $00C7FE LEA     $FA48.W,A2
        DC.W    $4EBA,$80E6         ; $00C802 JSR     $0048EA(PC)
        DC.W    $4EBA,$811A         ; $00C806 JSR     $004922(PC)
        DC.W    $43F9,$0089,$B73C   ; $00C80A LEA     $0089B73C,A1
        DC.W    $45F8,$FDAA         ; $00C810 LEA     $FDAA.W,A2
        DC.W    $7E35               ; $00C814 MOVEQ   #$35,D7
loc_00C816:
        DC.W    $24D9               ; $00C816 MOVE.L  (A1)+,(A2)+
        DC.W    $51CF,$FFFC         ; $00C818 DBRA    D7,loc_00C816
        DC.W    $7000               ; $00C81C MOVEQ   #$00,D0
        DC.W    $11C0,$FEA5         ; $00C81E MOVE.B  D0,$FEA5.W
        DC.W    $11C0,$FEA6         ; $00C822 MOVE.B  D0,$FEA6.W
        DC.W    $11C0,$FEAB         ; $00C826 MOVE.B  D0,$FEAB.W
        DC.W    $11C0,$FEA7         ; $00C82A MOVE.B  D0,$FEA7.W
        DC.W    $11C0,$FDA8         ; $00C82E MOVE.B  D0,$FDA8.W
        DC.W    $11C0,$EF07         ; $00C832 MOVE.B  D0,$EF07.W
        DC.W    $11C0,$FEB7         ; $00C836 MOVE.B  D0,$FEB7.W
        DC.W    $11C0,$FEB1         ; $00C83A MOVE.B  D0,$FEB1.W
        DC.W    $11FC,$0002,$FEAD   ; $00C83E MOVE.B  #$0002,$FEAD.W
        DC.W    $11FC,$0002,$FEAE   ; $00C844 MOVE.B  #$0002,$FEAE.W
        DC.W    $11FC,$00FF,$FEA4   ; $00C84A MOVE.B  #$00FF,$FEA4.W
        DC.W    $11FC,$0000,$C825   ; $00C850 MOVE.B  #$0000,$C825.W
        DC.W    $4EF9,$0088,$A83E   ; $00C856 JMP     $0088A83E
loc_00C85C:
        DC.W    $7200               ; $00C85C MOVEQ   #$00,D1
        DC.W    $43F9,$00FF,$6000   ; $00C85E LEA     $00FF6000,A1
        DC.W    $4EB9,$0088,$4836   ; $00C864 JSR     $00884836
        DC.W    $4EF9,$0088,$483E   ; $00C86A JMP     $0088483E
        DC.W    $61EA               ; $00C870 BSR.S  loc_00C85C
        DC.W    $3038,$C8CC         ; $00C872 MOVE.W  $C8CC.W,D0
        DC.W    $43F9,$0089,$5488   ; $00C876 LEA     $00895488,A1
        DC.W    $2271,$0000         ; $00C87C MOVEA.L $00(A1,D0.W),A1
        DC.W    $4A38,$C80F         ; $00C880 TST.B  $C80F.W
        DC.W    $6720               ; $00C884 BEQ.S  loc_00C8A6
        DC.W    $43F9,$0089,$5560   ; $00C886 LEA     $00895560,A1
        DC.W    $2271,$0000         ; $00C88C MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F9,$00FF,$6330   ; $00C890 LEA     $00FF6330,A2
        DC.W    $4EB9,$0088,$4920   ; $00C896 JSR     $00884920
        DC.W    $43F9,$0089,$54F4   ; $00C89C LEA     $008954F4,A1
        DC.W    $2271,$0000         ; $00C8A2 MOVEA.L $00(A1,D0.W),A1
loc_00C8A6:
        DC.W    $45F9,$00FF,$6100   ; $00C8A6 LEA     $00FF6100,A2
        DC.W    $4EB9,$0088,$4920   ; $00C8AC JSR     $00884920
        DC.W    $31D9,$C054         ; $00C8B2 MOVE.W  (A1)+,$C054.W
        DC.W    $31D9,$C056         ; $00C8B6 MOVE.W  (A1)+,$C056.W
        DC.W    $21D9,$C0C8         ; $00C8BA MOVE.L  (A1)+,$C0C8.W
        DC.W    $31D9,$C0CC         ; $00C8BE MOVE.W  (A1)+,$C0CC.W
        DC.W    $33D1,$00FF,$60CC   ; $00C8C2 MOVE.W  (A1),$00FF60CC
        DC.W    $33FC,$0070,$00FF,$60CE; $00C8C8 MOVE.W  #$0070,$00FF60CE
        DC.W    $43F8,$C0AE         ; $00C8D0 LEA     $C0AE.W,A1
        DC.W    $7200               ; $00C8D4 MOVEQ   #$00,D1
        DC.W    $22C1               ; $00C8D6 MOVE.L  D1,(A1)+
        DC.W    $22C1               ; $00C8D8 MOVE.L  D1,(A1)+
        DC.W    $2281               ; $00C8DA MOVE.L  D1,(A1)
        DC.W    $21FC,$00FF,$9000,$C888; $00C8DC MOVE.L  #$00FF9000,$C888.W
        DC.W    $4E75               ; $00C8E4 RTS
        DC.W    $5400               ; $00C8E6 ADDQ.B  #2,D0
        DC.W    $5500               ; $00C8E8 SUBQ.B  #2,D0
        DC.W    $5A00               ; $00C8EA ADDQ.B  #5,D0
        DC.W    $5B00               ; $00C8EC SUBQ.B  #5,D0
        DC.W    $4A00               ; $00C8EE TST.B  D0
        DC.W    $4B00               ; $00C8F0 DC.W    $4B00
        DC.W    $3038,$C8CC         ; $00C8F2 MOVE.W  $C8CC.W,D0
        DC.W    $33FB,$00EE,$00FF,$6122; $00C8F6 MOVE.W  -$12(PC,D0.W),$00FF6122
        DC.W    $33FB,$00E8,$00FF,$6352; $00C8FE MOVE.W  -$18(PC,D0.W),$00FF6352
        DC.W    $43F9,$0089,$57A0   ; $00C906 LEA     $008957A0,A1
        DC.W    $6154               ; $00C90C BSR.S  loc_00C962
        DC.W    $43F9,$00FF,$6114   ; $00C90E LEA     $00FF6114,A1
        DC.W    $49F9,$0089,$57A0   ; $00C914 LEA     $008957A0,A4
        DC.W    $616A               ; $00C91A BSR.S  loc_00C986
        DC.W    $4EBA,$0090         ; $00C91C JSR     loc_00C9AE(PC)
        DC.W    $43F9,$00FF,$6218   ; $00C920 LEA     $00FF6218,A1
        DC.W    $49F9,$0089,$57A0   ; $00C926 LEA     $008957A0,A4
        DC.W    $6158               ; $00C92C BSR.S  loc_00C986
        DC.W    $23F8,$C754,$00FF,$6228; $00C92E MOVE.L  $C754.W,$00FF6228
        DC.W    $43F9,$00FF,$6344   ; $00C936 LEA     $00FF6344,A1
        DC.W    $49F9,$0089,$57A0   ; $00C93C LEA     $008957A0,A4
        DC.W    $6142               ; $00C942 BSR.S  loc_00C986
        DC.W    $6168               ; $00C944 BSR.S  loc_00C9AE
        DC.W    $23F8,$C754,$00FF,$6354; $00C946 MOVE.L  $C754.W,$00FF6354
        DC.W    $43F9,$00FF,$6448   ; $00C94E LEA     $00FF6448,A1
        DC.W    $49F9,$0089,$57A0   ; $00C954 LEA     $008957A0,A4
        DC.W    $602A               ; $00C95A BRA.S  loc_00C986
loc_00C95C:
        DC.W    $43F9,$0089,$56C8   ; $00C95C LEA     $008956C8,A1
loc_00C962:
        DC.W    $3038,$C8CC         ; $00C962 MOVE.W  $C8CC.W,D0
        DC.W    $2271,$0000         ; $00C966 MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F8,$C710         ; $00C96A LEA     $C710.W,A2
        DC.W    $4EF9,$0088,$48FE   ; $00C96E JMP     $008848FE
loc_00C974:
        DC.W    $61E6               ; $00C974 BSR.S  loc_00C95C
        DC.W    $43F9,$00FF,$6114   ; $00C976 LEA     $00FF6114,A1
        DC.W    $6102               ; $00C97C BSR.S  loc_00C980
        DC.W    $602E               ; $00C97E BRA.S  loc_00C9AE
loc_00C980:
        DC.W    $49F9,$0089,$56C8   ; $00C980 LEA     $008956C8,A4
loc_00C986:
        DC.W    $2678,$C734         ; $00C986 MOVEA.L $C734.W,A3
        DC.W    $3038,$C8CC         ; $00C98A MOVE.W  $C8CC.W,D0
        DC.W    $2874,$0000         ; $00C98E MOVEA.L $00(A4,D0.W),A4
        DC.W    $7001               ; $00C992 MOVEQ   #$01,D0
        DC.W    $3280               ; $00C994 MOVE.W  D0,(A1)
        DC.W    $43E9,$0010         ; $00C996 LEA     $0010(A1),A1
        DC.W    $22DC               ; $00C99A MOVE.L  (A4)+,(A1)+
        DC.W    $6104               ; $00C99C BSR.S  loc_00C9A2
        DC.W    $6102               ; $00C99E BSR.S  loc_00C9A2
        DC.W    $4E71               ; $00C9A0 NOP
loc_00C9A2:
        DC.W    $32C0               ; $00C9A2 MOVE.W  D0,(A1)+
        DC.W    $22DB               ; $00C9A4 MOVE.L  (A3)+,(A1)+
        DC.W    $32DB               ; $00C9A6 MOVE.W  (A3)+,(A1)+
        DC.W    $5089               ; $00C9A8 ADDQ.L  #8,A1
        DC.W    $22DC               ; $00C9AA MOVE.L  (A4)+,(A1)+
        DC.W    $4E75               ; $00C9AC RTS
loc_00C9AE:
        DC.W    $3280               ; $00C9AE MOVE.W  D0,(A1)
        DC.W    $235C,$0010         ; $00C9B0 MOVE.L  (A4)+,$0010(A1)
        DC.W    $4E75               ; $00C9B4 RTS
        DC.W    $43F9,$0089,$8C80   ; $00C9B6 LEA     $00898C80,A1
        DC.W    $0838,$0003,$C80E   ; $00C9BC BTST    #3,$C80E.W
        DC.W    $6706               ; $00C9C2 BEQ.S  loc_00C9CA
        DC.W    $43F9,$0089,$8F00   ; $00C9C4 LEA     $00898F00,A1
loc_00C9CA:
        DC.W    $45F9,$00FF,$6800   ; $00C9CA LEA     $00FF6800,A2
        DC.W    $701F               ; $00C9D0 MOVEQ   #$1F,D0
loc_00C9D2:
        DC.W    $24D9               ; $00C9D2 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $00C9D4 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $00C9D6 MOVE.L  (A1)+,(A2)+
        DC.W    $24D9               ; $00C9D8 MOVE.L  (A1)+,(A2)+
        DC.W    $51C8,$FFF6         ; $00C9DA DBRA    D0,loc_00C9D2
        DC.W    $4E75               ; $00C9DE RTS
        DC.W    $43F9,$0089,$9500   ; $00C9E0 LEA     $00899500,A1
        DC.W    $45F9,$00FF,$6800   ; $00C9E6 LEA     $00FF6800,A2
        DC.W    $701F               ; $00C9EC MOVEQ   #$1F,D0
        DC.W    $60E2               ; $00C9EE BRA.S  loc_00C9D2
        DC.W    $43F9,$0089,$9100   ; $00C9F0 LEA     $00899100,A1
        DC.W    $45F9,$00FF,$6800   ; $00C9F6 LEA     $00FF6800,A2
        DC.W    $701F               ; $00C9FC MOVEQ   #$1F,D0
        DC.W    $60D2               ; $00C9FE BRA.S  loc_00C9D2
        DC.W    $43F9,$0089,$9300   ; $00CA00 LEA     $00899300,A1
        DC.W    $45F9,$00FF,$6800   ; $00CA06 LEA     $00FF6800,A2
        DC.W    $701F               ; $00CA0C MOVEQ   #$1F,D0
        DC.W    $60C2               ; $00CA0E BRA.S  loc_00C9D2
        DC.W    $43F9,$0089,$9700   ; $00CA10 LEA     $00899700,A1
        DC.W    $45F9,$00FF,$6800   ; $00CA16 LEA     $00FF6800,A2
        DC.W    $7007               ; $00CA1C MOVEQ   #$07,D0
        DC.W    $60B2               ; $00CA1E BRA.S  loc_00C9D2
        DC.W    $43F9,$0089,$8E80   ; $00CA20 LEA     $00898E80,A1
        DC.W    $45F9,$00FF,$6800   ; $00CA26 LEA     $00FF6800,A2
        DC.W    $7007               ; $00CA2C MOVEQ   #$07,D0
        DC.W    $61A2               ; $00CA2E BSR.S  loc_00C9D2
        DC.W    $7200               ; $00CA30 MOVEQ   #$00,D1
        DC.W    $7017               ; $00CA32 MOVEQ   #$17,D0
loc_00CA34:
        DC.W    $1481               ; $00CA34 MOVE.B  D1,(A2)
        DC.W    $45EA,$0010         ; $00CA36 LEA     $0010(A2),A2
        DC.W    $51C8,$FFF8         ; $00CA3A DBRA    D0,loc_00CA34
        DC.W    $33C1,$00FF,$6740   ; $00CA3E MOVE.W  D1,$00FF6740
        DC.W    $33C1,$00FF,$672C   ; $00CA44 MOVE.W  D1,$00FF672C
        DC.W    $4E75               ; $00CA4A RTS
        DC.W    $13FC,$0004,$00FF,$6920; $00CA4C MOVE.B  #$0004,$00FF6920
        DC.W    $13FC,$0001,$00FF,$6880; $00CA54 MOVE.B  #$0001,$00FF6880
        DC.W    $13FC,$0001,$00FF,$69A0; $00CA5C MOVE.B  #$0001,$00FF69A0
        DC.W    $4E75               ; $00CA64 RTS
        DC.W    $13FC,$0004,$00FF,$6920; $00CA66 MOVE.B  #$0004,$00FF6920
        DC.W    $13FC,$0001,$00FF,$6880; $00CA6E MOVE.B  #$0001,$00FF6880
        DC.W    $13FC,$0001,$00FF,$6800; $00CA76 MOVE.B  #$0001,$00FF6800
        DC.W    $4E75               ; $00CA7E RTS
        DC.W    $13FC,$0004,$00FF,$6910; $00CA80 MOVE.B  #$0004,$00FF6910
        DC.W    $13FC,$0001,$00FF,$6870; $00CA88 MOVE.B  #$0001,$00FF6870
        DC.W    $13FC,$0001,$00FF,$69D0; $00CA90 MOVE.B  #$0001,$00FF69D0
        DC.W    $4E75               ; $00CA98 RTS
        DC.W    $6134               ; $00CA9A BSR.S  loc_00CAD0
        DC.W    $4EFA,$012C         ; $00CA9C JMP     loc_00CBCA(PC)
        DC.W    $612E               ; $00CAA0 BSR.S  loc_00CAD0
        DC.W    $33FC,$004E,$00FF,$6744; $00CAA2 MOVE.W  #$004E,$00FF6744
        DC.W    $3038,$C8C8         ; $00CAAA MOVE.W  $C8C8.W,D0
        DC.W    $6700,$011A         ; $00CAAE BEQ.W  loc_00CBCA
        DC.W    $0C40,$0001         ; $00CAB2 CMPI.W  #$0001,D0
        DC.W    $660C               ; $00CAB6 BNE.S  loc_00CAC4
        DC.W    $33FC,$0050,$00FF,$6744; $00CAB8 MOVE.W  #$0050,$00FF6744
        DC.W    $4EFA,$0108         ; $00CAC0 JMP     loc_00CBCA(PC)
loc_00CAC4:
        DC.W    $33FC,$0050,$00FF,$6744; $00CAC4 MOVE.W  #$0050,$00FF6744
        DC.W    $4EFA,$00FC         ; $00CACC JMP     loc_00CBCA(PC)
loc_00CAD0:
        DC.W    $3038,$C8CC         ; $00CAD0 MOVE.W  $C8CC.W,D0
        DC.W    $43F9,$0089,$8C68   ; $00CAD4 LEA     $00898C68,A1
        DC.W    $23F1,$0000,$00FF,$6858; $00CADA MOVE.L  $00(A1,D0.W),$00FF6858
        DC.W    $43FA,$0012         ; $00CAE2 LEA     $0012(PC),A1
        DC.W    $2271,$0000         ; $00CAE6 MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F9,$00FF,$6740   ; $00CAEA LEA     $00FF6740,A2
        DC.W    $4EF9,$0088,$4920   ; $00CAF0 JMP     $00884920
        DC.W    $0088,$CB02,$0088   ; $00CAF6 ORI.L  #$CB020088,A0
        DC.W    $CB16               ; $00CAFC AND.B  D5,(A6)
        DC.W    $0088,$CB2A,$0001   ; $00CAFE ORI.L  #$CB2A0001,A0
        DC.W    $FF6C,$0036,$0000   ; $00CB04 MOVE.W  $0036(A4),$0000(A7)
        DC.W    $0000,$0000         ; $00CB0A ORI.B  #$0000,D0
        DC.W    $0800,$0087         ; $00CB0E BTST    #7,D0
        DC.W    $2229,$59D6         ; $00CB12 MOVE.L  $59D6(A1),D1
        DC.W    $0001,$FF6C         ; $00CB16 ORI.B  #$FF6C,D1
        DC.W    $0038,$0000,$0000   ; $00CB1A ORI.B  #$0000,$0000.W
        DC.W    $0000,$0800         ; $00CB20 ORI.B  #$0800,D0
        DC.W    $0084,$2229,$59D6   ; $00CB24 ORI.L  #$222959D6,D4
        DC.W    $0001,$FF6F         ; $00CB2A ORI.B  #$FF6F,D1
        DC.W    $0038,$0000,$0000   ; $00CB2E ORI.B  #$0000,$0000.W
        DC.W    $0000,$0800         ; $00CB34 ORI.B  #$0800,D0
        DC.W    $0084,$2229,$59D6   ; $00CB38 ORI.L  #$222959D6,D4
        DC.W    $3038,$C8CC         ; $00CB3E MOVE.W  $C8CC.W,D0
        DC.W    $43F9,$0089,$8C74   ; $00CB42 LEA     $00898C74,A1
        DC.W    $23F1,$0000,$00FF,$6858; $00CB48 MOVE.L  $00(A1,D0.W),$00FF6858
        DC.W    $23F1,$0000,$00FF,$69B8; $00CB50 MOVE.L  $00(A1,D0.W),$00FF69B8
        DC.W    $43FA,$0028         ; $00CB58 LEA     $0028(PC),A1
        DC.W    $2271,$0000         ; $00CB5C MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F9,$00FF,$631C   ; $00CB60 LEA     $00FF631C,A2
        DC.W    $4EB9,$0088,$4920   ; $00CB66 JSR     $00884920
        DC.W    $43FA,$0014         ; $00CB6C LEA     $0014(PC),A1
        DC.W    $2271,$0000         ; $00CB70 MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F9,$00FF,$654C   ; $00CB74 LEA     $00FF654C,A2
        DC.W    $4EB9,$0088,$4920   ; $00CB7A JSR     $00884920
        DC.W    $6048               ; $00CB80 BRA.S  loc_00CBCA
        DC.W    $0088,$CB8E,$0088   ; $00CB82 ORI.L  #$CB8E0088,A0
        DC.W    $CBA2               ; $00CB88 AND.L  D5,-(A2)
        DC.W    $0088,$CBB6,$0001   ; $00CB8A ORI.L  #$CBB60001,A0
        DC.W    $FF72,$002B,$0000   ; $00CB90 MOVE.W  $2B(A2,D0.W),$0000(A7)
        DC.W    $0000,$0000         ; $00CB96 ORI.B  #$0000,D0
        DC.W    $0800,$006C         ; $00CB9A BTST    #12,D0
        DC.W    $2229,$59D6         ; $00CB9E MOVE.L  $59D6(A1),D1
        DC.W    $0001,$FF6C         ; $00CBA2 ORI.B  #$FF6C,D1
        DC.W    $002C,$0000,$0000   ; $00CBA6 ORI.B  #$0000,$0000(A4)
        DC.W    $0000,$0800         ; $00CBAC ORI.B  #$0800,D0
        DC.W    $0072,$2229,$59D6   ; $00CBB0 ORI.W  #$2229,-$2A(A2,D5.L)
        DC.W    $0001,$FF73         ; $00CBB6 ORI.B  #$FF73,D1
        DC.W    $002C,$0000,$0000   ; $00CBBA ORI.B  #$0000,$0000(A4)
        DC.W    $0000,$0800         ; $00CBC0 ORI.B  #$0800,D0
        DC.W    $006B,$2229,$59D6   ; $00CBC4 ORI.W  #$2229,$59D6(A3)
loc_00CBCA:
        DC.W    $3038,$C8A0         ; $00CBCA MOVE.W  $C8A0.W,D0
        DC.W    $E548               ; $00CBCE LSL.W  #2,D0
        DC.W    $43F9,$0089,$5668   ; $00CBD0 LEA     $00895668,A1
        DC.W    $43F1,$0000         ; $00CBD6 LEA     $00(A1,D0.W),A1
        DC.W    $45F9,$00FF,$672C   ; $00CBDA LEA     $00FF672C,A2
        DC.W    $357C,$0001,$0000   ; $00CBE0 MOVE.W  #$0001,$0000(A2)
        DC.W    $2559,$0002         ; $00CBE6 MOVE.L  (A1)+,$0002(A2)
        DC.W    $3559,$0006         ; $00CBEA MOVE.W  (A1)+,$0006(A2)
        DC.W    $3559,$000E         ; $00CBEE MOVE.W  (A1)+,$000E(A2)
        DC.W    $2551,$0010         ; $00CBF2 MOVE.L  (A1),$0010(A2)
        DC.W    $0838,$0007,$FDA8   ; $00CBF6 BTST    #7,$FDA8.W
        DC.W    $6706               ; $00CBFC BEQ.S  loc_00CC04
        DC.W    $066A,$0020,$0002   ; $00CBFE ADDI.W  #$0020,$0002(A2)
loc_00CC04:
        DC.W    $4E75               ; $00CC04 RTS
loc_00CC06:
        DC.W    $49F9,$0089,$58B4   ; $00CC06 LEA     $008958B4,A4
        DC.W    $3238,$C8CC         ; $00CC0C MOVE.W  $C8CC.W,D1
        DC.W    $2874,$1000         ; $00CC10 MOVEA.L $00(A4,D1.W),A4
        DC.W    $7001               ; $00CC14 MOVEQ   #$01,D0
        DC.W    $43F9,$00FF,$6218   ; $00CC16 LEA     $00FF6218,A1
        DC.W    $7E0E               ; $00CC1C MOVEQ   #$0E,D7
loc_00CC1E:
        DC.W    $2478,$C73C         ; $00CC1E MOVEA.L $C73C.W,A2
        DC.W    $264C               ; $00CC22 MOVEA.L A4,A3
        DC.W    $3340,$0000         ; $00CC24 MOVE.W  D0,$0000(A1)
        DC.W    $3340,$0014         ; $00CC28 MOVE.W  D0,$0014(A1)
        DC.W    $3340,$0028         ; $00CC2C MOVE.W  D0,$0028(A1)
        DC.W    $235B,$0010         ; $00CC30 MOVE.L  (A3)+,$0010(A1)
        DC.W    $235B,$0024         ; $00CC34 MOVE.L  (A3)+,$0024(A1)
        DC.W    $2353,$0038         ; $00CC38 MOVE.L  (A3),$0038(A1)
        DC.W    $235A,$0016         ; $00CC3C MOVE.L  (A2)+,$0016(A1)
        DC.W    $335A,$001A         ; $00CC40 MOVE.W  (A2)+,$001A(A1)
        DC.W    $235A,$002A         ; $00CC44 MOVE.L  (A2)+,$002A(A1)
        DC.W    $3352,$002E         ; $00CC48 MOVE.W  (A2),$002E(A1)
        DC.W    $43E9,$003C         ; $00CC4C LEA     $003C(A1),A1
        DC.W    $51CF,$FFCC         ; $00CC50 DBRA    D7,loc_00CC1E
        DC.W    $43F9,$00FF,$6226   ; $00CC54 LEA     $00FF6226,A1
        DC.W    $45F9,$0093,$816C   ; $00CC5A LEA     $0093816C,A2
        DC.W    $2472,$1000         ; $00CC60 MOVEA.L $00(A2,D1.W),A2
        DC.W    $7E0E               ; $00CC64 MOVEQ   #$0E,D7
loc_00CC66:
        DC.W    $329A               ; $00CC66 MOVE.W  (A2)+,(A1)
        DC.W    $43E9,$003C         ; $00CC68 LEA     $003C(A1),A1
        DC.W    $51CF,$FFF8         ; $00CC6C DBRA    D7,loc_00CC66
        DC.W    $4E75               ; $00CC70 RTS
        DC.W    $4E75               ; $00CC72 RTS
        DC.W    $43F9,$0089,$97EC   ; $00CC74 LEA     $008997EC,A1
        DC.W    $43F1,$0000         ; $00CC7A LEA     $00(A1,D0.W),A1
        DC.W    $45F8,$C08C         ; $00CC7E LEA     $C08C.W,A2
        DC.W    $4EF9,$0088,$4922   ; $00CC82 JMP     $00884922
        DC.W    $11F8,$FEA9,$C30F   ; $00CC88 MOVE.B  $FEA9.W,$C30F.W
        DC.W    $41F8,$9000         ; $00CC8E LEA     $9000.W,A0
        DC.W    $11FC,$0000,$C819   ; $00CC92 MOVE.B  #$0000,$C819.W
        DC.W    $31F8,$C094,$C07A   ; $00CC98 MOVE.W  $C094.W,$C07A.W
        DC.W    $11FC,$0000,$C311   ; $00CC9E MOVE.B  #$0000,$C311.W
        DC.W    $31FC,$0001,$C048   ; $00CCA4 MOVE.W  #$0001,$C048.W
        DC.W    $11FC,$0004,$C302   ; $00CCAA MOVE.B  #$0004,$C302.W
        DC.W    $31FC,$0000,$C086   ; $00CCB0 MOVE.W  #$0000,$C086.W
        DC.W    $31FC,$0040,$C0E4   ; $00CCB6 MOVE.W  #$0040,$C0E4.W
        DC.W    $43F9,$0089,$8A04   ; $00CCBC LEA     $00898A04,A1
        DC.W    $3038,$C89C         ; $00CCC2 MOVE.W  $C89C.W,D0
        DC.W    $C0FC,$0014         ; $00CCC6 MULU    #$0014,D0
        DC.W    $D3C0               ; $00CCCA ADDA.L  D0,A1
        DC.W    $45F8,$C700         ; $00CCCC LEA     $C700.W,A2
        DC.W    $4EB9,$0088,$4922   ; $00CCD0 JSR     $00884922
        DC.W    $2151,$0018         ; $00CCD6 MOVE.L  (A1),$0018(A0)
        DC.W    $2151,$00B2         ; $00CCDA MOVE.L  (A1),$00B2(A0)
        DC.W    $43F9,$0093,$0612   ; $00CCDE LEA     $00930612,A1
        DC.W    $3038,$C8CC         ; $00CCE4 MOVE.W  $C8CC.W,D0
        DC.W    $2271,$0000         ; $00CCE8 MOVEA.L $00(A1,D0.W),A1
        DC.W    $21C9,$C268         ; $00CCEC MOVE.L  A1,$C268.W
        DC.W    $43F9,$0093,$05D6   ; $00CCF0 LEA     $009305D6,A1
        DC.W    $2271,$0000         ; $00CCF6 MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F8,$C8E4         ; $00CCFA LEA     $C8E4.W,A2
        DC.W    $4EB9,$0088,$4922   ; $00CCFE JSR     $00884922
        DC.W    $317C,$0001,$002A   ; $00CD04 MOVE.W  #$0001,$002A(A0)
        DC.W    $317C,$0001,$00A6   ; $00CD0A MOVE.W  #$0001,$00A6(A0)
        DC.W    $317C,$000F,$00A4   ; $00CD10 MOVE.W  #$000F,$00A4(A0)
        DC.W    $317C,$0003,$00AC   ; $00CD16 MOVE.W  #$0003,$00AC(A0)
        DC.W    $317C,$0100,$0076   ; $00CD1C MOVE.W  #$0100,$0076(A0)
        DC.W    $317C,$0100,$0078   ; $00CD22 MOVE.W  #$0100,$0078(A0)
        DC.W    $7000               ; $00CD28 MOVEQ   #$00,D0
        DC.W    $31FC,$001E,$C0AC   ; $00CD2A MOVE.W  #$001E,$C0AC.W
        DC.W    $11FC,$0014,$C824   ; $00CD30 MOVE.B  #$0014,$C824.W
        DC.W    $0C78,$0001,$C8C8   ; $00CD36 CMPI.W  #$0001,$C8C8.W
        DC.W    $6606               ; $00CD3C BNE.S  loc_00CD44
        DC.W    $11FC,$001E,$C824   ; $00CD3E MOVE.B  #$001E,$C824.W
loc_00CD44:
        DC.W    $31FC,$FFFF,$C05A   ; $00CD44 MOVE.W  #$FFFF,$C05A.W
        DC.W    $4E75               ; $00CD4A RTS
        DC.W    $43F9,$0089,$8A7C   ; $00CD4C LEA     $00898A7C,A1
        DC.W    $3E38,$C8A0         ; $00CD52 MOVE.W  $C8A0.W,D7
        DC.W    $2271,$7000         ; $00CD56 MOVEA.L $00(A1,D7.W),A1
        DC.W    $7E0E               ; $00CD5A MOVEQ   #$0E,D7
        DC.W    $41F8,$9100         ; $00CD5C LEA     $9100.W,A0
        DC.W    $47F9,$0093,$814E   ; $00CD60 LEA     $0093814E,A3
        DC.W    $7000               ; $00CD66 MOVEQ   #$00,D0
        DC.W    $7202               ; $00CD68 MOVEQ   #$02,D1
loc_00CD6A:
        DC.W    $2459               ; $00CD6A MOVEA.L (A1)+,A2
        DC.W    $214A,$0018         ; $00CD6C MOVE.L  A2,$0018(A0)
        DC.W    $315B,$00C2         ; $00CD70 MOVE.W  (A3)+,$00C2(A0)
        DC.W    $3140,$00A4         ; $00CD74 MOVE.W  D0,$00A4(A0)
        DC.W    $3141,$00A6         ; $00CD78 MOVE.W  D1,$00A6(A0)
        DC.W    $5240               ; $00CD7C ADDQ.W  #1,D0
        DC.W    $5241               ; $00CD7E ADDQ.W  #1,D1
        DC.W    $0240,$000F         ; $00CD80 ANDI.W  #$000F,D0
        DC.W    $0241,$000F         ; $00CD84 ANDI.W  #$000F,D1
        DC.W    $41E8,$0100         ; $00CD88 LEA     $0100(A0),A0
        DC.W    $51CF,$FFDC         ; $00CD8C DBRA    D7,loc_00CD6A
        DC.W    $4E75               ; $00CD90 RTS
        DC.W    $2F38,$C260         ; $00CD92 MOVE.L  $C260.W,-(A7)
        DC.W    $43F8,$C000         ; $00CD96 LEA     $C000.W,A1
        DC.W    $7200               ; $00CD9A MOVEQ   #$00,D1
        DC.W    $4EB9,$0088,$483A   ; $00CD9C JSR     $0088483A
        DC.W    $21DF,$C260         ; $00CDA2 MOVE.L  (A7)+,$C260.W
        DC.W    $43F8,$9000         ; $00CDA6 LEA     $9000.W,A1
        DC.W    $7200               ; $00CDAA MOVEQ   #$00,D1
        DC.W    $7E0F               ; $00CDAC MOVEQ   #$0F,D7
loc_00CDAE:
        DC.W    $4EB9,$0088,$4842   ; $00CDAE JSR     $00884842
        DC.W    $51CF,$FFF8         ; $00CDB4 DBRA    D7,loc_00CDAE
        DC.W    $7200               ; $00CDB8 MOVEQ   #$00,D1
        DC.W    $11C1,$C30E         ; $00CDBA MOVE.B  D1,$C30E.W
        DC.W    $31C1,$C8AA         ; $00CDBE MOVE.W  D1,$C8AA.W
        DC.W    $31C1,$C8AC         ; $00CDC2 MOVE.W  D1,$C8AC.W
        DC.W    $31C1,$C8AE         ; $00CDC6 MOVE.W  D1,$C8AE.W
        DC.W    $31FC,$FFFF,$C026   ; $00CDCA MOVE.W  #$FFFF,$C026.W
        DC.W    $4E75               ; $00CDD0 RTS
        DC.W    $7E0F               ; $00CDD2 MOVEQ   #$0F,D7
        DC.W    $D078,$C8A0         ; $00CDD4 ADD.W  $C8A0.W,D0
        DC.W    $41F8,$9000         ; $00CDD8 LEA     $9000.W,A0
        DC.W    $3438,$C8CC         ; $00CDDC MOVE.W  $C8CC.W,D2
        DC.W    $43F9,$0093,$82BA   ; $00CDE0 LEA     $009382BA,A1
        DC.W    $2271,$2000         ; $00CDE6 MOVEA.L $00(A1,D2.W),A1
        DC.W    $2271,$0000         ; $00CDEA MOVEA.L $00(A1,D0.W),A1
loc_00CDEE:
        DC.W    $614C               ; $00CDEE BSR.S  loc_00CE3C
        DC.W    $41E8,$0100         ; $00CDF0 LEA     $0100(A0),A0
        DC.W    $51CF,$FFF8         ; $00CDF4 DBRA    D7,loc_00CDEE
        DC.W    $21FC,$0000,$0000,$902C; $00CDF8 MOVE.L  #$00000000,$902C.W
        DC.W    $4E75               ; $00CE00 RTS
        DC.W    $7200               ; $00CE02 MOVEQ   #$00,D1
        DC.W    $611C               ; $00CE04 BSR.S  loc_00CE22
        DC.W    $317C,$000F,$00A4   ; $00CE06 MOVE.W  #$000F,$00A4(A0)
        DC.W    $317C,$000F,$00A6   ; $00CE0C MOVE.W  #$000F,$00A6(A0)
        DC.W    $41F8,$9F00         ; $00CE12 LEA     $9F00.W,A0
        DC.W    $6124               ; $00CE16 BSR.S  loc_00CE3C
        DC.W    $3141,$00A4         ; $00CE18 MOVE.W  D1,$00A4(A0)
        DC.W    $3141,$00A6         ; $00CE1C MOVE.W  D1,$00A6(A0)
        DC.W    $4E75               ; $00CE20 RTS
loc_00CE22:
        DC.W    $41F8,$9000         ; $00CE22 LEA     $9000.W,A0
        DC.W    $D078,$C8A0         ; $00CE26 ADD.W  $C8A0.W,D0
        DC.W    $3438,$C8CC         ; $00CE2A MOVE.W  $C8CC.W,D2
        DC.W    $43F9,$0093,$82BA   ; $00CE2E LEA     $009382BA,A1
        DC.W    $2271,$2000         ; $00CE34 MOVEA.L $00(A1,D2.W),A1
        DC.W    $2271,$0000         ; $00CE38 MOVEA.L $00(A1,D0.W),A1
loc_00CE3C:
        DC.W    $3159,$0030         ; $00CE3C MOVE.W  (A1)+,$0030(A0)
        DC.W    $3159,$0032         ; $00CE40 MOVE.W  (A1)+,$0032(A0)
        DC.W    $3159,$0034         ; $00CE44 MOVE.W  (A1)+,$0034(A0)
        DC.W    $3151,$003C         ; $00CE48 MOVE.W  (A1),$003C(A0)
        DC.W    $3159,$0040         ; $00CE4C MOVE.W  (A1)+,$0040(A0)
        DC.W    $2141,$002C         ; $00CE50 MOVE.L  D1,$002C(A0)
        DC.W    $4E75               ; $00CE54 RTS
        DC.W    $7E0F               ; $00CE56 MOVEQ   #$0F,D7
        DC.W    $41F8,$9000         ; $00CE58 LEA     $9000.W,A0
        DC.W    $43F9,$0093,$8EAE   ; $00CE5C LEA     $00938EAE,A1
loc_00CE62:
        DC.W    $61D8               ; $00CE62 BSR.S  loc_00CE3C
        DC.W    $41E8,$0100         ; $00CE64 LEA     $0100(A0),A0
        DC.W    $51CF,$FFF8         ; $00CE68 DBRA    D7,loc_00CE62
        DC.W    $21FC,$0000,$0000,$902C; $00CE6C MOVE.L  #$00000000,$902C.W
        DC.W    $4E75               ; $00CE74 RTS
        DC.W    $7200               ; $00CE76 MOVEQ   #$00,D1
        DC.W    $43F8,$A800         ; $00CE78 LEA     $A800.W,A1
        DC.W    $4EB9,$0088,$4842   ; $00CE7C JSR     $00884842
        DC.W    $4EB9,$0088,$4846   ; $00CE82 JSR     $00884846
        DC.W    $4EB9,$0088,$4856   ; $00CE88 JSR     $00884856
        DC.W    $11C1,$C81D         ; $00CE8E MOVE.B  D1,$C81D.W
        DC.W    $11C1,$C81F         ; $00CE92 MOVE.B  D1,$C81F.W
        DC.W    $11C1,$C820         ; $00CE96 MOVE.B  D1,$C820.W
        DC.W    $31C1,$A9E0         ; $00CE9A MOVE.W  D1,$A9E0.W
        DC.W    $21FC,$0000,$C4C4,$A9E2; $00CE9E MOVE.L  #$0000C4C4,$A9E2.W
        DC.W    $21FC,$0000,$C4C4,$A9E6; $00CEA6 MOVE.L  #$0000C4C4,$A9E6.W
        DC.W    $11FC,$0000,$C819   ; $00CEAE MOVE.B  #$0000,$C819.W
        DC.W    $31FC,$0000,$C8BE   ; $00CEB4 MOVE.W  #$0000,$C8BE.W
        DC.W    $11F8,$C81A,$C310   ; $00CEBA MOVE.B  $C81A.W,$C310.W
        DC.W    $4E75               ; $00CEC0 RTS
        DC.W    $41F8,$9000         ; $00CEC2 LEA     $9000.W,A0
        DC.W    $1038,$FEAD         ; $00CEC6 MOVE.B  $FEAD.W,D0
        DC.W    $6008               ; $00CECA BRA.S  loc_00CED4
        DC.W    $41F8,$9F00         ; $00CECC LEA     $9F00.W,A0
        DC.W    $1038,$FEAE         ; $00CED0 MOVE.B  $FEAE.W,D0
loc_00CED4:
        DC.W    $3238,$C8CC         ; $00CED4 MOVE.W  $C8CC.W,D1
        DC.W    $D241               ; $00CED8 ADD.W  D1,D1
        DC.W    $D278,$C8CA         ; $00CEDA ADD.W  $C8CA.W,D1
        DC.W    $4880               ; $00CEDE EXT.W   D0
        DC.W    $D040               ; $00CEE0 ADD.W  D0,D0
        DC.W    $D041               ; $00CEE2 ADD.W  D1,D0
        DC.W    $303B,$0008         ; $00CEE4 MOVE.W  $08(PC,D0.W),D0
        DC.W    $D178,$C0E8         ; $00CEE8 ADD.W  D0,$C0E8.W
        DC.W    $4E75               ; $00CEEC RTS
        DC.W    $001E,$000F         ; $00CEEE ORI.B  #$000F,(A6)+
        DC.W    $0000,$FFF1         ; $00CEF2 ORI.B  #$FFF1,D0
        DC.W    $FFE2               ; $00CEF6 MOVE.W  -(A2),<EA:3F>
        DC.W    $001E,$000F         ; $00CEF8 ORI.B  #$000F,(A6)+
        DC.W    $0000,$FFF1         ; $00CEFC ORI.B  #$FFF1,D0
        DC.W    $FFE2               ; $00CF00 MOVE.W  -(A2),<EA:3F>
        DC.W    $001E,$000F         ; $00CF02 ORI.B  #$000F,(A6)+
        DC.W    $0000,$FFF1         ; $00CF06 ORI.B  #$FFF1,D0
        DC.W    $FFE2               ; $00CF0A MOVE.W  -(A2),<EA:3F>
loc_00CF0C:
        DC.W    $41F8,$9100         ; $00CF0C LEA     $9100.W,A0
        DC.W    $7E0E               ; $00CF10 MOVEQ   #$0E,D7
loc_00CF12:
        DC.W    $3F07               ; $00CF12 MOVE.W  D7,-(A7)
        DC.W    $4EBA,$ABA0         ; $00CF14 JSR     $007AB6(PC)
        DC.W    $4EBA,$AB9C         ; $00CF18 JSR     $007AB6(PC)
        DC.W    $4EBA,$AB98         ; $00CF1C JSR     $007AB6(PC)
        DC.W    $4EBA,$AB94         ; $00CF20 JSR     $007AB6(PC)
        DC.W    $4EBA,$AB90         ; $00CF24 JSR     $007AB6(PC)
        DC.W    $4EBA,$AB8C         ; $00CF28 JSR     $007AB6(PC)
        DC.W    $4EBA,$AB88         ; $00CF2C JSR     $007AB6(PC)
        DC.W    $4EBA,$AB84         ; $00CF30 JSR     $007AB6(PC)
        DC.W    $4EBA,$AB80         ; $00CF34 JSR     $007AB6(PC)
        DC.W    $43F9,$0093,$AC2C   ; $00CF38 LEA     $0093AC2C,A1
        DC.W    $3028,$00C8         ; $00CF3E MOVE.W  $00C8(A0),D0
        DC.W    $9068,$0032         ; $00CF42 SUB.W  $0032(A0),D0
        DC.W    $D040               ; $00CF46 ADD.W  D0,D0
        DC.W    $6B0A               ; $00CF48 BMI.S  loc_00CF54
        DC.W    $0240,$03FF         ; $00CF4A ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $00CF4E MOVE.W  $00(A1,D0.W),D0
        DC.W    $600C               ; $00CF52 BRA.S  loc_00CF60
loc_00CF54:
        DC.W    $4440               ; $00CF54 NEG.W  D0
        DC.W    $0240,$03FF         ; $00CF56 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $00CF5A MOVE.W  $00(A1,D0.W),D0
        DC.W    $4440               ; $00CF5E NEG.W  D0
loc_00CF60:
        DC.W    $3140,$003A         ; $00CF60 MOVE.W  D0,$003A(A0)
        DC.W    $43F9,$0093,$A82C   ; $00CF64 LEA     $0093A82C,A1
        DC.W    $3028,$0032         ; $00CF6A MOVE.W  $0032(A0),D0
        DC.W    $9068,$00C6         ; $00CF6E SUB.W  $00C6(A0),D0
        DC.W    $D040               ; $00CF72 ADD.W  D0,D0
        DC.W    $6B0A               ; $00CF74 BMI.S  loc_00CF80
        DC.W    $0240,$03FF         ; $00CF76 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $00CF7A MOVE.W  $00(A1,D0.W),D0
        DC.W    $600C               ; $00CF7E BRA.S  loc_00CF8C
loc_00CF80:
        DC.W    $4440               ; $00CF80 NEG.W  D0
        DC.W    $0240,$03FF         ; $00CF82 ANDI.W  #$03FF,D0
        DC.W    $3031,$0000         ; $00CF86 MOVE.W  $00(A1,D0.W),D0
        DC.W    $4440               ; $00CF8A NEG.W  D0
loc_00CF8C:
        DC.W    $4EBA,$A6C0         ; $00CF8C JSR     $00764E(PC)
        DC.W    $4EBA,$A1B8         ; $00CF90 JSR     $00714A(PC)
        DC.W    $3140,$003E         ; $00CF94 MOVE.W  D0,$003E(A0)
        DC.W    $3168,$006E,$0046   ; $00CF98 MOVE.W  $006E(A0),$0046(A0)
        DC.W    $41E8,$0100         ; $00CF9E LEA     $0100(A0),A0
        DC.W    $3E1F               ; $00CFA2 MOVE.W  (A7)+,D7
        DC.W    $51CF,$FF6C         ; $00CFA4 DBRA    D7,loc_00CF12
        DC.W    $4EF9,$0088,$36DE   ; $00CFA8 JMP     $008836DE
loc_00CFAE:
        DC.W    $3038,$C8CC         ; $00CFAE MOVE.W  $C8CC.W,D0
        DC.W    $43F9,$0089,$55CC   ; $00CFB2 LEA     $008955CC,A1
        DC.W    $2271,$0000         ; $00CFB8 MOVEA.L $00(A1,D0.W),A1
        DC.W    $45F9,$00FF,$6178   ; $00CFBC LEA     $00FF6178,A2
loc_00CFC2:
        DC.W    $7E07               ; $00CFC2 MOVEQ   #$07,D7
loc_00CFC4:
        DC.W    $2559,$0002         ; $00CFC4 MOVE.L  (A1)+,$0002(A2)
        DC.W    $3559,$0006         ; $00CFC8 MOVE.W  (A1)+,$0006(A2)
        DC.W    $45EA,$0014         ; $00CFCC LEA     $0014(A2),A2
        DC.W    $51CF,$FFF2         ; $00CFD0 DBRA    D7,loc_00CFC4
        DC.W    $4E75               ; $00CFD4 RTS
        DC.W    $3038,$C8CC         ; $00CFD6 MOVE.W  $C8CC.W,D0
        DC.W    $43F9,$0089,$55CC   ; $00CFDA LEA     $008955CC,A1
        DC.W    $2271,$0000         ; $00CFE0 MOVEA.L $00(A1,D0.W),A1
        DC.W    $2649               ; $00CFE4 MOVEA.L A1,A3
        DC.W    $45F9,$00FF,$6178   ; $00CFE6 LEA     $00FF6178,A2
        DC.W    $61D4               ; $00CFEC BSR.S  loc_00CFC2
        DC.W    $224B               ; $00CFEE MOVEA.L A3,A1
        DC.W    $45F9,$00FF,$627C   ; $00CFF0 LEA     $00FF627C,A2
        DC.W    $61CA               ; $00CFF6 BSR.S  loc_00CFC2
        DC.W    $224B               ; $00CFF8 MOVEA.L A3,A1
        DC.W    $45F9,$00FF,$63A8   ; $00CFFA LEA     $00FF63A8,A2
        DC.W    $61C0               ; $00D000 BSR.S  loc_00CFC2
        DC.W    $224B               ; $00D002 MOVEA.L A3,A1
        DC.W    $45F9,$00FF,$64AC   ; $00D004 LEA     $00FF64AC,A2
        DC.W    $60B6               ; $00D00A BRA.S  loc_00CFC2
loc_00D00C:
        DC.W    $43F8,$C806         ; $00D00C LEA     $C806.W,A1
        DC.W    $12FC,$0000         ; $00D010 MOVE.B  #$0000,(A1)+
        DC.W    $12FC,$00C4         ; $00D014 MOVE.B  #$00C4,(A1)+
        DC.W    $12BC,$00C4         ; $00D018 MOVE.B  #$00C4,(A1)
        DC.W    $31FC,$C200,$C076   ; $00D01C MOVE.W  #$C200,$C076.W
        DC.W    $0838,$0003,$C80E   ; $00D022 BTST    #3,$C80E.W
        DC.W    $6610               ; $00D028 BNE.S  loc_00D03A
        DC.W    $21FC,$6100,$0000,$C254; $00D02A MOVE.L  #$61000000,$C254.W
        DC.W    $21FC,$6000,$0000,$C260; $00D032 MOVE.L  #$60000000,$C260.W
loc_00D03A:
        DC.W    $43FA,$0014         ; $00D03A LEA     $0014(PC),A1
        DC.W    $7000               ; $00D03E MOVEQ   #$00,D0
        DC.W    $1038,$FDA9         ; $00D040 MOVE.B  $FDA9.W,D0
        DC.W    $11F1,$0000,$C051   ; $00D044 MOVE.B  $00(A1,D0.W),$C051.W
        DC.W    $4E75               ; $00D04A RTS
        DC.W    $5041               ; $00D04C ADDQ.W  #8,D1
        DC.W    $4100               ; $00D04E DC.W    $4100
        DC.W    $504B               ; $00D050 ADDQ.W  #8,A3
        DC.W    $4600               ; $00D052 NOT.B  D0
        DC.W    $4EBA,$FFB6         ; $00D054 JSR     loc_00D00C(PC)
        DC.W    $3038,$C8A0         ; $00D058 MOVE.W  $C8A0.W,D0
        DC.W    $43F9,$0089,$8C0C   ; $00D05C LEA     $00898C0C,A1
        DC.W    $23F1,$0000,$00FF,$6868; $00D062 MOVE.L  $00(A1,D0.W),$00FF6868
loc_00D06A:
        DC.W    $227B,$0004         ; $00D06A MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $00D06E JMP     (A1)
        DC.W    $0088,$D088,$0088   ; $00D070 ORI.L  #$D0880088,A0
        DC.W    $D088               ; $00D076 ADD.L  A0,D0
        DC.W    $0088,$D088,$0088   ; $00D078 ORI.L  #$D0880088,A0
        DC.W    $D088               ; $00D07E ADD.L  A0,D0
        DC.W    $0088,$D088,$0088   ; $00D080 ORI.L  #$D0880088,A0
        DC.W    $D088               ; $00D086 ADD.L  A0,D0
        DC.W    $4E75               ; $00D088 RTS
        DC.W    $11FC,$0000,$C806   ; $00D08A MOVE.B  #$0000,$C806.W
        DC.W    $11FC,$00C4,$C807   ; $00D090 MOVE.B  #$00C4,$C807.W
        DC.W    $11FC,$00C4,$C808   ; $00D096 MOVE.B  #$00C4,$C808.W
        DC.W    $11FC,$0000,$C813   ; $00D09C MOVE.B  #$0000,$C813.W
        DC.W    $11FC,$00C4,$C814   ; $00D0A2 MOVE.B  #$00C4,$C814.W
        DC.W    $11FC,$00C4,$C815   ; $00D0A8 MOVE.B  #$00C4,$C815.W
        DC.W    $31FC,$C200,$C076   ; $00D0AE MOVE.W  #$C200,$C076.W
        DC.W    $21FC,$6100,$0000,$C254; $00D0B4 MOVE.L  #$61000000,$C254.W
        DC.W    $21FC,$6000,$0000,$C260; $00D0BC MOVE.L  #$60000000,$C260.W
        DC.W    $3038,$C8A0         ; $00D0C4 MOVE.W  $C8A0.W,D0
        DC.W    $4EFA,$FFA0         ; $00D0C8 JMP     loc_00D06A(PC)
        DC.W    $43F8,$FDAA         ; $00D0CC LEA     $FDAA.W,A1
        DC.W    $3238,$C89C         ; $00D0D0 MOVE.W  $C89C.W,D1
        DC.W    $EB49               ; $00D0D4 LSL.W  #5,D1
        DC.W    $D278,$C8A0         ; $00D0D6 ADD.W  $C8A0.W,D1
        DC.W    $3038,$C8C8         ; $00D0DA MOVE.W  $C8C8.W,D0
        DC.W    $E748               ; $00D0DE LSL.W  #3,D0
        DC.W    $D078,$C8CC         ; $00D0E0 ADD.W  $C8CC.W,D0
        DC.W    $D240               ; $00D0E4 ADD.W  D0,D1
        DC.W    $43F1,$1000         ; $00D0E6 LEA     $00(A1,D1.W),A1
        DC.W    $45F9,$00FF,$68E0   ; $00D0EA LEA     $00FF68E0,A2
        DC.W    $4EF9,$0088,$4280   ; $00D0F0 JMP     $00884280
        DC.W    $11FC,$0003,$C80A   ; $00D0F6 MOVE.B  #$0003,$C80A.W
        DC.W    $45F8,$C200         ; $00D0FC LEA     $C200.W,A2
        DC.W    $43F8,$EEE0         ; $00D100 LEA     $EEE0.W,A1
        DC.W    $4EB9,$0088,$4920   ; $00D104 JSR     $00884920
        DC.W    $21F8,$EEFC,$C254   ; $00D10A MOVE.L  $EEFC.W,$C254.W
        DC.W    $31FC,$00C0,$C054   ; $00D110 MOVE.W  #$00C0,$C054.W
        DC.W    $31FC,$0540,$C056   ; $00D116 MOVE.W  #$0540,$C056.W
        DC.W    $31FC,$0000,$C896   ; $00D11C MOVE.W  #$0000,$C896.W
        DC.W    $43F8,$C200         ; $00D122 LEA     $C200.W,A1
        DC.W    $47F9,$00FF,$68D8   ; $00D126 LEA     $00FF68D8,A3
        DC.W    $7E04               ; $00D12C MOVEQ   #$04,D7
loc_00D12E:
        DC.W    $4EBA,$E30C         ; $00D12E JSR     $00B43C(PC)
        DC.W    $43E9,$0004         ; $00D132 LEA     $0004(A1),A1
        DC.W    $47EB,$0010         ; $00D136 LEA     $0010(A3),A3
        DC.W    $51CF,$FFF2         ; $00D13A DBRA    D7,loc_00D12E
        DC.W    $72FF               ; $00D13E MOVEQ   #-$01,D1
        DC.W    $7E04               ; $00D140 MOVEQ   #$04,D7
        DC.W    $2038,$C254         ; $00D142 MOVE.L  $C254.W,D0
        DC.W    $43F8,$C200         ; $00D146 LEA     $C200.W,A1
loc_00D14A:
        DC.W    $5241               ; $00D14A ADDQ.W  #1,D1
        DC.W    $B099               ; $00D14C CMP.L  (A1)+,D0
        DC.W    $57CF,$FFFA         ; $00D14E DBEQ    D7,loc_00D14A
        DC.W    $E949               ; $00D152 LSL.W  #4,D1
        DC.W    $43F9,$00FF,$68D0   ; $00D154 LEA     $00FF68D0,A1
        DC.W    $43F1,$1000         ; $00D15A LEA     $00(A1,D1.W),A1
        DC.W    $137C,$0001,$0001   ; $00D15E MOVE.B  #$0001,$0001(A1)
        DC.W    $21C9,$C960         ; $00D164 MOVE.L  A1,$C960.W
        DC.W    $4EBA,$9ADC         ; $00D168 JSR     $006C46(PC)
        DC.W    $4EBA,$B750         ; $00D16C JSR     $0088BE(PC)
        DC.W    $31FC,$00C0,$C0C8   ; $00D170 MOVE.W  #$00C0,$C0C8.W
        DC.W    $31FC,$07D0,$C8D4   ; $00D176 MOVE.W  #$07D0,$C8D4.W
        DC.W    $31FC,$0600,$C8D6   ; $00D17C MOVE.W  #$0600,$C8D6.W
        DC.W    $31FC,$3000,$C8D8   ; $00D182 MOVE.W  #$3000,$C8D8.W
        DC.W    $31FC,$0000,$C8DA   ; $00D188 MOVE.W  #$0000,$C8DA.W
        DC.W    $31FC,$00C0,$C8DC   ; $00D18E MOVE.W  #$00C0,$C8DC.W
        DC.W    $31FC,$0540,$C8DE   ; $00D194 MOVE.W  #$0540,$C8DE.W
        DC.W    $4E75               ; $00D19A RTS
        DC.W    $7400               ; $00D19C MOVEQ   #$00,D2
        DC.W    $0C40,$0002         ; $00D19E CMPI.W  #$0002,D0
        DC.W    $6602               ; $00D1A2 BNE.S  loc_00D1A6
        DC.W    $7401               ; $00D1A4 MOVEQ   #$01,D2
loc_00D1A6:
        DC.W    $0C40,$0003         ; $00D1A6 CMPI.W  #$0003,D0
        DC.W    $6602               ; $00D1AA BNE.S  loc_00D1AE
        DC.W    $7401               ; $00D1AC MOVEQ   #$01,D2
loc_00D1AE:
        DC.W    $11C2,$C826         ; $00D1AE MOVE.B  D2,$C826.W
        DC.W    $31C0,$C89C         ; $00D1B2 MOVE.W  D0,$C89C.W
        DC.W    $D040               ; $00D1B6 ADD.W  D0,D0
        DC.W    $31C0,$C89E         ; $00D1B8 MOVE.W  D0,$C89E.W
        DC.W    $D040               ; $00D1BC ADD.W  D0,D0
        DC.W    $31C0,$C8A0         ; $00D1BE MOVE.W  D0,$C8A0.W
        DC.W    $31C1,$C8C8         ; $00D1C2 MOVE.W  D1,$C8C8.W
        DC.W    $D241               ; $00D1C6 ADD.W  D1,D1
        DC.W    $31C1,$C8CA         ; $00D1C8 MOVE.W  D1,$C8CA.W
        DC.W    $D241               ; $00D1CC ADD.W  D1,D1
        DC.W    $31C1,$C8CC         ; $00D1CE MOVE.W  D1,$C8CC.W
        DC.W    $4E75               ; $00D1D2 RTS
