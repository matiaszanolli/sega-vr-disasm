/*
 * func_069: Block Copy with Stride
 * ROM File Offset: 0x2400E - 0x24059 (76 bytes)
 * SH2 Address: 0x0222400E - 0x02224059
 *
 * Purpose: Block copy routine with bounds checking and stride.
 *          Uses nested loops to copy data blocks with 8-byte pairs.
 *
 * Type: Leaf function (no subroutine calls)
 * Called By: Unknown
 *
 * Operation:
 *   1. Load R8/R9 from context, mask R9 for alignment
 *   2. Bounds check against constants from literal pool
 *   3. Nested loop: outer counts blocks (R7), inner copies pairs (R2)
 *   4. Each iteration copies 8 bytes, advances dest by stride (R13)
 *
 * Literal pool at $02405A:
 *   $02405A: $01FF (mask)
 *   $02405C: $0140 (threshold)
 *   $02405E: $FFFF (sentinel)
 */

.section .text
.p2align 1    /* 2-byte alignment for $02400E start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_069: Block Copy with Stride
 * Entry: 0x0222400E
 * ═══════════════════════════════════════════════════════════════════════════ */
func_069:
    .short  0x58E2        /* $02400E: MOV.L @(8,R14),R8 */
    .short  0x59E1        /* $024010: MOV.L @(4,R14),R9 */
    .short  0xE0FC        /* $024012: MOV #-4,R0 */
    .short  0x2909        /* $024014: AND R0,R9 (align to 4 bytes) */
    .short  0x6093        /* $024016: MOV R9,R0 */
    .short  0x911F        /* $024018: MOV.W @(62,PC),R1 → $01FF at $02405A */
    .short  0x2019        /* $02401A: AND R1,R0 (mask low bits) */
    .short  0x911E        /* $02401C: MOV.W @(60,PC),R1 → $0140 at $02405C */
    .short  0x3013        /* $02401E: CMP/GE R1,R0 */
    .short  0x8919        /* $024020: BT $024056 (skip if >= threshold) */
    .short  0x4009        /* $024022: SHLR2 R0 */
    .short  0x4001        /* $024024: SHLR R0 */
    .short  0x6685        /* $024026: MOV.W @R8+,R6 */
    .short  0xE500        /* $024028: MOV #0,R5 */
    .short  0x306C        /* $02402A: ADD R6,R0 */
    .short  0x70D8        /* $02402C: ADD #-40,R0 */
    .short  0x4015        /* $02402E: CMP/PL R0 */
    .short  0x8B03        /* $024030: BF $02403A */
    .short  0x3608        /* $024032: SUB R0,R6 */
    .short  0x6503        /* $024034: MOV R0,R5 */
    .short  0x4508        /* $024036: SHLL2 R5 */
    .short  0x4500        /* $024038: SHLL R5 */
.loop_outer:
    .short  0x6785        /* $02403A: MOV.W @R8+,R7 */
    .short  0x6193        /* $02403C: MOV R9,R1 */
    .short  0x6263        /* $02403E: MOV R6,R2 */
.loop_inner:
    .short  0x6086        /* $024040: MOV.L @R8+,R0 */
    .short  0x1100        /* $024042: MOV.L R0,@(0,R1) */
    .short  0x6086        /* $024044: MOV.L @R8+,R0 */
    .short  0x1101        /* $024046: MOV.L R0,@(4,R1) */
    .short  0x4210        /* $024048: DT R2 */
    .short  0x8FF9        /* $02404A: BF/S .loop_inner */
    .short  0x7108        /* $02404C: [delay] ADD #8,R1 */
    .short  0x385C        /* $02404E: ADD R5,R8 (skip adjustment) */
    .short  0x4710        /* $024050: DT R7 */
    .short  0x8FF3        /* $024052: BF/S .loop_outer */
    .short  0x39DC        /* $024054: [delay] ADD R13,R9 (stride) */
.exit:
    .short  0x000B        /* $024056: RTS */
    .short  0x0009        /* $024058: [delay] NOP */

/* ============================================================================
 * End of func_069 (76 bytes = 38 instructions)
 *
 * Literal pool follows at $02405A:
 *   $02405A: $01FF - mask for bounds check
 *   $02405C: $0140 - threshold value (320)
 *   $02405E: $FFFF - sentinel
 * ============================================================================ */
