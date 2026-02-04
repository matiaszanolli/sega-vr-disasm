/*
 * cmd27_queue_drain - Async Queue Processor for cmd $27
 * ======================================================
 * Location: Expansion ROM at $300600 (suggested)
 * Size: ~120 bytes (including literal pool)
 *
 * PURPOSE
 * -------
 * Drains a ring buffer of cmd $27 entries, processing each without
 * per-entry COMM handshakes. Called when COMM7 doorbell is rung.
 *
 * This replaces 21 × 3-phase handshakes with 1 doorbell signal,
 * eliminating ~8,400 cycles of polling overhead per frame.
 *
 * QUEUE LAYOUT (68K Work RAM, shared with SH2)
 * ---------------------------------------------
 * 68K address:  $FFFB00  (in 68K Work RAM)
 * SH2 address:  $02FFFB00 (68K RAM visible to SH2)
 *
 *   +0x00: write_idx (16-bit, 0-31, wraps)
 *   +0x02: read_idx  (16-bit, 0-31, wraps)
 *   +0x04: entry[0]  (10 bytes)
 *   +0x0E: entry[1]  ...
 *   ...
 *   +0x144: entry[31]
 *
 * ENTRY FORMAT (10 bytes each)
 * ----------------------------
 *   +0: data_ptr   (32-bit) - pointer to pixel region
 *   +4: width      (16-bit) - bytes per row
 *   +6: height     (16-bit) - number of rows
 *   +8: add_value  (16-bit) - constant to add to each byte
 *
 * PROTOCOL
 * --------
 * 68K side:
 *   1. Write entry to queue[write_idx]
 *   2. Increment write_idx (mod 32)
 *   3. If queue was empty: COMM7 = $0101 (doorbell)
 *   4. Return immediately (no wait)
 *
 * SH2 side (this function):
 *   1. Called when COMM7 != 0
 *   2. Loop: while read_idx != write_idx
 *   3.   Load entry[read_idx]
 *   4.   Process (add constant to pixel region)
 *   5.   Increment read_idx (mod 32)
 *   6. Clear COMM7 (doorbell acknowledged)
 *   7. Return
 *
 * REGISTER USAGE
 * --------------
 * Preserved: R15 (stack), PR (via stack)
 * Destroyed: R0-R11
 *
 * R0  = write_idx / scratch
 * R1  = read_idx
 * R2  = entry pointer calculation
 * R3  = data_ptr (current entry)
 * R4  = width
 * R5  = height
 * R6  = add_value
 * R7  = row stride (0x200)
 * R8  = queue base address
 * R9  = current byte pointer (inner loop)
 * R10 = inner loop counter
 * R11 = current byte value
 *
 * INTEGRATION
 * -----------
 * Add to master_poll_loop after COMM0 check:
 *
 *   mov.w   @(14,r8),r0       ; R0 = COMM7 (offset 14 from COMM base)
 *   tst     r0,r0
 *   bt      .no_queue
 *   mov.l   .L_drain_func,r0
 *   jsr     @r0
 *   nop
 * .no_queue:
 *
 * ============================================================================
 */

        .section .text
        .align 2

        .global cmd27_queue_drain

cmd27_queue_drain:
        sts.l   pr,@-r15                /* Save return address */

        mov.l   .L_queue_base,r8        /* R8 = 0x2203E100 (queue base) */

.L_drain_loop:
        /* Load indices - must re-read write_idx each iteration
         * in case 68K enqueues more while we're processing */
        mov.w   @r8,r0                  /* R0 = write_idx */
        mov     r8,r1                   /* R1 = queue base */
        add     #2,r1                   /* R1 = &read_idx */
        mov.w   @r1,r1                  /* R1 = read_idx */

        /* Check if queue empty */
        cmp/eq  r0,r1                   /* read_idx == write_idx? */
        bt      .L_done                 /* Yes: queue empty, exit */

        /* Calculate entry address: base + 4 + (read_idx * 10)
         * SH2 has no immediate multiply, so: x*10 = x*8 + x*2 = (x<<3) + (x<<1)
         */
        mov     r1,r2                   /* R2 = read_idx */
        shll2   r2                      /* R2 = read_idx * 4 */
        shll    r2                      /* R2 = read_idx * 8 */
        mov     r1,r0                   /* R0 = read_idx */
        shll    r0                      /* R0 = read_idx * 2 */
        add     r0,r2                   /* R2 = read_idx * 10 */
        add     r8,r2                   /* R2 = base + read_idx*10 */
        add     #4,r2                   /* R2 = base + 4 + read_idx*10 = &entry */

        /* Load entry fields */
        mov.l   @r2+,r3                 /* R3 = data_ptr (68K address) */
        mov.w   @r2+,r4                 /* R4 = width (16-bit) */
        mov.w   @r2+,r5                 /* R5 = height (16-bit) */
        mov.w   @r2,r6                  /* R6 = add_value (16-bit) */

        /* Convert 68K address to SH2 address space */
        mov.l   .L_sh2_offset,r0        /* R0 = 0x02000000 */
        add     r0,r3                   /* R3 = data_ptr + 0x02000000 */

        /* Zero-extend width/height/add_value (MOV.W sign-extends) */
        extu.w  r4,r4                   /* Zero-extend width */
        extu.w  r5,r5                   /* Zero-extend height */
        extu.w  r6,r6                   /* Zero-extend add_value */

        /* Load row stride constant */
        mov.w   .L_row_stride,r7        /* R7 = 0x0200 */

        /* Skip if height == 0 */
        tst     r5,r5
        bt      .L_next_entry

/* ============================================================================
 * PIXEL PROCESSING: Add constant to 2D region
 * Same algorithm as original cmd $27 handler
 * ============================================================================ */
.L_outer_loop:
        mov     r3,r9                   /* R9 = current row start */
        mov     r4,r10                  /* R10 = width counter */

        /* Skip if width == 0 */
        tst     r10,r10
        bt      .L_next_row

.L_inner_loop:
        mov.b   @r9,r11                 /* R11 = current byte */
        add     r6,r11                  /* R11 += add_value */
        mov.b   r11,@r9                 /* Store modified byte */
        add     #1,r9                   /* Advance pointer */
        dt      r10                     /* Decrement counter, set T if zero */
        bf      .L_inner_loop           /* Loop if width remaining */

.L_next_row:
        add     r7,r3                   /* Advance to next row (+stride) */
        dt      r5                      /* Decrement height counter */
        bf      .L_outer_loop           /* Loop if rows remaining */

/* ============================================================================
 * UPDATE READ INDEX AND LOOP
 * ============================================================================ */
.L_next_entry:
        /* Increment read_idx (mod 32)
         * SH2 MOV.W with displacement requires R0 as src/dst */
        mov     r8,r2                   /* R2 = queue base */
        add     #2,r2                   /* R2 = &read_idx */
        mov.w   @r2,r0                  /* R0 = read_idx */
        add     #1,r0                   /* read_idx++ */
        mov     #31,r1                  /* R1 = mask for mod 32 */
        and     r1,r0                   /* read_idx &= 31 */
        mov.w   r0,@r2                  /* Store new read_idx */

        bra     .L_drain_loop           /* Process next entry */
        nop

/* ============================================================================
 * COMPLETION: Clear doorbell and return
 * ============================================================================ */
.L_done:
        /* Clear COMM7 to acknowledge doorbell */
        mov.l   .L_comm7_addr,r0        /* R0 = 0x2000402E (COMM7) */
        mov     #0,r1
        mov.w   r1,@r0                  /* COMM7 = 0 */

        lds.l   @r15+,pr                /* Restore return address */
        rts
        nop

/* ============================================================================
 * LITERAL POOL
 * ============================================================================ */
        .align 4

.L_row_stride:
        .word   0x0200                  /* Row stride (512 bytes) */
        .word   0x0000                  /* Padding */

.L_queue_base:
        .long   0x02FFFB00              /* Queue in 68K Work RAM (SH2 view) */

.L_sh2_offset:
        .long   0x02000000              /* 68K→SH2 address conversion offset */

.L_comm7_addr:
        .long   0x2000402E              /* COMM7 register */

/* ============================================================================
 * SIZE VERIFICATION
 * ============================================================================
 * Expected size: ~100 bytes code + 12 bytes literals = ~112 bytes
 *
 * To assemble and verify:
 *   sh-elf-as --isa=sh2 -o cmd27_queue_drain.o cmd27_queue_drain.asm
 *   sh-elf-objcopy -O binary cmd27_queue_drain.o cmd27_queue_drain.bin
 *   ls -l cmd27_queue_drain.bin
 *
 * ============================================================================
 */

/* End of cmd27_queue_drain.asm */
