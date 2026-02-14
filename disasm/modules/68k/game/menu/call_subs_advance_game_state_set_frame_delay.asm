; ============================================================================
; Call Subs + Advance Game State + Set Frame Delay
; ROM Range: $005348-$00535E (22 bytes)
; ============================================================================
; Calls two sub-routines ($00210A and animation_update at $00B09E),
; then advances the main game state by 4 and sets frame delay to $0010.
;
; Memory:
;   $FFFFC87E = main game state (word, incremented by 4)
;   $00FF0008 = display mode / frame delay (word, set to $0010)
; Entry: none | Exit: state advanced | Uses: none
; ============================================================================

call_subs_advance_game_state_set_frame_delay:
        jsr     sound_update_disp+52(pc); $4EBA $CDC0
        jsr     cascaded_frame_counter+10(pc); $4EBA $5D50
        addq.w  #4,($FFFFC87E).w               ; $005350: $5878 $C87E — advance game state
        move.w  #$0010,$00FF0008                ; $005354: $33FC $0010 $00FF $0008 — 16 frame delay
        rts                                     ; $00535C: $4E75
