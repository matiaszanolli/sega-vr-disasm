/*
 * slave_comm7_idle_check - COMM7 Doorbell Handler for Slave Idle Loop
 * ===================================================================
 * Location: Expansion ROM at $300700 (SH2 address: 0x02300700)
 * Size: ~56 bytes (18 words code + 8 words literals)
 *
 * PURPOSE
 * -------
 * Replaces the Slave SH2's 64-NOP delay loop. Instead of burning idle
 * cycles, checks COMM7 for doorbell signals and dispatches accordingly.
 *
 * When COMM7 != 0: clears COMM7, drains BOTH queues:
 *   1. cmd27_queue_drain at $300600 (pixel work for cmd $27)
 *   2. general_queue_drain at $301000 (COMM protocol replay for $22/$25/$2F/$21)
 * Then returns to the Slave's command_loop at $06000592.
 *
 * When COMM7 = 0: returns directly to command_loop (no delay needed
 * since the JMP overhead provides sufficient bus spacing).
 *
 * INTEGRATION
 * -----------
 * The Slave's delay loop at $020608 is replaced with a 12-byte
 * trampoline: MOV.L @(disp,PC),R3 / JMP @R3 / NOP + literal.
 * This preserves the original COMM1 command dispatch entirely.
 *
 * RACE SAFETY
 * -----------
 * COMM7 is cleared BEFORE calling drain functions. This allows the
 * 68K to ring the doorbell again while the Slave is draining. Both
 * drain loops re-read write_idx each iteration, so new entries added
 * during drain are processed.
 *
 * REGISTER USAGE
 * --------------
 * Destroyed: R0-R12 (via general_queue_drain), R3
 * Preserved: R15 (stack), PR (via stack if JSR path taken)
 *
 * NOTE: No registers need preservation for the return to command_loop,
 * because command_loop reloads all state (COMM1 addr, etc.) each iteration.
 */

        .section .text
        .align 2

        .global slave_comm7_idle_check

slave_comm7_idle_check:
        /* Load COMM7 address and read current value */
        mov.l   .L_comm7_addr,r1        /* R1 = 0x2000402E (COMM7) */
        mov.w   @r1,r0                  /* R0 = COMM7 value */
        tst     r0,r0                   /* Is COMM7 == 0? */
        bt      .L_idle                 /* Yes: nothing to do, return to command_loop */

        /* COMM7 != 0: clear doorbell and drain queue */
        mov     #0,r0
        mov.w   r0,@r1                  /* COMM7 = 0 (open doorbell for 68K) */

        sts.l   pr,@-r15               /* Save PR (for JSR return) */
        mov.l   .L_drain_addr,r3        /* R3 = cmd27_queue_drain (0x02300600) */
        jsr     @r3                     /* Drain all queued cmd $27 entries */
        nop                             /* Delay slot */
        mov.l   .L_gen_drain_addr,r3    /* R3 = general_queue_drain (0x02301000) */
        jsr     @r3                     /* Drain general command queue */
        nop                             /* Delay slot */
        lds.l   @r15+,pr               /* Restore PR */

.L_idle:
        /* Return to Slave command_loop (polls COMM1 for game commands) */
        mov.l   .L_cmdloop_addr,r3      /* R3 = command_loop (0x06000592) */
        jmp     @r3                     /* Jump (not call - no return) */
        nop                             /* Delay slot */

/* Literal pool (must be 4-byte aligned) */
        .align 4

.L_comm7_addr:
        .long   0x2000402E              /* COMM7 register (SH2 address) */

.L_drain_addr:
        .long   0x02300600              /* cmd27_queue_drain in expansion ROM */

.L_gen_drain_addr:
        .long   0x02301000              /* general_queue_drain in expansion ROM */

.L_cmdloop_addr:
        .long   0x06000592              /* Slave command_loop in SDRAM */

/* End of slave_comm7_idle_check.asm */
