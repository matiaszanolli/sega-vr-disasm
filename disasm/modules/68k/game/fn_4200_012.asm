; ============================================================================
; Logic Sprite Update Check 012 (auto-analyzed)
; ROM Range: $004D00-$004D1A (26 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 3 subroutines
;   RAM: $C87E (game_state)
;   Calls: animation_update, sprite_update_check
;
; RAM:
;   $C87E: game_state
; Calls:
;   $005908: sprite_update_check
;   $00B09E: animation_update
; Confidence: medium
; ============================================================================

fn_4200_012:
        DC.W    $4EBA,$D408         ; JSR     $00210A(PC); $004D00
        DC.W    $4EBA,$6398         ; JSR     $00B09E(PC); $004D04
        DC.W    $4EBA,$0BFE         ; JSR     $005908(PC); $004D08
        ADDQ.W  #4,(-14210).W                   ; $004D0C
        MOVE.W  #$0010,$00FF0008                ; $004D10
        RTS                                     ; $004D18
