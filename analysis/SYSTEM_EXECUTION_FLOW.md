# System Execution Flow — Virtua Racing Deluxe 32X

**What actually happens, in order, every frame.**

This document answers: "when we optimize function X, what is the surrounding context?"
For per-function detail see [MASTER_FUNCTION_REFERENCE.md](MASTER_FUNCTION_REFERENCE.md).
For SH2 3D engine internals see [sh2-analysis/SH2_3D_FUNCTION_REFERENCE.md](sh2-analysis/SH2_3D_FUNCTION_REFERENCE.md).

---

## System Overview

Three CPUs run concurrently. Communication is exclusively through COMM registers
(`$A15120–$A1512E` from 68K, `$20004020–$2000402E` from SH2).

```
┌─────────────────────────────────────────────────────────────────┐
│  68K (7.67 MHz)          Master SH2 (23 MHz)   Slave SH2 (23 MHz)
│  100% utilization        0–36% utilization      78% utilization
│  ← BOTTLENECK →         (blocked waiting for  (mostly async cmd
│                           68K commands)          $27 pixel work)
│
│  V-INT fires every 16.67 ms (60 Hz, NTSC)
│  Active display: ~263 scan lines ≈ 16 ms of game logic
└─────────────────────────────────────────────────────────────────┘

COMM registers ($A15120–$A1512E on 68K / $20004020–$2000402E on SH2):

  COMM0 HI ($A15120)  Master SH2 dispatch index / "command in flight" flag
  COMM0 LO ($A15121)  Jump table index byte (written with COMM0 HI together)
  COMM1 HI ($A15122)  Slave work command (original game protocol)
  COMM1 LO ($A15123)  "Command done" signal managed by func_084
  COMM2:3  ($A15124)  Source pointer / width parameter
  COMM4:5  ($A15128)  Destination pointer
  COMM6    ($A1512C)  Height + width-in-words packed
  COMM7    ($A1512E)  Slave SH2 doorbell ($0027 = cmd_27 work pending)
```

---

## 1. V-INT Handler ($001684)

Fires at the start of every vertical blank (~60 Hz).

```
V-INT fires
    │
    ├─ TST.W $FFC87A        ; Any pending state work?
    ├─ BEQ → RTE            ; No → exit immediately (fast path)
    │
    ├─ SR = $2700           ; Disable all interrupts
    ├─ MOVEM.L → stack      ; Save D0–D7 / A0–A6 (56 bytes)
    │
    ├─ D0 = [$FFC87A]       ; Load dispatch state (pre-multiplied ×4)
    ├─ [$FFC87A] = 0        ; Clear (acknowledge)
    │
    ├─ A1 = jmp_table[D0]   ; Load handler from table at ROM $0016B2
    ├─ JSR (A1)             ; Call state handler (see table below)
    │
    ├─ [$FFC964] += 1       ; Increment global frame counter
    │
    ├─ MOVEM.L ← stack      ; Restore all registers
    ├─ SR = $2300           ; Re-enable interrupts (H-INT allowed)
    └─ RTE
```

### V-INT State Dispatch Table (ROM $0016B2)

The main loop sets `$FFC87A` before each V-INT to request a specific VDP/FB operation.

| `$FFC87A` value | Handler | Purpose |
|-----------------|---------|---------|
| 0, 4, 8, 32     | `vint_state_common` ($001A64) | VDP sync + Work RAM ops |
| 16              | `vint_state_minimal` ($001A6E) | Quick VDP status read |
| 20              | `vint_state_vdp_sync` ($001A72) | Full VDP register sync |
| 24              | `vint_state_fb_toggle` ($001C66) | Frame buffer page flip |
| 28              | `vint_state_sprite_cfg` ($001ACA) | VDP sprite configuration |
| 36              | `vint_state_fb_setup` ($001E42) | Frame buffer pointer setup |
| 40              | `vint_state_vdp_config` ($001B14) | VDP mode config |
| 44              | `vint_state_transition` ($001A64) | Queue next state |
| 48              | `vint_state_complex` ($001BA8) | Complex VDP operations |
| 52              | `vint_state_fb_palette` ($001E94) | FB + palette update |
| 56              | `vint_state_fb_dma` ($001F4A) | Frame buffer DMA |
| 60              | `vint_state_cleanup` ($002010) | Clear SH2 command flags |

---

## 2. Main Game Loop (Between V-INTs)

After the V-INT returns, the 68K runs the main game loop for the ~16 ms active
display period. The loop has two phases: **game logic** and **render submission**.

```
Main loop (polling_loop / state_machine):
    │
    ├─ poll_controllers ($00179E)
    │   ├─ Read IO_DATA1 ($A10003), IO_DATA2 ($A10005)
    │   ├─ Button remap via table at $FFEF82
    │   └─ Store to $FFC86C (controller flags, longword)
    │
    ├─ Game state dispatch via $FFC87E
    │   ├─ State 0: Boot/menu (game_logic_entry $006200)
    │   ├─ State N: Race mode (physics, AI, collision)
    │   ├─ State M: Results / attract / name entry
    │   └─ (each state calls its own sub-state machines)
    │
    ├─ Object system update
    │   ├─ obj_position_update ($007084) — integrate velocities
    │   ├─ obj_velocity_x/y ($007F50/$007E7A) × 18 calls each
    │   ├─ obj_collision_test ($007816) × 11 calls
    │   └─ ai_entity_main_update_orch ($00A972) — AI steering/physics
    │
    ├─ Render preparation
    │   ├─ sh2_graphics_cmd ($00E22C) × 14 calls
    │   │   └─ Builds block-copy command parameters from object list
    │   │
    │   └─ Render submission (see §3 below)
    │
    └─ Loop back to poll_controllers
```

### Key State Variables (Work RAM / ROM space)

| Address | Size | Name | Purpose |
|---------|------|------|---------|
| `$FFC87A` | word | `vint_dispatch_state` | V-INT handler selector (pre-×4) |
| `$FFC87E` | word | `game_state` | Main game state machine |
| `$FFC8A0` | word | `race_state` | Race sub-state |
| `$FFC964` | long | `frame_counter` | Global frame count (V-INT incremented) |
| `$FFC86C` | long | `controller_flags` | Joypad button state (P1+P2) |
| `$FFC8AE` | word | `effect_countdown` | Per-frame timer for effects |
| `$FFEF05` | byte | `boot_flag_1` | Boot sequence gate |
| `$FFEF06` | byte | `boot_flag_2` | Boot sequence gate |
| `$FFEF00` | word | `prng_seed` | Pseudo-random number generator state |

---

## 3. SH2 Command Submission (The Bottleneck)

Every frame, the 68K submits commands to both SH2 CPUs. This is where ~60% of 68K
cycles are spent — waiting in polling loops.

### sh2_send_cmd ($00E35A) — 14 calls/frame, BLOCKING

Each call submits one 2D block-copy command. The 68K is fully blocked until the
Master SH2 finishes the copy.

```
68K side (sh2_send_cmd):
    │
    ├─ WAIT: tst.b $A15120 (COMM0_HI); bne.s .wait   ← WAIT #1: SH2 ready?
    │        (spins until Master SH2 clears COMM0 from previous command)
    │
    ├─ move.l A0, $A15124    COMM2:3 = source pointer (cache-through SDRAM addr)
    ├─ move.l A1, $A15128    COMM4:5 = dest pointer
    ├─ move.b D1, $A1512C    COMM6_HI = height (rows)
    ├─ move.b D0, $A1512D    COMM6_LO = width/2 (word count)
    │
    ├─ move.w #$0122,$A15120  COMM0: HI=$01 (dispatch idx), LO=$22 (cmd code)
    │                         → triggers Master SH2 dispatch
    │
    ├─ WAIT: tst.b $A15121; bne.s .wait    ← WAIT #2: params consumed?
    │        (Master SH2 clears COMM0_LO after reading COMM2–6)
    │
    └─ WAIT: tst.b $A15120; bne.s .wait    ← WAIT #3: copy complete?
             (Master SH2 clears COMM0_HI after block copy finishes)

Total blocking time per call: ~150+ cycles (3 COMM handshake waits)
14 calls × ~150 cycles = ~2,100 cycles (~1.6% of 68K frame budget)
Plus the Master SH2 execution time — 68K stalls for ALL of it.
```

**B-004 optimization** (params-read signal, v5 applied): Removes WAIT #1 by
writing all params before setting COMM0, and WAIT #2 is shortened to ~50 cycles.
Net saving: ~100 cycles × 14 calls = ~1,400 cycles/frame.

### sh2_cmd_27 ($00E3B4) — 21 calls/frame, FIRE-AND-FORGET

These commands go to the **Slave SH2** via COMM7 doorbell. The 68K does not wait
for completion — the Slave processes async during the display period.

```
68K side (sh2_cmd_27):
    │
    ├─ WAIT: tst.w $A1512E (COMM7); bne.s .wait   ← only wait: Slave idle?
    │        (spins until Slave clears COMM7 from previous cmd_27)
    │
    ├─ move.l A0, $A15124    COMM2:3 = data pointer
    ├─ move.w D1, $A1512C    COMM6_HI = height
    ├─ move.w D0, $A1512E    COMM7    = $0027 (doorbell — triggers Slave)
    │
    └─ RTS (return immediately)

Slave side (inline_slave_drain @ SDRAM $020608):
    │
    ├─ Detect COMM7 != 0
    ├─ Copy COMM2:3, COMM6 to local registers
    ├─ Clear COMM7 = 0 (acknowledge)
    └─ Execute pixel operation (add/OR/mask) on the region
       → Slave loops back to poll COMM7 for next doorbell
```

**B-003 optimization** (applied, working): Removed the synchronous 3-way
handshake. 68K now fire-and-forgets, Slave processes all 21 calls overlapped
with the 68K's next game logic pass.

### Master SH2 Dispatch Loop ($020460)

```
Dispatch loop (runs continuously on Master SH2):
    │
    ├─ R8 = $20004020 (COMM0 cache-through address)
    │
    ├─ R0 = MOV.B @R8        ; read COMM0_HI
    ├─ CMP/EQ #0, R0         ; zero = no command?
    ├─ BT → loop             ; yes → keep polling
    │
    └─ Non-zero:
         ├─ R0 = MOV.B @(1,R8)   ; read COMM0_LO = command code
         ├─ SHLL2 R0             ; R0 *= 4 (jump table offset)
         ├─ R1 = $06000780       ; jump table base (SDRAM literal)
         ├─ R0 = MOV.L @(R0,R1) ; load handler address
         ├─ JSR @R0             ; call handler
         └─ BRA → loop         ; return to poll
```

**Jump table at SDRAM $06000780** — key entries:

| COMM0_LO | Handler | Purpose |
|----------|---------|---------|
| `$01`    | `$060008A0` | Standard 3-phase COMM6 handler (all original game cmds) |
| `$22`    | `$3010F0` | Expansion ROM: single-shot block copy (B-004) |
| `$27`    | COMM7 path | Routed to Slave via COMM7 (B-003), NOT dispatched via Master |

### Slave SH2 Idle Loop ($06000592 / SDRAM)

The Slave polls COMM1 (for original game scene commands) and COMM7 (for async
pixel work). **78% utilization** — Slave is busy for most of each frame.

```
Slave loop:
    │
    ├─ Poll COMM1_HI ($20004022)
    │   ├─ Non-zero → dispatch via jump table at $0205C8
    │   └─ Zero → fall through to COMM7 check
    │
    ├─ Poll COMM7 ($2000402E) [inline_slave_drain @ $020608]
    │   ├─ Non-zero ($0027) → process cmd_27 pixel work (async)
    │   │   ├─ Read COMM2:3 (data ptr), COMM6 (dims)
    │   │   ├─ Clear COMM7 = 0 (release 68K from its wait)
    │   │   └─ Execute pixel region operation
    │   └─ Zero → loop back to COMM1 poll
    │
    └─ Loop
```

---

## 4. Full Frame Timeline

NTSC: 16.67 ms/frame, 60 Hz target (actual: ~20–24 FPS at baseline).

| Time (ms) | CPU | Action |
|-----------|-----|--------|
| 0.00 | **V-INT** | Interrupt fires at $001684 |
| 0.00 | 68K | Check $FFC87A, dispatch VDP/FB state handler |
| 0.00 | 68K | Increment $FFC964 frame counter |
| 0.00 | 68K | Restore registers, RTE |
| 0.05 | 68K | `poll_controllers` — read joypad state |
| 0.05–12 | 68K | Game state dispatch (physics, AI, collision, menus) |
| 12–16 | 68K | Render preparation: `sh2_graphics_cmd` × 14 |
| 12–16 | 68K | **Blocking**: `sh2_send_cmd` × 14 (waits for Master SH2 each) |
| 12–16 | Master SH2 | Executes 14 block copies serially, each triggered by 68K |
| Throughout | Slave SH2 | Polls COMM7; processes `cmd_27` × 21 async pixel ops |
| 16.67 | **V-INT** | Next interrupt fires; cycle repeats |

**Why FPS is ~20–24 and not 60:** The 68K blocks for Master SH2 completion on
every `sh2_send_cmd` call. The Master SH2's execution time (block copy) is added
to the 68K's frame time, not overlapped with it. Combined with 100% 68K
utilization for game logic, the frame cannot fit into 16.67 ms.

---

## 5. Scene Flow (Game States)

The `master_sequencer` ($00C200) drives scene transitions via `$FFC87E`:

```
master_sequencer ($00C200):
    │
    ├─ Read game_state ($FFC87E)
    ├─ Dispatch via scene_state_dispatch ($00C662) → jump table
    │
    ├─ Boot/attract:    load assets, configure VDP, init objects
    ├─ Menu:            input handling, track/car selection
    ├─ Race:            full game loop (physics + SH2 render pipeline)
    ├─ Pause/options:   freeze physics, show menu overlay
    ├─ Results:         lap times, comparison, leaderboard
    └─ Name entry:      character input grid

Scene transitions → scene_transition ($00C870):
    └─ Saves game_state, sets up next state, triggers V-INT state 11
       (vint_state_transition) to queue next handler
```

During **race mode**, each frame the scene module calls:
1. `sh2_frame_sync` ($00203A) — ensures SH2 is ready to receive new frame
2. `sh2_framebuffer_prep` ($0027DA) — sets up 32X FB for new render
3. Game update + physics (all the game subcategories)
4. Render command submission (14× `sh2_send_cmd` + 21× `sh2_cmd_27`)

---

## 6. Optimization Opportunity Map

Based on the above, here is where cycle savings can be found:

| Optimization | Cycles/Frame | Status |
|-------------|-------------|--------|
| B-003: `sh2_cmd_27` fire-and-forget | ~3,000 saved | DONE |
| B-004: `sh2_send_cmd` params-read signal | ~1,400 saved | IN PROGRESS |
| B-005: Command batching (35→3 submissions) | TBD | OPEN |
| B-006: Slave SH2 parallel vertex transform | ~15–20% gain | REVERTED (needs redesign) |
| B-009: FB write FIFO burst mode (2.4× raster) | TBD | OPEN |
| Inline `angle_to_sine` (29 calls) | ~580 saved | Not started |
| Eliminate COMM0 busy-wait between commands | ~2,100 → 0 | Needs B-005 first |

The architectural ceiling: **the 3-way COMM handshake per `sh2_send_cmd` call
forces serialization of 68K and Master SH2**. Removing these waits (via async
command queues or pipelining, i.e. B-005) is the highest-leverage single change.

---

*See also:*
- [68K_SH2_COMMUNICATION.md](68K_SH2_COMMUNICATION.md) — COMM register protocol detail
- [COMM_REGISTERS_HARDWARE_ANALYSIS.md](COMM_REGISTERS_HARDWARE_ANALYSIS.md) — hardware hazards
- [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) — cycle budget
- [MASTER_FUNCTION_REFERENCE.md](MASTER_FUNCTION_REFERENCE.md) — all 799 function entries
