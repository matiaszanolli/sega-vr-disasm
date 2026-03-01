# COMM Register Usage Analysis - Async Safety Validation

**Date:** 2026-01-27
**Purpose:** Document COMM register usage for async command optimization safety
**Status:** Critical Pre-Implementation Check #2 Complete

---

## COMM Register Memory Map

### 68K Address Space

| Register | Address | SH2 Address | Size | Purpose |
|----------|---------|-------------|------|---------|
| **COMM0** | $00A15120 | $20004020 | word | Status/Control (command ready flag) |
| **COMM1** | $00A15122 | $20004022 | word | Command dispatch type |
| **COMM2** | $00A15124 | $20004024 | word | Work counter/status |
| **COMM3** | $00A15126 | $20004026 | word | Slave "OVRN" marker |
| **COMM4** | $00A15128 | $20004028 | long | **Parameter pointer (primary)** |
| **COMM5** | $00A1512A | $2000402A | word | Status flags |
| **COMM6** | $00A1512C | $2000402C | word | **Handshake/signal flag** |
| **COMM7** | $00A1512E | $2000402E | word | Command type extension |

---

## COMM Register Usage in Blocking Functions

### Function: sh2_send_cmd_wait ($00E316)

**Assembly Code:**
```asm
sh2_send_cmd_wait:
    ; Wait for SH2 ready
    TST.B   COMM0           ; $00A15120 - Test if SH2 ready for command
    BNE.S   sh2_send_cmd_wait  ; Loop until ready (blocking!)

    ; Transform address to SH2 space
    ADDA.L  #$02000000,A0   ; Convert 68K addr → SH2 addr

    ; Submit command
    MOVE.L  A0,COMM4        ; $00A15128 - Write parameter pointer
    MOVE.W  #$0101,COMM6    ; $00A1512C - Signal SH2 (command ready)

    ; Continue to sh2_wait_response (falls through)
```

**COMM Registers Used:**
- **COMM0** (read-only) - Polled for SH2 ready status
- **COMM4** (write) - Parameter pointer passed to SH2
- **COMM6** (write) - Handshake signal to SH2

**Blocking Behavior:**
- Tight spin loop on COMM0 until cleared by SH2
- Estimated 200-400 cycles per wait

---

### Function: sh2_wait_response ($00E342)

**Assembly Code:**
```asm
sh2_wait_response:
    ; Wait for SH2 completion
    TST.B   COMM6           ; $00A1512C - Test if SH2 completed
    BNE.S   sh2_wait_response  ; Loop until complete (blocking!)

    ; Acknowledge completion
    MOVE.L  A1,COMM4        ; $00A15128 - Write secondary parameter
    MOVE.W  #$0101,COMM6    ; $00A1512C - Acknowledge completion

    RTS
```

**COMM Registers Used:**
- **COMM6** (read) - Polled for SH2 completion signal
- **COMM4** (write) - Secondary parameter or acknowledgment
- **COMM6** (write) - Acknowledgment signal

**Blocking Behavior:**
- Tight spin loop on COMM6 until cleared by SH2
- Estimated 150-300 cycles per wait

---

## COMM Register Reuse Analysis

### Per-Frame COMM Slot Usage

Based on the 17 call sites of `sh2_send_cmd_wait`, all use the SAME COMM registers:

```
Call 1:  COMM0 (poll) → COMM4 (write) → COMM6 (write)
Call 2:  COMM0 (poll) → COMM4 (write) → COMM6 (write)
...
Call 17: COMM0 (poll) → COMM4 (write) → COMM6 (write)
```

**CRITICAL FINDING: COMM REGISTER REUSE COLLISION**

All 17 command submissions PER FRAME reuse the SAME COMM registers:
- COMM0 for ready polling
- COMM4 for parameter passing
- COMM6 for handshake

**Why This Works Currently (Blocking Model):**
Each command submission WAITS for SH2 completion before proceeding. Sequence:
```
68K: Write COMM4 + COMM6 (command 1)
68K: Block waiting on COMM0/COMM6
SH2: Process command 1, clear COMM6
68K: Unblock, write COMM4 + COMM6 (command 2)
68K: Block waiting on COMM0/COMM6
SH2: Process command 2, clear COMM6
... (repeat 17 times)
```

**Why This BREAKS With Naive Async:**
Without blocking, multiple commands could overwrite COMM registers before SH2 reads them:
```
68K: Write COMM4 + COMM6 (command 1)  ← Parameters for cmd 1
68K: Return immediately (async)
68K: Write COMM4 + COMM6 (command 2)  ← OVERWRITES cmd 1 parameters!
SH2: Process command with corrupted parameters
```

**Async Safety Requirement:**
- **Option A:** Queue commands in 68K RAM, submit one at a time (single-slot pending queue)
- **Option B:** Use different COMM register pairs for different command types (requires SH2 code changes)
- **Option C:** Batch all commands, submit buffer pointer once per frame

**Phase 1A Recommendation: Option A (Single-Slot Queue)**
- Simplest to implement
- No SH2 code changes required
- Falls back to blocking if SH2 busy
- See [ASYNC_PHASE1A_SAFETY_CHECKLIST.md](ASYNC_PHASE1A_SAFETY_CHECKLIST.md) for implementation

---

## Secondary Status Register: $FFFFC80E

### Discovery

Two call sites ($010B2C, $010BAE) immediately test a RAM address after `sh2_send_cmd_wait`:

**Call Site: $010B2C**
```asm
$010B2C: JSR     $E316(PC)       ; sh2_send_cmd_wait
$010B30: BTST    #4,$FFFFC80E    ; ← Test bit 4 of RAM variable
$010B38: BEQ     $10B40          ; Branch if clear
```

**Call Site: $010BAE**
```asm
$010BAE: JSR     $E316(PC)       ; sh2_send_cmd_wait
$010BB2: MOVEQ   #$00,D0         ; (2 instructions later)
$010BB4: MOVE.B  $FFFFFEA5,D0
$010BBA: BTST    #5,$FFFFC80E    ; ← Test bit 5 of RAM variable
$010BC2: BEQ     $10BAE          ; Loop back (polling!)
```

### Analysis

**Address:** $FFFFC80E
**Type:** 68K RAM (Work RAM, offset $C80E from $FF0000)
**Size:** Byte/Word
**Purpose:** Status flags for SH2 command completion

**Hypothesis:**
This is NOT a COMM hardware register (those are at $A15120-$A1512E). This is a **cached status byte** written by:
1. SH2 via shared memory writes, OR
2. 68K after reading COMM registers

**Polling Pattern:**
```asm
.wait_loop:
    BTST    #5,$FFFFC80E    ; Test bit 5
    BEQ     .wait_loop      ; Loop if clear (blocking!)
```

This is a **secondary blocking wait** in addition to the COMM register waits in `sh2_send_cmd_wait`.

**Implication for Async:**
These two call sites have **double blocking**:
1. `sh2_send_cmd_wait` blocks on COMM0/COMM6 (hardware)
2. Immediately followed by blocking on $FFFFC80E (RAM status)

**Phase 1A Decision:** EXCLUDE these 2 call sites from async optimization (keep them blocking).

---

## COMM Register Safety Summary

### Safe Patterns (15 of 17 call sites)

**Fire-and-Forget:**
```asm
JSR     sh2_send_cmd_wait       ; Submit command
LEA     $000ECC90,A0            ; Setup next command (no COMM reads)
MOVEA.L #$06019000,A1           ; Continue immediately
```

**Characteristics:**
- No COMM register reads after JSR
- No RAM status flag checks ($FFFFC80E)
- Setup for next command or continue with game logic
- Can be converted to async without behavioral changes

---

### Unsafe Patterns (2 of 17 call sites)

**Immediate Status Check:**
```asm
JSR     sh2_send_cmd_wait       ; Submit command
BTST    #4,$FFFFC80E            ; ← Immediate status check
BEQ     branch_target           ; ← Immediate conditional
```

**Characteristics:**
- Immediate read of $FFFFC80E RAM status byte
- Conditional branching based on SH2 completion
- **Cannot be async** without breaking synchronization logic
- Represent frame-boundary sync points

---

## Phase 1A Async Strategy

### Target: 15 Safe Call Sites

**Implementation:**
1. Replace `sh2_send_cmd_wait` with `sh2_send_cmd_async` (15 sites)
2. Keep 2 unsafe sites calling original blocking function
3. Add single-slot pending queue to prevent COMM reuse
4. Add frame-end sync point to ensure completion

**Addresses of Safe Call Sites:**
```
$00FF32, $00FF42, $00FF64, $00FF86, $00FF96
$00FFA6, $00FFB6, $00FFC6, $010B0C, $010B1C
$010B48, $010B58, $010B68, $010BF4, $010C04
```

**Addresses of Unsafe Call Sites (Keep Blocking):**
```
$010B2C  - Tests bit 4 of $FFFFC80E immediately after
$010BAE  - Tests bit 5 of $FFFFC80E with polling loop
```

---

## Expected Performance Impact

### Current (Blocking Model)

**Per-frame overhead:**
```
17 calls × 200-400 cycles (COMM0 wait) = 3,400-6,800 cycles
17 calls × 150-300 cycles (COMM6 wait) = 2,550-5,100 cycles
────────────────────────────────────────────────────────────
Total blocking overhead:                  5,950-11,900 cycles
Percentage of 68K budget:                 4.7-9.3%
Time equivalent:                          0.78-1.55 ms
```

### After Phase 1A (15 Async + 2 Blocking)

**Per-frame overhead:**
```
15 calls × 0 cycles (async, no wait)     = 0 cycles
2 calls × 350-700 cycles (blocking)      = 700-1,400 cycles
────────────────────────────────────────────────────────────
Total blocking overhead:                  700-1,400 cycles
Savings:                                  5,250-10,500 cycles (88%)
Time equivalent saved:                    0.68-1.37 ms
```

**Expected FPS improvement:**
- Current frame time: ~42 ms (24 FPS)
- Time saved: 0.68-1.37 ms
- New frame time: 40.6-41.3 ms
- Expected FPS: 24.2-24.6 (+0.8-2.5%)

**Note:** This is conservative. Actual gains may be higher if:
- SH2 processing overlaps with 68K work
- Other blocking sources are also reduced
- Frame-boundary sync is more efficient than per-command sync

---

## Validation Checklist

### Pre-Implementation

- [x] **COMM register usage documented** (COMM0, COMM4, COMM6 for all calls)
- [x] **COMM reuse collision identified** (all 17 calls use same registers)
- [x] **Single-slot queue required** (prevents parameter corruption)
- [x] **Unsafe call sites identified** (2 sites with RAM status checks)
- [x] **Safe call sites enumerated** (15 sites ready for async)

### Implementation Required

- [ ] Implement single-slot pending queue (fallback to blocking if full)
- [ ] Create `sh2_send_cmd_async` function (returns immediately)
- [ ] Create `sh2_wait_frame_complete` function (sync at frame boundary)
- [ ] Redirect 15 safe call sites to async path
- [ ] Keep 2 unsafe sites calling original blocking function
- [ ] Add instrumentation (cycle counters, overflow detection)

### Post-Implementation Validation

- [ ] Verify no COMM register corruption (parameter integrity)
- [ ] Verify no visual artifacts (frame-by-frame comparison)
- [ ] Verify FPS improvement ≥0.5% (measurable gain)
- [ ] Verify async overflow count = 0 (no SH2 busy collisions)
- [ ] Stress test 30+ minutes (stability)

---

## Related Documents

- [ASYNC_PHASE1A_SAFETY_CHECKLIST.md](ASYNC_PHASE1A_SAFETY_CHECKLIST.md) - Implementation safety checks
- [ASYNC_COMMAND_IMPLEMENTATION_PLAN.md](ASYNC_COMMAND_IMPLEMENTATION_PLAN.md) - Full implementation plan
- [68K_BOTTLENECK_ANALYSIS.md](../profiling/68K_BOTTLENECK_ANALYSIS.md) - Bottleneck identification

---

**Status:** ✅ Critical Check #2 Complete - COMM register reuse collision documented
**Next Action:** Run Critical Check #3 (Frame timeline mapping)
**Risk Level:** MEDIUM (single-slot queue required to prevent corruption)
