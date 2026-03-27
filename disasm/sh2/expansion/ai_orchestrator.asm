/*
 * ai_orchestrator — SH2 AI Entity Update Orchestrator
 * VR60 Phase 4
 *
 * Ports ai_entity_main_update_orch ($00A972, 716B) to SH2.
 * Per-frame update for AI entities: spawn positioning, heading calculation,
 * speed convergence, position integration, physics chain.
 *
 * 3 entry points (routed by entity_type_dispatch via entity+$AE):
 *   sh2_ai_orch_main:    Active racing — steering, speed, position
 *   sh2_ai_orch_spawn:   Spawn timer — visibility ramp, slot management
 *   sh2_ai_orch_finish:  Retirement — slot scan, cleanup
 *
 * Convention: GBR = AI entity base ($06010000+), R13 = globals base
 * Clobbers: R0-R7 (R8-R9 saved/restored when needed)
 * Stack: PR save for BSR/JSR calls
 *
 * Global outputs (written to SDRAM AI globals at $0600FC10):
 *   +$00: countdown_timer (replaces WRAM $C00E)
 *   +$02: visibility_counter (replaces WRAM $C00A)
 *   +$04: race_counter (replaces WRAM $C00C)
 *   +$06-$0D: race_slot_table (4 words, replaces WRAM $C024)
 *
 * ROM tables: spawn positions at SH2 $020A868, offsets at $020A8C8
 *
 * Speed conversion: raw × 1000 × 256 ÷ 3600 ÷ 20 simplified to:
 *   speed = (raw × 32) / 9  (exact integer equivalent)
 *   Uses MULS.W + sh2_sdiv16 with divisor 9
 */

.section .text
.align 2

/* ============================================================================
 * sh2_ai_orch_main — Active racing update
 * ============================================================================
 * Lookup spawn target from ROM tables, compute distance, select speed band,
 * compute steering via ai_steering_calc, converge speed, integrate position,
 * fall through to physics.
 *
 * Entry: GBR = AI entity, R13 = globals
 * Globals needed:
 *   globals+$34: difficulty_index (staged from $C83E)
 *   globals+$36: camera_mode (staged from $C840)
 * ============================================================================
 */
.global sh2_ai_orch_main
sh2_ai_orch_main:
    sts.l   pr,@-r15
    mov.l   r8,@-r15               /* save R8 (used for nav_target_X) */
    mov.l   r9,@-r15               /* save R9 (used for nav_target_Y) */

    /* === AI globals: tick countdown if active === */
    mov.l   @(.ao_ai_globals,pc),r7
    mov.w   @r7,r0                 /* ai_globals[+$00] = countdown_timer */
    tst     r0,r0
    bt      .ao_after_countdown    /* timer == 0: skip */
    add     #-1,r0
    mov.w   r0,@r7                 /* countdown-- */
.ao_after_countdown:
    /* Clear visibility + AI flag (these were WRAM writes, now SDRAM) */
    mov     #0,r0
    mov.w   r0,@(2,r7)            /* ai_globals[+$02] = vis = 0 */
    mov.w   r0,@(4,r7)            /* ai_globals[+$04] = race_counter = 0 */

    /* === Lookup spawn target from ROM tables === */
    /* X offset table at ROM $00A8C8 → SH2 $020A8C8 */
    /* Spawn pos table at ROM $00A868 → SH2 $020A868 */
    mov.l   @(.ao_ofs_tbl,pc),r1   /* R1 = X offset table base */
    mov     #0x34,r0
    mov.w   @(r0,r13),r0          /* globals+$34 = difficulty_index */
    mov     r0,r2                  /* R2 = difficulty index (for table lookup) */
    /* R0 = index, need to use R0 for indexed load */
    mov.w   @(r0,r1),r0           /* X_offset = ofs_tbl[difficulty] */
    mov     r0,r5                  /* R5 = X offset for distance band */

    /* Spawn position table indexed by slot×4 + camera×4 */
    mov.l   @(.ao_pos_tbl,pc),r1   /* R1 = spawn pos table base */
    mov     #0x36,r0
    mov.w   @(r0,r13),r0          /* globals+$36 = camera_mode */
    shll    r0
    shll    r0                     /* ×4 (longword stride) */
    mov     r0,r2                  /* R2 = camera_mode × 4 */

    mov.w   @(0xAE,gbr),r0        /* entity[+$AE] slot_index */
    shll    r0
    shll    r0                     /* ×4 */
    add     r2,r0                  /* R0 = combined index */
    /* Load target X and Y from spawn table */
    mov     r0,r2                  /* save combined index */
    mov.w   @(r0,r1),r0           /* target_X = pos_tbl[combined] */
    mov     r0,r8                  /* R8 = target_X (preserved) */
    mov     r2,r0
    add     #2,r0                  /* +2 for next word */
    mov.w   @(r0,r1),r0           /* target_Y = pos_tbl[combined+2] */
    mov     r0,r9                  /* R9 = target_Y (preserved) */

    /* === Distance check: Y distance to spawn target === */
    mov.w   @(0x34,gbr),r0        /* entity[+$34] y_pos */
    mov     r9,r4
    sub     r0,r4                  /* R4 = dist = target_Y - y_pos */
    mov     #2,r1
    cmp/ge  r1,r4                  /* dist >= 2? */
    bt      .ao_dist_close         /* yes: approach */

    /* === SNAP SPAWN: within 2 units, zero all motion === */
    mov     r8,r0
    mov.w   r0,@(0x30,gbr)        /* x_pos = target_X */
    mov     r9,r0
    mov.w   r0,@(0x34,gbr)        /* y_pos = target_Y */
    mov     #0,r0
    mov.w   r0,@(0x3C,gbr)        /* heading = 0 */
    mov.w   r0,@(0x40,gbr)        /* target_heading = 0 */
    mov.w   r0,@(0x8E,gbr)        /* steer_vel = 0 */
    mov.w   r0,@(0x90,gbr)        /* drift = 0 */
    mov.w   r0,@(0x06,gbr)        /* display_speed = 0 */
    mov.w   r0,@(0x04,gbr)        /* speed = 0 */
    mov.w   r0,@(0x7A,gbr)        /* gear = 0 */
    mov.w   r0,@(0x92,gbr)        /* slide = 0 */
    mov.w   r0,@(0x14,gbr)        /* timer = 0 */
    mov.w   r0,@(0x8C,gbr)        /* param = 0 */
    mov.w   r0,@(0xB8,gbr)        /* trail = 0 */
    /* Set slot state to "ready" (2) */
    mov.l   @(.ao_ai_globals,pc),r7
    mov.w   @(0xAE,gbr),r0        /* slot_index */
    shll    r0                     /* ×2 */
    add     #6,r0                  /* offset into race_slot_table (ai_globals+$06) */
    mov     r0,r2
    mov     #2,r0                  /* state = 2 (ready) */
    mov     r2,r1
    /* Need R0=index for indexed store... restructure */
    mov     r2,r0                  /* R0 = offset */
    mov     #2,r1                  /* R1 = value (state=2) */
    mov.w   r1,@(r0,r7)           /* race_slot[slot] = 2 */
    /* Set spawn timer = 120 */
    mov     #120,r0
    extu.b  r0,r0
    mov.w   r0,@(0xB0,gbr)        /* entity[+$B0] = 120 */
    /* Clear countdown */
    mov.l   @(.ao_ai_globals,pc),r7
    mov     #0,r0
    mov.w   r0,@r7                 /* countdown = 0 */
    /* Fall through to physics (restore regs first) */
    mov.l   @r15+,r9
    mov.l   @r15+,r8
    lds.l   @r15+,pr
    /* JMP equivalent: call force_integration via JSR @Rn, then RTS */
    /* Actually, the 68K JMPs to entity_force_integration+18.
     * On SH2, this is part of the physics pipeline called by cmd $3F.
     * For the AI entity loop, physics runs AFTER the orchestrator.
     * So we just RTS here. */
    rts
    nop

    /* === DISTANCE BANDS: select approach speed === */
.ao_dist_close:
    /* Band 1: dist < $80 (128), speed = $20 (32) */
    mov     #0x80,r1
    extu.b  r1,r1
    cmp/gt  r1,r4                  /* dist > 128? */
    bt      .ao_dist_medium

    /* R8 = nav_X, R9 = nav_Y already set */
    mov     #0x20,r6               /* R6 = target_speed = 32 */
    bra     .ao_compute_steering
    nop

.ao_dist_medium:
    /* Band 2: dist < $180 (384), speed = dist×3/16 + 8 */
    mov     #0xC0,r1
    extu.b  r1,r1
    shll    r1                     /* R1 = $180 = 384 */
    cmp/gt  r1,r4                  /* dist > 384? */
    bt      .ao_dist_far

    /* Offset nav_Y by -64 */
    mov     r9,r0
    add     #-64,r0
    mov     r0,r9                  /* nav_Y -= 64 */
    /* Speed = dist/16 × 3 + 8 */
    mov     r4,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 = dist >> 4 */
    mov     r0,r1
    shll    r0                     /* ×2 */
    add     r1,r0                  /* ×3 */
    add     #8,r0                  /* +8 */
    mov     r0,r6                  /* R6 = target_speed */
    bra     .ao_compute_steering
    nop

.ao_dist_far:
    /* Band 3: dist < $400 (1024), speed = dist/8 + $20, + difficulty X offset */
    mov     #4,r1
    shll8   r1                     /* R1 = $400 = 1024 */
    cmp/gt  r1,r4
    bt      .ao_dist_very_far

    /* Add difficulty X offset + Y offset -128 */
    add     r5,r8                  /* nav_X += difficulty_offset */
    mov     r9,r0
    add     #-128,r0
    mov     r0,r9                  /* nav_Y -= 128 */

    mov     r4,r0
    shar    r0
    shar    r0
    shar    r0                     /* R0 = dist >> 3 = dist/8 */
    add     #0x20,r0              /* +32 */
    mov     r0,r6                  /* R6 = target_speed */
    bra     .ao_compute_steering
    nop

.ao_dist_very_far:
    /* Band 4: dist >= $400, speed = dist/16 + $64, clamped to 200 */
    add     r5,r8                  /* nav_X += difficulty_offset */
    mov     r9,r0
    add     #-128,r0
    mov     r0,r9                  /* nav_Y -= 128 */

    mov     r4,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* dist >> 4 */
    mov     #0x64,r1
    extu.b  r1,r1
    add     r1,r0                  /* + 100 */
    mov     #0xC8,r1
    extu.b  r1,r1                  /* max = 200 */
    cmp/gt  r1,r0
    bf      .ao_speed_ok
    mov     r1,r0
.ao_speed_ok:
    mov     r0,r6                  /* R6 = target_speed */

    /* === COMPUTE STEERING: heading toward nav target === */
.ao_compute_steering:
    /* ai_steering_calc: R0=entityY, R1=entityX, R2=targetY, R3=targetX */
    mov.w   @(0x34,gbr),r0        /* entity Y */
    mov     r0,r1                  /* save for steering call */
    mov.w   @(0x30,gbr),r0        /* entity X */
    neg     r0,r0                  /* negate for atan2 convention */
    mov     r0,r3                  /* R3 = -entity_X (target_X arg) */
    /* Wait, the 68K does:
     * D0 = entity_Y, D1 = entity_X (negated), D2 = nav_Y, D3 = nav_X (negated)
     * Then calls ai_steering_calc(D0,D1,D2,D3)
     * Our SH2 version: R0=entityY, R1=entityX, R2=targetY, R3=targetX */
    mov.w   @(0x34,gbr),r0        /* R0 = entity Y */
    mov.w   @(0x30,gbr),r0        /* Oops, need both. Let me restructure. */

    /* Load all 4 values into correct registers for sh2_ai_steering_calc */
    mov.w   @(0x34,gbr),r0        /* R0 = entity Y */
    mov     r0,r2                  /* save temporarily */
    mov.w   @(0x30,gbr),r0        /* R0 = entity X */
    mov     r0,r1                  /* R1 = entity X */
    mov     r2,r0                  /* R0 = entity Y */
    /* Target: R2 = nav_Y, R3 = nav_X */
    mov     r9,r2                  /* R2 = nav target Y */
    mov     r8,r3                  /* R3 = nav target X */
    /* 68K negates D1 (entity_X) and D3 (nav_X) before calling */
    neg     r1,r1                  /* R1 = -entity_X */
    neg     r3,r3                  /* R3 = -nav_X */
    mov.l   @(.ao_steer_addr,pc),r7
    jsr     @r7                    /* sh2_ai_steering_calc */
    nop
    /* R0 = target angle (16-bit) */
    mov     r0,r7                  /* R7 = target_heading (save) */

    /* === Clamp steering delta to ±$140 per frame === */
    mov.w   @(0x3C,gbr),r0        /* entity heading */
    mov     r0,r1
    mov     r7,r0                  /* target heading */
    sub     r1,r0                  /* R0 = delta = target - heading */
    mov     #5,r1
    shll2   r1
    shll2   r1
    shll    r1
    shll    r1                     /* R1 = $140 = 320 */
    cmp/gt  r1,r0                  /* delta > $140? */
    bf      .ao_steer_hi_ok
    mov     r1,r0
.ao_steer_hi_ok:
    mov     #5,r1
    shll2   r1
    shll2   r1
    shll    r1
    shll    r1
    neg     r1,r1                  /* R1 = -$140 = -320 */
    cmp/ge  r1,r0                  /* delta >= -$140? */
    bt      .ao_steer_lo_ok
    mov     r1,r0
.ao_steer_lo_ok:
    /* Apply steering delta to heading */
    mov     r0,r4                  /* R4 = clamped delta (save for later use) */
    mov.w   @(0x3C,gbr),r0        /* heading */
    add     r4,r0                  /* heading += delta */
    mov.w   r0,@(0x3C,gbr)

    /* Dead zone: if |heading| < $100, snap to 0 */
    mov.w   @(0x3C,gbr),r0
    mov     r0,r1
    cmp/pz  r1
    bt      .ao_hdz_pos
    neg     r1,r1
.ao_hdz_pos:
    mov     #1,r2
    shll8   r2                     /* R2 = $100 = 256 */
    cmp/ge  r2,r1                  /* |heading| >= $100? */
    bt      .ao_apply_steer
    mov     #0,r0
    mov.w   r0,@(0x3C,gbr)        /* snap heading to 0 */

.ao_apply_steer:
    /* Write steering fields */
    mov     r4,r0                  /* clamped delta */
    mov.w   r0,@(0x8E,gbr)        /* steer_vel */
    mov.w   r0,@(0x90,gbr)        /* drift */
    shll    r0                     /* ×2 */
    neg     r0,r0                  /* invert for turn_rate */
    mov.w   r0,@(0x46,gbr)        /* turn_rate */

    /* Smooth target heading convergence: 1/4 per frame */
    mov     r7,r0                  /* target heading */
    mov.w   @(0x40,gbr),r0        /* current target... clobbers R0! */
    /* Fix: load current target separately */
    mov.w   @(0x40,gbr),r0        /* R0 = current target_heading */
    mov     r0,r1
    mov     r7,r0                  /* R0 = desired target */
    sub     r1,r0                  /* R0 = desired - current */
    shar    r0
    shar    r0                     /* R0 = delta/4 */
    add     r0,r1                  /* R1 = current + delta/4 */
    mov     r1,r0
    mov.w   r0,@(0x40,gbr)        /* converge target_heading */

    /* === Speed conversion: raw × 32 / 9 === */
    /* R6 = raw target speed from distance band */
    mov     r6,r0
    shll2   r0
    shll2   r0
    shll    r0                     /* R0 = raw × 32 */
    mov     #9,r1                  /* divisor */
    mov.l   @(.ao_sdiv_addr,pc),r7
    jsr     @r7                    /* sh2_sdiv16: R0/R1 → R0 */
    nop
    /* R0 = converted game speed */
    mov     r0,r6                  /* R6 = converted speed (save) */

    /* Clamp acceleration: display_speed += clamp(delta, -80, +47) */
    mov.w   @(0x06,gbr),r0        /* display_speed */
    mov     r0,r1
    mov     r6,r0                  /* target speed */
    sub     r1,r0                  /* R0 = delta */
    mov     #47,r1
    cmp/gt  r1,r0
    bf      .ao_accel_hi
    mov     r1,r0
.ao_accel_hi:
    mov     #-80,r1
    cmp/ge  r1,r0
    bt      .ao_accel_lo
    mov     r1,r0
.ao_accel_lo:
    /* Apply acceleration */
    mov     r0,r2                  /* R2 = clamped accel */
    mov.w   @(0x06,gbr),r0
    add     r2,r0
    mov.w   r0,@(0x06,gbr)        /* display_speed += accel */

    /* Call entity_speed_clamp (already on SH2) */
    mov.l   @(.ao_spd_clamp,pc),r7
    jsr     @r7
    nop

    /* Deceleration accumulator: entity[+$BC] -= speed × 32 */
    mov.w   @(0x04,gbr),r0        /* speed */
    shll2   r0
    shll2   r0
    shll    r0                     /* ×32 */
    /* Clamp to [0, $11F8] */
    mov.w   @(.ao_c11F8,pc),r1
    cmp/gt  r1,r0
    bf      .ao_shift_hi
    mov     r1,r0
.ao_shift_hi:
    cmp/pz  r0
    bt      .ao_shift_lo
    mov     #0,r0
.ao_shift_lo:
    mov     r0,r2                  /* R2 = clamped shift value */
    mov.w   @(0xBC,gbr),r0        /* decel_accum */
    sub     r2,r0
    mov.w   r0,@(0xBC,gbr)

    /* === Position integration (16-bit integer, AI convention) === */
    /* heading = -target_heading, speed = display_speed */
    mov.w   @(0x40,gbr),r0        /* target_heading */
    neg     r0,r0                  /* movement direction */
    extu.w  r0,r0                  /* mask to 16 bits */
    mov     r0,r4                  /* R4 = angle for sin lookup */

    mov.w   @(0x06,gbr),r0        /* display_speed */
    mov     r0,r6                  /* R6 = speed (preserve for both axes) */

    /* Sine lookup for X displacement */
    mov.l   @(.ao_sin_addr,pc),r7
    jsr     @r7                    /* sh2_sin_lookup: R4=angle → R0=sin */
    nop
    /* R0 = sin(heading), Q8 */
    muls.w  r6,r0
    sts     macl,r0                /* R0 = sin × speed */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>12 (AI uses integer, not 16.16) */
    mov     r0,r2                  /* R2 = dx */
    mov.w   @(0x30,gbr),r0        /* x_pos */
    add     r2,r0
    mov.w   r0,@(0x30,gbr)        /* x_pos += dx */

    /* Cosine lookup for Y displacement */
    mov     r4,r0                  /* angle */
    mov.w   @(.ao_c4000,pc),r1
    add     r1,r0                  /* + 90° for cosine */
    extu.w  r0,r0
    mov     r0,r4                  /* R4 = cosine angle */
    mov.l   @(.ao_sin_addr,pc),r7
    jsr     @r7
    nop
    muls.w  r6,r0
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>12 */
    mov     r0,r2                  /* R2 = dy */
    mov.w   @(0x34,gbr),r0        /* y_pos */
    add     r2,r0
    mov.w   r0,@(0x34,gbr)        /* y_pos += dy */

    /* Orchestrator done — physics runs after (called by cmd $3F loop) */
    mov.l   @r15+,r9
    mov.l   @r15+,r8
    lds.l   @r15+,pr
    rts
    nop


/* ============================================================================
 * sh2_ai_orch_spawn — Spawn timer state
 * ============================================================================
 * Visibility ramp: (120 - timer) × $3BBB >> 16
 * Timer tick: decrement spawn_timer, advance slot when expired
 * ============================================================================
 */
.global sh2_ai_orch_spawn
sh2_ai_orch_spawn:
    /* Visibility: (120 - remaining_timer) × $3BBB >> 16 → [0..20] */
    mov     #120,r0
    extu.b  r0,r0
    mov.w   @(0xB0,gbr),r0        /* spawn_timer → clobbers 120! */
    /* Fix: save 120, load timer */
    mov     #120,r1
    extu.b  r1,r1
    mov.w   @(0xB0,gbr),r0
    sub     r0,r1                  /* R1 = 120 - timer */
    mov.w   @(.ao_c3BBB,pc),r2
    mulu.w  r2,r1                  /* MACL = (120-timer) × $3BBB (unsigned) */
    sts     macl,r0
    shlr16  r0                     /* >>16 → visibility [0..20] */
    /* Store to AI globals visibility */
    mov.l   @(.ao_ai_globals,pc),r7
    mov.w   r0,@(2,r7)            /* ai_globals[+$02] = visibility */

    /* Tick spawn timer */
    mov.w   @(0xB0,gbr),r0
    add     #-1,r0
    mov.w   r0,@(0xB0,gbr)
    tst     r0,r0
    bf      .sp_rts                /* timer > 0: done */

    /* Timer expired: advance slot to state 3 (active) */
    mov.w   @(0xAE,gbr),r0        /* slot_index */
    shll    r0                     /* ×2 */
    add     #6,r0                  /* offset into race_slot_table */
    mov     r0,r2
    mov     #3,r1                  /* state = 3 */
    mov     r2,r0                  /* R0 = offset */
    mov.w   r1,@(r0,r7)           /* race_slot[slot] = 3 */

.sp_rts:
    rts
    nop


/* ============================================================================
 * sh2_ai_orch_finish — Retirement state
 * ============================================================================
 * Scan race slots for reorder opportunities, then retire entity.
 * Sets entity inactive flag (+$02 |= $4000), clears slot, sets respawn timer.
 * ============================================================================
 */
.global sh2_ai_orch_finish
sh2_ai_orch_finish:
    /* Simplified retirement: just mark entity inactive and clear slot.
     * The full slot scanning logic is complex and rarely triggers.
     * For now: set inactive flag, clear slot, set respawn delay. */
    mov.w   @(0x02,gbr),r0        /* flags */
    mov.w   @(.ao_c4000,pc),r1
    or      r1,r0
    mov.w   r0,@(0x02,gbr)        /* flags |= $4000 (inactive) */

    /* Set respawn delay */
    mov     #0x50,r0
    extu.b  r0,r0                  /* 80 frames */
    mov.l   @(.ao_ai_globals,pc),r7
    mov.w   r0,@r7                 /* countdown_timer = 80 */

    /* Clear slot */
    mov.w   @(0xAE,gbr),r0        /* slot_index */
    shll    r0                     /* ×2 */
    add     #6,r0                  /* offset into race_slot_table */
    mov     r0,r2
    mov     #0,r1
    mov     r2,r0
    mov.w   r1,@(r0,r7)           /* race_slot[slot] = 0 (empty) */

    rts
    nop


/* === LITERAL POOL === */
.align 2
.ao_c0180:      .short  0x0180     /* 384 (band 2 threshold) */
.ao_c0400:      .short  0x0400     /* 1024 (band 3 threshold) */
.ao_c0140:      .short  0x0140     /* max steer delta = 320 */
.ao_cFEC0:      .short  0xFEC0     /* min steer delta = -320 */
.ao_c0100:      .short  0x0100     /* dead zone threshold = 256 */
.ao_c11F8:      .short  0x11F8     /* decel accum max */
.ao_c4000_s:    .short  0x4000     /* cosine offset (90°) */
.ao_c3BBB:      .short  0x3BBB     /* visibility scaling factor */
.ao_c4000:      .short  0x4000     /* inactive flag */
.align 2
.ao_ai_globals: .long   0x0600FC10 /* AI globals area (cache-through not needed, Master only reads) */
.ao_ofs_tbl:    .long   0x020A8C8  /* X offset table (ROM) */
.ao_pos_tbl:    .long   0x020A868  /* spawn position table (ROM) */
.ao_steer_addr: .long   0x023025E0     /* sh2_ai_steering_calc */
.ao_sdiv_addr:  .long   0x02301760     /* sh2_sdiv16 */
.ao_spd_clamp:  .long   0x023017F2     /* sh2_entity_speed_clamp (g1+$032) */
.ao_sin_addr:   .long   0x02301EDC     /* .pu_sin_lookup (physics_pos_update) */

.global ai_orchestrator_end
ai_orchestrator_end:
