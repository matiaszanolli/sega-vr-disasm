; ============================================================================
; Code Section ($010200-$0121FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $010200

        include "modules/68k/game/menu/name_entry_sh2_xfer_advance.asm"
        include "modules/68k/game/menu/name_entry_character_input_010244.asm"
        include "modules/68k/game/menu/name_entry_object_update_dma.asm"
        include "modules/68k/game/menu/name_entry_character_input_0103c4.asm"
        include "modules/68k/game/menu/name_entry_sprite_update_anim.asm"
        include "modules/68k/game/scene/sh2_comm_reset_mode_set.asm"
        include "modules/68k/game/auto/fn_10200_014.asm"
        include "modules/68k/game/auto/fn_10200_015.asm"
        include "modules/68k/game/auto/fn_10200_016.asm"
        include "modules/68k/game/hud/ascii_character_to_tile_index_mapper_010674.asm"
        include "modules/68k/game/auto/fn_10200_018.asm"
        include "modules/68k/game/menu/name_entry_cursor_render.asm"
        include "modules/68k/game/menu/name_entry_input_handler.asm"
        include "modules/68k/game/auto/fn_10200_020.asm"
        include "modules/68k/game/auto/fn_10200_021.asm"
        include "modules/68k/game/menu/advance_game_state_set_frame_delay.asm"
        include "modules/68k/game/menu/name_entry_score_disp_xfer.asm"
        include "modules/68k/game/menu/name_entry_mode_select_input_handler.asm"
        include "modules/68k/game/menu/name_entry_sh2_comm_setup_dma.asm"
        include "modules/68k/game/menu/name_entry_scroll_view_action_handler.asm"
        include "modules/68k/game/menu/name_entry_sh2_comm_scroll_dma_blink.asm"
        include "modules/68k/game/menu/name_entry_dual_scroll_view_action_handler.asm"
        include "modules/68k/game/menu/sh2_scene_reset_name_entry_mode_disp.asm"
        include "modules/68k/game/scene/sh2_scene_reset_set_handler_88d4a4.asm"
        include "modules/68k/game/scene/sprite_buffer_clear_sh2_scene_reset.asm"
        include "modules/68k/game/auto/fn_10200_030.asm"
        include "modules/68k/game/auto/fn_10200_031.asm"
        include "modules/68k/game/auto/fn_10200_032.asm"
        include "modules/68k/game/auto/fn_10200_033.asm"
        include "modules/68k/game/auto/fn_10200_034.asm"
        include "modules/68k/game/auto/fn_10200_035.asm"
        include "modules/68k/game/menu/name_entry_color_palette_update.asm"
        include "modules/68k/game/auto/fn_10200_006.asm"
        include "modules/68k/game/scene/sh2_command_sender.asm"
        include "modules/68k/game/auto/fn_10200_036.asm"
        include "modules/68k/game/menu/name_entry_bcd_score_cmp.asm"
        include "modules/68k/game/menu/name_entry_score_area_dma_xfer.asm"
        include "modules/68k/game/auto/fn_10200_038.asm"
        include "modules/68k/game/auto/fn_10200_039.asm"
        include "modules/68k/game/menu/name_entry_rendering_sh2_xfer.asm"
        dc.w    $0401        ; $0121FA
        dc.w    $9010        ; $0121FC
        dc.w    $0401        ; $0121FE
