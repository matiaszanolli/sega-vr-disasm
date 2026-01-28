# Async Command Submission Profiling Plan

**Date:** 2026-01-28
**Phase:** 1A - Single call site async implementation
**Goal:** Measure effectiveness of async command submission

---

## What We're Measuring

### 1. Async Behavior Metrics
- **Immediate submissions**: Commands sent directly (SH2 ready)
- **Queued submissions**: Commands deferred to V-INT (SH2 busy)
- **Dispatches**: How often V-INT dispatches queued commands
- **Queue utilization**: Percentage of calls that queue vs submit immediately

### 2. Performance Impact
- **FPS comparison**: Blocking vs async frame rate
- **68K wait reduction**: Time saved by not blocking on SH2

---

## Memory Layout for Profiling Counters

**Location:** `$00FFD000-$00FFD0FF` (Async queue + counters)

| Address | Size | Purpose | Current Use |
|---------|------|---------|-------------|
| $00FFD000 | 2B | PENDING_CMD_VALID | ✓ Active |
| $00FFD002 | 2B | PENDING_CMD_TYPE | ✓ Active |
| $00FFD004 | 2B | ~~PENDING_CMD_COUNT~~ | Removed |
| $00FFD006 | 2B | **IMMEDIATE_COUNT** | NEW profiling |
| $00FFD008 | 4B | PENDING_CMD_PARAMS | ✓ Active |
| $00FFD00C | 4B | ~~PENDING_CMD_PARAMS+4~~ | Removed |
| $00FFD010 | 4B | **QUEUED_COUNT** | NEW profiling |
| $00FFD014 | 4B | ~~TOTAL_CMDS_ASYNC~~ | Removed |
| $00FFD018 | 2B | ~~ASYNC_OVERFLOW_COUNT~~ | Removed |
| $00FFD01A | 2B | **DISPATCH_COUNT** | NEW profiling |
| $00FFD020 | 2B | Init magic | ✓ Active |

**New Counters (6 bytes total):**
- `$00FFD006` (2B): IMMEDIATE_COUNT - incremented when cmd submitted immediately
- `$00FFD010` (4B): QUEUED_COUNT - incremented when cmd queued for later
- `$00FFD01A` (2B): DISPATCH_COUNT - incremented when V-INT dispatches queued cmd

---

## Profiling Implementation

### Step 1: Add Counters (Minimal Overhead)

**In `sh2_send_cmd_async`:**
```assembly
.sh2_ready_path:
    ; ... existing COMM writes ...
    addq.w  #1,$00FFD006            ; IMMEDIATE_COUNT++  (2 bytes)
    rts

.sh2_busy_path:
    addq.l  #1,$00FFD010            ; QUEUED_COUNT++  (4 bytes)
    rts
```

**In `sh2_wait_frame_complete`:**
```assembly
.dispatch_queued:
    ; ... existing COMM writes ...
    addq.w  #1,$00FFD01A            ; DISPATCH_COUNT++  (2 bytes)
```

**Total overhead:** 8 bytes (fits in existing padding)

### Step 2: Baseline FPS Measurement

**Test Scenario:** Time Trial, Grand Prix Canyon, 1 lap

#### Blocking Version (control):
1. Build ROM with async call site disabled (`$E3B6`)
2. Run test scenario for 60 seconds
3. Record SH2 frames from `0x22000400`
4. Calculate: `baseline_fps = frames / 60`

#### Async Version (experimental):
1. Build ROM with async call site enabled (`$EC16`)
2. Run same test scenario for 60 seconds
3. Record SH2 frames from `0x22000400`
4. Calculate: `async_fps = frames / 60`
5. Read counters:
   - IMMEDIATE_COUNT @ `$00FFD006`
   - QUEUED_COUNT @ `$00FFD010`
   - DISPATCH_COUNT @ `$00FFD01A`

#### Analysis:
```
FPS improvement = (async_fps - baseline_fps) / baseline_fps * 100%
Queue ratio = QUEUED_COUNT / (IMMEDIATE_COUNT + QUEUED_COUNT) * 100%
```

### Step 3: GDB Memory Dump

**At end of 60-second test:**
```gdb
# Attach to PicoDrive process
(gdb) attach <pid>
(gdb) break *0x22000400  # SH2 frame counter location

# Dump async counters
(gdb) x/1xw 0x00FFD000   # PENDING_CMD_VALID
(gdb) x/1xh 0x00FFD006   # IMMEDIATE_COUNT
(gdb) x/1xw 0x00FFD010   # QUEUED_COUNT
(gdb) x/1xh 0x00FFD01A   # DISPATCH_COUNT
(gdb) x/1xw 0x22000400   # SH2 frame count
```

---

## Expected Results

### Hypothesis 1: Most commands submit immediately
If SH2 is usually ready, we expect:
- IMMEDIATE_COUNT >> QUEUED_COUNT
- Queue ratio < 10%
- Minimal FPS impact (async overhead dominates)

### Hypothesis 2: Significant queueing occurs
If SH2 is often busy, we expect:
- QUEUED_COUNT > IMMEDIATE_COUNT
- Queue ratio > 50%
- Measurable FPS improvement (68K blocking time reduced)

### Hypothesis 3: Single call site insufficient
Even with effective async, one call site may be too small:
- FPS improvement < 5%
- Need to extend to all 13 call sites for cumulative effect

---

## Success Criteria

**Async is working if:**
- ✓ IMMEDIATE_COUNT + QUEUED_COUNT > 0 (calls are happening)
- ✓ DISPATCH_COUNT ≈ QUEUED_COUNT (queued cmds actually dispatched)
- ✓ No freezes or crashes over 60-second test
- ✓ Game behavior identical to blocking version

**Async is beneficial if:**
- ✓ FPS improvement ≥ 1% with single call site
- ✓ Queue ratio ≥ 20% (meaningful async happening)
- ✓ Extrapolated improvement with 13 sites ≥ 10% FPS gain

---

## Next Steps After Profiling

### If async is effective (FPS ↑):
1. Extend to remaining 12 safe call sites
2. Re-profile with all sites enabled
3. Measure cumulative FPS impact
4. Document results and proceed to Phase 1B

### If async shows no benefit:
1. Analyze why (queue ratio too low? overhead too high?)
2. Consider alternative optimizations:
   - VDP polling reduction
   - 68K delay loop elimination
   - Slave workload offloading
3. Document findings and pivot to next optimization

---

## Files to Create

1. `build_async_profiling.sh` - Build script for profiling ROM
2. `ASYNC_PROFILING_RESULTS.md` - Results documentation template
3. Updated `sh2_send_cmd_async` with counters
4. Updated `sh2_wait_frame_complete` with counters
