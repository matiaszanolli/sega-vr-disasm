; ============================================================================
; Frame Orchestrator (9 Subroutines + Controller Tail-Jump)
; ROM Range: $00535E-$0053B0 (82 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points:
;   Entry 1 ($00535E): Full frame — calls 9 subroutines (init, controllers,
;     animation, 2 updates, 2 setups, sprite+object). Increments
;     scene_state ($C8AA), advances state_dispatch_idx ($C87E) by 4,
;     writes $54 to SH2 COMM, tail-jumps to controller check ($0056F8).
;   Entry 2 ($005396): Reduced frame — calls init, controllers,
;     animation, increments scene counter ($C886), writes $54 to SH2 COMM.
;
; Uses: D0, D2, A0, A1, A2, A6
; RAM:
;   $C886: scene counter (byte, +1)
;   $C87E: state_dispatch_idx (word, +4)
;   $C8AA: scene_state (word, +1)
; Calls:
;   $00179E: poll_controllers
;   $0020D6: init handler (from $00212E)
;   $00212E: frame init
;   $006840: sprite_handler
;   $00B02C: frame_update (from $00B11A)
;   $00B09E: animation_update
;   $00B11A: update_A
;   $00B504: setup_A
;   $00B5A4: setup_B
;   $00B684: object_update
;   $00B6DA: sprite_update
; ============================================================================

frame_orch_00535e:
; --- entry 1: full frame orchestrator ---
        jsr     sound_update_disp+88(pc); $4EBA $CDCE
        jsr     controller_read_button_remap+16(pc); $4EBA $C43A
        jsr     cascaded_frame_counter+10(pc); $4EBA $5D36
        jsr     ai_buffer_setup(pc)     ; $4EBA $5DAE
        jsr     display_digit_extract+58(pc); $4EBA $6194
        jsr     ai_data_load_cond_return_on_flag+12(pc); $4EBA $6230
        addq.w  #1,($FFFFC8AA).w               ; $005376  scene_state++
        jsr     entity_render_pipeline_with_2_player_dispatch+198(pc); $4EBA $14C4
        jsr     animated_seq_player+10(pc); $4EBA $635A
        jsr     object_update(pc)       ; $4EBA $6300
        addq.w  #4,($FFFFC87E).w               ; $005386  advance state_dispatch
        move.w  #$0054,$00FF0008               ; $00538A  SH2 COMM = $54
        jmp     pause_menu_handler_ctrl_check+20(pc); $4EFA $0364
; --- entry 2: reduced frame ---
        jsr     sound_update_disp+88(pc); $4EBA $CD96
        jsr     controller_read_button_remap+16(pc); $4EBA $C402
        jsr     cascaded_frame_counter+10(pc); $4EBA $5CFE
        addq.b  #1,($FFFFC886).w               ; $0053A2  scene counter++
        move.w  #$0054,$00FF0008               ; $0053A6  SH2 COMM = $54
        rts                                     ; $0053AE
