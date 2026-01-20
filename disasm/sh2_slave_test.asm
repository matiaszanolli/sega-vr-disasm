/* ============================================================================
 * SH2 Slave Test - Simple execution test
 * Just increments a counter to prove Slave is running
 * ============================================================================ */

.section .text

.set SYNC_BASE, 0x22000400
.set SLAVE_FRAME_COUNTER, 0x40
.set DONE_MAGIC, 0x444F4E45

.globl slave_main_loop

.align 2

/* Simple test: increment counter and signal done repeatedly */
slave_main_loop:
    mov.l   sync_base_lit, r14

main_loop:
    /* Increment frame counter to prove we're running */
    mov.l   @(SLAVE_FRAME_COUNTER, r14), r0
    add     #1, r0
    mov.l   r0, @(SLAVE_FRAME_COUNTER, r14)

    /* Signal done */
    mov.l   done_magic_lit, r0
    mov.l   r0, @(0x0C, r14)

    /* Small delay loop */
    mov     #0x7F, r1
delay:
    dt      r1
    bf      delay

    /* Loop forever */
    bra     main_loop
    nop

.align 4

sync_base_lit:
    .long   SYNC_BASE

done_magic_lit:
    .long   DONE_MAGIC
