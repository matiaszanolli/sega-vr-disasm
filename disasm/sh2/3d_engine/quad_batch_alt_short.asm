/*
 * func_019: Quad Batch Alternate (with alternate entry at $02346A)
 * ROM File Offset: 0x23414 - 0x2349F (140 bytes)
 * SH2 Address: 0x02223414 - 0x0222349F
 *
 * Purpose: Quad batch processor with two entry points:
 *          - Main entry ($023414): Uses mask from literal pool
 *          - Alternate entry ($02346A): Uses zero mask
 *          Processes 4 vertices per quad via conditional BSR to func_020.
 *
 * Type: Non-leaf function (calls func_020 at $0234A0)
 * Called By: func_018, display list processor
 *
 * Entry Points:
 *   $023414 - Main entry (masked processing)
 *   $02346A - Alternate entry (zero mask)
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23414 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_019: Main Entry - Masked Quad Batch
 * Entry: 0x02223414
 * ═══════════════════════════════════════════════════════════════════════════ */
func_019:
    /* Load mask from literal pool and apply */
    .short  0xD10D                              /* $023414: MOV.L @(52,PC),R1 → mask literal */
    .short  0x2109                              /* $023416: AND R0,R1 */
    .short  0x2A12                              /* $023418: MOV.L R1,@R10 */
    .short  0x7AFC                              /* $02341A: ADD #-4,R10 */
    .short  0x4001                              /* $02341C: SHLR R0 */
    .short  0x1E02                              /* $02341E: MOV.L R0,@(8,R14) */

    /* Save registers for loop */
    .short  0x2F66                              /* $023420: MOV.L R6,@-R15 */
    .short  0x2F76                              /* $023422: MOV.L R7,@-R15 */
    .short  0x2FA6                              /* $023424: MOV.L R10,@-R15 */

.loop_main:
    /* Process vertex 0 - conditional call */
    .short  0x84EA                              /* $023426: MOV.B @(10,R14),R0 */
    .short  0x8800                              /* $023428: CMP/EQ #0,R0 */
    .short  0x8901                              /* $02342A: BT .skip_v0 */
    .short  0xB038                              /* $02342C: BSR func_020 ($0234A0) */
    .short  0x4F22                              /* $02342E: [delay] STS.L PR,@-R15 */

.skip_v0:
    /* Process vertex 1 */
    .short  0x7BE0                              /* $023430: ADD #-32,R11 */
    .short  0x84E8                              /* $023432: MOV.B @(8,R14),R0 */
    .short  0x8800                              /* $023434: CMP/EQ #0,R0 */
    .short  0x8901                              /* $023436: BT .skip_v1 */
    .short  0xB032                              /* $023438: BSR func_020 ($0234A0) */
    .short  0x4F22                              /* $02343A: [delay] STS.L PR,@-R15 */

.skip_v1:
    /* Restore registers and loop */
    .short  0x6AF6                              /* $02343C: MOV.L @R15+,R10 */
    .short  0x67F6                              /* $02343E: MOV.L @R15+,R7 */
    .short  0x66F6                              /* $023440: MOV.L @R15+,R6 */
    .short  0x4710                              /* $023442: DT R7 (decrement and test) */
    .short  0x8FD8                              /* $023444: BF/S .loop_main (-80) */
    .short  0x7BE0                              /* $023446: [delay] ADD #-32,R11 */

    /* Exit to func_018's epilogue */
    .short  0xAFDE                              /* $023448: BRA $023408 (in func_018) */
    .short  0x0009                              /* $02344A: [delay] NOP */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool
 * ───────────────────────────────────────────────────────────────────────────── */
.lit_mask:
    .short  0x00FF                              /* $02344C: Mask literal (0x00FF00FF) */
    .short  0x00FF                              /* $02344E: */

/* ─────────────────────────────────────────────────────────────────────────────
 * Helper Function: Process vertex with flag check
 * Entry: $023450
 * ───────────────────────────────────────────────────────────────────────────── */
.helper_process:
    .short  0x4F22                              /* $023450: STS.L PR,@-R15 */
    .short  0xBF89                              /* $023452: BSR $023368 (utility func) */
    .short  0x0009                              /* $023454: [delay] NOP */
    .short  0x60A2                              /* $023456: MOV.L @R10,R0 */
    .short  0x8800                              /* $023458: CMP/EQ #0,R0 */
    .short  0x8B06                              /* $02345A: BF .helper_loop */

    /* Quick exit path */
    .short  0x7AFC                              /* $02345C: ADD #-4,R10 */
    .short  0x4710                              /* $02345E: DT R7 */
    .short  0x8FF9                              /* $023460: BF/S .helper_process (-14) */
    .short  0x7BC0                              /* $023462: [delay] ADD #-64,R11 */

.helper_return:
    .short  0x4F26                              /* $023464: LDS.L @R15+,PR */
    .short  0x000B                              /* $023466: RTS */
    .short  0x0009                              /* $023468: [delay] NOP */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_019_alt: Alternate Entry - Zero Mask
 * Entry: 0x0222346A
 * ═══════════════════════════════════════════════════════════════════════════ */
func_019_alt:
    /* Use zero instead of literal mask */
    .short  0xE100                              /* $02346A: MOV #0,R1 */
    .short  0x2A12                              /* $02346C: MOV.L R1,@R10 */
    .short  0x7AFC                              /* $02346E: ADD #-4,R10 */
    .short  0x4001                              /* $023470: SHLR R0 */
    .short  0x1E02                              /* $023472: MOV.L R0,@(8,R14) */

    /* Save registers for loop */
    .short  0x2F66                              /* $023474: MOV.L R6,@-R15 */
    .short  0x2F76                              /* $023476: MOV.L R7,@-R15 */
    .short  0x2FA6                              /* $023478: MOV.L R10,@-R15 */

.loop_alt:
    /* Process vertex 0 - conditional call */
    .short  0x84EB                              /* $02347A: MOV.B @(11,R14),R0 */
    .short  0x8800                              /* $02347C: CMP/EQ #0,R0 */
    .short  0x8901                              /* $02347E: BT .skip_alt_v0 */
    .short  0xB00E                              /* $023480: BSR func_020 ($0234A0) */
    .short  0x4F22                              /* $023482: [delay] STS.L PR,@-R15 */

.skip_alt_v0:
    /* Process vertex 1 */
    .short  0x7BE0                              /* $023484: ADD #-32,R11 */
    .short  0x84E9                              /* $023486: MOV.B @(9,R14),R0 */
    .short  0x8800                              /* $023488: CMP/EQ #0,R0 */
    .short  0x8901                              /* $02348A: BT .skip_alt_v1 */
    .short  0xB008                              /* $02348C: BSR func_020 ($0234A0) */
    .short  0x4F22                              /* $02348E: [delay] STS.L PR,@-R15 */

.skip_alt_v1:
    /* Restore registers and loop */
    .short  0x6AF6                              /* $023490: MOV.L @R15+,R10 */
    .short  0x67F6                              /* $023492: MOV.L @R15+,R7 */
    .short  0x66F6                              /* $023494: MOV.L @R15+,R6 */
    .short  0x4710                              /* $023496: DT R7 (decrement and test) */
    .short  0x8FDD                              /* $023498: BF/S .loop_alt (-70) */
    .short  0x7BE0                              /* $02349A: [delay] ADD #-32,R11 */

    /* Exit via shared return */
    .short  0xAFE2                              /* $02349C: BRA .helper_return ($023464) */
    .short  0x0009                              /* $02349E: [delay] NOP */

/* ============================================================================
 * End of func_019 + alternate entry (140 bytes)
 *
 * Analysis:
 * - Two entry points for masked vs zero-mask processing
 * - Both variants process quads in a loop, calling func_020 conditionally
 * - Main entry BRAs to func_018's epilogue for return
 * - Alternate entry BRAs to helper_return for return
 * - Registers: R6/R7 = loop control, R10/R11 = data pointers, R14 = context
 * ============================================================================ */
