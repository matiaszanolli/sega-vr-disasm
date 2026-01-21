/*
 * Slave SH2 Test Loop - COMM2 Increment
 * Location: ROM $02050C (SH2: 0x0602050C)
 *
 * This is the PROPER ASSEMBLY version of our test code.
 * Assembles with: sh-elf-as --isa=sh2 -o slave_test_loop.o slave_test_loop.asm
 */

.section .text
.align 2

/* Entry point at $02050C */
.global slave_comm2_test
slave_comm2_test:
    mov.l   comm2_addr,r0       /* Load COMM2 register address */
    mov     #0,r1               /* Initialize counter to 0 */

test_loop:
    add     #1,r1               /* Increment counter */
    mov.l   r1,@r0              /* Write counter to COMM2 (LONGWORD!) */
    bra     test_loop           /* Loop forever */
    nop                         /* Delay slot (executed before branch) */

/* Data section - must be 4-byte aligned for mov.l @(disp,PC) */
.align 4
comm2_addr:
    .long   0x20004024          /* COMM2 register address */

/* Padding to match original 18-byte section size */
    nop

/*
 * Binary output:
 * D002 E100 7101 2012 AFFC 0009 20004024
 *
 * Compare with dc.w version:
 * dc.w $D002, $E100, $7101, $2012, $AFFC, $0009, $2000, $4024
 *
 * Advantages of assembly version:
 * - Readable: "mov.l comm2_addr,r0" vs "$D002"
 * - Safe: Assembler catches wrong register
 * - Maintainable: Can add labels, comments, macros
 * - Debuggable: Symbols for gdb/debugging
 */
