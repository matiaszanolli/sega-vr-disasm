; ============================================================================
; Code Section ($002200-$0041FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $002200

        include "modules/68k/util/counter_decrement_flag_set.asm"
        include "modules/68k/game/race/audio_frequency_update.asm"
        include "modules/68k/game/state/randomized_timer_decrement_a.asm"
        include "modules/68k/game/state/weighted_timer_average_a.asm"
        include "modules/68k/game/state/randomized_timer_decrement_b.asm"
        include "modules/68k/game/state/weighted_timer_average_b.asm"
        include "modules/68k/game/state/randomized_timer_decrement_c.asm"
        include "modules/68k/game/race/audio_trigger_frequency_calc.asm"
        include "modules/68k/game/race/randomized_sound_param_0023c2.asm"
        include "modules/68k/game/physics/weighted_average_pos_clamp_0023dc.asm"
        include "modules/68k/game/race/randomized_sound_param_00240c.asm"
        include "modules/68k/game/physics/weighted_average_pos_clamp_002426.asm"
        include "modules/68k/game/race/randomized_sound_param_002452.asm"
        include "modules/68k/display/set_flag_8507_01.asm"
        include "modules/68k/display/set_flag_8507_80.asm"
        include "modules/68k/graphics/pixel_unpack_2pairs.asm"
        include "modules/68k/graphics/pixel_unpack_1pair.asm"
        include "modules/68k/game/data/vdp_tile_unpack_0024ca.asm"
        include "modules/68k/game/hud/conditional_tile_index_expand.asm"
        include "modules/68k/game/data/vdp_tile_unpack_0025b0.asm"
        include "modules/68k/hardware-regs/mars_regs_init_13.asm"
        include "modules/68k/game/render/gfx_32x_vdp_mode_reg_setup.asm"
        include "modules/68k/game/render/mars_adapter_state_init_framebuffer_setup.asm"
        include "modules/68k/game/render/mars_framebuffer_preparation.asm"
        include "modules/68k/vdp/vdp_fill_framebuffer.asm"
        include "modules/68k/vdp/vdp_clear_palette.asm"
        include "modules/68k/vdp/vdp_fill_line_table_flat.asm"
        include "modules/68k/vdp/vdp_fill_line_table_ramp.asm"
        include "modules/68k/game/render/gfx_32x_framebuffer_palette_fill.asm"
        include "modules/68k/vdp/vdp_fill_pattern.asm"
        include "modules/68k/vdp/palette_copy_full.asm"
        include "modules/68k/vdp/palette_copy_partial.asm"
        include "modules/68k/game/render/v_int_cram_xfer_gate.asm"
        include "modules/68k/sh2/mars_comm_write.asm"
        include "modules/68k/game/render/mars_dma_xfer_vdp_fill.asm"
        include "modules/68k/game/camera/camera_param_calc.asm"
        include "modules/68k/game/state/object_enable_fields_state_dispatch.asm"
        include "modules/68k/game/physics/object_velocity_init_cond_clear.asm"
        include "modules/68k/object/entity_set_model_type0.asm"
        include "modules/68k/game/camera/camera_param_calc_b.asm"
        include "modules/68k/game/render/object_render_disp.asm"
        include "modules/68k/game/entity/entity_visibility_check.asm"
        include "modules/68k/game/camera/camera_param_calc_c.asm"
        include "modules/68k/game/state/object_param_8a_dispatch_002dca.asm"
        include "modules/68k/game/physics/object_velocity_init_002df4.asm"
        include "modules/68k/game/physics/object_velocity_init_002e14.asm"
        include "modules/68k/game/state/object_param_8a_dispatch_002e34.asm"
        include "modules/68k/game/physics/object_velocity_init_002e5e.asm"
        include "modules/68k/game/physics/object_velocity_init_002e7e.asm"
        include "modules/68k/game/render/load_disp_list_pointer_002e9e.asm"
        include "modules/68k/game/render/load_disp_list_pointer_002eb2.asm"
        include "modules/68k/game/entity/object_field_clear.asm"
        include "modules/68k/game/render/object_visibility_enable.asm"
        include "modules/68k/game/camera/camera_param_calc_d.asm"
        include "modules/68k/game/render/object_pos_copy_with_render_flags.asm"
        include "modules/68k/game/camera/camera_offset_clamping.asm"
        include "modules/68k/display/camera_offset_check.asm"
        include "modules/68k/game/camera/vdp_buffer_xfer_camera_offset_apply.asm"
        include "modules/68k/game/render/vdp_config_xfer_scaled_params.asm"
        include "modules/68k/game/state/object_state_disp_0031a6.asm"
        include "modules/68k/game/race/object_timer_tick_sfx_lookup_field_clear.asm"
        include "modules/68k/game/state/load_object_pointer_clear_object_state.asm"
        include "modules/68k/game/race/race_result_recording_003272.asm"
        include "modules/68k/game/race/lap_check_disp.asm"
        include "modules/68k/game/state/set_state_0x34.asm"
        include "modules/68k/sound/sound_lookup_play.asm"
        include "modules/68k/game/race/race_result_recording_003404.asm"
        include "modules/68k/game/state/calc_state_from_flags.asm"
        include "modules/68k/game/state/object_state_disp_0034e8.asm"
        include "modules/68k/game/race/object_timer_tick_sfx_lookup.asm"
        include "modules/68k/game/state/clear_object_state_bytes.asm"
        include "modules/68k/game/race/race_result_with_leaderboard_update.asm"
        include "modules/68k/game/state/calc_state_from_flags_2.asm"
; Trampoline: implementation relocated to code_1c200 for LOD culling expansion (S-1)
; Padded to original 216 bytes to preserve PC-relative offsets in subsequent functions.
; Free space after JMP used for frame-rate interpolation routines (A1-A3).
object_table_sprite_param_update:
        jmp     $00880000+object_table_sprite_param_update_impl  ; 6 bytes

; ============================================================================
; camera_snapshot_wrapper — Wraps mars_dma_xfer_vdp_fill with camera snapshot
; Called from state 0 handlers in place of mars_dma_xfer_vdp_fill.
; Saves prev/curr camera buffer at $FF6080/$FF6090 for interpolation.
; Clobbers: D0-D3 (already trashed by mars_dma_xfer_vdp_fill)
; ============================================================================
camera_snapshot_wrapper:
        ; Snapshot current $FF6100 BEFORE DMA (these are this frame's camera params)
        ; Step 1: curr → prev
        lea     $00FF6090,a0
        lea     $00FF6080,a1
        movem.l (a0),d0-d3                     ; load 16 bytes from curr
        movem.l d0-d3,(a1)                     ; store to prev
        ; Step 2: $FF6100 → curr
        lea     $00FF6100,a0
        lea     $00FF6090,a1
        movem.l (a0),d0-d3                     ; load 16 bytes from camera buffer
        movem.l d0-d3,(a1)                     ; store to curr snapshot
        ; Step 3: call original DMA function
        jsr     mars_dma_xfer_vdp_fill(pc)
        rts

; ============================================================================
; camera_avg_and_redma — Average camera and re-send DMA to SH2
; Averages 8 words between prev ($FF6080) and curr ($FF6090),
; writes result to $FF6100, then re-DMAs $FF6000 block to SH2.
; Clobbers: D0, D7, A0-A2 (plus whatever mars_dma_xfer_vdp_fill uses)
; Size: 38 bytes
; ============================================================================
camera_avg_and_redma:
        lea     $00FF6080,a0                   ; prev snapshot
        lea     $00FF6090,a1                   ; curr snapshot
        lea     $00FF6100,a2                   ; camera buffer output
        moveq   #7,d7                          ; 8 words to average
.avg_loop:
        move.w  (a0)+,d0                       ; prev[i]
        add.w   (a1)+,d0                       ; prev + curr
        asr.w   #1,d0                          ; / 2
        move.w  d0,(a2)+                       ; store averaged
        dbra    d7,.avg_loop
        jsr     mars_dma_xfer_vdp_fill(pc)     ; re-DMA to SH2
        rts

; ============================================================================
; state4_epilogue — State 4 tail: block-copy + swap + interpolation + re-DMA
; Tail-jumped from frame_update_orch_005070 (state 4 handler).
;
; 1. Sends 2 sh2_send_cmd block copies to capture the CURRENT SH2 render
;    (camera N) to the framebuffer before re-DMA overwrites SDRAM.
; 2. Swaps frame buffer → displays camera N render (first swap = 40 FPS).
; 3. Averages camera, re-DMAs → SH2 re-renders with interpolated camera.
;    State 8's existing block copies + swap will display this second render.
;
; Size: 102 bytes
; ============================================================================
state4_epilogue:
; --- Block-copy current SH2 render (camera N) to framebuffer ---
; Same params as sh2_geometry_transfer_and_palette_cycle_handler
        movea.l #$06038000,a0                  ; 3D geometry source (SDRAM)
        movea.l #$04012010,a1                  ; framebuffer dest
        move.w  #$0120,d0                      ; width = 288 pixels
        move.w  #$0030,d1                      ; height = 48 rows
        jsr     $0088E35A                      ; sh2_send_cmd (abs.l, PC-rel too far)
        movea.l #$0603B600,a0                  ; sprite data source (SDRAM)
        movea.l #$0401B010,a1                  ; framebuffer dest
        move.w  #$0120,d0                      ; width = 288 pixels
        move.w  #$0018,d1                      ; height = 24 rows
        jsr     $0088E35A                      ; sh2_send_cmd
; --- Swap frame buffer (COMM1_LO bit 0 set after last block copy) ---
        btst    #0,COMM1_LO                    ; SH2 block copy done?
        beq.s   .no_swap                       ; no → skip (shouldn't happen)
        bclr    #0,COMM1_LO                    ; clear done flag
        bchg    #0,($FFFFC80C).w               ; flip frame toggle
        bchg    #0,$00A1518B                   ; toggle FS bit (swap display)
.no_swap:
; --- Interpolate camera and trigger second SH2 render ---
        jsr     camera_avg_and_redma(pc)
; --- VR60 Phase 1B: relay game state via COMM3-5, trigger cmd $3F ---
        jsr     vr60_comm_trigger               ; 6B — writes COMM3-5 + triggers cmd $3F
; --- Original state 4 epilogue ---
        addq.w  #4,($FFFFC87E).w               ; advance game_state
        move.w  #$001C,$00FF0008               ; V-INT state = sprite_cfg
        rts

; JSR (6B) replaces 24B inline trigger from Phase 1A. Padding restored to 18B.
; Code = 6 (JMP) + 46 (snapshot) + 38 (avg) + 108 (epilogue 102 + JSR 6) = 198 bytes.
; Padding = 216 - 198 = 18 bytes.
        dcb.b   18,$FF
        include "modules/68k/game/collision/object_proximity_check_jump_table_dispatch.asm"
        include "modules/68k/game/state/conditional_return_on_disp_flag.asm"
        include "modules/68k/game/collision/proximity_check_with_sine_billboard.asm"
        include "modules/68k/game/collision/sprite_init_collision_check_003924.asm"
        include "modules/68k/game/render/sprite_param_setup.asm"
        include "modules/68k/game/collision/proximity_check_simple.asm"
        include "modules/68k/game/collision/proximity_loop_iterator_a.asm"
        include "modules/68k/game/collision/sprite_init_collision_check_003a4e.asm"
        include "modules/68k/game/collision/proximity_check_062.asm"
        include "modules/68k/game/collision/object_table_3_proximity_with_animation.asm"
        include "modules/68k/game/collision/proximity_loop_iterator_b.asm"
        include "modules/68k/game/hud/sprite_hud_layout_builder.asm"
        include "modules/68k/game/render/vdp_sprite_pointer_setup_cond_disp_clear.asm"
        include "modules/68k/game/race/sfx_trigger_object_enable_fields.asm"
        include "modules/68k/game/hud/hud_element_init.asm"
        include "modules/68k/game/state/reset_timer_advance_state.asm"
        include "modules/68k/game/menu/conditional_scene_transition_003da6.asm"
        include "modules/68k/game/menu/conditional_scene_transition_003dd4.asm"
        include "modules/68k/game/render/scene_transition_check_vdp_clear.asm"
        include "modules/68k/game/scene/clear_scene_state_advance_dispatch_index.asm"
        include "modules/68k/game/scene/clear_scene_state_advance_dispatch_set_mode.asm"
        include "modules/68k/game/menu/conditional_scene_transition_003e7e.asm"
        include "modules/68k/game/menu/conditional_scene_transition_003ea2.asm"
        include "modules/68k/game/menu/conditional_scene_transition_003ec6.asm"
        include "modules/68k/game/render/scene_state_timer_vdp_output.asm"
        dc.w    $4E75        ; $003F2C — $4E75 = RTS stub (empty function placeholder)
        include "modules/68k/game/render/render_slot_setup.asm"
        include "modules/68k/game/render/display_state_disp_004084.asm"
        include "modules/68k/game/physics/object_speed_ramp_up_state_advance.asm"
        include "modules/68k/game/state/check_timeout_60.asm"
        include "modules/68k/game/race/race_completion_check_lap_bit_tracking.asm"
        include "modules/68k/game/render/display_state_race_lap_preamble.asm"
