; ============================================================================
; Sh2 Comm Send Cmd 019 (auto-analyzed)
; ROM Range: $0125EC-$01260A (30 bytes)
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

fn_12200_019:
        LSL.W  #6,D1                            ; $0125EC
        MOVE.W  D1,D0                           ; $0125EE
        LSL.W  #1,D1                            ; $0125F0
        DC.W    $D240                           ; $0125F2
        MOVEA.L #$0601F000,A0                   ; $0125F4
        ADDA.W  D1,A0                           ; $0125FA
        MOVE.W  #$000C,D0                       ; $0125FC
        MOVE.W  #$0010,D1                       ; $012600
        DC.W    $4EBA,$BD54         ; JSR     $00E35A(PC); $012604
        RTS                                     ; $012608
