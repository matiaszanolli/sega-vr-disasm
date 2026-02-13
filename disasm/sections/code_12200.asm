; ============================================================================
; Code Section ($012200-$0141FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $012200

        include "modules/68k/game/auto/fn_12200_015.asm"
        include "modules/68k/game/scene/sh2_scene_reset_set_handler_8926d2.asm"
        include "modules/68k/game/menu/camera_tile_render.asm"
        include "modules/68k/game/auto/fn_12200_017.asm"
        include "modules/68k/game/auto/fn_12200_018.asm"
        include "modules/68k/game/auto/fn_12200_019.asm"
        include "modules/68k/game/auto/fn_12200_002.asm"
        include "modules/68k/game/hud/ascii_character_to_tile_index_mapper_012618.asm"
        include "modules/68k/game/auto/fn_12200_021.asm"
        include "modules/68k/game/auto/fn_12200_022.asm"
        include "modules/68k/game/scene/scene_state_disp_track_data_tables.asm"
        include "modules/68k/game/menu/camera_demo_palette_sh2_setup.asm"
        include "modules/68k/game/menu/camera_dma_xfer.asm"
        include "modules/68k/game/auto/fn_12200_003.asm"
        include "modules/68k/game/auto/fn_12200_004.asm"
        include "modules/68k/game/auto/fn_12200_026.asm"
        include "modules/68k/game/menu/sh2_mode_disp_select_scene_by_track_mode.asm"
        include "modules/68k/game/menu/camera_sh2_command_27_dispatch.asm"
        include "modules/68k/game/auto/fn_12200_006.asm"
        include "modules/68k/game/auto/fn_12200_007.asm"
        include "modules/68k/game/auto/fn_12200_028.asm"
        include "modules/68k/game/menu/camera_state_disp.asm"
        include "modules/68k/game/menu/camera_render_dma_overlay.asm"
        include "modules/68k/game/menu/camera_menu_orch.asm"
        include "modules/68k/game/menu/camera_menu_input_handler.asm"
        include "modules/68k/game/menu/camera_selection_counter_0136aa.asm"
        include "modules/68k/game/menu/camera_selection_counter_0136ea.asm"
        include "modules/68k/game/menu/camera_selection_counter_013734.asm"
        include "modules/68k/game/menu/camera_selection_counter_01377a.asm"
        include "modules/68k/game/menu/conditional_state_set_enable_flags_sh2_call_0137c0.asm"
        include "modules/68k/game/menu/conditional_state_set_enable_flags_sh2_call_0137f4.asm"
        include "modules/68k/game/scene/sh2_scene_reset_cond_handler_by_player_2_flag.asm"
        include "modules/68k/game/auto/fn_12200_035.asm"
        include "modules/68k/game/auto/fn_12200_036.asm"
        include "modules/68k/game/menu/camera_sh2_scene_transition_dual_dma.asm"
        include "modules/68k/game/auto/fn_12200_038.asm"
        include "modules/68k/game/menu/i_o_port_config_backup_sh2_scene_reset.asm"
        include "modules/68k/game/auto/fn_12200_039.asm"
        include "modules/68k/game/auto/fn_12200_014.asm"
        dc.w    $0001        ; $0141DC
        dc.w    $0504        ; $0141DE
        dc.w    $0600        ; $0141E0
        dc.w    $0001        ; $0141E2
        dc.w    $0A09        ; $0141E4
        dc.w    $0805        ; $0141E6
        dc.w    $0406        ; $0141E8
        dc.w    $2A01        ; $0141EA
        dc.w    $43F9        ; $0141EC
        dc.w    $0089        ; $0141EE
        dc.w    $AB5A        ; $0141F0
        dc.w    $363C        ; $0141F2
        dc.w    $0003        ; $0141F4
        dc.w    $4A00        ; $0141F6
        dc.w    $6700        ; $0141F8
        dc.w    $000C        ; $0141FA
        dc.w    $43F9        ; $0141FC
        dc.w    $0089        ; $0141FE
