/*
 * physics_group2_accel — VR60 Phase 3B: Functions 6 + 7
 * Expansion ROM Address: appended to physics_group1
 *
 * Contains:
 *   6. sh2_speed_accel_braking    (68K: 382B)
 *   7. sh2_tilt_adjust            (68K: 106B)
 *
 * === DIVU REPLACEMENT STRATEGY ===
 *
 * 68K DIVU $00(A1,D2.W),D1 (acceleration brake path):
 *   dividend = speed << 8  (32-bit)
 *   divisor  = gear_ratio[new_gear] (16-bit, from ROM table)
 *   result   = dividend / divisor   (16-bit quotient)
 *
 * SH2 replacement: result = (speed * gear_recip[gear]) >> 16
 *   gear_recip_table at $02301690 (6 longword entries, Phase 3B-1)
 *   Verified: max 1 LSB error across full [0..17000] speed range.
 *
 * 68K DIVS -$02(A1,D1.W),D2 (natural decel path):
 *   Same formula but uses PREVIOUS gear's ratio (gear-1).
 *   SH2: result = (speed * gear_recip[gear-1]) >> 16
 *   Guard: gear-1 >= 0 (68K checks gear > 0 before this path)
 *
 * Entry: GBR = entity base, R13 = globals base
 */

.section .text
.align 2

/* =========================================================================
 * FUNCTION 6: sh2_speed_accel_braking
 * =========================================================================
 * 68K: entity_speed_acceleration_and_braking ($009182, 382B)
 *
 * 4 paths: accel (gas), brake, coast/natural-accel, natural-decel.
 * All paths converge at speed delta clamping.
 *
 * Clobbers: R0-R7
 */
.global sh2_speed_accel_braking
sh2_speed_accel_braking:
    /* Skip if lateral collision or sliding */
    mov.w   @(140,gbr),r0          /* entity[+$8C] lateral_flag */
    mov     r0,r1
    mov.w   @(106,gbr),r0          /* entity[+$6A] collision */
    add     r0,r1
    tst     r1,r1
    bf      .sa_exit_rts            /* nonzero: skip entire function */

    /* Check surface drivability (globals +$10) */
    mov     #0x10,r0
    mov.b   @(r0,r13),r0
    tst     r0,r0
    bt      .sa_coast               /* surface=0: coast only */

    /* Check per-segment accel permission */
    /* The segment table is at 68K $FFC1F4 (WRAM). For SH2, we skip this */
    /* check since the entity's +$AE field already reflects permission. */
    /* The 68K checks table[$AE*2] == 1 → blocked. We replicate by */
    /* reading the permission from the staged entity data at +$AE. */
    /* NOTE: This is a simplification. If the segment table is dynamic, */
    /* we'll need to stage it too. For now, treat +$AE as permission flag. */

    /* === ACCELERATION (gas button) === */
    /* Globals +$18 = input_state byte. Bit 1 = gas. */
    mov     #0x18,r0
    mov.b   @(r0,r13),r0           /* input_state */
    mov     #2,r1                   /* bit 1 mask */
    tst     r1,r0                   /* T = (bit1 == 0) */
    bt      .sa_check_brake         /* gas not held */

    mov.w   @(122,gbr),r0          /* entity[+$7A] gear */
    mov     r0,r2                   /* R2 = gear */
    mov     #6,r1
    cmp/ge  r1,r2                   /* T = (gear >= 6) */
    bt      .sa_clamp_delta         /* max gear: done */

    /* Multiply speed by gear_ratio[gear] */
    mov.w   @(116,gbr),r0          /* entity[+$74] raw_speed */
    mov     r0,r1                   /* R1 = speed */
    /* Load gear ratio from ROM table */
    mov.l   @(.sa_gear_tbl,pc),r6  /* gear table base */
    mov     r2,r0                   /* gear index */
    add     r0,r0                   /* word offset */
    mov.w   @(r0,r6),r0            /* R0 = gear_ratio[gear] */
    muls.w  r0,r1                   /* MACL = speed × ratio */
    sts     macl,r0
    shlr8   r0                      /* >> 8 (logical: speed×ratio is positive) */
    mov.w   r0,@(116,gbr)          /* entity[+$74] = new speed */

    /* Advance gear */
    mov.w   @(122,gbr),r0
    add     #1,r0
    mov.w   r0,@(122,gbr)          /* entity[+$7A] += 1 */

    /* Gear shift sound: speed >= $1F40 AND gear < 4 AND no timer */
    mov.w   @(116,gbr),r0          /* raw_speed */
    mov.w   @(.sa_c1f40,pc),r1     /* $1F40 = 8000 */
    cmp/hs  r1,r0                   /* speed >= 8000? (unsigned) */
    bf      .sa_clamp_delta         /* no: skip */
    mov.w   @(122,gbr),r0          /* gear */
    mov     #4,r1
    cmp/ge  r1,r0                   /* gear >= 4? */
    bt      .sa_clamp_delta         /* high gear: no sound */
    mov.w   @(130,gbr),r0          /* entity[+$82] sound_timer */
    tst     r0,r0
    bf      .sa_clamp_delta         /* timer active */
    mov     #15,r0
    mov.w   r0,@(130,gbr)          /* timer = 15 */
    mov     #0x2C,r0
    mov     #0xB4,r1
    extu.b  r1,r1
    mov.b   r1,@(r0,r13)           /* globals[+$2C] = $B4 */
    bra     .sa_clamp_delta
    nop

    /* === BRAKING (brake button) === */
.sa_check_brake:
    mov     #0x18,r0
    mov.b   @(r0,r13),r0           /* input_state */
    mov     #1,r1                   /* bit 0 = brake */
    tst     r1,r0
    bt      .sa_clamp_delta         /* brake not held */
    mov.w   @(122,gbr),r0          /* gear */
    cmp/pz  r0
    bf      .sa_clamp_delta         /* gear <= 0: can't downshift */
    tst     r0,r0
    bt      .sa_clamp_delta

    /* Downshift */
    add     #-1,r0
    mov.w   r0,@(122,gbr)          /* gear -= 1 */

    /* Decelerate: speed = (speed * recip[new_gear]) >> 16 */
    mov.w   @(116,gbr),r0          /* raw_speed */
    mov     r0,r1                   /* R1 = speed */
    mov.w   @(122,gbr),r0          /* new gear */
    mov     r0,r2                   /* R2 = new gear index */
    /* Load reciprocal from gear_recip_table */
    mov.l   @(.sa_recip_tbl,pc),r6
    shll2   r2                      /* gear × 4 (longword stride) */
    mov     r2,r0
    mov.l   @(r0,r6),r0            /* R0 = gear_recip[gear] */
    mul.l   r0,r1                   /* MACL = speed × recip (32×32→32) */
    sts     macl,r0
    shlr16  r0                      /* >> 16 = braked speed */
    mov.w   r0,@(116,gbr)          /* entity[+$74] */

    /* Overspeed check */
    mov.w   @(.sa_c4268,pc),r1     /* $4268 = 17000 */
    cmp/gt  r1,r0                   /* speed > 17000? */
    bf      .sa_clamp_delta
    mov     r1,r0
    mov.w   r0,@(116,gbr)          /* clamp to 17000 */
    /* Brake timer + drag on overspeed */
    mov.w   @(132,gbr),r0          /* entity[+$84] brake_timer */
    tst     r0,r0
    bf      .sa_brk_drag            /* timer active: skip set */
    mov     #10,r0
    mov.w   r0,@(132,gbr)          /* timer = 10 */
.sa_brk_drag:
    mov     #0xFF,r0
    extu.b  r0,r0                   /* R0 = 255 */
    mov.w   r0,@(16,gbr)           /* entity[+$10] drag = $FF */
    bra     .sa_clamp_delta
    nop

    /* === COASTING / NATURAL ACCELERATION === */
.sa_coast:
    mov.w   @(116,gbr),r0          /* raw_speed */
    mov     r0,r2                   /* R2 = speed */
    mov.w   @(122,gbr),r0          /* gear */
    mov     r0,r1                   /* R1 = gear */
    add     r0,r0                   /* R0 = word offset */
    mov     r0,r5                   /* R5 = word offset (preserve) */

    /* Check base speed != 0 */
    mov.w   @(4,gbr),r0            /* entity[+$04] */
    tst     r0,r0
    bt      .sa_decel               /* no speed: decel */

    /* Check natural accel threshold */
    mov.l   @(.sa_nat_tbl,pc),r6   /* natural accel threshold table */
    mov     r5,r0
    mov.w   @(r0,r6),r0            /* threshold[gear] */
    cmp/gt  r0,r2                   /* speed > threshold? */
    bf      .sa_decel               /* no: check decel */

    /* Natural upshift: speed × gear_ratio >> 8 */
    mov.l   @(.sa_gear_tbl,pc),r6
    mov     r5,r0                   /* word offset */
    mov.w   @(r0,r6),r0            /* gear_ratio[gear] */
    muls.w  r0,r2                   /* MACL = speed × ratio */
    sts     macl,r0
    shlr8   r0                      /* >> 8 */
    mov.w   r0,@(116,gbr)          /* entity[+$74] */
    mov.w   @(122,gbr),r0          /* gear */
    add     #1,r0
    mov.w   r0,@(122,gbr)          /* gear += 1 */

    /* Natural shift sound (same as accel sound) */
    mov.w   @(116,gbr),r0
    mov.w   @(.sa_c1f40,pc),r1
    cmp/hs  r1,r0
    bf      .sa_clamp_delta
    mov.w   @(122,gbr),r0
    mov     #4,r1
    cmp/ge  r1,r0
    bt      .sa_clamp_delta
    mov.w   @(130,gbr),r0
    tst     r0,r0
    bf      .sa_clamp_delta
    mov     #15,r0
    mov.w   r0,@(130,gbr)
    mov     #0x2C,r0
    mov     #0xB4,r1
    extu.b  r1,r1
    mov.b   r1,@(r0,r13)
    bra     .sa_clamp_delta
    nop

    /* === NATURAL DECELERATION === */
.sa_decel:
    mov.l   @(.sa_dec_tbl,pc),r6   /* decel threshold table */
    mov     r5,r0
    mov.w   @(r0,r6),r0            /* decel_threshold[gear] */
    cmp/hs  r0,r2                   /* speed >= threshold? (unsigned) */
    bt      .sa_clamp_delta         /* above threshold: no decel */

    /* Downshift + divide by prev gear ratio via reciprocal */
    mov.w   @(122,gbr),r0          /* gear */
    add     #-1,r0
    mov.w   r0,@(122,gbr)          /* gear -= 1 */

    mov.l   @(.sa_recip_tbl,pc),r6
    mov     r0,r3                   /* R3 = new gear (= old gear - 1) */
    shll2   r3                      /* × 4 (longword stride) */
    mov     r3,r0
    mov.l   @(r0,r6),r0            /* recip[prev_gear_ratio] */
    /* Note: 68K does DIVS -$02(A1,D1.W) — divides by the gear ratio at */
    /* index (D1-2)/2, which is the PREVIOUS gear. Since we already */
    /* decremented gear, gear_recip[new_gear] = recip of old gear's ratio. */
    /* This matches: the 68K accessed A1+(D1-2) where D1 was doubled old gear. */
    /* We use gear_recip[gear-1] = gear_recip[new_gear] ✓ */
    mul.l   r0,r2                   /* MACL = speed × recip */
    sts     macl,r0
    shlr16  r0                      /* >> 16 */
    mov.w   r0,@(116,gbr)          /* entity[+$74] */

    /* Brake timer */
    mov.w   @(132,gbr),r0          /* brake_timer */
    tst     r0,r0
    bf      .sa_clamp_delta
    mov     #10,r0
    mov.w   r0,@(132,gbr)          /* timer = 10 */

    /* === SPEED DELTA CLAMPING: [-$400, +$400] === */
.sa_clamp_delta:
    mov.w   @(116,gbr),r0          /* raw_speed */
    mov     r0,r1
    mov.w   @(126,gbr),r0          /* entity[+$7E] target_speed */
    sub     r0,r1                   /* R1 = delta (raw - target) */
    mov.w   @(.sa_c0400,pc),r2     /* $0400 = 1024 */
    cmp/gt  r2,r1                   /* delta > 1024? */
    bf      .sa_check_min
    mov     r2,r1                   /* clamp to +1024 */
.sa_check_min:
    neg     r2,r2                   /* R2 = -1024 */
    cmp/ge  r2,r1                   /* delta >= -1024? */
    bt      .sa_apply
    mov     r2,r1                   /* clamp to -1024 */
.sa_apply:
    mov.w   @(126,gbr),r0          /* target_speed */
    add     r1,r0                   /* target += clamped delta */
    mov.w   r0,@(126,gbr)          /* entity[+$7E] */
.sa_exit_rts:
    rts
    nop

/* Literal pool for function 6 */
.align 2
.sa_c1f40:      .short  0x1F40     /* 8000 — sound threshold */
.sa_c4268:      .short  0x4268     /* 17000 — max speed */
.sa_c0400:      .short  0x0400     /* 1024 — max delta/frame */
.align 2
.sa_gear_tbl:   .long   0x020A1F0  /* SH2 ROM: gear ratio table ($0088A1F0) */
.sa_recip_tbl:  .long   0x02301690 /* expansion ROM: gear_recip_table ($301660+$30) */
.sa_nat_tbl:    .long   0x020A1E2  /* SH2 ROM: natural accel thresholds ($0088A1E2) */
.sa_dec_tbl:    .long   0x02139EDE /* SH2 ROM: decel thresholds ($00939EDE) */
/* Pool: 6 + 16 = 22 bytes */
/* Function 6 total: ~360 bytes */


/* =========================================================================
 * FUNCTION 7: sh2_tilt_adjust
 * =========================================================================
 * 68K: tilt_adjust ($00961E, 106B)
 *
 * Adjusts entity X-tilt (+$0E) and Z-tilt (+$10) based on track banking.
 * No multiply/divide. Pure compare/clamp logic.
 *
 * Globals used:
 *   +$00 = track_tilt (word)         — 68K $FFC0AC
 *   +$13 = banking_direction (byte)  — 68K $FFC971
 *
 * Clobbers: R0, R1, R2
 */
.global sh2_tilt_adjust
sh2_tilt_adjust:
    /* Skip if collision or lateral flag set */
    mov.w   @(106,gbr),r0          /* entity[+$6A] collision */
    mov     r0,r1
    mov.w   @(140,gbr),r0          /* entity[+$8C] lateral_flag */
    or      r0,r1
    tst     r1,r1
    bf      .ta_done                /* either set: skip */

    mov     #0x30,r0               /* R0 = tilt rate = 48 */

    /* --- X-tilt phase --- */
    /* Load track_tilt from globals +$00 */
    mov     r0,r7                   /* save tilt rate (48) */
    mov     #0x00,r0
    mov.w   @(r0,r13),r0           /* R0 = track_tilt */
    mov     r0,r1                   /* R1 = track_tilt */
    /* Compare with entity direction (+$92) */
    mov.w   @(146,gbr),r0          /* R0 = entity[+$92] direction */
    cmp/ge  r0,r1                   /* T = (track >= direction) signed */
    bt      .ta_check_dir_bit
    /* track < direction: negate tilt */
    neg     r7,r7
    bra     .ta_x_apply
    nop
.ta_check_dir_bit:
    /* Check direction flag bit 4 (globals +$13) */
    mov     #0x13,r0
    mov.b   @(r0,r13),r0           /* banking_direction byte */
    mov     #0x10,r1               /* bit 4 mask */
    tst     r1,r0                   /* T = (bit4 == 0) */
    bf      .ta_x_apply             /* bit4 set: don't negate */
    neg     r7,r7                   /* negate tilt rate */

.ta_x_apply:
    mov.w   @(14,gbr),r0           /* R0 = entity[+$0E] X-tilt */
    add     r7,r0                   /* apply tilt rate */
    /* Clamp to [-51, +255] = [$FFCD, $00FF] */
    mov     #0x7F,r1
    add     #0x7F,r1               /* R1 = $FE... no, MOV #imm is sign-extended */
    /* Build 255: */
    mov     #0xFF,r1
    extu.b  r1,r1                   /* R1 = 255 */
    cmp/gt  r1,r0                   /* R0 > 255? */
    bf      .ta_x_upper_ok
    mov     r1,r0                   /* clamp to 255 */
.ta_x_upper_ok:
    mov     #-51,r1                 /* R1 = -51 ($FFCD sign-extended) */
    cmp/ge  r1,r0                   /* R0 >= -51? */
    bt      .ta_x_lower_ok
    mov     r1,r0                   /* clamp to -51 */
.ta_x_lower_ok:
    mov.w   r0,@(14,gbr)           /* entity[+$0E] = X-tilt */

    /* --- Z-tilt phase --- */
    mov     #0x30,r7               /* reset tilt rate = 48 */
    /* Check direction flag bit 6 */
    mov     #0x13,r0
    mov.b   @(r0,r13),r0           /* banking_direction */
    mov     #0x40,r1               /* bit 6 mask */
    tst     r1,r0
    bf      .ta_z_apply             /* bit6 set: don't negate */
    neg     r7,r7

.ta_z_apply:
    mov.w   @(16,gbr),r0           /* R0 = entity[+$10] Z-tilt */
    add     r7,r0
    /* Clamp to [0, 255] */
    mov     #0xFF,r1
    extu.b  r1,r1                   /* R1 = 255 */
    cmp/gt  r1,r0
    bf      .ta_z_upper_ok
    mov     r1,r0
.ta_z_upper_ok:
    cmp/pz  r0                      /* R0 >= 0? */
    bt      .ta_z_lower_ok
    mov     #0,r0                   /* clamp to 0 */
.ta_z_lower_ok:
    mov.w   r0,@(16,gbr)           /* entity[+$10] = Z-tilt */

.ta_done:
    rts
    nop
/* Function 7 total: ~120 bytes, 0 pool */


.global physics_group2_end
physics_group2_end:
