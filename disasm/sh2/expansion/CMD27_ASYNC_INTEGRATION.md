# cmd $27 Async Queue Integration Guide

## Overview

This document describes how to integrate the async cmd $27 queue system into the game.

**Files created:**
- `disasm/sh2/expansion/cmd27_queue_drain.asm` — SH2 queue processor
- `disasm/modules/68k/sh2/sh2_cmd_27_async.asm` — 68K enqueue functions

**Performance gain:** ~1.4ms per frame (0.7ms 68K + 0.7ms SH2)

---

## Memory Layout

### Queue Location

| CPU | Address | Description |
|-----|---------|-------------|
| 68K | `$FFFB00` | Queue in 68K Work RAM |
| SH2 | `$02FFFB00` | Same physical RAM, SH2 view |

### Queue Structure (324 bytes total)

```
Offset  Size  Field
──────  ────  ─────────────────
+$00    2     write_idx (0-31)
+$02    2     read_idx (0-31)
+$04    320   entry[32] × 10 bytes
```

### Entry Format (10 bytes)

```
Offset  Size  Field
──────  ────  ─────────────
+0      4     data_ptr (68K address)
+4      2     width
+6      2     height
+8      2     add_value
```

---

## Integration Steps

### Step 1: Initialize Queue (68K)

At game startup, after 32X initialization:

```asm
; Clear queue indices
        clr.l   $FFFB00             ; write_idx = read_idx = 0
```

Or call `sh2_cmd_27_queue_init` from `sh2_cmd_27_async.asm`.

### Step 2: Add COMM7 Check to Master Poll Loop (SH2)

The Master SH2 poll loop at `$02020460` needs to check COMM7 for the doorbell.

**Original code** (at `$020468`):
```asm
    mov.b   @(1,r8),r4          ; R4 = COMM1 (command byte)
    ; ... dispatch code ...
```

**Modified code** — insert COMM7 check before dispatch:
```asm
    ; Check COMM7 doorbell (queue processing)
    mov.w   @(14,r8),r0         ; R0 = COMM7 (offset 14 from $20004020)
    tst     r0,r0               ; Is COMM7 == 0?
    bt      .no_queue           ; Yes: skip queue processing

    ; Process queue
    mov.l   .L_drain_func,r0    ; R0 = cmd27_queue_drain address
    jsr     @r0                 ; Call queue drain
    nop

.no_queue:
    ; Continue with normal COMM0 check...
    mov.b   @(1,r8),r4          ; R4 = COMM1 (command byte)
    ; ... original dispatch code ...

; Add to literal pool:
.L_drain_func:
    .long   0x02300600          ; cmd27_queue_drain in expansion ROM
```

**Alternative: Hook via expansion ROM trampoline**

Instead of patching the poll loop directly, inject a hook at `$02046A` that:
1. Checks COMM7
2. If set, calls `cmd27_queue_drain`
3. Falls through to original dispatch

### Step 3: Place Queue Drain Handler in Expansion ROM

Add `cmd27_queue_drain` to `expansion_300000.asm` at address `$300600`:

```asm
; At $300600 in expansion ROM
        org     $300600
        include "sh2/expansion/cmd27_queue_drain.asm"
```

Update the literal pool reference in the poll loop hook to point to `$02300600`.

### Step 4: Redirect 68K Calls (Optional)

**Option A: Trampoline patch**

Patch `sh2_cmd_27` at `$00E3B4` to jump to `sh2_cmd_27_enqueue`:

```asm
; At $00E3B4
        jmp     sh2_cmd_27_enqueue      ; Redirect all calls
```

**Option B: Selective replacement**

Find call sites and replace individually. Useful for A/B testing.

**Option C: Parallel operation**

Keep both paths active:
- Original `sh2_cmd_27` for critical/sync operations
- `sh2_cmd_27_enqueue` for bulk operations

### Step 5: Add Frame Sync (Optional)

If visual glitches occur, add a sync point at frame end:

```asm
; Before V-blank / buffer flip
        bsr     sh2_cmd_27_flush        ; Wait for queue to drain
```

This blocks until COMM7 == 0 (queue empty).

---

## Protocol Summary

```
68K                                  Master SH2
 │                                        │
 │  1. Write entry to queue[write_idx]    │
 │  2. write_idx++                        │
 │  3. If was_empty: COMM7 ← $0101        │
 │  4. Return (no wait!)                  │
 │                                        │
 │                          ─────────────→│ [In poll loop]
 │                                        │ Check COMM7 != 0
 │                                        │ Call cmd27_queue_drain
 │                                        │   while read_idx != write_idx:
 │                                        │     process entry[read_idx]
 │                                        │     read_idx++
 │                                        │   COMM7 ← 0
 │                                        │ Continue poll loop
```

---

## Verification

### Queue Empty Check
```bash
# From 68K debugger or memory viewer
# Queue should be empty when idle (write_idx == read_idx)
examine $FFFB00  ; Should show 0000 0000 when idle
```

### COMM7 State
```bash
# COMM7 should be 0 when queue is empty
examine $A1512E  ; 68K view
# Or $2000402E from SH2
```

### Profiling
Use the COMM profiler to track COMM7 transitions:
```bash
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=profile.csv \
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay
```

---

## Rollback

To disable async and revert to synchronous:

1. Remove COMM7 check from poll loop (or comment out)
2. Restore original `sh2_cmd_27` jump target
3. Queue will remain unused (harmless)

---

## Future Extensions

This queue pattern can be extended to other commands:

| Command | Handshakes | Calls/Frame | Queue Benefit |
|---------|------------|-------------|---------------|
| $27 | 3 | 21 | ✅ Implemented |
| $25 | 2 | 14 | High |
| $22 | 3 | 10+ | Medium |
| $2F | 3 | varies | Low |

Each command would need:
- Separate queue (or union struct)
- Entry format matching its parameters
- Dedicated drain handler (or shared with dispatch)
