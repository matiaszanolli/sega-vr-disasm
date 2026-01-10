# Phase 3: Slave Rendering Functions - Implementation Plan

## Objective

Add rendering functions to Slave SH2, enabling it to process a portion of polygons independently. This demonstrates parallelization benefits while keeping Master code unchanged.

## Current Status

✅ **Phase 1 Complete**: Slave engine active, responds to work dispatch
⏸ **Phase 2 Paused**: Master sync protocol designed, ROM patching deferred
→ **Phase 3 Starting**: Add Slave rendering functions

## Key Insight

**We don't need to modify Master code for Phase 3!** Instead:
- Slave has Phase 1 engine (work dispatcher loop)
- Slave can process polygons independently
- Master continues normal rendering
- Both CPUs process polygons in parallel on different ranges

This is safer and demonstrates real parallelization benefits.

---

## Phase 3 Architecture

### Polygon Split

```
Display List (800 polygons total):
  Master: Polygons 0-399 (original code path)
  Slave:  Polygons 400-799 (new functions)
```

### Frame Buffer Partition

```
Frame Buffer (0x24000000, 448 × 224 pixels):
  Master: Lines 0-111 (upper half)
  Slave:  Lines 112-223 (lower half)
```

### Memory Layout (SDRAM)

```
0x22000400: Sync buffer (from Phase 1)
  ├─ MASTER_READY / SLAVE_READY / MASTER_DONE / SLAVE_DONE
  ├─ POLYGON_COUNT = 800
  ├─ SLAVE_START = 400
  ├─ SLAVE_END = 799
  └─ Other parameters

0x22001000: Polygon bounds cache (Phase 3.5, optional)
  └─ 800 × 4 bytes = 3.2 KB

0x22040000: Slave scratch RAM
  └─ Temporary variables, call stack
```

---

## Phase 3 Implementation Stages

### Stage 3.0: Polygon Bounds Parsing

**Goal**: Extract bounding box for each polygon (min/max X, Y)

**Why**: Enables spatial partitioning - Slave only renders polygons visible in lower half

**Functions to create**:
- `parse_polygon_bounds()`: Scans display list, extracts bounds
- Stores in SDRAM at 0x22001000
- Called once per frame by Master (or Slave, after sync setup)

**Size estimate**: 60-80 bytes assembly
**Complexity**: Medium (display list parsing)

### Stage 3.1: Simplest Rendering Function - func_029

**Original function**: Region code generation (82 bytes in Master)

**Purpose**: Compute Cohen-Sutherland region codes for polygon vertices

**Why start here**:
- Pure computation (no frame buffer writes)
- No complex state management
- Safe to test independently
- Can verify output against Master's calculation

**Modifications for Slave**:
- Input: Polygon vertex data (from display list)
- Output: Region codes (to scratch RAM)
- No special partition handling needed

**Size estimate**: 90-100 bytes
**Complexity**: Low
**Risk**: Very low (read-only operation)

### Stage 3.2: Second Function - func_032

**Original function**: Scanline fill (32 bytes in Master)

**Purpose**: Fill polygon rows to frame buffer

**Why add next**:
- Uses func_029 output (region codes)
- Actually writes to frame buffer (tests partition logic)
- Moderate complexity, well-isolated

**Modifications for Slave**:
- Frame buffer offset: +71,680 bytes (start at line 112)
- Only fill scanlines in Slave's vertical range
- Polygon bounds check: Skip if outside lower half

**Size estimate**: 40-50 bytes
**Complexity**: Medium
**Risk**: Medium (frame buffer writes, must not overwrite)

### Stage 3.3: Third Function - func_033

**Original function**: Polygon rendering (98 bytes in Master)

**Purpose**: Clip polygon to viewport bounds, setup fill

**Why add third**:
- Calls func_032 (scanline fill)
- More complete than stages 3.1-3.2
- Tests multi-function integration

**Modifications for Slave**:
- Same partition handling as func_032
- Use Slave's frame buffer region only

**Size estimate**: 110-120 bytes
**Complexity**: High
**Risk**: Medium (complex logic, but isolated to Slave)

### Stage 3.4: Final Function - func_023

**Original function**: Frustum culler / main dispatcher (242 bytes in Master)

**Purpose**: Visibility tests, branches to appropriate rendering path

**Why add last**:
- Calls func_024, func_026, func_029, func_032, func_033
- Ties everything together
- Must not break Master's func_023 calls

**Modifications for Slave**:
- Skip Master-specific setup (func_024, func_026)
- Use Slave's frame buffer base
- Respect polygon bounds

**Size estimate**: 260-300 bytes
**Complexity**: Very high
**Risk**: High (complex state, many dependencies)

---

## Implementation Steps

### Step 1: Extract Function Code

From `sh2_3d_engine_annotated.asm`:
- func_029 (line 838)
- func_032 (line 921)
- func_033 (line 985)
- func_023 (line 178)

Extract to `disasm/sh2_slave_rendering_stage_X.asm` files.

### Step 2: Modify for Slave Context

For each function:
1. Change R14 base (frame buffer offset for Slave)
2. Add polygon bounds checking
3. Adjust relative jumps if needed
4. Update any hard-coded addresses

### Step 3: Assemble and Verify

```bash
sh-elf-as -o build/sh2_slave_rendering_3X.o disasm/sh2_slave_rendering_stage_X.asm
sh-elf-objcopy -O binary build/sh2_slave_rendering_3X.o build/sh2_slave_rendering_3X.bin
```

### Step 4: Inject into ROM

Append to Slave engine code in ROM:
- Phase 1: Slave engine at 0x20650 (112 bytes) - DONE
- Phase 3.0: Bounds parser at 0x206D0 (~80 bytes)
- Phase 3.1: func_029 at 0x20730 (~100 bytes)
- Phase 3.2: func_032 at 0x207A0 (~50 bytes)
- Phase 3.3: func_033 at 0x207F0 (~120 bytes)
- Phase 3.4: func_023 at 0x20870 (~300 bytes)

**Total Phase 3 size**: ~650 bytes (fits comfortably after existing code)

### Step 5: Update Slave Main Loop

Modify `disasm/sh2_slave_engine.asm`:
- Call `parse_polygon_bounds()` if not done by Master
- Main loop calls `slave_process_polygons()`
- `slave_process_polygons()` now calls rendering functions instead of stub loop

### Step 6: Test Incrementally

After each stage:
1. Rebuild Phase 3 ROM with updated functions
2. Boot on emulator
3. Verify:
   - ROM still boots
   - Slave processes polygons (frame counter advances)
   - No corruption or hangs
   - Visual output improves progressively

---

## Function Dependencies

```
slave_func_023 (Frustum Culler)
  ├─ slave_func_024 (Setup) [SKIP - use Master's version or inline]
  ├─ slave_func_026 (Setup) [SKIP - use Master's version or inline]
  ├─ slave_func_029 (Region Codes)
  │   └─ (pure computation, no calls)
  ├─ slave_func_032 (Scanline Fill)
  │   └─ slave_func_029 (for region codes)
  ├─ slave_func_033 (Polygon Rendering)
  │   └─ slave_func_032 (for scanlines)
  └─ slave_func_036 (Special rendering) [OPTIONAL]
```

**Build order**:
1. func_029 (independent)
2. func_032 (depends on func_029)
3. func_033 (depends on func_032)
4. func_023 (ties everything together)

---

## Frame Buffer Management

### Master's Region (Upper Half)

- Lines 0-111 (71,680 bytes from 0x24000000)
- Master renders normally here
- Slave reads RenderingContext but doesn't write here

### Slave's Region (Lower Half)

- Lines 112-223 (71,680 bytes from 0x24011800)
- Slave renders here exclusively
- Master reads/writes to upper half only
- No coherency issues since disjoint regions

### Offset Calculation

```
Frame buffer base: 0x24000000
Slave offset: 112 lines × 512 bytes/line = 57,344 bytes = 0xE000

Actually, for Virtua Racing:
- 448 pixels wide, but stored as 512 bytes per line (padding)
- 224 lines total
- Slave starts at line 112
- Offset = 112 × 512 = 57,344 = 0xE000

Slave region base = 0x24000000 + 0xE000 = 0x2400E000
```

### Memory Barriers

**Before Slave starts rendering**:
- Master clears its region to background
- Slave clears its region to background
- Both read from same RenderingContext (read-only, safe)

**After rendering**:
- VDP reads both regions sequentially
- Display combines upper + lower halves
- No synchronization needed (fixed schedule)

---

## Testing Strategy

### Test 1: Phase 3.0 - Bounds Parsing

- [x] Code compiles and assembles
- [ ] Slave calls parse_polygon_bounds()
- [ ] SDRAM contains valid bounds data
- [ ] Both CPUs can read bounds correctly

### Test 2: Phase 3.1 - func_029

- [ ] ROM boots normally
- [ ] Slave processes polygons 400-799
- [ ] Region codes computed correctly
- [ ] No corruption or hangs

### Test 3: Phase 3.2 - func_032

- [ ] ROM boots normally
- [ ] Slave writes to frame buffer (lower half only)
- [ ] Visual rendering appears (partial)
- [ ] No pixel corruption in Master's region

### Test 4: Phase 3.3 - func_033

- [ ] ROM boots normally
- [ ] Slave renders full polygons
- [ ] Complex shapes render correctly
- [ ] No visual artifacts

### Test 5: Phase 3.4 - func_023

- [ ] ROM boots normally
- [ ] Full parallelization working
- [ ] Frame rate measurably faster
- [ ] Graphics render correctly
- [ ] Stable for 100+ frames

---

## Success Criteria

### Minimum (Phase 3 Complete)

- ✅ Slave rendering code compiles and assembles
- ✅ ROM boots without crashing
- ✅ Slave processes polygons (frame counter advances)
- ✅ Visual changes from Phase 1 (proof of code execution)
- ✅ No hangs or infinite loops

### Target (Phase 3 Successful)

- ✅ Lower half of screen renders (Slave output visible)
- ✅ Upper half still intact (Master output correct)
- ✅ Frame rate noticeably faster (+10-15%)
- ✅ No visual artifacts or corruption
- ✅ Stable for 1000+ frames

### Stretch (Phase 3 Optimized)

- ✅ Frame rate +20-30%
- ✅ Perfect visual quality
- ✅ Load balanced (both CPUs ~50% utilization)
- ✅ Dynamic polygon split based on complexity
- ✅ Full optimization for parallel execution

---

## Risk Assessment

| Stage | Risk Level | Mitigation |
|-------|-----------|-----------|
| 3.0 - Bounds parsing | Low | Read-only SDRAM writes, easy to verify |
| 3.1 - func_029 | Low | Pure computation, no side effects |
| 3.2 - func_032 | Medium | Frame buffer writes, must respect boundaries |
| 3.3 - func_033 | Medium | Complex logic, but isolated to Slave |
| 3.4 - func_023 | High | Main dispatcher, many dependencies |

**Mitigation strategy**:
- Test each stage independently
- Keep Phase 1 ROM as fallback (revert if issues)
- Use frame counter to verify progress
- Monitor COMM registers for state

---

## Timeline Estimate

| Stage | Effort | Duration |
|-------|--------|----------|
| 3.0 - Bounds parser | 2-3 hours | 1 day |
| 3.1 - func_029 | 2-3 hours | 1 day |
| 3.2 - func_032 | 3-4 hours | 1-2 days |
| 3.3 - func_033 | 4-5 hours | 1-2 days |
| 3.4 - func_023 | 6-8 hours | 2-3 days |
| Integration + Testing | 8-12 hours | 2-3 days |
| **Total Phase 3** | **25-35 hours** | **5-7 days** |

---

## Deliverables

### Code Files

- `disasm/sh2_slave_rendering_stage_0.asm` - Bounds parser
- `disasm/sh2_slave_rendering_stage_1.asm` - func_029
- `disasm/sh2_slave_rendering_stage_2.asm` - func_032
- `disasm/sh2_slave_rendering_stage_3.asm` - func_033
- `disasm/sh2_slave_rendering_stage_4.asm` - func_023

### Binary Artifacts

- `build/sh2_slave_rendering_*.bin` - Assembled binaries

### Test ROMs

- `build/vrd_phase3_stage0.32x` - With bounds parser
- `build/vrd_phase3_stage1.32x` - With func_029
- `build/vrd_phase3_stage2.32x` - With func_032
- `build/vrd_phase3_stage3.32x` - With func_033
- `build/vrd_phase3_stage4.32x` - With func_023 (complete)

### Documentation

- `PHASE_3_PROGRESS.md` - Stage-by-stage progress log
- `PHASE_3_ANALYSIS.md` - Technical analysis and findings
- Performance measurements and benchmarks

---

## Next Steps

1. **Extract rendering functions** from sh2_3d_engine_annotated.asm
2. **Create Stage 3.0** - Bounds parser (simple starting point)
3. **Test Stage 3.0** - Verify SDRAM writes work
4. **Proceed incrementally** through stages 3.1-3.4
5. **Measure performance** at each stage
6. **Document findings** for Phase 4 optimization

---

## Decision Point

**Ready to begin Phase 3?**

Start with Stage 3.0 (bounds parser) and work through stages incrementally, testing each ROM before proceeding to the next stage.

**Estimated time to first visible parallelization benefit**: 2-3 days (through Stage 3.2)
**Estimated time to full Phase 3**: 5-7 days
