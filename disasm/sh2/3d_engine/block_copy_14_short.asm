/*
 * func_074: 14-Block Copy Routine
 * ROM File Offset: 0x241E8 - 0x24205 (30 bytes)
 * SH2 Address: 0x022241E8 - 0x02224205
 *
 * Purpose: Copies 14 blocks of 8 bytes each from table to destination.
 *          Used by func_072 for element data transfer.
 *
 * Type: Leaf function (no subroutine calls)
 * Called By: func_072 via BSR at $0241BE
 *
 * Operation:
 *   1. Load table base from literal at $024208
 *   2. R0 = (R0 << 8) >> 1 = R0 * 128 (index to offset)
 *   3. R10 = table base + offset
 *   4. Loop 14 times: copy 8 bytes, advance dest by R13 (stride)
 *
 * Note: This function crosses the section boundary at $024200.
 *       The literal pool at $024206-$02420B follows the code.
 *
 * Literal pool at $024208:
 *   $024208: $22029D6C (table base address)
 */

.section .text
.p2align 1    /* 2-byte alignment for $0241E8 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_074: 14-Block Copy Routine
 * Entry: 0x022241E8
 * ═══════════════════════════════════════════════════════════════════════════ */
func_074:
    .short  0xDA07        /* $0241E8: MOV.L @(28,PC),R10 → table base at $024208 */
    .short  0x4018        /* $0241EA: SHLL8 R0 */
    .short  0x4001        /* $0241EC: SHLR R0 (R0 *= 128) */
    .short  0x3A0C        /* $0241EE: ADD R0,R10 */
    .short  0x6193        /* $0241F0: MOV R9,R1 (dest = R9) */
    .short  0xE70E        /* $0241F2: MOV #14,R7 (loop count) */
.loop:
    .short  0x62A6        /* $0241F4: MOV.L @R10+,R2 */
    .short  0x1120        /* $0241F6: MOV.L R2,@(0,R1) */
    .short  0x62A6        /* $0241F8: MOV.L @R10+,R2 */
    .short  0x1121        /* $0241FA: MOV.L R2,@(4,R1) */
    .short  0x4710        /* $0241FC: DT R7 */
    .short  0x8FF9        /* $0241FE: BF/S .loop */
    .short  0x31DC        /* $024200: [delay] ADD R13,R1 */
    .short  0x000B        /* $024202: RTS */
    .short  0x0009        /* $024204: [delay] NOP */

/* ============================================================================
 * End of func_074 (30 bytes = 15 instructions)
 *
 * Literal pool follows at $024206:
 *   $024206: $0000 - padding for alignment
 *   $024208: $22029D6C - table base address (longword)
 *
 * Note: Copies 14 × 8 = 112 bytes from table to destination with stride.
 * ============================================================================ */
