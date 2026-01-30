/*
 * func_033: Quad Rendering / Edge Walking
 * ROM File Offset: 0x236F8 - 0x2375A (98 bytes)
 * SH2 Address: 0x022236F8 - 0x0222375A
 *
 * Purpose: Renders a quad by walking its edges and generating
 *          scanline data. Handles edge setup and calls func_034
 *          for the actual span filling.
 *
 * Type: Coordinator function
 * Called By: func_023 (frustum cull dispatcher)
 * Calls: func_034 @ $02375C (span filler)
 *
 * Input:
 *   R9  = Output buffer / scanline array
 *   R10 = Quad vertex data
 *   Context contains edge coordinates
 *
 * Processing:
 *   1. Initialize edge walkers from quad vertices
 *   2. Compare edges to determine left/right
 *   3. Generate scanline spans by interpolation
 *   4. Call func_034 to fill each span
 */

.section .text
.align 2

func_033:
    /* ─────────────────────────────────────────────────────────────────────────
     * Entry: Store initial value and load context
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0236F8: 2902 */ mov.l   r0,@r9              /* Store initial value */
    /* $0236FA: D80B */ mov.l   .lit_edge_buf,r8    /* R8 = edge buffer */
    /* $0236FC: 60A3 */ mov     r10,r0              /* R0 = vertex base */
    /* $0236FE: 53E5 */ mov.l   @(20,r14),r3        /* R3 = context->field_0x14 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Edge comparison loop: Determine left vs right edges
     * ───────────────────────────────────────────────────────────────────────── */
    /* $023700: 018E */ mac.w   @r8+,@r9+           /* MAC interpolation */
    /* $023702: 641F */ exts.b  r1,r4               /* Sign-extend low byte */
    /* $023704: 3433 */ cmp/ge  r3,r4               /* Compare to threshold */
    /* $023706: 8911 */ bt      .right_edge_first   /* Branch if right edge */

    /* Left edge processing */
    /* $023708: 6213 */ mov     r1,r2               /* R2 = edge value */
    /* $02370A: 30CC */ add     r12,r0              /* Advance position */
    /* $02370C: C90C */ and     #12,r0              /* Mask to valid range */
    /* $02370E: 018E */ mac.w   @r8+,@r9+           /* Continue interpolation */
    /* $023710: 641F */ exts.b  r1,r4               /* Sign-extend */
    /* $023712: 3433 */ cmp/ge  r3,r4               /* Compare again */
    /* $023714: 8BF8 */ bf      .edge_loop          /* Loop if not done */

    /* ─────────────────────────────────────────────────────────────────────────
     * Call span filler
     * ───────────────────────────────────────────────────────────────────────── */
    /* $023716: 4F22 */ sts.l   pr,@-r15            /* Save return address */
    /* $023718: B021 */ bsr     func_034            /* Call span filler */
    /* $02371A: 0009 */ nop                         /* Delay slot */
    /* $02371C: 4F26 */ lds.l   @r15+,pr            /* Restore PR */

    /* Post-processing */
    /* $02371E: 2932 */ mov.l   r3,@r9              /* Store edge data */
    /* $023720: 7904 */ add     #4,r9               /* Advance pointer */
    /* $023722: A008 */ bra     .continue           /* Continue processing */
    /* $023724: 53E6 */ mov.l   @(24,r14),r3        /* [delay] Load next param */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool
 * ───────────────────────────────────────────────────────────────────────────── */
.align 4
.lit_edge_buf:
    /* $023728: */ .long   0x06000740          /* Edge interpolation buffer */

.right_edge_first:
    /* Handle case where right edge comes first */
    /* $02372C: 2912 */ mov.l   r1,@r9              /* Store edge value */
    /* $02372E: 7904 */ add     #4,r9               /* Advance */
    /* $023730: 53E6 */ mov.l   @(24,r14),r3        /* Load param */
    /* ... continued processing ... */

.continue:
.edge_loop:
    /* Additional edge walking and span generation */
    /* $023732: 30CC */ add     r12,r0              /* Advance */
    /* $023734: C90C */ and     #12,r0              /* Mask */
    /* $023736: 6213 */ mov     r1,r2               /* Copy edge */
    /* $023738: 018E */ mac.w   @r8+,@r9+           /* Interpolate */
    /* $02373A: 641F */ exts.b  r1,r4               /* Sign-extend */
    /* $02373C: 3437 */ cmp/gt  r3,r4               /* Compare */
    /* $02373E: 8905 */ bt      .edge_done          /* Branch if done */
    /* $023740: 2912 */ mov.l   r1,@r9              /* Store */
    /* $023742: 7904 */ add     #4,r9               /* Advance */
    /* $023744: 30B0 */ cmp/eq  r11,r0              /* Check end */
    /* $023746: 8907 */ bt      .full_exit          /* Exit if done */
    /* ... continues ... */

.edge_done:
.full_exit:
    /* Exit paths */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Edge Walking Algorithm:
 *    Classic polygon rasterization using edge walking:
 *    - Track left and right edges separately
 *    - Interpolate X coordinates as Y increases
 *    - Generate horizontal spans between edges
 *
 * 2. MAC.W Usage:
 *    Hardware multiply-accumulate for fast interpolation.
 *    Computes: new_x = start_x + (delta_x * step)
 *
 * 3. Sign Extension:
 *    EXTS.B R1,R4 extends 8-bit values to 32-bit.
 *    This handles negative edge deltas correctly.
 *
 * 4. Left/Right Classification:
 *    Compares edge positions to determine which is left vs right.
 *    Important for correct fill order (left-to-right scanlines).
 *
 * 5. func_034 Call:
 *    After setting up edge data, calls func_034 to actually
 *    fill the horizontal span with pixels/texture data.
 *
 * ============================================================================ */
