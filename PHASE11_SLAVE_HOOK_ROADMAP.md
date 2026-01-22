# Phase 11: Slave Hook Implementation Roadmap

**Date:** 2026-01-21
**Version:** 1.0
**Status:** Ready for Implementation
**Dependency:** pdcore MVP-1 debugger (in parallel development)

---

## Overview

Phase 11 completes the expansion ROM communication protocol by implementing the **Slave SH2 hook**—the receiving end of the Master→Slave signaling established in Steps 7-10.

**What Phase 11 Accomplishes:**
- Slave SH2 reads COMM6 signal from Master (68K) every frame
- Calls `expansion_frame_counter` in expansion ROM when signal detected
- Increments COMM4 and SDRAM diagnostic counter
- Clears COMM6 (edge-triggered acknowledgment)
- Validates frame-by-frame execution with <5% jitter

**Prerequisite:** pdcore MVP-1 must be complete to provide runtime instruction/memory access during Slave execution.

---

## Prerequisites Checklist

Before beginning Phase 11 implementation:

- [ ] pdcore MVP-1 complete (reads/writes Slave memory, executes single instructions)
- [ ] Slave polling loop located and validated (expected at $06000596 or nearby)
- [ ] Expansion ROM verified reachable from Slave address space ($02300000)
- [ ] COMM registers readable from debugger ($2000402C, $20004028)
- [ ] SDRAM at 0x22000100 accessible for diagnostic counter
- [ ] Test ROM builds cleanly without Phase 11 changes
- [ ] EXPANSION_ROM_PROTOCOL_ABI.md reviewed and locked

---

## Step 1: Locate Slave Polling Loop (pdcore MVP-1 Required)

**Goal:** Find exact address where Slave SH2 main loop waits for work.

**Procedure:**
1. Boot test ROM in PicoDrive with pdcore attached
2. Wait ~2 seconds (V-INT fires 50-60 times)
3. Pause execution
4. Use pdcore to read Slave PC register
5. Repeat 3-5 times, observing if PC changes or stays in loop
6. When PC is stable or cycling in tight loop, disassemble at that address

**Expected Result:**
```
Slave PC stuck at ~$06000596 (or similar address in SDRAM)
Instruction pattern: CMP, BNE, LOOP_START
(or: SLEEP instruction waiting for interrupt)
```

**Record:**
- Exact polling loop start address
- Loop size (in bytes)
- Instructions in loop
- Condition that exits loop (or confirmed idle loop)

**If Loop Not Found:**
- Check if Slave is running at all (PC changing?)
- Verify pdcore can read Slave memory (not just Master)
- Consult Boot ROM documentation (Hardware Manual Section 1.13)
- Defer to pdcore debugging if Slave not executing

---

## Step 2: Verify Safe Injection Point

**Goal:** Confirm we can inject code without breaking Slave execution.

**Constraints:**
1. Must be within polling loop (executes every frame)
2. Must not corrupt loop condition
3. Must preserve all registers except those intentionally written
4. Must not exceed 20 instructions (keep loop iteration fast)

**Procedure:**

1. **Backup original loop:**
   ```
   Record hex dump of loop (e.g., bytes 596-610 in SDRAM)
   Save to file: phase11_slave_loop_backup.hex
   ```

2. **Identify entry point:**
   - Find instruction right after loop condition check
   - This is safest insertion point (condition already evaluated)
   - Example: if loop is `CMP R0,R1 / BNE loop_start`, insert after BNE

3. **Verify space:**
   - Count available instructions before next essential operation
   - Need minimum 12 instructions (48 bytes)
   - If insufficient: use beginning of next idle section

4. **Test with NOP:**
   - Replace first 2 instructions with NOP
   - Boot test ROM
   - Verify game still runs (rendering, V-INT firing)
   - Restore original instructions
   - If game crashes: injection point is wrong

**If Safe Point Not Found:**
- Polling loop too tight (< 12 instructions available)
- Alternative: inject at Slave exception handler (lower priority, more complex)
- Escalate to pdcore team for runtime patching approach

---

## Step 3: Implement Register-Preserving Slave Hook

**Goal:** Inject code that reads COMM6 and conditionally calls expansion code.

**Code Pattern (SH2 Assembly):**

```asm
; Hook entry point (injected into Slave polling loop)
; Preserves R0-R7, flags, PSR
; Must clear COMM6 after servicing (edge-triggered protocol)

slave_expansion_hook:
        ; Check if Master signaled (COMM6 == 0x0012)
        mov.l   #$2000402C, R0  ; Load COMM6 address
        mov.l   @R0, R1         ; Read COMM6 (call = read, gets value)
        cmp/eq  #$0012, R1      ; Compare with signal value
        bf      hook_exit       ; If not equal, skip to exit

        ; Signal detected - call expansion_frame_counter
        ; expansion_frame_counter address: $02300000 + offset
        mov.l   #$02300027, R0  ; Load expansion_frame_counter entry
        jsr     @R0             ; Call expansion code
        nop                     ; (delay slot - safe NOP)

        ; Clear COMM6 (critical: edge-triggered acknowledgment)
        mov.l   #$2000402C, R0  ; Load COMM6 address again
        mov.l   #$0000, R1      ; Load clear value
        mov.l   R1, @R0         ; Write 0x0000 to COMM6

hook_exit:
        ; Resume polling loop (hook consumed ~24 bytes / 12 instructions)
        ; Register state fully preserved
        rts
        nop                     ; (delay slot)
```

**Critical Notes:**
- **COMM6 clear is mandatory** - prevents repeated execution (edge-triggered)
- **expansion_frame_counter offset:** Calculate from ROM layout
  - Expansion ROM base: $300000 in ROM file
  - SH2 address space: $02300000
  - expansion_frame_counter at offset 0x27 (see expansion_300000.asm)
  - Full address: $02300027
- **Delay slots:** Every JSR/BRA/RTS has mandatory delay slot (next instruction executes regardless of branch)
- **Register preservation:** No R0-R7 used outside hook; full state restoration

**SH2 Opcode Reference (dc.w format):**

| Instruction | Opcode | SH2 Notes |
|-------------|--------|-----------|
| `mov.l imm,Rn` | `E_nn` | Load 8-bit imm into Rn |
| `mov.l @Rn,Rm` | `6nm4` | Read memory at Rn into Rm |
| `mov.l Rn,@Rm` | `2nm3` | Write Rn to memory at Rm |
| `cmp/eq imm,R0` | `8800` | Compare R0 with imm (affects flags) |
| `bf addr` | `8900` | Branch if false (opposite of `bt`) |
| `jsr @Rn` | `400n` | Jump to subroutine at Rn |
| `nop` | `0009` | No operation |
| `rts` | `000B` | Return from subroutine |

---

## Step 4: Calculate expansion_frame_counter Exact Address

**Goal:** Determine byte offset of `expansion_frame_counter` in expansion ROM.

**Procedure:**

1. **Locate label in expansion_300000.asm:**
   ```
   expansion_frame_counter:  ; This is at offset 0x27 in ROM
        dc.w    $D002        ; SH2 opcode
   ```

2. **Calculate SH2 address:**
   - ROM offset: 0x300000
   - SH2 address space offset: +0x02000000
   - expansion_frame_counter offset: +0x27
   - Full address: 0x02300027

3. **Verify in compiled ROM:**
   ```bash
   hexdump -C build/vr_rebuild.32x | grep -A2 "^00300020"
   ```
   - Should show opcodes: `D0 02 60 08 71 01 20 12`
   - These are MOV.L, MOV.L, ADD, MOV.L (frame counter increment sequence)

4. **If opcodes don't match:**
   - expansion_300000.asm may have changed
   - Recount bytes from start of file (org $300000)
   - Adjust offset accordingly

---

## Step 5: Encode Hook in SH2 Opcodes (dc.w format)

**Goal:** Convert hook assembly into raw SH2 bytecode for injection.

**Example Encoding:**

```asm
; Hook code in assembly:
mov.l   #$2000402C, R0  →  mov.l imm32, R0
                            Need 2 words (4 bytes) for 32-bit imm
                            dc.w $D002        ; MOV.L @(disp,PC),R0
                            dc.w $0000        ; alignment
                            dc.l $2000402C    ; actual address

mov.l   @R0, R1         →  dc.w $6004        ; MOV.L @R0,R1

cmp/eq  #$0012, R1      →  (only cmp/eq imm,R0 exists in SH2)
                            Alternative: cmp R0,R1
                            dc.w $3010        ; CMP/EQ R1,R0
                            But need #$0012 in R1 first
                            Better: mov.l #$0012,R1 then cmp @R0,R1

bf      hook_exit       →  dc.w $8B0N        ; BF offset (depends on distance)

jsr     @R0             →  dc.w $400N        ; JSR @RN

rts                     →  dc.w $000B        ; RTS

nop                     →  dc.w $0009        ; NOP
```

**Better Approach - Use SH2 Assembler:**

Rather than manually calculating opcodes, use vasm with `cpu sh2` mode:

```asm
; phase11_slave_hook.asm
        org     $06000596  ; Slave polling loop address (example)

slave_expansion_hook:
        mov.l   #$2000402C, R0
        mov.l   @R0, R1
        mov     #$0012, R2
        cmp/eq  R2, R1
        bf      hook_exit
        mov.l   #$02300027, R0
        jsr     @R0
        nop
        mov.l   #$2000402C, R0
        mov     #$0000, R1
        mov.l   R1, @R0
hook_exit:
        rts
        nop
```

Assemble with: `vasm -cpu sh2 phase11_slave_hook.asm`
Extract bytecode from object file, then convert to `dc.w` format for SDRAM injection.

---

## Step 6: Inject Hook into Slave SDRAM (Runtime Patching)

**Goal:** Modify running Slave memory to call expansion code.

**Using pdcore (MVP-1):**

```
1. Boot test ROM in PicoDrive with pdcore attached
2. Pause after V-INT fires ~5 times (ensures system stable)
3. Use pdcore write command to patch polling loop
4. Write 24 bytes (12 SH2 instructions) starting at $06000596
5. Verify write with read (echo back)
```

**Example pdcore Command Sequence:**
```
write_memory 0x06000596 D002 6004 3010 8B02 4027 0009 D002 0000 000B 0009
read_memory 0x06000596 0x0C
# Verify output matches what we wrote
```

**Alternative - Direct ROM Patch (Not Recommended):**

If pdcore write is not available in MVP-1, could modify ROM directly:
1. Locate Slave polling loop in disassembled original ROM
2. Replace instructions in expansion section
3. Jump from new location to loop
4. But this requires reverse-engineering Slave boot (more complex)

**Expected After Injection:**
- Slave PC cycles through polling loop normally
- Every V-INT, loop executes hook code
- COMM6 read, check, expansion call, clear happens once per frame
- COMM4 increments
- SDRAM[0x22000100] increments
- Game continues rendering normally

---

## Step 7: Verify Hook Execution (Smoke Test)

**Goal:** Confirm Slave hook runs every frame without crashing game.

**Procedure:**

```
1. Boot test ROM with hook injected
2. Wait ~2 seconds (120+ V-INTs)
3. Observe:
   - Game renders (no black screen)
   - No emulator crashes
   - Audio plays normally
4. Use debugger to check:
   - COMM4 register ($A15128): value > 0, incrementing
   - SDRAM[0x22000100]: value > 0, incrementing
   - COMM6 register ($A1512C): oscillates 0000→0012→0000 each frame
5. Compare counters:
   - Frame count ≈ expected (≈ seconds_elapsed * 50-60)
   - COMM4 ≈ SDRAM counter (should match or COMM4 be lower 16 bits)
6. Run for 60 frames, measure jitter:
   - Expected: counter increments by 1 each frame
   - Acceptable: max_increment - min_increment ≤ 1
   - Fail: any frame skipped (increment ≠ 1) or counter frozen
```

**Success Criteria:**
- ✅ Game boots normally
- ✅ Counters increment every frame
- ✅ No jitter (±0 frames deviation)
- ✅ No crashes over 60+ frames
- ✅ COMM registers cycle predictably

**Failure Diagnosis:**

| Symptom | Probable Cause | Action |
|---------|----------------|--------|
| Black screen immediately | Hook injection point wrong | Revert, check polling loop address |
| Game boots but counters stuck at 0 | Hook not executing or expansion code broken | Check COMM6 value (should be 0012 each frame) |
| Counters increment once then stuck | Infinite loop in expansion code | Hook clears COMM6? expansion_frame_counter returns? |
| Counters jump by > 1 per frame | Multiple hook executions per V-INT | Slave polling rate > V-INT rate; check loop timing |
| Game crashes after 5-10 frames | Stack corruption or register not preserved | Review register save/restore in hook |

---

## Step 8: Integrate pdcore Results into Permanent Hook

**Goal:** Convert runtime-patched Slave hook into permanent ROM code.

**Two Options:**

### Option A: Patch Slave Entry Point (Complex, Permanent)

If polling loop address is stable (same every boot):
1. Disassemble original ROM's Slave code at that address
2. Create permanent modified version
3. Inject into Master ROM's disassembly
4. Rebuild and verify
5. Benefits: One-time fix, no runtime patching needed

### Option B: Keep Runtime Patching (Simple, Debuggable)

If pdcore will be persistent debugger:
1. Document exact pdcore command sequence to apply hook
2. Automate in test harness (pdcore script)
3. Run hook injection every boot
4. Benefits: Easy to iterate, visible in debugger, no ROM modification

**Recommendation:** Option B for now (pdcore MVP-1 is debugger, not full disassembly tool). Permanent hook can come later once Slave boot sequence fully understood.

---

## Step 9: Extended Validation (60-Second Stress Test)

**Goal:** Confirm hook stability under sustained load.

**Procedure:**

```
1. Boot test ROM with hook
2. Play game for 60 seconds (~3000-3600 V-INTs)
3. Monitor every 30 frames:
   - COMM4 value
   - SDRAM[0x22000100]
   - Game state (rendering, audio)
4. Record results in validation log:
   Frame | COMM4 | SDRAM[0x22000100] | Status
   30    | 30    | 30                | ✅
   60    | 60    | 60                | ✅
   ...
   3600  | 3600  | 3600              | ✅
```

**Pass Criteria:**
- Every frame counter incremented by exactly 1
- No skipped frames (delta always 1)
- No crashes or hangs
- Game play unaffected (rendering, audio, controls responsive)

**Fail Criteria:**
- Counter skips a frame (delta > 1)
- Counter misses frame (delta = 0 for one or more frames)
- Game crashes or becomes unresponsive
- COMM registers show undefined values

**If Extended Validation Fails:**
- Check Slave loop timing (pdcore: measure time between hook executions)
- Verify hook code doesn't block V-INT
- Confirm expansion code returns cleanly (no infinite loop)
- Check for memory corruption (write to wrong address)

---

## Step 10: Document Achievement and Tag Milestone

**Goal:** Record successful Slave hook implementation.

**Actions:**

1. **Create Phase 11 Results Document:**
   ```
   PHASE11_RESULTS.md
   - Slave polling loop address (with verification method)
   - Hook implementation (SH2 opcodes, register usage)
   - Validation results (smoke test + 60-second stress test)
   - Known limitations (if any)
   ```

2. **Update EXPANSION_ROM_MILESTONE_v2_1.md:**
   - Add "Phase 11: Slave Hook Implementation ✅" section
   - Link to PHASE11_RESULTS.md
   - Update overall status to "Expansion ROM Complete"

3. **Git Commit:**
   ```bash
   git add phase11_slave_hook.asm PHASE11_RESULTS.md EXPANSION_ROM_MILESTONE_v2_1.md
   git commit -m "Phase 11: Implement Slave SH2 expansion hook with frame counter"
   git tag v2.2-expansion-complete
   ```

4. **Archive Phase 11 Work:**
   ```bash
   mkdir -p _archive/phase_logs/phase11
   cp PHASE11_RESULTS.md _archive/phase_logs/phase11/
   cp phase11_slave_hook.asm _archive/phase_logs/phase11/
   ```

---

## Rollback Procedure (If Phase 11 Fails)

**If hook crashes game or breaks emulation:**

```bash
# Revert pdcore patches (if runtime injection)
pdcore reset_memory 0x06000596

# OR revert ROM changes (if permanent injection)
git checkout disasm/sections/code_200.asm
git checkout disasm/sections/expansion_300000.asm

# Rebuild and test
make clean && make all
picodrive build/vr_rebuild.32x

# Verify baseline still boots
# (should reach title screen within 3 seconds)
```

---

## Implementation Checklist (Phase 11 Ready-State)

From EXPANSION_ROM_PROTOCOL_ABI.md, adapt for Phase 11:

- [ ] Slave polling loop located (pdcore step 1)
- [ ] Safe injection point verified (pdcore step 2)
- [ ] Hook code written in SH2 opcodes (step 3)
- [ ] expansion_frame_counter address calculated (step 4)
- [ ] Hook bytecode encoded (step 5)
- [ ] Injected into Slave SDRAM via pdcore (step 6)
- [ ] Smoke test passes (counters increment per frame) (step 7)
- [ ] Permanent hook integrated (or pdcore script documented) (step 8)
- [ ] 60-second stress test passes (step 9)
- [ ] Results documented and tagged (step 10)
- [ ] No game crashes or stalls over extended play
- [ ] COMM6/COMM4 behavior matches ABI specification exactly

---

## Key Files for Phase 11

| File | Purpose | Status |
|------|---------|--------|
| EXPANSION_ROM_PROTOCOL_ABI.md | Locked protocol spec (Master→Slave) | ✅ Complete |
| phase11_slave_hook.asm | Slave hook source (SH2 asm) | ⏳ To write |
| PHASE11_RESULTS.md | Validation results | ⏳ To write |
| pdcore/MVP-1 | Runtime patching tool | ⏳ Parallel development |
| EXPANSION_ROM_MILESTONE_v2_1.md | Updated with Phase 11 results | ⏳ To update |

---

## Integration with pdcore MVP-1

**Dependency Path:**
```
pdcore MVP-1 (in progress)
  ↓
  ├─ Read/write Slave memory
  └─ Execute instructions on Slave
       ↓
       Phase 11: Slave Hook Implementation
         ↓
         ├─ Step 1: Locate polling loop (pdcore reads Slave PC)
         ├─ Step 2-5: Write hook code (pdcore writes SDRAM)
         └─ Step 6+: Validation (pdcore monitors Slave execution)
```

**Can Begin Phase 11:** As soon as pdcore MVP-1 supports Slave memory read/write.

**Parallel Work:** While pdcore is being developed, prepare:
- SH2 hook code assembly (phase11_slave_hook.asm)
- Validation test harness
- Rollback procedures

---

## Success Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| COMM4 increment rate | 1 per V-INT | Debugger read every 30 frames |
| COMM4 jitter | ±0 frames | max(delta) - min(delta) = 0 |
| Game stability | 60+ seconds | Play test, observe rendering |
| Counter accuracy | frame_count ≈ elapsed_time * fps | (COMM4 or SDRAM[0x22000100]) / elapsed_seconds |
| Hook overhead | < 1% of V-INT time | Measure via pdcore if available |

---

## Estimated Effort

- **Step 1-2 (Locate + Verify):** 30-45 minutes (pdcore-dependent)
- **Step 3-5 (Code + Encoding):** 1-2 hours (can be done now, assembly ready)
- **Step 6-7 (Inject + Smoke Test):** 30-45 minutes (pdcore execution)
- **Step 8-9 (Permanent + Stress Test):** 1-2 hours (depending on findings)
- **Step 10 (Documentation):** 30 minutes

**Total:** 4-6 hours of active work (parallelizable with pdcore development)

---

## References

- [EXPANSION_ROM_PROTOCOL_ABI.md](EXPANSION_ROM_PROTOCOL_ABI.md) - Locked protocol spec
- [EXPANSION_ROM_MILESTONE_v2_1.md](EXPANSION_ROM_MILESTONE_v2_1.md) - Previous progress
- [Hardware Manual Section 1.13](docs/32x-hardware-manual.md) - Boot ROM sequence
- [Hardware Manual Section 3.2.2](docs/32x-hardware-manual.md) - COMM registers
- [SH2 CPU ISA](https://www.hitachi-id.co.jp/) - SH7095 opcode reference

---

**Status:** ✅ Roadmap Ready - Awaiting pdcore MVP-1 Completion

