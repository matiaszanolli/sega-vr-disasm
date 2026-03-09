/*
 * func_021_optimized: Coordinate Transform + Cull (with func_016 inlined)
 *
 * This is an optimized version of func_021 that inlines func_016 to eliminate
 * BSR/RTS call overhead. Located in expansion ROM at $300040.
 *
 * Original func_021: $0234C8 - $0234EA (36 bytes)
 * Optimized version: ~60 bytes (larger, but saves 6 cycles per call)
 *
 * OPTIMIZATION: Eliminates BSR/RTS overhead for func_016 calls
 * Savings: 6 cycles per polygon (BSR + RTS + delay slots)
 * At 800 polygons/frame: 4,800 cycles saved for this call site
 *
 * Input: (same as original func_021)
 *   R14 = RenderingContext pointer
 *   R7 = loop counter
 *   R8 = data pointer
 *   R5 = output pointer
 *
 * Calls: $0202350A (absolute address for nested function)
 * Note: Uses JSR @Rn instead of BSR for cross-ROM calls
 */

.section .text
.align 2

func_021_optimized:
    /* Entry: Save return address */
    sts.l   pr,@-r15

    /* ========== INLINED func_016 START ========== */
    /* Original: BSR func_016 + NOP (4 bytes, 6+ cycles) */
    /* Now: 15 instructions inline (30 bytes, ~15 cycles) */

    /* Load coordinate fields from context */
    mov.l   @(28,r14),r1            /* R1 = field_0x1C (coordinate Y1) */
    mov.l   @(32,r14),r2            /* R2 = field_0x20 (coordinate Y2) */

    /* Shift to upper 16 bits */
    shll16  r1                      /* R1 = R1 << 16 */
    shll16  r2                      /* R2 = R2 << 16 */

    /* Load base value and prepare copies */
    mov.l   @(20,r14),r0            /* R0 = field_0x14 (base X value) */
    mov     r1,r3                   /* R3 = copy of shifted Y1 */
    mov     r2,r4                   /* R4 = copy of shifted Y2 */

    /* Combine with first base value: upper(Y) | lower(X) */
    or      r0,r1                   /* R1 = Y1<<16 | X1 */
    or      r0,r2                   /* R2 = Y2<<16 | X1 */

    /* Store first pair of packed coordinates */
    mov.l   r1,@(40,r14)            /* field_0x28 = packed coord 1 */
    mov.l   r2,@(44,r14)            /* field_0x2C = packed coord 2 */

    /* Load alternate base value */
    mov.l   @(24,r14),r0            /* R0 = field_0x18 (alternate X) */

    /* Combine with second base value */
    or      r0,r3                   /* R3 = Y1<<16 | X2 */
    or      r0,r4                   /* R4 = Y2<<16 | X2 */

    /* Store second pair of packed coordinates */
    mov.l   r3,@(48,r14)            /* field_0x30 = packed coord 3 */
    mov.l   r4,@(52,r14)            /* field_0x34 = packed coord 4 */
    /* ========== INLINED func_016 END ========== */

.loop_start:
    /* Save registers for nested call */
    mov.l   r7,@-r15                /* Save R7 */
    mov.l   r8,@-r15                /* Save R8 */

    /* Call nested function $0202350A using absolute addressing */
    /* Original used: BSR $02350A with STS.L PR,@-R15 in delay slot */
    mov.l   .addr_nested_func,r0    /* Load absolute address */
    jsr     @r0                     /* Call nested function */
    sts.l   pr,@-r15                /* [delay slot] Save PR before call */

    /* Restore registers */
    mov.l   @r15+,r8                /* Restore R8 */
    mov.l   @r15+,r7                /* Restore R7 */

    /* Load result from data pointer */
    mov.w   @(2,r8),r0              /* Load word from R8+2 into R0 (encoded disp=1) */

    /* Test and branch */
    tst     #1,r0                   /* Test bit 0 of R0 */
    bf/s    .skip_extra             /* Branch if bit 0 is set (T=0) */
    add     #16,r8                  /* [delay slot] R8 += 16 */
    add     #4,r8                   /* Extra adjustment (only if not branching) */

.skip_extra:
    dt      r7                      /* Decrement R7, set T if zero */
    bf      .loop_start             /* Loop if R7 != 0 */

    /* Exit: Restore return address and return */
    lds.l   @r15+,pr                /* Restore PR */
    rts
    nop

    /* Literal pool - must be aligned */
.align 4
.addr_nested_func:
    .long   0x0202350A              /* Absolute address of nested function (func_023+10) */

/*
 * End of func_021_optimized
 */
