/*
 * func_006: Matrix × Vector Multiplication (MAC.L)
 * ROM File Offset: 0x23120 - 0x23178 (88 bytes)
 * SH2 Address: 0x02223120
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
 *   R9 = Y coordinate offset (from caller)
 *   R12 = X coordinate offset (from caller)
 *
 * Output:
 *   @(0,R6)  = X' (transformed X)
 *   @(16,R6) = R7 parameter (passed through)
 *   @(20,R6) = 0 (cleared)
 *   Results in R1, R2 used by caller
 *
 * Clobbers: R0, R1, R2, R3, R4, R5, R8, MACH, MACL
 *
 * Performance: ~45 cycles (9 MAC.L operations + setup)
 */

.section .text
.align 2

func_006:
    /* ─────────────────────────────────────────────────────────────────────
     * Transform X: X' = M[0][0]*X + M[0][1]*Y + M[0][2]*Z + T[0]
     * ───────────────────────────────────────────────────────────────────── */
    mac.l   @r4+,@r5+               /* MAC += M[0][0] * V[0] */
    mac.l   @r4+,@r5+               /* MAC += M[0][1] * V[1] */
    mac.l   @r4+,@r5+               /* MAC += M[0][2] * V[2] */
    add     #-12,r5                 /* Reset R5 to vector start */
    mov.l   @r4+,r8                 /* R8 = T[0] (translation X) */
    add     #-48,r4                 /* Adjust matrix pointer back */
    sts     mach,r0                 /* R0 = MAC[63:32] */
    sts     macl,r3                 /* R3 = MAC[31:0] */
    xtrct   r0,r3                   /* R3 = MAC[47:16] (16.16 result) */
    add     r8,r3                   /* R3 += T[0] */
    mov.l   r3,@(0,r6)              /* Store X' at output[0] */
    mov.l   r7,@(16,r6)             /* Store param at output[16] */
    mov     #0,r0                   /* Clear R0 */
    mov.l   r0,@(20,r6)             /* Store 0 at output[20] */
    clrmac                          /* Clear MAC for next operation */

    /* ─────────────────────────────────────────────────────────────────────
     * Transform Y: Y' = M[1][0]*X + M[1][1]*Y + M[1][2]*Z + T[1]
     * ───────────────────────────────────────────────────────────────────── */
    mac.l   @r4+,@r5+               /* MAC += M[1][0] * V[0] */
    mac.l   @r4+,@r5+               /* MAC += M[1][1] * V[1] */
    mac.l   @r4+,@r5+               /* MAC += M[1][2] * V[2] */
    add     #-12,r5                 /* Reset R5 to vector start */
    mov.l   @r4+,r8                 /* R8 = T[1] (translation Y) */
    sts     mach,r0                 /* Extract MAC result */
    sts     macl,r1
    xtrct   r0,r1                   /* R1 = Y' (before translation) */
    add     r8,r1                   /* R1 += T[1] */

    /* ─────────────────────────────────────────────────────────────────────
     * Transform Z: Z' = M[2][0]*X + M[2][1]*Y + M[2][2]*Z + T[2]
     * ───────────────────────────────────────────────────────────────────── */
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

    /* ─────────────────────────────────────────────────────────────────────
     * Post-processing: Screen coordinate mapping
     * Uses DMULS.L (313D/323D) for 32×32→64 multiplication
     * ───────────────────────────────────────────────────────────────────── */
    mov.l   @(28,r6),r3             /* Load scale factor from output[28] */
    .word   0x313D                  /* DMULS.L R3,R1 (Y × scale) */
    sts     mach,r0                 /* R0 = high 32 bits of result */
    add     r9,r0                   /* Add Y offset from caller */
    .word   0x81a6                  /* MOV.W R0,@(12,R10) - store Y screen coord */
    .word   0x323D                  /* DMULS.L R3,R2 (Z × scale) */
    sts     mach,r0                 /* R0 = high 32 bits of result */
    add     r12,r0                  /* Add X offset from caller */
    rts
    .word   0x81a7                  /* MOV.W R0,@(14,R10) - store X screen coord (delay slot) */

/*
 * End of func_006
 */
