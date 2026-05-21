# Track Data Format — Virtua Racing Deluxe (32X)

## 1. Overview

The track data system converts 2D world positions into track surface properties (tile type, height, curvature). It uses a **segmented spline model** with paged auxiliary data: 4 data pages spaced $800 bytes apart, segment records of 5 longwords + 9 words, and two table modes (normal/alternate) selected by game mode.

**4 core modules** in `disasm/modules/68k/game/track/`:
- `track_data_index_calc_table_lookup` — tile address computation (11+ call sites, hot path)
- `track_data_extract_033` — 4-page geometry extraction
- `track_segment_load_031` — segment record loader for AI path following
- `track_graphics_and_sound_loader` — init-only visual asset loading

**Supporting scene modules** handle initialization:
- `game_mode_track_config` — pre-computes mode/track index variants
- `scene_dispatch_track_data_setup` — populates segment buffer from ROM tables
- `scene_camera_init` — sets track data pointer from ROM

---

## 2. Track RAM Variables

| Address | Size | Name | Written By | Read By |
|---------|------|------|------------|---------|
| `$C02E` | 24B | work_buffer | track_data_extract_033 | collision system |
| `$C04C` | word | track_mode | track_segment_load_031 (clears to 0) | — |
| `$C054` | word | track_pos_hi | track_segment_load_031 | menu segment scroll |
| `$C056` | word | track_pos_lo | track_segment_load_031 | menu segment scroll |
| `$C268` | long | track_data_ptr | scene_camera_init (from ROM $00930612) | track_data_extract_033, zone_check_inner |
| `$C710-$C720` | 20B | segment_data_buf | scene_dispatch_track_data_setup | track_segment_load_031, entity init |
| `$C734` | long | segment_word_ptr | scene_dispatch_track_data_setup | track_segment_load_031, display list setup |
| `$C744` | long | segment_table_ptr | scene init (part of $C700+ block) | track_segment_load_031 |
| `$C89C` | word | game_mode | game_mode_track_config | — |
| `$C89E` | word | game_mode_x2 | game_mode_track_config | — |
| `$C8A0` | word | game_mode_x4 | game_mode_track_config | track_data_index_calc |
| `$C8B0-$C8BA` | 6 words | segment_scroll_vals | menu scroll functions | menu segment add/subtract |
| `$C8BC` | word | segment_base_index | various | track_segment_load_031 |
| `$C8C8` | word | track_number | game_mode_track_config | — |
| `$C8CA` | word | track_x2 | game_mode_track_config | — |
| `$C8CC` | word | track_x4 | game_mode_track_config | scene_dispatch_track_data_setup, scene_camera_init |

---

## 3. Segment Index Computation

**Function:** `track_data_index_calc_table_lookup`
**ROM:** $0073E8-$00742C (68 bytes)
**Source:** [track_data_index_calc_table_lookup.asm](disasm/modules/68k/game/track/track_data_index_calc_table_lookup.asm)

This is the **hot-path function** (11+ call sites per frame) that converts 2D position into a track tile address.

**Algorithm:**
```
Input: D1 = X component, D2 = Y component, A0+$E4 = table select flag
Output: A1 = pointer to track tile data

D3 = $400                         // base offset (center of track grid)
D4 = D1 >> 4                     // scale X
D4 = D4 + D3                     // offset from center
D4 = D4 >> 5                     // column index (32-unit grid cells)
D5 = D2 >> 4                     // scale Y
D3 = D3 + D5                     // row offset
D3 = D3 & $FFE0                  // align to 32-byte boundary
D3 = D3 << 1                     // scale for word entries
D3 = D3 + D4                     // combine row + column
D3 = D3 + D3                     // ×2 for word-sized table entries

// Select pointer table based on game mode and table flag:
D0 = [$C8A0] × 2                 // game_mode × 8 (already ×4, doubled)
if A0+$E4 == 0:
    A2 = normal_table @ $00742C
else:
    A2 = alternate_table @ $00745C

// Two-level lookup:
A1 = [A2 + D0]                   // segment_map_ptr (longword from table)
D3 = [A1 + D3]                   // word offset from segment map
A1 = [A2 + D0 + 4]               // base_data_ptr (longword from table)
D3 = D3 × 2                      // scale offset
A1 = A1 + D3                     // final tile data address
```

**Inline ROM Tables (96 bytes total at $00742C-$00748B):**

Normal table at $00742C — 6 longword pairs (one per game mode × 2):
```
Mode 0: segment_map = $0094C000, base_data = $00970000
Mode 1: segment_map = $0094C000, base_data = $00970000  (same)
Mode 2: ...
```

Alternate table at $00745C — same format, mostly zeroed for unused modes.

**Callers (11 sites):**
- `track_boundary_collision_detection`: 5 calls (center + 4 probes)
- `directional_collision_probe`: 3 calls (forward, adjacent, center)
- `visibility_eval_caller`: 1 call
- `race_init_orch_005`: 1 call

---

## 4. Segment Data Layout

**Function:** `track_segment_load_031`
**ROM:** $00B990-$00BA18 (136 bytes)
**Source:** [track_segment_load_031.asm](disasm/modules/68k/game/track/track_segment_load_031.asm)

Loads a complete segment record into an output buffer (A2). Used by AI path-following code.

**Algorithm:**
```
Input: D0 = segment offset, A2 = output buffer
Reads: $C744 (table ptr), $C8BC (base index), $C303 (sub-index)

A1 = [$C744]                     // segment table base
D0 = D0 + [$C8BC]                // add base index
A1 = [A1 + D0]                   // dereference to segment entry
sub_idx = [$C303] × 4            // sub-index (longword stride)
position = [A1 + sub_idx]        // position longword
$C054 = position.hi              // track_pos_hi
$C056 = position.lo              // track_pos_lo

// Copy 5 longwords from segment data buffer:
A2[$10] = [$C710]
A2[$24] = [$C714]
A2[$38] = [$C718]
A2[$4C] = [$C71C]
A2[$60] = [$C720]

// Copy 9 words from segment word pointer:
A1 = [$C734]
A2[$16,$18,$1A] = (A1)[0,1,2]    // 3 words
A2[$2A,$2C,$2E] = (A1)[3,4,5]    // 3 words
A2[$3E,$40,$42] = (A1)[6,7,8]    // 3 words

// Initialize 5 counters to 1:
A2[$00] = A2[$14] = A2[$28] = A2[$3C] = A2[$50] = 1
$C04C = 0                        // clear track_mode
```

**Output buffer stride pattern** (5 sub-segments, 20 bytes apart):

| Sub-Seg | Counter | Longword | Words (3) |
|---------|---------|----------|-----------|
| 0 | A2+$00 | A2+$10 | A2+$16, $18, $1A |
| 1 | A2+$14 | A2+$24 | A2+$2A, $2C, $2E |
| 2 | A2+$28 | A2+$38 | A2+$3E, $40, $42 |
| 3 | A2+$3C | A2+$4C | (no words for sub-seg 3) |
| 4 | A2+$50 | A2+$60 | (no words for sub-seg 4) |

**Callers:** `ai_timer_dec_cond_state_clear.asm:16`, `ai_timer_dec_state_clear_reactivate.asm:16`

---

## 5. Multi-Page Data Extraction

**Function:** `track_data_extract_033`
**ROM:** $0076A2-$007700 (94 bytes)
**Source:** [track_data_extract_033.asm](disasm/modules/68k/game/track/track_data_extract_033.asm)

Extracts signed byte pairs from 4 pages of 3D track geometry data. Each page is $800 bytes (2KB) from the previous, containing curvature/normal/gradient data per segment.

**Algorithm:**
```
Input: D0 = track segment index (pre-shifted)
Reads: $C268 (track_data_ptr)
Writes: work buffer at $C02E (24 bytes)

A1 = [$C268]                     // track data base
offset = (D0 >> 6) × 2           // segment stride
A1 = A1 + offset

// Page 0:
$C02E+$00 = sign_extend(A1[0])   // signed byte → word
$C02E+$04 = sign_extend(A1[1])

// Page 1 (A1 += $7FF):
$C02E+$06 = sign_extend(A1[0])
$C02E+$0A = sign_extend(A1[1])

// Page 2 (A1 += $7FF):
$C02E+$0C = sign_extend(A1[0])
$C02E+$10 = sign_extend(A1[1])

// Page 3 (A1 += $7FF):
$C02E+$12 = sign_extend(A1[0])
$C02E+$16 = sign_extend(A1[1])
```

The `$7FF` increment (not $800) accounts for the `(A1)+` post-increment on the first byte read of each pair.

**Work buffer layout at $C02E:**

| Offset | Page | Byte | Likely Meaning |
|--------|------|------|----------------|
| +$00 | 0 | 0 | Curvature X |
| +$04 | 0 | 1 | Curvature Y |
| +$06 | 1 | 0 | Normal X |
| +$0A | 1 | 1 | Normal Y |
| +$0C | 2 | 0 | Gradient X |
| +$10 | 2 | 1 | Gradient Y |
| +$12 | 3 | 0 | Reserved X |
| +$16 | 3 | 1 | Reserved Y |

**Caller:** `track_boundary_collision_detection` at $0078A8

---

## 6. Track Graphics and Sound Loading

**Function:** `track_graphics_and_sound_loader`
**ROM:** $00C7C2-$00C8E6 (292 bytes)
**Source:** [track_graphics_and_sound_loader.asm](disasm/modules/68k/game/track/track_graphics_and_sound_loader.asm)

Init-only function with two entry points. Loads track-specific visual assets and palette data during scene setup.

**Entry 1 (main, $00C7C2):**
- Loads from ROM tables at `$0089B6AC` / `$0089B73C` indexed by track
- Copies 54 longwords (216 bytes) of palette data
- Initializes 10+ sound/timing state variables
- Calls sound driver

**Entry 2 (+$AE = $00C870):**
- Loads track overlay graphics from 3 ROM tables:
  - `$00895488` (normal modes)
  - `$008954F4` (mode-specific)
  - `$00895560` (alternate mode)
- All indexed by `$C89C` (game_mode)
- Configures display viewport
- Clears display list at `$FF60C0-$FF60D0`

**Callers (5 sites):** All `race_scene_init_*` modules

---

## 7. Initialization Data Flow

```
game_mode_track_config (D0=mode, D1=track)
  → $C89C/C89E/C8A0 = mode, ×2, ×4
  → $C8C8/C8CA/C8CC = track, ×2, ×4
  → $C826 = multiplayer flag
        |
        v
scene_camera_init (uses $C8CC)
  → $C268 = track_data_ptr (from ROM $00930612)
  → $C700+ region populated (includes $C710, $C734, $C744)
        |
        v
scene_dispatch_track_data_setup (uses $C8CC)
  → $C710 = segment data buffer (from ROM $008957A0/$008956C8)
  → 4 display list blocks at $FF6114/$FF6218/$FF6344/$FF6448
        |
        v
track_graphics_and_sound_loader (uses $C89C)
  → Palette data (54 longs)
  → Overlay graphics
  → Display list at $FF60C0-$FF60D0
```

**Runtime hot path:**
```
track_data_index_calc_table_lookup (×11/frame)
  Position → tile address via $C8A0 + ROM pointer tables

track_data_extract_033 (×1/frame via collision)
  Tile → 4-page geometry extraction to $C02E work buffer

track_segment_load_031 (called by AI)
  $C744 table + $C8BC index → 5L+9W segment record
```

---

## 8. Per-Track ROM Data Tables

| ROM Address | Purpose | Indexed By |
|-------------|---------|------------|
| `$00742C` | Normal segment map/base pointer pairs (inline) | `$C8A0` (mode×4, doubled) |
| `$00745C` | Alternate segment map/base pointer pairs (inline) | `$C8A0` |
| `$00930612` | Track data base pointers (road geometry) | `$C8CC` (track×4) |
| `$0094C000` | Segment map (tile grid → offset lookup) | Computed 2D index |
| `$00970000` | Base track data (tile properties) | Offset from segment map |
| `$008957A0` | Track segment base table | `$C8CC` |
| `$008956C8` | Track segment alt table | `$C8CC` |
| `$0089B6AC` | Track graphics data | Track index |
| `$0089B73C` | Track palette data (54 longs per track) | Track index |
| `$00895488` | Overlay graphics (normal) | `$C89C` (mode) |
| `$008954F4` | Overlay graphics (mode-specific) | `$C89C` |
| `$00895560` | Overlay graphics (alternate) | `$C89C` |
| `$0129E0-$012A1F` | Per-track parameter tables (3 × 16 words) | Track index |

---

## 9. Menu Track Segment System

A parallel subsystem manages 6 scroll accumulators for menu/UI track preview:

| Seg | Value | Accumulator | Add Func | Sub Func |
|-----|-------|-------------|----------|----------|
| 0 | `$C8B0` | `$C056` | $01474A | $014754 |
| 1 | `$C8B2` | `$C086` | $01475E | $014768 |
| 2 | `$C8B4` | `$C0B0` | $014772 | $01477C |
| 3 | `$C8B6` | `$C0AE` | $014786 | $014790 |
| 4 | `$C8B8` | `$C0B2` | $01479A | $0147A4 |
| 5 | `$C8BA` | `$C054` | $0147AE | $0147B8 |

All initialized to `$0080` by `initialize_track_segment_values_to_center` at $0147E8.

**Note:** Segments 0 and 5 share `$C054`/`$C056` with the race-mode track position system. These are only used during menu display, not during racing.
