; ============================================================================
; Logic Animation Update 020 (auto-analyzed)
; ROM Range: $005348-$00535E (22 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   RAM: $C87E (game_state)
;   Calls: animation_update
;
; RAM:
;   $C87E: game_state
; Calls:
;   $00B09E: animation_update
; Confidence: medium
; ============================================================================

fn_4200_020:
        DC.W    $4EBA,$CDC0         ; JSR     $00210A(PC); $005348
        DC.W    $4EBA,$5D50         ; JSR     $00B09E(PC); $00534C
        ADDQ.W  #4,(-14210).W                   ; $005350
        MOVE.W  #$0010,$00FF0008                ; $005354
        RTS                                     ; $00535C
