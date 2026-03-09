/*
 * func_022: Wait for Ready / Hardware Sync
 * ROM File Offset: 0x234EE - 0x23507 (26 bytes verified)
 * SH2 Address: 0x022234EE
 *
 * Purpose: Polls a hardware status register waiting for a ready
 *          flag (bit 3) to be set. Used for synchronization with
 *          VDP or frame buffer operations.
 *
 * Type: Leaf function (no calls)
 * Called By: Rendering pipeline (before frame buffer operations)
 *
 * Input:
 *   R14 = RenderingContext pointer
 *
 * Context Fields Used:
 *   @(36,R14) = Base address for status check
 *   @(28,R1)  = Status word to poll
 *
 * Output:
 *   R0 = 6 (success code)
 *   Stores result to *(R1+28)
 *
 * Behavior:
 *   Spins in tight loop until bit 3 of status word is set.
 */

.section .text
.p2align 1    /* 2-byte alignment (2^1) for 0x234EE start */

func_022:
    /* ─────────────────────────────────────────────────────────────────────────
     * Setup: Load mask (done once)
     * D005 = MOV.L @(5*4,PC),R0 - manually encoded for correct displacement
     * When linked at 0x234EE: PC = (0x234EE+4)&~3 = 0x234F0, target = PC+20 = 0x23504
     * ───────────────────────────────────────────────────────────────────────── */
    .short  0xD005                              /* MOV.L .lit_mask,R0 */

    /* ─────────────────────────────────────────────────────────────────────────
     * Setup: Load base address and apply mask (done once)
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0234F0 */ mov.l   @(36,r14),r1          /* R1 = context->field_0x24 */
    /* $0234F2 */ or      r0,r1                 /* R1 |= mask */

    /* ─────────────────────────────────────────────────────────────────────────
     * Poll loop: Wait for bit 3 to be set (loop starts here at 0x234F4)
     * ───────────────────────────────────────────────────────────────────────── */
.poll_loop:
    /* $0234F4 */ mov.w   @(28,r1),r0           /* R0 = status word at R1+28 */
    /* $0234F6 */ tst     #8,r0                 /* Test bit 3 */
    /* $0234F8 */ bt      .poll_loop            /* Loop if bit 3 is clear */

    /* ─────────────────────────────────────────────────────────────────────────
     * Ready: Store result and return
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0234FA */ mov.l   @(36,r14),r1          /* R1 = base address again */
    /* $0234FC */ mov     #6,r0                 /* R0 = 6 (ready code) */
    /* $0234FE */ rts                           /* Return */
    /* $023500 */ mov.w   r0,@(28,r1)           /* [delay] store 6 to *(R1+28) */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool
 * Manual 2-byte padding to align literal at 0x23504 when linked at 0x234EE
 * ───────────────────────────────────────────────────────────────────────────── */
    .byte   0x00, 0x00
.lit_mask:
    .byte   0x20, 0x00, 0x00, 0x00              /* 0x20000000 in big-endian */

/* ============================================================================
 * End of func_022
 * ============================================================================ */
