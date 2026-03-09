/* DOCUMENTATION ONLY — not used by build system.
 * Build source: func_002_case_handlers_short.asm
 *
 * WARNING: This file has documentation errors — case_2 handler has a phantom
 * EXTU.W R13,R6 ($66D5) at $023088 that doesn't exist in ROM. All addresses
 * after that point are shifted by 2 bytes. The _short.asm file has correct
 * values verified against the ROM section file.
 */
/*
 * func_002: Switch Case Handlers Block
 * ROM File Offset: 0x23070 - 0x230C7 (88 bytes)
 * SH2 Address: 0x02223070 - 0x022230C7
 *
 * Purpose: Collection of case handlers called from func_001's jump table.
 *          Processes different rendering states with various R7 parameter
 *          values, calling func_003/func_004 helper functions.
 *
 * Type: Multi-entry case handler block
 * Called By: func_001 via BSRF (jump table dispatch)
 * Calls:
 *   - func_003 @ $0230CC (data store helper)
 *   - func_004 @ $0230DC (data store variant)
 *
 * Jump Table Targets (from func_001 @ $023068):
 *   Case 0: $023070 (offset $0024 from BSRF @ $02304C)
 *   Case 2: $023088 (offset $003C)
 *   Case 4: $023094 (offset $0048)
 *   Case 6: $0230A6 (offset $005A)
 *
 * Input:
 *   R13 = State register (counter in lower word)
 *   R14 = RenderingContext pointer
 *
 * Note: This is not a single function but a block of case handlers
 *       that share common exit paths and helper calls.
 */

.section .text
.align 2

/* ═══════════════════════════════════════════════════════════════════════════
 * Case 0 Handler: Full processing path
 * Entry: $023070 (jump table offset $0024)
 * ═══════════════════════════════════════════════════════════════════════════ */
case_0_handler:
    /* $023070: 4F22 */ sts.l   pr,@-r15            /* Save return address */
    /* $023072: 5CE8 */ mov.l   @(32,r14),r12       /* R12 = context->field_0x20 */
    /* $023074: 60D5 */ extu.w  r13,r0              /* R0 = R13 & 0xFFFF */
    /* $023076: 81E1 */ mov.w   r0,@(2,r14)         /* context->field_0x02 = R0 (status) */
    /* $023078: 66D5 */ extu.w  r13,r6              /* R6 = R13 & 0xFFFF */
    /* $02307A: B02B */ bsr     func_004            /* Call func_004 @ $0230D4 */
    /* $02307C: E700 */ mov     #0,r7               /* [delay] R7 = 0 */
    /* $02307E: 66D5 */ extu.w  r13,r6              /* Refresh R6 */
    /* $023080: B028 */ bsr     func_004            /* Call func_004 again */
    /* $023082: E710 */ mov     #16,r7              /* [delay] R7 = 16 */
    /* $023084: A019 */ bra     .common_exit        /* Jump to common exit @ $0230BA */
    /* $023086: 66D5 */ extu.w  r13,r6              /* [delay] Refresh R6 */

/* ═══════════════════════════════════════════════════════════════════════════
 * Case 2 Handler: Nested processing with R6=48, R7=16
 * Entry: $023088 (jump table offset $003C)
 * ═══════════════════════════════════════════════════════════════════════════ */
case_2_handler:
    /* $023088: 66D5 */ extu.w  r13,r6              /* R6 = R13 & 0xFFFF */
    /* $02308A: 4F22 */ sts.l   pr,@-r15            /* Save return address */
    /* $02308C: E630 */ mov     #48,r6              /* R6 = 48 (0x30) */
    /* $02308E: B027 */ bsr     func_004            /* Call func_004 */
    /* $023090: E710 */ mov     #16,r7              /* [delay] R7 = 16 */
    /* $023092: A00F */ bra     .restore_and_exit   /* Exit path → $0230B2 */
    /* $023094: 4F26 */ lds.l   @r15+,pr            /* [delay] Restore PR (shared with case_4) */

/* ═══════════════════════════════════════════════════════════════════════════
 * Case 4 Handler: Two-stage processing with nested PR save
 * Entry: $023094 (jump table offset $0048)
 * ═══════════════════════════════════════════════════════════════════════════ */
case_4_handler:
    /* NOTE: Entry overlaps with case_2's delay slot! */
    /* $023094: 4F22 */ sts.l   pr,@-r15            /* Save return address */
    /* $023096: E630 */ mov     #48,r6              /* R6 = 48 */
    /* $023098: B021 */ bsr     func_004            /* Call func_004 */
    /* $02309A: E700 */ mov     #0,r7               /* [delay] R7 = 0 */
    /* $02309C: E620 */ mov     #32,r6              /* R6 = 32 */
    /* $02309E: B01E */ bsr     func_004            /* Call func_004 again */
    /* $0230A0: E710 */ mov     #16,r7              /* [delay] R7 = 16 */
    /* $0230A2: A006 */ bra     .restore_and_exit   /* Exit → $0230B0 */
    /* $0230A4: 4F26 */ lds.l   @r15+,pr            /* [delay] Restore PR */

/* ═══════════════════════════════════════════════════════════════════════════
 * Case 6 Handler: Simple single-call path
 * Entry: $0230A6 (jump table offset $005A)
 * ═══════════════════════════════════════════════════════════════════════════ */
case_6_handler:
    /* $0230A6: 4F22 */ sts.l   pr,@-r15            /* Save return address */
    /* $0230A8: E620 */ mov     #32,r6              /* R6 = 32 */
    /* $0230AA: B018 */ bsr     func_004            /* Call func_004 */
    /* $0230AC: E700 */ mov     #0,r7               /* [delay] R7 = 0 */
    /* $0230AE: A000 */ bra     .restore_pr         /* Exit → $0230B0 */
    /* $0230B0: 4F26 */ lds.l   @r15+,pr            /* [delay/target] Restore PR */

.restore_and_exit:
    /* $0230B2: 4F22 */ sts.l   pr,@-r15            /* Re-save PR for nested call */
    /* $0230B4: 60D5 */ extu.w  r13,r0              /* R0 = R13 & 0xFFFF */
    /* $0230B6: 81E1 */ mov.w   r0,@(2,r14)         /* context->field_0x02 = R0 */
    /* $0230B8: 66D5 */ extu.w  r13,r6              /* R6 = R13 & 0xFFFF */

.common_exit:
    /* $0230BA: B00B */ bsr     func_003            /* Call func_003 @ $0230D2 */
    /* $0230BC: E720 */ mov     #32,r7              /* [delay] R7 = 32 */
    /* $0230BE: C801 */ tst     #1,r0               /* Test bit 0 of result */
    /* $0230C0: E730 */ mov     #48,r7              /* R7 = 48 (for next call) */
    /* $0230C2: 8B04 */ bf      .skip_extra_call    /* Skip if bit 0 set */
    /* $0230C4: B006 */ bsr     func_003            /* Call func_003 again */
    /* $0230C6: 66D5 */ extu.w  r13,r6              /* [delay] R6 = R13 & 0xFFFF */

.skip_extra_call:
    /* $0230C8: 4F26 */ lds.l   @r15+,pr            /* Restore return address */
    /* $0230CA: 000B */ rts                         /* Return */
    /* $0230CC: 0009 */ nop                         /* Delay slot */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_003: Data Store Helper (Simple Loop)
 * Address: $0230CE - $0230DA (12 bytes)
 * Purpose: Store data words with pointer arithmetic
 * ═══════════════════════════════════════════════════════════════════════════ */
func_003:
    /* $0230CE: 37CC */ mov.l   r12,@(48,r7)        /* *(R7+48) = R12 */
    /* $0230D0: AFFA */ bra     func_003            /* Loop back (infinite?) */
    /* $0230D2: 1743 */ mov.l   r4,@(12,r7)         /* [delay] *(R7+12) = R4 */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_004: Data Store Variant
 * Address: $0230D4 - $0230E4 (16 bytes)
 * Purpose: Store multiple data values to context
 * ═══════════════════════════════════════════════════════════════════════════ */
func_004:
    /* $0230D4: 36AC */ mov.l   r10,@(48,r6)        /* *(R6+48) = R10 */
    /* $0230D6: 37CC */ mov.l   r12,@(48,r7)        /* *(R7+48) = R12 */
    /* $0230D8: 5463 */ mov.l   @(12,r6),r4         /* R4 = *(R6+12) */
    /* $0230DA: 000B */ rts                         /* Return */
    /* $0230DC: 1743 */ mov.l   r4,@(12,r7)         /* [delay] *(R7+12) = R4 */

/* Note: There appears to be more code at $0230DE-$0230E4 that's also part
 * of the overlapping function structure. The exact boundaries are complex
 * due to shared code paths and delay slot reuse.
 */

/* ============================================================================
 * ANALYSIS NOTES
 *
 * 1. Multi-Entry Architecture:
 *    This is NOT a single function but a block of case handlers that share
 *    common code paths. The jump table in func_001 dispatches to different
 *    entry points within this block.
 *
 * 2. Parameter Patterns:
 *    - R6 values: 0, 32, 48 (context offsets for different data areas)
 *    - R7 values: 0, 16, 32, 48 (output offset variations)
 *    - Different combinations produce different processing modes
 *
 * 3. Shared Exit Paths:
 *    All cases eventually converge to .common_exit which:
 *    - Calls func_003 with R7=32
 *    - Conditionally calls func_003 again with R7=48
 *    - Tests result bit 0 to decide on second call
 *
 * 4. func_003 Infinite Loop:
 *    The BRA back to itself suggests func_003 is a placeholder or
 *    requires external termination (interrupt/timeout). May be used
 *    for hardware synchronization.
 *
 * 5. Memory Layout:
 *    These functions store data at various offsets from R6/R7:
 *    - offset 12: R4 value
 *    - offset 48: R10 or R12 value
 *    Likely populating display list or transformation matrices.
 *
 * ============================================================================ */
