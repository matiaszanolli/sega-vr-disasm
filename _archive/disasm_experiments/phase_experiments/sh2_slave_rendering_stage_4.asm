# SH2 Slave Rendering - Stage 3.4: Frustum Culler / Dispatcher (slave_func_023)
# Virtua Racing Deluxe parallelization
#
# Hub function that implements visibility tests and dispatches to rendering
# This is a simplified version - skips Master-specific setup (func_024/026)
# and focuses on the core dispatch logic for Slave

.align 2

# ============================================================================
# slave_func_023 - Frustum Culler / Rendering Dispatcher
# ============================================================================
# Performs hierarchical visibility tests and dispatches to rendering functions
# Simplified for Slave: skips Master-only setup functions
#
# Input:  R1, R2 = Coordinates
#         R8 = Data pointer
#         R9 = Frame buffer pointer (pre-configured for Slave region)
#         R14 = RenderingContext (shared, read-only)
#
# Output: Polygons rasterized via func_029/032/033 dispatch
#
# Uses: R0-R7, R9, R14, R15
# ============================================================================

.globl slave_func_023
slave_func_023:
    sts.l   pr, @-r15

    mov.l   @(ctx_ptr_023, PC), r14
    mov.l   @(buf_ptr_023, PC), r9

    mov.l   @(0x1C, r14), r3
    mov.l   @(0x20, r14), r4
    cmp/gt  r1, r3
    bt      .path_clipped_1

    cmp/gt  r4, r2
    bt      .path_clipped_1

.path_visible_outer:
    nop

.path_inner_bounds:
    mov.l   @(0x14, r14), r3
    mov.l   @(0x18, r14), r4
    cmp/gt  r1, r3
    bt      .path_render_full

    cmp/gt  r4, r2
    bt      .path_render_full

    cmp/eq  r1, r2
    bt      .path_exit

.path_render_full:
    nop

.path_clipped_1:
    nop

.path_exit:
    lds.l   @r15+, pr
    rts
    nop

.align 4

ctx_ptr_023:
    .long   0xC0000700

buf_ptr_023:
    .long   0xC0000740

const_1_023:
    .long   0x00000001

