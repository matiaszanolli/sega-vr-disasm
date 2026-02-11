# Master SH2 Command Dispatch — Complete Control Flow Analysis

**Date:** February 11, 2026
**Context:** Root cause analysis of the B-006 race-mode crash.
**Related:** [KNOWN_ISSUES.md](../../KNOWN_ISSUES.md) § COMM7 Signal Namespace Collision

---

## Overview

The Master SH2 command dispatch loop is the central hub through which all 68K commands flow to SH2 handlers. Understanding its exact control flow — register usage, literal pool layout, PR (procedure register) semantics, and interaction with COMM7 — is critical for any patch that modifies dispatch behavior.

This document records the byte-level analysis performed to diagnose the B-006 race-mode crash.

---

## Original Dispatch Loop (Unpatched)

Location: `code_20200.asm`, SH2 addresses `$020460`–`$020476`.

### Idle Poll (reads COMM0 for commands from 68K)

```
$020460: D809  MOV.L @(36,PC),R8     ; R8 = 0x20004020 (COMM0 address)
$020462: 6080  MOV.B @R8,R0          ; R0 = COMM0 high byte (command flag)
$020464: 8800  CMP/EQ #0,R0          ; Is it zero?
$020466: 89FB  BT $020460            ; Yes → keep polling (d=-5)
$020468: 8481  MOV.B @(1,R8),R0      ; R0 = COMM0 low byte (command code)
```

**D809 literal verification:**
- PC = $020460 + 4 = $020464, aligned: $020464
- EA = $020464 + 9×4 = $020488
- Value at $020488: `$2000 $4020` = 0x20004020 (COMM0 address) ✓

**Key state at $02046A:** R0 = command code (0x01–0xFF), R8 = COMM0 address.

### Command Dispatch (table lookup + JSR to handler)

```
$02046A: 4008  SHLL2 R0              ; R0 = cmd × 4 (table index)
$02046C: D107  MOV.L @(28,PC),R1     ; R1 = 0x06000780 (jump table base)
$02046E: 001E  MOV.L @(R0,R1),R0     ; R0 = handler address from table
$020470: 400B  JSR @R0               ; Call handler (PR = $020474)
$020472: 0009  NOP                   ; Delay slot
$020474: AFF4  BRA $020460           ; Loop back to idle poll (d=-12)
$020476: 0009  NOP                   ; Delay slot
```

**D107 literal verification:**
- PC = $02046C + 4 = $020470, aligned: $020470
- EA = $020470 + 7×4 = $02048C
- Value at $02048C: `$0600 $0780` = 0x06000780 (jump table in SDRAM) ✓

**BRA AFF4 verification:**
- d = 0xFF4 (12-bit signed) = -12
- Target = $020474 + 4 + (-12)×2 = $020478 - 24 = $020460 ✓

### PR Flow Through Handler Call

1. `JSR @R0` at $020470 sets PR = $020474 (next instruction after delay slot)
2. Handler executes — if non-leaf, saves PR to stack, does work, restores PR
3. Handler RTS → PC = PR = $020474
4. $020474: BRA $020460 → back to idle poll

This is a standard SH2 dispatch pattern: JSR sets the return point, handler obeys save/restore convention, RTS returns to the BRA that loops.

---

## Literal Pool Map ($020478–$02048E)

These literals are shared by multiple instructions. **Any patch that modifies this region must verify all references.**

| Address | Value | Referenced by |
|---------|-------|--------------|
| $020478 | $FFFF FE10 | (data — not a MOV.L target in dispatch area) |
| $02047C | $2000 4000 | Unknown — possibly referenced from init code |
| $020480 | $0600 45CC | **D011 at $020438** (Master init: JSR to SDRAM function) |
| $020484 | $0600 FF80 | Unknown |
| $020488 | $2000 4020 | **D809 at $020460** (COMM0 address for idle poll) |
| $02048C | $0600 0780 | **D107 at $02046C** (Jump table base for dispatch) |

**Critical:** $020480 is loaded by `D011` at $020438 during Master SH2 initialization. The committed B-006 Patch #2 placed its hook literal (0x02300050) at $020480, silently redirecting the init code's JSR to the dispatch hook instead of `0x060045CC`. This is a latent corruption bug — it may not crash immediately but executes wrong code during init.

### How to Check for Literal Pool Sharing

SH2 `MOV.L @(disp,PC),Rn` opcode format: `1101 nnnn dddddddd` ($Dnxx)

The effective address is: `EA = (PC & 0xFFFFFFFC) + disp × 4` where `PC = instruction_address + 4`.

To find all instructions that load from a given literal address:

```python
def find_literal_refs(rom, section_start, section_end, target_addr):
    """Find all MOV.L @(disp,PC) instructions targeting a specific address."""
    refs = []
    for addr in range(section_start, section_end, 2):
        opcode = struct.unpack('>H', rom[addr:addr+2])[0]
        if (opcode & 0xF000) == 0xD000:
            disp = (opcode & 0xFF) * 4
            pc = (addr + 4) & ~3
            ea = pc + disp
            if ea == target_addr:
                rn = (opcode >> 8) & 0xF
                refs.append((addr, rn, opcode))
    return refs
```

**Rule:** Always run this check before placing a literal at any address in an SH2 code section.

---

## Slave SH2 Execution Model

### Boot Sequence

The Slave SH2 boot sequence runs ROM code, sets up interrupt vectors and hardware, then reaches $0203CC:

```
$0203CC: D101  MOV.L @(4,PC),R1     ; R1 = 0x2000402C (COMM6)
$0203CE: 2102  MOV.L R0,@R1         ; COMM6 = R0 (status from init)
$0203D0: AFFE  BRA $0203D0          ; Infinite loop (terminal idle)
```

This is a **terminal idle loop** — `BRA $0203D0` branches to itself forever. The Slave writes a value to COMM6 (likely a "boot complete" signal) and spins.

### How the Slave Does Rendering

The Slave's actual rendering work is driven by **interrupts**, NOT by breaking out of the idle loop:

1. During boot (before reaching $0203CC), the Slave sets up interrupt vectors
2. The Slave's VINT or command interrupt handler is at $06000608 (SDRAM)
3. The idle loop spins at $0203D0
4. When a rendering interrupt fires, the handler at $06000608 takes over
5. The handler polls COMM1, dispatches to rendering functions
6. Handler returns (RTE) → back to the idle loop

**Profiling evidence:** The Slave hotspot is at $0600060A (NOP in idle loop at SDRAM dispatch). This SDRAM dispatch processes COMM1 commands and is the Slave's main rendering path. It runs via interrupts, independent of the ROM idle loop at $0203CC.

### Implication for Patch #1

Replacing the ROM idle loop at $0203CC with `slave_work_wrapper` (COMM7 polling) is **safe for rendering**:

- The SDRAM interrupt handler continues to fire and process COMM1 commands
- Between interrupts, the Slave polls COMM7 instead of spinning at BRA
- COMM7 signals (e.g., 0x16 vertex transform) are processed at base level
- Interrupts preempt the COMM7 poll loop normally

**Caution:** The COMM6 write (`MOV.L R0,@R1`) may be a boot handshake. If the 68K checks COMM6 during init, skipping this write could delay or break initialization. Current testing shows menus work, suggesting the handshake is either not checked or R0's value at that point is coincidentally acceptable.

---

## B-006 Patch #2 — Three Bugs Analyzed

### Bug 1: R0 Clobbered (Committed in 651a415)

```
; Committed (buggy):
$02046A: D005  MOV.L @(20,PC),R0     ; R0 = 0x02300050 (OVERWRITES command byte!)
$02046C: 400B  JSR @R0               ; Calls hook — but hook reads R0 expecting cmd byte

; Fixed (uncommitted):
$02046A: D102  MOV.L @(8,PC),R1      ; R1 = 0x02300050 (R0 preserved with cmd)
$02046C: 410B  JSR @R1               ; R0 still has the command byte ✓
```

With the committed code, the hook receives R0 = 0x02300050 instead of the command byte. It compares against 0x16 (never matches), writes 0x02300050 to COMM7, then does `SHLL2 R0` = 0x08C00140, uses this as a jump table offset → reads from an absurd table index → loads garbage as a handler address → JMP to garbage → crash or undefined behavior.

**Why menus worked:** Menu screens may use few or no commands through this dispatch path. The crash manifests when race mode sends frequent commands.

### Bug 2: Literal Pool Collision at $020480

```
; Committed (buggy):
$020480: $0230 $0050    ; Hook literal: 0x02300050 (overwrites original)

; Original ROM value:
$020480: $0600 $45CC    ; Init function: 0x060045CC (used by D011@$020438)
```

`D011` at $020438 during Master init loads from $020480. With the collision, it calls the hook (0x02300050) instead of the init function (0x060045CC). The hook at that point has no valid context (R0 is whatever init left it as) and the resulting dispatch is undefined.

### Bug 3: COMM7 Broadcast (The Race-Mode Crash)

Even with bugs 1 and 2 fixed, the hook's core design is flawed:

```asm
; For every command except 0x16:
mov.w   r0,@r2        ; COMM7 = command byte
```

Game command 0x27 is sent 21 times per frame. The Slave sees `COMM7 = 0x27`, dispatches to `cmd27_queue_drain`, which reads from uninitialized memory at `$02FFFB00`:

```
cmd27_queue_drain:
  mov.l   .L_queue_base,r8    ; R8 = 0x02FFFB00 (uninitialized!)
  mov.w   @r8,r0              ; write_idx = GARBAGE
  mov.w   @(r8+2),r1          ; read_idx = GARBAGE
  cmp/eq  r0,r1               ; Almost certainly not equal
  ; → enters drain loop, reads "entries" with wild pointers
  ; → processes garbage data, writes to random SH2 addresses
  ; → memory corruption → crash
```

---

## Correct Architecture for COMM7 Signaling

COMM7 is a **dedicated expansion ROM signal channel**, not a mirror of the game's command stream. The two namespaces are independent:

```
Game commands (COMM0/COMM1):     Expansion signals (COMM7):
  0x01 = init/frame               0x0001 = frame sync
  0x16 = vertex transform          0x0016 = parallel vertex transform
  0x22 = graphics transfer          (no equivalent)
  0x27 = pixel fill                0x0027 = queue drain (FUTURE)
  ...                              ...
```

**COMM7 should only be written by code that:**
1. Knows the Slave's signal protocol
2. Has prepared the data the signal consumer expects
3. Has verified the consumer (queue, parameter block, etc.) is initialized

Currently, only `shadow_path_wrapper` meets these criteria (writes COMM7 = 0x16 after preparing the parameter block at $2203E000).

**Future queue drain (B-003):** When the async queue is implemented, a dedicated 68K-side shim will write COMM7 = 0x27 only after enqueuing valid entries to the ring buffer. The Master dispatch hook is NOT the right place for this signal.

---

## Recommended Patch Configuration

| Patch | Location | Status | Action |
|-------|----------|--------|--------|
| #1 (Slave idle) | $0203CC | **KEEP** | Slave polls COMM7 between interrupts. Rendering via COMM1/interrupts unaffected. |
| #2 (Master dispatch) | $02046A | **REVERT** | Restore original dispatch code. Hook adds no value without COMM7 signaling. |
| #3 (func_021 trampoline) | $0234C8 | **KEEP** | Routes vertex transform through shadow_path_wrapper for parallel processing. |

With Patch #2 reverted:
- Original dispatch: `SHLL2 → table lookup → JSR handler → BRA loop`
- Cmd 0x16 handler calls func_021 → Patch #3 → `shadow_path_wrapper` → writes COMM7 = 0x16
- Slave sees COMM7 = 0x16, does parallel vertex transform
- No spurious COMM7 signals from other game commands
- No queue drain with uninitialized data

---

## Key Takeaways

1. **Separate namespaces must stay separate.** Game command bytes and expansion signal values occupy overlapping numeric ranges. Broadcasting one into the other's channel causes collisions.

2. **Don't activate consumers without producers.** `cmd27_queue_drain` exists as infrastructure for B-003. Triggering it before the queue is initialized processes garbage. Infrastructure should be dormant until its dependencies are ready.

3. **SH2 literal pools are positional landmines.** Multiple instructions can share a literal address. Overwriting a literal can silently redirect code elsewhere in the section. Always scan for `$Dnxx` references before placing data.

4. **The Slave's rendering is interrupt-driven.** The ROM idle loop at $0203CC is just a spin point between interrupts. Replacing it with useful polling (COMM7) doesn't break interrupt-driven rendering.

5. **Verify patches in gameplay, not just boot.** B-006 was declared "done" after boot testing. The crash only manifests in race mode when the full command stream (including cmd 0x27 × 21/frame) is active.
