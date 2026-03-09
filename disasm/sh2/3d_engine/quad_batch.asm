/* DOCUMENTATION ONLY — not used by build system.
 * Build source: func_018_quad_batch_short.asm
 */
/*
 * func_018: Quad Batch Processor
 * ROM File Offset: 0x233A2 - 0x2340A (106 bytes)
 * SH2 Address: 0x022233A2 - 0x0222340A
 *
 * Purpose: Main quad batch processing loop. Processes a batch of quads
 *          by calling func_016 (coord transform) multiple times and
 *          func_020 (recursive quad processor) as needed.
 *
 * Type: Coordinator
 * Called By: Rendering pipeline
 * Calls: func_016 (4× per quad), func_020 (conditional)
 * Priority: Medium (but calls hot functions)
 *
 * NOTE: VRD uses QUADS (4-vertex sprites) with Super Scaler-like processing.
 *       Each quad vertex needs coordinate transformation via func_016.
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

/* $0233A2 = NOP (previous function delay slot) */

func_018:
    /* ─────────────────────────────────────────────────────────────────────
     * Entry: Initialize output buffer
     * ───────────────────────────────────────────────────────────────────── */
    /* $0233A4: E100 */ mov     #0,r1               /* R1 = 0 */
    /* $0233A6: 2A12 */ mov.l   r1,@r10             /* Clear output header */
    /* $0233A8: 7AFC */ add     #-4,r10             /* R10 -= 4 */
    /* $0233AA: 4001 */ shlr    r0                  /* R0 >>= 1 */
    /* $0233AC: 1E02 */ mov.l   r0,@(8,r14)         /* Store to context+8 */

    /* ─────────────────────────────────────────────────────────────────────
     * Save registers for nested calls
     * ───────────────────────────────────────────────────────────────────── */
    /* $0233AE: 2F66 */ mov.l   r6,@-r15            /* Save R6 */
    /* $0233B0: 2F76 */ mov.l   r7,@-r15            /* Save R7 */
    /* $0233B2: 2FA6 */ mov.l   r10,@-r15           /* Save R10 */

.loop_start:
    /* ─────────────────────────────────────────────────────────────────────
     * Process 4 vertices of quad (calls func_016 for each)
     * ───────────────────────────────────────────────────────────────────── */

    /* Vertex 1 */
    /* $0233B4: C9FF */ and     #0xFF,r0            /* Mask to byte */
    /* $0233B6: 8800 */ cmp/eq  #0,r0               /* Check if zero */
    /* $0233B8: 8901 */ bt      .skip_vertex1       /* Skip if zero */
    /* $0233BA: B071 */ bsr     func_020            /* Call recursive processor */
    /* $0233BC: 4F22 */ sts.l   pr,@-r15            /* [delay] Save PR */
.skip_vertex1:
    /* $0233BE: 7BF0 */ add     #-16,r11            /* R11 -= 16 (advance state) */

    /* Vertex 2 */
    /* $0233C0: 84EA */ mov.w   @(20,r14),r0        /* Load flag from context+20 */
    /* $0233C2: 8800 */ cmp/eq  #0,r0
    /* $0233C4: 8901 */ bt      .skip_vertex2
    /* $0233C6: B06B */ bsr     func_020
    /* $0233C8: 4F22 */ sts.l   pr,@-r15
.skip_vertex2:
    /* $0233CA: 7BF0 */ add     #-16,r11

    /* Vertex 3 */
    /* $0233CC: 84E9 */ mov.w   @(18,r14),r0        /* Load flag from context+18 */
    /* $0233CE: 8800 */ cmp/eq  #0,r0
    /* $0233D0: 8901 */ bt      .skip_vertex3
    /* $0233D2: B065 */ bsr     func_020
    /* $0233D4: 4F22 */ sts.l   pr,@-r15
.skip_vertex3:
    /* $0233D6: 7BF0 */ add     #-16,r11

    /* Vertex 4 */
    /* $0233D8: 84E8 */ mov.w   @(16,r14),r0        /* Load flag from context+16 */
    /* $0233DA: 8800 */ cmp/eq  #0,r0
    /* $0233DC: 8901 */ bt      .skip_vertex4
    /* $0233DE: B05F */ bsr     func_020
    /* $0233E0: 4F22 */ sts.l   pr,@-r15
.skip_vertex4:

    /* ─────────────────────────────────────────────────────────────────────
     * Restore and loop
     * ───────────────────────────────────────────────────────────────────── */
    /* $0233E2: 6AF6 */ mov.l   @r15+,r10           /* Restore R10 */
    /* $0233E4: 67F6 */ mov.l   @r15+,r7            /* Restore R7 */
    /* $0233E6: 66F6 */ mov.l   @r15+,r6            /* Restore R6 */

    /* $0233E8: 4710 */ dt      r7                  /* Decrement R7, set T if zero */
    /* $0233EA: 8FD1 */ bf/s    .loop_start         /* Loop if R7 != 0 */
    /* $0233EC: 7BF0 */ add     #-16,r11            /* [delay] R11 -= 16 */

    /* $0233EE: AFD6 */ bra     .exit               /* Jump to exit */
    /* $0233F0: 0009 */ nop

    /* ─────────────────────────────────────────────────────────────────────
     * Alternate path (after main loop)
     * ───────────────────────────────────────────────────────────────────── */
.alternate:
    /* $0233F2: 4F22 */ sts.l   pr,@-r15
    /* $0233F4: BFB8 */ bsr     func_016            /* Call coord transform */
    /* $0233F6: 0009 */ nop

.check_loop:
    /* $0233F8: 60A2 */ mov.b   @r10,r0             /* Load byte from output */
    /* $0233FA: D105 */ mov.l   .mask_literal,r1    /* Load mask value */
    /* $0233FC: 2018 */ tst     r1,r0               /* Test with mask */
    /* $0233FE: 8B09 */ bf      .exit               /* Exit if bits set */
    /* $023400: 7AFC */ add     #-4,r10             /* R10 -= 4 */
    /* $023402: 4710 */ dt      r7                  /* Decrement counter */
    /* $023404: 8FF8 */ bf/s    .check_loop         /* Loop if not zero */
    /* $023406: 7BC0 */ add     #-64,r11            /* [delay] R11 -= 64 */

.exit:
    /* $023408: 4F26 */ lds.l   @r15+,pr            /* Restore PR */
    /* $02340A: 000B */ rts
    /* $02340C: 0009 */ nop                         /* Delay slot */

/* ============================================================================
 * Literal pool
 * ============================================================================ */
.mask_literal:
    /* $02340E: 0000 FF00 */ .long 0x0000FF00      /* Mask for visibility check */
    /* $023412: FF00 */                            /* Part of literal or padding */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Quad Processing:
 *    - Each quad has 4 vertices
 *    - Function checks visibility flag for each vertex
 *    - Calls func_020 only for visible/valid vertices
 *    - This is the Super Scaler-like quad transform path
 *
 * 2. Register Pattern:
 *    - R11 decremented by 16 for each vertex (state stride = 16 bytes)
 *    - R14 context holds visibility flags at offsets 16, 18, 20
 *    - R10 tracks output buffer position
 *
 * 3. Performance:
 *    - 4 potential BSR calls per quad (func_020)
 *    - Additional func_016 call in alternate path
 *    - Stack heavy due to saves/restores each iteration
 *
 * 4. Optimization Potential:
 *    - Unroll the 4-vertex check/call pattern
 *    - Eliminate redundant stack operations
 *    - Early exit if all vertices culled
 *
 * ============================================================================ */
