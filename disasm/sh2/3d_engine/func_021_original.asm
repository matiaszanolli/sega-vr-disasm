/* DOCUMENTATION ONLY — not used by build system.
 * Build source: func_021_original_short.asm
 */
/*
 * func_021: Vertex Transform Entry Point (ORIGINAL)
 * ROM File Offset: 0x234C8 - 0x234EC (36 bytes)
 * SH2 Address: 0x022234C8
 *
 * Purpose: Top-level vertex transformation function called during quad
 *          rendering. Processes a batch of vertices by calling func_016
 *          (coordinate packing) and a nested function for each vertex.
 *
 * This is the PRIMARY OPTIMIZATION TARGET for parallel processing.
 * The optimized version (func_021_optimized at $300100) inlines func_016.
 *
 * Call Context:
 *   Called from: Rendering pipeline (likely func_020 or dispatch)
 *   Frequency: Once per quad batch (~800 quads/frame)
 *
 * Input:
 *   R14 = RenderingContext pointer (passed to func_016)
 *   R7  = Loop counter (number of iterations)
 *   R8  = Data pointer (vertex data)
 *   R5  = Output pointer
 *
 * Stack Usage:
 *   Saves: PR, R7, R8 (nested calls clobber these)
 *
 * Calls:
 *   func_016 @ $0222335A - Coordinate packing (via BSR)
 *   Nested func @ $0222350A - Per-vertex processing (via BSR)
 */

.section .text
.align 2

func_021:
    /* ─────────────────────────────────────────────────────────────────────
     * Entry: Save PR and call func_016 for coordinate setup
     * ───────────────────────────────────────────────────────────────────── */
    /* $0234C8: 4F22 */ sts.l   pr,@-r15            /* Save return address */
    /* $0234CA: BF4D */ bsr     func_016            /* Call coord packing */
    /* $0234CC: 0009 */ nop                         /* Delay slot */

    /* ─────────────────────────────────────────────────────────────────────
     * Main Loop: Process each vertex
     * ───────────────────────────────────────────────────────────────────── */
.loop_start:
    /* $0234CE: 2F76 */ mov.l   r7,@-r15            /* Save loop counter */
    /* $0234D0: 2F86 */ mov.l   r8,@-r15            /* Save data pointer */

    /* Call nested processing function */
    /* $0234D2: B01A */ bsr     nested_func         /* BSR forward +0x34 → $02350A */
    /* $0234D4: 4F22 */ sts.l   pr,@-r15            /* [delay] Save PR for nested call */

    /* Restore saved registers */
    /* $0234D6: 68F6 */ mov.l   @r15+,r8            /* Restore R8 */
    /* $0234D8: 67F6 */ mov.l   @r15+,r7            /* Restore R7 */

    /* ─────────────────────────────────────────────────────────────────────
     * Post-processing: Check result and adjust data pointer
     * ───────────────────────────────────────────────────────────────────── */
    /* $0234DA: 8581 */ mov.w   @(2,r8),r0          /* Load control word from data+2 */
    /* $0234DC: C801 */ tst     #1,r0               /* Test bit 0 */
    /* $0234DE: 8F01 */ bf/s    .skip_extra         /* Skip if bit set (T=0) */
    /* $0234E0: 7810 */ add     #16,r8              /* [delay] Advance data ptr by 16 */
    /* $0234E2: 7804 */ add     #4,r8               /* Extra 4 bytes if bit clear */

.skip_extra:
    /* $0234E4: 4710 */ dt      r7                  /* Decrement R7, set T if zero */
    /* $0234E6: 8BF2 */ bf      .loop_start         /* Loop if R7 != 0 */

    /* ─────────────────────────────────────────────────────────────────────
     * Exit: Restore PR and return
     * ───────────────────────────────────────────────────────────────────── */
    /* $0234E8: 4F26 */ lds.l   @r15+,pr            /* Restore return address */
    /* $0234EA: 000B */ rts
    /* $0234EC: 0009 */ nop                         /* Delay slot */

/* ============================================================================
 * OPTIMIZATION NOTES
 *
 * 1. BSR Overhead:
 *    - func_016 call: 4 cycles (BSR + NOP)
 *    - nested_func call: 4 cycles (BSR + STS.L)
 *    - Returns add: ~4 cycles each
 *    - Total call overhead: ~16 cycles per iteration
 *
 * 2. Loop Count:
 *    - R7 initial value determines iterations
 *    - At 800 quads/frame with multiple verts each: high frequency
 *
 * 3. Inlining Opportunity:
 *    - func_016 is only 34 bytes (17 instructions)
 *    - Inlining saves: BSR (2) + NOP (2) + RTS (2) + NOP (2) = 6 cycles
 *    - Already done in func_021_optimized at $300100
 *
 * 4. Parallel Processing:
 *    - This function is CPU-bound (no I/O waits)
 *    - Can be offloaded to Slave SH2 while Master handles dispatch
 *    - Infrastructure ready: trampoline → COMM7 signal → Slave execution
 *
 * ============================================================================
 * HOOK STATUS (Current: DISABLED)
 *
 * When enabled, func_021 is replaced by a trampoline that:
 * 1. Captures parameters (R14, R7, R8, R5) to shared memory at $2203E000
 * 2. Signals Slave via COMM7 = 0x16
 * 3. Returns immediately (Master continues with other work)
 * 4. Slave executes func_021_optimized at $300100
 *
 * See: expansion_300000.asm for slave_work_wrapper and slave_test_func
 * ============================================================================ */
