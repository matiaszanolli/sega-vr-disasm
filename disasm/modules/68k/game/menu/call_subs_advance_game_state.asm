; ============================================================================
; Call Subs + Advance Game State
; ROM Range: $004D00-$004D1A (26 bytes)
; ============================================================================
; Calls three subroutines: $00210A, animation_update ($00B09E),
; and sprite_update_check ($005908). Advances game state dispatch
; ($C87E) by 4 and sets display mode/frame delay to $0010.
;
; Memory:
;   $FFFFC87E = game state dispatch (word, advanced by 4)
;   $00FF0008 = SH2 display mode/frame delay (word, set to $0010)
; Entry: none | Exit: game state advanced | Uses: none
; ============================================================================

call_subs_advance_game_state:
        jsr     sound_update_disp+52(pc); $4EBA $D408
        jsr     cascaded_frame_counter+10(pc); $4EBA $6398
        jsr     sh2_comm_check_cond_guard(pc); $4EBA $0BFE
        addq.w  #4,($FFFFC87E).w               ; $004D0C: $5878 $C87E — advance game state
        move.w  #$0010,$00FF0008                ; $004D10: $33FC $0010 $00FF $0008 — set display mode
        rts                                     ; $004D18: $4E75

