/* DOCUMENTATION ONLY — not used by build system.
 * Build sources: individual func_040..059_*_short.asm files
 */
/*
 * func_040 - func_059: Display Engine Functions
 * ROM File Offset: 0x2385A - 0x23DD6 (~1404 bytes, ~20 functions)
 * SH2 Address Range: 0x0222385A - 0x02223DD6
 *
 * This region contains the display list processing and polygon rendering
 * engine. Functions are densely packed with shared code paths.
 *
 * Major Function Entry Points (identified by STS.L PR,@-R15):
 *   func_040: 0x0222385E - Display list setup
 *   func_041: 0x022239F0 - Main render coordinator
 *   func_042: 0x02223A52 - VDP data copy helper
 *   func_043: 0x02223A70 - Polygon batch processor (documented in call graph)
 *   func_044: 0x02223BA8 - Edge/scan processor
 *   func_045-059: Various render helpers and edge cases
 */

.section .text
.align 2

/* ═══════════════════════════════════════════════════════════════════════════
 * func_040: Display List Buffer Setup
 * Entry: 0x0222385E
 * Size: ~146 bytes
 *
 * Purpose: Initialize display list buffers at VDP addresses 0xC00007C0
 *          and 0xC00007E0. Copies polygon data from context to VDP.
 *
 * Input:
 *   R5  = Status flags pointer
 *   R14 = Context pointer (@+0x24 = source data)
 *
 * Output:
 *   VDP display buffers initialized
 *   R6 state mask updated and stored back
 * ═══════════════════════════════════════════════════════════════════════════ */
func_040:
    mov.l   @(.vdp_buf_a,pc),r8     /* R8 = 0xC00007C0 */
    mov.l   @(.vdp_buf_b,pc),r9     /* R9 = 0xC00007E0 */
    mov.l   @(0x24,r14),r6          /* R6 = context->display_data */
    mov.l   @(.flag_mask,pc),r1     /* R1 = flag mask */
    or      r6,r1                   /* Combine flags */
    mov.b   r0,@(14,r5)             /* Store to status */

    /* Wait for VDP ready (C808 = TST #$08,R0) */
.wait_vdp:
    bt      .wait_vdp

    mov     r6,r10                  /* R10 = source A */
    mov     r6,r11                  /* R11 = source B */
    add     #0x20,r11               /* R11 += 32 (offset for second buffer) */

    mov.b   r0,@(2,r5)              /* Status update */
    cmp/eq  #0,r0                   /* Check terminator */
    bt/s    .process_b
    mov     r0,r3                   /* R3 = index */

    /* Jump table dispatch based on R3 value */
    /* Entries handle different polygon types */
    /* ... */

.copy_loop_a:
    mov.l   @r8+,r0                 /* Read from VDP A */
    cmp/eq  #0xFF,r0                /* Check terminator */
    bt      .done_a
    mov.l   r0,@r10                 /* Write to buffer A */
    bra     .copy_loop_a
    add     #4,r10

.done_a:
    /* Process buffer B similarly */
    /* ... */

.process_b:
    mov.l   @r9+,r0                 /* Read from VDP B */
    cmp/eq  #0xFF,r0                /* Check terminator */
    bt      .done_all
    mov.l   r0,@r11                 /* Write to buffer B */
    bra     .process_b
    add     #4,r11

.done_all:
    /* Final status update */
    mov.b   r0,@(0,r5)
    mov.b   r0,@(15,r1)
    mov     #4,r0
    mov.b   r0,@(14,r1)
    /* Update state mask */
    mov.w   @(.state_mask,pc),r0
    add     #0x40,r6
    and     r0,r6
    rts
    mov.l   r6,@(0x24,r14)

.align 2
.vdp_buf_a:
    .long   0xC00007C0
.vdp_buf_b:
    .long   0xC00007E0
.flag_mask:
    .long   0x20000000
.state_mask:
    .word   0xFFBF                  /* Mask off bit 6 */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_041: Main Render Coordinator
 * Entry: 0x022239F0
 * Size: ~94 bytes
 *
 * Purpose: Coordinates the rendering pipeline by calling:
 *          - Hardware init subroutine
 *          - Data copy helper (func_042)
 *          - Main processing loop
 *          Includes the tertiary delay loop (16 iterations)
 *
 * Input:
 *   R14 = Context pointer
 *
 * Flow:
 *   1. JSR to hardware init @ 0x02223A2C
 *   2. BSR to func_042 (data copy)
 *   3. BSR to GBR setup routine
 *   4. Check status flags
 *   5. If needed, execute 16-iteration delay loop
 *   6. Return to caller
 * ═══════════════════════════════════════════════════════════════════════════ */
func_041:
    sts.l   pr,@-r15                /* Save return address */
    mov.l   @(.hw_init,pc),r0       /* Hardware init routine */
    jsr     @r0
    nop
    bsr     func_042                /* Data copy helper */
    nop
    bsr     .gbr_setup              /* GBR register setup */
    nop
    mov.l   @(.status_mask,pc),r0
    mov.l   @(0x24,r14),r1          /* Status flags */
    or      r0,r1
    mov.b   r0,@(14,r5)
    /* C804 = TST #$04,R0 */
    bt      .delay_done
    /* C802 = TST #$02,R0 */
    bf      .skip_delay

    /* Execute delay and branch back */
    /* ... complex branching ... */

.delay_16:
    mov     #0x10,r7                /* 16 iterations */
.delay_loop:
    dt      r7                      /* Decrement */
    bf      .delay_loop             /* Loop until zero */
    bra     .continue
    nop

.delay_done:
.skip_delay:
    /* ... */

.continue:
    lds.l   @r15+,pr
    rts
    nop

.align 2
.hw_init:
    .long   0x060045CC              /* Hardware init routine address (SDRAM) */
.status_mask:
    .long   0x20000000              /* Bit 29 status mask */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_042: VDP Data Copy Helper
 * Entry: 0x02223A52
 * Size: ~24 bytes
 *
 * Purpose: Copy 145 (0x91) longwords from SDRAM to VDP registers
 *
 * Input:
 *   None (uses fixed addresses from constants)
 *
 * Output:
 *   145 longwords copied to VDP @ 0xC0000000
 * ═══════════════════════════════════════════════════════════════════════════ */
func_042:
    mov.l   @(.vdp_dest,pc),r1      /* R1 = 0xC0000000 */
    mov.l   @(.sdram_src,pc),r0     /* R0 = 0x06003A70 */
    mov.w   @(.copy_count,pc),r7    /* R7 = 0x91 = 145 */

.copy_loop:
    mov.l   @r0+,r2                 /* Read from SDRAM */
    mov.l   r2,@r1                  /* Write to VDP */
    dt      r7                      /* Decrement counter */
    bf/s    .copy_loop              /* Loop if not zero */
    add     #4,r1                   /* Advance dest pointer */
    rts
    nop

.align 2
.copy_count:
    .word   0x0091                  /* 145 longwords */
.vdp_dest:
    .long   0xC0000000
.sdram_src:
    .long   0x06003A70

/* ═══════════════════════════════════════════════════════════════════════════
 * func_043: Polygon Batch Processor
 * Entry: 0x02223A70
 * Size: ~200 bytes
 *
 * Purpose: Process batches of polygon data, performing edge interpolation
 *          and visibility calculations. This is the main polygon rendering
 *          workhorse function.
 *
 * Input:
 *   R5  = Status/flag pointer
 *   R14 = Context pointer
 *         @+0x24 = source data pointer
 *
 * Algorithm:
 *   1. Initialize output buffers at VDP addresses
 *   2. Loop through polygon vertex pairs
 *   3. For each pair:
 *      - Check visibility (CMP/PZ)
 *      - Calculate edge deltas
 *      - Apply MULS.W for interpolation
 *      - Store results
 *   4. Terminate when negative value encountered
 *
 * Uses:
 *   - Fixed-point arithmetic (SHLL16, MULS.W)
 *   - Reciprocal lookup table at 0x060048D0
 *   - MAC register for multiply-accumulate
 * ═══════════════════════════════════════════════════════════════════════════ */
func_043:
    sts.l   pr,@-r15                /* Save return address */
    mov.l   @(.init_val,pc),r1      /* Initialization value */
    mov.l   @(0x24,r14),r8          /* R8 = source polygon data */
    mov     #0,r0                   /* Clear accumulator */
    or      r8,r1                   /* Combine addresses */
    mov.l   r0,@r1                  /* Clear output[0] */
    mov.l   r0,@(16,r1)             /* Clear output[4] */
    mov.l   r0,@(32,r1)             /* Clear output[8] */
    mov.l   r0,@(48,r1)             /* Clear output[12] */
    mov     r8,r9                   /* R9 = secondary pointer */
    add     #0x20,r9                /* R9 += 32 (second vertex stream) */

    /* Alignment NOPs for loop optimization */
    nop
    nop
    nop
    nop

.vertex_loop:
    mov.w   @r8+,r1                 /* R1 = X1 */
    mov.w   @r8+,r2                 /* R2 = Y1 */
    cmp/pz  r1                      /* X1 >= 0? (visible) */
    bf      .done_batch             /* If negative, end of batch */
    mov.b   r0,@(1,r5)              /* Update status */
    mov     r2,r5                   /* Save Y1 */
    cmp/eq  r0,r2                   /* Y1 == 0? */
    bt      .vertex_loop            /* Skip if zero */
    sub     r0,r2                   /* R2 = Y1 - 0 = Y1 */
    cmp/pl  r2                      /* Y1 > 0? */
    bt      .done_batch             /* If positive only, done */

    /* Calculate interpolation */
    mov.l   @(.recip_table,pc),r0   /* Reciprocal table */
    neg     r2,r6                   /* R6 = -Y1 (delta) */
    shll    r2                      /* R2 *= 2 (table index) */
    /* ... lookup and multiply ... */
    mov.b   r0,@(0,r5)
    mov     r1,r12                  /* R12 = X1 */
    shll16  r12                     /* R12 <<= 16 (fixed point) */
    sub     r0,r1                   /* Adjust X1 */
    muls.w  r1,r3                   /* Multiply for interpolation */

    /* Process second vertex stream */
    mov.w   @r9+,r1                 /* Read X2 */
    mov.w   @r9+,r2                 /* Read Y2 */
    cmp/pz  r1                      /* X2 >= 0? */
    bf      .done_batch
    mov.b   r0,@(1,r5)
    /* ... continue processing ... */

    /* Loop continues until terminator */

.done_batch:
    lds.l   @r15+,pr                /* Restore return address */
    rts
    nop

.align 2
.init_val:
    .long   0x40000000              /* Initialization constant (bit 30) */
.recip_table:
    .long   0x060048D0              /* Reciprocal lookup table */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_044 - func_059: Additional Render Helpers
 *
 * The remaining functions in this region handle:
 * - Edge case polygon processing
 * - Clipping boundary conditions
 * - Alternative rendering paths for different polygon types
 * - VDP register setup variants
 *
 * These are highly interconnected with shared code paths and
 * fallthrough logic. Full translation would require careful
 * control flow analysis.
 *
 * Notable patterns:
 * - Jump tables for polygon type dispatch
 * - Conditional delay loops for timing
 * - MAC register usage for fixed-point math
 * - VDP register polling (C808, C804, C802 = TST #imm,R0)
 * ═══════════════════════════════════════════════════════════════════════════ */

/*
 * Analysis Notes:
 *
 * This 1.4KB region contains the heart of the 3D polygon rendering engine.
 * Key characteristics:
 *
 * 1. Display List Architecture:
 *    - Two parallel buffers (A @ 0xC00007C0, B @ 0xC00007E0)
 *    - Polygons processed in pairs for edge interpolation
 *    - 0xFF terminator marks end of display list
 *
 * 2. Fixed-Point Math:
 *    - 16.16 format (SHLL16 for conversion)
 *    - MULS.W for 16×16→32 multiplication
 *    - Reciprocal table at 0x060048D0 for division
 *
 * 3. Visibility Testing:
 *    - CMP/PZ checks if coordinate >= 0
 *    - Negative values indicate clipped/hidden polygons
 *    - Status flags stored to @(N,R5) for later use
 *
 * 4. VDP Synchronization:
 *    - TST #$08,R0 (C808) polls VDP busy flag
 *    - Delay loops ensure timing requirements met
 *    - Direct writes to 0xC0000xxx VDP register space
 *
 * 5. The 16-iteration delay loop at 0x02223A48-0x02223A4C
 *    is the tertiary hotspot (1.48% of Slave cycles).
 *
 * End of display engine functions
 */
