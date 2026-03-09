/*
 * func_066: Run-Length Decoder
 * ROM File Offset: 0x23FC4 - 0x23FF3 (48 bytes)
 * SH2 Address: 0x02223FC4
 *
 * Purpose: Decodes run-length encoded data from source stream to destination
 *          buffer. Processes multiple RLE entries per outer loop iteration.
 *
 * Input:
 *   R14 = Context pointer
 *         [R14+4] = Destination buffer base
 *         [R14+8] = Source stream pointer
 *   R13 = Destination stride (added between outer iterations)
 *
 * RLE Format:
 *   Each entry is a 16-bit word:
 *   - High byte: fill value
 *   - Low byte: count (0 = end of inner sequence)
 *
 * Output:
 *   Decoded data written to destination buffer
 *
 * Clobbers: R0, R1, R6, R7, R8, R9
 */

.section .text
.align 2

func_066:
    /* Entry - this NOP is shared delay slot from func_065 */
    nop

    /* Load context pointers */
    mov.l   @(8,r14),r8             /* R8 = source stream pointer */
    mov.l   @(4,r14),r9             /* R9 = destination base */

    /* Load outer loop counter */
    mov.w   @r8+,r7                 /* R7 = outer iteration count */

outer_loop:
    mov     r9,r1                   /* R1 = current destination */

inner_load:
    mov.w   @r8+,r0                 /* R0 = packed (value:count) */

inner_check:
    /* Loop entry for fill_loop (delay slot preloads, skip this mov.w) */
    cmp/eq  #0,r0                   /* Check for end marker */
    bt      outer_end               /* If zero, end inner loop */

    extu.b  r0,r6                   /* R6 = count (low byte) */
    shlr8   r0                      /* R0 = value (high byte) */

    /* TST #$FF,R0 - check if value is zero */
    .word   0xC8FF                  /* GNU AS doesn't support TST #imm,R0 syntax */

    bt      skip_fill               /* If value is 0, skip fill loop */

fill_loop:
    dt      r6                      /* R6-- (decrement count) */
    bf/s    fill_loop               /* Loop while R6 != 0 */
    mov.b   r0,@-r1                 /* Delay: store byte, decrement dest */

    bra     inner_check             /* Continue with next entry */
    mov.w   @r8+,r0                 /* Delay: preload next entry */

skip_fill:
    bra     inner_load              /* Skip to next entry - need to load */
    sub     r6,r1                   /* Delay: adjust destination by count */

outer_end:
    dt      r7                      /* R7-- (decrement outer counter) */
    bf/s    outer_loop              /* Loop while R7 != 0 */
    add     r13,r9                  /* Delay: advance destination by stride */

    rts
    nop                             /* Delay slot */

/*
 * End of func_066
 */
