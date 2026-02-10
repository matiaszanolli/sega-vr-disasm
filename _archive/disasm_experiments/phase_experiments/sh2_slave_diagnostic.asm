/* ============================================================================
 * SH2 Slave Diagnostic - Writes state to COMM registers for visibility
 * ============================================================================
 * COMM registers are visible in PicoDrive debug output
 * This helps diagnose what Slave is doing without a full debugger
 * ============================================================================ */

.section .text

/* COMM registers - visible from both CPUs */
.set COMM0, 0x20004020
.set COMM2, 0x20004022
.set COMM4, 0x20004024
.set COMM6, 0x20004026

/* Sync buffer in SDRAM */
.set SYNC_BASE, 0x22000400
.set MASTER_READY_OFFSET, 0x00
.set SLAVE_DONE_OFFSET, 0x0C

.set WORK_MAGIC, 0x574F524B
.set DONE_MAGIC, 0x444F4E45

.globl slave_main_loop

.align 2

slave_main_loop:
    /* Write 0xAA to COMM0 - "Slave started" */
    mov.l   comm0_addr, r8
    mov     #0xAA, r0
    mov.w   r0, @r8

    /* Load sync base */
    mov.l   sync_base_lit, r14

    /* Write 0xBB to COMM2 - "Entering main loop" */
    mov.l   comm2_addr, r9
    mov     #0xBB, r0
    mov.w   r0, @r9

    /* Frame counter in r10 */
    mov     #0, r10

main_loop:
    /* Increment frame counter */
    add     #1, r10

    /* Write frame counter low byte to COMM4 */
    mov.l   comm4_addr, r11
    mov     r10, r0
    mov.w   r0, @r11

    /* Check for WORK signal */
    mov.l   @(MASTER_READY_OFFSET, r14), r0
    mov.l   work_magic_lit, r1
    cmp/eq  r1, r0
    bf      no_work

    /* Got WORK - write 0xCC to COMM6 */
    mov.l   comm6_addr, r12
    mov     #0xCC, r0
    mov.w   r0, @r12

    /* Signal DONE */
    mov.l   done_magic_lit, r0
    mov.l   r0, @(SLAVE_DONE_OFFSET, r14)

    /* Clear WORK so we don't process again */
    mov     #0, r0
    mov.l   r0, @(MASTER_READY_OFFSET, r14)

    bra     main_loop
    nop

no_work:
    /* Write 0xDD to COMM6 - "Waiting for work" */
    mov.l   comm6_addr, r12
    mov     #0xDD, r0
    mov.w   r0, @r12

    /* Small delay */
    mov     #0x10, r1
delay:
    dt      r1
    bf      delay

    bra     main_loop
    nop

.align 4

sync_base_lit:
    .long   SYNC_BASE

work_magic_lit:
    .long   WORK_MAGIC

done_magic_lit:
    .long   DONE_MAGIC

comm0_addr:
    .long   COMM0

comm2_addr:
    .long   COMM2

comm4_addr:
    .long   COMM4

comm6_addr:
    .long   COMM6
