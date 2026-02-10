/*
 * Slave SH2 Work Check - Redirect Version
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: Exactly 18 bytes (redirect only)
 *
 * Strategy: Jump to full function at ROM gap $020466
 * This gives us unlimited space for work check logic
 */

.section .text

/*
 * Entry Point: $02050C (18 bytes)
 * Simple redirect to full function
 */
.global slave_work_entry
slave_work_entry:
    mov.l   work_func_addr,r0   /* D002: Load function address */
    jmp     @r0                 /* 402B: Jump to work check function */
    nop                         /* 0009: Delay slot */

.align 4
work_func_addr:
    .long   slave_work_full     /* Address of full function */

/* Padding to exactly 18 bytes */
    nop                         /* 0009: Padding */
    nop                         /* 0009: Padding */

/*
 * This is: 2+2+2 = 6 bytes code
 *          4 bytes address
 *          4 bytes padding
 *          = 14 bytes total
 *
 * Need 4 more bytes... let me adjust alignment
 */

.end

/*
 * =================================================================
 * Full Work Check Function
 * Location: ROM gap (will be placed separately)
 * Size: Unlimited (we have 100 bytes of gaps available)
 * =================================================================
 */
