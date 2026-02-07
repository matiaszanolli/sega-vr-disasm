; ============================================================================
; Fn 30200 003
; ROM Range: $03029E-$0302EE (80 bytes)
; Source: code_30200
; ============================================================================

fn_30200_003:
        TST.B  $000A(A5)                        ; $03029E
        BEQ.W  .loc_004E                        ; $0302A2
        BTST    #1,(A5)                         ; $0302A6
        BNE.W  .loc_004E                        ; $0302AA
        BTST    #2,(A5)                         ; $0302AE
        BNE.W  .loc_004E                        ; $0302B2
        DC.W    $4EBA,$0036         ; JSR     $0302EE(PC); $0302B6
        TST.B  $000F(A6)                        ; $0302BA
        BEQ.S  .loc_002C                        ; $0302BE
        CMPI.B  #$02,$0001(A5)                  ; $0302C0
        DC.W    $6700,$00C6         ; BEQ.W  $03038E; $0302C6
.loc_002C:
        MOVE.W  D6,D1                           ; $0302CA
        LSR.W  #8,D1                            ; $0302CC
        MOVE.B  #$A4,D0                         ; $0302CE
        DC.W    $4EBA,$0A48         ; JSR     $030D1C(PC); $0302D2
        DC.W    $4EBA,$09F4         ; JSR     $030CCC(PC); $0302D6
        MOVE.B  D6,D1                           ; $0302DA
        MOVE.B  #$A0,D0                         ; $0302DC
        DC.W    $4EBA,$09EA         ; JSR     $030CCC(PC); $0302E0
        MOVE.W  #$0000,$00A11100                ; $0302E4
.loc_004E:
        RTS                                     ; $0302EC
