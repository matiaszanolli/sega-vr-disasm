# 68K-SH2 Communication

**Last Updated**: February 17, 2026
**Purpose:** Communication protocol and coordination between 68000 and dual SH2 processors
**Status:** Reference document — reflects B-003/B-004 optimizations (Feb 2026)
**Related:** [COMM_REGISTER_REFERENCE.md](../disasm/sh2/COMM_REGISTER_REFERENCE.md) for register-level quick reference, [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) for validated v2.3 sync protocol

---

## Architecture Overview

```
                    +----------------+
                    |   Cartridge    |
                    |    ROM (4MB)   |
                    +-------+--------+
                            |
        +-------------------+-------------------+
        |                   |                   |
+-------v-------+   +-------v-------+   +-------v-------+
|    68000      |   | SH2 Master    |   | SH2 Slave     |
|  (7.67 MHz)   |   |  (23.01 MHz)  |   |  (23.01 MHz)  |
+-------+-------+   +-------+-------+   +-------+-------+
        |                   |                   |
        v                   v                   v
    Genesis             32X SDRAM           32X SDRAM
    Work RAM            (256KB)             (shared)
     (64KB)                 |                   |
        |                   +-----+-----+-------+
        |                         |     |
        +----------> COMM <-------+     |
                   Registers            |
                   ($A15120)            v
                                   Frame Buffer
                                    (256KB)
```

**Note:** ROM is 4MB (32 Mbit), not 3MB. 68K runs at 7.67 MHz (not 12.5 MHz—that's the base Genesis clock before divider).

---

## Communication Registers (✅ Confirmed per Hardware Manual)

### COMM Port Mapping ($A15120-$A1512F from 68K side)

The 32X has **8 COMM registers** (COMM0-COMM7) at **2-byte (word) intervals**:

| 68K Address | SH2 Address | Name  | VRD Usage (Current) |
|-------------|-------------|-------|---------------------|
| $A15120 | $20004020 | COMM0 | Trigger (HI) + dispatch index (LO); B-004 uses $2222 |
| $A15122 | $20004022 | COMM1 | **System signal — do not write** (V-INT/scene-init/frame-swap handshake) |
| $A15124 | $20004024 | COMM2 | **Slave cmd byte** (Sega calls this "COMM1") / Source ptr hi (B-004) / Width (B-003) |
| $A15126 | $20004026 | COMM3 | Source ptr lo (B-004) / Height (B-003) |
| $A15128 | $20004028 | COMM4 | Dest ptr hi (B-004) / Data ptr hi (B-003) |
| $A1512A | $2000402A | COMM5 | Dest ptr lo (B-004) / Data ptr lo (B-003) |
| $A1512C | $2000402C | COMM6 | Height (HI) + words-per-row (LO) (B-004) / Add value (B-003) / Handshake (original) |
| $A1512E | $2000402E | COMM7 | Slave doorbell: $0027=cmd27 work (B-003), $0000=idle |

**Access patterns:**
- **68K word access**: Each register is a 16-bit word (e.g., `MOVE.W d0,$A15120`)
- **68K byte access**: Game uses byte access within words (e.g., `TST.B $A15120` tests COMM0 hi byte)
- **68K longword access**: `MOVE.L a0,$A15128` writes to COMM4+COMM5 as a 32-bit pointer
- **SH2 longword access**: SH2 can read paired registers as 32-bit (e.g., $20004020 reads COMM0+COMM1)

### Adapter Control ($A15100-$A15106) (✅ Confirmed)

| Address | Name | Purpose |
|---------|------|---------|
| $A15100 | ADAPTER_CTRL | 32X enable (ADEN), FM bit (VDP access) |
| $A15102 | INT_CTRL | SH2 interrupt control |
| $A15104 | BANK_SET | ROM banking for >4MB games |
| $A15106 | DREQ_CTRL | DMA request control |

See [DATA_STRUCTURES.md](architecture/DATA_STRUCTURES.md) for complete memory map.

---

## Boot Synchronization Protocol (✅ Per Official Hardware Manual)

After power-on, the boot ROM coordinates startup between all three processors using COMM registers:

### Official Three-Way Handshake

```
┌─────────────────────────────────────────────────────────────────┐
│                    BOOT SYNCHRONIZATION                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Master SH2:                                                    │
│    1. Initialize FRT for interrupt correction                   │
│    2. Write "M_OK" (0x4D5F4F4B) to COMM0                       │
│    3. Wait for COMM0 = 0 (68K start signal)                    │
│    4. Wait for "SLAV" (0x534C4156) in COMM8                    │
│    5. Configure serial interface                                │
│    6. Enable interrupts (SR = 0x20)                            │
│                                                                 │
│  Slave SH2:                                                     │
│    1. Initialize FRT for interrupt correction                   │
│    2. Write "SLAV" (0x534C4156) to COMM8                       │
│    3. Write "S_OK" (0x535F4F4B) to COMM4                       │
│    4. Wait for COMM4 = 0 (68K start signal)                    │
│    5. Enable interrupts (SR = 0x20)                            │
│                                                                 │
│  68000:                                                         │
│    1. Wait for "M_OK" in COMM0 (Master ready)                  │
│    2. Wait for "S_OK" in COMM4 (Slave ready)                   │
│    3. Clear COMM0 to 0 (signal Master to start)                │
│    4. Clear COMM4 to 0 (signal Slave to start)                 │
│    5. Set initflug = "INIT" (0x494E4954)                       │
│    6. Continue to main program                                  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Source:** [32x-hardware-manual.md](../docs/32x-hardware-manual.md) Chapter 5 §1.13 (Boot ROM), Section 3.3, [32x-technical-info-attachment-1.md](../docs/32x-technical-info-attachment-1.md)

### Magic Values

| Value | ASCII | Register | Meaning |
|-------|-------|----------|---------|
| 0x4D5F4F4B | "M_OK" | COMM0 | Master SH2 initialized |
| 0x535F4F4B | "S_OK" | COMM4 | Slave SH2 initialized |
| 0x534C4156 | "SLAV" | COMM8 | Slave ready for Master coordination |
| 0x494E4954 | "INIT" | initflug (68K RAM) | Boot complete marker |

---

## COMM Register Usage

### Original Game Protocol (✅ Confirmed January 2026)

Based on disassembly of [sh2_communication.asm](../disasm/modules/68k/sh2/sh2_communication.asm):

| Register | 68K Addr | SH2 Addr | Usage | Confidence |
|----------|----------|----------|-------|------------|
| COMM0 hi | $A15120 | $20004020 | Command flag (68K→SH2) | ✅ Confirmed |
| COMM0 lo | $A15121 | $20004021 | Command code ($22, $25, $27, etc.) | ✅ Confirmed |
| COMM2 | $A15124 | $20004024 | **Slave command byte** - Slave polls COMM2_HI (Sega calls this "COMM1") | ✅ Confirmed |
| COMM3 | $A15126 | $20004026 | Slave status ("OVRN" marker) | ✅ Confirmed |
| COMM4+5 | $A15128 | $20004028 | 32-bit data pointer (68K→SH2) | ✅ Confirmed |
| COMM6 | $A1512C | $2000402C | Handshake flag ($0101 = ready) | ✅ Confirmed |
| COMM7 | $A1512E | $2000402E | Master→Slave signal (expansion ROM) | ✅ Mod uses |

**Slave COMM1 Protocol (✅ Disassembled):**

The Slave SH2 runs a command dispatcher loop at SDRAM `$06000592`. **Naming note:** Sega's internal source calls the register at hardware address `$20004024` (our COMM2) "COMM1". This is Sega's convention — hardware COMM0 ($20004020) is the master command trigger, so their COMM1 starts at $20004024. All addresses below reflect hardware addresses.

```
1. Read COMM2_HI byte ($20004024) — Sega calls this "COMM1"
2. If COMM2_HI == 0: No work → enter COMM7 doorbell check ($06000608)
3. If COMM2_HI != 0: Dispatch to handler via jump table ($060005C8)
4. Loop back to step 1
```

**B-003 Change (Feb 2026):** The original 64-cycle delay loop at `$06000608` has been **replaced** by `inline_slave_drain` — a COMM7 doorbell handler that checks for cmd $27 async work. When COMM7 != 0, the Slave reads pixel parameters from COMM2-6, processes them, and clears COMM7. When COMM7 == 0, it returns to the COMM1 command loop. This converts ~66.5% idle time into useful work processing.

See: [slave_command_dispatcher.asm](../disasm/sh2/3d_engine/slave_command_dispatcher.asm), [inline_slave_drain.asm](../disasm/sh2/expansion/inline_slave_drain.asm)

### v2.3+ Protocol Additions (Expansion ROM)

| Register | 68K Addr | Expansion ROM Usage |
|----------|----------|---------------------|
| COMM5 | $A1512A | Vertex transform counter (+101 per call) |
| COMM7 | $A1512E | Slave doorbell signal (see below) |

**COMM7 Values (current):**

| Value | Meaning | Writer | Consumer |
|-------|---------|--------|----------|
| `$0000` | Idle / ack | Slave SH2 | 68K (polls before next write) |
| `$0027` | cmd27 async work | 68K (`sh2_cmd_27`) | Slave (`inline_slave_drain` at $020608) |

**Important:** COMM7 must **never** carry raw game command codes. Game commands ($01, $16, $27...) overlap with expansion signal values — broadcasting them to COMM7 triggers uninitialized handlers on the Slave and crashes (proven in B-006). See [KNOWN_ISSUES.md](../KNOWN_ISSUES.md) §COMM7 Signal Namespace Collision.

### B-003: Async sh2_cmd_27 via COMM Registers (Feb 2026)

Bypasses Master SH2 entirely. 68K writes pixel parameters directly to COMM2-6, rings COMM7 doorbell, Slave processes inline from SDRAM.

```
68K (sh2_cmd_27)                 Slave SH2 ($020608)
 │                                    │
 ├─ Wait COMM7==0 (Slave idle) ──────>│  Polls COMM7
 ├─ A0→COMM4:5 (data ptr)            │
 ├─ D0→COMM2 (width)                 │
 ├─ D1→COMM3 (height)                │
 ├─ D2→COMM6 (add value)             │
 ├─ $0027→COMM7 (doorbell) ─────────>│  COMM7 != 0 detected
 ├─ RTS (fire-and-forget)             ├─ Read COMM2-6
 │                                    ├─ Clear COMM7=0 (ack)
 │                                    ├─ OR ptr with $20000000 (cache-through)
 │                                    ├─ Process pixel region
 │                                    └─ BRA check_comm7 (re-entrant)
```

- **21 calls/frame**, ~50 cycles each (was ~250 with Master dispatch)
- No Master SH2 involvement, no COMM0 dispatch overhead
- Slave code runs from SDRAM (PicoDrive cannot execute Slave code from expansion ROM)
- **Files:** [code_e200.asm](../disasm/sections/code_e200.asm):328 (68K), [inline_slave_drain.asm](../disasm/sh2/expansion/inline_slave_drain.asm) (SH2)

### B-004: Single-Shot sh2_send_cmd (Feb 2026) ✅ DONE

Keeps Master SH2 dispatch but writes all params to COMM2-6 at once (COMM1 untouched), eliminating 2 of 3 COMM6 handshake waits. Tested: 189 32X frames in PicoDrive, no crash (2026-02-20).

```
68K (sh2_send_cmd)               Master SH2 ($3010F0)
 │                                    │
 ├─ Wait COMM0_HI==0 ───────────────>│  Idle poll
 ├─ A0→COMM2:3, A1→COMM4:5          │
 ├─ D1→COMM6_HI, D0/2→COMM6_LO     │
 ├─ $2222→COMM0 (trigger+index) ───>│  Dispatch to entry $22
 ├─ Wait COMM0_LO==0 (params read)  ├─ Read COMM2:3, COMM4:5, COMM6 at once
 ├─ Wait COMM0_HI==0 (done)         ├─ Signal params read: clr COMM0_LO
 │                                    ├─ Word-by-word 2D block copy
 │                                    ├─ func_084: clr.l COMM0 (done)
 │                                    └─ Return to dispatch loop
```

- **COMM layout (v5, COMM1-safe)**: COMM0=$2222 (HI=trigger flag, LO=dispatch index $22); COMM2:3=A0; COMM4:5=A1; COMM6_HI=D1 (height); COMM6_LO=D0/2 (words/row); COMM1+COMM7=untouched
- **Dispatch mechanism**: COMM0_HI polled for non-zero (trigger). COMM0_LO ($20004021) = index → shll2 → jump table at $06000780. Entry $22 at $06000808 → $023010F0.
- **14 calls/frame**, ~170 cycles each (was ~300 with 3-phase)
- Jump table entry at $020808 redirected to expansion $023010F0 (active since commit 7ba0150)
- **Files:** [code_e200.asm](../disasm/sections/code_e200.asm):281 (68K), [cmd22_single_shot.asm](../disasm/sh2/expansion/cmd22_single_shot.asm) (SH2)

See [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) for validated synchronization protocol details.
See [COMM_REGISTER_REFERENCE.md](../disasm/sh2/COMM_REGISTER_REFERENCE.md) for register-level details and SH2 assembly patterns.

---

## 68K Functions That Communicate with SH2 (✅ Confirmed)

### Command Submission (✅ Disassembled - see [sh2_communication.asm](../disasm/modules/68k/sh2/sh2_communication.asm))

| Address | Name | Description |
|---------|------|-------------|
| $00E316 | `sh2_send_cmd_wait` | Wait for ready, send command (1 blocking loop) |
| $00E35A | `sh2_send_cmd` | **B-004:** Single-shot param write + COMM0 trigger (was 3 blocking loops) |
| $00E342 | `sh2_wait_response` | Poll COMM6 for SH2 response (used by remaining 3-phase cmds) |
| $00E3B4 | `sh2_cmd_27` | **B-003:** Fire-and-forget via COMM2-6 + COMM7 doorbell (was 2 blocking loops, 21 calls/frame) |
| $00E406 | `sh2_cmd_2F` | Extended command $2F (3 inline blocking loops, 4 params) |
| $00E22C | `sh2_graphics_cmd` | General graphics command |
| $00E2F0 | `sh2_load_data` | Data load via SH2 |
| $00E2E4 | `sh2_copy_routine` | SH2 memory copy |
| $00E1BC | `sh2_palette_load` | Palette transfer |
| $011B08 | `sh2_graphics_batch` | Batch graphics ops |
| $012260 | `sh2_wait_ready` | COMM ready check |

### Synchronization

| Address | Name | Description |
|---------|------|-------------|
| $00203A | `sh2_frame_sync` | Frame boundary sync |
| $002890 | `sh2_comm_sync` | COMM register sync |
| $0027DA | `sh2_framebuffer_prep` | Frame buffer setup |
| $0028C2 | `VDPSyncSH2` | VDP/SH2 sync |

See [68K_FUNCTION_REFERENCE.md](68K_FUNCTION_REFERENCE.md) for complete function catalog.

---

## SH2 Functions (📋 Inferred from disassembly)

### 3D Engine (Master SH2)

| Address | Name | Description |
|---------|------|-------------|
| $0222301C | `display_list_processor` | Parse display list |
| $02223066 | `render_init` | Initialize render |
| $022230E6 | `matrix_transform_loop` | Transform batch |
| $02224320 | `polygon_dispatch_6way` | Polygon render |

### Slave SH2 (Original Game) ✅ Confirmed January 2026

| SDRAM Addr | ROM Offset | Name | Description |
|------------|------------|------|-------------|
| $06000570 | $020570 | `slave_init` | Initialize Slave, set VBR, wait for Master |
| $06000592 | $020592 | `slave_command_loop` | Poll COMM1 for commands |
| $060005C8 | $0205C8 | `slave_jump_table` | Command handler dispatch table |
| $06000608 | $020608 | `inline_slave_drain` | **B-003:** COMM7 doorbell check + cmd27 pixel processing (was 64-cycle delay) |
| $0600060A | $02060A | *(drain code)* | Previously 66.5% idle — now processes cmd27 work via COMM2-6 |
| $02220694 | $020694 | *(unused)* | "OVRN" marker write (fallback idle) |

**Profiler Note:** Pre-optimization profiling showed the Slave spending 66.5% of its cycles at `$0600060A` (NOP inside delay loop). B-003 replaces this delay with `inline_slave_drain`, which processes cmd $27 pixel work during what was previously idle time.

See: [slave_command_dispatcher.asm](../disasm/sh2/3d_engine/slave_command_dispatcher.asm), [inline_slave_drain.asm](../disasm/sh2/expansion/inline_slave_drain.asm)
See: [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) for optimization strategies.

---

## Timing Constraints (📋 Estimated)

### Frame Budget

| CPU | Clock | Cycles/Frame (60 Hz) |
|-----|-------|----------------------|
| 68K | 7.67 MHz | ~128,000 |
| SH2 | 23 MHz | ~383,000 |

### V-INT Coordination

```
V-Blank Start
    |
    +-- 68K: vint_handler ($001684)
    |       Reads $FFC87A for dispatch state
    |       May update COMM registers
    |
    +-- SH2: Checks COMM during idle loop
            Responds to commands
            Updates COMM4/COMM6

Active Display
    |
    +-- 68K: Game logic, input processing
    |
    +-- SH2: 3D rendering to back buffer

V-Blank End
    |
    +-- Buffer flip (if frame complete)
```

See [VINT_HANDLER_ARCHITECTURE.md](architecture/VINT_HANDLER_ARCHITECTURE.md) for 68K V-INT details.

---

## Data Flow (📋 Conceptual)

### Display List Path

```
68K Work RAM              SH2 SDRAM              Frame Buffer
+------------+          +------------+          +------------+
| Object     |  COMM    | Display    |  Render  | Pixel      |
| Tables     | -------> | List       | -------> | Data       |
| $FF9100+   |          | (parsed)   |          | $840000+   |
+------------+          +------------+          +------------+
```

### Palette Path

```
68K                      32X VDP
+------------+  Write   +------------+
| Palette    | -------> | CRAM       |
| Buffer     |          | $A15200    |
+------------+          +------------+
```

---

## Related Documentation

- [COMM_REGISTER_REFERENCE.md](../disasm/sh2/COMM_REGISTER_REFERENCE.md) - **Register-level quick reference with code patterns and hazards**
- [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) - Parallel processing infrastructure
- [MASTER_SH2_DISPATCH_ANALYSIS.md](architecture/MASTER_SH2_DISPATCH_ANALYSIS.md) - Master dispatch + B-006 crash analysis
- [KNOWN_ISSUES.md](../KNOWN_ISSUES.md) - COMM7 namespace collision, SH2 Work RAM inaccessibility, cache-through
- [DATA_STRUCTURES.md](architecture/DATA_STRUCTURES.md) - Memory maps and data structures
- [VINT_HANDLER_ARCHITECTURE.md](architecture/VINT_HANDLER_ARCHITECTURE.md) - V-INT handler details
- [68K_FUNCTION_REFERENCE.md](68K_FUNCTION_REFERENCE.md) - Complete 68K function catalog
- [SH2_SYMBOL_MAP.md](../disasm/SH2_SYMBOL_MAP.md) - SH2 function symbols

---

**Document Status:** Reference document
**Confidence:** High — COMM register mapping confirmed, command functions disassembled, B-003/B-004 implementations verified
**Last Updated:** 2026-02-17 (Updated for B-003 async cmd27, B-004 single-shot cmd22, COMM7 doorbell protocol)
