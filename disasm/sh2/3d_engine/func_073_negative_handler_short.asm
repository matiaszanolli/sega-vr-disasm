/*
 * func_073: Negative Count Handler
 * ROM File Offset: 0x241D8 - 0x241E7 (16 bytes)
 * SH2 Address: 0x022241D8 - 0x022241E7
 *
 * Purpose: Alternative entry point for func_072 when element count is negative.
 *          Adjusts loop parameters and jumps into func_072's main loop.
 *
 * Type: Entry point (BRA to func_072)
 * Called By: func_072's BF at $0241B4 (when count < 0)
 * Jumps To: $0241B8 (func_072's loop)
 *
 * Operation:
 *   1. Negate R0 (make positive)
 *   2. R11 = 28 - R0 (adjusted count)
 *   3. R12 += R0 (adjust VDP pointer)
 *   4. R0 *= 8 (SHLL2 + SHLL)
 *   5. R9 += R0 (adjust dest pointer)
 *   6. BRA to func_072's loop
 */

.section .text
.p2align 1    /* 2-byte alignment for $0241D8 start */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_073: Negative Count Handler
 * Entry: 0x022241D8
 * ═══════════════════════════════════════════════════════════════════════════ */
func_073:
    .short  0x600B        /* $0241D8: NEG R0,R0 */
    .short  0xEB1C        /* $0241DA: MOV #28,R11 */
    .short  0x3B08        /* $0241DC: SUB R0,R11 */
    .short  0x3C0C        /* $0241DE: ADD R0,R12 */
    .short  0x4008        /* $0241E0: SHLL2 R0 */
    .short  0x4000        /* $0241E2: SHLL R0 */
    .short  0xAFE8        /* $0241E4: BRA $0241B8 (func_072 loop) */
    .short  0x390C        /* $0241E6: [delay] ADD R0,R9 */

/* ============================================================================
 * End of func_073 (16 bytes = 8 instructions)
 *
 * Note: This handles the case where the element count was negative.
 * It calculates how many elements to skip, adjusts the VDP read pointer
 * and destination pointer, then enters func_072's main loop.
 * ============================================================================ */
