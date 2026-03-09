/*
 * func_065: Unrolled Data Copy Loop
 * ROM File Offset: 0x23F2C - 0x23FC3 (152 bytes)
 * SH2 Address: 0x02223F2C
 *
 * HOTSPOT: Called 4× by func_060, func_061, func_062, func_063
 *
 * Purpose: Fast bulk data copy with stride. Copies 14 blocks of 8 bytes
 *          (2 longwords) from source to destination with custom stride.
 *          Used for texture data or vertex attribute copying.
 *
 * Input:
 *   R0  = Index/offset (multiplied by 128 to get source offset)
 *   R9  = Destination base pointer
 *   R10 = Source base pointer
 *   R13 = Destination stride (bytes between blocks)
 *
 * Output:
 *   Copies 14 × 8 = 112 bytes total
 *   R0 = Final source address
 *   R1 = Final destination address
 *
 * Clobbers: R0, R1, R2
 */

.section .text
.align 2

func_065:
    /* Entry alignment */
    nop

    /* Calculate source address: R0 = R10 + (R0 * 128) */
    shll8   r0                      /* R0 = R0 << 8 (×256) */
    shlr    r0                      /* R0 = R0 >> 1 (÷2) = R0 × 128 */
    add     r10,r0                  /* R0 = source base + offset */
    mov     r9,r1                   /* R1 = destination pointer */

    /* Iteration 1 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 2 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 3 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 4 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 5 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 6 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 7 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 8 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 9 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 10 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 11 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 12 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 13 */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    /* Iteration 14 (final) */
    mov.l   @r0+,r2
    mov.l   r2,@(0,r1)
    mov.l   @r0+,r2
    mov.l   r2,@(4,r1)
    add     r13,r1

    rts
    nop                             /* Delay slot */

/*
 * End of func_065
 */
