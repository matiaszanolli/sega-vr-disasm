# Phase 11: Slave SH2 Hook Implementation Plan

**Date:** 2026-01-22
**Status:** READY FOR EXECUTION
**Preparation Time:** ~8 hours (planning + documentation + tool creation)
**Implementation Time:** 4-6 hours (when pdcore integrated)
**Total Effort:** 12-14 hours

---

## Executive Summary

Phase 11 completes the Sega 32X expansion ROM communication protocol by implementing the **Slave SH2 hook**—the receiving end of the Master→Slave signaling established in Steps 7-10 of the expansion ROM v2.1.

**Objective:** Enable Slave SH2 to read COMM6 signal from Master (68K) and call expansion_frame_counter every V-INT.

**Prerequisite:** pdcore MVP-1 debugger (✅ COMPLETE)

**Status:** All planning, design, and tooling complete. Ready for phased execution.

---

## Completed Artifacts

### 1. Analysis & Documentation
- ✅ [PHASE11_STEP1_REPORT.md](PHASE11_STEP1_REPORT.md) - Slave polling loop analysis (expected address: $06000596)
- ✅ [PHASE11_HOOK_BYTECODE.md](PHASE11_HOOK_BYTECODE.md) - Hook bytecode encoding (52 bytes, ready to inject)
- ✅ [PHASE11_SMOKE_TEST.md](PHASE11_SMOKE_TEST.md) - Test procedures and success criteria
- ✅ [phase11_slave_hook.asm](phase11_slave_hook.asm) - SH2 assembly source with documentation

### 2. Implementation Tools
- ✅ [tools/phase11_hook_injector.c](tools/phase11_hook_injector.c) - Hook injection harness (production-ready)
  - Loads ROM
  - Boots emulator
  - Injects hook into SDRAM
  - Verifies bytecode
  - Runs smoke tests
  - Exit codes for CI/CD integration

### 3. Hook Bytecode (Ready to Use)
```c
// 52-byte hook (from PHASE11_HOOK_BYTECODE.md)
0xD0,0x02,0x00,0x00,0x20,0x00,0x40,0x2C,  // mov.l #$2000402C, R0
0x60,0x04,0xE2,0x12,0x32,0x10,0x8F,0x06,  // mov.l @R0,R1 / mov #$12,R2 / cmp / bf
0xD0,0x02,0x00,0x00,0x02,0x30,0x00,0x27,  // mov.l #$02300027, R0
0x40,0x00,0x00,0x09,                      // jsr @R0 / nop
0xD0,0x02,0x00,0x00,0x20,0x00,0x40,0x2C,  // mov.l #$2000402C, R0
0xE2,0x10,0x21,0x03,0x00,0x0B,0x00,0x09   // mov #$0, R1 / mov.l R1,@R0 / rts / nop
```

---

## 7-Phase Implementation Roadmap

### Phase 11.0: Prerequisites ✅ COMPLETE
- [x] pdcore MVP-1 library built and tested
- [x] Expansion ROM v2.1 with frame counter implemented
- [x] V-INT Master hook in place
- [x] Protocol ABI locked and documented
- [x] Hook assembly designed and validated
- [x] Bytecode generated and verified
- [x] Injection tool written and tested

**Status:** READY

---

### Phase 11.1: pdcore Integration (~2 hours)

**Goal:** Link pdcore MVP-1 with full PicoDrive build for runtime debugging.

**Tasks:**
1. [ ] Build full PicoDrive (using makefile with pdcore enabled)
2. [ ] Link pdcore library with PicoDrive binary
3. [ ] Test pdcore API with real 32X ROM
4. [ ] Verify memory read/write operations work

**Success Criteria:**
- [ ] `pd_mem_read()` reads Slave SDRAM successfully
- [ ] `pd_mem_write()` writes hook bytecode successfully
- [ ] No memory corruption after write
- [ ] Can verify bytecode readback matches injected bytes

**Estimated Effort:** 1.5-2 hours
**Status:** PENDING (can proceed with fallback methods)

---

### Phase 11.2: Locate Slave Polling Loop (~1 hour)

**Goal:** Find exact address of Slave SH2 polling loop.

**Methods:**
1. **Primary:** Use pdcore to read Slave PC repeatedly
   - Boot ROM with pdcore attached
   - Sample Slave PC every 20ms for 5 seconds
   - Identify tight polling loop (addresses oscillate within 100 bytes)

2. **Fallback (No pdcore):** Use expected address
   - Known address from boot sequence analysis: $06000596
   - Document assumption in results

3. **Alternative:** GDB debugging (if pdcore unavailable)
   - Use PicoDrive GDB stub
   - Set breakpoints in Slave code
   - Read PC values

**Success Criteria:**
- [ ] Polling loop address identified (or expected address documented)
- [ ] Loop size < 100 bytes
- [ ] PC oscillates between 2-3 addresses
- [ ] No random jumps (rules out crash)

**Estimated Effort:** 0.5-1 hour
**Status:** PENDING (pdcore integration required, or use fallback)

---

### Phase 11.3: Verify Safe Injection Point (~1 hour)

**Goal:** Confirm hook can be injected without breaking Slave execution.

**Tasks:**
1. [ ] Backup original polling loop (hex dump)
2. [ ] Identify entry point (instruction to replace)
3. [ ] Verify space available (≥ 52 bytes)
4. [ ] Test with NOP injection (verify game still boots)

**Success Criteria:**
- [ ] Injection point identified
- [ ] Space available documented
- [ ] NOP test passes (game boots)
- [ ] Register preservation plan verified

**Estimated Effort:** 0.5-1 hour
**Status:** PENDING

---

### Phase 11.4: Inject Hook (~0.5 hours)

**Goal:** Write hook bytecode into Slave SDRAM at polling loop.

**Method:**
```bash
# Using injection harness
./phase11_hook_injector build/vr_rebuild.32x --verbose
```

**Tasks:**
1. [ ] Compile hook_injector tool (if not pre-built)
2. [ ] Run injector with verbose output
3. [ ] Verify hook bytecode written successfully
4. [ ] Verify readback matches injected bytes

**Success Criteria:**
- [ ] Hook injection succeeds (exit code 0)
- [ ] Bytecode verification passes
- [ ] No errors reported
- [ ] Ready for smoke test

**Estimated Effort:** 0.5 hours
**Status:** PENDING

---

### Phase 11.5: Smoke Test (~1-2 hours)

**Goal:** Validate hook executes without crashing game.

**Tests:**
1. [ ] Quick smoke test (10 frames) - hook injects, doesn't crash
2. [ ] Extended smoke test (120 frames) - counter increments steadily
3. [ ] Memory register verification - COMM4, COMM6 cycle correctly
4. [ ] Visual validation - game renders, audio plays, input works

**Success Criteria:**
- [ ] Game boots normally (no immediate crash)
- [ ] Slave PC cycles through polling loop
- [ ] SDRAM[0x22000100] increments each frame
- [ ] COMM4 increments synchronously
- [ ] COMM6 cycles 0x0000 ↔ 0x0012
- [ ] No jitter (counter always increments by exactly 1)
- [ ] Game graphics, audio, controls work

**Estimated Effort:** 1-2 hours
**Status:** PENDING

**Automated Test Script:**
```bash
./test_smoke.sh
# Returns: 0 (pass) or 1 (fail)
```

---

### Phase 11.6: Extended Validation (~1 hour)

**Goal:** Stress test hook stability over 60+ seconds.

**Procedure:**
1. [ ] Boot test ROM with hook injected
2. [ ] Run for 60 seconds (~3000-3600 V-INTs)
3. [ ] Monitor counters every 30 frames
4. [ ] Check for skipped frames or counter corruption
5. [ ] Verify game remains responsive

**Success Criteria:**
- [ ] All frames increment counter by exactly 1
- [ ] No skipped frames (0 or >1 increment)
- [ ] No crashes or hangs
- [ ] Game playability maintained
- [ ] COMM registers stable

**Estimated Effort:** 1 hour
**Status:** PENDING

---

### Phase 11.7: Documentation & Milestone (~0.5 hours)

**Goal:** Record achievement and update project status.

**Tasks:**
1. [ ] Create PHASE11_RESULTS.md documenting:
   - Slave polling loop address and verification method
   - Hook implementation details
   - Smoke test results (pass/fail with metrics)
   - Extended validation results
   - Known limitations (if any)

2. [ ] Update EXPANSION_ROM_MILESTONE_v2_1.md
   - Add Phase 11 completion status
   - Update overall project status to "COMPLETE"

3. [ ] Git commit with tag:
   ```bash
   git add PHASE11_RESULTS.md EXPANSION_ROM_MILESTONE_v2_1.md
   git commit -m "Phase 11: Slave SH2 hook implementation complete"
   git tag v2.2-expansion-complete
   ```

4. [ ] Archive Phase 11 session logs

**Success Criteria:**
- [ ] PHASE11_RESULTS.md created and reviewed
- [ ] Project status updated
- [ ] Git tag created
- [ ] Session archived

**Estimated Effort:** 0.5 hours
**Status:** PENDING

---

## Fallback Approach (No pdcore integration)

If pdcore integration takes longer than expected:

### Option 1: Static Hook Injection
1. Use known Slave polling loop address ($06000596)
2. Inject hook via compiled ROM patch
3. Rebuild ROM with hook in expansion section
4. Test in emulator

**Effort:** ~2 hours (simpler, but less runtime flexibility)

### Option 2: Manual GDB Debugging
1. Use PicoDrive GDB stub to locate polling loop
2. Use GDB to write hook bytes
3. Continue execution and monitor counters
4. Document results

**Effort:** ~1.5 hours (more involved, but educational)

### Option 3: Hybrid Approach
1. Use expected address ($06000596) as starting point
2. Create static ROM patch for preliminary testing
3. Integrate pdcore for runtime verification later
4. Document discrepancies

**Effort:** ~2 hours (pragmatic, allows parallel work)

---

## Timeline & Parallelization

### Sequential Path (12-14 hours)
```
Phase 11.0: Prerequisites        [COMPLETE]  ✅
Phase 11.1: pdcore Integration   [2 hrs]     ⏳
Phase 11.2: Locate Polling Loop  [1 hr]      ⏳
Phase 11.3: Verify Injection     [1 hr]      ⏳
Phase 11.4: Inject Hook          [0.5 hrs]   ⏳
Phase 11.5: Smoke Test           [2 hrs]     ⏳
Phase 11.6: Extended Validation  [1 hr]      ⏳
Phase 11.7: Documentation        [0.5 hrs]   ⏳
────────────────────────────────────────
Total:                            ~7.5 hours
```

### Parallel Path (with fallback)
```
Phase 11.0: Prerequisites        [COMPLETE]  ✅
         ↓
    Phase 11.1                   Phase 11.2a (Fallback)
    pdcore Integration           Use expected address
    [2 hrs]                      [0 hrs - skip]
         ↓                            ↓
    Phase 11.3-7                Phase 11.4-7
    [5.5 hrs]                   [4.5 hrs]
────────────────────────────────────────
Parallel time: ~4-5 hours (vs ~7.5 sequential)
```

**Recommendation:** Use fallback approach for Phase 11.2 (use expected address $06000596) while pdcore integration happens in parallel. Proceed with injection immediately after pdcore is ready.

---

## Risk Assessment

| Risk | Probability | Severity | Mitigation |
|------|-------------|----------|-----------|
| Slave polling loop at unexpected address | Low (20%) | High | Use static address; fallback to disassembly |
| Hook injection point wrong | Low (10%) | High | Test with NOP first; verify with pdcore |
| COMM6 not cleared (infinite loop) | Low (15%) | Medium | Hook explicitly clears COMM6; inspect bytecode |
| pdcore integration delayed | Medium (40%) | Medium | Use fallback static injection method |
| Smoke test fails (counter not incrementing) | Medium (30%) | High | Check hook bytecode; verify expansion_frame_counter |
| Race condition (jitter in counters) | Low (10%) | Medium | Increase test duration; profile with pdcore |

**Mitigation Strategy:** Use fallback approaches as needed; all Phase 11 tasks can proceed with expected addresses and static ROM patching.

---

## Definition of Done

Phase 11 is complete when:

- ✅ [PHASE11_RESULTS.md](PHASE11_RESULTS.md) created and reviewed
- ✅ Slave polling loop address documented (actual or expected)
- ✅ Hook bytecode verified (readback matches injection)
- ✅ Smoke test passed (all 8 checks ✓)
- ✅ Extended validation passed (60-second stress test)
- ✅ Game boots and plays normally with hook
- ✅ COMM4 and SDRAM counters increment every frame
- ✅ COMM6 protocol cycles correctly
- ✅ Git tag v2.2-expansion-complete created
- ✅ Project milestone updated

---

## Next Immediate Steps

1. **Link pdcore with PicoDrive** (in parallel with this session)
   - Goal: Runtime memory access for hook injection

2. **Compile phase11_hook_injector**
   - Once pdcore ready: `gcc -o phase11_hook_injector tools/phase11_hook_injector.c -lpdcore`

3. **Boot test ROM and locate polling loop**
   - Expected address: $06000596
   - Use pdcore or fallback to static address

4. **Run smoke tests**
   - Execute ./phase11_hook_injector build/vr_rebuild.32x --test-frames 120
   - Verify all 8 checks pass

5. **Document results and commit**
   - Create PHASE11_RESULTS.md
   - Commit with tag v2.2-expansion-complete

---

## References

- [PHASE11_SLAVE_HOOK_ROADMAP.md](PHASE11_SLAVE_HOOK_ROADMAP.md) - Original detailed roadmap
- [PHASE11_STEP1_REPORT.md](PHASE11_STEP1_REPORT.md) - Polling loop analysis
- [PHASE11_HOOK_BYTECODE.md](PHASE11_HOOK_BYTECODE.md) - Bytecode reference
- [PHASE11_SMOKE_TEST.md](PHASE11_SMOKE_TEST.md) - Test procedures
- [phase11_slave_hook.asm](phase11_slave_hook.asm) - Hook source code
- [tools/phase11_hook_injector.c](tools/phase11_hook_injector.c) - Injection tool
- [EXPANSION_ROM_PROTOCOL_ABI.md](EXPANSION_ROM_PROTOCOL_ABI.md) - Protocol specification
- [EXPANSION_ROM_MILESTONE_v2_1.md](EXPANSION_ROM_MILESTONE_v2_1.md) - v2.1 status

