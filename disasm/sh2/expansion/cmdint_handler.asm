/*
 * CMDINT Handler - Master SH2 Command Interrupt Handler
 * ROM File Offset: Expansion ROM $300800
 * SH2 Address: 0x02300800 (expansion ROM cached)
 *
 * PURPOSE
 * -------
 * Handles CMDINT (command interrupt) from 68K CPU. The 68K triggers this
 * interrupt when it queues commands in the ring buffer at $2203F000.
 *
 * The handler processes ONE queue entry per interrupt, then returns.
 * If the queue is still non-empty after RTE, another CMDINT fires immediately.
 *
 * CRITICAL: SH2 INTERRUPT BUG WORKAROUND
 * ---------------------------------------
 * All external interrupt handlers MUST include FRT TOCR toggle.
 * From 32X Hardware Manual Supplement 2 (Doc. MAR-32-R4-SP2-072694):
 *
 * Without this workaround, interrupt recognition fails intermittently
 * on retail 32X hardware (EVA chip cut < 2.5).
 *
 * PROTOCOL
 * --------
 * 1. Save registers (PR, R0-R3)
 * 2. MANDATORY: Toggle FRT TOCR bit 1 (hardware bug workaround)
 * 3. Call queue_processor to dequeue and forward one command
 * 4. Clear CMDINT flag at $2000401A
 * 5. Synchronization: read back clear register (ensures write completes)
 * 6. Restore registers
 * 7. RTE (return from interrupt)
 *
 * REGISTER USAGE
 * --------------
 * Modified: PR, R0-R3 (saved/restored)
 * Preserved: R4-R15
 *
 * EXIT CONDITIONS
 * ---------------
 * - One queue entry processed (tail pointer advanced)
 * - CMDINT flag cleared
 * - If queue still non-empty, another CMDINT fires after RTE
 *
 * REFERENCES
 * ----------
 * - 32X Hardware Manual, §1.15 (Interrupt configuration)
 * - 32X Hardware Manual Supplement 2 (SH2 interrupt bug)
 * - Phase 1 Implementation Plan (CMDINT handler specification)
 */

.section .text
.align 2

cmdint_handler:
    /* Save context */
    sts.l   pr,@-r15            /* Push return address */
    mov.l   r0,@-r15            /* Push R0 */
    mov.l   r1,@-r15            /* Push R1 */
    mov.l   r2,@-r15            /* Push R2 */
    mov.l   r3,@-r15            /* Push R3 */

    /* =================================================================
     * CRITICAL: FRT TOCR TOGGLE (Hardware Bug Workaround)
     * =================================================================
     * This is MANDATORY for all external interrupt handlers.
     * Without this, interrupt recognition fails intermittently.
     *
     * FRT (Free-Running Timer) base: 0xFFFFFF80 (cache-through)
     * TOCR (Timer Output Compare Control Register) offset: 0x0E
     * Toggle bit 1 of TOCR
     */
    mov.l   frt_base,r1         /* R1 = 0xFFFFFF80 (FRT base, cache-through) */
    mov.b   @(14,r1),r0         /* R0 = TOCR (offset 0x0E) */
    xor     #0x02,r0            /* Toggle bit 1 */
    mov.b   r0,@(14,r1)         /* Write back TOCR */

    /* Process one queue entry */
    mov.l   queue_proc_addr,r0  /* R0 = queue_processor address */
    jsr     @r0                 /* Call queue_processor */
    nop                         /* Delay slot */

    /* Clear CMDINT flag */
    mov.l   cmdint_clear,r1     /* R1 = 0x2000401A (CMD Interrupt Clear Register) */
    mov.w   clear_value,r0      /* R0 = 0x0001 (any value clears interrupt) */
    mov.w   r0,@r1              /* Write to clear register */

    /* Synchronization: read back to ensure write completes
     * Hardware manual requires 2+ cycles between clear and RTE */
    mov.w   @r1,r0              /* Dummy read (forces write completion) */

    /* Restore context */
    mov.l   @r15+,r3            /* Pop R3 */
    mov.l   @r15+,r2            /* Pop R2 */
    mov.l   @r15+,r1            /* Pop R1 */
    mov.l   @r15+,r0            /* Pop R0 */
    lds.l   @r15+,pr            /* Pop return address */

    /* Return from interrupt */
    rte                         /* Return to interrupted code */
    nop                         /* Delay slot */

/* ========================================================================
 * Literal Pool (4-byte aligned)
 * ======================================================================== */
.align 4
frt_base:
    .long 0xFFFFFF80            /* FRT base address (cache-through) */
cmdint_clear:
    .long 0x2000401A            /* CMD Interrupt Clear Register */
queue_proc_addr:
    .long 0x02300C00            /* queue_processor at expansion ROM $300C00 */
clear_value:
    .word 0x0001                /* Value to write to clear register */

.align 2
