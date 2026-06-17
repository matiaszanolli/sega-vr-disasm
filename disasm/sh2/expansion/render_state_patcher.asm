/*
 * render_state_patcher — Update entity render states for 60 FPS display
 * Expansion ROM Address: $302B00 (SH2: $02302B00)
 *
 * Called from cmd3f_vr60_gameframe after physics pipeline completes.
 * Bridges the gap between SH2 physics entities and the Slave SH2 render
 * data at $0600CA00+ (entity state arrays).
 *
 * PROBLEM: 68K physics is bypassed (VR60), so WRAM entity positions ($FF9000)
 * are frozen. The DREQ sends frozen display objects to SH2. The Slave renders
 * the same scene every frame. SH2 physics updates SDRAM entities but the
 * render pipeline never sees them.
 *
 * SOLUTION: After physics, recompute camera-relative positions for ALL
 * entities using updated world positions from SH2 physics entities + the
 * camera matrix at on-chip SRAM $C0000400.
 *
 * Algorithm (absolute, per-entity):
 *   1. Compute camera correction: cam_corr = M × [-(playerX - frozenX)<<12, 0, -(playerY - frozenY)<<12]
 *   2. Apply cam_corr to ALL 82 entity states (camera follows player)
 *   3. For each AI entity: compute ai_corr = M × [(aiX - frozenX)<<12, 0, (aiY - frozenY)<<12]
 *      and add to that entity's state entries (AI car moves independently)
 *
 * Entity state layout (48 bytes):
 *   +$00-$0B: Camera matrix row 0 (3 longwords)
 *   +$0C-$0F: Camera-relative X position
 *   +$10-$1B: Camera matrix row 1
 *   +$1C-$1F: Camera-relative depth
 *   +$20-$2B: Camera matrix row 2
 *   +$2C-$2F: Camera-relative height
 *
 * Mapping: AI entity N → display object N at $0600C218+N*$3C
 *          → entity state main at $0600CCA0+N*$90
 *          → sub-entities at +$30, +$60 within the $90 block
 *
 * Convention: GBR = player entity base ($0600F20C)
 * Clobbers: R0-R7, R9, R10, R11, R12 (R8 preserved, R15 preserved)
 * Preserves: GBR, R8, R13, R15
 */

.section .text
.align 2

.global sh2_render_state_patch
sh2_render_state_patch:
    sts.l   pr,@-r15

    /* ================================================================
     * PHASE 1: Camera correction (player moved → shift ALL entities)
     * ================================================================
     * Player's frozen position is in the DREQ buffer display objects.
     * But the player isn't in the display object array — camera data is
     * at $0600C100. We use the DREQ buffer's first display object's
     * world X/Y as a reference for the frozen state. Actually, the player
     * physics entity +$30/+$34 WAS frozen at staging time. The DREQ
     * display objects reflect that frozen state.
     *
     * Simpler: use entity+$EC/+$EE (saved pre-physics) as frozen ref.
     * Compute: delta = post_physics - pre_physics
     * Camera correction = M × [-delta_X<<12, 0, -delta_Y<<12]
     */

    /* Compute player delta */
    mov.w   @(0xEC,gbr),r0         /* old world X (saved before physics) */
    exts.w  r0,r0
    mov     r0,r1
    mov.w   @(0x30,gbr),r0         /* new world X (post-physics) */
    exts.w  r0,r0
    sub     r1,r0                  /* deltaX = new - old */
    shll8   r0
    shll2   r0
    shll2   r0                     /* deltaX << 12 */
    neg     r0,r5                  /* R5 = -deltaX<<12 (camera moves opposite) */

    mov.w   @(0xEE,gbr),r0         /* old world Y */
    exts.w  r0,r0
    mov     r0,r1
    mov.w   @(0x34,gbr),r0         /* new world Y */
    exts.w  r0,r0
    sub     r1,r0
    shll8   r0
    shll2   r0
    shll2   r0
    neg     r0,r7                  /* R7 = -deltaY<<12 */

    /* Multiply camera correction by camera matrix */
    mov.l   @(.cam_matrix,pc),r4   /* R4 = $C0000400 */

    /* corr[0] = M[0][0]*R5 + M[0][2]*R7 (M[0][1]*0 = 0, skip) */
    mov.l   @(0x00,r4),r0         /* M[0][0] */
    dmuls.l r0,r5
    sts     macl,r9
    sts     mach,r0
    xtrct   r0,r9
    mov.l   @(0x08,r4),r0         /* M[0][2] */
    dmuls.l r0,r7
    sts     macl,r1
    sts     mach,r0
    xtrct   r0,r1
    add     r1,r9                  /* R9 = cam_corr[0] */

    /* corr[1] = M[1][0]*R5 + M[1][2]*R7 */
    mov.l   @(0x10,r4),r0         /* M[1][0] */
    dmuls.l r0,r5
    sts     macl,r10
    sts     mach,r0
    xtrct   r0,r10
    mov.l   @(0x18,r4),r0         /* M[1][2] */
    dmuls.l r0,r7
    sts     macl,r1
    sts     mach,r0
    xtrct   r0,r1
    add     r1,r10                 /* R10 = cam_corr[1] */

    /* corr[2] = M[2][0]*R5 + M[2][2]*R7 */
    mov.l   @(0x20,r4),r0         /* M[2][0] */
    dmuls.l r0,r5
    sts     macl,r11
    sts     mach,r0
    xtrct   r0,r11
    mov.l   @(0x28,r4),r0         /* M[2][2] */
    dmuls.l r0,r7
    sts     macl,r1
    sts     mach,r0
    xtrct   r0,r1
    add     r1,r11                 /* R11 = cam_corr[2] */

    /* ================================================================
     * PHASE 2: Apply camera correction to ALL 82 entity states
     * ================================================================ */
    mov.l   @(.state_base,pc),r4   /* R4 = $0600CA00 */
    mov     #82,r6

.cam_loop:
    mov.l   @(0x0C,r4),r0
    add     r9,r0
    mov.l   r0,@(0x0C,r4)

    mov.l   @(0x1C,r4),r0
    add     r10,r0
    mov.l   r0,@(0x1C,r4)

    mov.l   @(0x2C,r4),r0
    add     r11,r0
    mov.l   r0,@(0x2C,r4)

    add     #0x30,r4
    dt      r6
    bf      .cam_loop

    /* ================================================================
     * PHASE 3: Per-AI-entity position correction
     * ================================================================
     * For each AI entity, compute how much IT moved (not the camera)
     * and apply that correction to its entity state entries.
     *
     * AI entity N physics: $06010000 + N*$100
     * AI entity N frozen X: DREQ display object at $0600C218 + N*$3C + $02
     * AI entity N frozen Y: DREQ display object at $0600C218 + N*$3C + $06
     * Entity state main: $0600CCA0 + N*$90 + $0C/+$1C/+$2C
     * Entity state sub1: $0600CCA0 + N*$90 + $30 + $0C/+$1C/+$2C
     * Entity state sub2: $0600CCA0 + N*$90 + $60 + $0C/+$1C/+$2C
     */
    mov.l   @(.ai_phys_base,pc),r12  /* R12 = $06010000 (AI physics entities) */
    mov.l   @(.disp_obj_base,pc),r3  /* R3 = $0600C218 (frozen display objects) */
    mov.l   @(.ai_state_base,pc),r4  /* R4 = $0600CCA0 (AI entity states) */
    mov     #15,r6                    /* 15 AI entities */

.ai_loop:
    /* Read frozen world X from DREQ display object +$02 */
    mov.w   @(0x02,r3),r0            /* frozen X (16-bit) */
    exts.w  r0,r0
    mov     r0,r1                     /* R1 = frozen X */

    /* Read current world X from AI physics entity +$30 */
    mov     #0x30,r0
    mov.w   @(r0,r12),r0             /* AI entity[+$30] current X */
    exts.w  r0,r0
    sub     r1,r0                     /* deltaX = current - frozen */
    shll8   r0
    shll2   r0
    shll2   r0                        /* deltaX << 12 */
    mov     r0,r5                     /* R5 = AI deltaX << 12 */

    /* Read frozen world Y from DREQ display object +$06 */
    mov.w   @(0x06,r3),r0
    exts.w  r0,r0
    mov     r0,r1                     /* R1 = frozen Y */

    /* Read current world Y from AI physics entity +$34 */
    mov     #0x34,r0
    mov.w   @(r0,r12),r0
    exts.w  r0,r0
    sub     r1,r0
    shll8   r0
    shll2   r0
    shll2   r0
    mov     r0,r7                     /* R7 = AI deltaY << 12 */

    /* Skip if no movement (optimization: most entities haven't moved much) */
    mov     r5,r0
    or      r7,r0
    tst     r0,r0
    bt      .ai_next                  /* both zero: skip matrix multiply */

    /* Compute AI correction: M × [deltaX, 0, deltaY] */
    mov.l   @(.cam_matrix,pc),r2      /* reload matrix base */

    mov.l   @(0x00,r2),r0            /* M[0][0] */
    dmuls.l r0,r5
    sts     macl,r9
    sts     mach,r0
    xtrct   r0,r9
    mov.l   @(0x08,r2),r0            /* M[0][2] */
    dmuls.l r0,r7
    sts     macl,r1
    sts     mach,r0
    xtrct   r0,r1
    add     r1,r9                     /* R9 = ai_corr[0] */

    mov.l   @(0x10,r2),r0            /* M[1][0] */
    dmuls.l r0,r5
    sts     macl,r10
    sts     mach,r0
    xtrct   r0,r10
    mov.l   @(0x18,r2),r0            /* M[1][2] */
    dmuls.l r0,r7
    sts     macl,r1
    sts     mach,r0
    xtrct   r0,r1
    add     r1,r10                    /* R10 = ai_corr[1] */

    mov.l   @(0x20,r2),r0            /* M[2][0] */
    dmuls.l r0,r5
    sts     macl,r11
    sts     mach,r0
    xtrct   r0,r11
    mov.l   @(0x28,r2),r0            /* M[2][2] */
    dmuls.l r0,r7
    sts     macl,r1
    sts     mach,r0
    xtrct   r0,r1
    add     r1,r11                    /* R11 = ai_corr[2] */

    /* Apply AI correction to main entity state + 2 sub-entities */
    /* Main: R4+$0C, R4+$1C, R4+$2C */
    mov.l   @(0x0C,r4),r0
    add     r9,r0
    mov.l   r0,@(0x0C,r4)
    mov.l   @(0x1C,r4),r0
    add     r10,r0
    mov.l   r0,@(0x1C,r4)
    mov.l   @(0x2C,r4),r0
    add     r11,r0
    mov.l   r0,@(0x2C,r4)

    /* Sub-entity 1: R4+$30 base */
    mov     r4,r2
    add     #0x30,r2                  /* R2 = R4 + $30 */
    mov.l   @(0x0C,r2),r0
    add     r9,r0
    mov.l   r0,@(0x0C,r2)
    mov.l   @(0x1C,r2),r0
    add     r10,r0
    mov.l   r0,@(0x1C,r2)
    mov.l   @(0x2C,r2),r0
    add     r11,r0
    mov.l   r0,@(0x2C,r2)

    /* Sub-entity 2: R4+$60 base */
    mov     r4,r2
    add     #0x60,r2                  /* R2 = R4 + $60 */
    mov.l   @(0x0C,r2),r0
    add     r9,r0
    mov.l   r0,@(0x0C,r2)
    mov.l   @(0x1C,r2),r0
    add     r10,r0
    mov.l   r0,@(0x1C,r2)
    mov.l   @(0x2C,r2),r0
    add     r11,r0
    mov.l   r0,@(0x2C,r2)

.ai_next:
    /* Advance to next AI entity */
    mov.w   @(.ai_stride,pc),r0       /* entity stride = $100 */
    add     r0,r12                    /* next AI physics entity */
    add     #0x3C,r3                  /* next display object (60B) */
    mov.l   @(.state_stride,pc),r0    /* state stride = $90 */
    add     r0,r4                     /* next entity state block */
    dt      r6
    bf      .ai_loop

    /* ================================================================
     * PHASE 4: Save positions for next frame's delta computation
     * ================================================================ */
    mov.w   @(0x30,gbr),r0
    mov.w   r0,@(0xEC,gbr)
    mov.w   @(0x34,gbr),r0
    mov.w   r0,@(0xEE,gbr)

    lds.l   @r15+,pr
    rts
    nop

.align 2
.cam_matrix:    .long   0xC0000400     /* Camera matrix template (Master on-chip SRAM) */
.state_base:    .long   0x0600CA00     /* First entity state */
.ai_phys_base:  .long   0x06010000     /* AI physics entities (SDRAM) */
.disp_obj_base: .long   0x0600C218     /* Display objects in DREQ buffer */
.ai_state_base: .long   0x0600CCA0     /* AI entity state (phase 4 start) */
.state_stride:  .long   0x00000090     /* Entity state outer stride (3 × $30) */
.ai_stride:     .short  0x0100         /* AI physics entity stride (256B) */

.global render_state_patcher_end
render_state_patcher_end:
