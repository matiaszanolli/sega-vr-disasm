# PicoDrive SH2 Core Investigation

**Created:** 2026-01-26
**Phase:** ROADMAP v4.1 - Phase 1, Task 1.1
**Purpose:** Document PicoDrive build status and identify profiling options

---

## Executive Summary

**Finding:** The custom PicoDrive build in `third_party/picodrive/` is **fundamentally broken for 32X emulation**. It shows "Genesis" instead of "32X" and displays a black screen. This is an emulator issue, not a ROM issue - both v3.0 and v4.0 ROMs work correctly on stock PicoDrive.

**Debug Output Cleanup (Intermediate Finding):**
- Original debug build: 815 lines in 8 seconds
- After cleanup: 21 lines (97.4% reduction)
- Successfully removed excessive printf spam
- **However:** Debug cleanup did NOT fix underlying 32X emulation failure

**Impact on v4.0 Activation:**
- ❌ **Custom PicoDrive**: Fundamentally broken - no 32X emulation, black screen
- ✅ **System PicoDrive**: Works perfectly for both ROMs, but no debug/profiling capabilities
- 🚨 **Critical Blocker**: Cannot use custom build for profiling until 32X support fixed
- 📋 **Alternative needed**: Must find or create profiling solution (MAME, ROM telemetry, or fix custom build)

**Recommendation:** Evaluate alternative profiling approaches (Phase 1, Task 1.3) - custom build is NOT viable

---

## Test Results

### Test 1: System PicoDrive

**Command:**
```bash
picodrive build/vr_rebuild.32x
```

**Result:** ✅ **SUCCESS** - Clean boot, functional gameplay

**Output:**
```
plat_sdl: using 1920x1080 as fullscreen resolution
plat_sdl: overlay: fmt 59565955, planes: 1, pitch: 1280, hw: 1
input: new device #0 "sdl:keys"
input: async-only devices detected..
emu_ReloadRom(build/vr_rebuild.32x)
00000:000: couldn't open carthw.cfg!
00000:000: sram: 200000 - 203fff; eeprom: 0
starting audio: 44100 len: 735 stereo: 1, pal: 0
00003:134: 32X startup
00003:134: drc_cmn_init: 0x60c808eb4000, 2097152 bytes: 0
```

**Key Observations:**
- Boots successfully
- 32X subsystem initializes
- DRC (Dynamic Recompiler) active
- No errors or crashes
- Minimal console output (clean, production build)

**Location:** `/usr/local/bin/picodrive`

**Assessment:** Suitable for ROM testing, but **no profiling/debug capabilities**

---

### Test 2: Custom PicoDrive Build

**Command:**
```bash
third_party/picodrive/picodrive build/vr_rebuild.32x
```

**Result:** ⚠️ **VERBOSE DEBUG BUILD** - Massive console output, unusable for normal use

**Output Statistics:**
- **Lines of output**: 815 lines in 8 seconds
- **File size**: 45.6 KB of debug logs
- **Output rate**: ~100+ lines/second

**Sample Output:**
```
[SH2 RESET] Master: MARS sig=0x00000000
[SH2 RESET] Master: Using ROM 0 vectors - PC=0x00000204 SP=0x06040000 VBR=0x00000000
[SH2 RESET] Slave: MARS sig=0x00000000
[SH2 RESET] Slave: Using ROM 0 vectors - PC=0x00000204 SP=0x0603F800 VBR=0x00000000
[IDL] Copying 0xC000 bytes from ROM 0x020000 to SDRAM 0x000000
[IDL] Copied successfully, DRC flushed, SH-2 code now in SDRAM at 0x000000+
[IDL] Verify direct: SDRAM[0x140]=0x06000544 SDRAM[0x288]=0xD1026012 SDRAM[0x294]=0x06000140
[READ32] addr=0x06000288 map_idx=3 p=0x3000000 mask=0x3FFFC pd=0x6000288 val=0xD1026012
[READ32] addr=0x06000140 map_idx=3 p=0x3000000 mask=0x3FFFC pd=0x6000140 val=0x06000544
[IDL] Verify SH2 read: [0x06000288]=0xD1026012 [0x06000140]=0x06000544
[INIT] Master SH2: PC=0x06000280 SP=0x0603FFF0 VBR=0x06000000
[INIT] Slave SH2: PC=0x06000288 SP=0x0603FFF0 VBR=0x06000140
[SSH2 attempt #1] st=0 cycles=528 next=385058 m68k_done=384530
[SSH2 run #1] PC=06000288 cycles=1266 m68k_done=384530 done_so_far=0
[READ32] addr=0x06000294 map_idx=3 p=0x3000000 mask=0x3FFFC pd=0x6000294 val=0x06000140
[READ32] addr=0x06000140 map_idx=3 p=0x3000000 mask=0x3FFFC pd=0x6000140 val=0x06000544
[SSH2<-COMM2 #1] reg=0x0000 PC=0600058A
[SSH2<-COMM2 #2] reg=0x0000 PC=06000596
[SSH2<-COMM2 #3] reg=0x0000 PC=06000596
[SSH2 attempt #1001] st=0 cycles=487 next=758640 m68k_done=758153
[SSH2 run #1001] PC=0600060A cycles=1168 m68k_done=758153 done_so_far=1173
```

**Debug Information Logged:**
- SH2 reset vectors and initial state
- Memory copies to SDRAM
- Every memory read (address, value, mapping)
- SSH2 (Slave SH2) execution attempts (every 1000 attempts)
- COMM register accesses (every access!)
- PC (Program Counter) values
- Cycle counts
- Stack pointers, VBR (Vector Base Register)

**Location:** `third_party/picodrive/picodrive`

**Assessment:** **NOT USABLE** for profiling due to:
1. Performance overhead from logging (~10-100x slowdown estimated)
2. Console flood makes debugging impossible
3. Log files grow exponentially
4. Can't see actual game state through debug noise

---

### Test 3: Custom PicoDrive Build (Debug Cleanup Attempt)

**Motivation:** Remove excessive debug output to make custom build usable for profiling

**Actions Taken:**
1. Identified 9 printf statements in `pico/32x/32x.c` and `pico/32x/memory.c`
2. Commented out debug logging with `// DEBUG_DISABLED:` prefix
3. Rebuilt: `cd third_party/picodrive && make clean && make`

**Result:** ⚠️ **CONSOLE CLEANUP SUCCESSFUL, BUT 32X EMULATION BROKEN**

**Console Output Statistics (After Cleanup):**
- **Lines of output**: 21 lines (down from 815)
- **Reduction**: 97.4% noise reduction
- **Boot messages preserved**: SH2 RESET, DRC initialization

**Cleaned Output:**
```
warning: failed to do hugetlb mmap (0x2000000, 4194308): 12
plat_sdl: using 1920x1080 as fullscreen resolution
plat_sdl: overlay: fmt 59565955, planes: 1, pitch: 1280, hw: 1
input: new device #0 "sdl:keys"
input: async-only devices detected..
found skin.txt
using sdl audio output driver
emu_ReloadRom(../../build/vr_rebuild.32x)
00000:000: sram: 200000 - 203fff; eeprom: 0
starting audio: 44100 len: 735 stereo: 1, pal: 0
00002:072: 32X startup
00002:072: drc_cmn_init: 0x649046260000, 4194304 bytes: 0
DRC registers created, 15 host regs (3 REG, 2 STATIC, 1 CTX)
[SH2 RESET] Master: MARS sig=0x00000000
[SH2 RESET] Master: Using ROM 0 vectors - PC=0x00000204 SP=0x06040000 VBR=0x00000000
[SH2 RESET] Slave: MARS sig=0x00000000
[SH2 RESET] Slave: Using ROM 0 vectors - PC=0x00000204 SP=0x0603F800 VBR=0x00000000
```

**Console Assessment:** ✅ **SUCCESS** - Clean, readable output with critical boot info preserved

**Graphics/Gameplay Assessment:** ❌ **FAILURE** - Black screen, no 32X emulation

**Critical Discovery: Custom Build 32X Emulation Failure**

**Symptoms:**
- Black screen during gameplay (no graphics rendering)
- Status bar shows "**NTSC Genesis ✓ 60FPS**" instead of "32X"
- Emulator incorrectly identifies 32X ROM as Genesis ROM
- No visual output despite console showing "32X startup"

**Verification:**
- **v3.0 ROM (disasm/vrd_original.32x)**: ❌ Black screen on custom build, ✅ Works on stock PicoDrive
- **v4.0 ROM (build/vr_rebuild.32x)**: ❌ Black screen on custom build, ✅ Works on stock PicoDrive

**Root Cause:**
- **NOT a ROM issue** - Both ROMs work correctly on stock PicoDrive (`/usr/local/bin/picodrive`)
- **Emulator issue** - Custom build has fundamental 32X detection/emulation problem
- Debug output cleanup did NOT cause this issue (issue existed before cleanup)
- Issue is deeper than console spam - likely 32X subsystem initialization failure

**Impact:**
- Custom PicoDrive build is **completely unusable** for 32X ROM testing
- Cannot use for profiling, performance testing, or gameplay validation
- Debug cleanup was successful but insufficient - underlying 32X support is broken

---

## Debug Cleanup Implementation Details

### Original Debug Logging Implementation

**File:** `third_party/picodrive/pico/32x/32x.c`

**Example Debug Code:**
```c
// Debug SSH2 execution attempts (print once per 60 frames)
static unsigned int ssh2_attempt_count = 0;
ssh2_attempt_count++;
if (ssh2_attempt_count % 1000 == 1) {
  printf("[SSH2 attempt #%u] st=%X cycles=%ld next=%u m68k_done=%u\n",
         ssh2_attempt_count, st, cycles, next, ssh2.m68krcycles_done);
}
```

**Analysis:**
- Debug logging is **hardcoded** in source
- Prints every 1000 SSH2 attempts
- Additional logging for COMM registers, memory reads, initialization
- No runtime flag to disable (would require recompilation)

### Build Configuration

**File:** `third_party/picodrive/Makefile`

```make
DEBUG ?= 0
ifeq "$(DEBUG)" "0"
	CFLAGS += -O3 -DNDEBUG
```

**Findings:**
- `DEBUG` defaults to 0 (release mode)
- Custom build appears to be release mode (`-O3 -DNDEBUG`)
- Debug logging is NOT controlled by `DEBUG` flag
- Logging is **custom development code**, not standard debug output

---

## Root Cause Analysis

### Why Custom Build Has Extensive Logging

The custom PicoDrive build in `third_party/picodrive/` was created specifically for **32X development and debugging**. The debug output is intentional and valuable for:

1. **Understanding SH2 Core Behavior**
   - Shows exact PC values during execution
   - Tracks cycle counts
   - Reveals COMM register timing

2. **Debugging 32X ROMs**
   - Verifies SDRAM initialization
   - Monitors Slave SH2 activity
   - Traces inter-CPU communication

3. **Development Tool**
   - Not intended for gameplay
   - Not intended for performance profiling
   - Purpose-built for low-level debugging

### Why This Is "Broken" for Our Use Case

For v4.0 parallel processing activation, we need:

✅ **Cycle-accurate profiling** (measures performance impact)
✅ **COMM register tracing** (validates synchronization)
✅ **Minimal performance overhead** (real-world timing)

❌ **Custom build provides:**
- Excessive logging (performance overhead)
- Unreadable console output (can't extract useful data)
- No structured profiling output (just debug prints)

---

## Comparison Matrix

| Feature | System PicoDrive | Custom PicoDrive (Original) | Custom PicoDrive (Cleaned) | Ideal for v4.0 |
|---------|------------------|---------------------------|--------------------------|----------------|
| **32X Emulation** | ✅ Works | ❌ Black screen | ❌ Black screen | ✅ Required |
| **ROM Detection** | ✅ Detects 32X | ❌ Shows "Genesis" | ❌ Shows "Genesis" | ✅ Required |
| **Clean Console** | ✅ Yes | ❌ 815 lines/8s | ✅ 21 lines | ✅ Required |
| **Performance** | ✅ Full speed | ❌ Slow (~10-100x) | ⚠️ Unknown (no video) | ✅ Required |
| **Profiling** | ❌ None | ⚠️ Debug logs only | ⚠️ Debug logs only | ✅ Required |
| **Cycle Counts** | ❌ None | ✅ Printed (before cleanup) | ❌ Removed | ✅ Required |
| **COMM Tracing** | ❌ None | ✅ All accesses logged | ❌ Removed | ✅ Required |
| **PC Tracking** | ❌ None | ✅ Printed (before cleanup) | ❌ Removed | ⚠️ Nice-to-have |
| **GDB Support** | ❌ Unknown | ❌ Unknown | ❌ Unknown | ✅ Ideal |
| **Structured Output** | N/A | ❌ Just printf | ❌ Just printf | ✅ Required |
| **Usability** | ✅ Production ready | ❌ Unusable (spam) | ❌ Unusable (broken) | ✅ Required |

---

## Actionable Insights

### What Custom Build Revealed (From Original Verbose Output)

Despite the custom build being broken for 32X emulation, the original verbose debug output (before cleanup) provided valuable insights into SH2 initialization:

**1. SH2 Initialization Sequence:**
```
[SH2 RESET] Master: Using ROM 0 vectors - PC=0x00000204 SP=0x06040000 VBR=0x00000000
[SH2 RESET] Slave: Using ROM 0 vectors - PC=0x00000204 SP=0x0603F800 VBR=0x00000000
```
- Master and Slave use same PC (0x00000204)
- Different stack pointers (SP): Master=0x06040000, Slave=0x0603F800
- VBR=0x00000000 (vectors at ROM start)

**2. SDRAM Initialization:**
```
[IDL] Copying 0xC000 bytes from ROM 0x020000 to SDRAM 0x000000
[IDL] Copied successfully, DRC flushed, SH-2 code now in SDRAM at 0x000000+
```
- 48 KB (0xC000) copied from ROM to SDRAM
- DRC (Dynamic Recompiler) flushed after copy
- Code now executable from SDRAM

**3. Slave SH2 Activity:**
```
[SSH2 attempt #1001] st=0 cycles=487 next=758640 m68k_done=758153
[SSH2 run #1001] PC=0600060A cycles=1168 m68k_done=758153 done_so_far=1173
```
- Slave is ACTIVE (not idle!)
- PC=0x0600060A (SDRAM address)
- Executing ~1168 cycles per attempt

**4. COMM Register Patterns:**
```
[SSH2<-COMM2 #1] reg=0x0000 PC=0600058A
[SSH2<-COMM2 #1001] reg=0x0000 PC=06000596
```
- Slave reading COMM2 register
- Value remains 0x0000 (no commands)
- PC varies between 0x060005XX range

**Note:** After debug cleanup, we preserved SH2 RESET messages (insights #1) but lost runtime execution data (insights #2-4). This trade-off eliminated console spam but also removed profiling data.

### Implications for v4.0

**Positive:**
- ✅ Debug output cleanup technique works (97.4% reduction achieved)
- ✅ Stock PicoDrive confirms both v3.0 and v4.0 ROMs are valid
- ✅ Console output shows SH2 initialization messages (informative even if emulation broken)
- ✅ Have working emulator (stock PicoDrive) for ROM validation

**Negative:**
- ❌ **Custom PicoDrive build is completely broken for 32X emulation**
- ❌ Cannot use custom build for any testing (profiling, performance, gameplay)
- ❌ Debug cleanup did NOT fix underlying 32X detection/emulation issue
- ❌ Lost access to cycle counts, COMM tracing, PC tracking after cleanup
- ❌ No profiling solution available for v4.0 activation
- ❌ Cannot validate timing assumptions without profiling tools
- ❌ Phase 1 blocked until alternative profiling approach identified

---

## Next Steps (Phase 1, Task 1.2 & 1.3)

### ~~Option A: Modify Custom Build~~ ❌ ATTEMPTED - FAILED

**Task:** Remove debug printf statements, rebuild

**Status:** **COMPLETED BUT INSUFFICIENT**

**Result:**
- ✅ Console cleanup successful (97.4% reduction)
- ❌ Custom build still fundamentally broken for 32X emulation
- ❌ Black screen, shows "Genesis" instead of "32X"
- ❌ Issue is deeper than debug output spam

**Conclusion:** Debug cleanup alone cannot fix custom PicoDrive. Underlying 32X detection/emulation is broken.

**Pros (Realized):**
- Quick to implement (~1 hour)
- Successfully cleaned console output
- Preserved critical boot messages

**Cons (Realized):**
- Did NOT fix 32X emulation
- Lost profiling data (cycle counts, COMM traces) without gaining working emulator
- Custom build remains unusable for any purpose

---

### Option A2: Fix Custom Build 32X Emulation

**Task:** Investigate and repair 32X detection/emulation in custom PicoDrive build

**Effort:** High (8-16 hours, potentially days)

**Steps:**
1. Compare custom build source with stock PicoDrive source
2. Identify divergences in 32X detection code
3. Check build configuration differences (Makefile, defines)
4. Test 32X ROM detection logic
5. Debug why emulator shows "Genesis" instead of "32X"
6. Verify 32X VDP (Video Display Processor) initialization
7. Fix and rebuild iteratively

**Pros:**
- If successful, restores full profiling capability
- Keeps all custom debug infrastructure
- Full control over codebase

**Cons:**
- **Very high effort** - deep debugging required
- May require significant PicoDrive internals knowledge
- Unknown if fixable without upstream PicoDrive updates
- Could take days/weeks with no guarantee of success
- Risky time investment given v4.0 activation deadline

**Risk Assessment:** **HIGH** - Unknown root cause, potentially unfixable

---

### Option B: Research MAME SH2 Core

**Task:** Investigate MAME's SH2 emulation and debugging tools

**Effort:** Medium (4-8 hours)

**Steps:**
1. Clone MAME repository
2. Locate SH2 core implementation
3. Check for debugger integration
4. Test 32X ROM support in MAME

**Pros:**
- Official, well-maintained codebase
- Built-in debugger
- Shared with PicoDrive (similar core)

**Cons:**
- Learning curve
- May not support 32X as well as PicoDrive
- Unknown if debugger supports profiling

---

### Option C: Cycle-Accurate Logging in ROM

**Task:** Inject telemetry code into v4.0 ROM

**Effort:** Medium (2-4 hours)

**Steps:**
1. Add cycle counters to Master/Slave code
2. Write counts to COMM registers
3. Capture COMM values via external script
4. Post-process for profiling data

**Pros:**
- Platform-independent (works on any emulator)
- Precise measurements
- Already have expansion ROM space

**Cons:**
- Invasive (modifies ROM)
- Manual instrumentation
- Limited to cycle counts (not full profiling)

---

### Option D: Use System PicoDrive (Limited)

**Task:** Accept limited profiling, rely on qualitative testing

**Effort:** None (already available)

**Steps:**
1. Use system PicoDrive for ROM testing
2. Measure FPS subjectively (visual observation)
3. Use COMM5 counter for work tracking
4. Defer precise profiling to later

**Pros:**
- No additional work
- Can proceed with Phase 2 (trampolining)
- v4.0 activation doesn't strictly require profiling

**Cons:**
- No empirical performance data
- Can't validate timing assumptions
- Risky to activate without measurements

---

## Recommendation

**Status Update:**
- ✅ **Option A attempted** - Console cleanup successful, but 32X emulation still broken
- ❌ **Custom PicoDrive unusable** - Black screen, shows "Genesis" not "32X"
- ✅ **Both ROMs validated** - v3.0 and v4.0 work correctly on stock PicoDrive

**Immediate Decision Required:**

Given custom PicoDrive is fundamentally broken, we have three paths forward:

**Path 1: Fix Custom Build (High Risk, High Reward)**
- Pursue Option A2 (investigate/fix 32X emulation issue)
- **Effort**: 8-16+ hours, potentially days
- **Risk**: Unknown root cause, may not be fixable
- **Reward**: Full profiling capability if successful
- **Recommendation**: ⚠️ **Only if we have deep PicoDrive knowledge or can get upstream help**

**Path 2: Alternative Profiling Tools (Medium Risk, Medium Reward)**
- Pursue Option B (MAME SH2 core investigation)
- **Effort**: 4-8 hours research + setup
- **Risk**: MAME may not support 32X well, debugger may not have needed features
- **Reward**: Industry-standard debugger, well-documented
- **Recommendation**: ✅ **RECOMMENDED** - Good balance of effort vs. reward

**Path 3: ROM-Based Telemetry (Low Risk, Limited Reward)**
- Pursue Option C (inject cycle counters into ROM code)
- **Effort**: 2-4 hours implementation
- **Risk**: Low - we control the ROM
- **Reward**: Cycle counts only, no full profiling
- **Recommendation**: ⚠️ **Fallback if Option B fails**

**Path 4: Proceed Without Profiling (Low Risk, High Long-Term Risk)**
- Pursue Option D (use stock PicoDrive, qualitative testing only)
- **Effort**: None
- **Risk**: **HIGH** - Activating v4.0 without performance validation is risky
- **Recommendation**: ❌ **NOT RECOMMENDED** - Too risky for parallel processing activation

---

**Recommended Action Plan:**

1. **Phase 1, Task 1.3:** Research MAME SH2 core (Option B)
   - Investigate MAME 32X support
   - Check debugger capabilities
   - Test with our ROMs
   - Estimate profiling feasibility

2. **If MAME insufficient:** Implement ROM telemetry (Option C)
   - Add cycle counters to Master/Slave code
   - Use COMM registers for data export
   - Measure performance empirically

3. **Defer custom PicoDrive fix** (Option A2)
   - Only pursue if Options B & C both fail
   - Or if we get help from PicoDrive maintainers
   - Too high risk/effort for immediate path

4. **Proceed to Phase 2** (trampolining) in parallel
   - Don't block all progress on profiling
   - Can test trampolines on stock PicoDrive
   - Verify code safety without performance data

---

## References

**Files Analyzed:**
- [third_party/picodrive/pico/32x/32x.c](../../../third_party/picodrive/pico/32x/32x.c) - SH2 debug logging
- [third_party/picodrive/Makefile](../../../third_party/picodrive/Makefile) - Build configuration

**Test Logs:**
- System PicoDrive: Clean boot, working 32X emulation
- Custom PicoDrive (Original): `/tmp/picodrive_custom_test.log` (815 lines, 45.6 KB)
- Custom PicoDrive (Cleaned): `/tmp/picodrive_cleaned_test.log` (21 lines, clean console)

**Modified Files:**
- [third_party/picodrive/pico/32x/32x.c](../../../third_party/picodrive/pico/32x/32x.c) - 6 debug printfs disabled
- [third_party/picodrive/pico/32x/memory.c](../../../third_party/picodrive/pico/32x/memory.c) - 3 debug printfs disabled

**Related Roadmap:**
- [ROADMAP_v4.1.md](../../ROADMAP_v4.1.md) - Phase 1: Restore Profiling Capability

**Test ROMs:**
- [build/vr_rebuild.32x](../../../build/vr_rebuild.32x) - v4.0 4MB ROM (✅ works on stock PicoDrive)
- [disasm/vrd_original.32x](../../../disasm/vrd_original.32x) - v3.0 original ROM (✅ works on stock PicoDrive)

---

**Document Status:** Complete - Phase 1, Task 1.1 Investigation Finished

**Findings:**
1. ✅ Debug output cleanup successful (97.4% reduction: 815→21 lines)
2. ❌ Custom PicoDrive has fundamental 32X emulation failure (black screen, shows "Genesis")
3. ✅ Both v3.0 and v4.0 ROMs validated on stock PicoDrive (not a ROM issue)
4. ❌ Custom build is unusable for any purpose until 32X support fixed

**Phase Status:** Phase 1, Task 1.1 **COMPLETE** (investigation done)

**Next Task:** Phase 1, Task 1.3 - Evaluate alternative profiling approaches
- **Recommended:** Option B (MAME SH2 core investigation)
- **Fallback:** Option C (ROM-based telemetry)
- **Deferred:** Option A2 (fix custom PicoDrive) - too high risk/effort

**Decision Point:** Custom PicoDrive is NOT viable → Must pursue alternative profiling solution before v4.0 activation
