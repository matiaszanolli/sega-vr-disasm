/*
 * shadow_path_wrapper: Shadow Path Instrumentation Wrapper
 * ROM File Offset: 0x300400 (expansion ROM)
 * SH2 Address: 0x02300400
 * Size: ~80 bytes (expanded for barriers)
 *
 * FIXED: Moved counters from COMM6 to dedicated RAM at 0x2203E010
 * ADDED: Per-call barrier (wait for COMM7 == 0 before signaling)
 */

.section .text
.align 2

shadow_path_wrapper:
        /* Preserve caller return address across internal JSR */
        sts.l   pr,@-r15

        /* BARRIER: Wait for Slave to clear COMM7 from previous call */
        mov.l   .L_comm7_addr,r0
.wait_slave_ready:
        mov.w   @r0,r1                  /* Read COMM7 */
        tst     r1,r1                   /* Is COMM7 == 0? */
        bf      .wait_slave_ready       /* Loop until Slave clears it */

        /* Increment Master call counter in RAM (NOT COMM6) */
        mov.l   .L_master_counter_addr,r0
        mov.w   @r0,r1                  /* Read counter */
        add     #1,r1                   /* Increment */
        mov.w   r1,@r0                  /* Write back */

        /* Write parameters to shared block */
        mov.l   .L_param_block_addr,r0
        mov.l   r14,@r0                 /* param[0] = R14 */
        mov.l   r7,@(4,r0)              /* param[1] = R7 */
        mov.l   r8,@(8,r0)              /* param[2] = R8 */
        mov.l   r5,@(12,r0)             /* param[3] = R5 */

        /* Signal Slave via COMM7 (now safe - barrier passed) */
        mov.l   .L_comm7_addr,r0
        mov     #0x16,r1                /* Signal value */
        mov.w   r1,@r0                  /* COMM7 = 0x16 */

        /* Call original func_021 (Master path) */
        mov.l   .L_func_orig_addr,r0
        jsr     @r0                     /* Call original */
        nop
        lds.l   @r15+,pr
        rts
        nop

        /* Literal pool (4-byte aligned) */
        .align 4
.L_master_counter_addr:
        .long   0x2203E010              /* Master counter address (RAM, NOT COMM) */
.L_param_block_addr:
        .long   0x2203E000              /* Parameter block */
.L_comm7_addr:
        .long   0x2000402E              /* COMM7 address */
.L_func_orig_addr:
        .long   0x02300300              /* func_021_original_relocated */
