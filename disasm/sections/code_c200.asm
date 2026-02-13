; ============================================================================
; Code Section ($00C200-$00E1FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $00C200

        include "modules/68k/game/scene/scene_init_orch.asm"
        include "modules/68k/game/state/state_disp_00c30a.asm"
        include "modules/68k/game/scene/scene_init_multiple_sh2_calls.asm"
        include "modules/68k/game/scene/scene_orch.asm"
        include "modules/68k/game/scene/scene_dispatch.asm"
        include "modules/68k/game/scene/scene_state_disp.asm"
        include "modules/68k/game/scene/scene_frame_update_disp_mode_set.asm"
        include "modules/68k/game/scene/scene_dispatch_input_replay.asm"
        dc.w    $4E75        ; $00C542
        include "modules/68k/game/scene/scene_phase_timer_setup.asm"
        include "modules/68k/game/scene/scene_phase_timer_tick_data_tables.asm"
        include "modules/68k/game/scene/scene_phase_timer_reset.asm"
        include "modules/68k/game/race/countdown_timer_setup_race_start_init.asm"
        include "modules/68k/game/race/countdown_timer_update_anim_race_start.asm"
        include "modules/68k/game/race/scene_state_disp_race_init_phases.asm"
        include "modules/68k/game/race/race_init_phase_1_flag_setup.asm"
        include "modules/68k/game/race/race_init_phase_2_vdp_scroll_mode_config.asm"
        include "modules/68k/game/race/race_scene_data_loader.asm"
        include "modules/68k/game/track/track_graphics_and_sound_loader.asm"
        include "modules/68k/game/scene/scene_dispatch_track_data_setup.asm"
        include "modules/68k/game/entity/object_field_store_helper.asm"
        include "modules/68k/game/render/vdp_reg_table_copy.asm"
        include "modules/68k/game/render/vdp_reg_table_init_multi_entry_loader.asm"
        include "modules/68k/game/menu/vdp_slot_activation_config_a.asm"
        include "modules/68k/game/menu/vdp_slot_activation_config_b.asm"
        include "modules/68k/game/menu/vdp_slot_activation_config_c.asm"
        include "modules/68k/game/race/race_track_overlay_config.asm"
        include "modules/68k/game/entity/object_array_init_rom_tables.asm"
        dc.w    $4E75        ; $00CC72
        include "modules/68k/game/camera/scene_camera_init.asm"
        include "modules/68k/game/entity/object_table_init_entry_array.asm"
        include "modules/68k/game/scene/scene_init_sh2_buffer_clear_loop.asm"
        include "modules/68k/game/entity/object_entry_loader_loop_table_lookup.asm"
        include "modules/68k/game/entity/dual_object_entry_init_primary_alternate.asm"
        include "modules/68k/game/entity/object_entry_data_copy.asm"
        include "modules/68k/game/entity/object_entries_reset_init_fixed_table.asm"
        include "modules/68k/game/scene/scene_init.asm"
        include "modules/68k/game/hud/score_stat_lookup_accum_dual.asm"
        include "modules/68k/game/physics/entity_heading_and_turn_rate_calculator.asm"
        include "modules/68k/game/render/scene_init_vdp_block_setup_counter_reset.asm"
        include "modules/68k/game/race/race_scene_init_jump_table_dispatch.asm"
        include "modules/68k/game/race/race_sprite_table_init.asm"
        include "modules/68k/game/scene/game_mode_track_config.asm"
        include "modules/68k/game/render/vdp_dma_config_and_display_init.asm"
        include "modules/68k/game/render/scene_init_vdp_dma_setup_track_param_load.asm"
        include "modules/68k/game/render/sh2_display_and_palette_init.asm"
        include "modules/68k/game/render/scene_state_disp_with_palette_data.asm"
        include "modules/68k/game/entity/object_update_cond_game_state_advance.asm"
        include "modules/68k/game/render/palette_data_loader_and_cycle_handler.asm"
        include "modules/68k/game/render/scene_param_adjustment_and_dma_upload.asm"
        include "modules/68k/game/physics/positive_velocity_step_small_inc.asm"
        include "modules/68k/game/physics/negative_velocity_step_small_dec.asm"
        include "modules/68k/game/scene/sh2_object_and_sprite_update_orch.asm"
        include "modules/68k/game/scene/sh2_dual_screen_object_update_orch.asm"
        include "modules/68k/game/scene/sh2_handshake_state_advance.asm"
        include "modules/68k/game/scene/scene_setup_game_mode_transition.asm"
        include "modules/68k/game/render/sh2_cmd_27_sprite_render.asm"
        dc.w    $0401        ; $00E19E
        dc.w    $4010        ; $00E1A0
        dc.w    $003A        ; $00E1A2
        dc.w    $0401        ; $00E1A4
        dc.w    $4049        ; $00E1A6
        dc.w    $003B        ; $00E1A8
        dc.w    $0401        ; $00E1AA
        dc.w    $4083        ; $00E1AC
        dc.w    $003A        ; $00E1AE
        dc.w    $0401        ; $00E1B0
        dc.w    $40BC        ; $00E1B2
        dc.w    $003A        ; $00E1B4
        dc.w    $0401        ; $00E1B6
        dc.w    $40F5        ; $00E1B8
        dc.w    $003B        ; $00E1BA
        dc.w    $3ABC        ; $00E1BC
        dc.w    $8F02        ; $00E1BE
        dc.w    $2ABC        ; $00E1C0
        dc.w    $4000        ; $00E1C2
        dc.w    $0003        ; $00E1C4
        dc.w    $4240        ; $00E1C6
        dc.w    $761B        ; $00E1C8
        dc.w    $3200        ; $00E1CA
        dc.w    $E749        ; $00E1CC
        dc.w    $41F9        ; $00E1CE
        dc.w    $0088        ; $00E1D0
        dc.w    $E20C        ; $00E1D2
        dc.w    $41F0        ; $00E1D4
        dc.w    $1000        ; $00E1D6
        dc.w    $383C        ; $00E1D8
        dc.w    $0005        ; $00E1DA
        dc.w    $3A3C        ; $00E1DC
        dc.w    $0007        ; $00E1DE
        dc.w    $7C00        ; $00E1E0
        dc.w    $1C30        ; $00E1E2
        dc.w    $5000        ; $00E1E4
        dc.w    $0646        ; $00E1E6
        dc.w    $02F0        ; $00E1E8
        dc.w    $3C86        ; $00E1EA
        dc.w    $51CD        ; $00E1EC
        dc.w    $FFF2        ; $00E1EE
        dc.w    $51CC        ; $00E1F0
        dc.w    $FFEA        ; $00E1F2
        dc.w    $383C        ; $00E1F4
        dc.w    $004F        ; $00E1F6
        dc.w    $3CBC        ; $00E1F8
        dc.w    $0000        ; $00E1FA
        dc.w    $51CC        ; $00E1FC
        dc.w    $FFFA        ; $00E1FE
