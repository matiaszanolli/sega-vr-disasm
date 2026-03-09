/* DOCUMENTATION ONLY — not used by build system.
 * Build source: func_023_frustum_cull_short.asm
 */
/*
 * func_023: Frustum Culling / Visibility Dispatcher
 * ROM File Offset: 0x23508 - 0x235F2 (234 bytes)
 * SH2 Address: 0x02223508 - 0x022235F2
 *
 * Purpose: Core visibility testing and rendering dispatch function.
 *          Performs frustum culling on quads and dispatches visible
 *          geometry to appropriate rasterization handlers.
 *
 * Type: Hub function (coordinator)
 * Called By: func_020 (recursive quad processor), func_021 (vertex transform)
 * Calls:
 *   - func_024 @ $0235F4 (visibility test helper)
 *   - func_026 @ $023642 (bounds check)
 *   - func_029 @ $023686 (render dispatch A)
 *   - func_032 @ $0236D8 (render dispatch B)
 *   - func_033 @ $0236F8 (render dispatch C)
 *   - func_036 @ $0237D2 (render dispatch D)
 *
 * Input:
 *   R14 = RenderingContext pointer
 *   Context fields contain transformed vertex data
 *
 * Output:
 *   Dispatches to rasterizer based on visibility results
 *   Updates context with culling status
 *
 * Frustum Tests:
 *   Tests quad vertices against view frustum planes:
 *   - Near/far plane (Z depth)
 *   - Left/right plane (X bounds)
 *   - Top/bottom plane (Y bounds)
 */

.section .text
.align 2

/* Literal pool before function (from previous func_022) */
    /* $023502: */ .long   0x00002000      /* Address constant */

func_023:
    /* ─────────────────────────────────────────────────────────────────────────
     * Prologue: Save return and load context pointers
     * ───────────────────────────────────────────────────────────────────────── */
    /* $023508: 4F22 */ sts.l   pr,@-r15            /* Save return address */
    /* $02350A: DE12 */ mov.l   .lit_context_a,r14  /* R14 = context pointer A */
    /* $02350C: D912 */ mov.l   .lit_context_b,r9   /* R9 = context pointer B */

    /* ─────────────────────────────────────────────────────────────────────────
     * First visibility pass: Test against primary planes
     * ───────────────────────────────────────────────────────────────────────── */
    /* $02350E: B072 */ bsr     func_024            /* Call visibility test */
    /* $023510: 7802 */ add     #2,r8               /* [delay] Advance ptr */
    /* $023512: B097 */ bsr     func_026            /* Call bounds check */
    /* $023514: 0009 */ nop                         /* Delay slot */

    /* Load and test vertex pair 1 */
    /* $023516: 53E7 */ mov.l   @(28,r14),r3        /* R3 = vertex data 1 */
    /* $023518: 54E8 */ mov.l   @(32,r14),r4        /* R4 = vertex data 2 */
    /* $02351A: 3317 */ cmp/gt  r1,r3               /* Compare R3 > R1 */
    /* $02351C: 893C */ bt      .cull_path_a        /* Branch if outside */
    /* $02351E: 3247 */ cmp/gt  r4,r2               /* Compare R2 > R4 */
    /* $023520: 893A */ bt      .cull_path_a        /* Branch if outside */

    /* Secondary visibility test */
    /* $023522: B0B1 */ bsr     func_029            /* Call render dispatch A */
    /* $023524: 0009 */ nop                         /* Delay slot */

    /* Load and test vertex pair 2 */
    /* $023526: 53E5 */ mov.l   @(20,r14),r3        /* R3 = vertex data 3 */
    /* $023528: 54E6 */ mov.l   @(24,r14),r4        /* R4 = vertex data 4 */
    /* $02352A: 3317 */ cmp/gt  r1,r3               /* Compare R3 > R1 */
    /* $02352C: 8918 */ bt      .cull_path_b        /* Branch if outside */
    /* $02352E: 3247 */ cmp/gt  r4,r2               /* Compare R2 > R4 */
    /* $023530: 8916 */ bt      .cull_path_b        /* Branch if outside */

    /* Z-depth test */
    /* $023532: 3210 */ cmp/eq  r1,r2               /* Compare Z values */
    /* $023534: 895C */ bt      .z_equal_path       /* Branch if Z equal */

    /* ─────────────────────────────────────────────────────────────────────────
     * Visibility passed - dispatch to rasterizer
     * ───────────────────────────────────────────────────────────────────────── */
    /* $023536: 56E9 */ mov.l   @(36,r14),r6        /* R6 = rasterize params */
    /* $023538: D308 */ mov.l   .lit_handler_ptr,r3 /* Load handler address */
    /* $02353A: 236B */ mov     r6,r3               /* Copy params (OR operation) */
    /* $02353C: 853E */ mov.w   @(28,r14),r0        /* Load control word */
    /* $02353E: C808 */ tst     #8,r0               /* Test flag bit 3 */
    /* $023540: 89FC */ bt      .dispatch_loop      /* Branch based on flag */

    /* Render dispatch with offset adjustment */
    /* $023542: 6963 */ mov     r6,r9               /* R9 = params */
    /* $023544: B0C9 */ bsr     func_032            /* Call render dispatch B */
    /* $023546: EC04 */ mov     #4,r12              /* [delay] R12 = 4 */
    /* $023548: 6963 */ mov     r6,r9               /* Restore R9 */
    /* $02354A: 7920 */ add     #32,r9              /* Offset by 32 */
    /* $02354C: B0C5 */ bsr     func_032            /* Call again with offset */
    /* $02354E: ECFC */ mov     #-4,r12             /* [delay] R12 = -4 */
    /* $023550: A223 */ bra     .exit_success       /* Jump to exit */
    /* $023552: 4F26 */ lds.l   @r15+,pr            /* [delay] Restore PR */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool 1
 * ───────────────────────────────────────────────────────────────────────────── */
.align 4
.lit_context_a:
    /* $023554: */ .long   0x06000700          /* SDRAM context A */
.lit_context_b:
    /* $023558: */ .long   0x06000740          /* SDRAM context B */
.lit_null:
    /* $02355C: */ .long   0x00002000          /* Null/default pointer */

/* ─────────────────────────────────────────────────────────────────────────────
 * Alternate visibility path: Different test sequence
 * ───────────────────────────────────────────────────────────────────────────── */
.alt_visibility_path:
    /* $023560: 3237 */ cmp/gt  r3,r2               /* Compare bounds */
    /* $023562: 8B45 */ bf      .cull_reject        /* Reject if failed */
    /* $023564: 3147 */ cmp/gt  r4,r1               /* Compare bounds */
    /* $023566: 8943 */ bt      .cull_reject        /* Reject if failed */
    /* $023568: 3210 */ cmp/eq  r1,r2               /* Z equality test */
    /* $02356A: 8941 */ bt      .special_case       /* Special handling */

    /* Load render parameters */
    /* $02356C: 56E9 */ mov.l   @(36,r14),r6        /* R6 = params */
    /* $02356E: D309 */ mov.l   .lit_handler_2,r3   /* Handler address */
    /* $023570: 236B */ mov     r6,r3               /* Merge params */
    /* $023572: 853E */ mov.w   @(28,r14),r0        /* Control word */
    /* $023574: C808 */ tst     #8,r0               /* Test flag */
    /* $023576: 89FC */ bt      .alt_dispatch       /* Dispatch based on flag */

    /* Push and render */
    /* $023578: 2F66 */ mov.l   r6,@-r15            /* Save R6 */
    /* $02357A: 6963 */ mov     r6,r9               /* R9 = params */
    /* $02357C: B0BD */ bsr     func_033            /* Call render dispatch C */
    /* $02357E: EC04 */ mov     #4,r12              /* [delay] R12 = 4 */
    /* $023580: 66F6 */ mov.l   @r15+,r6            /* Restore R6 */
    /* $023582: 2F66 */ mov.l   r6,@-r15            /* Save again */
    /* $023584: 6963 */ mov     r6,r9               /* R9 = params */
    /* $023586: 7920 */ add     #32,r9              /* Offset */
    /* $023588: B0B7 */ bsr     func_033            /* Call again */
    /* $02358A: ECFC */ mov     #-4,r12             /* [delay] R12 = -4 */
    /* $02358C: 66F6 */ mov.l   @r15+,r6            /* Restore R6 */
    /* $02358E: A204 */ bra     .exit_alt           /* Exit path */
    /* $023590: 4F26 */ lds.l   @r15+,pr            /* [delay] Restore PR */

/* ─────────────────────────────────────────────────────────────────────────────
 * Literal Pool 2
 * ───────────────────────────────────────────────────────────────────────────── */
.align 4
.lit_handler_2:
    /* $023594: */ .long   0x00002000          /* Handler reference */

/* ─────────────────────────────────────────────────────────────────────────────
 * Third visibility path with func_036 dispatch
 * ───────────────────────────────────────────────────────────────────────────── */
.third_path:
    /* $023598: B076 */ bsr     func_036            /* Call render dispatch D */
    /* $02359A: 0009 */ nop                         /* Delay slot */
    /* ... continued processing ... */

/* (Additional paths and exit handling continue through $0235F2) */

/* ─────────────────────────────────────────────────────────────────────────────
 * Cull rejection paths
 * ───────────────────────────────────────────────────────────────────────────── */
.cull_path_a:
.cull_path_b:
.cull_reject:
    /* Quad is outside frustum - skip rendering */
    /* Return without dispatching to rasterizer */

/* ─────────────────────────────────────────────────────────────────────────────
 * Exit paths
 * ───────────────────────────────────────────────────────────────────────────── */
.exit_success:
.exit_alt:
    /* $0235F0: 4F26 */ lds.l   @r15+,pr            /* Restore return address */
    /* $0235F2: 000B */ rts                         /* Return */
    /* $0235F4: 0009 */ nop                         /* Delay slot */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Frustum Culling Logic:
 *    Tests quad vertices against view frustum using CMP/GT comparisons.
 *    Three test pairs check X, Y, and Z bounds against frustum planes.
 *    Failed tests branch to cull paths, skipping rasterization.
 *
 * 2. Multiple Dispatch Paths:
 *    Based on visibility test results and control flags, dispatches to:
 *    - func_029: Primary render path
 *    - func_032: Secondary with offset rendering
 *    - func_033: Tertiary render variant
 *    - func_036: Special case rendering
 *
 * 3. Control Flag Testing:
 *    Uses TST #8,R0 to check bit 3 of control word at context+28.
 *    This flag selects between different rendering modes (likely
 *    related to polygon type: flat, textured, gouraud, etc.)
 *
 * 4. Offset Rendering Pattern:
 *    Calls render function twice with R9 offset by 32 bytes between calls.
 *    R12 alternates between +4 and -4 for some adjustment parameter.
 *    This suggests rendering front/back faces or split quads.
 *
 * 5. SDRAM Contexts:
 *    Two context pointers loaded from literal pool:
 *    - 0x06000700: Primary context (transformed vertices?)
 *    - 0x06000740: Secondary context (clipping/culling state?)
 *
 * 6. Performance Critical:
 *    Called for every potentially visible quad (~800/frame).
 *    Quick rejection of invisible quads is key to performance.
 *    The early BT (branch if true) instructions provide fast-path culling.
 *
 * ============================================================================ */
