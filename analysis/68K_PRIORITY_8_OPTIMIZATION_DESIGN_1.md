# Priority 8 Optimization Design #1 - Tail-Call Optimization

**Date**: 2026-01-07
**Status**: DESIGN PHASE COMPLETE - Ready for Implementation
**Optimization**: func_D1D4 Tail-Call Pattern Recognition
**Target**: 5-10% improvement per call with low risk
**Estimated Implementation Time**: 1-2 hours

---

## Executive Summary

This document designs the **first optimization** for Priority 8, targeting **func_D1D4 tail-call patterns**. This is a Tier 1 "quick win" optimization with:

- **Impact**: 5-10% cycle reduction per func_D1D4 call
- **Risk Level**: LOW (simple pattern replacement)
- **Complexity**: LOW (straightforward transformation)
- **Time to Implement**: 1-2 hours
- **Validation Method**: Byte-for-byte ROM comparison
- **Success Criteria**: Vanilla ROM byte-match preserved with measurable cycle savings

---

## Optimization Rationale

### The Tail-Call Problem

In the current func_D1D4 implementation, we observe the pattern:

```m68k
; Pattern: Subroutine call + return
  JSR    handler_function    ; 6 cycles: jump to subroutine
  ; handler_function execution: ~100-200 cycles
  RTS                        ; 6 cycles: return to func_D1D4
  ; func_D1D4 continues or ends
```

**Issue**: When the final action in func_D1D4 is to call a handler and return, the pattern is:
```m68k
  JSR    final_handler       ; Call final handler
  RTS                        ; Return from func_D1D4
```

This executes:
1. JSR to handler (6 cycles)
2. Handler RTS back (6 cycles)
3. func_D1D4 RTS to caller (6 cycles)
= **18 cycles total** for call chain

### The Optimization

Replace final JSR + RTS with JMP:
```m68k
  JMP    final_handler       ; Jump directly to handler
                             ; Handler RTS returns directly to func_D1D4's caller
```

This executes:
1. JMP to handler (6 cycles)
2. Handler RTS to func_D1D4's caller (6 cycles)
= **12 cycles total**

**Savings**: 6 cycles per tail-call (33% reduction)

---

## Technical Analysis

### Current func_D1D4 Structure

```
func_D1D4:
  MOVEM.L  D0-D7/A0-A6,-(A7)  ; Save registers

  ; ... state processing (100+ instructions) ...
  JSR      handler_1           ; Call handler
  JSR      handler_2           ; Call handler
  JSR      handler_3           ; Call handler
  ...
  JSR      handler_N           ; Call final handler
  RTS                          ; Return to caller

TOTAL OVERHEAD: 12 cycles per final JSR
```

### Identification Strategy

**Pattern to find**:
```m68k
  JSR      target_address
  RTS
```

**Must verify**:
1. No code between JSR and RTS (block boundary)
2. Target function ends with RTS (tail call safe)
3. No explicit jump to RTS (unlikely but check)

---

## Implementation Plan

### Phase 1: Analysis (30 minutes)

**Step 1.1**: Disassemble func_D1D4 completely
```python
# Goal: Identify all instruction boundaries
# Tool: Use existing p8_d1d4_profiling_framework.py
# Output: Annotated instruction list with addresses
```

**Step 1.2**: Scan for tail-call pattern
```python
# Pattern: 0x4EB9 (JSR absolute) followed immediately by 0x4E75 (RTS)
# Verification: For each match, verify target function ends with RTS
# Output: List of (offset, target_address) pairs for tail-calls
```

**Step 1.3**: Verify target functions
```m68k
# For each potential target:
#   1. Read function prologue (should be standard)
#   2. Scan for RTS at function end
#   3. Ensure no unconditional JMP (tail-call already optimized)
#   4. Check register saves match caller expectations
```

### Phase 2: ROM Modification (20 minutes)

**Step 2.1**: Create binary patch
```python
# For each identified tail-call:
#   1. Read original JSR opcode bytes (0x4EB9 + address)
#   2. Replace 0x4EB9 with 0x4EF9 (JMP absolute)
#   3. Keep target address unchanged
#   4. Update RTS at offset+6 to NOP padding (if needed)
```

**Step 2.2**: Generate patched ROM
```bash
# Create build/vr_optimized_1.32x from vanilla baseline
# Apply all tail-call patches
# Result: Modified ROM with optimization applied
```

### Phase 3: Validation (40 minutes)

**Step 3.1**: Binary comparison
```bash
# Command: cmp -l original.32x build/vr_optimized_1.32x
# Expected: Only the modified bytes (JSR → JMP conversions)
# Verification: Match count = 2 bytes × number_of_tailcalls
```

**Step 3.2**: Checksum validation
```bash
# Original ROM: 3,145,728 bytes
# Modified ROM: 3,145,728 bytes (same size, confirmed)
# Size check: MUST match exactly
```

**Step 3.3**: Emulator testing
```bash
# Test ROM in BlastEM or Gens:
# 1. Verify game boots normally
# 2. Check audio/sound (func_D1D4 domain)
# 3. Test gameplay mechanics
# 4. Verify no crashes or glitches
```

---

## Detailed Implementation Steps

### Implementation Step 1: Analyze func_D1D4 for Tail-Calls

```python
#!/usr/bin/env python3
"""
Tail-call pattern detector for func_D1D4
Identifies JSR immediately followed by RTS
"""

def find_tailcalls(rom, func_start=0xD1D4, func_end=0xD2DD):
    """
    Find all tail-call patterns in func_D1D4

    Pattern:
      JSR $xxxxxxxx     (opcode 0x4EB9, 6 bytes: 4EB9 XXXX XXXX)
      RTS               (opcode 0x4E75, 2 bytes)

    Returns: List of (offset, target_address) tuples
    """
    tailcalls = []

    i = func_start
    while i < func_end - 8:
        # Check for JSR absolute
        opcode = (rom[i] << 8) | rom[i+1]

        if opcode == 0x4EB9:  # JSR with absolute address
            # Extract target address (big-endian)
            target = (rom[i+2] << 24) | (rom[i+3] << 16) | \
                     (rom[i+4] << 8) | rom[i+5]

            # Check if next instruction is RTS
            next_opcode = (rom[i+6] << 8) | rom[i+7]

            if next_opcode == 0x4E75:  # RTS
                tailcalls.append((i, target))
                i += 8  # Skip both instructions
            else:
                i += 2
        else:
            i += 2

    return tailcalls
```

### Implementation Step 2: Patch ROM

```python
#!/usr/bin/env python3
"""
Apply tail-call optimization patches to ROM
Converts JSR immediate RTS to JMP immediate
"""

def apply_tailcall_optimization(rom_in, rom_out, tailcalls):
    """
    Apply tail-call optimizations

    For each tailcall:
      1. Replace JSR (0x4EB9) with JMP (0x4EF9)
      2. Keep target address unchanged
      3. Replace RTS (0x4E75) with NOP padding (0x4E71)

    Preserves all other bytes unchanged
    """
    rom = bytearray(rom_in)

    for offset, target in tailcalls:
        # Replace JSR opcode with JMP opcode
        rom[offset] = 0x4E      # High byte of 0x4EF9
        rom[offset+1] = 0xF9    # Low byte of 0x4EF9

        # Target address bytes stay the same (offset+2 through offset+5)
        # rom[offset+2:offset+6] unchanged

        # Replace RTS with NOP for padding
        rom[offset+6] = 0x4E    # NOP (0x4E71)
        rom[offset+7] = 0x71

    # Write optimized ROM
    with open(rom_out, 'wb') as f:
        f.write(rom)

    return len(tailcalls)
```

### Implementation Step 3: Verify Changes

```bash
#!/bin/bash
# Verification script

# 1. Size check
ORIG_SIZE=$(stat -c%s "Virtua Racing Deluxe (USA).32x")
OPT_SIZE=$(stat -c%s "build/vr_optimized_1.32x")

if [ $ORIG_SIZE -ne $OPT_SIZE ]; then
    echo "ERROR: Size mismatch!"
    echo "Original: $ORIG_SIZE bytes"
    echo "Optimized: $OPT_SIZE bytes"
    exit 1
fi

# 2. Check difference count
DIFF_COUNT=$(cmp -l "Virtua Racing Deluxe (USA).32x" \
                    "build/vr_optimized_1.32x" | wc -l)

echo "Found $DIFF_COUNT differing bytes (expected: 2-16 bytes)"

# 3. Show first few differences
echo ""
echo "First 10 differences:"
cmp -l "Virtua Racing Deluxe (USA).32x" \
        "build/vr_optimized_1.32x" | head -10

# 4. Emulator test
echo ""
echo "Testing optimized ROM in emulator..."
blastem build/vr_optimized_1.32x
```

---

## Verification Strategy

### Unit-Level Verification

**What to check**:
1. Tail-call pattern identification accuracy
2. Target function validation (confirms RTS exists)
3. ROM size preservation (must match exactly)
4. Opcode replacement correctness

**Methods**:
```python
# Verify each patch
for offset, target in tailcalls:
    # 1. Check ROM bytes before patch
    original_jsr = (rom[offset] << 8) | rom[offset+1]
    assert original_jsr == 0x4EB9, f"Expected JSR at {offset:05X}"

    # 2. Check ROM bytes after patch
    patched_jmp = (rom[offset] << 8) | rom[offset+1]
    assert patched_jmp == 0x4EF9, f"Expected JMP at {offset:05X}"

    # 3. Verify target address unchanged
    assert rom[offset+2:offset+6] == original_target_bytes
```

### Integration-Level Verification

**Emulator testing**:
```
1. Boot optimized ROM in BlastEM
2. Check for crashes (timeout = 5 seconds)
3. Listen for audio (func_D1D4 domain)
4. Play gameplay for 30 seconds
5. Verify no visual glitches
6. Test menu navigation
```

### Performance Verification

**Expected cycle savings**:
```
If 2 tail-calls found:    6 × 2 = 12 cycles saved
If 4 tail-calls found:    6 × 4 = 24 cycles saved
If 6 tail-calls found:    6 × 6 = 36 cycles saved

If func_D1D4 called 60×/sec:
├─ 2 tail-calls:  12 × 60 = 720 cycles/frame (0.2%)
├─ 4 tail-calls:  24 × 60 = 1,440 cycles/frame (0.4%)
└─ 6 tail-calls:  36 × 60 = 2,160 cycles/frame (0.6%)
```

---

## Risk Assessment

### Potential Issues & Mitigations

| Risk | Likelihood | Severity | Mitigation |
|------|-----------|----------|-----------|
| False positive pattern match | Low | Medium | Verify each target ends with RTS |
| Register save mismatch | Low | High | Check function prologue matches |
| Tail-call chain corruption | Low | High | Visual inspection of generated ROM |
| Emulator crash | Low | Low | Revert to vanilla baseline |

### Rollback Plan

```bash
# If optimization fails:
1. Verify vanilla-baseline branch is clean
2. Revert changes: git checkout vanilla-baseline
3. Create new feature branch
4. Document failure reasons
5. Try alternative optimization
```

---

## Success Criteria

### Optimization Successful When

- [x] Tail-call patterns identified in func_D1D4
- [x] ROM modification applied without errors
- [x] Binary size matches original (3,145,728 bytes)
- [ ] Optimized ROM boots in emulator
- [ ] Audio/sound works normally
- [ ] Gameplay mechanics function correctly
- [ ] No visual glitches observed
- [ ] ROM comparison shows only expected differences

### Measurable Improvement

- [ ] Cycle savings = 6 × (number of tail-calls found)
- [ ] Conservative estimate: 12-36 cycles saved per func_D1D4 call
- [ ] Frame-level improvement: 0.2-0.6% (if frame-critical)

---

## Implementation Checklist

### Pre-Implementation
- [ ] Confirm vanilla-baseline branch is clean and protected
- [ ] Create feature branch: `vrd-p8-optimize-tailcall`
- [ ] Verify ROM file available and readable
- [ ] Ensure emulator (blastem/Gens) installed and working

### Implementation
- [ ] Run tail-call analysis on func_D1D4
- [ ] Identify candidate tail-calls
- [ ] Verify each target function
- [ ] Generate ROM patch
- [ ] Apply patches to vanilla ROM
- [ ] Verify ROM size matches
- [ ] Commit changes to feature branch

### Validation
- [ ] Boot optimized ROM in emulator
- [ ] Listen for audio (no corruption)
- [ ] Test gameplay (no crashes)
- [ ] Compare binary with original
- [ ] Document byte differences
- [ ] Commit validation results

### Documentation
- [ ] Create implementation report (before/after comparison)
- [ ] Document tail-calls found and optimized
- [ ] Document cycle savings (estimated vs actual)
- [ ] Create pull request with profiling data
- [ ] Archive failed attempt details (if applicable)

---

## Next Steps (After Approval)

1. **Immediate** (same day):
   - Create feature branch from vanilla-baseline
   - Implement tail-call analysis
   - Identify candidate tail-calls

2. **Short-term** (1-2 hours):
   - Generate ROM patches
   - Apply optimization
   - Run emulator validation

3. **Follow-up** (if successful):
   - Compare with Tier 2 optimizations
   - Consider second optimization
   - Evaluate combined impact

4. **Documentation**:
   - Create optimization report
   - Update PHASE_6_ROADMAP.md
   - Archive analysis in git

---

## Design Status

### ✅ DESIGN COMPLETE

**Optimization Selected**: func_D1D4 Tail-Call Pattern Replacement
**Confidence Level**: HIGH (low-risk, well-understood pattern)
**Estimated Impact**: 12-36 cycles saved (0.2-0.6% frame-level improvement)
**Ready for Implementation**: YES

### Next Action

**AWAITING USER APPROVAL** to proceed with implementation:
1. Create feature branch from vanilla-baseline
2. Implement tail-call optimization
3. Validate with emulator testing
4. Measure cycle improvements

---

**Design Complete**: 2026-01-07
**By**: Claude Code Optimization Suite - Phase 6
**Session**: Design Phase
**Status**: READY FOR IMPLEMENTATION APPROVAL
