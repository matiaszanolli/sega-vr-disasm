/*
 * func_026: Bounds Comparison / Min-Max Tracker
 * ROM File Offset: 0x23644 - 0x23678 (52 bytes)
 * SH2 Address: 0x02223644 - 0x02223678
 *
 * Purpose: Compares coordinate values to determine bounding box
 *          and track minimum/maximum values for visibility testing.
 *          Works with func_029 to classify quad visibility.
 *
 * Type: Leaf function (no calls)
 * Called By: func_023 (frustum cull dispatcher)
 *
 * Input:
 *   Coordinate buffer in SDRAM (pointed by literal pool)
 *
 * Output:
 *   R1 = Minimum value tracked
 *   R2 = Maximum value tracked
 *   T flag = Comparison result for caller
 */

.section .text
.align 2

func_026:
    /* ─────────────────────────────────────────────────────────────────────────
     * Initialize: Load coordinate buffer and first value
     * ───────────────────────────────────────────────────────────────────────── */
    /* $023644: D804 */ mov.l   .lit_coord_buf,r8   /* R8 = coordinate buffer */
    /* $023646: 8580 */ mov.w   @(0,r8),r0          /* R0 = coord[0] */
    /* $023648: 6103 */ mov     r0,r1               /* R1 = min = coord[0] */
    /* $02364A: 6203 */ mov     r0,r2               /* R2 = max = coord[0] */

    /* ─────────────────────────────────────────────────────────────────────────
     * Compare coordinate pair 1
     * ───────────────────────────────────────────────────────────────────────── */
    /* $02364C: 8582 */ mov.w   @(4,r8),r0          /* R0 = coord[2] */
    /* $02364E: 3013 */ cmp/ge  r1,r0               /* Is R0 >= R1 (min)? */
    /* $023650: 8904 */ bt      .pair1_ge_min       /* Branch if >= min */
    /* $023652: A006 */ bra     .pair1_update_max   /* Otherwise check max */
    /* $023654: 6103 */ mov     r0,r1               /* [delay] R1 = new min */

/* Literal pool */
.align 4
.lit_coord_buf:
    /* $023658: */ .long   0x06000740          /* Coordinate buffer in SDRAM */

.pair1_ge_min:
    /* R0 >= min, check if > max */
    /* $02365C: 3203 */ cmp/ge  r0,r2               /* Is R2 >= R0? */
    /* $02365E: 8900 */ bt      .pair2_setup        /* Branch if max >= val */
    /* $023660: 6203 */ mov     r0,r2               /* R2 = new max */

    /* ─────────────────────────────────────────────────────────────────────────
     * Compare coordinate pair 2
     * ───────────────────────────────────────────────────────────────────────── */
.pair1_update_max:
.pair2_setup:
    /* $023662: 8584 */ mov.w   @(8,r8),r0          /* R0 = coord[4] */
    /* $023664: 3013 */ cmp/ge  r1,r0               /* Is R0 >= min? */
    /* $023666: 8901 */ bt      .pair2_ge_min       /* Branch if >= */
    /* $023668: A003 */ bra     .pair3_setup        /* Else continue */
    /* $02366A: 6103 */ mov     r0,r1               /* [delay] R1 = new min */

.pair2_ge_min:
    /* $02366C: 3203 */ cmp/ge  r0,r2               /* Is max >= val? */
    /* $02366E: 8900 */ bt      .pair3_setup        /* Branch if yes */
    /* $023670: 6203 */ mov     r0,r2               /* R2 = new max */

    /* ─────────────────────────────────────────────────────────────────────────
     * Compare coordinate pair 3
     * ───────────────────────────────────────────────────────────────────────── */
.pair3_setup:
    /* $023672: 8586 */ mov.w   @(12,r8),r0         /* R0 = coord[6] */
    /* $023674: 3013 */ cmp/ge  r1,r0               /* Is R0 >= min? */
    /* $023676: 8901 */ bt      .final_max_check    /* Branch if >= */
    /* $023678: 000B */ rts                         /* Return early */
    /* $02367A: 6103 */ mov     r0,r1               /* [delay] R1 = new min */

.final_max_check:
    /* $02367C: 3203 */ cmp/ge  r0,r2               /* Is max >= val? */
    /* $02367E: 8901 */ bt      .exit_unchanged     /* Branch if yes */
    /* $023680: 000B */ rts                         /* Return */
    /* $023682: 6203 */ mov     r0,r2               /* [delay] R2 = new max */

.exit_unchanged:
    /* $023684: 000B */ rts                         /* Return */
    /* $023686: 0009 */ nop                         /* Delay slot */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Min-Max Algorithm:
 *    Iterates through 4 coordinate values (at offsets 0, 4, 8, 12)
 *    tracking the minimum (R1) and maximum (R2) values found.
 *
 * 2. Coordinate Buffer:
 *    Reads from SDRAM at 0x06000740, which contains screen-space
 *    coordinates computed by earlier transform functions.
 *
 * 3. Early Exit Optimization:
 *    Multiple RTS instructions allow early exit when certain
 *    conditions are met, avoiding unnecessary comparisons.
 *
 * 4. Used for Clipping:
 *    The min/max values determine the quad's screen extent.
 *    Caller uses these to determine:
 *    - If quad is completely inside view (no clipping)
 *    - If quad is completely outside (cull entirely)
 *    - Which edges need clipping (partial visibility)
 *
 * 5. Relationship to func_029:
 *    func_026 and func_029 perform similar operations on
 *    different coordinate components (X vs Y axis).
 *
 * ============================================================================ */
