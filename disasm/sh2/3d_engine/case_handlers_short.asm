/*
 * func_002: Switch Case Handlers Block
 * ROM File Offset: 0x23070 - 0x230C7 (88 bytes, 44 words)
 * SH2 Address: 0x02223070 - 0x022230C7
 *
 * Purpose: Case handlers called from func_001's jump table.
 *          Processes different rendering states with various R6/R7 parameter
 *          values, calling func_003/func_004 helper functions.
 *
 * Jump Table Targets (from func_001's BSRF @ $023048):
 *   Case 0: $023070 (offset $0024) — calls func_003 twice
 *   Case 2: $023088 (offset $003C) — calls func_004 once
 *   Case 4: $023094 (offset $0048) — calls func_004 twice
 *   Case 6: $0230A6 (offset $005A) — calls func_004 once
 *
 * Input:
 *   R13 = State register (counter in lower word)
 *   R14 = RenderingContext pointer
 *   R10, R11, R12 = Context pointers (from func_001 dispatch)
 *
 * Note: Exit paths at $0230C8+ are in func_003_004_offset_copy_short.asm.
 *       All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23070 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * Case 0 Handler: Full processing path
 * Entry: $023070 — saves state, calls func_003 twice, then common_exit
 * ═══════════════════════════════════════════════════════════════════════════ */
case_0_handler:
    .short  0x4F22                            /* $023070: STS.L PR,@-R15 */
    .short  0x5CE8                            /* $023072: MOV.L @(32,R14),R12 */
    .short  0x60D5                            /* $023074: EXTU.W R13,R0 */
    .short  0x81E1                            /* $023076: MOV.W R0,@(2,R14) */
    .short  0x66D5                            /* $023078: EXTU.W R13,R6 */
    .short  0xB02B                            /* $02307A: BSR func_003 ($0230D4) */
    .short  0xE700                            /* $02307C: [delay] MOV #0,R7 */
    .short  0x66D5                            /* $02307E: EXTU.W R13,R6 */
    .short  0xB028                            /* $023080: BSR func_003 ($0230D4) */
    .short  0xE710                            /* $023082: [delay] MOV #16,R7 */
    .short  0xA019                            /* $023084: BRA .common_exit ($0230BA) */
    .short  0x66D5                            /* $023086: [delay] EXTU.W R13,R6 */

/* ═══════════════════════════════════════════════════════════════════════════
 * Case 2 Handler: Single func_004 call with R6=48, R7=16
 * Entry: $023088
 * ═══════════════════════════════════════════════════════════════════════════ */
case_2_handler:
    .short  0x4F22                            /* $023088: STS.L PR,@-R15 */
    .short  0xE630                            /* $02308A: MOV #48,R6 */
    .short  0xB027                            /* $02308C: BSR func_004 ($0230DE) */
    .short  0xE710                            /* $02308E: [delay] MOV #16,R7 */
    .short  0xA00F                            /* $023090: BRA .restore_and_exit ($0230B2) */
    .short  0x4F26                            /* $023092: [delay] LDS.L @R15+,PR */

/* ═══════════════════════════════════════════════════════════════════════════
 * Case 4 Handler: Two-stage processing with func_004
 * Entry: $023094
 * ═══════════════════════════════════════════════════════════════════════════ */
case_4_handler:
    .short  0x4F22                            /* $023094: STS.L PR,@-R15 */
    .short  0xE630                            /* $023096: MOV #48,R6 */
    .short  0xB021                            /* $023098: BSR func_004 ($0230DE) */
    .short  0xE700                            /* $02309A: [delay] MOV #0,R7 */
    .short  0xE620                            /* $02309C: MOV #32,R6 */
    .short  0xB01E                            /* $02309E: BSR func_004 ($0230DE) */
    .short  0xE710                            /* $0230A0: [delay] MOV #16,R7 */
    .short  0xA006                            /* $0230A2: BRA .restore_and_exit ($0230B2) */
    .short  0x4F26                            /* $0230A4: [delay] LDS.L @R15+,PR */

/* ═══════════════════════════════════════════════════════════════════════════
 * Case 6 Handler: Simple single func_004 call
 * Entry: $0230A6
 * ═══════════════════════════════════════════════════════════════════════════ */
case_6_handler:
    .short  0x4F22                            /* $0230A6: STS.L PR,@-R15 */
    .short  0xE620                            /* $0230A8: MOV #32,R6 */
    .short  0xB018                            /* $0230AA: BSR func_004 ($0230DE) */
    .short  0xE700                            /* $0230AC: [delay] MOV #0,R7 */
    .short  0xA000                            /* $0230AE: BRA .restore_pr ($0230B2) */
    .short  0x4F26                            /* $0230B0: [delay] LDS.L @R15+,PR */

/* ─────────────────────────────────────────────────────────────────────────
 * Shared exit: restore_and_exit — re-save PR, store status, fall through
 * ───────────────────────────────────────────────────────────────────────── */
.restore_and_exit:
    .short  0x4F22                            /* $0230B2: STS.L PR,@-R15 */
    .short  0x60D5                            /* $0230B4: EXTU.W R13,R0 */
    .short  0x81E1                            /* $0230B6: MOV.W R0,@(2,R14) */
    .short  0x66D5                            /* $0230B8: EXTU.W R13,R6 */

/* ─────────────────────────────────────────────────────────────────────────
 * Common exit: call func_003, conditionally call again
 * ───────────────────────────────────────────────────────────────────────── */
.common_exit:
    .short  0xB00B                            /* $0230BA: BSR func_003 ($0230D4) */
    .short  0xE720                            /* $0230BC: [delay] MOV #32,R7 */
    .short  0xC801                            /* $0230BE: TST #1,R0 */
    .short  0xE730                            /* $0230C0: MOV #48,R7 */
    .short  0x8B04                            /* $0230C2: BF .skip ($0230CE) */
    .short  0xB006                            /* $0230C4: BSR func_003 ($0230D4) */
    .short  0x66D5                            /* $0230C6: [delay] EXTU.W R13,R6 */

/* Execution falls through to func_003_004 block at $0230C8 */

/* ============================================================================
 * End of func_002 case handlers (88 bytes, 44 words)
 *
 * Analysis:
 * - Multi-entry case handler block for func_001's jump table
 * - Case 0 calls func_003 (R10-based offset copy): R7=0, R7=16
 * - Cases 2/4/6 call func_004 (R12-based offset copy): various R6/R7
 * - Each case saves/restores PR via STS.L/LDS.L pairs
 * - Common exit calls func_003 with R7=32, conditionally R7=48
 * - BF at $0230C2 targets $0230CE (func_002_alt_path in func_003_004)
 * ============================================================================ */
