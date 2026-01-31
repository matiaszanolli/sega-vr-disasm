/*
 * func_032: Table Lookup / Indexed Load Loop
 * ROM File Offset: 0x236DA - 0x236F9 (32 bytes verified)
 * SH2 Address: 0x022236DA
 *
 * Purpose: Performs indexed table lookups using R0 as index into
 *          a base table at R8, storing results to output buffer R9.
 *
 * Type: Leaf function (no calls)
 * Called By: func_023 (frustum cull dispatcher)
 *
 * Input:
 *   R8  = Base address (loaded from literal pool)
 *   R9  = Output buffer pointer
 *   R10 = Starting index value
 *   R11 = Ending index value
 *   R12 = Index increment
 *
 * Processing:
 *   Uses indexed addressing @(R0,R8) to lookup table entries.
 *   R0 cycles through indices from R10 to R11 by R12 steps.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x236DA start */

func_032:
    /* ─────────────────────────────────────────────────────────────────────────
     * Setup: Load table base address
     * MOV.L @(5,PC),R8 manually encoded: at 0x236DA, target = 0x236F0
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD805                            /* MOV.L @(5*4,PC),R8 -> 0x236F0 */
    /* $0236DC */ mov     r10,r0              /* R0 = starting index */

    /* ─────────────────────────────────────────────────────────────────────────
     * Main loop: Indexed table lookup
     * ───────────────────────────────────────────────────────────────────────── */
.loop:
    /* $0236DE */ mov.l   @(r0,r8),r1         /* R1 = table[R0] via indexed addr */
    /* $0236E0 */ mov.l   r1,@r9              /* Store to output buffer */
    /* $0236E2 */ cmp/eq  r11,r0              /* R0 == end index? */
    /* $0236E4 */ bt/s    .exit               /* Exit if done */
    /* $0236E6 */ add     #4,r9               /* [delay] Advance output ptr */
    /* $0236E8 */ add     r12,r0              /* R0 += increment */
    /* $0236EA */ bra     .loop               /* Continue loop */
    /* $0236EC */ and     #12,r0              /* [delay] Mask index (0,4,8,12) */

/* ─────────────────────────────────────────────────────────────────────────────
 * Padding and Literal Pool (aligned to 4 bytes at 0x236F0)
 * ───────────────────────────────────────────────────────────────────────────── */
    .byte   0x00, 0x00                        /* Manual padding */
.lit_table_base:
    .byte   0xC0, 0x00, 0x07, 0x40            /* 0xC0000740 in big-endian */

.exit:
    /* $0236F4 */ mov     #-1,r0              /* R0 = 0xFFFFFFFF (terminator) */
    /* $0236F6 */ rts                         /* Return */
    /* $0236F8 */ mov.l   r0,@r9              /* [delay] Store terminator */

/* ============================================================================
 * End of func_032 (32 bytes)
 * ============================================================================ */
