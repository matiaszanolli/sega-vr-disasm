# Async Phase 1A - Safety Checklist & Critical Checks

**Date:** 2026-01-27
**Phase:** 1A Proof of Concept (Single Command Type)
**Target:** `sh2_cmd_27` (21 calls/frame)
**Risk Level:** LOW (with proper validation)

---

## Critical Pre-Implementation Checks

### 1. Command Ordering Dependency Analysis

**MUST CHECK BEFORE ASYNC:**

Does `sh2_cmd_27` have immediate result consumption?

```asm
; Pattern to look for at call sites:
call_site:
    jsr     sh2_cmd_27          ; Submit command
    ; DANGER: Does 68K immediately read results?
    move.w  COMM4, d0           ; ← If this happens, results MUST be ready
    tst.w   d0                  ; ← Immediate consumption = NOT safe for async
    beq.s   handle_result
```

**Safe patterns:**
```asm
; Pattern A: Fire-and-forget
jsr     sh2_cmd_27              ; Submit
; ... other 68K work ...
; (results not read until later)

; Pattern B: Batched with other commands
jsr     sh2_cmd_27              ; Submit 1
jsr     sh2_cmd_27              ; Submit 2
; ... more commands ...
; (results processed at frame end)
```

**Unsafe patterns:**
```asm
; Pattern C: Immediate read (BLOCKING REQUIRED)
jsr     sh2_cmd_27              ; Submit
move.w  COMM4, d0               ; ← Read result immediately
; (CANNOT async this command)
```

**Action:**
- [ ] Read disassembly at all 21 call sites of `sh2_cmd_27`
- [ ] Check next 5-10 instructions after each call
- [ ] Document safe vs unsafe call sites
- [ ] If ANY site reads results immediately → **Choose different command for Phase 1A**

**Alternative safe commands if sh2_cmd_27 unsafe:**
- Palette update commands (fire-and-forget)
- Non-critical VDP commands
- Sound commands (async by nature)

---

### 2. COMM Register Reuse Check

**MUST VERIFY:**

Which COMM registers does `sh2_cmd_27` use?

```
COMM0/1: Command type & parameters (write-only, safe)
COMM2/3: Parameter pointers (write-only, safe)
COMM4/5: SH2 status/results (read-only, CRITICAL)
COMM6/7: Handshake flags (read/write, CRITICAL)
```

**Danger scenario:**
```asm
; Frame N:
jsr     sh2_cmd_27              ; Write COMM0-3
; (async returns immediately)
move.w  COMM4, d0               ; ← Read stale data from previous frame!

; OR WORSE:
jsr     sh2_cmd_27              ; Command 1 → COMM0-3
jsr     sh2_graphics_cmd        ; Command 2 → OVERWRITES COMM0-3
; (SH2 processes corrupted parameters!)
```

**Safety rule:**
**NEVER reuse COMM registers for multiple commands in the same frame without sync.**

**Action:**
- [ ] Document which COMM slots each command type uses
- [ ] Verify no COMM slot reuse within frame
- [ ] If reuse detected → **Add intermediate sync points**

**Implementation:**
```c
// Safe: Each command uses different COMM slots
sh2_cmd_27(params)      → COMM0, COMM2 (slot A)
sh2_graphics_cmd(obj)   → COMM1, COMM3 (slot B)

// Unsafe: Commands share COMM slots
sh2_cmd_27(params)      → COMM0, COMM2 (slot A)
sh2_other_cmd(data)     → COMM0, COMM2 (slot A) ← COLLISION!
```

---

### 3. Frame-End Sync Location Validation

**MUST CONFIRM:**

When do commands happen relative to V-INT?

**Dangerous patterns:**
```
V-INT handler:
    [interrupt entry]
    jsr     vdp_update              ← Commands during V-INT
    jsr     sh2_wait_frame_complete ← DEADLOCK! (commands after sync)
    [interrupt exit]
```

**Safe patterns:**
```
Option A: Sync at V-INT start
V-INT handler:
    jsr     sh2_wait_frame_complete ← Sync first
    jsr     vdp_update              ← Then issue new commands
    rte

Option B: Sync at V-INT end
V-INT handler:
    jsr     vdp_update              ← Commands first
    jsr     sh2_wait_frame_complete ← Then sync
    rte

Option C: Sync in main loop (safest)
main_loop:
    jsr     game_logic              ← Issue all commands
    jsr     sh2_wait_frame_complete ← Sync before next frame
    bra     main_loop
```

**Action:**
- [ ] Map all command submission points in frame
- [ ] Identify when they happen relative to V-INT
- [ ] Choose sync point AFTER all submissions
- [ ] Document command timeline:
  ```
  Frame N timeline:
    0 ms:  V-INT start
    2 ms:  Command batch 1 (14 graphics)
    8 ms:  Command batch 2 (21 cmd_27)
    14 ms: ← Sync point must be HERE or later
    16 ms: V-INT end
  ```

---

### 4. Single-Slot Pending Queue (Phase 1A)

**Implementation (minimal):**

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

    ; Write to COMM registers
    move.w  d0, COMM0
    move.l  a0, COMM2
    move.w  #1, COMM6           ; Signal SH2

    ; Increment counters
    addq.w  #1, pending_cmd_count
    addq.l  #1, total_cmds_async

    rts
```

**Why this matters:**
- Prevents COMM register corruption
- Safe fallback if SH2 slower than expected
- Detects async bottlenecks (overflow count)
- Can expand to N-slot queue later

---

### 5. Wait Time Instrumentation (Cycles)

**Enhanced counters:**

```asm
; Data section
total_wait_cycles:      dc.l 0          ; Total cycles spent waiting
max_wait_cycles:        dc.l 0          ; Worst-case wait time
current_wait_start:     dc.l 0          ; Timestamp for wait start
```

**Instrumented wait function:**

```asm
sh2_wait_frame_complete:
    ; Only wait if commands pending
    tst.w   pending_cmd_count
    beq.s   .no_wait

    ; Start cycle timer
    move.l  frame_counter, current_wait_start

.wait_loop:
    ; Poll SH2 status
    move.w  COMM4, d0
    beq.s   .done

    ; Continue waiting
    bra.s   .wait_loop

.done:
    ; Calculate cycles waited
    move.l  frame_counter, d0
    sub.l   current_wait_start, d0      ; d0 = cycles waited

    ; Update totals
    add.l   d0, total_wait_cycles       ; Accumulate
    cmp.l   max_wait_cycles, d0
    ble.s   .not_max
    move.l  d0, max_wait_cycles         ; Track worst case
.not_max:

    ; Clear pending
    clr.w   pending_cmd_count

.no_wait:
    rts
```

**Why this matters:**
- Quantifies exact time savings (10-15 ms → X ms)
- Identifies regressions (max wait cycles increasing)
- Validates async working (total wait cycles decreasing)

---

## Phase 1A Success Criteria (Tightened)

### Functional Requirements

- [ ] **No visual artifacts** (frame-by-frame comparison with original)
- [ ] **No crashes or hangs** (30+ minute stress test)
- [ ] **All game modes work** (menus, racing, replays)
- [ ] **Controls responsive** (no input lag increase)

### Performance Requirements

- [ ] **FPS ≥ 25** in stable scene (Highland track, no opponents)
- [ ] **Total sync waits reduced ≥25%** (baseline: ~30,000 cycles → target: ≤22,500)
- [ ] **Max pending commands ≤1** (confirms single-slot queue sufficient)
- [ ] **Async overflow count = 0** (no SH2 busy collisions)

### Instrumentation Validation

```
=== Phase 1A Results (Target) ===
Baseline (Blocking):
  Total wait cycles:       30,000/frame
  Max wait cycles:         500/command
  FPS:                     24.0

Phase 1A (Async):
  Total wait cycles:       ≤22,500/frame  (25% reduction)
  Max wait cycles:         ≤400/command   (20% reduction)
  Pending cmd count:       ≤1             (single-slot OK)
  Async overflow:          0              (no collisions)
  FPS:                     ≥25.0          (4% improvement minimum)
```

**If results don't meet targets:**
- Max wait cycles increasing → SH2 processing slower than expected
- Async overflow > 0 → Need queue expansion or sync point adjustment
- FPS unchanged → Command chosen has no impact (try different command)

---

## Phase 1A Implementation Checklist

### Pre-Implementation (CRITICAL)

- [ ] **Run all Critical Checks (sections 1-3)**
- [ ] Confirm `sh2_cmd_27` safe for async (no immediate result reads)
- [ ] Document COMM register usage (no reuse conflicts)
- [ ] Map frame timeline (sync point after all commands)
- [ ] Identify safe call sites (at least 5 of 21 sites)

### Implementation

- [ ] Implement single-slot pending queue
- [ ] Add cycle-accurate wait time instrumentation
- [ ] Create `sh2_send_cmd_async` with fallback
- [ ] Add `sh2_wait_frame_complete` with timeout
- [ ] Redirect 5 safe call sites to async path
- [ ] Keep 16 unsafe sites blocking (safety)

### Testing

- [ ] Unit test: Single async command (synthetic)
- [ ] Integration test: 5 async + 16 blocking (mixed mode)
- [ ] Stress test: 30-minute race (stability)
- [ ] Comparison test: Frame captures vs original (correctness)

### Validation

- [ ] Review instrumentation counters
- [ ] Verify success criteria met
- [ ] Document any anomalies
- [ ] **GO/NO-GO decision for Phase 1B**

---

## Failure Modes & Mitigation

### Failure Mode 1: Visual Artifacts

**Symptom:** Missing geometry, flickering, corruption
**Root Cause:** Command results consumed before SH2 completion
**Detection:** Frame comparison shows differences
**Mitigation:**
- [ ] Revert call site to blocking
- [ ] Add intermediate sync point
- [ ] Choose different command for Phase 1A

### Failure Mode 2: Async Overflow

**Symptom:** `async_overflow_count` > 0
**Root Cause:** SH2 processing slower than command submission rate
**Detection:** Counter increments
**Mitigation:**
- [ ] Expand queue to 2-3 slots
- [ ] Add throttling (don't submit if queue full)
- [ ] Reduce async call sites

### Failure Mode 3: No FPS Improvement

**Symptom:** FPS unchanged despite async working
**Root Cause:** Command chosen not on critical path
**Detection:** Wait cycles reduced but FPS flat
**Mitigation:**
- [ ] Profile to find critical commands
- [ ] Try `sh2_graphics_cmd` instead
- [ ] Combine multiple command types

### Failure Mode 4: Deadlock

**Symptom:** Game hangs, no progress
**Root Cause:** Sync point waits for command never submitted
**Detection:** Infinite loop in `sh2_wait_frame_complete`
**Mitigation:**
- [ ] Add timeout (exit after N iterations)
- [ ] Log pending count at deadlock
- [ ] Fix command submission logic

---

## Next Steps After Phase 1A

**If Phase 1A succeeds (≥25% wait reduction, FPS ≥25):**
→ Proceed to Phase 1B (extend to `sh2_graphics_cmd`)

**If Phase 1A inconclusive (wait reduced but FPS unchanged):**
→ Profile to identify true critical path
→ Try different command type

**If Phase 1A fails (artifacts, crashes, deadlock):**
→ Debug root cause (use failure mode mitigation)
→ Consider architectural alternative (batching without async)

---

## Reference Materials

**Addresses to locate (from 68K_BOTTLENECK_ANALYSIS.md):**
- `sh2_cmd_27` call sites: Search for JSR $00E3B4
- `sh2_send_cmd_wait`: $00E316
- `sh2_wait_response`: $00E342
- V-INT handler: Search for vector table entry 6

**Tools:**
- `tools/m68k_disasm.py` - Disassemble call sites
- `tools/generate_call_graph.py` - Map command flows
- `analysis/68K_FUNCTION_REFERENCE.md` - Function documentation

---

**Status:** Safety checklist complete
**Next Action:** Run Critical Checks 1-3 before writing any code
**Timeline:** 1-2 days for validation, 2-3 days for implementation
**Go/No-Go:** After Critical Checks pass
