# Analysis Documentation Revision - 2026-01-20

## Executive Summary

**Date**: 2026-01-20
**Trigger**: Debugger measurements revealing Slave SH2 boot failure in PicoDrive
**Scope**: Comprehensive revision of SH2-related analysis documents
**Impact**: Major correction to parallelization strategy and Slave SH2 assumptions

---

## Critical Discovery

### What We Thought (Static Analysis)
- Slave SH2 boots correctly and reaches ROM 0x020650+ code
- Slave executes work loop at ROM 0x020688 (JSR @R2 pattern)
- R2 register contains function pointer to VDP wait or work dispatcher
- Slave sits in idle loop waiting for work dispatch from Master
- Slave writes "OVRN" to COMM3 to signal readiness
- Work distribution can be implemented by modifying Master dispatch

### What Debugger Revealed (Runtime Measurement)
- **Slave NEVER boots correctly in PicoDrive**
- PicoDrive reads SH2 reset vectors from ROM 0x0 (68K vectors) instead of 32X header at 0x3C0+
- Slave PC gets set to 0x00880832 (68K code address)
- Slave executes 68K instructions as SH2 code (garbage execution)
- Slave gets stuck at ROM 0x0600060A-0x0600060E (infinite loop in 68K code/data region)
- R2 = 0x220003E4 is **accidental garbage** from mis-executing 68K code, NOT intentional
- **Slave NEVER reaches ROM 0x020650 or any SH2 code region**
- All static analysis of "Slave work loop" was analyzing **dead/unused code**

### Root Cause
**PicoDrive emulator bug**: `sh2_reset()` function reads reset vectors from wrong location
- Current: Reads from ROM offset 0 (Genesis/68K vectors)
- Correct: Should read from 32X header at ROM 0x3C0-0x3FF

### Source of Truth Documents
1. [SLAVE_BOOT_FAILURE_ROOT_CAUSE.md](SLAVE_BOOT_FAILURE_ROOT_CAUSE.md) ✅ **Latest analysis**
2. [R2_DEBUGGER_RESULTS.md](R2_DEBUGGER_RESULTS.md) ✅ **Debugger measurements**
3. [PDB_DEBUGGER_USAGE.md](PDB_DEBUGGER_USAGE.md) - Debugger methodology
4. [docs/32x-hardware-manual.md](docs/32x-hardware-manual.md) - Official hardware behavior

---

## Documents Requiring Revision

### Critical - Contains Outdated Slave Boot Assumptions

| Document | Issue | Severity | Action Required |
|----------|-------|----------|-----------------|
| [SH2_PARALLELIZATION_STRATEGY.md](analysis/sh2-analysis/SH2_PARALLELIZATION_STRATEGY.md) | Entire strategy assumes Slave boots and executes work loop | 🔴 CRITICAL | Add emulator bug warning at top |
| [MASTER_SLAVE_ANALYSIS.md](analysis/architecture/MASTER_SLAVE_ANALYSIS.md) | Claims Slave runs idle loop at ROM 0x20650-0x2069A | 🔴 CRITICAL | Add debugger contradiction section |
| [SH2_ARCHITECTURE_COMPLETE.md](analysis/SH2_ARCHITECTURE_COMPLETE.md) | Describes Slave work loop in SDRAM (0x22000400) | 🔴 CRITICAL | Add PicoDrive caveat |

### Moderate - Contains References to Slave Execution

| Document | Issue | Severity | Action Required |
|----------|-------|----------|-----------------|
| [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) | References Slave idle/underutilization | 🟡 MODERATE | Add note: "In theory, on real hardware" |
| [SH2_CODE_HUNT.md](analysis/sh2-analysis/SH2_CODE_HUNT.md) | Documents finding Slave entry at ROM 0x020650 | 🟡 MODERATE | Note: Code exists but not executed in PicoDrive |
| [SH2_MASTER_CODE.md](analysis/sh2-analysis/SH2_MASTER_CODE.md) | May reference Slave coordination | 🟡 MODERATE | Review for Slave assumptions |
| [INITIALIZATION_SEQUENCE.md](analysis/architecture/INITIALIZATION_SEQUENCE.md) | May describe Slave boot sequence | 🟡 MODERATE | Distinguish real HW vs PicoDrive |

### Low - Mentions Slave But Not Dependent On Boot Behavior

| Document | Issue | Severity | Action Required |
|----------|-------|----------|-----------------|
| [README.md](analysis/README.md) | Summary references parallelization strategy | 🟢 LOW | Update to reference this revision |
| [MEMORY_MAP.md](analysis/architecture/MEMORY_MAP.md) | May show Slave SDRAM regions | 🟢 LOW | Add note about theoretical usage |
| [CODEBASE_DOCUMENTATION_PLAN.md](analysis/architecture/CODEBASE_DOCUMENTATION_PLAN.md) | Planning doc | 🟢 LOW | Note: Plans based on static analysis |

### Validated - No Assumptions About Slave Execution

| Document | Status | Notes |
|----------|--------|-------|
| [BOTTLENECK_ANALYSIS.md](analysis/optimization/BOTTLENECK_ANALYSIS.md) | ✅ OK | Focuses on VDP wait loops, not Slave boot |
| [68K_FUNCTION_REFERENCE.md](analysis/68K_FUNCTION_REFERENCE.md) | ✅ OK | 68K code only |
| [68K_SH2_CROSS_REFERENCE.md](analysis/68K_SH2_CROSS_REFERENCE.md) | ✅ OK | Communication protocol (hardware-level) |
| [DATA_STRUCTURES.md](analysis/DATA_STRUCTURES.md) | ✅ OK | Data structures, not execution flow |
| [VDP_POLLING_ANALYSIS.md](analysis/VDP_POLLING_ANALYSIS.md) | ✅ OK | VDP polling analysis |

---

## Specific Corrections Needed

### 1. SH2_PARALLELIZATION_STRATEGY.md

**Add at top of document:**

```markdown
## ⚠️ CRITICAL CAVEAT - PicoDrive Emulator Bug (2026-01-20)

**This strategy document was created based on static analysis and assumes the Slave SH2 boots correctly.**

**Debugger findings reveal this assumption is FALSE in PicoDrive**:
- PicoDrive reads SH2 reset vectors from wrong location (ROM 0x0 instead of 32X header)
- Slave PC gets set to 0x00880832 (68K code), not 0x06020650 (SH2 entry)
- Slave never reaches SH2 code regions - stuck executing 68K garbage
- All Slave code at ROM 0x020650+ exists but is NEVER executed

**Status of this document**:
✅ **Theoretically sound** - Strategy would work IF Slave booted correctly
❌ **Not testable in PicoDrive** - Requires fixing `sh2_reset()` first
❓ **Real hardware unknown** - May work on actual 32X hardware

**Next steps**:
1. Fix PicoDrive's `sh2_reset()` to read from 32X header (ROM 0x3E0+)
2. Verify Slave boots and reaches ROM 0x020650
3. THEN implement this strategy

**See**: [SLAVE_BOOT_FAILURE_ROOT_CAUSE.md](../../SLAVE_BOOT_FAILURE_ROOT_CAUSE.md) for root cause analysis

---
```

### 2. MASTER_SLAVE_ANALYSIS.md

**Add section after "Slave Idle Loop Breakdown":**

```markdown
---

## ⚠️ DEBUGGER CONTRADICTION (2026-01-20)

**The above analysis was based on static code inspection. Runtime debugger measurements reveal a critical discrepancy.**

### What Debugger Actually Shows

**Slave PC trace** (first 100 instructions):
```
PC=0x00000204  (ROM 0x204 - 68K code region)
PC=0x0000020A  (ROM 0x20A - 68K code region)
PC=0x00000218  (ROM 0x218 - 68K code region)
PC=0x0600058A  (ROM 0x58A - "ROM Version 1.0" text)
PC=0x0600060A  (ROM 0x60A - 68K code/data)
... loops forever at 0x0600060A-0x0600060E
```

**Critical findings**:
1. Slave **NEVER reaches ROM 0x020650** (claimed entry point)
2. Slave **NEVER writes "OVRN" to COMM3** (never reaches that code)
3. Slave **executes 68K instructions as SH2** (garbage execution)
4. Code described above **exists but is dead code**

### Root Cause

PicoDrive reads SH2 reset vectors from ROM offset 0 (Genesis/68K vectors) instead of 32X header at 0x3C0-0x3FF.

**Result**: Slave PC = 0x00880832 (invalid 68K address interpreted as SH2 entry)

### Implications

- **All static analysis** of Slave idle loop was correct about the CODE
- **None of that code executes** in PicoDrive due to boot failure
- **Real 32X hardware** may work correctly (unknown)
- **Cannot test optimizations** until PicoDrive boot sequence fixed

**See**: [SLAVE_BOOT_FAILURE_ROOT_CAUSE.md](../../SLAVE_BOOT_FAILURE_ROOT_CAUSE.md)

---
```

### 3. SH2_ARCHITECTURE_COMPLETE.md

**Add at beginning of "Slave SH2 Entry" section:**

```markdown
## ⚠️ PicoDrive Emulator Boot Failure (2026-01-20)

**The following describes the Slave SH2 code structure based on static analysis. However, debugger measurements reveal this code is NEVER executed in PicoDrive.**

**Why**: PicoDrive's `sh2_reset()` reads reset vectors from ROM 0x0 (68K vectors) instead of 32X header (ROM 0x3C0+), causing Slave to execute 68K garbage code.

**Status**:
- ✅ Code exists and appears correct
- ❌ Never executed in PicoDrive
- ❓ Unknown if real hardware boots correctly

**See**: [SLAVE_BOOT_FAILURE_ROOT_CAUSE.md](SLAVE_BOOT_FAILURE_ROOT_CAUSE.md)

---
```

### 4. analysis/README.md

**Update "Current Status" section to add:**

```markdown
### ⚠️ Latest Discovery: Slave Boot Failure (2026-01-20)

**Critical Finding**: Debugger measurements reveal the Slave SH2 never boots correctly in PicoDrive emulator.

- **Issue**: PicoDrive reads SH2 reset vectors from wrong ROM location
- **Result**: Slave executes 68K garbage code instead of SH2 rendering engine
- **Impact**: All Slave parallelization strategies are untestable until emulator fixed
- **Status**: Root cause identified, fix required in PicoDrive `sh2_reset()`

**Documents**:
- [SLAVE_BOOT_FAILURE_ROOT_CAUSE.md](../SLAVE_BOOT_FAILURE_ROOT_CAUSE.md) - Complete analysis
- [R2_DEBUGGER_RESULTS.md](../R2_DEBUGGER_RESULTS.md) - Debugger measurements
- [ANALYSIS_REVISION_2026-01-20.md](../ANALYSIS_REVISION_2026-01-20.md) - Documentation impact

**Affected Analysis**:
- [SH2_PARALLELIZATION_STRATEGY.md](sh2-analysis/SH2_PARALLELIZATION_STRATEGY.md) - Strategy is sound but untestable
- [MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) - Static analysis contradicted
- [SH2_ARCHITECTURE_COMPLETE.md](SH2_ARCHITECTURE_COMPLETE.md) - Slave sections are theoretical

**Next Steps**:
1. Fix PicoDrive's reset vector reading (or test on real hardware)
2. Verify Slave boots to ROM 0x020650
3. Resume parallelization implementation
```

---

## Methodology Lessons Learned

### What Went Wrong

**Over-reliance on static analysis without runtime verification**
- Disassembled ROM code and made assumptions about execution paths
- Did not verify with debugger that code actually executes
- Did not account for emulator bugs affecting boot sequence

### What Went Right

**When we finally used debugger**
- Immediately discovered Slave never reaches analyzed code
- Found root cause within hours
- Revealed fundamental emulator vs hardware difference

### Best Practices Going Forward

1. **Always verify execution paths with debugger before deep analysis**
   - Static analysis shows what COULD execute
   - Debugger shows what DOES execute

2. **Distinguish emulator behavior from hardware behavior**
   - Document: "Tested on PicoDrive" vs "Should work on hardware"
   - Test on multiple emulators when possible

3. **Validate key assumptions early**
   - "Does Slave boot?" should have been first question
   - "Does R2 contain what we think?" - verify, don't assume

4. **Mark confidence levels in documentation**
   - ✅ Verified (debugger, hardware test)
   - 📋 Static analysis (code inspection)
   - ❓ Theoretical (unverified)
   - ❌ Disproven (contradicted by evidence)

---

## Positive Outcomes

### What Still Stands

1. **SH2 code quality analysis** ✅
   - Function catalog (109 functions)
   - Call graph analysis
   - Code patterns and architecture
   - All still valid - code EXISTS and is well-structured

2. **Parallelization strategy design** ✅
   - Polygon-based partitioning approach is sound
   - Sync protocol design is correct
   - Would work IF Slave boots properly

3. **68K analysis** ✅
   - All 68K code analysis unaffected
   - V-INT handlers, state machines, controller input
   - No dependencies on Slave boot behavior

4. **Data structures** ✅
   - Polygon descriptors, rendering context
   - Memory maps, SDRAM layout
   - All hardware-accurate

5. **VDP polling bottleneck analysis** ✅
   - VDP wait loops are real
   - Master SH2 idle time is real
   - Optimization opportunities still valid

### What We Gained

1. **Root cause understanding**
   - Know exact PicoDrive bug location
   - Know exact fix required
   - Can target real hardware or fix emulator

2. **Debugger infrastructure**
   - PDB debugger integrated
   - R2 tracking methodology
   - Reusable for future verification

3. **Humility about assumptions**
   - Static analysis is a starting point, not truth
   - Always verify with runtime measurements
   - Emulator ≠ hardware

---

## Action Items

### Immediate (This Session)

- [x] Create this revision document
- [ ] Update SH2_PARALLELIZATION_STRATEGY.md with caveat
- [ ] Update MASTER_SLAVE_ANALYSIS.md with debugger contradiction
- [ ] Update SH2_ARCHITECTURE_COMPLETE.md with boot failure note
- [ ] Update analysis/README.md with latest discovery
- [ ] Add confidence markers to documents (✅📋❓❌)

### Short-term (Next Session)

- [ ] Fix PicoDrive `sh2_reset()` to read from 32X header
- [ ] Verify Slave boots to ROM 0x020650
- [ ] Measure R2 register at correct entry point
- [ ] Re-validate all Slave execution assumptions

### Long-term

- [ ] Test ROM on real 32X hardware
- [ ] Compare emulator vs hardware Slave behavior
- [ ] Resume parallelization if Slave boots correctly
- [ ] Document real hardware findings

---

## Document Status Legend

Going forward, all analysis documents should include a status marker:

| Symbol | Status | Meaning |
|--------|--------|---------|
| ✅ | Verified | Confirmed via debugger, hardware test, or official docs |
| 📋 | Static Analysis | Based on code inspection, not runtime verification |
| 🧪 | Experimental | Tested in emulator, hardware behavior unknown |
| ❓ | Theoretical | Logical inference, not directly verified |
| ⚠️ | Questionable | Contradicted by some evidence |
| ❌ | Disproven | Known to be incorrect |

---

## Summary

**What changed**: Discovery that Slave SH2 never boots correctly in PicoDrive emulator

**Why it matters**: Entire parallelization strategy depends on Slave execution

**What's still valid**:
- 68K analysis ✅
- Master SH2 rendering pipeline ✅
- VDP bottleneck analysis ✅
- Data structures ✅
- Parallelization strategy design ✅ (but untestable)

**What's invalidated**:
- Assumptions about Slave runtime behavior ❌
- Claims about "Slave idle loop" execution ❌
- R2 register interpretation ❌

**Path forward**: Fix emulator or test on hardware, then resume work

---

**Revision Date**: 2026-01-20
**Revision Author**: Claude Code
**Revision Scope**: Major (affects multiple SH2 documents)
**Revision Type**: Debugger-driven correction of static analysis assumptions
