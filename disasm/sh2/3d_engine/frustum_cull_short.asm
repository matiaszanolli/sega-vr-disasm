/*
 * func_023: Frustum Culling / Visibility Dispatcher
 * ROM File Offset: 0x23508 - 0x235F5 (238 bytes)
 * SH2 Address: 0x02223508 - 0x022235F5
 *
 * Purpose: Core visibility testing and rendering dispatch function.
 *          Performs frustum culling on quads and dispatches visible
 *          geometry to appropriate rasterization handlers.
 *
 * Type: Hub function (coordinator) - LARGEST standalone function
 * Called By: func_020 (recursive quad processor), func_021 (vertex transform)
 * Calls:
 *   - func_024 @ $0235F6 (screen coords)
 *   - func_026 @ $023644 (bounds check)
 *   - func_029 @ $023688 (render dispatch A)
 *   - func_032 @ $0236DA (render dispatch B)
 *   - func_033 @ $0236FA (render dispatch C)
 *   - func_036 @ $0237D6 (render dispatch D)
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x23508 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_023: Frustum Culling / Visibility Dispatcher
 * Entry: 0x02223508
 * ═══════════════════════════════════════════════════════════════════════════ */
func_023:
    /* Prologue and context setup */
    .short  0x4F22                              /* $023508: STS.L PR,@-R15 */
    .short  0xDE12                              /* $02350A: MOV.L @(72,PC),R14 → context A */
    .short  0xD912                              /* $02350C: MOV.L @(72,PC),R9 → context B */

    /* First visibility pass */
    .short  0xB072                              /* $02350E: BSR func_024 (screen coords) */
    .short  0x7802                              /* $023510: [delay] ADD #2,R8 */
    .short  0xB097                              /* $023512: BSR func_026 (bounds check) */
    .short  0x0009                              /* $023514: [delay] NOP */

    /* Test vertex pair 1 */
    .short  0x53E7                              /* $023516: MOV.L @(28,R14),R3 */
    .short  0x54E8                              /* $023518: MOV.L @(32,R14),R4 */
    .short  0x3317                              /* $02351A: CMP/GT R1,R3 */
    .short  0x893C                              /* $02351C: BT .cull_path_a */
    .short  0x3247                              /* $02351E: CMP/GT R4,R2 */
    .short  0x893A                              /* $023520: BT .cull_path_a */

    /* Secondary visibility test */
    .short  0xB0B1                              /* $023522: BSR func_029 (dispatch A) */
    .short  0x0009                              /* $023524: [delay] NOP */

    /* Test vertex pair 2 */
    .short  0x53E5                              /* $023526: MOV.L @(20,R14),R3 */
    .short  0x54E6                              /* $023528: MOV.L @(24,R14),R4 */
    .short  0x3317                              /* $02352A: CMP/GT R1,R3 */
    .short  0x8918                              /* $02352C: BT .cull_path_b */
    .short  0x3247                              /* $02352E: CMP/GT R4,R2 */
    .short  0x8916                              /* $023530: BT .cull_path_b */

    /* Z-depth test */
    .short  0x3210                              /* $023532: CMP/EQ R1,R2 */
    .short  0x895C                              /* $023534: BT .z_equal_path */

    /* Dispatch to rasterizer */
    .short  0x56E9                              /* $023536: MOV.L @(36,R14),R6 */
    .short  0xD308                              /* $023538: MOV.L @(32,PC),R3 → handler */
    .short  0x236B                              /* $02353A: OR R6,R3 */
    .short  0x853E                              /* $02353C: MOV.W @(28,R14),R0 */
    .short  0xC808                              /* $02353E: TST #8,R0 */
    .short  0x89FC                              /* $023540: BT .dispatch_loop */

    /* Render dispatch path 1 */
    .short  0x6963                              /* $023542: MOV R6,R9 */
    .short  0xB0C9                              /* $023544: BSR func_032 */
    .short  0xEC04                              /* $023546: [delay] MOV #4,R12 */
    .short  0x6963                              /* $023548: MOV R6,R9 */
    .short  0x7920                              /* $02354A: ADD #32,R9 */
    .short  0xB0C5                              /* $02354C: BSR func_032 */
    .short  0xECFC                              /* $02354E: [delay] MOV #-4,R12 */
    .short  0xA223                              /* $023550: BRA .exit_success */
    .short  0x4F26                              /* $023552: [delay] LDS.L @R15+,PR */

/* Literal Pool 1 */
.lit_pool_1:
    .short  0xC000                              /* $023554: Context A high (0xC0000700) */
    .short  0x0700                              /* $023556: */
    .short  0xC000                              /* $023558: Context B high (0xC0000740) */
    .short  0x0740                              /* $02355A: */
    .short  0x2000                              /* $02355C: Null ptr (0x20000000) */
    .short  0x0000                              /* $02355E: */

/* Alternate visibility path */
.alt_path:
    .short  0x3237                              /* $023560: CMP/GT R3,R2 */
    .short  0x8B45                              /* $023562: BF .cull_reject */
    .short  0x3147                              /* $023564: CMP/GT R4,R1 */
    .short  0x8943                              /* $023566: BT .cull_reject */
    .short  0x3210                              /* $023568: CMP/EQ R1,R2 */
    .short  0x8941                              /* $02356A: BT .special_case */

    /* Load render params */
    .short  0x56E9                              /* $02356C: MOV.L @(36,R14),R6 */
    .short  0xD309                              /* $02356E: MOV.L @(36,PC),R3 → handler 2 */
    .short  0x236B                              /* $023570: OR R6,R3 */
    .short  0x853E                              /* $023572: MOV.W @(28,R14),R0 */
    .short  0xC808                              /* $023574: TST #8,R0 */
    .short  0x89FC                              /* $023576: BT .alt_dispatch */

    /* Push and render path 2 */
    .short  0x2F66                              /* $023578: MOV.L R6,@-R15 */
    .short  0x6963                              /* $02357A: MOV R6,R9 */
    .short  0xB0BD                              /* $02357C: BSR func_033 */
    .short  0xEC04                              /* $02357E: [delay] MOV #4,R12 */
    .short  0x66F6                              /* $023580: MOV.L @R15+,R6 */
    .short  0x2F66                              /* $023582: MOV.L R6,@-R15 */
    .short  0x6963                              /* $023584: MOV R6,R9 */
    .short  0x7920                              /* $023586: ADD #32,R9 */
    .short  0xB0B7                              /* $023588: BSR func_033 */
    .short  0xECFC                              /* $02358A: [delay] MOV #-4,R12 */
    .short  0x66F6                              /* $02358C: MOV.L @R15+,R6 */
    .short  0xA204                              /* $02358E: BRA .exit_alt */
    .short  0x4F26                              /* $023590: [delay] LDS.L @R15+,PR */

/* Literal Pool 2 */
.lit_pool_2:
    .short  0x0000                              /* $023592: Padding */
    .short  0x2000                              /* $023594: Handler ref (0x20000000) */
    .short  0x0000                              /* $023596: */

/* Third visibility path */
.third_path:
    .short  0xB076                              /* $023598: BSR func_036 (dispatch D) */
    .short  0x0009                              /* $02359A: [delay] NOP */
    .short  0x53E5                              /* $02359C: MOV.L @(20,R14),R3 */
    .short  0x54E6                              /* $02359E: MOV.L @(24,R14),R4 */
    .short  0x3237                              /* $0235A0: CMP/GT R3,R2 */
    .short  0x8B25                              /* $0235A2: BF .path_3_reject */
    .short  0x3147                              /* $0235A4: CMP/GT R4,R1 */
    .short  0x8923                              /* $0235A6: BT .path_3_reject */
    .short  0x3210                              /* $0235A8: CMP/EQ R1,R2 */
    .short  0x8921                              /* $0235AA: BT .path_3_special */

    /* Dispatch sequence */
    .short  0xD90C                              /* $0235AC: MOV.L @(48,PC),R9 */
    .short  0xB0A4                              /* $0235AE: BSR func_033 */
    .short  0xEC04                              /* $0235B0: [delay] MOV #4,R12 */
    .short  0xD90C                              /* $0235B2: MOV.L @(48,PC),R9 */
    .short  0xB0A1                              /* $0235B4: BSR func_033 */
    .short  0xECFC                              /* $0235B6: [delay] MOV #-4,R12 */

    /* Final setup and call */
    .short  0xD809                              /* $0235B8: MOV.L @(36,PC),R8 */
    .short  0xD90B                              /* $0235BA: MOV.L @(44,PC),R9 */
    .short  0xB10C                              /* $0235BC: BSR func_036 */
    .short  0x4F22                              /* $0235BE: [delay] STS.L PR,@-R15 */
    .short  0x4A28                              /* $0235C0: SHLL16 R10 */
    .short  0x4A08                              /* $0235C2: SHLL2 R10 */
    .short  0x4B08                              /* $0235C4: SHLL2 R11 */
    .short  0x2BAB                              /* $0235C6: OR R10,R11 */
    .short  0x1EB1                              /* $0235C8: MOV.L R11,@(4,R14) */

    /* Second call sequence */
    .short  0xD806                              /* $0235CA: MOV.L @(24,PC),R8 */
    .short  0xD907                              /* $0235CC: MOV.L @(28,PC),R9 */
    .short  0xB103                              /* $0235CE: BSR func_036 */
    .short  0x4F22                              /* $0235D0: [delay] STS.L PR,@-R15 */
    .short  0x4A28                              /* $0235D2: SHLL16 R10 */
    .short  0x2BAB                              /* $0235D4: OR R10,R11 */
    .short  0x5AE1                              /* $0235D6: MOV.L @(4,R14),R10 */
    .short  0x2BAB                              /* $0235D8: OR R10,R11 */
    .short  0x1EB1                              /* $0235DA: MOV.L R11,@(4,R14) */
    .short  0xA13F                              /* $0235DC: BRA .final_exit */
    .short  0x4F26                              /* $0235DE: [delay] LDS.L @R15+,PR */

/* Literal Pool 3 */
.lit_pool_3:
    .short  0xC000                              /* $0235E0: Context ptr (0xC0000780) */
    .short  0x0780                              /* $0235E2: */
    .short  0xC000                              /* $0235E4: Context ptr (0xC00007A0) */
    .short  0x07A0                              /* $0235E6: */
    .short  0xC000                              /* $0235E8: Context ptr (0xC00007C0) */
    .short  0x07C0                              /* $0235EA: */
    .short  0xC000                              /* $0235EC: Context ptr (0xC00007E0) */
    .short  0x07E0                              /* $0235EE: */

/* Final exit */
.final_return:
    .short  0x4F26                              /* $0235F0: LDS.L @R15+,PR */
    .short  0x000B                              /* $0235F2: RTS */
    .short  0x0009                              /* $0235F4: [delay] NOP */

/* ============================================================================
 * End of func_023 (238 bytes)
 *
 * Analysis:
 * - Core frustum culling hub - coordinates all visibility testing
 * - Multiple dispatch paths based on visibility test results
 * - Calls func_024 (coords), func_026 (bounds), func_029/032/033/036 (render)
 * - Three literal pools for context pointers (SDRAM cache-through)
 * - Complex branching with early-out cull rejection paths
 * ============================================================================ */
