/*
 * func_033: Quad Rendering / Edge Walking
 * ROM File Offset: 0x236FA - 0x2375B (98 bytes)
 * SH2 Address: 0x022236FA - 0x0222375B
 *
 * Purpose: Renders a quad by walking its edges and generating
 *          scanline data. Handles edge setup and calls func_034
 *          for the actual span filling.
 *
 * Type: Coordinator function
 * Called By: func_023 (frustum cull dispatcher)
 * Calls: func_034 @ $02375C (span filler)
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x236FA start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_033: Quad Rendering / Edge Walking
 * Entry: 0x022236FA
 * Size: 98 bytes
 * ═══════════════════════════════════════════════════════════════════════════ */
func_033:
    .short  0xD80B                            /* $0236FA: MOV.L @(PC+0x2C),R8 → edge buffer */
    .short  0x60A3                            /* $0236FC: MOV R10,R0 */
    .short  0x53E5                            /* $0236FE: MOV.L @(20,R14),R3 */
    .short  0x018E                            /* $023700: MAC.W @R8+,@R9+ */
    .short  0x641F                            /* $023702: EXTS.B R1,R4 */
    .short  0x3433                            /* $023704: CMP/GE R3,R4 */
    .short  0x8911                            /* $023706: BT right_edge_first (+0x22) */
    .short  0x6213                            /* $023708: MOV R1,R2 */
    .short  0x30CC                            /* $02370A: ADD R12,R0 */
    .short  0xC90C                            /* $02370C: AND #12,R0 */
    .short  0x018E                            /* $02370E: MAC.W @R8+,@R9+ */
    .short  0x641F                            /* $023710: EXTS.B R1,R4 */
    .short  0x3433                            /* $023712: CMP/GE R3,R4 */
    .short  0x8BF8                            /* $023714: BF edge_loop_back (-0x10) */
    .short  0x4F22                            /* $023716: STS.L PR,@-R15 */
    .short  0xB021                            /* $023718: BSR func_034_call_1 */
    .short  0x0009                            /* $02371A: [delay] NOP */
    .short  0x4F26                            /* $02371C: LDS.L @R15+,PR */
    .short  0x2932                            /* $02371E: MOV.L R3,@R9 */
    .short  0x7904                            /* $023720: ADD #4,R9 */
    .short  0xA008                            /* $023722: BRA continue (+0x10) */
    .short  0x53E6                            /* $023724: [delay] MOV.L @(24,R14),R3 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool (aligned to 4 bytes)
 * ───────────────────────────────────────────────────────────────────────────── */
    .short  0x0000                            /* $023726: padding for alignment */
.lit_edge_buf:
    .byte   0xC0, 0x00, 0x07, 0x40            /* $023728: 0xC0000740 - Edge buffer (cache-through) */

/* ─────────────────────────────────────────────────────────────────────────────
 * Right edge first path
 * ───────────────────────────────────────────────────────────────────────────── */
right_edge_first:
    .short  0x2912                            /* $02372C: MOV.L R1,@R9 */
    .short  0x7904                            /* $02372E: ADD #4,R9 */
    .short  0x53E6                            /* $023730: MOV.L @(24,R14),R3 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Continue: Edge walking loop
 * ───────────────────────────────────────────────────────────────────────────── */
continue:
edge_walking_loop:
    .short  0x30CC                            /* $023732: ADD R12,R0 */
    .short  0xC90C                            /* $023734: AND #12,R0 */
    .short  0x6213                            /* $023736: MOV R1,R2 */
    .short  0x018E                            /* $023738: MAC.W @R8+,@R9+ */
    .short  0x641F                            /* $02373A: EXTS.B R1,R4 */
    .short  0x3437                            /* $02373C: CMP/GT R3,R4 */
    .short  0x8905                            /* $02373E: BT edge_done (+0x0A) */
    .short  0x2912                            /* $023740: MOV.L R1,@R9 */
    .short  0x7904                            /* $023742: ADD #4,R9 */
    .short  0x30B0                            /* $023744: CMP/EQ R11,R0 */
    .short  0x8907                            /* $023746: BT full_exit (+0x0E) */
    .short  0xAFF4                            /* $023748: BRA edge_walking_loop (-0x18) */
    .short  0x30CC                            /* $02374A: [delay] ADD R12,R0 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Edge done: Call func_034 for span fill
 * ───────────────────────────────────────────────────────────────────────────── */
edge_done:
    .short  0x4F22                            /* $02374C: STS.L PR,@-R15 */
    .short  0xB006                            /* $02374E: BSR func_034_call_2 → $02375E */
    .short  0x0009                            /* $023750: [delay] NOP */
    .short  0x4F26                            /* $023752: LDS.L @R15+,PR */
    .short  0x2932                            /* $023754: MOV.L R3,@R9 */
    .short  0x7904                            /* $023756: ADD #4,R9 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Exit path
 * ───────────────────────────────────────────────────────────────────────────── */
full_exit:
    .short  0xE0FF                            /* $023758: MOV #-1,R0 (return value = -1) */
    .short  0x000B                            /* $02375A: RTS */
    /* Note: Delay slot at $02375C (MOV.L R0,@R9) is first word of func_034 */

/* ============================================================================
 * End of func_033 (98 bytes)
 *
 * Analysis:
 * - Edge walking algorithm for quad polygon rasterization
 * - MAC.W used for fast edge interpolation
 * - EXTS.B for sign-extension of edge deltas
 * - Two BSR calls to func_034 for span filling
 * - Returns -1 (0xFF) in R0
 * - Shares delay slot with func_034's first instruction
 *
 * Literal value: 0xC0000740 (cache-through mirror of 0x06000740)
 * ============================================================================ */
