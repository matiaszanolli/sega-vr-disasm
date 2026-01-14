; Generated assembly for $0017EE-$002200
; Branch targets: 78
; Labels: 69
; Format: DC.W with decoded mnemonics as comments

        org     $0017EE

        DC.W    $1410               ; $0017EE MOVE.B  (A0),D2
        DC.W    $3200               ; $0017F0 MOVE.W  D0,D1
        DC.W    $B102               ; $0017F2 EOR.B  D0,D2
        DC.W    $C002               ; $0017F4 AND.B  D2,D0
        DC.W    $10C1               ; $0017F6 MOVE.B  D1,(A0)+
        DC.W    $10C0               ; $0017F8 MOVE.B  D0,(A0)+
        DC.W    $7C00               ; $0017FA MOVEQ   #$00,D6
        DC.W    $8C01               ; $0017FC OR.B   D1,D6
        DC.W    $0206,$000C         ; $0017FE ANDI.B  #$000C,D6
        DC.W    $1E1B               ; $001802 MOVE.B  (A3)+,D7
        DC.W    $0F01               ; $001804 BTST    D7,D1
        DC.W    $6704               ; $001806 BEQ.S  loc_00180C
        DC.W    $08C6,$0004         ; $001808 BSET    #4,D6
loc_00180C:
        DC.W    $1E1B               ; $00180C MOVE.B  (A3)+,D7
        DC.W    $0F01               ; $00180E BTST    D7,D1
        DC.W    $6704               ; $001810 BEQ.S  loc_001816
        DC.W    $08C6,$0006         ; $001812 BSET    #6,D6
loc_001816:
        DC.W    $1E1B               ; $001816 MOVE.B  (A3)+,D7
        DC.W    $0F01               ; $001818 BTST    D7,D1
        DC.W    $6704               ; $00181A BEQ.S  loc_001820
        DC.W    $08C6,$0001         ; $00181C BSET    #1,D6
loc_001820:
        DC.W    $1E1B               ; $001820 MOVE.B  (A3)+,D7
        DC.W    $0F01               ; $001822 BTST    D7,D1
        DC.W    $6704               ; $001824 BEQ.S  loc_00182A
        DC.W    $08C6,$0000         ; $001826 BSET    #0,D6
loc_00182A:
        DC.W    $1E1B               ; $00182A MOVE.B  (A3)+,D7
        DC.W    $0F01               ; $00182C BTST    D7,D1
        DC.W    $6704               ; $00182E BEQ.S  loc_001834
        DC.W    $08C6,$000A         ; $001830 BSET    #10,D6
loc_001834:
        DC.W    $1E1B               ; $001834 MOVE.B  (A3)+,D7
        DC.W    $0F01               ; $001836 BTST    D7,D1
        DC.W    $6704               ; $001838 BEQ.S  loc_00183E
        DC.W    $08C6,$0005         ; $00183A BSET    #5,D6
loc_00183E:
        DC.W    $1E1B               ; $00183E MOVE.B  (A3)+,D7
        DC.W    $0F01               ; $001840 BTST    D7,D1
        DC.W    $6704               ; $001842 BEQ.S  loc_001848
        DC.W    $08C6,$0009         ; $001844 BSET    #9,D6
loc_001848:
        DC.W    $1E1B               ; $001848 MOVE.B  (A3)+,D7
        DC.W    $0F01               ; $00184A BTST    D7,D1
        DC.W    $6704               ; $00184C BEQ.S  loc_001852
        DC.W    $08C6,$0008         ; $00184E BSET    #8,D6
loc_001852:
        DC.W    $3412               ; $001852 MOVE.W  (A2),D2
        DC.W    $34C6               ; $001854 MOVE.W  D6,(A2)+
        DC.W    $BD42               ; $001856 EOR.W  D6,D2
        DC.W    $CC42               ; $001858 AND.W  D2,D6
        DC.W    $34C6               ; $00185A MOVE.W  D6,(A2)+
        DC.W    $4E75               ; $00185C RTS
loc_00185E:
        DC.W    $33FC,$0100,$00A1,$1100; $00185E MOVE.W  #$0100,$00A11100
loc_001866:
        DC.W    $0839,$0000,$00A1,$1100; $001866 BTST    #0,$00A11100
        DC.W    $66F6               ; $00186E BNE.S  loc_001866
        DC.W    $12BC,$0040         ; $001870 MOVE.B  #$0040,(A1)
        DC.W    $7C00               ; $001874 MOVEQ   #$00,D6
        DC.W    $723F               ; $001876 MOVEQ   #$3F,D1
        DC.W    $C211               ; $001878 AND.B  (A1),D1
        DC.W    $1286               ; $00187A MOVE.B  D6,(A1)
        DC.W    $7E40               ; $00187C MOVEQ   #$40,D7
        DC.W    $7030               ; $00187E MOVEQ   #$30,D0
        DC.W    $C011               ; $001880 AND.B  (A1),D0
        DC.W    $E508               ; $001882 LSL.B  #2,D0
        DC.W    $8041               ; $001884 OR.W   D1,D0
        DC.W    $1287               ; $001886 MOVE.B  D7,(A1)
        DC.W    $4E71               ; $001888 NOP
        DC.W    $4E71               ; $00188A NOP
        DC.W    $4E71               ; $00188C NOP
        DC.W    $4E71               ; $00188E NOP
        DC.W    $1211               ; $001890 MOVE.B  (A1),D1
        DC.W    $1286               ; $001892 MOVE.B  D6,(A1)
        DC.W    $3A3C,$00FF         ; $001894 MOVE.W  #$00FF,D5
        DC.W    $1211               ; $001898 MOVE.B  (A1),D1
        DC.W    $1287               ; $00189A MOVE.B  D7,(A1)
        DC.W    $1211               ; $00189C MOVE.B  (A1),D1
        DC.W    $1286               ; $00189E MOVE.B  D6,(A1)
        DC.W    $4E71               ; $0018A0 NOP
        DC.W    $4E71               ; $0018A2 NOP
        DC.W    $4E71               ; $0018A4 NOP
        DC.W    $720F               ; $0018A6 MOVEQ   #$0F,D1
        DC.W    $C211               ; $0018A8 AND.B  (A1),D1
        DC.W    $661C               ; $0018AA BNE.S  loc_0018C8
        DC.W    $1287               ; $0018AC MOVE.B  D7,(A1)
        DC.W    $4E71               ; $0018AE NOP
        DC.W    $4E71               ; $0018B0 NOP
        DC.W    $4E71               ; $0018B2 NOP
        DC.W    $720F               ; $0018B4 MOVEQ   #$0F,D1
        DC.W    $C211               ; $0018B6 AND.B  (A1),D1
        DC.W    $E149               ; $0018B8 LSL.W  #8,D1
        DC.W    $8041               ; $0018BA OR.W   D1,D0
        DC.W    $4640               ; $0018BC NOT.W  D0
        DC.W    $33FC,$0000,$00A1,$1100; $0018BE MOVE.W  #$0000,$00A11100
        DC.W    $4E75               ; $0018C6 RTS
loc_0018C8:
        DC.W    $4640               ; $0018C8 NOT.W  D0
        DC.W    $C045               ; $0018CA AND.W  D5,D0
        DC.W    $1287               ; $0018CC MOVE.B  D7,(A1)
        DC.W    $33FC,$0000,$00A1,$1100; $0018CE MOVE.W  #$0000,$00A11100
        DC.W    $4E75               ; $0018D6 RTS
        DC.W    $7000               ; $0018D8 MOVEQ   #$00,D0
        DC.W    $6100,$00B6         ; $0018DA BSR.W  loc_001992
        DC.W    $11C0,$C810         ; $0018DE MOVE.B  D0,$C810.W
        DC.W    $7001               ; $0018E2 MOVEQ   #$01,D0
        DC.W    $6100,$00AC         ; $0018E4 BSR.W  loc_001992
        DC.W    $11C0,$C811         ; $0018E8 MOVE.B  D0,$C811.W
        DC.W    $7002               ; $0018EC MOVEQ   #$02,D0
        DC.W    $6100,$00A2         ; $0018EE BSR.W  loc_001992
        DC.W    $11C0,$C812         ; $0018F2 MOVE.B  D0,$C812.W
        DC.W    $33FC,$0100,$00A1,$1100; $0018F6 MOVE.W  #$0100,$00A11100
loc_0018FE:
        DC.W    $0839,$0000,$00A1,$1100; $0018FE BTST    #0,$00A11100
        DC.W    $66F6               ; $001906 BNE.S  loc_0018FE
        DC.W    $7040               ; $001908 MOVEQ   #$40,D0
        DC.W    $13C0,$00A1,$0009   ; $00190A MOVE.B  D0,$00A10009
        DC.W    $13C0,$00A1,$000B   ; $001910 MOVE.B  D0,$00A1000B
        DC.W    $13C0,$00A1,$000D   ; $001916 MOVE.B  D0,$00A1000D
        DC.W    $303C,$00C0         ; $00191C MOVE.W  #$00C0,D0
        DC.W    $13C0,$00A1,$0003   ; $001920 MOVE.B  D0,$00A10003
        DC.W    $13C0,$00A1,$0005   ; $001926 MOVE.B  D0,$00A10005
        DC.W    $13C0,$00A1,$0007   ; $00192C MOVE.B  D0,$00A10007
        DC.W    $33FC,$0000,$00A1,$1100; $001932 MOVE.W  #$0000,$00A11100
        DC.W    $3E3C,$1400         ; $00193A MOVE.W  #$1400,D7
loc_00193E:
        DC.W    $51CF,$FFFE         ; $00193E DBRA    D7,loc_00193E
        DC.W    $11FC,$0000,$C818   ; $001942 MOVE.B  #$0000,$C818.W
        DC.W    $43F9,$00A1,$0003   ; $001948 LEA     $00A10003,A1
        DC.W    $4EBA,$FF0E         ; $00194E JSR     loc_00185E(PC)
        DC.W    $0800,$000F         ; $001952 BTST    #15,D0
        DC.W    $6706               ; $001956 BEQ.S  loc_00195E
        DC.W    $08F8,$0000,$C818   ; $001958 BSET    #0,$C818.W
loc_00195E:
        DC.W    $43F9,$00A1,$0005   ; $00195E LEA     $00A10005,A1
        DC.W    $4EBA,$FEF8         ; $001964 JSR     loc_00185E(PC)
        DC.W    $0800,$000F         ; $001968 BTST    #15,D0
        DC.W    $6706               ; $00196C BEQ.S  loc_001974
        DC.W    $08F8,$0001,$C818   ; $00196E BSET    #1,$C818.W
loc_001974:
        DC.W    $0C38,$000D,$C810   ; $001974 CMPI.B  #$000D,$C810.W
        DC.W    $6706               ; $00197A BEQ.S  loc_001982
        DC.W    $08F8,$0002,$C818   ; $00197C BSET    #2,$C818.W
loc_001982:
        DC.W    $0C38,$000D,$C811   ; $001982 CMPI.B  #$000D,$C811.W
        DC.W    $6706               ; $001988 BEQ.S  loc_001990
        DC.W    $08F8,$0003,$C818   ; $00198A BSET    #3,$C818.W
loc_001990:
        DC.W    $4E75               ; $001990 RTS
loc_001992:
        DC.W    $33FC,$0100,$00A1,$1100; $001992 MOVE.W  #$0100,$00A11100
loc_00199A:
        DC.W    $0839,$0000,$00A1,$1100; $00199A BTST    #0,$00A11100
        DC.W    $66F6               ; $0019A2 BNE.S  loc_00199A
        DC.W    $48E7,$6040         ; $0019A4 MOVEM.L -(A7),D6/A5/A6
        DC.W    $D040               ; $0019A8 ADD.W  D0,D0
        DC.W    $D040               ; $0019AA ADD.W  D0,D0
        DC.W    $41FA,$0044         ; $0019AC LEA     $0044(PC),A0
        DC.W    $2070,$0000         ; $0019B0 MOVEA.L $00(A0,D0.W),A0
        DC.W    $43FA,$0034         ; $0019B4 LEA     $0034(PC),A1
        DC.W    $1151,$0006         ; $0019B8 MOVE.B  (A1),$0006(A0)
        DC.W    $7000               ; $0019BC MOVEQ   #$00,D0
        DC.W    $7208               ; $0019BE MOVEQ   #$08,D1
loc_0019C0:
        DC.W    $1099               ; $0019C0 MOVE.B  (A1)+,(A0)
        DC.W    $4E71               ; $0019C2 NOP
        DC.W    $4E71               ; $0019C4 NOP
        DC.W    $4E71               ; $0019C6 NOP
        DC.W    $4E71               ; $0019C8 NOP
        DC.W    $1410               ; $0019CA MOVE.B  (A0),D2
        DC.W    $C419               ; $0019CC AND.B  (A1)+,D2
        DC.W    $6700,$0004         ; $0019CE BEQ.W  loc_0019D4
        DC.W    $8001               ; $0019D2 OR.B   D1,D0
loc_0019D4:
        DC.W    $E209               ; $0019D4 LSR.B  #1,D1
        DC.W    $66E8               ; $0019D6 BNE.S  loc_0019C0
        DC.W    $4228,$0006         ; $0019D8 CLR.B  $0006(A0)
        DC.W    $4CDF,$0206         ; $0019DC MOVEM.L D1/D2/A1,(A7)+
        DC.W    $33FC,$0000,$00A1,$1100; $0019E0 MOVE.W  #$0000,$00A11100
        DC.W    $4E75               ; $0019E8 RTS
        DC.W    $400C               ; $0019EA NEGX.B A4
        DC.W    $4003               ; $0019EC NEGX.B D3
        DC.W    $000C,$0003         ; $0019EE ORI.B  #$0003,A4
        DC.W    $00A1,$0003,$00A1   ; $0019F2 ORI.L  #$000300A1,-(A1)
        DC.W    $0005,$00A1         ; $0019F8 ORI.B  #$00A1,D5
        DC.W    $0007,$3015         ; $0019FC ORI.B  #$3015,D7
        DC.W    $2ABC,$6C00,$0003   ; $001A00 MOVE.L  #$6C000003,(A5)
        DC.W    $3CB8,$8000         ; $001A06 MOVE.W  $8000.W,(A6)
        DC.W    $3CB8,$8002         ; $001A0A MOVE.W  $8002.W,(A6)
        DC.W    $2ABC,$4000,$0010   ; $001A0E MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $001A14 MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $001A18 MOVE.W  $C882.W,(A6)
        DC.W    $33FC,$0100,$00A1,$1100; $001A1C MOVE.W  #$0100,$00A11100
loc_001A24:
        DC.W    $0839,$0000,$00A1,$1100; $001A24 BTST    #0,$00A11100
        DC.W    $66F6               ; $001A2C BNE.S  loc_001A24
        DC.W    $3838,$C874         ; $001A2E MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001A32 BSET    #4,D4
        DC.W    $3A84               ; $001A36 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9340,$9400   ; $001A38 MOVE.L  #$93409400,(A5)
        DC.W    $2ABC,$9540,$96C2   ; $001A3E MOVE.L  #$954096C2,(A5)
        DC.W    $3ABC,$977F         ; $001A44 MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$C000         ; $001A48 MOVE.W  #$C000,(A5)
        DC.W    $31FC,$0080,$C876   ; $001A4C MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $001A52 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001A56 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $001A5A MOVE.W  #$0000,$00A11100
        DC.W    $4E75               ; $001A62 RTS
        DC.W    $31FC,$002C,$C87A   ; $001A64 MOVE.W  #$002C,$C87A.W
        DC.W    $4EFA,$065A         ; $001A6A JMP     loc_0020C6(PC)
        DC.W    $3015               ; $001A6E MOVE.W  (A5),D0
        DC.W    $4E75               ; $001A70 RTS
        DC.W    $3015               ; $001A72 MOVE.W  (A5),D0
        DC.W    $2ABC,$4000,$0010   ; $001A74 MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $001A7A MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $001A7E MOVE.W  $C882.W,(A6)
        DC.W    $33FC,$0100,$00A1,$1100; $001A82 MOVE.W  #$0100,$00A11100
loc_001A8A:
        DC.W    $0839,$0000,$00A1,$1100; $001A8A BTST    #0,$00A11100
        DC.W    $66F6               ; $001A92 BNE.S  loc_001A8A
        DC.W    $3838,$C874         ; $001A94 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001A98 BSET    #4,D4
        DC.W    $3A84               ; $001A9C MOVE.W  D4,(A5)
        DC.W    $2ABC,$9340,$9400   ; $001A9E MOVE.L  #$93409400,(A5)
        DC.W    $2ABC,$9540,$96C2   ; $001AA4 MOVE.L  #$954096C2,(A5)
        DC.W    $3ABC,$977F         ; $001AAA MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$C000         ; $001AAE MOVE.W  #$C000,(A5)
        DC.W    $31FC,$0080,$C876   ; $001AB2 MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $001AB8 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001ABC MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $001AC0 MOVE.W  #$0000,$00A11100
        DC.W    $4E75               ; $001AC8 RTS
        DC.W    $3015               ; $001ACA MOVE.W  (A5),D0
        DC.W    $33FC,$0100,$00A1,$1100; $001ACC MOVE.W  #$0100,$00A11100
loc_001AD4:
        DC.W    $0839,$0000,$00A1,$1100; $001AD4 BTST    #0,$00A11100
        DC.W    $66F6               ; $001ADC BNE.S  loc_001AD4
        DC.W    $3838,$C874         ; $001ADE MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001AE2 BSET    #4,D4
        DC.W    $3A84               ; $001AE6 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9380,$9401   ; $001AE8 MOVE.L  #$93809401,(A5)
        DC.W    $2ABC,$951E,$96C0   ; $001AEE MOVE.L  #$951E96C0,(A5)
        DC.W    $3ABC,$977F         ; $001AF4 MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$6C3C         ; $001AF8 MOVE.W  #$6C3C,(A5)
        DC.W    $31FC,$0083,$C876   ; $001AFC MOVE.W  #$0083,$C876.W
        DC.W    $3AB8,$C876         ; $001B02 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001B06 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $001B0A MOVE.W  #$0000,$00A11100
        DC.W    $4E75               ; $001B12 RTS
        DC.W    $3015               ; $001B14 MOVE.W  (A5),D0
        DC.W    $2ABC,$6C00,$0003   ; $001B16 MOVE.L  #$6C000003,(A5)
        DC.W    $3CB8,$8000         ; $001B1C MOVE.W  $8000.W,(A6)
        DC.W    $3CB8,$8002         ; $001B20 MOVE.W  $8002.W,(A6)
        DC.W    $2ABC,$4000,$0010   ; $001B24 MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $001B2A MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $001B2E MOVE.W  $C882.W,(A6)
        DC.W    $33FC,$0100,$00A1,$1100; $001B32 MOVE.W  #$0100,$00A11100
loc_001B3A:
        DC.W    $0839,$0000,$00A1,$1100; $001B3A BTST    #0,$00A11100
        DC.W    $66F6               ; $001B42 BNE.S  loc_001B3A
        DC.W    $3838,$C874         ; $001B44 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001B48 BSET    #4,D4
        DC.W    $3A84               ; $001B4C MOVE.W  D4,(A5)
        DC.W    $2ABC,$9380,$9403   ; $001B4E MOVE.L  #$93809403,(A5)
        DC.W    $2ABC,$9500,$9688   ; $001B54 MOVE.L  #$95009688,(A5)
        DC.W    $3ABC,$977F         ; $001B5A MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$6000         ; $001B5E MOVE.W  #$6000,(A5)
        DC.W    $31FC,$0082,$C876   ; $001B62 MOVE.W  #$0082,$C876.W
        DC.W    $3AB8,$C876         ; $001B68 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001B6C MOVE.W  $C874.W,(A5)
        DC.W    $3838,$C874         ; $001B70 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001B74 BSET    #4,D4
        DC.W    $3A84               ; $001B78 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9340,$9400   ; $001B7A MOVE.L  #$93409400,(A5)
        DC.W    $2ABC,$9540,$96C2   ; $001B80 MOVE.L  #$954096C2,(A5)
        DC.W    $3ABC,$977F         ; $001B86 MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$C000         ; $001B8A MOVE.W  #$C000,(A5)
        DC.W    $31FC,$0080,$C876   ; $001B8E MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $001B94 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001B98 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $001B9C MOVE.W  #$0000,$00A11100
        DC.W    $4EFA,$FBF8         ; $001BA4 JMP     $00179E(PC)
        DC.W    $3015               ; $001BA8 MOVE.W  (A5),D0
        DC.W    $33FC,$0100,$00A1,$1100; $001BAA MOVE.W  #$0100,$00A11100
loc_001BB2:
        DC.W    $0839,$0000,$00A1,$1100; $001BB2 BTST    #0,$00A11100
        DC.W    $66F6               ; $001BBA BNE.S  loc_001BB2
        DC.W    $3838,$C874         ; $001BBC MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001BC0 BSET    #4,D4
        DC.W    $3A84               ; $001BC4 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9380,$9403   ; $001BC6 MOVE.L  #$93809403,(A5)
        DC.W    $2ABC,$9500,$9688   ; $001BCC MOVE.L  #$95009688,(A5)
        DC.W    $3ABC,$977F         ; $001BD2 MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$6000         ; $001BD6 MOVE.W  #$6000,(A5)
        DC.W    $31FC,$0082,$C876   ; $001BDA MOVE.W  #$0082,$C876.W
        DC.W    $3AB8,$C876         ; $001BE0 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001BE4 MOVE.W  $C874.W,(A5)
        DC.W    $3838,$C874         ; $001BE8 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001BEC BSET    #4,D4
        DC.W    $3A84               ; $001BF0 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9380,$9403   ; $001BF2 MOVE.L  #$93809403,(A5)
        DC.W    $2ABC,$9580,$968B   ; $001BF8 MOVE.L  #$9580968B,(A5)
        DC.W    $3ABC,$977F         ; $001BFE MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$4000         ; $001C02 MOVE.W  #$4000,(A5)
        DC.W    $31FC,$0083,$C876   ; $001C06 MOVE.W  #$0083,$C876.W
        DC.W    $3AB8,$C876         ; $001C0C MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001C10 MOVE.W  $C874.W,(A5)
        DC.W    $3838,$C874         ; $001C14 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001C18 BSET    #4,D4
        DC.W    $3A84               ; $001C1C MOVE.W  D4,(A5)
        DC.W    $2ABC,$9340,$9400   ; $001C1E MOVE.L  #$93409400,(A5)
        DC.W    $2ABC,$9540,$96C2   ; $001C24 MOVE.L  #$954096C2,(A5)
        DC.W    $3ABC,$977F         ; $001C2A MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$C000         ; $001C2E MOVE.W  #$C000,(A5)
        DC.W    $31FC,$0080,$C876   ; $001C32 MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $001C38 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001C3C MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $001C40 MOVE.W  #$0000,$00A11100
        DC.W    $2ABC,$6C00,$0003   ; $001C48 MOVE.L  #$6C000003,(A5)
        DC.W    $3CB8,$8000         ; $001C4E MOVE.W  $8000.W,(A6)
        DC.W    $3CB8,$8002         ; $001C52 MOVE.W  $8002.W,(A6)
        DC.W    $2ABC,$4000,$0010   ; $001C56 MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $001C5C MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $001C60 MOVE.W  $C882.W,(A6)
        DC.W    $4E75               ; $001C64 RTS
        DC.W    $3015               ; $001C66 MOVE.W  (A5),D0
        DC.W    $2ABC,$6C00,$0003   ; $001C68 MOVE.L  #$6C000003,(A5)
        DC.W    $3CB8,$8000         ; $001C6E MOVE.W  $8000.W,(A6)
        DC.W    $3CB8,$8002         ; $001C72 MOVE.W  $8002.W,(A6)
        DC.W    $2ABC,$4000,$0010   ; $001C76 MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $001C7C MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $001C80 MOVE.W  $C882.W,(A6)
        DC.W    $33FC,$0100,$00A1,$1100; $001C84 MOVE.W  #$0100,$00A11100
loc_001C8C:
        DC.W    $0839,$0000,$00A1,$1100; $001C8C BTST    #0,$00A11100
        DC.W    $66F6               ; $001C94 BNE.S  loc_001C8C
        DC.W    $3838,$C874         ; $001C96 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001C9A BSET    #4,D4
        DC.W    $3A84               ; $001C9E MOVE.W  D4,(A5)
        DC.W    $2ABC,$9340,$9400   ; $001CA0 MOVE.L  #$93409400,(A5)
        DC.W    $2ABC,$9540,$96C2   ; $001CA6 MOVE.L  #$954096C2,(A5)
        DC.W    $3ABC,$977F         ; $001CAC MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$C000         ; $001CB0 MOVE.W  #$C000,(A5)
        DC.W    $31FC,$0080,$C876   ; $001CB4 MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $001CBA MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001CBE MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $001CC2 MOVE.W  #$0000,$00A11100
        DC.W    $4A39,$00A1,$5120   ; $001CCA TST.B  $00A15120
        DC.W    $6638               ; $001CD0 BNE.S  loc_001D0A
        DC.W    $08B9,$0007,$00A1,$5100; $001CD2 BCLR    #7,$00A15100
loc_001CDA:
        DC.W    $0839,$0007,$00A1,$518A; $001CDA BTST    #7,$00A1518A
        DC.W    $67F6               ; $001CE2 BEQ.S  loc_001CDA
        DC.W    $4EBA,$0B92         ; $001CE4 JSR     $002878(PC)
        DC.W    $0878,$0000,$C80C   ; $001CE8 BCHG    #0,$C80C.W
        DC.W    $660A               ; $001CEE BNE.S  loc_001CFA
        DC.W    $08F9,$0000,$00A1,$518B; $001CF0 BSET    #0,$00A1518B
        DC.W    $6008               ; $001CF8 BRA.S  loc_001D02
loc_001CFA:
        DC.W    $08B9,$0000,$00A1,$518B; $001CFA BCLR    #0,$00A1518B
loc_001D02:
        DC.W    $08F9,$0007,$00A1,$5100; $001D02 BSET    #7,$00A15100
loc_001D0A:
        DC.W    $4E75               ; $001D0A RTS
        DC.W    $3015               ; $001D0C MOVE.W  (A5),D0
        DC.W    $2ABC,$6C00,$0003   ; $001D0E MOVE.L  #$6C000003,(A5)
        DC.W    $3CB8,$8000         ; $001D14 MOVE.W  $8000.W,(A6)
        DC.W    $3CB8,$8002         ; $001D18 MOVE.W  $8002.W,(A6)
        DC.W    $2ABC,$4000,$0010   ; $001D1C MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $001D22 MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $001D26 MOVE.W  $C882.W,(A6)
        DC.W    $33FC,$0100,$00A1,$1100; $001D2A MOVE.W  #$0100,$00A11100
loc_001D32:
        DC.W    $0839,$0000,$00A1,$1100; $001D32 BTST    #0,$00A11100
        DC.W    $66F6               ; $001D3A BNE.S  loc_001D32
        DC.W    $3838,$C874         ; $001D3C MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001D40 BSET    #4,D4
        DC.W    $3A84               ; $001D44 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9340,$9400   ; $001D46 MOVE.L  #$93409400,(A5)
        DC.W    $2ABC,$9540,$96C2   ; $001D4C MOVE.L  #$954096C2,(A5)
        DC.W    $3ABC,$977F         ; $001D52 MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$C000         ; $001D56 MOVE.W  #$C000,(A5)
        DC.W    $31FC,$0080,$C876   ; $001D5A MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $001D60 MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001D64 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $001D68 MOVE.W  #$0000,$00A11100
        DC.W    $0839,$0000,$00A1,$5123; $001D70 BTST    #0,$00A15123
        DC.W    $6742               ; $001D78 BEQ.S  loc_001DBC
        DC.W    $08B9,$0000,$00A1,$5123; $001D7A BCLR    #0,$00A15123
        DC.W    $31FC,$0000,$C87E   ; $001D82 MOVE.W  #$0000,$C87E.W
        DC.W    $08B9,$0007,$00A1,$5100; $001D88 BCLR    #7,$00A15100
loc_001D90:
        DC.W    $0839,$0007,$00A1,$518A; $001D90 BTST    #7,$00A1518A
        DC.W    $67F6               ; $001D98 BEQ.S  loc_001D90
        DC.W    $0878,$0000,$C80C   ; $001D9A BCHG    #0,$C80C.W
        DC.W    $660A               ; $001DA0 BNE.S  loc_001DAC
        DC.W    $08F9,$0000,$00A1,$518B; $001DA2 BSET    #0,$00A1518B
        DC.W    $6008               ; $001DAA BRA.S  loc_001DB4
loc_001DAC:
        DC.W    $08B9,$0000,$00A1,$518B; $001DAC BCLR    #0,$00A1518B
loc_001DB4:
        DC.W    $08F9,$0007,$00A1,$5100; $001DB4 BSET    #7,$00A15100
loc_001DBC:
        DC.W    $4E75               ; $001DBC RTS
        DC.W    $3015               ; $001DBE MOVE.W  (A5),D0
        DC.W    $3E3C,$0063         ; $001DC0 MOVE.W  #$0063,D7
loc_001DC4:
        DC.W    $4E71               ; $001DC4 NOP
        DC.W    $51CF,$FFFC         ; $001DC6 DBRA    D7,loc_001DC4
        DC.W    $2ABC,$6C00,$0003   ; $001DCA MOVE.L  #$6C000003,(A5)
        DC.W    $3CB8,$8000         ; $001DD0 MOVE.W  $8000.W,(A6)
        DC.W    $3CB8,$8002         ; $001DD4 MOVE.W  $8002.W,(A6)
        DC.W    $2ABC,$4000,$0010   ; $001DD8 MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $001DDE MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $001DE2 MOVE.W  $C882.W,(A6)
        DC.W    $0839,$0000,$00A1,$5123; $001DE6 BTST    #0,$00A15123
        DC.W    $6750               ; $001DEE BEQ.S  loc_001E40
        DC.W    $08B9,$0000,$00A1,$5123; $001DF0 BCLR    #0,$00A15123
        DC.W    $0C38,$0018,$C8C5   ; $001DF8 CMPI.B  #$0018,$C8C5.W
        DC.W    $6606               ; $001DFE BNE.S  loc_001E06
        DC.W    $31FC,$0000,$C87E   ; $001E00 MOVE.W  #$0000,$C87E.W
loc_001E06:
        DC.W    $11FC,$0000,$C8C4   ; $001E06 MOVE.B  #$0000,$C8C4.W
        DC.W    $08B9,$0007,$00A1,$5100; $001E0C BCLR    #7,$00A15100
loc_001E14:
        DC.W    $0839,$0007,$00A1,$518A; $001E14 BTST    #7,$00A1518A
        DC.W    $67F6               ; $001E1C BEQ.S  loc_001E14
        DC.W    $0878,$0000,$C80C   ; $001E1E BCHG    #0,$C80C.W
        DC.W    $660A               ; $001E24 BNE.S  loc_001E30
        DC.W    $08F9,$0000,$00A1,$518B; $001E26 BSET    #0,$00A1518B
        DC.W    $6008               ; $001E2E BRA.S  loc_001E38
loc_001E30:
        DC.W    $08B9,$0000,$00A1,$518B; $001E30 BCLR    #0,$00A1518B
loc_001E38:
        DC.W    $08F9,$0007,$00A1,$5100; $001E38 BSET    #7,$00A15100
loc_001E40:
        DC.W    $4E75               ; $001E40 RTS
        DC.W    $3015               ; $001E42 MOVE.W  (A5),D0
        DC.W    $2ABC,$6C00,$0003   ; $001E44 MOVE.L  #$6C000003,(A5)
        DC.W    $3CB8,$8000         ; $001E4A MOVE.W  $8000.W,(A6)
        DC.W    $3CB8,$8002         ; $001E4E MOVE.W  $8002.W,(A6)
        DC.W    $2ABC,$4000,$0010   ; $001E52 MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $001E58 MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $001E5C MOVE.W  $C882.W,(A6)
        DC.W    $31FC,$0000,$C87E   ; $001E60 MOVE.W  #$0000,$C87E.W
        DC.W    $0878,$0000,$C80C   ; $001E66 BCHG    #0,$C80C.W
        DC.W    $660A               ; $001E6C BNE.S  loc_001E78
        DC.W    $08F9,$0000,$00A1,$518B; $001E6E BSET    #0,$00A1518B
        DC.W    $6008               ; $001E76 BRA.S  loc_001E80
loc_001E78:
        DC.W    $08B9,$0000,$00A1,$518B; $001E78 BCLR    #0,$00A1518B
loc_001E80:
        DC.W    $41F8,$A100         ; $001E80 LEA     $A100.W,A0
        DC.W    $43F9,$00A1,$5200   ; $001E84 LEA     $00A15200,A1
        DC.W    $707F               ; $001E8A MOVEQ   #$7F,D0
loc_001E8C:
        DC.W    $22D8               ; $001E8C MOVE.L  (A0)+,(A1)+
        DC.W    $51C8,$FFFC         ; $001E8E DBRA    D0,loc_001E8C
        DC.W    $4E75               ; $001E92 RTS
        DC.W    $3015               ; $001E94 MOVE.W  (A5),D0
        DC.W    $33FC,$0100,$00A1,$1100; $001E96 MOVE.W  #$0100,$00A11100
loc_001E9E:
        DC.W    $0839,$0000,$00A1,$1100; $001E9E BTST    #0,$00A11100
        DC.W    $66F6               ; $001EA6 BNE.S  loc_001E9E
        DC.W    $3838,$C874         ; $001EA8 MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001EAC BSET    #4,D4
        DC.W    $3A84               ; $001EB0 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9320,$9400   ; $001EB2 MOVE.L  #$93209400,(A5)
        DC.W    $2ABC,$9500,$96D8   ; $001EB8 MOVE.L  #$950096D8,(A5)
        DC.W    $3ABC,$977F         ; $001EBE MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$C000         ; $001EC2 MOVE.W  #$C000,(A5)
        DC.W    $31FC,$0080,$C876   ; $001EC6 MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $001ECC MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001ED0 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $001ED4 MOVE.W  #$0000,$00A11100
        DC.W    $0839,$0000,$00A1,$5123; $001EDC BTST    #0,$00A15123
        DC.W    $6762               ; $001EE4 BEQ.S  loc_001F48
        DC.W    $08B9,$0000,$00A1,$5123; $001EE6 BCLR    #0,$00A15123
        DC.W    $0C38,$0018,$C8C5   ; $001EEE CMPI.B  #$0018,$C8C5.W
        DC.W    $6606               ; $001EF4 BNE.S  loc_001EFC
        DC.W    $31FC,$0000,$C87E   ; $001EF6 MOVE.W  #$0000,$C87E.W
loc_001EFC:
        DC.W    $11FC,$0000,$C8C4   ; $001EFC MOVE.B  #$0000,$C8C4.W
        DC.W    $08B9,$0007,$00A1,$5100; $001F02 BCLR    #7,$00A15100
loc_001F0A:
        DC.W    $0839,$0007,$00A1,$518A; $001F0A BTST    #7,$00A1518A
        DC.W    $67F6               ; $001F12 BEQ.S  loc_001F0A
        DC.W    $43F8,$B400         ; $001F14 LEA     $B400.W,A1
        DC.W    $45F9,$00A1,$5200   ; $001F18 LEA     $00A15200,A2
        DC.W    $4EBA,$29B6         ; $001F1E JSR     $0048D6(PC)
        DC.W    $4EBA,$29B6         ; $001F22 JSR     $0048DA(PC)
        DC.W    $0878,$0000,$C80C   ; $001F26 BCHG    #0,$C80C.W
        DC.W    $660A               ; $001F2C BNE.S  loc_001F38
        DC.W    $08F9,$0000,$00A1,$518B; $001F2E BSET    #0,$00A1518B
        DC.W    $6008               ; $001F36 BRA.S  loc_001F40
loc_001F38:
        DC.W    $08B9,$0000,$00A1,$518B; $001F38 BCLR    #0,$00A1518B
loc_001F40:
        DC.W    $08F9,$0007,$00A1,$5100; $001F40 BSET    #7,$00A15100
loc_001F48:
        DC.W    $4E75               ; $001F48 RTS
        DC.W    $3015               ; $001F4A MOVE.W  (A5),D0
        DC.W    $2ABC,$6C00,$0003   ; $001F4C MOVE.L  #$6C000003,(A5)
        DC.W    $3CB8,$8000         ; $001F52 MOVE.W  $8000.W,(A6)
        DC.W    $3CB8,$8002         ; $001F56 MOVE.W  $8002.W,(A6)
        DC.W    $2ABC,$4000,$0010   ; $001F5A MOVE.L  #$40000010,(A5)
        DC.W    $3CB8,$C880         ; $001F60 MOVE.W  $C880.W,(A6)
        DC.W    $3CB8,$C882         ; $001F64 MOVE.W  $C882.W,(A6)
        DC.W    $33FC,$0100,$00A1,$1100; $001F68 MOVE.W  #$0100,$00A11100
loc_001F70:
        DC.W    $0839,$0000,$00A1,$1100; $001F70 BTST    #0,$00A11100
        DC.W    $66F6               ; $001F78 BNE.S  loc_001F70
        DC.W    $3838,$C874         ; $001F7A MOVE.W  $C874.W,D4
        DC.W    $08C4,$0004         ; $001F7E BSET    #4,D4
        DC.W    $3A84               ; $001F82 MOVE.W  D4,(A5)
        DC.W    $2ABC,$9320,$9400   ; $001F84 MOVE.L  #$93209400,(A5)
        DC.W    $2ABC,$9540,$96C2   ; $001F8A MOVE.L  #$954096C2,(A5)
        DC.W    $3ABC,$977F         ; $001F90 MOVE.W  #$977F,(A5)
        DC.W    $3ABC,$C000         ; $001F94 MOVE.W  #$C000,(A5)
        DC.W    $31FC,$0080,$C876   ; $001F98 MOVE.W  #$0080,$C876.W
        DC.W    $3AB8,$C876         ; $001F9E MOVE.W  $C876.W,(A5)
        DC.W    $3AB8,$C874         ; $001FA2 MOVE.W  $C874.W,(A5)
        DC.W    $33FC,$0000,$00A1,$1100; $001FA6 MOVE.W  #$0000,$00A11100
        DC.W    $0839,$0000,$00A1,$5123; $001FAE BTST    #0,$00A15123
        DC.W    $6756               ; $001FB6 BEQ.S  loc_00200E
        DC.W    $08B9,$0000,$00A1,$5123; $001FB8 BCLR    #0,$00A15123
        DC.W    $31FC,$0000,$C87E   ; $001FC0 MOVE.W  #$0000,$C87E.W
        DC.W    $08B9,$0007,$00A1,$5100; $001FC6 BCLR    #7,$00A15100
loc_001FCE:
        DC.W    $0839,$0007,$00A1,$518A; $001FCE BTST    #7,$00A1518A
        DC.W    $67F6               ; $001FD6 BEQ.S  loc_001FCE
        DC.W    $43F9,$00FF,$6E00   ; $001FD8 LEA     $00FF6E00,A1
        DC.W    $45F9,$00A1,$5200   ; $001FDE LEA     $00A15200,A2
        DC.W    $4EBA,$28F0         ; $001FE4 JSR     $0048D6(PC)
        DC.W    $4EBA,$28F0         ; $001FE8 JSR     $0048DA(PC)
        DC.W    $0878,$0000,$C80C   ; $001FEC BCHG    #0,$C80C.W
        DC.W    $660A               ; $001FF2 BNE.S  loc_001FFE
        DC.W    $08F9,$0000,$00A1,$518B; $001FF4 BSET    #0,$00A1518B
        DC.W    $6008               ; $001FFC BRA.S  loc_002006
loc_001FFE:
        DC.W    $08B9,$0000,$00A1,$518B; $001FFE BCLR    #0,$00A1518B
loc_002006:
        DC.W    $08F9,$0007,$00A1,$5100; $002006 BSET    #7,$00A15100
loc_00200E:
        DC.W    $4E75               ; $00200E RTS
        DC.W    $3015               ; $002010 MOVE.W  (A5),D0
        DC.W    $0839,$0000,$00A1,$5123; $002012 BTST    #0,$00A15123
        DC.W    $671C               ; $00201A BEQ.S  loc_002038
        DC.W    $08B9,$0000,$00A1,$5123; $00201C BCLR    #0,$00A15123
        DC.W    $0C38,$0018,$C8C5   ; $002024 CMPI.B  #$0018,$C8C5.W
        DC.W    $6606               ; $00202A BNE.S  loc_002032
        DC.W    $31FC,$0000,$C87E   ; $00202C MOVE.W  #$0000,$C87E.W
loc_002032:
        DC.W    $11FC,$0000,$C8C4   ; $002032 MOVE.B  #$0000,$C8C4.W
loc_002038:
        DC.W    $4E75               ; $002038 RTS
        DC.W    $48E7,$FFFE         ; $00203A MOVEM.L -(A7),D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6/A7
        DC.W    $4EB9,$008B,$0004   ; $00203E JSR     $008B0004
        DC.W    $4CDF,$7FFF         ; $002044 MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,(A7)+
        DC.W    $4E75               ; $002048 RTS
        DC.W    $7000               ; $00204A MOVEQ   #$00,D0
        DC.W    $31C0,$C8A4         ; $00204C MOVE.W  D0,$C8A4.W
        DC.W    $11C0,$C822         ; $002050 MOVE.B  D0,$C822.W
        DC.W    $11C0,$C823         ; $002054 MOVE.B  D0,$C823.W
        DC.W    $31C0,$C8A2         ; $002058 MOVE.W  D0,$C8A2.W
        DC.W    $4E75               ; $00205C RTS
        DC.W    $11FC,$00F0,$C822   ; $00205E MOVE.B  #$00F0,$C822.W
        DC.W    $4E75               ; $002064 RTS
        DC.W    $11FC,$0003,$8506   ; $002066 MOVE.B  #$0003,$8506.W
        DC.W    $11FC,$0030,$8504   ; $00206C MOVE.B  #$0030,$8504.W
        DC.W    $7000               ; $002072 MOVEQ   #$00,D0
        DC.W    $11C0,$C822         ; $002074 MOVE.B  D0,$C822.W
        DC.W    $21C0,$C8A4         ; $002078 MOVE.L  D0,$C8A4.W
        DC.W    $4E75               ; $00207C RTS
        DC.W    $4E75               ; $00207E RTS
        DC.W    $1038,$C822         ; $002080 MOVE.B  $C822.W,D0
        DC.W    $6710               ; $002084 BEQ.S  loc_002096
        DC.W    $11C0,$8509         ; $002086 MOVE.B  D0,$8509.W
        DC.W    $7000               ; $00208A MOVEQ   #$00,D0
        DC.W    $11C0,$C822         ; $00208C MOVE.B  D0,$C822.W
        DC.W    $21C0,$C8A4         ; $002090 MOVE.L  D0,$C8A4.W
        DC.W    $6030               ; $002094 BRA.S  loc_0020C6
loc_002096:
        DC.W    $1038,$C8A5         ; $002096 MOVE.B  $C8A5.W,D0
        DC.W    $6716               ; $00209A BEQ.S  loc_0020B2
        DC.W    $B038,$C8A7         ; $00209C CMP.B  $C8A7.W,D0
        DC.W    $6708               ; $0020A0 BEQ.S  loc_0020AA
        DC.W    $11C0,$850A         ; $0020A2 MOVE.B  D0,$850A.W
        DC.W    $11C0,$C8A7         ; $0020A6 MOVE.B  D0,$C8A7.W
loc_0020AA:
        DC.W    $11FC,$0000,$C8A5   ; $0020AA MOVE.B  #$0000,$C8A5.W
        DC.W    $6014               ; $0020B0 BRA.S  loc_0020C6
loc_0020B2:
        DC.W    $1038,$C8A4         ; $0020B2 MOVE.B  $C8A4.W,D0
        DC.W    $670E               ; $0020B6 BEQ.S  loc_0020C6
        DC.W    $11C0,$850A         ; $0020B8 MOVE.B  D0,$850A.W
        DC.W    $11C0,$C8A6         ; $0020BC MOVE.B  D0,$C8A6.W
        DC.W    $11FC,$0000,$C8A4   ; $0020C0 MOVE.B  #$0000,$C8A4.W
loc_0020C6:
        DC.W    $48E7,$0006         ; $0020C6 MOVEM.L -(A7),D1/D2
        DC.W    $4EB9,$008B,$0000   ; $0020CA JSR     $008B0000
        DC.W    $4CDF,$6000         ; $0020D0 MOVEM.L A5/A6,(A7)+
        DC.W    $4E75               ; $0020D4 RTS
        DC.W    $4A38,$850A         ; $0020D6 TST.B  $850A.W
        DC.W    $661C               ; $0020DA BNE.S  loc_0020F8
        DC.W    $0838,$0005,$C30E   ; $0020DC BTST    #5,$C30E.W
        DC.W    $6614               ; $0020E2 BNE.S  loc_0020F8
        DC.W    $11F8,$C8A4,$850A   ; $0020E4 MOVE.B  $C8A4.W,$850A.W
        DC.W    $670C               ; $0020EA BEQ.S  loc_0020F8
        DC.W    $11F8,$C8A4,$C8A6   ; $0020EC MOVE.B  $C8A4.W,$C8A6.W
        DC.W    $11FC,$0000,$C8A4   ; $0020F2 MOVE.B  #$0000,$C8A4.W
loc_0020F8:
        DC.W    $48E7,$0006         ; $0020F8 MOVEM.L -(A7),D1/D2
        DC.W    $4EB9,$008B,$0000   ; $0020FC JSR     $008B0000
        DC.W    $4CDF,$6000         ; $002102 MOVEM.L A5/A6,(A7)+
        DC.W    $4EFA,$0226         ; $002106 JMP     $00232E(PC)
        DC.W    $4A38,$850A         ; $00210A TST.B  $850A.W
        DC.W    $660C               ; $00210E BNE.S  loc_00211C
        DC.W    $11F8,$C8A5,$850A   ; $002110 MOVE.B  $C8A5.W,$850A.W
        DC.W    $11FC,$0000,$C8A5   ; $002116 MOVE.B  #$0000,$C8A5.W
loc_00211C:
        DC.W    $48E7,$0006         ; $00211C MOVEM.L -(A7),D1/D2
        DC.W    $4EB9,$008B,$0000   ; $002120 JSR     $008B0000
        DC.W    $4CDF,$6000         ; $002126 MOVEM.L A5/A6,(A7)+
        DC.W    $4EFA,$0202         ; $00212A JMP     $00232E(PC)
        DC.W    $1038,$C822         ; $00212E MOVE.B  $C822.W,D0
        DC.W    $670E               ; $002132 BEQ.S  loc_002142
        DC.W    $11C0,$8509         ; $002134 MOVE.B  D0,$8509.W
        DC.W    $7000               ; $002138 MOVEQ   #$00,D0
        DC.W    $11C0,$C822         ; $00213A MOVE.B  D0,$C822.W
        DC.W    $21C0,$C8A4         ; $00213E MOVE.L  D0,$C8A4.W
loc_002142:
        DC.W    $48E7,$0006         ; $002142 MOVEM.L -(A7),D1/D2
        DC.W    $4EB9,$008B,$0000   ; $002146 JSR     $008B0000
        DC.W    $4CDF,$6000         ; $00214C MOVEM.L A5/A6,(A7)+
        DC.W    $4EFA,$01DC         ; $002150 JMP     $00232E(PC)
        DC.W    $4A38,$850A         ; $002154 TST.B  $850A.W
        DC.W    $6614               ; $002158 BNE.S  loc_00216E
        DC.W    $11F8,$C8A4,$850A   ; $00215A MOVE.B  $C8A4.W,$850A.W
        DC.W    $670C               ; $002160 BEQ.S  loc_00216E
        DC.W    $11F8,$C8A4,$C8A6   ; $002162 MOVE.B  $C8A4.W,$C8A6.W
        DC.W    $11FC,$0000,$C8A4   ; $002168 MOVE.B  #$0000,$C8A4.W
loc_00216E:
        DC.W    $48E7,$0006         ; $00216E MOVEM.L -(A7),D1/D2
        DC.W    $4EB9,$008B,$0000   ; $002172 JSR     $008B0000
        DC.W    $4CDF,$6000         ; $002178 MOVEM.L A5/A6,(A7)+
        DC.W    $4EFA,$008E         ; $00217C JMP     $00220C(PC)
        DC.W    $4A38,$850A         ; $002180 TST.B  $850A.W
        DC.W    $660C               ; $002184 BNE.S  loc_002192
        DC.W    $11F8,$C8A5,$850A   ; $002186 MOVE.B  $C8A5.W,$850A.W
        DC.W    $11FC,$0000,$C8A5   ; $00218C MOVE.B  #$0000,$C8A5.W
loc_002192:
        DC.W    $48E7,$0006         ; $002192 MOVEM.L -(A7),D1/D2
        DC.W    $4EB9,$008B,$0000   ; $002196 JSR     $008B0000
        DC.W    $4CDF,$6000         ; $00219C MOVEM.L A5/A6,(A7)+
        DC.W    $4EFA,$006A         ; $0021A0 JMP     $00220C(PC)
        DC.W    $1038,$C822         ; $0021A4 MOVE.B  $C822.W,D0
        DC.W    $670E               ; $0021A8 BEQ.S  loc_0021B8
        DC.W    $11C0,$8509         ; $0021AA MOVE.B  D0,$8509.W
        DC.W    $7000               ; $0021AE MOVEQ   #$00,D0
        DC.W    $11C0,$C822         ; $0021B0 MOVE.B  D0,$C822.W
        DC.W    $21C0,$C8A4         ; $0021B4 MOVE.L  D0,$C8A4.W
loc_0021B8:
        DC.W    $48E7,$0006         ; $0021B8 MOVEM.L -(A7),D1/D2
        DC.W    $4EB9,$008B,$0000   ; $0021BC JSR     $008B0000
        DC.W    $4CDF,$6000         ; $0021C2 MOVEM.L A5/A6,(A7)+
        DC.W    $4EFA,$0044         ; $0021C6 JMP     $00220C(PC)
        DC.W    $1038,$C822         ; $0021CA MOVE.B  $C822.W,D0
        DC.W    $670E               ; $0021CE BEQ.S  loc_0021DE
        DC.W    $11C0,$8509         ; $0021D0 MOVE.B  D0,$8509.W
        DC.W    $7000               ; $0021D4 MOVEQ   #$00,D0
        DC.W    $11C0,$C822         ; $0021D6 MOVE.B  D0,$C822.W
        DC.W    $21C0,$C8A4         ; $0021DA MOVE.L  D0,$C8A4.W
loc_0021DE:
        DC.W    $48E7,$0006         ; $0021DE MOVEM.L -(A7),D1/D2
        DC.W    $4EB9,$008B,$0000   ; $0021E2 JSR     $008B0000
        DC.W    $4CDF,$6000         ; $0021E8 MOVEM.L A5/A6,(A7)+
        DC.W    $4E75               ; $0021EC RTS
        DC.W    $11FC,$000A,$C827   ; $0021EE MOVE.B  #$000A,$C827.W
        DC.W    $11FC,$000F,$C828   ; $0021F4 MOVE.B  #$000F,$C828.W
        DC.W    $4A78,$C8C8         ; $0021FA TST.W  $C8C8.W
        DC.W    $6704               ; $0021FE BEQ.S  $002204
