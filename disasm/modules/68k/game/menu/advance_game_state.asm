; ============================================================================
; Advance Game State
; ROM Range: $0143FA-$014400 (6 bytes)
; ============================================================================
; Advances the main game state machine by one step (4 = one state entry).
;
; Memory: $FFFFC87E = main game state index (word)
; Entry: none | Exit: state advanced | Uses: none
; ============================================================================

advance_game_state:
        addq.w  #4,($FFFFC87E).w               ; $0143FA: $5878 $C87E — advance game state
        rts                                     ; $0143FE: $4E75
