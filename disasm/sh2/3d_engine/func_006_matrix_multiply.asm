/*
 * func_006: Matrix × Vector Multiplication (MAC.L)
 * ROM Address: 0x223114 - 0x223174 (98 bytes)
 * SH2 Address: 0x02223114
 *
 * Purpose: Transform 3D vector using 4×4 matrix (3×3 rotation + translation)
 *          Uses SH2 MAC (Multiply-Accumulate) for efficient fixed-point math
 *
 * Formula: V_out = M × V_in + T
 *
 * Fixed-Point Format: 16.16 (16 integer bits, 16 fractional bits)
 *
 * Input:
 *   R4 = Pointer to 4×4 matrix (row-major, 4 longs per row)
 *   R5 = Pointer to input vector (3 longs: X, Y, Z)
 *   R6 = Pointer to output buffer
 *   R7 = Additional parameter
 *   R9 = Y coordinate (from caller)
 *   R12 = X coordinate (from caller)
 *
 * Output:
 *   @(0,R6)  = X'
 *   @(4,R6)  = Y'
 *   @(8,R6)  = Z'
 *   @(16,R6) = R7 parameter
 *   @(20,R6) = MACH value
 *
 * Clobbers: R0, R1, R2, R3, R4, R5, R7, R8, MACH, MACL
 *
 * Performance: ~30-40 cycles (9 MAC.L operations)
 */

.section .text
.align 2

func_006:
    /* Transform X: X' = M[0][0]*X + M[0][1]*Y + M[0][2]*Z + T[0] */
    mac.l   @r4+,@r5+               /* MAC += M[0][0] * V[0] */
    mac.l   @r4+,@r5+               /* MAC += M[0][1] * V[1] */
    mac.l   @r4+,@r5+               /* MAC += M[0][2] * V[2] */
    add     #-12,r5                 /* Reset R5 to vector start */
    mov.l   @r4+,r8                 /* R8 = T[0] (translation X) */
    add     #-48,r4                 /* Adjust matrix pointer */
    sts     mach,r0                 /* R0 = MAC[63:32] */
    sts     macl,r3                 /* R3 = MAC[31:0] */
    xtrct   r0,r3                   /* R3 = MAC[47:16] (16.16 result) */
    add     r8,r3                   /* R3 += T[0] */
    mov.l   r3,@r6                  /* Store X' at output[0] */
    mov.l   r7,@(16,r6)             /* Store param at output[16] */
    mov.l   r0,@(20,r6)             /* Store MACH at output[20] */
    clrmac                          /* Clear MAC for next operation */

    /* Transform Y: Y' = M[1][0]*X + M[1][1]*Y + M[1][2]*Z + T[1] */
    mac.l   @r4+,@r5+               /* MAC += M[1][0] * V[0] */
    mac.l   @r4+,@r5+               /* MAC += M[1][1] * V[1] */
    mac.l   @r4+,@r5+               /* MAC += M[1][2] * V[2] */
    add     #-12,r5                 /* Reset R5 to vector start */
    mov.l   @r4+,r8                 /* R8 = T[1] (translation Y) */
    sts     mach,r0                 /* Extract MAC result */
    sts     macl,r1
    xtrct   r0,r1                   /* R1 = Y' (before translation) */
    add     r8,r1                   /* R1 += T[1] */

    /* Transform Z: Z' = M[2][0]*X + M[2][1]*Y + M[2][2]*Z + T[2] */
    clrmac
    mac.l   @r4+,@r5+               /* MAC += M[2][0] * V[0] */
    mac.l   @r4+,@r5+               /* MAC += M[2][1] * V[1] */
    mac.l   @r4+,@r5+               /* MAC += M[2][2] * V[2] */
    add     #-12,r5                 /* Reset R5 */
    mov.l   @r4+,r8                 /* R8 = T[2] (translation Z) */
    sts     mach,r0
    sts     macl,r2
    xtrct   r0,r2                   /* R2 = Z' (before translation) */
    add     r8,r2                   /* R2 += T[2] */

    /* Additional post-processing (perspective/screen mapping) */
    mov.l   @(28,r6),r3             /* Load from output[28] */
    .word   0x313D                  /* Unknown MAC operation */
    sts     mach,r0
    add     r9,r0                   /* Add R9 (Y coordinate) */
    mov.b   r0,@(6,r1)              /* Store byte to offset +6 */
    .word   0x323D                  /* Unknown MAC operation */
    sts     mach,r0
    add     r12,r0                  /* Add R12 (X coordinate) */
    rts
    mov.b   r0,@(7,r1)              /* Store byte to offset +7 (delay slot) */

/*
 * End of func_006
 */
