/*
 * Master SH2 Command Loop - Core Polling and Dispatch
 * ROM File Offset: 0x20450 - 0x20490 (64 bytes)
 * SH2 Address: 0x02020450 - 0x02020490
 *
 * Purpose: Main polling loop where Master SH2 waits for 68K commands
 *          via COMM registers, then dispatches to appropriate handlers.
 *
 * This is the CRITICAL path for 68K→SH2 communication.
 * Understanding this is essential for async optimization.
 *
 * COMM Register Layout (from Master SH2 perspective):
 *   COMM0 ($20004020): Handshake signal (68K sets non-zero when command ready)
 *   COMM1 ($20004021): Command byte (function number to execute)
 *   COMM2 ($20004022): Status/flags
 *   COMM3 ($20004023): Reserved
 *   COMM4 ($20004024): Parameter pointer (low word)
 *   COMM5 ($20004026): Parameter pointer (high word) / counter
 *   COMM6 ($20004028): Trigger/busy flag
 *   COMM7 ($2000402A): Frame sync / work signal
 *
 * Register Usage:
 *   R8 = COMM base address ($20004020)
 *   R0 = Temp / command value
 *   R1 = Jump table base
 *   R4 = Command byte from COMM1
 */

.section .text
.align 2

/* ============================================================================
 * Pre-loop setup ($020450-$02045E)
 * Clears COMM registers and prepares for polling
 * ============================================================================ */
master_init_comm:
    /* $020450: D10A */ mov.l   comm_base_addr,r1       /* R1 = 0x20004020 (COMM base) */
    /* $020452: 5018 */ mov.l   @(32,r0),r0             /* Load something? */
    /* $020454: 8800 */ cmp/eq  #0,r0                   /* Test if zero */
    /* $020456: 8BFC */ bf      master_init_comm        /* Loop if not zero (wait?) */
    /* $020458: E000 */ mov     #0,r0                   /* R0 = 0 */
    /* $02045A: 1109 */ mov.l   r0,@(36,r1)             /* Clear COMM9? */
    /* $02045C: E020 */ mov     #32,r0                  /* R0 = 0x20 (32) */
    /* $02045E: 400E */ ldc     r0,sr                   /* Set status register */

/* --- Phase 1: Enable CMDINT (Command Interrupt) ---
 * The 32X has two interrupt mask mechanisms:
 * 1. SH2 SR register (I mask bits 3-0) - set above to level 2
 * 2. 32X interrupt mask register at $20004000 - CMD bit must be enabled
 * Both must be configured for CMDINT to fire.
 */
    mov.l   int_mask_reg,r1             /* R1 = 0x20004000 (interrupt mask register) */
    mov.w   @r1,r0                      /* Read current mask value */
    or      #0x08,r0                    /* Set CMD bit (bit 3, enables CMDINT) */
    mov.w   r0,@r1                      /* Write back */

/* ============================================================================
 * Main Polling Loop ($020460-$020476)
 * Waits for COMM0 != 0, then dispatches command
 * ============================================================================ */
master_poll_loop:
    /* $020460: D809 */ mov.l   comm_base_literal,r8    /* R8 = COMM base (0x20004020) */
.poll_wait:
    /* $020462: 6080 */ mov.b   @r8,r0                  /* R0 = COMM0 (handshake byte) */
    /* $020464: 8800 */ cmp/eq  #0,r0                   /* Is COMM0 == 0? */
    /* $020466: 89FB */ bt      .poll_wait              /* Yes: keep polling (-5 = $020462) */

    /* Command received - COMM0 is non-zero */
    /* $020468: 8481 */ mov.b   @(1,r8),r4              /* R4 = COMM1 (command byte) */

/* Original dispatch code (could be hooked for expansion ROM) */
.dispatch:
    /* $02046A: 4008 */ shll2   r0                      /* R0 = R0 * 4 (table index) */
    /* $02046C: D107 */ mov.l   jump_table_addr,r1     /* R1 = jump table base */
    /* $02046E: 001E */ mov.l   @(r0,r1),r0            /* R0 = table[cmd] (handler addr) */
    /* $020470: 400B */ jsr     @r0                    /* Call handler */
    /* $020472: 0009 */ nop                            /* Delay slot */
    /* $020474: AFF4 */ bra     master_poll_loop       /* Loop back (-12 = $020460) */
    /* $020476: 0009 */ nop                            /* Delay slot */

/* ============================================================================
 * Literal Pool (4-byte aligned)
 * ============================================================================ */
.align 4
int_mask_reg:
    .long 0x20004000          /* Phase 1: Interrupt mask register */
    /* $020478: FFFF FE10 */ .long 0xFFFFFE10          /* ? */
comm_base_literal:
    /* $02047C: 2000 4000 */ .long 0x20004020          /* COMM base address */
                            /* Note: Listed as 0x20004000 but should be 0x20004020? */
    /* $020480: 0600 45CC */ .long 0x060045CC          /* Some handler address */
    /* $020484: 0600 FF80 */ .long 0x0600FF80          /* Another address */
comm_base_addr:
    /* $020488: 2000 4020 */ .long 0x20004020          /* COMM base address */
jump_table_addr:
    /* $02048C: 0600 0780 */ .long 0x06000780          /* Jump table in SDRAM */

/*
 * Jump Table Location: 0x06000780
 * Contains 256 handler addresses (one per command byte)
 * Each entry is 4 bytes (32-bit address)
 *
 * Example entries:
 *   table[0x00] = idle handler
 *   table[0x01] = init command
 *   table[0x16] = vertex transform (our optimization target)
 *   ...etc
 */

/* ============================================================================
 * Analysis Notes:
 *
 * 1. POLLING OVERHEAD
 *    The poll_wait loop consumes cycles while waiting for 68K:
 *    - mov.b @r8,r0  (1 cycle)
 *    - cmp/eq #0,r0  (1 cycle)
 *    - bt .poll_wait (2 cycles if taken)
 *    = 4 cycles per iteration minimum
 *
 *    If 68K takes 1000 cycles to prepare next command:
 *    Master SH2 burns ~250 poll iterations = wasted CPU time
 *
 * 2. HOOK OPPORTUNITY
 *    The dispatch at $02046A could redirect to expansion ROM:
 *    - Check command type
 *    - For certain commands, redirect to custom handlers
 *    - Return to original flow for others
 *
 * 3. ASYNC POTENTIAL
 *    Instead of busy-waiting in poll_loop:
 *    - Could use interrupt-driven command notification
 *    - Or: Master does useful work while polling (interleaved)
 *
 * ============================================================================ */
