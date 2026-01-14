; Generated assembly for $001684-$0017EE
; Branch targets: 8
; Labels: 6
; Format: DC.W with decoded mnemonics as comments

        org     $001684

        DC.W    $4A78,$C87A         ; $001684 TST.W  $C87A.W
        DC.W    $6726               ; $001688 BEQ.S  loc_0016B0
        DC.W    $46FC,$2700         ; $00168A NOT    #$2700
        DC.W    $48E7,$FFFE         ; $00168E MOVEM.L -(A7),D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6/A7
        DC.W    $3038,$C87A         ; $001692 MOVE.W  $C87A.W,D0
        DC.W    $31FC,$0000,$C87A   ; $001696 MOVE.W  #$0000,$C87A.W
        DC.W    $227B,$0014         ; $00169C MOVEA.L $14(PC,D0.W),A1
        DC.W    $4E91               ; $0016A0 JSR     (A1)
        DC.W    $52B8,$C964         ; $0016A2 ADDQ.L  #1,$C964.W
        DC.W    $4CDF,$7FFF         ; $0016A6 MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,(A7)+
        DC.W    $46FC,$2300         ; $0016AA NOT    #$2300
        DC.W    $4E73               ; $0016AE RTE
loc_0016B0:
        DC.W    $4E73               ; $0016B0 RTE
        DC.W    $0088,$19FE,$0088   ; $0016B2 ORI.L  #$19FE0088,A0
        DC.W    $19FE,$0088         ; $0016B8 MOVE.B  <EA:3E>,#$0088
        DC.W    $19FE,$0001         ; $0016BC MOVE.B  <EA:3E>,#$0001
        DC.W    $8200               ; $0016C0 OR.B   D0,D1
        DC.W    $0088,$1A6E,$0088   ; $0016C2 ORI.L  #$1A6E0088,A0
        DC.W    $1A72,$0088         ; $0016C8 MOVEA.B -$78(A2,D0.W),A5
        DC.W    $1C66               ; $0016CC MOVEA.B -(A6),A6
        DC.W    $0088,$1ACA,$0088   ; $0016CE ORI.L  #$1ACA0088,A0
        DC.W    $19FE,$0088         ; $0016D4 MOVE.B  <EA:3E>,#$0088
        DC.W    $1E42               ; $0016D8 MOVEA.B D2,A7
        DC.W    $0088,$1B14,$0088   ; $0016DA ORI.L  #$1B140088,A0
        DC.W    $1A64               ; $0016E0 MOVEA.B -(A4),A5
        DC.W    $0088,$1BA8,$0088   ; $0016E2 ORI.L  #$1BA80088,A0
        DC.W    $1E94               ; $0016E8 MOVE.B  (A4),(A7)
        DC.W    $0088,$1F4A,$0088   ; $0016EA ORI.L  #$1F4A0088,A0
        DC.W    $2010               ; $0016F0 MOVE.L  (A0),D0
        DC.W    $0000,$0001         ; $0016F2 ORI.B  #$0001,D0
        DC.W    $0088,$1DBE,$0000   ; $0016F6 ORI.L  #$1DBE0000,A0
        DC.W    $0001,$0000         ; $0016FC ORI.B  #$0000,D1
        DC.W    $0001,$0000         ; $001700 ORI.B  #$0000,D1
        DC.W    $0001,$0088         ; $001704 ORI.B  #$0088,D1
        DC.W    $1D0C               ; $001708 MOVE.B  A4,-(A6)
        DC.W    $4E73               ; $00170A RTE
        DC.W    $11FC,$0000,$FE92   ; $00170C MOVE.B  #$0000,$FE92.W
        DC.W    $11FC,$0000,$FE93   ; $001712 MOVE.B  #$0000,$FE93.W
        DC.W    $43F8,$FE82         ; $001718 LEA     $FE82.W,A1
        DC.W    $12FC,$0004         ; $00171C MOVE.B  #$0004,(A1)+
        DC.W    $12FC,$0006         ; $001720 MOVE.B  #$0006,(A1)+
        DC.W    $12FC,$0001         ; $001724 MOVE.B  #$0001,(A1)+
        DC.W    $12FC,$0000         ; $001728 MOVE.B  #$0000,(A1)+
        DC.W    $12FC,$0005         ; $00172C MOVE.B  #$0005,(A1)+
        DC.W    $12FC,$000A         ; $001730 MOVE.B  #$000A,(A1)+
        DC.W    $12FC,$0009         ; $001734 MOVE.B  #$0009,(A1)+
        DC.W    $12FC,$0008         ; $001738 MOVE.B  #$0008,(A1)+
        DC.W    $12FC,$0004         ; $00173C MOVE.B  #$0004,(A1)+
        DC.W    $12FC,$0006         ; $001740 MOVE.B  #$0006,(A1)+
        DC.W    $12FC,$0001         ; $001744 MOVE.B  #$0001,(A1)+
        DC.W    $12FC,$0000         ; $001748 MOVE.B  #$0000,(A1)+
        DC.W    $12FC,$0005         ; $00174C MOVE.B  #$0005,(A1)+
        DC.W    $12FC,$000A         ; $001750 MOVE.B  #$000A,(A1)+
        DC.W    $12FC,$0009         ; $001754 MOVE.B  #$0009,(A1)+
        DC.W    $12BC,$0008         ; $001758 MOVE.B  #$0008,(A1)
        DC.W    $43F8,$FE94         ; $00175C LEA     $FE94.W,A1
        DC.W    $47FA,$0034         ; $001760 LEA     $0034(PC),A3
        DC.W    $0838,$0000,$C818   ; $001764 BTST    #0,$C818.W
        DC.W    $6604               ; $00176A BNE.S  loc_001770
        DC.W    $47FA,$0020         ; $00176C LEA     $0020(PC),A3
loc_001770:
        DC.W    $4EBA,$0012         ; $001770 JSR     loc_001784(PC)
        DC.W    $47FA,$0020         ; $001774 LEA     $0020(PC),A3
        DC.W    $0838,$0001,$C818   ; $001778 BTST    #1,$C818.W
        DC.W    $6604               ; $00177E BNE.S  loc_001784
        DC.W    $47FA,$000C         ; $001780 LEA     $000C(PC),A3
loc_001784:
        DC.W    $7E07               ; $001784 MOVEQ   #$07,D7
loc_001786:
        DC.W    $12DB               ; $001786 MOVE.B  (A3)+,(A1)+
        DC.W    $51CF,$FFFC         ; $001788 DBRA    D7,loc_001786
        DC.W    $4E75               ; $00178C RTS
        DC.W    $0406,$0100         ; $00178E SUBI.B  #$0100,D6
        DC.W    $0500               ; $001792 BTST    D2,D0
        DC.W    $0000,$0406         ; $001794 ORI.B  #$0406,D0
        DC.W    $0100               ; $001798 BTST    D0,D0
        DC.W    $050A               ; $00179A BTST    D2,A2
        DC.W    $0908               ; $00179C BTST    D4,A0
        DC.W    $0C38,$000D,$C810   ; $00179E CMPI.B  #$000D,$C810.W
        DC.W    $6630               ; $0017A4 BNE.S  loc_0017D6
        DC.W    $41F8,$C86C         ; $0017A6 LEA     $C86C.W,A0
        DC.W    $23D0,$00FF,$60D0   ; $0017AA MOVE.L  (A0),$00FF60D0
        DC.W    $43F9,$00A1,$0003   ; $0017B0 LEA     $00A10003,A1
        DC.W    $45F8,$C970         ; $0017B6 LEA     $C970.W,A2
        DC.W    $47F8,$FE82         ; $0017BA LEA     $FE82.W,A3
        DC.W    $4EBA,$009E         ; $0017BE JSR     $00185E(PC)
        DC.W    $4EBA,$002A         ; $0017C2 JSR     $0017EE(PC)
        DC.W    $0C38,$000D,$C811   ; $0017C6 CMPI.B  #$000D,$C811.W
        DC.W    $6716               ; $0017CC BEQ.S  loc_0017E4
        DC.W    $11FC,$0000,$C86E   ; $0017CE MOVE.B  #$0000,$C86E.W
        DC.W    $4E75               ; $0017D4 RTS
loc_0017D6:
        DC.W    $11FC,$0000,$C86C   ; $0017D6 MOVE.B  #$0000,$C86C.W
        DC.W    $11FC,$0000,$C86E   ; $0017DC MOVE.B  #$0000,$C86E.W
        DC.W    $4E75               ; $0017E2 RTS
loc_0017E4:
        DC.W    $43F9,$00A1,$0005   ; $0017E4 LEA     $00A10005,A1
        DC.W    $4EBA,$0072         ; $0017EA JSR     $00185E(PC)
