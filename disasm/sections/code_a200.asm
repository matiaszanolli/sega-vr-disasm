; ============================================================================
; Code Section ($00A200-$00C1FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $00A200

; ============================================================================
; Physics Lookup Tables ($00A200-$00A34F)
; Translated from dc.w format - see disasm/modules/68k/game/physics_lookup_tables.asm
; ============================================================================
        include "modules/68k/game/physics/physics_lookup_tables.asm"

; ============================================================================
; Effect Timer Management ($00A350-$00A3B8)
; Translated from dc.w format - see disasm/modules/68k/game/effect_timer_mgmt.asm
; ============================================================================
        include "modules/68k/game/state/effect_timer_mgmt.asm"

; ============================================================================
; Speed Calculation ($00A3BA-$00A3E8)
; Translated from dc.w format - see disasm/modules/68k/game/speed_calculation.asm
; ============================================================================
        include "modules/68k/game/physics/speed_calculation.asm"

; ============================================================================
; Speed Interpolation ($00A3EA-$00A432)
; Translated from dc.w format - see disasm/modules/68k/game/speed_interpolation.asm
; ============================================================================
        include "modules/68k/game/physics/speed_interpolation.asm"

; ============================================================================
; AI Opponent Select ($00A434-$00A46E)
; Translated from dc.w format - see disasm/modules/68k/game/ai_opponent_select.asm
; ============================================================================
        include "modules/68k/game/ai/ai_opponent_select.asm"

        include "modules/68k/game/ai/collision_avoidance_speed_calc.asm"
; ============================================================================
; Physics Integration ($00A666-$00A6F6)
; Translated from dc.w format - see disasm/modules/68k/game/physics_integration.asm
; ============================================================================
        include "modules/68k/game/physics/physics_integration.asm"

        include "modules/68k/game/ai/collision_avoidance_no_target.asm"
; ============================================================================
; AI Steering Calculation ($00A7A0-$00A7E0)
; Translated from dc.w format - see disasm/modules/68k/game/ai_steering_calc.asm
; ============================================================================
        include "modules/68k/game/ai/ai_steering_calc.asm"

; ============================================================================
; Entity Table Load ($00A7E2-$00A808)
; Translated from dc.w format - see disasm/modules/68k/game/entity_table_load.asm
; ============================================================================
        include "modules/68k/game/entity/entity_table_load.asm"

; ============================================================================
; Entity Table Load Mode ($00A80A-$00A83C)
; Translated from dc.w format - see disasm/modules/68k/game/entity_table_load_mode.asm
; ============================================================================
        include "modules/68k/game/entity/entity_table_load_mode.asm"

; ============================================================================
; Bulk Table Copy ($00A83E-$00A866)
; Translated from dc.w format - see disasm/modules/68k/game/bulk_table_copy.asm
; ============================================================================
        include "modules/68k/game/data/bulk_table_copy.asm"

        include "modules/68k/game/entity/entity_type_dispatch_tables.asm"
; ============================================================================
; Object State Return ($00A8F8-$00A970)
; Translated from dc.w format - see disasm/modules/68k/game/obj_state_return.asm
; ============================================================================
        include "modules/68k/game/entity/obj_state_return.asm"

        include "modules/68k/game/ai/ai_entity_main_update_orch.asm"
; ============================================================================
; Effect Countdown ($00AC3E-$00ACBE)
; Translated from dc.w format - see disasm/modules/68k/game/effect_countdown.asm
; ============================================================================
        include "modules/68k/game/state/effect_countdown.asm"
; ============================================================================
; Race Mode Flag Set ($00ACC0-$00ACD2)
; Translated from dc.w format - see disasm/modules/68k/game/race_mode_flag_set.asm
; ============================================================================
        include "modules/68k/game/race/race_mode_flag_set.asm"

; ============================================================================
; AI Target Check ($00ACD4-$00AD12)
; Translated from dc.w format - see disasm/modules/68k/game/ai_target_check.asm
; ============================================================================
        include "modules/68k/game/ai/ai_target_check.asm"

; ============================================================================
; Entity Target Action ($00AD14-$00ADC2)
; Translated from dc.w format - see disasm/modules/68k/game/entity_target_action.asm
; ============================================================================
        include "modules/68k/game/entity/entity_target_action.asm"
; ============================================================================
; Proximity Distance Check ($00ADC4-$00AE04)
; Translated from dc.w format - see disasm/modules/68k/game/proximity_distance_check.asm
; ============================================================================
        include "modules/68k/game/collision/proximity_distance_check.asm"
; ============================================================================
; Zone Check Inner ($00AE06-$00AED6)
; Translated from dc.w format - see disasm/modules/68k/game/zone_check_inner.asm
; ============================================================================
        include "modules/68k/game/collision/zone_check_inner.asm"
; ============================================================================
; Entity Directional Push ($00AED8-$00AF16)
; Translated from dc.w format - see disasm/modules/68k/game/entity_directional_push.asm
; ============================================================================
        include "modules/68k/game/entity/entity_directional_push.asm"
        include "modules/68k/game/collision/object_collision_detection.asm"
; ============================================================================
; Close Position Flags ($00AFC2-$00AFFC)
; Translated from dc.w format - see disasm/modules/68k/game/close_position_flags.asm
; ============================================================================
        include "modules/68k/game/collision/close_position_flags.asm"
; ============================================================================
; Position Separation ($00AFFE-$00B02A)
; Translated from dc.w format - see disasm/modules/68k/game/position_separation.asm
; ============================================================================
        include "modules/68k/game/collision/position_separation.asm"

; ============================================================================
; Speed Scale Simple ($00B02C-$00B03A)
; Translated from dc.w format - see disasm/modules/68k/game/speed_scale_simple.asm
; ============================================================================
        include "modules/68k/game/physics/speed_scale_simple.asm"

; ============================================================================
; Speed Scale Conditional ($00B03C-$00B068)
; Translated from dc.w format - see disasm/modules/68k/game/speed_scale_conditional.asm
; ============================================================================
        include "modules/68k/game/physics/speed_scale_conditional.asm"

; ============================================================================
; Speed Scale Calculation ($00B06A-$00B092)
; Translated from dc.w format - see disasm/modules/68k/game/speed_scale_calc.asm
; ============================================================================
        include "modules/68k/game/physics/speed_scale_calc.asm"
        include "modules/68k/game/state/cascaded_frame_counter.asm"
        include "modules/68k/game/ai/ai_timer_inc.asm"
        include "modules/68k/game/ai/ai_buffer_setup.asm"
        include "modules/68k/game/sound/sequence_data_byte_decoder.asm"
        include "modules/68k/game/ai/ai_digit_lookup_best_lap.asm"
        include "modules/68k/game/hud/bcd_scoring_calc.asm"
        include "modules/68k/game/ai/ai_table_lookup_cond_fall_through.asm"
        include "modules/68k/game/hud/bcd_time_update_010.asm"
        include "modules/68k/game/ai/ai_param_lookup_threshold_check_00b36e.asm"
        include "modules/68k/game/ai/ai_param_lookup_threshold_check_00b398.asm"
        include "modules/68k/game/sound/sequence_data_word_decoder.asm"
        include "modules/68k/game/sound/sound_buffer_copy_with_decode.asm"
        include "modules/68k/game/sound/sound_buffer_copy_with_offset.asm"
        include "modules/68k/game/data/word_to_nibble_unpacker.asm"
        include "modules/68k/game/hud/bcd_nibble_subtractor.asm"
        include "modules/68k/game/hud/display_digit_extract.asm"
; ============================================================================
; HUD Panel Config ($00B55A-$00B58E)
; Translated from dc.w format - see disasm/modules/68k/game/hud_panel_config.asm
; ============================================================================
        include "modules/68k/game/hud/hud_panel_config.asm"
        include "modules/68k/game/state/conditional_return_on_disp_config_flag.asm"
        include "modules/68k/game/ai/ai_data_load_cond_return_on_flag.asm"
        include "modules/68k/game/race/lap_disp_update_vdp_tile_write.asm"
        include "modules/68k/game/ai/ai_flag_setup_at_object_array.asm"
; ============================================================================
; Lap Value Store 1 ($00B632-$00B644)
; Translated from dc.w format - see disasm/modules/68k/game/lap_value_store_1.asm
; ============================================================================
        include "modules/68k/game/race/lap_value_store_1.asm"

; ============================================================================
; Lap Value Store 2 ($00B646-$00B658)
; Translated from dc.w format - see disasm/modules/68k/game/lap_value_store_2.asm
; ============================================================================
        include "modules/68k/game/race/lap_value_store_2.asm"
        include "modules/68k/game/race/sfx_dispatch_object_update_anim_seq.asm"
        include "modules/68k/game/render/animated_seq_player.asm"
        include "modules/68k/game/render/animation_seq_player.asm"
        include "modules/68k/game/camera/camera_state_selector.asm"
        include "modules/68k/game/render/display_state_bit_10_guard.asm"
        include "modules/68k/game/camera/camera_animation_state_disp.asm"
        include "modules/68k/game/ai/ai_timer_dec_cond_state_clear.asm"
        include "modules/68k/game/ai/ai_timer_dec_state_clear_reactivate.asm"
        include "modules/68k/game/track/track_segment_load_031.asm"
        dc.w    $4E75        ; $00BA18  RTS stub (empty function, called by scene init)
        include "modules/68k/game/state/triple_dispatch.asm"
        include "modules/68k/game/scene/scene_menu_init_and_input_handler.asm"
        include "modules/68k/game/scene/scene_command_disp.asm"
        include "modules/68k/game/menu/reset_scene_menu_state.asm"
        include "modules/68k/game/state/clear_state_copy_scroll_data_object.asm"
        include "modules/68k/game/entity/backward_object_scan_copy_scroll_data.asm"
        include "modules/68k/game/ai/ai_scene_interpolation.asm"
; ============================================================================
; Abort With Flag ($00BD9E-$00BDA6)
; Translated from dc.w format - see disasm/modules/68k/game/abort_with_flag.asm
; ============================================================================
        include "modules/68k/game/state/abort_with_flag.asm"

; ============================================================================
; HUD Activate Check ($00BDA8-$00BDC6)
; Translated from dc.w format - see disasm/modules/68k/game/hud_activate_check.asm
; ============================================================================
        include "modules/68k/game/hud/hud_activate_check.asm"

; ============================================================================
; Counter Init Check ($00BDC8-$00BDD4)
; Translated from dc.w format - see disasm/modules/68k/game/counter_init_check.asm
; ============================================================================
        include "modules/68k/game/state/counter_init_check.asm"
        include "modules/68k/game/ai/ai_object_setup_cond_flag_set.asm"
        include "modules/68k/game/render/display_param_calc.asm"
        include "modules/68k/game/ai/ai_state_dispatch.asm"
        include "modules/68k/game/ai/ai_dispatch_triple_object_setup.asm"
        include "modules/68k/game/hud/display_entry_builder.asm"
        include "modules/68k/game/render/vdp_table_entry_write_00bf9e.asm"
        include "modules/68k/game/ai/advance_ai_state_machine_00bfd4.asm"
        include "modules/68k/game/render/vdp_table_entry_write_00bfde.asm"
        include "modules/68k/game/ai/advance_ai_state_machine_00c01e.asm"
; ============================================================================
; HUD Buffer Clear ($00C028-$00C05A)
; Translated from dc.w format - see disasm/modules/68k/game/hud_buffer_clear.asm
; ============================================================================
        include "modules/68k/game/hud/hud_buffer_clear.asm"
        include "modules/68k/game/hud/display_list_builder.asm"
        include "modules/68k/game/scene/race_scene_init_vdp_mode.asm"
