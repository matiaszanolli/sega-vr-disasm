# SH2 Slave Engine - Phase 1
# Virtua Racing Deluxe parallelization

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

.align 2

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

slave_func_023:
slave_func_029:
slave_func_032:
slave_func_033:
    rts
    nop

.align 4

bounds_base_addr:
    .long   0x22001000

default_bounds_val:
    .long   0x01C00000

poly_count_val:
    .long   800
