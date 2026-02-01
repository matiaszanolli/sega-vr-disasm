# Baseline Profiling Results - 2026-01-29

**Purpose:** Establish baseline performance metrics after removing unstable 68K async code
**ROM:** `build/vr_rebuild.32x` (4MB, expansion ROM hooks disabled)
**Tool:** `tools/libretro-profiling/profiling_frontend` (1800 frames, autoplay)

---

## CPU Utilization

| CPU | Cycles/Frame | Utilization | Status |
|-----|--------------|-------------|--------|
| **68000** | **127,987** | **100.1%** | **BOTTLENECK** |
| Master SH2 | 60 | 0.0% | Completely idle |
| Slave SH2 | 306,989 | 80.1% | All rendering work |

### Key Finding: Master SH2 is 100% Available

The Master SH2 averaging only 60 cycles/frame (vs 306,989 for Slave) confirms:
- Expansion ROM hooks are **disabled** (original code restored)
- Master SH2 has **full capacity available** for parallel work
- Current ROM runs unmodified VRD behavior

### Reconciling with Architectural Analysis

**Q: If Slave is at 80.1% utilization, why does ARCHITECTURAL_BOTTLENECK_ANALYSIS say it's underutilized?**

**A:** Both are true. PC-level profiling shows **66.5% of Slave cycles** are spent at `$0600060A` - a NOP inside an idle delay loop. The Slave is *running* (high cycle count) but *wasting* those cycles waiting for work that rarely comes.

| Metric | Value | Meaning |
|--------|-------|---------|
| Slave cycles/frame | 306,989 | Raw cycle count (high) |
| Slave "utilization" | 80.1% | % of 383K cycle budget used |
| Slave idle fraction | 66.5% | % of cycles in delay loop |
| **Slave useful work** | **~33.5%** | **Actual rendering cycles** |

---

## Expansion ROM Status

All parallel processing hooks confirmed **DISABLED**:

| File | Line | Status |
|------|------|--------|
| `code_20200.asm` | 318 | "Original dispatch code (RESTORED)" |
| `code_20200.asm` | 238 | "Original Slave idle loop (RESTORED)" |
| `code_22200.asm` | 2322 | "func_021: Original implementation (RESTORED)" |
| `code_e200.asm` | 3685 | "ASYNC: DISABLED (no space for init code)" |

The expansion ROM infrastructure exists (`expansion_300000.asm`) but nothing calls into it.

---

## Bottleneck Analysis

### Why 68K is the Constraint

From [68K_BOTTLENECK_ANALYSIS.md](68K_BOTTLENECK_ANALYSIS.md):

1. **68K orchestrates the entire frame pipeline** - command prep, sync waits, result processing
2. **68K is saturated at 100% capacity** - no headroom available
3. **SH2 optimizations won't increase FPS** - 68K is the constraint, not SH2 processing time
4. **Blocking handshake model serializes work** - 68K waits for SH2, preventing overlap

### 68K Blocking Functions

| Address | Function | Role |
|---------|----------|------|
| `$00E316` | `sh2_send_cmd_wait` | Primary blocking point - polls COMM until SH2 ready |
| `$00E342` | `sh2_wait_response` | Polls COMM6 for SH2 completion signal |
| `$00E22C` | `sh2_graphics_cmd` | Graphics command submission (14 calls/frame) |
| `$00E3B4` | `sh2_cmd_27` | Most frequent command (21 calls/frame) |

**These blocking functions consume 68K cycles regardless of SH2 processing speed.**

---

## Decision: Optimization Strategy

### What Won't Help FPS

**Re-enabling SH2 parallel hooks (vertex transform offload):**
- Offloads Master SH2 → Slave SH2 work
- Does NOT free 68K cycles (the actual bottleneck)
- FPS governed by 68K time, not SH2 distribution

### What Will Help FPS

| Priority | Strategy | Expected Gain | Notes |
|----------|----------|---------------|-------|
| **1A** | Async Command Submission | 25-50% FPS | Let 68K continue while SH2 processes |
| **1B** | Double-Buffered Commands | 15-30% FPS | Build N+1 while SH2 renders N |
| **1C** | Reduce Blocking Call Count | 10-20% FPS | Batch 35→3 submissions/frame |
| **2** | Command Batching | 10-20% FPS | Reduce 68K↔SH2 sync overhead |

### Chosen Path

**Focus: 68K blocking reduction**
- Async command submission (if space permits)
- Command batching to reduce sync points

**Fallback: SH2 interrupt queue (Path B)**
- Move queue management to Master SH2
- Saves 80+ bytes in cramped 68K section
- Uses the completely idle Master SH2
- 12-16 hour implementation effort

---

## Previous Session Context

### 68K Async Removal (Same Day)

Commit `0dd98c4`: Removed Phase 1A 68K async infrastructure due to section capacity blocker.

**Why removed:**
- Section `$00E200-$010200` at absolute capacity (0 bytes free)
- 68K async requires 20 bytes for stable init (unachievable)
- Without init code, Work RAM contains garbage → ROM freezes

**What was removed:**
- `sh2_send_cmd_async` and async queue logic
- `sh2_wait_frame_complete` function
- V-INT dispatch hook

**What was preserved:**
- All async research documentation
- SH2 interrupt queue analysis for future Path B implementation

---

## Raw Profile Data

**File:** `tools/libretro-profiling/baseline_profile.csv`

```
Total frames: 1798
68000 Cycles: Min=127,984, Max=127,988, Avg=127,987.0
Master SH2:   Min=0, Max=107,679, Avg=59.9
Slave SH2:    Min=0, Max=307,165, Avg=306,989.0
```

---

## Next Steps

1. **Analyze 68K blocking functions** - Understand exact cycle cost of `sh2_send_cmd_wait` and `sh2_wait_response`
2. **Identify batching opportunities** - Can 35 commands/frame become 3?
3. **Evaluate space budget** - Is there room for minimal async in 68K section?
4. **Consider SH2 queue** - If 68K space impossible, implement Path B

---

## References

- [68K_BOTTLENECK_ANALYSIS.md](68K_BOTTLENECK_ANALYSIS.md) - Architectural analysis
- [ASYNC_STATUS.md](../../ASYNC_STATUS.md) - Decision tree for async approaches
- [SH2_ASYNC_QUEUE_ANALYSIS.md](../optimization/SH2_ASYNC_QUEUE_ANALYSIS.md) - Path B research
- [SESSION_HANDOFF.md](../../SESSION_HANDOFF.md) - Session context
