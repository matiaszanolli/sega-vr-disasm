# Architectural Overhaul Assessment — Virtua Racing Deluxe 32X

**Date:** March 11, 2026
**Status:** Historical architecture survey; current execution truth is in `../VR60_STATUS.md`
**Purpose:** Comprehensive catalog of WHY the engine architecture limits performance, and EVERY opportunity for improvement. No idea dismissed without evidence.

> **2026-07-21 correction:** Early sections preserve obsolete 14-command, CPU-bottleneck,
> and memory-map assumptions. They are research history, not the current roadmap. Normal 1P
> cadence is dispatcher-controlled, the 68000 remains authoritative, and SH2 cartridge ROM is
> `$02000000` while SDRAM is `$06000000` (cache-through `$26000000`).

---

## Part I: Why Architectural Change Is Necessary

### The Engine's Fundamental Problem

Virtua Racing Deluxe runs at ~20 FPS on hardware capable of much more. The reason is not any single CPU being slow — it's that the three CPUs (68K, Master SH2, Slave SH2) are **coordinated through a serial protocol** that forces each to wait for the others.

This isn't a bug. It's a design choice from 1994, when having three CPUs on a consumer cartridge was unprecedented. The developers at Sega chose correctness and simplicity over throughput: every inter-CPU data transfer completes before the next begins, every frame renders fully before the next starts, and every CPU knows exactly what the others are doing at all times. That reliability came at the cost of parallelism.

### The Serial Coordination Model

The engine's frame pipeline works like an assembly line where each station must finish before the next starts:

```
TV Frame 0 (state 0):  68K does VDP sync, sound    → SH2 renders previous frame
TV Frame 1 (state 4):  68K does sound, counter      → SH2 renders previous frame
TV Frame 2 (state 8):  68K does ALL game logic       → SH2 starts new render
                        └─ 14 sh2_send_cmd calls ─────┘
                           (each blocks until complete)
```

**Result:** 3 TV frames = 1 game frame = ~20 FPS.

### The Six Architectural Constraints

**1. COMM0_HI Is a Global Serialization Barrier**

Every `sh2_send_cmd` call writes parameters to COMM2-6, sets COMM0 = $0101, and then **spins polling COMM0_HI** until the Master SH2 clears it after completing the block copy. This means:
- 68K cannot prepare the next command while the previous one transfers
- Master SH2 cannot overlap copy operations
- 14 calls × ~940 cycles/call = 13,160 cycles of pure wait

This accounts for 10.52% of 68K time — time that could be spent on game logic or eliminated entirely.

**2. Master SH2 Wastes Cycles on Block Copies**

The Master SH2 (23 MHz) spends most of its active time copying data blocks from 68K Work RAM to SDRAM via COMM-parameterized transfers. This is a glorified memcpy — work that a DMA controller should do, not a CPU. The Master finishes at 0-36% utilization while the Slave drowns at 78.3%.

**3. No Culling Architecture**

The original engine sends ALL 15 entities' 3D geometry to the Slave SH2 for rendering, regardless of:
- Distance from the camera (entities behind the horizon)
- Visibility (entities behind the player, off-screen)
- Importance (barely-visible specks vs. nearby competitors)

Every entity gets full vertex transform + frustum cull + rasterization. The S-1 LOD culling patch addresses distance, but the engine has no concept of view frustum culling, occlusion, or level-of-detail at the 68K dispatch level.

**4. Fixed 3-Frame Pipeline Floor**

The $C87E adaptive state machine can **extend** the game frame beyond 3 TV frames if SH2 is slow, but can never **contract** below 3. States 0 and 4 each consume an entire TV frame doing minimal work (sound update, counter increment). Even if SH2 finishes rendering in 1 TV frame, the game still takes 3.

**5. No CPU Work Distribution**

The workload assignment is completely rigid:
- 68K: ALL game logic (physics, AI, collision, sorting, entity management)
- Master SH2: ALL data transfers (block copies via COMM protocol)
- Slave SH2: ALL 3D rendering (vertex transform, culling, rasterization)

There is no mechanism for one CPU to help another. If the Slave SH2 has too many polygons, it just takes longer — the idle Master SH2 cannot assist.

**6. Painter's Algorithm Creates a CPU Dependency Chain**

The 3D engine has no Z-buffer. Instead, the 68K sorts polygons back-to-front using `depth_sort.asm` (painter's algorithm), and the SH2 renders them in that order. This creates a hard dependency: **the 68K must finish sorting before the SH2 can begin rendering**. In a Z-buffered engine, the SH2 could start rendering polygons in any order as they arrive.

### Quantifying the Waste

| Resource | Available | Used | Wasted | Wasted Because |
|----------|-----------|------|--------|----------------|
| 68K cycles | 128K/TV frame | ~49K | ~79K (62%) | STOP idle — waiting for V-INT |
| Master SH2 cycles | 384K/TV frame | 0-138K | 246-384K (64-100%) | Idle between block copies |
| Slave SH2 cycles | 384K/TV frame | ~300K | ~84K (22%) | Efficient but overloaded |
| TV frames per game | 3 | 1 (state 8) | 2 (states 0+4) | Rigid pipeline structure |

The engine wastes **~65% of total available compute** across all three CPUs per game frame due to serialization, idle waiting, and rigid work assignment.

### Why Micro-Optimizations Cannot Fix This

We proved this empirically. March 2026 optimizations freed ~84M 68K cycles across 2400 frames (STOP instruction, insertion sort, longword copy). **FPS change: 0%.** All freed cycles became idle time because the bottleneck is structural, not computational.

The only path to higher FPS is **architectural change**: restructuring how the CPUs coordinate, what work each does, and how the frame pipeline is organized.

---

## Part II: Opportunity Catalog

### Evaluation Framework

Each opportunity is rated on:
- **FPS Impact:** Does this directly reduce time-to-frame? (High/Medium/Low/None)
- **Feasibility:** How hard to implement given our tooling? (Easy/Moderate/Hard/Research)
- **Risk:** What can go wrong? (Low/Medium/High)
- **Dependencies:** What must be done first?

### Category 1: COMM Protocol Redesign

#### 1A. SDRAM Command Queue (Replace Synchronous Handshakes)

**Concept:** Instead of 14 synchronous COMM round-trips per frame, the 68K writes all command parameters to a pre-allocated SDRAM buffer, then sends a single COMM signal. Master SH2 processes the entire queue at once.

**How it works:**
1. 68K writes command params directly to SDRAM via... wait. Can the 68K write to SDRAM?
   - **68K cannot directly access SH2 SDRAM.** SDRAM is at `$06000000-$0603FFFF` on SH2, not mapped to any 68K address.
   - Shared writable memory: COMM registers (16 bytes), SDRAM (via SH2 only), Frame Buffer (FM-controlled).
   - The 68K CAN access ROM at banked addresses, but ROM is read-only.

**Revised approach:** 68K writes to COMM registers in rapid succession (no wait for completion). Master SH2 captures parameters to SDRAM queue on each COMM0 trigger, clears COMM0_HI immediately (before doing the actual copy), then processes all queued copies after the last one arrives.

**FPS Impact:** Low directly (freed 68K cycles become STOP time), but **enables 1B and 1C**.
**Feasibility:** Moderate — queue management in SH2 expansion ROM, early COMM0_HI clear timing.
**Risk:** Medium — B-005 proved early COMM0_HI clear causes display corruption if 68K races ahead of copies. Need explicit "all copies done" barrier before frame flip.
**Dependencies:** None.

#### 1B. Batch Copy With DMA-Style Transfer

**Concept:** Instead of individual block copies, the Master SH2 receives a descriptor list (source, dest, size) and processes all copies in a single batch, potentially reordering for SDRAM cache efficiency.

**FPS Impact:** Low (Master SH2 headroom), but enables Master SH2 to finish copies faster → start rendering earlier.
**Feasibility:** Moderate.
**Risk:** Low.
**Dependencies:** 1A (command queue).

#### 1C. Eliminate COMM Copies Entirely

**Concept:** Can the data flow be restructured so SH2 reads directly from where the 68K already has the data?

The 68K writes entity data to Work RAM ($FF0000+). SH2 cannot access Work RAM. But what if entity data is computed directly in a shared location?

- **Option A:** 68K writes entity render parameters directly to SDRAM via Frame Buffer + creative addressing. (Unlikely — FB is pixel data, not general RAM.)
- **Option B:** Use the frame buffer as a general data mailbox during non-display periods (when FM bit allows 68K access). (Possible but FB access has FIFO constraints.)
- **Option C:** Expand COMM register usage — pack more data per transaction, reduce call count from 14 to fewer larger transfers.
- **Option D:** 68K writes to ROM-bankable area... but ROM is read-only from 68K.

**FPS Impact:** Medium — eliminating the copy step entirely would free Master SH2 for rendering.
**Feasibility:** Research needed — no obvious shared writable memory large enough.
**Risk:** High.
**Dependencies:** Deep understanding of what data each copy transfers and whether SH2 can compute it locally.

---

### Category 2: CPU Work Redistribution

#### 2A. Master SH2 Assists With 3D Rendering

**Concept:** The Master SH2 is 0-36% utilized. The Slave SH2 is at 78.3%. Move some rendering work to Master.

**Possible partitioning:**
- **Object-level split:** Master renders entities 0-7, Slave renders 8-14. Each writes to different frame buffer regions.
- **Pipeline-level split:** Master does vertex transform + culling, Slave does rasterization.
- **Temporal split:** Master renders even-frame entities, Slave renders odd-frame entities. (Creates visual flicker — probably unacceptable.)

**Challenges:**
- SH2 code is in dc.w (raw opcodes). Modifying it requires understanding the entire 3D pipeline.
- Frame buffer write contention — both SH2s writing to the same buffer creates bus conflicts.
- The 3D pipeline is monolithic — there's no clean split point between "do this half" and "do that half."

**FPS Impact:** High — if 50% of Slave rendering moves to Master, Slave drops from 2.35 to ~1.2 TV frames → 30 FPS trivially achievable.
**Feasibility:** Hard — requires SH2 code modification (dc.w format) and solving FB contention.
**Risk:** High.
**Dependencies:** Full understanding of SH2 3D pipeline data flow.

#### 2B. 68K Assists With Vertex Transform

**Concept:** The 68K has 51.89% idle time. Use it to pre-compute vertex transforms or sorting that the SH2 currently does.

The 68K already does depth sorting (painter's algorithm). Could it also:
- Pre-transform vertices to screen space? (68K has no MAC.L hardware — would be slower per vertex.)
- Pre-classify visibility? (The 68K already checks entity positions — could flag which polygons are visible.)
- Pre-sort the polygon submission order for SH2 cache efficiency?

**FPS Impact:** Low-Medium — 68K at 7.67 MHz doing work that SH2 does at 23 MHz is inherently slower per operation, but parallel with SH2.
**Feasibility:** Moderate — 68K-side changes only, no SH2 modification.
**Risk:** Low — falls back gracefully (just send less pre-computed data).
**Dependencies:** Understanding what SH2 vertex transform actually needs as input.

#### 2C. Offload 68K Game Logic to Master SH2

**Concept:** Move some game logic from 68K to Master SH2. AI, physics, or collision detection could run on the Master SH2 while the 68K handles other tasks.

**Problem:** Game logic reads/writes 68K Work RAM extensively. SH2 cannot access Work RAM. All data would need to flow through COMM registers or SDRAM — the overhead would likely exceed the savings.

**FPS Impact:** None (68K has spare capacity — this doesn't help).
**Feasibility:** Hard.
**Risk:** High.
**Dependencies:** Shared memory solution.
**Verdict:** Not useful unless 68K becomes a bottleneck again.

---

### Category 3: Frame Pipeline Restructuring

#### 3A. Merge States 0+4 (2-Frame Game Loop)

**Concept:** Combine the minimal-work states 0 and 4 into a single TV frame. The game frame becomes 2 TV frames instead of 3.

**Mechanism:** In each race dispatcher, advance $C87E by 8 instead of 4 from the combined state. State 8 fires on the second TV frame.

**FPS Impact:** High — directly converts 3→2 TV frames per game frame (20 FPS → 30 FPS), **IF** SH2 finishes rendering in ≤2 TV frames.
**Feasibility:** Easy — 68K-only changes in 4-5 dispatcher files.
**Risk:** Low.
**Dependencies:** SH2 render time must be ≤2 TV frames (S-1 LOD culling or similar).

#### 3B. Split Game Logic Across States

**Concept:** Instead of cramming ALL game logic into state 8, distribute it:
- State 0: AI + collision detection
- State 4: Physics + entity updates
- State 8: Rendering submission only

**Benefits:**
- State 8 finishes faster → SH2 gets commands earlier → more render time
- Each TV frame has balanced 68K workload (better for consistent timing)

**FPS Impact:** Medium — SH2 gets render commands sooner.
**Feasibility:** Moderate — requires careful analysis of data dependencies between game logic phases.
**Risk:** Medium — game logic may have ordering dependencies (AI reads physics results, etc.).
**Dependencies:** Full data dependency analysis of game_frame_orch_013.asm.

#### 3C. Pipelined Frame Overlap (Track C)

**Concept:** Frame N's rendering overlaps with frame N+1's game logic. The 68K starts computing the next frame while SH2 still renders the current one.

The engine already has 1-frame overlap (state 8 sends commands, SH2 renders during states 0+4 of the NEXT game frame). Deepening this to 2-frame overlap would allow 60 FPS.

**FPS Impact:** Very High — potentially enables 60 FPS.
**Feasibility:** Hard — requires double-buffering all game state, not just the frame buffer.
**Risk:** High — introduces 1-frame input latency, visual state may be inconsistent.
**Dependencies:** Everything else working at 30 FPS first.

---

### Category 4: Culling Architecture

#### 4A. View Frustum Culling (68K Side)

**Concept:** Before sending entity data to SH2, check if the entity is within the camera's view frustum. Entities behind the player or far to the side → skip render commands entirely.

The 68K already has camera position and orientation. A simple dot product + threshold can determine if an entity is in the ~60° forward cone.

**FPS Impact:** High — entities behind the camera are currently rendered then culled by SH2's frustum_cull_short. Culling them on 68K saves the full vertex transform + cull cost on SH2.
**Feasibility:** Easy — 68K math, no SH2 changes. Similar to S-1 LOD but angle-based instead of distance-based.
**Risk:** Low — if the check is slightly conservative (wider cone than actual FOV), no visual artifacts.
**Dependencies:** Camera angle/orientation must be accessible at the point where render commands are issued. Need to verify entity position is in world space at that point.

#### 4B. Screen-Space Bounding Box Pre-Check

**Concept:** The 68K already computes scaled positions in `object_table_sprite_param_update`. If the scaled position puts the entity's bounding box entirely off-screen, skip the render command.

**FPS Impact:** Medium — catches entities that pass the LOD distance check but are off to the side.
**Feasibility:** Easy — add bounds check to existing scaled position computation.
**Risk:** Low.
**Dependencies:** S-1 LOD culling (already implemented).

#### 4C. Polygon Count Per Entity (LOD Levels)

**Concept:** Instead of binary cull/render, have multiple detail levels per entity model. Close entities: full polygon count. Medium distance: simplified model. Far distance: sprite or billboard.

**Problem:** The 3D models are stored as fixed polygon lists in ROM. Creating simplified versions requires either:
- New model data (manual creation or automated decimation)
- Runtime polygon decimation (computationally expensive)
- Sprite substitution (different rendering path)

**FPS Impact:** High — the key optimization for 3D engines since the 1990s.
**Feasibility:** Hard — requires creating alternative model data AND the dispatch logic to select between them.
**Risk:** Medium — visual quality tradeoff at medium distances.
**Dependencies:** Understanding of model data format in ROM.

#### 4D. Temporal Coherence (Skip-Frame Updates)

**Concept:** For entities that didn't move significantly since last frame, skip their full physics/render update. Use last frame's data. Only do a full update every N frames for distant entities.

**FPS Impact:** Medium — reduces both 68K game logic AND SH2 render work.
**Feasibility:** Moderate — need to track per-entity "dirty" flags.
**Risk:** Medium — could cause visible stuttering for distant entities.
**Dependencies:** None.

---

### Category 5: 3D Pipeline Optimization (SH2 Side)

#### 5A. Optimize coord_transform (17% Hotspot)

**Concept:** `coord_transform` (34 bytes at $023368) is the single hottest function — 17% of Slave SH2 time. Called 4× per quad. Any improvement here has 4× amplified impact.

**Analysis already done:** `COORD_TRANSFORM_INLINING_INFEASIBILITY.md` concluded inlining is infeasible due to tight register coupling. But other approaches:
- Reduce the number of coord_transform calls by pre-rejecting invisible quads before vertex packing
- Optimize the coord_transform implementation itself (register renaming, instruction scheduling)
- Use SH2 cache behavior to keep this function always-resident

**FPS Impact:** High — 17% of Slave time.
**Feasibility:** Hard — SH2 dc.w code modification.
**Risk:** High — any encoding error = silent corruption.
**Dependencies:** Full understanding of coord_transform's register inputs/outputs.

#### 5B. SH2 Cache Optimization

**Concept:** The SH2 has 4KB direct-mapped cache. If the hottest 3D pipeline functions fit within cache and don't conflict on cache lines, execution speed increases dramatically.

**Approach:**
- Map the address of each hot SH2 function to its cache line
- Identify cache line conflicts (two functions mapping to the same line)
- Relocate functions in SDRAM or expansion ROM to eliminate conflicts

**FPS Impact:** Medium-High — cache misses can double execution time for tight loops.
**Feasibility:** Moderate — requires cache line analysis and potentially relocating SH2 code.
**Risk:** Medium — cache behavior is sensitive to alignment.
**Dependencies:** SH2 PC hotspot profiling (which functions are cache-resident).

#### 5C. Reduce Reciprocal Table Lookups

**Concept:** `span_filler` uses a 256-entry reciprocal table for 1/ΔY computation. The table lookup requires a memory read that may cache-miss. For common ΔY values (1-8), inline the reciprocal as an immediate.

**FPS Impact:** Low-Medium.
**Feasibility:** Moderate — SH2 code modification with small scope.
**Risk:** Low.
**Dependencies:** Profiling data on ΔY distribution.

---

### Category 6: Approximate Math for Small Resolution

#### 6A. Reduced-Precision Vertex Transform

**Concept:** The display is 320×224. A pixel is ~0.3% of screen width. The vertex transform uses 32-bit MAC.L for full precision, but the final screen coordinates only need ~10 bits (0-320, 0-224). Earlier stages of the pipeline could use 16-bit precision without visible artifacts.

**Approach:** Replace the 4×4 matrix multiply (MAC.L, 32-bit) with a 16-bit version (MULS.W) for entities beyond a certain distance. Close entities get full precision, distant ones get approximate transform.

**FPS Impact:** Medium — MAC.L takes ~45 cycles/vertex. MULS.W could be ~20 cycles/vertex for distant objects.
**Feasibility:** Hard — requires SH2 code modification with an alternate code path.
**Risk:** Medium — visual artifacts at boundary between precision levels.
**Dependencies:** Understanding of which pipeline stages need full precision vs. can tolerate error.

#### 6B. 68K Sine/Cosine Table Expansion

**Concept:** The 68K calls `sine_cosine_quadrant_lookup` and `angle_to_sine` repeatedly. These use a 256-entry table with quadrant mirroring. A larger direct table (1024 entries, no mirroring) would eliminate the quadrant logic and serve results directly.

**FPS Impact:** None (68K has spare capacity).
**Feasibility:** Easy — ROM space available.
**Risk:** Low.
**Dependencies:** None.
**Note:** Only relevant if 68K becomes a bottleneck again or for code quality.

#### 6C. Precomputed Entity-to-Screen Projection

**Concept:** For entities at known track positions, precompute the screen-space bounding box per camera angle. Store as a lookup table. This allows the 68K to know if an entity is on-screen without any 3D math.

**FPS Impact:** Medium — could eliminate 68K-side distance/angle computation AND help SH2 by pre-classifying visibility.
**Feasibility:** Hard — the number of possible (entity_pos, camera_pos, camera_angle) combinations is vast. Only practical with quantization.
**Risk:** Medium — quantization may cause visible popping.
**Dependencies:** Track geometry analysis.

---

### Category 7: Memory Layout & Bank Switching

#### 7A. Bank-Switched Code Sections

**Concept:** The 68K can access 1MB of ROM at $900000-$9FFFFF via the Bank Set Register ($A15104, 2-bit selector). Currently unused during gameplay. This gives access to the full 4MB ROM.

**Use case:** Move menu code, initialization code, and rarely-used handlers to higher ROM banks ($100000+). Free space in the first 512KB ($000000-$07FFFF) for race-critical code, giving the packed 8KB sections breathing room.

**How it works:**
1. Set Bank Register to desired bank (1 word write to $A15104)
2. Access code/data at $900000-$9FFFFF
3. Restore bank when done

**Limitations:**
- Bank switching has latency (register write + pipeline flush)
- Cannot be used for interrupt handlers (V-INT fires at any time → bank may be wrong)
- PC-relative references break across bank boundaries
- SH2 can also access the same ROM area — concurrent 68K/SH2 ROM access gives SH2 priority

**FPS Impact:** None directly, but enables larger functions without trampoline overhead.
**Feasibility:** Moderate — need to identify which code can safely be banked.
**Risk:** Medium — bank state must be carefully managed, especially around interrupts.
**Dependencies:** Mapping of which functions are called from interrupts vs. main thread.

#### 7B. SDRAM Layout Optimization

**Concept:** The SH2 SDRAM (`$06000000-$0603FFFF`, 256KB) holds runtime code/data loaded by the boot process. Layout affects cache performance and bus contention.

**Approach:**
- Separate hot code from hot data in SDRAM to reduce cache line conflicts
- Align frequently-accessed data structures to cache line boundaries
- Place expansion ROM handlers at non-conflicting cache addresses

**FPS Impact:** Medium — directly affects SH2 execution speed.
**Feasibility:** Moderate — requires SDRAM address mapping analysis.
**Risk:** Low — moves data without changing logic.
**Dependencies:** SH2 cache line mapping.

#### 7C. 68K Work RAM Layout

**Concept:** Entity data is stored in $100-byte strides in Work RAM ($FF9100+). This is cache-friendly on modern hardware but may cause bus contention patterns on the 68K.

**Approach:** Reorganize entity fields so that render-critical fields (+$30, +$34, +$C1) are contiguous, reducing the number of cache line/bus accesses during the render parameter computation loop.

**FPS Impact:** Low.
**Feasibility:** Hard — requires changing every field offset reference in the codebase.
**Risk:** High — $100-byte stride is deeply embedded in the engine.
**Dependencies:** Complete field offset map (exists in GAME_LOGIC_AI_PHYSICS.md).

---

### Category 8: VDP & Frame Buffer Optimization

#### 8A. Frame Buffer Write FIFO Exploitation

**Concept:** The 32X frame buffer has a 4-word write FIFO. Continuous writes take 3 cycles, but interrupted sequences take 5 cycles per word. Ensuring the SH2 writes in continuous bursts maximizes throughput.

**FPS Impact:** Low-Medium — affects rasterization speed.
**Feasibility:** Hard — requires understanding SH2 rasterizer write patterns.
**Risk:** Low.
**Dependencies:** B-009 analysis (concluded NOT feasible for func_065 which writes SDRAM, but may apply to actual FB writes in rasterizer).

#### 8B. Reduced Frame Buffer Size

**Concept:** If the 3D viewport doesn't need the full 320×224, rendering a smaller area (e.g., 256×192) reduces SH2 rasterization work proportionally. The HUD overlay on the Genesis VDP layer hides the reduced border.

**FPS Impact:** Medium — 25-30% fewer pixels = proportional SH2 reduction.
**Feasibility:** Moderate — requires VDP line table reconfiguration and adjusting the SH2 viewport bounds.
**Risk:** Medium — visual quality reduction, may affect HUD layout.
**Dependencies:** Understanding of VDP line table configuration.

---

### Category 9: Data-Driven Optimizations

#### 9A. Track-Specific Polygon Budgets

**Concept:** Some tracks have more complex geometry than others. Set per-track polygon limits and cull distance thresholds. Simple tracks (beginner oval) can afford more distant entities; complex tracks (Grand Prix circuits) need more aggressive culling.

**FPS Impact:** Adaptive — ensures consistent frame rate across tracks.
**Feasibility:** Easy — data-driven parameter tuning.
**Risk:** Low.
**Dependencies:** S-1 LOD culling with configurable threshold.

#### 9B. Dynamic Quality Scaling

**Concept:** Monitor SH2 completion time. If SH2 is finishing late (COMM1 not set by state 4), increase culling distance. If early, decrease it. This auto-adapts quality to maintain target frame rate.

**FPS Impact:** Adaptive — guarantees frame rate target.
**Feasibility:** Moderate — requires feedback mechanism from SH2 to 68K.
**Risk:** Low — conservative default (more culling) is safe.
**Dependencies:** S-1 culling infrastructure (implemented).

---

## Part III: Priority Matrix

### Highest Impact (Directly Enables 30 FPS)

| ID | Opportunity | FPS Impact | Feasibility | Dependencies |
|----|------------|------------|-------------|--------------|
| 4A | View frustum culling (68K side) | High | Easy | Camera data access |
| 3A | Merge states 0+4 (2-frame loop) | High | Easy | SH2 render ≤ 2 TV frames |
| 2A | Master SH2 assists with 3D | High | Hard | SH2 pipeline understanding |
| 5A | coord_transform optimization | High | Hard | SH2 dc.w modification |

### Medium Impact (Improves Headroom)

| ID | Opportunity | FPS Impact | Feasibility | Dependencies |
|----|------------|------------|-------------|--------------|
| 1A | SDRAM command queue | Medium | Moderate | Enables 1B, 2A |
| 4B | Screen-space bounds pre-check | Medium | Easy | S-1 implemented |
| 5B | SH2 cache optimization | Medium-High | Moderate | Cache line analysis |
| 8B | Reduced frame buffer | Medium | Moderate | VDP line table |
| 9B | Dynamic quality scaling | Adaptive | Moderate | S-1 implemented |

### Research Required (High Potential, Unknown Feasibility)

| ID | Opportunity | FPS Impact | Feasibility | What We Need to Learn |
|----|------------|------------|-------------|----------------------|
| 4C | LOD polygon levels | High | Hard | Model data format, how to create simplified models |
| 6A | Reduced-precision vertex transform | Medium | Hard | Precision requirements per pipeline stage |
| 3C | Pipelined frame overlap | Very High | Hard | Game state double-buffering feasibility |
| 1C | Eliminate COMM copies | Medium | Research | Shared memory alternatives |

### Low Priority (Quality of Life / Future Insurance)

| ID | Opportunity | Note |
|----|------------|------|
| 7A | Bank-switched code | Enables larger functions, no FPS impact |
| 6B | Expanded sine table | Cleaner code, no FPS impact |
| 7C | Work RAM layout | High risk, low reward |
| 2C | Offload to Master SH2 | 68K has spare capacity — not needed |

---

## Part IV: Recommended Attack Sequence

```
Phase 0: Foundation (now)
├─ Profile LOD culling impact (S-1 already implemented)
├─ Measure Slave SH2 render time reduction with culling active
└─ Establish baseline for 30 FPS feasibility

Phase 1: Low-Hanging Fruit (68K-side culling)
├─ 4A: View frustum culling — skip entities behind camera
├─ 4B: Screen-space bounds pre-check — skip off-screen entities
├─ 9A: Track-specific cull distances
└─ Profile → measure Slave SH2 reduction

Phase 2: Frame Pipeline (if SH2 ≤ 2 TV frames after Phase 1)
├─ 3A: Merge states 0+4 → 2-frame game loop
├─ 9B: Dynamic quality scaling (maintain 30 FPS)
└─ Profile → confirm 30 FPS achieved

Phase 3: SH2 Deep Work (if 30 FPS not reached by Phase 2)
├─ 5B: SH2 cache line optimization
├─ 5A: coord_transform hotspot analysis
├─ 1A: SDRAM command queue (free Master SH2)
└─ 2A: Master SH2 rendering assist

Phase 4: Stretch (60 FPS)
├─ 3C: Pipelined frame overlap
├─ 6A: Reduced-precision transforms
└─ 8B: Reduced frame buffer
```

---

## Part V: Open Questions

1. **What is the exact polygon count per entity?** Needed to estimate LOD/culling impact quantitatively.
2. **What does each of the 14 sh2_send_cmd calls transfer?** Needed for batching analysis (1A/1B).
3. **Can the Master SH2 write to frame buffer concurrently with Slave?** FM bit arbitration may prevent this.
4. **What is the SH2 cache line mapping for the 3D pipeline?** Needed for 5B optimization.
5. **What is the camera FOV angle?** Needed for view frustum culling (4A) threshold calculation.
6. **Are there track-specific entity limits?** Beginner tracks may already have fewer AI opponents.
7. **What is the actual pixel rendering cost per polygon?** Fill rate vs. vertex rate — which dominates?
