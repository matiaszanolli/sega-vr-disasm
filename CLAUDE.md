# CLAUDE.md

Agent briefing for Virtua Racing Deluxe 32X disassembly/reassembly project.

**Last Updated**: February 28, 2026

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

## Architecture

**Approach:** Full ROM rebuild from disassembly (NOT code injection).
**Workflow:** Edit sources in `disasm/sections/` or `disasm/modules/` → `make all` → test.

### ROM Layout

```
$000000-$2FFFFF  3.0 MB  Original game (68K + SH2)
$300000-$3FFFFF  1.0 MB  SH2 expansion space (~1KB used, 99.9% free)
```

### Build Pipeline

```
disasm/vrd.asm (entry point)
  → disasm/sections/*.asm (header + vectors + 12 code sections + data + SH2 + expansion)
    → disasm/modules/68k/*/*.asm (821 modules across 17 categories + 15 game subcategories)
    → disasm/sh2/generated/*.inc (89 SH2 function includes)
  → build/vr_rebuild.32x (4MB ROM)
```

### Key Stats

- **821 68K modules** (736 fully translated, 85 with remaining dc.w — all data, not code)
- **All SH2 functions** integrated (92 function IDs via 89 .inc files, zero remaining)
- **68K is THE bottleneck** — 100% utilization, ~60% wasted polling COMM registers
- **Master SH2**: 0-36% util. **Slave SH2**: 78% util. **Baseline FPS**: ~20-24

### Critical Constraint: Expansion ROM ($300000+)

- Executed by **SH2 only**, not 68K
- Must use `dc.w` format (raw SH2 opcodes), NEVER 68K mnemonics
- 68K machine code = invalid SH2 instructions = boot failure
- Implementation: [disasm/sections/expansion_300000.asm](disasm/sections/expansion_300000.asm)

### ROM Address Mapping

- **68000**: `cpu_addr = file_offset + 0x00880000`
- **SH2**: `cpu_addr = file_offset + 0x02000000`

## Where to Look

| Question | File |
|----------|------|
| What to work on next | [BACKLOG.md](BACKLOG.md) |
| Known pitfalls and bugs | [KNOWN_ISSUES.md](KNOWN_ISSUES.md) |
| Strategic optimization roadmap | [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) |
| Hardware reference (start here) | [docs/development-guide.md](docs/development-guide.md) |
| Complete hardware manual | [docs/32x-hardware-manual.md](docs/32x-hardware-manual.md) |
| SH2 instruction set + opcode map | [docs/sh1-sh2-cpu-core-architecture.md](docs/sh1-sh2-cpu-core-architecture.md) |
| 68K instruction set + opcode map | [docs/motorola-68000-programmers-reference.md](docs/motorola-68000-programmers-reference.md) |
| SH7604 CPU datasheet (600+ pp) | [docs/sh7604-hardware-manual.md](docs/sh7604-hardware-manual.md) |
| All documentation index | [docs/DOCUMENTATION_INDEX.md](docs/DOCUMENTATION_INDEX.md) |
| **ALL functions (799 entries, auto-gen)** | **[analysis/MASTER_FUNCTION_REFERENCE.md](analysis/MASTER_FUNCTION_REFERENCE.md)** |
| **Quick address lookup (flat, ctrl+F)** | **[analysis/FUNCTION_QUICK_LOOKUP.md](analysis/FUNCTION_QUICK_LOOKUP.md)** |
| **Frame execution flow (start here)** | **[analysis/SYSTEM_EXECUTION_FLOW.md](analysis/SYSTEM_EXECUTION_FLOW.md)** |
| 68K function catalog (503+, older) | [analysis/68K_FUNCTION_REFERENCE.md](analysis/68K_FUNCTION_REFERENCE.md) |
| 68K↔SH2 communication | [analysis/68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) |
| COMM registers hardware deep dive | [analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md](analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md) |
| Register reference + hazards | [analysis/architecture/32X_REGISTERS.md](analysis/architecture/32X_REGISTERS.md) |
| Master SH2 dispatch + COMM7 design | [analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md](analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md) |
| Bottleneck root cause | [analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) |
| SH2 3D pipeline | [analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) |
| SH2 translation guide | [analysis/sh2-analysis/SH2_TRANSLATION_INTEGRATION.md](analysis/sh2-analysis/SH2_TRANSLATION_INTEGRATION.md) |
| Profiling how-to | [tools/libretro-profiling/README_68K_PC_PROFILING.md](tools/libretro-profiling/README_68K_PC_PROFILING.md) |

## Module Categories

68K modules live in `disasm/modules/68k/<category>/`:

| Category | Purpose |
|----------|---------|
| boot | Initialization, adapter init |
| display | Display list, screen rendering |
| frame | Frame management |
| game | Game logic (674 functions, all documented and organized into subcategories) |
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
| ai | 25 | AI behavior, steering, opponent logic |
| camera | 29 | Camera setup, positioning, scrolling |
| collision | 23 | Collision detection, proximity checks |
| data | 16 | Decompression, lookup tables |
| entity | 34 | Entity/object management, spawning |
| hud | 28 | HUD, score display, digit rendering |
| menu | 115 | Menu, name entry, mode selection, UI |
| physics | 50 | Speed, acceleration, braking, tilt |
| race | 50 | Race state, lap tracking, sound triggers |
| render | 80 | Visibility, depth sort, VDP, DMA, sprites |
| scene | 52 | Scene init, SH2 communication, transitions |
| sound | 67 | FM/PSG sound driver functions |
| state | 101 | State dispatchers, counters, flags, timers |
| track | 4 | Track data, segment operations |

## Profiling Quick Start

```bash
cd tools/libretro-profiling
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay   # 30 seconds
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=profile.csv \
  ./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay  # PC hotspots
python3 analyze_pc_profile.py profile.csv
```

**Baseline measurements** (January 2026):

| CPU | Cycles/Frame | Utilization |
|-----|-------------|-------------|
| 68K | 127,987 | 100.1% (bottleneck) |
| Master SH2 | 60-139,568 | 0-36% |
| Slave SH2 | 299,958 | 78.3% |
