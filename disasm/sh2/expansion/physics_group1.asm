/*
 * physics_group1 — VR60 Phase 3B: SH2 Physics Functions 1, 5
 * Expansion ROM Address: $301680+
 *
 * Contains SH2 translations of the simplest physics functions:
 *   1. sh2_speed_degrade_calc      (68K: 42B)
 *   5. sh2_entity_speed_clamp      (68K: 32B)
 *
 * Functions 2-4 will be added incrementally after these assemble and verify.
 *
 * === REGISTER CONVENTION ===
 *
 * GBR = entity base pointer ($0600F20C)
 *   - Set once by caller via LDC Rn,GBR
 *   - MOV.W @(disp,GBR),R0: dest MUST be R0, address = GBR + disp×2
 *   - MOV.W R0,@(disp,GBR): source MUST be R0
 *   - All entity word fields at offset 0-510 reachable (256B entity fits)
 *   - Loads auto sign-extend (word → 32-bit signed)
 *
 * R13 = globals base pointer ($0600F30C)
 *   - Access via MOV.x @(R0,R13) with R0 = byte offset
 *
 * R8  = COMM base ($20004020, preserved from dispatch loop)
 * R0  = scratch (special: required by GBR addressing, TST #imm, indexed)
 * R1-R7, R9-R12 = scratch
 *
 * === SH2 ADDRESSING QUICK REFERENCE ===
 *
 * Entity field access (GBR-relative, 1 cycle each):
 *   Load:  mov.w @(byte_offset,gbr),r0  → R0 = entity[byte_offset], sign-extended
 *   Store: mov.w r0,@(byte_offset,gbr)  → entity[byte_offset] = R0 (low 16 bits)
 *   byte_offset must be even (word-aligned), range 0-510.
 *   Gas assembler takes the BYTE OFFSET directly (divides by 2 internally).
 *   Examples: +$04 → @(4,gbr), +$74 → @(116,gbr), +$BC → @(188,gbr)
 *
 * Entity field access for offsets > 510 or non-R0 targets:
 *   mov     #offset,r0             → R0 = offset (sign-extended if >$7F!)
 *   extu.b  r0,r0                  → R0 = offset (zero-extended for $80-$FF)
 *   mov.w   @(r0,r14),rN           → rN = entity[offset] (any dest register)
 *
 * Globals access (R13-based, R0 = byte offset):
 *   mov     #offset,r0
 *   mov.w   @(r0,r13),r0           → R0 = globals[offset]
 *   mov.b   @(r0,r13),r0           → R0 = globals[offset] (byte, sign-extended)
 *
 * === SH2 SHIFT REFERENCE (no SHAD/SHLD on SH-2) ===
 *
 * Left:  SHLL(1), SHLL2(2), SHLL8(8), SHLL16(16) — all 1 cycle, logical
 * Right: SHLR(1), SHLR2(2), SHLR8(8), SHLR16(16) — logical (zero-fill)
 *        SHAR(1) — arithmetic (sign-extend), 1 cycle
 * For ASR by N: N× SHAR (N cycles). No shortcut.
 * For LSR by N: combine SHLR2/SHLR8/SHLR16 where possible.
 */

.section .text
.align 2

/* =========================================================================
 * FUNCTION 1: sh2_speed_degrade_calc
 * =========================================================================
 * 68K: speed_degrade_calc ($00859A, 42B)
 *
 * Logic:
 *   val = sign_extend(entity.speed[+$04]) << 6
 *   if val < 0: val = 0
 *   if val >= $1900: val <<= 2
 *     if val >= $7000: val = $7080
 *   entity.drag_output[+$BC] -= val
 *
 * Entry: GBR = entity base
 * Clobbers: R0, R1, R2
 */
.global sh2_speed_degrade_calc
sh2_speed_degrade_calc:
    /* Load entity.speed (+$04) — GBR auto sign-extends word to 32-bit */
    /* Replaces 68K: MOVE.W $0004(A0),D0 + EXT.L D0 (2 instr → 1) */
    mov.w   @(4,gbr),r0            /* R0 = (s32)entity[+$04] */

    /* R0 <<= 6: three SHLL2 (3 cycles vs 68K's LSL.L D1,D0 = 6+2 cycles) */
    shll2   r0
    shll2   r0
    shll2   r0

    /* Clamp negative to 0 */
    cmp/pz  r0                      /* T = (R0 >= 0) */
    bt      .sd_nonneg
    mov     #0,r0

.sd_nonneg:
    /* if R0 >= $1900: build constant inline (no literal pool needed) */
    mov     #0x19,r1                /* R1 = $19 */
    shll8   r1                      /* R1 = $1900 */
    cmp/hs  r1,r0                   /* T = (R0 >=u R1) unsigned */
    bf      .sd_apply               /* R0 < $1900: use as-is */

    /* Steeper slope: R0 <<= 2 */
    shll2   r0

    /* if R0 >= $7000 */
    mov     #0x70,r1                /* R1 = $70 */
    shll8   r1                      /* R1 = $7000 */
    cmp/hs  r1,r0                   /* T = (R0 >=u R1) */
    bf      .sd_apply               /* R0 < $7000: use shifted value */

    /* Cap at $7080: reuse R1=$7000, build $80 unsigned */
    mov     #0x80,r0                /* R0 = $FFFFFF80 (sign-extended!) */
    extu.b  r0,r0                   /* R0 = $00000080 */
    or      r1,r0                   /* R0 = $7080 */

.sd_apply:
    /* entity.drag_output[+$BC] -= R0 (word subtract) */
    /* +$BC = 188 bytes. GBR disp = 188/2 = 94. Valid (0-255 range). */
    /* But GBR load target must be R0, and R0 has the value to subtract. */
    /* Solution: save value, load via GBR, subtract, store. */
    mov     r0,r1                   /* R1 = degrade value (preserve) */
    mov.w   @(188,gbr),r0          /* R0 = entity[+$BC] (sign-extended) */
    sub     r1,r0                   /* R0 -= degrade (32-bit sub, low 16 used) */
    mov.w   r0,@(188,gbr)         /* entity[+$BC] = R0 */
    rts
    nop                             /* delay slot */
/* Size: 50 bytes, 0 pool. 68K: 42 bytes. */


/* =========================================================================
 * FUNCTION 5: sh2_entity_speed_clamp
 * =========================================================================
 * 68K: entity_speed_clamp ($009B12, 32B)
 *
 * Logic:
 *   speed = entity.display_speed[+$06]
 *   if speed_state[+$A8] == 0 AND speed > max_speed[+$0A]:
 *     speed = max_speed
 *   entity.output_speed[+$04] = (speed × 72) >> 8
 *
 * Entry: GBR = entity base
 * Clobbers: R0, R1, R2
 */
.global sh2_entity_speed_clamp
sh2_entity_speed_clamp:
    /* Load display_speed (+$06) — auto sign-extended */
    mov.w   @(6,gbr),r0            /* R0 = entity[+$06] */
    mov     r0,r2                   /* R2 = speed (preserve across GBR loads) */

    /* Test speed_state (+$A8) — if nonzero, skip clamping */
    mov.w   @(168,gbr),r0          /* R0 = entity[+$A8] */
    tst     r0,r0                   /* T = (speed_state == 0) */
    bf      .sc_multiply            /* != 0: skip clamp */

    /* Compare speed with max_speed (+$0A) */
    mov.w   @(10,gbr),r0           /* R0 = entity[+$0A] */
    cmp/gt  r0,r2                   /* T = (speed > max) signed */
    bf      .sc_multiply            /* speed <= max: no clamp */
    mov     r0,r2                   /* R2 = max_speed (clamp) */

.sc_multiply:
    /* R2 = (R2 × 72) >> 8 */
    /* 72 = $48, fits in MOV #imm (signed 8-bit: 72 < 128) */
    mov     #72,r1                  /* R1 = 72 */
    muls.w  r1,r2                   /* MACL = speed × 72 (16×16→32 signed) */
    sts     macl,r0                 /* R0 = product */
    /* ASR 8: 8× SHAR */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0

    /* Store to entity.output_speed (+$04) */
    mov.w   r0,@(4,gbr)            /* entity[+$04] = R0 */
    rts
    nop                             /* delay slot */
/* Size: ~40 bytes, 0 pool. 68K: 32 bytes. */


/* =========================================================================
 * FUNCTION 2: sh2_steering_input
 * =========================================================================
 * 68K: steering_input_processing_and_velocity_update ($0094FA, 298B)
 * SH2 version implements Phase B only: integration, damping, deadzone.
 *
 * Phase A (raw input → velocity) stays on 68K. The 68K writes the
 * processed steering_velocity to $FFC000 which is staged to globals +$14.
 *
 * 68K Phase A outputs consumed by SH2:
 *   globals[+$14] = steering_velocity (word, clamped [-127, +127])
 *   entity[+$8E]  = may be set directly by 68K on direction change
 *   entity[+$94]  = drift_rate (read for countersteer decay)
 *
 * SH2 Phase B:
 *   1. Read velocity from globals
 *   2. Clamp to [-$7F, +$7F]
 *   3. Deadzone: |vel| < 24 → zero
 *   4. Integrate: new = (vel×256 + old_steer) / 2
 *   5. Drift accumulator: |delta| >> 8 → accum, clamp [0, 200]
 *   6. Final deadzone on integrated value
 *   7. Store to entity[+$8E]
 *
 * Entry: GBR = entity base, R13 = globals base
 * Clobbers: R0, R1, R2, R3
 */
.global sh2_steering_input
sh2_steering_input:
    /* Load processed steering velocity from globals +$14 */
    mov     #0x14,r0
    mov.w   @(r0,r13),r0           /* R0 = steering_velocity */
    mov     r0,r2                   /* R2 = velocity (working register) */

    /* === Clamp to [-$7F, +$7F] === */
    mov     #0x7F,r1                /* R1 = +127 */
    cmp/gt  r1,r2                   /* T = (vel > 127) signed */
    bf      .si_check_lower
    mov     r1,r2                   /* clamp to +127 */
.si_check_lower:
    mov     #-127,r1                /* R1 = -127 (sign-extended by MOV #imm) */
    cmp/ge  r1,r2                   /* T = (vel >= -127) signed */
    bt      .si_deadzone
    mov     r1,r2                   /* clamp to -127 */

    /* === Deadzone: |vel| < 24 → zero velocity === */
.si_deadzone:
    mov     r2,r0                   /* R0 = vel (for abs) */
    cmp/pz  r0
    bt      .si_dz_check
    neg     r0,r0                   /* R0 = |vel| */
.si_dz_check:
    mov     #24,r1
    cmp/hs  r1,r0                   /* T = (|vel| >= 24) unsigned */
    bt      .si_integrate           /* above deadzone: proceed */
    mov     #0,r2                   /* below: zero velocity */

    /* === Integrate: new_steer = (vel×256 + old_steer) / 2 === */
.si_integrate:
    exts.w  r2,r2                   /* sign-extend velocity to 32-bit */
    shll8   r2                      /* R2 = vel × 256 (8.8 fixed-point) */
    mov.w   @(142,gbr),r0          /* R0 = entity[+$8E] old steering */
    exts.w  r0,r1                   /* R1 = sign-extended old steering */
    add     r1,r2                   /* R2 = vel×256 + old_steer */
    shar    r2                      /* R2 = average (IIR smoothing) */

    /* === Drift accumulator: track steering change magnitude === */
    mov     r2,r3                   /* R3 = new steering */
    sub     r1,r3                   /* R3 = delta (new - old) */
    cmp/pz  r3
    bt      .si_abs_done
    neg     r3,r3                   /* R3 = |delta| */
.si_abs_done:
    /* ASR.W #8: normalize from 8.8 — signed, use 8× SHAR */
    shar    r3
    shar    r3
    shar    r3
    shar    r3
    shar    r3
    shar    r3
    shar    r3
    shar    r3                      /* R3 = |delta| >> 8 */

    /* Add to drift accumulator entity[+$AA] */
    mov.w   @(170,gbr),r0          /* R0 = entity[+$AA] drift_accum */
    add     r0,r3                   /* R3 += accum */

    /* Clamp drift to [0, 200] */
    cmp/pz  r3
    bt      .si_drift_upper
    mov     #0,r3                   /* floor at 0 */
.si_drift_upper:
    mov.w   @(.si_c200,pc),r1      /* R1 = 200 ($C8) — too large for MOV #imm */
    cmp/gt  r1,r3                   /* T = (drift > 200) */
    bf      .si_store_drift
    mov     r1,r3                   /* cap at 200 */
.si_store_drift:
    mov     r3,r0                   /* GBR store requires R0 */
    mov.w   r0,@(170,gbr)          /* entity[+$AA] = drift_accum */

    /* === Final deadzone on integrated steering === */
    mov     r2,r1                   /* R1 = integrated steering */
    cmp/pz  r1
    bt      .si_final_dz
    neg     r1,r1                   /* R1 = |steering| */
.si_final_dz:
    mov     #24,r0                  /* deadzone threshold */
    cmp/hs  r0,r1                   /* T = (|steer| >= 24) unsigned */
    bt      .si_store
    mov     #0,r2                   /* below deadzone: zero steering */

.si_store:
    mov     r2,r0                   /* GBR store requires R0 */
    mov.w   r0,@(142,gbr)          /* entity[+$8E] = steering */
    rts
    nop                             /* delay slot */

.align 1
.si_c200:   .short  200             /* drift accumulator cap */
/* Function 2 total: ~110 bytes code + 2 bytes pool = ~112 bytes */
/* 68K original: 298B total, but Phase B only = ~130B. SH2 is slightly smaller. */


/* =========================================================================
 * FUNCTION 3: sh2_force_integration
 * =========================================================================
 * 68K: entity_force_integration_and_speed_calc ($009312, 344B)
 *    + speed_calc_multiplier_chain ($009458, 156B) — INLINED
 *    + speed_modifier ($009B32, 34B) — INLINED
 *
 * Entry: GBR = entity base, R13 = globals base
 * Clobbers: R0-R7, R9-R12
 */
.global sh2_force_integration
sh2_force_integration:
    sts.l   pr,@-r15                /* save PR (for JSR to sdiv16) */

    /* === 1. Clamp raw_speed[+$74] to [0, $4268] === */
    mov.w   @(116,gbr),r0          /* R0 = entity[+$74] raw_speed */
    cmp/pz  r0
    bt      .fi_upper
    mov     #0,r0
    bra     .fi_clamped
    nop
.fi_upper:
    mov.w   @(.fi_pool1,pc),r1     /* R1 = $4268 (max speed) */
    cmp/gt  r1,r0
    bf      .fi_clamped
    mov     r1,r0
.fi_clamped:
    mov     r0,r4                   /* R4 = clamped speed (preserved) */

    /* === 2. Drag table lookup: index = speed >> 7 === */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                      /* R0 = speed >> 7 */
    add     r0,r0                   /* R0 = word offset */
    mov     r0,r5                   /* R5 = table word offset */

    /* Select drag table (globals +$10 = surface_drivability) */
    mov     #0x10,r0
    mov.b   @(r0,r13),r0
    tst     r0,r0
    bt      .fi_offroad
    mov.l   @(.fi_drag_a,pc),r6
    bra     .fi_tbl_ok
    nop
.fi_offroad:
    mov.l   @(.fi_drag_b,pc),r6
.fi_tbl_ok:
    mov     r5,r0                   /* R0 = word offset */
    mov.w   @(r0,r6),r0            /* R0 = drag_coeff */
    mov     r0,r2                   /* R2 = drag (D2 equiv) */

    /* === 3. Gear multiplier === */
    mov     #0x0C,r0
    mov.l   @(r0,r13),r6           /* R6 = gear_table_ptr */
    mov.w   @(122,gbr),r0          /* R0 = entity[+$7A] gear */
    mov     r0,r3                   /* R3 = gear (preserve) */
    add     r0,r0                   /* word offset */
    mov.w   @(r0,r6),r0            /* R0 = gear_ratio */
    mulu.w  r0,r2                   /* MACL = drag × gear (unsigned) */
    sts     macl,r2
    shlr2   r2
    shlr2   r2
    shlr    r2                      /* R2 = (drag × gear) >> 5 */

    /* === 4. Force direction === */
    mov.w   @(14,gbr),r0           /* R0 = entity[+$0E] force */
    muls.w  r0,r2                   /* MACL = drag × force (signed) */
    sts     macl,r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2                      /* R2 >>= 7 */

    /* Clamp force: if >= 0, skip. If < -512, clamp */
    cmp/pz  r2
    bt      .fi_fclamped
    mov.w   @(.fi_pool1+2,pc),r0   /* R0 = -512 ($FE00) */
    cmp/ge  r0,r2
    bt      .fi_fclamped
    mov     r0,r2
.fi_fclamped:

/* --- INTERMEDIATE LITERAL POOL 1 (within 510B of references above) --- */
    bra     .fi_after_pool1
    nop
.align 2
.fi_pool1:      .short  0x4268     /* max speed */
                .short  0xFE00     /* -512 min force */
.fi_drag_a:     .long   0x0213910E /* road drag table */
.fi_drag_b:     .long   0x02138FCE /* off-road drag table */
.fi_after_pool1:

    /* === 5. INLINED speed_calc_multiplier_chain === */
    /* 5a. Speed table lookup */
    mov     #0x08,r0
    mov.l   @(r0,r13),r6           /* R6 = speed_table_ptr */
    mov.w   @(4,gbr),r0            /* R0 = entity[+$04] velocity_index */
    add     r0,r0
    mov.w   @(r0,r6),r0            /* R0 = speed_table[index] */

    /* 5b. × track_speed_factor (globals +$02) */
    mov     #0x02,r0
    mov.w   @(r0,r13),r1           /* R1 = track_speed_factor */
    /* WAIT: @(disp,Rn) for Rn!=GBR needs R0 as dest. */
    /* Fix: load factor via R0 */
    mov     r0,r7                   /* R7 = save velocity (from speed table) */
    mov     #0x02,r0
    mov.w   @(r0,r13),r0           /* R0 = track_speed_factor */
    muls.w  r0,r7                   /* MACL = speed × factor */
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                      /* R0 >>= 8 */
    mov.w   r0,@(22,gbr)           /* entity[+$16] = calc_speed */
    mov     r0,r9                   /* R9 = calc_speed */

    /* 5c. Boost modifier */
    mov     #0x12,r0
    mov.b   @(r0,r13),r0           /* globals[+$12] has_boost_flag */
    tst     r0,r0
    bt      .fi_hi_spd
    mov     #16,r7                  /* R7 = 16 */
    mov.w   @(138,gbr),r0          /* R0 = entity[+$8A] boost_modifier */
    add     r0,r7                   /* R7 = 16 + boost */
    muls.w  r9,r7                   /* MACL = (16+boost) × speed */
    sts     macl,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                      /* >> 4 */
    mov     r0,r9
    mov.w   r0,@(22,gbr)

    /* 5d. High-speed ×0.69 (speed_state > 4) */
.fi_hi_spd:
    mov.w   @(168,gbr),r0          /* R0 = speed_state */
    mov     #4,r1
    cmp/gt  r1,r0
    bf      .fi_brk
    mov     r9,r1                   /* speed */
    add     r9,r9                   /* 2s */
    add     r9,r9                   /* 4s */
    add     r1,r9                   /* 5s */
    add     r9,r9                   /* 10s */
    add     r1,r9                   /* 11s */
    shar    r9
    shar    r9
    shar    r9
    shar    r9                      /* 11s/16 */
    bra     .fi_sto_cs
    nop

    /* 5e. Braking ×1.5 */
.fi_brk:
    mov.w   @(168,gbr),r0
    tst     r0,r0
    bt      .fi_sto_cs
    mov.w   @(6,gbr),r0            /* base_speed */
    mov     r0,r7                   /* preserve */
    mov.w   @(10,gbr),r0           /* min_threshold */
    cmp/gt  r0,r7                   /* base > min? */
    bf      .fi_sto_cs
    mov     r9,r1
    shar    r1
    add     r1,r9                   /* 1.5× */

.fi_sto_cs:
    mov     r9,r0
    mov.w   r0,@(22,gbr)

    /* 5f. Wind correction (inlined speed_modifier) */
    mov     #0x11,r0
    mov.b   @(r0,r13),r0           /* wind_active */
    tst     r0,r0
    bt      .fi_boost
    mov     r0,r10                  /* R10 = wind flag */
    mov.w   @(4,gbr),r0            /* speed */
    muls.w  r0,r0
    sts     macl,r0
    shlr2   r0
    shlr2   r0                      /* speed² >> 4 */
    mov     #2,r1
    cmp/gt  r1,r10
    bt      .fi_wind_add
    shlr    r0                      /* flag <= 2: halve */
.fi_wind_add:
    mov     r0,r7                   /* save wind correction */
    mov.w   @(22,gbr),r0           /* R0 = calc_speed */
    add     r7,r0                   /* R0 += wind */
    mov     r0,r9

    /* Wind 3/4 bonus */
    shar    r0                      /* speed/2 */
    mov     r0,r1
    shar    r1                      /* speed/4 */
    add     r1,r0                   /* 3/4 */
    add     r0,r9
    mov     r9,r0
    mov.w   r0,@(22,gbr)

    /* 5g. Boost timer */
.fi_boost:
    mov.w   @(20,gbr),r0           /* entity[+$14] */
    cmp/pz  r0
    bf      .fi_bst_done
    tst     r0,r0
    bt      .fi_bst_done
    add     #-1,r0
    mov.w   r0,@(20,gbr)           /* timer-- */
    mov.w   @(22,gbr),r0           /* calc_speed */
    mov.w   @(.fi_pool2,pc),r1     /* $738 boost */
    /* WAIT: same issue. pc-relative load to R0 only for MOV.W. */
    /* But MOV.W @(disp,PC),Rn — is Rn restricted to R0? Let me check. */
    /* Actually: MOV.W @(disp,PC),Rn can target ANY register (not just R0). */
    /* Only GBR-relative is R0-restricted. PC-relative is general. */
    add     r1,r0
    mov.w   r0,@(22,gbr)
.fi_bst_done:

    /* === 6. Subtract friction + air drag === */
    mov.w   @(22,gbr),r0           /* calc_speed */
    exts.w  r0,r1
    shll2   r1
    shll2   r1                      /* × 16 */
    sub     r1,r2                   /* R2 -= friction */

    mov.w   @(16,gbr),r0           /* entity[+$10] drag */
    mov.w   @(.fi_pool2+2,pc),r1   /* $71C0 air coeff */
    muls.w  r1,r0
    sts     macl,r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1                      /* >> 7 */
    sub     r1,r2                   /* R2 -= air drag */

    cmp/pz  r2
    bt      .fi_no_dbl
    add     r2,r2                   /* decel penalty: double */
.fi_no_dbl:

    /* === 7. Reset grip, overflow check === */
    mov.w   @(.fi_pool2+4,pc),r0   /* $0100 grip 1.0 */
    mov.w   r0,@(120,gbr)          /* entity[+$78] = 1.0 */

    mov     #0x28,r0
    mov.w   @(r0,r13),r0           /* min_speed_threshold */
    neg     r0,r0
    exts.w  r0,r0                   /* R0 = -threshold */
    cmp/gt  r0,r2
    bt      .fi_overspd

    mov     r0,r1
    add     r1,r1                   /* -2× threshold */
    cmp/gt  r1,r2
    bt      .fi_clamp_min           /* not extreme */

    /* Skid sound $B1 */
    mov.w   @(128,gbr),r0          /* sound_timer */
    tst     r0,r0
    bf      .fi_clamp_min
    mov.w   @(140,gbr),r0          /* lateral_flag */
    tst     r0,r0
    bf      .fi_clamp_min
    mov.w   @(4,gbr),r0            /* speed */
    mov     #20,r7
    cmp/gt  r7,r0
    bf      .fi_clamp_min
    mov     #15,r0
    mov.w   r0,@(128,gbr)          /* timer = 15 */
    mov     #0x2C,r0
    mov     #0xB1,r1
    extu.b  r1,r1
    mov.b   r1,@(r0,r13)           /* sound = $B1 */

.fi_clamp_min:
    mov     #0x28,r0
    mov.w   @(r0,r13),r0
    neg     r0,r0
    exts.w  r0,r0
    mov     r0,r2
    bra     .fi_integ
    nop

/* --- INTERMEDIATE LITERAL POOL 2 --- */
.align 2
.fi_pool2:      .short  0x0738     /* boost addition */
                .short  0x71C0     /* air resistance coeff */
                .short  0x0100     /* grip 1.0 (8.8) */

    /* === 8. Overspeed: grip reduction === */
.fi_overspd:
    mov     #0x2A,r0
    mov.w   @(r0,r13),r0           /* max_speed_threshold */
    exts.w  r0,r0
    mov     r0,r5
    cmp/gt  r5,r2
    bf      .fi_integ

    mov     r2,r0
    sub     r5,r0
    shll8   r0                      /* excess << 8 */
    mov     r5,r1                   /* divisor */
    mov.l   @(.fi_sdiv_addr,pc),r6
    jsr     @r6
    nop
    /* R0 = ratio (from DIVS) */
    /* 68K logic: SUB.W D1,grip; CMPI.W #$80,D1; BLE .squeal; MOVE.W #$80,grip */
    /* = subtract ratio from grip, then if ratio > 128, override grip to 128 */
    mov     r0,r7                   /* R7 = ratio */
    mov.w   @(120,gbr),r0          /* R0 = grip */
    sub     r7,r0                   /* R0 = grip - ratio */
    mov.w   r0,@(120,gbr)          /* store subtracted grip */
    /* Check RATIO (not grip!) against 128 — match 68K CMPI.W #$80,D1 / BLE */
    mov     #0x80,r1
    extu.b  r1,r1                   /* R1 = 128 */
    cmp/gt  r1,r7                   /* T = (ratio > 128) signed */
    bf      .fi_squeal              /* ratio <= 128: keep subtracted grip */
    mov     r1,r0                   /* ratio > 128: override grip to 128 */
    mov.w   r0,@(120,gbr)

.fi_squeal:
    mov.w   @(122,gbr),r0          /* gear */
    tst     r0,r0
    bf      .fi_integ
    mov.w   @(130,gbr),r0          /* brake_timer */
    tst     r0,r0
    bf      .fi_integ
    mov     #15,r0
    mov.w   r0,@(130,gbr)
    mov     #0x2C,r0
    mov     #0xB4,r1
    extu.b  r1,r1
    mov.b   r1,@(r0,r13)           /* sound = $B4 */

    /* === 9. Integrate === */
.fi_integ:
    shar    r2                      /* force/2 */
    mov.w   @(120,gbr),r0          /* grip */
    muls.w  r0,r2
    sts     macl,r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2                      /* (force/2 × grip) >> 7 */

    /* === 10. Slope via reciprocal === */
    mov     r2,r1
    shar    r1
    shar    r1                      /* force/4 */
    exts.w  r1,r1
    mov.l   @(.fi_r400_addr,pc),r0  /* 41943 */
    dmuls.l r0,r1                   /* 64-bit product */
    sts     macl,r1
    shlr16  r1
    shlr8   r1                      /* >> 24 = slope */

    mov     r1,r0
    mov.w   r0,@(12,gbr)           /* entity[+$0C] slope */
    mov.w   @(6,gbr),r0            /* display_speed */
    add     r1,r0
    cmp/pz  r0
    bt      .fi_dsp_ok
    mov     #0,r0
.fi_dsp_ok:
    mov.w   r0,@(6,gbr)            /* entity[+$06] */

    /* === 11. Raw speed = gear × display × 596/4096 === */
    mov     #0x0C,r0
    mov.l   @(r0,r13),r6           /* gear_table_ptr */
    mov     r3,r0                   /* gear (preserved in R3) */
    add     r0,r0
    mov.w   @(r0,r6),r7            /* R7 = gear_ratio */
    mov.w   @(6,gbr),r0            /* display_speed */
    muls.w  r0,r7
    sts     macl,r5                 /* R5 = base product */

    /* ×596/4096: 596 = 512 + 64 + 16 + 4 */
    mov     r5,r4                   /* base */
    shll2   r5                      /* ×4 */
    mov     r5,r6                   /* R6 = ×4 */
    shll2   r5                      /* ×16 */
    add     r5,r6                   /* ×20 */
    shll2   r5                      /* ×64 */
    add     r5,r6                   /* ×84 */
    shll    r5
    shll    r5
    shll    r5                      /* ×512 */
    add     r6,r5                   /* ×596 */
    shlr8   r5
    shlr2   r5
    shlr2   r5                      /* >> 12 */

    /* Clamp [0, $4268] */
    cmp/pz  r5
    bt      .fi_raw_upper
    mov     #0,r5
.fi_raw_upper:
    mov.w   @(.fi_pool3,pc),r1     /* $4268 */
    cmp/gt  r1,r5
    bf      .fi_raw_ok
    mov     r1,r5
.fi_raw_ok:
    mov     r5,r0
    mov.w   r0,@(116,gbr)          /* entity[+$74] raw_speed */

    lds.l   @r15+,pr
    rts
    nop

.align 2
.fi_sdiv_addr:  .long   0x023016E0 /* sh2_sdiv16 address (at physics_divide base $3016E0) */
.fi_r400_addr:  .long   41943      /* reciprocal of 400 */
.fi_pool3:      .short  0x4268     /* max speed */


.global physics_group1_end
physics_group1_end:
/* Grand total: functions 1+5+2+3 */
