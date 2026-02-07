; ============================================================================
; Ai Menu Substate 035 (auto-analyzed)
; ROM Range: $00BCCA-$00BCDA (16 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   RAM: $C8AA (scene_state), $C084 (menu_substate)
;
; RAM:
;   $C084: menu_substate
;   $C8AA: scene_state
; Confidence: high
; ============================================================================

fn_a200_035:
        CLR.W  (-14166).W                       ; $00BCCA
        CLR.W  (-16252).W                       ; $00BCCE
        MOVE.W  #$001C,(-16262).W               ; $00BCD2
        RTS                                     ; $00BCD8
