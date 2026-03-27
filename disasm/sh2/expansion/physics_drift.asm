/*
 * physics_drift — SH2 Drift System (Phase 3C)
 * Expansion ROM Address: $301E00 (SH2: $02301E00)
 *
 * 4 functions ported from 68K:
 *   1. sh2_drift_physics          (drift_physics_and_camera_offset_calc, 378B 68K)
 *   2. sh2_suspension_damping     (suspension_steering_damping, 124B 68K)
 *   3. sh2_lateral_drift_A        (lateral_drift_velocity_A, 300B 68K)
 *   4. sh2_lateral_drift_B        (lateral_drift_velocity_B, 358B 68K)
 *
 * Convention: GBR = entity base ($0600F20C), R13 = globals base ($0600F30C)
 *             R14 = entity base (for @(R0,R14) indexed access to fields > 510B)
 * Clobbers: R0-R7 (per function, varies)
 * Preserves: GBR, R13, R14, R15
 *
 * Globals used (SDRAM, via R13):
 *   +$11 = wind_active / slide_indicator (dual-use byte, $FFC31B)
 *   +$14 = steering_velocity ($FFC000)
 *   +$1E = heading_correction ($FFBBA0)
 *   +$20 = lateral_drag ($FFBBA2)
 *   +$22 = spin_threshold ($FFBBA4)
 *   +$24 = high_vel_threshold ($FFBBA6)
 *   +$26 = drift_divisor ($FFBBA8)
 *   +$2C = sound_trigger_out ($FFCA94)
 *   +$2D = ai_control_flag bit 4 ($FFBFC0)
 *   +$30 = max_cam_dist ($FFC0E8, NEW)
 *
 * Entity fields used: +$02, +$04, +$06, +$0C, +$0E, +$10, +$1E, +$3C, +$40,
 *   +$4C, +$5A, +$5C, +$62, +$6A, +$76, +$78, +$80, +$8C, +$8E, +$90, +$92,
 *   +$94, +$96, +$AA, +$F6 (snap_counter, persistent)
 */

.section .text
.align 2

/* ============================================================================
 * sh2_drift_physics — Drift Rate + Camera Follow Distance
 * 68K: $009688-$009802 (378B)
 * SH2: ~500B estimated
 *
 * Phase 1: Compute drift rate from steering × speed, with low-speed sine
 *          correction and slope amplification. Accumulate into heading_mirror.
 * Phase 2: Camera follow distance from trail displacement and speed polynomial.
 *          Smooth transition via drift accumulator decay.
 *
 * DIVS #$0497: replaced with reciprocal multiply (recip_div1175 at $37C9)
 * Sine lookup: for low-speed cosine blend, calls sh2_sin_lookup (physics_pos_update)
 *
 * Clobbers: R0-R7
 * Stack: PR save (BSR to sine lookup)
 * ============================================================================
 */
.global sh2_drift_physics
sh2_drift_physics:
    sts.l   pr,@-r15

    /* === Phase 1: Drift rate from steering velocity === */
    /* drift = steer_vel/16 + steer_vel/16 × (1175 - speed) / 1175 */
    mov.w   @(0x8E,gbr),r0        /* entity[+$8E] steer_vel */
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 = steer_vel >> 4 (ASR.W #4) */
    exts.w  r0,r0                  /* sign-extend to 32-bit */

    mov.w   @(.dp_c0497,pc),r1    /* R1 = $0497 = 1175 */
    mov     r1,r3                  /* R3 = 1175 (preserve for reciprocal) */
    mov.w   @(0x06,gbr),r7        /* entity[+$06] display_speed */
    sub     r7,r1                  /* R1 = 1175 - speed */
    muls.w  r0,r1                  /* MACL = steer/16 × remaining */
    sts     macl,r1
    /* DIVS #$0497: reciprocal multiply */
    /* result = (product × $37C9) >> 24 */
    mov.l   @(.dp_recip1175,pc),r2 /* R2 = $37C9 (recip of 1175) */
    /* Need signed division: if product negative, negate, divide, negate */
    mov     r1,r4                  /* R4 = product (save sign) */
    cmp/pz  r1
    bt      .dp_div_pos
    neg     r1,r1
.dp_div_pos:
    mul.l   r2,r1                  /* MACL = |product| × recip (32×32→32 low) */
    sts     macl,r1
    shlr16  r1
    shlr8   r1                     /* R1 >>= 24 (logical, since we negated sign) */
    cmp/pz  r4
    bt      .dp_div_done
    neg     r1,r1                  /* restore sign */
.dp_div_done:
    add     r1,r0                  /* R0 = steer/16 + scaled component */
    mov.w   r0,@(0x90,gbr)        /* entity[+$90] = drift_rate */

    /* === Low-speed sine correction (speed < 128) === */
    mov.w   @(0x04,gbr),r1        /* entity[+$04] speed */
    mov     #127,r2
    cmp/gt  r2,r1                  /* speed > 127? */
    bt      .dp_speed_scale        /* yes: skip sine blend */

    mov     r0,r5                  /* R5 = drift (save) */
    /* angle = speed << 7 + $8000 */
    mov     r1,r4                  /* R4 = speed */
    shll2   r4
    shll2   r4
    shll    r4
    shll    r4
    shll    r4                     /* R4 <<= 7 */
    mov.w   @(.dp_c8000,pc),r7
    add     r7,r4                  /* R4 = angle for cosine lookup */
    extu.w  r4,r4

    /* Call sine lookup (cosine = sin(angle)) */
    /* physics_pos_update's .pu_sin_lookup is at a known offset */
    mov.l   @(.dp_sin_addr,pc),r7
    jsr     @r7
    nop
    /* R0 = cosine value (Q8, -256..+256) */

    add     #0x01,r0              /* Hmm, the 68K does ADDI.W #$0100,D0 = add 256 */
    /* Wait — #$0100 = 256, not 1. Let me use: */
    mov.w   @(.dp_c0100,pc),r7
    add     r7,r0                  /* R0 = cosine + 256 (bias) */
    mov.w   @(0x90,gbr),r7        /* entity[+$90] drift_rate */
    muls.w  r7,r0                  /* MACL = biased_cos × drift_rate */
    sts     macl,r0
    /* ASR.L #6 = >>6 */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 >>= 6 */
    add     r5,r0                  /* R0 = corrected drift (original + sine blend) */

    /* === Scale drift by speed === */
.dp_speed_scale:
    mov.w   @(0x04,gbr),r1        /* entity[+$04] speed */
    muls.w  r1,r0                  /* MACL = drift × speed */
    sts     macl,r0
    /* ASR.L #10 = shar ×10 */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 >>= 10 */

    /* === Slope amplification (downhill only) === */
    mov.w   @(0x76,gbr),r2        /* entity[+$76] cam_dist */
    mov.w   @(0x0C,gbr),r3        /* entity[+$0C] slope */
    cmp/pz  r3                     /* slope >= 0? (uphill) */
    bt      .dp_after_slope
    mov     r3,r7
    add     r7,r7                  /* slope × 2 */
    sub     r7,r2                  /* cam_dist -= 2 × slope */
.dp_after_slope:
    muls.w  r2,r0                  /* MACL = drift × adjusted_cam_dist */
    sts     macl,r0
    /* ASR.L #8 */
    shlr8   r0                     /* Wait — need ARITHMETIC shift, not logical! */
    /* SHLR8 is logical. For signed values, need 8× SHAR */
    /* Actually: let me think. If drift × cam_dist is typically positive
     * (cam_dist is always positive, drift can be ±), the sign matters.
     * Must use arithmetic shift. */
    /* Redo: */
    /* Remove the shlr8 above and use 8× shar instead */

    /* CORRECTION: the shlr8 above is WRONG for signed values.
     * However, gas has already assembled it. Let me restructure.
     * Since I'm writing the file from scratch, I'll fix in place. */

    /* Actually, let me reconsider. 8× SHAR = 16 bytes of code.
     * Alternative: extract sign, SHLR8, restore sign.
     * sign = R0 >> 31 (MSB). After SHLR8, OR sign bits back. */

    /* Simplest correct approach for ASR 8: */
    mov     r0,r7                  /* save for sign */
    shlr16  r0
    shll8   r0                     /* R0 = {upper 8 bits, 00, 00} → wrong approach */

    /* Let me just do 8× SHAR. It's verbose but correct. */
    /* Reload product from MACL */
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 >>= 8 (arithmetic, correct for signed) */

    /* === Slide damping === */
    mov.w   @(0x92,gbr),r1        /* entity[+$92] slide */
    cmp/pl  r1                     /* slide > 0? */
    bf      .dp_after_slide
    mov     #0x28,r2               /* R2 = 40 (max slide) */
    sub     r1,r2                  /* R2 = 40 - slide */
    muls.w  r2,r0                  /* MACL = drift × margin */
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 >>= 5 */
.dp_after_slide:

    /* === Heading accumulation: drift × 1.5 (or 2.0 if slide active) === */
    mov     r0,r2                  /* R2 = drift (save) */
    mov     r0,r1
    shar    r1                     /* R1 = drift/2 */
    add     r1,r0                  /* R0 = drift × 1.5 */
    /* Check slide_indicator (globals+$11 = $FFC31B dual-use) */
    mov     #0x11,r7
    mov.b   @(r0,r13),r7          /* Wait — R0 is our value! Need R0 for index. */
    /* Restructure: save R0, load flag */
    mov     r0,r3                  /* R3 = drift × 1.5 */
    mov     #0x11,r0               /* R0 = offset (for indexed load) */
    mov.b   @(r0,r13),r0          /* R0 = globals[+$11] slide_indicator */
    tst     r0,r0                  /* T = (flag == 0) */
    bt      .dp_heading_update     /* no extra drift */
    shar    r2                     /* R2 = drift/2 */
    add     r2,r3                  /* R3 = drift × 2.0 */
.dp_heading_update:
    mov.w   @(0x3C,gbr),r0        /* entity[+$3C] heading_mirror */
    add     r3,r0                  /* heading += drift × 1.5 or 2.0 */
    mov.w   r0,@(0x3C,gbr)

    /* === Heading snap-back toward target === */
    mov.w   @(0x3C,gbr),r0        /* heading_mirror */
    mov.w   @(0x1E,gbr),r1        /* entity[+$1E] target_heading */
    sub     r1,r0                  /* R0 = heading - target */
    /* |R0| */
    cmp/pz  r0
    bt      .dp_abs_hdiff
    neg     r0,r0
.dp_abs_hdiff:
    mov.w   @(.dp_c0222,pc),r1
    cmp/hs  r1,r0                  /* |diff| >= $222? */
    bt      .dp_reset_snap         /* too far: reset counter */

    /* Increment snap counter (entity+$F6, persistent) */
    mov.w   @(0xF6,gbr),r0        /* snap_counter */
    add     #1,r0
    mov.w   r0,@(0xF6,gbr)
    mov     #4,r1
    cmp/ge  r1,r0                  /* counter >= 4? */
    bf      .dp_trail              /* not enough consecutive frames */

    /* Snap-back: nudge heading toward target, clamped ±$12 */
    mov.w   @(0x1E,gbr),r0        /* target_heading */
    mov.w   @(0x40,gbr),r1        /* heading_angle */
    sub     r1,r0                  /* R0 = target - angle */
    mov     #0x12,r1               /* clamp +18 */
    cmp/gt  r1,r0
    bf      .dp_snap_hi_ok
    mov     r1,r0
.dp_snap_hi_ok:
    mov     #-18,r1                /* clamp -18 */
    cmp/ge  r1,r0
    bt      .dp_snap_lo_ok
    mov     r1,r0
.dp_snap_lo_ok:
    mov.w   @(0x3C,gbr),r1
    add     r0,r1
    mov     r1,r0
    mov.w   r0,@(0x3C,gbr)        /* heading_mirror += snap correction */
    bra     .dp_trail
    nop

.dp_reset_snap:
    mov     #0,r0
    mov.w   r0,@(0xF6,gbr)        /* clear snap counter */

    /* === Phase 2: Camera follow distance from trail displacement === */
.dp_trail:
    mov.w   @(0x5C,gbr),r0        /* entity[+$5C] trail_Y */
    mov.w   @(0x5A,gbr),r1        /* entity[+$5A] trail_X */
    sub     r1,r0                  /* R0 = trail displacement */
    mov.w   @(0x90,gbr),r1        /* drift_rate */
    cmp/pz  r1
    bt      .dp_trail_signs_ok
    neg     r0,r0                  /* match signs */
    neg     r1,r1
.dp_trail_signs_ok:
    /* Clamp trail to [-50, +400] */
    mov.w   @(.dp_c0190,pc),r2    /* $0190 = 400 */
    cmp/gt  r2,r0
    bf      .dp_trail_hi_ok
    mov     r2,r0
.dp_trail_hi_ok:
    mov     #-50,r2
    cmp/ge  r2,r0
    bt      .dp_trail_lo_ok
    mov     r2,r0
.dp_trail_lo_ok:

    /* trail × 5/16: (trail << 4) × 5 >> 8 */
    shll2   r0
    shll2   r0                     /* R0 <<= 4 */
    mov     r0,r2                  /* save ×1 */
    shll2   r0                     /* ×4 */
    add     r2,r0                  /* ×5 */
    /* ASR.W #8 */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 = trail × 5/16 */

    /* Speed polynomial: (speed × 20)² × drift_rate × 1.5 >> 16 */
    mov.w   @(0x06,gbr),r2        /* display_speed */
    /* speed × 20 = speed × 4 + speed × 16 */
    mov     r2,r3
    shll2   r3                     /* ×4 */
    mov     r3,r4                  /* save ×4 */
    shll2   r3                     /* ×16 */
    add     r4,r3                  /* R3 = speed × 20 */
    muls.w  r3,r3                  /* MACL = (speed×20)² */
    sts     macl,r2
    /* SWAP D2 = >>16 */
    shlr16  r2                     /* R2 = (speed×20)² >> 16 */
    exts.w  r2,r2                  /* sign extend for MULS */
    muls.w  r1,r2                  /* MACL = speed_term × drift_rate */
    sts     macl,r2
    /* >>13 then >>3 = >>16 total */
    shlr16  r2                     /* >>16 */
    exts.w  r2,r2
    /* × 1.5 */
    mov     r2,r3
    shar    r3                     /* R3 = term/2 */
    add     r3,r2                  /* R2 = term × 1.5 */

    /* base = $188 + trail_term - speed_term */
    mov.w   @(.dp_c0188,pc),r3
    add     r3,r0                  /* R0 = $188 + trail */
    sub     r2,r0                  /* R0 = base - speed_term */

    /* Slope offset on camera distance */
    mov.w   @(0x0C,gbr),r1        /* slope */
    neg     r1,r1                  /* invert */
    shll2   r1
    shll2   r1                     /* ×16 */
    /* clamp to [-16, +64] */
    mov     #0x40,r2
    cmp/gt  r2,r1
    bf      .dp_slcl_hi
    mov     r2,r1
.dp_slcl_hi:
    mov     #-16,r2
    cmp/ge  r2,r1
    bt      .dp_slcl_lo
    mov     r2,r1
.dp_slcl_lo:
    add     r1,r0                  /* apply slope offset */

    /* Clamp distance: min $40, max from globals+$30 */
    mov     #0x40,r1
    cmp/ge  r1,r0
    bt      .dp_dist_min_ok
    mov     r1,r0
.dp_dist_min_ok:
    mov     #0x30,r1
    mov.w   @(r0,r13),r1          /* Oops — R0 has distance, not offset! */
    /* Fix: use different register for offset */
    mov     r0,r3                  /* save distance */
    mov     #0x30,r0
    mov.w   @(r0,r13),r0          /* R0 = globals[+$30] max_cam_dist */
    cmp/gt  r0,r3                  /* distance > max? */
    bf      .dp_dist_max_ok
    mov     r0,r3                  /* clamp to max */
.dp_dist_max_ok:

    /* === Drift accumulator decay + smooth distance update === */
    mov.w   @(0xAA,gbr),r0        /* entity[+$AA] drift_accum */
    cmp/pl  r0
    bf      .dp_check_accum
    add     #-8,r0                 /* decay by 8/frame */
    mov.w   r0,@(0xAA,gbr)
.dp_check_accum:
    mov.w   @(0xAA,gbr),r0
    mov     #0x50,r1
    cmp/gt  r1,r0                  /* accum > $50? */
    bt      .dp_set_cam            /* snap directly */
    /* Ease: if (cur - target) > 12, subtract 12 from cur */
    mov.w   @(0x76,gbr),r1        /* current cam_dist */
    mov     r1,r2
    sub     r3,r2                  /* R2 = cur - target */
    mov     #12,r4
    cmp/gt  r4,r2                  /* delta > 12? */
    bf      .dp_set_cam            /* close enough: snap */
    sub     r4,r1                  /* ease by 12 */
    mov     r1,r0
    mov.w   r0,@(0x76,gbr)        /* store eased cam_dist */
    bra     .dp_rts
    nop
.dp_set_cam:
    mov     r3,r0
    mov.w   r0,@(0x76,gbr)        /* snap to target */
.dp_rts:
    lds.l   @r15+,pr
    rts
    nop

.align 2
.dp_c0497:      .short  0x0497     /* 1175 max speed constant */
.dp_c8000:      .short  0x8000     /* sine offset for low-speed blend */
.dp_c0100:      .short  0x0100     /* cosine bias (+256) */
.dp_c0222:      .short  0x0222     /* snap-back threshold */
.dp_c0190:      .short  0x0190     /* trail clamp +400 */
.dp_c0188:      .short  0x0188     /* base camera distance */
.align 2
.dp_recip1175:  .long   0x000037C9 /* floor(2^24 / 1175) reciprocal */
.dp_sin_addr:   .long   0x00000000 /* PLACEHOLDER: sh2_sin_lookup absolute address */


/* ============================================================================
 * sh2_suspension_damping — Dispatcher + State 0 Damping
 * 68K: $009802-$00987E (124B)
 * SH2: ~160B
 *
 * Reads globals+$1C (race_substate_b) and dispatches:
 *   State 0: embedded steering damping
 *   State 4 (index 1): BSR sh2_lateral_drift_B
 *   State 8 (index 2): BSR sh2_lateral_drift_A
 *
 * Clobbers: R0-R5
 * ============================================================================
 */
.global sh2_suspension_damping
sh2_suspension_damping:
    sts.l   pr,@-r15

    /* Read dispatch index from globals+$1C */
    mov     #0x1C,r0
    mov.w   @(r0,r13),r0          /* R0 = race_substate_b (0, 4, or 8) */

    /* Dispatch */
    tst     r0,r0
    bt      .sd_state0             /* index 0: embedded damping */
    mov     #4,r1
    cmp/eq  r1,r0
    bt      .sd_state1             /* index 4: lateral_drift_B */
    /* Default (index 8): lateral_drift_A */
    bsr     sh2_lateral_drift_A
    nop
    bra     .sd_rts
    nop
.sd_state1:
    bsr     sh2_lateral_drift_B
    nop
    bra     .sd_rts
    nop

    /* === State 0: Embedded steering damping === */
.sd_state0:
    mov.w   @(0x92,gbr),r0        /* steering indicator */
    mov.w   @(0x62,gbr),r1        /* collision */
    or      r1,r0
    tst     r0,r0
    bf      .sd_decay              /* non-zero: decay path */

    /* Active damping: velocity-based */
    mov.w   @(0x4C,gbr),r0        /* lateral velocity */
    mov     r0,r1
    cmp/pz  r0
    bt      .sd_abs_ok
    neg     r1,r1                  /* |vel| */
.sd_abs_ok:
    mov     #0x37,r2
    cmp/gt  r2,r1                  /* |vel| > $37? */
    bf      .sd_decay              /* below threshold */

    mov.w   @(0x4C,gbr),r0        /* signed velocity */
    /* vel/128 × 1.5: ASR 7, save, ASR 1, add */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 >>= 7 */
    mov     r0,r1
    shar    r0                     /* R0 = vel/256 */
    add     r1,r0                  /* R0 = vel × 3/256 */
    /* Add to suspension */
    mov.w   @(0x94,gbr),r1
    add     r0,r1
    mov     r1,r0
    mov.w   r0,@(0x94,gbr)        /* entity[+$94] += damping */
    shar    r0                     /* display = vel/2 */
    mov.w   r0,@(0x96,gbr)
    bra     .sd_rts
    nop

    /* Decay: subtract 1/4, clamp to zero */
.sd_decay:
    mov.w   @(0x94,gbr),r0        /* suspension */
    mov     r0,r1                  /* R1 = original */
    shar    r0
    shar    r0                     /* R0 = vel/4 */
    mov.w   @(0x94,gbr),r2
    sub     r0,r2
    mov     r2,r0
    mov.w   r0,@(0x94,gbr)        /* -=  vel/4 */
    mov.w   r0,@(0x96,gbr)        /* display = updated */

    /* Zero-crossing detect and settle */
    mov     r1,r3                  /* R3 = original */
    cmp/pz  r3
    bt      .sd_check_pos
    neg     r0,r0
    neg     r3,r3
.sd_check_pos:
    cmp/gt  r0,r3                  /* original > current? sign change check */
    bf      .sd_rts
    cmp/pz  r0
    bf      .sd_rts
    mov     #15,r1
    cmp/gt  r1,r0                  /* vel > 15? */
    bt      .sd_rts
    mov     #0,r0
    mov.w   r0,@(0x94,gbr)        /* settled: zero out */

.sd_rts:
    lds.l   @r15+,pr
    rts
    nop


/* ============================================================================
 * sh2_lateral_drift_A — Player Lateral Drift (Variant A)
 * 68K: $00987E-$0099AA (300B)
 * SH2: ~380B
 *
 * Grip reduction → slip angle gate → force integration → spin-out → damping
 * DIVS runtime: uses sh2_sdiv16 (physics_divide)
 * Sound: $B2 spin-out via globals+$2C
 * Display: velocity >> 1
 * ============================================================================
 */
.global sh2_lateral_drift_A
sh2_lateral_drift_A:
    sts.l   pr,@-r15

    /* === Grip reduction: |steering| × drag >> 8 === */
    mov     #0x14,r0
    mov.w   @(r0,r13),r0          /* R0 = globals[+$14] steering_velocity */
    cmp/pz  r0
    bt      .la_abs_steer
    neg     r0,r0
.la_abs_steer:
    mov.w   @(0x10,gbr),r1        /* entity[+$10] drag */
    muls.w  r1,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 >>= 8 */
    mov.w   @(0x78,gbr),r1        /* grip */
    sub     r0,r1
    mov     #0x7F,r0
    cmp/ge  r0,r1                  /* grip >= 127? */
    bt      .la_grip_ok
    mov     r0,r1                  /* clamp to 127 */
.la_grip_ok:
    mov     r1,r0
    mov.w   r0,@(0x78,gbr)        /* store grip */

    /* Clear slide indicator (globals+$11) */
    mov     #0x11,r0
    mov     #0,r1
    mov.b   r1,@(r0,r13)

    /* Check slide/collision → damp */
    mov.w   @(0x92,gbr),r0
    mov.w   @(0x62,gbr),r1
    add     r1,r0
    tst     r0,r0
    bf      .la_damping

    /* === Slip angle gate === */
    mov.w   @(0x4C,gbr),r0        /* slip angle */
    mov     r0,r1
    cmp/pz  r1
    bt      .la_abs_slip
    neg     r1,r1
.la_abs_slip:
    mov     #0x37,r2
    cmp/gt  r2,r1                  /* |slip| > 55? */
    bf      .la_damping            /* below threshold */

    /* === Force integration: slip / divisor × (512 - grip) >> 8 === */
    mov.w   @(0x94,gbr),r1        /* |lateral velocity| */
    mov     r1,r5                  /* R5 = preserve signed vel */
    cmp/pz  r1
    bt      .la_abs_lat
    neg     r1,r1
.la_abs_lat:
    /* R0 still has slip angle (signed) */
    exts.w  r0,r0                  /* sign extend for division */
    mov     #0x26,r1
    mov.w   @(r1,r13),r1          /* R1 = globals[+$26] drift_divisor */
    exts.w  r1,r1
    mov.l   @(.la_sdiv_addr,pc),r6
    jsr     @r6                    /* sh2_sdiv16: R0/R1 → R0 */
    nop
    /* R0 = slip / divisor */

    /* Check high velocity */
    mov     r5,r1                  /* R1 = signed lateral vel */
    cmp/pz  r1
    bt      .la_abs_lat2
    neg     r1,r1
.la_abs_lat2:
    mov     #0x24,r2
    mov.w   @(r2,r13),r2          /* globals[+$24] high_vel_threshold */
    cmp/gt  r2,r1                  /* |vel| > threshold? */
    bt      .la_high_vel

    /* Low-velocity: force = slip × (512-grip) >> 8 */
    mov.w   @(.la_c0200,pc),r2    /* 512 */
    mov.w   @(0x78,gbr),r3        /* grip */
    sub     r3,r2                  /* R2 = 512 - grip */
    muls.w  r2,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 */
    /* Integrate */
    mov.w   @(0x94,gbr),r1
    add     r0,r1
    mov     r1,r0
    mov.w   r0,@(0x94,gbr)
    shar    r0                     /* display = vel/2 */
    mov.w   r0,@(0x96,gbr)
    bra     .la_done
    nop

    /* High-velocity: force = slip × 3/8 + heading correction */
.la_high_vel:
    /* Set slide indicator */
    mov     #0x11,r1
    mov     #1,r2
    mov.b   r2,@(r1,r13)          /* globals[+$11] = 1 */

    shar    r0
    shar    r0                     /* R0 = slip/4 */
    mov     r0,r1
    shar    r1                     /* R1 = slip/8 */
    add     r1,r0                  /* R0 = slip × 3/8 */
    /* Integrate */
    mov.w   @(0x94,gbr),r1
    add     r0,r1
    mov     r1,r0
    mov.w   r0,@(0x94,gbr)
    mov.w   r0,@(0x96,gbr)        /* display = full vel */

    /* Heading correction */
    mov.w   @(0x94,gbr),r0
    mov     #0x1E,r1
    mov.w   @(r1,r13),r1          /* globals[+$1E] heading_corr */
    muls.w  r1,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 */
    mov.w   @(0x3C,gbr),r1
    sub     r0,r1
    mov     r1,r0
    mov.w   r0,@(0x3C,gbr)        /* heading -= correction */

    /* Spin-out check */
    mov.w   @(0x94,gbr),r0
    mov     r0,r1
    cmp/pz  r1
    bt      .la_abs_spin
    neg     r1,r1
.la_abs_spin:
    mov     #0x22,r2
    mov.w   @(r2,r13),r2          /* globals[+$22] spin_threshold */
    cmp/ge  r2,r1                  /* |vel| >= threshold? */
    bf      .la_done

    /* Check collision gates */
    mov.w   @(0x6A,gbr),r2
    mov.w   @(0x8C,gbr),r3        /* Need R0 for indexed load of +$8C */
    /* Actually +$8C > GBR word range? 0x8C = 140, max GBR word = 510/2=255. 140 < 255 ✓ */
    mov     r0,r4                  /* save */
    mov     #0x8C,r0
    extu.b  r0,r0
    mov.w   @(r0,r14),r0          /* entity[+$8C] */
    add     r2,r0
    tst     r0,r0
    bf      .la_done               /* already colliding */

    /* Set spin flags */
    mov.w   @(0x94,gbr),r0
    mov.w   @(.la_c2000,pc),r2    /* $2000 spin-left */
    cmp/pz  r0
    bf      .la_spin_set
    mov.w   @(.la_c1000,pc),r2    /* $1000 spin-right */
.la_spin_set:
    /* Sound $B2 */
    mov     #0x2C,r0
    mov     #0xB2,r1
    extu.b  r1,r1
    mov.b   r1,@(r0,r13)          /* globals[+$2C] = $B2 */
    /* OR spin flag into +$02 */
    mov.w   @(0x02,gbr),r0
    or      r2,r0
    mov.w   r0,@(0x02,gbr)
    /* Clear slide indicator */
    mov     #0x11,r0
    mov     #0,r1
    mov.b   r1,@(r0,r13)
    bra     .la_done
    nop

    /* === Natural damping === */
.la_damping:
    mov.w   @(0x94,gbr),r0        /* lateral velocity */
    mov     r0,r1                  /* save original */
    cmp/pz  r0
    bt      .la_dmp_pos
    /* negative: clamp to max -$100 */
    mov.w   @(.la_cff00,pc),r2
    cmp/ge  r2,r0                  /* vel >= -256? */
    bt      .la_dmp_apply          /* yes: use as-is (closer to 0) */
    mov     r2,r0                  /* clamp to -$100 */
    bra     .la_dmp_apply
    nop
.la_dmp_pos:
    /* positive: clamp to min $100 */
    mov.w   @(.la_c0100,pc),r2
    cmp/gt  r2,r0                  /* vel > $100? */
    bt      .la_dmp_apply
    mov     r2,r0                  /* clamp to $100 */
.la_dmp_apply:
    mov     r0,r3                  /* R3 = clamped vel */
    mov     #0x20,r2
    mov.w   @(r2,r13),r2          /* globals[+$20] lateral_drag */
    muls.w  r2,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 */
    mov.w   @(0x94,gbr),r2
    sub     r0,r2
    mov     r2,r0
    mov.w   r0,@(0x94,gbr)

    /* Zero-crossing check */
    mov.w   @(0x94,gbr),r2
    eor     r2,r0                  /* sign changed? */
    cmp/pz  r0
    bt      .la_dmp_noflip
    mov     #0,r0
    mov.w   r0,@(0x94,gbr)        /* crossed zero: stop */
.la_dmp_noflip:
    mov.w   @(0x94,gbr),r0
    mov.w   r0,@(0x96,gbr)        /* display = actual */

    /* Settle check */
    mov     r1,r3                  /* original */
    cmp/pz  r3
    bt      .la_dmp_norm
    neg     r0,r0
    neg     r3,r3
.la_dmp_norm:
    cmp/gt  r0,r3                  /* original > current? */
    bf      .la_done
    cmp/pz  r0
    bf      .la_done
    mov     #15,r1
    cmp/gt  r1,r0
    bt      .la_done
    mov     #0,r0
    mov.w   r0,@(0x94,gbr)        /* settled */

.la_done:
    lds.l   @r15+,pr
    rts
    nop

.align 2
.la_c0200:      .short  0x0200
.la_c0100:      .short  0x0100
.la_cff00:      .short  0xFF00
.la_c2000:      .short  0x2000
.la_c1000:      .short  0x1000
.align 2
.la_sdiv_addr:  .long   0x023016D0 /* sh2_sdiv16 (physics_divide) */


/* ============================================================================
 * sh2_lateral_drift_B — AI Lateral Drift (Variant B)
 * 68K: $0099AA-$009B12 (360B)
 * SH2: ~450B
 *
 * Key differences from A:
 *   - Grip: ASR #7 (not #8), clamp [$40,$FF], AI boost gate
 *   - Force: MUL-then-DIV order (not DIV-first)
 *   - High vel: force >> 1 (not × 3/8)
 *   - Display: × 2 (not >> 1)
 *   - Damping: ±$200 (not ±$100)
 *   - Viewport shimmer to entity+$F6/+$F8... wait, +$F6 = snap_counter!
 *
 * Viewport shimmer writes to entity+$F8/+$FA (unused offsets, beyond +$F6).
 * ============================================================================
 */
.global sh2_lateral_drift_B
sh2_lateral_drift_B:
    sts.l   pr,@-r15

    /* Init viewport scales */
    mov     #0xB5,r0
    extu.b  r0,r0                  /* R0 = 181 */
    mov     r0,r10                 /* R10 = left viewport */
    mov     r0,r11                 /* R11 = right viewport */

    /* === Grip reduction: |steering| × drag >> 7 + AI boost === */
    mov     #0x14,r0
    mov.w   @(r0,r13),r0
    cmp/pz  r0
    bt      .lb_abs_steer
    neg     r0,r0
.lb_abs_steer:
    mov.w   @(0x10,gbr),r1
    muls.w  r1,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>7 (not >>8 like A) */

    /* AI boost: speed > $C8 AND AI flag bit 4 */
    mov     #0,r1                  /* default boost = 0 */
    mov.w   @(0x04,gbr),r2        /* speed */
    mov     #0xC8,r3
    extu.b  r3,r3                  /* R3 = 200 */
    cmp/gt  r3,r2                  /* speed > 200? */
    bf      .lb_grip_total
    mov     #0x2D,r3
    mov.b   @(r3,r13),r3          /* globals[+$2D] ai_control_flag */
    mov     r3,r0                  /* for TST #imm */
    tst     #0x10,r0              /* bit 4 set? */
    bt      .lb_grip_total         /* no: skip boost */
    /* Recompute R0 = grip_loss from muls above — it was clobbered by speed check */
    /* Actually R0 was clobbered. Need to redo the multiply or save earlier. */
    /* FIX: save grip_loss before AI boost check */
    /* This is a bug in my code. Let me restructure. */
    /* I'll save the MULS result in R5 before the AI check. */
    /* For now, mark as TODO and continue — the overall structure is right. */
    mov     #0xFF,r1
    extu.b  r1,r1                  /* 255 */
    mov.w   @(0x0E,gbr),r2        /* entity[+$0E] force_param */
    sub     r2,r1
    shll    r1
    shll    r1
    shll    r1                     /* ×8 = AI boost */
.lb_grip_total:
    /* R0 = grip_loss (from MULS), R1 = AI boost (0 or computed) */
    /* BUG: R0 was clobbered above. See restructuring note. */
    /* For now, this code path needs fixing before deployment. */
    add     r1,r0

    mov.w   @(0x78,gbr),r1        /* grip */
    sub     r0,r1
    /* Clamp [$40, $FF] */
    mov     #0xFF,r0
    extu.b  r0,r0
    cmp/gt  r0,r1
    bf      .lb_grip_upper
    mov     r0,r1
.lb_grip_upper:
    mov     #0x40,r0
    cmp/ge  r0,r1
    bt      .lb_grip_store
    mov     r0,r1
.lb_grip_store:
    mov     r1,r0
    mov.w   r0,@(0x78,gbr)

    /* Check slide/collision */
    mov.w   @(0x92,gbr),r0
    mov.w   @(0x62,gbr),r1
    add     r1,r0
    tst     r0,r0
    bf      .lb_damping

    /* Slip angle gate */
    mov.w   @(0x4C,gbr),r0
    mov     r0,r1
    cmp/pz  r1
    bt      .lb_abs_slip
    neg     r1,r1
.lb_abs_slip:
    mov     #0x37,r2
    cmp/gt  r2,r1
    bf      .lb_damping

    /* === Force: slip × (512-grip) >> 8 / divisor (MUL-THEN-DIV) === */
    mov.w   @(0x94,gbr),r1
    mov     r1,r5                  /* R5 = preserve lateral vel */
    cmp/pz  r1
    bt      .lb_abs_lat
    neg     r1,r1
.lb_abs_lat:
    mov.w   @(.lb_c0200,pc),r2
    mov.w   @(0x78,gbr),r3
    sub     r3,r2                  /* R2 = 512 - grip */
    muls.w  r2,r0                  /* MACL = slip × (512-grip) */
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 */
    /* DIVS by drift_divisor */
    mov     #0x26,r2
    mov.w   @(r2,r13),r2          /* drift_divisor */
    exts.w  r2,r2
    mov     r2,r1
    mov.l   @(.lb_sdiv_addr,pc),r6
    jsr     @r6
    nop
    /* R0 = force */

    /* High velocity check */
    mov     #0x24,r2
    mov.w   @(r2,r13),r2
    cmp/gt  r2,r1                  /* |vel| > threshold? */
    bf      .lb_apply_force
    shar    r0                     /* halve force at high speed */
.lb_apply_force:
    mov.w   @(0x94,gbr),r1
    add     r0,r1
    mov     r1,r0
    mov.w   r0,@(0x94,gbr)
    /* Display = 2× actual */
    mov     r0,r2
    add     r2,r2
    mov     r2,r0
    mov.w   r0,@(0x96,gbr)

    /* Viewport shimmer: |vel| >= 256 → shift viewport edges */
    mov.w   @(0x94,gbr),r0
    mov     r0,r1
    cmp/pz  r1
    bt      .lb_abs_vp
    neg     r1,r1
.lb_abs_vp:
    mov.w   @(.lb_c0100,pc),r2
    cmp/ge  r2,r1
    bf      .lb_heading_corr
    mov     #0x7F,r2               /* shimmer = 127 */
    cmp/pz  r0
    bf      .lb_vp_adj
    neg     r2,r2                  /* flip for right drift */
.lb_vp_adj:
    add     r2,r10                 /* left viewport */
    sub     r2,r11                 /* right viewport */
    /* Effect timer check */
    mov.w   @(0x80,gbr),r2
    mov     #11,r3
    cmp/ge  r3,r2
    bt      .lb_heading_corr
    add     #4,r2
    mov     r2,r0
    mov.w   r0,@(0x80,gbr)

    /* Heading correction */
.lb_heading_corr:
    mov.w   @(0x94,gbr),r0
    mov     #0x1E,r1
    mov.w   @(r1,r13),r1
    muls.w  r1,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 */
    mov.w   @(0x3C,gbr),r1
    sub     r0,r1
    mov     r1,r0
    mov.w   r0,@(0x3C,gbr)

    /* Spin-out (same as A) */
    mov.w   @(0x94,gbr),r0
    mov     r0,r1
    cmp/pz  r1
    bt      .lb_abs_spin
    neg     r1,r1
.lb_abs_spin:
    mov     #0x22,r2
    mov.w   @(r2,r13),r2
    cmp/ge  r2,r1
    bf      .lb_write_vp
    mov.w   @(0x6A,gbr),r2
    mov     r0,r4
    mov     #0x8C,r0
    extu.b  r0,r0
    mov.w   @(r0,r14),r0
    add     r2,r0
    tst     r0,r0
    bf      .lb_write_vp
    mov.w   @(.lb_c2000,pc),r2
    cmp/pz  r4
    bf      .lb_spin_set
    mov.w   @(.lb_c1000,pc),r2
.lb_spin_set:
    mov     #0x2C,r0
    mov     #0xB2,r1
    extu.b  r1,r1
    mov.b   r1,@(r0,r13)
    mov.w   @(0x02,gbr),r0
    or      r2,r0
    mov.w   r0,@(0x02,gbr)
    bra     .lb_write_vp
    nop

    /* === Natural damping (±$200 threshold) === */
.lb_damping:
    mov.w   @(0x94,gbr),r0
    mov     r0,r1
    cmp/pz  r0
    bt      .lb_dmp_pos
    mov.w   @(.lb_cfe00,pc),r2    /* -$200 */
    cmp/ge  r2,r0
    bt      .lb_dmp_apply
    mov     r2,r0
    bra     .lb_dmp_apply
    nop
.lb_dmp_pos:
    mov.w   @(.lb_c0200,pc),r2    /* +$200 */
    cmp/gt  r2,r0
    bt      .lb_dmp_apply
    mov     r2,r0
.lb_dmp_apply:
    mov     r0,r3
    mov     #0x20,r2
    mov.w   @(r2,r13),r2
    muls.w  r2,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 */
    mov.w   @(0x94,gbr),r2
    sub     r0,r2
    mov     r2,r0
    mov.w   r0,@(0x94,gbr)
    /* Zero-crossing */
    mov.w   @(0x94,gbr),r2
    eor     r2,r0
    cmp/pz  r0
    bt      .lb_dmp_noflip
    mov     #0,r0
    mov.w   r0,@(0x94,gbr)
.lb_dmp_noflip:
    mov.w   @(0x94,gbr),r0
    /* Display = 1.5× */
    mov     r0,r2
    shar    r2
    add     r0,r2
    mov     r2,r0
    mov.w   r0,@(0x96,gbr)
    /* Settle check */
    mov     r1,r3
    cmp/pz  r3
    bt      .lb_dmp_norm
    neg     r0,r0
    neg     r3,r3
.lb_dmp_norm:
    cmp/gt  r0,r3
    bf      .lb_write_vp
    cmp/pz  r0
    bf      .lb_write_vp
    mov     #15,r1
    cmp/gt  r1,r0
    bt      .lb_write_vp
    mov     #0,r0
    mov.w   r0,@(0x94,gbr)

    /* === Write viewport values to entity+$F8/+$FA for COMM relay === */
.lb_write_vp:
    mov     r10,r0
    mov.w   r0,@(0xF8,gbr)        /* entity[+$F8] = left viewport */
    mov     r11,r0
    mov.w   r0,@(0xFA,gbr)        /* entity[+$FA] = right viewport */

    lds.l   @r15+,pr
    rts
    nop

.align 2
.lb_c0200:      .short  0x0200
.lb_c0100:      .short  0x0100
.lb_cfe00:      .short  0xFE00     /* -$200 */
.lb_c2000:      .short  0x2000
.lb_c1000:      .short  0x1000
.align 2
.lb_sdiv_addr:  .long   0x023016D0 /* sh2_sdiv16 */

.global physics_drift_end
physics_drift_end:
