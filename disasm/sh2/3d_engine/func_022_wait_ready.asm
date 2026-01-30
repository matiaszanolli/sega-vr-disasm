/*
 * func_022: Wait for Ready / Hardware Sync
 * ROM File Offset: 0x234EE - 0x23500 (18 bytes)
 * SH2 Address: 0x022234EE - 0x02223500
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
 *   Updates context->field_0x1C with final value
 *
 * Behavior:
 *   Spins in tight loop until bit 3 of status word is clear.
 */

.section .text
.align 2

func_022:
    /* ─────────────────────────────────────────────────────────────────────────
     * Setup: Load mask and base address
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0234EE: D005 */ mov.l   .lit_mask,r0        /* R0 = OR mask */

    /* ─────────────────────────────────────────────────────────────────────────
     * Poll loop: Wait for bit 3 to clear
     * ───────────────────────────────────────────────────────────────────────── */
.poll_loop:
    /* $0234F0: 51E9 */ mov.l   @(36,r14),r1        /* R1 = context->field_0x24 */
    /* $0234F2: 210B */ or      r0,r1               /* R1 |= mask */
    /* $0234F4: 851E */ mov.w   @(28,r1),r0         /* R0 = status word at R1+28 */
    /* $0234F6: C808 */ tst     #8,r0               /* Test bit 3 */
    /* $0234F8: 89FC */ bt      .poll_loop          /* Loop if bit 3 is clear */

    /* ─────────────────────────────────────────────────────────────────────────
     * Ready: Store result and return
     * ───────────────────────────────────────────────────────────────────────── */
    /* $0234FA: 51E9 */ mov.l   @(36,r14),r1        /* R1 = base address again */
    /* $0234FC: E006 */ mov     #6,r0               /* R0 = 6 (ready code) */
    /* $0234FE: 000B */ rts                         /* Return */
    /* $023500: 811E */ mov.w   r1,@(28,r14)        /* [delay] context->field_0x1C = R1 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool
 * ───────────────────────────────────────────────────────────────────────────── */
.align 4
.lit_mask:
    /* $023504: */ .long   0x00002000          /* OR mask for address setup */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Polling Pattern:
 *    Classic busy-wait loop checking hardware status.
 *    Tests bit 3 (mask 0x08) of status word.
 *    Continues until bit is SET (TST returns true when AND==0).
 *
 * 2. Wait Condition:
 *    The TST #8,R0 / BT loop means:
 *    - TST sets T=1 when (R0 AND 8) == 0 (bit 3 clear)
 *    - BT branches when T=1 (bit 3 clear)
 *    - Loop exits when bit 3 is SET
 *
 * 3. Likely Purpose:
 *    - Wait for VDP to finish previous operation
 *    - Wait for frame buffer flip to complete
 *    - Synchronize with vertical blank
 *
 * 4. Return Code:
 *    Returns R0=6, possibly indicating:
 *    - Number of retries (hardcoded)
 *    - Success status code
 *    - Next state in state machine
 *
 * 5. Performance Impact:
 *    Busy-waiting consumes CPU cycles. In async architecture,
 *    this function could be a target for replacement with
 *    interrupt-driven notification.
 *
 * ============================================================================ */
