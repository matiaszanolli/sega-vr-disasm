# Sega 32X Technical Information Attachment 1

**Document Number:** MAR-42-072694

**CONFIDENTIAL - PROPERTY OF SEGA**

© 1994 SEGA. All Rights Reserved.

---

## Details of 32X Technical Information 6

### Problem Description

When using the 32X, and the RV bit of address `A15106H` is "1", the normal operation of the Mega Drive can be affected after reset is applied.

### Hardware Correction

To correct this, the hardware has been changed so that the 32X system is reset by the watch-dog-timer output when VRES interrupt occurs on the SH2 (Master) side, and the RV bit is checked and is "1".

### Software Requirements

With respect to each application, the determination must be made whether or not the SH2 resets the system by checking the RV bit in the process within the VRES interrupt.

On the MD side, the initial program operates if the system is reset, but because the MD side I/O isn't reset, the initial program moves onto application execution without executing the adapter usage procedure and determines whether or not the adapter usage procedure is performed; if the procedure hasn't been performed, it then must be performed.

Apart from the above procedure, it must be determined whether all processes at the start time are performed as a corrective measure when reset is applied repeatedly.

**Note:** With regard to applications that don't change the RV bit, the above operation is not required.

### Version Information

The above corrective measure will go into effect from the Ver. 2.1 (new board scheduled for release after Sept. 1994) development board. This problem cannot be avoided for development boards prior to Ver. 2.1 even if corrective action is taken by software.

---

## Corrective Program Sample - 68000 Side

```assembly
;******************************************************************************
; Vector / Mega Drive ID / Mars Intro Program
;******************************************************************************
.include source\megadrive.prg    ; Sega Mega Drive Header
.include source\cd_mars.prg       ; Mars Header
                                  ; Sega indicated Initial Program & Security

_errorO:
    bra     _errorO

_init:
    moveq   #0, d0
    moveq   #15, d0
    bra     VresStart               ; Reset with VRES Button?

VresStart:
    lea     marsreg, a5
    btst.b  #ADEN, adapter(a5)      ; has 32X gone into effect?
    bne     AdapterEnable

    ; SUPER 32X Usage Procedure
    move.l  #0, commO(a5)
    lea     ?10, a0
    lea     $800000, a1

?10:
    ; copy from ROM to WRAM
    move.l  (a0)+, (a1)+
    move.l  (a0)+, (a1)+
    move.l  (a0)+, (a1)+
    move.l  (a0)+, (a1)+
    move.l  (a0)+, (a1)+
    move.l  (a0)+, (a1)+
    move.l  (a0)+, (a1)+

    lea     $800000, a0
    jmp     (a0)                    ; jump work ram

RestartIcd:
    move.b  #1, adapter(a5)         ; SUPER 32X Mode
    lea     RestartIcd, a0
    adda.l  #marsipl, a0
    jmp     (a0)                    ; jump ROM (+$880000)

_hotstart:
    lea     $a10000, a5
    move.l  #-64, a4
    move.w  #$100, d7
    lea     marsipl+$6e4, a1
    jmp     (a1)                    ; operate cd_mars.prg

AdapterEnable:
    lea     marsreg, a5
    btst.b  #RES, adapter(a5)       ; SH2 reset canceled?
    bne     _hotstart               ; if not canceled reset once
    bra.b   RestartIcd              ; operate cd_mars.prg

; Main Program - cd_mars.prg

_mars:
?w:
    cmp.l   #'M_OK', commO(a5)      ; SH2 Master OK?
    bne.b   ?w

?w1:
    cmp.l   #'S_OK', comm4(a5)      ; SH2 Slave OK?
    bne.b   ?w1

    moveq   #0, d0
    move.l  d0, commO(a5)           ; SH2 Start - Master
    move.l  d0, comm4(a5)           ; SH2 Start - Slave
    move.l  #'INIT', initflug

?start:
    cmp.l   #'INIT', initflug       ; Has initial process ended?
    bne.b   _init

    move.l  $880000, a7
    bsr     SysInit                 ; Mega Drive Init
    move.w  #$2000, sr
    move.w  #$8164, reg_1(a6)       ; Display On
    move.w  #$8164, _vdpreg         ; V Interrupt Enable
```

---

## Corrective Program Sample - SH2 (Master) Side

```assembly
;******************************************************************************
; SH2 (Master) Vector
;******************************************************************************
.org    0

vector:
    .data.l start                   ; Power On Reset PC
    .data.l M_STACK                 ; Power On Reset SP
    .data.l start                   ; Manual Reset PC
    .data.l M_STACK                 ; Manual Reset SP
    .data.l errorO                  ; General invalid command
    .datab.l 1, h'00000000          ; System reserve
    .data.l errorO                  ; Slot invalid command
    .datab.l 1, h'00000000          ; System reserve (ICE Vector)
    .datab.l 1, h'20100400          ; System reserve (ICE Vector)
    .datab.l 1, h'20100420          ; System reserve (ICE Vector)
    .data.l errorO                  ; CPU address error
    .data.l errorO                  ; DMA address error
    .data.l errorO                  ; NMI
    .data.l errorO                  ; User Break
    .datab.l 19, h'00000000         ; System reserve
    .datab.l 32, errorO             ; Trap command (User vector)

;******************************************************************************
; Program Start
;******************************************************************************
start:
    ; Set Free Run Timer
    mov.l   #_sysreg, r14
    ldc     r14, gbr
    mov.l   #_FRT, r1
    mov     #h'00, r0
    mov.b   r0, @(_TIER, r1)
    mov     #h'e2, r0
    mov.b   r0, @(_TOCR, r1)
    mov     #h'00, r0
    mov.b   r0, @(_OCR_H, r1)
    mov     #h'01, r0
    mov.b   r0, @(_OCR_L, r1)
    mov     #0, r0
    mov.b   r0, @(_TCR, r1)
    mov     #1, r0
    mov.b   r0, @(_TCSR, r1)
    mov     #h'00, r0
    mov.b   r0, @(_FRC_H, r1)
    mov.b   r0, @(_FRC_L, r1)
    mov     #h'02, r0
    mov.b   r0, @(_TOCR, r1)
    mov     #h'00, r0
    mov.b   r0, @(_OCR_H, r1)
    mov     #h'01, r0
    mov.b   r0, @(_OCR_L, r1)
    mov     #h'e2, r0
    mov.b   r0, @(_TOCR, r1)

wait_md:
    ; Combine Mega Drive timing
    mov.l   @(commO, gbr), r0
    cmp/eq  #0, r0
    bf      wait_md
    mov.l   #'SLAV', r1

wait_slave:
    ; Combine SH2 Slave timing
    mov.l   @(comm8, gbr), r0
    cmp/eq  r1, r0
    bf      wait_slave

    mov.l   #_SERIAL, r1
    mov     #b'10000000, r0
    mov.b   r0, @r1                 ; Serial Mode Register
    mov     #74, r0
    mov.b   r0, @(1, r1)            ; Bit Rate Register
    mov     #b'00000000, r0
    mov.b   r0, @(2, r1)            ; Serial Control Register
    mov.l   #4*74, r0

w_serial:
    nop
    dt      r0
    bf      w_serial

    mov     #b'00100000, r0
    mov.b   r0, @(2, r1)            ; Serial Control Register (start)
    mov     #0, r0
    mov.b   r0, @(4, r1)
    mov     #h'20, r0
    ldc     r0, sr                  ; SH2 Interrupt Enable

;******************************************************************************
; Interrupt Control
;******************************************************************************
m_int:
    push    0, 1
    sts.l   pr, @-r15
    stc     sr, r0
    shlr2   r0
    and     #h'3c, r0
    mov.l   ?inttable, r1
    add     r1, r0
    mov.l   @r0, r1
    jsr     @r1
    nop
    lds.l   @r15+, pr
    pop     0, 1
    rte
    nop

.align  2

?inttable:
    .data.l inttable

inttable:
    .data.l noret               ; Illegal Interrupt
    .data.l noret               ; Level 1
    .data.l noret               ; Level 2
    .data.l noret               ; Level 3
    .data.l noret               ; Level 4
    .data.l noret               ; Level 5
    .data.l noret               ; Level 6
    .data.l pwmint              ; Level 7
    .data.l pwmint              ; Level 8
    .data.l cmdint              ; Level 9
    .data.l cmdint              ; Level 10
    .data.l hint                ; Level 11
    .data.l hint                ; Level 12
    .data.l vint                ; Level 13
    .data.l vint                ; Level 14
    .data.l vresint             ; Level 15
    .data.l vresint             ; Level 15

noret:
    rts
    nop

;******************************************************************************
; VRES Interrupt - CRITICAL CORRECTIVE ACTION
;******************************************************************************
vresint:
    mov.l   #_sysreg, r0
    ldc     r0, gbr

    mov.w   r0, @(vresintclr, gbr)  ; V Interrupt Clear

    ; VRES corrective action - Check RV bit
    mov.b   @(dreqctl, gbr), r0
    tst     #RV, r0
    bf      mars_reset              ; If RV=1, reset system

    ; Continue normal VRES handling
    mov.l   #M_STACK-8, r15         ; Stack change
    mov.l   #_hotstart, r0
    mov     r0, @r15                ; PC change
    mov.w   #h'f0, r0
    mov     r0, @(4, r15)           ; SR mask
    mov.l   #_DMAOPERATION, r1
    mov     #0, r0
    mov.l   r0, @r1                 ; DMA Off
    mov.l   #_DMACHANNELO, r1
    mov     #0, r0
    mov.l   r0, @r1
    mov.l   #b'0100010011100000, r1
    mov.l   r0, @r1                 ; Channel Control
    rte
    nop

mars_reset:
    ; System Reset - RV bit was set
    mov.l   #_FRT, r1
    mov.b   @(_TOCR, r1), r0
    or      #h'01, r0
    mov.b   r0, @(_TOCR, r1)

vresloop:
    bra     vresloop
    nop
```

---

## Corrective Program Sample - SH2 (Slave) Side

```assembly
;******************************************************************************
; Interrupt Control
;******************************************************************************
s_int:
    push    0, 1
    sts.l   pr, @-r15
    stc     sr, r0
    shlr2   r0
    and     #h'3c, r0
    mov.l   ?inttable, r1
    add     r1, r0
    mov.l   @r0, r1
    jsr     @r1
    nop
    lds.l   @r15+, pr
    pop     0, 1
    rte
    nop

.align  2

?inttable:
    .data.l inttable

inttable:
    .data.l noret               ; Illegal Interrupt
    .data.l noret               ; Level 1
    .data.l noret               ; Level 2
    .data.l noret               ; Level 3
    .data.l noret               ; Level 4
    .data.l noret               ; Level 5
    .data.l noret               ; Level 6
    .data.l pwmint              ; Level 7
    .data.l pwmint              ; Level 8
    .data.l cmdint              ; Level 9
    .data.l cmdint              ; Level 10
    .data.l hint                ; Level 11
    .data.l hint                ; Level 12
    .data.l vint                ; Level 13
    .data.l vint                ; Level 14
    .data.l vresint             ; Level 15
    .data.l vresint             ; Level 15

noret:
    rts
    nop

;******************************************************************************
; VRES Interrupt - CRITICAL CORRECTIVE ACTION
;******************************************************************************
vresint:
    mov.l   #_sysreg, r0
    ldc     r0, gbr

    mov.w   r0, @(vresintclr, gbr)  ; V Interrupt Clear

    ; VRES corrective action - Check RV bit
    mov.b   @(dreqctl, gbr), r0
    tst     #RV, r0
    bf      vresloop                ; If RV=1, loop (reset by Master)

    ; Continue normal VRES handling
    mov.l   #S_STACK-8, r15         ; Stack change
    mov.l   #_hotstart, r0
    mov     r0, @r15                ; PC change
    mov.w   #h'f0, r0
    mov     r0, @(4, r15)           ; SR mask
    mov.l   #_DMAOPERATION, r1
    mov     #0, r0
    mov.l   r0, @r1                 ; DMA Off
    mov.l   #_DMACHANNELO, r1
    mov     #0, r0
    mov.l   r0, @r1
    mov.l   #b'0100010011100000, r1
    mov.l   r0, @r1                 ; Channel Control
    rte
    nop

vresloop:
    ; Wait loop - Master will reset system
    bra     vresloop
    nop
```

---

## Implementation Summary

### Key Points

1. **Check RV bit in VRES interrupt handler** (both Master and Slave)
2. **Master SH2:** If RV=1, trigger system reset via watchdog timer
3. **Slave SH2:** If RV=1, enter infinite loop (Master will reset)
4. **68000 side:** Check if adapter initialization was performed, re-initialize if needed

### Critical Requirements

- This fix is **mandatory** for applications that use the RV bit
- Hardware fix only available in Ver. 2.1 and later development boards
- Software workaround **cannot** fix the issue on Ver. 2.0x boards
- Applications that never set RV=1 do not need this correction

### Testing Notes

- Test reset behavior with RV=1 set
- Verify proper re-initialization on both CPUs
- Ensure DMA operations are properly stopped before reset
- Check that 68000 adapter usage procedure is re-executed after reset

---

**Document End**
