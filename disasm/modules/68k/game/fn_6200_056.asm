; ============================================================================
; Fn 6200 056
; ROM Range: $007D82-$007E0C (138 bytes)
; Source: code_6200
; ============================================================================

fn_6200_056:
        CMPI.W  #$0001,(-14180).W               ; $007D82
        BNE.S  .loc_0012                        ; $007D88
        BTST    #2,$00E5(A0)                    ; $007D8A
        DC.W    $6600,$009E         ; BNE.W  $007E30; $007D90
.loc_0012:
        TST.W  (-16308).W                       ; $007D94
        BEQ.S  .loc_0024                        ; $007D98
        MOVE.W  #$0001,(-16380).W               ; $007D9A
        MOVE.W  #$0001,(-16312).W               ; $007DA0
.loc_0024:
        MOVE.W  $0024(A0),D0                    ; $007DA6
        ADDQ.W  #2,D0                           ; $007DAA
        TST.B  (-15598).W                       ; $007DAC
        BEQ.S  .loc_0032                        ; $007DB0
        SUBQ.W  #4,D0                           ; $007DB2
.loc_0032:
        DC.W    $43FA,$00BE         ; LEA     $007E74(PC),A1; $007DB4
        MOVE.W  (-14180).W,D6                   ; $007DB8
        MOVE.B  $00(A1,D6.W),D6                 ; $007DBC
        LSL.W  D6,D0                            ; $007DC0
        MOVE.B  $00E5(A0),D1                    ; $007DC2
        ANDI.B  #$06,D1                         ; $007DC6
        BEQ.S  .loc_004C                        ; $007DCA
        ADDQ.W  #1,D0                           ; $007DCC
.loc_004C:
        MOVEA.L (-14584).W,A1                   ; $007DCE
        MOVE.B  $00(A1,D0.W),D0                 ; $007DD2
        ANDI.W  #$00FF,D0                       ; $007DD6
        MOVEQ   #$28,D1                         ; $007DDA
        MOVE.W  D1,$008C(A0)                    ; $007DDC
        MOVE.W  D1,$0014(A0)                    ; $007DE0
        MOVE.W  (-16230).W,(-16262).W           ; $007DE4
        DC.W    $4EBA,$00CC         ; JSR     $007EB8(PC); $007DEA
        TST.B  (-14298).W                       ; $007DEE
        BEQ.S  .loc_0082                        ; $007DF2
        CMPI.W  #$000F,$008A(A0)                ; $007DF4
        BGE.S  .loc_0082                        ; $007DFA
        ADDQ.W  #1,$008A(A0)                    ; $007DFC
        DC.W    $4EBA,$23FA         ; JSR     $00A1FC(PC); $007E00
.loc_0082:
        MOVE.B  #$B0,(-14172).W                 ; $007E04
        RTS                                     ; $007E0A
