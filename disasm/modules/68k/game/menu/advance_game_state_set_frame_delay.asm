; ============================================================================
; Advance Game State + Set Frame Delay
; ROM Range: $0111A4-$0111B6 (18 bytes)
; ============================================================================
; Calls a sub-routine at $011B08, then advances the main game state
; by 4 and sets the frame delay parameter to $0018 (24 frames).
;
; Memory:
;   $FFFFC87E = main game state (word, incremented by 4)
;   $00FF0008 = display mode / frame delay (word, set to $0018)
; Entry: none | Exit: state advanced | Uses: none
; ============================================================================

advance_game_state_set_frame_delay:
        jsr     name_entry_ui_tile_refresh(pc); $4EBA $0962
        addq.w  #4,($FFFFC87E).w               ; $0111A8: $5878 $C87E — advance game state
        move.w  #$0018,$00FF0008                ; $0111AC: $33FC $0018 $00FF $0008 — 24 frame delay
        rts                                     ; $0111B4: $4E75
