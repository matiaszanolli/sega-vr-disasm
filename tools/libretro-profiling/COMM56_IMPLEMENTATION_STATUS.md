# COMM5/COMM6 Profiling Implementation Status

**Date:** 2026-02-03
**Branch:** optimization-attempt-1
**Phase:** v4.4.0 - Phase 1 Infrastructure Complete, Awaiting func_021 Execution

## Summary

Successfully implemented complete COMM5/COMM6 tracking infrastructure for Phase 1 validation. V4 profiler built and verified working. Phase 1 ROM confirmed with correct trampoline addressing. **Critical finding:** func_021 (vertex transform) is not called during autoplay/attract mode, preventing timing validation. Manual gameplay testing required to trigger 3D rendering code paths.

## ✅ Completed Components

### 1. Phase 1 ROM Implementation
**Status:** Complete and tested
**Location:** `disasm/sh2/expansion/func_021_conditional.asm`

- ✅ func_021_conditional increments COMM6 ($2000402C) on each Master call
- ✅ Master signals Slave via COMM7 ($2000402E) = 0x16
- ✅ Slave increments COMM5 ($2000402A) when acknowledging signal
- ✅ Trampoline activated at $0234C8 redirecting to $02300438
- ✅ Slave hybrid wrapper at $02300200 handles COMM7 acknowledgement

**Verification:** Phase 1 ROM tested successfully - game runs without crashes in attract mode and racing.

### 2. v4 Profiler Patch
**Status:** Complete, needs application
**Location:** `tools/libretro-profiling/libretro_vrd_profiling_v4_comm56.patch`

**Changes:**
- Added COMM5/COMM6 sampling before/after each frame
- Updated CSV header: `frame,m68k_cycles,msh2_cycles,ssh2_cycles,comm5_before,comm5_after,comm6_before,comm6_after,comm7_before,comm7_after,is_32x`
- Modified fprintf to log COMM5/COMM6 values
- All PC-level profiling from v3 preserved

**Size:** 333 lines (12.8 KB)

### 3. Analysis Script Updates
**Status:** Complete
**Location:** `tools/libretro-profiling/analyze_profile.py`

**New Features:**
- Reads COMM5/COMM6 columns from CSV
- Calculates gap (COMM6 - COMM5) = pending work
- Status interpretation:
  - Gap = 0: "PERFECT SYNC - Slave keeping up"
  - Gap 1-10: "EXCELLENT - Slave nearly keeping up"
  - Gap 11-100: "GOOD - Minor lag"
  - Gap > 100: "FALLING BEHIND - Can't keep up"
- Displays signals/frame and ACKs/frame throughput

### 4. Build Infrastructure
**Status:** Complete
**Location:** `tools/libretro-profiling/build_with_comm56_profiling.sh`

- Build script created and made executable
- Documentation written: `README_COMM56_PROFILING.md`
- Usage examples provided

## ⚠️ Outstanding Issues

### func_021 Not Called During Autoplay
**Problem:** COMM5/COMM6 registers remain 0x0000 during 600-2400 frame autoplay profiles
**Root Cause:** func_021 (vertex transform) is not invoked during attract mode/autoplay
**Investigation Completed:**
1. ✅ Profiler working correctly (verified with test writes 0xAAA5/0xBBB6/0xCCC7)
2. ✅ COMM register indices correct (regs[21]=COMM5, regs[22]=COMM6, regs[23]=COMM7)
3. ✅ Trampoline correct at ROM 0x234C8 → 0x02300438
4. ✅ func_021_conditional present at 0x300438 with COMM6 increment
5. ❌ func_021 simply not called in test scenario

**Impact:** Cannot validate Phase 1 timing with autoplay profiling

## 🔍 Debugging Session Findings (2026-02-03)

### Issue #1: Address Mismatch (RESOLVED)
- **Problem:** Documentation claimed func_021_conditional at 0x300440
- **Reality:** Actual location is 0x300438 (8-byte offset)
- **Root Cause:** Padding calculation comment in expansion_300000.asm was incorrect
- **Fix:** None needed - trampoline was already correct at 0x02300438
- **Lesson:** Always verify addresses with `xxd` on actual ROM, don't trust comments

### Issue #2: Profiler Register Indices (RESOLVED)
- **Problem:** Initially used regs[5/6/7] for COMM5/6/7
- **Reality:** COMM registers use byte-offset/2: regs[21/22/23]
- **Verification:** Test writes (0xAAA5/0xBBB6/0xCCC7) confirmed correct indices
- **Status:** Profiler correctly samples COMM registers

### Issue #3: func_021 Not Executed (ONGOING)
- **Problem:** All COMM registers read 0x0000 across 600-2400 frame profiles
- **Verification:** Trampoline present at 0x234C8, points to 0x02300438 ✓
- **Verification:** func_021_conditional present at 0x300438 with COMM6 code ✓
- **Conclusion:** func_021 is simply not called during autoplay/attract mode
- **Next Action:** Test with manual gameplay to trigger 3D vertex transforms

## 🔧 Resolution Options

### Option A: Manual Gameplay Testing (Recommended)
Test with actual gameplay where 3D rendering is guaranteed:

1. ✅ V4 profiler built with COMM5/COMM6 tracking in libretro.c
2. ✅ Phase 1 ROM verified with trampoline at correct address
3. ⏳ Test with MANUAL gameplay (not --autoplay):
   ```bash
   VRD_PROFILE_LOG=phase1_manual.csv ./profiling_frontend ../../build/vr_rebuild.32x 1800
   # Manually select race, drive for 30 seconds
   ```
4. Check if COMM6 increments during active racing

### Option B: Profile Different Code Path
func_021 may only be called in specific 3D scenarios. Alternative approaches:

1. Search for hot functions that ARE called during autoplay
2. Use PC-level profiling to identify frequently executed SH2 addresses
3. Hook a different function that's guaranteed to execute

### Option C: GDB Breakpoint Verification
Verify func_021 execution with debugger:
1. Set breakpoint at 0x0234C8 (func_021 entry)
2. Run game in PicoDrive with debugging
3. Confirm if breakpoint ever hits during gameplay

## 📊 Expected Results

Once v4 profiler is working, expected output for Phase 1:

```
=== PHASE 1 PARALLEL PROCESSING ANALYSIS ===
COMM6 = Master signals sent | COMM5 = Slave acknowledgements

Cumulative Counters (after 1800 frames):
  COMM6 (Master signals):  ~7,200  (4 calls/frame * 1800 frames)
  COMM5 (Slave ACKs):      ~7,200  (should match COMM6 if keeping up)
  Gap (pending work):      0-10    (target: minimal gap)
  Status: PERFECT SYNC or EXCELLENT

Throughput:
  Master signals/frame: ~4.0
  Slave ACKs/frame:     ~4.0
```

## 🎯 Next Steps

1. ✅ **DONE:** Built v4 profiler binary with COMM5/COMM6 tracking
2. ✅ **DONE:** Verified Phase 1 ROM trampoline at correct address (0x234C8 → 0x02300438)
3. ✅ **DONE:** Confirmed func_021_conditional present with COMM6 increment code
4. ⏳ **TODO:** Test with manual gameplay (not autoplay) to trigger func_021 calls:
   ```bash
   VRD_PROFILE_LOG=phase1_manual.csv ./profiling_frontend ../../build/vr_rebuild.32x 1800
   ```
5. **Alternative:** Use PC-level profiling to identify which SH2 functions ARE called during autoplay
6. **Analyze:** Once COMM6 > 0, run `python3 analyze_profile.py phase1_manual.csv`
7. **Validate:** Confirm gap ≈ 0 (Slave keeping up)
8. **Decision:** If gap acceptable, proceed to Phase 2 (Slave does actual work)

## 📁 Files Modified/Created

### New Files
- `tools/libretro-profiling/libretro_vrd_profiling_v4_comm56.patch` (333 lines)
- `tools/libretro-profiling/build_with_comm56_profiling.sh` (executable)
- `tools/libretro-profiling/README_COMM56_PROFILING.md` (115 lines)
- `tools/libretro-profiling/COMM56_IMPLEMENTATION_STATUS.md` (this file)

### Modified Files
- `tools/libretro-profiling/analyze_profile.py` (added COMM5/COMM6 analysis section)
- `disasm/sh2/trampolines/func_021_trampoline.inc` (updated comments for Phase 1 description)

### Unchanged (Already Working)
- `disasm/sh2/expansion/func_021_conditional.asm` (COMM6 increment already present)
- `disasm/sh2/expansion/slave_work_wrapper_hybrid.asm` (COMM5 increment already present)
- `build/vr_rebuild.32x` (Phase 1 ROM, 4.0 MB, built Feb 2 22:38)

## 📈 Success Criteria

Phase 1 validation is successful when:
1. ✅ ROM runs without crashes (already confirmed)
2. ⏳ COMM5/COMM6 gap remains ≤ 10 during gameplay
3. ⏳ Slave acknowledgement rate ≈ Master signal rate
4. ⏳ No frame drops or stuttering observed

Once validated, proceed to **Phase 2**: Slave executes actual work (calls func_021_optimized).

## 🔗 Related Documentation

- `OPTIMIZATION_PLAN.md` - Overall 60 FPS roadmap
- `analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md` - Root cause analysis
- `tools/libretro-profiling/README_68K_PC_PROFILING.md` - v3 profiler docs
- `disasm/sh2/expansion/func_021_conditional.asm` - Phase 1 implementation source
