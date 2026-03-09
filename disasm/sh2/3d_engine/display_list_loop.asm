/*
 * func_011: Display List Processing Loop
 * ROM File Offset: 0x23220 - 0x23273 (84 bytes verified)
 * SH2 Address: 0x02223220
 *
 * Purpose: Iterates over display list entries, processing each one
 *          by calling func_012. Sets up transformation parameters
 *          from context fields before each iteration.
 *
 * Type: Coordinator/Loop
 * Called By: Higher-level rendering pipeline
 * Calls: func_012 @ $023278 (via BSR)
 *
 * Input:
 *   R14 = RenderingContext pointer
 *
 * Context Fields Used:
 *   @(2,R14)   = X scale factor
 *   @(6,R14)   = Y scale factor
 *   @(14,R14)  = Loop count (0 = skip processing)
 *
 * Note: All PC-relative instructions (BT/S, BF/S, MOV.L @(disp,PC), BSR)
 *       are manually encoded to match the original ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23220 start */

func_011:
    /* ─────────────────────────────────────────────────────────────────────────
     * Prologue and early-out check
     * ───────────────────────────────────────────────────────────────────────── */
    /* $023220 */ sts.l   pr,@-r15            /* Save return address */
    /* $023222 */ mov.w   @(14,r14),r0        /* R0 = context->count */
    /* $023224 */ cmp/eq  #0,r0               /* Is count == 0? */
    .short  0x8D1A                            /* BT/S .exit (at 0x23264) */
    /* $023228 */ mov     r0,r4               /* [delay] R4 = count */

    /* ─────────────────────────────────────────────────────────────────────────
     * Calculate scaled X coordinate: X * 4096
     * SHLL8 + SHLL2 + SHLL2 = shift left by 12 = multiply by 4096
     * ───────────────────────────────────────────────────────────────────────── */
    /* $02322A */ mov.w   @(2,r14),r0         /* R0 = context->x_scale */
    /* $02322C */ shll8   r0                  /* R0 <<= 8 */
    /* $02322E */ shll2   r0                  /* R0 <<= 2 */
    /* $023230 */ shll2   r0                  /* R0 <<= 2 (total: <<12) */
    /* $023232 */ mov     r0,r1               /* R1 = scaled_x */

    /* ─────────────────────────────────────────────────────────────────────────
     * Calculate scaled Y coordinate: Y * 4096
     * ───────────────────────────────────────────────────────────────────────── */
    /* $023234 */ mov.w   @(6,r14),r0         /* R0 = context->y_scale */
    /* $023236 */ shll8   r0                  /* R0 <<= 8 */
    /* $023238 */ shll2   r0                  /* R0 <<= 2 */
    /* $02323A */ shll2   r0                  /* R0 <<= 2 (total: <<12) */
    /* $02323C */ mov     r0,r3               /* R3 = scaled_y */

    /* ─────────────────────────────────────────────────────────────────────────
     * Setup transform buffer
     * D50B: MOV.L @(11,PC),R5 → 0x2326C (.lit_buffer_ptr)
     * D00B: MOV.L @(11,PC),R0 → 0x23270 (.lit_offset)
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD50B                            /* MOV.L @(11,PC),R5 → 0x2326C */
    /* $023240 */ mov     #0,r2               /* R2 = 0 (clear value) */
    .short  0xD00B                            /* MOV.L @(11,PC),R0 → 0x23270 */
    /* $023244 */ sub     r0,r1               /* R1 -= offset */
    /* $023246 */ add     r0,r3               /* R3 += offset */

    /* Store transform parameters */
    /* $023248 */ mov.l   r1,@(0,r5)          /* buffer[0] = scaled_x - offset */
    /* $02324A */ mov.l   r2,@(4,r5)          /* buffer[4] = 0 */
    /* $02324C */ mov.l   r3,@(8,r5)          /* buffer[8] = scaled_y + offset */

    /* $02324E */ mov     r4,r0               /* R0 = count */

    /* ─────────────────────────────────────────────────────────────────────────
     * Main loop: Process each display list entry
     * ───────────────────────────────────────────────────────────────────────── */
.loop_start:
    /* Save registers for nested call */
    /* $023250 */ mov.l   r14,@-r15           /* Save R14 (context) */
    /* $023252 */ mov.l   r7,@-r15            /* Save R7 (loop counter) */

    /* Setup for func_012 call
     * DE07: MOV.L @(7,PC),R14 → 0x23270 (.lit_offset = 0x00100000)
     * B00F: BSR func_012 (at 0x23278)
     */
    .short  0xDE07                            /* MOV.L @(7,PC),R14 → 0x23270 */
    .short  0xB00F                            /* BSR func_012 (at 0x23278) */
    /* $023258 */ mov.w   r0,@(2,r14)         /* [delay] Store param */

    /* Restore and loop */
    /* $02325A */ mov.l   @r15+,r7            /* Restore R7 */
    /* $02325C */ mov.l   @r15+,r14           /* Restore R14 */
    /* $02325E */ dt      r7                  /* R7--, set T if zero */
    .short  0x8FDF                            /* BF/S .loop_start (at 0x23250) */
    /* $023262 */ add     #60,r14             /* [delay] R14 += 60 (next entry) */

    /* ─────────────────────────────────────────────────────────────────────────
     * Exit
     * ───────────────────────────────────────────────────────────────────────── */
.exit:
    /* $023264 */ lds.l   @r15+,pr            /* Restore PR */
    /* $023266 */ rts                         /* Return */
    /* $023268 */ nop                         /* Delay slot */

/* ─────────────────────────────────────────────────────────────────────────────
 * Padding and Literal Pool
 * Aligned to 4 bytes at 0x2326C
 * ───────────────────────────────────────────────────────────────────────────── */
    .byte   0x00, 0x00                        /* Padding at 0x2326A */

.lit_buffer_ptr:
    /* $02326C */ .byte   0xC0, 0x00, 0x07, 0x70  /* 0xC0000770 - Transform buffer */

.lit_offset:
    /* $023270 */ .byte   0x00, 0x10, 0x00, 0x00  /* 0x00100000 - Offset value */

/* ============================================================================
 * End of func_011 (84 bytes: code 74 + pad 2 + literals 8)
 *
 * Note: The literal at 0x23274 (0xC0000700) belongs to func_012, not this
 * function. That literal is func_012's context pointer.
 * ============================================================================ */
