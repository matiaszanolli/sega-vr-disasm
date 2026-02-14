/*
 * Slave SH2 Command Dispatcher
 * ROM File Offset: 0x20570 - 0x20612 (162 bytes)
 * SDRAM Address: 0x06000570 - 0x06000612 (copied at boot)
 * SH2 ROM Address: 0x02020570 - 0x02020612
 *
 * Purpose: Main command polling loop for Slave SH2.
 *          Polls COMM1 for work commands from Master 68K.
 *          When no work available (COMM1==0), enters delay loop.
 *          When command received, dispatches to handler via jump table.
 *
 * This is why the profiler shows 66.5% of Slave time at $0600060A:
 * The Slave spends most of its time WAITING for work because:
 *   1. The 68K→Master SH2 blocking command model serializes rendering
 *   2. The Slave only gets activated for specific parallel tasks
 *   3. Most rendering work is done by Master SH2 alone
 *
 * The delay loop is NOT a performance bug - it's the symptom of
 * architectural underutilization of the Slave SH2.
 *
 * See: analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md
 *
 * Register Usage:
 *   R0  = Command byte / scratch
 *   R1  = COMM register address (0x20004024 = COMM1)
 *   R2  = Command × 4 (jump table index)
 *   R7  = Delay loop counter (64 iterations)
 *   R14 = System registers base
 *   R15 = Stack pointer
 *
 * COMM Protocol (Original Game):
 *   COMM1 = 0x00: No work (Slave idles)
 *   COMM1 != 0:   Command ID for Slave to execute
 */

.section .text
.align 2

/* ============================================================================
 * Slave Initialization ($020570-$02058F)
 * Sets up stack, VBR, waits for Master ready signal
 * ============================================================================ */
slave_init:
    /* $020570: D110 */ mov.l   stack_init,r1           /* R1 = stack address */
    /* $020572: D011 */ mov.l   init_marker,r0          /* R0 = "INIT" marker */
    /* $020574: 2102 */ mov.l   r0,@r1                  /* Write marker to stack */
    /* $020576: D011 */ mov.l   init_func_addr,r0       /* R0 = init function */
    /* $020578: 400B */ jsr     @r0                     /* Call init function */
    /* $02057A: 0009 */ nop                             /* Delay slot */
    /* $02057C: DF10 */ mov.l   stack_addr,r15          /* R15 = stack pointer */
    /* $02057E: DE0C */ mov.l   sys_regs_base,r14       /* R14 = system registers */
    /* $020580: 85E0 */ mov.w   @(0,r14),r0             /* Read status */
    /* $020582: CB02 */ or      #0x02,r0                /* Set ready bit */
    /* $020584: 81E0 */ mov.w   r0,@(0,r14)             /* Write back */
    /* $020586: D10A */ mov.l   master_ready_addr,r1    /* R1 = Master ready addr */
.wait_master:
    /* $020588: 5019 */ mov.l   @(0x24,r1),r0           /* Read Master status */
    /* $02058A: 8800 */ cmp/eq  #0,r0                   /* Is it 0? */
    /* $02058C: 8BFC */ bf      .wait_master            /* Loop until 0 */
    /* $02058E: E020 */ mov     #0x20,r0                /* VBR value */
    /* $020590: 400E */ ldc     r0,vbr                  /* Set Vector Base Register */

/* ============================================================================
 * Command Dispatcher Loop ($020592-$0205A8)
 * Polls COMM1 for commands, dispatches or idles
 * ============================================================================ */
.command_loop:
    /* $020592: D10C */ mov.l   comm1_addr,r1           /* R1 = 0x20004024 (COMM1) */
    /* $020594: 6010 */ mov.b   @r1,r0                  /* R0 = COMM1 value */
    /* $020596: 8800 */ cmp/eq  #0,r0                   /* Is COMM1 == 0? */
    /* $020598: 8936 */ bt      .delay_loop             /* Yes: no work, go idle */

    /* Command received - dispatch to handler */
    /* $02059A: 6203 */ mov     r0,r2                   /* R2 = command ID */
    /* $02059C: C70A */ mova    @(0x28,pc),r0           /* R0 = jump table base */
    /* $02059E: 4208 */ shll2   r2                      /* R2 = command × 4 */
    /* $0205A0: 002E */ mov.b   @(r0,r2),r0             /* R0 = handler address */
    /* $0205A2: 400B */ jsr     @r0                     /* Call command handler */
    /* $0205A4: 0009 */ nop                             /* Delay slot */
    /* $0205A6: AFF4 */ bra     .command_loop           /* Loop back */
    /* $0205A8: 0009 */ nop                             /* Delay slot */

/* ============================================================================
 * Jump Table / Literal Pool ($0205AA-$0205C8)
 * Contains addresses for command handlers and system registers
 * ============================================================================ */
.align 4
.literal_pool_1:
    /* $0205AA */ .word   0x0000              /* Padding */
    /* $0205AC */ .long   0xFFFFFE10          /* ? */
    /* $0205B0 */ .long   0x20004000          /* sys_regs_base: System registers */
    /* $0205B4 */ .long   0x2600F180          /* stack_init: Stack marker address */
    /* $0205B8 */ .long   0x494E4954          /* init_marker: "INIT" ASCII */
    /* $0205BC */ .long   0x060045CC          /* init_func_addr: Init function */
    /* $0205C0 */ .long   0x06010000          /* stack_addr: Stack pointer value */
    /* $0205C4 */ .long   0x20004024          /* comm1_addr: COMM1 register */

/* Jump table entries ($0205C8-$020606) */
.jump_table:
    /* $0205C8 */ .long   0x06000608          /* cmd 0: delay loop (idle) */
    /* $0205CC */ .long   0x060039F0          /* cmd 1: handler */
    /* $0205D0 */ .long   0x06000FA8          /* cmd 2: handler */
    /* $0205D4 */ .long   0x06001384          /* cmd 3: handler */
    /* $0205D8 */ .long   0x06000D88          /* cmd 4: handler */
    /* $0205DC */ .long   0x06001380          /* cmd 5: handler */
    /* $0205E0 */ .long   0x0600135C          /* cmd 6: handler */
    /* $0205E4 */ .long   0x06000DA8          /* cmd 7: handler */
    /* $0205E8 */ .long   0x06000608          /* cmd 8+: back to delay */
    /* ... more entries pointing to 0x06000608 ... */

/* ============================================================================
 * Delay Loop / Idle State ($020608-$020612)
 *
 * PROFILER HOTSPOT: $0600060A consumes 66.5% of Slave cycles
 *
 * This is NOT a bug - it's the Slave waiting for work.
 * The Slave polls COMM1, and when no command is pending,
 * it burns 64 NOP cycles before checking again.
 *
 * Reducing the delay would just increase bus contention
 * from more frequent COMM1 reads. The real fix is giving
 * the Slave actual rendering work to do.
 * ============================================================================ */
.delay_loop:
    /* REPLACED: 64-NOP idle loop → JMP to expansion ROM COMM7 handler.
     * The expansion handler at 0x02300700 checks COMM7 for doorbell
     * signals ($0027 = cmd27 queue drain), then returns to .command_loop.
     * Original COMM1 command dispatch is preserved (trampoline only
     * replaces the idle path). Same 12 bytes as original delay loop.
     *
     * Original code was:
     *   $020608: E740  MOV #64,R7
     *   $02060A: 0009  NOP           (66.5% profiler hotspot)
     *   $02060C: 4710  DT R7
     *   $02060E: 8BFC  BF .delay_spin
     *   $020610: AFBF  BRA .command_loop
     *   $020612: 0009  NOP
     */
    /* $020608: D301 */ mov.l   .L_comm7_handler,r3     /* R3 = expansion handler addr */
    /* $02060A: 432B */ jmp     @r3                     /* Jump to COMM7 idle check */
    /* $02060C: 0009 */ nop                             /* Delay slot */
    /* $02060E: 0009 */ nop                             /* Align literal to 4 bytes */

    /* Literal: expansion handler at 0x02300700 */
.L_comm7_handler:
    /* $020610 */ .long  0x02300700

/* ============================================================================
 * Analysis Notes
 *
 * Why the Slave is idle 66.5% of the time:
 *
 * 1. The original game architecture uses a BLOCKING command model:
 *    - 68K sends command to Master SH2
 *    - 68K WAITS for Master to complete
 *    - Slave gets no work during this time
 *
 * 2. The Slave is only activated for specific operations:
 *    - VDP palette loads
 *    - Some data copies
 *    - NOT used for polygon rendering (Master does all transforms)
 *
 * 3. The v4.0 expansion ROM addresses this by:
 *    - Redirecting Slave to slave_work_wrapper @ $300200
 *    - Having Master signal Slave via COMM7 for parallel vertex transforms
 *    - Allowing true parallel processing between Master and Slave
 *
 * OPTIMIZATION STATUS (see DELAY_ELIMINATION_TEST_RESULTS.md):
 * ─────────────────────────────────────────────────────────────
 * The delay loop CAN be safely reduced (tested: 64→1 iterations):
 *   - No hardware timing dependencies (pure busy-wait)
 *   - No synchronization primitives affected
 *   - Slave cycles: 300K → 100K per frame (-66.6%)
 *   - Slave utilization: 78% → 26% (52% headroom gained)
 *   - Bottleneck shifts from Slave → Master
 *
 * TO APPLY: Change MOV #64,R7 to MOV #1,R7 at $020608:
 *   Original: E740 (64 iterations)
 *   Patched:  E701 (1 iteration)
 *
 * REQUIRES: Gameplay validation before deployment.
 * ─────────────────────────────────────────────────────────────
 *
 * See: analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md
 * See: analysis/profiling/DELAY_ELIMINATION_TEST_RESULTS.md
 * See: disasm/sections/expansion_300000.asm (slave_work_wrapper)
 * ============================================================================ */

/* ============================================================================
 * Symbol Exports (for reference)
 * ============================================================================ */
.global slave_init
.global slave_command_loop
.global slave_delay_loop

/* End of slave_command_dispatcher.asm */
