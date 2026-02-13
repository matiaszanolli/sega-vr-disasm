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
        include "modules/68k/game/hud/lap_time_digit_renderer_a.asm"
        include "modules/68k/game/hud/bcd_nibble_splitter_a.asm"
        include "modules/68k/game/hud/digit_tile_dma_to_framebuffer_a.asm"
        include "modules/68k/game/hud/ascii_character_to_tile_index_mapper_010674.asm"
        include "modules/68k/game/menu/name_entry_background_tile_transfer.asm"
        include "modules/68k/game/menu/name_entry_cursor_render.asm"
        include "modules/68k/game/menu/name_entry_input_handler.asm"
        include "modules/68k/game/menu/name_entry_screen_init.asm"
        include "modules/68k/game/menu/name_entry_state_disp.asm"
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
        include "modules/68k/game/hud/lap_time_digit_renderer_b.asm"
        include "modules/68k/game/hud/bcd_nibble_splitter_b.asm"
        include "modules/68k/game/hud/digit_tile_dma_to_framebuffer_b.asm"
        include "modules/68k/game/hud/lap_time_digit_renderer_c.asm"
        include "modules/68k/game/hud/bcd_nibble_splitter_c.asm"
        include "modules/68k/game/hud/digit_tile_blit_to_framebuffer.asm"
        include "modules/68k/game/menu/name_entry_color_palette_update.asm"
        include "modules/68k/game/menu/cursor_pos_clamp.asm"
        include "modules/68k/game/scene/sh2_command_sender.asm"
        include "modules/68k/game/menu/name_entry_ui_tile_refresh.asm"
        include "modules/68k/game/menu/name_entry_bcd_score_cmp.asm"
        include "modules/68k/game/menu/name_entry_score_area_dma_xfer.asm"
        include "modules/68k/game/menu/records_screen_init.asm"
        include "modules/68k/game/menu/records_screen_state_disp.asm"
        include "modules/68k/game/menu/name_entry_rendering_sh2_xfer.asm"
        dc.w    $0401        ; $0121FA
        dc.w    $9010        ; $0121FC
        dc.w    $0401        ; $0121FE
