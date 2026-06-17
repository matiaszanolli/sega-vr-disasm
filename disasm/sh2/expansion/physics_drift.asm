/*
 * physics_drift — SH2 Drift System (Phase 3C)
 * Expansion ROM Address: $301E00 (SH2: $02301E00)
 *
 * 4 functions: drift_physics, suspension_damping, lateral_drift_A, lateral_drift_B
 *
 * Convention: GBR = entity base ($0600F20C), R13 = globals base ($0600F30C)
 *             R14 = entity base (for @(R0,R14) indexed access)
 *
 * SH2 REGISTER CONSTRAINTS (applied consistently throughout):
 *   - GBR load/store: destination/source MUST be R0
 *   - TST #imm: operand MUST be R0
 *   - Indexed @(R0,Rn): R0 MUST be the offset register
 *   Pattern: mov.w @(offset,gbr),r0; mov r0,rN  (load entity field to rN)
 *   Pattern: mov rN,r0; mov.w r0,@(offset,gbr)  (store rN to entity field)
 *   Pattern: mov #offset,r0; mov.w @(r0,r13),rN  (load globals to rN)
 *   Pattern: mov #offset,r0; mov.b rN,@(r0,r13)  (store byte to globals)
 *
 * Clobbers: R0-R7 (per function)
 * Preserves: GBR, R13, R14, R15
 */

.section .text
.align 2

/* ============================================================================
 * sh2_drift_physics — Drift Rate + Camera Follow Distance
 * 68K: $009688-$009802 (378B)
 *
 * Phase 1: drift rate from steering × speed (reciprocal ÷1175)
 * Phase 2: camera follow distance from trail + speed polynomial
 * Clobbers: R0-R7. Stack: PR save (BSR for sine lookup).
 * ============================================================================
 */
.global sh2_drift_physics
sh2_drift_physics:
    sts.l   pr,@-r15

    /* === Phase 1: drift rate === */
    /* steer_vel/16 + steer_vel/16 × (1175 - speed) / 1175 */
    mov.w   @(0x8E,gbr),r0        /* steer_vel */
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 = steer_vel >> 4 */
    exts.w  r0,r0
    mov     r0,r3                  /* R3 = steer/16 (preserved) */

    mov.w   @(.dp_c0497_near,pc),r1 /* R1 = 1175 */
    mov.w   @(0x06,gbr),r0        /* display_speed → R0 */
    mov     r0,r2                  /* R2 = speed */
    mov     r1,r0                  /* R0 = 1175 */
    sub     r2,r0                  /* R0 = 1175 - speed */
    muls.w  r3,r0                  /* MACL = steer/16 × remaining */
    sts     macl,r1                /* R1 = product */

    /* Reciprocal divide: product × $37C9 >> 24 (signed) */
    mov     r1,r4                  /* R4 = save sign */
    cmp/pz  r1
    bt      .dp_div_pos
    neg     r1,r1
.dp_div_pos:
    mov.l   @(.dp_recip1175,pc),r2
    mul.l   r2,r1
    sts     macl,r1
    shlr16  r1
    shlr8   r1                     /* R1 >>= 24 */
    cmp/pz  r4
    bt      .dp_div_done
    neg     r1,r1
.dp_div_done:
    add     r1,r3                  /* R3 = steer/16 + scaled part */
    mov     r3,r0
    mov.w   r0,@(0x90,gbr)        /* entity[+$90] = drift_rate */

    /* === Low-speed sine correction (speed < 128) === */
    mov.w   @(0x04,gbr),r0        /* speed */
    mov     r0,r1
    mov     #127,r2
    cmp/gt  r2,r1                  /* speed > 127? */
    bt      .dp_speed_scale

    mov     r3,r5                  /* R5 = drift (save) */
    /* angle = speed << 7 + $8000 */
    mov     r1,r4
    shll2   r4
    shll2   r4
    shll    r4
    shll    r4
    shll    r4                     /* R4 <<= 7 */
    mov.w   @(.dp_c8000_near,pc),r7
    add     r7,r4
    extu.w  r4,r4

    /* BSR sine lookup */
    mov.l   @(.dp_sin_addr,pc),r7
    jsr     @r7
    nop
    /* R0 = cosine value Q8 */

    mov.w   @(.dp_c0100_near,pc),r7
    add     r7,r0                  /* R0 = cosine + 256 (bias) */
    mov     r0,r7                  /* R7 = biased cosine */
    mov.w   @(0x90,gbr),r0        /* R0 = drift_rate */
    muls.w  r7,r0                  /* MACL = cos × drift */
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 >>= 6 */
    add     r5,r0                  /* R0 = corrected drift */
    mov     r0,r3                  /* R3 = drift (update) */

    /* Literal pool island (Phase 1 constants, within PC-relative range) */
    bra     .dp_speed_scale
    nop
.align 2
.dp_c0497_near: .short  0x0497     /* 1175 max speed */
.dp_c8000_near: .short  0x8000     /* sine offset */
.dp_c0100_near: .short  0x0100     /* cosine bias */

    /* === Scale drift by speed === */
.dp_speed_scale:
    mov.w   @(0x04,gbr),r0        /* speed */
    mov     r0,r1
    mov     r3,r0                  /* R0 = drift */
    muls.w  r1,r0                  /* MACL = drift × speed */
    sts     macl,r0
    /* ASR.L #10 */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 >>= 10 */
    mov     r0,r3                  /* R3 = drift_scaled (SAVE before slope GBR loads) */

    /* === Slope amplification === */
    mov.w   @(0x76,gbr),r0        /* cam_dist */
    mov     r0,r2                  /* R2 = cam_dist */
    mov.w   @(0x0C,gbr),r0        /* slope */
    mov     r0,r4                  /* R4 = slope */
    cmp/pz  r4
    bt      .dp_after_slope
    mov     r4,r7
    add     r7,r7                  /* slope × 2 */
    sub     r7,r2                  /* cam_dist -= 2×slope */
.dp_after_slope:
    /* R3 = drift_scaled, R2 = adjusted cam_dist */
    muls.w  r2,r3                  /* MACL = drift × cam_dist */
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 >>= 8 */
    mov     r0,r3                  /* R3 = drift after cam_dist scaling */

    /* === Slide damping === */
    mov.w   @(0x92,gbr),r0        /* slide */
    mov     r0,r1
    cmp/pl  r1                     /* slide > 0? */
    bf      .dp_after_slide
    mov     #0x28,r2               /* 40 */
    sub     r1,r2                  /* R2 = 40 - slide */
    mov     r3,r0                  /* R0 = drift */
    muls.w  r2,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>5 */
    mov     r0,r3                  /* R3 = slide-damped drift */
.dp_after_slide:

    /* === Heading accumulation: ×1.5 or ×2.0 === */
    mov     r3,r0                  /* R0 = drift */
    mov     r0,r2                  /* R2 = drift (for ×2.0 path) */
    mov     r0,r1
    shar    r1                     /* R1 = drift/2 */
    add     r1,r0                  /* R0 = drift × 1.5 */
    /* Check slide_indicator (globals+$11 = $FFC31B) */
    mov     r0,r3                  /* R3 = drift × 1.5 (save) */
    mov     #0x11,r0
    mov.b   @(r0,r13),r0          /* slide indicator */
    tst     r0,r0
    bt      .dp_heading_update
    shar    r2                     /* +drift/2 more */
    add     r2,r3                  /* R3 = drift × 2.0 */
.dp_heading_update:
    mov.w   @(0x3C,gbr),r0        /* heading_mirror */
    add     r3,r0
    mov.w   r0,@(0x3C,gbr)

    /* === Heading snap-back === */
    mov.w   @(0x3C,gbr),r0        /* heading_mirror */
    mov     r0,r1
    mov.w   @(0x1E,gbr),r0        /* target_heading */
    sub     r0,r1                  /* R1 = heading - target */
    mov     r1,r0
    cmp/pz  r0
    bt      .dp_abs_hdiff
    neg     r0,r0
.dp_abs_hdiff:
    mov.w   @(.dp_c0222,pc),r1
    cmp/hs  r1,r0                  /* |diff| >= $222? */
    bt      .dp_reset_snap

    /* Increment snap counter (entity+$F6) */
    mov.w   @(0xF6,gbr),r0
    add     #1,r0
    mov.w   r0,@(0xF6,gbr)
    mov     #4,r1
    cmp/ge  r1,r0
    bf      .dp_trail

    /* Snap correction: target - angle, clamped ±$12 */
    mov.w   @(0x1E,gbr),r0        /* target */
    mov     r0,r1
    mov.w   @(0x40,gbr),r0        /* angle */
    sub     r0,r1                  /* R1 = target - angle */
    mov     r1,r0
    mov     #0x12,r1
    cmp/gt  r1,r0
    bf      .dp_snap_hi
    mov     r1,r0
.dp_snap_hi:
    mov     #-18,r1
    cmp/ge  r1,r0
    bt      .dp_snap_lo
    mov     r1,r0
.dp_snap_lo:
    mov     r0,r2                  /* R2 = clamped correction */
    mov.w   @(0x3C,gbr),r0
    add     r2,r0
    mov.w   r0,@(0x3C,gbr)
    bra     .dp_trail
    nop

.dp_reset_snap:
    mov     #0,r0
    mov.w   r0,@(0xF6,gbr)

    /* === Phase 2: Camera follow distance === */
.dp_trail:
    mov.w   @(0x5C,gbr),r0        /* trail_Y */
    mov     r0,r1
    mov.w   @(0x5A,gbr),r0        /* trail_X */
    sub     r0,r1                  /* R1 = trail_Y - trail_X */
    mov     r1,r0                  /* R0 = displacement */
    mov.w   @(0x90,gbr),r0        /* drift_rate → clobbers displacement! */
    /* Fix: save displacement first */
    mov     r1,r4                  /* R4 = displacement (save) */
    mov.w   @(0x90,gbr),r0        /* drift_rate */
    mov     r0,r1                  /* R1 = drift_rate */
    mov     r4,r0                  /* R0 = displacement (restore) */
    cmp/pz  r1
    bt      .dp_trail_signs
    neg     r0,r0
    neg     r1,r1
.dp_trail_signs:
    /* Clamp to [-50, +400] */
    mov.w   @(.dp_c0190,pc),r2
    cmp/gt  r2,r0
    bf      .dp_trail_hi
    mov     r2,r0
.dp_trail_hi:
    mov     #-50,r2
    cmp/ge  r2,r0
    bt      .dp_trail_lo
    mov     r2,r0
.dp_trail_lo:
    /* trail × 5/16 */
    shll2   r0
    shll2   r0                     /* <<4 */
    mov     r0,r2
    shll2   r0                     /* ×4 */
    add     r2,r0                  /* ×5 */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 → trail×5/16 */
    mov     r0,r4                  /* R4 = trail_term */

    /* Speed polynomial: (speed×20)² × drift_rate × 1.5 >> 16 */
    mov.w   @(0x06,gbr),r0        /* display_speed */
    mov     r0,r2
    shll2   r2                     /* ×4 */
    mov     r2,r3
    shll2   r3                     /* ×16 */
    add     r2,r3                  /* R3 = speed × 20 */
    muls.w  r3,r3
    sts     macl,r2                /* R2 = (speed×20)² */
    shlr16  r2                     /* >>16 */
    exts.w  r2,r2
    muls.w  r1,r2                  /* MACL = speed² × drift_rate */
    sts     macl,r2
    shlr16  r2                     /* >>16 */
    exts.w  r2,r2
    /* ×1.5 */
    mov     r2,r3
    shar    r3
    add     r3,r2                  /* R2 = speed_term × 1.5 */

    /* base = $188 + trail_term - speed_term */
    mov.w   @(.dp_c0188,pc),r0
    add     r4,r0                  /* + trail_term */
    sub     r2,r0                  /* - speed_term */
    mov     r0,r3                  /* R3 = target distance */

    /* Slope offset */
    mov.w   @(0x0C,gbr),r0        /* slope */
    neg     r0,r0
    shll2   r0
    shll2   r0                     /* ×16 */
    mov     #0x40,r1
    cmp/gt  r1,r0
    bf      .dp_slcl_hi
    mov     r1,r0
.dp_slcl_hi:
    mov     #-16,r1
    cmp/ge  r1,r0
    bt      .dp_slcl_lo
    mov     r1,r0
.dp_slcl_lo:
    add     r0,r3                  /* apply slope offset */

    /* Clamp: min $40 */
    mov     #0x40,r0
    cmp/ge  r0,r3
    bt      .dp_dist_min_ok
    mov     r0,r3
.dp_dist_min_ok:
    /* Clamp: max from globals+$30 */
    mov     #0x30,r0
    mov.w   @(r0,r13),r0          /* max_cam_dist */
    cmp/gt  r0,r3
    bf      .dp_dist_max_ok
    mov     r0,r3
.dp_dist_max_ok:

    /* === Drift accumulator decay + smooth cam update === */
    mov.w   @(0xAA,gbr),r0
    cmp/pl  r0
    bf      .dp_check_accum
    add     #-3,r0                 /* 60 FPS: -8÷3 ≈ -3 decay/frame */
    mov.w   r0,@(0xAA,gbr)
.dp_check_accum:
    mov.w   @(0xAA,gbr),r0
    mov     #0x50,r1
    cmp/gt  r1,r0                  /* accum > $50? */
    bt      .dp_set_cam
    /* Ease: if (cur - target) > 4, ease by 4 (60 FPS: 12÷3) */
    mov.w   @(0x76,gbr),r0        /* current cam_dist */
    mov     r0,r1
    sub     r3,r1                  /* R1 = cur - target */
    mov     #4,r2                  /* 60 FPS: 12÷3 = 4 */
    cmp/gt  r2,r1
    bf      .dp_set_cam
    sub     r2,r0                  /* ease by 4 */
    mov.w   r0,@(0x76,gbr)
    bra     .dp_rts
    nop
.dp_set_cam:
    mov     r3,r0
    mov.w   r0,@(0x76,gbr)
.dp_rts:
    lds.l   @r15+,pr
    rts
    nop

.align 2
.dp_c0497:      .short  0x0497
.dp_c8000:      .short  0x8000
.dp_c0100:      .short  0x0100
.dp_c0222:      .short  0x0222
.dp_c0190:      .short  0x0190
.dp_c0188:      .short  0x0188
.align 2
.dp_recip1175:  .long   0x000037C9
.dp_sin_addr:   .long   0x02301EDC /* .pu_sin_lookup (pos_update $301E00 + $7C) */


/* ============================================================================
 * sh2_suspension_damping — Dispatcher + State 0 Damping
 * 68K: $009802-$00987E (124B)
 * Clobbers: R0-R5
 * ============================================================================
 */
.global sh2_suspension_damping
sh2_suspension_damping:
    sts.l   pr,@-r15

    /* Read dispatch index */
    mov     #0x1C,r0
    mov.w   @(r0,r13),r0          /* R0 = race_substate_b */

    tst     r0,r0
    bt      .sd_state0
    mov     #4,r1
    cmp/eq  r1,r0
    bt      .sd_state1
    /* State 2: lateral_drift_A */
    bsr     sh2_lateral_drift_A
    nop
    bra     .sd_rts
    nop
.sd_state1:
    bsr     sh2_lateral_drift_B
    nop
    bra     .sd_rts
    nop

.sd_state0:
    /* Steering damping */
    mov.w   @(0x92,gbr),r0        /* steering indicator */
    mov     r0,r2
    mov.w   @(0x62,gbr),r0        /* collision */
    or      r0,r2
    tst     r2,r2
    bf      .sd_decay

    /* Active damping */
    mov.w   @(0x4C,gbr),r0        /* lateral velocity */
    mov     r0,r1
    cmp/pz  r0
    bt      .sd_abs_ok
    neg     r1,r1
.sd_abs_ok:
    mov     #0x37,r2
    cmp/gt  r2,r1
    bf      .sd_decay

    mov.w   @(0x4C,gbr),r0        /* signed velocity */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>7 */
    mov     r0,r1                  /* R1 = vel/128 */
    shar    r0                     /* R0 = vel/256 */
    add     r1,r0                  /* R0 = vel × 3/256 */
    mov     r0,r2                  /* R2 = damping (save) */
    mov.w   @(0x94,gbr),r0        /* suspension */
    mov     r0,r1
    add     r2,r1                  /* R1 = suspension + damping */
    mov     r1,r0
    mov.w   r0,@(0x94,gbr)
    shar    r0                     /* display = vel/2 */
    mov.w   r0,@(0x96,gbr)
    bra     .sd_rts
    nop

.sd_decay:
    mov.w   @(0x94,gbr),r0
    mov     r0,r1                  /* R1 = original */
    shar    r0
    shar    r0                     /* R0 = vel/4 */
    mov     r0,r2                  /* R2 = decay amount */
    mov.w   @(0x94,gbr),r0
    sub     r2,r0                  /* R0 = vel - vel/4 */
    mov.w   r0,@(0x94,gbr)
    mov.w   r0,@(0x96,gbr)        /* display */

    /* Zero-crossing + settle */
    mov     r1,r3                  /* R3 = original */
    cmp/pz  r3
    bt      .sd_check_pos
    neg     r0,r0
    neg     r3,r3
.sd_check_pos:
    cmp/gt  r0,r3
    bf      .sd_rts
    cmp/pz  r0
    bf      .sd_rts
    mov     #15,r1
    cmp/gt  r1,r0
    bt      .sd_rts
    mov     #0,r0
    mov.w   r0,@(0x94,gbr)

.sd_rts:
    lds.l   @r15+,pr
    rts
    nop


/* ============================================================================
 * sh2_lateral_drift_A — Player Lateral Drift
 * 68K: $00987E-$0099AA (300B)
 *
 * Grip reduction → slip gate → force integration → spin-out → damping
 * Display: velocity >> 1
 * ============================================================================
 */
.global sh2_lateral_drift_A
sh2_lateral_drift_A:
    sts.l   pr,@-r15

    /* === Grip reduction: |steering| × drag >> 8 === */
    mov     #0x14,r0
    mov.w   @(r0,r13),r0          /* globals[+$14] steering */
    cmp/pz  r0
    bt      .la_abs_steer
    neg     r0,r0
.la_abs_steer:
    mov     r0,r2                  /* R2 = |steering| */
    mov.w   @(0x10,gbr),r0        /* entity[+$10] drag */
    muls.w  r2,r0                  /* MACL = |steer| × drag */
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 */
    mov     r0,r2                  /* R2 = grip_loss */
    mov.w   @(0x78,gbr),r0        /* grip */
    mov     r0,r1
    sub     r2,r1                  /* R1 = grip - loss */
    mov     #0x7F,r0
    cmp/ge  r0,r1
    bt      .la_grip_ok
    mov     r0,r1
.la_grip_ok:
    mov     r1,r0
    mov.w   r0,@(0x78,gbr)

    /* Clear slide indicator */
    mov     #0x11,r0
    mov     #0,r1
    mov.b   r1,@(r0,r13)

    /* Check slide/collision */
    mov.w   @(0x92,gbr),r0
    mov     r0,r2
    mov.w   @(0x62,gbr),r0
    add     r0,r2
    tst     r2,r2
    bf      .la_damping

    /* === Slip angle gate (threshold $37 = 55°) === */
    mov.w   @(0x4C,gbr),r0        /* slip angle */
    mov     r0,r3                  /* R3 = slip (preserve signed) */
    mov     r0,r1
    cmp/pz  r1
    bt      .la_abs_slip
    neg     r1,r1
.la_abs_slip:
    mov     #0x37,r2
    cmp/gt  r2,r1
    bf      .la_damping

    /* === Force: slip / divisor × (512 - grip) >> 8 === */
    mov.w   @(0x94,gbr),r0        /* lateral velocity */
    mov     r0,r5                  /* R5 = preserve lateral vel (signed) */
    cmp/pz  r0
    bt      .la_abs_lat
    neg     r0,r0
.la_abs_lat:
    mov     r0,r6                  /* R6 = |lateral vel| */

    /* Division: slip / drift_divisor */
    mov     r3,r0                  /* R0 = slip (signed, from R3) */
    exts.w  r0,r0
    mov     #0x26,r1
    extu.b  r1,r1
    mov     r1,r0                  /* Oops — clobbered slip! */
    /* Fix: need to load divisor without losing slip.
     * Save slip, load offset into R0, load divisor, restore slip. */
    mov     r3,r4                  /* R4 = slip (save) */
    mov     #0x26,r0
    mov.w   @(r0,r13),r1          /* R1 = drift_divisor */
    exts.w  r1,r1
    mov     r4,r0                  /* R0 = slip (restore) */
    exts.w  r0,r0
    mov.l   @(.la_sdiv_addr,pc),r7
    jsr     @r7                    /* sh2_sdiv16: R0/R1 → R0 quotient */
    nop
    /* R0 = slip / divisor */

    /* High velocity check */
    mov     r0,r4                  /* R4 = force (save) */
    mov     #0x24,r0
    mov.w   @(r0,r13),r2          /* R2 = high_vel_threshold */
    cmp/gt  r2,r6                  /* |vel| > threshold? (R6 = |lat vel|) */
    bt      .la_high_vel

    /* Low-velocity: force × (512 - grip) >> 8 */
    mov     r4,r0                  /* R0 = force */
    mov.w   @(.la_c0200,pc),r2
    mov.w   @(0x78,gbr),r0        /* grip → R0 (clobbers force!) */
    /* Fix: save force first */
    mov     r4,r3                  /* R3 = force (resave) */
    mov.w   @(0x78,gbr),r0        /* grip */
    mov     r0,r1
    mov.w   @(.la_c0200,pc),r2
    sub     r1,r2                  /* R2 = 512 - grip */
    mov     r3,r0                  /* R0 = force */
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
    mov     r0,r2                  /* R2 = scaled force */
    mov.w   @(0x94,gbr),r0
    add     r2,r0
    mov.w   r0,@(0x94,gbr)
    shar    r0                     /* display = vel/2 */
    mov.w   r0,@(0x96,gbr)
    bra     .la_done
    nop

.la_high_vel:
    /* Set slide indicator */
    mov     #0x11,r0
    mov     #1,r1
    mov.b   r1,@(r0,r13)

    /* force × 3/8 */
    mov     r4,r0                  /* R0 = force */
    shar    r0
    shar    r0                     /* R0 = force/4 */
    mov     r0,r1
    shar    r1                     /* R1 = force/8 */
    add     r1,r0                  /* R0 = force × 3/8 */
    mov     r0,r2                  /* R2 = scaled force */
    mov.w   @(0x94,gbr),r0
    add     r2,r0
    mov.w   r0,@(0x94,gbr)
    mov.w   r0,@(0x96,gbr)        /* display = full vel */

    /* Heading correction */
    mov.w   @(0x94,gbr),r0
    mov     r0,r2                  /* R2 = lateral vel */
    mov     #0x1E,r0
    mov.w   @(r0,r13),r1          /* heading_corr */
    muls.w  r1,r2
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 */
    mov     r0,r2                  /* R2 = correction */
    mov.w   @(0x3C,gbr),r0
    sub     r2,r0
    mov.w   r0,@(0x3C,gbr)

    /* Spin-out check */
    mov.w   @(0x94,gbr),r0
    mov     r0,r1
    cmp/pz  r1
    bt      .la_abs_spin
    neg     r1,r1
.la_abs_spin:
    mov     r1,r6                  /* R6 = |vel| for spin check */
    mov     #0x22,r0
    mov.w   @(r0,r13),r2          /* spin_threshold */
    cmp/ge  r2,r6
    bf      .la_done

    /* Collision gates */
    mov.w   @(0x6A,gbr),r0
    mov     r0,r2                  /* R2 = lateral collision */
    mov     #0x8C,r0
    extu.b  r0,r0
    mov.w   @(r0,r14),r0          /* entity[+$8C] via R14 */
    add     r2,r0
    tst     r0,r0
    bf      .la_done

    /* Set spin flags + sound */
    mov.w   @(0x94,gbr),r0
    mov.w   @(.la_c2000,pc),r2
    cmp/pz  r0
    bf      .la_spin_set
    mov.w   @(.la_c1000,pc),r2
.la_spin_set:
    mov     #0x2C,r0
    mov     #0xB2,r1
    extu.b  r1,r1
    mov.b   r1,@(r0,r13)          /* sound $B2 */
    mov.w   @(0x02,gbr),r0
    or      r2,r0
    mov.w   r0,@(0x02,gbr)
    /* Clear slide */
    mov     #0x11,r0
    mov     #0,r1
    mov.b   r1,@(r0,r13)
    bra     .la_done
    nop

    /* === Natural damping === */
.la_damping:
    mov.w   @(0x94,gbr),r0
    mov     r0,r1                  /* R1 = original */
    cmp/pz  r0
    bt      .la_dmp_pos
    mov.w   @(.la_cff00,pc),r2
    cmp/ge  r2,r0
    bt      .la_dmp_apply
    mov     r2,r0
    bra     .la_dmp_apply
    nop
.la_dmp_pos:
    mov.w   @(.la_c0100,pc),r2
    cmp/gt  r2,r0
    bt      .la_dmp_apply
    mov     r2,r0
.la_dmp_apply:
    mov     r0,r3                  /* R3 = clamped vel */
    mov     #0x20,r0
    mov.w   @(r0,r13),r2          /* lateral_drag */
    mov     r3,r0
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
    mov     r0,r2                  /* R2 = drag */
    mov.w   @(0x94,gbr),r0
    sub     r2,r0
    mov.w   r0,@(0x94,gbr)

    /* Zero-crossing */
    mov.w   @(0x94,gbr),r0
    mov     r0,r3
    xor     r2,r3
    cmp/pz  r3
    bt      .la_dmp_noflip
    mov     #0,r0
    mov.w   r0,@(0x94,gbr)
.la_dmp_noflip:
    mov.w   @(0x94,gbr),r0
    mov.w   r0,@(0x96,gbr)        /* display = actual */

    /* Settle */
    mov     r1,r3                  /* original */
    mov.w   @(0x94,gbr),r0
    cmp/pz  r3
    bt      .la_dmp_norm
    neg     r0,r0
    neg     r3,r3
.la_dmp_norm:
    cmp/gt  r0,r3
    bf      .la_done
    cmp/pz  r0
    bf      .la_done
    mov     #15,r1
    cmp/gt  r1,r0
    bt      .la_done
    mov     #0,r0
    mov.w   r0,@(0x94,gbr)

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
.la_sdiv_addr:  .long   0x02301700


/* ============================================================================
 * sh2_lateral_drift_B — AI Lateral Drift
 * 68K: $0099AA-$009B12 (360B)
 *
 * Key differences from A: ASR#7 not #8, clamp [$40,$FF], AI boost,
 * MUL-THEN-DIV order, display ×2, damping ±$200, viewport shimmer.
 * ============================================================================
 */
.global sh2_lateral_drift_B
sh2_lateral_drift_B:
    sts.l   pr,@-r15
    mov.l   r8,@-r15               /* save R8 for viewport left */
    mov.l   r9,@-r15               /* save R9 for viewport right */

    /* Init viewport */
    mov     #0xB5,r0
    extu.b  r0,r0
    mov     r0,r8                  /* R8 = left = 181 */
    mov     r0,r9                  /* R9 = right = 181 */

    /* === Grip: |steering| × drag >> 7 + AI boost === */
    mov     #0x14,r0
    mov.w   @(r0,r13),r0          /* steering */
    cmp/pz  r0
    bt      .lb_abs_steer
    neg     r0,r0
.lb_abs_steer:
    mov     r0,r2                  /* R2 = |steering| */
    mov.w   @(0x10,gbr),r0        /* drag */
    muls.w  r2,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>7 */
    mov     r0,r5                  /* R5 = grip_loss (SAVED before AI check) */

    /* AI boost: speed > $C8 AND AI flag bit 4 */
    mov     #0,r1                  /* default boost = 0 */
    mov.w   @(0x04,gbr),r0        /* speed */
    mov     #0xC8,r2
    extu.b  r2,r2
    cmp/gt  r2,r0                  /* speed > 200? */
    bf      .lb_grip_total
    mov     #0x2D,r0
    mov.b   @(r0,r13),r0          /* ai_control_flag */
    tst     #0x10,r0              /* bit 4? (TST #imm requires R0 ✓) */
    bt      .lb_grip_total
    mov     #0xFF,r1
    extu.b  r1,r1                  /* 255 */
    mov.w   @(0x0E,gbr),r0        /* force_param */
    sub     r0,r1                  /* 255 - force */
    shll    r1
    shll    r1
    shll    r1                     /* ×8 */
.lb_grip_total:
    add     r1,r5                  /* R5 = grip_loss + AI boost */

    mov.w   @(0x78,gbr),r0        /* grip */
    mov     r0,r1
    sub     r5,r1                  /* R1 = grip - loss */
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
    mov     r0,r2
    mov.w   @(0x62,gbr),r0
    add     r0,r2
    tst     r2,r2
    bf      .lb_damping

    /* Slip angle gate */
    mov.w   @(0x4C,gbr),r0
    mov     r0,r3                  /* R3 = slip (signed) */
    mov     r0,r1
    cmp/pz  r1
    bt      .lb_abs_slip
    neg     r1,r1
.lb_abs_slip:
    mov     #0x37,r2
    cmp/gt  r2,r1
    bf      .lb_damping

    /* === Force: slip × (512-grip) >> 8 / divisor (MUL-THEN-DIV) === */
    mov.w   @(0x94,gbr),r0
    mov     r0,r5                  /* R5 = lateral vel (signed) */
    cmp/pz  r0
    bt      .lb_abs_lat
    neg     r0,r0
.lb_abs_lat:
    mov     r0,r6                  /* R6 = |lateral vel| */

    /* slip × (512-grip) >> 8 */
    mov.w   @(0x78,gbr),r0
    mov     r0,r1
    mov.w   @(.lb_c0200,pc),r2
    sub     r1,r2                  /* R2 = 512 - grip */
    mov     r3,r0                  /* R0 = slip (from R3) */
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

    /* / drift_divisor */
    mov     r0,r4                  /* R4 = product (save for division) */
    mov     #0x26,r0
    mov.w   @(r0,r13),r1          /* drift_divisor */
    exts.w  r1,r1
    mov     r4,r0                  /* R0 = dividend */
    mov.l   @(.lb_sdiv_addr,pc),r7
    jsr     @r7
    nop
    /* R0 = force */

    /* High velocity: halve force */
    mov     #0x24,r1
    extu.b  r1,r1
    mov     r0,r4                  /* R4 = force (save) */
    mov     r1,r0
    mov.w   @(r0,r13),r2          /* high_vel_threshold */
    cmp/gt  r2,r6                  /* |vel| > threshold? */
    bf      .lb_apply_force
    shar    r4                     /* halve force */
.lb_apply_force:
    mov.w   @(0x94,gbr),r0
    add     r4,r0
    mov.w   r0,@(0x94,gbr)
    /* Display = 2× */
    mov     r0,r2
    add     r2,r2
    mov     r2,r0
    mov.w   r0,@(0x96,gbr)

    /* Viewport shimmer */
    mov.w   @(0x94,gbr),r0
    mov     r0,r1
    cmp/pz  r1
    bt      .lb_abs_vp
    neg     r1,r1
.lb_abs_vp:
    mov.w   @(.lb_c0100,pc),r2
    cmp/ge  r2,r1
    bf      .lb_heading_corr
    mov     #0x7F,r2
    cmp/pz  r0
    bf      .lb_vp_adj
    neg     r2,r2
.lb_vp_adj:
    add     r2,r8                  /* left viewport */
    sub     r2,r9                  /* right viewport */
    mov.w   @(0x80,gbr),r0
    mov     r0,r2
    mov     #11,r3
    cmp/ge  r3,r2
    bt      .lb_heading_corr
    add     #4,r2
    mov     r2,r0
    mov.w   r0,@(0x80,gbr)

.lb_heading_corr:
    mov.w   @(0x94,gbr),r0
    mov     r0,r2                  /* R2 = lateral vel */
    mov     #0x1E,r0
    mov.w   @(r0,r13),r1          /* heading_corr */
    muls.w  r1,r2
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>8 */
    mov     r0,r2
    mov.w   @(0x3C,gbr),r0
    sub     r2,r0
    mov.w   r0,@(0x3C,gbr)

    /* Spin-out (same as A) */
    mov.w   @(0x94,gbr),r0
    mov     r0,r1
    cmp/pz  r1
    bt      .lb_abs_spin
    neg     r1,r1
.lb_abs_spin:
    mov     r1,r6
    mov     #0x22,r0
    mov.w   @(r0,r13),r2
    cmp/ge  r2,r6
    bf      .lb_write_vp
    mov.w   @(0x6A,gbr),r0
    mov     r0,r2
    mov     #0x8C,r0
    extu.b  r0,r0
    mov.w   @(r0,r14),r0
    add     r2,r0
    tst     r0,r0
    bf      .lb_write_vp
    mov.w   @(0x94,gbr),r0
    mov.w   @(.lb_c2000,pc),r2
    cmp/pz  r0
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

    /* === Damping (±$200) === */
.lb_damping:
    mov.w   @(0x94,gbr),r0
    mov     r0,r1                  /* R1 = original */
    cmp/pz  r0
    bt      .lb_dmp_pos
    mov.w   @(.lb_cfe00,pc),r2
    cmp/ge  r2,r0
    bt      .lb_dmp_apply
    mov     r2,r0
    bra     .lb_dmp_apply
    nop
.lb_dmp_pos:
    mov.w   @(.lb_c0200,pc),r2
    cmp/gt  r2,r0
    bt      .lb_dmp_apply
    mov     r2,r0
.lb_dmp_apply:
    mov     r0,r3
    mov     #0x20,r0
    mov.w   @(r0,r13),r2          /* lateral_drag */
    mov     r3,r0
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
    mov     r0,r2                  /* R2 = drag */
    mov.w   @(0x94,gbr),r0
    sub     r2,r0
    mov.w   r0,@(0x94,gbr)
    /* Zero-crossing */
    mov.w   @(0x94,gbr),r0
    mov     r0,r3
    xor     r2,r3
    cmp/pz  r3
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
    /* Settle */
    mov     r1,r3
    mov.w   @(0x94,gbr),r0
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

    /* === Write viewport to entity+$F8/+$FA === */
.lb_write_vp:
    mov     r8,r0
    mov.w   r0,@(0xF8,gbr)
    mov     r9,r0
    mov.w   r0,@(0xFA,gbr)

    mov.l   @r15+,r9
    mov.l   @r15+,r8
    lds.l   @r15+,pr
    rts
    nop

.align 2
.lb_c0200:      .short  0x0200
.lb_c0100:      .short  0x0100
.lb_cfe00:      .short  0xFE00
.lb_c2000:      .short  0x2000
.lb_c1000:      .short  0x1000
.align 2
.lb_sdiv_addr:  .long   0x02301700

.global physics_drift_end
physics_drift_end:
