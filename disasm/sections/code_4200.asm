; ============================================================================
; Code Section ($004200-$0061FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $004200

        include "modules/68k/game/render/sprite_config_setup_001.asm"
        include "modules/68k/util/data_unpack_nibbles.asm"
        include "modules/68k/game/state/timer_threshold_init.asm"
        include "modules/68k/display/scroll_update.asm"
        include "modules/68k/game/state/timer_wait_clear.asm"
        include "modules/68k/display/fade_subtract_array.asm"
        include "modules/68k/game/state/advance_clear_timer.asm"
        include "modules/68k/game/state/timer_flag_set.asm"
        include "modules/68k/game/race/sound_advance_check.asm"
        include "modules/68k/game/state/game_init_state_dispatch_002.asm"
        include "modules/68k/game/scene/scene_state_check_cond_advance.asm"
        include "modules/68k/game/state/flag_check_advance.asm"
        include "modules/68k/game/state/state_reset_multi.asm"
        include "modules/68k/game/state/display_state_disp.asm"
        include "modules/68k/game/race/call_sub_address_check_set_race_mode.asm"
        include "modules/68k/display/set_flag_clear_sprite.asm"
        include "modules/68k/game/state/advance_input_state.asm"
        include "modules/68k/game/state/input_state_disp.asm"
        include "modules/68k/game/render/sprite_position_check.asm"
        include "modules/68k/game/render/sprite_clear_alt.asm"
        include "modules/68k/game/state/counter_reset_3.asm"
        include "modules/68k/game/race/sound_sprite_advance.asm"
        include "modules/68k/game/state/flag96_sprite_advance.asm"
        include "modules/68k/display/scroll_limit_update.asm"
        include "modules/68k/display/visibility_flag_set.asm"
        include "modules/68k/game/state/counter_check_advance.asm"
        include "modules/68k/game/state/timer_complete_flags.asm"
        include "modules/68k/memory/block_copy_with_check.asm"
        include "modules/68k/game/state/game_logic_init_state_dispatch.asm"
        include "modules/68k/game/state/flag_sound_advance_b.asm"
        include "modules/68k/game/state/full_state_reset_b.asm"
        include "modules/68k/util/word_pack_swap.asm"
        include "modules/68k/memory/quad_memory_fill.asm"
        include "modules/68k/memory/fast_fill_128_fixed.asm"
        include "modules/68k/memory/triple_memory_copy.asm"
        include "modules/68k/memory/fast_copy_128_fixed.asm"
        include "modules/68k/math/random_number_gen.asm"
        include "modules/68k/frame/wait_for_vblank.asm"
        include "modules/68k/input/input_clear_both.asm"
        include "modules/68k/input/input_clear_partial_a.asm"
        include "modules/68k/input/input_clear_partial_b.asm"
        include "modules/68k/input/input_mask_both.asm"
        include "modules/68k/input/input_mask_partial_a.asm"
        include "modules/68k/input/input_mask_partial_b.asm"
        include "modules/68k/game/auto/fn_4200_009.asm"
        include "modules/68k/game/scene/set_state_pre_dispatch_init_sh2_scene.asm"
        include "modules/68k/game/state/state_disp_004cb8.asm"
        include "modules/68k/game/menu/call_subs_advance_game_state.asm"
        include "modules/68k/game/scene/game_frame_orch_013.asm"
        include "modules/68k/game/auto/fn_4200_014.asm"
        include "modules/68k/game/state/state_disp_005020.asm"
        include "modules/68k/game/scene/frame_update_orch_005070.asm"
        include "modules/68k/game/scene/frame_orch_00509e.asm"
        include "modules/68k/game/auto/fn_4200_018.asm"
        include "modules/68k/game/state/state_disp_005308.asm"
        include "modules/68k/game/menu/call_subs_advance_game_state_set_frame_delay.asm"
        include "modules/68k/game/scene/frame_orch_00535e.asm"
        include "modules/68k/game/auto/fn_4200_022.asm"
        include "modules/68k/game/state/state_disp_005586.asm"
        include "modules/68k/game/menu/sfx_queue_sprite_check_advance_game_state.asm"
        include "modules/68k/game/scene/frame_update_orch_0055d0.asm"
        include "modules/68k/game/race/process_sfx_poll_ctrls_advance_frame.asm"
        include "modules/68k/game/state/state_disp_005618.asm"
        include "modules/68k/game/menu/call_4_subs_advance_game_state.asm"
        include "modules/68k/game/scene/frame_orch_005676.asm"
        include "modules/68k/game/state/pause_menu_handler_ctrl_check.asm"
        include "modules/68k/game/state/state_disp_00573c.asm"
        include "modules/68k/display/counter_inc_display.asm"
        include "modules/68k/game/state/state_disp_ctrl_poll_sprite_update.asm"
        include "modules/68k/game/state/advance_sub_seq_timer.asm"
        include "modules/68k/game/state/controller_input_check_start_button_handler.asm"
        include "modules/68k/game/state/set_timer_val.asm"
        include "modules/68k/game/race/sound_queue_enable_flags_advance_state.asm"
        include "modules/68k/game/state/flag_check_clear_init.asm"
        include "modules/68k/game/scene/sh2_handler_dispatch_scene_init.asm"
        include "modules/68k/game/entity/object_table_lookup_loop.asm"
        include "modules/68k/game/scene/sh2_comm_check_cond_guard.asm"
        include "modules/68k/game/entity/object_table_clear_loop.asm"
        include "modules/68k/game/auto/fn_4200_040.asm"
        include "modules/68k/game/auto/fn_4200_041.asm"
        include "modules/68k/game/auto/fn_4200_042.asm"
        include "modules/68k/game/auto/fn_4200_043.asm"
        include "modules/68k/game/scene/game_frame_orch.asm"
        include "modules/68k/game/auto/fn_4200_045.asm"
        dc.w    $0838        ; $00617A
        dc.w    $0000        ; $00617C
        dc.w    $C80E        ; $00617E
        dc.w    $6600        ; $006180
        dc.w    $00D6        ; $006182
        dc.w    $11FC        ; $006184
        dc.w    $0001        ; $006186
        dc.w    $C800        ; $006188
        dc.w    $7000        ; $00618A
        dc.w    $3140        ; $00618C
        dc.w    $0044        ; $00618E
        dc.w    $3140        ; $006190
        dc.w    $0046        ; $006192
        dc.w    $3140        ; $006194
        dc.w    $004A        ; $006196
        dc.w    $4EBA        ; $006198
        dc.w    $1F32        ; $00619A
        dc.w    $4EBA        ; $00619C
        dc.w    $23AA        ; $00619E
        dc.w    $4EBA        ; $0061A0
        dc.w    $3660        ; $0061A2
        dc.w    $4EBA        ; $0061A4
        dc.w    $1CD4        ; $0061A6
        dc.w    $4EBA        ; $0061A8
        dc.w    $0DEE        ; $0061AA
        dc.w    $4EBA        ; $0061AC
        dc.w    $1B2A        ; $0061AE
        dc.w    $4EBA        ; $0061B0
        dc.w    $0EF8        ; $0061B2
        dc.w    $4EBA        ; $0061B4
        dc.w    $0F94        ; $0061B6
        dc.w    $4EBA        ; $0061B8
        dc.w    $1494        ; $0061BA
        dc.w    $4EBA        ; $0061BC
        dc.w    $1D92        ; $0061BE
        dc.w    $4EBA        ; $0061C0
        dc.w    $3B0C        ; $0061C2
        dc.w    $4EBA        ; $0061C4
        dc.w    $4A78        ; $0061C6
        dc.w    $4EBA        ; $0061C8
        dc.w    $398A        ; $0061CA
        dc.w    $4EBA        ; $0061CC
        dc.w    $24FA        ; $0061CE
        dc.w    $4EBA        ; $0061D0
        dc.w    $CF54        ; $0061D2
        dc.w    $4EBA        ; $0061D4
        dc.w    $CF8A        ; $0061D6
        dc.w    $4EBA        ; $0061D8
        dc.w    $144A        ; $0061DA
        dc.w    $4EBA        ; $0061DC
        dc.w    $1170        ; $0061DE
        dc.w    $4EBA        ; $0061E0
        dc.w    $D4FC        ; $0061E2
        dc.w    $4EBA        ; $0061E4
        dc.w    $D5D0        ; $0061E6
        dc.w    $4EBA        ; $0061E8
        dc.w    $DD9C        ; $0061EA
        dc.w    $4EBA        ; $0061EC
        dc.w    $2E76        ; $0061EE
        dc.w    $11F8        ; $0061F0
        dc.w    $C304        ; $0061F2
        dc.w    $C30C        ; $0061F4
        dc.w    $3038        ; $0061F6
        dc.w    $C8A0        ; $0061F8
        dc.w    $0838        ; $0061FA
        dc.w    $0007        ; $0061FC
        dc.w    $C81C        ; $0061FE
