; ============================================================================
; Virtua Racing Deluxe - Main Loop   Vint_Handler
; Module: 68k/main-loop/vint_handler.asm
; Address: $001684-$0017ED (362 bytes)
; ============================================================================
;
; TODO: Add function annotations and documentation
;
; ============================================================================

        org     $001684

vint_handler:
        DC.W    $4A78,$C87A,$6726,$46FC,$2700,$48E7,$FFFE,$3038  ; $001684 TST.W  $4A78.W ; BEQ     $000016B0 ; MOVE.W  #$46FC,SR ; MOVEM.L D0/D1/D2/D5/D6/D7/A3/A6,-(A7) ; MOVE.W  $3038.W,D0
        DC.W    $C87A,$31FC,$0000,$C87A,$227B,$0014,$4E91,$52B8  ; $001694 AND.W  <EA:3A>,D4 ; MOVE.W  #$31FC,$0000.W ; MOVEA.L <EA:3B>,A1 ; BTST    #20,(A4) ; SUBQ.L  #1,$52B8.W
        DC.W    $C964,$4CDF,$7FFF,$46FC,$2300,$4E73,$4E73,$0088  ; $0016A4 AND.W  D4,-(A4) ; MOVEM.L D0/D1/D2/D3/D4/D6/D7/A2/A3/A6,(A7)+ ; MOVE.W  #$46FC,SR ; RTE ; RTE ; BCLR    #136,A0
        DC.W    $19FE,$0088,$19FE,$0088,$19FE,$0001,$8200,$0088  ; $0016B4 MOVE.B  <EA:3E>,#$19FE ; MOVE.B  <EA:3E>,#$19FE ; MOVE.B  <EA:3E>,#$19FE ; OR.B  D0,D1 ; BCLR    #136,A0
        DC.W    $1A6E,$0088,$1A72,$0088,$1C66,$0088,$1ACA,$0088  ; $0016C4 MOVE.B  $1A6E(A6),A5 ; MOVE.B  <EA:32>,A5 ; BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0
        DC.W    $19FE,$0088,$1E42,$0088,$1B14,$0088,$1A64,$0088  ; $0016D4 MOVE.B  <EA:3E>,#$19FE ; MOVE.B  D2,A7 ; BCLR    #136,A0 ; BCLR    #136,A0 ; BCLR    #136,A0
        DC.W    $1BA8,$0088,$1E94,$0088,$1F4A,$0088,$2010,$0000  ; $0016E4 MOVE.B  $1BA8(A0),<EA:35> ; MOVE.B  (A4),(A7) ; BCLR    #136,A0 ; BCLR    #136,A0 ; BTST    #0,D0
        DC.W    $0001,$0088,$1DBE,$0000,$0001,$0000,$0001,$0000  ; $0016F4 BTST    #1,D1 ; MOVE.B  <EA:3E>,<EA:36> ; BTST    #0,D0 ; BTST    #0,D0 ; BTST    #0,D0
        DC.W    $0001,$0088,$1D0C,$4E73,$11FC,$0000,$FE92,$11FC  ; $001704 BTST    #1,D1 ; MOVE.B  A4,-(A6) ; RTE ; MOVE.B  #$11FC,$0000.W ; DC.W $11FC
        DC.W    $0000,$FE93,$43F8,$FE82,$12FC,$0004,$12FC,$0006  ; $001714 BTST    #0,D0 ; DC.W    $43F8  ; Unknown ; DC.W    $FE82  ; Unknown ; MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+
        DC.W    $12FC,$0001,$12FC,$0000,$12FC,$0005,$12FC,$000A  ; $001724 MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+
        DC.W    $12FC,$0009,$12FC,$0008,$12FC,$0004,$12FC,$0006  ; $001734 MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+
        DC.W    $12FC,$0001,$12FC,$0000,$12FC,$0005,$12FC,$000A  ; $001744 MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12FC,(A1)+
        DC.W    $12FC,$0009,$12BC,$0008,$43F8,$FE94,$47FA,$0034  ; $001754 MOVE.B  #$12FC,(A1)+ ; MOVE.B  #$12BC,(A1) ; DC.W    $43F8  ; Unknown ; DC.W    $FE94  ; Unknown ; LEA     $00005F5C(PC),A3
        DC.W    $0838,$0000,$C818,$6604,$47FA,$0020,$4EBA,$0012  ; $001764 BTST    #56,$0000.W ; BNE     $00001770 ; LEA     $00005F68(PC),A3 ; JSR     $0000662C(PC)
        DC.W    $47FA,$0020,$0838,$0001,$C818,$6604,$47FA,$000C  ; $001774 LEA     $00005F70(PC),A3 ; BTST    #56,$0001.W ; BNE     $00001784 ; LEA     $00005F7C(PC),A3
        DC.W    $7E07,$12DB,$51CF,$FFFC,$4E75,$0406,$0100,$0500  ; $001784 MOVEQ   #$07,D7 ; MOVE.B  (A3)+,(A1)+ ; DBRA    D7,$00006959 ; RTS ; BTST    #6,D6 ; BTST    D2,D0
        DC.W    $0000,$0406,$0100,$050A,$0908,$0C38,$000D,$C810  ; $001794 BTST    #0,D0 ; BTST    D0,D0 ; BTST    D2,A2 ; BTST    D4,A0 ; CMPI.B  #$C38,$000D.W
        DC.W    $6630,$41F8,$C86C,$23D0,$00FF,$60D0,$43F9,$00A1  ; $0017A4 BNE     $000017D6 ; DC.W    $41F8  ; Unknown ; AND.W  $C86C(A4),D4 ; BSET    #255,<EA:3F> ; LEA     $43F900A1,A1
        DC.W    $0003,$45F8,$C970,$47F8,$FE82,$4EBA,$009E,$4EBA  ; $0017B4 BTST    #3,D3 ; AND.W  D4,<EA:30> ; DC.W    $47F8  ; Unknown ; DC.W    $FE82  ; Unknown ; JSR     $0000667A(PC) ; JSR     $0000667E(PC)
        DC.W    $002A,$0C38,$000D,$C811,$6716,$11FC,$0000,$C86E  ; $0017C4 BTST    #42,$0C38(A2) ; AND.B  (A1),D4 ; BEQ     $000017E4 ; MOVE.B  #$11FC,$0000.W
        DC.W    $4E75,$11FC,$0000,$C86C,$11FC,$0000,$C86E,$4E75  ; $0017D4 RTS ; MOVE.B  #$11FC,$0000.W ; MOVE.B  #$11FC,$0000.W ; RTS
        DC.W    $43F9,$00A1,$0005,$4EBA,$0072  ; $0017E4 LEA     $43F900A1,A1 ; JSR     $000066A6(PC)

; ============================================================================
; End of Main Loop   Vint_Handler
; ============================================================================
