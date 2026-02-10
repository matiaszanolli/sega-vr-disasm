/*
 * SH2 Interrupt Handler Template — Mandatory Workaround Pattern
 * ==============================================================
 *
 * REFERENCE ONLY — Not included in the build.
 * Copy and adapt this template when writing any new SH2 interrupt handler.
 *
 * SOURCE: 32X Hardware Manual Supplement 2 (Doc. MAR-32-R4-SP2-072694)
 * See: docs/32x-hardware-manual-supplement-2.md
 *
 * THE BUG
 * -------
 * Original SH2 silicon (EVA chip cut < 2.5) has a hardware bug where:
 *   1. External interrupts can be MISSED during the acknowledge period
 *      of other interrupts
 *   2. The WRONG interrupt vector can be jumped to when multiple
 *      interrupts arrive simultaneously
 *
 * THE WORKAROUND (mandatory for ALL external interrupt handlers)
 * ---------------------------------------------------------------
 *   1. Toggle FRT TOCR bit 1 (XOR #$02) — fixes interrupt recognition
 *   2. Clear the interrupt source register
 *   3. Read back the clear register (synchronization — forces write completion)
 *   4. Ensure 1+ cycle gap between sync read and RTE
 *   5. Handler body must consume 5+ clocks (between TOCR toggle and RTE)
 *
 * APPLIES TO: VINT, HINT, CMDINT, PWMINT handlers on Master and Slave SH2.
 * Does NOT apply to internal peripheral interrupts (FRT, SCI, etc.)
 *
 * INTERRUPT CLEAR REGISTERS (SH2 addresses, cache-through):
 *   VRES  = 0x20004014
 *   VINT  = 0x20004016
 *   HINT  = 0x20004018
 *   CMD   = 0x2000401A
 *   PWM   = 0x2000401C
 *
 * INTERRUPT LEVELS (only use these — other levels trigger the bug):
 *   Level 14: VRES (reset)
 *   Level 12: VINT (vertical blank)
 *   Level 10: HINT (horizontal blank)
 *   Level  8: CMD  (command from 68K)
 *   Level  6: PWM  (pulse width modulation)
 *
 * TIMING REQUIREMENTS:
 *   External interrupt → RTE:    1 cycle between sync read and RTE
 *   External interrupt → LDC SR: 4 cycles between sync read and LDC
 *   Internal interrupt → RTE:    1 cycle margin (automatic)
 *   Internal interrupt → LDC SR: 2 cycles between sync read and LDC
 *
 * FRT REGISTER MAP:
 *   Base: 0xFFFFFE10 (on-chip, NOT cache-through)
 *     +0x00  TIER  (Timer Interrupt Enable Register)
 *     +0x01  TCSR  (Timer Control & Status Register)
 *     +0x02  FRC_H (Free Running Counter High)
 *     +0x03  FRC_L (Free Running Counter Low)
 *     +0x04  OCR_H (Output Compare Register High)
 *     +0x05  OCR_L (Output Compare Register Low)
 *     +0x06  TCR   (Timer Control Register)
 *     +0x07  TOCR  (Timer Output Compare Control Register) ← toggle bit 1
 *
 * NOTE: cmdint_handler.asm uses cache-through base 0xFFFFFF80 with offset 14
 *       (0xFFFFFF80 + 0x0E = 0xFFFFFF8E). This is equivalent but accesses via
 *       a different address alias. Both work. The canonical on-chip address is
 *       0xFFFFFE10 + 0x07 = 0xFFFFFE17.
 *       We use the 0xFFFFFF80 + 14 form to match the Sega sample code.
 */

.section .text
.align 2

/* =====================================================================
 * TEMPLATE: Generic SH2 External Interrupt Handler
 * Replace <HANDLER_NAME>, <CLEAR_REG>, and "handler body" with your code.
 * ===================================================================== */

<HANDLER_NAME>:
    /* --- Save context --- */
    sts.l   pr,@-r15            /* Push PR (return address for JSR) */
    mov.l   r0,@-r15            /* Push R0 */
    mov.l   r1,@-r15            /* Push R1 */
    /* Push additional registers as needed (R2, R3, ...) */

    /* --- MANDATORY: FRT TOCR Toggle (Hardware Bug Workaround) --- */
    /* This MUST be the FIRST thing after saving context.           */
    /* Do NOT skip this even if "it works in the emulator" — real   */
    /* hardware will intermittently miss interrupts without it.     */
    mov.l   _frt_base,r1       /* R1 = 0xFFFFFF80 */
    mov.b   @(14,r1),r0        /* R0 = TOCR (base + 0x0E) */
    xor     #0x02,r0           /* Toggle bit 1 */
    mov.b   r0,@(14,r1)        /* Write back TOCR */

    /* --- Handler body --- */
    /* Your interrupt processing logic goes here.                   */
    /* Must consume at least 5 clocks total (TOCR toggle to RTE).  */
    /* The save/restore + TOCR toggle already consumes ~8 cycles,   */
    /* so any non-trivial handler body satisfies this requirement.  */
    nop                         /* Placeholder — replace with real work */

    /* --- Clear interrupt source --- */
    /* Each interrupt type has its own clear register.              */
    /* Writing any value clears the pending interrupt flag.         */
    mov.l   _int_clear,r1      /* R1 = interrupt clear register address */
    mov.w   _clear_val,r0      /* R0 = any value (e.g., 0x0001) */
    mov.w   r0,@r1             /* Write to clear interrupt */

    /* --- Synchronization read-back --- */
    /* MANDATORY: Read the clear register to force the write to     */
    /* complete through the bus. Without this, the interrupt flag    */
    /* may still be pending when RTE executes, causing re-entry.    */
    mov.w   @r1,r0             /* Sync read (1 cycle between this and RTE) */

    /* --- Restore context --- */
    /* Pop additional registers in reverse order */
    mov.l   @r15+,r1           /* Pop R1 */
    mov.l   @r15+,r0           /* Pop R0 */
    lds.l   @r15+,pr           /* Pop PR */

    /* --- Return from interrupt --- */
    /* The restore sequence above provides the required 1+ cycle    */
    /* gap between the sync read and RTE. If you remove the         */
    /* register restores (e.g., no registers to save), you MUST     */
    /* insert a NOP between the sync read and RTE.                  */
    rte                         /* Return to interrupted code */
    nop                         /* Delay slot (MANDATORY for SH2 RTE) */

/* =====================================================================
 * Literal Pool (must be 4-byte aligned, within 256 bytes of references)
 * ===================================================================== */
.align 4
_frt_base:
    .long 0xFFFFFF80            /* FRT access base (cache-through alias) */
_int_clear:
    .long 0x2000401A            /* <-- Replace with correct clear register:
                                 *     VRES=0x20004014  VINT=0x20004016
                                 *     HINT=0x20004018  CMD =0x2000401A
                                 *     PWM =0x2000401C                   */
_clear_val:
    .word 0x0001                /* Any non-zero value clears the flag */

.align 2
