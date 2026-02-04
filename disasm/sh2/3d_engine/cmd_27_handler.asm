/*
 * cmd $27 Handler - 2D Pixel Modifier (Most Frequent: 21 calls/frame)
 * ====================================================================
 * SH2 Address: $06005AC8 (SDRAM, copied from ROM at boot)
 * ROM Offset:  $025AC8
 * Size:        92 bytes (including literal pool)
 *
 * PURPOSE
 * -------
 * Adds a constant value to every byte in a 2D rectangular region.
 * Used for brightness adjustment, color modification, or palette effects.
 *
 * Called 21 times per frame via 68K function sh2_cmd_27 ($00E3B4).
 * Contains 2 blocking handshake loops - primary async optimization target.
 *
 * ============================================================================
 * PROTOCOL SUMMARY - Three-Phase Handshake
 * ============================================================================
 *
 *        68K                                    Master SH2
 *         |                                          |
 *   ======|========== PHASE 1: Data Pointer =========|======
 *         |                                          |
 *         |  1. Write data_ptr → COMM4+5 (32-bit)    |
 *         |  2. Write $0101 → COMM6 (ready)          |
 *         |  3. Write $27 → COMM0_lo (cmd code)      |
 *         |  4. Write $01 → COMM0_hi (trigger)       |
 *         |                                          |
 *         |                        [Entry: dispatch] |
 *         |                        Read COMM4+5 → R0 | (data pointer)
 *         |                        Write $0000 → COMM6 (ack)
 *         |                                          |
 *         |  ←←←←←← POLL LOOP 1 ←←←←←←               |
 *         |  Poll COMM6 until == 0                   |
 *         |                                          |
 *   ======|========== PHASE 2: Parameters D0/D1 =====|======
 *         |                                          |
 *         |  5. Write D0 → COMM4 (width)             |
 *         |  6. Write D1 → COMM5 (height)            |
 *         |  7. Write $0101 → COMM6 (ready)          |
 *         |                                          |
 *         |                        Poll COMM6 != 0   |
 *         |                        Read COMM4 → R1   | (width)
 *         |                        Read COMM5 → R2   | (height)
 *         |                        Write $0000 → COMM6 (ack)
 *         |                                          |
 *         |  ←←←←←← POLL LOOP 2 ←←←←←←               |
 *         |  Poll COMM6 until == 0                   |
 *         |                                          |
 *   ======|========== PHASE 3: Parameter D2 =========|======
 *         |                                          |
 *         |  8. Write D2 → COMM4 (add value)         |
 *         |  9. Write $0101 → COMM6 (ready)          |
 *         | 10. RTS (fire-and-forget!)               |
 *         |                                          |
 *         |                        Poll COMM6 != 0   |
 *         |                        Read COMM4 → R3   | (add value)
 *         |                        Write $0000 → COMM6 (ack)
 *         |                                          |
 *         |                        [PROCESS DATA]    |
 *         |                        for row in height:|
 *         |                          for col in width:|
 *         |                            *ptr++ += add |
 *         |                          ptr += stride   |
 *         |                                          |
 *         |                        Call func_084     | (clears COMM0)
 *         |                        RTS               |
 *         |                                          |
 *
 * ============================================================================
 * COMM REGISTER STATE MACHINE
 * ============================================================================
 *
 * COMM0 (Command Flag):
 *   - 68K writes: $01xx (trigger) at phase 1 start
 *   - SH2 clears: $00xx via func_084 at completion
 *   - Implicit: SH2 doesn't read COMM0 during handler
 *
 * COMM4+5 (Parameters):
 *   - Phase 1: 32-bit data pointer (longword read by SH2)
 *   - Phase 2: COMM4=D0 (width), COMM5=D1 (height) (word reads)
 *   - Phase 3: COMM4=D2 (add value) (word read)
 *
 * COMM6 (Handshake):
 *   State transitions:
 *     $0101 → 68K signals "data ready"
 *     $0000 → SH2 signals "data received" (acknowledgment)
 *
 *   68K blocking points:
 *     After phase 1: polls until COMM6 == 0
 *     After phase 2: polls until COMM6 == 0
 *     After phase 3: NO POLL (fire-and-forget return)
 *
 *   SH2 polling points:
 *     Before phase 2 read: polls until COMM6 != 0
 *     Before phase 3 read: polls until COMM6 != 0
 *
 * ============================================================================
 * ASYNC OPTIMIZATION IMPLICATIONS
 * ============================================================================
 *
 * To make cmd $27 async-safe:
 *
 * 1. PARAMETER CAPTURE: All three phases must complete before 68K overwrites
 *    COMM4/5/6 with next command. Current fire-and-forget on phase 3 is safe
 *    because 68K doesn't reuse COMM until next sh2_cmd_27 call.
 *
 * 2. QUEUE REQUIREMENTS: If batching multiple cmd $27 calls:
 *    - Queue entry needs: data_ptr (32-bit), width (16), height (16), add (16)
 *    - Total: 10 bytes per queued command
 *    - 21 calls/frame = 210 bytes queue minimum
 *
 * 3. COMPLETION SIGNAL: func_084 clears COMM0. For async, could:
 *    - Keep COMM0 clear approach (compatible)
 *    - Or use COMM7 for batch completion signal
 *
 * 4. SLAVE OFFLOAD: This is a good candidate for Slave execution:
 *    - Self-contained data processing (no external state)
 *    - Predictable memory access pattern
 *    - No VDP/hardware register access
 *
 * ============================================================================
 * REGISTER USAGE
 * ============================================================================
 *
 * Input (from COMM registers):
 *   R0 = data pointer (32-bit from COMM4+5)
 *   R1 = width / inner loop count (16-bit from COMM4)
 *   R2 = height / outer loop count (16-bit from COMM5)
 *   R3 = add value (16-bit from COMM4)
 *
 * Working:
 *   R4 = current row pointer
 *   R5 = inner loop counter / COMM6 address
 *   R6 = zero constant / row stride
 *   R7 = current byte value / COMM6 read value
 *   R8 = 1 (unused, possibly vestigial)
 *
 * Preserved:
 *   PR = return address (via stack)
 *   R15 = stack pointer
 *
 * ============================================================================
 */

        .section .text
        .align 2

/* ============================================================================
 * Entry Point - Save PR and Load COMM Addresses
 * ============================================================================ */
cmd_27_handler:
        sts.l   pr,@-r15                /* $5AC8: 4F22 - Save return address */
        mov.l   .L_comm4_addr,r3        /* $5ACA: D313 - R3 = 0x20004028 (COMM4) */
        mov.l   .L_comm6_addr,r5        /* $5ACC: D513 - R5 = 0x2000402C (COMM6) */

/* ============================================================================
 * PHASE 1: Read Data Pointer (32-bit from COMM4+5)
 * ============================================================================
 * At entry, 68K has already written:
 *   COMM4+5 = data pointer (32-bit)
 *   COMM6 = $0101 (ready signal)
 *   COMM0 = $0127 (command $27 triggered)
 * ============================================================================ */
        mov.l   @r3,r0                  /* $5ACE: 6032 - R0 = *(COMM4) as 32-bit */
                                        /*        This reads COMM4+COMM5 together */
                                        /*        R0 = data pointer from 68K */

        mov     #0,r6                   /* $5AD0: E600 - R6 = 0 (ack value) */
        mov.w   r6,@r5                  /* $5AD2: 2561 - *COMM6 = 0 (ACK PHASE 1) */
                                        /*        68K will unblock from poll loop */

/* ============================================================================
 * POLL LOOP 1: Wait for Phase 2 Parameters
 * ============================================================================
 * SH2 polls until 68K writes COMM6 = $0101 with D0/D1 parameters
 * This is where SH2 waits for 68K to prepare next phase
 * ============================================================================ */
.L_poll_phase2:
        mov.w   @r5,r7                  /* $5AD4: 6751 - R7 = *COMM6 */
        cmp/eq  r6,r7                   /* $5AD6: 3760 - Is COMM6 == 0? */
        bt      .L_poll_phase2          /* $5AD8: 89FC - Yes: keep polling */
                                        /*        No: 68K wrote $0101, continue */

/* ============================================================================
 * PHASE 2: Read Width (D0) and Height (D1)
 * ============================================================================
 * 68K has written:
 *   COMM4 = D0 (width / inner loop count)
 *   COMM5 = D1 (height / outer loop count)
 *   COMM6 = $0101 (ready signal)
 * ============================================================================ */
        mov.w   @r3+,r1                 /* $5ADA: 6135 - R1 = *COMM4 (width) */
                                        /*        R3 += 2 → now points to COMM5 */
        mov.w   @r3,r2                  /* $5ADC: 6231 - R2 = *COMM5 (height) */

        mov.w   r6,@r5                  /* $5ADE: 2561 - *COMM6 = 0 (ACK PHASE 2) */
                                        /*        68K will unblock from poll loop */

/* ============================================================================
 * POLL LOOP 2: Wait for Phase 3 Parameter
 * ============================================================================
 * SH2 polls until 68K writes COMM6 = $0101 with D2 parameter
 * ============================================================================ */
.L_poll_phase3:
        mov.w   @r5,r7                  /* $5AE0: 6751 - R7 = *COMM6 */
        cmp/eq  r6,r7                   /* $5AE2: 3760 - Is COMM6 == 0? */
        bt      .L_poll_phase3          /* $5AE4: 89FC - Yes: keep polling */
                                        /*        No: 68K wrote $0101, continue */

/* ============================================================================
 * PHASE 3: Read Add Value (D2) - Final Acknowledgment
 * ============================================================================
 * 68K has written:
 *   COMM4 = D2 (add value)
 *   COMM6 = $0101 (ready signal)
 * 68K then returns WITHOUT waiting (fire-and-forget)
 * ============================================================================ */
        mov.l   .L_comm4_addr,r3        /* $5AE6: D30C - R3 = 0x20004028 (COMM4) */
        mov.w   @r3,r3                  /* $5AE8: 6331 - R3 = *COMM4 (add value) */
                                        /*        Note: reuses R3 for add value */

        mov     #0,r6                   /* $5AEA: E600 - R6 = 0 */
        mov.w   r6,@r5                  /* $5AEC: 2561 - *COMM6 = 0 (ACK PHASE 3) */
                                        /*        68K already returned, this is */
                                        /*        just clearing for next command */

/* ============================================================================
 * DATA PROCESSING: Add Constant to 2D Pixel Region
 * ============================================================================
 * At this point:
 *   R0 = data pointer (base address)
 *   R1 = width (bytes per row to process)
 *   R2 = height (number of rows)
 *   R3 = add value (constant to add to each byte)
 *
 * Algorithm:
 *   for (row = 0; row < height; row++) {
 *       ptr = base + row * stride;
 *       for (col = 0; col < width; col++) {
 *           *ptr++ += add_value;
 *       }
 *   }
 *
 * Stride is 0x200 (512 bytes) - likely frame buffer row pitch
 * ============================================================================ */
        mov.w   .L_row_stride,r6        /* $5AEE: 9611 - R6 = 0x0200 (row stride) */
        mov     #1,r8                   /* $5AF0: E801 - R8 = 1 (unused) */

.L_outer_loop:                          /* Process each row */
        mov     r0,r4                   /* $5AF2: 6403 - R4 = current row start */
        mov     r1,r5                   /* $5AF4: 6513 - R5 = width counter */

.L_inner_loop:                          /* Process each byte in row */
        mov.b   @r4,r7                  /* $5AF6: 6740 - R7 = current byte */
        add     r3,r7                   /* $5AF8: 373C - R7 += add_value */
        mov.b   r7,@r4                  /* $5AFA: 2470 - Store modified byte */
        add     #1,r4                   /* $5AFC: 7401 - Advance pointer */
        dt      r5                      /* $5AFE: 4510 - Decrement, set T if zero */
        bf      .L_inner_loop           /* $5B00: 8BF9 - Loop if width remaining */

        add     r6,r0                   /* $5B02: 306C - Advance to next row */
        dt      r2                      /* $5B04: 4210 - Decrement height counter */
        bf      .L_outer_loop           /* $5B06: 8BF4 - Loop if rows remaining */

/* ============================================================================
 * COMPLETION: Clear COMM0 and Return
 * ============================================================================
 * func_084 at $060043F0 clears COMM0 to signal command completion.
 * This allows the next command to be dispatched.
 * ============================================================================ */
        mov.l   .L_completion_func,r0   /* $5B08: D005 - R0 = 0x060043F0 */
        jsr     @r0                     /* $5B0A: 400B - Call func_084 */
        nop                             /* $5B0C: 0009 - Delay slot */

        lds.l   @r15+,pr                /* $5B0E: 4F26 - Restore return address */
        rts                             /* $5B10: 000B - Return to dispatcher */
        nop                             /* $5B12: 0009 - Delay slot */

/* ============================================================================
 * LITERAL POOL (4-byte aligned)
 * ============================================================================ */
        .align 4
.L_row_stride:
        .word   0x0200                  /* $5B14: Row stride (512 bytes) */
        .word   0x0000                  /* $5B16: Padding for alignment */

.L_comm4_addr:
        .long   0x20004028              /* $5B18: COMM4 address */

.L_comm6_addr:
        .long   0x2000402C              /* $5B1C: COMM6 address */

.L_completion_func:
        .long   0x060043F0              /* $5B20: func_084 (clears COMM0) */

/* ============================================================================
 * TIMING ANALYSIS
 * ============================================================================
 *
 * Cycle counts (approximate, not including memory wait states):
 *
 * Setup (once):
 *   STS.L, 2x MOV.L, MOV.L @R3: ~8 cycles
 *
 * Phase 1 ack:
 *   MOV #0, MOV.W @R5: ~3 cycles
 *
 * Poll loop 1 (per iteration):
 *   MOV.W, CMP/EQ, BT: 4 cycles
 *   If 68K takes ~200 cycles to prepare: ~50 iterations = 200 cycles wasted
 *
 * Phase 2 read + ack:
 *   MOV.W @R3+, MOV.W @R3, MOV.W R6,@R5: ~6 cycles
 *
 * Poll loop 2 (same as loop 1):
 *   ~200 cycles wasted typical
 *
 * Phase 3 read + ack:
 *   MOV.L, MOV.W, MOV #0, MOV.W: ~6 cycles
 *
 * Data processing (per byte):
 *   MOV.B, ADD, MOV.B, ADD, DT, BF: ~8 cycles
 *   Typical region: 32x16 = 512 bytes → 4096 cycles
 *
 * Completion:
 *   JSR, func_084 (~20 cycles), LDS.L, RTS: ~30 cycles
 *
 * TOTAL per call (typical 32x16 region):
 *   Protocol overhead: ~420 cycles (including 400 polling)
 *   Data processing: ~4096 cycles
 *   Total: ~4500 cycles
 *
 * With 21 calls/frame:
 *   21 × 4500 = 94,500 cycles/frame
 *   At 23 MHz: ~4.1ms per frame
 *
 * Polling alone: 21 × 400 = 8,400 cycles = 0.37ms wasted
 *
 * ============================================================================
 * VERIFICATION
 * ============================================================================
 *
 * Expected ROM bytes at offset 0x025AC8:
 *   4F22 D313 D513 6032 E600 2561 6751 3760
 *   89FC 6135 6231 2561 6751 3760 89FC D30C
 *   6331 E600 2561 9611 E801 6403 6513 6740
 *   373C 2470 7401 4510 8BF9 306C 4210 8BF4
 *   D005 400B 0009 4F26 000B 0009 0200 0000
 *   2000 4028 2000 402C 0600 43F0
 *
 * Verify with: xxd -s 0x25AC8 -l 92 build/vr_rebuild.32x
 *
 * ============================================================================
 */

/* End of cmd_27_handler.asm */
