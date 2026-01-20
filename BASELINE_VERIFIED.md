# Verified Baseline ROM - 2026-01-20

## Status: ✅ WORKING

The rebuilt ROM now works identically to the original with full SH2 rendering and audio.

## Verification

```bash
# Only 1 difference in first 3MB (ROM size field)
cmp -l build/vr_rebuild.32x "Virtua Racing Deluxe (USA).32x" | awk '{if ($1 < 3145728) print $0}'
# Output: 422  77  57
# Byte 422 (offset 0x1A5) = ROM size (4MB vs 3MB) - EXPECTED
```

### Test Results
- ✅ ROM boots normally
- ✅ SH2 rendering active
- ✅ Audio working
- ✅ Gameplay functional

## Critical Lessons Learned

### DO NOT MODIFY
1. **VDP Wait Function** at `$02050C` - Slave SH2 rendering depends on this
2. **Master SH2 Entry** at `$020500` ("M_OK" signature)
3. **Copyright Text** at `$000512` ("MARS Initial & Security Program")
4. **V-INT Handler Epilogue** at `$0016A6` (MOVEM.L, MOVE SR, RTE)

### Files Verified Clean
- `disasm/sections/code_200.asm` - Matches original
- `disasm/sections/code_20200.asm` - Matches original (VDP wait restored)

### Expansion ROM
- `disasm/sections/expansion_300000.asm` - Contains unused COMM monitor (24 bytes)
- Not called by ROM - ready for future use
- Does not affect game operation

## Atomic Development Methodology

Going forward, ALL changes must follow this process:

1. **Single atomic change** - One function, one location, minimal bytes
2. **Build immediately** - `make clean && make all`
3. **Test in emulator** - `picodrive build/vr_rebuild.32x`
4. **Verify functionality** - Boot, audio, rendering, gameplay
5. **Document change** - What, where, why, expected behavior
6. **Commit or revert** - Keep if works, revert if broken
7. **Repeat** - Only move to next change after verification

### Change Size Targets
- Ideal: 2-10 bytes (single instruction or small function)
- Maximum: 30 bytes (must be well-tested and reversible)
- Never: Multiple modifications in different locations simultaneously

## Next Steps

Ready for atomic implementation of work distribution features.

**Recommended first atomic change**:
- Add 6-byte JSR call in V-INT handler to expansion ROM COMM monitor
- Test: Verify boot, audio, rendering still work
- Measure: Use debugger to confirm JSR executes each frame
- Then: Add actual COMM register reads/writes one at a time

---

**Baseline Date**: 2026-01-20 19:48
**ROM Size**: 4.0 MB
**Build**: Successful
**Status**: Production-ready baseline for future modifications
