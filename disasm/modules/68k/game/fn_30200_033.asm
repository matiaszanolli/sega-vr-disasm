; ============================================================================
; Fn 30200 033
; ROM Range: $030ECE-$030F0E (64 bytes)
; Source: code_30200
; ============================================================================

fn_30200_033:
        TST.B  $000A(A5)                        ; $030ECE
        BEQ.S  .loc_003E                        ; $030ED2
        BTST    #1,(A5)                         ; $030ED4
        BNE.S  .loc_003E                        ; $030ED8
        BTST    #2,(A5)                         ; $030EDA
        BNE.S  .loc_003E                        ; $030EDE
        DC.W    $4EBA,$F40C         ; JSR     $0302EE(PC); $030EE0
        MOVE.B  $0001(A5),D0                    ; $030EE4
        CMPI.B  #$E0,D0                         ; $030EE8
        BNE.S  .loc_0024                        ; $030EEC
        MOVE.B  #$C0,D0                         ; $030EEE
.loc_0024:
        MOVE.W  D6,D1                           ; $030EF2
        ANDI.B  #$0F,D1                         ; $030EF4
        DC.W    $8001                           ; $030EF8
        LSR.W  #4,D6                            ; $030EFA
        ANDI.B  #$3F,D6                         ; $030EFC
        MOVE.B  D0,$00C00011                    ; $030F00
        MOVE.B  D6,$00C00011                    ; $030F06
.loc_003E:
        RTS                                     ; $030F0C
