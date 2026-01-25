# PicoDrive Performance Testing - v4.0

**Date**: January 25, 2026
**Purpose**: Compare performance between original ROM and v4.0 parallel processing ROM

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
| COMM7 | 0x2000402E | **Master→Slave signal** | **0x16 when dispatching func_021** |

---

## Expected Behavior During 3D Racing

### Original ROM
```
COMM5: 0000 (stays zero - Master does all transforms)
COMM7: 0000 (no Slave signaling)
```

The Master SH2 executes func_021 directly with no parallel processing.

### v4.0 ROM (Parallel Processing)
```
COMM5: Incrementing by 101 per transform
COMM7: Alternates 0x0000 / 0x0016 (signals sent to Slave)
```

The func_021 trampoline at $0234C8:
1. Captures parameters (R14, R7, R8, R5) to 0x2203E000
2. Writes COMM7 = 0x16 (signals Slave)
3. Returns immediately (Master continues)

The Slave SH2:
1. Polls COMM7 in loop at $300200
2. When COMM7 = 0x16, loads parameters from 0x2203E000
3. Executes `func_021_optimized` at $300100
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

## Next Steps

1. **Manual Testing**: Load both ROMs in system PicoDrive and race
2. **Visual Verification**: Confirm v4.0 ROM plays correctly
3. **Performance Metrics**: Compare perceived FPS during heavy 3D scenes
4. **COMM Monitoring**: If possible, capture COMM5 during actual gameplay

---

## Files

- Custom PicoDrive binary: `third_party/picodrive/picodrive`
- Metrics code: [third_party/picodrive/pico/pdcore_cli.c](../third_party/picodrive/pico/pdcore_cli.c)
- Original ROM: `Virtua Racing Deluxe (USA).32x` (3MB)
- v4.0 ROM: `build/vr_rebuild.32x` (4MB with 1MB expansion)

---

**Summary**: Custom PicoDrive build successfully monitors COMM registers. Both ROMs boot and run identically during menu screens. Performance comparison during actual 3D racing requires manual testing.
