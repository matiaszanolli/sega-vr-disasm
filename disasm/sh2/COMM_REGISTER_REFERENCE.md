# COMM Register Reference — Comprehensive Guide

**Purpose:** Definitive reference for COMM register layout, protocols, hazards, and code patterns. Read this before touching any 68K↔SH2 communication code.

**Last Updated:** February 2026

---

## 1. Address Map

All 8 COMM registers are **16-bit words** at **2-byte intervals**.

| Register | 68K Address | SH2 Address | Byte Offset¹ | Access |
|----------|------------|-------------|:------------:|--------|
| **COMM0** | `$A15120` | `$20004020` | 0 | Word / Byte |
| **COMM1** | `$A15122` | `$20004022` | 2 | Word / Byte |
| **COMM2** | `$A15124` | `$20004024` | 4 | Word |
| **COMM3** | `$A15126` | `$20004026` | 6 | Word |
| **COMM4** | `$A15128` | `$20004028` | 8 | Word |
| **COMM5** | `$A1512A` | `$2000402A` | 10 | Word |
| **COMM6** | `$A1512C` | `$2000402C` | 12 | Word / Byte |
| **COMM7** | `$A1512E` | `$2000402E` | 14 | Word |

¹ Offset from SH2 COMM base register R8 = `$20004020`.

### Multi-Width Access

| Width | 68K Example | SH2 Example | What It Reads |
|-------|------------|-------------|---------------|
| **Byte** | `tst.b $A15120` | `mov.b @r8,r0` | COMM0 high byte only |
| **Byte+1** | `move.b #$22,$A15121` | `mov.b @(1,r8),r0` | COMM0 low byte only |
| **Word** | `move.w d0,$A15124` | `mov.w @(4,r8),r0` | COMM2 (16-bit) |
| **Longword** | `move.l a0,$A15128` | `mov.l @(8,r8),r0` | COMM4 + COMM5 (32-bit) |

### Byte Aliases (68K)

Defined in `definitions.asm`:

```asm
COMM0_HI   equ $A15120   ; Command flag byte (68K→SH2: $01=trigger)
COMM0_LO   equ $A15121   ; Command code byte ($21/$22/$25/$27/$2F)
COMM1_HI   equ $A15122   ; COMM1 high byte
COMM1_LO   equ $A15123   ; COMM1 low byte (handshake bit)
```

---

## 2. Ownership Protocol

The hardware manual says: **simultaneous writes from both CPUs to the same register = undefined.** VRD avoids this with a set/clear convention:

| Register | Who Sets (writes non-zero) | Who Clears (writes zero) | Purpose |
|----------|---------------------------|--------------------------|---------|
| **COMM0_HI** | 68K (`#$01`) | SH2 (func_084 `clr.l $20004020`) | Command trigger |
| **COMM0_LO** | 68K (cmd code) | SH2 (func_084) | Command ID |
| **COMM1** | 68K (param/status) | SH2 (func_084) | Height param / status |
| **COMM2:3** | 68K (source ptr) | — (overwritten next cmd) | Pointer param |
| **COMM4:5** | 68K (dest ptr) | — (overwritten next cmd) | Pointer param |
| **COMM6** | 68K (`#$0101` ready) | SH2 (`#$0000` done) | Handshake flag |
| **COMM7** | 68K (`#$0027` doorbell) | Slave SH2 (`#$0000` ack) | Master→Slave signal |

**Rule:** 68K always sets, SH2 always clears. They never write the same register at the same time.

---

## 3. The Three Protocols

### 3a. Original: 3-Phase Blocking (cmd $22/$25/$2F/$21)

Used by the stock game for all SH2 commands. **This is the 60% bottleneck.**

```
68K                              Master SH2
 │                                    │
 ├─ Phase 1: Write A1→COMM4:5 ──────>│
 ├─ Write COMM6=$0101 ───────────────>│
 ├─ 🔴 POLL: wait COMM6==0 <─────────┤  ← WAIT #1 (handler reads params)
 │                                    │
 ├─ Phase 2: Write D0→COMM4,D1→COMM5 │
 ├─ Write COMM6=$0101 ───────────────>│
 ├─ 🔴 POLL: wait COMM6==0 <─────────┤  ← WAIT #2 (handler reads params)
 │                                    │
 ├─ Phase 3: Write A0→COMM4:5 ───────>│
 ├─ Write COMM6=$0101 ───────────────>│
 ├─ Write cmd→COMM0_LO ─────────────>│
 ├─ Write $01→COMM0_HI ─────────────>│  ← Trigger dispatch
 ├─ 🔴 POLL: wait COMM0_HI==0 <──────┤  ← WAIT #3 (handler done)
 │                                    │
```

**Why 3 phases?** Each phase writes to the same COMM4:5 registers with different values. The SH2 handler must read the current values before the 68K overwrites them with the next phase. COMM6 serves as the "I've read them" signal.

### 3b. B-004: Single-Shot (cmd $22 replacement)

Writes all params at once using separate COMM slots. **Eliminates 2 waits.**

```
68K                              Master SH2
 │                                    │
 ├─ 🔴 POLL: wait COMM0_HI==0 <──────┤  ← WAIT #1 (SH2 idle)
 ├─ D1→COMM1, A0→COMM2:3 ──────────>│
 ├─ A1→COMM4:5, D0→COMM6 ──────────>│  ← All params in one shot
 ├─ $22→COMM0_HI ───────────────────>│  ← Trigger
 ├─ RTS (returns immediately) ────────│
 │                                    ├─ Read COMM1,2:3,4:5,6 at once
 │                                    ├─ Block copy (word-by-word)
 │                                    ├─ func_084: clr.l COMM0 (done)
```

**COMM layout:**
| COMM | Content | 68K Register |
|------|---------|-------------|
| COMM1 | Height (rows) | D1 |
| COMM2:3 | Source pointer | A0 |
| COMM4:5 | Dest pointer | A1 |
| COMM6 | Width (bytes/row) | D0 |
| COMM7 | **UNTOUCHED** | — |

**Code:** [cmd22_single_shot.asm](expansion/cmd22_single_shot.asm) (SH2), [code_e200.asm](../sections/code_e200.asm):281 (68K)

### 3c. B-003: COMM7 Doorbell (cmd $27 — Slave direct)

Bypasses Master SH2 entirely. 68K writes params to COMM2-6, rings COMM7 doorbell, Slave processes.

```
68K                    Slave SH2 (SDRAM $020608)
 │                          │
 ├─ 🔴 wait COMM7==0 <─────┤  ← WAIT #1 (Slave read prev params)
 ├─ A0→COMM4:5 ───────────>│
 ├─ D0→COMM2, D1→COMM3 ──>│
 ├─ D2→COMM6 ─────────────>│
 ├─ $0027→COMM7 ──────────>│  ← Doorbell
 ├─ RTS (fire-and-forget) ──│
 │                          ├─ Read COMM4:5,2,3,6
 │                          ├─ Clear COMM7=0 (ack)
 │                          ├─ OR data_ptr with $20000000 (cache-through)
 │                          ├─ Process pixel region
 │                          └─ BRA check_comm7 (re-entrant)
```

**COMM layout:**
| COMM | Content | 68K Register |
|------|---------|-------------|
| COMM0 | Not used | — |
| COMM1 | Not used | — |
| COMM2 | Width | D0 |
| COMM3 | Height | D1 |
| COMM4:5 | Data pointer | A0 |
| COMM6 | Add value | D2 |
| COMM7 | Doorbell ($0027) / Ack ($0000) | — |

**Code:** [inline_slave_drain.asm](expansion/inline_slave_drain.asm) (SH2), [code_e200.asm](../sections/code_e200.asm):328 (68K)

---

## 4. SH2 Assembly Patterns

### Base Register Convention

The Master SH2 dispatch loop sets `R8 = $20004020` (COMM base). All expansion ROM handlers receive this in R8.

### Reading Individual COMM Registers

```asm
/* Word access (16-bit) */
mov.w   @(2,r8),r0      /* R0 = COMM1  (byte offset 2)  */
mov.w   @(4,r8),r0      /* R0 = COMM2  (byte offset 4)  */
mov.w   @(12,r8),r0     /* R0 = COMM6  (byte offset 12) */
mov.w   @(14,r8),r0     /* R0 = COMM7  (byte offset 14) */

/* Longword access (32-bit, reads two consecutive COMM regs) */
mov.l   @(4,r8),r0      /* R0 = COMM2:3 (byte offset 4)  */
mov.l   @(8,r8),r0      /* R0 = COMM4:5 (byte offset 8)  */

/* Byte access */
mov.b   @r8,r0           /* R0 = COMM0 high byte (command flag) */
mov.b   @(1,r8),r0       /* R0 = COMM0 low byte (command code) */
```

### Writing COMM Registers

```asm
/* Clear COMM7 (Slave ack) */
mov     #0,r0
mov.w   r0,@(14,r8)     /* COMM7 = 0 */

/* Or with direct address: */
mov.l   .L_comm7,r1     /* R1 = $2000402E */
mov.w   r0,@r1          /* COMM7 = 0 */
```

### Polling COMM7 (Slave idle loop)

```asm
mov.l   .L_comm7,r8     /* R8 = $2000402E */
.poll:
    mov.w   @r8,r0       /* Read COMM7 */
    tst     r0,r0        /* == 0? */
    bt      .poll        /* Yes: keep waiting */
/* COMM7 != 0 — work arrived */
```

### Complete Single-Shot Read Pattern (cmd $22)

```asm
/* R8 = $20004020 (COMM base, from dispatch loop) */
mov.w   @(2,r8),r0      /* COMM1 = height */
mov     r0,r2
mov.w   @(12,r8),r0     /* COMM6 = width */
mov     r0,r1
mov.l   @(4,r8),r0      /* COMM2:3 = source ptr */
mov     r0,r3
mov.l   @(8,r8),r0      /* COMM4:5 = dest ptr */
/* All params now in R0-R3 — proceed */
```

---

## 5. 68K Assembly Patterns

### Byte-Level Polling (Most Common)

```asm
.wait:
    tst.b   COMM0_HI      ; $4A39 $00A1 $5120 — Test command flag
    bne.s   .wait          ; $66F8              — Loop until SH2 clears it

; OR: wait for Slave ack
.wait_slave:
    tst.w   COMM7          ; $4A79 $00A1 $512E — Test doorbell
    bne.s   .wait_slave    ; $66F8              — Loop until Slave clears it
```

### Writing All Params (Single-Shot Pattern)

```asm
    move.w  d1,COMM1       ; $33C1 $00A1 $5122 — Height
    move.l  a0,COMM2       ; $23C8 $00A1 $5124 — Source → COMM2:3 (longword)
    move.l  a1,COMM4       ; $23C9 $00A1 $5128 — Dest → COMM4:5 (longword)
    move.w  d0,COMM6       ; $33C0 $00A1 $512C — Width
    move.b  #CMD_DIRECT,COMM0_HI  ; Trigger dispatch
```

### COMM7 Doorbell (Slave Direct)

```asm
    move.l  a0,COMM4       ; Data pointer → COMM4:5
    move.w  d0,COMM2       ; Width → COMM2
    move.w  d1,COMM3       ; Height → COMM3
    move.w  d2,COMM6       ; Add value → COMM6
    move.w  #$0027,COMM7   ; Ring doorbell
```

### Handshake Bit Check (COMM1_LO)

```asm
    btst    #0,COMM1_LO    ; Check SH2 handshake bit
    beq.s   .wait          ; Loop until set
    bclr    #0,COMM1_LO    ; Clear handshake bit
```

---

## 6. Hardware Hazards

### Race Conditions

| Hazard | Cause | Prevention |
|--------|-------|------------|
| **Undefined register value** | Both CPUs write same COMM reg simultaneously | Partition by ownership (see §2) |
| **Stale COMM read** | SH2 reads COMM via cache hit | Always use cache-through (`$20004020`, not `$00004020`) for system registers |
| **Parameter overwrite** | 68K writes next cmd params before SH2 reads current | Handshake: wait for ack before next write |

### COMM7 Namespace Collision (Proven Crash — B-006)

**DO NOT** broadcast raw game command bytes to COMM7. Game commands ($01, $16, $27, ...) overlap with expansion ROM signal values:

| Value | Game Meaning | Expansion Meaning | Result |
|-------|-------------|-------------------|--------|
| `$0001` | Frame init cmd | Frame sync signal | Wrong behavior |
| `$0016` | Vertex transform | Vertex transform | Coincidence (skipped by design) |
| `$0027` | Pixel fill (21x/frame) | Queue drain signal | **CRASH** |

The Slave interprets COMM7 as expansion signals. Writing game cmd `$27` to COMM7 triggers `cmd27_queue_drain` with uninitialized data — garbage pointers, random pixel writes, crash with stuck engine sound.

**Rules:**
1. Only write COMM7 from code that knows the Slave's signal protocol
2. Never write COMM7 from a generic dispatch hook
3. Currently, only `sh2_cmd_27` (68K) and `shadow_path_wrapper` (Master SH2) write COMM7

### SH2 Cannot Access 68K Work RAM

The SH2 memory map has a gap between SDRAM ($0203FFFF) and Frame Buffer ($04000000). Addresses like `$02FFFB00` and `$22FFFB00` are **unmapped** — reads return garbage, writes go nowhere.

**Shared memory options (exhaustive list):**
1. **COMM registers** — 16 bytes, always accessible, no caching issues
2. **SDRAM** — 256KB ($02000000-$0203FFFF), both CPUs can read/write
3. **Frame Buffer** — 128KB per bank, access controlled by FM bit

### Cache-Through for Shared Data

SH2 writes to framebuffer addresses must use **cache-through** (`$24xxxxxx`) not cached (`$04xxxxxx`). Otherwise writes stay in SH2 data cache and never reach DRAM — the display controller reads from DRAM, so modifications are invisible.

```asm
/* Convert $04xxxxxx → $24xxxxxx (OR with $20000000) */
mov     #0x20,r0
shll16  r0          /* $00200000 */
shll8   r0          /* $20000000 */
or      r0,r3       /* data_ptr now cache-through */
```

---

## 7. SH2 Assembler Gotchas

### Byte Offsets, Not Scaled

`sh-elf-as` uses **byte offsets** in the assembly syntax. The opcode encodes a scaled displacement internally, but you write the actual byte distance:

```asm
mov.w @(2,r8),r0    /* ✅ Byte offset 2 → COMM1 */
mov.w @(1,r8),r0    /* ❌ Error: 1 is not a multiple of 2 */

mov.l @(4,r8),r0    /* ✅ Byte offset 4 → COMM2:3 */
mov.l @(1,r8),r0    /* ❌ Error: 1 is not a multiple of 4 */
```

### Alignment Directives

`.align N` = 2^N bytes (power-of-two):

| Directive | Alignment | Use For |
|-----------|-----------|---------|
| `.align 1` | 2 bytes | `.word` literal pools |
| `.align 2` | 4 bytes | `.long` literal pools, code sections |
| `.align 4` | **16 bytes** (!) | Almost never needed — causes bloat |

### Offset Quick Reference

| Target | Byte Offset | MOV.W | MOV.L |
|--------|:-----------:|-------|-------|
| COMM0 | 0 | `@r8` or `@(0,r8)` | — |
| COMM1 | 2 | `@(2,r8)` | — |
| COMM2 | 4 | `@(4,r8)` | — |
| COMM2:3 | 4 | — | `@(4,r8)` |
| COMM4 | 8 | `@(8,r8)` | — |
| COMM4:5 | 8 | — | `@(8,r8)` |
| COMM6 | 12 | `@(12,r8)` | — |
| COMM7 | 14 | `@(14,r8)` | — |

---

## 8. Performance

### 68K Cycle Budget

68K runs at 100% utilization (~128,000 cycles/frame). COMM polling is the dominant cost.

| Operation | Cycles/Call | Calls/Frame | Total/Frame | % Budget |
|-----------|:----------:|:-----------:|:-----------:|:--------:|
| Original 3-phase cmd $22 | ~300 | 14 | ~4,200 | 3.3% |
| Original cmd $27 (via Master) | ~250 | 21 | ~5,250 | 4.1% |
| **All original COMM polling** | — | 35+ | **~77,000** | **60%** |
| B-004 single-shot cmd $22 | ~170 | 14 | ~2,380 | 1.9% |
| B-003 COMM7 doorbell cmd $27 | ~50 | 21 | ~1,050 | 0.8% |

### Savings Summary

| Optimization | Savings/Frame | Description |
|-------------|:------------:|-------------|
| B-004 (single-shot) | ~1,792 cycles (1.4%) | Eliminates 2 of 3 COMM6 waits for cmd $22 |
| B-003 (COMM7 doorbell) | ~4,200 cycles (3.3%) | Bypasses Master entirely for cmd $27 |
| **Combined** | **~6,000 cycles (4.7%)** | — |

The remaining ~55% COMM overhead comes from other commands ($25, $2F, $21, $2A, $2D) and COMM0_HI polling throughout the frame. These are future optimization targets.

---

## 9. Boot Synchronization

During boot, COMM registers carry magic values (not commands):

```
68K: Wait for "M_OK" ($4D5F4F4B) in COMM0:1 (Master ready)
68K: Wait for "S_OK" ($535F4F4B) in COMM4:5 (Slave ready)
68K: Clear COMM0 to 0 (start Master)
68K: Clear COMM4 to 0 (start Slave)
68K: Set initflug = "INIT" ($494E4954)

Master SH2: Write "M_OK" to COMM0:1
Master SH2: Wait for COMM0 == 0
Master SH2: Wait for "SLAV" ($534C4156) from Slave

Slave SH2: Write "SLAV" to COMM8(!)
Slave SH2: Write "S_OK" to COMM4:5
Slave SH2: Wait for COMM4 == 0
Slave SH2: Enter command loop
```

**After boot:** COMM0-7 transition to the command protocol described above.

---

## 10. Checklist for New COMM Code

Before writing or modifying COMM register code, verify:

- [ ] **Ownership:** Does your code only WRITE registers that its CPU "owns"? (see §2)
- [ ] **No simultaneous writes:** Is there any scenario where both CPUs write the same register?
- [ ] **COMM7 safety:** If writing COMM7, does the Slave understand the value you're writing? (see §6)
- [ ] **SH2 memory access:** Are you accessing COMM at `$20004020` (cache-through), not from unmapped regions?
- [ ] **Parameter lifetime:** Will all COMM params survive until the reader copies them? (handshake/ack before overwriting)
- [ ] **Byte offsets:** SH2 `MOV @(disp,Rm)` uses byte offsets — verified against the table in §7?
- [ ] **Literal pool alignment:** Using `.align 2` (4-byte) before `.long`, `.align 1` (2-byte) before `.word`?
- [ ] **Cache-through for framebuffer:** SH2 writes to `$24xxxxxx`, not `$04xxxxxx`?
- [ ] **func_084 completion:** If adding a Master SH2 handler, does it call func_084 (`$060043F0`) to clear COMM0+COMM1?
- [ ] **Build + test:** `make clean && make all`, then test in PicoDrive (menus AND race mode)?

---

## 11. File Index

### 68K COMM Code

| File | Function | Registers Used |
|------|----------|---------------|
| [mars_comm_write.asm](../modules/68k/sh2/mars_comm_write.asm) | Spin-wait handshake write | COMM0, COMM1 |
| [code_e200.asm](../sections/code_e200.asm):281 | `sh2_send_cmd` (B-004 single-shot) | COMM0-6 |
| [code_e200.asm](../sections/code_e200.asm):328 | `sh2_cmd_27` (B-003 doorbell) | COMM2-7 |
| [comm_transfer_setup_a.asm](../modules/68k/sh2/comm_transfer_setup_a.asm) | World coord transfer | COMM0 |
| [comm_transfer_block.asm](../modules/68k/sh2/comm_transfer_block.asm) | FIFO block transfer | COMM0, COMM1 |
| [sync_wait_reset.asm](../modules/68k/sh2/sync_wait_reset.asm) | Wait + state reset | COMM0, COMM1 |
| [adapter_init.asm](../modules/68k/boot/adapter_init.asm) | Hardware init | COMM6 |
| [sh2_handshake_state_advance.asm](../modules/68k/game/scene/sh2_handshake_state_advance.asm) | Game-level sync | COMM0, COMM1 |
| [v_int_comm1_signal_handler.asm](../modules/68k/game/scene/v_int_comm1_signal_handler.asm) | V-INT response | COMM1 |

### SH2 COMM Code

| File | Function | Registers Used |
|------|----------|---------------|
| [cmd22_single_shot.asm](expansion/cmd22_single_shot.asm) | B-004 handler | Reads COMM1,2:3,4:5,6 |
| [inline_slave_drain.asm](expansion/inline_slave_drain.asm) | B-003 Slave handler | Reads COMM2-6, writes COMM7 |
| [master_dispatch_hook.asm](expansion/master_dispatch_hook.asm) | Command dispatch | Writes COMM7 |
| [general_queue_drain.asm](expansion/general_queue_drain.asm) | Async replay (dormant) | COMM0,4,6 |
| [slave_comm7_idle_check.asm](expansion/slave_comm7_idle_check.asm) | COMM7 idle handler | COMM7 |

### Definitions

| File | What It Defines |
|------|----------------|
| [definitions.asm](../modules/shared/definitions.asm) | All COMM equ labels (68K addresses) |

---

## 12. Quick Decision Tree

```
Need to send data from 68K to SH2?
│
├─ Is it cmd $22 (2D block copy)?
│   └─ Use B-004 single-shot: write COMM1-6, trigger COMM0_HI
│
├─ Is it cmd $27 (pixel region fill)?
│   └─ Use B-003 doorbell: write COMM2-6, ring COMM7=$0027
│
├─ Is it cmd $25/$2F/$21?
│   └─ Currently uses original 3-phase protocol (future optimization target)
│
├─ Is it cmd $2A (world coordinates)?
│   └─ Uses comm_transfer_setup functions (special COMM buffer protocol)
│
├─ Is it cmd $2D (FIFO block)?
│   └─ Uses comm_transfer_block (DREQ FIFO, different mechanism)
│
└─ Adding a new command?
    └─ Follow the single-shot pattern (B-004):
       1. Assign unique COMM0_LO code
       2. Write all params to COMM1-6 at once
       3. Add SH2 handler in expansion ROM
       4. Redirect jump table entry
       5. Handler calls func_084 when done
```
