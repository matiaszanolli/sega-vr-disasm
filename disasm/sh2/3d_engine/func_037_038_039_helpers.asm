/* DOCUMENTATION ONLY — not used by build system.
 * Build source: func_037_038_039_helpers_short.asm
 */
/*
 * func_037, func_038, func_039: Visibility Helper Functions
 * ROM File Offset: 0x2381E - 0x2385A (~60 bytes)
 * SH2 Addresses:
 *   func_037: 0x0222381E (visibility test)
 *   func_038: 0x02223834 (conditional early return)
 *   func_039: 0x02223844 (span setup caller)
 *
 * These are helper subroutines called by func_036 (render dispatch).
 */

.section .text
.align 2

/* ═══════════════════════════════════════════════════════════════════════════
 * func_037: Visibility Test Helper
 * Entry: 0x0222381E
 * Size: ~22 bytes
 *
 * Purpose: Test if value R3 is within bounds [R14+0x1C, R14+0x20]
 *          Returns visibility flags in R0
 *
 * Input:
 *   R3  = Value to test
 *   R14 = Context pointer
 *         @(0x1C,R14) = min bound
 *         @(0x20,R14) = max bound
 *
 * Output:
 *   R0  = Visibility flags (0=inside, 4=below, 2=above, 6=outside)
 * ═══════════════════════════════════════════════════════════════════════════ */
func_037:
    mov.l   @(0x1C,r14),r1          /* R1 = context->min_bound */
    mov.l   @(0x20,r14),r2          /* R2 = context->max_bound */
    mov     #0,r0                   /* R0 = 0 (initially inside) */

    cmp/ge  r1,r3                   /* R3 >= R1 (above min)? */
    bt      .check_max              /* If yes, check max bound */
    /* CB04 = OR #$04,R0 */         /* R0 |= 4 (below min flag) */

.check_max:
    cmp/ge  r3,r2                   /* R2 >= R3 (below max)? */
    bt      .done_037               /* If yes, we're done */
    /* CB02 = OR #$02,R0 */         /* R0 |= 2 (above max flag) */

.done_037:
    rts
    /* C806 = TST #$06,R0 */        /* Test visibility bits (delay slot side effect) */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_038: Conditional Early Return
 * Entry: 0x02223834
 * Size: 8 bytes
 *
 * Purpose: Return early if R0 == 0, otherwise continue
 *
 * Input:
 *   R0  = Value to test
 *
 * Output:
 *   Returns immediately if R0 == 0
 *   Falls through if R0 != 0
 * ═══════════════════════════════════════════════════════════════════════════ */
func_038:
    cmp/eq  #0,r0                   /* R0 == 0? */
    bf      .not_zero               /* If not zero, continue */
    rts                             /* Return immediately */
    nop

.not_zero:
    cmp/eq  #2,r0                   /* R0 == 2? */
    mov.l   @(0x20,r14),r3          /* R3 = max bound (default) */
    bt      .use_max                /* If R0 == 2, use max */
    mov.l   @(0x1C,r14),r3          /* R3 = min bound (R0 == other) */
    /* Falls through to func_039 */

.use_max:
    /* Falls through to func_039 */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_039: Span Setup Caller
 * Entry: 0x02223844
 * Size: ~22 bytes
 *
 * Purpose: Set up span parameters and call func_034 for interpolation
 *
 * Input:
 *   R3  = Clipping bound
 *   R8  = Source data pointer
 *   R9  = Output pointer
 *   R14 = Context pointer
 *
 * Output:
 *   Interpolated span data written to @R9
 * ═══════════════════════════════════════════════════════════════════════════ */
func_039:
    sts.l   pr,@-r15                /* Save return address */
    mov.l   @r8,r2                  /* R2 = *R8 (current entry) */
    mov     r8,r0                   /* R0 = R8 */
    add     #-4,r0                  /* R0 = R8 - 4 (previous entry) */
    mov.l   @r0,r1                  /* R1 = *(R8-4) (previous) */
    swap.w  r2,r2                   /* Swap words of R2 */
    bsr     func_034                /* Call span filler @ $02223175E */
    swap.w  r1,r1                   /* (delay) Swap words of R1 */
    swap.w  r3,r3                   /* Swap result words */
    mov.l   r3,@r9                  /* Store result */
    lds.l   @r15+,pr                /* Restore return address */
    /* RTS follows */

/*
 * Analysis Notes:
 *
 * These helper functions support func_036's display list processing:
 *
 * func_037: Visibility Classification
 * - Compares polygon coordinate against view frustum bounds
 * - Returns bit flags: 0=inside, 2=right of max, 4=left of min
 * - Used to determine if clipping is needed
 *
 * func_038: Optimized Early Exit
 * - Quickly returns for fully visible polygons (R0=0)
 * - For clipped cases, selects appropriate bound and falls through
 *
 * func_039: Edge Interpolation Setup
 * - Prepares parameters for func_034 (span filler)
 * - Reads adjacent polygon entries to set up edge interpolation
 * - Used when polygon edge crosses clipping boundary
 *
 * The CB04/CB02 opcodes are OR #imm,R0 instructions that set
 * visibility flags. C806 is TST #$06,R0 in a delay slot.
 *
 * End of helper functions
 */
