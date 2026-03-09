/*
 * func_008: Alternative Matrix × Vector Multiplication (MAC.L)
 * ROM File Offset: 0x231AC - 0x231E3 (56 bytes, excludes delay slot)
 * SH2 Address: 0x022231AC
 *
 * Purpose: Transform 3D vector using matrix multiplication
 *          Similar to func_006 but with different output handling
 *          Called by func_007 (alternative transform loop)
 *
 * NOTE: Delay slot (0x81A7) is provided by func_009's first instruction.
 *       This enables seamless include chaining in the ROM build.
 *
 * Input:
 *   R4 = Pointer to matrix
 *   R5 = Pointer to input vector (3 longs: X, Y, Z)
 *   R9 = Y coordinate offset
 *   R12 = X coordinate offset
 *
 * Output:
 *   Results in R1, R2 (transformed coordinates)
 *   Screen coordinates written via MOV.W
 *
 * Clobbers: R0, R1, R2, R4, R5, R8, MACH, MACL
 */

.section .text
.align 2

func_008:
    /* ─────────────────────────────────────────────────────────────────────
     * Transform Y: Y' = M[0][0]*X + M[0][1]*Y + M[0][2]*Z + T[0]
     * ───────────────────────────────────────────────────────────────────── */
    mac.l   @r4+,@r5+               /* MAC += M[0][0] * V[0] */
    mac.l   @r4+,@r5+               /* MAC += M[0][1] * V[1] */
    mac.l   @r4+,@r5+               /* MAC += M[0][2] * V[2] */
    add     #-12,r5                 /* Reset R5 to vector start */
    mov.l   @r4+,r8                 /* R8 = T[0] (translation) */
    sts     mach,r0                 /* R0 = MAC[63:32] */
    sts     macl,r1                 /* R1 = MAC[31:0] */
    xtrct   r0,r1                   /* R1 = MAC[47:16] (16.16 result) */
    add     r8,r1                   /* R1 += T[0] */
    clrmac                          /* Clear MAC for next operation */

    /* ─────────────────────────────────────────────────────────────────────
     * Transform Z: Z' = M[1][0]*X + M[1][1]*Y + M[1][2]*Z + T[1]
     * ───────────────────────────────────────────────────────────────────── */
    mac.l   @r4+,@r5+               /* MAC += M[1][0] * V[0] */
    mac.l   @r4+,@r5+               /* MAC += M[1][1] * V[1] */
    mac.l   @r4+,@r5+               /* MAC += M[1][2] * V[2] */
    add     #-12,r5                 /* Reset R5 to vector start */
    mov.l   @r4+,r8                 /* R8 = T[1] (translation) */
    add     #-32,r4                 /* Reset matrix pointer */
    sts     mach,r0                 /* R0 = MAC[63:32] */
    sts     macl,r2                 /* R2 = MAC[31:0] */
    xtrct   r0,r2                   /* R2 = MAC[47:16] (16.16 result) */
    add     r8,r2                   /* R2 += T[1] */

    /* ─────────────────────────────────────────────────────────────────────
     * Post-processing: Screen coordinate mapping
     * ───────────────────────────────────────────────────────────────────── */
    .word   0x313D                  /* DMULS.L R3,R1 (Y × scale) */
    sts     mach,r0                 /* R0 = high 32 bits of result */
    add     r9,r0                   /* Add Y offset from caller */
    .word   0x81a6                  /* MOV.W R0,@(12,R10) - store Y screen coord */
    .word   0x323D                  /* DMULS.L R3,R2 (Z × scale) */
    sts     mach,r0                 /* R0 = high 32 bits of result */
    add     r12,r0                  /* Add X offset from caller */
    rts
    /* Delay slot provided by func_009's first instruction (0x81A7) */

/*
 * End of func_008
 */
