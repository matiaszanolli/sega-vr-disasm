# Expansion ROM Communication Protocol (ABI)

**Date:** 2026-01-21
**Version:** 1.0
**Status:** **REVOKED / HISTORICAL** — invalid `$22000100` memory premise

> `$22000100` is cache-through cartridge ROM, not writable SDRAM, and the 68000
> cannot read SH2 SDRAM directly. COMM4 remains the only diagnostic described
> here that could be observed by both sides; this ABI must not be treated as locked.

---

## Overview

This document defines the Master (68K) ↔ Slave (SH2) communication protocol for expansion ROM operations.

**Design Principles:**
- Hardware-safe (no undefined simultaneous writes)
- Deterministic (edge-triggered, not level-triggered)
- Scalable (single command now, extensible to job queue later)
- Diagnostically observable through COMM4 (the historical SDRAM mirror was invalid)

---

## Register Ownership

### COMM6 (Master → Slave Signal)

**Address:**
- 68K: $A1512C
- SH2: $2000402C

**Ownership:** Master writes, Slave reads only

**Values:**
- 0x0000 = No signal (Slave has acknowledged and cleared)
- 0x0012 = Frame tick request (Slave should execute expansion_frame_counter)

**Ack Semantics:** **Edge-triggered with Slave clearing**
- Master writes 0x0012 every V-INT
- Slave reads COMM6, detects signal
- Slave services the request (call expansion_frame_counter, increment counter)
- **Slave clears COMM6 to 0x0000** (important: prevents repeated triggers)
- Master never modifies COMM6 beyond writing 0x0012 each frame

**Why Slave clears:**
- Prevents ambiguous repeated execution if Slave polls multiple times per frame
- Makes protocol edge-triggered (0000→0012 is the signal)
- Master can safely write same value every frame without special logic

### COMM4 (Slave → Master Response)

**Address:**
- 68K: $A15128
- SH2: $20004028

**Ownership:** Slave writes, Master reads only

**Content:** Frame counter (16-bit unsigned)

**Increment:** Slave increments COMM4 after processing expansion_frame_counter

**Semantics:**
- Read by Master (68K) to verify Slave is executing
- Counter should increment every frame that expansion code runs
- Historically intended as the primary observable counter; not live-validated
- Historical SDRAM-mirror claim retracted

---

## Retracted Diagnostic-State Design

**Invalid historical literal:** 0x22000100 (cartridge ROM, not SDRAM)

**Layout:**
```
0x22000100: historical invalid frame-counter location
              - Incremented by Slave in expansion_frame_counter
              - Not writable as SDRAM
              - Not readable by the 68000 as shared RAM

0x22000104: 32-bit execution count (future use)
0x22000108: 32-bit error flags (future use)
0x2200010C: Reserved (align to cache line)
```

**Why this design was rejected:**
- COMM registers are precious and volatile
- `$22000100` selects cartridge ROM
- correct SH2 SDRAM would use `$060/$260`, but the 68000 cannot access it directly
- no valid producer/consumer diagnostic path was established

---

## Protocol Sequence (Per-Frame)

### Master (68K)

```
V-INT Handler:
  1. At $00037A hook point
  2. Write MOVE.W #$0012, $A1512C (COMM6)
  3. (don't touch COMM6 again until next frame)
  4. Continue V-INT handler
```

**Timing:** Every V-INT (~50-60 Hz depending on PAL/NTSC)

### Slave (SH2)

```
Slave Polling Loop (once per frame, after COMM6 hook is integrated):
  1. Read COMM6 register
  2. Check if value == 0x0012
  3. If no: loop back (no signal)
  4. If yes:
     a. Call expansion_frame_counter (in expansion ROM)
     b. Historical invalid step: attempted increment at ROM alias 0x22000100
     c. Increment COMM4 register
     d. Write 0x0000 to COMM6 (CRITICAL: acknowledge/clear)
     e. Loop back
```

**Note:** Slave **must** clear COMM6 to prevent repeated execution if polling rate > V-INT rate.

---

## State Machine (Timing Safe)

```
Master State          COMM6    Slave State
─────────────────────────────────────────────
Waiting for ack       0x0000   Idle, polling
V-INT fires           0x0012   Detects signal
(same)                0x0012   Servicing (increment counter)
(same)                0x0012   Clear COMM6
Waiting for ack       0x0000   Idle, ready for next signal
Next V-INT            0x0012   (cycle repeats)
```

**Key Invariant:** Master only writes; Slave only clears. No race conditions.

---

## Error Conditions

### Slave Not Responding

**Symptom:** COMM4 stuck at same value for multiple frames

**Root Causes:**
1. Slave hook not yet installed (expected in Phase 11)
2. Slave crash/exception in expansion code
3. Slave stuck in infinite loop

**Historical diagnostic (invalid):** 0x22000100 is cartridge ROM, not an SDRAM counter.
Do not use it to infer Slave execution. A future SDRAM diagnostic would need a verified
`$260xxxxx` address plus a reader/consumer trace.
- Compare against expected value: `expected = frame_count_since_boot`

### Master Not Signaling

**Symptom:** COMM6 never becomes 0x0012

**Root Causes:**
1. V-INT hook not yet installed (expected in Phase 7)
2. V-INT not firing (system hang)
3. Hook code corrupted

**Diagnostic:**
- Boot ROM should complete before V-INT fires
- Check that V-INT handler is running (observe game rendering)
- Use debugger to inspect opcode at 0x00037A

---

## Extension Points (Future)

### Multiple Commands (Job Queue)

**Possible expansion:**
```
COMM6: Command queue head pointer
COMM5: Command queue tail pointer (Slave writes)
COMM3/COMM2: Job parameter 1 / Job parameter 2
Prospective SH2-only SDRAM `$26000110+`: command queue buffer (not 68000-writable)
```

**Compatible with current design?** Yes—protocol remains edge-triggered, COMM4 still response counter.

### Latency Measurement

**Historical concept; would require a valid SH2-only producer:**
```
0x26000110: Master-SH2 write timestamp (cycle counter)
0x26000114: Slave-SH2 read timestamp (cycle counter)
→ Measure latency = read - write
```

---

## Testing & Validation

### Baseline Smoke Test (Phase 11)

```
1. Boot ROM
2. Wait for V-INT to fire (observe game)
3. Read COMM4 register
   - It should be non-zero if the Slave path genuinely executes
5. Wait 1 frame
6. Inspect again
   - COMM4 should increment by 1
7. Repeat 5-10 frames
   - COMM4 should be monotonically increasing
```

### Retracted Hardware-Validation Procedure

This procedure is invalid because `$22000100` is ROM:
```
1. Do not hook 0x22000100 as a counter
2. Validate COMM4 and exact Slave execution instead
3. Allocate any replacement diagnostic in collision-checked $260xxxxx SDRAM
```

---

## Invariants (Do Not Violate)

1. **Master writes COMM6 only (once per V-INT with value 0x0012)**
   - If you add multiple commands, use COMM5/COMM3 for parameters, not COMM6

2. **Slave clears COMM6 to 0x0000 after servicing**
   - Required to prevent repeated execution

3. **COMM4 is Slave write-only** (Master reads only)
   - Future: could add COMM3/COMM2 for parameters

4. **No SDRAM counter is canonical in this historical ABI**
   - `$22000100` must never be used as liveness evidence
   - establish any future `$260xxxxx` diagnostic independently

5. **No blocking or waiting in Slave hook**
   - Hook must be register-preserving
   - Must not touch VDP, DMA, or 68K-visible areas

---

## Implementation Checklist (Phase 11)

- [ ] Slave hook inserted at confirmed polling loop location
- [ ] Hook reads COMM6 and compares against 0x0012
- [ ] Hook calls expansion_frame_counter if match
- [ ] Hook clears COMM6 to 0x0000 after servicing
- [ ] Any future SDRAM diagnostic uses a verified `$260xxxxx` address and reader
- [ ] Hook increments COMM4
- [ ] Hook preserves all registers except those written
- [ ] Baseline smoke test passes (counters increment per frame)
- [ ] No game crashes or stalls

---

## References

- **HARDWARE_COMPLIANCE_VERIFICATION.md** - Detailed verification against official Sega 32X Hardware Manual
- Hardware Manual Section 3.2.2 (COMM registers - A15120-A1512E Communication Port)
- Hardware Manual Section 1.13 (Boot ROM sequence, V-INT timing)
- EXPANSION_ROM_MILESTONE_v2_1.md (implementation details and status)
- PHASE11_SLAVE_HOOK_ROADMAP.md (Phase 11 mechanical implementation guide)
- NEXT_STEPS.md (earlier testing plan)

---

**Status:** **REVOKED / NOT READY FOR IMPLEMENTATION**
