/*
 * func_025: Coordinate Offset Calculator
 * ROM File Offset: 0x23634 - 0x23643 (16 bytes)
 * SH2 Address: 0x02223634 - 0x02223643
 *
 * Purpose: Read two words from R8, apply offset math, store results
 *
 * Input:
 *   R1  = Base offset
 *   R2  = Subtrahend
 *   R8  = Source data pointer
 *
 * Output:
 *   @(6,R1) = R0 + R1
 *   @(7,R1) = -(R4 - R2) = R2 - R4
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23634 start */

func_025:
    .short  0x6085                            /* $023634: MOV.B @R8+,R0 */
    .short  0x6485                            /* $023636: MOV.B @R8+,R4 */
    .short  0x301C                            /* $023638: ADD R1,R0 */
    .short  0x8196                            /* $02363A: MOV.B R0,@(6,R1) */
    .short  0x3428                            /* $02363C: SUB R2,R4 */
    .short  0x604B                            /* $02363E: NEG R4,R0 */
    .short  0x000B                            /* $023640: RTS */
    .short  0x8197                            /* $023642: [delay] MOV.B R0,@(7,R1) */

/* ============================================================================
 * End of func_025 (16 bytes)
 *
 * Analysis:
 * - Reads two bytes from source pointer (R8 auto-increments)
 * - First byte: adds base offset (R1) and stores at @(6,R1)
 * - Second byte: subtracts R2, negates, stores at @(7,R1)
 * - Used for coordinate offset calculations in rasterizer
 * ============================================================================ */
