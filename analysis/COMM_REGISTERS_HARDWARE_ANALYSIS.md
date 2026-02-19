# COMM Registers — Hardware Analysis & Deep Dive

**Purpose:** Definitive hardware-level reference for 32X Communication Port registers, cross-referenced from all official Sega documentation. Read this before designing any new COMM protocol.

**Sources:**
- [32x-hardware-manual.md](../docs/32x-hardware-manual.md) — Primary specification (Sections 3.2, 3.3, 4.1)
- [32x-hardware-manual-supplement-2.md](../docs/32x-hardware-manual-supplement-2.md) — Errata, sample code, equates
- [sh7604-hardware-manual.md](../docs/sh7604-hardware-manual.md) — SH2 CPU datasheet (bus, cache, write buffer)
- [32x-technical-info-attachment-1.md](../docs/32x-technical-info-attachment-1.md) — Boot ROM code samples
- [development-guide.md](../docs/development-guide.md) — Quick reference

**See also:**
- [COMM_REGISTER_REFERENCE.md](../disasm/sh2/COMM_REGISTER_REFERENCE.md) — VRD-specific code patterns and protocols
- [68K_SH2_COMMUNICATION.md](68K_SH2_COMMUNICATION.md) — Protocol diagrams and game usage
- [architecture/MASTER_SH2_DISPATCH_ANALYSIS.md](architecture/MASTER_SH2_DISPATCH_ANALYSIS.md) — Dispatch loop internals

**Last Updated:** February 2026

---

## 1. Physical Specification

The 32X adapter ASIC contains **8 x 16-bit bidirectional word registers** called the Communication Port. They sit between the 68K bus and the SH2 bus, accessible from both sides with no access restrictions.

### Address Map

| Register | 68K Address | SH2 Address | Byte Offset from R8 |
|----------|:----------:|:-----------:|:--------------------:|
| COMM0 | `$A15120` | `$20004020` | 0 |
| COMM1 | `$A15122` | `$20004022` | 2 |
| COMM2 | `$A15124` | `$20004024` | 4 |
| COMM3 | `$A15126` | `$20004026` | 6 |
| COMM4 | `$A15128` | `$20004028` | 8 |
| COMM5 | `$A1512A` | `$2000402A` | 10 |
| COMM6 | `$A1512C` | `$2000402C` | 12 |
| COMM7 | `$A1512E` | `$2000402E` | 14 |

R8 = `$20004020` is the COMM base register, set by the Master SH2 dispatch loop every iteration.

### Naming Convention Warning

Sega's official supplement-2 uses **byte-offset names** from the system register base (`$20004000`):

```
comm0  = h'20   →  $20004020  =  our COMM0
comm2  = h'22   →  $20004022  =  our COMM1
comm4  = h'24   →  $20004024  =  our COMM2
comm6  = h'26   →  $20004026  =  our COMM3
comm8  = h'28   →  $20004028  =  our COMM4
comm9  = h'29   →  $20004029  =  our COMM4 LOW BYTE (!)
comm10 = h'2a   →  $2000402A  =  our COMM5
comm12 = h'2c   →  $2000402C  =  our COMM6
comm14 = h'2e   →  $2000402E  =  our COMM7
```

Note `comm9` at offset h'29 — this is a **byte** address, pointing to the low byte of COMM4. This confirms Sega intended byte-level access to individual halves.

Also note: `comm14` (h'2e, our COMM7) is mislabeled "PWM Timer Control" in the supplement — this is an error in the official documentation. The actual PWM Timer Control register starts at offset h'30.

Our codebase uses **register-index names** (COMM0-COMM7). Mapping: Sega's `comm(2N)` = our `COMM(N)`.

---

## 2. Access Width Rules

The hardware manual specifies **"Access: Byte/Word"** for both the 68K and SH2 sides.

### Multi-Width Access

| Width | 68K Example | SH2 Example | What It Accesses |
|-------|------------|-------------|-----------------|
| **Byte (HI)** | `tst.b $A15120` | `mov.b @r8,r0` | COMM0 high byte only |
| **Byte (LO)** | `move.b #$22,$A15121` | `mov.b @(1,r8),r0` | COMM0 low byte only |
| **Word** | `move.w d0,$A15124` | `mov.w @(4,r8),r0` | Full COMM2 (16-bit) |
| **Longword** | `move.l a0,$A15128` | `mov.l @(8,r8),r0` | COMM4 + COMM5 (32-bit) |

### Longword Access Constraints

68K `move.l` to a COMM address writes **two consecutive registers** as one 32-bit value. SH2 `mov.l @(disp,r8),Rn` reads two consecutive registers. Both require 4-byte-aligned effective addresses:

| SH2 Instruction | Effective Address | Registers Read |
|----------------|:-----------------:|---------------|
| `mov.l @(0,r8),Rn` | `$20004020` | COMM0 + COMM1 |
| `mov.l @(4,r8),Rn` | `$20004024` | COMM2 + COMM3 |
| `mov.l @(8,r8),Rn` | `$20004028` | COMM4 + COMM5 |
| `mov.l @(12,r8),Rn` | `$2000402C` | COMM6 + COMM7 |

**Caution:** `mov.l @(0,r8),Rn` reads COMM0:1 — this includes COMM1, which in VRD carries signal bits. Reading COMM6:7 as a longword includes COMM7 (Slave doorbell). Be aware of side effects.

### SH2 Word Load Restriction

`mov.w @(disp,Rm),R0` — the destination **must be R0**. This is an SH2 ISA constraint. Use `mov r0,Rn` afterward to transfer to another register:

```asm
mov.w   @(2,r8),r0      /* Can ONLY load into R0 */
mov     r0,r2            /* Then move to target register */
```

`mov.l @(disp,Rm),Rn` has no such restriction — any destination register works.

### 68K Byte Aliases

Defined in `definitions.asm` for byte-level access within 16-bit registers:

```asm
COMM0_HI   equ $A15120   ; High byte of COMM0 (command trigger flag)
COMM0_LO   equ $A15121   ; Low byte of COMM0 (command index)
COMM1_HI   equ $A15122   ; High byte of COMM1 (mode flags)
COMM1_LO   equ $A15123   ; Low byte of COMM1 (handshake bit 0)
```

---

## 3. Access Timing

COMM registers are classified as **System Registers** in the 32X access timing table (Section 4.1):

| CPU | Operation | Wait States | Bus Cycle Time |
|-----|-----------|:-----------:|:--------------:|
| **SH2** | Read or Write | 1 wait (constant) | 3 clocks = ~130 ns @ 23 MHz |
| **68K** | Read or Write | 0 wait (constant) | 4 clocks = ~559 ns @ 7.16 MHz |

For context, other access timings:

| Region | SH2 Wait | 68K Wait |
|--------|:--------:|:--------:|
| Cartridge ROM | 6-15 wait | 0-5 wait |
| Frame Buffer | 5 wait ~ 64 µs | 2-3 wait ~ 64 µs |
| VDP Register | 5 wait | 0-2 wait |
| **System Register (COMM)** | **1 wait** | **0 wait** |
| SDRAM | 2-6 wait | N/A (SH2 only) |

COMM registers are the **fastest shared resource** available to both CPUs.

---

## 4. The Hazard Rule — Read-During-Write is Undefined

This is the single most important hardware constraint. From the 32X hardware manual (Section 3.3), verbatim:

> "If simultaneously writing the same register from both the 68000 and SH2, **or if either the 68000 or SH2 is writing while the other is reading**, the value of that register becomes undefined."

This is **stronger than most documentation suggests**. It covers three cases:

| Scenario | Result |
|----------|--------|
| 68K writes + SH2 writes same register | **Undefined** |
| 68K writes + SH2 reads same register | **Undefined** |
| SH2 writes + 68K reads same register | **Undefined** |

Only **read + read** is safe without synchronization.

The manual continues:

> "As a result, dividing the register to be used as SH2 → 68000 and 68000 → SH2 must be avoided."

This warns against a naive partitioning where "COMM0-3 are 68K→SH2" and "COMM4-7 are SH2→68K" — because the reading side could overlap with the writing side. Instead, VRD uses a **set/clear ownership model**: the 68K sets values (writes non-zero), and the SH2 clears them (writes zero). They never access the same register in the same time window, enforced by polling-based handshakes.

### Practical Implication

Every COMM protocol must guarantee that when CPU-A writes a register, CPU-B is NOT simultaneously reading or writing it. The only way to enforce this on hardware without cache snooping or memory barriers is **software handshake**: one CPU signals via a DIFFERENT register that it's done writing, and the other CPU only reads after seeing that signal.

---

## 5. SH2 Write Buffer — Writes Are Asynchronous

The SH7604 CPU (Section 7.11.2) has a **1-level write buffer** in its Bus State Controller:

> "When the right to use the internal bus is held, the CPU is notified that the write is completed **without waiting for the actual writing** to the on-chip peripheral module or off the chip to end."

**What this means:** After an SH2 instruction like `mov.w r6,@r8` (write to COMM0), the SH2 CPU moves to the next instruction *before the value physically reaches the COMM register*. The 68K won't see the new value until the write buffer flushes to the external bus.

### Forcing Write Completion

From the SH7604 manual:

> "To immediately continue processing after checking that the write to the device of actual data has ended, perform a **dummy read access to the same address** consecutively to check that the write has ended."

Pattern:
```asm
mov.w   r6,@r8          /* Write $0100 to COMM0 */
mov.w   @r8,r6          /* Dummy read — forces write buffer flush */
/* Now the 68K is guaranteed to see the new COMM0 value */
```

The supplement-2 shows this pattern in interrupt clear code:
```asm
mov.w   r0, @(intclr, gbr)      ; Write interrupt clear
mov.w   @(intclr, gbr), r0      ; Read back — synchronize write buffer
rte                              ; Safe to return now
```

### Impact on VRD Protocols

In B-004's params-read signal, the SH2 writes $0100 to COMM0 after reading all params. Without a dummy read, there's a brief window where the 68K still sees the old COMM0_LO value and spins a few extra poll cycles. This is **not a correctness issue** (the 68K eventually sees the new value), but adds a few microseconds of unnecessary latency. Adding a dummy read would eliminate this latency at the cost of one SH2 instruction (2 bytes).

---

## 6. Cache Coherency — Cache-Through Required

The SH7604 data cache (Section 8.5.3):

> "The SH7604's cache memory does not have a **snoop function**. This means that when data is shared with a bus master other than the CPU, software must be used to ensure the coherency of data."

COMM registers are accessed at `$20004020`-`$2000402E`, which is in the **cache-through area** (`$20000000`-`$27FFFFFF`). Cache-through accesses bypass the data cache entirely — every read goes to the physical register, every write goes to the write buffer → physical register.

| Address Range | Cache Behavior | Use For COMM? |
|---------------|---------------|:-------------:|
| `$00004020` | **Cacheable** — may return stale data | **NEVER** |
| `$20004020` | **Cache-through** — always reads physical register | **ALWAYS** |

The boot ROM sets `_sysreg = h'00004000 + TH` where `TH = h'20000000` (cache-through), ensuring all system register access goes through cache-through by default.

---

## 7. CMD Interrupt — The Unused Signaling Mechanism

The 32X provides hardware interrupts from 68K to SH2, separate from COMM polling:

### Interrupt Control Register (68K side: `$A15102`)

| Bit | 15-2 | 1 | 0 |
|-----|:----:|:-:|:-:|
| Field | — | INTS | INTM |
| R/W | — | R/W | R/W |

- **INTM** = 1: Generate CMD interrupt on Master SH2
- **INTS** = 1: Generate CMD interrupt on Slave SH2
- Both auto-clear when the SH2 acknowledges

### CMD Interrupt Clear Register (SH2 side: `$2000401A`)

Writing any value clears the pending CMD interrupt. Must be cleared before the interrupt can fire again.

### Interrupt Mask Register (SH2 side: `$20004000`)

CMD interrupt can be masked/unmasked via the CMD bit (0 = masked, 1 = enabled). Master and Slave have separate mask registers at the same address.

### Why VRD Doesn't Use This

VRD uses polling (`tst.b COMM0_HI` / `bne.s .wait`) instead of CMD interrupts. The polling loop is the 60% bottleneck. CMD interrupts could theoretically free the Master SH2 to do useful work between commands instead of spinning in the dispatch loop.

**Critical limitation:** "There are no interrupts from SH2 to 68000." The SH2 can only signal the 68K via COMM register writes (polling on the 68K side). This is asymmetric — 68K→SH2 can use interrupts, but SH2→68K cannot.

---

## 8. Shared Memory Alternatives

COMM registers are just 16 bytes. For comparison, all shared memory options:

| Memory | Size | 68K Access | SH2 Access | Caching | Notes |
|--------|:----:|:----------:|:----------:|:-------:|-------|
| **COMM registers** | 16 B | `$A15120` (0 wait) | `$20004020` (1 wait) | None (cache-through) | Always accessible, fastest |
| **SDRAM** | 256 KB | N/A | `$06000000` (2-6 wait) | Cacheable | SH2-only; 68K accesses ROM copy |
| **Cartridge ROM** | 4 MB | `$000000` (0-5 wait) | `$02000000` (6-15 wait) | Cacheable | Read-only (both CPUs) |
| **Frame Buffer** | 128 KB x2 | `$840000` | `$04000000` / `$24000000` | Cacheable / CT | Access controlled by FM bit |
| **68K Work RAM** | 64 KB | `$FF0000` | **UNMAPPED** | N/A | SH2 CANNOT access |

**Key constraint:** SH2 cannot access 68K Work RAM at ANY address. The SH2 memory map has a gap between SDRAM (`$0203FFFF`) and Frame Buffer (`$04000000`). Addresses like `$02FFFB00` are unmapped — reads return garbage, writes go nowhere.

---

## 9. Boot Synchronization Protocol

During power-on, the boot ROM uses COMM registers for three-way handshake between all CPUs. The registers carry ASCII magic values, not command protocol data.

### Sequence

```
Master SH2:
  1. Hardware init (FRT, BSC, SDRAM, cache)
  2. Security check
  3. Copy ROM $020000-$05FFFF → SDRAM $06000000-$0603FFFF
  4. Write "M_OK" ($4D5F4F4B) to COMM0:1
  5. Wait for 68K to clear COMM0 to 0
  6. Wait for Slave to write "SLAV" ($534C4156) to COMM8
  7. Start application

Slave SH2:
  1. Hardware init (FRT, cache)
  2. Write "SLAV" ($534C4156) to COMM8
  3. Write "S_OK" ($535F4F4B) to COMM4:5
  4. Wait for 68K to clear COMM4 to 0
  5. Start application

68000:
  1. Wait for "M_OK" in COMM0:1 (Master ready)
  2. Wait for "S_OK" in COMM4:5 (Slave ready)
  3. Clear COMM0 to 0 (signal Master to start app)
  4. Clear COMM4 to 0 (signal Slave to start app)
  5. Set initflug = "INIT" ($494E4954)
  6. Start application
```

**68K boot code sample** (from supplement attachment):
```asm
?w:     cmp.l   #'M_OK', comm0(a5)     ; SH2 Master OK?
        bne.b   ?w
?w1:    cmp.l   #'S_OK', comm4(a5)     ; SH2 Slave OK?
        bne.b   ?w1
        moveq   #0, d0
        move.l  d0, comm0(a5)          ; Start Master
        move.l  d0, comm4(a5)          ; Start Slave
        move.l  #'INIT', initflug
```

**SH2 boot code sample** (from supplement attachment):
```asm
wait_md:
        mov.l   @(comm0, gbr), r0      ; Wait for 68K to clear COMM0
        cmp/eq  #0, r0
        bf      wait_md
wait_slave:
        mov.l   #"SLAV", r1
        mov.l   @(comm8, gbr), r0      ; Wait for Slave ready signal
        cmp/eq  r1, r0
        bf      wait_slave
```

After boot completes, COMM0-7 transition to the game's command protocol. All magic values are cleared.

---

## 10. VRD COMM1 Usage — Why It's Dangerous

Cross-referencing all game code, COMM1 (`$A15122`/`$20004022`) has **multiple overlapping roles** in VRD:

### func_084 Behavior (Master SH2, `$060043F0`)

Called after EVERY Master SH2 command as the "completion" signal:

```
1. MOV.L #0, @$20004020     → Clears COMM0_HI, COMM0_LO, COMM1_HI, COMM1_LO
2. MOV.B @$20004023, R0     → Read COMM1_LO (= 0, just cleared)
3. OR #1, R0                → Set bit 0
4. MOV.B R0, @$20004023     → COMM1_LO = 1 ("command done" signal)
```

This means after every command: COMM0 = $0000, COMM1 = $0001.

### All COMM1 Consumers

| Component | What It Reads | How |
|-----------|--------------|-----|
| **V-INT handler** | COMM1_LO bit 0 | `btst #0,$A15123` — checks if SH2 command is done |
| **Scene init** | COMM1_LO bit 0 | Wait loop until SH2 signals ready |
| **Frame swap** | COMM1_LO bit 0 | Checks SH2 state before buffer swap |
| **VDP operations** | COMM1_LO bit 0 and bit 1 | Bit 0 = command done, bit 1 = ACK for data transfers |
| **Mars COMM write** | COMM1_LO bit 0 | Handshake verification |
| **Race scene init** | COMM1_HI | `move.b #$04,COMM1_HI` for 2-player mode flag |
| **Slave SH2 dispatcher** | Byte at `$20004022` | Polls for Slave work commands (non-zero = dispatch) |

### The Hazard

Writing arbitrary data (e.g., a height parameter) to COMM1 corrupts ALL of these signals simultaneously. Even with interrupt protection on the 68K side, the Slave SH2 continuously polls COMM1 for work — writing height to COMM1 could cause the Slave to interpret it as a work command and dispatch to a random jump table entry.

---

## 11. SH2 Interrupt Bug & Corrective Action

The supplement-2 documents a critical SH2 hardware bug affecting interrupt handling:

> "If an external interrupt (VRES, V, H, CMD, PWM) input is in the acknowledge period for interrupt inputs, or external interrupt of lower levels, SH2 will not recognize the external interrupt."

> "When multiple interrupt inputs are entered, there may be branching to the interrupt process routine of a **vector number that differs from the interrupt vector originally received**."

**Corrective action:** Toggle the Free Run Timer (FRT) output in every external interrupt handler:

```asm
vint:
        ; ... save context ...
        mov.l   #_FRT, r1
        mov.b   @(_TOCR, r1), r0
        xor     #h'02, r0               ; Toggle FRT output
        mov.b   r0, @(_TOCR, r1)
        mov.w   r0, @(vintclr, gbr)     ; Clear V interrupt
        ; ... handler body (must be ≥5 clocks) ...
```

**Pipeline synchronization requirement:** When clearing an external interrupt factor, a dummy read must follow to prevent the same interrupt from being reacknowledged:

```asm
mov.w   r0, @(vintclr, gbr)     ; Write interrupt clear
mov.w   @(vintclr, gbr), r0     ; Read back — flush write buffer
rte                              ; Safe to return
nop
```

This is the same write-buffer synchronization pattern described in Section 5.

---

## 12. Architecture Diagram

From the hardware manual (Figure 3.28):

```
                              INTM
                      ┌────────────────────┐
                      │   INTS             │
                      │                    │
                      │   8 Word           │         SH2
    MEGA      ◄──────►│   Communication    │◄───────► Master
    Drive             │   Port             │
                      │                    │
              ○───────┤   ─ ─ ─ ─ ─ ─ ─   │
                  ○───┤                    │         SH2
                      │   4 Word FIFO      │◄───────► Slave
              ○───────┤   (DREQ/DMA)       │
                  ○───┤                    │
                      │   4 Word FIFO      │
                      └────────────────────┘

              Figure: 68000 and SH2 Communication Block
```

The 8-word Communication Port is the primary inter-CPU channel. The 4-word FIFOs are separate (used for DMA/DREQ transfers, not COMM protocol). INTM and INTS are CMD interrupt lines from 68K to Master/Slave SH2.

---

## 13. Summary of Critical Rules

1. **Read-during-write = undefined.** Not just write-write — any overlapping access to the same register from different CPUs produces undefined results.

2. **SH2 writes are buffered.** The value may not be visible to the 68K immediately. Use a dummy read to force synchronization if timing matters.

3. **Always use cache-through** (`$20004020`) for SH2 COMM access. Never `$00004020`.

4. **COMM1 is a system signal register.** func_084 manages COMM1_LO bit 0 as the "command done" flag. The Slave polls COMM1 for work. Writing arbitrary data to COMM1 breaks both the Master and Slave protocols.

5. **COMM7 is the Slave doorbell.** Only write COMM7 from code that understands the Slave's signal protocol. Never broadcast game command bytes to COMM7 (proven crash — B-006).

6. **16 bytes is all you get.** COMM registers are the only always-accessible shared memory. Every protocol competes for the same 8 words.

7. **No SH2→68K interrupts.** The SH2 can only signal the 68K by writing to COMM registers and hoping the 68K polls. CMD interrupts only go 68K→SH2.

8. **func_084 clears COMM0:1 atomically** via a longword zero write to `$20004020`. This is both the command completion signal and the COMM1 reset. Any protocol using COMM1 for parameter passing must account for this.
