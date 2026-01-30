/*
 * func_032: Scanline Setup / MAC.W Interpolation
 * ROM File Offset: 0x236DA - 0x236F6 (28 bytes)
 * SH2 Address: 0x022236DA - 0x022236F6
 *
 * Purpose: Sets up scanline data for rasterization using the
 *          SH2's MAC.W (multiply-accumulate word) instruction
 *          for efficient interpolation calculations.
 *
 * Type: Leaf function (no calls)
 * Called By: func_023 (frustum cull dispatcher)
 *
 * Input:
 *   R9  = Output buffer pointer
 *   R10 = Base value
 *   R11 = Comparison value
 *   R12 = Increment value
 *
 * Processing:
 *   Uses MAC.W to compute interpolated values along scanlines.
 *   This is the hardware-accelerated inner loop of the rasterizer.
 */

.section .text
.align 2

func_032:
    /* ─────────────────────────────────────────────────────────────────────────
     * Setup: Load interpolation table
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0236DA: D805 */ mov.l   .lit_interp_table,r8 /* R8 = interpolation table */
    /* $0236DC: 60A3 */ mov     r10,r0              /* R0 = base value */

    /* ─────────────────────────────────────────────────────────────────────────
     * Interpolation loop using MAC.W
     * ───────────────────────────────────────────────────────────────────────── */
.interp_loop:
    /* $0236DE: 018E */ mac.w   @r8+,@r9+           /* MAC += *R8++ * *R9++ */
    /* $0236E0: 2912 */ mov.l   r1,@r9              /* Store result */
    /* $0236E2: 30B0 */ cmp/eq  r11,r0              /* Is R0 == R11? */
    /* $0236E4: 8D06 */ bt/s    .exit               /* Exit if equal */
    /* $0236E6: 7904 */ add     #4,r9               /* [delay] Advance output */
    /* $0236E8: 30CC */ add     r12,r0              /* R0 += increment */
    /* $0236EA: AFF8 */ bra     .interp_loop        /* Loop back */
    /* $0236EC: C90C */ and     #12,r0              /* [delay] Mask to valid range */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool
 * ───────────────────────────────────────────────────────────────────────────── */
.align 4
.lit_interp_table:
    /* $0236F0: */ .long   0x06000740          /* Interpolation coefficients */

.exit:
    /* $0236F4: E0FF */ mov     #-1,r0              /* R0 = 0xFFFFFFFF (done flag) */
    /* $0236F6: 000B */ rts                         /* Return */
    /* $0236F8: 2902 */ mov.l   r0,@r9              /* [delay] Store terminator */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. MAC.W Instruction:
 *    The MAC.W @R8+,@R9+ instruction performs:
 *    - Read word from R8 (auto-increment)
 *    - Read word from R9 (auto-increment)
 *    - Multiply them (16×16=32)
 *    - Add to MACL/MACH accumulator
 *    This is ideal for texture coordinate interpolation.
 *
 * 2. Loop Structure:
 *    - Start with base value in R0
 *    - MAC.W computes interpolated value
 *    - Add increment (R12) each iteration
 *    - Continue until R0 equals end value (R11)
 *
 * 3. Output Format:
 *    Results stored at R9 with 4-byte spacing.
 *    Likely scanline edge coordinates or texture U/V values.
 *
 * 4. Termination:
 *    Writes 0xFFFFFFFF as terminator to mark end of valid data.
 *    Rasterizer can detect this to know when to stop.
 *
 * 5. Performance:
 *    MAC.W is a single-cycle instruction on SH2.
 *    Combined with post-increment addressing, this is optimal
 *    for the tight inner loop of span generation.
 *
 * ============================================================================ */
