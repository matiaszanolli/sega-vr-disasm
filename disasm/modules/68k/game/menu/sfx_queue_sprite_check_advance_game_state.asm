; ============================================================================
; SFX Queue + Sprite Check + Advance Game State
; ROM Range: $0055BA-$0055D0 (22 bytes)
; ============================================================================
; Calls sfx_queue_process ($0021CA) and sprite_update_check ($005908),
; then advances the main game state by 4 and sets frame delay to $0010.
;
; Memory:
;   $FFFFC87E = main game state (word, incremented by 4)
;   $00FF0008 = display mode / frame delay (word, set to $0010)
; Entry: none | Exit: state advanced | Uses: none
; ============================================================================

sfx_queue_sprite_check_advance_game_state:
        jsr     sound_update_disp+244(pc); $4EBA $CC0E
        jsr     sh2_comm_check_cond_guard(pc); $4EBA $0348
        addq.w  #4,($FFFFC87E).w               ; $0055C2: $5878 $C87E — advance game state
        move.w  #$0010,$00FF0008                ; $0055C6: $33FC $0010 $00FF $0008 — 16 frame delay
        rts                                     ; $0055CE: $4E75
