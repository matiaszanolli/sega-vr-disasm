/* DOCUMENTATION ONLY — not used by build system.
 * Build source: func_036_render_dispatch_short.asm
 */
/*
 * func_036: Render Dispatch D / Display List Processor
 * ROM File Offset: 0x237D6 - 0x2381C (~70 bytes)
 * SH2 Address: 0x022237D6
 *
 * Note: Data constants at $237D2-$237D5 precede function entry.
 *       Actual entry point is $237D6 (STS.L PR,@-R15).
 *
 * Called By: func_023 (frustum_cull) third visibility path
 *
 * Purpose: Process a display list of polygon entries, performing
 *          visibility tests and dispatching to render subroutines.
 *          Processes entries until 0xFF terminator is found.
 *
 * Input:
 *   R8  = Input display list pointer
 *   R9  = Output buffer pointer
 *   R14 = Context pointer (contains bounds at +0x1C, +0x20)
 *
 * Output:
 *   R8  = Advanced past processed entries
 *   R9  = Advanced past output data
 *   0xFF written to output as terminator
 *
 * Calls:
 *   - Subroutine @ $0222381E (visibility test helper)
 *   - Subroutine @ $02223834 (render output helper)
 */

.section .text
.align 2

/* Data constants (before function entry) */
.func_036_constants:
    .word   0x237B                  /* Related to reciprocal table? */
    .word   0xFF00                  /* Padding/constant */

func_036:
    /* Function prologue */
    sts.l   pr,@-r15                /* Save return address */

    /* Process first entry */
    bsr     .visibility_test        /* Call visibility helper */
    mov.w   @r8,r3                  /* (delay) R3 = first entry */

    mov     r0,r10                  /* R10 = visibility result A */
    mov     r0,r12                  /* R12 = current visibility */

.entry_loop:
    mov.l   @r8+,r3                 /* R3 = next entry, advance R8 */
    bf      .skip_output1           /* If T=0, skip output */
    mov.l   r3,@r9                  /* Write entry to output */
    add     #4,r9                   /* Advance output pointer */

.skip_output1:
    /* Process second entry of pair */
    bsr     .visibility_test        /* Call visibility helper */
    mov.w   @r8,r3                  /* (delay) R3 = entry */

    mov     r0,r11                  /* R11 = visibility result B */

    /* Check visibility combination */
    tst     r12,r0                  /* Test R12 AND R0 */
    bf      .next_entry             /* If non-zero, skip to next */

    /* Visibility logic */
    or      r12,r0                  /* R0 = R12 OR visibility */
    /* $C806 = TST #$06,R0 (test bits 1,2) */
    bt      .output_entry           /* If bits clear, output directly */

    /* Call render helpers for edge cases */
    bsr     .render_helper          /* Call render @ $02223834 */
    mov     r12,r0                  /* (delay) R0 = current visibility */
    bsr     .render_helper          /* Call render again */
    mov     r11,r0                  /* (delay) R0 = second visibility */

    mov     r11,r0                  /* R0 = visibility B */
    /* $C806 = TST #$06,R0 */
    bf      .next_entry             /* If bits set, skip output */

.output_entry:
    mov.l   @r8,r3                  /* R3 = current entry */
    mov.l   r3,@r9                  /* Write to output */
    add     #4,r9                   /* Advance output */

.next_entry:
    add     #4,r8                   /* Advance input pointer */
    mov     r11,r12                 /* R12 = previous visibility */

    /* Check for terminator */
    mov.l   @r8,r0                  /* R0 = next entry */
    cmp/eq  #0xFF,r0                /* Is it 0xFF terminator? */
    bf      .entry_loop             /* If not, continue loop */

    /* Function epilogue */
    mov     #0xFF,r0                /* Terminator value */
    lds.l   @r15+,pr                /* Restore return address */
    rts                             /* Return */
    mov.l   r0,@r9                  /* (delay) Write terminator */

/* ─────────────────────────────────────────────────────────────────────────────
 * Subroutine: Visibility Test Helper
 * Address: $0222381E
 * ───────────────────────────────────────────────────────────────────────────── */
.visibility_test:
    mov.l   @(0x1C,r14),r1          /* R1 = context->bounds_min */
    mov.l   @(0x20,r14),r2          /* R2 = context->bounds_max */
    mov     #0,r0                   /* R0 = 0 (initial result) */
    cmp/ge  r1,r3                   /* Compare entry >= min? */
    /* ... continues with visibility calculation ... */

/*
 * Analysis Notes:
 *
 * This is a display list processor that:
 * 1. Reads polygon entries from input buffer (R8)
 * 2. Tests visibility against frustum bounds
 * 3. Writes visible entries to output buffer (R9)
 * 4. Handles edge cases requiring additional render passes
 * 5. Terminates on 0xFF marker
 *
 * The visibility flags in R10/R11/R12 track which polygon edges
 * are inside/outside the view frustum, enabling partial clipping.
 *
 * The $C806 opcode is TST #imm,R0 testing specific visibility bits.
 *
 * End of func_036
 */
