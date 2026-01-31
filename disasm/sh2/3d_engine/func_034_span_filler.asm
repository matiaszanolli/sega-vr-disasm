/*
 * func_034: Span Filler / Edge Interpolation
 * ROM File Offset: 0x2375C - 0x237D0 (~116 bytes)
 * SH2 Address: 0x0222375C
 *
 * Called By: func_033 (render_quad)
 *
 * Purpose: Calculate interpolated edge values for scanline rendering.
 *          Sets up span data for horizontal line drawing in the rasterizer.
 *
 * Input:
 *   R0  = Edge value A (written to output)
 *   R1  = Y1:X1 packed (high word: Y, low word: X)
 *   R2  = Y2:X2 packed
 *   R3  = Edge value B
 *   R9  = Output pointer
 *
 * Output:
 *   Writes interpolated span data to @R9 and R13 output area
 *
 * Algorithm:
 *   1. Ensure Y1 <= Y2 (swap if needed)
 *   2. Extract X and Y components
 *   3. Calculate delta-X and delta-Y
 *   4. Look up reciprocal from table for division
 *   5. Interpolate edge values using MULS.W
 *   6. Store results for span rendering
 */

.section .text
.align 2

func_034:
    /* Store first edge value */
    mov.l   r0,@r9                  /* *R9 = R0 (edge value A) */

    /* Extract and compare Y values to ensure Y1 <= Y2 */
    exts.w  r1,r4                   /* R4 = sign-extend low word of R1 (X1) */
    exts.w  r2,r5                   /* R5 = sign-extend low word of R2 (X2) */
    cmp/ge  r4,r5                   /* Compare: X1 >= X2? (actually Y order) */
    bt      .no_swap                /* If already ordered, skip swap */
    mov     r1,r4                   /* Swap R1 and R2 */
    mov     r2,r1
    mov     r4,r2

.no_swap:
    /* Extract high words (Y coordinates) */
    swap.w  r1,r4                   /* R4 = swap words of R1 */
    exts.w  r4,r4                   /* R4 = Y1 (sign extended) */
    swap.w  r2,r5                   /* R5 = swap words of R2 */
    exts.w  r5,r5                   /* R5 = Y2 (sign extended) */

    /* Calculate delta-Y (R4 = Y1 - Y2) */
    sub     r5,r4                   /* R4 = Y1 - Y2 = -deltaY */

    /* Load reciprocal table limit */
    mov.w   @(.recip_limit,pc),r7   /* R7 = 0x237B (max table index?) */

    /* Calculate delta-X */
    exts.w  r1,r5                   /* R5 = X1 */
    exts.w  r2,r6                   /* R6 = X2 */
    sub     r6,r5                   /* R5 = X1 - X2 = deltaX */

    /* Check if delta exceeds table limit */
    cmp/gt  r5,r7                   /* R7 > deltaX? */
    bt      .small_delta            /* Use alternative path for small deltas */

    /* Large delta path: use reciprocal table lookup */
    mov.l   @(.recip_table,pc),r7   /* R7 = 0x060048D0 (reciprocal table in SDRAM) */
    shll    r5                      /* R5 = deltaX * 2 (word offset) */
    add     r5,r7                   /* R7 = table + offset */
    mov.w   @r7,r7                  /* R7 = reciprocal[deltaX] */
    muls.w  r4,r7                   /* MACL = deltaY * reciprocal */

    exts.w  r1,r5                   /* R5 = X1 */
    exts.w  r3,r7                   /* R7 = edge value B (sign ext) */
    sts     macl,r4                 /* R4 = interpolation result */
    sub     r5,r7                   /* R7 = edgeB - X1 */
    shll16  r7                      /* R7 = (edgeB - X1) << 16 */
    shll2   r4                      /* R4 <<= 2 (scale result) */
    add     r4,r7                   /* R7 = scaled position (DW $374D = ADD R4,R7) */

    extu.w  r3,r3                   /* R3 = zero-extend edge B */
    swap.w  r1,r4                   /* R4 = Y1 */
    sts     mach,r7                 /* R7 = high part of multiply */
    exts.w  r4,r4                   /* R4 = Y1 (sign ext) */
    add     r4,r7                   /* R7 += Y1 */
    shll16  r7                      /* R7 <<= 16 */
    rts
    nop

.align 2
.recip_limit:
    .word   0x237B                  /* Max delta for table lookup */
    .word   0xFF01                  /* Padding/constant */
.recip_table:
    .long   0x060048D0              /* Reciprocal table address in SDRAM */

.small_delta:
    /* Alternative path for small deltas (direct calculation) */
    exts.w  r1,r5                   /* R5 = X1 */
    exts.w  r3,r7                   /* R7 = edge B */
    sub     r5,r7                   /* R7 = edgeB - X1 */
    muls.w  r7,r4                   /* MACL = (edgeB - X1) * deltaY */

    mov.w   @(.output_ptr,pc),r13   /* R13 = output pointer */
    exts.w  r2,r6                   /* R6 = X2 */
    sub     r6,r5                   /* R5 = deltaX */
    sts     macl,r7                 /* R7 = multiply result */
    mov.l   r5,@(0,r13)             /* Store deltaX */
    mov.l   r7,@(4,r13)             /* Store interpolated value */

    extu.w  r3,r3                   /* R3 = edge B (zero ext) */
    swap.w  r1,r4                   /* R4 = Y1 */
    /* Function continues with more interpolation... */

    /* Note: Partial translation - full function extends further */

.align 2
.output_ptr:
    .word   0x????                  /* TODO: Extract from ROM */

/*
 * Analysis Notes:
 *
 * This is a Bresenham-style edge interpolation function used by the
 * polygon rasterizer. It calculates X coordinates along an edge
 * as Y advances, using fixed-point arithmetic.
 *
 * Key operations:
 * - Reciprocal table lookup for fast division (0x060048D0)
 * - MULS.W for 16-bit signed multiplication
 * - SHLL16/SHLL2 for fixed-point scaling
 *
 * The reciprocal table allows division by delta-X to be replaced
 * with multiplication, which is faster on SH2.
 *
 * End of func_034 (partial)
 */
