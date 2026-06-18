/*
 * collision_leaf — SH2 Pure-Math Collision/BSP Leaf Functions (VR60 Phase 5A)
 * Expansion ROM Address: $302D00 (SH2: $02302D00)
 *
 * Three zero-addressing-risk leaf functions ported 1:1 from 68K. These are
 * REGISTER-PARAMETER pure-math leaves (NOT GBR/entity-field functions):
 * the caller supplies all pointers and scalars in registers, exactly as the
 * 68K originals do. No WRAM access, no DIV, no COMM. The only external call
 * is rotational_offset_calc's sine/cosine, which reuses the existing
 * .pu_sin_lookup routine in physics_pos_update (SH2 $02301EDC) — verified to
 * produce identical Q8 (±256) output to the 68K sine_cosine_quadrant_lookup
 * (same table at file $130000, same quadrant scheme).
 *
 * 5A is ADDITIVE ONLY — these are NOT wired into cmd $3F dispatch yet
 * (integration happens in a later sub-phase). 5A proves they assemble, link,
 * and are byte-correct translations.
 *
 * SH2 translation notes vs 68K:
 *   - 68K ASL.W #1,Dn -> SH2 SHLL Rn (shifts bit15 into T; bcs/bcc -> bt/bf)
 *   - 68K EXT.L Dn     -> SH2 EXTS.W Rn (sign-extend word to long)
 *   - 68K ASL.L #5,Dn  -> 5x SHLL ; ASR.L #6,Dn -> 6x SHAR (no var-count shift)
 *   - 68K ASL.L D5,Dn (D5=9) -> 9x SHLL ; ASR.L D5,Dn -> 9x SHAR
 *   - 68K MULS.W (A1)+,D0 -> mov.w @r_ptr+,rTmp ; muls.w rTmp,rD ; sts macl,rD
 *   - 68K DBRA Dn,lbl  -> add #-1,rn ; cmp/eq #-1 path emulated with explicit
 *                          decrement-and-test (SH2 has no DBRA)
 *   - 68K CMP.L Dx,Dy / BLT -> signed compare via cmp/ge + bf (BLT = !(>=) )
 *   - 68K ASL.W #1,D3 tests bit15 of a 16-bit reg; SH2 SHLL tests bit31 of a
 *     32-bit reg. The plane selector is moved into bits 31:16 with SHLL16 at
 *     read time so each subsequent SHLL shifts out the original bit15. (Caught
 *     by exhaustive simulation — without it the carry-driven BSP branches were
 *     wrong for selectors with bit15 set after sign-extension by MOV.W.)
 *   - 68K coefficient-path branch polarity is ASYMMETRIC between the D1 and D2
 *     paths (D1 positive uses BCS->found, D2 positive uses BCC->found). This is
 *     preserved exactly; verified against a faithful 68K reference model.
 *
 * VERIFICATION: angle_normalize/_alt (40k cases), _p24 (20k), plane_eval/_signed
 * (10k), rotational_offset_calc (30k) all byte-match a 68K reference model
 * (SH2-opcode simulator + Q8 sine from ROM table file $130000).
 *
 * Register mapping for angle_normalize / angle_normalize_alt:
 *   R1 = D1 (angle 1)     R2 = D2 (angle 2)     R3 = D3 (plane selector word)
 *   R4 = D4 (constant)    R0 = D0 (scratch/result)
 *   R6 = D6 (4-bit counter)  R7 = D7 (outer plane-group counter)
 *   R8 = A1 (BSP data ptr, advancing)  R9 = A2 (saved base ptr)
 *   (R8/R9 are used as plain locals here — these leaves never touch COMM/GBR.)
 *   Returns: R0 = 1 visible, 0 culled.
 *
 * Clobbers: R0-R9.
 * Preserves: GBR, R13, R14, R15, PR (rotational_offset_calc saves PR).
 */

.section .text
.align 2

/* ============================================================================
 * angle_normalize — Full BSP visibility test with flag check
 * 68K: $00748C-$0075C6 (entry $748C; +24 entry $74A4; alt entry $7534)
 *
 * Entry points (all externally called):
 *   angle_normalize      ($748C): normalize D1/D2, then read flag, BSP test
 *   angle_normalize_p24  ($74A4): skip normalization, enter at flag read
 *   angle_normalize_alt  ($7534): normalize D1/D2, single-pass BSP (no outer
 *                                  loop, inverted found/visible result)
 *
 * In:  R1 = angle1, R2 = angle2, R8 = BSP data ptr
 * Out: R0 = 1 (visible) / 0 (culled)
 * ============================================================================
 */
.global angle_normalize
angle_normalize:
    /* Normalize D1: (D1 + $4000) & $1FF, *2, sign-extend to long */
    mov.w   @(.an_c4000,pc),r0
    add     r0,r1                  /* addi.w #$4000,d1 */
    mov.w   @(.an_c01ff,pc),r0
    and     r0,r1                  /* andi.w #$01FF,d1 */
    shll    r1                     /* asl.w #1,d1 */
    exts.w  r1,r1                  /* ext.l d1 */
    /* Normalize D2 likewise */
    mov.w   @(.an_c4000,pc),r0
    add     r0,r2
    mov.w   @(.an_c01ff,pc),r0
    and     r0,r2
    shll    r2
    exts.w  r2,r2

.global angle_normalize_p24
angle_normalize_p24:
    /* +24 entry ($74A4): read visibility flag word */
    mov.w   @r8+,r7                /* move.w (a1)+,d7 ; D7 = flag/outer count */
    cmp/pz  r7                     /* bpl.s .bsp_test (T = flag >= 0) */
    bt      .an_bsp_test
    mov     #0,r0                  /* not visible */
    rts
    nop

.an_bsp_test:
    add     #1,r7                  /* dbra d7 loops d7+1 times -> dt counter = d7+1 */
    mov     r8,r9                  /* movea.l a1,a2 ; A2 = saved base */
.an_read_plane:
    mov.w   @r8+,r3               /* move.w (a1)+,d3 ; plane selector */
    shll16  r3                     /* selector -> bits 31:16 so SHLL tests bit15-equiv */
    mov     #4,r6                  /* dbra d6 (d6=3) loops 4 times -> dt counter = 4 */
.an_bit_test:
    shll    r3                     /* asl.w #1,d3 ; bit15 -> T */
    bt      .an_d2_coef            /* bcs .d2_coef */
    shll    r3                     /* asl.w #1,d3 ; bit14 -> T */
    bt      .an_d1_direct          /* bcs .d1_direct */
    /* --- D1 coefficient path: (D1*coef + const<<9) >> 9 --- */
    mov     r1,r0                  /* D0 = D1 */
    mov.w   @r8+,r4               /* coefficient (a1)+ */
    muls.w  r4,r0
    sts     macl,r0                /* D0 = D1*coef */
    mov.w   @r8+,r4               /* constant (a1)+ */
    exts.w  r4,r4                  /* ext.l d4 */
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4                     /* d4 <<= 9 */
    add     r4,r0                  /* D0 += const<<9 */
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* D0 >>= 9 (arithmetic) */
    /* cmp.l d0,d2 ; blt .d1_neg   (BLT: D2 < D0) */
    cmp/ge  r0,r2                  /* T = (D2 >= D0) */
    bf      .an_d1_neg             /* D2 < D0 */
    shll    r3                     /* asl.w #1,d3 ; bcs .found */
    bt      .an_found
    bra     .an_next_bit
    nop
.an_d1_neg:
    shll    r3                     /* asl.w #1,d3 ; bcc .found */
    bf      .an_found
    bra     .an_next_bit
    nop

    /* --- D1 direct compare path --- */
.an_d1_direct:
    mov.w   @r8,r0                /* cmp.w (a1),d1 ; load plane value (no inc) */
    exts.w  r0,r0
    /* blt .d1_dir_neg : D1 < value */
    cmp/ge  r0,r1                  /* T = (D1 >= value) */
    bf      .an_d1_dir_neg
    shll    r3                     /* asl.w #1,d3 ; bcc .found */
    bf      .an_found
    bra     .an_next_plane_skip
    nop
.an_d1_dir_neg:
    shll    r3                     /* asl.w #1,d3 ; bcs .found */
    bt      .an_found
    bra     .an_next_plane_skip
    nop

    /* --- D2 coefficient path --- */
.an_d2_coef:
    shll    r3                     /* asl.w #1,d3 ; bit14 -> T */
    bt      .an_d2_direct          /* bcs .d2_direct */
    mov     r2,r0                  /* D0 = D2 */
    mov.w   @r8+,r4
    muls.w  r4,r0
    sts     macl,r0                /* D0 = D2*coef */
    mov.w   @r8+,r4               /* constant */
    exts.w  r4,r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4                     /* <<9 */
    add     r4,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0                     /* >>9 */
    /* cmp.l d0,d1 ; blt .d2_neg  (BLT: D1 < D0) */
    cmp/ge  r0,r1                  /* T = (D1 >= D0) */
    bf      .an_d2_neg
    shll    r3                     /* asl.w #1,d3 ; bcc .found */
    bf      .an_found
    bra     .an_next_bit
    nop
.an_d2_neg:
    shll    r3                     /* asl.w #1,d3 ; bcs .found */
    bt      .an_found
    bra     .an_next_bit
    nop

    /* --- D2 direct compare path --- */
.an_d2_direct:
    mov.w   @r8,r0               /* cmp.w (a1),d2 */
    exts.w  r0,r0
    /* blt .d2_dir_neg : D2 < value */
    cmp/ge  r0,r2                  /* T = (D2 >= value) */
    bf      .an_d2_dir_neg
    shll    r3                     /* asl.w #1,d3 ; bcs .found */
    bt      .an_found
    bra     .an_next_plane_skip
    nop
.an_d2_dir_neg:
    shll    r3                     /* asl.w #1,d3 ; bcc .found */
    bf      .an_found
    /* fall through to next_plane_skip */
.an_next_plane_skip:
    add     #4,r8                  /* addq.l #4,a1 ; skip unread data */
.an_next_bit:
    /* dbra d6,.bit_test : dt counter, loop while non-zero (4 iterations) */
    dt      r6
    bf      .an_bit_test
    /* All 4 bits tested -> polygon visible */
    mov     #1,r0
    bra     .an_return
    nop
.an_found:
    mov     #0x1C,r0
    add     r0,r9                  /* adda.l #$1C,a2 ; advance 28 bytes */
    mov     r9,r8                  /* movea.l a2,a1 ; restore A1 */
    /* dbra d7,.read_plane : dt counter (= d7+1), loop while non-zero */
    dt      r7
    bf      .an_read_plane
    /* Outer loop exhausted -> culled */
    mov     #0,r0
.an_return:
    rts
    nop

.align 1
.an_c4000:  .short  0x4000
.an_c01ff:  .short  0x01FF

/* ============================================================================
 * angle_normalize_alt — BSP test without flag check, single pass
 * 68K: $007534-$0075C6
 *
 * In:  R1 = angle1, R2 = angle2, R8 = BSP data ptr
 * Out: R0 = 1 (visible) / 0 (culled)
 * ============================================================================
 */
.global angle_normalize_alt
angle_normalize_alt:
    mov.w   @(.aa_c4000,pc),r0
    add     r0,r1
    mov.w   @(.aa_c01ff,pc),r0
    and     r0,r1
    shll    r1
    exts.w  r1,r1
    mov.w   @(.aa_c4000,pc),r0
    add     r0,r2
    mov.w   @(.aa_c01ff,pc),r0
    and     r0,r2
    shll    r2
    exts.w  r2,r2
    mov     r8,r9                  /* movea.l a1,a2 */
.aa_read_plane:
    mov.w   @r8+,r3
    shll16  r3                     /* selector -> bits 31:16 so SHLL tests bit15-equiv */
    mov     #4,r6                  /* dbra d6 (d6=3) loops 4 times -> dt counter = 4 */
.aa_bit_test:
    shll    r3
    bt      .aa_d2_coef
    shll    r3
    bt      .aa_d1_direct
    /* --- D1 coefficient path --- */
    mov     r1,r0
    mov.w   @r8+,r4
    muls.w  r4,r0
    sts     macl,r0
    mov.w   @r8+,r4
    exts.w  r4,r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    add     r4,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    cmp/ge  r0,r2                  /* blt .alt_d1_neg : D2 < D0 */
    bf      .aa_d1_neg
    shll    r3                     /* bcs .alt_found */
    bt      .aa_found
    bra     .aa_next_bit
    nop
.aa_d1_neg:
    shll    r3                     /* bcc .alt_found */
    bf      .aa_found
    bra     .aa_next_bit
    nop
    /* --- D1 direct compare --- */
.aa_d1_direct:
    mov.w   @r8,r0
    exts.w  r0,r0
    cmp/ge  r0,r1                  /* blt .alt_d1_dir_neg : D1 < value */
    bf      .aa_d1_dir_neg
    shll    r3                     /* bcc .alt_found */
    bf      .aa_found
    bra     .aa_next_plane_skip
    nop
.aa_d1_dir_neg:
    shll    r3                     /* bcs .alt_found */
    bt      .aa_found
    bra     .aa_next_plane_skip
    nop
    /* --- D2 coefficient path --- */
.aa_d2_coef:
    shll    r3
    bt      .aa_d2_direct
    mov     r2,r0
    mov.w   @r8+,r4
    muls.w  r4,r0
    sts     macl,r0
    mov.w   @r8+,r4
    exts.w  r4,r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    shll    r4
    add     r4,r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    shar    r0
    cmp/ge  r0,r1                  /* blt .alt_d2_neg : D1 < D0 */
    bf      .aa_d2_neg
    shll    r3                     /* bcc .alt_found */
    bf      .aa_found
    bra     .aa_next_bit
    nop
.aa_d2_neg:
    shll    r3                     /* bcs .alt_found */
    bt      .aa_found
    bra     .aa_next_bit
    nop
    /* --- D2 direct compare --- */
.aa_d2_direct:
    mov.w   @r8,r0
    exts.w  r0,r0
    cmp/ge  r0,r2                  /* blt .alt_d2_dir_neg : D2 < value */
    bf      .aa_d2_dir_neg
    shll    r3                     /* bcs .alt_found */
    bt      .aa_found
    bra     .aa_next_plane_skip
    nop
.aa_d2_dir_neg:
    shll    r3                     /* bcc .alt_found */
    bf      .aa_found
.aa_next_plane_skip:
    add     #4,r8
.aa_next_bit:
    dt      r6                     /* dbra d6 -> dt counter (4 iterations) */
    bf      .aa_bit_test
    /* All bits tested -> visible */
    mov     #1,r0
    bra     .aa_return
    nop
.aa_found:
    mov     #0,r0                  /* alt: found -> culled (inverted) */
.aa_return:
    rts
    nop

.align 1
.aa_c4000:  .short  0x4000
.aa_c01ff:  .short  0x01FF

/* ============================================================================
 * plane_eval / plane_eval_signed — BSP plane evaluation pair
 * 68K: $0075C8-$0075FD (54 bytes; +24 = plane_eval at $75E0... see note)
 *
 * plane_eval:        result = (D1*coefA + D2*coefB + C<<5) >> 6
 * plane_eval_signed: if A2+$19 byte >= 0 -> plane_eval (shift 6),
 *                    else                -> shift 5 (less aggressive)
 *
 * In:  R1 = angle1 (D1), R2 = angle2 (D2), R9 = plane data ptr (A2)
 * Out: R1 = evaluation result (matches 68K: result in D1)
 * Fields: A2+$12 coefA(w), +$14 coefB(w), +$16 C(w), +$19 sign(b)
 *
 * NOTE: 68K entry plane_eval = $75C8, plane_eval_signed = $75E0 ($75C8+24).
 * Here the source order is reversed for fall-through clarity:
 * plane_eval_signed checks the sign byte and either branches to plane_eval
 * (shift 6) or runs the shift-5 body inline, exactly mirroring the 68K.
 * ============================================================================
 */
.global plane_eval
plane_eval:
    mov.w   @(0x12,r9),r0         /* coefA */
    muls.w  r0,r1
    sts     macl,r1                /* D1 = D1*coefA */
    mov.w   @(0x14,r9),r0         /* coefB */
    muls.w  r0,r2
    sts     macl,r2                /* D2 = D2*coefB */
    add     r2,r1                  /* add.l d2,d1 */
    mov.w   @(0x16,r9),r0         /* C */
    exts.w  r0,r0                  /* ext.l d2 (constant) */
    shll    r0
    shll    r0
    shll    r0
    shll    r0
    shll    r0                     /* asl.l #5 */
    add     r0,r1                  /* add.l d2,d1 */
    shar    r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1                     /* asr.l #6 */
    rts
    nop

.global plane_eval_signed
plane_eval_signed:
    mov     #0x19,r0
    mov.b   @(r0,r9),r0          /* tst.b $19(a2) — load sign byte */
    extu.b  r0,r0                 /* zero-extend (mov.b sign-extends) */
    /* 68K BPL tests bit7 of the byte: bit7 clear -> positive -> shift-6 path */
    tst     #0x80,r0
    bt      plane_eval             /* bit7 clear -> positive -> plane_eval (shift 6) */
    /* shift-5 path */
    mov.w   @(0x12,r9),r0
    muls.w  r0,r1
    sts     macl,r1
    mov.w   @(0x14,r9),r0
    muls.w  r0,r2
    sts     macl,r2
    add     r2,r1
    mov.w   @(0x16,r9),r0
    exts.w  r0,r0
    shll    r0
    shll    r0
    shll    r0
    shll    r0
    shll    r0                     /* <<5 */
    add     r0,r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1                     /* >>5 */
    rts
    nop

/* ============================================================================
 * rotational_offset_calc — Billboard rotational offsets (cross-product)
 * 68K: $00764E-$0076A2 (84 bytes)
 *
 * Computes lateral (+$72) and longitudinal (+$E2) offsets from entity heading
 * (+$1E) and position deltas (+$20 - +$30, +$22 - +$34) using cos/sin rotation.
 *
 * In:  R8 = entity base pointer (68K A0)
 * Out: writes entity+$72 (word) and entity+$E2 (word)
 *
 * 68K calls:
 *   sine_cosine_quadrant_lookup    ($8F4E, cosine: angle+$4000) -> D4
 *   sine_cosine_quadrant_lookup+4  ($8F52, sine)                 -> D5
 * SH2 uses .pu_sin_lookup (SH2 $02301EDC): pure sine, R4=angle(16-bit unsigned,
 *   masked), R0=Q8 result (±256). cos = .pu_sin_lookup(angle+$4000).
 *   VERIFIED identical Q8 magnitude to the 68K routine (same table, same
 *   quadrant logic) — no scale adjustment needed; 68K ASR.L #8 preserved.
 *
 * .pu_sin_lookup clobbers R4,R5,R7 and preserves R1,R2,R3,R6. We keep the
 * cosine (D4) in R10 and sine (D5) in R11 across the cross-product math, and
 * the entity base (A0) in R8 — none of which the sine routine touches.
 *
 * Clobbers: R0-R7, R10, R11. Stack: PR save (JSR to sine).
 * ============================================================================
 */
.global rotational_offset_calc
rotational_offset_calc:
    sts.l   pr,@-r15

    /* D4 = cos(heading) : sine_cosine_quadrant_lookup($1E) adds $4000 */
    mov.w   @(0x1E,r8),r0        /* heading */
    mov.w   @(.ro_c4000,pc),r4
    add     r4,r0
    extu.w  r0,r4                 /* R4 = (heading + $4000) & $FFFF */
    mov.l   @(.ro_sin_addr,pc),r7
    jsr     @r7
    nop
    mov     r0,r10               /* D4 = cos */

    /* D2 = (target_x - x) * cos   (offsets >= $20 need @(R0,R8) indexed) */
    mov     #0x20,r0
    mov.w   @(r0,r8),r2          /* target_x */
    mov     #0x30,r0
    mov.w   @(r0,r8),r1          /* x_position */
    sub     r1,r2                 /* R2 = tx - x (word delta) */
    exts.w  r2,r2
    mov     r10,r0
    muls.w  r0,r2
    sts     macl,r2               /* D2 = delta_x * cos (32-bit) */

    /* D5 = sin(heading) : sine_cosine_quadrant_lookup+4 (no offset) */
    mov.w   @(0x1E,r8),r0        /* heading */
    extu.w  r0,r4
    mov.l   @(.ro_sin_addr,pc),r7
    jsr     @r7
    nop
    mov     r0,r11               /* D5 = sin */

    /* D3 = (target_y - y) * sin */
    mov     #0x22,r0
    mov.w   @(r0,r8),r3          /* target_y */
    mov     #0x34,r0
    mov.w   @(r0,r8),r1          /* y_position */
    sub     r1,r3
    exts.w  r3,r3
    mov     r11,r0
    muls.w  r0,r3
    sts     macl,r3               /* D3 = delta_y * sin */

    /* D3 = D2 + D3 ; ASR.L #8 ; NEG.W ; store -> +$72 */
    add     r2,r3                 /* add.l d2,d3 */
    shar    r3
    shar    r3
    shar    r3
    shar    r3
    shar    r3
    shar    r3
    shar    r3
    shar    r3                     /* asr.l #8 */
    neg     r3,r3                  /* neg.w d3 (low word negate) */
    mov     #0x72,r0
    mov.w   r3,@(r0,r8)          /* entity+$72 = lateral offset */

    /* === Longitudinal: D2 = (tx-x)*D5 ; D3 = (ty-y)*D4 ; D2-D3 ; ASR.L #8 === */
    mov     #0x20,r0
    mov.w   @(r0,r8),r2
    mov     #0x30,r0
    mov.w   @(r0,r8),r1
    sub     r1,r2
    exts.w  r2,r2
    mov     r11,r0               /* D0 = D5 (sin) */
    muls.w  r0,r2
    sts     macl,r2               /* D2 = delta_x * sin */

    mov     #0x22,r0
    mov.w   @(r0,r8),r3
    mov     #0x34,r0
    mov.w   @(r0,r8),r1
    sub     r1,r3
    exts.w  r3,r3
    mov     r10,r0               /* D0 = D4 (cos) */
    muls.w  r0,r3
    sts     macl,r3               /* D3 = delta_y * cos */

    sub     r3,r2                 /* sub.l d3,d2 */
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2
    shar    r2                     /* asr.l #8 */
    mov     #0xE2,r0
    extu.b  r0,r0                 /* $E2 = 226; build offset in R0 (byte-safe) */
    mov.w   r2,@(r0,r8)          /* entity+$E2 = longitudinal offset */

    lds.l   @r15+,pr
    rts
    nop

.align 1
.ro_c4000:      .short  0x4000
.align 2
.ro_sin_addr:   .long   0x02301EDC     /* .pu_sin_lookup (physics_pos_update) */

.global collision_leaf_end
collision_leaf_end:
