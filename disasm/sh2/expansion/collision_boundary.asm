/*
 * collision_boundary — SH2 Track-Boundary Collision Detection (VR60 Phase 5C)
 * Expansion ROM Address: $303200 (SH2: $02303200)
 *
 * Ports the boundary-detection layer:
 *   object_type_dispatch                 (68K $007A40, 78B) — surface classifier
 *   track_boundary_collision_detection   (68K $00789C, 420B) — center + 4 probes
 *
 * ADDITIVE / DUAL-PATH ONLY. The 68K collision path keeps running unchanged.
 * cmd $3F dispatch of track_boundary is DEFERRED (see "WIRING STATUS" in the
 * findings / roadmap) — these SH2 functions are assembled + reference-model-
 * verified, exactly as 5A/5B were. The 68K globals packer IS extended this phase
 * (globals +$38/+$3A) so index_calc/extract_033 have their inputs when later
 * dispatched; that packer change is inert until cmd $3F calls collision.
 *
 * Inherits the 5B pointer-translation convention VERBATIM (see collision_track_
 * data.asm header §"POINTER-TRANSLATION CONVENTION"): table CONTENTS / $C268 are
 * 68K CPU addrs translated by +$01780000 ONCE at formation, stored SH2-ready;
 * table BASE ptrs ($0200742C/$0200745C) need NO translation. index_calc returns
 * R1 = tile ptr (SH2-ready) and R9 = table base. The pointer stored into the
 * SDRAM entity tile fields (+$CE/$D2/$D6/$DA/$DE) is the SH2-form BSP pointer of
 * the detecting angle_normalize call (Auditor A-3: never store WRAM 68K-form).
 *
 * ===========================================================================
 *  A2 SEMANTICS — the surface pointer 68K stores is angle_normalize's OUTPUT
 * ===========================================================================
 *  68K track_boundary stores register A2 (NOT A1, the input tile ptr) as the
 *  matched surface descriptor: into +$04(A4), entity +$CE/$D2/$D6/$DE, and as
 *  the arg to object_type_dispatch (which reads +$18(A2)). A2 is left behind by
 *  the angle_normalize* routine:
 *    - angle_normalize (+0) / angle_normalize_p24 (+24): set A2 = input_ptr+2 at
 *      .an_bsp_test, then ADVANCE A2 by +$1C per matched plane-group. On a HIT,
 *      A2 = input+2 + $1C×(prior found-groups) — NOT the input tile ptr.
 *    - angle_normalize_alt (+168): A2 = input_ptr, never advanced (single pass).
 *      So for the alt fast-path A2 == its input == the center surface (+$04(A4)).
 *  SH2 port: the leaves maintain A2 in R9 and leave it intact through rts. So the
 *  correct A2 sits in R9 immediately after each anorm jsr. We CAPTURE R9 into the
 *  stable local R11 right after the call (before R9 is reused by the COLL_POS
 *  peek), and store R11. The alt-hit path instead loads R11 from +$04(A4) — the
 *  same value alt's A2 holds. (Bug fixed 2026-06-17: the port had stored R10/R11
 *  = the INPUT tile ptr in 3 of 4 store paths; only alt was already correct.)
 *
 * ===========================================================================
 *  THE object_type_dispatch PUZZLE — RESOLVED (verified vs ROM bytes)
 * ===========================================================================
 *  68K jump table @ file $7A52 (14 longwords; each $0088xxxx = 68K CPU addr,
 *  file = addr-$880000). Decoded from build/vr_rebuild.32x:
 *
 *    idx  target   handler effect
 *     0   $7A8A    MOVEQ #1,D0; RTS                       -> D0=$01
 *     1   $7A8E    MOVEQ #2,D0; RTS                       -> D0=$02
 *     2   $7A92    ADDQ.B #1,$C31A; MOVEQ #4,D0; RTS      -> inc; D0=$04
 *     3   $7A9A    ADDQ.B #1,$C31A; MOVEQ #8,D0; RTS      -> inc; D0=$08
 *     4   $7AAA    MOVEQ #2,D0; RTS                       -> D0=$02
 *   5,6,7 $7AB2    *** DIVU #0,D0 (entity_heading_init) = divide-by-zero TRAP
 *     8   $7AA2    ADDQ.B #1,$C31A; MOVEQ #$10,D0; RTS    -> inc; D0=$10
 *  9..12  $7AB2    *** TRAP (same as 5,6,7)
 *    13   $7AAE    MOVEQ #2,D0; RTS                       -> D0=$02
 *  (nibbles 14,15 index PAST the 14-entry table -> bogus jump target -> crash.)
 *
 *  RESOLUTION. object_type_dispatch's ONLY caller is track_boundary (4 sites;
 *  grep-verified — no other reference in disasm/modules/). Its structurally-
 *  identical twin object_type_dispatch_b (68K $7BE4) maps the SAME default
 *  indices (5,6,7,9,10,11,12) to a clean `MOVEQ #2,D0; RTS` (handler $7C46),
 *  proving the game's DESIGN-INTENT default for unhandled surface nibbles is
 *  D0=$02. Variant A merely ran out of dedicated handler bodies, so its default
 *  index fell onto the next function ($7AB2 = entity_heading_init, first word
 *  DIVU #0) — a latent /0 trap the game never hits because track-boundary
 *  surface tiles only carry the handled nibbles (0,1,2,3,4,8,13). The SH2 has
 *  no 68K DIVU-/0 trap anyway; the faithful+safe port classifies the unhandled
 *  nibbles as D0=$02 (variant-B intent). In dual-path this doubles as a canary.
 *  verify_5c.py: 256 input bytes, 7 DEFINED nibbles, 0 mismatch.
 *
 * ===========================================================================
 *  WRAM -> SDRAM RELOCATION MAP (SH2 can't reach 68K WRAM; ground-rule H-5)
 * ===========================================================================
 *  All intra-frame scratch, written+read within ONE collision pass; placed in
 *  the TRACK_WORK region $06011000+ (AI entities end $06010F00 -> free; grep'd).
 *
 *    68K WRAM       size  meaning                      SH2 SDRAM
 *    -----------    ----  ---------------------------  -----------------------
 *    $C02E..$C044    16   probe x/y offsets (8 words)  $06011000 TRACK_WORK_BUF
 *        (= EXACTLY the 8 words extract_033 writes: buf+$00,$04,$06,$0A,$0C,
 *         $10,$12,$16; $C02E+those == the 8 read addrs $C02E/$C032/$C034/$C038/
 *         $C03A/$C03E/$C040/$C044 — confirmed in verify_5c.py.)
 *    $C319           1    surface type byte            $06011020 SURF_TYPE
 *    $C31A           1    surface counter (inc'd)      $06011021 SURF_CNT
 *    A4 scratch      8    center tile / surface        $06011024 SCRATCH_A4
 *                         (A4)=center tile ptr, +$04=center surface ptr
 *    $C0D0..$C0E2   20    collision x/y per probe      $06011030 COLL_POS (10W)
 *                         consumed by 5D collision_response_surface_tracking;
 *                         relocated (not dropped) so 5D can read it.
 *  (Brief cited $C090..; ROM-verified signed-16 stores (-16176..-16158) resolve
 *   to $C0D0..$C0E2; roadmap §9.0 agrees. Used the verified addresses.)
 *
 *  Entity tile-data pointers (SDRAM entity via GBR/R14, SH2-form):
 *    +$CE center, +$D2 probe1, +$D6 probe2, +$DA probe3, +$DE probe4
 *    (ROM-verified stores $0078D6/$007926/$007976/$0079C6/$007A16.)
 *
 * ===========================================================================
 *  GLOBALS STAGED BY THE 68K PACKER (5B layout — wired in vr60_globals_stage)
 * ===========================================================================
 *    globals +$38 (word) = race_state ($FFC8A0)         — read by index_calc
 *    globals +$3A (long) = $FFC268 PRE-TRANSLATED (+$01780000) — by extract_033
 *  Per A-2, $C268 is scene-init-stable; staged from the live WRAM value each
 *  frame (cheap, always correct). entity +$E4 (alt-table flag) read directly
 *  from the SDRAM entity via GBR (already a field).
 *
 * ===========================================================================
 *  REGISTER CONVENTION (VR60 §7.9) + callee contracts
 * ===========================================================================
 *   GBR/R14 = entity base ($0600F20C)   R13 = globals base ($0600F30C)
 *   R8 = COMM base (clobbered by angle_normalize; cmd $3F reloads it for the
 *        COMM-cleanup epilogue — it already does after the physics JSRs).
 *  Callee contracts (from 5A/5B headers):
 *   index_calc  : in R1=x,R2=y,GBR,R13 ; out R1=tile ptr,R9=table base ;
 *                 clobbers R0,R1,R3,R4,R5,R6,R9 ; PRESERVES R2,R7,R10-R15,GBR,R13,R8,PR.
 *   extract_033 : in R0=seg idx,R13 ; clobbers R0,R1,R2,R3 ; PRESERVES R4-R15,GBR,R13,R8,PR.
 *   angle_normalize/_p24/_alt : in R1=ang1,R2=ang2,R8=BSP ptr ; out R0=hit/miss ;
 *                 clobbers R0-R9 ; PRESERVES R10-R15,GBR,R13,PR.
 *  track_boundary stable locals (survive all callees): R10,R11,R12,R14 + GBR/R13.
 *  Probe x/y are NOT kept in registers across angle calls — they are recomputed
 *  on demand from R14 + TRACK_WORK_BUF (cheap, avoids register pressure).
 *  All ROM/abs literals are 8 hex digits (no dropped-zero bug).
 */

.section .text
.align 2

/* ============================================================================
 * object_type_dispatch  (68K $007A40-$007A8E, 78B)
 *
 * In:  R9 = BSP/surface ptr (reads byte at +$18)
 * Out: R0 = classification ($01/$02/$04/$08/$10)
 *      side effect: SURF_CNT ($06011021) incremented for codes $04/$08/$10
 * Clobbers: R0,R1,R2,R3. Preserves: R9,R10-R15,GBR,R13,R8,PR.
 * ============================================================================
 */
.global object_type_dispatch
object_type_dispatch:
    mov     #0x18,r0
    mov.b   @(r0,r9),r0          /* MOVE.B $18(A2),D0 (disp 24 > 15 -> indexed) */
    mov     #0x0F,r1
    and     r1,r0                 /* nibble */
    cmp/eq  #0,r0
    bt      .ot_ret1
    cmp/eq  #2,r0
    bt      .ot_inc4
    cmp/eq  #3,r0
    bt      .ot_inc8
    cmp/eq  #8,r0
    bt      .ot_inc10
    /* 1,4,13 defined as $02; 5,6,7,9,10,11,12,14,15 trap/oob -> default $02 */
    mov     #0x02,r0
    rts
    nop
.ot_ret1:
    mov     #0x01,r0
    rts
    nop
.ot_inc4:
    bsr     .ot_bump_cnt
    nop
    mov     #0x04,r0
    rts
    nop
.ot_inc8:
    bsr     .ot_bump_cnt
    nop
    mov     #0x08,r0
    rts
    nop
.ot_inc10:
    bsr     .ot_bump_cnt
    nop
    mov     #0x10,r0
    rts
    nop
/* ADDQ.B #1,$C31A -> SURF_CNT byte increment in SDRAM. Clobbers R0,R2,R3. */
.ot_bump_cnt:
    mov.l   @(.cb_surf_cnt,pc),r2
    mov.b   @r2,r3
    add     #1,r3
    rts
    mov.b   r3,@r2               /* [delay slot] store */

.align 2
.cb_surf_cnt:   .long   0x06011021

/* ============================================================================
 * track_boundary_collision_detection  (68K $00789C-$007A40, 420B)
 *
 * In:  GBR = entity base ($0600F20C)   R13 = globals base
 * Out: entity +$55 (combined), +$56/$57/$58/$59 (per-probe flags),
 *      +$CE/$D2/$D6/$DA/$DE (SH2-form ptrs), SURF_TYPE, COLL_POS, SURF_CNT.
 * Clobbers: R0-R12. Preserves: GBR,R13,R14(saved),R15.
 * ============================================================================
 */
.global track_boundary_collision_detection
track_boundary_collision_detection:
    sts.l   pr,@-r15
    mov.l   r14,@-r15
    mov.l   r12,@-r15

    stc     gbr,r14                  /* R14 = entity base (stable) */
    mov.l   @(.cb_scratch_a4,pc),r12 /* R12 = A4 scratch base */

    /* clear SURF_TYPE (MOVE.B #0,$C319) */
    mov.l   @(.cb_surf_type,pc),r0
    mov     #0,r1
    mov.b   r1,@r0

    /* === CENTER PROBE === */
    /* extract_033 input D0 = heading(+$40) + scale(+$46) */
    mov     #0x40,r0
    mov.w   @(r0,r14),r1
    mov     #0x46,r0
    mov.w   @(r0,r14),r2
    add     r2,r1
    mov     r1,r0                    /* R0 = seg index */
    mov.l   @(.cb_extract,pc),r3
    jsr     @r3
    nop

    /* D1=x(+$30), D2=y(+$34); tile = index_calc */
    bsr     .cb_load_center_xy
    nop
    mov.l   @(.cb_index,pc),r3
    jsr     @r3                      /* R1=tile, R9=table base */
    nop
    mov     r1,r10                   /* R10 = center tile ptr (BSP ptr) */
    mov.l   r10,@r12                 /* (A4) = center tile ptr */
    /* angle_normalize(x,y, tile) */
    mov     r10,r8                   /* R8 = BSP ptr = tile */
    bsr     .cb_load_center_xy       /* reload D1/D2 (index_calc clobbered R1) */
    nop
    mov.l   @(.cb_anorm,pc),r3
    jsr     @r3
    nop
    tst     r0,r0
    bf      .cb_center_hit
    /* no center hit: clear (A4) and +$04(A4) */
    mov     #0,r0
    mov.l   r0,@r12
    mov.l   r0,@(4,r12)
    bra     .cb_probe1
    nop
.cb_center_hit:
    /* On a center hit, 68K stores A2 — the pointer angle_normalize ADVANCES and
     * leaves behind (input+2 +$1C×found-groups), NOT the input tile ptr R10.
     * The port keeps that A2 in R9 across the rts; R9 is intact here (only
     * tst/bf intervened since the anorm jsr). Capture it before R0/R9 are reused
     * (the COLL_POS peek below clobbers R9). R11 is a stable local. */
    mov     r9,r11                   /* R11 = A2 (angle_normalize advanced output) */
    mov.l   r11,@(4,r12)             /* +$04(A4) = center surface (= A2) */
    mov     #0xCE,r0
    extu.b  r0,r0                     /* $CE >= $80: mov # sign-extends, mask to byte */
    mov.l   r11,@(r0,r14)            /* entity+$CE = center surface ptr (longword) */
    mov     #0x18,r0
    mov.b   @(r0,r11),r0          /* surface[+$18] (disp 24 -> indexed) */
    mov.l   @(.cb_surf_type,pc),r1
    mov.b   r0,@r1                   /* SURF_TYPE = surface type byte */
    /* COLL_POS center x/y = current x/y */
    bsr     .cb_load_center_xy
    nop
    mov.l   @(.cb_coll_pos,pc),r3
    mov.w   r1,@r3                   /* COLL_POS+$00 = x */
    mov     #2,r0
    mov.w   r2,@(r0,r3)            /* COLL_POS+$02 = y (R0-index store) */

    /* === PROBES 1-4 ===
     * Each: probe_one(x-slot, y-slot, flag-off, tile-field-off, collpos-slot).
     * Args passed in R0-R3 via the .cb_probe_one helper convention:
     *   R4 = x-offset slot, R5 = y-offset slot (into TRACK_WORK_BUF)
     *   R6 = flag offset (entity), R7 = tile-field offset (entity)
     *   R3 = COLL_POS slot offset (added to COLL_POS base)
     */
.cb_probe1:
    mov     #0x00,r4
    mov     #0x04,r5
    mov     #0x56,r6
    mov     #0xD2,r7
    mov     #0x04,r3
    bsr     .cb_probe_one
    nop
.cb_probe2:
    mov     #0x06,r4
    mov     #0x0A,r5
    mov     #0x57,r6
    mov     #0xD6,r7
    mov     #0x08,r3
    bsr     .cb_probe_one
    nop
.cb_probe3:
    mov     #0x0C,r4
    mov     #0x10,r5
    mov     #0x58,r6
    mov     #0xDA,r7
    mov     #0x0C,r3
    bsr     .cb_probe_one
    nop
.cb_probe4:
    mov     #0x12,r4
    mov     #0x16,r5
    mov     #0x59,r6
    mov     #0xDE,r7
    mov     #0x10,r3
    bsr     .cb_probe_one
    nop

.cb_combine:
    /* +$55 = +$56 | +$57 | +$58 | +$59 */
    mov     #0x56,r0
    mov.b   @(r0,r14),r1
    extu.b  r1,r1
    mov     #0x57,r0
    mov.b   @(r0,r14),r2
    extu.b  r2,r2
    or      r2,r1
    mov     #0x58,r0
    mov.b   @(r0,r14),r2
    extu.b  r2,r2
    or      r2,r1
    mov     #0x59,r0
    mov.b   @(r0,r14),r2
    extu.b  r2,r2
    or      r2,r1
    mov     #0x55,r0
    mov.b   r1,@(r0,r14)

    mov.l   @r15+,r12
    mov.l   @r15+,r14
    lds.l   @r15+,pr
    rts
    nop

/* ----------------------------------------------------------------------------
 * .cb_probe_one — one directional probe.
 * In (caller sets, all survive the index_calc since R3-R7 partially clobbered):
 *   R4=x-slot, R5=y-slot, R6=flag-off(entity), R7=tile-field-off(entity),
 *   R3=COLL_POS slot. R12=A4 base, R14=entity, R13=globals.
 * These probe params must survive index_calc (clobbers R0,R1,R3,R4,R5,R6,R9).
 * -> stash the 5 params in stack/R10-R11 before calling index_calc.
 * ---------------------------------------------------------------------------- */
.cb_probe_one:
    sts.l   pr,@-r15
    /* Stash all 5 probe params on the stack: index_calc clobbers R3,R4,R5,R6,R9
     * and angle_normalize clobbers R0-R9 (INCLUDING R7). So NOTHING in R0-R9 is
     * safe across the callees — stash everything we need.
     * Frame (top->down): [sp+0]=R3 collpos, [sp+4]=R4 xslot, [sp+8]=R5 yslot,
     *                     [sp+12]=R6 flagoff, [sp+16]=R7 tilefield. */
    mov.l   r7,@-r15
    mov.l   r6,@-r15
    mov.l   r5,@-r15
    mov.l   r4,@-r15
    mov.l   r3,@-r15

    /* default flag entity[R6] = $01 */
    mov     r6,r0
    mov     #0x01,r1
    mov.b   r1,@(r0,r14)

    /* compute probe D1/D2 = entity x/y + workbuf[xslot/yslot] */
    bsr     .cb_probe_pos            /* uses [sp] xslot/yslot; returns R1,R2 */
    nop
    /* tile = index_calc(D1,D2) */
    mov.l   @(.cb_index,pc),r3
    jsr     @r3                      /* R1=tile, R9=table base */
    nop
    mov     r1,r10                   /* R10 = probe tile ptr */

    /* decide path: center=(A4); same = center!=0 && tile==center */
    mov.l   @r12,r0                  /* center tile ptr */
    tst     r0,r0
    bt      .cb_p_newtile
    cmp/eq  r0,r10
    bf      .cb_p_newtile
    /* --- same tile: fast alt check with center surface (+$04(A4)) --- */
    mov.l   @(4,r12),r8             /* R8 = center surface (BSP ptr) */
    bsr     .cb_probe_pos
    nop
    mov.l   @(.cb_anorm_alt,pc),r3
    jsr     @r3                      /* angle_normalize_alt -> R0 */
    nop
    tst     r0,r0
    bf      .cb_p_alt_hit            /* alt nonzero -> hit */
    /* alt miss: full p24 check with tile ptr */
    mov     r10,r8                   /* R8 = tile ptr */
    bsr     .cb_probe_pos
    nop
    mov.l   @(.cb_anorm_p24,pc),r3
    jsr     @r3                      /* angle_normalize_p24 -> R0 */
    nop
    /* R11 = A2 = angle_normalize_p24's ADVANCED output (R9 on return), NOT the
     * tile ptr. R8=R10=tile was only the INPUT; p24 sets A2=input+2 and advances
     * it +$1C per found plane-group, leaving the matched surface ptr in R9. */
    mov     r9,r11
    bra     .cb_p_result
    nop
.cb_p_alt_hit:
    /* hit via alt; BSP ptr = center surface */
    mov.l   @(4,r12),r11            /* R11 = center surface (the A2 stored) */
    mov     #1,r0                    /* force hit nonzero (alt returned nonzero) */
    bra     .cb_p_result
    nop
.cb_p_newtile:
    /* --- new tile: standard angle_normalize with tile ptr --- */
    mov     r10,r8                   /* R8 = tile ptr */
    bsr     .cb_probe_pos
    nop
    mov.l   @(.cb_anorm,pc),r3
    jsr     @r3                      /* angle_normalize -> R0 */
    nop
    mov     r9,r11                   /* R11 = A2 = angle_normalize advanced output
                                      * (R8=R10=tile is the INPUT; A2 is left in R9
                                      * on return — that is the ptr 68K stores) */
.cb_p_result:
    tst     r0,r0
    bt      .cb_p_done               /* miss -> leave default flag $01, no store */
    /* === collision: store ptr, coll pos, classify === */
    /* entity[tilefield] = R11 (BSP/surface ptr, longword). tilefield ([sp+16])
     * is $D2/$D6/$DA/$DE (>= $80) -> mask to byte ($mov #imm sign-extended). */
    mov.l   @(16,r15),r0            /* tilefield offset */
    extu.b  r0,r0
    mov.l   r11,@(r0,r14)
    /* COLL_POS[R3 slot] = probe x/y. recompute probe pos again. */
    bsr     .cb_probe_pos            /* R1=x, R2=y */
    nop
    mov.l   @(.cb_coll_pos,pc),r4
    mov.l   @r15,r9                  /* peek saved collpos slot ([sp+0]) */
    add     r9,r4                    /* R4 = COLL_POS + slot */
    mov.w   r1,@r4                   /* coll x */
    mov     #2,r0
    mov.w   r2,@(r0,r4)            /* coll y (R0-index store) */
    /* classify: object_type_dispatch(R9=R11 surface) */
    mov     r11,r9                   /* R9 = surface ptr */
    mov.l   @(.cb_otd,pc),r3
    jsr     @r3                      /* R0 = classification */
    nop
    /* store flag entity[R6] = R0. recover R6 (flag off) from stack ([sp+12]) */
    mov.l   @(12,r15),r6
    mov     r0,r1                    /* R1 = classification value */
    mov     r6,r0                    /* R0 = flag offset (index reg) */
    mov.b   r1,@(r0,r14)           /* entity[flagoff] = classification */
.cb_p_done:
    add     #20,r15                  /* pop 5 stashed params (R3,R4,R5,R6,R7) */
    lds.l   @r15+,pr
    rts
    nop

/* ----------------------------------------------------------------------------
 * .cb_probe_pos — compute probe D1/D2 from entity x/y + TRACK_WORK_BUF offsets.
 * Reads x-slot at [sp_outer], y-slot — but those are inside .cb_probe_one's
 * frame. .cb_probe_one pushed (top->down): R3(collpos)[sp+0], R4(xslot)[sp+4],
 * R5(yslot)[sp+8], R6(flagoff)[sp+12], and .cb_probe_pos itself pushes PR.
 * After our own `sts.l pr` the frame is: [sp+0]=PR, [sp+4]=collpos, [sp+8]=xslot,
 * [sp+12]=yslot, [sp+16]=flagoff.
 * Returns R1=D1 (x+xoff, word-signed), R2=D2 (y+yoff). Clobbers R0,R3,R4.
 * ---------------------------------------------------------------------------- */
.cb_probe_pos:
    sts.l   pr,@-r15
    mov.l   @(.cb_workbuf,pc),r3     /* TRACK_WORK_BUF */
    /* D1 = x + buf[xslot] */
    mov     #0x30,r0
    mov.w   @(r0,r14),r1            /* x_pos */
    mov.l   @(8,r15),r0            /* xslot */
    mov.w   @(r0,r3),r4
    exts.w  r4,r4
    add     r4,r1
    exts.w  r1,r1
    /* D2 = y + buf[yslot] */
    mov     #0x34,r0
    mov.w   @(r0,r14),r2            /* y_pos */
    mov.l   @(12,r15),r0           /* yslot */
    mov.w   @(r0,r3),r4
    exts.w  r4,r4
    add     r4,r2
    exts.w  r2,r2
    lds.l   @r15+,pr
    rts
    nop

/* ----------------------------------------------------------------------------
 * .cb_load_center_xy — D1=entity x(+$30), D2=entity y(+$34). R14 = entity.
 * Clobbers R0. Returns R1=x, R2=y.
 * ---------------------------------------------------------------------------- */
.cb_load_center_xy:
    mov     #0x30,r0
    mov.w   @(r0,r14),r1
    mov     #0x34,r0
    rts
    mov.w   @(r0,r14),r2            /* [delay slot] */

.align 2
.cb_scratch_a4:  .long   0x06011024
.cb_surf_type:   .long   0x06011020
.cb_coll_pos:    .long   0x06011030
.cb_workbuf:     .long   0x06011000
.cb_extract:     .long   0x0230317C     /* track_data_extract_033 */
.cb_index:       .long   0x02303100     /* track_data_index_calc */
.cb_anorm:       .long   0x02302D00     /* angle_normalize */
.cb_anorm_p24:   .long   0x02302D18     /* angle_normalize_p24 (+24) */
.cb_anorm_alt:   .long   0x02302E12     /* angle_normalize_alt (+168) */
.cb_otd:         .long   0x02303200     /* object_type_dispatch (this module base) */

.global collision_boundary_end
collision_boundary_end:
