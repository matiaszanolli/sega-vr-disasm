! Phase 11: Slave SH2 Hook Implementation (v2 - Phase 16 support)
!
! This hook triggers on ANY non-zero COMM6, calls handler which decides action
! Handler entry: 0x02300028 (even-aligned)
!
! Assembled with: sh-elf-as --isa=sh2 -o phase11_hook.o phase11_hook_v2.asm
!

        .section .text
        .align 2

slave_expansion_hook:
        ! Read COMM6 to check for any Master signal
        mov.l   comm6_lit, r0   ! Load COMM6 address
        mov.l   @r0, r1         ! Read COMM6 value into R1

        ! Check if COMM6 is zero (no signal)
        tst     r1, r1          ! Set T if R1 == 0
        bt      hook_exit       ! Branch if T=1 (COMM6 is zero)

        ! Non-zero signal detected - call handler
        mov.l   handler_lit, r0 ! Load handler address
        jsr     @r0             ! Call handler
        nop                     ! Delay slot

        ! Clear COMM6 to prevent re-triggering
        mov.l   comm6_lit2, r0  ! Load COMM6 address
        mov     #0, r1          ! R1 = 0
        mov.l   r1, @r0         ! Clear COMM6

hook_exit:
        rts                     ! Return from hook
        nop                     ! Delay slot

! Literal pool (4-byte aligned)
        .align 2
comm6_lit:
        .long   0x2000402C      ! COMM6 address
handler_lit:
        .long   0x02300028      ! Handler address
comm6_lit2:
        .long   0x2000402C      ! COMM6 address (duplicate)
