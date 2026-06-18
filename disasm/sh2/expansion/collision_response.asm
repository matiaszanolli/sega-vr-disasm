/*
 * collision_response — SH2 Collision Response + Surface Tracking (VR60 Phase 5D)
 * Expansion ROM Address: $303410 (SH2: $02303410)
 *
 * Ports the top-level collision-response function:
 *   collision_response_surface_tracking  (68K $007700, 412B)
 *
 * Two halves (faithful 1:1 transliteration):
 *   1. BINARY SEARCH (4 iterations). Calls track_boundary_collision_detection
 *      (5C) once; if +$62 <= 0 AND +$55 bit0 set (a collision this frame),
 *      compute 1/4-step deltas (ASR.W #2) of heading(+$40)/scale(+$46)/x(+$30)/
 *      y(+$34) vs prev (+$42/+$48/+$36/+$38); reset to prev; then 4x { add 1/4
 *      step; call track_boundary; if +$55 bit0 set -> revert last step & stop }.
 *      Then snapshot current -> prev.
 *   2. SURFACE TRACKING (EMA). For tiles at entity +$D2 (probe1), +$D6 (probe2),
 *      +$DA (probe3), +$CE (center): call plane_eval_signed; if result > 0,
 *      EMA new = (prev + height) >> 1 (signed long) into +$5A,+$5C,+$5E,+$32.
 *      probe4 (+$DE) is NOT used here. Probe x/y come from COLL_POS scratch.
 *
 * ===========================================================================
 *  ADDITIVE / DEFERRED — NOT WIRED INTO cmd $3F (decision below)
 * ===========================================================================
 *  Like 5A/5B/5C, this is ASSEMBLED + reference-model-verified, NOT dispatched.
 *  The §9.0 "authoritative-copy" open question is UNRESOLVED, and wiring this
 *  live would make SH2 WRITE the SDRAM entity (+$30/$34/$40/$46/$5A/$5C/$5E/$32)
 *  — a behavioral change, not passive observation. Investigation conclusion:
 *
 *    - render_state_patch (render_state_patcher.asm) READS the SDRAM player
 *      entity +$30/$34 (post-physics X/Y, lines 67/78) and the pre-physics
 *      snapshot +$EC/$EE to compute a camera delta it applies to render-state
 *      arrays at $0600CA00/$0600CCA0. So the SDRAM entity position IS the input
 *      that *would* drive the rendered camera — IF those arrays were consumed.
 *    - BUT render_state_patcher is a PROVEN NO-OP (VR60_ROADMAP.md §1250,
 *      2026-06-17): the 3D engine reads context-relative from $06003xxx/
 *      $06004xxx, never $0600CA00/$0600CCA0. Empirically 0% Slave-render change.
 *      => The SH2-authoritative car's position drives NOTHING visible today.
 *      The visible car is still the 68K WRAM entity (68K physics+collision path
 *      runs unchanged; §9.0). So the SH2 car cannot "drive through walls" on
 *      screen — it isn't on screen.
 *    - cmd $3F runs physics + AI but NO collision today; the SDRAM entity gets
 *      zero collision correction. Adding collision live would change +$30/$34 of
 *      an entity nothing reads — harmless to display, but it would also run
 *      track_boundary 5x/frame, which WRITES SDRAM-entity +$55-$59, +$CE/$D2/
 *      $D6/$DA/$DE and SURF_* scratch. Nothing downstream reads those THIS build
 *      (5C is itself deferred; render path ignores them). So no corruption — but
 *      no benefit either, and it interacts with A-1 ($C8D2-gated staging): a
 *      mid-race mode-0 stage can repopulate +$CE.. with 68K-form garbage between
 *      frames, which track_boundary would then dereference. Per the task's
 *      "prefer caution" + 5F-defers-the-question directive, wiring is DEFERRED.
 *
 *  WIRING DECISION: ADDITIVE / DEFERRED (no cmd $3F JSR). Safe-wiring plan for
 *  5F is in findings.md; the precise call site is the same as 5C's: a JSR right
 *  after .phys_f12 in cmd3f_vr60_gameframe.asm (collision_response calls
 *  track_boundary itself, so 5C need not be separately dispatched — 5D is the
 *  entry point for both). Honors A-1 (re-confirm $C8D2 gate), A-3 (never stores
 *  WRAM 68K-form pointers; it only READS the SH2-form +$CE/$D2/$D6/$DA that 5C
 *  already stored, and writes only position/EMA scalars — no pointer writes).
 *
 * ===========================================================================
 *  COLL_POS scratch mapping (5C relocation, RE-VERIFIED here)
 * ===========================================================================
 *  5C moved the 68K probe-position scratch $FFC0D0..$C0E2 to COLL_POS =
 *  $06011030 (.cb_coll_pos in collision_boundary.asm:497). Slot layout:
 *    center x/y = COLL_POS+$00/+$02 ; probe1 = +$04/+$06 ; probe2 = +$08/+$0A ;
 *    probe3 = +$0C/+$0E ; probe4 = +$10/+$12.
 *  68K surface-tracking reads (signed-16 WRAM, RE-COMPUTED, NOT $C09x):
 *    probe1 x/y: (-16172).W=$C0D4 / (-16170).W=$C0D6  -> COLL_POS+$04/+$06
 *    probe2 x/y: (-16168).W=$C0D8 / (-16166).W=$C0DA  -> COLL_POS+$08/+$0A
 *    probe3 x/y: (-16164).W=$C0DC / (-16162).W=$C0DE  -> COLL_POS+$0C/+$0E
 *    center x/y: (-16176).W=$C0D0 / (-16174).W=$C0D2  -> COLL_POS+$00/+$02
 *  (-16176 = 65536-16176 = $C0D0, NOT $C090. Verified arithmetic.)
 *  track_boundary (5C) writes these slots on each probe hit; surface-tracking
 *  reads them back. They are written+consumed within one collision pass.
 *
 * ===========================================================================
 *  ENTITY tile-data pointer fields (SH2-form, stored by 5C)
 * ===========================================================================
 *    +$CE center, +$D2 probe1, +$D6 probe2, +$DA probe3 (all >= $80).
 *  These hold SH2-ready BSP/surface pointers (5B convention: translated once at
 *  formation, never at dereference). Loaded into R9 for plane_eval_signed.
 *
 * ===========================================================================
 *  CALLEE CONTRACTS (verified)
 * ===========================================================================
 *  track_boundary_collision_detection (SH2 $02303250):
 *    In:  GBR/R14 = entity base ; no register params.
 *    Out: entity +$55/$56-$59, +$CE/$D2/$D6/$DA/$DE (SH2-ptrs), SURF_TYPE,
 *         COLL_POS, SURF_CNT.
 *    Clobbers R0-R12. Preserves GBR, R13, R14(save/restore), R15, PR(save/rest).
 *    => the binary-search 1/4-step deltas MUST be stashed across each call. The
 *       68K does MOVEM.L D0-D7,-(A7)/restore; we stash the 4 deltas (heading,
 *       scale, x, y) + the GBR-derived entity base on the STACK (R0-R12 all die;
 *       GBR survives so we re-STC it after each call).
 *
 *  plane_eval_signed (SH2 $02302F3A = collision_leaf $302D00 + offset $23A,
 *    confirmed via sh-elf-nm -n collision_leaf.o):
 *    In:  R1 = x (D1), R2 = y (D2), R9 = tile/plane data ptr (A2 — NOTE R9).
 *    Out: R1 = result.
 *    LEAF (no PR save). Clobbers R0,R1,R2. Preserves R3-R15, GBR, PR, R9.
 *    => R9 (tile ptr) survives, but R2 (y) is consumed. We reload x/y per probe.
 *    NO usable T for the 68K BLE (its final SHAR sets T from a shifted-out bit).
 *    68K `BLE .skip` = skip-if-result<=0. SH2: `cmp/pl r1` (T = R1 > 0) then
 *    `bf .skip` (skip when NOT > 0, i.e. <= 0). EXACT equivalent of BLE.
 *
 * ===========================================================================
 *  REGISTER CONVENTION (VR60 §7.9) + translation notes
 * ===========================================================================
 *   GBR/R14 = entity base ($0600F20C player). R13 = globals base.
 *   Entity field access: offsets < $80 via @(off,GBR) R0-dest, OR
 *     `mov #off,r0; mov.w @(r0,r14),rn` indexed. Offsets >= $80 (+$CE/$D2/$D6/
 *     $DA, +$5A/$5C/$5E) need `extu.b r0,r0` after `mov #imm` (mov sign-extends).
 *     +$32 < $80.
 *   68K ASR.W #2 = signed word /4 -> exts.w then 2x shar (word domain).
 *   68K ASR.L #1 = signed long /2 -> 1x shar.
 *   68K EXT.L Dn = sign-extend word->long -> exts.w.
 *   68K BTST #0,(byte) -> mov.b + and #1 + (T via tst).
 *   All ROM/abs literals are 8 hex digits (no dropped-zero bug).
 *
 *   Binary-search stable locals (only valid BETWEEN track_boundary calls,
 *   re-stashed each call): none survive a call, so we keep all 4 deltas on the
 *   stack frame and re-load them after every track_boundary return.
 *   Stack frame (built once, after the initial-detect early-outs):
 *     [r15+0]=R3 heading-delta, [r15+4]=R4 scale-delta,
 *     [r15+8]=R5 x-delta, [r15+12]=R6 y-delta.   (PR saved below them.)
 */

.section .text
.align 2

/* ============================================================================
 * collision_response_surface_tracking  (68K $007700-$00789C, 412B)
 *
 * In:  GBR/R14 = entity base ($0600F20C)   R13 = globals base
 * Out: entity +$30/$34/$40/$46 (after binary search), +$5A/$5C/$5E/$32 (EMA).
 *      (plus everything track_boundary writes, 5x.)
 * Clobbers: R0-R12. Preserves: GBR, R13, R14(save/restore), R15.
 * ============================================================================
 */
.global collision_response_surface_tracking
collision_response_surface_tracking:
    sts.l   pr,@-r15
    mov.l   r14,@-r15
    stc     gbr,r14                  /* R14 = entity base (stable local) */

    /* === Initial collision detection === ($007700) */
    mov.l   @(.cr_track_boundary,pc),r0
    jsr     @r0                      /* track_boundary_collision_detection */
    nop
    stc     gbr,r14                  /* track_boundary preserves GBR; refresh R14 */

    /* CMPI.W #0,+$62 ; BGT.W .save_current_pos  (collision state > 0 -> skip) */
    mov     #0x62,r0
    mov.w   @(r0,r14),r1
    exts.w  r1,r1
    cmp/pl  r1                       /* T = (+$62 > 0) */
    bt      .cr_save_current_pos

    /* BTST #0,+$55 ; BEQ.W .save_current_pos  (no probe hit -> skip) */
    mov     #0x55,r0
    mov.b   @(r0,r14),r1
    mov     #1,r2
    and     r2,r1
    tst     r1,r1                    /* T = (bit0 == 0) */
    bt      .cr_save_current_pos

    /* === Binary search: compute 1/4-step deltas === ($007718) */
    /* D3 = (heading +$40 - prev +$42) >> 2  (ASR.W #2) */
    mov     #0x40,r0
    mov.w   @(r0,r14),r1
    mov     #0x42,r0
    mov.w   @(r0,r14),r2
    sub     r2,r1
    exts.w  r1,r1
    shar    r1
    shar    r1                       /* R1 = heading delta/4 (word-signed) */
    mov     r1,r3
    /* D4 = (scale +$46 - prev +$48) >> 2 */
    mov     #0x46,r0
    mov.w   @(r0,r14),r1
    mov     #0x48,r0
    mov.w   @(r0,r14),r2
    sub     r2,r1
    exts.w  r1,r1
    shar    r1
    shar    r1
    mov     r1,r4                    /* R4 = scale delta/4 */
    /* D5 = (x +$30 - prev +$36) >> 2 */
    mov     #0x30,r0
    mov.w   @(r0,r14),r1
    mov     #0x36,r0
    mov.w   @(r0,r14),r2
    sub     r2,r1
    exts.w  r1,r1
    shar    r1
    shar    r1
    mov     r1,r5                    /* R5 = x delta/4 */
    /* D6 = (y +$34 - prev +$38) >> 2 */
    mov     #0x34,r0
    mov.w   @(r0,r14),r1
    mov     #0x38,r0
    mov.w   @(r0,r14),r2
    sub     r2,r1
    exts.w  r1,r1
    shar    r1
    shar    r1
    mov     r1,r6                    /* R6 = y delta/4 */

    /* Stash the 4 deltas on the stack (R0-R12 die in track_boundary). */
    mov.l   r6,@-r15                 /* [r15+12] y-delta */
    mov.l   r5,@-r15                 /* [r15+8]  x-delta */
    mov.l   r4,@-r15                 /* [r15+4]  scale-delta */
    mov.l   r3,@-r15                 /* [r15+0]  heading-delta */

    /* --- Reset to previous frame position --- ($007740) */
    /* x(+$30) = prev_x(+$36) */
    mov     #0x36,r0
    mov.w   @(r0,r14),r1
    mov     #0x30,r0
    mov.w   r1,@(r0,r14)
    /* y(+$34) = prev_y(+$38) */
    mov     #0x38,r0
    mov.w   @(r0,r14),r1
    mov     #0x34,r0
    mov.w   r1,@(r0,r14)
    /* heading(+$40) = prev_heading(+$42) */
    mov     #0x42,r0
    mov.w   @(r0,r14),r1
    mov     #0x40,r0
    mov.w   r1,@(r0,r14)
    /* scale(+$46) = prev_scale(+$48) */
    mov     #0x48,r0
    mov.w   @(r0,r14),r1
    mov     #0x46,r0
    mov.w   r1,@(r0,r14)

    /* === 4 iterations: advance 1/4 step, test, revert-on-collision === */
    mov     #4,r12                   /* iteration counter (R12 survives? NO — track_
                                      * boundary clobbers R0-R12. Counter must live
                                      * on the stack too.) */
    mov.l   r12,@-r15                /* [r15+0] iter count ; deltas now at +4..+16 */

.cr_iter:
    /* advance current by 1/4 step: load deltas from stack (+4..+16) */
    mov.l   @(4,r15),r3              /* heading-delta */
    mov.l   @(8,r15),r4              /* scale-delta */
    mov.l   @(12,r15),r5            /* x-delta */
    mov.l   @(16,r15),r6           /* y-delta */
    /* heading(+$40) += R3 */
    mov     #0x40,r0
    mov.w   @(r0,r14),r1
    add     r3,r1
    mov     #0x40,r0
    mov.w   r1,@(r0,r14)
    /* scale(+$46) += R4 */
    mov     #0x46,r0
    mov.w   @(r0,r14),r1
    add     r4,r1
    mov     #0x46,r0
    mov.w   r1,@(r0,r14)
    /* x(+$30) += R5 */
    mov     #0x30,r0
    mov.w   @(r0,r14),r1
    add     r5,r1
    mov     #0x30,r0
    mov.w   r1,@(r0,r14)
    /* y(+$34) += R6 */
    mov     #0x34,r0
    mov.w   @(r0,r14),r1
    add     r6,r1
    mov     #0x34,r0
    mov.w   r1,@(r0,r14)

    /* test boundary (MOVEM.L save/restore mirrored by stack stash) */
    mov.l   @(.cr_track_boundary,pc),r0
    jsr     @r0
    nop
    stc     gbr,r14                  /* refresh entity base */

    /* BTST #0,+$55 ; BNE -> revert & stop */
    mov     #0x55,r0
    mov.b   @(r0,r14),r1
    mov     #1,r2
    and     r2,r1
    tst     r1,r1                    /* T = (bit0 == 0) => no collision */
    bf      .cr_revert_step          /* collision (bit0 set) -> revert last step */

    /* no collision: next iteration */
    mov.l   @r15,r12                 /* iter count */
    dt      r12
    mov.l   r12,@r15
    bf      .cr_iter

    /* all 4 iterations clear -> keep full step (BEQ .save fall-through) */
    bra     .cr_pop_and_save
    nop

.cr_revert_step:                     /* ($0077EA) undo last 1/4 step */
    mov.l   @(4,r15),r3              /* heading-delta */
    mov.l   @(8,r15),r4              /* scale-delta */
    mov.l   @(12,r15),r5           /* x-delta */
    mov.l   @(16,r15),r6          /* y-delta */
    mov     #0x40,r0
    mov.w   @(r0,r14),r1
    sub     r3,r1
    mov     #0x40,r0
    mov.w   r1,@(r0,r14)
    mov     #0x46,r0
    mov.w   @(r0,r14),r1
    sub     r4,r1
    mov     #0x46,r0
    mov.w   r1,@(r0,r14)
    mov     #0x30,r0
    mov.w   @(r0,r14),r1
    sub     r5,r1
    mov     #0x30,r0
    mov.w   r1,@(r0,r14)
    mov     #0x34,r0
    mov.w   @(r0,r14),r1
    sub     r6,r1
    mov     #0x34,r0
    mov.w   r1,@(r0,r14)

.cr_pop_and_save:
    add     #20,r15                  /* pop iter count(4) + 4 deltas(16) */

.cr_save_current_pos:                /* ($0077FA) snapshot current -> prev */
    /* prev_heading(+$42) = heading(+$40) */
    mov     #0x40,r0
    mov.w   @(r0,r14),r1
    mov     #0x42,r0
    mov.w   r1,@(r0,r14)
    /* prev_scale(+$48) = scale(+$46) */
    mov     #0x46,r0
    mov.w   @(r0,r14),r1
    mov     #0x48,r0
    mov.w   r1,@(r0,r14)
    /* prev_x(+$36) = x(+$30) */
    mov     #0x30,r0
    mov.w   @(r0,r14),r1
    mov     #0x36,r0
    mov.w   r1,@(r0,r14)
    /* prev_y(+$38) = y(+$34) */
    mov     #0x34,r0
    mov.w   @(r0,r14),r1
    mov     #0x38,r0
    mov.w   r1,@(r0,r14)
    /* (68K BRA.W .surface_tracking; the jsr at $007818 is DEAD CODE — not ported) */

/* === Surface tracking: EMA height at 4 probe points === ($00781A) */
/* Probe A: tile=+$D2, x/y=COLL_POS+$04/+$06, EMA target +$5A */
.cr_surface:
    mov     #0xD2,r0
    extu.b  r0,r0                    /* +$D2 >= $80 */
    mov.l   @(r0,r14),r9            /* R9 = probe1 tile ptr (SH2-form) */
    mov.l   @(.cr_coll_pos,pc),r2
    mov     #4,r0
    mov.w   @(r0,r2),r1            /* COLL_POS+$04 = probe1 x */
    exts.w  r1,r1
    mov     #6,r0
    mov.w   @(r0,r2),r2           /* COLL_POS+$06 = probe1 y */
    exts.w  r2,r2
    mov.l   @(.cr_plane_eval_signed,pc),r0
    jsr     @r0                      /* R1 = result (R9 tile ptr, R1=x, R2=y) */
    nop
    cmp/pl  r1                       /* T = (result > 0) */
    bf      .cr_skip_a               /* 68K BLE: result <= 0 -> skip */
    /* EMA: new = (prev(+$5A, EXT.L) + height) >> 1 */
    mov     #0x5A,r0
    extu.b  r0,r0
    mov.w   @(r0,r14),r2
    exts.w  r2,r2                    /* EXT.L prev */
    add     r2,r1
    shar    r1                       /* ASR.L #1 */
    mov     #0x5A,r0
    extu.b  r0,r0
    mov.w   r1,@(r0,r14)            /* store smoothed +$5A */
.cr_skip_a:

    /* Probe B: tile=+$D6, x/y=COLL_POS+$08/+$0A, EMA target +$5C */
    mov     #0xD6,r0
    extu.b  r0,r0
    mov.l   @(r0,r14),r9
    mov.l   @(.cr_coll_pos,pc),r2
    mov     #8,r0
    mov.w   @(r0,r2),r1           /* COLL_POS+$08 = probe2 x */
    exts.w  r1,r1
    mov     #0x0A,r0
    mov.w   @(r0,r2),r2          /* COLL_POS+$0A = probe2 y */
    exts.w  r2,r2
    mov.l   @(.cr_plane_eval_signed,pc),r0
    jsr     @r0
    nop
    cmp/pl  r1
    bf      .cr_skip_b
    mov     #0x5C,r0
    extu.b  r0,r0
    mov.w   @(r0,r14),r2
    exts.w  r2,r2
    add     r2,r1
    shar    r1
    mov     #0x5C,r0
    extu.b  r0,r0
    mov.w   r1,@(r0,r14)
.cr_skip_b:

    /* Probe C: tile=+$DA, x/y=COLL_POS+$0C/+$0E, EMA target +$5E */
    mov     #0xDA,r0
    extu.b  r0,r0
    mov.l   @(r0,r14),r9
    mov.l   @(.cr_coll_pos,pc),r2
    mov     #0x0C,r0
    mov.w   @(r0,r2),r1          /* COLL_POS+$0C = probe3 x */
    exts.w  r1,r1
    mov     #0x0E,r0
    mov.w   @(r0,r2),r2         /* COLL_POS+$0E = probe3 y */
    exts.w  r2,r2
    mov.l   @(.cr_plane_eval_signed,pc),r0
    jsr     @r0
    nop
    cmp/pl  r1
    bf      .cr_skip_c
    mov     #0x5E,r0
    extu.b  r0,r0
    mov.w   @(r0,r14),r2
    exts.w  r2,r2
    add     r2,r1
    shar    r1
    mov     #0x5E,r0
    extu.b  r0,r0
    mov.w   r1,@(r0,r14)
.cr_skip_c:

    /* Probe D (center): tile=+$CE, x/y=COLL_POS+$00/+$02, EMA target +$32 */
    mov     #0xCE,r0
    extu.b  r0,r0
    mov.l   @(r0,r14),r9
    mov.l   @(.cr_coll_pos,pc),r2
    mov     #0,r0
    mov.w   @(r0,r2),r1            /* COLL_POS+$00 = center x */
    exts.w  r1,r1
    mov     #2,r0
    mov.w   @(r0,r2),r2          /* COLL_POS+$02 = center y */
    exts.w  r2,r2
    mov.l   @(.cr_plane_eval_signed,pc),r0
    jsr     @r0
    nop
    cmp/pl  r1
    bf      .cr_skip_d
    /* +$32 (=50): too large for mov.w @(disp,Rn) (max 30) -> indexed via R0 */
    mov     #0x32,r0
    mov.w   @(r0,r14),r2
    exts.w  r2,r2
    add     r2,r1
    shar    r1
    mov     #0x32,r0
    mov.w   r1,@(r0,r14)
.cr_skip_d:

    mov.l   @r15+,r14
    lds.l   @r15+,pr
    rts
    nop

.align 2
.cr_track_boundary:     .long   0x02303250     /* track_boundary_collision_detection */
.cr_plane_eval_signed:  .long   0x02302F3A     /* plane_eval_signed (leaf $302D00+$23A) */
.cr_coll_pos:           .long   0x06011030     /* COLL_POS scratch (5C) */

.global collision_response_end
collision_response_end:
