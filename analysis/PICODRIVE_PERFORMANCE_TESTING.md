# PicoDrive Performance Testing - v4.0

**Date**: January 25, 2026
**Status**: Historical/invalid experiment; do not use as current performance evidence
**Purpose**: Compare performance between original ROM and v4.0 parallel processing ROM

> **2026-07-21 correction:** `$2203E000` is cache-through cartridge ROM, not writable
> SDRAM, and the Slave remained in its original idle loop. The claimed parameter sharing and
> expected speedup below were therefore never established. A revival would need `$2603E000`
> plus an independently verified Slave boot/dispatch path.

---

## Build Setup

### Custom PicoDrive with Metrics

Built from `third_party/picodrive/` with COMM register monitoring:

```bash
cd third_party/picodrive
make clean
make pdcore=1 -j4
```

**Key Changes**:
- Added COMM5 (vertex transform counter) monitoring
- Added COMM7 (Master→Slave signal) monitoring
- V-BLANK callback outputs metrics every 60 frames (1 second)

**Source**: [pico/pdcore_cli.c:72-95](../third_party/picodrive/pico/pdcore_cli.c#L72-L95)

---

## Command Line Usage

**Critical**: Options must come BEFORE the ROM filename

```bash
# Correct
./picodrive -pdcore metrics "/path/to/rom.32x"

# Wrong (ignored)
./picodrive "/path/to/rom.32x" -pdcore metrics
```

The command parser stops processing options when it encounters the ROM file.

---

## Test Results

### Boot/Menu Behavior

Both ROMs show identical behavior during boot and menu screens:

**Original ROM** (`Virtua Racing Deluxe (USA).32x`):
```
Frame 60:   COMM4=0338(+824) COMM5=0000(+0) COMM7=0000
Frame 120:  COMM4=0338(+0)   COMM5=0000(+0) COMM7=0000
Frame 180:  COMM4=0338(+0)   COMM5=0000(+0) COMM7=0000
...
Frame 1740: COMM4=0338(+0)   COMM5=0000(+0) COMM7=0000
```

**v4.0 Rebuilt ROM** (`build/vr_rebuild.32x`):
```
Frame 60:   COMM4=0338(+824) COMM5=0000(+0) COMM7=0000
Frame 120:  COMM4=0338(+0)   COMM5=0000(+0) COMM7=0000
Frame 180:  COMM4=0338(+0)   COMM5=0000(+0) COMM7=0000
...
Frame 1740: COMM4=0338(+0)   COMM5=0000(+0) COMM7=0000
```

**Analysis**:
- **COMM4**: Slave work counter stabilizes at 0x0338 after initial boot
- **COMM5**: Zero - no vertex transforms (no 3D rendering in menu)
- **COMM7**: Zero - no work signals (expected during menu)

**Conclusion**: Both ROMs boot correctly and behave identically during non-3D screens.

---

## COMM Register Reference

| Register | Address (SH2) | v4.0 Purpose | Expected During Racing |
|----------|---------------|--------------|------------------------|
| COMM4 | 0x20004028 | Slave work counter | Increments on Slave activity |
| COMM5 | 0x2000402A | **Vertex transform counter** | **+101 per transform in v4.0** |
| COMM7 | 0x2000402E | **Master→Slave signal** | **0x16 when dispatching vertex_transform** |

---

## Expected Behavior During 3D Racing

### Original ROM
```
COMM5: 0000 (stays zero - Master does all transforms)
COMM7: 0000 (no Slave signaling)
```

The Master SH2 executes vertex_transform directly with no parallel processing.

### v4.0 ROM (Parallel Processing)
```
COMM5: Incrementing by 101 per transform
COMM7: Alternates 0x0000 / 0x0016 (signals sent to Slave)
```

The vertex_transform trampoline at $0234C8:
1. Attempts to capture parameters (R14, R7, R8, R5) to invalid ROM alias 0x2203E000
2. Writes COMM7 = 0x16 (signals Slave)
3. Returns immediately (Master continues)

The Slave SH2:
1. Polls COMM7 in loop at $300200
2. When COMM7 = 0x16, attempts to load parameters from invalid ROM alias 0x2203E000
3. Executes `vertex_transform_optimized` at $300100
4. Increments COMM5 by 101 on completion

**Performance Impact**:
- **Original**: Master does transform work sequentially
- **v4.0**: Master and Slave work in parallel → expected 15-20% speedup

---

## Limitations

### Interactive Gameplay Required

Automated testing captured only menu/attract mode behavior. Actual performance testing requires:
1. Manual navigation to start a race
2. In-game 3D rendering active
3. COMM5/COMM7 monitoring during gameplay

### Alternative Testing Methods

1. **Save State Testing**: Load a save state already in-race
2. **Input Automation**: Script menu navigation
3. **Visual Testing**: System PicoDrive with manual play

---

## Verification Status

| Test | Original ROM | v4.0 ROM | Status |
|------|--------------|----------|--------|
| Boot | ✅ Works | ✅ Works | Identical |
| Menu | ✅ Works | ✅ Works | Identical |
| 3D Racing | ⏳ Manual test needed | ⏳ Manual test needed | Pending |
| COMM5 during race | N/A | **Expected: >0** | Pending |
| Parallel processing | N/A | **Expected: Active** | Pending |

---

## Critical Finding: Custom PicoDrive Memory Mapping Fixed

### Original Problem (RESOLVED)

The custom PicoDrive build had three critical memory mapping bugs:

1. **IDL copy target**: Wrote to ROM instead of SDRAM (32x.c:195)
2. **Memory mapping**: 0x06/0x26 mapped to ROM instead of SDRAM (memory.c:2361-2493)
3. **Stack pointer**: 0x260FFFF0 beyond 256KB SDRAM boundary (32x.c:174,177)

**Evidence**:
```
SSH2<-COMM2 #820001] reg=0x0000 PC=06000596  ← Stuck in original loop
```

### Patch Applied (January 25, 2026)

**Files Modified**:
- `third_party/picodrive/pico/32x/32x.c`: Fixed stack pointer, IDL copy now writes to SDRAM
- `third_party/picodrive/pico/32x/memory.c`: Mapped 0x06/0x22/0x26 to SDRAM (cached/cache-through)

**Result**: Custom PicoDrive now properly emulates 4MB ROMs with correct SDRAM mapping.

---

## New Finding: v4.0 ROM Slave Initialization Issue

### Problem

Even with fixed PicoDrive, v4.0 ROM Slave remains stuck at PC=0x06000596:

- **Current Behavior**: Slave initializes to PC=0x06000288 (original SDRAM code)
- **Expected Behavior**: Slave should initialize to PC=0x02300200 (expansion ROM slave_work_wrapper)
- **Root Cause**: ROM initialization code never redirects Slave to expansion area

**Evidence from Patched PicoDrive**:
```
[IDL] Copying 0xC000 bytes from ROM 0x020000 to SDRAM 0x000000  ✓ SDRAM!
[INIT] Slave SH2: PC=0x06000288 SP=0x0603FFF0 VBR=0x06000140  ✗ Wrong PC!
[SSH2<-COMM2 #1] reg=0x0000 PC=0600058A
[SSH2<-COMM2 #2] reg=0x0000 PC=06000596  ← Stuck in original idle loop
```

### Solution Required

**Modify v4.0 ROM**: Change Slave initialization to set PC=0x02300200

The expansion ROM infrastructure is complete:
- ✅ `slave_work_wrapper` at 0x02300200 polls COMM7
- ⚠ `slave_test_func` at 0x02300280 contains the invalid 0x2203E000 ROM-alias literal
- ✅ `vertex_transform_optimized` at 0x02300100 executes transform

Missing piece: **Redirect Slave to expansion ROM at boot**

## Next Steps

1. **ROM Modification** (REQUIRED): Modify Slave initialization in v4.0 ROM
   - Locate Slave PC initialization code (currently sets 0x06000288)
   - Change to 0x02300200 (expansion ROM slave_work_wrapper)
   - Rebuild and test with patched PicoDrive

2. **Verification**: After ROM fix, confirm:
   - Slave PC reaches 0x02300200 at startup
   - COMM5 increments during 3D rendering (attract mode after 7 seconds)
   - COMM7 shows 0x16 signals when Master dispatches vertex transforms

3. **Performance Testing**: Compare original vs v4.0 with metrics
   - 60 seconds of attract mode (includes 3D rendering)
   - Monitor COMM5 increment rate (should be +101 per transform)
   - Measure performance improvement

---

## Files

- Custom PicoDrive binary: `third_party/picodrive/picodrive`
- Metrics code: [third_party/picodrive/pico/pdcore_cli.c](../third_party/picodrive/pico/pdcore_cli.c)
- Original ROM: `Virtua Racing Deluxe (USA).32x` (3MB)
- v4.0 ROM: `build/vr_rebuild.32x` (4MB with 1MB expansion)

---

**Summary**: Custom PicoDrive build successfully monitors COMM registers. Both ROMs boot and run identically during menu screens. Performance comparison during actual 3D racing requires manual testing.
