/*
 * cmd3f_vr60_gameframe — VR60 Game Frame Handler (Phase 2B: Async Block Copies)
 * Expansion ROM Address: $301500 (SH2: $02301500)
 *
 * Phase 3B: Fire-and-forget handler + SH2 physics pipeline.
 * 68K triggers cmd $3F and continues immediately. This handler performs:
 *   1. Read COMM3-5 game state, write to SDRAM mailbox
 *   2. Geometry block copy: $06038000 → $04012010, 144 words × 48 rows
 *   3. Sprite block copy:   $0603B600 → $0401B010, 144 words × 24 rows
 *   4. SH2 PHYSICS PIPELINE: 7 functions on entity at $0600F20C
 *      - Set GBR = entity base, R13 = globals base
 *      - JSR: speed_degrade → steering → force_integration → speed_clamp
 *             → speed_accel → tilt_adjust
 *   5. Post-physics canary at $2200FC00
 *   6. COMM cleanup: COMM1_LO bit 0 = "frame done" signal
 *
 * Phase 3B: Physics runs in DUAL-PATH mode. 68K physics also runs on WRAM.
 * SH2 physics results stay in SDRAM entity copy. Compare outputs to verify.
 *
 * Block copy algorithm reused from cmd22_single_shot.asm (longword path).
 * All addresses are 4-byte aligned and width is even → always longword path.
 * Row stride = $0200 (512 bytes, framebuffer line width).
 * Source is contiguous in SDRAM; destination is strided in framebuffer.
 *
 * Synchronization: V-INT $54 (vdp_dma_frame_swap_037) polls COMM1_LO bit 0.
 * When set, it swaps the frame buffer and resets $C87E. This gates state 0's
 * DREQ DMA from firing while copies are still in progress.
 * See: analysis/ASYNC_PIPELINE_ARCHITECTURE.md §6.3
 *
 * COMM protocol (follows cmd22 proven pattern):
 *   R8 = $20004020 (COMM base, cache-through, set by dispatch loop)
 *   Read COMM3  @(6,R8)  = frame_counter   → mailbox +$06
 *   Read COMM4  @(8,R8)  = game_state      → mailbox +$08
 *   Read COMM5  @(10,R8) = frame_toggle    → mailbox +$0A
 *   THEN clear COMM0_LO (params consumed signal)
 *
 * Block copy parameters (constant during racing, hardcoded):
 *   Geometry: src=$06038000 (SDRAM), dst=$04012010 (framebuffer)
 *            144 words/row = 72 longwords/row, 48 rows, stride $0200
 *   Sprites:  src=$0603B600 (SDRAM), dst=$0401B010 (framebuffer)
 *            144 words/row = 72 longwords/row, 24 rows, stride $0200
 *
 * Entry: R8 = $20004020
 * Clobbers: R0-R7 (R8 reloaded for cleanup)
 * Preserves: R15
 */

.section .text
.align 2

cmd3f_vr60_gameframe:
    /* Save PR */
    /* offset  0 */ sts.l   pr,@-r15

    /* === PARAM READ: read ALL COMM params BEFORE clearing COMM0_LO === */
    /* offset  2 */ mov.w   @(6,r8),r0           /* R0 = COMM3 */
    /* offset  4 */ mov     r0,r1                /* R1 = frame_counter */
    /* offset  6 */ mov.w   @(8,r8),r0           /* R0 = COMM4 */
    /* offset  8 */ mov     r0,r2                /* R2 = game_state */
    /* offset 10 */ mov.w   @(10,r8),r0          /* R0 = COMM5 */
    /* offset 12 */ mov     r0,r3                /* R3 = frame_toggle */

    /* === PARAMS-CONSUMED SIGNAL === */
    /* offset 14 */ mov     #0,r0
    /* offset 16 */ mov.b   r0,@(1,r8)           /* COMM0_LO = $00 */

    /* === WRITE COMM DATA TO SDRAM MAILBOX === */
    /* offset 18 */ mov.l   @(.mailbox_addr,pc),r4  /* R4 = $2200BC00 */
    /* offset 20 */ mov     r1,r0                /* R0 = frame_counter */
    /* offset 22 */ mov.w   r0,@(6,r4)           /* mailbox+$06 */
    /* offset 24 */ mov     r2,r0                /* R0 = game_state */
    /* offset 26 */ mov.w   r0,@(8,r4)           /* mailbox+$08 */
    /* offset 28 */ mov     r3,r0                /* R0 = frame_toggle */
    /* offset 30 */ mov.w   r0,@(10,r4)          /* mailbox+$0A */

    /* === GEOMETRY BLOCK COPY: $06038000 → $04012010, 72 longs × 48 rows === */
    /* Source is contiguous SDRAM (Slave rendered here during state 0).        */
    /* Dest is strided framebuffer (stride = $0200 = 512 bytes/line).          */
    /* offset 32 */ mov.l   @(.geo_src,pc),r3    /* R3 = $06038000 (src, auto-inc) */
    /* offset 34 */ mov.l   @(.geo_dst,pc),r0    /* R0 = $04012010 (dest base) */
    /* offset 36 */ mov     #2,r6                /* Build stride: R6 = 2 */
    /* offset 38 */ shll8   r6                   /* R6 = $0200 (512) */
    /* offset 40 */ mov     #48,r2               /* R2 = 48 rows */
.geo_row:
    /* offset 42 */ mov     r0,r4                /* R4 = dest row start */
    /* offset 44 */ mov     #72,r5               /* R5 = 72 longwords/row */
.geo_copy:
    /* offset 46 */ mov.l   @r3+,r7              /* R7 = *src++ */
    /* offset 48 */ mov.l   r7,@r4               /* *dest = R7 */
    /* offset 50 */ dt      r5                   /* R5-- and test */
    /* offset 52 */ bf/s    .geo_copy            /* loop if not zero */
    /* offset 54 */ add     #4,r4                /* [delay slot] dest += 4 */
    /* offset 56 */ dt      r2                   /* row-- */
    /* offset 58 */ bf/s    .geo_row             /* next row */
    /* offset 60 */ add     r6,r0                /* [delay slot] dest base += stride */

    /* === SPRITE BLOCK COPY: $0603B600 → $0401B010, 72 longs × 24 rows === */
    /* R6 = $0200 (stride preserved from geometry copy) */
    /* offset 62 */ mov.l   @(.spr_src,pc),r3    /* R3 = $0603B600 (src) */
    /* offset 64 */ mov.l   @(.spr_dst,pc),r0    /* R0 = $0401B010 (dest base) */
    /* offset 66 */ mov     #24,r2               /* R2 = 24 rows */
.spr_row:
    /* offset 68 */ mov     r0,r4                /* R4 = dest row start */
    /* offset 70 */ mov     #72,r5               /* R5 = 72 longwords/row */
.spr_copy:
    /* offset 72 */ mov.l   @r3+,r7              /* R7 = *src++ */
    /* offset 74 */ mov.l   r7,@r4               /* *dest = R7 */
    /* offset 76 */ dt      r5                   /* R5-- and test */
    /* offset 78 */ bf/s    .spr_copy            /* loop if not zero */
    /* offset 80 */ add     #4,r4                /* [delay slot] dest += 4 */
    /* offset 82 */ dt      r2                   /* row-- */
    /* offset 84 */ bf/s    .spr_row             /* next row */
    /* offset 86 */ add     r6,r0                /* [delay slot] dest base += stride */

    /* === PHASE 3B: RUN SH2 PHYSICS ON ENTITY DATA === */
    /* Entity data at $0600F20C (transferred by cmd $3E via DREQ).            */
    /* Globals at $0600F30C (also transferred by cmd $3E).                    */
    /* Set GBR = entity base, R13 = globals base, then call physics.          */

    /* Set GBR = entity base pointer */
    mov.l   @(.ent_dst,pc),r0       /* R0 = $0600F20C */
    ldc     r0,gbr                  /* GBR = entity base */

    /* Set R13 = globals base (entity + 256 = $0600F30C) */
    mov.l   @(.globals_base,pc),r13 /* R13 = $0600F30C */

    /* Call physics + timer/guard functions in orchestrator order via JSR @Rn.
     * Order matches 68K entity_render_pipeline Variant A (lines 27-40):
     *   speed_degrade → effect_timer → timer_expire → field_guard
     *   → timer_decrement → steering → force_integration → speed_clamp
     *   → speed_accel → tilt_adjust → anim_timer_speed_clear
     * tire_squeal_check stays on 68K (writes globals, not entity fields).
     */

    /* 1. speed_degrade_calc */
    mov.l   @(.phys_f1,pc),r0
    jsr     @r0
    nop

    /* T1. effect_timer_mgmt */
    mov.l   @(.tmr_et,pc),r0
    jsr     @r0
    nop

    /* T2. timer_expire_reset */
    mov.l   @(.tmr_te,pc),r0
    jsr     @r0
    nop

    /* T3. field_check_guard (sets R2 = lateral flag) */
    mov.l   @(.tmr_fg,pc),r0
    jsr     @r0
    nop

    /* T4. timer_decrement_multi */
    mov.l   @(.tmr_td,pc),r0
    jsr     @r0
    nop

    /* 2. steering_input */
    mov.l   @(.phys_f2,pc),r0
    jsr     @r0
    nop

    /* 3. force_integration (inlines speed_calc_chain + speed_modifier) */
    mov.l   @(.phys_f3,pc),r0
    jsr     @r0
    nop

    /* 5. entity_speed_clamp */
    mov.l   @(.phys_f5,pc),r0
    jsr     @r0
    nop

    /* 6. speed_accel_braking */
    mov.l   @(.phys_f6,pc),r0
    jsr     @r0
    nop

    /* 7. tilt_adjust */
    mov.l   @(.phys_f7,pc),r0
    jsr     @r0
    nop

    /* T5. anim_timer_speed_clear */
    mov.l   @(.tmr_ac,pc),r0
    jsr     @r0
    nop

    /* === CANARY: write entity first longword to verify physics ran === */
    mov.l   @(.ent_dst,pc),r4       /* R4 = entity base (re-read, GBR may differ) */
    mov.l   @r4,r0                  /* R0 = entity[0..3] (post-physics) */
    mov.l   @(.canary_addr,pc),r4
    mov.l   r0,@r4                  /* canary = entity first longword */
    mov.l   @(.canary_val,pc),r0
    mov.l   r0,@(4,r4)             /* canary+4 = $DEADBEEF */

    /* === COMPLETION: inline COMM cleanup (func_084 equivalent) === */
    /* Reload COMM base (clobbered during copy loops) */
    /* offset 110 */ mov.l  @(.comm_base,pc),r8  /* R8 = $20004020 */

    /* Clear COMM1, set "command done" bit */
    /* offset 112 */ mov    #0,r0
    /* offset 114 */ mov.w  r0,@(2,r8)           /* COMM1 = $0000 */
    /* offset 116 */ mov.b  @(3,r8),r0           /* R0 = COMM1_LO (0) */
    /* offset 118 */ or     #1,r0                /* R0 |= 1 */
    /* offset 120 */ mov.b  r0,@(3,r8)           /* COMM1_LO = 1 ("done") */

    /* Clear COMM0_HI (idle — allows next COMM0 command) */
    /* offset 122 */ mov    #0,r0
    /* offset 124 */ mov.b  r0,@(0,r8)           /* COMM0_HI = 0 */

    /* === RETURN === */
    /* offset 126 */ lds.l  @r15+,pr
    /* offset 128 */ rts
    /* offset 130 */ nop                         /* delay slot */

/* === LITERAL POOL ===
 * Code ends at offset 132.
 * All longword entries must be 4-byte aligned.
 */
.align 2
.mailbox_addr:
    .long   0x2200BC00              /* SDRAM mailbox (cache-through) */
.geo_src:
    .long   0x06038000              /* Geometry source (SDRAM, native read) */
.geo_dst:
    .long   0x04012010              /* Geometry dest (framebuffer, cached write) */
.spr_src:
    .long   0x0603B600              /* Sprite source (SDRAM, native read) */
.spr_dst:
    .long   0x0401B010              /* Sprite dest (framebuffer, cached write) */
.ent_dst:
    .long   0x0600F20C              /* Entity working copy (native SDRAM) */
.globals_base:
    .long   0x0600F30C              /* Globals block (native SDRAM, entity + 256) */
.canary_addr:
    .long   0x2200FC00              /* Validation canary location (cache-through for visibility) */
.canary_val:
    .long   0xDEADBEEF              /* Canary value */
.comm_base:
    .long   0x20004020              /* COMM register base (cache-through) */

/* Physics function addresses */
/* physics_group1 at $301700, physics_group2_accel at $301A80, physics_timers at $301C80 */
.phys_f1:
    .long   0x02301700              /* sh2_speed_degrade_calc (g1 + $000) */
.phys_f2:
    .long   0x02301760              /* sh2_steering_input (g1 + $060) */
.phys_f3:
    .long   0x023017DC              /* sh2_force_integration (g1 + $0DC) */
.phys_f5:
    .long   0x02301732              /* sh2_entity_speed_clamp (g1 + $032) */
.phys_f6:
    .long   0x02301A80              /* sh2_speed_accel_braking (g2 + $000) */
.phys_f7:
    .long   0x02301BFC              /* sh2_tilt_adjust (g2 + $17C) */

/* Timer/guard function addresses (physics_timers at $301C80) */
.tmr_td:
    .long   0x02301C80              /* sh2_timer_decrement_multi (tmr + $000) */
.tmr_et:
    .long   0x02301CD4              /* sh2_effect_timer_mgmt (tmr + $054) */
.tmr_te:
    .long   0x02301D40              /* sh2_timer_expire_reset (tmr + $0C0) */
.tmr_fg:
    .long   0x02301D60              /* sh2_field_check_guard (tmr + $0E0) */
.tmr_ac:
    .long   0x02301D6E              /* sh2_anim_timer_speed_clear (tmr + $0EE) */

/* Total: ~280 bytes code + 92 bytes pool = ~372 bytes */

.global cmd3f_vr60_gameframe
