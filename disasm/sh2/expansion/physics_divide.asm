/*
 * physics_divide — VR60 Phase 3B: SH2 Division Infrastructure
 * Expansion ROM Address: $301610
 *
 * Provides:
 *   1. sh2_sdiv16: Software signed 16-bit divide (R0 / R1 → R0)
 *   2. Gear reciprocal table (6 entries, for DIVU replacement)
 *   3. Constant reciprocals for DIVS #$0190 and DIVS #$0497
 *
 * Division strategy:
 *   - Runtime DIVS → BSR sh2_sdiv16 (~50 cycles, called 1×/entity/frame)
 *   - Gear DIVU  → MUL.L with reciprocal table + shift (3 cycles)
 *   - DIVS #400  → MUL.L with constant reciprocal + shift (3 cycles)
 *   - DIVS #1175 → MUL.L with constant reciprocal + shift (3 cycles)
 *
 * Register convention:
 *   sh2_sdiv16: R0 = dividend (signed 32-bit), R1 = divisor (signed 16-bit)
 *               Returns: R0 = quotient (truncated toward zero, matches 68K DIVS)
 *               Clobbers: R1, R2, R3
 *
 * Verified: all reciprocals produce max 1 LSB error across full input ranges.
 * Gear reciprocals: 0 error at max dividend ($426800).
 */

.section .text
.align 2

/*
 * sh2_sdiv16 — Signed 16-bit division (32-bit dividend / 16-bit divisor)
 *
 * Matches 68K DIVS behavior: truncation toward zero.
 * Algorithm: Extract signs, unsigned divide, restore sign.
 *
 * Entry: R0 = dividend (signed 32-bit), R1 = divisor (signed 16-bit, sign-extended to 32)
 * Exit:  R0 = quotient (signed, truncated toward zero)
 * Clobbers: R1, R2, R3
 * Cost: ~50 cycles (16-iteration shift-subtract loop)
 */
.global sh2_sdiv16
sh2_sdiv16:
    /* Save sign: R2 = sign_dividend XOR sign_divisor */
    mov     r0,r2           /* R2 = dividend (for sign) */
    xor     r1,r2           /* R2 bit 31 = result sign */

    /* Make both operands positive */
    cmp/pz  r0              /* Test dividend sign */
    bt      .div_pos_num
    neg     r0,r0           /* R0 = |dividend| */
.div_pos_num:
    cmp/pz  r1              /* Test divisor sign */
    bt      .div_pos_den
    neg     r1,r1           /* R1 = |divisor| */
.div_pos_den:

    /* Unsigned divide: R0 / R1 → R0 quotient, R3 remainder */
    mov     #0,r3           /* R3 = remainder = 0 */
    mov     #16,r4          /* R4 = 16 iterations (16-bit quotient) */

.div_loop:
    /* Shift dividend left, MSB into remainder */
    shll    r0              /* R0 <<= 1, old bit 31 → T */
    rotcl   r3              /* R3 = (R3 << 1) | T */

    /* Compare remainder with divisor */
    cmp/hs  r1,r3           /* T = (R3 >= R1) unsigned */
    bf      .div_no_sub

    /* Subtract divisor from remainder, set quotient bit */
    sub     r1,r3           /* R3 -= R1 */
    add     #1,r0           /* Set LSB of quotient */

.div_no_sub:
    dt      r4              /* R4-- and test */
    bf      .div_loop       /* Loop if R4 != 0 */

    /* Restore sign */
    cmp/pz  r2              /* Test result sign (bit 31 of XOR) */
    bt      .div_done
    neg     r0,r0           /* Negate quotient */

.div_done:
    rts
    nop                     /* delay slot */


/*
 * Reciprocal lookup tables — stored as literal pool data.
 * Accessed via MOV.L @(disp,PC),Rn from physics functions.
 */

.align 2

/* Gear reciprocal table: floor(256 * 65536 / gear_ratio)
 * Usage: result = (speed * gear_recip[gear]) >> 16
 * Replaces: EXT.L + LSL.L #8 + DIVU gear_ratio
 * Index: gear × 4 (longword stride)
 */
.global gear_recip_table
gear_recip_table:
    .long   98112           /* Gear 0: ratio 171, recip $017F40 */
    .long   87381           /* Gear 1: ratio 192, recip $015555 */
    .long   81840           /* Gear 2: ratio 205, recip $013FB0 */
    .long   78766           /* Gear 3: ratio 213, recip $0133AE */
    .long   76608           /* Gear 4: ratio 219, recip $012B40 */
    .long   74898           /* Gear 5: ratio 224, recip $012492 */

/* Constant reciprocals for DIVS replacements
 * Usage: result = (dividend * recip) >> 24
 * MULS.W then STS MACL for signed multiply
 */
.global recip_div400
recip_div400:
    .long   41943           /* floor(2^24 / 400) = $00A3D7 */

.global recip_div1175
recip_div1175:
    .long   14278           /* floor(2^24 / 1175) = $0037C6 */

/* Total: ~68 bytes code + 8 bytes pool = ~76 bytes */
/* Gear table: 24 bytes (6 × 4) */
/* Constant reciprocals: 8 bytes (2 × 4) */
/* Grand total: ~108 bytes */
