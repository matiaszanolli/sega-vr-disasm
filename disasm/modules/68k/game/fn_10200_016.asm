; ============================================================================
; Sh2 Comm Send Cmd 016 (auto-analyzed)
; ROM Range: $010656-$010674 (30 bytes)
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

fn_10200_016:
        LSL.W  #6,D1                            ; $010656
        MOVE.W  D1,D0                           ; $010658
        LSL.W  #1,D1                            ; $01065A
        DC.W    $D240                           ; $01065C
        MOVEA.L #$06023200,A0                   ; $01065E
        ADDA.W  D1,A0                           ; $010664
        MOVE.W  #$000C,D0                       ; $010666
        MOVE.W  #$0010,D1                       ; $01066A
        DC.W    $4EBA,$DCEA         ; JSR     $00E35A(PC); $01066E
        RTS                                     ; $010672
