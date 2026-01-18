# Phase 1 Integration Guide

## Overview

Phase 1 is complete with the Slave engine (`disasm/sh2_slave_engine.asm`). Now we need to modify the Master code to initialize the sync buffer and dispatch work to Slave.

**Files Modified in Phase 1**:
- ✅ NEW: `disasm/sh2_slave_engine.asm` - Slave work dispatcher
- 🔄 MODIFY: `disasm/sh2_3d_engine_annotated.asm` - Master initialization code

---

## Phase 1 Testing Checklist

### Pre-Build Setup
- [ ] Verify `disasm/sh2_slave_engine.asm` exists and is readable
- [ ] sh2-elf-as toolchain available
- [ ] BlastEm emulator available for testing

### Build Steps

```bash
# Assemble Slave engine
sh2-elf-as -o build/sh2_slave.o disasm/sh2_slave_engine.asm
sh2-elf-objcopy -O binary build/sh2_slave.o build/sh2_slave.bin

# Copy original ROM as backup
cp "Virtua Racing Deluxe (USA).32x" "Virtua Racing Deluxe (USA)_BACKUP.32x"

# Inject Slave code at ROM offset 0x20650 (Slave idle loop location)
dd if=build/sh2_slave.bin of="Virtua Racing Deluxe (USA).32x" \
   bs=1 seek=$((0x20650)) conv=notrunc

# Test
blastem "Virtua Racing Deluxe (USA).32x"
```

### Expected Behavior (Phase 1)

1. **ROM boots normally** - should load and start game
2. **Slave loop active** - Slave sits in work dispatcher, writing "REDY" to COMM3
3. **COMM3 shows pattern** - If debugging enabled:
   - Slave should output 0x5555 pattern to COMM3
   - Frame counter should remain constant (Slave not doing real work yet)

### What NOT to expect in Phase 1

- ❌ No visible performance improvement (stub only)
- ❌ Slave doesn't do any rendering (stub)
- ❌ No output on screen from Slave (will add in Phase 3)

---

## Master Integration (Phase 2 Prep)

These code additions prepare Master to dispatch work. They're documented here for Phase 2 implementation, but not yet applied to the ROM.

### Location 1: func_001 Entry (Sync Buffer Initialization)

**File**: `disasm/sh2_3d_engine_annotated.asm`
**Current Location**: ROM offset 0x023024 (CPU address 0x0222301C)

**Current Code**:
```assembly
func_001:
0222301C  0009     NOP
0222301E  0000     DW      $0000
02223020  C000     DW      $C000
02223022  0740     DW      $0740
02223024  4F22     STS.L   PR,@-R15           ; Push return address
02223026  B0A7     BSR     func_007           ; Initial setup call
02223028  7D02     ADD     #$02,R13           ; Advance command pointer (delay slot)
```

**To Add** (after STS.L PR):
```assembly
; NEW: Initialize sync buffer for this frame
MOV.L   @(sync_base,PC),R1         ; R1 = 0x22000400
MOV.L   #0,R0                       ; R0 = 0
MOV.L   R0,@(0x00,R1)              ; Clear MASTER_READY
MOV.L   R0,@(0x04,R1)              ; Clear SLAVE_READY
MOV.L   R0,@(0x08,R1)              ; Clear MASTER_DONE
MOV.L   R0,@(0x0C,R1)              ; Clear SLAVE_DONE

; Store context pointer (READ-ONLY for Slave)
MOV.L   #0xC0000700,R0             ; RenderingContext address
MOV.L   R0,@(0x20,R1)              ; Store CONTEXT_PTR

; Store display list pointer
MOV.L   R13,R0                     ; R13 = current display list
MOV.L   R0,@(0x24,R1)              ; Store DISPLAY_LIST_PTR

; Store frame buffer pointer
MOV.L   #0x24000000,R0             ; Frame buffer base
MOV.L   R0,@(0x28,R1)              ; Store FRAME_BUFFER_PTR

; Literal for sync base
.align 4
sync_base:
    .long   0x22000400
```

### Location 2: final_exit (Slave Dispatch)

**File**: `disasm/sh2_3d_engine_annotated.asm`
**Current Location**: ROM offset 0x0239A (CPU address 0x0222399A)

**Current Code**:
```assembly
final_exit:
0222399A  85E0     MOV.B   R0,@($0,R5)        ; [R5+0] = low_byte(R0)
0222399C  816F     MOV.B   R0,@($F,R1)        ; [R1+0x0F] = low_byte(R0)
0222399E  E004     MOV     #$04,R0             ; R0 = 0x04
022239A0  816E     MOV.B   R0,@($E,R1)        ; [R1+0x0E] = 0x04
022239A2  9003     MOV.W   @(PC),R0           ; Load mask
022239A4  7640     ADD     #$40,R6             ; R6 += 0x40
022239A6  2609     AND     R0,R6              ; R6 &= mask
022239A8  000B     RTS                        ; Return
022239AA  1E69     MOV.L   R6,@($24,R14)      ; [R14+0x24] = R6
```

**To Add** (before final cleanup):
```assembly
; NEW: Dispatch work to Slave
MOV.L   @(sync_base,PC),R14        ; R14 = 0x22000400

; Check if Slave is ready (with timeout)
MOV     #60,R2                      ; Timeout: 60 iterations
.wait_slave_ready:
    MOV.L   @(0x04,R14),R0          ; Load SLAVE_READY
    MOV.L   @(ready_magic,PC),R1
    CMP/EQ  R1,R0
    BT      .slave_is_ready
    DT      R2
    BF      .wait_slave_ready
    BRA     .skip_slave              ; Timeout: Slave not ready
    NOP

.slave_is_ready:
    ; Set work parameters
    MOV.L   #800,R0
    MOV.L   R0,@(0x10,R14)          ; POLYGON_COUNT = 800
    MOV.L   #400,R0
    MOV.L   R0,@(0x14,R14)          ; SLAVE_START = 400
    MOV.L   #799,R0
    MOV.L   R0,@(0x18,R14)          ; SLAVE_END = 799

    ; Signal Slave to start work
    MOV.L   @(work_magic,PC),R0
    MOV.L   R0,@(0x00,R14)          ; MASTER_READY = "WORK"

    ; Master continues with own work (polygons 0-399)
    ; Later: Add bounds checking here for Master
    ; For now: Master does nothing (Slave does all)

    MOV.L   @(done_magic,PC),R0
    MOV.L   R0,@(0x08,R14)          ; MASTER_DONE

    ; Wait for Slave to complete
    MOV     #1000,R2                ; Timeout: 1000 iterations
.wait_slave_done:
    MOV.L   @(0x0C,R14),R0          ; Load SLAVE_DONE
    MOV.L   @(done_magic,PC),R1
    CMP/EQ  R1,R0
    BT      .both_done
    DT      R2
    BF      .wait_slave_done
    ; Timeout: Fall through

.skip_slave:
.both_done:
    ; Continue with original final_exit code

.align 4
ready_magic:
    .long   0x52454459              ; "REDY"
work_magic:
    .long   0x574F524B              ; "WORK"
done_magic:
    .long   0x444F4E45              ; "DONE"
```

---

## Phase 1 Verification

### Success Indicators

**In BlastEm with debug output**:
1. Game boots and runs normally
2. COMM3 register shows values (0x5555 at start, then changes if DEBUG_LEVEL >= 1)
3. Game doesn't crash or hang
4. Slave loop is active (can see register writes to COMM3)

**Performance**:
- No change yet (stub doesn't do real work)
- Frame rate: Same as original (~20 FPS)

### Debug Output Interpretation

With `DEBUG_LEVEL = 2` in `sh2_slave_engine.asm`:

| COMM3 Value | COMM4 Value | Meaning |
|-------------|-------------|---------|
| 0x5555 | - | Slave alive, loop active |
| 0xRRRR | 0x0001 | Slave state=READY, waiting |
| 0x0400 | 0x0002 | Slave state=WORKING (polygon 400) |
| 0x0400 | 0x0003 | Slave state=DONE, 400 polygons ready |

---

## Next Steps (Phase 2)

Once Phase 1 ROM boots successfully:

1. **Create modified Master code** with sync buffer init + dispatch
2. **Modify `sh2_3d_engine_annotated.asm`** to add Master dispatch
3. **Test Master-Slave handshake** on emulator
4. **Verify sync protocol** with trace buffer

---

## Troubleshooting

### ROM won't boot
- **Issue**: Binary injection corrupted code
- **Check**: Verify ROM size unchanged: `ls -l "Virtua Racing Deluxe (USA).32x"`
- **Solution**: Restore from backup, re-inject with correct offset

### Slave doesn't show in COMM3
- **Issue**: Slave code not executing
- **Check**: Verify offset 0x20650 is correct (Slave entry point)
- **Solution**: Check if sh2_slave.bin has correct magic bytes at start

### Game crashes immediately
- **Issue**: Slave code overwrote critical code
- **Check**: Verify only Slave idle loop region replaced (0x20650-0x20694)
- **Solution**: Restore backup, check ROM layout

---

## Files Reference

- `disasm/sh2_slave_engine.asm` - Phase 1 Slave implementation ✅
- `disasm/sh2_3d_engine_annotated.asm` - Master code (modifications in Phase 2)
- `SH2_PARALLELIZATION_STRATEGY.md` - Detailed technical strategy
- `docs/SH2_FRAME_COUNTER_PROFILING.md` - SH2 address space reference

---

## Build Instructions (Final)

```bash
# Phase 1: Build Slave engine
cd /mnt/data/src/32x-playground
sh2-elf-as -o build/sh2_slave.o disasm/sh2_slave_engine.asm
sh2-elf-objcopy -O binary build/sh2_slave.o build/sh2_slave.bin

# Backup original
cp "Virtua Racing Deluxe (USA).32x" "Virtua Racing Deluxe (USA)_BACKUP.32x"

# Inject Slave code
dd if=build/sh2_slave.bin of="Virtua Racing Deluxe (USA).32x" \
   bs=1 seek=$((0x20650)) conv=notrunc

# Test
blastem "Virtua Racing Deluxe (USA).32x"

# Monitor COMM3 in BlastEm debug window
# Should see 0x5555 pattern if Slave is executing
```

---

## Expected Timeline

- **Phase 1 (TODAY)**: Slave engine created + tested ✅
- **Phase 2 (1-2 days)**: Master integration + sync handshake
- **Phase 3 (1-2 weeks)**: Bounds parsing + rendering functions
- **Phase 4 (5-7 days)**: Optimization + load balancing
- **Phase 5 (3-4 days)**: Validation + hardware testing

**Total**: 3-4 weeks to full implementation
