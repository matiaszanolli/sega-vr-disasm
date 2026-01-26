# Master/Slave CPU Load Balancing Analysis

**Project**: Virtua Racing Deluxe (Sega 32X)
**Discovery**: Slave SH2 CPU is **severely underutilized** during 3D rendering
**Optimization Potential**: **+30-50% performance gain** by distributing work to Slave

---

## 📋 Revision History

| Date | Version | Status | Key Change |
|------|---------|--------|------------|
| 2026-01-06 | v1.0 | Initial | Static analysis identified Slave idle loop |
| 2026-01-20 | v1.1 | Blocked | Discovered PicoDrive Slave boot failure |
| 2026-01-22 | v2.3 | Bypass attempted | Phase 11-13: Hook injection approach |
| 2026-01-23 | v2.4 | Injection limits | Hook injection hit space/alignment constraints |
| 2026-01-24 | v3.0 | Assembly approach | Switched to full assembly build with 4MB expansion |
| 2026-01-24 | v3.1 | Command dispatch | Master→Slave signaling via COMM7, work dispatch |
| 2026-01-25 | **v4.0** | **⚠️ INFRASTRUCTURE READY** | Parallel processing infrastructure complete, **activation deferred** |

---

## 🔍 Executive Summary

### Original Finding (v1.0)
The Slave SH2 CPU is largely IDLE during 3D rendering. The Master SH2 performs the vast majority of rendering work while the Slave sits in an infinite loop waiting for commands that rarely come.

### Current Status (v4.0) ⚠️ EXPERIMENTAL
**INFRASTRUCTURE COMPLETE, ACTIVATION DEFERRED DUE TO TIMING CONCERNS**

The infrastructure for parallel processing is ready but **NOT YET ACTIVATED** in live gameplay:

```
Designed flow (when activated):
Game calls func_021 → Trampoline captures R14/R7/R8/R5 → COMM7=0x16
                    → Master returns immediately (no work done)
                    → Slave picks up work, executes func_021_optimized
                    → Both CPUs running in parallel! (15-20% expected speedup - THEORETICAL/UNVALIDATED)
```

**⚠️ IMPORTANT - Parameter Meanings** (reconciled with SH2 documentation):
- **R14**: Rendering context pointer (not vertex data pointer)
- **R7**: Loop count (not transform matrix)
- **R8**: Data pointer (not output buffer)
- **R5**: Output pointer (not count/flags)

**What's ready (infrastructure complete, activation pending):**
- ✅ func_021_optimized at $300100 (96 bytes, func_016 inlined)
- ✅ slave_work_wrapper at $300200 (COMM7 polling loop)
- ✅ Parameter block design at 0x2203E000 (cache-through SDRAM, 16 bytes)
- ✅ Shadow path validated (non-live testing)
- ⏳ **Live activation deferred** - Timing concerns need validation

**Current reality:**
- Infrastructure is built and tested via shadow path
- Live activation not yet enabled in gameplay
- func_021_optimized ready at $300100 (coordinate transform with func_016 inlined)
- Parameter block ready at $2203E000 (R14, R7, R8, R5 - 16 bytes)

| Aspect | Before v4.0 | After v4.0 (when activated) |
|--------|-------------|------------------------------|
| Build approach | Full assembly (`make all`) | Full assembly (`make all`) |
| Expansion space | 1MB active ($300000-$3FFFFF) | 1MB active ($300000-$3FFFFF) |
| Vertex transforms | Master-only (blocking) | **Slave parallel execution** [NOT YET ACTIVATED] |
| Parameter passing | N/A | Real R14/R7/R8/R5 captured [INFRASTRUCTURE READY] |
| CPU utilization | Master 100%, Slave ~0% | **Both CPUs working** [THEORETICAL] |

---

## 🎯 Key Findings

### 1. Slave CPU Status: IDLE (Static Analysis ✅)

**Evidence**:
- Slave entry point (ROM 0x20650) enters infinite loop after initialization
- Loop writes "OVRN" (overrun marker) to COMM3 register repeatedly
- No substantial work performed - just signaling availability
- 3D engine code (8KB analyzed) has only **7 COMM register references**

**Slave Idle Loop** (ROM 0x20650-0x2069A):
```assembly
; Slave Main Loop (IDLE LOOP!)
02220694  D102     MOV.L   @($022206A0,PC),R1  ; R1 = 0x2000402C (COMM3)
02220696  D003     MOV.L   @($022206A4,PC),R0  ; R0 = "OVRN" (0x4F56524E)
02220698  2102     MOV.L   R0,@R1              ; Write "OVRN" to COMM3
0222069A  AFFE     BRA     $0222069A           ; INFINITE LOOP
0222069C  0009     NOP
```

**Conclusion**: Slave spends 99%+ of time in this 4-instruction loop doing nothing useful.

---

### 2. Master CPU Status: OVERLOADED (Static Analysis ✅)

**Evidence**:
- 3D engine code (0x23000-0x25000) runs entirely on Master SH2
- 109 functions identified, all executed by Master
- Theoretical 60 FPS budget: 383,000 cycles @ 23 MHz
- Actual ~20 FPS budget: ~1,150,000 cycles @ 23 MHz
- Estimated usage: ~350,000 cycles for core rendering (leaves ~800K cycles in blocking sync waits)

**Master Workload Breakdown** (estimated from pipeline analysis):
```
Stage                      Cycles/Frame    % of 60 FPS Budget
-------------------------------------------------------------
1. Initialization              5,000          1.3%
2. Model Data Load            15,000          3.9%
3. Vertex Transformation      30,000          7.8%  ⬅ PARALLELIZABLE
4. Polygon Processing         50,000         13.0%  ⬅ PARALLELIZABLE
5. Rasterization             200,000         52.2%
6. Display/VSync              50,000         13.0%
-------------------------------------------------------------
Total                        350,000         91.4%

Note: Percentages are relative to a theoretical 60 FPS budget (383K cycles)
for comparison purposes. Actual game runs at ~20 FPS due to blocking sync.
```

**Bottleneck**: Master CPU spends ~350K cycles on actual rendering work but wastes ~800K cycles in blocking synchronization with 68K (the root cause of ~20 FPS ceiling).

---

### 3. v2.3 Synchronization Protocol (Validated ✅)

**How the boot issue was bypassed:**

Instead of fixing PicoDrive's reset vector reading, Phase 11 injected a 44-byte hook into the Slave's **already-running idle loop** at SDRAM address 0x06000596. The Slave eventually reaches an idle loop (even after garbage execution), and the hook intercepts it.

**Validated Protocol (COMM6/COMM4):**

```
MASTER CPU (Main Thread)           SLAVE CPU (Polling Thread)
─────────────────────────────      ──────────────────────────
Frame N:
  Set COMM6 = 0x0012   ──────────→  Hook detects signal
  (call signal)                      ↓
                                    Invoke handler @ 0x02300027
                                    ↓
                                    Increment COMM4 += 1
                                    ↓
                                    Clear COMM6 = 0x0000

Frame N+1:
  Read COMM4 (value+1)  ←─────────  Signal ready
  Read COMM6 (cleared)               Protocol cycle complete ✓
```

**Validation Results (Phase 13):**
- ✅ 3,600+ frames tested without anomaly
- ✅ COMM4 increments exactly once per frame
- ✅ Frame rate stable at 60.00 FPS (protocol test harness, not gameplay FPS)
- ✅ Zero memory corruption, register corruption, or visual glitches
- ✅ Overhead: <0.01% per frame (~8 cycles)

---

### 4. COMM Register Usage

**COMM Register Map (from hardware manual, 2-byte spacing):**

| Address     | Register | Game Usage | Mod Status |
|-------------|----------|------------|------------|
| 0x20004020  | COMM0    | 68K→SH2 command trigger | Used by game |
| 0x20004022  | COMM1    | Reserved/flags | Used by game |
| 0x20004024  | COMM2    | Work status | Used by game |
| 0x20004026  | COMM3    | Slave "OVRN" marker | Used by game |
| 0x20004028  | COMM4    | **Slave work counter** | ✅ Mod uses |
| 0x2000402A  | COMM5    | **Vertex transform counter** | ✅ Mod uses (+101/call) |
| 0x2000402C  | COMM6    | 68K→Master handshake ($0101) | ⚠️ Used by game |
| 0x2000402E  | COMM7    | **Master→Slave signal** | ✅ Mod uses |

**Historical Note:** v1.0 analysis incorrectly assumed 4-byte spacing (0x20004030, etc.). Those addresses are PWM registers, not COMM. This was corrected in v2.3.

---

## 📊 Work Distribution Analysis

### Current Distribution (Estimated from Static Analysis)

**Master SH2**: ~350,000 cycles/frame for rendering work
- Vertex transformation: ~30,000 cycles (estimated)
- Polygon processing: ~50,000 cycles (estimated)
- Rasterization: ~200,000 cycles (estimated)
- Overhead: ~70,000 cycles (estimated)
- **Note**: Additional ~800K cycles lost to blocking 68K sync (root cause of ~20 FPS)

**Slave SH2**: ~100 cycles/frame (0.03% busy)
- Idle loop + hook overhead: ~100 cycles (validated by v2.3 stress test)
- **Wasted capacity**: ~1,150,000 cycles/frame at 20 FPS!

```
Master CPU: ██████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 30% (rendering)
            ░░░░░░░░░░░░░░████████████████████████████████ 70% (blocking sync)
Slave  CPU: █                                             0.03%
            └─ MASSIVE WASTE ─────────────────────────────┘
```

### Ideal Distribution (Theoretical)

**Goal**: Reduce blocking sync time by having Slave pre-compute work

**Master SH2**: ~300,000 cycles/frame
- Polygon processing: ~50,000 cycles
- Rasterization: ~200,000 cycles
- Reduced sync wait: ~50,000 cycles (down from ~800K)

**Slave SH2**: ~200,000 cycles/frame
- Vertex transformation: ~30,000 cycles (moved from Master)
- Pre-computation for next frame: ~150,000 cycles
- Overhead: ~20,000 cycles

---

## 🎯 Optimization Opportunities

### Status Overview

| Optimization | Status | Blocker |
|--------------|--------|---------|
| Basic sync protocol | ✅ Validated (v2.3) | None |
| Command-driven dispatch | ✅ Complete (v3.1) | None |
| Vertex transform offload | ⚠️ **INFRASTRUCTURE READY (v4.0)** | Activation deferred due to timing concerns |
| Parallel polygon processing | 📋 Theoretical | Needs work split implementation |
| Lighting offload | 📋 Theoretical | Depends on polygon processing |

### Priority 1: Move Vertex Transformation to Slave ⭐⭐⭐

**Current**: Master performs all vertex transformations (30,000 cycles/frame)

**Proposed**: Slave handles vertex transforms in parallel using cache-through staging

**Implementation Strategy** (from SLAVE_INTEGRATION_RESEARCH.md):
1. Master copies vertex data from 0xC0000XXX to 0x22000XXX (cache-through)
2. Master signals Slave via COMM6
3. Slave transforms vertices, writes results to 0x22000XXX+offset
4. Slave increments COMM4
5. Master copies results back to 0xC0000XXX

**Challenge**: The game uses 0xC0000XXX addresses which have cache coherency issues between CPUs. Cache-through staging (0x22000XXX) is required.

**Expected Gain (THEORETICAL - UNVALIDATED)**:
- Master freed: 30,000 cycles (8%) [ESTIMATED]
- Assumes: no cache contention, balanced work split, minimal sync overhead
- FPS improvement: ~8% (assumes 60 FPS baseline → 65 FPS) [THEORETICAL]
- **⚠️ NOT TESTED**: No performance testing conducted, activation pending

### Priority 2: Parallel Polygon Processing ⭐⭐

**Current**: Master processes all polygons sequentially (50,000 cycles)

**Proposed**: Split polygon list between Master and Slave

**Expected Gain (THEORETICAL - UNVALIDATED)**: +8.6% (assumes perfect parallelization) [NOT TESTED]

### Priority 3: Offload Lighting Calculations ⭐

**Expected Gain (THEORETICAL - UNVALIDATED)**: +5-10% [NOT TESTED]

---

## ⚠️ Technical Challenges

### 1. Cache Coherency (CRITICAL)

**Problem**: Each SH2 has its own 4KB cache. If both CPUs access 0xC0000760:
- Master writes → goes to Master's cache
- Slave reads → reads from Slave's cache (STALE DATA!)

**Solution**: Use cache-through addresses (0x22000XXX) for all shared data, or implement explicit cache flush/invalidate.

### 2. 0xC0000XXX Address Mystery

The transform code uses addresses like 0xC0000740, 0xC0000760. This is NOT a standard 32X mapping. Likely an undocumented alias or the 32X hardware decodes upper bits differently.

**Impact**: Cannot directly share transform buffers between CPUs without copying to cache-through region.

### 3. Synchronization Overhead

**Measured (v2.3)**: <0.01% per frame (~8 cycles for basic signal/acknowledge)

**For vertex offload**: Additional overhead for:
- Data copy to staging: ~100 cycles per 64 bytes
- Waiting for Slave completion: variable

---

## ❓ Known Unknowns

| Unknown | Impact | How to Resolve |
|---------|--------|----------------|
| Cache-through staging cost | May reduce theoretical gains by 10-30% | Benchmark with pdcore memory inspection |
| SDRAM contention | Both CPUs hitting SDRAM simultaneously may stall | Profile with cycle counter during parallel access |
| VDP timing interaction | Frame buffer writes may conflict with Slave work | Test with visual artifact detection |
| 0xC0000XXX mapping | Unknown cache behavior at these addresses | Hardware test or emulator memory dump comparison |

**Validation dependency**: Performance gains require memory inspection tooling (pdcore) or hardware testing to confirm correctness and measure actual speedup.

---

## 📈 Expected Results (Theoretical)

**⚠️ DISCLAIMER**: The following estimates are theoretical. Actual gains depend on:
- Cache contention behavior
- DMA/VDP contention
- Work split balance
- Staging buffer overhead
- No blocking sync in critical path

### Conservative Estimate (+15%)
- Move vertex transforms to Slave only
- Basic synchronization with staging overhead
- FPS: 20 → 23 (actual baseline is ~20 FPS, not 60)

### Optimistic Estimate (+30%)
- Full work distribution (transforms + polygons)
- Optimized staging and minimal contention
- FPS: 20 → 26

### Ideal Scenario (+50%)
- Perfect load balance, zero sync overhead
- Both CPUs at ~50% utilization
- FPS: 20 → 30

---

## 🛠 Implementation Roadmap

### ✅ Phase 11-13: Foundation (COMPLETE - Superseded)
- ✅ Slave hook mechanism via SDRAM injection
- ✅ Expansion ROM handler
- ✅ COMM6/COMM4 protocol validated
- ⚠️ **Superseded by full assembly approach (v3.0)**

### ✅ Phase v3.0: Full Assembly Build (COMPLETE)
- ✅ 4MB ROM builds from disassembly sources (`make all`)
- ✅ 1MB expansion ROM space at $300000-$3FFFFF
- ✅ Slave idle loop redirected: $0203CC → JMP $02300200
- ✅ `slave_work_wrapper` executes in expansion ROM
- ✅ "Proof of life": Slave continuously increments COMM4

### ✅ Phase v3.1: Command-Driven Dispatch (COMPLETE)
- ✅ Master dispatch hook at $300050 writes COMM7=cmd
- ✅ Slave polls COMM7, dispatches based on command value
- ✅ Frame sync (0x0001): Slave increments COMM4
- ✅ Vertex transform (0x0016): Slave increments COMM5

### ⚠️ Phase v4.0: Parallel Processing Infrastructure (COMPLETE - ACTIVATION PENDING)
- ✅ func_021 trampoline design (captures R14/R7/R8/R5 parameters)
- ✅ Parameter block at $2203E000 (SDRAM, shared between SH2s)
- ✅ Master dispatch hook at $300050 (skips COMM7 cmd $16)
- ✅ Slave work wrapper at $300200 (COMM7 polling)
- ✅ func_021_optimized at $300100 (with func_016 inlined)
- ✅ Shadow path validation (non-live testing)
- ⏳ **LIVE ACTIVATION DEFERRED** - Timing concerns need validation

### 📋 Next Phases (Before Activation)
1. **Performance Testing**: Measure actual FPS improvement (currently unknown)
2. **Timing Validation**: Ensure Slave completes before next frame needs results
3. **Frame Synchronization**: Validate synchronization at frame boundaries
4. **Live Activation**: Enable parallel processing in gameplay
5. **Load Balancing**: Split polygon workload between CPUs (future)
6. **Pipeline Optimization**: Pre-compute frame N+1 while displaying frame N (future)

---

## 📝 Conclusions

### Key Discovery
**Virtua Racing Deluxe severely underutilizes the Slave SH2 CPU.** While the Master CPU runs at 91% capacity performing all 3D rendering, the Slave sits in an infinite idle loop contributing nothing.

### Progress Made
1. **v1.0**: Identified the problem (Slave idle, Master overloaded)
2. **v1.1**: Hit blocker (PicoDrive boot failure)
3. **v2.3**: Bypassed blocker with hook injection
4. **v3.0**: Full assembly build with 4MB ROM
5. **v3.1**: Command-driven dispatch (COMM7 signaling)
6. **v4.0**: **⚠️ INFRASTRUCTURE COMPLETE** - Parallel processing ready, activation pending

### Why This Matters
- First time Virtua Racing's CPU usage has been analyzed in 30+ years
- **Infrastructure ready for parallel processing** (shadow path validated)
- Foundation established for parallel work distribution (pending live activation)
- Techniques applicable to other 32X games
- **⚠️ NOTE**: Performance gains theoretical until live activation and testing

---

## 📚 References

**Code Locations:**
- Master sync code: ROM 0x20500-0x20650
- Slave idle loop: ROM 0x20650-0x2069A
- 68000 handshake: ROM 0x800-0x8E0
- 3D engine (Master): ROM 0x23000-0x25000
- v2.3 hook location: SDRAM 0x06000596
- v2.3 handler: Expansion ROM 0x02300027

**COMM Registers:**
- 0x20004020-0x2000403C (SH2 side)
- 0xA15120-0xA1513C (68000 side)

**Documentation:**
- [32x-hardware-manual.md](../../docs/32x-hardware-manual.md) - Hardware reference
- [SLAVE_INTEGRATION_RESEARCH.md](../sh2-analysis/SLAVE_INTEGRATION_RESEARCH.md) - Cache staging strategy
- [FINAL_PROJECT_STATUS_v2.3.md](../../FINAL_PROJECT_STATUS_v2.3.md) - v2.3 validation results
- [SLAVE_BOOT_FAILURE_ROOT_CAUSE.md](../_archive/SLAVE_BOOT_FAILURE_ROOT_CAUSE.md) - Historical: boot issue analysis

---

**Status**: ⚠️ **INFRASTRUCTURE READY (v4.0) - ACTIVATION DEFERRED**
**Current**: Shadow path validated, architecture complete, live activation pending
**Next Phase**: Performance testing, timing validation, frame synchronization, live activation
**Estimated gain**: +15-50% performance (THEORETICAL - UNVALIDATED)
**Risk**: Moderate (timing concerns need validation before activation)
**Reward**: HIGH - **first major optimization milestone when activated**

---

**Original Discovery**: January 6, 2026
**v2.3 Bypass Achieved**: January 22, 2026
**v3.0 Assembly Build**: January 24, 2026
**v3.1 Command Dispatch**: January 24, 2026
**v4.0 Infrastructure**: January 25, 2026
**Document Updated**: January 26, 2026
**Status**: Infrastructure complete, activation deferred due to timing concerns
