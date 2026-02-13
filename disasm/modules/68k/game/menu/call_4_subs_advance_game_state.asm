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
        dc.w    $4EBA,$CB70                     ; BSR.W $0021CA ; $005658: — call SFX queue process
        dc.w    $4EBA,$59CE                     ; BSR.W $00B02C ; $00565C: — call game sub 1
        dc.w    $4EBA,$5FD0                     ; BSR.W $00B632 ; $005660: — call game sub 2
        dc.w    $4EBA,$02A2                     ; BSR.W $005908 ; $005664: — call sprite_update_check
        addq.w  #4,($FFFFC87E).w               ; $005668: $5878 $C87E — advance game state
        move.w  #$0010,$00FF0008                ; $00566C: $33FC $0010 $00FF $0008 — set display mode
        rts                                     ; $005674: $4E75

