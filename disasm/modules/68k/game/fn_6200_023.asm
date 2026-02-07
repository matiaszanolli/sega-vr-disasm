; ============================================================================
; Fn 6200 023
; ROM Range: $006F98-$006FFA (98 bytes)
; Source: code_6200
; ============================================================================

fn_6200_023:
        TST.W  $0062(A0)                        ; $006F98
        BNE.S  .loc_003E                        ; $006F9C
        TST.W  $0092(A0)                        ; $006F9E
        BGT.S  .loc_0036                        ; $006FA2
        MOVE.W  $003C(A0),D0                    ; $006FA4
        ADD.W  $0096(A0),D0                     ; $006FA8
        MOVE.W  D0,$0040(A0)                    ; $006FAC
        NEG.W  D0                               ; $006FB0
        MOVE.W  $0006(A0),D2                    ; $006FB2
        MOVE.W  $0030(A0),D3                    ; $006FB6
        MOVE.W  $0034(A0),D4                    ; $006FBA
        DC.W    $4EBA,$001E         ; JSR     $006FDE(PC); $006FBE
        MOVE.W  D3,$0030(A0)                    ; $006FC2
        MOVE.W  D4,$0034(A0)                    ; $006FC6
        DC.W    $4EFA,$0734         ; JMP     $007700(PC); $006FCA
.loc_0036:
        DC.W    $4EBA,$002A         ; JSR     $006FFA(PC); $006FCE
        DC.W    $4EFA,$0842         ; JMP     $007816(PC); $006FD2
.loc_003E:
        DC.W    $4EBA,$0030         ; JSR     $007008(PC); $006FD6
        DC.W    $4EFA,$083A         ; JMP     $007816(PC); $006FDA
        MOVEQ   #$0C,D6                         ; $006FDE
        MOVE.W  D0,D5                           ; $006FE0
        DC.W    $4EBA,$1F6E         ; JSR     $008F52(PC); $006FE2
        MULS    D2,D0                           ; $006FE6
        ASR.L  D6,D0                            ; $006FE8
        DC.W    $D640                           ; $006FEA
        MOVE.W  D5,D0                           ; $006FEC
        DC.W    $4EBA,$1F5E         ; JSR     $008F4E(PC); $006FEE
        MULS    D2,D0                           ; $006FF2
        ASR.L  D6,D0                            ; $006FF4
        DC.W    $D840                           ; $006FF6
        RTS                                     ; $006FF8
