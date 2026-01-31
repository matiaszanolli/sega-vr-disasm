/*
 * func_017: Quad Processing Helper
 * ROM File Offset: 0x2338A - 0x233A3 (26 bytes verified)
 * SH2 Address: 0x0222338A
 *
 * Purpose: Small helper function for quad processing.
 *          Calls func_016 (coordinate packing) then loops over data,
 *          decrementing a counter and adjusting pointers.
 *
 * Type: Helper/Coordinator
 * Called By: func_018, func_019 (quad batch processors)
 * Calls: func_016 (via BSR at 0x23368)
 *
 * Input:
 *   R14 = RenderingContext pointer (for func_016)
 *   R10 = Output pointer
 *   R7  = Loop counter
 *   R11 = State/context pointer
 *
 * Stack Usage:
 *   Saves: PR (for BSR call)
 *
 * Note: BF at 0x23394 branches to 0x233A4 (func_018 entry) for early exit
 *       when output byte is non-zero. This is unusual shared control flow.
 */

.section .text
.p2align 1    /* 2-byte alignment (2^1) for 0x2338A start */

func_017:
    /* ─────────────────────────────────────────────────────────────────────
     * Call func_016 for coordinate packing
     * BSR manually encoded: target=0x23368, PC+4=0x23390, disp=-20
     * ───────────────────────────────────────────────────────────────────── */
    /* $02338A */ sts.l   pr,@-r15            /* Save return address */
    .short  0xBFEC                            /* BSR func_016 (at 0x23368) */
    /* $02338E */ nop                         /* Delay slot */

.loop_start:
    /* ─────────────────────────────────────────────────────────────────────
     * Check and loop
     * BF manually encoded: target=0x233A4 (func_018), PC+4=0x23398, disp=6
     * ───────────────────────────────────────────────────────────────────── */
    /* $023390 */ mov.l   @r10,r0             /* Load long from output ptr */
    /* $023392 */ cmp/eq  #0,r0               /* Is it zero? */
    .short  0x8B06                            /* BF +6 (to 0x233A4/func_018) */
    /* $023396 */ add     #-4,r10             /* R10 -= 4 (move pointer) */
    /* $023398 */ dt      r7                  /* Decrement R7, set T if zero */
    /* $02339A */ bf/s    .loop_start         /* Loop if R7 != 0 */
    /* $02339C */ add     #-64,r11            /* [delay] R11 -= 64 */

    /* ─────────────────────────────────────────────────────────────────────
     * Normal return (loop exhausted)
     * ───────────────────────────────────────────────────────────────────── */
    /* $02339E */ lds.l   @r15+,pr            /* Restore PR */
    /* $0233A0 */ rts
    /* $0233A2 */ nop                         /* Delay slot */

/* ============================================================================
 * End of func_017 (26 bytes)
 * ============================================================================ */
