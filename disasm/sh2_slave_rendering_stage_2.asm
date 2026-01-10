# SH2 Slave Rendering - Stage 3.2: Scanline Fill (func_032)
# Virtua Racing Deluxe parallelization
#
# Tight loop for filling scanlines with pixels
# This is the first frame buffer writing function for Slave

.align 2

# ============================================================================
# slave_func_032 - Scanline Fill Loop
# ============================================================================
# Fills a scanline region with pixel data from R1
# Writes to Slave's frame buffer region (lower half of screen)
#
# Input:  R1  = Pixel data (color/value to write)
#         R9  = Frame buffer write pointer (starts at Slave region)
#         R10 = Current region code (loop counter)
#         R11 = Target region code (loop end marker)
#         R12 = Step value (region increment per iteration)
#
# Output: Frame buffer filled at R9 region
#         R9 advanced to next scanline
#         R10 updated to match R11
#
# Registers: R0 (temp), R9 (pointer), R10 (counter), R12 (step)
# Uses: R0, R1, R9, R10, R11, R12
# ============================================================================

.globl slave_func_032
slave_func_032:
    mov     r10, r0

.fill_loop:
    mov.l   r1, @r9
    cmp/eq  r11, r0
    bt/s    .fill_done
    add     #4, r9

    add     r12, r0
    bra     .fill_loop
    nop

.fill_done:
    mov     #0xFF, r0
    rts
    mov.l   r0, @r9

.align 2

# ============================================================================
# Placeholder functions for stages 3.3 and 3.4
# ============================================================================

.globl slave_func_033
slave_func_033:
    rts
    nop

.globl slave_func_023
slave_func_023:
    rts
    nop
