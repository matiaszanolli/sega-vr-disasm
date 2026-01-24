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

| 68K Address | SH2 Address | Name | Width |
|-------------|-------------|------|-------|
| $A15120 | $20004020 | COMM0 | 16-bit (68K) / 32-bit (SH2) |
| $A15122 | $20004020 | COMM0 (low) | 16-bit |
| $A15124 | $20004024 | COMM1 | 16-bit / 32-bit |
| $A15126 | $20004024 | COMM1 (low) | 16-bit |
| $A15128 | $20004028 | COMM2 | 16-bit / 32-bit |
| $A1512A | $20004028 | COMM2 (low) | 16-bit |
| $A1512C | $2000402C | COMM3 | 16-bit / 32-bit |
| $A1512E | $2000402C | COMM3 (low) | 16-bit |
| $A15130 | $20004030 | COMM4 | 16-bit / 32-bit |
| $A15132 | $20004030 | COMM4 (low) | 16-bit |
| $A15134 | $20004034 | COMM5 | 16-bit / 32-bit |
| $A15136 | $20004034 | COMM5 (low) | 16-bit |
| $A15138 | $20004038 | COMM6 | 16-bit / 32-bit |
| $A1513A | $20004038 | COMM6 (low) | 16-bit |
| $A1513C | $2000403C | COMM7 | 16-bit / 32-bit |
| $A1513E | $2000403C | COMM7 (low) | 16-bit |

**Width note:** SH2 reads/writes longwords (32-bit) at even-numbered addresses above. 68K accesses as word pairs. Writing COMM0 from 68K affects only the upper 16 bits of SH2's longword view.

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

### Original Game (📋 Inferred from code patterns)

| Register | Observed Usage |
|----------|----------------|
| COMM0 | 68K→SH2 command (inferred: RENDER_FRAME) |
| COMM1 | Display list address (inferred from 68K writes) |
| COMM2 | Work status flags (inferred) |
| COMM3 | Slave status ("OVRN" loop, ✅ confirmed in ROM at $20694) |
| COMM4-7 | Unused by original game |

### v2.3 Protocol Additions (✅ Validated)

| Register | v2.3 Usage |
|----------|------------|
| COMM4 | Slave frame counter (incremented by handler) |
| COMM6 | Master→Slave signal (0x0012 = work, 0x0000 = idle) |

See [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) for validated synchronization protocol details.

---

## 68K Functions That Communicate with SH2 (📋 Inferred)

### Command Submission

| Address | Name | Description |
|---------|------|-------------|
| $00E316 | `sh2_send_cmd_wait` | Wait for ready, send command |
| $00E35A | `sh2_send_cmd` | Direct command send |
| $00E342 | `sh2_wait_response` | Poll for SH2 response |
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

### Slave SH2 (Original Game)

| Address | Description |
|---------|-------------|
| $02220694 | Idle loop - writes "OVRN" to COMM3 repeatedly |

The Slave is **largely idle** during 3D rendering. See [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) for analysis.

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

- [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) - **v2.3 validated sync protocol**
- [DATA_STRUCTURES.md](architecture/DATA_STRUCTURES.md) - Memory maps and data structures
- [STATE_MACHINES.md](architecture/STATE_MACHINES.md) - Game state machines
- [VINT_HANDLER_ARCHITECTURE.md](architecture/VINT_HANDLER_ARCHITECTURE.md) - V-INT handler details
- [68K_FUNCTION_REFERENCE.md](68K_FUNCTION_REFERENCE.md) - Complete 68K function catalog
- [SH2_SYMBOL_MAP.md](../disasm/SH2_SYMBOL_MAP.md) - SH2 function symbols

---

**Document Status:** Reference document
**Confidence:** Mixed - see ✅/📋 markers per section
**Last Updated:** 2026-01-24
