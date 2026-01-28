# Virtua Racing Deluxe - Data Structure Reference

This document consolidates all known data structures used by the 68K and SH2 CPUs.

**Confidence Levels:**
- ✅ **Confirmed** - Verified from ROM analysis or hardware documentation
- 📋 **Inferred** - Derived from code patterns, not directly verified
- ❓ **Hypothetical** - Educated guess based on typical game engine patterns

---

## Memory Map Overview

### 68K Address Space (✅ Confirmed)

| Range | Size | Description |
|-------|------|-------------|
| $000000-$3FFFFF | 4MB | ROM (cartridge) |
| $840000-$87FFFF | 256KB | 32X Frame Buffers (2×128KB) - **requires FM=0** |
| $880000-$8FFFFF | 512KB | ROM Cartridge mirror ($000000-$07FFFF, 4Mbit fixed) |
| $900000-$9FFFFF | 1MB | ROM Cartridge bank-switched (32Mbit÷4 banks via Bank Set Register) |
| $A00000-$A0FFFF | 64KB | Z80 Sound RAM |
| $A10000-$A1001F | 32B | Genesis I/O ports |
| $A15100-$A152FF | 512B | 32X System Registers |
| $A15120-$A1512F | 16B | COMM Registers (68K side) |
| $C00000-$C0001F | 32B | VDP Registers |
| $FF0000-$FFFFFF | 64KB | 68K Work RAM |

### SH2 Address Space (✅ Confirmed per Hardware Manual)

| Range | Size | Description | Cache |
|-------|------|-------------|-------|
| $00000000-$00000FFF | 4KB (📋) | SH2 Internal Boot ROM (size varies by SH2 model) | - |
| $00004000-$000040FF | 256B | SH2 System Registers | - |
| $00004100-$000041FF | 256B | VDP Registers | - |
| $00004200-$000043FF | 512B | Color Palette | - |
| **$02000000-$0203FFFF** | **256KB** | **SDRAM** | Cached |
| $04000000-$0401FFFF | 128KB | Cartridge ROM (per hardware manual §3.2) | Cached |
| $04020000-$0403FFFF | 128KB | Frame Buffer - **requires FM=1** (per manual) | Cached |
| $04040000-$0405FFFF | 128KB | Overwrite Image - **requires FM=1** (per manual) | Cached |
| **$22000000-$2203FFFF** | **256KB** | **SDRAM (cache-through)** | Bypass |
| $20004000-$200040FF | 256B | System Registers (cache-through) | Bypass |
| $24000000-$2401FFFF | 128KB | Cartridge ROM (cache-through) | Bypass |
| $24020000-$2403FFFF | 128KB | Frame Buffer (cache-through) - **requires FM=1** | Bypass |

**FM Bit (VDP Access Authorization):**
- FM=0 (default): Only 68K can access frame buffer, overwrite image, VDP registers, color palette
- FM=1: Only SH2 can access these regions
- When wrong FM state: reads return undefined, writes are ignored

**Cache notes:**
- Addresses $0X000000 use cache; $2X000000 bypass cache
- **Critical for inter-CPU sharing:** Use cache-through ($22000000) for data shared between Master/Slave
- **COMM register width:** SH2 reads/writes longwords (32-bit); 68K uses word pairs (16-bit). Writing COMM0 from 68K affects only the upper 16 bits of the SH2's longword view.

**⚠️ Address Discrepancy:** The project's MEMORY_MAP.md and Phase 11 code use $06000000 for SDRAM (observed: Slave hook injected at 0x06000596 in PicoDrive). The hardware manual shows $06000000 as undefined. This may be an emulator-specific alias or undocumented hardware behavior. Use $02000000/$22000000 for portable code.

### Unknown: 0xC0000XXX Addresses (❓ Hypothetical)

The 3D transform code uses addresses like `0xC0000740`, `0xC0000760`. These are **not standard 32X mappings**.

Possible explanations:
- Undocumented hardware alias
- Upper address bits decoded differently by 32X
- May map to SDRAM or frame buffer region

**Impact:** Cannot share transform buffers between CPUs without copying to cache-through region (0x22000XXX).

See [../sh2-analysis/SLAVE_INTEGRATION_RESEARCH.md](../sh2-analysis/SLAVE_INTEGRATION_RESEARCH.md) for cache-through staging strategies.

---

### Work RAM Layout ($FF0000-$FFFFFF) (📋 Inferred)

```
$FF0000-$FF5FFF: General work area (24KB)
$FF6000-$FF6FFF: Display/VDP state (4KB)
  $FF6950: Object flags
  $FF6960: Display state flag
  $FF68F0: Status code
  $FF68F8: Time display buffer (8 bytes)

$FF9000-$FF9FFF: Object tables (4KB)
  $FF9100: Object Table 1 (6 entries, hardware loop)
  $FF9700: Object Table 2 (8 entries, hardware loop)
  $FF9F00: Object Table 3 (1 entry, hardware loop)

$FFC000-$FFCFFF: Control state (4KB)
  $FFC0xx: System control parameters
  $FFC8xx: Game state machine indices
```

---

## State Machine Variables ($FFC000-$FFC9FF) (📋 Inferred)

See [STATE_MACHINES.md](STATE_MACHINES.md) for complete documentation.

| Address | Name | Range | Purpose |
|---------|------|-------|---------|
| $FFC048 | camera_state | 0-N | Camera mode |
| $FFC050 | scroll_state | 0-N | Scroll position |
| $FFC07C | input_state | 0-N | Controller state |
| $FFC082 | menu_state | 0-N | Menu navigation |
| $FFC084 | menu_substate | 0-N | Sub-menu state |
| $FFC0A2 | gfx_mode | 0-N | Graphics mode |
| $FFC0FA | timer_state | 0-N | Timer/countdown |
| $FFC87E | game_state | 0-60 | Main game state (×4) |
| $FFC89C | sh2_comm_state | 0-N | SH2 communication |
| $FFC89E | sh2_comm_sub | 0-N | Comm sub-state |
| $FFC8A0 | race_state | 0-N | Race phase |
| $FFC8AA | scene_state | 0-N | Scene transitions |
| $FFC80E | **[UNDOCUMENTED]** | varies | **RAM status byte** (tested by $010B2C, $010BAE) |
| $FFC8C8 | vint_state | 0-N | V-INT processing |
| $FFC8CC | race_substate | 0-N | Race sub-phase |
| **$FFC8D0** | **async_queue_start** | - | **Async command queue (Phase 1A)** ✅ |
| $FFC8D0 | pending_cmd_valid | 0-1 | 1=command pending in queue |
| $FFC8D2 | pending_cmd_type | 0-N | Command type ($27, etc.) |
| $FFC8D4 | pending_cmd_count | 0-N | Commands awaiting frame sync |
| $FFC8D6 | [reserved] | - | Alignment padding |
| $FFC8D8 | pending_cmd_params | - | Parameter storage (3 longs) |
| $FFC8E4 | total_cmds_async | 0-∞ | Total async commands issued (long) |
| $FFC8E8 | async_overflow_count | 0-N | Queue full events (word) |
| $FFC8EA | [reserved] | - | Alignment padding |
| $FFC8EC | total_wait_cycles | 0-∞ | Cumulative wait cycles (long) |
| $FFC8F0 | max_wait_cycles | 0-∞ | Peak wait cycles (long) |
| **$FFC8F4** | **async_queue_end** | - | **(36 bytes allocated)** ✅ |
| $FFC964 | frame_counter | 0-∞ | Frame count |
| $FFC972 | anim_state | 0-N | Animation state |

---

## Object Table Structure (📋 Inferred)

### Object Table 1 ($FF9100) - 6 Entries

Used by `func_6D9C` hardware loop. Likely main game objects (player car, etc.)

```
Offset  Size  Field              Confidence
------  ----  -----              ----------
$00     2     flags/type         📋 Inferred
$02     2     x_position         📋 Inferred
$04     2     y_position         📋 Inferred
$06     2     z_depth            📋 Inferred
$08     2     sprite_index       📋 Inferred
$0A     2     animation_frame    📋 Inferred
$0C     4     world_x            📋 Inferred (16.16 fixed)
$10     4     world_y            📋 Inferred (16.16 fixed)
$14     4     world_z            📋 Inferred (16.16 fixed)
$18     2     velocity           📋 Inferred
$1A     2     direction          📋 Inferred
$1C     4     [unknown]          ❓
------
Total: ~32 bytes per entry (estimated)
```

### Object Table 2 ($FF9700) - 8 Entries

Used by `func_6DC8` hardware loop. Secondary objects (opponent cars, items).

### Object Table 3 ($FF9F00) - 1 Entry

Used by `func_DF0` single-iteration loop. Special object (camera target, etc.)

---

## 32X Frame Buffer Format (✅ Confirmed)

### Memory Layout ($840000-$87FFFF)

```
$840000-$85FFFF: Frame Buffer 0 (128KB)
$860000-$87FFFF: Frame Buffer 1 (128KB)

Each frame buffer:
$xx0000-$xx01FF: Line Table (256 × 16-bit offsets)
$xx0200-$xxFFFF: Pixel Data
```

### Line Table Entry (✅ Confirmed)

```
Bits 15-0: Offset from frame buffer base to start of scanline
           Allows non-contiguous scanline storage for scrolling
```

### Pixel Format - Packed Pixel Mode (✅ Confirmed)

```
Each byte = 1 pixel (8-bit palette index)
Resolution: 320×224 = 71,680 bytes
```

### Palette Format ($A15200) (✅ Confirmed)

```
256 entries × 16-bit each
Bit 15:     Priority (1 = high priority over Genesis plane)
Bits 14-10: Blue (0-31)
Bits 9-5:   Green (0-31)
Bits 4-0:   Red (0-31)
```

---

## 68K-SH2 Communication Protocol

### COMM Registers (✅ Confirmed)

**68K Side ($A15120-$A1512F):**

| Address | Register | Size | Description |
|---------|----------|------|-------------|
| $A15120 | COMM0 | 16-bit | Command/status |
| $A15122 | COMM1 | 16-bit | Parameter 1 |
| $A15124 | COMM2 | 16-bit | Parameter 2 |
| $A15126 | COMM3 | 16-bit | Parameter 3 |
| $A15128 | COMM4 | 16-bit | Response 1 |
| $A1512A | COMM5 | 16-bit | Response 2 |
| $A1512C | COMM6 | 16-bit | Response 3 |
| $A1512E | COMM7 | 16-bit | Response 4 |

**SH2 Side ($20004020-$2000403F):**

| Address | Register | Original Game (📋 Inferred) | v2.3 Protocol (✅ Validated) |
|---------|----------|----------------------------|------------------------------|
| $20004020 | COMM0 | 68K→SH2 command (RENDER_FRAME=0x0001) | *unchanged* |
| $20004024 | COMM1 | Display list address | *unchanged* |
| $20004028 | COMM2 | Work status flags | *unchanged* |
| $2000402C | COMM3 | Slave writes "OVRN" in idle loop | *unchanged* |
| $20004030 | COMM4 | *Unused by original* | **Slave frame counter** |
| $20004034 | COMM5 | *Unused* | *unused* |
| $20004038 | COMM6 | *Unused by original* | **Master→Slave signal** (0x0012=work) |
| $2000403C | COMM7 | *Unused* | *unused* |

### Original Protocol Flow (📋 Inferred)

```
1. 68K writes command to COMM0/COMM1
2. 68K waits for SH2 response
3. Master SH2 reads COMM0/COMM1
4. Master SH2 processes command
5. Master SH2 writes response to COMM4/COMM5
6. 68K reads response
```

### v2.3 Synchronization Protocol (✅ Validated)

```
MASTER                              SLAVE
  |                                   |
  |-- Set COMM6 = 0x0012 ------------>|  (signal)
  |                                   |
  |                         Hook detects signal
  |                         Call handler @ 0x02300027
  |                         Increment COMM4
  |                         Clear COMM6 = 0x0000
  |                                   |
  |<-- COMM4 incremented -------------|  (acknowledge)
```

See [MASTER_SLAVE_ANALYSIS.md](MASTER_SLAVE_ANALYSIS.md) for complete v2.3 protocol documentation.

### Known Commands (📋 Inferred)

| COMM0 | COMM1 | Description |
|-------|-------|-------------|
| $0001 | addr | Render frame at display list address |
| $0002 | flags | Set render mode flags |
| $0003 | - | Frame sync |
| $FFFF | - | Reset/initialize |

---

## SH2 Rendering Structures

### Rendering Context (📋 Inferred, ~56 bytes)

Multiple registers point to context structures during rendering. Based on func_006/func_009/func_010 analysis:

**R14-based context (word operations):**
```
Offset  Size  Field               Evidence
------  ----  -----               --------
$02     2     [word field]        MOV.W @(2,R14),R0 in func_009/010
$06     2     [counter/index]     MOV.W @(6,R14),R0 / MOV.W R0,@(6,R14)
```

**R6-based context (func_006):**
```
Offset  Size  Field               Evidence
------  ----  -----               --------
$1C     4     scale_factor        MOV.L @(28,R6),R3 in func_006
```

**R10-based output (screen coordinates):**
```
Offset  Size  Field               Evidence
------  ----  -----               --------
$0C     2     screen_y            MOV.W R0,@(12,R10) in func_006
$0E     2     screen_x            MOV.W R0,@(14,R10) in func_006
```

**R11-based output buffer (func_009/010):**
```
Offset  Size  Field               Evidence
------  ----  -----               --------
$02     2     [header word]       MOV.W R0,@(2,R11)
$04     4     element[0]          MOV.L R0,@(4,R11)
$08     4     element[1]          MOV.L R1,@(8,R11)
$0C     4     element[2]          MOV.L R2,@(12,R11)
$10     4     element[3]          MOV.L R3,@(16,R11) (func_009 only)
```

**Note:** The original generic "SH2 Rendering Context" structure documented below may not match actual code. The above is derived from func_006/009/010 disassembly.

### Generic Rendering Context (❓ Hypothetical, 56 bytes)

This structure is **hypothetical** - may not match actual game code:

```
Offset  Size  Field               Notes
------  ----  -----               -----
$00     4     callback_ptr        Subroutine address
$04     4     display_list_ptr    Current display list
$08     4     vertex_buffer_ptr   Output vertex buffer
$0C     4     work_buffer_ptr     Temporary calculations
$10     4     frame_buffer_ptr    Target frame buffer
$14     4     depth_buffer_ptr    Z-buffer (if used)
$18     4     matrix_ptr          Current transform matrix
$1C     4     light_vector_ptr    Lighting direction
$20     4     polygon_count       Number of polygons
$24     4     vertex_count        Number of vertices
$28     4     render_flags        Mode flags
$2C     4     clip_planes         Near/far clip values
$30     4     screen_width        Viewport width
$34     4     screen_height       Viewport height
```

---

## Transformation Matrix (✅ Confirmed, 64 bytes)

4×4 matrix in 16.16 fixed-point format. Standard 3D graphics layout.

```
        | M00  M01  M02  M03 |
Matrix =| M10  M11  M12  M13 |
        | M20  M21  M22  M23 |
        | M30  M31  M32  M33 |

Offset  Field    Usage
------  -----    -----
$00     M00      Scale X / Rotation
$04     M01      Rotation
$08     M02      Rotation
$0C     M03      Translation X
$10     M10      Rotation
$14     M11      Scale Y / Rotation
$18     M12      Rotation
$1C     M13      Translation Y
$20     M20      Rotation
$24     M21      Rotation
$28     M22      Scale Z / Rotation
$2C     M23      Translation Z
$30     M30      Perspective
$34     M31      Perspective
$38     M32      Perspective
$3C     M33      W (usually 1.0 = 0x00010000)
```

---

## Polygon Descriptor (📋 Inferred, 20 bytes)

```
Offset  Size  Field
------  ----  -----
$00     2     flags           (bit 0: active, bits 1-3: type)
$02     2     vertex_count    (3 or 4)
$04     2     vertex_idx[0]   Index into vertex buffer
$06     2     vertex_idx[1]
$08     2     vertex_idx[2]
$0A     2     vertex_idx[3]   (quads only)
$0C     4     color           ARGB or palette index
$10     4     texture_id      Texture reference
```

### Polygon Types (📋 Inferred)

| Type | Value | Description |
|------|-------|-------------|
| Flat Triangle | 0 | Single color, 3 vertices |
| Gouraud Triangle | 1 | Vertex colors, 3 vertices |
| Flat Quad | 2 | Single color, 4 vertices |
| Gouraud Quad | 3 | Vertex colors, 4 vertices |
| Textured Triangle | 4 | UV mapped, 3 vertices |
| Textured Quad | 5 | UV mapped, 4 vertices |

---

## Vertex Structure (📋 Inferred)

### Input Vertex (model space, 32 bytes)

```
Offset  Size  Field
------  ----  -----
$00     4     x           16.16 fixed-point
$04     4     y           16.16 fixed-point
$08     4     z           16.16 fixed-point
$0C     4     w           1.0 (homogeneous)
$10     4     nx          Normal X (for lighting)
$14     4     ny          Normal Y
$18     4     nz          Normal Z
$1C     4     color       Vertex color (Gouraud)
```

### Output Vertex (screen space, ~52 bytes)

```
Offset  Size  Field
------  ----  -----
$00     4     screen_x    Screen X (16.16)
$04     4     screen_y    Screen Y (16.16)
$08     4     depth       Z-depth for sorting
$0C     4     w_recip     1/W for perspective
$10     4     color       Computed vertex color
$14-$34 32    [extended]  UV coords, flags, etc.
```

---

## Track Data Format (❓ Hypothetical)

**Warning:** This section is highly speculative, based on typical racing game patterns.

### Track Header (❓ Hypothetical)

```
Offset  Size  Field
------  ----  -----
$00     4     track_id
$04     4     segment_count
$08     4     waypoint_ptr
$0C     4     geometry_ptr
$10     4     texture_ptr
$14     4     palette_ptr
$18     4     object_ptr      (trackside objects)
$1C     4     collision_ptr
```

### Track Segment (❓ Hypothetical)

```
Offset  Size  Field
------  ----  -----
$00     4     start_distance
$04     4     length
$08     2     curvature       (signed: - = left, + = right)
$0A     2     elevation       (signed: - = down, + = up)
$0C     2     width
$0E     2     surface_type
$10     4     next_segment_ptr
```

---

## Related Documentation

- [STATE_MACHINES.md](STATE_MACHINES.md) - State machine details
- [MEMORY_MAP.md](MEMORY_MAP.md) - Complete memory map
- [MASTER_SLAVE_ANALYSIS.md](MASTER_SLAVE_ANALYSIS.md) - CPU synchronization and v2.3 protocol
- [../graphics-vdp/32X_FRAME_BUFFER_FORMAT.md](../graphics-vdp/32X_FRAME_BUFFER_FORMAT.md) - VDP details
- [../../disasm/SH2_SYMBOL_MAP.md](../../disasm/SH2_SYMBOL_MAP.md) - SH2 function symbols

---

**Document Status:** Reference document
**Confidence:** Mixed - see individual sections
**Last Updated:** 2026-01-23
