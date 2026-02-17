/*
 * inline_slave_drain - COMM7 check + cmd27 COMM-register processing
 * ==================================================================
 * Location: SDRAM at $06000608 (replaces original delay loop)
 * Size: MUST be <= 128 bytes (64 words) to fit delay loop space
 *
 * PURPOSE
 * -------
 * Replaces the Slave SH2 delay loop with inline COMM7 doorbell
 * check and cmd27 pixel processing.  Reads parameters directly
 * from COMM registers (the ONLY documented shared memory between
 * 68K and SH2).  Runs entirely from SDRAM — does NOT jump to
 * expansion ROM (PicoDrive cannot execute code from $02300000+
 * on the Slave SH2).
 *
 * PROTOCOL
 * --------
 * 68K writes: COMM4+5=data_ptr, COMM2=width, COMM3=height,
 *   COMM6=add_value, COMM7=$0027 (doorbell).
 * Slave reads COMM2-6, clears COMM7 (signals "params read"),
 *   then processes pixels with cache-through writes.
 * After processing, loops back to check for another entry.
 *
 * REGISTER USAGE
 * --------------
 * R8 = &COMM7 (preserved across loop iterations)
 * All other registers destroyed (command_loop reloads everything)
 */

        .section .text
        .align 2

        .global inline_slave_drain

inline_slave_drain:
        mov.l   .L_comm7_addr,r8        /* R8 = &COMM7 ($2000402E) — kept for re-checks */

.L_check_comm7:
        mov.w   @r8,r0                  /* R0 = COMM7 value */
        tst     r0,r0                   /* COMM7 == 0? */
        bt      .L_idle                 /* Yes: nothing to do */

        /* --- Read all params from COMM registers BEFORE clearing COMM7 --- */
        mov.l   .L_comm_base,r1         /* R1 = $20004020 (COMM register base) */

        /* data_ptr from COMM4+COMM5 (R1 + 8 bytes) */
        mov.l   @(8,r1),r3              /* R3 = data_ptr (longword: COMM4 hi, COMM5 lo) */

        /* width from COMM2 (R1 + 4 bytes) */
        mov     r1,r2                   /* R2 = COMM base */
        add     #4,r2                   /* R2 = &COMM2 ($20004024) */
        mov.w   @r2,r4                  /* R4 = width */

        /* height from COMM3 (R2 + 2 bytes) */
        add     #2,r2                   /* R2 = &COMM3 ($20004026) */
        mov.w   @r2,r5                  /* R5 = height */

        /* add_value from COMM6 (base + 12 bytes) */
        mov     r1,r2                   /* R2 = COMM base */
        add     #12,r2                  /* R2 = &COMM6 ($2000402C) */
        mov.w   @r2,r6                  /* R6 = add_value */

        /* --- Clear COMM7: signal 68K that params have been read --- */
        mov     #0,r0
        mov.w   r0,@r8                  /* COMM7 = 0 (68K can now write next entry) */

        /* Convert data_ptr to cache-through: $04xxxxxx → $24xxxxxx
         * The Slave SH2 has its own data cache. Writes to $04xxxxxx
         * stay in cache and never reach framebuffer DRAM. The display
         * controller reads from DRAM, so modifications are invisible.
         * OR with $20000000 sets bit 29 → cache-through mirror. */
        mov     #0x20,r0
        shll16  r0                      /* R0 = $00200000 */
        shll8   r0                      /* R0 = $20000000 */
        or      r0,r3                   /* R3 = data_ptr ($24xxxxxx cache-through) */

        /* Stride: build 0x200 from immediates (saves literal pool space) */
        mov     #2,r7
        shll8   r7                      /* R7 = 0x0200 (512-byte stride) */

        /* No zero checks for height/width — cmd_27 callers never pass 0 */

.L_outer_loop:
        mov     r3,r9                   /* R9 = row start */
        mov     r4,r10                  /* R10 = width counter */

.L_inner_loop:
        mov.b   @r9,r11                 /* Load pixel byte */
        add     r6,r11                  /* Add brightness constant */
        mov.b   r11,@r9                 /* Store modified pixel */
        add     #1,r9
        dt      r10                     /* Decrement width, set T if done */
        bf      .L_inner_loop

        add     r7,r3                   /* Next row (+ stride) */
        dt      r5                      /* Decrement height */
        bf      .L_outer_loop

        /* Check for another entry (68K may have written while we processed) */
        bra     .L_check_comm7
        nop                             /* delay slot */

.L_idle:
        /* Return to Slave command_loop */
        mov.l   .L_cmdloop_addr,r3
        jmp     @r3
        nop

/* Literal pool (must be 4-byte aligned; .align 2 = 2^2 = 4 bytes) */
        .align 2
.L_comm7_addr:
        .long   0x2000402E              /* COMM7 register */
.L_comm_base:
        .long   0x20004020              /* COMM register base */
.L_cmdloop_addr:
        .long   0x06000592              /* Slave command_loop */

/* End of inline_slave_drain.asm */
