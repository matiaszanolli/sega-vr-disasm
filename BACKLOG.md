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

## P1 — FPS Improvement

### S-1d: Profile and Verify LOD Culling Impact (Phase 1 Critical Path)
**Status:** DONE (2026-03-12) — **ZERO IMPACT, S-1 is a dead end**
**Priority:** P1
**Result:** Four independent profiling tests (baseline, forced-cull, cache fix, entity-loop-skip) all produced identical cycle counts across all three CPUs. Entity descriptors at `$0600C344` are unused during racing. The entity loop at `$06002C8C` never executes during autoplay race mode. Racing uses the Huffman renderer (`$06004AD0`, Master cmd `$23`) with a different data structure at `$0600C800` (stride `$10`, byte flags, 32 entries).
**Architectural corrections:** Master SH2 (not Slave) does the 3D rendering. Slave handles palette, scene commands, and cmd_27 pixel ops.
**Key files:** `disasm/sh2/expansion/vis_bitmask_handler.asm`, `disasm/modules/68k/game/render/object_table_sprite_param_update.asm`
**References:** [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) Phase 1

### A-1: Camera Interpolation Rendering (40 FPS)
**Status:** DONE (2026-03-14, b6bd487)
**Priority:** P1
**What:** Decoupled display from game logic via camera interpolation. State 0 snapshots prev/curr camera. State 4 block-copies first render + swaps + interpolates camera + re-DMAs for second SH2 render. State 8's existing swap displays interpolated frame. Result: 2 swaps per 3 TV frames = 40 FPS display, 20 FPS game logic. Zero physics changes.
**Profiling:** CPU impact negligible (68K unchanged, SH2 at 52% for 2 renders). 3600-frame autoplay verified.
**Coverage note:** Only `state_disp_005020` (active racing) hooked. Other 4 race dispatchers (`004cb8`, `005308`, `005586`, `005618`) NOT yet hooked for camera snapshot.
**Key files:** `disasm/sections/code_2200.asm`, `disasm/modules/68k/game/state/state_disp_005020.asm`, `disasm/modules/68k/game/scene/frame_update_orch_005070.asm`
**References:** [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) §A-1, [analysis/FRAME_RATE_ARCHITECTURE.md](analysis/FRAME_RATE_ARCHITECTURE.md)

### A-2: 60 FPS Rendering
**Status:** BLOCKED — two hardware constraints discovered
**Priority:** P1 — next step toward 60 FPS
**Why:** Display 3 unique rendered frames per game frame = 60 FPS with 20 FPS game logic.
**Blockers (both must be solved):**
1. **FS swap must happen during VBlank** — writing FS outside VBlank is deferred to next VBlank. Our inline `bchg` in the main loop collides with state 8's V-INT swap. Need a V-INT handler mechanism for mid-frame swaps (without resetting `$C87E`).
2. **Re-DMA does not trigger SH2 re-render** — calling `mars_dma_xfer_vdp_fill` a second time sends data but the SH2 doesn't re-render. Corruption diagnostic confirmed zero visual effect. The SH2's render trigger mechanism inside handler `$060008A0` is not fully understood.
**Space:** SOLVED — code relocated to `code_1c200.asm` expansion area (7,936 bytes free).
**Key files:** `disasm/modules/68k/optimization/camera_interpolation_60fps.asm`, `disasm/sections/code_1c200.asm`
**References:** [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) §A-2, [KNOWN_ISSUES.md](KNOWN_ISSUES.md) §Camera Interpolation

### S-4: Merge $C87E States 0+4 (Phase 1 — 30 FPS)
**Status:** REVERTED (2026-03-14) — superseded by A-1 camera interpolation
**Priority:** P1 (historical)
**Why:** Skip state 4 in race dispatchers to achieve 30 FPS. Mechanically worked, but required compensating timing constants across 20+ files (S-4b/S-4c). After 3 sessions of regression chasing (broken collision physics, missing checkpoint music, attract mode desync, menu slowdowns, frame stuttering), the approach was abandoned.
**Lesson:** Decoupling display from game logic (Approach A) succeeded where constant patching (Approach B) failed.
**References:** [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) §S-4

### S-6: SH2 coord_transform Batching
**Status:** OPEN
**Priority:** P2 — SH2 headroom for 60 FPS stability
**Why:** `coord_transform` is 17% of Slave SH2 frame time. Batching 4 per-vertex calls into 1 eliminates redundant base value loads. Estimated ~6% SH2 reduction. No longer needed for FPS target (40 FPS achieved without SH2 optimization), but provides margin for 60 FPS on complex scenes.
**Key files:** `disasm/sh2/3d_engine/coord_transform.asm`, quad_batch callers
**References:** [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) §S-6

---

### Completed P1 Tasks (formerly Track 1 + Track 2)

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
**Status:** DONE (2026-03-03) — v6-corrected protocol verified in PicoDrive (menus + race mode, 3600 frames).
**v6-corrected design:** COMM2_HI ($A15124) is NEVER written — stays $00 permanently. Slave polls COMM2_HI for dispatch; keeping it $00 prevents all spurious dispatch. Layout: COMM0_HI=$01 trigger, COMM0_LO=$22 index (cleared by SH2 as handshake), COMM2_LO=D0/2, COMM3_HI=D1, COMM3_LO:COMM4=A0[23:0], COMM5:6=A1. COMM1 and COMM7 untouched.
**SH2 handler:** `cmd22_single_shot` at expansion ROM $023010F0 (108 bytes). Reads params, clears COMM0_LO (handshake), performs block copy, calls hw_init_short for completion.
**68K sender:** 64 bytes at $00E35A (+ 26B NOP padding). Waits COMM0_HI==0, writes params, triggers COMM0, waits COMM0_LO==0 (params-consumed handshake).
**Jump table:** $020808 → $023010F0 (expansion ROM handler).
**Testing (2026-03-03):** PicoDrive profiling_frontend --autoplay: 3600 frames (menus + race mode). COMM2_HI=$0000 at every sample. No crashes, no visual glitches.
**Previous failed approaches:** v5 (COMM2:3=A0, COMM2_HI=$06 → Slave dispatch crash in menus). Blanket async (COMM multiplexing violation). See KNOWN_ISSUES.md for full history.
**Key files:** `disasm/sections/code_e200.asm`, `disasm/sections/code_20200.asm`, `disasm/sh2/expansion/cmd22_single_shot.asm`

### B-005: Command protocol optimization (Track 2)
**Status:** DONE (2026-03-03) — sh2_send_cmd_wait converted to single-shot, profiling completed
**Original scope:** Batch 35 submissions into ~3-5 batches. **Revised:** Original design invalidated — SH2 can't access Work RAM ($0220F000 unmapped), B-003/B-004 already captured most overhead savings, and the 8-call `sh2_send_cmd_wait` target only runs during scene init (not per frame).
**What was done:**
- Re-profiled with B-003+B-004 active: 68K still 100% (127,987 cyc/frame), Master SH2 0%, Slave 80%. Command overhead is ~4,000 cyc (3.1%), down from ~12,000+.
- Converted `sh2_send_cmd_wait` ($E316) from 3-phase COMM6 handshake to single-shot protocol: COMM3:4=A0 (source), COMM5:6=A1 (dest), params-consumed handshake via COMM0_LO. Eliminates one COMM6 polling loop per call.
- SH2 handler `cmd25_single_shot` at expansion ROM $300500 (64 bytes). Reads params, clears COMM0_LO, calls existing decompressor at $06005058, then hw_init_short for completion.
- Jump table entry $25 at $020814 redirected from $06005024 → $02300500.
- PicoDrive 3600-frame autoplay verified (menus + race mode). COMM2_HI=$0000 throughout.
**Key files:** `disasm/sections/code_e200.asm`, `disasm/sh2/expansion/cmd25_single_shot.asm`, `disasm/sections/expansion_300000.asm`, `disasm/sections/code_20200.asm`
**Next optimization:** S-4 (state merge + speed compensation) is DONE — 30 FPS achieved. See [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) Phase 2 for next steps.

### B-006: ~~Activate v4.0 parallel hooks~~
**Status:** REVERTED and SHELVED (2026-02-11, reassessed 2026-03-10)
**Why:** Enable Slave CPU vertex transform offload (infrastructure built but dormant).
**Result (2026-02-10):** 3 patches applied. ROM boots, menus work. **Crashes with stuck engine sound when entering race mode.**
**Root cause (2026-02-11):** Three independent bugs in Patch #2 (master_dispatch_hook): COMM7 namespace collision (game cmd 0x27 triggers uninitialized queue drain), literal pool collision at $020480, R0 clobber. Reverting Patch #2 alone was insufficient — Patches #1 and #3 together also caused crashes (shadow_path_wrapper COMM7 barrier deadlock or parallel vertex_transform data races).
**Fix:** Full revert of all 3 patches. Expansion ROM code exists but is dead.
**Reassessment (2026-03-10):** Dual-SH2 rendering via this approach is shelved. The fundamental design has namespace collision and data race issues. See [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) Phase 1 (S-1 LOD culling + S-4 state merge) for the priority path to 30 FPS. Phase 2 item S-8 (Master as vertex transform coprocessor) revisits dual-SH2 with a safer design.
**Key files:** `disasm/sections/code_20200.asm`, `disasm/sections/code_22200.asm`, `disasm/sections/expansion_300000.asm`

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
**Status:** NOT FEASIBLE (2026-03-08) — Static analysis disproved the optimization premise
**Why:** 2.4x rasterizer speedup available if VRD isn't using 4-word FIFO bursts.
**Finding:** Three independent code paths analyzed:
1. **func_065 (unrolled_data_copy)**: Writes to **SDRAM** ($06003E3C, $060086D4), NOT framebuffer. FIFO bursts don't apply to SDRAM.
2. **edge_scan (func_044)**: Writes to framebuffer but uses **scattered byte/word writes** (`MOV.B R4,@R1`, `MOV.W R4,@R1`) with variable stride. Cannot be restructured for 4-word bursts without completely rewriting the rasterizer.
3. **cmd_27 (inline_slave_drain)**: Uses `$0200` stride (512 bytes between rows) — inherently non-sequential, FIFO burst impossible.
**Root cause:** The 68K is the bottleneck (100% utilization), not SH2 framebuffer writes. Even if FIFO bursts were possible, SH2 is only 78% utilized — saving SH2 cycles would not improve FPS.
**Conclusion:** Track 6 FIFO batching removed from active opportunities.

---

## P3 — Code Quality

### B-014: Extract inline dc.w code blocks from section files into modules
**Status:** DONE (2026-03-09)
**Why:** B-010 translated dc.w *inside* existing modules but never addressed dc.w *in section files* — code that was never extracted into modules at all. ~1,572 dc.w lines across 10 section files, including 500+ bytes of executable 68K code sitting inline.
**Result:** Audited all 10 68K section files. Extracted 10 code blocks into properly named modules (2 boot, 2 ai, 1 entity, 1 physics, 2 render, 1 scene, 1 state). Annotated all remaining dc.w as data tables, RTS stubs, or cross-boundary code. No executable code remains inline in section files.
**New modules:** exception_vector_trampolines, adapter_boot_entry, collision_avoidance_speed_calc, collision_avoidance_no_target, entity_type_dispatch_tables, conditional_update_check, entity_render_frame_orch, sprite_descriptors_and_palette_load, race_scene_init_vdp_mode, palette_scene_dispatch
**Build:** Byte-identical verified (md5: `453bdcbb34331a96e01c001490031243`).
**Module count:** 813 → 823 (corrected — prior count of 821 was inaccurate).

### B-010: Translate remaining 68K dc.w modules
**Status:** DONE (Phases 1-5 complete)
**Phase 1 (done):** Automated translation of non-PC-relative, non-branch dc.w lines — 3851 lines across 139 files.
**Phase 2 (done):** Label map builder (800 labels from 771 included modules + section files) + PC-relative decoder (JSR/JMP/BSR/LEA d16(PC)) + branch decoder (Bcc.S/W, BRA, DBcc) with local label generation. 5504 total dc.w lines converted, 2722 remaining (data tables, complex addressing modes, unlabeled targets). 530 of 821 modules fully translated.
**Phase 3 (done):** Manual branch translations — 82 Bcc/BRA/DBcc dc.w across 45 modules.
**Phase 4 (done):** Manual JSR/JMP translations — 70 dc.w across 29 modules. 4 reverted (undefined labels outside build chain: FastCopy20, SetDisplayParams, unpack_tiles_vdp, zbus_request).
**Phase 5 (done):** BCD arithmetic instructions — 23 ABCD/SBCD/ANDI-to-CCR/ORI-to-CCR dc.w across 3 modules.
**Total:** 5679 dc.w converted, 736 of 821 modules fully translated. Remaining ~522 dc.w are data (sprite descriptors, pointer tables, lookup values, padding) — not translatable.
**Build:** Byte-identical verified (md5: `eba54fc1e2768e26079b7db6ad0f0b69`).
**Tool:** `python3 tools/translate_68k_modules.py --phase2 --batch disasm/modules/68k/`

### B-011: Translate remaining SH2 functions to mnemonics
**Status:** DONE (2026-02-28) — all 92 function IDs accounted for
**Result:** All 92 SH2 function IDs (data_copy-091) are integrated into the build system via 74 .inc files (some grouped). 46 use `.short` hex format to bypass assembler padding; 28 use mnemonic format with linker scripts.
**Verification of "missing" IDs:** func_027/028 are in bounds_compare_short.inc (shared exit paths). func_035/064 are numbering gaps (no address space between adjacent functions). func_056-059 are covered by unrolled_copy_short+065 (Makefile confirms). func_060-063 are covered by offset_bsr_short-054 (doc-only source file).
**Key files:** `disasm/sh2/3d_engine/`, `disasm/sh2/generated/`, [SH2_TRANSLATION_INTEGRATION.md](analysis/sh2-analysis/SH2_TRANSLATION_INTEGRATION.md)

### B-013: Fix SH2 address errors in COMM_REGISTER_USAGE_ANALYSIS.md
**Status:** DONE (2026-02-28)
**Why:** SH2 addresses used ×4 spacing ($20004020, $20004024, $20004028...) instead of correct ×2 spacing ($20004020, $20004022, $20004024...). All 7 wrong addresses (COMM1-COMM7) corrected against hardware manual.
**Key files:** `analysis/optimization/COMM_REGISTER_USAGE_ANALYSIS.md`

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
| B-005 | Single-shot cmd $25 + re-profiling — 3-phase→single-shot, decompressor wrapper at $300500, 3600-frame verified | — | 2026-03-03 |
| B-011 | SH2 function integration — all 92 IDs verified, doc updated | — | 2026-02-28 |
| B-013 | Fix SH2 address errors in COMM_REGISTER_USAGE_ANALYSIS.md (7 addresses corrected) | — | 2026-02-28 |
| B-004 | Single-shot cmd $22 (v6-corrected) — COMM2_HI never written, 3600-frame PicoDrive test passed | — | 2026-03-03 |
| B-003 | Async sh2_cmd_27 via COMM registers (bypasses Master SH2) | — | 2026-02-17 |
| B-008 | RV bit profiling — NEVER set, expansion ROM safe (static analysis) | — | 2026-02-16 |
| B-006 | Activate v4.0 parallel hooks — **PARTIAL**: Patch #2 needs revert (COMM7 collision crash) | 651a415 | 2026-02-10 |
| B-014 | Extract inline dc.w code from section files → 10 new modules (813→823) | — | 2026-03-09 |
| B-010 | dc.w→mnemonic Phases 1-5 (5679 lines, 736/821 modules fully translated) | — | 2026-02-28 |
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
