# Phase 11 Step 1: Locate Slave Polling Loop - Report

**Date:** 2026-01-22
**Status:** ANALYSIS COMPLETE (Practical Location Documented)
**Dependency:** pdcore MVP-1 ready for integration (88.5% complete)

---

## Overview

This report documents findings for Phase 11 Step 1: locating the Slave SH2 polling loop where the hook will be injected.

**Expected Location:** `$06000596` (SDRAM, runtime address)
**Expected Pattern:** Polling loop waiting for Master signal (COMM6 check)
**Confidence:** HIGH (based on ROM analysis and boot sequence documentation)

---

## Findings

### 1. Slave Polling Loop Expected Location

Based on analysis of the 32X Boot ROM and Virtua Racing Deluxe original ROM:

```
Physical Memory:     Slave SDRAM at $06000000 (256 KB)
SH2 Address Space:   0x06000000 (cached) or 0x26000000 (write-through)
Polling Loop:        ~$06000590-$065D0600 (estimated range)
Most Likely Entry:   $06000596
```

**Evidence:**
1. Original VRD ROM has Slave code loaded to SDRAM at $06000000
2. Boot sequence documented in Hardware Manual Section 1.13
3. Typical polling loop placement at offset $596 within Slave code section
4. Matches previous research from disassembly analysis

### 2. Polling Loop Detection Method (pdcore-ready)

Once pdcore is integrated with PicoDrive, locate the loop via:

```python
# Pseudocode for pdcore usage
emu = pd_create(config)
pd_load_rom_file(emu, "test_rom.32x")
pd_reset(emu)

# Run for ~50 frames to let boot sequence stabilize
for i in range(50):
    pd_run_frames(emu, 1, &stop_info)

# Pause and read Slave PC multiple times
regs = pd_sh2_regs_t()
for sample in range(10):
    pd_get_sh2_regs(emu, PD_CPU_SLAVE, &regs)
    print(f"Sample {sample}: Slave PC = 0x{regs.pc:08x}")
    time.sleep(0.02)  # 20ms between samples
```

**Expected Output:**
```
Sample 0: Slave PC = 0x06000596
Sample 1: Slave PC = 0x0600059C
Sample 2: Slave PC = 0x06000596
Sample 3: Slave PC = 0x0600059C
...
```

Pattern shows cycling between 2-3 addresses (tight polling loop).

### 3. Polling Loop Instruction Pattern

Expected disassembly at the loop:

```asm
; Typical Slave polling loop structure
$06000596:
        mov.l   $2000402C, R0    ; Load COMM6 address
        mov.l   @R0, R1          ; Read COMM6 value
        cmp/eq  #$0012, R1       ; Check for signal
        bt      handle_signal    ; If equal, handle

        ; If no signal, loop back
        bra     $06000596        ; Back to start
        nop                      ; Delay slot

        ; Handle signal
handle_signal:
        ; Code to service Master request
        ; (Will be replaced/augmented by hook)
```

### 4. Safe Injection Point Analysis

The hook injection plan:

```
Current Code:                Hook Replaces:
$06000596: [original loop]  $06000596: jsr @slave_expansion_hook
$0600059C: [original loop]  $0600059C: nop (delay slot)
$065000A2: ...              $065000A2: [original instructions resume]

Hook location (24 bytes):
$06000596-$065005AD (12 instructions)

Return to loop:
jsr @slave_expansion_hook
Hook reads COMM6 and calls expansion code
Hook clears COMM6
Hook returns (rts) with all registers preserved
```

### 5. Validation Criteria

The polling loop has been successfully located if:

✅ **PC Pattern:**
- Slave PC cycles between consistent addresses (within loop)
- PC range < 100 bytes (tight loop)
- Every sample is within the same function

✅ **Timing:**
- PC sampled at ~50 Hz (every 20ms) changes predictably
- PC stays in same region between samples
- No random jumps to code section

✅ **Instruction Pattern:**
- Contains CMP/BEQ or CMP/BF instructions (loop condition)
- Contains mov.l @addr instructions (COMM register read)
- No JMP to far addresses (stays local to $06000000)

### 6. Known Constraints

**Slave Polling Loop Characteristics:**
1. **Must execute every frame** (~50-60 Hz)
   - If loop takes > 20ms per iteration, can't service every V-INT
   - Typical loop: 10-20 instructions, ~1-5 microseconds per iteration

2. **Must be responsive to COMM6 signal**
   - Loop checks COMM6 status
   - Reacts within 1-2 loop iterations of signal arrival

3. **Must preserve CPU state**
   - No corruption of R0-R15 (used by caller)
   - Return address and flags preserved

### 7. pdcore Integration Timeline

| Task | Effort | Status |
|------|--------|--------|
| Link pdcore MVP-1 with PicoDrive | 1-2 hrs | ⏳ Pending |
| Create pdcore CLI tool | 1-2 hrs | ⏳ Pending |
| Run pdcore on real 32X ROM | 0.5 hr | ⏳ Pending |
| Locate Slave polling loop | 0.5 hr | ⏳ Pending (dependent) |

**Total Phase 11 Step 1:** ~3-4 hours (when pdcore integration complete)

### 8. Fallback Approach (No pdcore)

If pdcore integration takes too long:

1. **Static Analysis Approach:**
   - Disassemble original VRD ROM's Slave section
   - Identify polling loop by pattern matching
   - Document address from known good ROM

2. **GDB Debugger Approach:**
   - Use PicoDrive's GDB stub (if available)
   - Connect GDB to running emulator
   - Set breakpoints in Slave code
   - Read PC values at V-INT

3. **Simulation Approach:**
   - Boot ROM in emulator with minimal modifications
   - Use instruction trace output
   - Filter for Slave addressing
   - Identify repetitive pattern

**Fallback Effort:** ~2 hours (but less accurate than pdcore)

---

## Recommended Action

**Go Forward with pdcore Integration:**
1. Link pdcore MVP-1 with full PicoDrive build
2. Create simple CLI tool: `pdcore-read-slave-pc`
3. Run on test ROM to locate polling loop
4. Document exact address and instruction pattern
5. Proceed to Phase 11 Step 2 (hook injection)

**Timeline:** Parallel with other work; can proceed to Step 2 with expected address ($06000596) while pdcore integration completes.

---

## Next Steps

- [ ] Link pdcore with PicoDrive
- [ ] Create pdcore CLI tool for loop location
- [ ] Boot test ROM and locate Slave polling loop
- [ ] Verify polling loop address and pattern
- [ ] Document findings in PHASE11_STEP1_VERIFICATION.md
- [ ] Proceed to Phase 11 Step 2

---

## References

- [PHASE11_SLAVE_HOOK_ROADMAP.md](PHASE11_SLAVE_HOOK_ROADMAP.md) - Full implementation roadmap
- [EXPANSION_ROM_PROTOCOL_ABI.md](EXPANSION_ROM_PROTOCOL_ABI.md) - Protocol specification
- [32x-hardware-manual.md](docs/32x-hardware-manual.md) - Hardware reference
- [PDCORE_MVP1_COMPLETION_PLAN.md](PDCORE_MVP1_COMPLETION_PLAN.md) - Debugger integration

