/*
 * ai_steering — SH2 AI Steering + atan2 Calculation
 * VR60 Phase 4
 *
 * Ports ai_steering_calc ($00A7A0, 66B) and atan2_calc ($008FC8, 120B)
 * to SH2 as a single module.
 *
 * ai_steering_calc computes a 16-bit angle from position deltas:
 *   angle = atan2(target - entity) in range $0000-$FFFF (65536 = 360°)
 *
 * Entry: R0 = entity Y, R1 = entity X, R2 = target Y, R3 = target X
 * Exit:  R0 = steering angle (16-bit)
 * Clobbers: R0-R5
 * Preserves: R6-R15, GBR
 *
 * atan2_calc uses 3 ROM lookup tables at SH2 $02130202/$02130402:
 *   Range 1 (|input| < $400): table1[(|input| & $FC) >> 1]
 *   Range 2 ($400 ≤ |input| < $D8F): table2[((|input|-$400) & $F0) >> 3]
 *   Range 3 ($D8F ≤ |input| < $517C): (|input| >> 11) + $F4
 *   Range 4 (|input| ≥ $517C): $FE or $100
 *   Result scaled <<6, sign from original input
 */

.section .text
.align 2

/* ============================================================================
 * sh2_ai_steering_calc
 * Entry: R0=entityY, R1=entityX, R2=targetY, R3=targetX
 * Exit: R0=angle (16-bit)
 * ============================================================================ */
.global sh2_ai_steering_calc
sh2_ai_steering_calc:
    sub     r1,r3                  /* R3 = DX = target_x - entity_x */
    sub     r0,r2                  /* R2 = DY = target_y - entity_y */
    tst     r2,r2
    bf      .sc_has_dy             /* DY != 0: compute angle */

    /* DY == 0: purely horizontal */
    cmp/pl  r3                     /* DX > 0? */
    bt      .sc_positive
    tst     r3,r3
    bt      .sc_zero               /* DX == 0: angle = 0 */
    /* DX < 0 */
    mov.w   @(.sc_cC000,pc),r0     /* angle = -$4000 */
    rts
    nop
.sc_zero:
    mov     #0,r0
    rts
    nop
.sc_positive:
    mov.w   @(.sc_c4000,pc),r0     /* angle = +$4000 */
    rts
    nop

.sc_has_dy:
    /* Compute tangent ratio: (DX * 256) / DY */
    mov     r3,r0                  /* R0 = DX */
    exts.w  r0,r0                  /* sign-extend to 32-bit */
    shll8   r0                     /* R0 = DX * 256 */
    /* Signed divide R0 / R2 (DY) */
    /* Check for overflow: if |DX*256| > 32767*|DY|, overflow */
    /* Actually, 68K DIVS overflows when quotient doesn't fit in 16 bits. */
    /* We'll use sh2_sdiv16 for the division. */
    mov     r2,r1                  /* R1 = DY (divisor) */
    exts.w  r1,r1
    mov     r0,r4                  /* R4 = DX*256 (save for overflow check) */
    /* sh2_sdiv16: R0/R1 → R0 quotient */
    mov.l   @(.sc_sdiv_addr,pc),r5
    jsr     @r5
    nop
    /* R0 = quotient. Check if it overflowed 16-bit range. */
    /* 68K DIVS sets V flag on overflow. For SH2, check |quotient| > 32767. */
    mov     r0,r5                  /* R5 = quotient (save) */
    cmp/pz  r0
    bt      .sc_check_pos_overflow
    neg     r0,r0
.sc_check_pos_overflow:
    mov.w   @(.sc_c7FFF,pc),r1
    cmp/gt  r1,r0                  /* |quotient| > 32767? */
    bf      .sc_atan_lookup        /* no overflow: proceed to atan2 */
    /* Overflow: return ±$4000 based on DX sign */
    cmp/pz  r3                     /* DX >= 0? */
    bt      .sc_positive
    mov.w   @(.sc_cC000,pc),r0
    rts
    nop

.sc_atan_lookup:
    /* Call atan2 with quotient in R0 */
    mov     r5,r0                  /* R0 = quotient */
    exts.w  r0,r0                  /* sign-extend */
    mov     r2,r4                  /* R4 = DY (save for hemisphere check) */
    bsr     .sc_atan2
    nop
    /* R0 = angle from atan2 */
    /* Adjust for DY hemisphere */
    cmp/pz  r4                     /* DY >= 0? */
    bt      .sc_return
    mov.w   @(.sc_c8000,pc),r1
    add     r1,r0                  /* angle += $8000 (flip hemisphere) */
.sc_return:
    rts
    nop

/* ============================================================================
 * .sc_atan2 — Segmented arctangent lookup
 * Entry: R0 = input (signed 32-bit, sign-extended from 16-bit quotient)
 * Exit: R0 = angle (16-bit)
 * Clobbers: R1, R2, R3
 * ============================================================================ */
.sc_atan2:
    mov     r0,r3                  /* R3 = original input (SIGN PRESERVED) */
    mov     r0,r1                  /* R1 = input (will be abs'd) */
    cmp/pz  r1
    bt      .at_pos
    neg     r1,r1                  /* R1 = |input| */
.at_pos:
    /* Range 1: |input| < $400 */
    mov.w   @(.at_c0400,pc),r2
    cmp/hs  r2,r1                  /* |input| >= $400? (unsigned) */
    bt      .at_range2

    /* Table 1 lookup: index = (|input| & $FC) >> 1 */
    mov     r1,r2
    mov     #0xFC,r3
    extu.b  r3,r3
    and     r3,r2                  /* R2 = |input| & $FC */
    shlr    r2                     /* R2 = index (byte offset into word table) */
    mov.l   @(.at_tbl1,pc),r3     /* table 1 base */
    mov     r2,r0                  /* R0 = offset (for indexed load) */
    mov.w   @(r0,r3),r0           /* R0 = table1[index] */
    exts.w  r0,r0
    bra     .at_apply_sign
    nop

.at_range2:
    /* Range 2: $400 ≤ |input| < $D8F */
    mov.w   @(.at_c0D8F,pc),r2
    cmp/hs  r2,r1                  /* |input| >= $D8F? (unsigned) */
    bt      .at_range3

    /* Table 2 lookup: index = ((|input| - $400) & $F0) >> 3 */
    mov     r1,r2
    mov.w   @(.at_c0400,pc),r3
    sub     r3,r2                  /* R2 = |input| - $400 */
    mov     #0xF0,r3
    extu.b  r3,r3
    and     r3,r2                  /* R2 = (|input|-$400) & $F0 */
    shlr    r2
    shlr    r2
    shlr    r2                     /* R2 >>= 3 (byte offset for word table) */
    mov.l   @(.at_tbl2,pc),r3     /* table 2 base */
    mov     r2,r0
    mov.w   @(r0,r3),r0
    exts.w  r0,r0
    bra     .at_apply_sign
    nop

.at_range3:
    /* Range 3: $D8F ≤ |input| < $517C */
    mov.l   @(.at_c517C,pc),r2
    cmp/hs  r2,r1                  /* |input| >= $517C? (unsigned) */
    bt      .at_large

    /* Computed: (|input| >> 11) + $F4 */
    mov     r1,r2
    shlr8   r2
    shlr2   r2
    shlr    r2                     /* R2 = |input| >> 11 */
    mov     #0xF4,r3
    extu.b  r3,r3
    add     r3,r2                  /* R2 = (|input|>>11) + $F4 */
    mov     r2,r0
    exts.w  r0,r0
    bra     .at_apply_sign
    nop

.at_large:
    /* Range 4: very large input → $FE or $100 */
    mov     #0xFE,r0
    extu.b  r0,r0                  /* R0 = $FE */
    mov.l   @(.at_cA2F8,pc),r2
    cmp/hs  r2,r1                  /* |input| >= $A2F8? */
    bf      .at_apply_sign
    mov.w   @(.at_c0100,pc),r0    /* R0 = $100 */

.at_apply_sign:
    /* R0 = unsigned lookup result, R3 = original signed input */
    /* Apply sign: if original was negative, negate result */
    cmp/pz  r3                     /* original input >= 0? */
    bt      .at_no_negate
    neg     r0,r0                  /* negate result for negative input */
.at_no_negate:
    /* Scale result <<6 (matches 68K ASL.L #6) */
    shll    r0
    shll    r0
    shll    r0
    shll    r0
    shll    r0
    shll    r0                     /* R0 <<= 6 */
    rts
    nop

.align 2
.sc_c4000:      .short  0x4000
.sc_cC000:      .short  0xC000
.sc_c8000:      .short  0x8000
.sc_c7FFF:      .short  0x7FFF
.at_c0400:      .short  0x0400
.at_c0D8F:      .short  0x0D8F
.at_c0100:      .short  0x0100
.align 2
.sc_sdiv_addr:  .long   0x02301720     /* sh2_sdiv16 */
.at_tbl1:       .long   0x02130202     /* atan2 table 1 (ROM $00930202) */
.at_tbl2:       .long   0x02130402     /* atan2 table 2 (ROM $00930402) */
.at_c517C:      .long   0x0000517C     /* range 3 upper bound */
.at_cA2F8:      .long   0x0000A2F8     /* extra large threshold */

.global ai_steering_end
ai_steering_end:
