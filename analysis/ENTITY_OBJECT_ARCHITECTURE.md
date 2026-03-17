# Entity/Object Architecture — Virtua Racing Deluxe (32X)

## 1. Overview

The entity system is a **dual-layer architecture**: 68K-side entity tables in Work RAM ($FF9000-$FF9FFF) hold game state, which is projected into a display object array ($FF6218) and then DMA-transferred to SH2 SDRAM for 3D rendering.

**46 modules** across `disasm/modules/68k/object/` (11) and `disasm/modules/68k/game/entity/` (35).

**Key characteristics:**
- 4 object tables: Player, AI (15 entities), Secondary (8), Special (1)
- Fixed 256-byte records ($100 stride) — simplifies address arithmetic
- 20-subroutine per-frame pipeline for the player entity
- Type dispatch via RAM indirection table at $C05C (runtime-reconfigurable)
- Display objects ($FF6218, 60B stride) are the final 68K output before SH2 transfer
- All display data sent to SH2 in a single 2560-byte FIFO burst per frame

---

## 2. 68K Object Tables

Four tables in Work RAM, all using 256-byte ($100) stride:

| Table | Base | Entries | Size | Purpose | Init Function |
|-------|------|---------|------|---------|---------------|
| **0 (Player)** | `$FF9000` | 16 | 4KB | Player entity + world state | `object_entry_loader_loop_table_lookup`, `object_entries_reset_init_fixed_table` |
| **1 (AI)** | `$FF9100` | 15 | 3840B | AI opponent entities | `object_table_init_entry_array` (ROM $00898A7C) |
| **2 (Secondary)** | `$FF9700` | 8 | 2KB | Trackside objects | `object_table_clear_loop` |
| **3 (Special)** | `$FF9F00` | 1 | 256B | 2P alternate / camera target | `dual_object_entry_init_primary_alternate` |

**Tables 0 and 3 are paired:** `dual_object_entry_init_primary_alternate` ($00CE02) initializes both from the same ROM data but with different counter phases (Table 0: counters=15, Table 3: counters=0). Table 3 is used for 2-player alternate viewport, trackside proximity checks, and collision detection.

**Table 1 initialization:** `object_table_init_entry_array` ($00CD4C) reads ROM table at $00898A7C indexed by game mode ($C8A0), fills 15 entries with staggered phase counters at +$A4/+$A6 (0-15 modular), sprite sub-index at +$C2, and model data at +$24 from $C710.

**Table 1 speed data:** `entity_table_load` ($00A7E2) copies speed attributes from ROM $00938F2E (indexed by mode) into entity +$0A (max speed) and +$B6 (speed attribute) for all 15 entries.

**Reference counts:** $9000 appears in 47 locations/22 files; $9100 in 14/9; $9700 in 5/4; $9F00 in 16/11.

---

## 3. Entity Record Field Map (256 Bytes)

Each entity occupies $100 bytes. Fields consolidated from all modules:

| Offset | Size | Name | Primary Users |
|--------|------|------|---------------|
| +$02 | word | flags | Control bits (6=inactive, 11=collision, 12-13=direction) |
| +$04 | word | speed | Base speed / velocity index |
| +$06 | word | display_speed | Visible speed / entity type |
| +$0A | word | max_speed | Speed cap (from entity_table_load) |
| +$0E | word | x_tilt | Banking / interpolation target |
| +$10 | word | z_tilt / drag | Tilt or drag coefficient |
| +$14 | word | boost_timer | Countdown for speed boost |
| +$16 | word | calc_speed | Computed effective speed |
| +$18 | long | data_ptr | ROM data pointer (from init) |
| +$1C | word | frame_counter | Entity index / frame counter |
| +$1E | word | heading | Current heading angle |
| +$20 | word | target_x | Target position X |
| +$22 | word | target_y | Target position Y |
| +$24 | word | track_pos_a | Track segment position |
| +$26 | word | track_pos_b | Secondary track position |
| +$2C | long | lap_counter | Control / lap data |
| +$2E | word | counter | Guard counter (decremented) |
| +$30 | word | **x_position** | World X coordinate |
| +$32 | word | y_sub | Sub-position / height |
| +$34 | word | **y_position** | World Y coordinate |
| +$36 | word | prev_x | Previous frame X (binary search) |
| +$38 | word | prev_y | Previous frame Y |
| +$3A | word | lateral_force | Sine-computed lateral |
| +$3C | word | heading_mirror | Active heading |
| +$3E | word | longitudinal | Cosine-computed depth |
| +$40 | word | heading_angle | Canonical heading |
| +$42 | word | prev_heading | Previous heading (binary search) |
| +$44 | word | display_offset | Cleared each frame |
| +$46 | word | display_scale | Cleared each frame |
| +$48 | word | prev_scale | Previous scale (binary search) |
| +$4A | word | display_aux | Cleared each frame |
| +$4C | word | slip_angle | Angle between heading and velocity |
| +$4E | word | velocity_z | Z velocity component |
| +$50 | word | velocity_y | Y velocity component |
| +$52 | word | velocity_x | X velocity component |
| +$54 | word | steering_flags | Steering mode bits |
| +$55 | byte | collision_combined | OR of 4 probe results |
| +$56-$59 | bytes | probe_flags | Individual collision probe results |
| +$5A | word | probe_1_height | EMA smoothed surface |
| +$5C | word | probe_2_height | EMA smoothed |
| +$5E | word | probe_3_height | EMA smoothed |
| +$62 | word | mode | Multi-use: timer, drift active, collision state |
| +$64 | word | drift_angle | Angular delta during drift |
| +$66 | word | drift_target | Target angle for drift |
| +$68 | word | drift_direction | -1 (left) or +1 (right) |
| +$6A | word | collision_state | Lateral collision |
| +$6E | word | roll / height_offset | Roll/height for display |
| +$72 | word | lateral_offset | Cross-product rotation result |
| +$74 | word | raw_speed | Gear-scaled speed (0-17000) |
| +$76 | word | camera_dist | Camera follow distance |
| +$78 | word | grip | 8.8 fixed-point ($0100 = 1.0) |
| +$7A | word | gear | Gear index (0-6) |
| +$7E | word | target_speed | Smoothed speed (rate-limited) |
| +$80 | word | sound_timer | Sound trigger cooldown |
| +$82 | word | brake_timer | Brake sound cooldown |
| +$86 | word | ai_cooldown | Opponent select cooldown |
| +$88 | word | direction_flags | 4-bit directional push |
| +$89 | byte | zone_bits | Angle-based visibility (4 bits) |
| +$8C | word | guard_field | Guard check field |
| +$8E | word | steering_velocity | 8.8 fixed-point |
| +$90 | word | drift_rate | Steering × speed derivative |
| +$92 | word | slide | Slide / drift cooldown |
| +$94 | word | lateral_velocity | Force-integrated lateral |
| +$96 | word | position_offset | Display-mapped lateral |
| +$A4 | word | target_index_1 | Primary target entity |
| +$A6 | word | target_index_2 | Secondary target |
| +$A8 | word | speed_state | Multiplier chain selector |
| +$AA | word | drift_accum | Drift accumulator (0-200) |
| +$AE | word | entity_type | Type dispatch index |
| +$B0 | word | spawn_timer | AI spawn countdown (120 frames) |
| +$B2 | long | stored_position | Copied to +$18 per frame |
| +$B6 | word | speed_attribute | From entity_table_load |
| +$BC | word | decel / rotation | Deceleration or rotation |
| +$C0 | word | render_state | Active flag / render dispatch |
| +$C1 | byte | sprite_type | Sprite definition index |
| +$C2 | word | sprite_sub | Sprite sub-index |
| +$C4 | word | angular_value | Display angular parameter |
| +$C6 | word | forward_height | Directional probe EMA |
| +$C8 | word | adjacent_height | Directional probe EMA |
| +$CC | word | distance_result | Distance calc output |
| +$CE | long | link_ptr / tile_center | BSP link / center tile data |
| +$D2 | long | tile_ptr_1 | Probe 1 tile data |
| +$D6 | long | tile_ptr_2 | Probe 2 tile data |
| +$DA | long | tile_ptr_3 | Probe 3 tile data |
| +$DE | long | tile_ptr_4 | Probe 4 tile data |
| +$E2 | word | longitudinal_offset | Cross-product output |
| +$E4 | byte | flip_flag | Table select (0 or 1) |
| +$E5 | byte | entity_flags | bit 0=flip, bit 3=visibility, bits 1-2=AI type |

---

## 4. Entity Lifecycle

### 4.1 Initialization

```
game_mode_track_config
  → object_entry_loader_loop_table_lookup (Table 0: 16 entries from ROM)
  → object_table_init_entry_array (Table 1: 15 AI entities from ROM $00898A7C)
  → dual_object_entry_init_primary_alternate (Table 0 + Table 3)
  → entity_table_load (speed attributes from ROM $00938F2E)
  → object_array_init_rom_tables (15 display objects at $FF6218)
```

### 4.2 Per-Frame Update

`race_entity_update_loop` dispatches to pipeline variants via a 10-entry jump table indexed by `$C07A`:

| Entry | Handler | Pipeline |
|-------|---------|----------|
| 0-3 | `entity_render_pipeline` A-D | Decreasing complexity |
| 4 | `player_entity_frame_update` | Full 20-subroutine pipeline |
| 5-9 | 2P mode variants | Split-screen variants |

Override: if bit 7 of $C81C set, forces entry [4] (full player pipeline).

### 4.3 Type Dispatch (`entity_type_dispatch`, $A8E0)

Two-level dispatch for AI behavior:

```
type_index = entity+$AE                    // entity type
secondary = RAM_table[$C05C + type_index×2] // RAM indirection
handler = ROM_table[$A8D4 + secondary×4]   // handler pointer
JSR handler
```

ROM handler table has 3 entries, all into `ai_entity_main_update_orch`:
- Entry 1: $A972 (main AI update)
- Entry 2: $AB88 (spawn timer state)
- Entry 3: $ABCE (finish/retirement state)

The RAM table at $C05C allows runtime reconfiguration of entity-to-handler mappings per track/mode.

### 4.4 Visibility

Two visibility systems:
- **`object_visibility`** ($002EC6): 6 slots at 20B stride from A1 display buffer. Checks $C31C flag + E5 bit 3.
- **`entity_visibility_check`** ($002C9A): 4 slots at offsets $118/$12C/$140/$154 into A2 buffer. Tests entity active flag (+$C0), writes display parameters.

---

## 5. Per-Frame Pipeline (Player Entity)

`player_entity_frame_update` ($005D08, 192 bytes) runs 20 subroutines:

| # | Function | Purpose |
|---|----------|---------|
| 1 | `field_check_guard` | Skip if +$8C = 0 |
| 2 | `timer_decrement_multi` | Decrement multiple timers |
| 3 | `suspension_steering_damping` | Steering physics damping |
| 4 | `object_anim_timer_speed_clear+6` | Animation timer |
| 5 | `entity_pos_update` | Position integration → collision |
| 6 | `multi_flag_test` | AND collision probe flags |
| 7 | `angle_to_sine` | Heading → sine for movement |
| 8 | `object_link_copy_table_lookup` | Follow link ptr, copy fields |
| 9 | `rotational_offset_calc` | Cross-product rotation |
| 10 | `position_threshold_check` | Position comparison + guard |
| 11 | `race_pos_sorting+50` | Race position sort |
| 12 | `effect_countdown` | Effect timer decrement |
| 13 | `set_camera_regs_to_invalid` | Invalidate camera |
| 14 | `proximity_zone_multi+54` | Multi-zone proximity |
| 15 | `heading_from_position` | XY → heading |
| 16 | JSR $0081D8 | Unknown function |
| 17 | `obj_distance_calc` | Distance computation |
| 18 | `object_visibility_collector` | Visibility state |
| 19 | `camera_param_calc` | Camera parameters |
| 20 | `object_state_disp_0031a6` | State dispatch |

Then 3 render output functions:
- `object_table_sprite_param_update` — entity → display object conversion
- `object_proximity_check_jump_table_dispatch` — proximity-based rendering
- `render_slot_setup+88` — render slot configuration

---

## 6. SH2 Entity Descriptors

The SH2 side has **separate** entity descriptors, distinct from 68K object tables:

| Address | Stride | Entries | Purpose |
|---------|--------|---------|---------|
| `$0600C344` | $14 (20B) | 5+ | SH2 entity descriptors (rendering loop 1) |
| `$0600C3A8` | $14 | — | Entity descriptor group 2 |
| `$0600C448` | $14 | — | Entity descriptor group 3 |
| `$0600C800` | $10 (16B) | 32 | Huffman renderer entity data |

These are populated by the SH2 cmd $02 handler (scene orchestrator) from DMA-transferred data, NOT directly from 68K entity tables.

---

## 7. 68K → SH2 Data Flow

### Step 1: Entity Tables → Display Objects

`object_table_sprite_param_update` ($0036DE) iterates 15 entities (Table 1, stride $100) and writes to display object array at $FF6218 (stride $3C = 60 bytes):

**Display Object Layout (60 bytes each):**

| Offset | Source | Description |
|--------|--------|-------------|
| +$00 | computed | Visibility flag 1 |
| +$02 | entity +$30 | Speed / world X |
| +$04 | entity +$32 + camera | Angle offset |
| +$06 | entity +$34 | World Y / heading |
| +$08 | entity +$3A >> 3 | Lateral offset (negated) |
| +$0A | entity +$3C + +$6E >> 3 | Height with roll |
| +$0C | entity +$3E >> 3 | Depth offset (negated) |
| +$0E | — | Secondary table value |
| +$10 | ROM $008958E4 | Sprite definition pointer |
| +$14 | computed | Visibility flag 2 |
| +$1C | entity +$BC >> 3 | Rotation |
| +$28 | computed | Visibility flag 3 |
| +$30 | entity +$C4 >> 3 | Angular value |

### Step 2: Display Objects → SH2 via MARS DMA FIFO

`mars_dma_xfer_vdp_fill` ($0028C2) transfers 2560 bytes ($500) from $FF6000 region:

```
1. Set MARS DREQ length to $500
2. Write command $0102 (scene orchestrator) to COMM0
3. Poll COMM1_LO bit 1 for ACK
4. Stream data via 10 block copy calls:
   $FF6000-$FF60C7: System/camera state
   $FF6100-$FF617F: Viewport A (camera + world coords)
   $FF6218-$FF65FF: Display objects (15 × $3C) + render slots
   $FF6330-$FF6447: Viewport B (alternate/2P)
   $FF6448-$FF64AB: Render slot config
   $FF6800+: VDP register work area
```

### Step 3: SH2 Processing

Master SH2 cmd $02 handler receives DMA data, writes to SDRAM. Slave SH2 rendering pipeline reads entity descriptors from SDRAM for 3D transform → frustum cull → rasterize.

---

## 8. Display Buffers

| Address | Size | Purpose |
|---------|------|---------|
| `$FF6000-$FF60C7` | 200B | System/camera state block |
| `$FF60C0-$FF60D0` | 16B | Display list (track_graphics_loader init) |
| `$FF6100-$FF617F` | 128B | Viewport A: camera + world coordinates |
| `$FF6218-$FF6578` | 864B | Display object array (15 × 60B) |
| `$FF6330-$FF6447` | 280B | Viewport B: alternate/2P data |
| `$FF6448-$FF64AB` | 100B | Render slot configuration |
| `$FF6800-$FF6830` | 48B | SH2 objects (3 × $10) |
| `$FF6900+` | varies | Display entries (racers) |

---

## 9. Cross-References

- **Entity → Physics:** Per-frame pipeline calls steering, force integration, tilt, drift, pos_update. See [PHYSICS_SYSTEM_ARCHITECTURE.md](PHYSICS_SYSTEM_ARCHITECTURE.md)
- **Entity → AI:** Type dispatch routes to `ai_entity_main_update_orch`. See [AI_SYSTEM_ARCHITECTURE.md](AI_SYSTEM_ARCHITECTURE.md)
- **Entity → Collision:** `entity_pos_update` JMPs to `collision_response_surface_tracking`. See [COLLISION_SYSTEM_ARCHITECTURE.md](COLLISION_SYSTEM_ARCHITECTURE.md)
- **Entity → Rendering:** Display objects at $FF6218 are DMA-transferred to SH2. See [RENDERING_PIPELINE.md](RENDERING_PIPELINE.md)
- **Entity → Memory:** Object table clearing uses `QuadMemoryFill`. See [MEMORY_MANAGEMENT_ARCHITECTURE.md](MEMORY_MANAGEMENT_ARCHITECTURE.md)
