; ============================================================================
; Frame Orchestrator (12 Subroutines, 2 Entry Points)
; ROM Range: $00509E-$005100 (98 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points:
;   Entry 1 ($509E): Full orchestrator — calls 12 subroutines (init,
;     scene logic, animation, frame update, sprite processing), increments
;     scene_state, advances state_dispatch_idx by 4, writes $54 to SH2
;     COMM, tail-jumps to controller handler ($0056F8).
;   Entry 2 ($50DE): Reduced — calls 5 subroutines (init, poll_controllers,
;     animation, update), increments scene_counter, writes $54 to SH2 COMM.
;
; Uses: D0, D3, D7, A1, A2
; RAM:
;   $C87E: state_dispatch_idx (word)
;   $C886: scene_counter (byte)
;   $C8AA: scene_state (word)
; Calls:
;   $00179E: poll_controllers
;   $0021A4: init handler A
;   $006496: scene logic
;   $00B094: frame_sync
;   $00B09E: animation_update
;   $00B0DE: display_update
;   $00B4F8: sprite_sort
;   $00B504: sprite_build
;   $00B55A: sprite_commit
;   $00B590: sprite_finalize
;   $00B684: object_update
;   $00B6DA: sprite_update
; ============================================================================

frame_orch_00509e:
; --- entry 1: full orchestrator ---
        jsr     sound_update_disp+206(pc); $4EBA $D104
        jsr     gfx_2_player_entity_frame_orch(pc); $4EBA $13F2
        jsr     cascaded_frame_counter+10(pc); $4EBA $5FF6
        jsr     cascaded_frame_counter(pc); $4EBA $5FE8
        jsr     ai_timer_inc(pc)        ; $4EBA $602E
        jsr     display_digit_extract+58(pc); $4EBA $6450
        jsr     display_digit_extract+46(pc); $4EBA $6440
        jsr     hud_panel_config(pc)    ; $4EBA $649E
        jsr     conditional_return_on_disp_config_flag(pc); $4EBA $64D0
        addq.w  #1,($FFFFC8AA).w                ; $0050C2  scene_state++
        jsr     animated_seq_player+10(pc); $4EBA $6612
        jsr     object_update(pc)       ; $4EBA $65B8
        addq.w  #4,($FFFFC87E).w                ; $0050CE  advance state
        move.w  #$0054,$00FF0008                ; $0050D2  SH2 COMM = $54
        jmp     pause_menu_handler_ctrl_check+20(pc); $4EFA $061C
; --- entry 2: reduced orchestrator ---
        jsr     sound_update_disp+206(pc); $4EBA $D0C4
        jsr     controller_read_button_remap+16(pc); $4EBA $C6BA
        jsr     cascaded_frame_counter+10(pc); $4EBA $5FB6
        jsr     cascaded_frame_counter(pc); $4EBA $5FA8
        jsr     ai_timer_inc(pc)        ; $4EBA $5FEE
        addq.b  #1,($FFFFC886).w                ; $0050F2  scene_counter++
        move.w  #$0054,$00FF0008                ; $0050F6  SH2 COMM = $54
        rts                                     ; $0050FE

