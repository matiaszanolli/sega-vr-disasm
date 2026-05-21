# Collision System Architecture — Virtua Racing Deluxe (32X)

## 1. Overview

The collision system handles three distinct subsystems: **track boundary detection** (center + 4-probe with binary search response), **object-to-object collision** (weighted speed averaging), and **proximity zones** (4-level Manhattan distance classification).

**23 modules** in `disasm/modules/68k/game/collision/`, ~3KB total code.

**Key characteristics:**
- 4-iteration binary search resolves collision to 1/4-frame precision
- EMA surface tracking: `new = (old + height) / 2` for temporal smoothing
- Manhattan distance (|dX|+|dY|) throughout — no Euclidean distance
- 4-level proximity zones with bit-15 flag for critical proximity
- Called from `entity_pos_update` via JMP (no RTS boundary from physics)

---

## 2. Track Boundary Collision

### 2.1 5-Point Probe System (`track_boundary_collision_detection`, $789C)

**ROM:** $00789C-$007A40 (420 bytes)
**Source:** [track_boundary_collision_detection.asm](disasm/modules/68k/game/collision/track_boundary_collision_detection.asm)

Probes 5 points per frame: center + 4 directional offsets.

**Center probe:**
1. Computes heading + scale from entity fields
2. Extracts track geometry via `track_data_extract_033` (4-page, work buffer at $C02E)
3. Tile lookup via `track_data_index_calc_table_lookup`
4. Stores tile data pointer in +$CE, surface type byte, probe coordinates

**4 directional probes** (front-left, front-right, rear-left, rear-right):
1. Adds pre-computed offset from RAM (negative word addresses -16338 through -16316) to entity position
2. Performs tile lookup
3. **Same-tile optimization:** If same tile as center (compare A1 pointers), tries fast boundary check (`angle_normalize+168`) first, then full check (`angle_normalize+24`). Avoids redundant tile lookups.
4. On collision: stores tile pointer (+$D2/+$D6/+$DA/+$DE), classifies surface via `object_type_dispatch`, stores per-probe flag (+$56/+$57/+$58/+$59)

**Flag combination:** Final = `probe1 | probe2 | probe3 | probe4` → +$55

**Callers:** `collision_response_surface_tracking` (up to 5 calls during binary search)

---

## 3. Binary Search Response (`collision_response_surface_tracking`, $7700)

**ROM:** $007700-$00789C (412 bytes)
**Source:** [collision_response_surface_tracking.asm](disasm/modules/68k/game/collision/collision_response_surface_tracking.asm)

The most sophisticated algorithm in the collision system. Resolves the precise collision point via **4-iteration binary search**.

### Algorithm

```
1. INITIAL DETECTION:
   Call track_boundary_collision_detection (5-probe)
   If collision active (+$62 > 0) OR any probe hit (+$55 bit 0):
     → enter binary search

2. COMPUTE 1/4 DELTAS:
   For heading(+$40), scale(+$46), X(+$30), Y(+$34):
     delta = (current - previous) / 4

3. RESET TO PREVIOUS FRAME:
   Restore all 4 values from previous-frame snapshots (+$42, +$48, +$36, +$38)

4. BINARY SEARCH (4 iterations):
   for i = 0..3:
     advance by 1/4 step
     call track_boundary_collision_detection
     if +$55 bit 0 set (collision):
       revert last 1/4 step
       break

5. SNAPSHOT:
   Save current values as previous for next frame

6. SURFACE TRACKING (EMA):
   For 4 probe points:
     height = plane_eval(probe_position)
     probe_height = (old_height + height) / 2    // alpha = 0.5
   Store: +$5A, +$5C, +$5E (probe heights), +$32 (center height)
```

### Fields Rolled Back During Search

| Field | Current | Previous | Delta |
|-------|---------|----------|-------|
| Heading | +$40 | +$42 | (current-prev)/4 |
| Scale | +$46 | +$48 | (current-prev)/4 |
| X position | +$30 | +$36 | (current-prev)/4 |
| Y position | +$34 | +$38 | (current-prev)/4 |

---

## 4. Surface Tracking

After binary search resolution, evaluates surface height at each probe point using `plane_eval`, then smooths with exponential moving average:

```
new_height = (old_height + eval_height) / 2
```

Alpha = 0.5 provides temporal smoothing, preventing height jitter on rough terrain.

**Output fields:**
- +$5A: probe 1 height
- +$5C: probe 2 height
- +$5E: probe 3 height
- +$32: center height (y_sub)

---

## 5. Directional Collision Probes (`directional_collision_probe`, $7AD6)

**ROM:** $007AD6-$007BAC (214 bytes)
**Source:** [directional_collision_probe.asm](disasm/modules/68k/game/collision/directional_collision_probe.asm)

Heading-aligned probing for terrain preview:

1. **Forward probe:** Offset from heading angle via ROM table at $0093661E (256 entries, 2 bytes each: signed x,y). Index = `(heading + scale) >> 6`. Evaluates surface height, EMA smooth → +$C6.

2. **Adjacent probe:** Offsets by $7FF entries (~90°) in same table. EMA smooth → +$C8.

3. **Center probe:** Entity's own position as fallback. Same-tile optimization.

---

## 6. Object-to-Object Collision (`object_collision_detection`, $AF18)

**ROM:** $00AF18-$00AFC2 (170 bytes)
**Source:** [object_collision_detection.asm](disasm/modules/68k/game/collision/object_collision_detection.asm)

Player (A0) vs opponent at $9F00 (A1):

```
1. ALREADY-ACTIVE CHECK:
   sum = accel_x + velocity_x (both entities)
   if nonzero → skip (already processing)

2. DISTANCE GATE:
   if |lateral_offset_diff| >= $200 → skip

3. PROXIMITY TEST:
   call zone_check_inner
   if no collision → skip

4. SOUND TRIGGER: $B8 → $C8A4

5. SPEED COMPARISON:
   if |speed_diff| <= threshold ($C8CE):
     call position_separation (gentle push)
     return

6. WEIGHTED SPEED AVERAGE:
   faster = speed_sum × 3/4              // clamp to $04DC
   slower = speed_sum × 3/8              // clamp to $04DC
   assign based on which entity was faster

7. COLLISION FLAGS:
   if velocity_gap > $C8D0 threshold:
     set bit $0800 in both entities' +$02
```

---

## 7. Proximity System

### 7.1 Zone Classification (4 Levels)

| Zone | Value | Bit 15 | Meaning |
|------|-------|--------|---------|
| Far | $0000 | 0 | Outside all thresholds |
| Approaching | $0003 | 0 | Within outer threshold |
| Near | $0002 | 0 | Within middle threshold |
| Inner 1 | $8001 | 1 | Closest range |
| Inner 2 | $8002 | 1 | Close (critical) |

Callers can test bit 15 with `BMI` for fast critical-proximity detection.

### 7.2 Variants

**`proximity_zone_loop`** ($877A, 104 bytes): Fixed thresholds $140/$2C0/$1000. Iterates 15 entities at $9100 with $100 stride. Writes zone to entity +$C0.

**`proximity_zone_multi`** ($86C8, 178 bytes): Camera override (uses $C0BA/$C0BE if nonzero). Flag-dependent threshold sets:
- Normal: $140/$1C0/$400/$800
- Wide: $800/$FA0
- Alternate: $2C0/$1000
4 zone levels including $8002.

**`proximity_zone_simple`** ($8672, 86 bytes): Single entity pair, thresholds $200/$1000.

**`proximity_check_simple`** ($39EC, 82 bytes): 3D range test + sprite data copy.

### 7.3 15-Entity Iteration

`proximity_zone_loop` scans all 15 entities in Table 1 ($FF9100, stride $100):
```
for i = 0..14:
  entity = $9100 + i × $100
  dist = |entity.x - ref.x| + |entity.y - ref.y|    // Manhattan
  zone = classify(dist)
  entity.zone = zone
```

---

## 8. Rotational Offset (`rotational_offset_calc`, $764E)

**ROM:** $00764E-$0076A2 (84 bytes)

Standard 2D rotation matrix for billboard rendering:

```
lateral    = -(cos × dX + sin × dY) >> 8    → +$72
longitudinal = (sin × dX - cos × dY) >> 8   → +$E2
```

Uses `sine_cosine_quadrant_lookup`, heading from +$1E, target from +$20/+$22, position from +$30/+$34.

---

## 9. Angle-Based Visibility (`zone_check_inner`, $AE06)

**ROM:** $00AE06-$00AED6 (210 bytes)

Two symmetric passes using a 2KB lookup table at `($C268)`:
- **Pass 1:** A1's facing vs A0's position → 4 zone bits in A0+$89
- **Pass 2:** A0's facing vs A1's position → 4 zone bits in A1+$89
- Each pass advances $800 bytes (2KB) through the table per zone

Bounding boxes from RAM: $C8E4-$C8EA (pass 1), $C8EC-$C8F2 (pass 2).

---

## 10. Entity Field Map (Collision-Relevant)

| Offset | Size | Name | Written By |
|--------|------|------|------------|
| +$30 | word | x_position | Binary search rollback, position_separation |
| +$32 | word | y_sub | Surface tracking EMA (center) |
| +$34 | word | y_position | Binary search rollback, position_separation |
| +$36 | word | prev_x | Snapshot (for binary search) |
| +$38 | word | prev_y | Snapshot |
| +$40 | word | heading | Binary search rollback |
| +$42 | word | prev_heading | Snapshot |
| +$46 | word | scale | Binary search rollback |
| +$48 | word | prev_scale | Snapshot |
| +$55 | byte | combined_flag | OR of all 4 probe results |
| +$56-$59 | 4 bytes | per_probe_flags | Individual probe collision results |
| +$5A | word | probe_1_height | EMA smoothed surface height |
| +$5C | word | probe_2_height | EMA smoothed |
| +$5E | word | probe_3_height | EMA smoothed |
| +$62 | word | collision_active | Active collision sequence |
| +$72 | word | lateral_offset | rotational_offset_calc |
| +$88 | word | collision_result | object_collision_detection |
| +$89 | byte | zone_bits | zone_check_inner (4 angle bits) |
| +$C0 | word | proximity_zone | proximity_zone_loop |
| +$C6 | word | forward_height | directional_collision_probe EMA |
| +$C8 | word | adjacent_height | directional_collision_probe EMA |
| +$CE | long | tile_ptr_center | Center tile data |
| +$D2 | long | tile_ptr_1 | Probe 1 tile data |
| +$D6 | long | tile_ptr_2 | Probe 2 tile data |
| +$DA | long | tile_ptr_3 | Probe 3 tile data |
| +$DE | long | tile_ptr_4 | Probe 4 tile data |
| +$E2 | word | long_offset | rotational_offset_calc (longitudinal) |

---

## 11. Cross-Subsystem Interfaces

- **Physics → Collision:** `entity_pos_update` ($6F98) tail-calls `collision_response_surface_tracking` ($7700) via JMP
- **Collision → Track:** `track_boundary_collision_detection` calls `track_data_index_calc_table_lookup` (5× per binary search iteration) and `track_data_extract_033` (1×)
- **AI → Collision:** `ai_target_check` calls `proximity_distance_check` → `zone_check_inner`
- **Collision → AI:** `close_position_flags` sets AI mode $B2 and direction bits
- **Collision → Sound:** `object_collision_detection` triggers sound $B8
