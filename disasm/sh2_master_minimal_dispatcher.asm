/* ============================================================================
 * SH2 Master Minimal Dispatcher - Phase 2 (Test Version)
 * Virtua Racing Deluxe parallelization
 *
 * This is a simplified Master dispatcher for Phase 2 testing.
 * Replaces func_001 entry to initialize sync buffer and wait for Slave.
 *
 * This version skips Master rendering to isolate Slave functionality.
 * Use this to validate that Slave can work independently.
 *
 * Status: TEST/VALIDATION ONLY
 * Production use: Wait for full Phase 2 with proper Master rendering
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
.set FRAME_BUFFER_ADDR, 0x24000000

.align 2

/* ============================================================================
 * master_minimal_dispatcher - Minimal Master for Phase 2 testing
 * ============================================================================
 * Replaces func_001 entry point entirely.
 * Initializes sync buffer, sets up minimal context, returns.
 * Actual rendering is deferred to Slave for testing.
 *
 * Input:  R13 = Display list pointer (from game engine)
 * Output: Returns with sync buffer initialized
 * ============================================================================ */

.globl master_minimal_dispatcher
master_minimal_dispatcher:
    /* Save return address for calling function */
    sts.l   pr, @-r15

    /* Load sync buffer base */
    mov.l   sync_base_addr, r14

    /* Clear all sync flags */
    mov     #0, r0
    mov.l   r0, @(MASTER_READY_OFFSET, r14)
    mov.l   r0, @(SLAVE_READY_OFFSET, r14)
    mov.l   r0, @(MASTER_DONE_OFFSET, r14)
    mov.l   r0, @(SLAVE_DONE_OFFSET, r14)

    /* Set up work parameters (fixed split: polygons 0-799) */
    mov.l   poly_count_val, r0
    mov.l   r0, @(POLYGON_COUNT_OFFSET, r14)

    mov.l   slave_start_val, r0
    mov.l   r0, @(SLAVE_START_OFFSET, r14)

    mov.l   slave_end_val, r0
    mov.l   r0, @(SLAVE_END_OFFSET, r14)

    /* Store context pointer (RenderingContext at 0xC0000700) */
    mov.l   context_addr, r0
    mov.l   r0, @(CONTEXT_PTR_OFFSET, r14)

    /* Store display list pointer (R13 from caller) */
    mov.l   r13, @(DISPLAY_LIST_OFFSET, r14)

    /* Store frame buffer pointer */
    mov.l   frame_buf_addr, r0
    mov.l   r0, @(FRAME_BUFFER_OFFSET, r14)

    /* Signal Slave ready and wait for it to finish */
    mov.l   ready_magic, r0
    mov.l   r0, @(SLAVE_READY_OFFSET, r14)

    /* Set work signal */
    mov.l   work_magic, r0
    mov.l   r0, @(MASTER_READY_OFFSET, r14)

    /* Master done immediately (Slave does all work in this test version) */
    mov.l   done_magic, r0
    mov.l   r0, @(MASTER_DONE_OFFSET, r14)

    /* Wait for Slave to complete (with timeout) */
    mov     #100, r2

wait_for_slave:
    mov.l   @(SLAVE_DONE_OFFSET, r14), r0
    mov.l   done_magic, r1
    cmp/eq  r1, r0
    bt      slave_finished
    dt      r2
    bf      wait_for_slave

    /* Timeout - continue anyway */
    bra     slave_finished
    nop

slave_finished:
    /* Clear for next frame */
    mov     #0, r0
    mov.l   r0, @(MASTER_READY_OFFSET, r14)

    /* Return to caller */
    lds.l   @r15+, pr
    rts
    nop

.align 4

/* Literal pool */
sync_base_addr:
    .long   SYNC_BASE

frame_buf_addr:
    .long   FRAME_BUFFER_ADDR

context_addr:
    .long   0xC0000700

ready_magic:
    .long   READY_MAGIC

work_magic:
    .long   WORK_MAGIC

done_magic:
    .long   DONE_MAGIC

poly_count_val:
    .long   800

slave_start_val:
    .long   400

slave_end_val:
    .long   799
