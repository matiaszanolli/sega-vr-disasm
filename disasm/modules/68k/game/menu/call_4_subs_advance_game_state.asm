; ============================================================================
; Call 4 Subs + Advance Game State
; ROM Range: $005658-$005676 (30 bytes)
; ============================================================================
; Calls SFX queue process ($0021CA), two game subs ($00B02C,
; $00B632), and sprite_update_check ($005908). Advances game
; state dispatch ($C87E) by 4 and sets display mode to $0010.
;
; Memory:
;   $FFFFC87E = game state dispatch (word, advanced by 4)
;   $00FF0008 = SH2 display mode/frame delay (word, set to $0010)
; Entry: none | Exit: game state advanced | Uses: none
; ============================================================================

call_4_subs_advance_game_state:
        jsr     sound_update_disp+244(pc); $4EBA $CB70
        jsr     speed_scale_simple(pc)  ; $4EBA $59CE
        jsr     lap_value_store_1(pc)   ; $4EBA $5FD0
        jsr     sh2_comm_check_cond_guard(pc); $4EBA $02A2
        addq.w  #4,($FFFFC87E).w               ; $005668: $5878 $C87E — advance game state
        move.w  #$0010,$00FF0008                ; $00566C: $33FC $0010 $00FF $0008 — set display mode
        rts                                     ; $005674: $4E75

