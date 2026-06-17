/*
 * physics_timers — SH2 Timer/Guard Functions for VR60 Phase 3B
 * Expansion ROM Address: $301C40 (SH2: $02301C40)
 *
 * Co-ported from 68K to solve the entity ownership problem.
 * These functions modify entity fields that physics depends on,
 * so they must run on the same CPU as physics (Master SH2).
 *
 * Convention: GBR = entity base ($0600F20C), R13 = globals base ($0600F30C)
 * GBR word displacement: gas expects BYTE OFFSET, divides by 2 internally.
 *   Example: entity+$98 → @(0x98,gbr) → gas encodes disp=0x4C
 * All functions are leaf (no JSR).
 * Clobbers: R0, R1, R2 (varies per function)
 * Preserves: GBR, R13, R14, R15
 */

.section .text
.align 2

/* ============================================================================
 * sh2_timer_decrement_multi — Decrement 8 entity timer fields
 * 68K: $008548-$00859A (82 bytes)
 *
 * For each of 8 timers: if timer > 0, decrement by 1.
 * Fields: +$80, +$82, +$84, +$86, +$98, +$9A, +$E6, +$E8
 * Clobbers: R0
 * ============================================================================
 */
.global sh2_timer_decrement_multi
sh2_timer_decrement_multi:
    mov.w   @(0x98,gbr),r0         /* +$98 screech_timer_A */
    cmp/pl  r0
    bf      .td_1
    add     #-1,r0
    mov.w   r0,@(0x98,gbr)
.td_1:
    mov.w   @(0x9A,gbr),r0         /* +$9A screech_timer_B */
    cmp/pl  r0
    bf      .td_2
    add     #-1,r0
    mov.w   r0,@(0x9A,gbr)
.td_2:
    mov.w   @(0x86,gbr),r0         /* +$86 timer_aux */
    cmp/pl  r0
    bf      .td_3
    add     #-1,r0
    mov.w   r0,@(0x86,gbr)
.td_3:
    mov.w   @(0x80,gbr),r0         /* +$80 sound_timer */
    cmp/pl  r0
    bf      .td_4
    add     #-1,r0
    mov.w   r0,@(0x80,gbr)
.td_4:
    mov.w   @(0x82,gbr),r0         /* +$82 brake_timer */
    cmp/pl  r0
    bf      .td_5
    add     #-1,r0
    mov.w   r0,@(0x82,gbr)
.td_5:
    mov.w   @(0x84,gbr),r0         /* +$84 brake_timer_2 */
    cmp/pl  r0
    bf      .td_6
    add     #-1,r0
    mov.w   r0,@(0x84,gbr)
.td_6:
    mov.w   @(0xE6,gbr),r0         /* +$E6 screech_timer_C */
    cmp/pl  r0
    bf      .td_7
    add     #-1,r0
    mov.w   r0,@(0xE6,gbr)
.td_7:
    mov.w   @(0xE8,gbr),r0         /* +$E8 screech_timer_D */
    cmp/pl  r0
    bf      .td_done
    add     #-1,r0
    mov.w   r0,@(0xE8,gbr)
.td_done:
    rts
    nop

/* ============================================================================
 * sh2_effect_timer_mgmt — Animation effect timer management
 * 68K: $00A350-$00A3B8 (106 bytes)
 *
 * If timer (+$6A) > 0: lookup sine table, update sine value (+$6E),
 *   decrement timer, increment index (+$6C).
 * If timer expired: check flags (+$02) bits 12/13 for spin-out,
 *   clear flags, reinitialize timer/index/effect duration.
 *
 * Sine table: ROM at $00A2D8 (68K) = file offset $1A2D8 = SH2 $021A2D8
 * Clobbers: R0, R1, R2
 * ============================================================================
 */
.global sh2_effect_timer_mgmt
sh2_effect_timer_mgmt:
    mov.w   @(0x6A,gbr),r0        /* +$6A timer */
    cmp/pl  r0                    /* T = (timer > 0) */
    bf      .et_expired           /* timer <= 0: check flags */

    /* Timer active: lookup sine, update, decrement */
    mov.w   @(0x6C,gbr),r0        /* +$6C index */
    add     r0,r0                 /* word offset (index × 2) */
    mov.l   @(.et_sine_tbl,pc),r1 /* sine table base */
    mov.w   @(r0,r1),r0           /* sine_table[index] */
    mov.w   r0,@(0x6E,gbr)        /* +$6E = sine value */
    /* Decrement timer */
    mov.w   @(0x6A,gbr),r0        /* +$6A */
    add     #-1,r0
    mov.w   r0,@(0x6A,gbr)
    /* Increment index */
    mov.w   @(0x6C,gbr),r0        /* +$6C */
    add     #1,r0
    mov.w   r0,@(0x6C,gbr)
    rts
    nop

.et_expired:
    /* Timer expired: check spin-out flags in +$02 */
    mov.w   @(0x02,gbr),r0        /* +$02 flags */
    mov     r0,r1                 /* save flags */

    /* Check bit 13 ($2000) */
    mov.w   @(.et_mask_2000,pc),r2
    tst     r2,r0                 /* flags & $2000 */
    bt      .et_check_bit12       /* bit 13 clear */

    /* Bit 13 set: clear it, reinitialize */
    mov.w   @(.et_clear_2000,pc),r2  /* $DFFF */
    and     r2,r1
    mov     r1,r0
    mov.w   r0,@(0x02,gbr)        /* +$02: clear bit 13 */
    mov     #90,r0                /* 60 FPS: 30×3 = 90 */
    mov.w   r0,@(0x6C,gbr)        /* +$6C index = 90 */
    mov.w   r0,@(0x6A,gbr)        /* +$6A timer = 90 */
    mov.w   r0,@(0x14,gbr)        /* +$14 duration = 90 */
    mov     #0,r0
    mov.w   r0,@(0x0E,gbr)        /* +$0E effect = 0 */
    rts
    nop

.et_check_bit12:
    mov.w   @(.et_mask_1000,pc),r2
    tst     r2,r0                 /* flags & $1000 */
    bt      .et_return            /* bit 12 clear: nothing */

    /* Bit 12 set: clear it, reinitialize */
    mov.w   @(.et_clear_1000,pc),r2  /* $EFFF */
    and     r2,r1
    mov     r1,r0
    mov.w   r0,@(0x02,gbr)        /* +$02: clear bit 12 */
    mov     #0,r0
    mov.w   r0,@(0x0E,gbr)        /* +$0E = 0 */
    mov.w   r0,@(0x6C,gbr)        /* +$6C = 0 */
    mov     #90,r0                /* 60 FPS: 30×3 = 90 */
    mov.w   r0,@(0x6A,gbr)        /* +$6A = 90 */
    mov.w   r0,@(0x14,gbr)        /* +$14 = 90 */
.et_return:
    rts
    nop

.align 2
.et_sine_tbl:   .long   0x021A2D8   /* sine table ROM */
.et_mask_2000:  .short  0x2000
.et_clear_2000: .short  0xDFFF
.et_mask_1000:  .short  0x1000
.et_clear_1000: .short  0xEFFF

/* ============================================================================
 * sh2_timer_expire_reset — Timer expiry + heading/speed_param reset
 * 68K: $008170-$0081C0 (80 bytes)
 *
 * If timer (+$62) > 0: decrement. If just reached 0 AND player entity:
 *   write 15 to globals track_tilt, set +$92 = $28, copy +$3C → +$40.
 *
 * SIMPLIFICATION: For player entity (entity 0), object_id (+$24) = $00,
 *   which is < $69, so the 68K type check chain always reaches .set_speed.
 *   The $C89C/$C8C8 conditional paths are unreachable for entity 0.
 * Clobbers: R0, R1
 * ============================================================================
 */
.global sh2_timer_expire_reset
sh2_timer_expire_reset:
    mov.w   @(0x62,gbr),r0        /* +$62 timer */
    cmp/pl  r0
    bf      .te_done              /* timer <= 0 */

    add     #-1,r0
    mov.w   r0,@(0x62,gbr)        /* --timer */
    tst     r0,r0                 /* reached 0? */
    bf      .te_done              /* not yet */

    /* Timer just expired: set speed_frames, speed_param, copy heading */
    mov     #15,r1                /* value = 15 */
    mov     #0,r0                 /* offset = 0 */
    mov.w   r1,@(r0,r13)          /* globals+$00 = track_tilt = 15 */

    mov     #0x28,r0              /* speed_param = 40 */
    mov.w   r0,@(0x92,gbr)        /* +$92 */

    mov.w   @(0x3C,gbr),r0        /* +$3C heading_mirror */
    mov.w   r0,@(0x40,gbr)        /* +$40 heading = mirror */

.te_done:
    rts
    nop

/* ============================================================================
 * sh2_field_check_guard — Guard gate: check +$8C lateral flag
 * 68K: $0080CC-$0080D5 (10 bytes)
 *
 * Loads entity +$8C into R2. Caller (cmd $3F) can check R2.
 * Clobbers: R0, R2
 * ============================================================================
 */
.global sh2_field_check_guard
sh2_field_check_guard:
    mov     #0,r2
    mov     #0x8C,r0
    extu.b  r0,r0                 /* R0 = 140 */
    mov.w   @(r0,r14),r0          /* entity[+$8C] */
    mov     r0,r2                 /* R2 = lateral flag */
    rts
    nop

/* ============================================================================
 * sh2_anim_timer_speed_clear — Timer expiry → speed clear
 * 68K: $007E74-$007EA4 (48 bytes, enter at +6)
 *
 * Tests bit 1 of +$55. If set: clear frame counter, return.
 * If clear: increment frame counter. If counter > 80: clear counter +
 *   clear speed (+$06).
 *
 * Frame counter stored at entity+$F0 (persistent, within 256B entity record).
 * NOT in globals block (globals+$30 is cleared every frame by staging).
 * The 68K uses WRAM $C02A; the SH2 uses entity+$F0 as equivalent.
 * JMP to conditional_return_on_state_match replaced with RTS
 *   (the conditional fallthrough path handles edge-case state transitions
 *    that don't occur during normal racing for entity 0).
 * Clobbers: R0, R1
 * ============================================================================
 */
.global sh2_anim_timer_speed_clear
sh2_anim_timer_speed_clear:
    /* Test bit 1 of +$55 — byte access via R0+R14 indexed */
    mov     #0x55,r0
    extu.b  r0,r0
    mov.b   @(r0,r14),r0          /* entity[+$55] byte */
    tst     #2,r0                 /* bit 1? */
    bf      .ac_clear_counter     /* set: clear counter */

    /* Bit 1 clear: increment frame counter at entity+$F0 */
    mov.w   @(0xF0,gbr),r0        /* entity+$F0 = anim frame counter */
    add     #1,r0                 /* counter++ */
    mov.w   r0,@(0xF0,gbr)        /* store back */

    /* Check if counter > 240 (60 FPS: 80×3) */
    mov.w   @(.ac_threshold,pc),r1
    cmp/gt  r1,r0                 /* counter > 240? */
    bf      .ac_done              /* not yet */

    /* Counter exceeded 80: clear counter, clear speed */
    mov     #0,r0
    mov.w   r0,@(0xF0,gbr)        /* entity+$F0 = 0 (clear counter) */
    mov.w   r0,@(0x06,gbr)        /* entity+$06 = 0 (clear speed) */

.ac_done:
    rts
    nop

.ac_clear_counter:
    /* Bit 1 was set: clear frame counter and return */
    mov     #0,r0
    mov.w   r0,@(0xF0,gbr)        /* entity+$F0 = 0 */
    rts
    nop

.align 2
.ac_threshold:  .short  240        /* 60 FPS: 80×3 = 240 frame threshold */

.global physics_timers_end
physics_timers_end:
