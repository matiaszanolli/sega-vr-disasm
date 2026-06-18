/*
 * collision_object — SH2 Object/Proximity Collision (VR60 Phase 5E)
 * Expansion ROM Address: $303640 (SH2: $02303640)
 *
 * The FINAL additive sub-phase of the Phase 5 collision port. Ports the four
 * entity-vs-entity / proximity functions that operate over the entity TABLE
 * (player + 15 AI), as opposed to the track-boundary layer (5A-5D):
 *
 *   object_collision_detection  (68K $00AF18, 170B) — player vs entity-15
 *   zone_check_inner            (68K $00AE06, 210B) — 2-pass angle/bounds zone
 *   position_separation         (68K $00AFFE,  44B) — push two entities apart
 *   proximity_zone_loop         (68K $00877A, 104B) — 15-entity zone classify
 *
 * ADDITIVE / DEFERRED, exactly like 5A-5D: assembled + reference-model-verified
 * (verify_5e.py, 0 mismatch), NOT dispatched from cmd $3F. The 68K collision
 * path keeps running unchanged. No existing function or the 68K globals packer
 * is modified by 5E (the staged-globals window is already full — see below).
 *
 * Inherits the 5B pointer-translation convention VERBATIM (collision_track_
 * data.asm header): 68K CPU addresses are translated by +$01780000 ONCE at
 * formation and stored SH2-ready; never translated at dereference.
 *
 * ===========================================================================
 *  SDRAM ENTITY-ITERATION CONVENTION (the 5E deliverable, §7.10 deferred this)
 * ===========================================================================
 *  WRAM layout (68K, original):  entity i at $FF9000 + i*$100.
 *    entity 0  = player        = $FF9000
 *    entity i (1..15) = AI/opp  = $FF9100 .. $FF9F00  (stride $100)
 *
 *  VR60 SDRAM layout (verified against the staging code):
 *    player (entity 0)  -> $0600F20C   (cmd $3F .ent_dst; §7.10)
 *    AI entities 1..15  -> $06010000 + (i-1)*$100   (stride $100)
 *
 *  EVIDENCE for the AI mapping (WRAM entity i==1 -> SDRAM $06010000):
 *    disasm/modules/68k/sh2/vr60_ai_entity_stage.asm:26  VR60_AI_STAGE_SRC=$FF9100
 *      header line 6-7: "Copies 3,840 bytes (15 x 256B) of AI entities from WRAM
 *      $FF9100 ... for DREQ transfer to SDRAM $06010000."  The DREQ copies the
 *      15x256B block intact, so WRAM $FF9100 (entity 1) lands at SDRAM $06010000,
 *      and WRAM entity i (i=1..15) <-> SDRAM $06010000 + (i-1)*$100.
 *    cmd3f_vr60_gameframe.asm:361 .ai_ent_base=$06010000, :367 .ai_stride=$0100,
 *      :215 count=15 — the AI physics loop iterates exactly this layout. We reuse
 *      that base+stride+count so object/proximity iterate the SAME SDRAM copies.
 *
 *  Therefore WRAM entity-15 ($FF9F00, i==15) <-> SDRAM $06010E00 (the LAST AI
 *  slot, = $06010000 + 14*$100). This is:
 *    - object_collision_detection's A1 (`lea $FF9F00,A1` -> SH2 $06010E00).
 *    - proximity_zone_loop's 15th/last iteration (it iterates A1 from $FF9100
 *      stride $100 for 15 entities -> SH2 $06010000 stride $100 for 15).
 *  proximity_zone_loop's stride is $100 in BOTH WRAM and SDRAM (confirmed: the
 *  AI entities are a contiguous 256B-stride array in both memories).
 *
 *  How the SH2 port addresses each role:
 *    "player"        : GBR/R14 = $0600F20C (set by the eventual cmd $3F caller).
 *    "entity-15"     : literal $06010E00 (object_collision_detection's A1).
 *    "iterate 15 AI" : base $06010000, stride $100, count 15 (proximity loop).
 *
 * ===========================================================================
 *  $C268 SAME-OR-DIFFERENT FINDING (settled)
 * ===========================================================================
 *  zone_check_inner reads `movea.l ($FFFFC268).w,A2` (its module comment calls
 *  this the "Angle lookup table base"). track_data_extract_033 (5B) ALSO reads
 *  `movea.l ($FFFFC268).w,A1`. There is exactly ONE $FFC268 WRAM longword:
 *    - written ONCE at scene init: scene_camera_init.asm:84
 *        `move.l A1,($FFFFC268).w  ; road_segment_ptr`
 *    - read by track_data_extract_033.asm:23 and zone_check_inner.asm:58/94.
 *  => They are the SAME pointer. zone_check_inner's "angle lookup table" label is
 *     a MISLABEL; it is the road-segment base, identical to 5B/5C's track_seg_base.
 *  => 5E REUSES 5C's pre-translated globals +$3A (the packer already stages
 *     $C268 + $01780000 there — vr60_globals_stage.asm:131-136). zone_check reads
 *     it as an SH2-ready pointer; NO separate relocation or translation in 5E.
 *
 * ===========================================================================
 *  GLOBALS / WRAM RELOCATION (SH2 can't reach 68K WRAM — H-5)
 * ===========================================================================
 *  The 64-byte SDRAM globals block ($0600F30C) is FULL: persistent +$00-$2F
 *  (48B used) and the per-frame-staged window +$30-$3F is entirely consumed
 *  (+$30 reserved, +$34/$36 AI, +$38/$3A/$3E by 5C). There is NO free staged
 *  offset for 5E's read-only scene-stable scalars. So — exactly as 5C placed its
 *  non-staged scratch in the TRACK_WORK region — 5E's globals live in a NEW
 *  dedicated SDRAM block in TRACK_WORK, OBJ_COLL_GLOBALS = $06011050 (free; AI
 *  entities end $06010F00, TRACK_WORK uses $06011000-$06011044, $06011050+ is
 *  unused — grep-verified). These are SCENE-STABLE read-only inputs; the 68K
 *  packer would stage them ONCE at scene transition (NOT per-frame) when 5E is
 *  wired in 5F. 5E does NOT add packer writes now (additive/deferred, and the
 *  staged window is full anyway):
 *
 *    OBJ_COLL_GLOBALS ($06011050), 20 bytes, all words:
 *      +$00  collision_speed_threshold     (68K $FFC8CE)  object_collision
 *      +$02  collision_position_threshold  (68K $FFC8D0)  object_collision
 *      +$04  zone pass1 X-min bound        (68K $FFC8E4)  zone_check pass 1
 *      +$06  zone pass1 Y-max bound        (68K $FFC8E6)
 *      +$08  zone pass1 X-max bound        (68K $FFC8E8)
 *      +$0A  zone pass1 Y-min bound        (68K $FFC8EA)
 *      +$0C  zone pass2 X-min bound        (68K $FFC8EC)  zone_check pass 2
 *      +$0E  zone pass2 X-max bound        (68K $FFC8EE)
 *      +$10  zone pass2 Y-min bound        (68K $FFC8F0)
 *      +$12  zone pass2 Y-max bound        (68K $FFC8F2)
 *
 *  Sound: object_collision writes $B8 to $FFC8A4. Reuse the existing 5D/physics
 *  sound-relay convention — write $B8 to globals +$2C (R13 base); cmd $3F already
 *  relays globals+$2C -> COMM6_HI -> 68K (cmd3f_vr60_gameframe.asm:264-276).
 *
 *  proximity_zone_loop's center x/y + 3 thresholds are CALLER-SUPPLIED REGISTERS
 *  (the 68K reads them from A0+$30/$34 and hardcodes the 3 thresholds). The SH2
 *  entry preserves that param convention: R1=center_x, R2=center_y, R4=close,
 *  R5=near, R6=approach thresholds (the eventual caller supplies them; the 68K
 *  hardcodes close=$0140, near=$02C0, approach=$1000 and derives x/y from A0).
 *
 * ===========================================================================
 *  directional_collision_probe ($7AD6, 214B) — EXCLUDED (dead code)
 * ===========================================================================
 *  NOT ported. grep over disasm/ proves ZERO references: no jsr/bsr, no
 *  jump-table entry, no data pointer resolves to $7AD6 / directional_collision_
 *  probe. (The `dc.w $7AD6` hits in disasm/sections/code_*.asm are coincidental
 *  data/opcode words at file offset $xx7AD6 in mirror copies, surrounded by
 *  unrelated values like $77DC/$78DA — not call targets.) It is dead in this
 *  build; the task scope confirms the exclusion.
 *
 * ===========================================================================
 *  WIRING DECISION: ADDITIVE / DEFERRED (no cmd $3F JSR)
 * ===========================================================================
 *  Consistent with 5C/5D. Per 5D's authoritative-copy finding, the SH2 player
 *  entity drives nothing rendered today (render_state_patch is a proven no-op;
 *  the on-screen car is the 68K WRAM entity). Wiring 5E live would WRITE entity
 *  fields (+$88, +$06, +$02 bit11, +$89 zone bits, +$30/$34 separation, +$C0
 *  zone) on entities nothing downstream reads — no benefit — and would interact
 *  with the A-1 $C8D2 staging hazard (a mid-race mode-0 stage could repopulate
 *  the SDRAM AI entities with stale 68K data between frames). It also needs the
 *  OBJ_COLL_GLOBALS packer + a $06010E00 entity-15 that is actually populated
 *  (the AI loop covers it). So wiring is DEFERRED.
 *
 *  Safe-wiring plan for 5F (documented, NOT done here):
 *    - Stage OBJ_COLL_GLOBALS once at scene transition (NOT per-frame; A-2).
 *    - object_collision_detection: set GBR/R14 = player ($0600F20C) and call it;
 *      it loads A1 = entity-15 ($06010E00) itself. Call site = after .phys_f12
 *      in cmd3f_vr60_gameframe.asm (same site as 5C/5D's plan).
 *    - proximity_zone_loop: call once per relevant entity with R1/R2 = that
 *      entity's x/y and the 3 thresholds; it writes +$C0 across the 15 AI slots.
 *    - Re-confirm the A-1 $C8D2 gate before relying on entity contents; this
 *      writes entity flags, so a stale stage would corrupt collision.
 *    - Route sound via globals+$2C (already relayed). Add an A-4-style canary if
 *      desired before deleting the 68K path (5F switchover).
 *
 * ===========================================================================
 *  REGISTER CONVENTION (VR60 §7.9) + 68K->SH2 translation notes
 * ===========================================================================
 *   GBR/R14 = entity base (player $0600F20C). R13 = globals base ($0600F30C).
 *   Entity field <$80: @(off,GBR) R0-dest, or `mov #off,r0; mov.w @(r0,R14)`.
 *   Entity field >=$80 (+$88,+$89,+$8C,+$C0): `mov #imm,r0; extu.b r0,r0` then
 *     indexed (mov # sign-extends so the byte offset must be masked).
 *   68K ASR.W #n (signed word /2^n) -> exts.w Rn,Rn then n x shar.
 *   68K NEG.W Dn (word negate)      -> neg Rn,Rn then exts.w Rn,Rn. The exts.w
 *     is MANDATORY: SH2 `neg` is a 32-bit op, so -$8000 (word) negates to +$8000
 *     (32-bit), which would flip the following cmp/ge|cmp/gt. The 68K neg.w keeps
 *     -$8000 -> -$8000. (Finding B fix: both abs sites in object_collision now
 *     re-truncate; proximity_zone_loop already did.)
 *   68K EXT.W Dn (sign byte->word)  -> exts.b Rn,Rn.
 *   68K EXG D1,D2 (swap)            -> via a temp register (R0/R3).
 *   68K BSET Dn,$89(Ax) (bit set in a BYTE in memory) -> read byte, OR with
 *     (1<<Dn) built via `mov #1,rm; shld rDn,rm` (SHLD = shift-left by Rn>=0),
 *     write back. SH2 has no BSET-to-memory.
 *   68K ORI.W #$0800,$0002(Ax) -> read word (+$02), or #$0800 (built in reg),
 *     write back. SH2 has no ORI-to-memory.
 *   68K `lea zone_check_data(pc),A2` (pass 2 only) is NOT a mask-table load for the
 *     bset (the bit number is computed as 1<<(3-cnt)). It REASSIGNS the loop's READ
 *     pointer: after the first in-bounds hit, subsequent iterations read byte pairs
 *     from zone_check_data + k*$800, NOT the angle table. The SH2 port replicates
 *     this via .zc_zb_bytes + an R12 mode flag (Finding A fix). See zone_check_inner.
 *   All ROM/abs literals are 8 hex digits (no dropped-zero 0x020xxxxx bug).
 *
 * ===========================================================================
 *  FINDINGS A & B FIDELITY FIXES (Phase 5E bug-fix pass; verify_5e.py has teeth)
 * ===========================================================================
 *  A) zone_check_inner pass 2: the 68K `lea zone_check_data(pc),A2` (on every
 *     in-bounds hit) clobbers the READ pointer, so post-hit iterations read
 *     zone_check_data + k*$800 (k=1,2,3). Those original-ROM bytes (verified vs
 *     "Virtua Racing Deluxe (USA).32x"): +$800={$00,$FF}, +$1000={$00,$10},
 *     +$1800={$00,$03}. Replicated VERBATIM in .zc_zb_bytes; R12=0 means angle
 *     mode, R12!=0 means ZB mode (set on hit, +2 per non-hit iter). Pass 1 has NO
 *     such lea and stays on the angle table for all 4 iterations. Now bit-exact.
 *  B) object_collision_detection: the two abs computations (`neg`) now follow with
 *     `exts.w` so -$8000 stays -$8000 (68K neg.w word semantics), matching
 *     proximity_zone_loop. See NEG.W note above.
 */

.section .text
.align 2

/* ============================================================================
 * object_collision_detection  (68K $00AF18-$00AFC2, 170B)
 *
 * Player ($0600F20C via GBR/R14) vs entity-15 ($06010E00 = A1). Sums velocities;
 * if zero, distance/zone check; on hit triggers sound $B8 + weighted-avg speeds
 * (3/4 & 3/8 of sum, clamp $04DC, faster object gets higher) + collision flag
 * bit11 in +$02 if velocity gap exceeds threshold.
 *
 * In:  GBR/R14 = player entity ($0600F20C)   R13 = globals base
 * Out: writes player & entity-15 +$88(clear), +$06(opp speed), +$02(bit11),
 *      sound globals+$2C.
 * Clobbers: R0-R7,R10,R11. Preserves: GBR,R13,R14(save/restore),R15,PR.
 *
 * 68K field map: +$02 flags, +$04 velocity, +$06 speed, +$32 lateral_offset,
 *   +$6A accel_x, +$88 collision_result, +$8C velocity_x.
 * ============================================================================
 */
.global object_collision_detection
object_collision_detection:
    sts.l   pr,@-r15
    mov.l   r14,@-r15
    mov.l   r11,@-r15
    mov.l   r10,@-r15

    stc     gbr,r14                  /* R14 = player (A0) */
    mov.l   @(.co_ent15,pc),r11      /* R11 = entity-15 (A1) = $06010E00 */

    /* clear collision_result +$88 on both (>= $80 -> extu.b offset) */
    mov     #0x88,r0
    extu.b  r0,r0
    mov     #0,r1
    mov.w   r1,@(r0,r14)             /* player +$88 = 0 */
    mov     #0x88,r0
    extu.b  r0,r0
    mov.w   r1,@(r0,r11)             /* entity-15 +$88 = 0 */

    /* --- sum velocities + lateral motion: D0 = A0.6A+A1.6A+A0.8C+A1.8C --- */
    mov     #0x6A,r0
    mov.w   @(r0,r14),r1             /* player accel_x (+$6A) */
    mov     #0x6A,r0
    mov.w   @(r0,r11),r2             /* opp accel_x */
    add     r2,r1
    mov     #0x8C,r0
    extu.b  r0,r0
    mov.w   @(r0,r14),r2             /* player velocity_x (+$8C) */
    add     r2,r1
    mov     #0x8C,r0
    extu.b  r0,r0
    mov.w   @(r0,r11),r2            /* opp velocity_x */
    add     r2,r1
    extu.w  r1,r1                    /* word compare for bne.w */
    tst     r1,r1                    /* T = (sum == 0) */
    bf      .co_no_collision         /* nonzero -> already active, skip */

    /* --- distance check: D0 = |A1.32 - A0.32| ; if >= $200 skip --- */
    mov     #0x32,r0
    mov.w   @(r0,r11),r1            /* opp lateral_offset (+$32) */
    mov     #0x32,r0
    mov.w   @(r0,r14),r2            /* player +$32 */
    sub     r2,r1                    /* D0 = opp - player */
    exts.w  r1,r1
    cmp/pz  r1                       /* T = (>=0) bpl.s */
    bt      .co_dist_pos
    neg     r1,r1                    /* abs */
    exts.w  r1,r1                    /* 68K neg.w truncates to word; re-truncate (-$8000 stays -$8000) */
.co_dist_pos:
    mov.w   @(.co_c0200,pc),r2       /* $0200 */
    exts.w  r2,r2
    cmp/ge  r2,r1                    /* T = (D0 >= $200) -> bge skip */
    bt      .co_no_collision

    /* --- proximity/zone check: zone_check_inner(A0,A1) -> R0 (D0) --- */
    /* zone_check_inner uses GBR=A0, R11=A1 explicitly. beq.w means R0==0 skip. */
    mov.l   @(.co_zone_check,pc),r0
    jsr     @r0                      /* R0 = A0 zone bits */
    nop
    extu.b  r0,r0
    tst     r0,r0                    /* T = (zone bits == 0) */
    bt      .co_no_collision         /* beq.w .no_collision */

    /* --- collision detected: sound $B8 -> globals +$2C --- */
    mov     #0x2C,r0
    mov     #0xB8,r1                 /* $B8 */
    mov.b   r1,@(r0,r13)             /* globals[+$2C] = $B8 */

    /* --- speed comparison: D0 = |A0.04 - A1.04| ; if <= thr -> separation --- */
    mov     #0x04,r0
    mov.w   @(r0,r14),r1            /* player velocity (+$04) */
    mov     #0x04,r0
    mov.w   @(r0,r11),r2           /* opp velocity */
    sub     r2,r1
    exts.w  r1,r1
    cmp/pz  r1
    bt      .co_diff_pos
    neg     r1,r1
    exts.w  r1,r1                    /* 68K neg.w truncates to word; re-truncate (-$8000 stays -$8000) */
.co_diff_pos:
    /* cmp.w collision_speed_threshold,D0 ; ble.w position_separation */
    mov.l   @(.co_obj_globals,pc),r2
    mov.w   @r2,r0                  /* OBJ_COLL_GLOBALS+$00 speed thr */
    exts.w  r0,r0
    cmp/gt  r0,r1                    /* T = (D0 > thr) */
    bt      .co_weighted             /* D0 > thr -> compute speeds */
    /* D0 <= thr -> tail-call position_separation(A0=GBR, A1=$06010E00) */
    mov.l   @(.co_pos_sep,pc),r0
    jsr     @r0                      /* position_separation uses GBR + .ps_ent15 */
    nop
    bra     .co_no_collision         /* (position_separation returns; then rts) */
    nop

.co_weighted:
    /* D0 = A0.06 + A1.06 ; D2 = D0>>1 + D0>>2 (3/4) ; D1 = D0>>2 then >>1 + (3/8) */
    mov     #0x06,r0
    mov.w   @(r0,r14),r1           /* player speed (+$06) */
    mov     #0x06,r0
    mov.w   @(r0,r11),r2          /* opp speed */
    add     r2,r1                   /* R1 = sum (D0) */
    exts.w  r1,r1
    /* D2 = sum>>1 ; D0 = sum>>2 ; D2 += D0  (= 3/4 sum) */
    mov     r1,r2
    shar    r2                       /* D2 = sum/2 */
    mov     r1,r0
    shar    r0
    shar    r0                       /* D0 = sum/4 */
    add     r0,r2                    /* D2 = 3/4 sum */
    /* D1 = D0 ; D1 >>= 1 (= sum/8) ; D1 += D0 (= 3/8 sum) */
    mov     r0,r1
    shar    r1                       /* D1 = sum/8 */
    add     r0,r1                    /* D1 = 3/8 sum */

    /* clamp D1, D2 to $04DC (signed ble.s) */
    mov.w   @(.co_c04dc,pc),r3       /* $04DC */
    exts.w  r3,r3
    cmp/gt  r3,r1                    /* T = (D1 > $04DC) */
    bf      .co_d1_ok
    mov     r3,r1
.co_d1_ok:
    cmp/gt  r3,r2                    /* T = (D2 > $04DC) */
    bf      .co_d2_ok
    mov     r3,r2
.co_d2_ok:
    /* assign: if opp.06 > player.06 swap D1,D2 (exg) else keep */
    mov     #0x06,r0
    mov.w   @(r0,r11),r3          /* opp speed */
    exts.w  r3,r3
    mov     #0x06,r0
    mov.w   @(r0,r14),r0         /* player speed */
    exts.w  r0,r0
    cmp/gt  r0,r3                    /* T = (opp > player) -> ble.s else: ble means <= -> assign w/o swap */
    bf      .co_assign               /* opp <= player -> no swap */
    /* exg d1,d2 via temp */
    mov     r1,r0
    mov     r2,r1
    mov     r0,r2
.co_assign:
    /* opponent gets D2: A1.06 = D2 */
    mov     #0x06,r0
    mov.w   r2,@(r0,r11)

    /* --- collision flags if velocity gap large: D3 = A0.04 - A1.04 --- */
    mov     #0x04,r0
    mov.w   @(r0,r14),r1
    mov     #0x04,r0
    mov.w   @(r0,r11),r2
    sub     r2,r1                    /* D3 = player - opp */
    exts.w  r1,r1
    mov.l   @(.co_obj_globals,pc),r2
    mov     #2,r0
    mov.w   @(r0,r2),r0            /* OBJ_COLL_GLOBALS+$02 position thr */
    exts.w  r0,r0
    cmp/gt  r0,r1                    /* T = (D3 > thr) -> ble means <= skip */
    bf      .co_no_collision         /* D3 <= thr -> close_position_flags (skip) */
    /* ori.w #$0800,+$02 on both (read-modify-write word) */
    mov     #0x02,r0
    mov.w   @(r0,r14),r1
    mov.w   @(.co_c0800,pc),r2       /* $0800 */
    or      r2,r1
    mov     #0x02,r0
    mov.w   r1,@(r0,r14)             /* player +$02 |= $0800 */
    mov     #0x02,r0
    mov.w   @(r0,r11),r1
    or      r2,r1
    mov     #0x02,r0
    mov.w   r1,@(r0,r11)            /* entity-15 +$02 |= $0800 */

.co_no_collision:
    mov.l   @r15+,r10
    mov.l   @r15+,r11
    mov.l   @r15+,r14
    lds.l   @r15+,pr
    rts
    nop

.align 1
.co_c0200:  .short  0x0200
.co_c04dc:  .short  0x04DC
.co_c0800:  .short  0x0800
.align 2
.co_ent15:        .long   0x06010E00     /* WRAM $FF9F00 -> SDRAM entity-15 */
.co_obj_globals:  .long   0x06011050     /* OBJ_COLL_GLOBALS (thresholds + bounds) */
.co_zone_check:   .long   0x023037C4     /* zone_check_inner (module base $303640 + $184) */
.co_pos_sep:      .long   0x02303768     /* position_separation (module base + $128) */

/* ============================================================================
 * position_separation  (68K $00AFFE-$00B02A, 44B)
 *
 * Push player (A0=GBR/R14) and entity-15 (A1=$06010E00) apart by 16 on X(+$30)
 * and Y(+$34). Direction by which has the larger coordinate.
 *
 * In:  GBR/R14 = player ($0600F20C). (A1 = $06010E00 loaded internally.)
 * Out: player & entity-15 +$30/+$34 adjusted.
 * Clobbers: R0,R1,R2,R3,R10. Preserves GBR,R13,R14? — uses R14 as A0, R10 as A1.
 *   This is also the BLE.W tail target of object_collision; it must work with
 *   GBR=player set, so it derives A0 from GBR and A1 from the literal.
 * ============================================================================
 */
.global position_separation
position_separation:
    stc     gbr,r14                  /* R14 = A0 = player */
    mov.l   @(.ps_ent15,pc),r10      /* R10 = A1 = entity-15 */

    /* --- X axis: d1 = +16 if A0.30 > A1.30 else -16 --- */
    mov     #0x30,r0
    mov.w   @(r0,r14),r1            /* X_a (+$30) */
    exts.w  r1,r1
    mov     #0x30,r0
    mov.w   @(r0,r10),r2           /* X_b */
    exts.w  r2,r2
    mov     #0x10,r3                 /* push = 16 */
    cmp/gt  r2,r1                    /* T = (X_a > X_b) bgt.s */
    bt      .ps_xp
    neg     r3,r3                    /* reverse */
.ps_xp:
    /* A0.30 += d1 ; A1.30 -= d1 */
    mov     #0x30,r0
    mov.w   @(r0,r14),r1
    add     r3,r1
    mov     #0x30,r0
    mov.w   r1,@(r0,r14)
    mov     #0x30,r0
    mov.w   @(r0,r10),r1
    sub     r3,r1
    mov     #0x30,r0
    mov.w   r1,@(r0,r10)

    /* --- Y axis: d1 = +16 if A0.34 > A1.34 else -16 --- */
    mov     #0x34,r0
    mov.w   @(r0,r14),r1            /* Y_a (+$34) */
    exts.w  r1,r1
    mov     #0x34,r0
    mov.w   @(r0,r10),r2
    exts.w  r2,r2
    mov     #0x10,r3
    cmp/gt  r2,r1                    /* T = (Y_a > Y_b) */
    bt      .ps_yp
    neg     r3,r3
.ps_yp:
    mov     #0x34,r0
    mov.w   @(r0,r14),r1
    add     r3,r1
    mov     #0x34,r0
    mov.w   r1,@(r0,r14)
    mov     #0x34,r0
    mov.w   @(r0,r10),r1
    sub     r3,r1
    mov     #0x34,r0
    mov.w   r1,@(r0,r10)
    rts
    nop

.align 2
.ps_ent15:  .long   0x06010E00

/* ============================================================================
 * zone_check_inner  (68K $00AE06-$00AED6, 210B)
 *
 * 2-pass angle/bounds zone test. Pass 1: angle A1->A0, set bits in A0+$89.
 * Pass 2: angle A0->A1, set bits in A1+$89. Both index a 2KB-stride angle table
 * ($C268 base, now globals +$3A pre-translated). Bounds from OBJ_COLL_GLOBALS.
 *
 * In:  GBR/R14 = A0 = player ($0600F20C). R11 = A1 = entity-15 (set by caller
 *      object_collision_detection). R13 = globals base.
 * Out: A0+$89, A1+$89 zone bits ; R0 = A0+$89 (return value, the 68K D0).
 * Clobbers: R0-R7. Preserves R8-R15,GBR,R13,PR (saves PR; uses R14=A0,R11=A1).
 *
 * NOTE on A1: object_collision passes A1 in R11 (it set R11=$06010E00). To stay
 * robust standalone, zone_check loads A1 from the same .zc_ent15 literal if
 * called directly. We use R11 as A1 — object_collision keeps R11 across the JSR
 * (it saved R11) so the contract is: A0=GBR/R14, A1=R11. The center-offset and
 * table math match the 68K exactly.
 *
 * 68K: asr.w #5 (table index), addi $0800, andi $07FE; per-pass 4-zone loop
 *   reading byte pairs from the table, bounds-checking, bset zone bit.
 * ============================================================================
 */
.global zone_check_inner
zone_check_inner:
    sts.l   pr,@-r15
    mov.l   r8,@-r15
    mov.l   r9,@-r15
    mov.l   r12,@-r15                /* pass-2 ZB-clobber read pointer (caller uses R12) */

    /* A0 = R14 (GBR), A1 = R11 (caller-supplied). Keep A1 in R8 (stable). */
    stc     gbr,r14
    mov     r11,r8                   /* R8 = A1 = entity-15 */

    mov.l   @(.zc_obj_globals,pc),r9 /* R9 = OBJ_COLL_GLOBALS (bounds base) */

    /* ===== PASS 1: angle A1->A0, set A0+$89 ===== */
    /* D0 = (A1.3C - A0.40) asr 5 ; +$0800 ; & $07FE */
    mov     #0x3C,r0
    mov.w   @(r0,r8),r1            /* A1 facing angle (+$3C) */
    mov     #0x40,r0
    mov.w   @(r0,r14),r2          /* A0 angle B (+$40) */
    sub     r2,r1
    exts.w  r1,r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1                       /* asr.w #5 */
    mov.w   @(.zc_c0800,pc),r0
    add     r0,r1                    /* addi.w #$0800 */
    mov.w   @(.zc_c07fe,pc),r0
    and     r0,r1                    /* andi.w #$07FE -> even index, R1 = table idx */
    extu.w  r1,r1
    /* D3 = A0.30 - A1.30 ; D4 = A0.34 - A1.34 */
    mov     #0x30,r0
    mov.w   @(r0,r14),r2          /* A0.X */
    mov     #0x30,r0
    mov.w   @(r0,r8),r3           /* A1.X */
    sub     r3,r2
    exts.w  r2,r2                    /* R2 = D3 = Xdiff */
    mov     #0x34,r0
    mov.w   @(r0,r14),r3          /* A0.Y */
    mov     #0x34,r0
    mov.w   @(r0,r8),r0           /* A1.Y */
    sub     r0,r3
    exts.w  r3,r3                    /* R3 = D4 = Ydiff */
    /* A2 = $C268_base (globals +$3A, pre-translated) + index */
    mov     #0x3A,r0
    mov.l   @(r0,r13),r4          /* R4 = track/angle table base (SH2-form) */
    add     r1,r4                    /* A2 = base + index (R4 advances each zone) */

    /* 4-zone loop (d2 = 3 downto 0). R5 = counter. */
    mov     #3,r5
.zc_loop1:
    /* D6 = (byte (A2)) + D3 -> R6 ; D7 = (byte +1(A2)) + D4 -> R7 */
    mov.b   @r4,r0                 /* X offset byte */
    exts.b  r0,r0
    add     r2,r0
    exts.w  r0,r0
    mov     r0,r6                    /* R6 = D6 */
    mov.b   @(1,r4),r0           /* Y offset byte (+$01) */
    exts.b  r0,r0
    add     r3,r0
    exts.w  r0,r0
    mov     r0,r7                    /* R7 = D7 */
    /* bounds: pass1 X-min(+$04) Xmax(+$08) Ymin(+$0A) Ymax(+$06).
     * mov.w @(disp,Rn),R0 (R0-dest only); compare against D6(R6)/D7(R7). */
    mov.w   @(4,r9),r0           /* X min */
    exts.w  r0,r0
    cmp/ge  r0,r6                    /* T = (D6 >= Xmin) ; blt skip = !(>=) */
    bf      .zc_skip1
    mov.w   @(8,r9),r0           /* X max */
    exts.w  r0,r0
    cmp/gt  r0,r6                    /* T = (D6 > Xmax) bgt skip */
    bt      .zc_skip1
    mov.w   @(10,r9),r0          /* Y min */
    exts.w  r0,r0
    cmp/ge  r0,r7                    /* blt skip */
    bf      .zc_skip1
    mov.w   @(6,r9),r0           /* Y max */
    exts.w  r0,r0
    cmp/gt  r0,r7                    /* bgt skip */
    bt      .zc_skip1
    /* in zone: zone = 3 - counter (R5) ; set bit (1<<zone) in A0+$89.
     * SH2 has no SHLD (SH3+) — build 1<<zone with a shift loop (zone in 0..3). */
    mov     #3,r0
    sub     r5,r0                    /* R0 = zone index (0..3) */
    mov     #1,r1                    /* R1 = mask = 1 */
.zc_shl1:
    tst     r0,r0
    bt      .zc_shl1_done
    shll    r1
    dt      r0
    bra     .zc_shl1
    nop
.zc_shl1_done:
    mov     #0x89,r0
    extu.b  r0,r0
    mov.b   @(r0,r14),r6         /* A0+$89 byte */
    extu.b  r6,r6
    or      r1,r6
    mov     #0x89,r0
    extu.b  r0,r0
    mov.b   r6,@(r0,r14)         /* A0+$89 |= (1<<zone) */
.zc_skip1:
    mov.w   @(.zc_c0800,pc),r0
    add     r0,r4                    /* A2 += $0800 (next 2KB segment) */
    dt      r5
    bf      .zc_loop1

    /* ===== PASS 2: angle A0->A1, set A1+$89 ===== */
    mov     #0x3C,r0
    mov.w   @(r0,r14),r1         /* A0 facing angle (+$3C) */
    mov     #0x3C,r0
    mov.w   @(r0,r8),r2          /* A1 facing angle (+$3C) */
    sub     r2,r1
    exts.w  r1,r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1
    shar    r1                       /* asr.w #5 */
    mov.w   @(.zc_c0800,pc),r0
    add     r0,r1
    mov.w   @(.zc_c07fe,pc),r0
    and     r0,r1
    extu.w  r1,r1
    /* D3 = A1.30 - A0.30 ; D4 = A1.34 - A0.34 */
    mov     #0x30,r0
    mov.w   @(r0,r8),r2          /* A1.X */
    mov     #0x30,r0
    mov.w   @(r0,r14),r3         /* A0.X */
    sub     r3,r2
    exts.w  r2,r2
    mov     #0x34,r0
    mov.w   @(r0,r8),r3          /* A1.Y */
    mov     #0x34,r0
    mov.w   @(r0,r14),r0         /* A0.Y */
    sub     r0,r3
    exts.w  r3,r3
    /* A2 = $C268 base + index */
    mov     #0x3A,r0
    mov.l   @(r0,r13),r4
    add     r1,r4

    mov     #3,r5
    mov     #0,r12                   /* R12 = pass-2 read pointer: 0 = angle table (R4);
                                      *  nonzero = .zc_zb_bytes addr (post-hit ZB clobber) */
.zc_loop2:
    /* 68K pass 2 reassigns A2 = zone_check_data on EVERY in-bounds hit (lea before
     * bset), then .skip2 advances +$800. So AFTER the first hit, reads come from
     * zone_check_data + k*$800 (the mask-table region), NOT the angle table. R12==0
     * means "not yet switched" -> read angle table via R4; R12!=0 means read the
     * replicated ZB bytes at R12 (= what the 68K reads at zone_check_data+k*$800). */
    tst     r12,r12
    bf      .zc_l2_zbread            /* R12 != 0 -> read from ZB clobber table */
    mov.b   @r4,r0                   /* angle-table X offset */
    bra     .zc_l2_xdone
    nop
.zc_l2_zbread:
    mov.b   @r12,r0                  /* ZB-clobber X offset (zone_check_data+k*$800) */
.zc_l2_xdone:
    exts.b  r0,r0
    add     r2,r0
    exts.w  r0,r0
    mov     r0,r6                    /* R6 = D6 */
    tst     r12,r12
    bf      .zc_l2_zbread2
    mov.b   @(1,r4),r0              /* angle-table Y offset */
    bra     .zc_l2_ydone
    nop
.zc_l2_zbread2:
    mov.b   @(1,r12),r0            /* ZB-clobber Y offset */
.zc_l2_ydone:
    exts.b  r0,r0
    add     r3,r0
    exts.w  r0,r0
    mov     r0,r7                    /* R7 = D7 */
    /* bounds: pass2 Xmin(+$0C) Xmax(+$0E) Ymin(+$10) Ymax(+$12) (all <=30, even) */
    mov.w   @(12,r9),r0
    exts.w  r0,r0
    cmp/ge  r0,r6
    bf      .zc_skip2
    mov.w   @(14,r9),r0
    exts.w  r0,r0
    cmp/gt  r0,r6
    bt      .zc_skip2
    mov.w   @(16,r9),r0          /* Y min (+$10) */
    exts.w  r0,r0
    cmp/ge  r0,r7
    bf      .zc_skip2
    mov.w   @(18,r9),r0          /* Y max (+$12) */
    exts.w  r0,r0
    cmp/gt  r0,r7
    bt      .zc_skip2
    /* in zone: set bit (1<<zone) in A1+$89. The bset bit NUMBER is 1<<(3-cnt),
     * same as pass 1 — that part was always correct. THE FIX: the 68K's
     * `lea zone_check_data(pc),A2` also reassigns the READ pointer for the NEXT
     * iteration, so we switch R12 to the ZB-clobber table here and skip the R4
     * advance (the 68K's +$800 from zone_check_data is folded into pointing R12
     * at the first ZB pair = zone_check_data+$800). */
    mov     #3,r0
    sub     r5,r0
    mov     #1,r1
.zc_shl2:
    tst     r0,r0
    bt      .zc_shl2_done
    shll    r1
    dt      r0
    bra     .zc_shl2
    nop
.zc_shl2_done:
    mov     #0x89,r0
    extu.b  r0,r0
    mov.b   @(r0,r8),r6
    extu.b  r6,r6
    or      r1,r6
    mov     #0x89,r0
    extu.b  r0,r0
    mov.b   r6,@(r0,r8)          /* A1+$89 |= (1<<zone) */
    /* switch to ZB-clobber table (= zone_check_data+$800 onward); skip R4 advance.
     * mova is PC-relative (position-independent) so no fragile absolute self-addr. */
    mova    .zc_zb_bytes,r0
    mov     r0,r12                   /* R12 = &.zc_zb_bytes (next read = ZB+$800) */
    dt      r5
    bf      .zc_loop2
    bra     .zc_l2_end
    nop
.zc_skip2:
    /* no hit this iteration: advance the active pointer by $800 (68K .skip2) */
    tst     r12,r12
    bf      .zc_skip2_zb
    mov.w   @(.zc_c0800,pc),r0
    add     r0,r4                    /* angle mode: A2 += $800 */
    bra     .zc_skip2_adv
    nop
.zc_skip2_zb:
    add     #2,r12                   /* ZB mode: advance one byte-pair (= +$800 in 68K) */
.zc_skip2_adv:
    dt      r5
    bf      .zc_loop2
.zc_l2_end:

    /* return D0 = A0+$89 */
    mov     #0x89,r0
    extu.b  r0,r0
    mov.b   @(r0,r14),r0
    extu.b  r0,r0                    /* R0 = A0 zone bits */

    mov.l   @r15+,r12
    mov.l   @r15+,r9
    mov.l   @r15+,r8
    lds.l   @r15+,pr
    rts
    nop

.align 1
.zc_c0800:  .short  0x0800
.zc_c07fe:  .short  0x07FE
/* zone_check_data (68K $00AE06): big-endian bytes {$01,$02,$04,$08}. The bset bit
 * NUMBER is computed as 1<<(3-cnt) (the shift loop) — this table's bytes are NOT
 * indexed for the bit number. .co_zone_mask is kept for documentation only. */
.align 1
.co_zone_mask:  .short  0x0102, 0x0408   /* bytes $01,$02,$04,$08 (masks 0-3; doc only) */
/* ZB-CLOBBER TABLE (Finding A fix): the 68K `lea zone_check_data(pc),A2` in pass 2
 * reassigns the READ pointer; after the first in-bounds hit, subsequent iterations
 * read byte pairs from zone_check_data + k*$800 (k=1,2,3 are the only reachable
 * offsets). Those ROM bytes in the ORIGINAL game are, verified against
 * "Virtua Racing Deluxe (USA).32x": $00AE06+$800={$00,$FF}, +$1000={$00,$10},
 * +$1800={$00,$03}. We replicate them VERBATIM so the post-clobber reads (and the
 * resulting zone bits) are bit-exact to the 68K. R12 points here (first pair =
 * zone_check_data+$800) on switch, advancing +2 per subsequent non-hit iteration. */
.align 2
.zc_zb_bytes:  .byte 0x00,0xFF, 0x00,0x10, 0x00,0x03
.align 2
.zc_obj_globals:  .long   0x06011050

/* ============================================================================
 * proximity_zone_loop  (68K $00877A-$0087E2, 104B)
 *
 * Iterate 15 AI entities ($06010000 stride $100), classify each into a proximity
 * zone written to its +$C0 word, by Manhattan distance from a center point.
 *
 * In (CALLER-SUPPLIED REGISTERS — preserved param convention):
 *      R1 = center_x (68K A0+$30)   R2 = center_y (68K A0+$34)
 *      R4 = close threshold  (68K $0140)
 *      R5 = near threshold   (68K $02C0)
 *      R6 = approach threshold (68K $1000)
 *   (The 68K loads x/y from A0+$30/$34 and hardcodes the 3 thresholds; the SH2
 *    entry takes them in registers so the eventual cmd $3F caller supplies them.)
 * Out: each AI entity +$C0 (word) = $0000 / $0003 / $0002 / $8001 zone code.
 * Clobbers: R0,R3,R7,R10,R11. Preserves GBR,R13,R14,R15,PR (leaf, no call).
 * ============================================================================
 */
.global proximity_zone_loop
proximity_zone_loop:
    mov.l   r8,@-r15                 /* extra scratch (dy) */
    mov.l   r9,@-r15                 /* extra scratch (zone value) */
    exts.w  r1,r1                    /* center_x signed (cx) */
    exts.w  r2,r2                    /* center_y signed (cy) */
    exts.w  r4,r4                    /* close threshold */
    exts.w  r5,r5                    /* near threshold */
    exts.w  r6,r6                    /* approach threshold */
    mov.l   @(.pz_ai_base,pc),r10    /* R10 = A1 = $06010000 (first AI entity) */
    mov     #15,r11                  /* 15 entities (68K: moveq #14 + dbra) */
    /* Stable across loop: R1=cx R2=cy R4=close R5=near R6=approach R10=A1
     * R11=count. Per-iteration: R3=dx, R8=dy, R9=zone code, R0=offset/tmp.
     * 68K writes +$C0 incrementally as it descends tiers; we compute the final
     * zone code into R9 and store ONCE at .pz_store (semantically identical:
     * the deepest matched tier wins, and the 68K never re-reads +$C0). */
.pz_loop:
    /* dx = |A1.30 - cx| -> R3 (68K sub.w is WORD: re-truncate via exts.w) */
    mov     #0x30,r0
    mov.w   @(r0,r10),r3
    exts.w  r3,r3
    sub     r1,r3                    /* d2 = A1.X - cx */
    exts.w  r3,r3                    /* sub.w word semantics (wrap to 16) */
    cmp/pz  r3
    bt      .pz_xp
    neg     r3,r3
    exts.w  r3,r3                    /* neg.w word */
.pz_xp:
    /* dy = |A1.34 - cy| -> R8 */
    mov     #0x34,r0
    mov.w   @(r0,r10),r8
    exts.w  r8,r8
    sub     r2,r8                    /* d3 = A1.Y - cy */
    exts.w  r8,r8                    /* sub.w word semantics */
    cmp/pz  r8
    bt      .pz_yp
    neg     r8,r8
    exts.w  r8,r8                    /* neg.w word */
.pz_yp:
    mov     #0,r9                    /* default zone 0 */
    /* approach gate: dx>approach OR dy>approach -> zone 0 */
    cmp/gt  r6,r3
    bt      .pz_store
    cmp/gt  r6,r8
    bt      .pz_store
    /* within approach -> zone 3 */
    mov     #3,r9
    /* near gate: dx>near OR dy>near -> stay zone 3 */
    cmp/gt  r5,r3
    bt      .pz_store
    cmp/gt  r5,r8
    bt      .pz_store
    /* within near -> zone 2 */
    mov     #2,r9
    /* close gate: dx>close OR dy>close -> stay zone 2 */
    cmp/gt  r4,r3
    bt      .pz_store
    cmp/gt  r4,r8
    bt      .pz_store
    /* within close -> inner zone $8001 */
    mov.w   @(.pz_c8001,pc),r9
.pz_store:
    mov     #0xC0,r0
    extu.b  r0,r0
    mov.w   r9,@(r0,r10)           /* +$C0 = zone code */
.pz_next:
    mov.w   @(.pz_stride,pc),r0
    add     r0,r10                   /* A1 += $100 */
    dt      r11
    bf      .pz_loop
    mov.l   @r15+,r9
    mov.l   @r15+,r8
    rts
    nop

.align 1
.pz_stride:  .short  0x0100
.pz_c8001:   .short  0x8001
.align 2
.pz_ai_base: .long   0x06010000

.global collision_object_end
collision_object_end:
