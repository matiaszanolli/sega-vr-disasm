# 68K-SH2 Communication

**Purpose:** Communication protocol and coordination between 68000 and dual SH2 processors
**Status:** Reference document with mixed confidence levels
**Related:** [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) for validated v2.3 sync protocol

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
|   (7.67MHz)   |   |   (23MHz)     |   |   (23MHz)     |
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

| 68K Address | SH2 Address | Name  | VRD Game Usage |
|-------------|-------------|-------|----------------|
| $A15120 | $20004020 | COMM0 | Command flag (hi byte) + code (lo byte) |
| $A15122 | $20004022 | COMM1 | Status/reserved |
| $A15124 | $20004024 | COMM2 | Parameter word |
| $A15126 | $20004026 | COMM3 | Parameter word |
| $A15128 | $20004028 | COMM4 | Data pointer (hi word) |
| $A1512A | $2000402A | COMM5 | Data pointer (lo word) |
| $A1512C | $2000402C | COMM6 | Handshake flag |
| $A1512E | $2000402E | COMM7 | Master→Slave signal (expansion ROM) |

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

## COMM Register Usage

### Original Game Protocol (✅ Confirmed January 2026)

Based on disassembly of [sh2_communication.asm](../disasm/modules/68k/sh2/sh2_communication.asm):

| Register | 68K Addr | SH2 Addr | Usage | Confidence |
|----------|----------|----------|-------|------------|
| COMM0 hi | $A15120 | $20004020 | Command flag (68K→SH2) | ✅ Confirmed |
| COMM0 lo | $A15121 | $20004021 | Command code ($22, $25, $27, etc.) | ✅ Confirmed |
| COMM1 | $A15122 | $20004022 | **Slave command byte** - Slave polls this | ✅ Confirmed |
| COMM3 | $A15126 | $20004026 | Slave status ("OVRN" marker) | ✅ Confirmed |
| COMM4+5 | $A15128 | $20004028 | 32-bit data pointer (68K→SH2) | ✅ Confirmed |
| COMM6 | $A1512C | $2000402C | Handshake flag ($0101 = ready) | ✅ Confirmed |
| COMM7 | $A1512E | $2000402E | Master→Slave signal (expansion ROM) | ✅ Mod uses |

**Slave COMM1 Protocol (✅ Disassembled):**

The Slave SH2 runs a command dispatcher loop at SDRAM `$06000592`:

```
1. Read COMM1 byte ($20004022)
2. If COMM1 == 0: No work → enter delay loop ($06000608)
3. If COMM1 != 0: Dispatch to handler via jump table ($060005C8)
4. Loop back to step 1
```

The delay loop burns 64 cycles before rechecking COMM1. Profiling shows **66.5% of Slave cycles** spent in this loop - confirming architectural underutilization.

See: [slave_command_dispatcher.asm](../disasm/sh2/3d_engine/slave_command_dispatcher.asm)

### v2.3+ Protocol Additions (Expansion ROM)

| Register | 68K Addr | Expansion ROM Usage |
|----------|----------|---------------------|
| COMM5 | $A1512A | Vertex transform counter (+101 per call) |
| COMM7 | $A1512E | Master→Slave signal (0x16 = work, 0x00 = idle) |

See [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) for validated synchronization protocol details.

---

## 68K Functions That Communicate with SH2 (✅ Confirmed)

### Command Submission (✅ Disassembled - see [sh2_communication.asm](../disasm/modules/68k/sh2/sh2_communication.asm))

| Address | Name | Description |
|---------|------|-------------|
| $00E316 | `sh2_send_cmd_wait` | Wait for ready, send command (1 blocking loop) |
| $00E35A | `sh2_send_cmd` | Direct command send (3 blocking loops) |
| $00E342 | `sh2_wait_response` | Poll COMM6 for SH2 response |
| $00E3B4 | `sh2_cmd_27` | Graphics command $27 |
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
| $06000608 | $020608 | `slave_delay_loop` | Idle state (64-cycle delay) |
| $0600060A | $02060A | *(delay NOP)* | **66.5% of Slave cycles** (profiler hotspot) |
| $02220694 | $020694 | *(unused)* | "OVRN" marker write (fallback idle) |

**Profiler Confirmation:** PC-level profiling shows the Slave spends 66.5% of its cycles at `$0600060A` (the NOP inside the delay loop), confirming the Slave is **architecturally underutilized** - it has no rendering work to do.

See: [slave_command_dispatcher.asm](../disasm/sh2/3d_engine/slave_command_dispatcher.asm)
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

- [sh2_communication.asm](../disasm/modules/68k/sh2/sh2_communication.asm) - **Annotated disassembly of blocking comm functions**
- [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) - Parallel processing infrastructure
- [DATA_STRUCTURES.md](architecture/DATA_STRUCTURES.md) - Memory maps and data structures
- [STATE_MACHINES.md](architecture/STATE_MACHINES.md) - Game state machines
- [VINT_HANDLER_ARCHITECTURE.md](architecture/VINT_HANDLER_ARCHITECTURE.md) - V-INT handler details
- [68K_FUNCTION_REFERENCE.md](68K_FUNCTION_REFERENCE.md) - Complete 68K function catalog
- [SH2_SYMBOL_MAP.md](../disasm/SH2_SYMBOL_MAP.md) - SH2 function symbols

---

**Document Status:** Reference document
**Confidence:** High - COMM register mapping confirmed, command functions disassembled
**Last Updated:** 2026-02-01 (COMM register table corrected per hardware manual)
