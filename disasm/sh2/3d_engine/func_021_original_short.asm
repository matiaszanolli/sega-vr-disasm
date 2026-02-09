/*
 * func_021: Vertex Transform Inner Loop
 * ROM File Offset: 0x234C8 - 0x234ED (38 bytes)
 * SH2 Address: 0x022234C8 - 0x022234ED
 *
 * Purpose: Inner loop of vertex transformation pipeline.
 *          Processes vertex list with flag-based large/small vertex handling.
 *
 * Note: All instructions as .short to match ROM exactly.
 */

.section .text
.p2align 1    /* 2-byte alignment for 0x234C8 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_021: Original vertex transform inner loop
 * Entry: 0x022234C8
 * ═══════════════════════════════════════════════════════════════════════════ */
func_021:
    .short  0x4F22                              /* $0234C8: STS.L PR,@-R15 */
    .short  0xBF4D                              /* $0234CA: BSR func_016 */
    .short  0x0009                              /* $0234CC: [delay] NOP */

    /* Push R7 and R8 */
    .short  0x2F76                              /* $0234CE: MOV.L R7,@-R15 */
    .short  0x2F86                              /* $0234D0: MOV.L R8,@-R15 */

    /* Setup loop: R7 = vertex count, R8 = vertex list pointer */
    .short  0xB01A                              /* $0234D2: BSR (setup, +52) */
    .short  0x4F22                              /* $0234D4: [delay] STS.L PR,@-R15 */

.loop:
    .short  0x68F6                              /* $0234D6: MOV.L @R15+,R8 */
    .short  0x67F6                              /* $0234D8: MOV.L @R15+,R7 */

    /* Check vertex flag and advance pointer */
    .short  0x8581                              /* $0234DA: MOV.W @(2,R8),R0 */
    .short  0xC801                              /* $0234DC: TST #1,R0 */
    .short  0x8F01                              /* $0234DE: BF/S .skip_large (+2) */
    .short  0x7810                              /* $0234E0: [delay] ADD #16,R8 */
.skip_large:
    .short  0x7804                              /* $0234E2: ADD #4,R8 */

    /* Loop control */
    .short  0x4710                              /* $0234E4: DT R7 (decrement and test) */
    .short  0x8BF2                              /* $0234E6: BF .loop (-28) */

    /* Restore and return */
    .short  0x4F26                              /* $0234E8: LDS.L @R15+,PR */
    .short  0x000B                              /* $0234EA: RTS */
    .short  0x0009                              /* $0234EC: [delay] NOP */

/* ============================================================================
 * End of func_021 (38 bytes = 19 words)
 * ============================================================================ */
