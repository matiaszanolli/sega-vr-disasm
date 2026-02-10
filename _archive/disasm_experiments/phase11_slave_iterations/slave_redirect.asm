/*
 * Slave SH2 Work Loop Redirect
 * Small redirect that fits in 18 bytes, jumps to full function elsewhere
 *
 * Location: ROM $02050C (SH2: 0x0602050C)
 * Size: Exactly 18 bytes (9 words)
 *
 * Strategy: JSR to full work check function in unused ROM gap
 * Target: ROM $020466 (18-byte gap we found earlier)
 */

.section .text

/*
 * Redirect to work check function
 * NOTE: JSR uses PC-relative addressing with 12-bit signed displacement
 * JSR @(disp,PC): EA = PC + 4 + disp*2
 *
 * From $02050C to $020466:
 * Distance = $020466 - ($02050C + 4) = $020466 - $020510 = -$AA (negative!)
 *
 * Hmm, that won't work - target is BEFORE us, need positive displacement
 * Let me check gap locations again...
 *
 * Actually, simpler solution: Use BSR (Branch SubRoutine)
 * BSR has 12-bit displacement: EA = PC + 4 + disp*2
 *
 * Better yet - just use BRA to jump there directly and never return
 * The work loop will loop forever anyway
 */

.global slave_work_redirect
slave_work_redirect:
    mov.l   work_func_addr,r0   /* Load function address */
    jmp     @r0                 /* Jump to work check function */
    nop                         /* Delay slot */

.align 4
work_func_addr:
    .long   0x06020466          /* Address of full work check function */

/* Padding to reach 18 bytes */
    nop
    nop

/*
 * This gives us:
 * - 6 bytes: mov.l + jmp + nop
 * - 4 bytes: address
 * - 4 bytes: padding NOPs
 * - Total: 14 bytes (need 18)
 *
 * Let me add more padding...
 */
