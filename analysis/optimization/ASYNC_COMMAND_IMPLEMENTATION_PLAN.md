# Async Command Submission - Implementation Plan

**Date:** 2026-01-27
**Priority:** P1 - Highest ROI optimization
**Risk:** Low (frame-boundary sync preserved)
**Expected Gain:** +46-67% FPS (24 → 35-40 FPS)

---

## Overview

**Problem:** 35 blocking sync points per frame consuming 10-15 ms in polling loops

**Solution:** Remove per-command blocking, sync once at frame boundary

**Approach:** Minimal async shim with single pending command slot (simplest safe implementation)

---

## Phase 1: Minimal Async Shim (Low Risk, High ROI)

### Goal

Replace per-command blocking waits with immediate return, defer sync to frame boundary.

### Implementation Strategy

**1. Split Blocking Function**

Current:
```c
sh2_send_cmd_wait(cmd, params) {
    write_comm_registers(cmd, params);
    while (!sh2_ready()) { /* BLOCKING */ }  // 200-400 cycles
}
```

Proposed:
```c
sh2_send_cmd_async(cmd, params) {
    write_comm_registers(cmd, params);
    pending_cmd_count++;
    // Return immediately (no wait)
}

sh2_wait_frame_complete() {
    while (pending_cmd_count > 0 && !sh2_ready()) {
        /* Wait only at frame boundary */
    }
    pending_cmd_count = 0;
}
```

**2. Add Pending Command Tracking**

```c
// Global state (shared memory)
static volatile uint16_t pending_cmd_count = 0;
static volatile uint16_t last_cmd_submitted = 0;
static volatile uint16_t async_overflow_count = 0;
```

**3. Safe Sync Point**

Call `sh2_wait_frame_complete()` once per frame at:
- End of V-INT handler
- Before frame buffer swap
- After all commands submitted

**4. Instrumentation**

```c
// Counters for analysis
uint32_t total_cmds_issued = 0;
uint32_t total_cmds_async = 0;
uint32_t total_cmds_blocked = 0;
uint32_t max_pending_cmds = 0;
```

---

## Current Function Mapping

### Blocking Functions to Modify (from 68K_BOTTLENECK_ANALYSIS.md)

| Address | Function | Calls/Frame | Current Behavior | New Behavior |
|---------|----------|-------------|------------------|--------------|
| **$00E316** | `sh2_send_cmd_wait` | 35 | Blocks 200-400 cycles | Returns immediately |
| **$00E342** | `sh2_wait_response` | 35 | Blocks 150-300 cycles | Deferred to frame end |
| $00E22C | `sh2_graphics_cmd` | 14 | Calls blocking wait | Calls async version |
| $00E3B4 | `sh2_cmd_27` | 21 | Calls blocking wait | Calls async version |
| $002890 | `sh2_comm_sync` | ~10 | Sync coordination | Unchanged (or async) |

### Safe Sync Point Locations

| Address | Function | Purpose | Frequency |
|---------|----------|---------|-----------|
| V-INT handler end | Frame boundary | Natural sync point | 60 Hz |
| Main loop iteration | Frame production | After command batch | Per frame |
| VDP swap | Framebuffer flip | Before display | Per frame |

---

## Implementation Steps

### Step 1: Locate and Document Blocking Functions

**Files to examine:**
```
disasm/sections/code_00*.asm  (68K game code)
```

**Search for:**
- `sh2_send_cmd_wait` @ $00E316
- `sh2_wait_response` @ $00E342
- COMM register polling patterns (tst.w COMM4, bne loop)

**Action:**
- [ ] Read disassembly at $00E316, document exact behavior
- [ ] Read disassembly at $00E342, document exact behavior
- [ ] Map call sites (35 locations calling these functions)
- [ ] Identify V-INT handler location for sync point

### Step 2: Create Async Wrapper Functions

**New code in expansion ROM ($300000+):**

```asm
; Async command submission (no blocking wait)
sh2_send_cmd_async:
    ; Write command to COMM registers (existing logic)
    move.w  d0, COMM0           ; Command type
    move.l  a0, COMM2           ; Parameter pointer
    move.w  #1, COMM6           ; Signal SH2 (command ready)

    ; Increment pending counter
    addq.w  #1, pending_cmd_count

    ; Return immediately (no wait loop)
    rts

; Frame-end sync (called once per frame)
sh2_wait_frame_complete:
    ; Only wait if commands pending
    tst.w   pending_cmd_count
    beq.s   .no_wait

.wait_loop:
    ; Poll SH2 status
    move.w  COMM4, d0
    beq.s   .done               ; SH2 signaled complete

    ; Optional: timeout after N iterations to prevent hang
    dbra    d7, .wait_loop

.done:
    ; Clear pending counter
    clr.w   pending_cmd_count

.no_wait:
    rts
```

### Step 3: Redirect Call Sites

**Trampoline approach (minimal invasive):**

At $00E316 (sh2_send_cmd_wait):
```asm
; Original function entry
sh2_send_cmd_wait:
    jmp     sh2_send_cmd_async  ; Redirect to async version
    ; (original code never reached)
```

At $00E342 (sh2_wait_response):
```asm
sh2_wait_response:
    rts                         ; No-op (wait deferred to frame end)
    ; (original code never reached)
```

**Advantage:** All 35 call sites automatically use async version with 2-line change.

### Step 4: Add Frame-End Sync

**Insert call in V-INT handler or main loop:**

```asm
v_int_handler:
    ; ... existing V-INT code ...

    ; Add sync before frame completes
    jsr     sh2_wait_frame_complete

    ; ... continue with frame boundary logic ...
    rte
```

**Or in main game loop:**
```asm
main_loop:
    ; Frame start
    jsr     game_logic_update
    jsr     prepare_commands

    ; Sync before next frame
    jsr     sh2_wait_frame_complete

    ; Frame end
    bra     main_loop
```

### Step 5: Instrumentation

**Add counters for analysis:**

```asm
; Data section
pending_cmd_count:      dc.w 0
total_cmds_issued:      dc.l 0
total_cmds_async:       dc.l 0
max_pending_cmds:       dc.w 0
async_overflow_count:   dc.w 0

; In sh2_send_cmd_async:
    addq.l  #1, total_cmds_issued
    addq.l  #1, total_cmds_async

    ; Track max pending
    move.w  pending_cmd_count, d0
    cmp.w   max_pending_cmds, d0
    ble.s   .no_update
    move.w  d0, max_pending_cmds
.no_update:
```

---

## Testing Strategy

### Phase 1A: Proof of Concept (Single Command Type)

**Goal:** Test async on lowest-risk command first

**Target:** `sh2_cmd_27` (21 calls/frame, simple command)

**Steps:**
1. Modify only `sh2_cmd_27` path to use async
2. Keep all other commands blocking
3. Add frame-end sync
4. Measure FPS

**Expected Result:**
- FPS increase: +5-10% (proves concept works)
- No visual artifacts
- Stable synchronization

**Success Criteria:**
- [ ] FPS increases (any amount)
- [ ] No crashes or hangs
- [ ] Visuals identical to original
- [ ] Counters show async commands executing

### Phase 1B: Extend to Graphics Commands

**Goal:** Apply async to high-frequency commands

**Target:** `sh2_graphics_cmd` (14 calls/frame)

**Steps:**
1. Extend async to graphics commands
2. Keep original `sh2_send_cmd_wait` as fallback
3. Measure FPS

**Expected Result:**
- FPS increase: +15-25% (cumulative)
- Stable across all game modes

**Success Criteria:**
- [ ] FPS: 24 → 28-30 (conservative)
- [ ] All tracks playable without artifacts
- [ ] Menu transitions work correctly

### Phase 1C: Full Async (All Commands)

**Goal:** Remove all blocking waits

**Target:** All 35 command submission points

**Steps:**
1. Replace all `sh2_send_cmd_wait` calls with async
2. Single frame-end sync point
3. Measure FPS

**Expected Result:**
- FPS increase: +46-67% (target)
- **FPS: 24 → 35-40**

**Success Criteria:**
- [ ] FPS ≥ 35 in gameplay
- [ ] Stable across all modes (menus, racing, replays)
- [ ] No synchronization errors
- [ ] Counters show 0 blocking calls

---

## Risk Mitigation

### Potential Issues

**1. SH2 Overrun (Command Submitted While Busy)**

**Symptom:** Visual glitches, missing geometry
**Mitigation:**
- Check SH2 status before async submit
- Queue or defer if SH2 busy
- Counter: `async_overflow_count`

**Code:**
```c
sh2_send_cmd_async(cmd) {
    if (sh2_busy()) {
        async_overflow_count++;
        sh2_wait_response();  // Fallback to blocking
    }
    // Normal async path
}
```

**2. Frame Boundary Missed**

**Symptom:** Tearing, incomplete frames
**Mitigation:**
- Ensure sync point before VDP swap
- Timeout in wait loop (prevent infinite hang)

**3. Timing Regression**

**Symptom:** FPS doesn't increase as expected
**Analysis:**
- Check `total_cmds_async` vs `total_cmds_blocked`
- Verify sync point not called too frequently
- Profile remaining blocking sources

---

## Expected Performance Impact

### Conservative Estimates

**Current Frame Time Breakdown:**
```
68K work:        16.69 ms (game logic + commands)
Blocking waits:  10-15 ms (polling loops)
SH2 work:        13.04 ms (rendering)
Other:           2 ms (VDP, overhead)
────────────────────────────────────────
Total:           41-47 ms (21-24 FPS)
```

**After Async (Phase 1C):**
```
68K work:        16.69 ms (unchanged)
Blocking waits:  1-2 ms (frame-end sync only)
SH2 work:        13.04 ms (parallel to 68K)
Other:           2 ms (VDP, overhead)
────────────────────────────────────────
Total:           25-29 ms (34-40 FPS)

Improvement: 12-14 ms saved (29-33% faster)
```

**Key Insight:** SH2 rendering now overlaps with 68K work for next frame.

### Aggressive Estimates (With Perfect Overlap)

**If 68K and SH2 fully parallelize:**
```
Frame time = MAX(68K work, SH2 work) + sync overhead
           = MAX(16.69 ms, 13.04 ms) + 2 ms
           = 18.69 ms
           = 53.5 FPS
```

**Realistic with some serialization:**
- Frame time: ~25 ms
- **FPS: 35-40** (target)

---

## Success Metrics

### Instrumentation Output (Target Values)

```
=== Async Command Statistics ===
Total Commands Issued:     84,000 (35/frame × 2400 frames)
Async Commands:            84,000 (100%)
Blocked Commands:          0 (0%)
Max Pending Commands:      35 (one frame's worth)
Async Overflows:           0 (no SH2 busy collisions)

Frame Sync Points:         2,400 (1 per frame)
Avg Wait Time (sync):      1.2 ms (vs 10-15 ms before)
Total Wait Time Saved:     21,600 ms (9 ms × 2400 frames)

FPS: 37.2 (baseline: 24.0) → +55% improvement
```

### Validation Checklist

**Functional:**
- [ ] All game modes work (menus, racing, replays)
- [ ] No visual artifacts or glitches
- [ ] No crashes or hangs
- [ ] Controls responsive

**Performance:**
- [ ] FPS increase ≥ 30% (24 → 31+ FPS)
- [ ] Stable frame time (no spikes)
- [ ] CPU utilization: 68K < 90% (headroom gained)

**Synchronization:**
- [ ] Counters show async paths used
- [ ] Overflow count = 0 (no SH2 collisions)
- [ ] Max pending ≤ 35 (within budget)

---

## Next Phase: Batching (Priority 2)

**After async proven:**

Combine multiple commands into single batch:
```c
// Current (35 async calls):
for (each object) {
    sh2_send_cmd_async(cmd);  // 35 times
}

// Batched (1-3 calls):
build_command_buffer(objects);
sh2_execute_batch(cmd_buffer);    // Once
```

**Expected additional gain:** +8-15% FPS (40 → 43-46 FPS)

---

## Timeline

| Phase | Task | Duration | Expected FPS |
|-------|------|----------|--------------|
| **1A** | Proof of concept (1 cmd type) | 2-3 days | 25-26 |
| **1B** | Extend to graphics cmds | 3-5 days | 28-30 |
| **1C** | Full async (all cmds) | 5-7 days | 35-40 |
| **Validation** | Testing across modes | 3-5 days | 35-40 |
| **Documentation** | Update docs, analysis | 2 days | 35-40 |
| **Total** | Phase 1 Complete | **15-22 days** | **35-40 FPS** |

---

## Implementation Locations

### Source Files to Modify

**68K Code (disassembly):**
```
disasm/sections/code_*.asm
- Locate $00E316 (sh2_send_cmd_wait)
- Locate $00E342 (sh2_wait_response)
- Locate V-INT handler
- Locate main game loop
```

**Expansion ROM (new code):**
```
disasm/sections/expansion_300000.asm
- Add sh2_send_cmd_async @ $3002C0
- Add sh2_wait_frame_complete @ $3002E0
- Add instrumentation counters @ $300300
```

**Build System:**
```
Makefile
- Build with async enabled by default
- Optional: ASYNC=0 to disable (A/B testing)
```

---

## References

- [68K_STATIC_ANALYSIS_DECISION.md](../profiling/68K_STATIC_ANALYSIS_DECISION.md) - Strategic decision rationale
- [68K_BOTTLENECK_ANALYSIS.md](../profiling/68K_BOTTLENECK_ANALYSIS.md) - 68K utilization proof
- [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](../ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) - Blocking model analysis
- [OPTIMIZATION_PLAN.md](../../OPTIMIZATION_PLAN.md) - Strategic roadmap

---

**Status:** Ready for implementation
**Priority:** P1 (highest ROI)
**Risk:** Low (frame-boundary sync preserves correctness)
**Expected Outcome:** 24 → 35-40 FPS (+46-67%)
