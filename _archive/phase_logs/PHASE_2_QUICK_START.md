# Phase 2 Quick Start: Minimal Master + Full Slave

## Objective

Test the Master-Slave sync protocol with a minimal Master dispatcher that delegates all polygon rendering to the Slave.

## Current Status

✅ Phase 1 Complete:
- Slave engine assembled and injected at ROM 0x20650
- 112 bytes of working Slave code
- ROM confirmed working: `build/vrd_vdp_optimized.32x`

✅ Phase 2 Preparation:
- Master sync functions created: `disasm/sh2_master_sync_phase2.asm` (144 bytes)
- Minimal Master dispatcher created: `disasm/sh2_master_minimal_dispatcher.asm` (128 bytes)
- Both tested and assembled successfully

## Phase 2 Test Implementation

### Step 1: Inject Master Sync Functions

Place the Master sync initialization and dispatch functions in ROM:

```bash
cd /mnt/data/src/32x-playground

# Assemble Master sync functions (if not already done)
sh-elf-as -o build/sh2_master_sync_phase2.o disasm/sh2_master_sync_phase2.asm
sh-elf-objcopy -O binary build/sh2_master_sync_phase2.o build/sh2_master_sync_phase2.bin

# Copy Phase 1 ROM to create Phase 2 test ROM
cp build/vrd_vdp_optimized.32x build/vrd_phase2_test.32x

# Inject Master sync functions after Slave engine (ROM offset 0x20750)
dd if=build/sh2_master_sync_phase2.bin of=build/vrd_phase2_test.32x \
   bs=1 seek=$((0x20750)) conv=notrunc
```

**Expected result**: No errors, file size unchanged (3.0 MB)

**Verification**:
```bash
ls -l build/vrd_phase2_test.32x
# Should show 3,145,728 bytes (same as input)
```

### Step 2: Inject Minimal Master Dispatcher

Replace the func_001 entry point with the minimal dispatcher:

```bash
# Inject at func_001 location (ROM offset 0x023024)
dd if=build/sh2_master_minimal_dispatcher.bin of=build/vrd_phase2_test.32x \
   bs=1 seek=$((0x023024)) conv=notrunc
```

**Note**: The minimal dispatcher is 128 bytes. It will overwrite the original func_001 code.

**Expected result**: No errors

### Step 3: Test ROM on Emulator

```bash
# Using BlastEm (Linux/Mac)
blastem build/vrd_phase2_test.32x

# Using Gens (Windows)
./Gens_KMod_v0.7.3/gens.exe build/vrd_phase2_test.32x
```

## Expected Behavior - Phase 2

When the Phase 2 test ROM boots, you should see:

### What WILL happen (same as Phase 1):
1. ✅ ROM loads and initializes (no crash)
2. ✅ 68000 game loop starts
3. ✅ Display initializes
4. ✅ Emulator runs without errors

### What SHOULD happen (new in Phase 2):
1. ✅ Sync buffer initialized at 0x22000400
2. ✅ Slave receives work dispatch signal
3. ✅ Slave processes polygons (400-799 range)
4. ✅ Master waits for Slave completion
5. ✅ Frame updates (may be slow or blank depending on Slave rendering status)

### What MIGHT happen (depending on Slave):
- **Blank/black screen**: Slave is rendering off-screen or frame buffer not cleared
- **Partial rendering**: Slave is only rendering subset of polygons
- **Flickering**: Sync protocol working but timing is off
- **Game menu visible**: Master code still running (injection failed)

## Success Indicators

### Definite Success
- ROM boots without crashing
- No emulator errors or hangs
- Can navigate menus (if they run on Master)
- Stable frame rate

### Good Signs (Phase 2 Working)
- COMM3/COMM4 registers show changing values (if debug enabled)
- Slave heartbeat visible (0x52454459 = "REDY")
- Any visual change from Phase 1 (indicates code execution changed)

### Troubleshooting

| Observation | Possible Cause | Next Step |
|-------------|----------------|-----------|
| ROM won't boot / immediate crash | Injection corrupted code | Restore from `build/vrd_vdp_optimized.32x` |
| Blank/black screen with no interaction | Master dispatcher didn't call Slave / Slave not rendering | Check COMM registers for sync signals |
| Same as Phase 1 (no change) | Code not injected correctly | Verify ROM sizes and offsets |
| Stuttering/slow FPS | Sync protocol working but slow | Expected for test version |

## What This Phase 2 Test Validates

✅ **Sync Protocol**: Master and Slave can communicate via SDRAM sync buffer
✅ **Work Dispatch**: Master can send polygon ranges to Slave
✅ **Frame Synchronization**: Slave can complete work before next frame
✅ **Integration Points**: Code injection works without breaking boot sequence

❌ **NOT validated yet**:
- Rendering correctness (Slave rendering functions)
- Performance improvement
- Master continuing own work (Master just waits in this test)

## Advancing to Full Phase 2

After successful Phase 2 test, next steps:

1. **Add Slave Rendering Functions**
   - Copy func_029, func_032, func_033, func_023 to Slave code
   - Modify to use Slave's frame buffer region

2. **Restore Full Master**
   - Revert Master dispatcher to original func_001
   - Add proper BSR calls to sync functions
   - Master does own rendering while Slave works in parallel

3. **Performance Testing**
   - Measure FPS with sync vs. without
   - Validate polygon split is working
   - Optimize if needed

## Files Summary

| File | Purpose | Size | Status |
|------|---------|------|--------|
| `disasm/sh2_slave_engine.asm` | Slave work dispatcher | 114 lines | ✅ Phase 1 |
| `disasm/sh2_master_sync_phase2.asm` | Master sync functions | - | ✅ Created |
| `disasm/sh2_master_minimal_dispatcher.asm` | Test Master (minimal) | - | ✅ Created |
| `build/vrd_phase2_test.32x` | Test ROM (Phase 2) | 3.0 MB | → Ready to build |

## Build Commands Summary

```bash
#!/bin/bash
# Complete Phase 2 test build

cd /mnt/data/src/32x-playground

# Assemble components
echo "Building Phase 2 components..."
sh-elf-as -o build/sh2_master_sync_phase2.o disasm/sh2_master_sync_phase2.asm
sh-elf-objcopy -O binary build/sh2_master_sync_phase2.o build/sh2_master_sync_phase2.bin

sh-elf-as -o build/sh2_master_minimal_dispatcher.o disasm/sh2_master_minimal_dispatcher.asm
sh-elf-objcopy -O binary build/sh2_master_minimal_dispatcher.o build/sh2_master_minimal_dispatcher.bin

# Create Phase 2 test ROM
echo "Creating Phase 2 test ROM..."
cp build/vrd_vdp_optimized.32x build/vrd_phase2_test.32x

# Inject Master sync functions
dd if=build/sh2_master_sync_phase2.bin of=build/vrd_phase2_test.32x \
   bs=1 seek=$((0x20750)) conv=notrunc

# Inject minimal Master dispatcher
dd if=build/sh2_master_minimal_dispatcher.bin of=build/vrd_phase2_test.32x \
   bs=1 seek=$((0x023024)) conv=notrunc

# Verify
echo "Build complete!"
ls -lh build/vrd_phase2_test.32x
echo "Test ROM ready: build/vrd_phase2_test.32x"
```

Save this as `build_phase2.sh` and run:
```bash
chmod +x build_phase2.sh
./build_phase2.sh
```

## Next Commands

Once build is complete:

```bash
# Test on emulator
blastem build/vrd_phase2_test.32x
```

## Notes

- The minimal Master dispatcher replaces func_001 entirely
- In full Phase 2, func_001 would be restored with sync init calls
- Current test focuses on validating sync protocol, not rendering quality
- All original Phase 1 files remain unchanged

## Timeline

- ✅ Phase 1: 2-3 days (complete)
- → **Phase 2: 1-2 days** (current step)
- ⏳ Phase 3: 5-7 days (rendering functions)
- ⏳ Phase 4: 4-5 days (optimization)
- ⏳ Phase 5: 3-4 days (validation)

---

**Status**: Phase 2 ready for testing. Proceed with Step 1 above.
