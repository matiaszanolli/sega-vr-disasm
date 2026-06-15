# Physics System Architecture — Virtua Racing Deluxe (32X)

## 1. Overview

The physics system is a **per-frame vehicle simulation** running on the 68K. It processes speed, steering, force integration, grip, drift, tilt, and position integration in a fixed 17-step pipeline called from `entity_render_pipeline`.

**51 modules** in `disasm/modules/68k/game/physics/`, totaling ~4.5KB of code.

**Key characteristics:**
- 8.8 fixed-point grip ($0100 = 1.0)
- 7-gear transmission with multiplicative ratio table
- 384-entry speed lookup table at $19DA4
- Per-frame speed delta clamped to +/-1024
- Falls through to collision system (no RTS boundary at `entity_pos_update` → `collision_response_surface_tracking`)

---

## 2. Execution Pipeline (Per-Frame Order)

From `entity_render_pipeline` Variant A (full player pipeline at $005AB6):

```
 1. camera_state_selector+12         — select camera mode
 2. clear display offsets (+$44, +$46, +$4A = 0)
 3. tire_squeal_check                — sound effect guard
 4. speed_degrade_calc ($00859A)     — speed → drag at +$BC
 5. effect_timer_mgmt                — manage effect timers
 6. object_timer_expire ($008170)    — +$62 countdown
 7. field_check_guard                — guard checks
 8. timer_decrement_multi            — multiple timer decrements
 9. steering_input_processing ($0094FA) — controller → +$8E steering
10. entity_force_integration ($009312)  — drag/friction → +$74, +$78, +$0C, +$06
11. entity_speed_clamp ($009B12)     — +$06 → +$04 via ×$48/256
12. entity_speed_accel_and_braking ($009182) — gear shifts on +$74/+$7A
13. tilt_adjust ($00961E)            — banking on +$0E, +$10
14. drift_physics ($009688)          — drift → +$3C, +$76
15. suspension_steering_damping      — damping
16. object_anim_timer_speed_clear+6  — animation reset
17. entity_pos_update ($006F98)      — heading + speed → +$30, +$34
    └── [JMP] collision_response_surface_tracking ($007700)
```

**Pipeline variants:**
- **A** (full player): All 17 steps
- **B** (non-player): Drops steering, drift, pos_update
- **C** (countdown): Adds pre-race countdown timer logic
- **D** (spectator/replay): Drops steering and drift, keeps pos_update

---

## 3. Speed System

### 3.1 Speed Field Map

The "speed" flows through multiple representations:

| Field | Offset | Range | Description |
|-------|--------|-------|-------------|
| `raw_speed` | +$74 | 0-17000 | Gear-scaled internal speed |
| `target_speed` | +$7E | 0-17000 | Smoothed +$74 (rate-limited +/-1024/frame) |
| `display_speed` | +$06 | — | Accumulated via slope delta from force integration |
| `speed` | +$04 | — | `display_speed × $48 / 256` (entity_speed_clamp output) |
| `calc_speed` | +$16 | — | Effective speed from table + multipliers (friction input) |

### 3.2 Speed Lookup Table

384-entry table at ROM $00899DA4 (via RAM pointer `$C27C`). Indexed by `+$04` (velocity_index). Returns base speed used by the multiplier chain.

### 3.3 Multiplier Chain (`speed_calc_multiplier_chain`, $009458)

```
base_speed = speed_table[entity.velocity_index]
calc_speed = (base_speed × track_speed_factor) >> 8

if has_boost_flag:   calc_speed = calc_speed × (16 + boost_modifier) >> 4
if speed_state > 4:  calc_speed = calc_speed × 11 / 16     // ~0.69× high-speed reducer
elif speed_state≠0:  calc_speed ×= 1.5                     // braking boost
if wind_active:      calc_speed ×= 1.75                    // +3/4
if boost_timer > 0:  calc_speed += $738; timer--
```

### 3.4 Force Integration (`entity_force_integration_and_speed_calc`, $009300)

The core physics function. Computes net force from drag, friction, and air resistance, applies grip scaling:

```
raw_speed = clamp(+$74, 0, 17000)
table_idx = raw_speed >> 7
drag_coeff = drag_table[surface][table_idx] × gear_table[gear] >> 5
net_force = (drag_coeff × entity.force) >> 7

friction = calc_speed << 4
net_force -= friction
air_drag = (entity.drag × $71C0) >> 7
net_force -= air_drag
if net_force < 0: net_force ×= 2        // double deceleration penalty

// Grip computation
entity.grip = $0100                      // reset to 1.0
if net_force exceeds max_threshold:
  excess = (excess << 8) / max_threshold
  entity.grip -= excess                  // reduce grip (min 0.5)
  trigger tire squeal $B4

final_force = (net_force >> 1) × entity.grip >> 7
entity.slope = final_force >> 2 / 400
entity.display_speed += entity.slope
entity.raw_speed = display_speed × gear_mult × 596 / 4096
```

**Drag tables:** Road at $0093910E, off-road at $00938FCE. Indexed by `raw_speed >> 7`.

### 3.5 Gear System (`entity_speed_acceleration_and_braking`, $009182)

7 gears (0-6). Transitions use multiplicative ratios from table at $0088A1F0:
- **Upshift:** `raw_speed = (raw_speed × ratio[gear]) >> 8; gear++`
- **Downshift:** `raw_speed = (raw_speed << 8) / ratio[gear]; gear--`
- **Natural shifts** at per-gear thresholds from $0088A1E2 (upshift) and $00939EDE (downshift)
- Per-frame delta clamped to +/-$400 (1024)

---

## 4. Steering and Heading

### 4.1 Controller Input (`steering_input_processing_and_velocity_update`, $0094F4)

```
Read L/R from controller bits → D0 (horizontal direction)

if direction_changed:
  steering_vel = accel_table[direction]   // inline: [-24, +24, 0]
  entity.steer = steering_vel << 8
elif no_input:
  centering damping (subtract damp_table[sign(vel)])
elif same_direction:
  accelerate (halve if countersteering same-sign as drift)
  steering_vel += accel

clamp(steering_vel, -127, +127)
if |steering_vel| < 24: steering_vel = 0    // deadzone

// Smoothing filter (EMA)
new_steer = (steering_vel << 8 + old_steer) / 2
drift_accum = clamp(drift_accum + |delta|>>8, 0, 200)

if |new_steer| < 24: new_steer = 0          // final deadzone
entity.steering_velocity = new_steer
```

### 4.2 Position Integration (`entity_pos_update`, $006F98)

```
heading = entity.heading_mirror + entity.heading_offset
entity.heading_angle = heading
heading = -heading

dx = sin(heading) × speed >> 12
x_position += dx
dy = cos(heading) × speed >> 12
y_position += dy

JMP collision_response_surface_tracking    // no RTS — falls through!
```

Sine/cosine from main trig table at $00930000 via `sine_cosine_quadrant_lookup` ($008F4E).

### 4.3 AI Entity Path (`physics_integration`, $00A666)

AI entities bypass controller input and use target-seeking:

```
distance = |target_x - pos_x| + |target_y - pos_y|    // Manhattan
frames_to_target = (distance << 4) / (speed + 1)
steering_factor = max(1, frames_to_target / 2)

target_heading = ai_steering_calc(pos, target)          // atan2 approx
heading_delta = (target_heading - heading) / steering_factor
heading += heading_delta

x_pos += (sin(heading) × speed) >> 12
y_pos += (cos(heading) × speed) >> 12
```

**Note:** `collision_avoidance_speed_calc` ($00A470) falls through directly to `physics_integration` with no RTS boundary. See [AI_SYSTEM_ARCHITECTURE.md](AI_SYSTEM_ARCHITECTURE.md) §5.

---

## 5. Tilt and Banking (`tilt_adjust`, $00961E)

```
if collision OR lateral_flag: return

tilt_rate = 48
// X-tilt: track tilt direction
if track_tilt < entity.direction: tilt_rate = -48
entity.x_tilt = clamp(entity.x_tilt + tilt_rate, -51, 255)

// Z-tilt: Z direction flag
if Z_direction not set: tilt_rate = -48
entity.z_tilt = clamp(entity.z_tilt + tilt_rate, 0, 255)
```

---

## 6. Drift Model

### 6.1 Lateral Drift (`lateral_drift_velocity_processing_00987e`, $00987E)

Two variants: A (standard) and B ($0099AA, adds AI boost + viewport scaling).

```
grip -= (|steering_input| × drag) >> 8     // steering reduces grip
clamp(grip, 127, ...)

if |slip_angle| <= 55: goto natural_damping

// Force integration
if low_velocity:
  force = slip × (512 - grip) >> 8
  lateral_vel += force
else:
  force = slip × 3/8
  lateral_vel += force
  heading -= (lateral_vel × correction_coeff) >> 8
  if |lateral_vel| >= spin_limit:
    trigger spin-out (sound $B2, flag $1000/$2000)

natural_damping:
  drag_force = clamped_vel × lateral_drag_coeff >> 8
  lateral_vel -= drag_force
  if zero_crossing: lateral_vel = 0
  if |vel| < 16 AND converging: lateral_vel = 0       // settled
```

### 6.2 Drift Accumulator (+$AA)

Tracks cumulative steering change. Range 0-200, decays by 8/frame. Used to determine when countersteer damping should activate (halves acceleration when countersteering matches drift direction).

---

## 7. Lookup Tables

| Table | ROM Address | Entries | Purpose |
|-------|------------|---------|---------|
| Drag (road) | $0093910E | ~134 | Speed-indexed drag coefficients |
| Drag (off-road) | $00938FCE | ~134 | Off-road drag coefficients |
| Gear ratios | $0088A1F0 | 7 | Per-gear multiplicative ratios |
| Natural upshift | $0088A1E2 | 7 | Per-gear speed thresholds |
| Natural downshift | $00939EDE | 7 | Per-gear decel thresholds |
| Speed table | $00899DA4 (via $C27C) | 384 | velocity_index → base speed |
| Speed calc alt | $0093925E | — | Alternative speed lookup |
| Track physics | $00898818 | per-track | Gear table ptr + 14 physics params |
| Sine/cosine (full) | $00930000 | 256 | Quadrant-based trig |
| Turn rate sine | $0093AC2C | 512 | Heading difference sine |
| Turn rate cosine | $0093A82C | 512 | Lateral force cosine |
| Physics lookup | $00A218 (inline) | 96 | 6×16 word table |
| Sine/cosine (mini) | $00A2D8 (inline) | 56 | 64-entry fixed-point |
| Angle-to-offset | $0093661E | 256 | Directional probe offsets |
| Steering accel | $0094F4 (inline) | 3 | [-24, +24, 0] |

---

## 8. Entity Field Map (Physics-Relevant)

| Offset | Size | Name | Written By |
|--------|------|------|------------|
| +$02 | word | flags | drift (spin-out bits $1000/$2000) |
| +$04 | word | speed | entity_speed_clamp |
| +$06 | word | display_speed | force_integration |
| +$0C | word | slope | force_integration |
| +$0E | word | x_tilt | tilt_adjust |
| +$10 | word | z_tilt / drag | tilt_adjust, drift |
| +$14 | word | boost_timer | multiplier_chain (decrements) |
| +$16 | word | calc_speed | multiplier_chain |
| +$30 | word | x_position | entity_pos_update |
| +$34 | word | y_position | entity_pos_update |
| +$3C | word | heading_mirror | drift_physics |
| +$40 | word | heading_angle | entity_pos_update |
| +$4C | word | slip_angle | drift (input) |
| +$74 | word | raw_speed | force_integration, speed_accel |
| +$76 | word | camera_dist | drift_physics |
| +$78 | word | grip | force_integration (reset), drift (reduce) |
| +$7A | word | gear | speed_accel (0-6) |
| +$7E | word | target_speed | speed_accel (rate-limited) |
| +$8E | word | steering_velocity | steering_input (8.8 fixed-point) |
| +$90 | word | drift_rate | drift_physics |
| +$92 | word | slide | drift (multi-use) |
| +$94 | word | lateral_velocity | drift (force-integrated) |
| +$96 | word | lateral_display | drift (display-mapped) |
| +$A8 | word | speed_state | multiplier_chain selector |
| +$AA | word | drift_accum | steering (0-200, decays 8/frame) |
| +$BC | word | drag_output | speed_degrade_calc |

---

## 9. Fixed-Point Conventions

| Shift | Usage | Example |
|-------|-------|---------|
| >>5 | Gear normalization | drag_coeff × gear_table >> 5 |
| >>7 | Drag/force scaling | net_force = (drag × force) >> 7 |
| >>8 | Velocity/grip (8.8) | grip $0100 = 1.0, steering ±127 in 8.8 |
| >>12 | Position integration | dx = sin × speed >> 12 |
| <<4 | Friction scaling | friction = calc_speed << 4 |
| <<8 | Gear ratio multiply | raw_speed × ratio >> 8 (upshift) |

---

## 10. Cross-Subsystem Interfaces

- **Physics → Collision:** `entity_pos_update` tail-calls `collision_response_surface_tracking` via JMP (no RTS boundary)
- **AI → Physics:** `collision_avoidance_speed_calc` falls through to `physics_integration` at $A666 (no RTS)
- **Shared utility:** `ai_steering_calc` ($A7A0) used by AI, physics, and camera subsystems
- **Shared utility:** `sine_cosine_quadrant_lookup` ($8F4E) used by all position/heading calculations
- **Sound triggers:** Physics writes sound bytes ($B1 skid, $B2 spin-out, $B4 tire squeal) to `$CA94` with 10-15 frame cooldowns at +$80/+$82/+$84
