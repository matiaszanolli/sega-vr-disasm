; ============================================================================
; Game Frame Orchestrator 013
; ROM Range: $004D1A-$004D98 (126 bytes)
; ============================================================================
; Category: object
; Purpose: Main game frame update — calls rendering + logic subroutines
;   Path A: full update (10 calls + input record + sprite/object update)
;   Path B: minimal update (4 calls + increment)
;   Records controller input to replay buffer
;
; Uses: D0, D1, A0
; RAM:
;   $C8AA: frame_counter
;   $C8C0: controller_ptr
;   $C971: input_mask
;   $C973: input_buttons
;   $C87E: game_state
;   $C886: vint_counter
; Calls:
;   $00212E: vdp_display_init (pre-frame)
;   $00179E: poll_controllers
;   $00B09E: animation_update
;   $00B144: sound_buffer_copy_with_decode
;   $00B504: display_param_calc
;   $00B4DC: ai_object_setup_cond_flag_set
;   $00B522: ai_state_dispatch
;   $00593C: sprite_state_process
;   $00B6DA: sprite_update
;   $00B684: object_update
;   $0056F8: state_disp_00573c (tail call via JMP)
; Confidence: high
; ============================================================================

game_frame_orch_013:
; --- path A: full frame update ---
        jsr     sound_update_disp+88(pc); $4EBA $D412
        jsr     controller_read_button_remap+16(pc); $4EBA $CA7E
        jsr     cascaded_frame_counter+10(pc); $4EBA $637A
        jsr     ai_buffer_setup+42(pc)  ; $4EBA $641C
        jsr     display_digit_extract+58(pc); $4EBA $67D8
        jsr     display_digit_extract+18(pc); $4EBA $67AC
        jsr     display_digit_extract+88(pc); $4EBA $67EE
        addq.w  #1,($FFFFC8AA).w                ; $004D36  frame_counter++
; --- record controller input to replay buffer ---
        movea.w ($FFFFC8C0).w,A0                ; $004D3A  A0 = controller_ptr
        cmpa.w  #$EF00,A0                       ; $004D3E  buffer full?
        beq.w   .skip_record                    ; $004D42  yes → skip
        move.b  ($FFFFC971).w,D0                ; $004D46  D0 = input_mask
        andi.b  #$5C,D0                         ; $004D4A  isolate d-pad + buttons
        move.b  ($FFFFC973).w,D1                ; $004D4E  D1 = input_buttons
        andi.b  #$03,D1                         ; $004D52  isolate A/B buttons
        or.b    d1,d0                   ; $8001
        move.b  D0,(A0)+                        ; $004D58  store to buffer, advance
        move.w  A0,($FFFFC8C0).w                ; $004D5A  update controller_ptr
.skip_record:
        jsr     race_entity_update_loop(pc); $4EBA $0BDC
        jsr     animated_seq_player+10(pc); $4EBA $6976
        jsr     object_update(pc)       ; $4EBA $691C
        addq.w  #4,($FFFFC87E).w                ; $004D6A  game_state += 4
        move.w  #$0054,$00FF0008                ; $004D6E  display list cmd = $54
        jmp     pause_menu_handler_ctrl_check+20(pc); $4EFA $0980
; --- path B: minimal update ---
        jsr     sound_update_disp+88(pc); $4EBA $D3B2
        jsr     controller_read_button_remap+16(pc); $4EBA $CA1E
        jsr     cascaded_frame_counter+10(pc); $4EBA $631A
        jsr     ai_buffer_setup+42(pc)  ; $4EBA $63BC
        addq.b  #1,($FFFFC886).w                ; $004D8A  vint_counter++
        move.w  #$0054,$00FF0008                ; $004D8E  display list cmd = $54
        rts                                     ; $004D96
