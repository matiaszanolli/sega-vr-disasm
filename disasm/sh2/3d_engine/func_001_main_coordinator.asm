/* DOCUMENTATION ONLY — not used by build system.
 * Build source: func_001_main_coordinator_short.asm
 */
/*
 * func_001: Main Coordinator / Switch Dispatcher
 * ROM File Offset: 0x23024 - 0x2306F (76 bytes including jump table)
 * SH2 Address: 0x02223024 - 0x0222306F
 *
 * Purpose: Central dispatch function for 3D engine operations.
 *          Uses a jump table to route processing based on state flags.
 *          Has two entry points calling different setup functions.
 *
 * Type: Coordinator/Dispatcher
 * Called By: Higher-level rendering loop
 * Calls:
 *   - func_003 @ $023176 (via entry A)
 *   - func_002 @ $0230E6 (via entry B)
 *   - Case handlers via jump table
 *
 * Entry Points:
 *   A: $023024 - Calls func_003 first
 *   B: $02302E - Calls func_002 first
 *
 * Input:
 *   R13 = State/mode register (upper byte contains dispatch index)
 *   R14 = RenderingContext pointer
 *
 * Jump Table Dispatch:
 *   Index extracted from R13 upper byte, masked to 0,2,4,6,8,10
 *   Index 12,14 cause immediate exit (invalid/done state)
 *
 * Stack Usage:
 *   Saves: PR (for BSR/BSRF calls)
 */

.section .text
.align 2

/* ─────────────────────────────────────────────────────────────────────────────
 * Entry Point A: Call func_003 (setup variant A)
 * ───────────────────────────────────────────────────────────────────────────── */
func_001_entry_a:
    /* $023024: 4F22 */ sts.l   pr,@-r15            /* Save return address */
    /* $023026: B0A7 */ bsr     func_003            /* Call setup function A → $023176 */
    /* $023028: 7D02 */ add     #2,r13              /* [delay] R13 += 2 (advance state) */
    /* $02302A: A003 */ bra     .main_dispatch      /* Jump to main dispatch logic */
    /* $02302C: 0009 */ nop                         /* Delay slot */

/* ─────────────────────────────────────────────────────────────────────────────
 * Entry Point B: Call func_002 (setup variant B)
 * ───────────────────────────────────────────────────────────────────────────── */
func_001_entry_b:
    /* $02302E: 4F22 */ sts.l   pr,@-r15            /* Save return address */
    /* $023030: B05A */ bsr     func_002            /* Call setup function B → $0230E6 */
    /* $023032: 7D02 */ add     #2,r13              /* [delay] R13 += 2 (advance state) */

/* ─────────────────────────────────────────────────────────────────────────────
 * Main Dispatch: Load context and switch on state
 * ───────────────────────────────────────────────────────────────────────────── */
.main_dispatch:
    /* $023034: 5AEB */ mov.l   @(44,r14),r10       /* R10 = context->field_0x2C (output ptr?) */
    /* $023036: 5BE9 */ mov.l   @(36,r14),r11       /* R11 = context->field_0x24 (data ptr?) */

    /* Extract dispatch index from R13 upper byte */
    /* $023038: 69D5 */ extu.w  r13,r9              /* R9 = R13 & 0xFFFF */
    /* $02303A: 6098 */ swap.w  r9,r0               /* R0 = upper word of R9 (state byte) */
    /* $02303C: C90E */ and     #14,r0              /* R0 &= 14 (valid: 0,2,4,6,8,10,12,14) */

    /* Check for exit condition */
    /* $02303E: 880C */ cmp/eq  #12,r0              /* Is index == 12? (done state) */
    /* $023040: 890F */ bt      .exit               /* Exit if done */

    /* Jump table dispatch */
    /* $023042: 6103 */ mov     r0,r1               /* R1 = index (0,2,4,6,8,10) */
    /* $023044: C708 */ mova    .jump_table,r0      /* R0 = address of jump table */
    /* $023046: 011D */ mov.w   @(r0,r1),r1         /* R1 = jump_table[index/2] (word offset) */
    /* $023048: 0103 */ bsrf    r1                  /* Call: PC+4+R1 */
    /* $02304A: 0009 */ nop                         /* Delay slot */

    /* ─────────────────────────────────────────────────────────────────────
     * After case handler returns: Check loop condition
     * ───────────────────────────────────────────────────────────────────── */
    /* $02304C: 6093 */ mov.w   @r9,r0              /* Load status word from R9 */
    /* $02304E: C801 */ tst     #1,r0               /* Test bit 0 */
    /* $023050: 8B03 */ bf      .path_b             /* Branch if bit 0 set */

    /* Path A: Continue with func_xxx */
    /* $023052: B0C9 */ bsr     func_loop_helper_a  /* Call helper A → $0231E0 approx */
    /* $023054: 85E1 */ mov.w   @(2,r14),r0         /* [delay] Load context->field_0x02 */
    /* $023056: AFF0 */ bra     .main_dispatch      /* Loop back to dispatch */
    /* $023058: 69D5 */ extu.w  r13,r9              /* [delay] Refresh R9 from R13 */

.path_b:
    /* Path B: Continue with func_yyy */
    /* $02305A: B0D4 */ bsr     func_loop_helper_b  /* Call helper B → $0231FE approx */
    /* $02305C: 85E1 */ mov.w   @(2,r14),r0         /* [delay] Load context->field_0x02 */
    /* $02305E: AFEC */ bra     .main_dispatch      /* Loop back to dispatch */
    /* $023060: 69D5 */ extu.w  r13,r9              /* [delay] Refresh R9 from R13 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Exit: Save state and return
 * ───────────────────────────────────────────────────────────────────────────── */
.exit:
    /* $023062: 4F26 */ lds.l   @r15+,pr            /* Restore return address */
    /* $023064: 000B */ rts                         /* Return */
    /* $023066: 1EB9 */ mov.l   r11,@(36,r14)       /* [delay] Save R11 to context->field_0x24 */

/* ─────────────────────────────────────────────────────────────────────────────
 * Jump Table: Word offsets from $02304C
 * ───────────────────────────────────────────────────────────────────────────── */
.align 2
.jump_table:
    /* $023068: */ .word   0x0024      /* Index 0: → $023070 (case_0) */
    /* $02306A: */ .word   0x003C      /* Index 2: → $023088 (case_2) */
    /* $02306C: */ .word   0x0048      /* Index 4: → $023094 (case_4) */
    /* $02306E: */ .word   0x005A      /* Index 6: → $0230A6 (case_6) */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Dual Entry Point Pattern:
 *    - Entry A ($023024): Calls func_003, then dispatches
 *    - Entry B ($02302E): Calls func_002, then dispatches
 *    Both advance R13 by 2 after their setup call
 *
 * 2. State Machine via Jump Table:
 *    - R13 upper byte encodes current state (0,2,4,6,8,10)
 *    - State 12 signals completion/exit
 *    - Each state calls a case handler via BSRF
 *
 * 3. Loop Structure:
 *    After each case handler returns, checks bit 0 of status word
 *    and either takes path A or path B before looping back.
 *
 * 4. Context Fields Used:
 *    - context+2  (field_0x02): Status/control word
 *    - context+36 (field_0x24): Data pointer (R11)
 *    - context+44 (field_0x2C): Output pointer (R10)
 *
 * 5. Jump Table Targets (from $02304C + offset):
 *    - Case 0: $023070 - First processing mode
 *    - Case 2: $023088 - Second processing mode
 *    - Case 4: $023094 - Third processing mode
 *    - Case 6: $0230A6 - Fourth processing mode
 *
 * 6. This appears to be the top-level coordinator for a multi-pass
 *    rendering algorithm, where each state handles a different
 *    phase of the 3D pipeline (transform, cull, sort, render?).
 *
 * ============================================================================ */
