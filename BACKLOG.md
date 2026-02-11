# BACKLOG — Task Queue

Pick the highest-priority unclaimed task. Mark it `IN PROGRESS` with your session date before starting. Mark `DONE` when complete with commit hash.

**Priority levels:** P0 = blocking other work, P1 = direct FPS improvement, P2 = infrastructure, P3 = nice to have.

---

## P0 — Blockers

### B-001: Find 20+ bytes in 68K $00E200 section
**Status:** OPEN
**Why:** Track 1 (async commands) needs `sh2_send_cmd_async` shim in this section, but it has 0 bytes free.
**Approach:** Analyze modules in the section for dead code, unreachable paths, or compressible functions. Alternative: BSR trampoline to a section with space.
**Acceptance:** 20+ bytes reclaimed, ROM byte-identical in all other regions.
**Key files:** `disasm/sections/code_e200.asm`, [68K_FUNCTION_REFERENCE.md](analysis/68K_FUNCTION_REFERENCE.md)
**Depends on:** Nothing
**Ref:** [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) § Phase 1

---

## P1 — FPS Improvement (Track 1: Async Commands)

### B-002: Master SH2 CMDINT queue infrastructure
**Status:** OPEN (blocked by B-001)
**Why:** Core of Track 1 — allows 68K to submit commands without blocking on COMM registers.
**Approach:** Ring buffer in SDRAM ($2203F000, 64 entries x 8 bytes = 512B). CMDINT handler in expansion ROM. 68K shim writes to buffer + fires CMDINT.
**Acceptance:** Single command type (cmd_27) submits async. Profiler shows reduced 68K blocking.
**Key files:** `disasm/sections/expansion_300000.asm`, [SH2_ASYNC_QUEUE_ANALYSIS.md](analysis/optimization/SH2_ASYNC_QUEUE_ANALYSIS.md)
**Depends on:** B-001
**Ref:** [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) § Track 1

### B-003: Convert sh2_cmd_27 to async (21 calls/frame)
**Status:** OPEN (blocked by B-002)
**Why:** Biggest single win — 60% of command submissions.
**Acceptance:** 21 cmd_27 calls use async path. Profiler shows >=25% 68K cycle reduction.
**Depends on:** B-002

### B-004: Convert remaining commands to async (14 calls/frame)
**Status:** OPEN (blocked by B-003)
**Why:** Complete Track 1 — all 35 commands non-blocking.
**Acceptance:** All submissions async. Handle 2 unsafe call sites ($010B2C, $010BAE with secondary RAM flag blocking).
**Depends on:** B-003

### B-005: Command batching (Track 2)
**Status:** OPEN (blocked by B-004)
**Why:** Reduce 35 submissions to ~3-5 batches for less per-command overhead.
**Acceptance:** batch_copy_handler works, cmd_27 grouped. Profiler confirms further 68K reduction.
**Key files:** expansion_300000.asm ($300500 batch_copy_handler)
**Depends on:** B-004
**Ref:** [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) § Track 2

### B-006: Activate v4.0 parallel hooks
**Status:** DONE (2026-02-10)
**Why:** Enable Slave CPU vertex transform offload (infrastructure built but dormant).
**Result:** All 3 patches applied successfully. ROM boots, parallel processing active. Slave polls COMM7, Master dispatch routes cmd $16 to hook, func_021 redirects to shadow_path_wrapper.
**Patches:** Slave idle ($0203CC→$02300200), Master dispatch ($02046A→$02300050), func_021 trampoline ($0234C8→$02300400).
**Key files:** `disasm/sections/code_20200.asm`, `disasm/sections/code_22200.asm`, `disasm/sections/expansion_300000.asm`
**Next:** Profile to measure FPS improvement and CPU utilization changes.

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
**Status:** OPEN
**Why:** If RV=1 during gameplay, expansion ROM code at $02300000 stalls — critical for all Track 1+ work.
**Approach:** Instrument profiler or add RV monitoring to init_sequence.
**Acceptance:** Definitive answer: does RV=1 occur during active rendering?
**Key files:** `tools/libretro-profiling/`, `disasm/modules/68k/boot/init_sequence.asm`

### B-009: Profile frame buffer write patterns (FIFO bursts)
**Status:** OPEN
**Why:** 2.4x rasterizer speedup available if VRD isn't using 4-word FIFO bursts.
**Approach:** PC-level hotspot profiling of SH2 frame buffer write addresses.
**Acceptance:** Report on burst usage, potential cycle savings quantified.

---

## P3 — Code Quality

### B-010: Translate remaining 122 68K dc.w modules
**Status:** OPEN
**Why:** 571/693 modules translated (82.5%). Improves readability and maintainability.
**Acceptance:** Each translated module verified byte-identical. No build regressions.
**Key files:** Modules in `disasm/modules/68k/*/fn_*.asm` still containing dc.w blocks.

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
| B-006 | Activate v4.0 parallel hooks (3 patches: Slave loop, Master dispatch, func_021) | PENDING | 2026-02-10 |
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
