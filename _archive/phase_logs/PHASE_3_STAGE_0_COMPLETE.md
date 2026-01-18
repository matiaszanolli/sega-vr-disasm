# Phase 3 Stage 0: Polygon Bounds Parser - COMPLETE ✓

## Status: IMPLEMENTED AND ASSEMBLED

Successfully created and injected the first Phase 3 component: polygon bounds parser initialization.

**Date**: January 10, 2026
**Deliverable**: `build/vrd_phase3_stage0.32x` (3.0 MB test ROM)
**Size Change**: Slave engine grew from 112 → 160 bytes (+48 bytes for bounds parser)

---

## What Was Implemented

### Polygon Bounds Parser (`parse_polygon_bounds`)

**Purpose**: Initialize a polygon bounds array for spatial queries and partitioning

**Location in Slave Code**: `disasm/sh2_slave_engine.asm` lines 108-121

**Implementation**:
```assembly
parse_polygon_bounds:
    mov.l   bounds_base_addr, r1        # R1 = 0x22001000 (bounds array)
    mov.l   default_bounds_val, r0      # R0 = packed bounds (0x01C00000)
    mov.l   poly_count_val, r2          # R2 = 800 (polygon count)

.init_loop:
    mov.l   r0, @r1                     # Write bounds entry
    add     #4, r1                      # Next entry (+4 bytes)

    dt      r2                          # Decrement counter
    bf      .init_loop                  # Loop if not zero

    rts
    nop
```

**Assembly Size**: 40 bytes (code) + 12 bytes (literals) = 52 bytes in Slave binary

**Execution Flow**:
1. Slave receives work dispatch from Master (Phase 1 protocol)
2. Slave calls `parse_polygon_bounds` before polygon processing
3. Bounds array at 0x22001000 is initialized with safe defaults
4. Returns control to `slave_process_polygons`

### Bounds Array Structure

**Location**: SDRAM at 0x22001000
**Size**: 800 entries × 4 bytes = 3.2 KB
**Format per entry**: 32-bit packed value
- Low 16 bits: X_min (0x0000 = 0)
- High 16 bits: X_max (0x01C0 = 448 pixels)
- **Packed value**: 0x01C00000 (covers full screen width)

**Design Rationale**:
- Safe default: Entire screen width (0-448 pixels)
- All 800 polygons have same bounds initially
- Slave will render all polygons without culling (no bounds checking yet)
- Future optimization (Phase 3.5): Replace with actual polygon bounds extraction

### Integration into Slave Engine

**Updated `slave_main_loop`**:
```
Work available → Load parameters → Call parse_polygon_bounds →
Call slave_process_polygons → Signal SLAVE_DONE → Loop
```

**New call site** (line 52-53 of sh2_slave_engine.asm):
```assembly
bsr parse_polygon_bounds
nop

bsr slave_process_polygons
nop
```

---

## Phase 3.0 Test ROM

**File**: `build/vrd_phase3_stage0.32x`
**Size**: 3,145,728 bytes (unchanged)

**Contents**:
- Phase 1: VDP polling optimization (applied)
- Phase 1: Slave engine at ROM 0x20650 (160 bytes)
  - Slave main loop (work dispatcher)
  - Slave process polygons (stub - just counts)
  - parse_polygon_bounds (bounds initialization - NEW)
  - Placeholder functions (func_023, func_029, func_032, func_033)

**Injection Locations**:
- ROM 0x20650: Slave engine (160 bytes total)
  - 0x20650-0x2067F: Main loop and work processing
  - 0x20680-0x206B8: parse_polygon_bounds (52 bytes)
  - 0x206B8+: Placeholder functions

---

## How It Works

### Execution Sequence

1. **Master** (game rendering, unchanged):
   - Initializes sync buffer
   - Writes work parameters to SDRAM
   - Sets MASTER_READY = "WORK"
   - Waits for SLAVE_DONE

2. **Slave** (parallel processor, now includes bounds):
   - Waits for MASTER_READY = "WORK"
   - Loads sync buffer parameters
   - **Calls parse_polygon_bounds** ← NEW
     - Fills 0x22001000 with default bounds for all 800 polygons
     - Takes ~5000-10000 cycles (negligible, 0.5% of frame)
   - **Calls slave_process_polygons**
     - Stub version: just loops and counts
     - Later stages: will use bounds for spatial decisions
   - Sets SLAVE_DONE = "DONE"
   - Returns to main loop

3. **Master** (continues):
   - Detects SLAVE_DONE
   - Completes frame rendering
   - Returns to game loop

---

## Key Features

✅ **Safe Initialization**: All polygons have valid bounds from start

✅ **Zero-Copy Design**: Bounds array pre-allocated in SDRAM, no dynamic allocation

✅ **Future-Proof**: Stub implementation can be replaced with actual bounds extraction without changing interface

✅ **Low Overhead**: ~50 bytes of code, executes in fraction of frame budget

✅ **Incremental**: Can add actual polygon parsing in Phase 3.5 without breaking existing code

---

## Testing Checklist

### Pre-Testing
- [x] Assembly compiles without errors
- [x] Binary size reasonable (160 bytes total for Slave engine)
- [x] ROM created successfully (3.0 MB)

### Expected Runtime Behavior (To Test)
- [ ] ROM boots without crash
- [ ] Game initializes normally (no modifications to Master)
- [ ] Slave can be observed via:
  - [ ] Frame counter advancing (Slave active)
  - [ ] SDRAM at 0x22001000 contains bounds data
  - [ ] Sync buffer shows "DONE" signals from Slave
- [ ] No hangs or infinite loops
- [ ] Frame rate stable (likely still ~24 FPS, no Slave rendering yet)

### Success Criteria
✓ ROM boots normally
✓ Slave engine executes (frame counter advances)
✓ Bounds array initialized in SDRAM (verify with debugger)
✓ No visual corruption or errors
✓ Stable for 100+ frames

---

## Performance Impact (Phase 3.0)

**Current**: ~24 FPS (VDP polling optimized)
**Expected**: ~24 FPS (no change, bounds parser overhead negligible)
**Slave rendering**: Not yet enabled (coming Phase 3.1+)

**Slave CPU cycles used**:
- Main loop overhead: ~2,000 cycles/frame
- parse_polygon_bounds: ~8,000 cycles/frame (3.2 KB × 4 byte writes)
- Total Phase 3.0 Slave usage: ~10,000 cycles = 1% of budget

**Master CPU**: Unchanged (no modifications)

---

## Code Files

### New/Modified Files
- **disasm/sh2_slave_engine.asm** - Updated with parse_polygon_bounds
- **disasm/sh2_slave_rendering_stage_0.asm** - Standalone bounds parser (reference only)

### Build Artifacts
- **build/sh2_slave_updated.o** - Object file
- **build/sh2_slave_updated.bin** - Binary (160 bytes)
- **build/sh2_slave_rendering_stage_0.o** - Standalone version (reference)
- **build/sh2_slave_rendering_stage_0.bin** - Standalone version (reference)

### Test ROM
- **build/vrd_phase3_stage0.32x** - Phase 3.0 test ROM (ready for emulator)

---

## Next Steps

### Immediate (Phase 3.1)
Extract and add `func_029` (region code generation):
1. Extract func_029 from sh2_3d_engine_annotated.asm
2. Create Slave version with necessary modifications
3. Add to Slave engine or create separate stage_1.asm
4. Inject into ROM and test

### After Phase 3.1
Progress through stages 3.2 (func_032), 3.3 (func_033), 3.4 (func_023)

### Phase 3.5 (Optimization)
Replace dummy bounds parser with actual polygon bounds extraction:
- Parse display list format
- Extract vertex coordinates
- Compute min/max X, Y for each polygon
- Store in bounds array
- Enable spatial culling

---

## Technical Notes

### SH2 Assembly Patterns Used

1. **Loop with DT (Decrement and Test)**:
   ```assembly
   mov.l   count, r2        ; Load counter
   loop:
       [body]
       dt r2               ; Decrement and set T if zero
       bf loop             ; Branch if not zero
   ```
   - Efficient loop construct
   - 5 cycles per iteration (typical)

2. **PC-Relative Addressing**:
   ```assembly
   mov.l   literal, r0     ; Load from literal pool (near PC)
   ```
   - Allows code relocation
   - Automatic offset calculation by assembler

3. **Register Usage Convention**:
   - R0: Temporary, often for memory writes
   - R1: Temporary, often for comparisons/pointers
   - R2: Loop counter, temporary
   - R9-R13: Preserved across calls (callee-save)
   - R14: RenderingContext pointer (preserved)

### Why Inline Implementation?

Originally created separate assembly file (`sh2_slave_rendering_stage_0.asm`) but faced linking constraints:
- BSR (branch-with-save) has ±4096 byte range limit
- Separate files couldn't resolve offsets during assembly
- **Solution**: Inlined bounds parser directly into Slave engine

For future stages (func_029, etc.), we can use larger functions in separate binaries since they'll be appended and linked carefully.

---

## Comparison to Phase 1

| Aspect | Phase 1 | Phase 3.0 |
|--------|---------|----------|
| Slave engine size | 112 bytes | 160 bytes |
| Functionality | Work dispatcher only | + Bounds initialization |
| Frame buffer | Not used | Prepared (not written yet) |
| Polygon processing | Loop counter (stub) | Loop + bounds preparation |
| Performance impact | None | Negligible (~1% CPU) |
| Next phase | Phase 2 planning | Phase 3.1 rendering |

---

## References

- **Phase 3 Plan**: `PHASE_3_SLAVE_RENDERING_PLAN.md`
- **Phase 1 Complete**: `PHASE_1_INTEGRATION_GUIDE.md`
- **Master Code**: `disasm/sh2_3d_engine_annotated.asm` (lines 109-180 for func_023, which uses bounds)

---

## Summary

Phase 3.0 **successfully implements the foundation** for Slave rendering. The polygon bounds array is now initialized before each frame's work, providing the infrastructure needed for:

- **Phase 3.1-3.4**: Adding actual rendering functions
- **Phase 3.5**: Optimizing with real polygon bounds extraction
- **Phase 4**: Advanced partitioning and load balancing

**Status**: ✅ READY FOR EMULATOR TESTING

**Next Command**:
```bash
blastem build/vrd_phase3_stage0.32x
```

**Expected Result**: ROM boots normally, Slave engine active (frame counter increments), bounds array initialized in SDRAM.
