/*
 * func_055: Unrolled 8-Block Copy with Stride
 * ROM File Offset: 0x23ED0 - 0x23F2B (92 bytes)
 * SH2 Address: 0x02223ED0 - 0x02223F2B
 *
 * Purpose: Core copy routine called by func_050's BSR calls.
 *          Copies 8 blocks of 8 bytes each with stride advancement.
 *          Fully unrolled for maximum speed.
 *
 * Type: Leaf function (no subroutine calls)
 * Called By: func_050 via BSR (10 times per call)
 *
 * Entry conditions:
 *   R0: Index value (multiplied by 64 to get offset)
 *   R9: Destination base pointer
 *   R10: Source base address
 *   R13: Stride value for destination advancement
 *
 * Operation:
 *   1. Calculate source offset: R0 = R0 * 64 + R10
 *   2. Copy 8 pairs of longwords (64 bytes total)
 *   3. Each pair: copy 8 bytes, advance dest by stride
 */

.section .text
.p2align 1    /* 2-byte alignment for $023ED0 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_055: Unrolled 8-Block Copy with Stride
 * Entry: 0x02223ED0
 * ═══════════════════════════════════════════════════════════════════════════ */
func_055:
    .short  0x4008        /* $023ED0: SHLL2 R0 (R0 *= 4) */
    .short  0x4008        /* $023ED2: SHLL2 R0 (R0 *= 4, total *= 16) */
    .short  0x4008        /* $023ED4: SHLL2 R0 (R0 *= 4, total *= 64) */
    .short  0x30AC        /* $023ED6: ADD R10,R0 (source = base + offset) */
    .short  0x6193        /* $023ED8: MOV R9,R1 (dest = R9) */
    /* Block 0 */
    .short  0x6206        /* $023EDA: MOV.L @R0+,R2 */
    .short  0x1120        /* $023EDC: MOV.L R2,@(0,R1) */
    .short  0x6206        /* $023EDE: MOV.L @R0+,R2 */
    .short  0x1121        /* $023EE0: MOV.L R2,@(4,R1) */
    .short  0x31DC        /* $023EE2: ADD R13,R1 (advance by stride) */
    /* Block 1 */
    .short  0x6206        /* $023EE4: MOV.L @R0+,R2 */
    .short  0x1120        /* $023EE6: MOV.L R2,@(0,R1) */
    .short  0x6206        /* $023EE8: MOV.L @R0+,R2 */
    .short  0x1121        /* $023EEA: MOV.L R2,@(4,R1) */
    .short  0x31DC        /* $023EEC: ADD R13,R1 */
    /* Block 2 */
    .short  0x6206        /* $023EEE: MOV.L @R0+,R2 */
    .short  0x1120        /* $023EF0: MOV.L R2,@(0,R1) */
    .short  0x6206        /* $023EF2: MOV.L @R0+,R2 */
    .short  0x1121        /* $023EF4: MOV.L R2,@(4,R1) */
    .short  0x31DC        /* $023EF6: ADD R13,R1 */
    /* Block 3 */
    .short  0x6206        /* $023EF8: MOV.L @R0+,R2 */
    .short  0x1120        /* $023EFA: MOV.L R2,@(0,R1) */
    .short  0x6206        /* $023EFC: MOV.L @R0+,R2 */
    .short  0x1121        /* $023EFE: MOV.L R2,@(4,R1) */
    .short  0x31DC        /* $023F00: ADD R13,R1 */
    /* Block 4 */
    .short  0x6206        /* $023F02: MOV.L @R0+,R2 */
    .short  0x1120        /* $023F04: MOV.L R2,@(0,R1) */
    .short  0x6206        /* $023F06: MOV.L @R0+,R2 */
    .short  0x1121        /* $023F08: MOV.L R2,@(4,R1) */
    .short  0x31DC        /* $023F0A: ADD R13,R1 */
    /* Block 5 */
    .short  0x6206        /* $023F0C: MOV.L @R0+,R2 */
    .short  0x1120        /* $023F0E: MOV.L R2,@(0,R1) */
    .short  0x6206        /* $023F10: MOV.L @R0+,R2 */
    .short  0x1121        /* $023F12: MOV.L R2,@(4,R1) */
    .short  0x31DC        /* $023F14: ADD R13,R1 */
    /* Block 6 */
    .short  0x6206        /* $023F16: MOV.L @R0+,R2 */
    .short  0x1120        /* $023F18: MOV.L R2,@(0,R1) */
    .short  0x6206        /* $023F1A: MOV.L @R0+,R2 */
    .short  0x1121        /* $023F1C: MOV.L R2,@(4,R1) */
    .short  0x31DC        /* $023F1E: ADD R13,R1 */
    /* Block 7 */
    .short  0x6206        /* $023F20: MOV.L @R0+,R2 */
    .short  0x1120        /* $023F22: MOV.L R2,@(0,R1) */
    .short  0x6206        /* $023F24: MOV.L @R0+,R2 */
    .short  0x1121        /* $023F26: MOV.L R2,@(4,R1) */
    .short  0x31DC        /* $023F28: ADD R13,R1 */
    /* Return */
    .short  0x000B        /* $023F2A: RTS */
    /* Note: Delay slot NOP at $023F2C is part of func_065 (shared boundary) */

/* ============================================================================
 * End of func_055 (92 bytes = 46 instructions)
 *
 * Note: This is a highly optimized unrolled copy loop. Each block copies
 * 8 bytes (2 longwords) and advances the destination by stride (R13).
 * Total: 8 blocks × 8 bytes = 64 bytes copied per call.
 *
 * The delay slot NOP at $023F2C is shared with func_065.
 * ============================================================================ */
