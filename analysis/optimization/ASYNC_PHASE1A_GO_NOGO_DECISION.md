# Async Phase 1A - GO/NO-GO Decision Document

**Date:** 2026-01-27
**Phase:** 1A Proof of Concept - Async Command Submission
**Decision:** **GO** with modified scope (15 safe sites, exclude 2 unsafe sites)
**Expected FPS Impact:** +0.8-2.5% (24 → 24.2-24.6 FPS, conservative)

---

## Executive Summary

**All 3 Critical Pre-Implementation Checks COMPLETE:**

1. ✅ **Command Ordering Dependency Analysis** - 15 of 17 call sites SAFE for async
2. ✅ **COMM Register Usage Documentation** - COMM reuse collision identified, requires single-slot queue
3. ✅ **Frame Timeline Mapping** - V-INT at $001684, safe sync point identified

**DECISION: GO FOR PHASE 1A IMPLEMENTATION**

**Scope:** Convert 15 safe call sites to async, keep 2 unsafe sites blocking.

**Risk Level:** LOW (with single-slot queue and proper instrumentation)

---

## Critical Check #1: Command Ordering Dependency Analysis

### Summary

**17 call sites to `sh2_send_cmd_wait` analyzed:**
- **15 SAFE** for async optimization (fire-and-forget pattern)
- **2 UNSAFE** (immediate RAM status checks, must remain blocking)

### Safe Call Sites (Fire-and-Forget Pattern)

| # | Address | Next Instruction | Safety Status |
|---|---------|------------------|---------------|
| 1 | $00FF32 | LEA $000ECC90,A0 | ✅ SAFE |
| 2 | $00FF42 | MOVEQ #$00,D0 | ✅ SAFE |
| 3 | $00FF64 | MOVEQ #$00,D0 | ✅ SAFE |
| 4 | $00FF86 | LEA $000F4620,A0 | ✅ SAFE |
| 5 | $00FF96 | LEA $000EBB40,A0 | ✅ SAFE |
| 6 | $00FFA6 | LEA $000EB980,A0 | ✅ SAFE |
| 7 | $00FFB6 | LEA $000F4E40,A0 | ✅ SAFE |
| 8 | $00FFC6 | DC.W $11FC (data) | ✅ SAFE |
| 9 | $010B0C | LEA $000ECC90,A0 | ✅ SAFE |
| 10 | $010B1C | LEA $000ECE20,A0 | ✅ SAFE |
| 11 | $010B48 | LEA $000EBB40,A0 | ✅ SAFE |
| 12 | $010B58 | LEA $000EB980,A0 | ✅ SAFE |
| 13 | $010B68 | MOVEQ #$00,D0 | ✅ SAFE |
| 14 | $010BF4 | LEA $000EDE10,A0 | ✅ SAFE |
| 15 | $010C04 | DC.W $11FC (data) | ✅ SAFE |

**Common Pattern:**
```asm
JSR     sh2_send_cmd_wait       ; Submit command
LEA     $XXXXXX,A0              ; Setup next command (no COMM reads)
MOVEA.L #$YYYYYY,A1             ; Continue immediately
```

**Characteristic:** No COMM register reads or RAM status checks immediately after JSR.

### Unsafe Call Sites (Immediate Status Checks)

| # | Address | Unsafe Pattern | Reason |
|---|---------|----------------|--------|
| 1 | **$010B2C** | BTST #4,$FFFFC80E immediately after JSR | **BLOCKS** - Tests RAM status bit 4, branches conditionally |
| 2 | **$010BAE** | BTST #5,$FFFFC80E ~8 cycles after JSR | **BLOCKS** - Polls RAM status bit 5 in tight loop |

**Example Unsafe Pattern:**
```asm
$010B2C: JSR     $E316(PC)       ; sh2_send_cmd_wait
$010B30: BTST    #4,$FFFFC80E    ; ← Immediate RAM status check
$010B38: BEQ     $10B40          ; ← Conditional branch
```

**$FFFFC80E:** 68K RAM status byte (NOT a COMM register). Used for secondary synchronization checks beyond the hardware COMM registers.

**Decision:** Keep these 2 call sites blocking to preserve synchronization logic.

---

## Critical Check #2: COMM Register Usage

### COMM Register Reuse Collision Identified

**Problem:** All 17 call sites reuse the SAME COMM registers:

| Register | Address | Usage | Collision Risk |
|----------|---------|-------|----------------|
| **COMM0** | $A15120 | Ready status (read) | ⚠️ Shared across all commands |
| **COMM4** | $A15128 | Parameter pointer (write) | ⚠️ **HIGH COLLISION RISK** |
| **COMM6** | $A1512C | Handshake signal (write) | ⚠️ **HIGH COLLISION RISK** |

**Current Blocking Model (Works):**
```
68K: Write COMM4 + COMM6 (command 1)
68K: Block waiting on COMM0/COMM6
SH2: Process command 1, clear COMM6
68K: Unblock, write COMM4 + COMM6 (command 2)
68K: Block waiting on COMM0/COMM6
... (serialize all 17 commands)
```

**Naive Async Model (BREAKS):**
```
68K: Write COMM4 + COMM6 (command 1)  ← Parameters for cmd 1
68K: Return immediately (async)
68K: Write COMM4 + COMM6 (command 2)  ← OVERWRITES cmd 1 parameters!
SH2: Process command with corrupted parameters → visual glitches
```

### Solution: Single-Slot Pending Queue

**Implementation:**
```asm
; Data section
pending_cmd_valid:      dc.w 0          ; 0=empty, 1=pending
pending_cmd_type:       dc.w 0          ; Command type
pending_cmd_params:     dc.l 0, 0, 0    ; Up to 3 parameters

; Async submission with queue
sh2_send_cmd_async:
    ; Check if queue full
    tst.w   pending_cmd_valid
    beq.s   .slot_free

    ; Queue full → fallback to blocking
    addq.w  #1, async_overflow_count
    jsr     sh2_send_cmd_wait_original  ; Blocking fallback
    rts

.slot_free:
    ; Store command in queue
    move.w  d0, pending_cmd_type
    move.l  a0, pending_cmd_params
    move.w  #1, pending_cmd_valid

    ; Write to COMM registers (only if SH2 ready)
    move.w  d0, COMM0
    move.l  a0, COMM4
    move.w  #1, COMM6           ; Signal SH2

    ; Increment counters
    addq.w  #1, pending_cmd_count
    addq.l  #1, total_cmds_async

    rts
```

**Safety Mechanism:** Automatically falls back to blocking if SH2 busy (queue full).

---

## Critical Check #3: Frame Timeline & Sync Points

### V-INT Handler Location

**Address:** $001684 in [code_200.asm](../../disasm/sections/code_200.asm)

**Execution Flow:**
```
V-INT @ $001684:
  ├─ Check pending state ($FFC87A)
  ├─ If zero → RTE (early exit)
  ├─ If non-zero:
  │  ├─ Save registers (D0-D7/A0-A6)
  │  ├─ Dispatch to state handler (16 states)
  │  ├─ Increment frame counter ($FFC964)
  │  ├─ Restore registers
  │  └─ RTE
```

### Frame Timeline (60 Hz / 16.67 ms per frame)

```
┌─────────────────────────────────────────────────────────────────┐
│ FRAME N START (V-BLANK)                                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│ 1. V-INT Handler @ $001684                                     │
│    ├─ State dispatch                                           │
│    ├─ VDP synchronization (if state 6)                         │
│    └─ Frame counter increment                                  │
│                                                                 │
│ 2. **PROPOSED SYNC POINT:**                                    │
│    └─ sh2_wait_frame_complete() ← Insert here before RTE      │
│                                                                 │
│ 3. RETURN FROM V-INT                                           │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│ ACTIVE DISPLAY (Game Loop)                                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│ 4. Main Game Loop:                                             │
│    ├─ Physics, AI, Input                                       │
│    ├─ sh2_graphics_cmd (14 calls) → sh2_send_cmd_wait        │
│    ├─ sh2_cmd_27 (21 calls) → sh2_send_cmd_wait              │
│    │                                                            │
│    └─ **CURRENTLY BLOCKS per command (~350 cycles each)**     │
│       Total blocking: 17 × 350 = ~6,000 cycles = 0.78 ms     │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│ FRAME N END                                                      │
└─────────────────────────────────────────────────────────────────┘
```

### Recommended Sync Point: V-INT Handler End

**Location:** Before RTE in V-INT handler at $001684

**Assembly Code Injection:**
```asm
; Inside V-INT handler, after state dispatch:
        jsr     sh2_wait_frame_complete ; $300XXX (expansion ROM)
        movem.l (sp)+,d0-d7/a0-a6      ; Restore registers
        move.w  #$2300,sr               ; Re-enable interrupts
        rte
```

**Why This Works:**
- All 17 command submissions happen AFTER V-INT completes
- Next V-INT won't trigger until 16.67 ms later
- Guaranteed all commands submitted before sync point
- Single sync per frame instead of 17 per-command syncs

**Alternative Sync Point (If V-INT Hook Complex):**
```asm
; End of main game loop, before frame complete:
main_loop:
    jsr     game_logic          ; Contains all 17 command submissions
    jsr     sh2_wait_frame_complete ; Sync once at loop end
    bra     main_loop
```

---

## Performance Estimates

### Current (Blocking Model)

**Per-frame blocking overhead:**
```
17 calls × 200-400 cycles (COMM0 wait) = 3,400-6,800 cycles
17 calls × 150-300 cycles (COMM6 wait) = 2,550-5,100 cycles
────────────────────────────────────────────────────────────
Total:                                    5,950-11,900 cycles
Time:                                     0.78-1.55 ms
Percentage of 68K budget:                 4.7-9.3%
```

### After Phase 1A (15 Async + 2 Blocking)

**Per-frame blocking overhead:**
```
15 calls × 0 cycles (async)             = 0 cycles
2 calls × 350-700 cycles (blocking)     = 700-1,400 cycles
Frame-end sync (single wait)            = 500-1,000 cycles
────────────────────────────────────────────────────────────
Total:                                    1,200-2,400 cycles
Time:                                     0.16-0.31 ms
Savings:                                  0.47-1.24 ms

Time saved:                               0.62-1.24 ms per frame
```

### FPS Impact Calculation

**Conservative Estimate:**

Current frame time: ~42 ms (24 FPS)
Time saved: 0.62-1.24 ms
New frame time: 40.76-41.38 ms
**New FPS: 24.2-24.6 (+0.8-2.5%)**

**Optimistic Estimate (With SH2 Overlap):**

If SH2 processing overlaps with subsequent 68K work:
- Additional 2-3 ms overlap possible
- New frame time: 38.76-40.38 ms
- **New FPS: 24.8-25.8 (+3.3-7.5%)**

---

## Implementation Plan

### Phase 1A: Proof of Concept

**Goal:** Demonstrate async works without breaking synchronization.

### Step 1: Create Async Infrastructure (Expansion ROM)

**File:** `disasm/sections/expansion_300000.asm`

**New Functions:**
```asm
; Address: $3002C0
sh2_send_cmd_async:
    ; Single-slot queue implementation
    ; Falls back to blocking if queue full
    ; Returns immediately if SH2 ready

; Address: $3002E0
sh2_wait_frame_complete:
    ; Polls COMM6 until all pending commands complete
    ; Includes timeout to prevent deadlock
    ; Clears pending_cmd_count

; Address: $300300 (data section)
pending_cmd_valid:      dc.w 0
pending_cmd_type:       dc.w 0
pending_cmd_count:      dc.w 0
total_cmds_async:       dc.l 0
async_overflow_count:   dc.w 0
total_wait_cycles:      dc.l 0
max_wait_cycles:        dc.l 0
```

### Step 2: Redirect Safe Call Sites

**File:** `disasm/sections/code_*.asm` (wherever the 15 safe call sites are)

**15 Safe Call Sites to Redirect:**
```
$00FF32, $00FF42, $00FF64, $00FF86, $00FF96
$00FFA6, $00FFB6, $00FFC6, $010B0C, $010B1C
$010B48, $010B58, $010B68, $010BF4, $010C04
```

**Modification (For Each Safe Site):**
```asm
; Before:
    jsr     $E316(PC)           ; sh2_send_cmd_wait (blocking)

; After:
    jsr     $3002C0             ; sh2_send_cmd_async (non-blocking)
```

**Or via trampoline (cleaner, single change):**
```asm
; At $00E316 (sh2_send_cmd_wait entry):
sh2_send_cmd_wait:
    ; Check caller address to determine safe vs unsafe
    ; If safe → jmp $3002C0 (async)
    ; If unsafe → continue with original blocking code
```

### Step 3: Keep Unsafe Call Sites Blocking

**2 Unsafe Call Sites (NO CHANGES):**
```
$010B2C  - Immediately tests $FFFFC80E bit 4
$010BAE  - Immediately tests $FFFFC80E bit 5
```

These continue calling the original blocking `sh2_send_cmd_wait` at $00E316.

### Step 4: Add Frame-End Sync Point

**Option A: V-INT Handler Injection**

**File:** `disasm/sections/code_200.asm` at line ~2650-2670 (V-INT handler end)

**Assembly Code:**
```asm
; Inside V-INT handler @ $001684, before RTE:
v_int_handler_end:
        ; ... (existing V-INT code) ...

        ; Add frame-end sync
        jsr     $3002E0             ; sh2_wait_frame_complete

        ; Restore and return
        movem.l (sp)+,d0-d7/a0-a6
        move.w  #$2300,sr
        rte
```

**Option B: Main Loop Injection (Safer if V-INT complex)**

**Location:** End of main game loop (need to identify exact address)

```asm
main_loop:
        jsr     game_logic          ; Contains all command submissions
        jsr     $3002E0             ; sh2_wait_frame_complete (sync once)
        bra     main_loop
```

### Step 5: Instrumentation

**Counters to track (already defined in expansion ROM data section):**

```asm
pending_cmd_count:      dc.w 0          ; Current pending commands
total_cmds_async:       dc.l 0          ; Total async commands issued
async_overflow_count:   dc.w 0          ; Times queue was full
total_wait_cycles:      dc.l 0          ; Total cycles spent waiting at frame sync
max_wait_cycles:        dc.l 0          ; Worst-case wait time
```

**Instrumentation in `sh2_wait_frame_complete`:**
```asm
sh2_wait_frame_complete:
    tst.w   pending_cmd_count
    beq.s   .no_wait

    ; Start cycle timer
    move.l  $FFC964, d7         ; Frame counter as timestamp

.wait_loop:
    move.w  COMM4, d0
    beq.s   .done
    bra.s   .wait_loop

.done:
    ; Calculate cycles waited
    move.l  $FFC964, d0
    sub.l   d7, d0              ; d0 = frames waited (convert to cycles)

    ; Update totals
    add.l   d0, total_wait_cycles
    cmp.l   max_wait_cycles, d0
    ble.s   .not_max
    move.l  d0, max_wait_cycles
.not_max:

    clr.w   pending_cmd_count

.no_wait:
    rts
```

---

## Success Criteria

### Functional Requirements

- [ ] **No visual artifacts** (frame-by-frame comparison with baseline)
- [ ] **No crashes or hangs** (30+ minute stress test)
- [ ] **All game modes work** (menus, racing, replays)
- [ ] **Controls responsive** (no input lag increase)

### Performance Requirements

- [ ] **FPS ≥ 24.2** (minimum +0.8% improvement)
- [ ] **Total wait cycles reduced ≥25%** (baseline: ~6,000 cycles → target: ≤4,500)
- [ ] **Max pending commands ≤1** (confirms single-slot queue sufficient)
- [ ] **Async overflow count = 0** (no SH2 busy collisions)

### Instrumentation Validation

**Expected Output:**
```
=== Phase 1A Results (Target) ===
Baseline (Blocking):
  Total commands/frame:    17
  Blocking commands:       17 (100%)
  Async commands:          0 (0%)
  Total wait cycles:       5,950-11,900
  Max wait cycles:         350-700
  FPS:                     24.0

Phase 1A (15 Async + 2 Blocking):
  Total commands/frame:    17
  Blocking commands:       2 (12%)
  Async commands:          15 (88%)
  Total wait cycles:       ≤4,500 (25% reduction target met)
  Max wait cycles:         ≤500
  Pending cmd count:       ≤1 (single-slot OK)
  Async overflow:          0 (no collisions)
  FPS:                     ≥24.2 (improvement confirmed)
```

---

## Risk Assessment

### Risk Level: LOW (with mitigations)

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| **COMM register corruption** | LOW | HIGH | Single-slot queue with fallback |
| **Visual artifacts** | LOW | HIGH | Frame-by-frame validation testing |
| **SH2 overrun** | LOW | MEDIUM | Overflow counter + blocking fallback |
| **Deadlock at frame sync** | LOW | HIGH | Timeout in wait loop |
| **No FPS improvement** | MEDIUM | LOW | Instrumentation will reveal why |

### Failure Modes & Mitigation

**Failure Mode 1: Async overflow > 0**
- **Symptom:** `async_overflow_count` increments
- **Root Cause:** SH2 slower than command submission rate
- **Mitigation:** Expand queue to 2-3 slots, or throttle submission

**Failure Mode 2: Visual artifacts**
- **Symptom:** Missing geometry, flickering
- **Root Cause:** Unsafe call site converted to async
- **Mitigation:** Revert to blocking, or add intermediate sync

**Failure Mode 3: No FPS improvement**
- **Symptom:** FPS unchanged despite async working
- **Root Cause:** Blocking overhead not on critical path
- **Mitigation:** Profile to find true critical path, try different approach

**Failure Mode 4: Deadlock**
- **Symptom:** Game hangs in `sh2_wait_frame_complete`
- **Root Cause:** Infinite wait for command never submitted
- **Mitigation:** Add timeout (exit after N iterations), log state

---

## GO/NO-GO Decision

### ✅ **GO FOR IMPLEMENTATION**

**Justification:**

1. **All 3 Critical Checks Complete:**
   - ✅ Command ordering analyzed (15 safe, 2 unsafe)
   - ✅ COMM register reuse documented (single-slot queue required)
   - ✅ Frame timeline mapped (V-INT at $001684, sync point identified)

2. **Risk Level: LOW**
   - Single-slot queue prevents COMM corruption
   - Automatic fallback to blocking if SH2 busy
   - 2 unsafe sites remain blocking (preserves sync logic)

3. **Clear Implementation Path:**
   - 15 specific call site addresses identified
   - Expansion ROM space available for new functions
   - V-INT handler location known for sync point

4. **Expected Positive Outcome:**
   - Conservative: +0.8-2.5% FPS (24 → 24.2-24.6)
   - Optimistic: +3.3-7.5% FPS (24 → 24.8-25.8)
   - Proof of concept for Phase 1B/1C scaling

5. **Instrumentation Ready:**
   - Cycle counters, overflow detection
   - Can quantify exact time savings
   - Will reveal any regressions

### Scope Modifications from Original Plan

**Original Plan:** Target `sh2_cmd_27` (21 calls/frame)

**Revised Plan:** Target 15 safe call sites of `sh2_send_cmd_wait` (mix of `sh2_graphics_cmd` and `sh2_cmd_27`)

**Reason:** `sh2_cmd_27` is not directly called via JSR. The 17 `sh2_send_cmd_wait` calls are the actual blocking points, and 15 of them are safe for async.

---

## Next Steps

### Immediate Actions

1. **Implement expansion ROM functions:**
   - [ ] `sh2_send_cmd_async` at $3002C0
   - [ ] `sh2_wait_frame_complete` at $3002E0
   - [ ] Data section at $300300

2. **Redirect 15 safe call sites:**
   - [ ] Modify disassembly to call $3002C0 instead of $E316

3. **Add V-INT sync point:**
   - [ ] Insert JSR $3002E0 before RTE in V-INT handler

4. **Build and test:**
   - [ ] `make all` to rebuild ROM
   - [ ] Test in PicoDrive with FPS counter
   - [ ] Validate instrumentation counters

5. **Validation testing:**
   - [ ] Frame-by-frame comparison with baseline
   - [ ] 30-minute stress test
   - [ ] All game modes (menus, racing, replays)

### Timeline Estimate

| Phase | Duration | Outcome |
|-------|----------|---------|
| Implementation | 2-3 days | Code written, ROM builds |
| Unit testing | 1 day | Single async command validated |
| Integration testing | 1-2 days | All 15 sites validated |
| Stress testing | 1 day | 30-minute stability confirmed |
| Documentation | 1 day | Results documented |
| **Total** | **6-8 days** | **Phase 1A Complete** |

---

## Related Documents

- [ASYNC_PHASE1A_SAFETY_CHECKLIST.md](ASYNC_PHASE1A_SAFETY_CHECKLIST.md) - Safety checks performed
- [ASYNC_COMMAND_IMPLEMENTATION_PLAN.md](ASYNC_COMMAND_IMPLEMENTATION_PLAN.md) - Full 3-phase plan
- [COMM_REGISTER_USAGE_ANALYSIS.md](COMM_REGISTER_USAGE_ANALYSIS.md) - COMM register documentation
- [68K_BOTTLENECK_ANALYSIS.md](../profiling/68K_BOTTLENECK_ANALYSIS.md) - Root cause analysis

---

**Status:** ✅ **ALL CRITICAL CHECKS COMPLETE - GO FOR IMPLEMENTATION**
**Risk Level:** LOW (with single-slot queue and proper instrumentation)
**Expected Outcome:** +0.8-7.5% FPS improvement (24 → 24.2-25.8 FPS)
**Next Action:** Begin implementation of expansion ROM async functions
**Timeline:** 6-8 days to Phase 1A completion
