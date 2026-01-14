; Generated assembly for $002878-$004200
; Branch targets: 156
; Labels: 146
; Format: DC.W with decoded mnemonics as comments

        org     $002878

        DC.W    $4A38,$C821         ; $002878 TST.B  $C821.W
        DC.W    $6710               ; $00287C BEQ.S  loc_00288E
        DC.W    $43F9,$00FF,$6E00   ; $00287E LEA     $00FF6E00,A1
        DC.W    $45F9,$00A1,$5200   ; $002884 LEA     $00A15200,A2
        DC.W    $4EFA,$2046         ; $00288A JMP     $0048D2(PC)
loc_00288E:
        DC.W    $4E75               ; $00288E RTS
loc_002890:
        DC.W    $0839,$0000,$00A1,$5123; $002890 BTST    #0,$00A15123
        DC.W    $67F6               ; $002898 BEQ.S  loc_002890
        DC.W    $08B9,$0000,$00A1,$5123; $00289A BCLR    #0,$00A15123
        DC.W    $31FC,$0000,$C8A8   ; $0028A2 MOVE.W  #$0000,$C8A8.W
        DC.W    $13F8,$C8A9,$00A1,$5121; $0028A8 MOVE.B  $C8A9.W,$00A15121
        DC.W    $13F8,$C8A8,$00A1,$5120; $0028B0 MOVE.B  $C8A8.W,$00A15120
        DC.W    $13FC,$0000,$00A1,$5123; $0028B8 MOVE.B  #$0000,$00A15123
        DC.W    $4E75               ; $0028C0 RTS
        DC.W    $33FC,$0500,$00A1,$5110; $0028C2 MOVE.W  #$0500,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $0028CA MOVE.B  #$0004,$00A15107
        DC.W    $13F8,$C8A9,$00A1,$5121; $0028D2 MOVE.B  $C8A9.W,$00A15121
        DC.W    $13F8,$C8A8,$00A1,$5120; $0028DA MOVE.B  $C8A8.W,$00A15120
loc_0028E2:
        DC.W    $0839,$0001,$00A1,$5123; $0028E2 BTST    #1,$00A15123
        DC.W    $67F6               ; $0028EA BEQ.S  loc_0028E2
        DC.W    $08B9,$0001,$00A1,$5123; $0028EC BCLR    #1,$00A15123
        DC.W    $43F9,$00FF,$6000   ; $0028F4 LEA     $00FF6000,A1
        DC.W    $45F9,$00A1,$5112   ; $0028FA LEA     $00A15112,A2
        DC.W    $4EB9,$0089,$88EC   ; $002900 JSR     $008988EC
        DC.W    $4EB9,$0089,$88EC   ; $002906 JSR     $008988EC
        DC.W    $4EB9,$0089,$88EC   ; $00290C JSR     $008988EC
        DC.W    $4EB9,$0089,$88EC   ; $002912 JSR     $008988EC
        DC.W    $4EB9,$0089,$88EC   ; $002918 JSR     $008988EC
        DC.W    $4EB9,$0089,$88EC   ; $00291E JSR     $008988EC
        DC.W    $4EB9,$0089,$88EC   ; $002924 JSR     $008988EC
        DC.W    $4EB9,$0089,$88EC   ; $00292A JSR     $008988EC
        DC.W    $4EB9,$0089,$88EC   ; $002930 JSR     $008988EC
        DC.W    $4EF9,$0089,$88EC   ; $002936 JMP     $008988EC
        DC.W    $49F9,$00A1,$5100   ; $00293C LEA     $00A15100,A4
        DC.W    $18BC,$0000         ; $002942 MOVE.B  #$0000,(A4)
        DC.W    $45F9,$00A1,$5186   ; $002946 LEA     $00A15186,A2
        DC.W    $47F9,$00A1,$5188   ; $00294C LEA     $00A15188,A3
        DC.W    $3E3C,$00BF         ; $002952 MOVE.W  #$00BF,D7
        DC.W    $7000               ; $002956 MOVEQ   #$00,D0
        DC.W    $323C,$3000         ; $002958 MOVE.W  #$3000,D1
        DC.W    $343C,$0100         ; $00295C MOVE.W  #$0100,D2
        DC.W    $397C,$009F,$0084   ; $002960 MOVE.W  #$009F,$0084(A4)
loc_002966:
        DC.W    $3481               ; $002966 MOVE.W  D1,(A2)
        DC.W    $3680               ; $002968 MOVE.W  D0,(A3)
        DC.W    $706F               ; $00296A MOVEQ   #$6F,D0
        DC.W    $81FC,$0378         ; $00296C DIVS    #$0378,D0
loc_002970:
        DC.W    $082C,$0001,$008B   ; $002970 BTST    #1,$008B(A4)
        DC.W    $66F8               ; $002976 BNE.S  loc_002970
        DC.W    $D242               ; $002978 ADD.W  D2,D1
        DC.W    $51CF,$FFEA         ; $00297A DBRA    D7,loc_002966
        DC.W    $18BC,$0080         ; $00297E MOVE.B  #$0080,(A4)
        DC.W    $4E75               ; $002982 RTS
        DC.W    $41F8,$9000         ; $002984 LEA     $9000.W,A0
        DC.W    $43F9,$00FF,$6100   ; $002988 LEA     $00FF6100,A1
        DC.W    $4A78,$C04C         ; $00298E TST.W  $C04C.W
        DC.W    $6600,$014A         ; $002992 BNE.W  loc_002ADE
loc_002996:
        DC.W    $3028,$0030         ; $002996 MOVE.W  $0030(A0),D0
        DC.W    $3340,$0016         ; $00299A MOVE.W  D0,$0016(A1)
        DC.W    $3028,$009C         ; $00299E MOVE.W  $009C(A0),D0
        DC.W    $E940               ; $0029A2 ASL.W  #4,D0
        DC.W    $3200               ; $0029A4 MOVE.W  D0,D1
        DC.W    $9278,$C054         ; $0029A6 SUB.W  $C054.W,D1
        DC.W    $4441               ; $0029AA NEG.W  D1
        DC.W    $3341,$0004         ; $0029AC MOVE.W  D1,$0004(A1)
        DC.W    $D078,$C0E4         ; $0029B0 ADD.W  $C0E4.W,D0
        DC.W    $D068,$0032         ; $0029B4 ADD.W  $0032(A0),D0
        DC.W    $3340,$0018         ; $0029B8 MOVE.W  D0,$0018(A1)
        DC.W    $3378,$C056,$0006   ; $0029BC MOVE.W  $C056.W,$0006(A1)
        DC.W    $3028,$0034         ; $0029C2 MOVE.W  $0034(A0),D0
        DC.W    $3340,$001A         ; $0029C6 MOVE.W  D0,$001A(A1)
        DC.W    $3028,$003A         ; $0029CA MOVE.W  $003A(A0),D0
        DC.W    $E640               ; $0029CE ASR.W  #3,D0
        DC.W    $3200               ; $0029D0 MOVE.W  D0,D1
        DC.W    $D078,$C0C8         ; $0029D2 ADD.W  $C0C8.W,D0
        DC.W    $3340,$0008         ; $0029D6 MOVE.W  D0,$0008(A1)
        DC.W    $3028,$0044         ; $0029DA MOVE.W  $0044(A0),D0
        DC.W    $E640               ; $0029DE ASR.W  #3,D0
        DC.W    $D041               ; $0029E0 ADD.W  D1,D0
        DC.W    $4440               ; $0029E2 NEG.W  D0
        DC.W    $3340,$001C         ; $0029E4 MOVE.W  D0,$001C(A1)
        DC.W    $3028,$003C         ; $0029E8 MOVE.W  $003C(A0),D0
        DC.W    $D068,$0096         ; $0029EC ADD.W  $0096(A0),D0
        DC.W    $E640               ; $0029F0 ASR.W  #3,D0
        DC.W    $3200               ; $0029F2 MOVE.W  D0,D1
        DC.W    $D078,$C0CA         ; $0029F4 ADD.W  $C0CA.W,D0
        DC.W    $4440               ; $0029F8 NEG.W  D0
        DC.W    $3340,$000A         ; $0029FA MOVE.W  D0,$000A(A1)
        DC.W    $3028,$0046         ; $0029FE MOVE.W  $0046(A0),D0
        DC.W    $E640               ; $002A02 ASR.W  #3,D0
        DC.W    $9240               ; $002A04 SUB.W  D0,D1
        DC.W    $3341,$001E         ; $002A06 MOVE.W  D1,$001E(A1)
        DC.W    $3028,$003E         ; $002A0A MOVE.W  $003E(A0),D0
        DC.W    $E640               ; $002A0E ASR.W  #3,D0
        DC.W    $3200               ; $002A10 MOVE.W  D0,D1
        DC.W    $D078,$C0CC         ; $002A12 ADD.W  $C0CC.W,D0
        DC.W    $3340,$000C         ; $002A16 MOVE.W  D0,$000C(A1)
        DC.W    $3028,$004A         ; $002A1A MOVE.W  $004A(A0),D0
        DC.W    $D068,$004C         ; $002A1E ADD.W  $004C(A0),D0
        DC.W    $EA40               ; $002A22 ASR.W  #5,D0
        DC.W    $9041               ; $002A24 SUB.W  D1,D0
        DC.W    $3340,$0020         ; $002A26 MOVE.W  D0,$0020(A1)
        DC.W    $3028,$0090         ; $002A2A MOVE.W  $0090(A0),D0
        DC.W    $E640               ; $002A2E ASR.W  #3,D0
        DC.W    $3340,$0032         ; $002A30 MOVE.W  D0,$0032(A1)
        DC.W    $3340,$0046         ; $002A34 MOVE.W  D0,$0046(A1)
        DC.W    $3028,$00BC         ; $002A38 MOVE.W  $00BC(A0),D0
        DC.W    $E640               ; $002A3C ASR.W  #3,D0
        DC.W    $3340,$0030         ; $002A3E MOVE.W  D0,$0030(A1)
        DC.W    $3340,$0044         ; $002A42 MOVE.W  D0,$0044(A1)
        DC.W    $3340,$0058         ; $002A46 MOVE.W  D0,$0058(A1)
        DC.W    $4A38,$C31C         ; $002A4A TST.B  $C31C.W
        DC.W    $6722               ; $002A4E BEQ.S  loc_002A72
        DC.W    $0828,$0003,$00E5   ; $002A50 BTST    #3,$00E5(A0)
        DC.W    $671A               ; $002A56 BEQ.S  loc_002A72
        DC.W    $7000               ; $002A58 MOVEQ   #$00,D0
        DC.W    $3280               ; $002A5A MOVE.W  D0,(A1)
        DC.W    $3340,$0014         ; $002A5C MOVE.W  D0,$0014(A1)
        DC.W    $3340,$0028         ; $002A60 MOVE.W  D0,$0028(A1)
        DC.W    $3340,$003C         ; $002A64 MOVE.W  D0,$003C(A1)
        DC.W    $3340,$0050         ; $002A68 MOVE.W  D0,$0050(A1)
        DC.W    $3340,$0064         ; $002A6C MOVE.W  D0,$0064(A1)
        DC.W    $4E75               ; $002A70 RTS
loc_002A72:
        DC.W    $7001               ; $002A72 MOVEQ   #$01,D0
        DC.W    $3280               ; $002A74 MOVE.W  D0,(A1)
        DC.W    $3340,$0014         ; $002A76 MOVE.W  D0,$0014(A1)
        DC.W    $3340,$0028         ; $002A7A MOVE.W  D0,$0028(A1)
        DC.W    $3340,$003C         ; $002A7E MOVE.W  D0,$003C(A1)
        DC.W    $3340,$0050         ; $002A82 MOVE.W  D0,$0050(A1)
        DC.W    $3028,$008A         ; $002A86 MOVE.W  $008A(A0),D0
        DC.W    $6738               ; $002A8A BEQ.S  loc_002AC4
        DC.W    $5340               ; $002A8C SUBQ.W  #1,D0
        DC.W    $671A               ; $002A8E BEQ.S  loc_002AAA
        DC.W    $2378,$C74C,$0024   ; $002A90 MOVE.L  $C74C.W,$0024(A1)
        DC.W    $337C,$0001,$0064   ; $002A96 MOVE.W  #$0001,$0064(A1)
        DC.W    $4A68,$008C         ; $002A9C TST.W  $008C(A0)
        DC.W    $673A               ; $002AA0 BEQ.S  loc_002ADC
        DC.W    $337C,$0000,$0064   ; $002AA2 MOVE.W  #$0000,$0064(A1)
        DC.W    $4E75               ; $002AA8 RTS
loc_002AAA:
        DC.W    $2378,$C748,$0024   ; $002AAA MOVE.L  $C748.W,$0024(A1)
        DC.W    $337C,$0001,$0064   ; $002AB0 MOVE.W  #$0001,$0064(A1)
        DC.W    $4A68,$008C         ; $002AB6 TST.W  $008C(A0)
        DC.W    $6720               ; $002ABA BEQ.S  loc_002ADC
        DC.W    $337C,$0000,$0064   ; $002ABC MOVE.W  #$0000,$0064(A1)
        DC.W    $4E75               ; $002AC2 RTS
loc_002AC4:
        DC.W    $2378,$C710,$0024   ; $002AC4 MOVE.L  $C710.W,$0024(A1)
        DC.W    $337C,$0001,$0064   ; $002ACA MOVE.W  #$0001,$0064(A1)
        DC.W    $4A68,$008C         ; $002AD0 TST.W  $008C(A0)
        DC.W    $6706               ; $002AD4 BEQ.S  loc_002ADC
        DC.W    $337C,$0000,$0064   ; $002AD6 MOVE.W  #$0000,$0064(A1)
loc_002ADC:
        DC.W    $4E75               ; $002ADC RTS
loc_002ADE:
        DC.W    $2378,$C724,$0024   ; $002ADE MOVE.L  $C724.W,$0024(A1)
        DC.W    $4A68,$008A         ; $002AE4 TST.W  $008A(A0)
        DC.W    $6706               ; $002AE8 BEQ.S  loc_002AF0
        DC.W    $2378,$C750,$0024   ; $002AEA MOVE.L  $C750.W,$0024(A1)
loc_002AF0:
        DC.W    $3028,$0030         ; $002AF0 MOVE.W  $0030(A0),D0
        DC.W    $3340,$0016         ; $002AF4 MOVE.W  D0,$0016(A1)
        DC.W    $3378,$C054,$0004   ; $002AF8 MOVE.W  $C054.W,$0004(A1)
        DC.W    $3028,$009C         ; $002AFE MOVE.W  $009C(A0),D0
        DC.W    $E940               ; $002B02 ASL.W  #4,D0
        DC.W    $D068,$0032         ; $002B04 ADD.W  $0032(A0),D0
        DC.W    $D078,$C0E4         ; $002B08 ADD.W  $C0E4.W,D0
        DC.W    $3340,$0018         ; $002B0C MOVE.W  D0,$0018(A1)
        DC.W    $3378,$C056,$0006   ; $002B10 MOVE.W  $C056.W,$0006(A1)
        DC.W    $3028,$0034         ; $002B16 MOVE.W  $0034(A0),D0
        DC.W    $3340,$001A         ; $002B1A MOVE.W  D0,$001A(A1)
        DC.W    $3028,$003A         ; $002B1E MOVE.W  $003A(A0),D0
        DC.W    $E640               ; $002B22 ASR.W  #3,D0
        DC.W    $3200               ; $002B24 MOVE.W  D0,D1
        DC.W    $D078,$C0C8         ; $002B26 ADD.W  $C0C8.W,D0
        DC.W    $3340,$0008         ; $002B2A MOVE.W  D0,$0008(A1)
        DC.W    $4441               ; $002B2E NEG.W  D1
        DC.W    $3341,$001C         ; $002B30 MOVE.W  D1,$001C(A1)
        DC.W    $3028,$003C         ; $002B34 MOVE.W  $003C(A0),D0
        DC.W    $D068,$0096         ; $002B38 ADD.W  $0096(A0),D0
        DC.W    $9068,$0046         ; $002B3C SUB.W  $0046(A0),D0
        DC.W    $E640               ; $002B40 ASR.W  #3,D0
        DC.W    $3200               ; $002B42 MOVE.W  D0,D1
        DC.W    $D078,$C0CA         ; $002B44 ADD.W  $C0CA.W,D0
        DC.W    $4440               ; $002B48 NEG.W  D0
        DC.W    $3340,$000A         ; $002B4A MOVE.W  D0,$000A(A1)
        DC.W    $3341,$001E         ; $002B4E MOVE.W  D1,$001E(A1)
        DC.W    $3028,$003E         ; $002B52 MOVE.W  $003E(A0),D0
        DC.W    $E640               ; $002B56 ASR.W  #3,D0
        DC.W    $3200               ; $002B58 MOVE.W  D0,D1
        DC.W    $D078,$C0CC         ; $002B5A ADD.W  $C0CC.W,D0
        DC.W    $3340,$000C         ; $002B5E MOVE.W  D0,$000C(A1)
        DC.W    $3028,$004C         ; $002B62 MOVE.W  $004C(A0),D0
        DC.W    $E840               ; $002B66 ASR.W  #4,D0
        DC.W    $9041               ; $002B68 SUB.W  D1,D0
        DC.W    $3340,$0020         ; $002B6A MOVE.W  D0,$0020(A1)
        DC.W    $3028,$0090         ; $002B6E MOVE.W  $0090(A0),D0
        DC.W    $E640               ; $002B72 ASR.W  #3,D0
        DC.W    $3340,$0032         ; $002B74 MOVE.W  D0,$0032(A1)
        DC.W    $3340,$0046         ; $002B78 MOVE.W  D0,$0046(A1)
        DC.W    $3028,$00BC         ; $002B7C MOVE.W  $00BC(A0),D0
        DC.W    $E640               ; $002B80 ASR.W  #3,D0
        DC.W    $3340,$0030         ; $002B82 MOVE.W  D0,$0030(A1)
        DC.W    $3340,$0044         ; $002B86 MOVE.W  D0,$0044(A1)
        DC.W    $3238,$C088         ; $002B8A MOVE.W  $C088.W,D1
        DC.W    $3028,$008E         ; $002B8E MOVE.W  $008E(A0),D0
        DC.W    $48C1               ; $002B92 EXT.L   D1
        DC.W    $48C0               ; $002B94 EXT.L   D0
        DC.W    $D081               ; $002B96 ADD.L  D1,D0
        DC.W    $E280               ; $002B98 ASR.L  #1,D0
        DC.W    $31C0,$C088         ; $002B9A MOVE.W  D0,$C088.W
        DC.W    $4440               ; $002B9E NEG.W  D0
        DC.W    $3200               ; $002BA0 MOVE.W  D0,D1
        DC.W    $EE41               ; $002BA2 ASR.W  #7,D1
        DC.W    $EC40               ; $002BA4 ASR.W  #6,D0
        DC.W    $D041               ; $002BA6 ADD.W  D1,D0
        DC.W    $E340               ; $002BA8 ASL.W  #1,D0
        DC.W    $3340,$0070         ; $002BAA MOVE.W  D0,$0070(A1)
        DC.W    $4E75               ; $002BAE RTS
        DC.W    $41F8,$9000         ; $002BB0 LEA     $9000.W,A0
        DC.W    $43F9,$00FF,$6100   ; $002BB4 LEA     $00FF6100,A1
        DC.W    $45F9,$00FF,$6330   ; $002BBA LEA     $00FF6330,A2
        DC.W    $0838,$0005,$C30E   ; $002BC0 BTST    #5,$C30E.W
        DC.W    $661E               ; $002BC6 BNE.S  loc_002BE6
        DC.W    $4EBA,$008E         ; $002BC8 JSR     loc_002C58(PC)
        DC.W    $4A78,$C04C         ; $002BCC TST.W  $C04C.W
        DC.W    $660C               ; $002BD0 BNE.S  loc_002BDE
        DC.W    $4EBA,$0108         ; $002BD2 JSR     loc_002CDC(PC)
        DC.W    $4EBA,$01F2         ; $002BD6 JSR     loc_002DCA(PC)
        DC.W    $4EFA,$02EA         ; $002BDA JMP     loc_002EC6(PC)
loc_002BDE:
        DC.W    $4EBA,$0324         ; $002BDE JSR     loc_002F04(PC)
        DC.W    $4EFA,$02BA         ; $002BE2 JMP     loc_002E9E(PC)
loc_002BE6:
        DC.W    $7002               ; $002BE6 MOVEQ   #$02,D0
        DC.W    $3340,$0014         ; $002BE8 MOVE.W  D0,$0014(A1)
        DC.W    $3340,$0028         ; $002BEC MOVE.W  D0,$0028(A1)
        DC.W    $3340,$003C         ; $002BF0 MOVE.W  D0,$003C(A1)
        DC.W    $3340,$0050         ; $002BF4 MOVE.W  D0,$0050(A1)
        DC.W    $4EBA,$0536         ; $002BF8 JSR     loc_003130(PC)
        DC.W    $4EBA,$0412         ; $002BFC JSR     loc_003010(PC)
        DC.W    $4EFA,$01C8         ; $002C00 JMP     loc_002DCA(PC)
        DC.W    $41F8,$9F00         ; $002C04 LEA     $9F00.W,A0
        DC.W    $43F9,$00FF,$6330   ; $002C08 LEA     $00FF6330,A1
        DC.W    $45F9,$00FF,$6100   ; $002C0E LEA     $00FF6100,A2
        DC.W    $0838,$0005,$C30E   ; $002C14 BTST    #5,$C30E.W
        DC.W    $661E               ; $002C1A BNE.S  loc_002C3A
        DC.W    $4EBA,$007C         ; $002C1C JSR     loc_002C9A(PC)
        DC.W    $4A78,$C04C         ; $002C20 TST.W  $C04C.W
        DC.W    $660C               ; $002C24 BNE.S  loc_002C32
        DC.W    $4EBA,$00B4         ; $002C26 JSR     loc_002CDC(PC)
        DC.W    $4EBA,$0208         ; $002C2A JSR     loc_002E34(PC)
        DC.W    $4EFA,$0296         ; $002C2E JMP     loc_002EC6(PC)
loc_002C32:
        DC.W    $4EBA,$02D0         ; $002C32 JSR     loc_002F04(PC)
        DC.W    $4EFA,$027A         ; $002C36 JMP     loc_002EB2(PC)
loc_002C3A:
        DC.W    $7002               ; $002C3A MOVEQ   #$02,D0
        DC.W    $3340,$0014         ; $002C3C MOVE.W  D0,$0014(A1)
        DC.W    $3340,$0028         ; $002C40 MOVE.W  D0,$0028(A1)
        DC.W    $3340,$003C         ; $002C44 MOVE.W  D0,$003C(A1)
        DC.W    $3340,$0050         ; $002C48 MOVE.W  D0,$0050(A1)
        DC.W    $4EBA,$04E2         ; $002C4C JSR     loc_003130(PC)
        DC.W    $4EBA,$03BE         ; $002C50 JSR     loc_003010(PC)
        DC.W    $4EFA,$01DE         ; $002C54 JMP     loc_002E34(PC)
loc_002C58:
        DC.W    $7000               ; $002C58 MOVEQ   #$00,D0
        DC.W    $4A68,$00C0         ; $002C5A TST.W  $00C0(A0)
        DC.W    $6728               ; $002C5E BEQ.S  loc_002C88
        DC.W    $7001               ; $002C60 MOVEQ   #$01,D0
        DC.W    $4A38,$9FE4         ; $002C62 TST.B  $9FE4.W
        DC.W    $6606               ; $002C66 BNE.S  loc_002C6E
        DC.W    $4A38,$B4FC         ; $002C68 TST.B  $B4FC.W
        DC.W    $670C               ; $002C6C BEQ.S  loc_002C7A
loc_002C6E:
        DC.W    $0828,$0003,$00E5   ; $002C6E BTST    #3,$00E5(A0)
        DC.W    $6712               ; $002C74 BEQ.S  loc_002C88
loc_002C76:
        DC.W    $7000               ; $002C76 MOVEQ   #$00,D0
        DC.W    $600E               ; $002C78 BRA.S  loc_002C88
loc_002C7A:
        DC.W    $0838,$0003,$9FE5   ; $002C7A BTST    #3,$9FE5.W
        DC.W    $6706               ; $002C80 BEQ.S  loc_002C88
        DC.W    $4A28,$00E4         ; $002C82 TST.B  $00E4(A0)
        DC.W    $66EE               ; $002C86 BNE.S  loc_002C76
loc_002C88:
        DC.W    $3540,$0118         ; $002C88 MOVE.W  D0,$0118(A2)
        DC.W    $3540,$012C         ; $002C8C MOVE.W  D0,$012C(A2)
        DC.W    $3540,$0140         ; $002C90 MOVE.W  D0,$0140(A2)
        DC.W    $3540,$0154         ; $002C94 MOVE.W  D0,$0154(A2)
        DC.W    $4E75               ; $002C98 RTS
loc_002C9A:
        DC.W    $7000               ; $002C9A MOVEQ   #$00,D0
        DC.W    $4A68,$00C0         ; $002C9C TST.W  $00C0(A0)
        DC.W    $6728               ; $002CA0 BEQ.S  loc_002CCA
        DC.W    $7001               ; $002CA2 MOVEQ   #$01,D0
        DC.W    $4A38,$90E4         ; $002CA4 TST.B  $90E4.W
        DC.W    $6606               ; $002CA8 BNE.S  loc_002CB0
        DC.W    $4A38,$B0FC         ; $002CAA TST.B  $B0FC.W
        DC.W    $670C               ; $002CAE BEQ.S  loc_002CBC
loc_002CB0:
        DC.W    $0828,$0003,$00E5   ; $002CB0 BTST    #3,$00E5(A0)
        DC.W    $6712               ; $002CB6 BEQ.S  loc_002CCA
loc_002CB8:
        DC.W    $7000               ; $002CB8 MOVEQ   #$00,D0
        DC.W    $600E               ; $002CBA BRA.S  loc_002CCA
loc_002CBC:
        DC.W    $0838,$0003,$90E5   ; $002CBC BTST    #3,$90E5.W
        DC.W    $6706               ; $002CC2 BEQ.S  loc_002CCA
        DC.W    $4A28,$00E4         ; $002CC4 TST.B  $00E4(A0)
        DC.W    $66EE               ; $002CC8 BNE.S  loc_002CB8
loc_002CCA:
        DC.W    $3540,$0118         ; $002CCA MOVE.W  D0,$0118(A2)
        DC.W    $3540,$012C         ; $002CCE MOVE.W  D0,$012C(A2)
        DC.W    $3540,$0140         ; $002CD2 MOVE.W  D0,$0140(A2)
        DC.W    $3540,$0154         ; $002CD6 MOVE.W  D0,$0154(A2)
        DC.W    $4E75               ; $002CDA RTS
loc_002CDC:
        DC.W    $3028,$0030         ; $002CDC MOVE.W  $0030(A0),D0
        DC.W    $3340,$0016         ; $002CE0 MOVE.W  D0,$0016(A1)
        DC.W    $3540,$011A         ; $002CE4 MOVE.W  D0,$011A(A2)
        DC.W    $3028,$009C         ; $002CE8 MOVE.W  $009C(A0),D0
        DC.W    $E940               ; $002CEC ASL.W  #4,D0
        DC.W    $3200               ; $002CEE MOVE.W  D0,D1
        DC.W    $9278,$C054         ; $002CF0 SUB.W  $C054.W,D1
        DC.W    $4441               ; $002CF4 NEG.W  D1
        DC.W    $3341,$0004         ; $002CF6 MOVE.W  D1,$0004(A1)
        DC.W    $D078,$C0E4         ; $002CFA ADD.W  $C0E4.W,D0
        DC.W    $D068,$0032         ; $002CFE ADD.W  $0032(A0),D0
        DC.W    $3340,$0018         ; $002D02 MOVE.W  D0,$0018(A1)
        DC.W    $3540,$011C         ; $002D06 MOVE.W  D0,$011C(A2)
        DC.W    $3378,$C056,$0006   ; $002D0A MOVE.W  $C056.W,$0006(A1)
        DC.W    $3028,$0034         ; $002D10 MOVE.W  $0034(A0),D0
        DC.W    $3340,$001A         ; $002D14 MOVE.W  D0,$001A(A1)
        DC.W    $3540,$011E         ; $002D18 MOVE.W  D0,$011E(A2)
        DC.W    $3028,$003A         ; $002D1C MOVE.W  $003A(A0),D0
        DC.W    $E640               ; $002D20 ASR.W  #3,D0
        DC.W    $3200               ; $002D22 MOVE.W  D0,D1
        DC.W    $D078,$C0C8         ; $002D24 ADD.W  $C0C8.W,D0
        DC.W    $D078,$C0AE         ; $002D28 ADD.W  $C0AE.W,D0
        DC.W    $3340,$0008         ; $002D2C MOVE.W  D0,$0008(A1)
        DC.W    $3028,$0044         ; $002D30 MOVE.W  $0044(A0),D0
        DC.W    $E640               ; $002D34 ASR.W  #3,D0
        DC.W    $D041               ; $002D36 ADD.W  D1,D0
        DC.W    $4440               ; $002D38 NEG.W  D0
        DC.W    $3340,$001C         ; $002D3A MOVE.W  D0,$001C(A1)
        DC.W    $3540,$0120         ; $002D3E MOVE.W  D0,$0120(A2)
        DC.W    $3028,$003C         ; $002D42 MOVE.W  $003C(A0),D0
        DC.W    $D068,$0096         ; $002D46 ADD.W  $0096(A0),D0
        DC.W    $E640               ; $002D4A ASR.W  #3,D0
        DC.W    $3200               ; $002D4C MOVE.W  D0,D1
        DC.W    $D078,$C0CA         ; $002D4E ADD.W  $C0CA.W,D0
        DC.W    $D078,$C0B0         ; $002D52 ADD.W  $C0B0.W,D0
        DC.W    $4440               ; $002D56 NEG.W  D0
        DC.W    $3340,$000A         ; $002D58 MOVE.W  D0,$000A(A1)
        DC.W    $3028,$0046         ; $002D5C MOVE.W  $0046(A0),D0
        DC.W    $E640               ; $002D60 ASR.W  #3,D0
        DC.W    $9240               ; $002D62 SUB.W  D0,D1
        DC.W    $3341,$001E         ; $002D64 MOVE.W  D1,$001E(A1)
        DC.W    $3541,$0122         ; $002D68 MOVE.W  D1,$0122(A2)
        DC.W    $3028,$003E         ; $002D6C MOVE.W  $003E(A0),D0
        DC.W    $E640               ; $002D70 ASR.W  #3,D0
        DC.W    $3200               ; $002D72 MOVE.W  D0,D1
        DC.W    $D078,$C0CC         ; $002D74 ADD.W  $C0CC.W,D0
        DC.W    $D078,$C0B2         ; $002D78 ADD.W  $C0B2.W,D0
        DC.W    $3340,$000C         ; $002D7C MOVE.W  D0,$000C(A1)
        DC.W    $3028,$004A         ; $002D80 MOVE.W  $004A(A0),D0
        DC.W    $D068,$004C         ; $002D84 ADD.W  $004C(A0),D0
        DC.W    $EA40               ; $002D88 ASR.W  #5,D0
        DC.W    $9041               ; $002D8A SUB.W  D1,D0
        DC.W    $3340,$0020         ; $002D8C MOVE.W  D0,$0020(A1)
        DC.W    $3540,$0124         ; $002D90 MOVE.W  D0,$0124(A2)
        DC.W    $3028,$0090         ; $002D94 MOVE.W  $0090(A0),D0
        DC.W    $E640               ; $002D98 ASR.W  #3,D0
        DC.W    $3340,$0032         ; $002D9A MOVE.W  D0,$0032(A1)
        DC.W    $3340,$0046         ; $002D9E MOVE.W  D0,$0046(A1)
        DC.W    $3540,$0136         ; $002DA2 MOVE.W  D0,$0136(A2)
        DC.W    $3540,$014A         ; $002DA6 MOVE.W  D0,$014A(A2)
        DC.W    $3028,$00BC         ; $002DAA MOVE.W  $00BC(A0),D0
        DC.W    $E640               ; $002DAE ASR.W  #3,D0
        DC.W    $3340,$0030         ; $002DB0 MOVE.W  D0,$0030(A1)
        DC.W    $3340,$0044         ; $002DB4 MOVE.W  D0,$0044(A1)
        DC.W    $3340,$0058         ; $002DB8 MOVE.W  D0,$0058(A1)
        DC.W    $3540,$0134         ; $002DBC MOVE.W  D0,$0134(A2)
        DC.W    $3540,$0148         ; $002DC0 MOVE.W  D0,$0148(A2)
        DC.W    $3540,$015C         ; $002DC4 MOVE.W  D0,$015C(A2)
        DC.W    $4E75               ; $002DC8 RTS
loc_002DCA:
        DC.W    $3028,$008A         ; $002DCA MOVE.W  $008A(A0),D0
        DC.W    $6744               ; $002DCE BEQ.S  loc_002E14
        DC.W    $5340               ; $002DD0 SUBQ.W  #1,D0
        DC.W    $6720               ; $002DD2 BEQ.S  loc_002DF4
        DC.W    $2378,$C74C,$0024   ; $002DD4 MOVE.L  $C74C.W,$0024(A1)
        DC.W    $2578,$C74C,$0128   ; $002DDA MOVE.L  $C74C.W,$0128(A2)
        DC.W    $337C,$0001,$0064   ; $002DE0 MOVE.W  #$0001,$0064(A1)
        DC.W    $4A68,$008C         ; $002DE6 TST.W  $008C(A0)
        DC.W    $6746               ; $002DEA BEQ.S  loc_002E32
        DC.W    $337C,$0000,$0064   ; $002DEC MOVE.W  #$0000,$0064(A1)
        DC.W    $4E75               ; $002DF2 RTS
loc_002DF4:
        DC.W    $2378,$C748,$0024   ; $002DF4 MOVE.L  $C748.W,$0024(A1)
        DC.W    $2578,$C748,$0128   ; $002DFA MOVE.L  $C748.W,$0128(A2)
        DC.W    $337C,$0001,$0064   ; $002E00 MOVE.W  #$0001,$0064(A1)
        DC.W    $4A68,$008C         ; $002E06 TST.W  $008C(A0)
        DC.W    $6726               ; $002E0A BEQ.S  loc_002E32
        DC.W    $337C,$0000,$0064   ; $002E0C MOVE.W  #$0000,$0064(A1)
        DC.W    $4E75               ; $002E12 RTS
loc_002E14:
        DC.W    $2378,$C710,$0024   ; $002E14 MOVE.L  $C710.W,$0024(A1)
        DC.W    $2578,$C710,$0128   ; $002E1A MOVE.L  $C710.W,$0128(A2)
        DC.W    $337C,$0001,$0064   ; $002E20 MOVE.W  #$0001,$0064(A1)
        DC.W    $4A68,$008C         ; $002E26 TST.W  $008C(A0)
        DC.W    $6706               ; $002E2A BEQ.S  loc_002E32
        DC.W    $337C,$0000,$0064   ; $002E2C MOVE.W  #$0000,$0064(A1)
loc_002E32:
        DC.W    $4E75               ; $002E32 RTS
loc_002E34:
        DC.W    $3028,$008A         ; $002E34 MOVE.W  $008A(A0),D0
        DC.W    $6744               ; $002E38 BEQ.S  loc_002E7E
        DC.W    $5340               ; $002E3A SUBQ.W  #1,D0
        DC.W    $6720               ; $002E3C BEQ.S  loc_002E5E
        DC.W    $2378,$C760,$0024   ; $002E3E MOVE.L  $C760.W,$0024(A1)
        DC.W    $2578,$C760,$0128   ; $002E44 MOVE.L  $C760.W,$0128(A2)
        DC.W    $337C,$0001,$0064   ; $002E4A MOVE.W  #$0001,$0064(A1)
        DC.W    $4A68,$008C         ; $002E50 TST.W  $008C(A0)
        DC.W    $6746               ; $002E54 BEQ.S  loc_002E9C
        DC.W    $337C,$0000,$0064   ; $002E56 MOVE.W  #$0000,$0064(A1)
        DC.W    $4E75               ; $002E5C RTS
loc_002E5E:
        DC.W    $2378,$C75C,$0024   ; $002E5E MOVE.L  $C75C.W,$0024(A1)
        DC.W    $2578,$C75C,$0128   ; $002E64 MOVE.L  $C75C.W,$0128(A2)
        DC.W    $337C,$0001,$0064   ; $002E6A MOVE.W  #$0001,$0064(A1)
        DC.W    $4A68,$008C         ; $002E70 TST.W  $008C(A0)
        DC.W    $6726               ; $002E74 BEQ.S  loc_002E9C
        DC.W    $337C,$0000,$0064   ; $002E76 MOVE.W  #$0000,$0064(A1)
        DC.W    $4E75               ; $002E7C RTS
loc_002E7E:
        DC.W    $2378,$C754,$0024   ; $002E7E MOVE.L  $C754.W,$0024(A1)
        DC.W    $2578,$C754,$0128   ; $002E84 MOVE.L  $C754.W,$0128(A2)
        DC.W    $337C,$0001,$0064   ; $002E8A MOVE.W  #$0001,$0064(A1)
        DC.W    $4A68,$008C         ; $002E90 TST.W  $008C(A0)
        DC.W    $6706               ; $002E94 BEQ.S  loc_002E9C
        DC.W    $337C,$0000,$0064   ; $002E96 MOVE.W  #$0000,$0064(A1)
loc_002E9C:
        DC.W    $4E75               ; $002E9C RTS
loc_002E9E:
        DC.W    $2378,$C724,$0024   ; $002E9E MOVE.L  $C724.W,$0024(A1)
        DC.W    $4A68,$008A         ; $002EA4 TST.W  $008A(A0)
        DC.W    $6706               ; $002EA8 BEQ.S  loc_002EB0
        DC.W    $2378,$C750,$0024   ; $002EAA MOVE.L  $C750.W,$0024(A1)
loc_002EB0:
        DC.W    $4E75               ; $002EB0 RTS
loc_002EB2:
        DC.W    $2378,$C758,$0024   ; $002EB2 MOVE.L  $C758.W,$0024(A1)
        DC.W    $4A68,$008A         ; $002EB8 TST.W  $008A(A0)
        DC.W    $6706               ; $002EBC BEQ.S  loc_002EC4
        DC.W    $2378,$C764,$0024   ; $002EBE MOVE.L  $C764.W,$0024(A1)
loc_002EC4:
        DC.W    $4E75               ; $002EC4 RTS
loc_002EC6:
        DC.W    $4A38,$C31C         ; $002EC6 TST.B  $C31C.W
        DC.W    $6722               ; $002ECA BEQ.S  loc_002EEE
        DC.W    $0828,$0003,$00E5   ; $002ECC BTST    #3,$00E5(A0)
        DC.W    $671A               ; $002ED2 BEQ.S  loc_002EEE
        DC.W    $7000               ; $002ED4 MOVEQ   #$00,D0
        DC.W    $3280               ; $002ED6 MOVE.W  D0,(A1)
        DC.W    $3340,$0014         ; $002ED8 MOVE.W  D0,$0014(A1)
        DC.W    $3340,$0028         ; $002EDC MOVE.W  D0,$0028(A1)
        DC.W    $3340,$003C         ; $002EE0 MOVE.W  D0,$003C(A1)
        DC.W    $3340,$0050         ; $002EE4 MOVE.W  D0,$0050(A1)
        DC.W    $3340,$0064         ; $002EE8 MOVE.W  D0,$0064(A1)
        DC.W    $4E75               ; $002EEC RTS
loc_002EEE:
        DC.W    $7001               ; $002EEE MOVEQ   #$01,D0
        DC.W    $3280               ; $002EF0 MOVE.W  D0,(A1)
        DC.W    $3340,$0014         ; $002EF2 MOVE.W  D0,$0014(A1)
        DC.W    $3340,$0028         ; $002EF6 MOVE.W  D0,$0028(A1)
        DC.W    $3340,$003C         ; $002EFA MOVE.W  D0,$003C(A1)
        DC.W    $3340,$0050         ; $002EFE MOVE.W  D0,$0050(A1)
        DC.W    $4E75               ; $002F02 RTS
loc_002F04:
        DC.W    $3028,$0030         ; $002F04 MOVE.W  $0030(A0),D0
        DC.W    $3340,$0016         ; $002F08 MOVE.W  D0,$0016(A1)
        DC.W    $3540,$011A         ; $002F0C MOVE.W  D0,$011A(A2)
        DC.W    $3378,$C054,$0004   ; $002F10 MOVE.W  $C054.W,$0004(A1)
        DC.W    $3028,$009C         ; $002F16 MOVE.W  $009C(A0),D0
        DC.W    $E940               ; $002F1A ASL.W  #4,D0
        DC.W    $D068,$0032         ; $002F1C ADD.W  $0032(A0),D0
        DC.W    $D078,$C0E4         ; $002F20 ADD.W  $C0E4.W,D0
        DC.W    $3340,$0018         ; $002F24 MOVE.W  D0,$0018(A1)
        DC.W    $3540,$011C         ; $002F28 MOVE.W  D0,$011C(A2)
        DC.W    $3378,$C056,$0006   ; $002F2C MOVE.W  $C056.W,$0006(A1)
        DC.W    $3028,$0034         ; $002F32 MOVE.W  $0034(A0),D0
        DC.W    $3340,$001A         ; $002F36 MOVE.W  D0,$001A(A1)
        DC.W    $3540,$011E         ; $002F3A MOVE.W  D0,$011E(A2)
        DC.W    $3028,$003A         ; $002F3E MOVE.W  $003A(A0),D0
        DC.W    $E640               ; $002F42 ASR.W  #3,D0
        DC.W    $3200               ; $002F44 MOVE.W  D0,D1
        DC.W    $D078,$C0C8         ; $002F46 ADD.W  $C0C8.W,D0
        DC.W    $D078,$C0AE         ; $002F4A ADD.W  $C0AE.W,D0
        DC.W    $3340,$0008         ; $002F4E MOVE.W  D0,$0008(A1)
        DC.W    $4441               ; $002F52 NEG.W  D1
        DC.W    $3341,$001C         ; $002F54 MOVE.W  D1,$001C(A1)
        DC.W    $3541,$0120         ; $002F58 MOVE.W  D1,$0120(A2)
        DC.W    $3028,$003C         ; $002F5C MOVE.W  $003C(A0),D0
        DC.W    $D068,$0096         ; $002F60 ADD.W  $0096(A0),D0
        DC.W    $9068,$0046         ; $002F64 SUB.W  $0046(A0),D0
        DC.W    $E640               ; $002F68 ASR.W  #3,D0
        DC.W    $3200               ; $002F6A MOVE.W  D0,D1
        DC.W    $D078,$C0CA         ; $002F6C ADD.W  $C0CA.W,D0
        DC.W    $D078,$C0B0         ; $002F70 ADD.W  $C0B0.W,D0
        DC.W    $4440               ; $002F74 NEG.W  D0
        DC.W    $3340,$000A         ; $002F76 MOVE.W  D0,$000A(A1)
        DC.W    $3341,$001E         ; $002F7A MOVE.W  D1,$001E(A1)
        DC.W    $3028,$0046         ; $002F7E MOVE.W  $0046(A0),D0
        DC.W    $E640               ; $002F82 ASR.W  #3,D0
        DC.W    $9240               ; $002F84 SUB.W  D0,D1
        DC.W    $3541,$0122         ; $002F86 MOVE.W  D1,$0122(A2)
        DC.W    $3028,$003E         ; $002F8A MOVE.W  $003E(A0),D0
        DC.W    $E640               ; $002F8E ASR.W  #3,D0
        DC.W    $3200               ; $002F90 MOVE.W  D0,D1
        DC.W    $D078,$C0CC         ; $002F92 ADD.W  $C0CC.W,D0
        DC.W    $D078,$C0B2         ; $002F96 ADD.W  $C0B2.W,D0
        DC.W    $3340,$000C         ; $002F9A MOVE.W  D0,$000C(A1)
        DC.W    $3028,$004C         ; $002F9E MOVE.W  $004C(A0),D0
        DC.W    $E840               ; $002FA2 ASR.W  #4,D0
        DC.W    $9041               ; $002FA4 SUB.W  D1,D0
        DC.W    $3340,$0020         ; $002FA6 MOVE.W  D0,$0020(A1)
        DC.W    $3028,$004A         ; $002FAA MOVE.W  $004A(A0),D0
        DC.W    $D068,$004C         ; $002FAE ADD.W  $004C(A0),D0
        DC.W    $EA40               ; $002FB2 ASR.W  #5,D0
        DC.W    $9041               ; $002FB4 SUB.W  D1,D0
        DC.W    $3540,$0124         ; $002FB6 MOVE.W  D0,$0124(A2)
        DC.W    $3028,$0090         ; $002FBA MOVE.W  $0090(A0),D0
        DC.W    $E640               ; $002FBE ASR.W  #3,D0
        DC.W    $3340,$0032         ; $002FC0 MOVE.W  D0,$0032(A1)
        DC.W    $3340,$0046         ; $002FC4 MOVE.W  D0,$0046(A1)
        DC.W    $3540,$0136         ; $002FC8 MOVE.W  D0,$0136(A2)
        DC.W    $3540,$014A         ; $002FCC MOVE.W  D0,$014A(A2)
        DC.W    $3028,$00BC         ; $002FD0 MOVE.W  $00BC(A0),D0
        DC.W    $E640               ; $002FD4 ASR.W  #3,D0
        DC.W    $3340,$0030         ; $002FD6 MOVE.W  D0,$0030(A1)
        DC.W    $3340,$0044         ; $002FDA MOVE.W  D0,$0044(A1)
        DC.W    $3540,$0134         ; $002FDE MOVE.W  D0,$0134(A2)
        DC.W    $3540,$0148         ; $002FE2 MOVE.W  D0,$0148(A2)
        DC.W    $3540,$015C         ; $002FE6 MOVE.W  D0,$015C(A2)
        DC.W    $3238,$C088         ; $002FEA MOVE.W  $C088.W,D1
        DC.W    $3028,$008E         ; $002FEE MOVE.W  $008E(A0),D0
        DC.W    $48C1               ; $002FF2 EXT.L   D1
        DC.W    $48C0               ; $002FF4 EXT.L   D0
        DC.W    $D081               ; $002FF6 ADD.L  D1,D0
        DC.W    $E280               ; $002FF8 ASR.L  #1,D0
        DC.W    $31C0,$C088         ; $002FFA MOVE.W  D0,$C088.W
        DC.W    $4440               ; $002FFE NEG.W  D0
        DC.W    $3200               ; $003000 MOVE.W  D0,D1
        DC.W    $EE41               ; $003002 ASR.W  #7,D1
        DC.W    $EC40               ; $003004 ASR.W  #6,D0
        DC.W    $D041               ; $003006 ADD.W  D1,D0
        DC.W    $E340               ; $003008 ASL.W  #1,D0
        DC.W    $3340,$0070         ; $00300A MOVE.W  D0,$0070(A1)
        DC.W    $4E75               ; $00300E RTS
loc_003010:
        DC.W    $7000               ; $003010 MOVEQ   #$00,D0
        DC.W    $4A68,$00C0         ; $003012 TST.W  $00C0(A0)
        DC.W    $6702               ; $003016 BEQ.S  loc_00301A
        DC.W    $7001               ; $003018 MOVEQ   #$01,D0
loc_00301A:
        DC.W    $3540,$0118         ; $00301A MOVE.W  D0,$0118(A2)
        DC.W    $3540,$012C         ; $00301E MOVE.W  D0,$012C(A2)
        DC.W    $3540,$0140         ; $003022 MOVE.W  D0,$0140(A2)
        DC.W    $3540,$0154         ; $003026 MOVE.W  D0,$0154(A2)
        DC.W    $3028,$0030         ; $00302A MOVE.W  $0030(A0),D0
        DC.W    $3540,$011A         ; $00302E MOVE.W  D0,$011A(A2)
        DC.W    $3028,$009C         ; $003032 MOVE.W  $009C(A0),D0
        DC.W    $E940               ; $003036 ASL.W  #4,D0
        DC.W    $D078,$C0E4         ; $003038 ADD.W  $C0E4.W,D0
        DC.W    $D068,$0032         ; $00303C ADD.W  $0032(A0),D0
        DC.W    $3540,$011C         ; $003040 MOVE.W  D0,$011C(A2)
        DC.W    $3028,$0034         ; $003044 MOVE.W  $0034(A0),D0
        DC.W    $3540,$011E         ; $003048 MOVE.W  D0,$011E(A2)
        DC.W    $3228,$003A         ; $00304C MOVE.W  $003A(A0),D1
        DC.W    $E641               ; $003050 ASR.W  #3,D1
        DC.W    $3028,$0044         ; $003052 MOVE.W  $0044(A0),D0
        DC.W    $E640               ; $003056 ASR.W  #3,D0
        DC.W    $D041               ; $003058 ADD.W  D1,D0
        DC.W    $4440               ; $00305A NEG.W  D0
        DC.W    $3540,$0120         ; $00305C MOVE.W  D0,$0120(A2)
        DC.W    $3428,$003C         ; $003060 MOVE.W  $003C(A0),D2
        DC.W    $D468,$0096         ; $003064 ADD.W  $0096(A0),D2
        DC.W    $E642               ; $003068 ASR.W  #3,D2
        DC.W    $3028,$0046         ; $00306A MOVE.W  $0046(A0),D0
        DC.W    $E640               ; $00306E ASR.W  #3,D0
        DC.W    $4440               ; $003070 NEG.W  D0
        DC.W    $D042               ; $003072 ADD.W  D2,D0
        DC.W    $3540,$0122         ; $003074 MOVE.W  D0,$0122(A2)
        DC.W    $3628,$003E         ; $003078 MOVE.W  $003E(A0),D3
        DC.W    $E643               ; $00307C ASR.W  #3,D3
        DC.W    $3028,$004A         ; $00307E MOVE.W  $004A(A0),D0
        DC.W    $D068,$004C         ; $003082 ADD.W  $004C(A0),D0
        DC.W    $EA40               ; $003086 ASR.W  #5,D0
        DC.W    $D043               ; $003088 ADD.W  D3,D0
        DC.W    $4440               ; $00308A NEG.W  D0
        DC.W    $3540,$0124         ; $00308C MOVE.W  D0,$0124(A2)
        DC.W    $3028,$0090         ; $003090 MOVE.W  $0090(A0),D0
        DC.W    $E640               ; $003094 ASR.W  #3,D0
        DC.W    $3340,$0032         ; $003096 MOVE.W  D0,$0032(A1)
        DC.W    $3340,$0046         ; $00309A MOVE.W  D0,$0046(A1)
        DC.W    $3540,$0136         ; $00309E MOVE.W  D0,$0136(A2)
        DC.W    $3540,$014A         ; $0030A2 MOVE.W  D0,$014A(A2)
        DC.W    $3028,$00BC         ; $0030A6 MOVE.W  $00BC(A0),D0
        DC.W    $E640               ; $0030AA ASR.W  #3,D0
        DC.W    $3340,$0030         ; $0030AC MOVE.W  D0,$0030(A1)
        DC.W    $3340,$0044         ; $0030B0 MOVE.W  D0,$0044(A1)
        DC.W    $3340,$0058         ; $0030B4 MOVE.W  D0,$0058(A1)
        DC.W    $3540,$0134         ; $0030B8 MOVE.W  D0,$0134(A2)
        DC.W    $3540,$0148         ; $0030BC MOVE.W  D0,$0148(A2)
        DC.W    $3540,$015C         ; $0030C0 MOVE.W  D0,$015C(A2)
        DC.W    $4E75               ; $0030C4 RTS
        DC.W    $0838,$0005,$C30E   ; $0030C6 BTST    #5,$C30E.W
        DC.W    $6746               ; $0030CC BEQ.S  loc_003114
        DC.W    $43F9,$00FF,$6100   ; $0030CE LEA     $00FF6100,A1
        DC.W    $3029,$000A         ; $0030D4 MOVE.W  $000A(A1),D0
        DC.W    $9078,$C0B0         ; $0030D8 SUB.W  $C0B0.W,D0
        DC.W    $323C,$F000         ; $0030DC MOVE.W  #$F000,D1
        DC.W    $B041               ; $0030E0 CMP.W  D1,D0
        DC.W    $6F08               ; $0030E2 BLE.S  loc_0030EC
        DC.W    $0678,$0040,$C0B0   ; $0030E4 ADDI.W  #$0040,$C0B0.W
        DC.W    $3200               ; $0030EA MOVE.W  D0,D1
loc_0030EC:
        DC.W    $3341,$000A         ; $0030EC MOVE.W  D1,$000A(A1)
        DC.W    $3038,$C056         ; $0030F0 MOVE.W  $C056.W,D0
        DC.W    $323C,$0280         ; $0030F4 MOVE.W  #$0280,D1
        DC.W    $4A78,$C8C8         ; $0030F8 TST.W  $C8C8.W
        DC.W    $6704               ; $0030FC BEQ.S  loc_003102
        DC.W    $323C,$0350         ; $0030FE MOVE.W  #$0350,D1
loc_003102:
        DC.W    $B041               ; $003102 CMP.W  D1,D0
        DC.W    $6F0A               ; $003104 BLE.S  loc_003110
        DC.W    $0478,$0010,$C056   ; $003106 SUBI.W  #$0010,$C056.W
        DC.W    $3238,$C056         ; $00310C MOVE.W  $C056.W,D1
loc_003110:
        DC.W    $31C1,$C056         ; $003110 MOVE.W  D1,$C056.W
loc_003114:
        DC.W    $4E75               ; $003114 RTS
        DC.W    $0838,$0005,$C30E   ; $003116 BTST    #5,$C30E.W
        DC.W    $6706               ; $00311C BEQ.S  loc_003124
        DC.W    $0678,$0040,$C0B0   ; $00311E ADDI.W  #$0040,$C0B0.W
loc_003124:
        DC.W    $4E75               ; $003124 RTS
        DC.W    $41F8,$9000         ; $003126 LEA     $9000.W,A0
        DC.W    $43F9,$00FF,$6100   ; $00312A LEA     $00FF6100,A1
loc_003130:
        DC.W    $3378,$C086,$0002   ; $003130 MOVE.W  $C086.W,$0002(A1)
        DC.W    $4EBA,$F85E         ; $003136 JSR     loc_002996(PC)
        DC.W    $3038,$C0AE         ; $00313A MOVE.W  $C0AE.W,D0
        DC.W    $D169,$0008         ; $00313E ADD.W  D0,$0008(A1)
        DC.W    $3038,$C0B0         ; $003142 MOVE.W  $C0B0.W,D0
        DC.W    $D169,$000A         ; $003146 ADD.W  D0,$000A(A1)
        DC.W    $3038,$C0B2         ; $00314A MOVE.W  $C0B2.W,D0
        DC.W    $D169,$000C         ; $00314E ADD.W  D0,$000C(A1)
        DC.W    $4A78,$C8C8         ; $003152 TST.W  $C8C8.W
        DC.W    $6706               ; $003156 BEQ.S  loc_00315E
        DC.W    $0669,$00E0,$0006   ; $003158 ADDI.W  #$00E0,$0006(A1)
loc_00315E:
        DC.W    $4E75               ; $00315E RTS
        DC.W    $33FC,$0001,$00FF,$6100; $003160 MOVE.W  #$0001,$00FF6100
        DC.W    $7070               ; $003168 MOVEQ   #$70,D0
        DC.W    $D078,$C0C6         ; $00316A ADD.W  $C0C6.W,D0
        DC.W    $33C0,$00FF,$60CE   ; $00316E MOVE.W  D0,$00FF60CE
        DC.W    $4A78,$C0BA         ; $003174 TST.W  $C0BA.W
        DC.W    $672A               ; $003178 BEQ.S  loc_0031A4
        DC.W    $33FC,$0002,$00FF,$6100; $00317A MOVE.W  #$0002,$00FF6100
        DC.W    $43F8,$C0BA         ; $003182 LEA     $C0BA.W,A1
        DC.W    $45F9,$00FF,$6102   ; $003186 LEA     $00FF6102,A2
        DC.W    $34D9               ; $00318C MOVE.W  (A1)+,(A2)+
        DC.W    $34D9               ; $00318E MOVE.W  (A1)+,(A2)+
        DC.W    $34D9               ; $003190 MOVE.W  (A1)+,(A2)+
        DC.W    $3019               ; $003192 MOVE.W  (A1)+,D0
        DC.W    $E640               ; $003194 ASR.W  #3,D0
        DC.W    $34C0               ; $003196 MOVE.W  D0,(A2)+
        DC.W    $3019               ; $003198 MOVE.W  (A1)+,D0
        DC.W    $E640               ; $00319A ASR.W  #3,D0
        DC.W    $34C0               ; $00319C MOVE.W  D0,(A2)+
        DC.W    $3019               ; $00319E MOVE.W  (A1)+,D0
        DC.W    $E640               ; $0031A0 ASR.W  #3,D0
        DC.W    $3480               ; $0031A2 MOVE.W  D0,(A2)
loc_0031A4:
        DC.W    $4E75               ; $0031A4 RTS
        DC.W    $7000               ; $0031A6 MOVEQ   #$00,D0
        DC.W    $1038,$C305         ; $0031A8 MOVE.B  $C305.W,D0
        DC.W    $227B,$0004         ; $0031AC MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $0031B0 JMP     (A1)
        DC.W    $0088,$3378,$0088   ; $0031B2 ORI.L  #$33780088,A0
        DC.W    $3272,$0088         ; $0031B8 MOVEA.W -$78(A2,D0.W),A1
        DC.W    $31DE,$0088         ; $0031BC MOVE.W  (A6)+,$0088.W
        DC.W    $31DE,$0088         ; $0031C0 MOVE.W  (A6)+,$0088.W
        DC.W    $31DE,$0088         ; $0031C4 MOVE.W  (A6)+,$0088.W
        DC.W    $31DE,$0088         ; $0031C8 MOVE.W  (A6)+,$0088.W
        DC.W    $322A,$0088         ; $0031CC MOVE.W  $0088(A2),D1
        DC.W    $322A,$0088         ; $0031D0 MOVE.W  $0088(A2),D1
        DC.W    $322A,$0088         ; $0031D4 MOVE.W  $0088(A2),D1
        DC.W    $3204               ; $0031D8 MOVE.W  D4,D1
        DC.W    $0088,$3250,$4A78   ; $0031DA ORI.L  #$32504A78,A0
        DC.W    $C04E               ; $0031E0 AND.W  A6,D0
        DC.W    $676C               ; $0031E2 BEQ.S  loc_003250
        DC.W    $2278,$C258         ; $0031E4 MOVEA.L $C258.W,A1
        DC.W    $137C,$0002,$0000   ; $0031E8 MOVE.B  #$0002,$0000(A1)
        DC.W    $13FC,$0003,$00FF,$6950; $0031EE MOVE.B  #$0003,$00FF6950
        DC.W    $13FC,$0001,$00FF,$6940; $0031F6 MOVE.B  #$0001,$00FF6940
        DC.W    $5838,$C305         ; $0031FE ADDQ.B  #4,$C305.W
        DC.W    $4E75               ; $003202 RTS
        DC.W    $5338,$C308         ; $003204 SUBQ.B  #1,$C308.W
        DC.W    $661A               ; $003208 BNE.S  loc_003224
        DC.W    $3038,$C08E         ; $00320A MOVE.W  $C08E.W,D0
        DC.W    $B078,$C07A         ; $00320E CMP.W  $C07A.W,D0
        DC.W    $6710               ; $003212 BEQ.S  loc_003224
        DC.W    $3028,$002C         ; $003214 MOVE.W  $002C(A0),D0
        DC.W    $43F9,$0089,$89EE   ; $003218 LEA     $008989EE,A1
        DC.W    $11F1,$0000,$C8A5   ; $00321E MOVE.B  $00(A1,D0.W),$C8A5.W
loc_003224:
        DC.W    $11FC,$0004,$C305   ; $003224 MOVE.B  #$0004,$C305.W
        DC.W    $4A78,$C04E         ; $00322A TST.W  $C04E.W
        DC.W    $6720               ; $00322E BEQ.S  loc_003250
        DC.W    $2278,$C258         ; $003230 MOVEA.L $C258.W,A1
        DC.W    $137C,$0000,$0000   ; $003234 MOVE.B  #$0000,$0000(A1)
        DC.W    $13FC,$0000,$00FF,$6940; $00323A MOVE.B  #$0000,$00FF6940
        DC.W    $13FC,$0000,$00FF,$6950; $003242 MOVE.B  #$0000,$00FF6950
        DC.W    $5838,$C305         ; $00324A ADDQ.B  #4,$C305.W
        DC.W    $4E75               ; $00324E RTS
loc_003250:
        DC.W    $2278,$C258         ; $003250 MOVEA.L $C258.W,A1
        DC.W    $137C,$0002,$0000   ; $003254 MOVE.B  #$0002,$0000(A1)
        DC.W    $13FC,$0000,$00FF,$6940; $00325A MOVE.B  #$0000,$00FF6940
        DC.W    $13FC,$0000,$00FF,$6950; $003262 MOVE.B  #$0000,$00FF6950
        DC.W    $11FC,$0000,$C305   ; $00326A MOVE.B  #$0000,$C305.W
        DC.W    $4E75               ; $003270 RTS
        DC.W    $11FC,$0002,$C308   ; $003272 MOVE.B  #$0002,$C308.W
        DC.W    $7000               ; $003278 MOVEQ   #$00,D0
        DC.W    $43F9,$00FF,$68D0   ; $00327A LEA     $00FF68D0,A1
        DC.W    $3028,$002C         ; $003280 MOVE.W  $002C(A0),D0
        DC.W    $5340               ; $003284 SUBQ.W  #1,D0
        DC.W    $E948               ; $003286 LSL.W  #4,D0
        DC.W    $D3C0               ; $003288 ADDA.L  D0,A1
        DC.W    $21C9,$C258         ; $00328A MOVE.L  A1,$C258.W
        DC.W    $137C,$0002,$0000   ; $00328E MOVE.B  #$0002,$0000(A1)
        DC.W    $13FC,$0003,$00FF,$6950; $003294 MOVE.B  #$0003,$00FF6950
        DC.W    $3478,$C076         ; $00329C MOVEA.W $C076.W,A2
        DC.W    $7000               ; $0032A0 MOVEQ   #$00,D0
        DC.W    $1038,$C806         ; $0032A2 MOVE.B  $C806.W,D0
        DC.W    $11FC,$0000,$C806   ; $0032A6 MOVE.B  #$0000,$C806.W
        DC.W    $D040               ; $0032AC ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $0032AE LEA     $00899884,A3
        DC.W    $3033,$0000         ; $0032B4 MOVE.W  $00(A3,D0.W),D0
        DC.W    $14C0               ; $0032B8 MOVE.B  D0,(A2)+
        DC.W    $7000               ; $0032BA MOVEQ   #$00,D0
        DC.W    $1038,$C807         ; $0032BC MOVE.B  $C807.W,D0
        DC.W    $11FC,$00C4,$C807   ; $0032C0 MOVE.B  #$00C4,$C807.W
        DC.W    $0400,$00C4         ; $0032C6 SUBI.B  #$00C4,D0
        DC.W    $D040               ; $0032CA ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $0032CC LEA     $00899884,A3
        DC.W    $3033,$0000         ; $0032D2 MOVE.W  $00(A3,D0.W),D0
        DC.W    $14C0               ; $0032D6 MOVE.B  D0,(A2)+
        DC.W    $7000               ; $0032D8 MOVEQ   #$00,D0
        DC.W    $1038,$C808         ; $0032DA MOVE.B  $C808.W,D0
        DC.W    $11FC,$00C4,$C808   ; $0032DE MOVE.B  #$00C4,$C808.W
        DC.W    $0400,$00C4         ; $0032E4 SUBI.B  #$00C4,D0
        DC.W    $D040               ; $0032E8 ADD.W  D0,D0
        DC.W    $47F9,$0089,$980C   ; $0032EA LEA     $0089980C,A3
        DC.W    $3033,$0000         ; $0032F0 MOVE.W  $00(A3,D0.W),D0
        DC.W    $34C0               ; $0032F4 MOVE.W  D0,(A2)+
        DC.W    $31CA,$C076         ; $0032F6 MOVE.W  A2,$C076.W
        DC.W    $4EB9,$0088,$B2E4   ; $0032FA JSR     $0088B2E4
        DC.W    $4EB9,$0088,$B422   ; $003300 JSR     $0088B422
        DC.W    $598A               ; $003306 SUBQ.L  #4,A2
        DC.W    $2012               ; $003308 MOVE.L  (A2),D0
        DC.W    $23FC,$222E,$070C,$00FF,$6948; $00330A MOVE.L  #$222E070C,$00FF6948
        DC.W    $11FC,$0000,$C30B   ; $003314 MOVE.B  #$0000,$C30B.W
        DC.W    $B0B8,$C254         ; $00331A CMP.L  $C254.W,D0
        DC.W    $6C3C               ; $00331E BGE.S  loc_00335C
        DC.W    $21C0,$C254         ; $003320 MOVE.L  D0,$C254.W
        DC.W    $7000               ; $003324 MOVEQ   #$00,D0
        DC.W    $43F9,$00FF,$68D1   ; $003326 LEA     $00FF68D1,A1
        DC.W    $1038,$C307         ; $00332C MOVE.B  $C307.W,D0
        DC.W    $45F1,$0000         ; $003330 LEA     $00(A1,D0.W),A2
        DC.W    $14BC,$0000         ; $003334 MOVE.B  #$0000,(A2)
        DC.W    $3028,$002C         ; $003338 MOVE.W  $002C(A0),D0
        DC.W    $5340               ; $00333C SUBQ.W  #1,D0
        DC.W    $E948               ; $00333E LSL.W  #4,D0
        DC.W    $11C0,$C307         ; $003340 MOVE.B  D0,$C307.W
        DC.W    $45F1,$0000         ; $003344 LEA     $00(A1,D0.W),A2
        DC.W    $14BC,$0001         ; $003348 MOVE.B  #$0001,(A2)
        DC.W    $23FC,$222D,$FB7C,$00FF,$6948; $00334C MOVE.L  #$222DFB7C,$00FF6948
        DC.W    $11FC,$0001,$C30B   ; $003356 MOVE.B  #$0001,$C30B.W
loc_00335C:
        DC.W    $13FC,$0001,$00FF,$6940; $00335C MOVE.B  #$0001,$00FF6940
        DC.W    $1038,$C8AB         ; $003364 MOVE.B  $C8AB.W,D0
        DC.W    $0200,$0003         ; $003368 ANDI.B  #$0003,D0
        DC.W    $D000               ; $00336C ADD.B  D0,D0
        DC.W    $D000               ; $00336E ADD.B  D0,D0
        DC.W    $0600,$000C         ; $003370 ADDI.B  #$000C,D0
        DC.W    $11C0,$C305         ; $003374 MOVE.B  D0,$C305.W
        DC.W    $4E75               ; $003378 RTS
        DC.W    $7000               ; $00337A MOVEQ   #$00,D0
        DC.W    $1038,$C305         ; $00337C MOVE.B  $C305.W,D0
        DC.W    $227B,$0004         ; $003380 MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $003384 JMP     (A1)
        DC.W    $0088,$34E6,$0088   ; $003386 ORI.L  #$34E60088,A0
        DC.W    $3404               ; $00338C MOVE.W  D4,D2
        DC.W    $0088,$33C2,$0088   ; $00338E ORI.L  #$33C20088,A0
        DC.W    $33C2,$0088,$33C2   ; $003394 MOVE.W  D2,$008833C2
        DC.W    $0088,$33C2,$0088   ; $00339A ORI.L  #$33C20088,A0
        DC.W    $33C2,$0088,$33C2   ; $0033A0 MOVE.W  D2,$008833C2
        DC.W    $0088,$33C2,$0088   ; $0033A6 ORI.L  #$33C20088,A0
        DC.W    $33C2,$0088,$33C2   ; $0033AC MOVE.W  D2,$008833C2
        DC.W    $0088,$33C2,$0088   ; $0033B2 ORI.L  #$33C20088,A0
        DC.W    $33EC,$0088,$33FC,$0088; $0033B8 MOVE.W  $0088(A4),$33FC0088
        DC.W    $34CA               ; $0033C0 MOVE.W  A2,(A2)+
        DC.W    $3038,$C08E         ; $0033C2 MOVE.W  $C08E.W,D0
        DC.W    $B078,$C07A         ; $0033C6 CMP.W  $C07A.W,D0
        DC.W    $6718               ; $0033CA BEQ.S  loc_0033E4
        DC.W    $5838,$C305         ; $0033CC ADDQ.B  #4,$C305.W
        DC.W    $3028,$002C         ; $0033D0 MOVE.W  $002C(A0),D0
        DC.W    $5340               ; $0033D4 SUBQ.W  #1,D0
        DC.W    $B038,$C310         ; $0033D6 CMP.B  $C310.W,D0
        DC.W    $6606               ; $0033DA BNE.S  loc_0033E2
        DC.W    $11FC,$0030,$C305   ; $0033DC MOVE.B  #$0030,$C305.W
loc_0033E2:
        DC.W    $4E75               ; $0033E2 RTS
loc_0033E4:
        DC.W    $11FC,$0034,$C305   ; $0033E4 MOVE.B  #$0034,$C305.W
        DC.W    $4E75               ; $0033EA RTS
        DC.W    $3028,$002C         ; $0033EC MOVE.W  $002C(A0),D0
        DC.W    $43F9,$0089,$89EE   ; $0033F0 LEA     $008989EE,A1
        DC.W    $11F1,$0000,$C8A5   ; $0033F6 MOVE.B  $00(A1,D0.W),$C8A5.W
        DC.W    $11FC,$0000,$C305   ; $0033FC MOVE.B  #$0000,$C305.W
        DC.W    $4E75               ; $003402 RTS
        DC.W    $43F8,$C806         ; $003404 LEA     $C806.W,A1
        DC.W    $B0FC,$9000         ; $003408 CMPA.W  #$9000,A0
        DC.W    $6704               ; $00340C BEQ.S  loc_003412
        DC.W    $43F8,$C813         ; $00340E LEA     $C813.W,A1
loc_003412:
        DC.W    $3478,$C076         ; $003412 MOVEA.W $C076.W,A2
        DC.W    $7000               ; $003416 MOVEQ   #$00,D0
        DC.W    $1011               ; $003418 MOVE.B  (A1),D0
        DC.W    $12BC,$0000         ; $00341A MOVE.B  #$0000,(A1)
        DC.W    $D040               ; $00341E ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $003420 LEA     $00899884,A3
        DC.W    $3033,$0000         ; $003426 MOVE.W  $00(A3,D0.W),D0
        DC.W    $14C0               ; $00342A MOVE.B  D0,(A2)+
        DC.W    $7000               ; $00342C MOVEQ   #$00,D0
        DC.W    $1029,$0001         ; $00342E MOVE.B  $0001(A1),D0
        DC.W    $137C,$00C4,$0001   ; $003432 MOVE.B  #$00C4,$0001(A1)
        DC.W    $0400,$00C4         ; $003438 SUBI.B  #$00C4,D0
        DC.W    $D040               ; $00343C ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $00343E LEA     $00899884,A3
        DC.W    $3033,$0000         ; $003444 MOVE.W  $00(A3,D0.W),D0
        DC.W    $14C0               ; $003448 MOVE.B  D0,(A2)+
        DC.W    $7000               ; $00344A MOVEQ   #$00,D0
        DC.W    $1029,$0002         ; $00344C MOVE.B  $0002(A1),D0
        DC.W    $137C,$00C4,$0002   ; $003450 MOVE.B  #$00C4,$0002(A1)
        DC.W    $0400,$00C4         ; $003456 SUBI.B  #$00C4,D0
        DC.W    $D040               ; $00345A ADD.W  D0,D0
        DC.W    $47F9,$0089,$980C   ; $00345C LEA     $0089980C,A3
        DC.W    $3033,$0000         ; $003462 MOVE.W  $00(A3,D0.W),D0
        DC.W    $34C0               ; $003466 MOVE.W  D0,(A2)+
        DC.W    $31CA,$C076         ; $003468 MOVE.W  A2,$C076.W
        DC.W    $4EBA,$7E76         ; $00346C JSR     $00B2E4(PC)
        DC.W    $598A               ; $003470 SUBQ.L  #4,A2
        DC.W    $2012               ; $003472 MOVE.L  (A2),D0
        DC.W    $B0B8,$C254         ; $003474 CMP.L  $C254.W,D0
        DC.W    $6C32               ; $003478 BGE.S  loc_0034AC
        DC.W    $21C0,$C254         ; $00347A MOVE.L  D0,$C254.W
        DC.W    $3028,$002C         ; $00347E MOVE.W  $002C(A0),D0
        DC.W    $5340               ; $003482 SUBQ.W  #1,D0
        DC.W    $E948               ; $003484 LSL.W  #4,D0
        DC.W    $11C0,$C307         ; $003486 MOVE.B  D0,$C307.W
        DC.W    $43F8,$C254         ; $00348A LEA     $C254.W,A1
        DC.W    $47F9,$00FF,$68E8   ; $00348E LEA     $00FF68E8,A3
        DC.W    $B0FC,$9000         ; $003494 CMPA.W  #$9000,A0
        DC.W    $6706               ; $003498 BEQ.S  loc_0034A0
        DC.W    $47F9,$00FF,$6968   ; $00349A LEA     $00FF6968,A3
loc_0034A0:
        DC.W    $177C,$0002,$FFF8   ; $0034A0 MOVE.B  #$0002,-$0008(A3)
        DC.W    $4EB9,$0088,$B43C   ; $0034A6 JSR     $0088B43C
loc_0034AC:
        DC.W    $0838,$0005,$C30E   ; $0034AC BTST    #5,$C30E.W
        DC.W    $660C               ; $0034B2 BNE.S  loc_0034C0
        DC.W    $4A38,$C819         ; $0034B4 TST.B  $C819.W
        DC.W    $6718               ; $0034B8 BEQ.S  loc_0034D2
        DC.W    $31F8,$C098,$C07A   ; $0034BA MOVE.W  $C098.W,$C07A.W
loc_0034C0:
        DC.W    $31FC,$0004,$C07C   ; $0034C0 MOVE.W  #$0004,$C07C.W
        DC.W    $5238,$C819         ; $0034C6 ADDQ.B  #1,$C819.W
        DC.W    $11FC,$0038,$C305   ; $0034CA MOVE.B  #$0038,$C305.W
        DC.W    $4E75               ; $0034D0 RTS
loc_0034D2:
        DC.W    $1038,$C8AB         ; $0034D2 MOVE.B  $C8AB.W,D0
        DC.W    $0200,$0003         ; $0034D6 ANDI.B  #$0003,D0
        DC.W    $D000               ; $0034DA ADD.B  D0,D0
        DC.W    $D000               ; $0034DC ADD.B  D0,D0
        DC.W    $0600,$000C         ; $0034DE ADDI.B  #$000C,D0
        DC.W    $11C0,$C305         ; $0034E2 MOVE.B  D0,$C305.W
        DC.W    $4E75               ; $0034E6 RTS
        DC.W    $7000               ; $0034E8 MOVEQ   #$00,D0
        DC.W    $1038,$C305         ; $0034EA MOVE.B  $C305.W,D0
        DC.W    $227B,$0004         ; $0034EE MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $0034F2 JMP     (A1)
        DC.W    $0088,$36DC,$0088   ; $0034F4 ORI.L  #$36DC0088,A0
        DC.W    $35B4,$0088,$3524   ; $0034FA MOVE.W  -$78(A4,D0.W),$24(A2,D3.W)
        DC.W    $0088,$3524,$0088   ; $003500 ORI.L  #$35240088,A0
        DC.W    $3524               ; $003506 MOVE.W  -(A4),-(A2)
        DC.W    $0088,$3524,$0088   ; $003508 ORI.L  #$35240088,A0
        DC.W    $3580,$0088         ; $00350E MOVE.W  D0,-$78(A2,D0.W)
        DC.W    $3580,$0088         ; $003512 MOVE.W  D0,-$78(A2,D0.W)
        DC.W    $3580,$0088         ; $003516 MOVE.W  D0,-$78(A2,D0.W)
        DC.W    $3540,$0088         ; $00351A MOVE.W  D0,$0088(A2)
        DC.W    $359C,$0088         ; $00351E MOVE.W  (A4)+,-$78(A2,D0.W)
        DC.W    $36C0               ; $003522 MOVE.W  D0,(A3)+
        DC.W    $4A78,$C04E         ; $003524 TST.W  $C04E.W
        DC.W    $6772               ; $003528 BEQ.S  loc_00359C
        DC.W    $13FC,$0003,$00FF,$6950; $00352A MOVE.B  #$0003,$00FF6950
        DC.W    $13FC,$0001,$00FF,$6940; $003532 MOVE.B  #$0001,$00FF6940
        DC.W    $5838,$C305         ; $00353A ADDQ.B  #4,$C305.W
        DC.W    $4E75               ; $00353E RTS
        DC.W    $5338,$C308         ; $003540 SUBQ.B  #1,$C308.W
        DC.W    $6634               ; $003544 BNE.S  loc_00357A
        DC.W    $3038,$C08E         ; $003546 MOVE.W  $C08E.W,D0
        DC.W    $B078,$C07A         ; $00354A CMP.W  $C07A.W,D0
        DC.W    $672A               ; $00354E BEQ.S  loc_00357A
        DC.W    $0838,$0005,$C30E   ; $003550 BTST    #5,$C30E.W
        DC.W    $6622               ; $003556 BNE.S  loc_00357A
        DC.W    $3028,$002C         ; $003558 MOVE.W  $002C(A0),D0
        DC.W    $43F9,$0089,$89EE   ; $00355C LEA     $008989EE,A1
        DC.W    $11F1,$0000,$C8A5   ; $003562 MOVE.B  $00(A1,D0.W),$C8A5.W
        DC.W    $0CB9,$222E,$0508,$00FF,$6948; $003568 CMPI.L  #$222E0508,$00FF6948
        DC.W    $6606               ; $003572 BNE.S  loc_00357A
        DC.W    $11FC,$0097,$C8A5   ; $003574 MOVE.B  #$0097,$C8A5.W
loc_00357A:
        DC.W    $11FC,$0004,$C305   ; $00357A MOVE.B  #$0004,$C305.W
        DC.W    $4A78,$C04E         ; $003580 TST.W  $C04E.W
        DC.W    $6716               ; $003584 BEQ.S  loc_00359C
        DC.W    $13FC,$0000,$00FF,$6940; $003586 MOVE.B  #$0000,$00FF6940
        DC.W    $13FC,$0000,$00FF,$6950; $00358E MOVE.B  #$0000,$00FF6950
        DC.W    $5838,$C305         ; $003596 ADDQ.B  #4,$C305.W
        DC.W    $4E75               ; $00359A RTS
loc_00359C:
        DC.W    $13FC,$0000,$00FF,$6940; $00359C MOVE.B  #$0000,$00FF6940
        DC.W    $13FC,$0000,$00FF,$6950; $0035A4 MOVE.B  #$0000,$00FF6950
        DC.W    $11FC,$0000,$C305   ; $0035AC MOVE.B  #$0000,$C305.W
        DC.W    $4E75               ; $0035B2 RTS
        DC.W    $11FC,$0001,$C308   ; $0035B4 MOVE.B  #$0001,$C308.W
        DC.W    $3028,$002C         ; $0035BA MOVE.W  $002C(A0),D0
        DC.W    $5240               ; $0035BE ADDQ.W  #1,D0
        DC.W    $B038,$C310         ; $0035C0 CMP.B  $C310.W,D0
        DC.W    $6606               ; $0035C4 BNE.S  loc_0035CC
        DC.W    $11FC,$0002,$C308   ; $0035C6 MOVE.B  #$0002,$C308.W
loc_0035CC:
        DC.W    $13FC,$0003,$00FF,$6950; $0035CC MOVE.B  #$0003,$00FF6950
        DC.W    $3478,$C076         ; $0035D4 MOVEA.W $C076.W,A2
        DC.W    $7000               ; $0035D8 MOVEQ   #$00,D0
        DC.W    $1038,$C806         ; $0035DA MOVE.B  $C806.W,D0
        DC.W    $11FC,$0000,$C806   ; $0035DE MOVE.B  #$0000,$C806.W
        DC.W    $D040               ; $0035E4 ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $0035E6 LEA     $00899884,A3
        DC.W    $3033,$0000         ; $0035EC MOVE.W  $00(A3,D0.W),D0
        DC.W    $14C0               ; $0035F0 MOVE.B  D0,(A2)+
        DC.W    $7000               ; $0035F2 MOVEQ   #$00,D0
        DC.W    $1038,$C807         ; $0035F4 MOVE.B  $C807.W,D0
        DC.W    $11FC,$00C4,$C807   ; $0035F8 MOVE.B  #$00C4,$C807.W
        DC.W    $0400,$00C4         ; $0035FE SUBI.B  #$00C4,D0
        DC.W    $D040               ; $003602 ADD.W  D0,D0
        DC.W    $47F9,$0089,$9884   ; $003604 LEA     $00899884,A3
        DC.W    $3033,$0000         ; $00360A MOVE.W  $00(A3,D0.W),D0
        DC.W    $14C0               ; $00360E MOVE.B  D0,(A2)+
        DC.W    $7000               ; $003610 MOVEQ   #$00,D0
        DC.W    $1038,$C808         ; $003612 MOVE.B  $C808.W,D0
        DC.W    $11FC,$00C4,$C808   ; $003616 MOVE.B  #$00C4,$C808.W
        DC.W    $0400,$00C4         ; $00361C SUBI.B  #$00C4,D0
        DC.W    $D040               ; $003620 ADD.W  D0,D0
        DC.W    $47F9,$0089,$980C   ; $003622 LEA     $0089980C,A3
        DC.W    $3033,$0000         ; $003628 MOVE.W  $00(A3,D0.W),D0
        DC.W    $34C0               ; $00362C MOVE.W  D0,(A2)+
        DC.W    $31CA,$C076         ; $00362E MOVE.W  A2,$C076.W
        DC.W    $4EBA,$7CB0         ; $003632 JSR     $00B2E4(PC)
        DC.W    $4EBA,$7DD6         ; $003636 JSR     $00B40E(PC)
        DC.W    $598A               ; $00363A SUBQ.L  #4,A2
        DC.W    $2012               ; $00363C MOVE.L  (A2),D0
        DC.W    $23FC,$222E,$070C,$00FF,$6948; $00363E MOVE.L  #$222E070C,$00FF6948
        DC.W    $B0B8,$C254         ; $003648 CMP.L  $C254.W,D0
        DC.W    $6C62               ; $00364C BGE.S  loc_0036B0
        DC.W    $21C0,$C254         ; $00364E MOVE.L  D0,$C254.W
        DC.W    $7200               ; $003652 MOVEQ   #$00,D1
        DC.W    $3228,$002C         ; $003654 MOVE.W  $002C(A0),D1
        DC.W    $5341               ; $003658 SUBQ.W  #1,D1
        DC.W    $E949               ; $00365A LSL.W  #4,D1
        DC.W    $11C1,$C307         ; $00365C MOVE.B  D1,$C307.W
        DC.W    $23FC,$222D,$FB7C,$00FF,$6948; $003660 MOVE.L  #$222DFB7C,$00FF6948
        DC.W    $43F8,$FDAA         ; $00366A LEA     $FDAA.W,A1
        DC.W    $3238,$C89C         ; $00366E MOVE.W  $C89C.W,D1
        DC.W    $EB49               ; $003672 LSL.W  #5,D1
        DC.W    $D278,$C8A0         ; $003674 ADD.W  $C8A0.W,D1
        DC.W    $3438,$C8C8         ; $003678 MOVE.W  $C8C8.W,D2
        DC.W    $E74A               ; $00367C LSL.W  #3,D2
        DC.W    $D478,$C8CC         ; $00367E ADD.W  $C8CC.W,D2
        DC.W    $D242               ; $003682 ADD.W  D2,D1
        DC.W    $43F1,$1000         ; $003684 LEA     $00(A1,D1.W),A1
        DC.W    $B091               ; $003688 CMP.L  (A1),D0
        DC.W    $6C24               ; $00368A BGE.S  loc_0036B0
        DC.W    $23FC,$222E,$0508,$00FF,$6948; $00368C MOVE.L  #$222E0508,$00FF6948
        DC.W    $22C0               ; $003696 MOVE.L  D0,(A1)+
        DC.W    $22F8,$C270         ; $003698 MOVE.L  $C270.W,(A1)+
        DC.W    $22B8,$C274         ; $00369C MOVE.L  $C274.W,(A1)
        DC.W    $43F9,$00FF,$6958   ; $0036A0 LEA     $00FF6958,A1
        DC.W    $45F9,$00FF,$68E8   ; $0036A6 LEA     $00FF68E8,A2
        DC.W    $24D9               ; $0036AC MOVE.L  (A1)+,(A2)+
        DC.W    $2491               ; $0036AE MOVE.L  (A1),(A2)
loc_0036B0:
        DC.W    $13FC,$0001,$00FF,$6940; $0036B0 MOVE.B  #$0001,$00FF6940
        DC.W    $0838,$0005,$C30E   ; $0036B8 BTST    #5,$C30E.W
        DC.W    $6708               ; $0036BE BEQ.S  loc_0036C8
        DC.W    $11FC,$002C,$C305   ; $0036C0 MOVE.B  #$002C,$C305.W
        DC.W    $4E75               ; $0036C6 RTS
loc_0036C8:
        DC.W    $1038,$C8AB         ; $0036C8 MOVE.B  $C8AB.W,D0
        DC.W    $0200,$0003         ; $0036CC ANDI.B  #$0003,D0
        DC.W    $D000               ; $0036D0 ADD.B  D0,D0
        DC.W    $D000               ; $0036D2 ADD.B  D0,D0
        DC.W    $0600,$000C         ; $0036D4 ADDI.B  #$000C,D0
        DC.W    $11C0,$C305         ; $0036D8 MOVE.B  D0,$C305.W
        DC.W    $4E75               ; $0036DC RTS
        DC.W    $41F8,$9100         ; $0036DE LEA     $9100.W,A0
        DC.W    $43F9,$00FF,$6218   ; $0036E2 LEA     $00FF6218,A1
        DC.W    $47F9,$0089,$58E4   ; $0036E8 LEA     $008958E4,A3
        DC.W    $3038,$C8CC         ; $0036EE MOVE.W  $C8CC.W,D0
        DC.W    $2673,$0000         ; $0036F2 MOVEA.L $00(A3,D0.W),A3
        DC.W    $7E0E               ; $0036F6 MOVEQ   #$0E,D7
loc_0036F8:
        DC.W    $7A00               ; $0036F8 MOVEQ   #$00,D5
        DC.W    $7C00               ; $0036FA MOVEQ   #$00,D6
        DC.W    $7000               ; $0036FC MOVEQ   #$00,D0
        DC.W    $1028,$00C1         ; $0036FE MOVE.B  $00C1(A0),D0
        DC.W    $6700,$008C         ; $003702 BEQ.W  loc_003790
        DC.W    $7A01               ; $003706 MOVEQ   #$01,D5
        DC.W    $7C01               ; $003708 MOVEQ   #$01,D6
        DC.W    $4A38,$90E4         ; $00370A TST.B  $90E4.W
        DC.W    $6606               ; $00370E BNE.S  loc_003716
        DC.W    $4A38,$C31C         ; $003710 TST.B  $C31C.W
        DC.W    $6710               ; $003714 BEQ.S  loc_003726
loc_003716:
        DC.W    $0828,$0003,$00E5   ; $003716 BTST    #3,$00E5(A0)
        DC.W    $6716               ; $00371C BEQ.S  loc_003734
loc_00371E:
        DC.W    $7A00               ; $00371E MOVEQ   #$00,D5
        DC.W    $7C00               ; $003720 MOVEQ   #$00,D6
        DC.W    $6000,$006C         ; $003722 BRA.W  loc_003790
loc_003726:
        DC.W    $0838,$0003,$90E5   ; $003726 BTST    #3,$90E5.W
        DC.W    $6706               ; $00372C BEQ.S  loc_003734
        DC.W    $4A28,$00E4         ; $00372E TST.B  $00E4(A0)
        DC.W    $66EA               ; $003732 BNE.S  loc_00371E
loc_003734:
        DC.W    $0C40,$0001         ; $003734 CMPI.W  #$0001,D0
        DC.W    $6702               ; $003738 BEQ.S  loc_00373C
        DC.W    $7C00               ; $00373A MOVEQ   #$00,D6
loc_00373C:
        DC.W    $D040               ; $00373C ADD.W  D0,D0
        DC.W    $D040               ; $00373E ADD.W  D0,D0
        DC.W    $D068,$00C2         ; $003740 ADD.W  $00C2(A0),D0
        DC.W    $2373,$0000,$0010   ; $003744 MOVE.L  $00(A3,D0.W),$0010(A1)
        DC.W    $3038,$C0E4         ; $00374A MOVE.W  $C0E4.W,D0
        DC.W    $D068,$0032         ; $00374E ADD.W  $0032(A0),D0
        DC.W    $3340,$0004         ; $003752 MOVE.W  D0,$0004(A1)
        DC.W    $3028,$003A         ; $003756 MOVE.W  $003A(A0),D0
        DC.W    $E640               ; $00375A ASR.W  #3,D0
        DC.W    $4440               ; $00375C NEG.W  D0
        DC.W    $3340,$0008         ; $00375E MOVE.W  D0,$0008(A1)
        DC.W    $3028,$003C         ; $003762 MOVE.W  $003C(A0),D0
        DC.W    $D068,$006E         ; $003766 ADD.W  $006E(A0),D0
        DC.W    $E640               ; $00376A ASR.W  #3,D0
        DC.W    $3340,$000A         ; $00376C MOVE.W  D0,$000A(A1)
        DC.W    $3028,$003E         ; $003770 MOVE.W  $003E(A0),D0
        DC.W    $E640               ; $003774 ASR.W  #3,D0
        DC.W    $4440               ; $003776 NEG.W  D0
        DC.W    $3340,$000C         ; $003778 MOVE.W  D0,$000C(A1)
        DC.W    $3028,$00BC         ; $00377C MOVE.W  $00BC(A0),D0
        DC.W    $E640               ; $003780 ASR.W  #3,D0
        DC.W    $3340,$001C         ; $003782 MOVE.W  D0,$001C(A1)
        DC.W    $3028,$00C4         ; $003786 MOVE.W  $00C4(A0),D0
        DC.W    $E640               ; $00378A ASR.W  #3,D0
        DC.W    $3340,$0030         ; $00378C MOVE.W  D0,$0030(A1)
loc_003790:
        DC.W    $3368,$0030,$0002   ; $003790 MOVE.W  $0030(A0),$0002(A1)
        DC.W    $3368,$0034,$0006   ; $003796 MOVE.W  $0034(A0),$0006(A1)
        DC.W    $3345,$0000         ; $00379C MOVE.W  D5,$0000(A1)
        DC.W    $3346,$0014         ; $0037A0 MOVE.W  D6,$0014(A1)
        DC.W    $3346,$0028         ; $0037A4 MOVE.W  D6,$0028(A1)
        DC.W    $41E8,$0100         ; $0037A8 LEA     $0100(A0),A0
        DC.W    $43E9,$003C         ; $0037AC LEA     $003C(A1),A1
        DC.W    $51CF,$FF46         ; $0037B0 DBRA    D7,loc_0036F8
        DC.W    $4E75               ; $0037B4 RTS
        DC.W    $41F8,$9000         ; $0037B6 LEA     $9000.W,A0
        DC.W    $3238,$C8A0         ; $0037BA MOVE.W  $C8A0.W,D1
        DC.W    $43F9,$0089,$5A64   ; $0037BE LEA     $00895A64,A1
        DC.W    $2271,$1000         ; $0037C4 MOVEA.L $00(A1,D1.W),A1
        DC.W    $45F9,$00FF,$659C   ; $0037C8 LEA     $00FF659C,A2
        DC.W    $323C,$0C80         ; $0037CE MOVE.W  #$0C80,D1
        DC.W    $7E02               ; $0037D2 MOVEQ   #$02,D7
loc_0037D4:
        DC.W    $3428,$0030         ; $0037D4 MOVE.W  $0030(A0),D2
        DC.W    $3828,$0034         ; $0037D8 MOVE.W  $0034(A0),D4
        DC.W    $9451               ; $0037DC SUB.W  (A1),D2
        DC.W    $6A02               ; $0037DE BPL.S  loc_0037E2
        DC.W    $4442               ; $0037E0 NEG.W  D2
loc_0037E2:
        DC.W    $B441               ; $0037E2 CMP.W  D1,D2
        DC.W    $6E46               ; $0037E4 BGT.S  loc_00382C
        DC.W    $9869,$0004         ; $0037E6 SUB.W  $0004(A1),D4
        DC.W    $6A02               ; $0037EA BPL.S  loc_0037EE
        DC.W    $4444               ; $0037EC NEG.W  D4
loc_0037EE:
        DC.W    $B841               ; $0037EE CMP.W  D1,D4
        DC.W    $6E3A               ; $0037F0 BGT.S  loc_00382C
        DC.W    $357C,$0001,$0000   ; $0037F2 MOVE.W  #$0001,$0000(A2)
        DC.W    $2559,$0002         ; $0037F8 MOVE.L  (A1)+,$0002(A2)
        DC.W    $3559,$0006         ; $0037FC MOVE.W  (A1)+,$0006(A2)
        DC.W    $3559,$000A         ; $003800 MOVE.W  (A1)+,$000A(A2)
        DC.W    $3559,$000E         ; $003804 MOVE.W  (A1)+,$000E(A2)
        DC.W    $2251               ; $003808 MOVEA.L (A1),A1
        DC.W    $3038,$C008         ; $00380A MOVE.W  $C008.W,D0
        DC.W    $5240               ; $00380E ADDQ.W  #1,D0
        DC.W    $0C40,$000C         ; $003810 CMPI.W  #$000C,D0
        DC.W    $6604               ; $003814 BNE.S  loc_00381A
        DC.W    $303C,$0000         ; $003816 MOVE.W  #$0000,D0
loc_00381A:
        DC.W    $31C0,$C008         ; $00381A MOVE.W  D0,$C008.W
        DC.W    $E248               ; $00381E LSR.W  #1,D0
        DC.W    $D040               ; $003820 ADD.W  D0,D0
        DC.W    $D040               ; $003822 ADD.W  D0,D0
        DC.W    $2571,$0000,$0010   ; $003824 MOVE.L  $00(A1,D0.W),$0010(A2)
        DC.W    $600E               ; $00382A BRA.S  loc_00383A
loc_00382C:
        DC.W    $43E9,$000E         ; $00382C LEA     $000E(A1),A1
        DC.W    $51CF,$FFA2         ; $003830 DBRA    D7,loc_0037D4
        DC.W    $357C,$0000,$0000   ; $003834 MOVE.W  #$0000,$0000(A2)
loc_00383A:
        DC.W    $3038,$C8A0         ; $00383A MOVE.W  $C8A0.W,D0
        DC.W    $227B,$0004         ; $00383E MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $003842 JMP     (A1)
        DC.W    $0088,$385E,$0088   ; $003844 ORI.L  #$385E0088,A0
        DC.W    $395C,$0088         ; $00384A MOVE.W  (A4)+,$0088(A4)
        DC.W    $385C               ; $00384E MOVEA.W (A4)+,A4
        DC.W    $0088,$3AAA,$0088   ; $003850 ORI.L  #$3AAA0088,A0
        DC.W    $385C               ; $003856 MOVEA.W (A4)+,A4
        DC.W    $0088,$385C,$4E75   ; $003858 ORI.L  #$385C4E75,A0
        DC.W    $4A38,$C80F         ; $00385E TST.B  $C80F.W
        DC.W    $6702               ; $003862 BEQ.S  loc_003866
        DC.W    $4E75               ; $003864 RTS
loc_003866:
        DC.W    $43F9,$0088,$3924   ; $003866 LEA     $00883924,A1
        DC.W    $45F9,$00FF,$65B0   ; $00386C LEA     $00FF65B0,A2
        DC.W    $5678,$C8E2         ; $003872 ADDQ.W  #3,$C8E2.W
        DC.W    $323C,$0C80         ; $003876 MOVE.W  #$0C80,D1
        DC.W    $363C,$1400         ; $00387A MOVE.W  #$1400,D3
        DC.W    $357C,$0000,$0000   ; $00387E MOVE.W  #$0000,$0000(A2)
        DC.W    $357C,$0000,$0014   ; $003884 MOVE.W  #$0000,$0014(A2)
        DC.W    $3038,$C8E2         ; $00388A MOVE.W  $C8E2.W,D0
        DC.W    $0240,$1FFF         ; $00388E ANDI.W  #$1FFF,D0
        DC.W    $3540,$0020         ; $003892 MOVE.W  D0,$0020(A2)
        DC.W    $6128               ; $003896 BSR.S  loc_0038C0
        DC.W    $45EA,$0028         ; $003898 LEA     $0028(A2),A2
        DC.W    $3038,$C8E2         ; $00389C MOVE.W  $C8E2.W,D0
        DC.W    $E148               ; $0038A0 LSL.W  #8,D0
        DC.W    $48E7,$4040         ; $0038A2 MOVEM.L -(A7),D6/A6
        DC.W    $4EBA,$56AA         ; $0038A6 JSR     $008F52(PC)
        DC.W    $4CDF,$0202         ; $0038AA MOVEM.L D1/A1,(A7)+
        DC.W    $E540               ; $0038AE ASL.W  #2,D0
        DC.W    $3540,$0020         ; $0038B0 MOVE.W  D0,$0020(A2)
        DC.W    $357C,$0000,$0000   ; $0038B4 MOVE.W  #$0000,$0000(A2)
        DC.W    $357C,$0000,$0010   ; $0038BA MOVE.W  #$0000,$0010(A2)
loc_0038C0:
        DC.W    $3428,$0030         ; $0038C0 MOVE.W  $0030(A0),D2
        DC.W    $3828,$0034         ; $0038C4 MOVE.W  $0034(A0),D4
        DC.W    $3A28,$0032         ; $0038C8 MOVE.W  $0032(A0),D5
        DC.W    $9451               ; $0038CC SUB.W  (A1),D2
        DC.W    $6A02               ; $0038CE BPL.S  loc_0038D2
        DC.W    $4442               ; $0038D0 NEG.W  D2
loc_0038D2:
        DC.W    $B441               ; $0038D2 CMP.W  D1,D2
        DC.W    $6E4C               ; $0038D4 BGT.S  loc_003922
        DC.W    $9A69,$0002         ; $0038D6 SUB.W  $0002(A1),D5
        DC.W    $6A02               ; $0038DA BPL.S  loc_0038DE
        DC.W    $4445               ; $0038DC NEG.W  D5
loc_0038DE:
        DC.W    $BA43               ; $0038DE CMP.W  D3,D5
        DC.W    $6E40               ; $0038E0 BGT.S  loc_003922
        DC.W    $9869,$0004         ; $0038E2 SUB.W  $0004(A1),D4
        DC.W    $6A02               ; $0038E6 BPL.S  loc_0038EA
        DC.W    $4444               ; $0038E8 NEG.W  D4
loc_0038EA:
        DC.W    $B841               ; $0038EA CMP.W  D1,D4
        DC.W    $6E34               ; $0038EC BGT.S  loc_003922
        DC.W    $357C,$0002,$0000   ; $0038EE MOVE.W  #$0002,$0000(A2)
        DC.W    $2559,$0002         ; $0038F4 MOVE.L  (A1)+,$0002(A2)
        DC.W    $3559,$0006         ; $0038F8 MOVE.W  (A1)+,$0006(A2)
        DC.W    $3559,$000A         ; $0038FC MOVE.W  (A1)+,$000A(A2)
        DC.W    $3559,$000E         ; $003900 MOVE.W  (A1)+,$000E(A2)
        DC.W    $2559,$0010         ; $003904 MOVE.L  (A1)+,$0010(A2)
        DC.W    $357C,$0002,$0014   ; $003908 MOVE.W  #$0002,$0014(A2)
        DC.W    $2559,$0016         ; $00390E MOVE.L  (A1)+,$0016(A2)
        DC.W    $3559,$001A         ; $003912 MOVE.W  (A1)+,$001A(A2)
        DC.W    $3559,$001E         ; $003916 MOVE.W  (A1)+,$001E(A2)
        DC.W    $3559,$0022         ; $00391A MOVE.W  (A1)+,$0022(A2)
        DC.W    $2559,$0024         ; $00391E MOVE.L  (A1)+,$0024(A2)
loc_003922:
        DC.W    $4E75               ; $003922 RTS
        DC.W    $F809               ; $003924 MOVE.W  A1,D4
        DC.W    $1417               ; $003926 MOVE.B  (A7),D2
        DC.W    $CF1F               ; $003928 AND.B  D7,(A7)+
        DC.W    $F07F               ; $00392A MOVEA.W <EA:3F>,A0
        DC.W    $0000,$222A         ; $00392C ORI.B  #$222A,D0
        DC.W    $1498               ; $003930 MOVE.B  (A0)+,(A2)
        DC.W    $0000,$1CB3         ; $003932 ORI.B  #$1CB3,D0
        DC.W    $0000,$0000         ; $003936 ORI.B  #$0000,D0
        DC.W    $0000,$222A         ; $00393A ORI.B  #$222A,D0
        DC.W    $160C               ; $00393E MOVE.B  A4,D3
        DC.W    $FDF0,$0A2C         ; $003940 MOVE.W  $2C(A0,D0.L),<EA:3E>
        DC.W    $D161               ; $003944 ADD.W  D0,-(A1)
        DC.W    $1000               ; $003946 MOVE.B  D0,D0
        DC.W    $0000,$222A         ; $003948 ORI.B  #$222A,D0
        DC.W    $1DBE,$0000         ; $00394C MOVE.B  <EA:3E>,$00(A6,D0.W)
        DC.W    $1A69,$0000         ; $003950 MOVEA.B $0000(A1),A5
        DC.W    $0000,$0000         ; $003954 ORI.B  #$0000,D0
        DC.W    $222A,$1EB8         ; $003958 MOVE.L  $1EB8(A2),D1
        DC.W    $43F9,$0088,$3A4E   ; $00395C LEA     $00883A4E,A1
        DC.W    $45F9,$00FF,$65B0   ; $003962 LEA     $00FF65B0,A2
        DC.W    $203C,$2229,$5A24   ; $003968 MOVE.L  #$22295A24,D0
        DC.W    $7E03               ; $00396E MOVEQ   #$03,D7
        DC.W    $4EBA,$007A         ; $003970 JSR     loc_0039EC(PC)
        DC.W    $4A38,$C80F         ; $003974 TST.B  $C80F.W
        DC.W    $6702               ; $003978 BEQ.S  loc_00397C
        DC.W    $4E75               ; $00397A RTS
loc_00397C:
        DC.W    $43F9,$0088,$3A80   ; $00397C LEA     $00883A80,A1
        DC.W    $45F9,$00FF,$65D8   ; $003982 LEA     $00FF65D8,A2
        DC.W    $0678,$001E,$C8E2   ; $003988 ADDI.W  #$001E,$C8E2.W
        DC.W    $323C,$0C80         ; $00398E MOVE.W  #$0C80,D1
        DC.W    $363C,$1400         ; $003992 MOVE.W  #$1400,D3
        DC.W    $357C,$0000,$0000   ; $003996 MOVE.W  #$0000,$0000(A2)
        DC.W    $357C,$0000,$0014   ; $00399C MOVE.W  #$0000,$0014(A2)
        DC.W    $3038,$C8E2         ; $0039A2 MOVE.W  $C8E2.W,D0
        DC.W    $0240,$1FFF         ; $0039A6 ANDI.W  #$1FFF,D0
        DC.W    $3540,$0020         ; $0039AA MOVE.W  D0,$0020(A2)
        DC.W    $4EBA,$FF10         ; $0039AE JSR     loc_0038C0(PC)
        DC.W    $45F9,$00FF,$65C4   ; $0039B2 LEA     $00FF65C4,A2
        DC.W    $357C,$0000,$0000   ; $0039B8 MOVE.W  #$0000,$0000(A2)
        DC.W    $4A79,$00FF,$65D8   ; $0039BE TST.W  $00FF65D8
        DC.W    $6724               ; $0039C4 BEQ.S  loc_0039EA
        DC.W    $43F9,$0088,$3A76   ; $0039C6 LEA     $00883A76,A1
        DC.W    $357C,$0001,$0000   ; $0039CC MOVE.W  #$0001,$0000(A2)
        DC.W    $2559,$0002         ; $0039D2 MOVE.L  (A1)+,$0002(A2)
        DC.W    $3559,$0006         ; $0039D6 MOVE.W  (A1)+,$0006(A2)
        DC.W    $3559,$000A         ; $0039DA MOVE.W  (A1)+,$000A(A2)
        DC.W    $3551,$000E         ; $0039DE MOVE.W  (A1),$000E(A2)
        DC.W    $257C,$222A,$218E,$0010; $0039E2 MOVE.L  #$222A218E,$0010(A2)
loc_0039EA:
        DC.W    $4E75               ; $0039EA RTS
loc_0039EC:
        DC.W    $323C,$0C80         ; $0039EC MOVE.W  #$0C80,D1
        DC.W    $363C,$0300         ; $0039F0 MOVE.W  #$0300,D3
loc_0039F4:
        DC.W    $3428,$0030         ; $0039F4 MOVE.W  $0030(A0),D2
        DC.W    $3828,$0034         ; $0039F8 MOVE.W  $0034(A0),D4
        DC.W    $3A28,$0032         ; $0039FC MOVE.W  $0032(A0),D5
        DC.W    $9451               ; $003A00 SUB.W  (A1),D2
        DC.W    $6A02               ; $003A02 BPL.S  loc_003A06
        DC.W    $4442               ; $003A04 NEG.W  D2
loc_003A06:
        DC.W    $B441               ; $003A06 CMP.W  D1,D2
        DC.W    $6E34               ; $003A08 BGT.S  loc_003A3E
        DC.W    $9A69,$0002         ; $003A0A SUB.W  $0002(A1),D5
        DC.W    $6A02               ; $003A0E BPL.S  loc_003A12
        DC.W    $4445               ; $003A10 NEG.W  D5
loc_003A12:
        DC.W    $BA43               ; $003A12 CMP.W  D3,D5
        DC.W    $6E28               ; $003A14 BGT.S  loc_003A3E
        DC.W    $9869,$0004         ; $003A16 SUB.W  $0004(A1),D4
        DC.W    $6A02               ; $003A1A BPL.S  loc_003A1E
        DC.W    $4444               ; $003A1C NEG.W  D4
loc_003A1E:
        DC.W    $B841               ; $003A1E CMP.W  D1,D4
        DC.W    $6E1C               ; $003A20 BGT.S  loc_003A3E
        DC.W    $357C,$0001,$0000   ; $003A22 MOVE.W  #$0001,$0000(A2)
        DC.W    $2559,$0002         ; $003A28 MOVE.L  (A1)+,$0002(A2)
        DC.W    $3559,$0006         ; $003A2C MOVE.W  (A1)+,$0006(A2)
        DC.W    $3559,$000A         ; $003A30 MOVE.W  (A1)+,$000A(A2)
        DC.W    $3551,$000E         ; $003A34 MOVE.W  (A1),$000E(A2)
        DC.W    $2540,$0010         ; $003A38 MOVE.L  D0,$0010(A2)
        DC.W    $4E75               ; $003A3C RTS
loc_003A3E:
        DC.W    $43E9,$000A         ; $003A3E LEA     $000A(A1),A1
        DC.W    $51CF,$FFB0         ; $003A42 DBRA    D7,loc_0039F4
        DC.W    $357C,$0000,$0000   ; $003A46 MOVE.W  #$0000,$0000(A2)
        DC.W    $4E75               ; $003A4C RTS
        DC.W    $F372,$1E33,$EE67   ; $003A4E MOVE.W  $33(A2,D1.L),-$1199(A1)
        DC.W    $F000               ; $003A54 MOVE.W  D0,D0
        DC.W    $0100               ; $003A56 BTST    D0,D0
        DC.W    $1049               ; $003A58 MOVEA.B A1,A0
        DC.W    $0FCD               ; $003A5A BSET    D7,A5
        DC.W    $E5E2               ; $003A5C ROXL.W  -(A2)
        DC.W    $F000               ; $003A5E MOVE.W  D0,D0
        DC.W    $0110               ; $003A60 BTST    D0,(A0)
        DC.W    $F0A8,$0DE6         ; $003A62 MOVE.W  $0DE6(A0),(A0)
        DC.W    $E977               ; $003A66 ROXL.W  D4,D7
        DC.W    $FCDF               ; $003A68 MOVE.W  (A7)+,(A6)+
        DC.W    $00F7               ; $003A6A DC.W    $00F7
        DC.W    $0F89               ; $003A6C BCLR    D7,A1
        DC.W    $08CD,$E03C         ; $003A6E BSET    #28,A5
        DC.W    $F800               ; $003A72 MOVE.W  D0,D4
        DC.W    $0100               ; $003A74 BTST    D0,D0
        DC.W    $1617               ; $003A76 MOVE.B  (A7),D3
        DC.W    $06AC,$F7AE,$F476,$0100; $003A78 ADDI.L  #$F7AEF476,$0100(A4)
        DC.W    $1579,$10A8,$F74A,$F447; $003A80 MOVE.B  $10A8F74A,-$0BB9(A2)
        DC.W    $0000,$222A         ; $003A88 ORI.B  #$222A,D0
        DC.W    $20DE               ; $003A8C MOVE.L  (A6)+,(A0)+
        DC.W    $0000,$0000         ; $003A8E ORI.B  #$0000,D0
        DC.W    $FA6A,$0000         ; $003A92 MOVEA.W $0000(A2),A5
        DC.W    $0000,$222A         ; $003A96 ORI.B  #$222A,D0
        DC.W    $2272,$F2E1         ; $003A9A MOVEA.L -$1F(A2,A7.W),A1
        DC.W    $0633,$2A89,$0000   ; $003A9E ADDI.B  #$2A89,$00(A3,D0.W)
        DC.W    $0100               ; $003AA4 BTST    D0,D0
        DC.W    $222A,$2508         ; $003AA6 MOVE.L  $2508(A2),D1
        DC.W    $4A38,$C80F         ; $003AAA TST.B  $C80F.W
        DC.W    $6702               ; $003AAE BEQ.S  loc_003AB2
        DC.W    $4E75               ; $003AB0 RTS
loc_003AB2:
        DC.W    $43F9,$0088,$3A9C   ; $003AB2 LEA     $00883A9C,A1
        DC.W    $45F9,$00FF,$65B0   ; $003AB8 LEA     $00FF65B0,A2
        DC.W    $0678,$003C,$C8E2   ; $003ABE ADDI.W  #$003C,$C8E2.W
        DC.W    $323C,$0C80         ; $003AC4 MOVE.W  #$0C80,D1
        DC.W    $363C,$1400         ; $003AC8 MOVE.W  #$1400,D3
        DC.W    $357C,$0000,$0000   ; $003ACC MOVE.W  #$0000,$0000(A2)
        DC.W    $3038,$C8E2         ; $003AD2 MOVE.W  $C8E2.W,D0
        DC.W    $0240,$1FFF         ; $003AD6 ANDI.W  #$1FFF,D0
        DC.W    $3540,$000A         ; $003ADA MOVE.W  D0,$000A(A2)
        DC.W    $3428,$0030         ; $003ADE MOVE.W  $0030(A0),D2
        DC.W    $3828,$0034         ; $003AE2 MOVE.W  $0034(A0),D4
        DC.W    $3A28,$0032         ; $003AE6 MOVE.W  $0032(A0),D5
        DC.W    $9451               ; $003AEA SUB.W  (A1),D2
        DC.W    $6A02               ; $003AEC BPL.S  loc_003AF0
        DC.W    $4442               ; $003AEE NEG.W  D2
loc_003AF0:
        DC.W    $B441               ; $003AF0 CMP.W  D1,D2
        DC.W    $6E32               ; $003AF2 BGT.S  loc_003B26
        DC.W    $9A69,$0002         ; $003AF4 SUB.W  $0002(A1),D5
        DC.W    $6A02               ; $003AF8 BPL.S  loc_003AFC
        DC.W    $4445               ; $003AFA NEG.W  D5
loc_003AFC:
        DC.W    $BA43               ; $003AFC CMP.W  D3,D5
        DC.W    $6E26               ; $003AFE BGT.S  loc_003B26
        DC.W    $9869,$0004         ; $003B00 SUB.W  $0004(A1),D4
        DC.W    $6A02               ; $003B04 BPL.S  loc_003B08
        DC.W    $4444               ; $003B06 NEG.W  D4
loc_003B08:
        DC.W    $B841               ; $003B08 CMP.W  D1,D4
        DC.W    $6E1A               ; $003B0A BGT.S  loc_003B26
        DC.W    $357C,$0001,$0000   ; $003B0C MOVE.W  #$0001,$0000(A2)
        DC.W    $2559,$0002         ; $003B12 MOVE.L  (A1)+,$0002(A2)
        DC.W    $3559,$0006         ; $003B16 MOVE.W  (A1)+,$0006(A2)
        DC.W    $3559,$000C         ; $003B1A MOVE.W  (A1)+,$000C(A2)
        DC.W    $3559,$000E         ; $003B1E MOVE.W  (A1)+,$000E(A2)
        DC.W    $2559,$0010         ; $003B22 MOVE.L  (A1)+,$0010(A2)
loc_003B26:
        DC.W    $4E75               ; $003B26 RTS
        DC.W    $41F8,$9F00         ; $003B28 LEA     $9F00.W,A0
        DC.W    $3238,$C8A0         ; $003B2C MOVE.W  $C8A0.W,D1
        DC.W    $43F9,$0089,$5A64   ; $003B30 LEA     $00895A64,A1
        DC.W    $2271,$1000         ; $003B36 MOVEA.L $00(A1,D1.W),A1
        DC.W    $45F9,$00FF,$663C   ; $003B3A LEA     $00FF663C,A2
        DC.W    $323C,$0C80         ; $003B40 MOVE.W  #$0C80,D1
        DC.W    $7E02               ; $003B44 MOVEQ   #$02,D7
loc_003B46:
        DC.W    $3428,$0030         ; $003B46 MOVE.W  $0030(A0),D2
        DC.W    $3828,$0034         ; $003B4A MOVE.W  $0034(A0),D4
        DC.W    $9451               ; $003B4E SUB.W  (A1),D2
        DC.W    $6A02               ; $003B50 BPL.S  loc_003B54
        DC.W    $4442               ; $003B52 NEG.W  D2
loc_003B54:
        DC.W    $B441               ; $003B54 CMP.W  D1,D2
        DC.W    $6E46               ; $003B56 BGT.S  loc_003B9E
        DC.W    $9869,$0004         ; $003B58 SUB.W  $0004(A1),D4
        DC.W    $6A02               ; $003B5C BPL.S  loc_003B60
        DC.W    $4444               ; $003B5E NEG.W  D4
loc_003B60:
        DC.W    $B841               ; $003B60 CMP.W  D1,D4
        DC.W    $6E3A               ; $003B62 BGT.S  loc_003B9E
        DC.W    $357C,$0001,$0000   ; $003B64 MOVE.W  #$0001,$0000(A2)
        DC.W    $2559,$0002         ; $003B6A MOVE.L  (A1)+,$0002(A2)
        DC.W    $3559,$0006         ; $003B6E MOVE.W  (A1)+,$0006(A2)
        DC.W    $3559,$000A         ; $003B72 MOVE.W  (A1)+,$000A(A2)
        DC.W    $3559,$000E         ; $003B76 MOVE.W  (A1)+,$000E(A2)
        DC.W    $2251               ; $003B7A MOVEA.L (A1),A1
        DC.W    $3038,$C008         ; $003B7C MOVE.W  $C008.W,D0
        DC.W    $5240               ; $003B80 ADDQ.W  #1,D0
        DC.W    $0C40,$000C         ; $003B82 CMPI.W  #$000C,D0
        DC.W    $6604               ; $003B86 BNE.S  loc_003B8C
        DC.W    $303C,$0000         ; $003B88 MOVE.W  #$0000,D0
loc_003B8C:
        DC.W    $31C0,$C008         ; $003B8C MOVE.W  D0,$C008.W
        DC.W    $E248               ; $003B90 LSR.W  #1,D0
        DC.W    $D040               ; $003B92 ADD.W  D0,D0
        DC.W    $D040               ; $003B94 ADD.W  D0,D0
        DC.W    $2571,$0000,$0010   ; $003B96 MOVE.L  $00(A1,D0.W),$0010(A2)
        DC.W    $600E               ; $003B9C BRA.S  loc_003BAC
loc_003B9E:
        DC.W    $43E9,$000E         ; $003B9E LEA     $000E(A1),A1
        DC.W    $51CF,$FFA2         ; $003BA2 DBRA    D7,loc_003B46
        DC.W    $357C,$0000,$0000   ; $003BA6 MOVE.W  #$0000,$0000(A2)
loc_003BAC:
        DC.W    $3238,$C89C         ; $003BAC MOVE.W  $C89C.W,D1
        DC.W    $0C41,$0001         ; $003BB0 CMPI.W  #$0001,D1
        DC.W    $6672               ; $003BB4 BNE.S  loc_003C28
        DC.W    $43F9,$0088,$3A4E   ; $003BB6 LEA     $00883A4E,A1
        DC.W    $45F9,$00FF,$6650   ; $003BBC LEA     $00FF6650,A2
        DC.W    $323C,$0C80         ; $003BC2 MOVE.W  #$0C80,D1
        DC.W    $363C,$0300         ; $003BC6 MOVE.W  #$0300,D3
        DC.W    $7E03               ; $003BCA MOVEQ   #$03,D7
loc_003BCC:
        DC.W    $3428,$0030         ; $003BCC MOVE.W  $0030(A0),D2
        DC.W    $3828,$0034         ; $003BD0 MOVE.W  $0034(A0),D4
        DC.W    $3A28,$0032         ; $003BD4 MOVE.W  $0032(A0),D5
        DC.W    $9451               ; $003BD8 SUB.W  (A1),D2
        DC.W    $6A02               ; $003BDA BPL.S  loc_003BDE
        DC.W    $4442               ; $003BDC NEG.W  D2
loc_003BDE:
        DC.W    $B441               ; $003BDE CMP.W  D1,D2
        DC.W    $6E38               ; $003BE0 BGT.S  loc_003C1A
        DC.W    $9A69,$0002         ; $003BE2 SUB.W  $0002(A1),D5
        DC.W    $6A02               ; $003BE6 BPL.S  loc_003BEA
        DC.W    $4445               ; $003BE8 NEG.W  D5
loc_003BEA:
        DC.W    $BA43               ; $003BEA CMP.W  D3,D5
        DC.W    $6E2C               ; $003BEC BGT.S  loc_003C1A
        DC.W    $9869,$0004         ; $003BEE SUB.W  $0004(A1),D4
        DC.W    $6A02               ; $003BF2 BPL.S  loc_003BF6
        DC.W    $4444               ; $003BF4 NEG.W  D4
loc_003BF6:
        DC.W    $B841               ; $003BF6 CMP.W  D1,D4
        DC.W    $6E20               ; $003BF8 BGT.S  loc_003C1A
        DC.W    $357C,$0001,$0000   ; $003BFA MOVE.W  #$0001,$0000(A2)
        DC.W    $2559,$0002         ; $003C00 MOVE.L  (A1)+,$0002(A2)
        DC.W    $3559,$0006         ; $003C04 MOVE.W  (A1)+,$0006(A2)
        DC.W    $3559,$000A         ; $003C08 MOVE.W  (A1)+,$000A(A2)
        DC.W    $3551,$000E         ; $003C0C MOVE.W  (A1),$000E(A2)
        DC.W    $257C,$2229,$5A24,$0010; $003C10 MOVE.L  #$22295A24,$0010(A2)
        DC.W    $4E75               ; $003C18 RTS
loc_003C1A:
        DC.W    $43E9,$000A         ; $003C1A LEA     $000A(A1),A1
        DC.W    $51CF,$FFAC         ; $003C1E DBRA    D7,loc_003BCC
        DC.W    $357C,$0000,$0000   ; $003C22 MOVE.W  #$0000,$0000(A2)
loc_003C28:
        DC.W    $4E75               ; $003C28 RTS
        DC.W    $F190,$09FA         ; $003C2A MOVE.W  (A0),-$06(A0,D0.L)
        DC.W    $F1F0,$F190,$0A40   ; $003C2E MOVE.W  -$70(A0,A7.W),$0A40.W
        DC.W    $F1F0,$EA70,$03B3   ; $003C34 MOVE.W  $70(A0,A6.L),$03B3.W
        DC.W    $FB50,$E900         ; $003C3A MOVE.W  (A0),-$1700(A5)
        DC.W    $0AF0               ; $003C3E DC.W    $0AF0
        DC.W    $0800,$EA70         ; $003C40 BTST    #16,D0
        DC.W    $03B3,$FB50         ; $003C44 BCLR    D1,$50(A3,A7.L)
        DC.W    $F190,$09FA         ; $003C48 MOVE.W  (A0),-$06(A0,D0.L)
        DC.W    $F1F0,$0030,$002B   ; $003C4C MOVE.W  $30(A0,D0.W),$002B.W
        DC.W    $0031,$FFFD,$FFD7   ; $003C52 ORI.B  #$FFFD,-$29(A1,A7.L)
        DC.W    $002B,$FFCE,$FFFD   ; $003C58 ORI.B  #$FFCE,-$0003(A3)
        DC.W    $0034,$0021,$0035   ; $003C5E ORI.B  #$0021,$35(A4,D0.W)
        DC.W    $FFF3,$FFD3         ; $003C64 MOVE.W  -$2D(A3,A7.L),<EA:3F>
        DC.W    $0021,$FFCA         ; $003C68 ORI.B  #$FFCA,-(A1)
        DC.W    $FFF3,$0034         ; $003C6C MOVE.W  $34(A3,D0.W),<EA:3F>
        DC.W    $0017,$0035         ; $003C70 ORI.B  #$0035,(A7)
        DC.W    $FFEE,$FFD3         ; $003C74 MOVE.W  -$002D(A6),<EA:3F>
        DC.W    $0017,$FFCA         ; $003C78 ORI.B  #$FFCA,(A7)
        DC.W    $FFEE,$3038         ; $003C7C MOVE.W  $3038(A6),<EA:3F>
        DC.W    $C8C8               ; $003C80 MULU    A0,D4
        DC.W    $E948               ; $003C82 LSL.W  #4,D0
        DC.W    $45FB,$00C8         ; $003C84 LEA     -$38(PC,D0.W),A2
        DC.W    $3038,$C8A0         ; $003C88 MOVE.W  $C8A0.W,D0
        DC.W    $D078,$C89E         ; $003C8C ADD.W  $C89E.W,D0
        DC.W    $47FB,$0098         ; $003C90 LEA     -$68(PC,D0.W),A3
        DC.W    $43F9,$00FF,$66DC   ; $003C94 LEA     $00FF66DC,A1
        DC.W    $7201               ; $003C9A MOVEQ   #$01,D1
        DC.W    $7403               ; $003C9C MOVEQ   #$03,D2
loc_003C9E:
        DC.W    $3341,$0000         ; $003C9E MOVE.W  D1,$0000(A1)
        DC.W    $301B               ; $003CA2 MOVE.W  (A3)+,D0
        DC.W    $D05A               ; $003CA4 ADD.W  (A2)+,D0
        DC.W    $3340,$0002         ; $003CA6 MOVE.W  D0,$0002(A1)
        DC.W    $335B,$0004         ; $003CAA MOVE.W  (A3)+,$0004(A1)
        DC.W    $301B               ; $003CAE MOVE.W  (A3)+,D0
        DC.W    $905A               ; $003CB0 SUB.W  (A2)+,D0
        DC.W    $3340,$0006         ; $003CB2 MOVE.W  D0,$0006(A1)
        DC.W    $43E9,$0014         ; $003CB6 LEA     $0014(A1),A1
        DC.W    $5D4B               ; $003CBA SUBQ.W  #6,A3
        DC.W    $51CA,$FFE0         ; $003CBC DBRA    D2,loc_003C9E
        DC.W    $7000               ; $003CC0 MOVEQ   #$00,D0
        DC.W    $600A               ; $003CC2 BRA.S  loc_003CCE
        DC.W    $7000               ; $003CC4 MOVEQ   #$00,D0
        DC.W    $3038,$C026         ; $003CC6 MOVE.W  $C026.W,D0
        DC.W    $6A02               ; $003CCA BPL.S  loc_003CCE
        DC.W    $4E75               ; $003CCC RTS
loc_003CCE:
        DC.W    $43F9,$00FF,$66EC   ; $003CCE LEA     $00FF66EC,A1
        DC.W    $45F9,$0089,$5B7E   ; $003CD4 LEA     $00895B7E,A2
        DC.W    $E940               ; $003CDA ASL.W  #4,D0
        DC.W    $7203               ; $003CDC MOVEQ   #$03,D1
loc_003CDE:
        DC.W    $265A               ; $003CDE MOVEA.L (A2)+,A3
        DC.W    $D7C0               ; $003CE0 ADDA.L  D0,A3
        DC.W    $228B               ; $003CE2 MOVE.L  A3,(A1)
        DC.W    $43E9,$0014         ; $003CE4 LEA     $0014(A1),A1
        DC.W    $51C9,$FFF4         ; $003CE8 DBRA    D1,loc_003CDE
        DC.W    $3238,$C026         ; $003CEC MOVE.W  $C026.W,D1
        DC.W    $0C41,$0007         ; $003CF0 CMPI.W  #$0007,D1
        DC.W    $6D2C               ; $003CF4 BLT.S  loc_003D22
        DC.W    $0C41,$0013         ; $003CF6 CMPI.W  #$0013,D1
        DC.W    $6C26               ; $003CFA BGE.S  loc_003D22
        DC.W    $7000               ; $003CFC MOVEQ   #$00,D0
        DC.W    $43F9,$00FF,$6128   ; $003CFE LEA     $00FF6128,A1
        DC.W    $3340,$0000         ; $003D04 MOVE.W  D0,$0000(A1)
        DC.W    $3340,$0014         ; $003D08 MOVE.W  D0,$0014(A1)
        DC.W    $4A78,$C04C         ; $003D0C TST.W  $C04C.W
        DC.W    $660E               ; $003D10 BNE.S  loc_003D20
        DC.W    $3340,$0028         ; $003D12 MOVE.W  D0,$0028(A1)
        DC.W    $4A78,$C8C8         ; $003D16 TST.W  $C8C8.W
        DC.W    $6604               ; $003D1A BNE.S  loc_003D20
        DC.W    $3340,$003C         ; $003D1C MOVE.W  D0,$003C(A1)
loc_003D20:
        DC.W    $4E75               ; $003D20 RTS
loc_003D22:
        DC.W    $0C41,$0004         ; $003D22 CMPI.W  #$0004,D1
        DC.W    $6606               ; $003D26 BNE.S  loc_003D2E
        DC.W    $11FC,$00BA,$C8A4   ; $003D28 MOVE.B  #$00BA,$C8A4.W
loc_003D2E:
        DC.W    $0C41,$0016         ; $003D2E CMPI.W  #$0016,D1
        DC.W    $6606               ; $003D32 BNE.S  loc_003D3A
        DC.W    $11FC,$00BA,$C8A4   ; $003D34 MOVE.B  #$00BA,$C8A4.W
loc_003D3A:
        DC.W    $7001               ; $003D3A MOVEQ   #$01,D0
        DC.W    $43F9,$00FF,$6128   ; $003D3C LEA     $00FF6128,A1
        DC.W    $3340,$0000         ; $003D42 MOVE.W  D0,$0000(A1)
        DC.W    $3340,$0014         ; $003D46 MOVE.W  D0,$0014(A1)
        DC.W    $4A78,$C04C         ; $003D4A TST.W  $C04C.W
        DC.W    $6608               ; $003D4E BNE.S  loc_003D58
        DC.W    $3340,$0028         ; $003D50 MOVE.W  D0,$0028(A1)
        DC.W    $3340,$003C         ; $003D54 MOVE.W  D0,$003C(A1)
loc_003D58:
        DC.W    $4E75               ; $003D58 RTS
        DC.W    $43F9,$00FF,$6980   ; $003D5A LEA     $00FF6980,A1
        DC.W    $12BC,$0009         ; $003D60 MOVE.B  #$0009,(A1)
        DC.W    $237C,$0402,$68F8,$0004; $003D64 MOVE.L  #$040268F8,$0004(A1)
        DC.W    $237C,$222F,$0FBE,$0008; $003D6C MOVE.L  #$222F0FBE,$0008(A1)
        DC.W    $43F9,$00FF,$69C0   ; $003D74 LEA     $00FF69C0,A1
        DC.W    $12BC,$0009         ; $003D7A MOVE.B  #$0009,(A1)
        DC.W    $43F9,$00FF,$6990   ; $003D7E LEA     $00FF6990,A1
        DC.W    $12BC,$0009         ; $003D84 MOVE.B  #$0009,(A1)
        DC.W    $237C,$0402,$C8EC,$0004; $003D88 MOVE.L  #$0402C8EC,$0004(A1)
        DC.W    $237C,$222F,$22A2,$0008; $003D90 MOVE.L  #$222F22A2,$0008(A1)
        DC.W    $4E75               ; $003D98 RTS
        DC.W    $31FC,$0000,$C8AA   ; $003D9A MOVE.W  #$0000,$C8AA.W
        DC.W    $5878,$C8AC         ; $003DA0 ADDQ.W  #4,$C8AC.W
        DC.W    $4E75               ; $003DA4 RTS
        DC.W    $0C78,$0014,$C8AA   ; $003DA6 CMPI.W  #$0014,$C8AA.W
        DC.W    $6F24               ; $003DAC BLE.S  loc_003DD2
        DC.W    $43F9,$00FF,$69C0   ; $003DAE LEA     $00FF69C0,A1
        DC.W    $137C,$0009,$0000   ; $003DB4 MOVE.B  #$0009,$0000(A1)
        DC.W    $237C,$222F,$1D4A,$0008; $003DBA MOVE.L  #$222F1D4A,$0008(A1)
        DC.W    $31FC,$0000,$C8AA   ; $003DC2 MOVE.W  #$0000,$C8AA.W
        DC.W    $11FC,$00A6,$C8A4   ; $003DC8 MOVE.B  #$00A6,$C8A4.W
        DC.W    $5878,$C8AC         ; $003DCE ADDQ.W  #4,$C8AC.W
loc_003DD2:
        DC.W    $4E75               ; $003DD2 RTS
        DC.W    $0C78,$0014,$C8AA   ; $003DD4 CMPI.W  #$0014,$C8AA.W
        DC.W    $6F2A               ; $003DDA BLE.S  loc_003E06
        DC.W    $23FC,$222F,$29EE,$00FF,$69C8; $003DDC MOVE.L  #$222F29EE,$00FF69C8
        DC.W    $23FC,$222F,$1716,$00FF,$6998; $003DE6 MOVE.L  #$222F1716,$00FF6998
        DC.W    $31FC,$0000,$C8AA   ; $003DF0 MOVE.W  #$0000,$C8AA.W
        DC.W    $11FC,$00A7,$C8A4   ; $003DF6 MOVE.B  #$00A7,$C8A4.W
        DC.W    $08F8,$0004,$C30E   ; $003DFC BSET    #4,$C30E.W
        DC.W    $5878,$C8AC         ; $003E02 ADDQ.W  #4,$C8AC.W
loc_003E06:
        DC.W    $4E75               ; $003E06 RTS
        DC.W    $0C78,$000A,$C8AA   ; $003E08 CMPI.W  #$000A,$C8AA.W
        DC.W    $6618               ; $003E0E BNE.S  loc_003E28
        DC.W    $3038,$C89C         ; $003E10 MOVE.W  $C89C.W,D0
        DC.W    $11FB,$003C,$C8A5   ; $003E14 MOVE.B  $3C(PC,D0.W),$C8A5.W
        DC.W    $0838,$0005,$C80E   ; $003E1A BTST    #5,$C80E.W
        DC.W    $6706               ; $003E20 BEQ.S  loc_003E28
        DC.W    $11FC,$0093,$C8A5   ; $003E22 MOVE.B  #$0093,$C8A5.W
loc_003E28:
        DC.W    $0C78,$0028,$C8AA   ; $003E28 CMPI.W  #$0028,$C8AA.W
        DC.W    $6F20               ; $003E2E BLE.S  loc_003E50
        DC.W    $31FC,$0000,$C8AA   ; $003E30 MOVE.W  #$0000,$C8AA.W
        DC.W    $31FC,$0000,$C8AC   ; $003E36 MOVE.W  #$0000,$C8AC.W
        DC.W    $7000               ; $003E3C MOVEQ   #$00,D0
        DC.W    $13C0,$00FF,$6980   ; $003E3E MOVE.B  D0,$00FF6980
        DC.W    $13C0,$00FF,$6990   ; $003E44 MOVE.B  D0,$00FF6990
        DC.W    $13C0,$00FF,$69C0   ; $003E4A MOVE.B  D0,$00FF69C0
loc_003E50:
        DC.W    $4E75               ; $003E50 RTS
        DC.W    $8383               ; $003E52 OR.L   D1,D3
        DC.W    $8499               ; $003E54 OR.L   (A1)+,D2
        DC.W    $9E99               ; $003E56 SUB.L  (A1)+,D7
        DC.W    $31FC,$0000,$C8AA   ; $003E58 MOVE.W  #$0000,$C8AA.W
        DC.W    $5878,$C8AC         ; $003E5E ADDQ.W  #4,$C8AC.W
        DC.W    $4E75               ; $003E62 RTS
        DC.W    $31FC,$0000,$C8AA   ; $003E64 MOVE.W  #$0000,$C8AA.W
        DC.W    $5878,$C8AC         ; $003E6A ADDQ.W  #4,$C8AC.W
        DC.W    $13FC,$0009,$00FF,$6980; $003E6E MOVE.B  #$0009,$00FF6980
        DC.W    $11FC,$00C0,$C8A4   ; $003E76 MOVE.B  #$00C0,$C8A4.W
        DC.W    $4E75               ; $003E7C RTS
        DC.W    $0C78,$0014,$C8AA   ; $003E7E CMPI.W  #$0014,$C8AA.W
        DC.W    $6F1A               ; $003E84 BLE.S  loc_003EA0
        DC.W    $23FC,$222F,$038A,$00FF,$6988; $003E86 MOVE.L  #$222F038A,$00FF6988
        DC.W    $11FC,$00C1,$C8A4   ; $003E90 MOVE.B  #$00C1,$C8A4.W
        DC.W    $31FC,$0000,$C8AA   ; $003E96 MOVE.W  #$0000,$C8AA.W
        DC.W    $5878,$C8AC         ; $003E9C ADDQ.W  #4,$C8AC.W
loc_003EA0:
        DC.W    $4E75               ; $003EA0 RTS
        DC.W    $0C78,$0014,$C8AA   ; $003EA2 CMPI.W  #$0014,$C8AA.W
        DC.W    $6F1A               ; $003EA8 BLE.S  loc_003EC4
        DC.W    $23FC,$222F,$002C,$00FF,$6988; $003EAA MOVE.L  #$222F002C,$00FF6988
        DC.W    $11FC,$00C2,$C8A4   ; $003EB4 MOVE.B  #$00C2,$C8A4.W
        DC.W    $31FC,$0000,$C8AA   ; $003EBA MOVE.W  #$0000,$C8AA.W
        DC.W    $5878,$C8AC         ; $003EC0 ADDQ.W  #4,$C8AC.W
loc_003EC4:
        DC.W    $4E75               ; $003EC4 RTS
        DC.W    $0C78,$0014,$C8AA   ; $003EC6 CMPI.W  #$0014,$C8AA.W
        DC.W    $6F26               ; $003ECC BLE.S  loc_003EF4
        DC.W    $23FC,$222E,$EF3A,$00FF,$6988; $003ECE MOVE.L  #$222EEF3A,$00FF6988
        DC.W    $11FC,$00C3,$C8A4   ; $003ED8 MOVE.B  #$00C3,$C8A4.W
        DC.W    $31FC,$0000,$C8AA   ; $003EDE MOVE.W  #$0000,$C8AA.W
        DC.W    $08F8,$0004,$C30E   ; $003EE4 BSET    #4,$C30E.W
        DC.W    $08F8,$0004,$B4EE   ; $003EEA BSET    #4,$B4EE.W
        DC.W    $5878,$C8AC         ; $003EF0 ADDQ.W  #4,$C8AC.W
loc_003EF4:
        DC.W    $4E75               ; $003EF4 RTS
        DC.W    $0C78,$0005,$C8AA   ; $003EF6 CMPI.W  #$0005,$C8AA.W
        DC.W    $6606               ; $003EFC BNE.S  loc_003F04
        DC.W    $11FC,$0098,$C8A5   ; $003EFE MOVE.B  #$0098,$C8A5.W
loc_003F04:
        DC.W    $7000               ; $003F04 MOVEQ   #$00,D0
        DC.W    $0838,$0002,$C8AB   ; $003F06 BTST    #2,$C8AB.W
        DC.W    $6602               ; $003F0C BNE.S  loc_003F10
        DC.W    $7009               ; $003F0E MOVEQ   #$09,D0
loc_003F10:
        DC.W    $13C0,$00FF,$6980   ; $003F10 MOVE.B  D0,$00FF6980
        DC.W    $0C78,$003C,$C8AA   ; $003F16 CMPI.W  #$003C,$C8AA.W
        DC.W    $6F0C               ; $003F1C BLE.S  loc_003F2A
        DC.W    $13FC,$0000,$00FF,$6980; $003F1E MOVE.B  #$0000,$00FF6980
        DC.W    $5878,$C8AC         ; $003F26 ADDQ.W  #4,$C8AC.W
loc_003F2A:
        DC.W    $4E75               ; $003F2A RTS
        DC.W    $4E75               ; $003F2C RTS
        DC.W    $7600               ; $003F2E MOVEQ   #$00,D3
        DC.W    $7800               ; $003F30 MOVEQ   #$00,D4
        DC.W    $4A79,$00FF,$6448   ; $003F32 TST.W  $00FF6448
        DC.W    $670A               ; $003F38 BEQ.S  loc_003F44
        DC.W    $4A68,$00C0         ; $003F3A TST.W  $00C0(A0)
        DC.W    $6704               ; $003F3E BEQ.S  loc_003F44
        DC.W    $7601               ; $003F40 MOVEQ   #$01,D3
        DC.W    $7802               ; $003F42 MOVEQ   #$02,D4
loc_003F44:
        DC.W    $43F9,$00FF,$64AC   ; $003F44 LEA     $00FF64AC,A1
        DC.W    $4EBA,$0044         ; $003F4A JSR     loc_003F90(PC)
        DC.W    $7601               ; $003F4E MOVEQ   #$01,D3
        DC.W    $7802               ; $003F50 MOVEQ   #$02,D4
        DC.W    $43F9,$00FF,$6178   ; $003F52 LEA     $00FF6178,A1
        DC.W    $6036               ; $003F58 BRA.S  loc_003F90
        DC.W    $7600               ; $003F5A MOVEQ   #$00,D3
        DC.W    $7800               ; $003F5C MOVEQ   #$00,D4
        DC.W    $4A79,$00FF,$6218   ; $003F5E TST.W  $00FF6218
        DC.W    $670A               ; $003F64 BEQ.S  loc_003F70
        DC.W    $4A68,$00C0         ; $003F66 TST.W  $00C0(A0)
        DC.W    $6704               ; $003F6A BEQ.S  loc_003F70
        DC.W    $7601               ; $003F6C MOVEQ   #$01,D3
        DC.W    $7802               ; $003F6E MOVEQ   #$02,D4
loc_003F70:
        DC.W    $43F9,$00FF,$627C   ; $003F70 LEA     $00FF627C,A1
        DC.W    $4EBA,$0018         ; $003F76 JSR     loc_003F90(PC)
        DC.W    $7601               ; $003F7A MOVEQ   #$01,D3
        DC.W    $7802               ; $003F7C MOVEQ   #$02,D4
        DC.W    $43F9,$00FF,$63A8   ; $003F7E LEA     $00FF63A8,A1
        DC.W    $600A               ; $003F84 BRA.S  loc_003F90
        DC.W    $43F9,$00FF,$6178   ; $003F86 LEA     $00FF6178,A1
        DC.W    $7601               ; $003F8C MOVEQ   #$01,D3
        DC.W    $7802               ; $003F8E MOVEQ   #$02,D4
loc_003F90:
        DC.W    $7200               ; $003F90 MOVEQ   #$00,D1
        DC.W    $7414               ; $003F92 MOVEQ   #$14,D2
        DC.W    $3341,$0000         ; $003F94 MOVE.W  D1,$0000(A1)
        DC.W    $3381,$2000         ; $003F98 MOVE.W  D1,$00(A1,D2.W)
        DC.W    $3038,$C00C         ; $003F9C MOVE.W  $C00C.W,D0
        DC.W    $6B1E               ; $003FA0 BMI.S  loc_003FC0
        DC.W    $D040               ; $003FA2 ADD.W  D0,D0
        DC.W    $D040               ; $003FA4 ADD.W  D0,D0
        DC.W    $45F9,$0089,$59B0   ; $003FA6 LEA     $008959B0,A2
        DC.W    $2372,$0000,$0010   ; $003FAC MOVE.L  $00(A2,D0.W),$0010(A1)
        DC.W    $3344,$0000         ; $003FB2 MOVE.W  D4,$0000(A1)
        DC.W    $23B2,$0000,$2010   ; $003FB6 MOVE.L  $00(A2,D0.W),$10(A1,D2.W)
        DC.W    $3383,$2000         ; $003FBC MOVE.W  D3,$00(A1,D2.W)
loc_003FC0:
        DC.W    $D3C2               ; $003FC0 ADDA.L  D2,A1
        DC.W    $D3C2               ; $003FC2 ADDA.L  D2,A1
        DC.W    $3341,$0000         ; $003FC4 MOVE.W  D1,$0000(A1)
        DC.W    $3038,$C012         ; $003FC8 MOVE.W  $C012.W,D0
        DC.W    $6B14               ; $003FCC BMI.S  loc_003FE2
        DC.W    $D040               ; $003FCE ADD.W  D0,D0
        DC.W    $D040               ; $003FD0 ADD.W  D0,D0
        DC.W    $45F9,$0089,$59D0   ; $003FD2 LEA     $008959D0,A2
        DC.W    $2372,$0000,$0010   ; $003FD8 MOVE.L  $00(A2,D0.W),$0010(A1)
        DC.W    $3343,$0000         ; $003FDE MOVE.W  D3,$0000(A1)
loc_003FE2:
        DC.W    $D3C2               ; $003FE2 ADDA.L  D2,A1
        DC.W    $3341,$0000         ; $003FE4 MOVE.W  D1,$0000(A1)
        DC.W    $3038,$C018         ; $003FE8 MOVE.W  $C018.W,D0
        DC.W    $6B14               ; $003FEC BMI.S  loc_004002
        DC.W    $D040               ; $003FEE ADD.W  D0,D0
        DC.W    $D040               ; $003FF0 ADD.W  D0,D0
        DC.W    $45F9,$0089,$59FC   ; $003FF2 LEA     $008959FC,A2
        DC.W    $2372,$0000,$0010   ; $003FF8 MOVE.L  $00(A2,D0.W),$0010(A1)
        DC.W    $3343,$0000         ; $003FFE MOVE.W  D3,$0000(A1)
loc_004002:
        DC.W    $D3C2               ; $004002 ADDA.L  D2,A1
        DC.W    $3341,$0000         ; $004004 MOVE.W  D1,$0000(A1)
        DC.W    $3038,$C01E         ; $004008 MOVE.W  $C01E.W,D0
        DC.W    $6B14               ; $00400C BMI.S  loc_004022
        DC.W    $D040               ; $00400E ADD.W  D0,D0
        DC.W    $D040               ; $004010 ADD.W  D0,D0
        DC.W    $45F9,$0089,$5A24   ; $004012 LEA     $00895A24,A2
        DC.W    $2372,$0000,$0010   ; $004018 MOVE.L  $00(A2,D0.W),$0010(A1)
        DC.W    $3344,$0000         ; $00401E MOVE.W  D4,$0000(A1)
loc_004022:
        DC.W    $D3C2               ; $004022 ADDA.L  D2,A1
        DC.W    $3341,$0000         ; $004024 MOVE.W  D1,$0000(A1)
        DC.W    $3038,$C024         ; $004028 MOVE.W  $C024.W,D0
        DC.W    $6B14               ; $00402C BMI.S  loc_004042
        DC.W    $D040               ; $00402E ADD.W  D0,D0
        DC.W    $D040               ; $004030 ADD.W  D0,D0
        DC.W    $45F9,$0089,$5A24   ; $004032 LEA     $00895A24,A2
        DC.W    $2372,$0000,$0010   ; $004038 MOVE.L  $00(A2,D0.W),$0010(A1)
        DC.W    $3343,$0000         ; $00403E MOVE.W  D3,$0000(A1)
loc_004042:
        DC.W    $D3C2               ; $004042 ADDA.L  D2,A1
        DC.W    $3341,$0000         ; $004044 MOVE.W  D1,$0000(A1)
        DC.W    $3038,$C00E         ; $004048 MOVE.W  $C00E.W,D0
        DC.W    $6B14               ; $00404C BMI.S  loc_004062
        DC.W    $D040               ; $00404E ADD.W  D0,D0
        DC.W    $D040               ; $004050 ADD.W  D0,D0
        DC.W    $45F9,$0089,$5A44   ; $004052 LEA     $00895A44,A2
        DC.W    $2372,$0000,$0010   ; $004058 MOVE.L  $00(A2,D0.W),$0010(A1)
        DC.W    $3344,$0000         ; $00405E MOVE.W  D4,$0000(A1)
loc_004062:
        DC.W    $D3C2               ; $004062 ADDA.L  D2,A1
        DC.W    $3341,$0000         ; $004064 MOVE.W  D1,$0000(A1)
        DC.W    $3038,$C010         ; $004068 MOVE.W  $C010.W,D0
        DC.W    $6B14               ; $00406C BMI.S  loc_004082
        DC.W    $D040               ; $00406E ADD.W  D0,D0
        DC.W    $D040               ; $004070 ADD.W  D0,D0
        DC.W    $45F9,$0089,$5A44   ; $004072 LEA     $00895A44,A2
        DC.W    $2372,$0000,$0010   ; $004078 MOVE.L  $00(A2,D0.W),$0010(A1)
        DC.W    $3343,$0000         ; $00407E MOVE.W  D3,$0000(A1)
loc_004082:
        DC.W    $4E75               ; $004082 RTS
        DC.W    $31FC,$0001,$C048   ; $004084 MOVE.W  #$0001,$C048.W
        DC.W    $3038,$C07C         ; $00408A MOVE.W  $C07C.W,D0
        DC.W    $227B,$0004         ; $00408E MOVEA.L $04(PC,D0.W),A1
        DC.W    $4ED1               ; $004092 JMP     (A1)
        DC.W    $0088,$40C8,$0088   ; $004094 ORI.L  #$40C80088,A0
        DC.W    $412E               ; $00409A DC.W    $412E
        DC.W    $0088,$413A,$0088   ; $00409C ORI.L  #$413A0088,A0
        DC.W    $4168               ; $0040A2 DC.W    $4168
        DC.W    $0088,$417C,$0088   ; $0040A4 ORI.L  #$417C0088,A0
        DC.W    $41E4               ; $0040AA LEA     -(A4),A0
        DC.W    $0088,$42BA,$0088   ; $0040AC ORI.L  #$42BA0088,A0
        DC.W    $4300               ; $0040B2 DC.W    $4300
        DC.W    $0088,$432E,$0088   ; $0040B4 ORI.L  #$432E0088,A0
        DC.W    $434A               ; $0040BA DC.W    $434A
        DC.W    $0088,$4390,$0088   ; $0040BC ORI.L  #$43900088,A0
        DC.W    $43BC               ; $0040C2 DC.W    $43BC
        DC.W    $0088,$43D0,$11FC   ; $0040C4 ORI.L  #$43D011FC,A0
        DC.W    $0001,$C800         ; $0040CA ORI.B  #$C800,D1
        DC.W    $0C78,$FFFF,$C050   ; $0040CE CMPI.W  #$FFFF,$C050.W
        DC.W    $6606               ; $0040D4 BNE.S  loc_0040DC
        DC.W    $31FC,$0000,$C050   ; $0040D6 MOVE.W  #$0000,$C050.W
loc_0040DC:
        DC.W    $13FC,$0000,$00FF,$6960; $0040DC MOVE.B  #$0000,$00FF6960
        DC.W    $13FC,$0000,$00FF,$6930; $0040E4 MOVE.B  #$0000,$00FF6930
        DC.W    $13FC,$0000,$00FF,$6970; $0040EC MOVE.B  #$0000,$00FF6970
        DC.W    $45F9,$00FF,$6754   ; $0040F4 LEA     $00FF6754,A2
        DC.W    $11FC,$00F3,$C822   ; $0040FA MOVE.B  #$00F3,$C822.W
        DC.W    $357C,$FFE0,$0004   ; $004100 MOVE.W  #$FFE0,$0004(A2)
        DC.W    $357C,$0040,$0006   ; $004106 MOVE.W  #$0040,$0006(A2)
        DC.W    $357C,$F600,$0008   ; $00410C MOVE.W  #$F600,$0008(A2)
        DC.W    $257C,$2229,$660C,$0010; $004112 MOVE.L  #$2229660C,$0010(A2)
        DC.W    $357C,$0001,$0000   ; $00411A MOVE.W  #$0001,$0000(A2)
        DC.W    $31FC,$0040,$C25C   ; $004120 MOVE.W  #$0040,$C25C.W
        DC.W    $5878,$C07C         ; $004126 ADDQ.W  #4,$C07C.W
        DC.W    $4EFA,$708C         ; $00412A JMP     $00B1B8(PC)
        DC.W    $11FC,$0096,$C8A5   ; $00412E MOVE.B  #$0096,$C8A5.W
        DC.W    $5878,$C07C         ; $004134 ADDQ.W  #4,$C07C.W
        DC.W    $4E75               ; $004138 RTS
        DC.W    $45F9,$00FF,$6754   ; $00413A LEA     $00FF6754,A2
        DC.W    $5078,$C25C         ; $004140 ADDQ.W  #8,$C25C.W
        DC.W    $3038,$C25C         ; $004144 MOVE.W  $C25C.W,D0
        DC.W    $3540,$0006         ; $004148 MOVE.W  D0,$0006(A2)
        DC.W    $546A,$0004         ; $00414C ADDQ.W  #2,$0004(A2)
        DC.W    $066A,$01C0,$0008   ; $004150 ADDI.W  #$01C0,$0008(A2)
        DC.W    $0C40,$0100         ; $004156 CMPI.W  #$0100,D0
        DC.W    $660A               ; $00415A BNE.S  loc_004166
        DC.W    $5878,$C07C         ; $00415C ADDQ.W  #4,$C07C.W
        DC.W    $31FC,$0000,$C8AA   ; $004160 MOVE.W  #$0000,$C8AA.W
loc_004166:
        DC.W    $4E75               ; $004166 RTS
        DC.W    $0C78,$003C,$C8AA   ; $004168 CMPI.W  #$003C,$C8AA.W
        DC.W    $660A               ; $00416E BNE.S  loc_00417A
        DC.W    $5878,$C07C         ; $004170 ADDQ.W  #4,$C07C.W
        DC.W    $31FC,$0000,$C8AA   ; $004174 MOVE.W  #$0000,$C8AA.W
loc_00417A:
        DC.W    $4E75               ; $00417A RTS
        DC.W    $0C78,$0015,$C8AA   ; $00417C CMPI.W  #$0015,$C8AA.W
        DC.W    $665E               ; $004182 BNE.S  loc_0041E2
        DC.W    $31F8,$C096,$C07A   ; $004184 MOVE.W  $C096.W,$C07A.W
        DC.W    $5878,$C07C         ; $00418A ADDQ.W  #4,$C07C.W
        DC.W    $33FC,$0000,$00FF,$6754; $00418E MOVE.W  #$0000,$00FF6754
        DC.W    $4A38,$FDA9         ; $004196 TST.B  $FDA9.W
        DC.W    $6746               ; $00419A BEQ.S  loc_0041E2
        DC.W    $0C38,$0001,$C30C   ; $00419C CMPI.B  #$0001,$C30C.W
        DC.W    $663E               ; $0041A2 BNE.S  loc_0041E2
        DC.W    $0838,$0007,$FDA8   ; $0041A4 BTST    #7,$FDA8.W
        DC.W    $6636               ; $0041AA BNE.S  loc_0041E2
        DC.W    $3038,$C89C         ; $0041AC MOVE.W  $C89C.W,D0
        DC.W    $01F8,$EF07         ; $0041B0 BSET    D0,$EF07.W
        DC.W    $0C38,$0002,$FDA9   ; $0041B4 CMPI.B  #$0002,$FDA9.W
        DC.W    $6604               ; $0041BA BNE.S  loc_0041C0
        DC.W    $01F8,$FEB7         ; $0041BC BSET    D0,$FEB7.W
loc_0041C0:
        DC.W    $0C38,$001F,$FEB7   ; $0041C0 CMPI.B  #$001F,$FEB7.W
        DC.W    $660C               ; $0041C6 BNE.S  loc_0041D4
        DC.W    $08F8,$0006,$FEB7   ; $0041C8 BSET    #6,$FEB7.W
        DC.W    $08F8,$0007,$FEB7   ; $0041CE BSET    #7,$FEB7.W
loc_0041D4:
        DC.W    $0C38,$001F,$EF07   ; $0041D4 CMPI.B  #$001F,$EF07.W
        DC.W    $6606               ; $0041DA BNE.S  loc_0041E2
        DC.W    $08F8,$0000,$FDA8   ; $0041DC BSET    #0,$FDA8.W
loc_0041E2:
        DC.W    $4E75               ; $0041E2 RTS
        DC.W    $11FC,$0001,$C800   ; $0041E4 MOVE.B  #$0001,$C800.W
        DC.W    $11FC,$00F3,$C822   ; $0041EA MOVE.B  #$00F3,$C822.W
        DC.W    $0838,$0005,$C30E   ; $0041F0 BTST    #5,$C30E.W
        DC.W    $6604               ; $0041F6 BNE.S  loc_0041FC
        DC.W    $4EBA,$6FBE         ; $0041F8 JSR     $00B1B8(PC)
loc_0041FC:
        DC.W    $4EB9,$0088,$CA20   ; $0041FC JSR     $0088CA20
