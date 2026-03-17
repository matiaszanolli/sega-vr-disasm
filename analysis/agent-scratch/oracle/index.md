# Oracle Knowledge Index — VRD 32X Disassembly Project

**Generated:** 2026-03-13
**Project:** Virtua Racing Deluxe (32X) disassembly/reassembly
**Purpose:** Pre-computed knowledge map for the Oracle agent
**Coverage:** Full architectural analysis, hardware reference, optimization roadmap, known pitfalls

---

## Section 1: Document Registry

### Primary Project Guidance

| Path | Purpose | Key Topics | Status |
|------|---------|-----------|--------|
| CLAUDE.md | Agent briefing, ground rules, build system, module organization | Build pipeline, ROM layout ($300000 expansion), COMM safety, SH2 literal pools, memory boundaries | Current (2026-02-20) |
| BACKLOG.md | Task queue with priority levels (P0-P3) and acceptance criteria | B-001 through B-016, status tracking, test results, commit hashes | Current — B-015/B-016 OPEN, B-003/B-004/B-005 DONE, B-006 SHELVED |
| KNOWN_ISSUES.md | 68+ pitfalls from real bugs — read BEFORE modifying code | Translation errors, hardware hazards, COMM races, SH2 patching discipline, abandoned approaches | Critical reference |
| OPTIMIZATION_PLAN.md | Strategic roadmap (v8.0): SH2 workload reduction + 68K QoL | SH2 bottleneck, LOD culling (S-1), cmd_22 queue, DIVS→MULS (QW-5), pipeline overlap | Current (v8.0, 2026-03-11) |

### Hardware References

| Path | Purpose | Key Topics | Note |
|------|---------|-----------|------|
| docs/32x-hardware-manual.md | Complete Sega 32X specification | Memory map, COMM registers, VDP, PWM, boot sequence, CPU speeds | Primary source |
| docs/development-guide.md | Practical development guidance | CPU coordination, cache addressing, register quick ref, memory banking | Quick start |
| docs/sh1-sh2-cpu-core-architecture.md | SH2 instruction set + opcode maps | Instruction encoding, PC-relative addressing, cache semantics | SH2 ISA reference |
| docs/motorola-68000-programmers-reference.md | 68K instruction set + opcode maps | Addressing modes, exception handling, timing tables | 68K ISA reference |
| docs/sh7604-hardware-manual.md | SH7604 CPU datasheet (600+ pages) | Write buffer, cache behavior, interrupt behavior, FRT timing | Deep hardware reference |

### Architecture & Analysis

| Path | Purpose | Key Topics | Note |
|------|---------|-----------|------|
| analysis/SYSTEM_EXECUTION_FLOW.md | Per-frame execution order | V-INT handler, main loop, render submission, state dispatch | Frame context |
| analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md | Hardware-level COMM deep dive | Register map, access width, hazard rules, naming traps (Sega vs VRD), write buffer | **MUST READ before COMM work** |
| analysis/68K_SH2_COMMUNICATION.md | Communication protocol & coordination | Boot handshake, COMM usage, parameter passing, async patterns (B-003/B-004) | Protocol reference |
| analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md | Root cause of 20-24 FPS ceiling | SH2 Slave at 78.3% = bottleneck, 68K 51.89% idle (STOP), $C87E adaptive state machine | Performance root cause |
| analysis/architecture/VBLANK_PERFORMANCE_ANALYSIS.md | V-blank 49.4% profiling + optimization analysis | Spin-wait loop, STOP instruction, FPS model (30/60), what can/cannot be optimized | Added March 2026 |
| analysis/architecture/VINT_HANDLER_ARCHITECTURE.md | V-INT handler dispatch mechanism | State machine (16 states), timing, interrupt priority, MOVEM overhead | Architecture overview |
| analysis/architecture/VINT_STATE_HANDLERS.md | Per-state handler disassembly | All 16 states: VDP ops, palette copy, frame buffer toggle, cycle estimates | Full state detail |
| analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md | Master dispatch internals + B-006 crash analysis | COMM0 trigger flag vs index, literal pool sharing, PR semantics, COMM7 namespace collision | Dispatch mechanism |
| analysis/architecture/32X_REGISTERS.md | System registers reference with hazards | Adapter control (FM bit), DREQ control (RV bit), interrupt control, bank set | Register reference |
| analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md | SH2 3D rendering engine design | Vertex transform, polygon rasterization, frame buffer protocol | 3D pipeline |
| analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md | Algorithmic deep dive into 3D engine | Color pipeline (8bpp palette), reciprocal table (0.14 fixed), flat shading, no Z-buffer, no textures | Decoded March 2026 |
| analysis/RENDERING_PIPELINE.md | End-to-end rendering flow | V-INT → 68K scene setup → COMM → SH2 transform → rasterize → VDP compositing | Pipeline overview |
| analysis/architecture/MASTER_SLAVE_ANALYSIS.md | Historical Master/Slave analysis | COMM protocol v2.3, timing, pre-B-006 context | ⚠ Historical (pre-B-006 revert) |
| analysis/sh2-analysis/SH2_PARALLELIZATION_STRATEGY.md | Historical parallelization approach | Multi-SH2 work distribution | ⚠ SUPERSEDED — approach reverted (B-006) |
| analysis/architecture/EXPANSION_ROM_PROTOCOL_ABI.md | Historical COMM6/COMM4 protocol | Pre-B-006 ABI | ⚠ Historical — no longer current |

### Game Logic Subsystems

| Path | Purpose | Key Topics | Note |
|------|---------|-----------|------|
| analysis/ENTITY_OBJECT_ARCHITECTURE.md | Entity/object system | 4 WRAM tables ($FF9000-$FF9F00), 256B records, dual-layer 68K↔SH2, 20-sub pipeline, display objects at $FF6218, DMA to SH2 | Added March 2026 |
| analysis/PHYSICS_SYSTEM_ARCHITECTURE.md | Physics system | 9-step pipeline, 8.8 grip, 7-gear transmission, speed/drag tables, fall-through to collision | Added March 2026 |
| analysis/AI_SYSTEM_ARCHITECTURE.md | AI system | 15-state machine (120-frame timer), 3-band Manhattan avoidance, atan2 steering, falls through to physics_integration | Added March 2026 |
| analysis/COLLISION_SYSTEM_ARCHITECTURE.md | Collision system | Binary search (4 iterations), center+4 probes, EMA surface tracking, 4-level proximity zones | Added March 2026 |
| analysis/SOUND_DRIVER_ARCHITECTURE.md | Sound driver | 68K-driven FM/PSG sequencer + Z80 DAC (653B), 18 channels ($30 stride), 3-priority commands, YM2612/SN76489/Z80 | Added March 2026 |
| analysis/TRACK_DATA_FORMAT.md | Track data format | Segmented spline, 4 pages × $800, 5L+9W per segment, 2 table modes, index computation | Added March 2026 |
| analysis/MEMORY_MANAGEMENT_ARCHITECTURE.md | Memory management | Static WRAM layout, JSR-cascade copy primitives, MOVEM block copy, PRNG ($FFEF00), no dynamic allocation | Added March 2026 |

### Function References

| Path | Purpose | Key Topics | Note |
|------|---------|-----------|------|
| analysis/MASTER_FUNCTION_REFERENCE.md | All 799 functions (68K + SH2), auto-generated | Addresses, sizes, call signatures, parameter passing | Comprehensive lookup |
| analysis/FUNCTION_QUICK_LOOKUP.md | Flat, searchable function list | Addresses in decimal/hex, one-line purpose | Fast lookup (Ctrl+F) |
| analysis/68K_FUNCTION_REFERENCE.md | 503+ 68K functions | Categories, call chains, entry points | **SUPERSEDED** (March 2026) — use MASTER_FUNCTION_REFERENCE (799 entries) |

### Profiling & Measurement

| Path | Purpose | Key Topics | Note |
|------|---------|-----------|------|
| tools/libretro-profiling/README_68K_PC_PROFILING.md | How to profile VRD | Frame-level + PC-level hotspots, toolchain, baseline setup | Profiling how-to |
| analysis/profiling/68K_BOTTLENECK_ANALYSIS.md | THE critical finding: 68K at 100.1% | Cycle counts, utilization proof, SH2 optimization futility | Performance root cause evidence |
| analysis/optimization/COMM_REGISTER_USAGE_ANALYSIS.md | COMM usage per call site (async safety) | 15 safe / 2 unsafe sites, buffer dependency analysis | ⚠ SH2 addresses offset by 2 for COMM1+ (known error) |
| analysis/VDP_POLLING_ANALYSIS.md | VDP polling locations in 68K code | ~71 polling sites, $FFFFC80E dependency, async safety | VDP optimization prerequisite |

### Module Organization

| Path | Purpose |
|------|---------|
| disasm/vrd.asm | ROM entry point + section orchestration |
| disasm/sections/*.asm | 12 code sections + header/vectors/data/SH2/expansion |
| disasm/modules/68k/<category>/ | 823 modules across 17 categories + 15 game subcategories |
| disasm/sh2/generated/*.inc | 92 SH2 functions, all integrated |
| disasm/sections/expansion_300000.asm | SH2 expansion ROM ($300000–$3FFFFF, 1MB) |
| disasm/sh2/expansion/cmd22_single_shot.asm | B-004 handler (60B, active at $023010F0) |
| disasm/sh2/expansion/inline_slave_drain.asm | B-003 handler (88B, active at SDRAM $020608) |

---

## Section 2: Key Facts (Fast Lookup)

### CPU Speeds & Frame Budget

```
68000:       7.67 MHz,  ~48% utilization (51.89% STOP idle — NOT the bottleneck)
Master SH2: 23.01 MHz,  0–36% utilization (COMM dispatch at $020460 + block copies)
Slave SH2:  23.01 MHz,  78.3% utilization over 3 TV frames (THE BOTTLENECK — ALL 3D rendering)
Baseline FPS: ~40 (camera interpolation, 2 renders/3 TV frames)

ARCHITECTURE VERIFIED (March 2026):
  Master = command router (dispatch $06000460, boots $06000004) + block copies (cmd $22)
  Slave = ALL 3D rendering (dispatch $06000592, boots $06002004)
  Master signals Slave via COMM2_HI. Slave is the bottleneck.

DUAL PIPELINE (March 2026):
  Pipeline 1: On-chip SRAM ($C0000000, 1748B, self-contained, zero-wait — UNTOUCHABLE)
    36 entities/frame, 3 batches, entry at $060024DC → JSR $C0000000
  Pipeline 2: SDRAM cache (main_coordinator $06003024 → quad_batch → frustum_cull → coord_transform)
    37% of Slave budget — THIS is the optimization target
    coord_transform ($06003368): 17%, 4 call sites ($0600338C, $060033F4, $06003452, $060034CA)
    frustum_cull ($0600350A): 12%, 2 call sites ($060034AE, $060034D2)
    Full trace: analysis/sh2-analysis/SH2_RENDERING_ARCHITECTURE.md

TIMING ARCHITECTURE (March 2026): ALL game timing uses fixed per-frame deltas — NO delta-time
system exists. Frame rate changes require speed compensation at ~10 choke points in 5 core functions.
S-4b constant scaling DONE: race_entity_update_loop ($2000→$1555, $1800→$1000),
speed_interpolation ($0284→$01AD), cascaded_frame_counter ($C4→$A6), ai_timer_inc ($C4→$A6).
S-4b target speed scaling PENDING: entity cruising speed still 1.5× fast.
Inline code scaling (MULU #$AAAB) blocked by section packing constraints.
Candidate: scale 384-entry speed lookup table DATA at $19DA4 by 2/3 (zero code change).

68K Time Breakdown (PC profiling, March 2026, optimized build, 248.1M total cycles):
  51.89% WRAM V-blank sync (STOP instruction)
  10.52% cmd_22 COMM0_HI wait
   2.37% Menu tile copy (menu-only)
   2.31% Angle normalization/visibility
   1.91% Physics integration
   1.34% collision_avoidance_speed_calc
   0.99% sine_cosine_quadrant_lookup
   0.97% rotational_offset_calc
  ~27.7% Everything else

FPS Threshold Model (revised March 12):
  Frame rate = max(3, ceil(SH2_render_time / TV_frame_duration))
  3 TV frames/game frame → ~20 FPS (current — state machine adds 2 idle TV frames)
  2 TV frames/game frame → ~30 FPS (Master at ~1.45 TV frames — ALREADY FITS)
  Path to 30 FPS: S-4 state merge (remove idle TV frame), NOT SH2 workload reduction
  S-1 LOD culling: DEAD END (entity descriptors unused during racing, 4 profiling tests)
```

### March 2026 Codebase Consolidation

```
Label cleanup:     1,448 generic loc_XXXX labels → semantic names (all 161 files, COMPLETE)
Mnemonic cleanup:  993 dc.w → proper 68K mnemonics across 34 modules (COMPLETE)
Source comments:   28 most complex modules annotated (~680 comment lines)
                   Categories: Physics (7), Render (9), Camera (5), Collision (3),
                   AI (1), Scene (2), Sound (1)
Module extraction: 10 inline code blocks → semantic modules (B-014, COMPLETE)
```

### 3D Engine Facts (Decoded March 2026)

```
Color format:      8-bit palette index (high byte of word at intermediate +0x1E)
                   Extraction: AND $FF00 → SWAP.B + OR → replicated byte in R4
                   Pixel write: MOV.B R4,@R1 (single), MOV.W R4,@R1 (word fill)
Shading:           Flat only — no Gouraud, no texture mapping
Z-buffer:          None — 68K painter's algorithm (depth_sort.asm) renders back-to-front
Reciprocal table:  256 entries at SDRAM $060048D0 (ROM $0248D0), 0.14 fixed-point
                   table[N] = floor(16384/N), entry[0] = $7FFF sentinel
Gradient strips:   ROM $025E3C = smooth color ramps (palette 32-253), 112 bytes
                   ROM $0286D4 = dithering/edge masks, 112 bytes
                   Both match func_065's 14×8 copy block size
FIFO batching:     NOT feasible (B-009) — func_065 writes SDRAM not framebuffer
S-6 coord_transform: DONE (March 2026) — inlined at all 4 call sites via expansion ROM
                   Phase A: func_021 → expansion $3011E0 (96B), trampoline $0234C8
                   Phase B: func_017-019 state machine → expansion $301300 (388B), 6 JMP trampolines
                   Savings: ~19,200 cyc/frame (~5% Slave SH2), coord_transform 17% → ~12%
                   Technique: full block relocation + inline + BSR→MOV.L+JSR for external calls
V-blank sync:      51.89% of 68K time (STOP instruction at $FF000C — main loop)
Main loop:         At $FF0000 (Work RAM, self-modifying JSR + STOP #$2300)
$C87E state mach:  Adaptive — V-INT checks COMM1 bit 0 (SH2 done). If set, resets
                   $C87E to 0 + flips frame buffer. States 0/4 give SH2 extra time.
LOD culling (S-1): DEAD END — entity descriptors at $0600C344 unused during racing
                   68K LOD culling at $0036DE works, but patches data nobody reads
                   Racing uses Huffman renderer ($06004AD0) with $0600C800 (stride $10)
QW-5 DIVS→MULS:   IMPLEMENTED — speed_interpolation divs #$67 → muls #$01AD + swap (2/3 scaled for S-4b)

A-2 BLOCKERS (researched March 16, 2026):
  Blocker 1 (FS swap timing): SOLVABLE — V-INT handlers run during VBlank, FS writes
    take effect immediately. Create swap-only V-INT handler (~50B), hook via jump table.
    No $C87E reset, no COMM1 check. One swap per TV frame = 60 FPS.
  Blocker 2 (re-DMA no re-render): REQUIRES R-001 — SH2 render pipeline at $060008A0
    is frame-synchronous (one render per game frame). Handler dispatched via COMM0 →
    jump table $06000780 entry $01. Needs disassembly to identify render trigger subroutines
    and re-entry prevention mechanism. ROM offset $208A0 in code_20200.asm.

Expansion ROM (post S-6): Free from $301490 (~1,018 KB, 99.8%)
  Active: $300500 (B-005), $300700 (B-003), $3010F0 (B-004), $3011E0 (S-6A), $301300 (S-6B)

MASTER SH2 COMMAND HANDLERS (all 7 disassembled March 16, 2026):
  $00 → $06000490: idle/no-op (just completion signal)
  $01 → $060008A0: scene init orchestrator (10 subs: DMAC, PWM, cache, transforms, SRAM copy, entity loop, display list, finalize)
  $02 → $06000CFC: scene orchestrator (entity loop callers)
  $03 → $06000CC4: racing per-frame trigger (buffer clear 82KB + done)
  $04 → $060012CC: full scene rendering (heaviest: 32 entities from $0600C800, 2-pass, COMM2 sync)
  $05 → $06001924: racing per-frame render (22 entities, visibility cull via $0600C0C8)
  $06 → $06001A0C: bulk DMA copy (56KB track data)
  Jump table: $06000780 (16 entries). $07+ → $06000490 (idle).
  Full reference: analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md

HUFFMAN RENDERER (Slave SH2, $06004AD0, decoded March 16):
  NOT a Master handler — dispatched by Slave. Reads compressed data from COMM4 pointer.
  Writes decoded entity data to $0600C000 (NOT $0600C800 — oracle was wrong).
  Two modes: straight store ($06004C48) or XOR/delta ($06004C5C).
  256-entry lookup table rebuilt each invocation at $06003000.
  Feeds into Pipeline 1 (on-chip SRAM) via entity loop at $060024DC.

KEY SUBROUTINES (all traced March 16):
  $06004448 (34B): DMAC/FIFO setup — SAR0=FIFO $20004012, sets COMM1_LO bit 1 ACK
  $060044F6 (42B): PWM audio FIFO fill (192 samples)
  $06004480 (14B): wait DMAC done + cache purge/enable
  $06000DC8 (128B): entity transform pipeline (9 sub-calls, 36 entities)
  $060022BC (240B): on-chip SRAM context init ($C0000700 region, viewport+func ptrs)
  $060032D4 (54B): display list/viewport init (160×112 half-size, 256 entries)
  $06004334 (52B): scene finalize (COMM2 sync, SRAM code call, FB swap ctrl)
  $06004300 (36B): buffer clear ~82KB ($06020000-$06033000 + $0600DA00-$0600EE00)
  $0600441C (12B): COMM2 handshake primitive (spin COMM2_HI=0, write R1)
  $06000BBC: NOT CODE — vertex normal data table (8 cube corners ±512)

HANDLER $05 VISIBILITY CULLING:
  Reads $0600C0C8/$0600C0CA (camera view range). If either=$FFFF or equal, skips heavy render.
  This is the game's built-in LOD/range culling — S-5/S-9 should interface here.
```

### SH2 Dispatch Architecture (Traced March 2026, corrected March 12)

**CORRECTION (March 12, 2026):** The PRIMARY dispatch at $020460 is the MASTER SH2,
NOT the Slave. The Slave SH2 has its own dispatch at $020592 which polls hardware
COMM2 (register $20004024, which Sega internally calls "COMM1").

**CRITICAL FINDING:** The entity loop at $06002C8C does NOT execute during racing.
Patching it to force-skip all entities produces identical cycle counts across all CPUs.
The vis_bitmask_handler patches descriptor flags at $0600C344, but this data structure
is unused during racing. The 3D rendering goes through the Huffman system at $06004AD0.

```
MASTER dispatch:    Master idle loop at file $20460 (display $02220460)
                    Polls COMM0_HI byte → SHLL2 → loads jump table at $06000780
                    COMM0_HI=2 → $06000CFC (scene orchestrator)
                    cmd $07 → $023011A0 (vis_bitmask_handler, expansion ROM)
                    cmd $22 → $023010F0 (cmd22_single_shot, expansion ROM)
                    Indirect JSR @R0 (function pointer dispatch, NOT BSR)

SLAVE dispatch:     Slave idle loop at file $20592 (display $02220592)
                    Polls COMM2_HI byte ($20004024) → jump table at $0205C8
                    cmd 1 → $060039F0 (scene handler)
                    NOT used for polygon rendering (Master does all transforms)

SECONDARY dispatch: COMM2-register based table at file $205C4 (display $022205C4)
                    cmd2 → $060039F0 (old Slave cmd1 handler at file $239F0)
                    This is a SEPARATE mechanism from the COMM0 primary dispatch
                    The "old cmd1 handler" at $239F0 does NOT call entity loops directly

Call chain for entity loops:
  COMM0_HI=2 → $06000CFC (scene orchestrator, file $20CFC)
    → BSR $022210AC (entity-loop caller 1, file $210AC)    [single BSR from $020D36]
    → BSR $022211B4 (entity-loop caller 2, file $2164C)
    → JSR $06004464, $060045CC, $060043FC
```

**Entity loop function pointers** (NOT called by BSR — via JSR @R0 with pointer in R0):
```
$06002F60 (file $22F60):  entity loop 1 — DT R7 / ADD #$14,R14 / ADD #$30,R13
$06002F94 (file $22F94):  entity loop 2 — same structure + extra BSR after render
$06002C8C (file $22C8C):  entity loop 3 — similar structure, called with R7=5 or 8
```

Function pointers stored as literals in SDRAM (confirmed by literal pool at file $21120):
  file $21130: $06002F60 (loop 1 ptr)
  file $21140: $06002F94 (loop 2 ptr)
  file $21764: $06002F60 (another ref — entity-loop caller 2)

**Entity descriptor base addresses** (R14 on entry to each entity loop call):
```
Entity-loop caller 1 (file $210AC) calls:
  loop1 @$06002F60:  R14=$0600C754 (file $2C754), R13=$0600D930, R7=1
  loop2 @$06002F94:  R14=$0600C740 (file $2C740), R13=$0600D900, R7=1
  loop2 @$06002F94:  R14=$0600C72C (file $2C72C), R13=$0600D8D0, R7=1  [post-loop R12=$C0000700]

Entity-loop caller 2 (file $2164C) calls loop3 @$06002C8C:
  R14=$0600C344, R13=$0600CF70, R7=5
  R14=$0600C3A8, R13=$0600D060, R7=8
  R14=$0600C448, R13=$0600D1E0, R7=5
  R14=$0600C4AC, R13=$0600D2D0, R7=8
  R14=$0600C63C, R13=$0600D690, R7=8
```

**Entity descriptor structure** (20 bytes per record, stride +$14):
  Offset +0: active flag (0x00 = skip, non-zero = render)
  R13 = model data pointer (48-byte records, stride +$30)
  R12 = $C0000700 (entity rendering context base in SH2 SDRAM)

**Entity descriptor ROM initial values** (sample — game updates these at runtime):
  $0600C754 (file $2C754): flags [00 00 01 01 01 01 ...] (first entity inactive)
  $0600C344 (file $2C344): flags [01 E2 F9 01 01 E2 ...]
  $0600C3A8 (file $2C3A8): flags [00 ...]
  $0600C448 (file $2C448): flags [01 ...]

**Address formula note**: SH2 disassembler display = file_offset + $02200000 (NOT $02000000
as stated in CLAUDE.md). Example: file $239F0 → display $022239F0. Empirically verified.

**Inner loop render path**:
  BSR to $0222300C: copies 12 longwords to $C0000740 (edge buffer staging)
  BSR to $0222302E: render dispatcher (checks active flag, calls transform + rasterize)
  BSR to $02223024: additional pass after $022302E (only in loop 2)

**Master cmd $02 data structure** (DIFFERENT from entity descriptors):
  $06000CFC scene orchestrator uses R14=$0600C800, R7=$20 (32 entries)
  Calls $06003CB4 with stride $10 (16 bytes), BYTE flag at offset +0
  This is NOT the entity descriptor structure at $0600C344 (stride $14, WORD flag)

**Main 3D Huffman render** (Master SH2 dispatch, not entity loops):
  File $24AD0 (cached $06004AD0): loads R9=@$20004028 (COMM4 = scene data pointer)
  Handles compressed/Huffman scene data, BSR $02224B00 for decompression
  This is the ACTIVE rendering system during racing (entity loops are NOT used)
```

### COMM Register Map (Critical — Hardware vs Sega Naming)

**Sega's internal slave code calls the register at $20004024 "COMM1". Hardware numbering
calls it COMM2. VRD documentation uses hardware numbering (COMM0–COMM7).**

| VRD Name | 68K Addr | SH2 Addr | R8 offset | Current Usage | Hazards |
|----------|:--------:|:--------:|:---------:|---------------|---------|
| **COMM0** | `$A15120` | `$20004020` | +0 | Trigger (HI=$22) + dispatch index (LO=$22) for B-004; $0101 for original game cmds | R/W race = undefined |
| **COMM1** | `$A15122` | `$20004022` | +2 | **System signal — NEVER repurpose.** hw_init_short clears then sets bit 0 ("done"). V-INT/scene-init/frame-swap poll it. | Never write arbitrary data |
| **COMM2** | `$A15124` | `$20004024` | +4 | Slave polls COMM2_HI for work dispatch (Sega calls this register "COMM1"). B-004: A0 src ptr HI. B-003: pixel width. | Slave race window if non-zero before COMM0 trigger |
| **COMM3** | `$A15126` | `$20004026` | +6 | B-004: A0 src ptr LO. B-003: pixel height. | — |
| **COMM4** | `$A15128` | `$20004028` | +8 | B-004: A1 dst ptr HI. B-003: data ptr HI. 68K longword write = COMM4+5 atomic. | — |
| **COMM5** | `$A1512A` | `$2000402A` | +10 | B-004: A1 dst ptr LO. B-003: data ptr LO. Vertex transform counter. | — |
| **COMM6** | `$A1512C` | `$2000402C` | +12 | B-004: D1/height (HI) + D0/2 words-per-row (LO). B-003: add value (LO). Original: handshake. | — |
| **COMM7** | `$A1512E` | `$2000402E` | +14 | Slave doorbell: $0027=cmd_27 work (B-003), $0000=idle. **Never write game cmd bytes.** | B-006 crash: 0x27 game cmd collides with expansion signal |

**SH2 register access:** Always use cache-through prefix `$20004020`, never `$00004020`.
**Write buffer:** After `mov.w rN,@r8`, dummy-read same address to force flush before other CPU reads.
**Access widths:** Byte = 1 register byte; Word = 1 register (16-bit); Longword = 2 adjacent registers.

### Memory Map

#### 68K Address Space
```
$000000–$7FFFFF   ROM (read-only)
$A10000–$A1FFFF   I/O and 32X adapter registers
  $A15120–$A1512E   COMM registers (COMM0–COMM7)
  $A15104           32X Bank Set register
$FF0000–$FFFFFF   68K Work RAM (NOT accessible from SH2 at any address)
```

#### SH2 Address Space
```
$00000000–$01FFFFFF   Boot ROM / unmapped (avoid)
$02000000–$0203FFFF   ROM Cartridge (cached)
$06000000–$0603FFFF   SDRAM (256 KB) — shared with 68K via COMM/DREQ
$02300000–$023FFFFF   Expansion ROM (1 MB, SH2-executable only)
$04000000–$041FFFFF   Frame Buffer (FM bit controls access)
$06000000–$06FFFFFE   SDRAM mirror (cached alias = $02000000 range)
$20004020–$2000402E   COMM registers (cache-through — ALWAYS use $20xxxxxx, NOT $00xxxxxx)
$24000000–$241FFFFF   Frame Buffer (cache-through variant)
UNMAPPED: $0204000–$03FFFFFF (between SDRAM and expansion ROM)
UNMAPPED: $0204000–$03FFFFFF, $25000000–$3FFFFFFF, etc.
```

**SH2 CANNOT access 68K Work RAM.** $02FFFB00, $22FFFB00 — all variants unmapped. Proven by 3 failed B-003 attempts before reading the hardware manual.

**Shared writable memory (exhaustive list):**
1. COMM registers ($20004020–$2000402E, 16 bytes)
2. SDRAM ($02000000–$0203FFFF, 256 KB)
3. Frame Buffer ($04000000 / $24000000, FM bit controlled)

### Address Mapping Formulas

```
68K: cpu_addr = file_offset + 0x00880000
SH2: cpu_addr = file_offset + 0x02000000
SH2 SDRAM ($0600xxxx): file_offset = cpu_addr - 0x06000000 + 0x00020000
                       i.e., $0600xxxx = ROM file offset $20000 + xxxx
```

Example: `$06000780` (jump table base) = ROM file offset `$20780`.

### Master SH2 Dispatch Mechanism

**Idle loop:** SDRAM `$020460`–`$020476` (R8 = $20004020 = COMM base)

```
$020460: MOV.B  @R8,R0        ; R0 = COMM0_HI ($20004020) — TRIGGER FLAG
$020462: TST    R0,R0         ; non-zero?
$020464: BT     $020460       ; no → keep polling
$020466: NOP
$020468: MOV.B  @(1,R8),R0   ; R0 = COMM0_LO ($20004021) — DISPATCH INDEX
$02046A: SHLL2  R0            ; index × 4
$02046C: MOV.L  @(R0,table),R1 ; load handler address from jump table
$020470: JSR    @R1            ; call handler (PR = return address)
$020472: NOP
$020474: BRA    $020460        ; loop
$020476: NOP
```

**Jump table:** Base `$06000780`, entries × 4 bytes.
- Index $01 (original game cmds, COMM0=$0101) → `$06000784` → general handler `$060008A0`
- Index $22 (B-004, COMM0=$2222) → `$06000808` → expansion ROM `$023010F0`

**hw_init_short** (`$060043F0`): Completion signal. Clears COMM0:1 (32-bit zero to $20004020), then sets COMM1_LO bit 0 ("done").

### Key Addresses

| Address | CPU | Name | Purpose |
|---------|-----|------|---------|
| `$001684` | 68K | V-INT handler | Fires every 16.67ms, state dispatcher |
| `$E3B4` | 68K | sh2_cmd_27 | Pixel fill command (21 calls/frame, B-003 async) |
| `$E35A` | 68K | sh2_send_cmd | 2D block copy (14 calls/frame, B-004 single-shot) |
| `$E316` | 68K | sh2_send_cmd_wait | Blocking wait + send (original, expensive) |
| `$020460` | SH2 | Master dispatch loop | Poll COMM0, decode, dispatch |
| `$020608` | SH2 | inline_slave_drain (B-003) | Slave pixel processor, reads COMM2-6 |
| `$060043F0` | SH2 | hw_init_short | COMM0:1 clear + done signal |
| `$06000780` | SH2 | Jump table base | 256 entries × 4B |
| `$023010F0` | SH2 | cmd22_single_shot (B-004) | Single-shot 2D block copy handler |

---

## Section 3: Known Pitfalls (Top 15 Critical)

### 🔴 CRITICAL (caused real crashes/corruption)

1. **SH2 cannot access 68K Work RAM at any address** — $FF0000, $02FFFB00, $22FFFB00 all unmapped. Use COMM registers or SDRAM only. (3 failed B-003 attempts)

2. **COMM7 namespace collision** — B-006 crash: game cmd 0x27 (21×/frame) written to COMM7 → triggered cmd27_queue_drain on Slave with uninitialized queue → crash. Never broadcast game command bytes to COMM7.

3. **SH2 literal pool sharing** — B-006 Patch #2: placed literal at $020480, which `D011@$020438` also loads. Silently redirected init JSR. Always scan for `$Dnxx` opcodes before overwriting any SH2 address.

4. **COMM1 is a system signal register** — hw_init_short, V-INT, scene-init, frame-swap all read COMM1. Writing arbitrary data (e.g., a height param) corrupts all simultaneously. B-004 v5 was redesigned specifically to avoid COMM1.

5. **Read-during-write = undefined** — Not just write-write. If one CPU writes while the other reads the SAME register, result is undefined. Always sequence via handshakes on a DIFFERENT register.

6. **SH2 write buffer is asynchronous** — `mov.w rN,@rM` does NOT immediately reach the register. Dummy-read the same address to force completion before the other CPU reads.

7. **Test SH2 patches in isolation** — Interacting patches hide root causes. B-006: reverting only Patch #2 was insufficient; Patches #1+#3 together also crashed. Always test each patch alone first.

### 🟠 HIGH (silent bugs, hours to debug)

8. **SH2 `.align N` uses power-of-2 semantics** — `.align 1`=2B, `.align 2`=4B, `.align 4`=16B. Using `.align 4` inflates code and shifts all PC-relative displacements.

9. **SH2 `@(disp,Rm)` uses byte offsets** — `mov.w @(2,r8),r0` = R8+2 bytes (not scaled). `mov.l @(4,r8),r0` = R8+4 bytes. Assembler does the scaling internally.

10. **SH2 MOV Rm,Rn field order** — Opcode `0110 nnnn mmmm 0011`: n=DESTINATION, m=SOURCE. Easy to swap. Always verify against ROM bytes.

11. **vasm 68K indexed mode confusion** — `dc.w $31BC,$0000,$2000` is `move.w #$0000,(a0,d2.w)` NOT `move.w #$0000,$2000(a0)`. $2000 is the extension word (D2.W index, disp=0).

12. **BSR.W vs JSR (d16,PC)** — `BSR.W`=$6100, `JSR (d16,PC)`=$4EBA. VRD uses JSR. Use `jsr label(pc)` not `bsr.w`.

13. **SDRAM offset formula** — `$0600xxxx` = ROM file offset `$20000 + xxxx`. Getting this wrong gives 68K code hex instead of SH2 SDRAM content.

8. **Section packing with hardcoded absolute address tables** — code_6200 and code_A200 are packed to exact 8192-byte boundaries. Both contain jump tables with hardcoded absolute 68K CPU addresses (DC.W $0088 + MOVEQ trick in object_type_dispatch, DC.L $0088xxxx in entity_type_dispatch_tables). Adding ANY bytes shifts subsequent code, breaking the tables. Cross-section absolute JSR references also target code_A200. Proven crash: +6 bytes in entity_pos_update crashed 3D engine in attract mode. **Rule:** never add/remove bytes in these sections — only modify constant values within existing instructions.

9. **Synchronous COMM offload overhead** — Offloading small, frequently-called functions via COMM registers is **slower** than running them natively on 68K. Each COMM round-trip costs ~200-500 68K cycles of polling + register I/O, and every call waits for ALL prior COMM commands to finish (COMM0_HI is a global busy flag). `angle_normalize` offload added 23% 68K time vs 1.2% saved. Only offload functions where computation >> handshake × call_count. Batch or async required for small functions.

### 🟡 MEDIUM (subtle, easy to miss)

14. **SH2 disassembler display address uses +$02200000, not +$02000000** — CLAUDE.md states "SH2: cpu_addr = file_offset + $02000000" but the sh2_disasm.py tool actually displays file_offset + $02200000 (cache-through base). Verified empirically: file $239F0 + $02200000 = $022239F0. When cross-referencing disassembler output with ROM file offsets, use the $02200000 formula for display addresses, $06000000 offset formula for $0600xxxx SDRAM refs.

15. **MOVE.W #$0000,(addr).W ≠ CLR.W (addr).W** — Different encodings (6 bytes vs 4 bytes). Never substitute one for the other when byte-matching original ROM.

15. **Sega's "COMM1" = hardware COMM2 ($20004024)** — Sega's slave source calls $20004024 "COMM1". VRD docs use hardware register index (COMM2). When reading Sega's internal code comments, their COMM1 = our COMM2.

---

## Section 4: Where-to-Find Cross-Reference

| Topic | Primary | Secondary |
|-------|---------|-----------|
| COMM register addresses + byte layout | analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md | analysis/68K_SH2_COMMUNICATION.md |
| COMM hazards (races, write buffer, hazard rules) | analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md | KNOWN_ISSUES.md §COMM |
| Master SH2 dispatch (COMM0 trigger/index, jump table) | analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md | analysis/68K_SH2_COMMUNICATION.md §B-004 |
| Memory map (SDRAM, Frame Buffer, unmapped regions) | docs/32x-hardware-manual.md | CLAUDE.md §Memory Boundaries |
| SH2 address mapping formula ($0600xxxx) | CLAUDE.md §ROM Address Mapping | KNOWN_ISSUES.md §SDRAM offset |
| Slave SH2 behavior (polling, dispatch, pixel processing) | analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md | analysis/SYSTEM_EXECUTION_FLOW.md |
| Frame execution flow (V-INT, main loop, state dispatch) | analysis/SYSTEM_EXECUTION_FLOW.md | analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md |
| Profiling methodology + tool usage | tools/libretro-profiling/README_68K_PC_PROFILING.md | analysis/profiling/68K_BOTTLENECK_ANALYSIS.md |
| Expansion ROM layout + active handlers | disasm/sections/expansion_300000.asm | BACKLOG.md §B-003/B-004 |
| B-003 async cmd_27 design | BACKLOG.md §B-003 | analysis/68K_SH2_COMMUNICATION.md §B-003 |
| B-004 single-shot cmd_22 design | BACKLOG.md §B-004 | analysis/68K_SH2_COMMUNICATION.md §B-004 |
| 3D pipeline (vertex transform, rasterization) | analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md | analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md |
| 3D engine data structures (color, reciprocal table, shading) | analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md | analysis/architecture/DATA_STRUCTURES.md |
| Slave SH2 entity loop dispatch (COMM0 → scene orchestrator → callers) | oracle/index.md §Slave SH2 Entity Loop Dispatch Architecture | analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md |
| Entity descriptor base addresses (R14) + model data pointers (R13) | oracle/index.md §Slave SH2 Entity Loop Dispatch Architecture | ROM file offsets $2C754, $2C344, $2C3A8, $2C448, $2C4AC, $2C63C |
| Entity loop function pointers + call sites | oracle/index.md §Slave SH2 Entity Loop Dispatch Architecture | ROM literal pool at file $21120–$21150 |
| Slave secondary dispatch (COMM2-register based, $022205C4) | oracle/index.md §Slave SH2 Entity Loop Dispatch Architecture | ROM file $205C4 |
| SH2 disassembler address formula (display = file + $02200000) | oracle/index.md §Slave SH2 Entity Loop Dispatch Architecture | Empirically verified — CLAUDE.md formula ($02000000) is incorrect for display |
| Color pipeline (8bpp palette, AND $FF00, SWAP.B) | analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md §5 | disasm/sh2/3d_engine/edge_scan_short.asm |
| Reciprocal lookup table (256 entries, 0.14 fixed-point) | analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md §4 | analysis/architecture/DATA_STRUCTURES.md |
| Gradient strip data (ramps + dithering masks) | analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md §6 | disasm/sh2/3d_engine/raster_batch.asm |
| FIFO burst feasibility (B-009, NOT feasible) | BACKLOG.md §B-009 | OPTIMIZATION_PLAN.md §Abandoned Approaches |
| V-blank sync (51.89% STOP) | analysis/architecture/VBLANK_PERFORMANCE_ANALYSIS.md | OPTIMIZATION_PLAN.md §Ground Truth |
| Main loop ($FF0000) + STOP instruction | analysis/architecture/VBLANK_PERFORMANCE_ANALYSIS.md §3 | disasm/modules/68k/main-loop/ |
| V-INT state machine (21+ states) | analysis/architecture/VINT_STATE_HANDLERS.md | analysis/architecture/VINT_HANDLER_ARCHITECTURE.md |
| $C87E adaptive state machine (SH2 completion) | OPTIMIZATION_PLAN.md §V-INT State Machine | disasm/modules/68k/game/render/vdp_dma_frame_swap_037.asm |
| LOD culling (S-1, IMPLEMENTED) | disasm/modules/68k/game/render/object_table_sprite_param_update.asm | disasm/sections/code_1c200.asm |
| JMP trampoline pattern (relocation technique) | disasm/sections/code_2200.asm (lines 81-85) | CLAUDE.md §Architecture |
| SH2 workload reduction strategy (path to 30 FPS) | OPTIMIZATION_PLAN.md §Phase 2 | analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md |
| COMM offload cost model + failed angle_normalize | OPTIMIZATION_PLAN.md §Completed Work (lessons) | KNOWN_ISSUES.md §Abandoned Approaches |
| cmd_22 queue decoupling (Phase 4) | OPTIMIZATION_PLAN.md §Phase 4 | BACKLOG.md |
| FPS threshold model (SH2-limited) | OPTIMIZATION_PLAN.md §FPS Threshold Analysis | analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md |
| 30 FPS path (~15% Slave SH2 reduction via LOD culling) | OPTIMIZATION_PLAN.md §Phase 2 | BACKLOG.md |
| Rendering pipeline (V-INT → VDP compositing) | analysis/RENDERING_PIPELINE.md | analysis/SYSTEM_EXECUTION_FLOW.md |
| Assembly translation pitfalls (68K dc.w) | KNOWN_ISSUES.md §68K Assembly Translation | CLAUDE.md ground rule 4 |
| SH2 assembly pitfalls (gas assembler) | KNOWN_ISSUES.md §SH2 Assembly Translation | docs/sh1-sh2-cpu-core-architecture.md |
| Function lookup by address | analysis/FUNCTION_QUICK_LOOKUP.md (Ctrl+F) | analysis/MASTER_FUNCTION_REFERENCE.md |
| B-006 crash root cause (COMM7 collision) | analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md | KNOWN_ISSUES.md §COMM7 Namespace |
| VDP polling and async safety | analysis/VDP_POLLING_ANALYSIS.md | KNOWN_ISSUES.md §VDP |
| SH2 bottleneck proof (78.3% Slave, 51.89% 68K idle) | analysis/profiling/68K_BOTTLENECK_ANALYSIS.md | OPTIMIZATION_PLAN.md §Ground Truth |
| Entity/object field offset map (consolidated) | analysis/architecture/GAME_LOGIC_AI_PHYSICS.md §Object/Entity Structure Offsets | Source module headers (28 annotated modules) |
| Force integration algorithm (drag, friction, air resistance) | analysis/architecture/GAME_LOGIC_AI_PHYSICS.md §Force Integration Model | disasm/modules/68k/game/physics/entity_force_integration_and_speed_calc.asm |
| Drift physics (speed×steer×slope interaction) | analysis/architecture/GAME_LOGIC_AI_PHYSICS.md §Drift Physics Model | disasm/modules/68k/game/camera/drift_physics_and_camera_offset_calc.asm |
| AI 4-band approach ramp (spawn distance control) | analysis/architecture/GAME_LOGIC_AI_PHYSICS.md §AI 4-Band Approach Ramp | disasm/modules/68k/game/ai/ai_entity_main_update_orch.asm |
| Track boundary collision (center + 4-probe) | analysis/architecture/GAME_LOGIC_AI_PHYSICS.md §Track Boundary Collision | disasm/modules/68k/game/collision/track_boundary_collision_detection.asm |
| Multi-panel tile rendering (split-screen) | analysis/RENDERING_PIPELINE.md §Multi-Panel Tile Rendering | disasm/modules/68k/game/render/sh2_multi_panel_tile_renderer.asm |
| Fixed-point math conventions (>>5, >>7, >>8, >>10) | analysis/architecture/GAME_LOGIC_AI_PHYSICS.md §Force Integration Model | Source module inline comments |
| Section packing constraint (code_6200, code_A200) | KNOWN_ISSUES.md §Section Packing | OPTIMIZATION_PLAN.md §S-4b |
| Speed lookup table (384 entries, $19DA4, only ref = speed_interpolation) | disasm/sections/code_18200.asm (lines 3464+) | disasm/modules/68k/game/physics/speed_interpolation.asm |
| entity_pos_update call sites (15+) and D2 load from A0+$06 | disasm/modules/68k/game/physics/entity_pos_update.asm line 25 | entity_render_pipeline*.asm, ai_entity_main_update_orch.asm |
| S-6 coord_transform inlining (expansion ROM relocation) | disasm/sh2/expansion/coord_transform_batched.inc | KNOWN_ISSUES.md §SH2 State Machine Relocation |
| A-2 Blocker 1 (FS swap timing, V-INT solution) | OPTIMIZATION_PLAN.md §A-2 Blocker 1 | docs/32x-hardware-manual.md (page 35) |
| A-2 Blocker 2 (SH2 render trigger at $060008A0) | OPTIMIZATION_PLAN.md §A-2 Blocker 2 | disasm/sections/code_20200.asm (offset $208A0) |
| SH2 Master cmd $01 handler ($060008A0) — render trigger | disasm/sections/code_20200.asm (offset $208A0) | analysis/68K_SH2_COMMUNICATION.md |

---

## Section 5: Query Protocol

This index is the Navigator agent's sole knowledge source.
The Navigator answers two query types only.

### TYPE 1 — "Where is X?"

Navigator response format: `[file] § [section or heading]`

Use the **Section 4 cross-reference table** above as the primary lookup for common topics.

Examples:
- "Where is the Slave SH2 polling interval documented?"
  → `analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md § Slave Command Polling`
- "Where is the SDRAM offset formula?"
  → `CLAUDE.md § ROM Address Mapping` + `KNOWN_ISSUES.md § SDRAM offset formula`

### TYPE 2 — "Is there a known pitfall for X?"

Navigator response format: `KNOWN_ISSUES.md § [section] — [one-line summary]`

Example:
- "Is there a known pitfall for .align in SH2 gas?"
  → `KNOWN_ISSUES.md § SH2 gas .align N — power-of-2: .align 2 = 4-byte boundary`

### What the Navigator does NOT do

- Never answers "What is X?" from memory
- Never summarizes document content
- Never loads additional files speculatively
- If something is not in this index: "Not in index. Most likely: [best candidate file]"

### Current project state

**Backlog status, expansion ROM map, and build state are NOT tracked here.**
They go stale after every session.
Read `BACKLOG.md` directly — it is always current.

### index.md Maintenance

After any session where new facts are established:
- New pitfall discovered → add to Section 3
- New architectural fact confirmed → add to Section 2
- New document created → add to Section 1 + Section 4 cross-reference
- Outdated entry found → correct or remove it

---

## Appendix: Critical DO/DON'T

### NEVER
- Write arbitrary data to COMM1 ($A15122 / $20004022)
- Write game command bytes to COMM7
- Assume SH2 can access $FF0000 or nearby Work RAM
- Overwrite SH2 addresses without scanning for `$Dnxx` literal pool references
- Combine multiple SH2 patches without testing each in isolation
- Use cached COMM addresses ($00004020) — always use cache-through ($20004020)
- Assume $0600xxxx = file offset $xxxx (it's $20000 + xxxx)
- Offload small, frequently-called functions via synchronous COMM (overhead >> computation saved)

### ALWAYS
- Read KNOWN_ISSUES.md before touching COMM registers or SH2 patches
- Read COMM_REGISTERS_HARDWARE_ANALYSIS.md before designing any COMM protocol
- Verify assembled bytes against original ROM with `python3`
- Test with `make clean && make all` after every change
- Test with PicoDrive for at minimum 189 frames covering race mode
- Use FUNCTION_QUICK_LOOKUP.md (Ctrl+F) for address lookups
- Profile before and after with libretro-profiling tools
