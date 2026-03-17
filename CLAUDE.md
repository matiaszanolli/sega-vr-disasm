# CLAUDE.md

Agent briefing for Virtua Racing Deluxe 32X disassembly/reassembly project.

**Last Updated**: March 16, 2026

## Agent Team (v3)

Two agents. See [agents/README.md](agents/README.md) for details.

**Worker** (Sonnet or Opus) does all technical work: research, code, build, test. Spawn directly — no intermediary. Use Opus for hard problems (B-004, B-006, novel COMM work), Sonnet for routine tasks.

**Auditor** (Opus) is a focused safety reviewer. Spawned fresh per concrete COMM/SH2/expansion proposal only. Returns APPROVED or BLOCKED. Not needed for 68K-only, profiling, or doc work.

**You are the task manager.** Pick a task from BACKLOG.md, spawn the Worker, review findings, spawn Auditor if flagged, approve/commit.

**Research-First Principle:** Before implementing any fix, read the relevant docs and build a mental model with citations. If a second attempt fails for related reasons, stop coding and read. Named anti-patterns: address shopping, circular investigation, modern platform assumptions, undocumented guessing — all banned.

**index.md maintenance rule:** After any session where a new pitfall is discovered or a new architectural fact is established, update `analysis/agent-scratch/oracle/index.md` before closing.

## Build & Test

```bash
make all          # Build 4MB ROM from disassembly
make clean        # Remove build artifacts
picodrive build/vr_rebuild.32x  # Test in emulator (PicoDrive only — BlastEm has NO 32X support)
```

Build produces `build/vr_rebuild.32x`. Binary compatibility with the original ROM is no longer maintained — the codebase is now actively modified for optimization and correctness.

## Ground Rules — STRICTLY ENFORCED

1. **Do Not Guess** — Use `docs/` (hardware manuals) and `analysis/` (architecture). Use `analysis/agent-scratch/oracle/index.md` as a topic lookup table. Read the primary source. Research first.
2. **Understand Before Modifying** — Never patch `dc.w` without understanding it. Disassemble and document first.
3. **Use Available Tools** — Profiler at `tools/libretro-profiling/`, disassemblers `tools/m68k_disasm.py` and `tools/sh2_disasm.py`. Measure, don't assume.
4. **Proper Assembly** — Modify assembly source, not raw binary. Convert `dc.w` to mnemonics when possible (see [KNOWN_ISSUES.md](KNOWN_ISSUES.md) for SH2 exceptions).
5. **Clean Commits** — No stale comments, no partial changes. Revert completely if something doesn't work.
6. **Verify Changes** — `make clean && make all` after every modification. Confirm build succeeds.
7. **DRY** — Never create duplicate files. Fix in place. Use git branches for experiments.
8. **COMM Register Safety** — Before modifying any 68K↔SH2 communication code, read [analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md](analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md). Critical rules:
   - **Read-during-write = undefined** — not just write-write. Both CPUs must use handshakes.
   - **SH2 writes are buffered** — value may not reach the register immediately. Dummy-read the same address to force synchronization.
   - **COMM1 is a system signal register** — func_084 manages COMM1_LO bit 0 ("command done"); V-INT, scene init, frame swap all poll it. Never write arbitrary data to COMM1 without save/restore + interrupt disable.
   - **COMM7 is the Slave doorbell** — never broadcast game command bytes to it (proven crash, B-006).
   - **Always use cache-through** (`$20004020`) for SH2 COMM access, never `$00004020`.
9. **Memory Boundaries** — Always check the [hardware manual memory map](docs/32x-hardware-manual.md) before assuming an address is accessible from another CPU.
   - **SH2 CANNOT access 68K Work RAM** (`$FF0000`) at ANY address. The region between SDRAM (`$0203FFFF`) and Frame Buffer (`$04000000`) is unmapped. Three failed B-003 attempts proved this.
   - **SDRAM mapping**: SH2 `$0600xxxx` = ROM file offset `$20000 + xxxx`, NOT `$xxxx`. Getting this wrong produces hex dumps of 68K code instead of SH2 SDRAM.
   - **Shared memory options** (exhaustive): COMM registers (16 bytes), SDRAM ($02000000-$0203FFFF), Frame Buffer ($04000000, FM-controlled). That's all.
10. **SH2 Patching Discipline** — SH2 code is tightly interconnected. Careless patches cause silent corruption.
    - **Literal pool sharing**: `MOV.L @(disp,PC),Rn` instructions share literal pools. Before overwriting ANY address in SH2 code, scan the entire section for `$Dnxx` opcodes that resolve to it (see [KNOWN_ISSUES.md](KNOWN_ISSUES.md) §SH2 Literal Pool Sharing).
    - **Test patches in isolation**: Interacting patches hide root causes. Never combine multiple SH2 patches without testing each one alone first (proven in B-006: reverting Patch #2 alone was insufficient).
    - **Verify encodings**: Always verify assembled SH2 opcodes against original ROM bytes with `python3`. Subtle encoding errors (wrong register field, wrong displacement) are invisible until runtime.
11. **COMM Offload Cost Model** — Synchronous COMM offload is **only viable when computation time >> handshake overhead × call count**. Each COMM round-trip costs ~200-500 68K cycles of polling + register I/O, and COMM0_HI is a global busy flag — every call waits for ALL prior COMM commands to finish. Small functions called frequently (e.g., `angle_normalize`: 8×/frame, ~1,500 cycles native) become **dramatically slower** under COMM dispatch (+23% total 68K time). For small functions, use batching (N inputs per COMM command) or async/pipelined approaches. See [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) §Key Lessons.

## Architecture

**Approach:** Full ROM rebuild from disassembly (NOT code injection).
**Workflow:** Edit sources in `disasm/sections/` or `disasm/modules/` → `make all` → test.

### ROM Layout

```
$000000-$2FFFFF  3.0 MB  Original game (68K + SH2)
$300000-$3FFFFF  1.0 MB  SH2 expansion space (~1.5KB used, 99.9% free)
```

### Build Pipeline

```
disasm/vrd.asm (entry point)
  → disasm/sections/*.asm (header + vectors + 12 code sections + data + SH2 + expansion)
    → disasm/modules/68k/*/*.asm (823 modules across 17 categories + 15 game subcategories)
    → disasm/sh2/generated/*.inc (89 SH2 function includes)
  → build/vr_rebuild.32x (4MB ROM)
```

### Key Stats

- **823 68K modules** (736 fully translated, 87 with remaining dc.w — all data, not code)
- **All SH2 functions** integrated (92 function IDs via 89 .inc files, zero remaining)
- **Display FPS**: ~40 (camera interpolation, stable frame pacing). Game logic at 20 FPS.
- **60 FPS blocker**: FS swap must happen during VBlank → need swap-only V-INT handler (R-002). Design ready, 4 table slots available. See [VINT_HANDLER_ARCHITECTURE.md](analysis/VINT_HANDLER_ARCHITECTURE.md) §6.
- **Master SH2 commands**: 7 active ($00-$06) — all disassembled. See [SH2_COMMAND_HANDLER_REFERENCE.md](analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md)

### 68K Game Architecture

The game uses a **two-level dispatch** system. See [SCENE_HANDLER_ARCHITECTURE.md](analysis/SCENE_HANDLER_ARCHITECTURE.md) for full reference.

**Level 1 — Scene handler** (`$FF0002`): Self-modifying main loop at `$FF0000` calls `JSR [$FF0002]` each frame. Changing this pointer changes the game mode (loading, display init, racing, menus, etc.). Over 20 distinct handlers exist.

**Level 2 — State dispatcher** (`$C87E`): Within each scene handler, a sub-dispatcher reads `$C87E` (game state, increments by 4), indexes a jump table, and executes the appropriate state handler. Five race sub-dispatchers handle countdown, active racing, results, attract, and replay.

**V-INT state** (`$C87A` via `$FF0008`): Each state handler writes a V-INT state that controls which V-INT sub-handler runs during the next VBlank. 16+ entries in the jump table at `$0016B2`. State `$0054` = frame swap handler (checks COMM1_LO "done" signal, resets `$C87E`, toggles FS bit). See [VINT_HANDLER_ARCHITECTURE.md](analysis/VINT_HANDLER_ARCHITECTURE.md).

**$C8A8 command staging**: `mars_dma_xfer_vdp_fill` reads `$C8A8` and writes its bytes to COMM0 for SH2 dispatch. **C8A8 = $0102 for ALL per-frame DMA in ALL modes** (cmd $02 = scene orchestrator). Cmd $03 ($0103) is one-time init only — `race_scene_init_vdp_mode` sets it but falls through to `scene_init_orch` which overwrites to $0102.

### SH2 Architecture

**Dual independent dispatch** — Master and Slave have completely separate poll loops. See [SLAVE_SH2_DISPATCH_ARCHITECTURE.md](analysis/SLAVE_SH2_DISPATCH_ARCHITECTURE.md).

| CPU | Loop | Polls | Jump Table | Utilization | Role |
|-----|------|-------|-----------|-------------|------|
| Master | $06000460 | COMM0_HI | $06000780 (16 entries) | 0-36% | Command router + block copies |
| Slave | $06000592 | COMM2_HI | $060005C8 (8 entries) | ~73% | **ALL 3D rendering (bottleneck)** |

No direct cross-trigger. 68K submits to Master (COMM0) and Slave (COMM2) independently. COMM7 = async doorbell for cmd_27 pixel work (Slave polls in idle loop). COMM1_LO bit 0 = Master "done" signal.

**Dual rendering pipeline** (both on Slave):
- **Pipeline 1**: On-chip SRAM ($C0000000, 1748B). Self-contained, zero wait states. 36 entities/frame in 3 batches. **Untouchable.**
- **Pipeline 2**: SDRAM cache ($06003024 main_coordinator_short). coord_transform (12%), frustum_cull (12%), span_filler (8%). **Optimization target** — S-6 saved ~5%.

### Critical Constraint: Expansion ROM ($300000+)

- Executed by **SH2 only**, not 68K
- Must use `dc.w` format (raw SH2 opcodes), NEVER 68K mnemonics
- 68K machine code = invalid SH2 instructions = boot failure
- Implementation: [disasm/sections/expansion_300000.asm](disasm/sections/expansion_300000.asm)

### ROM Address Mapping

- **68000**: `cpu_addr = file_offset + 0x00880000`
- **SH2**: `cpu_addr = file_offset + 0x02000000`

## Where to Look

### Project Management
| Question | File |
|----------|------|
| What to work on next | [BACKLOG.md](BACKLOG.md) |
| Known pitfalls and bugs | [KNOWN_ISSUES.md](KNOWN_ISSUES.md) |
| Strategic optimization roadmap | [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) |

### Game Architecture (start here for understanding the game)
| Question | File |
|----------|------|
| **Frame execution flow** | **[analysis/SYSTEM_EXECUTION_FLOW.md](analysis/SYSTEM_EXECUTION_FLOW.md)** |
| **Scene handler chain ($FF0002, $C87E, $C8A8)** | **[analysis/SCENE_HANDLER_ARCHITECTURE.md](analysis/SCENE_HANDLER_ARCHITECTURE.md)** |
| **Game mode transitions (boot→menu→racing)** | **[analysis/GAME_MODE_TRANSITIONS.md](analysis/GAME_MODE_TRANSITIONS.md)** |
| **V-INT dispatch table + frame swap mechanism** | **[analysis/VINT_HANDLER_ARCHITECTURE.md](analysis/VINT_HANDLER_ARCHITECTURE.md)** |
| **Rendering pipeline (end-to-end)** | **[analysis/RENDERING_PIPELINE.md](analysis/RENDERING_PIPELINE.md)** |

### SH2 Architecture
| Question | File |
|----------|------|
| **Master SH2 command handlers (all 7)** | **[analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md](analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md)** |
| **Slave SH2 dispatch + dual pipeline** | **[analysis/SLAVE_SH2_DISPATCH_ARCHITECTURE.md](analysis/SLAVE_SH2_DISPATCH_ARCHITECTURE.md)** |
| **SH2 3D engine algorithms** | **[analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md](analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md)** |
| **SH2 rendering architecture (Pipeline 1+2)** | **[analysis/sh2-analysis/SH2_RENDERING_ARCHITECTURE.md](analysis/sh2-analysis/SH2_RENDERING_ARCHITECTURE.md)** |
| Master SH2 dispatch + COMM7 design | [analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md](analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md) |
| SH2 3D pipeline (overview) | [analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) |
| SH2 translation guide | [analysis/sh2-analysis/SH2_TRANSLATION_INTEGRATION.md](analysis/sh2-analysis/SH2_TRANSLATION_INTEGRATION.md) |

### Game Logic Subsystems
| Question | File |
|----------|------|
| **Entity/object system (4 tables, 256B records)** | **[analysis/ENTITY_OBJECT_ARCHITECTURE.md](analysis/ENTITY_OBJECT_ARCHITECTURE.md)** |
| **Physics (9-step pipeline, grip, gears, drift)** | **[analysis/PHYSICS_SYSTEM_ARCHITECTURE.md](analysis/PHYSICS_SYSTEM_ARCHITECTURE.md)** |
| **AI (15-state machine, collision avoidance)** | **[analysis/AI_SYSTEM_ARCHITECTURE.md](analysis/AI_SYSTEM_ARCHITECTURE.md)** |
| **Collision (binary search, 4-probe, proximity)** | **[analysis/COLLISION_SYSTEM_ARCHITECTURE.md](analysis/COLLISION_SYSTEM_ARCHITECTURE.md)** |
| **Sound driver (FM/PSG/Z80, 18 channels)** | **[analysis/SOUND_DRIVER_ARCHITECTURE.md](analysis/SOUND_DRIVER_ARCHITECTURE.md)** |
| Track data format (segmented spline) | [analysis/TRACK_DATA_FORMAT.md](analysis/TRACK_DATA_FORMAT.md) |
| Memory management (WRAM layout, copy primitives) | [analysis/MEMORY_MANAGEMENT_ARCHITECTURE.md](analysis/MEMORY_MANAGEMENT_ARCHITECTURE.md) |

### Hardware & Communication
| Question | File |
|----------|------|
| Hardware reference (start here) | [docs/development-guide.md](docs/development-guide.md) |
| Complete hardware manual | [docs/32x-hardware-manual.md](docs/32x-hardware-manual.md) |
| SH2 instruction set + opcode map | [docs/sh1-sh2-cpu-core-architecture.md](docs/sh1-sh2-cpu-core-architecture.md) |
| 68K instruction set + opcode map | [docs/motorola-68000-programmers-reference.md](docs/motorola-68000-programmers-reference.md) |
| SH7604 CPU datasheet (600+ pp) | [docs/sh7604-hardware-manual.md](docs/sh7604-hardware-manual.md) |
| COMM registers hardware deep dive | [analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md](analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md) |
| 68K↔SH2 communication | [analysis/68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) |
| Register reference + hazards | [analysis/architecture/32X_REGISTERS.md](analysis/architecture/32X_REGISTERS.md) |

### Function Reference & Profiling
| Question | File |
|----------|------|
| **ALL functions (799 entries, auto-gen)** | **[analysis/MASTER_FUNCTION_REFERENCE.md](analysis/MASTER_FUNCTION_REFERENCE.md)** |
| **Quick address lookup (flat, ctrl+F)** | **[analysis/FUNCTION_QUICK_LOOKUP.md](analysis/FUNCTION_QUICK_LOOKUP.md)** |
| 68K function catalog (503+, older) | [analysis/68K_FUNCTION_REFERENCE.md](analysis/68K_FUNCTION_REFERENCE.md) |
| Bottleneck root cause | [analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) |
| All documentation index | [docs/DOCUMENTATION_INDEX.md](docs/DOCUMENTATION_INDEX.md) |
| Profiling how-to | [tools/libretro-profiling/README_68K_PC_PROFILING.md](tools/libretro-profiling/README_68K_PC_PROFILING.md) |

## Module Categories

68K modules live in `disasm/modules/68k/<category>/`:

| Category | Purpose |
|----------|---------|
| boot | Initialization, adapter init |
| display | Display list, screen rendering |
| frame | Frame management |
| game | Game logic (682 functions, all documented and organized into subcategories) |
| graphics | Graphics primitives |
| hardware-regs | Hardware register access |
| input | Controller I/O |
| main-loop | V-INT handler, main loop |
| math | Trigonometry, fixed-point arithmetic |
| memory | Memory management |
| object | Object system |
| optimization | FPS counter, performance hooks |
| sh2 | SH2 communication (command submission) |
| sound | Sound driver interface |
| util | Utility functions |
| vdp | VDP register access |
| vint | V-INT sub-handlers |

### Game Subcategories

Game modules in `disasm/modules/68k/game/<subcategory>/`:

| Subcategory | Count | Purpose |
|-------------|-------|---------|
| ai | 27 | AI behavior, steering, opponent logic |
| camera | 29 | Camera setup, positioning, scrolling |
| collision | 23 | Collision detection, proximity checks |
| data | 16 | Decompression, lookup tables |
| entity | 35 | Entity/object management, spawning |
| hud | 28 | HUD, score display, digit rendering |
| menu | 115 | Menu, name entry, mode selection, UI |
| physics | 51 | Speed, acceleration, braking, tilt |
| race | 50 | Race state, lap tracking, sound triggers |
| render | 82 | Visibility, depth sort, VDP, DMA, sprites |
| scene | 53 | Scene init, SH2 communication, transitions |
| sound | 67 | FM/PSG sound driver functions |
| state | 102 | State dispatchers, counters, flags, timers |
| track | 4 | Track data, segment operations |

## Profiling Quick Start

```bash
cd tools/libretro-profiling
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay   # 30 seconds
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=profile.csv \
  ./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay  # PC hotspots
python3 analyze_pc_profile.py profile.csv
```

**Current measurements** (March 2026, 40 FPS camera interpolation):

| CPU | Cycles/Frame | Utilization | Notes |
|-----|-------------|-------------|-------|
| 68K | 127,986 | ~48% active, 52% STOP | Interpolation overhead negligible |
| Master SH2 | 127,061 avg | 0-36% | Extra block copies in state 4 |
| Slave SH2 | 299,926 | 52% (2 renders/3 TV) | 22% headroom per render |
