# Synchronization Audit Report - Parallel Processing Infrastructure

**Date:** February 8, 2026
**Purpose:** Pre-activation audit of synchronization primitives
**Status:** ⚠️ CRITICAL ISSUES FOUND - DO NOT ACTIVATE

---

## Executive Summary

The parallel processing infrastructure is **NOT SAFE TO ACTIVATE** due to **THREE CRITICAL BLOCKING ISSUES**:

1. 🔴 **COMM6 Conflict** - Expansion ROM uses COMM6, but game HEAVILY uses it for handshaking (20+ occurrences)
2. 🔴 **Missing Per-Call Sync** - Parameter block can be overwritten mid-execution (race condition)
3. 🔴 **Missing Frame Sync** - No mechanism ensures Slave completes before next frame (overrun risk)

**Recommendation:** DO NOT activate until ALL THREE issues are fixed (estimated 4-6 hours).

### Quick Status

| Component | Status | Issue |
|-----------|--------|-------|
| COMM Protocol | ⚠️ PARTIAL | COMM7 ✅ safe, COMM6 🔴 conflict, COMM5 ✅ safe |
| Cache Coherency | ✅ CORRECT | Parameter block uses cache-through (0x2203E000) |
| Interrupt Handling | ✅ CORRECT | CMDINT clearing + FRT TOCR toggle present |
| Per-Call Sync | ❌ MISSING | No barrier prevents param overwrite |
| Frame Boundary Sync | ❌ MISSING | No barrier prevents frame overrun |
| RV Bit Safety | ✅ VERIFIED | Never set during gameplay - expansion ROM safe |

### Action Items Summary

**MUST FIX (blocking activation):**
- [ ] #3: Change COMM6 → COMM5 for Master counter (20-30 min) 🔴 CRITICAL
- [ ] #2: Add per-call barrier in shadow_path_wrapper (5-10 min) 🔴 CRITICAL
- [ ] #1: Add frame boundary barrier in V-INT handler (20-30 min) 🔴 CRITICAL

**RECOMMENDED (before activation):**
- [ ] #5: Profile Slave execution time (1-2 hours) 📊
- [ ] #6: Measure func_021 call frequency (30 min) 📊

**WHEN READY (activation):**
- [ ] #7: Patch Master dispatch at $02046A (2 min)
- [ ] #8: Patch func_021 trampoline at $0234C8 (2 min)

---

## 1. Frame Boundary Synchronization ❌ MISSING

### Current State
- **68K V-INT handler**: Runs every frame, dispatches to state handlers
- **Master SH2**: Polls COMM0 for commands from 68K
- **Slave SH2**: Polls COMM7 for work signals from expansion code

### Critical Gap: No Frame Completion Barrier

**Problem:** There is NO code that ensures the Slave SH2 completes `func_021_optimized` execution before the next frame's rendering begins.

**Current flow (when activated):**
```
Frame N:
  1. Game calls func_021 (Master SH2)
  2. Trampoline captures params → COMM7 = 0x16
  3. Master returns IMMEDIATELY (no work done)
  4. Slave detects COMM7 = 0x16, calls slave_test_func
  5. Slave executes func_021_optimized (takes ?? cycles)

Frame N+1:
  ⚠️ V-INT fires - NEW FRAME STARTS
  ⚠️ Master may receive NEW func_021 call
  ⚠️ Slave may STILL BE WORKING on frame N!
```

**Consequence:** Race condition - Slave could be overwritten mid-execution, causing:
- Visual corruption (incomplete transforms)
- Parameter block corruption (R14/R7/R8/R5 overwritten)
- Unpredictable behavior

**Evidence:**
- No sync code in [vint_handler.asm](disasm/modules/68k/main-loop/vint_handler.asm)
- No COMM5 check before frame transition
- No barrier in Master command loop
- `shadow_path_wrapper` increments COMM5 AFTER work completes (good), but nothing WAITS for it

---

## 2. COMM Register Protocol ✅ SOUND (with caveats)

### COMM7 Write Pattern: ✅ Unidirectional

**Writers:**
- `shadow_path_wrapper` (Master): COMM7 = 0x16 (signal Slave)
- `master_dispatch_hook` (Master): COMM7 = cmd (for non-0x16 commands)

**Readers:**
- `slave_work_wrapper_v2` (Slave): Polls COMM7, clears after handling

**Assessment:** ✅ No race condition - Master writes, Slave reads/clears. Unidirectional.

### COMM5 Counter Pattern: ✅ Unidirectional

**Writers:**
- `slave_test_func` (Slave): COMM5 += 1 after work completion

**Readers:**
- None currently (should be checked by sync barrier)

**Assessment:** ✅ No race condition - Slave-only writes. But MISSING READER.

### COMM6 Original Game Usage: ❌ CONFIRMED CONFLICT

**From code search:**
- ✅ **VERIFIED:** Original game HEAVILY uses COMM6 for handshaking
- 68K writes: `MOVE.W #$0101,$A1512C` (signal SH2)
- 68K polls: `TST.B $A1512C` (wait for response)
- **20+ occurrences** across game code:
  - [sh2_communication.asm](disasm/modules/68k/sh2/sh2_communication.asm)
  - [game_12200.asm](disasm/modules/68k/game/game_12200.asm)
  - [fn_10200_007.asm](disasm/modules/68k/game/fn_10200_007.asm)

**Expansion ROM usage:**
- `shadow_path_wrapper` increments COMM6 (Master call counter)

**Assessment:** 🔴 **CRITICAL CONFLICT** - Expansion ROM CANNOT use COMM6.

**Impact:** Game handshake protocol will be corrupted, causing:
- SH2 commands to fail
- 68K to hang waiting for COMM6 response
- Visual glitches or freeze

**Fix Required:** Change expansion ROM to use DIFFERENT register (see Action Item #3).

---

## 3. Parameter Block Cache-Through Addressing ✅ CORRECT

**Location:** 0x2203E000 (cache-through SDRAM)
**Size:** 16 bytes (R14, R7, R8, R5 - 4 bytes each)

**Assessment:** ✅ Correct use of cache-through addressing (0x22XXXXXX prefix). This ensures:
- Master writes are immediately visible to Slave (no cache coherency issues)
- No stale data from Slave's cache

**Reference:** Memory architecture notes in `MEMORY.md` confirm this is the correct approach.

---

## 4. Interrupt Clearing ✅ CORRECT (for CMDINT)

### CMDINT Handler: [cmdint_handler.asm](disasm/sh2/expansion/cmdint_handler.asm)

**Clearing sequence:**
```assembly
mov.l   cmdint_clear,r1     ; R1 = 0x2000401A
mov.w   clear_value,r0      ; R0 = 0x0001
mov.w   r0,@r1              ; Write to clear register
mov.w   @r1,r0              ; Dummy read (sync)
```

**Assessment:** ✅ Follows hardware manual requirements:
- Writes to clear register ($2000401A)
- Synchronization read ensures write completes
- 2+ cycles between clear and RTE

### FRT TOCR Toggle: ✅ PRESENT

**Code:**
```assembly
mov.l   frt_base,r1         ; R1 = 0xFFFFFF80
mov.b   @(14,r1),r0         ; R0 = TOCR
xor     #0x02,r0            ; Toggle bit 1
mov.b   r0,@(14,r1)         ; Write back
```

**Assessment:** ✅ Mandatory SH2 interrupt bug workaround present. Per [32x-hardware-manual-supplement-2.md](docs/32x-hardware-manual-supplement-2.md), this prevents interrupt recognition failures.

---

## 5. Slave Work Wrapper Synchronization ✅ CORRECT (local protocol)

### Protocol: [slave_work_wrapper_v2.asm](disasm/sh2/expansion/slave_work_wrapper_v2.asm)

**Flow:**
```
1. Poll COMM7 until non-zero
2. Dispatch to handler (frame sync / vertex transform / queue drain)
3. Clear COMM7
4. Return to polling
```

**Assessment:** ✅ Correct local protocol. Handler completes before COMM7 is cleared.

**But:** No inter-frame barrier - see Section 1.

---

## 6. Master Dispatch Hook ✅ CORRECT (local logic)

### Code: [master_dispatch_hook.asm](disasm/sh2/expansion/master_dispatch_hook.asm)

**Logic:**
```
if (cmd == 0x16) {
    // Skip COMM7 write (func_021 trampoline handles it)
} else {
    COMM7 = cmd  // Signal Slave for other commands
}
```

**Assessment:** ✅ Correct selective signaling. Avoids double-writing COMM7 for cmd 0x16.

**But:** No verification that Slave completed previous work before starting new work.

---

## 7. Race Condition Analysis

### Race #1: Parameter Block Overwrite ❌ PRESENT

**Scenario:**
```
Frame N, call 1: Trampoline writes params[R14, R7, R8, R5] → COMM7=0x16
Frame N, call 2: Trampoline OVERWRITES params → COMM7=0x16 (again)
                 ⚠️ Slave may still be reading params from call 1!
```

**Likelihood:** HIGH - func_021 is called MULTIPLE TIMES per frame (vertex transform loop).

**Mitigation:** Need per-call synchronization (wait for COMM7=0 before writing params).

### Race #2: Frame Boundary Overrun ❌ PRESENT

**Scenario:**
```
Frame N, late call: Trampoline signals Slave
Frame N ends, Frame N+1 starts
Frame N+1, early call: Trampoline signals Slave AGAIN
                       ⚠️ Slave may still be working on Frame N call!
```

**Likelihood:** MEDIUM - depends on Slave execution time vs frame timing.

**Mitigation:** Frame barrier (wait for COMM5 == expected_count before V-INT ends).

### Race #3: COMM6 Conflict ⚠️ UNKNOWN

**Scenario:** Original game code may still use COMM6 for handshaking.

**Likelihood:** UNKNOWN - needs code search.

**Mitigation:** Verify COMM6 is safe to repurpose, or use different register.

---

## 8. Missing Synchronization Primitives

### A. Per-Call Barrier (func_021 trampoline)

**Needed in `shadow_path_wrapper`:**
```assembly
; Wait for Slave to clear COMM7 from previous call
.wait_slave_ready:
    mov.w   @r_comm7,r1
    tst     r1,r1
    bf      .wait_slave_ready  ; Loop until COMM7 == 0

; NOW safe to write params and signal
mov.l   r14,@r_params
; ... write R7, R8, R5
mov     #0x16,r1
mov.w   r1,@r_comm7  ; Signal Slave
```

**Cost:** ~50-100 cycles if Slave is fast, unbounded if Slave is slow.

**Risk:** If Slave is slower than Master, this BLOCKS Master (defeats parallelism purpose).

### B. Frame Boundary Barrier (V-INT handler)

**Needed in 68K V-INT handler or Master frame sync:**
```assembly
; Before ending frame, wait for Slave completion
mov.l   expected_comm5,d0  ; D0 = expected counter value
.wait_slave_done:
    move.w  $A1512A,d1      ; D1 = COMM5 (Slave completion counter)
    cmp.w   d0,d1
    blt     .wait_slave_done ; Loop until COMM5 >= expected

; NOW safe to start next frame
```

**Cost:** 0 cycles if Slave is done, unbounded if Slave is slow.

**Risk:** If Slave is slower than Master, this BLOCKS the frame (reduces FPS).

---

## 9. Timing Analysis ⚠️ INCOMPLETE

### Critical Unknown: Slave Execution Time

**Question:** How long does `func_021_optimized` take to execute on Slave SH2?

**Estimate (based on func_021_original):**
- Original func_021: ~36 bytes, estimated 50-100 cycles
- func_021_optimized: 96 bytes (func_016 inlined), estimated 100-200 cycles

**Frame budget (20 FPS):**
- 23.01 MHz SH2 @ 20 FPS = 1,150,500 cycles/frame
- Multiple func_021 calls per frame (vertex transform loop)
- If 100 calls/frame × 200 cycles = 20,000 cycles total
- **Should fit comfortably** (< 2% of frame budget)

**But:** Need ACTUAL measurement via profiling, not estimates.

### Frame Timing Constraint

**68K frame timing (20 FPS baseline):**
- Frame period: 50 ms (1000ms / 20 FPS)
- 68K budget: 383,500 cycles @ 7.67 MHz = 50 ms

**Slave must complete ALL func_021 calls within 50 ms:**
- If 100 calls × 200 cycles = 20,000 cycles
- At 23 MHz: 20,000 / 23,000,000 = 0.87 ms ✅ PLENTY OF MARGIN

**Conclusion:** Slave should complete easily IF estimate is correct.

**Risk:** If estimate is wrong (e.g., cache misses, memory contention), Slave could be slower.

---

## 10. Synchronization Recommendations

### Option A: Conservative Approach (RECOMMENDED)

**Add both barriers:**
1. **Per-call barrier** in `shadow_path_wrapper` (wait for COMM7=0)
2. **Frame boundary barrier** in V-INT handler (wait for COMM5 target)

**Pros:**
- ✅ Guarantees correctness (no races)
- ✅ Safe to activate

**Cons:**
- ❌ May reduce parallelism if Slave is slow
- ❌ May reduce FPS if Slave blocks frame transitions

**Performance impact:**
- If Slave is fast: Minimal (barriers never block)
- If Slave is slow: Master waits (reduces benefit of parallelism)

### Option B: Optimistic Approach (RISKY)

**Add only frame boundary barrier:**
1. **Frame barrier** in V-INT handler (wait for COMM5 target)
2. **No per-call barrier** (assume Slave keeps up)

**Pros:**
- ✅ Maximum parallelism (no blocking between calls)
- ✅ Higher potential speedup

**Cons:**
- ❌ Race condition if Slave falls behind mid-frame
- ❌ May cause visual corruption

**Performance impact:**
- Best case: +15-20% FPS (full parallelism)
- Worst case: Corruption, instability

### Option C: Measurement-First Approach (SAFEST)

**Before activation:**
1. **Profile Slave execution time** via instrumentation
2. **Measure actual func_021 call frequency** per frame
3. **Calculate Slave frame budget** based on measurements
4. **Choose Option A or B** based on data

**Pros:**
- ✅ Data-driven decision
- ✅ No guesswork

**Cons:**
- ❌ Requires additional profiling work
- ❌ Delays activation

---

## 11. Additional Findings

### A. COMM Register Availability

**Unused by expansion ROM:**
- COMM0-COMM4: Used by original game
- COMM5: ✅ Expansion ROM uses (Slave counter)
- COMM6: ⚠️ Expansion ROM uses, may conflict with game
- COMM7: ✅ Expansion ROM uses (Master→Slave signal)

**Recommendation:** Verify COMM6 conflict (see Action Item #3).

### B. Expansion ROM Execution Model

**Location:** $300000-$3FFFFF (expansion ROM)
**SH2 address:** $02300000-$023FFFFF (cached)

**From MEMORY.md:** ⚠️ RV bit concern - if RV=1 during gameplay, SH2 ROM access BLOCKS.

**Recommendation:** Verify RV bit is never set during gameplay (see Action Item #4).

### C. Master Dispatch Hook Integration

**Current state:**
- `master_dispatch_hook` exists at $300050
- Original dispatch at $02046A is NOT patched to call hook

**To activate:**
- Patch $02046A: Replace `shll2 r0` with `mov.l hook_addr,r0; jsr @r0`
- Or: Use linker to redirect jump table entry for cmd 0x16

**Recommendation:** See Action Item #1.

---

## 12. Action Items (in priority order)

### BLOCKING ISSUES (must fix before activation)

**#1: Implement Frame Boundary Synchronization** ⚠️ CRITICAL
- **Where:** 68K V-INT handler or Master SH2 frame sync
- **What:** Add barrier that waits for COMM5 >= expected_count
- **Why:** Prevents frame overrun race condition
- **Effort:** Medium (20-30 lines of 68K or SH2 assembly)

**#2: Implement Per-Call Synchronization** ⚠️ CRITICAL
- **Where:** `shadow_path_wrapper` before writing params
- **What:** Add loop that waits for COMM7 == 0
- **Why:** Prevents parameter block overwrite race
- **Effort:** Low (5-10 lines of SH2 assembly)

### VERIFICATION ISSUES (must verify before activation)

**#3: ❌ COMM6 CONFLICT CONFIRMED - CRITICAL** 🔴 BLOCKING ISSUE
- **Status:** ✅ VERIFIED - CONFLICT EXISTS
- **Finding:** Original game EXTENSIVELY uses COMM6 for handshaking:
  - 68K writes `$0101` to COMM6 ($A1512C) to signal SH2
  - 68K polls COMM6 high byte to wait for response
  - Used by `sh2_send_cmd_wait`, `sh2_wait_response`, and multiple game functions
  - **20+ occurrences** in game code
- **Conflict:** Expansion ROM increments COMM6 as Master call counter
- **Impact:** 🔴 **CORRUPTS GAME STATE** - handshake protocol will fail
- **Solution:** Use a DIFFERENT register (COMM4 or COMM5 available)
  - COMM4 ($A15128): Used by game for data pointer (high word)
  - COMM5 ($A1512A): ✅ **Already used by expansion ROM** for Slave counter (safe)
  - **Recommendation:** Use COMM5 for BOTH counters (Master + Slave), or find unused register
- **Effort:** Medium (20-30 minutes to change register in expansion code)

**#4: ✅ RV Bit Safety CONFIRMED** ✅ NO ISSUE
- **Status:** ✅ VERIFIED - NO CONFLICT
- **Finding:** $A15104 (BANK_SET) written only during INITIALIZATION:
  - init_sequence.asm:705 - writes $0001 (bit 0, NOT RV bit 15)
  - adapter_init.asm - initialization context only
  - **No gameplay writes found**
- **RV bit:** Never set to 1 during gameplay
- **Conclusion:** ✅ Expansion ROM execution at $02300000 is SAFE (no blocking risk)
- **Effort:** ✅ COMPLETE (no action needed)

### MEASUREMENT TASKS (recommended before activation)

**#5: Profile Slave Execution Time** 📊 RECOMMENDED
- **Task:** Add cycle counter instrumentation to `func_021_optimized`
- **Goal:** Measure actual execution time (best/worst case)
- **Use:** Validate timing assumptions, choose sync strategy
- **Effort:** Medium (1-2 hours)

**#6: Measure func_021 Call Frequency** 📊 RECOMMENDED
- **Task:** Add COMM register counter increment per func_021 call
- **Goal:** Know how many times Slave will be invoked per frame
- **Use:** Calculate total Slave frame budget
- **Effort:** Low (30 minutes)

### ACTIVATION TASKS (after fixes above)

**#7: Patch Master Dispatch** (when ready)
- **Where:** $02046A in Master command loop
- **What:** Redirect to `master_dispatch_hook` at $300050
- **Effort:** Low (2-line assembly change)

**#8: Patch func_021 Trampoline** (when ready)
- **Where:** $0234C8 (func_021 entry point)
- **What:** Jump to `shadow_path_wrapper` at $300400
- **Effort:** Low (1-line assembly change)

---

## 13. Risk Assessment

| Risk | Severity | Likelihood | Mitigation | Status |
|------|----------|------------|------------|--------|
| COMM6 conflict | 🔴 CRITICAL | ✅ CONFIRMED | Change to COMM5 (#3) | ❌ BLOCKS ACTIVATION |
| Parameter block race | 🔴 CRITICAL | HIGH | Add per-call barrier (#2) | ❌ BLOCKS ACTIVATION |
| Frame overrun | 🔴 CRITICAL | MEDIUM | Add frame barrier (#1) | ❌ BLOCKS ACTIVATION |
| Visual corruption | 🟡 HIGH | MEDIUM | Both barriers (#1 + #2) | ⚠️ Mitigated by barriers |
| Slave too slow | 🟡 MEDIUM | LOW | Measure timing (#5) | ⏳ Needs measurement |
| RV bit blocking | 🟢 LOW | ✅ RULED OUT | N/A - verified safe (#4) | ✅ NO ISSUE |

**Overall Risk Level:** 🔴 **CRITICAL - ACTIVATION BLOCKED BY 3 ISSUES**

**Blocking Issues:**
1. 🔴 COMM6 conflict (confirmed - game uses COMM6 extensively)
2. 🔴 Missing per-call synchronization (race condition)
3. 🔴 Missing frame boundary synchronization (frame overrun)

**Must Fix Before Activation:** All 3 blocking issues (#1, #2, #3)

---

## 14. Conclusion

The parallel processing infrastructure is **architecturally sound** but **operationally incomplete**. The missing synchronization barriers create **critical race conditions** that will cause **corruption and instability** if activated.

**Recommendation:** Complete Action Items #1-#4 before activation. Optionally complete #5-#6 for data-driven optimization.

**Estimated effort to make safe:** 4-6 hours (barriers + verification).

**Expected performance gain (when safe):** +15-20% FPS IF synchronization overhead is minimal.

---

## References

1. [expansion_300000.asm](disasm/sections/expansion_300000.asm) - Expansion ROM layout
2. [slave_work_wrapper_v2.asm](disasm/sh2/expansion/slave_work_wrapper_v2.asm) - Slave polling loop
3. [shadow_path_wrapper.asm](disasm/sh2/expansion/shadow_path_wrapper.asm) - Trampoline code
4. [master_dispatch_hook.asm](disasm/sh2/expansion/master_dispatch_hook.asm) - Master dispatcher
5. [cmdint_handler.asm](disasm/sh2/expansion/cmdint_handler.asm) - Interrupt handler
6. [68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) - COMM protocol
7. [MASTER_SLAVE_ANALYSIS.md](analysis/architecture/MASTER_SLAVE_ANALYSIS.md) - Architecture analysis
8. [MEMORY.md](/home/matias/.claude/projects/-mnt-data-src-32x-playground/memory/MEMORY.md) - Memory architecture notes

---

**Document Status:** ✅ Audit Complete
**Next Step:** Review audit findings with user, implement Action Items #1-#4
**Last Updated:** 2026-02-08
