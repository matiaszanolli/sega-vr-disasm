/*
 * physics_pos_update — SH2 16.16 Fixed-Point Position Update
 * Expansion ROM Address: $301DA0 (SH2: $02301DA0)
 * VR60 Phase 3D
 *
 * Replaces 68K entity_pos_update ($006F98, 98 bytes) with a higher-
 * precision implementation using 16.16 fixed-point position accumulation.
 *
 * === PRECISION IMPROVEMENT ===
 *
 * 68K original: position is 16-bit integer. (sin × speed) >> 12 discards
 *   12 fractional bits every frame. At low speeds, deltas round to zero.
 *   Precision: ±0.5 world units.
 *
 * SH2 version: position is 16.16 fixed-point. Integer part at entity
 *   +$30/+$34 (rendering-compatible, unchanged). Fractional part at
 *   +$F2/+$F4 (new fields, persistent across frames).
 *   Precision: ±1/65536 world units (16,384× improvement).
 *
 * === MATHEMATICAL MODEL ===
 *
 * Sine table: Q8 format (256 entries, 0-256 = 0.0-1.0) at ROM $02130000
 * Speed: entity+$06 (16-bit signed, max ~17000)
 * Product: sin_Q8 × speed (max 256 × 17000 = 4,352,000, fits 23 bits)
 *
 * 68K: dx_int = (sin × speed) >> 12
 * SH2: dx_16.16 = (sin × speed) << 4
 *   Derivation: 16.16 = integer × 2^16, so (>>12) becomes (>>12 + <<16) = <<4
 *
 * === EXIT PATHS ===
 *
 * The 68K has 3 JMP exits into collision. All become RTS on SH2:
 *   1. Normal (+$62==0 AND +$92<=0): compute position, RTS
 *   2. Special (+$92>0): RTS (counter_guard stays on 68K)
 *   3. Alternate (+$62!=0): RTS (camera_position_smooth stays on 68K)
 *
 * Entry: GBR = entity base ($0600F20C), R13 = globals base
 * Clobbers: R0-R7
 * Stack: 4 bytes (PR save for BSR to sine lookup)
 */

.section .text
.align 2

.global sh2_entity_pos_update
sh2_entity_pos_update:
    sts.l   pr,@-r15               /* save PR (BSR clobbers it) */

    /* === Exit path 1: alternate mode (+$62 != 0) === */
    mov.w   @(0x62,gbr),r0
    tst     r0,r0
    bf      .pu_rts

    /* === Exit path 2: special param (+$92 > 0) === */
    mov.w   @(0x92,gbr),r0
    cmp/pl  r0                     /* T = (R0 > 0) */
    bt      .pu_rts

    /* === Compute heading === */
    /* heading = entity[+$3C] + entity[+$96] */
    mov.w   @(0x3C,gbr),r0        /* heading_mirror */
    mov     r0,r1
    mov.w   @(0x96,gbr),r0        /* heading_offset */
    add     r0,r1                  /* R1 = heading */
    mov     r1,r0
    mov.w   r0,@(0x40,gbr)        /* entity[+$40] = heading_angle */

    /* Negate heading and mask to 16 bits */
    neg     r1,r1
    extu.w  r1,r1                  /* R1 = (-heading) & $FFFF — preserved for cosine */

    /* Load speed, preserve in R6 */
    mov.w   @(0x06,gbr),r0
    mov     r0,r6                  /* R6 = speed (16-bit signed, preserved) */

    /* ==== SINE(-heading) → X displacement ==== */
    mov     r1,r4                  /* R4 = angle for sine lookup */
    bsr     .pu_sin_lookup
    nop                            /* [delay slot] */
    /* R0 = sin(-heading), signed Q8 (-256..+256) */

    /* dx_16.16 = (sin_Q8 × speed) << 4 */
    muls.w  r6,r0                  /* MACL = sin × speed (16×16→32 signed) */
    sts     macl,r2                /* R2 = product (interleave after MULS for pipeline) */
    shll2   r2                     /* <<2 */
    shll2   r2                     /* <<4 total → R2 = dx_16.16 */

    /* Load X position as 16.16: {entity[+$30], entity[+$F2]} */
    mov.w   @(0x30,gbr),r0        /* X integer (sign-extended to 32-bit by MOV.W) */
    shll16  r0                     /* R0 = X_int << 16 (integer in upper half) */
    mov     r0,r3                  /* R3 = X_int << 16 */
    mov.w   @(0xF2,gbr),r0        /* X fraction (sign-extended by GBR MOV.W) */
    extu.w  r0,r0                  /* zero-extend: fraction is unsigned 16-bit */
    or      r0,r3                  /* R3 = {X_int, X_frac} = X_16.16 */

    /* Accumulate delta */
    add     r2,r3                  /* R3 = new X_16.16 */

    /* Store X integer part to +$30 */
    mov     r3,r0
    swap.w  r0,r0                  /* R0[15:0] = integer part (big-endian swap) */
    mov.w   r0,@(0x30,gbr)        /* entity[+$30] = X integer */

    /* Store X fraction to +$F2 */
    mov     r3,r0                  /* R0[15:0] = fraction (low 16 of 16.16) */
    mov.w   r0,@(0xF2,gbr)        /* entity[+$F2] = X fraction */

    /* ==== COSINE(-heading) → Y displacement ==== */
    /* cos(x) = sin(x + 90°) = sin(x + $4000) */
    mov     r1,r4                  /* R4 = -heading (preserved from above) */
    mov.w   @(.pu_c4000,pc),r7    /* R7 = $4000 (90° phase shift) */
    add     r7,r4                  /* R4 = -heading + $4000 */
    extu.w  r4,r4                  /* mask to 16 bits (wrap at 360°) */
    bsr     .pu_sin_lookup
    nop                            /* [delay slot] */
    /* R0 = cos(-heading), signed Q8 */

    /* dy_16.16 = (cos_Q8 × speed) << 4 */
    muls.w  r6,r0
    sts     macl,r2
    shll2   r2
    shll2   r2                     /* R2 = dy_16.16 */

    /* Load Y position as 16.16 */
    mov.w   @(0x34,gbr),r0        /* Y integer */
    shll16  r0
    mov     r0,r3
    mov.w   @(0xF4,gbr),r0        /* Y fraction */
    extu.w  r0,r0
    or      r0,r3                  /* R3 = Y_16.16 */
    add     r2,r3                  /* R3 = new Y_16.16 */

    /* Store Y integer and fraction */
    mov     r3,r0
    swap.w  r0,r0
    mov.w   r0,@(0x34,gbr)        /* entity[+$34] = Y integer */
    mov     r3,r0
    mov.w   r0,@(0xF4,gbr)        /* entity[+$F4] = Y fraction */

.pu_rts:
    lds.l   @r15+,pr
    rts
    nop                            /* [delay slot] */


/* ============================================================
 * .pu_sin_lookup — Q8 sine with arithmetic quadrant dispatch
 * ============================================================
 * Input:  R4 = 16-bit unsigned angle (0-$FFFF, already masked)
 * Output: R0 = signed sine value (-256 to +256, Q8)
 * Clobbers: R4, R5, R7
 * Preserves: R1, R2, R3, R6
 *
 * Algorithm:
 *   10-bit index = angle >> 6
 *   quadrant = index >> 8 (bits 9:8, range 0-3)
 *   sub_idx  = index & $FF (bits 7:0, range 0-255)
 *   if quadrant & 1: sub_idx = 256 - sub_idx  (mirror Q1/Q3)
 *   result = sin_table[sub_idx]                (unsigned 0..256)
 *   if quadrant & 2: result = -result          (negate Q2/Q3)
 *
 * Table: 257 entries × 2 bytes at SH2 ROM $02130000
 *   (first quadrant only; 257th entry = sin(90°) = 256)
 * ============================================================ */
.pu_sin_lookup:
    /* Extract 10-bit index: angle >> 6 */
    mov     r4,r0                  /* R0 = angle */
    shlr2   r0                     /* >>2 */
    shlr2   r0                     /* >>4 */
    shlr2   r0                     /* >>6: R0 = 10-bit index (0-1023) */

    /* Split into quadrant (top 2 bits) and sub-index (bottom 8 bits) */
    mov     r0,r5                  /* R5 = 10-bit index */
    shlr8   r5                     /* R5 = quadrant (0-3) */
    extu.b  r0,r4                  /* R4 = sub_index = index & $FF (0-255) */

    /* Mirror check: if quadrant bit 0 set (Q1 or Q3), sub_idx = 256 - sub_idx */
    mov     r5,r0                  /* R0 = quadrant (TST #imm requires R0) */
    tst     #1,r0                  /* T = (quadrant bit 0 == 0) */
    bt      .sin_tbl               /* Q0/Q2: direct lookup, no mirror */
    /* Q1/Q3: mirror the index */
    mov     #1,r7
    shll8   r7                     /* R7 = 256 */
    sub     r4,r7                  /* R7 = 256 - sub_idx */
    mov     r7,r4                  /* R4 = mirrored index */

.sin_tbl:
    /* Table lookup: sin_table[R4] */
    /* MOV.W @(R0,Rm),Rn — R0 MUST be the index register */
    mov     r4,r0                  /* R0 = table index */
    add     r0,r0                  /* R0 = index × 2 (byte offset for word array) */
    mov.l   @(.pu_sin_table,pc),r7 /* R7 = table base $02130000 */
    mov.w   @(r0,r7),r0           /* R0 = sin_table[sub_idx], unsigned 0..256 */

    /* Negate check: if quadrant bit 1 set (Q2 or Q3), negate result */
    mov     r0,r4                  /* R4 = sine value (save — R0 needed for TST) */
    mov     r5,r0                  /* R0 = quadrant */
    tst     #2,r0                  /* T = (quadrant bit 1 == 0) */
    bt      .sin_done              /* Q0/Q1: positive, no negate */
    neg     r4,r4                  /* Q2/Q3: negate sine value */

.sin_done:
    mov     r4,r0                  /* R0 = final signed sine value */
    rts
    nop                            /* [delay slot] */


/* === LITERAL POOL === */
.align 2
.pu_c4000:
    .short  0x4000                 /* 90° phase shift for cosine */
.align 2
.pu_sin_table:
    .long   0x02130000             /* sine table base (SH2 ROM) */

.global physics_pos_update_end
physics_pos_update_end:
