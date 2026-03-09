/* DOCUMENTATION ONLY — not used by build system.
 * Build source: func_019_quad_batch_alt_short.asm
 */
/*
 * func_019: Quad Batch Processor (Alternate)
 * ROM File Offset: 0x2340C - 0x23466 (92 bytes)
 * SH2 Address: 0x0222340C - 0x02223466
 *
 * Purpose: Alternate quad batch processing loop. Similar to func_018 but
 *          processes only 2 vertices per quad (likely for simplified quads
 *          or different LOD levels).
 *
 * Type: Coordinator
 * Called By: Rendering pipeline
 * Calls: func_016 (2× per quad), func_020 (conditional)
 * Priority: Medium
 *
 * NOTE: VRD uses QUADS (4-vertex sprites) with Super Scaler-like processing.
 *       This variant may handle 2-vertex cases (edges or simplified quads).
 *
 * Input:
 *   R6  = Quad data pointer
 *   R7  = Quad count (loop counter)
 *   R10 = Output buffer pointer
 *   R11 = State/context pointer
 *   R14 = RenderingContext pointer
 *
 * Stack Usage:
 *   Saves: R6, R7, R10, PR (for nested calls)
 */

.section .text
.align 2

/* $02340C = NOP (previous function delay slot) */
/* $02340E-$023412 = Literal pool from func_018 */

func_019:
    /* ─────────────────────────────────────────────────────────────────────
     * Entry: Load literal and initialize
     * ───────────────────────────────────────────────────────────────────── */
    /* $023414: D10D */ mov.l   .literal_addr,r1    /* Load address from pool */
    /* $023416: 2109 */ mov.w   r0,@r1              /* Store R0 to address */
    /* $023418: 2A12 */ mov.l   r1,@r10             /* Store to output buffer */
    /* $02341A: 7AFC */ add     #-4,r10             /* R10 -= 4 */
    /* $02341C: 4001 */ shlr    r0                  /* R0 >>= 1 */
    /* $02341E: 1E02 */ mov.l   r0,@(8,r14)         /* Store to context+8 */

    /* ─────────────────────────────────────────────────────────────────────
     * Save registers for nested calls
     * ───────────────────────────────────────────────────────────────────── */
    /* $023420: 2F66 */ mov.l   r6,@-r15            /* Save R6 */
    /* $023422: 2F76 */ mov.l   r7,@-r15            /* Save R7 */
    /* $023424: 2FA6 */ mov.l   r10,@-r15           /* Save R10 */

.loop_start:
    /* ─────────────────────────────────────────────────────────────────────
     * Process 2 vertices of quad (simplified path)
     * ───────────────────────────────────────────────────────────────────── */

    /* Vertex 1 */
    /* $023426: 84EA */ mov.w   @(20,r14),r0        /* Load flag from context+20 */
    /* $023428: 8800 */ cmp/eq  #0,r0               /* Check if zero */
    /* $02342A: 8901 */ bt      .skip_vertex1       /* Skip if zero */
    /* $02342C: B038 */ bsr     func_020            /* Call recursive processor */
    /* $02342E: 4F22 */ sts.l   pr,@-r15            /* [delay] Save PR */
.skip_vertex1:
    /* $023430: 7BE0 */ add     #-32,r11            /* R11 -= 32 (larger stride) */

    /* Vertex 2 */
    /* $023432: 84E8 */ mov.w   @(16,r14),r0        /* Load flag from context+16 */
    /* $023434: 8800 */ cmp/eq  #0,r0
    /* $023436: 8901 */ bt      .skip_vertex2
    /* $023438: B032 */ bsr     func_020
    /* $02343A: 4F22 */ sts.l   pr,@-r15
.skip_vertex2:

    /* ─────────────────────────────────────────────────────────────────────
     * Restore and loop
     * ───────────────────────────────────────────────────────────────────── */
    /* $02343C: 6AF6 */ mov.l   @r15+,r10           /* Restore R10 */
    /* $02343E: 67F6 */ mov.l   @r15+,r7            /* Restore R7 */
    /* $023440: 66F6 */ mov.l   @r15+,r6            /* Restore R6 */

    /* $023442: 4710 */ dt      r7                  /* Decrement R7, set T if zero */
    /* $023444: 8FD8 */ bf/s    .loop_start         /* Loop if R7 != 0 */
    /* $023446: 7BE0 */ add     #-32,r11            /* [delay] R11 -= 32 */

    /* $023448: AFDE */ bra     .exit               /* Jump to exit */
    /* $02344A: 0009 */ nop

/* ─────────────────────────────────────────────────────────────────────
 * Literal pool (mid-function)
 * ───────────────────────────────────────────────────────────────────── */
    /* $02344C: 00FF 00FF */ .long 0x00FF00FF      /* Mask or constant */

    /* ─────────────────────────────────────────────────────────────────────
     * Alternate path (func_016 call)
     * ───────────────────────────────────────────────────────────────────── */
.alternate:
    /* $023450: 4F22 */ sts.l   pr,@-r15
    /* $023452: BF89 */ bsr     func_016            /* Call coord transform */
    /* $023454: 0009 */ nop

.check_loop:
    /* $023456: 60A2 */ mov.b   @r10,r0             /* Load byte from output */
    /* $023458: 8800 */ cmp/eq  #0,r0               /* Is it zero? */
    /* $02345A: 8B06 */ bf      .exit               /* Exit if not zero */
    /* $02345C: 7AFC */ add     #-4,r10             /* R10 -= 4 */
    /* $02345E: 4710 */ dt      r7                  /* Decrement counter */
    /* $023460: 8FF9 */ bf/s    .check_loop         /* Loop if not zero */
    /* $023462: 7BC0 */ add     #-64,r11            /* [delay] R11 -= 64 */

.exit:
    /* $023464: 4F26 */ lds.l   @r15+,pr            /* Restore PR */
    /* $023466: 000B */ rts
    /* $023468: 0009 */ nop                         /* Delay slot - start of func_020 */

/* ============================================================================
 * Literal pool (at function start)
 * ============================================================================ */
.literal_addr:
    /* Referenced by D10D at $023414 */
    /* Points to some SDRAM location for state storage */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Comparison with func_018:
 *    - func_018: Processes 4 vertices per quad
 *    - func_019: Processes 2 vertices per quad
 *    - Both call func_020 conditionally based on visibility flags
 *
 * 2. Stride Difference:
 *    - func_018: R11 -= 16 per vertex (64 bytes per quad)
 *    - func_019: R11 -= 32 per vertex (64 bytes per quad, but fewer vertices)
 *
 * 3. Use Case:
 *    - Likely used for edge rendering or simplified LOD
 *    - Or for certain quad types that only need 2 transformed vertices
 *
 * 4. Performance:
 *    - Fewer BSR calls than func_018 (2 vs 4 per quad)
 *    - Still has stack overhead from saves/restores
 *
 * ============================================================================ */
