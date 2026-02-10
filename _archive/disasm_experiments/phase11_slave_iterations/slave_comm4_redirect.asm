/*
 * Slave SH2 COMM4 Redirect
 * 18-byte redirect to full work detection function elsewhere
 *
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: Exactly 18 bytes (9 words)
 *
 * Strategy: JMP to function in expansion ROM where we have more space
 * Target: ROM $300000+ (expansion region) or nearby gap
 */

.section .text

.global slave_comm4_redirect
slave_comm4_redirect:
    mov.l   .L_work_func,r0         /* D001: Load function address */
    jmp     @r0                     /* 402B: Jump to work function */
    nop                             /* 0009: Delay slot */
    nop                             /* 0009: Padding */
    nop                             /* 0009: Padding */
    nop                             /* 0009: Padding */

.align 4
.L_work_func:
    .long   slave_work_detector     /* Address of full function */

/*
 * Size: 6 bytes (mov.l + jmp + nop) + 8 bytes (padding NOPs) + 4 bytes (address) = 18 bytes ✓
 *
 * This redirect jumps to slave_work_detector which can be placed anywhere
 * in ROM with sufficient space (we need ~30 bytes for the full function).
 */

/* ========================================================================== */
/* Full work detector function - place in expansion ROM or larger gap        */
/* ========================================================================== */

.global slave_work_detector
slave_work_detector:
    /* Load COMM2 address */
    mov.l   .L_comm2,r0             /* 2 bytes */
    mov     #0,r2                   /* 2 bytes: Counter = 0 */

.work_check_loop:
    /* Read COMM4 (offset +4 from COMM2) */
    mov.l   @(4,r0),r1              /* 2 bytes */
    tst     r1,r1                   /* 2 bytes */
    bt      .work_check_loop        /* 2 bytes: Loop if COMM4=0 */
    nop                             /* 2 bytes: Delay slot */

    /* Work found - increment COMM2 */
    add     #1,r2                   /* 2 bytes */
    mov.l   r2,@r0                  /* 2 bytes */
    bra     .work_check_loop        /* 2 bytes: Continue checking */
    nop                             /* 2 bytes: Delay slot */

.align 4
.L_comm2:
    .long   0x20004024              /* 4 bytes */

/* Total size: 28 bytes - fits comfortably in expansion ROM */

/*
 * =================================================================
 * DEPLOYMENT STRATEGY
 * =================================================================
 *
 * Option A: Use expansion ROM at $300000+
 * - Pro: Lots of space (1MB available)
 * - Con: Need to verify SH2 can execute from this region
 * - Address: 0x06300000 (uncached) or 0x02300000 (cached)
 *
 * Option B: Use nearby ROM gap
 * - Pro: Proven execution region
 * - Con: Limited space (18 bytes at $020466)
 * - Would need to find 30-byte gap or chain multiple gaps
 *
 * Option C: Keep it even simpler - polling-only test
 * - Just increment COMM2 whenever COMM4 != 0
 * - Ultra-compact: might fit in 18 bytes with tricks
 *
 * RECOMMENDATION: Try Option C first (ultra-compact polling test)
 */
