# 32X Technical Information Attachment 1

**Document:** Details of 32X Technical Information 6
**Source:** SEGA of America, Inc.
**Classification:** CONFIDENTIAL - PROPERTY OF SEGA

---

## VRES and RV Bit Corrective Action

### The Problem

When using the 32X, and the RV bit of A15106H address is "1", the normal operation of the Mega Drive can be affected after reset is applied. To correct this, the hardware has been changed so that the 32X system is reset by the watch-dog-timer output when VRES interrupt occurs on the SH2 (Master) side, and the RV bit is checked and is "1".

### Determining Reset Type

With respect to each application, the determination must be made whether or not the SH2 resets the system by checking the RV bit in the process within the VRES interrupt:

- On the MD side, the initial program operates if the system is reset
- But because the MD side I/O isn't reset, the initial program moves onto application execution without executing the adapter usage procedure
- The program determines whether or not the adapter usage procedure is performed; if the procedure hasn't been performed, it then must be performed

### Process Start Time Determination

Apart from the above procedure, it must be determined whether all processes at the start time are performed as a corrective measure when reset is applied repeatedly. With regard to applications that don't change the RV bit, the above operation is not required.

### Version Applicability

The above corrective measure will go into effect from the Ver. 2.1 (new board scheduled for release after Sept. 1994) development board. This problem cannot be avoided for development boards prior to Ver. 2.1 even if corrective action is taken by software.

---

## 68000 Side Corrective Program Sample

```asm
;*--------------------------------------------------------------*
;       Vector / Mega Drive ID / Mars Initial Program
        .include        source\header.prg       ; Mega Drive & Mars Header
        .include        source\cd_mars.prg      ; Sega indicated Initial Program & Security
;*--------------------------------------------------------------*

        bcs             _error0                 ; if cs = 1 then ID error
                                                ; or Self check error

        move.l          #0, initflug            ; clear initial flag
        btst            #15, d0
        bne.b           VresStart               ; Reset with VRES Button?

        bra             _init

;*--------------------------------------------------------------*
;       VRES Start - Check if 32X has gone into effect
;*--------------------------------------------------------------*
VresStart:
        lea             marsreg, a5
        btst.b          #ADEN, adapter(a5)
        bne             AdapterEnable           ; has 32X gone into effect?

;*--------------------------------------------------------------*
;       SUPER 32X Usage Procedure
;*--------------------------------------------------------------*
        move.l          #0, comm8(a5)

        lea             ?10, a0                 ; copy from ROM to WRAM
        lea             $ff0000, a1

        move.l          (a0)+, (a1)+
        move.l          (a0)+, (a1)+
        move.l          (a0)+, (a1)+
        move.l          (a0)+, (a1)+
        move.l          (a0)+, (a1)+
        move.l          (a0)+, (a1)+
        move.l          (a0)+, (a1)+
        move.l          (a0)+, (a1)+

        lea             $ff0000, a0
        jmp             (a0)                    ; jump workram

?10:
        move.b          #1, adapter(a5)         ; SUPER 32X Mode
                                                ; SH2 reset - wait 10ms -
        lea             Restartlcd, a0
        adda.l          #marsipl, a0
        jmp             (a0)                    ; jump ROM (+$880000)

Restartlcd:
        lea             $a10000, a5
        move.l          #-64, a4
        move.w          #$3900, d7              ; 8
        lea             marsipl+$6e4, a1
        jmp             (a1)                    ; jump icd_mars.prg ?res_wait

;*--------------------------------------------------------------*
;       Adapter Enable - SH2 reset canceled check
;*--------------------------------------------------------------*
AdapterEnable:
        lea             marsreg, a5
        btst.b          #RES, adapter(a5)
        bne             _hotstart               ; SH2 reset canceled?
        bra.b           Restartlcd              ; If not canceled reset once again
                                                ; operate icd_mars.prg

;*--------------------------------------------------------------*
;       Main Program
;*--------------------------------------------------------------*

_init:
        lea             marsreg, a5

?w:
        cmp.l           #'M_OK', comm0(a5)      ; SH2 Master OK ?
        bne.b           ?w

?w1:
        cmp.l           #'S_OK', comm4(a5)      ; SH2 Slave OK ?
        bne.b           ?w1

        moveq           #0, d0                  ; SH2 Start
        move.l          d0, comm0(a5)           ; Master
        move.l          d0, comm4(a5)           ; Slave
        move.l          #'INIT', initflug

_hotstart:
        cmp.l           #'INIT', initflug       ; Has initial process ended ?
        bne.b           _init
        move.l          $880000, a7
        bsr             SysInit                 ; Mega Drive Init

?start:
        move.w          #$2000, sr
        move.w          #$8164, reg_1(a6)       ; Display On
        move.w          #$8164, _vdpreg         ; V Interrupt Enable

        ; ... (main program continues) ...
```

---

## SH2 (Master) Side Corrective Program Sample

### SH2 (Master) Vector Table

```asm
;*--------------------------------------------------------------*
;       SH2 (Master) Vector
;*--------------------------------------------------------------*

vector:
        .data.l         start                   ; Power On Reset PC
_stack:
        .data.l         M_STACK,                ; Power On Reset SP
+                       start,                  ; Manual Reset PC
+                       M_STACK                 ; Manual Reset SP

        .data.l         error0,                 ; General invalid command
+                       h'00000000,             ; System reserve
+                       error0,                 ; Slot invalid command
+                       h'20100400,             ; System reserve (ICE Vector)
+                       h'20100420,             ; System reserve (ICE Vector)
+                       error0,                 ; CPU address error
+                       error0,                 ; DMA address error
+                       error0,                 ; NMI
+                       error0                  ; User break

        .datab.l        19, h'00000000          ; System reserve
        .datab.l        32, error0              ; Trap command (User vector)

        .data.l         m_int,                  ; Interrupt 1
+                       m_int,                  ; Interrupt 2, 3
+                       m_int,                  ; Interrupt 4, 5
+                       m_int,                  ; Interrupt 6, 7
+                       m_int,                  ; Interrupt 8, 9
+                       m_int,                  ; Interrupt 10, 11
+                       m_int,                  ; Interrupt 12, 13
+                       m_int                   ; Interrupt 14, 15
```

### Program Start (Master)

```asm
;*--------------------------------------------------------------*
;       Program Start
;*--------------------------------------------------------------*

start:
        mov.l           #_sysreg, r14
        ldc             r14, gbr

        mov.l           #_FRT, r1               ; Set Free Run Timer
        mov             #h'00, r0
        mov.b           r0, @(_TIER, r1)        ; for Correcting Interrupt
        mov             #h'e2, r0
        mov.b           r0, @(_TOCR, r1)        ;
        mov             #h'00, r0
        mov.b           r0, @(_OCR_H, r1)       ;
        mov             #h'01, r0
        mov.b           r0, @(_OCR_L, r1)       ;
        mov             #0, r0
        mov.b           r0, @(_TCR, r1)         ;
        mov             #1, r0
        mov.b           r0, @(_TCSR, r1)        ;
        mov             #h'00, r0
        mov.b           r0, @(_FRC_L, r1)       ;
        mov.b           r0, @(_FRC_H, r1)       ;

        ; FRT TOCR configuration for VRES corrective action
        mov             #h'f2, r0               ; for Correcting VRES
        mov.b           r0, @(_TOCR, r1)        ;
        mov             #h'00, r0
        mov.b           r0, @(_OCR_H, r1)       ;
        mov             #h'01, r0
        mov.b           r0, @(_OCR_L, r1)       ;
        mov.b           r0, @(_TCR, r1)         ;
        mov             #h'e2, r0
        mov.b           r0, @(_TOCR, r1)        ;

wait_md:
        mov.l           @(comm0, gbr), r0       ; Combine Mega Drive
                                                ; and timing
        cmp/eq          #0, r0
        bf              wait_md

wait_slave:
        mov.l           #"SLAV", r1

        mov.l           @(comm8, gbr), r0       ; Combine SH2 Slave
                                                ; and timing
        cmp/eq          r1, r0
        bf              wait_slave

        ; Serial Mode configuration
        mov.l           #_SERIAL, r1
        mov             #b'10000000, r0
        mov.b           r0, @r1                 ; Serial Mode Register
        mov             #74, r0
        mov.b           r0, @(1, r1)            ; Bit Rate Register
        mov             #b'00000000, r0
        mov.b           r0, @(2, r1)            ; Serial Control Register
        mov.l           #4+74, r0

w_serial:
        nop
        dt              r0
        bf              w_serial
        mov             #b'00100000, r0
        mov.b           r0, @(2, r1)            ; Serial Control Register (start)
        mov             #0, r0
        mov.b           r0, @(4, r1)

_hotstart:
        mov             #h'20, r0
        ldc             r0, sr                  ; SH2 Interrupt Enable

        ; ... (main program continues) ...
```

### Master Interrupt Control

```asm
;*--------------------------------------------------------------*
;       Interrupt Control
;*--------------------------------------------------------------*

m_int:
        push            0, 1
        sts.l           pr, @-r15

        stc             sr, r0
        shlr2           r0
        and             #h'3c, r0
        mov.l           #inttable, r1

        add             r1, r0
        mov.l           @r0, r1
        jsr             @r1
        nop

        lds.l           @r15+, pr
        pop             0, 1
        rte
        nop

;*--------------------------------------------------------------*
;       Interrupt Jump Table (Master)
;*--------------------------------------------------------------*

        .align          4
inttable:
        .data.l         noret,                  ; Illegal Interrupt
+                       noret,                  ; Level 1
+                       noret,                  ; Level 2
+                       noret,                  ; Level 3
+                       noret,                  ; Level 4
+                       noret,                  ; Level 5
+                       pwmint,                 ; Level 6
+                       pwmint,                 ; Level 7
+                       cmdint,                 ; Level 8
+                       cmdint,                 ; Level 9
+                       hint,                   ; Level 10
+                       hint,                   ; Level 11
+                       vint,                   ; Level 12
+                       vint,                   ; Level 13
+                       vresint,                ; Level 14
+                       vresint                 ; Level 15

noret:
        rts
        nop
```

### VRES Interrupt Handler (Master)

```asm
;*--------------------------------------------------------------*
;       VRES Interrupt
;*--------------------------------------------------------------*

vresint:
        mov.l           #_sysreg, r0
        ldc             r0, gbr

        mov.w           r0, @(vresintclr, gbr)  ; V Interrupt Clear

        mov.b           @(dreqctl, gbr), r0     ; VRES corrective action
        tst             #RV, r0
        bf              mars_reset

        ; Normal VRES handling (RV=0)
        mov.l           #M_STACK-8, r15         ; Stack change
        mov.l           #_hotstart, r0
        mov             r0, @r15                ; PC change
        mov.w           #h'f0, r0
        mov             r0, @(4, r15)           ; SR mask

        mov.l           #_DMAOPERATION, r1
        mov             #0, r0
        mov.l           r0, @r1                 ; DMA Off

        mov.l           #_DMACHANNEL0, r1
        mov             #0, r0
        mov.l           r0, @r1

        mov.l           #b'0100010011100000, r1
        mov.l           r0, @r1                 ; Channel Control

        rte
        nop

;*--------------------------------------------------------------*
;       Mars Reset (RV=1) - System Reset via watchdog
;*--------------------------------------------------------------*
mars_reset:
        mov.l           #_FRT, r1               ; System Reset
        mov.b           @(_TOCR, r1), r0        ;
        or              #h'01, r0
        mov.b           r0, @(_TOCR, r1)        ;

vresloop:
        bra             vresloop                ; Wait for watchdog reset
```

---

## SH2 (Slave) Side Corrective Program Sample

### Slave Interrupt Control

```asm
;*--------------------------------------------------------------*
;       Interrupt Control
;*--------------------------------------------------------------*

s_int:
        push            0, 1
        sts.l           pr, @-r15

        stc             sr, r0
        shlr2           r0
        and             #h'3c, r0
        mov.l           #inttable, r1
        add             r1, r0
        mov.l           @r0, r1
        jsr             @r1
        nop

        lds.l           @r15+, pr
        pop             0, 1
        rte
        nop

        .align          4
```

### Slave Interrupt Jump Table

```asm
inttable:
        .data.l         noret,                  ; Illegal Interrupt
+                       noret,                  ; Level 1
+                       noret,                  ; Level 2
+                       noret,                  ; Level 3
+                       noret,                  ; Level 4
+                       noret,                  ; Level 5
+                       pwmint,                 ; Level 6
+                       pwmint,                 ; Level 7
+                       cmdint,                 ; Level 8
+                       cmdint,                 ; Level 9
+                       hint,                   ; Level 10
+                       hint,                   ; Level 11
+                       vint,                   ; Level 12
+                       vint,                   ; Level 13
+                       vresint,                ; Level 14
+                       vresint                 ; Level 15

noret:
        rts
        nop
```

### VRES Interrupt Handler (Slave)

```asm
;*--------------------------------------------------------------*
;       VRES Interrupt
;*--------------------------------------------------------------*

vresint:
        mov.l           #_sysreg, r0
        ldc             r0, gbr

        mov.w           r0, @(vresintclr, gbr)  ; V Interrupt Clear

        mov.b           @(dreqctl, gbr), r0     ; VRES corrective action
        tst             #RV, r0
        bf              vresloop                ; If RV=1, wait for reset

        ; Normal VRES handling (RV=0)
        mov.l           #S_STACK-8, r15         ; Stack change
        mov.l           #_hotstart, r0
        mov             r0, @r15                ; PC change
        mov.w           #h'f0, r0
        mov             r0, @(4, r15)           ; SR mask

        mov.l           #_DMAOPERATION, r1
        mov             #0, r0
        mov.l           r0, @r1                 ; DMA Off

        mov.l           #_DMACHANNEL0, r1
        mov             #0, r0
        mov.l           r0, @r1
        mov.l           #b'0100010011100000, r1
        mov.l           r0, @r1                 ; Channel Control

        rte
        nop

vresloop:
        bra             vresloop                ; Wait for watchdog reset from Master
```

---

## Key Implementation Details

### FRT (Free Run Timer) Configuration for Interrupt Correction

The FRT must be initialized at startup for the interrupt correction to work:

```asm
; FRT Register Offsets from _FRT (h'fffffe10)
_TIER   .equ    h'00    ; Timer Interrupt Enable Register
_TCSR   .equ    h'01    ; Timer Control & Status Register
_FRC_H  .equ    h'02    ; Free Running Counter High
_FRC_L  .equ    h'03    ; Free Running Counter Low
_OCR_H  .equ    h'04    ; Output Compare Register High
_OCR_L  .equ    h'05    ; Output Compare Register Low
_TCR    .equ    h'06    ; Timer Control Register
_TOCR   .equ    h'07    ; Timer Output Compare Control Register

; Initial configuration
mov     #h'e2, r0       ; TOCR initial value
mov.b   r0, @(_TOCR, r1)
```

### Interrupt Level Mapping

| Level | Odd Handler | Even Handler | Interrupt Type |
|-------|-------------|--------------|----------------|
| 1     | noret       | -            | Unused         |
| 2-3   | noret       | noret        | Unused         |
| 4-5   | noret       | noret        | Unused         |
| 6-7   | pwmint      | pwmint       | PWM            |
| 8-9   | cmdint      | cmdint       | CMD (68K→SH2)  |
| 10-11 | hint        | hint         | H-Blank        |
| 12-13 | vint        | vint         | V-Blank        |
| 14-15 | vresint     | vresint      | VRES (Reset)   |

**Note:** Odd and even levels share the same handler to work around the SH2 interrupt bug where the wrong vector may be taken.

### VRES Handling Differences

| Condition | Master Action | Slave Action |
|-----------|---------------|--------------|
| RV = 0    | Normal restart via RTE | Normal restart via RTE |
| RV = 1    | Trigger watchdog reset (TOCR bit 0) | Wait in loop for Master's watchdog |

### Synchronization Sequence (Boot)

```
68000:
  1. Wait for "M_OK" in COMM0 (Master ready)
  2. Wait for "S_OK" in COMM4 (Slave ready)
  3. Clear COMM0 and COMM4 to signal start
  4. Set initflug = 'INIT'

Master SH2:
  1. Initialize FRT for interrupt correction
  2. Write "M_OK" to COMM0
  3. Wait for COMM0 = 0 (68K start signal)
  4. Wait for "SLAV" in COMM8 (Slave ready)
  5. Configure serial interface
  6. Enable interrupts (SR = h'20)

Slave SH2:
  1. Initialize FRT for interrupt correction
  2. Write "SLAV" to COMM8
  3. Write "S_OK" to COMM4
  4. Wait for COMM4 = 0 (68K start signal)
  5. Enable interrupts (SR = h'20)
```

---

## Cross-Reference

- **Main Technical Info:** [32x-technical-info.md](32x-technical-info.md) (Item 6)
- **Interrupt Bug Details:** [32x-hardware-manual-supplement-2.md](32x-hardware-manual-supplement-2.md)
- **Hardware Manual:** [32x-hardware-manual.md](32x-hardware-manual.md)
