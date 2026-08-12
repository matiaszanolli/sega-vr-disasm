/*
 * Q-026 validation-only bounded player-physics handler.
 *
 * Fixed placement: file $301500 / SH2 $02301500.
 * This deliberately contains only the existing player pre-position saves and
 * player physics/timer/position sequence.  It performs no COMM, framebuffer,
 * Slave, AI, collision, bridge, sound-relay, or authority work.
 */

.section .text
.align 2
.global q026_player_shadow
q026_player_shadow:
    sts.l   pr,@-r15

    mov.l   @(.L_sentinel,pc),r4
    mov.l   @(.L_entry_magic,pc),r0
    mov.l   r0,@(4,r4)
    mov.l   @(4,r4),r0

    mov.l   @(.L_entity,pc),r0
    ldc     r0,gbr
    mov     r0,r14
    mov.l   @(.L_globals,pc),r13

    mov.w   @(0x30,gbr),r0
    mov.w   r0,@(0xec,gbr)
    mov.w   @(0x34,gbr),r0
    mov.w   r0,@(0xee,gbr)

.macro q026_call target
    mov.l   @(\target,pc),r0
    jsr     @r0
    nop
.endm

    q026_call .L_f1
    q026_call .L_et
    q026_call .L_te
    q026_call .L_fg
    q026_call .L_td
    q026_call .L_f2
    q026_call .L_f3
    q026_call .L_f5
    q026_call .L_f6
    q026_call .L_f7
    q026_call .L_f8
    q026_call .L_f9
    q026_call .L_ac
    q026_call .L_f12

    mov.l   @(.L_sentinel,pc),r4
    mov.l   @(.L_done_magic,pc),r0
    mov.l   r0,@(8,r4)
    mov.l   @(8,r4),r0
    lds.l   @r15+,pr
    rts
    nop

.align 2
.L_sentinel:  .long   0x2600fc00
.L_entry_magic: .long 0x51323645       /* "Q26E" */
.L_done_magic:  .long 0x51323643       /* "Q26C" */
.L_entity:    .long   0x2600f20c
.L_globals:   .long   0x2600f30c
.L_f1:        .long   0x023017c0
.L_f2:        .long   0x02301820
.L_f3:        .long   0x0230189c
.L_f5:        .long   0x023017f2
.L_f6:        .long   0x02301b40
.L_f7:        .long   0x02301cbc
.L_td:        .long   0x02301d40
.L_et:        .long   0x02301d94
.L_te:        .long   0x02301e00
.L_fg:        .long   0x02301e20
.L_ac:        .long   0x02301e2e
.L_f12:       .long   0x02301e60
.L_f8:        .long   0x02301f20
.L_f9:        .long   0x02302158

.global q026_player_shadow_end
q026_player_shadow_end:
