; ============================================================================
; Name Entry Send Cmd 023 (auto-analyzed)
; ROM Range: $0111B6-$011240 (138 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C87E (game_state)
;   Calls: sh2_send_cmd, time_digit_render
;
; Uses: D0, D1, A0, A1, A2
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
;   $0118D4: time_digit_render
; Confidence: medium
; ============================================================================

fn_10200_023:
        MOVEA.L #$06018F80,A0                   ; $0111B6
        MOVEA.L #$0400D018,A1                   ; $0111BC
        MOVE.W  #$0078,D0                       ; $0111C2
        MOVE.W  #$0018,D1                       ; $0111C6
        DC.W    $4EBA,$D18E         ; JSR     $00E35A(PC); $0111CA
        MOVEA.L #$06019AC0,A0                   ; $0111CE
        MOVEA.L #$0400D0A0,A1                   ; $0111D4
        MOVE.W  #$0078,D0                       ; $0111DA
        MOVE.W  #$0018,D1                       ; $0111DE
        DC.W    $4EBA,$D176         ; JSR     $00E35A(PC); $0111E2
        LEA     $0403B048,A1                    ; $0111E6
        LEA     (-24506).W,A2                   ; $0111EC
        DC.W    $4EBA,$06E2         ; JSR     $0118D4(PC); $0111F0
        LEA     $0403B0D0,A1                    ; $0111F4
        LEA     (-24502).W,A2                   ; $0111FA
        DC.W    $4EBA,$06D4         ; JSR     $0118D4(PC); $0111FE
        MOVEA.L #$06018C00,A0                   ; $011202
        MOVEA.L #$0401B010,A1                   ; $011208
        MOVE.W  #$0038,D0                       ; $01120E
        MOVE.W  #$0010,D1                       ; $011212
        DC.W    $4EBA,$D142         ; JSR     $00E35A(PC); $011216
        MOVEA.L #$06018C00,A0                   ; $01121A
        MOVEA.L #$0401B098,A1                   ; $011220
        MOVE.W  #$0038,D0                       ; $011226
        MOVE.W  #$0010,D1                       ; $01122A
        DC.W    $4EBA,$D12A         ; JSR     $00E35A(PC); $01122E
        ADDQ.W  #4,(-14210).W                   ; $011232
        MOVE.W  #$0018,$00FF0008                ; $011236
        RTS                                     ; $01123E
