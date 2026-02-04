/*
 * slave_work_wrapper_v2 - Slave SH2 Work Dispatcher (with queue support)
 * ======================================================================
 * Location: Expansion ROM at $300200
 * Size: ~100 bytes (including literal pool)
 *
 * PURPOSE
 * -------
 * Slave SH2 main loop - polls COMM7 for work signals from Master/68K.
 * Dispatches based on COMM7 value:
 *   0x01 = Frame sync (increment COMM4)
 *   0x16 = Vertex transform (call slave_test_func, increment COMM5)
 *   0x27 = Queue drain (call cmd27_queue_drain) ← NEW
 *
 * PROTOCOL
 * --------
 * 1. Poll COMM7 until non-zero
 * 2. Dispatch to appropriate handler based on value
 * 3. Clear COMM7, return to polling
 *
 * REGISTER USAGE
 * --------------
 * R0 = COMM7 value / scratch
 * R1 = COMM7 address
 * R2 = comparison value / COMM address
 * R3 = function address (for JSR)
 */

        .section .text
        .align 2

        .global slave_work_wrapper_v2

slave_work_wrapper_v2:
        mov.l   .L_comm7_addr,r1        /* R1 = COMM7 address */

.poll_loop:
        mov.w   @r1,r0                  /* R0 = COMM7 value */
        tst     r0,r0                   /* Is COMM7 == 0? */
        bt      .poll_loop              /* Yes: keep polling */

        /* Work signal received - dispatch based on value */

        /* Check for frame sync (0x01) */
        mov     #1,r2
        cmp/eq  r2,r0
        bt      .frame_sync

        /* Check for vertex transform (0x16) */
        mov     #0x16,r2
        cmp/eq  r2,r0
        bt      .vertex_transform

        /* Check for queue drain (0x27) - NEW */
        mov     #0x27,r2
        cmp/eq  r2,r0
        bt      .queue_drain

.clear_and_loop:
        /* Unknown work type or handler done - clear signal */
        mov     #0,r0
        mov.w   r0,@r1                  /* COMM7 = 0 */
        bra     .poll_loop
        nop

/* ============================================================================
 * Frame Sync Handler (COMM7 = 0x01)
 * Increments COMM4 (frame counter)
 * ============================================================================ */
.frame_sync:
        mov.l   .L_comm4_addr,r2        /* R2 = COMM4 address */
        mov.w   @r2,r0                  /* R0 = COMM4 value */
        add     #1,r0                   /* Increment */
        mov.w   r0,@r2                  /* Write back */
        bra     .clear_and_loop
        nop

/* ============================================================================
 * Vertex Transform Handler (COMM7 = 0x16)
 * Calls slave_test_func, then increments COMM5
 * ============================================================================ */
.vertex_transform:
        mov.l   .L_slave_test_func,r3   /* R3 = slave_test_func address */
        jsr     @r3                     /* Call slave_test_func */
        nop
        mov.l   .L_comm5_addr,r2        /* R2 = COMM5 address */
        mov.w   @r2,r0                  /* R0 = COMM5 value */
        add     #1,r0                   /* Increment */
        mov.w   r0,@r2                  /* Write back */
        bra     .clear_and_loop
        nop

/* ============================================================================
 * Queue Drain Handler (COMM7 = 0x27) - NEW
 * Calls cmd27_queue_drain to process all queued cmd $27 entries
 * ============================================================================ */
.queue_drain:
        mov.l   .L_queue_drain_func,r3  /* R3 = cmd27_queue_drain address */
        jsr     @r3                     /* Call cmd27_queue_drain */
        nop
        bra     .clear_and_loop         /* Clear COMM7 and continue */
        nop

/* ============================================================================
 * Literal Pool (4-byte aligned)
 * ============================================================================ */
        .align 4

.L_comm7_addr:
        .long   0x2000402E              /* COMM7 register */

.L_comm4_addr:
        .long   0x20004028              /* COMM4 register */

.L_comm5_addr:
        .long   0x2000402A              /* COMM5 register */

.L_slave_test_func:
        .long   0x02300280              /* slave_test_func address */

.L_queue_drain_func:
        .long   0x02300600              /* cmd27_queue_drain address */

/* ============================================================================
 * SIZE VERIFICATION
 * ============================================================================
 * Expected size: ~80 bytes code + 20 bytes literals = ~100 bytes
 *
 * To assemble and verify:
 *   sh-elf-as --isa=sh2 -o slave_work_wrapper_v2.o slave_work_wrapper_v2.asm
 *   sh-elf-objcopy -O binary slave_work_wrapper_v2.o slave_work_wrapper_v2.bin
 *   ls -l slave_work_wrapper_v2.bin
 *
 * ============================================================================
 */

/* End of slave_work_wrapper_v2.asm */
