# SH2 Slave Engine - Consolidated (Phase 3.5+)
# Virtua Racing Deluxe parallelization
# All rendering stages in one file with proper symbol resolution

.set SYNC_BASE, 0x22000400
.set MASTER_READY_OFFSET, 0x00
.set SLAVE_READY_OFFSET, 0x04
.set MASTER_DONE_OFFSET, 0x08
.set SLAVE_DONE_OFFSET, 0x0C
.set POLYGON_COUNT_OFFSET, 0x10
.set SLAVE_START_OFFSET, 0x14
.set SLAVE_END_OFFSET, 0x18
.set CONTEXT_PTR_OFFSET, 0x20
.set DISPLAY_LIST_OFFSET, 0x24
.set FRAME_BUFFER_OFFSET, 0x28
.set SLAVE_FRAME_COUNTER, 0x40

.set READY_MAGIC, 0x52454459
.set WORK_MAGIC, 0x574F524B
.set DONE_MAGIC, 0x444F4E45

.globl slave_main_loop
.globl slave_process_polygons
.globl parse_polygon_bounds
.globl slave_func_023
.globl slave_func_029
.globl slave_func_032
.globl slave_func_033
.globl slave_func_034

.align 2

# ============================================================================
# PHASE 1: Slave Main Loop & Work Dispatcher
# ============================================================================

slave_main_loop:
    mov.l sync_base_addr, r14
    mov.l ready_magic, r0
    mov.l r0, @(SLAVE_READY_OFFSET, r14)

.wait_for_work:
    mov.l @(MASTER_READY_OFFSET, r14), r0
    mov.l work_magic, r1
    cmp/eq r1, r0
    bt .work_available
    bra .wait_for_work
    nop

.work_available:
    mov.l @(SLAVE_START_OFFSET, r14), r10
    mov.l @(SLAVE_END_OFFSET, r14), r11
    mov.l @(CONTEXT_PTR_OFFSET, r14), r12
    mov.l @(DISPLAY_LIST_OFFSET, r14), r13
    mov.l @(FRAME_BUFFER_OFFSET, r14), r9

    bsr parse_polygon_bounds
    nop

    bsr slave_process_polygons
    nop

    mov.l done_magic, r0
    mov.l r0, @(SLAVE_DONE_OFFSET, r14)

    mov.l @(SLAVE_FRAME_COUNTER, r14), r0
    add #1, r0
    mov.l r0, @(SLAVE_FRAME_COUNTER, r14)

    mov #0, r0
    mov.l r0, @(SLAVE_READY_OFFSET, r14)

    bra slave_main_loop
    nop

.align 2

slave_process_polygons:
    sts.l pr, @-r15

    mov #0, r8

.polygon_loop:
    cmp/gt r11, r10
    bt .polygons_done

    mov.l   func_023_addr, r1
    jsr     @r1
    nop

    add #1, r10
    add #1, r8
    bra .polygon_loop
    nop

.polygons_done:
    lds.l @r15+, pr
    rts
    nop

.align 4

sync_base_addr:
    .long SYNC_BASE

ready_magic:
    .long READY_MAGIC

work_magic:
    .long WORK_MAGIC

done_magic:
    .long DONE_MAGIC

.align 2

# ============================================================================
# PHASE 3.0: Polygon Bounds Parser
# ============================================================================

parse_polygon_bounds:
    mov.l   bounds_base_addr, r1
    mov.l   default_bounds_val, r0
    mov.l   poly_count_val, r2

.init_loop:
    mov.l   r0, @r1
    add     #4, r1

    dt      r2
    bf      .init_loop

    rts
    nop

.align 4

bounds_base_addr:
    .long   0x22001000

default_bounds_val:
    .long   0x01C00000

poly_count_val:
    .long   800

.align 2

# ============================================================================
# PHASE 3.1: Cohen-Sutherland Region Code Generator (func_029)
# ============================================================================

slave_func_029:
    mov     #0x00, r10
    mov     #0x00, r11

    cmp/ge  r1, r0
    bt      .skip_first_1

    mov     #0x04, r10

.skip_first_1:
    cmp/ge  r0, r2
    bt      .skip_first_2

    mov     #0x04, r11

.skip_first_2:
    cmp/ge  r1, r0
    bt      .skip_second_1

    mov     #0x08, r10

.skip_second_1:
    cmp/ge  r0, r2
    bt      .skip_second_2

    mov     #0x08, r11

.skip_second_2:
    cmp/ge  r1, r0
    bt      .skip_third_1

    mov     #0x0C, r10
    rts
    nop

.skip_third_1:
    cmp/ge  r0, r2
    bt      .third_return

    mov     #0x0C, r11

.third_return:
    rts
    nop

.align 2

# ============================================================================
# PHASE 3.2: Scanline Fill Loop (func_032)
# ============================================================================

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
# PHASE 3.3: Polygon Rendering (func_033) + Bresenham (func_034)
# ============================================================================

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
# Bresenham Line Rasterizer (func_034)
# ============================================================================

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

.align 2

# ============================================================================
# PHASE 3.4: Frustum Culler / Dispatcher (func_023)
# ============================================================================

slave_func_023:
    sts.l   pr, @-r15

    mov.l   @(ctx_ptr_023, PC), r14
    mov.l   @(buf_ptr_023, PC), r9

    mov.l   @(0x1C, r14), r3
    mov.l   @(0x20, r14), r4
    cmp/gt  r1, r3
    bt      .path_clipped_023

    cmp/gt  r4, r2
    bt      .path_clipped_023

.path_visible_outer_023:
    mov.l   func_029_addr, r1
    jsr     @r1
    nop

.path_inner_bounds_023:
    mov.l   @(0x14, r14), r3
    mov.l   @(0x18, r14), r4
    cmp/gt  r1, r3
    bt      .path_render_full_023

    cmp/gt  r4, r2
    bt      .path_render_full_023

    cmp/eq  r1, r2
    bt      .path_exit_023

.path_render_full_023:
    nop

.path_clipped_023:
    nop

.path_exit_023:
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

.align 4

func_023_addr:
    .long   0x022F6198

func_029_addr:
    .long   0x022F609C

