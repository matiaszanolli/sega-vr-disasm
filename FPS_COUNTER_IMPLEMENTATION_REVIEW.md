# FPS Counter Implementation - Technical Review

**Date:** February 8, 2026
**Status:** Working, but accuracy concerns require validation
**Current Build:** `build/vr_rebuild.32x` (commit 4ff3348)

---

## Executive Summary

We've implemented a working FPS counter that tracks actual frame buffer flips by monitoring the FS (Frame Select) bit in the 32X Frame Buffer Control register. The counter displays **stable 20 FPS** during gameplay with minimal variation (19→20 in first second, then constant 20).

**USER CONCERN:** The stable 20 FPS reading seems "too perfect" and may not accurately reflect true frame rate variance. Need verification that we're measuring correctly.

---

## Current Behavior

### Observed Display Values
- **First second:** 19 FPS
- **All subsequent seconds:** Exactly 20 FPS (no variation)
- **Attract mode:** Not yet tested
- **Different tracks/scenarios:** Not yet tested

### Expected Behavior (Based on Profiling)
From `tools/libretro-profiling/` analysis:
- **68K:** ~100% utilization (bottleneck)
- **Master SH2:** ~36% utilization
- **Slave SH2:** ~78% utilization
- **Expected FPS:** ~20-24 during gameplay with variance based on scene complexity

**Question:** Should we see more variance (18-22 FPS range) during gameplay, or is frame-locked 20 FPS legitimate?

---

## Implementation Architecture

### V-INT Flow
```
V-INT Vector ($000078) → fps_vint_wrapper ($0089C208)
│
├─ NO-WORK PATH ($C87A = 0, ~40/60 V-INTs)
│  └─ Render FPS → JMP original V-INT
│
└─ WORK PATH ($C87A ≠ 0, ~20/60 V-INTs)
   └─ JMP original V-INT → vint_epilogue
      ├─ Re-enable interrupts
      ├─ Drain async queue (sh2_wait_queue_empty)
      ├─ Track FS bit transitions
      ├─ Sample FPS (every 60 ticks)
      └─ Render FPS → RTE
```

### FS Bit Tracking (Core Measurement Logic)

**File:** [disasm/modules/68k/optimization/fps_vint_wrapper.asm:92-114](disasm/modules/68k/optimization/fps_vint_wrapper.asm#L92-L114)

```asm
; Every V-INT in epilogue:
move.w  FBCTL,d0                ; Read $00A1518A (Frame Buffer Control)
andi.w  #1,d0                   ; Isolate FS bit (bit 0)
cmp.w   fps_fs_last,d0          ; Compare to last known state
beq.s   .no_flip                ; Same state = no flip

; FS bit changed - buffer flip occurred
addq.l  #1,fps_flip_counter     ; Increment flip counter
move.w  d0,fps_fs_last          ; Update last state

.no_flip:
; Sample FPS once per second (60 V-INTs)
addq.w  #1,fps_vint_tick
cmpi.w  #60,fps_vint_tick
blt.s   .render

; Compute FPS = delta(fps_flip_counter) over 1 second
move.l  fps_flip_counter,d0
sub.l   fps_flip_last,d0        ; Flips in last second
move.w  d0,fps_value            ; Store for display
move.l  fps_flip_counter,fps_flip_last
clr.w   fps_vint_tick
```

**Key Measurement Point:** We read FBCTL **after** `sh2_wait_queue_empty` returns, meaning SH2 rendering is complete and buffer flip should have occurred.

---

## Technical Details

### Registers Used

| Register | Address | Purpose | Bit |
|----------|---------|---------|-----|
| **FBCTL** | `$00A1518A` | Frame Buffer Control | Bit 0 = FS (Frame Select) |
| Work Flag | `$FFFFC87A` | Work pending indicator | 0 = no work, ≠0 = work |

**Critical:** FBCTL is the **correct** register for FS bit. Initial implementation incorrectly read `$00A15100` (Adapter Control), resulting in 0 FPS. Fix confirmed at commit 4ff3348.

### RAM Layout ($FFFFE600-$FFFFE60D, 14 bytes)

| Offset | Symbol | Type | Purpose |
|--------|--------|------|---------|
| `+0` | `fps_vint_tick` | word | V-INT tick counter (0-59) |
| `+2` | `fps_value` | word | Display value (0-99) |
| `+4` | `fps_flip_counter` | long | Total flip count (cumulative) |
| `+8` | `fps_flip_last` | long | Last sampled flip count |
| `+12` | `fps_fs_last` | word | Last FS bit state (0 or 1) |

**Persistence Confirmed:** Test ladder validated that $FFFFE600 survives V-INT handler execution (canary test passed).

---

## Measurement Methodology

### What We're Counting
- **FS bit transitions** in FBCTL register
- Each transition = one frame buffer flip = one presented frame
- Samples over 60 V-INTs (1 second NTSC)

### What We're NOT Counting
- V-INT frequency (would always be 60)
- Work frame counter `$FFFFC964` (increments every V-INT, not just flips)
- SH2 command completions

### Timing Characteristics
- **Measurement window:** Exactly 60 V-INTs (1.000 second at 60 Hz)
- **Sampling frequency:** Once per second
- **Flip detection:** Every V-INT (60 Hz polling rate)

---

## Validation History

### Evolution of Implementation

1. **Initial Attempt:** Read `$FFFFC964` frame counter
   **Result:** Constant 60 FPS (wrong - measures V-INT frequency)

2. **FS Bit Tracking v1:** Read `$00A15100` (Adapter Control)
   **Result:** 0 FPS (wrong register - FS not in adapter control)

3. **FS Bit Tracking v2:** Read `$00A1518A` (FBCTL)
   **Result:** 19-20 FPS ✅ (current implementation)

### Test Ladder Results

| Test | Expected | Result | Status |
|------|----------|--------|--------|
| Step 1: Render path sanity | Stable "42" | Stable "42" | ✅ PASS |
| Step 2: Persistence canary | Stable "42" | Stable "42" | ✅ PASS |
| Step 3: Full FPS logic | ~20-24 FPS | 19-20 FPS | ⚠️ WORKING but variance low |

---

## Known Limitations

### 1. Sampling Window (1 Second)
- **Granularity:** Only updates once per second
- **Implication:** Can't detect frame time variance within the 1-second window
- **Example:** If game alternates 15-25 FPS every 0.5s, we'd see average ~20 FPS

**Possible Enhancement:** Sample every 30 ticks (0.5s) for higher temporal resolution

### 2. FS Bit Polling Rate (60 Hz)
- **Detection frequency:** Once per V-INT (every ~16.67ms)
- **Implication:** Could miss rapid double-flips if they occur between V-INTs
- **Likelihood:** Low (flips should be synchronized with V-INT)

### 3. Epilogue Timing
- **When we read FS:** After `sh2_wait_queue_empty` completes
- **Implication:** We only see FS state AFTER SH2 work finishes
- **Question:** Does VRD flip buffers during V-INT (between our reads), or does it flip at a fixed point?

---

## User's Concern: "Too Perfect" Stability

### Observation
After first second (19 FPS), counter shows **exactly 20 FPS every subsequent second** with zero variation.

### Possible Explanations

#### A. Legitimate Frame-Locking (Expected)
**Hypothesis:** VRD intentionally frame-locks to 60Hz/3 = 20 FPS for stable frame pacing.

**Evidence For:**
- 60 V-INTs ÷ 3 = exactly 20 frames (clean divisor)
- Prevents tearing by syncing to V-INT boundaries
- Common technique in 90s console games

**Evidence Against:**
- Profiling shows 68K at 100% utilization (bottleneck suggests variable frame time)
- First second showed 19 FPS (why would frame-lock allow 19 initially?)

#### B. Measurement Artifact (Potential Issue)
**Hypothesis:** We're only detecting certain flips, missing others, resulting in apparent stability.

**Possible Causes:**
1. **Sampling bias:** FS bit might only change at specific V-INTs we're not measuring
2. **Double-buffering lag:** Flip might occur 1 V-INT after we read, causing us to miss it
3. **Register read timing:** Reading FBCTL at wrong point in frame cycle

**How to Test:**
- Add diagnostic: Display raw `fps_flip_counter` value alongside FPS
- Compare flip counter increment rate across multiple seconds
- If flip counter increments exactly 20 every second → measurement is accurate
- If flip counter varies (18, 22, 19, 21) but FPS stays 20 → sampling artifact

#### C. VRD's Frame Scheduling (Likely)
**Hypothesis:** VRD uses a 3-V-INT frame schedule (work, render, flip) resulting in precisely 20 FPS.

**Evidence:**
- Async queue system suggests pipelined frame scheduling
- `$FFFFC87A` work flag indicates structured frame phases
- 68K bottleneck means frames take multiple V-INTs to complete

**Expected Pattern:**
```
V-INT 0: Work starts ($C87A = 1)
V-INT 1: Work continues
V-INT 2: Work completes, buffer flips, new work starts
→ Repeat every 3 V-INTs = 20 FPS
```

If this is the actual pattern, 20 FPS is legitimate and expected.

---

## Verification Tests Needed

### Test 1: Raw Flip Counter Display
**Goal:** Verify flip counter increments consistently

**Implementation:**
Add status indicator showing `fps_flip_counter % 100` (last 2 digits of total flips)

**Expected Results:**
- **If 20 FPS is real:** Counter increments exactly 20 every second (00→20→40→60→80→00)
- **If measurement artifact:** Counter increments vary (00→19→38→60→78) but FPS shows 20

### Test 2: Attract Mode Comparison
**Goal:** Test if FPS varies in different game modes

**Method:**
1. Boot ROM, wait at attract mode title screen (no 3D rendering)
2. Observe FPS counter
3. Start race, observe during gameplay

**Expected Results:**
- **Attract mode:** Higher/variable FPS (30-60) if simple scene
- **Gameplay:** Stable ~20 FPS if frame-locked
- **If both show 20:** Potential measurement issue

### Test 3: Different Track Complexity
**Goal:** Verify FPS responds to scene complexity

**Method:**
1. Test Bay Bridge track (original, simpler)
2. Test Highland track (more complex)
3. Compare FPS values

**Expected Results:**
- **If frame-locked:** Both show 20 FPS
- **If dynamic:** Highland shows 18-19 FPS, Bay Bridge shows 21-22 FPS

### Test 4: 0.5-Second Sampling
**Goal:** Increase temporal resolution to catch intra-second variance

**Implementation:**
Change `cmpi.w #60,fps_vint_tick` to `cmpi.w #30,fps_vint_tick`

**Expected Results:**
- Updates twice per second
- May reveal 18→22 FPS oscillation hidden by 1-second averaging

---

## Alternative Measurement Approaches

### Option 1: Dual Counter (Current + $FFFFC964)
Display both flip count FPS and `$FFFFC964` delta to compare methodologies.

**Pros:** Cross-validation of measurement
**Cons:** `$FFFFC964` already proven to measure V-INT frequency (60 Hz)

### Option 2: Work Frame Counter
Count epilogue executions directly (only runs when `$FFFFC87A ≠ 0`)

**Pros:** Measures actual work frames completed
**Cons:** Doesn't measure presented frames (flip timing)

### Option 3: VINT vs Flip Ratio
Display: `(flips per second) / (V-INTs per second) * 100` = frame percentage

**Example:** 20 flips / 60 V-INTs = 33% (1 frame every 3 V-INTs)

**Pros:** Shows frame scheduling pattern clearly
**Cons:** Requires 2-digit display expansion

---

## Files Modified

### Core Implementation
| File | Lines | Purpose |
|------|-------|---------|
| [fps_vint_wrapper.asm](disasm/modules/68k/optimization/fps_vint_wrapper.asm) | 125 | V-INT wrapper + epilogue with FS tracking |
| [fps_render.asm](disasm/modules/68k/optimization/fps_render.asm) | 192 | 2-digit display renderer |
| [ring_buffer_init.asm](disasm/modules/68k/boot/ring_buffer_init.asm) | 70 | FPS state initialization |

### Integration Points
| File | Line | Change |
|------|------|--------|
| [header.asm](disasm/sections/header.asm) | 68-69 | V-INT vector → $0089C208 |
| [code_1c200.asm](disasm/sections/code_1c200.asm) | 39-40 | Include FPS modules |
| [code_200.asm](disasm/sections/code_200.asm) | 466 | V-INT jumps to vint_epilogue |

---

## Critical Questions for Review

### 1. Measurement Accuracy
**Q:** Is reading FBCTL at epilogue-time (after queue drain) the correct measurement point?
**Concern:** Buffer flip might occur during V-INT handler, before we read FS bit.
**Evidence Needed:** Disassemble original V-INT handler to find where VRD flips buffers.

### 2. FS Bit Behavior
**Q:** Does FS bit toggle every frame flip, or is it set/cleared by software?
**Hardware Manual Quote:** "Bit 0: FS (Frame Select) - Selects which frame buffer to display"
**Concern:** If VRD manually sets FS (not hardware toggle), we might miss transitions.

### 3. Frame Pacing
**Q:** Does VRD intentionally frame-lock to 20 FPS, or should we see 18-24 FPS range?
**Evidence Needed:** Profile FPS in attract mode (simple scene) vs gameplay (complex scene).

### 4. Sampling Window
**Q:** Is 1-second sampling hiding intra-second variance?
**Test:** Switch to 0.5-second sampling (30 ticks) and observe.

### 5. Double Buffering Model
**Q:** Does VRD use traditional double buffering, or triple buffering, or something else?
**Evidence:** Two frame buffers at $840000 and $860000 confirmed. FS bit should toggle between them.

---

## Recommendations for Validation

### Priority 1: Raw Counter Display (Quick)
Add diagnostic showing `fps_flip_counter % 100` to verify consistent 20-flip-per-second increment.

**Implementation Time:** 15 minutes
**Diagnostic Value:** High (confirms measurement accuracy)

### Priority 2: Attract Mode Test (Quick)
Boot ROM, observe FPS at title screen vs gameplay.

**Implementation Time:** 5 minutes
**Diagnostic Value:** High (confirms dynamic measurement)

### Priority 3: 0.5-Second Sampling (Medium)
Change tick threshold from 60 to 30 for higher temporal resolution.

**Implementation Time:** 10 minutes + rebuild
**Diagnostic Value:** Medium (reveals intra-second variance)

### Priority 4: V-INT Handler Audit (Slow)
Disassemble original V-INT handler at $00881684 to find buffer flip location.

**Implementation Time:** 1-2 hours
**Diagnostic Value:** High (definitive answer on flip timing)

---

## Success Criteria

The FPS counter is **accurately measuring presented frames** if:

1. ✅ Raw flip counter increments match displayed FPS (Test 1)
2. ✅ FPS varies between attract mode and gameplay (Test 2)
3. ✅ FPS responds to scene complexity differences (Test 3)
4. ✅ Higher sampling rate reveals expected variance (Test 4)

If all tests pass: **20 FPS is legitimate frame-locked behavior**
If tests fail: **Measurement artifact - implementation needs revision**

---

## Open Issues

1. **Zero validation of attract mode FPS** - Need to test in different game states
2. **No scene complexity testing** - All testing done on single track during gameplay
3. **1-second sampling may hide variance** - Consider 0.5s or 0.25s sampling
4. **V-INT handler not audited** - Don't know exactly when/how VRD flips buffers
5. **No cross-validation with alternative measurement** - Single methodology, no redundancy

---

## Conclusion

We have a **working FPS counter** that tracks FS bit transitions in FBCTL and displays values consistent with VRD's known performance (~20 FPS). However, the **"too perfect" stability** (exactly 20 FPS every second after first sample) raises legitimate questions about measurement accuracy vs. legitimate frame-locking.

**Recommended Next Step:** Run Priority 1 test (raw counter display) to confirm flip counter increments exactly 20 per second. This is the quickest way to validate measurement accuracy without speculation.

---

**Last Updated:** February 8, 2026
**Review Requested By:** User (matias)
**For Review By:** Codex (future Claude session)
