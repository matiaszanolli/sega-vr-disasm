/* ============================================================================
 * SH2 Slave Engine - ROM Expansion Area
 * Virtua Racing Deluxe - Slave CPU Parallelization
 * ============================================================================
 *
 * Target location: ROM 0x300000 = SH2 CPU 0x02300000
 * This code is assembled as position-independent and injected at 0x300000
 * ============================================================================ */

.section .text

/* Constants */
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

/* Magic values */
.set READY_MAGIC, 0x52454459
.set WORK_MAGIC, 0x574F524B
.set DONE_MAGIC, 0x444F4E45

/* Hardware addresses */
.set RENDERING_CONTEXT, 0xC0000700
.set RENDER_BUFFER, 0xC0000740

.globl slave_main_loop

.align 2

/* ============================================================================
 * SLAVE MAIN LOOP (Entry Point @ 0x300000)
 * ============================================================================ */

slave_main_loop:
    mov.l   sync_base_lit, r14
    mov.l   ready_magic_lit, r0
    mov.l   r0, @(SLAVE_READY_OFFSET, r14)

wait_for_work:
    mov.l   @(MASTER_READY_OFFSET, r14), r0
    mov.l   work_magic_lit, r1
    cmp/eq  r1, r0
    bt      work_available
    bra     wait_for_work
    nop

work_available:
    mov.l   @(SLAVE_START_OFFSET, r14), r10
    mov.l   @(SLAVE_END_OFFSET, r14), r11
    mov.l   @(CONTEXT_PTR_OFFSET, r14), r12
    mov.l   @(DISPLAY_LIST_OFFSET, r14), r13
    mov.l   @(FRAME_BUFFER_OFFSET, r14), r9
    bsr     slave_process_polygons
    nop
    mov.l   done_magic_lit, r0
    mov.l   r0, @(SLAVE_DONE_OFFSET, r14)
    mov.l   @(SLAVE_FRAME_COUNTER, r14), r0
    add     #1, r0
    mov.l   r0, @(SLAVE_FRAME_COUNTER, r14)
    mov     #0, r0
    mov.l   r0, @(SLAVE_READY_OFFSET, r14)
    bra     slave_main_loop
    nop

/* Polygon processor */
slave_process_polygons:
    sts.l   pr, @-r15
    mov     #0, r8

polygon_loop:
    cmp/gt  r11, r10
    bt      polygons_done
    bsr     slave_func_023
    nop
    add     #1, r10
    add     #1, r8
    bra     polygon_loop
    nop

polygons_done:
    lds.l   @r15+, pr
    rts
    nop

.align 4

sync_base_lit:
    .long   SYNC_BASE

ready_magic_lit:
    .long   READY_MAGIC

work_magic_lit:
    .long   WORK_MAGIC

done_magic_lit:
    .long   DONE_MAGIC

/* ============================================================================
 * SLAVE FUNC_023: Frustum Culler / Rendering Dispatcher
 * ============================================================================ */

.align 2

slave_func_023:
    sts.l   pr, @-r15
    mov.l   ctx_ptr_lit, r14
    mov.l   buf_ptr_lit, r9
    mov.l   @(0x1C, r14), r3
    mov.l   @(0x20, r14), r4
    cmp/gt  r1, r3
    bt      path_clipped
    cmp/gt  r4, r2
    bt      path_clipped
    bsr     slave_func_029
    nop

path_inner_bounds:
    mov.l   @(0x14, r14), r3
    mov.l   @(0x18, r14), r4
    cmp/gt  r1, r3
    bt      path_render_full
    cmp/gt  r4, r2
    bt      path_render_full
    cmp/eq  r1, r2
    bt      path_exit

path_render_full:
    nop

path_clipped:
    nop

path_exit:
    lds.l   @r15+, pr
    rts
    nop

.align 4

ctx_ptr_lit:
    .long   RENDERING_CONTEXT

buf_ptr_lit:
    .long   RENDER_BUFFER

/* ============================================================================
 * SLAVE FUNC_029: Cohen-Sutherland Region Code Generator
 * ============================================================================ */

.align 2

slave_func_029:
    mov     #0x00, r10
    mov     #0x00, r11
    cmp/ge  r1, r0
    bt      skip_first_1
    mov     #0x04, r10

skip_first_1:
    cmp/ge  r0, r2
    bt      skip_first_2
    mov     #0x04, r11

skip_first_2:
    cmp/ge  r1, r0
    bt      skip_second_1
    mov     #0x08, r10

skip_second_1:
    cmp/ge  r0, r2
    bt      skip_second_2
    mov     #0x08, r11

skip_second_2:
    cmp/ge  r1, r0
    bt      skip_third_1
    mov     #0x0C, r10
    rts
    nop

skip_third_1:
    cmp/ge  r0, r2
    bt      third_return
    mov     #0x0C, r11

third_return:
    rts
    nop

/* ============================================================================
 * SLAVE FUNC_032: Scanline Fill Loop
 * ============================================================================ */

.align 2

slave_func_032:
    mov     r10, r0

fill_loop:
    mov.l   r1, @r9
    cmp/eq  r11, r0
    bt/s    fill_done
    add     #4, r9
    add     r12, r0
    bra     fill_loop
    nop

fill_done:
    mov     #0xFF, r0
    rts
    mov.l   r0, @r9

/* ============================================================================
 * SLAVE FUNC_033: Polygon Renderer
 * ============================================================================ */

.align 2

slave_func_033:
    mov.l   r0, @r9
    mov.l   buf_ptr_lit_033, r8
    mov     r10, r0
    mov.l   @(0x14, r14), r3
    exts.w  r1, r4
    cmp/ge  r3, r4
    bt      path_033_a
    mov     r1, r2
    add     r12, r0
    nop
    exts.w  r1, r4
    cmp/ge  r3, r4
    bf      loop_033

path_033_a:
    mov.l   r1, @r9
    add     #4, r9
    mov.l   @(0x18, r14), r3
    add     r12, r0
    nop

loop_033:
    mov     r1, r2
    nop
    exts.w  r1, r4
    cmp/gt  r3, r4
    bt      path_033_b
    mov.l   r1, @r9
    add     #4, r9
    cmp/eq  r11, r0
    bt      exit_033
    bra     loop_033
    add     r12, r0

path_033_b:
    sts.l   pr, @-r15
    bsr     slave_func_034
    nop
    lds.l   @r15+, pr
    mov.l   r3, @r9
    add     #4, r9

exit_033:
    mov     #0xFF, r0
    rts
    mov.l   r0, @r9

.align 4

buf_ptr_lit_033:
    .long   RENDER_BUFFER

/* ============================================================================
 * SLAVE FUNC_034: Bresenham Line Rasterizer
 * ============================================================================ */

.align 2

slave_func_034:
    mov.l   r0, @r9
    exts.w  r1, r4
    exts.w  r2, r5
    cmp/ge  r4, r5
    bt      skip_swap_034
    mov     r1, r4
    mov     r2, r1
    mov     r4, r2

skip_swap_034:
    swap.w  r1, r4
    exts.w  r4, r4
    swap.w  r2, r5
    exts.w  r5, r5
    sub     r5, r4
    mov.l   slope_lit_034, r7
    exts.w  r1, r5
    exts.w  r2, r6
    sub     r6, r5
    cmp/gt  r5, r7
    bt      branch_034
    mov.l   table_lit_034, r7
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

branch_034:
    exts.w  r1, r5
    exts.w  r3, r7
    sub     r5, r7
    rts
    nop

.align 4

slope_lit_034:
    .long   0x00000106

table_lit_034:
    .long   0xC00048D0

/* End marker */
.align 4
slave_code_end:
    nop
