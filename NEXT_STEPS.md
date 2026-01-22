# Next Steps - Post 4MB Cartridge Milestone

**Version:** v2.0-4mb-cartridge
**Date:** 2026-01-21
**Status:** Ready for Haiku execution

---

## Context

We have achieved the **4MB cartridge milestone**:
- ✅ 1MB SH2 expansion space ready at $300000-$3FFFFF
- ✅ ROM boots cleanly in PicoDrive
- ✅ Comprehensive documentation in place

The strategic goal is **60 FPS** (from current ~24 FPS). The expansion space enables **Track 2: Slave CPU Activation**, the highest-impact optimization (+50-100% FPS potential).

---

## Critical Blocker: Slave SH2 Boot Failure

⚠️ **Before any Slave CPU work can proceed**, we must address this discovery:

> Debugger measurements reveal the Slave SH2 never boots correctly in PicoDrive emulator.

**Options to resolve:**

| Option | Effort | Outcome |
|--------|--------|---------|
| A. Use BlastEm instead | Low | BlastEm may have working Slave SH2 |
| B. Implement pdcore debugger | 15-20 hours | Diagnose exact boot failure point |
| C. Fix PicoDrive directly | Unknown | Depends on root cause |

**Recommended:** Start with Option A (test in BlastEm), fall back to B if needed.

---

## Phase 1: Slave SH2 Investigation

### Task 1.1: Test ROM in BlastEm

**Goal:** Verify if Slave SH2 boots correctly in BlastEm

**Steps:**
1. Build BlastEm from source (if not available)
2. Load `build/vr_rebuild.32x` in BlastEm
3. Use BlastEm's built-in debugger to check Slave SH2 state
4. Document findings

**Success Criteria:**
- Know whether Slave boots in BlastEm
- Have baseline for Slave SH2 register state

**Files to reference:**
- [analysis/debugger-design/BLASTEM_ANALYSIS_README.md](analysis/debugger-design/BLASTEM_ANALYSIS_README.md)

---

### Task 1.2: Profile Original ROM's Slave Behavior

**Goal:** Understand what Slave SH2 should be doing

**Steps:**
1. Disassemble Slave SH2 entry point in original ROM
2. Trace Slave execution path from boot
3. Document expected Slave state at frame N
4. Compare with PicoDrive's actual behavior

**Files to reference:**
- [analysis/sh2-analysis/SH2_ANALYSIS_COMPLETE.md](analysis/sh2-analysis/SH2_ANALYSIS_COMPLETE.md)
- [analysis/architecture/MASTER_SLAVE_ANALYSIS.md](analysis/architecture/MASTER_SLAVE_ANALYSIS.md)

---

## Phase 2: Expansion ROM Code Injection (After Slave Boot Fixed)

### Task 2.1: Create SH2 Test Function

**Goal:** Inject minimal SH2 code into expansion space to verify execution

**Location:** [disasm/sections/expansion_300000.asm](disasm/sections/expansion_300000.asm)

**Approach:**
```asm
        org     $300000

; Minimal test: Write signature to COMM6 register
slave_test_func:
        dc.w    $E601        ; MOV #1,R6 (load immediate 1)
        dc.w    $C20B        ; MOV.W R0,@(disp,GBR) - write to COMM
        dc.w    $000B        ; RTS
        dc.w    $0009        ; NOP (delay slot)

        ; Fill remaining space with padding
        dcb.b   $100000-(*-$300000),$FF
```

**Critical Constraint:**
- ALL code must be `dc.w` format (raw SH2 opcodes)
- NEVER use 68K mnemonics in this section
- Reference: [analysis/architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md](analysis/architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md)

**SH2 opcode reference:**
- Use [tools/sh2_disasm.py](tools/sh2_disasm.py) to verify opcodes
- SH2 is little-endian for data, big-endian for instructions

---

### Task 2.2: Hook Expansion Code from Slave Main Loop

**Goal:** Have Slave SH2 call our expansion code

**Approach:**
1. Find Slave's idle/main loop in original ROM
2. Inject a JSR/BSR to $02300000 (expansion space)
3. Verify execution via COMM register signature

**Expected SH2 addresses:**
- ROM base: $02000000
- Expansion base: $02300000 (maps to ROM $300000)

---

## Phase 3: Work Distribution Implementation

### Task 3.1: Design Work Queue

**Goal:** Define shared memory structure for Master→Slave work distribution

**Location:** SDRAM ($06000000-$0603FFFF)

**Proposed structure:**
```
Offset    Size    Purpose
$0000     4       Work queue head pointer
$0004     4       Work queue tail pointer
$0008     4       Work items pending count
$000C     4       Slave status (0=idle, 1=busy)
$0010+    N×16    Work item array (task type, params, etc.)
```

**Documentation needed:**
- Create `analysis/optimization/WORK_QUEUE_DESIGN.md`

---

### Task 3.2: Implement Simple Work Item

**Goal:** Implement one parallelizable task

**Candidates (from OPTIMIZATION_PLAN.md):**
1. 3D vertex transformations
2. Physics calculations
3. Collision detection
4. Background pre-rendering

**Start with:** Memory clear/fill (simplest test case)

---

## Phase 4: Profile and Measure

### Task 4.1: Implement FPS Counter

**Goal:** Measure actual FPS improvement

**Tool:** [tools/inject_fps_counter.py](tools/inject_fps_counter.py)

**Steps:**
1. Inject FPS counter into V-INT handler
2. Display on-screen or via COMM registers
3. Compare baseline vs optimized

---

### Task 4.2: Document Results

**Goal:** Track performance gains per optimization

**Template:**
```markdown
## Optimization: [Name]
- Baseline FPS: ___
- After FPS: ___
- Delta: ___% improvement
- Implementation: [file:line]
```

---

## Decision Tree

```
Start
  │
  ├─ Does Slave SH2 boot in BlastEm?
  │    │
  │    ├─ YES → Use BlastEm for development
  │    │         Proceed to Phase 2
  │    │
  │    └─ NO → Slave boot is broken in original ROM too
  │             Check original ROM in BlastEm
  │
  └─ If both emulators fail:
       Implement pdcore debugger (15-20 hours)
       Use debugger to diagnose boot sequence
```

---

## File Checklist for Haiku

**Must Read Before Starting:**
1. [CLAUDE.md](CLAUDE.md) - Project conventions and constraints
2. [analysis/architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md](analysis/architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md) - Critical expansion constraints
3. [analysis/sh2-analysis/SH2_ANALYSIS_COMPLETE.md](analysis/sh2-analysis/SH2_ANALYSIS_COMPLETE.md) - SH2 architecture

**Key Implementation Files:**
- [disasm/sections/expansion_300000.asm](disasm/sections/expansion_300000.asm) - Expansion space
- [disasm/vrd.asm](disasm/vrd.asm) - Main build file
- [disasm/sections/code_200.asm](disasm/sections/code_200.asm) - V-INT wrapper

**Reference Documentation:**
- [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) - Strategic roadmap
- [docs/32x-hardware-manual.md](docs/32x-hardware-manual.md) - Hardware reference
- [analysis/debugger-design/PDCORE_MASTER_PLAN.md](analysis/debugger-design/PDCORE_MASTER_PLAN.md) - Debugger design

---

## Build & Test Commands

```bash
# Build ROM
make clean && make all

# Verify size (should be 4MB)
ls -la build/vr_rebuild.32x
# Expected: 4,194,304 bytes

# Test boot
picodrive build/vr_rebuild.32x

# Test in BlastEm (if available)
blastem build/vr_rebuild.32x
```

---

## Success Metrics

| Milestone | Target | Status |
|-----------|--------|--------|
| 4MB cartridge boots | ✅ | Complete |
| Slave SH2 boot diagnosed | ⏳ | Phase 1 |
| Expansion code executes | ⏳ | Phase 2 |
| Work queue implemented | ⏳ | Phase 3 |
| Slave actively processing | ⏳ | Phase 3 |
| FPS improvement measured | ⏳ | Phase 4 |
| 48+ FPS achieved | ⏳ | Goal |

---

## Warnings & Gotchas

1. **Expansion section is SH2-ONLY** - Never use 68K mnemonics
2. **SH2 opcodes must be dc.w format** - vasmm68k_mot doesn't understand SH2
3. **Test after every change** - Boot failures are common
4. **Keep backups** - Use git branches for experiments
5. **ROM header matters** - $1A4 must be $003F for 4MB

---

**Last Updated:** 2026-01-21
**Author:** Claude Opus 4.5 (planning for Haiku execution)
