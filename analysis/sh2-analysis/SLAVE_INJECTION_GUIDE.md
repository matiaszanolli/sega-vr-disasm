# Slave SH2 Work Check Injection Guide

## Overview

This guide documents safe injection points for activating the Slave SH2 CPU with work checking capabilities.

## Expansion ROM Functions

All work check functions are located in expansion ROM at `$300000-$30FFFF` (SH2 addresses `0x06300000-0x0630FFFF`):

| Function | ROM Address | SH2 Address | Size | Purpose |
|----------|-------------|-------------|------|---------|
| `slave_work_check` | `$300000` | `0x06300000` | 28 bytes | Standalone work check (COMM4→COMM2) |
| `master_dispatch_work` | `$300028` | `0x06300028` | 16 bytes | Master signals work via COMM4 |
| `slave_idle_wrapper` | `$300038` | `0x06300038` | 48 bytes | Complete idle loop replacement |

## Available Code Gaps in Slave ROM

Identified NOP/padding regions suitable for code injection:

| Address Range | Size | Location | Best Use |
|---------------|------|----------|----------|
| `$020466-$020476` | 18 bytes | Near loop at $020460 | JSR helper (12 bytes) |
| `$0206B6-$0206BE` | 10 bytes | Mid-section | BSR + address (8 bytes) |
| `$0209D8-$0209E2` | 12 bytes | Data area | JSR helper |
| `$0209F8-$020A02` | 12 bytes | Data area | JSR helper |
| `$020A18-$020A22` | 12 bytes | Data area | JSR helper |
| `$020A38-$020A42` | 12 bytes | Data area | JSR helper |
| `$020A58-$020A62` | 12 bytes | Data area | JSR helper |
| `$020A78-$020A82` | 12 bytes | Data area | JSR helper |

**Total: 100 bytes** of safe, unused space in original Slave ROM.

## Injection Strategies

### Strategy 1: Idle Loop Wrapper (RECOMMENDED)

**Concept**: Redirect Slave execution to expansion ROM wrapper that calls original VDP wait + checks for work.

**Advantages**:
- Non-invasive: Original VDP wait function unchanged
- Clean separation: All new code in expansion ROM
- Easy to debug: Clear execution path
- Minimal ROM modifications: Single redirection point

**Implementation**:

The `slave_idle_wrapper` at `0x06300038` provides a complete replacement idle loop:

```asm
slave_idle_wrapper:
    ; Load function addresses once
    mov.l   vdp_wait_addr, r10    ; R10 = original VDP wait (0x0602050C)
    mov.l   comm4_addr, r11       ; R11 = COMM4 (0x20004028)
    mov.l   comm2_addr, r12       ; R12 = COMM2 (0x20004024)

idle_loop:
    jsr     @r10                  ; Call original VDP wait
    nop

    mov.w   @r11, r1              ; R1 = COMM4 (work signal)
    tst     r1, r1                ; Check if work available
    bt      idle_loop             ; No work, loop again

    mov.w   @r12, r2              ; R2 = COMM2 (counter)
    add     #1, r2                ; Increment
    mov.w   r2, @r12              ; Write back

    mov     #0, r1
    mov.w   r1, @r11              ; Clear work flag

    bra     idle_loop             ; Continue
    nop
```

**Redirection Points**:

Find where Slave first enters its main loop and redirect to `0x06300038`.

Candidate locations:
1. **$020466** (18-byte gap): Place JSR helper to jump to wrapper
2. **Slave entry point** (TBD): Modify initial execution to start wrapper

### Strategy 2: Inline Work Check

**Concept**: Insert work check directly into existing code gaps.

**Advantages**:
- Faster (no JSR overhead)
- Self-contained

**Disadvantages**:
- Limited space (12 bytes max per gap)
- Must fit complete logic inline
- Harder to maintain

**Example** (12 bytes, fits in any gap):
```asm
; At injection point:
    mov.l   func_addr, r0    ; 4 bytes
    jsr     @r0              ; 2 bytes
    nop                      ; 2 bytes
func_addr:
    .long   0x06300000       ; 4 bytes
```

## Execution Flow Analysis

Based on emulator traces, Slave execution path:

```
1. Boot:         PC=0x00000204 (init)
2. Init:         PC=0x0000020A → PC=0x00000218
3. COMM setup:   Writes 0x535F to COMM2
4. Main loop:    PC=0x06000512-0x06000516 (VDP polling)
   └─ Tight loop: TST/TST/DT/BF cycle
5. Status:       99.97% idle in VDP wait
```

**Key Finding**: Slave spends nearly all time in VDP wait loop at `0x0602050C-0x0602051A`.

## Implementation Checklist

- [ ] Choose injection strategy (Wrapper recommended)
- [ ] Identify safe redirection point in Slave initialization
- [ ] Create JSR helper in gap (e.g., `$020466-$020476`)
- [ ] Build and test ROM
- [ ] Verify COMM2 increments when Master signals COMM4
- [ ] Implement actual work dispatch in Master rendering loop
- [ ] Test Master-Slave work handoff

## Master Integration

To signal work from Master rendering loop (ROM ~`$023062`):

```asm
; At end of Master rendering cycle:
    mov.l   dispatch_addr, r0
    jsr     @r0               ; Call master_dispatch_work
    nop

    ; ... original epilogue ...

dispatch_addr:
    .long   0x06300028        ; master_dispatch_work
```

## Testing Protocol

1. **Phase 1**: Verify wrapper executes
   - Check Slave PC reaches `0x06300038`
   - Confirm original VDP wait still called

2. **Phase 2**: Verify work detection
   - Master writes `1` to COMM4 (`0x20004028`)
   - Slave increments COMM2 (`0x20004024`)
   - COMM4 cleared after processing

3. **Phase 3**: Full integration
   - Master signals work at frame boundaries
   - Slave processes work assignments
   - Verify FPS improvement

## Notes

- All addresses shown as ROM offsets; add `0x02000000` for SH2 cached or `0x06000000` for uncached
- COMM register addresses are from SH2 perspective (`0x20004000+`)
- Preserve register state if injecting into active code paths
- Test with PicoDrive DRC disabled for initial validation

## Source Files

- `disasm/sh2_slave_work_check.asm` - Standalone work check
- `disasm/sh2_slave_idle_wrapper.asm` - Complete wrapper implementation
- `disasm/sh2_master_work_dispatch.asm` - Master signaling
- `disasm/sections/expansion_300000.asm` - Expansion ROM layout
- `tools/find_slave_gaps.py` - Gap finder utility
