# BACKLOG — Task Queue

Pick the highest-priority unclaimed task. Mark it `IN PROGRESS` with your session date before starting. Mark `DONE` when complete with commit hash.

**Priority levels:** P0 = blocking other work, P1 = direct FPS improvement, P2 = infrastructure, P3 = nice to have.

---

## P0 — Blockers

### B-001: Find 20+ bytes in 68K $00E200 section
**Status:** MOOT (bypassed by in-place replacement)
**Why:** Track 1 (async commands) originally needed `sh2_send_cmd_async` shim in this section, but had 0 bytes free.
**Resolution:** In-place replacement strategy bypassed the need. sh2_cmd_27's 82-byte body at $E3B4 was replaced with 68-byte async enqueue + 14B padding. No additional space needed.
**Key files:** `disasm/sections/code_e200.asm`
**Closed:** 2026-02-14

---

## P1 — FPS Improvement (Track 1: Async Commands)

### B-002: ~~Master SH2 CMDINT queue infrastructure~~
**Status:** SKIPPED (CMDINT not needed for cmd_27 async)
**Why:** Original Track 1 design required Master SH2 CMDINT ISR + ring buffer in SDRAM for async command submission.
**Resolution:** Simpler design adopted — Work RAM ring buffer ($FFFB00) + COMM7 doorbell + Slave SH2 processing. No CMDINT interrupts needed. Infrastructure exists (cmdint_handler at $300800 reserved but dormant).
**Key files:** `disasm/sections/expansion_300000.asm`
**Closed:** 2026-02-14

### B-003: Convert sh2_cmd_27 to async (21 calls/frame)
**Status:** DONE (2026-02-17) — COMM-register approach, fully tested
**v1 (ceb0ed3, reverted):** Broke menu highlights. Used Work RAM queue ($FFFB00) — SH2 cannot access 68K Work RAM.
**v2-v3 (reverted):** Tried $22FFFB00 and $02FFFB00 as queue base — both unmapped SH2 space.
**v4 (current, working):** Direct COMM register parameter passing. 68K writes params to COMM2-6, doorbell COMM7=$0027. Slave reads COMM2-6 inline from SDRAM at $020608 (88 bytes). No queue, no Work RAM, no expansion ROM execution on Slave.
**Key insight:** SH2 memory map shows $0240 0000+ as "-" (nothing). The ONLY shared writable memory is COMM registers (16 bytes) and SDRAM ($0200 0000-$0203 FFFF).
**Key files:** `disasm/sections/code_e200.asm`, `disasm/sections/code_20200.asm`

### B-004: Single-shot protocol for sh2_send_cmd (14 calls/frame)
**Status:** IN PROGRESS (2026-02-17) — params-read signal fix applied, pending emulator test
**Previous approach (REVERTED 2026-02-14):** Blanket async via general_queue_drain at $FFFC00 — failed due to 3-phase COMM multiplexing protocol constraints. Infrastructure preserved dormant at $301000.
**Current approach:** In-place handler replacement at SDRAM $06005198 with "params read" signal. The 68K writes ALL four parameters (D1→COMM1, A0→COMM2:3, A1→COMM4:5, D0→COMM6) at once, triggers COMM0_LO=$22 + COMM0_HI=$01 (standard dispatch — COMM0_LO is the jump table index, entry $22→$06005198). Handler reads COMM1-6, then clears COMM0_LO to signal "params read." 68K waits for COMM0_LO==0 before returning. Block copy proceeds, func_084 clears COMM0_HI.
**Root cause of earlier failures (black bar + crash):** COMM register clobber race. The original sh2_send_cmd was blocking (~150 cycles in 3 COMM6 waits), preventing other COMM-writing code from running. Our single-shot version returned instantly, and sh2_cmd_27 (21 calls/frame, writes COMM2-6) ran before the SH2 handler read the params, corrupting source/dest/width. The "params read" signal handshake closes this race window.
**Discarded hypotheses:** (1) $06004448 COMM1_LO bit 1 corruption was irrelevant — $06004448 is cmd $01's handler, dispatch uses COMM0_LO not COMM0_HI. (2) "Second-level dispatcher" at $060008A0 is actually cmd $01's fixed handler, not a general dispatcher.
**Implementation:**
- 68K: sh2_send_cmd at $E35A writes COMM1-6 params, triggers COMM0, waits for COMM0_LO==0
- SH2: handler at $06005198 reads COMM1-6, clears COMM0_LO (signal), block copy, func_084
- Jump table: entry at $020808 unchanged ($06005198) — direct dispatch via COMM0_LO index
- COMM7 left UNTOUCHED (Slave doorbell reserved for B-003)
**Cycle savings:** ~100 cycles/call × 14 calls/frame = ~1,400 cycles/frame (~1.1% of 68K budget). The params-read wait adds ~50 cycles but saves ~150 from eliminated COMM6 handshake phases.
**Key files:** `disasm/sections/code_e200.asm`, `disasm/sections/code_24200.asm` (in-place handler)

### B-005: Command batching (Track 2)
**Status:** OPEN (blocked by B-004)
**Why:** Reduce 35 submissions to ~3-5 batches for less per-command overhead.
**Acceptance:** batch_copy_handler works, cmd_27 grouped. Profiler confirms further 68K reduction.
**Key files:** expansion_300000.asm ($300500 batch_copy_handler)
**Depends on:** B-004
**Ref:** [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) § Track 2

### B-006: Activate v4.0 parallel hooks
**Status:** REVERTED — all 3 patches disabled (2026-02-11)
**Why:** Enable Slave CPU vertex transform offload (infrastructure built but dormant).
**Result (2026-02-10):** 3 patches applied. ROM boots, menus work. **Crashes with stuck engine sound when entering race mode.**
**Root cause (2026-02-11):** Patch #2 (master_dispatch_hook) writes every game command byte to COMM7. Game's cmd 0x27 (sent 21×/frame) triggers `cmd27_queue_drain` on the Slave with uninitialized queue data → random memory writes → crash. Three additional bugs in committed Patch #2: R0 clobbered, literal pool collision at $020480, COMM7 namespace collision. Reverting Patch #2 alone was insufficient — Patches #1 and #3 together also caused race-mode crashes (likely shadow_path_wrapper COMM7 barrier deadlock or data races from parallel func_021 execution on both CPUs). See [KNOWN_ISSUES.md](KNOWN_ISSUES.md) and [MASTER_SH2_DISPATCH_ANALYSIS.md](analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md).
**Fix:** Full revert of all 3 patches to original game code. Expansion ROM code still exists but is dead (nothing jumps to it).
**Patches:** ~~Slave idle ($0203CC→$02300200)~~ REVERTED, ~~Master dispatch ($02046A→$02300050)~~ REVERTED, ~~func_021 trampoline ($0234C8→$02300400)~~ REVERTED.
**Key files:** `disasm/sections/code_20200.asm`, `disasm/sections/code_22200.asm`, `disasm/sections/expansion_300000.asm`
**Next:** Requires redesign. Patches #1 and #3 need independent validation before re-activation. Test each patch in isolation with race-mode verification.

---

## P2 — Infrastructure & Diagnostics

### B-007: Fix FPS counter production sampling bug
**Status:** OPEN
**Why:** FPS counter flip detection works (Test 1: counter increments correctly), but production once-per-second sampling always shows 00.
**Diagnosis so far:** `fps_vint_tick` increments (confirmed via diagnostic showing 99). Epilogue is reached. ROM encoding verified byte-perfect. The delta computation (`fps_flip_counter - fps_flip_last` → `fps_value`) produces 0.
**Likely cause:** Register corruption between flip detection and sampling code, or addressing mode issue in delta path.
**Key files:** `disasm/modules/68k/optimization/fps_vint_wrapper.asm`, `disasm/modules/68k/optimization/fps_render.asm`
**Depends on:** Nothing

### B-008: Profile RV bit usage during gameplay
**Status:** DONE (2026-02-16) — RV is NEVER set. Expansion ROM is safe.
**Why:** If RV=1 during gameplay, expansion ROM code at $02300000 stalls — critical for all Track 1+ work.
**Result:** Full static analysis of every DREQ_CTRL ($A15106/$A15107) reference in the codebase. VRD exclusively uses CPU Write mode (manual FIFO feeding via $A15112), never ROM-to-VRAM DMA. All 9 translated writes use `move.b #$04,$A15107` (sets 68S only, RV=0). All 13 raw dc.w `$5106`/`$5107` occurrences are data values in data tables (no preceding instruction encoding). Boot code writes to DREQ source/dest regs but never DREQ_CTRL. **RV=1 never occurs.**
**Impact:** Expansion ROM at $02300000+ is confirmed safe for SH2 execution at all times. No SDRAM copy mitigation needed. All Track 1+ optimization work can proceed without RV concerns.

### B-009: Profile frame buffer write patterns (FIFO bursts)
**Status:** OPEN
**Why:** 2.4x rasterizer speedup available if VRD isn't using 4-word FIFO bursts.
**Approach:** PC-level hotspot profiling of SH2 frame buffer write addresses.
**Acceptance:** Report on burst usage, potential cycle savings quantified.

---

## P3 — Code Quality

### B-010: Translate remaining 68K dc.w modules
**Status:** DONE (Phase 1+2 complete)
**Phase 1 (done):** Automated translation of non-PC-relative, non-branch dc.w lines — 3851 lines across 139 files.
**Phase 2 (done):** Label map builder (800 labels from 771 included modules + section files) + PC-relative decoder (JSR/JMP/BSR/LEA d16(PC)) + branch decoder (Bcc.S/W, BRA, DBcc) with local label generation. 5504 total dc.w lines converted, 2722 remaining (data tables, complex addressing modes, unlabeled targets). 530 of 821 modules fully translated.
**Build:** Byte-identical verified (md5: `2d842a62085df8efba46053c5bea8868`).
**Tool:** `python3 tools/translate_68k_modules.py --phase2 --batch disasm/modules/68k/`

### B-011: Translate 17 remaining SH2 functions
**Status:** OPEN (partially blocked — see [KNOWN_ISSUES.md](KNOWN_ISSUES.md))
**Why:** 75/92 SH2 functions translated. 17 blocked by assembler padding.
**Approach:** Focus on simpler ones first: func_009, func_010, func_060-063. Skip func_001/002 (coordinators, size-critical).
**Key files:** `disasm/sh2/src/`, [SH2_TRANSLATION_INTEGRATION.md](analysis/sh2-analysis/SH2_TRANSLATION_INTEGRATION.md)

### B-012: Replace raw hex register addresses with symbolic names
**Status:** DONE (2026-02-10)
**Why:** Raw hex like `$00A15120` is unreadable; `COMM0_HI` is self-documenting. Critical for Track 1 work where COMM register logic must be clearly understood.
**Result:** All mnemonic-format modules hardened across 5 commits (118+ modules total). Covers all 17 module categories.
**Symbols used:** MARS_SYS_*, MARS_VDP_*, MARS_CRAM*, MARS_DREQ_*, MARS_FIFO, COMM0-7, COMM0_HI/LO, COMM1_HI/LO, Z80_BUSREQ, Z80_RESET, Z80_RAM, PSG, SRAM_BANK0, VDP_DATA, VDP_CTRL, MARS_FRAMEBUFFER, MARS_OVERWRITE.
**Note:** Remaining raw hex exists only in DC.W-encoded files (z80_commands.asm, init_sequence.asm, hw_reg_init.asm) where addresses are split across machine words. These need DC.W→mnemonic translation first (see B-010).
**Key files:** `disasm/modules/shared/definitions.asm` (master symbol table)

---

## Done

| ID | Description | Commit | Date |
|----|-------------|--------|------|
| B-003 | Async sh2_cmd_27 via COMM registers (bypasses Master SH2) | — | 2026-02-17 |
| B-008 | RV bit profiling — NEVER set, expansion ROM safe (static analysis) | — | 2026-02-16 |
| B-006 | Activate v4.0 parallel hooks — **PARTIAL**: Patch #2 needs revert (COMM7 collision crash) | 651a415 | 2026-02-10 |
| B-010 | dc.w→mnemonic Phase 1+2 (5504 lines, 530/821 modules fully translated) | — | 2026-02-13 |
| B-012 | Symbolic register hardening batch 1 (6 sh2/vdp modules) | 3b347d3 | 2026-02-10 |
| B-012 | Symbolic register hardening batch 2 (8 modules + COMM6 fix) | 350e346 | 2026-02-10 |
| B-012 | Symbolic register hardening batch 3 (20 modules, all categories) | 170c6e7 | 2026-02-10 |
| B-012 | Symbolic register hardening batch 4-6 (84 modules, all remaining) | a022098 | 2026-02-10 |
| — | dc.w→mnemonic translations in code_e200.asm (30+ instructions) | e8a0b5e | 2026-02-10 |
| — | Bank probe + DREQ register fix in adapter_init | 423f2e4 | 2026-02-10 |
| — | Codebase consolidation (133 MB removed, 775 files) | 53a9324 | 2026-02-09 |
| — | 68K modularization (693 functions, 12 sections) | v5.0.0 | 2026-02 |
| — | SH2 function translation (75 functions) | v5.0.0 | 2026-02 |
| — | 68K module auto-translation (571 modules) | v5.0.0 | 2026-02 |
| — | Expansion ROM infrastructure (1MB at $300000) | v4.0.0 | 2026-01 |
| — | Profiling infrastructure (cycle-accurate) | v3.0.0 | 2026-01 |
| — | Delay loop experiment (proved 68K bottleneck) | v3.0.0 | 2026-01 |
