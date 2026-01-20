/* ============================================================================
 * SH2 Master Sync Integration - Phase 2
 * Virtua Racing Deluxe parallelization
 *
 * This module provides two functions to be injected into the Master rendering engine:
 * 1. init_slave_sync - Initialize sync buffer (called at func_001 entry)
 * 2. dispatch_slave_and_wait - Dispatch work to Slave (called at final_exit)
 * ============================================================================ */

.section .text

.set SYNC_BASE, 0x22000400
.set MASTER_READY_OFFSET, 0x00
.set SLAVE_READY_OFFSET, 0x04
.set MASTER_DONE_OFFSET, 0x08
.set SLAVE_DONE_OFFSET, 0x0C
.set POLYGON_COUNT_OFFSET, 0x10
.set SLAVE_START_OFFSET, 0x14
.set SLAVE_END_OFFSET, 0x18
.set CONTEXT_PTR_OFFSET, 0x20
.set DISPLAY_LIST_OFFSET, 0x24
.set FRAME_BUFFER_OFFSET, 0x28

.set READY_MAGIC, 0x52454459
.set WORK_MAGIC, 0x574F524B
.set DONE_MAGIC, 0x444F4E45

.align 2

.globl init_slave_sync
init_slave_sync:
    mov.l   sync_base_addr, r1
    mov     #0, r0
    mov.l   r0, @(MASTER_READY_OFFSET, r1)
    mov     #0, r0
    mov.l   r0, @(SLAVE_READY_OFFSET, r1)
    mov     #0, r0
    mov.l   r0, @(MASTER_DONE_OFFSET, r1)
    mov     #0, r0
    mov.l   r0, @(SLAVE_DONE_OFFSET, r1)
    mov.l   r14, @(CONTEXT_PTR_OFFSET, r1)
    mov.l   r13, @(DISPLAY_LIST_OFFSET, r1)
    mov.l   frame_buf_addr, r0
    mov.l   r0, @(FRAME_BUFFER_OFFSET, r1)
    rts
    nop

.align 2

.globl dispatch_slave_and_wait
dispatch_slave_and_wait:
    sts.l   pr, @-r15

    mov.l   sync_base_addr, r14
    mov     #60, r2

wait_slave_ready:
    mov.l   @(SLAVE_READY_OFFSET, r14), r0
    mov.l   ready_magic, r1
    cmp/eq  r1, r0
    bt      slave_is_ready
    dt      r2
    bf      wait_slave_ready
    bra     skip_dispatch
    nop

slave_is_ready:
    mov.l   poly_count, r0
    mov.l   r0, @(POLYGON_COUNT_OFFSET, r14)

    mov.l   slave_start, r0
    mov.l   r0, @(SLAVE_START_OFFSET, r14)

    mov.l   slave_end, r0
    mov.l   r0, @(SLAVE_END_OFFSET, r14)

    mov.l   work_magic, r0
    mov.l   r0, @(MASTER_READY_OFFSET, r14)

    mov.l   done_magic, r0
    mov.l   r0, @(MASTER_DONE_OFFSET, r14)

    mov.l   timeout_long, r2

wait_slave_done:
    mov.l   @(SLAVE_DONE_OFFSET, r14), r0
    mov.l   done_magic, r1
    cmp/eq  r1, r0
    bt      both_done
    dt      r2
    bf      wait_slave_done

skip_dispatch:
both_done:
    lds.l   @r15+, pr
    rts
    nop

.align 4

sync_base_addr:
    .long   SYNC_BASE

frame_buf_addr:
    .long   0x24000000

ready_magic:
    .long   READY_MAGIC

work_magic:
    .long   WORK_MAGIC

done_magic:
    .long   DONE_MAGIC

poly_count:
    .long   800

slave_start:
    .long   400

slave_end:
    .long   799

timeout_long:
    .long   1000
