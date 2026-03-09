/*
 * func_046: Array Copy with Stride
 * ROM File Offset: 0x23CF8 - 0x23D1B (36 bytes)
 * SH2 Address: 0x02223CF8 - 0x02223D1B
 *
 * Purpose: Copies arrays of longword pairs with stride-based destination advance.
 *          Nested loop: outer loop advances destination by R13 (stride),
 *          inner loop copies 8 bytes (2 longwords) per iteration.
 *
 * Type: Leaf function (no subroutine calls)
 * Called By: func_045 dispatch (type 0, type 1)
 *
 * Entry conditions:
 *   R13: Destination stride (set by caller, typically $0200)
 *   R14: Parameter block pointer
 *     @(4,R14): Destination base address
 *     @(8,R14): Source pointer (starts with count words)
 *
 * Source data format:
 *   word[0]: Inner loop count (elements per row)
 *   word[1]: Outer loop count (number of rows)
 *   long[...]: Data pairs (8 bytes each)
 *
 * Operation:
 *   for (outer = 0; outer < R7; outer++) {
 *     dst = R9;
 *     for (inner = 0; inner < R6; inner++) {
 *       dst[0] = *src++;  // longword
 *       dst[4] = *src++;  // longword
 *       dst += 8;
 *     }
 *     R9 += R13;  // advance by stride
 *   }
 */

.section .text
.p2align 1    /* 2-byte alignment for $023CF8 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_046: Array Copy with Stride
 * Entry: 0x02223CF8
 * ═══════════════════════════════════════════════════════════════════════════ */
func_046:
    .short  0x58E2        /* $023CF8: MOV.L @(8,R14),R8 (source ptr) */
    .short  0x59E1        /* $023CFA: MOV.L @(4,R14),R9 (dest ptr) */
    .short  0x6685        /* $023CFC: MOV.W @R8+,R6 (inner count) */
    .short  0x6785        /* $023CFE: MOV.W @R8+,R7 (outer count) */
.outer_loop:
    .short  0x6193        /* $023D00: MOV R9,R1 (copy dest to work reg) */
    .short  0x6263        /* $023D02: MOV R6,R2 (copy inner count) */
.inner_loop:
    .short  0x6086        /* $023D04: MOV.L @R8+,R0 (read first longword) */
    .short  0x1100        /* $023D06: MOV.L R0,@(0,R1) (store at offset 0) */
    .short  0x6086        /* $023D08: MOV.L @R8+,R0 (read second longword) */
    .short  0x1101        /* $023D0A: MOV.L R0,@(4,R1) (store at offset 4) */
    .short  0x4210        /* $023D0C: DT R2 (decrement inner counter) */
    .short  0x8FF9        /* $023D0E: BF/S .inner_loop (-14) */
    .short  0x7108        /* $023D10: [delay] ADD #8,R1 (advance dest by 8) */
    .short  0x4710        /* $023D12: DT R7 (decrement outer counter) */
    .short  0x8FF4        /* $023D14: BF/S .outer_loop (-24) */
    .short  0x39DC        /* $023D16: [delay] ADD R13,R9 (advance by stride) */
    .short  0x000B        /* $023D18: RTS */
    .short  0x0009        /* $023D1A: [delay] NOP */

/* ============================================================================
 * End of func_046 (36 bytes)
 *
 * Note: Literal pool for func_045 follows at $023D1C-$023D23:
 *   $023D1C: $0200 (stride constant)
 *   $023D20: $06003CDC (jump table base address)
 * These are NOT part of func_046 but are used by func_045.
 * ============================================================================ */
