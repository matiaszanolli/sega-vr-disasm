# SH2 Slave Rendering - Stage 3.3: Polygon Rendering (func_033 + func_034)
# Virtua Racing Deluxe parallelization
#
# Polygon rendering with Bresenham rasterization
# This stage ties together region codes (029) and scanline fills (032)
# into complete polygon rasterization.
#
# Functions:
#   slave_func_033: Polygon rendering / scanline generator (98 bytes)
#   slave_func_034: Bresenham line rasterizer (116 bytes)

.align 2

# ============================================================================
# slave_func_033 - Polygon Rendering / Scanline Generator
# ============================================================================
# Processes each scanline of a polygon, calling func_034 to rasterize edges
# Handles clipping and bounds checking against viewport
#
# Input:  R0 = initial data
#         R1, R2 = coordinates
#         R3 = bounds/clip value
#         R9 = frame buffer pointer (Slave's region)
#         R10 = region code 1
#         R11 = region code 2
#         R12 = region step value
#         R14 = RenderingContext (read-only)
#
# Output: Polygon rasterized to frame buffer
#         R9 advanced through scanlines
#
# Uses: R0-R7, R9
# ============================================================================

.globl slave_func_033
slave_func_033:
    mov.l   r0, @r9
    mov.l   @(literal_buf033, PC), r8
    mov     r10, r0

    mov.l   @(0x14, r14), r3
    exts.w  r1, r4
    cmp/ge  r3, r4
    bt      .path_033_a

    mov     r1, r2
    add     r12, r0
    nop
    exts.w  r1, r4
    cmp/ge  r3, r4
    bf      .loop_033

.path_033_a:
    mov.l   r1, @r9
    add     #4, r9
    mov.l   @(0x18, r14), r3
    add     r12, r0
    nop

.loop_033:
    mov     r1, r2
    nop
    exts.w  r1, r4
    cmp/gt  r3, r4
    bt      .path_033_b

    mov.l   r1, @r9
    add     #4, r9
    cmp/eq  r11, r0
    bt      .exit_033

    bra     .loop_033
    add     r12, r0

.path_033_b:
    sts.l   pr, @-r15
    bsr     slave_func_034
    nop

    lds.l   @r15+, pr
    mov.l   r3, @r9
    add     #4, r9

.exit_033:
    mov     #0xFF, r0
    rts
    mov.l   r0, @r9

.align 4

literal_buf033:
    .long   0xC0000740

# ============================================================================
# slave_func_034 - Bresenham Line Rasterizer
# ============================================================================
# Rasterizes a single scanline using Bresenham line algorithm
# Performs coordinate transformation and integer division/interpolation
# Heavy use of multiply-accumulate for slope/error calculation
#
# Input:  R1, R2 = Endpoint coordinates
#         R3 = Clipping bound
#         R9 = frame buffer pointer
#
# Output: Rasterized scanline pixels written to frame buffer
#
# Registers Modified: R1-R7, MACL, MACH
# Uses: R0-R7
# ============================================================================

.globl slave_func_034
slave_func_034:
    mov.l   r0, @r9

    exts.w  r1, r4
    exts.w  r2, r5
    cmp/ge  r4, r5
    bt      .skip_swap_034

    mov     r1, r4
    mov     r2, r1
    mov     r4, r2

.skip_swap_034:
    swap.w  r1, r4
    exts.w  r4, r4
    swap.w  r2, r5
    exts.w  r5, r5
    sub     r5, r4

    mov.w   @(literal_slope034, PC), r7
    exts.w  r1, r5
    exts.w  r2, r6
    sub     r6, r5
    cmp/gt  r5, r7
    bt      .branch_034

    mov.l   @(literal_table034, PC), r7
    shll    r5
    add     r5, r7
    mov.w   @r7, r7
    muls.w  r4, r7
    exts.w  r1, r5
    exts.w  r3, r7
    sts     macl, r4
    sub     r5, r7
    shll16  r7
    shll2   r4
    nop
    extu.w  r3, r3
    swap.w  r1, r4
    sts     mach, r7
    exts.w  r4, r4
    add     r4, r7
    shll16  r7

    rts
    or      r7, r3

.branch_034:
    exts.w  r1, r5
    exts.w  r3, r7
    sub     r5, r7
    rts
    nop

.align 4

literal_slope034:
    .long   0x0106

literal_table034:
    .long   0xC00048D0

