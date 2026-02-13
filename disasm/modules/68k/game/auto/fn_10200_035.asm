; ============================================================================
; Name Entry Check 035 (auto-analyzed)
; ROM Range: $01199A-$0119B8 (30 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Calls: name_entry_check
;
; Uses: D0, D1, A0
; Calls:
;   $011A98: name_entry_check
; Confidence: low
; ============================================================================

fn_10200_035:
        LSL.W  #6,D1                            ; $01199A
        MOVE.W  D1,D0                           ; $01199C
        LSL.W  #1,D1                            ; $01199E
        DC.W    $D240                           ; $0119A0
        MOVEA.L #$0601DF00,A0                   ; $0119A2
        ADDA.W  D1,A0                           ; $0119A8
        MOVE.W  #$000C,D0                       ; $0119AA
        MOVE.W  #$0010,D1                       ; $0119AE
        DC.W    $4EBA,$00E4         ; JSR     $011A98(PC); $0119B2
        RTS                                     ; $0119B6
