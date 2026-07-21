# Slave SH2 Integration Guide

> **HARDWARE-MAP CORRECTION (2026-07-21):** This is a historical, inactive design.
> Its live literal `$2203E000` is cache-through cartridge ROM, not SDRAM, so the
> parameter block never existed as described. The intended SH2-shared address would
> be `$2603E000`, but the whole path must be revalidated before activation.

> **📋 STATUS UPDATE (2026-01-25):** Infrastructure complete, ready for activation!
> - ✅ `vertex_transform_optimized` ready at $300100 (96 bytes, coord_transform inlined)
> - ✅ `slave_work_wrapper` ready at $300200 (COMM7 polling loop)
> - ⚠ Parameter block literal 0x2203E000 is invalid ROM alias (intended SDRAM: 0x2603E000)
> - ⏳ **NOT YET ACTIVATED** - Requires trampoline connection + Slave PC redirect
> - Current state: Tagged as `v4.0-baseline` - ROM identical to original
>
> **Designed Architecture** (when activated):
> ```
> Game calls vertex_transform → Trampoline captures R14/R7/R8/R5 → COMM7=0x16
>                     → Master returns immediately (no work done)
>                     → Slave picks up work, executes vertex_transform_optimized
>                     → Both CPUs running in parallel! (15-20% expected speedup)
> ```

## Overview

This guide documents the Slave SH2 integration using the 4MB expansion ROM.

## Infrastructure Design (v4.0 Baseline)

### Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        PARALLEL PROCESSING FLOW                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────┐    ┌─────────────────┐    ┌─────────────────────────┐ │
│  │   68K CPU   │───▶│  Master SH2     │    │     Slave SH2           │ │
│  │             │    │                 │    │                         │ │
│  │ Game Logic  │    │ 1. Dispatch cmd │    │ 1. Poll COMM7           │ │
│  │ Send cmds   │    │ 2. Call handler │    │ 2. Detect 0x16          │ │
│  └─────────────┘    │ 3. Handler calls│    │ 3. Read params from     │ │
│                     │    vertex_transform     │    │    0x2203E000           │ │
│                     │ 4. Trampoline:  │    │ 4. Execute              │ │
│                     │    - Save params│───▶│    vertex_transform_optimized   │ │
│                     │    - COMM7=0x16 │    │ 5. COMM5 += 101         │ │
│                     │    - RTS (done!)│    │ 6. Clear COMM7          │ │
│                     │ 5. Continue...  │    │ 7. Back to polling      │ │
│                     └─────────────────┘    └─────────────────────────┘ │
│                              │                        │                 │
│                              └────────────────────────┘                 │
│                                 PARALLEL EXECUTION                      │
└─────────────────────────────────────────────────────────────────────────┘
```

### Key Components

| Component | Location | Size | Purpose |
|-----------|----------|------|---------|
| `master_dispatch_hook` | $300050 | 44B | Dispatch commands, skip COMM7 for 0x16 |
| `vertex_transform_optimized` | $300100 | 96B | Optimized vertex transform (coord_transform inlined) |
| `slave_work_wrapper` | $300200 | 76B | Slave main loop, command dispatch |
| `slave_test_func` | $300280 | 44B | Read params, call vertex_transform_optimized |
| `vertex_transform trampoline` | $0234C8 | 36B | Capture real params, signal Slave |

### Parameter Block (Shared Memory)

Historically assigned to invalid ROM alias `0x2203E000`; intended cache-through SDRAM
would be `0x2603E000` (accessible by both SH2s):

| Offset | Size | Register | Purpose |
|--------|------|----------|---------|
| +0x00 | 4B | R14 | RenderingContext pointer |
| +0x04 | 4B | R7 | Loop counter (polygon count) |
| +0x08 | 4B | R8 | Data pointer |
| +0x0C | 4B | R5 | Output pointer |

## Detailed Flow

### 1. Master Dispatch Hook ($300050)

Intercepts all 68K→SH2 commands. For cmd 0x16 (vertex transform), skips COMM7 write
so the trampoline can signal AFTER params are ready.

```asm
master_dispatch_hook:
    sts.l   pr,@-r15          ; Save return address
    mov     #$16,r1           ; Vertex transform code
    cmp/eq  r1,r0             ; Is this cmd 0x16?
    bt      .do_dispatch      ; Skip COMM7 write if 0x16
    mov.l   @(20,PC),r2       ; Load COMM7 address
    mov.w   r0,@r2            ; COMM7 = cmd (for other commands)
.do_dispatch:
    shll2   r0                ; cmd * 4
    mov.l   @(20,PC),r1       ; Load jump table
    mov.l   @(r0,r1),r0       ; Lookup handler
    jsr     @r0               ; Call command handler
    nop
    lds.l   @r15+,pr          ; Restore PR
    mov.l   @(12,PC),r0       ; Load loop address
    jmp     @r0               ; Return to polling
    nop
```

**Bytecode:** `4F22 E116 3010 8901 D205 2021 4008 D105 001E 400B 0009 4F26 D003 402B 0009 0009`

### 2. vertex_transform Trampoline ($0234C8)

Replaces original vertex_transform. Captures **real** parameters from registers and signals Slave.
Master returns immediately - **does not execute vertex_transform itself**.

```asm
; vertex_transform SLAVE OFFLOAD TRAMPOLINE
    mov.l   @(16,PC),r0       ; Load param block (0x2203E000)
    mov.l   r14,@r0           ; Save R14 (context pointer)
    mov.l   r7,@(4,r0)        ; Save R7 (loop counter)
    mov.l   r8,@(8,r0)        ; Save R8 (data pointer)
    mov.l   r5,@(12,r0)       ; Save R5 (output pointer)
    mov.l   @(12,PC),r0       ; Load COMM7 address
    mov     #$16,r1           ; Vertex transform signal
    mov.w   r1,@r0            ; COMM7 = 0x16 (signal Slave)
    rts                       ; Return to caller (Slave does work!)
    nop
; Literals:
    .long   0x2203E000        ; param block
    .long   0x2000402E        ; COMM7
```

**Bytecode:** `D004 20E2 1071 1082 1053 D003 E116 2011 000B 0009`

### 3. Slave Work Wrapper ($300200)

Polls COMM7, dispatches based on command value:

```asm
slave_work_wrapper:
    mov.l   @(56,PC),r1       ; Load COMM7 address
.poll_loop:
    mov.w   @r1,r0            ; Read COMM7
    tst     r0,r0             ; Zero?
    bt      .poll_loop        ; Keep polling

    mov     #1,r2             ; Frame sync code
    cmp/eq  r2,r0
    bt      .frame_sync
    mov     #$16,r2           ; Vertex transform code
    cmp/eq  r2,r0
    bt      .vertex_transform

.clear_loop:
    mov     #0,r0
    mov.w   r0,@r1            ; Clear COMM7
    bra     .poll_loop
    nop

.frame_sync:
    ; Increment COMM4
    ...
    bra     .clear_loop
    nop

.vertex_transform:
    mov.l   @(28,PC),r3       ; Load slave_test_func addr
    jsr     @r3               ; Call it
    nop
    mov.l   @(20,PC),r2       ; Load COMM5 addr
    mov.w   @r2,r0
    add     #1,r0
    mov.w   r0,@r2            ; COMM5 += 1
    bra     .clear_loop
    nop
```

### 4. Slave Test Function ($300280)

Reads parameters from shared memory and calls vertex_transform_optimized:

```asm
slave_test_func:
    sts.l   pr,@-r15          ; Save PR
    mov.l   @(28,PC),r0       ; Load param block (0x2203E000)
    mov.l   @r0,r14           ; R14 = context pointer
    mov.l   @(4,r0),r7        ; R7 = loop counter
    mov.l   @(8,r0),r8        ; R8 = data pointer
    mov.l   @(12,r0),r5       ; R5 = output pointer
    mov.l   @(20,PC),r0       ; Load vertex_transform_optimized addr
    jsr     @r0               ; Call it with real params!
    nop
    mov.l   @(20,PC),r0       ; Load COMM5 addr
    mov.w   @r0,r1
    add     #100,r1           ; Add 100 to show completion
    mov.w   r1,@r0
    lds.l   @r15+,pr          ; Restore PR
    rts
    nop
```

## COMM Register Protocol

| Register | Address | Purpose | Status |
|----------|---------|---------|--------|
| COMM4 | `0x20004028` | Frame sync counter | ✅ In use |
| COMM5 | `0x2000402A` | Vertex transform counter | ✅ In use (+101 per call) |
| COMM6 | `0x2000402C` | 68K-Master handshake | ⚠️ Used by game |
| COMM7 | `0x2000402E` | Master→Slave signal | ✅ In use |

### Signal Protocol

| COMM7 Value | Meaning | Action |
|-------------|---------|--------|
| `0x0000` | Idle | Slave polls |
| `0x0001` | Frame sync | Slave increments COMM4 |
| `0x0016` | Vertex transform | Slave calls vertex_transform_optimized |

## Expansion ROM Layout

| Address | Size | Function |
|---------|------|----------|
| $300000 | 40B | Padding |
| $300028 | 22B | `handler_frame_sync` |
| $30003E | 18B | Padding |
| $300050 | 44B | `master_dispatch_hook` |
| $30007C | 132B | Padding |
| $300100 | 96B | `vertex_transform_optimized` |
| $300160 | 160B | Padding |
| $300200 | 76B | `slave_work_wrapper` |
| $30024C | 52B | Padding |
| $300280 | 44B | `slave_test_func` |

## Testing

### Verify Build

```bash
make clean && make all

# Verify master_dispatch_hook (44 bytes)
xxd -s 0x300050 -l 44 build/vr_rebuild.32x
# Expected: 4f22 e116 3010 8901 d205 2021 4008 d105 ...

# Verify vertex_transform trampoline (36 bytes)
xxd -s 0x0234C8 -l 36 build/vr_rebuild.32x
# Expected: d004 20e2 1071 1082 1053 d003 e116 2011 ...

# Verify slave_test_func (44 bytes)
xxd -s 0x300280 -l 44 build/vr_rebuild.32x
# Expected: 4f22 d007 6e02 5701 5802 5503 d005 400b ...

# Boot in PicoDrive
picodrive build/vr_rebuild.32x
```

### Verify Operation

Using emulator memory view:
1. **COMM7** at `0x2000402E`: Toggles to 0x16 when vertex_transform called
2. **COMM5** at `0x2000402A`: Increments by 101 per vertex transform
3. **Param block** at `0x2203E000`: Contains real R14/R7/R8/R5 values

## Implementation History

### Phase 1: Slave Activation (2026-01-24)
- Slave idle loop redirected to expansion ROM
- Continuous COMM4 increment ("proof of life")

### Phase 2: Command-Driven Dispatch (2026-01-24)
- Master dispatch hook writes COMM7=cmd
- Slave dispatches based on COMM7 value
- Placeholder COMM5 increment for cmd 0x16

### Phase 3: Parameter Passing (2026-01-25)
- Shared memory parameter block at 0x2203E000
- Master writes dummy params, Slave reads them
- vertex_transform_optimized called with R7=0 (safe test)

### Phase 4: Infrastructure Complete (2026-01-25) 📋 BASELINE
- vertex_transform trampoline designed (not yet active)
- Parameter capture design complete (cache-through SDRAM at 0x2203E000)
- vertex_transform_optimized ready at $300100 with coord_transform inlined (96 bytes)
- slave_work_wrapper ready at $300200 (COMM7 polling loop)
- **INFRASTRUCTURE READY** - Not yet connected, awaiting activation experiment

## Implementation Steps (For Activation)

**Current state**: v4.0-baseline (infrastructure ready, not connected)

1. ✅ **Infrastructure design** - All code ready in expansion ROM
2. ✅ **Parameter block design** - Cache-through SDRAM at 0x2203E000
3. ⏳ **Activation required**:
   - Add trampoline at vertex_transform entry ($0234C8)
   - Redirect Slave PC to $02300200 (slave_work_wrapper)
   - Rebuild and test with metrics
4. **Performance Testing**: Measure actual FPS improvement vs baseline
5. **Synchronization**: Ensure Slave completes before results needed
6. **Load Balancing**: Consider splitting polygon workload between CPUs

## Technical Notes

- ROM addresses: `$XXXXXX` format (file offset)
- SH2 cartridge-ROM addresses: `0x02XXXXXX` (cached) or `0x22XXXXXX` (cache-through)
- COMM registers: `0x20004XXX` from SH2 perspective
- Historical parameter literal: `0x2203E000` (**invalid ROM alias**); intended SDRAM is `0x2603E000`
- **Cache coherency**: shared SDRAM uses region-specific cache-through `0x26XXXXXX`
  - 0x06000000-0x0603FFFF = SDRAM (cached, per-CPU cache)
  - 0x26000000-0x2603FFFF = SDRAM (cache-through, coherent)

## Source Files

- [expansion_300000.asm](../../disasm/sections/expansion_300000.asm) - Expansion ROM
- [code_22200.asm](../../disasm/sections/code_22200.asm) - vertex_transform trampoline
- [code_20200.asm](../../disasm/sections/code_20200.asm) - Slave entry point
