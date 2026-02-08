/*
 * Queue Processor - Dequeue and Forward Commands to Slave SH2
 * ROM File Offset: Expansion ROM $300C00
 * SH2 Address: 0x02300C00 (expansion ROM cached)
 *
 * PURPOSE
 * -------
 * Called by cmdint_handler to dequeue ONE entry from the ring buffer
 * and forward it to the Slave SH2 via COMM registers.
 *
 * Uses the EXACT SAME 3-phase COMM protocol as the original 68K code
 * (see sh2_cmd_27 at $00E3B4 in sh2_communication.asm).
 *
 * RING BUFFER LAYOUT (SDRAM $2203F000)
 * -------------------------------------
 * $2203F000-$2203F1FF: 64 entries × 8 bytes = 512 bytes
 *   Each entry: [cmd:16][param1:16][param2:16][param3:16]
 * $2203F200: Head pointer (32-bit, 68K write index, 0-63)
 * $2203F204: Tail pointer (32-bit, SH2 read index, 0-63)
 *
 * ALGORITHM
 * ---------
 * 1. Read head and tail pointers
 * 2. If head == tail, queue is empty → return immediately
 * 3. Calculate entry address: base + (tail * 8)
 * 4. Read entry: [cmd, param1, param2, param3]
 * 5. Forward to COMM registers using 3-phase protocol:
 *    Phase 1: Write cmd/param1/param2 to COMM, set trigger
 *    Phase 2: Wait for Slave acknowledgment (COMM6 clear)
 *    Phase 3: Write param3 to COMM4, set ready flag
 * 6. Advance tail pointer: tail = (tail + 1) & 63
 * 7. Return
 *
 * BLOCKING BEHAVIOR
 * -----------------
 * This function BLOCKS in a poll loop waiting for Slave acknowledgment
 * (COMM6 clear). This is SAFE because:
 * - Master SH2 is otherwise idle (0.0% utilization)
 * - We process one entry at a time (no corruption risk)
 * - Slave will eventually acknowledge (no deadlock)
 *
 * The blocking wait ensures COMM register stability. We cannot dequeue
 * the next entry until Slave finishes processing the current one.
 *
 * REGISTER USAGE
 * --------------
 * Modified: R0-R9
 * Preserved: R10-R15, PR
 *
 * REFERENCES
 * ----------
 * - sh2_communication.asm ($00E3B4) - Original blocking protocol
 * - Phase 1 Implementation Plan - Queue processor specification
 */

.section .text
.align 2

queue_processor:
    /* Load head and tail pointers */
    mov.l   head_ptr_addr,r2    /* R2 = 0x2203F200 (head pointer address) */
    mov.l   tail_ptr_addr,r3    /* R3 = 0x2203F204 (tail pointer address) */
    mov.l   @r2,r4              /* R4 = head (write index, 0-63) */
    mov.l   @r3,r5              /* R5 = tail (read index, 0-63) */

    /* Check if queue empty: head == tail? */
    cmp/eq  r4,r5               /* Compare head vs tail */
    bt      .empty              /* If equal, queue is empty → return */

    /* Calculate entry address: base + (tail * 8) */
    mov.l   ring_buf_base,r0    /* R0 = 0x2203F000 (ring buffer base) */
    mov     r5,r1               /* R1 = tail */
    shll2   r1                  /* R1 = tail * 4 */
    shll    r1                  /* R1 = tail * 8 */
    add     r1,r0               /* R0 = base + (tail * 8) = entry address */

    /* Read entry: [cmd:16][param1:16][param2:16][param3:16] */
    mov.w   @r0+,r6             /* R6 = command code (16-bit) */
    mov.w   @r0+,r7             /* R7 = param1 (16-bit) */
    mov.w   @r0+,r8             /* R8 = param2 (16-bit) */
    mov.w   @r0+,r9             /* R9 = param3 (16-bit) */

    /* Forward to COMM registers (3-phase protocol) */
    mov.l   comm_base,r1        /* R1 = 0x20004020 (COMM base address) */

    /* --- Phase 1: Write command and trigger --- */
    add     #1,r1               /* R1 = 0x20004021 (COMM0_LO) */
    mov.b   r6,@r1              /* COMM0_LO = command code */
    add     #-1,r1              /* R1 = 0x20004020 (back to base) */
    add     #8,r1               /* R1 = 0x20004028 (COMM4) */
    mov.w   r7,@r1              /* COMM4 = param1 */
    add     #2,r1               /* R1 = 0x2000402A (COMM5) */
    mov.w   r8,@r1              /* COMM5 = param2 */
    add     #2,r1               /* R1 = 0x2000402C (COMM6) */
    mov.w   handshake_ready,r0  /* R0 = 0x0101 */
    mov.w   r0,@r1              /* COMM6 = ready */
    mov.l   comm_base,r1        /* R1 = 0x20004020 (back to base) */
    mov     #1,r0               /* R0 = 1 */
    mov.b   r0,@r1              /* COMM0_HI = trigger */

    /* --- Phase 2: Wait for Slave acknowledgment (BLOCKING POLL) --- */
    mov.l   comm_base,r1        /* R1 = 0x20004020 */
    add     #12,r1              /* R1 = 0x2000402C (COMM6) */
.wait_ack:
    mov.b   @r1,r0              /* R0 = COMM6 high byte */
    tst     r0,r0               /* Test if zero */
    bf.s    .wait_ack           /* Loop if non-zero (Slave still processing) */
    nop                         /* Delay slot */

    /* --- Phase 3: Write param3 --- */
    mov.l   comm_base,r1        /* R1 = 0x20004020 */
    add     #8,r1               /* R1 = 0x20004028 (COMM4) */
    mov.w   r9,@r1              /* COMM4 = param3 */
    add     #4,r1               /* R1 = 0x2000402C (COMM6) */
    mov.w   handshake_ready,r0  /* R0 = 0x0101 */
    mov.w   r0,@r1              /* COMM6 = ready again */

    /* Advance tail pointer: (tail + 1) & 63 */
    add     #1,r5               /* tail++ */
    mov     #63,r0              /* R0 = 63 (mask for 64-entry wraparound) */
    and     r0,r5               /* tail = tail & 63 */
    mov.l   r5,@r3              /* Store updated tail pointer */

.empty:
    rts                         /* Return to caller (cmdint_handler) */
    nop                         /* Delay slot */

/* ========================================================================
 * Literal Pool (4-byte aligned)
 * ======================================================================== */
.align 4
head_ptr_addr:
    .long 0x2203F200            /* Head pointer address (cache-through SDRAM) */
tail_ptr_addr:
    .long 0x2203F204            /* Tail pointer address (cache-through SDRAM) */
ring_buf_base:
    .long 0x2203F000            /* Ring buffer base address (cache-through SDRAM) */
comm_base:
    .long 0x20004020            /* COMM base address (COMM0) */
handshake_ready:
    .word 0x0101                /* Handshake ready flag value */
trigger_value:
    .byte 0x01                  /* Command trigger value */

.align 2
