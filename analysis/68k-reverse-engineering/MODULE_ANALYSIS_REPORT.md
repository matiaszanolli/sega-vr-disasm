# 68K Module Analysis Report

**Generated**: Auto-analyzed 572 fn_* modules
**Tool**: tools/analyze_68k_modules.py

---

## Category Breakdown

| Category | Count | Percentage |
|----------|-------|------------|
| game | 317 | 55.4% |
| sh2 | 62 | 10.8% |
| sound | 56 | 9.8% |
| vint | 35 | 6.1% |
| boot | 29 | 5.1% |
| object | 28 | 4.9% |
| vdp | 18 | 3.1% |
| input | 10 | 1.7% |
| display | 10 | 1.7% |
| math | 5 | 0.9% |
| data | 1 | 0.2% |
| graphics | 1 | 0.2% |

## Confidence Levels

| Level | Count | Percentage |
|-------|-------|------------|
| high | 154 | 26.9% |
| medium | 160 | 28.0% |
| low | 258 | 45.1% |

## By Section

### Section 10200 (40 modules)

| Category | Count |
|----------|-------|
| game | 26 |
| sh2 | 14 |

### Section 12200 (39 modules)

| Category | Count |
|----------|-------|
| game | 21 |
| sh2 | 17 |
| data | 1 |

### Section 14200 (49 modules)

| Category | Count |
|----------|-------|
| game | 46 |
| vdp | 2 |
| sh2 | 1 |

### Section 200 (48 modules)

| Category | Count |
|----------|-------|
| boot | 29 |
| sh2 | 7 |
| vdp | 6 |
| input | 3 |
| game | 2 |
| vint | 1 |

### Section 2200 (81 modules)

| Category | Count |
|----------|-------|
| vint | 33 |
| game | 32 |
| object | 8 |
| sh2 | 4 |
| input | 2 |
| math | 1 |
| display | 1 |

### Section 30200 (63 modules)

| Category | Count |
|----------|-------|
| sound | 56 |
| vdp | 7 |

### Section 4200 (45 modules)

| Category | Count |
|----------|-------|
| game | 27 |
| object | 10 |
| input | 4 |
| sh2 | 2 |
| display | 1 |
| vdp | 1 |

### Section 6200 (70 modules)

| Category | Count |
|----------|-------|
| game | 56 |
| object | 7 |
| math | 2 |
| sh2 | 2 |
| display | 1 |
| vdp | 1 |
| input | 1 |

### Section 8200 (48 modules)

| Category | Count |
|----------|-------|
| game | 40 |
| display | 4 |
| math | 2 |
| vint | 1 |
| vdp | 1 |

### Section a200 (48 modules)

| Category | Count |
|----------|-------|
| game | 42 |
| display | 3 |
| object | 1 |
| sh2 | 1 |
| graphics | 1 |

### Section c200 (30 modules)

| Category | Count |
|----------|-------|
| game | 23 |
| sh2 | 5 |
| object | 2 |

### Section e200 (11 modules)

| Category | Count |
|----------|-------|
| sh2 | 9 |
| game | 2 |

## Full Module Reference

| Module | Suggested Name | Category | Confidence | Size |
|--------|---------------|----------|------------|------|
| fn_200_001.asm | vdp_001 | vdp | medium | 188B |
| fn_200_002.asm | vdp_002 | vdp | medium | 112B |
| fn_200_003.asm | init_003 | boot | low | 86B |
| fn_200_004.asm | init_004 | boot | low | 40B |
| fn_200_005.asm | sh2_comm_save_all_registers_005 | sh2 | high | 1438B |
| fn_200_006.asm | init_006 | boot | low | 22B |
| fn_200_007.asm | input_controller_port_init_007 | input | high | 248B |
| fn_200_008.asm | sh2_comm_z80_bus_vdp_init_008 | sh2 | high | 92B |
| fn_200_009.asm | init_009 | boot | low | 14B |
| fn_200_010.asm | z80_bus_vdp_init_010 | vdp | medium | 536B |
| fn_200_011.asm | io_port_init_011 | boot | low | 74B |
| fn_200_012.asm | vdp_012 | vdp | medium | 144B |
| fn_200_013.asm | vdp_013 | vdp | medium | 76B |
| fn_200_014.asm | init_014 | boot | low | 130B |
| fn_200_015.asm | init_015 | boot | low | 12B |
| fn_200_016.asm | init_016 | boot | low | 10B |
| fn_200_017.asm | init_017 | boot | low | 12B |
| fn_200_018.asm | init_018 | boot | low | 10B |
| fn_200_019.asm | init_dispatch_019 | boot | low | 262B |
| fn_200_020.asm | init_dispatch_020 | boot | low | 122B |
| fn_200_021.asm | init_dispatch_021 | boot | low | 70B |
| fn_200_022.asm | tile_decompress_init_022 | boot | low | 34B |
| fn_200_023.asm | init_dispatch_023 | boot | low | 110B |
| fn_200_024.asm | init_dispatch_024 | boot | low | 56B |
| fn_200_025.asm | init_dispatch_025 | boot | low | 138B |
| fn_200_026.asm | vdp_dispatch_026 | vdp | medium | 92B |
| fn_200_027.asm | init_027 | boot | low | 220B |
| fn_200_028.asm | input_button_remap_028 | input | high | 72B |
| fn_200_029.asm | init_029 | boot | low | 14B |
| fn_200_030.asm | input_zbus_request_030 | input | high | 186B |
| fn_200_031.asm | init_031 | boot | low | 122B |
| fn_200_032.asm | vint_dispatch_032 | vint | medium | 14B |
| fn_200_033.asm | init_033 | boot | low | 88B |
| fn_200_034.asm | init_034 | boot | low | 74B |
| fn_200_035.asm | init_035 | boot | low | 338B |
| fn_200_036.asm | sh2_comm_PaletteRAMCopy_036 | sh2 | high | 166B |
| fn_200_037.asm | sh2_comm_game_037 | sh2 | high | 178B |
| fn_200_038.asm | sh2_comm_game_038 | sh2 | high | 132B |
| fn_200_039.asm | boot_game_039 | game | medium | 82B |
| fn_200_040.asm | sh2_comm_game_040 | sh2 | high | 182B |
| fn_200_041.asm | sh2_comm_game_041 | sh2 | high | 198B |
| fn_200_042.asm | boot_game_042 | game | medium | 42B |
| fn_200_043.asm | init_043 | boot | low | 16B |
| fn_200_044.asm | init_044 | boot | low | 20B |
| fn_200_045.asm | init_045 | boot | low | 8B |
| fn_200_046.asm | init_046 | boot | low | 24B |
| fn_200_047.asm | init_047 | boot | low | 86B |
| fn_200_048.asm | init_048 | boot | low | 280B |
| fn_2200_001.asm | vint_001 | vint | medium | 136B |
| fn_2200_002.asm | vint_random_number_gen_002 | vint | low | 22B |
| fn_2200_003.asm | vint_003 | vint | low | 44B |
| fn_2200_004.asm | vint_random_number_gen_004 | vint | low | 22B |
| fn_2200_005.asm | vint_005 | vint | low | 40B |
| fn_2200_006.asm | vint_random_number_gen_006 | vint | low | 22B |
| fn_2200_007.asm | vint_dispatch_007 | vint | medium | 152B |
| fn_2200_008.asm | vint_random_number_gen_008 | vint | low | 26B |
| fn_2200_009.asm | vint_009 | vint | low | 48B |
| fn_2200_010.asm | vint_random_number_gen_010 | vint | low | 26B |
| fn_2200_011.asm | vint_011 | vint | low | 44B |
| fn_2200_012.asm | vint_random_number_gen_012 | vint | low | 26B |
| fn_2200_013.asm | vint_unpack_tiles_vdp_013 | vint | low | 202B |
| fn_2200_014.asm | vint_tile_index_expand_014 | vint | low | 28B |
| fn_2200_015.asm | vint_unpack_tiles_vdp_015 | vint | low | 142B |
| fn_2200_016.asm | vint_016 | vint | low | 46B |
| fn_2200_017.asm | sh2_comm_VDPPrep_017 | sh2 | high | 138B |
| fn_2200_018.asm | sh2_comm_framebuffer_prep_018 | sh2 | high | 50B |
| fn_2200_019.asm | sh2_comm_VDPPrep_019 | sh2 | high | 68B |
| fn_2200_020.asm | vint_020 | vint | low | 24B |
| fn_2200_021.asm | sh2_comm_021 | sh2 | high | 194B |
| fn_2200_022.asm | vint_physics_022 | game | medium | 238B |
| fn_2200_023.asm | vint_velocity_023 | game | medium | 56B |
| fn_2200_024.asm | vint_velocity_024 | game | low | 26B |
| fn_2200_025.asm | vint_physics_025 | game | medium | 210B |
| fn_2200_026.asm | obj_render_check_026 | object | high | 234B |
| fn_2200_027.asm | vint_physics_027 | game | medium | 238B |
| fn_2200_028.asm | vint_velocity_028 | game | low | 42B |
| fn_2200_029.asm | vint_velocity_029 | game | low | 32B |
| fn_2200_030.asm | vint_velocity_030 | game | low | 32B |
| fn_2200_031.asm | vint_velocity_031 | game | low | 42B |
| fn_2200_032.asm | vint_velocity_032 | game | low | 32B |
| fn_2200_033.asm | vint_velocity_033 | game | low | 32B |
| fn_2200_034.asm | vint_034 | vint | low | 20B |
| fn_2200_035.asm | vint_035 | vint | low | 20B |
| fn_2200_036.asm | vint_heading_036 | game | low | 40B |
| fn_2200_037.asm | vint_heading_037 | game | low | 22B |
| fn_2200_038.asm | vint_physics_038 | game | medium | 268B |
| fn_2200_039.asm | vint_physics_039 | game | medium | 182B |
| fn_2200_040.asm | vint_040 | vint | medium | 80B |
| fn_2200_041.asm | vint_041 | vint | medium | 58B |
| fn_2200_042.asm | vint_042 | vint | low | 70B |
| fn_2200_043.asm | obj_dispatch_043 | object | medium | 94B |
| fn_2200_044.asm | objs_044 | object | medium | 76B |
| fn_2200_045.asm | objs_045 | object | medium | 34B |
| fn_2200_046.asm | objs_046 | object | medium | 264B |
| fn_2200_047.asm | vint_dispatch_047 | vint | low | 106B |
| fn_2200_048.asm | input_048 | input | medium | 206B |
| fn_2200_049.asm | obj_dispatch_049 | object | medium | 88B |
| fn_2200_050.asm | objs_050 | object | medium | 92B |
| fn_2200_051.asm | objs_051 | object | medium | 24B |
| fn_2200_052.asm | vint_objs_052 | game | high | 276B |
| fn_2200_053.asm | vint_obj_table_1_053 | game | high | 216B |
| fn_2200_054.asm | vint_dispatch_054 | game | high | 168B |
| fn_2200_055.asm | vint_055 | vint | low | 8B |
| fn_2200_056.asm | math_sine_lookup_056 | math | medium | 190B |
| fn_2200_057.asm | vint_057 | vint | low | 88B |
| fn_2200_058.asm | vint_058 | vint | low | 112B |
| fn_2200_059.asm | vint_position_059 | game | low | 82B |
| fn_2200_060.asm | vint_060 | vint | low | 16B |
| fn_2200_061.asm | vint_061 | vint | low | 100B |
| fn_2200_062.asm | vint_position_062 | game | low | 118B |
| fn_2200_063.asm | vint_obj_table_3_063 | game | medium | 242B |
| fn_2200_064.asm | vint_064 | vint | low | 16B |
| fn_2200_065.asm | vint_dispatch_065 | vint | medium | 164B |
| fn_2200_066.asm | vint_066 | vint | medium | 84B |
| fn_2200_067.asm | vint_heading_067 | game | low | 56B |
| fn_2200_068.asm | vint_068 | vint | low | 64B |
| fn_2200_069.asm | vint_scene_069 | game | high | 46B |
| fn_2200_070.asm | vint_scene_070 | game | high | 52B |
| fn_2200_071.asm | vint_dispatch_071 | game | high | 74B |
| fn_2200_072.asm | vint_scene_072 | game | high | 18B |
| fn_2200_073.asm | vint_scene_073 | game | high | 26B |
| fn_2200_074.asm | vint_scene_074 | game | high | 36B |
| fn_2200_075.asm | vint_scene_075 | game | high | 36B |
| fn_2200_076.asm | vint_scene_076 | game | high | 48B |
| fn_2200_077.asm | vint_scene_077 | game | high | 54B |
| fn_2200_078.asm | vint_render_078 | vint | low | 342B |
| fn_2200_079.asm | display_dispatch_079 | display | high | 182B |
| fn_2200_080.asm | input_080 | input | medium | 46B |
| fn_2200_081.asm | vint_input_081 | game | medium | 104B |
| fn_4200_001.asm | input_001 | input | medium | 128B |
| fn_4200_002.asm | logic_dispatch_002 | game | high | 144B |
| fn_4200_003.asm | logic_input_003 | game | high | 56B |
| fn_4200_004.asm | display_dispatch_004 | display | medium | 80B |
| fn_4200_005.asm | input_005 | input | medium | 30B |
| fn_4200_006.asm | input_006 | input | medium | 6B |
| fn_4200_007.asm | input_dispatch_007 | input | medium | 98B |
| fn_4200_008.asm | logic_dispatch_008 | game | high | 172B |
| fn_4200_009.asm | logic_pre_dispatch_common_009 | game | high | 600B |
| fn_4200_010.asm | logic_pre_dispatch_common_010 | game | low | 46B |
| fn_4200_011.asm | logic_dispatch_011 | game | medium | 72B |
| fn_4200_012.asm | logic_sprite_update_check_012 | game | medium | 26B |
| fn_4200_013.asm | obj_poll_controllers_013 | object | high | 126B |
| fn_4200_014.asm | logic_sound_flag_handler_014 | game | high | 648B |
| fn_4200_015.asm | logic_dispatch_015 | game | medium | 80B |
| fn_4200_016.asm | logic_poll_controllers_016 | game | medium | 46B |
| fn_4200_017.asm | logic_poll_controllers_017 | game | high | 98B |
| fn_4200_018.asm | logic_sound_flag_handler_018 | game | high | 520B |
| fn_4200_019.asm | logic_dispatch_019 | game | medium | 64B |
| fn_4200_020.asm | logic_animation_update_020 | game | medium | 22B |
| fn_4200_021.asm | logic_poll_controllers_021 | game | high | 82B |
| fn_4200_022.asm | logic_sound_flag_handler_022 | game | high | 470B |
| fn_4200_023.asm | logic_dispatch_023 | game | medium | 52B |
| fn_4200_024.asm | logic_sfx_queue_process_024 | game | medium | 22B |
| fn_4200_025.asm | obj_poll_controllers_025 | object | high | 46B |
| fn_4200_026.asm | logic_poll_controllers_026 | game | low | 26B |
| fn_4200_027.asm | logic_dispatch_027 | game | medium | 64B |
| fn_4200_028.asm | logic_sfx_queue_process_028 | game | medium | 30B |
| fn_4200_029.asm | obj_poll_controllers_029 | object | high | 110B |
| fn_4200_030.asm | logic_SetDisplayParams_030 | game | high | 88B |
| fn_4200_031.asm | vdp_dispatch_031 | vdp | medium | 54B |
| fn_4200_032.asm | obj_dispatch_032 | object | medium | 74B |
| fn_4200_033.asm | logic_033 | game | low | 6B |
| fn_4200_034.asm | logic_034 | game | medium | 74B |
| fn_4200_035.asm | logic_035 | game | medium | 40B |
| fn_4200_036.asm | sh2_comm_dispatch_036 | sh2 | medium | 132B |
| fn_4200_037.asm | obj_table_lookup_037 | object | medium | 30B |
| fn_4200_038.asm | sh2_comm_038 | sh2 | medium | 30B |
| fn_4200_039.asm | obj_table_lookup_039 | object | medium | 22B |
| fn_4200_040.asm | logic_dispatch_040 | game | high | 378B |
| fn_4200_041.asm | obj_palette_update_041 | object | high | 594B |
| fn_4200_042.asm | logic_dispatch_042 | game | high | 192B |
| fn_4200_043.asm | obj_palette_update_043 | object | high | 112B |
| fn_4200_044.asm | obj_palette_update_044 | object | high | 178B |
| fn_4200_045.asm | obj_reg_write_045 | object | high | 656B |
| fn_6200_001.asm | obj_dispatch_001 | game | high | 64B |
| fn_6200_002.asm | obj_reg_write_002 | object | high | 598B |
| fn_6200_003.asm | obj_memory_copy_003 | object | high | 262B |
| fn_6200_004.asm | obj_calc_steering_004 | object | high | 382B |
| fn_6200_005.asm | obj_calc_steering_005 | game | high | 96B |
| fn_6200_006.asm | obj_dispatch_006 | object | high | 704B |
| fn_6200_007.asm | obj_dispatch_007 | game | high | 122B |
| fn_6200_008.asm | obj_dispatch_008 | object | high | 226B |
| fn_6200_009.asm | obj_dispatch_009 | game | low | 52B |
| fn_6200_010.asm | obj_010 | game | low | 62B |
| fn_6200_011.asm | obj_011 | game | low | 30B |
| fn_6200_012.asm | display_scroll_012 | display | medium | 32B |
| fn_6200_013.asm | obj_FastCopy16_013 | game | low | 66B |
| fn_6200_014.asm | obj_sprite_table_init_014 | object | medium | 84B |
| fn_6200_015.asm | obj_015 | game | low | 8B |
| fn_6200_016.asm | obj_016 | game | low | 8B |
| fn_6200_017.asm | obj_017 | game | low | 10B |
| fn_6200_018.asm | obj_018 | game | low | 10B |
| fn_6200_019.asm | obj_position_019 | game | medium | 30B |
| fn_6200_020.asm | obj_position_020 | game | medium | 30B |
| fn_6200_021.asm | obj_021 | game | low | 16B |
| fn_6200_022.asm | obj_dispatch_022 | object | high | 508B |
| fn_6200_023.asm | math_position_update_sub_023 | math | high | 98B |
| fn_6200_024.asm | obj_024 | game | low | 92B |
| fn_6200_025.asm | obj_race_025 | game | high | 162B |
| fn_6200_026.asm | vdp_026 | vdp | medium | 40B |
| fn_6200_027.asm | obj_race_027 | game | high | 206B |
| fn_6200_028.asm | obj_race_028 | game | medium | 154B |
| fn_6200_029.asm | obj_race_029 | game | medium | 68B |
| fn_6200_030.asm | obj_030 | game | low | 18B |
| fn_6200_031.asm | obj_heading_031 | game | low | 24B |
| fn_6200_032.asm | math_cosine_lookup_032 | math | high | 84B |
| fn_6200_033.asm | obj_033 | game | low | 94B |
| fn_6200_034.asm | obj_frame_calc_034 | game | medium | 412B |
| fn_6200_035.asm | obj_tile_position_calc_035 | game | high | 420B |
| fn_6200_036.asm | obj_dispatch_036 | game | low | 78B |
| fn_6200_037.asm | obj_037 | game | low | 4B |
| fn_6200_038.asm | obj_038 | game | low | 8B |
| fn_6200_039.asm | obj_039 | game | low | 8B |
| fn_6200_040.asm | obj_040 | game | low | 8B |
| fn_6200_041.asm | obj_041 | game | low | 4B |
| fn_6200_042.asm | obj_042 | game | low | 4B |
| fn_6200_043.asm | obj_render_043 | game | low | 36B |
| fn_6200_044.asm | obj_tile_position_calc_044 | game | high | 214B |
| fn_6200_045.asm | obj_dispatch_045 | game | low | 78B |
| fn_6200_046.asm | obj_046 | game | low | 4B |
| fn_6200_047.asm | obj_047 | game | low | 4B |
| fn_6200_048.asm | obj_048 | game | low | 4B |
| fn_6200_049.asm | obj_049 | game | low | 4B |
| fn_6200_050.asm | obj_050 | game | low | 4B |
| fn_6200_051.asm | obj_051 | game | low | 4B |
| fn_6200_052.asm | obj_052 | game | low | 12B |
| fn_6200_053.asm | obj_053 | game | low | 130B |
| fn_6200_054.asm | obj_velocity_054 | game | medium | 102B |
| fn_6200_055.asm | obj_velocity_055 | game | medium | 44B |
| fn_6200_056.asm | obj_race_state_read_056 | game | medium | 138B |
| fn_6200_057.asm | sh2_comm_057 | sh2 | medium | 104B |
| fn_6200_058.asm | obj_058 | game | low | 48B |
| fn_6200_059.asm | obj_059 | game | low | 14B |
| fn_6200_060.asm | obj_movement_060 | game | medium | 74B |
| fn_6200_061.asm | obj_heading_061 | game | low | 84B |
| fn_6200_062.asm | obj_scene_062 | game | high | 118B |
| fn_6200_063.asm | obj_063 | game | low | 20B |
| fn_6200_064.asm | obj_064 | game | low | 22B |
| fn_6200_065.asm | obj_065 | game | low | 46B |
| fn_6200_066.asm | input_066 | input | medium | 34B |
| fn_6200_067.asm | obj_scene_067 | game | medium | 90B |
| fn_6200_068.asm | obj_068 | game | low | 30B |
| fn_6200_069.asm | obj_camera_069 | game | medium | 154B |
| fn_6200_070.asm | sh2_comm_070 | sh2 | medium | 80B |
| fn_8200_001.asm | display_001 | display | medium | 70B |
| fn_8200_002.asm | state_002 | game | low | 16B |
| fn_8200_003.asm | state_003 | game | low | 42B |
| fn_8200_004.asm | state_dispatch_004 | game | medium | 96B |
| fn_8200_005.asm | display_status_code_005 | display | medium | 8B |
| fn_8200_006.asm | state_006 | game | low | 18B |
| fn_8200_007.asm | state_sh2_comm_007 | game | high | 110B |
| fn_8200_008.asm | state_008 | game | low | 18B |
| fn_8200_009.asm | state_009 | game | low | 16B |
| fn_8200_010.asm | state_010 | game | low | 16B |
| fn_8200_011.asm | state_011 | game | low | 10B |
| fn_8200_012.asm | state_012 | game | low | 30B |
| fn_8200_013.asm | display_num_to_decimal_013 | display | high | 272B |
| fn_8200_014.asm | state_014 | game | low | 22B |
| fn_8200_015.asm | state_015 | game | low | 4B |
| fn_8200_016.asm | state_016 | game | low | 20B |
| fn_8200_017.asm | state_017 | game | low | 16B |
| fn_8200_018.asm | state_018 | game | low | 22B |
| fn_8200_019.asm | math_cosine_lookup_019 | math | high | 220B |
| fn_8200_020.asm | state_020 | game | low | 176B |
| fn_8200_021.asm | state_dispatch_021 | game | high | 442B |
| fn_8200_022.asm | state_022 | game | low | 116B |
| fn_8200_023.asm | state_dispatch_023 | game | low | 112B |
| fn_8200_024.asm | state_dispatch_024 | game | low | 56B |
| fn_8200_025.asm | state_025 | game | low | 38B |
| fn_8200_026.asm | state_cosine_lookup_026 | game | medium | 94B |
| fn_8200_027.asm | math_cosine_lookup_027 | math | high | 246B |
| fn_8200_028.asm | state_ai_steering_calc_028 | game | medium | 32B |
| fn_8200_029.asm | state_position_029 | game | medium | 30B |
| fn_8200_030.asm | state_cosine_lookup_030 | game | medium | 82B |
| fn_8200_031.asm | state_dispatch_031 | game | low | 58B |
| fn_8200_032.asm | state_032 | game | low | 56B |
| fn_8200_033.asm | state_velocity_033 | game | medium | 382B |
| fn_8200_034.asm | state_velocity_034 | game | medium | 344B |
| fn_8200_035.asm | state_035 | game | low | 156B |
| fn_8200_036.asm | vint_036 | vint | medium | 298B |
| fn_8200_037.asm | state_sine_lookup_037 | game | medium | 378B |
| fn_8200_038.asm | state_dispatch_038 | game | medium | 124B |
| fn_8200_039.asm | state_velocity_039 | game | medium | 300B |
| fn_8200_040.asm | state_velocity_040 | game | medium | 360B |
| fn_8200_041.asm | display_camera_041 | display | medium | 46B |
| fn_8200_042.asm | state_dispatch_042 | game | low | 282B |
| fn_8200_043.asm | state_dispatch_043 | game | high | 314B |
| fn_8200_044.asm | state_dispatch_044 | game | medium | 132B |
| fn_8200_045.asm | state_045 | game | low | 20B |
| fn_8200_046.asm | state_dispatch_046 | game | high | 400B |
| fn_8200_047.asm | state_dispatch_047 | game | medium | 100B |
| fn_8200_048.asm | vdp_timer_048 | vdp | medium | 278B |
| fn_a200_001.asm | ai_player_table_setup_001 | game | high | 716B |
| fn_a200_002.asm | obj_table_3_002 | object | medium | 170B |
| fn_a200_003.asm | display_scroll_003 | display | medium | 74B |
| fn_a200_004.asm | ai_004 | game | low | 60B |
| fn_a200_005.asm | ai_005 | game | low | 68B |
| fn_a200_006.asm | ai_006 | game | low | 90B |
| fn_a200_007.asm | ai_007 | game | low | 166B |
| fn_a200_008.asm | ai_008 | game | low | 122B |
| fn_a200_009.asm | ai_009 | game | low | 36B |
| fn_a200_010.asm | sh2_comm_dispatch_010 | sh2 | medium | 114B |
| fn_a200_011.asm | ai_dispatch_011 | game | medium | 42B |
| fn_a200_012.asm | ai_dispatch_012 | game | medium | 54B |
| fn_a200_013.asm | ai_013 | game | low | 64B |
| fn_a200_014.asm | ai_014 | game | low | 20B |
| fn_a200_015.asm | ai_015 | game | low | 26B |
| fn_a200_016.asm | ai_016 | game | low | 60B |
| fn_a200_017.asm | ai_017 | game | low | 82B |
| fn_a200_018.asm | display_scroll_018 | display | medium | 144B |
| fn_a200_019.asm | ai_019 | game | low | 8B |
| fn_a200_020.asm | ai_020 | game | low | 22B |
| fn_a200_021.asm | ai_021 | game | low | 86B |
| fn_a200_022.asm | ai_022 | game | low | 46B |
| fn_a200_023.asm | ai_dispatch_023 | game | medium | 118B |
| fn_a200_024.asm | ai_dispatch_024 | game | medium | 82B |
| fn_a200_025.asm | ai_025 | game | low | 78B |
| fn_a200_026.asm | gfx_camera_026 | graphics | high | 118B |
| fn_a200_027.asm | ai_027 | game | low | 8B |
| fn_a200_028.asm | display_dispatch_028 | display | medium | 374B |
| fn_a200_029.asm | ai_029 | game | low | 22B |
| fn_a200_030.asm | ai_030 | game | low | 22B |
| fn_a200_031.asm | ai_heading_031 | game | low | 136B |
| fn_a200_032.asm | ai_032 | game | low | 68B |
| fn_a200_033.asm | ai_camera_033 | game | high | 446B |
| fn_a200_034.asm | ai_dispatch_034 | game | high | 174B |
| fn_a200_035.asm | ai_menu_substate_035 | game | high | 16B |
| fn_a200_036.asm | ai_menu_substate_036 | game | high | 38B |
| fn_a200_037.asm | ai_037 | game | low | 42B |
| fn_a200_038.asm | ai_scene_038 | game | medium | 116B |
| fn_a200_039.asm | ai_039 | game | low | 40B |
| fn_a200_040.asm | ai_dispatch_040 | game | low | 82B |
| fn_a200_041.asm | ai_dispatch_041 | game | low | 116B |
| fn_a200_042.asm | ai_dispatch_042 | game | medium | 56B |
| fn_a200_043.asm | ai_sh2_comm_043 | game | high | 162B |
| fn_a200_044.asm | ai_044 | game | low | 54B |
| fn_a200_045.asm | ai_045 | game | low | 10B |
| fn_a200_046.asm | ai_046 | game | low | 64B |
| fn_a200_047.asm | ai_047 | game | low | 10B |
| fn_a200_048.asm | ai_048 | game | low | 148B |
| fn_c200_001.asm | obj_sprite_input_check_001 | object | high | 266B |
| fn_c200_002.asm | scene_dispatch_002 | game | medium | 94B |
| fn_c200_003.asm | scene_game_003 | game | medium | 40B |
| fn_c200_004.asm | scene_object_update_004 | game | high | 134B |
| fn_c200_005.asm | scene_dispatch_005 | game | high | 54B |
| fn_c200_006.asm | scene_dispatch_006 | game | low | 88B |
| fn_c200_007.asm | scene_007 | game | low | 30B |
| fn_c200_008.asm | scene_dispatch_008 | game | high | 128B |
| fn_c200_009.asm | scene_009 | game | low | 74B |
| fn_c200_010.asm | scene_obj_table_1_010 | game | high | 268B |
| fn_c200_011.asm | scene_FastCopy16_011 | game | medium | 292B |
| fn_c200_012.asm | scene_dispatch_012 | game | medium | 200B |
| fn_c200_013.asm | scene_race_013 | game | high | 364B |
| fn_c200_014.asm | scene_camera_014 | game | medium | 216B |
| fn_c200_015.asm | scene_015 | game | high | 64B |
| fn_c200_016.asm | scene_016 | game | low | 76B |
| fn_c200_017.asm | obj_heading_update_017 | object | high | 232B |
| fn_c200_018.asm | scene_race_substate_018 | game | high | 118B |
| fn_c200_019.asm | scene_dispatch_019 | game | medium | 62B |
| fn_c200_020.asm | scene_sprite_table_init_020 | game | high | 274B |
| fn_c200_021.asm | scene_sh2_comm_021 | game | high | 552B |
| fn_c200_022.asm | scene_dispatch_022 | game | low | 134B |
| fn_c200_023.asm | sh2_comm_palette_load_023 | sh2 | high | 816B |
| fn_c200_024.asm | scene_dispatch_024 | game | medium | 262B |
| fn_c200_025.asm | scene_object_update_025 | game | high | 20B |
| fn_c200_026.asm | sh2_comm_dma_transfer_026 | sh2 | high | 452B |
| fn_c200_027.asm | scene_send_cmd_027 | game | medium | 540B |
| fn_c200_028.asm | sh2_comm_object_update_028 | sh2 | high | 456B |
| fn_c200_029.asm | sh2_comm_object_update_029 | sh2 | high | 340B |
| fn_c200_030.asm | sh2_comm_cmd_27_030 | sh2 | high | 134B |
| fn_e200_001.asm | sh2_comm_001 | sh2 | low | 34B |
| fn_e200_002.asm | sh2_comm_palette_load_002 | sh2 | high | 702B |
| fn_e200_003.asm | sh2_comm_send_cmd_003 | sh2 | medium | 392B |
| fn_e200_004.asm | sh2_comm_object_update_004 | sh2 | high | 564B |
| fn_e200_005.asm | sh2_comm_palette_load_005 | sh2 | high | 620B |
| fn_e200_006.asm | menu_dispatch_006 | game | high | 176B |
| fn_e200_007.asm | sh2_comm_send_cmd_007 | sh2 | medium | 566B |
| fn_e200_008.asm | sh2_comm_object_update_008 | sh2 | high | 438B |
| fn_e200_009.asm | sh2_comm_cmd_27_009 | sh2 | high | 558B |
| fn_e200_010.asm | sh2_comm_palette_load_010 | sh2 | high | 1260B |
| fn_e200_011.asm | menu_dispatch_011 | game | high | 246B |
| fn_10200_009.asm | name_entry_send_cmd_009 | game | medium | 68B |
| fn_10200_010.asm | name_entry_dma_transfer_010 | game | high | 280B |
| fn_10200_011.asm | name_entry_object_update_011 | game | medium | 104B |
| fn_10200_012.asm | name_entry_dma_transfer_012 | game | high | 222B |
| fn_10200_013.asm | name_entry_sprite_update_013 | game | high | 316B |
| fn_10200_001.asm | sh2_comm_game_001 | sh2 | high | 40B |
| fn_10200_014.asm | name_entry_014 | game | low | 52B |
| fn_10200_015.asm | name_entry_015 | game | low | 28B |
| fn_10200_016.asm | sh2_comm_send_cmd_016 | sh2 | medium | 30B |
| fn_10200_017.asm | sh2_comm_send_cmd_017 | sh2 | medium | 168B |
| fn_10200_018.asm | sh2_comm_send_cmd_018 | sh2 | medium | 122B |
| fn_10200_019.asm | name_entry_019 | game | low | 182B |
| fn_10200_002.asm | name_entry_002 | game | low | 296B |
| fn_10200_020.asm | sh2_comm_palette_load_020 | sh2 | high | 1738B |
| fn_10200_021.asm | name_entry_dispatch_021 | game | high | 358B |
| fn_10200_022.asm | name_entry_game_022 | game | medium | 18B |
| fn_10200_023.asm | name_entry_send_cmd_023 | game | medium | 138B |
| fn_10200_024.asm | name_entry_object_update_024 | game | high | 474B |
| fn_10200_025.asm | sh2_comm_dma_transfer_025 | sh2 | high | 84B |
| fn_10200_026.asm | name_entry_object_update_026 | game | high | 314B |
| fn_10200_027.asm | sh2_comm_send_cmd_027 | sh2 | high | 136B |
| fn_10200_028.asm | name_entry_object_update_028 | game | high | 452B |
| fn_10200_003.asm | name_entry_game_003 | game | high | 110B |
| fn_10200_004.asm | sh2_comm_game_004 | sh2 | high | 40B |
| fn_10200_029.asm | name_entry_sprite_update_029 | game | high | 74B |
| fn_10200_030.asm | name_entry_030 | game | low | 52B |
| fn_10200_031.asm | name_entry_031 | game | low | 28B |
| fn_10200_032.asm | sh2_comm_send_cmd_032 | sh2 | medium | 30B |
| fn_10200_033.asm | name_entry_033 | game | low | 60B |
| fn_10200_034.asm | name_entry_034 | game | low | 28B |
| fn_10200_035.asm | name_entry_check_035 | game | low | 30B |
| fn_10200_005.asm | name_entry_005 | game | low | 164B |
| fn_10200_006.asm | name_entry_006 | game | low | 20B |
| fn_10200_007.asm | sh2_comm_007 | sh2 | high | 152B |
| fn_10200_036.asm | sh2_comm_send_cmd_036 | sh2 | medium | 98B |
| fn_10200_008.asm | name_entry_008 | game | low | 276B |
| fn_10200_037.asm | sh2_comm_send_cmd_037 | sh2 | medium | 140B |
| fn_10200_038.asm | sh2_comm_palette_load_038 | sh2 | high | 558B |
| fn_10200_039.asm | name_entry_dispatch_039 | game | high | 332B |
| fn_10200_040.asm | sh2_comm_send_cmd_040 | sh2 | high | 374B |
| fn_12200_015.asm | sh2_comm_object_update_015 | sh2 | high | 780B |
| fn_12200_001.asm | sh2_comm_game_001 | sh2 | high | 40B |
| fn_12200_016.asm | camera_016 | game | low | 104B |
| fn_12200_017.asm | camera_017 | game | low | 52B |
| fn_12200_018.asm | camera_018 | game | low | 28B |
| fn_12200_019.asm | sh2_comm_send_cmd_019 | sh2 | medium | 30B |
| fn_12200_002.asm | camera_002 | game | low | 14B |
| fn_12200_020.asm | sh2_comm_send_cmd_020 | sh2 | medium | 142B |
| fn_12200_021.asm | sh2_comm_send_cmd_021 | sh2 | medium | 44B |
| fn_12200_022.asm | sh2_comm_palette_load_022 | sh2 | high | 782B |
| fn_12200_023.asm | data_12200_023 | data | medium | 146B |
| fn_12200_024.asm | sh2_comm_dma_transfer_024 | sh2 | high | 392B |
| fn_12200_025.asm | camera_dma_transfer_025 | game | medium | 164B |
| fn_12200_003.asm | camera_003 | game | low | 18B |
| fn_12200_004.asm | camera_004 | game | low | 18B |
| fn_12200_026.asm | sh2_comm_object_update_026 | sh2 | high | 584B |
| fn_12200_005.asm | sh2_comm_dispatch_005 | sh2 | high | 76B |
| fn_12200_027.asm | sh2_comm_cmd_27_027 | sh2 | medium | 70B |
| fn_12200_006.asm | camera_006 | game | low | 72B |
| fn_12200_007.asm | sh2_comm_007 | sh2 | high | 112B |
| fn_12200_028.asm | sh2_comm_palette_load_028 | sh2 | high | 574B |
| fn_12200_029.asm | camera_dispatch_029 | game | high | 180B |
| fn_12200_030.asm | sh2_comm_send_cmd_030 | sh2 | high | 386B |
| fn_12200_031.asm | camera_object_update_031 | game | high | 252B |
| fn_12200_032.asm | camera_032 | game | low | 230B |
| fn_12200_008.asm | camera_game_008 | game | medium | 64B |
| fn_12200_009.asm | camera_game_009 | game | medium | 74B |
| fn_12200_010.asm | camera_game_010 | game | medium | 70B |
| fn_12200_011.asm | camera_game_011 | game | medium | 70B |
| fn_12200_033.asm | camera_033 | game | medium | 52B |
| fn_12200_034.asm | camera_034 | game | medium | 48B |
| fn_12200_012.asm | sh2_comm_game_012 | sh2 | high | 64B |
| fn_12200_035.asm | sh2_comm_palette_load_035 | sh2 | high | 548B |
| fn_12200_036.asm | camera_dispatch_036 | game | medium | 424B |
| fn_12200_037.asm | sh2_comm_send_cmd_037 | sh2 | high | 138B |
| fn_12200_038.asm | camera_send_cmd_038 | game | high | 710B |
| fn_12200_013.asm | sh2_comm_game_013 | sh2 | high | 96B |
| fn_12200_039.asm | camera_039 | game | low | 430B |
| fn_12200_014.asm | camera_014 | game | low | 78B |
| fn_14200_038.asm | sh2_comm_cmd_27_038 | sh2 | high | 98B |
| fn_14200_039.asm | util_menu_039 | game | high | 356B |
| fn_14200_040.asm | util_dispatch_040 | game | medium | 52B |
| fn_14200_001.asm | util_game_001 | game | medium | 6B |
| fn_14200_041.asm | util_041 | game | low | 14B |
| fn_14200_042.asm | util_dispatch_042 | game | high | 94B |
| fn_14200_043.asm | util_menu_state_check_043 | game | high | 60B |
| fn_14200_044.asm | util_menu_state_check_044 | game | medium | 40B |
| fn_14200_045.asm | util_menu_state_check_045 | game | medium | 34B |
| fn_14200_046.asm | util_menu_state_check_046 | game | medium | 38B |
| fn_14200_047.asm | util_menu_state_check_047 | game | medium | 40B |
| fn_14200_048.asm | util_048 | game | low | 38B |
| fn_14200_002.asm | util_002 | game | low | 22B |
| fn_14200_003.asm | util_003 | game | low | 116B |
| fn_14200_004.asm | vdp_004 | vdp | medium | 58B |
| fn_14200_005.asm | vdp_005 | vdp | medium | 108B |
| fn_14200_049.asm | util_049 | game | low | 30B |
| fn_14200_006.asm | util_006 | game | low | 8B |
| fn_14200_007.asm | util_007 | game | low | 14B |
| fn_14200_008.asm | util_008 | game | low | 16B |
| fn_14200_009.asm | util_009 | game | low | 16B |
| fn_14200_010.asm | util_010 | game | low | 16B |
| fn_14200_011.asm | util_011 | game | low | 16B |
| fn_14200_012.asm | util_012 | game | low | 16B |
| fn_14200_013.asm | util_013 | game | low | 16B |
| fn_14200_014.asm | util_014 | game | low | 16B |
| fn_14200_015.asm | util_015 | game | low | 16B |
| fn_14200_016.asm | util_016 | game | low | 10B |
| fn_14200_017.asm | util_017 | game | low | 10B |
| fn_14200_018.asm | util_018 | game | low | 10B |
| fn_14200_019.asm | util_019 | game | low | 10B |
| fn_14200_020.asm | util_020 | game | low | 10B |
| fn_14200_021.asm | util_021 | game | low | 10B |
| fn_14200_022.asm | util_022 | game | low | 10B |
| fn_14200_023.asm | util_023 | game | low | 10B |
| fn_14200_024.asm | util_024 | game | low | 10B |
| fn_14200_025.asm | util_025 | game | low | 10B |
| fn_14200_026.asm | util_026 | game | low | 10B |
| fn_14200_027.asm | util_027 | game | low | 10B |
| fn_14200_028.asm | util_028 | game | low | 38B |
| fn_14200_029.asm | util_029 | game | low | 38B |
| fn_14200_030.asm | util_030 | game | low | 8B |
| fn_14200_031.asm | util_031 | game | low | 8B |
| fn_14200_032.asm | util_032 | game | low | 8B |
| fn_14200_033.asm | util_033 | game | low | 8B |
| fn_14200_034.asm | util_034 | game | low | 26B |
| fn_14200_035.asm | util_035 | game | low | 26B |
| fn_14200_036.asm | util_036 | game | low | 16B |
| fn_14200_037.asm | util_037 | game | low | 16B |
| fn_30200_001.asm | fm_init_channel_001 | sound | medium | 32B |
| fn_30200_002.asm | fm_set_volume_002 | sound | medium | 8B |
| fn_30200_003.asm | fm_sequence_process_003 | sound | high | 80B |
| fn_30200_004.asm | fm_004 | sound | low | 102B |
| fn_30200_005.asm | fm_005 | sound | low | 4B |
| fn_30200_006.asm | fm_write_port0_006 | sound | high | 116B |
| fn_30200_007.asm | fm_dispatch_007 | sound | low | 28B |
| fn_30200_008.asm | fm_dispatch_008 | sound | low | 26B |
| fn_30200_009.asm | fm_dispatch_009 | sound | medium | 104B |
| fn_30200_010.asm | fm_write_conditional_010 | sound | high | 202B |
| fn_30200_011.asm | fm_011 | sound | low | 52B |
| fn_30200_012.asm | fm_012 | sound | low | 80B |
| fn_30200_013.asm | fm_dispatch_013 | sound | medium | 98B |
| fn_30200_014.asm | fm_init_channel_014 | sound | high | 368B |
| fn_30200_015.asm | vdp_dispatch_015 | vdp | medium | 198B |
| fn_30200_016.asm | vdp_016 | vdp | medium | 228B |
| fn_30200_017.asm | fm_init_channel_017 | sound | high | 188B |
| fn_30200_018.asm | vdp_018 | vdp | medium | 106B |
| fn_30200_019.asm | fm_019 | sound | low | 22B |
| fn_30200_020.asm | fm_z80_dac_write_020 | sound | medium | 114B |
| fn_30200_021.asm | fm_write_conditional_021 | sound | high | 52B |
| fn_30200_022.asm | fm_write_port0_022 | sound | high | 64B |
| fn_30200_023.asm | fm_write_wrapper_023 | sound | medium | 80B |
| fn_30200_024.asm | fm_024 | sound | low | 148B |
| fn_30200_025.asm | fm_025 | sound | low | 24B |
| fn_30200_026.asm | fm_write_conditional_026 | sound | high | 24B |
| fn_30200_027.asm | fm_write_port0_027 | sound | high | 18B |
| fn_30200_028.asm | fm_028 | sound | low | 40B |
| fn_30200_029.asm | fm_029 | sound | low | 40B |
| fn_30200_030.asm | fm_z80_dac_write_030 | sound | medium | 160B |
| fn_30200_031.asm | fm_031 | sound | low | 6B |
| fn_30200_032.asm | fm_032 | sound | low | 174B |
| fn_30200_033.asm | vdp_sequence_process_033 | vdp | medium | 64B |
| fn_30200_034.asm | vdp_034 | vdp | medium | 116B |
| fn_30200_035.asm | fm_035 | sound | low | 14B |
| fn_30200_036.asm | fm_036 | sound | low | 18B |
| fn_30200_037.asm | vdp_037 | vdp | medium | 38B |
| fn_30200_038.asm | vdp_038 | vdp | medium | 24B |
| fn_30200_039.asm | fm_dispatch_039 | sound | low | 390B |
| fn_30200_040.asm | fm_z80_bus_request_040 | sound | medium | 22B |
| fn_30200_041.asm | fm_041 | sound | low | 12B |
| fn_30200_042.asm | fm_042 | sound | low | 32B |
| fn_30200_043.asm | fm_043 | sound | low | 32B |
| fn_30200_044.asm | fm_044 | sound | low | 6B |
| fn_30200_045.asm | fm_045 | sound | low | 36B |
| fn_30200_046.asm | fm_046 | sound | low | 28B |
| fn_30200_047.asm | fm_047 | sound | low | 24B |
| fn_30200_048.asm | fm_conditional_write_048 | sound | high | 92B |
| fn_30200_049.asm | fm_049 | sound | low | 6B |
| fn_30200_050.asm | fm_dispatch_050 | sound | high | 158B |
| fn_30200_051.asm | fm_dispatch_051 | sound | high | 120B |
| fn_30200_052.asm | fm_052 | sound | low | 60B |
| fn_30200_053.asm | fm_053 | sound | low | 18B |
| fn_30200_054.asm | fm_init_channel_054 | sound | high | 196B |
| fn_30200_055.asm | fm_055 | sound | low | 6B |
| fn_30200_056.asm | fm_056 | sound | low | 6B |
| fn_30200_057.asm | fm_057 | sound | low | 26B |
| fn_30200_058.asm | fm_058 | sound | low | 38B |
| fn_30200_059.asm | fm_059 | sound | low | 6B |
| fn_30200_060.asm | fm_conditional_write_060 | sound | medium | 28B |
| fn_30200_061.asm | fm_init_channel_061 | sound | high | 100B |
| fn_30200_062.asm | fm_conditional_write_062 | sound | medium | 92B |
| fn_30200_063.asm | fm_063 | sound | low | 26B |

## Needs Manual Review (Low Confidence)

258 modules could not be confidently categorized:

- **fn_200_003.asm** ($00063E, 86B): Object (A1): +$04 (speed_index/velocity), +$06 (speed), +$08, +$0B, +$80
- **fn_200_004.asm** ($000694, 40B): Short helper function. Object (A0): +$100
- **fn_200_006.asm** ($000C5A, 22B): Short helper function
- **fn_200_009.asm** ($000DC4, 14B): Short helper function
- **fn_200_011.asm** ($000FEA, 74B): Calls: io_port_init. Object (A0): +$01
- **fn_200_014.asm** ($001140, 130B): Object (A1): +$00, +$01
- **fn_200_015.asm** ($0011C2, 12B): Small leaf function
- **fn_200_016.asm** ($0011CE, 10B): Small leaf function
- **fn_200_017.asm** ($0011D8, 12B): Small leaf function
- **fn_200_018.asm** ($0011E4, 10B): Small leaf function
- **fn_200_019.asm** ($0011EE, 262B): State dispatcher using jump table. Object (A1): +$00
- **fn_200_020.asm** ($0012F4, 122B): State dispatcher using jump table
- **fn_200_021.asm** ($00136E, 70B): State dispatcher using jump table
- **fn_200_022.asm** ($0014BE, 34B): Short helper function. Calls: tile_decompress_init. Object (A0): +$04 (speed_ind
- **fn_200_023.asm** ($0014E0, 110B): State dispatcher using jump table. Object (A5): +$00
- **fn_200_024.asm** ($00154E, 56B): State dispatcher using jump table
- **fn_200_025.asm** ($001586, 138B): State dispatcher using jump table. Calls: bit_unpack_loop. Object (A1, A2, A4): 
- **fn_200_027.asm** ($0016B2, 220B): Function in 200 section (220 bytes)
- **fn_200_029.asm** ($0017D6, 14B): Short helper function
- **fn_200_031.asm** ($0019EA, 122B): Function in 200 section (122 bytes)
- **fn_200_033.asm** ($001A72, 88B): Function in 200 section (88 bytes)
- **fn_200_034.asm** ($001ACA, 74B): Function in 200 section (74 bytes)
- **fn_200_035.asm** ($001B14, 338B): Function in 200 section (338 bytes)
- **fn_200_043.asm** ($00203A, 16B): Short helper function
- **fn_200_044.asm** ($00204A, 20B): Short helper function
- **fn_200_045.asm** ($00205E, 8B): Small leaf function
- **fn_200_046.asm** ($002066, 24B): Short helper function
- **fn_200_047.asm** ($002080, 86B): Function in 200 section (86 bytes)
- **fn_200_048.asm** ($0020D6, 280B): Function in 200 section (280 bytes)
- **fn_2200_002.asm** ($002294, 22B): Short helper function. Calls: random_number_gen
- **fn_2200_003.asm** ($0022AA, 44B): Function in 2200 section (44 bytes)
- **fn_2200_004.asm** ($0022D6, 22B): Short helper function. Calls: random_number_gen
- **fn_2200_005.asm** ($0022EC, 40B): Short helper function
- **fn_2200_006.asm** ($002314, 22B): Short helper function. Calls: random_number_gen
- **fn_2200_008.asm** ($0023C2, 26B): Short helper function. Calls: random_number_gen
- **fn_2200_009.asm** ($0023DC, 48B): Function in 2200 section (48 bytes)
- **fn_2200_010.asm** ($00240C, 26B): Short helper function. Calls: random_number_gen
- **fn_2200_011.asm** ($002426, 44B): Function in 2200 section (44 bytes)
- **fn_2200_012.asm** ($002452, 26B): Short helper function. Calls: random_number_gen
- **fn_2200_013.asm** ($0024CA, 202B): Calls: unpack_tiles_vdp
- **fn_2200_014.asm** ($002594, 28B): Short helper function. Calls: tile_index_expand
- **fn_2200_015.asm** ($0025B0, 142B): Calls: unpack_tiles_vdp
- **fn_2200_016.asm** ($002652, 46B): Function in 2200 section (46 bytes)
- **fn_2200_020.asm** ($002878, 24B): Short helper function
- **fn_2200_024.asm** ($002AAA, 26B): Short helper function. Object (A0, A1): +$24, +$64, +$8C (velocity_x)
- **fn_2200_028.asm** ($002DCA, 42B): Object (A0, A1): +$24, +$64, +$8A (param_8a), +$8C (velocity_x)
- **fn_2200_029.asm** ($002DF4, 32B): Short helper function. Object (A0, A1): +$24, +$64, +$8C (velocity_x)
- **fn_2200_030.asm** ($002E14, 32B): Short helper function. Object (A0, A1): +$24, +$64, +$8C (velocity_x)
- **fn_2200_031.asm** ($002E34, 42B): Object (A0, A1): +$24, +$64, +$8A (param_8a), +$8C (velocity_x)
- **fn_2200_032.asm** ($002E5E, 32B): Short helper function. Object (A0, A1): +$24, +$64, +$8C (velocity_x)
- **fn_2200_033.asm** ($002E7E, 32B): Short helper function. Object (A0, A1): +$24, +$64, +$8C (velocity_x)
- **fn_2200_034.asm** ($002E9E, 20B): Short helper function. Object (A0, A1): +$24, +$8A (param_8a)
- **fn_2200_035.asm** ($002EB2, 20B): Short helper function. Object (A0, A1): +$24, +$8A (param_8a)
- **fn_2200_036.asm** ($002EC6, 40B): Short helper function. Object (A0, A1): +$14 (effect_duration), +$28, +$3C (head
- **fn_2200_037.asm** ($002EEE, 22B): Short helper function. Object (A1): +$14 (effect_duration), +$28, +$3C (heading_
- **fn_2200_042.asm** ($003160, 70B): Function in 2200 section (70 bytes)
- **fn_2200_047.asm** ($00337A, 106B): State dispatcher using jump table. Object (A0, A4): +$2C, +$88
- **fn_2200_055.asm** ($00385E, 8B): Small leaf function
- **fn_2200_057.asm** ($003924, 88B): Calls: collision_distance_calc. Object (A3): +$00
- **fn_2200_058.asm** ($00397C, 112B): Object (A2): +$00, +$02 (flags/type), +$06 (speed), +$0A (param_a), +$0E (param_
- **fn_2200_059.asm** ($0039EC, 82B): Object (A0, A1, A2): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 
- **fn_2200_060.asm** ($003A3E, 16B): Short helper function. Object (A1, A2): +$00, +$0A (param_a)
- **fn_2200_061.asm** ($003A4E, 100B): Object (A4): +$100
- **fn_2200_062.asm** ($003AB2, 118B): Object (A0, A1, A2): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 
- **fn_2200_064.asm** ($003C1A, 16B): Short helper function. Object (A1, A2): +$00, +$0A (param_a)
- **fn_2200_067.asm** ($003D22, 56B): Object (A1): +$00, +$14 (effect_duration), +$28, +$3C (heading_mirror)
- **fn_2200_068.asm** ($003D5A, 64B): Object (A1): +$04 (speed_index/velocity), +$08
- **fn_2200_078.asm** ($003F2E, 342B): Object (A0, A1, A2): +$00, +$10, +$C0 (render_flags)
- **fn_4200_010.asm** ($004C8A, 46B): Calls: pre_dispatch_common, WaitForVBlank
- **fn_4200_026.asm** ($0055FE, 26B): Orchestrator calling 3 subroutines. Calls: sfx_queue_process, poll_controllers
- **fn_4200_033.asm** ($0057CA, 6B): Small leaf function
- **fn_6200_009.asm** ($006B96, 52B): State dispatcher using jump table
- **fn_6200_010.asm** ($006BCA, 62B): Function in 6200 section (62 bytes)
- **fn_6200_011.asm** ($006C08, 30B): Short helper function
- **fn_6200_013.asm** ($006C46, 66B): Calls: FastCopy16
- **fn_6200_015.asm** ($006CDC, 8B): Small leaf function
- **fn_6200_016.asm** ($006CE4, 8B): Small leaf function
- **fn_6200_017.asm** ($006CEC, 10B): Small leaf function. Object (A1): +$04 (speed_index/velocity)
- **fn_6200_018.asm** ($006CF6, 10B): Small leaf function. Object (A1): +$04 (speed_index/velocity)
- **fn_6200_021.asm** ($006D8C, 16B): Short helper function
- **fn_6200_024.asm** ($00714A, 92B): Object (A0, A1, A2): +$00, +$02 (flags/type), +$19, +$1A (direction), +$1B, +$1D
- **fn_6200_030.asm** ($007624, 18B): Short helper function. Object (A0): +$CC
- **fn_6200_031.asm** ($007636, 24B): Short helper function. Object (A0): +$3C (heading_mirror), +$96, +$CC
- **fn_6200_033.asm** ($0076A2, 94B): Object (A1, A2): +$00, +$04 (speed_index/velocity), +$06 (speed), +$0A (param_a)
- **fn_6200_036.asm** ($007A40, 78B): State dispatcher using jump table. Object (A2): +$18
- **fn_6200_037.asm** ($007A8E, 4B): Small leaf function
- **fn_6200_038.asm** ($007A92, 8B): Small leaf function
- **fn_6200_039.asm** ($007A9A, 8B): Small leaf function
- **fn_6200_040.asm** ($007AA2, 8B): Small leaf function
- **fn_6200_041.asm** ($007AAA, 4B): Small leaf function
- **fn_6200_042.asm** ($007AAE, 4B): Small leaf function
- **fn_6200_043.asm** ($007AB2, 36B): Short helper function. Object (A0): +$32, +$C0 (render_flags), +$C6, +$C8
- **fn_6200_045.asm** ($007BE4, 78B): State dispatcher using jump table. Object (A2): +$18
- **fn_6200_046.asm** ($007C32, 4B): Small leaf function
- **fn_6200_047.asm** ($007C36, 4B): Small leaf function
- **fn_6200_048.asm** ($007C3A, 4B): Small leaf function
- **fn_6200_049.asm** ($007C3E, 4B): Small leaf function
- **fn_6200_050.asm** ($007C42, 4B): Small leaf function
- **fn_6200_051.asm** ($007C46, 4B): Small leaf function
- **fn_6200_052.asm** ($007C4A, 12B): Small leaf function. Object (A0): +$04 (speed_index/velocity)
- **fn_6200_053.asm** ($007C56, 130B): Object (A0): +$58, +$59, +$98, +$9A, +$E6, +$E8
- **fn_6200_058.asm** ($007E74, 48B): Object (A0): +$06 (speed), +$1C, +$55
- **fn_6200_059.asm** ($007EA4, 14B): Short helper function
- **fn_6200_061.asm** ($007EFC, 84B): Object (A0): +$1E, +$3C (heading_mirror)
- **fn_6200_063.asm** ($007FDA, 20B): Short helper function. Object (A0): +$02 (flags/type)
- **fn_6200_064.asm** ($007FEE, 22B): Short helper function. Object (A0): +$1C, +$2D
- **fn_6200_065.asm** ($008004, 46B): Object (A0): +$02 (flags/type), +$24, +$28, +$2C, +$2E
- **fn_6200_068.asm** ($0080AE, 30B): Short helper function. Object (A0): +$2D
- **fn_8200_002.asm** ($008246, 16B): Short helper function. Object (A0, A1): +$00, +$2C
- **fn_8200_003.asm** ($008256, 42B): Object (A0): +$02 (flags/type)
- **fn_8200_006.asm** ($0082E8, 18B): Short helper function
- **fn_8200_008.asm** ($008368, 18B): Short helper function
- **fn_8200_009.asm** ($00837A, 16B): Short helper function. Object (A4): +$04 (speed_index/velocity)
- **fn_8200_010.asm** ($00838A, 16B): Short helper function. Object (A4): +$04 (speed_index/velocity)
- **fn_8200_011.asm** ($0083BC, 10B): Small leaf function. Object (A0): +$02 (flags/type)
- **fn_8200_012.asm** ($0083C6, 30B): Short helper function. Object (A0): +$02 (flags/type)
- **fn_8200_014.asm** ($0084F4, 22B): Short helper function. Object (A2, A3): +$00
- **fn_8200_015.asm** ($00850A, 4B): Small leaf function
- **fn_8200_016.asm** ($00850E, 20B): Short helper function
- **fn_8200_017.asm** ($008522, 16B): Short helper function
- **fn_8200_018.asm** ($008532, 22B): Short helper function. Object (A4): +$04 (speed_index/velocity)
- **fn_8200_020.asm** ($0088BE, 176B): Function in 8200 section (176 bytes)
- **fn_8200_022.asm** ($008B28, 116B): Object (A2, A4, A6): +$00, +$78
- **fn_8200_023.asm** ($008C40, 112B): State dispatcher using jump table
- **fn_8200_024.asm** ($008CCE, 56B): State dispatcher using jump table. Object (A2): +$46 (display_scale)
- **fn_8200_025.asm** ($008D12, 38B): Short helper function
- **fn_8200_031.asm** ($008F4E, 58B): State dispatcher using jump table. Object (A0, A1): +$00, +$78
- **fn_8200_032.asm** ($009064, 56B): Object (A0): +$CC
- **fn_8200_035.asm** ($009458, 156B): Object (A0, A1): +$00, +$04 (speed_index/velocity), +$06 (speed), +$0A (param_a)
- **fn_8200_042.asm** ($009B82, 282B): State dispatcher using jump table. Object (A0): +$04 (speed_index/velocity), +$8
- **fn_8200_045.asm** ($009E5A, 20B): Short helper function. Object (A0): +$2A, +$A8
- **fn_a200_004.asm** ($00B0DE, 60B): Object (A0): +$01, +$02 (flags/type)
- **fn_a200_005.asm** ($00B11A, 68B): Function in a200 section (68 bytes)
- **fn_a200_006.asm** ($00B15E, 90B): Object (A0, A1): +$00, +$01, +$09
- **fn_a200_007.asm** ($00B1B8, 166B): Orchestrator calling 3 subroutines. Object (A1, A3): +$00
- **fn_a200_008.asm** ($00B25E, 122B): Function in a200 section (122 bytes)
- **fn_a200_009.asm** ($00B2D8, 36B): Short helper function. Object (A0, A1): +$00, +$2C
- **fn_a200_013.asm** ($00B3CE, 64B): Object (A3): +$00
- **fn_a200_014.asm** ($00B40E, 20B): Short helper function
- **fn_a200_015.asm** ($00B422, 26B): Short helper function. Object (A3): +$00
- **fn_a200_016.asm** ($00B43C, 60B): Object (A1, A3): +$01, +$02 (flags/type), +$03, +$04 (speed_index/velocity), +$0
- **fn_a200_017.asm** ($00B478, 82B): Object (A4): +$01, +$02 (flags/type), +$03, +$04 (speed_index/velocity), +$05, +
- **fn_a200_019.asm** ($00B590, 8B): Small leaf function
- **fn_a200_020.asm** ($00B598, 22B): Short helper function
- **fn_a200_021.asm** ($00B5AE, 86B): Object (A0, A1): +$00
- **fn_a200_022.asm** ($00B604, 46B): Object (A1): +$00
- **fn_a200_025.asm** ($00B722, 78B): Object (A0, A1, A2, A3): +$00, +$01, +$02 (flags/type)
- **fn_a200_027.asm** ($00B7E6, 8B): Small leaf function
- **fn_a200_029.asm** ($00B964, 22B): Short helper function
- **fn_a200_030.asm** ($00B97A, 22B): Short helper function
- **fn_a200_031.asm** ($00B990, 136B): Object (A1, A2): +$00, +$10, +$14 (effect_duration), +$16 (calc_speed), +$18, +$
- **fn_a200_032.asm** ($00BA1A, 68B): Object (A1): +$00
- **fn_a200_037.asm** ($00BD00, 42B): Object (A0, A1): +$02 (flags/type), +$10
- **fn_a200_039.asm** ($00BDD6, 40B): Short helper function. Object (A1): +$00, +$10
- **fn_a200_040.asm** ($00BDFE, 82B): State dispatcher using jump table. Object (A1, A2): +$02 (flags/type), +$04 (spe
- **fn_a200_041.asm** ($00BE50, 116B): State dispatcher using jump table. Object (A6): +$88
- **fn_a200_044.asm** ($00BF9E, 54B): Object (A1): +$00
- **fn_a200_045.asm** ($00BFD4, 10B): Small leaf function
- **fn_a200_046.asm** ($00BFDE, 64B): Object (A1): +$00
- **fn_a200_047.asm** ($00C01E, 10B): Small leaf function
- **fn_a200_048.asm** ($00C05C, 148B): Object (A1, A2): +$00, +$0C
- **fn_c200_006.asm** ($00C44C, 88B): State dispatcher using jump table
- **fn_c200_007.asm** ($00C4A4, 30B): Short helper function
- **fn_c200_009.asm** ($00C618, 74B): Function in c200 section (74 bytes)
- **fn_c200_016.asm** ($00CE76, 76B): Function in c200 section (76 bytes)
- **fn_c200_022.asm** ($00D3FC, 134B): State dispatcher using jump table
- **fn_e200_001.asm** ($00E5AC, 34B): Short helper function
- **fn_10200_014.asm** ($010606, 52B): Function in 10200 section (52 bytes)
- **fn_10200_015.asm** ($01063A, 28B): Short helper function
- **fn_10200_019.asm** ($010796, 182B): Function in 10200 section (182 bytes)
- **fn_10200_002.asm** ($01084C, 296B): Object (A0): +$00
- **fn_10200_030.asm** ($0118D4, 52B): Function in 10200 section (52 bytes)
- **fn_10200_031.asm** ($011908, 28B): Short helper function
- **fn_10200_033.asm** ($011942, 60B): Function in 10200 section (60 bytes)
- **fn_10200_034.asm** ($01197E, 28B): Short helper function
- **fn_10200_035.asm** ($01199A, 30B): Short helper function. Calls: name_entry_check
- **fn_10200_005.asm** ($0119B8, 164B): Function in 10200 section (164 bytes)
- **fn_10200_006.asm** ($011A5C, 20B): Short helper function
- **fn_10200_008.asm** ($011B6A, 276B): Object (A0, A1): +$01, +$02 (flags/type), +$03
- **fn_12200_016.asm** ($012534, 104B): Orchestrator calling 3 subroutines
- **fn_12200_017.asm** ($01259C, 52B): Function in 12200 section (52 bytes)
- **fn_12200_018.asm** ($0125D0, 28B): Short helper function
- **fn_12200_002.asm** ($01260A, 14B): Short helper function
- **fn_12200_003.asm** ($012C9E, 18B): Short helper function
- **fn_12200_004.asm** ($012CB0, 18B): Short helper function
- **fn_12200_006.asm** ($012F9C, 72B): Object (A3): +$39
- **fn_12200_032.asm** ($0135C4, 230B): Object (A0): +$00
- **fn_12200_039.asm** ($013FE0, 430B): Object (A3): +$00
- **fn_12200_014.asm** ($01418E, 78B): Object (A0, A1): +$00
- **fn_14200_041.asm** ($014400, 14B): Short helper function
- **fn_14200_048.asm** ($014540, 38B): Short helper function
- **fn_14200_002.asm** ($014566, 22B): Short helper function
- **fn_14200_003.asm** ($01457C, 116B): Function in 14200 section (116 bytes)
- **fn_14200_049.asm** ($014696, 30B): Short helper function
- **fn_14200_006.asm** ($0146B4, 8B): Small leaf function
- **fn_14200_007.asm** ($0146BC, 14B): Short helper function
- **fn_14200_008.asm** ($0146CA, 16B): Short helper function
- **fn_14200_009.asm** ($0146DA, 16B): Short helper function
- **fn_14200_010.asm** ($0146EA, 16B): Short helper function
- **fn_14200_011.asm** ($0146FA, 16B): Short helper function
- **fn_14200_012.asm** ($01470A, 16B): Short helper function
- **fn_14200_013.asm** ($01471A, 16B): Short helper function
- **fn_14200_014.asm** ($01472A, 16B): Short helper function
- **fn_14200_015.asm** ($01473A, 16B): Short helper function
- **fn_14200_016.asm** ($01474A, 10B): Small leaf function
- **fn_14200_017.asm** ($014754, 10B): Small leaf function
- **fn_14200_018.asm** ($01475E, 10B): Small leaf function
- **fn_14200_019.asm** ($014768, 10B): Small leaf function
- **fn_14200_020.asm** ($014772, 10B): Small leaf function
- **fn_14200_021.asm** ($01477C, 10B): Small leaf function
- **fn_14200_022.asm** ($014786, 10B): Small leaf function
- **fn_14200_023.asm** ($014790, 10B): Small leaf function
- **fn_14200_024.asm** ($01479A, 10B): Small leaf function
- **fn_14200_025.asm** ($0147A4, 10B): Small leaf function
- **fn_14200_026.asm** ($0147AE, 10B): Small leaf function
- **fn_14200_027.asm** ($0147B8, 10B): Small leaf function
- **fn_14200_028.asm** ($0147C2, 38B): Short helper function
- **fn_14200_029.asm** ($0147E8, 38B): Short helper function
- **fn_14200_030.asm** ($01480E, 8B): Small leaf function
- **fn_14200_031.asm** ($014816, 8B): Small leaf function
- **fn_14200_032.asm** ($01481E, 8B): Small leaf function
- **fn_14200_033.asm** ($014826, 8B): Small leaf function
- **fn_14200_034.asm** ($01482E, 26B): Short helper function
- **fn_14200_035.asm** ($014848, 26B): Short helper function
- **fn_14200_036.asm** ($014862, 16B): Short helper function
- **fn_14200_037.asm** ($014872, 16B): Short helper function
- **fn_30200_004.asm** ($0302EE, 102B): Object (A0, A5): +$00, +$03, +$0A (param_a), +$10, +$1C, +$1E
- **fn_30200_005.asm** ($030354, 4B): Small leaf function
- **fn_30200_007.asm** ($0303CC, 28B): State dispatcher using jump table. Object (A5): +$28
- **fn_30200_008.asm** ($0303E8, 26B): State dispatcher using jump table. Object (A5): +$28
- **fn_30200_011.asm** ($030536, 52B): Object (A0, A6): +$00, +$09, +$0A (param_a)
- **fn_30200_012.asm** ($03056A, 80B): Object (A6): +$09
- **fn_30200_019.asm** ($030A5C, 22B): Short helper function. Object (A6): +$04 (speed_index/velocity), +$06 (speed)
- **fn_30200_024.asm** ($030BF6, 148B): Object (A5): +$01
- **fn_30200_025.asm** ($030C8A, 24B): Short helper function. Object (A5): +$01
- **fn_30200_028.asm** ($030CCC, 40B): Short helper function. Object (A0, A5): +$01
- **fn_30200_029.asm** ($030CF4, 40B): Short helper function. Object (A0, A5): +$01, +$02 (flags/type), +$03
- **fn_30200_031.asm** ($030DEE, 6B): Small leaf function. Object (A6): +$38
- **fn_30200_032.asm** ($030E20, 174B): Orchestrator calling 9 subroutines. Object (A0, A5): +$00, +$04 (speed_index/vel
- **fn_30200_035.asm** ($030F82, 14B): Short helper function. Object (A5): +$12 (timer_12), +$13
- **fn_30200_036.asm** ($030F90, 18B): Short helper function. Object (A5): +$0C
- **fn_30200_039.asm** ($030FE0, 390B): State dispatcher using jump table. Object (A1, A4, A5, A6): +$09, +$16 (calc_spe
- **fn_30200_041.asm** ($03117C, 12B): Small leaf function. Object (A5): +$1E
- **fn_30200_042.asm** ($031188, 32B): Short helper function. Object (A5, A6): +$10, +$12 (timer_12), +$1E
- **fn_30200_043.asm** ($0311B8, 32B): Short helper function. Object (A5): +$01, +$27
- **fn_30200_044.asm** ($0311E2, 6B): Small leaf function. Object (A6): +$03
- **fn_30200_045.asm** ($0311E8, 36B): Short helper function. Object (A5): +$20, +$21, +$22, +$23, +$24, +$28
- **fn_30200_046.asm** ($03120C, 28B): Short helper function. Object (A5): +$01, +$09, +$27
- **fn_30200_047.asm** ($031228, 24B): Short helper function. Object (A5, A6): +$08, +$09
- **fn_30200_049.asm** ($0312A6, 6B): Small leaf function. Object (A6): +$0A (param_a)
- **fn_30200_052.asm** ($0313CA, 60B): Object (A5): +$0A (param_a), +$14 (effect_duration), +$18, +$19, +$1A (direction
- **fn_30200_053.asm** ($031406, 18B): Short helper function. Object (A5): +$01, +$0A (param_a)
- **fn_30200_055.asm** ($0314F6, 6B): Small leaf function. Object (A5): +$0A (param_a)
- **fn_30200_056.asm** ($0314FC, 6B): Small leaf function. Object (A5): +$0B
- **fn_30200_057.asm** ($03150E, 26B): Short helper function. Object (A5): +$2A
- **fn_30200_058.asm** ($031528, 38B): Short helper function. Object (A5): +$00, +$0D
- **fn_30200_059.asm** ($03154E, 6B): Small leaf function. Object (A5): +$02 (flags/type)
- **fn_30200_063.asm** ($031666, 26B): Short helper function. Object (A6): +$38, +$3A, +$3B
