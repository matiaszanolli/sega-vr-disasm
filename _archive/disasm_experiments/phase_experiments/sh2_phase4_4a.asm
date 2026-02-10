.global init_h_int
init_h_int:
    sts.l   pr, @-r15
    mov.l   ptr_gbr, r0
    ldc     r0, gbr
    mov.l   ptr_vdp_flag, r1
    mov     #0, r0
    mov.b   r0, @r1
    mov.l   ptr_h_count, r2
    mov     #8, r1
    mov.l   r1, @r2
    mov.l   ptr_h_enable, r2
    mov.b   @r2, r1
    mov     #0x80, r3
    or      r3, r1
    mov.b   r1, @r2
    lds.l   @r15+, pr
    rts
    nop

.align 2
ptr_gbr:        .long 0x22000500
ptr_vdp_flag:   .long 0x22000560
ptr_h_count:    .long 0x20004004
ptr_h_enable:   .long 0x20004000

.global h_int_handler
h_int_handler:
    mov.l   ptr_vdp_status, r0
    mov.b   @r0, r0
    mov.b   r0, @(0x60, gbr)
    mov.l   ptr_h_clear, r0
    mov     #0, r1
    mov.l   r1, @r0
    rte
    nop

.align 2
ptr_vdp_status: .long 0x24000008
ptr_h_clear:    .long 0x20004018

.global func_047_optimized
func_047_optimized:
wait_047:
    mov.l   @(0x60, gbr), r0
    cmp/eq  #0xFF, r0
    bf      wait_047
    rts
    nop

.global func_048_optimized
func_048_optimized:
wait_048:
    mov.l   @(0x60, gbr), r0
    cmp/eq  #0xFF, r0
    bf/s    wait_048
    mov     #0x01, r0
    rts
    nop
