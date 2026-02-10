# Archived Disassembly Files

**Date Archived:** 2026-01-23
**Reason:** Organization cleanup - consolidating experimental iterations

All files preserved in git history. Nothing deleted, just moved for clarity.

---

## Phase 11: Slave CPU Work Distribution

**Final working implementation:** [../sections/expansion_300000.asm](../sections/expansion_300000.asm)

### Archived Iterations (`phase11_slave_iterations/`)

Development iterations from Jan 2026 exploring Slave CPU COMM protocol:

**slave_comm4 variants:**
- `slave_comm4_compact.asm` - Compact polling loop
- `slave_comm4_detector.asm` - COMM4 signal detection logic
- `slave_comm4_minimal.asm` - Minimal working version
- `slave_comm4_poll_only.asm` - Pure polling, no handler
- `slave_comm4_redirect.asm` - Redirect-based approach

**slave_work variants:**
- `slave_work_loop.asm` - Initial polling loop
- `slave_work_minimal.asm` - Stripped down version
- `slave_work_simple.asm` - Simplified logic
- `slave_work_tight.asm` - Cycle-optimized version
- `slave_work_check_compact.asm` - Compact check version
- `slave_work_redirect_final.asm` - Final redirect attempt

**slave_test variants:**
- `slave_test_exact.asm` - Byte-perfect test (WORKING)
- `slave_test_loop.asm` - Test loop with alignment

**slave_redirect:**
- `slave_redirect.asm` - Generic redirect handler

**Files:** 14 total
**Status:** Superseded by expansion_300000.asm
**Value:** Historical reference for COMM protocol development

---

## Phase Experiments (`phase_experiments/`)

Various SH2 master/slave coordination experiments from development phases:

### Master Experiments
- `sh2_master_minimal_dispatcher.asm` - Minimal master dispatcher
- `sh2_master_sync.asm` - Master sync logic
- `sh2_master_sync_phase2.asm` - Phase 2 sync iteration
- `sh2_master_work_dispatch.asm` - Work distribution dispatcher

### Slave Experiments
- `sh2_slave_consolidated.asm` - Consolidated slave logic
- `sh2_slave_diagnostic.asm` - Diagnostic/debug slave code
- `sh2_slave_engine.asm` - Slave rendering engine experiment
- `sh2_slave_expansion.asm` - Expansion ROM slave code
- `sh2_slave_idle_wrapper.asm` - Idle loop wrapper
- `sh2_slave_jsr_helper.asm` - JSR helper routines
- `sh2_slave_rendering_stage_*.asm` (0-4) - Rendering pipeline stages
- `sh2_slave_test.asm` - Generic slave test
- `sh2_slave_test_split_*.asm` (200-450) - Split polygon tests
- `sh2_slave_work_check.asm` - Work check logic
- `sh2_slave_work_compact.asm` - Compact work handler

### Phase-Specific Experiments
- `sh2_phase4_4a.asm` - Phase 4 H-INT experiments

### Helper/Utility
- `sh2_redirect_to_wrapper.asm` - Generic redirect helper
- `sh2_func_047_modified.asm` - Modified func_047 (includes VDP flag)
- `sh2_h_int_handler.asm` - H-INT handler (includes VDP flag)
- `sh2_vdp_ready_flag.asm` - VDP ready flag implementation

### Reference Disassemblies
- `sh2_3d_engine.asm` - Original 3D engine disassembly (non-annotated)
  - **Superseded by:** [../sh2_3d_engine_annotated.asm](../sh2_3d_engine_annotated.asm)

**Files:** 30 total
**Status:** All superseded by annotated disassembly or not in active use
**Value:** Historical reference for understanding development process

---

## Restoration

If you need any of these files:

```bash
# They're all in git history
git log --all --full-history -- "disasm/archive/**"

# Or just copy from archive
cp disasm/archive/phase11_slave_iterations/slave_comm4_minimal.asm disasm/sh2/
```

---

## Build Impact

**None.** These files were never part of the active build system:
- Not included in `disasm/vrd.asm`
- Not included in `disasm/sections/*.asm`
- Not referenced in `Makefile`

They were standalone experiments and iterations used during development.

---

## Active Files (Not Archived)

These remain in active use:

**Top Level:**
- `sh2_3d_engine_annotated.asm` - 109 functions, fully annotated (REFERENCE)
- `sh2_symbols.inc` - Symbol definitions
- `SH2_SYMBOL_MAP.md` - Symbol map documentation

**Under sh2/:**
- `README.md` - SH2 workflow documentation
- `generated/` - Auto-generated dc.w includes (if any)

**Under sections/:**
- `expansion_300000.asm` - Phase 11 working handler (IN ROM)
- All other `code_*.asm` files - Binary blob sections (IN ROM)

---

**Organization Status:** Phase 1 Complete (Archival)
**Next:** Phase 2 - Convert func_006 to source assembly
**See:** [../ORGANIZATION_PLAN.md](../ORGANIZATION_PLAN.md)
