; ============================================================================
; 2P Split-Screen Dispatcher — Experimental VR60 Sequential Execution
; ROM Range: $005020-$00509D (126 bytes, absorbs frame_update_orch_005070)
; ============================================================================
;
; BUILT BUT UNVALIDATED: this is state_disp_005020, the 2-player path—not
; normal 1P racing. It runs the historical three states' work sequentially
; every TV frame, but no trustworthy 2P profiling/behavioral acceptance run
; has established a 60 FPS result.
;
; Historical CPU-margin claims are not current evidence. The 1P cmd $3F
; trigger and physics bypass are disabled, and normal 1P is controlled by
; state_disp_004cb8.
;
; Data prefix at $005020 MUST be preserved (referenced by other code).
; Jump table at $00502E is no longer used ($C87E always 0).
;
; Entry: called from scene handler via $FF0002 JSR
; Exit: tail-jumps to pause_menu_handler_ctrl_check+20
; V-INT state: always $0054 (unified handler does VDP sync + sprite cfg + swap)
; ============================================================================

state_disp_005020:
; --- data prefix: 2-word buffer addresses (MUST stay at $005020) ---
        dc.w    $A5A3                           ; $005020  buffer addr A
        dc.w    $A400                           ; $005022  buffer addr B

; ============================================================================
; STATE 0 WORK: DREQ + camera + sound + timers
; ============================================================================
        jsr     camera_snapshot_wrapper(pc)      ; camera snapshot + 2560B DREQ to SH2
        jsr     sound_update_disp+126(pc)        ; sound channel A ($C874)
        jsr     cascaded_frame_counter+10(pc)    ; countdown timer animation
        jsr     cascaded_frame_counter(pc)       ; cascaded counter
        jsr     ai_timer_inc(pc)                 ; AI think timer
        jsr     speed_scale_conditional(pc)      ; speed scaling factor
        jsr     lap_value_store_1(pc)            ; lap counter A
        jsr     lap_value_store_2(pc)            ; lap counter B

; ============================================================================
; STATE 4 WORK: input + AI buffers + entity render pipeline + SH2 physics
; ============================================================================
        jsr     sound_update_disp+170(pc)        ; sound channel B ($C875)
        jsr     controller_read_button_remap+16(pc) ; controller input
        jsr     ai_buffer_setup+14(pc)           ; AI buffer prep A
        jsr     ai_buffer_setup+28(pc)           ; AI buffer prep B
        jsr     entity_render_pipeline_with_vdp_dma_2p_copy+462(pc) ; entity rendering + VDP DMA
        jsr     state4_epilogue(pc)              ; globals staging + cmd $3F trigger

; ============================================================================
; STATE 8 WORK: 2P graphics + HUD + animation + objects
; ============================================================================
        jsr     sound_update_disp+206(pc)        ; sound channel C ($C862)
        jsr     gfx_2_player_entity_frame_orch(pc) ; 2-player entity graphics
        jsr     display_digit_extract+58(pc)     ; HUD digit rendering A
        jsr     display_digit_extract+46(pc)     ; HUD digit rendering B
        jsr     hud_panel_config(pc)             ; HUD panel configuration
        jsr     conditional_return_on_disp_config_flag(pc) ; display mode check
        addq.w  #1,($FFFFC8AA).w                ; scene_state++
        jsr     animated_seq_player+10(pc)       ; animation playback
        jsr     object_update(pc)                ; object/sprite update

; --- V-INT state: unified handler (VDP sync + sprite cfg + frame swap) ---
        move.w  #$0054,$00FF0008                ; V-INT state = unified 60 FPS handler

; --- Tail-jump to pause/scene transition check ---
        jmp     pause_menu_handler_ctrl_check+20(pc)
