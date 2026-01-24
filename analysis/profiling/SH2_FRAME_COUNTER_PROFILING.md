# SH2 Frame Counter Profiling Guide

## Overview

Virtua Racing Deluxe runs on a dual-CPU system with asynchronous frame rates:

- **Mega Drive (68000)**: Fixed 60 Hz V-INT (vertical interrupt) timing
- **32X (SH2)**: Variable frame rate rendering (~20 FPS baseline, heavily fluctuating)

The V-INT counter (`$C964`) increments at 60 Hz fixed rate and is **not useful for profiling SH2 performance**.

We need to measure **actual SH2 frame output** to establish a baseline and compare optimizations.

## Architecture: Two Frame Systems

### Mega Drive Frame (V-INT) - Fixed 60 Hz

```
V-INT fires 60 times per second
$C964 increments 60 times per second
Does NOT correlate with SH2 rendering speed
Used for: Game timing, input polling, audio sync
```

Location: `/mnt/data/src/32x-playground/disasm/sections/code_16xx.asm` (~line 1684)

### SH2 Frame - Variable Rate

```
SH2 displays new rendered frame when:
1. Display list fully processed (0x0C command terminator found)
2. All VDP command buffers finalized (0xFF written)
3. final_exit code executed (0x0222399A)

This happens ~20 times per second (heavily fluctuating)
```

Location: `/mnt/data/src/32x-playground/disasm/sh2_3d_engine_annotated.asm` (lines 3635-3667)

## SH2 Display List Processing Pipeline

### Display List Processor (func_001)

**Address**: CPU `0x0222301C` - `0x02223064` | ROM `0x01301C` - `0x013064`

```assembly
func_001: Display List Command Loop
  Command source: R13 (display list buffer pointer)
  Loop condition: Read command, check if opcode == 0x0C (terminator)

  When 0x0C found:
    - Exit loop immediately
    - Return to caller (main rendering loop)
    - Frame rendering begins
```

The **0x0C opcode** is the critical boundary marker for display list completion.

### Frame Rendering (func_023-func_036)

**Address**: CPU `0x022237A0` - `0x022239A8` | ROM `0x0137A0` - `0x0139A8`

```assembly
func_023 (hub function):
  - Routes to rendering functions based on visibility tests
  - Calls func_024-036 to rasterize geometry
  - Fills frame buffers with pixel data

func_029 (quad fill):
  - Scanline-based rasterization
  - Writes to frame buffer at 0x24000000 (SH2 side)

func_036 (line renderer):
  - Similar scanline iteration
  - Also writes to frame buffer
```

### Final Exit (Frame Completion)

**Address**: CPU `0x0222399A` - `0x022239A8` | ROM `0x01399A` - `0x0139A8`

```assembly
final_exit:
  022239A8  000B     RTS                       ; Return from frame processing
  022239AA  1E69     MOV.L R6,@($24,R14)      ; Store updated value (delay slot)
```

**This is the exact point where one SH2 frame completes.**

## SH2 Frame Counter Implementation

### Hook Point

**Location**: ROM offset `0x023A9A` (SH2 final_exit)

**CPU Address**: `0x0222399A` (for SH2 code)

**Trigger**: Executed exactly once per SH2 frame at frame completion

### Storage Location

**SDRAM Address**: `0x22000400` (32-bit word)

- **Accessible from**:
  - SH2 cache addressing: `0x02000400`
  - SH2 cache-through addressing: `0x22000400`
  - 68K: NOT directly accessible (different address space)
  - Emulator debugger: `0x22000400`

- **Size**: 4 bytes (32-bit long word)
- **Wrapping**: Will overflow at 4,294,967,296 frames (~191 days at 20 FPS)
- **Access speed**: Word or longword only (8-bit and 16-bit may not work correctly)

### Counter Code

**Injected at ROM**: `0x02DD5C`

**CPU Address**: `0x0202DD5C`

**Size**: 16 bytes

**Function**:
```
MOV.L @(8,PC),R0       ; Load counter address (0x22000400) into R0
MOV.L @R0,R1           ; Load current counter value
ADD #1,R1              ; Increment by 1
MOV.L R1,@R0           ; Store back to counter
RTS                    ; Return
NOP                    ; Delay slot
```

**Performance**: ~10 clock cycles per frame (~0.5 μs at 23 MHz)

## Profiling Methodology

### Benchmark Setup

**Duration**: Exactly 60 seconds of real time (wall clock)

**Test Scenario**: Consistent gameplay conditions
- Same track / menu screen
- Same difficulty / configuration
- Same emulator settings
- Same ROM version (with/without optimizations)

### Measurement Procedure

```
BASELINE TEST:
1. Load ROM in emulator
2. Start stopwatch (real time)
3. Note frame counter value at 0x22000400 (start_value)
4. Play for exactly 60 seconds
5. Note frame counter value again (end_value)
6. Stop stopwatch
7. Calculate: frames_rendered = end_value - start_value
8. Expected: ~1200 frames (20 FPS × 60s)

OPTIMIZATION TEST:
9. Load optimized ROM
10. Repeat steps 2-7
11. Compare: new_frames / baseline_frames = speedup factor
```

### Expected Baseline

| Scenario | Duration | Expected Frames | Expected FPS |
|----------|----------|-----------------|--------------|
| Garage menu | 60s | ~3600 | 60 |
| Race (20 FPS) | 60s | ~1200 | 20 |
| Heavy traffic | 60s | ~800-1000 | 13-17 |
| Optimized (target) | 60s | ~1800-2400 | 30-40 |

### Improvement Metrics

```
Frame rate improvement = (new_frames - baseline_frames) / baseline_frames × 100%

Example:
  Baseline: 1200 frames in 60s (20 FPS)
  After optimization: 1500 frames in 60s (25 FPS)
  Improvement: (1500-1200)/1200 × 100% = 25% faster
```

## Profiling Checklist

- [ ] Original ROM tested: baseline established
- [ ] Frame counter visible in debugger at 0x22000400
- [ ] Frame count increments every frame (not every V-INT)
- [ ] 60-second test runs consistently
- [ ] Results recorded for each optimization pass
- [ ] Variance tested (multiple runs to confirm)

## Debugging Frame Counter Issues

### Problem: Counter doesn't increment

**Check**:
1. Is final_exit being executed? (Add debug output)
2. Is the hook properly calling the counter code?
3. Is SDRAM address 0x22000400 readable in debugger?
4. Is SH2 actually running (not halted)?

**Diagnostic**:
```
If counter = 0 after 60s:
  - Hook not installed OR
  - SH2 code has an error

If counter increments every V-INT (~3600 in 60s):
  - Hooking wrong instruction (should be SH2, not 68K)

If counter increments at expected rate (~1200 in 60s):
  - SUCCESS! Counter is working correctly
```

### Problem: Counter increments too fast/slow

**Likely causes**:
- Wrong ROM offset for final_exit
- Hook installed on 68K instead of SH2 code
- Counter incremented multiple times per frame
- Measuring wrong timespan

**Verify**:
```
Expected rate = actual_frames / 60_seconds
If rate ≈ 20 FPS: ✓ Correct
If rate ≈ 60 FPS: ✗ Hooking 68K V-INT (3× too fast)
If rate < 10 FPS: ✗ Hooking only specific cases
```

## Related Code Locations

### Frame Completion
- **SH2 final_exit**: ROM `0x023A9A`, CPU `0x0222399A`
- **Display list terminator (0x0C)**: func_001 around ROM `0x01301C`

### Display List Processing
- **func_001**: ROM `0x01301C`, size 72 bytes
- **Display list buffer**: SDRAM `0x22010000` (estimated)

### Communication with 68K
- **COMM registers**: `0xA15120-0xA15127` (68K address)
- **V-INT handler**: ROM `0x001684`, CPU `0x00881684`

### VDP Register Access
- **68K side**: `0xA1518x` (Adapter Control, VDP Mode, Fill, etc.)
- **SH2 side**: `0x2000410x` (cache-through access required)

## Files in This Project

```
docs/SH2_FRAME_COUNTER_PROFILING.md       ← You are here
docs/32x-hardware-manual.md                 Hardware reference
docs/development-guide.md                   CPU coordination
docs/architecture-guide.md                  System architecture
disasm/sh2_3d_engine_annotated.asm         SH2 code with annotations
disasm/sections/code_16xx.asm              68K V-INT handlers
tools/inject_sh2_frame_counter.py          Counter injection tool
build/vr_sh2_frame_counter.32x             Modified ROM with counter
```

## Next Steps

1. **Verify counter is working**
   - Load `build/vr_sh2_frame_counter.32x`
   - Check 0x22000400 value after 60 seconds
   - Should show ~1200 (or appropriate rate for scenario)

2. **Establish baseline metrics**
   - Multiple 60-second runs
   - Record average and variance
   - Document test conditions

3. **Implement optimizations**
   - VDP polling optimization (target: +40%)
   - SH2 parallelization (target: +30%)
   - Measure improvement after each

4. **Compare results**
   - Calculate speedup factor
   - Verify consistency across runs
   - Identify bottlenecks via profiling

## Technical Notes

### Why Not Use V-INT Counter?

- V-INT fires 60 Hz regardless of SH2 frame output
- SH2 may drop frames or render at variable rate
- V-INT counter doesn't reflect actual frame rate
- 3× faster than real frame rate (60 Hz ÷ 20 FPS = 3×)

### SH2 Frame Structure

```
[Display List (variable size)]
        ↓
[func_001: Process commands until 0x0C]
        ↓
[func_023-036: Render geometry]
        ↓
[final_exit: Cleanup, return] ← FRAME COMPLETE HERE
        ↓
[Next frame begins]
```

### Memory Visibility

| Address Space | View | SH2 | 68K | Emulator |
|--------------|------|-----|-----|----------|
| 0x22000400 | Direct | ✓ | ✗ | ✓ |
| 0x02000400 | Cache | ✓ | ✗ | - |
| 0xC964 | 68K RAM | ✗ | ✓ | ✓ |

Note: SH2 and 68K have completely separate memory spaces. SH2 SDRAM is only visible to SH2 and emulators.

## References

- Sega 32X Hardware Manual (MAR-32-R4-072294)
- SH7095 CPU Manual (Hitachi)
- VRD Disassembly Analysis
- Exploration results from investigation phase

---

## SH2 Instruction Reference (Critical for Code Injection)

### Branch Instructions

**BRA (Branch Always)**
- **Encoding**: 1010 nnnn nnnn nnnn (12-bit signed offset)
- **Range**: ±2048 instructions (~4KB)
- **Usage**: Short-range branches within same function or nearby code
- **Limitation**: CANNOT reach far offsets (e.g., 20KB away)

**JMP (Jump)**
- **Format 1**: JMP @Rn (register indirect)
  - Jump to address in register
  - Requires loading address first
- **Format 2**: JMP absolute.L
  - `4EF9 aaaa aaaa` (6 bytes total)
  - 32-bit absolute address
  - Can jump anywhere in address space
  - **Required for large offsets**

### When to Use Each

| Scenario | Instruction | Example |
|----------|-------------|---------|
| Local branch (same ~4KB) | BRA | Jump within function |
| Jump to far address | JMP absolute.L | Jump 20KB away |
| Jump via register | JMP @Rn | Computed address |
| Subroutine call | JSR @Rn | Return with RTS |

### Code Injection Lesson Learned

**Problem**: Initial hook tried to use BRA for 20KB+ offset
```
final_exit:
  BRA 0xF16C ← INVALID! Range exceeded
  → SH2 DRC error: "illegal op f16c"
```

**Solution**: Use JMP with 32-bit absolute address
```
final_exit:
  JMP absolute.L
  DC.L target_address (32-bit)
  → Valid for any distance
```

### Key Takeaway

When injecting code hooks at distant locations, **always use JMP absolute.L**, not BRA. BRA's 4KB range is too restrictive for ROM-wide modifications.

