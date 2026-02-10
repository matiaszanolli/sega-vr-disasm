# FPS Counter Implementation - Next Steps Evaluation

**Date:** February 8, 2026
**Status:** Stable diagnostics achieved, implementation blocked
**Current ROM:** Reverted to commit e1beba2 (stable diagnostic state)

---

## Executive Summary

We need a working FPS counter that displays actual gameplay frame rate (expected ~20-24 FPS during play, ~60 FPS in attract mode). After extensive diagnostics, we've confirmed:

✅ **Working:** V-INT wrapper execution, display rendering, epilogue-time writes
❌ **Broken:** WRAM state persistence (V-INT handler corrupts), SDRAM implementation (showed "00"/"99")
🔍 **Root Cause:** V-INT handler at $00881684 clears high WRAM, making wrapper→epilogue handoff impossible

---

## Architecture Overview

### Current Design (Dual-Path V-INT)

```
V-INT Vector ($000078) → fps_vint_wrapper ($0089C208)
│
├─ NO-WORK PATH ($C87A = 0, ~40/60 V-INTs)
│  ├─ Increment tick counter
│  ├─ Sample FPS (every 60 ticks)
│  ├─ Render FPS counter
│  └─ JMP original V-INT handler
│
└─ WORK PATH ($C87A ≠ 0, ~20/60 V-INTs)
   ├─ Increment tick counter
   ├─ Sample FPS (every 60 ticks)
   ├─ JMP original V-INT handler
   │  └─ Original V-INT completes → vint_epilogue
   │     ├─ Re-enable interrupts
   │     ├─ Drain async queue (sh2_wait_queue_empty)
   │     ├─ Render FPS counter
   │     └─ RTE
   └─ [STATE CORRUPTION POINT: V-INT clears WRAM]
```

**Key Problem:** State written in wrapper (tick count, FPS value) must survive V-INT handler execution to reach epilogue render.

---

## Diagnostic Results (Proven Facts)

### Test 1: Wrapper Execution Confirmed
- **Action:** Write 11 to fps_value in wrapper
- **Result:** Display showed "11"
- **Conclusion:** ✅ Wrapper runs, display path works

### Test 2: Dual Sentinel Test (Lines 96-112 of fps_vint_wrapper.asm)
- **Action:** Write $4242 sentinel in wrapper, check before/after queue drain in epilogue
- **Result:** Code 91 (pre-drain corruption)
- **Conclusion:** ✅ V-INT handler corrupts WRAM *before* queue drain

### Test 3: Option 5 Sanity Test (Line 120 of fps_vint_wrapper.asm)
- **Action:** Write 42 to fps_value in epilogue immediately before render
- **Result:** Stable "42" display
- **Conclusion:** ✅ Epilogue-time writes work perfectly

### Test 4: SDRAM Implementation (Reverted)
- **Action:** Move state to cache-through SDRAM ($2203F210-$2203F21F)
- **Result:** Code "00" initially, then "99" after register fix
- **Conclusion:** ❌ SDRAM reads/writes failed for unknown reason

### WRAM Corruption Pattern
- **Locations Tested:** $FFFFFE00 (collision), $FFFFCA20 (corrupted), $FFFFD200 (corrupted)
- **Distance:** $CA20 and $D200 are 2KB+ apart (different cache lines)
- **Implication:** V-INT handler clears large contiguous WRAM range, not selective corruption

---

## Technical Constraints

### Memory Architecture
| Address Range | Type | Status | Notes |
|---------------|------|--------|-------|
| `$FFFFC800-$FFFFC9FF` | WRAM | ❌ Collision | Active game state |
| `$FFFFCA20-$FFFFCA2F` | WRAM | ❌ Corrupted | V-INT clears this |
| `$FFFFD200-$FFFFD20F` | WRAM | ❌ Corrupted | V-INT clears this too |
| `$2203F000-$2203F1FF` | SDRAM | Ring buffer | Working (queue system) |
| `$2203F200-$2203F207` | SDRAM | Ring pointers | Working (queue system) |
| `$2203F210-$2203F21F` | SDRAM | FPS state | ❌ Implementation failed |

### V-INT Handler Behavior (Observed)
- **Location:** $00881684 (original V-INT handler in code_200.asm)
- **Behavior:** Clears large WRAM range including $CA20 and $D200 (2KB+ apart)
- **Timing:** Corruption happens *before* sh2_wait_queue_empty in epilogue
- **Unaudited:** Exact clear pattern not yet verified by reading handler source

### Proven Working Components
1. **fps_render** (fps_render.asm): Correctly reads fps_value, renders to both frame buffers
2. **V-INT wrapper execution**: Wrapper definitely runs (Test 1 confirmed)
3. **Epilogue writes**: Writing fps_value immediately before render works perfectly (Test 3)
4. **FM bit protocol**: Frame buffer access handshake working correctly

---

## Failed Approaches

### Approach 1: WRAM at $FFFFFE00
- **Why Tried:** End of work RAM, should be safe
- **Why Failed:** Collision with existing game state (external expert identified)

### Approach 2: WRAM at $FFFFCA20
- **Why Tried:** Documented as free space 2KB beyond active game state
- **Why Failed:** V-INT handler corrupts this range (Test 2: code 91)

### Approach 3: WRAM at $FFFFD200
- **Why Tried:** 2KB away from $CA20, different cache line, truly isolated
- **Why Failed:** V-INT handler corrupts this range too (Test 2: code 91)
- **Implication:** V-INT clears large contiguous WRAM, not just specific addresses

### Approach 4: Cache-Through SDRAM at $2203F210
- **Why Tried:** Persistent storage outside WRAM, same addressing model as working ring buffer
- **Why Failed:**
  - Initial implementation: Register save/restore mismatch (saved d0-d2/a0, restored d0-d1/a0-a1)
  - After fix: Counter showed "00" (reads returning 0?) then "99" (overflow or corrupted read?)
  - Unknown root cause despite correct register discipline
- **Symptoms:**
  - Severe graphical corruption (first attempt)
  - Reduced corruption but "00" display (after register fix)
  - "99" display (final state before revert)

---

## Architecture Options for Next Steps

### Option A: Epilogue-Only FPS Computation
**Concept:** Skip wrapper sampling entirely, compute FPS only in epilogue using existing counters

**Pros:**
- No state handoff required (single execution context)
- Leverages proven working epilogue writes
- Simplest implementation (no new memory allocation)

**Cons:**
- Must find reliable time base (60 Hz proxy: V-INT counter? Game counter?)
- Needs access to frame counter ($FFFFC964) which is WRAM (may be corrupted too)

**Implementation:**
```asm
vint_epilogue:
    move.w  #$2300,sr
    movem.l d0-d2/a0,-(sp)
    bsr.w   sh2_wait_queue_empty

    ; Compute FPS from existing game counters
    ; - Read $FFFFC964 (frame counter)
    ; - Read some 60 Hz time base
    ; - Compute FPS = frames / seconds
    move.w  d0,fps_value.w      ; Store computed FPS

    bsr.w   fps_render
    movem.l (sp)+,d0-d2/a0
    rte
```

**Key Question:** Can we find a reliable 60 Hz time base that survives V-INT handler?

---

### Option B: Flip-Site Counting (Direct FS Bit Detection)
**Concept:** Increment flip counter directly at buffer flip sites instead of proxy counting

**Pros:**
- Measures actual buffer flips (true frame rate, not V-INT rate)
- No wrapper needed (just modify flip sites + epilogue)
- May avoid WRAM handoff issue if flip sites are late in V-INT path

**Cons:**
- Requires identifying all buffer flip sites in original V-INT handler
- Flip sites may be in middle of V-INT (before epilogue)
- Still needs persistent storage for flip count between samples

**Implementation:**
1. Find all `BCHG #0,$00A1518B` instructions (FS bit toggle in adapter_ctrl)
2. Add increment after each flip: `addq.l #1,fps_flip_counter`
3. In epilogue: sample counter every N V-INTs, compute FPS

**Key Question:** Do flip sites occur before or after WRAM clear in V-INT handler?

---

### Option C: Fix SDRAM Implementation (Debug Unknown Failure)
**Concept:** Diagnose why SDRAM reads/writes showed "00" and "99"

**Pros:**
- SDRAM is the "correct" solution (persistent, cache-through, proven with ring buffer)
- Ring buffer already uses $2203F000-$2203F207 successfully

**Cons:**
- Unknown root cause (not just register bug)
- Time-consuming investigation with unclear success probability
- May be emulator-specific issue (PicoDrive caching behavior?)

**Investigation Steps:**
1. **Verify SDRAM writes:** Add diagnostic that writes known values, reads back immediately
2. **Check cache-through addressing:** Confirm $2203Fxxx addresses work same as ring buffer
3. **Test simpler state:** Just one word counter (fps_vint_tick), no FPS computation
4. **Compare with ring buffer:** Why do ring pointers work but FPS state doesn't?

**Possible Root Causes:**
- Cache-through addressing incorrect (but ring buffer uses same pattern)
- SDRAM region not initialized (but ring buffer region works)
- Counter overflow logic broken (but how did we get "00" initially?)
- Emulator cache coherency bug (speculative, no evidence)

---

### Option D: Audit V-INT Handler (Understand WRAM Clear)
**Concept:** Read original V-INT handler source to understand what it clears and when

**Pros:**
- Might reveal safe WRAM region or clear timing
- Understanding clear pattern helps choose optimal strategy
- Low risk (read-only analysis)

**Cons:**
- Time-consuming (V-INT handler is complex)
- May not help (clear might be unavoidable)
- Doesn't solve persistence problem, just explains it

**Implementation:**
1. Read [disasm/sections/code_200.asm](disasm/sections/code_200.asm) line 166-466 (full V-INT handler)
2. Find all CLR/MOVE instructions that write to $FFFFxxxx addresses
3. Map exact clear pattern (which ranges, when in execution order)
4. Identify if clear happens before or after queue drain insertion point

**Key Question:** Is there a WRAM range that V-INT handler doesn't touch?

---

### Option E: Hybrid Approach (SDRAM + Epilogue-Only Sampling)
**Concept:** Use SDRAM for persistence, but only access it from epilogue (never from wrapper)

**Pros:**
- Epilogue-only = single execution context (no handoff timing issues)
- SDRAM = persistent storage (survives V-INT clears)
- Proven: epilogue writes work (Test 3), ring buffer SDRAM works

**Cons:**
- Still relies on SDRAM reads/writes that failed in Option C
- Needs reliable tick counter that increments every V-INT

**Implementation:**
```asm
fps_vint_wrapper:
    addq.l  #1,$2203F210        ; Increment SDRAM tick counter (atomic)
    tst.w   $FFFFC87A.w
    bne.s   .skip
    bsr.w   fps_render
.skip:
    jmp     ORIG_VINT

vint_epilogue:
    move.w  #$2300,sr
    movem.l d0-d2/a0,-(sp)
    bsr.w   sh2_wait_queue_empty

    ; Sample every 60 ticks
    move.l  $2203F210,d0        ; Read tick counter from SDRAM
    divu    #60,d0
    swap    d0
    tst.w   d0                  ; Check if tick % 60 == 0
    bne.s   .skip_sample

    ; Compute FPS from frame counter
    move.l  $FFFFC964.w,d1      ; Current frame count (WRAM, may be stale)
    sub.l   $2203F214,d1        ; Subtract last sample
    move.w  d1,$2203F218        ; Store FPS to SDRAM
    move.l  $FFFFC964.w,$2203F214  ; Update last sample

.skip_sample:
    move.w  $2203F218,fps_value.w  ; Copy FPS from SDRAM to WRAM for render
    bsr.w   fps_render
    movem.l (sp)+,d0-d2/a0
    rte
```

**Key Question:** Why did SDRAM reads/writes fail in Option C if this is the same pattern?

---

## Recommended Investigation Order

### Priority 1: Quick Validation Tests (Low Risk, High Value)

**Test A: SDRAM Write/Read Verification**
- Add diagnostic in epilogue that writes $CAFE to $2203F210, reads back immediately
- Display read value (should show "CA" "FE" as two digits)
- **Goal:** Confirm SDRAM addressing works at all

**Test B: Simplified Counter (Epilogue-Only)**
- Remove all wrapper state, just count V-INTs in epilogue
- Increment $2203F210 in epilogue, display % 100 every frame
- **Goal:** Test if epilogue-only SDRAM access works

**Test C: Frame Counter Stability**
- Read $FFFFC964 in epilogue, display value
- **Goal:** Check if frame counter survives to epilogue or is corrupted

### Priority 2: Full Implementation (Choose One)

**If Test A/B Succeed → Option E (Hybrid SDRAM + Epilogue-Only)**
- Proven components: epilogue writes, SDRAM addressing
- Avoids wrapper→epilogue handoff timing issue

**If Test A/B Fail → Option A (Epilogue-Only WRAM)**
- Use only WRAM in epilogue, accept possible staleness
- Simplest fallback with no SDRAM dependency

**If Test C Shows Stable $FFFFC964 → Option A (Epilogue-Only WRAM)**
- Can compute FPS directly from game's frame counter
- No need for separate tick counter

### Priority 3: Deep Investigation (If Priority 1/2 Fail)

**Option D: Audit V-INT Handler**
- Understand WRAM clear pattern
- Find safe WRAM region if it exists

**Option C: Debug SDRAM Failure**
- Systematic investigation of why "00"/"99" occurred
- Compare with working ring buffer implementation

---

## Technical Reference

### Current File State (Commit e1beba2)

**fps_vint_wrapper.asm (lines 60-72, 92-126):**
```asm
fps_vint_wrapper:
    addq.w  #1,fps_vint_tick        ; WRAM tick (will be corrupted)
    move.w  #42,fps_value            ; Diagnostic: constant 42
    move.w  #$4242,fps_sentinel      ; Sentinel for corruption test
    tst.w   $FFFFC87A.w
    bne.s   .skip_no_work_render
    bsr.w   fps_render               ; NO-WORK render
.skip_no_work_render:
    jmp     ORIG_VINT

vint_epilogue:
    move.w  #$2300,sr
    movem.l d0-d1/a0-a1,-(sp)

    ; Dual sentinel test
    cmpi.w  #$4242,fps_sentinel
    beq.s   .pre_queue_ok
    move.w  #91,fps_value            ; Code 91 = pre-drain corruption
    bra.w   .render_now
.pre_queue_ok:

    bsr.w   sh2_wait_queue_empty

    cmpi.w  #$4242,fps_sentinel
    beq.s   .post_queue_ok
    move.w  #92,fps_value            ; Code 92 = post-drain corruption
    bra.w   .render_now
.post_queue_ok:

.render_now:
    move.w  #42,fps_value            ; Option 5: epilogue-time write
    bsr.w   fps_render
    movem.l (sp)+,d0-d1/a0-a1
    rte
```

**Expected Display:** "42" (Option 5 override)
**Actual Display:** (Not verified post-revert, assumed "42" based on Test 3)

### SDRAM Memory Layout (Working vs Failed)

| Address | Size | Component | Status |
|---------|------|-----------|--------|
| `$2203F000` | 512B | Ring buffer entries | ✅ Working |
| `$2203F200` | 4B | Ring head pointer | ✅ Working |
| `$2203F204` | 4B | Ring tail pointer | ✅ Working |
| `$2203F208` | 8B | (Unused alignment) | - |
| `$2203F210` | 16B | FPS state (attempted) | ❌ Failed |

**Why Ring Buffer Works But FPS State Doesn't?**
- Same cache-through addressing ($2203Fxxx)
- Same initialization context (ring_buffer_init.asm)
- Possibly: Ring buffer accessed by SH2, FPS state accessed by 68K?
- Possibly: Ring buffer uses atomic writes (CLR.L), FPS used arithmetic (ADDQ)?

---

## Open Questions

1. **Why did SDRAM implementation show "00" and "99"?**
   - Register bug fixed, but still failed
   - Reads returning 0? Writes not happening? Arithmetic overflow?

2. **Does $FFFFC964 survive to epilogue?**
   - Frame counter might be usable if not corrupted
   - Would enable epilogue-only FPS computation

3. **Where exactly does V-INT clear WRAM?**
   - Auditing handler source could reveal safe regions or clear timing
   - May explain why $CA20 and $D200 both corrupted

4. **Is there a safe WRAM region?**
   - Below $C800? Above $FE00?
   - Would enable simpler WRAM-only solution

5. **Can we increment counter at flip sites?**
   - Would measure actual flips instead of proxy V-INT rate
   - Depends on flip site location in V-INT execution order

---

## Decision Matrix

| Option | Complexity | Success Probability | Implementation Time | Diagnostic Value |
|--------|-----------|---------------------|---------------------|------------------|
| **Test A (SDRAM R/W)** | Low | High | 15 min | High |
| **Test B (Simple Counter)** | Low | Medium | 20 min | High |
| **Test C (Frame Counter)** | Low | High | 10 min | Medium |
| **Option A (Epilogue WRAM)** | Medium | Medium | 1 hour | Low |
| **Option B (Flip Sites)** | High | Low | 2+ hours | Medium |
| **Option C (Debug SDRAM)** | High | Low | 2+ hours | High |
| **Option D (Audit V-INT)** | Medium | Low | 1+ hour | High |
| **Option E (Hybrid)** | Medium | Medium | 1 hour | Medium |

**Recommended Path:**
1. Run Tests A/B/C (45 minutes total)
2. Based on results, choose Option A or E
3. If blocked, escalate to Option D

---

## Next Action

**Awaiting decision on investigation approach.** Recommend starting with Priority 1 tests (A/B/C) to gather data before committing to full implementation strategy.
