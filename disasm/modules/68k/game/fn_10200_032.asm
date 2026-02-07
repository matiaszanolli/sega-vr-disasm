; ============================================================================
; Sh2 Comm Send Cmd 032 (auto-analyzed)
; ROM Range: $011924-$011942 (30 bytes)
; ============================================================================
; Category: sh2
; Purpose: Short helper function
;   Calls: sh2_send_cmd
;
; Uses: D0, D1, A0
; Calls:
;   $00E35A: sh2_send_cmd
; Confidence: medium
; ============================================================================

fn_10200_032:
        LSL.W  #6,D1                            ; $011924
        MOVE.W  D1,D0                           ; $011926
        LSL.W  #1,D1                            ; $011928
        DC.W    $D240                           ; $01192A
        MOVEA.L #$0601DF00,A0                   ; $01192C
        ADDA.W  D1,A0                           ; $011932
        MOVE.W  #$000C,D0                       ; $011934
        MOVE.W  #$0010,D1                       ; $011938
        DC.W    $4EBA,$CA1C         ; JSR     $00E35A(PC); $01193C
        RTS                                     ; $011940
