/*
 * func_020: Recursive Quad Processor
 * ROM File Offset: 0x23468 - 0x234BE (86 bytes)
 * SH2 Address: 0x02223468 - 0x022234BE
 *
 * Purpose: Recursive quad subdivision or hierarchical processing.
 *          Called for each quad node in the scene graph.
 *          Self-recursive - can call itself for nested quads.
 *
 * NOTE: VRD uses QUADS (4-vertex sprites) not triangular quads.
 *       Quads are processed with Super Scaler-like affine transforms.
 *
 * Type: Coordinator (recursive)
 * Called By: func_018, func_019, func_020 (self)
 * Call Count: 3 direct + recursive calls
 * Priority: ⭐⭐ HOT
 *
 * Input:
 *   R6  = Current node pointer
 *   R7  = Loop counter / node count
 *   R10 = Output buffer pointer
 *   R11 = Context/state pointer
 *   R14 = RenderingContext pointer
 *
 * Stack Usage:
 *   Saves: R6, R7, R10, R11, PR (for recursive calls)
 *
 * Calls:
 *   func_023 @ $02223500 (via BSR) - Leaf quad processing
 *   func_020 (self) - Recursive call for child nodes
 */

.section .text
.align 2

/* Note: $023468 is NOP - delay slot of previous function */
/* func_020 actually starts at $02346A */

func_020:
    /* ─────────────────────────────────────────────────────────────────────
     * Entry: Initialize output and adjust pointer
     * ───────────────────────────────────────────────────────────────────── */
    /* $02346A: E100 */ mov     #0,r1               /* R1 = 0 (clear/init) */
    /* $02346C: 2A12 */ mov.l   r1,@r10             /* Clear output buffer header */
    /* $02346E: 7AFC */ add     #-4,r10             /* R10 -= 4 (move to next slot) */

    /* $023470: 4001 */ shlr    r0                  /* R0 >>= 1 (divide by 2?) */
    /* $023472: 1E02 */ mov.l   r0,@(8,r14)         /* Store to context+8 */

    /* ─────────────────────────────────────────────────────────────────────
     * Save registers for recursive call
     * ───────────────────────────────────────────────────────────────────── */
    /* $023474: 2F66 */ mov.l   r6,@-r15            /* Save R6 (node ptr) */
    /* $023476: 2F76 */ mov.l   r7,@-r15            /* Save R7 (counter) */
    /* $023478: 2FA6 */ mov.l   r10,@-r15           /* Save R10 (output) */

.loop_start:
    /* ─────────────────────────────────────────────────────────────────────
     * Check node type and branch
     * ───────────────────────────────────────────────────────────────────── */
    /* $02347A: 84EB */ mov.w   @(22,r14),r0        /* Load node type from context+22 */
    /* $02347C: 8800 */ cmp/eq  #0,r0               /* Is type == 0? */
    /* $02347E: 8901 */ bt      .type_zero          /* Branch if type 0 */
    /* $023480: B00E */ bsr     func_023            /* Call leaf processor */
    /* $023482: 4F22 */ sts.l   pr,@-r15            /* [delay] Save PR */

.type_zero:
    /* $023484: 7BE0 */ add     #-32,r11            /* R11 -= 32 (adjust state) */

    /* ─────────────────────────────────────────────────────────────────────
     * Check second condition and potentially recurse
     * ───────────────────────────────────────────────────────────────────── */
    /* $023486: 84E9 */ mov.w   @(18,r14),r0        /* Load from context+18 */
    /* $023488: 8800 */ cmp/eq  #0,r0               /* Is it zero? */
    /* $02348A: 8901 */ bt      .skip_recurse       /* Skip if zero */
    /* $02348C: B008 */ bsr     func_020            /* RECURSIVE CALL to self */
    /* $02348E: 4F22 */ sts.l   pr,@-r15            /* [delay] Save PR */

.skip_recurse:
    /* ─────────────────────────────────────────────────────────────────────
     * Restore and loop
     * ───────────────────────────────────────────────────────────────────── */
    /* $023490: 6AF6 */ mov.l   @r15+,r10           /* Restore R10 */
    /* $023492: 67F6 */ mov.l   @r15+,r7            /* Restore R7 */
    /* $023494: 66F6 */ mov.l   @r15+,r6            /* Restore R6 */

    /* $023496: 4710 */ dt      r7                  /* Decrement R7, set T if zero */
    /* $023498: 8FDD */ bf/s    .loop_start         /* Loop if R7 != 0 */
    /* $02349A: 7BE0 */ add     #-32,r11            /* [delay] R11 -= 32 */

    /* $02349C: AFE2 */ bra     .continue           /* Branch to continuation */
    /* $02349E: 0009 */ nop                         /* Delay slot */

    /* ─────────────────────────────────────────────────────────────────────
     * Alternate path (reached via different entry?)
     * ───────────────────────────────────────────────────────────────────── */
.alternate_entry:
    /* $0234A0: 2FB6 */ mov.l   r11,@-r15           /* Save R11 */
    /* $0234A2: 61B5 */ mov.w   @(10,r11),r1        /* Load from R11+10 */
    /* $0234A4: D807 */ mov.l   .literal_pool,r8    /* Load literal address */
    /* $0234A6: 611D */ extu.w  r1,r1               /* Zero-extend R1 */
    /* $0234A8: 381C */ add     r1,r8               /* R8 += R1 (index into table) */
    /* $0234AA: 2FB6 */ mov.l   r11,@-r15           /* Save R11 again */
    /* $0234AC: 2F06 */ mov.l   r0,@-r15            /* Save R0 */
    /* $0234AE: B02C */ bsr     .some_func          /* Call helper */
    /* $0234B0: 4F22 */ sts.l   pr,@-r15            /* [delay] Save PR */

    /* Restore and continue */
    /* $0234B2: 60F6 */ mov.l   @r15+,r0            /* Restore R0 */
    /* $0234B4: 6BF6 */ mov.l   @r15+,r11           /* Restore R11 */
    /* $0234B6: 4010 */ dt      r0                  /* Decrement R0 */
    /* $0234B8: 8BF3 */ bf      .alternate_entry    /* Loop if R0 != 0 */
    /* $0234BA: 6BF6 */ mov.l   @r15+,r11           /* Final R11 restore */

    /* ─────────────────────────────────────────────────────────────────────
     * Exit
     * ───────────────────────────────────────────────────────────────────── */
.continue:
    /* $0234BC: 4F26 */ lds.l   @r15+,pr            /* Restore PR */
    /* $0234BE: 000B */ rts
    /* $0234C0: 0009 */ nop                         /* Delay slot */

/* ============================================================================
 * Literal pool (estimated location)
 * ============================================================================ */
.literal_pool:
    /* $0234C2: 0000 0601 */ .long 0x00000601      /* Table base or constant */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Structure:
 *    - Main loop iterates R7 times
 *    - Each iteration checks node type, calls func_023 or recurses
 *    - Recursive depth depends on scene graph complexity
 *
 * 2. Recursive Pattern:
 *    - Calls itself at $02348C when context+18 is non-zero
 *    - This implements hierarchical quad tree traversal
 *    - Stack grows with recursion depth (saves R6, R7, R10, PR each time)
 *
 * 3. Register Usage:
 *    - R6: Node pointer (preserved across calls)
 *    - R7: Loop counter (restored after each call)
 *    - R10: Output buffer (adjusted as processing proceeds)
 *    - R11: State pointer (decremented by 32 for each level)
 *    - R14: Rendering context (passed through)
 *
 * 4. Optimization Potential:
 *    - Loop unrolling for known tree depths
 *    - Iterative conversion to reduce stack pressure
 *    - Parallel processing of independent subtrees
 *
 * ============================================================================ */
