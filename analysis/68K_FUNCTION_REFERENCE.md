# 68K Function Reference

Categorized reference for all named 68000 functions in Virtua Racing Deluxe.

**Note:** Function names are inferred from behavior analysis, not original debug symbols.
**Scope:** Reference catalog only; protocol details are in `analysis/68K_SH2_COMMUNICATION.md` and `analysis/architecture/MASTER_SLAVE_ANALYSIS.md`.

---

## Boot & Initialization ($000xxx - $001xxx)

| Address | Function | Description |
|---------|----------|-------------|
| $000200 | `entry_point` | ROM entry point |
| $000838 | `adapter_init` | 32X adapter initialization |
| $000C5A | `save_all_registers` | Save D0-D7/A0-A6 to memory |
| $000D68 | `warm_boot_init` | Warm boot/soft reset sequence |
| $000DC4 | `sound_update_check` | Conditional FM/DMA sound update |
| $000FEA | `z80_bus_vdp_init` | Z80 bus request + VDP register init |
| $0010C4 | `vdp_copy_rows` | Copy data rows to VDP |
| $0010F4 | `tile_decompress_init` | Initialize tile decompression |
| $0013B4 | `bit_unpack_loop` | Bit unpacking/RLE loop |
| $0014BE | `fm_write` | FM chip register write |
| $00155E | `sound_dma_transfer` | Sound DMA transfer |
| $0015EA | `sound_dma_setup` | Sound DMA setup |

---

## V-INT Handler ($001684 - $002xxx)

### Main Handler

| Address | Function | Description |
|---------|----------|-------------|
| $001684 | `vint_handler` | V-INT entry point |
| $0016B0 | `vint_early_exit` | RTE when no state change |
| $00170A | `vint_return` | RTE instruction |
| $00170C | `controller_port_init` | Initialize controller ports |
| $00179E | `poll_controllers` | Controller read + mode check (12 calls) |
| $0017EE | `button_remap` | Button remapping function |
| $00185E | `zbus_request` | Z-Bus request |
| $0018D8 | `io_port_init` | I/O port initialization for controllers |

### V-INT State Handlers

The V-INT handler uses a state machine at `$FFC87A`:

| Address | Function | State | Description |
|---------|----------|-------|-------------|
| $0019FE | `vint_state_common` | 0,1,2,8 | VDP sync + RAM |
| $001A64 | `vint_state_transition` | 11 | Set next state |
| $001A6E | `vint_state_minimal` | 4 | Quick VDP read |
| $001A72 | `vint_state_vdp_sync` | 5 | Full VDP sync |
| $001ACA | `vint_state_sprite_cfg` | 7 | Sprite config |
| $001B14 | `vint_state_vdp_config` | 10 | VDP config |
| $001BA8 | `vint_state_complex` | 12 | Complex VDP ops |
| $001C66 | `vint_state_fb_toggle` | 6 | Frame buffer toggle |
| $001E42 | `vint_state_fb_setup` | 9 | Frame buffer setup |
| $001E94 | `vint_state_fb_palette` | 13 | FB + palette |
| $001F4A | `vint_state_fb_dma` | 14 | FB DMA |
| $002010 | `vint_state_cleanup` | 15 | Clear SH2 flags |

---

## SH2 Communication ($00E1BC - $00E3FF)

These functions manage the 68K-SH2 communication protocol via COMM registers at `$A15120-$A1512F`.
See `analysis/68K_SH2_COMMUNICATION.md` for validated COMM usage and v2.3 protocol notes.

| Address | Function | Description |
|---------|----------|-------------|
| $00E1BC | `sh2_palette_load` | Load palette via SH2 (9 calls) |
| $00E22C | `sh2_graphics_cmd` | Graphics command to SH2 (14 calls) |
| $00E2E4 | `sh2_copy_routine` | SH2 memory copy (7 calls) |
| $00E2F0 | `sh2_load_data` | Data load via SH2 (10 calls) |
| $00E316 | `sh2_send_cmd_wait` | Wait for ready, send command |
| $00E342 | `sh2_wait_response` | Wait for SH2 response |
| $00E35A | `sh2_send_cmd` | Direct command send |
| $00E3B4 | `sh2_cmd_27` | SH2 command $27 submit (21 calls) |
| $00203A | `sh2_frame_sync` | SH2 frame sync wrapper |
| $0027DA | `sh2_framebuffer_prep` | 32X adapter framebuffer prep |
| $002890 | `sh2_comm_sync` | SH2 COMM register sync (3 calls) |
| $012260 | `sh2_wait_ready` | Wait for SH2 COMM ready |

---

## VDP & Display ($0027F8 - $0086xx)

| Address | Function | Description |
|---------|----------|-------------|
| $0027F8 | `VDPFill` | VDP fill operation |
| $00281E | `VDPPrep` | VDP preparation |
| $002878 | `PaletteRAMCopy` | Palette RAM copy |
| $0028C2 | `VDPSyncSH2` | VDP/SH2 synchronization |
| $002984 | `palette_update` | Palette color update (7 calls) |
| $003126 | `vdp_reg_write` | VDP register write (9 calls) |
| $003160 | `vdp_dma_setup` | VDP DMA setup (7 calls) |
| $0031A6 | `display_mode_dispatch` | Display mode dispatcher (6 calls) |
| $008548 | `vdp_operation` | VDP operation |
| $00859A | `vdp_write` | VDP write |

### Tile Operations

| Address | Function | Description |
|---------|----------|-------------|
| $00247C | `unpack_tiles_vdp` | Nibble expand to VDP (24 calls) |
| $0024AE | `tile_index_expand` | Expand nibbles to tile indices |
| $0073E8 | `tile_position_calc` | Tile buffer position (9 calls) |

---

## Memory Operations ($003xxx - $004xxx)

### Fill Operations

| Address | Function | Description |
|---------|----------|-------------|
| $0036DE | `clear_buffer` | Clear buffer |
| $0037B6 | `memory_copy` | Memory copy |
| $003F86 | `clear_display_vars` | Clear viewport params (11 calls) |
| $004836 | `QuadMemoryFill` | Quad memory fill |
| $00483A | `MemoryFillWaterfall1` | Memory fill waterfall 1 |
| $00483E | `MemoryFillWaterfall2` | Memory fill waterfall 2 |
| $004842 | `MemoryFill60A1` | Memory fill 60A1 |
| $004846 | `MemoryFill60A4` | Memory fill 60A4 |
| $004856 | `UnrolledFill96` | Unrolled fill 96 |
| $00485E | `UnrolledFill112` | Unrolled fill 112 |
| $0048B8 | `UnrolledFill32` | Unrolled fill 32 |
| $0048CA | `TripleMemoryFill` | Triple memory fill |
| $0048CE | `MemoryFillWaterfall3` | Memory fill waterfall 3 |
| $0048D2 | `MemoryFillWaterfall4` | Memory fill waterfall 4 |
| $0048FE | `UnrolledFill60` | Unrolled fill 60 |
| $004920 | `FastCopy20` | Fast copy 20 bytes |
| $004922 | `FastCopy16` | Fast copy 16 bytes |

### Utility Operations

| Address | Function | Description |
|---------|----------|-------------|
| $004998 | `WaitForVBlank` | Wait for V-blank |
| $0049AA | `SetDisplayParams` | Set display parameters |
| $00496E | `random_number_gen` | PRNG using $EF00.W (6 calls) |
| $0049EE | `reset_scroll_vars` | Clear scroll variables (3 calls) |

---

## Game Initialization ($006200)

Entry point uses jump table for 7 initialization states:

| Address | Function | Description |
|---------|----------|-------------|
| $006200 | `game_logic_entry` | Main entry with jump table |
| $00625A | `init_state_0` | Minimal init + main loop |
| $006292 | `init_state_1` | Full system initialization |
| $00633A | `init_state_2` | Partial initialization |
| $006394 | `init_state_3` | Alternate partial init |
| $00640E | `init_state_4` | Display mode initialization |
| $006496 | `init_state_5` | Alternate display mode |
| $0065BC | `init_state_6` | Extended initialization |
| $006C46 | `sprite_table_init` | Initialize sprite table from ROM |

---

## Object System ($007xxx - $008xxx)

### Position & Movement

| Address | Function | Description |
|---------|----------|-------------|
| $006F98 | `calc_steering` | Steering/velocity calc (19 calls) |
| $0070AA | `angle_to_sine` | Trig table lookup (29 calls) |
| $007084 | `obj_position_update` | Update object positions (5 calls) |
| $00714A | `transform_calc` | Transform calculation |
| $0071A6 | `obj_screen_coord` | Object screen position (9 calls) |
| $00734E | `alt_screen_coord` | Alternate coord (SH2) (7 calls) |
| $00748C | `angle_normalize` | Angle normalization (8 calls) |
| $0074A4 | `sprite_list_process` | Sprite list iterator (6 calls) |
| $0075C8 | `vector_dot_product` | Vector dot product calc (3 calls) |
| $0075E0 | `vector_dot_conditional` | Conditional dot product (4 calls) |
| $0075FE | `obj_distance_calc` | Distance calculation (11 calls) |
| $007534 | `velocity_apply` | Velocity application (6 calls) |
| $007624 | `obj_angle_calc` | Object angle calculation (7 calls) |
| $00764E | `render_prep` | Render preparation |
| $007816 | `obj_collision_test` | Object collision test (11 calls) |
| $00789C | `obj_frame_calc` | Object frame calculation (6 calls) |
| $007A40 | `obj_type_dispatch` | Object type jump table (4 calls) |
| $007AB6 | `obj_heading_update` | Object heading/angle init (10 calls) |

### Velocity Updates

| Address | Function | Description |
|---------|----------|-------------|
| $007C4E | `obj_position_y` | Y position update (18 calls) |
| $007CD8 | `obj_position_x` | X position update (18 calls) |
| $007E7A | `obj_velocity_y` | Y velocity update (18 calls) |
| $007EA4 | `player_target_verify` | Player target comparison (3 calls) |
| $007F04 | `obj_bounds_check` | Object boundary check (11 calls) |
| $007F50 | `obj_velocity_x` | X velocity update (18 calls) |

### Object Rendering

| Address | Function | Description |
|---------|----------|-------------|
| $0080CC | `load_object_params` | Object table lookup (27 calls) |
| $008032 | `race_position_check` | Race position delta check (5 calls) |
| $008170 | `object_frame_timer` | Frame countdown handler (22 calls) |
| $002C9A | `obj_render_check` | Check if object should render |
| $002CDC | `obj_transform_copy` | Copy object position/scale to buffers |
| $002DCA | `obj_texture_select` | Select object texture from $C748/$C74C |
| $002E34 | `obj_texture_select_alt` | Alternate texture select from $C75C/$C760 |
| $002E9E | `obj_palette_select` | Select object palette ($C724/$C750) |
| $002EB2 | `obj_palette_select_alt` | Alternate palette select ($C758/$C764) |
| $002EC6 | `obj_visibility_check` | Check/set object visibility flags |
| $002F04 | `obj_position_copy` | Copy object position data to buffers |
| $003010 | `obj_render_flags_set` | Set object render flags from $00C0(A0) |

---

## State Management ($008200)

| Address | Function | Description |
|---------|----------|-------------|
| $008200 | `state_mgmt_entry` | State management entry |
| $00825C | `time_compare_display` | Time comparison display |
| $0082FA | `result_comparison` | Race result comparison |
| $00839A | `num_to_decimal` | Number to decimal conversion |
| $0084F4 | `time_compare_indexed` | Compare time against indexed table value |
| $00850E | `time_overflow_check` | Handle time display overflow (>60min) |
| $008548 | `timer_countdown` | 8 independent game timers |
| $0086C8 | `state_jump_indexed` | Indexed state jump (9 calls) |
| $0086FE | `state_dispatch_alt` | Alternate state dispatch (6 calls) |
| $008F4E | `state_dispatch_prep` | State dispatch setup (9 calls) |
| $008F52 | `state_dispatch_vdp` | VDP state dispatcher (9 calls) |

---

## Game Logic ($009xxx - $00Bxxx)

### Core Update Functions

| Address | Function | Description |
|---------|----------|-------------|
| $009040 | `view_offset_calc` | Camera/view offset calc (7 calls) |
| $009064 | `view_bounds_check` | Camera bounds checking (6 calls) |
| $009182 | `input_process` | Input processing |
| $009312 | `timer_update` | Timer update |
| $00961E | `state_machine` | State machine dispatch |
| $009688 | `timer_process` | Game timer processing (9 calls) |
| $009802 | `game_update` | Game update loop |
| $009B12 | `movement_calc` | Movement calculation |
| $009B54 | `physics_calc` | Physics calculation |
| $009CCE | `math_routine` | Math routine |
| $009E6E | `obj_proximity_check` | Object proximity comparison (10 calls) |
| $009EC0 | `state_jump_table` | State dispatcher via $C8AC (7 calls) |

### AI & Physics ($00Axxx)

| Address | Function | Description |
|---------|----------|-------------|
| $00A144 | `game_state_handler` | Game state handler (5 calls) |
| $00A1FC | `race_state_read` | Race state from $C8CA (10 calls) |
| $00A200 | `physics_lookup_tables` | Speed/acceleration tables |
| $00A350 | `effect_timer_mgmt` | Effect timers management |
| $00A3BA | `speed_calculation` | Table-based speed lookup |
| $00A434 | `ai_opponent_select` | AI opponent targeting |
| $00A470 | `collision_avoidance` | Steering/braking adjustments |
| $00A666 | `physics_integration` | 3D position calculations |
| $00A7A0 | `ai_steering_calc` | AI steering calculation (6 calls) |
| $00A8F8 | `obj_state_return` | Object state return (5 calls) |
| $00AC3E | `effect_countdown` | Effect timer at $C8AE (11 calls) |
| $00ACC0 | `race_mode_flag_set` | Set race mode flag at $FF6970 |
| $00ACD4 | `ai_target_check` | AI opponent targeting (9 calls) |

### Object & Animation ($00Bxxx)

| Address | Function | Description |
|---------|----------|-------------|
| $00B09E | `animation_update` | Animation update |
| $00B684 | `object_update` | Object update |
| $00B6DA | `sprite_update` | Sprite update |
| $00B770 | `select_sprite_buffer` | Sprite buffer select (11 calls) |
| $00B77C | `sprite_buffer_alt` | Alt sprite buffer (6 calls) |

---

## Master Sequencer ($00C200)

| Address | Function | Description |
|---------|----------|-------------|
| $00C200 | `master_sequencer` | Scene flow controller |
| $002080 | `pre_dispatch_common` | Common pre-dispatch function |
| $0020C6 | `sound_flag_handler` | Sound flag handling (5 calls) |
| $00C662 | `scene_state_dispatch` | Scene state jump table dispatcher |
| $00C870 | `scene_transition` | Scene state transition (5 calls) |
| $00CC06 | `object_array_init` | Initialize object array from ROM table |

---

## Sound System ($00D1D4, $030xxx)

### 68K Sound Interface

| Address | Function | Description |
|---------|----------|-------------|
| $00D1D4 | `sound_init` | FM chip initialization |
| $0021CA | `sfx_queue_process` | Sound effect queue handler (9 calls) |
| $0094FA | `sound_trigger` | Sound trigger |

### FM Chip Functions ($030xxx)

| Address | Function | Description |
|---------|----------|-------------|
| $0302EE | `fm_sequence_process` | FM sound sequence processor |
| $030C8A | `fm_init_channel` | FM channel init (5 calls) |
| $030CA2 | `fm_conditional_write` | Conditional FM write (7 calls) |
| $030CBA | `fm_write_wrapper` | FM write with bus release (8 calls) |
| $030CCC | `fm_write_conditional` | Conditional FM register write (13 calls) |
| $030CD8 | `fm_write_port0` | FM chip register write (9 calls) |
| $030D1C | `z80_bus_request` | Z80 bus request + wait (13 calls) |
| $030DF4 | `z80_dac_write` | Z80 bus request + DAC write |
| $030FB2 | `fm_set_volume` | FM volume control (5 calls) |

---

## DMA & Transfer ($00E52C)

| Address | Function | Description |
|---------|----------|-------------|
| $00E52C | `dma_transfer` | DMA transfer |

---

## Menu System ($00E466 - $00F4xx)

| Address | Function | Description |
|---------|----------|-------------|
| $00E466 | `text_render` | Text/digit rendering |
| $00E90C | `track_select_menu` | Track selection dispatcher |
| $00EA0E | `menu_input_handler` | Menu navigation input |
| $00F41C | `options_menu` | Options/difficulty menu |
| $0145F0 | `menu_state_check` | Menu state check (6 calls) |

---

## Results & Attract Mode ($0101xx)

| Address | Function | Description |
|---------|----------|-------------|
| $01012E | `results_screen` | Results/statistics screen |
| $01014E | `attract_mode` | Replay/attract mode |

---

## Name Entry ($010838 - $012xxx)

| Address | Function | Description |
|---------|----------|-------------|
| $010838 | `name_input_handler` | Grid navigation input |
| $011122 | `name_entry_main` | Name entry dispatcher |
| $011144 | `name_entry_alt` | Alternate entry mode |
| $01116C | `name_entry_sub` | Sub-state handler |
| $0118D4 | `time_digit_render` | Time display digit render (3 calls) |
| $011942 | `name_digit_render` | Name entry digit render (3 calls) |
| $011A98 | `name_entry_check` | Name entry state check (5 calls) |
| $012062 | `name_confirm` | Name confirmation |

---

## Race & Camera ($012200)

| Address | Function | Description |
|---------|----------|-------------|
| $012200 | `race_camera_module` | Camera system entry |
| $01231C | `camera_scroll_update` | Update camera scroll position |
| $012A40 | `race_camera_dispatcher` | Camera state machine |

---

## Sprite System

| Address | Function | Description |
|---------|----------|-------------|
| $0058C8 | `sprite_input_check` | Sprite/input validation (6 calls) |
| $005908 | `sprite_update_check` | Sprite update conditional (6 calls) |
| $00593C | `sprite_state_process` | Sprite state processing (6 calls) |
| $0059EC | `table_lookup` | Table lookup |

---

## Collision & Distance

| Address | Function | Description |
|---------|----------|-------------|
| $0039EC | `collision_distance_calc` | Calculate collision distances |
| $003CC4 | `player_table_load` | Load player pointers (6 calls) |

---

## Summary Statistics

- **Total named functions:** 503+
- **Categories:** 15 major categories
- **Most called functions:**
  1. `angle_to_sine` - 29 calls (trig lookup)
  2. `load_object_params` - 27 calls (object table)
  3. `unpack_tiles_vdp` - 24 calls (tile expansion)
  4. `object_frame_timer` - 22 calls (frame countdown)
  5. `sh2_cmd_27` - 21 calls (SH2 graphics command)
  6. `calc_steering` - 19 calls (steering calculation)
  7. `obj_velocity_x/y`, `obj_position_x/y` - 18 calls each

---

## Related Documentation

- [STATE_MACHINES.md](architecture/STATE_MACHINES.md) - State machine details
- [68K_SH2_COMMUNICATION.md](68K_SH2_COMMUNICATION.md) - Communication protocol (validated)
- [DATA_STRUCTURES.md](architecture/DATA_STRUCTURES.md) - Memory structures
- [VINT_HANDLER_ARCHITECTURE.md](architecture/VINT_HANDLER_ARCHITECTURE.md) - V-INT handler details

---

**Document Status:** Reference catalog
**Last Updated:** 2026-01-24
