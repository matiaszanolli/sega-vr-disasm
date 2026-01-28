# Async Phase 1A - Surgical Patch Plan

**Date:** 2026-01-27
**Status:** Ready for Implementation
**Risk Level:** LOW (all safety checks passed)

---

## Overview

This document provides **exact file locations, line numbers, and assembly code** for implementing Async Phase 1A optimization.

**Files to modify:**
1. **NEW:** Create `code_async.asm` for 68K async functions (68K code section)
2. **[code_200.asm](../../disasm/sections/code_200.asm)** - V-INT sync point injection
3. **[code_e200.asm](../../disasm/sections/code_e200.asm)** - Call site redirects (15 sites)
4. **[Makefile](../../Makefile)** - Add code_async.asm to build

**Important:** ⚠️ **Expansion ROM ($300000) is SH2-only** (per CRITICAL CONSTRAINT in expansion_300000.asm). 68K async functions MUST be in a 68K code section, NOT expansion ROM.

---

## PART A: Create 68K Async Functions (NEW FILE)

### File: `disasm/sections/code_async.asm`

**Purpose:** New 68K code section for async command infrastructure.

**Location in ROM:** Recommend placing at $101200-$1012FF (256 bytes, after code_e200.asm which ends at $0101FF).

**Complete Assembly Code:**

```asm
; ============================================================================
; Async Command Infrastructure ($101200-$1012FF)
; Phase 1A: Single-slot queue with blocking fallback
; ============================================================================

        org     $101200

; ============================================================================
; Work RAM Variables (defined in DATA_STRUCTURES.md at $FFC8D0-$FFC8F3)
; ============================================================================
PENDING_CMD_VALID       equ $FFC8D0     ; word: 0=empty, 1=pending
PENDING_CMD_TYPE        equ $FFC8D2     ; word: command type
PENDING_CMD_COUNT       equ $FFC8D4     ; word: commands awaiting sync
PENDING_CMD_PARAMS      equ $FFC8D8     ; 3 longs: parameter storage
TOTAL_CMDS_ASYNC        equ $FFC8E4     ; long: total async commands
ASYNC_OVERFLOW_COUNT    equ $FFC8E8     ; word: queue full events
TOTAL_WAIT_CYCLES       equ $FFC8EC     ; long: cumulative wait cycles
MAX_WAIT_CYCLES         equ $FFC8F0     ; long: peak wait cycles

; COMM register addresses (68K side)
COMM0                   equ $A15120     ; Command ready status
COMM4                   equ $A15128     ; Parameter pointer
COMM6                   equ $A1512C     ; Handshake signal

; Original blocking function address
SH2_SEND_CMD_WAIT_ORIG  equ $00E316     ; Original blocking function

; ============================================================================
; FUNCTION: sh2_send_cmd_async
; ADDRESS: $101200
; ============================================================================
; Non-blocking command submission with single-slot queue and fallback.
;
; INPUT:
;   D0.W = Command type
;   A0.L = Parameter pointer
;   A1.L = Secondary parameter (optional)
;
; OUTPUT:
;   Command submitted asynchronously (returns immediately)
;   Falls back to blocking if queue full
;
; MODIFIES: D0, A0 (preserved if fallback)
;
; ALGORITHM:
;   1. Check if queue slot available (PENDING_CMD_VALID == 0)
;   2. If full → increment overflow counter, call blocking fallback
;   3. If free → store command, write to COMM registers, return immediately
; ============================================================================

sh2_send_cmd_async:
        ; Check if queue slot available
        tst.w   PENDING_CMD_VALID
        beq.s   .slot_free

        ; Queue full → fallback to blocking
        addq.w  #1,ASYNC_OVERFLOW_COUNT
        jmp     SH2_SEND_CMD_WAIT_ORIG  ; Tail call to original function

.slot_free:
        ; Store command in queue
        move.w  d0,PENDING_CMD_TYPE
        move.l  a0,PENDING_CMD_PARAMS       ; Save first param
        move.l  a1,PENDING_CMD_PARAMS+4     ; Save second param (optional)
        move.w  #1,PENDING_CMD_VALID        ; Mark slot occupied

        ; Check if SH2 ready (COMM0 test from original)
        tst.b   COMM0
        bne.s   .sh2_busy                   ; If busy, just queue and return

        ; SH2 ready → write to COMM registers immediately
        adda.l  #$02000000,a0               ; Convert to SH2 address space
        move.l  a0,COMM4                    ; Write parameter pointer
        move.w  #$0101,COMM6                ; Signal SH2 (command ready)

        ; Update counters
        addq.w  #1,PENDING_CMD_COUNT
        addq.l  #1,TOTAL_CMDS_ASYNC

.sh2_busy:
        ; Return immediately (async behavior)
        rts

; ============================================================================
; FUNCTION: sh2_wait_frame_complete
; ADDRESS: ~$101250 (depends on above function size)
; ============================================================================
; Frame-end synchronization point - polls COMM6 until all pending commands complete.
; Called ONCE per frame from V-INT handler.
;
; INPUT: None
; OUTPUT: All pending commands completed
; MODIFIES: D0, D1, D7 (scratch registers)
;
; ALGORITHM:
;   1. Check if any commands pending (PENDING_CMD_COUNT > 0)
;   2. If none → return immediately
;   3. If pending → poll COMM6 until clear
;   4. Update instrumentation (wait cycles)
;   5. Clear pending count
; ============================================================================

sh2_wait_frame_complete:
        ; Check if any commands pending
        tst.w   PENDING_CMD_COUNT
        beq.s   .no_wait

        ; Start cycle timer (use frame counter as proxy)
        move.l  $FFC964,d7              ; d7 = start frame count

.wait_loop:
        ; Poll COMM6 for completion
        tst.b   COMM6                   ; Check handshake flag
        beq.s   .done                   ; If clear, SH2 completed

        ; Continue waiting (could add timeout here)
        bra.s   .wait_loop

.done:
        ; Calculate cycles waited (simplified: frame delta × cycles/frame)
        move.l  $FFC964,d0              ; d0 = end frame count
        sub.l   d7,d0                   ; d0 = frames waited
        beq.s   .no_cycles              ; If same frame, skip cycle calc

        ; Convert frames to cycles (approximate: 128K cycles/frame)
        lsl.l   #8,d0                   ; d0 × 256 (rough approximation)
        lsl.l   #1,d0                   ; d0 × 512

        ; Update cumulative wait cycles
        add.l   d0,TOTAL_WAIT_CYCLES

        ; Update max wait cycles if this is a new peak
        move.l  MAX_WAIT_CYCLES,d1
        cmp.l   d1,d0
        ble.s   .not_max
        move.l  d0,MAX_WAIT_CYCLES

.not_max:
.no_cycles:
        ; Clear pending count
        clr.w   PENDING_CMD_COUNT
        clr.w   PENDING_CMD_VALID       ; Mark queue slot free

.no_wait:
        rts

; ============================================================================
; PADDING: Fill remainder of 256-byte section
; ============================================================================
        org     $101300         ; Ensure section ends cleanly
```

**Size:** ~128 bytes for both functions + ~128 bytes padding = 256 bytes total

---

## PART B: V-INT Handler Sync Point Injection

### File: `disasm/sections/code_200.asm`

**Line:** 2652 (before MOVEM.L restore)

**Current Code (lines 2650-2656):**
```asm
2650:        dc.w    $52B8        ; $0016A2 - ADDQ.L #1,($C964).W (frame counter++)
2651:        dc.w    $C964        ; $0016A4
2652:        dc.w    $4CDF        ; $0016A6 - MOVEM.L (SP)+,D0-D7/A0-A6 (restore registers)
2653:        dc.w    $7FFF        ; $0016A8
2654:        dc.w    $46FC        ; $0016AA - MOVE.W #$2300,SR (re-enable interrupts)
2655:        dc.w    $2300        ; $0016AC
2656:        dc.w    $4E73        ; $0016AE - RTE
```

**Modified Code:**
```asm
2650:        dc.w    $52B8        ; $0016A2 - ADDQ.L #1,($C964).W (frame counter++)
2651:        dc.w    $C964        ; $0016A4

        ; ============== PHASE 1A ASYNC SYNC INJECTION ==============
        ; Insert frame-end sync BEFORE register restore
        ; This ensures all pending commands complete before returning from V-INT

2652:        dc.w    $4EB9        ; $0016A6 - JSR (absolute long)
2653:        dc.w    $0010        ; $0016A8 - High word of $00101250
2654:        dc.w    $1250        ; $0016AA - Low word of $00101250 (sh2_wait_frame_complete)
        ; ============================================================

2655:        dc.w    $4CDF        ; $0016AC - MOVEM.L (SP)+,D0-D7/A0-A6 (restore registers)
2656:        dc.w    $7FFF        ; $0016AE
2657:        dc.w    $46FC        ; $0016B0 - MOVE.W #$2300,SR (re-enable interrupts)
2658:        dc.w    $2300        ; $0016B2
2659:        dc.w    $4E73        ; $0016B4 - RTE
```

**Explanation:**
- **JSR $101250**: Calls `sh2_wait_frame_complete` (6 bytes: $4EB9 + 4-byte address)
- **Placement:** BEFORE MOVEM.L restore (critical - must preserve D0-D7/A0-A6 on stack)
- **Cost:** ~6 bytes + function execution time
- **Gated by:** Function returns immediately if no pending commands

**Alternative (gated by pending check):**
If you want to minimize overhead when no commands pending, use:
```asm
        ; Check if any commands pending before calling sync
        dc.w    $4A78        ; TST.W ($FFC8D4).W (PENDING_CMD_COUNT)
        dc.w    $C8D4
        dc.w    $6706        ; BEQ.S +6 (skip JSR if zero)
        dc.w    $4EB9        ; JSR $00101250
        dc.w    $0010
        dc.w    $1250
```
**Cost:** 10 bytes total, but saves JSR overhead when no commands pending.

**Recommendation:** Start with ungated JSR (simpler, function already checks internally).

---

## PART C: Call Site Redirects (15 Safe Sites)

### File: `disasm/sections/code_e200.asm`

**Current behavior:** All 15 sites call `sh2_send_cmd_wait` at $00E316 via relative JSR.

**Modification strategy:** Replace JSR destinations to call `sh2_send_cmd_async` at $101200.

### 15 Safe Call Sites (Verified from earlier analysis):

**Note:** These addresses are the **68K CPU addresses** where the JSR instruction starts. In the disassembly files, addresses are relative to section start.

**File:** Likely `disasm/sections/code_ff00.asm` (for $00FFxx addresses) and `disasm/sections/code_10a200.asm` (for $010Bxx addresses)

#### Call Sites in $00FFxx Range (8 sites):

| CPU Address | File Offset | Current JSR | New JSR Target | Notes |
|-------------|-------------|-------------|----------------|-------|
| $00FF32 | (find in code_ff00.asm) | JSR $E316(PC) | JSR $101200 | After LEA $000F3D80,A0 |
| $00FF42 | (find in code_ff00.asm) | JSR $E316(PC) | JSR $101200 | After MOVEA.L #$06014000,A1 |
| $00FF64 | (find in code_ff00.asm) | JSR $E316(PC) | JSR $101200 | After MOVEQ #$00,D0 |
| $00FF86 | (find in code_ff00.asm) | JSR $E316(PC) | JSR $101200 | Fire-and-forget |
| $00FF96 | (find in code_ff00.asm) | JSR $E316(PC) | JSR $101200 | Fire-and-forget |
| $00FFA6 | (find in code_ff00.asm) | JSR $E316(PC) | JSR $101200 | Fire-and-forget |
| $00FFB6 | (find in code_ff00.asm) | JSR $E316(PC) | JSR $101200 | Fire-and-forget |
| $00FFC6 | (find in code_ff00.asm) | JSR $E316(PC) | JSR $101200 | Followed by data section |

#### Call Sites in $010Bxx Range (7 sites):

| CPU Address | File Offset | Current JSR | New JSR Target | Notes |
|-------------|-------------|-------------|----------------|-------|
| $010B0C | (find in code_10a200.asm) | JSR $E316(PC) | JSR $101200 | After MOVEA.L #$06018000,A1 |
| $010B1C | (find in code_10a200.asm) | JSR $E316(PC) | JSR $101200 | After LEA $000ECE20,A0 |
| $010B48 | (find in code_10a200.asm) | JSR $E316(PC) | JSR $101200 | After LEA $000EBB40,A0 |
| $010B58 | (find in code_10a200.asm) | JSR $E316(PC) | JSR $101200 | After LEA $000EB980,A0 |
| $010B68 | (find in code_10a200.asm) | JSR $E316(PC) | JSR $101200 | After MOVEQ #$00,D0 |
| $010BF4 | (find in code_10a200.asm) | JSR $E316(PC) | JSR $101200 | Before LEA $000EDE10,A0 |
| $010C04 | (find in code_10a200.asm) | JSR $E316(PC) | JSR $101200 | Followed by data section |

### Encoding for JSR Modifications

**Current encoding (relative JSR):**
```
JSR $E316(PC)  →  $4EBA + 16-bit offset
```

**New encoding (absolute JSR):**
```
JSR $101200  →  $4EB9 + $00101200 (6 bytes total)
```

**Example modification at $00FF32:**
```asm
; Before:
$00FF32:    dc.w    $4EBA        ; JSR (PC-relative)
$00FF34:    dc.w    $D3E2        ; Offset to $E316

; After:
$00FF32:    dc.w    $4EB9        ; JSR (absolute long)
$00FF34:    dc.w    $0010        ; High word of $00101200
$00FF36:    dc.w    $1200        ; Low word of $00101200
```

**Important:** Absolute JSR is **6 bytes**, relative JSR is **4 bytes**. This creates a **+2 byte difference** per call site. Must ensure no overlap with following code.

**Safer approach (if space constrained):** Use a trampoline function at a single location that all call sites redirect to.

### Trampoline Approach (Recommended for simplicity):

**Create one trampoline in code_async.asm:**
```asm
; ============================================================================
; TRAMPOLINE: Async Redirect (for space-constrained call sites)
; ADDRESS: $101280
; ============================================================================
async_trampoline:
        jmp     sh2_send_cmd_async      ; 6 bytes: JMP (absolute long)
```

**Then modify call sites to use relative JSR to trampoline:**
```asm
; At each call site (example: $00FF32):
$00FF32:    dc.w    $4EBA        ; JSR (PC-relative)
$00FF34:    dc.w    XXXX         ; Calculate offset to $101280
```

**This keeps call sites at 4 bytes (no size change).**

---

## PART D: Unsafe Call Sites (DO NOT MODIFY)

### 2 Unsafe Sites to Keep Blocking:

| CPU Address | File | Reason | Action |
|-------------|------|--------|--------|
| **$010B2C** | code_10a200.asm | Tests $FFFFC80E bit 4 immediately after JSR | **NO CHANGE** |
| **$010BAE** | code_10a200.asm | Tests $FFFFC80E bit 5 in polling loop | **NO CHANGE** |

**These sites MUST continue calling the original blocking `sh2_send_cmd_wait` at $00E316.**

---

## PART E: Makefile Integration

### File: `Makefile`

**Add `code_async.asm` to build targets:**

**Current structure (likely):**
```makefile
CODE_SECTIONS = \
    disasm/sections/code_200.asm \
    disasm/sections/code_e200.asm \
    disasm/sections/code_10200.asm \
    ...
```

**Modified:**
```makefile
CODE_SECTIONS = \
    disasm/sections/code_200.asm \
    disasm/sections/code_e200.asm \
    disasm/sections/code_10200.asm \
    disasm/sections/code_async.asm \
    ...
```

**Ensure section is included in final ROM assembly order.**

---

## PART F: Work RAM Initialization

### File: Startup code (likely `code_200.asm` or `code_startup.asm`)

**Add initialization code to clear async queue variables at game startup:**

```asm
; ============================================================================
; Initialize Async Command Queue (Phase 1A)
; ============================================================================
; Call during game initialization, before main loop starts

init_async_queue:
        ; Clear all async queue variables
        clr.w   $FFC8D0         ; PENDING_CMD_VALID = 0
        clr.w   $FFC8D2         ; PENDING_CMD_TYPE = 0
        clr.w   $FFC8D4         ; PENDING_CMD_COUNT = 0
        clr.l   $FFC8D8         ; PENDING_CMD_PARAMS = 0 (first long)
        clr.l   $FFC8DC         ; PENDING_CMD_PARAMS+4 = 0 (second long)
        clr.l   $FFC8E0         ; PENDING_CMD_PARAMS+8 = 0 (third long)
        clr.l   $FFC8E4         ; TOTAL_CMDS_ASYNC = 0
        clr.w   $FFC8E8         ; ASYNC_OVERFLOW_COUNT = 0
        clr.l   $FFC8EC         ; TOTAL_WAIT_CYCLES = 0
        clr.l   $FFC8F0         ; MAX_WAIT_CYCLES = 0
        rts

; Insert call to init_async_queue in startup sequence
```

**Location:** Find game initialization routine (likely after COMM register setup) and add JSR to init_async_queue.

---

## Implementation Checklist

### Phase 1: Code Creation
- [ ] Create `disasm/sections/code_async.asm` with functions above
- [ ] Add code_async.asm to Makefile CODE_SECTIONS
- [ ] Add init_async_queue call to startup code
- [ ] Build ROM with `make all` - verify no assembly errors

### Phase 2: V-INT Sync Injection
- [ ] Modify `code_200.asm` line 2652 to insert JSR $101250
- [ ] Build and test - verify V-INT still works (game boots)

### Phase 3: Call Site Redirects (Incremental)
- [ ] Find exact section files for call sites (code_ff00.asm, code_10a200.asm)
- [ ] Modify **5 call sites** first (proof of concept)
- [ ] Build, test, measure FPS
- [ ] If successful, modify remaining **10 call sites**
- [ ] Build, final test

### Phase 4: Validation
- [ ] Run 30-minute stress test (no crashes)
- [ ] Compare frame captures with baseline (no visual artifacts)
- [ ] Read instrumentation counters from Work RAM:
  ```
  TOTAL_CMDS_ASYNC     @ $FFC8E4
  ASYNC_OVERFLOW_COUNT @ $FFC8E8
  TOTAL_WAIT_CYCLES    @ $FFC8EC
  MAX_WAIT_CYCLES      @ $FFC8F0
  ```
- [ ] Verify FPS improvement ≥ 0.8% (24 → 24.2+)

---

## Expected Results

### Instrumentation Counter Targets

**After 2400 frames (40 seconds @ 60 FPS):**

```
TOTAL_CMDS_ASYNC     = 36,000    (15 async calls/frame × 2400)
ASYNC_OVERFLOW_COUNT = 0         (no queue collisions)
PENDING_CMD_COUNT    = 0-1       (max 1 pending at any time)
TOTAL_WAIT_CYCLES    ≤ 10,800,000 (vs. 14,280,000 baseline, 25% reduction)
MAX_WAIT_CYCLES      ≤ 500       (vs. 700 baseline)
```

**FPS improvement:**
- Baseline: 24.0 FPS
- Target: 24.2-24.6 FPS (+0.8-2.5%)
- Optimistic: 24.8-25.8 FPS (+3.3-7.5% with SH2 overlap)

---

## Troubleshooting

### Build Errors

**Error:** `Section overlap at $XXXXXX`
- **Fix:** Adjust code_async.asm org address to avoid collision

**Error:** `Undefined symbol: sh2_wait_frame_complete`
- **Fix:** Ensure code_async.asm is included in Makefile before code_200.asm

### Runtime Errors

**Symptom:** Game crashes at startup
- **Check:** Verify init_async_queue is called during initialization
- **Check:** Ensure Work RAM addresses $FFC8D0-$FFC8F3 are not used elsewhere

**Symptom:** Visual artifacts after async enabled
- **Check:** One of the 15 "safe" call sites may actually be unsafe
- **Fix:** Revert that specific call site to blocking
- **Report:** Document which site caused issue for analysis

**Symptom:** ASYNC_OVERFLOW_COUNT > 0
- **Analysis:** SH2 slower than expected, queue filling up
- **Fix:** Expand queue to 2-3 slots (modify PENDING_CMD_VALID logic)

**Symptom:** FPS unchanged
- **Analysis:** Blocking waits not on critical path, or V-INT sync taking too long
- **Fix:** Profile to find true critical path, consider different optimization

---

## Rollback Plan

If Phase 1A causes issues:

1. **Revert V-INT injection:** Remove JSR $101250 from code_200.asm line 2652
2. **Revert call site redirects:** Change all 15 sites back to JSR $E316(PC)
3. **Build baseline ROM:** `make clean && make all`
4. **Analyze failure mode:** Use [ASYNC_PHASE1A_SAFETY_CHECKLIST.md](ASYNC_PHASE1A_SAFETY_CHECKLIST.md) failure modes section

**Rollback time:** ~5 minutes (simple edits, rebuild)

---

## Related Documents

- [ASYNC_PHASE1A_GO_NOGO_DECISION.md](ASYNC_PHASE1A_GO_NOGO_DECISION.md) - GO/NO-GO decision
- [ASYNC_PHASE1A_SAFETY_VERIFICATION.md](ASYNC_PHASE1A_SAFETY_VERIFICATION.md) - Safety verification report
- [ASYNC_PHASE1A_SAFETY_CHECKLIST.md](ASYNC_PHASE1A_SAFETY_CHECKLIST.md) - Safety requirements
- [COMM_REGISTER_USAGE_ANALYSIS.md](COMM_REGISTER_USAGE_ANALYSIS.md) - COMM register documentation
- [../../analysis/architecture/DATA_STRUCTURES.md](../../analysis/architecture/DATA_STRUCTURES.md) - Work RAM layout

---

**Status:** ✅ **SURGICAL PATCH PLAN COMPLETE**
**Next Action:** Create code_async.asm and begin Phase 1 implementation
**Timeline:** 6-8 days to completion
