# SH2 Global Symbol Map

| Address | Symbol | Description |
|---------|--------|-------------|
| $000203D8 | hot_sync_check | |
| $00020AD8 | init_registers | |
| $00021B04 | dot_product | |
| $00021B1C | vector_normalize | |
| $00021B2C | hot_math_routine | |
| $00021F3A | clip_to_screen | |
| $00021FAC | hot_coord_calc | |
| $00021FE6 | vertex_transform | |
| $00022006 | depth_compare | |
| $0002218A | face_normal_calc | |
| $000221C6 | hot_render_helper | |
| $00022206 | hot_vertex_proc | |
| $00022248 | hot_matrix_calc | |
| $00022514 | shade_calculate | |
| $00022B4A | hot_transform_prep | |
| $00022B58 | hot_transform_core | |
| $000231AC | lighting_calc | |
| $000234A0 | texture_lookup | |
| $00023ED0 | hot_data_fetch | |
| $00023F2E | hot_copy_loop | |
| $020203D8 | master_sync_entry | |
| $02020400 | comm_wait_68k | |
| $02020450 | comm_send_response | |
| $020204A0 | frame_sync_wait | |
| $0222300A | data_init_stride_loop | |
| $0222301C | display_list_processor | |
| $02223066 | render_init | |
| $022230CC | clear_render_state | |
| $022230DC | load_render_params | |
| $022230E6 | matrix_transform_loop | |
| $02223114 | matrix_vector_multiply | |
| $02223176 | alt_transform_loop | |
| $022231A2 | transform_handler | |
| $022231E4 | command_handler_09 | |
| $02223202 | command_handler_10 | |
| $0222321C | transform_wrapper | |
| $02223268 | transform_dispatch | |
| $022232C4 | projection_calc | |
| $02223308 | depth_calc | |
| $02223340 | screen_coord_convert | |
| $02223368 | coord_transform_util | |
| $02223388 | coord_transform_single | |
| $022233A2 | coord_transform_pair | |
| $0222340C | coord_transform_triple | |
| $02223468 | recursive_tree_traverse | |
| $022234C0 | transform_with_cull | |
| $022234EC | simple_transform | |
| $02223500 | frustum_cull_dispatch | |
| $022235F4 | render_param_setup | |
| $02223632 | param_helper | |
| $02223642 | coord_boundary_clamp | |
| $0222367A | conditional_value_assign | |
| $02223682 | register_copy | |
| $02223686 | region_code_generate | |
| $022236CA | conditional_param_assign | |
| $022236D4 | register_copy_v2 | |
| $022236D8 | scanline_fill_loop | |
| $022236F8 | polygon_scanline_gen | |
| $0222375C | bresenham_rasterize | |
| $022237A8 | render_param_fetch | |
| $022237D2 | conditional_block_proc | |
| $0222381C | bounds_validate | |
| $02223834 | zero_value_check | |
| $0222385C | memory_fill_init | |
| $022238D6 | block_fill_loop | |
| $0222395C | memory_copy_setup | |
| $022239AA | recursive_gbr_copy | |
| $022239CA | multi_level_dispatch | |
| $02223B3C | stream_decode_loop | |
| $02223BC2 | command_process | |
| $02223BEC | param_extract | |
| $02223C42 | utility_049 | |
| $02223C4C | data_fetch_loop | |
| $02223C60 | index_lookup | |
| $02223CA2 | utility_052 | |
| $02223CAE | byte_store_op | |
| $02223CB2 | word_store_op | |
| $02223CDA | long_store_op | |
| $02223D1A | ptr_advance | |
| $02223D3C | size_calc | |
| $02223D52 | offset_calc | |
| $02223DC4 | multi_block_copy_orch | |
| $02223E1C | polygon_type_select | |
| $02223E32 | dual_block_copy | |
| $02223E5C | conditional_dual_copy | |
| $02223E5E | tri_render_flat | |
| $02223E88 | triple_block_copy | |
| $02223EA0 | tri_render_gouraud | |
| $02223EC6 | inline_unrolled_copy | |
| $02223F00 | quad_render_flat | |
| $02223F2C | unrolled_data_copy | |
| $02223FC4 | block_copy_32 | |
| $02223FF2 | block_copy_48 | |
| $02224000 | block_copy_64 | |
| $02224100 | framebuffer_clear | |
| $02224150 | framebuffer_flip | |
| $022241A0 | palette_transfer | |
| $02224320 | polygon_dispatch_6way | |
| $02224366 | polygon_dispatch_variant | |
| $02224598 | recursive_list_proc | |
| $02224692 | sincos_lookup_table | |
| $02224AEC | register_save_wrapper | |
| $02224C7E | stream_state_machine | |
| $02224D16 | multipath_render_dispatch | |
| $22000400 | slave_main_loop | (placeholder - actual at $06000592) |
| $22001000 | slave_process_polygons | (placeholder) |
| $22001100 | parse_polygon_bounds | (placeholder) |

## Slave SH2 Functions (✅ Confirmed January 2026)

| SDRAM Address | ROM Offset | Symbol | Description |
|---------------|------------|--------|-------------|
| $06000570 | $020570 | slave_init | Initialize Slave, set VBR |
| $06000592 | $020592 | slave_command_loop | Poll COMM1 for commands |
| $060005C8 | $0205C8 | slave_jump_table | Command handler dispatch table |
| $06000608 | $020608 | slave_delay_loop | Idle state (64-cycle delay) |
| $0600060A | $02060A | *(delay NOP)* | **66.5% Slave cycles** (profiler hotspot) |

See: [slave_command_dispatcher.asm](sh2/3d_engine/slave_command_dispatcher.asm)

**Total symbols:** 112
