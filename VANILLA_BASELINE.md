# Vanilla Baseline Build

**Date**: 2026-01-07
**Branch**: `vanilla-baseline`
**Status**: Established - ready for optimization comparisons

---

## What is This Branch?

This is the **vanilla baseline** - an unmodified build that serves as a reference point for all optimizations.

### Build Verification

| Metric | Status | Details |
|--------|--------|---------|
| **Assembler** | ✅ Successful | vasm m68k assembler working |
| **Build** | ✅ Complete | 3.0 MB ROM assembled |
| **Comparison** | ✅ PERFECT MATCH | Byte-for-byte identical to original |
| **ROM Integrity** | ✅ Verified | CRC/size all match |

### Build Command

```bash
make clean && make all
```

### Verification Command

```bash
cmp "Virtua Racing Deluxe (USA).32x" "build/vr_rebuild.32x"
# Output: Files are identical
```

---

## Baseline Characteristics

### ROM Size
```
Original:  3,145,728 bytes (3.0 MB)
Rebuilt:   3,145,728 bytes (3.0 MB)
Match:     ✓ Exact match
```

### Source Code Status
- **68K Assembly**: Disassembled and annotated
- **SH2 Assembly**: Partially disassembled
- **Data Sections**: Included in rebuild
- **Modifications**: NONE (vanilla)

### Build Process
1. Assembler: `tools/vasmm68k_mot` (m68k syntax)
2. Flags: `-Fbin -m68000 -no-opt` (binary output, no optimization)
3. Input: `disasm/m68k_header.asm`
4. Output: `build/vr_rebuild.32x`
5. Data: `disasm/rom_data_remainder.bin` (included in header)

---

## Why This Baseline Matters

### For Optimization Work

1. **Reference Point**: All optimization attempts will be compared against this
2. **Size Baseline**: 3,145,728 bytes - metric for improvement measurement
3. **Functional Baseline**: Byte-for-byte match proves code reconstruction is accurate
4. **Testing Baseline**: Know that if rebuilt ROM doesn't work, it's from optimizations

### Verification Checklist

Before starting optimizations, confirm:
- [ ] You're on a feature branch (not vanilla-baseline)
- [ ] Vanilla baseline branch exists and is clean
- [ ] You can rebuild from vanilla-baseline successfully
- [ ] Original ROM is available for comparison
- [ ] Build command works: `make clean && make all`

### Rollback Strategy

If optimization breaks functionality:
1. `git checkout vanilla-baseline` - Return to working baseline
2. `make clean && make all` - Rebuild to verify it still works
3. Compare to original: `cmp "Virtua Racing Deluxe (USA).32x" "build/vr_rebuild.32x"`
4. Branch from vanilla-baseline again for next optimization attempt

---

## Optimization Workflow

### When Starting New Optimization Work

```bash
# From vanilla-baseline
git checkout vanilla-baseline

# Create feature branch for optimization
git checkout -b optimize/priority-8-d1d4

# Make changes to disasm/ files
# Rebuild and test
make clean && make all

# Commit with clear message
git commit -m "optimize: [description of changes]"

# Test functionality (ROM must run and sound/graphics work)

# If successful: ready to merge
# If failed: rollback changes
```

### Comparison Commands

```bash
# Size comparison
ls -lh "Virtua Racing Deluxe (USA).32x" build/vr_rebuild.32x

# Byte comparison (no output = identical)
cmp "Virtua Racing Deluxe (USA).32x" "build/vr_rebuild.32x"

# Diff count
cmp -l "Virtua Racing Deluxe (USA).32x" "build/vr_rebuild.32x" | wc -l

# Show first differences
cmp -l "Virtua Racing Deluxe (USA).32x" "build/vr_rebuild.32x" | head -20
```

---

## Current Analysis Status

### Priority 8 Analysis Complete ✅

See [README_PRIORITY_8.md](analysis/README_PRIORITY_8.md) for complete analysis including:

1. **163 functions analyzed** - All Priority 8 functions inventoried
2. **Call graph complete** - 51 callsites mapped
3. **Hotspot identified** - func_D1D4 confirmed (11 JSR calls)
4. **Dispatcher located** - func_CA9A (score 38/50)
5. **Optimization targets** - 10-35% improvement potential

### Next Steps

1. **Verify This Baseline Works**
   - Run the ROM in emulator
   - Confirm audio and graphics function
   - Note any anomalies

2. **Profile func_D1D4**
   - Measure call frequency (frame-critical vs event-driven)
   - Identify JSR call overhead
   - Determine optimization ROI

3. **Dispatcher Investigation**
   - Deep disassemble func_CA9A
   - Confirm it's the game state dispatcher
   - Map all handler functions

4. **Plan First Optimization**
   - Based on profiling results
   - Target func_D1D4 if frame-critical
   - Or dispatcher refactoring if opportunity found

---

## Technical Details

### Build System

- **Assembler**: vasm (Motorola 68k syntax, binary output)
- **Language**: m68k assembly
- **Platform**: Sega 32X (68k + 2x SH2)
- **ROM Format**: Binary .32x file
- **No Optimization Flags**: `-no-opt` ensures faithful reproduction

### Known Limitations

1. **SH2 Code**: Only partially disassembled (3D engine)
2. **Optimization**: Not yet enabled in assembly
3. **Integration**: No changes to source yet
4. **Verification**: Manual ROM comparison only

---

## Documentation References

- **CLAUDE.md**: Project guidelines
- **development-guide.md**: Hardware and development info
- **32x-hardware-manual.md**: Complete hardware reference
- **Priority 8 Analysis**: `/analysis/README_PRIORITY_8.md`

---

## Status Summary

### ✅ Baseline Established

- Vanilla build: Working and verified
- Size: 3,145,728 bytes (matches original exactly)
- Assembly: Correct and reproducible
- Ready for optimization work

### ⏭️ Ready for Phase 6

Optimization can begin from feature branches based on:
1. Priority 8 analysis findings
2. Profiling data (when available)
3. Dispatcher investigation results

---

**Created**: 2026-01-07
**By**: Claude Code
**Branch**: vanilla-baseline
**Status**: STABLE & READY FOR OPTIMIZATION

