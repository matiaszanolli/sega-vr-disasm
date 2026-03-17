# AI System Architecture — Virtua Racing Deluxe (32X)

## 1. Overview

The AI system controls opponent vehicles using a **15-state machine** with timer-based advancement, **3-band Manhattan distance collision avoidance**, and a **4-band distance-based approach ramp** for spawn-to-active transitions.

**27 modules** in `disasm/modules/68k/game/ai/`, ~2.5KB total code.

**Key characteristics:**
- 15-state machine at `$FFA0EA` (120-frame timer per state, cyclic 3-phase pattern)
- Manhattan distance (|dX|+|dY|) for all proximity — cheap to compute on 68K
- `collision_avoidance_speed_calc` falls through directly to `physics_integration` (no RTS)
- atan2 approximation for heading computation
- 4-slot race position system with spawn/active/retire lifecycle

---

## 2. AI Entity Lifecycle

### 2.1 Race Slot System

4 slots managed via table at RAM `$FFC03C`:

| State | Value | Meaning |
|-------|-------|---------|
| Empty | 0 | Slot available |
| Finished | 1 | Entity completed race |
| Ready | 2 | Assigned, not yet spawned |
| Active | 3 | Entity racing |
| Retiring | 4 | Fade-out in progress |

### 2.2 Spawn Phase

`ai_entity_main_update_orch` ($00A972) manages the spawn sequence:

1. **Target lookup:** Reads spawn target from slot/difficulty tables
2. **Visibility ramp:** `visibility = (120 - timer) × $3BBB >> 16`
3. **Race state trigger:** At visibility=20, calls `race_state_read`
4. **Activation:** When timer expires, advances slot to state 3 (active)

### 2.3 4-Band Approach Ramp

Distance from spawn point to target position determines approach speed:

| Band | Distance | Speed | Y Offset |
|------|----------|-------|----------|
| 1 | <128 | $20 (slow) | 0 |
| 2 | 128-384 | `dist×3/16 + 8` | -64 |
| 3 | 384-1024 | `dist/8 + $20` | -128 |
| 4 | >1024 | `dist/16 + $64` (max 200) | -128 |

### 2.4 Retirement

Scans slot table for reorder opportunities (lower slots with state==1, upper slots with state==4), then retires entity, clearing slot.

---

## 3. State Machine

**Dispatch:** `ai_state_dispatch` at $00BE50 (116 bytes)
**State variable:** `$FFA0EA` (word, steps by 4)
**Timer variable:** `$FFA0EC` (word)

15-entry jump table. Entry 0 is the timer handler (counts to 120 frames, then advances state by 4, resets timer). Entries 1-13 form a **repeating 3-phase cycle**:

```
Entries 2, 5, 8, 11 → Phase A handler
Entries 3, 6, 9, 12 → Phase B handler
Entries 4, 7, 10, 13 → Phase C handler
Entry 14 → Terminal state
```

State advance: `addq.w #4,($A0EA).w` + `clr.w ($A0EC).w`
(Two identical copies at $BFD4 and $C01E)

---

## 4. Steering System

### 4.1 atan2 Approximation (`ai_steering_calc`, $00A7A0)

```
DX = target_x - entity_x
DY = target_y - entity_y

if DY == 0: return ±$4000 (90 degrees)

ratio = (DX × 256) / DY         // fixed-point tangent
angle = atan2_lookup(ratio)      // table-based
return 16-bit angle ($0000-$FFFF = full circle)
```

Shared by AI, physics, and camera subsystems.

Source: [ai_steering_calc.asm](disasm/modules/68k/game/ai/ai_steering_calc.asm)

### 4.2 Heading Convergence

```
heading_delta = (target_heading - current_heading) / steering_factor
heading += heading_delta
```

- `steering_factor` = `max(1, frames_to_target / 2)` — longer distances use gentler steering
- Override: if `+$54` bit 0 set, force `steering_factor = 2`
- Convergence rate: 1/4 per frame (`ASR.W #2`)

### 4.3 Turn Rate Clamping

- Maximum: +/-$140 per frame
- Dead zone: heading zeroed if |heading| < $100 (prevents oscillation)

---

## 5. Collision Avoidance

`collision_avoidance_speed_calc` ($00A470, 502 bytes) — the primary AI combat logic.

**Critical:** This function has **no RTS** — it falls through directly to `physics_integration` at $A666.

Source: [collision_avoidance_speed_calc.asm](disasm/modules/68k/game/ai/collision_avoidance_speed_calc.asm)

### 5.1 Speed Computation ($A470-$A4AC)

Loads entity data pointer (+$18), computes speed from table index (+$24) with modifier from speed table at `$C280`. Default speed = 150 ($96).

### 5.2 Proximity Gate ($A4AE)

Tests bit 1 of +$55 (collision flag). If clear → skip avoidance, go directly to `physics_integration`.

### 5.3 Primary Target Avoidance ($A4EC-$A580)

Three distance bands using Manhattan distance (|dX|+|dY|):

| Band | Threshold | Steering Response | Speed Response |
|------|-----------|-------------------|----------------|
| Close | <160 | If |dZ|<64: force = `(64 - |dZ|) × 6` | Braking at |dZ|<48 |
| Medium | 160-320 | Speed-dependent scaling | — |
| Approach | <112 (heading) | Heading correction (halve delta) | — |

Track-specific scaling: track 28 uses ×9 instead of default ×6 for steering force.

### 5.4 Secondary Entity Path ($A582-$A664)

Follows target's own target chain (+$A4 → +$A4). Different thresholds:
- Manhattan < 480: speed-based braking `(480 - dist) >> variable_shift`
- |dZ| < 64: lateral steering ×4 multiplier

### 5.5 No-Target Fallback (`collision_avoidance_no_target`, $A6F8)

Uses player entity at $9000 as reference:
- Manhattan threshold: $230 (560 units)
- Lateral threshold: $40-$70
- Steering force: `(96 - |dZ|) × 24`
- Exits via `BRA.W physics_integration`

---

## 6. Opponent Selection (`ai_opponent_select`, $A434)

**Activation gates:**
- Game mode `$C8C8` != 1
- Speed index >= $59 (89)
- Game state == 4
- 15-frame cooldown at +$86

**Categories:**
- Normal: speed < 200
- High-speed: speed >= $C8 (200) → sets opponent category flag +$BE = 1

Triggers AI behavior byte $B7 in `$C8A4`.

Source: [ai_opponent_select.asm](disasm/modules/68k/game/ai/ai_opponent_select.asm)

---

## 7. Scene Interpolation (`ai_scene_interpolation`, $BD2A)

6-component keyframe blending for attract/replay mode:

Interpolates position (X, Y, Z), heading, speed, and camera angle between two keyframes. Linear interpolation with per-component delta scaling.

Source: [ai_scene_interpolation.asm](disasm/modules/68k/game/ai/ai_scene_interpolation.asm)

---

## 8. Speed Conversion

AI orchestrator converts distance-based speed to game units:

```
game_speed = distance_speed × 1000 × 256 / 3600 / 20
```

Per-frame acceleration clamped to: +$2F (47) acceleration, -$50 (80) deceleration.

---

## 9. Cross-Subsystem Interfaces

### AI → Physics (Fall-Through)

`collision_avoidance_speed_calc` ($A470) has **no RTS** at its end. All exit paths flow into `physics_integration` ($A666), which computes heading via `ai_steering_calc`, integrates position via sin/cos × speed >> 12, and updates +$30/+$34.

### Shared Functions

| Function | Address | Used By |
|----------|---------|---------|
| `ai_steering_calc` | $A7A0 | AI, Physics, Camera |
| `sine_cosine_quadrant_lookup` | $8F4E | All subsystems |
| `entity_speed_clamp` | $9B12 | AI orchestrator, Physics pipeline |
| `entity_force_integration+18` | $9312 | AI orchestrator (tail-call) |
| `entity_pos_update+70` | $7008 | AI orchestrator (position integration) |

### Entity Fields (AI-Specific)

| Offset | Size | Name | Purpose |
|--------|------|------|---------|
| +$A4 | word | target_index_1 | Primary target entity index |
| +$A6 | word | target_index_2 | Secondary target |
| +$AE | word | slot_index | Race slot (0-3) |
| +$B0 | word | spawn_timer | Countdown (120 frames) |
| +$BC | word | decel_accum | Deceleration accumulator |
| +$BE | word | opponent_category | 0=normal, 1=high-speed |

### Global AI RAM

| Address | Purpose |
|---------|---------|
| `$FFA0EA` | AI state (jump table index, 0-56) |
| `$FFA0EC` | AI timer (counts to 120) |
| `$FFC8AA` | Scene state (interpolation counter) |
| `$FFC03C` | Race slot table base (4 slots) |
