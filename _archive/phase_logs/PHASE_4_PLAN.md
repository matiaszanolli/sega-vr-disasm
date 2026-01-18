# Phase 4: Optimization & Multi-Region Integration Plan

**Status**: Planning & Infrastructure Complete
**Date**: January 10, 2026
**Target**: +20-30% performance with proper function linking and load balancing

---

## Executive Summary

Phase 4 transitions from **proof-of-concept parallelization** (Phase 3) to **production-grade optimization**. The strategy uses **multi-region ROM injection** to circumvent bootstrap space limitations:

- **Phase 1** (160-200 bytes) → Slave work dispatcher at boot critical location (0x20650)
- **Phase 3 Functions** (280 bytes) → Rendering functions at safe extended space (0x2F6000)
- **Result**: Eliminates address conflicts, enables full function linking

---

## Architecture: Multi-Region Injection

```
ROM Layout:
0x020650 ┌─────────────────────────┐
         │ Phase 1: Slave Engine   │ (200 bytes - boot critical)
0x020858 ├─────────────────────────┤
         │ (Safe space buffer)     │
         │                         │
0x2F6000 │ Phase 3: Rendering Fns  │ (280 bytes - extended space)
0x2F6118 └─────────────────────────┘
         │ (169KB available)       │
```

### Why Multi-Region?

**Problem (Phase 3)**: Consolidated 480-byte engine at 0x20650 broke ROM
- Bootstrap code needs <200 bytes at 0x20650
- Anything larger overwrites initialization

**Solution (Phase 4)**: Split across two regions with proper linking
- Small Phase 1 dispatcher at boot
- Full rendering pipeline in extended space
- Linker resolves all addresses automatically

---

## Linker System (Phase 3.5 Enhanced)

### Phase 3.5 Linker
- **File**: `tools/sh2_linker.py`
- **Purpose**: Single-region symbol resolution
- **Status**: Complete, tested

### Phase 4 Linker (NEW)
- **File**: `tools/sh2_linker_phase4.py`
- **Purpose**: Multi-region symbol resolution with dual injection
- **Features**:
  - Automatic region allocation (Phase 1 vs Phase 3 functions)
  - Separate binary generation for each region
  - ROM injection at both locations simultaneously
  - Memory map showing full address resolution

**Usage**:
```bash
python3 tools/sh2_linker_phase4.py \
    disasm/sh2_slave_consolidated.asm \
    build/sh2_slave_phase4.bin \
    --rom build/vrd_phase4_multiregion.32x
```

**Output**:
- `build/sh2_slave_phase4.bin` - Complete binary (480 bytes)
- Injected at 0x20650 (first 200 bytes) + 0x2F6000 (remaining 280 bytes)
- Memory map showing both regions

---

## Function Allocation Strategy

### Phase 1 Functions (Slave Work Dispatcher)
```
Offset    Function              Size      Priority
0x0000    slave_main_loop       ~60 bytes CRITICAL
0x003C    slave_process_polygons ~40 bytes CRITICAL
0x0060    Sync buffer           ~32 bytes CRITICAL
          Literals              ~68 bytes
          ────────────────────────────
Total:                          200 bytes (fits boot region)
```

### Phase 3 Functions (Rendering Pipeline)
```
Offset    Function              Size
0x0000    parse_polygon_bounds  32 bytes (Phase 3.0)
0x0032    slave_func_029        48 bytes (Phase 3.1)
0x0064    slave_func_032        24 bytes (Phase 3.2)
0x0080    slave_func_033        76 bytes (Phase 3.3)
0x00CC    slave_func_034        92 bytes (Phase 3.3)
0x0118    slave_func_023        56 bytes (Phase 3.4)
0x0150    Literals              ~100 bytes
          ────────────────────────────
Total:                          ~280 bytes (fits extended space)
```

---

## Implementation Roadmap

### Step 1: Verify ROM Structure ✅
- [x] Identify safe injection points (0x2F6000 has 169KB free)
- [x] Create Phase 4 linker with multi-region support
- [x] Generate test ROM: `vrd_phase4_multiregion.32x`

### Step 2: Function Linking (NEXT)
- [ ] Update Phase 3 functions to use absolute addressing for cross-calls
- [ ] Enable func_023 → func_029 → func_032 → func_033 → func_034 chain
- [ ] Validate all functions execute correctly
- [ ] Test frame buffer output

### Step 3: Load Balancing
- [ ] Measure Master vs Slave CPU utilization per frame
- [ ] Adjust polygon split point (currently 0-399 / 400-799)
- [ ] Balance for ~50% Master / 40% Slave utilization
- [ ] Measure FPS improvement

### Step 4: Performance Optimization
- [ ] Profile function call overhead
- [ ] Optimize hot paths (func_032 scanline fill)
- [ ] Implement FIFO batching for frame buffer writes
- [ ] Measure cycle savings per optimization

### Step 5: Testing & Validation
- [ ] Boot ROM on BlastEm emulator
- [ ] Verify all rendering functions execute
- [ ] Stress test 1000+ frames
- [ ] Capture performance metrics (FPS, CPU utilization)
- [ ] Validate visual output correctness

---

## Cross-Function Calling Strategy

**Challenge**: Functions at different ROM addresses (0x20650 vs 0x2F6000)
- Direct BSR (branch-with-save) limited to ±4KB
- Need JSR (jump-with-save) for long-distance calls

**Solution**: Absolute addressing for phase 3 functions

```assembly
; Instead of: bsr slave_func_029 (fails due to range)
; Use:
mov.l   func_029_addr, r1
jsr     @r1         ; Jump to absolute address
nop

; In literal pool:
func_029_addr:
    .long   0x22F60... + offset_of_func_029
```

**For Phase 4 work items**:
- Update func_023 → func_029 call chain with JSR
- Provide linker-generated address constants
- Validate all cross-function calls

---

## ROM Space Analysis

### Current Usage
```
0x000000 - 0x020650: 68K game code + data
0x020650 - 0x020858: Slave Phase 1 (200 bytes)
0x020858 - 0x2F5C6A: 3D engine, game assets (~3MB)
0x2F5C6A - 0x300000: Free space (169KB)
```

### Phase 4 Utilization
```
0x020650: Phase 1 engine (200 bytes) ✅ Fits safely
0x2F6000: Phase 3 functions (280 bytes) ✅ Ample space
Remaining: 168KB for future expansion (Phase 5+)
```

### Expansion Room
- **Phase 5 optimization code**: 5-10KB available
- **Lookup tables / data**: 20KB available
- **Future rendering functions**: Unlimited in free space

---

## Expected Performance Gains

### Conservative Estimate (Phase 4)
```
Master CPU:  91% → 65% utilization (-26%)
Slave CPU:   0% → 30% utilization
FPS boost:   24 FPS → 28 FPS (+17%)
```

### Optimistic Estimate (Phase 4 + 5)
```
Master CPU:  91% → 55% utilization (-36%)
Slave CPU:   0% → 45% utilization
FPS boost:   24 FPS → 32 FPS (+33%)
```

### Measurement Plan
```bash
# Cycle profiling with frame counter
# Before: Master ~350K cycles/frame
# After Phase 4: Master ~250K cycles/frame (28% gain)
# After Phase 5: Master ~220K cycles/frame (37% gain)
```

---

## Technical Implementation Details

### Phase 4.1: Function Linking (Priority: HIGH)

**File to modify**: `disasm/sh2_slave_consolidated.asm`

**Change 1**: func_023 dispatcher
```assembly
; Current (won't work - BSR out of range):
; bsr slave_func_029

; New (absolute addressing):
func_023:
    mov.l   func_029_addr, r1
    jsr     @r1
    nop

    ; [... more code ...]

func_029_addr:
    .long   0x2F609C    ; Linker-calculated address
```

**Change 2**: Enable rendering chain
```assembly
slave_process_polygons:
    ; Load RenderingContext from sync buffer
    mov.l   @(CONTEXT_PTR_OFFSET, r14), r14

    ; Call dispatcher for each polygon range
    mov.l   func_023_addr, r1
    jsr     @r1
    nop

func_023_addr:
    .long   0x2F6198    ; Phase 3 extended space
```

### Phase 4.2: Load Balancing

**Current split** (Phase 3):
- Master: Polygons 0-399
- Slave: Polygons 400-799
- Split point: Fixed at 400

**Phase 4 optimization**:
- Measure rendering time per polygon
- Adjust split dynamically: ~25% Slave / 75% Master
- For 800 polygons: Slave might render 150-200, Master 600-650

**Implementation**:
```assembly
; Calculate dynamic split based on polygon count
mov.l   @(POLYGON_COUNT_OFFSET, r14), r3  ; Total count
shll2   r3              ; Multiply by 4 (25% calculation)
mov.l   r3, @(SLAVE_START_OFFSET, r14)
```

### Phase 4.3: Performance Profiling

**Metrics to capture**:
1. Frame counter (already incremented by Slave)
2. Master CPU cycles per frame (via gdb)
3. Slave CPU cycles per frame (via gdb)
4. FPS measurement from game
5. Visual verification (no corruption)

**Profiling code** (add to Slave engine):
```assembly
prof_frame_start:
    mov.l   @(FRT_counter), r0    ; Free-running timer
    mov.l   r0, @(prof_start, PC)  ; Save timestamp

    ; [render operations]

prof_frame_end:
    mov.l   @(FRT_counter), r1
    sub     r0, r1                 ; R1 = elapsed cycles
    mov.l   r1, @(prof_time, PC)   ; Store for analysis
```

---

## Testing Checklist

### Phase 4.0: ROM Stability
- [ ] ROM boots without crashes
- [ ] 32X startup completes normally
- [ ] No "invalid PC" errors
- [ ] Frame counter advances (Slave active)

### Phase 4.1: Function Linking
- [ ] slave_main_loop calls slave_process_polygons ✓
- [ ] slave_process_polygons calls func_023 ✓
- [ ] func_023 successfully calls func_029
- [ ] func_029 → func_032 → func_033 chain works
- [ ] All functions return correctly (no stack corruption)

### Phase 4.2: Rendering Output
- [ ] Lower screen half renders (Slave region)
- [ ] Upper screen half intact (Master region)
- [ ] No pixel corruption between regions
- [ ] Visual quality matches Phase 3

### Phase 4.3: Performance
- [ ] Frame rate measurably improved
- [ ] Slave CPU active (>20% utilization)
- [ ] Master CPU reduced (<75% utilization)
- [ ] Stable for 1000+ frames

---

## Next Immediate Actions

### For Community Implementation
1. **Test Phase 4 ROM**: `build/vrd_phase4_multiregion.32x`
   ```bash
   blastem build/vrd_phase4_multiregion.32x
   ```
   Expected: Should boot (or may fail with broken dispatcher)

2. **Implement function linking** in `sh2_slave_consolidated.asm`
   - Replace BSR calls with JSR absolute addressing
   - Add linker-generated address constants

3. **Validate cross-function execution**
   - Each function should execute and return properly
   - Use breakpoints in gdb to trace execution path

4. **Measure performance improvement**
   - Use frame counter to calculate FPS
   - Compare before/after Phase 4

---

## Risk Mitigation

### Risk 1: Function Address Calculation
**Symptom**: Wrong addresses → illegal instruction
**Mitigation**: Linker automatically calculates and validates all addresses
**Fallback**: Revert to Phase 3.2 stable ROM

### Risk 2: Stack Corruption
**Symptom**: JSR chain overwrites R15 (stack pointer)
**Mitigation**: Verify each function preserves stack
**Fallback**: Limit to 2-level call depth maximum

### Risk 3: ROM Overwrite
**Symptom**: Extended code overflows available space
**Mitigation**: Monitor binary size (<169KB for extended space)
**Fallback**: Move to different ROM location if needed

---

## Files & Artifacts

### Source Files
- `disasm/sh2_slave_consolidated.asm` (updated for Phase 4 linking)
- `tools/sh2_linker_phase4.py` (multi-region linker)

### Build Artifacts
- `build/sh2_slave_phase4.bin` (480 bytes, dual-region)
- `build/vrd_phase4_multiregion.32x` (test ROM)

### Documentation
- This file: `PHASE_4_PLAN.md`
- `PHASE_3_COMPLETION.md` (foundation)

---

## Success Criteria

### Minimum (Phase 4 Complete)
- [x] Multi-region linker working
- [x] Phase 4 ROM created
- [ ] Phase 4 ROM boots without crash
- [ ] Slave functions execute correctly
- [ ] Performance gain measurable (+10%)

### Target (Phase 4 Successful)
- [ ] All rendering functions working
- [ ] Load balanced appropriately
- [ ] Performance gain +20-25%
- [ ] Visual output correct
- [ ] Stable for 1000+ frames

### Stretch (Phase 4 Optimized)
- [ ] Performance gain +30%+
- [ ] Code optimized for speed
- [ ] Perfect visual quality
- [ ] Community-ready production code

---

## Timeline

| Phase | Duration | Status |
|-------|----------|--------|
| 4.0: Infrastructure | ✅ Complete | Rom analysis, linker creation |
| 4.1: Function Linking | 1-2 days | Pending - update sh2_slave_consolidated.asm |
| 4.2: Load Balancing | 1 day | Pending - measure & adjust polygon split |
| 4.3: Performance Profiling | 1-2 days | Pending - measure FPS/CPU gains |
| 4.4: Testing & Validation | 1-2 days | Pending - stability & correctness |

**Total Phase 4**: 5-8 days

---

## References

- **Phase 3 Complete**: `PHASE_3_COMPLETION.md`
- **Phase 3.5 Linker**: `tools/sh2_linker.py`
- **Consolidated Assembly**: `disasm/sh2_slave_consolidated.asm`
- **ROM Map**: 0x2F6000 has 169KB available for Phase 4+ code

---

## Conclusion

**Phase 4 infrastructure is complete and ready for implementation:**
- ✅ Multi-region linker functional
- ✅ Safe ROM space identified and allocated
- ✅ Test ROM created
- ⏳ Awaiting function linking implementation

**Next step**: Update `sh2_slave_consolidated.asm` to enable JSR-based function calls, test Phase 4 ROM, measure performance gains.

