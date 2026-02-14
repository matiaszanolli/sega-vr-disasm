; ============================================================================
; Process SFX + Poll Controllers + Advance Frame
; ROM Range: $0055FE-$005618 (26 bytes)
; ============================================================================
; Calls SFX queue process ($0021CA), poll controllers ($00179E),
; and sub at $00BAD4. Increments frame counter ($C886) and sets
; SH2 display mode/frame delay to $0054.
;
; Memory:
;   $FFFFC886 = frame counter (byte, incremented by 1)
;   $00FF0008 = SH2 display mode/frame delay (word, set to $0054)
; Entry: none | Exit: controllers polled, frame advanced | Uses: none
; ============================================================================

process_sfx_poll_ctrls_advance_frame:
        jsr     sound_update_disp+244(pc); $4EBA $CBCA
        jsr     controller_read_button_remap+16(pc); $4EBA $C19A
        jsr     scene_menu_init_and_input_handler+118(pc); $4EBA $64CC
        addq.b  #1,($FFFFC886).w               ; $00560A: $5238 $C886 — increment frame counter
        move.w  #$0054,$00FF0008                ; $00560E: $33FC $0054 $00FF $0008 — set display mode
        rts                                     ; $005616: $4E75

