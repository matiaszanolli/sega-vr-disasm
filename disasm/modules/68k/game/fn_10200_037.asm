; ============================================================================
; Sh2 Comm Send Cmd 037 (auto-analyzed)
; ROM Range: $011C7E-$011D0A (140 bytes)
; ============================================================================
; Category: sh2
; Purpose: Calls: sh2_send_cmd
;
; Uses: D0, D1, A0, A1
; Calls:
;   $00E35A: sh2_send_cmd
; Confidence: medium
; ============================================================================

fn_10200_037:
        TST.W  (-24498).W                       ; $011C7E
        BNE.S  .loc_0046                        ; $011C82
        BTST    #0,(-24496).W                   ; $011C84
        BNE.S  .loc_002A                        ; $011C8A
        MOVEA.L #$06018F80,A0                   ; $011C8C
        MOVEA.L #$0400D018,A1                   ; $011C92
        MOVE.W  #$0078,D0                       ; $011C98
        MOVE.W  #$0018,D1                       ; $011C9C
        DC.W    $4EBA,$C6B8         ; JSR     $00E35A(PC); $011CA0
        BRA.W  .loc_008A                        ; $011CA4
.loc_002A:
        MOVEA.L #$06010000,A0                   ; $011CA8
        MOVEA.L #$0400D018,A1                   ; $011CAE
        MOVE.W  #$0078,D0                       ; $011CB4
        MOVE.W  #$0018,D1                       ; $011CB8
        DC.W    $4EBA,$C69C         ; JSR     $00E35A(PC); $011CBC
        BRA.W  .loc_008A                        ; $011CC0
.loc_0046:
        CMPI.W  #$0002,(-24498).W               ; $011CC4
        BEQ.S  .loc_008A                        ; $011CCA
        BTST    #0,(-24496).W                   ; $011CCC
        BNE.S  .loc_0072                        ; $011CD2
        MOVEA.L #$06019AC0,A0                   ; $011CD4
        MOVEA.L #$0400D0A0,A1                   ; $011CDA
        MOVE.W  #$0078,D0                       ; $011CE0
        MOVE.W  #$0018,D1                       ; $011CE4
        DC.W    $4EBA,$C670         ; JSR     $00E35A(PC); $011CE8
        BRA.W  .loc_008A                        ; $011CEC
.loc_0072:
        MOVEA.L #$06010000,A0                   ; $011CF0
        MOVEA.L #$0400D0A0,A1                   ; $011CF6
        MOVE.W  #$0078,D0                       ; $011CFC
        MOVE.W  #$0018,D1                       ; $011D00
        DC.W    $4EBA,$C654         ; JSR     $00E35A(PC); $011D04
.loc_008A:
        RTS                                     ; $011D08
