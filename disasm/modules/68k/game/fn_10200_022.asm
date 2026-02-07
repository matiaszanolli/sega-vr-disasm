; ============================================================================
; Name Entry Game 022 (auto-analyzed)
; ROM Range: $0111A4-$0111B6 (18 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   RAM: $C87E (game_state)
;
; RAM:
;   $C87E: game_state
; Confidence: medium
; ============================================================================

fn_10200_022:
        DC.W    $4EBA,$0962         ; JSR     $011B08(PC); $0111A4
        ADDQ.W  #4,(-14210).W                   ; $0111A8
        MOVE.W  #$0018,$00FF0008                ; $0111AC
        RTS                                     ; $0111B4
