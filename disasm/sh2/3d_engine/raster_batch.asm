/*
 * func_060, func_061, func_062, func_063: Rasterization Batch Processors
 * ROM File Offset: 0x23DD8 - 0x23EC6 (~238 bytes total)
 * SH2 Addresses:
 *   func_060: 0x02223DD8
 *   func_061: 0x02223E48
 *   func_062: 0x02223E64
 *   func_063: 0x02223E90
 *
 * Purpose: Batch data copy coordinators for rasterization.
 *          Each function calls func_065 (unrolled data copy) multiple times
 *          to fill scanline buffers for polygon rendering.
 *
 * Common Pattern:
 *   1. Save PR (function prologue)
 *   2. Load destination pointer from context @(4,R14)
 *   3. Add offset and set R10 (source base)
 *   4. Call func_065 repeatedly with different index values
 *   5. Advance output pointer R9 by 8 bytes between calls
 *   6. Restore PR and return
 *
 * Input:
 *   R4  = Output index storage pointer
 *   R14 = Context pointer (@+4 = destination base)
 *
 * Output:
 *   Fills multiple 112-byte blocks via func_065 calls
 */

.section .text
.align 2

/* ═══════════════════════════════════════════════════════════════════════════
 * func_060: Extended Rasterization Batch (10+ calls to func_065)
 * Entry: 0x02223DD8
 * Size: ~112 bytes
 * ═══════════════════════════════════════════════════════════════════════════ */
func_060:
    sts.l   pr,@-r15                /* Save return address */
    mov.l   @(4,r14),r9             /* R9 = context->dest_base */
    mov.w   @(.offset_060,pc),r0    /* R0 = offset (0x0400) */
    add     r0,r9                   /* R9 += offset */
    mov.l   @(.src_060,pc),r10      /* R10 = source base (0x06003E3C) */
    mov.b   r0,@(1,r4)              /* Store index */
    shll2   r0                      /* R0 <<= 2 (scale) */
    /* ... conditional call setup ... */
    mov.b   r0,@(8,r4)              /* Store scaled index */
    cmp/eq  #0,r0                   /* Check if zero */
    bt      .skip_060_1             /* Skip if zero */
    bsr     func_065                /* Call data copy */
    nop
.skip_060_1:
    add     #8,r9                   /* Advance output */
    mov.b   r0,@(9,r4)              /* Store index */
    cmp/eq  #0,r0
    bt      .skip_060_2
    bsr     func_065
    nop
.skip_060_2:
    add     #8,r9
    bsr     func_065
    mov.b   r0,@(10,r4)
    add     #8,r9
    bsr     func_065
    mov     #10,r0                  /* R0 = 0x0A (index 10) */
    add     #8,r9
    bsr     func_065
    mov.b   r0,@(11,r4)
    add     #8,r9
    bsr     func_065
    mov.b   r0,@(12,r4)
    add     #8,r9
    bsr     func_065
    mov     #11,r0                  /* R0 = 0x0B (index 11) */
    add     #8,r9
    bsr     func_065
    mov.b   r0,@(13,r4)
    add     #8,r9
    bsr     func_065
    mov.b   r0,@(14,r4)
    add     #8,r9
    bsr     func_065
    mov.b   r0,@(15,r4)
    lds.l   @r15+,pr                /* Restore return address */
    rts
    nop

.align 2
.offset_060:
    .word   0x0400
    .word   0x0000                  /* Padding */
.src_060:
    .long   0x06003E3C              /* Source base in SDRAM */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_061: Simple Rasterization Batch (2 calls to func_065)
 * Entry: 0x02223E48
 * Size: ~28 bytes
 * ═══════════════════════════════════════════════════════════════════════════ */
func_061:
    sts.l   pr,@-r15                /* Save return address */
    mov.l   @(4,r14),r9             /* R9 = context->dest_base */
    mov.l   @(.src_061,pc),r10      /* R10 = source base (0x060086D4) */
    bsr     func_065                /* First copy */
    mov.b   r0,@(10,r4)
    add     #8,r9                   /* Advance output */
    bsr     func_065                /* Second copy */
    mov.b   r0,@(11,r4)
    lds.l   @r15+,pr                /* Restore return address */
    rts
    nop

.align 2
.src_061:
    .long   0x060086D4              /* Source base in SDRAM */

/* ═══════════════════════════════════════════════════════════════════════════
 * func_062: Conditional Rasterization Batch (2-3 calls to func_065)
 * Entry: 0x02223E64
 * Size: ~44 bytes
 * ═══════════════════════════════════════════════════════════════════════════ */
func_062:
    sts.l   pr,@-r15                /* Save return address */
    mov.l   @(4,r14),r9             /* R9 = context->dest_base */
    mov.w   @(.offset_062,pc),r0    /* R0 = offset */
    add     r0,r9                   /* R9 += offset */
    mov.l   @(.src_062,pc),r10      /* R10 = source base */
    mov.b   r0,@(1,r4)              /* Store index */
    shll2   r0                      /* Scale */
    /* $0AAE = STS MACL,R10 or similar */
    mov.b   r0,@(10,r4)
    cmp/eq  #0,r0                   /* Check if zero */
    bt      .skip_062               /* Skip if zero */
    bsr     func_065
    nop
.skip_062:
    add     #8,r9
    bsr     func_065
    mov.b   r0,@(11,r4)
    lds.l   @r15+,pr
    rts
    nop

.align 2
.offset_062:
    .word   0x0400
.src_062:
    .long   0x06003E3C

/* ═══════════════════════════════════════════════════════════════════════════
 * func_063: Extended Conditional Batch (2-4 calls to func_065)
 * Entry: 0x02223E90
 * Size: ~54 bytes
 * ═══════════════════════════════════════════════════════════════════════════ */
func_063:
    sts.l   pr,@-r15                /* Save return address */
    mov.l   @(4,r14),r9             /* R9 = context->dest_base */
    mov.w   @(.offset_063,pc),r0    /* R0 = offset (0x0400) */
    add     r0,r9                   /* R9 += offset */
    mov.l   @(.src_063,pc),r10      /* R10 = source base */
    mov.b   r0,@(1,r4)              /* Store index */
    shll2   r0                      /* Scale */
    /* $0AAE instruction */
    mov     #0,r12                  /* R12 = 0 (flag) */
    mov.b   r0,@(9,r4)
    cmp/eq  #0,r0
    bt      .skip_063_1
    bsr     func_065
    mov     #1,r12                  /* R12 = 1 (flag set) */
.skip_063_1:
    add     #8,r9
    mov.b   r0,@(10,r4)
    cmp/pl  r12                     /* Test if R12 > 0 */
    bt      .do_063_2               /* If flag set, do copy */
    cmp/eq  #0,r0
    bt      .skip_063_2
.do_063_2:
    bsr     func_065
    mov     #1,r12
.skip_063_2:
    add     #8,r9
    bsr     func_065
    mov.b   r0,@(11,r4)
    lds.l   @r15+,pr
    rts
    nop

.align 2
.offset_063:
    .word   0x0400
    .word   0x0000                  /* Padding */
.src_063:
    .long   0x06003E3C

/*
 * Analysis Notes:
 *
 * These four functions are the primary callers of func_065 (hot data copy).
 * They coordinate batch memory transfers for rasterization buffers:
 *
 * Pattern Analysis:
 * - func_060: Most calls (~10), fills extensive scanline buffer
 * - func_061: Minimal (2 calls), simple case
 * - func_062: Conditional (2-3 calls), with skip logic
 * - func_063: Extended conditional (2-4 calls), with flag tracking
 *
 * Source Data:
 * - Multiple source bases in SDRAM (0x06003E3C, 0x060086D4, etc.)
 * - These contain pre-computed texture or gradient data
 *
 * Output:
 * - Index values stored to @(N,R4) for later processing
 * - R9 output pointer advances by 8 bytes per func_065 call
 * - Total output: func_060 fills ~80 bytes, others less
 *
 * Performance:
 * - Each func_065 call copies 112 bytes (14 × 8)
 * - func_060 alone copies ~1120 bytes per invocation
 *
 * End of func_060-063
 */
