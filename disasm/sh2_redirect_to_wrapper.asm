/* ============================================================================
 * SH2 Slave Redirection Helper
 *
 * This helper redirects Slave execution to the idle wrapper in expansion ROM.
 * Placed in gap at $020466-$020476 (18 bytes available).
 *
 * Size: 12 bytes (fits comfortably in 18-byte gap)
 * ============================================================================ */

.section .text
.align 2

.set SLAVE_IDLE_WRAPPER, 0x06300038   /* Wrapper in expansion ROM */

.globl redirect_to_wrapper

/* Jump to expansion ROM wrapper - never returns */
redirect_to_wrapper:
    mov.l   wrapper_addr, r0      /* R0 = wrapper address */
    jmp     @r0                   /* Jump (not JSR - never returns) */
    nop

.align 4

wrapper_addr:
    .long   SLAVE_IDLE_WRAPPER
