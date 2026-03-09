/*
 * func_001: Main Coordinator / Switch Dispatcher
 * ROM File Offset: 0x23024 - 0x2306F (76 bytes)
 * SH2 Address: 0x02223024 - 0x0222306F
 *
 * Purpose: Central dispatch function for 3D engine operations.
 *          Uses a jump table to route processing based on state flags.
 *          Has two entry points calling different setup functions.
 *
 * Entry Points:
 *   A: $023024 - Calls func_003 first, then dispatches
 *   B: $02302E - Calls func_002 first, then dispatches
 *
 * Input:
 *   R13 = State/mode register (upper byte contains dispatch index)
 *   R14 = RenderingContext pointer
 *
 * Jump Table Dispatch:
 *   Index extracted from R13 upper byte, masked to 0,2,4,6,8,10
 *   Index 12 causes immediate exit (done state)
 *
 * Calls:
 *   - func_003 via BSR (entry A)
 *   - func_002 via BSR (entry B)
 *   - Case handlers via BSRF jump table
 *   - func_loop_helper_a / func_loop_helper_b via BSR
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23024 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * Entry Point A: Call func_003, then dispatch
 * Entry: 0x02223024
 * ═══════════════════════════════════════════════════════════════════════════ */
func_001_entry_a:
    .short  0x4F22                            /* $023024: STS.L PR,@-R15 */
    .short  0xB0A7                            /* $023026: BSR func_003 */
    .short  0x7D02                            /* $023028: [delay] ADD #2,R13 */
    .short  0xA003                            /* $02302A: BRA .main_dispatch */
    .short  0x0009                            /* $02302C: [delay] NOP */

/* ═══════════════════════════════════════════════════════════════════════════
 * Entry Point B: Call func_002, then dispatch
 * Entry: 0x0222302E
 * ═══════════════════════════════════════════════════════════════════════════ */
func_001_entry_b:
    .short  0x4F22                            /* $02302E: STS.L PR,@-R15 */
    .short  0xB05A                            /* $023030: BSR func_002 */
    .short  0x7D02                            /* $023032: [delay] ADD #2,R13 */

/* ─────────────────────────────────────────────────────────────────────────
 * Main Dispatch: Load context and switch on state
 * ───────────────────────────────────────────────────────────────────────── */
.main_dispatch:
    .short  0x5AEB                            /* $023034: MOV.L @(44,R14),R10 (output ptr) */
    .short  0x5BE9                            /* $023036: MOV.L @(36,R14),R11 (data ptr) */
    .short  0x69D5                            /* $023038: EXTU.W R13,R9 */
    .short  0x6098                            /* $02303A: SWAP.W R9,R0 (state byte) */
    .short  0xC90E                            /* $02303C: AND #14,R0 (mask to 0-14) */
    .short  0x880C                            /* $02303E: CMP/EQ #12,R0 (done?) */
    .short  0x890F                            /* $023040: BT .exit */

    /* Jump table dispatch */
    .short  0x6103                            /* $023042: MOV R0,R1 */
    .short  0xC708                            /* $023044: MOVA .jump_table,R0 */
    .short  0x011D                            /* $023046: MOV.W @(R0,R1),R1 */
    .short  0x0103                            /* $023048: BSRF R1 */
    .short  0x0009                            /* $02304A: [delay] NOP */

    /* After case handler returns: check loop condition */
    .short  0x6093                            /* $02304C: MOV.W @R9,R0 */
    .short  0xC801                            /* $02304E: TST #1,R0 */
    .short  0x8B03                            /* $023050: BF .path_b */

    /* Path A */
    .short  0xB0C9                            /* $023052: BSR func_loop_helper_a */
    .short  0x85E1                            /* $023054: [delay] MOV.W @(2,R14),R0 */
    .short  0xAFF0                            /* $023056: BRA .main_dispatch */
    .short  0x69D5                            /* $023058: [delay] EXTU.W R13,R9 */

    /* Path B */
.path_b:
    .short  0xB0D4                            /* $02305A: BSR func_loop_helper_b */
    .short  0x85E1                            /* $02305C: [delay] MOV.W @(2,R14),R0 */
    .short  0xAFEC                            /* $02305E: BRA .main_dispatch */
    .short  0x69D5                            /* $023060: [delay] EXTU.W R13,R9 */

/* ─────────────────────────────────────────────────────────────────────────
 * Exit: Save state and return
 * ───────────────────────────────────────────────────────────────────────── */
.exit:
    .short  0x4F26                            /* $023062: LDS.L @R15+,PR */
    .short  0x000B                            /* $023064: RTS */
    .short  0x1EB9                            /* $023066: [delay] MOV.L R11,@(36,R14) */

/* ─────────────────────────────────────────────────────────────────────────
 * Jump Table: Word offsets for BSRF dispatch (from PC @ $02304C)
 * ───────────────────────────────────────────────────────────────────────── */
.jump_table:
    .short  0x0024                            /* $023068: Index 0 → $023070 (case_0) */
    .short  0x003C                            /* $02306A: Index 2 → $023088 (case_2) */
    .short  0x0048                            /* $02306C: Index 4 → $023094 (case_4) */
    .short  0x005A                            /* $02306E: Index 6 → $0230A6 (case_6) */

/* ============================================================================
 * End of func_001 (76 bytes)
 *
 * Analysis:
 * - Dual entry point coordinator for 3D rendering pipeline
 * - Jump table dispatch on state byte from R13 upper word
 * - After each case handler, loops back with path A or B
 * - State 12 = done, triggers exit with context save
 * ============================================================================ */
